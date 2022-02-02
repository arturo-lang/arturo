######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Net.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import algorithm, asyncdispatch, asynchttpserver
    import cgi, httpclient, httpcore, os
    import sequtils, smtp, strutils, times
    import nre except toSeq

    import helpers/jsonobject
    import helpers/terminal
    import helpers/url
    import helpers/webview

import vm/lib
when not defined(WEB):
    import vm/[env, exec]
when defined(SAFE):
    import vm/[errors]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Net"

    when not defined(WEB):
        

        builtin "download",
            alias       = unaliased, 
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
            ;;;;
            download.as:"arturoLogo.png"
                        "https://github.com/arturo-lang/arturo/raw/master/logo.png"
            
            ; (downloads file with a different name)
            """:
                ##########################################################
                when defined(SAFE): RuntimeError_OperationNotPermitted("download")
                let path = x.s

                var target: string

                if (let aAs = popAttr("as"); aAs!=VNULL):
                    target = aAs.s
                else:
                    target = extractFilename(path)

                var client = newHttpClient()
                client.downloadFile(path,target)

        builtin "mail",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "send mail using given message and configuration",
            args        = {
                "recipient" : {String},
                "message"   : {Dictionary},
                "config"    : {Dictionary}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            mail "recipient@somemail.com"
                #[
                    title: "Hello from Arturo"
                    content: "Arturo rocks!"
                ]
                #[
                    server: "mymailserver.com"
                    username: "myusername"
                    password: "mypass123"
                ]
            """:
                ##########################################################
                when defined(SAFE): RuntimeError_OperationNotPermitted("mail")
                let recipient = x.s
                let message = y.d
                let config = z.d

                var mesg = createMessage(message["title"].s,
                                    message["content"].s,
                                    @[recipient])
                let smtpConn = newSmtp(useSsl = true, debug=true)
                smtpConn.connect(config["server"].s, Port 465)
                smtpConn.auth(config["username"].s, config["password"].s)
                smtpConn.sendmail(config["username"].s, @[recipient], $mesg)

        # TODO(Net\request) could it work for Web/JS builds?
        #  it could easily be a hidden Ajax request
        #  labels: library,enhancement,open discussion,web
        builtin "request",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "perform HTTP request to url with given data and get response",
            args        = {
                "url"   : {String},
                "data"  : {Dictionary, Null}
            },
            attrs       = {
                "get"       : ({Logical},"perform a GET request (default)"),
                "post"      : ({Logical},"perform a POST request"),
                "patch"     : ({Logical},"perform a PATCH request"),
                "put"       : ({Logical},"perform a PUT request"),
                "delete"    : ({Logical},"perform a DELETE request"),
                "json"      : ({Logical},"send data as Json"),
                "headers"   : ({Dictionary},"send custom HTTP headers"),
                "agent"     : ({String},"use given user agent"),
                "timeout"   : ({Integer},"set a timeout"),
                "proxy"     : ({String},"use given proxy url"),
                "raw"       : ({Logical},"return raw response without processing")
            },
            returns     = {Dictionary},
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
                ;;;;
                r: request "https://httpbin.org/get" #[some:"arg" another: 123]
                body: read.json r\body
                inspect body\headers
                ; [ :dictionary
	            ;       Content-Length   :	0 :string
	            ;       Host             :	httpbin.org :string
	            ;       User-Agent       :	Arturo HTTP Client / 0.9.75 :string
	            ;       X-Amzn-Trace-Id  :	Root=1-608fd5f3-7e47203117863c111a3aef3b :string
                ; ]
                ;;;;
                print (request "https://httpbin.org/get" #[]) \ 'status
                ; 200
                ;;;;
                print request.post "https://httpbin.org/post" #[some:"arg" another: 123]
                ; ...same as above...
            """:
                ##########################################################
                when defined(SAFE): RuntimeError_OperationNotPermitted("request")

                var url = x.s
                var meth: HttpMethod = HttpGet 

                if (popAttr("get")!=VNULL): discard
                if (popAttr("post")!=VNULL): meth = HttpPost
                if (popAttr("patch")!=VNULL): meth = HttpPatch
                if (popAttr("put")!=VNULL): meth = HttpPut
                if (popAttr("delete")!=VNULL): meth = HttpDelete

                var headers: HttpHeaders = newHttpHeaders()
                if (let aHeaders = popAttr("headers"); aHeaders != VNULL):
                    var headersArr: seq[(string,string)] = @[]
                    for k,v in pairs(aHeaders.d):
                        headersArr.add((k, $(v)))
                    headers = newHttpHeaders(headersArr)

                var agent = "Arturo HTTP Client / " & $(getSystemInfo()["version"])
                if (let aAgent = popAttr("agent"); aAgent != VNULL):
                    agent = aAgent.s

                var timeout: int = -1
                if (let aTimeout = popAttr("timeout"); aTimeout != VNULL):
                    timeout = aTimeout.i

                var proxy: Proxy = nil
                if (let aProxy = popAttr("proxy"); aProxy != VNULL):
                    proxy = newProxy(aProxy.s)

                var body: string = ""
                var multipart: MultipartData = nil
                if meth != HttpGet:
                    if (popAttr("json") != VNULL):
                        headers.add("Content-Type", "application/json")
                        body = jsonFromValue(y, pretty=false)
                    else:
                        multipart = newMultipartData()
                        for k,v in pairs(y.d):
                            echo "adding multipart data:" & $(k)
                            multipart[k] = $(v)
                else:
                    if y != VNULL and (y.kind==Dictionary and y.d.len!=0):
                        var parts: seq[string] = @[]
                        for k,v in pairs(y.d):
                            parts.add(k & "=" & urlencode($(v)))
                        url &= "?" & parts.join("&")

                let client = newHttpClient(userAgent = agent,
                                        proxy = proxy, 
                                        timeout = timeout,
                                        headers = headers)

                let response = client.request(url = url,
                                            httpMethod = meth,
                                            body = body,
                                            multipart = multipart)

                var ret: ValueDict = initOrderedTable[string,Value]()
                ret["version"] = newString(response.version)
                
                ret["body"] = newString(response.body)
                ret["headers"] = newDictionary()

                if (popAttr("raw")!=VNULL):
                    ret["status"] = newString(response.status)

                    for k,v in response.headers.table:
                        ret["headers"].d[k] = newStringBlock(v)
                else:
                    try:
                        let respStatus = (response.status.splitWhitespace())[0]
                        ret["status"] = newInteger(respStatus)
                    except:
                        ret["status"] = newString(response.status)

                    for k,v in response.headers.table:
                        var val: Value
                        if v.len==1:
                            case k
                                of "age","content-length": 
                                    try:
                                        val = newInteger(v[0])
                                    except:
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
                                    except:
                                        val = newString(v[0])
                                else:
                                    val = newString(v[0])
                        else:
                            val = newStringBlock(v)
                        ret["headers"].d[k] = val

                push newDictionary(ret)

        # TODO(Net\serve) add documentation for `.kill`
        #  labels: library,documentation,easy
        builtin "serve",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "start web server using given routes",
            args        = {
                "routes"    : {Dictionary}
            },
            attrs       = {
                "port"      : ({Integer},"use given port"),
                "verbose"   : ({Logical},"print info log"),
                "chrome"    : ({Logical},"open in Chrome windows as an app"),
                "kill"      : ({String},"bind a kill signal to the server (default: '/exit')")
            },
            returns     = {Nothing},
            example     = """
            serve .port:18966 #[
                "/":                          [ "This is the homepage" ]
                "/post/(?<title>[a-z]+)":     [ render "We are in post: |title|" ]
            ]
            
            ; (run the app and go to localhost:18966 - that was it!)
            """:
                ##########################################################
                when defined(SAFE): RuntimeError_OperationNotPermitted("serve")
                #{.push warning[GcUnsafe2]:off.}
                when not defined(VERBOSE):
                    let routes = x

                    var port = 18966
                    var verbose = (popAttr("verbose") != VNULL)
                    if (let aPort = popAttr("port"); aPort != VNULL):
                        port = aPort.i

                    var killPath = "/exit"
                    if (let aKill = popAttr("kill"); aKill != VNULL):
                        killPath = aKill.s
                
                    if (let aChrome = popAttr("chrome"); aChrome != VNULL):
                        openChromeWindow(port)

                    proc startServer {.async.} =

                        var server = newAsyncHttpServer()

                        proc handler(req: Request) {.async,gcsafe.} =
                            if verbose:
                                stdout.write bold(magentaColor) & "<< [" & req.protocol[0] & "] " & req.hostname & ": " & resetColor & ($(req.reqMethod)).replace("Http").toUpperAscii() & " " & req.url.path
                                if req.url.query!="":
                                    stdout.write "?" & req.url.query

                                stdout.write "\n"
                                stdout.flushFile()

                            # echo "body: " & req.body

                            # echo "========"
                            # for k,v in pairs(req.headers):
                            #     echo k & " => " & v
                            # echo "========"

                            var status = 200
                            var headers = newHttpHeaders()

                            var body: string

                            var routeFound = ""
                    
                            for k in routes.d.keys:
                                let route = req.url.path.match(nre.re(k & "$"))

                                if not route.isNone:

                                    var args: ValueArray = @[]

                                    let captures = route.get.captures.toTable

                                    for group,capture in captures:
                                        args.add(newString(group))

                                    if req.reqMethod==HttpPost:
                                        for d in decodeData(req.body):
                                            args.add(newString(d[0]))

                                        for d in (toSeq(decodeData(req.body))).reversed:
                                            push(newString(d[1]))

                                    for capture in (toSeq(pairs(captures))).reversed:
                                        push(newString(capture[1]))

                                    try:
                                        {.cast(gcsafe).}:
                                            discard execBlock(routes.d[k], execInParent=true, args=args, memoized=Value(kind: Null))
                                    except:
                                        let e = getCurrentException()
                                        echo "Something went wrong: " & e.msg
                                    body = pop().s
                                    routeFound = k
                                    break

                            if routeFound=="":
                                let subpath = joinPath(env.currentPath(),req.url.path)
                                if fileExists(subpath):
                                    body = readFile(subpath)
                                else:
                                    status = 404
                                    body = "page not found!"

                            if verbose:
                                echo bold(greenColor) & ">> [" & $(status) & "] " & routeFound & resetColor

                            if req.url.path==killPath:
                                raise newException(Exception, "Received kill signal")

                            await req.respond(status.HttpCode, body, headers)

                        try:
                            if verbose:
                                echo ":: Starting server on port " & $(port) & "...\n"
                            server.listen(Port(port))
                            while true:
                                if server.shouldAcceptRequest():
                                    await server.acceptRequest(handler)
                                else:
                                    await sleepAsync(500)
                            #waitFor server.serve(port = port.Port, callback = handler, address = "")
                        except:
                            let e = getCurrentException()
                            echo ":: Server message: " & e.msg
                            server.close()

                    waitFor startServer()

                #{.push warning[GcUnsafe2]:on.}

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)