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
    {.compile("libclipboard/clipboard_x11.c", "-DLIBCLIPBOARD_BUILD_X11 -pthread").}
    {.passL: "-pthread -lxcb".}
elif defined(macosx):
    {.compile("libclipboard/clipboard_cocoa.c", "-x objective-c -DLIBCLIPBOARD_BUILD_COCOA -framework Foundation").}
elif defined(windows):
    {.compile("libclipboard/clipboard_win32.c", "-DLIBCLIPBOARD_BUILD_WIN32").}

#=======================================
# Types
#=======================================

type
    ClipboardMode* {.importc:"clipboard_mode".} = enum
        LCB_CLIPBOARD = 0
        LCB_PRIMARY
        LCB_SELECTION
        LCB_SECONDARY
        LCB_MODE_END
    ClipboardStruct* {.importc:"clipboard_c", header: "libclipboard/libclipboard.h", pure.} = object
    ClipboardObj* = ptr ClipboardStruct

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