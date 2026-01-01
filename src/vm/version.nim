#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
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
    ArturoMetadata*   = static readFile("version/metadata").strip()

    ArturoVersionTxt* = "arturo v/" & ArturoVersion &                   ## The current version text
                        (if ArturoMetadata!="" or parseInt(ArturoBuild) > 3: " b/" & ArturoBuild & (if ArturoMetadata=="": "" else: "." & ArturoMetadata) else: "") &
                        " (" & systemArch & "/" & systemOs & ")"
                        
