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

proc sub2to1*(a: var ByteArray, subA: OpCode, subB: OpCode, replacement: OpCode) =
    var i = 0
    var cntr = 0
    let aLen = a.len
    while i < aLen-2+1:
        let diffA = a[i] - (Byte)(subA)
        if diffA >= 0 and diffA <= 29 and diffA == a[i+1] - (Byte)(subB):
            a[i] = (Byte)(replacement) + diffA
            a[i+1] = (Byte)255
            cntr.inc()
            i.inc()
        i.inc()
    a.keepIf((item) => item != (Byte)255)

proc substitute2to1*(a: ByteArray, subA: OpCode, subB: OpCode, replacement: OpCode): ByteArray =
    var i = 0
    var cntr = 0
    let aLen = a.len
    newSeq(result, aLen)
    while i < aLen-2+1:
        let diffA = a[i] - (Byte)(subA)
        if diffA >= 0 and diffA <= 29 and diffA == a[i+1] - (Byte)(subB):
            result[cntr] = (Byte)(replacement) + diffA
            cntr.inc()
            i.inc(2)
        else:
            result[cntr] = a[i]
            cntr.inc()
            i.inc(1)
    let rest = a[i..^1]
    for j,it in rest:
        result[cntr+j] = it
    result.setLen(cntr + rest.len)

proc numberToBinary*(i: int | float): ByteArray =
    if i==0: return @[(byte)0]
    var bytes = toSeq(cast[array[0..7, byte]](i)).reversed
    var i=0
    while i < bytes.len and bytes[i] == 0:
        i += 1
    while i < bytes.len:
        result.add(bytes[i])
        i += 1