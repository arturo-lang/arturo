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

// Globals

Globals Glob;

// Constants

const string ARGS                                       = "@";
//const string THIS                                         = "this";

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
            ret ~= "funcSet(new " ~ className ~ "());";

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

    Value getSymbol(string s) {
        //writeln("searching for: " ~ s);
        if (varExists(s)) return varGet(s);
        else if (s.indexOf(".")!=-1) {
            string[] parts = s.split(".");
            string mainObject = parts[0];
            Value main;

            if (varExists(mainObject)) main = varGet(mainObject);
            else return null;

            parts.popFront();

            while (parts.length>0) {
                string nextKey = parts[0];

                //writeln("looking for: " ~ nextKey ~ " in: " ~ main.stringify());

                if (main.type==dV) {
                    Value nextKeyValue = main.getValueFromDict(nextKey);
                    if (nextKeyValue !is null)
                        main = nextKeyValue;
                    else return null;
                }
                else if (main.type==aV) {
                    if (isNumeric(nextKey) && main.content.a.length<to!int(nextKey)) 
                        main = main.content.a[to!int(nextKey)];
                    else return null;
                }
                else return null;

                parts.popFront();
            }

            return main;
        }
        else return null;
    }

    Value getSymbolParent(string s) {
        string[] parts = s.split(".");
        string mainObject = parts[0];
        Value main;

        if (varExists(mainObject)) main = varGet(mainObject);
        else return null;

        parts.popFront();

        while (parts.length>0) {
            string nextKey = parts[0];

            if (main.type==dV) {
                if ((parts.length==1) && (main.getValueFromDict(nextKey) !is null)) return main;

                Value nextKeyValue = main.getValueFromDict(nextKey);
                if (nextKeyValue !is null)
                    main = nextKeyValue;
                else return null;
            }
            else if (main.type==aV) {
                if ((parts.length==1) && (isNumeric(nextKey)) && (main.content.a.length<to!int(nextKey))) return main;

                if (isNumeric(nextKey) && main.content.a.length<to!int(nextKey)) 
                    main = main.content.a[to!int(nextKey)];
                else return null;
            }
            else return null;

            parts.popFront();
        }

        return null;
    }

    Context contextForSymbol(string n) {
        Stack!(Context) copied = contextStack.copy();
        Context currentContext = copied.pop();

        while (currentContext !is null) {
            if (currentContext._varExists(n)) {
                return currentContext;
            }

            currentContext = copied.pop();
            
        }

        return null;
    }

    void varSet(string n, Value v, bool immut = false, bool redefine = false) {
        Value gs = getSymbol(n);

        //writeln("attempting to set var: " ~ n);
        //contextStack.print();

        if (redefine || gs is null) 
        {
            contextStack.lastItem()._varSet(n,v,immut);
        }
        else {
            if (gs !is null) {
                return contextForSymbol(n)._varSet(n,v,immut);
            }
            else {
                contextStack.lastItem()._varSet(n,v,immut);
            }

        }
        //variables[n] = new Var(n,v);
    }

    Var varGetVar(string n) {
        if (varExists(n)) {
            Stack!(Context) copied = contextStack.copy();
            Context currentContext = copied.pop();

            while (currentContext !is null) {
                if (currentContext._varExists(n))
                {
                    //writeln("found. returning variable: " ~ n);
                    return currentContext._varGetVar(n);
                }

                currentContext = copied.pop();
                //if (currentContext is null) writeln("currentContext=null");
            }

            throw new ERR_SymbolNotFound(n);
        }
        else throw new ERR_SymbolNotFound(n);
    }

    Value varGet(string n) {
        if (varExists(n)) {
            Stack!(Context) copied = contextStack.copy();
            Context currentContext = copied.pop();

            while (currentContext !is null) {
                if (currentContext._varExists(n))
                {
                    //writeln("found. returning variable: " ~ n);
                    return currentContext._varGet(n);
                }

                currentContext = copied.pop();
                //if (currentContext is null) writeln("currentContext=null");
            }

            throw new ERR_SymbolNotFound(n);
        }
        else throw new ERR_SymbolNotFound(n);
    }

    bool varExists(string n) {
        Stack!(Context) copied = contextStack.copy();
        Context currentContext = copied.pop();

        while (currentContext !is null) {
            //writeln("searching " ~ n);
            //writeln("copied " ~ to!string(copied.size()));
            if (currentContext._varExists(n)) {
                //writeln("found");
                return true;
            }

            currentContext = copied.pop();
            //if (currentContext is null) writeln("currentContext=null");

        }
        return false;
        /*
        Context currentContext = contextStack.lastItem();
        if (currentContext._varExists(n)) 
            return true;
        return ((n in variables)!=null);*/
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
