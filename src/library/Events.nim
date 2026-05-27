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

# Dispatcher + signal hooks unusable on JS; gate the machinery.
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

        Subscription = object
            id: int         ## unique id for this registration; surfaced via `on.id` and used by `off id`
            once: bool      ## if true, drop from subscribers after the next fire
            handler: EventHandler

    # Subscribers keyed by event name.
    var subscribers: Table[string, seq[Subscription]]
    var nextSubscriberId: int = 0

    # Child-side outbound emit file (`ARTURO_EVENT_FILE`). Nil on top-level VM.
    var emitChannel: File = nil

    # Flips inbound tail's `alive` to false during `BeforeExit` drain.
    var shuttingDown: bool = false

#=======================================
# Helpers
#=======================================

when not defined(WEB):
    proc dispatchEvent(name: string, payload: Value) {.gcsafe.}

    proc enqueueEmit(handler: EventHandler, payload: Value) =
        ## Schedule handler on next dispatcher tick (avoids reentrancy).
        let cap = handler
        let pay = payload
        sleepAsync(0).addCallback(proc() {.gcsafe.} =
            {.cast(gcsafe).}:
                try:
                    if cap.param.len > 0:
                        Syms[cap.param] = pay
                    execUnscoped(cap.body)
                except CatchableError as e:
                    echo "Events: handler raised: " & e.msg
        )

    proc initEmitChannel() =
        let path = getEnv("ARTURO_EVENT_FILE")
        if path.len == 0: return
        try:
            var f: File
            if open(f, path, fmAppend):
                emitChannel = f
        except CatchableError:
            discard

    proc initInboundChannel() =
        let path = getEnv("ARTURO_EVENT_INBOUND")
        if path.len == 0: return
        asyncCheck tailEventChannel(path,
            proc(): bool {.gcsafe.} = not shuttingDown)

    proc dispatchEvent(name: string, payload: Value) {.gcsafe.} =
        ## Enqueue each subscriber for `name` on next tick. Shared by
        ## `emit` and OS-signal hooks (CtrlC etc.).
        {.cast(gcsafe).}:
            if subscribers.hasKey(name):
                var oneShotIds: seq[int]
                for sub in subscribers[name]:
                    enqueueEmit(sub.handler, payload)
                    if sub.once:
                        oneShotIds.add(sub.id)
                if oneShotIds.len > 0:
                    var keep: seq[Subscription]
                    for sub in subscribers[name]:
                        if sub.id notin oneShotIds:
                            keep.add(sub)
                    subscribers[name] = keep

# TODO(Events): per-handler unsubscribe via `on`-returned handles.

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =
    when not defined(WEB):

        initEmitChannel()
        setInboundEventDispatcher(dispatchEvent)
        initInboundChannel()

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
                "finished"  : ({Logical},"with `:task`: fire on any termination (default)"),
                "id"        : ({Logical},"return an :integer id identifying this registration (for use with `off`)"),
                "once"      : ({Logical},"with `:event`: auto-remove the handler after its first fire")
            },
            returns     = {Nothing,Integer},
            example     = """
            DataReady: event 'data-ready
            on.with:'payload DataReady [ print ["got:" payload] ]
            ..........
            on CtrlC [ print "graceful shutdown..." ]
            ..........
            ; task callbacks
            t: do.async [pause 200 42]
            on.done.with:'r t [ print ["ok:" r] ]
            on.failed.with:'e t [ print ["fail:" e] ]
            ..........
            on.once E [ print "fires once" ]
            """:
                #=======================================================
                var handler = EventHandler(body: y)
                if checkAttr("with"):
                    handler.param = aWith.s

                inc nextSubscriberId
                let subId = nextSubscriberId
                let sub = Subscription(id: subId, once: hadAttr("once"), handler: handler)

                if xKind == Event:
                    subscribers.mgetOrPut(x.evt.name, @[]).add(sub)
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
                                # (subprocess case, see helpers/parallelism)
                                state = "cancelled"
                                payload = VNULL
                            else:
                                if tsk.state == taskPending:
                                    tsk.state = taskDone
                                state = "done"
                                payload = fin.read()

                            if mode == "finished" or mode == state:
                                # Fire synchronously (we're already inside
                                # the future's dispatcher callback).
                                try:
                                    if cap.param.len > 0:
                                        Syms[cap.param] = payload
                                    execUnscoped(cap.body)
                                except CatchableError as e:
                                    echo "Events: handler raised: " & e.msg
                    )

                if hadAttr("id"):
                    push newInteger(subId)

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
            ; no payload, just emit:
            emit CtrlC
            """:
                #=======================================================
                let payload =
                    if checkAttr("with"): aWith
                    else: VNULL
                dispatchEvent(x.evt.name, payload)
                # Built-in events stay local; user events propagate cross-process.
                let isBuiltIn = x.evt.name in [
                    "CtrlC", "BeforeExit", "SigTerm", "SigHup"
                ]
                if not isBuiltIn:
                    if not emitChannel.isNil:
                        # child → parent: 2-line record (name + codified payload)
                        try:
                            emitChannel.writeLine(x.evt.name)
                            emitChannel.writeLine(codify(payload, safeStrings = true))
                            emitChannel.flushFile()
                        except IOError:
                            discard
                    else:
                        # Parent → all live children. Same two-line wire
                        # format. No-op when there are no live children.
                        broadcastToChildren(x.evt.name, codify(payload, safeStrings = true))

        builtin "off",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "remove registered handler(s), either every handler for given event, or the one with given id",
            args        = {
                "target" : {Event,Integer}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            E: event 'tick
            on E [ print "tick!" ]
            emit E
            off E
            emit E   ; → no-op; nothing prints
            ..........
            ; per-handler removal via the id `on.id` returns:
            id: on.id E [ print "first" ]
            on E [ print "second" ]
            off id          ; drops only the "first" handler
            emit E          ; → second
            """:
                #=======================================================
                if xKind == Event:
                    subscribers.del(x.evt.name)
                else:
                    # per-handler removal by id (linear scan)
                    let targetId = x.i
                    block found:
                        for evtName, subs in subscribers.mpairs:
                            for i in 0 ..< subs.len:
                                if subs[i].id == targetId:
                                    subs.delete(i)
                                    break found

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
        # `dispatchEvent` are not signal-safe, but in practice the
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

        # Process exit → emit `BeforeExit`, drain dispatcher (bounded ~2s).
        addExitProc(proc() {.noconv.} =
            {.cast(gcsafe).}:
                shuttingDown = true
                dispatchEvent("BeforeExit", VNULL)
                var drainTicks = 0
                try:
                    while hasPendingOperations() and drainTicks < 100:
                        poll(0)
                        inc drainTicks
                except CatchableError:
                    discard
        )

        # SIGINT → emit `CtrlC`, drain (Nim invokes hook at safe point).
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
        # and the OS hooks that fire them land in follow-up commits;
        # see EVENT_NOTES.md.
