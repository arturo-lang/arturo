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

proc substitute2to1r*(a: ByteArray, sub: tuple[a: OpCode, b: OpCode], replacement: OpCode): ByteArray =
    var i = 0
    let aLen = a.len
    let one = (Byte)(sub.a)
    let two = (Byte)(sub.b)
    let rOne = one..(one+29)
    let rTwo = two..(two+29)
    while i < aLen-2+1:
        if a[i] in rOne and a[i+1] in rTwo and (a[i]-one == a[i+1]-two):
            result.add((Byte)(replacement) + a[i]-one)
            i += 2
        else:
            result.add(a[i])
            i = i + 1
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