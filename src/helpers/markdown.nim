######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: helpers/markdown.nim
######################################################

#=======================================
# Libraries
#=======================================

import extras/markdown

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

proc parseMarkdownInput*(input: string): Value =
    return newString(markdown(input))
