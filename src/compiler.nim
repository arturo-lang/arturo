#[****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import algorithm, math, os, parseutils, sequtils, strutils, tables
import panic, utils

#[######################################################
    Type definitions
  ======================================================]#

type
    #[----------------------------------------
        Stack
      ----------------------------------------]#

    Context = seq[(string,Value)]

    #[----------------------------------------
        KeyPath
      ----------------------------------------]#

    KeyPathPartKind = enum
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
    
    ArgumentKind = enum
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

    ExpressionOperator = enum
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
        Position
      ----------------------------------------]#

    Position = object
        file    : string
        line    : int 

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
                expression      : Expression
            of normalStatement:
                id              : string
                expressions     : ExpressionList
                isAssignment    : bool

    #[----------------------------------------
        StatementList
      ----------------------------------------]#

    StatementList = ref object
        list    : seq[Statement]

    #[----------------------------------------
        Function
      ----------------------------------------]#

    FunctionKind = enum
        userFunction, systemFunction

    FunctionCall[F,X,V]     = proc(f:F, xl: X): V {.inline.}
    FunctionConstraints     = seq[seq[ValueKind]]
    FunctionReturns         = seq[ValueKind]

    Function = ref object
        case kind: FunctionKind:
            of userFunction:
                id              : string
                args            : seq[string]
                body            : StatementList
                hasContext      : bool
                parentThis      : Value
                parentContext   : Context
            of systemFunction:
                name            : string
                call            : FunctionCall[Function,ExpressionList,Value]
                require         : FunctionConstraints
                ret             : FunctionReturns
                description     : string
                minReq          : int
                maxReq          : int

    #[----------------------------------------
        Value
      ----------------------------------------]#

    ValueKind* = enum
        stringValue, integerValue, realValue, booleanValue,
        arrayValue, dictionaryValue, functionValue, objectValue,
        nullValue, anyValue

    Object = ref object

    Value* = ref object
        case kind*: ValueKind:
            of stringValue      : s: string
            of integerValue     : i: int
            of realValue        : r: float
            of booleanValue     : b: bool 
            of arrayValue       : a: seq[Value]
            of dictionaryValue  : d: Context
            of functionValue    : f: Function
            of objectValue      : o: Object
            of nullValue        : discard
            of anyValue         : discard

    #[----------------------------------------
        Returns
      ----------------------------------------]#

    ReturnValue* = object of Exception
        value: Value

#[######################################################
    Globals
  ======================================================]#

var
    MainProgram {.exportc.} : StatementList

    # Environment

    Stack*                  : seq[Context]

    SystemFunctions*        : TableRef[string,Function]

    CurrentPosition         : Position

    # Const/literal arguments

    ConstStrings            : TableRef[string,Argument]
    ConstTrue               : Argument
    ConstFalse              : Argument
    ConstNull               : Argument

#[######################################################
    Aliases
  ======================================================]#

template SV():ValueKind         = stringValue
template IV():ValueKind         = integerValue
template RV():ValueKind         = realValue
template BV():ValueKind         = booleanValue
template AV():ValueKind         = arrayValue
template DV():ValueKind         = dictionaryValue
template FV():ValueKind         = functionValue
template OV():ValueKind         = objectValue
template ANY():ValueKind        = anyValue

template S(_:int):string        = v[_].s
template I(_:int):int           = v[_].i
template R(_:int):float         = v[_].r
template B(_:int):bool          = v[_].b
template A(_:int):seq[Value]    = v[_].a
template D(_:int):Context       = v[_].d
template FN(_:int):Function     = v[_].f
template OB(_:int):Object       = v[_].o

template NULL():Value       = ConstNull.v
template TRUE():Value       = ConstTrue.v
template FALSE():Value      = ConstFalse.v

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
    Forward declarations
  ======================================================]#

proc compare(l: Value, r: Value): int {.inline.}
proc stringify*(v: Value, quoted: bool = true): string

proc evaluate(x: Expression): Value {.inline.}
proc evaluate(xl: ExpressionList, forceArray: bool=false): Value

