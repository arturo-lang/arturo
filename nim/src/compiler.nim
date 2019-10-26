#[****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import math, os, parseutils, strutils, tables
import panic

import lib/core

type
    #[----------------------------------------
        Identifier
      ----------------------------------------]#

    IdentifierKind = enum
        simpleIdentifier, 
        keypathIdentifier

    Identifier = ref object
        case kind: IdentifierKind:
            of simpleIdentifier:
                i: string
            of keypathIdentifier:
                k: Expression
                
    #[----------------------------------------
        Argument
      ----------------------------------------]#
    
    ArgumentKind = enum
        identifierArgument, 
        literalArgument,
        arrayArgument,
        dictionaryArgument,
        functionArgument,
        inlineCallArgument

    Argument = ref object

        case kind: ArgumentKind:
            of identifierArgument:
                i: Identifier
            of literalArgument:
                v: Value
            of arrayArgument:
                a: ExpressionList
            of dictionaryArgument:
                d: StatementList
            of functionArgument:
                f: Function
            of inlineCallArgument:
                c: Statement


    #[----------------------------------------
        Expression
      ----------------------------------------]#

    ExpressionOperator = enum
        PLUS_SG, MINUS_SG, MULT_SG, DIV_SG, MOD_SG, POW_SG,
        EQ_OP, GE_OP, LE_OP, GT_OP, LT_OP, NE_OP

    ExpressionKind = enum
        argumentExpression, 
        normalExpression

    Expression = ref object
        case kind: ExpressionKind:
            of argumentExpression:
                a: Argument
            of normalExpression:
                left: Expression
                op: ExpressionOperator
                right: Expression

    #[----------------------------------------
        ExpressionList
      ----------------------------------------]#

    ExpressionList = ref object
        list: seq[Expression]

    #[----------------------------------------
        Position
      ----------------------------------------]#

    Position = object
        file: string
        line: int 

    #[----------------------------------------
        Statement
      ----------------------------------------]#

    StatementKind = enum
        expressionStatement,
        normalStatement

    Statement = ref object
        pos: Position
        case kind: StatementKind:
            of expressionStatement:
                expression: Expression
            of normalStatement:
                id: Identifier
                expressions: ExpressionList

    #[----------------------------------------
        StatementList
      ----------------------------------------]#

    StatementList = ref object
        list: seq[Statement]

    #[----------------------------------------
        Function
      ----------------------------------------]#

    FunctionKind = enum
        userFunction, systemFunction

    FunctionCall[V,X] = proc(v: V, x: X): V

    Function = ref object
        case kind: FunctionKind:
            of userFunction:
                args: seq[string]
                body: StatementList
            of systemFunction:
                call: FunctionCall[Value,ExpressionList]
                constraints: seq[seq[ValueKind]]
                eval: bool

    #[----------------------------------------
        Value
      ----------------------------------------]#

    ValueKind = enum
        stringValue, integerValue, realValue, booleanValue,
        arrayValue, dictionaryValue, functionValue, objectValue,
        nullValue

    Object = object

    Value = ref object
        case kind: ValueKind:
            of stringValue:
                s: string
            of integerValue:
                i: int
            of realValue:
                r: float
            of booleanValue:
                b: bool 
            of arrayValue:
                a: seq[Value]
            of dictionaryValue:
                d: Table[string,Value]
            of functionValue:
                f: Function
            of objectValue:
                o: Object
            of nullValue: 
                discard

var
    MainProgram {.exportc.} : StatementList
    Stack                   : seq[Table[string, Value]]
    SystemFunctions         : Table[string,Function]

#[######################################################
    Parser Interface
  ======================================================]#

proc yyparse(): cint {.importc.}
proc yy_scan_buffer(buff:cstring, s:csize) {.importc.}

var yyfilename {.importc.}: cstring
var yyin {.importc.}: File
var yylineno {.importc.}: cint

#[######################################################
    Stack management
  ======================================================]#

proc addContext() =
    Stack.add(initTable[string, Value]())

proc getSymbol(k: string): Value = 
    if Stack[^1].hasKey(k):
        return Stack[^1][k]
    else:
        return nil

proc setSymbol(k: string, v: Value): Value = 
    Stack[^1][k] = v
    result = v

#[######################################################
    Methods
  ======================================================]#

#[----------------------------------------
    Value
  ----------------------------------------]#

proc valueFromString(v: string): Value =
    result = Value(kind: stringValue, s: v)

proc valueFromInteger(v: int): Value =
    result = Value(kind: integerValue, i: v)

proc valueFromInteger(v: string): Value =
    var intValue: int
    discard parseInt(v, intValue)

    result = valueFromInteger(intValue)

proc valueFromReal(v: float): Value =
    result = Value(kind: realValue, r: v)

proc valueFromReal(v: string): Value =
    var floatValue: float
    discard parseFloat(v, floatValue)

    result = valueFromReal(floatValue)

proc valueFromBoolean(v: bool): Value =
    result = Value(kind: booleanValue, b: v)

