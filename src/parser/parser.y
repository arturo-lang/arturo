%{
/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/parser/parser.y
 *****************************************************************/

#include "src/arturo.h"

/****************************************
 Extern & Forward declarations
 ****************************************/

extern int yylex();

/****************************************
 Functions
 ****************************************/ 
 
int yywrap() {
    return 1;
} 

void yyerror (char const *s) {
    printf("parse error: %s\n",s);
}

%}

/****************************************
 Definitions
 ****************************************/

%union {
    char* str;
    void* compo;
    int op;
}

/****************************************
 Tokens
 ****************************************/

%token <str> STRING             "STRING LITERAL"

%token <str> ID                 "IDENTIFIER"
%token <op>  SYSCALL0           "SYSTEM CALL/0"
%token <op>  SYSCALL1           "SYSTEM CALL/1"
%token <op>  SYSCALL2           "SYSTEM CALL/2"
%token <str> INTEGER            "INTEGER"
%token <str> BIG_INTEGER        "BIG INTEGER"
%token <str> REAL               "REAL"

%token <str> ADD_OP             "`+` (plus operator)"
%token <str> SUB_OP             "`-` (minus operator)"
%token <str> MUL_OP             "`*` (multiplication v)"
%token <str> DIV_OP             "`/` (division operator)"
%token <str> MOD_OP             "`%` (modulo operator)"
%token <str> POW_OP             "`^` (power operator)"

%token <str> EQ_OP              "`=` (equality operator)"
%token <str> NE_OP              "`≠` (inequality operator)"
%token <str> GT_OP              "`>` (greater-than operator)"
%token <str> GE_OP              "`≥` (greater-than-or-equal operator)"
%token <str> LT_OP              "`>` (less-than operator)"
%token <str> LE_OP              "`≤` (less-than-or-equal operator)"

%token <str> DOT                "`.` (dot)"
%token <str> FIELD              "``` (field)"
%token <str> COLON              "`:` (colon)"
%token <str> COMMA              "`,` (comma)"
%token <str> PIPE               "`|` (pipe)"

%token <str> FUNC               "`$` (function specifier)"
%token <str> ARRAY              "`@` (array specifier)"
%token <str> DICT               "`#` (dictionary specifier)"

%token <str> LPAREN             "`(` (opening parenthesis)"
%token <str> RPAREN             "`)` (closing parenthesis)"
%token <str> LSQUARE            "`[` (opening square bracket)"
%token <str> RSQUARE            "`]` (closing square bracket)"
%token <str> LCURLY             "`{` (opening curly bracket)"
%token <str> RCURLY             "`}` (closing curly bracket)"

%token <str> NL                 "NEWLINE"

%token <str> IF_CMD             "IF_CMD"

/****************************************
 Token precedence
 ****************************************/

%glr-parser

%nonassoc EQ_OP NE_OP GT_OP GE_OP LT_OP LE_OP

%left ADD_OP SUB_OP
%left MUL_OP DIV_OP MOD_OP
%right POW_OP
%left DOT
%left FIELD

%left INTEGER
%left REAL

/****************************************
 Options
 ****************************************/

%start program
%define parse.error verbose
%locations

%%

/****************************************
 Grammar Rules
 ****************************************/

//==============================
// Basic arguments
//==============================    

number                  :   INTEGER             { doPushInt(strToIntValue($INTEGER)); }
                        |   BIG_INTEGER         { emitOpWord(PUSH,storeValueData(strToBigintValue($BIG_INTEGER))); }
                        |   REAL                { emitOpWord(PUSH,storeValueData(strToRealValue($REAL))); }
                        ;

string                  :   STRING              { emitOpWord(PUSH, storeValueData(strToStringValue($STRING))); }
                        ;

id                      :   ID                  { processLoad($ID); }
                        ;

//==============================
// Blocks
//==============================

ids                     :   ids ID                                      { aAdd(LocalLookup,$ID); argCounter++; }
                        |   ID                                          { aAdd(LocalLookup,$ID); argCounter++; }
                        ;

verbatim                :   LSQUARE statements RSQUARE
                        ;  

block_start             :   LPAREN ids RPAREN LCURLY                    { printf("found block_start\n"); signalGotInBlock(); }
                        |   LCURLY                                      { printf("found block_start\n"); signalGotInBlock(); }
                        ;

