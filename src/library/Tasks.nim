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

import asyncdispatch
import osproc

import vm/lib
import vm/values/custom/[vtask]

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    builtin "wait",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "block until given task is finished and return its result",
        args        = {
            "task"  : {Task}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
        ; (draft) once `request.async` lands, this is the natural shape:
        ;
        ; t: request.async "https://example.com"
        ; data: wait t
        """:
            #=======================================================
            if x.tsk.state == taskCancelled:
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
