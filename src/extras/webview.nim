######################################################
# nim-webview
# New-style Zaitsev's webview wrapper
# for Nim
#
# (c) 2022 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/webview.nim
######################################################

#=======================================
# Libraries
#=======================================

import os

import extras/window

#=======================================
# Compilation & Linking
#=======================================

{.passC: "-I" & parentDir(currentSourcePath()) .}

when defined(linux):
    {.compile("webview/webview_unix.cc","-std=c++11").}
    {.passC: "-DWEBVIEW_GTK=1 " &
             staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0".}
    {.passL: "-lstdc++ " &
             staticExec"pkg-config --libs gtk+-3.0 webkit2gtk-4.0".}
elif defined(freebsd):
    {.compile("webview/webview_unix.cc","-std=c++11").}
    {.passC: "-DWEBVIEW_GTK=1 " &
             staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
    {.passL: "-lstdc++ " &
             staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
elif defined(macosx):
    {.compile("webview/webview_unix.cc","-std=c++11").}
    {.passC: "-DWEBVIEW_COCOA=1".}
    {.passL: "-lstdc++ -framework WebKit".}
elif defined(windows):
    {.passC: "-DWEBVIEW_EDGE=1 -mwindows".}
    {.passL: """-static-libstdc++ -std=c++17 -L""" & currentSourcePath().splitPath.head & """/webview/deps/dlls/x64 -lwebview -lWebView2Loader""".}

{.push header: "webview/webview_unix.h", cdecl.}

#=======================================
# Types
#=======================================

type
    Constraints* = enum
        Default = 0
        Minimum = 1
        Maximum = 2
        Fixed = 3
    
    ccstring* {.importc:"const char*".} = cstring

type
    Webview* {.importc: "webview_t".} = pointer
    WebviewCallback* = proc (seq: ccstring, req: ccstring, arg: pointer) {.cdecl.}
    WebviewDispatch* = proc (w: Webview, arg: pointer) {.cdecl.}

#=======================================
# Function prototypes
#=======================================

proc webview_create*(debug: cint = 0, window: pointer = nil): Webview {.importc.}
    ## Creates a new webview instance. If debug is non-zero - developer tools will
    ## be enabled (if the platform supports them). Window parameter can be a
    ## pointer to the native window handle. If it's non-null - then child WebView
    ## is embedded into the given parent window. Otherwise a new window is created.
    ## Depending on the platform, a GtkWindow, NSWindow or HWND pointer can be
    ## passed here.

proc webview_destroy*(w: Webview) {.importc.}
    ## Destroys a webview and closes the native window.

proc webview_run*(w: Webview) {.importc.}
    ## Runs the main loop until it's terminated. After this function exits - you
    ## must destroy the webview.

proc webview_terminate*(w: Webview) {.importc.}
    ## Stops the main loop. It is safe to call this function from another other
    ## background thread.

proc webview_dispatch(w: Webview, fn: WebviewDispatch, arg: pointer) {.importc, used.}
    ## Posts a function to be executed on the main thread. You normally do not need
    ## to call this function, unless you want to tweak the native window.

proc webview_get_window*(w: Webview): Window {.importc.}
    ## Returns a native window handle pointer. When using GTK backend the pointer
    ## is GtkWindow pointer, when using Cocoa backend the pointer is NSWindow
    ## pointer, when using Win32 backend the pointer is HWND pointer.

proc webview_set_title*(w: Webview, title: cstring) {.importc.}
    ## Updates the title of the native window. Must be called from the UI thread.

proc webview_set_size*(w: Webview, width: cint, height: cint, constraints: Constraints) {.importc.}
    ## Updates native window size. See WEBVIEW_HINT constants.

proc webview_navigate*(w: Webview, url: cstring) {.importc.}
    ## Navigates webview to the given URL. URL may be a data URI, i.e.
    ## "data:text/html,<html>...</html>". It is often ok not to url-encode it
    ## properly, webview will re-encode it for you.

proc webview_init*(w: Webview, js: cstring) {.importc.}
    ## Injects JavaScript code at the initialization of the new page. Every time
    ## the webview will open a the new page - this initialization code will be
    ## executed. It is guaranteed that code is executed before window.onload.

proc webview_eval*(w: Webview, js: cstring) {.importc.}
    ## Evaluates arbitrary JavaScript code. Evaluation happens asynchronously, also
    ## the result of the expression is ignored. Use RPC bindings if you want to
    ## receive notifications about the results of the evaluation.

proc webview_bind*(w: Webview, name: cstring, cb: WebviewCallback, arg: pointer) {.importc.}
    ## Binds a native C callback so that it will appear under the given name as a
    ## global JavaScript function. Internally it uses webview_init(). Callback
    ## receives a request string and a user-provided argument pointer. Request
    ## string is a JSON array of all the arguments passed to the JavaScript
    ## function.

proc webview_return*(w: Webview; seq: cstring; status: cint; result: cstring)
    ## Allows to return a value from the native binding. Original request pointer
    ## must be provided to help internal RPC engine match requests with responses.
    ## If status is zero - result is expected to be a valid JSON result value.
    ## If status is not zero - result is an error JSON object.

{.pop.}