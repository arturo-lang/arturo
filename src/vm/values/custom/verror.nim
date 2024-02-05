
import std/strformat

type
    VErrorClass* = enum
        RuntimeError    = "Runtime"
        SyntaxError     = "Syntax"
        CompilerError   = "Compiler"

        UndefinedError  = "Undefined"
        
    VErrorKind* = ref object
        class*: VErrorClass
        label*: string

    VError* = ref object of CatchableError
        kind*: VErrorKind

proc newDefaultError*(): VErrorKind =
    result = VErrorKind(label: "Generic Error")

let 
    genericErrorKind*: VErrorKind = newDefaultError()

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"

