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
// Helpers to avoid too much typing with the Objective C runtime
inline SEL operator"" _sel(const char *s, size_t) { 
    return sel_registerName(s); 
}
#endif

bool isFullscreen = false;

#if defined(_WIN32)
    DWORD previousStyle;
    DWORD previousStyleX;
    RECT previousRect;
#endif

#if defined(__linux__) || defined(__FreeBSD__)
#include <map>

static std::map<GtkWidget*, struct WindowSize> minSizes;
static std::map<GtkWidget*, struct WindowSize> maxSizes;
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

struct WindowSize get_window_min_size(void* windowHandle) {
    struct WindowSize size = {0, 0};
    
    #if defined(__linux__) || defined(__FreeBSD__)
        auto it = minSizes.find((GtkWidget*)windowHandle);
        if (it != minSizes.end()) {
            size = it->second;
        }
    #elif defined(__APPLE__)
        NSSize minSize = [(WINDOW_TYPE)windowHandle minSize];
        size.width = minSize.width;
        size.height = minSize.height;
    #elif defined(_WIN32)
        WindowSize* storedSize = (WindowSize*)GetWindowLongPtr((WINDOW_TYPE)windowHandle, GWLP_USERDATA);
        if (storedSize) {
            size = *storedSize;
        }
    #endif
    
    return size;
}

void set_window_min_size(void* windowHandle, struct WindowSize size) {
    #if defined(__linux__) || defined(__FreeBSD__)
        GdkGeometry hints;
        hints.min_width = size.width;
        hints.min_height = size.height;
        gtk_window_set_geometry_hints(GTK_WINDOW((WINDOW_TYPE)windowHandle),
                                    NULL,
                                    &hints,
                                    GDK_HINT_MIN_SIZE);
        minSizes[(GtkWidget*)windowHandle] = size;  // Store the value
    #elif defined(__APPLE__)
        NSSize minSize = NSMakeSize(size.width, size.height);
        [(WINDOW_TYPE)windowHandle setMinSize:minSize];
    #elif defined(_WIN32)
        RECT rect;
        GetWindowRect((WINDOW_TYPE)windowHandle, &rect);
        SetWindowPos((WINDOW_TYPE)windowHandle, 
                    NULL,
                    rect.left, rect.top,
                    std::max(size.width, rect.right - rect.left),
                    std::max(size.height, rect.bottom - rect.top),
                    SWP_NOMOVE | SWP_NOZORDER);
        SetWindowLongPtr((WINDOW_TYPE)windowHandle, 
                        GWLP_USERDATA, 
                        (LONG_PTR)&size);
    #endif
}

struct WindowSize get_window_max_size(void* windowHandle) {
    struct WindowSize size = {0, 0};
    
    #if defined(__linux__) || defined(__FreeBSD__)
        auto it = maxSizes.find((GtkWidget*)windowHandle);
        if (it != maxSizes.end()) {
            size = it->second;
        }
    #elif defined(__APPLE__)
        NSSize maxSize = [(WINDOW_TYPE)windowHandle maxSize];
        size.width = maxSize.width;
        size.height = maxSize.height;
    #elif defined(_WIN32)
        // Windows doesn't store max size directly, would need additional storage mechanism
        // Returns 0,0 for now
    #endif
    
    return size;
}

void set_window_max_size(void* windowHandle, struct WindowSize size) {
    #if defined(__linux__) || defined(__FreeBSD__)
        GdkGeometry hints;
        hints.max_width = size.width;
        hints.max_height = size.height;
        gtk_window_set_geometry_hints(GTK_WINDOW((WINDOW_TYPE)windowHandle),
                                    NULL,
                                    &hints,
                                    GDK_HINT_MAX_SIZE);
        maxSizes[(GtkWidget*)windowHandle] = size;  // Store the value
    #elif defined(__APPLE__)
        NSSize maxSize = NSMakeSize(size.width, size.height);
        [(WINDOW_TYPE)windowHandle setMaxSize:maxSize];
    #elif defined(_WIN32)
        RECT rect;
        GetWindowRect((WINDOW_TYPE)windowHandle, &rect);
        SetWindowPos((WINDOW_TYPE)windowHandle, 
                    NULL,
                    rect.left, rect.top,
                    min(size.width, rect.right - rect.left),
                    min(size.height, rect.bottom - rect.top),
                    SWP_NOMOVE | SWP_NOZORDER);
    #endif
}

struct WindowPosition get_window_position(void* windowHandle) {
    struct WindowPosition pos = {0, 0};
    
    #if defined(__linux__) || defined(__FreeBSD__)
        gdk_window_get_root_origin(gtk_widget_get_window((WINDOW_TYPE)windowHandle), 
                                  &pos.x, &pos.y);
    #elif defined(__APPLE__)
        long winId = ((long(*)(id, SEL))objc_msgSend)((WINDOW_TYPE)windowHandle, "windowNumber"_sel);
        auto winInfoArray = CGWindowListCopyWindowInfo(kCGWindowListOptionIncludingWindow, winId);
        auto winInfo = CFArrayGetValueAtIndex(winInfoArray, 0);
        auto winBounds = CFDictionaryGetValue((CFDictionaryRef) winInfo, kCGWindowBounds);

        CGRect winPos;
        CGRectMakeWithDictionaryRepresentation((CFDictionaryRef) winBounds, &winPos);
        
        pos.x = winPos.origin.x;
        pos.y = winPos.origin.y;
    #elif defined(_WIN32)
        RECT rect;
        GetWindowRect((WINDOW_TYPE)windowHandle, &rect);
        pos.x = rect.left;
        pos.y = rect.top;
    #endif
    
    return pos;
}

void set_window_position(void* windowHandle, struct WindowPosition position) {
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_move(GTK_WINDOW((WINDOW_TYPE)windowHandle), 
                       position.x, position.y);
    #elif defined(__APPLE__)
        auto displayId = CGMainDisplayID();
        int height = CGDisplayPixelsHigh(displayId);
        ((void (*)(id, SEL, CGPoint))objc_msgSend)(
            (WINDOW_TYPE)windowHandle, "setFrameTopLeftPoint:"_sel,
            CGPointMake(position.x, height - position.y));
    #elif defined(_WIN32)
        RECT rect;
        GetWindowRect((WINDOW_TYPE)windowHandle, &rect);
        MoveWindow((WINDOW_TYPE)windowHandle, 
                   position.x, position.y,
                   rect.right - rect.left,
                   rect.bottom - rect.top, 
                   TRUE);
    #endif
}

void center_window(void* windowHandle) {
    struct WindowSize windowSize = get_window_size(windowHandle);
    struct WindowPosition centerPos = {0, 0};
    
    #if defined(__linux__) || defined(__FreeBSD__)
        GdkRectangle workArea;
        gdk_monitor_get_workarea(
            gdk_display_get_primary_monitor(gdk_display_get_default()),
            &workArea);
        centerPos.x = (workArea.width - windowSize.width) / 2;
        centerPos.y = (workArea.height - windowSize.height) / 2;
    #elif defined(__APPLE__)
        auto displayId = CGMainDisplayID();
        centerPos.x = (CGDisplayPixelsWide(displayId) - windowSize.width) / 2;
        centerPos.y = (CGDisplayPixelsHigh(displayId) - windowSize.height) / 2;
    #elif defined(_WIN32)
        RECT screen;
        GetWindowRect(GetDesktopWindow(), &screen);
        centerPos.x = ((screen.right - screen.left) - windowSize.width) / 2;
        centerPos.y = ((screen.bottom - screen.top) - windowSize.height) / 2;
    #endif

    set_window_position(windowHandle, centerPos);
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