proc valueFromBoolean(v: string): Value =
    if v=="true": result = valueFromBoolean(true)
    else: result = valueFromBoolean(false)

proc valueFromNull(): Value =
    result = Value(kind: nullValue)

proc valueFromArray(v: seq[Value]): Value =
    result = Value(kind: arrayValue, a: v)

proc `+`(l: Value, r: Value): Value =
    case l.kind
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i + r.i)
                of realValue: result = valueFromReal(float(l.i)+r.r)
                else: 
                    echo "i don't know what to do"
                    result = nil
        else:
            echo "i don't know what to do"
            result = nil

proc `-`(l: Value, r: Value): Value =
    case l.kind
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i - r.i)
                else:
                    echo "i don't know what to do"
                    result = nil
        else:
            echo "i don't know what to do"
            result = nil
    result = nil

proc `*`(l: Value, r: Value): Value = 
    case l.kind
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i * r.i)
                else:
                    echo "i don't know what to do"
                    result = nil
        else:
            echo "i don't know what to do"
            result = nil
    result = nil

proc `/`(l: Value, r: Value): Value = 
    case l.kind
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i div r.i)
                else:
                    echo "i don't know what to do"
                    result = nil
        else:
            echo "i don't know what to do"
            result = nil
    result = nil

proc `%`(l: Value, r: Value): Value =
    case l.kind
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i mod r.i)
                else:
                    echo "i don't know what to do"
                    result = nil
        else:
            echo "i don't know what to do"
            result = nil
    result = nil

proc `^`(l: Value, r: Value): Value =
    case l.kind
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i ^ r.i)
                else:
                    echo "i don't know what to do"
                    result = nil
        else:
            echo "i don't know what to do"
            result = nil
    result = nil

proc compare(l: Value, r: Value): int =
    case l.kind
        of stringValue:
            case r.kind
                of stringValue:
                    if l.s==r.s: result = 0
                    elif l.s<r.s: result = -1
                    else: result = 1
                else:
                    runtimeError("cannot compare '" & $(l.kind) & "' and '" & $(r.kind) & "'")
                    result = 0
        of integerValue:
            case r.kind
                of integerValue: 
                    if l.i==r.i: result = 0
                    elif l.i<r.i: result = -1
                    else: result = 1
                of realValue:
                    if l.i==int(r.r): result = 0
                    elif l.i<int(r.r): result = -1
                    else: result = 1
                else:
                    runtimeError("cannot compare '" & $(l.kind) & "' and '" & $(r.kind) & "'")
                    result = 0
        of realValue:
            case r.kind
                of integerValue:
                    if int(l.r)==r.i: result = 0
                    elif int(l.r)<r.i: result = -1
                    else: result = 1
                of realValue:
                    if l.r==r.r: result = 0
                    elif l.r<r.r: result = -1
                    else: result = 1
                else:
                    runtimeError("cannot compare '" & $(l.kind) & "' and '" & $(r.kind) & "'")
                    result = 0
        else:
            echo "i don't know what to do"
            result = 0

proc stringify(v: Value): string =
    case v.kind
        of stringValue      :   result = v.s
        of integerValue     :   result = $(v.i)
        of realValue        :   result = $(v.r)
        of booleanValue     :   result = $(v.b)
        else                :   result = "NOTHING"

#[----------------------------------------
    Functions
  ----------------------------------------]#

proc newUserFunction(s: StatementList, a: seq[string] = @[]): Function =
    result = Function(kind: userFunction, args: a, body: s)

proc newSystemFunction(f: FunctionCall[Value,ExpressionList], c: seq[seq[ValueKind]], e: bool = true): Function =
    result = Function(kind: systemFunction, call: f, constraints: c, eval: e)

proc evaluate(xl: ExpressionList, forceArray: bool=false): Value # Forward
proc execute(f: Function, s: ExpressionList): Value =
    if f.eval:
        result = f.call(s.evaluate(),s)
    else:
        result = f.call(nil,s)

#[----------------------------------------
    Identifier
  ----------------------------------------]#

proc identifierFromString(i: cstring): Identifier {.exportc.} =
    result = Identifier(kind: simpleIdentifier, i: $i)

proc identifierFromKeypath(k: Expression): Identifier {.exportc.} =
    result = Identifier(kind: keypathIdentifier, k: k)

#[----------------------------------------
    Expression
  ----------------------------------------]#

proc expressionFromArgument(a: Argument): Expression {.exportc.} =
    result = Expression(kind: argumentExpression, a: a)

proc expressionFromExpressions(l: Expression, op: cstring, r: Expression): Expression {.exportc.} =
    result = Expression(kind: normalExpression, left: l, op: parseEnum[ExpressionOperator]($op), right: r)

