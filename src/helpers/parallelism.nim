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
    import asyncdispatch, asyncfile, httpclient, httpcore
    import os, osproc
    import std/tempfiles
    import streams, strtabs, strutils, times
    when defined(posix):
        import posix
    import asyncnet, deques
    when defined(ssl):
        # std/net has to be qualified, there's a sibling `helpers/net.nim`
        # and Nim resolves bare `net` to it first.
        import std/net as netmod
        import extras/smtp

    import extras/minicoro

    import vm/lib
    import vm/[context, exec, parse, stack]
    import vm/values/custom/[vtask, verror]

#=======================================
# Fibers - stackful coroutines via vendored minicoro
#=======================================
# Asymmetric: main `resume(f)`, fiber `suspend()`. A→B = suspend to
# main, then resume B. Under `--mm:orc`, refs reachable only via a
# suspended fiber stay alive by refcount; no `GC_addStack` needed.

when not defined(WEB):
    const
        DefaultFiberStackSize* = 256 * 1024     ## 256KB per fiber

    type
        Fiber* = ref object
            handle: McoCoroPtr
            entry: proc ()
            ctx*: VMContext                     ## per-fiber VM globals slice; nil if outside scheduler

    proc fiberCheck(res: McoResult, op: string) {.inline.} =
        if res != mcoSuccess:
            raise newException(CatchableError,
                "fiber " & op & " failed: " & $mco_result_description(res))

    proc fiberTrampoline(co: McoCoroPtr) {.cdecl.} =
        let f = cast[Fiber](mco_get_user_data(co))
        f.entry()

    proc createFiber*(entry: proc (),
                      stackSize: int = DefaultFiberStackSize): Fiber =
        ## Create suspended fiber. First `resume` runs `entry`. On return,
        ## fiber becomes `mcoDead`; clean up with `destroyFiber`.
        result = Fiber(entry: entry)
        GC_ref(result)  # keep alive while minicoro holds the user_data ptr
        var desc = mco_desc_init(fiberTrampoline, csize_t(stackSize))
        desc.userData = cast[pointer](result)
        var co: McoCoroPtr
        fiberCheck(mco_create(addr co, addr desc), "create")
        result.handle = co

    proc destroyFiber*(f: Fiber) =
        ## Release fiber stack + struct. Only when suspended or dead.
        if f.handle != nil:
            fiberCheck(mco_destroy(f.handle), "destroy")
            f.handle = nil
            GC_unref(f)

    proc resume*(f: Fiber) {.inline.} =
        fiberCheck(mco_resume(f.handle), "resume")

    proc suspend*() {.inline.} =
        fiberCheck(mco_yield(mco_running()), "suspend")

    proc isDone*(f: Fiber): bool {.inline.} =
        mco_status(f.handle) == mcoDead

    proc currentFiberHandle*(): McoCoroPtr {.inline.} =
        ## minicoro handle of running fiber, nil on main thread.
        mco_running()

#=======================================
# Scheduler - fibers + asyncdispatch
#=======================================
# Main owns the asyncdispatch poll loop; fibers yield via
# `cooperativeAwait`. `currentFiber == nil` means main is running.

