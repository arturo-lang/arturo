######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Strings.nim
######################################################

#=======================================
# Methods
#=======================================

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
        print capitalize "hello World"  ____; "Hello World"
        
        str: "hello World"
        capitalize 'str                 ____; str: "Hello World"
    """:
        ##########################################################
        if x.kind==String: stack.push(newString(x.s.capitalize()))
        else: syms[x.s].s = syms[x.s].s.capitalize()

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
        print color.green "Hello!"            ____; Hello! (in green)
        print color.red.bold "Some text"      ____; Some text (in red/bold)
    """:
        ##########################################################
        var pre: string = "\e[0;"
        let reset = "\e[0m"

        if (popAttr("bold") != VNULL):
            pre = "\e[1"
        elif (popAttr("underline") != VNULL):
            pre = "\e[4"

        if (let aRgb = popAttr("rgb"); aRgb != VNULL):
            pre &= ";38;5;" & $(aRgb.i)
        if (popAttr("black") != VNULL):
            pre &= ";30"
        elif (popAttr("red") != VNULL):
            pre &= ";31"
        elif (popAttr("green") != VNULL):
            pre &= ";32"
        elif (popAttr("yellow") != VNULL):
            pre &= ";33"
        elif (popAttr("blue") != VNULL):
            pre &= ";34"
        elif (popAttr("magenta") != VNULL):
            pre &= ";35"
        elif (popAttr("cyan") != VNULL):
            pre &= ";36"
        elif (popAttr("white") != VNULL):
            pre &= ";37"
        elif (popAttr("gray") != VNULL):
            pre &= ";90"
        else:
            pre &= ""

        pre &= "m"

        stack.push(newString(pre & x.s & reset))

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
                syms[x.s] = newString(joinPath(syms[x.s].a.map(proc (v:Value):string = v.s)))
            else:
                stack.push(newString(joinPath(x.a.map(proc (v:Value):string = v.s))))
        else:
            var sep = ""
            if (let aWith = popAttr("with"); aWith != VNULL):
                sep = aWith.s

            if x.kind==Literal:
                syms[x.s] = newString(syms[x.s].a.map(proc (v:Value):string = v.s).join(sep))
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
        print levenshtein "for" "fur"     ____; 1
        print levenshtein "one" "one"     ____; 0
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
        print lower "hello World, 你好!"  ____; "hello world, 你好!"
        
        str: "hello World, 你好!"
        lower 'str                       ____; str: "hello world, 你好!"
    """:
        ##########################################################
        if x.kind==String: stack.push(newString(x.s.toLower()))
        else: syms[x.s].s = syms[x.s].s.toLower()

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
        lower? "ñ"           ____; => true
        lower? "X"           ____; => false
        lower? "Hello World" ____; => false
        lower? "hello"       ____; => true
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
        print match "hello" "hello"         ____; => ["hello"]
        match "x: 123, y: 456" "[0-9]+"     ____; => [123 456]
        match "this is a string" "[0-9]+"   ____; => []
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
        numeric? "hello"       ____; => false
        numeric? "3.14"        ____; => true
        numeric? "18966"       ____; => true
        numeric? "123xxy"      ____; => false
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
        pad "good" 10             ____; => "      good"
        pad.right "good" 10       ____; => "good      "
        pad.center "good" 10      ____; => "   good   "
        
        a: "hello"
        pad 'a 10        ____; a: "     hello"
    """:
        ##########################################################
        if (popAttr("right") != VNULL):
            if x.kind==String: stack.push(newString(unicode.alignLeft(x.s, y.i)))
            else: syms[x.s].s = unicode.alignLeft(syms[x.s].s, y.i)
        elif (popAttr("center") != VNULL): # PENDING unicode support
            if x.kind==String: stack.push(newString(center(x.s, y.i)))
            else: syms[x.s].s = center(syms[x.s].s, y.i)
        else:
            if x.kind==String: stack.push(newString(unicode.align(x.s, y.i)))
            else: syms[x.s].s = unicode.align(syms[x.s].s, y.i)

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
        prefix "ello" "h"              ____; => "hello"
        
        str: "ello"
        prefix 'str                    ____; str: "hello"
    """:
        ##########################################################
        if x.kind==String: stack.push(newString(y.s & x.s))
        else: syms[x.s] = newString(y.s & syms[x.s].s)

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
        prefix? "hello" "he"      ____; => true
        prefix? "boom" "he"       ____; => false
    """:
        ##########################################################
        if (popAttr("regex") != VNULL):
            stack.push(newBoolean(re.startsWith(x.s, re.re(y.s))))
        else:
            stack.push(newBoolean(x.s.startsWith(y.s)))

