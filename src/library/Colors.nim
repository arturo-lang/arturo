######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
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
        example     = """
            blend #red #CCCCCC                  ; => #E66666
            ;;;;
            blend .balance: 0.75 #red #CCCCCC   
            ; => #D99999
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
        example     = """
            darken #red 0.2         ; => #CC0000
            darken #red 0.5         ; => #7F0000

            darken #9944CC 0.3      ; => #6B308F
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
        example     = """
            desaturate #red 0.2         ; => #E61919
            desaturate #red 0.5         ; => #BF4040

            desaturate #9944CC 0.3      ; => #9558B8
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
        example     = """
            print #orange               ; #FFA500

            invert #orange              ; => #0059FF
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
        example     = """
            print #lightblue            ; #ADD8E6

            lighten #lightblue 0.2      ; => #D0FFFF
            lighten #lightblue 0.5      ; => #FFFFFF

            lighten #9944CC 0.3         ; => #C758FF
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
        example     = """
            print #lightblue            ; #ADD8E6

            saturate #lightblue 0.2     ; => #A7DBEC
            saturate #lightblue 0.5     ; => #9FDFF4

            saturate #9944CC 0.3        ; => #A030E0
        """:
            ##########################################################
            if x.kind == Literal:
                SetInPlace(newColor(saturateColor(InPlace.l, y.f)))
            else:
                push newColor(saturateColor(x.l, y.f))

    builtin "spin",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "spin color around the hue wheel by given amount",
        args        = {
            "color"     : {ValueKind.Color},
            "amount"   : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {ValueKind.Color},
        # TODO(Colors\spin) add library documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            if x.kind == Literal:
                SetInPlace(newColor(spinColor(InPlace.l, y.i)))
            else:
                push newColor(spinColor(x.l, y.i))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)