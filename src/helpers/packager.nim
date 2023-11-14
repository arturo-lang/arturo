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

import algorithm, options
import sequtils, strformat, strutils, tables

when not defined(WEB):
    import asyncdispatch, httpClient, os

import extras/miniz

when not defined(WEB):
    import helpers/io
    import helpers/terminal
    import helpers/url

import vm/[env, errors, exec, parse, values/types]

import vm/values/custom/[vsymbol, vversion]

#=======================================
# Types
#=======================================

type
    VersionSpec*        = tuple[min: bool, ver: VVersion]
    VersionLocation*    = tuple[loc: string, ver: VVersion]

#=======================================
# Constants
#=======================================

let
    NoPackageVersion*   = VVersion(major: 0, minor: 0, patch: 0, extra: "")
    NoVersionLocation*  = ("", NoPackageVersion)
    NoImportResult*     = (false, "")

const
    PackageFolder*      = "{HomeDir}.arturo/packages/"

    SpecLatestUrl*      = "https://{pkg}.pkgr.art/spec"
    SpecVersionUrl*     = "https://{pkg}.pkgr.art/{version}/spec"

    SpecFolder*         = PackageFolder & "specs/"
    SpecPackage*        = SpecFolder & "{pkg}/"
    SpecFile*           = SpecPackage & "{version}.art"

    CacheFolder*        = PackageFolder & "cache/"
    CachePackage*       = CacheFolder & "{pkg}/"
    CacheFiles*         = CachePackage & "{version}/"

#=======================================
# Global Variables
#=======================================

var
    VerbosePackager* = false

#=======================================
# Forward declarations
#=======================================

proc processLocalPackage(src: string, version: VersionSpec, latest: bool = false): Option[string]
proc processRemotePackage(src: string, version: VersionSpec): Option[string]
proc verifyDependencies*(deps: seq[Value]): bool

#=====================================
# Template
#=====================================

template hasDependencies(item: ValueDict): bool =
    (item.hasKey("depends") and item["depends"].kind == Block)

#=======================================
# Helpers
#=======================================

proc getEntryPointFromSourceFolder*(folder: string): Option[string] =
    ## In a supposed package source folder,
    ## look either for the 'entry' as defined in the package's info.art
    ## or a main.art file - our default entry point

    var entryPoint = "{folder}/main.art".fmt
    var allOk = true

    if (let infoPath = "{folder}/info.art".fmt; infoPath.fileExists()):
        let infoArt = execDictionary(doParse(infoPath, isFile=true))

        if infoArt.hasKey("entry"):
            let entryName = infoArt["entry"].s
            entryPoint = "{folder}/{entryName}.art".fmt

        if not entryPoint.fileExists():
            # should throw!
            allOk = false

        if infoArt.hasDependencies() and not verifyDependencies(infoArt["depends"].a):
            return

    if allOk:
        return some(entryPoint)

proc lookupLocalPackageVersion*(pkg: string, version: VersionSpec): Option[VersionLocation] =
    let packagesPath = CachePackage.fmt

    if packagesPath.dirExists():
        # Get all local versions
        let localVersions = (toSeq(walkDir(packagesPath))).map(
                proc (vers: tuple[kind: PathComponent, path: string]): VersionLocation = 
                    let filepath = vers.path
                    let (_, name, ext) = splitFile(filepath)
                    (filepath, newVVersion(name & ext))
            ).sorted(proc (a: VersionLocation, b: VersionLocation): int = cmp(a.ver, b.ver), order=SortOrder.Ascending)

        # Go through them and return the one - if any -
        # that matches the version specification we are looking for
        for found in localVersions:
            if version.min:
                if (found.ver > version.ver or found.ver == version.ver):
                    return some(found)
            else:
                if found.ver == version.ver:
                    return some(found)

proc readSpec(pkg: string, version: VVersion): ValueDict =
    let specFile = SpecFile.fmt
    result = execDictionary(doParse(specFile, isFile=true))

proc readSpecFromContent(content: string): ValueDict =
    result = execDictionary(doParse(content, isFile=false))

