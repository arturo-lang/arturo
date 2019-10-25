#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import os, parseutils, strutils, tables
import panic

type
    #[----------------------------------------
        Identifier
      ----------------------------------------]#

    KeypathPartKind* = enum
        stringKeypathPart, 
        integerKeypathPart, 
        expressionKeypathPart

    KeypathPart* = object
        case kind*: KeypathPartKind:
            of stringKeypathPart:
                s*: string
            of integerKeypathPart:
                i*: int
            of expressionKeypathPart:
                x*: Expression

    IdentifierKind* = enum
        simpleIdentifier, 
        keypathIdentifier

    Identifier* = ref object
        case kind*: IdentifierKind:
            of simpleIdentifier:
                i*: string
            of keypathIdentifier:
                k*: seq[KeypathPart]
                
    #[----------------------------------------
        Argument
      ----------------------------------------]#
    
    ArgumentKind* = enum
        identifierArgument, 
        literalArgument

    Argument* = ref object

        case kind*: ArgumentKind:
            of identifierArgument:
                i*: Identifier
            of literalArgument:
                v*: Value

    #[----------------------------------------
        Expression
      ----------------------------------------]#

    ExpressionOperator* = enum
        PLUS_SG, MINUS_SG, MULT_SG, DIV_SG, MOD_SG, POW_SG,
        EQ_OP, GE_OP, LE_OP, GT_OP, LT_OP, NE_OP

    ExpressionKind* = enum
        argumentExpression, 
        normalExpression

    Expression* = ref object
        case kind*: ExpressionKind:
            of argumentExpression:
                a*: Argument
            of normalExpression:
                left*: Expression
                op*: ExpressionOperator
                right*: Expression

    #[----------------------------------------
        ExpressionList
      ----------------------------------------]#

    ExpressionList* = ref object
        list*: seq[Expression]

    #[----------------------------------------
        Value
      ----------------------------------------]#

    ValueKind* = enum
        stringValue, integerValue, realValue, booleanValue,
        arrayValue, dictionaryValue, functionValue, objectValue

    Function* = object

    Object* = object

    Value* = ref object
        case kind*: ValueKind:
            of stringValue:
                s*: string
            of integerValue:
                i*: int
            of realValue:
                r*: float
            of booleanValue:
                b*: bool 
            of arrayValue:
                a*: seq[Value]
            of dictionaryValue:
                d*: Table[string,Value]
            of functionValue:
                f*: Function
            of objectValue:
                o*: Object

#[######################################################
    Parser Interface
  ======================================================]#

proc yyparse(): cint {.importc.}
proc yy_scan_buffer(buff:cstring, s:csize) {.importc.}

var yyfilename {.importc.}: cstring
var yyin {.importc.}: File
var yylineno {.importc.}: cint

#[######################################################
    Methods
  ======================================================]#

#[----------------------------------------
    Value
  ----------------------------------------]#

proc valueFromString*(v: string): Value =
    result = Value(kind: stringValue, s: v)

proc valueFromInteger*(v: int): Value =
    result = Value(kind: integerValue, i: v)

proc valueFromInteger*(v: string): Value =
    var intValue: int
    discard parseInt(v, intValue)

    result = valueFromInteger(intValue)

proc valueFromReal*(v: float): Value =
    result = Value(kind: realValue, r: v)

proc valueFromReal*(v: string): Value =
    var floatValue: float
    discard parseFloat(v, floatValue)

    result = valueFromReal(floatValue)

proc valueFromBoolean*(v: bool): Value =
    result = Value(kind: booleanValue, b: v)

proc valueFromBoolean*(v: string): Value =
    if v=="true": result = valueFromBoolean(true)
    else: result = valueFromBoolean(false)

#[----------------------------------------
    Identifier
  ----------------------------------------]#

proc identifierFromString*(i: cstring): Identifier {.exportc.} =
    result = Identifier(kind: simpleIdentifier, i: $i)

#[----------------------------------------
    Expression
  ----------------------------------------]#

proc expressionFromArgument*(a: Argument): Expression {.exportc.} =
    result = Expression(kind: argumentExpression, a: a)

proc expressionFromExpressions*(l: Expression, op: cstring, r: Expression): Expression {.exportc.} =
    result = Expression(kind: normalExpression, left: l, op: parseEnum[ExpressionOperator]($op), right: r)

#[----------------------------------------
    Argument
  ----------------------------------------]#

proc argumentFromIdentifier*(i: Identifier): Argument {.exportc.} =
    result = Argument(kind: identifierArgument, i: i)

proc argumentFromStringLiteral*(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromString($l))

proc argumentFromIntegerLiteral*(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromInteger($l))

proc argumentFromRealLiteral*(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromReal($l))

proc argumentFromBooleanLiteral*(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromBoolean($l))

proc printArgument*(arg: Argument) {.exportc.} =
    echo repr arg

#[######################################################
    MAIN ENTRY
  ======================================================]#

proc runScript*(scriptPath:string, includePath:string, warnings:bool) = 
    if not fileExists(scriptPath): 
        cmdlineError("path not found: '" & scriptPath & "'")

    yylineno = 0
    yyfilename = scriptPath

    let success = open(yyin, scriptPath)
    if not (success): 
        cmdlineError("something went wrong when opening file")

    discard yyparse()
