import hashes, sugar, tables
import unicode, std/with

import vm/[globals, values/value]
import vm/values/printable
import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vrational, vversion]

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

func addChild*(node: Node, child: Node) =
    node.children.add(child)
    child.parent = node

func addChildren*(node: Node, children: NodeArray) =
    for child in children:
        node.addChild(child)

proc processBlock*(root: Node, blok: Value) =
    var i: int = 0
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

    template rewindCallBranches(target: var Node): untyped =
        while target.kind==CallNode and target.children.len == target.arity:
            target = target.parent

    template addPotentialInfixCall(target: var Node): untyped =
        if i < nLen - 1:
            let nextNode {.cursor.} = blok.a[i+1]
            if nextNode.kind == Symbol:

                if (let aliased = Aliases.getOrDefault(nextNode.m, NoAliasBinding); aliased != NoAliasBinding):
                    var symfunc {.cursor.} = GetSym(aliased.name.s)

                    if symfunc.kind==Function and aliased.precedence==InfixPrecedence:
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

    proc addInline(target: var Node, val: Value, flags: NodeFlags = {}) =
        var subNode = Node(kind: RootNode)
        subNode.processBlock(val)

        with target:
            rewindCallBranches()

            addPotentialInfixCall()

            addChildren(subNode.children)
            
            rewindCallBranches()

    while i < nLen:
        let item = blok.a[i]

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

            of Newline:
                discard

            else:
                current.addTerminal(item)

        i += 1

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

    result.processBlock(parsed)

    echo dumpNode(result)