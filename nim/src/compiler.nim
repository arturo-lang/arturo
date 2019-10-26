#[****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import algorithm, math, os, parseutils, sequtils, strutils, tables
import panic

import lib/core

type
    #[----------------------------------------
        Stack
      ----------------------------------------]#

    Context = Table[string,Value]

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
                parentThis: Value
                parentContext: Context
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
        nullValue, anyValue

    Object = ref object

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
                d: Context
            of functionValue:
                f: Function
            of objectValue:
                o: Object
            of nullValue: 
                discard
            of anyValue:
                discard

var
    MainProgram {.exportc.} : StatementList

    Stack                   : seq[Context]
    SystemFunctions         : Table[string,Function]

    # Const/literal arguments
    ConstStrings            : Table[string,Argument]
    ConstTrue               : Argument
    ConstFalse              : Argument
    ConstNull               : Argument

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

proc popContext() =
    discard Stack.pop()

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

proc valueFromDictionary(v: Context): Value = 
    result = Value(kind: dictionaryValue, d: v)

proc valueFromFunction(v: Function): Value =
    result = Value(kind: functionValue, f: v)

proc valueFromValue(v: Value): Value =
    case v.kind
        of stringValue: result = valueFromString(v.s)
        of integerValue: result = valueFromInteger(v.i)
        of realValue: result = valueFromReal(v.r)
        of arrayValue:
            result = valueFromArray(@[])
            for item in v.a:
                result.a.add(valueFromValue(item))
        of dictionaryValue:
            result = valueFromDictionary(initTable[string, Value]())
            for k,val in v.d.pairs:
                result.d[k] = valueFromValue(val)

        else: result = v

proc compare(l: Value, r: Value): int # Forward
proc findValueInArray(v: Value, lookup: Value): int =
    var index = 0
    for i in v.a:
        if compare(i,lookup)==0: return index
        inc(index)

