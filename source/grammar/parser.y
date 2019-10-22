%{
/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: grammar/parser.y
 *****************************************************************/

/****************************************
 Extern & Forward declarations
 ****************************************/

// Macros

#define POS(X) set_Position(X,new_Position(yylineno,yyfilename));

// External definitions

extern void yyerror(const char* str);
extern int yyparse(void);
extern int yylex();

extern int yylineno;
char* yyfilename;

extern void* _program;

extern void* new_IdentifierWithId(char* s, int hsh);
extern void add_IdToIdentifier(char* s, void* iden);
extern void add_NumToIdentifier(char* l, void* iden);
extern void add_ExprToIdentifier(void* e, void* iden);
extern void* new_Identifiers();
extern void add_Identifier(void* i, void* iden);

extern void* new_Argument(char* t, char* v);
extern void* new_ArgumentFromIdentifier(void* iden);
extern int argument_Interpolated(void* a);
extern void* new_Expression(void* l, char* op, void* r, int tp);
extern void* new_ExpressionFromArgument(void* a);
extern void* new_ExpressionFromStatement(void* s);
extern void* new_ExpressionFromStatementBlock(void* st);
extern void* new_ExpressionFromStatementBlockWithArguments(void* st,void* ids);
extern void* new_ExpressionFromDictionary(void* st);
extern void* new_ExpressionFromArray(void* ar);
extern void* new_Statement(char* id);
extern void* new_StatementFromExpression(void* ex);
extern void* new_StatementWithExpressions(char* id, void* ex);
extern void* new_Expressions();
extern void* new_Statements();

extern void add_Statement(void* s, void* st);
extern void add_Expression(void* e, void* ex);

extern void* new_Position(int l, char* f);
extern void set_Position(void* i, void* p);

extern void set_MainEntry(void* p, void* s);

/****************************************
 Functions
 ****************************************/ 
 
int yywrap() {
	return 1;
} 

%}

/****************************************
 Definitions
 ****************************************/

%union {
	char* str;
	void* compo;
}

/****************************************
 Tokens & Types
 ****************************************/

%token <str> ID "ID"
%token <str> HASH_ID "@ID"
%token <str> FUNCTION_ID "Function Identifier"
%token <str> NUMBER "Number"
%token <str> FLOAT "Float"
%token <str> STRING "String Literal"
%token <str> NULLV "Null"
%token <str> BOOLEAN "Boolean"

%token <str> PIPE "|"
%token <str> IMPLIES "->"

%token <str> EQ_OP "="
%token <str> LE_OP "<="
%token <str> LT_OP "<"
%token <str> GE_OP ">="
%token <str> GT_OP ">"
%token <str> NE_OP "!="

%token <str> PLUS_SG "+"
%token <str> MINUS_SG "-"
%token <str> MULT_SG "*"
%token <str> DIV_SG "/"
%token <str> MOD_SG "%"
%token <str> POW_SG "^"

%token <str> BEGIN_ARR "#("
%token <str> BEGIN_DICT "#{"
%token <str> BEGIN_INLINE "$("

%token <str> DOT "."
%token <str> HASH "#"
%token <str> DOLLAR "$"
%token <str> LPAREN "("
%token <str> RPAREN ")"
%token <str> LCURLY "{"
%token <str> RCURLY "}"
%token <str> LSQUARE "["
%token <str> RSQUARE "]"
%token <str> COMMA ","
%token <str> COLON ":"
%token <str> EXCL "!"
%token <str> SEMICOLON ";"
%token <str> TILDE "~"

%token <str> NEW_LINE "End Of Line"

%type <str> identifier
%type <str> identifiers

%type <compo> argument
%type <compo> expression expression_list
%type <compo> statements statement
%type <compo> program

/****************************************
 Directives
 ****************************************/

%glr-parser
%locations
%define parse.error verbose

%right TILDE
%nonassoc EQ_OP LE_OP GE_OP LT_OP GT_OP NE_OP 

%left PLUS_SG MINUS_SG
%left MULT_SG DIV_SG MOD_SG 
%left POW_SG
%left IMPLIES

%nonassoc REDUCE
%nonassoc ID

%left NUMBER
%left FLOAT

%start program

%%

/****************************************
 Grammar Rules
 ****************************************/

//==============================
// Building blocks
//==============================

identifier 				: 	ID 																	{ $$ = new_IdentifierWithId($ID,0); }
						| 	HASH_ID																{ $$ = new_IdentifierWithId($HASH_ID,1); }
						|	EXCL																{ $$ = new_IdentifierWithId("let",0); }
						|	identifier[previous] DOT ID 										{ void* i = $previous; add_IdToIdentifier($ID, i); $$ = i; }
						|	identifier[previous] DOT NUMBER										{ void* i = $previous; add_NumToIdentifier($NUMBER, i); $$ = i; }
						|	identifier[previous] DOT FLOAT										{ void* i = $previous; add_NumToIdentifier($FLOAT, i); $$ = i; }
						| 	identifier[previous] DOT LSQUARE expression RSQUARE					{ void* i = $previous; add_ExprToIdentifier($expression, i); $$ = i; }
						;

identifiers				: 	identifiers[previous] COMMA identifier 								{ void* i = $previous; add_Identifier(i, $identifier); $$ = i; }
						|	identifier 															{ void* i = new_Identifiers(); add_Identifier(i, $identifier); $$ = i; }
						|	/* Nothing */														{ $$ = new_Identifiers(); }
						;

