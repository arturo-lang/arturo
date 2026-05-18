#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/parallelism.nim
#=======================================================

## Helpers for the `:task` value and `.async` builtins.

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import asyncdispatch, asyncfile, asynchttpserver, httpclient, httpcore
    import os, osproc
    import std/tempfiles
    import streams, strtabs, strutils, times
    when defined(posix):
        import posix
    when defined(ssl):
        # std/net has to be qualified — there's a sibling `helpers/net.nim`
        # and Nim resolves bare `net` to it first.
        import std/net as netmod
        import asyncnet
        import extras/smtp

    import extras/minicoro

    import vm/lib
    import vm/[context, exec, parse, stack]
    import vm/values/custom/[vtask, verror]

#=======================================
# Fibers — stackful coroutines on top of vendored minicoro
#=======================================
#
# Asymmetric coroutines: from the main thread you `resume(f)` a
# fiber; from inside the fiber, `suspend()` yields back to whoever
# resumed it. Switching A → B (both fibers) is two hops:
# `suspend()` from A back to main, then `resume(B)` from main.
#
# ## GC integration (or lack thereof)
#
# Arturo builds with `--mm:orc`. Under ORC the compiler emits
# refcount inc/dec at every scope boundary; the GC does **not** scan
# C stacks. A suspended fiber hasn't yet executed its scope-end
# decrements, so any `ref` reachable only from the fiber's stack is
# kept alive by its own refcount. Cycles reachable only from the
# fiber are likewise visible to ORC's cycle collector. Consequently,
# no `GC_addStack` / `GC_removeStack` is needed — under ORC those
# procs aren't even declared. Confirmed by the ucontext spike (see
# CONCURRENCY_NOTES.md "Spike result", 2026-05-01) and the Phase 1
# stress test on this branch. If we ever switch to a stack-scanning
# GC, this comment is the place to start re-reading.

when not defined(WEB):
    const
        DefaultFiberStackSize* = 256 * 1024
            ## 256KB per CONCURRENCY_NOTES.md — comfortable for
            ## moderately recursive Arturo functions, far more than
            ## minicoro's own 56KB default. Per-fiber override via
            ## `createFiber`'s `stackSize` argument.

    type
        Fiber* = ref object
            ## Owns the underlying `mco_coro` and the entry closure.
            ## Held as a Nim `ref` so the closure environment stays
            ## alive as long as the fiber does.
            handle: McoCoroPtr
            entry: proc ()
            ctx*: VMContext
                ## Per-fiber slice of the VM globals. Set by the
                ## scheduler when the fiber is spawned; swapped
                ## in/out around each `resume` / `suspend`.
                ## `nil` for fibers used outside the scheduler.

    proc fiberCheck(res: McoResult, op: string) {.inline.} =
        if res != mcoSuccess:
            raise newException(CatchableError,
                "fiber " & op & " failed: " & $mco_result_description(res))

    proc fiberTrampoline(co: McoCoroPtr) {.cdecl.} =
        # Single C-callable entry. Pulls the Fiber ref back out of
        # user_data, then invokes the Nim closure stored on it.
        let f = cast[Fiber](mco_get_user_data(co))
        f.entry()

    proc createFiber*(entry: proc (),
                      stackSize: int = DefaultFiberStackSize): Fiber =
        ## Create a new suspended fiber. The first `resume` call will
        ## start running `entry` on a fresh stack of `stackSize`
        ## bytes. When `entry` returns, the fiber transitions to
        ## `mcoDead` and must be cleaned up with `destroyFiber`.
        result = Fiber(entry: entry)
        GC_ref(result)  # keep alive while minicoro holds the user_data ptr
        var desc = mco_desc_init(fiberTrampoline, csize_t(stackSize))
        desc.userData = cast[pointer](result)
        var co: McoCoroPtr
        fiberCheck(mco_create(addr co, addr desc), "create")
        result.handle = co

    proc destroyFiber*(f: Fiber) =
        ## Release the fiber's stack and internal struct. Safe only
        ## when the fiber is suspended or dead — calling this on a
        ## running fiber is a programming error and minicoro will
        ## report it.
        if f.handle != nil:
            fiberCheck(mco_destroy(f.handle), "destroy")
            f.handle = nil
            GC_unref(f)

    proc resume*(f: Fiber) {.inline.} =
        ## Resume `f` until it suspends or finishes. Must be called
        ## from a context that is *not* itself running on `f`'s stack.
        fiberCheck(mco_resume(f.handle), "resume")

    proc suspend*() {.inline.} =
        ## Yield execution from the currently running fiber back to
        ## its resumer. Must be called from inside a fiber's entry
        ## chain.
        fiberCheck(mco_yield(mco_running()), "suspend")

    proc isDone*(f: Fiber): bool {.inline.} =
        ## True once the fiber's entry proc has returned.
        mco_status(f.handle) == mcoDead

    proc currentFiberHandle*(): McoCoroPtr {.inline.} =
        ## The minicoro handle for the currently running fiber, or
        ## `nil` if called from the main thread (no fiber active).
        ## The Phase 3 scheduler uses this to identify "are we on
        ## the main fiber" without going through the `Fiber` ref.
        mco_running()

#=======================================
# Scheduler — fibers + asyncdispatch
#=======================================
#
# Cooperative scheduler. Main thread owns the asyncdispatch poll
# loop; fibers run user blocks and yield via `cooperativeAwait`
# whenever they need to wait on a future. The dispatcher resumes
# them by adding to `scheduler.ready` and the driver picks them up.
#
# `currentFiber == nil` means main is running. Every fiber the
# scheduler tracks owns a `VMContext` that gets swapped in/out
# around each `resume` / `suspend` so the VM globals always reflect
# the running fiber's view.

