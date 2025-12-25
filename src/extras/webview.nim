#=======================================================
# nim-webview
# New-style Zaitsev's webview wrapper
# for Nim
#
# (c) 2019-2026 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/webview.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os

import extras/window

#=======================================
# Compilation & Linking
#=======================================

{.passC: "-I" & parentDir(currentSourcePath()) .}

when defined(linux) or defined(freebsd):
    const
        webkitVersion {.strdefine.} = "empty"
    {.compile("webview/webview-unix.cc","-std=c++11").}
    {.passC: "-DWEBVIEW_GTK=1 -DWEBVIEW_STATIC=1 " &
             staticExec("pkg-config --cflags gtk+-3.0 webkit2gtk-" & webkitVersion) .}
    {.passL: "-lstdc++ " &
             staticExec("pkg-config --libs gtk+-3.0 webkit2gtk-" & webkitVersion) .}
elif defined(macosx):
    {.compile("webview/webview-unix.cc","-std=c++11").}
    {.passC: "-DWEBVIEW_COCOA=1 -DWEBVIEW_STATIC=1".}
    {.passL: "-lstdc++ -framework WebKit".}
elif defined(windows):
    {.passC: "-DWEBVIEW_EDGE=1 -mwindows".}
    {.passL: """-static-libstdc++ -std=c++17 -L""" & currentSourcePath().splitPath.head & """/webview/deps/dlls/x64 -lwebview -lWebView2Loader""".}

{.push header: "webview/webview.h", cdecl.}

#=======================================
# Types
#=======================================

type
    Constraints* = enum
        Default = 0
        Minimum = 1
        Maximum = 2
        Fixed = 3

    NativeHandle* = enum
        Window = 0
        Widget = 1
        BrowserController = 2

    WebviewError* = enum
        MissingDependency   = -5
        Canceled            = -4
        InvalidState        = -3
        InvalidArgument     = -2
        Unspecified         = -1
        OK                  = 0
        Duplicate           = 1
        NotFound            = 2
    
    ccstring* {.importc:"const char*".} = cstring

type
    Webview* {.importc: "webview_t".} = pointer
    WebviewCallback* = proc (seq: ccstring, req: ccstring, arg: pointer) {.cdecl.}
    WebviewDispatch* = proc (w: Webview, arg: pointer) {.cdecl.}

#=======================================
# Function prototypes
#=======================================

proc webview_create*(debug: cint = 0, window: pointer = nil): Webview {.importc.}
    ## Creates a new webview instance.
    ##
    ## @param debug Enable developer tools if supported by the backend.
    ## @param window Optional native window handle, i.e. @c GtkWindow pointer
    ##        @c NSWindow pointer (Cocoa) or @c HWND (Win32). If non-null,
    ##        the webview widget is embedded into the given window, and the
    ##        caller is expected to assume responsibility for the window as
    ##        well as application lifecycle. If the window handle is null,
    ##        a new window is created and both the window and application
    ##        lifecycle are managed by the webview instance.
    ## @remark Win32: The function also accepts a pointer to @c HWND (Win32) in the
    ##         window parameter for backward compatibility.
    ## @remark Win32/WebView2: @c CoInitializeEx should be called with
    ##         @c COINIT_APARTMENTTHREADED before attempting to call this function
    ##         with an existing window. Omitting this step may cause WebView2
    ##         initialization to fail.
    ## @return @c NULL on failure. Creation can fail for various reasons such
    ##         as when required runtime dependencies are missing or when window
    ##         creation fails.
    ## @retval WEBVIEW_ERROR_MISSING_DEPENDENCY
    ##         May be returned if WebView2 is unavailable on Windows.

proc webview_destroy*(w: Webview): WebviewError {.importc.}
    ## Destroys a webview instance and closes the native window.
    ##
    ## @param w The webview instance.

proc webview_run*(w: Webview): WebviewError {.importc.}
    ## Runs the main loop until it's terminated.
    ##
    ## @param w The webview instance.

proc webview_terminate*(w: Webview): WebviewError {.importc.}
    ## Stops the main loop. It is safe to call this function from another other
    ## background thread.
    ##
    ## @param w The webview instance.

proc webview_dispatch(w: Webview, fn: WebviewDispatch, arg: pointer): WebviewError {.importc, used.}
    ## Schedules a function to be invoked on the thread with the run/event loop.
    ## Use this function e.g. to interact with the library or native handles.
    ##
    ## @param w The webview instance.
    ## @param fn The function to be invoked.
    ## @param arg An optional argument passed along to the callback function.

