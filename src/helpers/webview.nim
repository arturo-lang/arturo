######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/webview.nim
######################################################

#=======================================
# Command-line arguments
#=======================================

when not defined(NOWEBVIEW):
    {.compile("extras/webview.cpp", "-std=c++11").}
    {.passL: "-lstdc++".}

    when defined(linux):
        {.passC: "-DWEBVIEW_GTK=1 " &
                 staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0".}
        {.passL: staticExec"pkg-config --libs gtk+-3.0 webkit2gtk-4.0".}
    elif defined(freebsd):
        {.passC: "-DWEBVIEW_GTK=1 " &
                 staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
        {.passL: staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
    elif defined(windows):
        {.passC: "-DWEBVIEW_EDGE=1".}
        {.passL: "-L./dll/x64 -lwebview -lWebView2Loader".}
    elif defined(macosx):
        {.passC: "-DWEBVIEW_COCOA=1".}
        {.passL: "-framework Cocoa -framework WebKit".}

#=======================================
# Libraries
#=======================================

import os, osproc, strutils

#=======================================
# Types
#=======================================

type
    WebView* = pointer

#=======================================
# C Imports
#=======================================

when not defined(NOWEBVIEW):
    proc newWebview*(debug: bool, window: pointer): WebView {.importc: "webview_create", header:"webview.h".}
    proc setTitle*(w: WebView, title: cstring) {.importc:"webview_set_title", header:"webview.h".}
    proc setSize*(w: WebView, width: int, height: int, hints: int) {.importc:"webview_set_size", header:"webview.h".}
    proc navigate*(w: WebView, url: cstring) {.importc:"webview_navigate", header:"webview.h".}
    proc eval*(w: WebView, js: cstring) {.importc:"webview_eval", header:"webview.h".}
    proc run*(w: WebView) {.importc:"webview_run", header:"webview.h".}
    proc terminate*(w: WebView) {.importc:"webview_terminate", header:"webview.h".}
    proc destroy*(w: WebView) {.importc:"webview_destroy", header:"webview.h".}

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
    proc createWebView*(title="Arturo", url="", 
                     width=640, height=480, 
                     resizable=true, debug=false,
                     handler: pointer): WebView =
        var wv = newWebview(debug, nil)

        wv.setTitle(cstring(title))
        wv.setSize(width.cint, height.cint, 0.cint)
        wv.navigate(cstring(url))
        
        # var w = cast[Webview](alloc0(sizeof(WebviewObj)))
        # w.title = title
        # w.url = url
        # w.width = width.cint
        # w.height = height.cint
        # w.resizable = if resizable: 1 else: 0
        # w.debug = if debug: 1 else: 0
        # w.invokeCb = handler
        # if w.init() != 0: return nil

        wv.eval cstring("""
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
        """)

        return wv