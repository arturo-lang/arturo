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

import compiler;
import globals;
import panic;
import program;
import value;

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

enum ArgumentType
{
	stringArgument,
	numberArgument,
	booleanArgument,
	nullArgument,
	identifierArgument
}

union ArgumentContent
{
	Identifier i;
	Value v;
}

// Utilities

string formatString(string s) @safe pure nothrow {
	string f = s;

	if (f[0]=='"') { // double-quoted string
		f = chompPrefix(chomp(f,"\""),"\"");
		f = replace(f, "\\\"", "\"");
	}
	else {
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

// Functions

final class Argument {

	immutable ArgumentType type;
	ArgumentContent content;

	@disable this();

	this(Identifier iden) {
		type = ArgumentType.identifierArgument;
		content.i = iden;
	}

	this(string t, string v) {
		if (t=="string") {
			type = ArgumentType.stringArgument;
			content.v = new Value(formatString(v));
		}
		else if (t=="number") {
			type = ArgumentType.numberArgument;

			// real
			if (v.indexOf(".")!=-1) content.v = new Value(to!real(v));
			else {
				try {
					// long
					content.v = new Value(to!long(v));
				}
				catch (Exception ex) {
					// long overflow
					// let's store it as a BigInt Value
					content.v = new Value(v, true);
				}
			}
		}
		else if (t=="boolean") {
			type = ArgumentType.booleanArgument;
			if (v=="true") content.v = TRUEV;
			else content.v = FALSEV;
		}
		else if (t=="null") {
			type = ArgumentType.nullArgument;
			content.v = NULLV;
		}
	}

	bool isStringInterpolated() pure nothrow {
		if (type==sA) {
			if (content.v.content.s.indexOf("`")!=-1) return true;
			else return false;
		}
		else return false;
	}

	Value getValue() {
		if (type==iA) {
			Value symbolValue;

			if ((symbolValue = Glob.getSymbol(content.i)) !is null) return symbolValue;
			else throw new ERR_SymbolNotFound(content.i.getFullIdentifier());
		}
		else {
			/*if (isStringInterpolated()) {
				string interpol = content.v.content.s;

				string replacer(Captures!(string) m) {
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
				
				return new Value(finalString);
			}
			else*/ return content.v;
		}
	}
}
