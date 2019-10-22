/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: repl.d
 *****************************************************************/

module repl;

// Imports

import core.memory;
import core.stdc.stdlib;

import std.array;
import std.ascii;
import std.conv;
import std.file;
import std.stdio;
import std.string;

import external.terminal;

import parser.identifier;
import parser.statements;

import compiler;
import func;
import globals;
import panic;
import program;
import value;
import versions;

// Constants

enum REPL_PROMPT            =   "\x1B[38;5;208m\x1B[1m$ :%s\x1B[0m\x1B[38;5;208m\x1B[1m>\x1B[0m ";

class ReplLineGetter : LineGetter {
    mixin LineGetterConstructors;

    override protected string[] tabComplete(in dchar[] candidate) {
        import std.file, std.conv, std.algorithm, std.string;
        const(dchar)[] soFar = candidate;
        auto idx = candidate.lastIndexOf(" ");
        if(idx != -1)
            soFar = candidate[idx + 1 .. $];

        string[] list;

        string[] autocompletionsArray = Glob.getAutocompletionsForRepl(); 
        
        foreach(string name; autocompletionsArray) {
            if(startsWith(name, soFar))
                list ~= text(candidate, name[soFar.length .. $]);
        }

        return list;
    }
}

// Functions

final class Repl {

    Compiler compiler;

    this() {
        compiler = new Compiler();
        Glob.isRepl = true;
    }

    void clearConsole() {
        system("clear");
    }
    
    void exitConsole() {
        writeln();
        writeln("# Exiting interactive console\n");
        exit(0);
    }

    void showHelp() {
        writeln("?info <id>            show infomation for given identifier");
        //writeln();
        writeln("?symbols              show defined symbols");
        writeln("?functions            show system functions");
        writeln();
        writeln("?read <file>          read source from file");
        writeln("?write <file>         write console buffer to file");
        writeln();
        writeln("?clear                clear console window");
        writeln("?help                 show this help page");
        writeln("?exit                 exit interactive console");
    }

    void readSourceFrom(string source) {
        Value ret = compiler.compileFromFile(source);
        write("=> ");
        writeln(ret.stringify());
    }

    void writeLinesTo(string[] ls, string filename) {
        string writeTo = filename;

        if (filename.indexOf(".art")==-1) writeTo ~= ".art";
    
        std.file.write(writeTo, ls.join("\n"));
    }

    void showInfo(string id) {

        Value va;

        if ((va = Glob.getSymbol(new Identifier(id))) is null) {
            Panic.consoleError((new ERR_ConsoleIdentifierNotFoundError(id)).msg);
        }
        else {

            if (va.type==fV) {
                va.content.f.inspect(id,true);
            }
            else {
                //Glob.globalContext._inspectSymbol(id,va,true);
            }
        }
    }
    void start() {
        string[] lines;
        int lineCounter = 1;

        auto terminal = Terminal(ConsoleOutputType.linear);
        auto getter = new ReplLineGetter(&terminal);

        getter.prompt = format(REPL_PROMPT, format("%03s",lineCounter));
        getter.history = [];

        showLogo(&terminal);
            
        terminal.writeln();
        terminal.writeln("# Launching interactive console; Rock on.");
        terminal.writeln("# Type '?help' for help on console commands\n");
  
        while (true) {
            auto input = strip(getter.getline());
            writeln();

            if (input.strip!="") {
            
                if (input.startsWith("?"))
                {
                    string[] parts = input.split(" ");
                    string cmd = parts[0];
                    switch (cmd) {
                        case "?info": parts.popFront(); showInfo(parts[0]); break;
                        case "?symbols": Glob.inspectSymbols(); break;
                        case "?functions": Glob.inspectFunctions(); break;
                        case "?read": parts.popFront(); readSourceFrom(parts[0]); break;
                        case "?write": parts.popFront(); writeLinesTo(lines,parts[0]); break;
                        case "?clear" : clearConsole(); break;
                        case "?help": showHelp(); break;
                        case "?exit": getter.dispose(); exitConsole(); break;
                        default: Panic.consoleError((new ERR_ConsoleCommandNotFoundError(cmd)).msg); break;
                    }
                }
                else {
                    lineCounter += 1;
                    lines ~= input;

                    getter.prompt = format(REPL_PROMPT, format("%03s",lineCounter));

                    Value ret = compiler.compileFromString(input);
                    terminal.write("=> ");
                    terminal.writeln(ret.stringify(true,true));
                }

            }
            else {
                lineCounter += 1;
                lines ~= "";

                getter.prompt = format(REPL_PROMPT, format("%03s",lineCounter));
            }

        }

    }
}