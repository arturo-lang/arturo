#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/vm.nim
#=======================================================

## The main VM module.
## 
## It initializes our main settings, orchestrates the 
## different components of the VM and executes the given
## code via ``run``.

#=======================================
# Libraries
#=======================================

import macros, os, random
import strutils, tables

when defined(WEB):
    import jsffi, json

import helpers/jsonobject
when not defined(WEB):
    import helpers/stores

import vm/[
    env, 
    errors, 
    eval, 
    exec, 
    globals, 
    parse, 
    stack, 
    values/value, 
    version
]

when not defined(WEB):
    import vm/profiler

when defined(WEB):
    import vm/values/printable

#=======================================
# Packaging setup
#=======================================

when defined(PORTABLE):
    import json, sequtils

    let js {.compileTime.} = parseJson(static readFile(getEnv("PORTABLE_DATA")))
    let mods {.compileTime.} = toSeq(js["uses"]["modules"]).map((x) => x.getStr())
    let compact {.compileTime.} = js["compact"].getStr() == "true"
else:
    let mods {.compileTime.}: seq[string] = @[]
    let compact {.compileTime.} = false

#=======================================
# Macros
#=======================================

macro importLib(name: static[string]): untyped =
    let id = ident(name & "Lib")
    let libname = name.toUpperAscii()
    result = quote do:
        when not defined(PORTABLE) or not compact or mods.contains(`name`):
            when defined(DEV):
                static: 
                    echo "-------------------------"
                    echo " ## " & `libname`
                    echo "-------------------------"
            import library/`name` as `id`

#=======================================
# Standard library setup
#=======================================

importLib "Arithmetic"
importLib "Bitwise"
importLib "Collections"
importLib "Colors"
importLib "Comparison"
importLib "Converters"
importLib "Core"
importLib "Crypto"
importLib "Databases"
importLib "Dates"
importLib "Files"
importLib "Io"
importLib "Iterators"
importLib "Logic"
importLib "Net"
importLib "Numbers"
importLib "Paths"
importLib "Quantities"
importLib "Reflection"
importLib "Sets"
importLib "Sockets"
importLib "Statistics"
importLib "Strings"
importLib "System"
importLib "Ui"

#=======================================
# Variables
#=======================================

var
    initialized     : bool = false

#=======================================
# Helpers
#=======================================

proc setupLibrary() =
    for i,importLibrary in Libraries:
        importLibrary()

template initialize(args: seq[string], filename: string, isFile:bool, scriptData:Value = nil, mutedColors: bool = false, portableData = "") =
    # stack
    createMainStack()

    # attributes
    createAttrsStack()
    
    # random number generator
    randomize()

    # environment
    initEnv(
        arguments = args, 
        version = ArturoVersion,
        build = ArturoBuild,
        script = scriptData
    )

    when not defined(WEB):
        # configuration
        Config = newStore(
            initStore(
                "config",
                doLoad=false,
                forceExtension=true,
                createIfNotExists=true,
                global=true,
                autosave=true,
                kind=NativeStore
            )
        )

    when not defined(WEB):
        # paths
        if isFile: env.addPath(filename)
        else: env.addPath(getCurrentDir())

    Syms = initTable[string,Value]()

    if portableData != "":
        SetSym("_portable", valueFromJson(portableData))

    # library
    setupLibrary()

    # set VM as initialized
    initialized = true

template handleVMErrors(blk: untyped): untyped =
    try:
        blk
    except CatchableError, Defect:
        let e = getCurrentException()        
        showVMErrors(e)

        when not defined(WEB):
            savePendingStores()

        if e.name == $(ProgramError):
            let code = parseInt(e.msg.split(";;")[1].split("<:>")[0])
            quit(code)
        else:
            quit(1)

#=======================================
# Methods
#=======================================

when not defined(WEB):

    proc runBytecode*(code: Translation, filename: string, args: seq[string]) =
        ## Takes compiled Arturo bytecode and executes it.
        handleVMErrors:
            initialize(args, filename, isFile=true)

            execUnscoped(code)

    proc run*(code: var string, args: seq[string], isFile: bool, doExecute: bool = true, withData=""): Translation {.exportc:"run".} =
        ## Takes a string of Arturo code and executes it.
        handleVMErrors:

            # TODO(VM/vm) Would it make sense to `GC_disableMarkAndSweep`?
            #  will it even matter at all?
            #  labels: vm, open discussion, benchmark, performance

            if isFile:
                when defined(SAFE):
                    CurrentFile = "main.art"
                else:
                    CurrentFile = lastPathPart(code)
                    CurrentPath = code

            initProfiler()
            
            let mainCode = doParse(code, isFile=isFile)

            if not initialized:
                initialize(
                    args, 
                    code, 
                    isFile=isFile, 
                    mainCode.data,
                    portableData=withData
                )

            let evaled = doEval(mainCode, useStored=false)

            if doExecute:
                execUnscoped(evaled)

            showProfilerData()

            savePendingStores()

            return evaled

else:

    proc run*(code: var string, params: JsObject = jsUndefined): JsObject {.exportc:"run".} =
        handleVMErrors:

            if params != jsUndefined:
                for param in items(params):
                    let val = parseJsObject(param)
                    code &= " " & codify(val)

            let mainCode = doParse(code, isFile=false)

            if not initialized:
                initialize(
                    @[""], 
                    code, 
                    isFile=false, 
                    mainCode.data
                )

            let evaled = doEval(mainCode, useStored=false)

            execUnscoped(evaled)

            var ret: Value = VNULL

            if SP>0:
                ret = sTop()
            
            return generateJsObject(ret)
    