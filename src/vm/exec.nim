######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/exec.nim
######################################################

#=======================================
# Libraries
#=======================================

import hashes, math, tables

when defined(VERBOSE):
    import strformat
    import helpers/debug

import vm/[bytecode, errors, eval, globals, parse, stack, values/logic, values/value]

#=======================================
# Variables
#=======================================

var
    Memoizer*  = initOrderedTable[Hash,Value]()
    CurrentDump*: Translation = NoTranslation

#=======================================
# Forward Declarations
#=======================================

proc doExec*(input:Translation, depth: int = 0, args: ValueArray = NoValues): ValueDict

#=======================================
# Helpers
#=======================================

template pushByIndex(idx: int):untyped =
    stack.push(cnst[idx])

template storeByIndex(idx: int):untyped =
    let symIndx = cnst[idx].s
    Syms[symIndx] = stack.pop()
    if Syms[symIndx].kind==Function:
        let fun = Syms[symIndx]
        if fun.fnKind==BuiltinFunction:
            Arities[symIndx] = fun.arity
        else:
            Arities[symIndx] = fun.params.a.len

template loadByIndex(idx: int):untyped =
    let symIndx = cnst[idx].s
    let item = GetSym(symIndx)
    stack.push(item)

template callFunction*(f: Value):untyped =
    if f.fnKind==UserFunction:
        var memoized: Value = VNULL
        if f.memoize: memoized = f
        discard execBlock(f.main, args=f.params.a, isFuncBlock=true, imports=f.imports, exports=f.exports, exportable=f.exportable, memoized=memoized)
    else:
        f.action()

template callByName*(symIndx: string):untyped =
    let fun = GetSym(symIndx)
    callFunction(fun)

template callByIndex(idx: int):untyped =
    let symIndx = cnst[idx].s
    callByName(symIndx)

template fetchAttributeByIndex(idx: int):untyped =
    let attr = cnst[idx]
    let val = stack.pop()

    stack.pushAttr(attr.r, val)

####

template execIsolated*(evaled:Translation): untyped =
    doExec(evaled, 1, NoValues)

template getMemoized*(v: Value): Value =
    Memoizer.getOrDefault(hash(v), VNULL)

template setMemoized*(v: Value, res: Value) =
    Memoizer[hash(v)] = res

proc execBlock*(
    blk             : Value, 
    dictionary      : bool = false, 
    args            : ValueArray = NoValues, 
    evaluated       : Translation = NoTranslation, 
    execInParent    : bool = false, 
    isFuncBlock     : bool = false, 
    imports         : Value = nil,
    exports         : Value = nil,
    exportable      : bool = false,
    inTryBlock      : bool = false,
    memoized        : Value = VNULL
): ValueDict =
    var newSyms: ValueDict
    let savedArities = Arities
    var savedSyms: OrderedTable[string,Value]
    
    var passedParams: Value = newBlock(@[])

    Arities = savedArities
    try:
        if isFuncBlock:
            if memoized != VNULL:
                passedParams.a.add(memoized)
                for i,arg in args:
                    passedParams.a.add(stack.peek(i))

                if (let memd = getMemoized(passedParams); memd != VNULL):            
                    popN args.len
                    push memd
                    return Syms
            else:
                for i,arg in args:          
                    if stack.peek(i).kind==Function:
                        Arities[arg.s] = stack.peek(i).params.a.len
                    else:
                        if Arities.hasKey(arg.s):
                            Arities.del(arg.s)

            if imports!=VNULL:
                savedSyms = Syms
                for k,v in pairs(imports.d):
                    Syms[k] = v

        let evaled = 
            if evaluated==NoTranslation : 
                if dictionary       : doEval(blk, isDictionary=true)
                else                : doEval(blk)
            else                        : evaluated

        newSyms = doExec(evaled, 1, args)

    except ReturnTriggered as e:
        if not isFuncBlock:
            raise e
        else:
            discard
        
    finally:
        if dictionary:
            var res: ValueDict = initOrderedTable[string,Value]()
            for k, v in pairs(newSyms):
                if not Syms.hasKey(k) or (newSyms[k]!=Syms[k]):
                    res[k] = v

            return res
        else:
            if isFuncBlock:
                if memoized!=VNULL:
                    setMemoized(passedParams, stack.peek(0))

                if imports!=VNULL:
                    Syms = savedSyms

                Arities = savedArities
                if not exports.isNil():
                    if exportable:
                        Syms = newSyms
                    else:
                        for k in exports.a:
                            if newSyms.hasKey(k.s):
                                Syms[k.s] = newSyms[k.s]
                else:
                    # for k, v in pairs(newSyms):
                    #     if v.kind==Function and Syms.hasKey(k):
                    #         if Syms[k].kind==Function:
                    #             Arities[k]=getArity(Syms[k])
                    #         else:
                    #             Arities.del(k)

                    for arg in args:
                        Arities.del(arg.s)

            else:
                if not inTryBlock or (inTryBlock and getCurrentException().isNil()):
                    if execInParent:
                        Syms=newSyms
                    else:
                        Arities = savedArities
                        for k, v in pairs(newSyms):
                            if not (v.kind==Function and v.fnKind==BuiltinFunction):
                                if Syms.hasKey(k):# and Syms[k]!=newSyms[k]:
                                    Syms[k] = newSyms[k]

    return Syms

