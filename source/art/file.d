/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/file.d
 *****************************************************************/

module art.file;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.path;
import std.stdio;
import std.string;
import std.typetuple;

import parser.expression;
import parser.expressions;
import parser.statements;

import func;
import globals;
import value;

// Functions

final class File__Exists_ : Func {
	this(string ns="") { super(ns ~ "exists","check if file exists at given path",[[sV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias filePath = S!(v,0);

		string path = Glob.env.fileFolder ~ "/" ~ filePath;

		return new Value(path.exists);
	}
}

final class File__Filesize_ : Func {
	this(string ns="") { super(ns ~ "filesize","get file size of file at given path",[[sV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias filePath = S!(v,0);
		
		string path = Glob.env.fileFolder ~ "/" ~ filePath;

		return new Value(getSize(path));
	}
}

final class File__Read_ : Func {
	this(string ns="") { super(ns ~ "read","read string from file at given path",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias filePath = S!(v,0);
		
		string path = Glob.env.fileFolder ~ "/" ~ filePath;

		return new Value(readText(path));
	}
}

final class File__Write_ : Func {
	this(string ns="") { super(ns ~ "write","write string to file at given path",[[sV,sV]],[noV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias filePath = S!(v,0);
		alias fileContent = S!(v,1);

		string path = Glob.env.fileFolder ~ "/" ~ filePath;

		std.file.write(path, fileContent);

		return NULLV;
	}
}
