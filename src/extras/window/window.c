// Roughly based-on/inspired-by:
// https://github.com/neutralinojs/neutralinojs/blob/main/api/window/window.cpp

#include "window.h"

#if defined(__linux__) || defined(__FreeBSD__)
    #include <gtk/gtk.h>
    #include <glib.h>
    #include <gdk-pixbuf/gdk-pixbuf.h>
    
    #define WINDOW_TYPE GtkWidget*

#elif defined(__APPLE__)
    #include <objc/objc-runtime.h>
    #include <AppKit/AppKit.h>

    #define WINDOW_TYPE id

#elif defined(_WIN32)
    #define _WINSOCKAPI_
    #include <windows.h>
    #include <gdiplus.h>
    #pragma comment (lib,"Gdiplus.lib")
    #pragma comment(lib, "WebView2Loader.dll.lib")

    #define WINDOW_TYPE HWND

#endif

#if defined(__APPLE__)
    
#endif

bool isFullscreen = false;

#if defined(_WIN32)
    DWORD previousStyle;
    DWORD previousStyleX;
    RECT previousRect;
#endif

bool is_maximized_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        return gtk_window_is_maximized(GTK_WINDOW(windowHandle)) == 1;
    #elif defined(__APPLE__)
        return [windowHandle isZoomed];
    #elif defined(_WIN32)
        return IsZoomed(windowHandle) == 1;
    #endif
}

void maximize_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_maximize(GTK_WINDOW(windowHandle));
    #elif defined(__APPLE__)
        [windowHandle zoom:nil];
    #elif defined(_WIN32)
        ShowWindow(windowHandle, SW_MAXIMIZE);
    #endif
}

void unmaximize_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_unmaximize(GTK_WINDOW(windowHandle));
    #elif defined(__APPLE__)
        [windowHandle zoom:nil];
    #elif defined(_WIN32)
        ShowWindow(windowHandle, SW_RESTORE);
    #endif
}

bool is_visible_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        return gtk_widget_is_visible(windowHandle) == 1;
    #elif defined(__APPLE__)
        return [windowHandle isVisible];
    #elif defined(_WIN32)
        return IsWindowVisible(windowHandle) == 1;
    #endif
}

void show_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_widget_show(windowHandle);
    #elif defined(__APPLE__)
        [windowHandle setIsVisible: true];
    #elif defined(_WIN32)
        ShowWindow(windowHandle, SW_SHOW);
    #endif
}

void hide_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_widget_hide(windowHandle);
    #elif defined(__APPLE__)
        [windowHandle setIsVisible: false];
    #elif defined(_WIN32)
        ShowWindow(windowHandle, SW_HIDE);
    #endif
}

bool is_fullscreen_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        return isFullscreen;
    #elif defined(__APPLE__)
        return ([windowHandle styleMask] & NSWindowStyleMaskFullScreen) == NSWindowStyleMaskFullScreen;
    #elif defined(_WIN32)
        return isFullscreen;
    #endif
}

void fullscreen_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_fullscreen(GTK_WINDOW(windowHandle));
    #elif defined(__APPLE__)
        [windowHandle toggleFullScreen: nil];
    #elif defined(_WIN32)
        previousStyle = GetWindowLong(windowHandle, GWL_STYLE);
        previousStyleX = GetWindowLong(windowHandle, GWL_EXSTYLE);
        GetWindowRect(windowHandle, &previousRect);

        MONITORINFO monitor_info;
        DWORD newStyle = previousStyle & ~(WS_CAPTION | WS_THICKFRAME);
        DWORD newStyleX = previousStyleX & ~(WS_EX_DLGMODALFRAME | WS_EX_WINDOWEDGE |
                            WS_EX_CLIENTEDGE | WS_EX_STATICEDGE);
        SetWindowLong(windowHandle, GWL_STYLE, newStyle);
        SetWindowLong(windowHandle, GWL_EXSTYLE, newStyleX);
        monitor_info.cbSize = sizeof(monitor_info);
        GetMonitorInfo(MonitorFromWindow(windowHandle, MONITOR_DEFAULTTONEAREST),
                    &monitor_info);
        RECT r;
        r.left = monitor_info.rcMonitor.left;
        r.top = monitor_info.rcMonitor.top;
        r.right = monitor_info.rcMonitor.right;
        r.bottom = monitor_info.rcMonitor.bottom;
        SetWindowPos(
            windowHandle, 
            NULL, 
            r.left, 
            r.top, 
            r.right - r.left,
            r.bottom - r.top,
            SWP_NOZORDER | SWP_NOACTIVATE | SWP_FRAMECHANGED
        );
        
        isFullscreen = true;
    #endif
}

void unfullscreen_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_unfullscreen(GTK_WINDOW(windowHandle));
    #elif defined(__APPLE__)
        [windowHandle toggleFullScreen: nil];
    #elif defined(_WIN32)
        SetWindowLong(windowHandle, GWL_STYLE, previousStyle);
        SetWindowLong(windowHandle, GWL_EXSTYLE, previousStyleX);
        SetWindowPos(
            windowHandle, 
            NULL, 
            previousRect.left, 
            previousRect.top, 
            previousRect.right - previousRect.left,
            previousRect.bottom - previousRect.top,
            SWP_NOZORDER | SWP_NOACTIVATE | SWP_FRAMECHANGED
        );
        
        isFullscreen = false;
    #endif
}

void set_topmost_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_set_keep_above(GTK_WINDOW(windowHandle), true);
    #elif defined(__APPLE__)
        [windowHandle setLevel: NSFloatingWindowLevel];
    #elif defined(_WIN32)
        SetWindowPos(
            windowHandle,
            HWND_TOPMOST,
            0,
            0,
            0,
            0,
            SWP_NOMOVE | SWP_NOSIZE
        )
    #endif
}

void unset_topmost_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_set_keep_above(GTK_WINDOW(windowHandle), false);
    #elif defined(__APPLE__)
        [windowHandle setLevel: NSNormalWindowLevel];
    #elif defined(_WIN32)
        SetWindowPos(
            windowHandle,
            HWND_NOTOPMOST,
            0,
            0,
            0,
            0,
            SWP_NOMOVE | SWP_NOSIZE
        )
    #endif
}

void make_borderless_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_set_decorated(GTK_WINDOW(windowHandle), false);
    #elif defined(__APPLE__)
        [windowHandle setStyleMask: [windowHandle styleMask] & ~NSWindowStyleMaskTitled];
    #elif defined(_WIN32)
        DWORD currentStyle = GetWindowLong(windowHandle, GWL_STYLE);
        currentStyle &= ~(WS_CAPTION | WS_THICKFRAME);
        SetWindowLong(windowHandle, GWL_STYLE, currentStyle);
        SetWindowPos(
            windowHandle, 
            NULL, 
            0, 
            0, 
            0, 
            0, 
            SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_NOACTIVATE | SWP_FRAMECHANGED
        );
    #endif
}