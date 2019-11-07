#[****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import algorithm, bitops, macros, math, os, parseutils, random, sequtils, strutils, sugar, unicode, tables
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
        assignmentStatement,
        expressionStatement,
        normalStatement

    Statement = ref object
        pos: int
        case kind: StatementKind:
            of commandStatement:
                code            : int
                arguments       : ExpressionList
            of assignmentStatement:
                symbol          : string
                rValue          : ExpressionList
            of expressionStatement:
                expression      : Expression
            of normalStatement:
                id              : string
                expressions     : ExpressionList

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

proc keys*(ctx: Context): seq[string] {.inline.}
proc values*(ctx: Context): seq[Value] {.inline.}
proc getValueForKey*(ctx: Context, key: string): Value {.inline.}
proc inspectStack()

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

proc getSystemFunctionInstance*(n: string): SystemFunction {.inline.}
proc callFunction(f: string, v: seq[Value]): Value
proc execute(f: Function, v: Value): Value {.inline.} 
proc validate(x: Expression, name: string, req: openArray[ValueKind]): Value {.inline.}
proc validate(xl: ExpressionList, name: string, req: seq[seq[ValueKind]]): seq[Value] {.inline.}

proc newExpressionList: ExpressionList {.exportc.}
proc addExpressionToExpressionList(x: Expression, xl: ExpressionList): ExpressionList {.exportc.}
proc evaluate(x: Expression): Value {.inline.}
proc evaluate(xl: ExpressionList, forceArray: bool=false): Value

proc expressionFromArgument(a: Argument): Expression {.exportc.}

proc statementFromExpressions(i: cstring, xl: ExpressionList, l: cint=0): Statement {.exportc.}
proc statementFromCommand(i: cint, xl: ExpressionList, l: cint): Statement {.exportc.}
proc execute(stm: Statement, parent: Value = nil): Value {.inline.}
proc execute(sl: StatementList): Value

proc argumentFromInlineCallLiteral(l: Statement): Argument {.exportc.}
proc getValue(a: Argument): Value {.inline.}

proc setup*(args: seq[string] = @[])

#[######################################################
    Globals
  ======================================================]#

var
    MainProgram {.exportc.} : StatementList

    # Environment

    Stack*                  : seq[Context]
    FileName                : string
    IsRepl                  : bool

    # Const/literal arguments

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
template ANY():ValueKind        = anyValue

template S(_:int):string        = v[_].s
template I(_:int):int           = v[_].i
template BI(_:int):Int          = v[_].bi
template R(_:int):float         = v[_].r
template B(_:int):bool          = v[_].b
template A(_:int):seq[Value]    = v[_].a
template D(_:int):Context       = v[_].d
template FN(_:int):Function     = v[_].f

template STR(v:string):Value        = Value(kind: stringValue, s: v)
template INT(v:int):Value           = Value(kind: integerValue, i: v)
template BIGINT(v:Int):Value        = Value(kind: bigIntegerValue, bi: v)
template REAL(v:float):Value        = Value(kind: realValue, r: v)
template BOOL(v:bool):Value         = 
    if v: TRUE
    else: FALSE
template ARR(v:seq[Value]):Value    = Value(kind: arrayValue, a: v)
template DICT(v:Context):Value      = Value(kind: dictionaryValue, d: v)
template FUNC(v:Function):Value     = Value(kind: functionValue, f: v)

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
include lib/system/math
include lib/system/reflection
include lib/system/string

