######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: vm/globals.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/value

#=======================================
# Super-Globals
#=======================================

var
    syms*{.threadvar.}: ValueDict