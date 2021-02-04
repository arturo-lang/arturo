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

        opConstI1M      = 0x0B      # -1
        opConstF1       = 0x0C      # 1.0

        opConstBT       = 0x0D      # true
        opConstBF       = 0x0E      # false

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
        opPush30        = 0x2E

        opPush          = 0x2F

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
        opStore30       = 0x4E

        opStore         = 0x4F

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
        opLoad30        = 0x6E

        opLoad          = 0x6F

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
        opCall30        = 0x8E

        opCall          = 0x8F

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

        opAttr          = 0x90

        opEnd           = 0x91     
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
