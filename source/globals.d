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
import std.stdio;
import std.string;
import std.typetuple;

import parser.identifier;
import parser.expressions;
import parser.statements;

import value;

import context;
import env;
import func;
import var;

import panic;

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

import stack;

import parser.identifier;

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
    string ret = "";
    string[] methods;

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
        foreach (string className; classMembers!(moduleName))
            ret ~= "setSystemFunctionSymbol(new " ~ className ~ "(\"" ~ moduleName.replace("art.","") ~ ":\"));";

    return ret;
}

string getSystemFuncsArray() {
    string[] methods = [];

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
        foreach (string className; classMembers!(moduleName))
            methods ~= "\"" ~ className.toLower.replace("__",":").replace("_","") ~ "\"";

    return "[\"?info\",\"?functions\",\"?symbols\",\"?write.to\",\"?clear\",\"?help\",\"?exit\"," ~ methods.join(",") ~ "]";
}

// Functions

class Globals : Context {
    Stack!(Context) contextStack;
    bool isRepl;
    bool trace;
    string[] memoize;
    Value[string] memoized;
    Statements parentBlock;
    int retCounter;
    Stack!(int) retStack;
    Stack!(Statements) blockStack;
    Expressions[Identifier] symboldefs;
    bool warningsOn;
    string[] activeNamespaces;
    Env env;

    this(string[] args) {
        super();

        mixin(registerSystemFuncs());

        contextStack = new Stack!(Context);
        retStack = new Stack!(int);
        blockStack = new Stack!(Statements);
        contextStack.push(this);

        Value[] ret = cast(Value[])([]);

        foreach (string arg; args) {
            ret ~= new Value(arg);  
        }

        setGlobalSymbol(ARGS, new Value(ret));

        isRepl = false;
        trace = false;

        retCounter = -1;

        warningsOn = false;

        activeNamespaces = [];
        addNamespaces(["array","collection","convert","core","date","dictionary","file","number","path","string","system"]);

        env = new Env();
    }

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

