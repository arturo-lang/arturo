#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: vm/checks.nim
#=======================================================

## Helpers & value checkers for Arturo's standard library.

#=======================================
# Libraries
#=======================================

import sequtils, strutils

import helpers/terminal

import vm/[globals, stack, errors]
import vm/values/[value, printable]

#=======================================
# Helpers
#=======================================

proc showWrongArgumentTypeError*(name: string, pos: int, params: openArray[Value], expected: openArray[(string, set[ValueKind])]) =
    ## show relevant error message in case ``require`` 
    ## fails to validate the arguments passed to the 
    ## function
    var expectedValues = toSeq((expected[pos][1]).items)
    let acceptedStr = expectedValues.map(proc(x:ValueKind):string = stringify(x)).join(", ")
    let actualStr = expected.map(proc(aa:(string,set[ValueKind])):string = aa[0]).join(" ") &
        fg(redColor) & " \u25c4" & resetColor()

    Error_WrongArgumentType(name, actualStr, Dumper(params[^1]), $(pos+1), acceptedStr)

proc showWrongAttributeTypeError*(fName: string, aName: string, actual:Value, expected: set[ValueKind]): bool =
    ## show relevant error message in case an attribute
    ## fails to validate its argument
    var expectedValues = toSeq(expected.items)
    let acceptedStr = expectedValues.map(proc(x:ValueKind):string = stringify(x)).join(" ")
    Error_WrongAttributeType(fName, aName & ":" & fg(redColor) & " \u25c4" & resetColor(), Dumper(actual), acceptedStr)

proc showWrongValueTypeError*(fName: string, actual: Value, pre: string, expected: set[ValueKind] | string) =
    let actualStr = pre & "[" & valueKind(actual) & "...]"
    let acceptedStr = 
        when expected is set[ValueKind]:
            (toSeq(expected.items)).map(proc(x:ValueKind):string = stringify(x)).join(" ")
        else:
            expected

    Error_IncompatibleBlockValue(fName, actualStr, acceptedStr)

proc showWrongValueAttrTypeError*(fName: string, attr: string, actual: Value, expected: set[ValueKind] | string) =
    let actualStr = "[" & valueKind(actual) & "...]"
    let acceptedStr = 
        when expected is set[ValueKind]:
            (toSeq(expected.items)).map(proc(x:ValueKind):string = stringify(x)).join(" ")
        else:
            expected

    Error_IncompatibleBlockValueAttribute(fName, "." & attr, actualStr, acceptedStr)

#=======================================
# Methods
#=======================================

template require*(name: string, spec: untyped): untyped =
    ## make sure that the given arguments match the given spec, 
    ## before passing the control to the function
    when spec!=NoArgs:
        const currentBuiltinName {.inject.} = name

        if unlikely(SP<(static spec.len)):
            Error_NotEnoughArguments(currentBuiltinName, spec.len)

    when (static spec.len)>=1 and spec!=NoArgs:
        let x {.inject.} = stack.pop()
        let xKind {.inject, used.} = x.kind
        when not (ANY in static spec[0][1]):
            if unlikely(not (xKind in (static spec[0][1]))):
                showWrongArgumentTypeError(currentBuiltinName, 0, [x], spec)
                
        when (static spec.len)>=2:
            let y {.inject.} = stack.pop()
            let yKind {.inject, used.} = y.kind
            when not (ANY in static spec[1][1]):
                if unlikely(not (yKind in (static spec[1][1]))):
                    showWrongArgumentTypeError(currentBuiltinName, 1, [x,y], spec)
                    
            when (static spec.len)>=3:
                let z {.inject.} = stack.pop()
                let zKind {.inject, used.} = z.kind
                when not (ANY in static spec[2][1]):
                    if unlikely(not (zKind in (static spec[2][1]))):
                        showWrongArgumentTypeError(currentBuiltinName, 2, [x,y,z], spec)

template requireBlockSize*(v: Value, expected: int, maxExpected: int = 0) =
    when not defined(BUNDLE):
        when maxExpected == 0:
            if unlikely(v.a.len != expected):
                Error_IncompatibleBlockSize(currentBuiltinName, v.a.len, $(expected))
        else:
            if unlikely(v.a.len < expected or v.a.len > maxExpected):
                Error_IncompatibleBlockSize(currentBuiltinName, v.a.len, $(expected) & ".." & $(maxExpected))

template requireValue*(v: Value, expected: set[ValueKind], position: int = 1, message: set[ValueKind] | string = {}) = 
    when not defined(BUNDLE):
        template pre(): untyped {.redefine.} = 
            when position == 2:
                valueKind(x) & " "
            elif position == 3:
                valueKind(x) & " " & valueKind(y) & " "
            else:
                ""

        if unlikely(v.kind notin expected):
            when message is string:
                showWrongValueTypeError(currentBuiltinName, v, pre, message)
            else:
                showWrongValueTypeError(currentBuiltinName, v, pre, expected)

template requireValueBlock*(v: Value, expected: set[ValueKind], position: int = 1, message: set[ValueKind] | string = {}) = 
    for item in v.a:
        requireValue(item, expected, position, message)

template requireAttrValue*(attr: string, v: Value, expected: set[ValueKind], message: set[ValueKind] | string = {}) =
    when not defined(BUNDLE):
        if unlikely(v.kind notin expected):
            when message is string:
                showWrongValueAttrTypeError(currentBuiltinName, attr, v, message)
            else:
                showWrongValueAttrTypeError(currentBuiltinName, attr, v, expected)

template requireAttrValueBlock*(attr: string, v: Value, expected: set[ValueKind], message: set[ValueKind] | string = {}) = 
    for item in v.a:
        requireAttrValue(attr, item, expected, message)
