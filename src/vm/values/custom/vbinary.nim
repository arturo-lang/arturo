#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/custom/vbinary.nim
#=======================================================

## The internal `:binary` type

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, strformat
import strutils, sugar

#=======================================
# Types
#=======================================

type 
    Byte* = byte
    VBinary*  = seq[Byte]
    
#=======================================
# Helpers
#=======================================

template loopOp(a, b: VBinary, op: untyped) =
    if 0 notin [a.len, b.len]:
        result = newSeq[byte](min(a.high, b.high))
        for i in 0..result.high:
            result[i] = op(a[i], b[i])

#=======================================
# Overloads
#=======================================

proc `and`*(a, b: VBinary): VBinary =
    loopOp(a, b, `and`)

proc `or`*(a: VBinary, b: VBinary): VBinary =
    loopOp(a, b, `or`)

proc `xor`*(a: VBinary, b: VBinary): VBinary =
    loopOp(a, b, `xor`)

proc `not`*(a: VBinary): VBinary =
    a.map((w) => not w)

func `$`*(a: VBinary): string =
    a.map((child) => fmt"{child:02X}").join(" ")

#=======================================
# Methods
#=======================================

proc substitute*(a: VBinary, needle: VBinary, replacement: VBinary): VBinary =
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

proc numberToBinary*(i: int | float): VBinary =
    if i==0: return @[byte(0)]
    var bytes = toSeq(cast[array[0..7, byte]](i)).reversed
    var i=0
    while i < bytes.len and bytes[i] == 0:
        i += 1
    while i < bytes.len:
        result.add(bytes[i])
        i += 1
