######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/version.nim
######################################################

#=======================================
# Libraries
#=======================================

import strutils

#=======================================
# Constants
#=======================================

const 
    Version* = static readFile("version/version").strip()
    Build* = static readFile("version/build").strip()

    VersionTxt* = "arturo v/" & Version
