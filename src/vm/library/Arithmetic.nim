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

    if x.kind==Literal  : syms[x.s] -= 1
    else                : stack.push(x * (-1))

template Inc*():untyped =
    require(opInc)

    if x.kind==Literal  : syms[x.s] += 1
    else                : stack.push(x+1)

template Dec*():untyped =
    require(opDec)

    if x.kind==Literal:
        if syms[x.s].kind == Integer:
            if syms[x.s].iKind==NormalInteger: 
                try:
                    syms[x.s].i -= 1
                except OverflowDefect:
                    syms[x.s] = newInteger(newInt(syms[x.s].i)-1)
            else: 
                syms[x.s].bi -= 1
        elif syms[x.s].kind == Floating: syms[x.s].f -= 1.0
    elif x.kind==Integer:
        if x.iKind==NormalInteger: 
            try:
                stack.push(newInteger(x.i-1))
            except OverflowDefect:
                stack.push(newInteger(newInt(x.i)-1))
        else: 
            stack.push(newInteger(x.bi-1))
    elif x.kind==Floating:
        stack.push(newFloating(x.f-1.0))