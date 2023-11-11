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

import algorithm, sequtils, strformat, tables

when not defined(WEB):
    import helpers/url

when not defined(WEB):
    import asyncdispatch, httpClient, os

# when defined(SAFE):
#     import vm/errors

# when not defined(WEB):
#     import helpers/url

# when defined(PORTABLE):
#     import tables
#     import vm/globals

import helpers/io

import vm/[env, exec, parse, values/types]

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

proc readSpec(name: string, version: VVersion): ValueDict =
    let specFile = "{HomeDir}.arturo/packages/specs/{name}/{version}.art".fmt
    result = execDictionary(doParse(specFile, isFile=true))

proc readSpecFromContent(content: string): ValueDict =
    result = execDictionary(doParse(content, isFile=false))

proc installRemotePackage*(name: string, version: VersionSpec): bool =
    var packageSpec: string 
    if version[0]:
        packageSpec = "https://{name}.pkgr.art/spec".fmt
    else:
        packageSpec = "https://{name}.pkgr.art/{version[1]}/spec".fmt

    let specContent = waitFor (newAsyncHttpClient().getContent(packageSpec))
    let spec = readSpecFromContent(specContent)
    let actualVersion = spec["version"].version
    let specFolder = "{HomeDir}.arturo/packages/specs/{name}".fmt
    createDir(specFolder)
    let specFile = "{specFolder}/{actualVersion}.art".fmt
    writeToFile(specFile, specContent)
    
    return true

proc verifyDependencies*(name: string, version: VVersion) =
    discard

proc getSourceFromRepo*(repo: string): string =
    echo "getSourceFromRepo: " & repo
    return ""

proc getSourceFromLocalFile*(path: string): string =
    return path

proc getEntryFileForPackage*(location: string, spec: ValueDict): string =
    return location & "/" & spec["entry"].s

proc loadLocalPackage(src: string, version: VersionSpec): (bool, string) =
    if (let (isLocalPackage, packageSource)=checkLocalPackage(src, version); isLocalPackage):
        let (packageLocation, packageVersion) = packageSource
        let packageSpec = readSpec(src, packageVersion)
        verifyDependencies(src, packageVersion)
        return (true, getSourceFromLocalFile(
            getEntryFileForPackage(packageLocation, packageSpec)
        ))
    else:
        return (false, "")

proc loadRemotePackage(src: string, version: VersionSpec): (bool, string) =
    if installRemotePackage(src, version):
        return loadLocalPackage(src, version)
    else:
        return (false, "")

proc getPackageSource*(src: string, version: VersionSpec, latest: bool): string {.inline.} =
    var source = src

    if src.isUrl():
        return getSourceFromRepo(src)
    elif (let (isLocalFile, fileSrc)=checkLocalFile(src); isLocalFile):
        return getSourceFromLocalFile(fileSrc)
    else:
        if latest:
            if (let (ok,finalSource) = loadRemotePackage(src,version); ok):
                return finalSource
            else:
                echo "not found"
                return ""
        else:
            if (let (ok, finalSource) = loadLocalPackage(src, version); ok):
                return finalSource
            else:
                if (let (ok,finalSource) = loadRemotePackage(src,version); ok):
                    return finalSource
                else:
                    echo "not found"
                    return ""