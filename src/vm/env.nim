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

import os, strutils, tables, times

import vm/bytecode, vm/value

#=======================================
# Globals
#=======================================

var 
    PathStack*  : seq[string]
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

proc currentPath*():string =
    PathStack[^1]

proc addPath*(newPath: string) =
    var (dir, _, _) = splitFile(newPath)
    PathStack.add(dir)

proc getEnvDictionary*(): ValueDict =
    result = initOrderedTable[string,Value]()

    result["arg"] = newBlock(Arguments)

    result["sys"] = newDictionary({
        "author"    : newString("Yanis Zafirópulos"),
        "copyright" : newString("(c) 2019-2020"),
        "version"   : newString(Version),
        "build"     : newInteger(parseInt(Build)),
        "buildDate" : newDate(now()),
        "cpu"       : newString(hostCPU),
        "os"        : newString(hostOS),
        "builtin"   : newBlock(getBuiltins())
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
