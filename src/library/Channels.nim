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
    # process appends a 2-line record to the file instead of running
    # the local state machine — letting the parent's `tailChannelFile`
    # deliver into its real local channel.
    var outboundChannelFile*: File
    var outboundChannelFileOpen*: bool = false

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    when not defined(WEB):

        # Channel dispatcher — routes a (name, payload) inbound from a
        # child VM into the matching local `:channel` via `chanSend`.
        # If the name isn't registered, the record is dropped silently.
        setInboundChannelDispatcher(proc(name: string, payload: Value) {.gcsafe.} =
            {.cast(gcsafe).}:
                if channelsByName.hasKey(name):
                    discard chanSend(channelsByName[name], payload)
        )

        # If we were spawned by a parent VM, the parent's path lives
        # in `ARTURO_CHANNEL_FILE`. Open it once for append.
        let path = getEnv("ARTURO_CHANNEL_FILE")
        if path.len > 0:
            try:
                if open(outboundChannelFile, path, fmAppend):
                    outboundChannelFileOpen = true
            except CatchableError:
                discard

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
