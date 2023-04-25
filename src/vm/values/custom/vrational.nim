#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/custom/vrational.nim
#=======================================================

## The internal `:rational` type

# Contains code based on
# the Rationals module: https://raw.githubusercontent.com/nim-lang/Nim/version-1-6/lib/pure/rationals.nim
# which forms part of the Nim standard library.
# (c) Copyright 2015 Dennis Felsing

#=======================================
# Libraries
#=======================================

import math, hashes

when not defined(NOGMP):
    import helpers/bignums

#=======================================
# Types
#=======================================

# TODO(VM/values/custom/vrational) add support for BigNum based rational numbers
#  see: https://discord.com/channels/765519132186640445/829324913097048065/1078783018187100341
#  labels: values, enhancement

type 
    VRationalObj*[T] = object
        num*: T
        den*: T

    RationalKind = enum
        NormalRational,
        BigRational

    VRational* = object
        case rKind*: RationalKind:
            of NormalRational:
                r*: VRationalObj[int]
            of BigRational:
                when not defined(NOGMP):
                    br*: Rat

#=======================================
# Methods
#=======================================

func reduce*(x: var VRational) =
    let common = gcd(x.r.num, x.r.den)
    if x.r.den > 0:
        x.r.num = x.r.num div common
        x.r.den = x.r.den div common
    elif x.r.den < 0:
        x.r.num = -x.r.num div common
        x.r.den = -x.r.den div common
    else:
        raise newException(DivByZeroDefect, "division by zero")

func initRational*(num, den: int): VRational =
    result.rKind = NormalRational
    result.r.num = num
    result.r.den = den
    reduce(result)

func `//`*(num, den: int): VRational =
    initRational(num, den)

func `$`*(x: VRational): string =
    if x.rKind == NormalRational:
        result = $x.r.num & "/" & $x.r.den
    else:
        when not defined(NOGMP):
            result = $x.br

func toRational*(x: int): VRational =
    result.rKind = NormalRational
    result.r.num = x
    result.r.den = 1

when not defined(NOGMP):
    func toBigRational*(x: int | float): VRational =
        result.rKind = BigRational
        result.br = newRat(x)

    func toBigRational*(x: VRational): VRational =
        result.rKind = BigRational
        result.br = newRat(x.r.num, x.r.den)

func toRational*(x: float, n: int = high(int) shr (sizeof(int) div 2 * 8)): VRational =
    var
        m11, m22 = 1
        m12, m21 = 0
        ai = int(x)
        x = x
    while m21 * ai + m22 <= n:
        swap m12, m11
        swap m22, m21
        m11 = m12 * ai + m11
        m21 = m22 * ai + m21
        if x == float(ai): break # division by zero
        x = 1 / (x - float(ai))
        if x > float(high(int32)): 
            when not defined(NOGMP):
                return toBigRational(x)
            else:
                break # representation failure; should throw error!
        ai = int(x)
    result = m11 // m21

func toFloat*(x: VRational): float =
    if x.rKind == NormalRational:
        result = x.r.num / x.r.den
    else:
        when not defined(NOGMP):
            result = toCDouble(x.br)

func toInt*(x: VRational): int =
    if x.rKind == NormalRational:
        result = x.r.num div x.r.den
    else:
        discard
        # show error

func `+`*(x, y: VRational): VRational =
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            let common = lcm(x.r.den, y.r.den)
            result.rKind = NormalRational
            result.r.num = common div x.r.den * x.r.num + common div y.r.den * y.r.num
            result.r.den = common
            reduce(result)
        else:
            result = x + toBigRational(y)
    else:
        if y.rKind == NormalRational:
            result = toBigRational(x) + y
        else:
            result = VRational(
                rKind: BigRational,
                br: x.br + y.br
            )

func `+`*(x: VRational, y: int): VRational =
    result.num = x.num + y * x.den
    result.den = x.den

