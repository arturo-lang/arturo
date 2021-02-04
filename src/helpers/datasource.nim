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

import helpers/url as UrlHelper

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
        let content = waitFor (newAsyncHttpClient().getContent(src))
        result = (content, WebData)
    elif src.fileExists():
        result = (readFile(src), FileData)
    else:
        result = (src, TextData)