proc webview_get_window*(w: Webview): Window {.importc.}
    ## Returns the native handle of the window associated with the webview instance.
    ## The handle can be a @c GtkWindow pointer (GTK), @c NSWindow pointer (Cocoa)
    ## or @c HWND (Win32).
    ##
    ## @param w The webview instance.
    ## @return The handle of the native window.

proc webview_get_native_handle*(w: Webview, handle: NativeHandle): pointer {.importc.}
    ## Get a native handle of choice.
    ##
    ## @param w The webview instance.
    ## @param kind The kind of handle to retrieve.
    ## @return The native handle or @c NULL.
    ## @since 0.11

proc webview_set_title*(w: Webview, title: cstring): WebviewError {.importc.}
    ## Updates the title of the native window.
    ##
    ## @param w The webview instance.
    ## @param title The new title.

proc webview_set_size*(w: Webview, width: cint, height: cint, constraints: Constraints): WebviewError {.importc.}
    ## Updates the size of the native window.
    ##
    ## Remarks:
    ## - Using WEBVIEW_HINT_MAX for setting the maximum window size is not
    ##   supported with GTK 4 because X11-specific functions such as
    ##   gtk_window_set_geometry_hints were removed. This option has no effect
    ##   when using GTK 4.
    ##
    ## @param w The webview instance.
    ## @param width New width.
    ## @param height New height.
    ## @param hints Size hints.

proc webview_navigate*(w: Webview, url: cstring): WebviewError {.importc.}
    ## Navigates webview to the given URL. URL may be a properly encoded data URI.
    ##
    ## Example:
    ## @code{.c}
    ## webview_navigate(w, "https://github.com/webview/webview");
    ## webview_navigate(w, "data:text/html,%3Ch1%3EHello%3C%2Fh1%3E");
    ## webview_navigate(w, "data:text/html;base64,PGgxPkhlbGxvPC9oMT4=");
    ## @endcode
    ##
    ## @param w The webview instance.
    ## @param url URL.
    
proc webview_set_html*(w: Webview, html: cstring): WebviewError {.importc.}
    ## Load HTML content into the webview.
    ##
    ## Example:
    ## @code{.c}
    ## webview_set_html(w, "<h1>Hello</h1>");
    ## @endcode
    ##
    ## @param w The webview instance.
    ## @param html HTML content.

proc webview_init*(w: Webview, js: cstring): WebviewError {.importc.}
    ## Injects JavaScript code to be executed immediately upon loading a page.
    ## The code will be executed before @c window.onload.
    ##
    ## @param w The webview instance.
    ## @param js JS content.

proc webview_eval*(w: Webview, js: cstring): WebviewError {.importc.}
    ## Evaluates arbitrary JavaScript code.
    ##
    ## Use bindings if you need to communicate the result of the evaluation.
    ##
    ## @param w The webview instance.
    ## @param js JS content.

proc webview_bind*(w: Webview, name: cstring, cb: WebviewCallback, arg: pointer): WebviewError {.importc.}
    ## Binds a function pointer to a new global JavaScript function.
    ##
    ## Internally, JS glue code is injected to create the JS function by the
    ## given name. The callback function is passed a request identifier,
    ## a request string and a user-provided argument. The request string is
    ## a JSON array of the arguments passed to the JS function.
    ##
    ## @param w The webview instance.
    ## @param name Name of the JS function.
    ## @param fn Callback function.
    ## @param arg User argument.
    ## @retval WEBVIEW_ERROR_DUPLICATE
    ##         A binding already exists with the specified name.

proc webview_unbind*(w: Webview, name: cstring): WebviewError {.importc.}
    ## Removes a binding created with webview_bind().
    ##
    ## @param w The webview instance.
    ## @param name Name of the binding.
    ## @retval WEBVIEW_ERROR_NOT_FOUND No binding exists with the specified name.

proc webview_return*(w: Webview; seq: cstring; status: cint; result: cstring): WebviewError
    ## Responds to a binding call from the JS side.
    ##
    ## @param w The webview instance.
    ## @param id The identifier of the binding call. Pass along the value received
    ##           in the binding handler (see webview_bind()).
    ## @param status A status of zero tells the JS side that the binding call was
    ##               succesful; any other value indicates an error.
    ## @param result The result of the binding call to be returned to the JS side.
    ##               This must either be a valid JSON value or an empty string for
    ##               the primitive JS value @c undefined.

{.pop.}