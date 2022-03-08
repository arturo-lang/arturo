#                 MIT License
# Copyright (c) 2020 Dominik Picheta

# Copyright 2020 Zeshen Xing
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#         http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


import net, nativesockets, os, httpcore, asyncdispatch, strutils
import options, logging, times, heapqueue, std/monotimes

from deques import len

import httpx/parser

import extras/ioselectors


when defined(windows):
    import sets
else:
    import posix
    when compileOption("threads"):
        from osproc import countProcessors


export httpcore


type
    FdKind = enum
        Server, Client, Dispatcher

    Data = object
        fdKind: FdKind ## Determines the fd kind (server, client, dispatcher)
                                     ## - Client specific data.
                                     ## A queue of data that needs to be sent when the FD becomes writeable.
        sendQueue: string
        ## The number of characters in `sendQueue` that have been sent already.
        bytesSent: int
        ## Big chunk of data read from client during request.
        data: string
        ## Determines whether `data` contains "\c\l\c\l".
        headersFinished: bool
        ## Determines position of the end of "\c\l\c\l".
        headersFinishPos: int
        ## The address that a `client` connects from.
        ip: string
        ## Future for onRequest handler (may be nil).
        reqFut: Future[void]
        ## Identifier for current request. Mainly for better detection of cross-talk.
        requestID: uint

type
    Request* = object
        selector: Selector[Data]
        client*: SocketHandle
        # Determines where in the data buffer this request starts.
        # Only used for HTTP pipelining.
        start: int
        # Identifier used to distinguish requests.
        requestID: uint

    OnRequest* = proc (req: Request): Future[void] {.gcsafe, gcsafe.}

    Startup = proc () {.closure, gcsafe.}

    Settings* = object
        port*: Port
        bindAddr*: string
        numThreads: int
        startup: Startup

    HttpxDefect* = ref object of Defect

const
    serverInfo {.strdefine.} = "Arturo/Server"
    clientBufSzie = 256

var serverDate {.threadvar.}: string

proc doNothing(): Startup {.gcsafe.} =
    result = proc () {.closure, gcsafe.} =
        discard

func initSettings*(port = Port(8080),
                                     bindAddr = "",
                                     numThreads = 0,
                                     startup: Startup,
): Settings =
    result = Settings(
        port: port,
        bindAddr: bindAddr,
        numThreads: numThreads,
        startup: startup
    )

func initSettings*(port = Port(8080),
                                     bindAddr = "",
                                     numThreads = 0
): Settings =
    result = Settings(
        port: port,
        bindAddr: bindAddr,
        numThreads: numThreads,
        startup: doNothing()
    )

func initData(fdKind: FdKind, ip = ""): Data =
    result = Data(fdKind: fdKind,
             sendQueue: "",
             bytesSent: 0,
             data: "",
             headersFinished: false,
             headersFinishPos: -1, ## By default we assume the fast case: end of data.
             ip: ip
    )


template withRequestData(req: Request, body: untyped) =
    let requestData {.inject.} = addr req.selector.getData(req.client)
    body

#[ API start ]#

proc unsafeSend*(req: Request, data: string) {.inline.} =
    ## Sends the specified data on the request socket.
    ##
    ## This function can be called as many times as necessary.
    ##
    ## It does not check whether the socket is in a state
    ## that can be written so be careful when using it.
    if req.client notin req.selector:
        return

    withRequestData(req):
        requestData.sendQueue.add(data)
    req.selector.updateHandle(req.client, {Event.Read, Event.Write})

proc send*(req: Request, code: HttpCode, body: string, contentLength: Option[string], headers = "") {.inline.} =
    ## Responds with the specified HttpCode and body.
    ##
    ## **Warning:** This can only be called once in the OnRequest callback.

    if req.client notin req.selector:
        return

    withRequestData(req):
        # assert requestData.headersFinished, "Selector not ready to send."
        if requestData.requestID != req.requestID:
            raise HttpxDefect(msg: "You are attempting to send data to a stale request.")

        let otherHeaders =
            if likely(headers.len != 0):
                "\c\L" & headers
            else:
                ""
    
        var text = ""
        template makeResponse(bodyLength: string) =
            text &= "HTTP/1.1 "
            text &= $code
            text &= "\c\LContent-Length: "
            text &= bodyLength
            text &= "\c\LServer: " & serverInfo
            text &= "\c\LDate: "
            text &= serverDate
            text &= otherHeaders
            text &= "\c\L\c\L"
            text &= body
        if contentLength.isNone:
            makeResponse($body.len)
        else:
            makeResponse(contentLength.get)
        requestData.sendQueue.add(text)
    req.selector.updateHandle(req.client, {Event.Read, Event.Write})

