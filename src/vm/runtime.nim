#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/runtime.nim
#=======================================================

## VM runtime

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Globals
#=======================================

var
    # the path stack
    PathStack*  {.global.}  : seq[string]           ## The main path stack

#---------------------
# Path stack
#---------------------

proc entryPath*(): string =
    ## get initial script path
    PathStack[0]

proc currentPath*(): string =
    ## get current path
    PathStack[^1]

proc pushPath*(newPath: string, fromFile: static bool = false) =
    ## add given path to path stack
    when fromFile:
        var (dir, _, _) = splitFile(newPath)
        PathStack.add(dir)
    else:
        PathStack.add(newPath)

proc popPath*(): string =
    ## pop last path from path stack
    PathStack.pop()