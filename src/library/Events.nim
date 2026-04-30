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
    import tables

    import vm/values/custom/[vevent]

import vm/lib

when not defined(WEB):
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

    proc dispatchEvent(name: string, payload: Value) {.gcsafe.} =
        ## Look up subscribers for the named event and enqueue each on
        ## the next dispatcher tick. Shared by the `emit` builtin and
        ## the OS-level hooks for built-in events (`CtrlC`, `SigTerm`, …).
        {.cast(gcsafe).}:
            if subscribers.hasKey(name):
                for handler in subscribers[name]:
                    enqueueEmit(handler, payload)

# TODO(Events): unsubscribe (`off`) — deferred until someone needs it.
#  Subscribers currently live until program end; for v1 that's fine.

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =
    when not defined(WEB):

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
            description = "register a handler block to fire whenever given event is emitted",
            args        = {
                "event"  : {Event},
                "action" : {Block,Bytecode}
            },
            attrs       = {
                "with"   : ({Literal},"bind the emitted payload to given symbol inside the handler")
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
            """:
                #=======================================================
                var handler = EventHandler(body: y)
                if checkAttr("with"):
                    handler.param = aWith.s
                subscribers.mgetOrPut(x.evt.name, @[]).add(handler)

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

        #----------------------------
        # Constants
        #----------------------------

        constant "CtrlC",
            alias       = unaliased,
            description = "built-in event fired when the user presses Ctrl+C":
                newEvent("CtrlC")

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
