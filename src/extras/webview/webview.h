/*
 * MIT License
 *
 * Copyright (c) 2017 Serge Zaitsev
 * Copyright (c) 2022 Steffen André Langnes
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#ifndef WEBVIEW_H
#define WEBVIEW_H

#ifndef WEBVIEW_API
#if defined(WEBVIEW_SHARED) || defined(WEBVIEW_BUILD_SHARED)
#if defined(_WIN32) || defined(__CYGWIN__)
#if defined(WEBVIEW_BUILD_SHARED)
#define WEBVIEW_API __declspec(dllexport)
#else
#define WEBVIEW_API __declspec(dllimport)
#endif
#else
#define WEBVIEW_API __attribute__((visibility("default")))
#endif
#elif !defined(WEBVIEW_STATIC) && defined(__cplusplus)
#define WEBVIEW_API inline
#else
#define WEBVIEW_API extern
#endif
#endif

#ifndef WEBVIEW_VERSION_MAJOR
// The current library major version.
#define WEBVIEW_VERSION_MAJOR 0
#endif

#ifndef WEBVIEW_VERSION_MINOR
// The current library minor version.
#define WEBVIEW_VERSION_MINOR 11
#endif

#ifndef WEBVIEW_VERSION_PATCH
// The current library patch version.
#define WEBVIEW_VERSION_PATCH 0
#endif

#ifndef WEBVIEW_VERSION_PRE_RELEASE
// SemVer 2.0.0 pre-release labels prefixed with "-".
#define WEBVIEW_VERSION_PRE_RELEASE ""
#endif

#ifndef WEBVIEW_VERSION_BUILD_METADATA
// SemVer 2.0.0 build metadata prefixed with "+".
#define WEBVIEW_VERSION_BUILD_METADATA ""
#endif

// Utility macro for stringifying a macro argument.
#define WEBVIEW_STRINGIFY(x) #x

// Utility macro for stringifying the result of a macro argument expansion.
#define WEBVIEW_EXPAND_AND_STRINGIFY(x) WEBVIEW_STRINGIFY(x)

// SemVer 2.0.0 version number in MAJOR.MINOR.PATCH format.
#define WEBVIEW_VERSION_NUMBER                                                 \
  WEBVIEW_EXPAND_AND_STRINGIFY(WEBVIEW_VERSION_MAJOR)                          \
  "." WEBVIEW_EXPAND_AND_STRINGIFY(                                            \
      WEBVIEW_VERSION_MINOR) "." WEBVIEW_EXPAND_AND_STRINGIFY(WEBVIEW_VERSION_PATCH)

// Holds the elements of a MAJOR.MINOR.PATCH version number.
typedef struct {
  // Major version.
  unsigned int major;
  // Minor version.
  unsigned int minor;
  // Patch version.
  unsigned int patch;
} webview_version_t;

// Holds the library's version information.
typedef struct {
  // The elements of the version number.
  webview_version_t version;
  // SemVer 2.0.0 version number in MAJOR.MINOR.PATCH format.
  char version_number[32];
  // SemVer 2.0.0 pre-release labels prefixed with "-" if specified, otherwise
  // an empty string.
  char pre_release[48];
  // SemVer 2.0.0 build metadata prefixed with "+", otherwise an empty string.
  char build_metadata[48];
} webview_version_info_t;

#ifdef __cplusplus
extern "C" {
#endif

typedef void *webview_t;

// Creates a new webview instance. If debug is non-zero - developer tools will
// be enabled (if the platform supports them). The window parameter can be a
// pointer to the native window handle. If it's non-null - then child WebView
// is embedded into the given parent window. Otherwise a new window is created.
// Depending on the platform, a GtkWindow, NSWindow or HWND pointer can be
// passed here. Returns null on failure. Creation can fail for various reasons
// such as when required runtime dependencies are missing or when window creation
// fails.
WEBVIEW_API webview_t webview_create(int debug, void *window);

// Destroys a webview and closes the native window.
WEBVIEW_API void webview_destroy(webview_t w);

// Runs the main loop until it's terminated. After this function exits - you
// must destroy the webview.
WEBVIEW_API void webview_run(webview_t w);

// Stops the main loop. It is safe to call this function from another other
// background thread.
WEBVIEW_API void webview_terminate(webview_t w);

// Posts a function to be executed on the main thread. You normally do not need
// to call this function, unless you want to tweak the native window.
WEBVIEW_API void
webview_dispatch(webview_t w, void (*fn)(webview_t w, void *arg), void *arg);

// Returns a native window handle pointer. When using a GTK backend the pointer
// is a GtkWindow pointer, when using a Cocoa backend the pointer is a NSWindow
// pointer, when using a Win32 backend the pointer is a HWND pointer.
WEBVIEW_API void *webview_get_window(webview_t w);

// Updates the title of the native window. Must be called from the UI thread.
WEBVIEW_API void webview_set_title(webview_t w, const char *title);

// Window size hints
#define WEBVIEW_HINT_NONE 0  // Width and height are default size
#define WEBVIEW_HINT_MIN 1   // Width and height are minimum bounds
#define WEBVIEW_HINT_MAX 2   // Width and height are maximum bounds
#define WEBVIEW_HINT_FIXED 3 // Window size can not be changed by a user
// Updates the size of the native window. See WEBVIEW_HINT constants.
WEBVIEW_API void webview_set_size(webview_t w, int width, int height,
                                  int hints);

// Navigates webview to the given URL. URL may be a properly encoded data URI.
// Examples:
// webview_navigate(w, "https://github.com/webview/webview");
// webview_navigate(w, "data:text/html,%3Ch1%3EHello%3C%2Fh1%3E");
// webview_navigate(w, "data:text/html;base64,PGgxPkhlbGxvPC9oMT4=");
WEBVIEW_API void webview_navigate(webview_t w, const char *url);

// Set webview HTML directly.
// Example: webview_set_html(w, "<h1>Hello</h1>");
WEBVIEW_API void webview_set_html(webview_t w, const char *html);

// Injects JavaScript code at the initialization of the new page. Every time
// the webview will open a new page - this initialization code will be
// executed. It is guaranteed that code is executed before window.onload.
WEBVIEW_API void webview_init(webview_t w, const char *js);

// Evaluates arbitrary JavaScript code. Evaluation happens asynchronously, also
// the result of the expression is ignored. Use RPC bindings if you want to
// receive notifications about the results of the evaluation.
WEBVIEW_API void webview_eval(webview_t w, const char *js);

// Binds a native C callback so that it will appear under the given name as a
// global JavaScript function. Internally it uses webview_init(). The callback
// receives a sequential request id, a request string and a user-provided
// argument pointer. The request string is a JSON array of all the arguments
// passed to the JavaScript function.
WEBVIEW_API void webview_bind(webview_t w, const char *name,
                              void (*fn)(const char *seq, const char *req,
                                         void *arg),
                              void *arg);

// Removes a native C callback that was previously set by webview_bind.
WEBVIEW_API void webview_unbind(webview_t w, const char *name);

// Responds to a binding call from the JS side. The ID/sequence number must
// match the value passed to the binding handler in order to respond to the
// call and complete the promise on the JS side. A status of zero resolves
// the promise, and any other value rejects it. The result must either be a
// valid JSON value or an empty string for the primitive JS value "undefined".
WEBVIEW_API void webview_return(webview_t w, const char *seq, int status,
                                const char *result);

// Get the library's version information.
// @since 0.10
WEBVIEW_API const webview_version_info_t *webview_version(void);

#ifdef __cplusplus
}
#endif

#endif /* WEBVIEW_H */