when not defined(WEB):
    type
        FiberCancelledError* = object of CatchableError
            ## Raised when the running fiber's `cancelRequested` flag is set.

        Scheduler = object
            mainCtx: VMContext
            currentFiber: Fiber
            ready: seq[Fiber]

    var scheduler {.global.}: Scheduler

    proc initScheduler*() =
        ## Reset scheduler. Idempotent.
        if scheduler.mainCtx.isNil:
            scheduler.mainCtx = VMContext()
        scheduler.currentFiber = nil
        scheduler.ready.setLen(0)

    proc readyLen*(): int {.inline.} =
        scheduler.ready.len

    proc onMainFiber*(): bool {.inline.} =
        scheduler.currentFiber.isNil

    proc spawnFiber*(entry: proc (), parentSyms: SymTable): Fiber =
        ## Create fiber with fresh VMContext (shallow-copied syms), queue ready.
        if scheduler.mainCtx.isNil:
            initScheduler()
        result = createFiber(entry)
        result.ctx = newVMContext(parentSyms)
        scheduler.ready.add(result)

    proc runOneStep*() =
        ## Resume next ready fiber or poll dispatcher once.
        if scheduler.ready.len > 0:
            let f = scheduler.ready[0]
            scheduler.ready.delete(0)
            if isDone(f):                     # cancel race: already-done fiber re-queued
                return
            scheduler.currentFiber = f
            swapOutTo(scheduler.mainCtx)
            swapInFrom(f.ctx)
            resume(f)
            swapOutTo(f.ctx)
            swapInFrom(scheduler.mainCtx)
            scheduler.currentFiber = nil
        elif hasPendingOperations():
            poll()

    proc runScheduledFibers*() =
        ## Drain ready queue + asyncdispatch until both empty.
        while scheduler.ready.len > 0 or hasPendingOperations():
            runOneStep()

    proc pumpScheduler*(timeoutMs: int) =
        ## Single tick: drain ready fibers, poll for `timeoutMs`. Used by REPL idle.
        while scheduler.ready.len > 0:
            runOneStep()
        if hasPendingOperations():
            try: poll(timeoutMs)
            except CatchableError: discard

    proc runUntilFutureDone*[T](fut: Future[T]): T =
        ## Block on `fut` from main, driving fibers + I/O. Raises if
        ## both queues drain while `fut` still pending.
        while not fut.finished:
            if scheduler.ready.len == 0 and not hasPendingOperations():
                raise newException(CatchableError,
                    "runUntilFutureDone: no pending work, future will never complete")
            runOneStep()
        when T is void:
            fut.read()
        else:
            return fut.read()

    proc cooperativeAwait*[T](fut: Future[T]): T =
        ## Suspend current fiber until `fut` completes. Fiber-only;
        ## main thread should use `waitFor`.
        let me = scheduler.currentFiber
        doAssert not me.isNil,
            "cooperativeAwait called outside a fiber, use waitFor on main"
        if me.ctx.cancelRequested:
            raise newException(FiberCancelledError, "task cancelled")
        if not fut.finished:
            fut.addCallback(proc () {.gcsafe.} =
                {.cast(gcsafe).}:
                    scheduler.ready.add(me))
            suspend()
            if me.ctx.cancelRequested:
                raise newException(FiberCancelledError, "task cancelled")
        when T is void:
            fut.read()
        else:
            return fut.read()

    proc coopWait*[T](fut: Future[T]): T =
        ## Block on `fut` from any context. Drives scheduler on main,
        ## yields on fiber.
        if onMainFiber():
            when T is void:
                runUntilFutureDone(fut)
            else:
                return runUntilFutureDone(fut)
        else:
            when T is void:
                cooperativeAwait(fut)
            else:
                return cooperativeAwait(fut)

#=======================================
# Cross-process event dispatch hook
#=======================================

