#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
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

        # [0x00-0x1F]
        # push constants 
        opConstI0       = 0x00      # 0
        opConstI1       = 0x01      # 1
        opConstI2       = 0x02      # 2
        opConstI3       = 0x03      # 3
        opConstI4       = 0x04      # 4
        opConstI5       = 0x05      # 5
        opConstI6       = 0x06      # 6
        opConstI7       = 0x07      # 7
        opConstI8       = 0x08      # 8 
        opConstI9       = 0x09      # 9
        opConstI10      = 0x0A      # 10
        opConstI11      = 0x0B      # 11
        opConstI12      = 0x0C      # 12
        opConstI13      = 0x0D      # 13    
        opConstI14      = 0x0E      # 14
        opConstI15      = 0x0F      # 15

        opConstI1M      = 0x10      # -1 

        opConstF0       = 0x11      # 0.0
        opConstF1       = 0x12      # 1.0
        opConstF2       = 0x13      # 2.0 

        opConstF1M      = 0x14      # -1.0

        opConstBT       = 0x15      # true
        opConstBF       = 0x16      # false
        opConstBM       = 0x17      # maybe

        opConstS        = 0x18      # empty string
        opConstA        = 0x19      # empty array
        opConstD        = 0x1A      # empty dictionary

        opConstN        = 0x1B      # null

        # lines & error reporting
        opEol           = 0x1C
        opEolX          = 0x1D

        # dictionary keys storage

        opDStore        = 0x1E
        opDStoreX       = 0x1F
 
        # [0x20-0x2F]
        # push values
        opPush0         = 0x20   
        opPush1         = 0x21
        opPush2         = 0x22
        opPush3         = 0x23
        opPush4         = 0x24
        opPush5         = 0x25
        opPush6         = 0x26
        opPush7         = 0x27
        opPush8         = 0x28
        opPush9         = 0x29
        opPush10        = 0x2A
        opPush11        = 0x2B
        opPush12        = 0x2C
        opPush13        = 0x2D

        opPush          = 0x2E
        opPushX         = 0x2F

        # [0x30-3F]
        # store variables (from <- stack)
        opStore0        = 0x30   
        opStore1        = 0x31
        opStore2        = 0x32
        opStore3        = 0x33
        opStore4        = 0x34
        opStore5        = 0x35
        opStore6        = 0x36
        opStore7        = 0x37
        opStore8        = 0x38
        opStore9        = 0x39
        opStore10       = 0x3A
        opStore11       = 0x3B
        opStore12       = 0x3C
        opStore13       = 0x3D

        opStore         = 0x3E
        opStoreX        = 0x3F

        # [0x40-0x4F]
        # load variables (to -> stack)
        opLoad0         = 0x40   
        opLoad1         = 0x41
        opLoad2         = 0x42
        opLoad3         = 0x43
        opLoad4         = 0x44
        opLoad5         = 0x45
        opLoad6         = 0x46
        opLoad7         = 0x47
        opLoad8         = 0x48
        opLoad9         = 0x49
        opLoad10        = 0x4A
        opLoad11        = 0x4B
        opLoad12        = 0x4C
        opLoad13        = 0x4D
        
        opLoad          = 0x4E
        opLoadX         = 0x4F

        # [0x50-0x5F]
        # store-load variables (from <- stack, without popping)
        opStorl0        = 0x50   
        opStorl1        = 0x51
        opStorl2        = 0x52
        opStorl3        = 0x53
        opStorl4        = 0x54
        opStorl5        = 0x55
        opStorl6        = 0x56
        opStorl7        = 0x57
        opStorl8        = 0x58
        opStorl9        = 0x59
        opStorl10       = 0x5A
        opStorl11       = 0x5B
        opStorl12       = 0x5C
        opStorl13       = 0x5D

        opStorl         = 0x5E
        opStorlX        = 0x5F

        # [0x60-0x6F]
        # function calls
        opCall0         = 0x60   
        opCall1         = 0x61
        opCall2         = 0x62
        opCall3         = 0x63
        opCall4         = 0x64
        opCall5         = 0x65
        opCall6         = 0x66
        opCall7         = 0x67
        opCall8         = 0x68
        opCall9         = 0x69
        opCall10        = 0x6A
        opCall11        = 0x6B
        opCall12        = 0x6C
        opCall13        = 0x6D
        
        opCall          = 0x6E
        opCallX         = 0x6F

        # [0x70-0x8F]
        # attributes
        opAttr0         = 0x70   
        opAttr1         = 0x71
        opAttr2         = 0x72
        opAttr3         = 0x73
        opAttr4         = 0x74
        opAttr5         = 0x75
        opAttr6         = 0x76
        opAttr7         = 0x77
        opAttr8         = 0x78
        opAttr9         = 0x79
        opAttr10        = 0x7A
        opAttr11        = 0x7B
        opAttr12        = 0x7C
        opAttr13        = 0x7D

        opAttr          = 0x7E
        opAttrX         = 0x7F

        opSetAttr0      = 0x80   
        opSetAttr1      = 0x81
        opSetAttr2      = 0x82
        opSetAttr3      = 0x83
        opSetAttr4      = 0x84
        opSetAttr5      = 0x85
        opSetAttr6      = 0x86
        opSetAttr7      = 0x87
        opSetAttr8      = 0x88
        opSetAttr9      = 0x89
        opSetAttr10     = 0x8A
        opSetAttr11     = 0x8B
        opSetAttr12     = 0x8C
        opSetAttr13     = 0x8D

        opSetAttr       = 0x8E
        opSetAttrX      = 0x8F

        #---------------------------------
        # OP FUNCTIONS
        #---------------------------------

        # [0x90-0x9F]
        # arithmetic operators
        opAdd           = 0x90
        opSub           = 0x91
        opMul           = 0x92
        opDiv           = 0x93
        opFdiv          = 0x94
        opMod           = 0x95
        opPow           = 0x96

        opNeg           = 0x97

        # binary operators
        opBNot          = 0x98
        opBAnd          = 0x99
        opBOr           = 0x9A

        opShl           = 0x9B
        opShr           = 0x9C

        # logical operators
        opNot           = 0x9D
        opAnd           = 0x9E
        opOr            = 0x9F

        # [0xA0-0xAF]
        # comparison operators
        opEq            = 0xA0
        opNe            = 0xA1
        opGt            = 0xA2
        opGe            = 0xA3
        opLt            = 0xA4
        opLe            = 0xA5

        # branching
        opIf            = 0xA6
        opIfE           = 0xA7
        opUnless        = 0xA8
        opElse          = 0xA9
        opSwitch        = 0xAA
        opWhile         = 0xAB
        opReturn        = 0xAC

        # converters
        opTo            = 0xAD
        opToS           = 0xAE  
        opToI           = 0xAF

        # [0xB0-0xBF]
        # getters/setters
        opGet           = 0xB0
        opSet           = 0xB1

        # generators
        opArray         = 0xB2
        opDict          = 0xB3
        opFunc          = 0xB4

        # ranges & iterators
        opRange         = 0xB5
        opLoop          = 0xB6
        opMap           = 0xB7
        opSelect        = 0xB8

        # collections
        opSize          = 0xB9
        opReplace       = 0xBA
        opSplit         = 0xBB
        opJoin          = 0xBC
        opReverse       = 0xBD

        # increment/decrement
        opInc           = 0xBE
        opDec           = 0xBF

        # [0xC0-0xCF]
        # i/o operations
        opPrint         = 0xC0

        RSRV1           = 0xC1
        RSRV2           = 0xC2
        RSRV3           = 0xC3
        RSRV4           = 0xC4
        RSRV5           = 0xC5
        RSRV6           = 0xC6
        RSRV7           = 0xC7
        RSRV8           = 0xC8
        RSRV9           = 0xC9
        RSRV10          = 0xCA
        RSRV11          = 0xCB
        RSRV12          = 0xCC
        RSRV13          = 0xCD
        RSRV14          = 0xCE
        RSRV15          = 0xCF

        #---------------------------------
        # LOW-LEVEL OPERATIONS
        #---------------------------------

        # [0xD0-0xDF]
        # no operation
        opNop           = 0xD0

        # stack operations
        opPop           = 0xD1
        opDup           = 0xD2
        opOver          = 0xD3
        opSwap          = 0xD4

        # conditional jumps
        opJmpIf         = 0xD5
        opJmpIfNot      = 0xD6
        opJmpIfEq       = 0xD7
        opJmpIfNe       = 0xD8
        opJmpIfGt       = 0xD9
        opJmpIfGe       = 0xDA
        opJmpIfLt       = 0xDB
        opJmpIfLe       = 0xDC

        # flow control
        opGoto          = 0xDD
        opRet           = 0xDE
        opEnd           = 0xDF

