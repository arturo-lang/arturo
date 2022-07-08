######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/eval.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, tables, unicode

when defined(VERBOSE):
    import sugar

when not defined(PORTABLE):
    import strformat, strutils
    import helpers/terminal as terminalHelper

import vm/[bytecode, globals, values/value]

#=======================================
# Variables
#=======================================

var
    TmpArities*    : Table[string,int]

#=======================================
# Forward Declarations
#=======================================

when defined(VERBOSE):
    proc dump*(evaled: Translation)

#=======================================
# Helpers
#=======================================

func indexOfValue*(a: seq[Value], item: Value): int {.inline.}=
    result = 0
    for i in items(a):
        if sameValue(item, i): return
        if item.kind in [Word, Label] and i.kind in [Word, Label] and item.s==i.s: return
        inc(result)
    result = -1

#=======================================
# Methods
#=======================================

when not defined(NOERRORLINES):
    template addEol(line: untyped):untyped =
        it.add((byte)opEol)
        it.add((byte)line shr 8)
        it.add((byte)line)

proc evalOne(n: Value, consts: var ValueArray, it: var ByteArray, inBlock: bool = false, isDictionary: bool = false) =
    var argStack: seq[int] = @[]
    var currentCommand: ByteArray = @[]

    let childrenCount = n.a.len

    #------------------------
    # Helper Functions
    #------------------------

    when defined(VERBOSE):
        proc debugCurrentCommand() =
            var i = 0

            while i < currentCommand.len:
                stdout.write fmt("{i}: ")
                var instr = (OpCode)(currentCommand[i])

                stdout.write ($instr).replace("op").toLowerAscii()

                case instr:
                    of opPush, opStore, opLoad, opCall, opAttr :
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
        var indx = consts.indexOfValue(v)
        if indx == -1:
            consts.add(v)
            indx = consts.len-1

        if indx <= 29:
            addToCommand((byte)(((byte)(op)-0x1E) + (byte)(indx)))
        else:
            if indx>255:
                addToCommand((byte)indx)
                addToCommand((byte)indx shr 8)
                addToCommand((byte)(op)+1)
            else:
                addToCommand((byte)indx)
                addToCommand((byte)op)

    template addToCommandHead(b: byte, at = 0):untyped =
        currentCommand.insert(b, at)

    proc addTrailingConst(consts: var seq[Value], v: Value, op: OpCode) =
        var atPos = 0
        if currentCommand[0] in opStore0.byte..opStoreX.byte:
            atPos = 1

        var indx = consts.indexOfValue(v)
        if indx == -1:
            consts.add(v)
            indx = consts.len-1

        if indx <= 29:
            addToCommandHead((byte)(((byte)(op)-0x1E) + (byte)(indx)), atPos)
        else:
            if indx>255:
                addToCommandHead((byte)indx, atPos)
                addToCommandHead((byte)indx shr 8, atPos)
                addToCommandHead((byte)(op)+1, atPos)
            else:
                addToCommandHead((byte)indx, atPos)
                addToCommandHead((byte)op, atPos)

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

                let symalias = n.a[i+1].m
                if Aliases.hasKey(symalias):
                    let symfunc = Syms[Aliases[symalias].name.s]

                    if symfunc.kind==Function and Aliases[symalias].precedence==InfixPrecedence:
                        i += step;
                        
                        when not inArrowBlock:
                            addConst(consts, Aliases[symalias].name, opCall)
                            if symfunc.fnKind == BuiltinFunction:
                                argStack.add(symfunc.arity)
                            else:
                                argStack.add(symfunc.params.a.len)
                        else:
                            if symfunc.fnKind == BuiltinFunction:
                                subargStack.add(symfunc.arity)
                            else:
                                argStack.add(symfunc.params.a.len)

                        when inArrowBlock: ret.add(n.a[i])
                
            ## Run main code
            code

            ## Check if command complete
            when not inArrowBlock:
                if argStack.len != 0: argStack[^1] -= 1

                while argStack.len != 0 and argStack[^1] == 0:
                    discard argStack.pop()
                    argStack[^1] -= 1

                if not (i+1<childrenCount and n.a[i+1].kind == Symbol and n.a[i+1].m == pipe):
                    if argStack.len==0:
                        # The command is finished
                        
                        if inBlock: (for b in currentCommand: it.add(b))
                        else: (for b in currentCommand.reversed: it.add(b))
                        currentCommand = @[]
                else:
                    # TODO(Eval\addTerminalValue) Verify pipe operators are working
                    # labels: vm,evaluator,enhancement,unit-test
                    
                    # There is a trailing pipe;
                    # let's inspect the following symbol

                    i += 1
                    if (i+1<childrenCount and n.a[i+1].kind == Word and Syms[n.a[i+1].s].kind == Function):
                        let funcName = n.a[i+1].s
                        if TmpArities.hasKey(funcName):
                            if TmpArities[funcName]>1:
                                argStack.add(TmpArities[funcName]-1)
                                addTrailingConst(consts, n.a[i+1], opCall)
                            else:
                                addTrailingConst(consts, n.a[i+1], opCall)
                                if argStack.len==0:
                                    if inBlock: (for b in currentCommand: it.add(b))
                                    else: (for b in currentCommand.reversed: it.add(b))
                                    currentCommand = @[]
                            i += 1
            else:
                if subargStack.len != 0: subargStack[^1] -= 1

                while subargStack.len != 0 and subargStack[^1] == 0:
                    discard subargStack.pop()
                    subargStack[^1] -= 1

                # TODO(Eval\addTerminalValue) pipes not working along with sub-blocks
                #  it's mainly when we might combine `->`/`=>` sugar with pipes 
                # labels: vm,evaluator,enhancement,bug

                # Check for a trailing pipe
                if not (i+1<childrenCount and n.a[i+1].kind == Symbol and n.a[i+1].m == pipe):
                    if subargStack.len==0:
                        # The subcommand is finished
                        
                        ended = true

    template processNextCommand(): untyped =
        i += 1

        while i < n.a.len and not ended:
            let subnode = n.a[i]
            ret.add(subnode)

            case subnode.kind:
                of Null, 
                   Logical: discard
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
                    if TmpArities.hasKey(subnode.s):
                        let funcArity = TmpArities[subnode.s]
                        if funcArity!=0:
                            subargStack.add(funcArity)
                        else:
                            addTerminalValue(true):
                                discard
                    else:
                        addTerminalValue(true):
                            discard

                of Symbol: 
                    let symalias = subnode.m
                    if Aliases.hasKey(symalias):
                        let symfunc = Syms[Aliases[symalias].name.s]
                        if symfunc.kind==Function:
                            if Aliases[symalias].precedence==PrefixPrecedence:
                                if symfunc.fnKind==BuiltinFunction and symfunc.arity!=0:
                                    subargStack.add(symfunc.arity)
                                elif symfunc.fnKind==UserFunction and symfunc.params.a.len!=0:
                                    subargStack.add(symfunc.params.a.len)
                                else:
                                    addTerminalValue(true):
                                        discard
                            else:
                                ret.add(newSymbol(ampersand))
                                swap(ret[^1],ret[^2])
                                subargStack.add(symfunc.arity-1)
                        else:
                            addTerminalValue(true):
                                discard
                    else:
                        addTerminalValue(true):
                            discard

                of AttributeLabel:
                    subargStack[subargStack.len-1] += 1

                else: discard

            
            i += 1

        i -= 1
        ret

    template processThickArrowRight(argblock: var seq[Value], subblock: var seq[Value]): untyped =
        while n.a[i+1].kind == Newline:
            when not defined(NOERRORLINES):
                addEol(n.a[i+1].line)
            i += 1

        # get next node
        let subnode = n.a[i+1]

        # we'll want to create the two blocks, 
        # for functions like loop, map, select, filter
        # so let's get them ready
        argblock = @[]
        subblock = @[subnode]

        var funcArity{.inject.}: int = 0

        # if it's a word
        if subnode.kind==Word:
            # check if it's a function
            if TmpArities.hasKey(subnode.s):
                    # automatically "push" all its required arguments
                funcArity = TmpArities[subnode.s]

                for i in 0..(funcArity-1):
                    let arg = newWord("_" & $(i))
                    argblock.add(arg)
                    subblock.add(arg)

        elif subnode.kind==Block:
            # replace ampersand symbols, 
            # sequentially, with arguments
            var idx = 0
            var fnd = 0
            while idx<subnode.a.len:
                if subnode.a[idx].kind==Symbol and subnode.a[idx].m==ampersand:
                    let arg = newWord("_" & $(fnd))
                    argblock.add(arg)
                    subnode.a[idx] = arg
                    fnd += 1
                idx += 1
            funcArity = fnd
            subblock = subnode.a 

    #------------------------
    # Main Eval Loop
    #------------------------

    var i = 0
    while i < n.a.len:
        let node = n.a[i]

        case node.kind:
            of Null:    addToCommand((byte)opConstN)
            of Logical: 
                    if node.b==True: addToCommand((byte)opConstBT)
                    elif node.b==False: addToCommand((byte)opConstBF)
                    else: addToCommand((byte)opConstBM)

            of Integer:
                addTerminalValue(false):
                    when defined(WEB) or not defined(NOGMP):
                        if node.iKind==NormalInteger:
                            if node.i>=0 and node.i<=10: addToCommand((byte)((byte)(opConstI0) + (byte)(node.i)))
                            else: addConst(consts, node, opPush)
                        else:
                            addConst(consts, node, opPush)
                    else:
                        if node.i>=0 and node.i<=10: addToCommand((byte)((byte)(opConstI0) + (byte)(node.i)))
                        else: addConst(consts, node, opPush)

            of Floating:
                addTerminalValue(false):
                    if node.f==1.0: addToCommand((byte)opConstF1)
                    else: addConst(consts, node, opPush)

            of Complex:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Rational:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Version:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Type:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Char:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of String:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Word:
                if TmpArities.hasKey(node.s):
                    let funcArity = TmpArities[node.s]
                    if funcArity!=0:
                        addConst(consts, node, opCall)
                        argStack.add(funcArity)
                    else:
                        addTerminalValue(false):
                            addConst(consts, node, opCall)
                else:
                    addTerminalValue(false):
                        addConst(consts, node, opLoad)

            of Literal: 
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Label: 
                let funcIndx = node.s
                var hasThickArrow = false
                var ab: seq[Value]
                var sb: seq[Value]
                if (n.a[i+1].kind == Word and n.a[i+1].s == "function") or
                   (n.a[i+1].kind == Symbol and n.a[i+1].m == dollar):
                    if n.a[i+2].kind == Symbol and n.a[i+2].m == thickarrowright:
                        i += 2
                        processThickArrowRight(ab,sb)
                        TmpArities[funcIndx] = funcArity
                        hasThickArrow = true
                        i += 1
                    else:
                        TmpArities[funcIndx] = n.a[i+2].a.countIt(it.kind != Type) #n.a[i+2].a.len
                else:
                    if not isDictionary:
                        TmpArities.del(funcIndx)

                addConst(consts, node, opStore)
                argStack.add(1)

                if hasThickArrow:
                    addConst(consts, newWord("function"), opCall)
                    argStack.add(2)

                    # add the blocks
                    addTerminalValue(false):
                        addConst(consts, newBlock(ab), opPush)
                    addTerminalValue(false):
                        addConst(consts, newBlock(sb), opPush) 

            of Attribute:
                addAttr(consts, node)
                addToCommand((byte)opConstBT)

            of AttributeLabel:
                addAttr(consts, node)
                argStack[argStack.len-1] += 1

            of Path:
                addTerminalValue(false):
                    addConst(consts, newWord("get"), opCall)

                    var i=1
                    while i<node.p.len-1:
                        addConst(consts, newWord("get"), opCall)
                        i += 1

                    let baseNode = node.p[0]

                    if TmpArities.hasKey(baseNode.s) and TmpArities[baseNode.s]==0:
                        addConst(consts, baseNode, opCall)
                    else:
                        addConst(consts, baseNode, opLoad)

                    i = 1
                    while i<node.p.len:
                        addConst(consts, node.p[i], opPush)
                        i += 1

            of PathLabel:
                addConst(consts, newWord("set"), opCall)
                    
                var i=1
                while i<node.p.len-1:
                    addConst(consts, newWord("get"), opCall)
                    i += 1
                
                addConst(consts, node.p[0], opLoad)
                i = 1
                while i<node.p.len:
                    addConst(consts, node.p[i], opPush)
                    i += 1

                argStack.add(1)

            of Symbol: 
                case node.m:
                    of doublecolon      :
                        inc(i)
                        var subblock: seq[Value] = @[]
                        while i < n.a.len:
                            let subnode = n.a[i]
                            subblock.add(subnode)
                            inc(i)
                        addTerminalValue(false):
                            addConst(consts, newBlock(subblock), opPush)
                            
                    of arrowright       : 
                        var subargStack: seq[int] = @[]
                        var ended = false
                        var ret: seq[Value] = @[]

                        let subblock = processNextCommand()
                        addTerminalValue(false):
                            addConst(consts, newBlock(subblock), opPush)

                    of thickarrowright  : 
                        # TODO(Eval\addTerminalValue) Thick arrow-right not working with pipes
                        # labels: vm,evaluator,enhancement,bug
                        var ab: seq[Value]
                        var sb: seq[Value]
                        processThickArrowRight(ab, sb)          

                        # add the blocks
                        addTerminalValue(false):
                            addConst(consts, newBlock(ab), opPush)
                        addTerminalValue(false):
                            addConst(consts, newBlock(sb), opPush)            

                        i += 1
                    else:
                        let symalias = node.m
                        if Aliases.hasKey(symalias):
                            let symfunc = Syms[Aliases[symalias].name.s]
                            if symfunc.kind==Function:
                                if symfunc.fnKind == BuiltinFunction and symfunc.arity!=0:
                                    addConst(consts, Aliases[symalias].name, opCall)
                                    argStack.add(symfunc.arity)
                                elif symfunc.fnKind == UserFunction and symfunc.params.a.len!=0:
                                    addConst(consts, Aliases[symalias].name, opCall)
                                    argStack.add(symfunc.params.a.len)
                                else:
                                    addTerminalValue(false):
                                        addConst(consts, Aliases[symalias].name, opCall)
                            else:
                                addTerminalValue(false):
                                    addConst(consts, Aliases[symalias].name, opLoad)
                        else:
                            addTerminalValue(false):
                                addConst(consts, node, opPush)

            of SymbolLiteral:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Regex:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Color : 
                addTerminalValue(false):
                    addConst(consts, node, opPush)
            of Date : discard

            of Binary : discard

            of Dictionary,
               Function: 
                   addTerminalValue(false):
                        addConst(consts, node, opPush)

            of Inline: 
                addTerminalValue(false):
                    evalOne(node, consts, currentCommand, inBlock=true, isDictionary=isDictionary)

            of Block:
                addTerminalValue(false):
                    addConst(consts, node, opPush)

            of Database: discard

            of Bytecode: discard

            of Newline: 
                when not defined(NOERRORLINES):
                    addEol(node.line)
                else:
                    discard
                # #echo "EVAL: found newline: " & $(node.line)
                # it.add((byte)opEol)
                # it.add((byte)node.line shr 8)
                # it.add((byte)node.line)

            of Nothing: discard
            of Any: discard

        i += 1

    if currentCommand!=[]:
        if inBlock: 
            for b in currentCommand: it.add(b)
        else:
            for b in currentCommand.reversed: it.add(b)

