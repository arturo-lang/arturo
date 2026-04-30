#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Events.nim
#=======================================================

## The main Events module
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

# Mirrors `Tasks.nim`'s WEB-gating: the dispatcher-driven scheduling
# this module relies on (and the OS-level signal hooks for built-in
# events like `CtrlC`) aren't available on the JS backend. The
# `:event` *value* itself is fine on WEB — only the surrounding
# machinery is gated.
when not defined(WEB):
    import asyncdispatch
    import os
    import std/exitprocs
    import tables

    when not defined(windows):
        import posix

    import vm/values/custom/[vevent, vtask, verror]

import vm/lib

when not defined(WEB):
    import helpers/parallelism
    import vm/exec

#=======================================
# Variables
#=======================================

when not defined(WEB):
    type
        EventHandler = object
            param: string   ## empty string means "no payload binding"
            body: Value     ## raw block; executed via `execUnscoped`

    # Subscribers indexed by event name. Each `on e [...]` appends a
    # handler here; `emit` looks up by name and schedules each handler
    # on the next dispatcher tick.
    var subscribers: Table[string, seq[EventHandler]]

    # When this VM is running as a `do.async` subprocess, the parent
    # opens a pipe and passes the write-fd via `ARTURO_EVENT_FD`. We
    # open it as a `File` here and append one `[name payload]` record
    # per `emit` so the parent's dispatcher can fire its own handlers.
    # Nil when running as the top-level VM — `emit` then is purely local.
    var emitChannel: File = nil

#=======================================
# Helpers
#=======================================

when not defined(WEB):
    proc dispatchEvent(name: string, payload: Value) {.gcsafe.}

    proc enqueueEmit(handler: EventHandler, payload: Value) =
        ## Schedule a handler invocation on the next dispatcher tick.
        ## Avoids reentrancy surprises: `emit` never runs handlers
        ## synchronously — they fire from `sleepAsync(0)`'s callback.
        ##
        ## We bind the payload as a plain global symbol and `execUnscoped`
        ## the handler body directly — same idiom `loop` uses for its
        ## iterator var. Going through `callFunction` here would push args
        ## + re-enter `execFunction`, which deadlocks the VM when the
        ## dispatcher is being driven from inside another VM call (e.g.
        ## mid-`wait`).
        let cap = handler
        let pay = payload
        sleepAsync(0).addCallback(proc() {.gcsafe.} =
            {.cast(gcsafe).}:
                try:
                    if cap.param.len > 0:
                        Syms[cap.param] = pay
                    execUnscoped(cap.body)
                except CatchableError as e:
                    # v1 policy: a raising handler doesn't poison the
                    # queue — log a warning and move on. Revisit if we
                    # want an UnhandledError event later.
                    echo "Events: handler raised: " & e.msg
        )

    proc initEmitChannel() =
        ## If we were spawned by a parent VM with cross-process emit
        ## enabled, the parent will have placed the pipe's write-fd
        ## under `ARTURO_EVENT_FD`. Open it once at module init.
        let fdStr = getEnv("ARTURO_EVENT_FD")
        if fdStr.len == 0: return
        try:
            let fd = parseInt(fdStr).cint
            var f: File
            if open(f, FileHandle(fd), fmAppend):
                emitChannel = f
        except CatchableError:
            discard

    proc dispatchEvent(name: string, payload: Value) {.gcsafe.} =
        ## Look up subscribers for the named event and enqueue each on
        ## the next dispatcher tick. Shared by the `emit` builtin and
        ## the OS-level hooks for built-in events (`CtrlC`, `SigTerm`, …).
        {.cast(gcsafe).}:
            if subscribers.hasKey(name):
                for handler in subscribers[name]:
                    enqueueEmit(handler, payload)

