#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
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

    when defined(windows): 
        {.passL: "-Bstatic -Lsrc/extras/openssl/deps/windows -lssl -lcrypto -lws2_32 -Bdynamic".}
    elif defined(linux):
        when defined(arm64):
            {.passL: "-Bstatic -Lsrc/extras/openssl/deps/linux/arm64 -lssl -lcrypto -Bdynamic".}
        else:
            {.passL: "-Bstatic -Lsrc/extras/openssl/deps/linux/amd64 -lssl -lcrypto -Bdynamic".}
    elif defined(macosx):
        # TODO(Net) Use OpenSSL 1.1 in all cases
        #  right now, every OS/architecture statically links OpenSSL 1.1.
        #  except for Mac/arm64 (M1). This - most likely - leads to the aforementioned
        #  binaries being largest, without any reason. This has to be fixed (by finding the correct
        #  libraries to link against and making sure they are found during compilation). Once this is
        #  done, we'll also have to remove the definition of `--define:useOpenssl3` in 
        #  .config/buildmode.nims
        #  labels: enhancement, 3rd-party, macos
        when defined(arm64):
            {.passL: "-Bstatic -Lsrc/extras/openssl/deps/macos/arm64 -lssl -lcrypto -Bdynamic".}
        else:
            {.passL: "-Bstatic -Lsrc/extras/openssl/deps/macos/amd64 -lssl -lcrypto -Bdynamic".}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import algorithm, asyncdispatch, browsers
    import httpclient, httpcore, std/net, os
    import sequtils, strformat, strutils
    import terminal, times, uri

    when defined(ssl):
        import extras/smtp
        import helpers/stores

    import helpers/benchmark
    import helpers/jsonobject
    import helpers/servers
    import helpers/strings
    import helpers/terminal
    import helpers/url
    import helpers/webviews

import vm/lib
import vm/errors
import vm/values/custom/verror

when not defined(WEB):
    import vm/[env, exec]

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
                when defined(SAFE): Error_OperationNotPermitted("browse")
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
                "as"    : ({String},"set target file")
            },
            returns     = {Nothing},
            example     = """
            download "https://github.com/arturo-lang/arturo/raw/master/logo.png"
            ; (downloads file as "logo.png")
            ..........
            download.as:"arturoLogo.png"
                        "https://github.com/arturo-lang/arturo/raw/master/logo.png"
            
            ; (downloads file with a different name)
            """:
                #=======================================================
                when defined(SAFE): Error_OperationNotPermitted("download")
                let path = x.s

                var target: string

                if checkAttr("as"):
                    target = aAs.s
                else:
                    target = extractFilename(path)

                var client = newHttpClient()
                client.downloadFile(path,target)

        when defined(ssl):
            builtin "mail",
                alias       = unaliased, 
                op          = opNop,
                rule        = PrefixPrecedence,
                description = "send mail using given title and message to selected recipient",
                args        = {
                    "recipient" : {String},
                    "title"     : {String},
                    "message"   : {String}
                },
                attrs       = {
                    "using"     : ({Dictionary},"use given configuration")
                },
                returns     = {Nothing},
                example     = """
                mail .using: #[
                        server: "mymailserver.com"
                        username: "myusername"
                        password: "mypass123"
                    ]
                    "recipient@somemail.com" "Hello from Arturo" "Arturo rocks!"                
                """:
                    #=======================================================
                    when defined(SAFE): Error_OperationNotPermitted("mail")
                    let recipient = x.s
                    let title = y.s
                    let message = z.s

                    if checkAttr("using"):
                        discard
                    
                    retrieveConfig("mail", "using")

                    # TODO(Net\mail) raise error, if there is no configuration provided whatsoever
                    #  perhaps, this could be also done in a more "templated" way; at least, for Config values
                    #  labels: library, bug

                    var mesg = createMessage(title, message, @[recipient])
                    let smtpConn = newSmtp(useSsl = true, debug=true)
                    smtpConn.connect(config["server"].s, Port 465)
                    smtpConn.auth(config["username"].s, config["password"].s)
                    smtpConn.sendmail(config["username"].s, @[recipient], $mesg)

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
                "raw"           : ({Logical},"return raw response without processing")
            },
            returns     = {Dictionary,Null},
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
                when defined(SAFE): Error_OperationNotPermitted("request")

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
                        # TODO(Net\request) show warning/error when trying to use SSL certificates in MINI builds
                        #  labels: library, error handling, enhancement
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

                    var ret: ValueDict = initOrderedTable[string,Value]()
                    ret["version"] = newString(response.version)
                    
                    ret["body"] = newString(response.body)
                    ret["headers"] = newDictionary()

                    if (hadAttr("raw")):
                        ret["status"] = newString(response.status)

                        for k,v in response.headers.table:
                            ret["headers"].d[k] = newStringBlock(v)
                    else:
                        try:
                            let respStatus = (response.status.splitWhitespace())[0]
                            ret["status"] = newInteger(respStatus)
                        except CatchableError:
                            ret["status"] = newString(response.status)

                        for k,v in response.headers.table:
                            var val: Value
                            if v.len==1:
                                case k
                                    of "age","content-length": 
                                        try:
                                            val = newInteger(v[0])
                                        except CatchableError:
                                            val = newString(v[0])
                                    of "access-control-allow-credentials":
                                        val = newLogical(v[0])
                                    of "date", "expires", "last-modified":
                                        let dateParts = v[0].splitWhitespace()
                                        let cleanDate = (dateParts[0..(dateParts.len-2)]).join(" ")
                                        var dateFormat = "ddd, dd MMM YYYY HH:mm:ss"
                                        let timeFormat = initTimeFormat(dateFormat)
                                        try:
                                            val = newDate(parse(cleanDate, timeFormat))
                                        except CatchableError:
                                            val = newString(v[0])
                                    else:
                                        val = newString(v[0])
                            else:
                                val = newStringBlock(v)
                            ret["headers"].d[k] = val
                
                    push newDictionary(ret)
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
                "chrome"    : ({Logical},"open in Chrome windows as an app")
            },
            returns     = {Nothing},
            example     = """
            serve .port:18966 [
                
                GET "/"                     [ "This is the homepage" ]
                GET "/post"                 $[id][ 
                                                send.html ~"This is the post with id: |id|" 
                                            ]                
                POST "/getinfo"             $[id][ 
                                                send.json write.json ø #[
                                                    i: id
                                                    msg: "This is some info"
                                                ] 
                                            ]
            ]
            
            ; run the app and go to localhost:18966 - that was it!
            ; the app will respond to GET requests to "/" or "/post?id=..."
            ; and also POST requests to "/getinfo" with an 'id' parameter
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
                when defined(SAFE): Error_OperationNotPermitted("serve")

                # get parameters
                let routes = x
                var port = 18966
                var verbose = not (hadAttr("verbose"))
                if checkAttr("port"):
                    port = aPort.i
            
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
                            let parts = reqPath.split("?")
                            reqPath = parts[0]
                            for k,v in decodeQuery(parts[1]):
                                reqQuery[k] = newString(v)

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
                                "headers": newStringDictionary(reqHeaders, collapseBlocks=true)
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
                        req.respond(newServerResponse(
                            responseDict["body"].s,
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