when false:
    #=======================================
    # Helpers
    #=======================================

    iterator getOpcodes*(bs: seq[byte]): (OpCode, int, bool, int) =
        var pos = 0
        while pos < bs.len:
            let op = (OpCode)bs[pos]
            case op:
                of opPush, opStore, opLoad, opCall, opStorl, opAttr:
                    yield (op, pos, true, (int)(bs[pos + 1]))
                    pos += 2
                of opPushX, opStoreX, opLoadX, opCallX, opStorlX, opEol:
                    yield (op, pos, true, (int)(((uint16)(bs[pos + 1]) shl 8) + (byte)bs[pos + 2]))
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
            let op = (OpCode)bs[pos]
            case op:
                of opPush, opStore, opLoad, opCall, opStorl, opAttr:
                    firstTup = (op, pos, true, (int)(bs[pos + 1]))
                    pos += 2
                of opPushX, opStoreX, opLoadX, opCallX, opStorlX, opEol:
                    firstTup = (op, pos, true, (int)(((uint16)(bs[pos + 1]) shl 8) + (byte)bs[pos + 2]))
                    pos += 3
                else: 
                    firstTup = (op, pos, false, 0)
                    pos += 1
            if pos < bs.len:
                let op = (OpCode)bs[pos]
                case op:
                    of opPush, opStore, opLoad, opCall, opStorl, opAttr:
                        secondTup = (op, pos, true, (int)(bs[pos + 1]))
                        #pos += 2
                    of opPushX, opStoreX, opLoadX, opCallX, opStorlX, opEol:
                        secondTup = (op, pos, true, (int)(((uint16)(bs[pos + 1]) shl 8) + (byte)bs[pos + 2]))
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
    except:
        return opNop

func stringify*(x: OpCode): string {.inline.} =
    result = $(x)
    removePrefix(result, "op")
    result = result.toLowerAscii()

func hash*(x: OpCode): Hash {.inline.} =
    cast[Hash](ord(x))