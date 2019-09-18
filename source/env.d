/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: env.d
 ************************************************/

module env;

// Imports

import std.stdio;

import value;

import panic;

// Functions

class Env {

	string currentFolder;
	string fileFolder;

	this() {

	}

	this(string cF, string fF) {
		currentFolder = cF;
		fileFolder = cF ~ "/" ~ fF;
	}

	string[] searchPaths() {
		return [currentFolder, fileFolder];
	}

	void inspect() {
		writeln("ENV::");
		writeln("currentFolder: " ~ currentFolder);
		writeln("fileFolder: " ~ fileFolder);
	}
}