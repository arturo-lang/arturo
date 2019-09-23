/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/string.d
 *****************************************************************/

module art.string;

// Imports

import std.algorithm;
import std.array;
import std.ascii;
import std.conv;
import std.file;
import std.random;
import std.regex;
import std.stdio;
import std.string;
import std.uuid;

import parser.expression;
import parser.expressions;
import parser.statements;

import value;

import func;
import globals;

// Utilities

string isRegex(string s) {
	if (s[0]=='/' && s[$-1]=='/') return chomp(chompPrefix(s,"/"),"/");
	else return null;
}

// Functions

class Capitalize_ : Func {
	this() { super("capitalize","capitalize given string",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		return new Value(capitalize(input));
	}
}

class Char_ : Func {
	this() { super("char","get ASCII character from given char code",[[nV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias charCode = I!(v,0);

		Value ret = new Value(to!string(cast(char)charCode));

		return ret;
	}
}

class Characters_ : Func {
	this() { super("characters","get string characters as an array",[[sV]],[aV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		Value[] ret = input.split("").map!(s=> new Value(to!string(s))).array;

		return new Value(ret);
	}
}

class Ends__With_ : Func {
	this() { super("ends.with","check if string ends with given string",[[sV,sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias what = S!(v,1);

		return new Value(endsWith(input, what));
	}
}

class Is__Alpha_ : Func {
	this() { super("is.alpha","check if all characters in given string are ASCII letters",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isAlpha(cast(dchar)(ch[0]))) return new Value(false);

		return new Value(true);
	}
}

class Is__Alphanumeric_ : Func {
	this() { super("is.alphanumeric","check if all characters in given string are ASCII letters or digits",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isAlphaNum(cast(dchar)(ch[0]))) return new Value(false);

		return new Value(true);
	}
}

class Is__Control_ : Func {
	this() { super("is.control","check if all characters in given string are control characters",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isControl(cast(dchar)(ch[0]))) return new Value(false);

		return new Value(true);
	}
}

class Is__Digit_ : Func {
	this() { super("is.digit","check if all characters in given string are digits",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isDigit(cast(dchar)(ch[0]))) return new Value(false);

		return new Value(true);
	}
}

class Is__Lowercase_ : Func {
	this() { super("is.lowercase","check if all characters in given string are lowercase",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isLower(cast(dchar)(ch[0]))) return new Value(false);

		return new Value(true);
	}
}

class Is__Match_ : Func {
	this() { super("is.match","check if string matches given regex",[[sV,sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias patt = S!(v,1);

		string pattern;
		if (isRegex(patt) !is null) pattern = isRegex(patt);
		else pattern = patt;

		auto rx = regex(pattern,"gm");

		if (match(input,rx)) return new Value(true);
		else return new Value(false);
	}
}

class Is__Uppercase_ : Func {
	this() { super("is.uppercase","check if all characters in given string are uppercase",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isUpper(cast(dchar)(ch[0]))) return new Value(false);

		return new Value(true);
	}
}

class Is__Whitespace_ : Func {
	this() { super("is.whitespace","check if all characters in given string are whitespace",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isWhite(cast(dchar)(ch[0]))) return new Value(false);

		return new Value(true);
	}
}

class Levenshtein_ : Func {
	this() { super("levenshtein","get Levenshtein distance between two given strings",[[sV,sV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias str1 = S!(v,0);
		alias str2 = S!(v,1);

		auto ret = levenshteinDistance(str1,str2);

		return new Value(ret);
	}
}

class Lines_ : Func {
	this() { super("lines","get lines from string as an array",[[sV]],[aV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		Value[] ret = input.split("\n").map!(s=> new Value(to!string(s))).array;

		return new Value(ret);
	}
}

class Lowercase_ : Func {
	this() { super("lowercase","lowercase given string",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		return new Value(input.toLower);
	}
}

class Matches_ : Func {
	this() { super("matches","get array of matches for string using given regex",[[sV,sV]],[aV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias patt = S!(v,1);

		string pattern;
		if (isRegex(patt) !is null) pattern = isRegex(patt);
		else pattern = patt;

		auto rx = regex(pattern,"gm");

		Value[] ret = match(input,rx).map!(m=> new Value(m.hit)).array;

		return new Value(ret);
	}
}

class Pad__Center_ : Func {
	this() { super("pad.center","center justify string by adding padding",[[sV,nV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias padding = I!(v,1);

		auto ret = center(input,to!int(padding));

		return new Value(ret);
	}
}

class Pad__Left_ : Func {
	this() { super("pad.left","left justify string by adding padding",[[sV,nV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias padding = I!(v,1);

		auto ret = leftJustify(input,to!int(padding));

		return new Value(ret);
	}
}

class Pad__Right_ : Func {
	this() { super("pad.right","right justify string by adding padding",[[sV,nV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias padding = I!(v,1);

		auto ret = rightJustify(input,to!int(padding));

		return new Value(ret);
	}
}

class Replace__ : Func {
	this() { super("replace","get string by replacing occurences of string with another string",[[sV,sV,sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias what = S!(v,1);
		alias repl = S!(v,2);

		return new Value(input.replace(what,repl));
	}
}

class Split_ : Func {
	this() { super("split","split string by given separator or regex",[[sV,sV]],[aV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias separator = S!(v,1);

		Value[] ret;

		string pattern = isRegex(separator);
		if (pattern is null) {
			ret = input.split(separator).filter!(s=> s!="").map!(s=> new Value(s)).array;
		}
		else {
			auto rx = regex(pattern,"gm");
			ret = splitter(input, rx).array.filter!(s=> s!="").map!(s=> new Value(s)).array;
		}

		return new Value(ret);
	}
}

class Starts__With_ : Func {
	this() { super("starts.with","check if string starts with given string",[[sV,sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias what = S!(v,1);

		return new Value(startsWith(input, what));
	}
}

class Strip_ : Func {
	this() { super("strip","strip spaces from given string",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		return new Value(input.strip());
	}
}

class Uppercase_ : Func {
	this() { super("uppercase","uppercase given string",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		return new Value(input.toUpper);
	}
}

class Uuid_ : Func {
	this() { super("uuid","generate random UUID string",[[]],[sV]); }
	override Value execute(Expressions ex) {
		auto uuid = randomUUID();
		Xorshift192 gen;

		gen.seed(unpredictableSeed);
		auto genUuid = randomUUID(gen);

		return new Value(genUuid.toString());
	}
}

class Words_ : Func {
	this() { super("words","get words from string as an array",[[sV]],[aV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		Value[] ret = input.split().map!(s=> new Value(to!string(s))).array;

		return new Value(ret);
	}
}
