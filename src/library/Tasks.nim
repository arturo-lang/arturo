#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Tasks.nim
#=======================================================

## The main Tasks module
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

# `asyncdispatch` and `osproc` transitively pull in `nativesockets`, which
# uses procs (e.g. `cstringArrayToSeq`) that aren't available on the JS
# backend. The `:task` value and its operations only make sense outside
# WEB mode anyway, so we gate the whole module on it.
when not defined(WEB):
    import asyncdispatch
    import osproc
    import times

    import helpers/parallelism as ParallelismHelper

    import vm/values/custom/[vtask, verror]

import vm/lib

when not defined(WEB):
    import vm/errors

#=======================================
# Definitions
#=======================================

when not defined(WEB):
    template timeoutMsOf(v: Value): int = ParallelismHelper.timeoutMsOf(v)

    proc cancelTask(tsk: Value) =
        ## Move a `:task` value to the cancelled state and tear down its
        ## underlying handle (subprocess or in-process producer's cancel hook).
        ## Idempotent — calling on a non-pending task is a no-op.
        if tsk.tsk.state != taskPending:
            return
        tsk.tsk.state = taskCancelled
        if not tsk.tsk.process.isNil and tsk.tsk.process.running:
            tsk.tsk.process.terminate()
        if not tsk.tsk.cancelHandle.isNil:
            try: tsk.tsk.cancelHandle()
            except CatchableError: discard

