%{
/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: parser/lexer.l
 *****************************************************************/

/****************************************
 Includes
 ****************************************/

#include <stdio.h>
#include "parser.tab.h"

/****************************************
 Extern & Forward declarations
 ****************************************/

void yyerror(const char* str);
void count();

extern char* yyfilename;
extern void parseError(const char* msg, const char* filename, int line);

%}

/****************************************
 Options
 ****************************************/

%option yylineno
%x C_COMMENT

/****************************************
 Building blocks
 ****************************************/

DIGIT               [0-9]
DIGIT_HEX           [a-fA-F0-9]
DIGIT_BIN           [01]
LETTER              [a-zA-Z_]
LETTER_OR_MISC      [a-zA-Z_]

/****************************************
 Tokens
 ****************************************/

%%

\"(\\.|[^\\"])*\"                                   { yylval.str=strdup(yytext); return STRING; }

"/*"                                                { BEGIN(C_COMMENT); }
<C_COMMENT>"*/"                                     { BEGIN(INITIAL); }
<C_COMMENT>\n                                       { yylineno++; }
<C_COMMENT>.                                        { }

"//".*                                              { /* Single-line comment. Ignore. */ }
"#!".*                                              { /* She-bang line. Ignore. */ }

"all" { yylval.code = 0; return SYSTEM_CMD; }
"any" { yylval.code = 1; return SYSTEM_CMD; }
"count" { yylval.code = 2; return SYSTEM_CMD; }
"filter" { yylval.code = 3; return SYSTEM_CMD; }
"filter!" { yylval.code = 4; return SYSTEM_CMD; }
"first" { yylval.code = 5; return SYSTEM_CMD; }
"fold" { yylval.code = 6; return SYSTEM_CMD; }
"last" { yylval.code = 7; return SYSTEM_CMD; }
"map" { yylval.code = 8; return SYSTEM_CMD; }
"map!" { yylval.code = 9; return SYSTEM_CMD; }
"permutations" { yylval.code = 10; return SYSTEM_CMD; }
"pop" { yylval.code = 11; return SYSTEM_CMD; }
"pop!" { yylval.code = 12; return SYSTEM_CMD; }
"range" { yylval.code = 13; return SYSTEM_CMD; }
"rangeBy" { yylval.code = 14; return SYSTEM_CMD; }
"rotate" { yylval.code = 15; return SYSTEM_CMD; }
"rotate!" { yylval.code = 16; return SYSTEM_CMD; }
"sample" { yylval.code = 17; return SYSTEM_CMD; }
"shuffle" { yylval.code = 18; return SYSTEM_CMD; }
"shuffle!" { yylval.code = 19; return SYSTEM_CMD; }
"sort" { yylval.code = 20; return SYSTEM_CMD; }
"sort!" { yylval.code = 21; return SYSTEM_CMD; }
"swap" { yylval.code = 22; return SYSTEM_CMD; }
"swap!" { yylval.code = 23; return SYSTEM_CMD; }
"unique" { yylval.code = 24; return SYSTEM_CMD; }
"unique!" { yylval.code = 25; return SYSTEM_CMD; }
"zip" { yylval.code = 26; return SYSTEM_CMD; }
"exec" { yylval.code = 27; return SYSTEM_CMD; }
"if" { yylval.code = 28; return SYSTEM_CMD; }
"import" { yylval.code = 29; return SYSTEM_CMD; }
"loop" { yylval.code = 30; return SYSTEM_CMD; }
"new" { yylval.code = 31; return SYSTEM_CMD; }
"panic" { yylval.code = 32; return SYSTEM_CMD; }
"return" { yylval.code = 33; return SYSTEM_CMD; }
"syms" { yylval.code = 34; return SYSTEM_CMD; }
"append" { yylval.code = 35; return SYSTEM_CMD; }
"append!" { yylval.code = 36; return SYSTEM_CMD; }
"contains" { yylval.code = 37; return SYSTEM_CMD; }
"delete" { yylval.code = 38; return SYSTEM_CMD; }
"delete!" { yylval.code = 39; return SYSTEM_CMD; }
"deleteBy" { yylval.code = 40; return SYSTEM_CMD; }
"deleteBy!" { yylval.code = 41; return SYSTEM_CMD; }
"get" { yylval.code = 42; return SYSTEM_CMD; }
"index" { yylval.code = 43; return SYSTEM_CMD; }
"isEmpty" { yylval.code = 44; return SYSTEM_CMD; }
"reverse" { yylval.code = 45; return SYSTEM_CMD; }
"reverse!" { yylval.code = 46; return SYSTEM_CMD; }
"set" { yylval.code = 47; return SYSTEM_CMD; }
"set!" { yylval.code = 48; return SYSTEM_CMD; }
"size" { yylval.code = 49; return SYSTEM_CMD; }
"slice" { yylval.code = 50; return SYSTEM_CMD; }
"abs" { yylval.code = 51; return SYSTEM_CMD; }
"acos" { yylval.code = 52; return SYSTEM_CMD; }
"acosh" { yylval.code = 53; return SYSTEM_CMD; }
"asin" { yylval.code = 54; return SYSTEM_CMD; }
"asinh" { yylval.code = 55; return SYSTEM_CMD; }
"atan" { yylval.code = 56; return SYSTEM_CMD; }
"atanh" { yylval.code = 57; return SYSTEM_CMD; }
"avg" { yylval.code = 58; return SYSTEM_CMD; }
"ceil" { yylval.code = 59; return SYSTEM_CMD; }
"cos" { yylval.code = 60; return SYSTEM_CMD; }
"cosh" { yylval.code = 61; return SYSTEM_CMD; }
"csec" { yylval.code = 62; return SYSTEM_CMD; }
"csech" { yylval.code = 63; return SYSTEM_CMD; }
"ctan" { yylval.code = 64; return SYSTEM_CMD; }
"ctanh" { yylval.code = 65; return SYSTEM_CMD; }
"exp" { yylval.code = 66; return SYSTEM_CMD; }
"floor" { yylval.code = 67; return SYSTEM_CMD; }
"gcd" { yylval.code = 68; return SYSTEM_CMD; }
"inc" { yylval.code = 69; return SYSTEM_CMD; }
"inc!" { yylval.code = 70; return SYSTEM_CMD; }
"isEven" { yylval.code = 71; return SYSTEM_CMD; }
"isOdd" { yylval.code = 72; return SYSTEM_CMD; }
"isPrime" { yylval.code = 73; return SYSTEM_CMD; }
"lcm" { yylval.code = 74; return SYSTEM_CMD; }
"ln" { yylval.code = 75; return SYSTEM_CMD; }
"log" { yylval.code = 76; return SYSTEM_CMD; }
"log2" { yylval.code = 77; return SYSTEM_CMD; }
"log10" { yylval.code = 78; return SYSTEM_CMD; }
"max" { yylval.code = 79; return SYSTEM_CMD; }
"min" { yylval.code = 80; return SYSTEM_CMD; }
"pi" { yylval.code = 81; return SYSTEM_CMD; }
"primeFactors" { yylval.code = 82; return SYSTEM_CMD; }
"product" { yylval.code = 83; return SYSTEM_CMD; }
"random" { yylval.code = 84; return SYSTEM_CMD; }
"round" { yylval.code = 85; return SYSTEM_CMD; }
"sec" { yylval.code = 86; return SYSTEM_CMD; }
"sech" { yylval.code = 87; return SYSTEM_CMD; }
"shl" { yylval.code = 88; return SYSTEM_CMD; }
"shl!" { yylval.code = 89; return SYSTEM_CMD; }
"shr" { yylval.code = 90; return SYSTEM_CMD; }
"shr!" { yylval.code = 91; return SYSTEM_CMD; }
"sin" { yylval.code = 92; return SYSTEM_CMD; }
"sinh" { yylval.code = 93; return SYSTEM_CMD; }
"sqrt" { yylval.code = 94; return SYSTEM_CMD; }
"sum" { yylval.code = 95; return SYSTEM_CMD; }
"tan" { yylval.code = 96; return SYSTEM_CMD; }
"tanh" { yylval.code = 97; return SYSTEM_CMD; }
"clear" { yylval.code = 98; return SYSTEM_CMD; }
"input" { yylval.code = 99; return SYSTEM_CMD; }
"inputChar" { yylval.code = 100; return SYSTEM_CMD; }
"print" { yylval.code = 101; return SYSTEM_CMD; }
"prints" { yylval.code = 102; return SYSTEM_CMD; }
"shell" { yylval.code = 103; return SYSTEM_CMD; }


