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

        # [0x00-0x0F]
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

        opConstF1       = 0x0B      # 1.0

        opConstBT       = 0x0C      # true
        opConstBF       = 0x0D      # false

        opConstA        = 0x0E      # [] empty array

        opConstN        = 0x0F      # null
 
        # [0x10-0x2F]
        # push values
        opPush0         = 0x10   
        opPush1         = 0x11
        opPush2         = 0x12
        opPush3         = 0x13
        opPush4         = 0x14
        opPush5         = 0x15
        opPush6         = 0x16
        opPush7         = 0x17
        opPush8         = 0x18
        opPush9         = 0x19
        opPush10        = 0x1A
        opPush11        = 0x1B
        opPush12        = 0x1C
        opPush13        = 0x1D
        opPush14        = 0x1E
        opPush15        = 0x1F
        opPush16        = 0x20
        opPush17        = 0x21
        opPush18        = 0x22
        opPush19        = 0x23
        opPush20        = 0x24
        opPush21        = 0x25
        opPush22        = 0x26
        opPush23        = 0x27
        opPush24        = 0x28
        opPush25        = 0x29
        opPush26        = 0x2A
        opPush27        = 0x2B
        opPush28        = 0x2C
        opPush29        = 0x2D

        opPush          = 0x2E
        opPushX         = 0x2F

        # [0x30-0x4F]
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
        opStore14       = 0x3E
        opStore15       = 0x3F
        opStore16       = 0x40
        opStore17       = 0x41
        opStore18       = 0x42
        opStore19       = 0x43
        opStore20       = 0x44
        opStore21       = 0x45
        opStore22       = 0x46
        opStore23       = 0x47
        opStore24       = 0x48
        opStore25       = 0x49
        opStore26       = 0x4A
        opStore27       = 0x4B
        opStore28       = 0x4C
        opStore29       = 0x4D

        opStore         = 0x4E
        opStoreX        = 0x4F

        # [0x50-0x6F]
        # load variables (to -> stack)
        opLoad0         = 0x50   
        opLoad1         = 0x51
        opLoad2         = 0x52
        opLoad3         = 0x53
        opLoad4         = 0x54
        opLoad5         = 0x55
        opLoad6         = 0x56
        opLoad7         = 0x57
        opLoad8         = 0x58
        opLoad9         = 0x59
        opLoad10        = 0x5A
        opLoad11        = 0x5B
        opLoad12        = 0x5C
        opLoad13        = 0x5D
        opLoad14        = 0x5E
        opLoad15        = 0x5F
        opLoad16        = 0x60
        opLoad17        = 0x61
        opLoad18        = 0x62
        opLoad19        = 0x63
        opLoad20        = 0x64
        opLoad21        = 0x65
        opLoad22        = 0x66
        opLoad23        = 0x67
        opLoad24        = 0x68
        opLoad25        = 0x69
        opLoad26        = 0x6A
        opLoad27        = 0x6B
        opLoad28        = 0x6C
        opLoad29        = 0x6D
        
        opLoad          = 0x6E
        opLoadX         = 0x6F

        # [0x70-0x8F]
        # function calls
        opCall0         = 0x70   
        opCall1         = 0x71
        opCall2         = 0x72
        opCall3         = 0x73
        opCall4         = 0x74
        opCall5         = 0x75
        opCall6         = 0x76
        opCall7         = 0x77
        opCall8         = 0x78
        opCall9         = 0x79
        opCall10        = 0x7A
        opCall11        = 0x7B
        opCall12        = 0x7C
        opCall13        = 0x7D
        opCall14        = 0x7E
        opCall15        = 0x7F
        opCall16        = 0x80
        opCall17        = 0x81
        opCall18        = 0x82
        opCall19        = 0x83
        opCall20        = 0x84
        opCall21        = 0x85
        opCall22        = 0x86
        opCall23        = 0x87
        opCall24        = 0x88
        opCall25        = 0x89
        opCall26        = 0x8A
        opCall27        = 0x8B
        opCall28        = 0x8C
        opCall29        = 0x8D
        
        opCall          = 0x8E
        opCallX         = 0x8F

        # [0x90-0xAF]
        # store variables (from <- stack)
        opStorl0        = 0x90   
        opStorl1        = 0x91
        opStorl2        = 0x92
        opStorl3        = 0x93
        opStorl4        = 0x94
        opStorl5        = 0x95
        opStorl6        = 0x96
        opStorl7        = 0x97
        opStorl8        = 0x98
        opStorl9        = 0x99
        opStorl10       = 0x9A
        opStorl11       = 0x9B
        opStorl12       = 0x9C
        opStorl13       = 0x9D
        opStorl14       = 0x9E
        opStorl15       = 0x9F
        opStorl16       = 0xA0
        opStorl17       = 0xA1
        opStorl18       = 0xA2
        opStorl19       = 0xA3
        opStorl20       = 0xA4
        opStorl21       = 0xA5
        opStorl22       = 0xA6
        opStorl23       = 0xA7
        opStorl24       = 0xA8
        opStorl25       = 0xA9
        opStorl26       = 0xAA
        opStorl27       = 0xAB
        opStorl28       = 0xAC
        opStorl29       = 0xAD

        opStorl         = 0xAE
        opStorlX        = 0xAF

        #-----------------------

        # [0xB0-BF] #
        # generators
        opAttr          = 0xB0
        opArray         = 0xB1
        opDict          = 0xB2
        opFunc          = 0xB3

        # stack operations
        opPop           = 0xB4
        opDup           = 0xB5
        opSwap          = 0xB6

        # flow control
        opJump          = 0xB7
        opJumpIf        = 0xB8
        opJumpIfNot     = 0xB9
        opRet           = 0xBA
        opEnd           = 0xBB

        opNop           = 0xBC
        opEol           = 0xBD
        opEolX          = 0xBE
        
        # reserved
        opRsrv1         = 0xBF

        # [0xC0-CF] #
        # arithmetic & logical operators
        opIAdd          = 0xC0
        opISub          = 0xC1
        opIMul          = 0xC2
        opIDiv          = 0xC3
        opIFDiv         = 0xC4
        opIMod          = 0xC5
        opIPow          = 0xC6

        opINeg          = 0xC7

        opBNot          = 0xC8
        opBAnd          = 0xC9
        opOr            = 0xCA
        opXor           = 0xCB

        opShl           = 0xCC
        opShr           = 0xCD

        # reserved
        opRsrv2         = 0xCE
        opRsrv3         = 0xCF

        # [0xD0-DF] #
        # comparison operators

        opEq            = 0xD0
        opNe            = 0xD1
        opGt            = 0xD2
        opGe            = 0xD3
        opLt            = 0xD4
        opLe            = 0xD5

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