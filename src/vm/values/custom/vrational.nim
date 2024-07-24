#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/custom/VRational.nim
#=======================================================

## The internal `:rational` type

# Initially inspired by
# the Rationals module: https://raw.githubusercontent.com/nim-lang/Nim/version-1-6/lib/pure/rationals.nim
# which forms part of the Nim standard library.
# (c) Copyright 2015 Dennis Felsing

#=======================================
# Libraries
#=======================================

import hashes, math, strformat

import helpers/intrinsics

when defined(GMP):
    import helpers/bignums

import vm/errors

#=======================================
# Types
#=======================================

type 
    RationalMode* = enum
        CurrencyRational,
        TemperatureRational,
        RegularRational

    RationalKind* = enum
        NormalRational,
        BigRational

    VRational* = ref object
        case rKind*: RationalKind:
            of NormalRational:
                num*: int
                den*: int
            of BigRational:
                when defined(GMP):
                    br*: Rat

#=======================================
# Forward declarations
#=======================================

func toRational*(num, den: int): VRational {.inline.}
when defined(GMP):
    func toBigRational*(x: int | Int | float): VRational

func `/`*(x, y: VRational): VRational

#=======================================
# Helpers
#=======================================

template overflowGuard(main: untyped, alternative: untyped): untyped {.dirty.} =
    block overflowBlock:
        main
        return

    alternative

template tryOp(op: untyped): untyped =
    if unlikely(op): break overflowBlock

func reduce(x: var VRational) =
    let common = gcd(x.num, x.den)
    if x.den > 0:
        x.num = x.num div common
        x.den = x.den div common
    elif x.den < 0:
        x.num = -x.num div common
        x.den = -x.den div common
    else:
        Error_ZeroDenominator()
        #raise newException(DivByZeroDefect, "division by zero")

when defined(GMP):
    func simplifyRational(x: var VRational) =
        if x.rKind == BigRational and canBeSimplified(x.br):
            x = toRational(getInt(numerator(x.br)), getInt(denominator(x.br)))

func canBeCoerced*(x: VRational): bool =
    if x.rKind == NormalRational:
        let quotient = x.num / x.den
        return quotient == round(quotient, 10)
    else:
        when defined(GMP):
            let quotient = float64(float(toCDouble(numerator(x.br)) / toCDouble(denominator(x.br))))
            return quotient == round(quotient, 10)

# Public

func isZero*(x: VRational): bool =
    if x.rKind == NormalRational:
        result = x.num == 0
    else:
        when defined(GMP):
            result = numerator(x.br) == 0

func isNegative*(x: VRational): bool =
    if x.rKind == NormalRational:
        result = x.num < 0
    else:
        when defined(GMP):
            result = numerator(x.br) < 0

func isPositive*(x: VRational): bool =
    if x.rKind == NormalRational:
        result = x.num > 0
    else:
        when defined(GMP):
            result = numerator(x.br) > 0

#=======================================
# Templates
#=======================================

template getNumerator*(x: VRational, big: bool = false): untyped =
    when big and defined(GMP):
        numerator(x.br)
    else:
        x.num

template getDenominator*(x: VRational, big: bool = false): untyped =
    when big and defined(GMP):
        denominator(x.br)
    else:
        x.den

#=======================================
# Constructors
#=======================================

func copyRational*(rat: VRational): VRational {.inline.} =
    if rat.rKind == NormalRational:
        result = VRational(
            rKind: NormalRational,
            num: rat.num,
            den: rat.den
        )
    else:
        when defined(GMP):
            result = VRational(
                rKind: BigRational,
                br: copyRat(rat.br)
            )

func toRational*(num, den: int): VRational {.inline.} =
    # create VRational from numerator and denominator (both int's)
    result = VRational(
        rKind: NormalRational,
        num: num,
        den: den
    )
    reduce(result)

func `//`*(num, den: int): VRational {.inline.} =
    # alias for `toRational`
    toRational(num, den)

func toRational*(x: int): VRational =
    # create VRational from int
    result = VRational(
        rKind: NormalRational,
        num: x,
        den: 1
    )

