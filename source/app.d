/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: app.d
 *****************************************************************/

import core.stdc.stdlib;

import std.array;
import std.conv;
import std.file;
import std.getopt;
import std.stdio;
import std.string;
import std.system;

import compiler;
import globals;
import panic;
import repl;
import value;
import versions;

// Interface

extern (C) void ART_Compile(char[] s) {
    Compiler comp = new Compiler();
    comp.compileFromString(to!string(s));
}

// Main

void main(string[] args) {
    string includePath;
    bool interactiveCmd;
    bool warnings;
    bool versionCmd;
    bool helpCmd;
    bool dev;

    try {
        auto cmdline = getopt(
            args,
            "include|i",    "Set include path", &includePath,
            "warnings|w",   "Turn warnings ON", &warnings,
            "console|c",    "Interactive console mode (REPL)", &interactiveCmd,
            "version|v",    "Show version information", &versionCmd,
            "dev|d",        "Show developer utility", &dev
        );

        if (cmdline.helpWanted) {
            showLogo();
            defaultGetoptPrinter("\nusage: arturo [options] filename [args] ...\n", cmdline.options);
            exit(0);
        }

        if (dev) {
            (new Globals([])).printSystemFunctionsForDocumentation(true);
            (new Globals([])).printSystemFunctionsForDocumentation(false);
            exit(0);
        }

        if (versionCmd) {
            showVersion();
            exit(0);
        }

        if (interactiveCmd) {
            Repl repl = new Repl(); 
            repl.start();
        } else {
            args.popFront();
            if (args.length>0) {
                auto input = args[0];

                if (!input.exists) throw new Exception("Cannot open file. Input file not found (" ~ input ~ ")");

                args.popFront();

                Compiler compiler = new Compiler(true, args);
                Value v = compiler.compileFromFile(input,includePath,warnings);
            }
            else {
                throw new Exception("Not enough arguments");
            }
        }

    }
    catch (Exception e) {
        writeln("arturo: " ~ e.msg);
        writeln("usage: arturo [options] filename [args] ...\n");
        writeln("try `arturo -h` for more information.");
        exit(0);
    }
    
}

/****************************************
  This is the end,
  my only friend, the end...
 ****************************************/