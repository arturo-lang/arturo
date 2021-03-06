######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/templates.nim
######################################################

#=======================================
# Libraries
#=======================================

import strutils, unicode

import vm/value

#=======================================
# Methods
#=======================================

proc renderString*(s: string, reference: ValueDict): string =
    ""
