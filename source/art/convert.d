/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: art/convert.d
 ************************************************/

module art.convert;

// Imports

import std.conv;
import std.file;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import compiler;

import value;

import func;
import globals;

import panic;

class To__String_ : Func {
	this() { super("to.string","convert given number/boolean/array/dictionary to its corresponding string value",[[nV],[rV],[bV],[aV],[dV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		return new Value(v[0].stringify());
	}
}

class To__Number_ : Func {
	this() { super("to.number","convert given value to its corresponding number value",[[rV],[sV],[bV]],[nV,rV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

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
}