when not defined(WEB):
    # Events.nim registers its dispatcher here. nil if Events not loaded.
    var inboundEventDispatcher*: proc(name: string, payload: Value) {.gcsafe.} = nil

    proc setInboundEventDispatcher*(fn: proc(name: string, payload: Value) {.gcsafe.}) =
        inboundEventDispatcher = fn

    # Cross-process channels: wire format is uniform 4-line records.
    #   SEND     name  payload  ""
    #   RECV     name  uid      child-inbound-path
    #   DELIVER  uid   payload  ""

    var inboundChannelDispatcher*: proc(name: string, payload: Value) {.gcsafe.} = nil

    proc setInboundChannelDispatcher*(fn: proc(name: string, payload: Value) {.gcsafe.}) =
        inboundChannelDispatcher = fn

    var outboundChannelEmitter*: proc(name: string, payload: Value): bool {.gcsafe.} = nil

    proc setOutboundChannelEmitter*(fn: proc(name: string, payload: Value): bool {.gcsafe.}) =
        outboundChannelEmitter = fn

    proc emitToOutboundChannel*(name: string, payload: Value): bool {.gcsafe.} =
        {.cast(gcsafe).}:
            if outboundChannelEmitter.isNil:
                return false
            return outboundChannelEmitter(name, payload)

    type RemoteReceiver* = object
        uid*: string
        inbound*: string

    var remoteReceivers: Table[string, Deque[RemoteReceiver]]

    proc registerRemoteReceiver*(name: string, rr: RemoteReceiver) =
        if not remoteReceivers.hasKey(name):
            remoteReceivers[name] = initDeque[RemoteReceiver]()
        remoteReceivers[name].addLast(rr)

    proc popRemoteReceiver*(name: string): (bool, RemoteReceiver) =
        if remoteReceivers.hasKey(name) and remoteReceivers[name].len > 0:
            return (true, remoteReceivers[name].popFirst())
        return (false, RemoteReceiver())

    proc writeDeliverRecord*(inbound: string, uid: string, payloadSrc: string) {.gcsafe.} =
        {.cast(gcsafe).}:
            try:
                var f: File
                if open(f, inbound, fmAppend):
                    f.writeLine("DELIVER")
                    f.writeLine(uid)
                    f.writeLine(payloadSrc)
                    f.writeLine("")
                    f.flushFile()
                    f.close()
            except IOError, OSError:
                discard

    var uidCounter: int = 0
    proc genReceiveUid*(): string =
        inc uidCounter
        result = "r-" & $getCurrentProcessId() & "-" & $uidCounter

    var remoteReceiverFulfiller*: proc(name: string): bool {.gcsafe.} = nil

    proc setRemoteReceiverFulfiller*(fn: proc(name: string): bool {.gcsafe.}) =
        remoteReceiverFulfiller = fn

    proc tryFulfillRemoteReceiver*(name: string): bool {.gcsafe.} =
        {.cast(gcsafe).}:
            if remoteReceiverFulfiller.isNil:
                return false
            return remoteReceiverFulfiller(name)

    var deliverDispatcher*: proc(uid: string, payload: Value) {.gcsafe.} = nil

    proc setDeliverDispatcher*(fn: proc(uid: string, payload: Value) {.gcsafe.}) =
        deliverDispatcher = fn

    proc dispatchDeliver(uid: string, payload: Value) {.gcsafe.} =
        {.cast(gcsafe).}:
            if not deliverDispatcher.isNil:
                deliverDispatcher(uid, payload)

    var proxyReceiveHook*: proc(c: VChannel): Future[Value] {.gcsafe.} = nil

    proc setProxyReceiveHook*(fn: proc(c: VChannel): Future[Value] {.gcsafe.}) =
        proxyReceiveHook = fn

    proc tryProxyReceive*(c: VChannel): (bool, Future[Value]) {.gcsafe.} =
        {.cast(gcsafe).}:
            if proxyReceiveHook.isNil:
                return (false, Future[Value](nil))
            return (true, proxyReceiveHook(c))

    proc dispatchInboundChannel(name: string, payload: Value) {.gcsafe.} =
        {.cast(gcsafe).}:
            if not inboundChannelDispatcher.isNil:
                inboundChannelDispatcher(name, payload)

    # Shim hides the procvar from the `async` macro's gcsafety analyzer.
    proc dispatchInbound(name: string, payload: Value) {.gcsafe.} =
        {.cast(gcsafe).}:
            if not inboundEventDispatcher.isNil:
                inboundEventDispatcher(name, payload)

    proc cooperativePause*(ms: int) =
        ## Sleep without freezing in-flight tasks. Yields on fiber,
        ## drives scheduler on main with pending work, plain OS sleep otherwise.
        if not onMainFiber():
            cooperativeAwait sleepAsync(ms)
        elif scheduler.ready.len > 0 or hasPendingOperations():
            try:
                runUntilFutureDone(sleepAsync(ms))
            except CatchableError:
                discard
        else:
            sleep(ms)

    # Per-child inbound files for parent→child event broadcast.
    var childInboundFiles: seq[string] = @[]

    proc registerChildInbound*(path: string) =
        childInboundFiles.add(path)

    proc unregisterChildInbound*(path: string) =
        let idx = childInboundFiles.find(path)
        if idx >= 0:
            childInboundFiles.delete(idx)

    proc broadcastToChildren*(name: string, payloadSrc: string) {.gcsafe.} =
        ## Append 2-line record to every live child's inbound file.
        {.cast(gcsafe).}:
            for path in childInboundFiles:
                try:
                    var f: File
                    if open(f, path, fmAppend):
                        f.writeLine(name)
                        f.writeLine(payloadSrc)
                        f.flushFile()
                        f.close()
                except IOError, OSError:
                    discard

    {.push warning[GcUnsafe2]: off.}
    proc tailEventChannel*(path: string, alive: proc(): bool {.gcsafe.}) {.async, gcsafe.} =
        ## Tail child's event file, 2-line records (name + codified payload).
        ## Re-opens each pass to dodge stdio EOF-stickiness.
        var pos: int64 = 0
        while true:
            block oneRound:
                var f: File
                if not open(f, path, fmRead):
                    break oneRound
                defer: f.close()
                f.setFilePos(pos)
                var name: string
                var payloadSrc: string
                while f.readLine(name):
                    if not f.readLine(payloadSrc):
                        break
                    pos = f.getFilePos()
                    if inboundEventDispatcher.isNil: continue
                    try:
                        {.cast(gcsafe).}:
                            let parsed = doParse(payloadSrc, isFile=false)
                            var payload = VNULL
                            if not parsed.isNil:
                                let savedSP = SP
                                execUnscoped(parsed)
                                if SP > savedSP:
                                    payload = stack.pop()
                            dispatchInbound(name, payload)
                    except CatchableError:
                        discard
            if not alive():
                # one more pass already happened above, safe to exit
                break
            await sleepAsync(20)
    {.pop.}

    {.push warning[GcUnsafe2]: off.}
    proc tailChannelFile*(path: string, alive: proc(): bool {.gcsafe.}) {.async, gcsafe.} =
        var pos: int64 = 0
        while true:
            block oneRound:
                var f: File
                if not open(f, path, fmRead):
                    break oneRound
                defer: f.close()
                f.setFilePos(pos)
                var recType: string
                var lineB, lineC, lineD: string
                while f.readLine(recType):
                    if not f.readLine(lineB): break
                    if not f.readLine(lineC): break
                    if not f.readLine(lineD): break
                    pos = f.getFilePos()
                    case recType
                        of "SEND":
                            if inboundChannelDispatcher.isNil: continue
                            try:
                                {.cast(gcsafe).}:
                                    let parsed = doParse(lineC, isFile=false)
                                    var payload = VNULL
                                    if not parsed.isNil:
                                        let savedSP = SP
                                        execUnscoped(parsed)
                                        if SP > savedSP:
                                            payload = stack.pop()
                                    dispatchInboundChannel(lineB, payload)
                            except CatchableError:
                                discard
                        of "RECV":
                            registerRemoteReceiver(lineB, RemoteReceiver(uid: lineC, inbound: lineD))
                            try:
                                {.cast(gcsafe).}:
                                    discard tryFulfillRemoteReceiver(lineB)
                            except CatchableError:
                                discard
                        of "DELIVER":
                            try:
                                {.cast(gcsafe).}:
                                    let parsed = doParse(lineC, isFile=false)
                                    var payload = VNULL
                                    if not parsed.isNil:
                                        let savedSP = SP
                                        execUnscoped(parsed)
                                        if SP > savedSP:
                                            payload = stack.pop()
                                    dispatchDeliver(lineB, payload)
                            except CatchableError:
                                discard
                        else: discard
            if not alive():
                break
            await sleepAsync(20)
    {.pop.}

    #=======================================
    # Channel primitives
    #=======================================
    # Cooperative state machine over a `VChannel`. Single-threaded
    # under `--threads:off`; every `await` is the sync point.

    proc chanSend*(c: VChannel, v: Value): Future[void] =
        result = newFuture[void]("channel.send")
        if c.closed:
            result.fail(newException(CatchableError, "send on closed channel"))
            return
        if c.receivers.len > 0:
            let r = c.receivers.popFirst()
            r.complete(v)
            result.complete()
            return
        let (hasRemote, rr) = popRemoteReceiver(c.name)
        if hasRemote:
            writeDeliverRecord(rr.inbound, rr.uid, codify(v, safeStrings = true))
            result.complete()
            return
        if c.capacity == -1 or (c.capacity > 0 and c.buffer.len < c.capacity):
            c.buffer.addLast(v)
            result.complete()
            return
        c.senders.addLast((v: v, f: result))

    proc chanReceive*(c: VChannel): Future[Value] =
        result = newFuture[Value]("channel.receive")
        if c.buffer.len > 0:
            let v = c.buffer.popFirst()
            if c.senders.len > 0:
                let s = c.senders.popFirst()
                c.buffer.addLast(s.v)
                s.f.complete()
            result.complete(v)
            return
        if c.senders.len > 0:
            let s = c.senders.popFirst()
            s.f.complete()
            result.complete(s.v)
            return
        if c.closed:
            result.complete(VNULL)
            return
        c.receivers.addLast(result)

    proc chanClose*(c: VChannel) =
        if c.closed:
            return
        c.closed = true
        while c.receivers.len > 0 and c.buffer.len == 0:
            let r = c.receivers.popFirst()
            r.complete(VNULL)
        while c.senders.len > 0:
            let s = c.senders.popFirst()
            s.f.fail(newException(CatchableError, "send on closed channel"))
        if remoteReceivers.hasKey(c.name):
            while remoteReceivers[c.name].len > 0:
                let rr = remoteReceivers[c.name].popFirst()
                writeDeliverRecord(rr.inbound, rr.uid, "null")

    # Per-process channel state.
    var channelsByName*: Table[string, VChannel] = initTable[string, VChannel]()
    var outboundChannelFile*: File
    var outboundChannelFileOpen*: bool = false
    var ownChannelInbound*: string = ""
    var pendingProxyRecvs*: Table[string, Future[Value]] = initTable[string, Future[Value]]()

    proc proxyReceive*(c: VChannel): Future[Value] =
        let uid = genReceiveUid()
        result = newFuture[Value]("channel.proxyReceive")
        pendingProxyRecvs[uid] = result
        try:
            outboundChannelFile.writeLine("RECV")
            outboundChannelFile.writeLine(c.name)
            outboundChannelFile.writeLine(uid)
            outboundChannelFile.writeLine(ownChannelInbound)
            outboundChannelFile.flushFile()
        except IOError:
            pendingProxyRecvs.del(uid)
            result.complete(VNULL)

    proc initChannels*() =
        setInboundChannelDispatcher(proc(name: string, payload: Value) {.gcsafe.} =
            {.cast(gcsafe).}:
                if channelsByName.hasKey(name):
                    discard chanSend(channelsByName[name], payload)
        )

        setRemoteReceiverFulfiller(proc(name: string): bool {.gcsafe.} =
            {.cast(gcsafe).}:
                if not channelsByName.hasKey(name):
                    return false
                let c = channelsByName[name]
                var picked: Value
                var have = false
                if c.buffer.len > 0:
                    picked = c.buffer.popFirst()
                    have = true
                    if c.senders.len > 0:
                        let s = c.senders.popFirst()
                        c.buffer.addLast(s.v)
                        s.f.complete()
                elif c.senders.len > 0:
                    let s = c.senders.popFirst()
                    s.f.complete()
                    picked = s.v
                    have = true
                if not have:
                    if c.closed:
                        let (ok, rr) = popRemoteReceiver(name)
                        if ok:
                            writeDeliverRecord(rr.inbound, rr.uid, "null")
                            return true
                    return false
                let (ok, rr) = popRemoteReceiver(name)
                if not ok:
                    c.buffer.addFirst(picked)
                    return false
                writeDeliverRecord(rr.inbound, rr.uid, codify(picked, safeStrings = true))
                return true
        )

        setDeliverDispatcher(proc(uid: string, payload: Value) {.gcsafe.} =
            {.cast(gcsafe).}:
                if pendingProxyRecvs.hasKey(uid):
                    let fut = pendingProxyRecvs[uid]
                    pendingProxyRecvs.del(uid)
                    fut.complete(payload)
        )

        let path = getEnv("ARTURO_CHANNEL_FILE")
        if path.len > 0:
            try:
                if open(outboundChannelFile, path, fmAppend):
                    outboundChannelFileOpen = true
            except CatchableError:
                discard

        ownChannelInbound = getEnv("ARTURO_CHANNEL_INBOUND")
        if ownChannelInbound.len > 0:
            asyncCheck tailChannelFile(ownChannelInbound,
                proc(): bool {.gcsafe.} = true)

        if outboundChannelFileOpen:
            setProxyReceiveHook(proc(c: VChannel): Future[Value] {.gcsafe.} =
                {.cast(gcsafe).}:
                    return proxyReceive(c)
            )

        setOutboundChannelEmitter(proc(name: string, payload: Value): bool {.gcsafe.} =
            {.cast(gcsafe).}:
                if not outboundChannelFileOpen:
                    return false
                try:
                    outboundChannelFile.writeLine("SEND")
                    outboundChannelFile.writeLine(name)
                    outboundChannelFile.writeLine(codify(payload, safeStrings = true))
                    outboundChannelFile.writeLine("")
                    outboundChannelFile.flushFile()
                    return true
                except IOError:
                    return false
        )

