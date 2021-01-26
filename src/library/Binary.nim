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

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template And*():untyped = 
    # EXAMPLE:
    # print and 2 3  ____; 2
    #
    # a: 2
    # and 'a 3       ____; a: 2

    require(opBAnd)

    if x.kind==Literal : syms[x.s] &&= y
    else               : stack.push(x && y)

template Nand*():untyped =
    # EXAMPLE:
    # print nand 2 3 ____; -3
    #
    # a: 2
    # nand 'a 3      ____; a: -3

    require(opBNand)

    if x.kind==Literal : syms[x.s] &&= y; !!= syms[x.s]
    else               : stack.push(!! (x && y))

template Nor*():untyped =
    # EXAMPLE:
    # print nor 2 3  ____; -4
    #
    # a: 2
    # nor 'a 3       ____; a: -4

    require(opBNor)

    if x.kind==Literal : syms[x.s] ||= y; !!= syms[x.s]
    else               : stack.push(!! (x || y))

template Not*():untyped =
    # EXAMPLE:
    # print not 123  ____; -124
    #
    # a: 123
    # not 'a         ____; a: -124

    require(opBNot)
    
    if x.kind==Literal : !!= syms[x.s] 
    else               : stack.push(!! x)

template Or*():untyped =
    # EXAMPLE:
    # print or 2 3   ____; 3
    #
    # a: 2
    # or 'a 3        ____; a: 3

    require (opBOr)

    if x.kind==Literal : syms[x.s] ||= y
    else               : stack.push(x || y)

template Shl*():untyped =
    # EXAMPLE:
    # print shl 2 3  ____; 16
    #
    # a: 2
    # shl 'a 3       ____; a: 16

    require(opShl)
    
    if x.kind==Literal : syms[x.s] <<= y
    else               : stack.push(x << y)

template Shr*():untyped =
    # EXAMPLE:
    # print shr 16 3 ____; 2
    #
    # a: 16
    # shr 'a 3       ____; a: 2

    require(opShr)
    
    if x.kind==Literal : syms[x.s] >>= y
    else               : stack.push(x >> y)

template Xnor*():untyped =
    # EXAMPLE:
    # print xnor 2 3 ____; -2
    #
    # a: 2
    # xnor 'a 3      ____; a: -2

    require(opBXnor)

    if x.kind==Literal : syms[x.s] ^^= y; !!= syms[x.s]
    else               : stack.push(!! (x ^^ y))
    
template Xor*():untyped =
    # EXAMPLE:
    # print xor 2 3  ____; 1
    #
    # a: 2
    # xor 'a 3       ____; a: 1

    require(opBXor)
    
    if x.kind==Literal : syms[x.s] ^^= y
    else               : stack.push(x ^^ y)
