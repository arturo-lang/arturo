######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: vm/exec.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, asyncdispatch, asynchttpserver
import base64, cgi, db_sqlite, std/editdistance
import httpClient, json, math, md5, os, osproc
import random, rdstdin, re, sequtils, smtp
import std/sha1, strformat, strutils, sugar
import tables, times, unicode, uri, xmltree
import nre except toSeq

when not defined(windows):
    import linenoise

import extras/bignum

import helpers/arrays       as arraysHelper   
import helpers/csv          as csvHelper
import helpers/database     as databaseHelper
import helpers/datasource   as datasourceHelper
import helpers/html         as htmlHelper
import helpers/json         as jsonHelper
import helpers/markdown     as markdownHelper
import helpers/path         as pathHelper
import helpers/strings      as stringsHelper
import helpers/unisort      as unisortHelper
import helpers/url          as urlHelper
import helpers/webview      as webviewHelper
import helpers/xml          as xmlHelper

import library/[
    Arithmetic,
    Binary,
    Collections, 
    Comparison, 
    Conversion,
    Core, 
    Crypto,
    Database,
    Dates,
    Files,
    Logic, 
    Net,
    Numbers,
    Path,
    Reflection,
    Shell,
    Strings,
    Ui
]

import translator/eval, translator/parse
import vm/bytecode, vm/stack, vm/value

import utils    

#=======================================
# Globals
#=======================================

var
    vmPanic* = false
    vmError* = ""
    vmReturn* = false

#=======================================
# Helpers
#=======================================

template panic(error: string): untyped =
    vmPanic = true
    vmError = error
    return

template pushByIndex(idx: int):untyped =
    stack.push(cnst[idx])

template storeByIndex(idx: int):untyped =
    let symIndx = cnst[idx].s
    syms[symIndx] = stack.pop()

template loadByIndex(idx: int):untyped =
    let symIndx = cnst[idx].s
    let item = syms.getOrDefault(symIndx)
    if item.isNil: panic "symbol not found: " & symIndx
    stack.push(syms[symIndx])

template callByIndex(idx: int):untyped =
    let symIndx = cnst[idx].s
    let fun = syms.getOrDefault(symIndx)
    if fun.isNil: panic "symbol not found: " & symIndx
    if fun.pure:
        discard execBlock(fun.main, useArgs=true, args=fun.params.a, isFuncBlock=true, exports=fun.exports, isPureFunc=true)
    else:
        discard execBlock(fun.main, useArgs=true, args=fun.params.a, isFuncBlock=true, exports=fun.exports, isPureFunc=false)

# template callFromStack():untyped =
#     let fun = stack.pop()
#     discard execBlock(fun.main, useArgs=true, args=fun.args.a)

####

