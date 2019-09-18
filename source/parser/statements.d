/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: parser/statement.d
 ************************************************/

module parser.statements;

// Imports

import core.memory;
import std.stdio;

import parser.statement;

import value;

import panic;

// C Interface

extern (C) {
	void* new_Statements() { return cast(void*)(new Statements()); }
	void add_Statement(Statements s, Statement st) { GC.addRoot(cast(void*)s); s.add(st); }
}

// Utilities

class ReturnResult : Exception {
	Value val;
	this(Value v) {
		super("ReturnResult");
		val = v;
	}
}

// Functions

class Statements {

	Statement[] lst;

	this() {
	}

	this(Statement st) {
		lst ~= st;
	}

	void add(Statement st) {
		lst ~= st;
	}

	Value execute(Value* v = null) {
		Value ret;
		foreach (size_t i, Statement s; lst) {
			try {
				ret = s.execute(null);
			}
			catch (Exception e) {
				//writeln("Caught exception: " ~ e.msg);
				//if (cast(ReturnResult)(e) !is null) {
				//	Value va = (cast(ReturnResult)(e)).val;
				//	return va;
				//} else {
				Panic.runtimeError(e.msg, s.pos);
					// rethrow
					//throw e;
				//}
			}
		}
		return ret;
	}

	void inspect() {
		foreach (size_t i, Statement s; lst) {
			s.inspect();
		}
	}

}