/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: art/html.d
 ************************************************/

module art.html;

// Imports

import std.algorithm;
import std.conv;
import std.file;
import std.process;
import std.stdio;
import std.string;
import std.xml;

import parser.expression;
import parser.expressions;
import parser.statements;

import vibe.textfilter.markdown;

import value;

import func;
import globals;

class Convert__Markdown_ : Func {
	this() { super("convert.markdown","convert given markdown string to html",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto converted = filterMarkdown(input);

		return new Value(converted);
	}
}
