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

import parser.identifier;
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
    dictionaryContext = "dictionary",
    functionContext = "function"
}

// Functions

class Context {
    Func[string] functions;
    Var[string] variables;
    ContextType type;
    Env env;

    Value[string] symbols;

    this(ContextType xctype=ContextType.blockContext) {
        env = new Env();
        type = xctype;
    }

    Value _getSym(string sym) {
        if (sym in symbols) return symbols[sym];
        else return null;
    }

    Value _setSym(string sym, Value v) {
        symbols[sym] = v;
    }

    Context dup() {
        Context ret = new Context(type);
        ret.functions = functions.dup;
        ret.variables = variables.dup;
        return ret;
    }

    string[] _varKeys() {
        return variables.keys;
    }

    Value[] _varValues() {
        Value[] ret;
        foreach (string k, Var v; variables) {
            ret ~= v.value;
        }
        return ret;
    }

    void  _varUnset(string n) {
        if (_varExists(n))  {
            variables.remove(n);
        }
    }

    void _varSet(Func f) {
        _varSet(f.name, new Value(f));
    }

    void _varSet(string n, Value v, bool immut = false) {
        variables[n] = new Var(n,v,immut);
    }

    Var _varGet(string n) {
        return variables[n];
    }

    bool _varExists(string n) {
        return ((n in variables)!=null);
    }

    const bool _varExistsImmut(string n) {
        return ((n in variables)!=null);
    }

    void funcSet(Func f) {
        functions[f.getFullName()] = f;
    }

    void funcSet(string n, Statements s = null) {
        Func f = new Func(n,s);
        funcSet(f);
    }
    /*
    Func funcGet(string n, string ns) {
        if (funcExists(n)) {
            if ((n in functions)!=null) { return functions[n]; }
            else {
                foreach (Func f; functions) {
                    if (f.name==n) { return  f; }
                }
            }
        }

        throw new ERR_FunctionNotFound(n);
    }*/

    Func funcGet(string n, string ns) {
        if (ns !is null) {
            foreach (Func f; functions) {
                if (f.name==n && f.namespace==ns) {
                    return f;
                }
            }
            return null;
        }
        else {
            foreach (Func f; functions) {
                if (Glob.activeNamespaces.canFind(f.namespace)) {
                    if (f.name==n) {
                        return f;
                    }
                }
            }
            return null;
        }
    }

    string inspectVars() {
        string[] ret;
        foreach (string name, Var v; variables) {
            ret ~= "\t" ~ name ~ ": (0x" ~ to!string(cast(void*)v) ~ "|0x" ~ to!string(cast(void*)v.value) ~ ") = " ~ v.value.stringify();
        }

        return ret.join("\n");
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
