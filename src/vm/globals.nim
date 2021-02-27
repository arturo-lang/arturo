######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/globals.nim
######################################################

#=======================================
# Libraries
#=======================================

import std/editdistance, tables

import vm/[errors,value]

#=======================================
# Types
#=======================================

type
    Translation* = (ValueArray, ByteArray) # (constants, instructions)
    Library* = proc()

#=======================================
# Constants
#=======================================

const
    NoTranslation*  = (@[],@[])

#=======================================
# Globals
#=======================================

var
    # symbols
    Syms*       : ValueDict

    # symbol aliases
    Aliases*    : SymbolDict

    # function arity reference
    Arities*    : Table[string,int]

    # libraries 
    Libraries*  : seq[Library]

#=======================================
# Methods
#=======================================

proc suggestAlternative*(s: string): string {.inline.} =
    var minLevenshtein = 100
    result = ""
    for k,v in pairs(Syms):
        let ed = editDistance(s,k)
        if ed < minLevenshtein:
            minLevenshtein = ed
            result = k

#=======================================
# Methods
#=======================================

proc setValue*(s: string, v: Value) {.inline.} =
    Syms[s] = v

proc getValue*(s: string): Value {.inline.} =
    result = Syms.getOrDefault(s)
    if result.isNil:
        RuntimeError_SymbolNotFound(s, suggestAlternative(s))

template inPlace*(s: string): untyped =
    if not Syms.hasKey(s):
        RuntimeError_SymbolNotFound(s, suggestAlternative(s))
    Syms[s]