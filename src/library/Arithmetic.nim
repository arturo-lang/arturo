#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: library/Arithmetic.nim
#=======================================================

## The main Arithmetic module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/lib

when defined(GMP):
    import helpers/bignums as BignumsHelper

#=======================================
# Definitions
#=======================================

# TODO(Arithmetic) add `powmod` built-in function?
#  labels: library, enhancement, open discussion

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------

    builtin "add",
        alias       = plus, 
        op          = opAdd,
        rule        = InfixPrecedence,
        description = "add given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Color,Quantity,Object,Literal,PathLiteral},
            "valueB": {Integer,Floating,Complex,Rational,Color,Quantity,Object}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Color,Quantity,Object,Nothing},
        example     = """
            print add 1 2      ; 3
            print 1 + 3        ; 4
            ..........
            a: 4
            add 'a 1           ; a: 5
        """:
            #=======================================================
            generateOperationB("add", `+`, `+=`)

    builtin "dec",
        alias       = unaliased, 
        op          = opDec,
        rule        = PrefixPrecedence,
        description = "decrease given value by 1",
        args        = {
            "value" : {Integer,Floating,Complex,Rational,Quantity,Object,Literal,PathLiteral}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Quantity,Object,Nothing},
        example     = """
            print dec 5        ; 4
            ..........
            a: 4
            dec 'a             ; a: 3
        """:
            #=======================================================
            generateOperationA("dec", `dec`, `decI`)
        
    builtin "div",
        alias       = slash, 
        op          = opDiv,
        rule        = InfixPrecedence,
        description = "perform integer division between given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Quantity,Object,Literal,PathLiteral},
            "valueB": {Integer,Floating,Complex,Rational,Quantity,Object}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Quantity,Object,Nothing},
        example     = """
            print div 5 2      ; 2
            print 9 / 3        ; 3
            ..........
            a: 6
            div 'a 3           ; a: 2
        """:
            #=======================================================
            generateOperationB("div", `/`, `/=`)

    builtin "divmod",
        alias       = slashpercent, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "perform integer division between given values and return tuple with quotient and remainder",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Quantity,Literal,PathLiteral},
            "valueB": {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            print divmod 15 5       ; 3 0
            print 14 /% 3           ; 4 2
            ..........
            [q,r]: 10 /% 3          ; q: 3, r: 1
            ..........
            a: 6
            divmod 'a 4             ; a: [1, 2]
        """:
            #=======================================================
            generateOperationB("divmod", `/%`, `/%=`)

    builtin "fdiv",
        alias       = doubleslash, 
        op          = opFDiv,
        rule        = InfixPrecedence,
        description = "divide given values and return result",
        args        = {
            "valueA": {Integer,Floating,Rational,Quantity,Object,Literal,PathLiteral},
            "valueB": {Integer,Floating,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Rational,Quantity,Object,Nothing},
        example     = """
            print fdiv 5 2     ; 2.5
            ..........
            a: 6
            fdiv 'a 3          ; a: 2.0
        """:
            #=======================================================
            generateOperationB("fdiv", `//`, `//=`)

    builtin "inc",
        alias       = unaliased, 
        op          = opInc,
        rule        = PrefixPrecedence,
        description = "increase given value by 1",
        args        = {
            "value" : {Integer,Floating,Complex,Rational,Quantity,Object,Literal,PathLiteral}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Quantity,Object,Nothing},
        example     = """
            print inc 5        ; 6
            ..........
            a: 4
            inc 'a             ; a: 5
        """:
            #=======================================================
            generateOperationA("inc", `inc`, `incI`)

    builtin "mod",
        alias       = percent, 
        op          = opMod,
        rule        = InfixPrecedence,
        description = "calculate the modulo of given values and return result",
        args        = {
            "valueA": {Integer,Floating,Rational,Quantity,Object,Literal,PathLiteral},
            "valueB": {Integer,Floating,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Rational,Quantity,Object,Nothing},
        example     = """
            print mod 5 2      ; 1
            print 9 % 3        ; 0
            ..........
            a: 8
            mod 'a 3           ; a: 2
        """:
            #=======================================================
            generateOperationB("mod", `%`, `%=`)

    builtin "mul",
        alias       = asterisk, 
        op          = opMul,
        rule        = InfixPrecedence,
        description = "calculate the product of given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Quantity,Object,Literal,PathLiteral},
            "valueB": {Integer,Floating,Complex,Rational,Quantity,Object}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Quantity,Object,Nothing},
        example     = """
            print mul 1 2      ; 2
            print 2 * 3        ; 6
            ..........
            a: 5
            mul 'a 2           ; a: 10
        """:
            #=======================================================
            generateOperationB("mul", `*`, `*=`)

    builtin "neg",
        alias       = unaliased, 
        op          = opNeg,
        rule        = PrefixPrecedence,
        description = "reverse sign of given value and return it",
        args        = {
            "value" : {Integer,Floating,Complex,Rational,Quantity,Object,Literal,PathLiteral}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Quantity,Object,Nothing},
        example     = """
            print neg 1        ; -1
            ..........
            a: 5
            neg 'a             ; a: -5
        """:
            #=======================================================
            generateOperationA("neg", `neg`, `negI`)

    builtin "pow",
        alias       = caret, 
        op          = opPow,
        rule        = InfixPrecedence,
        description = "calculate the power of given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Quantity,Object,Literal,PathLiteral},
            "valueB": {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Quantity,Object,Nothing},
        example     = """
            print pow 2 3      ; 8
            print 3 ^ 2        ; 9
            ..........
            a: 5
            pow 'a 2           ; a: 25
        """:
            #=======================================================
            generateOperationB("pow", `^`, `^=`)

    builtin "sub",
        alias       = minus, 
        op          = opSub,
        rule        = InfixPrecedence,
        description = "subtract given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Color,Quantity,Object,Literal,PathLiteral},
            "valueB": {Integer,Floating,Complex,Rational,Color,Quantity,Object}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Color,Quantity,Object,Nothing},
        example     = """
            print sub 2 1      ; 1
            print 5 - 3        ; 2
            ..........
            a: 7
            sub 'a 2           ; a: 5
        """:
            #=======================================================
            generateOperationB("sub", `-`, `-=`)

#=======================================
# Add Library
#=======================================

Libraries.add(defineLibrary)