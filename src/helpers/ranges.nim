#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/ranges.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import vm/values/custom/vrange

import vm/values/value

#=======================================
# Iterators
#=======================================

iterator items*(rng: VRange): Value =
    let rLen = rng.len
    let numeric = rng.numeric

    let step = 
        if rng.forward: rng.step
        else: -1 * rng.step

    var j = rng.start
    var i = 0
    while i < rLen:
        yield 
            if numeric: newInteger(j)
            else: newChar(char(j))
        j += step
        i += 1

iterator pairs*(rng: VRange): (int,Value) =
    let rLen = rng.len
    let numeric = rng.numeric

    let step = 
        if rng.forward: rng.step
        else: -1 * rng.step

    var j = rng.start
    var i = 0
    while i < rLen:
        yield 
            if numeric: (i, newInteger(j))
            else: (i, newChar(char(j)))
        j += step
        i += 1

#=======================================
# Methods
#=======================================