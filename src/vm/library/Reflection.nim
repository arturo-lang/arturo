######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Reflection.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, re, sequtils, strformat, strutils, tables

import vm/bytecode, vm/stack, vm/value
import utils

#=======================================
# Helpers
#=======================================

proc printHelp*() {.inline.} =
    var tbl = initTable[string,string]()

    for spec in OpSpecs:
        if spec.name!="":
            var args = ""
            if spec.an!="":
                args &= spec.an
            if spec.bn!="":
                args &= ", " & spec.bn
            if spec.cn!="":
                args &= ", " & spec.cn

            tbl[spec.name] = alignLeft("(" & args & ")",35) & spec.desc.replace("~"," ")

    let sorted = toSeq(tbl.pairs).sorted

    for pair in sorted:
        echo fgBold & alignLeft(pair[0],20) & fgWhite & pair[1]

proc getInfo*(op: OpSpec): Value {.inline.} =
    var argArray: ValueArray = @[]
    if op.args >= 1:
        argArray.add(newDictionary({"name": newString(op.an), "type": newBlock(toSeq((op.a).items).map(proc(x:ValueKind):Value = newType(x)))}.toOrderedTable))

        if op.args >= 2:
            argArray.add(newDictionary({"name": newString(op.bn), "type": newBlock(toSeq((op.b).items).map(proc(x:ValueKind):Value = newType(x)))}.toOrderedTable))

            if op.args >= 3:
                argArray.add(newDictionary({"name": newString(op.cn), "type": newBlock(toSeq((op.c).items).map(proc(x:ValueKind):Value = newType(x)))}.toOrderedTable))


    var ret: Value = newBlock(toSeq((op.ret).items).map(proc(x:ValueKind):Value = newType(x)))         

    var attrArray: ValueArray = @[]
    if op.attrs!="":
        var parts = op.attrs.split("~")
        for part in parts:
            var subparts = part.split("->")
            var descr = subparts[1].strip
            var subsubparts = subparts[0].split()
            var name = subsubparts[0]
            var params: ValueArray = @[]
            
            for subsub in subsubparts:
                if subsub != name:
                    if subsub.strip!="":
                        params.add(newType(subsub.strip.replace(":")))

            attrArray.add(newDictionary({
                    "name": newString(name.strip.replace(".")),
                    "action": newString(descr.strip),
                    "parameters": newBlock(params)
                }.toOrderedTable))
        discard

    result = newDictionary({
                    "name"          : newString(op.name),
                    "description"   : newString(op.desc.replace("~"," ")),
                    "alias"         : newString(op.alias),
                    "arguments"     : newBlock(argArray),
                    "attributes"    : newBlock(attrArray),
                    "return"        : ret
                }.toOrderedTable)

proc printInfo*(op: OpSpec) {.inline.} =

    proc countSubstr(s, sub: string): int =
        var i = 0
        while true:
            i = s.find(sub, i)
            if i < 0:
                break
            i += sub.len # i += 1 for overlapping substrings
            inc result

    var params = ""

    let maxLen = @[op.an.len, op.bn.len, op.cn.len].max() + 1

    if op.args >= 1:
        params &= alignLeft(op.an,maxLen) & fgGray & " " & toSeq((op.a).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ") & " " & fgWhite
    if op.args >= 2:
        params &= "\n|" & ' '.repeat(18+op.name.len) & alignLeft(op.bn,maxLen) & fgGray & " " & toSeq((op.b).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ") & " " & fgWhite
    if op.args >= 3:
        params &= "\n|" & ' '.repeat(18+op.name.len) & alignLeft(op.cn,maxLen) & fgGray & " " & toSeq((op.c).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ") & "" & fgWhite

    var ret = toSeq((op.ret).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
    var formattedDesc = op.desc.replace("~","\n|                 ")

    echo fmt("|------------------------------------------------------------------")
    echo fmt("|    {fgMagenta}{align(op.name,11)}{fgWhite}  {formattedDesc}")
    if op.alias!="":
        echo fmt("|          {fgWhite}alias{fgWhite}  {op.alias}")
    # echo fmt("|")
    # echo fmt("|                 {formattedDesc}")
    echo fmt("|------------------------------------------------------------------")
    let clearName = op.name.replace("*","")
    echo fmt("|          {fgGreen}usage{fgWhite}  {fgBold}{clearName}{fgWhite} {params}")

    if op.attrs!="":
        echo "|"
        var attrLines = op.attrs.replacef(re":(\w+)", fgGray & ":$1" & fgWhite)
                            .replacef(re"\.(\w+)", fgBold & ".$1" & fgWhite)
                            .split("~")
        var maxattr = attrLines.map(proc (x:string):int = (x.split("->"))[0].len ).max()
        var maxprop = attrLines.map(proc (x:string):int = (x.split("->"))[0].countSubstr(":") ).max()
        #maxattr = attrLines.map(proc (x:string):int = (echo x.split("->"); echo (x.split("->"))[0].len; x.split("->"))[0].len ).max()
        attrLines = attrLines.map(proc (x:string):string = 
            alignLeft( (x.split("->"))[0], maxattr-((maxprop-(x.split("->"))[0].countSubstr(":"))*11)) & "->" & (x.split("->"))[1]
        )
        #echo fmt("maxattr: {maxattr}")
        var formattedAttrs = attrLines.join("\n|                 ")
                                     
        echo fmt("|        {fgGreen}options{fgWhite}  {formattedAttrs}")

    echo "|"
    echo fmt("|        {fgGreen}returns{fgWhite}  {fgGray}{ret}{fgWhite}")
    echo fmt("|------------------------------------------------------------------")

#=======================================
# Methods
#=======================================

template Inspect*():untyped =
    require(opInspect)
    x.dump(0, false)

template Is*():untyped =
    require(opIs)
    stack.push(newBoolean(x.t == y.kind))

template Type*():untyped = 
    require(opType)
    stack.push(newType(x.kind))

template Info*():untyped =
    require(opInfo)
    var found = false

    for opspec in OpSpecs:
        if opspec.name.replace("*","") == x.s:
            found = true
            if (popAttr("get") != VNULL):
                stack.push(opspec.getInfo())
            else:
                opspec.printInfo()
            break

    if not found:
        echo "no information found for given symbol"

template Help*():untyped =
    require(opHelp)
    printHelp()

template Benchmark*():untyped =
    require(opBenchmark)

    benchmark "":
        discard execBlock(x)

template GetAttr*():untyped =
    require(opGetAttr)

    stack.push(popAttr(x.s))

template HasAttr*():untyped =
    require(opHasAttr)

    if getAttr(x.s) != VNULL:
        stack.push(VTRUE)
    else:
        stack.push(VFALSE)

template GetAttrs*():untyped =
    require(opGetAttrs)

    stack.push(getAttrsDict())

template IsSet*():untyped =
    require(opIsSet)

    stack.push(newBoolean(syms.hasKey(x.s)))

template Symbols*():untyped =
    require(opSymbols)
    var symbols: ValueDict = initOrderedTable[string,Value]()
    for k,v in pairs(syms):
        if k[0]!=toUpperAscii(k[0]):
            symbols[k] = v
    stack.push(newDictionary(symbols))

template GetStack*():untyped =
    require(opStack)

    stack.push(newBlock(Stack[0..SP-1]))