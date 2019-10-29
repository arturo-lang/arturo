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

import containers.dynamicarray;

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

final class Expressions {

	DynamicArray!Expression lst;
	bool hasHashId;

	this() {
		hasHashId = false;
	}

	void add(Expression ex) {
		if (lst.empty()) {
			if (ex.type==ExpressionType.argumentExpression && 
				ex.content.arg.type==ArgumentType.identifierArgument &&
				ex.content.arg.content.i.isHash) {
				hasHashId = true;
			}
		}
		lst ~= ex;
	}

	Identifier extractHashId() {
		Expression hashEx = lst[0];

		lst.remove(0);

		return hashEx.content.arg.content.i;
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