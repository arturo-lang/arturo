/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/number.d
 *****************************************************************/

module art.number;

// Imports

import core.bitop;

import std.algorithm;
import std.array;
import std.bigint;
import std.conv;
import std.math;
import std.random;
import std.range;
import std.stdio;
import std.string;
import std.traits;

import parser.expression;
import parser.expressions;
import parser.statements;

import compiler;
import func;
import globals;
import panic;
import value;

// Utilities

Unqual!T[] primeFactors(T)(in T number) pure nothrow
in {
    assert(number > 1);
} body {
    typeof(return) result;
    Unqual!T n = number;
 
    for (Unqual!T i = 2; n % i == 0; n /= i)
        result ~= i;
    for (Unqual!T i = 3; n >= i * i; i += 2)
        for (; n % i == 0; n /= i)
            result ~= i;
 
    if (n != 1)
        result ~= n;
    return result;
}

bool isPrime(ulong n) {
	if (n<2) return false;
	if (n==2 || n==3) return true;
	if (n%2==0) return false;

	for (auto x=3; x<=to!ulong(sqrt(to!real(n))); x+=2) {
		if (n%x==0) return false;
	}
	return true;
}

string registerMathFunc(string func, string funcName = null) {
	string ff = func;
	if (funcName !is null) ff = funcName;
	return "
		final class " ~ capitalize(func) ~ "_ : Func {
			this(string ns=\"\") { super(ns ~ \"" ~ func ~ "\",\"get '" ~ func ~ "' for given number\",[[nV],[rV]],[rV]); }
			override Value execute(Expressions ex, string hId=null) {
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

final class Even_ : Func {
	this(string ns="") { super(ns ~ "even","check if given number is even",[[nV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias num = I!(v,0);

		return new Value(num%2==0);
	}
}

final class Is__Prime_ : Func {
	this(string ns="") { super(ns ~ "isPrime","check if given number is prime (uses the Miller-Rabin algorithm)",[[nV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias num = I!(v,0);

		return new Value(isPrime(num));
	}
}

final class Odd_ : Func {
	this(string ns="") { super(ns ~ "odd","check if given number is odd",[[nV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias num = I!(v,0);

		return new Value(num%2!=0);
	}
}

final class Prime__Factors_ : Func {
	this(string ns="") { super(ns ~ "primeFactors","get list of prime factors for given number",[[nV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		Value ret;

		if (v[0].isBig) {
			ret = new Value(primeFactors(v[0].content.bi).array.map!(a => new Value(a)).array);
		}
		else {
			ret = new Value(primeFactors(v[0].content.i).array.map!(a => new Value(a)).array);
		}

		return ret;
	}
}


final class Random_ : Func {
	this(string ns="") { super(ns ~ "random","generate random number in given range (from..to)",[[nV,nV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias numFrom = I!(v,0);
		alias numTo = I!(v,1);

		long ret = uniform(numFrom,numTo);

		return new Value(ret);
	}
}

final class Shl_ : Func {
	this(string ns="") { super(ns ~ "shl","bitwise left shift",[[nV,nV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias num1 = I!(v,0);
		alias num2 = I!(v,1);

		return new Value(num1 << num2);
	}
}

final class Shr_ : Func {
	this(string ns="") { super(ns ~ "shr","bitwise right shift",[[nV,nV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias num1 = I!(v,0);
		alias num2 = I!(v,1);

		return new Value(num1 >> num2);
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

