#=======================================================
# Windows management
# and utilities
#
# (c) 2024 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/windows.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os

import extras/window

#=======================================
# Compilation & Linking
#=======================================

{.passC: "-I" & parentDir(currentSourcePath()) .}

when defined(linux):
    {.compile("menus/menus.cc", staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0").}
    {.passC: staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0".}
    {.passL: staticExec"pkg-config --libs gtk+-3.0 webkit2gtk-4.0".}
elif defined(freebsd) or defined(netbsd) or defined(openbsd):
    {.compile("menus/menus.cc", staticExec"pkg-config --cflags gtk3 webkit2-gtk3").}
    {.passC: staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
    {.passL: staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
elif defined(macosx):
    {.compile("menus/menus.cc", "-framework Foundation -framework AppKit -x objective-c++").}
    {.passL: "-framework AppKit".}
elif defined(windows):
    {.compile("menus/menus.cc", "-std=c++17").}
    {.passL: """-std=c++17 -lgdiplus -lshlwapi""".} # version.lib shell32.lib gdiplus.lib

#=======================================
# Types
#=======================================

type
    MenuActionCallback* = proc(userData: pointer) {.cdecl.}

    MenuItem* {.importc: "struct MenuItem", bycopy.} = object
        label*: cstring
        shortcut*: cstring
        enabled*: bool
        checked*: bool
        action*: MenuActionCallback
        userData*: pointer
        submenu*: Menu

    Menu* {.importc: "struct Menu", bycopy.} = object
        title*: cstring
        items*: ptr MenuItem
        itemCount*: csize_t

#=======================================
# Function prototypes
#=======================================

{.push header: "menus/menus.h", cdecl.}

# Menu management functions
proc create_menu*(title: cstring): ptr Menu {.importc.}
proc free_menu*(menu: ptr Menu) {.importc.}

proc add_menu_item*(menu: ptr Menu, label: cstring, action: MenuActionCallback): ptr MenuItem {.importc.}
proc add_menu_separator*(menu: ptr Menu): ptr MenuItem {.importc.}
proc add_submenu*(menu: ptr Menu, label: cstring, submenu: ptr Menu): ptr MenuItem {.importc.}

proc set_menu_item_enabled*(item: ptr MenuItem, enabled: bool) {.importc.}
proc set_menu_item_checked*(item: ptr MenuItem, checked: bool) {.importc.}
proc set_menu_item_shortcut*(item: ptr MenuItem, shortcut: cstring) {.importc.}

# Window menu bar functions
proc set_window_menu*(window: Window, menus: ptr ptr Menu, menuCount: csize_t) {.importc.}
proc remove_window_menu*(window: Window) {.importc.}

{.pop.}
