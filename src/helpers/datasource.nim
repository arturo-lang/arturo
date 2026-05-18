#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/datasource.nim
#=======================================================

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import asyncdispatch, httpClient, os
    when defined(ssl):
        import std/net as netmod

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
        # TODO(Helpers/datasource) could we "download" files in Web mode?
        #  perhaps using Fetch?
        #  see: https://nim-lang.org/docs/jsfetch.html
        #  labels: library, enhancement, web
        when defined(PORTABLE):
            if SymExists("_portable") and GetSym("_portable").d.hasKey("embed") and GetSym("_portable").d["embed"].d.hasKey(src):
                return (GetSym("_portable").d["embed"].d[src].s, FileData)
                            
        if src.isUrl():
            # match `spawnAsyncReadUrl` / `spawnAsyncDownload`: use a
            # permissive SSL context. plain `newAsyncHttpClient()` hangs
            # on HTTPS hosts that redirect (google.com, raw.githubusercontent,
            # …) under the async client.
            when defined(ssl):
                let client = newAsyncHttpClient(
                    sslContext = netmod.newContext(verifyMode = CVerifyNone)
                )
            else:
                let client = newAsyncHttpClient()
            let content = waitFor client.getContent(src)
            result = (content, WebData)
        elif src.fileExists():
            result = (readFile(src), FileData)
        else:
            result = (src, TextData)
    else:
        result = (src, TextData)