proc doEval*(root: Value, isDictionary=false): Translation = 
    var cnsts: ValueArray = @[]
    var newit: ByteArray = @[]

    TmpArities = Arities

    evalOne(root, cnsts, newit, isDictionary=isDictionary)
    newit.add((byte)opEnd)

    result = (cnsts, newit)

    when defined(VERBOSE):
        result.dump()

    result = (cnsts,newit)
        
#=======================================
# Inspection
#=======================================

when not defined(PORTABLE):
    proc dump*(evaled: Translation) =
        var lines: seq[string] = @[] 
        # for l in showDebugHeader("Constants"):
        #     lines.add(l)

        # var i = 0

        # let consts = evaled[0]
        let it = evaled[1]

        # while i < consts.len:
        #     var cnst = consts[i]
        #     lines.add(fmt("{i}: "))
        #     # stdout.write fmt("{i}: ")
        #     # cnst.dump(0, false)

        #     i += 1
        
        # for l in showDebugHeader("Instruction Table"):
        #     lines.add(l)

        var i = 0

        while i < it.len:
            #stdout.write fmt("{i}: ")
            var instr = (OpCode)(it[i])

            #stdout.write ($instr).replace("op").toLowerAscii()

            case instr:
                of opPush, opStore, opLoad, opCall, opAttr:
                    i += 1
                    let indx = it[i]
                    lines.add(($instr).replace("op").toUpperAscii() & fmt("\t#{indx}"))
                # of opExtra:
                #     i += 1
                #     let extra = ($((OpCode)((int)(it[i])+(int)(opExtra)))).replace("op").toLowerAscii()
                #     stdout.write fmt("\t%{extra}\n")
                else:
                    lines.add(($instr).replace("op").toUpperAscii())

            i += 1
 
        echo ""
        echo bold(grayColor) & ">>      VM | " & fg(grayColor) & 
             lines.join(bold(grayColor) & "\n           | " & fg(grayColor)) & resetColor
