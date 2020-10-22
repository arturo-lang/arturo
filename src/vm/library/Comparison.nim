######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Comparison.nim
######################################################

#=======================================
# Libraries
#=======================================

import ../stack, ../value

#=======================================
# Methods
#=======================================

template IsEqual*():untyped =
    require(opEq)
    stack.push(newBoolean(x == y))

template IsGreater*():untyped =
    require(opGt)
    stack.push(newBoolean(x > y))

template IsGreaterOrEqual*():untyped =
    require(opGe)
    stack.push(newBoolean(x >= y))

template IsLess*():untyped =
    require(opLt)
    stack.push(newBoolean(x < y))

template IsLessOrEqual*():untyped =
    require(opGe)
    stack.push(newBoolean(x <= y))
            
template IsNotEqual*():untyped =
    require(opNe)
    stack.push(newBoolean(x != y))
            
