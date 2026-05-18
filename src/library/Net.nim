#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Net.nim
#=======================================================

## The main Net module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Compilation & Linking
#=======================================

when defined(ssl):
    when defined(linux):
        when defined(LEGACYUNIX):
            when defined(arm64):
                {.passL: "-Bstatic -Lsrc/deps/openssl/linux/arm64/legacy -lssl -lcrypto -Bdynamic".}
            else:
                {.passL: "-Bstatic -Lsrc/deps/openssl/linux/amd64/legacy -lssl -lcrypto -Bdynamic".}
        else:
            when defined(arm64):
                {.passL: "-Bstatic -Lsrc/deps/openssl/linux/arm64 -lssl -lcrypto -Bdynamic".}
            else:
                {.passL: "-Bstatic -Lsrc/deps/openssl/linux/amd64 -lssl -lcrypto -Bdynamic".}
    elif defined(freebsd):
        {.passL: "-Bstatic -Lsrc/deps/openssl/freebsd/amd64 -lssl -lcrypto -Bdynamic".}
    elif defined(macosx):
        when defined(arm64):
            {.passL: "src/deps/openssl/macos/arm64/libssl.a src/deps/openssl/macos/arm64/libcrypto.a".}
        else:
            {.passL: "src/deps/openssl/macos/amd64/libssl.a src/deps/openssl/macos/amd64/libcrypto.a".}
    elif defined(windows): 
        {.passL: "-Bstatic -Lsrc/deps/openssl/windows/amd64 -lssl -lcrypto -Bdynamic -lws2_32 -lcrypt32".}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import algorithm, asyncdispatch, browsers
    import httpclient, httpcore, std/net, os
    import sequtils, strformat, strutils
    import terminal, times, uri
    # aliased — `Request` would collide with too many other things.
    import std/asynchttpserver as ahs

    when defined(ssl):
        import extras/smtp
        import helpers/stores

    import helpers/benchmark
    import helpers/jsonobject
    import helpers/net as netHelper
    import helpers/parallelism
    import helpers/servers
    import helpers/strings
    import helpers/terminal
    import helpers/url
    import helpers/webviews

    import vm/lib
    import vm/[env, errors, exec]
    import vm/values/custom/verror

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    when not defined(WEB):

        builtin "browse",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "open given URL with default browser",
            args        = {
                "url"   : {String}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            browse "https://arturo-lang.io"
            ; opens Arturo's official website in a new browser window
            """:
                #=======================================================
                openDefaultBrowser(x.s)
        
        builtin "download",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "download file from url to disk",
            args        = {
                "url"   : {String}
            },
            attrs       = {
                "as"    : ({String},"set target file"),
                "async" : ({Logical},"download asynchronously and return a `:task`")
            },
            returns     = {Nothing,Task},
            example     = """
            download "https://github.com/arturo-lang/arturo/raw/master/logo.png"
            ; (downloads file as "logo.png")
            ..........
            download.as:"arturoLogo.png"
                        "https://github.com/arturo-lang/arturo/raw/master/logo.png"

            ; (downloads file with a different name)
            """:
                #=======================================================
                let path = x.s

                var target: string

                if checkAttr("as"):
                    target = aAs.s
                else:
                    target = extractFilename(path)

                let explicitAsync = hadAttr("async")
                if explicitAsync or not onMainFiber():
                    let asyncTask = spawnAsyncDownload(path, target)
                    if explicitAsync:
                        push asyncTask
                    else:
                        push coopWait(asyncTask.tsk.future)
                    return

                var client = newHttpClient()
                client.downloadFile(path,target)

        when defined(ssl):
            builtin "mail",
                alias       = unaliased, 
                op          = opNop,
                rule        = PrefixPrecedence,
                description = "send mail using given subject and message to selected recipient",
                args        = {
                    "recipient" : {String},
                    "subject"   : {String},
                    "message"   : {String}
                },
                attrs       = {
                    "using"     : ({Dictionary},"use given configuration"),
                    "async"     : ({Logical},"send asynchronously and return a `:task`")
                },
                returns     = {Nothing,Task},
                example     = """
                mail .using: #[
                        server: "mymailserver.com"
                        username: "myusername"
                        password: "mypass123"
                    ]
                    "recipient@somemail.com" "Hello from Arturo" "Arturo rocks!"
                """:
                    #=======================================================
                    let recipient = x.s
                    let subject = y.s
                    let message = z.s

                    if checkAttr("using"):
                        discard

                    retrieveConfig("mail", "using")

                    # TODO(Net\mail) raise error, if there is no configuration provided whatsoever
                    #  perhaps, this could be also done in a more "templated" way; at least, for Config values
                    #  labels: library, bug

                    var mesg = createMessage(subject, message, sender=config["username"].s, mTo= @[recipient])

                    if hadAttr("async"):
                        push spawnAsyncMail(
                            server   = config["server"].s,
                            port     = 465,
                            username = config["username"].s,
                            password = config["password"].s,
                            fromAddr = config["username"].s,
                            toAddrs  = @[recipient],
                            msgStr   = $mesg
                        )
                        return

                    let smtpConn = newSmtp(useSsl = true, debug=true)
                    smtpConn.connect(config["server"].s, Port 465)
                    smtpConn.auth(config["username"].s, config["password"].s)
                    smtpConn.sendmail(config["username"].s, @[recipient], $mesg)
                    smtpConn.close()

        # TODO(Net\request) could it work for Web/JS builds?
        #  it could easily be a hidden Ajax request
        #  labels: library,enhancement,open discussion,web
        builtin "request",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "perform HTTP request to url with given data and get response",
            args        = {
                "url"   : {String},
                "data"  : {Dictionary, String, Null}
            },
            attrs       = {
                "get"           : ({Logical},"perform a GET request (default)"),
                "post"          : ({Logical},"perform a POST request"),
                "patch"         : ({Logical},"perform a PATCH request"),
                "put"           : ({Logical},"perform a PUT request"),
                "delete"        : ({Logical},"perform a DELETE request"),
                "json"          : ({Logical},"send data as Json"),
                "headers"       : ({Dictionary},"send custom HTTP headers"),
                "agent"         : ({String},"use given user agent"),
                "timeout"       : ({Integer},"set a timeout"),
                "proxy"         : ({String},"use given proxy url"),
                "certificate"   : ({String},"use SSL certificate at given path"),
                "raw"           : ({Logical},"return raw response without processing"),
                "async"         : ({Logical},"perform request asynchronously and return a `:task`")
            },
            returns     = {Dictionary,Null,Task},
            example     = """
            print request "https://httpbin.org/get" #[some:"arg" another: 123]
            ; [version:1.1 body:{
            ;     "args": {
            ;          "another": "123", 
            ;          "some": "arg"
            ;     }, 
            ;     "headers": {
            ;          "Content-Length": "0", 
            ;          "Host": "httpbin.org", 
            ;          "User-Agent": "Arturo HTTP Client / 0.9.75", 
            ;          "X-Amzn-Trace-Id": "Root=1-608fd4b2-6b8a34291cc2fbd17a678b0f"
            ;     }, 
            ;     "origin": "92.59.209.80", 
            ;     "url": "https://httpbin.org/get?some=arg&another=123"
            ; } headers:[server:gunicorn/19.9.0 content-length:341 access-control-allow-credentials:true content-type:application/json date:2021-05-03T10:47:14+02:00 access-control-allow-origin:* connection:keep-alive] status:200]
            ..........
            r: request "https://httpbin.org/get" #[some:"arg" another: 123]
            body: read.json r\body
            inspect body\headers
            ; [ :dictionary
            ;       Content-Length   :	0 :string
            ;       Host             :	httpbin.org :string
            ;       User-Agent       :	Arturo HTTP Client / 0.9.75 :string
            ;       X-Amzn-Trace-Id  :	Root=1-608fd5f3-7e47203117863c111a3aef3b :string
            ; ]
            ..........
            print (request "https://httpbin.org/get" #[]) \ 'status
            ; 200
            ..........
            print request.post "https://httpbin.org/post" #[some:"arg" another: 123]
            ; ...same as above...
            """:
                #=======================================================
                var url = x.s
                var meth: HttpMethod = HttpGet

                if (hadAttr("get")): discard
                if (hadAttr("post")): meth = HttpPost
                if (hadAttr("patch")): meth = HttpPatch
                if (hadAttr("put")): meth = HttpPut
                if (hadAttr("delete")): meth = HttpDelete

                var headers: HttpHeaders = newHttpHeaders()
                if checkAttr("headers"):
                    var headersArr: seq[(string,string)]
                    for k,v in pairs(aHeaders.d):
                        headersArr.add((k, $(v)))
                    headers = newHttpHeaders(headersArr)

                var agent = "Arturo HTTP Client / " & $(getSystemInfo()["version"])
                if checkAttr("agent"):
                    agent = aAgent.s

                var timeout: int = -1
                if checkAttr("timeout"):
                    timeout = aTimeout.i

                var proxy: Proxy = nil
                if checkAttr("proxy"):
                    proxy = newProxy(aProxy.s)

                var body: string
                var multipart: MultipartData = nil
                if meth != HttpGet:
                    if (hadAttr("json")):
                        headers.add("Content-Type", "application/json")
                        body = jsonFromValue(y, pretty=false)
                    else:
                        if yKind == String:
                            body = y.s
                        else:
                            multipart = newMultipartData()
                            for k,v in pairs(y.d):
                                multipart[k] = $(v)
                else:
                    if y != VNULL:
                        if (yKind==Dictionary and y.d.len!=0):
                            var parts: seq[string]
                            for k,v in pairs(y.d):
                                parts.add(k & "=" & urlencode($(v)))
                            url &= "?" & parts.join("&")
                        elif yKind==String:
                            url &= "?" & y.s

                let explicitAsync = hadAttr("async")
                if explicitAsync or not onMainFiber():
                    # in-process async request: build an `AsyncHttpClient`
                    # mirroring the sync setup, hand it off to `spawnAsyncRequest`,
                    # which awaits the response and runs our `buildResp` closure
                    # to produce a Value identical to the sync builtin's output.
                    #
                    # implicit-fiber routing: when called from inside a fiber
                    # (`do.async` / `map.parallel` / etc.), we transparently
                    # take the async path and cooperatively wait — otherwise
                    # the fiber would block the C stack and starve siblings.
                    var asyncClient: AsyncHttpClient
                    if checkAttr("certificate"):
                        when defined(ssl):
                            asyncClient = newAsyncHttpClient(
                                userAgent = agent,
                                sslContext = newContext(certFile=aCertificate.s),
                                proxy = proxy,
                                headers = headers
                            )
                        else:
                            asyncClient = newAsyncHttpClient(
                                userAgent = agent,
                                proxy = proxy,
                                headers = headers
                            )
                    else:
                        when defined(ssl):
                            asyncClient = newAsyncHttpClient(
                                userAgent = agent,
                                sslContext = newContext(verifyMode = CVerifyNone),
                                proxy = proxy,
                                headers = headers
                            )
                        else:
                            asyncClient = newAsyncHttpClient(
                                userAgent = agent,
                                proxy = proxy,
                                headers = headers
                            )
                    let raw = hadAttr("raw")
                    let buildResp = proc(version, bodyStr, status: string,
                                         hdrs: HttpHeaders): Value =
                        httpResponseToValue(version, bodyStr, status, hdrs, raw)
                    let asyncTask = spawnAsyncRequest(asyncClient, url, meth, body,
                                                      multipart, buildResp, timeout)
                    if explicitAsync:
                        push asyncTask
                    else:
                        push coopWait(asyncTask.tsk.future)
                    return

                var client: HttpClient

                if checkAttr("certificate"):
                    when defined(ssl):
                        client = newHttpClient(
                            userAgent = agent,
                            sslContext = newContext(certFile=aCertificate.s),
                            proxy = proxy,
                            timeout = timeout,
                            headers = headers
                        )
                    else:
                        client = newHttpClient(
                            userAgent = agent,
                            proxy = proxy,
                            timeout = timeout,
                            headers = headers
                        )
                else:
                    client = newHttpClient(
                        userAgent = agent,
                        proxy = proxy,
                        timeout = timeout,
                        headers = headers
                    )

                try:
                    let response = client.request(url = url,
                                                httpMethod = meth,
                                                body = body,
                                                multipart = multipart)
                    push httpResponseToValue(response.version, response.body,
                                             response.status, response.headers,
                                             hadAttr("raw"))
                except CatchableError:
                    push(VNULL)

        builtin "serve",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "start web server using given routes",
            args        = {
                "routes"    : {Block, Function}
            },
            attrs       = {
                "port"      : ({Integer},"use given port. Default: 18966"),
                "silent"    : ({Logical},"don't print info log"),
                "chrome"    : ({Logical},"open in Chrome windows as an app"),
                "async"     : ({Logical},"serve in a child process and return a `:task` (cancel to stop)")
            },
            returns     = {Nothing,Task},
            example     = """
            serve .port: 9000 [

                ; simple static routes
                GET "/"             -> "Welcome to my site!"
                GET "/about"        -> "About us"

                ; regex route with a named capture group
                GET {//user/(?<name>[a-z]+)/}  $[name][ 
                    emit.html ~"Hello, |name|!" 
                ]

                ; POST with JSON body
                POST "/login"  $[username, password][
                    emit.json write.json #[
                        msg: ~"Welcome back, |username|!"
                    ] ø
                ]

                GET {//.*/}         -> "catch-all fallback"
            ]

            ; $> curl localhost:9000/
            ; Welcome to my site!%

            ; $> curl localhost:9000/about
            ; About us%

            ; $> curl localhost:9000/user/john
            ; Hello, john!%

            ; $> curl -X POST localhost:9000/login -d "username=admin&password=secret"
            ; {
            ;     "msg": "Welcome back, admin!"
            ; }%

            ; $>  curl localhost:9000/something-else
            ; catch-all fallback%
            ..........
            serve $[req][
                inspect req
                ;[ :dictionary
                ;    method   :        GET :string
                ;    path     :        / :string
                ;    uri      :        / :string
                ;    body     :         :string
                ;    query    :        [ :dictionary
                ;    ]
                ;    headers  :        [ :dictionary
                ;        ...
                ;    ]

                ; we have to return either a string
                ; or a dictionary like:
                #[
                    body: "..."
                    status: 200
                    headers: #[
                        ;...
                    ]
                ]
            ]
            """:
                #=======================================================
                # get parameters
                let routes = x
                var port = 18966
                var verbose = not (hadAttr("silent"))
                if checkAttr("port"):
                    port = aPort.i

                if hadAttr("async"):
                    # in-process async serve via `asynchttpserver`. the handler
                    # mirrors the sync one below but uses asynchttpserver's
                    # Request API and `await req.respond(...)` rather than
                    # httpx's blocking send. cancel works (the helper closes
                    # the server, freeing the port).
                    if hadAttr("chrome"):
                        openChromeWindow(port)

                    if routes.kind != Function:
                        execInternal("Net/serve")
                        callInternal("initServerInternal", getValue=false, routes)

                    proc asyncHandler(req: ahs.Request): Future[void] {.async, gcsafe.} =
                        {.cast(gcsafe).}:
                            let reqAction = req.reqMethod
                            let reqBody = req.body
                            let reqHeaders = req.headers.table
                            let initialReqPath =
                                if req.url.query.len > 0: req.url.path & "?" & req.url.query
                                else: req.url.path
                            let reqPath = decodeUrl(req.url.path)
                            var reqQuery = initOrderedTable[string, Value]()
                            if req.url.query.len > 0:
                                for k, v in decodeQuery(req.url.query):
                                    reqQuery[k] = newString(v)

                            var reqBodyV: Value
                            if reqAction != HttpGet:
                                try:
                                    reqBodyV = valueFromJson(reqBody)
                                except CatchableError:
                                    reqBodyV = newDictionary()
                                    for k, v in decodeQuery(reqBody):
                                        reqBodyV.d[k] = newString(v)
                            else:
                                reqBodyV = newString(reqBody)

                            let requestDict = newDictionary({
                                    "method": newString($(reqAction)),
                                    "path": newString(reqPath),
                                    "uri": newString(initialReqPath),
                                    "body": reqBodyV,
                                    "query": newDictionary(reqQuery),
                                    "headers": newStringDictionary(reqHeaders, collapseBlocks=true),
                                    "ip": newString(req.hostname)
                                }.toOrderedTable)

                            var responseDict: ValueDict = {
                                "body": newString(""),
                                "status": newInteger(200),
                                "headers": newDictionary()
                            }.toOrderedTable

                            var resp: Value
                            if routes.kind == Function:
                                let timeTaken = getBenchmark:
                                    try:
                                        callFunction(routes, "<closure>", @[requestDict])
                                        resp = stack.pop()
                                        if resp.kind == String:
                                            responseDict["body"] = resp
                                        else:
                                            for k, v in resp.d.pairs:
                                                responseDict[k] = v
                                    except VError as e:
                                        showError(e)
                                        responseDict["status"] = newInteger(500)
                                    except CatchableError, Defect:
                                        let e = getCurrentException()
                                        showError(VError(e))
                                        responseDict["status"] = newInteger(500)
                                responseDict["benchmark"] = newQuantity(toQuantity(timeTaken, parseAtoms("ms")))
                            else:
                                responseDict = callInternal("serveInternal", getValue=true,
                                    requestDict
                                ).d
                                if not responseDict["headers"].d.hasKey("Content-Type"):
                                    responseDict["headers"].d["Content-Type"] = newString("text/html")

                            var respHeaders = newHttpHeaders()
                            for k, v in responseDict["headers"].d.pairs:
                                respHeaders.add(k, v.s)

                            let bodyStr =
                                if responseDict["body"].kind == Binary:
                                    var s = newString(responseDict["body"].n.len)
                                    if s.len > 0:
                                        copyMem(addr s[0], addr responseDict["body"].n[0], s.len)
                                    s
                                else:
                                    responseDict["body"].s

                            if verbose:
                                let status = responseDict["status"].i
                                echo "[" & $(now()) & "] " & ($(reqAction)).toUpperAscii() &
                                     " " & initialReqPath & " -> " & $(status)

                            await req.respond(HttpCode(responseDict["status"].i),
                                              bodyStr, respHeaders)

                    if verbose:
                        echo " :: Starting server on port " & $(port) & "...\n"

                    push spawnAsyncServe(port, asyncHandler)
                    return

                if hadAttr("chrome"):
                    openChromeWindow(port)

                if routes.kind != Function:
                    # necessary so that "serveInternal" is available
                    execInternal("Net/serve")

                    # call internal implementation
                    # to initialize routes
                    callInternal("initServerInternal", getValue=false,
                        routes
                    )

                proc requestHandler(req: ServerRequest): Future[void] {.gcsafe.} =
                    {.cast(gcsafe).}:
                        # store many request details
                        let reqAction = req.action()
                        let reqBody = req.body()
                        let reqHeaders = req.headers().table
                        var reqQuery = initOrderedTable[string,Value]()
                        var reqPath = req.path()
                        let initialReqPath = reqPath

                        # get query components, if any
                        if reqPath.contains("?"):
                            let parts = reqPath.split("?", maxsplit=1)
                            reqPath = decodeUrl(parts[0])
                            for k,v in decodeQuery(parts[1]):
                                reqQuery[k] = newString(v)
                        else:
                            reqPath = decodeUrl(reqPath)

                        # carefully parse request body, if any
                        var reqBodyV: Value

                        if reqAction!=HttpGet: 
                            try:
                                reqBodyV = valueFromJson(reqBody) 
                            except CatchableError:
                                reqBodyV = newDictionary()
                                for k,v in decodeQuery(reqBody):
                                    reqBodyV.d[k] = newString(v)
                        else: 
                            reqBodyV = newString(reqBody)

                        # store request info inside a Dictionary
                        # we will pass this to the function -
                        # user-defined or the "default" one -
                        # which will handle it
                        let requestDict = newDictionary({
                                "method": newString($(reqAction)),
                                "path": newString(reqPath),
                                "uri": newString(initialReqPath),
                                "body": reqBodyV,
                                "query": newDictionary(reqQuery),
                                "headers": newStringDictionary(reqHeaders, collapseBlocks=true),
                                "ip": newString(req.ip())
                            }.toOrderedTable)

                        # the response
                        var responseDict: ValueDict = {
                            "body": newString(""),
                            "status": newInteger(200),
                            "headers": newDictionary()
                        }.toOrderedTable

                        var resp: Value
                        if routes.kind == Function:
                            let timeTaken = getBenchmark:
                                try:
                                    callFunction(routes, "<closure>", @[requestDict])
                                    resp = stack.pop()

                                    if resp.kind == String:
                                        responseDict["body"] = resp
                                    else:
                                        for k,v in resp.d.pairs:
                                            responseDict[k] = v

                                except VError as e:
                                    showError(e)
                                    responseDict["status"] = newInteger(500)
                                except CatchableError, Defect:
                                    let e = getCurrentException()
                                    showError(VError(e))
                                    responseDict["status"] = newInteger(500)
                            
                            responseDict["benchmark"] = newQuantity(toQuantity(timeTaken, parseAtoms("ms")))
                        else:
                            # call internal implementation
                            responseDict = callInternal("serveInternal", getValue=true,
                                requestDict
                            ).d

                            if not responseDict["headers"].d.hasKey("Content-Type"):
                                responseDict["headers"].d["Content-Type"] = newString("text/html")

                        let headerStr = (toSeq(responseDict["headers"].d.pairs)).map(
                            proc(kv: (string,Value)): string = 
                                kv[0] & ": " & kv[1].s
                        ).join("\c\L")

                        # send response
                        let bodyStr = if responseDict["body"].kind == Binary:
                                var s = newString(responseDict["body"].n.len)
                                if s.len > 0:
                                    copyMem(addr s[0], addr responseDict["body"].n[0], s.len)
                                s
                            else:
                                responseDict["body"].s

                        req.respond(newServerResponse(
                            bodyStr,
                            HttpCode(responseDict["status"].i),
                            headerStr
                        ))

                        # show request response info
                        # if we're on .verbose mode
                        if verbose:
                            let contentType = responseDict["headers"].d.getOrDefault("Content-Type", newString("--"))
                            let requestPattern = responseDict.getOrDefault("pattern", newString(initialReqPath))

                            var colorCode = greenColor
                            if responseDict["status"].i != 200: 
                                colorCode = redColor

                            var serverPattern = " "
                            if requestPattern.s != initialReqPath and requestPattern.s != "":
                                serverPattern = " -> " & requestPattern.s & " "

                            var serverBenchmark: string
                            formatValue(serverBenchmark, toFloat(responseDict["benchmark"].q.original), ".2f")
                            serverBenchmark = "| " & align(serverBenchmark, 6) & " ms "
                            let timestamp = "[" & $(now()) & "] "

                            let logStr = 
                                bold(colorCode) & " -- " & $(responseDict["status"].i) & resetColor & " " & 
                                fg(whiteColor) & timestamp &
                                bold(whiteColor) & ($(reqAction)).toUpperAscii() & " " & initialReqPath & #& "\n" & align($(responseDict["status"].i), timestamp.len() + 6)
                                bold(colorCode)  & " " & resetColor

                            echo logStr & fg(whiteColor) & align(contentType.s, terminalWidth() - logStr.realLen() - serverBenchmark.realLen() - 1) & " " &
                                          fg(grayColor) & serverBenchmark & resetColor


                # show server startup info
                # if we're on .verbose mode
                if verbose:
                    echo " :: Starting server on port " & $(port) & "...\n"
                
                startServer(requestHandler.RequestHandler, port)
