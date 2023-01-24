#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/eval.nim
#=======================================================

## This module contains the evaluator for the VM.
## 
## The evaluator:
## - takes a Block of values coming from the parser
## - passes to the AST generator
## - interpretes the AST and returns a Translation object
## 
## The main entry point is ``doEval``.

#=======================================
# Libraries
#=======================================

import hashes, sugar, tables

import vm/[ast, bytecode, values/value]
import vm/values/custom/[vbinary, vlogical]

import vm/values/printable

#=======================================
# Variables
#=======================================

var
    StoredTranslations : Table[Hash, Translation]

#=======================================
# Helpers
#=======================================

func indexOfValue(a: ValueArray, item: Value): int {.inline,enforceNoRaises.}=
    result = 0
    for i in items(a):
        if consideredEqual(item, i): return
        inc(result)
    result = -1

template addByte(instructions: var VBinary, b: untyped): untyped = 
    when b is OpCode:
        instructions.add(byte(b))
    else:
        instructions.add(b)

template addOpWithNumber(instructions: var VBinary, oper: OpCode, num: untyped, hasShortcut = true): untyped =
    if num > 255:
        instructions.addByte([
            byte(oper)+1,
            byte(num shr 8),
            byte(num)
        ])
    else:
        when hasShortcut:
            if num <= 13:
                instructions.addByte((byte(oper)-0x0E) + byte(num))
            else:
                instructions.addByte([
                    byte(oper),
                    byte(num)
                ])
        else:
            instructions.addByte([
                byte(oper),
                byte(num)
            ])

template addReplaceOpWithIndex(instructions: var VBinary, oper: OpCode, num: untyped): untyped =
    if num > 255:
        instructions[^1] = byte(oper)+1
        instructions.addByte([
            byte(num shr 8),
            byte(num)
        ])
    else:
        instructions[^1] = byte(oper)
        instructions.addByte(byte(num))

proc cleanChildren(node: Node): seq[Node] =
    result = collect:
        for subnode in node.children:
            if subnode.kind != NewlineNode:
                subnode

proc getNextNonNewlineNode(blok: Node, i: var int, nLen: int): Node =
    result = nil
    if i + 1 >= nlen: return
    result = blok.children[i+1]

    var j = i+1
    while result.kind == NewlineNode and j + 1 < nLen:
        j += 1
        result = blok.children[j]

    if result.kind == NewlineNode: 
        result = nil
    else:
        i = j

proc addConst(consts: var ValueArray, instructions: var VBinary, v: Value, op: OpCode, hasShortcut: static bool=true) {.inline,enforceNoRaises.} =
    var indx = consts.indexOfValue(v)
    if indx == -1:
        let newv = v
        newv.readonly = true
        consts.add(newv)
        indx = consts.len-1

    instructions.addOpWithNumber(op, indx, hasShortcut)

proc getOperand*(node: Node, inverted: static bool=false): OpCode =
    if node.kind notin CallNode:
        when inverted: opJmpIfNot   else: opJmpIf
    else:
        case node.op:
            of opEq: 
                when inverted: opJmpIfNe    else: opJmpIfEq
            of opNe: 
                when inverted: opJmpIfEq    else: opJmpIfNe
            of opLt: 
                when inverted: opJmpIfGe    else: opJmpIfLt
            of opLe: 
                when inverted: opJmpIfGt    else: opJmpIfLe
            of opGt: 
                when inverted: opJmpIfLe    else: opJmpIfGt
            of opGe: 
                when inverted: opJmpIfLt    else: opJmpIfGe
            of opNot: 
                when inverted: opJmpIf      else: opJmpIfNot
            else: 
                when inverted: opJmpIfNot   else: opJmpIf

func doesNotContainBranching(blok: Value): bool {.enforceNoRaises.} =
    for subvalue in blok.a:
        if subvalue.kind == Word and subvalue.s in ["continue", "break"]:
            return false
        elif subvalue.kind == Block:
            if not doesNotContainBranching(subvalue):
                return false
    return true

func doesNotContainBranching(node: Node): bool {.enforceNoRaises.} =
    for subnode in node.children:
        if subnode.kind == BuiltinCall and subnode.op in {opContinue, opBreak}:
            return false
        elif subnode.kind == ConstantValue and subnode.value.kind == Block:
            if not doesNotContainBranching(subnode.value):
                return false
        else:
            if not doesNotContainBranching(subnode):
                return false
    return true

