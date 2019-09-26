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
	void add_NumToIdentifier(char* l, Identifier iden) { GC.addRoot(cast(void*)iden); iden.add(to!int(to!string(l))); }
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
		writeln("IN IDENTIFIER constructor: " ~ cleanstr);
		pathContentTypes = [ idPC ];
		PathContent pc = {cleanstr};
		pathContents = [ pc ];
		//pathContents = [];
		//pathContents ~= {s};
		//pathContents = [  ];
	}

	void add(string s) {
		writeln("IN IDENTIFIER add: " ~ s);
		pathContentTypes ~= idPC;
		PathContent pc = {id:s};
		pathContents ~= pc;
	}

	void add(int l) {
		writeln("IN IDENTIFIER add: " ~ to!string(l));
		pathContentTypes ~= numPC;
		PathContent pc = {num:l};
		pathContents ~= pc;
	}

	void add(Expression e) {
		writeln("IN IDENTIFIER add: expr");
		pathContentTypes ~= exprPC;
		PathContent pc = {expr:e};
		pathContents ~= pc;
	}

	string getId() {
		return pathContents[0].id;
	}

	string inspect() {
		string[] ret = [];
		writeln("here");
		for (size_t i=0; i<pathContentTypes.length; i++) {
			PathContentType pct = pathContentTypes[i];
			PathContent pc = pathContents[i];

			ret ~= to!string(pct) ~ ":" ~ pc.id;
		}

		writeln("here");

		return ret.join(", ");
	}
}
