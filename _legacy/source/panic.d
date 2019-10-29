/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: panic.d
 *****************************************************************/

// Imports

import core.stdc.stdlib;

import std.array;
import std.conv;
import std.stdio;
import std.string;

import parser.position;

import globals;

// Constants

enum SPACER                                         = "               ";

enum PARSE_ERROR_POS_TEMPLATE                       = "\x1B[4;1;35mSyntax Error\x1B[0;32m   \x1B[1m@ File:\x1B[0;32m %s, \x1B[1mLine:\x1B[0;32m %d\x1B[0;37m\n" ~ 
                                                              SPACER ~ "\x1B[1m#\x1B[0;37m %s\n\n";
enum PARSE_ERROR_POS_TEMPLATE_REPL                  = "\x1B[4;1;35mSyntax Error\x1B[0;32m   " ~ 
                                                              "\x1B[1m#\x1B[0;37m %s";
enum RUNTIME_ERROR_POS_TEMPLATE                     = "\x1B[4;1;35mRuntime Error\x1B[0;32m  \x1B[1m@ File:\x1B[0;32m %s, \x1B[1mLine:\x1B[0;32m %d\x1B[0;37m\n" ~ 
                                                              SPACER ~ "\x1B[1m#\x1B[0;37m %s\n\n";
enum RUNTIME_ERROR_POS_TEMPLATE_REPL                = "\x1B[4;1;35mRuntime Error\x1B[0;32m  " ~ 
                                                              "\x1B[1m#\x1B[0;37m %s";
enum CONSOLE_ERROR_POS_TEMPLATE_REPL                = "\x1B[4;1;35mConsole Error\x1B[0;32m  " ~ 
                                                              "\x1B[1m#\x1B[0;37m %s\n\n" ~ 
                                                              SPACER ~ "  For more info type '?help'";

enum RUNTIME_WARNING_POS_TEMPLATE                   = "\x1B[4;1;36mW a r n i n g !\x1B[0;32m  " ~ 
                                                              "\x1B[1m#\x1B[0;37m %s";                                                              


enum GENERIC_ERROR_TEMPLATE                         = "\x1B[1;37m%s:\x1B[0;37m %s\n\n" ~ SPACER ~ "  %s";
enum GENERIC_ERROR_TEMPLATE_WITHOUT_DETAILS         = "\x1B[1;37m%s:\x1B[0;37m %s";
enum GENERIC_ERROR_TEMPLATE_WITHOUT_REFERENCE       = "\x1B[1;37m%s\x1B[0;37m\n\n" ~ SPACER ~ "  %s";

// C Interface

extern (C) {
    void panic_ParseError(char* m, char* f, int line) { Panic.parseError(to!string(m),to!string(f), line); }
}

// Utilities

string getErrorString(string msg, string symbol, string[] entryStrings, string[] entryValues) {
    string[] entriesArray = [];
    foreach (i, string entryString; entryStrings) {
        string entryValue = entryValues[i];
        if (entryValue=="") entriesArray ~= entryString;
        else {
            if (entryValue.indexOf(" or ")!=-1) {
                string formattedEntryValue = entryValue.split(" or ").join(" or \n" ~ SPACER ~ "    " ~ " ".replicate(entryString.length));
                formattedEntryValue = formattedEntryValue.replace(" or "," \x1B[1;37mor\x1B[0;37m ");
                entriesArray ~= format(entryString ~ ": %s",formattedEntryValue);
            }
            else entriesArray ~= format(entryString ~ ": %s", entryValue);
        }
    }

    if (entryStrings==[]) return format(GENERIC_ERROR_TEMPLATE_WITHOUT_DETAILS, msg, symbol);
    else {
        if (symbol is null) return format(GENERIC_ERROR_TEMPLATE_WITHOUT_REFERENCE, msg, entriesArray.join("\n  " ~ SPACER));
        else return format(GENERIC_ERROR_TEMPLATE, msg, symbol, entriesArray.join("\n  " ~ SPACER));
    }
}

// Functions

final class WARN_ErroneousParameterValueIgnored : Exception {
    this(string param, string value) {
        super( getErrorString("Erroneous parameter value will be ignored ", null,
            ["Parameter", "Value"],
            [param, value] )
        );
    }
}

final class WARN_AssignmentInsideExpression : Exception {
    this(string symbol) {
        super( getErrorString("Found assignment inside expression ", null,
            ["Symbol"],
            [symbol] )
        );
    }
}

final class ERR_FunctionNotFound : Exception {
    this(string symbol) {
        super( getErrorString("Function not found", symbol, [], []) );
    }
}

final class ERR_SymbolNotFound : Exception {
    this(string symbol) {
        super( getErrorString("Variable not found", symbol, [], []) );
    }
}

final class ERR_FileNotFound : Exception {
    this(string filePath) {
        super( getErrorString("File not found", filePath, [], []) );
    }
}

final class ERR_IndexNotFound : Exception {
    this(long index, string object) {
        super( getErrorString("Index out of range", to!string(index), ["Object"], [object]) );
    }

    this(string index, string object) {
        super( getErrorString("Key not found", index, ["Object"], [object]) );
    }
}

final class ERR_ArrayNotSortable : Exception {
    this(string object) {
        super( getErrorString("Array not sortable", null, ["Object"], [object]) );
    }
}

final class ERR_ObjectNotIndexable : Exception {
    this(string object, string index) {
        super( getErrorString("Object not indexable", null, ["Object", "Index"], [object, index]) );
    }
}

