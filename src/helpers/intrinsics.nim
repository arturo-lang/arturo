#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
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
    when not defined(WEB):
        func addIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_saddll_overflow", nodecl, nosideeffect.}
        func subIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_ssubll_overflow", nodecl, nosideeffect.}
        func mulIntWithOverflow*(a, b: int, res: var int): bool {.importc: "__builtin_smulll_overflow", nodecl, nosideeffect.}        
    else:
        # see: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/MAX_SAFE_INTEGER
        func isSafeInteger*(a: int): bool {.importjs: "Number.isSafeInteger(#)".}
        
        func addIntWithOverflow*(a, b: int, res: var int): bool =
            res = a + b
            return not isSafeInteger(res)

        func subIntWithOverflow*(a, b: int, res: var int): bool =
            res = a - b
            return not isSafeInteger(res)

        func mulIntWithOverflow*(a, b: int, res: var int): bool =
            res = a * b
            return not isSafeInteger(res)

#=======================================
# Methods
#=======================================

func powIntWithOverflow*(a, b: int, res: var int): bool =
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

# in-place

func addIntWithOverflowI*(a, b: int, res: var int): bool {.inline, nosideeffect.} =
    var subres: int
    if unlikely(addIntWithOverflow(a, b, subres)):
        return true
    else:
        res = subres
        return false

func subIntWithOverflowI*(a, b: int, res: var int): bool {.inline, nosideeffect.} =
    var subres: int
    if unlikely(subIntWithOverflow(a, b, subres)):
        return true
    else:
        res = subres
        return false

func mulIntWithOverflowI*(a, b: int, res: var int): bool {.inline, nosideeffect.} =
    var subres: int
    if unlikely(mulIntWithOverflow(a, b, subres)):
        return true
    else:
        res = subres
        return false

func powIntWithOverflowI*(a, b: int, res: var int): bool {.inline, nosideeffect.} =
    var subres: int
    if unlikely(powIntWithOverflow(a, b, subres)):
        return true
    else:
        res = subres
        return false