when not defined(WEB):
    type
        FiberCancelledError* = object of CatchableError
            ## Raised by `cooperativeAwait` when the running fiber's
            ## `VMContext.cancelRequested` flag is set (typically by
            ## a `cancel` from another part of the program).
            ##
            ## The fiber entry's top-level `try/except` catches it
            ## and turns the cancellation into a future failure;
            ## `wait` then translates that into a `:null` result
            ## (matching the existing subprocess-cancellation shape).

        Scheduler = object
            mainCtx: VMContext
                ## Main thread's saved snapshot of the VM globals.
                ## Populated lazily on first fiber spawn (we don't
                ## know main's state until it has one to save).
            currentFiber: Fiber
                ## Whoever is running right now. `nil` while main
                ## is on the C stack (typical case at top-level and
                ## in between fiber resumptions).
            ready: seq[Fiber]
                ## Fibers ready to resume. Pushed by future
                ## callbacks (Phase 3.3) and by `spawnFiber`
                ## (Phase 3.2). Drained by the driver loop
                ## (Phase 3.4).

    var scheduler {.global.}: Scheduler

    proc initScheduler*() =
        ## Bring the scheduler up to a known-good state. Idempotent:
        ## safe to call more than once. Called automatically on
        ## first spawn but exposed so tests / re-entry paths can
        ## reset it explicitly.
        if scheduler.mainCtx.isNil:
            scheduler.mainCtx = VMContext()
        scheduler.currentFiber = nil
        scheduler.ready.setLen(0)

    proc readyLen*(): int {.inline.} =
        ## Diagnostic: number of fibers waiting to resume. Tests
        ## use this to drive the scheduler step-by-step.
        scheduler.ready.len

    proc onMainFiber*(): bool {.inline.} =
        ## True iff control is currently on the main thread (no
        ## fiber is running). Used by `wait` to decide between
        ## `waitFor` (drives the dispatcher) and `cooperativeAwait`
        ## (suspends the current fiber).
        scheduler.currentFiber.isNil

    proc spawnFiber*(entry: proc (), parentSyms: SymTable): Fiber =
        ## Create a fiber bound to a fresh `VMContext` (shallow copy
        ## of `parentSyms`, fresh stack/attrs/scope) and queue it on
        ## the scheduler's ready list. Returns the `Fiber` so the
        ## caller can hold onto it (e.g. for cancellation) — the
        ## scheduler doesn't otherwise expose its queue.
        ##
        ## The entry proc receives the fiber's globals already
        ## installed (the scheduler swaps them in before each
        ## `resume`); it runs as if at top-level. When it returns,
        ## the scheduler treats the fiber as done. Suspending
        ## mid-run is a separate concern (`cooperativeAwait`).
        if scheduler.mainCtx.isNil:
            initScheduler()
        result = createFiber(entry)
        result.ctx = newVMContext(parentSyms)
        scheduler.ready.add(result)

    proc runOneStep*() =
        ## One iteration of the scheduler loop. Either resumes the
        ## next ready fiber (preferred) or, if none, drives one
        ## round of asyncdispatch. Caller is expected to drive this
        ## from main only.
        ##
        ## Swap protocol: main → fiber → main, with the live VM
        ## globals belonging to whoever is currently running.
        if scheduler.ready.len > 0:
            let f = scheduler.ready[0]
            scheduler.ready.delete(0)         # FIFO; O(N) — fine for v1
            # Cancel hooks may re-queue a fiber that has already
            # finished (race between `cancel` and the fiber's last
            # resume). Skip dead fibers — minicoro's `resume` on
            # `mcoDead` would error.
            if isDone(f):
                return
            scheduler.currentFiber = f
            swapOutTo(scheduler.mainCtx)
            swapInFrom(f.ctx)
            resume(f)                         # runs f until it suspends or returns
            swapOutTo(f.ctx)                  # save f's view (or empty if done)
            swapInFrom(scheduler.mainCtx)     # main's view back
            scheduler.currentFiber = nil
        elif hasPendingOperations():
            poll()                            # blocks until at least one I/O event

    proc runScheduledFibers*() =
        ## Drain the ready queue plus the asyncdispatch queue until
        ## both are empty. Used at program-exit-style sync points
        ## where we want every spawned fiber to finish.
        while scheduler.ready.len > 0 or hasPendingOperations():
            runOneStep()

    proc pumpScheduler*(timeoutMs: int) =
        ## Non-blocking-ish single tick: drains all currently-ready
        ## fibers, then polls asyncdispatch for at most `timeoutMs`
        ## milliseconds. Designed to be called from idle loops that
        ## want to keep in-process tasks making progress without
        ## hijacking control (e.g. the REPL's input wait).
        ##
        ## Returns immediately if there's no pending work at all.
        while scheduler.ready.len > 0:
            runOneStep()
        if hasPendingOperations():
            try: poll(timeoutMs)
            except CatchableError: discard

    proc runUntilFutureDone*[T](fut: Future[T]): T =
        ## Block on `fut` from main while letting fibers and I/O
        ## callbacks make progress. This is what `wait t` will call
        ## when invoked from main (Phase 4). Returns the future's
        ## value or re-raises its failure.
        ##
        ## Deadlock guard: if both queues are empty but `fut` isn't
        ## done, nothing can ever wake it — bail with a clear error
        ## rather than spin forever.
        while not fut.finished:
            if scheduler.ready.len == 0 and not hasPendingOperations():
                raise newException(CatchableError,
                    "runUntilFutureDone: no pending work, future will never complete")
            runOneStep()
        when T is void:
            fut.read()
        else:
            return fut.read()

    proc cooperativeAwait*[T](fut: Future[T]): T =
        ## Suspend the current fiber until `fut` completes, then
        ## return its value (or re-raise its failure). Must be
        ## called from inside a fiber — calling from main is a
        ## programming error since main has no fiber stack to park.
        ##
        ## ## Protocol with the scheduler
        ##
        ## The fiber does **not** swap its globals here — the
        ## scheduler's `runOneStep` does that around every
        ## `resume` / `suspend` pair. From the fiber's view:
        ##
        ## 1. If `fut` is already finished, fast-path: just read it.
        ## 2. Otherwise register a callback that re-queues us when
        ##    the future fires, then `suspend()` — control returns
        ##    to whoever called `resume(me)` (the scheduler).
        ## 3. ...time passes; the future eventually completes; the
        ##    callback adds us to `scheduler.ready`; the scheduler
        ##    eventually picks us up, swaps our globals back in, and
        ##    `resume(me)`s us.
        ## 4. We come back from `suspend()` with our globals live
        ##    again; read and return the future's value.
        ##
        ## `Future[void]` is special-cased: `read()` returns `void`,
        ## so `return read()` is a type error. We branch on `T` at
        ## compile time.
        let me = scheduler.currentFiber
        doAssert not me.isNil,
            "cooperativeAwait called outside a fiber — use waitFor on main"
        # Fast path: if cancellation was requested before we got
        # here, bail out without touching the future.
        if me.ctx.cancelRequested:
            raise newException(FiberCancelledError, "task cancelled")
        if not fut.finished:
            # The scheduler global is GC-allocated; the closure
            # below touches it from inside an asyncdispatch callback.
            # `cast(gcsafe)` is the standard escape — same pattern
            # `broadcastToChildren` above uses for `childInboundFiles`.
            fut.addCallback(proc () {.gcsafe.} =
                {.cast(gcsafe).}:
                    scheduler.ready.add(me))
            suspend()
            # Resumed: cancellation may have been requested while we
            # were parked (cancel hook flips the flag and re-queues
            # us). Check again before we surface a result.
            if me.ctx.cancelRequested:
                raise newException(FiberCancelledError, "task cancelled")
        when T is void:
            fut.read()
        else:
            return fut.read()

    proc coopWait*[T](fut: Future[T]): T =
        ## Block on `fut` from any context — main or fiber. Picks the
        ## right primitive automatically:
        ##
        ## - **on main:** `runUntilFutureDone` drives both the
        ##   scheduler ready queue and the asyncdispatch poll loop.
        ##   Plain `waitFor` would skip our scheduler and starve any
        ##   in-process fiber tasks.
        ## - **inside a fiber:** `cooperativeAwait` registers a
        ##   re-queue callback and yields back to the scheduler.
        ##
        ## Stdlib code that previously called `waitFor t.tsk.future`
        ## should now call `coopWait t.tsk.future` so it composes
        ## with both subprocess- and fiber-backed tasks.
        if onMainFiber():
            when T is void:
                runUntilFutureDone(fut)
            else:
                return runUntilFutureDone(fut)
        else:
            when T is void:
                cooperativeAwait(fut)
            else:
                return cooperativeAwait(fut)

