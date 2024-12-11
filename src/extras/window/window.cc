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
    #ifdef WIN32_LEAN_AND_MEAN
        #undef WIN32_LEAN_AND_MEAN
    #endif
    #include <windows.h>
    #include <gdiplus.h>
    #pragma comment(lib, "Gdiplus.lib")

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

struct WindowSize get_window_size(void* windowHandle) {
    WindowSize size = {0, 0};
    
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_get_size(GTK_WINDOW((WINDOW_TYPE)windowHandle),
                           &size.width, &size.height);
    #elif defined(__APPLE__)
        long winId = ((long(*)(id, SEL))objc_msgSend)((WINDOW_TYPE)windowHandle, "windowNumber"_sel);
        auto winInfoArray = CGWindowListCopyWindowInfo(kCGWindowListOptionIncludingWindow, winId);
        auto winInfo = CFArrayGetValueAtIndex(winInfoArray, 0);
        auto winBounds = CFDictionaryGetValue((CFDictionaryRef) winInfo, kCGWindowBounds);

        CGRect winPos;
        CGRectMakeWithDictionaryRepresentation((CFDictionaryRef) winBounds, &winPos);
        
        size.width = winPos.size.width;
        size.height = winPos.size.height;
    #elif defined(_WIN32)
        RECT rect;
        GetWindowRect((WINDOW_TYPE)windowHandle, &rect);
        size.width = rect.right - rect.left;
        size.height = rect.bottom - rect.top;
    #endif
    
    return size;
}

void set_window_size(void* windowHandle, struct WindowSize size) {
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_resize(GTK_WINDOW((WINDOW_TYPE)windowHandle), 
                         size.width, size.height);
    #elif defined(__APPLE__)
        NSRect frame = [(WINDOW_TYPE)windowHandle frame];
        frame.size.width = size.width;
        frame.size.height = size.height;
        [(WINDOW_TYPE)windowHandle setFrame:frame display:YES];
    #elif defined(_WIN32)
        SetWindowPos((WINDOW_TYPE)windowHandle, NULL, 0, 0, 
                     size.width, size.height, 
                     SWP_NOMOVE | SWP_NOZORDER);
    #endif
}

bool is_maximized_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        return gtk_window_is_maximized(GTK_WINDOW((WINDOW_TYPE)windowHandle)) == 1;
    #elif defined(__APPLE__)
        return [(WINDOW_TYPE)windowHandle isZoomed];
    #elif defined(_WIN32)
        return IsZoomed((WINDOW_TYPE)windowHandle) == 1;
    #endif
}

void maximize_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_maximize(GTK_WINDOW((WINDOW_TYPE)windowHandle));
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle zoom:nil];
    #elif defined(_WIN32)
        ShowWindow((WINDOW_TYPE)windowHandle, SW_MAXIMIZE);
    #endif
}

void unmaximize_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_unmaximize(GTK_WINDOW((WINDOW_TYPE)windowHandle));
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle zoom:nil];
    #elif defined(_WIN32)
        ShowWindow((WINDOW_TYPE)windowHandle, SW_RESTORE);
    #endif
}

bool is_minimized_window(void* windowHandle) {
    #if defined(__linux__) || defined(__FreeBSD__)
        // GTK doesn't have a direct "is minimized" check
        // We'd need to check the window state
        GdkWindow *gdk_window = gtk_widget_get_window((WINDOW_TYPE)windowHandle);
        GdkWindowState state = gdk_window_get_state(gdk_window);
        return (state & GDK_WINDOW_STATE_ICONIFIED) != 0;
    #elif defined(__APPLE__)
        return [(WINDOW_TYPE)windowHandle isMiniaturized];
    #elif defined(_WIN32)
        return IsIconic((WINDOW_TYPE)windowHandle) == 1;
    #endif
}

void minimize_window(void* windowHandle) {
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_iconify(GTK_WINDOW((WINDOW_TYPE)windowHandle));
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle miniaturize:nil];
    #elif defined(_WIN32)
        ShowWindow((WINDOW_TYPE)windowHandle, SW_MINIMIZE);
    #endif
}

void unminimize_window(void* windowHandle) {
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_deiconify(GTK_WINDOW((WINDOW_TYPE)windowHandle));
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle deminiaturize:nil];
    #elif defined(_WIN32)
        ShowWindow((WINDOW_TYPE)windowHandle, SW_RESTORE);
    #endif
}

bool is_visible_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        return gtk_widget_is_visible((WINDOW_TYPE)windowHandle) == 1;
    #elif defined(__APPLE__)
        return [(WINDOW_TYPE)windowHandle isVisible];
    #elif defined(_WIN32)
        return IsWindowVisible((WINDOW_TYPE)windowHandle) == 1;
    #endif
}

void show_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_widget_show((WINDOW_TYPE)windowHandle);
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle setIsVisible: true];
    #elif defined(_WIN32)
        ShowWindow((WINDOW_TYPE)windowHandle, SW_SHOW);
    #endif
}

