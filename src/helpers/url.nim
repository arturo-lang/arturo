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

import re, tables, uri

import vm/value

#=======================================
# Methods
#=======================================

proc isUrl*(s: string): bool {.inline.} =
    return s.match(re"^(?:http(s)?:\/\/)[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$")

proc parseUrlComponents*(s: string): OrderedTable[string,Value] {.inline.} =
    var res = initUri()
    parseUri(s, res)

    result = {
        "scheme":   newString(res.scheme),
        "host":     newString(res.hostname),
        "port":     newString(res.port),
        "user":     newString(res.username),
        "password": newString(res.password),
        "path":     newString(res.path),
        "query":    newString(res.query),
        "anchor":   newString(res.anchor)
        }.toOrderedTable

    echo repr res