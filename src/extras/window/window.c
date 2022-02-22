// Roughly based-on/inspired-by:
// https://github.com/neutralinojs/neutralinojs/blob/main/api/window/window.cpp

#include "window.h"

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

void make_borderless_window(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_set_decorated(GTK_WINDOW(windowHandle), false);
    #elif defined(__APPLE__)
        [windowHandle setStyleMask: [windowHandle styleMask] & ~NSWindowStyleMaskTitled];
    #elif defined(_WIN32)
        DWORD currentStyle = GetWindowLong(windowHandle, GWL_STYLE);
        currentStyle &= ~(WS_CAPTION | WS_THICKFRAME);
        SetWindowLong(windowHandle, GWL_STYLE, currentStyle);
        SetWindowPos(windowHandle, NULL, 0, 0, 0, 0, 
            SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_NOACTIVATE | SWP_FRAMECHANGED);
    #endif
}