proc stringify(v: Value, quoted: bool = true): string # Forward
proc `+`(l: Value, r: Value): Value =
    case l.kind
        of stringValue:
            case r.kind
                of stringValue: result = valueFromString(l.s & r.s)
                of integerValue: result = valueFromString(l.s & $(r.i))
                of realValue: result = valueFromString(l.s & $(r.r))
                else: result = valueFromString(l.s & r.stringify())
        of integerValue:
            case r.kind
                of stringValue: result = valueFromString($(l.i) & r.s)
                of integerValue: result = valueFromInteger(l.i + r.i)
                of realValue: result = valueFromReal(float(l.i)+r.r)
                else: runtimeError("cannot use `+` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of realValue:
            case r.kind
                of stringValue: result = valueFromString($(l.r) & r.s)
                of integerValue: result = valueFromReal(l.r + float(r.i))
                of realValue: result = valueFromReal(l.r+r.r)
                else: runtimeError("cannot use `+` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of arrayValue:
            result = valueFromValue(l)
            if r.kind!=arrayValue:
                result.a.add(r)
            else:
                for item in r.a:
                    result.a.add(item)
        of dictionaryValue:
            if r.kind==dictionaryValue:
                result = valueFromValue(l)
                for k,v in l.d.pairs:
                    result.d[k] = v

            else: runtimeError("cannot use `+` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        else:
            runtimeError("cannot use `+` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil

proc `-`(l: Value, r: Value): Value =
    case l.kind
        of stringValue:
            case r.kind
                of stringValue: result = valueFromString(l.s.replace(r.s,""))
                of integerValue: result = valueFromString(l.s.replace($(r.i),""))
                of realValue: result = valueFromString(l.s.replace($(r.r),""))
                else: runtimeError("cannot use `-` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i - r.i)
                of realValue: result = valueFromReal(float(l.i)-r.r)
                else: runtimeError("cannot use `-` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of realValue:
            case r.kind
                of integerValue: result = valueFromReal(l.r - float(r.i))
                of realValue: result = valueFromReal(l.r-r.r)
                else: runtimeError("cannot use `-` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of arrayValue:
            result = valueFromValue(l)
            if r.kind!=arrayValue:
                result.a.delete(l.findValueInArray(r))
            else:
                for item in r.a:
                    result.a.delete(result.findValueInArray(item))

        of dictionaryValue:
            result = valueFromValue(l)
            for k,v in l.d.pairs:
                if compare(v,r)==0:
                    result.d.del(k)

        else:
            runtimeError("cannot use `-` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil

proc `*`(l: Value, r: Value): Value = 
    case l.kind
        of stringValue:
            case r.kind
                of integerValue: result = valueFromString(l.s.repeat(r.i))
                of realValue: result = valueFromString(l.s.repeat(int(r.r)))
                else: runtimeError("cannot use `*` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of integerValue:
            case r.kind
                of stringValue: result = valueFromString(r.s.repeat(l.i))
                of integerValue: result = valueFromInteger(l.i * r.i)
                of realValue: result = valueFromReal(float(l.i)*r.r)
                else: runtimeError("cannot use `*` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of realValue:
            case r.kind
                of stringValue: result = valueFromString(r.s.repeat(int(l.r)))
                of integerValue: result = valueFromReal(l.r * float(r.i))
                of realValue: result = valueFromReal(l.r*r.r)
                else: runtimeError("cannot use `*` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of arrayValue:
            result = valueFromArray(@[])
            if r.kind==integerValue or r.kind==realValue:
                var limit:int
                if r.kind==integerValue: limit = r.i
                else: limit = int(r.r)

                var i = 0
                while i<limit:
                    for item in l.a:
                        result.a.add(valueFromValue(item))
                    inc(i)
            else: runtimeError("cannot use `*` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        else:
            runtimeError("cannot use `*` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil

proc `/`(l: Value, r: Value): Value = 
    case l.kind
        of stringValue:
            case r.kind
                of integerValue: 
                    var k=0
                    var resp=""
                    result = valueFromArray(@[])
                    while k<l.s.len:
                        resp &= l.s[k]
                        if ((k+1) mod r.i)==0: 
                            result.a.add(valueFromString(resp))
                            resp = ""
                        inc(k)
                
                of realValue: 
                    var k=0
                    var resp=""
                    result = valueFromArray(@[])
                    while k<l.s.len:
                        resp &= l.s[k]
                        if ((k+1) mod int(r.r))==0: 
                            result.a.add(valueFromString(resp))
                            resp = ""
                        inc(k)

                else: runtimeError("cannot use `/` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of integerValue:
            case r.kind
                of integerValue: result = valueFromReal(l.i / r.i)
                of realValue: result = valueFromReal(float(l.i) / r.r)
                else: runtimeError("cannot use `/` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of realValue:
            case r.kind
                of integerValue: result = valueFromReal(l.r / float(r.i))
                of realValue: result = valueFromReal(l.r / r.r)
                else: runtimeError("cannot use `/` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of arrayValue:
            result = valueFromArray(@[])
            if r.kind==integerValue or r.kind==realValue:
                var limit:int
                if r.kind==integerValue: limit = r.i
                else: limit = int(r.r)

                var k = 0
                var resp = valueFromArray(@[])
                while k<l.a.len:
                    resp.a.add(valueFromValue(l.a[k]))
                    if ((k+1) mod limit)==0: 
                        result.a.add(resp)
                        resp = valueFromArray(@[])
                    inc(k)

            else: runtimeError("cannot use `/` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        else:
            runtimeError("cannot use `/` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil

proc `%`(l: Value, r: Value): Value =
    case l.kind
        of stringValue:
            case r.kind
                of integerValue: 
                    let le = (l.s.len mod r.i)
                    result = valueFromString(l.s[l.s.len-le..^1])
                
                of realValue: 
                    let le = (l.s.len mod int(r.r))
                    result = valueFromString(l.s[l.s.len-le..^1])

                else: runtimeError("cannot use `%` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i mod r.i)
                of realValue: result = valueFromInteger(l.i mod int(r.r))
                else: runtimeError("cannot use `%` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of realValue:
            case r.kind
                of integerValue: result = valueFromInteger(int(l.r) mod r.i)
                of realValue: result = valueFromInteger(int(l.r) mod int(r.r))
                else: runtimeError("cannot use `%` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of arrayValue:
            result = valueFromArray(@[])
            if r.kind==integerValue or r.kind==realValue:
                var limit:int
                if r.kind==integerValue: limit = r.i
                else: limit = int(r.r)

                let le = (l.a.len mod limit)
                result = valueFromArray(l.a[l.a.len-le..^1])
            else: runtimeError("cannot use `%` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        else:
            runtimeError("cannot use `%` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil

proc `^`(l: Value, r: Value): Value =
    case l.kind
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i ^ r.i)
                of realValue: result = valueFromInteger(l.i ^ int(r.r))
                else: runtimeError("cannot use `^` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        of realValue:
            case r.kind
                of integerValue: result = valueFromInteger(int(l.r) ^ r.i)
                of realValue: result = valueFromReal(pow(l.r,r.r))
                else: runtimeError("cannot use `^` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil
        else:
            runtimeError("cannot use `^` for '" & $(l.kind) & "' and '" & $(r.kind) & "'"); result = nil

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
        of booleanValue:
            case r.kind
                of booleanValue:
                    if l==r: result = 0
                    else: result = -1
                else:
                    runtimeError("cannot compare '" & $(l.kind) & "' and '" & $(r.kind) & "'")
                    result = 0

        of arrayValue:
            case r.kind
                of arrayValue:
                    if l.a.len < r.a.len: result = -1
                    elif l.a.len > r.a.len: result = 1
                    else:
                        var i=0
                        while i<l.a.len:
                            if compare(l.a[i],r.a[i])!=0: return -2
                            inc(i)
                        result = 0
                else:
                    runtimeError("cannot compare '" & $(l.kind) & "' and '" & $(r.kind) & "'")
                    result = 0
        of dictionaryValue:
            case r.kind
                of dictionaryValue:
                    if toSeq(l.d.keys()).len < toSeq(r.d.keys()).len: result = -1
                    elif toSeq(l.d.keys()).len > toSeq(r.d.keys()).len: result = 1
                    else:
                        for k,v in l.d.pairs:
                            if not r.d.hasKey(k): return -2
                            else: 
                                if compare(l.d[k],r.d[k])!=0: return -2

                        result = 0
                else:
                    runtimeError("cannot compare '" & $(l.kind) & "' and '" & $(r.kind) & "'")
                    result = 0 

        else:
            echo "i don't know what to do"
            result = 0

proc stringify(v: Value, quoted: bool = true): string =
    case v.kind
        of stringValue      :   
            if quoted: result = escape(v.s)
            else: result = v.s
        of integerValue     :   result = $(v.i)
        of realValue        :   result = $(v.r)
        of booleanValue     :   result = $(v.b)
        of arrayValue       :
            result = "#("
            var items: seq[string] = @[]

            for item in v.a:
                items.add(item.stringify())

            result &= items.join(" ")
            result &= ")"
        of dictionaryValue  :
            result = "#{ "
            var items: seq[string] = @[]

            for item in sorted(toSeq(v.d.keys())):
                items.add(item & " " & v.d[item].stringify())

            result &= items.join(", ")
            result &= " }"

            if result=="#{  }": result = "#{}"
        of functionValue    :   result = "<function: 0x>"
        of nullValue        :   result = "null"
        of objectValue      :   result = "<object: 0x>"
        of anyValue         :   result = ""

#[----------------------------------------
    Functions
  ----------------------------------------]#

proc newUserFunction(s: StatementList, a: seq[string] = @[]): Function =
    result = Function(kind: userFunction, args: a, body: s, parentThis: nil, parentContext: initTable[string, Value]())

proc newSystemFunction(f: FunctionCall[Value,ExpressionList], c: seq[seq[ValueKind]], e: bool = true): Function =
    result = Function(kind: systemFunction, call: f, constraints: c, eval: e)

proc evaluate(xl: ExpressionList, forceArray: bool=false): Value # Forward
proc execute(sl: StatementList): Value # Forward
proc execute(f: Function, s: ExpressionList): Value =
    if f.kind==systemFunction:
        if f.eval:
            result = f.call(s.evaluate(),s)
        else:
            result = f.call(nil,s)
    else:
        addContext()
        var params = s.evaluate(forceArray=true)
        if f.args.len>0:
            if params.a.len!=f.args.len: runtimeError("wrong number of parameters for function")

            var ind=0
            for arg in f.args:
                discard setSymbol(arg,params.a[ind])
                inc(ind)
        
        discard setSymbol("&", params)
        result = f.body.execute()
        popContext()

#[----------------------------------------
    Identifier
  ----------------------------------------]#

proc identifierFromString(i: cstring): Identifier {.exportc.} =
    #echo "creating identifier: " & $i
    result = Identifier(kind: simpleIdentifier, i: $i)

proc identifierFromKeypath(k: Expression): Identifier {.exportc.} =
    #echo "creating identifier (k): "
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
    if ConstStrings.hasKey($l):
        result = ConstStrings[$l]
    else:
        result = Argument(kind: literalArgument, v: valueFromString(unescape($l).replace("\\n","\n")))
        ConstStrings[$l] = result

proc argumentFromIntegerLiteral(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromInteger($l))

proc argumentFromRealLiteral(l: cstring): Argument {.exportc.} =
    result = Argument(kind: literalArgument, v: valueFromReal($l))

proc argumentFromBooleanLiteral(l: cstring): Argument {.exportc.} =
    if l=="true": result = ConstTrue
    else: result = ConstFalse

proc argumentFromNullLiteral(): Argument {.exportc.} =
    result = ConstNull

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

proc execute(s: Statement, parent: Value = nil): Value # Forward
proc getValue(a: Argument): Value =
    case a.kind
        of identifierArgument:
            case a.i.kind
                of simpleIdentifier: result = getSymbol(a.i.i)
                of keypathIdentifier: result = a.i.k.evaluate()
        of literalArgument:
            result = a.v
        of arrayArgument:
            result = a.a.evaluate(forceArray=true)
        of dictionaryArgument:
            var ret  = valueFromDictionary(initTable[string, Value]())

            addContext()
            for statement in a.d.list:
                discard statement.execute(ret)
            popContext()

            result = ret
        of functionArgument:
            result = valueFromFunction(a.f)
        of inlineCallArgument:
            result = a.c.execute()

#[----------------------------------------
    Statement
  ----------------------------------------]#

proc statementFromExpression(x: Expression): Statement {.exportc.} =
    result = Statement(kind: expressionStatement, expression: x)

proc statementFromExpressions(i: Identifier, xl: ExpressionList): Statement {.exportc.} =
    #echo "creating statement"
    result = Statement(kind: normalStatement, id: i, expressions: xl)

proc setStatementPosition(s: Statement, f: cstring, l: int) {.exportc.} =
    s.pos = Position(file: $f, line: l)

proc executeAssign(s: Statement, parent: Value = nil): Value =
    var ev = s.expressions.evaluate()

    if parent==nil:
        result = setSymbol(s.id.i, ev)
    else:
        parent.d[s.id.i] = ev

        if ev.kind==functionValue:
            ev.f.parentThis = ev
            ev.f.parentContext = parent.d    

        result = ev    


proc execute(s: Statement, parent: Value = nil): Value = 

    case s.kind
        of expressionStatement:
            result = s.expression.evaluate()
        of normalStatement:
            if SystemFunctions.hasKey(s.id.i):
                result = SystemFunctions[s.id.i].execute(s.expressions)
            else:
                let sym = getSymbol(s.id.i)

                if sym==nil:
                    if s.expressions.list.len > 0:
                        result = s.executeAssign(parent)
                    else:
                        runtimeError("symbol not found: '" & s.id.i & "'")
                else:
                    if sym.kind==functionValue:
                        result = sym.f.execute(s.expressions)
                    else:
                        if s.expressions.list.len > 0:
                            result = s.executeAssign(parent)
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
    SystemFunctions["print"] = newSystemFunction(Core_Print,@[@[anyValue]])

#[######################################################
    Store management
  ======================================================]#

template initializeConsts() =
    ConstStrings = initTable[string,Argument]()
    ConstTrue = Argument(kind: literalArgument, v: valueFromBoolean(true))
    ConstFalse = Argument(kind: literalArgument, v: valueFromBoolean(false))
    ConstNull = Argument(kind: literalArgument, v: valueFromNull())

#[######################################################
    MAIN ENTRY
  ======================================================]#

proc runScript*(scriptPath:string, includePath:string="", warnings:bool=false) = 
    if not fileExists(scriptPath): 
        cmdlineError("path not found: '" & scriptPath & "'")

    yylineno = 0
    yyfilename = scriptPath

    let success = open(yyin, scriptPath)
    if not (success): 
        cmdlineError("something went wrong when opening file")

    initializeConsts()

    MainProgram = nil
    discard yyparse()

    #echo repr MainProgram

    if MainProgram!=nil:
        addContext()
        registerSystemFunctions()

        discard MainProgram.execute()
