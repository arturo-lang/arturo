#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/opcodes.nim
#=======================================================

## VM OpCodes definition and utilities.

#=======================================
# Libraries
#=======================================

import hashes, strutils

import vm/values/custom/[vregex]

#=======================================
# Types 
#=======================================

type 
    OpCode* = enum

        #-------------------------------------------------------------------------#
        #                                                      STACK              #
        #-------------------------------------------------------------------------#
        # Name          # Code      # Parameters        # Before    # After       #
        #-------------------------------------------------------------------------#

        # [0x00-0x1F]
        # push constants 
        opConstI1M      = 0x00      # ()                #                   # -1
        opConstI0       = 0x01      # ()                #                   # 0 
        opConstI1       = 0x02      # ()                #                   # 1
        opConstI2       = 0x03      # ()                #                   # 2
        opConstI3       = 0x04      # ()                #                   # 3
        opConstI4       = 0x05      # ()                #                   # 4
        opConstI5       = 0x06      # ()                #                   # 5
        opConstI6       = 0x07      # ()                #                   # 6
        opConstI7       = 0x08      # ()                #                   # 7
        opConstI8       = 0x09      # ()                #                   # 8
        opConstI9       = 0x0A      # ()                #                   # 9
        opConstI10      = 0x0B      # ()                #                   # 10
        opConstI11      = 0x0C      # ()                #                   # 11
        opConstI12      = 0x0D      # ()                #                   # 12
        opConstI13      = 0x0E      # ()                #                   # 13
        opConstI14      = 0x0F      # ()                #                   # 14
        opConstI15      = 0x10      # ()                #                   # 15

        opConstF1M      = 0x11      # ()                #                   # -1.0
        opConstF0       = 0x12      # ()                #                   # 0.0
        opConstF1       = 0x13      # ()                #                   # 1.0
        opConstF2       = 0x14      # ()                #                   # 2.0

        opConstBT       = 0x15      # ()                #                   # true
        opConstBF       = 0x16      # ()                #                   # false
        opConstBM       = 0x17      # ()                #                   # maybe

        opConstS        = 0x18      # ()                #                   # ""
        opConstA        = 0x19      # ()                #                   # []
        opConstD        = 0x1A      # ()                #                   # #[]

        opConstN        = 0x1B      # ()                #                   # null

        # lines & error reporting
        opEol           = 0x1C      # (line)            #                   #
        opEolX          = 0x1D      # (line,lineB)      #                   #

        # dictionary keys storage

        opDStore        = 0x1E      # (idx)             # rvalue            #
        opDStoreX       = 0x1F      # (idx,idxB)        # rvalue            #
 
        # [0x20-0x2F]
        # push values
        opPush0         = 0x20      # ()                #                   # value
        opPush1         = 0x21      # ()                #                   # value
        opPush2         = 0x22      # ()                #                   # value
        opPush3         = 0x23      # ()                #                   # value
        opPush4         = 0x24      # ()                #                   # value
        opPush5         = 0x25      # ()                #                   # value
        opPush6         = 0x26      # ()                #                   # value
        opPush7         = 0x27      # ()                #                   # value
        opPush8         = 0x28      # ()                #                   # value
        opPush9         = 0x29      # ()                #                   # value
        opPush10        = 0x2A      # ()                #                   # value
        opPush11        = 0x2B      # ()                #                   # value
        opPush12        = 0x2C      # ()                #                   # value
        opPush13        = 0x2D      # ()                #                   # value

        opPush          = 0x2E      # (idx)             #                   # value
        opPushX         = 0x2F      # (idx,idxB)        #                   # value

        # [0x30-3F]
        # store variables (from <- stack)
        opStore0        = 0x30      # ()                # rvalue            #
        opStore1        = 0x31      # ()                # rvalue            #
        opStore2        = 0x32      # ()                # rvalue            #
        opStore3        = 0x33      # ()                # rvalue            #
        opStore4        = 0x34      # ()                # rvalue            #
        opStore5        = 0x35      # ()                # rvalue            #
        opStore6        = 0x36      # ()                # rvalue            #
        opStore7        = 0x37      # ()                # rvalue            #
        opStore8        = 0x38      # ()                # rvalue            #
        opStore9        = 0x39      # ()                # rvalue            #
        opStore10       = 0x3A      # ()                # rvalue            #
        opStore11       = 0x3B      # ()                # rvalue            #
        opStore12       = 0x3C      # ()                # rvalue            #
        opStore13       = 0x3D      # ()                # rvalue            #

        opStore         = 0x3E      # (idx)             # rvalue            #
        opStoreX        = 0x3F      # (idx,idxB)        # rvalue            #

        # [0x40-0x4F]
        # load variables (to -> stack)
        opLoad0         = 0x40      # ()                #                   # value
        opLoad1         = 0x41      # ()                #                   # value
        opLoad2         = 0x42      # ()                #                   # value
        opLoad3         = 0x43      # ()                #                   # value
        opLoad4         = 0x44      # ()                #                   # value
        opLoad5         = 0x45      # ()                #                   # value
        opLoad6         = 0x46      # ()                #                   # value
        opLoad7         = 0x47      # ()                #                   # value
        opLoad8         = 0x48      # ()                #                   # value
        opLoad9         = 0x49      # ()                #                   # value
        opLoad10        = 0x4A      # ()                #                   # value
        opLoad11        = 0x4B      # ()                #                   # value  
        opLoad12        = 0x4C      # ()                #                   # value
        opLoad13        = 0x4D      # ()                #                   # value
        
        opLoad          = 0x4E      # (idx)             #                   # value
        opLoadX         = 0x4F      # (idx,idxB)        #                   # value

        # [0x50-0x5F]
        # store-load variables (from <- stack, without popping)
        opStorl0        = 0x50      # ()                #                   # 
        opStorl1        = 0x51      # ()                #                   #
        opStorl2        = 0x52      # ()                #                   #
        opStorl3        = 0x53      # ()                #                   #
        opStorl4        = 0x54      # ()                #                   #
        opStorl5        = 0x55      # ()                #                   #
        opStorl6        = 0x56      # ()                #                   #
        opStorl7        = 0x57      # ()                #                   #
        opStorl8        = 0x58      # ()                #                   #
        opStorl9        = 0x59      # ()                #                   #
        opStorl10       = 0x5A      # ()                #                   #
        opStorl11       = 0x5B      # ()                #                   #
        opStorl12       = 0x5C      # ()                #                   #
        opStorl13       = 0x5D      # ()                #                   #

        opStorl         = 0x5E      # (idx)             #                   #
        opStorlX        = 0x5F      # (idx,idxB)        #                   #

        # [0x60-0x6F]
        # function calls
        opCall0         = 0x60      # ()                # X,...             # A,...
        opCall1         = 0x61      # ()                # X,...             # A,...
        opCall2         = 0x62      # ()                # X,...             # A,...
        opCall3         = 0x63      # ()                # X,...             # A,...
        opCall4         = 0x64      # ()                # X,...             # A,...
        opCall5         = 0x65      # ()                # X,...             # A,...
        opCall6         = 0x66      # ()                # X,...             # A,...
        opCall7         = 0x67      # ()                # X,...             # A,...
        opCall8         = 0x68      # ()                # X,...             # A,...
        opCall9         = 0x69      # ()                # X,...             # A,...
        opCall10        = 0x6A      # ()                # X,...             # A,...
        opCall11        = 0x6B      # ()                # X,...             # A,...
        opCall12        = 0x6C      # ()                # X,...             # A,...
        opCall13        = 0x6D      # ()                # X,...             # A,...
        
        opCall          = 0x6E      # (idx)             # X,...             # A,...
        opCallX         = 0x6F      # (idx,idxB)        # X,...             # A,...

        # [0x70-0x7F]
        # attributes
        opAttr0         = 0x70      # ()                # rvalue            # 
        opAttr1         = 0x71      # ()                # rvalue            #
        opAttr2         = 0x72      # ()                # rvalue            #
        opAttr3         = 0x73      # ()                # rvalue            #
        opAttr4         = 0x74      # ()                # rvalue            #
        opAttr5         = 0x75      # ()                # rvalue            #
        opAttr6         = 0x76      # ()                # rvalue            #
        opAttr7         = 0x77      # ()                # rvalue            #
        opAttr8         = 0x78      # ()                # rvalue            #
        opAttr9         = 0x79      # ()                # rvalue            #
        opAttr10        = 0x7A      # ()                # rvalue            #
        opAttr11        = 0x7B      # ()                # rvalue            #
        opAttr12        = 0x7C      # ()                # rvalue            #
        opAttr13        = 0x7D      # ()                # rvalue            #

        opAttr          = 0x7E      # (idx)             # rvalue            #
        opAttrX         = 0x7F      # (idx,idxB)        # rvalue            #

        #---------------------------------
        # OP FUNCTIONS
        #---------------------------------

        # [0x80-0x8F]
        # arithmetic operators
        opAdd           = 0x80      # ()                # x,y               # result
        opSub           = 0x81      # ()                # x,y               # result
        opMul           = 0x82      # ()                # x,y               # result
        opDiv           = 0x83      # ()                # x,y               # result
        opFdiv          = 0x84      # ()                # x,y               # result
        opMod           = 0x85      # ()                # x,y               # result
        opPow           = 0x86      # ()                # x,y               # result

        opNeg           = 0x87      # ()                # x                 # result

        # increment/decrement
        opInc           = 0x88      # ()                # value             # result
        opDec           = 0x89      # ()                # value             # result

        # binary operators
        opBNot          = 0x8A      # ()                # x                 # result
        opBAnd          = 0x8B      # ()                # x,y               # result
        opBOr           = 0x8C      # ()                # x,y               # result

        opShl           = 0x8D      # ()                # x,y               # result
        opShr           = 0x8E      # ()                # x,y               # result

        RSRV1           = 0x8F      #

        # [0x90-0x9F]
        # logical operators
        opNot           = 0x90      # ()                # x                 # result
        opAnd           = 0x91      # ()                # x,y               # result
        opOr            = 0x92      # ()                # x,y               # result

        # comparison operators
        opEq            = 0x93      # ()                # x,y               # result
        opNe            = 0x94      # ()                # x,y               # result
        opGt            = 0x95      # ()                # x,y               # result
        opGe            = 0x96      # ()                # x,y               # result
        opLt            = 0x97      # ()                # x,y               # result
        opLe            = 0x98      # ()                # x,y               # result

        # getters/setters
        opGet           = 0x99      # ()                # obj,key           # result
        opSet           = 0x9A      # ()                # obj,key,rvalue    #

        RSRV2           = 0x9B      #
        RSRV3           = 0x9C      #
        RSRV4           = 0x9D      #
        RSRV5           = 0x9E      #
        RSRV6           = 0x9F      #

        # [0xA0-0xAF]
        # branching
        opIf            = 0xA0      # ()                # cond,bl           # X
        opIfE           = 0xA1      # ()                # cond,bl           # cond
        opUnless        = 0xA2      # ()                # cond,bl           # X
        opUnlessE       = 0xA3      # ()                # cond,bl           # cond
        opElse          = 0xA4      # ()                # success           # X
        opSwitch        = 0xA5      # ()                # cond,a,b          # X
        opWhile         = 0xA6      # ()                # cond,bl           # X

        opReturn        = 0xA7      # ()                # value             #
        opBreak         = 0xA8      # ()                #                   #
        opContinue      = 0xA9      # ()                #                   #

        # converters
        opTo            = 0xAA      # ()                # tp,value          # result
        opToS           = 0xAB      # ()                # value             # result
        opToI           = 0xAC      # ()                # value             # result

        RSRV7           = 0xAD      #    
        RSRV8           = 0xAE      #
        RSRV9           = 0xAF      #

        # [0xB0-0xBF]
        # generators
        opArray         = 0xB0      # ()                # blk               # result
        opDict          = 0xB1      # ()                # blk               # result
        opFunc          = 0xB2      # ()                # params,blk        # result
        opRange         = 0xB3      # ()                # start,stop        # result

        # ranges & iterators
        
        opLoop          = 0xB4      # ()                # range,param,blk   # X
        opMap           = 0xB5      # ()                # range,param,blk   # result
        opSelect        = 0xB6      # ()                # range,param,blk   # result

        # collections
        opSize          = 0xB7      # ()                # obj               # result
        opReplace       = 0xB8      # ()                # obj,what,with     # result
        opSplit         = 0xB9      # ()                # obj,what          # result
        opJoin          = 0xBA      # ()                # obj               # result
        opReverse       = 0xBB      # ()                # blk               # result
        opAppend        = 0xBC      # ()                # x,y               # result

        # i/o operations
        opPrint         = 0xBD      # ()                # value             #

        RSRV10          = 0xBE      #
        RSRV11          = 0xBF      #

        #---------------------------------
        # LOW-LEVEL OPERATIONS
        #---------------------------------

        # [0xC0-0xDF]
        # no operation
        opNop           = 0xC0      # ()                #                   # 

        # stack operations
        opPop           = 0xC1      # ()                # X                 # 
        opDup           = 0xC2      # ()                # X                 # X,X
        opOver          = 0xC3      # ()                # X,Y               # X,Y,X
        opSwap          = 0xC4      # ()                # X,Y               # Y,X

        # conditional jumps
        opJmpIf         = 0xC5      # (idx)             # cond              #
        opJmpIfX        = 0xC6      # (idx,idxB)        # cond              #
        opJmpIfNot      = 0xC7      # (idx)             # cond              #
        opJmpIfNotX     = 0xC8      # (idx,idxB)        # cond              #
        opJmpIfEq       = 0xC9      # (idx)             # cond              #
        opJmpIfEqX      = 0xCA      # (idx,idxB)        # cond              #
        opJmpIfNe       = 0xCB      # (idx)             # cond              #
        opJmpIfNeX      = 0xCC      # (idx,idxB)        # cond              #
        opJmpIfGt       = 0xCD      # (idx)             # cond              #
        opJmpIfGtX      = 0xCE      # (idx,idxB)        # cond              #
        opJmpIfGe       = 0xCF      # (idx)             # cond              #
        opJmpIfGeX      = 0xD0      # (idx,idxB)        # cond              #
        opJmpIfLt       = 0xD1      # (idx)             # cond              #
        opJmpIfLtX      = 0xD2      # (idx,idxB)        # cond              #
        opJmpIfLe       = 0xD3      # (idx)             # cond              #
        opJmpIfLeX      = 0xD4      # (idx,idxB)        # cond              #

        # flow control
        opGoto          = 0xD5      # (idx)             #                   #
        opGotoX         = 0xD6      # (idx,idxB)        #                   #
        opGoup          = 0xD7      # (idx)             #                   #
        opGoupX         = 0xD8      # (idx,idxB)        #                   #
        
        opRet           = 0xD9      # ()                #                   #
        opEnd           = 0xDA      # ()                #                   #