        activeNamespaces = newNamespaces.uniq.array;
    }

    Expressions getSymbolDef(string id) {
        foreach (Identifier iden, Expressions ex; symboldefs) {
            if (iden.pathContents[0].id==id) return ex;
        }
        return null;
    }
    /*
    Value getParentDictForSymbol(string s) {
        string[] parts = s.split(".");
        string mainObject = parts[0];
        Var main = varGet(mainObject);

        if (main is null) return null;

        Value mainValue = main.value;

        parts.popFront();

        while (parts.length>0) {
            string nextKey = parts[0];

            if (mainValue.type==dV) {
                if ((parts.length==1) && (mainValue.getValueFromDict(nextKey) !is null)) return mainValue;

                Value nextKeyValue = mainValue.getValueFromDict(nextKey);
                if (nextKeyValue !is null)
                    mainValue = nextKeyValue;
                else return null;
            }
            else if (mainValue.type==aV) {
                if ((parts.length==1) && (isNumeric(nextKey)) && to!int(nextKey)<(mainValue.content.a.length)) return mainValue;

                if (isNumeric(nextKey) && mainValue.content.a.length<to!int(nextKey)) 
                    mainValue = mainValue.content.a[to!int(nextKey)];
                else return null;
            }
            else return null;

            parts.popFront();
        }

        return null;
    }*/

    void setSystemFunctionSymbol(Func f) {
        setGlobalSymbol(f.name,new Value(f));
    }

    void setGlobalSymbol(string sym, Value v) {
        _setSymbol(sym,v);
    }

    void unsetGlobalSymbol(string sym) {
        _unsetSymbol(sym);
    }

    bool setSymbol(Identifier i, Value v, bool redefine=false) {
        
        // it's a simple identifier
        if (i.isSimple) {

            if (redefine) {
                // if we redefine the symbol, just put it on the topmost context
                contextStack.lastItem()._setSymbol(i.simpleId,v);
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
                contextStack.lastItem()._setSymbol(i.simpleId,v);
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
/*
    void varSet(string n, Value v, bool immut = false, bool redefine = false) {
        if (redefine) {
            contextStack.lastItem()._varSet(n,v,immut);
        }
        else {
            Var existingVar = varGet(n);

            if (existingVar !is null) {
                existingVar.value = v;
            }
            else {
                contextStack.lastItem()._varSet(n,v,immut);
            }
        }
    } 

    bool varSetByIdentifier(Identifier iden, Value v, bool redefine = false) {
        Var existingVar = varGetByIdentifier(iden);
        bool varAlreadyExisting = existingVar !is null;

        if (iden.pathContents.length==1) { // no index
            string varName = iden.pathContents[0].id;

            if (redefine) {
                if (isUpper(varName[0])) _varSet(varName,v); // set global var
                else contextStack.lastItem()._varSet(varName,v);
            }
            else {
                if (varAlreadyExisting) {
                    existingVar.value = v;
                }
                else {
                    if (isUpper(varName[0])) _varSet(varName,v); // set global var
                    else contextStack.lastItem()._varSet(varName,v);
                }
            }
            return true;
        }
        else {
            Var rootVar = varGetByIdentifier(iden.getIdentifierRoot());

            if (rootVar is null) return false;
            else {
                Value rootValue = rootVar.value;

                PathContentType last_pct = iden.pathContentTypes[iden.pathContentTypes.length-1];
                PathContent last_pc = iden.pathContents[iden.pathContents.length-1];

                if (rootValue.type==dV) { // is dictionary
                    if (last_pct==numPC) return false;

                    string subKey; 
                    if (last_pct==idPC) { subKey = last_pc.id; }
                    else if (last_pct==exprPC) {
                        Value sub = last_pc.expr.evaluate();
                        if (sub.type!=sV) return false;

                        subKey = sub.content.s;
                    }

                    rootValue.setValueForDict(subKey, v);

                    return true;
                }
                else if (rootValue.type==aV) { // is array
                    long subKey;
                    if (last_pct==numPC) { subKey = last_pc.num; }
                    else if (last_pct==exprPC) {
                        Value sub = last_pc.expr.evaluate();
                        if (sub.type!=nV) return false;
                        subKey = sub.content.i;
                    }

                    if (subKey>=rootValue.content.a.length) return false;

                    rootValue.content.a[subKey] =  v;

                    return true;
                }
                else return false;
            }
        }
    }

    Var varGetByIdentifier(Identifier iden) {
        //try {

            //writeln("inspect: " ~ iden.inspect());
        Var ret = varGet(iden.pathContents[0].id);
        if (ret is null) return null;

        Value currentValue = ret.value;
        if (iden.pathContents.length==1) { return ret; }

        string varName = iden.pathContents[0].id;

        PathContentType[] types = iden.pathContentTypes[1..$];
        PathContent[] parts = iden.pathContents[1..$];

        for (auto i=0; i<parts.length; i++) {
            auto ppart = parts[i];
            auto ptype = types[i];

            if (currentValue.type==dV) {
                if (ptype==numPC) return null;

                string subKey; 
                if (ptype==idPC) subKey= ppart.id;
                else if (ptype==exprPC) {
                    Value sub = ppart.expr.evaluate();
                    if (sub.type!=sV) return null;
                    subKey = sub.content.s;
                }
                
                varName ~= "." ~ subKey;
                
                Value nextKeyValue = currentValue.getValueFromDict(subKey);

                if (nextKeyValue is null) return null;
                else currentValue = nextKeyValue;
            }
            else if (currentValue.type==aV) {
                if (ptype==idPC) return null;

                long subKey;

                if (ptype==numPC) { subKey = ppart.num; }
                else if (ptype==exprPC) {
                    Value sub = ppart.expr.evaluate();
                    if (sub.type!=nV) return null;
                    subKey = sub.content.i;
                }

                if (subKey>=currentValue.content.a.length) return null;

                varName ~= "." ~ to!string(subKey);

                currentValue =  currentValue.content.a[subKey];
                
            }
            else return null;
        }

        return new Var(varName,currentValue,true);
        //}
        //catch (Exception ex) {
        //    writeln("VARGET: EXCEPTION! ~ " ~ ex.msg);
        //    return null;
        //}
    }

    Var varGet(string n) {
        
        foreach_reverse (i, Context ctx; contextStack.list) {
            if (ctx._varExists(n)) return ctx._varGet(n);

        }
        return null;

        ////// OLD IMPLEMENTATION
        
        // if it's an ARGS variable, return it from top-most context
        if (n==ARGS && contextStack.lastItem()._varExists(ARGS)) return contextStack.lastItem()._varGet(ARGS);

        // if it's a global, return it now
        // ADDED: isUpper part
        if (this._varExists(n) && n[0].isUpper()) return this._varGet(n); 

        // else search back into the context stack
        // until reaching root (global), finding it, 
        // or crossing the first function-type block
        foreach_reverse (i, Context ctx; contextStack.list) {
            // if we reach global, that's it
            // REMOVED: if (ctx is this) return null;

            if (ctx._varExists(n)) return ctx._varGet(n);

             // if it is a function and still not found, don't go any further
            if (ctx.type==ContextType.functionContext && contextStack.list[i-1].type!=ContextType.dictionaryContext) {
                return null;
            } 
        }
        return null;
    }*/

    string inspectAllVars() {
        string[] ret;
        
        foreach (i, st; contextStack.list) {
            ret ~= "\n[" ~ to!string(i) ~ "]: " ~ st.type ~ " -> " ~ "\n" ~ st.inspectVars();
        }

        return ret.join(" | ");
    }

    void inspectSymbols() {
        contextStack.lastItem()._inspectSymbols(true,false);
    }

    void inspectFunctions() {
        contextStack.lastItem()._inspectSymbols(false,true);
    }

    void getFunctionsMarkdown() {
        /* 
        // core
        string[] coreNamespaces = activeNamespaces;
        Func[][string] coreFuncs;
        Func[][string] moreFuncs;
        foreach (Func f; functions) {
            if (coreNamespaces.canFind(f.namespace)) {
                coreFuncs[f.namespace] ~= f;
            }
            else {
                moreFuncs[f.namespace] ~= f;
            }
        }
        writeln("#### Main");
        writeln("The functions below are reserved keywords and can be used at any time, without the use of a namespace");
        writeln("|  Library  | Function | Description | Syntax |");
        writeln("| :---      | :---     | :---        | :---   |");
        foreach (string ns; coreNamespaces.sort()) {
            Func[] funcs = coreFuncs[ns].sort!((f1,f2) => f1.name<f2.name).array;

            foreach (Func f; funcs) {
                writeln(f.markdownishWithNamespace());
            }
        }
        string[] moreNamespaces;
        foreach (string ns, Func[] f; moreFuncs) {
            if (!moreNamespaces.canFind(ns)) moreNamespaces ~= ns;
        }

        writeln("#### More");
        writeln("The functions below have to be used with their namespace");
        writeln("|  Library  | Function | Description | Syntax |");
        writeln("| :---      | :---     | :---        | :---   |");
        foreach (string ns; moreNamespaces.sort()) {
            Func[] funcs = moreFuncs[ns].sort!((f1,f2) => f1.name<f2.name).array;

            foreach (Func f; funcs) {
                writeln(f.markdownishWithNamespace());
            }
        }

        string[] sblm;
        foreach(string ns, Func[] f; coreFuncs) {
            foreach (Func ff; f) {
                sblm ~= ff.sublimeishWithNamespace(true);
            }
        }
        foreach(string ns, Func[] f; moreFuncs) {
            foreach (Func ff; f) {
                sblm ~= ff.sublimeishWithNamespace(false);
            }
        }
        writeln(sblm.join(""));*/
    }

    void inspect() {
        Stack!(Context) copied = contextStack.copy();
        Context currentContext = copied.pop();
        int level = 0;
        while (currentContext !is null) {
            writeln("----------------------");
            writeln("context: " ~ to!string(level));
            writeln("----------------------");
            currentContext._inspect();
        
            currentContext = copied.pop();
            level += 1;
        }
    }
}
