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

import vm/lib
import vm/[eval, exec]
import vm/values/custom/[vtask]

#=======================================
# Definitions
#=======================================

# TODO(Tasks) the whole module is currently a draft scaffold
#  there are no producers of `:task` values yet (e.g. `request.async`, `read.async`, ...)
#  so `wait` / `done?` / `cancel` only operate on the bookkeeping state of a freshly-created
#  task. once we wire `:task` to an actual `Future[Value]` (or a `Process` handle), these
#  builtins will need to drive the dispatcher / poll the underlying handle.
#  labels: library, enhancement, open discussion

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    builtin "task",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "wrap given block in a task and return its handle",
        args        = {
            "code"  : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Task},
        example     = """
        ; (draft) for now `task` runs the block synchronously and returns
        ; an already-settled task - useful for plumbing/composition while
        ; we work out the real concurrent execution model.
        ;
        ; t: task [ 1 + 2 ]
        ; print wait t          ; 3
        """:
            #=======================================================
            # TODO(Tasks/task) actually run the block off the main VM
            #  the VM is not reentrant under `await`, so for now we evaluate
            #  the block synchronously and return an already-completed task.
            #  the API shape is what matters here - the real concurrency story
            #  comes once we have a producer-side dispatcher.
            #  labels: library, enhancement, open discussion
            let evaled = evalOrGet(x)
            execUnscoped(evaled)
            let res = stack.pop()

            let f = newFuture[Value]("task")
            f.complete(res)

            push newTask(VTask(state: taskDone, future: f))

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
        ; (draft) cancel a long-running task
        ;
        ; t: download.async "https://example.com/big.zip" "out.zip"
        ; cancel t
        """:
            #=======================================================
            # TODO(Tasks/cancel) signal the underlying future / process
            #  once we have real producers (`Future[Value]`, `Process`, timers),
            #  cancellation has to actually interrupt them - not just flip the flag
            #  labels: library, enhancement
            if x.tsk.state == taskPending:
                x.tsk.state = taskCancelled

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
