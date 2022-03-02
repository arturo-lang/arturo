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
    is_maximized_window((Window)w)

proc isVisible(w: Window): bool =
    is_visible_window((Window)w)

proc isFullscreen(w: Window): bool =
    is_fullscreen_window((Window)w)

#=======================================
# Methods
#=======================================

proc maximize*(w: Window) =
    if not w.isMaximized():
        maximize_window((Window)w)

proc unmaximize*(w: Window) =
    if w.isMaximized():
        unmaximize_window((Window)w)

proc show*(w: Window) =
    if not w.isVisible():
        show_window((Window)w)

proc hide*(w: Window) =
    if w.isVisible():
        hide_window((Window)w)

proc fullscreen*(w: Window) =
    if not w.isFullscreen():
        fullscreen_window((Window)w)

proc unfullscreen*(w: Window) =
    if w.isFullscreen():
        unfullscreen_window((Window)w)

proc topmost*(w: Window) =
    set_topmost_window((Window)w)

proc untopmost*(w: Window) =
    unset_topmost_window((Window)w)

proc makeBorderless*(w: Window) =
    make_borderless_window((Window)w)