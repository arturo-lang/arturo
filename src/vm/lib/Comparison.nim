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

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Eq*():untyped =
    require(opEq)
    stack.push(newBoolean(x == y))

template Ne*():untyped =
    require(opNe)
    stack.push(newBoolean(x != y))

template Gt*():untyped =
    require(opGt)
    stack.push(newBoolean(x > y))

template Ge*():untyped =
    require(opGe)
    stack.push(newBoolean(x >= y))

template Lt*():untyped =
    require(opLt)
    stack.push(newBoolean(x < y))

template Le*():untyped =
    require(opGe)
    stack.push(newBoolean(x <= y))
            