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

import globals;
import env;

import program;

import panic;

import value;

// C Interface

extern (C) struct yy_buffer_state;
extern (C) int yyparse();
extern (C) yy_buffer_state* yy_scan_string(const char*);
extern (C) yy_buffer_state* yy_scan_buffer(char *, size_t);
extern (C) extern __gshared FILE* yyin;
extern (C) extern __gshared const(char)* yyfilename;
extern (C) extern __gshared int yycgiMode;
extern (C) extern __gshared int yylineno;
extern (C) __gshared void* _program;

Program sourceTree;

// Functions

class Compiler {

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
            else return new Value();
        }
        catch (Exception e)
        {
            return new Value();
        }
    }

    Value compileFromFile(string source) {
        Glob.env = new Env(getcwd(), dirName(source));
        string input = readText(source) ~ "\n";

        yylineno = 0;

        try {
            yyfilename = toStringz(source);
            yy_scan_buffer(cast(char*)(toStringz(input~'\0')),input.length+2);
            yyparse();

            sourceTree = cast(Program)(_program);
            //debug inspect();
            Value v = sourceTree.execute();
            //debug Glob.inspect();

            return v;
        }
        catch (Exception e) {
            //debug writeln("caught exception (compiler level): " ~ e.msg);
        }
        return new Value(0);
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
        Glob.inspect();
    }
}