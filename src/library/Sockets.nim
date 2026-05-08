#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
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
    import vm/errors
    import vm/values/custom/[vsocket]

#=======================================
# Definitions
#=======================================

# TODO(Sockets) Verify the whole module & check for missing functionality
#  obviously this cannot be done with unit-tests as easily as with other modules, but
#  we'd still have to verify it works as expected and track down possibly-missing
#  features
#  labels: open discussion

proc defineModule*(moduleName: string) =

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
            server: listen 18966
            print "started server connection..."

            client: accept server
            print ["accepted incoming connection from:" client]
            """:
                #=======================================================
                dispatch:
                    Socket(srv):
                        var client: netsock.Socket
                        srv.socket.accept(client)

                        let (address,port) = getPeerAddr(client)

                        let socket = initSocket(client, proto=srv.protocol, address=address, port=port)
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
                bindAttrs:
                    udp: Logical
                    toAddress(to): String = "0.0.0.0"

                let protocol =
                    if udp: IPPROTO_UDP
                    else:   IPPROTO_TCP

                dispatch:
                    Integer(i):
                        let port = Port(i)

                        var sock: netsock.Socket = netsock.newSocket(protocol=protocol)
                        if not udp:
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
                "udp"       : ({Logical},"use UDP instead of TCP")
            },
            returns     = {Socket},
            example     = """
            ; start a server listening on port 18966
            server: listen 18966
            """:
                #=======================================================
                bindAttrs:
                    udp: Logical

                let protocol =
                    if udp: IPPROTO_UDP
                    else:   IPPROTO_TCP

                dispatch:
                    Integer(i):
                        let blocking = true

                        var sock: netsock.Socket = netsock.newSocket(protocol=protocol)
                        sock.setSockOpt(OptReuseAddr, true)

                        sock.getFd().setBlocking(blocking)
                        sock.bindAddr(Port(i))
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
            server: listen 18966
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
                bindAttrs:
                    size:    Integer = MaxLineLength
                    timeout: Integer = -1

                dispatch:
                    Socket(s):
                        push newString(s.socket.recvLine(timeout=timeout, maxLength=size))

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
                bindAttrs:
                    chunk: Logical

                dispatch:
                    (Socket(s), String(t)):
                        let message =
                            if chunk: t
                            else:     t & "\r\L"

                        s.socket.send(message)

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
                dispatch:
                    Socket(s): s.socket.close()

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
                dispatch:
                    (Socket(s), String(t)): push newLogical(s.socket.trySend(t))
