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
#include "parser.tab.h"

/****************************************
 Extern & Forward declarations
 ****************************************/

void yyerror(const char* str);
void count();

extern char* yyfilename;

extern void panic_ParseError(const char* m, const char* f, int line);

%}

/****************************************
 Options
 ****************************************/

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
"~"													{ count(); return ID; }
":"													{ count(); return COLON; }
"#"													{ count(); return HASH; }
*/


%%

\"(\\.|[^\\"])*\"									{ count(); return STRING; }
'(\\.|[^\\'])+'										{ count(); return STRING; }


"/*"            									{ BEGIN(C_COMMENT); }
<C_COMMENT>"*/" 									{ BEGIN(INITIAL); }
<C_COMMENT>\n   									{ yylineno++; }
<C_COMMENT>.   	 									{ }

"//".*                                  			{ count(); /* Single-line comment. Ignore. */ }
"#!".*                                  			{ count(); /* She-bang line. Ignore. */ }

"null"												{ count(); return NULLV; }
"true"|"false"     									{ count(); return BOOLEAN; }


{LETTER}({LETTER_OR_MISC}|{DIGIT})*					{ count(); return ID; }
":"({LETTER_OR_MISC}|{DIGIT})*						{ count(); return ID; }
"@"({LETTER_OR_MISC}|{DIGIT})*						{ count(); return HASH_ID; }
{DIGIT}+											{ count(); return NUMBER; }
{DIGIT}+\.{DIGIT}+									{ count(); return FLOAT; }

"|"													{ count(); return PIPE; }
"->"												{ count(); return IMPLIES; }

"="													{ count(); return EQ_OP; }
"<="												{ count(); return LE_OP; }
">="												{ count(); return GE_OP; }
"<"													{ count(); return LT_OP; }
">"													{ count(); return GT_OP; }
"!="												{ count(); return NE_OP; }

"+"													{ count(); return PLUS_SG; }
"-"													{ count(); return MINUS_SG; }
"*"													{ count(); return MULT_SG; }
"/"													{ count(); return DIV_SG; }
"%"													{ count(); return MOD_SG; }
"^"													{ count(); return POW_SG; }

"#("												{ count(); return BEGIN_ARR; }
"#{"												{ count(); return BEGIN_DICT; }
"$("												{ count(); return BEGIN_INLINE; }

"."													{ count(); return DOT; }

"$"													{ count(); return DOLLAR; }
"("													{ count(); return LPAREN; }
")"													{ count(); return RPAREN; }
"{"													{ count(); return LCURLY; }
"}"													{ count(); return RCURLY; }
"["													{ count(); return LSQUARE; }
"]"													{ count(); return RSQUARE; }
","													{ count(); return COMMA; }
"!"													{ count(); return EXCL; }
";"													{ count(); return SEMICOLON; }
"~"													{ count(); return TILDE; }

\n 													{ count(); return NEW_LINE; }

[ \t\v\f]+                							{ count(); /* ignore whitespace */ }
.													{ count(); /* ignore it */ } 
%%

/****************************************
 Functions
 ****************************************/

int yycolumn = 0;

void count()
{
	int i;
	
	for (i = 0; yytext[i] != '\0'; i++)
	{
		if (yytext[i] == '\n') yycolumn = 0;
		else if (yytext[i] == '\t') yycolumn += 8 - (yycolumn % 8);
		else yycolumn++;
	}

	yylval.str=strdup(yytext);
}

void yyerror(const char *str)
{
	panic_ParseError(str, yyfilename, yylineno);
}

/****************************************
  This is the end,
  my only friend, the end...
 ****************************************/
