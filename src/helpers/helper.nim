######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/datasource.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, sets, strformat
import strutils, tables

import helpers/colors as ColorsHelper

import vm/[globals, value]

#=======================================
# Constants
#=======================================

const
    lineChar       = "-"
    lineLength     = 80
    initialSep     = "|"
    initialPadding = "    "
    labelAlignment = 11

#=======================================
# Helpers
#=======================================

template printLine() =
    stdout.write initialSep
    var i=0
    while i<lineLength:
        stdout.write lineChar
        i += 1
    stdout.write "\n"
    stdout.flushFile()

proc printEmptyLine() = 
    echo "|"

proc getAlias(n: string): string = 
    for k,v in pairs(Aliases):
        if v.name.s==n:
            return $(newSymbol(k))
    return ""

proc printOneData(label: string, data: string, color: string = resetColor, colorb: string = resetColor) =
    echo fmt("{initialSep}{initialPadding}{color}{align(label,labelAlignment)}{resetColor}  {colorb}{data}{resetColor}")

proc printMultiData(label: string, data: seq[string], color: string = resetColor, colorb: string = resetColor) =
    printOneData(label, data[0], color, colorb)
    for item in data[1..^1]:
        printOneData("",item,resetColor,colorb)

proc getShortData(initial: string): seq[string] =
    result = @[initial]
    if result[0].len>50:
        let parts = result[0].splitWhitespace()
        let middle = (parts.len div 2)
        result = @[
            parts[0..middle].join(" "),
            parts[middle+1..^1].join(" ")
        ]

proc getTypeString(vs: ValueSpec):string =
    var specs: seq[string] = @[]

    for s in vs:
        specs.add(":" & ($(s)).toLowerAscii())

    return specs.join(" ")

proc getUsageForBuiltin(n: string, v: Value): seq[string] =
    let args = toSeq(v.args.pairs)
    result = @[]
    let lenBefore = n.len
    var spaceBefore = ""
    var j=0
    while j<lenBefore:
        spaceBefore &= " "
        j+=1

    if args[0][0]!="":
        result.add fmt("{bold()}{n}{resetColor} {args[0][0]} {fg(grayColor)}{getTypeString(args[0][1])}")
    else:
        result.add fmt("{bold()}{n}{resetColor} {fg(grayColor)}{getTypeString(args[0][1])}")

    for arg in args[1..^1]:
        result.add fmt("{spaceBefore} {arg[0]} {fg(grayColor)}{getTypeString(arg[1])}")

proc getUsageForUser(n: string, v: Value): seq[string] =
    let args = v.params.a
    result = @[]
    let lenBefore = n.len
    var spaceBefore = ""
    var j=0
    while j<lenBefore:
        spaceBefore &= " "
        j+=1

    if args.len==0:
        result.add fmt("{bold()}{n}{resetColor} {fg(grayColor)}:nothing")
    else:
        result.add fmt("{bold()}{n}{resetColor} {args[0].s}")
        for arg in args[1..^1]:
            result.add fmt("{spaceBefore} {arg.s}")

proc getOptionsForBuiltin(v: Value): seq[string] =
    var attrs = toSeq(v.attrs.pairs)
    if attrs.len==1 and attrs[0][0]=="": return @[]

    var maxLen = 0
    for attr in attrs:
        let ts = getTypeString(attr[1][0])
        if ts!=":boolean":
            let len = fmt("{fg(cyanColor)}.{attr[0]} {fg(grayColor)}{ts}").len
            if len>maxLen: maxLen = len
        else:
            let len = fmt("{fg(cyanColor)}.{attr[0]}").len
            if len>maxLen: maxLen = len

    for attr in attrs:
        let ts = getTypeString(attr[1][0])
        var leftSide = ""
        if ts!=":boolean":
            leftSide = fmt("{fg(cyanColor)}.{attr[0]} {fg(grayColor)}{ts}")
        else:
            leftSide = fmt("{fg(cyanColor)}.{attr[0]}")
        
        result.add fmt("{alignLeft(leftSide,maxLen)} {resetColor}-> {attr[1][1]}")

