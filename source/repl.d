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

import helpers.terminal;

import parser.statements;

import globals;

import compiler;

import program;

import value;

import panic;
import versions;

// Constants

const string REPL_PROMPT            =   "\x1B[38;5;208m\x1B[1m$ :%s\x1B[0m\x1B[38;5;208m\x1B[1m>\x1B[0m ";

class ReplLineGetter : LineGetter {
    mixin LineGetterConstructors;

    string[] funcs = mixin(getSystemFuncsArray()); //["?info","?symbols","?functions","?clear","?help","?exit","acos","acosh","all","any","asin","asinh","atan","atanh","capitalize","ceil","characters","contains","cos","cosh","date.now","datetime.now","day","endsWith","exec","exp","file.exists","file.read","file.write","filter","first","floor","foreach","get","if","import","is.directory","is.file","is.match","is.symlink","json.generate","json.parse","justify.center","justify.left","justify.right","keys","last","lines","ln","log10","loop","lowercase","map","markdown","matches","max","md5","min","month","object","path.contents","path.create","path.current","path.directory","path.extension","path.filename","path.normalize","print","random","range","replace","return","reverse","round","set","sha256","sha512","shell","sin","sinh","size","sort","split","sqrt","startsWith","strip","tail","tan","tanh","time.now","to.number","trace","type","uppercase","uuid","web.read","words","xml.check","yaml.generate","yaml.parse"];
    override protected string[] tabComplete(in dchar[] candidate) {
        import std.file, std.conv, std.algorithm, std.string;
        const(dchar)[] soFar = candidate;
        auto idx = candidate.lastIndexOf(" ");
        if(idx != -1)
            soFar = candidate[idx + 1 .. $];

        string[] list;
        
        foreach(string name; funcs) {
            if(startsWith(name, soFar))
                list ~= text(candidate, name[soFar.length .. $]);
        }

        return list;
    }
}

// Functions

class Repl {

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
        writeln("?functions            show defined system functions");
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
        if (Glob.funcExists(id)) {
            Glob.funcGet(id).inspect(true);
        }
        else if (Glob.varGet(id) !is null) {
            Glob.varGet(id).inspect(true);
        }
        else {
            Panic.consoleError((new ERR_ConsoleIdentifierNotFoundError(id)).msg);
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

            /*
            bool commandReady = false;
            int leftbracks = 0;
            if (to!string(input[$-1])!="{") commandReady = true;
            else leftbracks = 1;

            while (!commandReady) {
                input ~= "\n";
                getter.prompt = "\x1B[38;5;208m\x1B[1m$ :" ~ format("%03s",lineCounter) ~ "\x1B[0m\x1B[38;5;208m\x1B[1m-\x1B[0m ";
                auto nextInput = strip(stdin.readln());

                if (to!string(nextInput[$-1])=="{") leftbracks += 1;
                if (to!string(nextInput[$-1])=="}") leftbracks -= 1;

                input ~= nextInput;

                if (leftbracks == 0) commandReady = true;
            }
            */
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
                    terminal.writeln(ret.stringify());

                    //ret.print();
                    //writeln("");
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