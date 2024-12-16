//=======================================================
// Arturo
// Programming Language + Bytecode VM compiler
// (c) 2019-2024 Yanis Zafirópulos
//
// @file: extras/menus/menu.cc
//=======================================================

#include "menus.h"

#include <cstring>
#include <cstdlib>
#include <map>
#include <string>

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
    #include <Shlwapi.h>      
    #pragma comment(lib, "Shlwapi.lib")

    #define WINDOW_TYPE HWND

    // Windows-specific callback storage
    namespace {
        std::map<int, MenuActionCallback> menuCallbacks;
        std::map<int, void*> menuUserData;
        WNDPROC originalWndProc = nullptr;

        LRESULT CALLBACK MenuWindowProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
            if (msg == WM_COMMAND) {
                int cmdId = LOWORD(wParam);
                auto callbackIt = menuCallbacks.find(cmdId);
                auto userDataIt = menuUserData.find(cmdId);
                
                if (callbackIt != menuCallbacks.end() && userDataIt != menuUserData.end()) {
                    callbackIt->second(userDataIt->second);
                    return 0;
                }
            }
            return CallWindowProc(originalWndProc, hwnd, msg, wParam, lParam);
        }
    }

#endif

#if defined(__APPLE__)
// Helpers to avoid too much typing with the Objective C runtime
inline id operator"" _cls(const char *s, size_t) { return (id)objc_getClass(s); }
inline SEL operator"" _sel(const char *s, size_t) { return sel_registerName(s); }
inline id operator"" _str(const char *s, size_t) {
    return ((id(*)(id, SEL, const char *))objc_msgSend)(
        "NSString"_cls, "stringWithUTF8String:"_sel, s);
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

#if defined(__linux__) || defined(__FreeBSD__)
    #include <map>
    static std::map<GtkMenuItem*, MenuActionCallback> menuCallbacks;
    static std::map<GtkMenuItem*, void*> menuUserData;

    void menu_item_activated(GtkMenuItem* menuItem, gpointer user_data) {
        auto callbackIt = menuCallbacks.find(menuItem);
        auto userDataIt = menuUserData.find(menuItem);
        if (callbackIt != menuCallbacks.end() && userDataIt != menuUserData.end()) {
            callbackIt->second(userDataIt->second);
        }
    }
#endif

Menu* create_menu(const char* title) {
    Menu* menu = new Menu();
    menu->title = strdup(title);
    menu->items = nullptr;
    menu->itemCount = 0;
    return menu;
}

void free_menu(Menu* menu) {
    if (!menu) return;
    
    free(menu->title);
    for (size_t i = 0; i < menu->itemCount; i++) {
        free(menu->items[i].label);
        if (menu->items[i].shortcut) free(menu->items[i].shortcut);
        if (menu->items[i].submenu) free_menu(menu->items[i].submenu);
    }
    delete[] menu->items;
    delete menu;
}

MenuItem* add_menu_item(Menu* menu, const char* label, MenuActionCallback action) {
    MenuItem* newItems = new MenuItem[menu->itemCount + 1];
    if (menu->itemCount > 0) {
        memcpy(newItems, menu->items, menu->itemCount * sizeof(MenuItem));
        delete[] menu->items;
    }
    menu->items = newItems;
    
    MenuItem* item = &menu->items[menu->itemCount++];
    item->label = strdup(label);
    item->shortcut = nullptr;
    item->enabled = true;
    item->checked = false;
    item->action = action;
    item->userData = nullptr;
    item->submenu = nullptr;
    
    return item;
}

void set_window_menu(void* windowHandle, struct Menu** menus, size_t menuCount) {
    #if defined(__linux__) || defined(__FreeBSD__)
        GtkWidget* menuBar = gtk_menu_bar_new();
        
        for (size_t i = 0; i < menuCount; i++) {
            GtkWidget* menuItem = gtk_menu_item_new_with_label(menus[i]->title);
            GtkWidget* subMenu = gtk_menu_new();
            
            for (size_t j = 0; j < menus[i]->itemCount; j++) {
                MenuItem* item = &menus[i]->items[j];
                
                GtkWidget* subMenuItem;
                if (strcmp(item->label, "-") == 0) {
                    subMenuItem = gtk_separator_menu_item_new();
                } else {
                    subMenuItem = gtk_menu_item_new_with_label(item->label);
                    if (item->action) {
                        menuCallbacks[GTK_MENU_ITEM(subMenuItem)] = item->action;
                        menuUserData[GTK_MENU_ITEM(subMenuItem)] = item->userData;
                        g_signal_connect(subMenuItem, "activate",
                                       G_CALLBACK(menu_item_activated), nullptr);
                    }
                }
                
                gtk_menu_shell_append(GTK_MENU_SHELL(subMenu), subMenuItem);
            }
            
            gtk_menu_item_set_submenu(GTK_MENU_ITEM(menuItem), subMenu);
            gtk_menu_shell_append(GTK_MENU_SHELL(menuBar), menuItem);
        }
        
        gtk_widget_show_all(menuBar);
        gtk_container_add(GTK_CONTAINER((WINDOW_TYPE)windowHandle), menuBar);
        
    #elif defined(__APPLE__)
        NSMenu* mainMenu = [[NSMenu alloc] init];
        
        // Add Application Menu (first menu in the menu bar)
        NSMenuItem* appMenuItem = [[NSMenuItem alloc] init];
        NSMenu* appMenu = [[NSMenu alloc] init];
        NSString* appName = [[NSProcessInfo processInfo] processName];
        
        // About Item
        NSMenuItem* aboutItem = [[NSMenuItem alloc]
            initWithTitle:[NSString stringWithFormat:@"About %@", appName]
            action:@selector(orderFrontStandardAboutPanel:)
            keyEquivalent:@""];
        [aboutItem setTarget:NSApp];
        [appMenu addItem:aboutItem];
        
        // Separator
        [appMenu addItem:[NSMenuItem separatorItem]];
        
        // Preferences
        NSMenuItem* prefsItem = [[NSMenuItem alloc]
            initWithTitle:@"Preferences…"
            action:@selector(showPreferences:)
            keyEquivalent:@","];
        [appMenu addItem:prefsItem];
        
        // Services
        NSMenuItem* servicesItem = [[NSMenuItem alloc] init];
        NSMenu* servicesMenu = [[NSMenu alloc] initWithTitle:@"Services"];
        [servicesItem setSubmenu:servicesMenu];
        [appMenu addItem:servicesItem];
        [NSApp setServicesMenu:servicesMenu];
        
        [appMenu addItem:[NSMenuItem separatorItem]];
        
        // Hide/Show items
        NSMenuItem* hideItem = [[NSMenuItem alloc]
            initWithTitle:[NSString stringWithFormat:@"Hide %@", appName]
            action:@selector(hide:)
            keyEquivalent:@"h"];
        [hideItem setTarget:NSApp];
        [appMenu addItem:hideItem];
        
        NSMenuItem* hideOthersItem = [[NSMenuItem alloc]
            initWithTitle:@"Hide Others"
            action:@selector(hideOtherApplications:)
            keyEquivalent:@"h"];
        [hideOthersItem setKeyEquivalentModifierMask:NSEventModifierFlagCommand | NSEventModifierFlagOption];
        [hideOthersItem setTarget:NSApp];
        [appMenu addItem:hideOthersItem];
        
        NSMenuItem* showAllItem = [[NSMenuItem alloc]
            initWithTitle:@"Show All"
            action:@selector(unhideAllApplications:)
            keyEquivalent:@""];
        [showAllItem setTarget:NSApp];
        [appMenu addItem:showAllItem];
        
        [appMenu addItem:[NSMenuItem separatorItem]];
        
        // Quit
        NSMenuItem* quitItem = [[NSMenuItem alloc]
            initWithTitle:[NSString stringWithFormat:@"Quit %@", appName]
            action:@selector(terminate:)
            keyEquivalent:@"q"];
        [quitItem setTarget:NSApp];
        [appMenu addItem:quitItem];
        
        [appMenuItem setSubmenu:appMenu];
        [mainMenu addItem:appMenuItem];
        
        // Add Edit menu with standard items if not already present
        bool hasEditMenu = false;
        for (size_t i = 0; i < menuCount; i++) {
            if (strcmp(menus[i]->title, "Edit") == 0) {
                hasEditMenu = true;
                break;
            }
        }
        
        if (!hasEditMenu) {
            NSMenuItem* editMenuItem = [[NSMenuItem alloc] init];
            NSMenu* editMenu = [[NSMenu alloc] initWithTitle:@"Edit"];
            
            // Standard Edit menu items
            NSMenuItem* undoItem = [[NSMenuItem alloc]
                initWithTitle:@"Undo"
                action:@selector(undo:)
                keyEquivalent:@"z"];
            [editMenu addItem:undoItem];
            
            NSMenuItem* redoItem = [[NSMenuItem alloc]
                initWithTitle:@"Redo"
                action:@selector(redo:)
                keyEquivalent:@"Z"];
            [editMenu addItem:redoItem];
            
            [editMenu addItem:[NSMenuItem separatorItem]];
            
            NSMenuItem* cutItem = [[NSMenuItem alloc]
                initWithTitle:@"Cut"
                action:@selector(cut:)
                keyEquivalent:@"x"];
            [editMenu addItem:cutItem];
            
            NSMenuItem* copyItem = [[NSMenuItem alloc]
                initWithTitle:@"Copy"
                action:@selector(copy:)
                keyEquivalent:@"c"];
            [editMenu addItem:copyItem];
            
            NSMenuItem* pasteItem = [[NSMenuItem alloc]
                initWithTitle:@"Paste"
                action:@selector(paste:)
                keyEquivalent:@"v"];
            [editMenu addItem:pasteItem];
            
            NSMenuItem* deleteItem = [[NSMenuItem alloc]
                initWithTitle:@"Delete"
                action:@selector(delete:)
                keyEquivalent:@""];
            [editMenu addItem:deleteItem];
            
            NSMenuItem* selectAllItem = [[NSMenuItem alloc]
                initWithTitle:@"Select All"
                action:@selector(selectAll:)
                keyEquivalent:@"a"];
            [editMenu addItem:selectAllItem];
            
            [editMenuItem setSubmenu:editMenu];
            [mainMenu addItem:editMenuItem];
        }
        
        // Add user-defined menus
        for (size_t i = 0; i < menuCount; i++) {
            NSMenuItem* menuItem = [[NSMenuItem alloc] init];
            NSMenu* subMenu = [[NSMenu alloc] initWithTitle:@(menus[i]->title)];
            [menuItem setSubmenu:subMenu];
            
            for (size_t j = 0; j < menus[i]->itemCount; j++) {
                MenuItem* item = &menus[i]->items[j];
                
                if (strcmp(item->label, "-") == 0) {
                    [subMenu addItem:[NSMenuItem separatorItem]];
                } else {
                    NSMenuItem* nsItem = [[NSMenuItem alloc] 
                        initWithTitle:@(item->label)
                        action:@selector(menuItemSelected:)
                        keyEquivalent:@""];
                        
                    if (item->action) {
                        // Store callback in associated object
                        objc_setAssociatedObject(nsItem, 
                            "callback",
                            [^{ item->action(item->userData); } copy],
                            OBJC_ASSOCIATION_RETAIN);
                    }
                    
                    [subMenu addItem:nsItem];
                }
            }
            
            [mainMenu addItem:menuItem];
        }
        
        [NSApp setMainMenu:mainMenu];
        
    #elif defined(_WIN32)
        HMENU hMenuBar = CreateMenu();
        
        // Set up window procedure if not already done
        if (!originalWndProc) {
            originalWndProc = (WNDPROC)SetWindowLongPtr(
                (WINDOW_TYPE)windowHandle,
                GWLP_WNDPROC,
                (LONG_PTR)MenuWindowProc
            );
        }
        
        // Clear existing callbacks (in case menu is being reset)
        menuCallbacks.clear();
        menuUserData.clear();
        
        for (size_t i = 0; i < menuCount; i++) {
            HMENU hMenu = CreatePopupMenu();
            
            for (size_t j = 0; j < menus[i]->itemCount; j++) {
                MenuItem* item = &menus[i]->items[j];
                
                if (strcmp(item->label, "-") == 0) {
                    AppendMenuW(hMenu, MF_SEPARATOR, 0, NULL);
                } else {
                    // Generate unique command ID for this menu item
                    int cmdId = 1000 + (i * 100) + j;  // Assuming max 100 items per menu
                    
                    // Convert label to wide string
                    int len = MultiByteToWideChar(CP_UTF8, 0, item->label, -1, NULL, 0);
                    std::wstring wLabel(len, 0);
                    MultiByteToWideChar(CP_UTF8, 0, item->label, -1, &wLabel[0], len);
                    
                    UINT flags = MF_STRING;
                    if (!item->enabled) flags |= MF_GRAYED;
                    if (item->checked) flags |= MF_CHECKED;
                    
                    AppendMenuW(hMenu, flags, cmdId, wLabel.c_str());
                    
                    // Store callback and user data
                    if (item->action) {
                        menuCallbacks[cmdId] = item->action;
                        menuUserData[cmdId] = item->userData;
                    }
                }
            }
            
            // Convert menu title to wide string
            int len = MultiByteToWideChar(CP_UTF8, 0, menus[i]->title, -1, NULL, 0);
            std::wstring wTitle(len, 0);
            MultiByteToWideChar(CP_UTF8, 0, menus[i]->title, -1, &wTitle[0], len);
            
            AppendMenuW(hMenuBar, MF_POPUP, (UINT_PTR)hMenu, wTitle.c_str());
        }
        
        SetMenu((WINDOW_TYPE)windowHandle, hMenuBar);
    #endif
}

#ifndef WIN32_LEAN_AND_MEAN
    #define WIN32_LEAN_AND_MEAN 1
#endif