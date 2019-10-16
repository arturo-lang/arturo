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
    Value[string] symbols;
    ContextType type;

    // Func[string] functions;
    // Var[string] variables;
    //Env env;

    this(ContextType xctype=ContextType.blockContext) {
        //env = new Env();
        type = xctype;
    }

    Context dup() {
        Context ret = new Context(type);
        ret.symbols = symbols.dup;
        return ret;
    }

    Value _getSymbol(string sym) {
        if (sym in symbols) return symbols[sym];
        else return null;
    }

    void _setSymbol(string sym, Value v) {
        symbols[sym] = v;
    }

    void  _unsetSymbol(string sym) {
        if (sym in symbols)  {
            symbols.remove(sym);
        }
    }

/*
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
    }*/
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
/*
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
    }*/

    string inspectVars() {
       /* 
        string[] ret;
        foreach (string nm, Value va; symbols) {
            ret ~= "\t" ~ nm ~ ": (0x" ~ to!string(cast(void*)va) ~ ") = " ~ va.stringify();
        }

        return ret.join("\n");*/
        return "TOFIX @ context.d";
    }

    void _inspect() {
        /*
        //env.inspect();
        foreach (string nm, Value va; symbols) {
            v.inspect();
        }
        string[] s = [];
        foreach (string name, Func f; functions) {
            if (f.type==FuncType.systemFunc) s ~= name;

            f.inspect();
        }

        // For sublime-syntax (system functions scope)
        writeln(s.sort().join("|"));*/
    }

    void _inspectSymbol(string nm, Value va, bool full=false){
        if (full) {
            writeln("  Symbol : \x1B[37m\x1B[1m" ~ nm ~ "\x1B[0m");
            writeln("       # | 0x" ~ to!string(&va));
        
            writeln();
        
            writeln("    type | " ~ va.type);
        
            writeln("      -> | " ~  va.stringify());
        }
        else {
            writeln("  " ~ leftJustify(nm,20) ~ " -> " ~ va.stringify());
        }
    }

    void _inspectSymbols(bool includeUserSymbols=true, bool includeSystemFunctions=false){
        auto sortedSymbols = symbols.keys.sort();
        foreach (string nm; sortedSymbols) {
            Value va = symbols[nm];

            if (va.type==fV) {
                if ((includeUserSymbols && va.content.f.type!=FuncType.systemFunc) ||
                    (includeSystemFunctions && va.content.f.type==FuncType.systemFunc))
                    
                    if (nm.indexOf(":")!=-1) 
                        va.content.f.inspect(nm);
            }
            else {
                if (includeUserSymbols)
                    _inspectSymbol(nm,va);
            }
            
        }
    }
}
