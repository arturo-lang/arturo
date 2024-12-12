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

//------------------------------
// Menus
//------------------------------

// Forward declarations
struct MenuItem;
struct Menu;

// Callback type for menu actions
typedef void (*MenuActionCallback)(void* userData);

struct MenuItem {
    char* label;                  // Display text
    char* shortcut;              // Optional keyboard shortcut (platform-specific format)
    bool enabled;                // Whether the item is clickable
    bool checked;                // For checkable menu items
    MenuActionCallback action;    // Callback when item is selected
    void* userData;              // User data passed to callback
    struct Menu* submenu;        // Optional submenu (NULL if none)
};

struct Menu {
    char* title;                 // Menu title (shown in menu bar)
    struct MenuItem* items;      // Array of menu items
    size_t itemCount;            // Number of items in menu
};

// Menu management functions
struct Menu* create_menu(const char* title);
void free_menu(struct Menu* menu);

struct MenuItem* add_menu_item(struct Menu* menu, const char* label, MenuActionCallback action);
struct MenuItem* add_menu_separator(struct Menu* menu);
struct MenuItem* add_submenu(struct Menu* menu, const char* label, struct Menu* submenu);

void set_menu_item_enabled(struct MenuItem* item, bool enabled);
void set_menu_item_checked(struct MenuItem* item, bool checked);
void set_menu_item_shortcut(struct MenuItem* item, const char* shortcut);

// Window menu bar functions
void set_window_menu(void* windowHandle, struct Menu** menus, size_t menuCount);
void remove_window_menu(void* windowHandle);

#ifdef __cplusplus
}
#endif

#endif /* WINDOW_H */