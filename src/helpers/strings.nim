######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/string.nim
######################################################

#=======================================
# Libraries
#=======================================

import strutils, unicode

when not defined(MINI):
    import unidecode

#=======================================
# Methods
#=======================================

when not defined(MINI):
    proc convertToAscii*(input: string): string =
        return unidecode(input)

else:
    proc convertToAscii*(input: string): string =
        echo "- feature not supported in MINI builds"
        return ""

proc truncatePreserving*(s: string, at: int, with: string = "..."): string =
    result = s
    if runeLen(s) > at:
        var i = at
        while i > 0 and ($(result.runeAt(i)))[0] notin Whitespace: dec i
        dec i
        while i > 0 and ($(result.runeAt(i)))[0] in Whitespace: dec i
        setLen result, i+1
        result.add with

proc truncate*(s: string, at: int, with: string = "..."): string =
    result = s
    if runeLen(s) > (at + len(with)):
        setLen result, at+1
        result.add with