when false:
    #=======================================
    # Helpers
    #=======================================

    iterator getOpcodes*(bs: seq[byte]): (OpCode, int, bool, int) =
        var pos = 0
        while pos < bs.len:
            let op = OpCode(bs[pos])
            case op:
                of opPush, opStore, opLoad, opCall, opStorl, opAttr:
                    yield (op, pos, true, int(bs[pos + 1]))
                    pos += 2
                of opPushX, opStoreX, opLoadX, opCallX, opStorlX, opEol:
                    yield (op, pos, true, int((uint16(bs[pos + 1]) shl 8) + byte(bs[pos + 2])))
                    pos += 3
                else: 
                    yield (op, pos, false, 0)
                    pos += 1

    type
        OpCodeTuple* = (OpCode, int, bool, int)

    const
        EmptyOpTuple* = (opNop, 0, false, 0)
    
    iterator getOpcodesBy2*(bs: seq[byte]): (OpCodeTuple,OpCodeTuple) =
        var pos = 0
        var firstTup, secondTup: OpCodeTuple
        while pos < bs.len:
            let op = OpCode(bs[pos])
            case op:
                of opPush, opStore, opLoad, opCall, opStorl, opAttr:
                    firstTup = (op, pos, true, int(bs[pos + 1]))
                    pos += 2
                of opPushX, opStoreX, opLoadX, opCallX, opStorlX, opEol:
                    firstTup = (op, pos, true, int((uint16(bs[pos + 1]) shl 8) + byte(bs[pos + 2])))
                    pos += 3
                else: 
                    firstTup = (op, pos, false, 0)
                    pos += 1
            if pos < bs.len:
                let op = OpCode(bs[pos])
                case op:
                    of opPush, opStore, opLoad, opCall, opStorl, opAttr:
                        secondTup = (op, pos, true, int(bs[pos + 1]))
                        #pos += 2
                    of opPushX, opStoreX, opLoadX, opCallX, opStorlX, opEol:
                        secondTup = (op, pos, true, int((uint16(bs[pos + 1]) shl 8) + byte(bs[pos + 2])))
                        #pos += 3
                    else: 
                        secondTup = (op, pos, false, 0)
                        #pos += 1
                yield (firstTup, secondTup)
            else:
                yield (firstTup, EmptyOpTuple)

