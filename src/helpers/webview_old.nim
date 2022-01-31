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

when not defined(NOWEBVIEW):
    {.passC: "-DWEBVIEW_STATIC -DWEBVIEW_IMPLEMENTATION".}
    {.passC: "-I" & currentSourcePath().substr(0, high(currentSourcePath()) - 4) .}

    when defined(linux):
        {.passC: "-DWEBVIEW_GTK=1 " &
        staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0".}
        {.passL: staticExec"pkg-config --libs gtk+-3.0 webkit2gtk-4.0".}
    elif defined(freebsd):
        {.passC: "-DWEBVIEW_GTK=1 " &
        staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
        {.passL: staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
    elif defined(windows):
        {.passC: "-DWEBVIEW_WINAPI=1".}
        {.passL: "-lole32 -lcomctl32 -loleaut32 -luuid -lgdi32".}
    elif defined(macosx):
        {.passC: "-DWEBVIEW_COCOA=1 -x objective-c".}
        {.passL: "-framework Cocoa -framework WebKit".}

#=======================================
# Libraries
#=======================================

import os, osproc, strutils

#=======================================
# Types
#=======================================

when not defined(NOWEBVIEW):

    type
        WebviewPrivObj  {.importc: "struct webview_priv", header: "webview.h", bycopy.} = object
        WebviewObj*     {.importc: "struct webview", header: "webview.h", bycopy.} = object
            url*        {.importc: "url".}: cstring
            title*      {.importc: "title".}: cstring
            width*      {.importc: "width".}: cint
            height*     {.importc: "height".}: cint
            resizable*  {.importc: "resizable".}: cint
            debug*      {.importc: "debug".}: cint
            invokeCb    {.importc: "external_invoke_cb".}: pointer
            priv        {.importc: "priv".}: WebviewPrivObj
            userdata    {.importc: "userdata".}: pointer
        Webview* = ptr WebviewObj

        DialogType* {.size: sizeof(cint).} = enum
            dtOpen  = 0
            dtSave  = 1
            dtAlert = 2

#=======================================
# C Imports
#=======================================

when not defined(NOWEBVIEW):
    proc init*(w: Webview): cint {.importc: "webview_init", header: "webview.h".}
    proc loop*(w: Webview; blocking: cint): cint {.importc: "webview_loop", header: "webview.h".}
    proc eval*(w: Webview; js: cstring): cint {.importc: "webview_eval", header: "webview.h".}
    proc getEval*(w: Webview; js: cstring): cstring {.importc: "webview_eval_get", header: "webview.h".}
    proc injectCss*(w: Webview; css: cstring): cint {.importc: "webview_inject_css", header: "webview.h".}
    proc setTitle*(w: Webview; title: cstring) {.importc: "webview_set_title", header: "webview.h".}
    proc setColor*(w: Webview; r,g,b,a: uint8) {.importc: "webview_set_color", header: "webview.h".}
    proc setFullscreen*(w: Webview; fullscreen: cint) {.importc: "webview_set_fullscreen", header: "webview.h".}
    proc dialog*(w: Webview; dlgtype: DialogType; flags: cint; title: cstring; arg: cstring; result: cstring; resultsz: csize_t) {.importc: "webview_dialog", header: "webview.h".}
    #proc dispatch(w: Webview; fn: pointer; arg: pointer) {.importc: "webview_dispatch", header: "webview.h".}
    proc terminate*(w: Webview) {.importc: "webview_terminate", header: "webview.h".}
    proc exit*(w: Webview) {.importc: "webview_exit", header: "webview.h".}
    proc debug*(format: cstring) {.varargs, importc: "webview_debug", header: "webview.h".}
    proc printLog*(s: cstring) {.importc: "webview_print_log", header: "webview.h".}
    proc webview*(title: cstring; url: cstring; w: cint; h: cint; resizable: cint): cint {.importc: "webview", header: "webview.h".}

#=======================================
# Methods
#=======================================

proc openChromeWindow*(port: int, flags: seq[string] = @[]) =
    var args = " --app=http://localhost:" & port.intToStr & "/ --disable-http-cache"
    for flag in flags:
        args &= " " & flag.strip

    var chromePath: string

    when hostOS == "macosx":
        chromePath = r"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
        if fileExists(absolutePath(chromePath)):
            chromePath = chromePath.replace(" ", r"\ ")
    elif hostOS == "windows":
        chromePath = r"\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    elif hostOS == "linux":
        const chromeNames = ["google-chrome", "chromium-browser", "chromium"]
        for name in chromeNames:
            if execCmd("which " & name) == 0:
                chromePath = name
                break

    let command = chromePath & args
    if execCmd(command) != 0:
        echo "could not open a Chrome window"

when not defined(NOWEBVIEW):
    proc generalExternalInvokeCallback(w: Webview, arg: cstring) {.exportc.} =
        echo "generalExternalInvoke: " & $(arg)
        # var handled = false
        # if eps.hasKey(w):
        #     try:
        #         var mi = parseJson($arg).to(MethodInfo)
        #         if hasKey(eps[w], mi.scope) and hasKey(eps[w][mi.scope], mi.name):
        #             discard eps[w][mi.scope][mi.name](mi.args)
        #             handled = true
        #     except:
        #         echo getCurrentExceptionMsg()

        # elif cbs.hasKey(w): 
        #     cbs[w](w, $arg)
        #     handled = true

        # if handled == false:
        #     echo "external invode:'", arg, "' not handled"

    proc createWebView*(title="Arturo", url="", 
                     width=640, height=480, 
                     resizable=true, debug=false,
                     handler: pointer): Webview =
        var w = cast[Webview](alloc0(sizeof(WebviewObj)))
        w.title = title
        w.url = url
        w.width = width.cint
        w.height = height.cint
        w.resizable = if resizable: 1 else: 0
        w.debug = if debug: 1 else: 0
        w.invokeCb = handler
        if w.init() != 0: return nil

        discard w.eval """
            if (typeof arturo === 'undefined') {
                arturo = {};
            }
            arturo.call = function(method,args) {
                window.external.invoke(
                    JSON.stringify({
                        method: method,
                        args: args
                    })
                );
            };
        """

        return w

    proc run*(w: Webview)=
        while w.loop(1) == 0:
            discard

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