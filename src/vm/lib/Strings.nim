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
import utils

#=======================================
# Methods
#=======================================

template Upper*():untyped =
    require(opUpper)

    if x.kind==String: stack.push(newString(x.s.toUpper()))
    else: syms[x.s].s = syms[x.s].s.toUpper()

template IsUpper*():untyped =
    require(opIsUpper)

    var broken = false
    for c in runes(x.s):
        if not c.isUpper():
            stack.push(VFALSE)
            broken = true
            break

    if not broken:
        stack.push(VTRUE)

template Lower*():untyped =
    require(opLower)

    if x.kind==String: stack.push(newString(x.s.toLower()))
    else: syms[x.s].s = syms[x.s].s.toLower()

template IsLower*():untyped =
    require(opIsLower)

    var broken = false
    for c in runes(x.s):
        if not c.isLower():
            stack.push(VFALSE)
            broken = true
            break

    if not broken:
        stack.push(VTRUE)

template Capitalize*():untyped =
    require(opCapitalize)

    if x.kind==String: stack.push(newString(x.s.capitalize()))
    else: syms[x.s].s = syms[x.s].s.capitalize()

template Pad*():untyped =
    require(opPad)

    if (popAttr("right") != VNULL):
        if x.kind==String: stack.push(newString(unicode.alignLeft(x.s, y.i)))
        else: syms[x.s].s = unicode.alignLeft(syms[x.s].s, y.i)
    elif (popAttr("center") != VNULL):
        if x.kind==String: stack.push(newString(center(x.s, y.i)))
        else: syms[x.s].s = center(syms[x.s].s, y.i)
    else:
        if x.kind==String: stack.push(newString(unicode.align(x.s, y.i)))
        else: syms[x.s].s = unicode.align(syms[x.s].s, y.i)


template Replace*():untyped =
    require(opReplace)

    if (popAttr("regex") != VNULL):
        if x.kind==String: stack.push(newString(x.s.replace(re.re(y.s), z.s)))
        else: syms[x.s].s = syms[x.s].s.replace(re.re(y.s), z.s)
    else:
        if x.kind==String: stack.push(newString(x.s.replace(y.s, z.s)))
        else: syms[x.s].s = syms[x.s].s.replace(y.s, z.s)

template Strip*():untyped =
    require(opStrip)

    if x.kind==String: stack.push(newString(strutils.strip(x.s)))
    else: syms[x.s].s = strutils.strip(syms[x.s].s) 

template Prefix*():untyped =
    require(opPrefix)

    if x.kind==String: stack.push(newString(y.s & x.s))
    else: syms[x.s] = newString(y.s & syms[x.s].s)

template HasPrefix*():untyped =
    require(opHasPrefix)

    if (popAttr("regex") != VNULL):
        stack.push(newBoolean(re.startsWith(x.s, re.re(y.s))))
    else:
        stack.push(newBoolean(x.s.startsWith(y.s)))

template Suffix*():untyped =
    require(opSuffix)

    if x.kind==String: stack.push(newString(x.s & y.s))
    else: syms[x.s] = newString(syms[x.s].s & y.s)

template HasSuffix*():untyped =
    require(opHasSuffix)

    if (popAttr("regex") != VNULL):
        stack.push(newBoolean(re.endsWith(x.s, re.re(y.s))))
    else:
        stack.push(newBoolean(x.s.endsWith(y.s)))

template Levenshtein*():untyped =
    require(opLevenshtein)

    stack.push(newInteger(editDistance(x.s,y.s)))

template Color*():untyped =
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

template IsWhitespace*():untyped =
    require(opIsWhitespace)

    stack.push(newBoolean(x.s.isEmptyOrWhitespace()))

template IsNumeric*():untyped =
    require(opIsNumeric)

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

template Render*():untyped =
    require(opRender)

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

template Match*():untyped =
    require(opMatch)

    stack.push(newStringBlock(x.s.findAll(re.re(y.s))))
