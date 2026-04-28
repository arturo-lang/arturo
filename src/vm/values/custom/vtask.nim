#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/values/custom/vtask.nim
#=======================================================

## The internal `:task` type

#=======================================
# Libraries
#=======================================

import hashes

#=======================================
# Types
#=======================================

type
    VTaskState* = enum
        taskPending
        taskDone
        taskFailed
        taskCancelled

    VTask* = ref object
        state*  : VTaskState
        result* : pointer       # filled-in once state == taskDone (a `Value`, kept opaque here to avoid a cyclic import)
        error*  : pointer       # filled-in once state == taskFailed (an Error `Value`)

#=======================================
# Overloads
#=======================================

proc hash*(t: VTask): Hash {.inline.} =
    cast[Hash](cast[uint](t))

func `$`*(t: VTask): string =
    case t.state
        of taskPending  : "<task:pending>"
        of taskDone     : "<task:done>"
        of taskFailed   : "<task:failed>"
        of taskCancelled: "<task:cancelled>"

#=======================================
# Methods
#=======================================

proc initTask*(): VTask {.inline.} =
    VTask(state: taskPending)
