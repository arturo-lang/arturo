/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/csv.d
 *****************************************************************/

module art.csv;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.csv;
import std.file;
import std.process;
import std.stdio;
import std.string;
import std.xml;

import parser.expression;
import parser.expressions;
import parser.statements;

import func;
import globals;
import value;

// Functions

final class CSV__Parse_ : Func {
	this(string ns="") { super(ns ~ "parse","get object by parsing given CSV string, optionally using headers",[[sV],[sV,bV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		Value[] ret;

		bool hasHeaders = false;

		if (v.length==2) hasHeaders = B!(v,1);

		if (hasHeaders) {
			foreach (row; csvReader!(string[string], Malformed.ignore)(input,null)) {
				string[string] rowDict;
				foreach (k,v; row) {
					rowDict[k] = v;
				}
				ret ~= new Value(rowDict);
			}
		}
		else {
			foreach (row; csvReader!(string, Malformed.ignore)(input)) {
				ret ~= new Value(row.array);
			}
		}

		return new Value(ret);
	}
}
