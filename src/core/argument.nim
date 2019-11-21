#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/argument.nim
  *****************************************************************]#

#[----------------------------------------
    Argument Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc argumentFromIdentifier(i: cstring): Argument {.exportc.} =
    if ConstIds.hasKey(i):
        result = ConstIds[i]
    else:
        result = Argument(kind: identifierArgument, i: storeOrGetHash(i))
        ConstIds[i] = result

proc argumentFromCommandIdentifier(i: cint): Argument {.exportc.} =
    if ConstCmds.hasKey(i):
        result = ConstCmds[i]
    else:
        result = Argument(kind: identifierArgument, i: storeOrGetHash(SystemFunctions[i].name))
        ConstCmds[i] = result

proc argumentFromStringLiteral(l: cstring): Argument {.exportc.} =
    if ConstStrings.hasKey(l):
        result = ConstStrings[l]
    else:
        result = Argument(kind: literalArgument, v: STR(unescape($l).replace("\\n","\n")))
        ConstStrings[l] = result

proc argumentFromIntegerLiteral(l: cstring): Argument {.exportc.} =
    if ConstInts.hasKey(l):
        result = ConstInts[l]
    else:
        result = Argument(kind: literalArgument, v: SINT($l))
        ConstInts[l] = result

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

proc hash(a: Argument): Hash {.inline.} =
    case a.kind
        of identifierArgument:
            result = a.i
        of literalArgument:
            result = a.v.hash
        else: 
            discard

proc getValue(a: Argument): Value {.inline.} =
    ## Retrieve runtime Value of given Argument

    {.computedGoto.}
    case a.kind
        of identifierArgument:
            result = getSymbol(a.i)
            if result == 0: SymbolNotFoundError($(a.i))
        of literalArgument:
            result = a.v
        of arrayArgument:
            result = a.a.evaluate()
        of dictionaryArgument:
            var ret = DICT(newSeq[(int,Value)]())
            #var ret = DICT(cast[Context](@[]))

            addContext()
            for statement in a.d.list:
                discard statement.execute(ret)
            popContext()

            result = ret
        of functionArgument:
            result = FUNC(a.f)
        of inlineCallArgument:
            result = a.c.execute()
