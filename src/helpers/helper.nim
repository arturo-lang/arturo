######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/datasource.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, sets, strformat
import strutils, tables

import helpers/terminal

import vm/values/[printable, value]

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

proc getAlias(n: string, aliases: SymbolDict): (string,PrecedenceKind) = 
    for k,v in pairs(aliases):
        if v.name.s==n:
            return ($(newSymbol(k)), v.precedence)
    return ("", PrefixPrecedence)

proc printOneData(label: string, data: string, color: string = resetColor, colorb: string = resetColor) =
    echo fmt("{initialSep}{initialPadding}{color}{align(label,labelAlignment)}{resetColor}  {colorb}{data}{resetColor}")

proc printMultiData(label: string, data: seq[string], color: string = resetColor, colorb: string = resetColor) =
    printOneData(label, data[0], color, colorb)
    for item in data[1..^1]:
        printOneData("",item,resetColor,colorb)

func getShortData(initial: string): seq[string] =
    result = @[initial]
    if result[0].len>50:
        let parts = result[0].splitWhitespace()
        let middle = (parts.len div 2)
        result = @[
            parts[0..middle].join(" "),
            parts[middle+1..^1].join(" ")
        ]

func getTypeString(vs: ValueSpec):string =
    var specs: seq[string] = @[]

    if vs == {}:
        return ":nothing"

    for s in vs:
        specs.add(":" & ($(s)).toLowerAscii())

    return specs.join(" ")

proc getUsageForFunction(n: string, v: Value): seq[string] =
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

proc getOptionsForFunction(v: Value): seq[string] =
    var attrs = toSeq(v.attrs.pairs)
    if attrs.len==1 and attrs[0][0]=="": return @[]

    var maxLen = 0
    for attr in attrs:
        let ts = getTypeString(attr[1][0])
        if ts!=":logical":
            let len = fmt(".{attr[0]} {ts}").len
            if len>maxLen: maxLen = len
        else:
            let len = fmt(".{attr[0]}").len
            if len>maxLen: maxLen = len

    for attr in attrs:
        let ts = getTypeString(attr[1][0])
        var leftSide = ""
        var myLen = maxLen
        if ts!=":logical":
            leftSide = fmt("{fg(cyanColor)}.{attr[0]} {fg(grayColor)}{ts}")
            myLen += len(fmt("{fg(cyanColor)}{fg(grayColor)}"))
        else:
            leftSide = fmt("{fg(cyanColor)}.{attr[0]}")
            myLen += len(fmt("{fg(cyanColor)}"))
        
        result.add fmt("{alignLeft(leftSide,myLen)} {resetColor}-> {attr[1][1]}")

#=======================================
# Methods
#=======================================

proc printHelp*(syms: ValueDict) =
    let sorted = toSeq(syms.keys).sorted
    for key in sorted:
        let v = syms[key]
        if v.kind==Function and v.fnKind==BuiltinFunction:
            var params = "(" & (toSeq(v.args.keys)).join(",") & ")"
            
            echo strutils.alignLeft(key,17) & strutils.alignLeft(params,30) & " -> " & v.info

proc getInfo*(n: string, v: Value, aliases: SymbolDict):ValueDict =
    result = initOrderedTable[string,Value]()

    result["name"] = newString(n)
    result["address"] = newString(fmt("{cast[ByteAddress](v):#X}"))
    result["type"] = newType(v.kind)

    if v.info!="":
        var desc = v.info
        if desc.contains("]"):
            let parts = desc.split("]")
            desc = parts[1].strip()
            let modl = parts[0].strip().strip(chars={'['})
            result["module"] = newString(modl)

        result["description"] = newString(desc)

    if v.kind==Function:
        var args = initOrderedTable[string,Value]()
        if v.args.len > 0 and (toSeq(v.args.keys))[0]!="":
            for k,spec in v.args:
                var specs:ValueArray = @[]
                for s in spec:
                    specs.add(newType(s))

                args[k] = newBlock(specs)
        result["args"] = newDictionary(args)

        var attrs = initOrderedTable[string,Value]()
        if v.attrs.len > 0 and (toSeq(v.attrs.keys))[0]!="":
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
        if v.returns.len > 0:
            for ret in v.returns:
                returns.add(newType(ret))
        else:
            returns = @[newType(Nothing)]

        result["returns"] = newBlock(returns)

        let alias = getAlias(n, aliases)
        if alias[0]!="":
            result["alias"] = newString(alias[0])
            result["infix?"] = newLogical(alias[1]==InfixPrecedence)

        result["description"] = newString(v.info)
        result["example"] = newString(v.example)

proc printInfo*(n: string, v: Value, aliases: SymbolDict) =
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
    let alias = getAlias(n, aliases)
    if alias[0]!="":
        printOneData("alias",alias[0])

    # Print separator
    printLine()

    # If it's a function or builtin constant,
    # print its description/info
    if v.info!="":
        var desc: string = v.info
        if desc.contains("]"):
            desc = desc.split("]")[1].strip()
        
        for d in getShortData(desc):
            printOneData("",d)
        printLine()

    # If it's a function,
    # print more details
    if v.kind==Function:
        printMultiData("usage", getUsageForFunction(n,v), bold(greenColor))
        let opts = getOptionsForFunction(v)
        if opts.len>0:
            printEmptyLine()
            printMultiData("options",opts,bold(greenColor))
            
        printEmptyLine()

        printOneData("returns",getTypeString(v.returns),bold(greenColor),fg(grayColor))
        printLine()