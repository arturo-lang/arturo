#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/env.nim
#=======================================================

## General environment configuration, paths, etc.

#=======================================
# Libraries
#=======================================
when not defined(WEB) and not defined(windows):
    import parseopt, sequtils, sugar

when not defined(WEB):
    import nativesockets

when not defined(NOGMP):
    import extras/gmp
    import extras/mpfr

when not defined(NOSQLITE):
    import sqlite3

import pcre

import os, strutils, tables, times, system

import helpers/terminal

import vm/[parse,values/value]
import vm/values/custom/[vlogical]

#=======================================
# Globals
#=======================================

var 
    PathStack*  {.threadvar.}: seq[string]      ## The main path stack
    HomeDir*    : string                        ## User's home directory
    TmpDir*     : string                        ## User's temp directory

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
    ## return all command0line arguments as 
    ## a Block value
    Arguments

proc parseCmdlineValue(v: string): Value =
    if v=="" or v=="true" or v=="on": return newLogical(True)
    elif v=="false" or v=="off": return newLogical(False)
    else:
        try:
            discard parseFloat(v)
            return doParse(v, isFile=false).a[0]
        except CatchableError:
            return newString(v)

# TODO(Env\parseCmdlineArguments) verify it's working right
#  labels: vm,library,language,unit-test
proc parseCmdlineArguments*(): ValueDict =
    ## parse command-line arguments and return 
    ## result as a Dictionary value
    result = initOrderedTable[string,Value]()
    var values: ValueArray

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
    ## return system info as a Dictionary value
    try:
        result = {
            "author"    : newString("Yanis Zafirópulos"),
            "copyright" : newString("(c) 2019-2023"),
            "version"   : newVersion(ArturoVersion),
            "build"     : newInteger(parseInt(ArturoBuild)),
            "buildDate" : newDate(parse(CompileDate & " " & CompileTime, "yyyy-MM-dd HH:mm:ss")),
            "deps"      : newDictionary(),
            "binary"    : 
                when defined(WEB):
                    newString("arturo.js")
                else:
                    newString(getAppFilename()),
            "cpu"       : newDictionary(),
            "os"        : newString(hostOS),
            "hostname"  : newString(""),
            "release"   : 
                when defined(MINI):
                    newLiteral("mini")
                else:
                    newLiteral("full")
        }.toOrderedTable
        
        result["cpu"].d["arch"] = newLiteral(hostCPU.replace("i386","x86"))
        result["cpu"].d["endian"] = 
            if cpuEndian == Endianness.littleEndian:
                newLiteral("little")
            else:
                newLiteral("big")

        when not defined(WEB):
            result["hostname"] = newString(getHostname())

        when not defined(NOGMP):
            result["deps"].d["gmp"] = newVersion($(gmpVersion))
            result["deps"].d["mpfr"] = newVersion($(mpfr_get_version()))

        when not defined(NOSQLITE):
            result["deps"].d["sqlite"] = newVersion($(sqlite3.libversion()))

        let pcreVersion = ($(pcre.version())).split(" ")[0] & ".0"
        result["deps"].d["pcre"] = newVersion(pcreVersion)
        
    except CatchableError:
        discard

proc getPathInfo*(): ValueDict =
    ## return path info as a Dictionary value
    {
        "current"   : newString(getCurrentDir()),
        "home"      : newString(HomeDir),
        "temp"      : newString(TmpDir),
    }.toOrderedTable

proc getScriptInfo*(): Value =
    ## return script info as a Dictionary value
    ScriptInfo

#=======================================
# Methods
#=======================================

proc entryPath*(): string =
    ## get initial script path
    PathStack[0]

proc currentPath*(): string =
    ## get current path
    PathStack[^1]

proc addPath*(newPath: string) =
    ## add given path to path stack
    var (dir, _, _) = splitFile(newPath)
    PathStack.add(dir)

proc popPath*(): string =
    ## pop last path from path stack
    PathStack.pop()

proc initEnv*(arguments: seq[string], version: string, build: string, script: Value) =
    ## initialize environment with given arguments
    Arguments = newStringBlock(arguments)
    ArturoVersion = version
    ArturoBuild = build

    if not script.isNil:
        ScriptInfo = script
    else:
        ScriptInfo = newDictionary()

    PathStack = @[]
    when not defined(WEB):
        HomeDir = getHomeDir()
        TmpDir  = getTempDir()

proc setColors*(muted: bool = false) =
    ## switch terminal colors on/off, globally
    NoColors = muted
