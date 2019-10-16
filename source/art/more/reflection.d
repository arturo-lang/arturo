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

import parser.identifier;
import parser.expression;
import parser.expressions;
import parser.statements;

import value;

import func;
import globals;

import var;

// Functions

class Symbol__Exists_ : Func {
	this(string ns="") { super(ns ~ "symbolExists","check if given symbol exists",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias symbolName = S!(v,0);

		if (Glob.getSymbol(new Identifier(symbolName)) !is null) return new Value(true);
		else return new Value(false);
	}
}

class Object_ : Func {
	this(string ns="") { super(ns ~ "object","get object for given symbol name",[[sV]],[xV,noV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias symbolName = S!(v,0);

		Value symbolValue;

		if ((symbolValue = Glob.getSymbol(new Identifier(symbolName))) !is null) return symbolValue;
		else return new Value();
	}
}

class Pointer_ : Func {
	this(string ns="") { super(ns ~ "pointer","get pointer location for object",[[xV],[sV]]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		return new Value(to!string(cast(void*)v[0]));
	}
}

class Type_ : Func {
	this(string ns="") { super(ns ~ "type","get type for given object",[[xV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		return new Value(v[0].type);
	}
}

class Syms_ : Func {
	this(string ns="") { super(ns ~ "syms","get list of declared symbols",[[],[sV]]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		return new Value(Glob.inspectAllVars());
	}
}
