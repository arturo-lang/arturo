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

import os, strutils, tables

import vm/[env, errors, eval, exec, globals, parse, value, version]

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
import library/Strings      as StringsLib
import library/System       as SystemLib
import library/Ui           as UiLib

#=======================================
# Types
#=======================================


#=======================================
# Globals
#=======================================


#=======================================
# Templates
#=======================================ar



#=======================================
# Helpers
#=======================================


#=======================================
# Methods
#=======================================

proc run*(code: var string, args: ValueArray, isFile: bool) =
    initEnv(
        arguments = args, 
        version = Version,
        build = Build
    )

    if isFile: env.addPath(code)
    else: env.addPath(getCurrentDir())

    syms = getEnvDictionary()

    ArithmeticLib.importSymbols()
    BinaryLib.importSymbols()
    CollectionsLib.importSymbols()
    ComparisonLib.importSymbols()
    ConvertersLib.importSymbols()
    CoreLib.importSymbols()
    CryptoLib.importSymbols()
    DatabasesLib.importSymbols()
    DatesLib.importSymbols()
    FilesLib.importSymbols()
    IoLib.importSymbols()
    IteratorsLib.importSymbols()
    LogicLib.importSymbols()
    NetLib.importSymbols()
    NumbersLib.importSymbols()
    PathsLib.importSymbols()
    ReflectionLib.importSymbols()
    StringsLib.importSymbols()
    SystemLib.importSymbols()
    UiLib.importSymbols()

    initVM()
    let parsed = doParse(move code, isFile)
    let evaled = parsed.doEval()
    discard doExec(evaled)
    showVMErrors()