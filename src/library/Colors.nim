######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Colors.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import helpers/colors as colorsHelper

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Converters"

    builtin "blend",
        alias       = at, 
        rule        = PrefixPrecedence,
        description = "blend given colors and get result",
        args        = {
            "colorA"    : {ValueKind.Color},
            "colorB"    : {ValueKind.Color}
        },
        attrs       = {
            "balance"   : ({Floating},"use different mix of color (0.0-1.0, default:0.5)")
        },
        returns     = {ValueKind.Color},
        # TODO(Color\blend) add documentation example
        #  labels: documentation,library,easy
        example     = """
        """:
            ##########################################################
            var balance = 0.5
            if (let aBalance = popAttr("balance"); aBalance != VNULL):
                balance = aBalance.f

            if x.kind == Literal:
                SetInPlace(newColor(blendColors(InPlace.l, y.l, balance)))
            else:
                push newColor(blendColors(x.l, y.l, balance))

    builtin "darken",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "darken color by given percentage (0.0-1.0)",
        args        = {
            "color"     : {ValueKind.Color},
            "percent"   : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {ValueKind.Color},
        # TODO(Color\darken) add documentation example
        #  labels: documentation,library,easy
        example     = """
        """:
            ##########################################################
            if x.kind == Literal:
                SetInPlace(newColor(alterColorValue(InPlace.l, y.f * (-1))))
            else:
                push newColor(alterColorValue(x.l, y.f * (-1)))

    builtin "desaturate",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "desaturate color by given percentage (0.0-1.0)",
        args        = {
            "color"     : {ValueKind.Color},
            "percent"   : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {ValueKind.Color},
        # TODO(Color\desaturate) add documentation example
        #  labels: documentation,library,easy
        example     = """
        """:
            ##########################################################
            if x.kind == Literal:
                SetInPlace(newColor(saturateColor(InPlace.l, y.f * (-1))))
            else:
                push newColor(saturateColor(x.l, y.f * (-1)))

    builtin "invert",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get complement for given color",
        args        = {
            "color"     : {ValueKind.Color}
        },
        attrs       = NoAttrs,
        returns     = {ValueKind.Color},
        # TODO(Color\invert) add documentation example
        #  labels: documentation,library,easy
        example     = """
        """:
            ##########################################################
            if x.kind == Literal:
                SetInPlace(newColor(invertColor(InPlace.l)))
            else:
                push newColor(invertColor(x.l))

    builtin "lighten",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "lighten color by given percentage (0.0-1.0)",
        args        = {
            "color"     : {ValueKind.Color},
            "percent"   : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {ValueKind.Color},
        # TODO(Color\lighten) add documentation example
        #  labels: documentation,library,easy
        example     = """
        """:
            ##########################################################
            if x.kind == Literal:
                SetInPlace(newColor(alterColorValue(InPlace.l, y.f)))
            else:
                push newColor(alterColorValue(x.l, y.f))

    builtin "saturate",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "saturate color by given percentage (0.0-1.0)",
        args        = {
            "color"     : {ValueKind.Color},
            "percent"   : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {ValueKind.Color},
        # TODO(Color\saturate) add documentation example
        #  labels: documentation,library,easy
        example     = """
        """:
            ##########################################################
            if x.kind == Literal:
                SetInPlace(newColor(saturateColor(InPlace.l, y.f)))
            else:
                push newColor(saturateColor(x.l, y.f))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)