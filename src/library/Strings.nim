#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Strings.nim
#=======================================================

## The main Strings module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import re except Regex
    import nre except Regex, toSeq

import std/editdistance, json, os
import sequtils, strutils, sugar
import unicode, std/wordwrap, xmltree

import helpers/charsets
import helpers/strings

import vm/lib

when not defined(WEB):
    import vm/[eval, exec]

import vm/parse

import vm/values/custom/[vrange]

#=======================================
# Variables
#=======================================

when not defined(WEB):
    var
        templateStore = initTable[string,Translation]()

#=======================================
# Helpers
#=======================================

template replaceStrWith(str: var string, src: Value, dst: Value): untyped =
    requireValue(src, {String,Regex})
    requireValue(dst, {String})
    if src.kind==String:
        str = str.replaceAll(src.s, dst.s)
    elif src.kind==Regex:
        str = str.replaceAll(src.rx, dst.s)

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------
    
    # TODO(Strings\alphabet) Should we move it to the Sets module?
    #  yes, strings are composed by characters which - together - form an alphabet.
    #  But what does this function return, if it's not a Set?
    #  labels: library, enhancement, cleanup, open discussion
    builtin "alphabet",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get dictionary-index charset for given locale",
        args        = {
            "locale": {String,Literal}
        },
        attrs       = {
            "lower" : ({Logical},"return lowercase characters (default)"),
            "upper" : ({Logical},"return uppercase characters"),
            "all"   : ({Logical},"also return non-dictionary characters")
        },
        returns     = {Block,Null},
        example     = """
            alphabet'es
            ; => [a b c d e f g h i j k l m n ñ o p q r s t u v w x y z]

            alphabet.upper 'es
            ; => [A B C D E F G H I J K L M N Ñ O P Q R S T U V W X Y Z]

            alphabet.all 'es
            ; => [a b c d e f g h i j k l m n ñ o p q r s t u v w x y z á é í ó ú ü]

            alphabet.lower.upper.all 'es
            ; => [a b c d e f g h i j k l m n ñ o p q r s t u v w x y z á é í ó ú ü A B C D E F G H I J K L M N Ñ O P Q R S T U V W X Y Z Á É Í Ó Ú Ü]
        """:
            #=======================================================
            bindAttrs:
                lower: Logical
                upper: Logical
                all:   Logical

            dispatch:
                _:
                    var got: ValueArray

                    if upper:
                        if lower:
                            got = getCharset(x.s, withExtras=all)

                        got.add(getCharset(x.s, withExtras=all, doUppercase=true))
                    else:
                        got = getCharset(x.s, withExtras=all)

                    push(newBlock(got))

    builtin "capitalize",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "convert given string to capitalized",
        args        = {
            "string": {String,Char,Literal,PathLiteral}
        },
        attrs       = NoAttrs,
        returns     = {String,Char,Nothing},
        example     = """
            print capitalize "hello World"      ; "Hello World"
            ..........
            str: "hello World"
            capitalize 'str                     ; str: "Hello World"
        """:
            #=======================================================
            dispatchWithLiteral:
                String(s): s.capitalize()
                Char(c):   c.toUpper()

    builtin "escape",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "escape given string",
        args        = {
            "string": {String,Literal,PathLiteral}
        },
        attrs       = {
            "json"  : ({Logical},"for literal use in JSON strings"),
            "regex" : ({Logical},"for literal use in regular expression"),
            "shell" : ({Logical},"for use in a shell command"),
            "xml"   : ({Logical},"for use in an XML document")
        },
        returns     = {String,Nothing},
        example     = """
            str: {a long "string" + with \diffe\rent symbols.}

            print escape str
            ; "a long \"string\" + with \\diffe\\rent symbols."

            print escape.json str
            ; a long \"string\" + with \\diffe\\rent symbols.

            print escape.regex str
            ; a\x20long\x20\x22string\x22\x20\x2B\x20with\x20\x5Cdiffe\x5Crent\x20symbols\x2E

            print escape.shell str
            ; 'a long "string" + with \diffe\rent symbols.'

            print escape.xml str
            ; a long &quot;string&quot; + with \diffe\rent symbols.
        """:
            #=======================================================
            dispatchWithLiteral:
                String(s):
                    on json:  escapeJsonUnquoted(s)
                    on regex: escapeForRegex(s)
                    on xml:   xmltree.escape(s)
                    on shell:
                        when not defined(WEB): quoteShell(s)
                        else:                  strutils.escape(s)
                    _:        strutils.escape(s)

    builtin "indent",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "indent each line of given text",
        args        = {
            "text"  : {String,Literal,PathLiteral}
        },
        attrs       = {
            "n"     : ({Integer},"pad by given number of spaces (default: 4)"),
            "with"  : ({String},"use given padding")
        },
        returns     = {String,Nothing},
        example     = """
            str: "one\ntwo\nthree"

            print indent str
            ;     one
            ;     two
            ;     three

            print indent .n:10 .with:"#" str
            ; ##########one
            ; ##########two
            ; ##########three
        """:
            #=======================================================
            bindAttrs:
                n:               Integer = 4
                padding(with):   String  = " "

            dispatchWithLiteral:
                String(s): indent(s, n, padding)

    builtin "jaro",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate Jaro distance/similarity between given strings",
        args        = {
            "stringA"   : {String},
            "stringB"   : {String}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            jaro "one" "one"        ; => 1.0

            jaro "crate" "trace"    ; => 0.7333333333333334
            jaro "dwayne" "duane"   ; => 0.8222222222222223

            jaro "abcdef" "fedcba"  ; => 0.3888888888888888
            jaro "abcde" "vwxyz"    ; => 0.0
        """:
            dispatch:
                (String(s), String(t)): push(newFloating(jaro(s, t)))

    builtin "join",
        alias       = unaliased, 
        op          = opJoin,
        rule        = PrefixPrecedence,
        description = "join collection of values into string",
        args        = {
            "collection"    : {Block,Literal,PathLiteral}
        },
        attrs       = {
            "with"  : ({String, Char},"use given separator"),
            "path"  : ({Logical},"join as path components"),
            "lines" : ({Logical},"join with newlines as separator."),
            "words" : ({Logical},"join with spaces as separator")
        },
        returns     = {String,Nothing},
        example     = """
            arr: ["one" "two" "three"]
            print join arr
            ; onetwothree
            
            print join.with:"," arr
            ; one,two,three
            
            join 'arr
            ; arr: "onetwothree"
            ..........
            print join ['H' 'e' 'l' 'l' 'o' '!']
            ; Hello!

            print join @["1 + 2 = " 1+2]
            ; 1 + 2 = 3
            ..........
            join.with:'-' ["Hello" "world"]
            ; => "Hello-world"
            ..........
            join.words ["This" "is" "a" "sentence."]
            ; => "This is a sentence."
            ..........
            ; This example uses the universal new line character
            ; If you need to use carriage return for some reason, use join.with: "\\r\\n" instead.
            $> join.lines ["# Recipe", "", "1. Apple", "2. Banana"]
            => # Recipe

            1. Apple
            2. Banana
        """:
            #=======================================================
            bindAttrs:
                asPath(path):  Logical
                asWords(words): Logical
                asLines(lines): Logical

            var sep: string
            if not asPath:
                if checkAttr("with"):
                    if likely(aWith.kind == String): sep = aWith.s
                    else:                            sep = $(aWith.c)
                elif asWords: sep = " "
                elif asLines: sep = "\n"
                else:         sep = ""

            dispatchWithLiteral:
                Block(a):
                    value:
                        let strs = a.map(proc (v: Value): string = $(v))
                        if asPath: push(newString(joinPath(strs)))
                        else:      push(newString(strs.join(sep)))
                    inplace:
                        let strs = a.map(proc (v: Value): string = $(v))
                        if asPath: SetInPlaceAny(newString(joinPath(strs)))
                        else:      SetInPlaceAny(newString(strs.join(sep)))

    builtin "levenshtein",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate Levenshtein distance/similarity between given strings",
        args        = {
            "stringA"   : {String},
            "stringB"   : {String}
        },
        attrs       = {
            "align" : ({Logical},"return aligned strings"),
            "with"  : ({Char},"use given filler for alignment (default: -)")
        },
        returns     = {Integer,Block},
        example     = """
            print levenshtein "for" "fur"         ; 1
            print levenshtein "one" "one"         ; 0
            ..........
            print join.with:"\n" levenshtein .align "ACTGCACTGAC" "GCATGACTAT"
            ; AC-TGCACTGAC
            ; GCATG-ACT-AT
        """:
            bindAttrs:
                align:         Logical
                filler(with):  Char = "-".runeAt(0)

            if align:
                let aligned = levenshteinAlign(x.s, y.s, filler)
                push(newStringBlock(@[aligned[0], aligned[1]]))
                return

            dispatch:
                (String(s), String(t)): push(newInteger(editDistance(s, t)))

    builtin "lower",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "convert given string to lowercase",
        args        = {
            "string": {String,Char,Literal,PathLiteral}
        },
        attrs       = NoAttrs,
        returns     = {String,Char,Nothing},
        example     = """
            print lower "hello World, 你好!"      ; "hello world, 你好!"
            ..........
            str: "hello World, 你好!"
            lower 'str                           ; str: "hello world, 你好!"
            ..........
            ch: 'A'
            lower ch    
            ; => 'a'  
        """:
            #=======================================================
            dispatchWithLiteral:
                String(s): s.toLower()
                Char(c):   c.toLower()

    # TODO(Strings\match) should work for Web builds as well
    #  labels: library, web, bug

    # TODO(Strings\match) add support for Char values as the value-to-match
    #  labels: library, enhancement
    when not defined(WEB):
        builtin "match",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "get matches within string, using given pattern or regular expression",
            args        = {
                "string": {String},
                "regex" : {Regex, String, Char}
            },
            attrs       = {
                "once"      : ({Logical},"get just the first match"),
                "count"     : ({Logical},"just get number of matches"),
                "capture"   : ({Logical},"get capture groups only"),
                "named"     : ({Logical},"get named capture groups as a dictionary"),
                "bounds"    : ({Logical},"get match bounds only"),
                "in"        : ({Range},"get matches within given range"),
                "full"      : ({Logical},"get results as an array of match results")
            },
            returns     = {Integer,Block,Dictionary},
            example     = """
            match "hello" "hello"                   ; => ["hello"]
            match "x: 123, y: 456" {/[0-9]+/}       ; => ["123" "456"]
            match "this is a string" {/[0-9]+/}     ; => []
            ..........
            match.once "x: 123, y: 456" {/[0-9]+/}      ; => ["123"]
            ..........
            match.count "some words" {/\w+/}        ; => 2
            ..........
            match.capture "abc" {/(.)/}             ; => ["a" "b" "c"]

            match.capture "x: 123, y: 456 - z: 789, w: 012" 
                          {/\w: (\d+), \w: (\d+)/}
            ; => [["123" "456"] ["789" "012"]]
            ..........
            inspect match.capture.named "x: 123, y: 456 - z: 789, w: 012" 
                                        {/\w: (?<numA>\d+), \w: (?<numB>\d+)/}
            ;[ :block
            ;    [ :dictionary
            ;        numA  :		123 :string
            ;        numB  :		456 :string
            ;    ]
            ;    [ :dictionary
            ;        numA  :		789 :string
            ;        numB  :		012 :string
            ;    ]
            ;]
            ..........
            match.bounds "hELlo wORLd" {/[A-Z]+/} 
            ; => [1..2 7..9]
            ..........
            match.in:0..2 "hello" {/l/}             ; => ["l"]
            """:
                #=======================================================
                let rgx : VRegex =
                    if yKind==Regex: y.rx
                    elif yKind==String: newRegex(y.s).rx
                    else: newRegex($(y.c)).rx

                bindAttrs:
                    doOnce(once):       Logical
                    doCount(count):     Logical
                    doCapture(capture): Logical
                    doNamed(named):     Logical
                    doBounds(bounds):   Logical
                    doFull(full):       Logical

                var iFrom = 0
                var iTo = int.high

                if checkAttr("in"):
                    iFrom = aIn.rng.start
                    if iFrom < 0:
                        iFrom = 0

                    iTo = aIn.rng.stop
                    if iTo >= x.s.len:
                        iTo = x.s.len-1

                if doCount:
                    var cnt = 0
                    for m in x.s.findIter(rgx, iFrom, iTo):
                        cnt += 1
                    push(newInteger(cnt))

                elif doFull:
                    var matches, matchesBounds: ValueArray
                    var captures, capturesBounds: ValueArray

                    for m in x.s.findIter(rgx, iFrom, iTo):
                        matches.add(newString(m.match))
                        let mBounds = m.matchBounds
                        matchesBounds.add(newRange(mBounds.a, mBounds.b, 1, false, true, true))

                        let capts = (m.captures.toSeq).map((w) => w.get)
                        captures.add(newStringBlock(capts))
                        let cBounds = (m.captureBounds.toSeq).map((w) => newRange(w.get.a, w.get.b, 1, false, true, true))
                        capturesBounds.add(newBlock(cBounds))

                        if doOnce: break

                    let fMatches = (matches.zip(matchesBounds)).map((w) => newBlock(w))
                    let fCaptures = (captures.zip(capturesBounds)).map((w) => newBlock(w))

                    push(newDictionary({
                        "matches":  newBlock(fMatches),
                        "captures": newBlock(fCaptures)
                    }.toOrderedTable))

                else:
                    var res: ValueArray

                    for m in x.s.findIter(rgx, iFrom, iTo):
                        if doCapture:
                            if doNamed:
                                res.add(newStringDictionary(m.captures.toTable))
                            else:
                                let captures = (m.captures.toSeq).map((w) => w.get)
                                if captures.len > 1:
                                    res.add(newStringBlock(captures))
                                else:
                                    res.add(newString(captures[0]))
                        elif doBounds:
                            let bounds = m.matchBounds
                            res.add(newRange(bounds.a, bounds.b, 1, false, true, true))
                        else:
                            res.add(newString(m.match))
                        
                        if doOnce: break

                    push(newBlock(res))

    builtin "outdent",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "outdent each line of given text, by using minimum shared indentation",
        args        = {
            "text"  : {String,Literal,PathLiteral}
        },
        attrs       = {
            "n"     : ({Integer},"unpad by given number of spaces"),
            "with"  : ({String},"use given padding")
        },
        returns     = {String,Nothing},
        example     = """
            print outdent {:
                one
                    two
                    three
            :}
            ; one
            ;     two
            ;     three
            ..........
            print outdent.n:1 {:
                one
                    two
                    three
            :}
            ;  one
            ;      two
            ;      three

        """:
            #=======================================================
            var count = 0
            if xKind in {Literal,PathLiteral}:
                ensureInPlaceAny()
                count = indentation(InPlaced.s)
            else:
                count = indentation(x.s)

            var padding = " "

            if checkAttr("n"):
                count = aN.i

            if checkAttr("with"):
                padding = aWith.s

            if xKind in {Literal, PathLiteral}:
                ensureInPlaceAny()
                SetInPlaceAny(newString(unindent(InPlaced.s, count, padding)))
            else:
                push(newString(unindent(x.s, count, padding))) 

    builtin "pad",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "align string by adding given padding",
        args        = {
            "string"    : {String,Literal,PathLiteral},
            "padding"   : {Integer}
        },
        attrs       = {
            "center"    : ({Logical},"add padding to both sides"),
            "right"     : ({Logical},"add right padding"),
            "with"      : ({Char},"pad with given character")
        },
        returns     = {String},
        example     = """
            pad "good" 10                 ; => "      good"
            pad.right "good" 10           ; => "good      "
            pad.center "good" 10          ; => "   good   "
            ..........
            a: "hello"
            pad 'a 10                     ; a: "     hello"
            ..........
            pad.with:`0` to :string 123 5   
            ; => 00123
        """:
            #=======================================================
            bindAttrs:
                padding(with): Char = ' '.Rune

            dispatchWithLiteral:
                String(s):
                    on right:  unicode.alignLeft(s, y.i, padding=padding)
                    on center: centerUnicode(s, y.i, padding=padding)
                    _:         unicode.align(s, y.i, padding=padding)

    when not defined(WEB):
        # TODO(Strings\render) function should also work for Web/JS builds
        #  the lack of proper RegEx libraries could be handled by using the newly-added JS helper functions
        #  labels: enhancement,library,web

        builtin "render",
            alias       = tilde, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "render template with |string| interpolation",
            args        = {
                "template"  : {String,Literal,PathLiteral}
            },
            attrs       = {
                "once"      : ({Logical},"don't render recursively"),
                "template"  : ({Logical},"render as a template")
            },
            returns     = {String,Nothing},
            example     = """
            x: 2
            greeting: "hello"
            print ~"|greeting|, your number is |x|"       ; hello, your number is 2
            """:
                #=======================================================
                bindAttrs:
                    once: Logical
                    templated(`template`): Logical

                let recursive = not once

                let Interpolated    = nre.re"\|([^\|]+)\|"
                let Embeddable      = re.re"(?s)(\<\|\|.*?\|\|\>)"

                dispatchWithLiteral:
                    String(s):
                        block:
                            var res = s
                            if templated:
                                var keepGoing = true
                                if recursive:
                                    keepGoing = res.contains(Embeddable)

                                while keepGoing:
                                    var evaled: Translation

                                    evaled = templateStore.getOrDefault(res, nil)
                                    if evaled.isNil:
                                        let initial = res
                                        # make necessary substitutions
                                        res = "««" & res.replace("<||=","<|| to :string ").multiReplace(
                                            ("||>","««"),
                                            ("<||","»»")
                                        ) & "»»"

                                        # parse string template
                                        evaled = doEval(doParse(res, isFile=false))
                                        templateStore[initial] = evaled

                                    # execute/reduce ('array') the resulting block
                                    let stop = SP
                                    execUnscoped(evaled)

                                    let arr: ValueArray = sTopsFrom(stop)
                                    SP = stop

                                    # and join the different strings
                                    res = ""
                                    for i, v in arr:
                                        if (not v.isNil) and v.kind==String:
                                            add(res, v.s)

                                    # if recursive, check if there's still more embedded tags
                                    # otherwise, break out of the loop
                                    if recursive: keepGoing = res.contains(Embeddable)
                                    else: keepGoing = false
                            else:
                                var keepGoing = true
                                if recursive:
                                    keepGoing = res.find(Interpolated).isSome

                                while keepGoing:
                                    res = res.replace(Interpolated, proc (match: RegexMatch): string =
                                                execUnscoped(doParse(match.captures[0], isFile=false))
                                                $(stack.pop())
                                            )

                                    # if recursive, check if there's still more embedded tags
                                    # otherwise, break out of the loop
                                    if recursive: keepGoing = res.find(Interpolated).isSome
                                    else: keepGoing = false
                            res

    # TODO(Strings\replace) better implementation with more options needed
    #  Obviously, no need to overdo it here. But at least, we could add support for things like `.once`
    #  or strict replacement of the matched groups, etc - if possible, in the style of `match`
    #
    #  see: https://discord.com/channels/765519132186640445/829324913097048065/1078717850270842962
    #  labels: enhancement,library

    builtin "replace",
        alias       = unaliased, 
        op          = opReplace,
        rule        = PrefixPrecedence,
        description = "replace every matched substring/s with given replacement string and return result",
        args        = {
            "string"        : {String, Literal,PathLiteral},
            "match"         : {String, Regex, Block},
            "replacement"   : {String, Block}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            replace "hello" "l" "x"         ; => "hexxo"
            ..........
            str: "hello"
            replace 'str "l" "x"            ; str: "hexxo"
            ..........
            replace "hello" ["h" "l"] "x"           ; => "xexxo"
            replace "hello" ["h" "o"] ["x" "z"]     ; => "xellz"
        """:
            #=======================================================
            dispatchWithLiteral:
                (String(s), String(m),   String(r)):
                    value:   push(newString(s.replaceAll(m, r)))
                    inplace: s = s.replaceAll(m, r)
                (String(s), Regex(rgx),  String(r)):
                    value:   push(newString(s.replaceAll(rgx, r)))
                    inplace: s = s.replaceAll(rgx, r)
                (String(s), Block(matches), String(_)):
                    value:
                        var final = s
                        for item in matches:
                            replaceStrWith(final, item, z)
                        push(newString(final))
                    inplace:
                        for item in matches:
                            replaceStrWith(s, item, z)
                (String(s), Block(matches), Block(reps)):
                    value:
                        var final = s
                        let lim = min(len(matches), len(reps))
                        var i = 0
                        while i < lim:
                            replaceStrWith(final, matches[i], reps[i])
                            inc i
                        push(newString(final))
                    inplace:
                        let lim = min(len(matches), len(reps))
                        var i = 0
                        while i < lim:
                            replaceStrWith(s, matches[i], reps[i])
                            inc i

    builtin "strip",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "strip whitespace from given string",
        args        = {
            "string": {String,Literal,PathLiteral}
        },
        attrs       = {
            "start" : ({Logical},"strip leading whitespace"),
            "end"   : ({Logical},"strip trailing whitespace")
        },
        returns     = {String,Nothing},
        example     = """
            str: "     Hello World     "

            print ["strip all:"      ">" strip str       "<"]
            print ["strip leading:"  ">" strip.start str "<"]
            print ["strip trailing:" ">" strip.end str   "<"]

            ; strip all: > Hello World < 
            ; strip leading: > Hello World      < 
            ; strip trailing: >      Hello World <
        """:
            #=======================================================
            bindAttrs:
                leading(start):  Logical
                trailing(`end`): Logical

            var stripStart = leading
            var stripEnd   = trailing
            if not leading and not trailing:
                stripStart = true
                stripEnd   = true

            dispatchWithLiteral:
                String(s): strutils.strip(s, stripStart, stripEnd)

    builtin "translate",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "takes a dictionary of translations and replaces each instance sequentially",
        args        = {
            "string"        : {String, Literal, PathLiteral},
            "translations"  : {Dictionary}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            print translate "the brown fox jumped over the lazy dog" #[
                brown: "green" 
                fox: "wolf" 
                jumped:"flew" 
                dog:"cat"
            ]
            ; the green wolf flew over the lazy cat
        """:
            #=======================================================
            let replacements = (toSeq(y.d.pairs)).map((w) => (w[0], w[1].s))

            dispatchWithLiteral:
                String(s): s.multiReplace(replacements)

    builtin "truncate",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "truncate string at given length",
        args        = {
            "string": {String,Literal,PathLiteral},
            "cutoff": {Integer}
        },
        attrs       = {
            "with"      : ({String},"use given filler"),
            "preserve"  : ({Logical},"preserve word boundaries")
        },
        returns     = {String,Nothing},
        example     = """
            str: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse erat quam"

            truncate str 30
            ; => "Lorem ipsum dolor sit amet, con..."

            truncate.preserve str 30
            ; => "Lorem ipsum dolor sit amet,..."

            truncate.with:"---" str 30
            ; => "Lorem ipsum dolor sit amet, con---"

            truncate.preserve.with:"---" str 30
            ; => "Lorem ipsum dolor sit amet,---"
        """: 
            #=======================================================
            bindAttrs:
                filler(with): String = "..."

            dispatchWithLiteral:
                String(s):
                    on preserve: truncatePreserving(s, y.i, filler)
                    _:           truncate(s, y.i, filler)

    builtin "upper",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "convert given string to uppercase",
        args        = {
            "string": {String,Char,Literal,PathLiteral}
        },
        attrs       = NoAttrs,
        returns     = {String,Char,Nothing},
        example     = """
            print upper "hello World, 你好!"       ; "HELLO WORLD, 你好!"
            ..........
            str: "hello World, 你好!"
            upper 'str                           ; str: "HELLO WORLD, 你好!"
            ..........
            ch: 'a'
            upper ch    
            ; => 'A'                     
        """:
            #=======================================================
            dispatchWithLiteral:
                String(s): s.toUpper()
                Char(c):   c.toUpper()

    builtin "wordwrap",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "word wrap a given string",
        args        = {
            "string": {String,Literal,PathLiteral}
        },
        attrs       = {
            "at"    : ({Integer},"use given max line width (default: 80)")
        },
        returns     = {String},
        example     = """
            print wordwrap {Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eget mauris non justo mattis dignissim. Cras in lobortis felis, id ultricies ligula. Curabitur egestas tortor sed purus vestibulum auctor. Cras dui metus, euismod sit amet suscipit et, cursus ullamcorper felis. Integer elementum condimentum neque, et sagittis arcu rhoncus sed. In luctus congue eros, viverra dapibus mi rhoncus non. Pellentesque nisl diam, auctor quis sapien nec, suscipit aliquam velit. Nam ac nisi justo.}
            ; Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eget mauris non
            ; justo mattis dignissim. Cras in lobortis felis, id ultricies ligula. Curabitur
            ; egestas tortor sed purus vestibulum auctor. Cras dui metus, euismod sit amet
            ; suscipit et, cursus ullamcorper felis. Integer elementum condimentum neque, et
            ; sagittis arcu rhoncus sed. In luctus congue eros, viverra dapibus mi rhoncus
            ; non. Pellentesque nisl diam, auctor quis sapien nec, suscipit aliquam velit. Nam
            ; ac nisi justo.
            ..........
            print wordwrap.at: 10 "one two three four five six seven eight nine ten"
            ; one two
            ; three four
            ; five six
            ; seven 
            ; eight nine
            ; ten
        """:
            #=======================================================
            bindAttrs:
                cutoff(at): Integer = 80

            dispatchWithLiteral:
                String(s): wrapWords(s, maxLineWidth=cutoff)

    #----------------------------
    # Predicates
    #----------------------------

    builtin "ascii?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given character/string is in ASCII",
        args        = {
            "string": {String,Char}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            ascii? 'd'              ; true
            ..........
            ascii? '😀'             ; false

            ascii? "hello world"    ; true
            ascii? "Hællø wœrld"    ; false
            ascii? "Γειά!"          ; false
        """:
            #=======================================================
            dispatch:
                Char(c): push(newLogical(ord(c) < 128))
                String(s):
                    var allOK = true
                    for ch in runes(s):
                        if ord(ch) >= 128:
                            allOK = false
                            push(VFALSE)
                            break
                    if allOK: push(VTRUE)

    builtin "lower?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given string is lowercase",
        args        = {
            "string": {String,Char}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            lower? "ñ"               ; => true
            lower? "X"               ; => false
            lower? "Hello World"     ; => false
            lower? "hello"           ; => true
            ..........
            lower? 'a'               ; => true
            lower? 'A'               ; => false
        """:
            #=======================================================
            dispatch:
                Char(c): push(newLogical(c.isLower()))
                String(s):
                    var broken = false
                    for ch in runes(s):
                        if not ch.isLower():
                            push(VFALSE)
                            broken = true
                            break
                    if not broken: push(VTRUE)

    when not defined(WEB):

        # TODO(Strings\match?) should work for Web builds as well
        #  labels: library, web, bug
        builtin "match?",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "check if string matches given regular expression",
            args        = {
                "string": {String},
                "regex" : {Regex, String}
            },
            attrs       = {
                "in"        : ({Range},"get matches within given range")
            },
            returns     = {Logical},
            example     = """
            match? "hello" {/l/}            ; => true
            match? "hello" {/x/}            ; => false

            match? "hello" "l"              ; => true
            ..........
            match?.in:0..1 "hello" {/l/}        ; => false
            match?.in:2..4 "hello" {/l/}        ; => true
            """:
                #=======================================================
                let rgx : VRegex =
                    if yKind==Regex: y.rx
                    else: newRegex(y.s).rx

                var iFrom = 0
                var iTo = int.high

                if checkAttr("in"):
                    iFrom = aIn.rng.start
                    if iFrom < 0:
                        iFrom = 0

                    iTo = aIn.rng.stop
                    if iTo >= x.s.len:
                        iTo = x.s.len-1

                var matched = false
                for m in x.s.findIter(rgx, iFrom, iTo):
                    matched = true
                    break

                push newLogical(matched)

    builtin "numeric?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given string is numeric",
        args        = {
            "string": {String,Char}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            numeric? "hello"            ; => false
            numeric? "3.14"             ; => true
            numeric? "18966"            ; => true
            numeric? "3:5"              ; => true
            numeric? "0xdeadbeef"       ; => true
            numeric? "123xxy"           ; => false
        """:
            #=======================================================
            var res: Value
            dispatch:
                String(s): res = doParse(s.strip(leading=true, trailing=false, {'-'}), isFile=false)
                Char(c):   res = doParse($(c), isFile=false)

            push(newLogical(res.a.len==1 and res.a[0].kind in {Integer,Floating,Rational}))

    builtin "prefix?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if string starts with given prefix",
        args        = {
            "string": {String},
            "prefix": {String, Regex, Char}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            prefix? "hello" "he"          ; => true
            prefix? "boom" "he"           ; => false
            ..........
            prefix? "hello" {/\w+/}       ; => true
            prefix? "world" {/\d+/}       ; => false
            ..........
            prefix? "hello" 'h'           ; => true
        """:
            #=======================================================
            dispatch:
                (String(s), String(t)): push(newLogical(s.startsWith(t)))
                (String(s), Regex(r)):  push(newLogical(s.startsWith(r)))
                (String(s), Char(ch)):  push(newLogical(s.len > 0 and s.runeAtPos(0) == ch))

    builtin "suffix?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if string ends with given suffix",
        args        = {
            "string": {String},
            "suffix": {String, Regex, Char}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            suffix? "hello" "lo"          ; => true
            suffix? "boom" "lo"           ; => false
            ..........
            suffix? "hello" {/\w/}        ; => true
            suffix? "world" {/\d/}        ; => false
            ..........
            suffix? "hello" 'o'           ; => true
            suffix? "world" 'o'           ; => false
        """:
            #=======================================================
            dispatch:
                (String(s), String(t)): push(newLogical(s.endsWith(t)))
                (String(s), Regex(r)):  push(newLogical(s.endsWith(r)))
                (String(s), Char(ch)):
                    let slen = s.runeLen()
                    push(newLogical(slen > 0 and s.runeAtPos(slen-1) == ch))

    builtin "upper?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given string is uppercase",
        args        = {
            "string": {String,Char}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            upper? "Ñ"               ; => true
            upper? "x"               ; => false
            upper? "Hello World"     ; => false
            upper? "HELLO"           ; => true
            ..........
            upper? 'A'               ; => true
            upper? 'a'               ; => false
        """:
            #=======================================================
            dispatch:
                Char(c): push(newLogical(c.isUpper()))
                String(s):
                    var broken = false
                    for ch in runes(s):
                        if not ch.isUpper():
                            push(VFALSE)
                            broken = true
                            break
                    if not broken: push(VTRUE)

    builtin "whitespace?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given string consists only of whitespace",
        args        = {
            "string": {String,Char}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            whitespace? "hello"           ; => false
            whitespace? " "               ; => true
            whitespace? "\n \n"           ; => true
            whitespace? ""                ; => false
            ..........
            whitespace? ' '               ; => true
            whitespace? '\n'              ; => true
            whitespace? 'a'               ; => false
        """:
            #=======================================================
            dispatch:
                Char(c):   push(newLogical(c.isWhitespace()))
                String(s): push(newLogical(s.isWhitespace()))
