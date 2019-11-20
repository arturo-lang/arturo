#[****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import algorithm, base64, bitops, hashes, httpClient, json, macros, math, md5, os, osproc
import parsecsv, parseutils, random, re, sequtils, std/editdistance, std/sha1
import streams, strformat, strutils, sugar, unicode, tables, terminal
import times, uri

import external/[bignum, markdown, mustache]
import panic, utils

#[######################################################
    Type definitions
  ======================================================]#

type
    #[----------------------------------------
        KeyPath
      ----------------------------------------]#

    KeyPathPartKind {.size: sizeof(cint),pure.} = enum
        stringKeyPathPart,
        integerKeyPathPart,
        inlineKeyPathPart

    KeyPathPart = ref object
        case kind: KeyPathPartKind:
            of stringKeyPathPart    : s: string
            of integerKeyPathPart   : i: int
            of inlineKeyPathPart    : a: Argument

    KeyPath = ref object
        parts: seq[KeyPathPart]
                
    #[----------------------------------------
        Argument
      ----------------------------------------]#
    
    ArgumentKind {.size: sizeof(cint),pure.} = enum
        identifierArgument, 
        literalArgument,
        arrayArgument,
        dictionaryArgument,
        functionArgument,
        inlineCallArgument

    Argument = ref object
        case kind: ArgumentKind:
            of identifierArgument   : i: int
            of literalArgument      : v: Value
            of arrayArgument        : a: ExpressionList
            of dictionaryArgument   : d: StatementList
            of functionArgument     : f: Function
            of inlineCallArgument   : c: Statement

    #[----------------------------------------
        Expression
      ----------------------------------------]#

    ExpressionOperator {.size: sizeof(cint),pure.} = enum
        PLUS_SG, MINUS_SG, MULT_SG, DIV_SG, MOD_SG, POW_SG,
        EQ_OP, LT_OP, GT_OP, LE_OP, GE_OP, NE_OP

    ExpressionKind = enum
        argumentExpression, 
        normalExpression

    Expression = ref object
        case kind: ExpressionKind:
            of argumentExpression:
                a       : Argument
            of normalExpression:
                left    : Expression
                op      : ExpressionOperator
                right   : Expression

    #[----------------------------------------
        ExpressionList
      ----------------------------------------]#

    ExpressionList = ref object
        list    : seq[Expression]

    #[----------------------------------------
        Statement
      ----------------------------------------]#

    StatementKind {.size: sizeof(cint),pure.} = enum
        commandStatement,
        callStatement,
        assignmentStatement,
        expressionStatement,

    Statement = ref object
        pos: int
        case kind: StatementKind:
            of commandStatement:
                code            : int
                arguments       : ExpressionList
            of callStatement:
                id              : int
                expressions     : ExpressionList
            of assignmentStatement:
                symbol          : int
                rValue          : Statement
            of expressionStatement:
                expression      : Expression

    #[----------------------------------------
        StatementList
      ----------------------------------------]#

    StatementList = ref object
        list    : seq[Statement]

    #[----------------------------------------
        Function
      ----------------------------------------]#

    SystemFunctionCall[F,X,V]   = proc(f: F, xl: X): V {.inline.}

    FunctionConstraints         = seq[seq[ValueKind]]
    FunctionReturns             = seq[ValueKind]

    SystemFunction* = ref object
        lib*            : string
        call*           : SystemFunctionCall[SystemFunction,ExpressionList,Value]
        name*           : string
        req*            : FunctionConstraints
        ret*            : FunctionReturns
        desc*           : string

    Function* = ref object
        id              : int
        args            : seq[int]
        hasNamedArgs    : bool
        body            : StatementList
        hasContext      : bool
        parentThis      : Value
        parentContext   : Context

    #[----------------------------------------
        General types
      ----------------------------------------]#

    Array = seq[Value]

    Context = ref object
        list    : seq[(int,Value)]

    #[----------------------------------------
        Value
      ----------------------------------------]#

    ValueKind* = int
    Value* = uint64

    ValueRef {.union.} = ref object
        s: string
        bi: Int
        a: Array
        d: Context
        f: Function

    #[----------------------------------------
        C interface
      ----------------------------------------]#

    yy_buffer_state {.importc.} = ref object
        yy_input_file       : File
        yy_ch_buf           : cstring
        yy_buf_pos          : cstring
        yy_buf_size         : clong
        yy_n_chars          : cint
        yy_is_our_buffer    : cint
        yy_is_interactive   : cint
        yy_at_bol           : cint
        yy_fill_buffer      : cint
        yy_buffer_status    : cint

