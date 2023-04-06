#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/common.nim
#=======================================================

## Helpers & utilities for Arturo's standard library.

#=======================================
# Libraries
#=======================================

import macros, sequtils, strutils, tables
export strutils, tables

import vm/[globals, errors, opcodes, stack, values/comparison, values/operators, values/printable, values/value]
export comparison, globals, opcodes, operators, printable, stack, value

import vm/values/custom/[vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol]
export vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol

import vm/profiler

#=======================================
# Constants
#=======================================

const
    NoArgs*      = static {"" : {Nothing}}          ## Shortcut for no arguments
    NoAttrs*     = static {"" : ({Nothing},"")}     ## Shortcut for no attributes

#=======================================
# Templates
#=======================================
when defined(PORTABLE):
    import algorithm, json, os, sugar

    let js {.compileTime.} = parseJson(static readFile(getEnv("PORTABLE_DATA")))
    let funcs {.compileTime.} = toSeq(js["uses"]["functions"]).map((x) => x.getStr())
    let compact {.compileTime.} = js["compact"].getStr() == "true"
else:
    let funcs {.compileTime.}: seq[string] = @[]
    let compact {.compileTime.} = false

# template expandTypesets*(args: untyped): untyped =
#     when (static args.len)==1 and args!=NoArgs:
#         #echo($(args))
#         when args[0][1].contains(Block):
#             [(args[0][0], args[0][1] + {Inline})]
#         else:
#             args
#     else:
#         args

macro attrTypes*(name: static[string], types: static[set[ValueKind]]): untyped =
    let attrRequiredTypes =  ident('t' & ($name).capitalizeAscii())
    if types == {Any}:
        result = quote do:
            let `attrRequiredTypes` {.used.} = {Null..Any}
    elif types != {Logical}:
        result = quote do:
            let `attrRequiredTypes` {.used.} = `types`
    
template addOne*(attrs: untyped, idx: int): untyped =
    when attrs.len > idx:
        attrTypes(attrs[idx][0], attrs[idx][1][0])

macro addAttrTypes*(attrs: untyped): untyped =
    result = newStmtList()
    for i in 0..<20:
        result.add quote do:
            addOne(`attrs`, `i`)