#=======================================
# Cross-process event dispatch hook
#=======================================

when not defined(WEB):
    # `library/Events.nim` registers its `dispatchEvent` here at module
    # init time so the read loop below (which runs in helpers, where we
    # can't import a library cleanly) has somewhere to deliver inbound
    # `[name payload]` records from a child VM. nil if Events isn't
    # loaded (e.g. minimal builds).
    var inboundEventDispatcher*: proc(name: string, payload: Value) {.gcsafe.} = nil

    proc setInboundEventDispatcher*(fn: proc(name: string, payload: Value) {.gcsafe.}) =
        inboundEventDispatcher = fn

    # Dispatcher-aware sleep. If there are pending in-process tasks (any
    # `.async` builtin currently in flight), route through `sleepAsync` +
    # `waitFor` so the dispatcher gets cycles to make progress on them.
    # Otherwise fall back to the OS `sleep` — there's nothing to drive,
    # and `waitFor sleepAsync` allocates a future for no reason.
    #
    # Avoids the footgun where `pause 1000` inside an async-heavy program
    # silently freezes every in-flight server / request / read for the
    # whole second.
    proc cooperativePause*(ms: int) =
        # On a fiber: yield to the scheduler so siblings (and any
        # pending dispatcher work) can interleave. `waitFor` would
        # block the fiber's C stack, starving every other fiber and
        # turning `map.async`/`loop.async` into sequential execution.
        if not onMainFiber():
            cooperativeAwait sleepAsync(ms)
        elif scheduler.ready.len > 0 or hasPendingOperations():
            # From main with live work: drive the fiber scheduler
            # AND asyncdispatch for the duration. Plain `waitFor`
            # would only pump dispatcher futures and starve any
            # ready fiber — including in-process `do.async` tasks
            # whose progress the user may be polling between
            # `pause`s (`while [not? finished? t][pause 100]`).
            try:
                runUntilFutureDone(sleepAsync(ms))
            except CatchableError:
                discard
        else:
            sleep(ms)

    # Per-child inbound files — paths the parent writes into so each
    # live child can tail and dispatch into its own subscriber table.
    # `runInChildProcess` registers when it spawns and unregisters when
    # the child exits. The list is what the parent's `emit` fans out
    # over (see `broadcastToChildren`).
    var childInboundFiles: seq[string] = @[]

    proc registerChildInbound*(path: string) =
        childInboundFiles.add(path)

    proc unregisterChildInbound*(path: string) =
        let idx = childInboundFiles.find(path)
        if idx >= 0:
            childInboundFiles.delete(idx)

    proc broadcastToChildren*(name: string, payloadSrc: string) {.gcsafe.} =
        ## Append a `[name, payload]` record (two-line format, same as
        ## the child→parent direction) into every live child's inbound
        ## file. Called by `emit` from a parent VM. `payloadSrc` is the
        ## already-codified Arturo source for the payload — keeps this
        ## helper decoupled from the value-codify imports.
        {.cast(gcsafe).}:
            for path in childInboundFiles:
                try:
                    var f: File
                    if open(f, path, fmAppend):
                        f.writeLine(name)
                        f.writeLine(payloadSrc)
                        f.flushFile()
                        f.close()
                except IOError, OSError:
                    discard

    proc tailEventChannel*(path: string, alive: proc(): bool {.gcsafe.}) {.async, gcsafe.} =
        ## Poll-based tail of the child's event channel file. Reads any
        ## newly-appended `[name payload]` records, parses each via the
        ## VM's normal parser, and hands the (name, payload) pair to the
        ## registered inbound dispatcher. Loops until `alive()` reports
        ## false AND a final read sees no new bytes. Re-opens the file
        ## each pass to dodge stdio EOF-stickiness.
        var pos: int64 = 0
        while true:
            block oneRound:
                var f: File
                if not open(f, path, fmRead):
                    break oneRound
                defer: f.close()
                f.setFilePos(pos)
                var line: string
                # two-line records: name on first line, codified payload
                # on second. if we read a name but EOF hits before the
                # payload, the name line is lost (rare — child flushes
                # both writeLines before the next emit/exit).
                var name: string
                var payloadSrc: string
                while f.readLine(name):
                    if not f.readLine(payloadSrc):
                        break
                    pos = f.getFilePos()
                    if inboundEventDispatcher.isNil: continue
                    try:
                        let parsed = doParse(payloadSrc, isFile=false)
                        var payload = VNULL
                        if not parsed.isNil:
                            let savedSP = SP
                            execUnscoped(parsed)
                            if SP > savedSP:
                                payload = stack.pop()
                        {.cast(gcsafe).}:
                            inboundEventDispatcher(name, payload)
                    except CatchableError:
                        discard
            if not alive():
                # one more pass already happened above — safe to exit
                break
            await sleepAsync(20)

