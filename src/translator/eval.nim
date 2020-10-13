######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: translator/eval.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, strformat, strutils, tables

import vm/bytecode, vm/value
import utils

#=======================================
# Globals
#=======================================

var
    Funcs*{.threadvar.}: Table[string,int]
    Evaled*{.threadvar.}: Table[Value,Translation]

#=======================================
# Forward Declarations
#=======================================

proc dump*(evaled: Translation)

#=======================================
# Methods
#=======================================

proc evalOne(n: Value, consts: var ValueArray, it: var ByteArray, inBlock: bool = false) =
    var argStack: seq[int] = @[]
    var currentCommand: ByteArray = @[]
    #var itIndex = 0

    let childrenCount = n.a.len

    #------------------------
    # Helper Functions
    #------------------------

    proc debugCurrentCommand() =
        var i = 0

        while i < currentCommand.len:
            stdout.write fmt("{i}: ")
            var instr = (OpCode)(currentCommand[i])

            stdout.write ($instr).replace("op").toLowerAscii()

            case instr:
                of opPushX, opStoreX, opLoadX, opCallX, opAttr :
                    i += 1
                    let indx = currentCommand[i]
                    stdout.write fmt("\t#{indx}\n")
                else:
                    discard

            stdout.write "\n"
            i += 1

    template addToCommand(b: byte):untyped =
        currentCommand.add(b)

    proc addConst(consts: var seq[Value], v: Value, op: OpCode) =
        var indx = consts.find(v)
        if indx == -1:
            consts.add(v)
            indx = consts.len-1

        if indx <= 13:
            addToCommand((byte)(((byte)(op)-0xE) + (byte)(indx)))
        else:
            if indx>255:
                addToCommand((byte)indx)
                addToCommand((byte)indx shr 8)
                addToCommand((byte)(op)+1)
            else:
                addToCommand((byte)indx)
                addToCommand((byte)op)

    proc addAttr(consts: var seq[Value], v: Value) =
        var indx = consts.find(v)
        if indx == -1:
            consts.add(v)
            indx = consts.len-1

        addToCommand((byte)indx)
        addToCommand((byte)opAttr)

    template addTerminalValue(inArrowBlock: bool, code: untyped) =
        block:
            ## Check for potential Infix operator ahead
            if (i+1<childrenCount and n.a[i+1].kind == Symbol):
                when not inArrowBlock:
                    let step = 1
                else:
                    let step = 1

                case n.a[i+1].m:
                    of plus         : 
                        i += step; addCommand(opAdd, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])       # +
                    of minus        : 
                        i += step; addCommand(opSub, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])       # -   
                    of asterisk     : 
                        i += step; addCommand(opMul, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])       # *
                    of slash        : 
                        i += step; addCommand(opDiv, inArrowBlock);  
                        when inArrowBlock: ret.add(n.a[i])      # /
                    of doubleslash  : 
                        i += step; addCommand(opFDiv, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])      # //
                    of percent      : 
                        i += step; addCommand(opMod, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])       # %
                    of caret        : 
                        i += step; addCommand(opPow, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])       # ^
                    of equal        : 
                        i += step; addCommand(opEq, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])        # =
                    of lessgreater  : 
                        i += step; addCommand(opNe, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])        # <>
                    of greaterthan  : 
                        i += step; addCommand(opGt, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])        # >
                    of greaterequal : 
                        i += step; addCommand(opGe, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])        # >=
                    of lessthan     : 
                        i += step; addCommand(opLt, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])        # <
                    of equalless    : 
                        i += step; addCommand(opLe, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])        # =<
                    of ellipsis     : 
                        i += step; addCommand(opRange, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])     # ..
                    of backslash    : 
                        i += step; addCommand(opGet, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])    
                    of doubleplus   : 
                        i += step; addCommand(opAppend, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])    # ++
                    of doubleminus  : 
                        i += step; addCommand(opRemove, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])    # --
                    of colon        : 
                        i += step; addCommand(opLet, inArrowBlock); 
                        when inArrowBlock: ret.add(n.a[i])       # :
                    else            : discard

            ## Run main code
            code

            ## Check if command complete
            when not inArrowBlock:
                if argStack.len != 0: argStack[^1] -= 1

                while argStack.len != 0 and argStack[^1] == 0:
                    discard argStack.pop()
                    argStack[^1] -= 1

                # Check for a trailing pipe
                if not (i+1<childrenCount and n.a[i+1].kind == Symbol and n.a[i+1].m == pipe):
                    if argStack.len==0:
                        # The command is finished
                        
                        if inBlock: (for b in currentCommand: it.add(b))
                        else: (for b in currentCommand.reversed: it.add(b))
                        currentCommand = @[]
            else:
                if subargStack.len != 0: subargStack[^1] -= 1

                while subargStack.len != 0 and subargStack[^1] == 0:
                    discard subargStack.pop()
                    subargStack[^1] -= 1

                # Check for a trailing pipe
                if not (i+1<childrenCount and n.a[i+1].kind == Symbol and n.a[i+1].m == pipe):
                    if subargStack.len==0:
                        # The subcommand is finished
                        
                        ended = true

            ## Process trailing pipe            
            if (i+1<childrenCount and n.a[i+1].kind == Symbol and n.a[i+1].m == pipe):
                
                if (i+2<childrenCount and n.a[i+2].kind == Word):
                    if argStack.len != 0: argStack[^1] -= 1
                    var found = false
                    for indx,spec in OpSpecs:
                        if spec.name == n.a[i+2].s:
                            found = true
                            if (((currentCommand[0])>=(byte)(opStore0)) and ((currentCommand[0])<=(byte)(opStoreY))):
                                currentCommand.insert((byte)indx, 1)
                            else:
                                currentCommand.insert((byte)indx)
                            argStack.add(OpSpecs[indx].args-1)
                            break
                    i += 2
                else:
                    echo "found trailing pipe without adjunct command. exiting"
                    quit()

    template addCommand(op: OpCode, inArrowBlock: bool = false): untyped =
        when static OpSpecs[op].args!=0:
            when not inArrowBlock:
                addToCommand((byte)op)
                argStack.add(static OpSpecs[op].args)
            else:
                subargStack.add(static OpSpecs[op].args)
        else:
            when not inArrowBlock:
                addTerminalValue(false):
                    addToCommand((byte)op)
            else:
                addTerminalValue(true):
                    discard

    template addPartial(op: OpCode): untyped =
        ret.add(newSymbol(ampersand))
        swap(ret[^1],ret[^2])
        subargStack.add(static OpSpecs[op].args-1)

    template processNextCommand(): untyped =
        i += 1

        while i < n.a.len and not ended:
            let subnode = n.a[i]
            ret.add(subnode)

            case subnode.kind:
                of Null, 
                   Boolean: discard
                of Integer,
                   Floating,
                   Type,
                   Char,
                   String,
                   Literal,
                   Path,
                   Inline,
                   Block: 
                    addTerminalValue(true):
                        discard
                of Word:
                    var found = false
                    for indx,spec in OpSpecs:
                        if spec.name == subnode.s:
                            found = true
                            subargStack.add(OpSpecs[indx].args)
                            break

                    if not found:
                        if Funcs.hasKey(subnode.s):
                            if Funcs[subnode.s]!=0:
                                subargStack.add(Funcs[subnode.s])
                            else:
                                addTerminalValue(true):
                                    discard
                        else:
                            addTerminalValue(true):
                                discard

                of Symbol: 
                    case subnode.m:
                        of plus             : addPartial(opAdd)       # +
                        of minus            : addPartial(opSub)       # -   
                        of asterisk         : addPartial(opMul)
                        of slash            : addPartial(opDiv)       # /
                        of doubleslash      : addPartial(opFDiv)      # //
                        of percent          : addPartial(opMod)       # %
                        of caret            : addPartial(opPow)       # ^
                        of equal            : addPartial(opEq)        # =
                        of lessgreater      : addPartial(opNe)        # <>
                        of greaterthan      : addPartial(opGt)        # >
                        of greaterequal     : addPartial(opGe)        # >=
                        of lessthan         : addPartial(opLt)        # <
                        of equalless        : addPartial(opLe)        # =<
                        of ellipsis         : addPartial(opRange)     # ..
                        of backslash        : addPartial(opGet)
                        of doubleplus       : addPartial(opAppend)    # ++
                        of doubleminus      : addPartial(opRemove)    # --
                        of colon            : addPartial(opLet)       # :

                        of tilde            : 
                            subargStack.add(OpSpecs[opRender].args)#addCommand(opRender, inArrowBlock=true)
                        of at               : addCommand(opArray, inArrowBlock=true)
                        of sharp            : addCommand(opDictionary, inArrowBlock=true)
                        of dollar           : addCommand(opFunction, inArrowBlock=true) 
                        of doublearrowright : addCommand(opWrite, inArrowBlock=true)   
                        of doublearrowleft  : addCommand(opRead, inArrowBlock=true) 

                        else:
                            addTerminalValue(true):
                                discard
                else: discard

            
            i += 1

        i -= 1
        ret

    #------------------------
    # Main Eval Loop
    #------------------------

    var i = 0
    while i < n.a.len:
        let node = n.a[i]

        case node.kind:
            of Null: discard # cannot reach here - parse does not emit null values  
            of Boolean: discard # cannot reach here - parse does not emit boolean values

            of Integer:
                addTerminalValue(false):
                    if node.i<=10: addToCommand((byte)((byte)(opIPush0) + (byte)(node.i)))
                    else: addConst(consts, node, opPushX)

            of Floating:
                addTerminalValue(false):
                    if node.f==1.0: addToCommand((byte)opFPush1)
                    else: addConst(consts, node, opPushX)

            of Type:
                addTerminalValue(false):
                    addConst(consts, node, opPushX)

            of Char:
                addTerminalValue(false):
                    addConst(consts, node, opPushX)

            of String:
                addTerminalValue(false):
                    addConst(consts, node, opPushX)

            of Word:
                case node.s:
                    of "null"   : 
                        addTerminalValue(false):
                            addToCommand((byte)opNPush)

                    of "true"   :
                        addTerminalValue(false):
                            addToCommand((byte)opBPushT)

                    of "false"  :
                        addTerminalValue(false):
                            addToCommand((byte)opBPushF)

                    of "add"        : addCommand(opAdd)
                    of "sub"        : addCommand(opSub)
                    of "mul"        : addCommand(opMul)
                    of "div"        : addCommand(opDiv)
                    of "fdiv"       : addCommand(opFDiv)
                    of "mod"        : addCommand(opMod)
                    of "pow"        : addCommand(opPow)

                    of "neg"        : addCommand(opNeg)

                    of "not?"       : addCommand(opNot)
                    of "and?"       : addCommand(opAnd)
                    of "or?"        : addCommand(opOr)
                    of "xor?"       : addCommand(opXor)

                    of "shl"        : addCommand(opShl)
                    of "shr"        : addCommand(opShr)

                    of "pop"        : addCommand(opPop)
                    of "dup"        : addCommand(opDup)
                    of "swap"       : addCommand(opSwap)
                    of "nop"        : addCommand(opNop)

                    of "push"       : addCommand(opPush)

                    of "equal?"             : addCommand(opEq)
                    of "notEqual?"          : addCommand(opNe)
                    of "greater?"           : addCommand(opGt)
                    of "greaterOrEqual?"    : addCommand(opGe)
                    of "less?"              : addCommand(opLt)
                    of "lessOrEqual?"       : addCommand(opLe)

                    of "array"      : addCommand(opArray)
                    of "dictionary" : addCommand(opDictionary)
                    of "function"   : addCommand(opFunction)

                    of "print"      : addCommand(opPrint)
                    of "inspect"    : addCommand(opInspect)

                    of "if"         : addCommand(opIf)
                    of "if?"        : addCommand(opIfE)
                    of "else"       : addCommand(opElse)

                    of "loop"       : addCommand(opLoop)

                    of "do"         : addCommand(opDo)
                    of "map"        : addCommand(opMap)
                    of "select"     : addCommand(opSelect)
                    of "filter"     : addCommand(opFilter)

                    of "size"       : addCommand(opSize)

                    of "upper"      : addCommand(opUpper)
                    of "lower"      : addCommand(opLower)

                    of "get"        : addCommand(opGet)
                    of "set"        : addCommand(opSet)

                    of "to"         : addCommand(opTo)

                    of "even?"      : addCommand(opEven)
                    of "odd?"       : addCommand(opOdd)

                    of "range"      : addCommand(opRange)
                    of "sum"        : addCommand(opSum)
                    of "product"    : addCommand(opProduct)

                    of "exit"       : addCommand(opExit)

                    of "info"       : addCommand(opInfo)

                    of "type"       : addCommand(opType)
                    of "is?"        : addCommand(opIs)

                    of "not"        : addCommand(opBNot)
                    of "and"        : addCommand(opBAnd)
                    of "or"         : addCommand(opBOr)
                    of "xor"        : addCommand(opBXor)

                    of "first"      : addCommand(opFirst)
                    of "last"       : addCommand(opLast)

                    of "unique"     : addCommand(opUnique)
                    of "sort"       : addCommand(opSort)

                    of "inc"        : addCommand(opInc)
                    of "dec"        : addCommand(opDec)

                    of "set?"       : addCommand(opIsSet)

                    of "symbols"    : addCommand(opSymbols)
                    of "stack"      : addCommand(opStack)

                    of "case"       : addCommand(opCase)
                    of "when?"      : addCommand(opWhen)

                    of "capitalize" : addCommand(opCapitalize)

                    of "repeat"     : addCommand(opRepeat)
                    of "while"      : addCommand(opWhile)

                    of "random"     : addCommand(opRandom)

                    of "sample"     : addCommand(opSample)
                    of "shuffle"    : addCommand(opShuffle)
                    of "slice"      : addCommand(opSlice)

                    of "clear"      : addCommand(opClear)

                    of "all?"       : addCommand(opAll)
                    of "any?"       : addCommand(opAny)

                    of "read"       : addCommand(opRead)
                    of "write"      : addCommand(opWrite)

                    of "abs"        : addCommand(opAbs)
                    of "acos"       : addCommand(opAcos)
                    of "acosh"      : addCommand(opAcosh)
                    of "asin"       : addCommand(opAsin)
                    of "asinh"      : addCommand(opAsinh)
                    of "atan"       : addCommand(opAtan)
                    of "atanh"      : addCommand(opAtanh)
                    of "cos"        : addCommand(opCos)
                    of "cosh"       : addCommand(opCosh)
                    of "csec"       : addCommand(opCsec)
                    of "csech"      : addCommand(opCsech)
                    of "ctan"       : addCommand(opCtan)
                    of "ctanh"      : addCommand(opCtanh)
                    of "sec"        : addCommand(opSec)
                    of "sech"       : addCommand(opSech)
                    of "sin"        : addCommand(opSin)
                    of "sinh"       : addCommand(opSinh)
                    of "tan"        : addCommand(opTan)
                    of "tanh"       : addCommand(opTanh)

                    of "input"      : addCommand(opInput)

                    of "return"     : addCommand(opReturn)

                    of "pad"        : addCommand(opPad)
                    of "replace"    : addCommand(opReplace)
                    of "strip"      : addCommand(opStrip)
                    of "split"      : addCommand(opSplit)
                    of "prefix"     : addCommand(opPrefix)
                    of "prefix?"    : addCommand(opHasPrefix)
                    of "suffix"     : addCommand(opSuffix)
                    of "suffix?"    : addCommand(opHasSuffix)

                    of "exists?"    : addCommand(opExists)

                    of "try"        : addCommand(opTry)
                    of "try?"       : addCommand(opTryE)

                    of "upper?"     : addCommand(opIsUpper)
                    of "lower?"     : addCommand(opIsLower)

                    of "help"       : addCommand(opHelp)

                    of "empty"      : addCommand(opEmpty)
                    of "empty?"     : addCommand(opIsEmpty)

                    of "in"         : addCommand(opIn)
                    of "in?"        : addCommand(opIsIn)
                    of "index"      : addCommand(opIndex)
                    of "key?"       : addCommand(opHasKey)
                    of "reverse"    : addCommand(opReverse)

                    of "execute"    : addCommand(opExecute)

                    of "prints"     : addCommand(opPrints)

                    of "benchmark"  : addCommand(opBenchmark)

                    of "join"       : addCommand(opJoin)

                    of "max"        : addCommand(opMax)
                    of "min"        : addCommand(opMin)

                    of "keys"       : addCommand(opKeys)
                    of "values"     : addCommand(opValues)

                    of "hash"       : addCommand(opGetHash)

                    of "levenshtein": addCommand(opLevenshtein)

                    of "mail"       : addCommand(opMail)
                    of "download"   : addCommand(opDownload)

                    of "attr"       : addCommand(opGetAttr)
                    of "attr?"      : addCommand(opHasAttr)

                    of "render"     : addCommand(opRender)

                    of "encode"     : addCommand(opEncode)
                    of "decode"     : addCommand(opDecode)

                    of "color"      : addCommand(opColor)

                    of "take"       : addCommand(opTake)
                    of "drop"       : addCommand(opDrop)

                    of "append"     : addCommand(opAppend)
                    of "remove"     : addCommand(opRemove)

                    of "combine"    : addCommand(opCombine)

                    of "list"       : addCommand(opList)

                    of "fold"       : addCommand(opFold)
                    of "sqrt"       : addCommand(opSqrt)

                    of "serve"      : addCommand(opServe)

                    of "let"        : addCommand(opLet)
                    of "var"        : addCommand(opVar)

                    of "now"        : addCommand(opNow)

                    of "pause"      : addCommand(opPause)

                    of "call"       : addCommand(opCall)

                    of "new"        : addCommand(opNew)

                    of "attrs"      : addCommand(opGetAttrs)

                    of "until"      : addCommand(opUntil)

                    of "globalize"  : addCommand(opGlobalize)

                    of "relative"   : addCommand(opRelative)

                    of "average"    : addCommand(opAverage)
                    of "median"     : addCommand(opMedian)

                    of "as"         : addCommand(opAs)

                    of "gcd"        : addCommand(opGcd)
                    of "prime?"     : addCommand(opPrime)

                    of "permutate"  : addCommand(opPermutate)

                    of "whitespace?": addCommand(opIsWhitespace)
                    of "numeric?"   : addCommand(opIsNumeric)

                    of "factors"    : addCommand(opFactors)

                    of "match"      : addCommand(opMatch)

                    of "module"     : addCommand(opModule)

                    else:
                        if Funcs.hasKey(node.s):
                            if Funcs[node.s]!=0:
                                addConst(consts, node, opCallX)
                                argStack.add(Funcs[node.s])
                            else:
                                addTerminalValue(false):
                                    addConst(consts, node, opCallX)
                        else:
                            addTerminalValue(false):
                                addConst(consts, node, opLoadX)

            of Literal: 
                addTerminalValue(false):
                    addConst(consts, node, opPushX)

            of Label: 
                if (n.a[i+1].kind == Word and n.a[i+1].s == "function") or
                   (n.a[i+1].kind == Symbol and n.a[i+1].m == dollar):
                    let funcIndx = node.s
                    Funcs[funcIndx] = n.a[i+2].a.len

                addConst(consts, node, opStoreX)
                argStack.add(1)

            of Attr:
                addAttr(consts, node)
                addToCommand((byte)opBPushT)

            of AttrLabel:
                addAttr(consts, node)
                argStack[argStack.len-1] += 1

            of Path:
                addTerminalValue(false):
                    addToCommand((byte)opGet)

                    var i=1
                    while i<node.p.len-1:
                        addToCommand((byte)opGet)
                        i += 1
                    
                    let opName = "op" & node.p[0].s.capitalizeAscii()
                    try:
                        let op = parseEnum[OpCode](opName)
                        addToCommand((byte)op)
                    except:
                        addConst(consts, node.p[0], opLoadX)

                    i = 1
                    while i<node.p.len:
                        addConst(consts, node.p[i], opPushX)
                        i += 1

            of PathLabel:
                addToCommand((byte)opSet)
                    
                var i=1
                while i<node.p.len-1:
                    addToCommand((byte)opGet)
                    i += 1
                
                addConst(consts, node.p[0], opLoadX)
                i = 1
                while i<node.p.len:
                    addConst(consts, node.p[i], opPushX)
                    i += 1

                argStack.add(1)

            of Symbol: 
                case node.m:
                    of tilde            : addCommand(opRender)
                    of at               : addCommand(opArray)
                    of sharp            : addCommand(opDictionary)
                    of dollar           : addCommand(opFunction)
                    of doublearrowright : addCommand(opWrite)   
                    of doublearrowleft  : addCommand(opRead) 
                    of arrowright       : 
                        var subargStack: seq[int] = @[]
                        var ended = false
                        var ret: seq[Value] = @[]

                        let subblock = processNextCommand()
                        addTerminalValue(false):
                            addConst(consts, newBlock(subblock), opPushX)

                    of thickarrowright  : 
                        var subargStack: seq[int] = @[]
                        var ended = false
                        var ret: seq[Value] = @[]

                        var subblock = processNextCommand()

                        addTerminalValue(false):
                            addConst(consts, newBlock(@[newWord("_arg")]), opPushX)

                        var idx = 0
                        var ampFound = false
                        while idx < subblock.len:
                            if subblock[idx].kind==Symbol and subblock[idx].m==ampersand:
                                subblock[idx] = newWord("_arg")
                                ampFound = true
                                break
                            idx += 1

                        if not ampFound:
                            subblock.add(newWord("_arg"))

                        addTerminalValue(false):
                            addConst(consts, newBlock(subblock), opPushX)
                    else:
                        addTerminalValue(false):
                            addConst(consts, node, opPushX)

            of Date : discard

            of Binary : discard

            of Dictionary,
               Function: discard

            of Inline: 
                addTerminalValue(false):
                    evalOne(node, consts, currentCommand, inBlock=true)

            of Block:
                addTerminalValue(false):
                    addConst(consts, node, opPushX)

            of Any: discard

        i += 1

    if currentCommand!=[]:
        if inBlock: 
            for b in currentCommand: it.add(b)
        else:
            for b in currentCommand.reversed: it.add(b)

