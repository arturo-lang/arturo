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
    import asyncdispatch, asyncfile, httpclient
    import os, osproc
    import strutils, times
    when defined(ssl):
        import net as netmod

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

    # in-process async download via Nim's `AsyncHttpClient`. unlike the subprocess
    # path, this stays in the same VM: no fork/exec overhead, no separate Arturo
    # interpreter, just a `Future[void]` from the dispatcher wrapped to return
    # `VNULL` (mirroring the sync `download` builtin's `Nothing` return).
    #
    # caveat: in-process futures only progress while the dispatcher is being
    # driven (i.e. during `wait` / `waitFor`). that's fine for the usual flow
    # — launch, do other things, then `wait` — but pure fire-and-forget won't
    # actually transfer bytes until something dispatches.
    proc downloadFileAsync(url, target: string): Future[Value] {.async.} =
        when defined(ssl):
            var client = newAsyncHttpClient(sslContext = netmod.newContext(verifyMode = CVerifyNone))
        else:
            var client = newAsyncHttpClient()
        try:
            await client.downloadFile(url, target)
        finally:
            client.close()
        result = VNULL

    # in-process async file read via `asyncfile`. returns the raw bytes/text;
    # the caller (`read.async` builtin) is responsible for any post-processing
    # like CSV/JSON/markdown parsing — that's pure CPU work and stays sync.
    proc readFileAsyncStr*(path: string): Future[string] {.async.} =
        var f = openAsync(path, fmRead)
        try:
            result = await f.readAll()
        finally:
            f.close()

    # convenience: kick off an in-process async read, run a sync `postProcess`
    # closure on the bytes once available, and push a `:task` whose result is
    # whatever the closure returned.
    proc spawnAsyncRead*(path: string, postProcess: proc(src: string): Value) =
        proc go(p: string): Future[Value] {.async.} =
            let src = await readFileAsyncStr(p)
            result = postProcess(src)
        let tsk = VTask(state: taskPending)
        tsk.future = go(path)
        push newTask(tsk)

    # in-process async file write via `asyncfile`. content is already
    # serialized by the caller (e.g. JSON-encoded), so this layer just
    # streams bytes to disk through the dispatcher.
    proc writeFileAsync(path, content: string, append: bool): Future[Value] {.async.} =
        let mode = if append: fmAppend else: fmWrite
        var f = openAsync(path, mode)
        try:
            await f.write(content)
        finally:
            f.close()
        result = VNULL

    # convenience: kick off an in-process async write and push a `:task`.
    proc spawnAsyncWrite*(path, content: string, append: bool) =
        let tsk = VTask(state: taskPending)
        tsk.future = writeFileAsync(path, content, append)
        push newTask(tsk)

    # convenience: kick off an in-process async download and push a `:task`.
    # parallels `spawnAsTask` but skips the subprocess machinery entirely.
    proc spawnAsyncDownload*(url, target: string) =
        let tsk = VTask(state: taskPending)
        tsk.future = downloadFileAsync(url, target)
        push newTask(tsk)

    # block on a task's future and push its result. used by `wait` and `do task`.
    proc drainTask*(tsk: VTask) =
        if tsk.state == taskCancelled:
            push VNULL
        else:
            let res = waitFor tsk.future
            tsk.state = taskDone
            push res
