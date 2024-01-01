
import std/strformat

type
    VError* = ref object of CatchableError
        kind*: VErrorKind
        
    VErrorKind* = ref object
        label*: string

proc newDefaultError*(): VErrorKind =
    result = VErrorKind(label: "Generic Error")

let 
    genericErrorKind*: VErrorKind = newDefaultError()

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"

