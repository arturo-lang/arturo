######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/opcodes.nim
######################################################

#=======================================
# Libraries
#=======================================

import hashes, strutils

import helpers/regex

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

        opConstF1       = 0x10      # 1.0

        opConstBT       = 0x11      # true
        opConstBF       = 0x12      # false

        opConstA        = 0x13      # empty array

        opConstN        = 0x14      # null

        opRsrv1
        opRsrv2
        opRsrv3
        opRsrv4
        opRsrv5
        opRsrv6
        opRsrv7
        opRsrv8
        opRsrv9
        opRsrv10
        opRsrv11
        opRsrv12
 
        # [0x20-0x3F]
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
        opPush14        = 0x2E
        opPush15        = 0x2F
        opPush16        = 0x30
        opPush17        = 0x31
        opPush18        = 0x32
        opPush19        = 0x33
        opPush20        = 0x34
        opPush21        = 0x35
        opPush22        = 0x36
        opPush23        = 0x37
        opPush24        = 0x38
        opPush25        = 0x39
        opPush26        = 0x3A
        opPush27        = 0x3B
        opPush28        = 0x3C
        opPush29        = 0x3D

        opPush          = 0x3E
        opPushX         = 0x3F

        # [0x40-0x5F]
        # store variables (from <- stack)
        opStore0        = 0x40   
        opStore1        = 0x41
        opStore2        = 0x42
        opStore3        = 0x43
        opStore4        = 0x44
        opStore5        = 0x45
        opStore6        = 0x46
        opStore7        = 0x47
        opStore8        = 0x48
        opStore9        = 0x49
        opStore10       = 0x4A
        opStore11       = 0x4B
        opStore12       = 0x4C
        opStore13       = 0x4D
        opStore14       = 0x4E
        opStore15       = 0x4F
        opStore16       = 0x50
        opStore17       = 0x51
        opStore18       = 0x52
        opStore19       = 0x53
        opStore20       = 0x54
        opStore21       = 0x55
        opStore22       = 0x56
        opStore23       = 0x57
        opStore24       = 0x58
        opStore25       = 0x59
        opStore26       = 0x5A
        opStore27       = 0x5B
        opStore28       = 0x5C
        opStore29       = 0x5D

        opStore         = 0x5E
        opStoreX        = 0x5F

        # [0x60-0x7F]
        # load variables (to -> stack)
        opLoad0         = 0x60   
        opLoad1         = 0x61
        opLoad2         = 0x62
        opLoad3         = 0x63
        opLoad4         = 0x64
        opLoad5         = 0x65
        opLoad6         = 0x66
        opLoad7         = 0x67
        opLoad8         = 0x68
        opLoad9         = 0x69
        opLoad10        = 0x6A
        opLoad11        = 0x6B
        opLoad12        = 0x6C
        opLoad13        = 0x6D
        opLoad14        = 0x6E
        opLoad15        = 0x6F
        opLoad16        = 0x70
        opLoad17        = 0x71
        opLoad18        = 0x72
        opLoad19        = 0x73
        opLoad20        = 0x74
        opLoad21        = 0x75
        opLoad22        = 0x76
        opLoad23        = 0x77
        opLoad24        = 0x78
        opLoad25        = 0x79
        opLoad26        = 0x7A
        opLoad27        = 0x7B
        opLoad28        = 0x7C
        opLoad29        = 0x7D
        
        opLoad          = 0x7E
        opLoadX         = 0x7F

        # [0x80-0x9F]
        # function calls
        opCall0         = 0x80   
        opCall1         = 0x81
        opCall2         = 0x82
        opCall3         = 0x83
        opCall4         = 0x84
        opCall5         = 0x85
        opCall6         = 0x86
        opCall7         = 0x87
        opCall8         = 0x88
        opCall9         = 0x89
        opCall10        = 0x8A
        opCall11        = 0x8B
        opCall12        = 0x8C
        opCall13        = 0x8D
        opCall14        = 0x8E
        opCall15        = 0x8F
        opCall16        = 0x90
        opCall17        = 0x91
        opCall18        = 0x92
        opCall19        = 0x93
        opCall20        = 0x94
        opCall21        = 0x95
        opCall22        = 0x96
        opCall23        = 0x97
        opCall24        = 0x98
        opCall25        = 0x99
        opCall26        = 0x9A
        opCall27        = 0x9B
        opCall28        = 0x9C
        opCall29        = 0x9D
        
        opCall          = 0x9E
        opCallX         = 0x9F

        # [0xA0-0xBF]
        # store variables (from <- stack)
        opStorl0        = 0xA0   
        opStorl1        = 0xA1
        opStorl2        = 0xA2
        opStorl3        = 0xA3
        opStorl4        = 0xA4
        opStorl5        = 0xA5
        opStorl6        = 0xA6
        opStorl7        = 0xA7
        opStorl8        = 0xA8
        opStorl9        = 0xA9
        opStorl10       = 0xAA
        opStorl11       = 0xAB
        opStorl12       = 0xAC
        opStorl13       = 0xAD
        opStorl14       = 0xAE
        opStorl15       = 0xAF
        opStorl16       = 0xB0
        opStorl17       = 0xB1
        opStorl18       = 0xB2
        opStorl19       = 0xB3
        opStorl20       = 0xB4
        opStorl21       = 0xB5
        opStorl22       = 0xB6
        opStorl23       = 0xB7
        opStorl24       = 0xB8
        opStorl25       = 0xB9
        opStorl26       = 0xBA
        opStorl27       = 0xBB
        opStorl28       = 0xBC
        opStorl29       = 0xBD

        opStorl         = 0xBE
        opStorlX        = 0xBF

        #-----------------------

        # [0xC0-0xCF] #
        # generators
        opAttr          = 0xC0
        opArray         = 0xC1
        opDict          = 0xC2
        opFunc          = 0xC3

        # stack operations
        opPop           = 0xC4
        opDup           = 0xC5
        opSwap          = 0xC6

        # flow control
        opJump          = 0xC7
        opJumpIf        = 0xC8
        opJumpIfNot     = 0xC9
        opRet           = 0xCA
        opEnd           = 0xCB

        opNop           = 0xCC
        opEol           = 0xCD
        opEolX          = 0xCE
        
        # reserved
        opRsrv13        = 0xCF

        # [0xD0-0xDF] #
        # arithmetic & logical operators
        opIAdd          = 0xD0
        opISub          = 0xD1
        opIMul          = 0xD2
        opIDiv          = 0xD3
        opIFDiv         = 0xD4
        opIMod          = 0xD5
        opIPow          = 0xD6

        opINeg          = 0xD7

        opBNot          = 0xD8
        opBAnd          = 0xD9
        opOr            = 0xDA
        opXor           = 0xDB

        opShl           = 0xDC
        opShr           = 0xDD

        # reserved
        opRsrv14        = 0xDE
        opRsrv15        = 0xDF

        # [0xE0-0xEF] #
        # comparison operators

        opEq            = 0xE0
        opNe            = 0xE1
        opGt            = 0xE2
        opGe            = 0xE3
        opLt            = 0xE4
        opLe            = 0xE5

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
                ("Iadd","IAdd"),
                ("Isub","ISub"),
                ("Imul","IMul"),
                ("Idiv","IDiv"),
                ("Ifdiv","IFDiv"),  
                ("Imod","IMod"),
                ("Ipow","IPow"),
                ("Ineg","INeg")
            ])
    str = "op" & str

    try:
        return parseEnum[OpCode](str)
    except:
        return opNop

func stringify*(x: OpCode): string {.inline.} =
    ($(x)).replace("op").toLowerAscii()

func hash*(x: OpCode): Hash {.inline.} =
    cast[Hash](ord(x))