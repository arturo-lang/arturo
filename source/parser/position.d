/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/position.d
 *****************************************************************/

module parser.position;

// Imports

import std.conv;

// C Interface

extern (C) {
	void* new_Position(int l, char* f) { return cast(void*)(new Position(l,to!string(f))); }
}

// Functions

class Position {

	int line;
	string filename;

	this(int l, string f) {
		line = l;
		filename = f;
	}

	override string toString() {
		return "file: " ~ filename ~ ", line: " ~ to!string(line);
	}
}

