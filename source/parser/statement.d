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

		writeln("Executing system func: " ~ functionToExec);

		if (expressions.hasHashId()) {
			size_t exsBefore = expressions.lst.length;
			Identifier hashId = expressions.extractHashId();
			size_t exsAfter = expressions.lst.length;

			writeln("has hash id: " ~ hashId.getId());
			writeln("exsBefore: " ~ to!string(exsBefore) ~ ", exsAfter: " ~ to!string(exsAfter));

			Value ret = Glob.funcGet(functionToExec).execute(expressions);

			bool success = Glob.varSetByIdentifier(hashId,ret,immut);			

			if (!success) {
				throw new ERR_CannotPerformAssignmentError(id.getFullIdentifier());
			}

			return ret;
		}
		else {
			writeln("no hash id found");
			return Glob.funcGet(functionToExec).execute(expressions);
		}
	}
/*
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

	}*/

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

	void assignExpressionValueToParentDict(Value result, Value* parentDict) {
		// if it doesn't already have a children's key, create it
		if (CHILDREN !in *parentDict) {
			(*parentDict)[CHILDREN] = Value.array();
		}

		// add result to parentDict
		(*parentDict)[CHILDREN].addValueToArray(result);
	}

	Value execute(Value* v) {
		Value ret;
		try {
			switch (type) {
				case StatementType.normalStatement:
					if (Glob.funcExists(id.getId())) {
						// it's a system func. call it and return its value
						ret = executeFunctionCall();
					}
					else {
						writeln("here1 : " ~ id.getId());
						if (!hasExpressions) {
							writeln("here2 : " ~ id.getId());
							// it's a single-id expression, return its value
							ret = new Expression(new Argument(id)).evaluate();
						}
						else {
							writeln("here3 : " ~ id.getId());
							// it's an assignment - return the result immediately,
							// no further processing needed
							return executeAssignment(v);
						}
					}
					break;

				case StatementType.expressionStatement:
					writeln("here4 : " ~ id.getId());
					// it's an expression, return its value
					ret = expression.evaluate();
					break;
				default:
					return new Value();
			}
		}
		catch (Exception e) {
			debug writeln("STATEMENT::execute  (" ~ id.inspect() ~ ")-> got exception; reTHROW");
			throw e;
		}

		if (v !is null) {
			// if we are in a dictionary and it was not an assignment
			// (in which case we've already return the result)
			// add the expression value to the dictionary's "children" property
			
			//bool dont = false;
			//if (id !is null && id.getId()[0]==':') dont=true;
			
			//if (!dont) 
			assignExpressionValueToParentDict(ret,v);
		}

		return ret;
	}

	void inspect() {
		writeln("statement: " ~ id.getId() ~ " with expressions:");
	}

}