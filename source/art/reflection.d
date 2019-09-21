/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/reflection.d
 *****************************************************************/

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

import var;

// Functions

class Exists_ : Func {
	this() { super("exists","check if given symbol exists",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias symbolName = S!(v,0);

		if (Glob.varGet(symbolName) !is null) return new Value(true);
		else return new Value(false);
	}
}

class Object_ : Func {
	this() { super("object","get object for given symbol name",[[sV]],[xV,noV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias symbolName = S!(v,0);

		Var symbol = Glob.varGet(symbolName);

		if (symbol !is null) return symbol.value;
		else return new Value();
	}
}

class Type_ : Func {
	this() { super("type","get type for given object",[[xV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		return new Value(v[0].type);
	}
}
