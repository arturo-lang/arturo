import hashes, strutils, sugar
import tables, unicode, std/with

import vm/[globals, values/value, values/types]
import vm/values/printable
import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vrational, vsymbol, vversion]

type
    # abstract syntax tree definition
    NodeKind* = enum
        RootNode            # Root node of the AST
        
        # TerminalNode
        ConstantValue       # Terminal node of the AST containing a value
        VariableLoad        # Load a variable

        # CallNode
        VariableStore       # Store a variable

        ArrayCall           # Opcode'd built-ins     
        DictCall
        FuncCall
        AddCall
        SubCall
        MulCall
        DivCall
        FdivCall
        ModCall
        PowCall
        NegCall
        BNotCall
        BAndCall
        BOrCall
        ShlCall
        ShrCall
        NotCall
        AndCall
        OrCall
        EqCall
        NeCall
        GtCall
        GeCall
        LtCall
        LeCall
        IfCall
        IfECall
        UnlessCall
        ElseCall
        SwitchCall
        WhileCall
        ReturnCall
        ToCall
        PrintCall
        GetCall
        SetCall
        RangeCall
        LoopCall
        MapCall
        SelectCall
        SizeCall
        ReplaceCall
        SplitCall
        JoinCall
        ReverseCall
        IncCall
        DecCall

        OtherCall           # Call to a function that is not a builtin

    NodeArray* = seq[Node]

    Node* = ref object
        case kind*: NodeKind:
            of RootNode, ConstantValue, VariableLoad:
                discard
            else:
                arity*: int8
                
        value*: Value
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

