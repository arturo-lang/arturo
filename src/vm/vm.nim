######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/vm.nim
######################################################

#=======================================
# Libraries
#=======================================

import macros, os, random
import strutils, sugar, tables

when defined(WEB):
    import jsffi, json

import helpers/jsonobject

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
importLib "Binary"
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
importLib "Reflection"
importLib "Sets"
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

proc setupLibrary*() =
    for i,importLibrary in Libraries:
        importLibrary()

template initialize*(args: seq[string], filename: string, isFile:bool, scriptData:Value = VNULL, mutedColors: bool = false, portableData = "") =
    # function arity
    Arities = initTable[string,int]()
    # stack
    createMainStack()

    # attributes
    createAttrsStack()

    # TODO(VM/vm) Completely remove DoDebug code blocks?
    #  There seem to be various DoDebug code blocks that have been commented out. I honestly cannot remember what their purpose is and how they worked. Is it the right moment to simply... remove them?
    #  labels: vm, cleanup
    
    # # opstack
    # if DoDebug:
    #     OpStack[0] = opNop
    #     OpStack[1] = opNop
    #     OpStack[2] = opNop
    #     OpStack[3] = opNop
    #     OpStack[4] = opNop
    
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
        # paths
        if isFile: env.addPath(filename)
        else: env.addPath(getCurrentDir())

    Syms = initOrderedTable[string,Value]()

    if portableData != "":
        Syms["_portable"] = valueFromJson(portableData)

    # library
    setupLibrary()

    # set VM as initialized
    initialized = true

template handleVMErrors*(blk: untyped): untyped =
    try:
        blk
    except:
        let e = getCurrentException()
        showVMErrors(e)
        when not defined(PORTABLE):
            if DoDebug:
                dump(CurrentDump)
        if e.name == ProgramError:
            let code = parseInt(e.msg.split(";;")[1].split("<:>")[0])
            quit(code)
        else:
            quit(1)

#=======================================
# Methods
#=======================================

when not defined(WEB):

    proc runBytecode*(code: Translation, filename: string, args: seq[string]) =
        handleVMErrors:
            initialize(args, filename, isFile=true)

            discard doExec(code)

    proc run*(code: var string, args: seq[string], isFile: bool, doExecute: bool = true, debug: bool = false, withData=""): Translation {.exportc:"run".} =
        handleVMErrors:

            DoDebug = debug

            if isFile:
                when defined(SAFE):
                    CurrentFile = "main.art"
                else:
                    CurrentFile = lastPathPart(code)
                    CurrentPath = code
            
            let mainCode = doParse(code, isFile)

            if not initialized:
                initialize(
                    args, 
                    code, 
                    isFile=isFile, 
                    mainCode.data,
                    portableData=withData
                )

            let evaled = mainCode.doEval()

            if doExecute:
                discard doExec(evaled)

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

            let evaled = mainCode.doEval()

            Syms = doExec(evaled)

            var ret: Value = VNULL

            if SP>0:
                ret = sTop()
            
            return generateJsObject(ret)
    