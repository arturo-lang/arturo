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

import os, strformat, strutils

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

proc isLocalFile*(src: string): bool =
    if src.fileExists():
        return true
    else:
        if (src & ".art").fileExists():
            return true
        else:
            return false

proc isLocalPackage*(src: string, version: VersionSpec): bool =
    let expectedPath = "{HomeDir}/.arturo/packages/cache/{src}".fmt
    if expectedPath.dirExists():
        return true
    else:
        return false

#=======================================
# Methods
#=======================================

proc getPackage*(src: string, version: VersionSpec): PackageKind {.inline.} =
    if src.isUrl():
        if ".pkgr.art" in src:
            return OfficialPackage
        else:
            return UserRepo
    elif isLocalFile(src):
        return LocalFile
    else:
        if isLocalPackage(src, version):
            return OfficialPackage
        else:
            return InvalidPackage

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