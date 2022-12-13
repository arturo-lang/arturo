#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Sockets.nim
#=======================================================

## The main Sockets module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import std/net as netsock except Socket
    import nativesockets

import vm/values/custom/[vsocket]

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =
    
    when not defined(WEB):
        builtin "accept",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "accept incoming connection and return corresponding socket",
            args        = {
                "server"    : {Socket}
            },
            attrs       = NoAttrs,
            returns     = {Socket},
            example     = """
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("")

                var client: netsock.Socket
                x.sock.socket.accept(client)

                let socket = initSocket(sock, proto=x.sock.proto, local=false)

                push newSocket(socket)

        builtin "listen",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "start listening on given port and return new socket",
            args        = {
                "port"  : {Integer}
            },
            attrs       = {
                "blocking"  : ({String},"set blocking mode (default: false)"),
                "udp"       : ({Logical},"use UDP instead of TCP")
            },
            returns     = {Socket},
            example     = """
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("")

                let blocking = hadAttr("blocking")
                let protocol = 
                    if hadAttr("udp"): IPPROTO_UDP
                    else: IPPROTO_TCP

                var sock: netsock.Socket = netsock.newSocket(protocol=protocol)
                sock.setSockOpt(OptReuseAddr, true)
                
                sock.getFd().setBlocking(blocking)
                sock.bindAddr(Port(x.i))
                sock.listen()

                let socket = initSocket(sock, proto=protocol, local=true)

                push newSocket(socket)
    else:
        discard

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
