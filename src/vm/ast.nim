#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/ast.nim
#=======================================================

## This module contains the AST implementation for the VM.
## 
## In a few words, it:
## - takes a Block of values coming from the parser
## - transforms it into an AST tree with semantics
##   ready for the evaluator
## 
## The main entry point is ``generateAst``.

# TODO(VM/ast) show warning in case `else` is preceded by `if` - and not `if?`
#  labels: vm, ast, enhancement, error handling

# TODO(VM/ast) make sure all left-right checking are not Newlines
#  labels: vm, ast, enhancement, unit-test

# TODO(VM/ast) make it so that pipes work inside arrow blocks
#  something like this could/should be working:
#  ```red
#  f: function [x]-> 2..x | select => even?
#  ```
#  labels: vm, ast, enhancement

#=======================================
# Libraries
#=======================================

import sequtils, strutils
import sugar, tables, unicode, std/with

import vm/[globals, values/value, values/comparison, values/operators, values/types]
import vm/values/printable
import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vrational, vsymbol, vversion]

import vm/profiler

import vm/bytecode
#=======================================
# Types
#=======================================

type
    # abstract syntax tree definition
    NodeKind* = enum
        RootNode            # Root node of the AST

        NewlineNode         # Newline node
        
        # TerminalNode
        ConstantValue       # Terminal node of the AST containing a value
        VariableLoad        # Load a variable

        # CallNode
        AttributeNode       # Either an Attribute or an AttributeLabel
        VariableStore       # Store a variable

        OtherCall           # Call to a function that is not a builtin
        BuiltinCall         # Call to a builtin function
        SpecialCall         # Call to a special function

    NodeArray* = seq[Node]

    Node* = ref object
        case kind*: NodeKind:
            of RootNode, ConstantValue, VariableLoad:
                discard
            of NewlineNode:
                line*: uint32
            else:
                op*: OpCode
                arity*: int8
                params*: int8
                
        value*: Value
        parent*: Node
        children*: NodeArray

    NodeObj = typeof(Node()[])

# Benchmarking
{.hints: on.}
{.hint: "Node's inner type is currently " & $sizeof(NodeObj) & ".".}
{.hints: off.}

#=======================================
# Variables
#=======================================
        
var
    TmpArities : Table[string,int8]
    ArrowBlock : seq[ValueArray]
    OldChild  : Node
    OldParent : Node

    PipeParent : Node

#=======================================
# Constants
#=======================================

const
    NoStartingLine  = 1896618966'u32

    TerminalNode*   : set[NodeKind] = {ConstantValue, VariableLoad}
    CallNode*       : set[NodeKind] = {AttributeNode..SpecialCall}

#=======================================
# Forward declarations
#=======================================

proc dumpNode*(node: Node, level = 0, single: static bool=false, showNewlines: static bool=false): string 

#=======================================
# Helpers
#=======================================

#------------------------
# Tree manipulation
#------------------------

func setOnlyChild(node: Node, child: Node) {.enforceNoRaises.} =
    child.parent = node
    node.children.setLen(1)
    node.children[0] = child

func addChild*(node: Node, child: Node) {.enforceNoRaises.} =
    child.parent = node
    node.children.add(child)
    if node.kind in CallNode and child.kind notin {NewlineNode, AttributeNode}:
        node.params += 1

func addChildToFront*(node: Node, child: Node): int {.enforceNoRaises.} =
    result = 0
    while node.children[result].kind==AttributeNode:
        result += 1

    child.parent = node
    node.children.insert(child, result)
    if node.kind in CallNode and child.kind notin {NewlineNode, AttributeNode}:
        node.params += 1

func addChildren*(node: Node, children: openArray[Node]) {.enforceNoRaises.} =
    for child in children:
        node.addChild(child)

func deleteNode(node: Node) =
    if not node.parent.isNil:
        node.parent.children.delete(node.parent.children.find(node))
        node.parent = nil

