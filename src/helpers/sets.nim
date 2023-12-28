#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/sets.nim
#=======================================================

# Contains code based on
# the Sets module: https://github.com/nim-lang/Nim/blob/version-1-6/lib/pure/collections/sets.nim
# which forms part of the Nim standard library.
# (c) Copyright 2012 Andreas Rumpf

#=======================================
# Libraries
#=======================================

import hashes, math

{.pragma: myShallow.}

#=======================================
# Types
#=======================================

type
    KeyValuePair[A] = tuple[hcode: Hash, key: A]
    KeyValuePairSeq[A] = seq[KeyValuePair[A]]
    HashSet*[A] {.myShallow.} = object
        data: KeyValuePairSeq[A]
        counter: int

    OrderedKeyValuePair[A] = tuple[
        hcode: Hash,
        next: int,
        key: A
    ]
    OrderedKeyValuePairSeq[A] = seq[OrderedKeyValuePair[A]]
    OrderedSet*[A] {.myShallow.} = object
        data: OrderedKeyValuePairSeq[A]
        counter, first, last: int
    SomeSet*[A] = HashSet[A] | OrderedSet[A]

#=======================================
# Constants
#=======================================
const
    defaultInitialSize* = 64

#=======================================
# Includes
#=======================================

include setimpl

#=======================================
# Templates
#=======================================

template forAllOrderedPairs(yieldStmt: untyped) {.dirty.} =
    if s.data.len > 0:
        var h = s.first
        var idx = 0
        while h >= 0:
            var nxt = s.data[h].next
            if isFilled(s.data[h].hcode):
                yieldStmt
                inc(idx)
            h = nxt

#=======================================
# Helpers
#=======================================

proc init*[A](s: var HashSet[A], initialSize = defaultInitialSize) =
    initImpl(s, initialSize)

proc init*[A](s: var OrderedSet[A], initialSize = defaultInitialSize) =
    initImpl(s, initialSize)

proc initHashSet*[A](initialSize = defaultInitialSize): HashSet[A] =
    result.init(initialSize)

proc initOrderedSet*[A](initialSize = defaultInitialSize): OrderedSet[A] =
    result.init(initialSize)

proc toHashSet*[A](keys: openArray[A]): HashSet[A] =
    result = initHashSet[A](keys.len)
    for key in items(keys): result.incl(key)

proc toOrderedSet*[A](keys: openArray[A]): OrderedSet[A] =
    result = initOrderedSet[A](keys.len)
    for key in items(keys): result.incl(key)

proc incl*[A](s: var HashSet[A], key: A) =
    inclImpl()

proc incl*[A](s: var OrderedSet[A], key: A) =
    inclImpl()

proc incl*[A](s: var HashSet[A], other: HashSet[A]) =
    for item in other: incl(s, item)

proc incl*[A](s: var HashSet[A], other: OrderedSet[A]) =
    for item in items(other): incl(s, item)

proc incl*[A](s: var OrderedSet[A], other: OrderedSet[A]) =
    for item in items(other): incl(s, item)

proc excl*[A](s: var HashSet[A], key: A) =
    discard exclImpl(s, key)

proc excl*[A](s: var OrderedSet[A], key: A) =
    discard exclImpl(s, key)

proc excl*[A](s: var HashSet[A], other: HashSet[A]) =
    for item in other: discard exclImpl(s, item)

proc contains*[A](s: HashSet[A], key: A): bool =
    var hc: Hash
    var index = rawGet(s, key, hc)
    result = index >= 0

proc contains*[A](s: OrderedSet[A], key: A): bool =
    var hc: Hash
    var index = rawGet(s, key, hc)
    result = index >= 0

proc containsOrIncl*[A](s: var HashSet[A], key: A): bool =
    containsOrInclImpl()

proc containsOrIncl*[A](s: var OrderedSet[A], key: A): bool =
    containsOrInclImpl()

proc missingOrExcl*[A](s: var HashSet[A], key: A): bool =
    exclImpl(s, key)

proc missingOrExcl*[A](s: var OrderedSet[A], key: A): bool =
    exclImpl(s, key)

