%{
/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: grammar/lexer.l
 *****************************************************************/

/****************************************
 Includes
 ****************************************/

#include <stdio.h>
//#include "parser.tab.h"

/****************************************
 Extern & Forward declarations
 ****************************************/



void yyerror(const char* str);
//void }

//extern char* yyfilename;

//extern void panic_ParseError(const char* m, const char* f, int line);

%}

/****************************************
 Options
 ****************************************/
%option noyywrap
%option yylineno
%x C_COMMENT

/****************************************
 Building blocks
 ****************************************/

DIGIT				[0-9]
DIGIT_HEX			[a-fA-F0-9]
DIGIT_BIN			[01]
LETTER				[a-zA-Z_&]
LETTER_OR_MISC		[a-zA-Z_:]



/****************************************
 Tokens
 ****************************************/
/*
"~"													{ }
":"													{ }
"#"													{ }
*/


%%

\"(\\.|[^\\"])*\"									{ }
'(\\.|[^\\'])+'										{ }


"/*"            									{ BEGIN(C_COMMENT); }
<C_COMMENT>"*/" 									{ BEGIN(INITIAL); }
<C_COMMENT>\n   									{ yylineno++; }
<C_COMMENT>.   	 									{ }

"//".*                                  			{ }
"#!".*                                  			{ }

"null"												{ }
"true"|"false"     									{ }


{LETTER}({LETTER_OR_MISC}|{DIGIT})*					{ }
":"({LETTER_OR_MISC}|{DIGIT})*						{ }
"@"({LETTER_OR_MISC}|{DIGIT})*						{ }
{DIGIT}+											{ }
{DIGIT}+\.{DIGIT}+									{ }

"|"													{ }
"->"												{ }

"="													{ }
"<="												{ }
">="												{ }
"<"													{ }
">"													{ }
"!="												{ }

"+"													{ }
"-"													{ }
"*"													{ }
"/"													{ }
"%"													{ }
"^"													{ }

"#("												{ }
"#{"												{ }
"$("												{ }

"."													{ }

"$"													{ }
"("													{ }
")"													{ }
"{"													{ }
"}"													{ }
"["													{ }
"]"													{ }
","													{ }
"!"													{ }
";"													{ }
"~"													{ }

\n 													{ }

[ \t\v\f]+                							{ /* ignore whitespace */ }
.													{ /* ignore it */ } 
%%

/****************************************
 Functions
 ****************************************/

int yycolumn = 0;

int main( argc, argv )
 int argc;
 char **argv;
 {
 ++argv, --argc;  /* skip over program name */
 if ( argc > 0 )
         yyin = fopen( argv[0], "r" );
 else
         yyin = stdin;

 yylex();
 }

/****************************************
  This is the end,
  my only friend, the end...
 ****************************************/
