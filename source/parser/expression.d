/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: parser/expression.d
 ************************************************/

module parser.expression;

// Imports

import std.stdio;
import std.conv;
import std.array;

import parser.argument;
import parser.expressions;
import parser.statement;
import parser.statements;

import globals;
import context;
import value;

// C Interface

extern (C) {
	void* new_Expression(Expression l, char* op, Expression r, int tp) { return cast(void*)(new Expression(l,to!string(op),r,tp)); }
	void* new_ExpressionFromArgument(Argument a) { return cast(void*)(new Expression(a)); }
	void* new_ExpressionFromStatement(Statement s) { return cast(void*)(new Expression(s)); }
	void* new_ExpressionFromStatementBlock(Statements st) { return cast(void*)(new Expression(st)); }
	void* new_ExpressionFromStatementBlockWithArguments(Statements st,char* ids) { return cast(void*)(new Expression(st,false,to!string(ids))); }
	void* new_ExpressionFromDictionary(Statements st) { return cast(void*)(new Expression(st,true)); }
	void* new_ExpressionFromArray(Expressions ar) { return cast(void*)(new Expression(ar)); }
}

// Aliases

alias aE = ExpressionType.argumentExpression;
alias nE = ExpressionType.nullExpression;
alias fE = ExpressionType.functionExpression;
alias bE = ExpressionType.blockExpression;

// Definitions

enum ExpressionType : string
{
	argumentExpression = "argument",
	normalExpression = "expre",
	comparisonExpression = "comparison",
	functionExpression = "function",
	blockExpression = "block",
	arrayExpression = "array",
	nullExpression = "expression",
	dictionaryExpression = "dictionary"
}

// Functions

class Expression {

	ExpressionType type;

	Expression left;
	string operator;
	Expression right;

	Argument arg;

	Statement statement;
	Statements statements;
	string[] function_arguments;
	Expressions expressions;

	this() {

	}

	this(Expression l, string op, Expression r, int tp) {
		if (tp==0) type = ExpressionType.normalExpression;
		else type = ExpressionType.comparisonExpression;

		left = l;
		operator = op;
		right = r;

		arg = null;
		statement = null;
		statements = null;
	}

	this(Argument a) {
		type = ExpressionType.argumentExpression;

		arg = a;
		statement = null;
		statements = null;
	}

	this(Statement s) {
		type = ExpressionType.functionExpression;

		arg = null;
		statement = s;
		statements = null;
	}

	this(Statements st, bool isDictionary=false, string ids = null) {
		if (isDictionary) type = ExpressionType.dictionaryExpression;
		else type = ExpressionType.blockExpression;

		arg = null;
		statement = null;
		statements = st;

		if (ids !is null) {
			function_arguments = ids.split(",");
		}
		else {
			function_arguments = [];
		}
	}

	this(Expressions ar) {
		type = ExpressionType.arrayExpression;

		arg = null;
		statement = null;
		statements = null;
		expressions = ar;
	}

	void inspect() {
		switch (type) {
			case ExpressionType.argumentExpression:
				writeln("\texpression: argument: ");
				arg.inspect();
				break;
			case ExpressionType.functionExpression:
				writeln("\texpression: statement: ");
				statement.inspect();
				break;
			case ExpressionType.blockExpression:
				writeln("\texpression: statement block: ");
				statements.inspect();
				break;
			case ExpressionType.normalExpression:
			case ExpressionType.comparisonExpression:
				writeln("\texpression: left: ");
				left.inspect();
				writeln("\texpression: op: " ~ operator);
				if (right !is null) {
					writeln("\texpression: right: ");
					right.inspect();
				}
				break;
			default:
				writeln("shouldn't reach this point");
				break;
		}
	}

	Value evaluateNormalExpression() {
		Value lValue = left.evaluate();
		Value rValue; 
		if (right) rValue = right.evaluate();

		switch (operator)
		{
			case "+"	: return lValue+rValue;
			case "-"	: return lValue-rValue;
			case "*"	: return lValue*rValue;
			case "/"	: return lValue/rValue;
			case "%"	: return lValue%rValue;
			case "^"	: return lValue^^rValue;
			case ""		: return lValue; //#CHNG
			default		: break;
		}

		return null;
	}

	Value evaluateComparisonExpression() {
		Value lValue = left.evaluate();
		Value rValue;
		if (right) rValue = right.evaluate();

		switch (operator)
		{
			case "=="	: return new Value(lValue==rValue);
			case "!="	: return new Value(lValue!=rValue);
			case ">"	: return new Value(lValue>rValue);
			case ">="	: return new Value(lValue>=rValue);
			case "<"	: return new Value(lValue<rValue);
			case "<="	: return new Value(lValue<=rValue);
			case "" 	: return lValue;
			default		: break;
		}

		return null;
	}

	Value evaluateArrayExpression() {
		Value[] res;

		foreach (Expression ex; expressions.lst) {
			res ~= ex.evaluate();
		}

		return new Value(res);
	}

	Value evaluateDictionaryExpression() {
		Value res = new Value();
		res.type = ValueType.dictionaryValue;

		//Glob.contextStack.push(new Context());
		//Glob.varSet(THIS, res);
		//Glob.inspect();

		foreach (Statement s; statements.lst) {
			s.execute(&res);
		}

		//Glob.contextStack.pop();

		return res;
	}

	Value evaluateFunctionExpression() {
		return statement.execute(null);
	}

	Value evaluateBlockExpression() {
		return new Value(statements, function_arguments);
		//return new Value(statements);
	}

	Value evaluate()
	{
		switch (type) {
			case ExpressionType.argumentExpression:
				return arg.getValue();
			case ExpressionType.normalExpression:
				return evaluateNormalExpression();
			case ExpressionType.arrayExpression:
				return evaluateArrayExpression();
			case ExpressionType.dictionaryExpression:
				return evaluateDictionaryExpression();
			case ExpressionType.comparisonExpression:
				return evaluateComparisonExpression();
			case ExpressionType.functionExpression:
				return evaluateFunctionExpression();
			case ExpressionType.blockExpression:
				return evaluateBlockExpression();
			default:
				writeln("I don't know how to evaluate this");
				return null;
		}
	}

}
