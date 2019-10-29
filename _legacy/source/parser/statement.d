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
import value;

// C Interface

extern (C) {
	void* new_Statement(Identifier id) { return cast(void*)(new Statement(id)); }
	void* new_StatementFromExpression(Expression ex) { return cast(void*)(new Statement(ex)); }
	void* new_StatementWithExpressions(Identifier id, Expressions ex) { return cast(void*)(new Statement(id,ex)); }
	void set_Position(Statement x, Position p) { x.pos = p; }
}

// alias

void WARN_ASSIGN(string sym) { Panic.runtimeWarning((new WARN_AssignmentInsideExpression(sym)).msg); }

// Definitions

enum StatementType
{
	normalStatement,
	functionCallStatement,
	expressionStatement
}

// Functions

final class Statement {
	immutable StatementType type;
	Identifier id;
	Expressions expressions;
	
	Expression expression;
	bool hasExpressions;

	Position pos;

	@disable this();

	this(Identifier i) {
		type = StatementType.normalStatement;
		id = i;
		expressions = new Expressions();
		hasExpressions = false;
	}

	this(Identifier i, Expressions ex) {
		type = StatementType.normalStatement;
		id = i;
		expressions = ex;
		hasExpressions = true;
	}

	this(Expression ex) {
		if (ex.type==aE) {
		
			if (ex.content.arg.type==ArgumentType.stringArgument) {
				type = StatementType.normalStatement;
				id = PRINT_ID;
				expressions = new Expressions();
				expressions.add(ex);
				hasExpressions = true;
				
			}
			else if (ex.content.arg.type==ArgumentType.identifierArgument) {
				type = StatementType.normalStatement;
				id = ex.content.arg.content.i;
				expressions = new Expressions();
				hasExpressions = false;
			}
			else {
				type = StatementType.expressionStatement;
				id = null;
				expression = ex;
			}
		}
		else {
			type = StatementType.expressionStatement;
			id = null;
			expression = ex;
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
				case fV: ev.content.f.name = id.simpleId; break;
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
					ev.content.f.name = id.simpleId;
				}
				v.setSymbolForDict(id.simpleId, ev);
			}
			else { // is array
				v.content.a[(new Value(id.simpleId)).content.i] = ev;
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
		Value ret;
		try {
			switch(type) {
				case StatementType.normalStatement:

					Value va;

					if ((va=Glob.getSymbol(id)) !is null) {
						// Variable already exists

						if (va.type==fV) {
							// USER FUNCTION CALL
							ret = executeFunction(va.content.f);
						} 
						else {
							if (hasExpressions) {
								// RE-ASSIGNMENT (of existing variable)
								return executeAssignment(v,isInExpression);
							}
							else {
								// it's a single-id expression, return its value
								ret = new Expression(new Argument(id)).evaluate();
							}
						}
					}
					else {
						if (hasExpressions) {
							// ASSIGNMENT (first)
							return executeAssignment(v,isInExpression);
						}
						else {
							// throw error
							throw new ERR_SymbolNotFound(id.getFullIdentifier());
						}
					}
					
					break;
				case StatementType.expressionStatement:
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