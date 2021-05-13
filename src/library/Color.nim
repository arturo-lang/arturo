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

import helpers/colors as colorsHelper

import vm/lib

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

    builtin "invert",
        alias       = at, 
        rule        = PrefixPrecedence,
        description = "invert given color",
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