#[######################################################
    Constants
  ======================================================]#

const
    ARGV        = "&"
    ARGV_HASH   = ARGV.hash

    MAX_INT     = 0xffffffffffffff

    NV          = 0
    IV          = 1
    BIV         = 2
    RV          = 4
    BV          = 8
    SV          = 16
    AV          = 32
    DV          = 64
    FV          = 128
    ANY         = 255

    FIELD       = 56

    IV_MASK     = cast[Value](IV shl FIELD)
    BIV_MASK    = cast[Value](BIV shl FIELD)
    RV_MASK     = cast[Value](RV shl FIELD)
    BV_MASK     = cast[Value](BV shl FIELD)
    SV_MASK     = cast[Value](SV shl FIELD)
    AV_MASK     = cast[Value](AV shl FIELD)
    DV_MASK     = cast[Value](DV shl FIELD)
    FV_MASK     = cast[Value](FV shl FIELD)
    MASK        = cast[Value](0xff00000000000000)
    UNMASK      = bitnot(MASK)

#[######################################################
    Globals
  ======================================================]#

var
    MainProgram {.exportc.} : StatementList

    # Environment

    Stack*                  : seq[Context]
    FileName                : string
    Paths                   : seq[string]

    Returned                : Value
    StatementLine           : int

    # Const literal arguments

    ConstArgExprs           : TableRef[Argument,Expression]

    ConstIds                : TableRef[cstring,Argument]
    ConstCmds               : TableRef[cint,Argument]
    ConstStrings            : TableRef[cstring,Argument]
    ConstInts               : TableRef[cstring,Argument]
    Hashes                  : Table[cstring,int]

    TRUE                    : Value
    FALSE                   : Value
    NULL                    : Value

#[######################################################
    Forward declarations
  ======================================================]#

# Context

proc updateOrSet(ctx: var Context, k: string, v: Value) {.inline.}
proc keys*(ctx: Context): seq[string] {.inline.}
proc values*(ctx: Context): seq[Value] {.inline.}
proc getValueForKey*(ctx: Context, key: string): Value {.inline.}
proc inspectStack()

# Value

proc SINT(v: string): Value {.inline.}
proc BIGINT*(v: string): Value {.inline.}
proc REAL(v: string): Value {.inline.}
proc STRARR(v: seq[string]): Value {.inline.}
proc INTARR(v: seq[int]): Value {.inline.}
proc BIGINTARR(v: seq[Int]): Value {.inline.}
proc REALARR(v: seq[float]): Value {.inline.}
proc BOOLARR(v: seq[bool]): Value {.inline.}
proc DICT(v: seq[(string,Value)]): Value {.inline.}
proc valueCopy(v: Value): Value {.inline.}
proc findValueInArray(v: Value, lookup: Value): int
proc findValueInArray(v: seq[Value], lookup: Value): int
proc `++`(l: Value, r: Value): Value {.inline.}
proc `--`(l: Value, r: Value): Value {.inline.}
proc `**`(l: Value, r: Value): Value {.inline.}
proc `//`(l: Value, r: Value): Value {.inline.}
proc `%%`(l: Value, r: Value): Value {.inline.}
proc `^^`(l: Value, r: Value): Value {.inline.}
proc eq(l: Value, r: Value): bool {.inline.}
proc lt(l: Value, r: Value): bool {.inline.}
proc gt(l: Value, r: Value): bool {.inline.}
proc valueKindToPrintable*(s: string): string
proc stringify*(v: Value, quoted: bool = true): string {.inline.}
proc inspect*(v: Value, prepend: int = 0, isKeyVal: bool = false): string

# Function

