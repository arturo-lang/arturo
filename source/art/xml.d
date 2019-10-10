/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/xml.d
 *****************************************************************/

module art.xml;

// Imports

import std.algorithm;
import std.conv;
import std.file;
import std.process;
import std.stdio;
import std.string;
import std.xml;

import parser.expression;
import parser.expressions;
import parser.statements;

import value;

import func;
import globals;

// Functions

class XML__Check_ : Func {
	this(string ns="") { super(ns ~ "check","check integrity of XML input using given string",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		try {
			std.xml.check(input);
			return new Value(true);
		}
		catch (CheckException c) {
			return new Value(false);
		}
	}
}