const
    TerminalNode    : set[NodeKind] = {ConstantValue, VariableLoad}
    CallNode        : set[NodeKind] = {VariableStore..OtherCall}

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

    proc addCall(target: var Node, name: string, arity: int8 = -1, fun: Value = nil) =
        var callType: ArrayCall..OtherCall = OtherCall

        var fn {.cursor.}: Value =
            if fun.isNil:
                GetSym(name)
            else:
                fun

        var ar: int8 =
            if arity == -1:
                fn.arity
            else:
                arity

        if fn == ArrayF     : callType = ArrayCall
        elif fn == DictF    : callType = DictCall 
        elif fn == FuncF    : callType = FuncCall
        elif fn == AddF     : callType = AddCall
        elif fn == SubF     : callType = SubCall
        elif fn == MulF     : callType = MulCall
        elif fn == DivF     : callType = DivCall
        elif fn == FdivF    : callType = FdivCall
        elif fn == ModF     : callType = ModCall
        elif fn == PowF     : callType = PowCall
        elif fn == NegF     : callType = NegCall
        elif fn == BNotF    : callType = BNotCall
        elif fn == BAndF    : callType = BAndCall
        elif fn == BOrF     : callType = BOrCall
        elif fn == ShlF     : callType = ShlCall
        elif fn == ShrF     : callType = ShrCall
        elif fn == NotF     : callType = NotCall
        elif fn == AndF     : callType = AndCall
        elif fn == OrF      : callType = OrCall
        elif fn == EqF      : callType = EqCall
        elif fn == NeF      : callType = NeCall
        elif fn == GtF      : callType = GtCall
        elif fn == GeF      : callType = GeCall
        elif fn == LtF      : callType = LtCall
        elif fn == LeF      : callType = LeCall
        elif fn == IfF      : callType = IfCall
        elif fn == IfEF     : callType = IfECall
        elif fn == UnlessF  : callType = UnlessCall
        elif fn == ElseF    : callType = ElseCall
        elif fn == SwitchF  : callType = SwitchCall
        elif fn == WhileF   : callType = WhileCall
        elif fn == ReturnF  : callType = ReturnCall
        elif fn == ToF      : callType = ToCall
        elif fn == PrintF   : callType = PrintCall
        elif fn == GetF     : callType = GetCall
        elif fn == SetF     : callType = SetCall
        elif fn == RangeF   : callType = RangeCall
        elif fn == LoopF    : callType = LoopCall
        elif fn == MapF     : callType = MapCall
        elif fn == SelectF  : callType = SelectCall
        elif fn == SizeF    : callType = SizeCall
        elif fn == ReplaceF : callType = ReplaceCall
        elif fn == SplitF   : callType = SplitCall
        elif fn == JoinF    : callType = JoinCall
        elif fn == ReverseF : callType = ReverseCall
        elif fn == IncF     : callType = IncCall
        elif fn == DecF     : callType = DecCall

        var v: Value =
            if callType == OtherCall: 
                newString(name)
            else:
                nil

        target.addChild(
            Node(
                kind: callType, 
                value: v,
                arity: ar
            )
        )
        
        target = target.children[^1]

    proc addStore(target: var Node, val: Value) =
        target.addChild(
            Node(
                kind: VariableStore, 
                value: val,
                arity: 1
            )
        )
        target = target.children[^1]

    template isSymbol(val: Value, sym: VSymbol): bool =
        val.kind == Symbol and val.m == sym

    template rewindCallBranches(target: var Node): untyped =
        while target.kind in CallNode and target.children.len == target.arity:
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
                        target.addCall(aliased.name.s, fun=symfunc)

    proc addTerminal(target: var Node, val: Value, ofType: NodeKind = ConstantValue) =
        with target:
            rewindCallBranches()

            addPotentialInfixCall()

            addChild(
                Node(
                    kind: ofType, 
                    value: val
                )
            )

            rewindCallBranches()

    template addPotentialTrailingPipe(target: var Node): untyped =
        var added = false
        if i < nLen - 1:
            var nextNode {.cursor.} = blok.a[i+1]
            if nextNode.kind == Word:
                if (let funcArity = TmpArities.getOrDefault(nextNode.s, -1); funcArity != -1):
                    i += 1
                    target.rewindCallBranches()

                    var lastChild = target.children[^1]
                    if lastChild.kind == VariableStore:
                        lastChild = lastChild.children[^1]
                        target = lastChild.parent   
                    
                    target.children.delete(target.children.len-1)

                    target.addCall(nextNode.s, funcArity)
                    target.addChild(lastChild)

                    target.rewindCallBranches()
                    
                    added = true

        if not added:
            target.addTerminal(newSymbol(pipe))

    proc addInline(target: var Node, val: Value) =
        var subNode = Node(kind: RootNode)
        discard subNode.processBlock(val)

        with target:
            rewindCallBranches()

            addPotentialInfixCall()

            addChildren(subNode.children)
            
            rewindCallBranches()

    proc addArrowBlock(target: var Node, val: Value) =
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
                    current.addCall(item.s, funcArity)
                else:
                    if item.s == "true":
                        current.addTerminal(VTRUE)
                    elif item.s == "false":
                        current.addTerminal(VFALSE)
                    else:
                        current.addTerminal(item, ofType=VariableLoad)

            of Label, PathLabel:
                current.addStore(item)

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
                        current.addPotentialTrailingPipe()

                    else:
                        let symalias = item.m
                        let aliased = Aliases.getOrDefault(symalias, NoAliasBinding)
                        if likely(aliased != NoAliasBinding):
                            var symfunc {.cursor.} = GetSym(aliased.name.s)
                            if symfunc.kind==Function:
                                current.addCall(aliased.name.s, fun=symfunc)
                            else: 
                                if aliased.name.s == "null":
                                    current.addTerminal(VNULL)
                                else:
                                    current.addTerminal(newString(aliased.name.s), ofType=VariableLoad)
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
            if node.kind == VariableStore:
                result &= "Store: " & $(node.value) & "\n"
            else:
                if node.value.isNil:
                    result &= "Call: " & ($node.kind).replace("Call","").toLowerAscii() & " <" & $node.arity & ">\n"
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