template send*(req: Request, code: HttpCode, body: string, headers = "") =
    ## Responds with the specified HttpCode and body.
    ##
    ## **Warning:** This can only be called once in the OnRequest callback.

    req.send(code, body, none(string), headers)

proc send*(req: Request, code: HttpCode) =
    ## Responds with the specified HttpCode. The body of the response
    ## is the same as the HttpCode description.
    assert req.selector.getData(req.client).requestID == req.requestID
    req.send(code, $code)

proc send*(req: Request, body: string, code = Http200) {.inline.} =
    ## Sends a HTTP 200 OK response with the specified body.
    ##
    ## **Warning:** This can only be called once in the OnRequest callback.
    req.send(code, body)

template acceptClient() =
    let (client, address) = fd.SocketHandle.accept
    if client == osInvalidSocket:
        let lastError = osLastError()

        when defined(posix):
            if lastError.int32 == EMFILE:
                warn("Ignoring EMFILE error: ", osErrorMsg(lastError))
                return

        raiseOSError(lastError)
    setBlocking(client, false)
    selector.registerHandle(client, {Event.Read},
                                                    initData(Client, ip = address))

template closeClient(selector: Selector[Data],
                                                         fd: SocketHandle|int,
                                                         inLoop = true) =
    # TODO: Can POST body be sent with Connection: Close?

    var data: ptr Data = addr selector.getData(fd)
    let isRequestComplete = data.reqFut.isNil or data.reqFut.finished
    if isRequestComplete:
        # The `onRequest` callback isn't in progress, so we can close the socket.
        selector.unregister(fd)
        fd.SocketHandle.close()
    else:
        # Close the socket only once the `onRequest` callback completes.
        data.reqFut.addCallback(
            proc (fut: Future[void]) =
                fd.SocketHandle.close()
        )
        # Unregister fd so that we don't receive any more events for it.
        # Once we do so the `data` will no longer be accessible.
        selector.unregister(fd)

    logging.debug("socket: " & $fd & " is closed!")

    when inLoop:
        break
    else:
        return

proc onRequestFutureComplete(theFut: Future[void],
                                                         selector: Selector[Data], fd: int) =
    if theFut.failed:
        raise theFut.error

template fastHeadersCheck(data: ptr Data): bool =
    let res = data.data[^1] == '\l' and data.data[^2] == '\c' and
                         data.data[^3] == '\l' and data.data[^4] == '\c'
    if res: 
        data.headersFinishPos = data.data.len
    res

template methodNeedsBody(data: ptr Data): bool =
    # Only idempotent methods can be pipelined (GET/HEAD/PUT/DELETE), they
        # never need a body, so we just assume `start` at 0.
    let reqMthod = parseHttpMethod(data.data, start = 0)
    reqMthod.isSome and (reqMthod.get in {HttpPost, HttpPut, HttpConnect, HttpPatch})

proc slowHeadersCheck(data: ptr Data): bool =
    if unlikely(methodNeedsBody(data)):
        # Look for \c\l\c\l inside data.
        data.headersFinishPos = 0
        template ch(i: int): char =
            let pos = data.headersFinishPos + i
            if pos >= data.data.len: 
                '\0'
            else:
                data.data[pos]

        while data.headersFinishPos < data.data.len:
            case ch(0)
            of '\c':
                if ch(1) == '\l' and ch(2) == '\c' and ch(3) == '\l':
                    data.headersFinishPos.inc(4)
                    return true
            else: 
                discard
            inc data.headersFinishPos

        data.headersFinishPos = -1

proc bodyInTransit(data: ptr Data): bool =
    # get, head, put, delete
    assert methodNeedsBody(data), "Calling bodyInTransit now is inefficient."
    assert data.headersFinished

    if data.headersFinishPos == -1: 
        return false

    let trueLen = parseContentLength(data.data, start = 0)

    let bodyLen = data.data.len - data.headersFinishPos
    assert(not (bodyLen > trueLen))
    result = bodyLen != trueLen

var requestCounter: uint = 0
proc genRequestID(): uint =
    if requestCounter == high(uint):
        requestCounter = 0
    requestCounter += 1
    return requestCounter

proc validateRequest(req: Request): bool {.gcsafe.}

