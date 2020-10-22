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

import ../stack, ../value

#=======================================
# Methods
#=======================================

template IsAnd*():untyped = 
    require(opAnd)
    stack.push(newBoolean(x.b and y.b))

template IsNand*():untyped =
    require(opNand)
    stack.push(newBoolean(not (x.b and y.b)))

template IsNor*():untyped =
    require(opNor)
    stack.push(newBoolean(not (x.b or y.b)))

template IsNot*():untyped =
    require(opNot)
    stack.push(newBoolean(not x.b))

template IsOr*():untyped =
    require(opOr)
    stack.push(newBoolean(x.b or y.b))

template IsXnor*():untyped =
    require(opXnor)
    stack.push(newBoolean(not (x.b xor y.b)))

template IsXor*():untyped =
    require(opXor)
    stack.push(newBoolean(x.b xor y.b))