final class ERR_ExpectedValueTypeError : Exception {
    this(string funcName, string expected, string given) {
        super( getErrorString("Erroneous value type for", funcName,
            ["Expected", "Given"],
            [expected, given] )
        );
    } 
}

final class ERR_FunctionCallConstraintsError : Exception {
    this(string funcName, string expected, string given) {
        super( getErrorString("Erroneous argument types for function",funcName,
            ["Expected", "Given"],
            [expected, given] )
        );
    }
}

final class ERR_FunctionCallErrorNotEnough : Exception {
    this(string funcName, ulong minArgs, ulong curArgs, bool userFunc = false) {
        if (!userFunc) {
            super( getErrorString("Not enough arguments for function",funcName,
                ["Expected at least", "Given"],
                [to!string(minArgs), to!string(curArgs)] )
            );
        }
        else {
            super( getErrorString("Not enough arguments for function",funcName,
                ["Expected", "Given"],
                [to!string(minArgs), to!string(curArgs)] )
            );
        }
    }
}

final class ERR_FunctionCallErrorTooMany : Exception {
    this(string funcName, ulong maxArgs, ulong curArgs, bool userFunc = false) {
        if (!userFunc) {
            super( getErrorString("Too many arguments for function",funcName,
                ["Expected up to", "Given"],
                [to!string(maxArgs), to!string(curArgs)] )
            );
        }
        else {
            super( getErrorString("Too many arguments for function",funcName,
                ["Expected", "Given"],
                [to!string(maxArgs), to!string(curArgs)] )
            );
        }
    }
} 

final class ERR_ErroneousObjectTypeError : Exception {
    this(string funcName, string expected, string given) {
        super( getErrorString("Erroneous object type for ",funcName,
            ["Expected", "Given"],
            [expected, given] )
        );
    }
}

final class ERR_FunctionCallValueError : Exception {
    this(string funcName, int arg, string expected, string given) {
        super( getErrorString("Error calling function",funcName,
            ["Argument", "Expected", "Given"],
            [to!string(arg), expected, given] )
        );
    }
}

final class ERR_ModifyingImmutableVariableError : Exception {
    this(string id) {
        super( getErrorString("Trying to modify immutable variable",null,
            ["Identifier"],
            [id] )
        );
    }
}

final class ERR_CannotPerformAssignmentError : Exception {
    this(string id) {
        super( getErrorString("Could not perform assignment - perhaps variable doesn't exist?",null,
            ["Identifier"],
            [id] )
        );
    }
}

final class ERR_DatabaseError : Exception {
    this(string msg) {
        super( getErrorString("Database error",null,
            ["Message"],
            [msg] )
        );
    }
}

final class ERR_ConsoleCommandNotFoundError : Exception {
    this(string cmd) {
        super( getErrorString("Command not found",cmd,
            [],
            [] )
        );
    }
}

final class ERR_ConsoleIdentifierNotFoundError : Exception {
    this(string cmd) {
        super( getErrorString("Identifier not found",cmd,
            [],
            [] )
        );
    }
}

final class ERR_OperationNotPermitted : Exception {
    this(string operation, string arg1, string arg2) {
        super( getErrorString("Operation not permited",operation,
            ["Argument", "With"],
            [arg1, arg2] )
        );
    }
}

final class ERR_CannotCompareTypesError : Exception {
    this(string arg1, string arg2) {
        super( getErrorString("Cannot compare arguments of given types",null,
            ["Argument", "With"],
            [arg1, arg2] )
        );
    }
}

final class ERR_ProgramPanic : Exception {
    this(string msg) {
        super( getErrorString("Program panic",null,
            ["Message"],
            [msg] )
        );
    }
}

final class Panic
{
    static void parseError(string msg, string filename, int line) {
        writeln(msg);
        string[] expecting = msg.replace("syntax error, ", "").split(", expecting");
        string given = expecting[0].replace("unexpected","").strip();
        string expected = expecting[1].strip();

        if (!Glob.isRepl) {
            if (expected=="") writeln(format(PARSE_ERROR_POS_TEMPLATE, filename, line+1, getErrorString("Problem parsing source file",null,["Found"],[given])));
            else writeln(format(PARSE_ERROR_POS_TEMPLATE, filename, line+1, getErrorString("Problem parsing source file",null,["Expected","Found"],[expected,given])));

            exit(0);
        }
        else {
            if (expected=="") writeln(format(PARSE_ERROR_POS_TEMPLATE_REPL, getErrorString("Problem parsing input",null,["Found"],[given])));
            else writeln(format(PARSE_ERROR_POS_TEMPLATE_REPL, getErrorString("Problem parsing input",null,["Expected","Found"],[expected,given])));
        }
    }

    static void runtimeError(string msg, Position pos) {
        if (!Glob.isRepl) {
            writeln(format(RUNTIME_ERROR_POS_TEMPLATE, pos.filename, pos.line+1, msg));

            exit(0);
        }
        else {
            writeln(format(RUNTIME_ERROR_POS_TEMPLATE_REPL, msg));

            throw new Exception(msg);
        }
    }

    static void runtimeWarning(string msg) {
        if (Glob.warningsOn) {
            writeln(format(RUNTIME_WARNING_POS_TEMPLATE, msg));
        }
    }

    static void consoleError(string msg) {
        writeln(format(CONSOLE_ERROR_POS_TEMPLATE_REPL, msg));
    }
}

