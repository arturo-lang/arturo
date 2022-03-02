######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/webview.nim
######################################################

#=======================================
# Libraries
#=======================================

import extras/window

export window

#=======================================
# Helpers
#=======================================

proc isMaximized(w: Window): bool =
    is_maximized_window(w)

proc isVisible(w: Window): bool =
    is_visible_window(w)

proc isFullscreen(w: Window): bool =
    is_fullscreen_window(w)

#=======================================
# Methods
#=======================================

proc maximize*(w: Window) =
    if not w.isMaximized():
        maximize_window(w)

proc unmaximize*(w: Window) =
    if w.isMaximized():
        unmaximize_window(w)

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

proc makeBorderless*(w: Window) =
    make_borderless_window(w)