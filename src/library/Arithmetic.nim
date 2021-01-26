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

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Add*():untyped =
    # EXAMPLE:
    # print add 1 2  ____; 3
    # print 1 + 3    ____; 4
    #
    # a: 4
    # add 'a 1       ____; a: 5
 
    require(opAdd)

    if x.kind==Literal  : syms[x.s] += y
    else                : stack.push(x+y)

template Dec*():untyped =
    # EXAMPLE:
    # print dec 5    ____; 4
    #
    # a: 4
    # dec 'a         ____; a: 3

    require(opDec)

    if x.kind==Literal  : syms[x.s] -= I1
    else                : stack.push(x-I1)
    
template Div*():untyped =
    # EXAMPLE:
    # print div 5 2  ____; 2
    # print 9 / 3    ____; 3
    #
    # a: 6
    # div 'a 3       ____; a: 2

    require(opDiv)

    if x.kind==Literal  : syms[x.s] /= y
    else                : stack.push(x/y)

template Fdiv*():untyped = 
    # EXAMPLE:
    # print fdiv 5 2 ____; 2.5
    #
    # a: 6
    # fdiv 'a 3      ____; a: 2.0

    require(opFDiv)

    if x.kind==Literal  : syms[x.s] //= y
    else                : stack.push(x//y)

template Inc*():untyped =
    # EXAMPLE:
    # print inc 5    ____; 6
    #
    # a: 4
    # inc 'a         ____; a: 5

    require(opInc)

    if x.kind==Literal  : syms[x.s] += I1
    else                : stack.push(x+I1)

template Mod*():untyped = 
    # EXAMPLE:
    # print mod 5 2  ____; 1
    # print 9 % 3    ____; 0
    #
    # a: 8
    # mod 'a 3       ____; a: 2

    require(opMod)

    if x.kind==Literal  : syms[x.s] %= y
    else                : stack.push(x%y)

template Mul*():untyped =
    # EXAMPLE:
    # print mul 1 2  ____; 2
    # print 2 * 3    ____; 6
    # 
    # a: 5
    # mul 'a 2       ____; a: 10

    require(opMul)

    if x.kind==Literal  : syms[x.s] *= y
    else                : stack.push(x*y)

template Neg*():untyped =
    # EXAMPLE:
    # print neg 1    ____; -1
    #
    # a: 5
    # neg 'a         ____; a: -5

    require(opNeg)

    if x.kind==Literal  : syms[x.s] *= I1M
    else                : stack.push(x * I1M)

template Pow*():untyped =
    # EXAMPLE:
    # print pow 2 3  ____; 8
    # print 3 ^ 2    ____; 9
    #
    # a: 5
    # pow 'a 2       ____; a: 25

    require(opPow)

    if x.kind==Literal  : syms[x.s] ^= y
    else                : stack.push(x^y)

template Sub*():untyped =
    # EXAMPLE:
    # print sub 2 1  ____; 1
    # print 5 - 3    ____; 2
    #
    # a: 7
    # sub 'a 2       ____; a: 5

    require(opSub)

    if x.kind==Literal  : syms[x.s] -= y
    else                : stack.push(x-y)