proc processEvents(selector: Selector[Data],
                                     events: array[64, ReadyKey], count: int,
                                     onRequest: OnRequest) =
    for i in 0 ..< count:
        let fd = events[i].fd
        var data: ptr Data = addr(getData(selector, fd))
        # Handle error events first.
        if Event.Error in events[i].events:
            if isDisconnectionError({SocketFlag.SafeDisconn},
                                                            events[i].errorCode):
                closeClient(selector, fd)
            raiseOSError(events[i].errorCode)

        case data.fdKind
        of Server:
            if Event.Read in events[i].events:
                acceptClient()
            else:
                doAssert false, "Only Read events are expected for the server"
        of Dispatcher:
            # Run the dispatcher loop.
            when defined(posix):
                assert events[i].events == {Event.Read}
                asyncdispatch.poll(0)
            else:
                discard
        of Client:
            if Event.Read in events[i].events:
                var buf: array[clientBufSzie, char]
                # Read until EAGAIN. We take advantage of the fact that the client
                # will wait for a response after they send a request. So we can
                # comfortably continue reading until the message ends with \c\l
                # \c\l.
                while true:
                    let ret = recv(fd.SocketHandle, addr buf[0], clientBufSzie, 0.cint)
                    if ret == 0:
                        closeClient(selector, fd)

                    if ret == -1:
                        # Error!
                        let lastError = osLastError()

                        when defined(posix):
                            if lastError.int32 in {EWOULDBLOCK, EAGAIN}:
                                break
                        else:
                            if lastError.int == WSAEWOULDBLOCK:
                                break

                        if isDisconnectionError({SocketFlag.SafeDisconn}, lastError):
                            closeClient(selector, fd)
                        raiseOSError(lastError)

                    # Write buffer to our data.
                    let origLen = data.data.len
                    data.data.setLen(origLen + ret)
                    for i in 0 ..< ret:
                        data.data[origLen + i] = buf[i]

                    if data.data.len >= 4 and fastHeadersCheck(data) or slowHeadersCheck(data):
                        # First line and headers for request received.
                        data.headersFinished = true
                        when not defined(release):
                            if data.sendQueue.len != 0:
                                logging.warn("sendQueue isn't empty.")
                            if data.bytesSent != 0:
                                logging.warn("bytesSent isn't empty.")

                        let waitingForBody = methodNeedsBody(data) and bodyInTransit(data)
                        if likely(not waitingForBody):
                            for start in parseRequests(data.data):
                                # For pipelined requests, we need to reset this flag.
                                data.headersFinished = true
                                data.requestID = genRequestID()

                                let request = Request(
                                    selector: selector,
                                    client: fd.SocketHandle,
                                    start: start,
                                    requestID: data.requestID
                                )

                                template validateResponse() =
                                    if data.requestID == request.requestID:
                                        data.headersFinished = false

                                if validateRequest(request):
                                    data.reqFut = onRequest(request)
                                    if not data.reqFut.isNil:
                                        data.reqFut.addCallback(
                                            proc (fut: Future[void]) =
                                                onRequestFutureComplete(fut, selector, fd)
                                                validateResponse()
                                        )
                                    else:
                                        validateResponse()

                    if ret != clientBufSzie:
                        # Assume there is nothing else for us right now and break.
                        break
            elif Event.Write in events[i].events:
                assert data.sendQueue.len > 0
                assert data.bytesSent < data.sendQueue.len
                # Write the sendQueue.

                let leftover =
                    when defined(posix):
                        data.sendQueue.len - data.bytesSent
                    else:
                        cint(data.sendQueue.len - data.bytesSent)

                let ret = send(fd.SocketHandle, addr data.sendQueue[data.bytesSent],
                                             leftover, 0)
                if ret == -1:
                    # Error!
                    let lastError = osLastError()

                    when defined(posix):
                        if lastError.int32 in {EWOULDBLOCK, EAGAIN}:
                            break
                    else:
                        if lastError.int == WSAEWOULDBLOCK:
                            break

                    if isDisconnectionError({SocketFlag.SafeDisconn}, lastError):
                        closeClient(selector, fd)
                    raiseOSError(lastError)

                data.bytesSent.inc(ret)

                if data.sendQueue.len == data.bytesSent:
                    data.bytesSent = 0
                    data.sendQueue.setLen(0)
                    data.data.setLen(0)
                    selector.updateHandle(fd.SocketHandle,
                                                                {Event.Read})
            else:
                assert false

proc updateDate(fd: AsyncFD): bool =
    result = false # Returning true signifies we want timer to stop.
    serverDate = now().utc().format("ddd, dd MMM yyyy HH:mm:ss 'GMT'")