proc clear*[A](s: var HashSet[A]) =
    s.counter = 0
    for i in 0 ..< s.data.len:
        s.data[i].hcode = 0
        s.data[i].key = default(typeof(s.data[i].key))

proc clear*[A](s: var OrderedSet[A]) =
    s.counter = 0
    s.first = -1
    s.last = -1
    for i in 0 ..< s.data.len:
        s.data[i].hcode = 0
        s.data[i].next = 0
        s.data[i].key = default(typeof(s.data[i].key))

proc len*[A](s: HashSet[A]): int =
    result = s.counter

proc len*[A](s: OrderedSet[A]): int =
    result = s.counter

proc card*[A](s: HashSet[A]): int =
    result = s.counter

proc card*[A](s: OrderedSet[A]): int =
    result = s.counter

#=======================================
# Iterators
#=======================================

iterator items*[A](s: HashSet[A]): A =
    let length = s.len
    for h in 0 .. high(s.data):
        if isFilled(s.data[h].hcode):
            yield s.data[h].key
            assert(len(s) == length, "the length of the HashSet changed while iterating over it")

iterator items*[A](s: OrderedSet[A]): A =
    let length = s.len
    forAllOrderedPairs:
        yield s.data[h].key
        assert(len(s) == length, "the length of the OrderedSet changed while iterating over it")

iterator pairs*[A](s: OrderedSet[A]): tuple[a: int, b: A] =
    let length = s.len
    forAllOrderedPairs:
        yield (idx, s.data[h].key)
        assert(len(s) == length, "the length of the OrderedSet changed while iterating over it")

#=======================================
# Methods
#=======================================

proc map*[A, B](data: HashSet[A], op: proc (x: A): B {.closure.}): HashSet[B] =
    result = initHashSet[B]()
    for item in items(data): result.incl(op(item))

proc map*[A, B](data: OrderedSet[A], op: proc (x: A): B {.closure.}): OrderedSet[B] =
    result = initOrderedSet[B]()
    for item in items(data): result.incl(op(item))

proc pop*[A](s: var HashSet[A]): A =
    for h in 0 .. high(s.data):
        if isFilled(s.data[h].hcode):
            result = s.data[h].key
            excl(s, result)
            return result
    raise newException(KeyError, "set is empty")

proc union*[A](s1, s2: HashSet[A]): HashSet[A] =
    result = s1
    incl(result, s2)

proc union*[A](s1, s2: OrderedSet[A]): OrderedSet[A] =
    result = s1
    incl(result, s2)

proc intersection*[A](s1, s2: HashSet[A]): HashSet[A] =
    result = initHashSet[A](max(min(s1.data.len, s2.data.len), 2))
  
    if s1.data.len < s2.data.len:
        for item in s1:
            if item in s2: incl(result, item)
    else:
        for item in s2:
            if item in s1: incl(result, item)

proc intersection*[A](s1, s2: OrderedSet[A]): OrderedSet[A] =
    result = initOrderedSet[A](max(min(s1.data.len, s2.data.len), 2))
  
    if s1.data.len < s2.data.len:
        for item in s1:
            if item in s2: incl(result, item)
    else:
        for item in s2:
            if item in s1: incl(result, item)
  
proc difference*[A](s1, s2: HashSet[A]): HashSet[A] =
    result = initHashSet[A]()
    for item in s1:
        if not contains(s2, item):
            incl(result, item)

proc difference*[A](s1, s2: OrderedSet[A]): OrderedSet[A] =
    result = initOrderedSet[A]()
    for item in s1:
        if not contains(s2, item):
            incl(result, item)

proc symmetricDifference*[A](s1, s2: HashSet[A]): HashSet[A] =
    result = s1
    for item in s2:
        if containsOrIncl(result, item): excl(result, item)

proc symmetricDifference*[A](s1, s2: OrderedSet[A]): OrderedSet[A] =
    result = s1
    for item in s2:
        if containsOrIncl(result, item): excl(result, item)

proc disjoint*[A](s1, s2: HashSet[A]): bool =
    for item in s1:
        if item in s2: return false
    return true