proc statementFromExpressions(i: cstring, xl: ExpressionList): Statement {.exportc.}
proc execute(s: Statement, parent: Value = nil): Value {.inline.}
proc execute(sl: StatementList): Value

proc argumentFromInlineCallLiteral(l: Statement): Argument {.exportc.}
proc getValue(a: Argument): Value {.inline.}

#[######################################################
    Context management
  ======================================================]#

proc addContext() {.inline.} =
    Stack.add(@[])

proc addContextWith(key:string, val:Value) {.inline.} =
    Stack[^1] = @[(key,val)]

proc addContextWith(pairs:seq[(string,Value)]) {.inline.} =
    Stack[^1] = pairs

proc popContext() {.inline.} =
    discard Stack.pop()

proc updateOrSet(ctx: var Context, k: string, v: Value) {.inline.} = 
    var i = 0
    while i<ctx.len:
        if ctx[i][0]==k: 
            ctx[i][1] = v
            return
        inc(i)

    # not updated, so let's assign it
    ctx.add((k,v))

proc keys*(ctx: Context): seq[string] {.inline.} =
    result = ctx.map(proc (x:(string,Value)):string = x[0])

proc hasKey*(ctx: Context, key: string): bool {.inline.} = 
    var i = 0
    while i<ctx.len:
        if ctx[i][0]==key: return true 
        inc(i)
    return false

proc getValueForKey*(ctx: Context, key: string): Value {.inline.} =
    var i = 0
    while i<ctx.len:
        if ctx[i][0]==key: return ctx[i][1] 
        inc(i)
    return nil

proc getSymbol(k: string): Value {.inline.} = 
    var i = len(Stack) - 1
    while i > -1:
        var j = 0
        while j<Stack[i].len:
            if Stack[i][j][0]==k: 
                return Stack[i][j][1]
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
            while j<Stack[i].len:
                if Stack[i][j][0]==k: 
                    Stack[i][j][1]=v
                    return v
                inc(j)

            dec(i)

        Stack[^1].updateOrSet(k,v)
        result = v

proc storeSymbols(syms: openArray[(string,Value)]):seq[(string,Value)] =
    result = syms.map(proc (x: (string,Value)): (string,Value) = (x[0],getSymbol(x[0])))
    var i = 0
    while i < syms.len:
        if syms[i][1]!=NULL:
            discard setSymbol(syms[i][0],syms[i][1])
        inc(i)

proc restoreSymbols(syms: openArray[(string,Value)]) {.inline.} =
    var i = 0
    while i < syms.len:
        if syms[i][1]!=NULL: 
            discard setSymbol(syms[i][0],syms[i][1])
        inc(i)

proc inspectStack() =
    var i = 0
    for s in Stack:
        var tab = ""
        if i>0: tab = "\t"
        echo tab,"----------------"
        echo tab,"Stack[",i,"]"
        echo tab,"----------------"

        for t in s:
            echo tab,t[0]," -> ",t[1].stringify()

        inc(i)

#[######################################################
    Methods
  ======================================================]#

#[----------------------------------------
    Value
  ----------------------------------------]#

proc valueFromString(v: string): Value =
    result = Value(kind: stringValue, s: v)

proc valueFromInteger*(v: int): Value =
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
    {.computedGoto.}
    case v.kind
        of stringValue: result = valueFromString(v.s)
        of integerValue: result = valueFromInteger(v.i)
        of realValue: result = valueFromReal(v.r)
        of arrayValue: result = valueFromArray(v.a.map(proc (x: Value): Value = valueFromValue(x)))
        of dictionaryValue: result = valueFromDictionary(v.d.map(proc (x: (string,Value)): (string,Value) = (x[0],valueFromValue(x[1]))))
        else: result = v

proc findValueInArray(v: Value, lookup: Value): int =
    var i = 0
    while i < v.a.len:
        if compare(v.a[i],lookup)==0: return i 
        inc(i)
    return -1