func toRational*(x: float): VRational =
    # create VRational from float
    let n: int = high(int) shr (sizeof(int) div 2 * 8)
    var
        m11, m22 = 1
        m12, m21 = 0
        ai = int(x)
        x = x
    
    when defined(GMP):
        var initial = x
        
    while m21 * ai + m22 <= n:
        swap m12, m11
        swap m22, m21
        m11 = m12 * ai + m11
        m21 = m22 * ai + m21
        if x == float(ai): 
            break # division by zero
        x = 1 / (x - float(ai))
        if x > float(high(int32)): 
            when defined(GMP):
                if m11 == 0 or m21 == 0: 
                    return toBigRational(initial)
                else: 
                    break
            else:
                break # representation failure; should throw error?
        ai = int(x)
    result = toRational(m11, m21)

func toRational*(x: float, y: int | float): VRational =
    # create VRational from numerator and denominator (float and int or float)
    result = toRational(x) / toRational(y)

func toRational*(x: int, y: float): VRational =
    # create VRational from numerator and denominator (int and float)
    result = toRational(x) / toRational(y)

when defined(GMP):
    func toRational*(x: Int): VRational = 
        # create VRational from big Int
        result = VRational(
            rKind: BigRational,
            br: newRat(x)
        )

    func toRational*(x: Rat): VRational =
        # create VRational from Rat
        result = VRational(
            rKind: BigRational,
            br: x
        )

    func toRational*(num: Int, den: int): VRational =
        # create VRational from numerator and denominator (big Int - int)
        result = VRational(
            rKind: BigRational,
            br: newRat(num, newInt(den))
        )

    func toRational*(num: int, den: Int): VRational =
        # create VRational from numerator and denominator (int - big Int)
        result = VRational(
            rKind: BigRational,
            br: newRat(newInt(num), den)
        )

    func toRational*(num: Int, den: Int): VRational =
        # create VRational from numerator and denominator (big Int's)
        result = VRational(
            rKind: BigRational,
            br: newRat(num, den)
        )

    func toRational*(x: float, y: Int): VRational =
        # create VRational from numerator and denominator (float and big Int)
        result = toRational(x) / toRational(y)

    func toRational*(x: Int, y: float): VRational =
        # create VRational from numerator and denominator (big Int and float)
        result = toRational(x) / toRational(y)

    func toBigRational*(x: int | Int | float): VRational =
        # create VRational from int, big Int or float
        result = VRational(
            rKind: BigRational,
            br: newRat(x)
        )
        
        simplifyRational(result)

    func toBigRational*(x: VRational): VRational =
        # create an explicitly-big VRational from a VRational
        result = VRational(
            rKind: BigRational,
            br: newRat(x.num, x.den)
        )

        # we don't call `simplifyRational` here,
        # since this could again degrade it to a Normal rational!
        
#=======================================
# Converters
#=======================================

func toFloat*(x: VRational): float =
    if x.rKind == NormalRational:
        result = x.num / x.den
    else:
        when defined(GMP):
            result = toCDouble(x.br)

func toInt*(x: VRational): int =
    if x.rKind == NormalRational:
        result = x.num div x.den
    else:
        when defined(GMP):
            if canBeSimplified(x.br):
                result = getInt(numerator(x.br)) div getInt(denominator(x.br))
            else:
                raise newException(ValueError, "cannot convert to int")

#=======================================
# Arithmetic Operators
#=======================================

func `+`*(x, y: VRational): VRational =
    # add two VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            overflowGuard:
                result = VRational()
                let common = lcm(x.den, y.den)
                result.rKind = NormalRational
                #result.num = common div x.den * x.num + common div y.den * y.num
                let part1 = common div x.den * x.num
                let part2 = common div y.den * y.num
                tryOp: addIntWithOverflow(part1, part2, result.num)
                result.den = common
                reduce(result)
            do:
                when defined(GMP):
                    result = toBigRational(x) + y
        else:
            when defined(GMP):
                result = toBigRational(x) + y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                result = x + toBigRational(y)
            else:
                result = VRational(
                    rKind: BigRational,
                    br: x.br + y.br
                )

