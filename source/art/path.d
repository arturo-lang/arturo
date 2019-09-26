/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/path.d
 *****************************************************************/

module art.path;

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

import value;

import func;
import globals;

// Functions

class Create__Dir_ : Func {
	this(string ns="") { super(ns ~ "createDir","create directory at given path",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		mkdir(path);

		return new Value(true);
	}
}

class Current__Dir_ : Func {
	this(string ns="") { super(ns ~ "currentDir","get current directory path",[[]],[sV]); }
	override Value execute(Expressions ex) {
		auto dirPath = getcwd();

		return new Value(dirPath);
	}
}

class Dir_ : Func {
	this(string ns="") { super(ns ~ "dir","get array of directory contents at given path",[[],[sV]],[aV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		string dirPath;

		if (v.length == 1) dirPath = S!(v,0);
		else dirPath = ".";

		string path = Glob.env.fileFolder ~ "/" ~ dirPath;

	    string[] files = std.file.dirEntries(path, SpanMode.shallow)
	        .filter!(a => a.isFile)
	        .map!(a => baseName(a.name))
	        .array;

	    Value[] ret;
	   	foreach (string f; files)
	   		ret ~= new Value(f);

	   	return new Value(ret);
	}
}

class Get__Dir_ : Func {
	this(string ns="") { super(ns ~ "getDir","get directory from given path",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = dirName(path);

		return new Value(ret);
	}
}

class Get__Ext_ : Func {
	this(string ns="") { super(ns ~ "getExt","get extension from given path",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = extension(path);

		return new Value(ret);
	}
}

class Get__Filename_ : Func {
	this(string ns="") { super(ns ~ "getFilename","get filename from given path",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = baseName(path);

		return new Value(ret);
	}
}

class Is__Directory_ : Func {
	this(string ns="") { super(ns ~ "isDirectory","check if given path is a directory",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = path.isDir();

		return new Value(ret);
	}
}

class Is__File_ : Func {
	this(string ns="") { super(ns ~ "isFile","check if given path is a file",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = path.isFile();

		return new Value(ret);
	}
}

class Is__Symlink_ : Func {
	this(string ns="") { super(ns ~ "isSymlink","check if given path is a symlink",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = path.isSymlink();

		return new Value(ret);
	}
}

class Normalize__Path_ : Func {
	this(string ns="") { super(ns ~ "normalizePath","get normalized path from given path",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = buildNormalizedPath(path);

		return new Value(ret);
	}
}
