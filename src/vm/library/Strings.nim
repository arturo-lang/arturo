######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Strings.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Capitalize*():untyped =
    # EXAMPLE:
    # print capitalize "hello World"  ____; "Hello World"
    #
    # str: "hello World"
    # capitalize 'str                 ____; str: "Hello World"

    require(opCapitalize)

    if x.kind==String: stack.push(newString(x.s.capitalize()))
    else: syms[x.s].s = syms[x.s].s.capitalize()

template Color*():untyped =
    # EXAMPLE:
    # print color.green "Hello!"            ____; Hello! (in green)
    # print color.red.bold "Some text"      ____; Some text (in red/bold)

    require(opColor)

    var pre: string = "\e[0;"
    let reset = "\e[0m"

    if (let aRgb = popAttr("rgb"); aRgb != VNULL):
        pre = "\e[38;5;" & $(aRgb.i)
    else:
        if (popAttr("bold") != VNULL):
            pre = "\e[1"
        elif (popAttr("underline") != VNULL):
            pre = "\e[4"

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

template HasPrefix*():untyped =
    # EXAMPLE:
    # prefix? "hello" "he"      ____; => true
    # prefix? "boom" "he"       ____; => false

    require(opHasPrefix) # PENDING unicode support

    if (popAttr("regex") != VNULL):
        stack.push(newBoolean(re.startsWith(x.s, re.re(y.s))))
    else:
        stack.push(newBoolean(x.s.startsWith(y.s)))

template HasSuffix*():untyped =
    # EXAMPLE:
    # suffix? "hello" "lo"      ____; => true
    # suffix? "boom" "lo"       ____; => false

    require(opHasSuffix) # PENDING unicode support

    if (popAttr("regex") != VNULL):
        stack.push(newBoolean(re.endsWith(x.s, re.re(y.s))))
    else:
        stack.push(newBoolean(x.s.endsWith(y.s)))

template IsLower*():untyped =
    # EXAMPLE:
    # lower? "ñ"           ____; => true
    # lower? "X"           ____; => false
    # lower? "Hello World" ____; => false
    # lower? "hello"       ____; => true

    require(opIsLower)

    var broken = false
    for c in runes(x.s):
        if not c.isLower():
            stack.push(VFALSE)
            broken = true
            break

    if not broken:
        stack.push(VTRUE)

template IsNumeric*():untyped =
    # EXAMPLE:
    # numeric? "hello"       ____; => false
    # numeric? "3.14"        ____; => true
    # numeric? "18966"       ____; => true
    # numeric? "123xxy"      ____; => false

    require(opIsNumeric) # PENDING unicode support

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

template IsUpper*():untyped =
    # EXAMPLE:
    # upper? "Ñ"           ____; => true
    # upper? "x"           ____; => false
    # upper? "Hello World" ____; => false
    # upper? "HELLO"       ____; => true

    require(opIsUpper)

    var broken = false
    for c in runes(x.s):
        if not c.isUpper():
            stack.push(VFALSE)
            broken = true
            break

    if not broken:
        stack.push(VTRUE)

template IsWhitespace*():untyped =
    # EXAMPLE:
    # whitespace? "hello"       ____; => false
    # whitespace? " "           ____; => true
    # whitespace? "\n \n"       ____; => true

    require(opIsWhitespace) # PENDING unicode support

    stack.push(newBoolean(x.s.isEmptyOrWhitespace()))

template Levenshtein*():untyped =
    # EXAMPLE:
    # print levenshtein "for" "fur"     ____; 1
    # print levenshtein "one" "one"     ____; 0

    require(opLevenshtein) # PENDING unicode support

    stack.push(newInteger(editDistance(x.s,y.s)))

template Lower*():untyped =
    # EXAMPLE:
    # print lower "hello World, 你好!"  ____; "hello world, 你好!"
    #
    # str: "hello World, 你好!"
    # lower 'str                       ____; str: "hello world, 你好!"

    require(opLower)

    if x.kind==String: stack.push(newString(x.s.toLower()))
    else: syms[x.s].s = syms[x.s].s.toLower()

template Match*():untyped =
    # EXAMPLE:
    # print match "hello" "hello"         ____; => ["hello"]
    # match "x: 123, y: 456" "[0-9]+"     ____; => [123 456]
    # match "this is a string" "[0-9]+"   ____; => []

    require(opMatch) # PENDING unicode support

    stack.push(newStringBlock(x.s.findAll(re.re(y.s))))
    
template Pad*():untyped =
    # EXAMPLE:
    # pad "good" 10             ____; => "      good"
    # pad.right "good" 10       ____; => "good      "
    # pad.center "good" 10      ____; => "   good   "
    #
    # a: "hello"
    # pad 'a 10        ____; a: "     hello"

    require(opPad)

    if (popAttr("right") != VNULL):
        if x.kind==String: stack.push(newString(unicode.alignLeft(x.s, y.i)))
        else: syms[x.s].s = unicode.alignLeft(syms[x.s].s, y.i)
    elif (popAttr("center") != VNULL): # PENDING unicode support
        if x.kind==String: stack.push(newString(center(x.s, y.i)))
        else: syms[x.s].s = center(syms[x.s].s, y.i)
    else:
        if x.kind==String: stack.push(newString(unicode.align(x.s, y.i)))
        else: syms[x.s].s = unicode.align(syms[x.s].s, y.i)


