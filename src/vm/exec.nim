#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
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

import hashes, macros, sugar, tables

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

import vm/values/custom/[vbinary]

import vm/values/comparison

#=======================================
# Types
#=======================================

type
    MemoizerKey = (Hash, Hash)
    MemoizerTable = Table[MemoizerKey, Value]

#=======================================
# Variables
#=======================================

var
    Memoizer: MemoizerTable = initTable[MemoizerKey,Value]()

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

            if f.inline: 
                var safeToProceed = true
                for i in 0..f.params.high:          
                    if stack.peek(i).kind==Function:
                        safeToProceed = false
                        break
                if safeToProceed: execFunctionInline(f, hash(fnName))
                else: execFunction(f, hash(fnName))
            else: execFunction(f, hash(fnName))
    else:
        f.action()()

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

template performConditionalJump(symb: untyped, short: static bool=false): untyped =
    when short:
        let x = move stack.pop()
        let y = move stack.pop()
        i += 1
        if `symb`(x,y):
            i += int(it[i])
    else:
        let x = move stack.pop()
        let y = move stack.pop()
        i += 2
        if `symb`(x,y):
            i += int(uint16(it[i-1]) shl 8 + byte(it[i]))

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

template prepareLeakless*(protected: seq[string] | ValueArray): untyped =
    ## Prepare for leak-less block execution

    var toRestore{.inject.}: seq[(string,Value)] = 
        collect:
            for psym in protected:
                when protected is ValueArray:
                    (psym.s, Syms.getOrDefault(psym.s, nil))
                else:
                    (psym, Syms.getOrDefault(psym, nil))

template finalizeLeakless*(): untyped =
    ## Finalize leak-less block execution

    for (sym, val) in mitems(toRestore):
        if val.isNil:
            Syms.del(sym)
        else:
            Syms[sym] = move val

template prepareLeaklessOne*(protected: string | Value): untyped =
    ## Prepare for leak-less block execution
    ## with a single protected argument
    
    let toRestoreKey {.inject.} = 
        when protected is Value: protected.s
        else: protected

    var toRestoreVal {.inject.} = 
        when protected is Value: Syms.getOrDefault(protected.s, nil)
        else: Syms.getOrDefault(protected, nil)

template finalizeLeaklessOne*(): untyped =
    ## Finalize leak-less block execution
    ## with a single protected argument
    
    if toRestoreVal.isNil:
        Syms.del(toRestoreKey)
    else:
        Syms[toRestoreKey] = move toRestoreVal

# TODO(VM/exec) Should also catch any *CatchableError* in `handleBranching`?
#  labels: vm, execution, error handling
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

    var memoizedParams: Value = nil
    var savedSyms: SymTable

    let argsL = len(fun.params)

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
        
    savedSyms = Syms
    if not fun.imports.isNil:
        for k,v in pairs(fun.imports.d):
            SetSym(k, v)

    for arg in fun.params:
        # pop argument and set it
        SetSym(arg, move stack.pop())

    if fun.bcode.isNil:
        fun.bcode = newBytecode(doEval(fun.main, isFunctionBlock=true))

    try:
        ExecLoop(fun.bcode().trans.constants, fun.bcode().trans.instructions)

    except ReturnTriggered:
        discard

    finally:
        if fun.memoize:
            setMemoized(fid, memoizedParams, stack.peek(0))

        if not fun.exports.isNil:
            for k in fun.exports.a:
                if (let newSym = Syms.getOrDefault(k.s, nil); not newSym.isNil):
                    savedSyms[k.s] = newSym
        
        Syms = savedSyms