proc defineModule*(moduleName: string) =
    when not defined(WEB):

        #----------------------------
        # Functions
        #----------------------------

        builtin "wait",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "block until given task is finished and return its result",
            args        = {
                "task"  : {Task,Block}
            },
            attrs       = {
                "all"     : ({Logical},"wait for all tasks in the given block to settle and return their results in order"),
                "first"   : ({Logical},"wait for the first task in the given block to settle and return its result; the others are left running"),
                "any"     : ({Integer},"wait for the first N tasks in the given block to settle and return their results in completion order"),
                "cancel"  : ({Logical},"with `.first` or `.any`: cancel the remaining (still-pending) tasks once enough have settled"),
                "timeout" : ({Integer,Quantity},"give up waiting after the given duration (ms by default; accepts time `:quantity` like `2:s`); returns an `:error` value on timeout")
            },
            returns     = {Any,Block},
            example     = """
            ; (draft) once `request.async` lands, this is the natural shape:
            ;
            ; t: request.async "https://example.com"
            ; data: wait t
            ..........
            ; fan-out: fire N tasks, block until all settle
            tasks: map ["alice" "bob" "carol"] 'name [
                request.async ~"https://api.example.com/users/|name|" #[]
            ]
            results: wait.all tasks
            ..........
            ; settle for the first 3 of 5 mirrors that respond — useful
            ; for redundant-fetch patterns. results come back in
            ; completion order (NOT input order), unlike `wait.all`.
            mirrors: map mirror-urls 'u [request.async u #[]]
            top3: wait.any: 3 mirrors                ; block of 3 results
            ; pair with `.cancel` to abort the remaining 2 once we have 3:
            top3: wait.any.cancel: 3 mirrors
            """:
                #=======================================================
                if (hadAttr("all")):
                    # accept a block of tasks; block until each settles, return
                    # their resolved values in input order. failed tasks
                    # surface as `:error` values in their slot; cancelled
                    # tasks surface as `:null` (matching bare `wait`).
                    # with `.timeout`: any task still pending when the budget
                    # runs out gets a timeout `:error` slot; the task itself
                    # is left untouched (still pending — caller can wait again).
                    for t in x.a:
                        if unlikely(t.kind != Task):
                            Error_OperationNotPermitted("`wait.all` expects a block of :task values")
                    var resolved: ValueArray = newSeq[Value](x.a.len)
                    let hasDeadline = checkAttr("timeout")
                    let deadline =
                        if hasDeadline: epochTime() + timeoutMsOf(aTimeout) / 1000
                        else: 0.0
                    for i, t in x.a.pairs:
                        if hasDeadline:
                            let remainingMs = max(0, int((deadline - epochTime()) * 1000))
                            if not ParallelismHelper.coopWait withTimeout(t.tsk.future, remainingMs):
                                resolved[i] = newError(RuntimeErr, "wait.all timed out")
                                continue
                        try:
                            let r = ParallelismHelper.coopWait t.tsk.future
                            if t.tsk.state == taskPending:
                                t.tsk.state = taskDone
                            resolved[i] = r
                        except CatchableError as e:
                            if t.tsk.state == taskCancelled:
                                resolved[i] = VNULL
                            else:
                                t.tsk.state = taskFailed
                                # In-process fibers raise the original
                                # `VError` (with kind, hint, context).
                                # Subprocess-backed tasks raise a generic
                                # exception — fall back to `RuntimeErr`.
                                resolved[i] =
                                    if e of VError: newError(VError(e))
                                    else:           newError(RuntimeErr, e.msg)
                    push newBlock(resolved)
                elif (hadAttr("first")):
                    # accept a block of tasks; block until the first one
                    # settles and return its value (or `:error` if the
                    # winner failed). the rest are left alone — pass
                    # `.cancel` to also abort them.
                    for t in x.a:
                        if unlikely(t.kind != Task):
                            Error_OperationNotPermitted("`wait.first` expects a block of :task values")
                    # `winner` settles when *any* underlying future settles
                    # (success OR failure), so we don't hang if the fastest
                    # task happens to be the failing one.
                    let winner = newFuture[Value]("Tasks.waitFirst")
                    for t in x.a:
                        let cap = t
                        cap.tsk.future.addCallback(proc(fin: Future[Value]) {.gcsafe.} =
                            {.cast(gcsafe).}:
                                if winner.finished: return
                                if fin.failed:
                                    if cap.tsk.state == taskCancelled:
                                        winner.complete(VNULL)
                                    else:
                                        cap.tsk.state = taskFailed
                                        # Preserve real `VError` (kind,
                                        # hint, context) from in-process
                                        # fibers; subprocess tasks fall
                                        # back to `RuntimeErr`.
                                        let err = fin.error
                                        winner.complete(
                                            if err of VError: newError(VError(err))
                                            else:             newError(RuntimeErr, err.msg)
                                        )
                                else:
                                    if cap.tsk.state == taskPending:
                                        cap.tsk.state = taskDone
                                    winner.complete(fin.read())
                        )
                    # `.timeout`: if no task settles within the budget, complete
                    # the winner with a timeout `:error`. underlying tasks are
                    # left untouched (still pending) — pair with `.cancel` to
                    # also abort them.
                    if checkAttr("timeout"):
                        let timer = sleepAsync(timeoutMsOf(aTimeout))
                        timer.addCallback(proc() {.gcsafe.} =
                            {.cast(gcsafe).}:
                                if not winner.finished:
                                    winner.complete(newError(RuntimeErr, "wait.first timed out"))
                        )
                    let res = ParallelismHelper.coopWait winner
                    let killLosers = hadAttr("cancel")
                    for t in x.a:
                        if t.tsk.state == taskPending and killLosers:
                            cancelTask(t)
                    push res
                elif (checkAttr("any")):
                    # accept a block of tasks; block until the first N
                    # settle and return their values in COMPLETION order
                    # (the fastest one ends up at index 0). Failed slots
                    # surface as `:error`, cancelled as `:null` —
                    # matching the rest of the `wait` family.
                    let target = aAny.i
                    if target < 1:
                        Error_OperationNotPermitted("`wait.any` count must be >= 1")
                    if target > x.a.len:
                        Error_OperationNotPermitted("`wait.any` count exceeds number of tasks")
                    for t in x.a:
                        if unlikely(t.kind != Task):
                            Error_OperationNotPermitted("`wait.any` expects a block of :task values")
                    var collected: ValueArray = @[]
                    let sentinel = newFuture[Value]("Tasks.waitAny")
                    for t in x.a:
                        let cap = t
                        cap.tsk.future.addCallback(proc(fin: Future[Value]) {.gcsafe.} =
                            {.cast(gcsafe).}:
                                if sentinel.finished: return
                                var resolved: Value
                                if fin.failed:
                                    if cap.tsk.state == taskCancelled:
                                        resolved = VNULL
                                    else:
                                        cap.tsk.state = taskFailed
                                        # Same `VError`-preservation as
                                        # `.first` / `.all`: in-process
                                        # fibers carry the real kind+hint;
                                        # subprocess fall back to `RuntimeErr`.
                                        let err = fin.error
                                        resolved =
                                            if err of VError: newError(VError(err))
                                            else:             newError(RuntimeErr, err.msg)
                                else:
                                    if cap.tsk.state == taskPending:
                                        cap.tsk.state = taskDone
                                    resolved = fin.read()
                                collected.add(resolved)
                                if collected.len >= target:
                                    sentinel.complete(VNULL)
                        )
                    discard ParallelismHelper.coopWait sentinel
                    let killLosers = hadAttr("cancel")
                    for t in x.a:
                        if t.tsk.state == taskPending and killLosers:
                            cancelTask(t)
                    push newBlock(collected)
                elif x.tsk.state == taskCancelled:
                    push VNULL
                else:
                    # optional `.timeout`: race the task's future against a
                    # sleep timer; on timeout return `:error` and leave the
                    # task pending (timeout is a wait-side concept — the
                    # work itself isn't broken, the user can wait again).
                    var timedOut = false
                    if checkAttr("timeout"):
                        let ms = timeoutMsOf(aTimeout)
                        if not ParallelismHelper.coopWait withTimeout(x.tsk.future, ms):
                            timedOut = true
                    if timedOut:
                        push newError(RuntimeErr, "wait timed out")
                    else:
                        # `coopWait` drives the dispatcher AND our fiber
                        # scheduler until the future settles. if the
                        # underlying work raised, surface it as an `:error`
                        # value rather than letting the exception escape
                        # into the VM.
                        try:
                            let res = ParallelismHelper.coopWait x.tsk.future
                            x.tsk.state = taskDone
                            push res
                        except CatchableError as e:
                            # if the task was cancelled mid-await, the producer's
                            # cancel hook closed an underlying handle and the
                            # in-flight future raised here. that's not a failure,
                            # so we still return `:null` to match cancelled-before-
                            # wait behavior. a genuine error otherwise.
                            if x.tsk.state == taskCancelled:
                                push VNULL
                            else:
                                x.tsk.state = taskFailed
                                # Preserve real `VError` (kind, hint,
                                # context) from in-process fibers; fall
                                # back to `RuntimeErr` for subprocess
                                # tasks where the underlying error type
                                # is opaque.
                                push (
                                    if e of VError: newError(VError(e))
                                    else:           newError(RuntimeErr, e.msg)
                                )

        builtin "cancel",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "abort given task if still pending",
            args        = {
                "task"  : {Task}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            ; cancel a long-running task
            s: serve.async.silent.port: 9000 [
                GET "/" -> "hi"
            ]
            ..........
            pause 1000
            cancel s          ; actually kills the child process
            """:
                #=======================================================
                cancelTask(x)

        #----------------------------
        # Predicates
        #----------------------------

        builtin "failed?",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "check if given task ended in failure",
            args        = {
                "task"  : {Task}
            },
            attrs       = NoAttrs,
            returns     = {Logical},
            example     = """
            ; t: do.async [1 / 0]
            ; wait t
            ; failed? t   ; => true
            """:
                #=======================================================
                push newLogical(x.tsk.state == taskFailed)

        builtin "finished?",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "check if given task has finished (successfully, with error, or cancelled)",
            args        = {
                "task"  : {Task}
            },
            attrs       = NoAttrs,
            returns     = {Logical},
            example     = """
            ; (draft) poll a task without blocking
            ;
            ; t: request.async "https://example.com"
            ; while [not? finished? t][ pause 100 ]
            """:
                #=======================================================
                push newLogical(x.tsk.state != taskPending or x.tsk.future.finished)
