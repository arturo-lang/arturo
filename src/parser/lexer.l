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

"true"					{ return BOOL_TRUE; }
"false"					{ return BOOL_FALSE; }

"if"                    { return IF_CMD; }
"loop"					{ return LOOP_CMD; }
"print"                 { yylval.op = DO_PRINT; return SYSCALL1; }
"log"					{ yylval.op = DO_LOG; return SYSCALL1; }
"size"                  { yylval.op = GET_SIZE; return SYSCALL1; }
"abs"					{ yylval.op = GET_ABS; return SYSCALL1; }
"return"				{ yylval.op = RET; return SYSCALL1; }

"inc!"					{ yylval.op = IN_INC; return INPLACE1; }
"append!"				{ yylval.op = IN_APPEND; return INPLACE2; }
"swap!"					{ yylval.op = IN_SWAP; return INPLACE3; }

"or"					{ yylval.op = OR; return SYSCALL2; }
"sqrt"					{ yylval.op = GET_SQRT; return SYSCALL1; }
"range"					{ yylval.op = GET_RANGE; return SYSCALL2; }
"product"				{ yylval.op = GET_PRODUCT; return SYSCALL1; }
"isPrime"				{ yylval.op = CHECK_ISPRIME; return SYSCALL1; }
"sort!"					{ yylval.op = IN_SORT; return SYSCALL1; }
"sort"					{ yylval.op = DO_SORT; return SYSCALL1; }

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

".."					{ return RANGE; }

"."                     { return DOT; }
"'"                     { return FIELD; }
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
