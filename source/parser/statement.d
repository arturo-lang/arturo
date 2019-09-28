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
			Glob.blockStack.push((*f).block);
		
			Value ret = (*f).executeWithRef(expressions,v);
			
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
			Glob.varSet(id.getId(),ev,immut);			

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
					writeln("Executing normal statement: " ~ id.inspect());

					if (Glob.funcExists(id.getId())) return executeFunctionCall();  // system function
					else {

						if (!hasExpressions) {
							// it's an id-expression, return it's value
							writeln("it's an id-expression");
							return new Expression(new Argument(id)).evaluate();
						}
						else {
							// it's an assignment
							writeln("it's an assignment");
							return executeAssignment(v);
						}

						/*
						bool isDictionaryKey = id.getId().indexOf(".")!=-1;
						
						Var sym = Glob.varGet(id.getId());
						
						if (hasExpressions) {
							if (sym is null) return executeAssignment(v);
							else {
								if (sym.value.type==fV) {
									if (sym.immut && !immut) return executeUserFunctionCall(&sym.value.content.f,v);
									else throw new ERR_ModifyingImmutableVariableError(id.getId());
								}
								else {
									if (isDictionaryKey) { 
										Value symParent = Glob.getParentDictForSymbol(id.getId());
										if (symParent !is null) {
											auto ids = id.getId().split(".");
											id = new Identifier(ids[ids.length-1]);
											return executeAssignment(&symParent);
										}
										else throw new ERR_SymbolNotFound(id.getId());
									}
									else {
										if (sym.immut) throw new ERR_ModifyingImmutableVariableError(id.getId());
										else return executeAssignment(v);
									}
								}
							}
						}
						else {
							if ((sym !is null) && (sym.value.type==fV)) {
								if (sym.immut) return executeUserFunctionCall(&sym.value.content.f,v);
								else return sym.value;
							}
							else return new Expression(new Argument(id)).evaluate();
						}
						*/
					}

				case StatementType.expressionStatement:
					writeln("Executing expression statement");
					return expression.evaluate();
				default:
					return new Value();
			}
		}
		catch (Exception e) {
			throw e;
		}
	}

	void inspect() {
		writeln("statement: " ~ id.getId() ~ " with expressions:");
	}

}