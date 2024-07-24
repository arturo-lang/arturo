#=======================================================
# Menubar management
# for Nim
#
# (c) 2024 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/menubar.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Compilation & Linking
#=======================================

{.compile("menubar/menubar.m","-x objective-c").}

{.passC: "-I" & parentDir(currentSourcePath()) .}
{.passL:"-framework Cocoa".}

{.push header: "menubar/menubar.h", cdecl.}

proc generateDefaultMainMenu*() {.importc.}

{.pop.}