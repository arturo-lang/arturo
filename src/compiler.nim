#[****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import algorithm, bitops, macros, math, os, parseutils, random, sequtils, strformat, strutils, sugar, unicode, tables
import bignum
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
        EQ_OP, GE_OP, LE_OP, GT_OP, LT_OP, NE_OP

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

    SystemFunction* = object
        lib*            : string
        call*           : SystemFunctionCall[SystemFunction,ExpressionList,Value]
        name*           : string
        req             : FunctionConstraints
        ret             : FunctionReturns
        desc            : string

    Function* = ref object
        id              : string
        args            : seq[string]
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
            of stringValue          : s: string
            of integerValue         : i*: int
            of bigIntegerValue      : bi*: Int
            of realValue            : r: float
            of booleanValue         : b: bool 
            of arrayValue           : a: seq[Value]
            of dictionaryValue      : d: Context
            of functionValue        : f: Function
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
proc STRARR(v: seq[string]): Value {.inline.}
proc INTARR(v: seq[int]): Value {.inline.}
proc BIGINTARR(v: seq[Int]): Value {.inline.}
proc REALARR(v: seq[float]): Value {.inline.}
proc BOOLARR(v: seq[bool]): Value {.inline.}
proc valueCopy(v: Value): Value
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
proc valueKindToPrintable(s: string): string
proc stringify*(v: Value, quoted: bool = true): string
proc inspect*(v: Value, prepend: int = 0, isKeyVal: bool = false): string

# Function

proc getSystemFunction*(n: string): int {.inline.}
proc getSystemFunctionInstance*(n: string): SystemFunction {.inline.}
proc callFunction(f: string, v: seq[Value]): Value
proc execute(f: Function, v: Value): Value {.inline.} 
proc validate(x: Expression, name: string, req: openArray[ValueKind]): Value {.inline.}
proc validate(xl: ExpressionList, name: string, req: seq[seq[ValueKind]]): seq[Value] {.inline.}

# Expression

proc expressionFromArgument(a: Argument): Expression {.exportc.}
proc evaluate(x: Expression): Value {.inline.}

# ExpressionList

proc newExpressionList: ExpressionList {.exportc.}
proc newExpressionList(xl: seq[Expression]): ExpressionList
proc addExpression(xl: ExpressionList, x: Expression): ExpressionList {.exportc.}
proc evaluate(xl: ExpressionList, forceArray: bool=false): Value

# Statement

proc statementFromCommand(i: cint, xl: ExpressionList, l: cint): Statement {.exportc.}
proc statementFromCall(i: cstring, xl: ExpressionList, l: cint=0): Statement {.exportc.}
proc statementFromCallWithKeypath(k: KeyPath, xl: ExpressionList, l: cint=0): Statement {.exportc.}
proc execute(stm: Statement, parent: Value = nil): Value {.inline.}

# StatementList

proc newStatementList: StatementList {.exportc.}
proc newStatementList(sl: seq[Statement]): StatementList
proc addStatement(sl: StatementList, s: Statement): StatementList {.exportc.}
proc execute(sl: StatementList): Value

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
    IsRepl                  : bool

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
include lib/system/core
include lib/system/dictionary
include lib/system/file
include lib/system/generic
include lib/system/logical
include lib/system/math
include lib/system/reflection
include lib/system/string
include lib/system/terminal

##---------------------------
## Function registration
##---------------------------

