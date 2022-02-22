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

#=======================================
# Types
#=======================================

type
    Window* = pointer

#=======================================
# Methods
#=======================================

proc maximize*(w: Window) =
    maximizeWindow(w)