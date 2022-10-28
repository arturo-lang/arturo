#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/exec.nim
#=======================================================

## This module contains the main loop for the VM.
## 
## Here:
## - we take a Translation object
## - go through each and every one of the bytecode
##   instructions and execute them, one by one
## 
## The main entry point is ``execBlock``.

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
    values/value
]

import vm/values/custom/[vbinary, vlogical]

#=======================================
# Types
#=======================================

type
    MemoizerKey = (Hash, Hash)

#=======================================
# Variables
#=======================================

var
    Memoizer: OrderedTable[MemoizerKey,Value] = initOrderedTable[MemoizerKey,Value]()

#=======================================
# Forward Declarations
#=======================================

proc ExecLoop*(cnst: ValueArray, it: VBinary)

#=======================================
# Helpers
#=======================================

template pushByIndex(idx: int):untyped =
    stack.push(cnst[idx])

proc storeByIndex(cnst: ValueArray, idx: int, doPop: static bool = true) {.inline,enforceNoRaises.}=
    hookProcProfiler("exec/storeByIndex"):
        var stackTop {.cursor.} = stack.peek(0)

        if unlikely(stackTop.kind==Function):
            Arities[cnst[idx].s] = stackTop.arity

        SetSym(cnst[idx].s, stackTop, safe=true)
        when doPop:
            stack.popN(1)

proc dStoreByIndex(cnst: ValueArray, idx: int, doPop: static bool = true) {.inline,enforceNoRaises.}=
    hookProcProfiler("exec/storeByIndex"):
        var stackTop {.cursor.} = stack.peek(0)

        SetDictSym(cnst[idx].s, stackTop, safe=true)
        when doPop:
            stack.popN(1)

template loadByIndex(idx: int):untyped =
    hookProcProfiler("exec/loadByIndex"):
        stack.push(FetchSym(cnst[idx].s))

template callFunction*(f: Value, fnName: string = "<closure>"):untyped =
    ## Take a Function value, whether a user or a built-in one, 
    ## and execute it
    if f.fnKind==UserFunction:
        hookProcProfiler("exec/callFunction:user"):
            if unlikely(SP < f.arity):
                RuntimeError_NotEnoughArguments(fnName, f.arity)

            execFunction(f, hash(fnName))
    else:
        f.action()

template callByName(symIndx: string):untyped =
    let fun = FetchSym(symIndx)
    callFunction(fun, symIndx)

template callByIndex(idx: int):untyped =
    hookProcProfiler("exec/callByIndex"):
        if cnst[idx].kind==Function:
            callFunction(cnst[idx])
        else:
            callByName(cnst[idx].s)

template fetchAttributeByIndex(idx: int):untyped =
    stack.pushAttr(cnst[idx].s, move stack.pop())

#---------------------------------------

template getMemoized(fid: Hash, v: Value): Value =
    Memoizer.getOrDefault((fid, value.hash(v)), nil)

template setMemoized(fid: Hash, v: Value, res: Value) =
    Memoizer[(fid, value.hash(v))] = res

template callInternal*(fname: string, getValue: bool, args: varargs[Value]): untyped =
    ## Call function by name, directly and - 
    ## optionally - return the result
    let fun = GetSym(fname)
    for v in args.reversed:
        push(v)

    callFunction(fun)

    when getValue:
        pop()

template prepareLeakless*(protected: ValueArray): untyped =
    ## Prepare for leak-less block execution
    ## 
    ## **Hint:** To be used in the Iterators module

    var toRestore{.inject.}: seq[(string,Value,int)] = protected.map((psym) =>
        (psym.s, Syms.getOrDefault(psym.s, nil), Arities.getOrDefault(psym.s, -1))
    )

template finalizeLeakless*(): untyped =
    ## Finalize leak-less block execution
    ## 
    ## **Hint:** To be used in the Iterators module

    for (sym, val, arity) in toRestore:
        if val.isNil:
            var delSym: Value
            if Syms.pop(sym, delSym):
                if delSym.kind==Function:
                    Arities.del(sym)
        else:
            Syms[sym] = val
            if arity != -1:
                Arities[sym] = arity
        # if arity != -1:
        #     Arities[sym] = arity
        # else:
        #     Arities.del(sym)

template handleBranching*(tryDoing, finalize: untyped): untyped =
    ## Wrapper for code that may throw *Break* or *Continue* signals, 
    ## or other errors that are to be caught
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

template execUnscoped*(input: Translation or Value) =
    ## Execute given bytecode without scoping
    ## 
    ## This means:
    ## - Symbols declared inside will be available 
    ##   in the outer scope
    ## - Symbols re-assigned inside will overwrite 
    ##   the value in the outer scope (if it exists)
    
    when input is Translation:
        ExecLoop(input.constants, input.instructions)
    else:
        let preevaled = evalOrGet(input)
        ExecLoop(preevaled.constants, preevaled.instructions)

template execInternal*(path: string) =
    ## Execute internal script using given path
    
    let preevaled = doEval(
        doParse(
            static readFile(
                normalizedPath(
                    parentDir(currentSourcePath()) & "/../library/internal/" & path & ".art"
                )
            ),
            isFile = false
        )
    )

    ExecLoop(preevaled.constants, preevaled.instructions)

proc execDictionary*(blk: Value): ValueDict =
    ## Execute given Block value and return 
    ## a Dictionary
    
    DictSyms.add(initOrderedTable[string,Value]())

    let preevaled = doEval(blk, isDictionary=true)

    ExecLoop(preevaled.constants, preevaled.instructions)

    result = DictSyms.pop()

