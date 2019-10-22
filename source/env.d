/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: env.d
 *****************************************************************/

module env;

// Imports

import std.stdio;

import panic;
import value;

// Functions

final class Env {

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