proc doEval*(root: Value): Translation = 
    if Evaled.hasKey(root):
        return Evaled[root]
    else:
        var cnsts: ValueArray = @[]
        var newit: ByteArray = @[]

        evalOne(root, cnsts, newit)
        newit.add((byte)opEnd)

        result = (cnsts, newit)

        when defined(VERBOSE):
            result.dump()

        result = (cnsts,newit)
        Evaled[root] = result

#=======================================
# Inspection
#=======================================

proc dump*(evaled: Translation) =
    showDebugHeader("Constants")

    var i = 0

    let consts = evaled[0]
    let it = evaled[1]

    while i < consts.len:
        var cnst = consts[i]

        stdout.write fmt("{i}: ")
        cnst.dump(0, false)

        i += 1
    
    showDebugHeader("Instruction Table")

    i = 0

    while i < it.len:
        stdout.write fmt("{i}: ")
        var instr = (OpCode)(it[i])

        stdout.write ($instr).replace("op").toLowerAscii()

        case instr:
            of opPushX, opStoreX, opLoadX, opCallX, opAttr :
                i += 1
                let indx = it[i]
                stdout.write fmt("\t#{indx}\n")
            else:
                discard

        stdout.write "\n"
        i += 1

#=======================================
# Initialization
#=======================================

when isMainModule:
    Funcs = initTable[string,int]()
    Evaled = initTable[Value,Translation]()
