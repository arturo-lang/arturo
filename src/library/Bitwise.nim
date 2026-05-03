#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Bitwise.nim
#=======================================================

## The main Bitwise module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/lib

#=======================================
# Definitions
#=======================================

# TODO(Binary) more potential built-in function candidates?
#  I'm thinking that we could probably add functions that allows to either clear or "set" a specific bit.
#  Potentially, this could lead to the need of having another - e.g. `:bitset` - type.
#  Is it worth the fuss?
#  labels: library, enhancement, open discussion

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    builtin "and",
        alias       = unaliased, 
        op          = opBAnd,
        rule        = InfixPrecedence,
        description = "calculate the binary AND for the given values",
        args        = {
            "valueA": {Integer,Binary,Literal,PathLiteral},
            "valueB": {Integer,Binary}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Binary,Nothing},
        example     = """
            print and 2 3      ; 2
            ..........
            a: 2
            and 'a 3           ; a: 2
        """:
            #=======================================================
            generateOperationB("and", `&&`, `&&=`)

    builtin "nand",
        alias       = unaliased, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "calculate the binary NAND for the given values",
        args        = {
            "valueA": {Integer,Binary,Literal,PathLiteral},
            "valueB": {Integer,Binary}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Binary,Nothing},
        example     = """
            print nand 2 3     ; -3
            ..........
            a: 2
            nand 'a 3          ; a: -3
        """:
            #=======================================================
            dispatchWithLiteral:
                _:
                    value:
                        if normalIntegerOperation():
                            push(normalIntegerNot(normalIntegerAnd(x.i, y.i).i))
                        else:
                            push(!! (x && y))
                    inplace:
                        InPlaced &&= y
                        !!= InPlaced

    builtin "nor",
        alias       = unaliased, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "calculate the binary NOR for the given values",
        args        = {
            "valueA": {Integer,Binary,Literal,PathLiteral},
            "valueB": {Integer,Binary}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Binary,Nothing},
        example     = """
            print nor 2 3      ; -4
            ..........
            a: 2
            nor 'a 3           ; a: -4
        """:
            #=======================================================
            dispatchWithLiteral:
                _:
                    value:
                        if normalIntegerOperation():
                            push(normalIntegerNot(normalIntegerOr(x.i, y.i).i))
                        else:
                            push(!! (x || y))
                    inplace:
                        InPlaced ||= y
                        !!= InPlaced

    builtin "not",
        alias       = unaliased, 
        op          = opBNot,
        rule        = PrefixPrecedence,
        description = "calculate the binary complement of the given value",
        args        = {
            "value" : {Integer,Binary,Literal,PathLiteral}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Binary,Nothing},
        example     = """
            print not 123      ; -124
            ..........
            a: 123
            not 'a             ; a: -124
        """:
            #=======================================================
            generateOperationA("not", `!!`, `!!=`)

    builtin "or",
        alias       = unaliased, 
        op          = opBOr,
        rule        = InfixPrecedence,
        description = "calculate the binary OR for the given values",
        args        = {
            "valueA": {Integer,Binary,Literal,PathLiteral},
            "valueB": {Integer,Binary}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Binary,Nothing},
        example     = """
            print or 2 3       ; 3
            ..........
            a: 2
            or 'a 3            ; a: 3
        """:
            #=======================================================
            generateOperationB("or", `||`, `||=`)

    builtin "shl",
        alias       = unaliased, 
        op          = opShl,
        rule        = InfixPrecedence,
        description = "shift-left first value bits by second value",
        args        = {
            "value" : {Integer,Literal,PathLiteral},
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
            #=======================================================
            bindAttrs:
                safe: Logical

            dispatchWithLiteral:
                _:
                    value:
                        var res =
                            if normalIntegerOperation(): normalIntegerShl(x.i, y.i)
                            else:                        x << y
                        if res < x and safe:
                            res = newBigInteger(x.i) << y
                        push(res)
                    inplace:
                        let valBefore = InPlaced
                        InPlaced <<= y
                        if InPlaced < valBefore and safe:
                            SetInPlaceAny(newBigInteger(valBefore.i) << y)

    builtin "shr",
        alias       = unaliased, 
        op          = opShr,
        rule        = InfixPrecedence,
        description = "shift-right first value bits by second value",
        args        = {
            "value" : {Integer,Literal,PathLiteral},
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
            #=======================================================
            generateOperationB("shr", `>>`, `>>=`)

    builtin "xnor",
        alias       = unaliased, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "calculate the binary XNOR for the given values",
        args        = {
            "valueA": {Integer,Binary,Literal,PathLiteral},
            "valueB": {Integer,Binary}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Binary,Nothing},
        example     = """
            print xnor 2 3     ; -2
            ..........
            a: 2
            xnor 'a 3          ; a: -2
        """:
            #=======================================================
            dispatchWithLiteral:
                _:
                    value:
                        if normalIntegerOperation():
                            push(normalIntegerNot(normalIntegerXor(x.i, y.i).i))
                        else:
                            push(!! (x ^^ y))
                    inplace:
                        InPlaced ^^= y
                        !!= InPlaced
        
    builtin "xor",
        alias       = unaliased, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "calculate the binary XOR for the given values",
        args        = {
            "valueA": {Integer,Binary,Literal,PathLiteral},
            "valueB": {Integer,Binary}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Binary,Nothing},
        example     = """
            print xor 2 3      ; 1
            ..........
            a: 2
            xor 'a 3           ; a: 1
        """:
            #=======================================================
            generateOperationB("xor", `^^`, `^^=`)
