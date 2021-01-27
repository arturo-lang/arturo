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

import extras/bignum, extras/miniz, extras/parsetoml

when not defined(MINI):
    import extras/webview

import helpers/arrays       as arraysHelper   
import helpers/csv          as csvHelper
import helpers/database     as databaseHelper
import helpers/datasource   as datasourceHelper
import helpers/html         as htmlHelper
import helpers/json         as jsonHelper
import helpers/markdown     as markdownHelper
import helpers/math         as mathHelper
import helpers/path         as pathHelper
import helpers/strings      as stringsHelper
import helpers/toml         as tomlHelper
import helpers/unisort      as unisortHelper
import helpers/url          as urlHelper
import helpers/webview      as webviewHelper
import helpers/xml          as xmlHelper

import library/[
    Core, 
    Reflection
]

import translator/eval, translator/parse
import vm/bytecode, vm/globals, vm/stack, vm/value

import utils    

#=======================================
# Globals
#=======================================

var
    vmPanic* = false
    vmError* = ""
    vmReturn* = false
    vmBreak* = false
    vmContinue* = false

#=======================================
# Helpers
#=======================================

template panic*(error: string): untyped =
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
    if fun.fnKind==UserFunction:
        if fun.pure:
            discard execBlock(fun.main, useArgs=true, args=fun.params.a, isFuncBlock=true, exports=fun.exports, isPureFunc=true)
        else:
            discard execBlock(fun.main, useArgs=true, args=fun.params.a, isFuncBlock=true, exports=fun.exports, isPureFunc=false)
    else:
        #echo "exec:builtin: " & $(symIndx)
        fun.action()

####

