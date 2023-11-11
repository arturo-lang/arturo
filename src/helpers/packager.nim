#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/packager.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import algorithm, os, sequtils, strformat, tables

when not defined(WEB):
    import helpers/url

# when not defined(WEB):
#     import asyncdispatch, httpClient, os

# when defined(SAFE):
#     import vm/errors

# when not defined(WEB):
#     import helpers/url

# when defined(PORTABLE):
#     import tables
#     import vm/globals

import vm/[env, exec, parse]

import vm/values/custom/[vversion]

#=======================================
# Types
#=======================================

type
    VersionSpec* = (bool, VVersion)
    VersionLocation* = (string, VVersion)

#=======================================
# Constants
#=======================================

let
    NoPackageVersion* = VVersion(major: 0, minor: 0, patch: 0, extra: "")
    NoVersionLocation* = ("", NoPackageVersion)

    # DataSourceKind* = enum
    #     WebData,
    #     FileData,
    #     TextData

    # DataSource* = (string, DataSourceKind)

#=======================================
# Helpers
#=======================================

proc checkLocalFile*(src: string): (bool, string) =
    if src.fileExists():
        return (true, src)
    else:
        let srcWithExtension = src & ".art"
        if srcWithExtension.fileExists():
            return (true, srcWithExtension)
        else:
            return (false, src)

proc getLocalPackageVersions(inPath: string, ordered: SortOrder): seq[VersionLocation] =
    result = (toSeq(walkDir(inPath))).map(
            proc (vers: tuple[kind: PathComponent, path: string]): VersionLocation = 
                let filepath = vers.path
                let (_, name, ext) = splitFile(filepath)
                (filepath, newVVersion(name & ext))
        ).sorted(
            proc (a: VersionLocation, b: VersionLocation): int =
                cmp(a[1], b[1])
        , order=ordered)

proc getBestVersion(within: seq[VersionLocation], version: VersionSpec): VersionLocation =
    let checkingForMinimum = version[0]
    let checkingForVersion = version[1]

    for vers in within:
        if checkingForMinimum:
            if (vers[1] > checkingForVersion or vers[1] == checkingForVersion):
                return vers
        else:
            if vers[1] == checkingForVersion:
                return vers

    return NoVersionLocation

proc checkLocalPackage*(src: string, version: VersionSpec): (bool, VersionLocation) =
    let expectedPath = "{HomeDir}.arturo/packages/cache/{src}".fmt
    echo $expectedPath
    
    if expectedPath.dirExists():
        let got = getBestVersion(
            getLocalPackageVersions(expectedPath, SortOrder.Descending),
            version
        )
        return (got[0]!="", got)
    else:
        return (false, NoVersionLocation)

#=======================================
# Methods
#=======================================

proc installRemotePackage*(name: string, version: VersionSpec) =
    discard

proc verifyDependencies*(name: string, version: VVersion) =
    discard

proc getSourceFromRepo*(repo: string): string =
    echo "getSourceFromRepo: " & repo
    return ""

proc getSourceFromLocalFile*(path: string): string =
    return path

proc getEntryFileForPackage*(name: string, location: string, version: VVersion): string =
    let specFile = "{HomeDir}.arturo/packages/specs/{name}/{version}.art".fmt
    let specDict = execDictionary(doParse(specFile, isFile=true))
    
    return location & "/" & specDict["entry"].s

proc getPackageSource*(src: string, version: VersionSpec, latest: bool): string {.inline.} =
    var source = src

    if src.isUrl():
        return getSourceFromRepo(src)
    elif (let (isLocalFile, fileSrc)=checkLocalFile(src); isLocalFile):
        return getSourceFromLocalFile(fileSrc)
    else:
        if latest:
            return "latest"
        else:
            if (let (isLocalPackage, packageSource)=checkLocalPackage(src, version); isLocalPackage):
                let (packageLocation, packageVersion) = packageSource
                verifyDependencies(src, packageVersion)
                return getSourceFromLocalFile(
                    getEntryFileForPackage(src, packageLocation, packageVersion)
                )
            else:
                installRemotePackage(src, version)
                if (let (isLocalPackage, packageSource)=checkLocalPackage(src, version); isLocalPackage):
                    let (packageLocation, packageVersion) = packageSource
                    verifyDependencies(src, packageVersion)
                    return getSourceFromLocalFile(
                        getEntryFileForPackage(src, packageLocation, packageVersion)
                    )
                else:
                    echo "not found"
                    return ""


    # if src.isUrl():
    #     return UserRepo
    # elif isLocalFile(src):
    #     return LocalFile
    # else:
    #     if isLocalPackage(src, version):
    #         return OfficialPackage
    #     else:
    #         return InvalidPackage

# proc getType*(src: string): DataSource {.inline.} =
#     when not defined(WEB):
#         when defined(PORTABLE):
#             if SymExists("_portable") and GetSym("_portable").d.hasKey("embed") and GetSym("_portable").d["embed"].d.hasKey(src):
#                 return (GetSym("_portable").d["embed"].d[src].s, FileData)
                            
#         if src.isUrl():
#             when defined(SAFE): RuntimeError_OperationNotPermitted("read")
#             let content = waitFor (newAsyncHttpClient().getContent(src))
#             result = (content, WebData)
#         elif src.fileExists():
#             when defined(SAFE): RuntimeError_OperationNotPermitted("read")
#             result = (readFile(src), FileData)
#         else:
#             result = (src, TextData)
#     else:
#         result = (src, TextData)