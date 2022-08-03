######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/bytecode.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import marshal, streams
import hashes

import vm/values/value

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
        opConstBM       = 0x0E      # maybe

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

        #-----------------------

        # [0x90-9F] #
        # generators
        opAttr          = 0x90
        opArray         = 0x91
        opDict          = 0x92
        opFunc          = 0x93

        # stack operations
        opPop           = 0x94
        opDup           = 0x95
        opSwap          = 0x96

        # flow control
        opJump          = 0x97
        opJumpIf        = 0x98
        opJumpIfNot     = 0x99
        opRet           = 0x9A
        opEnd           = 0x9B

        opNop           = 0x9C
        opEol           = 0x9D
        
        # reserved
        opRsrv1         = 0x9E
        opRsrv2         = 0x9F

        # [0xA0-AF] #
        # arithmetic & logical operators
        opIAdd          = 0xA0
        opISub          = 0xA1
        opIMul          = 0xA2
        opIDiv          = 0xA3
        opIFDiv         = 0xA4
        opIMod          = 0xA5
        opIPow          = 0xA6

        opINeg          = 0xA7

        opBNot          = 0xA8
        opBAnd          = 0xA9
        opOr            = 0xAA
        opXor           = 0xAB

        opShl           = 0xAC
        opShr           = 0xAD

        # reserved
        opRsrv3         = 0xAE
        opRsrv4         = 0xAF

        # [0xB0-BF] #
        # comparison operators

        opEq            = 0xB0
        opNe            = 0xB1
        opGt            = 0xB2
        opGe            = 0xB3
        opLt            = 0xB4
        opLe            = 0xB5

#=======================================
# Methods
#=======================================

# TODO(Bytecode) Re-visit bytecode reading & writing
#  Right now, we're using Nim's "marshalling". This looks a bit unnecessary.
#  labels: enhancement, cleanup, vm

proc writeBytecode*(trans: Translation, target: string): bool =
    when not defined(WEB):
        let marshaled = $$(trans[0])
        let bcode = trans[1]

        var f = newFileStream(target, fmWrite)
        if not f.isNil:
            f.write(len(marshaled))
            f.write(marshaled)
            f.write(len(bcode))
            for b in bcode:
                f.write(b)
            f.flush

            return true
        else:
            return false
    else:
        discard

proc readBytecode*(origin: string): Translation =
    when not defined(WEB):
        var f = newFileStream(origin, fmRead)
        if not f.isNil:
            var s: int
            f.read(s)           # read constants size
            var t: string
            f.readStr(s,t)      # read the marshaled constants

            f.read(s)           # read bytecode size

            var bcode: ByteArray = newSeq[byte](s)
            var indx = 0
            while not f.atEnd():
                bcode[indx] = f.readUint8()         # read bytes one-by-one
                indx += 1

            return (t.to[:ValueArray], bcode)       # return the Translation
    else:
        discard


func hash*(x: OpCode): Hash {.inline.}=
    cast[Hash](ord(x))
