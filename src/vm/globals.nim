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

import vm/[errors, values/value]

#=======================================
# Globals
#=======================================

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
# Methods
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

template GetKey*(dict: ValueDict, key: string): untyped =
    if not dict.hasKey(key):
        RuntimeError_KeyNotFound(key, suggestAlternative(key, reference=dict))
    dict[key]

template GetArrayIndex*(arr: ValueArray, indx: int): untyped =
    if indx < 0 or indx > (arr.len)-1:
        RuntimeError_OutOfBounds(indx, arr.len-1)
    arr[indx]

template SetArrayIndex*(arr: ValueArray, indx: int, v: Value): untyped =
    if indx < 0 or indx > (arr.len)-1:
        RuntimeError_OutOfBounds(indx, arr.len-1)
    arr[indx] = v

template InPlace*(): untyped =
    if not Syms.hasKey(x.s):
        RuntimeError_SymbolNotFound(x.s, suggestAlternative(x.s))
    Syms[x.s]

template InPlaced*(): untyped =
    Syms[x.s]

template SetInPlace*(v: Value): untyped =
    Syms[x.s] = v

template SymExists*(s: string): untyped =
    Syms.hasKey(s)

template GetSym*(s: string, unsafe: bool = false): untyped =
    when not unsafe:
        if not Syms.hasKey(s):
            RuntimeError_SymbolNotFound(s, suggestAlternative(s))
    Syms[s]

template SetSym*(s: string, v: Value): untyped =
    Syms[s] = v