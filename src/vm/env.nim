######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: vm/env.nim
######################################################

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Globals
#=======================================

var 
    PathStack*  : seq[string]
    HomeDir*    : string
    TmpDir*     : string

#=======================================
# Methods
#=======================================

proc currentPath*():string =
    PathStack[^1]

proc addPath*(newPath: string) =
    var (dir, _, _) = splitFile(newPath)
    PathStack.add(dir)

proc initEnv*() =
    PathStack = @[]

    HomeDir = getHomeDir()
    TmpDir  = getTempDir()
