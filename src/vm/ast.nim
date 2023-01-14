import hashes, sugar, tables
import unicode, std/with

import vm/[globals, values/value]
import vm/values/printable
import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vrational, vsymbol, vversion]

type
    # abstract syntax tree definition
    NodeKind* = enum
        RootNode,
        CallNode,
        TerminalNode

    NodeArray* = seq[Node]

    NodeFlag* = enum
        Variable,

        StoreSymbol,
        AddCall

    NodeFlags* = set[NodeFlag]

    Node* = ref object
        case kind*: NodeKind:
            of CallNode:
                arity*: int8
            else:
                discard

        value*: Value
        flags*: NodeFlags
        parent*: Node
        children*: NodeArray

    NodeObj = typeof(Node()[])

# Benchmarking
{.hints: on.} # Apparently we cannot disable just `Name` hints?
{.hint: "Node's inner type is currently " & $sizeof(NodeObj) & ".".}
{.hints: off.}
        

var
    TmpArities : Table[string,int8]
    ArrowBlock : ValueArray
    OldChild  : Node
    OldParent : Node

proc dumpNode*(node: Node, level = 0): string

func addChild*(node: Node, child: Node) =
    node.children.add(child)
    child.parent = node

func addChildren*(node: Node, children: NodeArray) =
    for child in children:
        node.addChild(child)

