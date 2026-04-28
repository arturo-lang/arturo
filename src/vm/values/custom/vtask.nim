#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/values/custom/vtask.nim
#=======================================================

## State enum for the `:task` value.
## The `VTask` object itself lives in `vm/values/types.nim`,
## since it needs to refer back to `Value` (via `Future[Value]`).

#=======================================
# Types
#=======================================

type
    VTaskState* = enum
        taskPending
        taskDone
        taskFailed
        taskCancelled
