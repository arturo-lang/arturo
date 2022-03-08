######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/env.nim
######################################################

#=======================================
# Libraries
#=======================================
when not defined(WEB) and not defined(windows):
    import parseopt, sequtils, sugar

import os, strutils, tables, times

import helpers/terminal

import vm/[parse,values/value]

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
    Arguments       : Value
    ArturoVersion   : string
    ArturoBuild     : string

    ScriptInfo      : Value

#=======================================
# Helpers
#=======================================

proc getCmdlineArgumentArray*(): Value =
    Arguments

proc parseCmdlineValue*(v: string): Value =
    if v=="" or v=="true" or v=="on": return newLogical(True)
    elif v=="false" or v=="off": return newLogical(False)
    else:
        try:
            discard parseFloat(v)
            return doParse(v, isFile=false).a[0]
        except:
            return newString(v)

# TODO(Env\parseCmdlineArguments) verify it's working right
#  labels: vm,library,language,unit-test
proc parseCmdlineArguments*(): ValueDict =
    result = initOrderedTable[string,Value]()
    var values: ValueArray = @[]

    when not defined(windows) and not defined(WEB):
        var p = initOptParser(Arguments.a.map((x)=>x.s))
        for kind, key, val in p.getopt():
            case kind
                of cmdArgument:
                    values.add(parseCmdlineValue(key))
                of cmdLongOption, cmdShortOption:
                    result[key] = parseCmdlineValue(val)
                of cmdEnd: assert(false) # cannot happen
    else:
        values = Arguments.a

    result["values"] = newBlock(values)

proc getSystemInfo*(): ValueDict =
    {
        "author"    : newString("Yanis Zafirópulos"),
        "copyright" : newString("(c) 2019-2022"),
        "version"   : newVersion(ArturoVersion),
        "build"     : newInteger(parseInt(ArturoBuild)),
        "buildDate" : newDate(now()),
        "binary"    : newString(getAppFilename()),
        "cpu"       : newString(hostCPU),
        "os"        : newString(hostOS),
        "release"   : 
            when defined(MINI):
                newLiteral("mini")
            else:
                newLiteral("full")
    }.toOrderedTable

proc getPathInfo*(): ValueDict =
    {
        "current"   : newString(getCurrentDir()),
        "home"      : newString(HomeDir),
        "temp"      : newString(TmpDir),
    }.toOrderedTable

proc getScriptInfo*(): Value =
    ScriptInfo

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

proc initEnv*(arguments: seq[string], version: string, build: string, script: Value) =
    Arguments = newStringBlock(arguments)
    ArturoVersion = version
    ArturoBuild = build

    ScriptInfo = script

    PathStack = @[]
    when not defined(WEB):
        HomeDir = getHomeDir()
        TmpDir  = getTempDir()

proc setColors*(muted: bool = false) =
    NoColors = muted