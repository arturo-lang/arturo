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

import ../stack, ../value

#=======================================
# Methods
#=======================================

template And*():untyped = 
    require(opBAnd)

    if x.kind==Literal : syms[x.s] &&= y
    else               : stack.push(x && y)

template Nand*():untyped =
    require(opBNand)

    if x.kind==Literal : syms[x.s] &&= y; !!= syms[x.s]
    else               : stack.push(!! (x && y))

template Nor*():untyped =
    require(opBNor)

    if x.kind==Literal : syms[x.s] ||= y; !!= syms[x.s]
    else               : stack.push(!! (x || y))

template Not*():untyped =
    require(opBNot)
    
    if x.kind==Literal : !!= syms[x.s] 
    else               : stack.push(!! x)

template Or*():untyped =
    require (opBOr)

    if x.kind==Literal : syms[x.s] ||= y
    else               : stack.push(x || y)

template Shl*():untyped =
    require(opShl)
    
    if x.kind==Literal : syms[x.s] <<= y
    else               : stack.push(x << y)

template Shr*():untyped =
    require(opShr)
    
    if x.kind==Literal : syms[x.s] >>= y
    else               : stack.push(x >> y)

template Xnor*():untyped =
    require(opBXnor)

    if x.kind==Literal : syms[x.s] ^^= y; !!= syms[x.s]
    else               : stack.push(!! (x ^^ y))
    
template Xor*():untyped =
    require(opBXor)
    
    if x.kind==Literal : syms[x.s] ^^= y
    else               : stack.push(x ^^ y)
