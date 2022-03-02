######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/servers.nim
######################################################

#=======================================
# Libraries
#=======================================

import nativesockets, options
import extras/httpx

#=======================================
# Types
#=======================================

type
    RequestHandler* = distinct OnRequest
    ServerRequest* = distinct Request
    ServerSettings* = distinct Settings

    ServerResponse* = ref object
        body*       : string
        status*     : HttpCode
        headers*    : string
        

#=======================================
# Helpers
#=======================================

proc ip*(req: ServerRequest): string =
    ip(req.Request)

proc path*(req: ServerRequest): string =
    path(req.Request).get()

proc action*(req: ServerRequest): HttpMethod =
    httpMethod(req.Request).get()

proc headers*(req: ServerRequest): HttpHeaders =
    headers(req.Request).get()

proc body*(req: ServerRequest): string =
    body(req.Request).get()
    
proc newServerResponse*(body = "", status = Http200, headers = ""): ServerResponse =
    ServerResponse(body: body, status: status, headers: headers)

#=======================================
# Methods
#=======================================

proc respond*(req: ServerRequest, resp: ServerResponse) =
    send(req.Request, resp.status, resp.body, none(string), resp.headers)

proc startServer*(handler: RequestHandler, port: int = 18966) =
    let settings = initSettings(port.Port)

    run(handler.OnRequest, settings)