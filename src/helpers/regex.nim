######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/regex.nim
######################################################

#=======================================
# Libraries
#=======================================

import hashes, strutils, tables

when defined(WEB):
    import jsre, sequtils, sugar
else:
    import nre except toSeq

#=======================================
# Types
#=======================================

type
    RegexObj* = (when defined(WEB): RegExp else: Regex)

#=======================================
# Helpers
#=======================================

proc escapeForRegex*(s: string): string =
    result = ""
    for c in items(s):
        case c:
            of 'a'..'z', 'A'..'Z', '0'..'9', '_':
                result.add(c)
            else:
                result.add("\\x")
                result.add(toHex(ord(c), 2))

#=======================================
# Methods
#=======================================

proc `$`*(rx: RegexObj): string =
    when defined(WEB):
        $(rx)
    else:
        rx.pattern

proc newRegexObj*(pattern: string): RegexObj =
    when defined(WEB):
        newRegExp(cstring(pattern))
    else:
        re(pattern)

proc contains*(str: string, rx: RegexObj): bool =
    when defined(WEB):
        cstring(str).contains(rx)
    else:
        nre.contains(str, rx)

proc contains*(str: string, rx: RegexObj, at: int): bool =
    let robj = newRegexObj(".{" & $(at) & "}" & $(rx))
    when defined(WEB):
        cstring(str).contains(robj)
    else:
        nre.contains(str, robj)

proc startsWith*(str: string, rx: RegexObj): bool =
    when defined(WEB):
        cstring(str).startsWith(rx)
    else:
        let match = str.find(rx)
        if not match.isNone:
            return match.get.matchBounds.a == 0
        else:
            return false

proc endsWith*(str: string, rx: RegexObj): bool =
    when defined(WEB):
        cstring(str).endsWith(rx)
    else:
        let match = str.find(rx)
        if not match.isNone:
            return match.get.matchBounds.b == str.len - 1
        else:
            return false

proc replaceAll*(str: string, rx: RegexObj, with: string): string =
    when defined(WEB):
        $(replace(cstring(str), rx, cstring(with)))
    else:
        nre.replace(str, rx, with)

proc split*(str: string, rx: RegexObj): seq[string] =
    when defined(WEB):
        cstring(str).split(rx).map(x => $(x))
    else:
        nre.split(str, rx)

proc matchAll*(str: string, rx: RegexObj): seq[string] =
    when defined(WEB):
        let globalR = rx
        rx.flags = "g"

        cstring(str).match(globalR).map(x => $(x))
    else:
        nre.findAll(str, rx)

proc matchAllGroups*(str: string, rx: RegexObj): Table[string,string] =
    when defined(WEB):
        discard
    else:
        let matches = nre.match(str, rx)
        if not matches.isNone:
            result = matches.get.captures.toTable

proc hash*(rx: RegexObj): Hash =
    when defined(WEB):
        hash($(rx))
    else:
        hash(rx.pattern)