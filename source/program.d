/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: program.d
 ************************************************/

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

class Program {

	Statements statements;

	this() {
		debug writeln("NEW program");
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