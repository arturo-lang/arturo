#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
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
    bundle/resources,
    env, 
    errors, 
    eval, 
    exec, 
    globals, 
    parse, 
    runtime,
    stack, 
    values/value, 
    values/printable,
    values/custom/verror
]

when not defined(WEB):
    import vm/profiler

#=======================================
# Packaging setup
#=======================================

# when defined(BUNDLE):
#     import json, sequtils, sugar

#     let js {.compileTime.} = parseJson(static getEnv("BUNDLE_MODULES"))
#     let bundledModules {.compileTime.} = toSeq(js).map((x) => x.getStr())
# else:
#     let bundledModules {.compileTime.}: seq[string] = @[]

#=======================================
# Macros
#=======================================

macro libraryModule(name: static[string]): untyped =
    let id = ident(name & "Lib")
    let libpath = ident("library/" & name)
    let libname = name.toUpperAscii()
    result = quote do:
        when not defined(BUNDLE) or BundleModules.contains(`name`):
            when defined(DEV):
                static: 
                    echo "-------------------------"
                    echo " ## " & `libname`
                    echo "-------------------------"
            import `libpath` as `id`
            LibraryModules[`name`] = `id`.defineModule

#=======================================
# Standard library setup
#=======================================

# TODO(VM/vm) don't completely eliminate unsupported functions
#  right now, if we have e.g. a MINI build, some - albeit few -
#  features are disabled. As a consequence, some functions cannot
#  work. For example, mysqlite is not available in MINI builds.
#  However, totally removing e.g. `open` - leads to confusing
#  situations, such as me using the function and all I can see
#  is that the identifier... "open" wasn't found.
#  Not very helpful at all, given that we could simply let people
#  know what is going on. That would obviously mean *not* completely
#  eliminating the function, only having it throw an error in case
#  some - or all - of its features are not supported.
#  Also, it would be a good idea to create sth like a macro(?) which
#  could combine the logic of `when defined(MINI)` (or whatever) +
#  the error handling part. Food for thought! ;-)
#  labels: vm, library, error handling, enhancement

libraryModule "Arithmetic"
libraryModule "Bitwise"
libraryModule "Collections"
libraryModule "Colors"
libraryModule "Comparison"
libraryModule "Core"
libraryModule "Crypto"
libraryModule "Databases"
libraryModule "Dates"
libraryModule "Exceptions"
libraryModule "Files"
libraryModule "Io"
libraryModule "Iterators"
libraryModule "Logic"
libraryModule "Net"
libraryModule "Numbers"
libraryModule "Paths"
libraryModule "Quantities"
libraryModule "Reflection"
libraryModule "Sets"
libraryModule "Sockets"
libraryModule "Statistics"
libraryModule "Strings"
libraryModule "System"
libraryModule "Types"
libraryModule "Ui"

#=======================================
# Variables
#=======================================

var
    initialized     : bool = false

#=======================================
# Helpers
#=======================================

proc setupLibrary() =
    for name, moduleDefinition in LibraryModules:
        moduleDefinition(name)

template initialize(args: seq[string], filename: string, isFile:bool, scriptData:Value = nil, mutedColors: bool = false, portableData = "") =
    # stack
    createMainStack()

    # attributes
    createAttrsStack()

    # frame stack
    createFrameStack()
    
    # random number generator
    randomize()

    # environment
    initEnv(
        arguments = args, 
        script = scriptData
    )

    when not defined(WEB):
        # configuration

        let currentDir = os.getCurrentDir()

        if os.fileExists(currentDir/"config.art"):
            Config = newStore(
                initStore(
                    currentDir/"config.art",
                    doLoad=false,
                    forceExtension=true,
                    createIfNotExists=false,
                    global=false,
                    autosave=true,
                    kind=NativeStore
                )
            )
        else:
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
        if isFile: 
            pushFrame(filename, fromFile=true)
        else: 
            pushFrame("")

    Syms = initTable[string,Value]()

    # library
    setupLibrary()

    # dumper
    Dumper = proc (v:Value):string =
        v.dumped()

    if portableData != "":
        when defined(BUNDLE):
            let bres = valueFromJson(portableData)

            echo "setting bundled resources"
            Bundled = bres.d
            echo Dumper(bres)

    # set VM as initialized
    initialized = true

template handleVMErrors(blk: untyped): untyped =
    try:
        blk
    except CatchableError, Defect:
        let e = getCurrentException()   
        showError(VError(e))

        when not defined(WEB):
            savePendingStores()

        try:
            let code = parseInt($(e.name))
            quit(code)
        except ValueError:
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
    
    proc run*(bl: proc()) =
        handleVMErrors:
            if not initialized:
                initialize(
                    @[], 
                    "", 
                    isFile=false, 
                    newBlock()
                )
            bl()

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
    