#=======================================
# Methods
#=======================================

proc parseOpCode*(x: string): OpCode =
    var str = x.toLowerAscii().capitalizeAscii()
    str = str.replaceAll(newRegexObj("i(\\d)$"), "I$1")
             .replaceAll(newRegexObj("(\\w+)x$"), "$1X")
             .replaceAll(newRegexObj("bt$"),"BT").replaceAll(newRegexObj("bf$"),"BF").replaceAll(newRegexObj("bm$"), "BM")
             .replaceAll(newRegexObj("n$"), "N")
             .replace("jumpifnot","jumpIfNot")
             .replace("jumpif","jumpIf")
             .multiReplace([
                ("Bnot","BNot"),
                ("Band","BAnd"),
                ("Bor","BOr"),
                ("Ife", "IfE"),
                ("Tos", "ToS"),
                ("Toi", "ToI"),
                ("JmpifX", "JmpIfX"),
                ("Jmpifn", "JmpIfN"),
                ("Jmpifnx", "JmpIfNX")
            ])
    str = "op" & str

    try:
        return parseEnum[OpCode](str)
    except CatchableError:
        return opNop

func stringify*(x: OpCode): string {.inline.} =
    result = $(x)
    removePrefix(result, "op")
    result = result.toLowerAscii()

func hash*(x: OpCode): Hash {.inline.} =
    cast[Hash](ord(x))