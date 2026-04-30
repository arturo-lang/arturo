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

    import vm/values/custom/[vtask]

import vm/lib

when not defined(WEB):
    import vm/errors

#=======================================
# Definitions
#=======================================

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
                "all"   : ({Logical},"wait for all tasks in the given block to settle and return their results in order"),
                "first" : ({Logical},"wait for the first task in the given block to settle and return its result; the others are left running")
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
                    for t in x.a:
                        if t.tsk.state == taskPending and t.tsk.future.finished:
                            t.tsk.state = taskDone
                    push res
                elif x.tsk.state == taskCancelled:
                    push VNULL
                else:
                    # `waitFor` drives the dispatcher until the future settles
                    let res = waitFor x.tsk.future
                    x.tsk.state = taskDone
                    push res

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
                if x.tsk.state == taskPending:
                    x.tsk.state = taskCancelled
                    # for subprocess-backed tasks, terminate the child immediately.
                    # the polling loop in `runInChildProcess` will notice the state
                    # transition and finish cleanly, but `terminate` makes it instant.
                    if not x.tsk.process.isNil and x.tsk.process.running:
                        x.tsk.process.terminate()
                    # for in-process tasks, run the producer's cancel hook (closes
                    # the underlying file/http client/etc. so the suspended future
                    # actually unwinds with an error rather than running to
                    # completion in the background).
                    if not x.tsk.cancelHandle.isNil:
                        try: x.tsk.cancelHandle()
                        except CatchableError: discard

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
