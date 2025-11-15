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

when defined(linux) or defined(freebsd):
    const
        webkitVersion {.strdefine.} = "empty"
    {.compile("menus/menus.cc", staticExec("pkg-config --cflags gtk+-3.0 webkit2gtk-" & webkitVersion)).}
    {.passC: staticExec("pkg-config --cflags gtk+-3.0 webkit2gtk-" & webkitVersion) .}
    {.passL: staticExec("pkg-config --libs gtk+-3.0 webkit2gtk-"  & webkitVersion) .}
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

    MenuItemObj* {.importc: "struct MenuItemObj", bycopy.} = object
        label*: cstring
        shortcut*: cstring
        enabled*: bool
        checked*: bool
        action*: MenuActionCallback
        userData*: pointer
        submenu*: MenuObj

    MenuObj* {.importc: "struct MenuObj", bycopy.} = object
        title*: cstring
        items*: ptr MenuItemObj
        itemCount*: csize_t

#=======================================
# Function prototypes
#=======================================

{.push header: "menus/menus.h", cdecl.}

# MenuObj management functions
proc create_menu*(title: cstring): ptr MenuObj {.importc.}
proc free_menu*(menu: ptr MenuObj) {.importc.}

proc add_menu_item*(menu: ptr MenuObj, label: cstring, action: MenuActionCallback): ptr MenuItemObj {.importc.}
proc add_menu_separator*(menu: ptr MenuObj): ptr MenuItemObj {.importc.}
proc add_submenu*(menu: ptr MenuObj, label: cstring, submenu: ptr MenuObj): ptr MenuItemObj {.importc.}

proc set_menu_item_enabled*(item: ptr MenuItemObj, enabled: bool) {.importc.}
proc set_menu_item_checked*(item: ptr MenuItemObj, checked: bool) {.importc.}
proc set_menu_item_shortcut*(item: ptr MenuItemObj, shortcut: cstring) {.importc.}

# Window menu bar functions
proc set_window_menu*(window: Window, menus: ptr ptr MenuObj, menuCount: csize_t) {.importc.}
proc remove_window_menu*(window: Window) {.importc.}

{.pop.}