func `+`*(x: int, y: VRational): VRational =
    result.num = x * y.den + y.num
    result.den = y.den

func `+=`*(x: var VRational, y: VRational) =
    let common = lcm(x.den, y.den)
    x.num = common div x.den * x.num + common div y.den * y.num
    x.den = common
    reduce(x)

func `+=`*(x: var VRational, y: int) =
    x.num += y * x.den

func `-`*(x: VRational): VRational =
    result.num = -x.num
    result.den = x.den

func `-`*(x, y: VRational): VRational =
    let common = lcm(x.den, y.den)
    result.num = common div x.den * x.num - common div y.den * y.num
    result.den = common
    reduce(result)

func `-`*(x: VRational, y: int): VRational =
    result.num = x.num - y * x.den
    result.den = x.den

func `-`*(x: int, y: VRational): VRational =
    result.num = x * y.den - y.num
    result.den = y.den

func `-=`*(x: var VRational, y: VRational) =
    let common = lcm(x.den, y.den)
    x.num = common div x.den * x.num - common div y.den * y.num
    x.den = common
    reduce(x)

func `-=`*(x: var VRational, y: int) =
    x.num -= y * x.den

func `*`*(x, y: VRational): VRational =
    result.num = x.num * y.num
    result.den = x.den * y.den
    reduce(result)

func `*`*(x: VRational, y: int): VRational =
    result.num = x.num * y
    result.den = x.den
    reduce(result)

func `*`*(x: int, y: VRational): VRational =
    result.num = x * y.num
    result.den = y.den
    reduce(result)

func `*=`*(x: var VRational, y: VRational) =
    x.num *= y.num
    x.den *= y.den
    reduce(x)

func `*=`*(x: var VRational, y: int) =
    x.num *= y
    reduce(x)

func reciprocal*(x: VRational): VRational =
    if x.num > 0:
        result.num = x.den
        result.den = x.num
    elif x.num < 0:
        result.num = -x.den
        result.den = -x.num
    else:
        raise newException(DivByZeroDefect, "division by zero")

func `/`*(x, y: VRational): VRational =
    result.num = x.num * y.den
    result.den = x.den * y.num
    reduce(result)

func `/`*(x: VRational, y: int): VRational =
    result.num = x.num
    result.den = x.den * y
    reduce(result)

func `/`*(x: int, y: VRational): VRational =
    result.num = x * y.den
    result.den = y.num
    reduce(result)

func `/=`*(x: var VRational, y: VRational) =
    x.num *= y.den
    x.den *= y.num
    reduce(x)

func `/=`*(x: var VRational, y: int) =
    x.den *= y
    reduce(x)

func `^`*(x: VRational, y: int): VRational =
    if y < 0:
        result.num = x.den ^ -y
        result.den = x.num ^ -y
    else:
        result.num = x.num ^ y
        result.den = x.den ^ y

func cmp*(x, y: VRational): int =
    (x - y).num

func `<`*(x, y: VRational): bool =
    (x - y).num < 0

func `<=`*(x, y: VRational): bool =
    (x - y).num <= 0

func `==`*(x, y: VRational): bool =
    (x - y).num == 0

func abs*(x: VRational): VRational =
    result.num = abs x.num
    result.den = abs x.den

func `div`*(x, y: VRational): int =
    (x.num * y.den) div (y.num * x.den)

func `mod`*(x, y: VRational): VRational =
    result = ((x.num * y.den) mod (y.num * x.den)) // (x.den * y.den)
    reduce(result)

func floorDiv*(x, y: VRational): int =
    floorDiv(x.num * y.den, y.num * x.den)

func floorMod*(x, y: VRational): VRational =
    result = floorMod(x.num * y.den, y.num * x.den) // (x.den * y.den)
    reduce(result)

func hash*(x: VRational): Hash =
    var copy = x
    reduce(copy)

    var h: Hash = 0
    h = h !& hash(copy.num)
    h = h !& hash(copy.den)
    result = !$h