#=======================================
# Subprocess-isolated path (`do.async.isolated`)
#=======================================
#
# Everything from here through `spawnShellAsTask` is the SUBPROCESS
# flavor of `do.async` — kept reachable via `do.async.isolated` (and
# `execute.async`). It's the *rare* path now:
#
#   - default `do.async` runs in-process via `spawnInProcessDoBlock`
#     (cooperative fiber, sub-ms spawn, closure capture, real
#     `:error` fidelity)
#   - `do.async.isolated` lands here: ~30 ms fork+exec, fresh VM,
#     no closure capture, generic "exited with code N" errors —
#     but full process isolation and true OS-scheduler parallelism
#
# Anything here that touches `osproc` / `runProcess` / temp-file
# IPC belongs to the isolated path. The cross-process event
# channel plumbing (`registerChildInbound`, `tailEventChannel`,
# `broadcastToChildren`) is shared between isolated tasks and
# parent ↔ child `emit` flows.

when not defined(WEB):
    # Put the child into its own process group so `terminateGroup`
    # below can take down any grandchildren the child spawned (shell
    # `execute.async`, nested `do.async.isolated`). On POSIX a small
    # race exists between `startProcess` returning and us calling
    # `setpgid` — child may briefly share parent's pgid. Mitigation:
    # we always set right after spawn; child's own startup is too
    # short to fork before we get here in practice. No-op on Windows
    # (job objects would be the equivalent — not wired today).
    proc detachToOwnGroup(p: Process) {.inline.} =
        when defined(posix):
            discard setpgid(Pid(p.processID), Pid(p.processID))

    # Cancellation/cleanup: prefer killing the whole group so any
    # grandchildren go down with the parent. POSIX `kill(-pgid, ...)`
    # signals the entire group. On Windows, `Process.terminate` is
    # the only reliable hook we have today; document and revisit if
    # leak hygiene matters there.
    proc terminateGroup(p: Process) {.inline.} =
        when defined(posix):
            discard posix.kill(Pid(-p.processID), cint(SIGTERM))
        else:
            p.terminate()

    # spawn a child arturo process to evaluate `blockSrc`, return a future that
    # settles when the child exits. result is whatever the child's expression
    # evaluated to, deserialized via `express`/`doParse` round-trip.
    #
    # this is THE primitive for "real" background work: the child has its own
    # VM, so it runs genuinely in parallel with whatever the main code is doing.
    # we poll with a 50ms granularity and yield to the dispatcher between polls,
    # which means other futures keep making progress.
    #
    # we INHERIT the child's stdout/stderr (so any `print` inside the async
    # block flows live to the user's terminal) and use a temp file for the
    # result hand-off. capturing stdout would swallow user prints.
    proc runInChildProcess*(tsk: VTask, blockSrc: string): Future[Value] {.async.} =
        let arturoBin = getAppFilename()
        # `genTempPath` mixes in OS-supplied random bytes — a real
        # unique path, unlike the old `pid + epochTime` recipe which
        # could collide under fast successive spawns.
        let resFile = genTempPath("arturo-task-", ".art")
        # Side-channel for errors — child writes `#[kind: msg:]` here
        # if the user block raises, so we can resurrect the real
        # `VError` kind+message on the parent side. Live `print` from
        # the child stays untouched (still inherits `poParentStreams`),
        # which is why we need a file rather than capturing stderr.
        let errFile = genTempPath("arturo-err-", ".art")
        # Cross-process emit channel — child appends one
        # `[name payload]` record per `emit`, parent tails. Created
        # empty so the child's append open succeeds immediately.
        let evtFile = genTempPath("arturo-evt-", ".art")
        writeFile(evtFile, "")
        # Inbound channel — parent writes here, child tails it. Pair
        # to `evtFile` (the outbound channel). Child receives parent's
        # `emit` records on `inboundFile` and dispatches them into its
        # own subscriber table.
        let inboundFile = genTempPath("arturo-inb-", ".art")
        writeFile(inboundFile, "")
        registerChildInbound(inboundFile)
        var childEnv = newStringTable(modeCaseSensitive)
        for k, v in envPairs():
            childEnv[k] = v
        childEnv["ARTURO_EVENT_FILE"] = evtFile
        childEnv["ARTURO_EVENT_INBOUND"] = inboundFile
        # void-safety trick: prepend `null` *inside* the user's block so the
        # block always has a value even if the user's last expression doesn't
        # push (e.g. ends with `print`). if the user does push a real value,
        # that supersedes the leading `null` as the topmost stack value.
        let safeBlock =
            if blockSrc.len >= 2 and blockSrc[0] == '[':
                "[null " & blockSrc[1 .. blockSrc.high]
            else:
                "[null " & blockSrc & "]"
        # `.safe` uses `«« »»` string delimiters and quotes dict keys -
        # round-trip-safe for anything Arturo can represent (HTTP responses,
        # dicts with hyphenated keys, strings containing curly braces, etc.)
        # `try` wraps the `do` so the child can ship the `VError` kind +
        # message back through `errFile`. Without `try`, the child crashes
        # to a non-zero exit and the parent only sees "exited with code N".
        # (Leading `null` inside `safeBlock` keeps void blocks safe.)
        # Use forward slashes when embedding the path into Arturo
        # source. Windows `getTempDir` returns backslash-separated
        # paths; Arturo's string parser treats `\` as the start of an
        # escape sequence (`\n`, `\t`, …) and an odd-length tail —
        # `…\` followed by the closing `"` — collapses to an
        # unterminated string and blows up the child VM (SIGSEGV).
        # Forward slashes work fine on every OS we target.
        let resFileEmbed = resFile.replace('\\', '/')
        let errFileEmbed = errFile.replace('\\', '/')
        let wrapped =
            "__err__: try.verbose [\n" &
            "    __res__: do " & safeBlock & "\n" &
            "    write express.safe __res__ \"" & resFileEmbed & "\"\n" &
            "]\n" &
            "unless null? __err__ [\n" &
            "    write express.safe #[kind: __err__\\kind\\label msg: __err__\\message] \"" & errFileEmbed & "\"\n" &
            "]"
        let p = startProcess(arturoBin,
                             args = @["-e", wrapped],
                             env = childEnv,
                             options = {poUsePath, poParentStreams})
        detachToOwnGroup(p)
        # publish the process handle so `cancel` can terminate it
        tsk.process = p
        # Tail the child's event channel concurrently. The closure
        # `alive` returns true while the child is still running, so the
        # loop exits with one trailing read after the child terminates
        # — flushes any final `emit` records the child wrote before exit.
        let proc1 = p
        let tailFut = tailEventChannel(evtFile, proc(): bool {.gcsafe.} =
            {.cast(gcsafe).}: proc1.running)
        while p.running and tsk.state != taskCancelled:
            await sleepAsync(50)
        if tsk.state == taskCancelled and p.running:
            terminateGroup(p)
            discard p.waitForExit()
        let code = p.peekExitCode()
        p.close()
        # Drain remaining events written between the last poll and exit.
        try:
            await tailFut
        except CatchableError:
            discard
        if fileExists(evtFile):
            try: removeFile(evtFile)
            except CatchableError: discard
        unregisterChildInbound(inboundFile)
        if fileExists(inboundFile):
            try: removeFile(inboundFile)
            except CatchableError: discard
        # Errors ride a side-channel (`errFile`) so live `print` from
        # the child stays untouched. If the child wrote one, reconstruct
        # the real `VError` (kind + message) and raise it so `wait` can
        # surface it as a structured `:error` matching the in-process
        # path's fidelity.
        if fileExists(errFile):
            let rawErr = readFile(errFile)
            removeFile(errFile)
            if fileExists(resFile): removeFile(resFile)
            var rebuiltKind = RuntimeErr
            var rebuiltMsg = ""
            try:
                let parsed = doParse(rawErr, isFile=false)
                if not parsed.isNil:
                    let savedSP = SP
                    execUnscoped(parsed)
                    if SP > savedSP:
                        let dict = stack.pop()
                        if dict.kind == Dictionary:
                            if dict.d.hasKey("kind") and dict.d["kind"].kind == String:
                                rebuiltKind = kindByLabel(dict.d["kind"].s)
                            if dict.d.hasKey("msg") and dict.d["msg"].kind == String:
                                rebuiltMsg = dict.d["msg"].s
            except CatchableError:
                discard
            raise toError(rebuiltKind, rebuiltMsg)
        elif code == 0 and fileExists(resFile):
            let raw = readFile(resFile)
            removeFile(resFile)
            try:
                let parsed = doParse(raw, isFile=false)
                if not parsed.isNil:
                    let savedSP = SP
                    execUnscoped(parsed)
                    if SP > savedSP:
                        result = stack.pop()
                    else:
                        result = VNULL
                else:
                    result = VNULL
            except CatchableError:
                result = VNULL
        else:
            if fileExists(resFile): removeFile(resFile)
            # cancellation is not a failure — caller observes via task state.
            # for any other non-zero exit, fail the future so `wait` can
            # surface it as an `:error` value.
            if tsk.state == taskCancelled:
                result = VNULL
            else:
                raise newException(CatchableError,
                    "task subprocess exited with code " & $code)

    # spawn a shell command as a child process, return a future that settles
    # when it exits. mirrors `execCmdEx` semantics: stdout+stderr captured
    # together, full string passed through the system shell (`poEvalCommand`).
    # 50ms poll, dispatcher-friendly. cancellation terminates the child;
    # non-zero exit fails the future so `wait` surfaces an `:error` (with the
    # captured output appended to the message — actually-useful diagnostics,
    # unlike `do.async`'s opaque "exited with code N").
    proc runShellInChildProcess*(tsk: VTask, fullCmd: string,
                                 withCode: bool): Future[Value] {.async.} =
        let p = startProcess(command = fullCmd,
                             options = {poUsePath, poEvalCommand, poStdErrToStdOut})
        detachToOwnGroup(p)
        tsk.process = p
        while p.running and tsk.state != taskCancelled:
            await sleepAsync(50)
        if tsk.state == taskCancelled and p.running:
            terminateGroup(p)
            discard p.waitForExit()
        let code = p.peekExitCode()
        var output = ""
        try:
            output = p.outputStream.readAll()
        except CatchableError:
            discard
        p.close()
        # cancellation always → :null, regardless of `.code`. consistent with
        # the rest of the `:task` family (cancel is not a failure).
        if tsk.state == taskCancelled:
            result = VNULL
        elif withCode:
            result = newDictionary({
                "output": newString(output),
                "code": newInteger(code)
            }.toOrderedTable)
        else:
            if code == 0:
                result = newString(output)
            else:
                let trimmed = output.strip()
                let suffix = if trimmed.len > 0: ": " & trimmed else: ""
                raise newException(CatchableError,
                    "shell command exited with code " & $code & suffix)

    # convenience: turn a piece of Arturo source into a pending `:task` value.
    # used by `.async` branches across the stdlib.
    proc spawnAsTask*(src: string, name: string = ""): Value =
        # the VTask has to exist before `runInChildProcess` runs so it can
        # publish the `Process` handle onto it for `cancel` to reach
        let tsk = VTask(state: taskPending, name: name)
        tsk.future = runInChildProcess(tsk, src)
        result = newTask(tsk)

    # convenience: turn a shell command into a pending `:task`. used by
    # `execute.async`. `withCode` toggles the resolved-value shape between
    # bare output string and `#[output: code:]` dict (mirrors `execute.code`).
    proc spawnShellAsTask*(fullCmd: string, withCode: bool, name: string = ""): Value =
        let tsk = VTask(state: taskPending, name: name)
        tsk.future = runShellInChildProcess(tsk, fullCmd, withCode)
        result = newTask(tsk)