#------------------------
# Optimization
#------------------------

template optimizeConditional(
    consts: var ValueArray, 
    it: var VBinary, 
    special: untyped, 
    withLoop=false,
    withPotentialElse=false,
    isSwitch=false,
    withInversion=false
): untyped =
    # let's keep some references
    # to the children
    let cleanedChildren = cleanChildren(special)
    let left {.cursor.} = cleanedChildren[0]
    let right {.cursor.} = cleanedChildren[1]

    # can we optimize?
    var canWeOptimize = false

    when withPotentialElse:
        var elseChild {.cursor.}: Node
        when isSwitch:
            elseChild = cleanedChildren[2]
            canWeOptimize = right.kind == ConstantValue and right.value.kind == Block and
                            elseChild.kind == ConstantValue and elseChild.value.kind == Block
        else:
            let previousI = i
            let elseNode = getNextNonNewlineNode(blok, i, nLen)

            if (not elseNode.isNil) and elseNode.kind == SpecialCall and elseNode.op == opElse:
                elseChild = elseNode.children[0]
                canWeOptimize = right.kind == ConstantValue and right.value.kind == Block and
                                elseChild.kind == ConstantValue and elseChild.value.kind == Block
            else:
                i = previousI
    else:
        when withLoop:
            canWeOptimize = right.kind == ConstantValue and right.value.kind == Block and 
                            left.kind == ConstantValue and left.value.kind == Block
        else:
            canWeOptimize = right.kind == ConstantValue and right.value.kind == Block

    if canWeOptimize:
        let rightNode = generateAst(right.value)

        when withLoop:
            var leftIt: VBinary
            let leftNode = generateAst(left.value)

        let stillProceed =
            when withLoop:
                leftNode.children.len > 0 and doesNotContainBranching(rightNode)
            else:
                true

        if stillProceed:

            when withLoop:
                # separately ast+evaluate right child block     
                evaluateBlock(leftNode, consts, leftIt)
                it.add(leftIt)
            else:
                # inline-evaluate left child
                evaluateBlock(Node(kind:RootNode, children: @[left]), consts, it)

            # separately ast+evaluate right child block     
            var rightIt: VBinary
            evaluateBlock(rightNode, consts, rightIt)

            when withPotentialElse:
                # separately ast+evaluate else child block     
                var elseIt: VBinary
                evaluateBlock(generateAst(elseChild.value), consts, elseIt)

            # get operand & added to the instructions
            let newOp = 
                when withLoop:
                    getOperand(leftNode.children[0], inverted=withInversion)
                else:
                    getOperand(left, inverted=withInversion)

            # get jump distance
            var jumpDistance =
                when withPotentialElse:
                    if elseIt.len > 255:
                        rightIt.len + 3
                    else:
                        rightIt.len + 2
                elif withLoop:
                    if (leftIt.len + rightIt.len) > 255:
                        rightIt.len + 3
                    else:
                        rightIt.len + 2
                else:
                    rightIt.len

            # add operand to our instructions
            if newOp in {opJmpIf, opJmpIfNot}:
                it.addOpWithNumber(newOp, jumpDistance, hasShortcut=false)
            else:
                it.addReplaceOpWithIndex(newOp, jumpDistance)
                jumpDistance -= 1

            # add the evaluated right block            
            it.add(rightIt)

            # finally add some potential else block
            # preceded by an appropriate jump around it
            when withPotentialElse:
                it.addOpWithNumber(opGoto, elseIt.len, hasShortcut=false)

                # add the else block
                it.add(elseIt)
            elif withLoop:
                let upDistance = leftIt.len + jumpDistance
                it.addOpWithNumber(opGoup, upDistance, hasShortcut=false)

            # processing finished
            alreadyProcessed = true

#=======================================
# Methods
#=======================================

