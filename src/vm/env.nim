######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/env.nim
######################################################

#=======================================
# Libraries
#=======================================

import os, strutils, tables, times

import vm/value

#=======================================
# Globals
#=======================================

var 
    PathStack*  {.threadvar.}: seq[string]
    HomeDir*    : string
    TmpDir*     : string

    #--------------------
    # private
    #--------------------
    Arguments   : ValueArray
    Version     : string
    Build       : string

#=======================================
# Methods
#=======================================

proc entryPath*(): string =
    PathStack[0]

proc currentPath*(): string =
    PathStack[^1]

proc addPath*(newPath: string) =
    var (dir, _, _) = splitFile(newPath)
    PathStack.add(dir)

proc popPath*(): string =
    PathStack.pop()

proc getEnvDictionary*(): ValueDict =
    result = initOrderedTable[string,Value]()

    result["arg"] = newBlock(Arguments)

    result["sys"] = newDictionary({
        "author"    : newString("Yanis Zafirópulos"),
        "copyright" : newString("(c) 2019-2021"),
        "version"   : newString(Version),
        "build"     : newInteger(parseInt(Build)),
        "buildDate" : newDate(now()),
        "cpu"       : newString(hostCPU),
        "os"        : newString(hostOS)
    }.toOrderedTable)

    result["path"] = newDictionary({
        "current"   : newString(getCurrentDir()),
        "home"      : newString(HomeDir),
        "temp"      : newString(TmpDir),
    }.toOrderedTable)

proc initEnv*(arguments: ValueArray, version: string, build: string) =
    Arguments = arguments
    Version = version
    Build = build

    PathStack = @[]
    HomeDir = getHomeDir()
    TmpDir  = getTempDir()
