//=======================================================
// Arturo
// Programming Language + Bytecode VM compiler
// (c) 2019-2024 Yanis Zafirópulos
//
// @file: extras/window/window.h
//=======================================================

// Initially based-on/inspired-by:
// https://github.com/neutralinojs/neutralinojs/blob/main/api/window/window.cpp
// MIT License
// Copyright (c) 2021 Neutralinojs and contributors.

#ifndef __WINDOW_H
#define __WINDOW_H

#include <stdbool.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

struct WindowSize {
    int width;
    int height;
};

struct WindowPosition {
    int x;
    int y;
};

struct WindowSize get_window_size(void* windowHandle);
void set_window_size(void* windowHandle, struct WindowSize size);

struct WindowSize get_window_min_size(void* windowHandle);
void set_window_min_size(void* windowHandle, struct WindowSize size);

struct WindowSize get_window_max_size(void* windowHandle);
void set_window_max_size(void* windowHandle, struct WindowSize size);

struct WindowPosition get_window_position(void* windowHandle);
void set_window_position(void* windowHandle, struct WindowPosition position);

void center_window(void* windowHandle);

bool is_maximized_window(void* windowHandle);
void maximize_window(void* windowHandle);
void unmaximize_window(void* windowHandle);

bool is_minimized_window(void* windowHandle);
void minimize_window(void* windowHandle);
void unminimize_window(void* windowHandle);

bool is_visible_window(void* windowHandle);
void show_window(void* windowHandle);
void hide_window(void* windowHandle);

bool is_fullscreen_window(void* windowHandle);
void fullscreen_window(void* windowHandle);
void unfullscreen_window(void* windowHandle);

void set_topmost_window(void* windowHandle);
void unset_topmost_window(void* windowHandle);

void set_focused_window(void* windowHandle, bool focused);
bool is_focused_window(void* windowHandle);

void make_borderless_window(void* windowHandle);

void set_closable_window(void* windowHandle, bool closable);
bool is_closable_window(void* windowHandle);

void set_maximizable_window(void* windowHandle, bool maximizable);
bool is_maximizable_window(void* windowHandle);

void set_minimizable_window(void* windowHandle, bool minimizable);
bool is_minimizable_window(void* windowHandle);

#ifdef __cplusplus
}
#endif

#endif /* WINDOW_H */