/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/convert.d
 *****************************************************************/

module art.convert;

// Imports

import std.bigint;
import std.conv;
import std.file;
import std.format;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import compiler;
import func;
import globals;
import panic;
import value;

// Functions

final class To__Bin_ : Func {
	this(string ns="") { super(ns ~ "toBin","convert given number to its corresponding binary string value",[[nV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias num =  I!(v,0);

		string ret = format("%b",num);

		return new Value(ret);
	}
}

final class To__Hex_ : Func {
	this(string ns="") { super(ns ~ "toHex","convert given number to its corresponding hexadecimal string value",[[nV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias num =  I!(v,0);

		string ret = format("%X",num);

		return new Value(ret);
	}
}

final class To__Number_ : Func {
	this(string ns="") { super(ns ~ "toNumber","convert given value to its corresponding number value",[[rV],[sV],[bV]],[nV,rV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		try {

			if (v[0].type==rV) {
				alias input = R!(v,0);

				return new Value(to!long(input));
			}
			else if (v[0].type==sV) {
				alias input = S!(v,0);

				if (input.indexOf(".")!=-1) return new Value(to!real(input));
				else return new Value(to!long(input));
			}
			else {
				alias input = B!(v,0);

				if (input) return new Value(1);
				else return new Value(0);
			}
		}
		catch (Exception ex) {
			if (v[0].type==sV) {
				alias input = S!(v,0);

				return new Value(BigInt(input));
			}
			else {
				return NULLV;
			}
		}
	}
}

final class To__Oct_ : Func {
	this(string ns="") { super(ns ~ "toOct","convert given number to its corresponding octal string value",[[nV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias num =  I!(v,0);

		string ret = format("%o",num);

		return new Value(ret);
	}
}

final class To__String_ : Func {
	this(string ns="") { super(ns ~ "toString","convert given number/boolean/array/dictionary to its corresponding string value",[[nV],[rV],[bV],[aV],[dV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		return new Value(v[0].stringify());
	}
}