#=======================================
# In-process path (default `do.async`)
#=======================================
#
# Cooperative fibers running inside the same VM. Sub-ms spawn,
# closure capture, real `:error` fidelity. This is the default
# `do.async [ ... ]` flavor and the spawn primitive every fan-out
# iterator (`map.parallel` / `loop.parallel` / …) calls into.

when not defined(WEB):
    # in-process flavor of `do.async`. Runs the block on a cooperative
    # fiber inside the same VM — sub-ms spawn, full closure capture
    # (parent `Syms` shallow-copied at spawn), real `VMError`s preserved
    # rather than the generic "exited with code N" of the subprocess
    # path. Returns immediately; the fiber actually executes when the
    # scheduler is driven (e.g. via `wait`).
    proc spawnInProcessDoBlock*(blk: Value, name: string = ""): Value =
        let tsk = VTask(state: taskPending, name: name)
        let fut = newFuture[Value]("do.async")
        tsk.future = fut

        # `f` declared up here so both the entry and the cancel
        # hook can see the same handle. Captured by closure env.
        var f: Fiber

        # Fiber captures the surrounding environment via these refs.
        # `blk`, `tsk`, `fut` are refs already; closure env keeps them
        # alive until the fiber finishes.
        proc fiberEntry() {.gcsafe.} =
            {.cast(gcsafe).}:
                try:
                    let prevSP = SP
                    execUnscoped(blk)
                    let res =
                        if SP > prevSP: pop()
                        else:           VNULL
                    tsk.state = taskDone
                    fut.complete(res)
                except FiberCancelledError:
                    # `cancel` hook flipped the flag while we were
                    # parked; cooperativeAwait re-raised. Surface as
                    # a cancelled future, *not* a failed one — the
                    # consumer (`wait`) maps cancelled → :null.
                    tsk.state = taskCancelled
                    fut.fail(newException(FiberCancelledError,
                        "task cancelled"))
                except CatchableError as e:
                    tsk.state = taskFailed
                    fut.fail(e)

        f = spawnFiber(fiberEntry, Syms)

        # Cancel hook flips the per-fiber cancel flag and pokes the
        # scheduler so a parked fiber actually wakes up to see it.
        # If the fiber is already in `ready` or already done, the
        # extra add is harmless — the scheduler skips finished
        # fibers and an extra resume on a still-suspended one just
        # runs the post-suspend cancel-check immediately.
        let cancelCtx = f.ctx
        let cancelF = f
        tsk.cancelHandle = proc () {.gcsafe.} =
            {.cast(gcsafe).}:
                cancelCtx.cancelRequested = true
                if not isDone(cancelF):
                    scheduler.ready.add(cancelF)

        result = newTask(tsk)

    # in-process async download via Nim's `AsyncHttpClient`. unlike the subprocess
    # path, this stays in the same VM: no fork/exec overhead, no separate Arturo
    # interpreter, just a `Future[void]` from the dispatcher wrapped to return
    # `VNULL` (mirroring the sync `download` builtin's `Nothing` return).
    #
    # caveat: in-process futures only progress while the dispatcher is being
    # driven (i.e. during `wait` / `waitFor`). that's fine for the usual flow
    # — launch, do other things, then `wait` — but pure fire-and-forget won't
    # actually transfer bytes until something dispatches.
    proc downloadFileAsync(client: AsyncHttpClient, url, target: string): Future[Value] {.async.} =
        # let CatchableError escape — `wait` classifies it (cancel → :null,
        # otherwise → :error). cancellation closes the client and surfaces
        # here as an exception, which `wait` filters out via task state.
        try:
            await client.downloadFile(url, target)
            result = VNULL
        finally:
            try: client.close()
            except CatchableError: discard

    # in-process async file read via `asyncfile`. returns the raw bytes/text;
    # the caller (`read.async` builtin) is responsible for any post-processing
    # like CSV/JSON/markdown parsing — that's pure CPU work and stays sync.
    proc readFileAsyncStr(f: AsyncFile): Future[string] {.async.} =
        # let CatchableError escape — `wait` classifies it (cancel → :null,
        # otherwise → :error). cancellation closes the file and surfaces
        # here as an exception, filtered out downstream via task state.
        try:
            result = await f.readAll()
        finally:
            try: f.close()
            except CatchableError: discard

    # in-process async URL fetch via `AsyncHttpClient.getContent`. mirrors
    # the sync `getSource` URL leg (which already uses `newAsyncHttpClient`
    # with a blocking `waitFor`) — same client, same semantics, but the
    # result is awaited cooperatively so other tasks can make progress.
    proc readUrlAsyncStr(client: AsyncHttpClient, url: string): Future[string] {.async.} =
        # let CatchableError escape — `wait` classifies it (cancel → :null,
        # otherwise → :error). cancellation closes the client and surfaces
        # here as an exception, filtered out downstream via task state.
        try:
            result = await client.getContent(url)
        finally:
            try: client.close()
            except CatchableError: discard

    # convenience: kick off an in-process async read, run a sync `postProcess`
    # closure on the bytes once available, and return a `:task` whose result
    # is whatever the closure returned. the open file is held by the task so
    # `cancel` can `close()` it and abort an in-flight read.
    proc spawnAsyncRead*(path: string, postProcess: proc(src: string): Value): Value =
        let f = openAsync(path, fmRead)
        proc go(): Future[Value] {.async.} =
            let src = await readFileAsyncStr(f)
            result = postProcess(src)
        let tsk = VTask(state: taskPending)
        tsk.future = go()
        tsk.cancelHandle = proc() =
            try: f.close()
            except CatchableError: discard
        result = newTask(tsk)

    # URL counterpart to `spawnAsyncRead`. mirrors the same shape: own the
    # http client so `cancel` can `close()` it and abort an in-flight GET,
    # run the user-supplied `postProcess` closure on the body once it
    # arrives. SSL context matches `spawnAsyncDownload` (verify-none, same
    # as the sync `getSource` path).
    proc spawnAsyncReadUrl*(url: string, postProcess: proc(src: string): Value): Value =
        when defined(ssl):
            let client = newAsyncHttpClient(sslContext = netmod.newContext(verifyMode = CVerifyNone))
        else:
            let client = newAsyncHttpClient()
        proc go(): Future[Value] {.async.} =
            let src = await readUrlAsyncStr(client, url)
            result = postProcess(src)
        let tsk = VTask(state: taskPending)
        tsk.future = go()
        tsk.cancelHandle = proc() =
            try: client.close()
            except CatchableError: discard
        result = newTask(tsk)

    when defined(ssl):
        # in-process async SMTP send via `extras/smtp`'s `AsyncSmtp`.
        # mirrors what the sync `mail` builtin does (newSmtp → connect →
        # auth → sendMail → close), but each step is awaited so other
        # in-flight tasks make progress while we wait on the network.
        proc mailAsyncSend(smtp: AsyncSmtp, server: string, port: int,
                           username, password, fromAddr: string,
                           toAddrs: seq[string], msgStr: string): Future[Value] {.async.} =
            # let CatchableError escape — `wait` classifies it (cancel →
            # :null, otherwise → :error). cancellation closes the smtp
            # socket and surfaces here as an exception, filtered out
            # downstream via task state.
            try:
                await smtp.connect(server, Port(port))
                await smtp.auth(username, password)
                await smtp.sendMail(fromAddr, toAddrs, msgStr)
                result = VNULL
            finally:
                try: await smtp.close()
                except CatchableError: discard

        # convenience: kick off an in-process async mail send and return
        # a `:task`. the `AsyncSmtp` is held by the task so `cancel` can
        # close the underlying socket and abort an in-flight handshake
        # or `DATA` transfer.
        proc spawnAsyncMail*(server: string, port: int,
                             username, password, fromAddr: string,
                             toAddrs: seq[string], msgStr: string,
                             useSsl = true): Value =
            let smtp = newAsyncSmtp(useSsl = useSsl)
            let tsk = VTask(state: taskPending)
            tsk.future = mailAsyncSend(smtp, server, port, username, password,
                                       fromAddr, toAddrs, msgStr)
            tsk.cancelHandle = proc() =
                # close() is async on AsyncSmtp; we just close the
                # underlying socket synchronously to abort.
                try: smtp.sock.close()
                except CatchableError: discard
            result = newTask(tsk)

    # in-process async file write via `asyncfile`. content is already
    # serialized by the caller (e.g. JSON-encoded), so this layer just
    # streams bytes to disk through the dispatcher.
    proc writeFileAsync(f: AsyncFile, content: string): Future[Value] {.async.} =
        # let CatchableError escape — `wait` classifies it (cancel → :null,
        # otherwise → :error). cancellation closes the file and surfaces
        # here as an exception, filtered out downstream via task state.
        try:
            await f.write(content)
            result = VNULL
        finally:
            try: f.close()
            except CatchableError: discard

    # convenience: kick off an in-process async write and return a `:task`.
    # the open file is held by the task so `cancel` can `close()` it and
    # abort an in-flight write.
    proc spawnAsyncWrite*(path, content: string, append: bool): Value =
        let mode = if append: fmAppend else: fmWrite
        let f = openAsync(path, mode)
        let tsk = VTask(state: taskPending)
        tsk.future = writeFileAsync(f, content)
        tsk.cancelHandle = proc() =
            try: f.close()
            except CatchableError: discard
        result = newTask(tsk)

    # in-process async HTTP request via Nim's `AsyncHttpClient`. the response
    # is awaited, the body is drained, and the caller-provided `buildResponse`
    # closure converts the raw fields into a Value (so the response shape
    # stays driven by Net.nim, not this helper).
    proc requestAsync(client: AsyncHttpClient, url: string, meth: HttpMethod,
                      body: string, multipart: MultipartData,
                      buildResponse: proc(version, body, status: string,
                                          headers: HttpHeaders): Value
                     ): Future[Value] {.async.} =
        # let CatchableError escape — `wait` classifies it based on task state
        # (cancellation → :null, anything else → :error). this is intentionally
        # *not* a mirror of sync `request`'s null-on-failure behavior: a `:task`
        # is a richer abstraction and users can introspect/recover via `:error`.
        try:
            let response = await client.request(url = url, httpMethod = meth,
                                                body = body, multipart = multipart)
            let bodyStr = await response.body
            result = buildResponse(response.version, bodyStr,
                                   response.status, response.headers)
        finally:
            try: client.close()
            except CatchableError: discard

    # convenience: kick off an in-process async HTTP request and return a
    # `:task`. the client is held by the task so `cancel` can `close()` it
    # and abort the in-flight request.
    proc spawnAsyncRequest*(client: AsyncHttpClient, url: string, meth: HttpMethod,
                            body: string, multipart: MultipartData,
                            buildResponse: proc(version, body, status: string,
                                                headers: HttpHeaders): Value,
                            timeoutMs: int = -1
                           ): Value =
        let tsk = VTask(state: taskPending)
        let inner = requestAsync(client, url, meth, body, multipart, buildResponse)
        # `AsyncHttpClient` doesn't expose a per-request timeout the way
        # the sync `HttpClient` does, so we race the request against
        # `sleepAsync(timeoutMs)`. Timer winning → close the client to
        # abort the in-flight request, then fail the future. The
        # downstream `:error` carries the timeout message; `wait` /
        # `on.failed` see it as a regular failure.
        if timeoutMs > 0:
            proc gated(): Future[Value] {.async.} =
                let inTime = await withTimeout(inner, timeoutMs)
                if not inTime:
                    try: client.close()
                    except CatchableError: discard
                    raise newException(CatchableError,
                        "request.async timed out after " & $timeoutMs & "ms")
                return inner.read
            tsk.future = gated()
        else:
            tsk.future = inner
        tsk.cancelHandle = proc() =
            try: client.close()
            except CatchableError: discard
        result = newTask(tsk)

    # convenience: kick off an in-process async download and return a `:task`.
    # parallels `spawnAsTask` but skips the subprocess machinery entirely.
    # the client is held by the task so `cancel` can `close()` it and abort
    # the in-flight download.
    proc spawnAsyncDownload*(url, target: string): Value =
        when defined(ssl):
            let client = newAsyncHttpClient(sslContext = netmod.newContext(verifyMode = CVerifyNone))
        else:
            let client = newAsyncHttpClient()
        let tsk = VTask(state: taskPending)
        tsk.future = downloadFileAsync(client, url, target)
        tsk.cancelHandle = proc() =
            try: client.close()
            except CatchableError: discard
        result = newTask(tsk)

    # in-process async HTTP server via Nim's `asynchttpserver`. the caller
    # provides a `handler` closure that processes each request; we own the
    # server lifecycle so `cancel` can `close()` it and free the port.
    proc spawnAsyncServe*(port: int,
                          handler: proc(req: Request): Future[void] {.async, gcsafe.}
                         ): Value =
        let server = newAsyncHttpServer()
        proc go(): Future[Value] {.async.} =
            # let CatchableError escape — `wait` classifies it (cancel → :null,
            # otherwise → :error, e.g. EADDRINUSE on bind). cancellation
            # closes the server and surfaces here as an exception, filtered
            # out downstream via task state.
            try:
                await server.serve(Port(port), handler)
                result = VNULL
            finally:
                try: server.close()
                except CatchableError: discard
        let tsk = VTask(state: taskPending)
        tsk.future = go()
        tsk.cancelHandle = proc() =
            try: server.close()
            except CatchableError: discard
        result = newTask(tsk)

    # block on a task's future and return its result. used by `do task`
    # as sugar for `wait task`. mirrors `wait`'s catch logic: failures
    # surface as `:error` (preserving the real `VError` for in-process
    # fibers, falling back to `RuntimeErr` for subprocess tasks);
    # cancellation surfaces as `:null`.
    proc timeoutMsOf*(v: Value): int =
        ## Read a `.timeout:` attr value (Integer = ms, Quantity = converted to ms).
        case v.kind
        of Integer:  v.i
        of Quantity: toInt((v.q.convertTo(parseAtoms("ms"))).original)
        else:        0

    proc drainTask*(tsk: VTask, timeoutMs: int = -1): Value =
        if tsk.state == taskCancelled:
            return VNULL
        try:
            if timeoutMs >= 0:
                # race the task's future against a sleep timer. on timeout
                # return `:error` and leave the task pending (timeout is a
                # drain-side concept — the work itself isn't broken; the
                # user can `do task` / `wait task` again).
                if not coopWait withTimeout(tsk.future, timeoutMs):
                    return newError(RuntimeErr, "do timed out")
            result = coopWait tsk.future
            if tsk.state == taskPending:
                tsk.state = taskDone
        except CatchableError as e:
            if tsk.state == taskCancelled:
                result = VNULL
            else:
                tsk.state = taskFailed
                result =
                    if e of VError: newError(VError(e))
                    else:           newError(RuntimeErr, e.msg)
