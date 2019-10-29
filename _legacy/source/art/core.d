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
import context;
import func;
import globals;
import value;
import panic;

// Functions

final class And_ : Func {
	this(string ns="") { super(ns ~ "and","bitwise/logical AND",[[bV,bV],[nV,nV]],[bV,nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		if (v[0].type==bV) {
			foreach (Value condition; v) {
				if (!B!(condition)) return FALSEV;
			}

			return TRUEV;
		}
		else {
			alias num1 = I!(v,0);
			alias num2 = I!(v,1);

			return v[0]&v[1]; // new Value(num1 & num2);
		}
	}
}

final class Exec_ : Func {
	this(string ns="") { super(ns ~ "exec","execute given function with optional array of arguments",[[fV],[fV,vV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias func = F!(v,0);

		Value args = null;
		if (v.length>=2) {
			args = new Value(v[1..$]);
		}

		Value ret = func.execute(args,null,to!string(cast(void*)func));

		return ret;
	}
}

final class If_ : Func {
	this(string ns="") { super(ns ~ "if","if condition is true, execute given function - else optionally execute alternative function",[[bV,fV], [bV,fV,fV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
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
			else { return NULLV; }
		}
	}
}

final class Import_ : Func {
	this(string ns="") { super(ns ~ "import","import external source file from path",[[sV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
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

final class Inherit_ : Func {
	this(string ns="") { super(ns ~ "inherit","inherit existing final class/dictionary",[[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias symdef = S!(v,0);
		alias object = D!(v,1);

		Expressions symbolDefExs = Glob.getSymbolDef(symdef);

		if (symbolDefExs is null) return NULLV;

		Value ret = symbolDefExs.evaluate();
		
		foreach (string nm, Value va; object) {
			ret.setValueForDict(nm, va);
		}

		return ret;
	}
}

final class Input_ : Func {
	this(string ns="") { super(ns ~ "input","read line from stdin",[[]],[sV,xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		
		string input = readln();

		if (input !is null) return new Value(input);
		else return NULLV;
	}
}

final class Lazy_ : Func {
	this(string ns="") { super(ns ~ "lazy","get a lazy-evaluated expression",[[xV]],[fV]); }
	override Value execute(Expressions ex, string hId=null) {
		Statements sts = new Statements(new Statement(ex.lst[0]));
		return new Value(sts);
	}
}

final class Let_ : Func {
	this(string ns="") { super(ns ~ "let","force assign right-hand value to symbol using string name",[[sV,xV]],[]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias symbol = S!(v,0);
		Value value = v[1];

		Glob.setSymbol(new Identifier(symbol),value,true);
		
		return value;
	}
}

final class Log_ : Func {
	this(string ns="") { super(ns ~ "log","print value of given expression to screen, in a readable format",[[xV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value item = v[0];

		writeln(item.logify());

		return v[0];
	}
}

final class Loop_ : Func {
	this(string ns="") { super(ns ~ "loop","execute given function for each element in array or dictionary, or while condition is true",[[aV,fV],[dV,fV],[bV,fV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		switch (v[0].type) {
			case aV: 	// foreach <array>
						alias arr = A!(v,0);
						alias func = F!(v,1);

						Value ret;
						foreach (Value item; arr) 
							ret = func.execute(item);

						return ret;
			case dV:	// foreach <dictionary>
						alias dict = D!(v,0);
						alias func = F!(v,1);

						Value ret;
						foreach (string nm, Value va; dict) {
							ret = func.execute(new Value([new Value(nm),va]));
						}

						return ret;
			default:
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

final class Memoize_ : Func {
	this(string ns="") { super(ns ~ "memoize","get a memoized function",[[fV]],[fV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		Value ret = new Value(v[0]);
		Glob.memoize ~= to!string(cast(void*)ret.content.f);

		return ret;
	}
}

final class New_ : Func {
	this(string ns="") { super(ns ~ "new","copy given object and return a new duplicate one",[[sV],[sV,vV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias symdef = S!(v,0);

		Expressions symbolDefExs = Glob.getSymbolDef(symdef);

		if (symbolDefExs !is null) {
			Value ret = symbolDefExs.evaluate();

			if (ret.type==dV) {

				Value initFunc;
				if ((initFunc=ret.content.d.get("init",null)) !is null) {

					Func func = initFunc.content.f;

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
			return NULLV;
		}
	}
}

final class Not_ : Func {
	this(string ns="") { super(ns ~ "not","bitwise/logical NOT",[[bV],[nV]],[bV,nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		if (v[0].type==bV) {
			return (!B!(v,0) ? TRUEV : FALSEV);
		}
		else {
			//alias num = I!(v,0);

			return ~v[0]; // new Value(~num);
		}
	}
}

final class Or_ : Func {
	this(string ns="") { super(ns ~ "or","bitwise/logical OR",[[bV,bV],[nV,nV]],[bV,nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		if (v[0].type==bV) {
			foreach (Value condition; v) {
				if (B!(condition)) return TRUEV;
			}

			return FALSEV;
		}
		else {
			alias num1 = I!(v,0);
			alias num2 = I!(v,1);

			return v[0] | v[1]; // new Value(num1 | num2);
		}
	}
}

final class Panic_ : Func {
	this(string ns="") { super(ns ~ "panic","exit program printing given error message",[[sV]],[]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias msg = S!(v,0);

		throw new ERR_ProgramPanic(msg);
	}
}

final class Print_ : Func {
	this(string ns="") { super(ns ~ "print","print value of given expression to screen, optionally suppressing newlines",[[xV],[xV,bV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value item = v[0];

		if (v.length==2 && B!(v,1)) {
			item.doWrite(true);
			stdout.flush();
		}
		else {
			item.doWriteln(true);
		}

		/*
		if (v.length==2 && B!(v,1)) {
			if (item.type==sV) write(item.content.s);
			else write(item.stringify(true,true));
			stdout.flush();
		}
		else {
			if (item.type==sV) writeln(item.content.s);
			else writeln(item.stringify(true,true));
		}
		*/
		return v[0];
	}
}

final class Return_ : Func {
	this(string ns="") { super(ns ~ "return","return given value",[[xV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		debug writeln("Core::Return_ -> THROWING");
		throw new ReturnResult(v[0]);
	}
}

final class Trace_ : Func {
	this(string ns="") { super(ns ~ "trace","trace executing of given expression",[[xV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Glob.trace = true;
		Value[] v = validate(ex);
		Glob.trace = false;

		return v[0];
	}
}

final class Unuse_ : Func {
	this(string ns="") { super(ns ~ "unuse","stop using given namespace(s)",[[sV],[aV]],[]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		if (v[0].type==sV) {
			Glob.removeNamespaces([v[0].content.s]);
		}
		else {
			foreach (Value ns; v[0].content.a) {
				Glob.removeNamespaces([ns.content.s]);
			}
		}

		return NULLV;
	}
}

final class Use_ : Func {
	this(string ns="") { super(ns ~ "use","use given namespace(s)",[[sV],[aV]],[]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		if (v[0].type==sV) {
			Glob.addNamespaces([v[0].content.s]);
		}
		else {
			foreach (Value ns; v[0].content.a) {
				Glob.addNamespaces([ns.content.s]);
			}
		}

		return NULLV;
	}
}

final class Xor_ : Func {
	this(string ns="") { super(ns ~ "xor","bitwise/logical XOR",[[bV,bV],[nV,nV]],[bV,nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		if (v[0].type==bV) {
			alias condition1 = B!(v,0);
			alias condition2 = B!(v,1);

			if ((condition1 && !condition2) || (!condition1 && condition2)) return TRUEV;
			else return FALSEV;
		}
		else {
			alias num1 = I!(v,0);
			alias num2 = I!(v,1);

			return v[0]^v[1]; // new Value(num1 ^ num2);
		}
	}
}
