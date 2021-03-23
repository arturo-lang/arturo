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

import os, parseopt, sequtils, strutils
import sugar, tables, times

import vm/[parse,value]

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
    Arguments   : Value
    Version     : string
    Build       : string

#=======================================
# Helpers
#=======================================

proc parseCmdlineValue*(v: string): Value =
    if v=="" or v=="true" or v=="on": return newBoolean(true)
    elif v=="false" or v=="off": return newBoolean(false)
    else:
        return doParse(v, isFile=false).a[0]

proc parseCmdlineArguments*(): ValueDict =
    result = initOrderedTable[string,Value]()
    var values: ValueArray = @[]

    when not defined(windows):
        var p = initOptParser(Arguments.a.map((x)=>x.s))
        for kind, key, val in p.getopt():
            case kind
                of cmdArgument:
                    values.add(parseCmdlineValue(key))
                of cmdLongOption, cmdShortOption:
                    result[key] = parseCmdlineValue(val)
                of cmdEnd: assert(false) # cannot happen
    else:
        values = Arguments.a.map((x)=>x.s)

    result["values"] = newBlock(values)

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

    result["arg"] = Arguments
    result["args"] = newDictionary(parseCmdlineArguments())

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

proc initEnv*(arguments: seq[string], version: string, build: string) =
    Arguments = newStringBlock(arguments)
    Version = version
    Build = build

    PathStack = @[]
    HomeDir = getHomeDir()
    TmpDir  = getTempDir()
