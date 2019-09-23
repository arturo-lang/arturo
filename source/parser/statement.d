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
			//writeln("Found assignment: " ~ id);
			Value ev = expressions.evaluate();
			if (ev.type==fV) {
				ev.content.f.name = id;
			}
			Glob.varSet(id,ev,immut);
			debug writeln("value= (" ~ id ~ ") -> " ~	ev.stringify());
			

			return ev;
		}
		else {
			//writeln("Executing inner assignment: " ~ id);
			Value ev = expressions.evaluate();
			//return ev;
			//writeln("setting: " ~ ev.stringify ~ " for: " ~ id ~ " object: " ~ v.stringify());
			if (v.type==dV) { // is dictionary
				//writeln("is dictionary");
				v.setValueForDict(id, ev);
			}
			else { // is array
				v.content.a[(new Value(id)).content.i] = ev;
			}
			//writeln("HERE");
			return ev;
			//return new Value(0);
		}
	}

	Value execute(Value* v) {
		//writeln("Executing statement: " ~ id);
		try {
			switch (type) {
				case StatementType.normalStatement:

					if (Glob.funcExists(id)) return executeFunctionCall();  // system function
					else {
						bool isDictionaryKey = id.indexOf(".")!=-1;
						
						Var sym = Glob.varGet(id);

						//writeln("sym :" ~ to!string(sym));
						
						if (hasExpressions) {
							if (sym is null) return executeAssignment(v);
							else {
								if (sym.value.type==fV) {
									if (sym.immut && !immut) return executeUserFunctionCall(&sym.value.content.f);
									else throw new ERR_ModifyingImmutableVariableError(id);
								}
								else {
									if (isDictionaryKey) { 
										Value symParent = Glob.getParentDictForSymbol(id);
										if (symParent !is null) {
											auto ids = id.split(".");
											id = ids[ids.length-1];
											return executeAssignment(&symParent);
										}
										else throw new ERR_SymbolNotFound(id);
									}
									else {
										if (sym.immut) throw new ERR_ModifyingImmutableVariableError(id);
										else return executeAssignment(v);
									}
								}
							}
						}
						else {
							if ((sym !is null) && (sym.value.type==fV)) {
								if (sym.immut) return executeUserFunctionCall(&sym.value.content.f);
								else return sym.value;
							}
							else return new Expression(new Argument("id",id)).evaluate();
						}
					}

				case StatementType.expressionStatement:
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
		writeln("statement: " ~ id ~ " with expressions:");
		//expressions.inspect();
	}

}