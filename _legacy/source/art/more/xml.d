/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/xml.d
 *****************************************************************/

module art.xml;

// Imports

import std.algorithm;
import std.conv;
import std.file;
import std.process;
import std.stdio;
import std.string;
import std.xml;

import dxml.dom;

import parser.expression;
import parser.expressions;
import parser.statements;

import func;
import globals;
import value;

// Utilities

Value getNode(DOMEntity!string nd) {
	writeln("name: " ~ nd.name);
	if (nd.children.length>0) writeln("has children");
	if (nd.attributes.length>0) writeln("has attributes");
	
	foreach (DOMEntity!string item; nd.children) {
		if (item.children.length>0) getNode(item);
		else writeln(item);
	}
	return NULLV;
}

// Functions

final class XML__Test_ : Func {
	this(string ns="") { super(ns ~ "test","check integrity of XML input using given string",[[]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		auto xml = "<root>\n" ~
           "    <foo>some text<whatever/></foo>\n" ~
           "    <bar/>\n" ~
           "    <baz></baz>\n" ~
           "</root>";

        auto dom = parseDOM(xml);
        getNode(dom);
        //writeln(dom.children);

        return NULLV;
	}
}

final class XML__Check_ : Func {
	this(string ns="") { super(ns ~ "check","check integrity of XML input using given string",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		try {
			std.xml.check(input);
			return TRUEV;
		}
		catch (CheckException c) {
			return FALSEV;
		}
	}
}