proc evaluateBlock*(blok: Node, consts: var ValueArray, it: var VBinary, isDictionary=false) =
    let nLen = blok.children.len
    var i = 0

    #------------------------
    # Shortcuts
    #------------------------

    template addConst(v: Value, op: OpCode, hasShortcut: static bool=true): untyped =
        addConst(consts, it, v, op, hasShortcut)

    template addSingleCommand(op: untyped): untyped =
        it.addByte(op)

    template addEol(n: untyped): untyped =
        it.addOpWithNumber(opEol, n, hasShortcut=false)

    #------------------------
    # MainLoop
    #------------------------

    while i < nLen:
        let item = blok.children[i]

        var alreadyProcessed = false
        
        if item.kind == SpecialCall:
            case item.op:
                of opIf:        optimizeConditional(consts, it, item, withInversion=true)
                of opIfE:       optimizeConditional(consts, it, item, withPotentialElse=true, withInversion=true)
                of opUnless:    optimizeConditional(consts, it, item)
                of opUnlessE:   optimizeConditional(consts, it, item, withPotentialElse=true)
                of opSwitch:    optimizeConditional(consts, it, item, withPotentialElse=true, isSwitch=true, withInversion=true)
                of opWhile:     optimizeConditional(consts, it, item, withLoop=true, withInversion=true)
                of opElse:
                    # `else` is not handled separately
                    # if it's a try?/else block for example, 
                    # it's to be handled as a normal op below
                    # if it's an if?/else or unless?/else construct, 
                    # it has already been above ^
                    discard
                else:
                    discard # won't reach here

        if not alreadyProcessed:

            for instruction in traverse(item):

                case instruction.kind:
                    of RootNode:
                        discard
                    of NewlineNode:
                        addEol(instruction.line)
                    of ConstantValue:
                        var alreadyPut = false
                        let iv {.cursor.} = instruction.value
                        case instruction.value.kind:
                            of Null:
                                addSingleCommand(opConstN)
                                alreadyPut = true
                            of Logical:
                                if iv.b == True:
                                    addSingleCommand(opConstBT)
                                    alreadyPut = true
                                elif iv.b == False:
                                    addSingleCommand(opConstBF)
                                    alreadyPut = true
                            of Integer:
                                if likely(iv.iKind==NormalInteger) and iv.i >= -1 and iv.i <= 15: 
                                    addSingleCommand(byte(opConstI0) + byte(iv.i))
                                    alreadyPut = true
                            of Floating:
                                case iv.f:
                                    of -1.0:
                                        addSingleCommand(opConstF1M)
                                        alreadyPut = true
                                    of 0.0:
                                        addSingleCommand(opConstF0)
                                        alreadyPut = true
                                    of 1.0:
                                        addSingleCommand(opConstF1)
                                        alreadyPut = true
                                    of 2.0:
                                        addSingleCommand(opConstF2)
                                        alreadyPut = true
                                    else:
                                        discard
                            of String:
                                if iv.s == "":
                                    addSingleCommand(opConstS)
                                    alreadyPut = true
                            of Block:
                                if iv.a.len == 0:
                                    addSingleCommand(opConstA)
                                    alreadyPut = true
                            of Dictionary:
                                if iv.d.len == 0:
                                    addSingleCommand(opConstD)
                                    alreadyPut = true
                            else:
                                discard

                        if not alreadyPut:
                            addConst(instruction.value, opPush)
                    of VariableLoad:
                        addConst(instruction.value, opLoad)
                    of AttributeNode:
                        addConst(instruction.value, opAttr)
                    of VariableStore:
                        if unlikely(isDictionary):
                            addConst(instruction.value, opDStore, hasShortcut=false)
                        else:
                            addConst(instruction.value, opStore)
                    of OtherCall:
                        addConst(instruction.value, opCall)
                    of BuiltinCall:
                        addSingleCommand(instruction.op)
                    of SpecialCall:
                        # TODO(VM/eval) nested `switch` calls are not being optimized
                        #  labels: vm, evaluator, performance, enhancement
                        addSingleCommand(instruction.op)

        i += 1

#=======================================
# Main
#=======================================

proc doEval*(root: Value, isDictionary=false, useStored: static bool = true): Translation {.inline.} = 
    ## Take a parsed Block of values and return its Translation - 
    ## that is: the constants found + the list of bytecode instructions
    
    var vhash {.used.}: Hash = -1
    
    when useStored:
        if not root.dynamic:
            vhash = hash(root)
            if (let storedTranslation = StoredTranslations.getOrDefault(vhash, nil); not storedTranslation.isNil):
                return storedTranslation

    var consts: ValueArray
    var it: VBinary

    evaluateBlock(generateAst(root, asDictionary=isDictionary), consts, it, isDictionary=isDictionary)
    it.add(byte(opEnd))

    result = Translation(constants: consts, instructions: it)

    #dump(newBytecode(result))

    when useStored:
        if vhash != -1:
            StoredTranslations[vhash] = result

template evalOrGet*(item: Value): untyped =
    if item.kind==Bytecode: item.trans
    else: doEval(item)