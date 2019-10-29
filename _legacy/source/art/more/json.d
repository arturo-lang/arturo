/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/json.d
 *****************************************************************/

module art.json;

// Imports

import std.conv;
import std.file;
import std.json;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import compiler;
import func;
import globals;
import panic;
import value;

// Utilities

Value parseJsonNode(JSONValue n)
{
	switch (n.type())
	{
		case JSONType.string 		: return new Value(n.str());
		case JSONType.integer 		: return new Value(n.integer());
		case JSONType.uinteger 		: return new Value(n.uinteger());
		case JSONType.float_ 		: return new Value(n.floating());
		case JSONType.array 		: {
			Value[] ret;

			foreach (JSONValue v; n.array()) 
				ret ~= parseJsonNode(v);

			return new Value(ret);
		}
		case JSONType.object 		: {
			Value[Value] ret;

			foreach (string k, JSONValue v; n.object()) {
				Value key = new Value(k);
				Value val = parseJsonNode(v);

				ret[key] = val;
			}

			return new Value(ret);
		}
		default : break;
	}

	return new Value(0);
}

JSONValue generateJsonValue(Value input)
{
	JSONValue ret;
	switch (input.type) {

		case ValueType.numberValue		:	ret = input.content.i; return ret;
		case ValueType.realValue		:	ret = input.content.r; return ret;
		case ValueType.stringValue		:	ret = input.content.s; return ret;
		case ValueType.booleanValue		:	ret = to!int(input.content.b); return ret;
		case ValueType.arrayValue		:	{
			JSONValue[] result;
			for (int i=0; i<input.content.a.length; i++)
				result ~= generateJsonValue(input.content.a[i]);
	
			ret = result;
			return ret;
		}
		case ValueType.dictionaryValue	: 	{
			JSONValue[string] result;
			foreach (string nm, Value va; input.content.d)
				result[nm] = generateJsonValue(va);

			ret = result;
			return ret;
		}
		default	: break;
	}

	return ret;
}

// Functions

final class Json__Generate_ : Func {
	this(string ns="") { super(ns ~ "generate","get JSON string from given object",[[xV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		JSONValue j = generateJsonValue(v[0]);
		string ret = j.toString();

		return new Value(ret);
	}
}

final class Json__Parse_ : Func {
	this(string ns="") { super(ns ~ "parse","get object by parsing given JSON string",[[sV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		JSONValue j = parseJSON(input);
		Value ret = parseJsonNode(j);

		return ret;
	}
}
