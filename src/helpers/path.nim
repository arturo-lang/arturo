######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/url.nim
######################################################

#=======================================
# Libraries
#=======================================

import os, tables, uri

import vm/value

#=======================================
# Methods
#=======================================

proc parsePathComponents*(s: string): OrderedTable[string,Value] {.inline.} =
    var (dir, name, ext) = splitFile(s)

    result = {
        "directory": newString(dir),
        "basename": newString(name & "." & ext),
        "filename": newString(name),
        "extension": newString(ext)
        }.toOrderedTable

proc parseUrlComponents*(s: string): OrderedTable[string,Value] {.inline.} =
    var res = initUri()
    parseUri(s, res)

    result = {
        "scheme":   newString(res.scheme),
        "host":     newString(res.hostname),
        "port":     newString(res.port),
        "user":     newString(res.username),
        "password": newString(res.password),
        "path":     newString(res.password),
        "query":    newString(res.query),
        "anchor":   newString(res.anchor)
        }.toOrderedTable
