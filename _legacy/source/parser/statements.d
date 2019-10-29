/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/statement.d
 *****************************************************************/

module parser.statements;

// Imports

import core.memory;

import std.conv;
import std.stdio;

import containers.dynamicarray;

import parser.statement;

import compiler;
import globals;
import panic;
import value;

// C Interface

extern (C) {
	void* new_Statements() { return cast(void*)(new Statements()); }
	void add_Statement(Statements s, Statement st) { GC.addRoot(cast(void*)s); s.add(st); }
}

// Utilities

final class ReturnResult : Exception {
	Value val;
	this(Value v) {
		super("ReturnResult");
		val = v;
	}
}

// Functions

final class Statements {

	DynamicArray!Statement lst;

	this() {
		//lst = [];
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
				ret = s.execute(v);
				//if (this is sourceTree.statements) {
				//	destroy(s);
				//}
			}
			catch (Exception e) {

				if (cast(ReturnResult)(e) !is null) {
					if (sourceTree.statements is this) {
						//writeln("STATEMENTS is ROOT");
					}
					else {
						//writeln("Statements is some random block");
					}
					debug write("BLOCK::execute -> got Return: ");
					/*
					if (!Glob.blockStack.empty() && Glob.blockStack.back() is this) {
						debug writeln("It's last item - return it");

						//writeln("STATEMENTS::execute -> popping block from stack after executing");
						//Glob.blockStack.pop();
						Glob.blockStack.removeBack();
						//Glob.contextStack.pop();
						//writeln("Return:: popping context");
						//writeln(Glob.inspectAllVars());
						Value va = (cast(ReturnResult)(e)).val;
						return va;
					}
					else {

						//writeln("STATEMENTS::execute -> reTHROW");
						debug writeln("Not last item - reTHROW");
						//writeln("Return:: popping context (throw)"); 					
						throw e;
					}*/
				} 
				else {
					debug writeln("BLOCK::execute -> got Exception");
					Panic.runtimeError(e.msg, s.pos);
				}
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