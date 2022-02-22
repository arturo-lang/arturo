// Roughly based-on/inspired-by:
// https://github.com/neutralinojs/neutralinojs/blob/main/api/window/window.cpp

#if defined(__linux__) || defined(__FreeBSD__)
    #include <gtk/gtk.h>
    #include <glib.h>
    #include <gdk-pixbuf/gdk-pixbuf.h>
    
    #define WINDOW_TYPE GtkWidget*

#elif defined(__APPLE__)
    #include <objc/objc-runtime.h>
    #include <AppKit/AppKit.h>
    
    #define NSBaseWindowLevel 0
    #define NSFloatingWindowLevel 5
    #define NSWindowStyleMaskFullScreen 16384

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

void make_borderless_window(WINDOW_TYPE windowHandle);