template require*(op: OpCode, nopop: bool = false): untyped =
    if SP<(static OpSpecs[op].args):
        panic "cannot perform '" & (static OpSpecs[op].name) & "'; not enough parameters: " & $(static OpSpecs[op].args) & " required"

    when (static OpSpecs[op].args)>=1:
        when not (ANY in static OpSpecs[op].a):
            if not (Stack[SP-1].kind in (static OpSpecs[op].a)):
                let acceptStr = toSeq((OpSpecs[op].a).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                panic "cannot perform '" & (static OpSpecs[op].name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " ...; incorrect argument type for 1st parameter; accepts " & acceptStr

        when (static OpSpecs[op].args)>=2:
            when not (ANY in static OpSpecs[op].b):
                if not (Stack[SP-2].kind in (static OpSpecs[op].b)):
                    let acceptStr = toSeq((OpSpecs[op].b).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                    panic "cannot perform '" & (static OpSpecs[op].name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " :" & ($(Stack[SP-2].kind)).toLowerAscii() & " ...; incorrect argument type for 2nd parameter; accepts " & acceptStr
                    break

            when (static OpSpecs[op].args)>=3:
                when not (ANY in static OpSpecs[op].c):
                    if not (Stack[SP-3].kind in (static OpSpecs[op].c)):
                        let acceptStr = toSeq((OpSpecs[op].c).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                        panic "cannot perform '" & (static OpSpecs[op].name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " :" & ($(Stack[SP-2].kind)).toLowerAscii() & " :" & ($(Stack[SP-3].kind)).toLowerAscii() & " ...; incorrect argument type for third parameter; accepts " & acceptStr

    when not nopop:
        when (static OpSpecs[op].args)>=1:
            var x {.inject.} = stack.pop()
        when (static OpSpecs[op].args)>=2:
            var y {.inject.} = stack.pop()
        when (static OpSpecs[op].args)>=3:
            var z {.inject.} = stack.pop()

# template execDictionary(
#     blk             : Value
# ): untyped = 
    
#     let previous = syms
#     echo "SAVING CURRENT SYMS @previous"
#     for k,v in pairs(previous):
#         echo "-- had " & k

#     let evaled = doEval(blk)
#     let subSyms = doExec(evaled, depth+1, addr syms)
#     echo "GOT subSyms AFTER doExec"
#     for k,v in pairs(subSyms):
#         echo "-- has " & k

#     # it's specified as a dictionary,
#     # so let's handle it this way

#     var res: ValueDict = initOrderedTable[string,Value]()

#     for k, v in pairs(subSyms):
#         if not previous.hasKey(k):
#             # it wasn't in the initial symbols, add it
#             res[k] = v
#         else:
#             # it already was in the symbols
#             # let's see if the value was the same
#             if (subSyms[k]) != (previous[k]):
#                 echo "value " & (k) & " already existed BUT CHANGED! (!= true)"
#                 # the value was not the same,
#                 # so we add it a dictionary key
#                 res[k] = v

#     echo "RETURN dictionary"
#     for k,v in pairs(res):
#         echo "-- with " & k

#     res


template execBlock*(
    blk             : Value, 
    dictionary      : bool = false, 
    useArgs         : bool = false, 
    args            : ValueArray = NoValues, 
    usePreeval      : bool = false, 
    evaluated       : Translation = NoTranslation, 
    execInParent    : bool = false, 
    isFuncBlock     : bool = false, 
    isBreakable     : bool = false,
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
        let subSyms = doExec(evaled, 1)#depth+1)#, nil)
    else:
        let subSyms = doExec(evaled, 1)#depth+1)#, addr syms)

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
        # break / continue
        #-----------------------------
        if vmBreak or vmContinue:
            when not isBreakable:
                return
                
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

template checkForBreak*(): untyped =
    if vmBreak:
        vmBreak = false
        break

    if vmContinue:
        vmContinue = false

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

proc doExec*(input:Translation, depth: int = 0): ValueDict = 

    when defined(VERBOSE):
        if depth==0:
            showDebugHeader("VM")

    let cnst = input[0]
    let it = input[1]

    var i = 0
    var op: OpCode
    var oldSyms: ValueDict

    oldSyms = syms

    while true:
        if vmBreak:
            break

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

            of opAdd        : discard #Arithmetic.Add()
            of opSub        : discard #Arithmetic.Sub()
            of opMul        : discard #Arithmetic.Mul()
            of opDiv        : discard #Arithmetic.Div()
            of opFDiv       : discard #Arithmetic.Fdiv()
            of opMod        : discard #Arithmetic.Mod()
            of opPow        : discard #Arithmetic.Pow()                

            of opNeg        : discard #Arithmetic.Neg()

            of opNot        : discard #Logic.IsNot()
            of opAnd        : discard #Logic.IsAnd()
            of opOr         : discard #Logic.IsOr()
            of opXor        : discard #Logic.IsXor()

            of opShl        : discard #Binary.Shl()
            of opShr        : discard #Binary.Shr()

            of opAttr       : 
                i += 1
                let indx = it[i]

                let attr = cnst[indx]
                let val = stack.pop()

                stack.pushAttr(attr.r, val)

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

            of opEq         : discard #Comparison.IsEqual()
            of opNe         : discard #Comparison.IsNotEqual()
            of opGt         : discard #Comparison.IsGreater()
            of opGe         : discard #Comparison.IsGreaterOrEqual()
            of opLt         : discard #Comparison.IsLess()
            of opLe         : discard #Comparison.IsLessOrEqual()

            # # structures

            of opArray      : Core.MakeArray()
            of opDictionary : Core.MakeDictionary()
            of opFunction   : Core.MakeFunction()

            # [0x7] #
            # system calls (144 slots)

            of opPrint      : discard #Core.Print()
            of opInspect    : Reflection.Inspect() 

            of opIf         : Core.If()
            of opIsIf       : Core.IsIf()
            of opElse       : Core.Else()

            of opLoop       : discard #Collections.Loop()

            of opDo         : Core.Do() 

            of opMap        : discard #Collections.Map()
            of opSelect     : discard #Collections.Select()
            of opFilter     : discard #Collections.Filter()

            of opSize: discard #Collections.Size()

            of opUpper: discard #Strings.Upper()
            of opLower: discard #Strings.Lower()

            of opGet: syms["get"].action() #discard #Collections.Get()  
            of opSet: syms["set"].action() #discard #Collections.Set()

            of opTo: Conversion.To()
            
            of opEven: discard #Numbers.IsEven()
            of opOdd: discard #Numbers.IsOdd()

            of opRange: discard #Collections.Range()

            of opSum: discard #Numbers.Sum()
            of opProduct: discard #Numbers.Product()
                
            of opExit: Core.Exit()
            of opInfo: Reflection.Info()
            of opType: Reflection.Type()
            of opIs: Reflection.Is()

            of opBNot: discard #Binary.Not()
            of opBAnd: discard #Binary.And()
            of opBOr: discard #Binary.Or()
            of opBXor: discard #Binary.Xor()

            of opFirst: discard #Collections.First()
            of opLast: discard #Collections.Last()
            
            of opUnique: discard #Collections.Unique()
            of opSort: discard #Collections.Sort()

            of opInc: discard #Arithmetic.Inc()
            of opDec: discard #Arithmetic.Dec()

            of opIsSet: Reflection.IsSet()
                
            of opSymbols: Reflection.Symbols()
            of opStack: Reflection.GetStack()

            of opCase: Core.Case()
            of opWhen: Core.IsWhen()

            of opCapitalize: discard #Strings.Capitalize()

            of opRepeat: discard #Collections.Repeat()
            of opWhile: Core.While()

            of opRandom: discard #Numbers.Random()

            of opSample: discard #Collections.Sample()
            of opShuffle: discard #Collections.Shuffle()
            of opSlice: discard #Collections.Slice()

            of opClear: discard #Core.Clear()

            of opAll: discard #Collections.IsAll()
            of opAny: discard #Collections.IsAny()

            of opRead: discard #Files.Read()
            of opWrite: discard #Files.Write()

            of opAbs: discard #Numbers.Abs()
            of opAcos: discard #Numbers.Acos()
            of opAcosh: discard #Numbers.Acosh()
            of opAsin: discard #Numbers.Asin()
            of opAsinh: discard #Numbers.Asinh()
            of opAtan: discard #Numbers.Atan()
            of opAtanh: discard #Numbers.Atanh()
            of opCos: discard #Numbers.Cos()
            of opCosh: discard #Numbers.Cosh()
            of opCsec: discard #Numbers.Csec()
            of opCsech: discard #Numbers.Csech()
            of opCtan: discard #Numbers.Ctan()
            of opCtanh: discard #Numbers.Ctanh()
            of opSec: discard #Numbers.Sec()
            of opSech: discard #Numbers.Sech()
            of opSin: discard #Numbers.Sin()
            of opSinh: discard #Numbers.Sinh()
            of opTan: discard #Numbers.Tan()
            of opTanh: discard #Numbers.Tanh()

            of opInput: discard #Core.Input()

            of opPad: discard #Strings.Pad()
            of opReplace: discard #Strings.Replace()
            of opStrip: discard #Strings.Strip()
            of opSplit: discard #Collections.Split()
            of opPrefix: discard #Strings.Prefix()
            of opHasPrefix: discard #Strings.HasPrefix()
            of opSuffix: discard #Strings.Suffix()
            of opHasSuffix: discard #Strings.HasSuffix()

            of opExists: discard #Files.IsExists()

            of opTry: Core.Try()
            of opTryE: Core.TryE()

            of opIsUpper: discard #Strings.IsUpper()
            of opIsLower: discard #Strings.IsLower()

            of opHelp: Reflection.Help()

            of opEmpty: discard #Collections.Empty()
            of opIsEmpty: discard #Collections.IsEmpty()

            of opInsert: discard #Collections.Insert()
            of opIsIn: discard #Collections.IsIn()
            of opIndex: discard #Collections.Index()
            of opHasKey: discard #Collections.HasKey()
            of opReverse: discard #Collections.Reverse()

            of opExecute: discard #Shell.Execute()

            of opPrints: discard #Core.Prints()

            of opBenchmark: Reflection.Benchmark()

            of opJoin: discard #Collections.Join()

            of opMax: discard #Collections.Max()
            of opMin: discard #Collections.Min()

            of opKeys: discard #Collections.Keys()
            of opValues: discard #Collections.Values()

            of opDigest: discard #Crypto.Digest()

            of opAlias: discard

            of opMail: discard #Net.Mail()
            of opDownload: discard #Net.Download()

            of opGetAttr: Reflection.GetAttr()
            of opHasAttr: Reflection.HasAttr()

            of opRender: discard #Strings.Render()

            of opEncode: discard #Crypto.Encode()
            of opDecode: discard #Crypto.Decode()

            of opColor: discard #Strings.Color()

            of opTake: discard #Collections.Take()
            of opDrop: discard #Collections.Drop()

            of opAppend: discard #Collections.Append()
            of opRemove: discard #Collections.Remove()

            of opCombine: discard #Collections.Combine()

            of opList: discard #Shell.List()

            of opFold: discard #Collections.Fold()
            of opSqrt: discard #Numbers.Sqrt()

            of opServe: discard #Net.Serve()

            of opLet: Core.Let()
            of opVar: Core.Var()

            of opNow: discard #Dates.Now()

            of opPause: Core.Pause()

            of opCall: Core.Call()

            of opNew: Core.New()

            of opGetAttrs: Reflection.GetAttrs()

            of opUntil: Core.Until()

            of opGlobalize: Core.Globalize()

            of opRelative: discard #Path.Relative()

            of opAverage: discard #Numbers.Average()
            of opMedian: discard #Numbers.Median()

            of opAs: Conversion.As()

            of opGcd: discard #Numbers.Gcd()
            of opPrime: discard #Numbers.IsPrime()

            of opPermutate: discard #Collections.Permutate()

            of opIsWhitespace: discard #Strings.IsWhitespace()
            of opIsNumeric: discard #Strings.IsNumeric()

            of opFactors: discard #Numbers.Factors()

            of opMatch: discard #Strings.Match()

            of opModule: discard #Path.Module()

            of opWebview: discard #Ui.Webview()

            of opFlatten: discard #Collections.Flatten()

            of opExtra:
                i += 1
                let extra = (OpCode)((int)(it[i])+(int)(opExtra))

                case extra:
                    of opLevenshtein: discard #Strings.Levenshtein()
                    of opNand: discard #Logic.IsNand()
                    of opNor: discard #Logic.IsNor()
                    of opXnor: discard #Logic.IsXnor()

                    of opBNand: discard #Binary.Nand()
                    of opBNor: discard #Binary.Nor()
                    of opBXnor: discard #Binary.Xnor()

                    of opNegative: discard #Numbers.IsNegative()
                    of opPositive: discard #Numbers.IsPositive()
                    of opZero: discard #Numbers.IsZero()

                    of opPanic: Core.Panic()

                    of opOpen: discard #Database.Open()
                    of opQuery: discard #Database.Query()
                    of opClose: discard #Database.Close()

                    of opNative: Core.Native()

                    of opExtract: discard #Path.Extract()

                    of opZip: discard #Files.Zip()
                    of opUnzip: discard #Files.Unzip()

                    of opGetHash: discard #Crypto.GetHash()

                    of opExtend: discard #Collections.Extend()

                    of opIsTrue: discard #Logic.IsTrue()
                    of opIsFalse: discard #Logic.IsFalse()

                    of opIsNull: Reflection.IsNull()
                    of opIsBoolean: Reflection.IsBoolean()
                    of opIsInteger: Reflection.IsInteger()
                    of opIsFloating: Reflection.IsFloating()
                    of opIsType: Reflection.IsType()
                    of opIsChar: Reflection.IsChar()
                    of opIsString: Reflection.IsString()
                    of opIsWord: Reflection.IsWord()
                    of opIsLiteral: Reflection.IsLiteral()
                    of opIsLabel: Reflection.IsLabel()
                    of opIsAttribute: Reflection.IsAttribute()
                    of opIsAttributeLabel: Reflection.IsAttributeLabel()
                    of opIsPath: Reflection.IsPath()
                    of opIsPathLabel: Reflection.IsPathLabel()
                    of opIsSymbol: Reflection.IsSymbol()
                    of opIsDate: Reflection.IsDate()
                    of opIsBinary: Reflection.IsBinary()
                    of opIsDictionary: Reflection.IsDictionary()
                    of opIsFunction: Reflection.IsFunction()
                    of opIsInline: Reflection.IsInline()
                    of opIsBlock: Reflection.IsBlock()
                    of opIsDatabase: Reflection.IsDatabase() 

                    of opBreak: Core.Break()
                    of opContinue: Core.Continue()

                    of opIsStandalone: Reflection.IsStandalone()

                    of opPi: discard #Numbers.GetPi()

                    of opIsContains: discard #Collections.IsContains()

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
    