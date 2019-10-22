/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/net.d
 *****************************************************************/

module art.net;

// Imports

import std.conv;
import std.net.curl;

import parser.expressions;

import func;
import globals;
import value;

// Functions

final class Net__Post_ : Func {
	this(string ns="") { super(ns ~ "post","perform POST request using given URL and data",[[sV,sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias url = S!(v,0);
		alias data = S!(v,1);

		string contents = to!string(std.net.curl.post(url,data));

		return new Value(contents);
	}
}

final class Net__Download_ : Func {
	this(string ns="") { super(ns ~ "download","download string contents from webpage using given URL",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias url = S!(v,0);

		try {
			string contents = to!string(std.net.curl.get(url));
			return new Value(contents);
		}
		catch (Exception ex) {
			return NULLV;
		}
	}
}
