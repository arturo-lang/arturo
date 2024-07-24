#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/combinatorics.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import helpers/maths

import vm/values/value

import vm/values/operators

#=======================================
# Helpers
#=======================================

# Code adapted from the very interesting contribution 
# by Stefan Salewski here: https://forum.nim-lang.org/t/2812
# Thanks! :)

proc repeatedPermutations(a: ValueArray, n: int): seq[ValueArray] =
    result = newSeq[ValueArray]()
    if n <= 0: return
    for i in 0 .. a.high:
        if n == 1:
            result.add(@[a[i]])
        else:
            for j in repeatedPermutations(a, n - 1):
                result.add(a[i] & j)

proc uniquePermutations(a: ValueArray, n: int, used: var seq[bool]): seq[ValueArray] =
    result = newSeq[ValueArray]()
    if n <= 0: return
    for i in 0 .. a.high:
        if not used[i]:
            if n == 1:
                result.add(@[a[i]])
            else:
                used[i] = true
                for j in uniquePermutations(a, n - 1, used):
                    result.add(a[i] & j)
                used[i] = false

proc repeatedCombinations(a: ValueArray; n: int; used: seq[bool]): seq[ValueArray] =
    result = newSeq[ValueArray]()
    var used = used
    if n <= 0: return
    for i in 0  .. a.high:
        if not used[i]:
            if n == 1:
                result.add(@[a[i]])
            else:
                for j in repeatedCombinations(a, n - 1, used):
                    result.add(a[i] & j)
                used[i] = true

proc uniqueCombinations(a: ValueArray; n: int; used: seq[bool]): seq[ValueArray] =
    result = newSeq[ValueArray]()
    var used = used
    if n <= 0: return
    for i in 0  .. a.high:
        if not used[i]:
            if n == 1:
                result.add(@[a[i]])
            else:
                used[i] = true
                for j in uniqueCombinations(a, n - 1, used):
                    result.add(a[i] & j)

#=======================================
# Methods
#=======================================

func getPermutations*(lst: ValueArray, size: int, repeated: bool = false): seq[ValueArray] =
    if repeated: repeatedPermutations(lst, size)
    else: 
        var used = newSeq[bool](lst.len)
        uniquePermutations(lst, size, used)

func getCombinations*(lst: ValueArray, size: int, repeated: bool = false): seq[ValueArray] =
    var used = newSeq[bool](lst.len)
    if repeated: repeatedCombinations(lst, size, used)
    else: uniqueCombinations(lst, size, used)

proc countPermutations*(lst: ValueArray, size: int, repeated: bool = false): Value =
    let n = lst.len
    if repeated: newInteger(n) ^ newInteger(size)
    else: factorial(n) / factorial(n-size)

proc countCombinations*(lst: ValueArray, size: int, repeated: bool = false): Value =
    let n = lst.len
    if repeated: factorial(n+size-1) / (factorial(size)*factorial(n-1))
    else: factorial(n) / (factorial(size)*factorial(n-size))