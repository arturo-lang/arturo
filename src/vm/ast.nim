import algorithm, hashes, sequtils
import sugar, tables, unicode

import vm/[bytecode, globals, values/value]

type
    # abstract syntax tree definition
    NodeKind* = enum
        RootNode,
        IdentifierNode,
        ConstantNode,
        CallNode,
        BuiltinNode

    CallNodeKind* = enum
        AddCall,
        SubCall,
        OtherCall

    NodeArray* = seq[Node]

    Node* = ref object
        case kind*: NodeKind:
            of CallNode:
                name*: string
                arity*: int8
                cKind*: CallNodeKind
            else:
                discard
        parent*: Node
        children*: NodeArray
        value*: Value

var
    TmpArities : Table[string,int8]

func addChild*(node: Node, child: Node) =
    node.children.add(child)
    child.parent = node

func addChildren*(node: Node, children: NodeArray) =
    for child in children:
        node.addChild(child)

func addTerminalValue*(target: var Node, val: Node) =
    while target.kind==CallNode and target.children.len == target.arity:
        target = target.parent

    target.addChild(val)

    while target.kind==CallNode and target.children.len == target.arity:
        target = target.parent

func addFunctionCall*(target: var Node, name: string, arity: int8) =
    target.addChild(Node(kind: CallNode, name: name, arity: arity))
    target = target.children[^1]

proc processBlock*(root: Node, blok: Value) =
    var i: int = 0
    var nLen: int = blok.a.len

    var currentNode: Node = root

    while i < nLen:
        let node {.cursor.} = blok.a[i]

        case node.kind:

            of Integer, Floating, String:
                currentNode.addTerminalValue(Node(kind: ConstantNode, value: node))

            of Word:
                var funcArity = TmpArities.getOrDefault(node.s, -1)
                if funcArity != -1:
                    currentNode.addFunctionCall(node.s, funcArity)
                else:
                    if node.s == "true":
                        currentNode.addTerminalValue(Node(kind: ConstantNode, value: VTRUE))
                    elif node.s == "false":
                        currentNode.addTerminalValue(Node(kind: ConstantNode, value: VFALSE))
                    else:
                        currentNode.addTerminalValue(Node(kind: IdentifierNode, value: node))

            else:
                discard

        i += 1

proc dumpNode*(node: Node, level = 0): string =
    echo "in dumpNode"
    let sep = "     "
    case node.kind:
        of RootNode:
            var j = 0
            while j < level:
                result &= sep
                j += 1
            result &= "ROOT\n"
            for child in node.children:
                result &= dumpNode(child, level+1)
        of IdentifierNode:
            var j = 0
            while j < level:
                result &= sep
                j += 1
            result &= "IdentifierNode: " & node.value.s
        of ConstantNode:
            var j = 0
            while j < level:
                result &= sep
                j += 1
            result &= "Constant: " & $(node.value.kind)
        of CallNode:
            var j = 0
            while j < level:
                result &= sep
                j += 1
            result &= "Call: " & node.name & " (" & $node.arity & ")\n"
            for child in node.children:
                result &= dumpNode(child, level+1)
        of BuiltinNode:
            result &= "BuiltinNode: " & node.name

    result &= "\n"

proc generateAst*(parsed: Value): Node =
    result = Node(kind: RootNode)

    TmpArities = collect:
        for k,v in Syms.pairs:
            if v.kind == Function:
                {k: v.arity}

    result.processBlock(parsed)

    echo dumpNode(result)