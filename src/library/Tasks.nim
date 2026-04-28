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

import vm/lib
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
            # TODO(Tasks/wait) actually block on the underlying future
            #  for now we only handle already-settled tasks; once a real
            #  producer exists we'll need to drive the async dispatcher here
            #  labels: library, enhancement
            case x.tsk.state
                of taskDone:
                    push cast[Value](x.tsk.result)
                of taskFailed:
                    push cast[Value](x.tsk.error)
                of taskCancelled:
                    push VNULL
                of taskPending:
                    # no real producer wired yet - placeholder behaviour
                    push VNULL

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
            push newLogical(x.tsk.state != taskPending)
