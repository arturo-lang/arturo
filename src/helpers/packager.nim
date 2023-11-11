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

import os, strformat

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

import vm/[env]

import vm/values/value

import vm/values/custom/[vversion]

#=======================================
# Types
#=======================================

type
    VersionConditionKind* = enum
        VersionEqual,
        VersionGreater,
        VersionGreaterOrEqual,
        VersionLess,
        VersionLessOrEqual

    VersionSpec* = (VersionConditionKind, VVersion)

    PackageKind* = enum
        OfficialPackage,
        UserRepo,
        LocalFile,
        InvalidPackage

#=======================================
# Constants
#=======================================

let
    LatestPackageVersion* = (VersionGreater, VVersion(major: 0, minor: 0, patch: 0, extra: ""))

    # DataSourceKind* = enum
    #     WebData,
    #     FileData,
    #     TextData

    # DataSource* = (string, DataSourceKind)

#=======================================
# Helpers
#=======================================

proc parseVersionCondition*(vsym: Value): VersionConditionKind =
    case vsym.m:
        of equal:
            return VersionEqual
        of greaterthan:
            return VersionGreater
        of greaterequal:
            return VersionGreaterOrEqual
        of lessthan:
            return VersionLess
        of equalless:
            return VersionLessOrEqual
        else:
            # shouldn't reach here
            return VersionEqual

proc checkLocalFile*(src: string): (bool, string) =
    if src.fileExists():
        return (true, src)
    else:
        let srcWithExtension = src & ".art"
        if srcWithExtension.fileExists():
            return (true, srcWithExtension)
        else:
            return (false, src)

proc checkLocalPackage*(src: string, version: VersionSpec): (bool, string) =
    let expectedPath = "{HomeDir}.arturo/packages/cache/{src}".fmt
    echo $expectedPath
    if expectedPath.dirExists():
        for vers in walkDir(expectedPath):
            echo $(vers)
            var (_, name, ext) = splitFile(vers.path)
            echo "-> " & name & "." & ext
        return (true, src)
    else:
        return (false, src)

proc isLocalPackage*(src: string, version: VersionSpec): bool =
    let expectedPath = "{HomeDir}/.arturo/packages/cache/{src}".fmt
    if expectedPath.dirExists():
        return true
    else:
        return false

# proc getPackageKind*(src: string): PackageKind {.inline.} =
#     if src.isUrl():
#         return UserRepo
#     elif isLocalFile(src):
#         return LocalFile
#     else:
#         if isLocalPackage(src,version)

#=======================================
# Methods
#=======================================

proc getSourceFromRepo*(repo: string): string =
    return "getSourceFromRepo: " & repo

proc getSourceFromLocalFile*(path: string): string =
    return "getSourceFromLocalFile: " & path

proc getPackageSource*(src: string, version: VersionSpec, latest: bool): string {.inline.} =
    var source = src

    # let pkgKind = getPackageKind(source)

    if src.isUrl():
        # user repo
        return getSourceFromRepo(src)
    elif (let (isLocalFile, fileSrc)=checkLocalFile(src); isLocalFile):
        return getSourceFromLocalFile(fileSrc)
    else:
        if latest:
            return "latest"
        else:
            if (let (isLocalPackage, fileSrc)=checkLocalPackage(src, version); isLocalPackage):
                return getSourceFromLocalFile("package / " & fileSrc)
            else:
                return "should check for remote repo"


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