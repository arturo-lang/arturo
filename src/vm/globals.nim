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

#=======================================
# Globals
#=======================================

var
    # symbols
    syms*{.threadvar.}      : ValueDict
    aliases*{.threadvar.}   : SymbolDict
    Funcs*{.threadvar.}     : Table[string,int]
    Evaled*{.threadvar.}    : Table[Value,Translation]