func `+`*(x: VRational, y: int): VRational =
    # add VRational and int
    if x.rKind == NormalRational:
        overflowGuard:
            result = VRational()
            result.rKind = NormalRational
            var m: int
            #result.num = x.num + y * x.den
            tryOp: mulIntWithOverflow(x.den, y, m)
            tryOp: addIntWithOverflow(x.num, m, result.num)
            result.den = x.den
            reduce(result)
        do:
            when defined(GMP):
                result = toBigRational(x) + y
    else:
        when defined(GMP):
            result = x + toBigRational(y)

func `+`*(x: VRational, y: float): VRational = 
    # add VRational and float
    x + toRational(y)

func `+`*(x: int, y: VRational): VRational {.inline.} =
    # add int and VRational
    y + x

when defined(GMP):
    func `+`*(x: VRational, y: Int): VRational =
        # add VRational and Int
        x + toRational(y)

    func `+`*(x: Int, y: VRational): VRational =
        # add Int and VRational
        toRational(x) + y

func `+=`*(x: var VRational, y: VRational) =
    # add two VRationals, in-place
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            overflowGuard:
                let common = lcm(x.den, y.den)
                #x.num = common div x.den * x.num + common div y.den * y.num
                let partOne = common div x.den * x.num
                let partTwo = common div y.den * y.num
                tryOp: addIntWithOverflowI(partOne, partTwo, x.num)
                x.den = common
                reduce(x)
            do:
                when defined(GMP):
                    x = toBigRational(x) + y
        else:
            when defined(GMP):
                x = toBigRational(x) + y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                x += toBigRational(y)
            else:
                x.br = x.br + y.br

func `+=`*(x: var VRational, y: int) =
    # add VRational and int, in-place
    if x.rKind == NormalRational:
        overflowGuard:
            #x.num += y * x.den
            var m: int
            tryOp: mulIntWithOverflow(y, x.den, m)
            tryOp: addIntWithOverflowI(x.num, m, x.num)
        do:
            when defined(GMP):
                x = toBigRational(x) + y
    else:
        when defined(GMP):
            x += toBigRational(y)

func `+=`*(x: var VRational, y: float) =
    # add VRational and float, in-place
    x += toRational(y)

when defined(GMP):
    func `+=`*(x: var VRational, y: Int) =
        # add VRational and Int, in-place
        x += toRational(y)

func `-`*(x: VRational): VRational =
    # negate a VRational
    if x.rKind == NormalRational:
        result = VRational(
            rKind: NormalRational,
            num: -x.num,
            den: x.den
        )
    else:
        when defined(GMP):
            result = VRational(
                rKind: BigRational,
                br: neg(x.br)
            )

func `-`*(x, y: VRational): VRational =
    # subtract two VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            overflowGuard:
                result = VRational()
                result.rKind = NormalRational
                let common = lcm(x.den, y.den)
                #result.num = common div x.den * x.num - common div y.den * y.num
                let part1 = common div x.den * x.num
                let part2 = common div y.den * y.num
                tryOp: subIntWithOverflow(part1, part2, result.num)
                result.den = common
                reduce(result)
            do:
                when defined(GMP):
                    result = toBigRational(x) - y
        else:
            when defined(GMP):
                result = toBigRational(x) - y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                result = x - toBigRational(y)
            else:
                result = VRational(
                    rKind: BigRational,
                    br: x.br - y.br
                )

func `-`*(x: VRational, y: int): VRational =
    # subtract int from VRational
    if x.rKind == NormalRational:
        overflowGuard:
            result = VRational()
            result.rKind = NormalRational
            #result.num = x.num - y * x.den
            var m: int
            tryOp: mulIntWithOverflow(y, x.den, m)
            tryOp: subIntWithOverflow(x.num, m, result.num)
            result.den = x.den
        do:
            when defined(GMP):
                result = toBigRational(x) - y
    else:
        when defined(GMP):
            result = x - toBigRational(y)

func `-`*(x: VRational, y: float): VRational = 
    # add VRational and float
    x - toRational(y)

func `-`*(x: int, y: VRational): VRational =
    # subtract VRational from int
    if y.rKind == NormalRational:
        overflowGuard:
            result = VRational()
            result.rKind = NormalRational
            #result.num = x * y.den - y.num
            var m: int
            tryOp: mulIntWithOverflow(x, y.den, m)
            tryOp: subIntWithOverflow(m, y.num, result.num)
            result.den = y.den
        do:
            when defined(GMP):
                result = x - toBigRational(y)
    else:
        when defined(GMP):
            result = toBigRational(x) - y

