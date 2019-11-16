#[****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import algorithm, base64, bitops, httpClient, json, macros, math, md5, os, osproc
import parsecsv, parseutils, random, re, segfaults, sequtils, std/editdistance
import std/sha1, streams, strformat, strutils, sugar, unicode, tables, terminal
import times, uri

import bignum, markdown, mustache
import panic, utils

#[######################################################
    Type definitions
  ======================================================]#

type
    #[----------------------------------------
        Stack
      ----------------------------------------]#

    Context = ref object
        list    : seq[(string,Value)]

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
            of identifierArgument   : i: string
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
                id              : string
                expressions     : ExpressionList
            of assignmentStatement:
                symbol          : string
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
        id              : string
        args            : seq[string]
        hasNamedArgs    : bool
        body            : StatementList
        hasContext      : bool
        parentThis      : Value
        parentContext   : Context

    #[----------------------------------------
        Value
      ----------------------------------------]#

    ValueKind* {.pure.} = enum
        stringValue, integerValue, bigIntegerValue, realValue, booleanValue,
        arrayValue, dictionaryValue, functionValue,
        nullValue, anyValue

    Value* = ref object
        case kind*: ValueKind:
            of stringValue          : s*: string
            of integerValue         : i*: int
            of bigIntegerValue      : bi*: Int
            of realValue            : r*: float
            of booleanValue         : b*: bool 
            of arrayValue           : a*: seq[Value]
            of dictionaryValue      : d*: Context
            of functionValue        : f*: Function
            of nullValue            : discard
            of anyValue             : discard

    #[----------------------------------------
        Returns
      ----------------------------------------]#

    ReturnValue* = object of Exception
        value: Value

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

proc INT(v: string): Value {.inline.}
proc BIGINT*(v: string): Value {.inline.}
proc REAL(v: string): Value {.inline.}
proc STRARR(v: seq[string]): Value {.inline.}
proc INTARR(v: seq[int]): Value {.inline.}
proc BIGINTARR(v: seq[Int]): Value {.inline.}
proc REALARR(v: seq[float]): Value {.inline.}
proc BOOLARR(v: seq[bool]): Value {.inline.}
proc DICT(v: seq[(string,Value)]): Value {.inline.}
proc valueCopy(v: Value): Value {.inline.}
template valueSet(lValue: var Value, rValue: Value) =
    {.computedGoto.}
    case rValue.kind
        of SV:  lValue.kind=SV; lValue.s=rValue.s
        of IV:  lValue.kind=IV; lValue.i=rValue.i
        of BIV: lValue.kind=BIV; lValue.bi=rValue.bi
        of RV:  lValue.kind=RV; lValue.r=rValue.r
        of BV:  shallowCopy(lValue,rValue)
        of AV:  lValue = rValue#lValue.kind=AV; lValue.a = rValue.a
        of DV:  deepCopy(lValue,rValue) # lValue.kind=DV; lValue.d=rValue.d
        of FV:  deepCopy(lValue,rValue) #.kind=FV; lValue.f=rValue.f
        of NV:  shallowCopy(lValue,rValue)
        of ANY: discard
proc findValueInArray(v: Value, lookup: Value): int
proc findValueInArray(v: seq[Value], lookup: Value): int
proc `+`(l: Value, r: Value): Value {.inline.}
proc `-`(l: Value, r: Value): Value {.inline.}
proc `*`(l: Value, r: Value): Value {.inline.}
proc `/`(l: Value, r: Value): Value {.inline.}
proc `%`(l: Value, r: Value): Value {.inline.}
proc `^`(l: Value, r: Value): Value {.inline.}
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
proc execute(stm: Statement, parent: Value = nil): Value {.inline.}

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
proc getValue(a: Argument): Value {.inline.}

# Setup

proc setup*(args: seq[string] = @[])

#[######################################################
    Parser C Interface
  ======================================================]#

type
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

proc yyparse(): cint {.importc.}
proc yy_scan_buffer(buff: cstring, s: csize) {.importc.}

proc yy_scan_string(str: cstring): yy_buffer_state {.importc.}
proc yy_switch_to_buffer(buff: yy_buffer_state) {.importc.}
proc yy_delete_buffer(buff: yy_buffer_state) {.importc.}

var yyfilename {.importc.}: cstring
var yyin {.importc.}: File
var yylineno {.importc.}: cint

var isRepl {.importc.}: cint

#[######################################################
    Constants
  ======================================================]#

const
    ARGV                    = "&"

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

    ConstStrings            : TableRef[string,Argument]

    TRUE                    : Value
    FALSE                   : Value
    NULL                    : Value

#[######################################################
    Aliases
  ======================================================]#

template SV():ValueKind         = stringValue
template IV():ValueKind         = integerValue
template BIV():ValueKind        = bigIntegerValue
template RV():ValueKind         = realValue
template BV():ValueKind         = booleanValue
template AV():ValueKind         = arrayValue
template DV():ValueKind         = dictionaryValue
template FV():ValueKind         = functionValue
template NV():ValueKind         = nullValue
template ANY():ValueKind        = anyValue

template S(_:int):string        = v[_].s
template I(_:int):int           = v[_].i
template BI(_:int):Int          = v[_].bi
template R(_:int):float         = v[_].r
template B(_:int):bool          = v[_].b
template A(_:int):seq[Value]    = v[_].a
template D(_:int):Context       = v[_].d
template FN(_:int):Function     = v[_].f

template STR(v:string):Value        = Value(kind: SV, s: v)
template INT(v:int):Value           = Value(kind: IV, i: v)
template BIGINT(v:Int):Value        = Value(kind: BIV, bi: v)
template REAL(v:float):Value        = Value(kind: RV, r: v)
template BOOL(v:bool):Value         = ( if v: TRUE else: FALSE )
template ARR(v:seq[Value]):Value    = Value(kind: AV, a: v)
template DICT(v:Context):Value      = Value(kind: DV, d: v)
template FUNC(v:Function):Value     = Value(kind: FV, f: v)        

#[######################################################
    Unittest setup
  ======================================================]#

when defined(unittest):
    
    import unittest 

    setup()

#[######################################################
    System library
  ======================================================]#

include lib/system/array
include lib/system/convert
include lib/system/core
include lib/system/crypto
include lib/system/csv
include lib/system/dictionary
include lib/system/generic
include lib/system/io
include lib/system/json
include lib/system/logical
include lib/system/math
include lib/system/net
include lib/system/path
include lib/system/reflection
include lib/system/string
include lib/system/terminal
include lib/system/time
include lib/system/url

##---------------------------
## Function registration
##---------------------------

