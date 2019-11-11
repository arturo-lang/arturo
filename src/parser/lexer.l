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

"null"                                              { return NULLV; }
"true"|"false"                                      { yylval.str=strdup(yytext); return BOOLEANV; }

%%SYSTEM_CMD%%

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

"="                                                 { return EQ_OP; }
"<="                                                { return LE_OP; }
">="                                                { return GE_OP; }
"<"                                                 { return LT_OP; }
">"                                                 { return GT_OP; }
"!="                                                { return NE_OP; }

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

void count()
{
    /*int i;
    
    for (i = 0; yytext[i] != '\0'; i++)
    {
        if (yytext[i] == '\n') yycolumn = 0;
        else if (yytext[i] == '\t') yycolumn += 8 - (yycolumn % 8);
        else yycolumn++;
    }*/

    yylval.str=strdup(yytext);
}

void yyerror(const char *str)
{
    parseError(str, yyfilename, yylineno);
}

/****************************************
  This is the end,
  my only friend, the end...
 ****************************************/
