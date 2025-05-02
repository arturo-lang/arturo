//=======================================================
// Arturo
// Programming Language + Bytecode VM compiler
// (c) 2019-2024 Yanis Zafirópulos
//
// @file: extras/menus/menus.h
//=======================================================

#ifndef __MENUS_H
#define __MENUS_H

#include <stdbool.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

// Forward declarations
struct MenuItemObj;
struct MenuObj;

// Callback type for menu actions
typedef void (*MenuActionCallback)(void* userData);

struct MenuItemObj {
    char* label;                  // Display text
    char* shortcut;              // Optional keyboard shortcut (platform-specific format)
    bool enabled;                // Whether the item is clickable
    bool checked;                // For checkable menu items
    MenuActionCallback action;    // Callback when item is selected
    void* userData;              // User data passed to callback
    struct MenuObj* submenu;        // Optional submenu (NULL if none)
};

struct MenuObj {
    char* title;                 // MenuObj title (shown in menu bar)
    struct MenuItemObj* items;      // Array of menu items
    size_t itemCount;            // Number of items in menu
};

// MenuObj management functions
struct MenuObj* create_menu(const char* title);
void free_menu(struct MenuObj* menu);

struct MenuItemObj* add_menu_item(struct MenuObj* menu, const char* label, MenuActionCallback action);
struct MenuItemObj* add_menu_separator(struct MenuObj* menu);
struct MenuItemObj* add_submenu(struct MenuObj* menu, const char* label, struct MenuObj* submenu);

void set_menu_item_enabled(struct MenuItemObj* item, bool enabled);
void set_menu_item_checked(struct MenuItemObj* item, bool checked);
void set_menu_item_shortcut(struct MenuItemObj* item, const char* shortcut);

// Window menu bar functions
void set_window_menu(void* windowHandle, struct MenuObj** menus, size_t menuCount);
void remove_window_menu(void* windowHandle);

#ifdef __cplusplus
}
#endif

#endif /* MENUS_H */