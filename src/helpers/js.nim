
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/js.nim
######################################################

# TODO(Helpers/js) Do we even need this?
#  Some of the functions in here were written by me and then included in Nim's stdlib. So, right now, they are like duplicates. If we don't need them at all - or the Helper module itself - we'd better remove it altogether.
#  labels: helpers, web, cleanup

#=======================================
# Libraries
#=======================================

import jsre

#=======================================
# Methods
#=======================================

func newRegExp(pattern: string, flags: string): RegExp =
    newRegExp(pattern.cstring, flags.cstring)

func replace*(pattern: cstring, self: RegExp, replacement: cstring): cstring {.importjs: "#.replace(#,#)".}
    ## Returns a new string with some or all matches of a pattern replaced by given replacement

func replace*(pattern: string, self: RegExp, replacement: string): cstring =
    replace(pattern.cstring, self, replacement.cstring)

func replaceAll*(pattern: cstring, self: RegExp, replacement: cstring): cstring {.importjs: "#.replaceAll(#,#)".}
    ## Returns a new string with all matches of a pattern replaced by given replacement