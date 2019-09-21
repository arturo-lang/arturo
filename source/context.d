/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: context.d
 *****************************************************************/

module context;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.stdio;
import std.string;
import std.typetuple;

import parser.statements;

import value;

import env;
import func;
import var;

import panic;

import globals;

// Definitions

enum ContextType : string
{
    blockContext = "block",
    functionContext = "function"
}

// Functions

class Context {
    Func[string] functions;
    Var[string] variables;
    ContextType type;
    Env env;

    this(bool isfunction=false) {
        env = new Env();
        if (isfunction) type = ContextType.functionContext;
        else type = ContextType.blockContext;
    }

    void _varSet(string n, Value v, bool immut = false) {
        variables[n] = new Var(n,v,immut);
    }

    Var _varGet(string n) {
        // check if path item
        if (n.indexOf(".")!=-1) {
            string[] parts = n.split(".");
            string mainObject = parts[0];
            Var main = Glob.varGet(mainObject);
            if (main is null) return null;
            Value mainValue = main.value;

            parts.popFront();

            while (parts.length>0) {
                string nextKey = parts[0];

                if (mainValue.type==dV) {
                    Value nextKeyValue = mainValue.getValueFromDict(nextKey);
                    if (nextKeyValue is null) return null;
                    else mainValue = nextKeyValue;
                }
                else if (mainValue.type==aV) {
                    if (isNumeric(nextKey) && to!int(nextKey)<mainValue.content.a.length)
                        mainValue = mainValue.content.a[to!int(nextKey)];
                    else return null;
                }

                parts.popFront();
            }

            return new Var(n,mainValue,true);
        }
        else return variables[n];
    }

    bool _varExists(string n) {
        // check if path item
        if (n.indexOf(".")!=-1) {
            string[] parts = n.split(".");
            string mainObject = parts[0];
            Var main = Glob.varGet(mainObject);
            if (main is null) return false;
            Value mainValue = main.value;

            parts.popFront();

            while (parts.length>0) {
                string nextKey = parts[0];

                if (mainValue.type==dV) {
                    Value nextKeyValue = mainValue.getValueFromDict(nextKey);
                    if (nextKeyValue is null) return false;
                    else mainValue = nextKeyValue;
                }
                else if (mainValue.type==aV) {
                    if (isNumeric(nextKey) && to!int(nextKey)<mainValue.content.a.length)
                        mainValue = mainValue.content.a[to!int(nextKey)];
                    else return false;
                }

                parts.popFront();
            }

            return true;
        }
        else return ((n in variables)!=null);
    }

    void funcSet(Func f) {
        functions[f.name] = f;
    }

    void funcSet(string n, Statements s = null) {
        functions[n] = new Func(n,s);
    }

    Func funcGet(string n) {
        if (funcExists(n)) return functions[n];
        else throw new ERR_FunctionNotFound(n);
    }

    bool funcExists(string n) {
        return ((n in functions)!=null);
    }

    string inspectVars() {
        string[] ret;
        foreach (string name, Var v; variables) {
            ret ~= name ~ ": " ~ v.value.stringify();
        }

        return ret.join(",");
    }

    void _inspect() {
        env.inspect();
        foreach (string name, Var v; variables) {
            v.inspect();
        }
        string[] s = [];
        foreach (string name, Func f; functions) {
            if (f.type==FuncType.systemFunc) s ~= name;

            f.inspect();
        }

        // For sublime-syntax (system functions scope)
        writeln(s.sort().join("|"));
    }
}
