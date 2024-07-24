#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/url.nim
#=======================================================

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import re
import strutils, tables, uri

import vm/values/value

#=======================================
# Methods
#=======================================

# TODO(Helpers/url) verify `isUrl` is working right & testing for valid URLs
#  Currently, our `isUrl` works with a RegEx - which looks pretty shady. If there's a better and more standards-compliant way to do it, we should - since lot's of things are based on this one.
#  labels: helpers, enhancement, open discussion

func isUrl*(s: string): bool {.inline.} =
    when not defined(WEB):
        
        return s.contains("localhost:") or s.match(re"^(?:http(s)?:\/\/)[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$")
    else:
        return false

func parseUrlComponents*(s: string): OrderedTable[string,Value] {.inline.} =
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
        
func urlencode*(s: string, encodeSpaces = false, encodeSlashes = false): string =
    result = newStringOfCap(s.len + s.len shr 2)
    let fromSpace = if encodeSpaces: "%20" else: "+"
    let fromSlash = if encodeSlashes: "%2F" else: "/"
    for c in s:
        case c
            of 'a'..'z', 'A'..'Z', '0'..'9', '-', '.', '_', '~': add(result, c)
            of ' ': add(result, fromSpace)
            of '/': add(result, fromSlash)
            else:
                add(result, '%')
                add(result, toHex(ord(c), 2))