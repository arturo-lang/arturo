######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Strings.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, re, std/editdistance, os
import sequtils, strutils, sugar, unicode
import nre except toSeq

import helpers/colors as ColorsHelper

import vm/[common, exec, globals, parse, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Strings"

    builtin "capitalize",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "convert given string to capitalized",
        args        = {
            "string": {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            print capitalize "hello World"      ; "Hello World"
            
            str: "hello World"
            capitalize 'str                     ; str: "Hello World"
        """:
            ##########################################################
            if x.kind==String: stack.push(newString(x.s.capitalize()))
            else: Syms[x.s].s = Syms[x.s].s.capitalize()

    builtin "color",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get colored version of given string",
        args        = {
            "string": {String}
        },
        attrs       = {
            "rgb"       : ({Integer},"use specific RGB color"),
            "bold"      : ({Boolean},"bold font"),
            "black"     : ({Boolean},"black foreground color"),
            "red"       : ({Boolean},"red foreground color"),
            "green"     : ({Boolean},"green foreground color"),
            "yellow"    : ({Boolean},"yellow foreground color"),
            "blue"      : ({Boolean},"blue foreground color"),
            "magenta"   : ({Boolean},"magenta foreground color"),
            "cyan"      : ({Boolean},"cyan foreground color"),
            "white"     : ({Boolean},"white foreground color"),
            "gray"      : ({Boolean},"gray foreground color")
        },
        returns     = {String},
        example     = """
            print color.green "Hello!"                ; Hello! (in green)
            print color.red.bold "Some text"          ; Some text (in red/bold)
        """:
            ##########################################################
            var color = ""

            if (let aRgb = popAttr("rgb"); aRgb != VNULL):
                color = rgb($(aRgb.i))
            if (popAttr("black") != VNULL):
                color = blackColor
            elif (popAttr("red") != VNULL):
                color = redColor
            elif (popAttr("green") != VNULL):
                color = greenColor
            elif (popAttr("yellow") != VNULL):
                color = yellowColor
            elif (popAttr("blue") != VNULL):
                color = blueColor
            elif (popAttr("magenta") != VNULL):
                color = magentaColor
            elif (popAttr("cyan") != VNULL):
                color = cyanColor
            elif (popAttr("white") != VNULL):
                color = whiteColor
            elif (popAttr("gray") != VNULL):
                color = grayColor

            var finalColor = ""

            if (popAttr("bold") != VNULL):
                finalColor = bold(color)
            elif (popAttr("underline") != VNULL):
                finalColor = underline(color)
            else:
                finalColor = fg(color)

            stack.push(newString(finalColor & x.s & resetColor))

    builtin "join",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "join collection of strings into string",
        args        = {
            "collection"    : {Block,Literal}
        },
        attrs       = {
            "with"  : ({String},"use given separator"),
            "path"  : ({Boolean},"join as path components")
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
        """:
            ##########################################################
            if (popAttr("path") != VNULL):
                if x.kind==Literal:
                    Syms[x.s] = newString(joinPath(Syms[x.s].a.map(proc (v:Value):string = v.s)))
                else:
                    stack.push(newString(joinPath(x.a.map(proc (v:Value):string = v.s))))
            else:
                var sep = ""
                if (let aWith = popAttr("with"); aWith != VNULL):
                    sep = aWith.s

                if x.kind==Literal:
                    Syms[x.s] = newString(Syms[x.s].a.map(proc (v:Value):string = v.s).join(sep))
                else:
                    stack.push(newString(x.a.map(proc (v:Value):string = v.s).join(sep)))

    builtin "levenshtein",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate Levenshtein distance between given strings",
        args        = {
            "stringA"   : {String},
            "stringB"   : {String}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print levenshtein "for" "fur"         ; 1
            print levenshtein "one" "one"         ; 0
        """:
            stack.push(newInteger(editDistance(x.s,y.s)))

    builtin "lower",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "convert given string to lowercase",
        args        = {
            "string": {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            print lower "hello World, 你好!"      ; "hello world, 你好!"
            
            str: "hello World, 你好!"
            lower 'str                           ; str: "hello world, 你好!"
        """:
            ##########################################################
            if x.kind==String: stack.push(newString(x.s.toLower()))
            else: Syms[x.s].s = Syms[x.s].s.toLower()

    builtin "lower?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given string is lowercase",
        args        = {
            "string": {String}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            lower? "ñ"               ; => true
            lower? "X"               ; => false
            lower? "Hello World"     ; => false
            lower? "hello"           ; => true
        """:
            ##########################################################
            var broken = false
            for c in runes(x.s):
                if not c.isLower():
                    stack.push(VFALSE)
                    broken = true
                    break

            if not broken:
                stack.push(VTRUE)

    builtin "match",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get matches within string, using given regular expression",
        args        = {
            "string": {String},
            "regex" : {String}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            print match "hello" "hello"             ; => ["hello"]
            match "x: 123, y: 456" "[0-9]+"         ; => [123 456]
            match "this is a string" "[0-9]+"       ; => []
        """:
            ##########################################################
            stack.push(newStringBlock(x.s.findAll(re.re(y.s))))

    builtin "numeric?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given string is numeric",
        args        = {
            "string": {String}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            numeric? "hello"           ; => false
            numeric? "3.14"            ; => true
            numeric? "18966"           ; => true
            numeric? "123xxy"          ; => false
        """:
            ##########################################################
            var found = false
            var dotFound = false
            for ch in x.s:
                if ch=='.':
                    if dotFound:
                        found = true
                        stack.push(VFALSE)
                        break
                    else:
                        dotFound = true
                else:
                    if not ch.isDigit():
                        found = true
                        stack.push(VFALSE)
                        break

            if not found:
                stack.push(VTRUE)

    builtin "pad",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given string consists only of whitespace",
        args        = {
            "string"    : {String,Literal},
            "padding"   : {Integer}
        },
        attrs       = {
            "center"    : ({Boolean},"add padding to both sides"),
            "right"     : ({Boolean},"add right padding")
        },
        returns     = {String},
        example     = """
            pad "good" 10                 ; => "      good"
            pad.right "good" 10           ; => "good      "
            pad.center "good" 10          ; => "   good   "
            
            a: "hello"
            pad 'a 10            ; a: "     hello"
        """:
            ##########################################################
            if (popAttr("right") != VNULL):
                if x.kind==String: stack.push(newString(unicode.alignLeft(x.s, y.i)))
                else: Syms[x.s].s = unicode.alignLeft(Syms[x.s].s, y.i)
            elif (popAttr("center") != VNULL): # PENDING unicode support
                if x.kind==String: stack.push(newString(center(x.s, y.i)))
                else: Syms[x.s].s = center(Syms[x.s].s, y.i)
            else:
                if x.kind==String: stack.push(newString(unicode.align(x.s, y.i)))
                else: Syms[x.s].s = unicode.align(Syms[x.s].s, y.i)

    builtin "prefix",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "add given prefix to string",
        args        = {
            "string": {String,Literal},
            "prefix": {String}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            prefix "ello" "h"                  ; => "hello"
            
            str: "ello"
            prefix 'str                        ; str: "hello"
        """:
            ##########################################################
            if x.kind==String: stack.push(newString(y.s & x.s))
            else: Syms[x.s] = newString(y.s & Syms[x.s].s)

    builtin "prefix?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if string starts with given prefix",
        args        = {
            "string": {String},
            "prefix": {String}
        },
        attrs       = {
            "regex" : ({Boolean},"match against a regular expression")
        },
        returns     = {Boolean},
        example     = """
            prefix? "hello" "he"          ; => true
            prefix? "boom" "he"           ; => false
        """:
            ##########################################################
            if (popAttr("regex") != VNULL):
                stack.push(newBoolean(re.startsWith(x.s, re.re(y.s))))
            else:
                stack.push(newBoolean(x.s.startsWith(y.s)))

    # TODO fix .template implementation (more template-engine like)    
    builtin "render",
        alias       = tilde, 
        rule        = PrefixPrecedence,
        description = "render template with |string| interpolation",
        args        = {
            "template"  : {String}
        },
        attrs       = {
            "single"    : ({Boolean},"don't render recursively"),
            "with"      : ({Dictionary},"use given dictionary for reference"),
            "template"  : ({Boolean},"render as a template")
        },
        returns     = {String,Nothing},
        example     = """
            x: 2
            greeting: "hello"
            print ~"|greeting|, your number is |x|"       ; hello, your number is 2
            
            data: #[
                name: "John"
                age: 34
            ]
            
            print render.with: data 
                "Hello, your name is |name| and you are |age| years old"
            
            ; Hello, your name is John and you are 34 years old
        """:
            ##########################################################
            var rgx = nre.re"\|([^\|]+)\|"

            if (popAttr("template") != VNULL):
                rgx = nre.re"\<\|(.+)\|\>"

            if (let aWith = popAttr("with"); aWith != VNULL):
                if x.kind==String:
                    var res = newString(x.s)
                    while (contains(res.s, rgx)):
                        res = newString(x.s.replace(rgx,
                            proc (match: RegexMatch): string =
                                var args: ValueArray = (toSeq(keys(aWith.d))).map((x) => newString(x))

                                for v in ((toSeq(values(aWith.d))).reversed):
                                    stack.push(v)
                                discard execBlock(doParse(match.captures[0], isFile=false), args=args)
                                $(stack.pop())
                        ))
                    stack.push(res)
                elif x.kind==Literal:
                    while (contains(Syms[x.s].s, rgx)):
                        Syms[x.s].s = Syms[x.s].s.replace(rgx,
                            proc (match: RegexMatch): string =
                                var args: ValueArray = (toSeq(keys(aWith.d))).map((x) => newString(x))

                                for v in ((toSeq(values(aWith.d))).reversed):
                                    stack.push(v)
                                discard execBlock(doParse(match.captures[0], isFile=false), args=args)
                                $(stack.pop())
                        )

            else:
                if x.kind==String:
                    var res = newString(x.s)
                    if (popAttr("single") != VNULL):
                        res = newString(res.s.replace(rgx,
                                proc (match: RegexMatch): string =
                                    discard execBlock(doParse(match.captures[0], isFile=false))
                                    $(stack.pop())
                            ))
                    else:
                        while (contains(res.s, rgx)):
                            res = newString(res.s.replace(rgx,
                                proc (match: RegexMatch): string =
                                    discard execBlock(doParse(match.captures[0], isFile=false))
                                    $(stack.pop())
                            ))
                    stack.push(res)
                elif x.kind==Literal:
                    while (contains(Syms[x.s].s, rgx)):
                        Syms[x.s].s = Syms[x.s].s.replace(rgx,
                            proc (match: RegexMatch): string =
                                discard execBlock(doParse(match.captures[0], isFile=false))
                                $(stack.pop())
                        )

    builtin "replace",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "add given suffix to string",
        args        = {
            "string"        : {String,Literal},
            "match"         : {String},
            "replacement"   : {String}
        },
        attrs       = {
            "regex" : ({Boolean},"match against a regular expression")
        },
        returns     = {String,Nothing},
        example     = """
            replace "hello" "l" "x"           ; => "hexxo"
            
            str: "hello"
            replace 'str "l" "x"              ; str: "hexxo"
        """:
            ##########################################################
            if (popAttr("regex") != VNULL):
                if x.kind==String: stack.push(newString(x.s.replace(re.re(y.s), z.s)))
                else: Syms[x.s].s = Syms[x.s].s.replace(re.re(y.s), z.s)
            else:
                if x.kind==String: stack.push(newString(x.s.replace(y.s, z.s)))
                else: Syms[x.s].s = Syms[x.s].s.replace(y.s, z.s)

    builtin "strip",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "strip whitespace from given string",
        args        = {
            "string": {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            strip "  this is a string "        ; => "this is a string"
            
            str: "  some string  "
            strip 'str                         ; str: "some string"
        """:
            ##########################################################
            if x.kind==String: stack.push(newString(strutils.strip(x.s)))
            else: Syms[x.s].s = strutils.strip(Syms[x.s].s) 

    builtin "suffix",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "add given suffix to string",
        args        = {
            "string": {String,Literal},
            "suffix": {String}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            suffix "hell" "o"                  ; => "hello"
            
            str: "hell"
            suffix 'str                        ; str: "hello"
        """:
            ##########################################################
            if x.kind==String: stack.push(newString(x.s & y.s))
            else: Syms[x.s] = newString(Syms[x.s].s & y.s)

    builtin "suffix?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if string ends with given suffix",
        args        = {
            "string": {String},
            "suffix": {String}
        },
        attrs       = {
            "regex" : ({Boolean},"match against a regular expression")
        },
        returns     = {Boolean},
        example     = """
            suffix? "hello" "lo"          ; => true
            suffix? "boom" "lo"           ; => false
        """:
            ##########################################################
            if (popAttr("regex") != VNULL):
                stack.push(newBoolean(re.endsWith(x.s, re.re(y.s))))
            else:
                stack.push(newBoolean(x.s.endsWith(y.s)))

    builtin "upper",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "convert given string to uppercase",
        args        = {
            "string": {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            print upper "hello World, 你好!"       ; "HELLO WORLD, 你好!"
            
            str: "hello World, 你好!"
            upper 'str                           ; str: "HELLO WORLD, 你好!"
        """:
            ##########################################################
            if x.kind==String: stack.push(newString(x.s.toUpper()))
            else: Syms[x.s].s = Syms[x.s].s.toUpper()

    builtin "upper?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given string is uppercase",
        args        = {
            "string": {String}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            upper? "Ñ"               ; => true
            upper? "x"               ; => false
            upper? "Hello World"     ; => false
            upper? "HELLO"           ; => true
        """:
            ##########################################################
            var broken = false
            for c in runes(x.s):
                if not c.isUpper():
                    stack.push(VFALSE)
                    broken = true
                    break

            if not broken:
                stack.push(VTRUE)

    builtin "whitespace?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given string consists only of whitespace",
        args        = {
            "string": {String}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            whitespace? "hello"           ; => false
            whitespace? " "               ; => true
            whitespace? "\n \n"           ; => true
        """:
            ##########################################################
            stack.push(newBoolean(x.s.isEmptyOrWhitespace()))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)