######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/bytecode.nim
######################################################

#=======================================
# Libraries
#=======================================

import hashes

#=======================================
# Types 
#=======================================

# TODO cleanup unneeded opcodes
# TODO extend range for PUSH/CALL/STORE's

type
    OpCode* = enum
        # [0x0] #
        # push constants 
        opConstI0        = 0x00      # 0
        opConstI1        = 0x01      # 1
        opConstI2        = 0x02      # 2
        opConstI3        = 0x03      # 3
        opConstI4        = 0x04      # 4
        opConstI5        = 0x05      # 5
        opConstI6        = 0x06      # 6
        opConstI7        = 0x07      # 7
        opConstI8        = 0x08      # 8 
        opConstI9        = 0x09      # 9
        opConstI10       = 0x0A      # 10

        opConstI1M       = 0x0B      # -1
        opConstF1        = 0x0C      # 1.0

        opConstBT        = 0x0D      # true
        opConstBF        = 0x0E      # false

        opConstN         = 0x0F      # null
 

        # [0x1] #
        # push value
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

        opPushX         = 0x1E
        opPushY         = 0x1F

        # [0x2] #
        # store variable (from <- stack)
        opStore0        = 0x20
        opStore1        = 0x21
        opStore2        = 0x22
        opStore3        = 0x23
        opStore4        = 0x24
        opStore5        = 0x25
        opStore6        = 0x26
        opStore7        = 0x27
        opStore8        = 0x28
        opStore9        = 0x29
        opStore10       = 0x2A
        opStore11       = 0x2B
        opStore12       = 0x2C
        opStore13       = 0x2D

        opStoreX        = 0x2E
        opStoreY        = 0x2F 

        # [0x3] #
        # load variable (to -> stack)
        opLoad0         = 0x30
        opLoad1         = 0x31
        opLoad2         = 0x32
        opLoad3         = 0x33
        opLoad4         = 0x34
        opLoad5         = 0x35
        opLoad6         = 0x36
        opLoad7         = 0x37
        opLoad8         = 0x38
        opLoad9         = 0x39
        opLoad10        = 0x3A
        opLoad11        = 0x3B
        opLoad12        = 0x3C
        opLoad13        = 0x3D

        opLoadX         = 0x3E 
        opLoadY         = 0x3F

        # [0x4] #
        # user function calls
        opCall0         = 0x40
        opCall1         = 0x41
        opCall2         = 0x42
        opCall3         = 0x43
        opCall4         = 0x44
        opCall5         = 0x45
        opCall6         = 0x46
        opCall7         = 0x47
        opCall8         = 0x48
        opCall9         = 0x49
        opCall10        = 0x4A
        opCall11        = 0x4B
        opCall12        = 0x4C
        opCall13        = 0x4D

        opCallX         = 0x4E
        opCallY         = 0x4F

        # # [0x5] #
        # # arithmetic & logical operations 
        # opAdd           = 0x50
        # opSub           = 0x51
        # opMul           = 0x52
        # opDiv           = 0x53
        # opFDiv          = 0x54
        # opMod           = 0x55
        # opPow           = 0x56

        # opNeg           = 0x57

        # opNot           = 0x58
        # opAnd           = 0x59
        # opOr            = 0x5A
        # opXor           = 0x5B

        # opShl           = 0x5C
        # opShr           = 0x5D

        opAttr          = 0x50

        opEnd           = 0x51     
        # opReturn        = 0x5F

        # # [0x6] #
        # # stack operations
        # opPop           = 0x60
        # opDup           = 0x61
        # opSwap          = 0x62
        # opNop           = 0x63

        # #flow control 
        # opJmp           = 0x64
        # opJmpIf         = 0x65
        
        # opPush          = 0x66

        # # comparison operations
        # opEq            = 0x67
        # opNe            = 0x68
        # opGt            = 0x69
        # opGe            = 0x6A
        # opLt            = 0x6B
        # opLe            = 0x6C

        # # structures
        # opArray         = 0x6D
        # opDictionary    = 0x6E
        # opFunction      = 0x6F

        # # [0x7] #
        # # system calls (144 slots)

        # opPrint         = 0x70
        # opInspect       = 0x71

        # opIf            = 0x72
        # opIsIf          = 0x73
        # opElse          = 0x74

        # opLoop          = 0x75

        # opDo            = 0x76
        # opMap           = 0x77
        # opSelect        = 0x78
        # opFilter        = 0x79

        # opSize          = 0x7A

        # opUpper         = 0x7B
        # opLower         = 0x7C
        
        # opGet           = 0x7D
        # opSet           = 0x7E

#=======================================
# Methods
#=======================================

proc hash*(x: OpCode): Hash {.inline.}=
    cast[Hash](ord(x))