when defined(GMP):
    func `-`*(x: VRational, y: Int): VRational =
        # subtract Int from VRational
        x - toRational(y)

    func `-`*(x: Int, y: VRational): VRational =
        # subtract VRational from Int
        toRational(x) - y

func `-=`*(x: var VRational, y: VRational) =
    # subtract two VRationals, in-place
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            overflowGuard:
                let common = lcm(x.den, y.den)
                #x.num = common div x.den * x.num - common div y.den * y.num
                let partOne = common div x.den * x.num
                let partTwo = common div y.den * y.num
                tryOp: subIntWithOverflowI(partOne, partTwo, x.num)
                x.den = common
                reduce(x)
            do:
                when defined(GMP):
                    x = toBigRational(x) - y
        else:
            when defined(GMP):
                x = toBigRational(x) - y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                x -= toBigRational(y)
            else:
                x.br = x.br - y.br
    
func `-=`*(x: var VRational, y: int) =
    # subtract int from VRational, in-place
    if x.rKind == NormalRational:
        overflowGuard:
            # x.num -= y * x.den
            var m: int
            tryOp: mulIntWithOverflow(y, x.den, m)
            tryOp: subIntWithOverflowI(x.num, m, x.num)
        do:
            when defined(GMP):
                x = toBigRational(x) - y
    else:
        when defined(GMP):
            x -= toBigRational(y)

func `-=`*(x: var VRational, y: float) =
    # subtract float from VRational, in-place
    x -= toRational(y)

when defined(GMP):
    func `-=`*(x: var VRational, y: Int) =
        # subtract Int from VRational, in-place
        x -= toRational(y)

func `*`*(x, y: VRational): VRational =
    # multiply two VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            overflowGuard:
                result = VRational()
                result.rKind = NormalRational
                #result.num = x.num * y.num
                tryOp: mulIntWithOverflow(x.num, y.num, result.num)
                #result.den = x.den * y.den
                tryOp: mulIntWithOverflow(x.den, y.den, result.den)
                reduce(result)
            do:
                when defined(GMP):
                    result = toBigRational(x) * y
        else:
            when defined(GMP):
                result = toBigRational(x) * y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                result = x * toBigRational(y)
            else:
                result = VRational(
                    rKind: BigRational,
                    br: x.br * y.br
                )
    
func `*`*(x: VRational, y: int): VRational =
    # multiply VRational by int
    if x.rKind == NormalRational:
        overflowGuard:
            result = VRational()
            result.rKind = NormalRational
            tryOp: mulIntWithOverflow(x.num, y, result.num)
            #result.num = x.num * y
            result.den = x.den
            reduce(result)
        do:
            when defined(GMP):
                result = toBigRational(x) * y
    else:
        when defined(GMP):
            result = x * toBigRational(y)

func `*`*(x: VRational, y: float): VRational = 
    # multiply VRational by float
    x * toRational(y)

func `*`*(x: float, y: VRational): VRational = 
    # multiply float by VRational
    toRational(x) * y

func `*`*(x: int, y: VRational): VRational {.inline.} =
    # multiply int by VRational
    y * x

when defined(GMP):
    func `*`*(x: VRational, y: Int): VRational =
        # multiply VRational by Int
        x * toRational(y)

    func `*`*(x: Int, y: VRational): VRational =
        # multiply Int by VRational
        toRational(x) * y

func `*=`*(x: var VRational, y: VRational) =
    # multiply two VRationals, in-place
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            overflowGuard:
                var num, den: int
                #x.num *= y.num
                tryOp: mulIntWithOverflow(x.num, y.num, num)
                #x.den *= y.den
                tryOp: mulIntWithOverflow(x.den, y.den, den)
                x.num = num
                x.den = den

                reduce(x)
            do:
                when defined(GMP):
                    x = toBigRational(x) * y
        else:
            when defined(GMP):
                x = toBigRational(x) * y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                x *= toBigRational(y)
            else:
                x.br = x.br * y.br

