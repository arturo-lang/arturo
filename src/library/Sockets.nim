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
    import asyncdispatch, asyncnet
    import std/net as netsock except Socket
    import nativesockets

    import helpers/parallelism

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
                let (address, client) = coopWait x.sock.socket.acceptAddr()
                let (_, port) = getPeerAddr(client)
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
                "udp"       : ({Logical},"use UDP instead of TCP"),
                "async"     : ({Logical},"return a `:task` resolving to the connected socket")
            },
            returns     = {Socket,Task},
            example     = """
            ; connect to local server on port 18966
            server: connect 18966
            ..........
            ; "connect" to a udp server on port 12345
            server: connect.udp 12345
            ..........
            ; connect to a remote server on port 18966
            server: connect.to:"123.456.789.123" 18966
            ..........
            ; parallel connect to many hosts
            tasks: map hosts 'h -> connect.async.to: h 80
            sockets: wait.all tasks
            """:
                #=======================================================
                let isUDP = hadAttr("udp")
                let explicitAsync = hadAttr("async")

                let protocol =
                    if isUDP: IPPROTO_UDP
                    else: IPPROTO_TCP

                let toAddress =
                    if checkAttr("to"): aTo.s
                    else:               "0.0.0.0"

                let port = Port(x.i)

                let sock: AsyncSocket =
                    if isUDP: newAsyncSocket(sockType=SOCK_DGRAM, protocol=IPPROTO_UDP, buffered=false)
                    else:     newAsyncSocket(protocol=IPPROTO_TCP)

                let post = proc(): Value =
                    newSocket(initSocket(sock, proto=protocol, address=toAddress, port=port))

                let asyncTask = spawnAsyncConnect(sock, toAddress, port, isUDP, post)
                if explicitAsync:
                    push asyncTask
                else:
                    push coopWait(asyncTask.tsk.future)

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
                let isUDP = hadAttr("udp")
                let protocol =
                    if isUDP: IPPROTO_UDP
                    else: IPPROTO_TCP

                var sock: AsyncSocket =
                    if isUDP: newAsyncSocket(sockType=SOCK_DGRAM, protocol=IPPROTO_UDP, buffered=false)
                    else:     newAsyncSocket(protocol=IPPROTO_TCP)
                sock.setSockOpt(OptReuseAddr, true)

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
                "timeout"   : ({Integer},"set timeout (in milliseconds)"),
                "async"     : ({Logical},"return a `:task` resolving to the received line")
            },
            returns     = {String,Task},
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
            ..........
            ; read-with-deadline via `:task`
            t: receive.async client
            r: wait.timeout: 5000 t          ; → :error on 5s deadline
            """:
                #=======================================================
                var size = MaxLineLength
                if checkAttr("size"):
                    size = aSize.i

                var timeout = -1
                if checkAttr("timeout"):
                    timeout = aTimeout.i

                let explicitAsync = hadAttr("async")
                let asyncTask = spawnAsyncReceive(x.sock.socket, size, timeout)
                if explicitAsync:
                    push asyncTask
                else:
                    push coopWait(asyncTask.tsk.future)

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
                let asChunk = hadAttr("chunk")

                let message =
                    if asChunk: y.s
                    else: y.s & "\r\L"

                coopWait x.sock.socket.send(message)

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
                var ok = true
                try:
                    coopWait x.sock.socket.send(y.s)
                except CatchableError:
                    ok = false
                push newLogical(ok)
