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
    RegularExpression* = (when defined(WEB): RegExp else: Regex)

#=======================================
# Methods
#=======================================

proc `$`*(rx: RegularExpression): string =
    when defined(WEB):
        $(rx)
    else:
        rx.pattern

proc newRegularExpression*(pattern: string): RegularExpression =
    when defined(WEB):
        newRegExp(cstring(pattern))
    else:
        re(pattern)

proc hash*(rx: RegularExpression): Hash =
    when defined(WEB):
        hash($(rx))
    else:
        hash(rx.pattern)