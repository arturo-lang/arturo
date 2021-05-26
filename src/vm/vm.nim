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

import os, random, strutils, tables

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

import library/Arithmetic   as ArithmeticLib
import library/Binary       as BinaryLib
import library/Collections  as CollectionsLib
import library/Colors       as ColorsLib
import library/Comparison   as ComparisonLib
import library/Converters   as ConvertersLib
import library/Core         as CoreLib
import library/Crypto       as CryptoLib
import library/Databases    as DatabasesLib
import library/Dates        as DatesLib
import library/Files        as FilesLib
import library/Io           as IoLib
import library/Iterators    as IteratorsLib
import library/Logic        as LogicLib
import library/Net          as NetLib
import library/Numbers      as NumbersLib
import library/Paths        as PathsLib
import library/Reflection   as ReflectionLib
import library/Sets         as SetsLib
import library/Statistics   as StatisticsLib
import library/Strings      as StringsLib
import library/System       as SystemLib
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

template initialize*(args: seq[string], filename: string, isFile:bool, scriptInfo:ValueDict = initOrderedTable[string,Value](), mutedColors: bool = false) =
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
        script = scriptInfo
    )

    when not defined(WEB):
        # paths
        if isFile: env.addPath(filename)
        else: env.addPath(getCurrentDir())

    Syms = initOrderedTable[string,Value]()

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

    proc run*(code: var string, args: seq[string], isFile: bool, doExecute: bool = true): Translation {.exportc:"run".} =
        handleVMErrors:

            if isFile:
                when defined(SAFE):
                    CurrentFile = "main.art"
                else:
                    CurrentFile = lastPathPart(code)
            
            let (mainCode, scriptInfo) = doParseAll(code, isFile)

            if not initialized:
                initialize(
                    args, 
                    code, 
                    isFile=isFile, 
                    parseData(doParse(scriptInfo, false)).d
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

            let (mainCode, scriptInfo) = doParseAll(code, isFile=false)

            if not initialized:
                initialize(
                    @[""], 
                    code, 
                    isFile=false, 
                    parseData(doParse(scriptInfo, false)).d
                )

            let evaled = mainCode.doEval()

            Syms = doExec(evaled)

            var ret: Value = VNULL

            if SP>0:
                ret = sTop()
            
            return generateJsObject(ret)
    