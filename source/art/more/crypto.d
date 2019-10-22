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

import std.base64;
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
import func;
import globals;
import panic;
import value;

// Functions

final class Encode__Base64_ : Func {
	this(string ns="") { super(ns ~ "encodeBase64","encode given object to base64",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		string encoded = Base64.encode(cast(ubyte[])input);

		return new Value(encoded);
	}
}

final class Decode__Base64_ : Func {
	this(string ns="") { super(ns ~ "decodeBase64","decode given object from base64",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto decoded = cast(string)Base64.decode(input);

		return new Value(decoded);
	}
}


final class Hash_ : Func {
	this(string ns="") { super(ns ~ "hash","get hash value for given value",[[xV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		return new Value(v[0].hash());
	}
}

final class MD5_ : Func {
	this(string ns="") { super(ns ~ "md5","get MD5 hash of given string data",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto md5 = new MD5Digest();
		ubyte[] hash = md5.digest(input);
		string ret = toHexString(hash);

		return new Value(ret);
	}
}


final class SHA256_ : Func {
	this(string ns="") { super(ns ~ "sha256","get SHA256 hash of given string data",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto sha256 = new SHA256Digest();
		ubyte[] hash = sha256.digest(input);
		string ret = toHexString(hash);

		return new Value(ret);
	}
}

final class SHA512_ : Func {
	this(string ns="") { super(ns ~ "sha512","get SHA512 hash of given string data",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto sha512 = new SHA512Digest();
		ubyte[] hash = sha512.digest(input);
		string ret = toHexString(hash);

		return new Value(ret);
	}
}
