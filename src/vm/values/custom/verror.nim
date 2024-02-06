#=======================================
# Libraries
#=======================================

import std/strformat

#=======================================
# Types
#=======================================

type        
    VErrorKind* = ref object
        parent*: VErrorKind
        label*: string

    VError* = ref object of CatchableError
        kind*: VErrorKind

#=======================================
# Constants
#=======================================

let 
    RuntimeErr*     = VErrorKind(label: "Runtime Error", parent: nil)
    SyntaxErr*      = VErrorKind(label: "Syntax Error", parent: nil)
    CompilerErr*    = VErrorKind(label: "Compiler Error", parent: nil)
    ProgramErr*     = VErrorKind(label: "Program Error", parent: nil)

proc newRuntimeError*(lbl: string): VErrorKind =
    result = VErrorKind(label: lbl, parent: RuntimeErr)

let 
    ArithmeticErr*      = newRuntimeError("Arithmetic Error")
    AssertionErr*       = newRuntimeError("Assertion Error")
    ConversionErr*      = newRuntimeError("Conversion Error")

#=======================================
# Overloads
#=======================================

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"