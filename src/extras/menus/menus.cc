//=======================================================
// Arturo
// Programming Language + Bytecode VM compiler
// (c) 2019-2026 Yanis Zafirópulos
//
// @file: extras/menus/menus.cc
//=======================================================

#include "menus.h"
#include <cstring>
#include <cstdlib>
#include <map>
#include <string>
#include <functional>

#if defined(__linux__) || defined(__FreeBSD__)
    #include <gtk/gtk.h>
    #include <glib.h>
    #include <gdk-pixbuf/gdk-pixbuf.h>
    
    #define WINDOW_TYPE GtkWidget*

#elif defined(__APPLE__)
    #include <objc/objc-runtime.h>
    #include <AppKit/AppKit.h>

    #define WINDOW_TYPE id

    // Helpers to avoid too much typing with the Objective C runtime
    inline id operator"" _cls(const char *s, size_t) { return (id)objc_getClass(s); }
    inline SEL operator"" _sel(const char *s, size_t) { return sel_registerName(s); }
    inline id operator"" _str(const char *s, size_t) {
        return ((id(*)(id, SEL, const char *))objc_msgSend)(
            "NSString"_cls, "stringWithUTF8String:"_sel, s);
    }

    @interface MenuActionHandler : NSObject
    - (void)menuItemSelected:(NSMenuItem*)sender;
    @end

    @implementation MenuActionHandler
    - (void)menuItemSelected:(NSMenuItem*)sender {
        void (^callback)(void) = objc_getAssociatedObject(sender, "callback");
        if (callback) callback();
    }
    @end

    static MenuActionHandler* actionHandler = nil;

    static void menuItemCallback(id self, SEL cmd, id sender) {
        void (^callback)(void) = objc_getAssociatedObject(sender, "callback");
        if (callback) callback();
    }

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

#if defined(__linux__) || defined(__FreeBSD__)
    static std::map<GtkMenuItem*, MenuActionCallback> menuCallbacks;
    static std::map<GtkMenuItem*, void*> menuUserData;

    static void menu_item_activated(GtkMenuItem* menuItem, gpointer user_data) {
        auto callbackIt = menuCallbacks.find(menuItem);
        auto userDataIt = menuUserData.find(menuItem);
        if (callbackIt != menuCallbacks.end() && userDataIt != menuUserData.end()) {
            callbackIt->second(userDataIt->second);
        }
    }
#endif

MenuObj* create_menu(const char* title) {
    MenuObj* menu = new MenuObj();
    menu->title = strdup(title);
    menu->items = nullptr;
    menu->itemCount = 0;
    return menu;
}

