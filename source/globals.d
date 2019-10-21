/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: globals.d
 *****************************************************************/

module globals;

// Imports

import std.algorithm;
import std.array;
import std.ascii;
import std.conv;
import std.container;
import std.stdio;
import std.string;
import std.typetuple;

import parser.identifier;
import parser.expressions;
import parser.statements;

import art.array;
import art.collection;
import art.convert;
import art.core;
import art.crypto;
import art.csv;
import art.database;
import art.date;
import art.dictionary;
import art.file;
import art.gui;
import art.html;
import art.json;
import art.net;
import art.number;
import art.path;
import art.reflection;
import art.string;
import art.system;
import art.web;
import art.xml;
import art.yaml;

import context;
import env;
import func;
import panic;
import stack;
import value;

// Globals

Globals Glob;

// Constants

enum ARGS                                       = "&";
enum CHILDREN                                   = "_";
enum THIS                                       = "this";

// Mixins

template StaticFilter(alias Pred, T...) {
    static if (T.length == 0) alias TypeTuple!() StaticFilter;
    else static if (Pred!(T[0])) alias TypeTuple!(T[0], StaticFilter!(Pred, T[1 .. $])) StaticFilter;
    else alias StaticFilter!(Pred, T[1 .. $]) StaticFilter;
}

