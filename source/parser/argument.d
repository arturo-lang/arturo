/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/argument.d
 *****************************************************************/

module parser.argument;

// Imports

import std.stdio;
import std.conv;
import std.array;
import std.string;
import std.algorithm;
import std.regex;

import parser.identifier;

import value;

import globals;

import panic;

import program;
import compiler;

import var;

// C Interface

extern (C) {
	void* new_Argument(char* t, char* v) { return cast(void*)(new Argument(to!string(t),to!string(v))); }
	void* new_ArgumentFromIdentifier(Identifier iden) { return cast(void*)(new Argument(iden)); }
	int argument_Interpolated(void* a) { return (cast(Argument)(a)).isStringInterpolated(); }
}

// Aliases

alias sA = ArgumentType.stringArgument;
alias nA = ArgumentType.numberArgument;
alias iA = ArgumentType.identifierArgument;
alias bA = ArgumentType.booleanArgument;
alias xA = ArgumentType.nullArgument;

// Definitions

enum ArgumentType : string
{
	stringArgument = "string",
	numberArgument = "number",
	booleanArgument = "boolean",
	nullArgument = "null",
	identifierArgument = "identifier"
}

// C Interface
/*
extern (C) struct yy_buffer_state;
extern (C) int yyparse();
extern (C) yy_buffer_state* yy_scan_string(const char*);
extern (C) yy_buffer_state* yy_scan_buffer(char *, size_t);
extern (C) extern __gshared FILE* yyin;
extern (C) extern __gshared const(char)* yyfilename;
extern (C) extern __gshared int yycgiMode;
extern (C) extern __gshared int yylineno;*/
//extern (C) __gshared void* _program;

// Functions

class Argument {

	ArgumentType type;
	Value value;
	Identifier identifier;

	this(Identifier iden) {
		//writeln("In argument constructor");
		type = ArgumentType.identifierArgument;
		identifier = iden;
		//writeln("AFTER");
	}

	this(string t, string v) {
		debug writeln("NEW argument (type: " ~ t ~ ", value: " ~ v ~ ")");

		if (t=="string") {
			type = ArgumentType.stringArgument;
			value = new Value(formatString(v));
		}
		else if (t=="number") {
			type = ArgumentType.numberArgument;
			if (v.indexOf(".")!=-1) value = new Value(to!real(v));
			else {
				try {
					value = new Value(to!long(v));
				}
				catch (Exception ex) {
					// long overflow
					// let's store it as a BigInt Value
					value = new Value(v, true);
				}
			}
		}
		else if (t=="boolean") {
			type = ArgumentType.booleanArgument;
			if (v=="true") value = new Value(true);
			else value = new Value(false);
		}
		else if (t=="null") {
			type = ArgumentType.nullArgument;
			value = new Value();
		}
		else {
			type = ArgumentType.identifierArgument;
			if (v.indexOf(ARGS)!=-1) {
				//writeln("found ARGS");
				auto m = matchFirst(v, regex(ARGS ~ "(?P<index>[0-9]+)"));
				//writeln(m);
				if (m["index"]!=[]) {
					//writeln(".. with shortcut:" ~ v);
					value = new Value(ARGS ~ "." ~ m["index"]);
				}
				else {
					//writeln(".. without shortcut");
					value = new Value(v);
				}
			
			}
			else value = new Value(v);
		}
	}

	bool isStringInterpolated() {
		if (type==ArgumentType.stringArgument) {
			if (value.content.s.indexOf("`")!=-1) return true;
			else return false;
		}
		else return false;
	}

	Value getValue() {
		if (type==ArgumentType.identifierArgument) {
			Var symbol = Glob.varGetByIdentifier(identifier);

			if (symbol !is null) return symbol.value;
			else throw new ERR_SymbolNotFound(identifier.getFullIdentifier());
		}
		else {
			
			if (isStringInterpolated()) {
				string interpol = value.content.s;

				string replacer(Captures!(string) m)
    			{
    				_program = cast(void*)(new Program());
       		 		yy_scan_buffer(cast(char*)(toStringz(m.hit~'\0')),m.hit.length+2);
					int parseResult = yyparse();
					if (parseResult==0) {
						Program subprogram = cast(Program)(_program);
						Value v = subprogram.execute();
						return v.stringify(false);  // false: strings without double-quotes
					}
					else return "";
    			}
    
    			string finalString = replaceAll!(replacer)(interpol,regex("`([^`]+)`"));
				value = new Value(finalString);
				return value;
			}
			else return value;
		}
	}

	string formatString(string s)
	{
		string f = s;

		if (f[0]=='"') // double-quoted
		{
			f = chompPrefix(chomp(f,"\""),"\"");
			f = replace(f, "\\\"", "\"");
		}
		else
		{
			f = chompPrefix(chomp(f,"'"),"'");
			f = replace(f, "\\'", "'");
		}

		f = replace(f, "\\t", "\t");
		f = replace(f, "\\n", "\n");
		f = replace(f, "\\x1B", "\x1B");

		f = replace(f, "\\1", "\1");
		f = replace(f, "\\2", "\2");
		f = replace(f, "\\3", "\3");

		return f;
	}

	void inspect() {
		writeln("\targument (type: " ~ type ~ ", value: " ~ value.toString() ~ ")");
	}
}
