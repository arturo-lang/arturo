######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/combinatorics.nim
######################################################

#=======================================
# Libraries
#=======================================

import hashes, sets, strutils, tables, unicode

import vm/values/comparison
import vm/values/value

#=======================================
# Methods
#=======================================

proc permutate*(s: ValueArray, emit: proc(emit:ValueArray) ) =
    var s = @s
    if s.len == 0: 
        emit(s)
        return
 
    var rc {.cursor} : proc(np: int)
    rc = proc(np: int) = 

        if np == 1: 
            emit(s)
            return
 
        var 
            np1 = np - 1
            pp = s.len - np1
 
        rc(np1) # recurs prior swaps
 
        for i in countDown(pp, 1):
            swap s[i], s[i-1]
            rc(np1) # recurs swap 
 
        let w = s[0]
        s[0..<pp] = s[1..pp]
        s[pp] = w
 
    rc(s.len)