func `*=`*(x: var VRational, y: int) =
    # multiply VRational by int, in-place
    if x.rKind == NormalRational:
        overflowGuard:
            #x.num *= y
            tryOp: mulIntWithOverflowI(x.num, y, x.num)
            reduce(x)
        do:
            when defined(GMP):
                x = toBigRational(x) * y
    else:
        when defined(GMP):
            x *= toBigRational(y)

func `*=`*(x: var VRational, y: float) = 
    # multiply VRational by float, in-place
    x *= toRational(y)

when defined(GMP):
    func `*=`*(x: var VRational, y: Int) =
        # multiply VRational by Int, in-place
        x *= toRational(y)

func `/`*(x, y: VRational): VRational =
    # divide two VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            overflowGuard:
                result = VRational()
                result.rKind = NormalRational
                #result.num = x.num * y.den
                tryOp: mulIntWithOverflow(x.num, y.den, result.num)
                #result.den = x.den * y.num
                tryOp: mulIntWithOverflow(x.den, y.num, result.den)
                reduce(result)
            do:
                when defined(GMP):
                    result = toBigRational(x) / y
        else:
            when defined(GMP):
                result = toBigRational(x) / y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                result = x / toBigRational(y)
            else:
                result = VRational(
                    rKind: BigRational,
                    br: x.br / y.br
                )

func `/`*(x: VRational, y: int): VRational =
    # divide VRational by int
    if x.rKind == NormalRational:
        overflowGuard:
            result = VRational()
            result.rKind = NormalRational
            result.num = x.num
            #result.den = x.den * y
            tryOp: mulIntWithOverflow(x.den, y, result.den)
            reduce(result)
        do:
            when defined(GMP):
                result = toBigRational(x) / y
    else:
        when defined(GMP):
            result = x / toBigRational(y)

func `/`*(x: int, y: VRational): VRational =
    # divide int by VRational
    if y.rKind == NormalRational:
        overflowGuard:
            result = VRational()
            result.rKind = NormalRational
            #result.num = x * y.den
            tryOp: mulIntWithOverflow(x, y.den, result.num)
            result.den = y.num
            reduce(result)
        do:
            when defined(GMP):
                result = toBigRational(x) / y
    else:
        when defined(GMP):
            result = toBigRational(x) / y

func `/`*(x: VRational, y: float): VRational = 
    # divide VRational by float
    x / toRational(y)

when defined(GMP):
    func `/`*(x: VRational, y: Int): VRational =
        # divide VRational by Int
        x / toRational(y)

    func `/`*(x: Int, y: VRational): VRational =
        # divide Int by VRational
        toRational(x) / y


func `/=`*(x: var VRational, y: VRational) =
    # divide two VRationals, in-place
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            overflowGuard:
                var num, den: int
                tryOp: mulIntWithOverflow(x.num, y.den, num)
                tryOp: mulIntWithOverflow(x.den, y.num, den)
                x.num = num
                x.den = den
                reduce(x)
            do:
                when defined(GMP):
                    x = toBigRational(x) / y
        else:
            when defined(GMP):
                x = toBigRational(x) / y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                x /= toBigRational(y)
            else:
                x.br = x.br / y.br

func `/=`*(x: var VRational, y: int) =
    # divide VRational by int, in-place
    if x.rKind == NormalRational:
        x.den *= y
        reduce(x)
    else:
        when defined(GMP):
            x /= toBigRational(y)

func `/=`*(x: var VRational, y: float) = 
    # divide VRational by float, in-place
    x /= toRational(y)

when defined(GMP):
    func `/=`*(x: var VRational, y: Int) =
        # divide VRational by Int, in-place
        x /= toRational(y)

func `div`*(x, y: VRational): int =
    # integer division of two VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            result = x.num * y.den div y.num * x.den
        else:
            raise newException(DivByZeroDefect, "div not supported")
    else:
        raise newException(DivByZeroDefect, "div not supported")

func `mod`*(x, y: VRational): VRational =
    # modulo of two VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            result = VRational()
            result.rKind = NormalRational
            result.num = (x.num * y.den) mod (y.num * x.den)
            result.den = x.den * y.den
            reduce(result)
        else:
            raise newException(DivByZeroDefect, "mod not supported")
    else:
        raise newException(DivByZeroDefect, "mod not supported")

