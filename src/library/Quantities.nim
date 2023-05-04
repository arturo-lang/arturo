#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Quantities.nim
#=======================================================

## The main Quantities module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/values/custom/vquantity
import vm/values/custom/quantities/preprocessor

import vm/lib

#=======================================
# Helpers
#=======================================

template convertQuantity(x, y: Value, xKind, yKind: ValueKind): untyped =
    let qs = 
        if x.kind == Unit:
            x.u
        else:
            parseAtoms(x.s)

    if yKind==Quantity:
        push newQuantity(y.q.convertQuantity(qs))
    elif yKind==Integer:
        if y.iKind == NormalInteger:
            push newQuantity(toQuantity(y.i, qs))
        else:
            when not defined(NOGMP):
                push newQuantity(toQuantity(y.bi, qs))
    elif yKind==Floating:
        push newQuantity(toQuantity(y.f, qs))
    else:
        push newQuantity(toQuantity(y.rat, qs))

#=======================================
# Methods
#=======================================

# TODO: potential candidates!
#
# scalar: get value as rational -> rational
# coerce: force conversion of the value to the most appropriate numeric type
#       (* could this go to the Number module?)
# unit: get unit from quantity

proc defineSymbols*() =

    addPhysicalConstants()
    addPropertyPredicates()

    builtin "conforms?",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given quantities/units are compatible",
        args        = {
            "a"     : {Quantity, Unit},
            "b"     : {Quantity, Unit}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        # TODO(Quantities/conforms?) add documentation example
        #  labels: documentation, easy
        example     = """
        """:
            #=======================================================
            if xKind == Quantity:
                if yKind == Quantity:
                    push newLogical(x.q =~ y.q)
                else:
                    push newLogical(x.q =~ y.u)
            else:
                if yKind == Quantity:
                    push newLogical(x.u =~ y.q)
                else:
                    push newLogical(x.u =~ y.u)

    builtin "convert",
        alias       = longarrowright,
        op          = opNop,
        rule        = InfixPrecedence,
        description = "convert quantity to given unit",
        args        = {
            "value" : {Quantity,Integer,Floating,Rational},
            "unit"  : {Unit,Literal,String,Word}
        },
        attrs       = NoAttrs,
        returns     = {Quantity},
        example     = """
            print convert 3`m `cm
            ; 300.0 cm

            print 1`yd2 ~> `m2
            ; 0.836127 m²
        """:
            #=======================================================
            convertQuantity(y, x, yKind, xKind)

    builtin "in",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "convert quantity to given unit",
        args        = {
            "unit"  : {Unit,Literal,String,Word},
            "value" : {Quantity,Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Quantity},
        example     = """
            print in`cm 3`m
            ; 300.0 cm

            print in`m2 1`yd2
            ; 0.836127 m²
        """:
            #=======================================================
            convertQuantity(x, y, xKind, yKind)

    builtin "property",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get the described property of given quantity",
        args        = {
            "quantity"  : {Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Literal},
        # TODO(Quantities/property) add documentation example
        #  labels: documentation, easy
        example     = """
        """:
            #=======================================================
            push newLiteral(getProperty(x.q))

    builtin "specify",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "define new user unit",
        args        = {
            "name"  : {Literal,String},
            "value" : {Quantity,Unit}
        },
        attrs       = {
            "symbol"    : ({String}, "define main unit symbol"),
            "describes" : ({String}, "set corresponding property for new unit"),
            "property"  : ({Logical}, "define a new property")
        },
        returns     = {Literal},
        # TODO(Quantities/specify) add documentation example
        #  labels: documentation, easy
        example     = """
        """:
            #=======================================================
            if hadAttr("property"):
                if yKind == Quantity:
                    defineNewProperty(x.s, y.q)
                else:
                    defineNewProperty(x.s, y.u)
            else:
                var sym = x.s
                var desc = x.s
 
                if checkAttr("symbol"):
                    sym = aSymbol.s
 
                if checkAttr("describes"):
                    desc = aDescribes.s
 
                if yKind == Quantity:
                    defineNewUserUnit(x.s, sym, desc, y.q)
                else:
                    defineNewUserUnit(x.s, sym, desc, y.u)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
