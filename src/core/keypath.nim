#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/keypath.nim
  *****************************************************************]#

#[----------------------------------------
    Keypath Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc keypathFromIdId(a: cstring, b: cstring): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: stringKeyPathPart, s: $b)])

proc keypathFromIdInteger(a: cstring, b: cstring): KeyPath {.exportc.} =
    var intValue: int
    discard parseInt($b, intValue)

    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: integerKeyPathPart, i: intValue)])

proc keypathFromIdReal(a: cstring, b: cstring): KeyPath {.exportc.} =
    let parts = ($b).split(".")
    var intA, intB: int
    discard parseInt(parts[0], intA)
    discard parseInt(parts[1], intB)

    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: integerKeyPathPart, i: intA), KeyPathPart(kind: integerKeyPathPart, i: intB)])

proc keypathFromIdInline(a: cstring, b: Argument): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: stringKeyPathPart, s: $a), KeyPathPart(kind: inlineKeyPathPart, a: b)])

proc keypathFromInlineId(a: Argument, b: cstring): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: stringKeyPathPart, s: $b)])

proc keypathFromInlineInteger(a: Argument, b: cstring): KeyPath {.exportc.} =
    var intValue: int
    discard parseInt($b, intValue)

    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: integerKeyPathPart, i: intValue)])

proc keypathFromInlineReal(a: Argument, b: cstring): KeyPath {.exportc.} =
    let parts = ($b).split(".")
    var intA, intB: int
    discard parseInt(parts[0], intA)
    discard parseInt(parts[1], intB)

    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: integerKeyPathPart, i: intA), KeyPathPart(kind: integerKeyPathPart, i: intB)])

proc keypathFromInlineInline(a: Argument, b: Argument): KeyPath {.exportc.} =
    result = KeyPath(parts: @[KeyPathPart(kind: inlineKeyPathPart, a: a), KeyPathPart(kind: inlineKeyPathPart, a: b)])

proc keypathByAddingIdToKeypath(k: KeyPath, a: cstring):KeyPath {.exportc.} =
    k.parts.add(KeyPathPart(kind: stringKeyPathPart, s: $a))
    result = k

proc keypathByAddingIntegerToKeypath(k: KeyPath, a: cstring):KeyPath {.exportc.} =
    var intValue: int
    discard parseInt($a, intValue)

    k.parts.add(KeyPathPart(kind: integerKeyPathPart, i: intValue))
    result = k

proc keypathByAddingRealToKeypath(k: KeyPath, a: cstring):KeyPath {.exportc.} =
    let parts = ($a).split(".")
    var intA, intB: int
    discard parseInt(parts[0], intA)
    discard parseInt(parts[1], intB)

    k.parts.add(KeyPathPart(kind: integerKeyPathPart, i: intA))
    k.parts.add(KeyPathPart(kind: integerKeyPathPart, i: intB))
    result = k

proc keypathByAddingInlineToKeypath(k: KeyPath, a: Argument): KeyPath {.exportc.} =
    k.parts.add(KeyPathPart(kind: inlineKeyPathPart, a: a))
    result = k
    