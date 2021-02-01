######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/exec.nim
######################################################

#=======================================
# Libraries
#=======================================

import asyncdispatch, asynchttpserver
import db_sqlite
import httpClient, json, md5, os
import random, sequtils, smtp
import std/sha1, strformat, strutils, sugar
import tables, times, unicode, uri, xmltree
import nre except toSeq

import extras/bignum, extras/parsetoml

import translator/eval, translator/parse
import vm/bytecode, vm/errors, vm/globals, vm/stack, vm/value

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

proc doExec*(input:Translation, depth: int = 0, args: ValueArray = NoValues): ValueDict

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
        discard execBlock(fun.main, args=fun.params.a, isFuncBlock=true, exports=fun.exports)
    else:
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

proc execBlock*(
    blk             : Value, 
    dictionary      : bool = false, 
    #useArgs         : bool = false, 
    args            : ValueArray = NoValues, 
    #usePreeval      : bool = false, 
    evaluated       : Translation = NoTranslation, 
    execInParent    : bool = false, 
    isFuncBlock     : bool = false, 
    #isBreakable     : bool = false,
    exports         : Value = nil
): ValueDict =
    var newSyms: ValueDict
    try:
        let evaled = 
            if evaluated==NoTranslation : doEval(blk)
            else                        : evaluated

        newSyms = doExec(evaled, 1, args)
    except ReturnTriggered as e:
        # echo "caught:: Return"
        if not isFuncBlock:
            # echo "re-raising"
            raise e
        else:
            # echo "it's function block"
            discard
    finally:
        # echo "processing finalization"
        if dictionary:
            var res: ValueDict = initOrderedTable[string,Value]()
            for k, v in pairs(newSyms):
                if not syms.hasKey(k) or (newSyms[k]!=syms[k]):
                    res[k] = v

            return res
        else:
            if isFuncBlock:
                if not exports.isNil():
                    for k in exports.a:
                        if newSyms.hasKey(k.s):
                            syms[k.s] = newSyms[k.s]
            else:
                if execInParent:
                    syms=newSyms
                else:
                    for k, v in pairs(newSyms):
                        if syms.hasKey(k) and syms[k]!=newSyms[k]:
                            syms[k] = newSyms[k]

    return syms
    #     #-----------------------------
    #     # store previous symbols
    #     #-----------------------------
    #     if (not isFuncBlock and not execInParent):
    #         # save previous symbols 
    #         previous = syms

    #     #-----------------------------
    #     # pre-process arguments
    #     #-----------------------------
    #     if useArgs:
    #         var saved = initOrderedTable[string,Value]()
    #         for arg in args:
    #             let symIndx = arg.s

    #             # if argument already exists, save it
    #             if syms.hasKey(symIndx):
    #                 saved[symIndx] = syms[symIndx]

    #             # pop argument and set it
    #             syms[symIndx] = stack.pop()

    #             # properly set arity, if argument is a function
    #             if syms[symIndx].kind==Function:
    #                 Funcs[symIndx] = syms[symIndx].params.a.len 

    #     #-----------------------------
    #     # pre-process injections
    #     #-----------------------------
    #     if willInject:
    #         if not useArgs:
    #             saved = initOrderedTable[string,Value]()

    #         for k,v in pairs(inject[]):
    #             if syms.hasKey(k):
    #                 saved[k] = syms[k]

    #             syms[k] = v

    #             if syms[k].kind==Function:
    #                 Funcs[k] = syms[k].params.a.len

    #     #-----------------------------
    #     # evaluate block
    #     #-----------------------------
    #     let evaled = 
    #         if not usePreeval:    doEval(blk)
    #         else:                   evaluated

    #     #-----------------------------
    #     # execute it
    #     #-----------------------------

    #     if isIsolated:
    #         subSyms = doExec(evaled, 1)#depth+1)#, nil)
    #     else:
    #         subSyms = doExec(evaled, 1)#depth+1)#, addr syms)
    # except ReturnTriggered as e:
    #     #echo "caught: ReturnTriggered"
    #     if not isFuncBlock:
    #         #echo "\tnot a Function - re-emitting"
    #         raise e
    #     else:
    #         #echo "\tit's a function, that was it"
    #         discard
    # finally:
    #     #echo "\tperforming housekeeping"
    #     #-----------------------------
    #     # handle result
    #     #-----------------------------

    #     if dictionary:
    #         # it's specified as a dictionary,
    #         # so let's handle it this way

    #         var res: ValueDict = initOrderedTable[string,Value]()

    #         for k, v in pairs(subSyms):
    #             if not previous.hasKey(k):
    #                 # it wasn't in the initial symbols, add it
    #                 res[k] = v
    #             else:
    #                 # it already was in the symbols
    #                 # let's see if the value was the same
    #                 if (subSyms[k]) != (previous[k]):
    #                     # the value was not the same,
    #                     # so we add it a dictionary key
    #                     res[k] = v

    #         #-----------------------------
    #         # return
    #         #-----------------------------

    #         return res

    #     else:
    #         # it's not a dictionary,
    #         # it's either a normal block or a function block

    #         #-----------------------------
    #         # update symbols
    #         #-----------------------------
    #         if not isFuncBlock:

    #             for k, v in pairs(subSyms):
    #                 # if we are explicitly .import-ing, 
    #                 # set symbol no matter what
    #                 if execInParent:
    #                     syms[k] = v
    #                 else:
    #                     # update parent only if symbol already existed
    #                     if previous.hasKey(k):
    #                         syms[k] = v

    #             if useArgs:
    #                 # go through the arguments
    #                 for arg in args:
    #                     # if the symbol already existed restore it
    #                     # otherwise, remove it
    #                     if saved.hasKey(arg.s):
    #                         syms[arg.s] = saved[arg.s]
    #                     else:
    #                         syms.del(arg.s)

    #             if willInject:
    #                 for k,v in pairs(inject[]):
    #                     if saved.hasKey(k):
    #                         syms[k] = saved[k]
    #                     else:
    #                         syms.del(k)
    #         else:
    #             # if the symbol already existed (e.g. nested functions)
    #             # restore it as we normally would
    #             for k, v in pairs(subSyms):
    #                 if saved.hasKey(k):
    #                     syms[k] = saved[k]

    #             # if there are exportable variables
    #             # do set them in parent
    #             if exports!=VNULL:
    #                 for k in exports.a:
    #                     if subSyms.hasKey(k.s):
    #                         syms[k.s] = subSyms[k.s]

    #         # #-----------------------------
    #         # # break / continue
    #         # #-----------------------------
    #         # if vmBreak or vmContinue:
    #         #     when not isBreakable:
    #         #         return
                    
    #         # #-----------------------------
    #         # # return
    #         # #-----------------------------
    #         # if vmReturn:
    #         #     when not isFuncBlock:
    #         #         return
    #         #     else:
    #         #         vmReturn = false
                    
    #         return subSyms

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