#=======================================
# Methods
#=======================================

proc printHelp*() =
    let sorted = toSeq(Syms.keys).sorted
    for key in sorted:
        let v = Syms[key]
        if v.kind==Function and v.fnKind==BuiltinFunction:
            var params = "(" & (toSeq(v.args.keys)).join(",") & ")"
            
            echo strutils.alignLeft(key,17) & strutils.alignLeft(params,30) & " -> " & v.fdesc

proc getInfo*(n: string, v: Value):ValueDict =
    result = initOrderedTable[string,Value]()

    result["name"] = newString(n)
    result["address"] = newString(fmt("{cast[ByteAddress](v):#X}"))
    result["type"] = newType(v.kind)

    if v.info!="":
        result["description"] = newString(v.info)

    if v.kind==Function:
        if v.fnKind==BuiltinFunction:
            result["module"] = newString(v.module)

            var args = initOrderedTable[string,Value]()
            if (toSeq(v.args.keys))[0]!="":
                for k,spec in v.args:
                    var specs:ValueArray = @[]
                    for s in spec:
                        specs.add(newType(s))

                    args[k] = newBlock(specs)
            result["args"] = newDictionary(args)

            var attrs = initOrderedTable[string,Value]()
            if (toSeq(v.attrs.keys))[0]!="":
                for k,dd in v.attrs:
                    let spec = dd[0]
                    let descr = dd[1]

                    var ss = initOrderedTable[string,Value]()

                    var specs:ValueArray = @[]
                    for s in spec:
                        specs.add(newType(s))

                    ss["types"] = newBlock(specs)
                    ss["description"] = newString(descr)

                    attrs[k] = newDictionary(ss)
            result["attrs"] = newDictionary(attrs)

            var returns:ValueArray = @[]
            for ret in v.returns:
                returns.add(newType(ret))
            result["returns"] = newBlock(returns)

            let alias = getAlias(n)
            if alias!="":
                result["alias"] = newString(alias)

            result["description"] = newString(v.fdesc)
            result["example"] = newString(v.example)

        else:
            result["args"] = v.params


proc printInfo*(n: string, v: Value) =
    # Get type + possible module (if it's a builtin)
    var typeStr = ":" & ($(v.kind)).toLowerAscii
    # if v.kind==Function and v.fnKind==BuiltinFunction:
    #     typeStr &= " /" & v.module.toLowerAscii()

    typeStr = alignLeft(typeStr,30)

    # Get address
    var address = align(fmt("{cast[ByteAddress](v):#X}"), 32)
    # if v.kind==Function and v.fnKind==BuiltinFunction:
    #     address = align(fmt("builtin\\{v.module.toLowerAscii()}"), 32)

    # Print header
    printLine()
    printOneData(n,fmt("{typeStr}{fg(grayColor)}{address}"),bold(magentaColor),resetColor)

    # Print alias if it exists
    let alias = getAlias(n)
    if alias!="":
        printOneData("alias",alias)

    # Print separator
    printLine()

    # If it's a function or builtin constant,
    # print its description/info
    if v.kind==Function and v.fnKind==BuiltinFunction:
        for d in getShortData(v.fdesc):
            printOneData("",d)
        printLine()
    elif v.info!="":
        for d in getShortData(v.info):
            printOneData("",d)
        printLine()
        echo v.info

    # If it's a function,
    # print more details
    if v.kind==Function:
        if v.fnKind==BuiltinFunction:
            printMultiData("usage",getUsageForBuiltin(n,v),bold(greenColor))
            let opts = getOptionsForBuiltin(v)
            if opts.len>0:
                printEmptyLine()
                printMultiData("options",opts,bold(greenColor))
            
            printEmptyLine()
            printOneData("returns",getTypeString(v.returns),bold(greenColor),fg(grayColor))
        else:
            printMultiData("usage",getUsageForUser(n,v),bold(greenColor))

        printLine()