block_end               :   RCURLY                                      { printf("found block_end\n"); signalGotOutOfBlock(); }
                        ;

block                   :   block_start statements block_end            { printf("found block section\n"); }
                        ;

function_specifier      :   FUNC                                        { signalGotInFunction(); printf("found function specifier\n"); }
                        ;

function                :   function_specifier block                    { printf("found function section\n"); signalFoundFunction(); }
                        ;

array_specifier         :   ARRAY                                       { signalGotInArray(); }
                        ;

array                   :   array_specifier verbatim                    { signalFoundArray(); }
                        |   array_specifier block                       { signalFoundArray(); }
                        ;

dictionary_specifier    :   DICT                                        { signalGotInDictionary(); }
                        ;

dictionary              :   dictionary_specifier verbatim               { signalFoundDictionary(); }
                        |   dictionary_specifier block                  { signalFoundDictionary(); }
                        ;

//==============================
// Expressions
//==============================

expression              :   number
                        |   string
                        |   id                                                                 

                        |   expression ADD_OP expression            { emitOp(ADD); }
                        |   expression SUB_OP expression            { emitOp(SUB); }
                        |   expression MUL_OP expression            { emitOp(MUL); }
                        |   expression DIV_OP expression            { emitOp(DIV); }
                        |   expression MOD_OP expression            { emitOp(MOD); }
                        |   expression POW_OP expression            { emitOp(POW); }

                        |   expression EQ_OP expression             { emitOp(CMPEQ); }
                        |   expression NE_OP expression             { emitOp(CMPNE); }
                        |   expression GT_OP expression             { emitOp(CMPGT); }
                        |   expression GE_OP expression             { emitOp(CMPGE); }
                        |   expression LT_OP expression             { emitOp(CMPLT); }
                        |   expression LE_OP expression             { emitOp(CMPLE); }

                        |   expression DOT ID                       { processCall($ID); }
                        |   expression DOT SYSCALL1                 { emitOp((OPCODE)$SYSCALL1); }
                        |   expression DOT SYSCALL2                 { emitOp((OPCODE)$SYSCALL2); }
                        |   expression FIELD expression             { emitOp((OPCODE)DO_GET); }

                        |   verbatim
                        |   block
                        |   function                                { printf("found function\n"); }
                        |   array
                        |   dictionary
                        ;

expressions             :   expressions expression
                        |   expression
                        ;



// expression              :   STRING                              { emitOpValue(PUSH, strToStringValue($STRING)); }
//                         |   number                              {  }
//                         |   symbol                              { processLoad($symbol); }
//                         |   array inlined                         { signalGotOutOfArray(); }
//                         |   range                               { }
//                         |   dict inlined                          { /*signalGotOutOfDict();*/ }
//                         |   block                                 { /*emitFunctionEnd(); signalGotOutOfFunction(); $$ = "<func>";*/ }
//                         //|   func LPAREN comma_ids RPAREN inlined  { /*emitFunctionEndWithArgs($comma_ids); signalGotOutOfFunction();*/ }
//                         |   inlined                               { /*emitBlockEnd();*/ }
//                         //|   LPAREN expression RPAREN            { }
//                         |   expression PLUS_OP expression       { emitOp(ADD); }
//                         |   expression MINUS_OP expression      { emitOp(SUB); }
//                         |   expression MUL_OP expression        { emitOp(MUL); }
//                         |   IMPL_MUL                            {  }
//                         |   expression DIV_OP expression        { emitOp(DIV); }
//                         |   expression FDIV_OP expression       { emitOp(FDIV); }
//                         |   expression MOD_OP expression        { emitOp(MOD); }
//                         |   expression POW_OP expression        { emitOp(POW); }
//                         |   NEG_OP expression %prec NEG_PREC    { emitOp(NEG); }
//                         |   NOT_OP expression %prec NOT_PREC    { emitOp(NOT); }
//                         |   expression AND_OP expression        { emitOp(AND); }
//                         |   expression OR_OP expression         { emitOp(OR); }
//                         |   expression XOR_OP expression        { emitOp(XOR); }
//                         |   expression EQ_OP expression         { emitOp(CMPEQ); }
//                         |   expression NE_OP expression         { emitOp(CMPNE); }
//                         |   expression GT_OP expression         { emitOp(CMPGT); }
//                         |   expression GE_OP expression         { emitOp(CMPGE); }
//                         |   expression LT_OP expression         { emitOp(CMPLT); }
//                         |   expression LE_OP expression         { emitOp(CMPLE); }
//                         ;

