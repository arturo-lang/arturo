
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/js.nim
######################################################

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

func delay*(time: cint) {.importjs: """
    await new Promise(done => setTimeout(() => done(), #));
"""}