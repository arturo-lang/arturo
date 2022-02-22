#if defined(__linux__) || defined(__FreeBSD__)
    #include <gtk/gtk.h>
    #include <glib.h>
    #include <gdk-pixbuf/gdk-pixbuf.h>
    
    #define WINDOW_TYPE GtkWidget*

#elif defined(__APPLE__)
    #include <objc/objc-runtime.h>
    #include <CoreFoundation/Corefoundation.h> 
    #include <CoreGraphics/CGDisplayConfiguration.h>
    #include <CoreGraphics/CGWindow.h>
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

void maximizeWindow(WINDOW_TYPE windowHandle);