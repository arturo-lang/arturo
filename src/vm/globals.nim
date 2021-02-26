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

import tables

import vm/value

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

proc setValue*(s: string, v: Value) {.inline.} =
    Syms[s] = v

proc getValue*(s: string): Value {.inline.} =
    Syms.getOrDefault(s, default=VNOTHING)