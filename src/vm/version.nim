#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/version.nim
#=======================================================

## General version information 
## about the current build.

#=======================================
# Libraries
#=======================================

import strutils

import helpers/system

#=======================================
# Constants
#=======================================

const 
    ArturoVersion*    = static readFile("version/version").strip()      ## The current version of Arturo
    ArturoBuild*      = static readFile("version/build").strip()        ## The current build number of Arturo

    ArturoVersionTxt* = "arturo v/" & ArturoVersion &                   ## The current version text
                        " b/" & ArturoBuild &
                        " (" & systemArch & "/" & systemOs & ")"
                        
