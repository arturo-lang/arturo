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

    import vm/values/custom/[vtask, verror]

import vm/lib

when not defined(WEB):
    import vm/errors

#=======================================
# Definitions
#=======================================

when not defined(WEB):
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
                "all"    : ({Logical},"wait for all tasks in the given block to settle and return their results in order"),
                "first"  : ({Logical},"wait for the first task in the given block to settle and return its result; the others are left running"),
                "cancel" : ({Logical},"with `.first`: cancel the remaining (still-pending) tasks once the winner settles")
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
            """:
                #=======================================================
                if (hadAttr("all")):
                    # accept a block of tasks; block until each settles, return
                    # their resolved values in input order. happy path only —
                    # error propagation is a separate piece of work, so a
                    # cancelled / failing task here is currently undefined.
                    var futures: seq[Future[Value]] = @[]
                    for t in x.a:
                        if unlikely(t.kind != Task):
                            Error_OperationNotPermitted("`wait.all` expects a block of :task values")
                        futures.add(t.tsk.future)
                    let resolved = waitFor all(futures)
                    for t in x.a:
                        if t.tsk.state == taskPending:
                            t.tsk.state = taskDone
                    push newBlock(resolved)
                elif (hadAttr("first")):
                    # accept a block of tasks; block until the first one
                    # settles and return its value. the rest are left alone —
                    # use `cancel` (or a future `.cancel` attr) to abort them.
                    var futures: seq[Future[Value]] = @[]
                    for t in x.a:
                        if unlikely(t.kind != Task):
                            Error_OperationNotPermitted("`wait.first` expects a block of :task values")
                        futures.add(t.tsk.future)
                    let winner = newFuture[Value]("Tasks.waitFirst")
                    for f in futures:
                        f.addCallback(proc(fin: Future[Value]) =
                            if not winner.finished and not fin.failed:
                                winner.complete(fin.read())
                        )
                    let res = waitFor winner
                    let killLosers = hadAttr("cancel")
                    for t in x.a:
                        if t.tsk.state == taskPending:
                            if t.tsk.future.finished:
                                t.tsk.state = taskDone
                            elif killLosers:
                                cancelTask(t)
                    push res
                elif x.tsk.state == taskCancelled:
                    push VNULL
                else:
                    # `waitFor` drives the dispatcher until the future settles.
                    # if the underlying work raised, surface it as an `:error`
                    # value rather than letting the exception escape into the VM.
                    try:
                        let res = waitFor x.tsk.future
                        x.tsk.state = taskDone
                        push res
                    except CatchableError as e:
                        x.tsk.state = taskFailed
                        push newError(RuntimeErr, e.msg)

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

        builtin "done?",
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
            ; while [not? done? t][ pause 100 ]
            """:
                #=======================================================
                push newLogical(x.tsk.state != taskPending or x.tsk.future.finished)
