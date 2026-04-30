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
    # Subscribers indexed by event name. Each `on e [...]` appends a
    # handler `Value` (a Function) here; `emit` looks up by name and
    # schedules each handler on the next dispatcher tick.
    var subscribers: Table[string, seq[Value]]

#=======================================
# Helpers
#=======================================

when not defined(WEB):
    proc enqueueEmit(handler: Value, payload: Value) =
        ## Schedule a handler invocation on the next dispatcher tick.
        ## Avoids reentrancy surprises: `emit` never runs handlers
        ## synchronously — they fire from `sleepAsync(0)`'s callback.
        let cap = handler
        let pay = payload
        sleepAsync(0).addCallback(proc() {.gcsafe.} =
            {.cast(gcsafe).}:
                try:
                    if cap.arity > 0:
                        callFunction(cap, "<event>", @[pay])
                    else:
                        callFunction(cap, "<event>", @[])
                except CatchableError as e:
                    # v1 policy: a raising handler doesn't poison the
                    # queue — log a warning and move on. Revisit if we
                    # want an UnhandledError event later.
                    echo "Events: handler raised: " & e.msg
        )

# TODO(Events): unsubscribe (`off`) — deferred until someone needs it.
#  Subscribers currently live until program end; for v1 that's fine.

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =
    when not defined(WEB):
        discard
        # Builtins (`event`, `on`, `emit`) and the pre-bound built-in
        # events (`CtrlC`, `BeforeExit`, `SigTerm`, `SigHup`) land in
        # follow-up commits — see EVENT_NOTES.md.
