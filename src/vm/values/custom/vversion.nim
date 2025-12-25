#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
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

# #=======================================
# # Helpers
# #=======================================

func isNumeric(s: string): bool =
    result = true

    for c in s:
        if not isDigit(c):
            return false

#=======================================
# Overloads
#=======================================

func cmp*(x: VVersion, y: VVersion): int {.inline.} =
    if (let cmpMajor = cmp(x.major, y.major); cmpMajor != 0):
        return cmpMajor

    if (let cmpMinor = cmp(x.minor, y.minor); cmpMinor != 0):
        return cmpMinor

    if (let cmpPatch = cmp(x.patch, y.patch); cmpPatch != 0):
        return cmpPatch

    let 
        lX = len(x.prerelease)
        lY = len(y.prerelease)

    if lX == 0 and lY == 0: 
        return 0
    elif lX == 0 and lY > 0: 
        return 1
    elif lX > 0 and lY == 0:
        return -1
    else:
        var
            i = 0
            preX = split(x.prerelease, ".")
            preY = split(y.prerelease, ".")
            comp: int

        while i < len(preX) and i < len(preY):
            comp = 
                if isNumeric(preX[i]) and isNumeric(preY[i]):
                    cmp(parseInt(preX[i]), parseInt(preY[i]))
                else:
                    cmp(preX[i], preY[i])

            if comp != 0:
                return comp
            else:
                i = i + 1

        if i == len(preX) and i == len(preY): 
            return 0
        elif i == len(preX) and i < len(preY): 
            return -1
        else: 
            return 1

func `==`*(a, b: VVersion): bool {.inline.} =
    cmp(a,b) == 0

func `<`*(a, b: VVersion): bool {.inline.} =
    cmp(a,b) == -1

func `>`*(a, b: VVersion): bool {.inline.} =
    cmp(a,b) == 1

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