#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/fiber.nim
#=======================================================

## Stackful coroutine primitive built on vendored
## [minicoro](src/extras/minicoro/minicoro.h). No scheduler — just
## `createFiber` / `resume` / `suspend` / `destroyFiber`. The scheduler
## that drives these on top of `asyncdispatch` lives separately
## (Phase 3, `helpers/scheduler.nim`).
##
## Asymmetric coroutines: from the main thread you `resume(f)` a
## fiber; from inside the fiber, `suspend()` yields back to whoever
## resumed it. Switching A → B (both fibers) is two hops:
## `suspend()` from A back to main, then `resume(B)` from main.

#=======================================
# Libraries
#=======================================

{.compile: "../extras/minicoro/minicoro.c".}

#=======================================
# Constants
#=======================================

const
    DefaultFiberStackSize* = 256 * 1024
        ## 256KB per CONCURRENCY_NOTES.md — comfortable for moderately
        ## recursive Arturo functions, far more than minicoro's own
        ## 56KB default. Configurable per-fiber via `createFiber`.

#=======================================
# Types
#=======================================

type
    McoState {.importc: "mco_state", header: "minicoro/minicoro.h".} = enum
        mcoDead = 0, mcoNormal, mcoRunning, mcoSuspended

    McoResult {.importc: "mco_result", header: "minicoro/minicoro.h".} = enum
        mcoSuccess = 0
        mcoGenericError, mcoInvalidPointer, mcoInvalidCoroutine
        mcoNotSuspended, mcoNotRunning
        mcoMakeContextError, mcoSwitchContextError
        mcoNotEnoughSpace, mcoOutOfMemory, mcoInvalidArguments
        mcoInvalidOperation, mcoStackOverflow

    McoCoro {.importc: "mco_coro", header: "minicoro/minicoro.h",
              incompleteStruct.} = object
        ## Opaque struct — declared so the C signature for entry
        ## functions and FFI procs uses `mco_coro*`, not `void*`.
        ## We never inspect the layout from Nim.

    FiberHandle* = ptr McoCoro
        ## Raw minicoro handle. Exposed so the scheduler (Phase 3)
        ## can identify the running fiber without going through the
        ## `Fiber` ref wrapper.

    McoEntry = proc (co: FiberHandle) {.cdecl.}

    McoDesc {.importc: "mco_desc", header: "minicoro/minicoro.h", bycopy.} = object
        # Layout has to match minicoro.h exactly. Keep this in sync if
        # we ever bump the vendored version.
        fn {.importc: "func".}: McoEntry
        userData {.importc: "user_data".}: pointer
        allocCb {.importc: "alloc_cb".}: pointer
        deallocCb {.importc: "dealloc_cb".}: pointer
        allocatorData {.importc: "allocator_data".}: pointer
        storageSize {.importc: "storage_size".}: csize_t
        coroSize {.importc: "coro_size".}: csize_t
        stackSize {.importc: "stack_size".}: csize_t

    Fiber* = ref object
        ## Owns the underlying `mco_coro` and the entry closure.
        ## Held as a Nim `ref` so the closure environment stays alive
        ## as long as the fiber does.
        handle: FiberHandle
        entry: proc ()

#=======================================
# Raw FFI
#=======================================

proc mco_desc_init(fn: McoEntry, stackSize: csize_t): McoDesc
    {.importc, header: "minicoro/minicoro.h".}

proc mco_create(outCo: ptr FiberHandle, desc: ptr McoDesc): McoResult
    {.importc, header: "minicoro/minicoro.h".}

proc mco_destroy(co: FiberHandle): McoResult
    {.importc, header: "minicoro/minicoro.h".}

proc mco_resume(co: FiberHandle): McoResult
    {.importc, header: "minicoro/minicoro.h".}

proc mco_yield(co: FiberHandle): McoResult
    {.importc, header: "minicoro/minicoro.h".}

proc mco_status(co: FiberHandle): McoState
    {.importc, header: "minicoro/minicoro.h".}

proc mco_running(): FiberHandle
    {.importc, header: "minicoro/minicoro.h".}

proc mco_get_user_data(co: FiberHandle): pointer
    {.importc, header: "minicoro/minicoro.h".}

proc mco_result_description(res: McoResult): cstring
    {.importc, header: "minicoro/minicoro.h".}

#=======================================
# Helpers
#=======================================

proc check(res: McoResult, op: string) {.inline.} =
    if res != mcoSuccess:
        raise newException(CatchableError,
            "fiber " & op & " failed: " & $mco_result_description(res))

proc trampoline(co: FiberHandle) {.cdecl.} =
    # Single C-callable entry. Pulls the Fiber ref back out of
    # user_data, then calls the Nim closure stored on it.
    let f = cast[Fiber](mco_get_user_data(co))
    f.entry()

#=======================================
# Public API
#=======================================

proc createFiber*(entry: proc (), stackSize: int = DefaultFiberStackSize): Fiber =
    ## Create a new suspended fiber. The first `resume` call will
    ## start running `entry` on a fresh stack of `stackSize` bytes.
    ## When `entry` returns, the fiber transitions to `mcoDead` and
    ## must be cleaned up with `destroyFiber`.
    result = Fiber(entry: entry)
    GC_ref(result)  # keep alive while minicoro holds the user_data ptr
    var desc = mco_desc_init(trampoline, csize_t(stackSize))
    desc.userData = cast[pointer](result)
    var co: FiberHandle
    check(mco_create(addr co, addr desc), "create")
    result.handle = co

proc destroyFiber*(f: Fiber) =
    ## Release the fiber's stack and internal struct. Safe only when
    ## the fiber is suspended or dead — calling this on a running
    ## fiber is a programming error and minicoro will report it.
    if f.handle != nil:
        check(mco_destroy(f.handle), "destroy")
        f.handle = nil
        GC_unref(f)

proc resume*(f: Fiber) {.inline.} =
    ## Resume `f` until it suspends or finishes. Must be called from
    ## a context that is *not* itself running on `f`'s stack.
    check(mco_resume(f.handle), "resume")

proc suspend*() {.inline.} =
    ## Yield execution from the currently running fiber back to its
    ## resumer. Must be called from inside a fiber's entry chain.
    check(mco_yield(mco_running()), "suspend")

proc isDone*(f: Fiber): bool {.inline.} =
    ## True once the fiber's entry proc has returned.
    mco_status(f.handle) == mcoDead

proc currentFiber*(): FiberHandle {.inline.} =
    ## The minicoro handle for the currently running fiber, or `nil`
    ## if called from the main thread (no fiber active).
    mco_running()
