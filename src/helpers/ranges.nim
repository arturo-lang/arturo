#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/ranges.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import vm/values/custom/vrange

import vm/values/comparison
import vm/values/value

#=======================================
# Templates
#=======================================

template getValueForRangeItem(rng: VRange, item: int): Value =
    if rng.numeric: newInteger(item)
    else: newChar(char(item))

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

proc nextItem*(rng: VRange): iterator(): Value =
    return iterator(): Value =
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

func `[]`*(rng: VRange, idx: int): Value =
    for (i, item) in pairs(rng):
        if i == idx: return item

    raise newException(ValueError, "Index out of range")

func `[]`*(rng: VRange, idx: HSlice): ValueArray =
    let numeric = rng.numeric

    let step = 
        if rng.forward: rng.step
        else: -1 * rng.step

    var start = rng.start + step*idx.a
    var i = idx.a
    while i <= idx.b:
        result.add(
            if numeric: newInteger(start)
            else: newChar(char(start))
        )
        start += step
        i += 1
        
        
func `[]`*(rng: VRange, idx: int, returnValue: bool): Value =
    
    if idx > rng.len or idx < 0: 
        raise newException(ValueError, "Index out of range!!")

    let step = 
        if rng.forward: rng.step
        else: -1 * rng.step
    
    return 
        if rng.numeric: newInteger(rng.start + step*(idx - 1))
        else: newChar(char(rng.start + step*(idx - 1)))
    
    
        
func `[]`*(rng: VRange, idx: HSlice, returnValue: bool): VRange =
    
    if idx.a > rng.len or idx.b > rng.len or idx.a < 0 or idx.b < 0: 
        raise newException(ValueError, "Index out of range!!")

    let step = 
        if rng.forward: rng.step
        else: -1 * rng.step

    var start = rng.start + step*idx.a
    var stop = rng.start + step*(idx.b-1)
    
    return VRange(
            start:      start,
            stop:       stop,
            step:       rng.step,
            infinite:   rng.infinite,
            numeric:    rng.numeric,
            forward:    rng.forward
        )

template arithmeticProgressionContains(target, start, step): bool =
    ## Mathematical definiton:
    ## 
    ## Given an arithmetic progression defined as:
    ## a, a + d, a + 2d, a + 3d, ...
    ## 
    ## When we want to check if a number x is part of this progression, 
    ## we need to determine if there exists an integer n such that:
    ## 
    ## (x - a) / d ∈ Z

    (target - start) mod step == 0

template forwardContains(rng: VRange, v: int): bool =
    if rng.infinite:
        v >= rng.start and arithmeticProgressionContains(v, rng.start, rng.step)
    else:
        v >= rng.start and v <= rng.stop and arithmeticProgressionContains(v, rng.start, rng.step)

template backwardContains(rng: VRange, v: int): bool =
    if rng.infinite:
        v <= rng.start and arithmeticProgressionContains(v, rng.start, rng.step)
    else:
        v <= rng.start and v >= rng.stop and arithmeticProgressionContains(v, rng.start, rng.step)


proc contains*(rng: VRange, v: Value): bool {.inline.} =
    let value: int = if rng.numeric: 
        v.i
    else: 
        int(ord(v.c))

    if rng.forward:
        forwardContains(rng, value)
    else:
        backwardContains(rng, value)

func min*(rng: VRange): (int,Value) {.inline.} =
    if rng.forward: 
        return (0, getValueForRangeItem(rng, rng.start))
    else:
        if rng.infinite: return (0, newFloating(NegInf))

        let rHigh = int(rng.len - 1)
        let lastItem = rng.start - rng.step * rHigh
        return (rHigh, getValueForRangeItem(rng, lastItem))

func max*(rng: VRange): (int,Value) {.inline.} =
    if rng.forward: 
        if rng.infinite: return (0, newFloating(Inf))

        let rHigh = int(rng.len - 1)
        let lastItem = rng.start + rng.step * rHigh
        return (rHigh, getValueForRangeItem(rng, lastItem))
    else:
        return (0, getValueForRangeItem(rng, rng.start))
