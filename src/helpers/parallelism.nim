#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/parallelism.nim
#=======================================================

## Helpers for the `:task` value and `.async` builtins.

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import asyncdispatch
    import os, osproc
    import strutils, times

    import vm/lib
    import vm/[exec, parse, stack]
    import vm/values/custom/vtask

#=======================================
# Helpers
#=======================================

when not defined(WEB):
    # spawn a child arturo process to evaluate `blockSrc`, return a future that
    # settles when the child exits. result is whatever the child's expression
    # evaluated to, deserialized via `express`/`doParse` round-trip.
    #
    # this is THE primitive for "real" background work: the child has its own
    # VM, so it runs genuinely in parallel with whatever the main code is doing.
    # we poll with a 50ms granularity and yield to the dispatcher between polls,
    # which means other futures keep making progress.
    #
    # we INHERIT the child's stdout/stderr (so any `print` inside the async
    # block flows live to the user's terminal) and use a temp file for the
    # result hand-off. capturing stdout would swallow user prints.
    proc runInChildProcess*(tsk: VTask, blockSrc: string): Future[Value] {.async.} =
        let arturoBin = getAppFilename()
        let resFile = getTempDir() / ("arturo-task-" & $getCurrentProcessId() & "-" & $epochTime() & ".art")
        # void-safety trick: prepend `null` *inside* the user's block so the
        # block always has a value even if the user's last expression doesn't
        # push (e.g. ends with `print`). if the user does push a real value,
        # that supersedes the leading `null` as the topmost stack value.
        let safeBlock =
            if blockSrc.len >= 2 and blockSrc[0] == '[':
                "[null " & blockSrc[1 .. blockSrc.high]
            else:
                "[null " & blockSrc & "]"
        # `.safe` uses `«« »»` string delimiters and quotes dict keys -
        # round-trip-safe for anything Arturo can represent (HTTP responses,
        # dicts with hyphenated keys, strings containing curly braces, etc.)
        let wrapped =
            "res: null\n" &
            "try [ res: do " & safeBlock & " ]\n" &
            "write express.safe res \"" & resFile & "\""
        let p = startProcess(arturoBin,
                             args = @["-e", wrapped],
                             options = {poUsePath, poParentStreams})
        # publish the process handle so `cancel` can terminate it
        tsk.process = p
        while p.running and tsk.state != taskCancelled:
            await sleepAsync(50)
        if tsk.state == taskCancelled and p.running:
            p.terminate()
            discard p.waitForExit()
        let code = p.peekExitCode()
        p.close()
        if code == 0 and fileExists(resFile):
            let raw = readFile(resFile)
            removeFile(resFile)
            try:
                let parsed = doParse(raw, isFile=false)
                if not parsed.isNil:
                    let savedSP = SP
                    execUnscoped(parsed)
                    if SP > savedSP:
                        result = stack.pop()
                    else:
                        result = VNULL
                else:
                    result = VNULL
            except CatchableError:
                result = VNULL
        else:
            if fileExists(resFile): removeFile(resFile)
            # real error propagation is a follow-up; for now: null on failure
            result = VNULL

    # convenience: turn a piece of Arturo source into a pending `:task` value
    # and push it onto the stack. used by `.async` branches across the stdlib.
    proc spawnAsTask*(src: string) =
        # the VTask has to exist before `runInChildProcess` runs so it can
        # publish the `Process` handle onto it for `cancel` to reach
        let tsk = VTask(state: taskPending)
        tsk.future = runInChildProcess(tsk, src)
        push newTask(tsk)

    # block on a task's future and push its result. used by `wait` and `do task`.
    proc drainTask*(tsk: VTask) =
        if tsk.state == taskCancelled:
            push VNULL
        else:
            let res = waitFor tsk.future
            tsk.state = taskDone
            push res
