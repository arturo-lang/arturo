
import std/strformat

type
    VError* = object of CatchableError
        kind: VErrorKind
        
    VErrorKind* = object
        label: string

proc newDefaultError(): VError =
    const labelID = "Generic Error"
    result = VError(kind: VErrorKind(label: labelID))
    result.msg = labelID
    return result

let 
    genericError*: VError = newDefaultError()

func `$`*(kind: VErrorKind): string =
    kind.label

func `$`*(error: VError): string =
    fmt"{error.kind}: {error.msg}"

