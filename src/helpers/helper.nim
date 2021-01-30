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

import sequtils, sets, strformat, strutils, sugar, tables

import vm/globals, vm/value
import utils

# proc printHelp*() {.inline.} =
#     var tbl = initTable[string,string]()

#     for spec in OpSpecs:
#         if spec.name!="":
#             var args = ""
#             if spec.an!="":
#                 args &= spec.an
#             if spec.bn!="":
#                 args &= ", " & spec.bn
#             if spec.cn!="":
#                 args &= ", " & spec.cn

#             tbl[spec.name] = alignLeft("(" & args & ")",35) & spec.desc.replace("~"," ")

#     let sorted = toSeq(tbl.pairs).sorted

#     for pair in sorted:
#         echo fgBold & alignLeft(pair[0],20) & fgWhite & pair[1]

# proc getInfo*(op: OpSpec): Value {.inline.} =
#     var argArray: ValueArray = @[]
#     if op.args >= 1:
#         argArray.add(newDictionary({"name": newString(op.an), "type": newBlock(toSeq((op.a).items).map(proc(x:ValueKind):Value = newType(x)))}.toOrderedTable))

#         if op.args >= 2:
#             argArray.add(newDictionary({"name": newString(op.bn), "type": newBlock(toSeq((op.b).items).map(proc(x:ValueKind):Value = newType(x)))}.toOrderedTable))

#             if op.args >= 3:
#                 argArray.add(newDictionary({"name": newString(op.cn), "type": newBlock(toSeq((op.c).items).map(proc(x:ValueKind):Value = newType(x)))}.toOrderedTable))


#     var ret: Value = newBlock(toSeq((op.ret).items).map(proc(x:ValueKind):Value = newType(x)))         

#     var attrArray: ValueArray = @[]
#     if op.attrs!="":
#         var parts = op.attrs.split("~")
#         for part in parts:
#             var subparts = part.split("->")
#             var descr = subparts[1].strip
#             var subsubparts = subparts[0].split()
#             var name = subsubparts[0]
#             var params: ValueArray = @[]
            
#             for subsub in subsubparts:
#                 if subsub != name:
#                     if subsub.strip!="":
#                         params.add(newType(subsub.strip.replace(":")))

#             attrArray.add(newDictionary({
#                     "name": newString(name.strip.replace(".")),
#                     "action": newString(descr.strip),
#                     "parameters": newBlock(params)
#                 }.toOrderedTable))
#         discard

#     let clearName = op.name.replace("*","")
#     result = newDictionary({
#                     "name"          : newString(clearName),
#                     "description"   : newString(op.desc.replace("~"," ")),
#                     "alias"         : newString(op.alias),
#                     "arguments"     : newBlock(argArray),
#                     "attributes"    : newBlock(attrArray),
#                     "return"        : ret
#                 }.toOrderedTable)

# proc printInfo*(op: OpSpec) {.inline.} =

#     proc countSubstr(s, sub: string): int =
#         var i = 0
#         while true:
#             i = s.find(sub, i)
#             if i < 0:
#                 break
#             i += sub.len # i += 1 for overlapping substrings
#             inc result

#     var params = ""

#     let maxLen = @[op.an.len, op.bn.len, op.cn.len].max() + 1

#     if op.args >= 1:
#         params &= alignLeft(op.an,maxLen) & fgGray & " " & toSeq((op.a).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ") & " " & fgWhite
#     if op.args >= 2:
#         params &= "\n|" & ' '.repeat(18+op.name.len) & alignLeft(op.bn,maxLen) & fgGray & " " & toSeq((op.b).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ") & " " & fgWhite
#     if op.args >= 3:
#         params &= "\n|" & ' '.repeat(18+op.name.len) & alignLeft(op.cn,maxLen) & fgGray & " " & toSeq((op.c).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ") & "" & fgWhite

#     var ret = toSeq((op.ret).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
#     var formattedDesc = op.desc.replace("~","\n|                 ")

#     echo fmt("|------------------------------------------------------------------")
#     echo fmt("|    {fgMagenta}{align(op.name,11)}{fgWhite}  {formattedDesc}")
#     if op.alias!="":
#         echo fmt("|          {fgWhite}alias{fgWhite}  {op.alias}")
#     # echo fmt("|")
#     # echo fmt("|                 {formattedDesc}")
#     echo fmt("|------------------------------------------------------------------")
#     let clearName = op.name.replace("*","")
#     echo fmt("|          {fgGreen}usage{fgWhite}  {fgBold}{clearName}{fgWhite} {params}")