proc disjoint*[A](s1, s2: OrderedSet[A]): bool =
    for item in s1:
        if item in s2: 
            return false
    return true

proc powerset*[A](s: HashSet[A]): HashSet[HashSet[A]] =
    result.incl(initHashSet[A]())
    for val in s:
        let previous = result
        for aSet in previous:
            var newSet = aSet
            newSet.incl(val)
            result.incl(newSet)

proc powerset*[A](s: OrderedSet[A]): OrderedSet[OrderedSet[A]] =
    result.incl(initOrderedSet[A]())
    for val in s:
        let previous = result
        for aSet in previous:
            var newSet = aSet
            newSet.incl(val)
            result.incl(newSet)

#=======================================
# Overloads
#=======================================

proc `[]`*[A](s: var HashSet[A], key: A): var A =
    var hc: Hash
    var index = rawGet(s, key, hc)
    if index >= 0: result = s.data[index].key
    else:
        when compiles($key):
            raise newException(KeyError, "key not found: " & $key)
        else:
            raise newException(KeyError, "key not found")

proc `[]`*[A](s: var OrderedSet[A], key: A): var A =
    var hc: Hash
    var index = rawGet(s, key, hc)
    if index >= 0: result = s.data[index].key
    else:
        when compiles($key):
            raise newException(KeyError, "key not found: " & $key)
        else:
            raise newException(KeyError, "key not found")

proc `+`*[A](s1, s2: HashSet[A]): HashSet[A] {.inline.} =
    result = union(s1, s2)

proc `+`*[A](s1, s2: OrderedSet[A]): OrderedSet[A] {.inline.} =
    result = union(s1, s2)

proc `*`*[A](s1, s2: HashSet[A]): HashSet[A] {.inline.} =
    result = intersection(s1, s2)

proc `*`*[A](s1, s2: OrderedSet[A]): OrderedSet[A] {.inline.} =
    result = intersection(s1, s2)

proc `-`*[A](s1, s2: HashSet[A]): HashSet[A] {.inline.} =
    result = difference(s1, s2)

proc `-`*[A](s1, s2: OrderedSet[A]): OrderedSet[A] {.inline.} =
    result = difference(s1, s2)

proc `-+-`*[A](s1, s2: HashSet[A]): HashSet[A] {.inline.} =
    result = symmetricDifference(s1, s2)

proc `-+-`*[A](s1, s2: OrderedSet[A]): OrderedSet[A] {.inline.} =
    result = symmetricDifference(s1, s2)

proc `==`*[A](s, t: HashSet[A]): bool =
    s.counter == t.counter and s <= t

proc `==`*[A](s, t: OrderedSet[A]): bool =
    if s.counter != t.counter: return false
    var h = s.first
    var g = t.first
    var compared = 0
    while h >= 0 and g >= 0:
        var nxh = s.data[h].next
        var nxg = t.data[g].next
        if isFilled(s.data[h].hcode) and isFilled(t.data[g].hcode):
            if s.data[h].key == t.data[g].key:
                inc compared
            else:
                return false
        h = nxh
        g = nxg
    result = compared == s.counter

proc `<`*[A](s, t: HashSet[A]): bool =
    s.counter != t.counter and s <= t

proc `<`*[A](s, t: OrderedSet[A]): bool =
    s.counter != t.counter and s <= t

proc `<=`*[A](s, t: HashSet[A]): bool =
    result = false
    if s.counter > t.counter: return
    result = true
    for item in items(s):
        if not(t.contains(item)):
            result = false
            return

proc `<=`*[A](s, t: OrderedSet[A]): bool =
    result = false
    if s.counter > t.counter: return
    result = true
    for item in s:
        if not(t.contains(item)):
            result = false
            return

proc hash*[A](s: HashSet[A]): Hash =
    for h in 0 .. high(s.data):
        result = result xor s.data[h].hcode
    result = !$result

proc hash*[A](s: OrderedSet[A]): Hash =
    forAllOrderedPairs:
        result = result !& s.data[h].hcode
    result = !$result

proc `$`*[A](s: HashSet[A]): string =
    dollarImpl()

proc `$`*[A](s: OrderedSet[A]): string =
    dollarImpl()