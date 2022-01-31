######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/datasource.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import asyncdispatch, httpClient, os

when defined(SAFE):
    import vm/errors

when not defined(WEB):
    import helpers/url

when defined(PORTABLE):
    import tables
    import vm/globals

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
    when not defined(WEB):
        when defined(PORTABLE):
            if Syms.hasKey("_portable") and Syms["_portable"].d.hasKey("embed") and Syms["_portable"].d["embed"].d.hasKey(src):
                return (Syms["_portable"].d["embed"].d[src].s, FileData)
                            
        if src.isUrl():
            when defined(SAFE): RuntimeError_OperationNotPermitted("read")
            let content = waitFor (newAsyncHttpClient().getContent(src))
            result = (content, WebData)
        elif src.fileExists():
            when defined(SAFE): RuntimeError_OperationNotPermitted("read")
            result = (readFile(src), FileData)
        else:
            result = (src, TextData)
    else:
        result = (src, TextData)
