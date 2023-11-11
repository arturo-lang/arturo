#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/system.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os, strutils

#=======================================
# Constants
#=======================================

const
    systemArch = hostCPU.replace("i386","x86")
    systemOS = hostOS.replace("macosx","macos")
