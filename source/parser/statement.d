/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/statement.d
 *****************************************************************/

module parser.statement;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.stdio;
import std.string;

import parser.identifier;
import parser.argument;
import parser.expression;
import parser.expressions;
import parser.statement;
import parser.statements;
import parser.position;

import var;

import value;
import globals;

import panic;

import func;

import stack;

// C Interface

extern (C) {
	void* new_Statement(Identifier id) { return cast(void*)(new Statement(id)); }
	void* new_StatementFromExpression(Expression ex) { return cast(void*)(new Statement(ex)); }
	void* new_StatementWithExpressions(Identifier id, Expressions ex) { return cast(void*)(new Statement(id,ex)); }
	void* new_ImmutableStatementWithExpressions(Identifier id, Expressions ex) { return cast(void*)(new Statement(id,ex,true)); }
	void set_Position(Statement x, Position p) { x.pos = p; }
}

// Definitions

enum StatementType : string
{
	normalStatement = "normal",
	functionCallStatement = "function",
	expressionStatement = "expression"
}

// Functions

class Statement {

	Identifier id;
	Expressions expressions;
	StatementType type;
	Expression expression;
	bool immut;
	bool hasExpressions;


	Position pos;

	this(Identifier i) {
		id = i;
		expressions = new Expressions();
		type = StatementType.normalStatement;
		hasExpressions = false;
	}

	this(Identifier i, Expressions ex, bool isImmutable=false) {
		id = i;
		expressions = ex;

		immut = isImmutable;

		hasExpressions = true;
	}

	this(Expression ex) {
		if (ex.type==aE) {
		
			if (ex.arg.type==ArgumentType.stringArgument) {
				id = new Identifier("print");
				expressions = new Expressions();
				expressions.add(ex);

				type = StatementType.normalStatement;
				immut = false;

				hasExpressions = true;
				
			}
			else if (ex.arg.type==ArgumentType.identifierArgument) {
				id = ex.arg.identifier;
				expressions = new Expressions();
				type = StatementType.normalStatement;
				immut = false;
				hasExpressions = false;
			}
			else {
				id = null;
				expression = ex;
				type = StatementType.expressionStatement;
			}
		}
		else {
			id = null;
			expression = ex;
			type = StatementType.expressionStatement;
		}
	}

	Value executeFunctionCall() {
		string functionToExec = id.getId();
		
		return Glob.funcGet(functionToExec).execute(expressions);
	}

	Value executeUserFunctionCall(Func* f,Value* v) {
		if (Glob.memoize.canFind(to!string(f))) {

			Glob.blockStack.push((*f).block);

			Value ret = (*f).executeMemoized(expressions,to!string(f),v);

			if (Glob.blockStack.lastItem() is (*f).block) {
				Glob.blockStack.pop();
			}

			return ret;
		}
		else {
			writeln("pushing block to stack and executing: " ~ id.inspect());
			Glob.blockStack.push((*f).block);
		
			Value ret = (*f).executeWithRef(expressions,v);

			writeln("after executing: " ~ id.inspect());
			
			if (Glob.blockStack.lastItem() is (*f).block) {
				Glob.blockStack.pop();
			}

			return ret;
		}

	}

	Value executeAssignment(Value* v) {

		if (v is null) {
			if (expressions.lst.length==1) {
				Glob.symboldefs[id] = expressions;
			}
		
			Value ev = expressions.evaluate();
			
			if (ev.type==fV) {
				ev.content.f.name = id.getId();
			}

			bool success = Glob.varSetByIdentifier(id,ev,immut);			

			if (!success) {
				throw new ERR_CannotPerformAssignmentError(id.getFullIdentifier());
			}

			return ev;
		}
		else {
			Value ev = expressions.evaluate();

			if (v.type==dV) { // is dictionary
				
				if (ev.type==fV) {
					ev.content.f.name = id.getId();
				}
				v.setValueForDict(id.getId(), ev);
			}
			else { // is array
				v.content.a[(new Value(id.getId())).content.i] = ev;
			}

			return ev;
		}
	}

	Value execute(Value* v) {
		try {
			switch (type) {
				case StatementType.normalStatement:
					if (Glob.funcExists(id.getId())) return executeFunctionCall();  // system function
					else {

						if (!hasExpressions) {
							// it's an id-expression, return its value
							return new Expression(new Argument(id)).evaluate();
						}
						else {
							// it's an assignment
							return executeAssignment(v);
						}
					}

				case StatementType.expressionStatement:
					// it's an expression, return its value
					return expression.evaluate();
				default:
					return new Value();
			}
		}
		catch (Exception e) {
			debug writeln("STATEMENT::execute  (" ~ id.inspect() ~ ")-> got exception; reTHROW");
			throw e;
		}
	}

	void inspect() {
		writeln("statement: " ~ id.getId() ~ " with expressions:");
	}

}