#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/webview.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os, osproc, strutils
import vm/errors

when not defined(NOWEBVIEW):
    import std/json

    import extras/webview
    when defined(macosx):
        import extras/menubar
    import helpers/jsonobject
    import helpers/url
    import helpers/windows
    import vm/values/value

    export webview

#=======================================
# Types
#=======================================

when not defined(NOWEBVIEW):
    type
        WebviewCallKind* = enum
            FunctionCall,
            ExecuteCode,
            BackendAction,
            WebviewEvent,
            UnrecognizedCall

        WebviewCallHandler* = proc (call: WebviewCallKind, value: Value): Value

#=======================================
# Variables
#=======================================

when not defined(NOWEBVIEW):
    var
        mainWebview* {.global.}      : Webview
        mainCallHandler* {.global.}  : WebviewCallHandler

#=======================================
# Forward declarations
#=======================================

when not defined(NOWEBVIEW):
    proc getWindow*(w: Webview): Window 

#=======================================
# Methods
#=======================================

proc openChromeWindow*(port: int, flags: seq[string] = @[]) =
    var args = @[
        "--app=http://localhost:" & port.intToStr & "/ ",
        "--disable-http-cache",
        "--disable-background-networking",
        "--disable-background-timer-throttling", 
        "--disable-backgrounding-occluded-windows", 
        "--disable-breakpad", 
        "--disable-client-side-phishing-detection", 
        "--disable-default-apps", 
        "--disable-dev-shm-usage", 
        "--disable-infobars", 
        "--disable-extensions", 
        "--disable-features=site-per-process", 
        "--disable-hang-monitor", 
        "--disable-ipc-flooding-protection", 
        "--disable-popup-blocking", 
        "--disable-prompt-on-repost", 
        "--disable-renderer-backgrounding", 
        "--disable-sync", 
        "--disable-translate", 
        "--disable-windows10-custom-titlebar", 
        "--metrics-recording-only", 
        "--no-first-run", 
        "--no-default-browser-check", 
        "--safebrowsing-disable-auto-update", 
        "--enable-automation", 
        "--password-store=basic", 
        "--use-mock-keychain"
    ]

    for flag in flags:
        args &= flag.strip

    var chromeBinaries: seq[string]
    var chromePath: string

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
        RuntimeError_CompatibleBrowserNotFound()
    else:
        let command = chromePath.replace(" ", r"\ ") & " " & args.join(" ")
        if execCmd(command) != 0:
            RuntimeError_CompatibleBrowserCouldNotOpenWindow()

when not defined(NOWEBVIEW):

    # proc startWebView*(content: string): Webview =
    #     result = webview_create(1)
    #     result.webview_set_title("This is a - successful - test".cstring)
    #     result.webview_set_size(320.cint, 480.cint, Default)
    #     result.webview_set_html(content.cstring)
    #     result.webview_run()
    #     result.webview_destroy()

    proc newWebView*(title       : string                = "Arturo", 
                     content     : string                = "", 
                     width       : int                   = 640, 
                     height      : int                   = 480, 
                     resizable   : bool                  = true, 
                     maximized   : bool                  = false,
                     fullscreen  : bool                  = false,
                     borderless  : bool                  = false,
                     topmost     : bool                  = false,
                     debug       : bool                  = false, 
                     initializer : string                = "",
                     callHandler : WebviewCallHandler    = nil): Webview =

        echo "webview_create"
        result = webview_create(debug.cint)
        echo "webview_set_title"
        webview_set_title(result, title=title.cstring)
        echo "webview_set_size"
        webview_set_size(result, width.cint, height.cint, if resizable: Constraints.Default else: Constraints.Fixed)
        if content.isUrl():
            echo "webview_navigate"
            webview_navigate(result, content.cstring)
        else:
            echo "webview_set_html"
            webview_set_html(result, content.cstring)

        echo "webview_init"
        webview_init(result,(
            (static readFile(parentDir(currentSourcePath()) & "/webviews.js")) & 
            "\n" & 
            initializer
        ).cstring)

        if maximized:
            result.getWindow().maximize()

        if fullscreen:
            result.getWindow().fullscreen()

        if borderless:
            result.getWindow().makeBorderless()
            result.getWindow().show()

        if topmost or borderless:
            result.getWindow().topmost()

        echo "setting handler..."
        let handler = proc (seq: ccstring, req: ccstring, arg: pointer) {.cdecl.} =
            echo "inside handler!"
            echo "request: " & $(cast[cstring](req))
            var request = parseJson($(cast[cstring](req)))

            echo $(request)

            let mode = request.elems[0].str
            let value = valueFromJson(request.elems[1].str)

            echo "MODE: " & mode

            var res = 0
            var callKind: WebviewCallKind
            var returned: cstring = "{}"

            case mode:
                of "call"   : callKind = FunctionCall
                of "exec"   : callKind = ExecuteCode
                of "event"  : callKind = WebviewEvent
                of "action" : callKind = BackendAction
                else        : 
                    res = 1
                    callKind = UnrecognizedCall

            if callKind == BackendAction:
                case value.s:
                    of "window.maximize":
                        mainWebview.getWindow().maximize()
                    of "window.unmaximize":
                        mainWebview.getWindow().unmaximize()
                    of "window.show":
                        mainWebview.getWindow().show()
                    of "window.hide":
                        mainWebview.getWindow().hide()
                    of "window.fullscreen":
                        mainWebview.getWindow().fullscreen()
                    of "window.unfullscreen":
                        mainWebview.getWindow().unfullscreen()
                    else:
                        discard
            else:
                if callKind != UnrecognizedCall:
                    echo "calling main handler..."
                    returned = jsonFromValue(mainCallHandler(callKind, value), pretty=false).cstring

            echo "webview_return"
            webview_return(mainWebview, cast[cstring](seq), res.cint, returned)

        echo "setting mainWebview"
        mainWebview = result
        echo "setting mainCallHandler"
        mainCallHandler = callHandler
        echo "webview_bind"
        result.webview_bind("callback", handler, cast[pointer](0))

    proc show*(w: Webview) =
        when defined(macosx):
            echo "generating default main menu"
            generateDefaultMainMenu()

        echo "webview_run"
        webview_run(w)
        echo "webview_destroy"
        webview_destroy(w)

    proc evaluate*(w: Webview, js: string) =
        echo "WV:evaluate"
        webview_eval(w, js.cstring)

    proc getWindow*(w: Webview): Window =
        echo "WV:getWindow"
        webview_get_window(w)
