#include "window.h"

void maximizeWindow(WINDOW_TYPE windowHandle){
    #if defined(__linux__) || defined(__FreeBSD__)
        gtk_window_maximize(GTK_WINDOW(windowHandle));
    #elif defined(_WIN32)
        ShowWindow(windowHandle, SW_MAXIMIZE);
    #elif defined(__APPLE__)
        [windowHandle zoom:nil];
    #endif
}