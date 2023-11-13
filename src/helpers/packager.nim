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

import algorithm, sequtils, strformat, strutils, tables

when not defined(WEB):
    import asyncdispatch, httpClient, os

import extras/miniz

when not defined(WEB):
    import helpers/io
    import helpers/url

import vm/[env, exec, parse, values/types]

import vm/values/custom/[vsymbol, vversion]


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

proc loadLocalPackage(src: string, version: VersionSpec): (bool, string)
proc loadRemotePackage(src: string, version: VersionSpec): (bool, string)
proc verifyDependencies*(deps: seq[Value]): bool

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

proc checkLocalFolder*(src: string): (bool, string) =
    var mainSource = "{src}/main.art".fmt
    var allOk = true
    if src.dirExists():
        if ("{src}/info.art".fmt).fileExists():
            let infoArt = execDictionary(doParse("{src}/info.art".fmt, isFile=true))
            let entryPoint = infoArt["entry"].s
            if ("{src}/{entryPoint}.art".fmt).fileExists():
                mainSource = "{src}/{entryPoint}.art".fmt
            elif ("{src}/main.art".fmt).fileExists():
                discard
            else:
                allOk = false
            
            allOk = verifyDependencies(infoArt["depends"].a)
        elif ("{src}/main.art".fmt).fileExists():
            discard
        else:
            allOk = false
    else:
        allOk = false

    return (allOk, mainSource)

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
    #echo $expectedPath
    
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
    if not verifyDependencies(spec["depends"].a):
        return false
    let specFolder = "{HomeDir}.arturo/packages/specs/{name}".fmt
    stdout.write "- Installing package: {name} {actualVersion}".fmt
    createDir(specFolder)
    let specFile = "{specFolder}/{actualVersion}.art".fmt
    writeToFile(specFile, specContent)

    let pkgUrl = spec["url"].s
    let client = newHttpClient()
    createDir("{HomeDir}.arturo/tmp/".fmt)
    let tmpPkgZip = "{HomeDir}.arturo/tmp/pkg.zip".fmt
    client.downloadFile(pkgUrl, tmpPkgZip)
    createDir("{HomeDir}.arturo/packages/cache/{name}".fmt)
    let files = miniz.unzipAndGetFiles(tmpPkgZip, "{HomeDir}.arturo/packages/cache/{name}".fmt)
    let (actualSubFolder, _, _) = splitFile(files[0])
    let actualFolder = "{HomeDir}.arturo/packages/cache/{name}/{actualSubFolder}".fmt
    moveDir(actualFolder, "{HomeDir}.arturo/packages/cache/{name}/{actualVersion}".fmt)

    stdout.write " ✅\n"
    stdout.flushFile()
    return true

proc verifyDependencies*(deps: seq[Value]): bool = 
    var depList: seq[(string, VersionSpec)] = @[]

    for dep in deps:
        if dep.kind == Word or dep.kind == Literal or dep.kind == String:
            depList.add((dep.s, (false, NoPackageVersion)))
        elif dep.kind == Block:
            if dep.a[0].kind == Word or dep.a[0].kind == Literal or dep.a[0].kind == String:
                if dep.a.len == 1:
                    depList.add((dep.a[0].s, (false, NoPackageVersion)))
                elif dep.a.len == 2:
                    depList.add((dep.a[0].s, (false, dep.a[1].version)))
                elif dep.a.len == 3:
                    if dep.a[1].m == greaterequal or dep.a[1].m == greaterthan:
                        depList.add((dep.a[0].s, (true, dep.a[2].version)))
                    elif dep.a[1].m == equal:
                        depList.add((dep.a[0].s, (false, dep.a[2].version)))

    var allOk = true
    for dep in depList:
        let src = dep[0]
        let version = dep[1]
        if (let (ok, finalSource) = loadLocalPackage(src, version); ok):
            discard
        else:
            if (let (ok,finalSource) = loadRemotePackage(src,version); ok):
                discard
            else:
                echo "not found"
                allOk = false

    return allOk

