#=======================================================
# nim-portable-dialogs
# Wrapper for Steve Bennett's fork of LineNoise
# for Nim
#
# (c) 2024 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/linenoise.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Compilation & Linking
#=======================================

{.passC: "-I" & parentDir(currentSourcePath()) .}

# TODO(extras/linenoise) UTF-8 support not working properly
#  should add -DUSE_UTF8 for UTF-8 support
#  to all following lines
#  the problem is that - although it "works" - different characters are not shown at all:
#  e.g. accented characters, or ø - our symbol for null
#  labels: bug, 3rd-party, repl
{.compile("linenoise/linenoise.c", "-I" & parentDir(currentSourcePath())).}
{.compile("linenoise/stringbuf.c", "-I" & parentDir(currentSourcePath())).}
{.compile("linenoise/utf8.c", "-I" & parentDir(currentSourcePath())).}

#=======================================
# Types
#=======================================

type
    constChar* {.importc:"const char*".} = cstring
    LinenoiseCompletions* {.bycopy.} = object
      len*: csize_t
      cvec*: cstringArray

    LinenoiseCompletionCallback*    = proc (buf: constChar; lc: ptr LinenoiseCompletions, userdata: pointer) {.cdecl.}
    LinenoiseHintsCallback*         = proc (buf: constChar; color: var cint; bold: var cint, userdata: pointer): cstring {.cdecl.}
    LinenoiseFreeHintsCallback*     = proc (buf: constChar; color: var cint; bold: var cint, userdata: pointer) {.cdecl.}

#=======================================
# Function prototypes
#=======================================

{.push header: "linenoise/linenoise.h", cdecl.}

proc linenoiseSetCompletionCallback*(cback: ptr LinenoiseCompletionCallback, userdata: pointer): ptr LinenoiseCompletionCallback {.importc: "linenoiseSetCompletionCallback".}
proc linenoiseSetHintsCallback*(callback: ptr LinenoiseHintsCallback, userdata: pointer) {.importc: "linenoiseSetHintsCallback".}
proc linenoiseAddCompletion*(a2: ptr LinenoiseCompletions; a3: cstring) {.importc: "linenoiseAddCompletion".}
proc linenoiseReadLine*(prompt: cstring): cstring {.importc: "linenoise".}
proc linenoiseHistoryAdd*(line: cstring): cint {.importc: "linenoiseHistoryAdd", discardable.}
proc linenoiseHistorySetMaxLen*(len: cint): cint {.importc: "linenoiseHistorySetMaxLen".}
proc linenoiseHistorySave*(filename: cstring): cint {.importc: "linenoiseHistorySave".}
proc linenoiseHistoryLoad*(filename: cstring): cint {.importc: "linenoiseHistoryLoad".}
proc linenoiseClearScreen*() {.importc: "linenoiseClearScreen".}
proc linenoiseSetMultiLine*(ml: cint) {.importc: "linenoiseSetMultiLine".}
proc linenoisePrintKeyCodes*() {.importc: "linenoisePrintKeyCodes".}

{.pop.}

proc free*(s: cstring) {.importc: "free", header: "<stdlib.h>".}

#=======================================
# Methods
#=======================================

proc clearScreen*() = 
    linenoiseClearScreen()
