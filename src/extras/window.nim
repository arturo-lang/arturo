#=======================================================
# Windows management
# and utilities
#
# (c) 2019-2025 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/windows.nim
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
    const
        webkitVersion {.strdefine.} = "empty"
    {.compile("window/window.cc", staticExec("pkg-config --cflags gtk+-3.0 webkit2gtk-" & webkitVersion)).}
    {.passC: staticExec("pkg-config --cflags gtk+-3.0 webkit2gtk-" & webkitVersion) .}
    {.passL: staticExec("pkg-config --libs gtk+-3.0 webkit2gtk-"  & webkitVersion) .}
elif defined(freebsd) or defined(netbsd) or defined(openbsd):
    {.compile("window/window.cc", staticExec"pkg-config --cflags gtk3 webkit2-gtk3").}
    {.passC: staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
    {.passL: staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
elif defined(macosx):
    {.compile("window/window.cc", "-framework Foundation -framework AppKit -x objective-c++").}
    {.passL: "-framework AppKit".}
elif defined(windows):
    {.compile("window/window.cc", "-std=c++17").}
    {.passL: """-std=c++17 -lgdiplus -lshlwapi""".} # version.lib shell32.lib gdiplus.lib

#=======================================
# Types
#=======================================

type
    Window* = distinct pointer

    WindowSize* {.importc: "struct WindowSize", bycopy.} = object
        width*: int
        height*: int

    WindowPosition* {.importc: "struct WindowPosition", bycopy.} = object
        x*: int
        y*: int

#=======================================
# Function prototypes
#=======================================

{.push header: "window/window.h", cdecl.}

proc get_window_size*(w: Window): WindowSize {.importc.}
proc set_window_size*(w: Window, size: WindowSize) {.importc.}
proc get_window_min_size*(w: Window): WindowSize {.importc.}
proc set_window_min_size*(w: Window, size: WindowSize) {.importc.}
proc get_window_max_size*(w: Window): WindowSize {.importc.}
proc set_window_max_size*(w: Window, size: WindowSize) {.importc.}
proc get_window_position*(w: Window): WindowPosition {.importc.}
proc set_window_position*(w: Window, position: WindowPosition) {.importc.}
proc center_window*(w: Window) {.importc.}
proc is_maximized_window*(w: Window): bool {.importc.}
proc maximize_window*(w: Window) {.importc.}
proc unmaximize_window*(w: Window) {.importc.}
proc is_minimized_window*(w: Window): bool {.importc.}
proc minimize_window*(w: Window) {.importc.}
proc unminimize_window*(w: Window) {.importc.}
proc is_visible_window*(w: Window): bool {.importc.}
proc show_window*(w: Window) {.importc.}
proc hide_window*(w: Window) {.importc.}
proc is_fullscreen_window*(w: Window): bool {.importc.}
proc fullscreen_window*(w: Window) {.importc.}
proc unfullscreen_window*(w: Window) {.importc.}
proc set_topmost_window*(w: Window) {.importc.}
proc unset_topmost_window*(w: Window) {.importc.}
proc set_focused_window*(w: Window, focused: bool) {.importc.}
proc is_focused_window*(w: Window): bool {.importc.}
proc make_borderless_window*(w: Window) {.importc.}
proc set_closable_window*(w: Window, closable: bool) {.importc.}
proc is_closable_window*(w: Window): bool {.importc.}
proc set_maximizable_window*(w: Window, maximizable: bool) {.importc.}
proc is_maximizable_window*(w: Window): bool {.importc.}
proc set_minimizable_window*(w: Window, minimizable: bool) {.importc.}
proc is_minimizable_window*(w: Window): bool {.importc.}

{.pop.}