proc `+`(l: Value, r: Value): Value {.inline.} =
    {.computedGoto.}
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
                else: InvalidOperationError("+",$(l.kind),$(r.kind))
        of realValue:
            case r.kind
                of stringValue: result = valueFromString($(l.r) & r.s)
                of integerValue: result = valueFromReal(l.r + float(r.i))
                of realValue: result = valueFromReal(l.r+r.r)
                else: InvalidOperationError("+",$(l.kind),$(r.kind))
        of arrayValue:
            if r.kind!=arrayValue:
                result = valueFromArray(l.a & r)
            else:
                result = valueFromArray(l.a & r.a)
        of dictionaryValue:
            if r.kind==dictionaryValue:
                result = valueFromValue(l)
                for k in r.d.keys:
                    result.d.updateOrSet(k,r.d.getValueForKey(k))

            else: InvalidOperationError("+",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("+",$(l.kind),$(r.kind))

proc `-`(l: Value, r: Value): Value {.inline.} =
    {.computedGoto.}
    case l.kind
        of stringValue:
            case r.kind
                of stringValue: result = valueFromString(l.s.replace(r.s,""))
                of integerValue: result = valueFromString(l.s.replace($(r.i),""))
                of realValue: result = valueFromString(l.s.replace($(r.r),""))
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i - r.i)
                of realValue: result = valueFromReal(float(l.i)-r.r)
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of realValue:
            case r.kind
                of integerValue: result = valueFromReal(l.r - float(r.i))
                of realValue: result = valueFromReal(l.r-r.r)
                else: InvalidOperationError("-",$(l.kind),$(r.kind))
        of arrayValue:
            result = valueFromValue(l)
            if r.kind!=arrayValue:
                result.a.delete(l.findValueInArray(r))
            else:
                for item in r.a:
                    result.a.delete(result.findValueInArray(item))

        of dictionaryValue:
            result = valueFromValue(l)
            var i = 0
            while i < l.d.len:
                if compare(l.d[i][1],r)==0:
                    result.d.del(i)
                inc(i)

        else:
            InvalidOperationError("-",$(l.kind),$(r.kind))

