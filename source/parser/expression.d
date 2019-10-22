/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/expression.d
 *****************************************************************/

module parser.expression;

// Imports

import std.array;
import std.conv;
import std.stdio;
import std.typecons;

import parser.argument;
import parser.expressions;
import parser.identifier;
import parser.identifiers;
import parser.statement;
import parser.statements;

import context;
import globals;
import value;

// C Interface

extern (C) {
	void* new_Expression(Expression l, char* op, Expression r, int tp) { return cast(void*)(new Expression(l,to!string(op),r,tp)); }
	void* new_ExpressionFromArgument(Argument a) { return cast(void*)(new Expression(a)); }
	void* new_ExpressionFromStatement(Statement s) { return cast(void*)(new Expression(s)); }
	void* new_ExpressionFromStatementBlock(Statements st) { return cast(void*)(new Expression(st)); }
	void* new_ExpressionFromStatementBlockWithArguments(Statements st,Identifiers ids) { return cast(void*)(new Expression(st,false,ids)); }
	void* new_ExpressionFromDictionary(Statements st) { return cast(void*)(new Expression(st,true)); }
	void* new_ExpressionFromArray(Expressions ar) { return cast(void*)(new Expression(ar)); }
}

// Aliases

alias aE = ExpressionType.argumentExpression;
alias cE = ExpressionType.comparisonExpression;
alias nE = ExpressionType.normalExpression;
alias xE = ExpressionType.nullExpression;
alias fE = ExpressionType.functionExpression;
alias bE = ExpressionType.blockExpression;
alias dE = ExpressionType.dictionaryExpression;
alias rE = ExpressionType.arrayExpression;

alias ExpressionTuple = Tuple!(Expression,"left",string,"operator",Expression,"right");
alias BlockTuple = Tuple!(Statements,"statements",string[],"args");

// Definitions

enum ExpressionType
{
	argumentExpression,
	normalExpression,
	comparisonExpression,
	functionExpression,
	blockExpression,
	arrayExpression,
	nullExpression,
	dictionaryExpression
}

union ExpressionContent
{
	ExpressionTuple normal;
	Argument arg;
	Statement func;
	Statements dict;
	BlockTuple block;
	Value v;
	Expressions arr;
}


// Functions

final class Expression {

	immutable ExpressionType type;
	ExpressionContent content;

	@disable this();

	this(Expression l, string op, Expression r, int tp) {
		if (tp==0) type = nE;
		else type = cE;

		content.normal = ExpressionTuple(l,op,r);
	}

	this(Argument a) {
		type = aE;
		content.arg = a;
	}

	this(Statement s) {
		type = ExpressionType.functionExpression;
		content.func = s;
	}

	this(Statements st, bool isDictionary=false, Identifiers ids = null) {

		string[] function_arguments;
		if (ids !is null) {
			//identifiers = ids;
			// #CHK: what happens if identifier is not a single ID? - eg a number, or a path
			foreach (Identifier id; ids.lst) {
				if (id.pathContentTypes[0]==idPC) {
					function_arguments ~= id.getId();
				}
			}
		}

		if (isDictionary) { type = dE; content.dict = st; }
		else { type = bE; content.block = BlockTuple(st,function_arguments); }
	}

	this(Expressions ar) {
		type = rE;
		content.arr = ar;
	}

	Value evaluateNormalExpression() {
		Value lValue = content.normal.left.evaluate();
		Value rValue; 
		
		if (content.normal.right) rValue = content.normal.right.evaluate();
		else return lValue;

		switch (content.normal.operator) {
			case "+"	: return lValue+rValue;
			case "-"	: return lValue-rValue;
			case "*"	: return lValue*rValue;
			case "/"	: return lValue/rValue;
			case "%"	: return lValue%rValue;
			case "^"	: return lValue^^rValue;
			case ""		: return lValue;
			default		: break;
		}

		return null;
	}

	Value evaluateComparisonExpression() {
		Value lValue = content.normal.left.evaluate();
		Value rValue;
		if (content.normal.right) rValue = content.normal.right.evaluate();
		else return lValue;

		switch (content.normal.operator) {
			case "="	: return lValue==rValue ? TRUEV : FALSEV;
			case "!="	: return lValue!=rValue ? TRUEV : FALSEV;
			case ">"	: return lValue>rValue  ? TRUEV : FALSEV;
			case ">="	: return lValue>=rValue ? TRUEV : FALSEV;
			case "<"	: return lValue<rValue  ? TRUEV : FALSEV;
			case "<="	: return lValue<=rValue ? TRUEV : FALSEV;
			case "" 	: return lValue;
			default		: break;
		}

		return null;
	}

	Value evaluateArrayExpression() {
		Value[] res;

		foreach (Expression ex; content.arr.lst) {
			res ~= ex.evaluate();
		}

		return new Value(res);
	}

	Value evaluateDictionaryExpression() {
		Value res = Value.dictionary();

		Glob.contextStack ~= res.content.d;

		foreach (Statement s; content.dict.lst) {
			s.execute(&res);
		}

		Glob.contextStack.removeBack();

		return res;
	}

	Value evaluate() {
		switch (type) {
			case ExpressionType.argumentExpression:		return content.arg.getValue();
			case ExpressionType.normalExpression:		return evaluateNormalExpression();
			case ExpressionType.arrayExpression:		return evaluateArrayExpression();
			case ExpressionType.dictionaryExpression:	return evaluateDictionaryExpression();
			case ExpressionType.comparisonExpression: 	return evaluateComparisonExpression();
			case ExpressionType.functionExpression:		return content.func.execute(null,true);
			case ExpressionType.blockExpression:		return new Value(content.block.statements, content.block.args);
			default: return null;
		}
	}

}
