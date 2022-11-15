#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/custom/vrange.nim
#=======================================================

## The internal `:range` type

#=======================================
# Libraries
#=======================================

#=======================================
# Types
#=======================================

type
    RangeDirection* = enum
        Forward
        Backward

    VRange* = ref object
        start*  : int | float
        stop*   : int | float 
        step*   : int | float
        order*  : RangeDirection

#=======================================
# Overloads
#=======================================

