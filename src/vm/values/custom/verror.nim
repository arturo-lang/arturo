
import std/strformat

type        
    VErrorKind* = ref object
        parent*: VErrorKind
        label*: string

    VError* = ref object of CatchableError
        kind*: VErrorKind

let RuntimeError*   = VErrorKind(label: "Runtime Error", parent: nil)

proc newRuntimeError*(lbl: string): VErrorKind =
    result = VErrorKind(label: lbl, parent: RuntimeError)

let 
    ArithmeticError*        = newRuntimeError("Arithmetic Error")

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"