argument				:	identifier 															{ $$ = new_ArgumentFromIdentifier($identifier); }
						| 	NUMBER 																{ $$ = new_Argument("number", $NUMBER); }
						|	FLOAT 																{ $$ = new_Argument("number", $FLOAT); }
						|	STRING 																{ $$ = new_Argument("string", $STRING); }
						|	TILDE %prec REDUCE													{ $$ = new_Argument("string", "\"\""); }
						|	TILDE ID 															{ $$ = new_Argument("string", $ID); }
						|	BOOLEAN 															{ $$ = new_Argument("boolean", $BOOLEAN); }
						|	NULLV	 															{ $$ = new_Argument("null", $NULLV); }
						;

expression				: 	argument 															{ $$ = new_ExpressionFromArgument($argument); }
						|	LPAREN expression[main] RPAREN 										{ $$ = $main; }
						|	expression[left] PLUS_SG expression[right] 							{ $$ = new_Expression($left, $2, $right, 0); }
						| 	expression[left] MINUS_SG expression[right] 						{ $$ = new_Expression($left, $2, $right, 0); }
						| 	expression[left] MULT_SG expression[right] 							{ $$ = new_Expression($left, $2, $right, 0); }
						| 	expression[left] DIV_SG expression[right] 							{ $$ = new_Expression($left, $2, $right, 0); }
						| 	expression[left] MOD_SG expression[right] 							{ $$ = new_Expression($left, $2, $right, 0); }
						| 	expression[left] POW_SG expression[right] 							{ $$ = new_Expression($left, $2, $right, 0); }
						| 	expression[left] EQ_OP expression[right] 							{ $$ = new_Expression($left, $2, $right, 1); } 
						|	expression[left] LE_OP expression[right]							{ $$ = new_Expression($left, $2, $right, 1); } 
						|	expression[left] GE_OP expression[right]							{ $$ = new_Expression($left, $2, $right, 1); } 
						|	expression[left] LT_OP expression[right]							{ $$ = new_Expression($left, $2, $right, 1); } 
						|	expression[left] GT_OP expression[right]							{ $$ = new_Expression($left, $2, $right, 1); } 
						|	expression[left] NE_OP expression[right]							{ $$ = new_Expression($left, $2, $right, 1); } 
						|	BEGIN_ARR expression_list RPAREN									{ $$ = new_ExpressionFromArray($expression_list); }
						|	BEGIN_ARR RPAREN													{ void* e = new_Expressions(); $$ = new_ExpressionFromArray(e); }
						|	BEGIN_DICT statements RCURLY										{ $$ = new_ExpressionFromDictionary($statements); }
						|	BEGIN_INLINE statement RPAREN 										{ $$ = new_ExpressionFromStatement($statement); }
						|	LCURLY statements RCURLY											{ $$ = new_ExpressionFromStatementBlock($statements); }
						| 	LSQUARE identifiers RSQUARE LCURLY statements RCURLY				{ $$ = new_ExpressionFromStatementBlockWithArguments($statements, $identifiers); }
						;


expression_list			:	expression 															{ void* e = new_Expressions(); add_Expression(e, $expression); $$ = e; }
						| 	IMPLIES expression													{ void* e = new_Expressions(); void* sts = new_Statements(); void* subex = new_Expressions(); add_Expression(subex,$expression); add_Statement(sts, new_StatementWithExpressions(new_IdentifierWithId("return",0), subex)); add_Expression(e, new_ExpressionFromStatementBlock(sts)); $$ = e; }
						| 	expression_list[previous] expression 								{ void* e = $previous; add_Expression(e, $expression); $$ = e; }
						| 	expression_list[previous] IMPLIES expression 						{ void* e = $previous; void* sts = new_Statements(); void* subex = new_Expressions(); add_Expression(subex,$expression); add_Statement(sts, new_StatementWithExpressions(new_IdentifierWithId("return",0), subex)); add_Expression(e, new_ExpressionFromStatementBlock(sts)); $$ = e; }
						;

statement				: 	expression 															{ $$ = new_StatementFromExpression($expression); POS($$); }
						|   IMPLIES expression 													{ void* subex = new_Expressions(); add_Expression(subex,$expression); $$ = new_StatementWithExpressions(new_IdentifierWithId("return",0), subex); }
						|	identifier expression_list											{ $$ = new_StatementWithExpressions($identifier, $expression_list); POS($$); }
						|	identifier PIPE statement[previous]									{ void* e = new_Expressions(); add_Expression(e, new_ExpressionFromStatement($previous)); $$ = new_StatementWithExpressions($identifier,e); POS($$); }
						;

statements 				:	statements[previous] NEW_LINE statement 							{ void* s = $previous; if ($statement!=NULL) { add_Statement(s, $statement); } $$ = s; }
						|   statements[previous] COMMA statement 								{ void* s = $previous; if ($statement!=NULL) { add_Statement(s, $statement); } $$ = s; }
						|	statements[previous] NEW_LINE										{ $$ = $previous; }
						| 	statement 															{ void* s = new_Statements(); if ($statement!=NULL) { add_Statement(s, $statement); $$ = s; } }
						|	/* Nothing */														{ $$ = new_Statements(); }
						;

//==============================
// Entry point
//==============================

program					:	statements 															{ set_MainEntry(_program, $statements); }
						;

%%

/****************************************
  This is the end,
  my only friend, the end...
 ****************************************/