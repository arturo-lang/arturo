#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/webview.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import tables

import extras/window
import extras/menus

export window, menus

type
    MenuBarAction* = proc(userData: pointer) {.closure.}

    MenuBarItemKind* = enum
        mbkItem
        mbkSeparator
        mbkSubmenu

    MenuBarItem* = ref object
        case kind*: MenuBarItemKind
        of mbkItem:
            label*: string
            shortcut*: string
            enabled*: bool
            checked*: bool
            action*: MenuBarAction
            userData*: pointer
        of mbkSeparator:
            discard
        of mbkSubmenu:
            submenuLabel*: string
            submenu*: MenuBar

    MenuBar* = ref object
        title*: string
        items*: seq[MenuBarItem]

#=======================================
# Methods
#=======================================

proc isMaximized*(w: Window): bool =
    is_maximized_window(w)

proc isMinimized*(w: Window): bool =
    is_minimized_window(w)

proc isVisible*(w: Window): bool =
    is_visible_window(w)

proc isFullscreen*(w: Window): bool =
    is_fullscreen_window(w)

proc getSize*(w: Window): WindowSize =
    get_window_size(w)

proc setSize*(w: Window, sz: WindowSize) =
    set_window_size(w, sz)

proc getMinSize*(w: Window): WindowSize =
    get_window_min_size(w)

proc setMinSize*(w: Window, sz: WindowSize) =
    set_window_min_size(w, sz)

proc getMaxSize*(w: Window): WindowSize =
    get_window_max_size(w)

proc setMaxSize*(w: Window, sz: WindowSize) =
    set_window_max_size(w, sz)

proc getPosition*(w: Window): WindowPosition =
    get_window_position(w)

proc setPosition*(w: Window, pos: WindowPosition) =
    set_window_position(w, pos)

proc center*(w: Window) =
    center_window(w)

proc maximize*(w: Window) =
    if not w.isMaximized():
        maximize_window(w)

proc unmaximize*(w: Window) =
    if w.isMaximized():
        unmaximize_window(w)

proc minimize*(w: Window) =
    if not w.isMinimized():
        minimize_window(w)

proc unminimize*(w: Window) =
    if w.isMinimized():
        unminimize_window(w)

proc show*(w: Window) =
    if not w.isVisible():
        show_window(w)

proc hide*(w: Window) =
    if w.isVisible():
        hide_window(w)

proc fullscreen*(w: Window) =
    if not w.isFullscreen():
        fullscreen_window(w)

proc unfullscreen*(w: Window) =
    if w.isFullscreen():
        unfullscreen_window(w)

proc topmost*(w: Window) =
    set_topmost_window(w)

proc untopmost*(w: Window) =
    unset_topmost_window(w)

proc setFocused*(w: Window, f: bool) =
    set_focused_window(w, f)

proc isFocused*(w: Window): bool =
    is_focused_window(w)

proc makeBorderless*(w: Window) =
    make_borderless_window(w)

proc setClosable*(w: Window, c: bool) =
    set_closable_window(w, c)

proc isClosable*(w: Window): bool =
    is_closable_window(w)

proc setMaximizable*(w: Window, m: bool) =
    set_maximizable_window(w, m)

proc isMaximizable*(w: Window): bool =
    is_maximizable_window(w)

proc setMinimizable*(w: Window, m: bool) =
    set_minimizable_window(w, m)

proc isMinimizable*(w: Window): bool =
    is_minimizable_window(w)

#---------------------

# At the top of the module, we'll need a way to store our closures
var menuCallbacks = newTable[pointer, MenuBarAction]()

# Helper to create a C-compatible callback
proc menuCallbackWrapper(userData: pointer) {.cdecl.} =
    if menuCallbacks.hasKey(userData):
        menuCallbacks[userData](userData)

proc newMenuBar*(title: string): MenuBar =
    result = MenuBar(
        title: title,
        items: @[]
    )

proc newMenu*(): MenuBar =
    ## Creates a new menu (not a menubar) that can be used as a submenu
    result = MenuBar(
        title: "",  # Submenus don't need a title in the same way as menubars
        items: @[]
    )

proc addItem*(menu: MenuBar, label: string, action: MenuBarAction = nil, userData: pointer = nil): MenuBarItem =
    result = MenuBarItem(
        kind: mbkItem,
        label: label,
        enabled: true,
        checked: false,
        action: action,
        userData: userData
    )
    menu.items.add(result)

proc addSeparator*(menu: MenuBar): MenuBarItem =
    result = MenuBarItem(kind: mbkSeparator)
    menu.items.add(result)

proc addSubmenu*(menu: MenuBar, label: string, submenu: MenuBar): MenuBarItem =
    result = MenuBarItem(
        kind: mbkSubmenu,
        submenuLabel: label,
        submenu: submenu
    )
    menu.items.add(result)

proc enable*(item: MenuBarItem) =
    if item.kind == mbkItem:
        item.enabled = true

proc disable*(item: MenuBarItem) =
    if item.kind == mbkItem:
        item.enabled = false

proc check*(item: MenuBarItem) =
    if item.kind == mbkItem:
        item.checked = true

proc uncheck*(item: MenuBarItem) =
    if item.kind == mbkItem:
        item.checked = false

proc setShortcut*(item: MenuBarItem, shortcut: string) =
    if item.kind == mbkItem:
        item.shortcut = shortcut

proc setMenuBar*(w: Window, menus: openArray[MenuBar]) =
    # Convert our high-level menu structure to C-style menus
    var cMenus = newSeq[ptr Menu](menus.len)
    
    for i, menu in menus:
        # Create the C menu
        cMenus[i] = create_menu(menu.title.cstring)
        
        # Add all items
        for item in menu.items:
            case item.kind:
            of mbkItem:
                if item.action != nil:
                    menuCallbacks[item.userData] = item.action
                    
                let cItem = add_menu_item(cMenus[i], 
                    item.label.cstring,
                    if item.action != nil: menuCallbackWrapper else: nil)
                
                if item.shortcut.len > 0:
                    set_menu_item_shortcut(cItem, item.shortcut.cstring)
                set_menu_item_enabled(cItem, item.enabled)
                set_menu_item_checked(cItem, item.checked)
                
            of mbkSeparator:
                discard add_menu_separator(cMenus[i])
                
            of mbkSubmenu:
                let cSubmenu = create_menu(item.submenuLabel.cstring)
                discard add_submenu(cMenus[i], item.submenuLabel.cstring, cSubmenu)
    
    # Set the menu bar
    set_window_menu(w, cast[ptr ptr Menu](addr cMenus[0]), cMenus.len.csize_t)

proc removeMenuBar*(w: Window) =
    remove_window_menu(w)