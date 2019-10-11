/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/expressions.d
 *****************************************************************/

module parser.expressions;

// Imports

import core.memory;
import std.array;
import std.stdio;

import parser.argument;
import parser.expression;
import parser.identifier;

import value;

// C Interface

extern (C) {
	void* new_Expressions() { return cast(void*)(new Expressions()); }
	void add_Expression(Expressions e, Expression ex) { GC.addRoot(cast(void*)e); e.add(ex); }
}

// Functions

class Expressions {

	Expression[] lst;

	this() {
		lst = [];
	}

	void add(Expression ex) {
		lst ~= ex;
	}

	bool hasHashId() {
		if (lst.length>0) {
			Expression ex = lst[0];

			if (ex.type==ExpressionType.argumentExpression) {
				if (ex.arg.type==ArgumentType.identifierArgument) {
					if (ex.arg.identifier.isHash) return true;
				}
			}
		}
		return false;
	}

	Identifier extractHashId() {
		Expression hashEx = lst[0];

		lst.popFront();

		return hashEx.arg.identifier;
	}

	Value evaluate(bool forceArray=false) {
		if (forceArray || lst.length > 1) {
			Value[] res;

			foreach (Expression e; lst) res ~= e.evaluate();
		
			return new Value(res);
		} 
		else {
			if (lst.length==1) return lst[0].evaluate();
			else return Value.array();
		}
	}

}