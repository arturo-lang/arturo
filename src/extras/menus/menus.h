//=======================================================
// Arturo
// Programming Language + Bytecode VM compiler
// (c) 2019-2024 Yanis Zafirópulos
//
// @file: extras/window/window.h
//=======================================================

#ifndef __WINDOW_H
#define __WINDOW_H

#include <stdbool.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

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