proc getSystemFunction*(n: string): int {.inline.}
proc getSystemFunctionInstance*(n: string): SystemFunction {.inline.}
proc callFunction(f: string, v: seq[Value]): Value
proc execute(f: Function, v: Value): Value {.inline.} 
proc validate(x: Expression, name: string, req: int): Value {.inline.}
proc validate(x: Expression, name: string, req: openArray[ValueKind]): Value {.inline.}
proc validate(xl: ExpressionList, f: SystemFunction): seq[Value] {.inline.}

# Expression

proc expressionFromArgument(a: Argument): Expression {.exportc.}
proc evaluate(x: Expression): Value {.inline.}

# ExpressionList

proc newExpressionList: ExpressionList {.exportc.}
proc newExpressionList(xl: seq[Expression]): ExpressionList
proc addExpression(xl: ExpressionList, x: Expression): ExpressionList {.exportc.}
proc evaluate(xl: ExpressionList, forceArray: bool=false): Value {.inline.}

# Statement

proc statementFromCommand(i: cint, xl: ExpressionList, l: cint): Statement {.exportc.}
proc statementFromCall(i: cstring, xl: ExpressionList, l: cint=0): Statement {.exportc.}
proc statementFromCallWithKeypath(k: KeyPath, xl: ExpressionList, l: cint=0): Statement {.exportc.}
proc execute(stm: Statement, parent: Value = 0): Value {.inline.}

# StatementList

proc newStatementList: StatementList {.exportc.}
proc newStatementList(sl: seq[Statement]): StatementList
proc newStatementListWithStatement(s: Statement): StatementList {.exportc.}
proc addStatement(sl: StatementList, s: Statement): StatementList {.exportc.}
proc execute(sl: StatementList): Value {.inline.}

# Argument

proc argumentFromIdentifier(i: cstring): Argument {.exportc.}
proc argumentFromCommandIdentifier(i: cint): Argument {.exportc.}
proc argumentFromStringLiteral(l: cstring): Argument {.exportc.}
proc argumentFromIntegerLiteral(l: cstring): Argument {.exportc.}
proc argumentFromInlineCallLiteral(l: Statement): Argument {.exportc.}
proc argumentFromCommand(cmd: cint, xl: ExpressionList): Argument
proc hash(a: Argument): Hash {.inline.}    
proc getValue(a: Argument): Value {.inline.}

# Setup

proc setup*(args: seq[string] = @[])

# Parser C Interface

proc yyparse(): cint {.importc.}

proc yy_scan_string(str: cstring): yy_buffer_state {.importc.}
proc yy_switch_to_buffer(buff: yy_buffer_state) {.importc.}
proc yy_delete_buffer(buff: yy_buffer_state) {.importc.}

var yyfilename {.importc.}: cstring
var yyin {.importc.}: File
var yylineno {.importc.}: cint

#[######################################################
    Global templates
  ======================================================]#

template kind*(v: Value): int       = cast[int](bitand(v,MASK) shr FIELD)
    
template S(_:Value):string          = (cast[ValueRef](bitand(_,UNMASK))).s
template I(_:Value):int             = cast[int](bitand(_,UNMASK))
template BI(_:Value):Int            = (cast[ValueRef](bitand(_,UNMASK))).bi
template R(_:Value):float           = cast[float](bitand(_,UNMASK))
template B(_:Value):bool            = cast[bool](bitand(_,UNMASK))
template A(_:Value):seq[Value]      = (cast[ValueRef](bitand(_,UNMASK))).a
template D(_:Value):Context         = (cast[ValueRef](bitand(_,UNMASK))).d
template FN(_:Value):Function       = cast[Function](bitand(_,UNMASK))

template STR(v:string):Value        = bitor(cast[Value](ValueRef(s:v)),SV_MASK)
template SINT(v:int):Value          = bitor(cast[Value](v),IV_MASK)
template BIGINT(v:Int):Value        = bitor(cast[Value](ValueRef(bi:v)),BIV_MASK)
template REAL(v:float):Value        = bitor(cast[Value](v),RV_MASK)
template BOOL(v:bool):Value         = bitor(cast[Value](v),BV_MASK)
template ARR(v:seq[Value]):Value    = bitor(cast[Value](ValueRef(a:v)),AV_MASK)
template DICT(v:Context):Value      = bitor(cast[Value](ValueRef(d:v)),DV_MASK)
template FUNC(v:Function):Value     = bitor(cast[Value](v),FV_MASK)   