proc printSyms*(vv:ValueDict, message: string)=
    echo "============================"
    echo message
    echo "============================"
    for k,v in pairs(vv):
        if k!="path" and k!="arg" and k!="sys" and k!="null" and k!="true" and k!="false" and k!="pi" and not (v.kind==Function and v.fnKind==BuiltinFunction):
            echo k & " => " & $(v)
    echo "----------------------------"

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

proc doExec*(input:Translation, depth: int = 0, args: ValueArray = NoValues): ValueDict = 
    #syms.printSyms("In doExec")
    when defined(VERBOSE):
        if depth==0:
            showDebugHeader("VM")

    let cnst = input[0]
    let it = input[1]

    var i = 0
    var op: OpCode
    var oldSyms: ValueDict

    oldSyms = syms

    if args!=NoValues:
        for arg in args:
            let symIndx = arg.s

            # pop argument and set it
            syms[symIndx] = stack.pop()

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

            of opAttr       : 
                i += 1
                let indx = it[i]

                let attr = cnst[indx]
                let val = stack.pop()

                stack.pushAttr(attr.r, val)


            of opPop        : discard #Core.Pop()
            of opDup        : stack.push(sTop())
            of opSwap       : swap(Stack[SP-1], Stack[SP-2])
            of opNop        : discard

            of opGet: syms["get"].action() #discard #Collections.Get()  
            of opSet: syms["set"].action() #discard #Collections.Set()

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

    let newSyms = syms
    syms = oldSyms

    #newSyms.printSyms("newSyms")
    #syms.printSyms("oldSyms -> syms")
    return newSyms

    # var newSyms: ValueDict = initOrderedTable[string,Value]()

    # for k,v in pairs(syms):
    #     if not oldSyms.hasKey(k) or oldSyms[k]!=syms[k]:
    #         echo "new: " & k & " = " & $(v)
    #         newSyms[k] = v

    # echo "-------"

    # return newSyms
    