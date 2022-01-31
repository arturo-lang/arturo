######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/common.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, sets, strutils, tables
export strutils, tables

import vm/[globals, errors, stack, values/comparison, values/logic, values/printable, values/value]
export comparison, globals, logic, printable, stack, value

#=======================================
# Constants
#=======================================

const
    NoArgs*      = static {"" : {Nothing}}
    NoAttrs*     = static {"" : ({Nothing},"")}

#=======================================
# Helpers
#=======================================

proc getWrongArgumentTypeErrorMsg*(functionName: string, argumentPos: int, expectedValues: seq[ValueKind]): string =
    let actualStr = toSeq(0..argumentPos).map(proc(x:int):string = ":" & ($(Stack[SP-1-x].kind)).toLowerAscii()).join(" ")
    let acceptedStr = expectedValues.map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")

    var ordinalPos: string = ""
    if argumentPos==0:
        ordinalPos = "first"
    elif argumentPos==1:
        ordinalPos = "second"
    elif argumentPos==2:
        ordinalPos = "third"

    return "cannot perform _" & functionName & "_ -> " & actualStr & ";" &
           "incorrect argument type for " & ordinalPos & " parameter;" &
           "accepts " & acceptedStr

#=======================================
# Templates
#=======================================
when defined(PORTABLE):
    import json, os, sugar

    let js {.compileTime.} = parseJson(static readFile(getEnv("PORTABLE_DATA")))
    let funcs {.compileTime.} = toSeq(js["uses"]["functions"]).map((x) => x.getStr())
    let compact {.compileTime.} = js["compact"].getStr() == "true"
else:
    let funcs {.compileTime.}: seq[string] = @[]
    let compact {.compileTime.} = false

template builtin*(n: string, alias: SymbolKind, rule: PrecedenceKind, description: string, args: untyped, attrs: untyped, returns: ValueSpec, example: string, act: untyped):untyped =
    when not defined(PORTABLE) or not compact or funcs.contains(n):
        
        when defined(DEV):
            static: echo " -> " & n

        when args.len==1 and args==NoArgs:  
            const argsLen = 0
        else:                               
            const argsLen = static args.len

        when defined(NOEXAMPLES):
            const cleanExample = ""
        else:
            const cleanExample = replace(strutils.strip(example),"\n            ","\n")
            
        when not defined(WEB):
            let b = newBuiltin(n, alias, rule, "[" & static (instantiationInfo().filename).replace(".nim") & "] " & description, static argsLen, args.toOrderedTable, attrs.toOrderedTable, returns, cleanExample, proc () =
                require(n, args)
                act
            )
        else:
            let b = newBuiltin(n, alias, rule, "[" & static (instantiationInfo().filename).replace(".nim") & "]", static argsLen, initOrderedTable[string,ValueSpec](), initOrderedTable[string,(ValueSpec,string)](), returns, cleanExample, proc () =
                require(n, args)
                act
            )

        Arities[n] = static argsLen
        Syms[n] = b

        when alias != unaliased:
            Aliases[alias] = AliasBinding(
                precedence: rule,
                name: newWord(n)
            )

template constant*(n: string, alias: SymbolKind, description: string, v: Value):untyped =
    Syms[n] = (v)
    Syms[n].info = "[" & static (instantiationInfo().filename).replace(".nim") & "] " & description
    when alias != unaliased:
        Aliases[alias] = AliasBinding(
            precedence: PrefixPrecedence,
            name: newWord(n)
        )

template require*(name: string, spec: untyped): untyped =
    if SP<(static spec.len) and spec!=NoArgs:
        RuntimeError_NotEnoughArguments(name, spec.len)

    when (static spec.len)>=1 and spec!=NoArgs:
        when not (ANY in static spec[0][1]):
            if not (Stack[SP-1].kind in (static spec[0][1])):
                RuntimeError_WrongArgumentType(name, 0, spec)
                
        when (static spec.len)>=2:
            when not (ANY in static spec[1][1]):
                if not (Stack[SP-2].kind in (static spec[1][1])):
                    RuntimeError_WrongArgumentType(name, 1, spec)
                    
            when (static spec.len)>=3:
                when not (ANY in static spec[2][1]):
                    if not (Stack[SP-3].kind in (static spec[2][1])):
                        RuntimeError_WrongArgumentType(name, 2, spec)
                        
    when (static spec.len)>=1 and spec!=NoArgs:
        var x {.inject.} = stack.pop()
        when (static spec.len)>=2:
            var y {.inject.} = stack.pop()
            when (static spec.len)>=3:
                var z {.inject.} = stack.pop()
