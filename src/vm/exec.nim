######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/exec.nim
######################################################

# TODO(VM/exec) General cleanup needed
#  labels: vm, execution, enhancement, cleanup

#=======================================
# Libraries
#=======================================

import hashes, tables

when defined(VERBOSE):
    import strformat
    import helpers/debug

import vm/[
    bytecode, 
    errors, 
    eval, 
    globals, 
    parse, 
    profiler, 
    stack, 
    values/logic, 
    values/value
]

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

template storeByIndex(idx: int, doPop = true):untyped =
    let symIndx = cnst[idx].s
    when doPop:
        Syms[symIndx] = stack.pop()
    else:
        Syms[symIndx] = stack.peek(0)

    if unlikely(Syms[symIndx].kind==Function):
        let fun = Syms[symIndx]
        if fun.fnKind==BuiltinFunction:
            Arities[symIndx] = fun.arity
        else:
            Arities[symIndx] = fun.params.a.len

template loadByIndex(idx: int):untyped =
    let symIndx = cnst[idx].s
    let item = GetSym(symIndx)
    stack.push(item)

template callFunction*(f: Value, fnName: string = "<closure>"):untyped =
    if f.fnKind==UserFunction:
        var memoized: Value = VNULL
        if f.memoize: memoized = f
        let fArity = f.params.a.len
        if unlikely(SP<fArity):
            RuntimeError_NotEnoughArguments(fnName, fArity)
        discard execBlock(f.main, args=f.params.a, isFuncBlock=true, imports=f.imports, exports=f.exports, exportable=f.exportable, memoized=memoized)
    else:
        f.action()

template callByName*(symIndx: string):untyped =
    let fun = GetSym(symIndx)
    callFunction(fun, symIndx)

