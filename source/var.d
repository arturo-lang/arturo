/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: var.d
 *****************************************************************/

module var;

// Imports

import std.conv;
import std.stdio;
import std.string;

import value;

import panic;

// Functions

class Var {

    string name;
    Value value;
    bool immut;

    this(string n, Value v, bool isImmutable = false) {
        name = n;
        value = v;
        immut = isImmutable;
    }

    void inspect(bool full=false) {
        if (full) {
            writeln("  Symbol : \x1B[37m\x1B[1m" ~ name ~ "\x1B[0m");
            writeln("       # | 0x" ~ to!string(&value));
            
            writeln();
            
            write("    type | " ~ value.type);

            if (immut) writeln(" (immutable)");
            else writeln();
            
            writeln("      -> | " ~  value.stringify());
        }
        else {
            write("  " ~ leftJustify(name,20) ~ " -> " ~ value.stringify());
            if (immut) writeln(" **");
            else writeln();
        }
    }
}