"null"                                              { return NULLV; }
"true"|"false"                                      { yylval.str=strdup(yytext); return BOOLEANV; }

"&0"                                                { yylval.str="0"; return ARGV; }
"&1"                                                { yylval.str="1"; return ARGV; }
"&2"                                                { yylval.str="2"; return ARGV; }
"&3"                                                { yylval.str="3"; return ARGV; }
"&4"                                                { yylval.str="4"; return ARGV; }
"&5"                                                { yylval.str="5"; return ARGV; }
"&6"                                                { yylval.str="6"; return ARGV; }
"&7"                                                { yylval.str="7"; return ARGV; }
"&8"                                                { yylval.str="8"; return ARGV; }
"&9"                                                { yylval.str="9"; return ARGV; }
"&"                                                 { yylval.str="&"; return ID; }

{LETTER}({LETTER_OR_MISC}|{DIGIT})*                 { yylval.str=strdup(yytext); return ID; }
{DIGIT}+                                            { yylval.str=strdup(yytext); return INTEGER; }
{DIGIT}+\.{DIGIT}+                                  { yylval.str=strdup(yytext); return REAL; }

"|"                                                 { return PIPE; }
"=>"                                                { return MAP; }
"->"                                                { return IMPLIES; }

"="                                                 { return EQ_OP; }
"<="|"≤"                                            { return LE_OP; }
">="|"≥"                                            { return GE_OP; }
"<"                                                 { return LT_OP; }
">"                                                 { return GT_OP; }
"!="|"≠"                                            { return NE_OP; }

"+"                                                 { return PLUS_SG; }
"-"                                                 { return MINUS_SG; }
"*"                                                 { return MULT_SG; }
"/"                                                 { return DIV_SG; }
"%"                                                 { return MOD_SG; }
"^"                                                 { return POW_SG; }

"#("                                                { return BEGIN_ARR; }
"#{"                                                { return BEGIN_DICT; }
"@("                                                { return BEGIN_ARGS; }

"@"                                                 { return AT; }

".."                                                { return RANGE; }
"."                                                 { return DOT; }

"("                                                 { return LPAREN; }
")"                                                 { return RPAREN; }
"{"                                                 { return LCURLY; }
"}"                                                 { return RCURLY; }
"["                                                 { return LSQUARE; }
"]"                                                 { return RSQUARE; }
","                                                 { return COMMA; }
";"                                                 { return SEMICOLON; }
":"                                                 { return COLON; }
"~"                                                 { return TILDE; }

\n                                                  { return NEW_LINE; }

[ \t\v\f]+                                          { /* ignore whitespace */ }
.                                                   { /* ignore it */ } 
%%

/****************************************
 Functions
 ****************************************/

int yycolumn = 0;

void yyerror(const char *str)
{
    parseError(str, yyfilename, yylineno);
}

/****************************************
  This is the end,
  my only friend, the end...
 ****************************************/
