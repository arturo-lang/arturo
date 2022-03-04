######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/url.nim
######################################################

#=======================================
# Libraries
#=======================================

import os, tables

import vm/values/value

#=======================================
# Methods
#=======================================

func parsePathComponents*(s: string): OrderedTable[string,Value] {.inline.} =
    var (dir, name, ext) = splitFile(s)

    result = {
        "directory": newString(dir),
        "basename": newString(name & ext),
        "filename": newString(name),
        "extension": newString(ext)
        }.toOrderedTable
