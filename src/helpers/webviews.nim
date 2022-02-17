######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/webview.nim
######################################################

#=======================================
# Libraries
#=======================================

import std/json, std/jsonutils
import os, osproc, strutils

when not defined(NOWEBVIEW):
    import extras/webview
    import helpers/jsonobject
    import vm/values/value, vm/values/printable

    export webview

#=======================================
# Types
#=======================================

type
    WebviewCallKind* = enum
        FunctionCall,
        BackendAction,
        UnrecognizedCall

    WebviewCallHandler* = proc (call: WebviewCallKind, value: Value): Value

#=======================================
# Variables
#=======================================

var
    mainWebview* {.global.}      : Webview
    mainCallHandler* {.global.}  : WebviewCallHandler

#=======================================
# Methods
#=======================================

proc openChromeWindow*(port: int, flags: seq[string] = @[]) =
    var args = @[
        "--app=http://localhost:" & port.intToStr & "/ ",
        "--disable-http-cache",
        # "--disable-background-networking",
        # "--disable-background-timer-throttling", 
        # "--disable-backgrounding-occluded-windows", 
        # "--disable-breakpad", 
        # "--disable-client-side-phishing-detection", 
        # "--disable-default-apps", 
        # "--disable-dev-shm-usage", 
        # "--disable-infobars", 
        # "--disable-extensions", 
        # "--disable-features=site-per-process", 
        # "--disable-hang-monitor", 
        # "--disable-ipc-flooding-protection", 
        # "--disable-popup-blocking", 
        # "--disable-prompt-on-repost", 
        # "--disable-renderer-backgrounding", 
        # "--disable-sync", 
        # "--disable-translate", 
        # "--disable-windows10-custom-titlebar", 
        # "--metrics-recording-only", 
        # "--no-first-run", 
        # "--no-default-browser-check", 
        # "--safebrowsing-disable-auto-update", 
        # "--enable-automation", 
        # "--password-store=basic", 
        # "--use-mock-keychain"
    ]

    for flag in flags:
        args &= flag.strip

    var chromeBinaries: seq[string]
    var chromePath = ""

    when hostOS == "macosx":
        chromeBinaries = @[
            r"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
            r"/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary",
            r"/Applications/Chromium.app/Contents/MacOS/Chromium",
            r"/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge",
            r"/usr/bin/google-chrome-stable",
            r"/usr/bin/google-chrome",
            r"/usr/bin/chromium",
            r"/usr/bin/chromium-browser"
        ]
    elif hostOS == "windows":
        chromeBinaries = @[
            getEnv("LocalAppData") & r"/Google/Chrome/Application/chrome.exe",
            getEnv("ProgramFiles") & r"/Google/Chrome/Application/chrome.exe",
            getEnv("ProgramFiles(x86)") & r"/Google/Chrome/Application/chrome.exe",
            getEnv("LocalAppData") & r"/Chromium/Application/chrome.exe",
            getEnv("ProgramFiles") & r"/Chromium/Application/chrome.exe",
            getEnv("ProgramFiles(x86)") & r"/Chromium/Application/chrome.exe",
            getEnv("ProgramFiles(x86)") & r"/Microsoft/Edge/Application/msedge.exe",
            getEnv("ProgramFiles") & r"/Microsoft/Edge/Application/msedge.exe"
        ]
    elif hostOS == "linux":
        chromeBinaries = @[
            r"/usr/bin/google-chrome-stable",
            r"/usr/bin/google-chrome",
            r"/usr/bin/chromium",
            r"/usr/bin/chromium-browser",
            r"/snap/bin/chromium"
        ]

    for bin in chromeBinaries:
        if fileExists(bin):
            chromePath = bin
            break

    if chromePath == "":
        echo "could not find any Chrome-compatible browser installed"
    else:
        let command = chromePath.replace(" ", r"\ ") & " " & args.join(" ")
        if execCmd(command) != 0:
            echo "could not open a Chrome window"

