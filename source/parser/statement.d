/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: parser/statement.d
 ************************************************/

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
	void* new_Statement(char* id) { return cast(void*)(new Statement(to!string(id))); }
	void* new_StatementFromExpression(Expression ex) { return cast(void*)(new Statement(ex)); }
	void* new_StatementWithExpressions(char* id, Expressions ex) { return cast(void*)(new Statement(to!string(id),ex)); }
	void* new_ImmutableStatementWithExpressions(char* id, Expressions ex) { return cast(void*)(new Statement(to!string(id),ex,true)); }
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

	string id;
	Expressions expressions;
	StatementType type;
	Expression expression;
	bool immut;
	bool hasExpressions;

	Position pos;

	this(string i) {
		id = i;
		expressions = new Expressions();
		type = StatementType.normalStatement;
		hasExpressions = false;
	}

	this(string i, Expressions ex, bool isImmutable=false) {
		id = i;
		expressions = ex;

		immut = isImmutable;

		hasExpressions = true;
	}

	this(Expression ex) {
		if (ex.type==aE) {
			if (ex.arg.type==ArgumentType.stringArgument) {
				id = "print";
				expressions = new Expressions();
				expressions.add(ex);

				type = StatementType.normalStatement;
				immut = false;

				hasExpressions = true;
				
			}
			else if (ex.arg.type==ArgumentType.identifierArgument) {
				id = ex.arg.value.content.s;
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
		return Glob.funcGet(id).execute(expressions);
	}

	Value getDottedItem(string s) {

		string[] parts = s.split(".");
		string mainObject = parts[0];
		Value main;

		if (Glob.varExists(mainObject)) main = Glob.varGet(mainObject);
		else throw new ERR_SymbolNotFound(mainObject);

		parts.popFront();

		while (parts.length>0) {
			string nextKey = parts[0];

			if (main.type==dV) {
				Value nextKeyValue = main.getValueFromDict(nextKey);
				if (nextKeyValue !is null)
					main = nextKeyValue;
				else throw new ERR_IndexNotFound(nextKey, to!string(main));
			}
			else if (main.type==aV) {
				if (isNumeric(nextKey) && main.content.a.length<to!int(nextKey)) 
					main = main.content.a[to!int(nextKey)];
				else {
					if (isNumeric(nextKey)) throw new ERR_IndexNotFound(to!long(nextKey), to!string(main));
					else throw new ERR_IndexNotFound(nextKey, to!string(main));
				}
			}
			else throw new ERR_ObjectNotIndexable(to!string(main), nextKey);

			parts.popFront();
		}

		return main;
	}

	Value executeUserFunctionCall(Func* f) {
		//writeln("About to execute(pointer): " ~ to!string(f));
		if (Glob.memoize.canFind(to!string(f))) {
			//Glob.retStack.push(Glob.retCounter+1);
			//writeln("** Statement:executeUserFunctionCall : name=" ~ (*f).name ~ ", retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());
			//writeln("** \tretStack: pushed " ~ to!string(Glob.retCounter+1));
			Glob.blockStack.push((*f).block);

			Value ret = (*f).executeMemoized(expressions,to!string(f));

			if (Glob.blockStack.lastItem() is (*f).block) {
				//writeln("STACK found unaltered (no return occured). I have to pop it");
				Glob.blockStack.pop();
			}
			//Glob.retStack.pop();
			return ret;
		}
		else {
			//Glob.retStack.push(Glob.retCounter+1);
			//writeln("** Statement:executeUserFunctionCall : name=" ~ (*f).name ~ ", retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());
			//writeln("** \tretStack: pushed " ~ to!string(Glob.retCounter+1));
			//Stack!(int) stackBefore = Glob.retStack;
			Glob.blockStack.push((*f).block);
			//writeln("** Statement:executeUserFunctionCall - PUSHing block");
			//writeln("** blockStack: " ~ Glob.blockStack.list.map!(b=> to!string(&b)).array.join(", "));
			Value ret = (*f).execute(expressions);
			//writeln("got result: " ~ ret.stringify());
			if (Glob.blockStack.lastItem() is (*f).block) {
				//writeln("STACK found unaltered (no return occured). I have to pop it");
				Glob.blockStack.pop();
			}
			//if (Glob.retStack.size()==stackBefore.size()) {
				//writeln("STACK found unaltered (no return occured) (before:" ~ to!string(stackBefore.size()) ~ ", after: " ~ to!string(Glob.retStack.size()) ~ " - popping");
				//Glob.retStack.pop();
			//}
			return ret;
		}
		/*
		Value func;

		if (Glob.varExists(id)) func = Glob.varGet(id);
		else if (id.indexOf(".")!=-1) func = getDottedItem(id);
		else throw new ERR_FunctionNotFound(id);

		if (func.type!=fV) throw new ERR_FunctionNotFound(id);
		else return func.content.f.execute(expressions);*/
	}
/*
	Value executeUserFunctionCall(Func f) {
		writeln("About to execute: " ~ to!string(&f));
		return f.execute(expressions);
	}
*/
	Value executeAssignment(Value* v) {
		if (v is null) {
			Value ev = expressions.evaluate();
			if (ev.type==fV) {
				ev.content.f.name = id;
			}
			Glob.varSet(id,ev,immut);
			debug writeln("value= (" ~ id ~ ") -> " ~	ev.stringify());
			debug writeln("Found assignment: " ~ id);

			return ev;
		}
		else {
			debug writeln("Executing inner assignment: " ~ id);
			Value ev = expressions.evaluate();
			//return ev;
			//writeln("setting: " ~ ev.stringify ~ " for: " ~ id ~ " object: " ~ v.stringify());
			if (v.getValueFromDict(id) !is null) {
				v.setValueForDict(id, ev);
			}
			else {
				v.content.d[new Value(id)] = ev;
			}
			return ev;
			//return new Value(0);
		}
	}

	Value execute(Value* v) {
		//writeln("executing statement: " ~	id);
		try {
			switch (type) {
				case StatementType.normalStatement:

					//writeln("normal statement");

					if (Glob.funcExists(id)) return executeFunctionCall(); // System function
					else {
						bool isDictionaryKey = id.indexOf(".")!=-1;
						
						Value sym = Glob.getSymbol(id);

						//writeln("no func exists: " ~ id);
						
						if (hasExpressions) {
							//writeln("has expressions");
							if (sym is null) {
								//writeln("sym is null");
								//writeln("Defining new symbol: " ~ id);
								return executeAssignment(v); // what about keys?
							}
							else {
								//writeln("sym not null");
								if (sym.type==fV) {
									if (isDictionaryKey) return executeUserFunctionCall(&sym.content.f);
									else {
										Var va = Glob.varGetVar(id);
										if (va.immut) return executeUserFunctionCall(&sym.content.f);
										else throw new ERR_ModifyingImmutableVariableError(id);
									}
								}
								else {
									//writeln("not fV");
									if (isDictionaryKey) { 
										//writeln("dictionary key");
										Value symParent = Glob.getSymbolParent(id);
										if (symParent !is null) {
											auto ids = id.split(".");
											id = ids[ids.length-1];
											return executeAssignment(&symParent);
										}
										else throw new ERR_SymbolNotFound(id);
									}
									else {
										Var va = Glob.varGetVar(id);
										if (va.immut) throw new ERR_ModifyingImmutableVariableError(id);
										else {
											//writeln("Re-assigning symbol: " ~ id);
											return executeAssignment(v);
										}
									}
								}
							}
						}
						else {
							//writeln("without expressions");
							//if (sym is null) throw new ERR_SymbolNotFound(id);

							if ((sym !is null) && (sym.type==fV)) {
								if (isDictionaryKey) {
									return executeUserFunctionCall(&sym.content.f);
								}
								else {
									Var va = Glob.varGetVar(id);
									if (va.immut) return executeUserFunctionCall(&sym.content.f);
									else return sym;
								}
							}
							else {
								return new Expression(new Argument("id",id)).evaluate();
							}
							//else return sym;
						}
					}

				case StatementType.expressionStatement:
					//writeln("expression statement");
					return expression.evaluate();
				default:
					return new Value();
			}
			/*
			//writeln("about to execute executeUserFunctionCall: " ~ id);
			if (type==StatementType.normalStatement) {
				if (!hasExpressions) {
					writeln("no expr");
					if (Glob.funcExists(id)) return executeFunctionCall();
					else {
						if (Glob.varExists(id)) {
							Var va = Glob.varGetVar(id);

							if ((va.immut) && (va.value.type==fV)) return executeUserFunctionCall();
							else return Glob.varGet(id);
						}
						else throw new ERR_SymbolNotFound(id);

						// TODO: get dotted items
						// if it's a function, call the function
						// if it's a value, return it
					}
				} 
				else {
					if (Glob.funcExists(id)) return executeFunctionCall();
					else {
						if (Glob.varExists(id)) {
							Var va = Glob.varGetVar(id);

							if (va.immut) {
								if (va.value.type==fV) return executeUserFunctionCall();
								else throw new ERR_ModifyingImmutableVariableError(id);
							}
							else return executeAssignment(v);

						} 
						else if (id.indexOf(".")!=-1) return executeUserFunctionCall();
						else return executeAssignment(v);
					}
				}
			} 
			else if (type==StatementType.expressionStatement) {
				//writeln("executing expressionStatement");
				return expression.evaluate();
				
				//return new Value(666);
			}
			else return new Value(0);
			//else return executeUserFunctionCall();*/
		}
		catch (Exception e) {
			//writeln("Caught exception (statement level): " ~ e.msg);
			throw e;
			/*
			if (cast(ReturnResult)(e) !is null) {
				Value va = (cast(ReturnResult)(e)).val;
				if (Glob.trace) {
					writeln(" ".replicate(Glob.contextStack.size()) ~ to!string(Glob.contextStack.size()) ~ "-> " ~ va.stringify());
				}
				return va;
			} else {
				//Panic.runtimeError(e.msg, s.pos);
				// rethrow
				throw e;
			}*/
		}
		//return new Value(0);
	}

	void inspect() {
		writeln("statement: " ~ id ~ " with expressions:");
		//expressions.inspect();
	}

}