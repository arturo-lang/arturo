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

bool isProbablePrime(in ulong n, in uint k=10) @safe {
    static ulong modPow(ulong b, ulong e, in ulong m)
    pure nothrow @safe @nogc {
        ulong result = 1;
        while (e > 0) {
            if ((e & 1) == 1)
                result = (result * b) % m;
            b = (b ^^ 2) % m;
            e >>= 1;
        }
        return result;
    }
 
    if (n < 2 || n % 2 == 0)
        return n == 2;
 
    ulong d = n - 1;
    ulong s = 0;
    while (d % 2 == 0) {
        d /= 2;
        s++;
    }
    assert(2 ^^ s * d == n - 1);
 
    outer:
    foreach (immutable _; 0 .. k) {
        immutable ulong a = uniform(2, n);
        ulong x = modPow(a, d, n);
        if (x == 1 || x == n - 1)
            continue;
        foreach (immutable __; 1 .. s) {
            x = modPow(x, 2, n);
            if (x == 1)
                return false;
            if (x == n - 1)
                continue outer;
        }
        return false;
    }
 
    return true;
}

string registerMathFunc(string func, string funcName = null) {
	string ff = func;
	if (funcName !is null) ff = funcName;
	return "
		class " ~ capitalize(func) ~ "_ : Func {
			this(string ns=\"\") { super(ns ~ \"" ~ func ~ "\",\"get '" ~ func ~ "' for given number\",[[nV],[rV]],[rV]); }
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
	this(string ns="") { super(ns ~ "even","check if given number is even",[[nV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias num = I!(v,0);

		return new Value(num%2==0);
	}
}

class Is__Prime_ : Func {
	this(string ns="") { super(ns ~ "isPrime","check if given number is prime (uses the Miller-Rabin algorithm)",[[nV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias num = I!(v,0);

		return new Value(isProbablePrime(num));
	}
}


class Odd_ : Func {
	this(string ns="") { super(ns ~ "odd","check if given number is odd",[[nV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias num = I!(v,0);

		return new Value(num%2!=0);
	}
}


class Random_ : Func {
	this(string ns="") { super(ns ~ "random","generate random number in given range (from..to)",[[nV,nV]],[nV]); }
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

