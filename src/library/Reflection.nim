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

import algorithm, re, sequtils
import strformat, strutils, tables

import vm/bytecode, vm/env, vm/stack, vm/value
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

    let clearName = op.name.replace("*","")
    result = newDictionary({
                    "name"          : newString(clearName),
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

template Benchmark*():untyped =
    # EXAMPLE:
    # benchmark [ 
    # ____; some process that takes some time
    # ____loop 1..10000 => prime? 
    # ]
    #
    # ; [benchmark] time: 0.065s

    require(opBenchmark)

    benchmark "":
        discard execBlock(x)

template GetAttr*():untyped =
    # EXAMPLE:
    # multiply: function [x][
    # ____if? attr? "with" [ 
    # ________x * attr "with"
    # ____] 
    # ____else [ 
    # ________2*x 
    # ____]
    # ]
    #
    # print multiply 5
    # ; 10
    #
    # print multiply.with: 6 5
    # ; 60

    require(opGetAttr)

    stack.push(popAttr(x.s))

template GetAttrs*():untyped =
    # EXAMPLE:
    # greet: function [x][
    # ____print ["Hello" x "!"]
    # ____print attrs
    # ]
    #
    # greet.later "John"
    #
    # ; Hello John!
    # ; [
    # ;____later:    true
    # ; ]

    require(opGetAttrs)

    stack.push(getAttrsDict())

template GetStack*():untyped =
    # EXAMPLE:
    # 10 15           ; push something to the stack
    # print stack
    #
    # ; [ 10 ]

    require(opStack)

    stack.push(newBlock(Stack[0..SP-1]))
    
template HasAttr*():untyped =
    # EXAMPLE:
    # greet: function [x][
    # ____if? not? attr? 'later [
    # ________print ["Hello" x "!"]
    # ____]
    # ____else [
    # ________print [x "I'm afraid I'll greet you later!"]
    # ____]
    # ]
    #
    # greet.later "John"
    #
    # ; John I'm afraid I'll greet you later!

    require(opHasAttr)

    if getAttr(x.s) != VNULL:
        stack.push(VTRUE)
    else:
        stack.push(VFALSE)

template Help*():untyped =
    # EXAMPLE:
    # help
    #
    # ; abs      (value)   get the absolute value for given integer
    # ; acos     (angle)   calculate the inverse cosine of given angle
    # ; acosh    (angle)   calculate the inverse hyperbolic cosine of given angle
    # ; ...
    #
    # help 'print
    # ; |------------------------------------------------------------------
    # ;           print  print given value to screen with newline
    # ; |------------------------------------------------------------------
    # ; |          usage  print value  :any 
    # ; |
    # ; |        returns  :null
    # ; |------------------------------------------------------------------
    #
    
    require(opHelp)

    if x.kind==Literal:

        var found = false
        for opspec in OpSpecs:
            if opspec.name.replace("*","") == x.s:
                found = true
                opspec.printInfo()
                break

        if not found:
            echo "no information found for given symbol"

    else:
        printHelp()

template Info*():untyped =
    # EXAMPLE:
    # print info 'print
    #
    # ;_[
    # ;____name:           print
    # ;____description:    print given value to screen with newline
    # ;____alias:          
    # ;____arguments:      [
    # ;________[
    # ;____________name:           value
    # ;____________type:           [
    # ;________________:any
    # ;____________]
    # ;________]
    # ;____]
    # ;____attributes:     [
    # ;____]
    # ;____return:         [
    # ;________:null
    # ;____]
    # ; ]

    require(opInfo)

    for opspec in OpSpecs:
        if opspec.name.replace("*","") == x.s:
            stack.push(opspec.getInfo())
            break

template Inspect*():untyped =
    # EXAMPLE:
    # inspect 3                 ; 3 :integer
    #
    # a: "some text"
    # inspect a                 ; some text :string

    require(opInspect)
    x.dump(0, false)

template Is*():untyped =
    # EXAMPLE:
    # is? :string "hello"       ; => true
    # is? :block [1 2 3]        ; => true
    # is? :integer "boom"       ; => false

    require(opIs)
    stack.push(newBoolean(x.t == y.kind))

template IsAttribute*():untyped = 
    require(opIsAttribute)
    stack.push(newBoolean(x.kind==Attribute))

template IsAttributeLabel*():untyped = 
    require(opIsAttributeLabel)
    stack.push(newBoolean(x.kind==AttributeLabel))

template IsBinary*():untyped = 
    require(opIsBinary)
    stack.push(newBoolean(x.kind==Binary))

template IsBlock*():untyped = 
    require(opIsBlock)
    stack.push(newBoolean(x.kind==Block))

template IsBoolean*():untyped = 
    require(opIsBoolean)
    stack.push(newBoolean(x.kind==Boolean))

template IsChar*():untyped = 
    require(opIsChar)
    stack.push(newBoolean(x.kind==Char))

template IsDatabase*():untyped = 
    require(opIsDatabase)
    stack.push(newBoolean(x.kind==Database))

template IsDate*():untyped = 
    require(opIsDate)
    stack.push(newBoolean(x.kind==Date))

template IsDictionary*():untyped = 
    require(opIsDictionary)
    stack.push(newBoolean(x.kind==Dictionary))

template IsInline*():untyped = 
    require(opIsInline)
    stack.push(newBoolean(x.kind==Inline))

template IsInteger*():untyped = 
    require(opIsInteger)
    stack.push(newBoolean(x.kind==Integer))

template IsFloating*():untyped = 
    require(opIsFloating)
    stack.push(newBoolean(x.kind==Floating))

template IsFunction*():untyped = 
    require(opIsFunction)
    stack.push(newBoolean(x.kind==Function))

template IsLabel*():untyped = 
    require(opIsLabel)
    stack.push(newBoolean(x.kind==Label))

template IsLiteral*():untyped = 
    require(opIsLiteral)
    stack.push(newBoolean(x.kind==Literal))

template IsNull*():untyped = 
    require(opIsNull)
    stack.push(newBoolean(x.kind==Null))

template IsPath*():untyped = 
    require(opIsPath)
    stack.push(newBoolean(x.kind==Path))

template IsPathLabel*():untyped = 
    require(opIsPathLabel)
    stack.push(newBoolean(x.kind==PathLabel))

template IsStandalone*():untyped =
    require(opIsStandalone)
    stack.push(newBoolean(PathStack.len == 1))

template IsString*():untyped = 
    require(opIsString)
    stack.push(newBoolean(x.kind==String))

template IsSymbol*():untyped = 
    require(opIsSymbol)
    stack.push(newBoolean(x.kind==Symbol))

template IsType*():untyped = 
    require(opIsType)
    stack.push(newBoolean(x.kind==Type))

template IsWord*():untyped = 
    require(opIsWord)
    stack.push(newBoolean(x.kind==Word))

template IsSet*():untyped =
    # EXAMPLE:
    # boom: 12
    # print set? 'boom          ; true
    #
    # print set? 'zoom          ; false
    require(opIsSet)

    stack.push(newBoolean(syms.hasKey(x.s)))

template Symbols*():untyped =
    # EXAMPLE:
    # a: 2
    # b: "hello"
    #
    # print symbols
    #
    # ; [
    # ;____a: 2
    # ;____b: "hello"
    # ;_]

    require(opSymbols)
    var symbols: ValueDict = initOrderedTable[string,Value]()
    for k,v in pairs(syms):
        if k[0]!=toUpperAscii(k[0]):
            symbols[k] = v
    stack.push(newDictionary(symbols))

template Type*():untyped = 
    # EXAMPLE
    # print type 18966          ; :integer
    # print type "hello world"  ; :string

    require(opType)
    stack.push(newType(x.kind))

