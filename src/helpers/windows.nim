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

import extras/window

export window

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

proc focus*(w: Window) =
    focus_window(w)

proc makeBorderless*(w: Window) =
    make_borderless_window(w)

proc setMaximizable*(w: Window, m: bool) =
    set_maximizable_window(w, m)

proc isMaximizable*(w: Window): bool =
    is_maximizable_window(w)

proc setMinimizable*(w: Window, m: bool) =
    set_minimizable_window(w, m)

proc isMinimizable*(w: Window): bool =
    is_minimizable_window(w)