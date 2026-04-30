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
    import asyncdispatch, asyncfile, asynchttpserver, httpclient, httpcore
    import os, osproc
    import strutils, times
    when defined(ssl):
        # std/net has to be qualified — there's a sibling `helpers/net.nim`
        # and Nim resolves bare `net` to it first.
        import std/net as netmod

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

    # convenience: turn a piece of Arturo source into a pending `:task` value.
    # used by `.async` branches across the stdlib.
    proc spawnAsTask*(src: string): Value =
        # the VTask has to exist before `runInChildProcess` runs so it can
        # publish the `Process` handle onto it for `cancel` to reach
        let tsk = VTask(state: taskPending)
        tsk.future = runInChildProcess(tsk, src)
        result = newTask(tsk)

    # in-process async download via Nim's `AsyncHttpClient`. unlike the subprocess
    # path, this stays in the same VM: no fork/exec overhead, no separate Arturo
    # interpreter, just a `Future[void]` from the dispatcher wrapped to return
    # `VNULL` (mirroring the sync `download` builtin's `Nothing` return).
    #
    # caveat: in-process futures only progress while the dispatcher is being
    # driven (i.e. during `wait` / `waitFor`). that's fine for the usual flow
    # — launch, do other things, then `wait` — but pure fire-and-forget won't
    # actually transfer bytes until something dispatches.
    proc downloadFileAsync(client: AsyncHttpClient, url, target: string): Future[Value] {.async.} =
        # let CatchableError escape — `wait` classifies it (cancel → :null,
        # otherwise → :error). cancellation closes the client and surfaces
        # here as an exception, which `wait` filters out via task state.
        try:
            await client.downloadFile(url, target)
            result = VNULL
        finally:
            try: client.close()
            except CatchableError: discard

    # in-process async file read via `asyncfile`. returns the raw bytes/text;
    # the caller (`read.async` builtin) is responsible for any post-processing
    # like CSV/JSON/markdown parsing — that's pure CPU work and stays sync.
    proc readFileAsyncStr(f: AsyncFile): Future[string] {.async.} =
        # let CatchableError escape — `wait` classifies it (cancel → :null,
        # otherwise → :error). cancellation closes the file and surfaces
        # here as an exception, filtered out downstream via task state.
        try:
            result = await f.readAll()
        finally:
            try: f.close()
            except CatchableError: discard

    # convenience: kick off an in-process async read, run a sync `postProcess`
    # closure on the bytes once available, and return a `:task` whose result
    # is whatever the closure returned. the open file is held by the task so
    # `cancel` can `close()` it and abort an in-flight read.
    proc spawnAsyncRead*(path: string, postProcess: proc(src: string): Value): Value =
        let f = openAsync(path, fmRead)
        proc go(): Future[Value] {.async.} =
            let src = await readFileAsyncStr(f)
            result = postProcess(src)
        let tsk = VTask(state: taskPending)
        tsk.future = go()
        tsk.cancelHandle = proc() =
            try: f.close()
            except CatchableError: discard
        result = newTask(tsk)

    # in-process async file write via `asyncfile`. content is already
    # serialized by the caller (e.g. JSON-encoded), so this layer just
    # streams bytes to disk through the dispatcher.
    proc writeFileAsync(f: AsyncFile, content: string): Future[Value] {.async.} =
        # let CatchableError escape — `wait` classifies it (cancel → :null,
        # otherwise → :error). cancellation closes the file and surfaces
        # here as an exception, filtered out downstream via task state.
        try:
            await f.write(content)
            result = VNULL
        finally:
            try: f.close()
            except CatchableError: discard

    # convenience: kick off an in-process async write and return a `:task`.
    # the open file is held by the task so `cancel` can `close()` it and
    # abort an in-flight write.
    proc spawnAsyncWrite*(path, content: string, append: bool): Value =
        let mode = if append: fmAppend else: fmWrite
        let f = openAsync(path, mode)
        let tsk = VTask(state: taskPending)
        tsk.future = writeFileAsync(f, content)
        tsk.cancelHandle = proc() =
            try: f.close()
            except CatchableError: discard
        result = newTask(tsk)

    # in-process async HTTP request via Nim's `AsyncHttpClient`. the response
    # is awaited, the body is drained, and the caller-provided `buildResponse`
    # closure converts the raw fields into a Value (so the response shape
    # stays driven by Net.nim, not this helper).
    proc requestAsync(client: AsyncHttpClient, url: string, meth: HttpMethod,
                      body: string, multipart: MultipartData,
                      buildResponse: proc(version, body, status: string,
                                          headers: HttpHeaders): Value
                     ): Future[Value] {.async.} =
        # let CatchableError escape — `wait` classifies it based on task state
        # (cancellation → :null, anything else → :error). this is intentionally
        # *not* a mirror of sync `request`'s null-on-failure behavior: a `:task`
        # is a richer abstraction and users can introspect/recover via `:error`.
        try:
            let response = await client.request(url = url, httpMethod = meth,
                                                body = body, multipart = multipart)
            let bodyStr = await response.body
            result = buildResponse(response.version, bodyStr,
                                   response.status, response.headers)
        finally:
            try: client.close()
            except CatchableError: discard

    # convenience: kick off an in-process async HTTP request and return a
    # `:task`. the client is held by the task so `cancel` can `close()` it
    # and abort the in-flight request.
    proc spawnAsyncRequest*(client: AsyncHttpClient, url: string, meth: HttpMethod,
                            body: string, multipart: MultipartData,
                            buildResponse: proc(version, body, status: string,
                                                headers: HttpHeaders): Value
                           ): Value =
        let tsk = VTask(state: taskPending)
        tsk.future = requestAsync(client, url, meth, body, multipart, buildResponse)
        tsk.cancelHandle = proc() =
            try: client.close()
            except CatchableError: discard
        result = newTask(tsk)

    # convenience: kick off an in-process async download and return a `:task`.
    # parallels `spawnAsTask` but skips the subprocess machinery entirely.
    # the client is held by the task so `cancel` can `close()` it and abort
    # the in-flight download.
    proc spawnAsyncDownload*(url, target: string): Value =
        when defined(ssl):
            let client = newAsyncHttpClient(sslContext = netmod.newContext(verifyMode = CVerifyNone))
        else:
            let client = newAsyncHttpClient()
        let tsk = VTask(state: taskPending)
        tsk.future = downloadFileAsync(client, url, target)
        tsk.cancelHandle = proc() =
            try: client.close()
            except CatchableError: discard
        result = newTask(tsk)

    # in-process async HTTP server via Nim's `asynchttpserver`. the caller
    # provides a `handler` closure that processes each request; we own the
    # server lifecycle so `cancel` can `close()` it and free the port.
    proc spawnAsyncServe*(port: int,
                          handler: proc(req: Request): Future[void] {.async, gcsafe.}
                         ): Value =
        let server = newAsyncHttpServer()
        proc go(): Future[Value] {.async.} =
            # let CatchableError escape — `wait` classifies it (cancel → :null,
            # otherwise → :error, e.g. EADDRINUSE on bind). cancellation
            # closes the server and surfaces here as an exception, filtered
            # out downstream via task state.
            try:
                await server.serve(Port(port), handler)
                result = VNULL
            finally:
                try: server.close()
                except CatchableError: discard
        let tsk = VTask(state: taskPending)
        tsk.future = go()
        tsk.cancelHandle = proc() =
            try: server.close()
            except CatchableError: discard
        result = newTask(tsk)

    # block on a task's future and return its result. used by `wait` and `do task`.
    proc drainTask*(tsk: VTask): Value =
        if tsk.state == taskCancelled:
            result = VNULL
        else:
            result = waitFor tsk.future
            tsk.state = taskDone
