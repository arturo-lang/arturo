######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Arithmetic.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Arithmetic"

    builtin "add",
        alias       = plus, 
        rule        = InfixPrecedence,
        description = "add given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Color,Quantity,Literal},
            "valueB": {Integer,Floating,Complex,Rational,Color,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Color,Quantity,Nothing},
        example     = """
            print add 1 2      ; 3
            print 1 + 3        ; 4
            ..........
            a: 4
            add 'a 1           ; a: 5
        """:
            ##########################################################
            if x.kind==Literal  : InPlace += y
            else                : push(x+y)

    builtin "dec",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "decrease given value by 1",
        args        = {
            "value" : {Integer,Floating,Rational,Quantity,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Rational,Quantity,Nothing},
        example     = """
            print dec 5        ; 4
            ..........
            a: 4
            dec 'a             ; a: 3
        """:
            ##########################################################
            if x.kind==Literal  : InPlace -= I1
            else                : push(x-I1)
        
    builtin "div",
        alias       = slash, 
        rule        = InfixPrecedence,
        description = "perform integer division between given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Quantity,Literal},
            "valueB": {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Quantity,Nothing},
        example     = """
            print div 5 2      ; 2
            print 9 / 3        ; 3
            ..........
            a: 6
            div 'a 3           ; a: 2
        """:
            ##########################################################
            if x.kind==Literal  : InPlace /= y
            else                : push(x/y)

    builtin "fdiv",
        alias       = doubleslash, 
        rule        = InfixPrecedence,
        description = "divide given values and return result",
        args        = {
            "valueA": {Integer,Floating,Rational,Quantity,Literal},
            "valueB": {Integer,Floating,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Rational,Quantity,Nothing},
        example     = """
            print fdiv 5 2     ; 2.5
            ..........
            a: 6
            fdiv 'a 3          ; a: 2.0
        """:
            ##########################################################
            if x.kind==Literal  : InPlace //= y
            else                : push(x//y)

    builtin "inc",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "increase given value by 1",
        args        = {
            "value" : {Integer,Floating,Rational,Quantity,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Rational,Quantity,Nothing},
        example     = """
            print inc 5        ; 6
            ..........
            a: 4
            inc 'a             ; a: 5
        """:
            ##########################################################
            if x.kind==Literal  : InPlace += I1
            else                : push(x+I1)

    builtin "mod",
        alias       = percent, 
        rule        = InfixPrecedence,
        description = "calculate the modulo of given values and return result",
        args        = {
            "valueA": {Integer,Floating,Rational,Quantity,Literal},
            "valueB": {Integer,Floating,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Rational,Quantity,Nothing},
        example     = """
            print mod 5 2      ; 1
            print 9 % 3        ; 0
            ..........
            a: 8
            mod 'a 3           ; a: 2
        """:
            ##########################################################
            if x.kind==Literal  : InPlace %= y
            else                : push(x%y)

    builtin "mul",
        alias       = asterisk, 
        rule        = InfixPrecedence,
        description = "calculate the product of given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Quantity,Literal},
            "valueB": {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Nothing},
        example     = """
            print mul 1 2      ; 2
            print 2 * 3        ; 6
            ..........
            a: 5
            mul 'a 2           ; a: 10
        """:
            ##########################################################
            if x.kind==Literal  : InPlace *= y
            else                : push(x*y)

    builtin "neg",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "reverse sign of given value and return it",
        args        = {
            "value" : {Integer,Floating,Complex,Rational,Quantity,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Quantity,Nothing},
        example     = """
            print neg 1        ; -1
            ..........
            a: 5
            neg 'a             ; a: -5
        """:
            ##########################################################
            if x.kind==Literal  : InPlace *= I1M
            else                : push(x * I1M)

    builtin "pow",
        alias       = caret, 
        rule        = InfixPrecedence,
        description = "calculate the power of given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Literal},
            "valueB": {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Nothing},
        example     = """
            print pow 2 3      ; 8
            print 3 ^ 2        ; 9
            ..........
            a: 5
            pow 'a 2           ; a: 25
        """:
            ##########################################################
            if x.kind==Literal  : InPlace ^= y
            else                : push(x^y)

    builtin "sub",
        alias       = minus, 
        rule        = InfixPrecedence,
        description = "subtract given values and return result",
        args        = {
            "valueA": {Integer,Floating,Complex,Rational,Color,Quantity,Literal},
            "valueB": {Integer,Floating,Complex,Rational,Color,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Complex,Rational,Color,Quantity,Nothing},
        example     = """
            print sub 2 1      ; 1
            print 5 - 3        ; 2
            ..........
            a: 7
            sub 'a 2           ; a: 5
        """:
            ##########################################################
            if x.kind==Literal  : InPlace -= y
            else                : push(x-y)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)