template builtin*(n: string, alias: VSymbol, op: OpCode, rule: PrecedenceKind, description: string, args: untyped, attrs: static openArray[(string,(set[ValueKind],string))], returns: ValueSpec, example: string, act: untyped):untyped =
    ## add new builtin, function with given name, alias, 
    ## rule, etc - followed by the code block to be 
    ## executed when the function is called
    
    when not defined(PORTABLE) or not compact or funcs.contains(n):
        
        when defined(DEV):
            static: echo " -> " & n

        when args.len==1 and args==NoArgs:  
            const argsLen = 0
        else:                               
            const argsLen = static args.len

        when defined(DOCGEN):
            const cleanExample = replace(strutils.strip(example),"\n            ","\n")
        else:
            const cleanExample = ""

        let b = newBuiltin(
            when not defined(WEB): description else: "",
            when not defined(WEB): static (instantiationInfo().filename.replace(".nim")) else: "",
            when not defined(WEB): static (instantiationInfo().line) else: 0,
            static argsLen, 
            when not defined(WEB): args.toOrderedTable else: initOrderedTable[string,ValueSpec](),
            when not defined(WEB): attrs.toOrderedTable else: initOrderedTable[string,(ValueSpec,string)](),
            returns, 
            cleanExample, 
            op,
            proc () =
                hookProcProfiler("lib/require"):
                    require(n, args)

                when attrs != NoAttrs:
                    addAttrTypes(attrs)

                {.emit: "////implementation: " & (static (instantiationInfo().filename.replace(".nim"))) & "/" & n .}

                hookFunctionProfiler(n):
                    act

                {.emit: "////end: " & (static (instantiationInfo().filename.replace(".nim"))) & "/" & n .}
        )

        SetSym(n, b)

        when n=="add"               : DoAdd = b.action()
        elif n=="sub"               : DoSub = b.action()
        elif n=="mul"               : DoMul = b.action()
        elif n=="div"               : DoDiv = b.action()
        elif n=="fdiv"              : DoFdiv = b.action()
        elif n=="mod"               : DoMod = b.action()
        elif n=="pow"               : DoPow = b.action()
        elif n=="neg"               : DoNeg = b.action()
        elif n=="inc"               : DoInc = b.action()
        elif n=="dec"               : DoDec = b.action()
        elif n=="not"               : DoBNot = b.action()
        elif n=="and"               : DoBAnd = b.action()
        elif n=="or"                : DoBOr = b.action()
        elif n=="shl"               : DoShl = b.action()
        elif n=="shr"               : DoShr = b.action()
        elif n=="not?"              : DoNot = b.action()
        elif n=="and?"              : DoAnd = b.action()
        elif n=="or?"               : DoOr = b.action()
        elif n=="equal?"            : DoEq = b.action()
        elif n=="notEqual?"         : DoNe = b.action()
        elif n=="greater?"          : DoGt = b.action()
        elif n=="greaterOrEqual?"   : DoGe = b.action()
        elif n=="less?"             : DoLt = b.action()
        elif n=="lessOrEqual?"      : DoLe = b.action()
        elif n=="get"               : DoGet = b.action()
        elif n=="set"               : DoSet = b.action()
        elif n=="if"                : DoIf = b.action()
        elif n=="if?"               : DoIfE = b.action()
        elif n=="unless"            : DoUnless = b.action()
        elif n=="unless?"           : DoUnlessE = b.action()
        elif n=="else"              : DoElse = b.action()
        elif n=="switch"            : DoSwitch = b.action()
        elif n=="while"             : DoWhile = b.action()
        elif n=="return"            : DoReturn = b.action()
        elif n=="break"             : DoBreak = b.action()
        elif n=="continue"          : DoContinue = b.action()
        elif n=="to"                : DoTo = b.action()
        elif n=="array"             : DoArray = b.action()
        elif n=="dictionary"        : DoDict = b.action()
        elif n=="function"          : DoFunc = b.action()  
        elif n=="range"             : DoRange = b.action()
        elif n=="loop"              : DoLoop = b.action()
        elif n=="map"               : DoMap = b.action() 
        elif n=="select"            : DoSelect = b.action()
        elif n=="size"              : DoSize = b.action()
        elif n=="replace"           : DoReplace = b.action()
        elif n=="split"             : DoSplit = b.action()
        elif n=="join"              : DoJoin = b.action()
        elif n=="reverse"           : DoReverse = b.action()
        elif n=="append"            : DoAppend = b.action()
        elif n=="print"             : DoPrint = b.action()

        when alias != unaliased:
            Aliases[alias] = AliasBinding(
                precedence: rule,
                name: newWord(n)
            )

# TODO(VM/lib) Merge constants and builtin's?
#  Do we really - really - need another "constant" type? I doubt it whether it makes any serious performance difference, with the only exception being constants like `true`, `false`, etc.
#  But then, it also over-complicates documentation generation for constants.
#  So, we should either make documentation possible for constants as well, or merge the two things into one concept
#  labels: vm, library, enhancement, open discussion

template constant*(n: string, alias: VSymbol, description: string, v: Value): untyped =
    ## add new constant with given name, alias, description - 
    ## followed by the value it's assigned to
    SetSym(n, v)
    var vInfo = ValueInfo(
        descr: description,
        module: static (instantiationInfo().filename).replace(".nim"),
        kind: v.kind
    )

    when defined(DOCGEN):
        vInfo.line = static (instantiationInfo().line)

    GetSym(n).info = vInfo

    when alias != unaliased:
        Aliases[alias] = AliasBinding(
            precedence: PrefixPrecedence,
            name: newWord(n)
        )

proc showWrongArgumentTypeError*(name: string, pos: int, params: openArray[Value], expected: openArray[(string, set[ValueKind])]) =
    ## show relevant error message in case ``require`` 
    ## fails to validate the arguments passed to the 
    ## function
    var expectedValues = toSeq((expected[pos][1]).items)
    let acceptedStr = expectedValues.map(proc(x:ValueKind):string = stringify(x)).join(" ")
    let actualStr = params.map(proc(x:Value):string = valueKind(x)).join(" ")
    var ordinalPos: string = ["first","second","third"][pos]

    RuntimeError_WrongArgumentType(name, actualStr, ordinalPos, acceptedStr)

proc showWrongAttributeTypeError*(fName: string, aName: string, actual:ValueKind, expected: set[ValueKind]): bool =
    ## show relevant error message in case an attribute
    ## fails to validate its argument
    var expectedValues = toSeq(expected.items)
    let acceptedStr = expectedValues.map(proc(x:ValueKind):string = stringify(x)).join(" ")
    let actualStr = stringify(actual)
    RuntimeError_WrongAttributeType(fName, aName, actualStr, acceptedStr)

