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

when defined(windows):
    {.compile("pfd/pfd.cc","-std=c++11 -static-libstdc++ -DSTRSAFE_NO_DEPRECATE").}
else:
    {.compile("pfd/pfd.cc","-std=c++11").}

{.passC: "-I" & parentDir(currentSourcePath()) .}

when defined(windows):
    {.passL:"-static-libstdc++ -L -lversion -lole32 -luuid -lshell32 -luser32 -lkernel32 -lgdi32 -lcomctl32 -loleaut32".}
else:
    {.passL:"-lstdc++".}

#=======================================
# Types
#=======================================

type
    DialogIcon* {.size: sizeof(cint).} = enum
        NoIcon = 0
        InfoIcon = 1
        WarningIcon = 2
        ErrorIcon = 3
        QuestionIcon = 4

    DialogType* {.size: sizeof(cint).} = enum
        OKDialog = 0
        OKCancelDialog = 1
        YesNoDialog = 2
        YesNoCancelDialog = 3
        RetryCancelDialog = 4
        RetryAbortIgnoreDialog = 5

    DialogResult* {.size: sizeof(cint).} = enum
        CancelResult = -1
        OKResult = 0
        YesResult = 1
        NoResult = 2
        AbortResult = 3
        RetryResult = 4
        IgnoreResult = 5

#=======================================
# Function prototypes
#=======================================

{.push header: "pfd/pfd.h", cdecl.}

proc pfd_notification*(title: cstring, message: cstring, ic: DialogIcon) {.importc.}
proc pfd_message*(title: cstring, message: cstring, tp: DialogType, ic: DialogIcon):DialogResult {.importc.}
proc pfd_select_folder*(title: cstring, path: cstring): cstring {.importc.}
proc pfd_select_file*(title: cstring, path: cstring): cstring {.importc.}

{.pop.}