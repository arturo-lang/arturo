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
    ArturoVersion*          = static readFile("version/version").strip()        ## The current version of Arturo
    ArturoRevision*         = static readFile("version/revision").strip()       ## The current revision number
    ArturoMetadata*         = static readFile("version/metadata").strip()       ## The metadata string (if any)
    ArturoCodename*         = static readFile("version/codename").strip()       ## The codename for official releases

    ArturoVersionString*    = ArturoVersion &                                   ## The version string with revision and metadata
                              (if ArturoVersion.contains("-dev"): 
                                  "+" & ArturoRevision & (if ArturoMetadata != "": "." & ArturoMetadata else: "")
                               else: "")

    ArturoVersionText*      = "arturo " &                                       ## What the user see for `arturo --version`
                               ArturoVersionString &     
                              (if ArturoCodename != "" and not ArturoVersion.contains("-dev"):
                                  " " & ArturoCodename
                               else: "") &     
                               " (" & systemArch & "/" & systemOs & ")"
