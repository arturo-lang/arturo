
import std/strformat

type
    VErrorClass* = enum
        RuntimeError    = "Runtime"
        SyntaxError     = "Syntax"
        CompilerError   = "Compiler"

        UndefinedError  = "Undefined"
        
    VErrorKind* = ref object
        parent*: VErrorKind
        label*: string

    VError* = ref object of CatchableError
        kind*: VErrorKind

let runtimeErrorKind*   = VErrorKind(label: "Runtime Error", parent: nil)

proc newRuntimeError*(lbl: string): VErrorKind =
    result = VErrorKind(label: lbl, parent: runtimeErrorKind)

let 
    arithmeticErrorKind*        = newRuntimeError("Arithmetic Error")
    

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"

