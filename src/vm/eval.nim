######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/eval.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, strformat, strutils, tables

import helpers/debug as DebugHelper

import vm/[bytecode, globals, value]

#=======================================
# Forward Declarations
#=======================================

proc dump*(evaled: Translation)

#=======================================
# Methods
#=======================================

proc evalOne(n: Value, consts: var ValueArray, it: var ByteArray, inBlock: bool = false, isDictionary: bool = false) =
    var argStack: seq[int] = @[]
    var currentCommand: ByteArray = @[]
    #var itIndex = 0

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
        var indx = consts.indexOfValue(v)
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

                let symalias = n.a[i+1].m
                if Aliases.hasKey(symalias):
                    let symfunc = Syms[Aliases[symalias].name.s]

                    if symfunc.kind==Function and Aliases[symalias].precedence==InfixPrecedence:
                        i += step;
                        
                        #echo "found infix alias: " & $(n.a[i])
                        if symfunc.arity!=0:
                            addConst(consts, Aliases[symalias].name, opCallX)
                            argStack.add(symfunc.arity)

                        when inArrowBlock: ret.add(n.a[i])
                

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

            # TO-FIX
            # ## Process trailing pipe            
            # if (i+1<childrenCount and n.a[i+1].kind == Symbol and n.a[i+1].m == pipe):
                
            #     if (i+2<childrenCount and n.a[i+2].kind == Word):
            #         if argStack.len != 0: argStack[^1] -= 1
            #         var found = false
            #         for indx,spec in OpSpecs:
            #             if spec.name == n.a[i+2].s:
            #                 found = true
            #                 if (((currentCommand[0])>=(byte)(opStore0)) and ((currentCommand[0])<=(byte)(opStoreY))):
            #                     currentCommand.insert((byte)indx, 1)
            #                 else:
            #                     currentCommand.insert((byte)indx)
            #                 argStack.add(OpSpecs[indx].args-1)
            #                 break
            #         i += 2
            #     else:
            #         echo "found trailing pipe without adjunct command. exiting"
            #         quit()

    # template addCommand(op: OpCode, inArrowBlock: bool = false): untyped =
    #     when static OpSpecs[op].args!=0:
    #         when not inArrowBlock:
    #             addToCommand((byte)op)
    #             argStack.add(static OpSpecs[op].args)
    #         else:
    #             subargStack.add(static OpSpecs[op].args)
    #     else:
    #         when not inArrowBlock:
    #             addTerminalValue(false):
    #                 addToCommand((byte)op)
    #         else:
    #             addTerminalValue(true):
    #                 discard

    # template addExtraCommand(op: OpCode, inArrowBlock: bool = false): untyped =
    #     when static OpSpecs[op].args!=0:
    #         when not inArrowBlock:
    #             addToCommand((byte)((int)(op)-(int)(opExtra)))
    #             addToCommand((byte)opExtra)
    #             argStack.add(static OpSpecs[op].args)
    #         else:
    #             subargStack.add(static OpSpecs[op].args)
    #     else:
    #         when not inArrowBlock:
    #             addTerminalValue(false):
    #                 addToCommand((byte)((int)(op)-(int)(opExtra)))
    #                 addToCommand((byte)opExtra)
    #         else:
    #             addTerminalValue(true):
    #                 discard

    # template addPartial(op: OpCode): untyped =
    #     ret.add(newSymbol(ampersand))
    #     swap(ret[^1],ret[^2])
    #     subargStack.add(static OpSpecs[op].args-1)

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
                    if Arities.hasKey(subnode.s):
                        let funcArity = Arities[subnode.s]
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
                                if symfunc.arity!=0:
                                    subargStack.add(symfunc.arity)
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
                    #discard
                    # case subnode.m:
                    #     of plus             : addPartial(opAdd)       # +
                    #     of minus            : addPartial(opSub)       # -   
                    #     of asterisk         : addPartial(opMul)
                    #     of slash            : addPartial(opDiv)       # /
                    #     of doubleslash      : addPartial(opFDiv)      # //
                    #     of percent          : addPartial(opMod)       # %
                    #     of caret            : addPartial(opPow)       # ^
                    #     of equal            : addPartial(opEq)        # =
                    #     of lessgreater      : addPartial(opNe)        # <>
                    #     of greaterthan      : addPartial(opGt)        # >
                    #     of greaterequal     : addPartial(opGe)        # >=
                    #     of lessthan         : addPartial(opLt)        # <
                    #     of equalless        : addPartial(opLe)        # =<
                    #     of ellipsis         : addPartial(opRange)     # ..
                    #     of backslash        : addPartial(opGet)
                    #     of doubleplus       : addPartial(opAppend)    # ++
                    #     of doubleminus      : addPartial(opRemove)    # --
                    #     of colon            : addPartial(opLet)       # :

                    #     of tilde            : 
                    #         subargStack.add(OpSpecs[opRender].args)#addCommand(opRender, inArrowBlock=true)
                    #     of at               : addCommand(opArray, inArrowBlock=true)
                    #     of sharp            : addCommand(opDictionary, inArrowBlock=true)
                    #     of dollar           : addCommand(opFunction, inArrowBlock=true)
                    #     of ampersand        : addCommand(opPush, inArrowBlock=true) 
                    #     of dotslash         : addCommand(opRelative, inArrowBlock=true)
                    #     of doublearrowright : addCommand(opWrite, inArrowBlock=true)   
                    #     of doublearrowleft  : addCommand(opRead, inArrowBlock=true) 

                    #     else:
                    #         addTerminalValue(true):
                    #             discard
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
                if Arities.hasKey(node.s):
                    let funcArity = Arities[node.s]
                    if funcArity!=0:
                        addConst(consts, node, opCallX)
                        argStack.add(funcArity)
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
                let funcIndx = node.s
                if (n.a[i+1].kind == Word and n.a[i+1].s == "function") or
                   (n.a[i+1].kind == Symbol and n.a[i+1].m == dollar):
                    Arities[funcIndx] = n.a[i+2].a.len
                    #echo "LABEL: create user function: " & node.s & " with arity: " & $(Arities[funcIndx])
                else:
                    if not isDictionary:
                        #echo "NOT-A-LABEL: delete function: " & node.s & " from index (if exists)"
                        Arities.del(funcIndx)
                    #echo "here"

                #echo "adding const"
                addConst(consts, node, opStoreX)
                #echo "adding to argStack"
                argStack.add(1)
                #echo "done"

            of Attribute:
                addAttr(consts, node)
                addToCommand((byte)opBPushT)

            of AttributeLabel:
                addAttr(consts, node)
                argStack[argStack.len-1] += 1

            of Path:
                addTerminalValue(false):
                    addConst(consts, newWord("get"), opCallX)
                    argStack.add(Arities["get"])

                    var i=1
                    while i<node.p.len-1:
                        addConst(consts, newWord("get"), opCallX)
                        argStack.add(Arities["get"])
                        i += 1
                    
                    # let opName = "op" & node.p[0].s.capitalizeAscii()
                    # try:
                    #     let op = parseEnum[OpCode](opName)
                    #     addToCommand((byte)op)
                    # except:
                    addConst(consts, node.p[0], opLoadX)

                    i = 1
                    while i<node.p.len:
                        addConst(consts, node.p[i], opPushX)
                        i += 1

            of PathLabel:
                addConst(consts, newWord("set"), opCallX)
                argStack.add(Arities["set"])
                    
                var i=1
                while i<node.p.len-1:
                    addConst(consts, newWord("get"), opCallX)
                    argStack.add(Arities["get"])
                    i += 1
                
                addConst(consts, node.p[0], opLoadX)
                i = 1
                while i<node.p.len:
                    addConst(consts, node.p[i], opPushX)
                    i += 1

                argStack.add(1)

            of Symbol: 
                case node.m:
                    of arrowright       : 
                        var subargStack: seq[int] = @[]
                        var ended = false
                        var ret: seq[Value] = @[]

                        let subblock = processNextCommand()
                        addTerminalValue(false):
                            addConst(consts, newBlock(subblock), opPushX)

                    of thickarrowright  : 
                        discard
                        # # get next node
                        # let subnode = n.a[i+1]

                        # # we'll want to create the two blocks, 
                        # # for functions like loop, map, select, filter
                        # # so let's get them ready
                        # var argblock: seq[Value] = @[]
                        # var subblock: seq[Value] = @[subnode]

                        # # is it a word?
                        # # e.g. map ["one" "two"] => upper
                        # if subnode.kind==Word:

                        #     var nofArgs = -1

                        #     var found = false
                        #     for indx,spec in OpSpecs:
                        #         if spec.name == subnode.s:
                        #             found = true
                        #             nofArgs = OpSpecs[indx].args
                        #             break

                        #     if not found:
                        #         if Arities.hasKey(subnode.s):
                        #             if Arities[subnode.s]!=0:
                        #                 nofArgs = Arities[subnode.s]
                        #                 found = true

                        #     # then let's just push its argument
                        #     # to the end
                        #     if found:
                                
                        #         for i in 0..(nofArgs-1):
                        #             let arg = newWord("arg_" & $(i))
                        #             argblock.add(arg)
                        #             subblock.add(arg)

                        # # is it an inline block?
                        # # e.g. map 1..10 => (2+_)
                        # elif subnode.kind==Inline:

                        #     # replace underscore symbols, sequentially
                        #     # with arguments
                        #     var idx = 0
                        #     while idx<subnode.a.len:
                        #         if subnode.a[idx].kind==Symbol and subnode.a[idx].m==underscore:
                        #             let arg = newWord("arg_" & $(idx))
                        #             argblock.add(arg)
                        #             subnode.a[idx] = arg
                        #         idx += 1
                        #     subblock = @[subnode]

                        # # add the blocks
                        # addTerminalValue(false):
                        #     addConst(consts, newBlock(argblock), opPushX)
                        # addTerminalValue(false):
                        #     addConst(consts, newBlock(subblock), opPushX)

                        # i += 1
                    else:
                        let symalias = node.m
                        if Aliases.hasKey(symalias):
                            let symfunc = Syms[Aliases[symalias].name.s]
                            if symfunc.kind==Function:
                                if symfunc.arity!=0:
                                    addConst(consts, Aliases[symalias].name, opCallX)
                                    argStack.add(symfunc.arity)
                                else:
                                    addTerminalValue(false):
                                        addConst(consts, Aliases[symalias].name, opCallX)
                            else:
                                addTerminalValue(false):
                                    addConst(consts, Aliases[symalias].name, opLoadX)
                        else:
                            addTerminalValue(false):
                                addConst(consts, node, opPushX)

            of Date : discard

            of Binary : discard

            of Dictionary,
               Function: discard

            of Inline: 
                addTerminalValue(false):
                    evalOne(node, consts, currentCommand, inBlock=true, isDictionary=isDictionary)

            of Block:
                addTerminalValue(false):
                    addConst(consts, node, opPushX)

            of Database: discard

            of Custom:
                addTerminalValue(false):
                    addConst(consts, node, opPushX)

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

    evalOne(root, cnsts, newit, isDictionary=isDictionary)
    newit.add((byte)opEnd)

    result = (cnsts, newit)

    when defined(VERBOSE):
        result.dump()

    result = (cnsts,newit)
        
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
            of opPushX, opStoreX, opLoadX, opCallX, opAttr:
                i += 1
                let indx = it[i]
                stdout.write fmt("\t#{indx}\n")
            # of opExtra:
            #     i += 1
            #     let extra = ($((OpCode)((int)(it[i])+(int)(opExtra)))).replace("op").toLowerAscii()
            #     stdout.write fmt("\t%{extra}\n")
            else:
                discard

        stdout.write "\n"
        i += 1
