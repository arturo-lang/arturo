#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/intrinsics.nim
#=======================================================

#=======================================
# Helpers
#=======================================

when defined(bit32):
    func addIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_sadd_overflow", nodecl, nosideeffect.}
    func subIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_ssub_overflow", nodecl, nosideeffect.}
    func mulIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_smul_overflow", nodecl, nosideeffect.}
else:
    func addIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_saddll_overflow", nodecl, nosideeffect.}
    func subIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_ssubll_overflow", nodecl, nosideeffect.}
    func mulIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_smulll_overflow", nodecl, nosideeffect.}

#=======================================
# Methods
#=======================================

func powIntWithOverflow*(a,b:int, res: var int): bool =
    result = false
    case b:
        of 0: res = 1
        of 1: res = a
        of 2: result = mulIntWithOverflow(a, a, res)
        of 3: 
            result = mulIntWithOverflow(a, a, res)
            if not result:
                result = mulIntWithOverflow(a, res, res)
        else:
            var (x,y) = (a,b)
            res = 1
            while true:
                if (y and 1) != 0:
                    if mulIntWithOverflow(res, x, res):
                        return true
                y = y shr 1
                if y == 0:
                    break
                if mulIntWithOverflow(x, x, x):
                    return true