builtin "render",
    alias       = tilde, 
    rule        = PrefixPrecedence,
    description = "render template with |string| interpolation",
    args        = {
        "template"  : {String}
    },
    attrs       = {
        "single"    : ({Boolean},"don't render recursively"),
        "with"      : ({Dictionary},"use given dictionary for reference")
    },
    returns     = {String,Nothing},
    example     = """
        x: 2
        greeting: "hello"
        print ~"|greeting|, your number is |x|"   ____; hello, your number is 2
        
        data: #[
        ____name: "John"
        ____age: 34
        ]
        
        print render.with: data 
        ____"Hello, your name is |name| and you are |age| years old"
        
        ; Hello, your name is John and you are 34 years old
    """:
        ##########################################################
        if (let aWith = popAttr("with"); aWith != VNULL):
            if x.kind==String:
                var res = newString(x.s)
                while (contains(res.s, nre.re"\|([^\|]+)\|")):
                    res = newString(x.s.replace(nre.re"\|([^\|]+)\|",
                        proc (match: RegexMatch): string =
                            var args: ValueArray = (toSeq(keys(aWith.d))).map((x) => newString(x))

                            for v in ((toSeq(values(aWith.d))).reversed):
                                stack.push(v)
                            discard execBlock(doParse(match.captures[0], isFile=false), args=args)
                            $(stack.pop())
                    ))
                stack.push(res)
            elif x.kind==Literal:
                while (contains(syms[x.s].s, nre.re"\|([^\|]+)\|")):
                    syms[x.s].s = syms[x.s].s.replace(nre.re"\|([^\|]+)\|",
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
                    res = newString(res.s.replace(nre.re"\|([^\|]+)\|",
                            proc (match: RegexMatch): string =
                                discard execBlock(doParse(match.captures[0], isFile=false))
                                $(stack.pop())
                        ))
                else:
                    while (contains(res.s, nre.re"\|([^\|]+)\|")):
                        res = newString(res.s.replace(nre.re"\|([^\|]+)\|",
                            proc (match: RegexMatch): string =
                                discard execBlock(doParse(match.captures[0], isFile=false))
                                $(stack.pop())
                        ))
                stack.push(res)
            elif x.kind==Literal:
                while (contains(syms[x.s].s, nre.re"\|([^\|]+)\|")):
                    syms[x.s].s = syms[x.s].s.replace(nre.re"\|([^\|]+)\|",
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
        replace "hello" "l" "x"       ____; => "hexxo"
        
        str: "hello"
        replace 'str "l" "x"          ____; str: "hexxo"
    """:
        ##########################################################
        if (popAttr("regex") != VNULL):
            if x.kind==String: stack.push(newString(x.s.replace(re.re(y.s), z.s)))
            else: syms[x.s].s = syms[x.s].s.replace(re.re(y.s), z.s)
        else:
            if x.kind==String: stack.push(newString(x.s.replace(y.s, z.s)))
            else: syms[x.s].s = syms[x.s].s.replace(y.s, z.s)

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
        strip "  this is a string "    ____; => "this is a string"
        
        str: "  some string  "
        strip 'str                     ____; str: "some string"
    """:
        ##########################################################
        if x.kind==String: stack.push(newString(strutils.strip(x.s)))
        else: syms[x.s].s = strutils.strip(syms[x.s].s) 

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
        suffix "hell" "o"              ____; => "hello"
        
        str: "hell"
        suffix 'str                    ____; str: "hello"
    """:
        ##########################################################
        if x.kind==String: stack.push(newString(x.s & y.s))
        else: syms[x.s] = newString(syms[x.s].s & y.s)

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
        suffix? "hello" "lo"      ____; => true
        suffix? "boom" "lo"       ____; => false
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
        print upper "hello World, 你好!"   ____; "HELLO WORLD, 你好!"
        
        str: "hello World, 你好!"
        upper 'str                       ____; str: "HELLO WORLD, 你好!"
    """:
        ##########################################################
        if x.kind==String: stack.push(newString(x.s.toUpper()))
        else: syms[x.s].s = syms[x.s].s.toUpper()

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
        upper? "Ñ"           ____; => true
        upper? "x"           ____; => false
        upper? "Hello World" ____; => false
        upper? "HELLO"       ____; => true
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
        whitespace? "hello"       ____; => false
        whitespace? " "           ____; => true
        whitespace? "\n \n"       ____; => true
    """:
        ##########################################################
        stack.push(newBoolean(x.s.isEmptyOrWhitespace()))