proc showWrongValueTypeError*(fName: string, actual: Value, pre: string, expected: set[ValueKind] | string) =
    let actualStr = pre & "[" & valueKind(actual) & "...]"
    let acceptedStr = 
        when expected is set[ValueKind]:
            (toSeq(expected.items)).map(proc(x:ValueKind):string = stringify(x)).join(" ")
        else:
            expected

    RuntimeError_IncompatibleBlockValue(fName, actualStr, acceptedStr)

proc showWrongValueAttrTypeError*(fName: string, attr: string, actual: Value, expected: set[ValueKind] | string) =
    let actualStr = "[" & valueKind(actual) & "...]"
    let acceptedStr = 
        when expected is set[ValueKind]:
            (toSeq(expected.items)).map(proc(x:ValueKind):string = stringify(x)).join(" ")
        else:
            expected

    RuntimeError_IncompatibleBlockValueAttribute(fName, "." & attr, actualStr, acceptedStr)

template require*(name: string, spec: untyped): untyped =
    ## make sure that the given arguments match the given spec, 
    ## before passing the control to the function
    when spec!=NoArgs:
        const currentBuiltinName {.inject.} = name

        if unlikely(SP<(static spec.len)):
            RuntimeError_NotEnoughArguments(currentBuiltinName, spec.len)

    when (static spec.len)>=1 and spec!=NoArgs:
        let x {.inject.} = move stack.pop()
        let xKind {.inject, used.} = x.kind
        when not (ANY in static spec[0][1]):
            if unlikely(not (xKind in (static spec[0][1]))):
                showWrongArgumentTypeError(currentBuiltinName, 0, [x], spec)
                
        when (static spec.len)>=2:
            let y {.inject.} = move stack.pop()
            let yKind {.inject, used.} = y.kind
            when not (ANY in static spec[1][1]):
                if unlikely(not (yKind in (static spec[1][1]))):
                    showWrongArgumentTypeError(currentBuiltinName, 1, [x,y], spec)
                    
            when (static spec.len)>=3:
                let z {.inject.} = move stack.pop()
                let zKind {.inject, used.} = z.kind
                when not (ANY in static spec[2][1]):
                    if unlikely(not (zKind in (static spec[2][1]))):
                        showWrongArgumentTypeError(currentBuiltinName, 2, [x,y,z], spec)

template requireBlockSize*(v: Value, expected: int, maxExpected: int = 0) =
    when not defined(PORTABLE):
        when maxExpected == 0:
            if unlikely(v.a.len != expected):
                RuntimeError_IncompatibleBlockSize(currentBuiltinName, v.a.len, $(expected))
        else:
            if unlikely(v.a.len < expected or v.a.len > maxExpected):
                RuntimeError_IncompatibleBlockSize(currentBuiltinName, v.a.len, $(expected) & ".." & $(maxExpected))

template showcaseBlockValues(): untyped = 
    when position == 2:
        valueKind(x) & " "
    elif position == 3:
        valueKind(x) & " " & valueKind(y) & " "
    else:
        ""

template requireValue*(v: Value, expected: set[ValueKind], position: int = 1, message: set[ValueKind] | string = {}) = 
    when not defined(PORTABLE):
        if unlikely(v.kind notin expected):
            when message is string:
                showWrongValueTypeError(currentBuiltinName, v, showcaseBlockValues, message)
            else:
                showWrongValueTypeError(currentBuiltinName, v, showcaseBlockValues, expected)

template requireValueBlock*(v: Value, expected: set[ValueKind], position: int = 1, message: set[ValueKind] | string = {}) = 
    for item in v.a:
        requireValue(item, expected, position, message)

template requireAttrValue*(attr: string, v: Value, expected: set[ValueKind], message: set[ValueKind] | string = {}) =
    when not defined(PORTABLE):
        if unlikely(v.kind notin expected):
            when message is string:
                showWrongValueAttrTypeError(currentBuiltinName, attr, v, message)
            else:
                showWrongValueAttrTypeError(currentBuiltinName, attr, v, expected)

template requireAttrValueBlock*(attr: string, v: Value, expected: set[ValueKind], message: set[ValueKind] | string = {}) = 
    for item in v.a:
        requireAttrValue(attr, item, expected, message)