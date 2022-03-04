######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/version.nim
######################################################

#=======================================
# Libraries
#=======================================

import strutils

#=======================================
# Constants
#=======================================

const 
    ArturoVersion*    = static readFile("version/version").strip()
    ArturoBuild*      = static readFile("version/build").strip()

    ArturoVersionTxt* = "arturo v/" & ArturoVersion
