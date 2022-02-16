######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/webview.nim
######################################################

# TODO(Helpers\webview): Add support for new version of Webview library
#  from https://github.com/webview/webview
#  labels: library, 3rd-party

#=======================================
# Command-line arguments
#=======================================

# when not defined(NOWEBVIEW):
#     {.passC: "-DWEBVIEW_STATIC -DWEBVIEW_IMPLEMENTATION".}
#     {.passC: "-I" & currentSourcePath().substr(0, high(currentSourcePath()) - 4) .}

#     when defined(linux):
#         {.passC: "-DWEBVIEW_GTK=1 " &
#         staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0".}
#         {.passL: staticExec"pkg-config --libs gtk+-3.0 webkit2gtk-4.0".}
#     elif defined(freebsd):
#         {.passC: "-DWEBVIEW_GTK=1 " &
#         staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
#         {.passL: staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
#     elif defined(windows):
#         {.passC: "-DWEBVIEW_WINAPI=1".}
#         {.passL: "-lole32 -lcomctl32 -loleaut32 -luuid -lgdi32".}
#     elif defined(macosx):
#         {.passC: "-DWEBVIEW_COCOA=1 -x objective-c".}
#         {.passL: "-framework Cocoa -framework WebKit".}

#=======================================
# Libraries
#=======================================

import os, osproc, strutils

when not defined(NOWEBVIEW):
    import extras/webview/webview
    import helpers/jsonobject
    import vm/values/value

    export webview

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

    proc createWebView*(title="Arturo", url="", width=640, height=480, resizable=true, debug=false, handler:WebviewCallback): Webview =
        result = newWebview(title, url, width=width, height=height, debug=true)
        webview_init(result,"""
            if (typeof arturo === 'undefined') {
                arturo = {};
            }
            arturo.call = function(method,args) {
                window.backend(
                    JSON.stringify({
                        method: method,
                        args: args
                    })
                );
            };
        """)

        result.webview_bind("callback", handler, cast[pointer](666))

        # proc receiver(seq: cstring, req: cstring, arg: pointer) {.cdecl.} =
        #     echo "SEQ: " & $(seq)
        #     echo "GOT: " & $(req)
        #     echo "arg: " & $(cast[int](arg))

        #     wt.webview_return(seq, 0.cint, ($ %*("this is a message")).cstring)

        # wt.webview_bind("something", receiver, cast[pointer](666))

    proc showWebview*(w: Webview) =
        w.show()
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

# when not defined(MINI):
#     proc bindMethod*(w: Webview, scope, name: string, p: (proc(param: Value): string)) =

#         proc hook(hookParam: string): string =
#             var 
#                 paramVal: Value
#                 retVal: string
#             try:
#                 paramVal = parseJsonNode(parseJson(hookParam))
#                 # echo $(jnode)
#                 # paramVal = jnode.to(P)
#             except:
#                 return "parse args failed: " & getCurrentExceptionMsg()
            
#             retVal = p(paramVal)
#             return $(%*retVal) # ==> json
        
#         discard eps.hasKeyOrPut(w, newTable[string, TableRef[string, CallHook]]())
#         discard hasKeyOrPut(eps[w], scope, newTable[string, CallHook]())
#         eps[w][scope][name] = hook
#         w.dispatch(proc() = discard w.eval(jsTemplate%[name, scope]))

# when not defined(MINI):
#     ## Something

# else:
#     proc showWebview*(title="WebView", url="", 
#                       width=640, height=480, 
#                       resizable=true, debug=false) =

#         echo "- feature not supported in MINI builds"

# proc showWebview*(title="WebView", url="", 
#                   width=640, height=480, 
#                   resizable=true, debug=false, bindings:ValueDict) =

#     let wv = newWebview(title=title, 
#                           url=url, 
#                         width=width, 
#                        height=height, 
#                     resizable=true, 
#                         debug=true,
#                            cb=nil)

#     for key,binding in bindings:
#         let meth = key

#         wv.bindMethod("webview", meth, proc (param: Value): string =
#             echo "calling method: " & meth
#             echo " - with argument: " & $(param)
#             echo " - for parameter: " & $(binding.params.a[0])

#             var args: ValueArray = @[binding.params.a[0]]

#             echo "calling function!"
#             discard execBlock(binding.main, execInParent=true, useArgs=true, args=args)
#             let got = stack.pop().s
#             echo " - got: " & $(got)

#             discard wv.eval(got)
#         )

#     # proc wvCallback (param: seq[string]): string =
#     #     echo "wvCallback :: " & param
#     #     echo "executing something..."
#     #     discard wv.eval("console.log('execd in JS');")
#     #     echo "returning value..."
#     #     return "returned value"

#     # wv.bindProc("webview","run",wvCallback)

#     wv.run()
#     wv.exit()