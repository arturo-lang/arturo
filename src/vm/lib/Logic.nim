######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Logic.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Not*():untyped =
    require(opNot)
    stack.push(newBoolean(not x.b))

template And*():untyped = 
    require(opAnd)
    stack.push(newBoolean(x.b and y.b))

template Or*():untyped =
    require(opOr)
    stack.push(newBoolean(x.b or y.b))

template Xor*():untyped =
    require(opXor)
    stack.push(newBoolean(x.b xor y.b))
