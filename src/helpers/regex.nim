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

import hashes

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