proc execFunctionInline*(fun: Value, fid: Hash) =
    ## Execute given Function value without scoping
    ## 
    ## This means:
    ## - No symbols are expected to be declared inside
    ## - Symbols re-assigned inside will NOT 
    ##   overwrite the value in the outer scope
    ## - Symbols declared in `.exports` will not 
    ##   abide by this rule

    var memoizedParams: Value = nil
 
    let argsL = len(fun.params)

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

    prepareLeakless(fun.params)

    for arg in fun.params:
        # pop argument and set it
        SetSym(arg, move stack.pop())

    if fun.bcode.isNil:
        fun.bcode = newBytecode(doEval(fun.main, isFunctionBlock=true))

    try:
        ExecLoop(fun.bcode().trans.constants, fun.bcode().trans.instructions)

    except ReturnTriggered:
        discard

    finally:
        if fun.memoize:
            setMemoized(fid, memoizedParams, stack.peek(0))

        finalizeLeakless()

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

        op = OpCode(it[i])

        #echo "Executing: " & (stringify(op)) & " at " & $(i)# & " with next: " & $(it[i+1])

        hookOpProfiler($(op)):

            case op:
                # [0x00-0x1F]
                # push constants 
                of opConstI1M           : stack.push(I1M)
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

                of opConstF1M           : stack.push(F1M)
                of opConstF0            : stack.push(F0)
                of opConstF1            : stack.push(F1)
                of opConstF2            : stack.push(F2)

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
                        CurrentLine = int(it[i])
                    else:
                        discard
                of opEolX               :   
                    when not defined(NOERRORLINES):
                        i += 2
                        CurrentLine = int(uint16(it[i-1]) shl 8 + byte(it[i]))
                    else:
                        discard

                of opDStore             : i += 1; dStoreByIndex(cnst, int(it[i]))
                of opDStoreX            : i += 2; dStoreByIndex(cnst, int(uint16(it[i-1]) shl 8 + byte(it[i]))) 

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
                #of opPush0..opPush13    : pushByIndex(int(op)-int(opPush0))
                of opPush               : i += 1; pushByIndex(int(it[i]))
                of opPushX              : i += 2; pushByIndex(int(uint16(it[i-1]) shl 8 + byte(it[i]))) 

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
                of opStore              : i += 1; storeByIndex(cnst, int(it[i]))   
                of opStoreX             : i += 2; storeByIndex(cnst, int(uint16(it[i-1]) shl 8 + byte(it[i])))              

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
                of opLoad               : i += 1; loadByIndex(int(it[i]))
                of opLoadX              : i += 2; loadByIndex(int(uint16(it[i-1]) shl 8 + byte(it[i]))) 

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
                of opStorl              : i += 1; storeByIndex(cnst, int(it[i]), doPop=false)   
                of opStorlX             : i += 2; storeByIndex(cnst, int(uint16(it[i-1]) shl 8 + byte(it[i])), doPop=false)              

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
                of opCall               : i += 1; callByIndex(int(it[i]))
                of opCallX              : i += 2; callByIndex(int(uint16(it[i-1]) shl 8 + byte(it[i]))) 

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
                #of opAttr0..opAttr13    : fetchAttributeByIndex(int(op)-int(opAttr0))
                of opAttr               : i += 1; fetchAttributeByIndex(int(it[i]))
                of opAttrX              : i += 2; fetchAttributeByIndex(int(uint16(it[i-1]) shl 8 + byte(it[i]))) 

                #---------------------------------
                # OP FUNCTIONS
                #---------------------------------

                # [0x80-0x8F]
                # arithmetic operators
                of opAdd                : DoAdd()
                of opSub                : DoSub()
                of opMul                : DoMul()
                of opDiv                : DoDiv()
                of opFdiv               : DoFdiv()
                of opMod                : DoMod()
                of opPow                : DoPow()

                of opNeg                : DoNeg()

                # increment/decrement
                of opInc                : DoInc()
                of opDec                : DoDec()

                # binary operators
                of opBNot               : DoBNot()
                of opBAnd               : DoBAnd()
                of opBOr                : DoBOr()

                of opShl                : DoShl()
                of opShr                : DoShr()

                of RSRV1                : discard

                # [0x90-0x9F]
                # logical operators
                of opNot                : DoNot()
                of opAnd                : DoAnd()
                of opOr                 : DoOr()

                # comparison operators
                of opEq                 : DoEq()
                of opNe                 : DoNe()
                of opGt                 : DoGt()
                of opGe                 : DoGe()
                of opLt                 : DoLt()
                of opLe                 : DoLe()

                # getters/setters
                of opGet                : DoGet()
                of opSet                : DoSet()

                of RSRV2                : discard
                of RSRV3                : discard   
                of RSRV4                : discard
                of RSRV5                : discard
                of RSRV6                : discard

                # [0xA0-0xAF]
                # branching
                of opIf                 : DoIf()
                of opIfE                : DoIfE()
                of opUnless             : DoUnless()
                of opUnlessE            : DoUnlessE()
                of opElse               : DoElse()
                of opSwitch             : DoSwitch()
                of opWhile              : DoWhile()

                of opReturn             : DoReturn()
                of opBreak              : DoBreak()
                of opContinue           : DoContinue()

                # converters
                of opTo                 : DoTo()
                of opToS                : 
                    stack.push(VSTRINGT)
                    DoTo()
                of opToI                : 
                    stack.push(VINTEGERT)
                    DoTo()

                of RSRV7                : discard
                of RSRV8                : discard
                of RSRV9                : discard

                # [0xB0-0xBF]
                # generators          
                of opArray              : DoArray()
                of opDict               : DoDict()
                of opFunc               : DoFunc()
                of opRange              : DoRange()
                
                # iterators
                of opLoop               : DoLoop()
                of opMap                : DoMap()
                of opSelect             : DoSelect()

                # collections
                of opSize               : DoSize()
                of opReplace            : DoReplace()
                of opSplit              : DoSplit()
                of opJoin               : DoJoin()
                of opReverse            : DoReverse()
                of opAppend             : DoAppend()

                # i/o operations
                of opPrint              : DoPrint()

                of RSRV10               : discard
                of RSRV11               : discard

                #---------------------------------
                # LOW-LEVEL OPERATIONS
                #---------------------------------

                # [0xC0-0xDF]
                # no operation
                of opNop                : discard

                # stack operations
                of opPop                : discard stack.pop()
                of opDup                : stack.push(sTop())
                of opOver               : stack.push(stack.peek(1))
                of opSwap               : swap(Stack[SP-1], Stack[SP-2])

                # conditional jumps
                of opJmpIf              :
                    let x = move stack.pop()
                    i += 1
                    if not (x.kind==Null or isFalse(x)):
                        i += int(it[i])

                of opJmpIfX:
                    let x = move stack.pop()
                    i += 2
                    if not (x.kind==Null or isFalse(x)):
                        i += int(uint16(it[i-1]) shl 8 + byte(it[i]))
                
                of opJmpIfNot           :
                    let x = move stack.pop()
                    i += 1
                    if x.kind==Null or isFalse(x):
                        i += int(it[i])
                
                of opJmpIfNotX:
                    let x = move stack.pop()
                    i += 2
                    if x.kind==Null or isFalse(x):
                        i += int(uint16(it[i-1]) shl 8 + byte(it[i]))

                of opJmpIfEq            : performConditionalJump(`==`, short=true)
                of opJmpIfEqX           : performConditionalJump(`==`)
                of opJmpIfNe            : performConditionalJump(`!=`, short=true)
                of opJmpIfNeX           : performConditionalJump(`!=`)
                of opJmpIfGt            : performConditionalJump(`>`, short=true)
                of opJmpIfGtX           : performConditionalJump(`>`)
                of opJmpIfGe            : performConditionalJump(`>=`, short=true)
                of opJmpIfGeX           : performConditionalJump(`>=`)
                of opJmpIfLt            : performConditionalJump(`<`, short=true)
                of opJmpIfLtX           : performConditionalJump(`<`)
                of opJmpIfLe            : performConditionalJump(`<=`, short=true)
                of opJmpIfLeX           : performConditionalJump(`<=`)

                # flow control
                of opGoto               :
                    i += 1
                    i += int(it[i])

                of opGotoX              :
                    i += 2
                    i += int(uint16(it[i-1]) shl 8 + byte(it[i]))

                of opGoup               :
                    i += 1
                    i -= (int(it[i]) + 2)

                of opGoupX              :
                    i += 2
                    i -= (int(uint16(it[i-1]) shl 8 + byte(it[i])) + 3)

                of opRet                :
                    discard

                of opEnd                :
                    break

        i += 1