proc installRemotePackage*(pkg: string, verspec: VersionSpec): bool =
    var packageSpec: string 
    if verspec[0]:
        packageSpec = SpecLatestUrl.fmt
    else:
        let version = verspec[1]
        packageSpec = SpecVersionUrl.fmt

    var specContent: string
    try:
        specContent = waitFor (newAsyncHttpClient().getContent(packageSpec))
    except Exception:
        RuntimeError_PackageNotFound(pkg)

    let spec = readSpecFromContent(specContent)
    let actualVersion = spec["version"].version
    if spec.hasDependencies() and not verifyDependencies(spec["depends"].a):
        return false
    let specFolder = SpecPackage.fmt
    stdout.write "- Installing package: {pkg} {actualVersion}".fmt
    try:
        echo "calling: " & "https://pkgr.art/download.php?pkg={pkg}&ver={actualVersion}&mgk=18966".fmt
        discard waitFor (newAsyncHttpClient().getContent("https://pkgr.art/download.php?pkg={pkg}&ver={actualVersion}&mgk=18966".fmt))
    except Exception as e:
        echo "error!"
        echo $(e)
        discard
    createDir(specFolder)
    let specFile = "{specFolder}/{actualVersion}.art".fmt
    writeToFile(specFile, specContent)

    let pkgUrl = spec["url"].s
    let client = newHttpClient()
    createDir("{HomeDir}.arturo/tmp/".fmt)
    let tmpPkgZip = "{HomeDir}.arturo/tmp/pkg.zip".fmt
    client.downloadFile(pkgUrl, tmpPkgZip)
    createDir(CachePackage.fmt)
    let files = miniz.unzipAndGetFiles(tmpPkgZip, CachePackage.fmt)
    let (actualSubFolder, _, _) = splitFile(files[0])
    let actualFolder = "{HomeDir}.arturo/packages/cache/{pkg}/{actualSubFolder}".fmt
    let version = actualVersion
    moveDir(actualFolder, CacheFiles.fmt)

    discard tryRemoveFile("{HomeDir}.arturo/tmp/pkg.zip".fmt)

    stdout.write bold(greenColor) & " ✔" & resetColor() & "\n"
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
        if processLocalPackage(src, version).isSome:
            discard
        else:
            if processRemotePackage(src,version).isSome:
                discard
            else:
                allOk = false

    return allOk

#=====================================

proc processLocalFile(filePath: string): Option[string] =
    ## Check if file exists at given path
    ## or alternatively "file.art"

    if filePath.fileExists():
        return some(filePath)
    else:
        if (let fileWithExtension = filePath & ".art"; fileWithExtension.fileExists()):
            return some(fileWithExtension)

proc processLocalFolder(folderPath: string): Option[string] =
    ## Check if valid package folder exists 
    ## at given path and return entry filepath

    if folderPath.dirExists():
        return getEntryPointFromSourceFolder(folderPath)

proc processRemoteRepo(repo: string, latest: bool = false): Option[string] =
    ## Check remote github repo with an Arturo
    ## package in it and clone it locally

    let cleanName = repo.replace("https://github.com/","")
    let parts = cleanName.split("/")

    let folderPath = "{HomeDir}.arturo/tmp/{parts[1]}@{parts[0]}".fmt
    if (not dirExists(folderPath)) or latest:
        let client = newHttpClient()
        let pkgUrl = "{repo}/archive/main.zip".fmt
        client.downloadFile(pkgUrl, "{HomeDir}.arturo/tmp/pkg.zip".fmt)
        let files = miniz.unzipAndGetFiles("{HomeDir}.arturo/tmp/pkg.zip".fmt, "{HomeDir}.arturo/tmp".fmt)
        let (actualSubFolder, _, _) = splitFile(files[0])
        let actualFolder = "{HomeDir}.arturo/tmp/{actualSubFolder}".fmt
        moveDir(actualFolder, folderPath)

        discard tryRemoveFile("{HomeDir}.arturo/tmp/pkg.zip".fmt)

    return getEntryPointFromSourceFolder(folderPath)

proc processLocalPackage(src: string, version: VersionSpec, latest: bool = false): Option[string] =
    ## Check for local package installed in our home folder
    ## and return its entry point

    if latest:
        return processRemotePackage(src, version)

    if (let localPackage = lookupLocalPackageVersion(src, version); localPackage.isSome):
        let (packageLocation, packageVersion) = localPackage.get()
        stdout.write "- Loading local package: {src} {packageVersion}".fmt
        let packageSpec = readSpec(src, packageVersion)
        if packageSpec.hasDependencies() and not verifyDependencies(packageSpec["depends"].a):
            return

        stdout.write bold(greenColor) & " ✔" & resetColor() & "\n"
        stdout.flushFile()

        return some(packageLocation & "/" & packageSpec["entry"].s)

proc processRemotePackage(src: string, version: VersionSpec): Option[string] =
    ## Check if there is a remote package with the given name/specificiation
    ## in our registry

    echo "- Querying remote packages...".fmt
    if installRemotePackage(src, version):
        return processLocalPackage(src, version)

#=======================================
# Methods
#=======================================

proc getEntryForPackage*(
    pkg: string, 
    verspec: VersionSpec, 
    latest: bool,
    checkForFiles: bool = true
): Option[string] {.inline.} =
    ## Given a package name and a version specification
    ## try to find the best match and return
    ## the appropriate entry source filepath

    if checkForFiles:
        # is it a file?
        if (result = processLocalFile(pkg); result.isSome):
            return

        # maybe it's a folder with a "package" in it?
        if (result = processLocalFolder(pkg); result.isSome):
            return
    
    # maybe it's a github repository url?
    if pkg.isUrl():
        if (result = processRemoteRepo(pkg, latest); result.isSome):
            return

    # maybe it's a package we already have locally?
    if (result = processLocalPackage(pkg, verspec, latest); result.isSome):
        return
    else:
        # maybe it's a remote package we should fetch?
        if (result = processRemotePackage(pkg, verspec); result.isSome):
            return