proc processBlock*(root: Node, blok: Value, start = 0, processingArrow: static bool = false): int =
    var i: int = start
    var nLen: int = blok.a.len

    var current = root

    proc addCall(target: var Node, val: Value, arity: int8, flags: NodeFlags = {}) =
        target.addChild(
            Node(
                kind: CallNode, 
                value: val,
                arity: arity,
                flags: flags
            )
        )
        target = target.children[^1]

    template isSymbol(val: Value, sym: VSymbol): bool =
        val.kind == Symbol and val.m == sym

    template rewindCallBranches(target: var Node, uptostore=false): untyped =
        while target.kind==CallNode and target.children.len == target.arity and (when uptostore: StoreSymbol notin target.flags else: true):
            target = target.parent

    template addPotentialInfixCall(target: var Node): untyped =
        if i < nLen - 1:
            let nextNode {.cursor.} = blok.a[i+1]
            if nextNode.kind == Symbol:

                if (let aliased = Aliases.getOrDefault(nextNode.m, NoAliasBinding); aliased != NoAliasBinding):
                    var symfunc {.cursor.} = GetSym(aliased.name.s)

                    if symfunc.kind==Function and aliased.precedence==InfixPrecedence:
                        when processingArrow:
                            ArrowBlock.add(nextNode)
                        i += 1
                        target.addCall(newString(aliased.name.s), symfunc.arity)

    proc addTerminal(target: var Node, val: Value, flags: NodeFlags = {}) =
        with target:
            rewindCallBranches()

            addPotentialInfixCall()

            addChild(
                Node(
                    kind: TerminalNode, 
                    value: val, 
                    flags: flags
                )
            )

            rewindCallBranches()

    template addPotentialTrailingPipe(target: var Node): untyped =
        var added = false
        if i < nLen - 1:
            var nextNode {.cursor.} = blok.a[i+1]
            if nextNode.kind == Word and GetSym(nextNode.s).kind == Function:
                if (let funcArity = TmpArities.getOrDefault(nextNode.s, -1); funcArity != -1):
                    i += 1
                    target.rewindCallBranches()

                    var lastChild = target.children[^1]
                    if StoreSymbol in lastChild.flags:
                        lastChild = lastChild.children[^1]
                        target = lastChild.parent   
                    
                    target.children.delete(target.children.len-1)

                    target.addCall(nextNode, funcArity)
                    target.addChild(lastChild)

                    target.rewindCallBranches()
                    
                    added = true

        if not added:
            target.addTerminal(newSymbol(pipe))

    proc addInline(target: var Node, val: Value, flags: NodeFlags = {}) =
        var subNode = Node(kind: RootNode)
        discard subNode.processBlock(val)

        with target:
            rewindCallBranches()

            addPotentialInfixCall()

            addChildren(subNode.children)
            
            rewindCallBranches()

    proc addArrowBlock(target: var Node, val: Value, flags: NodeFlags = {}) =
        var subNode = Node(kind: RootNode)
        i = subNode.processBlock(val, start=i+1, processingArrow=true)

        target.addTerminal(newBlock(ArrowBlock))

        ArrowBlock.setLen(0)

    proc addThickArrowBlocks(target: var Node) =
        # get next node
        let subnode {.cursor.} = blok.a[i+1]

        # we'll want to create the two blocks, 
        # for functions like loop, map, select, filter
        # so let's get them ready
        var argblock, subblock: ValueArray

        # if it's a word
        if subnode.kind==Word:
            subblock = @[subnode]
            # check if it's a function
            if (let funcArity = TmpArities.getOrDefault(subnode.s, -1); funcArity != -1):
                # automatically "push" all its required arguments
                for j in 0..(funcArity-1):
                    let arg = newWord("_" & $(j))
                    argblock.add(arg)
                    subblock.add(arg)

        elif subnode.kind==Block:
            # replace ampersand symbols, 
            # sequentially, with arguments
            var idx = 0
            var fnd: int8 = 0
            while idx<subnode.a.len:
                if (subnode.a[idx]).isSymbol(ampersand):
                    let arg = newWord("_" & $(fnd))
                    argblock.add(arg)
                    subblock.add(arg)
                else:
                    subblock.add(subnode.a[idx])
                idx += 1

        if argblock.len == 1:
            target.addTerminal(newLiteral(argblock[0].s))
        else:
            target.addTerminal(newBlock(argblock))

        target.addTerminal(newBlock(subblock))

    while i < nLen:
        let item = blok.a[i]

        when processingArrow:
            ArrowBlock.add(item)

        case item.kind:

            of Word:
                var funcArity = TmpArities.getOrDefault(item.s, -1)
                if funcArity != -1:
                    current.addCall(item, funcArity)
                else:
                    if item.s == "true":
                        current.addTerminal(VTRUE)
                    elif item.s == "false":
                        current.addTerminal(VFALSE)
                    else:
                        current.addTerminal(item, flags={Variable})

            of Label, PathLabel:
                current.addCall(item, 1, flags={StoreSymbol})

            of Inline:
                current.addInline(item)

            of Symbol:
                case item.m:
                    of doublecolon      :
                        inc(i)
                        var subblock: ValueArray
                        while i < nLen:
                            subblock.add(blok.a[i])
                            inc(i)
                        
                        current.addTerminal(newBlock(subblock))
                            
                    of arrowright       : 
                        current.addArrowBlock(blok)

                    of thickarrowright  :
                        current.addThickArrowBlocks()

                    of pipe             :
                        echo "found pipe!"
                        current.addPotentialTrailingPipe()

                    else:
                        let symalias = item.m
                        let aliased = Aliases.getOrDefault(symalias, NoAliasBinding)
                        if likely(aliased != NoAliasBinding):
                            var symfunc {.cursor.} = GetSym(aliased.name.s)
                            if symfunc.kind==Function:
                                current.addCall(newString(aliased.name.s), symfunc.arity)
                            else: 
                                if aliased.name.s == "null":
                                    current.addTerminal(VNULL)
                                else:
                                    current.addTerminal(newString(aliased.name.s), flags={Variable})
                        else:
                            current.addTerminal(item)

            of Newline:
                discard

            else:
                current.addTerminal(item)

        i += 1

        when processingArrow:
            if current.kind == RootNode:
                break

    return i-1

proc dumpNode*(node: Node, level = 0): string =
    template indentNode(): untyped =
        var j = 0
        while j < level:
            result &= "     "
            j += 1

    let sep = "     "
    case node.kind:
        of RootNode:
            indentNode()
            result &= "ROOT\n"
            for child in node.children:
                result &= dumpNode(child, level+1)
        of TerminalNode:
            indentNode()
            result &= "Constant: " & $(node.value)
        of CallNode:
            indentNode()
            if StoreSymbol in node.flags:
                result &= "Store: " & $(node.value) & "\n"
            else:
                result &= "Call: " & node.value.s & " <" & $node.arity & ">\n"
            for child in node.children:
                result &= dumpNode(child, level+1)

    result &= "\n"

proc generateAst*(parsed: Value): Node =
    result = Node(kind: RootNode)

    TmpArities = collect:
        for k,v in Syms.pairs:
            if v.kind == Function:
                {k: v.arity}

    discard result.processBlock(parsed)

    echo dumpNode(result)