// Roughly based-on/inspired-by:
// https://github.com/neutralinojs/neutralinojs/blob/main/api/window/window.cpp

#ifndef __WINDOW_H
#define __WINDOW_H

#ifdef __cplusplus
extern "C" {
#endif


#include <stdbool.h>

#if defined(__linux__) || defined(__FreeBSD__)
    #include <gtk/gtk.h>
    #include <glib.h>
    #include <gdk-pixbuf/gdk-pixbuf.h>
    
    #define WINDOW_TYPE GtkWidget*

#elif defined(__APPLE__)
    #include <objc/objc-runtime.h>

    #define WINDOW_TYPE id

#elif defined(_WIN32)
    #define _WINSOCKAPI_
    #include <windows.h>
    #include <gdiplus.h>
    #pragma comment (lib,"Gdiplus.lib")
    #pragma comment(lib, "WebView2Loader.dll.lib")

    #define WINDOW_TYPE HWND

#endif

bool is_maximized_window(WINDOW_TYPE windowHandle);
void maximize_window(WINDOW_TYPE windowHandle);
void unmaximize_window(WINDOW_TYPE windowHandle);

bool is_visible_window(WINDOW_TYPE windowHandle);
void show_window(WINDOW_TYPE windowHandle);
void hide_window(WINDOW_TYPE windowHandle);

bool is_fullscreen_window(WINDOW_TYPE windowHandle);
void fullscreen_window(WINDOW_TYPE windowHandle);
void unfullscreen_window(WINDOW_TYPE windowHandle);

void set_topmost_window(WINDOW_TYPE windowHandle);
void unset_topmost_window(WINDOW_TYPE windowHandle);

void make_borderless_window(WINDOW_TYPE windowHandle);

#ifdef __cplusplus
}
#endif

#endif /* WINDOW_H */