when not defined(NOWEBVIEW):
    # proc generalExternalInvokeCallback(w: Webview, arg: cstring) {.exportc.} =
    #     echo "generalExternalInvoke: " & $(arg)
    #     # var handled = false
    #     # if eps.hasKey(w):
    #     #     try:
    #     #         var mi = parseJson($arg).to(MethodInfo)
    #     #         if hasKey(eps[w], mi.scope) and hasKey(eps[w][mi.scope], mi.name):
    #     #             discard eps[w][mi.scope][mi.name](mi.args)
    #     #             handled = true
    #     #     except:
    #     #         echo getCurrentExceptionMsg()

    #     # elif cbs.hasKey(w): 
    #     #     cbs[w](w, $arg)
    #     #     handled = true

    #     # if handled == false:
    #     #     echo "external invode:'", arg, "' not handled"

    proc createWebView*(title="Arturo", 
                        url="", 
                        width=640, 
                        height=480, 
                        resizable=true, 
                        debug=false, 
                        callHandler:WebviewCallHandler = nil): Webview =
        result = webview_create(debug.cint)
        webview_set_title(result, title=title.cstring)
        webview_set_size(result, width.cint, height.cint, if resizable: Constraints.Default else: Constraints.Fixed)
        webview_navigate(result, url.cstring)
        webview_init(result,"""
            if (typeof arturo === 'undefined') {
                arturo = {};
            }
            arturo.call = function (method){
                return window.callback("call", JSON.stringify({
                    "method": method,
                    "args": Array.prototype.slice.call(arguments, 1)
                }));
            };
        """)

        let handler = proc (seq: cstring, req: cstring, arg: pointer) {.cdecl.} =
            var request = parseJson($(req))

            let mode = request.elems[0].str
            let value = valueFromJson(request.elems[1].str)

            var res = 0
            var callKind: WebviewCallKind
            var returned: cstring = "{}"

            case mode:
                of "call"   : callKind = FunctionCall
                of "action" : callKind = BackendAction
                else        : 
                    res = 1
                    callKind = UnrecognizedCall

            if callKind != UnrecognizedCall:
                returned = jsonFromValue(mainCallHandler(callKind, value), pretty=false).cstring

            webview_return(mainWebview, seq, res.cint, returned)

        mainWebview = result
        mainCallHandler = callHandler
        result.webview_bind("callback", handler, cast[pointer](0))

        # result = newWebview(title, url, width=width, height=height, debug=true)
        # webview_init(result,"""
        #     if (typeof arturo === 'undefined') {
        #         arturo = {};
        #     }
        #     arturo.call = function(method,args) {
        #         window.backend(
        #             JSON.stringify({
        #                 method: method,
        #                 args: args
        #             })
        #         );
        #     };
        # """)

        # result.webview_bind("callback", handler, cast[pointer](666))

        # proc receiver(seq: cstring, req: cstring, arg: pointer) {.cdecl.} =
        #     echo "SEQ: " & $(seq)
        #     echo "GOT: " & $(req)
        #     echo "arg: " & $(cast[int](arg))

        #     wt.webview_return(seq, 0.cint, ($ %*("this is a message")).cstring)

        # wt.webview_bind("something", receiver, cast[pointer](666))

    proc showWebview*(w: Webview) =
        webview_run(w)
        webview_destroy(w)
        #w.show()
    # proc createWebView*(title="Arturo", url="", 
    #                  width=640, height=480, 
    #                  resizable=true, debug=false,
    #                  handler: pointer): Webview =
    #     var w = cast[Webview](alloc0(sizeof(WebviewObj)))
    #     w.title = title
    #     w.url = url
    #     w.width = width.cint
    #     w.height = height.cint
    #     w.resizable = if resizable: 1 else: 0
    #     w.debug = if debug: 1 else: 0
    #     w.invokeCb = handler
    #     if w.init() != 0: return nil

    #     discard w.eval """
    #         if (typeof arturo === 'undefined') {
    #             arturo = {};
    #         }
    #         arturo.call = function(method,args) {
    #             window.external.invoke(
    #                 JSON.stringify({
    #                     method: method,
    #                     args: args
    #                 })
    #             );
    #         };
    #     """

    #     return w

    # proc run*(w: Webview)=
    #     while w.loop(1) == 0:
    #         discard