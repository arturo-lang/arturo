#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/custom/vrange.nim
#=======================================================

## The internal `:range` type

#=======================================
# Libraries
#=======================================

#=======================================
# Types
#=======================================

type
    GenericRange[T] = ref object
        start*      : T
        stop*       : T
        step*       : T
        infinite*   : bool
        numeric*    : bool 
        forward*    : bool

    VRange* = GenericRange[int]

#=======================================
# Overloads
#=======================================

func `$`*(v: VRange): string {.inline,enforceNoRaises.} =
    var start: string
    var stop: string

    if v.numeric: start = $(v.start)
    else: start = "`" & $(chr(v.start)) & "`"

    if v.infinite: stop = "∞"
    else: 
        if v.numeric: stop = $(v.stop)
        else: stop = "`" & $(chr(v.stop)) & "`"

    result = start & ".." & stop

    if v.step != 1:
        result &= " (" & $(v.step) & ")"