proc `*`(l: Value, r: Value): Value {.inline.} = 
    {.computedGoto.}
    case l.kind
        of stringValue:
            case r.kind
                of integerValue: result = valueFromString(l.s.repeat(r.i))
                of realValue: result = valueFromString(l.s.repeat(int(r.r)))
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of integerValue:
            case r.kind
                of stringValue: result = valueFromString(r.s.repeat(l.i))
                of integerValue: result = valueFromInteger(l.i * r.i)
                of realValue: result = valueFromReal(float(l.i)*r.r)
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
        of realValue:
            case r.kind
                of stringValue: result = valueFromString(r.s.repeat(int(l.r)))
                of integerValue: result = valueFromReal(l.r * float(r.i))
                of realValue: result = valueFromReal(l.r*r.r)
                else: InvalidOperationError("*",$(l.kind),$(r.kind))
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

                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of integerValue:
            case r.kind
                of integerValue: result = valueFromReal(l.i / r.i)
                of realValue: result = valueFromReal(float(l.i) / r.r)
                else: InvalidOperationError("/",$(l.kind),$(r.kind))
        of realValue:
            case r.kind
                of integerValue: result = valueFromReal(l.r / float(r.i))
                of realValue: result = valueFromReal(l.r / r.r)
                else: InvalidOperationError("/",$(l.kind),$(r.kind))
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
                    result = valueFromString(l.s[l.s.len-le..^1])
                
                of realValue: 
                    let le = (l.s.len mod int(r.r))
                    result = valueFromString(l.s[l.s.len-le..^1])

                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i mod r.i)
                of realValue: result = valueFromInteger(l.i mod int(r.r))
                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of realValue:
            case r.kind
                of integerValue: result = valueFromInteger(int(l.r) mod r.i)
                of realValue: result = valueFromInteger(int(l.r) mod int(r.r))
                else: InvalidOperationError("%",$(l.kind),$(r.kind))
        of arrayValue:
            result = valueFromArray(@[])
            if r.kind==integerValue or r.kind==realValue:
                var limit:int
                if r.kind==integerValue: limit = r.i
                else: limit = int(r.r)

                let le = (l.a.len mod limit)
                result = valueFromArray(l.a[l.a.len-le..^1])
            else: InvalidOperationError("%",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("%",$(l.kind),$(r.kind))

proc `^`(l: Value, r: Value): Value {.inline.} =
    {.computedGoto.}
    case l.kind
        of integerValue:
            case r.kind
                of integerValue: result = valueFromInteger(l.i ^ r.i)
                of realValue: result = valueFromInteger(l.i ^ int(r.r))
                else: InvalidOperationError("^",$(l.kind),$(r.kind))
        of realValue:
            case r.kind
                of integerValue: result = valueFromInteger(int(l.r) ^ r.i)
                of realValue: result = valueFromReal(pow(l.r,r.r))
                else: InvalidOperationError("^",$(l.kind),$(r.kind))
        else:
            InvalidOperationError("^",$(l.kind),$(r.kind))

proc compare(l: Value, r: Value): int {.inline.} =
    {.computedGoto.}
    case l.kind
        of stringValue:
            case r.kind
                of stringValue:
                    if l.s==r.s: result = 0
                    elif l.s<r.s: result = -1
                    else: result = 1
                else: NotComparableError($(l.kind),$(r.kind))
                    
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
                else: NotComparableError($(l.kind),$(r.kind))
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
                else: NotComparableError($(l.kind),$(r.kind))
        of booleanValue:
            case r.kind
                of booleanValue:
                    if l==r: result = 0
                    else: result = -1
                else: NotComparableError($(l.kind),$(r.kind))

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
                else: NotComparableError($(l.kind),$(r.kind))
        of dictionaryValue:
            case r.kind
                of dictionaryValue:
                    if l.d.keys.len < r.d.keys.len: result = -1
                    elif l.d.keys.len > r.d.keys.len: result = 1
                    else:
                        var i = 0
                        while i < l.d.len:
                            if not r.d.hasKey(l.d[i][0]): return -2
                            else:
                                if compare(l.d[i][1],r.d.getValueForKey(l.d[i][0]))!=0: return -2
                            inc(i)

                        result = 0
                else: NotComparableError($(l.kind),$(r.kind))

        else: NotComparableError($(l.kind),$(r.kind))

proc stringify*(v: Value, quoted: bool = true): string =
    {.computedGoto.}
    case v.kind
        of stringValue      :   
            if quoted: result = escape(v.s)
            else: result = v.s
        of integerValue     :   result = $(v.i)
        of realValue        :   result = $(v.r)
        of booleanValue     :   result = $(v.b)
        of arrayValue       :
            result = "#("

            let items = v.a.map(proc (x: Value):string = x.stringify())

            result &= items.join(" ")
            result &= ")"
        of dictionaryValue  :
            result = "#{ "
            
            let items = sorted(v.d.keys).map(proc (x: string):string = x & " " & v.d.getValueForKey(x).stringify())

            result &= items.join(", ")
            result &= " }"

            if result=="#{  }": result = "#{}"
        of functionValue    :   result = "<function>"
        of nullValue        :   result = "null"
        of objectValue      :   result = "<object>"
        of anyValue         :   result = ""

#[----------------------------------------
    Functions
  ----------------------------------------]#

proc newUserFunction(s: StatementList, a: seq[string]): Function =
    result = Function(kind: userFunction, id: "", args: a, body: s, hasContext: false, parentThis: nil, parentContext: @[])

proc setFunctionName(f: Function, s: string) {.inline.} =
    f.id = s
    f.hasContext = true

proc registerSystemFunction(n: string, f: FunctionCall[Function,ExpressionList,Value], req: FunctionConstraints = @[], ret: FunctionReturns, descr: string = "") =
    let minArgs = req.map(proc (x: seq[ValueKind]): int = x.len).min
    let maxArgs = req.map(proc (x: seq[ValueKind]): int = x.len).max

    SystemFunctions[n] = Function(kind: systemFunction, name: n, call: f, require: req, ret: ret, description: descr, minReq: minArgs, maxReq: maxArgs)

