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
    RangeDirection* = enum
        Forward
        Backward

    GenericRange[T] = ref object
        start*      : T
        stop*       : T
        step*       : T
        infinite*   : bool
        dir*        : RangeDirection

    VRange* = GenericRange[int]

#=======================================
# Overloads
#=======================================

func `$`*(v: VRange): string {.inline,enforceNoRaises.} =
    let start = $(v.start)
    var stop: string
    if v.infinite: stop = "∞"
    else: stop = $(v.stop)
    result = start & ".." & stop

    if v.step != 1:
        result &= " (" & $(v.step) & ")"