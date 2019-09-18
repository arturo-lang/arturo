/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: art/reflection.d
 ************************************************/

module art.reflection;

// Imports

import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import value;

import func;
import globals;

class Type_ : Func {
	this() { super("type","get type for given object",[[xV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		return new Value(v[0].type);
	}
}

class Object_ : Func {
	this() { super("object","get object for given symbol name",[[sV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias symbolName = S!(v,0);

		return Glob.varGet(symbolName);
	}
}

