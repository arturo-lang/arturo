/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: compiler.d
 *****************************************************************/

module compiler;

// Imports

import core.memory;
import core.stdc.stdlib;

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.regex;
import std.stdio;
import std.string;

import parser.argument;
import parser.expression;
import parser.expressions;
import parser.statement;
import parser.statements;

import env;
import globals;
import panic;
import program;
import value;

// C Interface

extern (C) struct yy_buffer_state;
extern (C) int yyparse();
extern (C) yy_buffer_state* yy_scan_string(const char*);
extern (C) void yy_delete_buffer(yy_buffer_state*);
extern (C) yy_buffer_state* yy_scan_buffer(char *, size_t);
extern (C) int yylex_destroy();
extern (C) extern __gshared FILE* yyin;
extern (C) extern __gshared const(char)* yyfilename;
extern (C) extern __gshared int yycgiMode;
extern (C) extern __gshared int yylineno;
extern (C) __gshared void* _program;

Program sourceTree;

// Functions

final class Compiler {

    this(bool main=true, string[] args = []) {
        _program = cast(void*)(new Program());
        if (main) Glob = new Globals(args);
    }

    Value compileFromString(string str) {
        string input = str ~ "\n";

        yylineno = 0;

        try 
        {
            yy_scan_buffer(cast(char*)(toStringz(input~'\0')),input.length+2);
            int parseResult = yyparse();

            if (parseResult==0) {
                sourceTree = cast(Program)(_program);
                //debug inspect();
                return sourceTree.execute();
            }
            else return NULLV;
        }
        catch (Exception e)
        {
            return NULLV;
        }
    }

    Value compileFromFile(string source, string includePath = null, bool warningsOn = false) {
        Glob.env = new Env(getcwd(), dirName(source));
        Glob.warningsOn = warningsOn;
        //writeln("=================================");
        //writeln("Before: " ~ readText(source));
        string preprocessed = readText(source);
        /*
        if (includePath) {
            //writeln("IncludePath: " ~ includePath);
            preprocessed = external.warp.omain.start(["",source,"--I",includePath]);
        }
        else {
            preprocessed = external.warp.omain.start(["",source]);
        }*/
        //writeln("=================================");
        //writeln("After: " ~ preprocessed);
        string input = preprocessed ~ "\n";

        //writeln(input);
        //string input = readText(source) ~ "\n";

        yylineno = 0;

        try {
            yyfilename = toStringz(source);
            yy_buffer_state* flex_buf = yy_scan_buffer(cast(char*)(toStringz(input~'\0')),input.length+2);
            yyparse();
            yy_delete_buffer(flex_buf);
            yylex_destroy();

            sourceTree = cast(Program)(_program);
            //debug inspect();
            Value v = sourceTree.execute();
            //debug Glob.inspect();
            return v;
        }
        catch (Exception e) {
            //debug writeln("caught exception (compiler level): " ~ e.msg);
        }
        return NULLV;
    }

    Value compileImport(string source) {
        string input = readText(source) ~ "\n";

        yylineno = 0;

        yy_scan_buffer(cast(char*)(toStringz(input~'\0')),input.length+2);
        yyparse();

        sourceTree = cast(Program)(_program);
        Value v = sourceTree.execute();
        
        return v;
    }

    void inspect() {
        sourceTree.inspect();
        //Glob.inspect();
    }
}