proc replaceNode(node: Node, newNode: Node) =
    newNode.parent = node.parent
    node.parent.children[node.parent.children.find(node)] = newNode

proc addSibling(node: Node, newNode: Node) =
    newNode.parent = node.parent
    node.parent.children.insert(newNode, node.parent.children.find(node)+1)

proc isLastChild(node: Node): bool =
    var j = node.parent.children.len-1
    while j >= 0 and node.parent.children[j].kind == NewlineNode:
        j -= 1
    return node.parent.children[j] == node

#------------------------
# Iterators
#------------------------

iterator traverse*(node: Node): Node =
    # reverse post-order traversal (RLN)
    var preStack = @[node]
    var postStack: seq[Node]

    while preStack.len > 0:
        var subnode = preStack.pop() 
        postStack.add(subnode)
        var j = subnode.children.len-1
        while j >= 0:
            preStack.add(subnode.children[j])
            j -= 1

    while postStack.len > 0:
        var subnode = postStack.pop()
        yield subnode

#------------------------
# Misc
#------------------------

template isSymbol(val: Value, sym: VSymbol): bool =
    val.kind == Symbol and val.m == sym

#=======================================
# Constructors
#=======================================

template newRootNode(): Node =
    Node(
        kind: RootNode
    )

template newTerminalNode(kn: NodeKind, va: Value): Node =
    Node(
        kind: kn,
        value: va
    )

template newConstant(v: Value): Node =
    newTerminalNode(ConstantValue, v)

template newVariable(v: Value): Node =
    newTerminalNode(VariableLoad, v)

template newCallNode(kn: NodeKind, ar: int8, va: Value, oper: OpCode = opNop): Node =
    Node(
        kind: kn,
        arity: ar,
        op: oper,
        value: va
    )

func copyNode(node: Node): Node =
    result = Node(kind: node.kind)
    case node.kind:
        of NewlineNode:
            result.line = node.line
        of ConstantValue, VariableLoad:
            result.value = node.value
        else:
            result.op = node.op
            result.arity = node.arity
            result.params = node.params
            result.value = node.value
            result.addChildren(node.children)        

#=======================================
# Methods
#=======================================

