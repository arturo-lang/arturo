######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/arrays.nim
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

func removeFirst*(str: string, what: string): string =
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

func removeByIndex*(arr: ValueArray, index: int): ValueArray =
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

func removeAll*(str: string, what: Value): string =
    if what.kind == String:
        return str.replace(what.s)
    elif what.kind == Char:
        return str.replace($(what.c))
    else:
        result = str

        for item in what.a:
            if item.kind == String:
                result = result.replace(item.s)
            elif item.kind == Char:
                result = result.replace($(item.c))

proc powerset*(s: HashSet[Value]): HashSet[HashSet[Value]] =
    result.incl(initHashSet[Value]())  # Initialized with empty set.
    for val in s:
        let previous = result
        for aSet in previous:
            var newSet = aSet
            newSet.incl(val)
            result.incl(newSet)

proc safeRepeat*(v: Value, times: int): ValueArray =
    result = newSeq[Value](times)
    for i in 0 ..< times:
        result[i] = copyValue(v)

proc safeCycle*(va: ValueArray, times: int): ValueArray =
    result = newSeq[Value](times * va.len)
    var o = 0
    for i in 0 ..< times:
        for e in va: 
            result[o] = copyValue(e)
            inc o

proc isSorted*(s: ValueArray, ascending: bool = true): bool =
    if s.len == 0: return true
    var last = s[0]
    if ascending:
        for c in s:
            if c < last:
                return false
            last = c
    else:
        for c in s:
            if c > last:
                return false
            last = c
    return true

proc deduplicated*[T](s: openArray[T], isSorted: bool = false): seq[T] =
  result = @[]
  if s.len > 0:
    if isSorted:
      var prev = s[0]
      result.add(prev)
      for i in 1..s.high:
        if s[i] != prev:
          prev = s[i]
          result.add(prev)
    else:
      for itm in items(s):
        if not result.contains(itm): result.add(itm)
