#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/intrinsics.nim
#=======================================================

#=======================================
# Libraries
#=======================================

#=======================================
# Constants
#=======================================

#=======================================
# Helpers
#=======================================


#=======================================
# Methods
#=======================================

# Arithmetics

when defined(bit32):
    func addIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_sadd_overflow", nodecl, nosideeffect.}
else:
    func addIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_saddll_overflow", nodecl, nosideeffect.}