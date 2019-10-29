/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/html.d
 *****************************************************************/

module art.html;

// Imports

import std.algorithm;
import std.conv;
import std.file;
import std.process;
import std.stdio;
import std.string;
import std.xml;

import dmarkdown.markdown;

import parser.expression;
import parser.expressions;
import parser.statements;

import func;
import globals;
import value;

// Functions

final class Markdown__To__Html_ : Func {
	this(string ns="") { super(ns ~ "markdownToHtml","convert given markdown string to html",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		
		auto converted = filterMarkdown(input);

		return new Value(converted);
	}
}