#     if op.attrs!="":
#         echo "|"
#         var attrLines = op.attrs.replacef(re":(\w+)", fgGray & ":$1" & fgWhite)
#                             .replacef(re"\.(\w+)", fgBold & ".$1" & fgWhite)
#                             .split("~")
#         var maxattr = attrLines.map(proc (x:string):int = (x.split("->"))[0].len ).max()
#         var maxprop = attrLines.map(proc (x:string):int = (x.split("->"))[0].countSubstr(":") ).max()
#         #maxattr = attrLines.map(proc (x:string):int = (echo x.split("->"); echo (x.split("->"))[0].len; x.split("->"))[0].len ).max()
#         attrLines = attrLines.map(proc (x:string):string = 
#             alignLeft( (x.split("->"))[0], maxattr-((maxprop-(x.split("->"))[0].countSubstr(":"))*11)) & "->" & (x.split("->"))[1]
#         )
#         #echo fmt("maxattr: {maxattr}")
#         var formattedAttrs = attrLines.join("\n|                 ")
                                     
#         echo fmt("|        {fgGreen}options{fgWhite}  {formattedAttrs}")

#     echo "|"
#     echo fmt("|        {fgGreen}returns{fgWhite}  {fgGray}{ret}{fgWhite}")
#     echo fmt("|------------------------------------------------------------------")

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
# Methods
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
    for k,v in pairs(aliases):
        if v.name.s==n:
            return $(newSymbol(k))
    return ""

proc printOneData(label: string, data: string, color: string = fgWhite, colorb: string = fgWhite) =
    echo fmt("{initialSep}{initialPadding}{color}{align(label,labelAlignment)}{fgWhite}  {colorb}{data}{fgWhite}")

proc printMultiData(label: string, data: seq[string], color: string = fgWhite, colorb: string = fgWhite) =
    printOneData(label, data[0], color, colorb)
    for item in data[1..^1]:
        printOneData("",item,fgWhite,colorb)

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
        result.add fmt("{fgBold}{n}{fgWhite} {args[0][0]} {fgGray}{getTypeString(args[0][1])}")
    else:
        result.add fmt("{fgBold}{n}{fgWhite} {fgGray}{getTypeString(args[0][1])}")

    for arg in args[1..^1]:
        result.add fmt("{spaceBefore} {arg[0]} {fgGray}{getTypeString(arg[1])}")

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
        result.add fmt("{fgBold}{n}{fgWhite} {fgGray}:nothing")
    else:
        result.add fmt("{fgBold}{n}{fgWhite} {args[0].s}")
        for arg in args[1..^1]:
            result.add fmt("{spaceBefore} {arg.s}")

proc getOptionsForBuiltin(v: Value): seq[string] =
    var attrs = toSeq(v.attrs.pairs)
    if attrs.len==1 and attrs[0][0]=="": return @[]

    var maxLen = 0
    for attr in attrs:
        let ts = getTypeString(attr[1][0])
        if ts!=":boolean":
            let len = fmt(".{attr[0]} {fgGray}{ts}").len
            if len>maxLen: maxLen = len
        else:
            let len = fmt(".{attr[0]}").len
            if len>maxLen: maxLen = len

    for attr in attrs:
        let ts = getTypeString(attr[1][0])
        var leftSide = ""
        if ts!=":boolean":
            leftSide = fmt("{fgCyan}.{attr[0]} {fgGray}{ts}")
        else:
            leftSide = fmt("{fgCyan}.{attr[0]}")
        
        result.add fmt("{alignLeft(leftSide,maxLen)} {fgWhite}-> {attr[1][1]}")


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
    printOneData(n,fmt("{typeStr}{fgGray}{address}"),fgMagenta,fgWhite)

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
            printMultiData("usage",getUsageForBuiltin(n,v),fgGreen)
            let opts = getOptionsForBuiltin(v)
            if opts.len>0:
                printEmptyLine()
                printMultiData("options",opts,fgGreen)
            
            printEmptyLine()
            printOneData("returns",getTypeString(v.returns),fgGreen,fgGray)
        else:
            printMultiData("usage",getUsageForUser(n,v),fgGreen)

        printLine()