proc eventLoop(params: (OnRequest, Settings)) =
    let 
        (onRequest, settings) = params
        selector = newSelector[Data]()
        server = newSocket()

    if settings.startup != nil:
        settings.startup()

    server.setSockOpt(OptReuseAddr, true)
    server.setSockOpt(OptReusePort, true)
    server.bindAddr(settings.port, settings.bindAddr)
    server.listen()
    server.getFd.setBlocking(false)
    selector.registerHandle(server.getFd, {Event.Read}, initData(Server))

    # Set up timer to get current date/time.
    discard updateDate(0.AsyncFD)
    asyncdispatch.addTimer(1000, false, updateDate)
    let disp = getGlobalDispatcher()

    when defined(posix):
        selector.registerHandle(disp.getIoHandler.getFd, {Event.Read},
                                                    initData(Dispatcher))

        var events: array[64, ReadyKey]
        while true:
            let ret = selector.selectInto(-1, events)
            processEvents(selector, events, ret, onRequest)

            # Ensure callbacks list doesn't grow forever in asyncdispatch.
            # See https://github.com/nim-lang/Nim/issues/7532.
            # Not processing callbacks can also lead to exceptions being silently
            # lost!
            if unlikely(asyncdispatch.getGlobalDispatcher().callbacks.len > 0):
                asyncdispatch.poll(0)
    else:
        var events: array[64, ReadyKey]
        while true:
            let ret =
                if disp.timers.len > 0:
                    selector.selectInto((disp.timers[0].finishAt - getMonoTime()).inMilliseconds.int, events)
                else:
                    selector.selectInto(20, events)
            if ret > 0:
                processEvents(selector, events, ret, onRequest)
            asyncdispatch.poll(0)

func httpMethod*(req: Request): Option[HttpMethod] {.inline.} =
    ## Parses the request's data to find the request HttpMethod.
    parseHttpMethod(req.selector.getData(req.client).data, req.start)

func path*(req: Request): Option[string] {.inline.} =
    ## Parses the request's data to find the request target.
    if unlikely(req.client notin req.selector): 
        return
    parsePath(req.selector.getData(req.client).data, req.start)

func headers*(req: Request): Option[HttpHeaders] =
    ## Parses the request's data to get the headers.
    if unlikely(req.client notin req.selector): 
        return
    parseHeaders(req.selector.getData(req.client).data, req.start)

func body*(req: Request): Option[string] =
    ## Retrieves the body of the request.
    let pos = req.selector.getData(req.client).headersFinishPos
    if pos == -1: 
        return none(string)
    result = some(req.selector.getData(req.client).data[pos .. ^1])

    when not defined(release):
        let length =
            if req.headers.get.hasKey("Content-Length"):
                req.headers.get["Content-Length"].parseInt
            else:
                0
        doAssert result.get.len == length

func ip*(req: Request): string =
    ## Retrieves the IP address that the request was made from.
    req.selector.getData(req.client).ip

proc forget*(req: Request) =
    ## Unregisters the underlying request's client socket from httpx's
    ## event loop.
    ##
    ## This is useful when you want to register ``req.client`` in your own
    ## event loop, for example when wanting to integrate httpx into a
    ## websocket library.
    req.selector.unregister(req.client)

proc validateRequest(req: Request): bool =
    ## Handles protocol-mandated responses.
    ##
    ## Returns ``false`` when the request has been handled.
    result = true

    # From RFC7231: "When a request method is received
    # that is unrecognized or not implemented by an origin server, the
    # origin server SHOULD respond with the 501 (Not Implemented) status
    # code."
    if req.httpMethod.isNone:
        req.send(Http501)
        result = false

proc run*(onRequest: OnRequest, settings: Settings) =
    ## Starts the HTTP server and calls `onRequest` for each request.
    ##
    ## The ``onRequest`` procedure returns a ``Future[void]`` type. But
    ## unlike most asynchronous procedures in Nim, it can return ``nil``
    ## for better performance, when no async operations are needed.
    when not defined(windows):
        when compileOption("threads"):
            let numThreads =
                if settings.numThreads == 0: 
                    countProcessors()
                else: 
                    settings.numThreads
        else:
            let numThreads = 1

        logging.debug("Starting ", numThreads, " threads")

        if numThreads > 1:
            when compileOption("threads"):
                var threads = newSeq[Thread[(OnRequest, Settings)]](numThreads)
                for i in 0 ..< numThreads:
                    createThread[(OnRequest, Settings)](
                        threads[i], eventLoop, (onRequest, settings)
                    )
                
                logging.debug("Listening on port ",
                        settings.port) # This line is used in the tester to signal readiness.
                
                joinThreads(threads)
            else:
                doAssert false, "Please enable threads when numThreads is greater than 1!"
        else:
            eventLoop((onRequest, settings))
    else:
        eventLoop((onRequest, settings))
        logging.debug("Starting ", 1, " threads")

proc run*(onRequest: OnRequest) {.inline.} =
    ## Starts the HTTP server with default settings. Calls `onRequest` for each
    ## request.
    ##
    ## See the other ``run`` proc for more info.
    run(onRequest, Settings(port: Port(8080), bindAddr: "", startup: doNothing()))

when false:
    proc close*(port: Port) =
        ## Closes an httpx server that is running on the specified port.
        ##
        ## **NOTE:** This is not yet implemented.

        doAssert false
        # TODO: Figure out the best way to implement this. One way is to use async
        # events to signal our `eventLoop`. Maybe it would be better not to support
        # multiple servers running at the same time?