######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/datasource.nim
######################################################

#=======================================
# Libraries
#=======================================

import asyncdispatch, httpClient, os

import helpers/url

import vm/errors

#=======================================
# Types
#=======================================

type
    DataSourceKind* = enum
        WebData,
        FileData,
        TextData

    DataSource* = (string, DataSourceKind)

#=======================================
# Methods
#=======================================

proc getSource*(src: string): DataSource {.inline.} =
    if src.isUrl():
        when defined(SAFE): RuntimeError_OperationNotPermitted("read")
        let content = waitFor (newAsyncHttpClient().getContent(src))
        result = (content, WebData)
    elif src.fileExists():
        when defined(SAFE): RuntimeError_OperationNotPermitted("read")
        result = (readFile(src), FileData)
    else:
        result = (src, TextData)