proc processBlock*(
    root: Node, 
    blok: Value, 
    start = 0, 
    startingLine: uint32 = NoStartingLine, 
    asDictionary: bool = false, 
    asFunction: bool = false, 
    processingArrow: static bool = false
): int =
    var i: int = start
    var nLen: int = blok.a.len

    var currentLine: uint32 = 
        if startingLine == NoStartingLine:
            if i < nLen:
                blok.a[i].ln
            else:
                0
        else:
            startingLine

    var current = root

    when processingArrow:
        ArrowBlock.add(@[])

    proc addCall(target: var Node, name: string, arity: int8 = -1, fun: Value = nil)

    #------------------------
    # Optimization
    #------------------------

    proc optimizeAdd(target: var Node) {.enforceNoRaises.} =
        var left = target.children[0]
        var right = target.children[1]

        if left.kind == ConstantValue and left.value.kind in {Integer, Floating}:
            # Constant folding
            if right.kind == ConstantValue and right.value.kind in {Integer, Floating}:
                hookOptimProfiler("add (CF)")
                target.replaceNode(newConstant(left.value + right.value))
            # Convert 1 + X -> inc X
            elif right.kind==VariableLoad and left.kind==ConstantValue and left.value == I1:
                hookOptimProfiler("add (inc)")
                target.op = opInc
                target.arity = 1
                target.setOnlyChild(right)
        
        # Convert X + 1 -> inc X
        elif left.kind==VariableLoad and right.kind==ConstantValue and right.value == I1:
            hookOptimProfiler("add (inc)")
            target.op = opInc
            target.arity = 1
            target.setOnlyChild(left)
        
        # Convert X + X * Y -> X * (1 + Y) and
        #         X + Y * X -> X * (Y + 1)
        elif left.kind == VariableLoad and right.op == opMul:
            if right.children[0].kind == VariableLoad and right.children[0].value == left.value:
                hookOptimProfiler("add (distributive)")
                target.op = opMul
                if right.children[1].kind == ConstantValue and right.children[1].value.kind in {Integer, Floating}:
                    right.replaceNode(newConstant(right.children[1].value + I1))
                else:
                    right.op = opAdd
                    right.children[0].kind = ConstantValue
                    right.children[0].value = newInteger(1)
            elif right.children[1].kind == VariableLoad and right.children[1].value == left.value:
                hookOptimProfiler("add (distributive)")
                target.op = opMul
                if right.children[0].kind == ConstantValue and right.children[0].value.kind in {Integer, Floating}:
                    right.replaceNode(newConstant(right.children[0].value + I1))
                else:
                    right.op = opAdd
                    right.children[1].kind = ConstantValue
                    right.children[1].value = newInteger(1)
        
        # Convert (X * Y) + X -> (1 + Y) * X and
        #         (Y * X) + X -> (Y + 1) * X
        elif right.kind == VariableLoad and left.op == opMul:
            if left.children[0].kind == VariableLoad and left.children[0].value == right.value:
                hookOptimProfiler("add (distributive)")
                target.op = opMul
                if left.children[1].kind == ConstantValue and left.children[1].value.kind in {Integer, Floating}:
                    left.replaceNode(newConstant(left.children[1].value + I1))
                else:
                    left.op = opAdd
                    left.children[0].kind = ConstantValue
                    left.children[0].value = newInteger(1)
            elif left.children[1].kind == VariableLoad and left.children[1].value == right.value:
                hookOptimProfiler("add (distributive)")
                target.op = opMul
                if left.children[0].kind == ConstantValue and left.children[0].value.kind in {Integer, Floating}:
                    left.replaceNode(newConstant(left.children[0].value + I1))
                else:
                    left.op = opAdd
                    left.children[1].kind = ConstantValue
                    left.children[1].value = newInteger(1)

    proc optimizeSub(target: var Node) {.enforceNoRaises.} =
        var left = target.children[0]
        var right = target.children[1]

        if left.kind == ConstantValue and left.value.kind in {Integer,Floating} and right.kind == ConstantValue and right.value.kind in {Integer,Floating}:
            hookOptimProfiler("sub (CF)")
            # Constant folding
            target.replaceNode(newConstant(left.value - right.value))
        elif left.kind == VariableLoad and right.kind == ConstantValue and right.value == I1:
            hookOptimProfiler("sub (dec)")
            # Convert X - 1 -> dec X
            target.op = opDec
            target.arity = 1
            target.setOnlyChild(left)

    template optimizeArithmeticOp(target: var Node, op: untyped) =
        var left = target.children[0]
        var right = target.children[1]

        if left.kind == ConstantValue and left.value.kind in {Integer,Floating} and 
           right.kind == ConstantValue and right.value.kind in {Integer,Floating}:
            hookOptimProfiler("other (CF)")
            target.replaceNode(newConstant(op(left.value,right.value)))

    proc optimizeAppend(target: var Node) {.enforceNoRaises.} =
        var left = target.children[0]
        var right = target.children[1]

        if left.kind == ConstantValue and left.value.kind == String:
            # Constant folding
            if right.kind == ConstantValue and right.value.kind == String:
                hookOptimProfiler("append (CF)")
                target.replaceNode(newConstant(newString(left.value.s & right.value.s)))

    proc optimizeTo(target: var Node) {.enforceNoRaises.} =
        var left = target.children[0]

        if left.kind == ConstantValue and left.value.kind==Type:
            if left.value.t == Integer:
                hookOptimProfiler("to (:integer)")
                # convert `to :integer` -> opToI
                target.op = opToI
                target.arity = 1
                target.children.delete(0)
            elif left.value.t == String:
                hookOptimProfiler("To (:string)")
                # convert `to :string` -> opToS
                target.op = opToS
                target.arity = 1
                target.children.delete(0)

    proc optimizeReturn(target: var Node) {.enforceNoRaises.} =
        if isLastChild(target):
            hookOptimProfiler("return (eliminate last)")
            # Replace last return
            var left = target.children[0]
            target.replaceNode(left)

    proc updateAritiesFromStore(target: var Node) {.enforceNoRaises.} =
        var child = target.children[0]

        if child.op == opFunc:
            let params {.cursor.} = child.children[0]

            if params.value.kind == Literal:
                TmpArities[target.value.s] = 1
            elif params.value.kind == Block:
                TmpArities[target.value.s] = int8(params.value.a.countIt(it.kind != Type))
        else:
            TmpArities.del(target.value.s)
 
    #------------------------
    # Helper Functions
    #------------------------

    template rewindCallBranches(target: var Node, optimize: bool = false, clearPipes: bool = true): untyped =
        while target.kind in CallNode and target.params == target.arity:
            when optimize:
                if target.kind == VariableStore:
                    target.updateAritiesFromStore()
                else:
                    try:
                        case target.op:
                            of opAdd        : target.optimizeAdd()
                            of opSub        : target.optimizeSub()
                            of opMul        : target.optimizeArithmeticOp(`*`)
                            of opDiv        : target.optimizeArithmeticOp(`/`)
                            of opFDiv       : target.optimizeArithmeticOp(`//`)
                            of opMod        : target.optimizeArithmeticOp(`%`)
                            of opPow        : target.optimizeArithmeticOp(`^`)
                            of opAppend     : target.optimizeAppend()
                            of opTo         : target.optimizeTo()
                            of opReturn     : 
                                if asFunction and i == nLen-1:
                                    target.optimizeReturn()
                                
                            else:
                                discard
                    except Defect, CatchableError:
                        discard

            target = target.parent

            when clearPipes:
                if target.kind == RootNode:
                    PipeParent = nil

    template rollThrough(target: var Node): untyped =
        target = target.children[^1]

    #------------------------
    # AST Generation
    #------------------------

    template addPotentialInfixCall(target: var Node): untyped =
        if i < nLen - 1:
            let nextNode {.cursor.} = blok.a[i+1]
            if nextNode.kind == Symbol and nextNode.m notin {arrowright, thickarrowright, pipe}:
                if (let aliased = Aliases.getOrDefault(nextNode.m, NoAliasBinding); aliased != NoAliasBinding):
                    var symfunc {.cursor.} = GetSym(aliased.name.s)

                    if symfunc.kind==Function and aliased.precedence==InfixPrecedence:
                        when processingArrow:
                            ArrowBlock[^1].add(nextNode)
                        i += 1
                        target.addCall(aliased.name.s, fun=symfunc)

    proc getCallNode(name: string, arity: int8 = -1, fun: Value = nil): Node =
        var callType: OtherCall..SpecialCall = OtherCall

        var fn {.cursor.}: Value =
            if fun.isNil:
                Syms.getOrDefault(name, nil)
            else:
                fun

        var ar: int8 =
            if arity == -1 and not fn.isNil:
                fn.arity
            else:
                arity

        var op: OpCode = opNop

        if (not fn.isNil) and fn.fnKind == BuiltinFunction:
            if (op = fn.op; op != opNop):
                callType = 
                    if op in {opIf, opIfE, opUnless, opUnlessE, opElse, opSwitch, opWhile}:
                        SpecialCall
                    else:
                        BuiltinCall

        var v: Value =
            if callType == OtherCall: 
                newWord(name)
            else:
                nil

        result = newCallNode(callType, ar, v, op)

    proc addCall(target: var Node, name: string, arity: int8 = -1, fun: Value = nil) =
        let newCall = getCallNode(name, arity, fun)
        
        if newCall.arity != 0:
            with target:
                addChild(newCall)
                rollThrough()
        else:
            with target:
                addPotentialInfixCall()
                addChild(newCall)
                rewindCallBranches(optimize=true)

    func addStore(target: var Node, val: Value) {.enforceNoRaises.} =
        target.addChild(newCallNode(VariableStore, 1, val))

        target.rollThrough()

    proc addAttribute(target: var Node, val: Value, isLabel: static bool = false) {.enforceNoRaises.} =
        let attrNode = newCallNode(AttributeNode, 1, val)

        when not isLabel:
            attrNode.addChild(newConstant(VTRUE))

        if not PipeParent.isNil:
            let injectionIndex = PipeParent.addChildToFront(attrNode)
            target = PipeParent
            when isLabel:
                target = target.children[injectionIndex]
            target.rewindCallBranches(clearPipes=false)
        else:
            target.addChild(attrNode)

            when isLabel:
                target.rollThrough()

    proc addNewline(target: var Node) =
        target.addChild(Node(kind: NewlineNode, line: currentLine))

    proc addTerminal(target: var Node, node: Node) =
        with target:
            rewindCallBranches()

            addPotentialInfixCall()

            addChild(node)

            rewindCallBranches(optimize=true)
            
    proc addTerminals(target: var Node, nodes: openArray[Node], dontOptimize: bool =false) =
        with target:
            rewindCallBranches()
            addPotentialInfixCall()
            addChildren(nodes)
        
        if dontOptimize:
            target.rewindCallBranches(optimize=false)
        else:
            target.rewindCallBranches(optimize=true)

    proc addPath(target: var Node, val: Value, isLabel: static bool=false) =
        var pathCallV: Value = nil

        when not isLabel:
            if (let curr = Syms.getOrDefault(val.p[0].s, nil); not curr.isNil):
                let next {.cursor.} = val.p[1]
                if curr.kind==Dictionary and (next.kind==Literal or next.kind==Word):
                    if (let item = curr.d.getOrDefault(next.s, nil); not item.isNil):
                        if item.kind == Function:
                            pathCallV = item

        if not pathCallV.isNil:
            target.addChild(Node(kind: OtherCall, arity: pathCallV.arity, op: opNop, value: pathCallV))
            target.rollThrough()
        else:
            let basePath {.cursor.} = val.p[0]

            when isLabel:
                var baseNode = newVariable(basePath)
            else:
                var baseNode = 
                    if TmpArities.getOrDefault(basePath.s, -1) == 0:
                        newCallNode(OtherCall, 0, basePath)
                    else:
                        newVariable(basePath)

            var i = 1

            while i < val.p.len:
                when isLabel:
                    let newNode = 
                        if i == val.p.len - 1:
                            newCallNode(BuiltinCall, 3, nil, opSet)
                        else:
                            newCallNode(BuiltinCall, 2, nil, opGet)
                else:
                    let newNode = newCallNode(BuiltinCall, 2, nil, opGet)
                
                newNode.addChild(baseNode)
                
                if val.p[i].kind==Block:
                    var subNode = newRootNode()
                    discard subNode.processBlock(val.p[i], startingLine=currentLine, asDictionary=false)
                    newNode.addChildren(subNode.children)
                else:
                    newNode.addChild(newConstant(val.p[i]))
                
                baseNode = newNode
                i += 1

            when isLabel:
                target.addChild(baseNode)
                target.rollThrough()
            else:
                target.addTerminal(baseNode)

    # TODO(VM/ast) verify attributes are correctly processed when using pipes
    #  example:
    #  ```
    #  1..10 | loop.with:'i 'x -> print [i x]
    #  ```
    #  labels: vm,ast,bug
    template addPotentialTrailingPipe(target: var Node): untyped =
        var added = false
        if i < nLen - 1:
            var nextNode {.cursor.} = blok.a[i+1]
            if nextNode.kind == Word:
                if (let funcArity = TmpArities.getOrDefault(nextNode.s, -1); funcArity != -1):
                    i += 1

                    target.rewindCallBranches()

                    var toSpot = target.children.len - 1
                    var toWrap: Node

                    var lastChild: Node = target.children[toSpot]
                    while lastChild.kind==NewlineNode:
                        toSpot -= 1
                        lastChild = target.children[toSpot]
                    
                    toWrap = lastChild

                    if lastChild.kind == VariableStore:
                        toSpot = 0
                        toWrap = copyNode(lastChild.children[0])

                        let newCall = getCallNode(nextNode.s, funcArity)
                        newCall.addChild(toWrap)

                        PipeParent = newCall
                        lastChild.children[0].replaceNode(newCall)
                        target = lastChild
                    
                        target.rollThrough()
                    else:
                    
                        target.children.delete(toSpot)

                        target.addCall(nextNode.s, funcArity)
                        target.addChild(toWrap)
                        PipeParent = target

                    target.rewindCallBranches(clearPipes=false)
                    
                    added = true

        if not added:
            target.addTerminal(newConstant(newSymbol(pipe)))

    proc addInline(target: var Node, val: Value) =
        var subNode = newRootNode()
        discard subNode.processBlock(val, startingLine=currentLine, asDictionary=false)

        target.addTerminals(subNode.children)

    proc addArrowBlock(target: var Node, val: Value) =
        var subNode = newRootNode()
        i = subNode.processBlock(val, start=i+1, startingLine=currentLine, asDictionary=false, processingArrow=true)

        let poppedArrowBlock = newBlock(ArrowBlock.pop())
        when processingArrow:
            ArrowBlock[^1].add(poppedArrowBlock)
    
        target.addTerminal(newConstant(poppedArrowBlock))

    proc addThickArrowBlocks(target: var Node) =
        # get next node
        let subnode {.cursor.} = blok.a[i+1]

        # we'll want to create the two blocks, 
        # for functions like loop, map, select, filter
        # so let's get them ready
        var argblock, subblock: ValueArray

        if subnode.kind==Block:
            # replace ampersand symbols, 
            # sequentially, with arguments
            var idx = 0
            var fnd: int8 = 0
            while idx<subnode.a.len:
                if (subnode.a[idx]).isSymbol(ampersand):
                    let arg = newWord("_" & $(fnd))
                    argblock.add(arg)
                    subblock.add(arg)
                    fnd += 1
                else:
                    subblock.add(subnode.a[idx])
                idx += 1
        else:
            subblock = @[subnode]
            if subnode.kind==Word:
                # check if it's a function
                if (let funcArity = TmpArities.getOrDefault(subnode.s, -1); funcArity != -1):
                    # automatically "push" all its required arguments
                    for j in 0..(funcArity-1):
                        let arg = newWord("_" & $(j))
                        argblock.add(arg)
                        subblock.add(arg)

        if argblock.len == 1:
            when processingArrow:
                ArrowBlock[^1].add(newLiteral(argblock[0].s))
                ArrowBlock[^1].add(newBlock(subblock))
            target.addTerminals([
                newConstant(newLiteral(argblock[0].s)),
                newConstant(newBlock(subblock))
            ])
        else:
            when processingArrow:
                ArrowBlock[^1].add(newBlock(argblock))
                ArrowBlock[^1].add(newBlock(subblock))

            target.addTerminals([
                newConstant(newBlock(argblock)),
                newConstant(newBlock(subblock))
            ])

        i += 1

    #------------------------
    # The Main Loop
    #------------------------

    while i < nLen:
        let item = blok.a[i]

        if item.ln != currentLine:
            currentLine = item.ln
            current.addNewline()

        case item.kind:
            of Word:
                when processingArrow: ArrowBlock[^1].add(item)
                
                var funcArity = TmpArities.getOrDefault(item.s, -1)
                if funcArity != -1:
                    current.addCall(item.s, funcArity)
                else:
                    if item.s == "true":
                        current.addTerminal(newConstant(VTRUE))
                    elif item.s == "false":
                        current.addTerminal(newConstant(VFALSE))
                    else:
                        current.addTerminal(newVariable(item))

            of Label:
                when processingArrow: ArrowBlock[^1].add(item)

                current.addStore(item)

            of Attribute:
                when processingArrow: ArrowBlock[^1].add(item)

                current.addAttribute(item)

            of AttributeLabel:
                when processingArrow: ArrowBlock[^1].add(item)

                current.addAttribute(item, isLabel=true)

            of Path:
                when processingArrow: ArrowBlock[^1].add(item)

                current.addPath(item)

            of PathLabel:
                when processingArrow: ArrowBlock[^1].add(item)

                current.addPath(item, isLabel=true)

            of Inline:
                when processingArrow: ArrowBlock[^1].add(item)

                current.addInline(item)

            of Symbol:
                case item.m:
                    of doublecolon      :
                        inc(i)
                        var subblock: ValueArray
                        while i < nLen:
                            subblock.add(blok.a[i])
                            inc(i)
                        
                        current.addTerminal(newConstant(newBlock(subblock)))
                            
                    of arrowright       : 
                        current.addArrowBlock(blok)

                    of thickarrowright  :
                        current.addThickArrowBlocks()

                    of pipe             :
                        current.addPotentialTrailingPipe()

                    else:
                        when processingArrow: ArrowBlock[^1].add(item)

                        let symalias = item.m
                        let aliased = Aliases.getOrDefault(symalias, NoAliasBinding)
                        if likely(aliased != NoAliasBinding):
                            var symfunc {.cursor.} = GetSym(aliased.name.s)
                            if symfunc.kind==Function:
                                current.addCall(aliased.name.s, fun=symfunc)
                            else: 
                                if aliased.name.s == "null":
                                    current.addTerminal(newConstant(VNULL))
                                else:
                                    current.addTerminal(newVariable(newWord(aliased.name.s)))
                        else:
                            current.addTerminal(newConstant(item))

            else:
                when processingArrow: ArrowBlock[^1].add(item)

                current.addTerminal(newConstant(item))

        i += 1

        when processingArrow:
            if current.kind == RootNode:
                break

    return i-1
    
