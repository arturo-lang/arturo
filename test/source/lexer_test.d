/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: grammar/lexer.d
 *****************************************************************/

module grammar.lexer;

// Imports

import core.stdc.stdlib;

import std.algorithm;
import std.array;
import std.ascii;
import std.conv;
import std.datetime.stopwatch;
import std.stdio;
import std.string;

import containers.dynamicarray;

import panic;
import value;

enum TT : string {
    STRING = "STRING",
    ID = "ID",
    NULLV = "null",
    BOOLEAN = "boolean",
    HASH_ID = "@ID",
    NUMBER = "number",
    FLOAT = "float",
    PIPE = "|",
    IMPLIES = "->",
    EQ_OP = "=",
    LE_OP = "<=",
    GE_OP = ">=",
    LT_OP = "<",
    GT_OP = ">",
    NE_OP = "!=",
    PLUS_SG = "+",
    MINUS_SG = "-",
    MULT_SG = "*",
    DIV_SG = "/",
    MOD_SG = "%",
    POW_SG = "^",
    BEGIN_ARR = "#(",
    BEGIN_DICT = "#{",
    BEGIN_INLINE = "$(",
    DOT = ".",
    DOLLAR = "$",
    LPAREN = "(",
    RPAREN = ")",
    LCURLY = "{",
    RCURLY = "}",
    LSQUARE = "[",
    RSQUARE = "]",
    COMMA = ",",
    EXCL = "!",
    SEMICOLON = ";",
    TILDE = "~",
    NEW_LINE = "NEW_LINE",
    EOF = "<EOF>"
}

struct Token {
    TT type;
    string content;
}

/*
"~"                                                 { count(); return ID; }
":"                                                 { count(); return COLON; }
"#"                                                 { count(); return HASH; }
*/
/*

%%

\"(\\.|[^\\"])*\"                                   { count(); return STRING; }
'(\\.|[^\\'])+'                                     { count(); return STRING; }


"/*"                                                { BEGIN(C_COMMENT); }
<C_COMMENT>"*"                                     { BEGIN(INITIAL); }
<C_COMMENT>\n                                       { yylineno++; }
<C_COMMENT>.                                        { }

"//".*                                              { count();  }
"#!".*                                              { count(); }

"null"                                              { count(); return NULLV; }
"true"|"false"                                      { count(); return BOOLEAN; }


{LETTER}({LETTER_OR_MISC}|{DIGIT})*                 { count(); return ID; }
":"({LETTER_OR_MISC}|{DIGIT})*                      { count(); return ID; }
"@"({LETTER_OR_MISC}|{DIGIT})*                      { count(); return HASH_ID; }
{DIGIT}+                                            { count(); return NUMBER; }
{DIGIT}+\.{DIGIT}+                                  { count(); return FLOAT; }

"|"                                                 { count(); return PIPE; }
"->"                                                { count(); return IMPLIES; }

"="                                                 { count(); return EQ_OP; }
"<="                                                { count(); return LE_OP; }
">="                                                { count(); return GE_OP; }
"<"                                                 { count(); return LT_OP; }
">"                                                 { count(); return GT_OP; }
"!="                                                { count(); return NE_OP; }

"+"                                                 { count(); return PLUS_SG; }
"-"                                                 { count(); return MINUS_SG; }
"*"                                                 { count(); return MULT_SG; }
"/"                                                 { count(); return DIV_SG; }
"%"                                                 { count(); return MOD_SG; }
"^"                                                 { count(); return POW_SG; }

"#("                                                { count(); return BEGIN_ARR; }
"#{"                                                { count(); return BEGIN_DICT; }
"$("                                                { count(); return BEGIN_INLINE; }

"."                                                 { count(); return DOT; }

"$"                                                 { count(); return DOLLAR; }
"("                                                 { count(); return LPAREN; }
")"                                                 { count(); return RPAREN; }
"{"                                                 { count(); return LCURLY; }
"}"                                                 { count(); return RCURLY; }
"["                                                 { count(); return LSQUARE; }
"]"                                                 { count(); return RSQUARE; }
","                                                 { count(); return COMMA; }
"!"                                                 { count(); return EXCL; }
";"                                                 { count(); return SEMICOLON; }
"~"                                                 { count(); return TILDE; }

\n                                                  { count(); return NEW_LINE; }

[ \t\v\f]+                                          { count(); }
.                                                   { count(); } 
*/
// Functions

