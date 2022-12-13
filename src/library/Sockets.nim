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

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =
    
    when not defined(WEB):
        builtin "listen",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "Start listening on given port and return corresponding socket",
            args        = {
                "port"  : {Integer}
            },
            attrs       = {
                "blocking"  : ({String},"set blocking mode (default: false)")
            },
            returns     = {Socket},
            example     = """
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("")

                let blocking = hadAttr("blocking")

                var socket: netsock.Socket = netsock.newSocket()
                socket.setSockOpt(OptReuseAddr, true)
                
                socket.getFd().setBlocking(blocking)
                socket.bindAddr(Port(x.i))
                socket.listen()

                push newSocket(socket)
    else:
        discard

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