void hide_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_widget_hide((WINDOW_TYPE)windowHandle);
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle setIsVisible: false];
    #elif defined(_WIN32)
        ShowWindow((WINDOW_TYPE)windowHandle, SW_HIDE);
    #endif
}

bool is_fullscreen_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        return isFullscreen;
    #elif defined(__APPLE__)
        return ([(WINDOW_TYPE)windowHandle styleMask] & NSWindowStyleMaskFullScreen) == NSWindowStyleMaskFullScreen;
    #elif defined(_WIN32)
        return isFullscreen;
    #endif
}

void fullscreen_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_fullscreen(GTK_WINDOW((WINDOW_TYPE)windowHandle));
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle toggleFullScreen: nil];
    #elif defined(_WIN32)
        previousStyle = GetWindowLong((WINDOW_TYPE)windowHandle, GWL_STYLE);
        previousStyleX = GetWindowLong((WINDOW_TYPE)windowHandle, GWL_EXSTYLE);
        GetWindowRect((WINDOW_TYPE)windowHandle, &previousRect);

        MONITORINFO monitor_info;
        DWORD newStyle = previousStyle & ~(WS_CAPTION | WS_THICKFRAME);
        DWORD newStyleX = previousStyleX & ~(WS_EX_DLGMODALFRAME | WS_EX_WINDOWEDGE |
                            WS_EX_CLIENTEDGE | WS_EX_STATICEDGE);
        SetWindowLong((WINDOW_TYPE)windowHandle, GWL_STYLE, newStyle);
        SetWindowLong((WINDOW_TYPE)windowHandle, GWL_EXSTYLE, newStyleX);
        monitor_info.cbSize = sizeof(monitor_info);
        GetMonitorInfo(MonitorFromWindow((WINDOW_TYPE)windowHandle, MONITOR_DEFAULTTONEAREST),
                    &monitor_info);
        RECT r;
        r.left = monitor_info.rcMonitor.left;
        r.top = monitor_info.rcMonitor.top;
        r.right = monitor_info.rcMonitor.right;
        r.bottom = monitor_info.rcMonitor.bottom;
        SetWindowPos(
            (WINDOW_TYPE)windowHandle, 
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

void unfullscreen_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_unfullscreen(GTK_WINDOW((WINDOW_TYPE)windowHandle));
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle toggleFullScreen: nil];
    #elif defined(_WIN32)
        SetWindowLong((WINDOW_TYPE)windowHandle, GWL_STYLE, previousStyle);
        SetWindowLong((WINDOW_TYPE)windowHandle, GWL_EXSTYLE, previousStyleX);
        SetWindowPos(
            (WINDOW_TYPE)windowHandle, 
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

void set_topmost_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_set_keep_above(GTK_WINDOW((WINDOW_TYPE)windowHandle), true);
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle setLevel: NSFloatingWindowLevel];
    #elif defined(_WIN32)
        SetWindowPos(
            (WINDOW_TYPE)windowHandle,
            HWND_TOPMOST,
            0,
            0,
            0,
            0,
            SWP_NOMOVE | SWP_NOSIZE
        );
    #endif
}

void unset_topmost_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_set_keep_above(GTK_WINDOW((WINDOW_TYPE)windowHandle), false);
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle setLevel: NSNormalWindowLevel];
    #elif defined(_WIN32)
        SetWindowPos(
            (WINDOW_TYPE)windowHandle,
            HWND_NOTOPMOST,
            0,
            0,
            0,
            0,
            SWP_NOMOVE | SWP_NOSIZE
        );
    #endif
}

void focus_window(void* windowHandle) {
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_present(GTK_WINDOW((WINDOW_TYPE)windowHandle));
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle orderFront:nil];
    #elif defined(_WIN32)
        SetForegroundWindow((WINDOW_TYPE)windowHandle);
    #endif
}

void make_borderless_window(void* windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_set_decorated(GTK_WINDOW((WINDOW_TYPE)windowHandle), false);
    #elif defined(__APPLE__)
        [(WINDOW_TYPE)windowHandle setStyleMask: [(WINDOW_TYPE)windowHandle styleMask] & ~NSWindowStyleMaskTitled];
    #elif defined(_WIN32)
        DWORD currentStyle = GetWindowLong((WINDOW_TYPE)windowHandle, GWL_STYLE);
        currentStyle &= ~(WS_CAPTION | WS_THICKFRAME);
        SetWindowLong((WINDOW_TYPE)windowHandle, GWL_STYLE, currentStyle);
        SetWindowPos(
            (WINDOW_TYPE)windowHandle, 
            NULL, 
            0, 
            0, 
            0, 
            0, 
            SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_NOACTIVATE | SWP_FRAMECHANGED
        );
    #endif
}

#ifndef WIN32_LEAN_AND_MEAN
    #define WIN32_LEAN_AND_MEAN 1
#endif