template VALID(i:int, r:int): Value {.dirty.} =
    xl.list[i].validate(f.name,r)

#[######################################################
    Unittest setup
  ======================================================]#

when defined(unittest):
    
    import unittest 

    setup()

#[######################################################
    System library
  ======================================================]#

include lib/system

#[######################################################
    Helpers
  ======================================================]#

proc storeOrGetHash(k:cstring):int {.inline.}=
    if Hashes.hasKey(k):
        result = Hashes[k]
    else:
        let hsh = k.hash
        Hashes[k]=hsh
        result = hsh

proc storeOrGetHash(k:string):int {.inline.}=
    if Hashes.hasKey(k):
        result = Hashes[k]
    else:
        let hsh = k.hash
        Hashes[k]=hsh
        result = hsh

#[######################################################
    CORE OBJECTS
  ======================================================]#

include core/context
include core/value
include core/function
include core/keypath
include core/expression
include core/expression_list
include core/argument
include core/statement
include core/statement_list

#[######################################################
    Environment setup
  =====================================================]#

template initializeConsts() =
    ## Setup global constant values that are to be re-used throughout the code

    ConstArgExprs   = newTable[Argument,Expression]()

    ConstIds        = newTable[cstring,Argument]()
    ConstCmds       = newTable[cint,Argument]()
    ConstStrings    = newTable[cstring,Argument]()
    ConstInts       = newTable[cstring,Argument]()
    TRUE            = BOOL(true)
    FALSE           = BOOL(false)
    NULL            = NV
    Hashes          = {cstring(ARGV):ARGV_HASH}.toTable

proc setup*(args: seq[string] = @[]) = 
    initializeConsts()
    Stack = newSeqOfCap[Context](2)
    addContext() # global
    initTopContextWith(ARGV_HASH, ARR(args.map((x) => STR(x))))

#[######################################################
    MAIN ENTRY
  ======================================================]#

proc runString*(src:string): string =
    ## Run a specific script from given string and return string output
    ## ! Used mainly from the Console module

    if not Paths.contains(getCurrentDir()):
        Paths.add(getCurrentDir())

    var buff = yy_scan_string(src)

    yylineno = 0
    yyfilename = "<repl>"
    FileName = "<repl>"

    QuitOnError = false

    yy_switch_to_buffer(buff)

    MainProgram = nil
    if yyparse()==0:
        yy_delete_buffer(buff)

        try:
            result = MainProgram.execute().stringify()
        except NilAccessError as e:
            runtimeError(e.msg, FileName, 1)


proc runScript*(scriptPath:string, args: seq[string], includePath:string="") = 
    ## Run a specific script from given path
    ## ! This is the main entry procedure

    if not fileExists(scriptPath): 
        cmdlineError("path not found: '" & scriptPath & "'")

    var (dir, _, _) = splitFile(scriptPath)
    Paths.add(dir)
    Paths.add(includePath)

    setup(args)

    yylineno = 0
    yyfilename = scriptPath
    FileName = scriptPath

    QuitOnError = true

    discard open(yyin, scriptPath)
    #benchmark "parsing":
    if yyparse()==0:
        try:
            discard MainProgram.execute()
        except Exception as e:
            runtimeError(e.msg, FileName, StatementLine)
        except NilAccessError as e:
            runtimeError(e.msg, FileName, 1)


#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Compiler":

        test "arithmetic operators":
            check(runString("1+1") == "2" )
            check(runString("1-1") == "0" )
            check(runString("1*1") == "1" )
            check(runString("1/1") == "1" )
            check(runString("5%2") == "1" )
            check(runString("2^3") == "8" )
            check(runString("1+2*3") == "7" )
            check(runString("(1+2)*3") == "9" )


        test "comparison operators":
            check(runString("1=1") == "true" )
            check(runString("1=2") == "false" )
            check(runString("1>1") == "false" )
            check(runString("2>1") == "true" )
            check(runString("2<1") == "false" )
            check(runString("5!=5") == "false" )
            check(runString("5!=7") == "true" )
            check(runString("2>=1") == "true" )
            check(runString("2>=2") == "true" )
            check(runString("2>=3") == "false" )
            check(runString("2<=1") == "false" )
            check(runString("2<=3") == "true" )
