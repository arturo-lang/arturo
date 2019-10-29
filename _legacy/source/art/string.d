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
import std.uri;
import std.uuid;

import parser.expression;
import parser.expressions;
import parser.statements;

import func;
import globals;
import value;

// Utilities

enum ColorType {
    fgBlack = 30,
    fgRed,
    fgGreen,
    fgYellow,
    fgBlue,
    fgMagenta,
    fgCyan,
    fgWhite
}
 

enum ColorTypeStr : string {
    fgBlack = "black",
    fgRed = "red",
    fgGreen = "green",
    fgYellow = "yellow",
    fgBlue = "blue",
    fgMagenta = "magenta",
    fgCyan = "cyan",
    fgWhite = "white"
}
 
string getColoredString(string text, string ink) {
	ColorType ct;

	switch (ink) {
		case "black": ct=ColorType.fgBlack; break;
		case "red": ct=ColorType.fgRed; break;
		case "green": ct=ColorType.fgGreen; break;
		case "yellow": ct=ColorType.fgYellow; break;
		case "blue": ct=ColorType.fgBlue; break;
		case "magenta": ct=ColorType.fgMagenta; break;
		case "cyan": ct=ColorType.fgCyan; break;
		case "white": ct=ColorType.fgWhite; break;
		default: ct=ColorType.fgWhite; 
	}

    return "\033["
        ~ ct.to!int.to!string
        ~ "m"
        ~ text
        ~ "\033[0m";
}

string isRegex(string s) {
	if (s[0]=='/' && s[$-1]=='/') return chomp(chompPrefix(s,"/"),"/");
	else return null;
}

// Functions

