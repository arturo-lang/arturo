######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/vm.nim
######################################################

#=======================================
# Libraries
#=======================================

import os, random
import strutils, sugar, tables

when defined(WEB):
    import jsffi, std/json

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

when defined(PORTABLE):
    import json, sequtils

    let js {.compileTime.} = parseJson(static readFile(getEnv("PORTABLE_DATA")))
    let mods {.compileTime.} = toSeq(js["using"]["modules"]).map((x) => x.getStr())
else:
    let mods {.compileTime.}: seq[string] = @[]

when not defined(PORTABLE) or mods.contains("Arithmetic"):
    import library/Arithmetic   as ArithmeticLib

when not defined(PORTABLE) or mods.contains("Binary"):
    import library/Binary       as BinaryLib

when not defined(PORTABLE) or mods.contains("Collections"):
    import library/Collections  as CollectionsLib

when not defined(PORTABLE) or mods.contains("Colors"):
    import library/Colors       as ColorsLib

when not defined(PORTABLE) or mods.contains("Comparison"):
    import library/Comparison   as ComparisonLib

when not defined(PORTABLE) or mods.contains("Converters"):
    import library/Converters   as ConvertersLib

when not defined(PORTABLE) or mods.contains("Core"):
    import library/Core         as CoreLib

when not defined(PORTABLE) or mods.contains("Crypto"):
    import library/Crypto       as CryptoLib

when not defined(PORTABLE) or mods.contains("Databases"):
    import library/Databases    as DatabasesLib

when not defined(PORTABLE) or mods.contains("Dates"):
    import library/Dates        as DatesLib

when not defined(PORTABLE) or mods.contains("Files"):
    import library/Files        as FilesLib

when not defined(PORTABLE) or mods.contains("Io"):
    import library/Io           as IoLib

when not defined(PORTABLE) or mods.contains("Iterators"):
    import library/Iterators    as IteratorsLib

when not defined(PORTABLE) or mods.contains("Logic"):
    import library/Logic        as LogicLib

when not defined(PORTABLE) or mods.contains("Net"):
    import library/Net          as NetLib

when not defined(PORTABLE) or mods.contains("Numbers"):
    import library/Numbers      as NumbersLib

when not defined(PORTABLE) or mods.contains("Paths"):
    import library/Paths        as PathsLib

when not defined(PORTABLE) or mods.contains("Reflection"):
    import library/Reflection   as ReflectionLib

when not defined(PORTABLE) or mods.contains("Sets"):
    import library/Sets         as SetsLib

when not defined(PORTABLE) or mods.contains("Statistics"):
    import library/Statistics   as StatisticsLib

when not defined(PORTABLE) or mods.contains("Strings"):
    import library/Strings      as StringsLib

when not defined(PORTABLE) or mods.contains("System"):
    import library/System       as SystemLib

when not defined(PORTABLE) or mods.contains("Ui"):
    import library/Ui           as UiLib

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

    # TODO(VM\runBytecode) doesn't work properly - at least - on Windows
    #  labels: bug,critical,execution,vm,windows
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
    