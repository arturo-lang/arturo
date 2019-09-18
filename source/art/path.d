/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: art/path.d
 ************************************************/

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

class Is__File_ : Func {
	this() { super("is.file","check if given path is a file",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = path.isFile();

		return new Value(ret);
	}
}

class Is__Directory_ : Func {
	this() { super("is.directory","check if given path is a directory",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = path.isDir();

		return new Value(ret);
	}
}

class Is__Symlink_ : Func {
	this() { super("is.symlink","check if given path is a symlink",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = path.isSymlink();

		return new Value(ret);
	}
}

class Path__Filename_ : Func {
	this() { super("path.filename","get filename from given path",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = baseName(path);

		return new Value(ret);
	}
}

class Path__Create_ : Func {
	this() { super("path.create","create directory at given path",[[sV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		mkdir(path);

		return new Value(true);
	}
}

class Path__Directory_ : Func {
	this() { super("path.directory","get directory from given path",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = dirName(path);

		return new Value(ret);
	}
}

class Path__Extension_ : Func {
	this() { super("path.extension","get extension from given path",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = extension(path);

		return new Value(ret);
	}
}

class Path__Current_ : Func {
	this() { super("path.current","get current directory path",[[]],[sV]); }
	override Value execute(Expressions ex) {
		auto dirPath = getcwd();

		return new Value(dirPath);
	}
}

class Path__Contents_ : Func {
	this() { super("path.contents","get array of directory contents at given path",[[],[sV]],[aV]); }
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

class Path__Normalize_ : Func {
	this() { super("path.normalize","get normalized path from given path",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		auto ret = buildNormalizedPath(path);

		return new Value(ret);
	}
}