proc execute(f: Function, v: Value): Value {.inline.} =
    if f.hasContext:
        if Stack.len == 1: addContext()

        let oldSeq = Stack[1]
        if f.args.len>0:
            if v.kind == AV: addContextWith(zip(f.args,v.a))
            else: addContextWith(f.args[0],v)
        else: addContextWith("&",v)

        try                         : result = f.body.execute()
        except ReturnValue as ret   : result = ret.value
        finally                     : 
            Stack[1] = oldSeq
            if Stack[1].len==0: popContext()
    else:
        var stored: seq[(string,Value)]

        if f.args.len>0:
            if v.kind == AV: 
                stored = storeSymbols(zip(f.args,v.a))
            else: stored = storeSymbols(@[(f.args[0],v)])
        else: 
            stored = storeSymbols(@[("&",v)])

        try                         : result = f.body.execute()
        except ReturnValue as ret   : raise
        finally                     : restoreSymbols(stored)

proc execute(f: Function, xl: ExpressionList): Value =
    if f.kind==systemFunction:
        result = f.call(f,xl)
    else:
        var params = xl.evaluate(forceArray=true)

        result = f.execute(params)

proc validate(f: Function, xl: ExpressionList): seq[Value] =
    if xl.list.len < f.minReq or xl.list.len > f.maxReq:
        IncorrectArgumentNumberError(f.name)

    var ret = xl.evaluate(forceArray=true).a

    var i = 0
    while i<f.require.len:
        var passing = true
        var j = 0
        while j<f.require[i].len:
            if f.require[i][j]!=ANY and f.require[i][j]!=ret[j].kind: 
                passing = false
            inc(j)

        if passing: return ret
        inc(i)

    # not passed

    let expected = f.require.map(proc (x: seq[ValueKind]): string = x.map(proc (y: ValueKind): string = ($y).replace("Value","")).join(",")).join(" or ")
    let got = ret.map(proc (x: Value): string = ($(x.kind)).replace("Value","")).join(",")
    
    IncorrectArgumentValuesError(f.name, expected, got)

proc validateOne(f: Function, x: Expression, req: openArray[ValueKind]): Value =
    result = x.evaluate()

    if not (result.kind in req):
        let expected = req.map(proc (x: ValueKind): string = $(x)).join(" or ")
        IncorrectArgumentValuesError(f.name, expected, $(result.kind))

proc getOneLineDescription*(f: Function): string =
    let args = f.require.map(proc (x: seq[ValueKind]): string = "(" & x.map(proc (y: ValueKind): string = ($y).replace("Value","")).join(",") & ")").join(" / ")
    let ret = "[" & f.ret.join(",").replace("Value","") & "]"
    result = alignLeft("\e[1m" & f.name & "\e[0m",20) & " " & args & " -> " & ret

proc getFullDescription*(f: Function): string =
    let args = f.require.map(proc (x: seq[ValueKind]): string = "(" & x.map(proc (y: ValueKind): string = ($y).replace("Value","")).join(",") & ")").join(" / ")
    let ret = "[" & f.ret.join(",").replace("Value","") & "]"
    result  = "Function : \e[1m" & f.name & "\e[0m" & "\n"
    result &= "       # : " & f.description & "\n\n"
    result &= "   usage : " & f.name & " " & args & "\n"
    result &= "        -> " & ret & "\n"

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

proc addIdToKeypath(k: KeyPath, a: cstring) {.exportc.} =
    k.parts.add(KeyPathPart(kind: stringKeyPathPart, s: $a))

proc addIntegerToKeypath(k: KeyPath, a: cstring) {.exportc.} =
    var intValue: int
    discard parseInt($a, intValue)

    k.parts.add(KeyPathPart(kind: integerKeyPathPart, i: intValue))

proc addInlineToKeypath(k: KeyPath, a: Argument) {.exportc.} =
    k.parts.add(KeyPathPart(kind: inlineKeyPathPart, a: a))

#[----------------------------------------
    Expression
  ----------------------------------------]#

proc expressionFromArgument(a: Argument): Expression {.exportc.} =
    result = Expression(kind: argumentExpression, a: a)

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
            else: result = left
            {.computedGoto.}
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

proc newExpressionListWithExpression(x: Expression): ExpressionList {.exportc.} =
    result = ExpressionList(list: @[x])

