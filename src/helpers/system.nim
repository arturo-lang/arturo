#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/system.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import strutils

#=======================================
# Constants
#=======================================

const
    systemArch* = hostCPU.replace("i386","x86")
    systemOs* = hostOS.replace("macosx","macos")
