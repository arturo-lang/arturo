#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/jsbignums.nim
#=======================================================

## Big Integer helpers for Web builds, on top of JS' BigInt.
##
## They are the counterpart of `helpers/bignums` (GMP),
## with the same names & semantics - so that the same code
## may work for both.

when not defined(WEB):
    {.error: "helpers/jsbignums is only meant for Web builds".}

#=======================================
# Libraries
#=======================================

import std/jsbigints

# (the in-place operators of `jsbigints` are left out: on object 
# fields - e.g. `x.bi *= y` - their JS output is broken)
export jsbigints except `+=`, `-=`, `*=`, `/=`, inc, dec

#=======================================
# Constants
#=======================================

# In Web builds, normal Integers are JS numbers,
# so they are exact only up to `Number.MAX_SAFE_INTEGER`
let
    MaxSafeInteger = big(9007199254740991'i64)
    MinSafeInteger = big(-9007199254740991'i64)

#=======================================
# Conversions
#=======================================

func toBig*(x: int): JsBigInt {.importjs: "BigInt(#)".}

func toFloat*(x: JsBigInt): float {.importjs: "Number(#)".}

func fitsSignedInt*(x: JsBigInt): bool {.inline.} =
    {.cast(noSideEffect).}:
        MinSafeInteger <= x and x <= MaxSafeInteger

func getSignedInt*(x: JsBigInt): int {.importjs: "Number(#)".}

func toString*(x: JsBigInt): string {.inline.} = $(toCstring(x))

#=======================================
# Comparisons (with Floating values)
#=======================================

func `==`*(x: JsBigInt, y: float): bool {.importjs: "(# == #)".}
func `==`*(x: float, y: JsBigInt): bool {.importjs: "(# == #)".}
func `<`*(x: JsBigInt, y: float): bool {.importjs: "(# < #)".}
func `<`*(x: float, y: JsBigInt): bool {.importjs: "(# < #)".}
func `<=`*(x: JsBigInt, y: float): bool {.importjs: "(# <= #)".}
func `<=`*(x: float, y: JsBigInt): bool {.importjs: "(# <= #)".}

#=======================================
# Arithmetic
#=======================================

# with Floating values

func `+`*(x: JsBigInt, y: float): float {.inline.} = toFloat(x) + y
func `+`*(x: float, y: JsBigInt): float {.inline.} = x + toFloat(y)
func `-`*(x: JsBigInt, y: float): float {.inline.} = toFloat(x) - y
func `-`*(x: float, y: JsBigInt): float {.inline.} = x - toFloat(y)
func `*`*(x: JsBigInt, y: float): float {.inline.} = toFloat(x) * y
func `*`*(x: float, y: JsBigInt): float {.inline.} = x * toFloat(y)
func `/`*(x: JsBigInt, y: float): float {.inline.} = toFloat(x) / y
func `/`*(x: float, y: JsBigInt): float {.inline.} = x / toFloat(y)

# between big Integers
# (`div` & `mod` truncate, as with GMP)

func neg*(x: JsBigInt): JsBigInt {.inline.} = -x

func `not`*(x: JsBigInt): JsBigInt {.inline.} = -x - big(1)

func pow*(x: JsBigInt, y: culong): JsBigInt {.inline.} = x ** big(y)
func pow*(x: float, y: JsBigInt): float {.importjs: "Math.pow(#, Number(#))".}
func pow*(x: JsBigInt, y: float): float {.importjs: "Math.pow(Number(#), #)".}

func `shl`*(x: JsBigInt, y: culong): JsBigInt {.inline.} = x shl big(y)
func `shr`*(x: JsBigInt, y: culong): JsBigInt {.inline.} = x shr big(y)

func `//`*(x, y: JsBigInt): JsBigInt =
    ## floor division (as GMP's `fdiv`)
    result = x div y
    if x mod y != big(0) and ((x < big(0)) != (y < big(0))):
        result = result - big(1)

func `//`*(x: int, y: JsBigInt): JsBigInt {.inline.} = toBig(x) // y

func divmod*(x, y: JsBigInt): (JsBigInt, JsBigInt) {.inline.} = (x div y, x mod y)
func divmod*(x: int, y: JsBigInt): (JsBigInt, JsBigInt) {.inline.} = divmod(toBig(x), y)
func divmod*(x: JsBigInt, y: int): (JsBigInt, JsBigInt) {.inline.} = divmod(x, toBig(y))

# in-place

func `+=`*(x: var JsBigInt, y: JsBigInt) {.inline.} = x = x + y
func `-=`*(x: var JsBigInt, y: JsBigInt) {.inline.} = x = x - y
func `*=`*(x: var JsBigInt, y: JsBigInt) {.inline.} = x = x * y
func inc*(x: var JsBigInt, y: int = 1) {.inline.} = x = x + toBig(y)
func dec*(x: var JsBigInt, y: int = 1) {.inline.} = x = x - toBig(y)

func negI*(x: var JsBigInt) {.inline.} = x = -x
func notI*(x: var JsBigInt) {.inline.} = x = not x
func divI*(x: var JsBigInt, y: JsBigInt) {.inline.} = x = x div y
func divI*(x: var JsBigInt, y: int) {.inline.} = x = x div toBig(y)
func modI*(x: var JsBigInt, y: JsBigInt) {.inline.} = x = x mod y
func powI*(x: var JsBigInt, y: culong) {.inline.} = x = pow(x, y)
func andI*(x: var JsBigInt, y: JsBigInt) {.inline.} = x = x and y
func orI*(x: var JsBigInt, y: JsBigInt) {.inline.} = x = x or y
func xorI*(x: var JsBigInt, y: JsBigInt) {.inline.} = x = x xor y
func shlI*(x: var JsBigInt, y: culong) {.inline.} = x = x shl y
func shrI*(x: var JsBigInt, y: culong) {.inline.} = x = x shr y

#=======================================
# Number theory
#=======================================

func abs*(x: JsBigInt): JsBigInt {.inline.} = 
    if x < big(0): -x else: x

func gcd*(x, y: JsBigInt): JsBigInt =
    var a = abs(x)
    var b = abs(y)
    while b != big(0):
        let t = b
        b = a mod b
        a = t
    a

func gcd*(x: int, y: JsBigInt): JsBigInt {.inline.} = gcd(toBig(x), y)
func gcd*(x: JsBigInt, y: int): JsBigInt {.inline.} = gcd(x, toBig(y))

func lcm*(x, y: JsBigInt): JsBigInt =
    if x == big(0) or y == big(0): big(0)
    else: abs(x div gcd(x, y) * y)

func lcm*(x: int, y: JsBigInt): JsBigInt {.inline.} = lcm(toBig(x), y)
func lcm*(x: JsBigInt, y: int): JsBigInt {.inline.} = lcm(x, toBig(y))

func exp*(x, y, m: JsBigInt): JsBigInt =
    ## modular exponentiation: (x ^ y) mod m
    ## (with the result's sign following `m`, as with GMP)
    if m == big(1) or m == big(-1): return big(0)
    var base = x mod m
    var e = y
    result = big(1)
    while e > big(0):
        if (e and big(1)) == big(1):
            result = (result * base) mod m
        e = e shr big(1)
        base = (base * base) mod m
    if result < big(0): result = result + abs(m)

func probablyPrime*(x: JsBigInt, n: cint): cint =
    ## Miller-Rabin test (with the first `n` primes as bases), 
    ## returning 0 (composite) or 1 (probably prime) - as with GMP
    const Bases = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
    if x < big(2): return 0
    for p in Bases:
        let bp = toBig(p)
        if x == bp: return 1
        if x mod bp == big(0): return 0
    var d = x - big(1)
    var r = 0
    while (d and big(1)) == big(0):
        d = d shr big(1)
        inc r
    for i, p in Bases:
        if i >= n: break
        var y = exp(toBig(p), d, x)
        if y == big(1) or y == x - big(1): continue
        var composite = true
        for _ in 1 ..< r:
            y = (y * y) mod x
            if y == x - big(1):
                composite = false
                break
        if composite: return 0
    return 1

#=======================================
# Bitwise operations (on normal Integers)
#=======================================

# JS' own bitwise operators work on 32 bits: for normal 
# Integers, we go through BigInt instead - with the same 
# 64-bit semantics as native builds

func bitAnd*(x, y: int): JsBigInt {.inline.} = toBig(x) and toBig(y)
func bitOr*(x, y: int): JsBigInt {.inline.} = toBig(x) or toBig(y)
func bitXor*(x, y: int): JsBigInt {.inline.} = toBig(x) xor toBig(y)
func bitNot*(x: int): JsBigInt {.inline.} = not toBig(x)
func bitShl*(x, y: int): JsBigInt {.inline.} = wrapToInt(toBig(x) shl toBig(y), 64)
func bitShr*(x, y: int): JsBigInt {.inline.} = toBig(x) shr toBig(y)