#=======================================
# Subprocess-isolated path (`do.async.isolated`)
#=======================================
# ~30 ms fork+exec, fresh VM, no closure capture. True parallelism via
# OS scheduler. In-process fiber path (`spawnInProcessDoBlock`) is the
# default for plain `do.async`.

when not defined(WEB):
    proc detachToOwnGroup(p: Process) {.inline.} =
        ## Put child in own pgid so `terminateGroup` kills grandchildren too.
        when defined(posix):
            discard setpgid(Pid(p.processID), Pid(p.processID))

    proc terminateGroup(p: Process) {.inline.} =
        ## POSIX: kill process group. Windows: plain terminate.
        when defined(posix):
            discard posix.kill(Pid(-p.processID), cint(SIGTERM))
        else:
            p.terminate()

    # Spawn child Arturo process, return future settling on exit. Child
    # writes result to temp file; we inherit its stdio so `print` flows live.
    proc runInChildProcess*(tsk: VTask, blockSrc: string): Future[Value] {.async.} =
        let arturoBin = getAppFilename()
        let resFile = genTempPath("arturo-task-", ".art")
        let errFile = genTempPath("arturo-err-", ".art")        ## VError kind+msg side-channel
        let evtFile = genTempPath("arturo-evt-", ".art")        ## child→parent events
        writeFile(evtFile, "")
        let inboundFile = genTempPath("arturo-inb-", ".art")    ## parent→child events
        writeFile(inboundFile, "")
        registerChildInbound(inboundFile)
        let chanFile = genTempPath("arturo-chn-", ".art")
        writeFile(chanFile, "")
        let chanInbound = genTempPath("arturo-cin-", ".art")
        writeFile(chanInbound, "")
        var childEnv = newStringTable(modeCaseSensitive)
        for k, v in envPairs():
            childEnv[k] = v
        childEnv["ARTURO_EVENT_FILE"] = evtFile
        childEnv["ARTURO_EVENT_INBOUND"] = inboundFile
        childEnv["ARTURO_CHANNEL_FILE"] = chanFile
        childEnv["ARTURO_CHANNEL_INBOUND"] = chanInbound
        # Leading `null` keeps void blocks safe (last `print` etc.)
        let safeBlock =
            if blockSrc.len >= 2 and blockSrc[0] == '[':
                "[null " & blockSrc[1 .. blockSrc.high]
            else:
                "[null " & blockSrc & "]"
        # Forward-slash paths: Windows backslashes would clash with
        # Arturo string-escape parsing inside embedded source.
        let resFileEmbed = resFile.replace('\\', '/')
        let errFileEmbed = errFile.replace('\\', '/')
        let wrapped =
            "__err__: try.verbose [\n" &
            "    __res__: do " & safeBlock & "\n" &
            "    write express.safe __res__ \"" & resFileEmbed & "\"\n" &
            "]\n" &
            "unless null? __err__ [\n" &
            "    write express.safe #[kind: __err__\\kind\\label msg: __err__\\message] \"" & errFileEmbed & "\"\n" &
            "]"
        let p = startProcess(arturoBin,
                             args = @["-e", wrapped],
                             env = childEnv,
                             options = {poUsePath, poParentStreams})
        detachToOwnGroup(p)
        tsk.process = p                  ## published so `cancel` can terminate
        let proc1 = p
        let tailFut = tailEventChannel(evtFile, proc(): bool {.gcsafe.} =
            {.cast(gcsafe).}: proc1.running)
        let chanTailFut = tailChannelFile(chanFile, proc(): bool {.gcsafe.} =
            {.cast(gcsafe).}: proc1.running)
        while p.running and tsk.state != taskCancelled:
            await sleepAsync(50)
        if tsk.state == taskCancelled and p.running:
            terminateGroup(p)
            discard p.waitForExit()
        let code = p.peekExitCode()
        p.close()
        # Drain trailing events written between last poll and exit.
        try:
            await tailFut
        except CatchableError:
            discard
        try:
            await chanTailFut
        except CatchableError:
            discard
        if fileExists(evtFile):
            try: removeFile(evtFile)
            except CatchableError: discard
        if fileExists(chanFile):
            try: removeFile(chanFile)
            except CatchableError: discard
        if fileExists(chanInbound):
            try: removeFile(chanInbound)
            except CatchableError: discard
        unregisterChildInbound(inboundFile)
        if fileExists(inboundFile):
            try: removeFile(inboundFile)
            except CatchableError: discard
        # Reconstruct VError from child's side-channel if present.
        if fileExists(errFile):
            let rawErr = readFile(errFile)
            removeFile(errFile)
            if fileExists(resFile): removeFile(resFile)
            var rebuiltKind = RuntimeErr
            var rebuiltMsg = ""
            try:
                let parsed = doParse(rawErr, isFile=false)
                if not parsed.isNil:
                    let savedSP = SP
                    execUnscoped(parsed)
                    if SP > savedSP:
                        let dict = stack.pop()
                        if dict.kind == Dictionary:
                            if dict.d.hasKey("kind") and dict.d["kind"].kind == String:
                                rebuiltKind = kindByLabel(dict.d["kind"].s)
                            if dict.d.hasKey("msg") and dict.d["msg"].kind == String:
                                rebuiltMsg = dict.d["msg"].s
            except CatchableError:
                discard
            raise toError(rebuiltKind, rebuiltMsg)
        elif code == 0 and fileExists(resFile):
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
            # cancellation is not a failure, caller observes via task state.
            # for any other non-zero exit, fail the future so `wait` can
            # surface it as an `:error` value.
            if tsk.state == taskCancelled:
                result = VNULL
            else:
                raise newException(CatchableError,
                    "task subprocess exited with code " & $code)

    # `execCmdEx`-style spawn: stdout+stderr captured together. Non-zero
    # exit fails future with captured output in message.
    proc runShellInChildProcess*(tsk: VTask, fullCmd: string,
                                 withCode: bool): Future[Value] {.async.} =
        let p = startProcess(command = fullCmd,
                             options = {poUsePath, poEvalCommand, poStdErrToStdOut})
        detachToOwnGroup(p)
        tsk.process = p
        while p.running and tsk.state != taskCancelled:
            await sleepAsync(50)
        if tsk.state == taskCancelled and p.running:
            terminateGroup(p)
            discard p.waitForExit()
        let code = p.peekExitCode()
        var output = ""
        try:
            output = p.outputStream.readAll()
        except CatchableError:
            discard
        p.close()
        # cancellation always → :null, regardless of `.code`. consistent with
        # the rest of the `:task` family (cancel is not a failure).
        if tsk.state == taskCancelled:
            result = VNULL
        elif withCode:
            result = newDictionary({
                "output": newString(output),
                "code": newInteger(code)
            }.toOrderedTable)
        else:
            if code == 0:
                result = newString(output)
            else:
                let trimmed = output.strip()
                let suffix = if trimmed.len > 0: ": " & trimmed else: ""
                raise newException(CatchableError,
                    "shell command exited with code " & $code & suffix)

    # convenience: turn a piece of Arturo source into a pending `:task` value.
    # used by `.async` branches across the stdlib.
    proc spawnAsTask*(src: string, name: string = ""): Value =
        # the VTask has to exist before `runInChildProcess` runs so it can
        # publish the `Process` handle onto it for `cancel` to reach
        let tsk = VTask(state: taskPending, name: name)
        tsk.future = runInChildProcess(tsk, src)
        result = newTask(tsk)

    # convenience: turn a shell command into a pending `:task`. used by
    # `execute.async`. `withCode` toggles the resolved-value shape between
    # bare output string and `#[output: code:]` dict (mirrors `execute.code`).
    proc spawnShellAsTask*(fullCmd: string, withCode: bool, name: string = ""): Value =
        let tsk = VTask(state: taskPending, name: name)
        tsk.future = runShellInChildProcess(tsk, fullCmd, withCode)
        result = newTask(tsk)

