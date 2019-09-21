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
import std.stdio;
import std.string;
import std.typetuple;

import parser.statements;

import value;

import env;
import func;
import var;

import panic;

// Functions

class Context {
    Func[string] functions;
    Var[string] variables;
    Env env;

    this() {
        env = new Env();
    }

    void _varSet(string n, Value v, bool immut = false) {
        variables[n] = new Var(n,v,immut);
    }

    Var _varGetVar(string n) {
        if (_varExists(n)) return variables[n];
        else throw new ERR_SymbolNotFound(n);
    }

    Value _varGet(string n) {
        if (_varExists(n)) return variables[n].value;
        else throw new ERR_SymbolNotFound(n);
    }

    bool _varExists(string n) {
        return ((n in variables)!=null);
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
