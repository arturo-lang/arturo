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

import hashes, strutils

when defined(WEB):
    import jsre
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

proc split*(str: string, rx: RegexObj): seq[string] =
    when defined(WEB):
        cstring(str).split(rx)
    else:
        nre.split(str, rx)

proc hash*(rx: RegexObj): Hash =
    when defined(WEB):
        hash($(rx))
    else:
        hash(rx.pattern)