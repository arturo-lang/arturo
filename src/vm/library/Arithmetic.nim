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

    if x.kind==Literal:
        if syms[x.s].kind==Integer and y.kind==Integer:
            if syms[x.s].iKind==NormalInteger:
                if y.iKind==BigInteger:
                    syms[x.s] = newInteger(syms[x.s].i+y.bi)
                else:
                    try:
                        syms[x.s].i += y.i
                    except OverflowDefect:
                        syms[x.s] = newInteger(newInt(syms[x.s].i)+y.i)
            else:
                if y.iKind==BigInteger:
                    syms[x.s].bi += y.bi
                else:
                    syms[x.s].bi += y.i
        else:
            if syms[x.s].kind==Floating:
                if y.kind==Floating: syms[x.s].f += y.f
                else: syms[x.s].f += (float)(y.i)
            else:
                syms[x.s] = newFloating((float)(syms[x.s].i)+y.f)
    else:
        stack.push(x+y)

template Sub*():untyped =
    require(opSub)

    if x.kind==Literal:
        if syms[x.s].kind==Integer and y.kind==Integer:
            if syms[x.s].iKind==NormalInteger:
                if y.iKind==BigInteger:
                    syms[x.s] = newInteger(syms[x.s].i-y.bi)
                else:
                    try:
                        syms[x.s].i -= y.i
                    except OverflowDefect:
                        syms[x.s] = newInteger(newInt(syms[x.s].i)-y.i)
            else:
                if y.iKind==BigInteger:
                    syms[x.s].bi -= y.bi
                else:
                    syms[x.s].bi -= y.i
        else:
            if syms[x.s].kind==Floating:
                if y.kind==Floating: syms[x.s].f -= y.f
                else: syms[x.s].f -= (float)(y.i)
            else:
                syms[x.s] = newFloating((float)(syms[x.s].i)-y.f)
    else:
        stack.push(x-y)

template Mul*():untyped =
    require(opMul)

    if x.kind==Literal:
        if syms[x.s].kind==Integer and y.kind==Integer:
            if syms[x.s].iKind==NormalInteger:
                if y.iKind==BigInteger:
                    syms[x.s] = newInteger(syms[x.s].i*y.bi)
                else:
                    try:
                        syms[x.s].i *= y.i
                    except OverflowDefect:
                        syms[x.s] = newInteger(newInt(syms[x.s].i)*y.i)
            else:
                if y.iKind==BigInteger:
                    syms[x.s].bi *= y.bi
                else:
                    syms[x.s].bi *= y.i
        else:
            if syms[x.s].kind==Floating:
                if y.kind==Floating: syms[x.s].f *= y.f
                else: syms[x.s].f *= (float)(y.i)
            else:
                syms[x.s] = newFloating((float)(syms[x.s].i)*y.f)
    else:
        stack.push(x*y)

template Div*():untyped =
    require(opDiv)

    if x.kind==Literal:
        if syms[x.s].kind==Integer and y.kind==Integer:
            if syms[x.s].iKind==NormalInteger:
                if y.iKind==BigInteger:
                    syms[x.s] = newInteger(syms[x.s].i div y.bi)
                else:
                    try:
                        syms[x.s] = newInteger(x.i div y.i)
                    except OverflowDefect:
                        syms[x.s] = newInteger(newInt(syms[x.s].i) div y.i)
            else:
                if y.iKind==BigInteger:
                    syms[x.s] = newInteger(syms[x.s].bi div y.bi)
                else:
                    syms[x.s] = newInteger(syms[x.s].bi div y.i)
        else:
            if syms[x.s].kind==Floating:
                if y.kind==Floating: syms[x.s].f /= y.f
                else: syms[x.s].f /= (float)(y.i)
            else:
                syms[x.s] = newFloating((float)(syms[x.s].i)/y.f)
    else:
        stack.push(x/y)

template Fdiv*():untyped = 
    require(opFDiv)

    if x.kind==Literal:
        if syms[x.s].kind==Integer and y.kind==Integer:
            syms[x.s] = newFloating(syms[x.s].i / y.i)
        else:
            if syms[x.s].kind==Floating:
                if y.kind==Floating: syms[x.s].f /= y.f
                else: syms[x.s].f /= (float)(y.i)
            else:
                syms[x.s] = newFloating((float)(x.i)/y.f)
    else:
        stack.push(x//y)

template Mod*():untyped = 
    require(opMod)

    if x.kind==Literal:
        if syms[x.s].iKind==NormalInteger:
            if y.iKind==NormalInteger: syms[x.s].i = syms[x.s].i mod y.i
            else: syms[x.s] = newInteger(syms[x.s].i mod y.bi)
        else:
            if y.iKind==NormalInteger: syms[x.s] = newInteger(syms[x.s].bi mod y.i)
            else: syms[x.s] = newInteger(syms[x.s].bi mod y.bi)
    else:
        stack.push(x%y)

template Pow*():untyped =
    require(opPow)

    if x.kind==Literal:
        if syms[x.s].kind==Integer and y.kind==Integer:
            let res = pow((float)syms[x.s].i,(float)y.i)
            syms[x.s] = newInteger((int)res)
        else:
            if syms[x.s].kind==Floating:
                if y.kind==Floating: syms[x.s] = newFloating(pow(syms[x.s].f,y.f))
                else: syms[x.s] = newFloating(pow(syms[x.s].f,(float)(y.i)))
            else:
                syms[x.s] = newFloating(pow((float)(syms[x.s].i),y.f))
    else:
        stack.push(x^y)

template Neg*():untyped =
    require(opNeg)

    if x.kind==Literal:
        if syms[x.s].kind==Integer: 
            if syms[x.s].iKind==NormalInteger: syms[x.s].i *= -1
            else: syms[x.s].bi *= -1
        else: syms[x.s] = newFloating(syms[x.s].f * (-1))
    else:
        if x.kind==Integer: 
            if x.iKind==NormalInteger:
                stack.push(newInteger(x.i * (-1)))
            elif x.iKind==BigInteger:
                stack.push(newInteger(newInt(x.i) * (-1)))
        else: stack.push(newFloating(x.f * (-1)))

template Inc*():untyped =
    require(opInc)

    if x.kind==Literal:
        if syms[x.s].kind == Integer: 
            if syms[x.s].iKind==NormalInteger: 
                try:
                    syms[x.s].i += 1
                except OverflowDefect:
                    syms[x.s] = newInteger(newInt(syms[x.s].i)+1)
            else: 
                syms[x.s].bi += 1
        elif syms[x.s].kind == Floating: syms[x.s].f += 1.0
    elif x.kind==Integer:
        if x.iKind==NormalInteger: 
            try:
                stack.push(newInteger(x.i+1))
            except OverflowDefect:
                stack.push(newInteger(newInt(x.i)+1))
        else: 
            stack.push(newInteger(x.bi+1))
    elif x.kind==Floating:
        stack.push(newFloating(x.f+1.0))

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