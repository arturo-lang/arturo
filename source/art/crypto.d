/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/crypto.d
 *****************************************************************/

module art.crypto;

// Imports

import std.conv;
import std.digest.md;
import std.digest.sha;
import std.file;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import compiler;

import value;

import func;
import globals;

import panic;

// Functions

class Hash_ : Func {
	this(string ns="") { super(ns ~ "hash","get hash value for given value",[[xV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		return new Value(v[0].hash());
	}
}

class MD5_ : Func {
	this(string ns="") { super(ns ~ "md5","get MD5 hash of given string data",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto md5 = new MD5Digest();
		ubyte[] hash = md5.digest(input);
		string ret = toHexString(hash);

		return new Value(ret);
	}
}


class SHA256_ : Func {
	this(string ns="") { super(ns ~ "sha256","get SHA256 hash of given string data",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto sha256 = new SHA256Digest();
		ubyte[] hash = sha256.digest(input);
		string ret = toHexString(hash);

		return new Value(ret);
	}
}

class SHA512_ : Func {
	this(string ns="") { super(ns ~ "sha512","get SHA512 hash of given string data",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto sha512 = new SHA512Digest();
		ubyte[] hash = sha512.digest(input);
		string ret = toHexString(hash);

		return new Value(ret);
	}
}
