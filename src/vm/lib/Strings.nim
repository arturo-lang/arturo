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

    if x.kind==String: stack.push(newString(x.s.toUpperAscii()))
    else: syms[x.s].s = syms[x.s].s.toUpperAscii()

template IsUpper*():untyped =
    require(opIsUpper)

    var broken = false
    for c in x.s:
        if not c.isUpperAscii():
            stack.push(VFALSE)
            broken = true
            break

    if not broken:
        stack.push(VTRUE)

template Lower*():untyped =
    require(opLower)

    if x.kind==String: stack.push(newString(x.s.toLowerAscii()))
    else: syms[x.s].s = syms[x.s].s.toLowerAscii()

template IsLower*():untyped =
    require(opIsLower)

    var broken = false
    for c in x.s:
        if not c.isLowerAscii():
            stack.push(VFALSE)
            broken = true
            break

    if not broken:
        stack.push(VTRUE)

template Capitalize*():untyped =
    require(opCapitalize)

    if x.kind==String: stack.push(newString(x.s.capitalizeAscii()))
    else: syms[x.s].s = syms[x.s].s.capitalizeAscii()

template Pad*():untyped =
    require(opPad)

    let attrs = getAttrs()

    if attrs.hasKey("right"):
        if x.kind==String: stack.push(newString(alignLeft(x.s, y.i)))
        else: syms[x.s].s = alignLeft(syms[x.s].s, y.i)
    elif attrs.hasKey("center"):
        if x.kind==String: stack.push(newString(center(x.s, y.i)))
        else: syms[x.s].s = center(syms[x.s].s, y.i)
    else:
        if x.kind==String: stack.push(newString(align(x.s, y.i)))
        else: syms[x.s].s = align(syms[x.s].s, y.i)

template Replace*():untyped =
    require(opReplace)

    if x.kind==String: stack.push(newString(x.s.replace(y.s, z.s)))
    else: syms[x.s].s = syms[x.s].s.replace(y.s, z.s)

template Strip*():untyped =
    require(opStrip)

    if x.kind==String: stack.push(newString(x.s.strip()))
    else: syms[x.s].s = syms[x.s].s.strip() 

template Prefix*():untyped =
    require(opPrefix)

    if x.kind==String: stack.push(newString(y.s & x.s))
    else: syms[x.s] = newString(y.s & syms[x.s].s)

template HasPrefix*():untyped =
    require(opHasPrefix)

    stack.push(newBoolean(x.s.startsWith(y.s)))

template Suffix*():untyped =
    require(opSuffix)

    if x.kind==String: stack.push(newString(x.s & y.s))
    else: syms[x.s] = newString(syms[x.s].s & y.s)

template HasSuffix*():untyped =
    require(opHasSuffix)

    stack.push(newBoolean(x.s.endsWith(y.s)))

template Levenshtein*():untyped =
    require(opLevenshtein)

    stack.push(newInteger(editDistance(x.s,y.s)))

template Color*():untyped =
    require(opColor)

    let attrs = getAttrs()

    var pre: string = "\e[0;"
    let reset = "\e[0m"

    if attrs.hasKey("rgb"):
        pre = "\e[38;5;" & $(attrs["rgb"].i)
    else:
        if attrs.hasKey("bold"):
            pre = "\e[1"
        elif attrs.hasKey("underline"):
            pre = "\e[4"

        if attrs.hasKey("black"):
            pre &= ";30"
        elif attrs.hasKey("red"):
            pre &= ";31"
        elif attrs.hasKey("green"):
            pre &= ";32"
        elif attrs.hasKey("yellow"):
            pre &= ";33"
        elif attrs.hasKey("blue"):
            pre &= ";34"
        elif attrs.hasKey("magenta"):
            pre &= ";35"
        elif attrs.hasKey("cyan"):
            pre &= ";36"
        elif attrs.hasKey("white"):
            pre &= ";37"
        elif attrs.hasKey("gray"):
            pre &= ";90"
        else:
            pre &= ""

    pre &= "m"

    stack.push(newString(pre & x.s & reset))

template Render*():untyped =
    require(opRender)

    let attrs = getAttrs()

    if attrs.hasKey("with"):
        if x.kind==String:
            stack.push(newString(x.s.replace(nre.re"\|([^\|]+)\|",
                proc (match: RegexMatch): string =
                    var args: ValueArray = (toSeq(keys(attrs["with"].d))).map((x) => newString(x))

                    for v in ((toSeq(values(attrs["with"].d))).reversed):
                        stack.push(v)
                    discard execBlock(doParse(match.captures[0], isFile=false), useArgs=true, args=args)
                    $(stack.pop())
            )))
        elif x.kind==Literal:
            syms[x.s].s = syms[x.s].s.replace(nre.re"\|([^\|]+)\|",
                proc (match: RegexMatch): string =
                    var args: ValueArray = (toSeq(keys(attrs["with"].d))).map((x) => newString(x))

                    for v in ((toSeq(values(attrs["with"].d))).reversed):
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
