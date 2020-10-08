######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Binary.nim
######################################################

#=======================================
# Libraries
#=======================================

import extras/bignum, math, sequtils

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Not*():untyped =
    require(opBNot)
    stack.push(newInteger(not x.i))

template And*():untyped = 
    require(opBAnd)
    stack.push(newInteger(x.i and y.i))

template Or*():untyped =
    require(opBOr)
    stack.push(newInteger(x.i or y.i))

template Xor*():untyped =
    require(opBXor)
    stack.push(newInteger(x.i xor y.i))

template Shl*():untyped =
    require(opShl)
    stack.push(newInteger(x.i shl y.i))

template Shr*():untyped =
    require(opShr)
    stack.push(newInteger(x.i shr y.i))
