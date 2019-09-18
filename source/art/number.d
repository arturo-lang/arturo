/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: art/number.d
 ************************************************/

module art.number;

// Imports

import std.conv;
import std.math;
import std.random;
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

// Utilities

string registerMathFunc(string func, string funcName = null) {
	string ff = func;
	if (funcName !is null) ff = funcName;
	return "
		class " ~ capitalize(func) ~ "_ : Func {
			this() { super(\"" ~ func ~ "\",\"get '" ~ func ~ "' for given number\",[[nV],[rV]],[rV]); }
			override Value execute(Expressions ex) {
				Value[] v = validate(ex);

				Value input = v[0];
				real n;

				switch (input.type) {
					case nV: n = to!real(I!(input)); break;
					case rV: n = R!(input); break;
					default: break;
				}

				real ret = std.math." ~ ff ~ "(n);

				return new Value(ret);
			}
		}";
}

// Functions

class Even_ : Func {
	this() { super("even","check if given number is even",[[nV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias num = I!(v,0);

		return new Value(num%2==0);
	}
}


class Odd_ : Func {
	this() { super("odd","check if given number is odd",[[nV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias num = I!(v,0);

		return new Value(num%2!=0);
	}
}


class Random_ : Func {
	this() { super("random","generate random number in given range (from..to)",[[nV,nV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias numFrom = I!(v,0);
		alias numTo = I!(v,0);

		long ret = uniform(numFrom,numTo);

		return new Value(ret);
	}
}

mixin(registerMathFunc("sin"));
mixin(registerMathFunc("cos"));
mixin(registerMathFunc("tan"));
mixin(registerMathFunc("sinh"));
mixin(registerMathFunc("cosh"));
mixin(registerMathFunc("tanh"));
mixin(registerMathFunc("asin"));
mixin(registerMathFunc("acos"));
mixin(registerMathFunc("atan"));
mixin(registerMathFunc("asinh"));
mixin(registerMathFunc("acosh"));
mixin(registerMathFunc("atanh"));

mixin(registerMathFunc("floor"));
mixin(registerMathFunc("ceil"));
mixin(registerMathFunc("round"));

mixin(registerMathFunc("ln","log"));
mixin(registerMathFunc("log10"));
mixin(registerMathFunc("exp"));
mixin(registerMathFunc("sqrt"));

