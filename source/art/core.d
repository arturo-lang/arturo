/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: art/core.d
 ************************************************/

module art.core;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statement;
import parser.statements;

import compiler;

import value;

import func;
import globals;

import panic;

class And_ : Func {
	this() { super("and","if all conditions are true, return true, otherwise return false",[[bV,bV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		foreach (Value condition; v) {
			if (!B!(condition)) return new Value(false);
		}

		return new Value(true);
	}
}

class Each_ : Func {
	this() { super("each","execute given function for each element in array or dictionary",[[aV,fV],[dV,fV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		if (v[0].type==aV) {
			alias arr = A!(v,0);
			alias func = F!(v,1);

			Value ret;
			foreach (Value item; arr) 
				ret = func.execute(item);

			return ret;
		} 
		else {
			alias dict = D!(v,0);
			alias func = F!(v,1);

			Value ret;
			foreach (Value key, Value item; dict)
				ret = func.execute(new Value([key,item]));

			return ret;
		}
	}
}

class Exec_ : Func {
	this() { super("exec","execute given function with optional array of arguments",[[fV],[fV,aV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias func = F!(v,0);

		Value args = null;
		if (v.length==2) 
			args = v[1];

		return func.execute(args);
	}
}

class If_ : Func {
	this() { super("if","if condition is true, execute given function - else optionally execute alternative function",[[bV,fV], [bV,fV,fV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias condition = B!(v,0);
		alias funcDo = F!(v,1);

		Func funcElse = null;
		if (v.length==3) 
			funcElse = F!(v,2);

		if (condition) {
			return funcDo.execute();
		}
		else {
			if (funcElse !is null) { return funcElse.execute(); }
			else { return new Value(); }
		}
	}
}

class Import_ : Func {
	this() { super("import","import external source file from path",[[sV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		string filePath = S!(v,0) ~	".art";
		string completeFilePath = null;

		foreach (string path; Glob.env.searchPaths()) {
			if ((path ~ "/" ~ filePath).exists) 
				completeFilePath = path ~ "/" ~ filePath;
		}

		if (completeFilePath !is null) {
			Compiler comp = new Compiler(false);
			return comp.compileImport(completeFilePath);
		}
		else throw new ERR_FileNotFound(filePath);
	}
}

class Input_ : Func {
	this() { super("input","read line from stdin",[[]],[sV,xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		
		string input = readln();

		if (input !is null) return new Value(input);
		else return new Value();
	}
}

class Lazy_ : Func {
	this() { super("lazy","get a lazy-evaluated expression",[[xV]],[fV]); }
	override Value execute(Expressions ex) {
		Statements sts = new Statements(new Statement(ex.lst[0]));
		return new Value(sts);
	}
}

class Loop_ : Func {
	this() { super("loop","while condition is true, execute given function",[[bV,fV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias func = F!(v,1);
		bool condition = B!(v,0);
		Value ret;
		while (condition) {
			ret = func.execute();

			Value conditionValue = validateValue(ex,0,[bV]);
			condition = B!(conditionValue);
		}

		return ret;
	}
}

class Memoize_ : Func {
	this() { super("memoize","get a memoized function",[[fV]],[fV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		Value ret = new Value(v[0]);
		//writeln("trying to memoize function: " ~ to!string(&ret.content.f));
		Glob.memoize ~= to!string(&ret.content.f);

		//Value[Value] vv;
		//Glob.memoized[to!string(&ret.content.f)] = new Value(vv);

		writeln(Glob.memoize);

		return ret;
	}
}

class Not_ : Func {
	this() { super("not","if the conditions is true, return false, otherwise return true",[[bV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		return new Value(!B!(v,0));
	}
}

class Or_ : Func {
	this() { super("or","if any one of the conditions is true, return true, otherwise return false",[[bV,bV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		foreach (Value condition; v) {
			if (B!(condition)) return new Value(true);
		}

		return new Value(false);
	}
}

class Print_ : Func {
	this() { super("print","print value of given expression to screen",[[xV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];

		if (item.type==sV) write(item.content.s);
		else write(item.stringify);

		writeln();

		return v[0];
	}
}

class Return_ : Func {
	this() { super("return","return given value",[[xV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		throw new ReturnResult(v[0]);
	}
}

class Trace_ : Func {
	this() { super("trace","trace executing of given expression",[[xV]],[xV]); }
	override Value execute(Expressions ex) {
		Glob.trace = true;
		Value[] v = validate(ex);
		Glob.trace = false;

		return v[0];
	}
}

class Xor_ : Func {
	this() { super("xor","if only one of the conditions is true, return true, otherwise return false",[[bV,bV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias condition1 = B!(v,0);
		alias condition2 = B!(v,1);

		if ((condition1 && !condition2) || (!condition1 && condition2)) return new Value(true);
		else return new Value(false);
	}
}
