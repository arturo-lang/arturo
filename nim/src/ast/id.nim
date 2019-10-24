type
    IdPartKind = enum
        stringIdPart, numIdPart, exprIdPart

    Expression = object
        left: string
        op: string
        right: string

    IdPart* = object
        case kind*: IdPartKind:
            of stringIdPart:
                s*: string
            of numIdPart:
                n*: int
            of exprIdPart:
                e*: Expression

    Id* = ref object
        parts:seq[IdPart]

#####

proc new_IdentifierWithId(i:cstring, hsh:bool):Id {.exportc.} = 
    let ret = Id(parts: @[IdPart(kind: stringIdPart, s: $i)])
    echo ret[]
    return ret

proc add_IdToIdentifier(i:cstring, id:Id) {.exportc.} =
    id.parts.add(IdPart(kind: stringIdPart, s: $i))
    echo id[]

#proc getID(i:cstring){.exportc.} =

proc gotID(i:cstring){.exportc.} =
    echo "found:ID=" & $i
