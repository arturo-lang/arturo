/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/identifiers.d
 *****************************************************************/

module parser.identifiers;

// Imports

import core.memory;

import std.array;
import std.stdio;

import containers.dynamicarray;

import parser.identifier;

import value;

// C Interface

extern (C) {
	void* new_Identifiers() { return cast(void*)(new Identifiers()); }
	void add_Identifier(Identifiers i, Identifier iden) { GC.addRoot(cast(void*)i); i.add(iden); }
}

// Functions

final class Identifiers {

	DynamicArray!Identifier lst;

	this() {
	}

	void add(Identifier iden) {
		lst ~= iden;
	}

	string inspect() {
		string[] ret = [];
		foreach (Identifier id; lst) {
			ret ~= id.inspect();
		}
		return ret.join(", ");
	}

}