void free_menu(MenuObj* menu) {
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

MenuItemObj* add_menu_item(MenuObj* menu, const char* label, MenuActionCallback action) {
    MenuItemObj* newItems = new MenuItemObj[menu->itemCount + 1];
    if (menu->itemCount > 0) {
        memcpy(newItems, menu->items, menu->itemCount * sizeof(MenuItemObj));
        delete[] menu->items;
    }
    menu->items = newItems;
    
    MenuItemObj* item = &menu->items[menu->itemCount++];
    item->label = strdup(label);
    item->shortcut = nullptr;
    item->enabled = true;
    item->checked = false;
    item->action = action;
    item->userData = nullptr;
    item->submenu = nullptr;
    
    return item;
}

MenuItemObj* add_menu_separator(MenuObj* menu) {
    return add_menu_item(menu, "-", nullptr);
}

MenuItemObj* add_submenu(MenuObj* menu, const char* label, MenuObj* submenu) {
    MenuItemObj* item = add_menu_item(menu, label, nullptr);
    item->submenu = submenu;
    return item;
}

void set_menu_item_enabled(MenuItemObj* item, bool enabled) {
    if (item) {
        item->enabled = enabled;
    }
}

void set_menu_item_checked(MenuItemObj* item, bool checked) {
    if (item) {
        item->checked = checked;
    }
}

void set_menu_item_shortcut(MenuItemObj* item, const char* shortcut) {
    if (item) {
        if (item->shortcut) free(item->shortcut);
        item->shortcut = shortcut ? strdup(shortcut) : nullptr;
    }
}

void set_window_menu(void* windowHandle, struct MenuObj** menus, size_t menuCount) {
#if defined(__linux__) || defined(__FreeBSD__)
    // Define function type first
    std::function<GtkWidget*(MenuObj*)> create_gtk_menu;
    
    // Then implement it
    create_gtk_menu = [&](MenuObj* menu) -> GtkWidget* {
        GtkWidget* gtkMenu = gtk_menu_new();
        
        for (size_t j = 0; j < menu->itemCount; j++) {
            MenuItemObj* item = &menu->items[j];
            GtkWidget* menuItem;
            
            if (strcmp(item->label, "-") == 0) {
                menuItem = gtk_separator_menu_item_new();
            } else {
                menuItem = gtk_menu_item_new_with_label(item->label);
                if (item->submenu) {
                    GtkWidget* subMenu = create_gtk_menu(item->submenu);
                    gtk_menu_item_set_submenu(GTK_MENU_ITEM(menuItem), subMenu);
                } else if (item->action) {
                    menuCallbacks[GTK_MENU_ITEM(menuItem)] = item->action;
                    menuUserData[GTK_MENU_ITEM(menuItem)] = item->userData;
                    g_signal_connect(menuItem, "activate",
                                   G_CALLBACK(menu_item_activated), nullptr);
                }
                gtk_widget_set_sensitive(menuItem, item->action != nullptr);
            }
            
            gtk_menu_shell_append(GTK_MENU_SHELL(gtkMenu), menuItem);
        }
        return gtkMenu;
    };

    GtkWidget* menuBar = gtk_menu_bar_new();
    
    for (size_t i = 0; i < menuCount; i++) {
        GtkWidget* menuItem = gtk_menu_item_new_with_label(menus[i]->title);
        GtkWidget* subMenu = create_gtk_menu(menus[i]);
        gtk_menu_item_set_submenu(GTK_MENU_ITEM(menuItem), subMenu);
        gtk_menu_shell_append(GTK_MENU_SHELL(menuBar), menuItem);
    }
    
    gtk_widget_show_all(menuBar);
    gtk_container_add(GTK_CONTAINER((WINDOW_TYPE)windowHandle), menuBar);

#elif defined(__APPLE__)
    NSMenu* mainMenu = [[NSMenu alloc] init];
    
    // Add Application MenuObj (first menu in the menu bar)
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
    
    // Create menu handler class if not already created
    static Class menuHandlerClass = nil;
    static id menuHandler = nil;
    
    if (!menuHandlerClass) {
        menuHandlerClass = objc_allocateClassPair([NSObject class], "MenuHandler", 0);
        class_addMethod(menuHandlerClass, @selector(menuItemSelected:), (IMP)menuItemCallback, "v@:@");
        objc_registerClassPair(menuHandlerClass);
        menuHandler = [[menuHandlerClass alloc] init];
    }

    std::function<NSMenu*(MenuObj*, bool)> create_ns_menu;
    create_ns_menu = [&](MenuObj* menu, bool isSubmenu) -> NSMenu* {
        NSMenu* nsMenu = [[NSMenu alloc] initWithTitle:@(menu->title)];
        [nsMenu setAutoenablesItems:NO];
        
        for (size_t j = 0; j < menu->itemCount; j++) {
            MenuItemObj* item = &menu->items[j];
            
            if (strcmp(item->label, "-") == 0) {
                [nsMenu addItem:[NSMenuItem separatorItem]];
            } else {
                NSMenuItem* nsItem = [[NSMenuItem alloc] 
                    initWithTitle:@(item->label)
                    action:nil
                    keyEquivalent:@""];
                
                if (item->submenu) {
                    NSMenu* subMenu = create_ns_menu(item->submenu, true);
                    [subMenu setTitle:@(item->label)];
                    [nsItem setSubmenu:subMenu];
                    [nsItem setEnabled:YES];
                } else {
                    if (item->action) {
                        objc_setAssociatedObject(nsItem, 
                            "callback",
                            [^{ item->action(item->userData); } copy],
                            OBJC_ASSOCIATION_RETAIN);
                        [nsItem setTarget:menuHandler];
                        [nsItem setAction:@selector(menuItemSelected:)];
                    }
                    [nsItem setEnabled:item->enabled];
                }
                
                [nsMenu addItem:nsItem];
            }
        }
        return nsMenu;
    };

    // Add user-defined menus
    for (size_t i = 0; i < menuCount; i++) {
        NSMenuItem* menuItem = [[NSMenuItem alloc] init];
        [menuItem setTitle:@(menus[i]->title)];  // Set the title for the main menu item
        NSMenu* menu = create_ns_menu(menus[i], false);
        [menu setTitle:@(menus[i]->title)];  // Set the title for the menu
        [menuItem setSubmenu:menu];
        [menuItem setEnabled:YES];
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
    
    menuCallbacks.clear();
    menuUserData.clear();
    
    std::function<HMENU(MenuObj*, int&)> create_windows_menu = [&](MenuObj* menu, int& cmdId) -> HMENU {
        HMENU hMenu = CreatePopupMenu();
        
        for (size_t j = 0; j < menu->itemCount; j++) {
            MenuItemObj* item = &menu->items[j];
            
            if (strcmp(item->label, "-") == 0) {
                AppendMenuW(hMenu, MF_SEPARATOR, 0, NULL);
            } else {
                int len = MultiByteToWideChar(CP_UTF8, 0, item->label, -1, NULL, 0);
                std::wstring wLabel(len, 0);
                MultiByteToWideChar(CP_UTF8, 0, item->label, -1, &wLabel[0], len);
                
                UINT flags = MF_STRING;
                if (!item->enabled) flags |= MF_GRAYED;
                if (item->checked) flags |= MF_CHECKED;
                
                if (item->submenu) {
                    HMENU hSubMenu = create_windows_menu(item->submenu, cmdId);
                    AppendMenuW(hMenu, flags | MF_POPUP, (UINT_PTR)hSubMenu, wLabel.c_str());
                } else {
                    cmdId++;
                    AppendMenuW(hMenu, flags, cmdId, wLabel.c_str());
                    
                    if (item->action) {
                        menuCallbacks[cmdId] = item->action;
                        menuUserData[cmdId] = item->userData;
                    }
                }
            }
        }
        return hMenu;
    };

    int cmdId = 1000;  // Starting ID for menu items
    for (size_t i = 0; i < menuCount; i++) {
        int len = MultiByteToWideChar(CP_UTF8, 0, menus[i]->title, -1, NULL, 0);
        std::wstring wTitle(len, 0);
        MultiByteToWideChar(CP_UTF8, 0, menus[i]->title, -1, &wTitle[0], len);
        
        HMENU hMenu = create_windows_menu(menus[i], cmdId);
        AppendMenuW(hMenuBar, MF_POPUP, (UINT_PTR)hMenu, wTitle.c_str());
    }
    
    SetMenu((WINDOW_TYPE)windowHandle, hMenuBar);
#endif
}

void remove_window_menu(void* windowHandle) {
#if defined(__linux__) || defined(__FreeBSD__)
    // For GTK, we need to remove all children from the container
    GtkWidget* container = GTK_WIDGET(windowHandle);
    GList* children = gtk_container_get_children(GTK_CONTAINER(container));
    
    for(GList* iter = children; iter != NULL; iter = g_list_next(iter)) {
        gtk_container_remove(GTK_CONTAINER(container), GTK_WIDGET(iter->data));
    }
    
    g_list_free(children);
    menuCallbacks.clear();
    menuUserData.clear();
    
#elif defined(__APPLE__)
    [NSApp setMainMenu:nil];
    
#elif defined(_WIN32)
    SetMenu((HWND)windowHandle, NULL);
    DrawMenuBar((HWND)windowHandle);
    menuCallbacks.clear();
    menuUserData.clear();
#endif
}