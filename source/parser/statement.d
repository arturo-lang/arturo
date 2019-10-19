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

import parser.argument;
import parser.expression;
import parser.expressions;
import parser.identifier;
import parser.statement;
import parser.statements;
import parser.position;

import func;
import globals;
import panic;
import stack;
import value;

// C Interface

extern (C) {
	void* new_Statement(Identifier id) { return cast(void*)(new Statement(id)); }
	void* new_StatementFromExpression(Expression ex) { return cast(void*)(new Statement(ex)); }
	void* new_StatementWithExpressions(Identifier id, Expressions ex) { return cast(void*)(new Statement(id,ex)); }
	void* new_ImmutableStatementWithExpressions(Identifier id, Expressions ex) { return cast(void*)(new Statement(id,ex,true)); }
	void set_Position(Statement x, Position p) { x.pos = p; }
}

// alias

void WARN_ASSIGN(string sym) { Panic.runtimeWarning((new WARN_AssignmentInsideExpression(sym)).msg); }

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

	@disable this();

	this(Identifier i) {
		id = i;
		expressions = new Expressions();
		type = StatementType.normalStatement;
		hasExpressions = false;
		//writeln("Statement(Identifier) @ Found identifier: " ~ id.getFullIdentifier());
	}

	this(Identifier i, Expressions ex, bool isImmutable=false) {
		id = i;
		expressions = ex;

		immut = isImmutable;

		hasExpressions = true;
		//writeln("Statement(Identifier,Expressions) @ Found identifier: " ~ id.getFullIdentifier());
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
				id = ex.arg.content.i;
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

	Value executeFunction(Func f) {
		if (expressions.hasHashId) {
			if (f.type==FuncType.systemFunc) {
				Identifier hashId = expressions.extractHashId();
				Value ret = f.execute(expressions,hashId.getId());

				Glob.setGlobalSymbol(hashId.simpleId,ret);

				return ret;
			}
			else {
				Value args = (expressions is null) ? Value.array() : expressions.evaluate(true);

				Identifier hashId = expressions.extractHashId();
				Value ret = f.execute(args,null,to!string(cast(void*)f));

				Glob.setGlobalSymbol(hashId.simpleId,ret);

				return ret;
			}
		}
		else {
			if (f.type==FuncType.systemFunc) {
				return f.execute(expressions);
			}
			else {
				Value args = (expressions is null) ? Value.array() : expressions.evaluate(true);

				return f.execute(args,null,to!string(cast(void*)f));
			}
		}
	}

	Value executeAssignment(Value* v, bool isInExpression=false) {

		if (v is null) {
		
			Value ev = expressions.evaluate();

			switch (ev.type) {
				case dV: if (expressions.lst.length==1) Glob.symboldefs[id] = expressions; break;
				case fV: ev.content.f.name = id.getId(); break;
				default: break;
			}	

			if (!Glob.setSymbol(id,ev)) {
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
				v.setSymbolForDict(id.getId(), ev);
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

	Value execute(Value* v, bool isInExpression=false) {
		//if (isInExpression) WARN_ASSIGN(id.getId());

		Value ret;
		try {
			switch(type) {
				case StatementType.normalStatement:

					Value va;

					if ((va=Glob.getSymbol(id)) !is null) {
						// Variable already exists

						if (va.type==fV) {
							//writeln(id.getFullIdentifier() ~ " : user func call");
							// USER FUNCTION CALL
							ret = executeFunction(va.content.f);
							//ret = executeUserFunctionCall(va.value.content.f);
						} 
						else {
							if (hasExpressions) {
								//writeln(id.getFullIdentifier() ~ " : re-assignment");
								// RE-ASSIGNMENT (of existing variable)
								return executeAssignment(v,isInExpression);
							}
							else {
								//writeln(id.getFullIdentifier() ~ " : expression (single-id)");
								// it's a single-id expression, return its value
								ret = new Expression(new Argument(id)).evaluate();
							}
						}
					}
					else {
						if (hasExpressions) {
							//writeln(id.getFullIdentifier() ~ " : assignment");
							// ASSIGNMENT (first)
							return executeAssignment(v,isInExpression);
						}
						else {
							// throw error
							//writeln(id.getFullIdentifier() ~ " : NOT FOUND!");
							throw new ERR_SymbolNotFound(id.getFullIdentifier());
						}
					}
					/*}*/
					break;
				case StatementType.expressionStatement:
					//writeln("null : expression statement");
					// it's an expression, return its value
					ret = expression.evaluate();
					break;
				default:
					// CONTROL NEVER REACHES THIS POINT
					return NULLV;
			}
		}
		catch (Exception e) {
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