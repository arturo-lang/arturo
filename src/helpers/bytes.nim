######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/bytes.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, sugar

import vm/opcodes

#=======================================
# Types
#=======================================

type
    Byte* = byte
    ByteArray*  = seq[Byte]

#=======================================
# Overloads
#=======================================

proc `and`*(a: ByteArray, b: ByteArray): ByteArray =
    zip(a, b).map((tup) => tup[0] and tup[1])

proc `or`*(a: ByteArray, b: ByteArray): ByteArray =
    zip(a, b).map((tup) => tup[0] or tup[1])

proc `xor`*(a: ByteArray, b: ByteArray): ByteArray =
    zip(a, b).map((tup) => tup[0] xor tup[1])

proc `not`*(a: ByteArray): ByteArray =
    a.map((w) => not w)

#=======================================
# Methods
#=======================================

proc substitute*(a: ByteArray, needle: ByteArray, replacement: ByteArray): ByteArray =
    var i = 0
    let aLen = a.len
    let needleLen = needle.len
    while i < aLen-needleLen+1:
        if a[i..i+needleLen-1] == needle:
            result.add(replacement)
            i += needleLen
        else:
            result.add(a[i])
            i = i + 1
    result.add(a[i..^1])

# TODO(Helpers/bytes) `substitute2to1r` needs some thorough cleanup & testing
#  preferrably, it should work in-place, that is: with a *var*
#  labels: vm, bytecode, benchmark, performance, enhancement, cleanup
proc substitute2to1r*(a: ByteArray, subA: OpCode, subB: OpCode, replacement: OpCode): ByteArray =
    var i = 0
    let aLen = a.len
    # let rOne = one..(one+29)
    # let rTwo = two..(two+29)
    while i < aLen-2+1:
        let diffA = a[i] - (Byte)(subA)
        if diffA >= 0 and diffA <= 29 and diffA == a[i+1] - (Byte)(subB):

        # if diffA == diffB and diffA>=0 and diffB <= 29:
        # # if a[i] in rOne and a[i+1] in rTwo and (a[i]-one == a[i+1]-two):
            result.add((Byte)(replacement) + diffA)
            i.inc(2)
            #i += 2
        else:
            result.add(a[i])
            i.inc(1)
            #i = i + 1
    result.add(a[i..^1])

proc numberToBinary*(i: int | float): ByteArray =
    if i==0: return @[(byte)0]
    var bytes = toSeq(cast[array[0..7, byte]](i)).reversed
    var i=0
    while i < bytes.len and bytes[i] == 0:
        i += 1
    while i < bytes.len:
        result.add(bytes[i])
        i += 1