final class Capitalize_ : Func {
	this(string ns="") { super(ns ~ "capitalize","capitalize given string",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		return new Value(capitalize(input));
	}
}

final class Char_ : Func {
	this(string ns="") { super(ns ~ "char","get ASCII character from given char code",[[nV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias charCode = I!(v,0);

		Value ret = new Value(to!string(cast(char)charCode));

		return ret;
	}
}

final class Characters_ : Func {
	this(string ns="") { super(ns ~ "characters","get string characters as an array",[[sV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		Value[] ret = input.split("").map!(s=> new Value(to!string(s))).array;

		return new Value(ret);
	}
}

final class Color_ : Func {
	this(string ns="") { super(ns ~ "color","get colored string using color",[[sV,sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias color = S!(v,1);

		string ret = getColoredString(input,color);

		return new Value(ret);
	}
}

final class Decode__URL_ : Func {
	this(string ns="") { super(ns ~ "decodeUrl","decode the given URL into a UTF-8 string url, optionally ignoring invalid characters",[[sV],[sV,bV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		if (v.length==2) {
			if (B!(v,1)) {
				return new Value(input.decode);
			}
			else {
				return new Value(input.decodeComponent);
			}
		}
		else {
			return new Value(input.decodeComponent);
		}
	}
}

final class Encode__URL_ : Func {
	this(string ns="") { super(ns ~ "encodeUrl","encode the given UTF-8 string url into a URL, optionally ignoring invalid characters",[[sV],[sV,bV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		
		if (v.length==2) {
			if (B!(v,1)) {
				return new Value(input.encode);
			}
			else {
				return new Value(input.encodeComponent);
			}
		}
		else {
			return new Value(input.encodeComponent);
		}
	}
}

final class Ends__With_ : Func {
	this(string ns="") { super(ns ~ "endsWith","check if string ends with given string",[[sV,sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias what = S!(v,1);

		return new Value(endsWith(input, what));
	}
}

final class Is__Alpha_ : Func {
	this(string ns="") { super(ns ~ "isAlpha","check if all characters in given string are ASCII letters",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isAlpha(cast(dchar)(ch[0]))) return FALSEV;

		return TRUEV;
	}
}

final class Is__Alphanumeric_ : Func {
	this(string ns="") { super(ns ~ "isAlphanumeric","check if all characters in given string are ASCII letters or digits",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isAlphaNum(cast(dchar)(ch[0]))) return FALSEV;

		return TRUEV;
	}
}

final class Is__Control_ : Func {
	this(string ns="") { super(ns ~ "isControl","check if all characters in given string are control characters",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isControl(cast(dchar)(ch[0]))) return FALSEV;

		return TRUEV;
	}
}

final class Is__Digit_ : Func {
	this(string ns="") { super(ns ~ "isDigit","check if all characters in given string are digits",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isDigit(cast(dchar)(ch[0]))) return FALSEV;

		return TRUEV;
	}
}

final class Is__Lowercase_ : Func {
	this(string ns="") { super(ns ~ "isLowercase","check if all characters in given string are lowercase",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isLower(cast(dchar)(ch[0]))) return FALSEV;

		return TRUEV;
	}
}

final class Is__Match_ : Func {
	this(string ns="") { super(ns ~ "isMatch","check if string matches given regex",[[sV,sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias patt = S!(v,1);

		string pattern;
		if (isRegex(patt) !is null) pattern = isRegex(patt);
		else pattern = patt;

		auto rx = regex(pattern,"gm");

		if (match(input,rx)) return TRUEV;
		else return FALSEV;
	}
}

final class Is__Uppercase_ : Func {
	this(string ns="") { super(ns ~ "isUppercase","check if all characters in given string are uppercase",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isUpper(cast(dchar)(ch[0]))) return FALSEV;

		return TRUEV;
	}
}

final class Is__Whitespace_ : Func {
	this(string ns="") { super(ns ~ "isWhitespace","check if all characters in given string are whitespace",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		foreach (ch; input.split(""))
			if (!isWhite(cast(dchar)(ch[0]))) return FALSEV;

		return TRUEV;
	}
}

final class Levenshtein_ : Func {
	this(string ns="") { super(ns ~ "levenshtein","get Levenshtein distance between two given strings",[[sV,sV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias str1 = S!(v,0);
		alias str2 = S!(v,1);

		auto ret = levenshteinDistance(str1,str2);

		return new Value(ret);
	}
}

final class Lines_ : Func {
	this(string ns="") { super(ns ~ "lines","get lines from string as an array",[[sV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		Value[] ret = input.split("\n").map!(s=> new Value(to!string(s))).array;

		return new Value(ret);
	}
}

final class Lowercase_ : Func {
	this(string ns="") { super(ns ~ "lowercase","lowercase given string",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		return new Value(input.toLower);
	}
}

final class Matches_ : Func {
	this(string ns="") { super(ns ~ "matches","get array of matches for string using given regex",[[sV,sV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias patt = S!(v,1);

		string pattern;
		if (isRegex(patt) !is null) pattern = isRegex(patt);
		else pattern = patt;

		auto rx = regex(pattern,"gm");

		auto matches = matchAll(input,rx);

		Value[] ret = matches.map!(m=> new Value(cast(string[])m.array)).array;
		return new Value(ret);

		//Value[] ret = match(input,rx).map!(m=> new Value(m.hit)).array;

		//return new Value(ret);

		//return new Value(match(input,rx).array);
	}
}

final class Pad__Center_ : Func {
	this(string ns="") { super(ns ~ "padCenter","center justify string by adding padding",[[sV,nV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias padding = I!(v,1);

		auto ret = center(input,to!int(padding));

		return new Value(ret);
	}
}

final class Pad__Left_ : Func {
	this(string ns="") { super(ns ~ "padLeft","left justify string by adding padding",[[sV,nV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias padding = I!(v,1);

		auto ret = leftJustify(input,to!int(padding));

		return new Value(ret);
	}
}

final class Pad__Right_ : Func {
	this(string ns="") { super(ns ~ "padRight","right justify string by adding padding",[[sV,nV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias padding = I!(v,1);

		auto ret = rightJustify(input,to!int(padding));

		return new Value(ret);
	}
}

final class Replace__ : Func {
	this(string ns="") { super(ns ~ "replace","get string by replacing occurences of string with another string",[[sV,sV,sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias what = S!(v,1);
		alias repl = S!(v,2);

		string ret;

		string pattern;
		if ((pattern=isRegex(what)) !is null) ret = input.replace(regex(pattern,"gm"),repl);
		else ret = input.replace(what,repl);

		return new Value(ret);
	}
}

final class Split_ : Func {
	this(string ns="") { super(ns ~ "split","split string by given separator or regex",[[sV,sV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
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

final class Starts__With_ : Func {
	this(string ns="") { super(ns ~ "startsWith","check if string starts with given string",[[sV,sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		alias what = S!(v,1);

		return new Value(startsWith(input, what));
	}
}

final class Strip_ : Func {
	this(string ns="") { super(ns ~ "strip","strip spaces from given string",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		return new Value(input.strip());
	}
}

final class Uppercase_ : Func {
	this(string ns="") { super(ns ~ "uppercase","uppercase given string",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		return new Value(input.toUpper);
	}
}

final class Uuid_ : Func {
	this(string ns="") { super(ns ~ "uuid","generate random UUID string",[[]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		auto uuid = randomUUID();
		Xorshift192 gen;

		gen.seed(unpredictableSeed);
		auto genUuid = randomUUID(gen);

		return new Value(genUuid.toString());
	}
}

final class Words_ : Func {
	this(string ns="") { super(ns ~ "words","get words from string as an array",[[sV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		Value[] ret = input.split().map!(s=> new Value(to!string(s))).array;

		return new Value(ret);
	}
}
