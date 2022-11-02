#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/eval.nim
#=======================================================

## This module contains the evaluator for the VM.
## 
## The evaluator:
## - takes a Block of values coming from the parser
## - interpretes it and returns a Translation object
## 
## The main entry point is ``doEval``.

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, tables, unicode

when not defined(PORTABLE):
    import strformat

import vm/[bytecode, globals, profiler, values/value]

import vm/values/custom/[vbinary, vlogical, vsymbol]

#=======================================
# Variables
#=======================================

var
    TmpArities : Table[string,int]

#=======================================
# Helpers
#=======================================

func indexOfValue(a: seq[Value], item: Value): int {.inline.}=
    result = 0
    for i in items(a):
        if sameValue(item, i): return
        if item.kind in {Word, Label} and i.kind in {Word, Label} and item.s==i.s: return
        inc(result)
    result = -1

#=======================================
# Methods
#=======================================

when not defined(NOERRORLINES):
    template addEol(line: untyped):untyped =
        if line > 255:
            it.add((byte)opEolX)
            it.add((byte)line shr 8)
            it.add((byte)line)
        else:
            it.add((byte)opEol)
            it.add((byte)line)

proc evalOne(n: Value, consts: var ValueArray, it: var VBinary, inBlock: bool = false, isDictionary: bool = false) =
    var argStack: seq[int] = @[]
    var currentCommand: VBinary = @[]

    let childrenCount = n.a.len

    var foundIf = false
    var foundIfE = false
    var foundUnless = false
    var foundElse = false
    var foundSwitch = false

    #------------------------
    # Helper Functions
    #------------------------

    template addToCommand(b: untyped):untyped {.dirty.} =
        when b is OpCode:
            currentCommand.add((byte)b)
        else:
            currentCommand.add(b)

    template addToCommandHead(b: untyped, at = 0):untyped {.dirty.} =
        when b is OpCode:
            currentCommand.insert((byte)b, at)
        else:
            currentCommand.insert(b, at)

    proc addConst(currentCommand: var VBinary, consts: var seq[Value], v: Value, op: OpCode) {.inline,enforceNoRaises.} =
        var indx = consts.indexOfValue(v)
        if indx == -1:
            v.readonly = true
            consts.add(v)
            indx = consts.len-1

        if indx <= 13:
            addToCommand(((byte)(op)-0x0E) + (byte)(indx))
        else:
            if indx>255:
                addToCommand([
                    (byte)indx,
                    (byte)indx shr 8,
                    (byte)(op)+1
                ])
            else:
                addToCommand([
                    (byte)indx,
                    (byte)op
                ])

    proc addShortConst(currentCommand: var VBinary, consts: var seq[Value], v: Value, op: OpCode) {.inline,enforceNoRaises.} =
        var indx = consts.indexOfValue(v)
        if indx == -1:
            v.readonly = true
            consts.add(v)
            indx = consts.len-1

        if indx>255:
            addToCommand([
                (byte)indx,
                (byte)indx shr 8,
                (byte)(op)+1
            ])
        else:
            addToCommand([
                (byte)indx,
                (byte)op
            ])

    proc addTrailingConst(currentCommand: var VBinary, consts: var seq[Value], v: Value, op: OpCode) {.inline,enforceNoRaises.} =
        var atPos = 0
        if currentCommand[0] in opStore0.byte..opStoreX.byte:
            atPos = 1

        var indx = consts.indexOfValue(v)
        if indx == -1:
            v.readonly = true
            consts.add(v)
            indx = consts.len-1

        if indx <= 13:
            addToCommandHead(((byte)(op)-0x0E) + (byte)(indx), atPos)
        else:
            if indx>255:
                addToCommandHead([
                    (byte)(op)+1,
                    (byte)indx shr 8,
                    (byte)indx
                ], atPos)
            else:
                addToCommandHead([
                    (byte)op,
                    (byte)indx
                ], atPos)

    proc evalFunctionCall(currentCommand: var VBinary, fun: var Value, toHead: bool, checkAhead: bool, i: var int, funcArity: var int): bool {.enforceNoRaises.} =
        var bt: OpCode = opNop
        var doElse = true

        let fn {.cursor.} = fun

        if fn == ArrayF: bt = opArray
        elif fn == DictF: bt = opDict
        elif fn == FuncF: bt = opFunc 
        elif fn == AddF: bt = opAdd
        elif fn == SubF: bt = opSub
        elif fn == MulF: bt = opMul
        elif fn == DivF: bt = opDiv
        elif fn == FdivF: bt = opFdiv
        elif fn == ModF: bt = opMod
        elif fn == PowF: bt = opPow
        elif fn == NegF: bt = opNeg
        elif fn == BNotF: bt = opBNot
        elif fn == BAndF: bt = opBAnd
        elif fn == BOrF: bt = opBOr
        elif fn == ShlF: bt = opShl
        elif fn == ShrF: bt = opShr
        elif fn == NotF: bt = opNot
        elif fn == AndF: bt = opAnd
        elif fn == OrF: bt = opOr
        elif fn == EqF: bt = opEq
        elif fn == NeF: bt = opNe
        elif fn == GtF: bt = opGt
        elif fn == GeF: bt = opGe
        elif fn == LtF: bt = opLt
        elif fn == LeF: bt = opLe
        elif fn == IfF: 
            foundIf = true
            bt = opIf
        elif fn == IfEF: 
            foundIfE = true
            bt = opIfE
        elif fn == UnlessF: 
            foundUnless = true
            bt = opUnless
        elif fn == ElseF: 
            foundElse = true
            bt = opElse
        elif fn == SwitchF: 
            foundSwitch = true
            bt = opSwitch
        elif fn == WhileF: bt = opWhile
        elif fn == ReturnF: bt = opReturn
        elif fn == ToF: 
            bt = opTo
            if checkAhead:
                let nextNode {.cursor.} = n.a[i+1]
                if nextNode.kind==Type:
                    if nextNode.t==String:
                        addToCommand(opToS)
                        bt = opNop
                        doElse = false
                        funcArity -= 1
                        i += 1
                    elif nextNode.t==Integer:
                        addToCommand(opToI)
                        bt = opNop
                        doElse = false
                        funcArity -= 1
                        i += 1
        elif fn == PrintF: bt = opPrint
        elif fn == GetF: bt = opGet
        elif fn == SetF: bt = opSet
        elif fn == RangeF: bt = opRange
        elif fn == LoopF: bt = opLoop
        elif fn == MapF: bt = opMap
        elif fn == SelectF: bt = opSelect
        elif fn == SizeF: bt = opSize
        elif fn == ReplaceF: bt = opReplace
        elif fn == SplitF: bt = opSplit
        elif fn == JoinF: bt = opJoin 
        elif fn == ReverseF: bt = opReverse
        elif fn == IncF: bt = opInc
        elif fn == DecF: bt = opDec

        if bt != opNop:
            if toHead:
                addToCommandHead(bt)
            else:
                addToCommand(bt)

            return true
        else:
            return not doElse

    proc getConstIdWithShift(currentCommand: var VBinary, pos: int): (int,int) {.inline,enforceNoRaises.} =
        if (OpCode)(currentCommand[pos]) in {opPush0..opPush13}:
            return ((int)(currentCommand[pos]) - (int)(opPush0), 0)
        elif (OpCode)(currentCommand[pos]) == opPush:
            return ((int)(currentCommand[pos+1]), 1)
        elif (OpCode)(currentCommand[pos]) == opPushX:
            return (((int)(currentCommand[pos+1]) shl 8) + (int)(currentCommand[pos+2]), 2)
        
        return (-1, -1)

    proc processIf(consts: var seq[Value], it: var VBinary) {.enforceNoRaises.} =
        let (cnstId, shift) = getConstIdWithShift(currentCommand, 0)

        if cnstId != -1:
            let blk = consts[cnstId]
            if blk.kind == Block and (OpCode)(currentCommand[^1]) in {opIf,opIfE}:
                currentCommand.delete(0..shift)
                discard currentCommand.pop()
                var injectable = opJmpIfNot
                case (OpCode)currentCommand[^1]:
                    of opNot:
                        discard currentCommand.pop()
                        injectable = opJmpIf
                    of opEq:
                        discard currentCommand.pop()
                        injectable = opJmpIfNe
                    of opNe:
                        discard currentCommand.pop()
                        injectable = opJmpIfEq
                    of opGt:
                        discard currentCommand.pop()
                        injectable = opJmpIfLe
                    of opGe:
                        discard currentCommand.pop()
                        injectable = opJmpIfLt
                    of opLt:
                        discard currentCommand.pop()
                        injectable = opJmpIfGe
                    of opLe:
                        discard currentCommand.pop()
                        injectable = opJmpIfGt
                    else:
                        discard
                currentCommand.add([(byte)injectable, (byte)0, (byte)0])
                let injPos = currentCommand.len - 2
                evalOne(blk, consts, currentCommand, inBlock=inBlock, isDictionary=isDictionary)
                if foundIfE:
                    currentCommand.add([(byte)opNop, (byte)opNop, (byte)opNop])
                let finPos = currentCommand.len - injPos - 2
                currentCommand[injPos] = (byte)finPos shr 8
                currentCommand[injPos+1] = (byte)finPos
        
        foundIf = false
        foundIfE = false

    proc processUnless(consts: var seq[Value], it: var VBinary) {.enforceNoRaises.} =
        let (cnstId, shift) = getConstIdWithShift(currentCommand, 0)

        if cnstId != -1:
            let blk = consts[cnstId]
            if blk.kind == Block and (OpCode)(currentCommand[^1]) == opUnless:
                currentCommand.delete(0..shift)
                discard currentCommand.pop()
                var injectable = opJmpIf
                case (OpCode)currentCommand[^1]:
                    of opNot:
                        discard currentCommand.pop()
                        injectable = opJmpIfNot
                    of opEq:
                        discard currentCommand.pop()
                        injectable = opJmpIfEq
                    of opNe:
                        discard currentCommand.pop()
                        injectable = opJmpIfNe
                    of opGt:
                        discard currentCommand.pop()
                        injectable = opJmpIfGt
                    of opGe:
                        discard currentCommand.pop()
                        injectable = opJmpIfGe
                    of opLt:
                        discard currentCommand.pop()
                        injectable = opJmpIfLt
                    of opLe:
                        discard currentCommand.pop()
                        injectable = opJmpIfLe
                    else:
                        discard
                currentCommand.add([(byte)injectable, (byte)0, (byte)0])
                let injPos = currentCommand.len - 2
                evalOne(blk, consts, currentCommand, inBlock=inBlock, isDictionary=isDictionary)
                if foundIfE:
                    currentCommand.add([(byte)opNop, (byte)opNop, (byte)opNop])
                let finPos = currentCommand.len - injPos - 2
                currentCommand[injPos] = (byte)finPos shr 8
                currentCommand[injPos+1] = (byte)finPos
        
        foundUnless = false

    proc processLess(consts: var seq[Value], it: var VBinary) {.enforceNoRaises.} =
        let (cnstId, shift) = getConstIdWithShift(currentCommand, 0)

        if cnstId != -1:
            let blk = consts[cnstId]
            if blk.kind == Block:
                currentCommand.delete(0..shift)
                discard currentCommand.pop()

                evalOne(blk, consts, currentCommand, inBlock=inBlock, isDictionary=isDictionary)
                let currentPos = currentCommand.len
                it[^3] = (byte)opGoto
                it[^2] = (byte)currentPos shr 8
                it[^1] = (byte)currentPos
                
        foundElse = false

    proc processSwitch(consts: var seq[Value], it: var VBinary) {.enforceNoRaises.} =
        let (cnstId, shift) = getConstIdWithShift(currentCommand, 0)

        if cnstId != -1:
            let blk = consts[cnstId]
            if blk.kind == Block:
                let (cnstId2, shift2) = getConstIdWithShift(currentCommand, 1+shift)

                if cnstId2 != -1:
                    let blk2 = consts[cnstId2]
                    if blk2.kind == Block:
                        # for b in currentCommand:
                        #     echo stringify((OpCode)b)
                        currentCommand.delete(0..shift+shift2+1)
                        var toPushBack: VBinary
                        var jpb = currentCommand.len - 1
                        while (OpCode)(currentCommand[jpb]) != opSwitch:
                            toPushBack.add(currentCommand.pop())
                            jpb -= 1
                        reverse(toPushBack)
                        discard currentCommand.pop()
                        var injectable = opJmpIfNot
                        case (OpCode)currentCommand[^1]:
                            of opNot:
                                discard currentCommand.pop()
                                injectable = opJmpIf
                            of opEq:
                                discard currentCommand.pop()
                                injectable = opJmpIfNe
                            of opNe:
                                discard currentCommand.pop()
                                injectable = opJmpIfEq
                            of opGt:
                                discard currentCommand.pop()
                                injectable = opJmpIfLe
                            of opGe:
                                discard currentCommand.pop()
                                injectable = opJmpIfLt
                            of opLt:
                                discard currentCommand.pop()
                                injectable = opJmpIfGe
                            of opLe:
                                discard currentCommand.pop()
                                injectable = opJmpIfGt
                            else:
                                discard
                        currentCommand.add([(byte)injectable, (byte)0, (byte)0])
                        let injPos = currentCommand.len - 2
                        evalOne(blk2, consts, currentCommand, inBlock=inBlock, isDictionary=isDictionary)
                        let preInjection = currentCommand.len
                        currentCommand.add([(byte)opNop, (byte)opNop, (byte)opNop])
                        let finPos = currentCommand.len - injPos - 2
                        currentCommand[injPos] = (byte)finPos shr 8
                        currentCommand[injPos+1] = (byte)finPos
                        let lastLen = currentCommand.len
                        evalOne(blk, consts, currentCommand, inBlock=inBlock, isDictionary=isDictionary)
                        let currentPos = currentCommand.len - lastLen
                        currentCommand[preInjection] = (byte)opGoto
                        currentCommand[preInjection+1] = (byte)currentPos shr 8
                        currentCommand[preInjection+2] = (byte)currentPos
                        if toPushBack.len > 0:
                            currentCommand.add(toPushBack)

        foundSwitch = false

    template addCurrentCommandToBytecode() {.dirty.} =
        if not inBlock: reverse(currentCommand)

        if foundIf or (foundIfE and i+1<childrenCount and n.a[i+1].kind == Word and GetSym(n.a[i+1].s) == ElseF):
            processIf(consts, it)

        elif foundUnless:
            processUnless(consts, it)
        
        elif foundElse and it[^1] == (byte)opNop:
            processLess(consts, it)

        elif foundSwitch:
            processSwitch(consts, it)

        for b in currentCommand:
            it.add(b)
    
        currentCommand.setLen(0)

    proc preAddTerminalValue(consts: var ValueArray, currentCommand: var VBinary, i: var int, n: Value) =
        ## Check for potential Infix operator ahead
            
        if (i+1<childrenCount and n.a[i+1].kind == Symbol):
            let step = 1

            let symalias = n.a[i+1].m
            let aliased = Aliases.getOrDefault(symalias, NoAliasBinding)
            if aliased != NoAliasBinding:
                var symfunc {.cursor.} = GetSym(aliased.name.s)

                if symfunc.kind==Function and aliased.precedence==InfixPrecedence:
                    i += step;
                    
                    if not evalFunctionCall(currentCommand, symfunc, toHead=false, checkAhead=false, i, i):
                        addConst(currentCommand, consts, aliased.name, opCall)

                    argStack.add(symfunc.arity)

    proc preAddTerminalSubValue(consts: var ValueArray, currentCommand: var VBinary, i: var int, n: Value, subargStack: var seq[int], ret: var ValueArray) =
        ## Check for potential Infix operator ahead
            
        if (i+1<childrenCount and n.a[i+1].kind == Symbol):
            let step = 1

            let symalias = n.a[i+1].m
            let aliased = Aliases.getOrDefault(symalias, NoAliasBinding)
            if aliased != NoAliasBinding:
                var symfunc {.cursor.} = GetSym(aliased.name.s)

                if symfunc.kind==Function and aliased.precedence==InfixPrecedence:
                    i += step;
                    
                    subargStack.add(symfunc.arity)

                    ret.add(n.a[i])

    proc postAddTerminalValue(consts: var ValueArray, currentCommand: var VBinary, i: var int, n: Value, it: var VBinary) =
        # Check if command complete

        if argStack.len != 0: argStack[^1] -= 1

        while argStack.len != 0 and argStack[^1] == 0:
            discard argStack.pop()
            argStack[^1] -= 1

        if not (i+1<childrenCount and n.a[i+1].kind == Symbol and n.a[i+1].m == pipe):
            if argStack.len==0:
                # The command is finished
                addCurrentCommandToBytecode()
        else:
            # TODO(Eval\addTerminalValue) Verify pipe operators are working
            # labels: vm,evaluator,enhancement,unit-test
            
            # There is a trailing pipe;
            # let's inspect the following symbol

            i += 1
            if (i+1<childrenCount and n.a[i+1].kind == Word and GetSym(n.a[i+1].s).kind == Function):
                let funcName {.cursor.} = n.a[i+1].s
                let tmpFuncArity = TmpArities.getOrDefault(funcName, -1)
                if tmpFuncArity != -1:
                    if tmpFuncArity>1:
                        argStack.add(tmpFuncArity-1)
                        # TODO(VM/eval) to be fixed
                        #  labels: bug, evaluator, vm
                        if not evalFunctionCall(currentCommand, n.a[i+1], toHead=true, checkAhead=false, i, i):
                            addTrailingConst(currentCommand, consts, n.a[i+1], opCall)
                    else:
                        addTrailingConst(currentCommand, consts, n.a[i+1], opCall)
                        if argStack.len==0:
                            addCurrentCommandToBytecode()
                    i += 1

    proc postAddTerminalSubValue(consts: var ValueArray, currentCommand: var VBinary, i: var int, n: Value, subargStack: var seq[int], ret: var ValueArray, ended: var bool) =
        # Check if command complete

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

    template addTerminalValue(code: untyped): untyped {.dirty.} =
        block:
            # Check for potential Infix operator ahead
            preAddTerminalValue(consts, currentCommand, i, n)
            
            # Run main code
            code

            # Check if command complete
            postAddTerminalValue(consts, currentCommand, i, n, it)

    template addTerminalSubValue(code: untyped): untyped {.dirty.} =
        block:
            # Check for potential Infix operator ahead
            preAddTerminalSubValue(consts, currentCommand, i, n, subargStack, ret)
            
            # Run main code
            code

            # Check if command complete
            postAddTerminalSubValue(consts, currentCommand, i, n, subargStack, ret, ended)

    template processNextCommand(): untyped =
        i += 1

        while i < n.a.len and not ended:
            let subnode {.cursor.} = n.a[i]
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
                    addTerminalSubValue():
                        discard
                of Word:
                    let funcArity = TmpArities.getOrDefault(subnode.s, -1)
                    if funcArity != -1:
                        if funcArity!=0:
                            subargStack.add(funcArity)
                        else:
                            addTerminalSubValue():
                                discard
                    else:
                        addTerminalSubValue():
                            discard

                of Symbol: 
                    let symalias = subnode.m
                    let aliased = Aliases.getOrDefault(symalias, NoAliasBinding)
                    if likely(aliased != NoAliasBinding):
                        let symfunc {.cursor.} = GetSym(aliased.name.s)
                        if symfunc.kind==Function:
                            if aliased.precedence==PrefixPrecedence:
                                if symfunc.arity != 0:
                                    subargStack.add(symfunc.arity)
                                else:
                                    addTerminalSubValue():
                                        discard
                            else:
                                ret.add(newSymbol(ampersand))
                                swap(ret[^1],ret[^2])
                                subargStack.add(symfunc.arity-1)
                        else:
                            addTerminalSubValue():
                                discard
                    else:
                        addTerminalSubValue():
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
        let subnode {.cursor.} = n.a[i+1]

        # we'll want to create the two blocks, 
        # for functions like loop, map, select, filter
        # so let's get them ready
        argblock = @[]
        subblock = @[subnode]

        var funcArity{.inject.}: int = 0

        # if it's a word
        if subnode.kind==Word:
            # check if it's a function
            funcArity = TmpArities.getOrDefault(subnode.s, -1)
            if funcArity != -1:
                # automatically "push" all its required arguments
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
        let node {.cursor.} = n.a[i]

        case node.kind:
            of Null:    addToCommand(opConstN)
            of Logical: 
                # TODO(VM/eval) needs to be inside an `addTerminalValue` block?
                #  this look like a bug...
                #  labels: evaluator, bug
                if node.b==True: addToCommand(opConstBT)
                elif node.b==False: addToCommand(opConstBF)
                else: addToCommand(opConstBM)

            of Integer:
                addTerminalValue():
                    when defined(WEB) or not defined(NOGMP):
                        if likely(node.iKind==NormalInteger):
                            if node.i>=0 and node.i<=15: addToCommand((byte)(opConstI0) + (byte)(node.i))
                            else: addConst(currentCommand, consts, node, opPush)
                        else:
                            addConst(currentCommand, consts, node, opPush)
                    else:
                        if node.i>=0 and node.i<=15: addToCommand((byte)(opConstI0) + (byte)(node.i))
                        else: addConst(currentCommand, consts, node, opPush)

            of Floating:
                addTerminalValue():
                    if node.f==0.0: addToCommand(opConstF0)
                    elif node.f==1.0: addToCommand(opConstF1)
                    elif node.f==2.0: addToCommand(opConstF2)
                    else: addConst(currentCommand, consts, node, opPush)

            of Word:
                var funcArity = TmpArities.getOrDefault(node.s, -1)
                if funcArity != -1:
                    if likely(funcArity!=0):
                        if (var symf = Syms.getOrDefault(node.s, nil); not symf.isNil):
                            if not evalFunctionCall(currentCommand, symf, toHead=false, checkAhead=true, i, funcArity):
                                addConst(currentCommand, consts, node, opCall)
                                # funcArity -> funcArity-1 for ToS/ToI!
                        else:
                            addConst(currentCommand, consts, node, opCall)
                        argStack.add(funcArity)
                    else:
                        addTerminalValue():
                            addConst(currentCommand, consts, node, opCall)
                else:
                    addTerminalValue():
                        addConst(currentCommand, consts, node, opLoad)

            of Label: 
                let funcIndx {.cursor.} = node.s
                var hasThickArrow = false
                var ab: seq[Value]
                var sb: seq[Value]
                let nextNode {.cursor.} = n.a[i+1]
                if (nextNode.kind == Word and nextNode.s == "function") or
                   (nextNode.kind == Symbol and nextNode.m == dollar):
                    let afterNextNode {.cursor.} = n.a[i+2]
                    if afterNextNode.kind == Symbol and afterNextNode.m == thickarrowright:
                        i += 2
                        processThickArrowRight(ab,sb)
                        TmpArities[funcIndx] = funcArity
                        hasThickArrow = true
                        i += 1
                    else:
                        TmpArities[funcIndx] = afterNextNode.a.countIt(it.kind != Type) #n.a[i+2].a.len
                else:
                    if not isDictionary:
                        TmpArities.del(funcIndx)

                if unlikely(isDictionary):
                    addShortConst(currentCommand, consts, node, opDStore)
                else:
                    addConst(currentCommand, consts, node, opStore)
                    
                argStack.add(1)

                if hasThickArrow:
                    addConst(currentCommand, consts, newWord("function"), opCall)
                    argStack.add(2)

                    # add the blocks
                    addTerminalValue():
                        addConst(currentCommand, consts, newBlock(ab), opPush)
                    addTerminalValue():
                        addConst(currentCommand, consts, newBlock(sb), opPush) 

            of Attribute:
                addConst(currentCommand, consts, node, opAttr)
                addToCommand(opConstBT)

            of AttributeLabel:
                addConst(currentCommand, consts, node, opAttr)
                argStack[argStack.len-1] += 1

            of Path:
                var pathCallV: Value = nil

                if (let curr = Syms.getOrDefault(node.p[0].s, nil); not curr.isNil):
                    let next {.cursor.} = node.p[1]
                    if curr.kind==Dictionary and (next.kind==Literal or next.kind==Word):
                        if (let item = curr.d.getOrDefault(next.s, nil); not item.isNil):
                            if item.kind == Function:
                                pathCallV = item

                if not pathCallV.isNil:
                    addConst(currentCommand, consts, pathCallV, opCall)
                    argStack.add(pathCallV.arity)
                else:
                    addTerminalValue():
                        addToCommand(opGet)
                        #addConst(currentCommand, consts, newWord("get"), opCall)
                        
                        var i=1
                        while i<node.p.len-1:
                            addToCommand(opGet)
                            #addConst(currentCommand, consts, newWord("get"), opCall)
                            i += 1

                        let baseNode {.cursor.} = node.p[0]

                        if TmpArities.getOrDefault(baseNode.s, -1) == 0:
                            addConst(currentCommand, consts, baseNode, opCall)
                        else:
                            addConst(currentCommand, consts, baseNode, opLoad)

                        i = 1
                        while i<node.p.len:
                            if node.p[i].kind==Block:
                                evalOne(node.p[i], consts, currentCommand, inBlock=true, isDictionary=isDictionary)
                            else:
                                addConst(currentCommand, consts, node.p[i], opPush)
                            i += 1

            of PathLabel:
                addToCommand(opSet)
                #addConst(currentCommand, consts, newWord("set"), opCall)
                    
                var i=1
                while i<node.p.len-1:
                    addToCommand(opGet)
                    #addConst(currentCommand, consts, newWord("get"), opCall)
                    i += 1
                
                addConst(currentCommand, consts, node.p[0], opLoad)
                i = 1
                while i<node.p.len:
                    if node.p[i].kind==Block:
                        evalOne(node.p[i], consts, currentCommand, inBlock=true, isDictionary=isDictionary)
                    else:
                        addConst(currentCommand, consts, node.p[i], opPush)
                    i += 1

                argStack.add(1)

            of Symbol: 
                case node.m:
                    of doublecolon      :
                        inc(i)
                        var subblock: seq[Value] = @[]
                        while i < n.a.len:
                            let subnode {.cursor.} = n.a[i]
                            subblock.add(subnode)
                            inc(i)
                        addTerminalValue():
                            addConst(currentCommand, consts, newBlock(subblock), opPush)
                            
                    of arrowright       : 
                        var subargStack: seq[int] = @[]
                        var ended = false
                        var ret: seq[Value] = @[]

                        let subblock = processNextCommand()
                        addTerminalValue():
                            addConst(currentCommand, consts, newBlock(subblock), opPush)

                    of thickarrowright  : 
                        # TODO(Eval\addTerminalValue) Thick arrow-right not working with pipes
                        # labels: vm,evaluator,enhancement,bug
                        var ab: seq[Value]
                        var sb: seq[Value]
                        processThickArrowRight(ab, sb)          

                        # add the blocks
                        addTerminalValue():
                            addConst(currentCommand, consts, newBlock(ab), opPush)
                        addTerminalValue():
                            addConst(currentCommand, consts, newBlock(sb), opPush)            

                        i += 1
                    else:
                        let symalias = node.m
                        let aliased = Aliases.getOrDefault(symalias, NoAliasBinding)
                        if likely(aliased != NoAliasBinding):
                            var symfunc {.cursor.} = GetSym(aliased.name.s)
                            if symfunc.kind==Function:
                                if symfunc.fnKind == BuiltinFunction and symfunc.arity!=0:
                                    if not evalFunctionCall(currentCommand, symfunc, toHead=false, checkAhead=false, i, i):
                                        addConst(currentCommand, consts, aliased.name, opCall)
                                    argStack.add(symfunc.arity)
                                elif symfunc.fnKind == UserFunction and symfunc.arity!=0:
                                    addConst(currentCommand, consts, aliased.name, opCall)
                                    argStack.add(symfunc.arity)
                                else:
                                    addTerminalValue():
                                        addConst(currentCommand, consts, aliased.name, opCall)
                            else:
                                addTerminalValue():
                                    addConst(currentCommand, consts, aliased.name, opLoad)
                        else:
                            addTerminalValue():
                                addConst(currentCommand, consts, node, opPush)

            of String:
                addTerminalValue():
                    if node.s.len==0:
                        addToCommand(opConstS)
                    else:
                        addConst(currentCommand, consts, node, opPush)

            of Block:
                addTerminalValue():
                    if node.a.len==0:
                        addToCommand(opConstA)
                    else:
                        addConst(currentCommand, consts, node, opPush)

            of Dictionary:
                addTerminalValue():
                    if node.d.len==0:
                        addToCommand(opConstD)
                    else:
                        addConst(currentCommand, consts, node, opPush)

            of Inline: 
                addTerminalValue():
                    evalOne(node, consts, currentCommand, inBlock=true, isDictionary=isDictionary)

            of Newline: 
                # TODO(Eval/evalOne) verify Newline handling works properly
                #  Also, we have to figure out whether the commented-out code is needed at all
                #  labels: vm, evaluator, cleanup
                when not defined(NOERRORLINES) and not defined(OPTIMIZED):
                    addEol(node.line)
                else:
                    discard

            of Date, Binary, Database, Bytecode,
               Nothing, Any: 

                discard

            else:
            # of Complex, Rational, Version, Type, Char,
            #    Literal, SymbolLiteral, Quantity,
            #    Regex, Color, Object, Function:

                addTerminalValue():
                    addConst(currentCommand, consts, node, opPush)

        i += 1

    if currentCommand!=[]:
        if inBlock: 
            for b in currentCommand: it.add(b)
        else:
            for b in currentCommand.reversed: it.add(b)

proc doEval*(root: Value, isDictionary=false): Translation = 
    ## Take a parsed Block of values and return its Translation - 
    ## that is: the constants found + the list of bytecode instructions
    hookProcProfiler("eval/doEval"):
        var cnsts: ValueArray = @[]
        var newit: VBinary = @[]

        TmpArities = Arities

        evalOne(root, cnsts, newit, isDictionary=isDictionary)
        newit.add((byte)opEnd)

        when defined(OPTIMIZED):
            newit = optimizeBytecode(newit)

    result = Translation(constants: cnsts, instructions: newit)

    # TODO(VM/eval) add option for evaluation into optimized bytecode directly
    #  if optimized:
    #      result.instructions = optimizeBytecode(result)
    # labels: vm, evaluator, enhancement

template evalOrGet*(item: Value): untyped =
    if item.kind==Bytecode: item.trans
    else: doEval(item)