void errorify(string msg) {
    writeln("ERRORific: " ~ msg);
    //exit(0);
}

bool checkNext(char[] inp, ulong pos, char what) {
    return (pos < inp.length && inp[pos]==what);
}

DynamicArray!TT lex(string src) {

    DynamicArray!TT ret;
    auto result = benchmark!(delegate void (){
        char[] input = cast(char[])src;

        for (size_t i=0; i<input.length; i++) {
            char ch = input[i];

            if (ch=='"') {
                string c;
                while (i+1<input.length && input[i+1]!='"') {
                    i++;
                    c ~= input[i];
                }
                ret ~= TT.STRING;
                if (i+1<input.length) i++;
            } 
            else if (ch=='@') {
                string c; c ~= ch;
                while (i+1<input.length && (input[i+1].isAlphaNum || input[i+1]=='_' || input[i+1]==':')) {
                    c ~= input[i+1];
                    i++;
                }
                ret ~= TT.HASH_ID;
            }
            else if (ch.isAlpha || ch=='_' || ch=='&' || ch==':') {
                string c; c ~= ch;
                while (i+1<input.length && (input[i+1].isAlphaNum || input[i+1]=='_' || input[i+1]==':')) {
                    c ~= input[i+1];
                    i++;
                }
                switch (c) {
                    case "true": ret ~= TT.BOOLEAN; break;
                    case "false": ret ~= TT.BOOLEAN; break;
                    case "null": ret ~= TT.NULLV; break;
                    default: ret ~= TT.ID;
                }
            }
            else if (ch.isDigit) {
                string c; c ~= ch; 
                bool isFloat = false;
                while (i+1<input.length && (input[i+1].isDigit || input[i+1]=='.')) {
                    if (input[i+1]=='.') isFloat = true;
                    c ~= input[i+1];
                    i++;
                }
                if (isFloat) ret ~= TT.FLOAT;
                else ret ~= TT.NUMBER;
            }
            else {
                switch (ch) {
                    case '|': ret ~= TT.PIPE; break;
                    case '#': if (checkNext(input,i+1,'(')) { ret ~= TT.BEGIN_ARR; i++; }
                              else if (checkNext(input,i+1,'{')) { ret ~= TT.BEGIN_DICT; i++; }
                              else errorify("expected ( or }"); break;
                    case '$': if (checkNext(input,i+1,'(')) { ret ~= TT.BEGIN_INLINE; i++; }
                              else { ret ~= TT.DOLLAR; } break;
                    case '=': ret ~= TT.PLUS_SG; break;
                    case '<': if (checkNext(input,i+1,'=')) { ret ~= TT.LE_OP; i++; }
                              else { ret ~= TT.LT_OP; } break;
                    case '>': if (checkNext(input,i+1,'=')) { ret ~= TT.GE_OP; i++; }
                              else { ret ~= TT.GT_OP; } break;
                    case '!': if (checkNext(input,i+1,'=')) { ret ~= TT.NE_OP; i++; }
                              else { ret ~= TT.EXCL; } break;

                    case '+': ret ~= TT.PLUS_SG; break;
                    case '-': if (checkNext(input,i+1,'>')) { ret ~= TT.IMPLIES; i++; }
                              else ret ~= TT.MINUS_SG; break;
                    case '*': ret ~= TT.MULT_SG; break;
                    case '/': ret ~= TT.DIV_SG; break;
                    case '%': ret ~= TT.MOD_SG; break;
                    case '^': ret ~= TT.POW_SG; break;

                    case '.': ret ~= TT.DOT; break;
                    case '(': ret ~= TT.LPAREN; break;
                    case ')': ret ~= TT.RPAREN; break;
                    case '{': ret ~= TT.LCURLY; break;
                    case '}': ret ~= TT.RCURLY; break;
                    case '[': ret ~= TT.LSQUARE; break;
                    case ']': ret ~= TT.RSQUARE; break;
                    case ',': ret ~= TT.COMMA; break;
                    case ';': ret ~= TT.SEMICOLON; break;
                    case '~': ret ~= TT.TILDE; break;
                    case '\n': ret ~= TT.NEW_LINE; break;

                    default: break;
                }
            }
        }

    })(1);

    writeln("Time taken : " ~ to!string(cast(Duration)result[0]));
    return ret;
}