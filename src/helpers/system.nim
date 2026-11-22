#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
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

when defined(WASI):
    # (for Nim, it's just Linux)
    const systemOs* = "wasi"
else:
    const systemOs* = hostOS.replace("macosx","macos")
