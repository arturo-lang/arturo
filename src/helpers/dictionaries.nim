######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/dictionaries.nim
######################################################

#=======================================
# Libraries
#=======================================

import tables

import vm/values/value

#=======================================
# Methods
#=======================================

proc flattenedDictionary*(vd: ValueDict): ValueArray =
    for k,v in vd.pairs:
        result.add(newString(k))
        result.add(v)