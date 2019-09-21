/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/dictionary.d
 *****************************************************************/

module art.dictionary;

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

// Functions

class Has__Key : Func {
	this() { super("has.key","check if dictionary has key",[[dV,sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias dict = D!(v,0);
		alias key = S!(v,1);

		foreach (Value k, Value v; dict) {
			if (S!(k) == key) return new Value(true);
		}

		return new Value(false);
	}
}

class Keys : Func {
	this() { super("keys","get array of dictionary keys",[[dV]],[aV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias dict = D!(v,0);

		Value[] ret;
		foreach (Value key, Value val; dict)
			ret ~= key;

		return new Value(ret);
	}
}
