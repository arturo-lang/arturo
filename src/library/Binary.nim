######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Binary.nim
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
        echo "- Importing: Binary"

    builtin "and",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "calculate the binary AND for the given values",
        args        = {
            "valueA": {Integer,Literal},
            "valueB": {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Nothing},
        example     = """
            print and 2 3      ; 2
            ..........
            a: 2
            and 'a 3           ; a: 2
        """:
            ##########################################################
            if x.kind==Literal : InPlace &&= y
            else               : push(x && y)


    builtin "nand",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "calculate the binary NAND for the given values",
        args        = {
            "valueA": {Integer,Literal},
            "valueB": {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Nothing},
        example     = """
            print nand 2 3     ; -3
            ..........
            a: 2
            nand 'a 3          ; a: -3
        """:
            ##########################################################
            if x.kind==Literal : InPlace &&= y; !!= InPlaced
            else               : push(!! (x && y))

    builtin "nor",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "calculate the binary NOR for the given values",
        args        = {
            "valueA": {Integer,Literal},
            "valueB": {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Nothing},
        example     = """
            print nor 2 3      ; -4
            ..........
            a: 2
            nor 'a 3           ; a: -4
        """:
            ##########################################################
            if x.kind==Literal : InPlace ||= y; !!= InPlaced
            else               : push(!! (x || y))

    builtin "not",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "calculate the binary complement the given value",
        args        = {
            "value" : {Integer,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Nothing},
        example     = """
            print not 123      ; -124
            ..........
            a: 123
            not 'a             ; a: -124
        """:
            ##########################################################
            if x.kind==Literal : !!= InPlace 
            else               : push(!! x)

    builtin "or",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "calculate the binary OR for the given values",
        args        = {
            "valueA": {Integer,Literal},
            "valueB": {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Nothing},
        example     = """
            print or 2 3       ; 3
            ..........
            a: 2
            or 'a 3            ; a: 3
        """:
            ##########################################################
            if x.kind==Literal : InPlace ||= y
            else               : push(x || y)

    builtin "shl",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "shift-left first value bits by second value",
        args        = {
            "value" : {Integer,Literal},
            "bits"  : {Integer}
        },
        attrs       = {
            "safe"  : ({Logical},"check for overflows")
        },
        returns     = {Integer,Nothing},
        example     = """
            print shl 2 3      ; 16
            ..........
            a: 2
            shl 'a 3           ; a: 16
        """:
            ##########################################################
            if x.kind==Literal : 
                let valBefore = InPlace
                InPlaced <<= y
                if InPlaced < valBefore and (popAttr("safe")!=VNULL):
                    SetInPlace(newBigInteger(valBefore.i) << y)
                    
            else               : 
                var res = x << y
                if res < x and (popAttr("safe")!=VNULL):
                    res = newBigInteger(x.i) << y
                push(res)

    builtin "shr",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "shift-right first value bits by second value",
        args        = {
            "value" : {Integer,Literal},
            "bits"  : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Nothing},
        example     = """
            print shr 16 3     ; 2
            ..........
            a: 16
            shr 'a 3           ; a: 2
        """:
            ##########################################################
            if x.kind==Literal : InPlace >>= y
            else               : push(x >> y)

    builtin "xnor",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "calculate the binary XNOR for the given values",
        args        = {
            "valueA": {Integer,Literal},
            "valueB": {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Nothing},
        example     = """
            print xnor 2 3     ; -2
            ..........
            a: 2
            xnor 'a 3          ; a: -2
        """:
            ##########################################################
            if x.kind==Literal : InPlace ^^= y; !!= InPlaced
            else               : push(!! (x ^^ y))
        
    builtin "xor",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "calculate the binary XOR for the given values",
        args        = {
            "valueA": {Integer,Literal},
            "valueB": {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Nothing},
        example     = """
            print xor 2 3      ; 1
            ..........
            a: 2
            xor 'a 3           ; a: 1
        """:
            ##########################################################
            if x.kind==Literal : InPlace ^^= y
            else               : push(x ^^ y)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)