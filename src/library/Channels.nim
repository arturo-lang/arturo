#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Channels.nim
#=======================================================

## The main Channels module
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import os, std/[asyncdispatch, deques, tables]

    import helpers/parallelism

import vm/lib

#=======================================
# Variables
#=======================================

when not defined(WEB):
    # Per-process registry of named channels. Two `channel 'foo` calls
    # in the same process still produce distinct VChannel instances
    # (identity-by-reference), but only the latest registration for a
    # given name is looked up by the inbound-from-children dispatcher.
    # That's how cross-process sends route into the right local channel.
    var channelsByName: Table[string, VChannel] = initTable[string, VChannel]()

    # Cross-process outbound (child → parent). Set at module init when
    # the spawning parent has placed a temp-file path in
    # `ARTURO_CHANNEL_FILE`. While open, every `send Ch v` from this
    # process appends a SEND record (4 lines, uniform) to the file
    # instead of running the local state machine.
    var outboundChannelFile*: File
    var outboundChannelFileOpen*: bool = false

    # Child's own inbound path — used in RECV records so parent knows
    # where to write DELIVER responses for this child.
    var ownChannelInbound*: string = ""

    # Pending proxy-recv futures, keyed by UID — populated when a child
    # calls `receive Ch` (writes RECV), resolved when a DELIVER record
    # arrives on the child's inbound.
    var pendingProxyRecvs: Table[string, Future[Value]] = initTable[string, Future[Value]]()

#=======================================
# Helpers
#=======================================

when not defined(WEB):
    proc proxyReceive*(c: VChannel): Future[Value] =
        ## Cross-process receive: write a RECV record to outbound,
        ## park a future under the generated UID, return it. The
        ## parent's tail registers a remote-receiver entry; when a
        ## value becomes available, the parent writes DELIVER to this
        ## child's inbound; the inbound tail resolves the future.
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
            # if the write fails, complete the future with null so the
            # caller doesn't hang forever
            pendingProxyRecvs.del(uid)
            result.complete(VNULL)

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    when not defined(WEB):

        # Inbound channel dispatcher — parent side: route SEND records
        # from children into the matching local channel by name.
        setInboundChannelDispatcher(proc(name: string, payload: Value) {.gcsafe.} =
            {.cast(gcsafe).}:
                if channelsByName.hasKey(name):
                    discard chanSend(channelsByName[name], payload)
        )

        # Remote-receiver fulfiller — parent side: when a child RECV
        # registers, try to drain one item from the named local channel
        # (buffer or parked sender) and DELIVER it back to that child.
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
                    # if a sender was parked because we were full, move
                    # its value into the freed slot and wake it
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
                    # closed channel with nothing buffered → DELIVER null
                    # so child receives unblock cleanly
                    if c.closed:
                        let (ok, rr) = popRemoteReceiver(name)
                        if ok:
                            writeDeliverRecord(rr.inbound, rr.uid, "null")
                            return true
                    return false
                let (ok, rr) = popRemoteReceiver(name)
                if not ok:
                    # remote was de-registered between RECV and fulfill —
                    # put the picked value back in front of the buffer
                    c.buffer.addFirst(picked)
                    return false
                writeDeliverRecord(rr.inbound, rr.uid, codify(picked, safeStrings = true))
                return true
        )

        # Deliver dispatcher — child side: resolve the pending proxy-recv
        # future under this UID with the delivered payload.
        setDeliverDispatcher(proc(uid: string, payload: Value) {.gcsafe.} =
            {.cast(gcsafe).}:
                if pendingProxyRecvs.hasKey(uid):
                    let fut = pendingProxyRecvs[uid]
                    pendingProxyRecvs.del(uid)
                    fut.complete(payload)
        )

        # If we were spawned by a parent VM, the parent's outbound path
        # lives in `ARTURO_CHANNEL_FILE`. Open it once for append.
        let path = getEnv("ARTURO_CHANNEL_FILE")
        if path.len > 0:
            try:
                if open(outboundChannelFile, path, fmAppend):
                    outboundChannelFileOpen = true
            except CatchableError:
                discard

        # Child's own inbound (parent writes DELIVER records here).
        # Start tailing it so DELIVER records resolve pending proxy
        # `receive` futures by UID. Same `tailChannelFile` proc the
        # parent uses for its outbound side — DELIVER branch handles
        # this direction.
        ownChannelInbound = getEnv("ARTURO_CHANNEL_INBOUND")
        if ownChannelInbound.len > 0:
            asyncCheck tailChannelFile(ownChannelInbound,
                proc(): bool {.gcsafe.} = true)

        # Register the proxy-receive hook for cross-process `receive Ch`.
        # Only relevant in a child VM (outbound file open) — otherwise
        # the hook stays nil and `receive` falls through to local
        # `chanReceive`.
        if outboundChannelFileOpen:
            setProxyReceiveHook(proc(c: VChannel): Future[Value] {.gcsafe.} =
                {.cast(gcsafe).}:
                    return proxyReceive(c)
            )

        # Register the outbound emitter for cross-process `send Ch v`.
        # Uniform 4-line SEND record: "SEND", name, codified-payload, "".
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

        builtin "channel",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "create a new channel with given name",
            args        = {
                "name"  : {Literal,String}
            },
            attrs       = {
                "bounded"   : ({Integer},"bounded buffer of given capacity"),
                "unbounded" : ({Logical},"unbounded buffer (send never blocks)")
            },
            returns     = {Channel},
            example     = """
            Jobs: channel 'jobs              ; unbuffered (send waits for recv)
            ..........
            Jobs: channel.bounded: 10 'jobs  ; bounded
            ..........
            Jobs: channel.unbounded 'jobs    ; never blocks send (use with care)
            """:
                #=======================================================
                var cap = 0
                if checkAttr("bounded"):
                    cap = aBounded.i
                elif hadAttr("unbounded"):
                    cap = -1

                let chn = VChannel(
                    name: x.s,
                    capacity: cap,
                    closed: false,
                    buffer: initDeque[Value](),
                    senders: initDeque[tuple[v: Value, f: Future[void]]](),
                    receivers: initDeque[Future[Value]]()
                )
                channelsByName[x.s] = chn
                push Value(kind: Channel, chn: chn)