#=======================================
# Output
#=======================================

proc dumpNode*(node: Node, level = 0, single: static bool = false, showNewlines: static bool = false): string =
    template indentNode(): untyped =
        result &= "     ".repeat(level)

    case node.kind:
        of RootNode:
            indentNode()
            result &= "ROOT: \n"
            for child in node.children:
                result &= dumpNode(child, level+1)
        of NewlineNode:
            when showNewlines:
                indentNode()
                result &= "NEWLINE: " & $(node.line) & "\n"
        of TerminalNode:
            indentNode()
            result &= "Constant: " & $(node.value)

        of CallNode:
            indentNode()
            if node.kind == VariableStore:
                result &= "Store: " & $(node.value) & " <" & $node.arity & ">\n"
            else:
                if node.kind == AttributeNode:
                    result &= "Attribute: "
                else:
                    result &= "Call: "
                if node.value.isNil:
                    var callName = ($node.op).toLowerAscii()
                    callName.removePrefix("op")
                    result &= callName & " <" & $node.arity & ">\n"
                else:
                    result &= node.value.s & " <" & $node.arity & ">\n"

            when not single:
                for child in node.children:
                    result &= dumpNode(child, level+1)

    result &= "\n"

#=======================================
# Main
#=======================================

proc generateAst*(parsed: Value, asDictionary=false, asFunction=false, reuseArities: static bool=false): Node =
    result = newRootNode()

    PipeParent = nil

    when not reuseArities:
        TmpArities = collect:
            for k,v in Syms.pairs:
                if v.kind == Function:
                    {k: v.arity}

    discard result.processBlock(parsed, asDictionary=asDictionary, asFunction=asFunction)

    #echo dumpNode(result)
