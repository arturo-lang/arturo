#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/common.nim
#=======================================================

## Helpers & utilities for Arturo's standard library.

#=======================================
# Libraries
#=======================================

import macros, strutils, tables
export strutils, tables

import vm/[checks, globals, opcodes, stack, values/comparison, values/operators, values/printable, values/value]
export checks, comparison, globals, opcodes, operators, printable, stack, value

import vm/values/custom/[vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol]
export vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol

import vm/bundle/resources

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
# when defined(BUNDLE):
#     import algorithm, json, os, sequtils, sugar

#     let js {.compileTime.} = parseJson(static getEnv("BUNDLE_FUNCTIONS"))
#     let bundledFuncs {.compileTime.} = toSeq(js).map((x) => x.getStr())
# else:
#     let bundledFuncs {.compileTime.}: seq[string] = @[]

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
    
    when not defined(BUNDLE) or BundleSymbols.contains(n):
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
            # if Aliases.hasKey(alias):
            #     echo "Already aliased! -> " & $(alias)
            #     echo "was aliased to: " & Aliases[alias].name.s
            #     echo "and trying to realias to: " & n
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
    
    when not defined(BUNDLE) or BundleSymbols.contains(n):
    
        when defined(DEV):
            static: echo " -> " & n

        SetSym(n, v)
        let moduleName = 
            when ((static (instantiationInfo().filename).replace(".nim")) != "macros"):
                (static (instantiationInfo().filename.replace(".nim")))
            else:
                "Quantities"
        var vInfo = ValueInfo(
            descr: description,
            module: moduleName,
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
