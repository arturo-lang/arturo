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

import db_sqlite as sqlite

#=======================================
# Super-Globals
#=======================================

var
    MainDb*: sqlite.DbConn