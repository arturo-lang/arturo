
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
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

func replace*(pattern: cstring, self: RegExp, replacement: cstring): cstring {.importjs: "#.replace(#,#)".}
  ## Returns a new string with some or all matches of a pattern replaced by given replacement

func replaceAll*(pattern: cstring, self: RegExp, replacement: cstring): cstring {.importjs: "#.replaceAll(#,#)".}
  ## Returns a new string with all matches of a pattern replaced by given replacement

func split*(pattern: cstring, self: RegExp, sep: cstring): seq[cstring] {.importjs: "#.split(#,#)".}
  ## Divides a string into an ordered list of substrings and returns the array

func match*(pattern: cstring, self: RegExp): seq[cstring] {.importjs: "#.match(#)".}
  ## Returns an array of matches of a RegExp against given string