proc copyExpressionList(xl: ExpressionList): ExpressionList {.exportc.} =
    result = ExpressionList(list: xl.list)

proc addExpressionToExpressionList(x: Expression, xl: ExpressionList): ExpressionList {.exportc.} =
    xl.list.add(x)
    result = xl

proc addExpressionToExpressionListFront(x: Expression, xl: ExpressionList): ExpressionList {.exportc.} =
    xl.list.insert(x,0)
    result = xl

proc evaluate(xl: ExpressionList, forceArray: bool=false): Value = 
    if forceArray or xl.list.len>1:
        result = valueFromArray(xl.list.map(proc (x: Expression): Value = x.evaluate()))
    else:
        if xl.list.len==1:
            result = xl.list[0].evaluate()
        else:
            result = valueFromArray(@[])

#[----------------------------------------
    Argument
  ----------------------------------------]#

proc argumentFromIdentifier(i: cstring): Argument {.exportc.} =
    result = Argument(kind: identifierArgument, i: $i)

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
        exprA = expressionFromArgument(argumentFromInlineCallLiteral(statementFromExpressions("get",lst)))

        inc(i)
        
    result = exprA.a

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
        result = Argument(kind: functionArgument, f: newUserFunction(l,@[]))
    else:
        result = Argument(kind: functionArgument, f: newUserFunction(l,($args).split(",")))

proc argumentFromInlineCallLiteral(l: Statement): Argument {.exportc.} =
    result = Argument(kind: inlineCallArgument, c: l)

proc getValue(a: Argument): Value {.inline.} =
    {.computedGoto.}
    case a.kind
        of identifierArgument:
            result = getSymbol(a.i)
            if result == nil: runtimeError("symbol not found: '" & a.i & "'", CurrentPosition.file, CurrentPosition.line)
        of literalArgument:
            result = a.v
        of arrayArgument:
            result = a.a.evaluate(forceArray=true)
        of dictionaryArgument:
            var ret = valueFromDictionary(@[])

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

proc statementFromExpressions(i: cstring, xl: ExpressionList): Statement {.exportc.} =
    var s = $i

    if s[^1]==':': s.removeSuffix(':'); result = Statement(kind: normalStatement, id: s, expressions: xl, isAssignment: true)
    else: result = Statement(kind: normalStatement, id: s, expressions: xl, isAssignment: false)

proc setStatementPosition(s: Statement, f: cstring, l: int) {.exportc.} =
    s.pos = Position(file: $f, line: l)

proc executeAssign(s: Statement, parent: Value = nil): Value {.inline.} =
    var ev = s.expressions.evaluate()

    if parent==nil:
        if ev.kind==functionValue:
            setFunctionName(ev.f,s.id)

        result = setSymbol(s.id, ev)
    else:
        parent.d.updateOrSet(s.id, ev)

        if ev.kind==functionValue:
            ev.f.parentThis = ev
            ev.f.parentContext = parent.d    

        result = ev    

proc execute(s: Statement, parent: Value = nil): Value {.inline.} = 
    CurrentPosition = s.pos

    case s.kind
        of expressionStatement:
            result = s.expression.evaluate()
        of normalStatement:
            if s.isAssignment:
                result = s.executeAssign(parent)
            else:
                if SystemFunctions.hasKey(s.id):
                    result = SystemFunctions[s.id].execute(s.expressions)
                else:
                    let sym = getSymbol(s.id)
                    if sym==nil: SymbolNotFoundError(s.id)
                    else: 
                        if s.expressions.list.len > 0: 
                            if sym.kind==FV: result = sym.f.execute(s.expressions)
                            else: 
                                result = expressionFromArgument(argumentFromArrayLiteral(addExpressionToExpressionListFront(expressionFromArgument(argumentFromIdentifier(s.id)),copyExpressionList(s.expressions)))).evaluate()
                        else: result = expressionFromArgument(argumentFromIdentifier(s.id)).evaluate()

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
    for s in sl.list:
        result = s.execute()

#[######################################################
    System library
  ======================================================]#

include lib/core
include lib/collections
include lib/numbers