//==============================
// Special tokens
//==============================

if_cmd                  :   IF_CMD                          { signalFoundIf(); printf("found IF\n"); }
                        ;

//==============================
// Statements
//==============================

label_statement         :   ID COLON statement              { processStore($ID); }
                        ;

call_statement          :   ID expressions                        { processCall($ID); }
                        |   expression DOT ID expressions         { processCall($ID); }
                        |   SYSCALL0                              { emitOp((OPCODE)$SYSCALL0); }
                        |   SYSCALL1 expression                   { emitOp((OPCODE)$SYSCALL1); }
                        |   SYSCALL2 expression expression        { emitOp((OPCODE)$SYSCALL2); }
                        |   expression DOT SYSCALL2 expression    { emitOp((OPCODE)$SYSCALL2); }
                        ;

special_statement       :   if_cmd expression block         { finalizeIf(); }
                        |   if_cmd expression block block   { finalizeIf(); }
                        ;

pipe_statement          :   ID PIPE statement               { }
                        |   SYSCALL1 PIPE statement         { emitOp((OPCODE)$SYSCALL1); }
                        ;

statement               :   label_statement
                        |   call_statement
                        |   special_statement
                        |   pipe_statement
                        |   expression
                        ;

statements              :   statements NL statement
                        |   statements COMMA statement
                        |   statements COMMA
                        |   statements NL
                        |   statement
                        |   
                        ;

//==============================
// Entry point
//==============================

program                 :   statements                      { emitOp(END); }
                        ;

// // number                  :   INTEGER             { doPushInt(strToIntValue($INTEGER)); }
// //                         |   BIG_INTEGER         { emitOpValue(PUSH,strToBigintValue($BIG_INTEGER)); }
// //                         |   BIN_INTEGER
// //                         |   OCT_INTEGER
// //                         |   HEX_INTEGER
// //                         |   REAL                { emitOpValue(PUSH,strToRealValue($REAL)); }
// //                         ;

// // piped_symbols           :   piped_symbols PIPE symbol
// //                         |   symbol
// //                         ;

// // comma_ids               :   comma_ids[prev] COMMA ID   { /* $$ = funcArgsAddArg($prev,$ID); emitLocalArgument($ID);*/ }
// //                         |   ID                   { /*$$ = funcArgsWithArg($ID); emitLocalArgument($ID);*/  }
// //                         ;

// // loop                    :   LOOP             { /*emitLoopStart();*/ }
// //                         ;

// // inlined_start             :   INLINE_START      { /*emitBlockStart();*/ }                   
// //                         ;

// // inlined_end               :   INLINE_END        {  }                     
// //                         ;

// // inlined                   :   inlined_start statements_section inlined_end     { }
// //                         ;

// // // implies                 :   IMPLIES { /*emitBlockStart();*/ }
// // //                         ;

// // // implied                 :   implies comma_statements NL
// // //                         |   implies comma_statements BLOCK_STOP
// // //                         ;

// // // function                :   FUNC inlined {  }    
// // //                         |   FUNC LPAREN comma_ids RPAREN inlined { /*emitFunctionEndWithArgs($comma_ids); printf("found function with comma_ids\n");*/ }
// // //                         |   implied { /*emitFunctionEnd();*/ }
// // //                         |   FUNC LPAREN comma_ids RPAREN implied { /*emitFunctionEnd();*/ }
// // //                         |   ACTION piped_symbols 
// // //                         ;

// // conditional_inlined       :   FUNC inlined { /*emitConditionalEnd();*/ }
// //                         ;

// //==============================
// // Expressions
// //==============================

// func                    : FUNC            { /*signalGotInFunction();*/ }
//                         ;
  
// array                   : ARRAY           { signalGotInArray(); }
//                         ;

// dict                    : DICT            { /*signalGotInDict();*/ }
//                         ;

// block_start             :   BLOCK_START    { signalGotInBlock(); }
//                         ;

