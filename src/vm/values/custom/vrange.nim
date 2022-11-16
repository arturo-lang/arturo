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
# Constants
#=======================================

const
    InfiniteRange* = 9999888776543210

#=======================================
# Methods
#=======================================

func len*(self: VRange): int64 =
    if self.infinite:
        return InfiniteRange
    else:
        return (1 + abs(self.stop - self.start)) div abs(self.step)

func reversed*(self: VRange): VRange =
    VRange(
        start: self.stop,
        stop: self.start,
        step: self.step,
        infinite: self.infinite,
        numeric: self.numeric,
        forward: not self.forward
    )

#=======================================
# Overloads
#=======================================

func `==`*(a, b: VRange): bool {.inline,enforceNoRaises.} =
    a[] == b[]

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