proc execFunction*(fun: Value, fid: Hash) =
    ## Execute given Function value with scoping
    ## 
    ## This means:
    ## - All symbols declared inside will NOT be 
    ##   available in the outer scope
    ## - Symbols re-assigned inside will NOT 
    ##   overwrite the value in the outer scope
    ## - Symbols declared in `.exports` will not 
    ##   abide by this rule
    ## - If the whole function is marked as 
    ##   `.exportable`, then none of the symbols 
    ##   will abide by this rule and it will behave 
    ##   pretty much like `execLeakless`
    
    var memoizedParams: Value = nil
    var savedSyms: ValueDict

    var savedArities = Arities
    let argsL = len(fun.params.a)

    if fun.memoize:
        memoizedParams = newBlock()

        var i=0
        while i < argsL:
            memoizedParams.a.add(stack.peek(i))
            inc i

        # this specific call result has already been memoized
        # so we can just return it
        if (let memd = getMemoized(fid, memoizedParams); not memd.isNil):
            popN argsL
            push memd
            return
    else:
        for i,arg in fun.params.a:          
            if stack.peek(i).kind==Function:
                Arities[arg.s] = stack.peek(i).arity
            else:
                Arities.del(arg.s)
        
    savedSyms = Syms
    if not fun.imports.isNil:
        for k,v in pairs(fun.imports.d):
            SetSym(k, v)

    for arg in fun.params.a:
        # pop argument and set it
        SetSym(arg.s, move stack.pop())

    let preevaled = doEval(fun.main)

    try:
        ExecLoop(preevaled.constants, preevaled.instructions)

    except ReturnTriggered:
        discard

    finally:
        if fun.memoize:
            setMemoized(fid, memoizedParams, stack.peek(0))

        if fun.exportable:
            for k in fun.params.a:
                if (let savedSym = savedSyms.getOrDefault(k.s, nil); not savedSym.isNil):
                    Syms[k.s] = savedSym
                    if (let savedArity = savedArities.getOrDefault(k.s, -1); savedArity != -1):
                        Arities[k.s] = savedArity
                    else:
                        Arities.del(k.s)
                else:
                    Syms.del(k.s)
                    Arities.del(k.s)
        else:
            if not fun.exports.isNil:
                for k in fun.exports.a:
                    if (let newSym = Syms.getOrDefault(k.s, nil); not newSym.isNil):
                        savedSyms[k.s] = newSym
                        if (let newArity = Arities.getOrDefault(k.s, -1); newArity != -1):
                            savedArities[k.s] = newArity
                        else:
                            savedArities.del(k.s)
            
                Syms = savedSyms
                Arities = savedArities
            else:
                Syms = savedSyms
                Arities = savedArities

proc ExecLoop*(cnst: ValueArray, it: VBinary) =
    ## The main execution loop.
    ## 
    ## It takes an array of constants, our data (``cnst``)
    ## and array of bytes, our instructions/bytecode (``it``),
    ## goes through them and executes them one-by-one
    ## 
    ## **Hint:** Not to be called directly! Better use one 
    ## of the helpers above!

    var
        i   {.register.}: int = 0
        op  {.register.}: OpCode

    while true:
        {.computedGoTo.}

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

                of opDStore             : i += 1; dStoreByIndex(cnst, (int)(it[i]))
                of opDStoreX            : i += 2; dStoreByIndex(cnst, (int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

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
                of opStore0             : storeByIndex(cnst, 0)
                of opStore1             : storeByIndex(cnst, 1)
                of opStore2             : storeByIndex(cnst, 2)
                of opStore3             : storeByIndex(cnst, 3)
                of opStore4             : storeByIndex(cnst, 4)
                of opStore5             : storeByIndex(cnst, 5)
                of opStore6             : storeByIndex(cnst, 6)
                of opStore7             : storeByIndex(cnst, 7)
                of opStore8             : storeByIndex(cnst, 8)
                of opStore9             : storeByIndex(cnst, 9)
                of opStore10            : storeByIndex(cnst, 10)
                of opStore11            : storeByIndex(cnst, 11)
                of opStore12            : storeByIndex(cnst, 12)
                of opStore13            : storeByIndex(cnst, 13)
                of opStore              : i += 1; storeByIndex(cnst, (int)(it[i]))   
                of opStoreX             : i += 2; storeByIndex(cnst, (int)((uint16)(it[i-1]) shl 8 + (byte)(it[i])))              

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
                of opStorl0             : storeByIndex(cnst, 0, doPop=false)
                of opStorl1             : storeByIndex(cnst, 1, doPop=false)
                of opStorl2             : storeByIndex(cnst, 2, doPop=false)
                of opStorl3             : storeByIndex(cnst, 3, doPop=false)
                of opStorl4             : storeByIndex(cnst, 4, doPop=false)
                of opStorl5             : storeByIndex(cnst, 5, doPop=false)
                of opStorl6             : storeByIndex(cnst, 6, doPop=false)
                of opStorl7             : storeByIndex(cnst, 7, doPop=false)
                of opStorl8             : storeByIndex(cnst, 8, doPop=false)
                of opStorl9             : storeByIndex(cnst, 9, doPop=false)
                of opStorl10            : storeByIndex(cnst, 10, doPop=false)
                of opStorl11            : storeByIndex(cnst, 11, doPop=false)
                of opStorl12            : storeByIndex(cnst, 12, doPop=false)
                of opStorl13            : storeByIndex(cnst, 13, doPop=false)
                of opStorl              : i += 1; storeByIndex(cnst, (int)(it[i]), doPop=false)   
                of opStorlX             : i += 2; storeByIndex(cnst, (int)((uint16)(it[i-1]) shl 8 + (byte)(it[i])), doPop=false)              

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

                of RSRV1                : discard

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