#=======================================
# In-process path (default `do.async`)
#=======================================
# Cooperative fibers in the same VM. Sub-ms spawn, closure capture,
# real `:error` fidelity. Default `do.async [...]` and spawn primitive
# for `.parallel` iterators.

when not defined(WEB):
    proc spawnInProcessDoBlock*(blk: Value, name: string = "", eager: bool = false): Value =
        ## `eager`: run the fiber until first yield before returning the task.
        ## Default `false` keeps `.parallel` fan-out cheap (helper-direct
        ## callers); `do.async` builtin opts-in unless `.lazy` set.
        let tsk = VTask(state: taskPending, name: name)
        let fut = newFuture[Value]("do.async")
        tsk.future = fut

        var f: Fiber                              ## shared between entry + cancel hook

        proc fiberEntry() {.gcsafe.} =
            {.cast(gcsafe).}:
                try:
                    let prevSP = SP
                    execUnscoped(blk)
                    let res =
                        if SP > prevSP: pop()
                        else:           VNULL
                    tsk.state = taskDone
                    fut.complete(res)
                except FiberCancelledError:
                    tsk.state = taskCancelled
                    fut.fail(newException(FiberCancelledError,
                        "task cancelled"))
                except CatchableError as e:
                    tsk.state = taskFailed
                    fut.fail(e)

        f = spawnFiber(fiberEntry, Syms)

        let cancelCtx = f.ctx
        let cancelF = f
        tsk.cancelHandle = proc () {.gcsafe.} =
            {.cast(gcsafe).}:
                cancelCtx.cancelRequested = true
                if not isDone(cancelF):
                    scheduler.ready.add(cancelF)

        result = newTask(tsk)

        if eager and onMainFiber():
            # one slice from main: fiber runs until first yield or completion
            runOneStep()

    # In-process async helpers via Nim's `asyncdispatch` family.
    # Errors escape; `wait` classifies (cancel → :null, else → :error).

    proc downloadFileAsync(client: AsyncHttpClient, url, target: string): Future[Value] {.async.} =
        try:
            await client.downloadFile(url, target)
            result = VNULL
        finally:
            try: client.close()
            except CatchableError: discard

    proc readFileAsyncStr(f: AsyncFile): Future[string] {.async.} =
        try:
            result = await f.readAll()
        finally:
            try: f.close()
            except CatchableError: discard

    proc readUrlAsyncStr(client: AsyncHttpClient, url: string): Future[string] {.async.} =
        try:
            result = await client.getContent(url)
        finally:
            try: client.close()
            except CatchableError: discard

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

    proc spawnAsyncReadUrl*(url: string, postProcess: proc(src: string): Value): Value =
        when defined(ssl):
            let client = newAsyncHttpClient(sslContext = netmod.newContext(verifyMode = CVerifyNone))
        else:
            let client = newAsyncHttpClient()
        proc go(): Future[Value] {.async.} =
            let src = await readUrlAsyncStr(client, url)
            result = postProcess(src)
        let tsk = VTask(state: taskPending)
        tsk.future = go()
        tsk.cancelHandle = proc() =
            try: client.close()
            except CatchableError: discard
        result = newTask(tsk)

    when defined(ssl):
        proc mailAsyncSend(smtp: AsyncSmtp, server: string, port: int,
                           username, password, fromAddr: string,
                           toAddrs: seq[string], msgStr: string): Future[Value] {.async.} =
            try:
                await smtp.connect(server, Port(port))
                await smtp.auth(username, password)
                await smtp.sendMail(fromAddr, toAddrs, msgStr)
                result = VNULL
            finally:
                try: await smtp.close()
                except CatchableError: discard

        proc spawnAsyncMail*(server: string, port: int,
                             username, password, fromAddr: string,
                             toAddrs: seq[string], msgStr: string,
                             useSsl = true): Value =
            let smtp = newAsyncSmtp(useSsl = useSsl)
            let tsk = VTask(state: taskPending)
            tsk.future = mailAsyncSend(smtp, server, port, username, password,
                                       fromAddr, toAddrs, msgStr)
            tsk.cancelHandle = proc() =
                try: smtp.sock.close()
                except CatchableError: discard
            result = newTask(tsk)

    proc writeFileAsync(f: AsyncFile, content: string): Future[Value] {.async.} =
        try:
            await f.write(content)
            result = VNULL
        finally:
            try: f.close()
            except CatchableError: discard

    proc spawnAsyncWrite*(path, content: string, append: bool): Value =
        let mode = if append: fmAppend else: fmWrite
        let f = openAsync(path, mode)
        let tsk = VTask(state: taskPending)
        tsk.future = writeFileAsync(f, content)
        tsk.cancelHandle = proc() =
            try: f.close()
            except CatchableError: discard
        result = newTask(tsk)

    # AsyncSocket.recvLine has no native timeout, race against sleepAsync.
    proc receiveAsync(sock: AsyncSocket, maxLen: int, timeoutMs: int): Future[Value] {.async.} =
        let inner = sock.recvLine(maxLength = maxLen)
        if timeoutMs > 0:
            let inTime = await withTimeout(inner, timeoutMs)
            if not inTime:
                try: sock.close()
                except CatchableError: discard
                raise newException(CatchableError,
                    "receive.async timed out after " & $timeoutMs & "ms")
            return newString(inner.read)
        let line = await inner
        return newString(line)

    # convenience: kick off an in-process async `recvLine` and return a
    # `:task`. cancel closes the underlying socket to unblock the recv.
    proc spawnAsyncReceive*(sock: AsyncSocket, maxLen: int, timeoutMs: int = -1): Value =
        let tsk = VTask(state: taskPending)
        tsk.future = receiveAsync(sock, maxLen, timeoutMs)
        tsk.cancelHandle = proc() =
            try: sock.close()
            except CatchableError: discard
        result = newTask(tsk)

    # `postProcess` builds the Value (e.g. wraps sock), keeps `vsocket`
    # plumbing out of this helper.
    proc connectAsync(sock: AsyncSocket, address: string, port: Port,
                      isUDP: bool,
                      postProcess: proc(): Value): Future[Value] {.async.} =
        if not isUDP:
            await sock.connect(address, port)
        return postProcess()

    proc spawnAsyncConnect*(sock: AsyncSocket, address: string, port: Port,
                            isUDP: bool,
                            postProcess: proc(): Value): Value =
        let tsk = VTask(state: taskPending)
        tsk.future = connectAsync(sock, address, port, isUDP, postProcess)
        tsk.cancelHandle = proc() =
            try: sock.close()
            except CatchableError: discard
        result = newTask(tsk)

    # `buildResponse` is provided by Net.nim so response shape stays there.
    proc requestAsync(client: AsyncHttpClient, url: string, meth: HttpMethod,
                      body: string, multipart: MultipartData,
                      buildResponse: proc(version, body, status: string,
                                          headers: HttpHeaders): Value
                     ): Future[Value] {.async.} =
        try:
            let response = await client.request(url = url, httpMethod = meth,
                                                body = body, multipart = multipart)
            let bodyStr = await response.body
            result = buildResponse(response.version, bodyStr,
                                   response.status, response.headers)
        finally:
            try: client.close()
            except CatchableError: discard

    proc spawnAsyncRequest*(client: AsyncHttpClient, url: string, meth: HttpMethod,
                            body: string, multipart: MultipartData,
                            buildResponse: proc(version, body, status: string,
                                                headers: HttpHeaders): Value,
                            timeoutMs: int = -1
                           ): Value =
        let tsk = VTask(state: taskPending)
        let inner = requestAsync(client, url, meth, body, multipart, buildResponse)
        # AsyncHttpClient has no per-request timeout, race against sleepAsync.
        if timeoutMs > 0:
            proc gated(): Future[Value] {.async.} =
                let inTime = await withTimeout(inner, timeoutMs)
                if not inTime:
                    try: client.close()
                    except CatchableError: discard
                    raise newException(CatchableError,
                        "request.async timed out after " & $timeoutMs & "ms")
                return inner.read
            tsk.future = gated()
        else:
            tsk.future = inner
        tsk.cancelHandle = proc() =
            try: client.close()
            except CatchableError: discard
        result = newTask(tsk)

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

    proc timeoutMsOf*(v: Value): int =
        ## Read a `.timeout:` attr value (Integer = ms, Quantity = converted to ms).
        case v.kind
        of Integer:  v.i
        of Quantity: toInt((v.q.convertTo(parseAtoms("ms"))).original)
        else:        0

    proc drainTask*(tsk: VTask, timeoutMs: int = -1): Value =
        ## Sugar for `do task`. Failures → :error, cancellation → :null.
        ## On timeout returns :error but leaves task pending.
        if tsk.state == taskCancelled:
            return VNULL
        try:
            if timeoutMs >= 0:
                if not coopWait withTimeout(tsk.future, timeoutMs):
                    return newError(RuntimeErr, "do timed out")
            result = coopWait tsk.future
            if tsk.state == taskPending:
                tsk.state = taskDone
        except CatchableError as e:
            if tsk.state == taskCancelled:
                result = VNULL
            else:
                tsk.state = taskFailed
                result =
                    if e of VError: newError(VError(e))
                    else:           newError(RuntimeErr, e.msg)