template callByIndex(idx: int):untyped =
    if cnst[idx].kind==Function:
        callFunction(cnst[idx])
    else:
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
            if unlikely(memoized != VNULL):
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
                        # TODO(VM/exec) Verify it's working correctly
                        #  apparently, `del` won't do anything if the key did not exist
                        #  labels: unit-test

                        Arities.del(arg.s)
                        # if Arities.hasKey(arg.s):
                        #     Arities.del(arg.s)

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
                            let newSymsKey = newSyms.getOrDefault(k.s, VNOTHING)
                            if newSymsKey != VNOTHING:
                            # if newSyms.hasKey(k.s):
                                Syms[k.s] = newSymsKey#newSyms[k.s]
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

    let cnst = input[0]
    let it = input[1]

    var i = 0
    var op {.register.}: OpCode
    var oldSyms: ValueDict

    oldSyms = Syms

    if args!=NoValues:
        for arg in args:
            let symIndx = arg.s

            # pop argument and set it
            Syms[symIndx] = stack.pop()

    while true:
        {.computedGoTo.}

        # if vmBreak:
        #     break

        op = (OpCode)(it[i])

        hookOpProfiler($(op)):

            when defined(VERBOSE):
                echo "exec: " & $(op)

            case op:
                # [0x00-0x1F]
                # push constants 
                of opConstI0            : stack.push(I0)
                of opConstI1            : stack.push(I1)
                of opConstI2            : stack.push(I2)
                of opConstI3            : stack.push(I3)
                of opConstI4            : stack.push(I4)
                of opConstI5            : stack.push(I5)
                of opConstI6            : stack.push(I6)
                of opConstI7            : stack.push(I7)
                of opConstI8            : stack.push(I8)
                of opConstI9            : stack.push(I9)
                of opConstI10           : stack.push(I10)
                of opConstI11           : stack.push(I11)
                of opConstI12           : stack.push(I12)
                of opConstI13           : stack.push(I13)
                of opConstI14           : stack.push(I14)
                of opConstI15           : stack.push(I15)

                of opConstI1M           : stack.push(I1M)           # unused by evaluator

                of opConstF0            : stack.push(F0)
                of opConstF1            : stack.push(F1)
                of opConstF2            : stack.push(F2)

                of opConstF1M           : stack.push(F1M)           # unused by evaluator

                of opConstBT            : stack.push(VTRUE)
                of opConstBF            : stack.push(VFALSE)
                of opConstBM            : stack.push(VMAYBE)

                of opConstS             : stack.push(VEMPTYSTR)
                of opConstA             : stack.push(VEMPTYARR)
                of opConstD             : stack.push(VEMPTYDICT)

                of opConstN             : stack.push(VNULL)

                # lines & error reporting
                of opEol                : 
                    when not defined(NOERRORLINES):
                        i += 1
                        CurrentLine = (int)(it[i])
                    else:
                        discard
                of opEolX               :   
                    when not defined(NOERRORLINES):
                        i += 2
                        CurrentLine = (int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))
                    else:
                        discard

                of RSRV1                : discard
                of RSRV2                : discard

                # [0x20-0x2F]
                # push values
                of opPush0              : pushByIndex(0)
                of opPush1              : pushByIndex(1)
                of opPush2              : pushByIndex(2)
                of opPush3              : pushByIndex(3)
                of opPush4              : pushByIndex(4)
                of opPush5              : pushByIndex(5)
                of opPush6              : pushByIndex(6)
                of opPush7              : pushByIndex(7)
                of opPush8              : pushByIndex(8)
                of opPush9              : pushByIndex(9)
                of opPush10             : pushByIndex(10)
                of opPush11             : pushByIndex(11)
                of opPush12             : pushByIndex(12)
                of opPush13             : pushByIndex(13)
                #of opPush0..opPush13    : pushByIndex((int)(op)-(int)(opPush0))
                of opPush               : i += 1; pushByIndex((int)(it[i]))
                of opPushX              : i += 2; pushByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

                # [0x30-0x3F]
                # store variables (from <- stack)
                of opStore0             : storeByIndex(0)
                of opStore1             : storeByIndex(1)
                of opStore2             : storeByIndex(2)
                of opStore3             : storeByIndex(3)
                of opStore4             : storeByIndex(4)
                of opStore5             : storeByIndex(5)
                of opStore6             : storeByIndex(6)
                of opStore7             : storeByIndex(7)
                of opStore8             : storeByIndex(8)
                of opStore9             : storeByIndex(9)
                of opStore10            : storeByIndex(10)
                of opStore11            : storeByIndex(11)
                of opStore12            : storeByIndex(12)
                of opStore13            : storeByIndex(13)
                of opStore              : i += 1; storeByIndex((int)(it[i]))   
                of opStoreX             : i += 2; storeByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i])))              

                # [0x40-0x4F]
                # load variables (to -> stack)
                of opLoad0              : loadByIndex(0)
                of opLoad1              : loadByIndex(1)
                of opLoad2              : loadByIndex(2)
                of opLoad3              : loadByIndex(3)
                of opLoad4              : loadByIndex(4)
                of opLoad5              : loadByIndex(5)
                of opLoad6              : loadByIndex(6)
                of opLoad7              : loadByIndex(7)
                of opLoad8              : loadByIndex(8)
                of opLoad9              : loadByIndex(9)
                of opLoad10             : loadByIndex(10)
                of opLoad11             : loadByIndex(11)
                of opLoad12             : loadByIndex(12)
                of opLoad13             : loadByIndex(13)
                of opLoad               : i += 1; loadByIndex((int)(it[i]))
                of opLoadX              : i += 2; loadByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

                # [0x50-0x5F]
                # store-load variables (from <- stack, without popping)
                of opStorl0             : storeByIndex(0, doPop=false)
                of opStorl1             : storeByIndex(1, doPop=false)
                of opStorl2             : storeByIndex(2, doPop=false)
                of opStorl3             : storeByIndex(3, doPop=false)
                of opStorl4             : storeByIndex(4, doPop=false)
                of opStorl5             : storeByIndex(5, doPop=false)
                of opStorl6             : storeByIndex(6, doPop=false)
                of opStorl7             : storeByIndex(7, doPop=false)
                of opStorl8             : storeByIndex(8, doPop=false)
                of opStorl9             : storeByIndex(9, doPop=false)
                of opStorl10            : storeByIndex(10, doPop=false)
                of opStorl11            : storeByIndex(11, doPop=false)
                of opStorl12            : storeByIndex(12, doPop=false)
                of opStorl13            : storeByIndex(13, doPop=false)
                of opStorl              : i += 1; storeByIndex((int)(it[i]), doPop=false)   
                of opStorlX             : i += 2; storeByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i])), doPop=false)              

                # [0x60-0x6F]
                # function calls
                of opCall0              : callByIndex(0)  
                of opCall1              : callByIndex(1)
                of opCall2              : callByIndex(2)
                of opCall3              : callByIndex(3)
                of opCall4              : callByIndex(4)
                of opCall5              : callByIndex(5)
                of opCall6              : callByIndex(6)
                of opCall7              : callByIndex(7)
                of opCall8              : callByIndex(8)
                of opCall9              : callByIndex(9)
                of opCall10             : callByIndex(10)
                of opCall11             : callByIndex(11)
                of opCall12             : callByIndex(12)
                of opCall13             : callByIndex(13)          
                of opCall               : i += 1; callByIndex((int)(it[i]))
                of opCallX              : i += 2; callByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

                # [0x70-0x7F]
                # attributes
                of opAttr0              : fetchAttributeByIndex(0)
                of opAttr1              : fetchAttributeByIndex(1)
                of opAttr2              : fetchAttributeByIndex(2)
                of opAttr3              : fetchAttributeByIndex(3)
                of opAttr4              : fetchAttributeByIndex(4)
                of opAttr5              : fetchAttributeByIndex(5)
                of opAttr6              : fetchAttributeByIndex(6)
                of opAttr7              : fetchAttributeByIndex(7)
                of opAttr8              : fetchAttributeByIndex(8)
                of opAttr9              : fetchAttributeByIndex(9)
                of opAttr10             : fetchAttributeByIndex(10)
                of opAttr11             : fetchAttributeByIndex(11)
                of opAttr12             : fetchAttributeByIndex(12)
                of opAttr13             : fetchAttributeByIndex(13)
                #of opAttr0..opAttr13    : fetchAttributeByIndex((int)(op)-(int)(opAttr0))
                of opAttr               : i += 1; fetchAttributeByIndex((int)(it[i]))
                of opAttrX              : i += 2; fetchAttributeByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

                #---------------------------------
                # OP FUNCTIONS
                #---------------------------------

                # [0x80-0x8F]
                # arithmetic operators
                of opAdd                : AddF.action()
                of opSub                : SubF.action()
                of opMul                : MulF.action()
                of opDiv                : DivF.action()
                of opFdiv               : FdivF.action()
                of opMod                : ModF.action()
                of opPow                : PowF.action()

                of opNeg                : NegF.action()

                # binary operators
                of opBNot               : BNotF.action()
                of opBAnd               : BAndF.action() 
                of opBOr                : BOrF.action()

                of opShl                : ShlF.action()
                of opShr                : ShrF.action()

                # logical operators
                of opNot                : NotF.action()
                of opAnd                : AndF.action()
                of opOr                 : OrF.action()

                # [0x90-0x9F]
                # comparison operators
                of opEq                 : EqF.action()
                of opNe                 : NeF.action()
                of opGt                 : GtF.action()
                of opGe                 : GeF.action()
                of opLt                 : LtF.action()
                of opLe                 : LeF.action()

                # branching
                of opIf                 : IfF.action()
                of opIfE                : IfEF.action()
                of opElse               : ElseF.action()
                of opWhile              : WhileF.action()
                of opReturn             : ReturnF.action()

                # getters/setters
                of opGet                : GetF.action()
                of opSet                : SetF.action()

                # converters
                of opTo                 : ToF.action()
                of opToS                : 
                    stack.push(VSTRINGT)
                    ToF.action()
                of opToI                : 
                    stack.push(VINTEGERT)
                    ToF.action()

                # [0xA0-0xAF]
                # i/o operations
                of opPrint              : PrintF.action()

                # generators          
                of opArray              : ArrayF.action()
                of opDict               : DictF.action()
                of opFunc               : FuncF.action()

                # ranges & iterators
                of opRange              : RangeF.action()
                of opLoop               : LoopF.action()
                of opMap                : MapF.action()
                of opSelect             : SelectF.action()

                # collections
                of opSize               : SizeF.action()
                of opReplace            : ReplaceF.action()
                of opSplit              : SplitF.action()
                of opJoin               : JoinF.action()
                of opReverse            : ReverseF.action()

                # increment/decrement
                of opInc                : IncF.action()
                of opDec                : DecF.action()

                of RSRV3                : discard

                #of RSRV3..RSRV14        : discard

                #---------------------------------
                # LOW-LEVEL OPERATIONS
                #---------------------------------

                # [0xB0-0xBF]
                # no operation
                of opNop                : discard

                # stack operations
                of opPop                : discard stack.pop()
                of opDup                : stack.push(sTop())
                of opOver               : stack.push(stack.peek(1))
                of opSwap               : swap(Stack[SP-1], Stack[SP-2])

                # flow control
                of opJmp                : i = (int)(it[i+1])
                of opJmpX               : i = (int)((uint16)(it[i+1]) shl 8 + (byte)(it[i+2]))
                of opJmpIf              : 
                    if stack.pop().b==True:
                        i = (int)(it[i+1])
                of opJmpIfX             : 
                    if stack.pop().b==True:
                        i = (int)((uint16)(it[i+1]) shl 8 + (byte)(it[i+2]))
                of opJmpIfN             : 
                    if Not(stack.pop().b)==True:
                        i = (int)(it[i+1])
                of opJmpIfNX            : 
                    if Not(stack.pop().b)==True:
                        i = (int)((uint16)(it[i+1]) shl 8 + (byte)(it[i+2]))
                of opRet                : discard
                of opEnd                : break

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

    return newSyms