#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/custom/vversion.nim
#=======================================================

## The internal `:version` type

#=======================================
# Libraries
#=======================================

import parseutils, strformat, strutils

#=======================================
# Types
#=======================================

type
    VVersion* = ref object
        major*   : int
        minor*   : int
        patch*   : int
        extra*   : string

#=======================================
# Overloads
#=======================================

func `==`*(a, b: VVersion): bool {.inline,enforceNoRaises.} =
    a[] == b[]

func `<`*(a, b: VVersion): bool {.inline,enforceNoRaises.} =
    a.major < b.major or (a.major == b.major and (
        a.minor < b.minor or
        (a.minor == b.minor and a.patch < b.patch)
    ))

func `>`*(a, b: VVersion): bool {.inline,enforceNoRaises.} =
    a.major > b.major or (a.major == b.major and (
        a.minor > b.minor or
        (a.minor == b.minor and a.patch > b.patch)
    ))

func `$`*(v: VVersion): string {.inline,enforceNoRaises.} =
    fmt("{v.major}.{v.minor}.{v.patch}{v.extra}")
    
func newVVersion(v: string): VVersion =
    var numPart: string
    var extraPart: string
    var lastIndex : int
    for i, c in v:
        lastIndex = i
        if c notin {'+','-'}:
            numPart.add(c)
        else:
            extraPart &= c
            break

    extraPart &= v[lastIndex+1 .. ^1]

    let parts: seq[string] = numPart.split(".")

    return VVersion(
        major: parseInt(parts[0]),
        minor: parseInt(parts[1]),
        patch: parseInt(parts[2]),
        extra: extraPart
    )