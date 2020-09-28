######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Net.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value
import utils

#=======================================
# Methods
#=======================================

template Mail*():untyped =
    require(opMail)

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

template Download*():untyped =
    require(opDownload)

    let path = x.s

    let attrs = getAttrs()
    var target: string

    if attrs.hasKey("as"):
        target = attrs["as"].s
    else:
        target = extractFilename(path)

    var client = newHttpClient()
    client.downloadFile(path,target)

template Serve*():untyped =
    require(opServe)

    let routes = x

    let attrs = getAttrs()

    var port = 18966
    var verbose = attrs.hasKey("verbose")
    if attrs.hasKey("port"):
        port = attrs["port"].i

    var server = newAsyncHttpServer()

    proc handler(req: Request) {.async,gcsafe.} =
        if verbose:
            echo fgMagenta & "<< [" & req.protocol[0] & "] " & req.hostname & ": " & fgWhite & req.url.path & " // " & req.url.query

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

                for capture in (toSeq(pairs(captures))).reversed:
                    stack.push(newString(capture[1]))

                discard execBlock(routes.d[k], execInParent=true, useArgs=true, args=args)
                body = stack.pop().s
                routeFound = k
                break

        if routeFound=="":
            status = 404
            body = "page not found!"

        if verbose:
            echo fgGreen & ">> [" & $(status) & "] " & routeFound & fgWhite

        await req.respond(status.HttpCode, body, headers)

    try:
        echo ":: Starting server on port " & $(port) & "...\n"
        waitFor server.serve(port = port.Port, callback = handler, address = "")
    except:
        let e = getCurrentException()
        echo "Something went wrong." & e.msg
        server.close()