const
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
        SystemFunction(lib:"array",         name:"last",                call:Array_last,                req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array"),
        SystemFunction(lib:"array",         name:"map",                 call:Array_map,                 req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after executing given function for each element"),
        SystemFunction(lib:"array",         name:"map!",                call:Array_mapI,                req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after executing given function for each element (in-place)"),
        SystemFunction(lib:"array",         name:"pop",                 call:Array_pop,                 req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array (same as 'last')"),
        SystemFunction(lib:"array",         name:"pop!",                call:Array_popI,                req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array and delete it (in-place)"),
        SystemFunction(lib:"array",         name:"range",               call:Array_range,               req: @[@[IV,IV]],                                                                   ret: @[AV],             desc:"get array from given range (from..to) with optional step"),
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

        SystemFunction(lib:"core",          name:"exec",                call:Core_exec,                 req: @[@[FV,AV]],                                                                   ret: @[ANY],            desc:"execute function using given array of values"),
        SystemFunction(lib:"core",          name:"if",                  call:Core_if,                   req: @[@[BV,FV],@[BV,FV,FV]],                                                       ret: @[ANY],            desc:"if condition is true, execute given function; else execute optional alternative function"),
        SystemFunction(lib:"core",          name:"loop",                call:Core_loop,                 req: @[@[AV,FV],@[DV,FV],@[BV,FV],@[IV,FV]],                                        ret: @[ANY],            desc:"execute given function for each element in collection, or while condition is true"),
        SystemFunction(lib:"core",          name:"panic",               call:Core_panic,                req: @[@[SV]],                                                                      ret: @[SV],             desc:"exit program printing given error message"),
        SystemFunction(lib:"core",          name:"return",              call:Core_return,               req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV]],                                 ret: @[ANY],            desc:"break execution and return given value"),

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

        SystemFunction(lib:"logical",       name:"and",                 call:Logical_and,               req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical AND"),
        SystemFunction(lib:"logical",       name:"nand",                call:Logical_nand,              req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical NAND"),
        SystemFunction(lib:"logical",       name:"nor",                 call:Logical_nor,               req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical NOR"),
        SystemFunction(lib:"logical",       name:"not",                 call:Logical_not,               req: @[@[BV],@[IV]],                                                                ret: @[BV,IV],          desc:"bitwise/logical NOT"),
        SystemFunction(lib:"logical",       name:"or",                  call:Logical_or,                req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical OR"),
        SystemFunction(lib:"logical",       name:"xnor",                call:Logical_xnor,              req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical XNOR"),   
        SystemFunction(lib:"logical",       name:"xor",                 call:Logical_xor,               req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical XOR"),   

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
        SystemFunction(lib:"math",          name:"round",               call:Math_round,                req: @[@[RV]],                                                                      ret: @[RV],             desc:"get given value rounded to the nearest value"),
        SystemFunction(lib:"math",          name:"product",             call:Math_product,              req: @[@[AV]],                                                                      ret: @[IV,BIV],         desc:"return product of elements of given array"),
        SystemFunction(lib:"math",          name:"random",              call:Math_random,               req: @[@[IV,IV]],                                                                   ret: @[IV],             desc:"generate random number in given range"),
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
        
        SystemFunction(lib:"reflection",    name:"inspect",             call:Reflection_inspect,        req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen in a readable format"),
        SystemFunction(lib:"reflection",    name:"type",                call:Reflection_type,           req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"get type of given object as a string"),

        SystemFunction(lib:"string",        name:"capitalize",          call:String_capitalize,         req: @[@[SV]],                                                                      ret: @[SV],             desc:"capitalize given string"),
        SystemFunction(lib:"string",        name:"capitalize!",         call:String_capitalizeI,        req: @[@[SV]],                                                                      ret: @[SV],             desc:"capitalize given string (in-place)"),
        SystemFunction(lib:"string",        name:"isAlpha",             call:String_isAlpha,            req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are ASCII letters"),
        SystemFunction(lib:"string",        name:"isAlphaNumeric",      call:String_isAlphaNumeric,     req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are ASCII letters or digits"),
        SystemFunction(lib:"string",        name:"isLowercase",         call:String_isLowercase,        req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are lowercase"),
        SystemFunction(lib:"string",        name:"isNumber",            call:String_isNumber,           req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if given string is a number"),
        SystemFunction(lib:"string",        name:"isUppercase",         call:String_isUppercase,        req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are uppercase"),
        SystemFunction(lib:"string",        name:"isWhitespace",        call:String_isWhitespace,       req: @[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are whitespace"),
        SystemFunction(lib:"string",        name:"join",                call:String_join,               req: @[@[AV],@[AV,SV]],                                                                      ret: @[SV],             desc:"join strings in given array, optionally using separator"),
        SystemFunction(lib:"string",        name:"lowercase",           call:String_lowercase,          req: @[@[SV]],                                                                      ret: @[SV],             desc:"lowercase given string"),
        SystemFunction(lib:"string",        name:"lowercase!",          call:String_lowercaseI,         req: @[@[SV]],                                                                      ret: @[SV],             desc:"lowercase given string (in-place)"),
        SystemFunction(lib:"string",        name:"lines",               call:String_lines,              req: @[@[SV]],                                                                      ret: @[AV],             desc:"get lines from string as an array"),
        SystemFunction(lib:"string",        name:"uppercase",           call:String_uppercase,          req: @[@[SV]],                                                                      ret: @[SV],             desc:"uppercase given string"),
        SystemFunction(lib:"string",        name:"uppercase!",          call:String_uppercaseI,         req: @[@[SV]],                                                                      ret: @[SV],             desc:"uppercase given string (in-place)"),

        SystemFunction(lib:"terminal",      name:"input",               call:Terminal_input,            req: @[],                                                                           ret: @[SV],             desc:"read line from stdin"),
        SystemFunction(lib:"terminal",      name:"print",               call:Terminal_print,            req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen")
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

#[######################################################
    Context management
  ======================================================]#

##---------------------------
## Constructors
##---------------------------

proc addContext() {.inline.} =
    ## Add a new context to the Stack
    
    Stack.add(Context(list: @[]))

proc initTopContextWith(key:string, val:Value) {.inline.} =
    ## Initialize topmost Context with key-val pair

    Stack[^1] = Context(list: @[(key,val)])

proc initTopContextWith(pairs:seq[(string,Value)]) {.inline.} =
    ## Initialize topmost Context with key-val pairs

    Stack[^1] = Context(list:pairs)

proc popContext() {.inline.} =
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
            ctx.list[i][1] = v
            return
        inc(i)

    ctx.list.add((k,v))

proc getSymbol(k: string): Value {.inline.} = 
    ## Get Value of key in the Stack

    var i = len(Stack) - 1
    while i > -1:
        var j = 0
        while j<Stack[i].list.len:
            if Stack[i].list[j][0]==k: 
                return Stack[i].list[j][1]
            inc(j)
        dec(i)

    return nil

proc getAndSetSymbol(k: string, v: Value): Value {.inline.} = 
    ## Set key in the Stack and return previous Value

    var i = len(Stack) - 1
    while i > -1:
        var j = 0
        while j<Stack[i].list.len:
            if Stack[i].list[j][0]==k: 
                result = Stack[i].list[j][1]
                Stack[i].list[j][1] = v
            inc(j)
        dec(i)

    return nil

proc setSymbol(k: string, v: Value, redefine: bool=false): Value {.inline.} = 
    ##  Set key in the Stack

    if redefine:
        Stack[^1].updateOrSet(k,v)
        result = v
    else:
        var i = len(Stack) - 1
        while i > -1:
            var j = 0
            while j<Stack[i].list.len:
                if Stack[i].list[j][0]==k: 
                    Stack[i].list[j][1]=v
                    return v
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
            echo tab,t[0]," -> ",t[1].stringify()

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

proc valueCopy(v: Value): Value =
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
                of IV: INT(l.i ^ r.i)
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
        of RV:
            result = case r.kind
                of IV: int(l.r)>r.i
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

proc valueKindToPrintable(s: string): string = 
    ## Convert ValueKind string representation to sth shorter and more readable
    ## ! Requires better rewriting

    s.replace("Value","").replace("ionary","").replace("tion","").replace("eger","").replace("ing","").replace("ean","")

proc stringify*(v: Value, quoted: bool = true): string =
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
            let items = sorted(v.d.keys).map((x) => repeat("\t",prepend) & repeat(" ",padding) & "\t" & KEY_COLOR & strutils.alignLeft(x,INSPECT_PADDING) & RESTORE_COLOR & "" & v.d.getValueForKey(x).inspect(prepend+1,true) & "\n")

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
    result = Function(id: "", args: a, body: s, hasContext: false, parentThis: nil, parentContext: nil)

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

        var oldSeq:Context
        oldSeq = Stack[1]

        if f.args.len>0:
            if v.kind == AV: initTopContextWith(zip(f.args,v.a))
            else: initTopContextWith(f.args[0],v)
        else: initTopContextWith(ARGV,v)

        try                         : result = f.body.execute()
        except ReturnValue as ret   : result = ret.value
        finally                     : 
            Stack[1]=oldSeq
            if Stack[1].list.len==0: popContext()
    else:
        var stored: Value = nil
        if v!=NULL:
            if f.args.len>0:
                if v.kind == AV: 
                    var i = 0
                    while i<f.args.len:
                        discard setSymbol(f.args[i],v.a[i],redefine=true)
                        inc(i)
                else: discard setSymbol(f.args[0],v,redefine=true)
            else: stored = getAndSetSymbol(ARGV,v)

        try                         : result = f.body.execute()
        except ReturnValue as ret   : raise
        finally                     : 
            if stored!=nil: discard setSymbol(ARGV,stored)

proc validate(x: Expression, name: string, req: openArray[ValueKind]): Value {.inline.} =
    ## Validate given Expression against an array of ValueKind's
    ## ! Called only from System functions

    result = x.evaluate()

    if not (result.kind in req):
        let expected = req.map((x) => $(x)).join(" or ")
        IncorrectArgumentValuesError(name, expected, $(result.kind))

proc validate(xl: ExpressionList, name: string, req: seq[seq[ValueKind]]): seq[Value] {.inline.} =
    ## Validate given ExpressionList against given array of constraints
    ## ! Called only from System functions

    result = xl.list.map((x) => x.evaluate())

    if not req.contains(result.map((x) => x.kind)):

        let expected = req.map((x) => x.map((y) => ($y).valueKindToPrintable()).join(",")).join(" or ")
        let got = result.map((x) => ($(x.kind)).valueKindToPrintable()).join(",")

        IncorrectArgumentValuesError(name, expected, got)

proc getOneLineDescription*(f: SystemFunction): string =
    ## Get one-line description for given System function
    ## ! Called only from the Console module

    let args = 
        if f.req.len>0: f.req.map((x) => "(" & x.map(proc (y: ValueKind): string = ($y).valueKindToPrintable()).join(",") & ")").join(" / ")
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

proc keypathFromIdInline(a: cstring, b: Argument): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: inlineKeyPathPart, a: b)])

proc keypathFromInlineId(a: Argument, b: cstring): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: stringKeyPathPart, s: $b)])

proc keypathFromInlineInteger(a: Argument, b: cstring): KeyPath {.exportc.} =
    var intValue: int
    discard parseInt($b, intValue)

    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: integerKeyPathPart, i: intValue)])

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
            var left = x.left.evaluate()
            var right: Value

            if x.right!=nil: right = x.right.evaluate()
            else: return left
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

proc evaluate(xl: ExpressionList, forceArray: bool=false): Value = 
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
            result = getSymbol(a.i)
            if result == nil: SymbolNotFoundError(a.i)
        of literalArgument:
            result = a.v
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

##---------------------------
## Methods
##---------------------------

proc execute(stm: Statement, parent: Value = nil): Value {.inline.} = 
    ## Execute given statement and return result
    ## parent = means statement is in a dictionary context

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

proc execute(sl: StatementList): Value = 
    ## Execute given StatementList and return result

    var i = 0
    while i < sl.list.len:
        try:
            result = sl.list[i].execute()
        except ReturnValue:
            raise
        except Exception as e:
            if IsRepl: raise
            else: runtimeError(e.msg, FileName, sl.list[i].pos, IsRepl)

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

    var buff = yy_scan_string(src)

    yylineno = 0
    yyfilename = "-"
    FileName = "-"
    IsRepl = true

    yy_switch_to_buffer(buff)

    MainProgram = nil
    discard yyparse()

    yy_delete_buffer(buff)

    try:
        result = MainProgram.execute().stringify()
    except Exception as e:
        runtimeError(e.msg, FileName, 0, IsRepl)


proc runScript*(scriptPath:string, args: seq[string], includePath:string="", warnings:bool=false) = 
    ## Run a specific script from given path
    ## ! This is the main entry procedure

    if not fileExists(scriptPath): 
        cmdlineError("path not found: '" & scriptPath & "'")

    setup(args)

    yylineno = 0
    yyfilename = scriptPath
    FileName = scriptPath
    IsRepl = false

    let success = open(yyin, scriptPath)
    if not success:
        cmdlineError("something went wrong when opening file")
    else:
        #benchmark "parsing":
        discard yyparse()

        discard MainProgram.execute()


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
