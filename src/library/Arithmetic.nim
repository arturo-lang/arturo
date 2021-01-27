######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Arithmetic.nim
######################################################

#=======================================
# Methods
#=======================================

builtin "add",
    alias       = plus, 
    precedence  = InfixPrecedence,
    description = "add given values and return result",
    args        = {
        "valueA": {Integer,Floating,Literal},
        "valueB": {Integer,Floating}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Floating,Nothing},
    example     = """
        print add 1 2  ____; 3
        print 1 + 3    ____; 4
        
        a: 4
        add 'a 1       ____; a: 5
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] += y
        else                : stack.push(x+y)

builtin "dec",
    alias       = unaliased, 
    precedence  = PrefixPrecedence,
    description = "decrease given value by 1",
    args        = {
        "value" : {Integer,Floating,Literal}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Floating,Nothing},
    example     = """
        print dec 5    ____; 4
        
        a: 4
        dec 'a         ____; a: 3
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] -= I1
        else                : stack.push(x-I1)
    
builtin "div",
    alias       = slash, 
    precedence  = InfixPrecedence,
    description = "perform integer division between given values and return result",
    args        = {
        "valueA": {Integer,Floating,Literal},
        "valueB": {Integer,Floating}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Nothing},
    example     = """
        print div 5 2  ____; 2
        print 9 / 3    ____; 3
        
        a: 6
        div 'a 3       ____; a: 2
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] /= y
        else                : stack.push(x/y)

builtin "fdiv",
    alias       = unaliased, 
    precedence  = InfixPrecedence,
    description = "divide given values and return result",
    args        = {
        "valueA": {Integer,Floating,Literal},
        "valueB": {Integer,Floating}
    },
    attrs       = NoAttrs,
    returns     = {Floating,Nothing},
    example     = """
        print fdiv 5 2 ____; 2.5
        
        a: 6
        fdiv 'a 3      ____; a: 2.0
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] //= y
        else                : stack.push(x//y)

builtin "inc",
    alias       = unaliased, 
    precedence  = PrefixPrecedence,
    description = "increase given value by 1",
    args        = {
        "value" : {Integer,Floating,Literal}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Floating,Nothing},
    example     = """
        print inc 5    ____; 6
        
        a: 4
        inc 'a         ____; a: 5
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] += I1
        else                : stack.push(x+I1)

builtin "mod",
    alias       = percent, 
    precedence  = InfixPrecedence,
    description = "calculate the modulo given values and return result",
    args        = {
        "valueA": {Integer,Literal},
        "valueB": {Integer}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Nothing},
    example     = """
        print mod 5 2  ____; 1
        print 9 % 3    ____; 0
        
        a: 8
        mod 'a 3       ____; a: 2
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] %= y
        else                : stack.push(x%y)

builtin "mul",
    alias       = asterisk, 
    precedence  = InfixPrecedence,
    description = "calculate the modulo given values and return result",
    args        = {
        "valueA": {Integer,Floating,Literal},
        "valueB": {Integer,Floating}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Floating,Nothing},
    example     = """
        print mul 1 2  ____; 2
        print 2 * 3    ____; 6
        
        a: 5
        mul 'a 2       ____; a: 10
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] *= y
        else                : stack.push(x*y)

builtin "neg",
    alias       = unaliased, 
    precedence  = PrefixPrecedence,
    description = "reverse sign of given value and return it",
    args        = {
        "value" : {Integer,Floating,Literal}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Floating,Nothing},
    example     = """
        print neg 1    ____; -1
        
        a: 5
        neg 'a         ____; a: -5
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] *= I1M
        else                : stack.push(x * I1M)

builtin "pow",
    alias       = caret, 
    precedence  = InfixPrecedence,
    description = "calculate the power of given values and return result",
    args        = {
        "valueA": {Integer,Floating,Literal},
        "valueB": {Integer,Floating}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Floating,Nothing},
    example     = """
        print pow 2 3  ____; 8
        print 3 ^ 2    ____; 9
        
        a: 5
        pow 'a 2       ____; a: 25
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] ^= y
        else                : stack.push(x^y)

builtin "sub",
    alias       = minus, 
    precedence  = InfixPrecedence,
    description = "subtract given values and return result",
    args        = {
        "valueA": {Integer,Floating,Literal},
        "valueB": {Integer,Floating}
    },
    attrs       = NoAttrs,
    returns     = {Integer,Floating,Nothing},
    example     = """
        print sub 2 1  ____; 1
        print 5 - 3    ____; 2
        
        a: 7
        sub 'a 2       ____; a: 5
    """:
        ##########################################################
        if x.kind==Literal  : syms[x.s] -= y
        else                : stack.push(x-y)
