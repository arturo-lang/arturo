######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/globals.nim
######################################################

#=======================================
# Libraries
#=======================================

import std/editdistance, sequtils, tables

import vm/[errors, profiler, values/value]

#=======================================
# Globals
#=======================================

# TODO(VM/globals) Is there any way to actually avoid them altogether?
#  Having all these global variables is practical, but it actually causes problems when we end up wanting to work with multiple threads. An idea would be to add them as fields in a VM object, and pass this object around. But it would still need to be properly benchmark as it would - undoubtedly - add some serious overhead.
#  labels: vm, enhancement, benchmark, open discussion

var
    # symbols
    Syms* {.global.}      : ValueDict

    # symbol aliases
    Aliases* {.global.}   : SymbolDict

    # function arity reference
    Arities* {.global.}   : Table[string,int]

    # libraries 
    Libraries* {.global.} : seq[BuiltinAction]

#=======================================
# Helpers
#=======================================

func suggestAlternative*(s: string, reference: ValueDict = Syms): seq[string] {.inline.} =
    var levs = initOrderedTable[string,int]()

    for k,v in pairs(reference):
        levs[k] = editDistance(s,k)

    proc cmper (x, y: (string, int)): int {.closure.} = cmp(x[1], y[1])
    levs.sort(cmper)

    if levs.len > 3: result = toSeq(levs.keys)[0..2]
    else: result = toSeq(levs.keys)

#=======================================
# Methods
#=======================================

# Safe Dictionary/Array access

template GetKey*(dict: ValueDict, key: string): untyped =
    let toRet = dict.getOrDefault(key, nil)
    if unlikely(toRet.isNil):
        RuntimeError_KeyNotFound(key, suggestAlternative(key, reference=dict))
    toRet

template GetArrayIndex*(arr: ValueArray, indx: int): untyped =
    if unlikely(indx < 0 or indx > (arr.len)-1):
        RuntimeError_OutOfBounds(indx, arr.len-1)
    arr[indx]

template SetArrayIndex*(arr: ValueArray, indx: int, v: Value): untyped =
    if unlikely(indx < 0 or indx > (arr.len)-1):
        RuntimeError_OutOfBounds(indx, arr.len-1)
    arr[indx] = v

# Symbol table

template SymExists*(s: string): untyped =
    Syms.hasKey(s)

proc FetchSym*(s: string, unsafe: static bool = false): Value {.inline.} =
    when not unsafe:
        if (result = Syms.getOrDefault(s, nil); unlikely(result.isNil)):
            RuntimeError_SymbolNotFound(s, suggestAlternative(s))
    else:
        Syms[s]

template SetSym*(s: string, v: Value, safe: static bool = false): untyped =
    when safe:
        if v.readonly:
            Syms[s] = copyValue(v)
        else:
            Syms[s] = v
    else:
        Syms[s] = v

template GetSym*(s: string): untyped =
    Syms[s]

# In-Place symbols

proc checkInPlaced*(ipv: Value, varname: string) {.inline.} =
    if unlikely(ipv.isNil):
        RuntimeError_SymbolNotFound(varname, suggestAlternative(varname))
    if unlikely(ipv.readonly):
        RuntimeError_CannotModifyConstant(varname)

template ensureInPlace*(): untyped = 
    var InPlaced {.cursor,inject.} = Syms.getOrDefault(x.s, nil)
    InPlaced.checkInPlaced(x.s)
    

# macro InPlacement*(): untyped =
#     result = quote do:
#         let InPlacer {.cursor.} = Syms.getOrDefault(x.s, nil)
#         if unlikely(InPlacer.isNil):
#             RuntimeError_SymbolNotFound(x.s, suggestAlternative(x.s))
#         if InPlacer.readonly:
#             RuntimeError_CannotModifyConstant(x.s)

#     else:
#         result = quote do:
#             let `cleanName` {.cursor.} = `name`.a


# # TODO(Globals/InPlace) Should convert to proc?
# #  labels: performance, benchmark
# template InPlace*(): untyped =
#     when defined(PROFILER):
#         hookProcProfiler("globals/InPlace"):
#             if unlikely(not SymExists(x.s)):
#                 RuntimeError_SymbolNotFound(x.s, suggestAlternative(x.s))
#             discard GetSym(x.s)
#         GetSym(x.s)
#     else:
#         # TODO(Globals/InPlace) Inefficient implementation
#         #  In case the variable exists, which it most likely does, we are doing a double lookup. 
#         #  We should be able to avoid this.
#         #  labels: performance, enhancement
#         if unlikely(not SymExists(x.s)):
#             RuntimeError_SymbolNotFound(x.s, suggestAlternative(x.s))

#         # TODO(Globals/InPlace) Should make sure the symbol is not a *readonly* constant
#         #  This is done already, but it makes the whole thing even more inefficient
#         #  labels: enhancement, values
#         if unlikely(GetSym(x.s).readonly):
#             RuntimeError_CannotModifyConstant(x.s)

#         GetSym(x.s)

# template InPlaced*(): untyped =
#     GetSym(x.s)

template SetInPlace*(v: Value, safe: static bool = false): untyped =
    SetSym(x.s, v, safe)