######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Arithmetic.nim
######################################################

#=======================================
# Libraries
#=======================================

import extras/bignum, math, sequtils

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Add*():untyped =
    require(opAdd)

    if x.kind==Literal  : syms[x.s] += y
    else                : stack.push(x+y)

template Sub*():untyped =
    require(opSub)

    if x.kind==Literal  : syms[x.s] -= y
    else                : stack.push(x-y)

template Mul*():untyped =
    require(opMul)

    if x.kind==Literal  : syms[x.s] *= y
    else                : stack.push(x*y)

template Div*():untyped =
    require(opDiv)

    if x.kind==Literal  : syms[x.s] /= y
    else                : stack.push(x/y)

template Fdiv*():untyped = 
    require(opFDiv)

    if x.kind==Literal  : syms[x.s] //= y
    else                : stack.push(x//y)

template Mod*():untyped = 
    require(opMod)

    if x.kind==Literal  : syms[x.s] %= y
    else                : stack.push(x%y)

template Pow*():untyped =
    require(opPow)

    if x.kind==Literal  : syms[x.s] ^= y
    else                : stack.push(x^y)

template Neg*():untyped =
    require(opNeg)

    if x.kind==Literal  : syms[x.s] *= I1M
    else                : stack.push(x * I1M)

template Inc*():untyped =
    require(opInc)

    if x.kind==Literal  : syms[x.s] += I1
    else                : stack.push(x+I1)

template Dec*():untyped =
    require(opDec)

    if x.kind==Literal  : syms[x.s] -= I1
    else                : stack.push(x-I1)
