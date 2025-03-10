#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: vm/env.nim
#=======================================================

## General environment configuration, paths, etc.

#=======================================
# Libraries
#=======================================
when not defined(WEB):
    import cpuinfo, nativesockets
    import parseopt, sequtils, sugar

when defined(GMP):
    import extras/gmp
    import extras/mpfr

when not defined(NOSQLITE):
    import extras/db_connector/sqlite3

import pcre

import os, strutils, tables, times, system

import helpers/system
import helpers/terminal

import vm/values/value
import vm/version

when not defined(WEB):
    import vm/parse
    import vm/values/custom/[vlogical]

#=======================================
# Globals
#=======================================

var 
    HomeDir*    : string                        ## User's home directory
    TmpDir*     : string                        ## User's temp directory

    #--------------------
    # private
    #--------------------
    Arguments       : Value
    ScriptInfo      : Value

#=======================================
# Helpers
#=======================================

proc getCmdlineArgumentArray*(): Value =
    ## return all command0line arguments as 
    ## a Block value
    Arguments

when not defined(WEB):
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

    when not defined(WEB):
        if Arguments.a.len > 0:
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
    var versionStr = ArturoVersion
    versionStr &= "+" & ArturoBuild
    if ArturoMetadata != "":
        versionStr &= "." & ArturoMetadata
    try:
        result = {
            "author"    : newString("Yanis Zafirópulos"),
            "copyright" : newString("(c) 2019-2025"),
            "version"   : newVersion(versionStr),
            "built"     : newDate(parse(CompileDate & " " & CompileTime, "yyyy-MM-dd HH:mm:ss")),
            "deps"      : newDictionary(),
            "binary"    : 
                when defined(WEB):
                    newString("arturo.js")
                else:
                    newString(getAppFilename()),
            "cpu"       : newDictionary(),
            "os"        : newString(systemOs),
            "hostname"  : newString(""),
            "release"   : 
                when defined(MINI):
                    newLiteral("mini")
                else:
                    newLiteral("full")
        }.toOrderedTable
        
        result["cpu"].d["arch"] = newLiteral(systemArch)
        result["cpu"].d["endian"] = 
            if cpuEndian == Endianness.littleEndian:
                newLiteral("little")
            else:
                newLiteral("big")

        when not defined(WEB):
            result["cpu"].d["cores"] = newInteger(countProcessors())

        when not defined(WEB):
            result["hostname"] = newString(getHostname())

        when defined(GMP):
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

proc initEnv*(arguments: seq[string], script: Value) =
    ## initialize environment with given arguments
    Arguments = newStringBlock(arguments)

    if not script.isNil:
        ScriptInfo = script
    else:
        ScriptInfo = newDictionary()

    # PathStack = @[]
    when not defined(WEB):
        HomeDir = getHomeDir()
        TmpDir  = getTempDir()

proc setColors*(muted: bool = false) =
    ## switch terminal colors on/off, globally
    NoColors = muted
