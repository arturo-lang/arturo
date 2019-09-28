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
import art.date;
import art.dictionary;
import art.file;
import art.html;
import art.json;
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

const string ARGS                                       = "@";
const string THIS                                       = "this";

// Utilities

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
        "art.date",
        "art.dictionary", 
        "art.file", 
        "art.html",
        "art.json", 
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
            ret ~= "funcSet(new " ~ className ~ "(\"" ~ moduleName.replace("art.","") ~ ":\"));";

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
        "art.date",
        "art.dictionary", 
        "art.file", 
        "art.html",
        "art.json", 
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
            methods ~= "\"" ~ className.toLower.replace("__",".").replace("_","") ~ "\"";

    return "[\"?info\",\"?functions\",\"?symbols\",\"?write.to\",\"?clear\",\"?help\",\"?exit\"," ~ methods.join(",") ~ "]";

    //return ret;
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

        varSet(ARGS, new Value(ret));

        isRepl = false;
        trace = false;

        retCounter = -1;
    }

    Expressions getSymbolDef(string id) {
        foreach (Identifier iden, Expressions ex; symboldefs) {
            if (iden.pathContents[0].id==id) return ex;
        }
        return null;
    }

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
    }

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
                contextStack.lastItem()._varSet(varName,v);
            }
            else {
                if (varAlreadyExisting) {
                    existingVar.value = v;
                }
                else {
                    contextStack.lastItem()._varSet(varName,v);
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
    }

    Var varGet(string n) {
        // if it's an ARGS variable, return it from top-most context
        if (n==ARGS && contextStack.lastItem()._varExists(ARGS)) return contextStack.lastItem()._varGet(ARGS);

        // if it's a global, return it now
        if (this._varExists(n)) return this._varGet(n); 

        // else search back into the context stack
        // until reaching root (global), finding it, 
        // or crossing the first function-type block
        foreach_reverse (i, Context ctx; contextStack.list) {
             // if we reach global, that's it
            if (ctx is this) return null;

            if (ctx._varExists(n)) return ctx._varGet(n);

             // if it is a function and still not found, don't go any further
            if (ctx.type==ContextType.functionContext && contextStack.list[i-1].type!=ContextType.dictionaryContext) {
                return null;
            } 
        }
        return null;
    }

    string inspectAllVars() {
        string[] ret;
        
        foreach (i, st; contextStack.list) {
            ret ~= "\n[" ~ to!string(i) ~ "]: " ~ st.type ~ " -> " ~ "\n" ~ st.inspectVars();
        }

        return ret.join(" | ");
    }

    void inspectSymbols() {
        auto sortedSymbols = contextStack.lastItem().variables.keys.sort();
        foreach (string symString; sortedSymbols) {
            Var v = contextStack.lastItem().variables[symString];
            v.inspect();
        }
    }

    void inspectFunctions() {
        auto sortedFunctions = contextStack.lastItem().functions.keys.sort();
        foreach (string funcString; sortedFunctions) {
            Func f = contextStack.lastItem().functions[funcString];
            //writeln(f.markdownish());
            //writeln(f.sublimeish());
            f.inspect();
        }
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