let 
    SystemFunctions* = @[
        #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        #              Library              Name                        Call                            Args                                                                                Return                  Description                                                                                             
        #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        SystemFunction(lib:"array",         name:"all",                 call:Array_all,                 req: @[@[AV],@[AV,FV]],                                                             ret: @[BV],             desc:"check if all elements of array are true or pass the condition of given function"),
        SystemFunction(lib:"array",         name:"any",                 call:Array_any,                 req: @[@[AV],@[AV,FV]],                                                             ret: @[BV],             desc:"check if any elements of array are true or pass the condition of given function"),
        SystemFunction(lib:"array",         name:"count",               call:Array_count,               req: @[@[AV,FV]],                                                                   ret: @[IV],             desc:"get number of elements from array that pass given condition"),
        SystemFunction(lib:"array",         name:"filter",              call:Array_filter,              req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after filtering each element using given function"),
        SystemFunction(lib:"array",         name:"filter!",             call:Array_filterI,             req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after filtering each element using given function (in-place)"),
        SystemFunction(lib:"array",         name:"first",               call:Array_first,               req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get first element of given array"),
        SystemFunction(lib:"array",         name:"fold",                call:Array_fold,                req: @[@[AV,IV,FV],@[AV,BIV,FV],@[AV,SV,FV],@[AV,AV,FV],@[AV,DV,FV]],               ret: @[IV,BIV,SV,AV,DV],desc:"fold array using seed value and the given function"),
        SystemFunction(lib:"array",         name:"last",                call:Array_last,                req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array"),
        SystemFunction(lib:"array",         name:"map",                 call:Array_map,                 req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after executing given function for each element"),
        SystemFunction(lib:"array",         name:"map!",                call:Array_mapI,                req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after executing given function for each element (in-place)"),
        SystemFunction(lib:"array",         name:"permutations",        call:Array_permutations,        req: @[@[AV]],                                                                      ret: @[AV],             desc:"get all permutations for given array"),
        SystemFunction(lib:"array",         name:"pop",                 call:Array_pop,                 req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array (same as 'last')"),
        SystemFunction(lib:"array",         name:"pop!",                call:Array_popI,                req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array and delete it (in-place)"),
        SystemFunction(lib:"array",         name:"range",               call:Array_range,               req: @[@[IV,IV]],                                                                   ret: @[AV],             desc:"get array from given range (from..to)"),
        SystemFunction(lib:"array",         name:"rangeBy",             call:Array_rangeBy,             req: @[@[IV,IV,IV]],                                                                ret: @[AV],             desc:"get array from given range (from..to) with step"),
        SystemFunction(lib:"array",         name:"rotate",              call:Array_rotate,              req: @[@[AV],@[AV,IV]],                                                             ret: @[AV],             desc:"rotate given array, optionally by using step; negative values for left rotation"),
        SystemFunction(lib:"array",         name:"rotate!",             call:Array_rotateI,             req: @[@[AV],@[AV,IV]],                                                             ret: @[AV],             desc:"rotate given array, optionally by using step; negative values for left rotation (in-place)"),
        SystemFunction(lib:"array",         name:"sample",              call:Array_sample,              req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get random sample from given array"),
        SystemFunction(lib:"array",         name:"shuffle",             call:Array_shuffle,             req: @[@[AV]],                                                                      ret: @[AV],             desc:"shuffle given array"),
        SystemFunction(lib:"array",         name:"shuffle!",            call:Array_shuffleI,            req: @[@[AV]],                                                                      ret: @[AV],             desc:"shuffle given array (in-place)"),
        SystemFunction(lib:"array",         name:"sort",                call:Array_sort,                req: @[@[AV]],                                                                      ret: @[AV],             desc:"sort given array"),
        SystemFunction(lib:"array",         name:"sort!",               call:Array_sortI,               req: @[@[AV]],                                                                      ret: @[AV],             desc:"sort given array (in-place)"),
        SystemFunction(lib:"array",         name:"swap",                call:Array_swap,                req: @[@[AV,IV,IV]],                                                                ret: @[AV],             desc:"swap array elements at given indices"),
        SystemFunction(lib:"array",         name:"swap!",               call:Array_swapI,               req: @[@[AV,IV,IV]],                                                                ret: @[AV],             desc:"swap array elements at given indices (in-place)"),
        SystemFunction(lib:"array",         name:"unique",              call:Array_unique,              req: @[@[AV]],                                                                      ret: @[AV],             desc:"remove duplicates from given array"),
        SystemFunction(lib:"array",         name:"unique!",             call:Array_uniqueI,             req: @[@[AV]],                                                                      ret: @[AV],             desc:"remove duplicates from given array (in-place)"),
        SystemFunction(lib:"array",         name:"zip",                 call:Array_zip,                 req: @[@[AV,AV]],                                                                   ret: @[AV],             desc:"get array of element pairs using given arrays"),

        SystemFunction(lib:"convert",       name:"toBin",               call:Convert_toBin,             req: @[@[IV]],                                                                      ret: @[SV],             desc:"convert given number to its binary string representation"),
        SystemFunction(lib:"convert",       name:"toHex",               call:Convert_toHex,             req: @[@[IV]],                                                                      ret: @[SV],             desc:"convert given number to its hexadecimal string representation"),
        SystemFunction(lib:"convert",       name:"toNumber",            call:Convert_toNumber,          req: @[@[SV],@[RV],@[BV]],                                                                ret: @[IV],             desc:"convert given string, real or boolean to an integer number"),
        SystemFunction(lib:"convert",       name:"toOct",               call:Convert_toOct,             req: @[@[IV]],                                                                      ret: @[SV],             desc:"convert given number to its octal string representation"),
        SystemFunction(lib:"convert",       name:"toReal",              call:Convert_toReal,            req: @[@[IV]],                                                                      ret: @[SV],             desc:"convert given integer number to real"),
        SystemFunction(lib:"convert",       name:"toString",            call:Convert_toString,          req: @[@[SV],@[IV],@[BIV],@[RV],@[AV],@[DV],@[FV],@[NV]],                           ret: @[SV],             desc:"convert given value to string"),

        SystemFunction(lib:"core",          name:"exec",                call:Core_exec,                 req: @[@[FV,AV]],                                                                   ret: @[ANY],            desc:"execute function using given array of values"),
        SystemFunction(lib:"core",          name:"if",                  call:Core_if,                   req: @[@[BV,FV],@[BV,FV,FV]],                                                       ret: @[ANY],            desc:"if condition is true, execute given function; else execute optional alternative function"),
        SystemFunction(lib:"core",          name:"import",              call:Core_import,               req: @[@[SV]],                                                                      ret: @[ANY],            desc:"import module or object in given script path"),
        SystemFunction(lib:"core",          name:"loop",                call:Core_loop,                 req: @[@[AV,FV],@[DV,FV],@[BV,FV],@[IV,FV]],                                        ret: @[ANY],            desc:"execute given function for each element in collection, or while condition is true"),
        SystemFunction(lib:"core",          name:"new",                 call:Core_new,                  req: @[@[SV],@[IV],@[BIV],@[RV],@[BV],@[AV],@[DV],@[FV]],                           ret: @[ANY],            desc:"get new copy of given object"),
        SystemFunction(lib:"core",          name:"panic",               call:Core_panic,                req: @[@[SV]],                                                                      ret: @[SV],             desc:"exit program printing given error message"),
        SystemFunction(lib:"core",          name:"return",              call:Core_return,               req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV]],                                 ret: @[ANY],            desc:"break execution and return given value"),
        SystemFunction(lib:"core",          name:"syms",                call:Core_syms,                 req: @[@[NV]],                                                                      ret: @[ANY],            desc:"break execution and return given value"),

        SystemFunction(lib:"crypto",        name:"decodeBase64",        call:Crypto_decodeBase64,       req: @[@[SV]],                                                                      ret: @[SV],             desc:"Base64-decode given string"),
        SystemFunction(lib:"crypto",        name:"decodeBase64!",       call:Crypto_decodeBase64I,      req: @[@[SV]],                                                                      ret: @[SV],             desc:"Base64-decode given string (in-place)"),
        SystemFunction(lib:"crypto",        name:"encodeBase64",        call:Crypto_encodeBase64,       req: @[@[SV]],                                                                      ret: @[SV],             desc:"Base64-encode given string"),
        SystemFunction(lib:"crypto",        name:"encodeBase64!",       call:Crypto_encodeBase64I,      req: @[@[SV]],                                                                      ret: @[SV],             desc:"Base64-encode given string (in-place)"),
        SystemFunction(lib:"crypto",        name:"md5",                 call:Crypto_md5,                req: @[@[SV]],                                                                      ret: @[SV],             desc:"MD5-encrypt given string"),
        SystemFunction(lib:"crypto",        name:"md5!",                call:Crypto_md5I,               req: @[@[SV]],                                                                      ret: @[SV],             desc:"MD5-encrypt given string (in-place)"),
        SystemFunction(lib:"crypto",        name:"sha1",                call:Crypto_sha1,               req: @[@[SV]],                                                                      ret: @[SV],             desc:"SHA1-encrypt given string"),
        SystemFunction(lib:"crypto",        name:"sha1!",               call:Crypto_sha1I,              req: @[@[SV]],                                                                      ret: @[SV],             desc:"SHA1-encrypt given string (in-place)"),

        SystemFunction(lib:"csv",           name:"generateCsv",         call:Csv_generateCsv,           req: @[@[AV]],                                                                      ret: @[SV],             desc:"get CSV string from given array of rows"),
        SystemFunction(lib:"csv",           name:"parseCsv",            call:Csv_parseCsv,              req: @[@[SV],@[SV,BV]],                                                             ret: @[AV],             desc:"get array of rows by parsing given CSV string, optionally using headers"),

        SystemFunction(lib:"dictionary",    name:"hasKey",              call:Dictionary_hasKey,         req: @[@[DV,SV]],                                                                   ret: @[BV],             desc:"check if dictionary contains key"),
        SystemFunction(lib:"dictionary",    name:"keys",                call:Dictionary_keys,           req: @[@[DV]],                                                                      ret: @[AV],             desc:"get array of dictionary keys"),
        SystemFunction(lib:"dictionary",    name:"values",              call:Dictionary_values,         req: @[@[DV]],                                                                      ret: @[AV],             desc:"get array of dictionary values"),  

        SystemFunction(lib:"generic",       name:"append",              call:Generic_append,            req: @[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],@[SV,SV]],   ret: @[AV,SV],          desc:"append element to given array/string"),
        SystemFunction(lib:"generic",       name:"append!",             call:Generic_appendI,           req: @[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],@[SV,SV]],   ret: @[AV,SV],          desc:"append element to given array/string (in-place)"),
        SystemFunction(lib:"generic",       name:"contains",            call:Generic_contains,          req: @[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],
                                                                                                               @[DV,SV],@[DV,IV],@[DV,BIV],@[DV,BV],@[DV,AV],@[DV,DV],@[DV,FV],@[SV,SV]],   ret: @[BV],             desc:"check if collection contains given element"),
        SystemFunction(lib:"generic",       name:"delete",              call:Generic_delete,            req: @[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],
                                                                                                               @[DV,SV],@[DV,IV],@[DV,BIV],@[DV,BV],@[DV,AV],@[DV,DV],@[DV,FV],@[SV,SV]],   ret: @[AV,SV,DV],       desc:"delete value from given array, dictionary or string"),
        SystemFunction(lib:"generic",       name:"delete!",             call:Generic_deleteI,           req: @[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],
                                                                                                               @[DV,SV],@[DV,IV],@[DV,BIV],@[DV,BV],@[DV,AV],@[DV,DV],@[DV,FV],@[SV,SV]],   ret: @[AV,SV,DV],       desc:"delete value from given array, dictionary or string (in-place)"),
        SystemFunction(lib:"generic",       name:"deleteBy",            call:Generic_deleteBy,          req: @[@[AV,IV],@[DV,SV],@[SV,IV]],                                                 ret: @[AV,SV,DV],       desc:"delete index from given array, dictionary or string"),
        SystemFunction(lib:"generic",       name:"deleteBy!",           call:Generic_deleteByI,         req: @[@[AV,IV],@[DV,SV],@[SV,IV]],                                                 ret: @[AV,SV,DV],       desc:"delete index from given array, dictionary or string (in-place)"),
        SystemFunction(lib:"generic",       name:"get",                 call:Generic_get,               req: @[@[AV,IV],@[DV,SV],@[SV,IV]],                                                 ret: @[ANY],            desc:"get element from array, dictionary or string using given index/key"),
        SystemFunction(lib:"generic",       name:"index",               call:Generic_index,             req: @[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],@[SV,SV]],   ret: @[IV],             desc:"get index of string/element within string/array or -1 if not found"),
        SystemFunction(lib:"generic",       name:"isEmpty",             call:Generic_isEmpty,           req: @[@[AV],@[SV],@[DV]],                                                          ret: @[BV],             desc:"check if given array, dictionary or string is empty"),
        SystemFunction(lib:"generic",       name:"reverse",             call:Generic_reverse,           req: @[@[AV],@[SV]],                                                                ret: @[AV,SV],          desc:"reverse given array or string"),
        SystemFunction(lib:"generic",       name:"reverse!",            call:Generic_reverseI,          req: @[@[AV],@[SV]],                                                                ret: @[AV,SV],          desc:"reverse given array or string (in-place)"),
        SystemFunction(lib:"generic",       name:"set",                 call:Generic_set,               req: @[@[AV,IV,IV],@[AV,IV,RV],@[AV,IV,BV],@[AV,IV,AV],@[AV,IV,DV],@[AV,IV,FV],
                                                                                                               @[AV,IV,BIV],@[AV,IV,SV],
                                                                                                               @[DV,SV,IV],@[DV,SV,RV],@[DV,SV,BV],@[DV,SV,AV],@[DV,SV,DV],@[DV,SV,FV],
                                                                                                               @[DV,SV,BIV],@[DV,SV,SV],
                                                                                                               @[SV,IV,SV]],                                                                ret: @[ANY],            desc:"set element of array, dictionary or string to given value using index/key"),
        SystemFunction(lib:"generic",       name:"set!",                call:Generic_setI,              req: @[@[AV,IV,IV],@[AV,IV,RV],@[AV,IV,BV],@[AV,IV,AV],@[AV,IV,DV],@[AV,IV,FV],
                                                                                                               @[AV,IV,BIV],@[AV,IV,SV],
                                                                                                               @[DV,SV,IV],@[DV,SV,RV],@[DV,SV,BV],@[DV,SV,AV],@[DV,SV,DV],@[DV,SV,FV],
                                                                                                               @[DV,SV,BIV],@[DV,SV,SV],
                                                                                                               @[SV,IV,SV]],                                                                ret: @[ANY],            desc:"set element of array, dictionary or string to given value using index/key (in-place)"),
        SystemFunction(lib:"generic",       name:"size",                call:Generic_size,              req: @[@[AV],@[SV],@[DV]],                                                          ret: @[IV],             desc:"get size of given collection or string"),
        SystemFunction(lib:"generic",       name:"slice",               call:Generic_slice,             req: @[@[AV,IV],@[AV,IV,IV],@[SV,IV],@[SV,IV,IV]],                                  ret: @[AV,SV],          desc:"get slice of array/string given a starting and/or end point"),

        SystemFunction(lib:"io",            name:"read",                call:Io_read,                   req: @[@[SV]],                                                                      ret: @[SV],             desc:"read string from file at given path"),
        SystemFunction(lib:"io",            name:"write",               call:Io_write,                  req: @[@[SV,SV]],                                                                   ret: @[SV],             desc:"write string to file at given path"),

        SystemFunction(lib:"json",          name:"generateJson",        call:Json_generateJson,         req: @[@[SV],@[IV],@[RV],@[BV],@[AV],@[DV]],                                        ret: @[SV],             desc:"get JSON string from given value"),
        SystemFunction(lib:"json",          name:"parseJson",           call:Json_parseJson,            req: @[@[SV]],                                                                      ret: @[SV,IV,RV,AV,DV], desc:"get object by parsing given JSON string"),

        SystemFunction(lib:"logical",       name:"and",                 call:Logical_and,               req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical AND"),
        SystemFunction(lib:"logical",       name:"nand",                call:Logical_nand,              req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical NAND"),
        SystemFunction(lib:"logical",       name:"nor",                 call:Logical_nor,               req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical NOR"),
        SystemFunction(lib:"logical",       name:"not",                 call:Logical_not,               req: @[@[BV],@[IV]],                                                                ret: @[BV,IV],          desc:"bitwise/logical NOT"),
        SystemFunction(lib:"logical",       name:"or",                  call:Logical_or,                req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical OR"),
        SystemFunction(lib:"logical",       name:"xnor",                call:Logical_xnor,              req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical XNOR"),   
        SystemFunction(lib:"logical",       name:"xor",                 call:Logical_xor,               req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical XOR"),   

        SystemFunction(lib:"math",          name:"abs",                 call:Math_abs,                  req: @[@[IV]],                                                                      ret: @[IV],             desc:"get absolute value from given value"),
        SystemFunction(lib:"math",          name:"acos",                call:Math_acos,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse cosine of given value"),
        SystemFunction(lib:"math",          name:"acosh",               call:Math_acosh,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse hyperbolic cosine of given value"),
        SystemFunction(lib:"math",          name:"asin",                call:Math_asin,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse sine of given value"),
        SystemFunction(lib:"math",          name:"asinh",               call:Math_asinh,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse hyperbolic sine of given value"),
        SystemFunction(lib:"math",          name:"atan",                call:Math_atan,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse tangent of given value"),
        SystemFunction(lib:"math",          name:"atanh",               call:Math_atanh,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse hyperbolic tangent of given value"),
        SystemFunction(lib:"math",          name:"avg",                 call:Math_avg,                  req: @[@[AV]],                                                                      ret: @[RV],             desc:"get average value from given array"),
        SystemFunction(lib:"math",          name:"ceil",                call:Math_ceil,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the smallest number greater than or equal to given value"),
        SystemFunction(lib:"math",          name:"cos",                 call:Math_cos,                  req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the cosine of given value"),
        SystemFunction(lib:"math",          name:"cosh",                call:Math_cosh,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic cosine of given value"),
        SystemFunction(lib:"math",          name:"csec",                call:Math_csec,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the cosecant of given value"),
        SystemFunction(lib:"math",          name:"csech",               call:Math_csech,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic cosecant of given value"),
        SystemFunction(lib:"math",          name:"ctan",                call:Math_ctan,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the cotangent of given value"),
        SystemFunction(lib:"math",          name:"ctanh",               call:Math_ctanh,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic cotangent of given value"),
        SystemFunction(lib:"math",          name:"exp",                 call:Math_exp,                  req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the exponential the given value"),
        SystemFunction(lib:"math",          name:"floor",               call:Math_floor,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the largest number greater than or equal to given value"),
        SystemFunction(lib:"math",          name:"gcd",                 call:Math_gcd,                  req: @[@[AV]],                                                                      ret: @[IV],             desc:"get the greatest common divisor of the values in given array"),
        SystemFunction(lib:"math",          name:"inc",                 call:Math_inc,                  req: @[@[IV],@[BIV]],                                                               ret: @[IV,BIV],         desc:"increase given value by 1"),
        SystemFunction(lib:"math",          name:"inc!",                call:Math_incI,                 req: @[@[IV],@[BIV]],                                                               ret: @[IV,BIV],         desc:"increase given value by 1 (in-place)"),
        SystemFunction(lib:"math",          name:"isEven",              call:Math_isEven,               req: @[@[IV],@[BIV]],                                                               ret: @[BV],             desc:"check if given number is even"),
        SystemFunction(lib:"math",          name:"isOdd",               call:Math_isOdd,                req: @[@[IV],@[BIV]],                                                               ret: @[BV],             desc:"check if given number is odd"),
        SystemFunction(lib:"math",          name:"isPrime",             call:Math_isPrime,              req: @[@[IV],@[BIV]],                                                               ret: @[BV],             desc:"check if given number is prime"),
        SystemFunction(lib:"math",          name:"lcm",                 call:Math_lcm,                  req: @[@[AV]],                                                                      ret: @[IV],             desc:"get the least common multiple of the values in given array"),
        SystemFunction(lib:"math",          name:"ln",                  call:Math_ln,                   req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the natural logarithm of given value"),
        SystemFunction(lib:"math",          name:"log",                 call:Math_log,                  req: @[@[RV,RV]],                                                                   ret: @[RV],             desc:"get the logarithm of value using given base"),
        SystemFunction(lib:"math",          name:"log2",                call:Math_log2,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the binary (base-2) logarithm of given value"),
        SystemFunction(lib:"math",          name:"log10",               call:Math_log10,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the common (base-10) logarithm of given value"),
        SystemFunction(lib:"math",          name:"max",                 call:Math_max,                  req: @[@[AV]],                                                                      ret: @[IV],             desc:"get maximum of the values in given array"),
        SystemFunction(lib:"math",          name:"min",                 call:Math_min,                  req: @[@[AV]],                                                                      ret: @[IV],             desc:"get minimum of the values in given array"),
        SystemFunction(lib:"math",          name:"pi",                  call:Math_pi,                   req: @[@[NV]],                                                                      ret: @[RV],             desc:"get the circle constant PI"),
        SystemFunction(lib:"math",          name:"primeFactors",        call:Math_primeFactors,         req: @[@[IV],@[BIV]],                                                               ret: @[AV],             desc:"get array of prime factors of given number"),
        SystemFunction(lib:"math",          name:"product",             call:Math_product,              req: @[@[AV]],                                                                      ret: @[IV,BIV],         desc:"return product of elements of given array"),
        SystemFunction(lib:"math",          name:"random",              call:Math_random,               req: @[@[IV,IV]],                                                                   ret: @[IV],             desc:"generate random number in given range"),
        SystemFunction(lib:"math",          name:"round",               call:Math_round,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get given value rounded to the nearest value"),
        SystemFunction(lib:"math",          name:"sec",                 call:Math_sec,                  req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the secant of given value"),
        SystemFunction(lib:"math",          name:"sech",                call:Math_sech,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic secant of given value"),
        SystemFunction(lib:"math",          name:"shl",                 call:Math_shl,                  req: @[@[IV,IV],@[BIV,IV]],                                                         ret: @[IV,BIV],         desc:"shift-left number by given amount of bits"),
        SystemFunction(lib:"math",          name:"shl!",                call:Math_shlI,                 req: @[@[IV,IV],@[BIV,IV]],                                                         ret: @[IV,BIV],         desc:"shift-left number by given amount of bits (in-place)"),
        SystemFunction(lib:"math",          name:"shr",                 call:Math_shr,                  req: @[@[IV,IV],@[BIV,IV]],                                                         ret: @[IV,BIV],         desc:"shift-right number by given amount of bits"),
        SystemFunction(lib:"math",          name:"shr!",                call:Math_shrI,                 req: @[@[IV,IV],@[BIV,IV]],                                                         ret: @[IV,BIV],         desc:"shift-right number by given amount of bits (in-place)"),
        SystemFunction(lib:"math",          name:"sin",                 call:Math_sin,                  req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the sine of given value"),
        SystemFunction(lib:"math",          name:"sinh",                call:Math_sinh,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic sine of given value"),
        SystemFunction(lib:"math",          name:"sqrt",                call:Math_sqrt,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"calculate the square root of given value"),
        SystemFunction(lib:"math",          name:"sum",                 call:Math_sum,                  req: @[@[AV]],                                                                      ret: @[IV,BIV],         desc:"return sum of elements of given array"),
        SystemFunction(lib:"math",          name:"tan",                 call:Math_tan,                  req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the tangent of given value"),
        SystemFunction(lib:"math",          name:"tanh",                call:Math_tanh,                 req: @[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic tangent of given value"),

        SystemFunction(lib:"net",           name:"download",            call:Net_download,              req: @[@[SV]],                                                                      ret: @[SV],             desc:"retrieve string contents from webpage using given URL"),

        SystemFunction(lib:"path",          name:"absolutePath",        call:Path_absolutePath,         req: @[@[SV]],                                                                      ret: @[SV],             desc:"get absolute path from given path"),
        SystemFunction(lib:"path",          name:"absolutePath!",       call:Path_absolutePathI,        req: @[@[SV]],                                                                      ret: @[SV],             desc:"get absolute path from given path (in-place)"),
        SystemFunction(lib:"path",          name:"copyDir",             call:Path_copyDir,              req: @[@[SV,SV]],                                                                   ret: @[BV],             desc:"copy directory at path to given destination"),
        SystemFunction(lib:"path",          name:"copyFile",            call:Path_copyFile,             req: @[@[SV,SV]],                                                                   ret: @[BV],             desc:"copy file at path to given destination"),
        SystemFunction(lib:"path",          name:"createDir",           call:Path_createDir,            req: @[@[SV]],                                                                      ret: @[BV],             desc:"create directory at given path"),
        SystemFunction(lib:"path",          name:"currentDir",          call:Path_currentDir,           req: @[@[NV],@[SV]],                                                                ret: @[SV],             desc:"get current directory or set it to given path"),
        SystemFunction(lib:"path",          name:"deleteDir",           call:Path_deleteDir,            req: @[@[SV]],                                                                      ret: @[BV],             desc:"delete directory at given path"),
        SystemFunction(lib:"path",          name:"deleteFile",          call:Path_deleteFile,           req: @[@[SV]],                                                                      ret: @[BV],             desc:"delete file at given path"),
        SystemFunction(lib:"path",          name:"dirContent",          call:Path_dirContent,           req: @[@[SV],@[SV,SV]],                                                             ret: @[AV],             desc:"get directory contents from given path; optionally filtering the results"),
        SystemFunction(lib:"path",          name:"dirContents",         call:Path_dirContents,          req: @[@[SV],@[SV,SV]],                                                             ret: @[AV],             desc:"get directory contents from given path, recursively; optionally filtering the results"),
        SystemFunction(lib:"path",          name:"fileCreationTime",    call:Path_fileCreationTime,     req: @[@[SV]],                                                                      ret: @[SV],             desc:"get creation time of file at given path"),
        SystemFunction(lib:"path",          name:"fileExists",          call:Path_fileExists,           req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if file exists at given path"),
        SystemFunction(lib:"path",          name:"fileLastAccess",      call:Path_fileLastAccess,       req: @[@[SV]],                                                                      ret: @[SV],             desc:"get last access time of file at given path"),
        SystemFunction(lib:"path",          name:"fileLastModification",call:Path_fileLastModification, req: @[@[SV]],                                                                      ret: @[SV],             desc:"get last modification time of file at given path"),
        SystemFunction(lib:"path",          name:"fileSize",            call:Path_fileSize,             req: @[@[SV]],                                                                      ret: @[IV],             desc:"get size of file at given path in bytes"),
        SystemFunction(lib:"path",          name:"dirExists",           call:Path_dirExists,            req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if directory exists at given path"),
        SystemFunction(lib:"path",          name:"moveDir",             call:Path_moveDir,              req: @[@[SV,SV]],                                                                   ret: @[BV],             desc:"move directory at path to given destination"),
        SystemFunction(lib:"path",          name:"moveFile",            call:Path_moveFile,             req: @[@[SV,SV]],                                                                   ret: @[BV],             desc:"move file at path to given destination"),
        SystemFunction(lib:"path",          name:"normalizePath",       call:Path_normalizePath,        req: @[@[SV]],                                                                      ret: @[SV],             desc:"normalize given path"),
        SystemFunction(lib:"path",          name:"normalizePath!",      call:Path_normalizePathI,       req: @[@[SV]],                                                                      ret: @[SV],             desc:"normalize given path (in-place)"),
        SystemFunction(lib:"path",          name:"pathDir",             call:Path_pathDir,              req: @[@[SV]],                                                                      ret: @[SV],             desc:"retrieve directory component from given path"),
        SystemFunction(lib:"path",          name:"pathExtension",       call:Path_pathExtension,        req: @[@[SV]],                                                                      ret: @[SV],             desc:"retrieve extension component from given path"),
        SystemFunction(lib:"path",          name:"pathFilename",        call:Path_pathFilename,         req: @[@[SV]],                                                                      ret: @[SV],             desc:"retrieve filename component from given path"),
        SystemFunction(lib:"path",          name:"symlinkExists",       call:Path_symlinkExists,        req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if symlink exists at given path"),

        SystemFunction(lib:"reflection",    name:"inspect",             call:Reflection_inspect,        req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen in a readable format"),
        SystemFunction(lib:"reflection",    name:"type",                call:Reflection_type,           req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"get type of given object as a string"),

        SystemFunction(lib:"string",        name:"capitalize",          call:String_capitalize,         req: @[@[SV]],                                                                      ret: @[SV],             desc:"capitalize given string"),
        SystemFunction(lib:"string",        name:"capitalize!",         call:String_capitalizeI,        req: @[@[SV]],                                                                      ret: @[SV],             desc:"capitalize given string (in-place)"),
        SystemFunction(lib:"string",        name:"char",                call:String_char,               req: @[@[IV]],                                                                      ret: @[SV],             desc:"get ASCII character from given char code"),
        SystemFunction(lib:"string",        name:"chars",               call:String_chars,              req: @[@[SV]],                                                                      ret: @[AV],             desc:"get string characters as an array"),
        SystemFunction(lib:"string",        name:"deletePrefix",        call:String_deletePrefix,       req: @[@[SV,SV]],                                                                   ret: @[SV],             desc:"get string by deleting given prefix"),
        SystemFunction(lib:"string",        name:"deletePrefix!",       call:String_deletePrefixI,      req: @[@[SV,SV]],                                                                   ret: @[SV],             desc:"get string by deleting given prefix (in-place)"),
        SystemFunction(lib:"string",        name:"deleteSuffix",        call:String_deleteSuffix,       req: @[@[SV,SV]],                                                                   ret: @[SV],             desc:"get string by deleting given suffix"),
        SystemFunction(lib:"string",        name:"deleteSuffix!",       call:String_deleteSuffixI,      req: @[@[SV,SV]],                                                                   ret: @[SV],             desc:"get string by deleting given suffix (in-place)"),
        SystemFunction(lib:"string",        name:"distance",            call:String_distance,           req: @[@[SV,SV]],                                                                   ret: @[IV],             desc:"get Levenshtein distance between given strings"),
        SystemFunction(lib:"string",        name:"endsWith",            call:String_endsWith,           req: @[@[SV,SV]],                                                                   ret: @[BV],             desc:"check if string ends with given string/regex"),
        SystemFunction(lib:"string",        name:"isAlpha",             call:String_isAlpha,            req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are ASCII letters"),
        SystemFunction(lib:"string",        name:"isAlphaNumeric",      call:String_isAlphaNumeric,     req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are ASCII letters or digits"),
        SystemFunction(lib:"string",        name:"isLowercase",         call:String_isLowercase,        req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are lowercase"),
        SystemFunction(lib:"string",        name:"isNumber",            call:String_isNumber,           req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if given string is a number"),
        SystemFunction(lib:"string",        name:"isUppercase",         call:String_isUppercase,        req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are uppercase"),
        SystemFunction(lib:"string",        name:"isWhitespace",        call:String_isWhitespace,       req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are whitespace"),
        SystemFunction(lib:"string",        name:"join",                call:String_join,               req: @[@[AV],@[AV,SV]],                                                             ret: @[SV],             desc:"join strings in given array, optionally using separator"),
        SystemFunction(lib:"string",        name:"lines",               call:String_lines,              req: @[@[SV]],                                                                      ret: @[AV],             desc:"get lines from string as an array"),
        SystemFunction(lib:"string",        name:"lowercase",           call:String_lowercase,          req: @[@[SV]],                                                                      ret: @[SV],             desc:"lowercase given string"),
        SystemFunction(lib:"string",        name:"lowercase!",          call:String_lowercaseI,         req: @[@[SV]],                                                                      ret: @[SV],             desc:"lowercase given string (in-place)"),
        SystemFunction(lib:"string",        name:"matches",             call:String_matches,            req: @[@[SV,SV]],                                                                   ret: @[AV],             desc:"get array of matches from string using given string/regex"),
        SystemFunction(lib:"string",        name:"padCenter",           call:String_padCenter,          req: @[@[SV,IV]],                                                                   ret: @[SV],             desc:"center-justify string by adding given padding"),
        SystemFunction(lib:"string",        name:"padCenter!",          call:String_padCenterI,         req: @[@[SV,IV]],                                                                   ret: @[SV],             desc:"center-justify string by adding given padding (in-place)"),
        SystemFunction(lib:"string",        name:"padLeft",             call:String_padLeft,            req: @[@[SV,IV]],                                                                   ret: @[SV],             desc:"left-justify string by adding given padding"),
        SystemFunction(lib:"string",        name:"padLeft!",            call:String_padLeftI,           req: @[@[SV,IV]],                                                                   ret: @[SV],             desc:"left-justify string by adding given padding (in-place)"),
        SystemFunction(lib:"string",        name:"padRight",            call:String_padRight,           req: @[@[SV,IV]],                                                                   ret: @[SV],             desc:"right-justify string by adding given padding"),
        SystemFunction(lib:"string",        name:"padRight!",           call:String_padRightI,          req: @[@[SV,IV]],                                                                   ret: @[SV],             desc:"right-justify string by adding given padding (in-place)"),
        SystemFunction(lib:"string",        name:"replace",             call:String_replace,            req: @[@[SV,SV,SV]],                                                                ret: @[SV],             desc:"get string by replacing occurences of string/regex with given replacement"),
        SystemFunction(lib:"string",        name:"replace!",            call:String_replaceI,           req: @[@[SV,SV,SV]],                                                                ret: @[SV],             desc:"get string by replacing occurences of string/regex with given replacement (in-place)"),
        SystemFunction(lib:"string",        name:"split",               call:String_split,              req: @[@[SV,SV]],                                                                   ret: @[AV],             desc:"split string to array by given string/regex separator"),
        SystemFunction(lib:"string",        name:"startsWith",          call:String_startsWith,         req: @[@[SV,SV]],                                                                   ret: @[BV],             desc:"check if string starts with given string/regex"),
        SystemFunction(lib:"string",        name:"strip",               call:String_strip,              req: @[@[SV]],                                                                      ret: @[SV],             desc:"remove leading and trailing whitespace from given string"),
        SystemFunction(lib:"string",        name:"strip!",              call:String_stripI,             req: @[@[SV]],                                                                      ret: @[SV],             desc:"remove leading and trailing whitespace from given string (in-place)"),
        SystemFunction(lib:"string",        name:"uppercase",           call:String_uppercase,          req: @[@[SV]],                                                                      ret: @[SV],             desc:"uppercase given string"),
        SystemFunction(lib:"string",        name:"uppercase!",          call:String_uppercaseI,         req: @[@[SV]],                                                                      ret: @[SV],             desc:"uppercase given string (in-place)"),

        SystemFunction(lib:"terminal",      name:"clear",               call:Terminal_clear,            req: @[@[NV]],                                                                      ret: @[NV],             desc:"clear screen and move cursor to home"),
        SystemFunction(lib:"terminal",      name:"input",               call:Terminal_input,            req: @[@[NV]],                                                                      ret: @[SV],             desc:"read line from stdin"),
        SystemFunction(lib:"terminal",      name:"inputChar",           call:Terminal_inputChar,        req: @[@[NV]],                                                                      ret: @[SV],             desc:"read character from terminal, without being printed"),
        SystemFunction(lib:"terminal",      name:"print",               call:Terminal_print,            req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen"),
        SystemFunction(lib:"terminal",      name:"prints",              call:Terminal_prints,           req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen without newline"),
        SystemFunction(lib:"terminal",      name:"shell",               call:Terminal_shell,            req: @[@[SV]],                                                                      ret: @[SV],             desc:"execute given shell command and get string output"),

        SystemFunction(lib:"time",          name:"benchmark",           call:Time_benchmark,            req: @[@[FV]],                                                                      ret: @[IV],             desc:"time the execution of a given function in seconds"),
        SystemFunction(lib:"time",          name:"datetime",            call:Time_datetime,             req: @[@[SV],@[SV,SV],@[IV],@[IV,SV]],                                              ret: @[IV,SV],          desc:"get timestamp from given datetime string (dd-MM-yyyy HH:mm:ss), or string from given timestamp, optionally using a different format"),
        SystemFunction(lib:"time",          name:"day",                 call:Time_day,                  req: @[@[IV]],                                                                      ret: @[SV],             desc:"get day of the week for given timestamp"),
        SystemFunction(lib:"time",          name:"dayOfMonth",          call:Time_dayOfMonth,           req: @[@[IV]],                                                                      ret: @[IV],             desc:"get day of the month for given timestamp"),
        SystemFunction(lib:"time",          name:"dayOfYear",           call:Time_dayOfYear,            req: @[@[IV]],                                                                      ret: @[IV],             desc:"get day of the year for given timestamp"),
        SystemFunction(lib:"time",          name:"delay",               call:Time_delay,                req: @[@[IV]],                                                                      ret: @[IV],             desc:"create system delay for given duration in milliseconds"),
        SystemFunction(lib:"time",          name:"hours",               call:Time_hours,                req: @[@[IV]],                                                                      ret: @[IV],             desc:"get hours component from given timestamp"),
        SystemFunction(lib:"time",          name:"minutes",             call:Time_minutes,              req: @[@[IV]],                                                                      ret: @[IV],             desc:"get minutes component from given timestamp"),
        SystemFunction(lib:"time",          name:"month",               call:Time_month,                req: @[@[IV]],                                                                      ret: @[SV],             desc:"get month from given timestamp"),
        SystemFunction(lib:"time",          name:"now",                 call:Time_now,                  req: @[@[NV]],                                                                      ret: @[IV],             desc:"get current timestamp"),
        SystemFunction(lib:"time",          name:"seconds",             call:Time_seconds,              req: @[@[IV]],                                                                      ret: @[IV],             desc:"get seconds component from given timestamp"),

        SystemFunction(lib:"url",           name:"decodeUrl",           call:Url_decodeUrl,             req: @[@[SV]],                                                                      ret: @[SV],             desc:"decode given URL"),
        SystemFunction(lib:"url",           name:"decodeUrl!",          call:Url_decodeUrlI,            req: @[@[SV]],                                                                      ret: @[SV],             desc:"decode given URL (in-place)"),
        SystemFunction(lib:"url",           name:"encodeUrl",           call:Url_encodeUrl,             req: @[@[SV]],                                                                      ret: @[SV],             desc:"encode given URL"),
        SystemFunction(lib:"url",           name:"encodeUrl!",          call:Url_encodeUrlI,            req: @[@[SV]],                                                                      ret: @[SV],             desc:"encode given URL (in-place)"),
        SystemFunction(lib:"url",           name:"isAbsoluteUrl",       call:Url_isAbsoluteUrl,         req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if given URL is absolute"),
        SystemFunction(lib:"url",           name:"urlAnchor",           call:Url_urlAnchor,             req: @[@[SV]],                                                                      ret: @[SV],             desc:"get anchor component of given URL"),
        SystemFunction(lib:"url",           name:"urlComponents",       call:Url_urlComponents,         req: @[@[SV]],                                                                      ret: @[DV],             desc:"get all components from given URL"),
        SystemFunction(lib:"url",           name:"urlHost",             call:Url_urlHost,               req: @[@[SV]],                                                                      ret: @[SV],             desc:"get host component from given URL"),
        SystemFunction(lib:"url",           name:"urlPassword",         call:Url_urlPassword,           req: @[@[SV]],                                                                      ret: @[SV],             desc:"get password component from given URL"),
        SystemFunction(lib:"url",           name:"urlPath",             call:Url_urlPath,               req: @[@[SV]],                                                                      ret: @[SV],             desc:"get path from given URL"),
        SystemFunction(lib:"url",           name:"urlPort",             call:Url_urlPort,               req: @[@[SV]],                                                                      ret: @[SV],             desc:"get port component from given URL"),
        SystemFunction(lib:"url",           name:"urlQuery",            call:Url_urlQuery,              req: @[@[SV]],                                                                      ret: @[SV],             desc:"get query part from given URL"),
        SystemFunction(lib:"url",           name:"urlScheme",           call:Url_urlScheme,             req: @[@[SV]],                                                                      ret: @[SV],             desc:"get scheme part from given URL"),
        SystemFunction(lib:"url",           name:"urlUser",             call:Url_urlUser,               req: @[@[SV]],                                                                      ret: @[SV],             desc:"get username component from given URL")
    ]

##---------------------------
## Command constants
##---------------------------

let
    EXEC_CMD    =   cint(getSystemFunction("exec"))
    GET_CMD     =   cint(getSystemFunction("get"))
    RANGE_CMD   =   cint(getSystemFunction("range"))
    SET_CMD     =   cint(getSystemFunction("set!"))

#[######################################################
    Context management
  ======================================================]#

##---------------------------
## Constructors
##---------------------------

template addContext() =
    ## Add a new context to the Stack

    Stack.add(Context(list: @[]))

template initTopContextWith(key:string, val:Value) =
    ## Initialize topmost Context with key-val pair

    Stack[^1] = Context(list: @[(key,val)])

template initTopContextWith(pairs:seq[(string,Value)]) =
    ## Initialize topmost Context with key-val pairs

    Stack[^1] = Context(list:pairs)

template popContext() =
    ## Discard topmost Context

    discard Stack.pop()

##---------------------------
## Methods
##---------------------------

proc keys*(ctx: Context): seq[string] {.inline.} =
    ## Get array of keys in given Context

    result = ctx.list.map((x) => x[0])

proc values*(ctx: Context): seq[Value] {.inline.} =
    ## Get array of values in given Context

    result = ctx.list.map((x) => x[1])

proc hasKey*(ctx: Context, key: string): bool {.inline.} = 
    ## Check if given Context contains key

    var i = 0
    while i<ctx.list.len:
        if ctx.list[i][0]==key: return true 
        inc(i)
    return false

proc getValueForKey*(ctx: Context, key: string): Value {.inline.} =
    ## Get Value of key in a given Context

    var i = 0
    while i<ctx.list.len:
        if ctx.list[i][0]==key: return ctx.list[i][1] 
        inc(i)
    return nil

proc updateOrSet(ctx: var Context, k: string, v: Value) {.inline.} = 
    ## In a given Context, either update a key if it exists, or create it
    var i = 0
    while i<ctx.list.len:
        if ctx.list[i][0]==k: 
            shallowCopy(ctx.list[i][1],v)
            return
        inc(i)

    ctx.list.add((k,v))

proc getSymbol(k: string): Value {.inline.} = 
    ## Get Value of key in the Stack

    var i = len(Stack) - 1
    var j: int
    while i > -1:
        j = 0
        while j<Stack[i].list.len:
            if Stack[i].list[j][0]==k: 
                return Stack[i].list[j][1]
            inc(j)
        dec(i)

    return nil

proc getAndSetSymbol(k: string, v: Value): Value {.inline.} = 
    ## Set key in the Stack and return previous Value

    var i = len(Stack) - 1
    var j: int
    while i > -1:
        j = 0
        while j<Stack[i].list.len:
            if Stack[i].list[j][0]==k: 
                result = Stack[i].list[j][1]
                shallowCopy(Stack[i].list[j][1],v)
                return 
            inc(j)
        dec(i)

    return nil

template resetSymbol(k: string, v: Value) =
    ##  Set key in the top Stack context

    Stack[^1].updateOrSet(k,v)

proc setSymbol(k: string, v: Value): Value {.inline.} = 
    var i = len(Stack) - 1
    var j: int
    while i > -1:
        j = 0
        while j<Stack[i].list.len:
            if Stack[i].list[j][0]==k: 
                shallowCopy(Stack[i].list[j][1],v)
                return Stack[i].list[j][1]
            inc(j)

        dec(i)

    Stack[^1].updateOrSet(k,v)
    result = v

##---------------------------
## Inspection
##---------------------------

proc inspectStack() =
    ## Utility method print out all Context's in the Stack

    var i = 0
    for s in Stack:
        var tab = ""
        if i>0: tab = "\t"
        echo tab,"----------------"
        echo tab,"Stack[",i,"]"
        echo tab,"----------------"

        for t in s.list:
            echo tab,t[0]," [" & fmt"{cast[int](unsafeAddr(t[1])):#x}" & "] -> ",t[1].stringify()
            if t[1].kind==IV:
                echo "\t\t" & fmt"{cast[int](unsafeAddr(t[1].i)):#x}"

        inc(i)

#[######################################################
    Main Objects
  ======================================================]#

#[----------------------------------------
    Value
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc INT(v: string): Value {.inline.} =
    var intValue: int
    try: 
        discard parseInt(v, intValue)
        result = INT(intValue)
    except: 
        result = BIGINT(v)

proc BIGINT*(v: string): Value {.inline.} =
    Value(kind: BIV, bi: newInt(v))

proc REAL(v: string): Value {.inline.} =
    var floatValue: float
    discard parseFloat(v, floatValue)

    result = REAL(floatValue)

proc STRARR(v: seq[string]): Value {.inline.} =
    result = ARR(v.map((x)=>STR(x)))

proc INTARR(v: seq[int]): Value {.inline.} =
    result = ARR(v.map((x)=>INT(x)))

proc BIGINTARR(v: seq[Int]): Value {.inline.} =
    result = ARR(v.map((x)=>BIGINT(x)))

proc REALARR(v: seq[float]): Value {.inline.} =
    result = ARR(v.map((x)=>REAL(x)))

proc BOOLARR(v: seq[bool]): Value {.inline.} =
    result = ARR(v.map((x)=>BOOL(x)))

proc DICT(v: seq[(string,Value)]): Value {.inline.} =
    result = DICT(Context(list:v))

proc valueCopy(v: Value): Value {.inline.} =
    {.computedGoto.}
    result = case v.kind
        of SV: STR(v.s)
        of IV: INT(v.i)
        of RV: REAL(v.r)
        of AV: ARR(v.a.map((x) => valueCopy(x)))
        of DV: DICT(Context(list:v.d.list.map((x) => (x[0],valueCopy(x[1])))))
        else: v

##---------------------------
## Methods
##---------------------------

proc findValueInArray(v: Value, lookup: Value): int =
    var i = 0
    while i < v.a.len:
        if v.a[i].eq(lookup): return i 
        inc(i)
    return -1

proc findValueInArray(v: seq[Value], lookup: Value): int =
    var i = 0
    while i < v.len:
        if v[i].eq(lookup): return i 
        inc(i)
    return -1

##---------------------------
## Operator overloads
##---------------------------

proc `+`(l: Value, r: Value): Value {.inline.} =
    ## Addition

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: STR(l.s & r.s)
                of IV: STR(l.s & $(r.i))
                of BIV: STR(l.s & $(r.bi))
                of RV: STR(l.s & $(r.r))
                else: STR(l.s & r.stringify())
        of IV:
            result = case r.kind
                of SV: STR($(l.i) & r.s)
                of IV: 
                    try: INT(l.i + r.i)
                    except Exception as e: BIGINT(newInt(l.i)+r.i)
                of BIV: BIGINT(l.i+r.bi)
                of RV: REAL(float(l.i)+r.r)
                else: InvalidOperationError("+",$(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: BIGINT(l.bi + r.i)
                of BIV: BIGINT(l.bi+r.bi)
                else: InvalidOperationError("+",$(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of SV: STR($(l.r) & r.s)
                of IV: REAL(l.r + float(r.i))
                of RV: REAL(l.r+r.r)
                else: InvalidOperationError("+",$(l.kind),$(r.kind))
        of AV:
            if r.kind!=AV:
                result = ARR(l.a & r)
            else: 
                result = ARR(l.a & r.a)
        of DV:
            if r.kind==DV:
                result = valueCopy(l)
                for k in r.d.keys:
                    result.d.updateOrSet(k,r.d.getValueForKey(k))

            else: InvalidOperationError("+",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("+",$(l.kind),$(r.kind))

proc `-`(l: Value, r: Value): Value {.inline.} =
    ## Subtraction

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: STR(l.s.replace(r.s,""))
                of IV: STR(l.s.replace($(r.i),""))
                of BIV: STR(l.s.replace($(r.bi),""))
                of RV: STR(l.s.replace($(r.r),""))
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of IV:
            result = case r.kind
                of IV: INT(l.i - r.i)
                of BIV: BIGINT(l.i - r.bi)
                of RV: REAL(float(l.i)-r.r)
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: BIGINT(l.bi - r.i)
                of BIV: BIGINT(l.bi - r.bi)
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of IV: REAL(l.r - float(r.i))
                of RV: REAL(l.r-r.r)
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of AV:
            result = valueCopy(l)
            if r.kind!=AV:
                result.a.delete(l.findValueInArray(r))
            else:
                for item in r.a:
                    result.a.delete(result.findValueInArray(item))

        of DV:
            result = valueCopy(l)
            var i = 0
            while i < l.d.list.len:
                if l.d.list[i][1].eq(r):
                    result.d.list.del(i)
                inc(i)

        else:
            InvalidOperationError("-",$(l.kind),$(r.kind))

proc `*`(l: Value, r: Value): Value {.inline.} = 
    ## Multiplication

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of IV: STR(l.s.repeat(r.i))
                of RV: STR(l.s.repeat(int(r.r)))
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of IV:
            result = case r.kind
                of SV: STR(r.s.repeat(l.i))
                of IV: 
                    try: INT(l.i * r.i)
                    except Exception as e: BIGINT(newInt(l.i)*r.i)
                of BIV: BIGINT(l.i * r.bi)
                of RV: REAL(float(l.i)*r.r)
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: BIGINT(l.bi * r.i)
                of BIV: BIGINT(l.bi * r.bi)
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of SV: STR(r.s.repeat(int(l.r)))
                of IV: REAL(l.r * float(r.i))
                of RV: REAL(l.r*r.r)
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of AV:
            result = ARR(@[])
            if r.kind==IV or r.kind==RV:
                var limit:int
                if r.kind==IV: limit = r.i
                else: limit = int(r.r)

                var i = 0
                while i<limit:
                    for item in l.a:
                        result.a.add(valueCopy(item))
                    inc(i)
            else: InvalidOperationError("*",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("*",$(l.kind),$(r.kind))

proc `/`(l: Value, r: Value): Value {.inline.} = 
    ## (Integer) division

    {.computedGoto.}
    case l.kind
        of SV:
            case r.kind
                of IV: 
                    var k=0
                    var resp=""
                    result = ARR(@[])
                    while k<l.s.len:
                        resp &= l.s[k]
                        if ((k+1) mod r.i)==0: 
                            result.a.add(STR(resp))
                            resp = ""
                        inc(k)
                
                of RV: 
                    var k=0
                    var resp=""
                    result = ARR(@[])
                    while k<l.s.len:
                        resp &= l.s[k]
                        if ((k+1) mod int(r.r))==0: 
                            result.a.add(STR(resp))
                            resp = ""
                        inc(k)

                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of IV:
            result = case r.kind
                of IV: INT(l.i div r.i)
                of BIV: BIGINT(l.i div r.bi)
                of RV: REAL(float(l.i) / r.r)
                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: BIGINT(l.bi div r.i)
                of BIV: BIGINT(l.bi div r.bi)
                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of IV: REAL(l.r / float(r.i))
                of RV: REAL(l.r / r.r)
                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of AV:
            result = ARR(@[])
            if r.kind==IV or r.kind==RV:
                var limit:int
                if r.kind==IV: limit = r.i
                else: limit = int(r.r)

                var k = 0
                var resp = ARR(@[])
                while k<l.a.len:
                    resp.a.add(valueCopy(l.a[k]))
                    if ((k+1) mod limit)==0: 
                        result.a.add(resp)
                        resp = ARR(@[])
                    inc(k)

            else: InvalidOperationError("/",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("/",$(l.kind),$(r.kind))

proc `%`(l: Value, r: Value): Value {.inline.} =
    ## Modulo

    {.computedGoto.}
    case l.kind
        of SV:
            case r.kind
                of IV: 
                    let le = (l.s.len mod r.i)
                    result = STR(l.s[l.s.len-le..^1])
                
                of RV: 
                    let le = (l.s.len mod int(r.r))
                    result = STR(l.s[l.s.len-le..^1])

                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of IV:
            result = case r.kind
                of IV: INT(l.i mod r.i)
                of BIV: BIGINT(l.i mod r.bi)
                of RV: INT(l.i mod int(r.r))
                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: BIGINT(l.bi mod r.i)
                of BIV: BIGINT(l.bi mod r.bi)
                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of IV: INT(int(l.r) mod r.i)
                of RV: INT(int(l.r) mod int(r.r))
                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of AV:
            result = ARR(@[])
            if r.kind==IV or r.kind==RV:
                var limit:int
                if r.kind==IV: limit = r.i
                else: limit = int(r.r)

                let le = (l.a.len mod limit)
                result = ARR(l.a[l.a.len-le..^1])
            else: InvalidOperationError("%",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("%",$(l.kind),$(r.kind))

proc `^`(l: Value, r: Value): Value {.inline.} =
    ## Powers

    {.computedGoto.}
    case l.kind
        of IV:
            result = case r.kind
                of IV: 
                    try: INT(l.i ^ r.i)
                    except Exception as e: BIGINT(pow(newInt(l.i),culong(r.i)))
                of RV: INT(l.i ^ int(r.r))
                else: InvalidOperationError("^",$(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: BIGINT(l.bi ^ culong(r.i))
                else: InvalidOperationError("^",$(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of IV: INT(int(l.r) ^ r.i)
                of RV: REAL(pow(l.r,r.r))
                else: InvalidOperationError("^",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("^",$(l.kind),$(r.kind))

proc eq(l: Value, r: Value): bool {.inline.} =
    ## The `==` operator

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: l.s==r.s
                else: NotComparableError($(l.kind),$(r.kind))
        of IV:
            result = case r.kind
                of IV: l.i==r.i
                of BIV: l.i==r.bi
                of RV: l.i==int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: l.bi==r.i
                of BIV: l.bi==r.bi
                of RV: l.bi==int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of IV: int(l.r)==r.i
                of BIV: int(l.r)==r.bi
                of RV: l.r==r.r
                else: NotComparableError($(l.kind),$(r.kind))
        of BV:
            result = case r.kind
                of BV: l==r
                else: NotComparableError($(l.kind),$(r.kind))
        of AV:
            case r.kind
                of AV:
                    if l.a.len!=r.a.len: result = false
                    else:
                        var i=0
                        while i<l.a.len:
                            if not (l.a[i].eq(r.a[i])): return false
                            inc(i)
                        result = true
                else: NotComparableError($(l.kind),$(r.kind))
        of DV:
            case r.kind
                of DV:
                    if l.d.keys!=r.d.keys: result = false
                    else:
                        var i = 0
                        while i < l.d.list.len:
                            if not r.d.hasKey(l.d.list[i][0]): return false
                            else:
                                if not (l.d.list[i][1].eq(r.d.getValueForKey(l.d.list[i][0]))): return false
                            inc(i)

                        result = true 
                else: NotComparableError($(l.kind),$(r.kind))

        else: NotComparableError($(l.kind),$(r.kind))

proc lt(l: Value, r: Value): bool {.inline.} =
    ## The `<` operator

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: l.s<r.s
                else: NotComparableError($(l.kind),$(r.kind))
                    
        of IV:
            result = case r.kind
                of IV: l.i<r.i
                of BIV: l.i<r.bi
                of RV: l.i<int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: l.bi<r.i
                of BIV: l.bi<r.bi
                of RV: l.bi<int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of IV: int(l.r)<r.i
                of BIV: int(l.r)<r.bi
                of RV: l.r<r.r
                else: NotComparableError($(l.kind),$(r.kind))
        of AV:
            result = case r.kind
                of AV: l.a.len < r.a.len
                else: NotComparableError($(l.kind),$(r.kind))
        of DV:
            result = case r.kind
                of DV: l.d.keys.len < r.d.keys.len
                else: NotComparableError($(l.kind),$(r.kind))

        else: NotComparableError($(l.kind),$(r.kind))

proc gt(l: Value, r: Value): bool {.inline.} =
    ## The `>` operator

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: l.s>r.s
                else: NotComparableError($(l.kind),$(r.kind))   
        of IV:
            result = case r.kind
                of IV: l.i>r.i
                of BIV: l.i>r.bi
                of RV: l.i>int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of BIV:
            result = case r.kind
                of IV: l.bi>r.i
                of BIV: l.bi>r.bi
                of RV: l.bi>int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of RV:
            result = case r.kind
                of IV: int(l.r)>r.i
                of BIV: int(l.r)>r.bi
                of RV: l.r>r.r
                else: NotComparableError($(l.kind),$(r.kind))
        of AV:
            result = case r.kind
                of AV: l.a.len > r.a.len
                else: NotComparableError($(l.kind),$(r.kind))
        of DV:
            result = case r.kind
                of DV: l.d.keys.len > r.d.keys.len
                else: NotComparableError($(l.kind),$(r.kind))

        else: NotComparableError($(l.kind),$(r.kind))

##---------------------------
## Inspection
##---------------------------

proc valueKindToPrintable*(s: string): string = 
    ## Convert ValueKind string representation to sth shorter and more readable
    ## ! Requires better rewriting

    s.replace("Value","").replace("ionary","").replace("tion","").replace("eger","").replace("ing","").replace("ean","")

proc stringify*(v: Value, quoted: bool = true): string {.inline.} =
    {.computedGoto.}
    case v.kind
        of SV   :   ( if quoted: result = escape(v.s) else: result = v.s )
        of IV   :   result = $(v.i)
        of BIV  :   result = $(v.bi)
        of RV   :   result = $(v.r)
        of BV   :   result = $(v.b)
        of AV   :
            result = "#("

            let items = v.a.map((x) => x.stringify())

            result &= items.join(" ")
            result &= ")"
        of DV   :
            result = "#{ "
            
            let items = sorted(v.d.keys).map((x) => x & ": " & v.d.getValueForKey(x).stringify())

            result &= items.join(", ")
            result &= " }"

            if result=="#{  }": result = "#{}"
        of FV   :   result = "<function " & fmt"{cast[int](addr(v.f)):#x}" & ">"
        of NV   :   result = "null"
        of ANY  :   result = ""

proc inspect*(v: Value, prepend: int = 0, isKeyVal: bool = false): string =
    const 
        RESTORE_COLOR   = "\x1B[0;37m"
        STR_COLOR       = "\x1B[0;33m"
        NUM_COLOR       = "\x1B[0;35m"
        KEY_COLOR       = "\x1B[1;37m"
        INSPECT_PADDING = 16

    let padding = 
        if isKeyVal: INSPECT_PADDING
        else: 0

    {.computedGoto.}
    case v.kind
        of SV   :   result = STR_COLOR & escape(v.s) & RESTORE_COLOR
        of IV   :   result = NUM_COLOR & $(v.i) & RESTORE_COLOR
        of BIV  :   result = NUM_COLOR & $(v.bi) & RESTORE_COLOR
        of RV   :   result = NUM_COLOR & $(v.r) & RESTORE_COLOR
        of BV   :   result = NUM_COLOR & $(v.b) & RESTORE_COLOR
        of AV   :
            result = "#(\n"

            if v.a.len==0: return "#()"
            let items = v.a.map((x) => repeat("\t",prepend) & repeat(" ",padding) & "\t" & x.inspect(prepend+1,isKeyVal) & "\n")

            result &= items.join("")
            result &= repeat("\t",prepend) & repeat(" ",padding) & ")"
        of DV   :
            result = "#{\n"
            
            if v.d.keys.len==0: return "#{}"
            let items = sorted(v.d.keys).map((x) => repeat("\t",prepend) & repeat(" ",padding) & "\t" & KEY_COLOR & strutils.alignLeft(x,INSPECT_PADDING) & RESTORE_COLOR & ": " & v.d.getValueForKey(x).inspect(prepend+1,true) & "\n")

            result &= items.join("")
            result &= repeat("\t",prepend) & repeat(" ",padding) & "}"
        of FV   :   result = "<function " & fmt"{cast[int](addr(v.f)):#x}" & ">"
        of NV   :   result = "null"
        of ANY  :   result = ""

#[----------------------------------------
    Function
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc newUserFunction(s: StatementList, a: seq[string]): Function =
    result = Function(id: "", args: a, hasNamedArgs: (a.len!=0), body: s, hasContext: false, parentThis: nil, parentContext: nil)

##---------------------------
## Getters/Setters
##---------------------------

proc setFunctionName(f: Function, s: string) {.inline.} =
    ## Set name of given user Function
    ## ! Used only when performing a variable assignment: f: { .. }

    f.id = s
    f.hasContext = true

proc getSystemFunction*(n: string): int =
    ## Get System function code from given name

    var i = 0
    while i < SystemFunctions.len:
        if SystemFunctions[i].name==n:
            return i
        inc(i)

    result = -1

proc getSystemFunctionInstance*(n: string): SystemFunction {.inline.} =
    ## Get System function from given name

    var i = 0
    while i < SystemFunctions.len:
        if SystemFunctions[i].name==n:
            return SystemFunctions[i]
        inc(i)

proc getNameOfSystemFunction*(n: int): cstring {.exportc.} =
    ## Get name of System function from given code
    ## ! Used from the Bison parser to find out the name of a user variable
    ## ! that happens to have the same name as a System function

    result = SystemFunctions[n].name

##---------------------------
## Methods
##---------------------------

proc callFunction(f: string, v: seq[Value]): Value = 
    ## Call a function by string with a given array of Value's
    ## ! Used only for UnitTests

    let fun = getSystemFunctionInstance(f)
    let exprs = newExpressionList()

    for val in v:
        discard exprs.addExpression(expressionFromArgument(Argument(kind: literalArgument, v: val)))

    result = fun.call(fun,exprs)

proc execute(f: Function, v: Value): Value {.inline.} =
    ## Execute user function with given Value

    if f.hasContext:
        if Stack.len == 1: addContext()
        #var oldSeq:Context
        let oldSeq = Stack[1]
        #shallowCopy(oldSeq,Stack[1])
        if f.hasNamedArgs:
            if v.kind == AV: initTopContextWith(zip(f.args,v.a))
            else: initTopContextWith(f.args[0],v)
        else: initTopContextWith(ARGV,v)

        result = f.body.execute()
        if Returned!=nil: 
            Returned = nil
        #try                         : result = f.body.execute()
        #except ReturnValue as ret   : result = ret.value
        #finally                     : 
        Stack[1] = oldSeq
        #shallowCopy(Stack[1],oldSeq)
        if Stack[1].list.len==0: popContext()
    else:
        #var stored: Value = nil
        if v!=NULL:
            let stored = getAndSetSymbol(ARGV,v)
            if f.hasNamedArgs:
                if v.kind == AV: 
                    var i = 0
                    while i<f.args.len:
                        resetSymbol(f.args[i],v.a[i])
                        inc(i)
                else: resetSymbol(f.args[0],v)
            result = f.body.execute()
            discard setSymbol(ARGV,stored)
        else:
            result = f.body.execute()
        #try                         : result = f.body.execute()
        #except ReturnValue as ret   : raise
        #finally                     : 
        #if stored!=nil: discard setSymbol(ARGV,stored)

proc validate(x: Expression, name: string, req: openArray[ValueKind]): Value {.inline.} =
    ## Validate given Expression against an array of ValueKind's
    ## ! Called only from System functions

    result = x.evaluate()

    if not likely(req.contains(result.kind)):
        let expected = req.map((x) => $(x)).join(" or ")
        IncorrectArgumentValuesError(name, expected, $(result.kind))

proc showValidationError(req:FunctionConstraints, vs:seq[Value], name: string) = 
    let expected = req.map((x) => "(" & x.map((y) => ($y).valueKindToPrintable()).join(",") & ")").join(" or ")
    let got = vs.map((x) => ($(x.kind)).valueKindToPrintable()).join(",")

    IncorrectArgumentValuesError(name, expected, got)

proc validate(xl: ExpressionList, f: SystemFunction): seq[Value] {.inline.} =
    ## Validate given ExpressionList against given array of constraints
    ## ! Called only from System functions

    result = xl.list.map((x) => x.evaluate())

    if not likely(f.req.contains(result.map((x) => x.kind))):
        showValidationError(f.req, result, f.name)
        
proc getOneLineDescription*(f: SystemFunction): string =
    ## Get one-line description for given System function
    ## ! Called only from the Console module

    let args = 
        if f.req.len>0: f.req.map((x) => "(" & x.map((y) => ($y).valueKindToPrintable()).join(",") & ")").join(" / ")
        else: "()"

    let ret = "[" & f.ret.join(",").valueKindToPrintable() & "]"

    result = strutils.alignLeft("\e[1m" & f.name & "\e[0m",20) & " " & args & " \x1B[0;32m->\x1B[0;37m " & ret

proc getFullDescription*(f: SystemFunction): string =
    ## Get full description for given System function
    ## ! Called only from the Console module

    let args = 
        if f.req.len>0: f.req.map((x) => "(" & x.map((y) => ($y).valueKindToPrintable()).join(",") & ")").join(" / ")
        else: "()"

    let ret = "[" & f.ret.join(",").valueKindToPrintable() & "]"

    result  = "Function : \e[1m" & f.name & "\e[0m" & "\n"
    result &= "       # : " & f.desc & "\n\n"
    result &= "   usage : " & f.name & " " & args & "\n"
    result &= "        \x1B[0;32m->\x1B[0;37m " & ret & "\n"

#[----------------------------------------
    KeyPath
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc keypathFromIdId(a: cstring, b: cstring): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: stringKeyPathPart, s: $b)])

proc keypathFromIdInteger(a: cstring, b: cstring): KeyPath {.exportc.} =
    var intValue: int
    discard parseInt($b, intValue)

    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: integerKeyPathPart, i: intValue)])

proc keypathFromIdReal(a: cstring, b: cstring): KeyPath {.exportc.} =
    let parts = ($b).split(".")
    var intA, intB: int
    discard parseInt(parts[0], intA)
    discard parseInt(parts[1], intB)

    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: integerKeyPathPart, i: intA), KeyPathPart(kind: integerKeyPathPart, i: intB)])

proc keypathFromIdInline(a: cstring, b: Argument): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: inlineKeyPathPart, a: b)])

proc keypathFromInlineId(a: Argument, b: cstring): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: stringKeyPathPart, s: $b)])

proc keypathFromInlineInteger(a: Argument, b: cstring): KeyPath {.exportc.} =
    var intValue: int
    discard parseInt($b, intValue)

    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: integerKeyPathPart, i: intValue)])

proc keypathFromInlineReal(a: Argument, b: cstring): KeyPath {.exportc.} =
    let parts = ($b).split(".")
    var intA, intB: int
    discard parseInt(parts[0], intA)
    discard parseInt(parts[1], intB)

    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: integerKeyPathPart, i: intA), KeyPathPart(kind: integerKeyPathPart, i: intB)])

proc keypathFromInlineInline(a: Argument, b: Argument): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: inlineKeyPathPart, a: b)])

proc keypathByAddingIdToKeypath(k: KeyPath, a: cstring):KeyPath {.exportc.} =
    k.parts.add(KeyPathPart(kind: stringKeyPathPart, s: $a))
    result = k

proc keypathByAddingIntegerToKeypath(k: KeyPath, a: cstring):KeyPath {.exportc.} =
    var intValue: int
    discard parseInt($a, intValue)

    k.parts.add(KeyPathPart(kind: integerKeyPathPart, i: intValue))
    result = k

proc keypathByAddingRealToKeypath(k: KeyPath, a: cstring):KeyPath {.exportc.} =
    let parts = ($a).split(".")
    var intA, intB: int
    discard parseInt(parts[0], intA)
    discard parseInt(parts[1], intB)

    k.parts.add(KeyPathPart(kind: integerKeyPathPart, i: intA))
    k.parts.add(KeyPathPart(kind: integerKeyPathPart, i: intB))
    result = k

proc keypathByAddingInlineToKeypath(k: KeyPath, a: Argument): KeyPath {.exportc.} =
    k.parts.add(KeyPathPart(kind: inlineKeyPathPart, a: a))
    result = k

#[----------------------------------------
    Expression
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc expressionFromArgument(a: Argument): Expression {.exportc.} =
    result = Expression(kind: argumentExpression, a: a)

proc expressionFromRange(a: Argument, b: Argument): Expression {.exportc.} =
    var lst = newExpressionList(@[
        expressionFromArgument(a),
        expressionFromArgument(b)
    ])

    result = Expression(kind: argumentExpression, a: argumentFromCommand(RANGE_CMD,lst))

proc expressionFromExpressions(l: Expression, op: cstring, r: Expression): Expression {.exportc.} =
    result = Expression(kind: normalExpression, left: l, op: parseEnum[ExpressionOperator]($op), right: r)

proc expressionFromKeyPathPart(part: KeyPathPart, isFirst: bool = false): Expression =
    case part.kind
        of stringKeyPathPart:
            if isFirst: result = expressionFromArgument(argumentFromIdentifier(part.s))
            else: result = expressionFromArgument(argumentFromStringLiteral("\"" & part.s & "\""))
        of integerKeyPathPart:
            result = expressionFromArgument(argumentFromIntegerLiteral($(part.i)))
        of inlineKeyPathPart:
            result = expressionFromArgument(part.a)

##---------------------------
## Methods
##---------------------------

proc evaluate(x: Expression): Value {.inline.} =
    ## Evaluate given Expression an return the result

    case x.kind
        of argumentExpression:
            result = x.a.getValue()
        of normalExpression:
            let left = x.left.evaluate()
            let right = x.right.evaluate()

            {.computedGoto.}
            case x.op
                of PLUS_SG  : result = left + right
                of MINUS_SG : result = left - right
                of MULT_SG  : result = left * right
                of DIV_SG   : result = left / right
                of MOD_SG   : result = left % right
                of POW_SG   : result = left ^ right
                of EQ_OP    : result = BOOL(left.eq(right))
                of LT_OP    : result = BOOL(left.lt(right))
                of GT_OP    : result = BOOL(left.gt(right))
                of LE_OP    : result = BOOL(left.lt(right) or left.eq(right))
                of GE_OP    : result = BOOL(left.gt(right) or left.eq(right))
                of NE_OP    : result = BOOL(not (left.eq(right)))

#[----------------------------------------
    ExpressionList
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc newExpressionList: ExpressionList {.exportc.} =
    result = ExpressionList(list: @[])

proc newExpressionList(xl: seq[Expression]): ExpressionList =
    result = ExpressionList(list: xl)

proc newExpressionListWithExpression(x: Expression): ExpressionList {.exportc.} =
    result = ExpressionList(list: @[x])

proc expressionListWithChainedStatement(st: Statement): ExpressionList {.exportc.} =
    newExpressionListWithExpression(expressionFromArgument(argumentFromInlineCallLiteral(st)))

template expressionListWithARGV(): ExpressionList = 
    newExpressionListWithExpression(expressionFromArgument(argumentFromIdentifier(ARGV)))

proc copyExpressionList(xl: ExpressionList): ExpressionList {.exportc.} =
    ExpressionList(list: xl.list)

proc addExpression(xl: ExpressionList, x: Expression): ExpressionList {.exportc.} =
    xl.list.add(x)
    result = xl

##---------------------------
## Methods
##---------------------------

proc evaluate(xl: ExpressionList, forceArray: bool=false): Value {.inline.} = 
    ## Evaluate given ExpressionList and return the result

    if forceArray or xl.list.len>1:
        result = ARR(xl.list.map((x) => x.evaluate()))
    else:
        if xl.list.len==1:
            result = xl.list[0].evaluate()
        else:
            result = ARR(@[])
    
#[----------------------------------------
    Argument
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc argumentFromIdentifier(i: cstring): Argument {.exportc.} =
    Argument(kind: identifierArgument, i: $i)

proc argumentFromCommandIdentifier(i: cint): Argument {.exportc.} =
    Argument(kind: identifierArgument, i: SystemFunctions[i].name)

proc argumentFromStringLiteral(l: cstring): Argument {.exportc.} =
    if ConstStrings.hasKey($l):
        result = ConstStrings[$l]
    else:
        result = Argument(kind: literalArgument, v: STR(unescape($l).replace("\\n","\n")))
        ConstStrings[$l] = result

proc argumentFromIntegerLiteral(l: cstring): Argument {.exportc.} =
    Argument(kind: literalArgument, v: INT($l))

proc argumentFromRealLiteral(l: cstring): Argument {.exportc.} =
    Argument(kind: literalArgument, v: REAL($l))

proc argumentFromBooleanLiteral(l: cstring): Argument {.exportc.} =
    if l=="true": Argument(kind: literalArgument, v: TRUE)
    else: Argument(kind: literalArgument, v: FALSE)

proc argumentFromKeypath(k: KeyPath): Argument {.exportc.} =
    var exprA = expressionFromKeyPathPart(k.parts[0], true)

    var i = 1
    while i<k.parts.len:
        var exprB = expressionFromKeyPathPart(k.parts[i], false)
        var lst = newExpressionList(@[exprA,exprB])

        exprA = expressionFromArgument(argumentFromCommand(GET_CMD,lst))

        inc(i)
        
    result = exprA.a

proc argumentFromNullLiteral(): Argument {.exportc.} =
    Argument(kind: literalArgument, v: NULL)

proc argumentFromArrayLiteral(l: ExpressionList): Argument {.exportc.} =
    if l==nil: Argument(kind: arrayArgument, a: newExpressionList())
    else: Argument(kind: arrayArgument, a: l)

proc argumentFromDictionaryLiteral(l: StatementList): Argument {.exportc.} =
    Argument(kind: dictionaryArgument, d: l)

proc argumentFromFunctionLiteral(l: StatementList, args: cstring = ""): Argument {.exportc.} =
    if args=="": Argument(kind: functionArgument, f: newUserFunction(l,@[]))
    else: Argument(kind: functionArgument, f: newUserFunction(l,($args).split(",")))

proc argumentFromInlineCallLiteral(l: Statement): Argument {.exportc.} =
    Argument(kind: inlineCallArgument, c: l)

proc argumentFromCommand(cmd: cint, xl: ExpressionList): Argument = 
    argumentFromInlineCallLiteral(statementFromCommand(cmd,xl,0))

proc argumentFromMapId(i: cstring): Argument {.exportc.} =
    var sl = newStatementList(@[statementFromCall($i,expressionListWithARGV(),0)])
    result = argumentFromFunctionLiteral(sl,"")

proc argumentFromMapCommand(c: cint): Argument {.exportc.} =
    var sl = newStatementList(@[statementFromCommand(c,expressionListWithARGV(),0)])
    result = argumentFromFunctionLiteral(sl,"")

proc argumentFromMapKeypath(k: KeyPath): Argument {.exportc.} =
    var sl = newStatementList(@[statementFromCallWithKeypath(k,expressionListWithARGV(),0)])
    result = argumentFromFunctionLiteral(sl,"")

##---------------------------
## Methods
##---------------------------

proc getValue(a: Argument): Value {.inline.} =
    ## Retrieve runtime Value of given Argument

    {.computedGoto.}
    case a.kind
        of identifierArgument:
            shallowCopy(result,getSymbol(a.i))
            if result == nil: SymbolNotFoundError(a.i)
        of literalArgument:
            result = valueCopy(a.v)
        of arrayArgument:
            result = a.a.evaluate(forceArray=true)
        of dictionaryArgument:
            var ret = DICT(Context(list: @[]))

            addContext()
            for statement in a.d.list:
                discard statement.execute(ret)
            popContext()

            result = ret
        of functionArgument:
            result = FUNC(a.f)
        of inlineCallArgument:
            result = a.c.execute()

#[----------------------------------------
    Statement
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc statementFromCommand(i: cint, xl: ExpressionList, l: cint): Statement {.exportc.} =
    result = Statement(kind: commandStatement, code: i, arguments: xl, pos: l)

proc statementFromCall(i: cstring, xl: ExpressionList, l: cint=0): Statement {.exportc.} =
    result = Statement(kind: callStatement, id: $i, expressions: xl, pos: l) 

proc statementFromCallWithKeypath(k: KeyPath, xl: ExpressionList, l: cint=0): Statement {.exportc.} =
    var lst = newExpressionList(@[
        expressionFromArgument(argumentFromKeypath(k)),
        expressionFromArgument(argumentFromArrayLiteral(xl))
    ])
    
    result = statementFromCommand(EXEC_CMD,lst,l)

proc statementFromAssignment(i: cstring, st: Statement, l: cint): Statement {.exportc.} =
    result = Statement(kind: assignmentStatement, symbol: $i, rValue: st, pos: l)

proc statementFromAssignmentWithKeypath(k: KeyPath, st: Statement, l: cint=0): Statement {.exportc.} =
    var parentExpr = expressionFromKeyPathPart(k.parts[0], true)

    var i = 1
    while i<k.parts.len-1:
        var exprB = expressionFromKeyPathPart(k.parts[i], false)
        var lst = newExpressionList(@[parentExpr,exprB])

        parentExpr = expressionFromArgument(argumentFromCommand(GET_CMD,lst))
        inc(i)
    
    var keyExpr = expressionFromKeyPathPart(k.parts[^1],false)
    var lst = newExpressionList(@[parentExpr,keyExpr, expressionFromArgument(argumentFromInlineCallLiteral(st))])

    result = statementFromCommand(SET_CMD,lst,l)

proc statementFromExpression(x: Expression, l: cint=0): Statement {.exportc.} =
    result = Statement(kind: expressionStatement, expression: x, pos: l)

proc statementByAddingImplication(st: Statement, i: Statement): Statement {.exportc.} =
    let e = expressionFromArgument(argumentFromFunctionLiteral(newStatementListWithStatement(i)))
    case st.kind
        of callStatement: 
            st.arguments.list.add(e)
        of commandStatement: 
            st.expressions.list.add(e)
        else: discard
        
    result = st

##---------------------------
## Methods
##---------------------------

proc execute(stm: Statement, parent: Value = nil): Value {.inline.} = 
    ## Execute given statement and return result
    ## parent = means statement is in a dictionary context

    StatementLine = stm.pos

    case stm.kind
        of commandStatement:
            # System function calls

            result = SystemFunctions[stm.code].call(SystemFunctions[stm.code],stm.arguments)

        of callStatement:
            # User function calls

            let sym = getSymbol(stm.id)
            if sym==nil: SymbolNotFoundError(stm.id)
            else: 
                if sym.kind==FV:
                    result = sym.f.execute(stm.expressions.evaluate(forceArray=true))
                else: 
                    FunctionNotFoundError(stm.id)

        of assignmentStatement:
            # Assignments

            result = stm.rValue.execute()
            if parent==nil:
                if result.kind==FV: setFunctionName(result.f,stm.id)   
                discard setSymbol(stm.id, result)
            else:
                parent.d.updateOrSet(stm.id, result)
                if result.kind==FV:
                    result.f.parentThis = result
                    result.f.parentContext = parent.d   

        of expressionStatement:
            # Simple expression statements

            result = stm.expression.evaluate()

#[----------------------------------------
    StatementList
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc newStatementList: StatementList {.exportc.} =
    result = StatementList(list: @[])

proc newStatementList(sl: seq[Statement]): StatementList =
    result = StatementList(list: sl)

proc newStatementListWithStatement(s: Statement): StatementList {.exportc.} =
    result = StatementList(list: @[s])

proc addStatement(sl: StatementList, s: Statement): StatementList {.exportc.} =
    sl.list.add(s)
    result = sl

##---------------------------
## Methods
##---------------------------

proc execute(sl: StatementList): Value {.inline.} = 
    ## Execute given StatementList and return result

    var i = 0
    while i < sl.list.len:
        #try:
        result = sl.list[i].execute()
        if Returned != nil:
            return Returned
        #except ReturnValue:
        #    raise
        #except Exception as e:
        #    runtimeError(e.msg, FileName, sl.list[i].pos)

        inc(i)

#[######################################################
    Environment setup
  =====================================================]#

template initializeConsts() =
    ## Setup global constant values that are to be re-used throughout the code

    ConstStrings    = newTable[string,Argument]()
    TRUE            = Value(kind: BV, b: true)
    FALSE           = Value(kind: BV, b: false)
    NULL            = Value(kind: NV)

proc setup*(args: seq[string] = @[]) = 
    initializeConsts()
    Stack = newSeqOfCap[Context](2)
    addContext() # global
    initTopContextWith(ARGV, ARR(args.map((x) => STR(x))))

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


proc runScript*(scriptPath:string, args: seq[string], includePath:string="", warnings:bool=false) = 
    ## Run a specific script from given path
    ## ! This is the main entry procedure

    if not fileExists(scriptPath): 
        cmdlineError("path not found: '" & scriptPath & "'")

    var (dir, name, ext) = splitFile(scriptPath)
    Paths.add(dir)

    setup(args)

    yylineno = 0
    yyfilename = scriptPath
    FileName = scriptPath

    QuitOnError = true

    let success = open(yyin, scriptPath)
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
