######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/arrays.nim
######################################################

#=======================================
# Libraries
#=======================================

import strutils, tables

import vm/value

#=======================================
# Methods
#=======================================

# TODO(Helpers\arrays) verify/debug implementation for flattened
#  labels: library, helpers, bug
proc flattened*(v: Value,once = false,level = 0): Value =
    result = newBlock()

    for item in v.a:
        if item.kind==Block and ((not once) or (once and level==0)):
            for subitem in flattened(item,once,level+1).a:
                result.a.add(subitem)
        else:
            result.a.add(item)

proc removeFirst*(str: string, what: string): string =
    let rng = str.find(what)
    if rng != -1:
        result = str[0..rng-1] & str[(rng+what.len)..^1]
    else:
        result = str

proc removeFirst*(arr: ValueArray, what: Value): ValueArray =
    result = @[]
    var searching = true
    for v in arr:
        if searching and v==what:
            searching = false
        else:
            result.add(v)

proc removeAll*(arr: ValueArray, what: Value): ValueArray =
    result = @[]
    if what.kind==Block:
        for v in arr:
            if not (v in what.a):
                result.add(v)
    else:
        for v in arr:
            if v!=what:
                result.add(v)

proc removeByIndex*(arr: ValueArray, index: int): ValueArray =
    result = @[]
    for i,v in arr:
        if i!=index:
            result.add(v)

proc removeFirst*(dict: ValueDict, what: Value, key: bool): ValueDict =
    result = initOrderedTable[string,Value]()
    var searching = true
    for k,v in pairs(dict):
        if key:
            if searching and k==what.s:
                searching = false
            else:
                result[k] = v
        else:
            if searching and v==what:
                searching = false
            else:
                result[k] = v

proc removeAll*(dict: ValueDict, what: Value, key: bool): ValueDict =
    result = initOrderedTable[string,Value]()
    for k,v in pairs(dict):
        if key:
            if k!=what.s:
                result[k] = v
        else:
            if v!=what:
                result[k] = v

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