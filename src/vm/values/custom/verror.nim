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

let RuntimeErr*   = VErrorKind(label: "Runtime Error", parent: nil)

proc newRuntimeError*(lbl: string): VErrorKind =
    result = VErrorKind(label: lbl, parent: RuntimeErr)

let 
    ArithmeticErr*      = newRuntimeError("Arithmetic Error")
    ConversionErr*      = newRuntimeError("Conversion Error")

#=======================================
# Overloads
#=======================================

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"