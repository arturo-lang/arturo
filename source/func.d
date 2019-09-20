/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: func.d
 ************************************************/

module func;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.digest.sha;
import std.stdio; 
import std.string;
import std.typecons;

import parser.expression;
import parser.expressions;
import parser.statements;

import value;

import globals;

import panic;

import context;

// Definitions

enum FuncType
{
	userFunc,
	systemFunc
}

// Functions

class Func {

	string name;
	string description;
	FuncType type;
	Statements block;

	ExpressionType[][] expressionConstraints;
	ValueType[][] valueConstraints;
	ValueType[] returnValues;

	ulong minArgs;
	ulong maxArgs;

	string[] ids;

	// system functions
	this (string n, string descr, ValueType[][] vc = [], ValueType[] rets = []) {
		name = n;
		block = null;
		type = FuncType.systemFunc;

		description = descr;

		minArgs = -1;
		maxArgs = 100;	

		if (vc!=[]) {
			valueConstraints = vc;
			minArgs = 100;
			maxArgs = 0;
			foreach (ValueType[] constraints; valueConstraints) {
				if (constraints.length<minArgs) minArgs = constraints.length;
				if (constraints.length>maxArgs) maxArgs = constraints.length;
			}
		}

		returnValues = rets;
	}

	// user functions
	this (string n, Statements b = null, ValueType[][] vc = [], string[] idents = []) {
		//Func f = this;
		//writeln("Creating: " ~ to!string(&f));
		name = n;
		block = b;

		if (b is null) type = FuncType.systemFunc;
		else type = FuncType.userFunc;

		minArgs = -1;
		maxArgs = 100;

		if (vc!=[]) {
			valueConstraints = vc;
			minArgs = 100;
			maxArgs = 0;
			foreach (ValueType[] constraints; valueConstraints) {
				if (constraints.length<minArgs) minArgs = constraints.length;
				if (constraints.length>maxArgs) maxArgs = constraints.length;
			}

			debug writeln("setting func: " ~ name ~ " minArgs: " ~ to!string(minArgs) ~ ", maxArgs: " ~ to!string(maxArgs));
		}

		ids = idents;
	}

	Value execute(Value values = null) {
		//writeln("about to execute function with values");

		//writeln("** Func:execute (before) : name=" ~ name ~ ", retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());

		Glob.contextStack.push(new Context());

		if (Glob.trace && name !is null && name.strip()!="") {
			write(" ".replicate(Glob.contextStack.size()) ~ to!string(Glob.contextStack.size()) ~ "- " ~ name ~ " : ");
		}

		//writeln("executiing functions... ids = " ~ to!string(ids));

		if ((ids.length>0) && (values is null)) {
			string funcName;
			if (name==null) funcName = "<user function>";
			else funcName = name;

			throw new ERR_FunctionCallErrorNotEnough(name,ids.length,0,true);
		}

		if ((ids.length>0) && (values !is null)) {
			if (values.type==aV) {
				 if (values.content.a.length!=ids.length) {
				 	string funcName;
					if (name==null) funcName = "<user function>";
					else funcName = name;

					if (ids.length>values.content.a.length) throw new ERR_FunctionCallErrorNotEnough(name,ids.length,values.content.a.length,true);
					else throw new ERR_FunctionCallErrorTooMany(name,ids.length,values.content.a.length,true);
				}
			} else {
				if (1!=ids.length) {
				 	string funcName;
					if (name==null) funcName = "<user function>";
					else funcName = name;

					if (ids.length>1) throw new ERR_FunctionCallErrorNotEnough(name,ids.length,1,true);
					else throw new ERR_FunctionCallErrorTooMany(name,ids.length,1,true);
				}
			}
			
		}

		if (values !is null) {
			if (values.type==aV) {
				foreach (i, string ident; ids) {
					Glob.varSet(ident, values.content.a[i], true, true);
				}	
			}
			else {
				if (ids.length==1) {
					Glob.varSet(ids[0], values, true, true);
				}
			}

			if (values !is null) {
				Glob.varSet(ARGS, values, false, true);
				if (Glob.trace) {
					if (values.type==aV)
						writeln(values.content.a.map!(v=>v.stringify()).array.join(", "));
				}
			}
		}
		
		//else Glob.varSet(ARGS, new Value(cast(Value[])([])));
			
		Value ret = block.execute();

		//writeln("** Func:execute (after) : name=" ~ name ~ ", retCounter=" ~ to!string(Glob.retCounter) ~ ", retStack=" ~ Glob.retStack.str());

		//int popped = Glob.retStack.pop();
		//writeln("POPPING STACK FROM FUNC!");
		Glob.contextStack.pop();

		//writeln("** \tretStack: popped " ~ to!string(popped));

		return ret;
	}

