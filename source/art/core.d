/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/core.d
 *****************************************************************/

module art.core;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

import parser.identifier;
import parser.expression;
import parser.expressions;
import parser.statement;
import parser.statements;

import compiler;

import value;

import func;
import globals;

import panic;

import var;

class And_ : Func {
	this(string ns="") { super(ns ~ "and","bitwise/logical AND",[[bV,bV],[nV,nV]],[bV,nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		if (v[0].type==bV) {
			foreach (Value condition; v) {
				if (!B!(condition)) return new Value(false);
			}

			return new Value(true);
		}
		else {
			alias num1 = I!(v,0);
			alias num2 = I!(v,1);

			return new Value(num1 & num2);
		}
	}
}

class Exec_ : Func {
	this(string ns="") { super(ns ~ "exec","execute given function with optional array of arguments",[[fV],[fV,vV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias func = F!(v,0);

		Value args = null;
		if (v.length>=2) {
			args = new Value(v[1..$]);
		}

		Value ret = func.execute(args);

		return ret;
	}
}

class If_ : Func {
	this(string ns="") { super(ns ~ "if","if condition is true, execute given function - else optionally execute alternative function",[[bV,fV], [bV,fV,fV]],[xV]); }
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
	this(string ns="") { super(ns ~ "import","import external source file from path",[[sV]],[xV]); }
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
	this(string ns="") { super(ns ~ "input","read line from stdin",[[]],[sV,xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		
		string input = readln();

		if (input !is null) return new Value(input);
		else return new Value();
	}
}

class Lazy_ : Func {
	this(string ns="") { super(ns ~ "lazy","get a lazy-evaluated expression",[[xV]],[fV]); }
	override Value execute(Expressions ex) {
		Statements sts = new Statements(new Statement(ex.lst[0]));
		return new Value(sts);
	}
}

class Loop_ : Func {
	this(string ns="") { super(ns ~ "loop","execute given function for each element in array or dictionary, or while condition is true",[[aV,fV],[dV,fV],[bV,fV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		if (v[0].type==aV) {
			// foreach <array>
			alias arr = A!(v,0);
			alias func = F!(v,1);

			Value ret;
			foreach (Value item; arr) 
				ret = func.execute(item);

			return ret;
		} 
		else if (v[0].type==dV) { 
			// foreach <dictionary>
			alias dict = D!(v,0);
			alias func = F!(v,1);

			Value ret;
			foreach (Var va; dict.variables) {
				ret = func.execute(new Value([new Value(va.name),va.value]));
			}

			return ret;
		} else { 
			// loop while
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
}

class Memoize_ : Func {
	this(string ns="") { super(ns ~ "memoize","get a memoized function",[[fV]],[fV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		Value ret = new Value(v[0]);
		Glob.memoize ~= to!string(&ret.content.f);

		return ret;
	}
}

class New_ : Func {
	this(string ns="") { super(ns ~ "new","copy given object and return a new duplicate one",[[sV],[sV,vV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		alias symdef = S!(v,0);

		Expressions symbolDefExs = Glob.getSymbolDef(symdef);

		if (symbolDefExs !is null) {
			Value ret = symbolDefExs.evaluate();

			if (ret.type==dV) {

				if (ret.content.d._varExists("init")) {

					Func func = ret.content.d._varGet("init").value.content.f;

					Value args = null;
					if (v.length>=2) {
						args = new Value(v[1..$]);
					}

					func.execute(args);
				}

			}

			return ret;
		}
		else {
			return new Value();
		}
	}
}

class Not_ : Func {
	this(string ns="") { super(ns ~ "not","bitwise/logical NOT",[[bV],[nV]],[bV,nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		if (v[0].type==bV) {
			return new Value(!B!(v,0));
		}
		else {
			alias num = I!(v,0);

			return new Value(~num);
		}
	}
}

class Or_ : Func {
	this(string ns="") { super(ns ~ "or","bitwise/logical OR",[[bV,bV],[nV,nV]],[bV,nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		if (v[0].type==bV) {
			foreach (Value condition; v) {
				if (B!(condition)) return new Value(true);
			}

			return new Value(false);
		}
		else {
			alias num1 = I!(v,0);
			alias num2 = I!(v,1);

			return new Value(num1 | num2);
		}
	}
}

class Panic_ : Func {
	this(string ns="") { super(ns ~ "panic","exit program printing given error message",[[sV]],[]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias msg = S!(v,0);

		throw new ERR_ProgramPanic(msg);
	}
}

class Print_ : Func {
	this(string ns="") { super(ns ~ "print","print value of given expression to screen, optionally suppressing newlines",[[xV],[xV,bV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];

		if (item.type==sV) write(item.content.s);
		else write(item.stringify);

		if (v.length==2) {
			if (!B!(v,1)) writeln();
		} else writeln();

		return v[0];
	}
}

class Return_ : Func {
	this(string ns="") { super(ns ~ "return","return given value",[[xV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		debug writeln("Core::Return_ -> THROWING");
		throw new ReturnResult(v[0]);
	}
}

class Shl_ : Func {
	this(string ns="") { super(ns ~ "shl","bitwise left shift",[[nV,nV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		alias num1 = I!(v,0);
		alias num2 = I!(v,1);

		return new Value(num1 << num2);
	}
}

class Shr_ : Func {
	this(string ns="") { super(ns ~ "shr","bitwise right shift",[[nV,nV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		alias num1 = I!(v,0);
		alias num2 = I!(v,1);

		return new Value(num1 >> num2);
	}
}

class Test_ : Func {
	this(string ns="") { super(ns ~ "test__","test function - dev only",[[sV]],[]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		
		Var va = Glob.varGet(input);

		if (va !is null) va.inspect();
		else writeln("variable not found");

		return new Value(666);
	}
}

class Trace_ : Func {
	this(string ns="") { super(ns ~ "trace","trace executing of given expression",[[xV]],[xV]); }
	override Value execute(Expressions ex) {
		Glob.trace = true;
		Value[] v = validate(ex);
		Glob.trace = false;

		return v[0];
	}
}

class Xor_ : Func {
	this(string ns="") { super(ns ~ "xor","bitwise/logical XOR",[[bV,bV],[nV,nV]],[bV,nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		if (v[0].type==bV) {
			alias condition1 = B!(v,0);
			alias condition2 = B!(v,1);

			if ((condition1 && !condition2) || (!condition1 && condition2)) return new Value(true);
			else return new Value(false);
		}
		else {
			alias num1 = I!(v,0);
			alias num2 = I!(v,1);

			return new Value(num1 ^ num2);
		}
	}
}
