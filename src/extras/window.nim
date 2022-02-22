######################################################
# nim-portable-dialogs
# Sam Hocevar's Portable File Dialogs wrapper
# for Nim
#
# (c) 2022 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/pfd.nim
######################################################

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Compilation & Linking
#=======================================

{.passC: "-I" & parentDir(currentSourcePath()) .}

when defined(linux):
    {.compile("window/window.c").}
    {.passC: staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0".}
    {.passL: staticExec"pkg-config --libs gtk+-3.0 webkit2gtk-4.0".}
elif defined(freebsd):
    {.compile("window/window.c").}
    {.passC: staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
    {.passL: staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
elif defined(macosx):
    {.compile("window/window.c", "-x objective-c").}
    {.passL: "-framework WebKit".}
elif defined(windows):
    {.passL: """/EHsc /std:c++17 "deps\libs\x64\WebView2LoaderStatic.lib" version.lib shell32.lib""".}

#=======================================
# Function prototypes
#=======================================

{.push header: "window/window.h", cdecl.}

proc maximizeWindow*(w: pointer) {.importc.}

{.pop.}