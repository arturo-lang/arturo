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
		writeln("HERE");
		writeln("new statement:  " ~ i.inspect());
		id = i;
		expressions = new Expressions();
		type = StatementType.normalStatement;
		hasExpressions = false;
	}

	this(Identifier i, Expressions ex, bool isImmutable=false) {
		writeln("HEERE:");
		writeln("new statement:  " ~ i.inspect());
		id = i;
		expressions = ex;

		immut = isImmutable;

		hasExpressions = true;
	}

	this(Expression ex) {
		writeln("new statement from expression:  ");
		if (ex.type==aE) {
			writeln("argument expression");
			if (ex.arg.type==ArgumentType.stringArgument) {
				id = new Identifier("print");
				expressions = new Expressions();
				expressions.add(ex);

				type = StatementType.normalStatement;
				immut = false;

				hasExpressions = true;
				
			}
			else if (ex.arg.type==ArgumentType.identifierArgument) {
				writeln("id argument");
				id = ex.arg.identifier;//new Identifier(ex.arg.value.content.s);
				expressions = new Expressions();
				type = StatementType.normalStatement;
				immut = false;
				hasExpressions = false;
			}
			else {
				writeln("other argument");
				id = null;
				expression = ex;
				type = StatementType.expressionStatement;
			}
		}
		else {
			writeln("other expression");
			id = null;
			expression = ex;
			type = StatementType.expressionStatement;
		}
		writeln("new statement from expression: POST");
	}

	Value executeFunctionCall() {
		return Glob.funcGet(id.getId()).execute(expressions);
	}

	Value executeUserFunctionCall(Func* f,Value* v) {
		//writeln("About to execute(pointer): " ~ to!string(f));
		if (Glob.memoize.canFind(to!string(f))) {
			//Glob.retStack.push(Glob.retCounter+1);
			//writeln("** Statement:executeUserFunctionCall : name=" ~ (*f).name ~ ", retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());
			//writeln("** \tretStack: pushed " ~ to!string(Glob.retCounter+1));
			Glob.blockStack.push((*f).block);

			Value ret = (*f).executeMemoized(expressions,to!string(f),v);

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
			//writeln("In statement:executeUserFunctionCall");
			Glob.blockStack.push((*f).block);
			//writeln("** Statement:executeUserFunctionCall - PUSHing block");
			//writeln("** blockStack: " ~ Glob.blockStack.list.map!(b=> to!string(&b)).array.join(", "));
			Value ret = (*f).executeWithRef(expressions,v);
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

		writeln("Executing assignment");
		if (v is null) {

			writeln("ASSIGNMENT: (before)" ~ id.getId());

			if (expressions.lst.length==1) {
				//writeln("FOUND CLASS_DEF: " ~ id);
				Glob.symboldefs[id.getId()] = expressions;
			}
			//writeln("Found assignment: " ~ id);
			Value ev = expressions.evaluate();
			//writeln("assigning: " ~ to!string(cast(void*)(ev)));
			//ev = new Value(ev);
			//writeln("assigning (new): " ~ to!string(cast(void*)(ev)));
			//writeln("ASSIGNMENT: " ~ id ~ " ==> (0x" ~ to!string(cast(void*)ev) ~ ") = " ~ ev.stringify());
			if (ev.type==fV) {
				ev.content.f.name = id.getId();
			}
			Glob.varSet(id.getId(),ev,immut);
			//debug writeln("value= (" ~ id ~ ") -> " ~	ev.stringify());
			

			return ev;
		}
		else {
			//writeln("ASSIGNMENT [internal for 0x" ~ to!string(cast(void*)*v) ~ "]: (before)" ~ id);
			//writeln("Executing inner assignment: " ~ id);
			Value ev = expressions.evaluate();

			//writeln("ASSIGNMENT [internal for 0x" ~ to!string(cast(void*)*v) ~ "] : " ~ id ~ " ==> (0x" ~ to!string(cast(void*)ev) ~ ") = " ~ ev.stringify());
			//return ev;
			//writeln("setting: " ~ ev.stringify ~ " for: " ~ id ~ " object: " ~ v.stringify());
			if (v.type==dV) { // is dictionary
				//writeln("is dictionary");
				//writeln("setting value: " ~ id ~ " to: " ~ ev.stringify() ~ " for: " ~ to!string(cast(void*)(*v)));
				if (ev.type==fV) {
					ev.content.f.name = id.getId();
				}
				v.setValueForDict(id.getId(), ev);
			}
			else { // is array
				v.content.a[(new Value(id.getId())).content.i] = ev;
			}
			//writeln("HERE");
			return ev;
			//return new Value(0);
		}
	}

	Value execute(Value* v) {
		//if (v is null) writeln("Executing statement: " ~ id.inspect() ~ ", value: null");
		//else  writeln("Executing statement: " ~ id.inspect() ~ ", value: " ~ to!string(cast(void*)(*v)));

		try {
			switch (type) {
				case StatementType.normalStatement:

					if (Glob.funcExists(id.getId())) return executeFunctionCall();  // system function
					else {
						bool isDictionaryKey = id.getId().indexOf(".")!=-1;
						
						Var sym = Glob.varGet(id.getId());

						writeln("sym :" ~ to!string(sym));
						
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
		writeln("statement: " ~ id.getId() ~ " with expressions:");
		//expressions.inspect();
	}

}