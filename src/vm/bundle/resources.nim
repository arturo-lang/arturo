#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/bundle/resources.nim
#=======================================================

## Bundled resources manager

#=======================================
# Libraries
#=======================================

when defined(BUNDLE):
    import algorithm, json, os
    import sequtils, sugar, tables

    import vm/[values/value]

#=======================================
# Types
#=======================================

when defined(BUNDLE):
    type
        BundleResource* = tuple
            source  : string
            path    : string

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
        BundleFiles         = static toTable((toSeq(BundleJson["files"].pairs)).map((z) => (z[0], z[1].getStr())))
        BundleAliases       = static toTable((toSeq(BundleJson["aliases"].pairs)).map((z) => (z[0], z[1].getStr())))

        NoResourceFound*    = ("", "")

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
    proc resourceNotFound(res: BundleResource): bool =
        res[0] == ""

    proc checkFile(identifier: string): BundleResource =
        result = (BundleFiles.getOrDefault(identifier, ""), identifier)
        if result.resourceNotFound():
            let (_, _, ext) = splitFile(identifier)
            if ext == "":
                let withExtension = identifier & ".art"
                result = (BundleFiles.getOrDefault(withExtension, ""), withExtension)

    proc checkAlias(identifier: string): string =
        BundleAliases.getOrDefault(identifier, "")

#=======================================
# Methods
#=======================================

when defined(BUNDLE):
    proc getBundledResource*(identifier: string): BundleResource =
        let bundledResource = checkFile(identifier)
        if not bundledResource.resourceNotFound():
            return bundledResource

        let aliasedFile = checkAlias(identifier)
        if aliasedFile != "":
            result = checkFile(aliasedFile)
            result[1] = aliasedFile
            return
            
        return NoResourceFound
