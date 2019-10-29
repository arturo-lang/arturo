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

import parser.expression;

import compiler;
import globals;
import panic;
import program;
import value;

// globals

__gshared Identifier ARGS_ID = new Identifier(ARGS);
__gshared Identifier THIS_ID = new Identifier(THIS);
__gshared Identifier PRINT_ID = new Identifier("print");

// C Interface

extern (C) {
	void* new_IdentifierWithId(char* t, int hsh) { return cast (void*)(getIdentifierForName(to!string(t), to!bool(hsh))); }//{ return cast(void*)(new Identifier(to!string(t), to!bool(hsh))); }

	void add_IdToIdentifier(char* s, Identifier iden) { GC.addRoot(cast(void*)iden); iden.add(to!string(s)); }
	void add_NumToIdentifier(char* l, Identifier iden) { GC.addRoot(cast(void*)iden); iden.add(to!string(l)); }
	void add_ExprToIdentifier(Expression e, Identifier iden) { GC.addRoot(cast(void*)iden); iden.add(cast(Expression)e); }
}

// Aliases

alias idPC = PathContentType.idPathContent;
alias numPC = PathContentType.numPathContent;
alias exprPC = PathContentType.exprPathContent;

__gshared Identifier[string] idTbl;

Identifier getIdentifierForName(string n, bool hsh) {
	if (n in idTbl) return idTbl[n];
	else return new Identifier(n,hsh);
}

// Definitions

enum PathContentType
{
	idPathContent,
	numPathContent,
	exprPathContent
}

union PathContent
{
	string id;
	long num;
	Expression expr;
}

// Functions

final class Identifier {
	PathContentType[] pathContentTypes;
	PathContent[] pathContents;
	string namespace;
	bool isHash;
	bool isSimple;
	string simpleId;

	@disable this();

	this(string s, bool hsh = false) {

		isSimple = true;
		string cleanstr = s;
		isHash = hsh;
		simpleId = s;
		/*
		if (s.indexOf(ARGS)!=-1) {
			auto m = matchFirst(s, regex(ARGS ~ "(?P<index>[0-9]+)"));
			if (m["index"]!=[]) {
				pathContentTypes = [ idPC,  numPC ];
				PathContent pc = { id:ARGS };
				PathContent nc = { num:to!int(m["index"]) };
				pathContents = [ pc, nc ];
				isSimple = false;
				simpleId = ARGS;
			}
			else {
				pathContentTypes = [ idPC ];
				PathContent pc = { ARGS };
				pathContents = [ pc ];
				simpleId = ARGS;
			}
		
		} 
		else {*/
			if (isHash) {
				cleanstr = cleanstr.replace("@","");
			}

			pathContentTypes = [ idPC ];
			PathContent pc = {cleanstr};
			pathContents = [ pc ];
			simpleId = cleanstr;
		/*}*/
	}

	void add(string s) {
		isSimple = false;
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
		isSimple = false;
		pathContentTypes ~= numPC;
		PathContent pc = {num:l};
		pathContents ~= pc;
	}

	void add(Expression e) {
		isSimple = false;
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

	string getJustId() {
		string ret = "";

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

		if (namespace is null) return ret.join(".");
		else return "[" ~ namespace ~ ":]" ~ ret.join(".");
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
