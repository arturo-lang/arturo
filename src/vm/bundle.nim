#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/bundle.nim
#=======================================================

## Bundled executable manager

#=======================================
# Libraries
#=======================================

import algorithm, json, sugar, tables
import vm/[values/value]

#=======================================
# Compile-time
#=======================================

when defined(BUNDLE):
    let BundleJson {.compileTime.} = parseJson(static readFile(getEnv("BUNDLE_CONFIG")))

    let BundleMain*     {.compileTime.} = BundleJson["main"].readStr()
    let BundleImports*  {.compileTime.} = toDictionary((toSeq(BundleJson["imports"].pairs)).map((z) => (z[0], z[1].getStr())))
    let BundlePackages* {.compileTime.} = toDictionary((toSeq(BundleJson["packages"].pairs)).map((z) => (z[0], z[1].getStr())))
    let BundleSymbols*  {.compileTime.} = BundleJson["symbols"].getElems().map((z) => z.getStr())
    let BundleModules*  {.compileTime.} = BundleJson["modules"].getElems().map((z) => z.getStr())
else:
    let BundleSymbols*  {.compileTime.} : seq[string] = @[]
    let BundleModules*  {.compileTime.} : seq[string] = @[]

#=======================================
# Variables
#=======================================

var
    Bundle*: ValueDict

when defined(WEB):
    var stdout: string = ""

#=======================================
# Methods
#=======================================

proc getBundledResource*(identifier: string): Value =
    Bundled[identifier]
