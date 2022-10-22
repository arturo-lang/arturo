#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/common.nim
#=======================================================

## Helpers & utilities for Arturo's standard library.

#=======================================
# Libraries
#=======================================

import sequtils, sets, strutils, tables
export strutils, tables

import vm/[globals, errors, stack, values/comparison, values/clean, values/printable, values/value]
export clean, comparison, globals, printable, stack, value

import vm/values/custom/[vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol]
export vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol

import vm/profiler

#=======================================
# Constants
#=======================================

const
    NoArgs*      = static {"" : {Nothing}}
    NoAttrs*     = static {"" : ({Nothing},"")}

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

# TODO(VM/lib) Introduce typeset data type?
#  It would be ideal to have a `:typeset` data type which would serve as an umbrella-set for different types, and used mainly in function signatures: primarily, the built-in ones, and of course the user-defined ones. But we have to figure out how this could work in a viable way...
#  The code below is just an attempt of "unfolding" typesets, by force-embedding them into each function's list of accepted types. But this may be messy for documentation generation.
#  labels: vm, language, values, enhancement, open discussion

# template expandTypesets*(args: untyped): untyped =
#     when (static args.len)==1 and args!=NoArgs:
#         #echo($(args))
#         when args[0][1].contains(Block):
#             [(args[0][0], args[0][1] + {Inline})]
#         else:
#             args
#     else:
#         args

template builtin*(n: string, alias: VSymbol, rule: PrecedenceKind, description: string, args: untyped, attrs: untyped, returns: ValueSpec, example: string, act: untyped):untyped =
    
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
            
        # TODO(VM/lib) Rewrite in a cleaner way
        #  labels: vm, cleanup
        when not defined(WEB):
            let b = newBuiltin("[" & static (instantiationInfo().filename).replace(".nim") & ":" & $(static (instantiationInfo().line)) & "] " & description, static argsLen, args.toOrderedTable, attrs.toOrderedTable, returns, cleanExample, proc () =
                hookProcProfiler("lib/require"):
                    require(n, args)

                {.emit: "////implementation: " & static (instantiationInfo().filename).replace(".nim") & "/" & n .}

                hookFunctionProfiler(n):
                    act

                {.emit: "////end: " & static (instantiationInfo().filename).replace(".nim") & "/" & n .}
            )
        else:
            let b = newBuiltin("", static argsLen, initOrderedTable[string,ValueSpec](), initOrderedTable[string,(ValueSpec,string)](), returns, cleanExample, proc () =
                require(n, args)
                act
            )

        Arities[n] = static argsLen
        SetSym(n, b)

        when n=="array"             : ArrayF = b
        elif n=="dictionary"        : DictF = b
        elif n=="function"          : FuncF = b               
        elif n=="add"               : AddF = b
        elif n=="sub"               : SubF = b
        elif n=="mul"               : MulF = b
        elif n=="div"               : DivF = b
        elif n=="fdiv"              : FdivF = b
        elif n=="mod"               : ModF = b
        elif n=="pow"               : PowF = b
        elif n=="neg"               : NegF = b
        elif n=="not"               : BNotF = b
        elif n=="and"               : BAndF = b
        elif n=="or"                : BOrF = b
        elif n=="shl"               : ShlF = b
        elif n=="shr"               : ShrF = b
        elif n=="not?"              : NotF = b
        elif n=="and?"              : AndF = b
        elif n=="or?"               : OrF = b
        elif n=="equal?"            : EqF = b
        elif n=="notEqual?"         : NeF = b
        elif n=="greater?"          : GtF = b
        elif n=="greaterOrEqual?"   : GeF = b
        elif n=="less?"             : LtF = b
        elif n=="lessOrEqual?"      : LeF = b
        elif n=="if"                : IfF = b
        elif n=="if?"               : IfEF = b
        elif n=="else"              : ElseF = b
        elif n=="while"             : WhileF = b
        elif n=="return"            : ReturnF = b
        elif n=="get"               : GetF = b 
        elif n=="set"               : SetF = b
        elif n=="to"                : ToF = b
        elif n=="print"             : PrintF = b
        elif n=="range"             : RangeF = b
        elif n=="loop"              : LoopF = b
        elif n=="map"               : MapF = b 
        elif n=="select"            : SelectF = b
        elif n=="size"              : SizeF = b
        elif n=="replace"           : ReplaceF = b
        elif n=="split"             : SplitF = b
        elif n=="join"              : JoinF = b
        elif n=="reverse"           : ReverseF = b
        elif n=="inc"               : IncF = b
        elif n=="dec"               : DecF = b

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
template constant*(n: string, alias: VSymbol, description: string, v: Value):untyped =
    SetSym(n, v)
    GetSym(n).info = "[" & static (instantiationInfo().filename).replace(".nim") & ":" & $(static (instantiationInfo().line)) & "] " & description
    when alias != unaliased:
        Aliases[alias] = AliasBinding(
            precedence: PrefixPrecedence,
            name: newWord(n)
        )

proc showWrongArgumentTypeError*(name: string, pos: int, params: openArray[Value], expected: openArray[(string, set[ValueKind])]) =
    var expectedValues = toSeq((expected[pos][1]).items)
    let acceptedStr = expectedValues.map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
    let actualStr = params.map(proc(x:Value):string = ":" & ($(x.kind)).toLowerAscii()).join(" ")
    var ordinalPos: string = ["first","second","third"][pos]

    RuntimeError_WrongArgumentType(name, actualStr, ordinalPos, acceptedStr)

template require*(name: string, spec: untyped): untyped =
    when spec!=NoArgs:
        if unlikely(SP<(static spec.len)):
            RuntimeError_NotEnoughArguments(name, spec.len)

    when (static spec.len)>=1 and spec!=NoArgs:
        let x {.inject.} = move stack.pop()
        when not (ANY in static spec[0][1]):
            if unlikely(not (x.kind in (static spec[0][1]))):
                showWrongArgumentTypeError(name, 0, [x], spec)
                
        when (static spec.len)>=2:
            let y {.inject.} = move stack.pop()
            when not (ANY in static spec[1][1]):
                if unlikely(not (y.kind in (static spec[1][1]))):
                    showWrongArgumentTypeError(name, 1, [x,y], spec)
                    
            when (static spec.len)>=3:
                let z {.inject.} = move stack.pop()
                when not (ANY in static spec[2][1]):
                    if unlikely(not (z.kind in (static spec[2][1]))):
                        showWrongArgumentTypeError(name, 2, [x,y,z], spec)