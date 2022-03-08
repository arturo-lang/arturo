// Roughly based-on/inspired-by:
// https://github.com/neutralinojs/neutralinojs/blob/main/api/window/window.cpp

#ifndef __WINDOW_H
#define __WINDOW_H

#include <stdbool.h>

// #if defined(__linux__) || defined(__FreeBSD__)
//     #include <gtk/gtk.h>

//     #define WINDOW_TYPE GtkWidget*

// #elif defined(__APPLE__)
//     #include <objc/objc-runtime.h>

//     #define WINDOW_TYPE id

// #elif defined(_WIN32)
//     #define _WINSOCKAPI_
//     #include <windows.h>

//     #define WINDOW_TYPE HWND
// #endif

#ifdef __cplusplus
extern "C" {
#endif

bool is_maximized_window(void* windowHandle);
void maximize_window(void* windowHandle);
void unmaximize_window(void* windowHandle);

bool is_visible_window(void* windowHandle);
void show_window(void* windowHandle);
void hide_window(void* windowHandle);

bool is_fullscreen_window(void* windowHandle);
void fullscreen_window(void* windowHandle);
void unfullscreen_window(void* windowHandle);

void set_topmost_window(void* windowHandle);
void unset_topmost_window(void* windowHandle);

void make_borderless_window(void* windowHandle);

#ifdef __cplusplus
}
#endif

#endif /* WINDOW_H */