func `^`*(x: VRational, y: int): VRational =
    # power of VRational with int exponent
    if x.rKind == NormalRational:
        overflowGuard:
            result = VRational()
            result.rKind = NormalRational
            if y < 0:
                tryOp: powIntWithOverflow(x.den, -y, result.num)
                tryOp: powIntWithOverflow(x.num, -y, result.den)
            else:
                tryOp: powIntWithOverflow(x.num, y, result.num)
                tryOp: powIntWithOverflow(x.den, y, result.den)
        do:
            when defined(GMP):
                result = toBigRational(x) ^ y
    else:
        when defined(GMP):
            result = VRational(
                rKind: BigRational,
                br: x.br ^ y
            )

func `^`*(x: VRational, y: float): VRational =
    # power of VRational with float exponent
    if x.rKind == NormalRational:
        let res = pow(toFloat(x), y)
        result = toRational(res)
    else:
        when defined(GMP):
            result = VRational(
                rKind: BigRational,
                br: x.br ^ y
            )

#=======================================
# Comparison Operators
#=======================================

func cmp*(x, y: VRational): int =
    # compare two VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            result = (x - y).num
        else:
            when defined(GMP):
                result = cmp(toBigRational(x), y)
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                result = cmp(x, toBigRational(y))
            else:
                result = cmp(x.br, y.br)

func `<`*(x, y: VRational): bool =
    # compare two VRationals, and 
    # check if `x` is less than `y`
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            result = (x - y).num < 0
        else:
            when defined(GMP):
                result = toBigRational(x) < y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                result = x < toBigRational(y)
            else:
                result = x.br < y.br

func `<=`*(x, y: VRational): bool =
    # compare two VRationals, and
    # check if `x` is less than or equal to `y`
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            result = (x - y).num <= 0
        else:
            when defined(GMP):
                result = toBigRational(x) <= y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                result = x <= toBigRational(y)
            else:
                result = x.br <= y.br

func `==`*(x, y: VRational): bool =
    # compare two VRationals, and
    # check if `x` is equal to `y`

    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            result = (x - y).num == 0
        else:
            when defined(GMP):
                result = toBigRational(x) == y
    else:
        when defined(GMP):
            if y.rKind == NormalRational:
                result = x == toBigRational(y)
            else:
                result = x.br == y.br

func `==`*(x: VRational, y: int): bool =
    if x.rKind == NormalRational:
        return (x.den == 1) and (x.num == y)
    else:
        when defined(GMP):
            return (denominator(x.br)==1) and (numerator(x.br)==y)

func `==`*(x: int, y: VRational): bool {.inline.} =
    return y == x

func `==`*(x: VRational, y: float): bool = 
    return toFloat(x) == y

func `==`*(x: float, y: VRational): bool {.inline.} =
    y == x

when defined(GMP):
    func `==`*(x: VRational, y: Int): bool =
        if x.rKind == NormalRational:
            return (x.den == 1) and (x.num == y)
        else:
            return (denominator(x.br)==1) and (numerator(x.br)==y)

    func `==`*(x: Int, y: VRational): bool =
        y == x

func `<`*(x: VRational, y: int): bool =
    return toFloat(x) < float(y)

func `<`*(x: int, y: VRational): bool =
    return float(x) < toFloat(y)

func `<`*(x: VRational, y: float): bool = 
    return toFloat(x) < y

func `<`*(x: float, y: VRational): bool =
    return x < toFloat(y)

when defined(GMP):
    func `<`*(x: VRational, y: Int): bool =
        return toFloat(x) < toCDouble(y)

    func `<`*(x: Int, y: VRational): bool =
        return toCDouble(x) < toFloat(y)

func `>`*(x: VRational, y: int): bool =
    return toFloat(x) > float(y)

func `>`*(x: int, y: VRational): bool =
    return float(x) > toFloat(y)

func `>`*(x: VRational, y: float): bool = 
    return toFloat(x) > y

func `>`*(x: float, y: VRational): bool =
    return x > toFloat(y)

when defined(GMP):
    func `>`*(x: VRational, y: Int): bool =
        return toFloat(x) > toCDouble(y)

    func `>`*(x: Int, y: VRational): bool =
        return toCDouble(x) > toFloat(y)

