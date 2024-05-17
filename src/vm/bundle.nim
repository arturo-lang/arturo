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

when defined(BUNDLE):
    import algorithm, json, os
    import sequtils, sugar, tables

    import vm/[values/value]

#=======================================
# Compile-time
#=======================================

when defined(BUNDLE):
    let BundleJson {.compileTime.} = parseJson(static readFile(getEnv("BUNDLE_CONFIG")))

    let BundleMain*     {.compileTime.} = BundleJson["main"].getStr()
    let BundleSymbols*  {.compileTime.} = BundleJson["symbols"].getElems().map((z) => z.getStr())
    let BundleModules*  {.compileTime.} = BundleJson["modules"].getElems().map((z) => z.getStr())
else:
    let BundleSymbols*  {.compileTime.} : seq[string] = @[]
    let BundleModules*  {.compileTime.} : seq[string] = @[]

#=======================================
# Constants
#=======================================

when defined(BUNDLE):
    const
        BundleImports       = static toTable((toSeq(BundleJson["imports"].pairs)).map((z) => (z[0], z[1].getStr())))
        BundlePackages      = static toTable((toSeq(BundleJson["packages"].pairs)).map((z) => (z[0], z[1].getStr())))

        NoResourceFound     = ""

#=======================================
# Variables
#=======================================

when defined(BUNDLE):
    var
        Bundled*: ValueDict

#=======================================
# Helpers
#=======================================

when defined(BUNDLE):
    proc checkImports(identifier: string): string =
        result = BundleImports.getOrDefault(identifier, NoResourceFound)
        if result == NoResourceFound:
            let (_, _, ext) = splitFile(identifier)
            if ext == "":
                result = BundleImports.getOrDefault(identifier & ".art", NoResourceFound)

    proc checkPackages(identifier: string): string =
        BundlePackages.getOrDefault(identifier, NoResourceFound)

#=======================================
# Methods
#=======================================

when defined(BUNDLE):
    proc getBundledResource*(identifier: string): string =
        let bundledResource = checkImports(identifier)
        if bundledResource != NoResourceFound:
            return bundledResource

        let bundledPackage = checkPackages(identifier)
        if bundledPackage != NoResourceFound:
            return checkImports(bundledPackage)

        return NoResourceFound
