/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/identifier.d
 *****************************************************************/

module parser.identifier;

// Imports

import core.memory;

import std.stdio;
import std.conv;
import std.array;
import std.string;
import std.algorithm;
import std.regex;

import value;

import globals;

import panic;

import program;
import compiler;

import parser.expression;

import var;

// C Interface

extern (C) {
	void* new_IdentifierWithId(char* t) { return cast(void*)(new Identifier(to!string(t))); }

	void add_IdToIdentifier(char* s, Identifier iden) { GC.addRoot(cast(void*)iden); iden.add(to!string(s)); }
	void add_NumToIdentifier(char* l, Identifier iden) { GC.addRoot(cast(void*)iden); iden.add(to!string(l)); }
	void add_ExprToIdentifier(Expression e, Identifier iden) { GC.addRoot(cast(void*)iden); iden.add(cast(Expression)e); }
}

// Aliases

alias idPC = PathContentType.idPathContent;
alias numPC = PathContentType.numPathContent;
alias exprPC = PathContentType.exprPathContent;

// Definitions

enum PathContentType : string
{
	idPathContent = "id",
	numPathContent = "num",
	exprPathContent = "expr"
}

union PathContent
{
	string id;
	long num;
	Expression expr;
}

// Functions

class Identifier {
	PathContentType[] pathContentTypes;
	PathContent[] pathContents;
	string namespace;

	this(string s) {
		string cleanstr = s;
		if (s.indexOf(":")!=-1) {
			string[] parts = s.split(":");
			namespace = parts[0];
			cleanstr = parts[1];
		}
		else {
			namespace = null;
		}

		if (s.indexOf(ARGS)!=-1) {
			auto m = matchFirst(s, regex(ARGS ~ "(?P<index>[0-9]+)"));
			if (m["index"]!=[]) {
				pathContentTypes = [ idPC,  numPC ];
				PathContent pc = { id:ARGS };
				PathContent nc = { num:to!int(m["index"]) };
				pathContents = [ pc, nc ];
			}
			else {
				pathContentTypes = [ idPC ];
				PathContent pc = { ARGS };
				pathContents = [ pc ];
			}
		
		} 
		else {
			pathContentTypes = [ idPC ];
			PathContent pc = {cleanstr};
			pathContents = [ pc ];
		}
	}

	void add(string s) {
		if (isNumeric(s)) {
			if (s.indexOf(".")!=-1) {
				string[] parts = s.split(".");

				foreach (part; parts) {
					add(to!int(part));
				}
			}
			else {
				add(to!int(s));
			}
		}
		else {
			pathContentTypes ~= idPC;
			PathContent pc = {id:s};
			pathContents ~= pc;
		}
	}

	void add(int l) {
		pathContentTypes ~= numPC;
		PathContent pc = {num:l};
		pathContents ~= pc;
	}

	void add(Expression e) {
		pathContentTypes ~= exprPC;
		PathContent pc = {expr:e};
		pathContents ~= pc;
	}

	Identifier getIdentifierRoot() {
		Identifier ret = new Identifier(pathContents[0].id);

		ret.namespace = namespace;

		for (size_t i=1; i<pathContentTypes.length-1; i++) {
			PathContentType pct = pathContentTypes[i];
			PathContent pc = pathContents[i];

			ret.pathContents ~= pc;
			ret.pathContentTypes ~= pct;
		}

		return ret;
	}

	string getId() {
		string ret = "";

		if (namespace !is null) ret ~= namespace ~ ":";
		ret ~= pathContents[0].id;
		
		return ret;
	}

	string getFullIdentifier() {
		string[] ret;

		for (size_t i=0; i<pathContentTypes.length; i++) {
			PathContentType pct = pathContentTypes[i];
			PathContent pc = pathContents[i];

			switch (pct) {
				case idPC: ret ~= pc.id;  break;
				case numPC: ret ~= to!string(pc.num); break;
				case exprPC: ret ~= "[" ~ pc.expr.evaluate().stringify() ~ "]"; break;
				default: break;
			}
		}

		return ret.join(".");
	}

	string inspect() {
		string[] ret = [];

		for (size_t i=0; i<pathContentTypes.length; i++) {
			PathContentType pct = pathContentTypes[i];
			PathContent pc = pathContents[i];
			switch (pct) {
				case idPC: ret ~= to!string(pct) ~ ":" ~ pc.id;  break;
				case numPC: ret ~= to!string(pct) ~ ":" ~ to!string(pc.num); break;
				case exprPC: ret ~= to!string(pct) ~ ":" ~ pc.expr.evaluate().stringify(); break;
				default: break;
			}
		}

		return ret.join(", ");
	}
}