template execInternal*(path: string): untyped =
    discard execBlock(
        doParse(
            static readFile(
                normalizedPath(
                    parentDir(currentSourcePath()) & "/../library/internal/" & path & ".art"
                )
            ),
            isFile = false
        ),
        execInParent = true
    )

template callInternal*(fname: string, getValue: bool, args: varargs[Value]): untyped =
    let fun = Syms[fname]
    for v in args.reversed:
        push(v)

    callFunction(fun)

    when getValue:
        pop()

template handleBranching*(tryDoing, finalize: untyped): untyped =
    try:
        tryDoing
    except BreakTriggered:
        return
    except ContinueTriggered:
        discard
    except Defect as e:
        raise e 
    finally:
        finalize

#=======================================
# Methods
#=======================================

# proc printSyms*(vv:ValueDict, message: string)=
#     echo "============================"
#     echo message
#     echo "============================"
#     for k,v in pairs(vv):
#         if k!="path" and k!="arg" and k!="sys" and k!="null" and k!="true" and k!="false" and k!="pi" and not (v.kind==Function and v.fnKind==BuiltinFunction):
#             echo k & " => " & $(v)
#     echo "----------------------------"

proc doExec*(input:Translation, depth: int = 0, args: ValueArray = NoValues): ValueDict = 
    when defined(VERBOSE):
        if depth==0:
            showDebugHeader("VM")

    #if DoDebug:
    #    ConstStack = input[0]

    let cnst = input[0]
    let it = input[1]

    var i = 0
    var op: OpCode
    var oldSyms: ValueDict

    oldSyms = Syms

    if args!=NoValues:
        for arg in args:
            let symIndx = arg.s

            # pop argument and set it
            Syms[symIndx] = stack.pop()

    when not defined(PORTABLE):
        if DoDebug: 
            ExecStack.add(CurrentLine)
            CurrentDump = (input[0], input[1])

    while true:
        # if vmBreak:
        #     break

        op = (OpCode)(it[i])

        # if DoDebug:
        #     OpStack.rotateLeft(1)
        #     OpStack[0] = op

        when defined(VERBOSE):
            echo "exec: " & $(op)

        case op:
            # [0x00-0x0F]
            # push constants 
            of opConstI0        : stack.push(I0)
            of opConstI1        : stack.push(I1)
            of opConstI2        : stack.push(I2)
            of opConstI3        : stack.push(I3)
            of opConstI4        : stack.push(I4)
            of opConstI5        : stack.push(I5)
            of opConstI6        : stack.push(I6)
            of opConstI7        : stack.push(I7)
            of opConstI8        : stack.push(I8)
            of opConstI9        : stack.push(I9)
            of opConstI10       : stack.push(I10)

            of opConstF1        : stack.push(F1)

            of opConstBT        : stack.push(VTRUE)
            of opConstBF        : stack.push(VFALSE)
            of opConstBM        : stack.push(VMAYBE)

            of opConstN         : stack.push(VNULL)

            # [0x10-0x2F]
            # push values
            of opPush0..opPush29    : pushByIndex((int)(op)-(int)(opPush0))
            of opPush               : i += 1; pushByIndex((int)(it[i]))
            of opPushX              : i += 2; pushByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

            # [0x30-0x4F]
            # store variables (from <- stack)
            of opStore0..opStore29  : storeByIndex((int)(op)-(int)(opStore0))
            of opStore              : i += 1; storeByIndex((int)(it[i]))   
            of opStoreX             : i += 2; storeByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i])))              

            # [0x50-0x6F]
            # load variables (to -> stack)
            of opLoad0..opLoad29    : loadByIndex((int)(op)-(int)(opLoad0))
            of opLoad               : i += 1; loadByIndex((int)(it[i]))
            of opLoadX              : i += 2; loadByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

            # [0x70-0x8F]
            # function calls
            of opCall0..opCall29    : callByIndex((int)(op)-(int)(opCall0))                
            of opCall               : i += 1; callByIndex((int)(it[i]))
            of opCallX              : i += 2; callByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

            # [0x90-9F] #
            # generators
            of opAttr               : i += 1; fetchAttributeByIndex((int)(it[i]))            
            of opArray, opDict,
               opFunc               : discard

            # stack operations
            of opPop                : discard stack.pop()
            of opDup                : stack.push(sTop())
            of opSwap               : swap(Stack[SP-1], Stack[SP-2])

            # flow control
            of opJump               : 
                i = (int)(it[i+1])-1
            of opJumpIf             : 
                if stack.pop().b==True: 
                    i = (int)(it[i+1])-1
            of opJumpIfNot          : 
                if Not(stack.pop().b)==True: 
                    i = (int)(it[i+1])-1
            of opRet                : discard    
            of opEnd                : break 

            of opNop                : discard

            of opEol                :
                when not defined(NOERRORLINES):
                    i += 2
                    CurrentLine = (int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))
                else:
                    discard

            # reserved
            of opRsrv1..opRsrv2     : discard

            # [0xA0-AF] #
            # arithmetic & logical operators
            of opIAdd               : stack.push(newInteger(Stack[SP-1].i + Stack[SP-2].i))
            of opISub               : stack.push(newInteger(Stack[SP-1].i - Stack[SP-2].i))
            of opIMul               : stack.push(newInteger(Stack[SP-1].i * Stack[SP-2].i))
            of opIDiv               : stack.push(newInteger(Stack[SP-1].i div Stack[SP-2].i))
        
            of opIFDiv              : discard
            of opIMod               : stack.push(newInteger(Stack[SP-1].i mod Stack[SP-2].i))
            of opIPow               : stack.push(newInteger((Stack[SP-1].i)^(Stack[SP-2].i)))

            of opINeg, opBNot, 
               opBAnd, opOr, opXor, 
               opShl, opShr         : discard

            # reserved
            of opRsrv3..opRsrv4     : discard

            # TODO(VM\exec) re-add missing bytecode opCodes in main loop
            #  labels: execution,vm,enhancement,cleanup
            # [0xB0-BF] #
            # comparison operators
            of opEq                 : stack.push(newLogical(Stack[SP-1]==Stack[SP-2]))
            of opNe                 : stack.push(newLogical(Stack[SP-1]!=Stack[SP-2]))
            of opGt                 : stack.push(newLogical(Stack[SP-1]>Stack[SP-2]))
            of opGe                 : stack.push(newLogical(Stack[SP-1]>=Stack[SP-2]))
            of opLt                 : stack.push(newLogical(Stack[SP-1]<Stack[SP-2]))
            of opLe                 : stack.push(newLogical(Stack[SP-1]<=Stack[SP-2]))

        i += 1

    when defined(VERBOSE):
        if depth==0:
            showDebugHeader("Constants")

            for j, cn in cnst:
                stdout.write fmt("{j}: ")
                cn.dump(0,false)
                
            showDebugHeader("Stack")

            i = 0
            while i < SP:
                stdout.write fmt("{i}: ")
                var item = Stack[i]

                item.dump(0, false)

                i += 1

            # showDebugHeader("Symbols")
            # for k,v in Syms:
            #     stdout.write fmt("{k} => ")
            #     v.dump(0, false)

    let newSyms = Syms
    Syms = oldSyms

    when not defined(PORTABLE):
        if DoDebug: discard ExecStack.pop()

    return newSyms