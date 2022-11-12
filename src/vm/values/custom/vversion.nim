#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/custom/vversion.nim
#=======================================================

## The internal `:version` type

#=======================================
# Libraries
#=======================================

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
    return a.major == b.major and 
           a.minor == b.minor and 
           a.patch == b.patch and 
           a.extra == b.extra

func `<`*(a, b: VVersion): bool {.inline,enforceNoRaises.} =
    if a.major < b.major:
        return true
    elif a.major == b.major:
        if a.minor < b.minor:
            return true
        elif a.minor == b.minor:
            if a.patch < b.patch:
                return true
    return false

func `>`*(a, b: VVersion): bool {.inline,enforceNoRaises.} =
    if a.major > b.major:
        return true
    elif a.major == b.major:
        if a.minor > b.minor:
            return true
        elif a.minor == b.minor:
            if a.patch > b.patch:
                return true
    return false

