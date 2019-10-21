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

//import containers.hashmap;

import parser.identifier;
import parser.statements;

import env;
import func;
import globals;
import panic;
import value;

// Definitions

enum ContextType : string
{
    blockContext = "block",
    dictionaryContext = "dictionary",
    functionContext = "function"
}

// Functions

class Context {
    //HashMap!(string, Value) symbols;
    Value[string] symbols;
    ContextType type;

    this(ContextType xctype=ContextType.blockContext) {
        type = xctype;
    }

    Context dup() {
        Context ret = new Context(type);
        /*
        writeln("DUP: context");
        foreach (string k,Value v; symbols) {
            ret.symbols[k] = v;
        }*/
        ret.symbols = symbols.dup;
        return ret;
    }

    Value _getSymbol(string sym) @safe {
        /*return symbols.get(sym,null);*/

        if (sym in symbols) {
            return symbols[sym];
        }
        else {
            return null;
        }
    }

    void _setSymbol(string sym, Value v) @safe nothrow {
        symbols[sym] = v;
    }

    void  _unsetSymbol(string sym) @safe nothrow {
        /*symbols.remove(sym);*/
        symbols.remove(sym);
    }

    void _rehash() nothrow {
        symbols.rehash();
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
