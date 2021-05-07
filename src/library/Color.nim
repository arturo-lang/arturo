######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Color.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

# import sequtils, strformat, sugar, times, unicode
# when not defined(NOGMP):
#     import extras/bignum

# import helpers/datasource
# when not defined(NOASCIIDECODE):
#     import helpers/strings

import colors as stdColors

import vm/lib
#import vm/[errors, exec, parse]

#=======================================
# Helpers
#=======================================

template rawRGB(r, g, b: int): stdColors.Color =
    stdColors.Color(r shl 16 or g shl 8 or b)

proc satPlus(a, b: int): int {.inline.} =
    result = a +% b
    if result > 255: result = 255

proc satMinus(a, b: int): int {.inline.} =
    result = a -% b
    if result < 0: result = 0

proc alterColorValue*(c: stdColors.Color, f: float): stdColors.Color =
    var (r,g,b) = extractRGB(c)
    var pcent: float
    if f > 0:
        pcent = f
        r = satPlus(r, toInt(toFloat(r) * pcent))
        g = satPlus(g, toInt(toFloat(g) * pcent))
        b = satPlus(b, toInt(toFloat(b) * pcent))
        result = rawRGB(r, g, b)
    elif f < 0:
        pcent = (-1) * f
        r = satMinus(r, toInt(toFloat(r) * pcent))
        g = satMinus(g, toInt(toFloat(g) * pcent))
        b = satMinus(b, toInt(toFloat(b) * pcent))
        result = rawRGB(r, g, b)
    else:
        return c

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Converters"

    builtin "darken",
        alias       = at, 
        rule        = PrefixPrecedence,
        description = "darken color by given percentage (0.0-0.1)",
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

    builtin "lighten",
        alias       = at, 
        rule        = PrefixPrecedence,
        description = "lighten color by given percentage (0.0-0.1)",
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

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)