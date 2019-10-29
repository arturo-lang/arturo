/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: program.d
 *****************************************************************/

module program;

// Imports

import core.memory;

import std.stdio;

import parser.statements;

import value;

// C Interface

extern (C) {
    void set_MainEntry(Program p, Statements s) { GC.addRoot(cast(void*)p); p.setStatements(s); }
}

// Functions

final class Program {

    Statements statements;

    this() {
        
    }

    void setStatements(Statements st) {
        statements = st;
    }

    Value execute() {
        return statements.execute(null);
    }

    void inspect() {
        statements.inspect();
    }

}