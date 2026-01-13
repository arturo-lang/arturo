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
    ArturoVersion*    = static readFile("version/version").strip()          ## The current version of Arturo
    ArturoRevision*   = static readFile("version/revision").strip()         ## The current revision number
    ArturoMetadata*   = static readFile("version/metadata").strip()

    ArturoVersionTxt* = "arturo " & ArturoVersion &                         ## The current version text
                        (if ArturoMetadata!="" or ArturoVersion.contains("-dev"): " @ " & ArturoRevision & (if ArturoMetadata=="": "" else: "." & ArturoMetadata) else: "") &
                        " (" & systemArch & "/" & systemOs & ")"
                        
