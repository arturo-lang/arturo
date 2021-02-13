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

import math, tables

when defined(VERBOSE):
    import strformat
    import helpers/debug as debugHelper

import vm/[bytecode, errors, eval, globals, parse, stack, value]

#=======================================
# Globals
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
    let item = Syms.getOrDefault(symIndx)
    if item.isNil: panic "symbol not found: " & symIndx
    stack.push(Syms[symIndx])

template callByIndex(idx: int):untyped =
    let symIndx = cnst[idx].s

    let fun = Syms.getOrDefault(symIndx)
    if fun.isNil: panic "symbol not found: " & symIndx
    if fun.fnKind==UserFunction:
        discard execBlock(fun.main, args=fun.params.a, isFuncBlock=true, exports=fun.exports)
    else:
        fun.action()

template fetchAttributeByIndex(idx: int):untyped =
    let attr = cnst[idx]
    let val = stack.pop()

    stack.pushAttr(attr.r, val)

####

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
        if isFuncBlock:
            for i,arg in args:            
                if stack.peek(i).kind==Function:
                    Arities[arg.s] = stack.peek(i).params.a.len

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
                if not exports.isNil():
                    for k in exports.a:
                        if newSyms.hasKey(k.s):
                            Syms[k.s] = newSyms[k.s]
                else:
                    for arg in args:
                        Arities.del(arg.s)

            else:
                if execInParent:
                    Syms=newSyms
                else:
                    for k, v in pairs(newSyms):
                        if Syms.hasKey(k) and Syms[k]!=newSyms[k]:
                            Syms[k] = newSyms[k]

    return Syms

    # TODO(Exec\execBlock) verify functionality and remove previous code
    #  The actual implementation seems to be working fine but needs verification. Also, flow breaks need to be taken care of.
    #  labels: vm,enhancement,unit-test,cleanup
    #     #-----------------------------
    #     # store previous symbols
    #     #-----------------------------
    #     if (not isFuncBlock and not execInParent):
    #         # save previous symbols 
    #         previous = Syms

    #     #-----------------------------
    #     # pre-process arguments
    #     #-----------------------------
    #     if useArgs:
    #         var saved = initOrderedTable[string,Value]()
    #         for arg in args:
    #             let symIndx = arg.s

    #             # if argument already exists, save it
    #             if Syms.hasKey(symIndx):
    #                 saved[symIndx] = Syms[symIndx]

    #             # pop argument and set it
    #             Syms[symIndx] = stack.pop()

    #             # properly set arity, if argument is a function
    #             if Syms[symIndx].kind==Function:
    #                 Funcs[symIndx] = Syms[symIndx].params.a.len 

    #     #-----------------------------
    #     # pre-process injections
    #     #-----------------------------
    #     if willInject:
    #         if not useArgs:
    #             saved = initOrderedTable[string,Value]()

    #         for k,v in pairs(inject[]):
    #             if Syms.hasKey(k):
    #                 saved[k] = Syms[k]

    #             Syms[k] = v

    #             if Syms[k].kind==Function:
    #                 Funcs[k] = Syms[k].params.a.len

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
    #         subSyms = doExec(evaled, 1)#depth+1)#, addr Syms)
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
    #                     Syms[k] = v
    #                 else:
    #                     # update parent only if symbol already existed
    #                     if previous.hasKey(k):
    #                         Syms[k] = v

    #             if useArgs:
    #                 # go through the arguments
    #                 for arg in args:
    #                     # if the symbol already existed restore it
    #                     # otherwise, remove it
    #                     if saved.hasKey(arg.s):
    #                         Syms[arg.s] = saved[arg.s]
    #                     else:
    #                         Syms.del(arg.s)

    #             if willInject:
    #                 for k,v in pairs(inject[]):
    #                     if saved.hasKey(k):
    #                         Syms[k] = saved[k]
    #                     else:
    #                         Syms.del(k)
    #         else:
    #             # if the symbol already existed (e.g. nested functions)
    #             # restore it as we normally would
    #             for k, v in pairs(subSyms):
    #                 if saved.hasKey(k):
    #                     Syms[k] = saved[k]

    #             # if there are exportable variables
    #             # do set them in parent
    #             if exports!=VNULL:
    #                 for k in exports.a:
    #                     if subSyms.hasKey(k.s):
    #                         Syms[k.s] = subSyms[k.s]

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

proc doExec*(input:Translation, depth: int = 0, args: ValueArray = NoValues): ValueDict = 
    #Syms.printSyms("In doExec")
    when defined(VERBOSE):
        if depth==0:
            showDebugHeader("VM")

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

    while true:
        if vmBreak:
            break

        op = (OpCode)(it[i])

        when defined(VERBOSE):
            echo fmt("exec: {op}")

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

            of opConstI1M       : stack.push(I1M)
            of opConstF1        : stack.push(F1)

            of opConstBT        : stack.push(VTRUE)
            of opConstBF        : stack.push(VFALSE)

            of opConstN         : stack.push(VNULL)

            # [0x10-0x2F]
            # push values
            of opPush0..opPush30    : pushByIndex((int)(op)-(int)(opPush0))
            of opPush               : i += 1; pushByIndex((int)(it[i]))

            # [0x30-0x4F]
            # store variables (from <- stack)
            of opStore0..opStore30  : storeByIndex((int)(op)-(int)(opStore0))
            of opStore              : i += 1; storeByIndex((int)(it[i]))                

            # [0x50-0x6F]
            # load variables (to -> stack)
            of opLoad0..opLoad30    : loadByIndex((int)(op)-(int)(opLoad0))
            of opLoad               : i += 1; loadByIndex((int)(it[i]))

            # [0x70-0x8F]
            # function calls
            of opCall0..opCall30    : callByIndex((int)(op)-(int)(opCall0))                
            of opCall               : i += 1; callByIndex((int)(it[i]))

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
                if stack.pop().b: 
                    i = (int)(it[i+1])-1
            of opJumpIfNot          : 
                if not stack.pop().b: 
                    i = (int)(it[i+1])-1
            of opRet                : discard    
            of opEnd                : break 

            # reserved
            of opRsrv0..opRsrv3     : discard

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
            of opRsrv4..opRsrv5     : discard

            # [0xB0-BF] #
            # comparison operators
            of opEq                 : stack.push(newBoolean(Stack[SP-1]==Stack[SP-2]))
            of opNe                 : stack.push(newBoolean(Stack[SP-1]!=Stack[SP-2]))
            of opGt                 : stack.push(newBoolean(Stack[SP-1]>Stack[SP-2]))
            of opGe                 : stack.push(newBoolean(Stack[SP-1]>=Stack[SP-2]))
            of opLt                 : stack.push(newBoolean(Stack[SP-1]<Stack[SP-2]))
            of opLe                 : stack.push(newBoolean(Stack[SP-1]<=Stack[SP-2]))

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
            for k,v in Syms:
                stdout.write fmt("{k} => ")
                v.dump(0, false)

    let newSyms = Syms
    Syms = oldSyms

    #newSyms.printSyms("newSyms")
    #Syms.printSyms("oldSyms -> Syms")
    return newSyms

    # var newSyms: ValueDict = initOrderedTable[string,Value]()

    # for k,v in pairs(Syms):
    #     if not oldSyms.hasKey(k) or oldSyms[k]!=Syms[k]:
    #         echo "new: " & k & " = " & $(v)
    #         newSyms[k] = v

    # echo "-------"

    # return newSyms
    