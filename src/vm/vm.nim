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

import vm/[globals, env, errors, eval, exec, globals, parse, stack, value, version]

import library/Arithmetic   as ArithmeticLib
import library/Binary       as BinaryLib
import library/Collections  as CollectionsLib
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
import library/Strings      as StringsLib
import library/System       as SystemLib

when not defined(MINI):
    import library/Ui           as UiLib

#=======================================
# Helpers
#=======================================

proc initialize*() =
    # function arity
    Arities = initTable[string,int]()
    
    # stack
    createMainStack()

    # attributes
    createAttrsStack()
    
    # random number generator
    randomize()

proc setupLibrary*() =
    for importLibrary in Libraries:
        importLibrary()

#=======================================
# Methods
#=======================================

proc run*(code: var string, args: ValueArray, isFile: bool) =
    initialize()

    initEnv(
        arguments = args, 
        version = Version,
        build = Build
    )

    if isFile: env.addPath(code)
    else: env.addPath(getCurrentDir())

    Syms = getEnvDictionary()

    setupLibrary()

    let parsed = doParse(move code, isFile)
    let evaled = parsed.doEval()
    discard doExec(evaled)
    
    showVMErrors()
    