#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Channels.nim
#=======================================================

## The main Channels module
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/lib

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    when not defined(WEB):
        discard