# TODO(Events): per-handler unsubscribe — `off E` clears *all* handlers
#  for an event today. Per-handler removal would need handles returned
#  from `on`. Add when someone needs it.

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =
    when not defined(WEB):

        initEmitChannel()
        setInboundEventDispatcher(dispatchEvent)

        #----------------------------
        # Functions
        #----------------------------

        builtin "event",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "create a new event with given name",
            args        = {
                "name"  : {Literal,String}
            },
            attrs       = NoAttrs,
            returns     = {Event},
            example     = """
            DataReady: event 'data-ready
            ; => <event>(data-ready)
            """:
                #=======================================================
                push newEvent(x.s)

        builtin "on",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "register a handler block to fire whenever given event or task settles",
            args        = {
                "target" : {Event,Task},
                "action" : {Block,Bytecode}
            },
            attrs       = {
                "with"      : ({Literal},"bind the emitted payload (or task result) to given symbol inside the handler"),
                "done"      : ({Logical},"with `:task`: fire only when the task ends successfully"),
                "failed"    : ({Logical},"with `:task`: fire only when the task ends with an error"),
                "cancelled" : ({Logical},"with `:task`: fire only when the task ends by cancellation"),
                "finished"  : ({Logical},"with `:task`: fire on any termination (default)")
            },
            returns     = {Nothing},
            example     = """
            DataReady: event 'data-ready
            on.with:'payload DataReady [
                print ["got:" payload]
            ]
            ..........
            ; no payload binding:
            on CtrlC [
                print "graceful shutdown..."
            ]
            ..........
            ; task callbacks:
            t: do.async [pause 200 42]
            on.done.with:'r t [ print ["succeeded:" r] ]
            on.failed.with:'e t [ print ["failed:" e] ]
            on.finished.with:'r t [ print ["settled:" r] ]
            wait t
            """:
                #=======================================================
                var handler = EventHandler(body: y)
                if checkAttr("with"):
                    handler.param = aWith.s

                if xKind == Event:
                    subscribers.mgetOrPut(x.evt.name, @[]).add(handler)
                else:
                    # `:task` callbacks. Modes filter which terminations
                    # the handler fires on; `.finished` (the default)
                    # fires for any outcome.
                    let mode =
                        if hadAttr("done"): "done"
                        elif hadAttr("failed"): "failed"
                        elif hadAttr("cancelled"): "cancelled"
                        else:
                            discard hadAttr("finished")
                            "finished"
                    let cap = handler
                    let tsk = x.tsk
                    let target = x
                    target.tsk.future.addCallback(proc(fin: Future[Value]) {.gcsafe.} =
                        {.cast(gcsafe).}:
                            var state: string
                            var payload: Value
                            if fin.failed:
                                if tsk.state == taskCancelled:
                                    state = "cancelled"
                                    payload = VNULL
                                else:
                                    tsk.state = taskFailed
                                    state = "failed"
                                    payload = newError(RuntimeErr, fin.error.msg)
                            elif tsk.state == taskCancelled:
                                # cancellation may surface as a successful
                                # `VNULL` rather than a raised future
                                # (subprocess case — see helpers/parallelism)
                                state = "cancelled"
                                payload = VNULL
                            else:
                                if tsk.state == taskPending:
                                    tsk.state = taskDone
                                state = "done"
                                payload = fin.read()

                            if mode == "finished" or mode == state:
                                enqueueEmit(cap, payload)
                    )

        builtin "emit",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "fire given event, scheduling each registered handler on the next dispatcher tick",
            args        = {
                "event"   : {Event}
            },
            attrs       = {
                "with"    : ({Any},"pass given value as the event's payload")
            },
            returns     = {Nothing},
            example     = """
            DataReady: event 'data-ready
            on.with:'p DataReady [ print ["got:" p] ]
            emit.with: "hello" DataReady
            ; → got: hello   (fires on next dispatcher tick)
            ..........
            ; no payload — just emit:
            emit CtrlC
            """:
                #=======================================================
                let payload =
                    if checkAttr("with"): aWith
                    else: VNULL
                dispatchEvent(x.evt.name, payload)
                # Cross-process leg: if we're a `do.async` child, also
                # ship `[name payload]` up the pipe so the parent's
                # dispatcher fires its own subscribers. Best-effort —
                # parent-died errors are dropped silently.
                if not emitChannel.isNil:
                    try:
                        emitChannel.writeLine(
                            "[" & codify(newString(x.evt.name), safeStrings = true) &
                            " " & codify(payload, safeStrings = true) & "]"
                        )
                        emitChannel.flushFile()
                    except IOError:
                        discard

        builtin "off",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "remove all registered handlers for given event",
            args        = {
                "event" : {Event}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            E: event 'tick
            on E [ print "tick!" ]
            emit E
            off E
            emit E   ; → no-op; nothing prints
            """:
                #=======================================================
                # Bulk removal: drops every handler registered for the
                # named event. Per-handler removal would need handles
                # returned from `on` — left for later. Note this only
                # affects `:event` subscribers; task `addCallback`s
                # have no removal API on Nim's side.
                subscribers.del(x.evt.name)

        #----------------------------
        # Constants
        #----------------------------

        constant "CtrlC",
            alias       = unaliased,
            description = "built-in event fired when the user presses Ctrl+C":
                newEvent("CtrlC")

        constant "BeforeExit",
            alias       = unaliased,
            description = "built-in event fired just before the program exits":
                newEvent("BeforeExit")

        constant "SigTerm",
            alias       = unaliased,
            description = "built-in event fired on a SIGTERM signal (POSIX only)":
                newEvent("SigTerm")

        constant "SigHup",
            alias       = unaliased,
            description = "built-in event fired on a SIGHUP signal (POSIX only)":
                newEvent("SigHup")

        # POSIX-only: catch SIGTERM / SIGHUP and dispatch the matching
        # event before letting the process exit. Strictly speaking, the
        # signal-handler context is async-unsafe and `addCallback` /
        # `dispatchEvent` are not signal-safe — but in practice the
        # handler is short and the alternative (a polled flag) needs a
        # main loop Arturo doesn't have. We drain inline so the user's
        # handler actually gets to run before `quit`. Exit codes follow
        # the conventional `128 + signum`.
        when not defined(windows):
            signal(SIGTERM, proc(s: cint) {.noconv.} =
                {.cast(gcsafe).}:
                    dispatchEvent("SigTerm", VNULL)
                    try:
                        while hasPendingOperations():
                            poll(0)
                    except CatchableError:
                        discard
                    quit(128 + int(SIGTERM))
            )

            signal(SIGHUP, proc(s: cint) {.noconv.} =
                {.cast(gcsafe).}:
                    dispatchEvent("SigHup", VNULL)
                    try:
                        while hasPendingOperations():
                            poll(0)
                    except CatchableError:
                        discard
                    quit(128 + int(SIGHUP))
            )

        # Process exit → emit `BeforeExit`. Same drain trick as `CtrlC`:
        # without pumping the dispatcher one final time, queued handlers
        # would be discarded at process teardown.
        addExitProc(proc() {.noconv.} =
            {.cast(gcsafe).}:
                dispatchEvent("BeforeExit", VNULL)
                try:
                    while hasPendingOperations():
                        poll(0)
                except CatchableError:
                    discard
        )

        # SIGINT → emit `CtrlC`. Nim invokes the hook on the main thread
        # at a safe point (not in signal context), so scheduling on the
        # dispatcher is fine. We drain the queue here because Nim's
        # runtime terminates the program once the hook returns —
        # otherwise the user's handler would never get to run.
        setControlCHook(proc() {.noconv.} =
            {.cast(gcsafe).}:
                dispatchEvent("CtrlC", VNULL)
                try:
                    while hasPendingOperations():
                        poll(0)
                except CatchableError:
                    discard
        )

        # Pre-bound built-in events (`BeforeExit`, `SigTerm`, `SigHup`)
        # and the OS hooks that fire them land in follow-up commits —
        # see EVENT_NOTES.md.
