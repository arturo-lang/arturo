#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/symslots.nim
#=======================================================

## Slot-based symbol table.
##
## Every symbol name gets a fixed, global id the first time
## we come across it; a symbol table is then just an array of
## values, indexed by that id (nil = not defined).

#=======================================
# Libraries
#=======================================

import tables

import vm/values/types

#=======================================
# Variables
#=======================================

var
    SymIds*     : Table[string, int32]      ## name -> id
    SymNames*   : seq[string] = @[""]       ## id -> name (0 = no symbol)

#=======================================
# Methods
#=======================================

proc findSymId*(s: string): int32 {.inline.} =
    ## Get id for given name - 0, if we've never seen it
    SymIds.getOrDefault(s, 0)

proc newSymId(s: string): int32 {.noinline.} =
    result = int32(SymNames.len)
    SymNames.add(s)
    SymIds[s] = result

proc symId*(s: string): int32 {.inline.} =
    ## Get id for given name, creating one if needed
    result = SymIds.getOrDefault(s, 0)
    if unlikely(result == 0):
        result = newSymId(s)

proc symIdOf*(v: Value): int32 {.inline.} =
    ## Get id for given Word/Literal/... value,
    ## cached in the value itself.
    ##
    ## Only constants get to keep it: they are read-only, so
    ## their name can never change under a cached id; any other
    ## value (e.g. a Literal held by a variable, that may still
    ## be altered in-place) is looked up by name every time
    result = v.sid
    if unlikely(result == 0):
        result = symId(v.s)
        if likely(v.readonly and v.kind != String):
            v.sid = result

proc initSymSlots*(initialSize = 1024): SymSlots =
    result.vals = newSeq[Value](initialSize)

proc grow(t: var SymSlots, id: int32) {.noinline.} =
    t.vals.setLen(max(int(id) + 1, t.vals.len * 2))

proc getById*(t: SymSlots, id: int32): Value {.inline.} =
    if likely(id < t.vals.len): t.vals[id]
    else: nil

proc addrById*(t: var SymSlots, id: int32): ptr Value {.inline.} =
    if likely(id < t.vals.len) and not t.vals[id].isNil: addr t.vals[id]
    else: nil

proc setById*(t: var SymSlots, id: int32, v: sink Value) {.inline.} =
    if unlikely(id >= t.vals.len): grow(t, id)
    t.vals[id] = v

proc delById*(t: var SymSlots, id: int32) {.inline.} =
    if likely(id < t.vals.len): t.vals[id] = nil

proc getOrDefault*(t: SymSlots, s: string, default: Value = nil): Value {.inline.} =
    let id = findSymId(s)
    if id != 0:
        result = t.getById(id)
    if result.isNil:
        result = default

proc hasKey*(t: SymSlots, s: string): bool {.inline.} =
    let id = findSymId(s)
    id != 0 and id < t.vals.len and not t.vals[id].isNil

proc `[]`*(t: var SymSlots, s: string): var Value =
    let id = findSymId(s)
    if id == 0 or id >= t.vals.len or t.vals[id].isNil:
        raise newException(KeyError, "key not found: " & s)
    t.vals[id]

proc `[]`*(t: SymSlots, s: string): Value =
    let id = findSymId(s)
    if id == 0 or id >= t.vals.len or t.vals[id].isNil:
        raise newException(KeyError, "key not found: " & s)
    t.vals[id]

proc `[]=`*(t: var SymSlots, s: string, v: sink Value) {.inline.} =
    t.setById(symId(s), v)

proc del*(t: var SymSlots, s: string) {.inline.} =
    let id = findSymId(s)
    if id != 0:
        t.delById(id)

iterator pairs*(t: SymSlots): (string, Value) =
    for i in 1 ..< min(t.vals.len, SymNames.len):
        if not t.vals[i].isNil:
            yield (SymNames[i], t.vals[i])

iterator keys*(t: SymSlots): string =
    for i in 1 ..< min(t.vals.len, SymNames.len):
        if not t.vals[i].isNil:
            yield SymNames[i]
