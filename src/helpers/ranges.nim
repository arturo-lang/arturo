#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
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


proc contains*(rng: VRange, v: Value): bool {.inline,enforceNoRaises.} =
    rng.find(v) >= 0

func min*(rng: VRange): (int,Value) {.inline,enforceNoRaises.} =
    if rng.forward: 
        return (0, getValueForRangeItem(rng, rng.start))
    else:
        if rng.infinite: return (0, newFloating(NegInf))

        let rHigh = int(rng.len - 1)
        let lastItem = rng.start - rng.step * rHigh
        return (rHigh, getValueForRangeItem(rng, lastItem))

func max*(rng: VRange): (int,Value) {.inline,enforceNoRaises.} =
    if rng.forward: 
        if rng.infinite: return (0, newFloating(Inf))

        let rHigh = int(rng.len - 1)
        let lastItem = rng.start + rng.step * rHigh
        return (rHigh, getValueForRangeItem(rng, lastItem))
    else:
        return (0, getValueForRangeItem(rng, rng.start))