template Prefix*():untyped =
    # EXAMPLE:
    # prefix "ello" "h"              ____; => "hello"
    #
    # str: "ello"
    # prefix 'str                    ____; str: "hello"

    require(opPrefix) # PENDING unicode support

    if x.kind==String: stack.push(newString(y.s & x.s))
    else: syms[x.s] = newString(y.s & syms[x.s].s)

template Render*():untyped =
    # EXAMPLE:
    # x: 2
    # greeting: "hello"
    # print ~"|greeting|, your number is |x|"   ____; hello, your number is 2
    #
    # data: #[
    # ____name: "John"
    # ____age: 34
    #]
    #
    # print render.with: data 
    # ____"Hello, your name is |name| and you are |age| years old"
    #
    # ; Hello, your name is John and you are 34 years old

    require(opRender) # PENDING unicode support

    if (let aWith = popAttr("with"); aWith != VNULL):
        if x.kind==String:
            stack.push(newString(x.s.replace(nre.re"\|([^\|]+)\|",
                proc (match: RegexMatch): string =
                    var args: ValueArray = (toSeq(keys(aWith.d))).map((x) => newString(x))

                    for v in ((toSeq(values(aWith.d))).reversed):
                        stack.push(v)
                    discard execBlock(doParse(match.captures[0], isFile=false), useArgs=true, args=args)
                    $(stack.pop())
            )))
        elif x.kind==Literal:
            syms[x.s].s = syms[x.s].s.replace(nre.re"\|([^\|]+)\|",
                proc (match: RegexMatch): string =
                    var args: ValueArray = (toSeq(keys(aWith.d))).map((x) => newString(x))

                    for v in ((toSeq(values(aWith.d))).reversed):
                        stack.push(v)
                    discard execBlock(doParse(match.captures[0], isFile=false), useArgs=true, args=args)
                    $(stack.pop())
            )

        # var mr: seq[(re.Regex,string)] = @[]
        #
        # for k,v in pairs(attrs["with"].d):
        #     mr.add((re.re("\\|" & k & "\\|"),$(v)))
        # 
        # if x.kind==String:
        #     stack.push(newString(re.multireplace(x.s,mr)))
        # elif x.kind==Literal:
        #     syms[x.s].s = re.multireplace(x.s,mr)

    else:
        if x.kind==String:
            stack.push(newString(x.s.replace(nre.re"\|([^\|]+)\|",
                proc (match: RegexMatch): string =
                    discard execBlock(doParse(match.captures[0], isFile=false))
                    $(stack.pop())
            )))
        elif x.kind==Literal:
            syms[x.s].s = syms[x.s].s.replace(nre.re"\|([^\|]+)\|",
                proc (match: RegexMatch): string =
                    discard execBlock(doParse(match.captures[0], isFile=false))
                    $(stack.pop())
            )

template Replace*():untyped =
    # EXAMPLE:
    # replace "hello" "l" "x"       ____; => "hexxo"
    #
    # str: "hello"
    # replace 'str "l" "x"          ____; str: "hexxo"

    require(opReplace) # PENDING unicode support

    if (popAttr("regex") != VNULL):
        if x.kind==String: stack.push(newString(x.s.replace(re.re(y.s), z.s)))
        else: syms[x.s].s = syms[x.s].s.replace(re.re(y.s), z.s)
    else:
        if x.kind==String: stack.push(newString(x.s.replace(y.s, z.s)))
        else: syms[x.s].s = syms[x.s].s.replace(y.s, z.s)

template Strip*():untyped =
    # EXAMPLE:
    # strip "  this is a string "    ____; => "this is a string"
    #
    # str: "  some string  "
    # strip 'str                     ____; str: "some string"

    require(opStrip)

    if x.kind==String: stack.push(newString(strutils.strip(x.s)))
    else: syms[x.s].s = strutils.strip(syms[x.s].s) 

template Suffix*():untyped =
    # EXAMPLE:
    # suffix "hell" "o"              ____; => "hello"
    #
    # str: "hell"
    # suffix 'str                    ____; str: "hello"

    require(opSuffix) # PENDING unicode support

    if x.kind==String: stack.push(newString(x.s & y.s))
    else: syms[x.s] = newString(syms[x.s].s & y.s)

template Upper*():untyped =
    # EXAMPLE:
    # print upper "hello World, 你好!"   ____; "HELLO WORLD, 你好!"
    #
    # str: "hello World, 你好!"
    # upper 'str                       ____; str: "HELLO WORLD, 你好!"

    require(opUpper)

    if x.kind==String: stack.push(newString(x.s.toUpper()))
    else: syms[x.s].s = syms[x.s].s.toUpper()
