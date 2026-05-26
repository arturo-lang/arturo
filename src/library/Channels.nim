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
    import std/[asyncdispatch, deques]

import vm/lib

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    when not defined(WEB):

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
                push Value(kind: Channel, chn: chn)