proc getValue(a: Argument): Value # Forward
proc evaluate(x: Expression): Value =
    case x.kind
        of argumentExpression:
            result = x.a.getValue()
        of normalExpression:
            var left = x.left.evaluate()
            var right: Value

            if x.right!=nil: right = x.right.evaluate()
            else: result = left

            case x.op
                of PLUS_SG  : result = left + right
                of MINUS_SG : result = left - right
                of MULT_SG  : result = left * right
                of DIV_SG   : result = left / right
                of MOD_SG   : result = left % right
                of POW_SG   : result = left ^ right
                of EQ_OP    : result = valueFromBoolean(compare(left,right)==0)
                of LT_OP    : result = valueFromBoolean(compare(left,right)==(-1))
                of GT_OP    : result = valueFromBoolean(compare(left,right)==1)
                of LE_OP    : result = valueFromBoolean(compare(left,right) in -1..0)
                of GE_OP    : result = valueFromBoolean(compare(left,right) in 0..1)
                of NE_OP    : result = valueFromBoolean(compare(left,right)!=0)

#[----------------------------------------
    ExpressionList
  ----------------------------------------]#

proc newExpressionList: ExpressionList {.exportc.} =
    result = ExpressionList(list: @[])

proc addExpressionToExpressionList(x: Expression, xl: ExpressionList) {.exportc.} =
    xl.list.add(x)

proc evaluate(xl: ExpressionList, forceArray: bool=false): Value = 
    if forceArray or xl.list.len>1:
        var ret: seq[Value] = @[]
        for x in xl.list:
            ret.add(x.evaluate())

        result = valueFromArray(ret)
    else:
        if xl.list.len==1:
            result = xl.list[0].evaluate()
        else:
            result = valueFromArray(@[])

#[----------------------------------------
    Argument
  ----------------------------------------]#

proc argumentFromIdentifier(i: Identifier): Argument {.exportc.} =
    result = Argument(kind: identifierArgument, i: i)

proc argumentFromStringLiteral(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromString($l))

proc argumentFromIntegerLiteral(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromInteger($l))

proc argumentFromRealLiteral(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromReal($l))

proc argumentFromBooleanLiteral(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromBoolean($l))

proc argumentFromNullLiteral(): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromNull())

proc argumentFromArrayLiteral(l: ExpressionList): Argument {.exportc.} =
    if l==nil:
        result = Argument(kind: arrayArgument, a: newExpressionList())
    else:
        result = Argument(kind: arrayArgument, a: l)

proc argumentFromDictionaryLiteral(l: StatementList): Argument {.exportc.} =
    result = Argument(kind: dictionaryArgument, d: l)

proc argumentFromFunctionLiteral(l: StatementList, args: cstring = ""): Argument {.exportc.} =
    if args=="":
        result = Argument(kind: functionArgument, f: newUserFunction(l))
    else:
        result = Argument(kind: functionArgument, f: newUserFunction(l,($args).split(",")))

proc argumentFromInlineCallLiteral(l: Statement): Argument {.exportc.} =
    result = Argument(kind: inlineCallArgument, c: l)

proc getValue(a: Argument): Value =
    case a.kind
        of identifierArgument:
            case a.i.kind
                of simpleIdentifier: result = getSymbol(a.i.i)
                of keypathIdentifier: result = a.i.k.evaluate()
        of literalArgument:
            result = a.v
        else:
            result = nil

#[----------------------------------------
    Statement
  ----------------------------------------]#

proc statementFromExpression(x: Expression): Statement {.exportc.} =
    result = Statement(kind: expressionStatement, expression: x)

proc statementFromExpressions(i: Identifier, xl: ExpressionList): Statement {.exportc.} =
    result = Statement(kind: normalStatement, id: i, expressions: xl)

proc setStatementPosition(s: Statement, f: cstring, l: int) {.exportc.} =
    s.pos = Position(file: $f, line: l)

proc execute(s: Statement): Value = 
    case s.kind
        of expressionStatement:
            result = s.expression.evaluate()
        of normalStatement:
            let sym = getSymbol(s.id.i)

            if sym==nil:
                if SystemFunctions.hasKey(s.id.i):
                    result = SystemFunctions[s.id.i].execute(s.expressions)
                else:
                    if s.expressions.list.len > 0:
                        result = setSymbol(s.id.i, s.expressions.evaluate())
                    else:
                        runtimeError("symbol not found: '" & s.id.i & "'")
            else:
                if sym.kind==functionValue:
                    echo "execute: " & s.id.i
                else:
                    if s.expressions.list.len > 0:
                        result = setSymbol(s.id.i, s.expressions.evaluate())
                    else:
                        result = expressionFromArgument(argumentFromIdentifier(s.id)).evaluate()


#[----------------------------------------
    StatementList
  ----------------------------------------]#

proc newStatementList: StatementList {.exportc.} =
    result = StatementList(list: @[])

proc addStatementToStatementList(s: Statement, sl: StatementList) {.exportc.} =
    sl.list.add(s)

proc execute(sl: StatementList): Value = 
    for s in sl.list:
        result = s.execute()

#[######################################################
    System library
  ======================================================]#

template registerSystemFunctions() =
    SystemFunctions["print"] = newSystemFunction(Core_Print,@[@[integerValue]])

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

    MainProgram = nil
    discard yyparse()

    echo repr MainProgram

    if MainProgram!=nil:
        addContext()
        registerSystemFunctions()

        discard MainProgram.execute()