template require(op: OpCode): untyped =
    if SP<(static OpSpecs[op].args):
        panic "cannot perform '" & (static OpSpecs[op].name) & "'; not enough parameters: " & $(static OpSpecs[op].args) & " required"

    when (static OpSpecs[op].args)>=1:
        when (static OpSpecs[op].a) != {ANY}:
            if not (Stack[SP-1].kind in (static OpSpecs[op].a)):
                let acceptStr = toSeq((OpSpecs[op].a).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                panic "cannot perform '" & (static OpSpecs[op].name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " ...; incorrect argument type for 1st parameter; accepts " & acceptStr

        when (static OpSpecs[op].args)>=2:
            when (static OpSpecs[op].b) != {ANY}:
                if not (Stack[SP-2].kind in (static OpSpecs[op].b)):
                    let acceptStr = toSeq((OpSpecs[op].b).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                    panic "cannot perform '" & (static OpSpecs[op].name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " :" & ($(Stack[SP-2].kind)).toLowerAscii() & " ...; incorrect argument type for 2nd parameter; accepts " & acceptStr
                    break

            when (static OpSpecs[op].args)>=3:
                when (static OpSpecs[op].c) != {ANY}:
                    if not (Stack[SP-3].kind in (static OpSpecs[op].c)):
                        let acceptStr = toSeq((OpSpecs[op].c).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                        panic "cannot perform '" & (static OpSpecs[op].name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " :" & ($(Stack[SP-2].kind)).toLowerAscii() & " :" & ($(Stack[SP-3].kind)).toLowerAscii() & " ...; incorrect argument type for third parameter; accepts " & acceptStr

    when (static OpSpecs[op].args)>=1:
        var x {.inject.} = stack.pop()
    when (static OpSpecs[op].args)>=2:
        var y {.inject.} = stack.pop()
    when (static OpSpecs[op].args)>=3:
        var z {.inject.} = stack.pop()

template execBlock(
        blk             : Value, 
        dictionary      : bool = false, 
        useArgs         : bool = false, 
        args            : ValueArray = NoValues, 
        usePreeval      : bool = false, 
        evaluated       : Translation = NoTranslation, 
        execInParent    : bool = false, 
        isFuncBlock     : bool = false, 
        exports         : Value = VNULL, 
        isPureFunc      : bool = false,
        isIsolated      : bool = false,
        willInject      : bool = false,
        inject          : ptr ValueDict = nil
): untyped =

    #-----------------------------
    # store previous symbols
    #-----------------------------

    when (not isFuncBlock and not execInParent) or isPureFunc:
        # save previous symbols 
        let previous = syms

        when isPureFunc:
            # and cleanup current ones
            syms = initOrderedTable[string,Value]()

    #-----------------------------
    # pre-process arguments
    #-----------------------------
    when useArgs:
        var saved = initOrderedTable[string,Value]()
        for arg in args:
            let symIndx = arg.s

            if not isPureFunc:
                # if argument already exists, save it
                if syms.hasKey(symIndx):
                    saved[symIndx] = syms[symIndx]

            # pop argument and set it
            syms[symIndx] = stack.pop()

            # properly set arity, if argument is a function
            if syms[symIndx].kind==Function:
                Funcs[symIndx] = syms[symIndx].params.a.len 

    #-----------------------------
    # pre-process injections
    #-----------------------------
    when willInject:
        when not useArgs:
            var saved = initOrderedTable[string,Value]()

        for k,v in pairs(inject[]):
            if syms.hasKey(k):
                saved[k] = syms[k]

            syms[k] = v

            if syms[k].kind==Function:
                Funcs[k] = syms[k].params.a.len

    #-----------------------------
    # evaluate block
    #-----------------------------
    let evaled = 
        when not usePreeval:    doEval(blk)
        else:                   evaluated

    #-----------------------------
    # execute it
    #-----------------------------
    when isIsolated:
        let subSyms = doExec(evaled, depth+1, nil)
    else:
        let subSyms = doExec(evaled, depth+1, addr syms)

    #-----------------------------
    # handle result
    #-----------------------------

    when dictionary:
        # it's specified as a dictionary,
        # so let's handle it this way

        var res: ValueDict = initOrderedTable[string,Value]()

        for k, v in pairs(subSyms):
            if not previous.hasKey(k):
                # it wasn't in the initial symbols, add it
                res[k] = v
            else:
                # it already was in the symbols
                # let's see if the value was the same
                if (subSyms[k]) != (previous[k]):
                    # the value was not the same,
                    # so we add it a dictionary key
                    res[k] = v

        #-----------------------------
        # return
        #-----------------------------

        res

    else:
        # it's not a dictionary,
        # it's either a normal block or a function block

        #-----------------------------
        # update symbols
        #-----------------------------
        when not isFuncBlock:

            for k, v in pairs(subSyms):
                # if we are explicitly .import-ing, 
                # set symbol no matter what
                when execInParent:
                    syms[k] = v
                else:
                    # update parent only if symbol already existed
                    if previous.hasKey(k):
                        syms[k] = v

            when useArgs:
                # go through the arguments
                for arg in args:
                    # if the symbol already existed restore it
                    # otherwise, remove it
                    if saved.hasKey(arg.s):
                        syms[arg.s] = saved[arg.s]
                    else:
                        syms.del(arg.s)

            when willInject:
                for k,v in pairs(inject[]):
                    if saved.hasKey(k):
                        syms[k] = saved[k]
                    else:
                        syms.del(k)
        else:
            when isPureFunc:
                # nothing will be touched,
                # so let's restore them all
                syms = previous

            else:
                # if the symbol already existed (e.g. nested functions)
                # restore it as we normally would
                for k, v in pairs(subSyms):
                    if saved.hasKey(k):
                        syms[k] = saved[k]

                # if there are exportable variables
                # do set them in parent
                if exports!=VNULL:
                    for k in exports.a:
                        if subSyms.hasKey(k.s):
                            syms[k.s] = subSyms[k.s]

        #-----------------------------
        # return
        #-----------------------------
        if vmReturn:
            when not isFuncBlock:
                return
            else:
                vmReturn = false
                
        subSyms

template execInternal*(path: string): untyped =
    execBlock(doParse(static readFile("src/vm/library/internal/" & path & ".art"), isFile=false))

#=======================================
# Methods
#=======================================

proc initVM*() =
    newSeq(Stack, StackSize)
    SP = 0

    emptyAttrs()

    randomize()

proc showVMErrors*() =
    if vmPanic:
        let errMsg = vmError.split(";").map((x)=>strutils.strip(x)).join(fmt("\n         {fgRed}|{fgWhite} "))
        echo fmt("{fgRed}>> Error |{fgWhite} {errMsg}")
        emptyStack()
        vmPanic = false

proc doExec*(input:Translation, depth: int = 0, withSyms: ptr ValueDict = nil): ValueDict = 

    when defined(VERBOSE):
        if depth==0:
            showDebugHeader("VM")

    let cnst = input[0]
    let it = input[1]

    var i = 0
    var op: OpCode
    var syms: ValueDict
    if withSyms!=nil:
        syms = withSyms[]
    else:
        syms = initOrderedTable[string,Value]()
    var oldSyms: ValueDict

    oldSyms = syms

    while true:
        op = (OpCode)(it[i])

        when defined(VERBOSE):
            echo fmt("exec: {op}")

        case op:
            # [0x0] #
            # stack.push constants 

            of opIPush0         : stack.push(I0)
            of opIPush1         : stack.push(I1)
            of opIPush2         : stack.push(I2)
            of opIPush3         : stack.push(I3)
            of opIPush4         : stack.push(I4)
            of opIPush5         : stack.push(I5)
            of opIPush6         : stack.push(I6)
            of opIPush7         : stack.push(I7)
            of opIPush8         : stack.push(I8)
            of opIPush9         : stack.push(I9)
            of opIPush10        : stack.push(I10)

            of opFPush1         : stack.push(F1)

            of opBPushT         : stack.push(VTRUE)
            of opBPushF         : stack.push(VFALSE)

            of opNPush          : stack.push(VNULL)

            of opEnd            : break

            # [0x1] #
            # stack.push value

            of opPush0, opPush1, opPush2,
               opPush3, opPush4, opPush5,
               opPush6, opPush7, opPush8,
               opPush9, opPush10, opPush11, 
               opPush12, opPush13               :   pushByIndex((int)(op)-(int)(opPush0))

            of opPushX                          :   i += 1; pushByIndex((int)(it[i]))
            of opPushY                          :   i += 2; pushByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

            # [0x2] #
            # store variable (from <- stack)

            of opStore0, opStore1, opStore2,
               opStore3, opStore4, opStore5,
               opStore6, opStore7, opStore8, 
               opStore9, opStore10, opStore11, 
               opStore12, opStore13             :   storeByIndex((int)(op)-(int)(opStore0))

            of opStoreX                         :   i += 1; storeByIndex((int)(it[i]))                
            of opStoreY                         :   i += 2; storeByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

            # [0x3] #
            # load variable (to -> stack)

            of opLoad0, opLoad1, opLoad2,
               opLoad3, opLoad4, opLoad5,
               opLoad6, opLoad7, opLoad8, 
               opLoad9, opLoad10, opLoad11, 
               opLoad12, opLoad13               :   loadByIndex((int)(op)-(int)(opLoad0))

            of opLoadX                          :   i += 1; loadByIndex((int)(it[i]))
            of opLoadY                          :   i += 2; loadByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

            # [0x4] #
            # user function calls

            of opCall0, opCall1, opCall2,
               opCall3, opCall4, opCall5,
               opCall6, opCall7, opCall8, 
               opCall9, opCall10, opCall11, 
               opCall12, opCall13               :   callByIndex((int)(op)-(int)(opCall0))                

            of opCallX                          :   i += 1; callByIndex((int)(it[i]))
            of opCallY                          :   i += 2; callByIndex((int)((uint16)(it[i-1]) shl 8 + (byte)(it[i]))) 

            # [0x5] #
            # arithmetic & logical operations

            of opAdd        : Arithmetic.Add()
            of opSub        : Arithmetic.Sub()
            of opMul        : Arithmetic.Mul()
            of opDiv        : Arithmetic.Div()
            of opFDiv       : Arithmetic.Fdiv()
            of opMod        : Arithmetic.Mod()
            of opPow        : Arithmetic.Pow()                

            of opNeg        : Arithmetic.Neg()

            of opNot        : Logic.IsNot()
            of opAnd        : Logic.IsAnd()
            of opOr         : Logic.IsOr()
            of opXor        : Logic.IsXor()

            of opShl        : Binary.Shl()
            of opShr        : Binary.Shr()

            of opAttr       : 
                i += 1
                let indx = it[i]

                let attr = cnst[indx]
                let val = stack.pop()

                stack.pushAttr(attr.r, val)
                # stack.pushAttr(val)
                # stack.pushAttr(attr)

            of opReturn     : Core.Return()

            # # [0x6] #
            # # stack operations

            of opPop        : Core.Pop()
            of opDup        : stack.push(sTop())
            of opSwap       : swap(Stack[SP-1], Stack[SP-2])
            of opNop        : discard

            # flow control 

            of opJmp        : discard # UNIMPLEMENTED
            of opJmpIf      : discard # UNIMPLEMENTED
        
            of opPush       : Core.Push()

            # # comparison operations

            of opEq         : Comparison.IsEqual()
            of opNe         : Comparison.IsNotEqual()
            of opGt         : Comparison.IsGreater()
            of opGe         : Comparison.IsGreaterOrEqual()
            of opLt         : Comparison.IsLess()
            of opLe         : Comparison.IsLessOrEqual()

            # # structures

            of opArray      : Core.MakeArray()
            of opDictionary : Core.MakeDictionary()
            of opFunction   : Core.MakeFunction()

            # [0x7] #
            # system calls (144 slots)

            of opPrint      : Core.Print()
            of opInspect    : Reflection.Inspect() 

            of opIf         : Core.If()
            of opIsIf       : Core.IsIf()
            of opElse       : Core.Else()

            of opLoop       : Collections.Loop()

            of opDo         : Core.Do() 

            of opMap        : Collections.Map()
            of opSelect     : Collections.Select()
            of opFilter     : Collections.Filter()

            of opSize: Collections.Size()

            of opUpper: Strings.Upper()
            of opLower: Strings.Lower()

            of opGet: Collections.Get()  
            of opSet: Collections.Set()

            of opTo: Conversion.To()
            
            of opEven: Numbers.IsEven()
            of opOdd: Numbers.IsOdd()

            of opRange: Collections.Range()

            of opSum: Numbers.Sum()
            of opProduct: Numbers.Product()
                
            of opExit: Core.Exit()
            of opInfo: Reflection.Info()
            of opType: Reflection.Type()
            of opIs: Reflection.Is()

            of opBNot: Binary.Not()
            of opBAnd: Binary.And()
            of opBOr: Binary.Or()
            of opBXor: Binary.Xor()

            of opFirst: Collections.First()
            of opLast: Collections.Last()
            
            of opUnique: Collections.Unique()
            of opSort: Collections.Sort()

            of opInc: Arithmetic.Inc()
            of opDec: Arithmetic.Dec()

            of opIsSet: Reflection.IsSet()
                
            of opSymbols: Reflection.Symbols()
            of opStack: Reflection.GetStack()

            of opCase: Core.Case()
            of opWhen: Core.IsWhen()

            of opCapitalize: Strings.Capitalize()

            of opRepeat: Core.Repeat()
            of opWhile: Core.While()

            of opRandom: Numbers.Random()

            of opSample: Collections.Sample()
            of opShuffle: Collections.Shuffle()
            of opSlice: Collections.Slice()

            of opClear: Core.Clear()

            of opAll: Collections.IsAll()
            of opAny: Collections.IsAny()

            of opRead: Files.Read()
            of opWrite: Files.Write()

            of opAbs: Numbers.Abs()
            of opAcos: Numbers.Acos()
            of opAcosh: Numbers.Acosh()
            of opAsin: Numbers.Asin()
            of opAsinh: Numbers.Asinh()
            of opAtan: Numbers.Atan()
            of opAtanh: Numbers.Atanh()
            of opCos: Numbers.Cos()
            of opCosh: Numbers.Cosh()
            of opCsec: Numbers.Csec()
            of opCsech: Numbers.Csech()
            of opCtan: Numbers.Ctan()
            of opCtanh: Numbers.Ctanh()
            of opSec: Numbers.Sec()
            of opSech: Numbers.Sech()
            of opSin: Numbers.Sin()
            of opSinh: Numbers.Sinh()
            of opTan: Numbers.Tan()
            of opTanh: Numbers.Tanh()

            of opInput: Core.Input()

            of opPad: Strings.Pad()
            of opReplace: Strings.Replace()
            of opStrip: Strings.Strip()
            of opSplit: Collections.Split()
            of opPrefix: Strings.Prefix()
            of opHasPrefix: Strings.HasPrefix()
            of opSuffix: Strings.Suffix()
            of opHasSuffix: Strings.HasSuffix()

            of opExists: Files.IsExists()

            of opTry: Core.Try()
            of opTryE: Core.TryE()

            of opIsUpper: Strings.IsUpper()
            of opIsLower: Strings.IsLower()

            of opHelp: Reflection.Help()

            of opEmpty: Collections.Empty()
            of opIsEmpty: Collections.IsEmpty()

            of opIn: Collections.In()
            of opIsIn: Collections.IsIn()
            of opIndex: Collections.Index()
            of opHasKey: Collections.HasKey()
            of opReverse: Collections.Reverse()

            of opExecute: Shell.Execute()

            of opPrints: Core.Prints()

            of opBenchmark: Reflection.Benchmark()

            of opJoin: Collections.Join()

            of opMax: Collections.Max()
            of opMin: Collections.Min()

            of opKeys: Collections.Keys()
            of opValues: Collections.Values()

            of opDigest: Crypto.Digest()

            of opAlias: discard

            of opMail: Net.Mail()
            of opDownload: Net.Download()

            of opGetAttr: Reflection.GetAttr()
            of opHasAttr: Reflection.HasAttr()

            of opRender: Strings.Render()

            of opEncode: Crypto.Encode()
            of opDecode: Crypto.Decode()

            of opColor: Strings.Color()

            of opTake: Collections.Take()
            of opDrop: Collections.Drop()

            of opAppend: Collections.Append()
            of opRemove: Collections.Remove()

            of opCombine: Collections.Combine()

            of opList: Shell.List()

            of opFold: Collections.Fold()
            of opSqrt: Numbers.Sqrt()

            of opServe: Net.Serve()

            of opLet: Core.Let()
            of opVar: Core.Var()

            of opNow: Dates.Now()

            of opPause: Core.Pause()

            of opCall: Core.Call()

            of opNew: Core.New()

            of opGetAttrs: Reflection.GetAttrs()

            of opUntil: Core.Until()

            of opGlobalize: Core.Globalize()

            of opRelative: Path.Relative()

            of opAverage: Numbers.Average()
            of opMedian: Numbers.Median()

            of opAs: Conversion.As()

            of opGcd: Numbers.Gcd()
            of opPrime: Numbers.IsPrime()

            of opPermutate: Collections.Permutate()

            of opIsWhitespace: Strings.IsWhitespace()
            of opIsNumeric: Strings.IsNumeric()

            of opFactors: Numbers.Factors()

            of opMatch: Strings.Match()

            of opModule: Path.Module()

            of opWebview: Ui.Webview()

            of opFlatten: Collections.Flatten()

            of opExtra:
                i += 1
                let extra = (OpCode)((int)(it[i])+(int)(opExtra))

                case extra:
                    of opLevenshtein: Strings.Levenshtein()
                    of opNand: Logic.IsNand()
                    of opNor: Logic.IsNor()
                    of opXnor: Logic.IsXnor()

                    of opBNand: Binary.Nand()
                    of opBNor: Binary.Nor()
                    of opBXnor: Binary.Xnor()

                    of opNegative: Numbers.IsNegative()
                    of opPositive: Numbers.IsPositive()
                    of opZero: Numbers.IsZero()

                    of opPanic: Core.Panic()

                    of opOpen: Database.Open()
                    of opQuery: Database.Query()
                    of opClose: Database.Close()

                    of opNative: Core.Native()

                    of opExtract: Path.Extract()

                    else: discard

            else: discard

        i += 1

    when defined(VERBOSE):
        if depth==0:
            showDebugHeader("Stack")

            i = 0
            while i < SP:
                stdout.write fmt("{i}: ")
                var item = Stack[i]

                item.dump(0, false)

                i += 1

            showDebugHeader("Symbols")
            for k,v in syms:
                stdout.write fmt("{k} => ")
                v.dump(0, false)

    return syms