const
    SystemFunctions* = @[
        #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        #              Library              Name                        Call                            Args                                                                                Return                  Description                                                                                             
        #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        SystemFunction(lib:"core",          name:"and",                 call:Core_and,                  req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical AND"),
        SystemFunction(lib:"core",          name:"get",                 call:Core_get,                  req: @[@[AV,IV],@[DV,SV]],                                                          ret: @[ANY],            desc:"get element from collection using given index/key"),
        SystemFunction(lib:"core",          name:"input",               call:Core_input,                req: @[],                                                                           ret: @[SV],             desc:"read line from stdin"),
        SystemFunction(lib:"core",          name:"if",                  call:Core_if,                   req: @[@[BV,FV],@[BV,FV,FV]],                                                       ret: @[ANY],            desc:"if condition is true, execute given function; else execute optional alternative function"),
        SystemFunction(lib:"core",          name:"loop",                call:Core_loop,                 req: @[@[AV,FV],@[DV,FV],@[BV,FV],@[IV,FV]],                                        ret: @[ANY],            desc:"execute given function for each element in collection, or while condition is true"),
        SystemFunction(lib:"core",          name:"not",                 call:Core_not,                  req: @[@[BV],@[IV]],                                                                ret: @[BV,IV],          desc:"bitwise/logical NOT"),
        SystemFunction(lib:"core",          name:"or",                  call:Core_or,                   req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical OR"),
        SystemFunction(lib:"core",          name:"panic",               call:Core_panic,                req: @[@[SV]],                                                                      ret: @[SV],             desc:"exit program printing given error message"),
        SystemFunction(lib:"core",          name:"print",               call:Core_print,                req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen"),
        SystemFunction(lib:"core",          name:"range",               call:Core_range,                req: @[@[IV,IV]],                                                                   ret: @[AV],             desc:"get array from given range (from..to) with optional step"),
        SystemFunction(lib:"core",          name:"return",              call:Core_return,               req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV]],                                 ret: @[ANY],            desc:"break execution and return given value"),
        SystemFunction(lib:"core",          name:"xor",                 call:Core_xor,                  req: @[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical XOR"),

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
        SystemFunction(lib:"generic",       name:"reverse",             call:Generic_reverse,           req: @[@[AV],@[SV]],                                                                ret: @[AV,SV],          desc:"reverse given array or string"),
        SystemFunction(lib:"generic",       name:"reverse!",            call:Generic_reverseI,          req: @[@[AV],@[SV]],                                                                ret: @[AV,SV],          desc:"reverse given array or string (in-place)"),
        SystemFunction(lib:"generic",       name:"size",                call:Generic_size,              req: @[@[AV],@[SV],@[DV]],                                                          ret: @[IV],             desc:"get size of given collection or string"),
        SystemFunction(lib:"generic",       name:"slice",               call:Generic_slice,             req: @[@[AV,IV],@[AV,IV,IV],@[SV,IV],@[SV,IV,IV]],                                  ret: @[AV,SV],          desc:"get slice of array/string given a starting and/or end point"),

        SystemFunction(lib:"array",         name:"all",                 call:Array_all,                 req: @[@[AV],@[AV,FV]],                                                             ret: @[BV],             desc:"check if all elements of array are true or pass the condition of given function"),
        SystemFunction(lib:"array",         name:"any",                 call:Array_any,                 req: @[@[AV],@[AV,FV]],                                                             ret: @[BV],             desc:"check if any elements of array are true or pass the condition of given function"),
        SystemFunction(lib:"array",         name:"filter",              call:Array_filter,              req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after filtering each element using given function"),
        SystemFunction(lib:"array",         name:"filter!",             call:Array_filterI,             req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after filtering each element using given function (in-place)"),
        SystemFunction(lib:"array",         name:"first",               call:Array_first,               req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get first element of given array"),
        SystemFunction(lib:"array",         name:"last",                call:Array_last,                req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array"),
        SystemFunction(lib:"array",         name:"map",                 call:Array_map,                 req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after executing given function for each element"),
        SystemFunction(lib:"array",         name:"map!",                call:Array_mapI,                req: @[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after executing given function for each element (in-place)"),
        SystemFunction(lib:"array",         name:"pop",                 call:Array_pop,                 req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array (same as 'last')"),
        SystemFunction(lib:"array",         name:"pop!",                call:Array_popI,                req: @[@[AV]],                                                                      ret: @[ANY],            desc:"get last element of given array and delete it (in-place)"),
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

        SystemFunction(lib:"dictionary",    name:"hasKey",              call:Dictionary_hasKey,         req: @[@[DV,SV]],                                                                   ret: @[BV],             desc:"check if dictionary contains key"),
        SystemFunction(lib:"dictionary",    name:"keys",                call:Dictionary_keys,           req: @[@[DV]],                                                                      ret: @[AV],             desc:"get array of dictionary keys"),
        SystemFunction(lib:"dictionary",    name:"values",              call:Dictionary_values,         req: @[@[DV]],                                                                      ret: @[AV],             desc:"get array of dictionary values"),     

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
        SystemFunction(lib:"reflection",    name:"type",                call:Reflection_type,           req: @[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"get type of given object as a string")
    ]

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

proc addContext() {.inline.} =
    Stack.add(Context(list: @[]))

proc addContextWith(key:string, val:Value) {.inline.} =
    Stack[^1] = Context(list: @[(key,val)])

proc addContextWith(pairs:seq[(string,Value)]) {.inline.} =
    Stack[^1] = Context(list:pairs)

proc popContext() {.inline.} =
    discard Stack.pop()

proc updateOrSet(ctx: var Context, k: string, v: Value) {.inline.} = 
    var i = 0
    while i<ctx.list.len:
        if ctx.list[i][0]==k: 
            ctx.list[i][1] = v
            return
        inc(i)

    # not updated, so let's assign it
    ctx.list.add((k,v))

proc keys*(ctx: Context): seq[string] {.inline.} =
    result = ctx.list.map((x) => x[0])

proc values*(ctx: Context): seq[Value] {.inline.} =
    result = ctx.list.map((x) => x[1])

proc hasKey*(ctx: Context, key: string): bool {.inline.} = 
    var i = 0
    while i<ctx.list.len:
        if ctx.list[i][0]==key: return true 
        inc(i)
    return false

proc getValueForKey*(ctx: Context, key: string): Value {.inline.} =
    var i = 0
    while i<ctx.list.len:
        if ctx.list[i][0]==key: return ctx.list[i][1] 
        inc(i)
    return nil

proc getSymbol(k: string): Value {.inline.} = 
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

proc inspectStack() =
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
    Methods
  ======================================================]#

#[----------------------------------------
    Value
  ----------------------------------------]#

proc INT(v: string): Value {.inline.} =
    var intValue: int
    try: 
        discard parseInt(v, intValue)
        result = INT(intValue)
    except: 
        result = BIGINT(v)

proc BIGINT*(v: string): Value {.inline.} =
    Value(kind: bigIntegerValue, bi: newInt(v))

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
        of stringValue: STR(v.s)
        of integerValue: INT(v.i)
        of realValue: REAL(v.r)
        of arrayValue: ARR(v.a.map((x) => valueCopy(x)))
        of dictionaryValue: DICT(Context(list:v.d.list.map((x) => (x[0],valueCopy(x[1])))))
        else: v

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

proc `+`(l: Value, r: Value): Value {.inline.} =
    {.computedGoto.}
    case l.kind
        of stringValue:
            result = case r.kind
                of stringValue: STR(l.s & r.s)
                of integerValue: STR(l.s & $(r.i))
                of bigIntegerValue: STR(l.s & $(r.bi))
                of realValue: STR(l.s & $(r.r))
                else: STR(l.s & r.stringify())
        of integerValue:
            result = case r.kind
                of stringValue: STR($(l.i) & r.s)
                of integerValue: 
                    try: INT(l.i + r.i)
                    except Exception as e: BIGINT(newInt(l.i)+r.i)
                of bigIntegerValue: BIGINT(l.i+r.bi)
                of realValue: REAL(float(l.i)+r.r)
                else: InvalidOperationError("+",$(l.kind),$(r.kind))
        of bigIntegerValue:
            result = case r.kind
                of integerValue: BIGINT(l.bi + r.i)
                of bigIntegerValue: BIGINT(l.bi+r.bi)
                else: InvalidOperationError("+",$(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of stringValue: STR($(l.r) & r.s)
                of integerValue: REAL(l.r + float(r.i))
                of realValue: REAL(l.r+r.r)
                else: InvalidOperationError("+",$(l.kind),$(r.kind))
        of arrayValue:
            if r.kind!=arrayValue:
                result = ARR(l.a & r)
            else: 
                result = ARR(l.a & r.a)
        of dictionaryValue:
            if r.kind==dictionaryValue:
                result = valueCopy(l)
                for k in r.d.keys:
                    result.d.updateOrSet(k,r.d.getValueForKey(k))

            else: InvalidOperationError("+",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("+",$(l.kind),$(r.kind))

proc `-`(l: Value, r: Value): Value {.inline.} =
    {.computedGoto.}
    case l.kind
        of stringValue:
            result = case r.kind
                of stringValue: STR(l.s.replace(r.s,""))
                of integerValue: STR(l.s.replace($(r.i),""))
                of bigIntegerValue: STR(l.s.replace($(r.bi),""))
                of realValue: STR(l.s.replace($(r.r),""))
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of integerValue:
            result = case r.kind
                of integerValue: INT(l.i - r.i)
                of bigIntegerValue: BIGINT(l.i - r.bi)
                of realValue: REAL(float(l.i)-r.r)
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of bigIntegerValue:
            result = case r.kind
                of integerValue: BIGINT(l.bi - r.i)
                of bigIntegerValue: BIGINT(l.bi - r.bi)
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of integerValue: REAL(l.r - float(r.i))
                of realValue: REAL(l.r-r.r)
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of arrayValue:
            result = valueCopy(l)
            if r.kind!=arrayValue:
                result.a.delete(l.findValueInArray(r))
            else:
                for item in r.a:
                    result.a.delete(result.findValueInArray(item))

        of dictionaryValue:
            result = valueCopy(l)
            var i = 0
            while i < l.d.list.len:
                if l.d.list[i][1].eq(r):
                    result.d.list.del(i)
                inc(i)

        else:
            InvalidOperationError("-",$(l.kind),$(r.kind))

proc `*`(l: Value, r: Value): Value {.inline.} = 
    {.computedGoto.}
    case l.kind
        of stringValue:
            result = case r.kind
                of integerValue: STR(l.s.repeat(r.i))
                of realValue: STR(l.s.repeat(int(r.r)))
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of integerValue:
            result = case r.kind
                of stringValue: STR(r.s.repeat(l.i))
                of integerValue: 
                    try: INT(l.i * r.i)
                    except Exception as e: BIGINT(newInt(l.i)*r.i)
                of bigIntegerValue: BIGINT(l.i * r.bi)
                of realValue: REAL(float(l.i)*r.r)
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of bigIntegerValue:
            result = case r.kind
                of integerValue: BIGINT(l.bi * r.i)
                of bigIntegerValue: BIGINT(l.bi * r.bi)
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of stringValue: STR(r.s.repeat(int(l.r)))
                of integerValue: REAL(l.r * float(r.i))
                of realValue: REAL(l.r*r.r)
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of arrayValue:
            result = ARR(@[])
            if r.kind==integerValue or r.kind==realValue:
                var limit:int
                if r.kind==integerValue: limit = r.i
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
    {.computedGoto.}
    case l.kind
        of stringValue:
            case r.kind
                of integerValue: 
                    var k=0
                    var resp=""
                    result = ARR(@[])
                    while k<l.s.len:
                        resp &= l.s[k]
                        if ((k+1) mod r.i)==0: 
                            result.a.add(STR(resp))
                            resp = ""
                        inc(k)
                
                of realValue: 
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
        of integerValue:
            result = case r.kind
                of integerValue: INT(l.i div r.i)
                of bigIntegerValue: BIGINT(l.i div r.bi)
                of realValue: REAL(float(l.i) / r.r)
                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of bigIntegerValue:
            result = case r.kind
                of integerValue: BIGINT(l.bi div r.i)
                of bigIntegerValue: BIGINT(l.bi div r.bi)
                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of integerValue: REAL(l.r / float(r.i))
                of realValue: REAL(l.r / r.r)
                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of arrayValue:
            result = ARR(@[])
            if r.kind==integerValue or r.kind==realValue:
                var limit:int
                if r.kind==integerValue: limit = r.i
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
    {.computedGoto.}
    case l.kind
        of stringValue:
            case r.kind
                of integerValue: 
                    let le = (l.s.len mod r.i)
                    result = STR(l.s[l.s.len-le..^1])
                
                of realValue: 
                    let le = (l.s.len mod int(r.r))
                    result = STR(l.s[l.s.len-le..^1])

                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of integerValue:
            result = case r.kind
                of integerValue: INT(l.i mod r.i)
                of bigIntegerValue: BIGINT(l.i mod r.bi)
                of realValue: INT(l.i mod int(r.r))
                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of bigIntegerValue:
            result = case r.kind
                of integerValue: BIGINT(l.bi mod r.i)
                of bigIntegerValue: BIGINT(l.bi mod r.bi)
                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of integerValue: INT(int(l.r) mod r.i)
                of realValue: INT(int(l.r) mod int(r.r))
                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of arrayValue:
            result = ARR(@[])
            if r.kind==integerValue or r.kind==realValue:
                var limit:int
                if r.kind==integerValue: limit = r.i
                else: limit = int(r.r)

                let le = (l.a.len mod limit)
                result = ARR(l.a[l.a.len-le..^1])
            else: InvalidOperationError("%",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("%",$(l.kind),$(r.kind))

proc `^`(l: Value, r: Value): Value {.inline.} =
    {.computedGoto.}
    case l.kind
        of integerValue:
            result = case r.kind
                of integerValue: INT(l.i ^ r.i)
                of realValue: INT(l.i ^ int(r.r))
                else: InvalidOperationError("^",$(l.kind),$(r.kind))
        of bigIntegerValue:
            result = case r.kind
                of integerValue: BIGINT(l.bi ^ culong(r.i))
                else: InvalidOperationError("^",$(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of integerValue: INT(int(l.r) ^ r.i)
                of realValue: REAL(pow(l.r,r.r))
                else: InvalidOperationError("^",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("^",$(l.kind),$(r.kind))

proc eq(l: Value, r: Value): bool {.inline.} =
    {.computedGoto.}
    case l.kind
        of stringValue:
            result = case r.kind
                of stringValue: l.s==r.s
                else: NotComparableError($(l.kind),$(r.kind))
                    
        of integerValue:
            result = case r.kind
                of integerValue: l.i==r.i
                of bigIntegerValue: l.i==r.bi
                of realValue: l.i==int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of integerValue: int(l.r)==r.i
                of bigIntegerValue: int(l.r)==r.bi
                of realValue: l.r==r.r
                else: NotComparableError($(l.kind),$(r.kind))
        of booleanValue:
            result = case r.kind
                of booleanValue: l==r
                else: NotComparableError($(l.kind),$(r.kind))

        of arrayValue:
            case r.kind
                of arrayValue:
                    if l.a.len!=r.a.len: result = false
                    else:
                        var i=0
                        while i<l.a.len:
                            if not (l.a[i].eq(r.a[i])): return false
                            inc(i)
                        result = true
                else: NotComparableError($(l.kind),$(r.kind))
        of dictionaryValue:
            case r.kind
                of dictionaryValue:
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
    {.computedGoto.}
    case l.kind
        of stringValue:
            result = case r.kind
                of stringValue: l.s<r.s
                else: NotComparableError($(l.kind),$(r.kind))
                    
        of integerValue:
            result = case r.kind
                of integerValue: l.i<r.i
                of bigIntegerValue: l.i<r.bi
                of realValue: l.i<int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of integerValue: int(l.r)<r.i
                of bigIntegerValue: int(l.r)<r.bi
                of realValue: l.r<r.r
                else: NotComparableError($(l.kind),$(r.kind))
        of arrayValue:
            result = case r.kind
                of arrayValue: l.a.len < r.a.len
                else: NotComparableError($(l.kind),$(r.kind))
        of dictionaryValue:
            result = case r.kind
                of dictionaryValue: l.d.keys.len < r.d.keys.len
                else: NotComparableError($(l.kind),$(r.kind))

        else: NotComparableError($(l.kind),$(r.kind))

proc gt(l: Value, r: Value): bool {.inline.} =
    {.computedGoto.}
    case l.kind
        of stringValue:
            result = case r.kind
                of stringValue: l.s>r.s
                else: NotComparableError($(l.kind),$(r.kind))
                    
        of integerValue:
            result = case r.kind
                of integerValue: l.i>r.i
                of bigIntegerValue: l.i>r.bi
                of realValue: l.i>int(r.r)
                else: NotComparableError($(l.kind),$(r.kind))
        of realValue:
            result = case r.kind
                of integerValue: int(l.r)>r.i
                of realValue: l.r>r.r
                else: NotComparableError($(l.kind),$(r.kind))
        of arrayValue:
            result = case r.kind
                of arrayValue: l.a.len > r.a.len
                else: NotComparableError($(l.kind),$(r.kind))
        of dictionaryValue:
            result = case r.kind
                of dictionaryValue: l.d.keys.len > r.d.keys.len
                else: NotComparableError($(l.kind),$(r.kind))

        else: NotComparableError($(l.kind),$(r.kind))

proc valueKindToPrintable(s: string): string = 
    s.replace("Value","").replace("ionary","").replace("tion","").replace("eger","").replace("ing","").replace("ean","")

proc stringify*(v: Value, quoted: bool = true): string =
    {.computedGoto.}
    case v.kind
        of stringValue          :   
            if quoted: result = escape(v.s)
            else: result = v.s
        of integerValue         :   result = $(v.i)
        of bigIntegerValue      :   result = $(v.bi)
        of realValue            :   result = $(v.r)
        of booleanValue         :   result = $(v.b)
        of arrayValue           :
            result = "#("

            let items = v.a.map((x) => x.stringify())

            result &= items.join(" ")
            result &= ")"
        of dictionaryValue      :
            result = "#{ "
            
            let items = sorted(v.d.keys).map((x) => x & ": " & v.d.getValueForKey(x).stringify())

            result &= items.join(", ")
            result &= " }"

            if result=="#{  }": result = "#{}"
        of functionValue        :   result = "<function>"
        of nullValue            :   result = "null"
        of anyValue             :   result = ""

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
        of stringValue          :   result = STR_COLOR & escape(v.s) & RESTORE_COLOR
        of integerValue         :   result = NUM_COLOR & $(v.i) & RESTORE_COLOR
        of bigIntegerValue      :   result = NUM_COLOR & $(v.bi) & RESTORE_COLOR
        of realValue            :   result = NUM_COLOR & $(v.r) & RESTORE_COLOR
        of booleanValue         :   result = NUM_COLOR & $(v.b) & RESTORE_COLOR
        of arrayValue           :
            result = "#(\n"

            if v.a.len==0: return "#()"
            let items = v.a.map((x) => repeat("\t",prepend) & repeat(" ",padding) & "\t" & x.inspect(prepend+1,isKeyVal) & "\n")

            result &= items.join("")
            result &= repeat("\t",prepend) & repeat(" ",padding) & ")"
        of dictionaryValue      :
            result = "#{\n"
            
            if v.d.keys.len==0: return "#{}"
            let items = sorted(v.d.keys).map((x) => repeat("\t",prepend) & repeat(" ",padding) & "\t" & KEY_COLOR & strutils.alignLeft(x,INSPECT_PADDING) & RESTORE_COLOR & "" & v.d.getValueForKey(x).inspect(prepend+1,true) & "\n")

            result &= items.join("")
            result &= repeat("\t",prepend) & repeat(" ",padding) & "}"
        of functionValue        :   result = "<function>"
        of nullValue            :   result = "null"
        of anyValue             :   result = ""

#[----------------------------------------
    Functions
  ----------------------------------------]#

proc newUserFunction(s: StatementList, a: seq[string]): Function =
    result = Function(id: "", args: a, body: s, hasContext: false, parentThis: nil, parentContext: nil)

proc setFunctionName(f: Function, s: string) {.inline.} =
    f.id = s
    f.hasContext = true

proc getSystemFunction*(n: string): int {.inline.} =
    var i = 0
    while i < SystemFunctions.len:
        if SystemFunctions[i].name==n:
            return i
        inc(i)

    result = -1

proc getSystemFunctionInstance*(n: string): SystemFunction {.inline.} =
    var i = 0
    while i < SystemFunctions.len:
        if SystemFunctions[i].name==n:
            return SystemFunctions[i]
        inc(i)

proc getNameOfSystemFunction*(n: int): cstring {.exportc.} =
    result = SystemFunctions[n].name

proc callFunction(f: string, v: seq[Value]): Value = 
    let fun = getSystemFunctionInstance(f)
    let exprs = newExpressionList()

    for val in v:
        discard addExpressionToExpressionList(expressionFromArgument(Argument(kind: literalArgument, v: val)),exprs)

    result = fun.call(fun,exprs)

proc execute(f: Function, v: Value): Value {.inline.} =
    if f.hasContext:
        if Stack.len == 1: addContext()

        var oldSeq:Context
        oldSeq = Stack[1]

        if f.args.len>0:
            if v.kind == AV: addContextWith(zip(f.args,v.a))
            else: addContextWith(f.args[0],v)
        else: addContextWith("&",v)

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
            else: stored = getAndSetSymbol("&",v)

        try                         : result = f.body.execute()
        except ReturnValue as ret   : raise
        finally                     : 
            if stored!=nil: discard setSymbol("&",stored)

proc validate(x: Expression, name: string, req: openArray[ValueKind]): Value {.inline.} =
    result = x.evaluate()

    if not (result.kind in req):
        let expected = req.map((x) => $(x)).join(" or ")
        IncorrectArgumentValuesError(name, expected, $(result.kind))

proc validate(xl: ExpressionList, name: string, req: seq[seq[ValueKind]]): seq[Value] {.inline.} =
    result = xl.list.map((x) => x.evaluate())

    if not req.contains(result.map((x) => x.kind)):

        let expected = req.map((x) => x.map((y) => ($y).valueKindToPrintable()).join(",")).join(" or ")
        let got = result.map((x) => ($(x.kind)).valueKindToPrintable()).join(",")

        IncorrectArgumentValuesError(name, expected, got)

proc getOneLineDescription*(f: SystemFunction): string =
    let args = 
        if f.req.len>0: f.req.map((x) => "(" & x.map(proc (y: ValueKind): string = ($y).valueKindToPrintable()).join(",") & ")").join(" / ")
        else: "()"

    let ret = "[" & f.ret.join(",").valueKindToPrintable() & "]"

    result = strutils.alignLeft("\e[1m" & f.name & "\e[0m",20) & " " & args & " \x1B[0;32m->\x1B[0;37m " & ret

proc getFullDescription*(f: SystemFunction): string =
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

proc expressionFromArgument(a: Argument): Expression {.exportc.} =
    result = Expression(kind: argumentExpression, a: a)

proc expressionFromRange(a: Argument, b: Argument): Expression {.exportc.} =
    var lst = newExpressionList()

    discard addExpressionToExpressionList(expressionFromArgument(a), lst)
    discard addExpressionToExpressionList(expressionFromArgument(b), lst)
    result = Expression(kind: argumentExpression, a: argumentFromInlineCallLiteral(statementFromCommand(static cint(getSystemFunction("range")),lst,0)))

proc expressionFromExpressions(l: Expression, op: cstring, r: Expression): Expression {.exportc.} =
    result = Expression(kind: normalExpression, left: l, op: parseEnum[ExpressionOperator]($op), right: r)

proc evaluate(x: Expression): Value {.inline.} =
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

proc newExpressionList: ExpressionList {.exportc.} =
    result = ExpressionList(list: @[])

proc newExpressionListWithExpression(x: Expression): ExpressionList {.exportc.} =
    result = ExpressionList(list: @[x])

proc copyExpressionList(xl: ExpressionList): ExpressionList {.exportc.} =
    ExpressionList(list: xl.list)

proc addExpressionToExpressionList(x: Expression, xl: ExpressionList): ExpressionList {.exportc.} =
    xl.list.add(x)
    result = xl

proc addExpressionToExpressionListFront(x: Expression, xl: ExpressionList): ExpressionList {.exportc.} =
    xl.list.insert(x,0)
    result = xl

proc evaluate(xl: ExpressionList, forceArray: bool=false): Value = 
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

proc expressionFromKeyPathPart(part: KeyPathPart, isFirst: bool = false): Expression =
    case part.kind
        of stringKeyPathPart:
            if isFirst: result = expressionFromArgument(argumentFromIdentifier(part.s))
            else: result = expressionFromArgument(argumentFromStringLiteral("\"" & part.s & "\""))
        of integerKeyPathPart:
            result = expressionFromArgument(argumentFromIntegerLiteral($(part.i)))
        of inlineKeyPathPart:
            result = expressionFromArgument(part.a)

proc argumentFromKeypath(k: KeyPath): Argument {.exportc.} =
    var exprA = expressionFromKeyPathPart(k.parts[0], true)

    var i = 1
    while i<k.parts.len:
        var exprB = expressionFromKeyPathPart(k.parts[i], false)
        var lst = newExpressionList()

        discard addExpressionToExpressionList(exprA, lst)
        discard addExpressionToExpressionList(exprB, lst)
        exprA = expressionFromArgument(argumentFromInlineCallLiteral(statementFromCommand(static cint(getSystemFunction("get")),lst,0)))

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

proc getValue(a: Argument): Value {.inline.} =
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

proc statementFromCommand(i: cint, xl: ExpressionList, l: cint): Statement {.exportc.} =
    result = Statement(kind: commandStatement, code: i, arguments: xl, pos: l)

proc statementFromAssignment(i: cstring, xl: ExpressionList, l: cint): Statement {.exportc.} =
    result = Statement(kind: assignmentStatement, symbol: $i, rValue: xl, pos: l)

proc statementFromExpression(x: Expression, l: cint=0): Statement {.exportc.} =
    result = Statement(kind: expressionStatement, expression: x, pos: l)

proc statementFromExpressions(i: cstring, xl: ExpressionList, l: cint=0): Statement {.exportc.} =
    result = Statement(kind: normalStatement, id: $i, expressions: xl, pos: l) 

proc execute(stm: Statement, parent: Value = nil): Value {.inline.} = 
    case stm.kind
        of assignmentStatement:
            result = stm.expressions.evaluate()
            if parent==nil:
                if result.kind==functionValue: setFunctionName(result.f,stm.id)   
                discard setSymbol(stm.id, result)
            else:
                parent.d.updateOrSet(stm.id, result)
                if result.kind==functionValue:
                    result.f.parentThis = result
                    result.f.parentContext = parent.d   
        of commandStatement:
            result = SystemFunctions[stm.code].call(SystemFunctions[stm.code],stm.expressions)
        of expressionStatement:
            result = stm.expression.evaluate()
        of normalStatement:
            let sym = getSymbol(stm.id)
            if sym==nil: SymbolNotFoundError(stm.id)
            else: 
                if sym.kind==FV:
                    result = sym.f.execute(stm.expressions.evaluate(forceArray=true))
                else: 
                    if stm.expressions.list.len > 0:
                        FunctionNotFoundError(stm.id)
                    else:
                        result = expressionFromArgument(argumentFromIdentifier(stm.id)).evaluate()
            

#[----------------------------------------
    StatementList
  ----------------------------------------]#

proc newStatementList: StatementList {.exportc.} =
    result = StatementList(list: @[])

proc newStatementListWithStatement(s: Statement): StatementList {.exportc.} =
    result = StatementList(list: @[s])

proc addStatementToStatementList(s: Statement, sl: StatementList): StatementList {.exportc.} =
    sl.list.add(s)
    result = sl

proc execute(sl: StatementList): Value = 
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
    Store management
  =====================================================]#

template initializeConsts() =
    ConstStrings    = newTable[string,Argument]()
    TRUE            = Value(kind: booleanValue, b: true)
    FALSE           = Value(kind: booleanValue, b: false)
    NULL            = Value(kind: nullValue)

#[######################################################
    MAIN ENTRY
  ======================================================]#

proc setup*(args: seq[string] = @[]) = 
    initializeConsts()
    Stack = newSeqOfCap[Context](2)
    addContext() # global
    addContextWith("&", ARR(args.map((x) => STR(x))))

proc runString*(src:string): string =
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
