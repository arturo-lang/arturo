#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Colors.nim
#=======================================================

## The main Colors module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import sequtils, sugar

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    # TODO(Colors) more potential built-in function candidates?
    #  labels: library, enhancement, open discussion

    builtin "blend",
        alias       = at, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "blend given colors and get result",
        args        = {
            "colorA"    : {Color},
            "colorB"    : {Color}
        },
        attrs       = {
            "balance"   : ({Floating},"use different mix of color (0.0-1.0, default:0.5)")
        },
        returns     = {Color},
        example     = """
            blend #red #CCCCCC                  ; => #E66666
            ..........
            blend .balance: 0.75 #red #CCCCCC   
            ; => #D99999
        """:
            #=======================================================
            var balance = 0.5
            if checkAttr("balance"):
                balance = aBalance.f

            if xKind == Literal:
                ensureInPlace()
                SetInPlace(newColor(blendColors(InPlaced.l, y.l, balance)))
            else:
                push newColor(blendColors(x.l, y.l, balance))

    builtin "darken",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "darken color by given percentage (0.0-1.0)",
        args        = {
            "color"     : {Color},
            "percent"   : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Color},
        example     = """
            darken #red 0.2         ; => #CC0000
            darken #red 0.5         ; => #7F0000

            darken #9944CC 0.3      ; => #6B308F
        """:
            #=======================================================
            if xKind == Literal:
                ensureInPlace()
                SetInPlace(newColor(alterColorValue(InPlaced.l, y.f * (-1))))
            else:
                push newColor(alterColorValue(x.l, y.f * (-1)))

    builtin "desaturate",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "desaturate color by given percentage (0.0-1.0)",
        args        = {
            "color"     : {Color},
            "percent"   : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Color},
        example     = """
            desaturate #red 0.2         ; => #E61919
            desaturate #red 0.5         ; => #BF4040

            desaturate #9944CC 0.3      ; => #9558B8
        """:
            #=======================================================
            if xKind == Literal:
                ensureInPlace()
                SetInPlace(newColor(saturateColor(InPlaced.l, y.f * (-1))))
            else:
                push newColor(saturateColor(x.l, y.f * (-1)))

    builtin "grayscale",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "convert color to grayscale",
        args        = {
            "color"     : {Color}
        },
        attrs       = NoAttrs,
        returns     = {Color},
        example     = """
            grayscale #red              ; => #808080
            grayscale #green            ; => #404040

            grayscale #FF44CC           ; => #A2A2A2
        """:
            #=======================================================
            if xKind == Literal:
                ensureInPlace()
                SetInPlace(newColor(saturateColor(InPlaced.l, -1.0)))
            else:
                push newColor(saturateColor(x.l, -1.0))

    builtin "invert",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get complement for given color",
        args        = {
            "color"     : {Color}
        },
        attrs       = NoAttrs,
        returns     = {Color},
        example     = """
            print #orange               ; #FFA500

            invert #orange              ; => #0059FF
        """:
            #=======================================================
            if xKind == Literal:
                ensureInPlace()
                SetInPlace(newColor(invertColor(InPlaced.l)))
            else:
                push newColor(invertColor(x.l))

    builtin "lighten",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "lighten color by given percentage (0.0-1.0)",
        args        = {
            "color"     : {Color},
            "percent"   : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Color},
        example     = """
            print #lightblue            ; #ADD8E6

            lighten #lightblue 0.2      ; => #D0FFFF
            lighten #lightblue 0.5      ; => #FFFFFF

            lighten #9944CC 0.3         ; => #C758FF
        """:
            #=======================================================
            if xKind == Literal:
                ensureInPlace()
                SetInPlace(newColor(alterColorValue(InPlaced.l, y.f)))
            else:
                push newColor(alterColorValue(x.l, y.f))

    builtin "palette",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "create palette using given base color",
        args        = {
            "color"     : {Color},
        },
        attrs       = {
            "triad"     : ({Logical},"generate a triad palette"),
            "tetrad"    : ({Logical},"generate a tetrad palette"),
            "split"     : ({Logical},"generate a split complement palette"),
            "analogous" : ({Logical},"generate an analogous palette"),
            "monochrome": ({Logical},"generate a monochromatic palette"),
            "random"    : ({Logical},"generate random palette based on color triads"),
            "size"      : ({Integer},"specify the size of the generated palette")
        },
        returns     = {Block},
        example     = """
            palette.triad #red      ; => [#FF0000 #00FF00 #0000FF]
            palette.tetrad #red     ; => [#FF0000 #80FF00 #00FFFF #7F00FF]
            ..........
            palette.monochrome #red
            ; => [#FF0000 #D40000 #AA0000 #7F0000 #550000 #2A0000]

            palette.monochrome.size:10 #red
            ; => [#FF0000 #E50000 #CC0000 #B20000 #990000 #7F0000 #660000 #4C0000 #330000 #190000]
            ..........
            palette.analogous #red
            ; => [#FF0099 #FF0066 #FF0033 #FF0000 #FF3300 #FF6600]

            palette.analogous.size:10 #red
            ; => [#FF00FF #FF00CC #FF0099 #FF0066 #FF0033 #FF0000 #FF3300 #FF6600 #FF9900 #FFCC00]
            ..........
            palette.random #red
            ; => [#FF0000 #00EC00 #0000D2 #00F000 #0000FF #00FF00]

            palette.random.size:10 #red
            ; => [#FF0000 #00FF00 #0000FF #00FE00 #F30000 #00FD00 #0000ED #EC0000 #00F800 #0000D8]
        """:
            #=======================================================
            if (hadAttr("triad")):
                push newBlock(triadPalette(x.l).map((c) => newColor(c)))
            elif (hadAttr("tetrad")):
                push newBlock(tetradPalette(x.l).map((c) => newColor(c)))
            elif (hadAttr("split")):
                push newBlock(splitPalette(x.l).map((c) => newColor(c)))
            elif (hadAttr("analogous")):
                var size = 6
                if checkAttr("size"):
                    size = aSize.i
                push newBlock(analogousPalette(x.l, size).map((c) => newColor(c)))
            elif (hadAttr("monochrome")):
                var size = 6
                if checkAttr("size"):
                    size = aSize.i
                push newBlock(monochromePalette(x.l, size).map((c) => newColor(c)))
            elif (hadAttr("random")):
                var size = 6
                if checkAttr("size"):
                    size = aSize.i
                push newBlock(randomPalette(x.l, size).map((c) => newColor(c)))
            else:
                push newBlock(@[x])

    builtin "saturate",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "saturate color by given percentage (0.0-1.0)",
        args        = {
            "color"     : {Color},
            "percent"   : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Color},
        example     = """
            print #lightblue            ; #ADD8E6

            saturate #lightblue 0.2     ; => #A7DBEC
            saturate #lightblue 0.5     ; => #9FDFF4

            saturate #9944CC 0.3        ; => #A030E0
        """:
            #=======================================================
            if xKind == Literal:
                ensureInPlace()
                SetInPlace(newColor(saturateColor(InPlaced.l, y.f)))
            else:
                push newColor(saturateColor(x.l, y.f))

    builtin "spin",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "spin color around the hue wheel by given amount",
        args        = {
            "color"     : {Color},
            "amount"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Color},
        example     = """
            spin #red 90            ; => #80FF00
            spin #red 180           ; => #00FFFF

            spin #123456 45         ; => #231256
            spin #123456 360        ; => #123456
        """:
            #=======================================================
            if xKind == Literal:
                ensureInPlace()
                SetInPlace(newColor(spinColor(InPlaced.l, y.i)))
            else:
                push newColor(spinColor(x.l, y.i))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)