	Value execute(Expressions ex) {
		//Func* f = cast(Func*)(&this);
		//writeln("Executing: " ~ to!string(f));
		Value values = ex.evaluate(true);

		return execute(values);
	}

	Value executeMemoized(Expressions ex, string memo) {
		Value values = ex.evaluate(true);

		//writeln("Glob.memoized before: ");
		//writeln(Glob.memoized);

		string hsh = memo ~ "_" ~ values.hash();
		//writeln("Hash: " ~ hsh);

		if ((hsh in Glob.memoized) is null) {
			//writeln("memoized value not found, calculating");
			Value ret = execute(values);
			Glob.memoized[hsh] = ret;
			//writeln("stored: ");
			//writeln(Glob.memoized);
			return ret;
		}
		else {
			//writeln("memoized value found, returning");
			return Glob.memoized[hsh];
		}
	}

	string getAcceptedConstraintsDescription() {
		string[] acceptedConstraints = [];
		foreach (ValueType[] constraints; valueConstraints) {
			acceptedConstraints ~= constraints.map!(c => "" ~ c).array.join("/");
			debug writeln(constraints.map!(c => "" ~ c).array.join("/"));
		}
		return acceptedConstraints.join(" or ");
	}

	string getReturnValuesDescription() {
		return returnValues.map!(m => "" ~ m).array.join(" or ");
	}

	Value[] validate(Expressions ex) {
		if (ex.lst.length < minArgs) throw new ERR_FunctionCallErrorNotEnough(name, minArgs, ex.lst.length);
		if (ex.lst.length > maxArgs) throw new ERR_FunctionCallErrorTooMany(name, maxArgs, ex.lst.length);

		Value[] ret;
		//string[] retString;
		foreach (Expression e; ex.lst) {
			Value vv = e.evaluate();
			ret ~= vv;
			//retString ~= vv.stringify();
		}

		

		foreach (ValueType[] constraints; valueConstraints.filter!(c => c.length == ex.lst.length)) {
			bool passingConstraint = true;
			foreach (i, ValueType constraint; constraints) {
				if (constraint != xV) {
					if (constraint != ret[i].type) {
						passingConstraint = false;
					}
				}
			}
			if (passingConstraint) return ret;
		}
		/*
		string[] acceptedConstraints = [];
		foreach (ValueType[] constraints; valueConstraints) {
			acceptedConstraints ~= constraints.map!(c => "" ~ c).array.join("/");
			debug writeln(constraints.map!(c => "" ~ c).array.join("/"));
		}
	*/
		string givenTypes = ret.map!(c => "" ~ c.type).array.join("/");

		throw new ERR_FunctionCallConstraintsError(name,getAcceptedConstraintsDescription(),givenTypes);
	}

	Value validateValue(Expressions ex, int i, ValueType[] vts) {
		Value evaluated = ex.lst[i].evaluate();

		bool valueOK = false;

		foreach (ValueType vt; vts) {
			if (evaluated.type == vt) valueOK = true;
		}

		if (valueOK) return evaluated;
		else {
			throw new ERR_FunctionCallValueError(name, i, vts.map!(v => "" ~ v).array.join(" or "), evaluated.type);
		}
	}

	void inspect(bool full=false) {
		if (full) {
			writeln("  Function : \x1B[37m\x1B[1m" ~ name ~ "\x1B[0m");
			writeln("         # | " ~ description);
			writeln();
			writeln("     usage | " ~ name ~ " [" ~  getAcceptedConstraintsDescription() ~ "]");
			writeln("        -> | " ~  getReturnValuesDescription());
		}
		else {
			writeln("  " ~ leftJustify(name,20) ~ " [" ~ getAcceptedConstraintsDescription() ~ "] -> " ~ getReturnValuesDescription());
		}
	}
}