proc getSourceFromRepo*(repo: string): string =
    let cleanName = repo.replace("https://github.com/","")
    let parts = cleanName.split("/")

    let folderPath = "{HomeDir}.arturo/tmp/{parts[1]}@{parts[0]}".fmt
    if not dirExists(folderPath):
        echo "folder not exists"
        let client = newHttpClient()
        let pkgUrl = "{repo}/archive/main.zip".fmt
        client.downloadFile(pkgUrl, "{HomeDir}.arturo/tmp/pkg.zip".fmt)
        echo "downloading file: {pkgUrl}".fmt
        echo "as: {HomeDir}.arturo/tmp/pkg.zip".fmt
        let files = miniz.unzipAndGetFiles("{HomeDir}.arturo/tmp/pkg.zip".fmt, "{HomeDir}.arturo/tmp".fmt)
        echo "unzipped: {HomeDir}.arturo/tmp/pkg.zip".fmt
        echo "into: {HomeDir}.arturo/tmp".fmt
        echo "and got: " & $(files)
        let (actualSubFolder, _, _) = splitFile(files[0])
        echo "actualSubFolder: {actualSubFolder}".fmt
        let actualFolder = "{HomeDir}.arturo/tmp/{actualSubFolder}".fmt
        echo "actualFolder: {actualFolder}".fmt
        moveDir(actualFolder, folderPath)

        discard tryRemoveFile("{HomeDir}.arturo/tmp/pkg.zip".fmt)

    let src = folderPath
    var allOk = false
    var mainSource = "{src}/main.art".fmt
    if ("{src}/info.art".fmt).fileExists():
        let infoArt = execDictionary(doParse("{src}/info.art".fmt, isFile=true))
        let entryPoint = infoArt["entry"].s
        if ("{src}/{entryPoint}.art".fmt).fileExists():
            mainSource = "{src}/{entryPoint}.art".fmt
        elif ("{src}/main.art".fmt).fileExists():
            discard
        else:
            allOk = false
        
        allOk = verifyDependencies(infoArt["depends"].a)
    elif ("{src}/main.art".fmt).fileExists():
        discard
    else:
        allOk = false

    if allOk:
        return mainSource
    
    return ""

proc getSourceFromLocalFile*(path: string): string =
    return path

proc getEntryFileForPackage*(location: string, spec: ValueDict): string =
    return location & "/" & spec["entry"].s

proc loadLocalPackage(src: string, version: VersionSpec): (bool, string) =
    if (let (isLocalPackage, packageSource)=checkLocalPackage(src, version); isLocalPackage):
        let (packageLocation, packageVersion) = packageSource
        stdout.write "- Loading local package: {src} {packageVersion}".fmt
        let packageSpec = readSpec(src, packageVersion)
        if not verifyDependencies(packageSpec["depends"].a):
            return (false, "")
        stdout.write " ✅\n"
        stdout.flushFile()
        return (true, getSourceFromLocalFile(
            getEntryFileForPackage(packageLocation, packageSpec)
        ))
    else:
        return (false, "")

proc loadRemotePackage(src: string, version: VersionSpec): (bool, string) =
    echo "- Querying remote packages...".fmt
    if installRemotePackage(src, version):
        return loadLocalPackage(src, version)
    else:
        return (false, "")

proc getPackageSource*(src: string, version: VersionSpec, latest: bool): string {.inline.} =
    var source = src

    if (let (isLocalFile, fileSrc)=checkLocalFile(src); isLocalFile):
        return getSourceFromLocalFile(fileSrc)
    elif (let (isLocalFolder, fileSrc)=checkLocalFolder(src); isLocalFolder):
        return getSourceFromLocalFile(fileSrc)
    elif src.isUrl():
        return getSourceFromRepo(src)
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