######################################################
# nim-portable-dialogs
# Jeremy Tan's libclipboard wrapper
# for Nim
#
# (c) 2022 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/libclipboard.nim
######################################################

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Compilation & Linking
#=======================================

{.passC: "-I" & parentDir(currentSourcePath()) .}
{.compile("libclipboard/clipboard_common.c", "-I" & parentDir(currentSourcePath())).}

when defined(linux) or defined(freebsd):
    {.compile("libclipboard/clipboard_x11.c", "-DLIBCLIPBOARD_BUILD_X11").}
elif defined(macosx):
    {.compile("libclipboard/clipboard_cocoa.c", "-x objective-c -DLIBCLIPBOARD_BUILD_COCOA -framework Foundation").}
elif defined(windows):
    {.compile("libclipboard/clipboard_win32.c", "-DLIBCLIPBOARD_BUILD_WIN32").}

#=======================================
# Types
#=======================================

type
    ClipboardMode* {.size: sizeof(cint).} = enum
        LCB_CLIPBOARD = 0
        LCB_PRIMARY = 1
        LCB_SELECTION = 2
        LCB_SECONDARY = 3
        LCB_MODE_END = 4

    ClipboardObj* {.pure.} = ref object

#=======================================
# Function prototypes
#=======================================

{.push header: "libclipboard/libclipboard.h", cdecl.}

proc clipboard_new*(cb_opts: pointer): ClipboardObj {.importc.}
proc clipboard_clear*(cb: ClipboardObj, mode: ClipboardMode) {.importc.}
proc clipboard_free*(cb: ClipboardObj) {.importc.}
proc clipboard_set_text*(cb: ClipboardObj, src: cstring) {.importc.}
proc clipboard_text*(cb: ClipboardObj): cstring {.importc.}

{.pop.}