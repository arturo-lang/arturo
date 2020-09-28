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
        echo fgBold & alignLeft(pair[0],15) & fgWhite & pair[1]

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
    # echo fmt("|")
    # echo fmt("|                 {formattedDesc}")
    echo fmt("|------------------------------------------------------------------")
    echo fmt("|          {fgGreen}usage{fgWhite}  {fgBold}{op.name}{fgWhite} {params}")

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
        if opspec.name == x.s:
            found = true
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

    let attrs = getAttrs()

    if attrs.hasKey(x.s): stack.push(attrs[x.s])
    else: stack.push(VNULL)

template HasAttr*():untyped =
    require(opHasAttr)

    var tmp = AP
    var found = false
    while tmp>0:
        let label = stack.Attrs[tmp-1].r
        if label == x.s: 
            stack.push(VTRUE)
            found = true 
            break

        tmp -= 2

    if not found:
        stack.push(VFALSE)

template GetAttrs*():untyped =
    require(opGetAttrs)

    stack.push(newDictionary(getAttrs()))