#=======================================
# Methods
#=======================================

func reciprocal*(x: VRational): VRational =
    # reciprocal of VRational
    if x.rKind == NormalRational:
        if x.num > 0:
            result = VRational(
                rKind: NormalRational,
                num: x.den,
                den: x.num
            )
        elif x.num < 0:
            result = VRational(
                rKind: NormalRational,
                num: -x.den,
                den: -x.num
            )
        else:
            raise newException(DivByZeroDefect, "division by zero")
    else:
        when defined(GMP):
            result.rKind = BigRational
            result.br = inv(x.br)

func abs*(x: VRational): VRational =
    # absolute value of VRational
    if x.rKind == NormalRational:
        result = VRational(
            rKind: NormalRational,
            num: abs(x.num),
            den: abs(x.den)
        )
    else:
        when defined(GMP):
            result = VRational(
                rKind: BigRational,
                br: abs(x.br)
            )

func neg*(x: VRational): VRational =
    # negation of VRational
    if x.rKind == NormalRational:
        result = VRational(
            rKind: NormalRational,
            num: -x.num,
            den: x.den
        )
    else:
        when defined(GMP):
            result = VRational(
                rKind: BigRational,
                br: neg(x.br)
            )

func floorDiv*(x, y: VRational): int =
    # floor division between given VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            result = floorDiv(x.num * y.den, y.num * x.den)
        else:
            raise newException(DivByZeroDefect, "floorDiv not supported")
    else:
        raise newException(DivByZeroDefect, "floorDiv not supported")

func floorMod*(x, y: VRational): VRational =
    # floor modulo between given VRationals
    if x.rKind == NormalRational:
        if y.rKind == NormalRational:
            result = VRational(
                rKind: NormalRational,
                num: floorMod(x.num * y.den, y.num * x.den),
                den: x.den * y.den
            )
            reduce(result)
        else:
            raise newException(DivByZeroDefect, "floorMod not supported")
    else:
        raise newException(DivByZeroDefect, "floorMod not supported")

#=======================================
# Hashing
#=======================================

func hash*(x: VRational): Hash =
    # calculate hash values for VRational
    if x.rKind == NormalRational:
        var copy = x
        reduce(copy)

        var h: Hash = 0
        h = h !& hash(copy.num)
        h = h !& hash(copy.den)
        result = !$h
    else:
        when defined(GMP):
            result = hash(x.br[])

#=======================================
# -> String
#=======================================

func codify*(x: VRational): string =
    # generate code for given VRational
    if x.rKind == NormalRational:
        if x.num < 0:
            result = fmt("to :rational @[neg {x.num * -1} {x.den}]")
        else:
            result = fmt("to :rational [{x.num} {x.den}]")
    else:
        when defined(GMP):
            let num = numerator(x.br)
            let den = denominator(x.br)
            if num < 0:
                result = fmt("to :rational @[neg {num * -1} {den}]")
            else:
                result = fmt("to :rational [{num} {den}]")

func `$`*(x: VRational): string =
    # convert VRational to string
    if x.rKind == NormalRational:
        result = $x.num & "/" & $x.den
    else:
        when defined(GMP):
            result = $x.br

func stringify*(x: VRational, mode: static RationalMode = RegularRational): string =
    # convert VRational to normalized string
    when mode == CurrencyRational:
        result = (toFloat(x)).formatFloat(ffDecimal, 2)
    elif mode == TemperatureRational:
        if x.rKind == NormalRational:
            if x.den == 1:
                result = $x.num
            else:
                result = (toFloat(x)).formatFloat(ffDecimal, 1)
        else:
            when defined(GMP):
                result = (toFloat(x)).formatFloat(ffDecimal, 1)
    else:
        if x.rKind == NormalRational:
            if x.den == 1:
                result = $x.num
            else:
                if x.canBeCoerced():
                    result = $(toFloat(x))
                else:
                    result = $x.num & "/" & $x.den
        else:
            when defined(GMP):
                if x.br.denominator == 1:
                    result = $x.br.numerator
                else:
                    if x.canBeCoerced:
                        result = $(toFloat(x))
                    else:
                        result = $x.br