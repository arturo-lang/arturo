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

    ServerResponseContent* = enum
        HTMLResponse,
        CSSResponse,
        XMLResponse,
        TextResponse

    ServerResponse* = ref object
        body*       : string
        status*     : HttpCode
        content*    : ServerResponseContent
        

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

proc generateHeaders*(resp: ServerResponse): string =
    result = ""
    
    # if resp.status == Http200:
    #     var contentType = "Content-Type: "
    #     case resp.content: 
    #         of HTMLResponse:
    #             contentType &= "text/html; charset=UTF-8"
    #         of CSSResponse:
    #             contentType &= "text/css"
    #         of XMLResponse:
    #             contentType &= "text/xml"
    #         of TextResponse:
    #             contentType &= "text/plain"

    #     result = contentType
    
proc newServerResponse*(body = "", status = Http200, content = HTMLResponse): ServerResponse =
    ServerResponse(body: body, status: status, content: content)

proc error404*(): ServerResponse =
    ServerResponse(body: "", status: Http404, content: HTMLResponse)

#=======================================
# Methods
#=======================================

proc respond*(req: ServerRequest, resp: ServerResponse) =
    send(req.Request, resp.status, resp.body, none(string), generateHeaders(resp))

proc startServer*(handler: RequestHandler, port: int = 18966) =
    let settings = initSettings(port.Port)

    run(handler.OnRequest, settings)