template registerSystemFunctions() =
    SystemFunctions = newTable[string,Function]()
    #-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #                       Name            Proc                        Args                                                Return          Description
    #-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    registerSystemFunction("if",            Core_If,                    @[@[BV,FV],@[BV,FV,FV]],                            @[ANY],         "if condition is true, execute given function; else execute optional alternative function")
    registerSystemFunction("get",           Core_Get,                   @[@[AV,IV],@[DV,SV]],                               @[ANY],         "get element from collection using given index/key")
    registerSystemFunction("loop",          Core_Loop,                  @[@[AV,FV],@[DV,FV],@[BV,FV]],                      @[ANY],         "execute given function for each element in collection, or while condition is true")
    registerSystemFunction("print",         Core_Print,                 @[@[ANY]],                                          @[SV],          "print value of given expression to screen")
    registerSystemFunction("range",         Core_Range,                 @[@[IV,IV]],                                        @[AV],          "get array from given range (from..to) with optional step")
    registerSystemFunction("return",        Core_Return,                @[@[ANY]],                                          @[ANY],         "break execution and return given value")
    registerSystemFunction("syms",          Core_Syms,                  @[@[ANY]],                                          @[ANY],         "print symbol stack")

    registerSystemFunction("and",           Core_And,                   @[@[BV,BV],@[IV,IV]],                               @[BV,IV],       "bitwise/logical AND")
    registerSystemFunction("not",           Core_Not,                   @[@[BV],@[IV]],                                     @[BV,IV],       "bitwise/logical NOT")
    registerSystemFunction("or",            Core_Or,                    @[@[BV,BV],@[IV,IV]],                               @[BV,IV],       "bitwise/logical OR")
    registerSystemFunction("xor",           Core_Xor,                   @[@[BV,BV],@[IV,IV]],                               @[BV,IV],       "bitwise/logical XOR")

    registerSystemFunction("filter",        Collections_Filter,         @[@[AV,FV]],                                        @[AV],          "get array after filtering each element using given function")
    registerSystemFunction("shuffle",       Collections_Shuffle,        @[@[AV]],                                           @[AV],          "get given array shuffled")
    registerSystemFunction("size",          Collections_Size,           @[@[AV],@[SV],@[DV]],                               @[IV],          "get size of given collection or string")
    registerSystemFunction("slice",         Collections_Slice,          @[@[AV,IV],@[AV,IV,IV],@[SV,IV],@[SV,IV,IV]],       @[AV,SV],       "get slice of array/string given a starting and/or end point")
    registerSystemFunction("swap",          Collections_Swap,           @[@[AV,IV,IV]],                                     @[AV],          "swap array elements at given indices")

    registerSystemFunction("isPrime",       Numbers_IsPrime,            @[@[IV]],                                           @[BV],          "check if given number is prime")
    

#[######################################################
    Store management
  ======================================================]#

template initializeConsts() =
    ConstStrings    = newTable[string,Argument]()
    ConstTrue       = Argument(kind: literalArgument, v: valueFromBoolean(true))
    ConstFalse      = Argument(kind: literalArgument, v: valueFromBoolean(false))
    ConstNull       = Argument(kind: literalArgument, v: valueFromNull())

#[######################################################
    MAIN ENTRY
  ======================================================]#

proc setup*(args: seq[string] = @[]) = 
    initializeConsts()
    addContext() # global
    addContextWith("&", valueFromArray(args.map((proc (x: string): Value = valueFromString(x)))))
    registerSystemFunctions()

proc runString*(src:string): string =
    var buff = yy_scan_string(src)

    yy_switch_to_buffer(buff)

    MainProgram = nil
    discard yyparse()

    yy_delete_buffer(buff)

    result = MainProgram.execute().stringify()

proc runScript*(scriptPath:string, args: seq[string], includePath:string="", warnings:bool=false) = 
    if not fileExists(scriptPath): 
        cmdlineError("path not found: '" & scriptPath & "'")

    setup(args)

    yylineno = 0
    yyfilename = scriptPath

    let success = open(yyin, scriptPath)
    if not success:
        cmdlineError("something went wrong when opening file")
    else:
        #benchmark "parsing":
        discard yyparse()

        discard MainProgram.execute()
