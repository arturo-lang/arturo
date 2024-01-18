#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
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

when not defined(WEB):
    import vm/errors

#=======================================
# Definitions
#=======================================

# TODO(Sockets) Verify the whole module & check for missing functionality
#  obviously this cannot be done with unit-tests as easily as with other modules, but
#  we'd still have to verify it works as expected and track down possibly-missing
#  features
#  labels: open discussion

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------
    
    when not defined(WEB):

        builtin "accept",
            alias       = unaliased,
            op          = opNop, 
            rule        = PrefixPrecedence,
            description = "accept incoming connection and return corresponding socket",
            args        = {
                "server"    : {Socket}
            },
            attrs       = NoAttrs,
            returns     = {Socket},
            example     = """
            server: listen.blocking 18966
            print "started server connection..."

            client: accept server
            print ["accepted incoming connection from:" client]
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("accept")

                var client: netsock.Socket
                x.sock.socket.accept(client)

                let (address,port) = getPeerAddr(client)

                let socket = initSocket(client, proto=x.sock.protocol, address=address, port=port)
                push newSocket(socket)

        builtin "connect",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "create new socket connection to given server port",
            args        = {
                "port"  : {Integer}
            },
            attrs       = {
                "to"        : ({String},"set socket address"),
                "udp"       : ({Logical},"use UDP instead of TCP")
            },
            returns     = {Socket},
            example     = """
            ; connect to local server on port 18966
            server: connect 18966
            ..........
            ; "connect" to a udp server on port 12345
            server: connect.udp 12345
            ..........
            ; connect to a remote server on port 18966
            server: connect.to:"123.456.789.123" 18966
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("connect")

                let isUDP = hadAttr("udp")

                let protocol = 
                    if isUDP: IPPROTO_UDP
                    else: IPPROTO_TCP

                var toAddress: string  
                if checkAttr("to"):
                    toAddress = aTo.s
                else:
                    toAddress = "0.0.0.0"

                var port = Port(x.i)

                var sock: netsock.Socket = netsock.newSocket(protocol=protocol)
                if not isUDP:
                    sock.connect(toAddress, port)

                let socket = initSocket(sock, proto=protocol, address=toAddress, port=port)

                push newSocket(socket)

        builtin "listen",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "start listening on given port and return new socket",
            args        = {
                "port"  : {Integer}
            },
            attrs       = {
                "blocking"  : ({Logical},"set blocking mode (default: false)"),
                "udp"       : ({Logical},"use UDP instead of TCP")
            },
            returns     = {Socket},
            example     = """
            ; start a server listening on port 18966
            server: listen 18966
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("listen")

                let blocking = hadAttr("blocking")
                let protocol = 
                    if hadAttr("udp"): IPPROTO_UDP
                    else: IPPROTO_TCP

                var sock: netsock.Socket = netsock.newSocket(protocol=protocol)
                sock.setSockOpt(OptReuseAddr, true)
                
                sock.getFd().setBlocking(blocking)
                sock.bindAddr(Port(x.i))
                sock.listen()

                let (address,port) = getLocalAddr(sock)

                let socket = initSocket(sock, proto=protocol, address=address, port=port)

                push newSocket(socket)

        builtin "receive",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "receive line of data from selected socket",
            args        = {
                "origin"    : {Socket}  
            },
            attrs       = {
                "size"      : ({Integer},"set maximum size of received data"),
                "timeout"   : ({Integer},"set timeout (in milliseconds)")
            },
            returns     = {String},
            example     = """
            server: listen.blocking 18966
            print "started server connection..."

            client: accept server
            print ["accepted incoming connection from:" client]

            keepGoing: true
            while [keepGoing][
                message: receive client
                print ["received message:" message]

                if message = "exit" [
                    unplug client
                    keepGoing: false
                ]
            ]

            unplug server
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("receive")

                var size = MaxLineLength
                if checkAttr("size"):
                    size = aSize.i

                var timeout = -1
                if checkAttr("timeout"):
                    timeout = aTimeout.i

                push newString(x.sock.socket.recvLine(timeout=timeout, maxLength=size))

        builtin "send",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "send given message to selected socket",
            args        = {
                "destination"   : {Socket},
                "message"       : {String}    
            },
            attrs       = {
                "chunk"     : ({Logical},"don't send data as a line of data")
            },
            returns     = {Nothing},
            example     = """
            ; connect to a local server on port 256
            socket: connect.to:"localhost" 256

            ; send a message to the server
            send socket "Hello Socket World"
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("send")

                let asChunk = hadAttr("chunk")

                let message = 
                    if asChunk: y.s
                    else: y.s & "\r\L"

                x.sock.socket.send(message)

        builtin "unplug",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "close given socket",
            args        = {
                "socket"    : {Socket} 
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            ; connect to a local server on port 256
            socket: connect.to:"localhost" 256

            ; send a message to the server
            send socket "Hello Socket World"

            ; disconnect from the server
            unplug socket
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("unplug")

                x.sock.socket.close()

    #----------------------------
    # Predicates
    #----------------------------

    when not defined(WEB):

        builtin "send?",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "send given message to selected socket and return true if successful",
            args        = {
                "destination"   : {Socket},
                "message"       : {String}    
            },
            attrs       = NoAttrs,
            returns     = {Logical},
            example     = """
            ; connect to a local server on port 256
            socket: connect.to:"localhost" 256

            ; send a message to the server
            ; and check if it was successful
            sent?: send? socket "Hello Socket World"

            print ["Message was sent successfully:" sent?]
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("send?")

                push newLogical(x.sock.socket.trySend(y.s))

#=======================================
# Add Library
#=======================================

Libraries.add(defineLibrary)
