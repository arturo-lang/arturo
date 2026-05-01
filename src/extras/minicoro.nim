#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: extras/minicoro.nim
#=======================================================

## Raw FFI bindings to the vendored
## [minicoro](minicoro/minicoro.h) v0.2.0 — a single-header,
## cross-platform stackful coroutine primitive.
##
## This module exposes only the C API as Nim sees it. Higher-level
## operations (typed `Fiber`, closure trampoline, `resume` / `suspend`
## helpers) live in [`helpers/parallelism`](../helpers/parallelism.nim).

{.compile: "minicoro/minicoro.c".}

#=======================================
# Types
#=======================================

type
    McoState* {.importc: "mco_state", header: "minicoro/minicoro.h".} = enum
        mcoDead = 0, mcoNormal, mcoRunning, mcoSuspended

    McoResult* {.importc: "mco_result", header: "minicoro/minicoro.h".} = enum
        mcoSuccess = 0
        mcoGenericError, mcoInvalidPointer, mcoInvalidCoroutine
        mcoNotSuspended, mcoNotRunning
        mcoMakeContextError, mcoSwitchContextError
        mcoNotEnoughSpace, mcoOutOfMemory, mcoInvalidArguments
        mcoInvalidOperation, mcoStackOverflow

    McoCoro* {.importc: "mco_coro", header: "minicoro/minicoro.h",
               incompleteStruct.} = object
        ## Opaque struct — declared so the C signature for entry
        ## functions and FFI procs uses `mco_coro*`, not `void*`.
        ## We never inspect the layout from Nim.

    McoCoroPtr* = ptr McoCoro

    McoEntry* = proc (co: McoCoroPtr) {.cdecl.}

    McoDesc* {.importc: "mco_desc", header: "minicoro/minicoro.h",
               bycopy.} = object
        # Layout has to match minicoro.h exactly. Keep this in sync if
        # we ever bump the vendored version.
        fn* {.importc: "func".}: McoEntry
        userData* {.importc: "user_data".}: pointer
        allocCb* {.importc: "alloc_cb".}: pointer
        deallocCb* {.importc: "dealloc_cb".}: pointer
        allocatorData* {.importc: "allocator_data".}: pointer
        storageSize* {.importc: "storage_size".}: csize_t
        coroSize* {.importc: "coro_size".}: csize_t
        stackSize* {.importc: "stack_size".}: csize_t

#=======================================
# FFI
#=======================================

proc mco_desc_init*(fn: McoEntry, stackSize: csize_t): McoDesc
    {.importc, header: "minicoro/minicoro.h".}

proc mco_create*(outCo: ptr McoCoroPtr, desc: ptr McoDesc): McoResult
    {.importc, header: "minicoro/minicoro.h".}

proc mco_destroy*(co: McoCoroPtr): McoResult
    {.importc, header: "minicoro/minicoro.h".}

proc mco_resume*(co: McoCoroPtr): McoResult
    {.importc, header: "minicoro/minicoro.h".}

proc mco_yield*(co: McoCoroPtr): McoResult
    {.importc, header: "minicoro/minicoro.h".}

proc mco_status*(co: McoCoroPtr): McoState
    {.importc, header: "minicoro/minicoro.h".}

proc mco_running*(): McoCoroPtr
    {.importc, header: "minicoro/minicoro.h".}

proc mco_get_user_data*(co: McoCoroPtr): pointer
    {.importc, header: "minicoro/minicoro.h".}

proc mco_result_description*(res: McoResult): cstring
    {.importc, header: "minicoro/minicoro.h".}
