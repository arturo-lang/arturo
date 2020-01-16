%{
/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/parser/lexer.l
 *****************************************************************/

/****************************************
 Includes
 ****************************************/

#include <stdlib.h>
#include <stdio.h>

#include "parser.tab.h"
#include "src/arturo.h"

%}

/****************************************
 Options
 ****************************************/

%option nodefault
%option yylineno
%option noyywrap

/****************************************
 Character classes
 ****************************************/

DIGIT               [0-9]
DIGIT_BIN           [01]
DIGIT_OCT           [0-7]
DIGIT_HEX           [0-9A-Fa-f]

LETTER              [A-Za-z_]

/****************************************
 Tokens
 ****************************************/
%%  

"\""(\\.|[^\\"])*"\""   { 
                            int l = strlen(yytext);
                            yylval.str = calloc(l-1, sizeof(char));
                            strncpy(yylval.str, &yytext[1], l-2);
                            yylval.str[l-1] = '\0';
                            return STRING; 
                        }

"||"[^\r\n]*[\r\n]      { /* Single-line comment. Ignore. */ }
"#!".*                  { /* She-bang line. Ignore. */ }

"if"                    { return IF_CMD; }
"loop"					{ return LOOP_CMD; }
"print"                 { yylval.op = DO_PRINT; return SYSCALL1; }
"size"                  { yylval.op = GET_SIZE; return SYSCALL1; }
"get"|"!"               { yylval.op = DO_GET; return SYSCALL2; }
"return"				{ yylval.op = RET; return SYSCALL1; }

{LETTER}+               { yylval.str=strdup(yytext); return ID; }
{DIGIT}{0,10}           { yylval.str=strdup(yytext); return INTEGER; }
{DIGIT}{11,}            { yylval.str=strdup(yytext); return BIG_INTEGER; }
{DIGIT}+\.{DIGIT}+      { yylval.str=strdup(yytext); return REAL; }

"+"                     { return ADD_OP; }
"-"                     { return SUB_OP; }
"*"                     { return MUL_OP; }
"/"                     { return DIV_OP; }
"%"                     { return MOD_OP; }
"^"                     { return POW_OP; }

"="                     { return EQ_OP; }
"/="|"≠"                { return NE_OP; }
">"                     { return GT_OP; }
">="|"≥"                { return GE_OP; }
"<"                     { return LT_OP; }
"<="|"≤"                { return LE_OP; }

"."                     { return DOT; }
"`"                     { return FIELD; }
":"                     { return COLON; }
","                     { return COMMA; }
"|"                     { return PIPE; }

"$"                     { return FUNC; }
"@"                     { return ARRAY; }
"#"                     { return DICT; }

"("                     { return LPAREN; }
")"                     { return RPAREN; }
"["                     { return LSQUARE; }
"]"                     { return RSQUARE; }
"{"                     { return LCURLY; }
"}"                     { return RCURLY; }

[\n]                    { return NL; }

[ \r\t]+                { /* ignore whitespace */ }
.                       { /* ignore all other characters */ }

%%