// block_end               :   BLOCK_END      { signalGotOutOfBlock(); }
//                         ;

// block                   :   block_start statements_section block_end { printf("found block!\n"); }
//                         |   LPAREN comma_ids RPAREN block_start statements_section block_end
//                         ;


// expression              :   STRING                              { emitOpValue(PUSH, strToStringValue($STRING)); }
//                         |   number                              {  }
//                         |   symbol                              { processLoad($symbol); }
//                         |   array inlined                         { signalGotOutOfArray(); }
//                         |   range                               { }
//                         |   dict inlined                          { /*signalGotOutOfDict();*/ }
//                         |   block                                 { /*emitFunctionEnd(); signalGotOutOfFunction(); $$ = "<func>";*/ }
//                         //|   func LPAREN comma_ids RPAREN inlined  { /*emitFunctionEndWithArgs($comma_ids); signalGotOutOfFunction();*/ }
//                         |   inlined                               { /*emitBlockEnd();*/ }
//                         //|   LPAREN expression RPAREN            { }
//                         |   expression PLUS_OP expression       { emitOp(ADD); }
//                         |   expression MINUS_OP expression      { emitOp(SUB); }
//                         |   expression MUL_OP expression        { emitOp(MUL); }
//                         |   IMPL_MUL                            {  }
//                         |   expression DIV_OP expression        { emitOp(DIV); }
//                         |   expression FDIV_OP expression       { emitOp(FDIV); }
//                         |   expression MOD_OP expression        { emitOp(MOD); }
//                         |   expression POW_OP expression        { emitOp(POW); }
//                         |   NEG_OP expression %prec NEG_PREC    { emitOp(NEG); }
//                         |   NOT_OP expression %prec NOT_PREC    { emitOp(NOT); }
//                         |   expression AND_OP expression        { emitOp(AND); }
//                         |   expression OR_OP expression         { emitOp(OR); }
//                         |   expression XOR_OP expression        { emitOp(XOR); }
//                         |   expression EQ_OP expression         { emitOp(CMPEQ); }
//                         |   expression NE_OP expression         { emitOp(CMPNE); }
//                         |   expression GT_OP expression         { emitOp(CMPGT); }
//                         |   expression GE_OP expression         { emitOp(CMPGE); }
//                         |   expression LT_OP expression         { emitOp(CMPLT); }
//                         |   expression LE_OP expression         { emitOp(CMPLE); }
//                         ;

// expressions             :   expressions expression             { }
//                         |   expression                         { }
//                         ;

// //==============================
// // Statements
// //==============================

// call_statement          :   symbol expressions        { /*emitCall($symbol);*/ }
//                         |   IF expression conditional_inlined          { /*emitOp(JMPIF);*/ }
//                         |   IF expression conditional_inlined conditional_inlined { /*emitOp(JMPIFE);*/ }
//                         |   loop expression conditional_inlined        { /*emitLoop();*/ }
//                         |   RETURN expression               { /*emitOp(RET);*/ }
//                         |   SYSCMD1 expression      { emitOp((OPCODE)$SYSCMD1); }
//                         ;

// label_statement         :   symbol LABEL statement          { processStore($symbol); }
//                         ;

// piped_statement         :   symbol PIPE statement           { /*emitCall($symbol);*/ }
//                         |   SYSCMD1 PIPE statement          { /*emitOp($SYSCMD1);*/ }
//                         ;

// inplace_statement       :   symbol INPLACE SYSCMD1 expression     { /*processInPlace((OPCODE)$SYSCMD1,$symbol);*/ }
//                         |   symbol INPLACE SYSCMD0                { /*processInPlace((OPCODE)$SYSCMD0,$symbol);*/ }
//                         ;

// statement               :   call_statement                  { }
//                         |   label_statement                 { }
//                         |   inplace_statement               { }
//                         |   expression                      { }
//                         |   piped_statement           {  }
//                         ;

// comma_statements        :   comma_statements COMMA statement
//                         |   statement
//                         ;

// statements              :   statements NL statement         {  }
//                         |   comma_statements
//                         ;

// statements_section      :   statements
//                         |   statements NL
//                         |   NL statements
//                         |   NL statements NL
//                         ;

// //==============================
// // Entry point
// //==============================

// program                 :   statements_section              { emitOp(END); }
//                         ;

%%
