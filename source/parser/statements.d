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

import parser.statement;

import value;

import panic;

import globals;

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
		//Glob.retCounter += 1;
		//writeln("** Statements:execute (before) : retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());
		//writeln("** \tretCounter: incremented to " ~ to!string(Glob.retCounter));
		Value ret;
		foreach (size_t i, Statement s; lst) {
			try {
				//writeln("before executing statement: " ~ s.id);
				ret = s.execute(v);
				//writeln("after executing statement: " ~ s.id);

			}
			catch (Exception e) {

				//writeln("Caught exception (block level): " ~ e.msg);
				//writeln("Caught exception: " ~ e.msg);
				if (cast(ReturnResult)(e) !is null) {
					//writeln("** Statements:execute : got ReturnResult");
					//writeln("Glob.retCounter: " ~ to!string(Glob.retCounter));

					if (Glob.blockStack.lastItem() is this) {

						
					//}
					//if (Glob.retCounter==Glob.retStack.lastItem()) {
						//Glob.retCounter -= 1;
						//int popped = Glob.retStack.pop();
						Glob.blockStack.pop();
						Glob.contextStack.pop();
						writeln("Return:: popping context");
						writeln(Glob.inspectAllVars());
						//Glob.contextStack.pop();
						//writeln("** Statements:execute (reached parent) : retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());
						//writeln("** \tretCounter: decreased to " ~ to!string(Glob.retCounter));
						//writeln("** \tretStacked: popped " ~ to!string(popped));
						Value va = (cast(ReturnResult)(e)).val;
						//writeln("**\t This is the last item in the block stack - POPing block & returning value: " ~ va.stringify());
						return va;
					}
					else {
						//writeln("**\t rethrowing");
						//Glob.retCounter -= 1;
						//writeln("Statements:execute (rethrowing exception) : retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());
						//writeln("\tretCounter: decreased to " ~ to!string(Glob.retCounter));
						writeln("Return:: popping context (throw)"); 
					
						//Glob.contextStack.pop();
						//writeln(Glob.inspectAllVars());
						throw e;
					}
				} else {
				Panic.runtimeError(e.msg, s.pos);
					// rethrow
					//throw e;
				}
			}
		}
		//Glob.retCounter -= 1;
		//writeln("** Statements:execute (after) : retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());
		//writeln("** \tretCounter: decreased to " ~ to!string(Glob.retCounter));
		//writeln("about to return: " ~ ret.stringify());
		return ret;
	}

	void inspect() {
		foreach (size_t i, Statement s; lst) {
			s.inspect();
		}
	}

}