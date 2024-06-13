#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/custom/vversion.nim
#=======================================================

## The internal `:version` type

#=======================================
# Libraries
#=======================================

import strformat, strutils

#=======================================
# Types
#=======================================

type
    VVersion* = ref object
        major*      : int
        minor*      : int
        patch*      : int
        prerelease* : string
        extra*      : string

#=======================================
# Overloads
#=======================================

func `==`*(a, b: VVersion): bool {.inline.} =
    a[] == b[]

func `<`*(a, b: VVersion): bool {.inline.} =
    a.major < b.major or (a.major == b.major and (
        a.minor < b.minor or
        (a.minor == b.minor and (
            a.patch < b.patch or (
                a.patch == a.patch and 
                    ((a.prerelease != "" and b.prerelease == "") or 
                     (a.prerelease < b.prerelease))
            ))
        )
    ))

func `>`*(a, b: VVersion): bool {.inline.} =
    a.major > b.major or (a.major == b.major and (
        a.minor > b.minor or
        (a.minor == b.minor and (
            a.patch > b.patch or (
                a.patch == a.patch and 
                    ((a.prerelease == "" and b.prerelease != "") or 
                     (a.prerelease > b.prerelease))
            ))
        )
    ))

proc cmp*(x: VVersion, y: VVersion): int {.inline.}=
    if x < y:
        return -1
    elif x > y:
        return 1
    else:
        return 0

func `$`*(v: VVersion): string {.inline.} =
    fmt("{v.major}.{v.minor}.{v.patch}{v.prerelease}{v.extra}")
    
func newVVersion*(v: string): VVersion =
    var numPart: string
    var prereleasePart: string
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

    if extraPart[0] == '-':
        let subparts = extraPart.split("+")
        prereleasePart = subparts[0]
        if subparts.len > 1:
            extraPart = "+" & subparts[1]
        else:
            extraPart = ""

    let parts: seq[string] = numPart.split(".")

    result = VVersion(
        major: parseInt(parts[0]),
        minor: parseInt(parts[1]),
        patch: parseInt(parts[2]),
        prerelease: prereleasePart,
        extra: extraPart
    )

    echo "new version:"
    echo $result[]