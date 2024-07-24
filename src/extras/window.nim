#=======================================================
# nim-portable-dialogs
# Sam Hocevar's Portable File Dialogs wrapper
# for Nim
#
# (c) 2024 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/pfd.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Compilation & Linking
#=======================================

{.passC: "-I" & parentDir(currentSourcePath()) .}

when defined(linux):
    {.compile("window/window.cc", staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0").}
    {.passC: staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0".}
    {.passL: staticExec"pkg-config --libs gtk+-3.0 webkit2gtk-4.0".}
elif defined(freebsd) or defined(netbsd) or defined(openbsd):
    {.compile("window/window.cc", staticExec"pkg-config --cflags gtk3 webkit2-gtk3").}
    {.passC: staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
    {.passL: staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
elif defined(macosx):
    {.compile("window/window.cc", "-framework Foundation -framework AppKit -x objective-c++").}
    {.passL: "-framework AppKit".}
elif defined(windows):
    {.compile("window/window.cc", "-std=c++17").}
    {.passL: """-std=c++17""".} # version.lib shell32.lib gdiplus.lib

#=======================================
# Types
#=======================================

type
    Window* = distinct pointer

#=======================================
# Function prototypes
#=======================================

{.push header: "window/window.h", cdecl.}

proc is_maximized_window*(w: Window): bool {.importc.}
proc maximize_window*(w: Window) {.importc.}
proc unmaximize_window*(w: Window) {.importc.}
proc is_visible_window*(w: Window): bool {.importc.}
proc show_window*(w: Window) {.importc.}
proc hide_window*(w: Window) {.importc.}
proc is_fullscreen_window*(w: Window): bool {.importc.}
proc fullscreen_window*(w: Window) {.importc.}
proc unfullscreen_window*(w: Window) {.importc.}
proc set_topmost_window*(w: Window) {.importc.}
proc unset_topmost_window*(w: Window) {.importc.}
proc make_borderless_window*(w: Window) {.importc.}

{.pop.}