template isClass(string name) {
    mixin("static if (is(" ~ name ~ " == class)) enum bool isClass = true;
                  else enum bool isClass = false;");
}

template extractClasses(string moduleName, members...) {
    alias StaticFilter!(isClass,members) extractClasses;
}

template classMembers(string moduleName) {
    mixin("alias extractClasses!(moduleName, __traits(allMembers, " ~ moduleName ~ ")) classMembers;");
}

string registerSystemFuncs() {
    string[] ret = [];

    static foreach(string moduleName; [
        "art.array", 
        "art.collection", 
        "art.convert",
        "art.core", 
        "art.crypto",
        "art.csv",
        "art.database",
        "art.date",
        "art.dictionary", 
        "art.file", 
        "art.gui",
        "art.html",
        "art.json", 
        "art.net",
        "art.number",
        "art.path",
        "art.reflection", 
        "art.string", 
        "art.system",
        "art.web",
        "art.xml",
        "art.yaml"
        ]) 
            foreach (string className; classMembers!(moduleName)) {
                ret ~= "setSystemFunctionSymbol(new " ~ className ~ "(\"" ~ moduleName.replace("art.","") ~ ":\"));";
                
            }

    return ret.join("");
}

// Functions

class Globals : Context {

    Stack!(Context)     contextStack;
    Stack!(Statements)  blockStack;

    Env env;

    bool isRepl;
    bool trace;
    bool warningsOn;

    string[]                    memoize;
    Value[string]               memoized;
    Expressions[Identifier]     symboldefs;
    string[]                    activeNamespaces;

    //--------------------------------
    // Initialization
    //--------------------------------

    @disable this();

    this(string[] args) {
        super();

        // register system functions
        mixin(registerSystemFuncs());

        // set up stacks
        contextStack = new Stack!(Context);
        blockStack = new Stack!(Statements);
        contextStack.push(this);

        // set command line arguments
        setGlobalSymbol(ARGS, new Value(args));

        // initialize environment
        env = new Env();

        // set defaults
        isRepl = false;
        trace = false;
        warningsOn = false;

        // set namespaces
        activeNamespaces = [];
        addNamespaces(["array","collection","convert","core","date","dictionary","file","number","path","string","system"]);
    }

    //--------------------------------
    // Namespace management
    //--------------------------------

    void addNamespaces(string[] toAdd) {
        foreach (string namespace; toAdd) {
            activeNamespaces ~= namespace;
            foreach (string key; symbols.keys){
                if (key.indexOf(namespace~":")!=-1) {
                    auto parts = key.split(":");
                    setGlobalSymbol(parts[1], symbols[key]);
                }
            }
        }

        rehashGlobalSymbols();

        activeNamespaces = activeNamespaces.uniq.array;
    }

    void removeNamespaces(string[] toRemove) {
        string[] newNamespaces;

        foreach (string namespace; activeNamespaces) {
            if (!toRemove.canFind(namespace))
                newNamespaces ~= namespace;
        }

        foreach (string namespace; toRemove) {
            foreach (string key; symbols.keys){
                if (key.indexOf(namespace~":")!=-1) {
                    auto parts = key.split(":");
                    unsetGlobalSymbol(parts[1]);
                }
            }
        }

        rehashGlobalSymbols();

        activeNamespaces = newNamespaces.uniq.array;
    }

    //--------------------------------
    // Symbol definitions index
    //--------------------------------

    Expressions getSymbolDef(string id) {
        foreach (Identifier iden, Expressions ex; symboldefs) {
            if (iden.pathContents[0].id==id) return ex;
        }
        return null;
    }

    //--------------------------------
    // Symbols get/set
    //--------------------------------

    pragma(inline)
    void rehashGlobalSymbols() nothrow {
        _rehash();
    }

    pragma(inline)
    void setSystemFunctionSymbol(Func f) {
        setGlobalSymbol(f.name,new Value(f));
    }

    pragma(inline)
    void setGlobalSymbol(string sym, Value v) @safe nothrow {
        _setSymbol(sym,v);
    }

    pragma(inline)
    void unsetGlobalSymbol(string sym) @safe nothrow {
        _unsetSymbol(sym);
    }

    bool setSymbol(Identifier i, Value v, bool redefine=false) {
        
        // it's a simple identifier
        if (i.isSimple) {

            if (redefine) {
                // if we redefine the symbol, just put it on the topmost context
                contextStack.list.back()._setSymbol(i.simpleId,v);
                return true;
            }
            else {
                // first check if it exists
                foreach_reverse (j, Context ctx; contextStack.list) {
                    if (ctx._getSymbol(i.simpleId) !is null) {
                        // re-assign it
                        ctx._setSymbol(i.simpleId,v);
                        return true;
                    }
                }

                // symbol did not exist, put it on the topmost context
                contextStack.list.back()._setSymbol(i.simpleId,v);
                return true;
            }
        }
        // it's an indexed assignement
        else {
            Value root;

            /////// 
            // Process root
            ////////////////

            // Look up our root symbol down the stack
            foreach_reverse (j, Context ctx; contextStack.list) {
                if ((root = ctx._getSymbol(i.simpleId)) !is null) break;

            }
            // if not found, return false
            if (root is null) return false;

            /////// 
            // Process ultimate index
            ////////////////

            // get symbol root (except the last element)
            root = getSymbol(i.getIdentifierRoot());
            if (root is null) return false;

            // get the last index only
            PathContentType last_pct = i.pathContentTypes[i.pathContentTypes.length-1];
            PathContent last_pc = i.pathContents[i.pathContents.length-1];

            // handle dictionaries
            if (root.type==dV) {
                // we cannot have numerical indexes in a dictionary
                if (last_pct==numPC) return false;

                // get the subkey
                string subKey; 
                if (last_pct==idPC) { subKey = last_pc.id; }
                else if (last_pct==exprPC) {
                    Value sub = last_pc.expr.evaluate();
                    if (sub.type!=sV) return false;

                    subKey = sub.content.s;
                }

                // set it
                root.setSymbolForDict(subKey, v);

                return true;
            }
            // handle arrays
            else if (root.type==aV) {

                // get the subkey
                long subKey;
                if (last_pct==numPC) { subKey = last_pc.num; }
                else if (last_pct==exprPC) {
                    Value sub = last_pc.expr.evaluate();
                    if (sub.type!=nV) return false;
                    subKey = sub.content.i;
                }

                // if index not found, return false
                if (subKey>=root.content.a.length) return false;

                root.content.a[subKey] =  v;

                return true;
            }
            // handle strings
            else if (root.type==sV) {

                // get the subkey
                long subKey;
                if (last_pct==numPC) { subKey = last_pc.num; }
                else if (last_pct==exprPC) {
                    Value sub = last_pc.expr.evaluate();
                    if (sub.type!=nV) return false;
                    subKey = sub.content.i;
                }

                // if index not found, return false
                if (subKey>=root.content.s.length) return false;

                root.content.a[subKey] =  v;

                return true;
            }
            // nothing else accepted, return false
            else return false;
        }
    }

    Value getSymbol(Identifier i) {
        Value ret;

        /////// 
        // Process root
        ////////////////

        // Look up our root symbol down the stack
        foreach_reverse (j, Context ctx; contextStack.list) {
            if ((ret = ctx._getSymbol(i.simpleId)) !is null) break;

        }
        // if not found, return null
        if (ret is null) return null;

        // if it's a simple identifier, there's nothing more to do
        if (i.isSimple) return ret;

        /////// 
        // Process all indexes
        ////////////////

        // get index paths, excluding the first element
        PathContentType[] types = i.pathContentTypes[1..$];
        PathContent[] parts = i.pathContents[1..$];

        // loop through the parts
        for (auto j=0; j<parts.length; j++) {
            auto ppart = parts[j];
            auto ptype = types[j];

            // handle dictionaries
            if (ret.type==dV) {
                // we cannot have numerical indexes in a dictionary
                if (ptype==numPC) return null;

                // get the subkey
                string subKey; 
                if (ptype==idPC) subKey= ppart.id;
                else if (ptype==exprPC) {
                    Value sub = ppart.expr.evaluate();
                    if (sub.type!=sV) return null;
                    subKey = sub.content.s;
                }
                
                // if index not found, return null
                if ((ret = ret.getSymbolFromDict(subKey)) is null) return null;
            }
            // handle arrays
            else if (ret.type==aV) {
                // we cannot have string indexes in an array
                if (ptype==idPC) return null;

                // get the subkey
                long subKey;
                if (ptype==numPC) { subKey = ppart.num; }
                else if (ptype==exprPC) {
                    Value sub = ppart.expr.evaluate();
                    if (sub.type!=nV) return null;
                    subKey = sub.content.i;
                }

                // if index not found, return null
                if (subKey>=ret.content.a.length) return null;

                ret = ret.content.a[subKey];
                
            }
            // handle strings
            else if (ret.type==sV) {
                if (ptype==idPC) return null;

                long subKey;

                if (ptype==numPC) { subKey = ppart.num; }
                else if (ptype==exprPC) {
                    Value sub = ppart.expr.evaluate();
                    if (sub.type!=nV) return null;
                    subKey = sub.content.i;
                }

                // if index not found, return null
                if (subKey>=ret.content.s.length) return null;

                ret = new Value(to!string(ret.content.s[subKey]));
                
            }
            // nothing else to index, return null
            else return null;
        }

        return ret;
    }

    //--------------------------------
    // Helper methods
    //--------------------------------

    string[] getAutocompletionsForRepl() {
        return ["?info","?functions","?symbols","?read","?write","?clear","?help","?exit"] ~
                symbols.keys;
    }

    void printSystemFunctionsForDocumentation(bool markdown=true) {
        string[] ret;

        if (markdown) {
            writeln("|  Library  | Function | Description | Syntax |");
            writeln("| :---      | :---     | :---        | :---   |");
        }

        auto sortedSymbols = symbols.keys.sort();
        foreach (string nm; sortedSymbols) {
            Value va = symbols[nm];

            if (va.type==fV && va.content.f.type==FuncType.systemFunc) {
                if (markdown && nm.indexOf(":")!=-1) {
                    writeln("| " ~ nm.split(":")[0] ~ " | **" ~ nm.split(":")[1] ~ "** | " ~ va.content.f.description ~ " | [" ~ va.content.f.getAcceptedConstraintsDescription() ~ "] -> " ~ va.content.f.getReturnValuesDescription() ~ " |");
                }
                else {
                    if (nm.indexOf(":")!=-1) {
                        ret ~= nm.split(":")[0];
                        ret ~= nm.split(":")[1];
                        ret ~= nm;
                    }
                }
            }
        }

        if (!markdown) {
            writeln(ret.sort.uniq.array.join("|"));
        }
        
    }

    //--------------------------------
    // Inspection
    //--------------------------------

    void inspectAllContexts() {
        foreach (i, st; contextStack.list) {
            writeln("[" ~ to!string(i) ~ ": " ~ st.type ~ "]");
            st._inspectSymbols(true,false);
        }
    }

    void inspectSymbols() {
        contextStack.lastItem()._inspectSymbols(true,false);
    }

    void inspectFunctions() {
        contextStack.lastItem()._inspectSymbols(false,true);
    }

}
