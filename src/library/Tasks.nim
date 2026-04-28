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
# Helpers
#=======================================

# NOTE(Tasks/runBlockAsync) "real-but-cooperative" execution.
#  the VM holds its state in module-level globals (stack, syms, attrs), so we
#  can't actually run two Arturo blocks in parallel on different OS threads
#  without thread-local-izing all of that. what we *can* do is hand the block
#  to the async dispatcher: the future genuinely starts pending, gets pumped
#  alongside other futures (e.g. `request.async`), and only runs the block
#  when the dispatcher schedules it.
#  this gives real concurrency between an I/O task and a CPU task, but two
#  CPU tasks still run serially - genuine parallelism is a follow-up.
proc runBlockAsync(code: Translation): Future[Value] {.async.} =
    # yield to the dispatcher before doing any work - this is what makes
    # the future genuinely pending until something pumps it
    await sleepAsync(0)
    execUnscoped(code)
    result = stack.pop()

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
        t: task [ 1 + 2 ]
        print done? t                  ; false (genuinely pending)
        print wait t                   ; 3
        ..........
        ; concurrency between I/O and CPU is real:
        req: request.async "https://httpbin.org/delay/1" null
        cpu: task [ inc 'sum, 'sum 1..100000 ]
        ; both pumped by the same dispatcher when we wait
        """:
            #=======================================================
            # TODO(Tasks/task) genuine parallelism (multiple CPU tasks at once)
            #  needs OS threads + thread-local VM state - sweeping VM change.
            #  current shape: cooperative async, see `runBlockAsync` above.
            #  labels: library, enhancement, vm, open discussion
            let evaled = evalOrGet(x)
            push newTask(VTask(state: taskPending, future: runBlockAsync(evaled)))

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
