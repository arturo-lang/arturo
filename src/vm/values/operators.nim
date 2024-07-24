#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/operators.nim
#=======================================================

## Arithmetic & logical operators for Value objects.

#=======================================
# Libraries
#=======================================

import lenientops, macros, math, strutils, tables

when defined(WEB):
    import std/jsbigints

when defined(GMP):
    import helpers/bignums as BignumsHelper

import helpers/intrinsics

import vm/[globals, errors, stack]

import vm/values/types
import vm/values/value
import vm/values/printable

import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vquantity, vrange, vrational, vversion]

#=======================================
# Constants
#=======================================

const
    BignumSupport = defined(GMP) or defined(WEB)

#=======================================
# Pragmas
#=======================================

#{.push overflowChecks: on.}

#=======================================
# Forward declarations
#=======================================

proc `+`*(x: Value, y: Value): Value
proc `-`*(x: Value, y: Value): Value
proc `*`*(x: Value, y: Value): Value
proc `/`*(x: Value, y: Value): Value
proc `//`*(x: Value, y: Value): Value

#=======================================
# Macros
#=======================================

macro generateOperationA*(name: static[string], op: untyped, inplaceOp: untyped): untyped =
    ## generates the code necessary for arithmetic operations
    ## that only require one operand, e.g. `inc`
    let normalInteger =  ident("normalInteger" & ($name).capitalizeAscii())
    let normalIntegerI = ident("normalInteger" & ($name).capitalizeAscii() & "I")

    result = quote do:
        if xKind in {Literal,PathLiteral}: 
            ensureInPlaceAny()
            if normalIntegerOperation(inPlace=true):
                `normalIntegerI`(InPlaced)
            else:
                `inplaceOp`(InPlaced)
        elif normalIntegerOperation():
            push(`normalInteger`(x.i))
        else:
            push(`op`(x))

macro generateOperationB*(name: static[string], op: untyped, inplaceOp: untyped): untyped =
    ## generates the code necessary for arithmetic operations
    ## that require two operands, e.g. `add`
    let normalInteger =  ident("normalInteger" & ($name).capitalizeAscii())
    let normalIntegerI = ident("normalInteger" & ($name).capitalizeAscii() & "I")

    result = quote do:
        if xKind in {Literal,PathLiteral}: 
            ensureInPlaceAny()
            if normalIntegerOperation(inPlace=true):
                `normalIntegerI`(InPlaced, y.i)
            else:
                `inplaceOp`(InPlaced, y)
        elif normalIntegerOperation():
            push(`normalInteger`(x.i, y.i))
        else:
            push(`op`(x,y))

#=======================================
# Helpers
#=======================================

template toBig(v: untyped): untyped =
    when defined(WEB):
        big(v)
    else:
        v

template toNewBig(v: untyped): untyped =
    when defined(WEB):
        big(v)
    else:
        newInt(v)

template throwDivisionByZeroError(v: untyped): untyped =
    when v is int:
        Error_DivisionByZero(Dumper(newInteger(v)))
    elif v is float:
        Error_DivisionByZero(Dumper(newFloating(v)))
    elif v is VRational:
        Error_DivisionByZero(Dumper(newRational(v)))
    elif v is VComplex:
        Error_DivisionByZero(Dumper(newComplex(v)))
    else:
        when BignumSupport:
            when not defined(WEB):
                when v is Int:
                    Error_DivisionByZero(Dumper(newInteger(v)))
                else:
                    Error_DivisionByZero(Dumper(v))
            else:
                when v is JsBigInt:
                    Error_DivisionByZero(Dumper(newInteger(v)))
                else:
                    Error_DivisionByZero(Dumper(v))
        else:
            Error_DivisionByZero(Dumper(v))

template notZero(v: untyped): untyped =
    when v is VRational:
        if unlikely(isZero(v)):
            throwDivisionByZeroError(v)
    elif v is VComplex:
        if unlikely(v.re==0 and v.im==0):
            throwDivisionByZeroError(v)
    else:
        when defined(WEB):
            when v is JsBigInt:
                if unlikely(v==big(0)):
                    throwDivisionByZeroError(v)
            else:
                if unlikely(v==0):
                    throwDivisionByZeroError(v)
        else:
            if unlikely(v==0):
                throwDivisionByZeroError(v)
    v

proc invalidOperation(op: string, x: Value, y: Value = nil): Value =
    when not defined(WEB):
        if y.isNil:
            Error_InvalidOperation(op, valueKind(x, withBigInfo=true), "")
        else:
            Error_InvalidOperation(op, valueKind(x, withBigInfo=true), valueKind(y, withBigInfo=true))
    VNULL

template invalidOperation(op: string): untyped =
    when declared(y):
        invalidOperation(op, x, y)
    else:
        invalidOperation(op, x)

#=======================================
# Templates
#=======================================

template normalIntegerOperation*(inPlace=false): bool =
    ## check if both operands (x,y) are Integers, but not GMP-style BigNums
    when inPlace:
        let xKind {.inject.} = InPlaced.kind
        when declared(y):
            let yKind {.inject.} = y.kind
    else:
        when not declared(xKind):
            let xKind {.inject.} = x.kind
            when declared(y):
                let yKind {.inject.} = y.kind

    when inPlace:
        when declared(y):
            likely(xKind==Integer) and likely(InPlaced.iKind==NormalInteger) and likely(yKind==Integer) and likely(y.iKind==NormalInteger)
        else:
            likely(xKind==Integer) and likely(InPlaced.iKind==NormalInteger)
    else:
        when declared(y):
            likely(xKind==Integer) and likely(x.iKind==NormalInteger) and likely(yKind==Integer) and likely(y.iKind==NormalInteger)
        else:
            likely(xKind==Integer) and likely(x.iKind==NormalInteger)

template normalIntegerAdd*(x, y: int): untyped =
    ## add two normal Integer values, checking for overflow
    ## and return result
    var res: int
    if unlikely(addIntWithOverflow(x, y, res)):
        when BignumSupport:
            newInteger(toNewBig(x) + toBig(y))
        else:
            Error_IntegerOperationOverflow("add", Dumper(newInteger(x)), Dumper(newInteger(y)))
            VNULL
    else:
        newInteger(res)

template normalIntegerAddI*(x: var Value, y: int): untyped =
    ## add two normal Integer values, checking for overflow
    ## and set result in-place
    if unlikely(addIntWithOverflowI(x.i, y, x.i)):
        when BignumSupport:
            x = newInteger(toNewBig(x.i) + toBig(y))
        else:
            Error_IntegerOperationOverflow("add", Dumper(x), Dumper(newInteger(y)))

template normalIntegerInc*(x: int): untyped =
    ## increment a normal Integer value by 1, checking for overflow
    ## and return result
    var res: int
    if unlikely(addIntWithOverflow(x, 1, res)):
        when BignumSupport:
            newInteger(toNewBig(x) + toBig(1))
        else:
            Error_IntegerSingleOperationOverflow("inc", Dumper(newInteger(x)))
            VNULL
    else:
        newInteger(res)

template normalIntegerIncI*(x: var Value): untyped =
    ## increment a normal Integer value by 1, checking for overflow
    ## and set result in-place
    if unlikely(addIntWithOverflowI(x.i, 1, x.i)):
        when BignumSupport:
            x = newInteger(toNewBig(x.i) + toBig(1))
        else:
            Error_IntegerSingleOperationOverflow("inc", Dumper(x))

template normalIntegerSub*(x, y: int): untyped =
    ## subtract two normal Integer values, checking for overflow
    ## and return result
    var res: int
    if unlikely(subIntWithOverflow(x, y, res)):
        when BignumSupport:
            newInteger(toNewBig(x) - toBig(y))
        else:
            Error_IntegerOperationOverflow("sub", Dumper(newInteger(x)), Dumper(newInteger(y)))
            VNULL
    else:
        newInteger(res)

template normalIntegerSubI*(x: var Value, y: int): untyped =
    ## subtract two normal Integer values, checking for overflow
    ## and set result in-place
    if unlikely(subIntWithOverflowI(x.i, y, x.i)):
        when BignumSupport:
            x = newInteger(toNewBig(x.i) - toBig(y))
        else:
            Error_IntegerOperationOverflow("sub", Dumper(x), Dumper(newInteger(y)))

template normalIntegerDec*(x: int): untyped =
    ## decrement a normal Integer value by 1, checking for overflow
    ## and return result
    var res: int
    if unlikely(subIntWithOverflow(x, 1, res)):
        when BignumSupport:
            newInteger(toNewBig(x) - toBig(1))
        else:
            Error_IntegerSingleOperationOverflow("dec", Dumper(newInteger(x)))
            VNULL
    else:
        newInteger(res)

template normalIntegerDecI*(x: var Value): untyped =
    ## decrement a normal Integer value by 1, checking for overflow
    ## and set result in-place
    if unlikely(subIntWithOverflowI(x.i, 1, x.i)):
        when BignumSupport:
            x = newInteger(toNewBig(x.i) - toBig(1))
        else:
            Error_IntegerSingleOperationOverflow("dec", Dumper(x))

template normalIntegerMul*(x, y: int): untyped =
    ## multiply two normal Integer values, checking for overflow
    ## and return result
    var res: int
    if unlikely(mulIntWithOverflow(x, y, res)):
        when BignumSupport:
            newInteger(toNewBig(x) * toBig(y))
        else:
            Error_IntegerOperationOverflow("mul", Dumper(newInteger(x)), Dumper(newInteger(y)))
            VNULL
    else:
        newInteger(res)

template normalIntegerMulI*(x: var Value, y: int): untyped =
    ## multiply two normal Integer values, checking for overflow
    ## and set result in-place
    if unlikely(mulIntWithOverflowI(x.i, y, x.i)):
        when BignumSupport:
            x = newInteger(toNewBig(x.i) * toBig(y))
        else:
            Error_IntegerOperationOverflow("mul", Dumper(x), Dumper(newInteger(y)))

template normalIntegerNeg*(x: int): untyped =
    ## negate a normal Integer value, checking for overflow
    ## and return result
    var res: int
    if unlikely(mulIntWithOverflow(x, -1, res)):
        when BignumSupport:
            newInteger(toNewBig(x) * toBig(-1))
        else:
            Error_IntegerSingleOperationOverflow("neg", Dumper(newInteger(x)))
            VNULL
    else:
        newInteger(res)

template normalIntegerNegI*(x: var Value): untyped =
    ## negate a normal Integer value, checking for overflow
    ## and set result in-place
    if unlikely(mulIntWithOverflowI(x.i, -1, x.i)):
        when BignumSupport:
            x = newInteger(toNewBig(x.i) + toBig(-1))
        else:
            Error_IntegerSingleOperationOverflow("neg", Dumper(x))

template normalIntegerDiv*(x, y: int): untyped =
    ## divide (integer division) two normal Integer values, checking for DivisionByZero
    ## and return result
    newInteger(x div notZero(y))

template normalIntegerDivI*(x: var Value, y: int): untyped =
    ## divide (integer division) two normal Integer values, checking for DivisionByZero
    ## and set result in-place
    x = newInteger(x.i div notZero(y))

template normalIntegerFDiv*(x, y: int): untyped =
    ## divide (floating-point division) two normal Integer values, checking for DivisionByZero
    ## and return result
    newFloating(x / notZero(y))

template normalIntegerFDivI*(x: var Value, y: int): untyped =
    ## divide (floating-point division) two normal Integer values, checking for DivisionByZero
    ## and set result in-place
    x = newFloating(x.i / notZero(y))

template normalIntegerMod*(x, y: int): untyped =
    ## modulo two normal Integer values, checking for DivisionByZero
    ## and return result
    newInteger(x mod notZero(y))

template normalIntegerModI*(x: var Value, y: int): untyped =
    ## divide (floating-point division) two normal Integer values, checking for DivisionByZero
    ## and set result in-place
    x = newInteger(x.i mod notZero(y))

template normalIntegerDivMod*(x, y: int): untyped =
    ## divide+modulo (integer division) two normal Integer values, checking for DivisionByZero
    ## and return result
    let (quotient, remainder) = math.divmod(x, notZero(y))
    newBlock(@[newInteger(quotient), newInteger(remainder)])

template normalIntegerDivModI*(x: var Value, y: int): untyped =
    ## divide+modulo (integer division) two normal Integer values, checking for DivisionByZero
    ## and set result in-place
    let (quotient, remainder) = math.divmod(x.i, notZero(y))
    x = newBlock(@[newInteger(quotient), newInteger(remainder)])

template normalIntegerPow*(x, y: int): untyped =
    ## get the power of two normal Integer values, checking for overflow
    ## and return result
    if likely(y >= 0):
        var res: int
        if unlikely(powIntWithOverflow(x, y, res)):
            when defined(GMP):
                newInteger(pow(x, culong(y)))
            elif defined(WEB):
                newInteger(big(x) ** big(y))
            else:
                Error_IntegerOperationOverflow("pow", Dumper(newInteger(x)), Dumper(newInteger(y)))
                VNULL
        else:
            newInteger(res)
    else:
        newFloating(pow(float(x), float(y)))

template normalIntegerPowI*(x: var Value, y: int): untyped =
    ## get the power of two normal Integer values, checking for overflow
    ## and set result in-place
    if likely(y >= 0):
        if unlikely(powIntWithOverflowI(x.i, y, x.i)):
            when defined(GMP):
                x = newInteger(pow(x.i, culong(y)))
            elif defined(WEB):
                x = newInteger(big(x.i) ** big(y))  
            else:
                Error_IntegerOperationOverflow("pow", Dumper(x), Dumper(newInteger(y)))
    else:
        x = newFloating(pow(float(x.i), float(y)))

template normalIntegerAnd*(x, y: int): untyped =
    ## bitwise AND two normal Integer values
    ## and return result
    newInteger(x and y)

template normalIntegerAndI*(x: var Value, y: int): untyped =
    ## bitwise AND two normal Integer values
    ## and set result in-place
    x.i = x.i and y

template normalIntegerOr*(x, y: int): untyped =
    ## bitwise OR two normal Integer values
    ## and return result
    newInteger(x or y)

template normalIntegerOrI*(x: var Value, y: int): untyped =
    ## bitwise OR two normal Integer values
    ## and set result in-place
    x.i = x.i or y

template normalIntegerXor*(x, y: int): untyped =
    ## bitwise XOR two normal Integer values
    ## and return result
    newInteger(x xor y)

template normalIntegerXorI*(x: var Value, y: int): untyped =
    ## bitwise XOR two normal Integer values
    ## and set result in-place
    x.i = x.i xor y

template normalIntegerNot*(x: int): untyped =
    ## bitwise NOT of a normal Integer value
    ## and return result
    newInteger(not x)

template normalIntegerNotI*(x: var Value): untyped =
    ## bitwise NOT of a normal Integer value
    ## and set result in-place
    x.i = not x.i

template normalIntegerShl*(x, y: int): untyped =
    ## bitwise shift-left two normal Integer values
    ## and return result
    newInteger(x shl y)

template normalIntegerShlI*(x: var Value, y: int): untyped =
    ## bitwise shift-left two normal Integer values
    ## and set result in-place
    x.i = x.i shl y

template normalIntegerShr*(x, y: int): untyped =
    ## bitwise shift-right two normal Integer values
    ## and return result
    newInteger(x shr y)

template normalIntegerShrI*(x: var Value, y: int): untyped =
    ## bitwise shift-right two normal Integer values
    ## and set result in-place
    x.i = x.i shr y

template objectOperationOrNothing*(operation: string, mgkMeth: MagicMethod, oneparam: static bool = false, inplace: static bool = false): untyped =
    if x.kind == Object and x.magic.fetch(mgkMeth):
        when inplace:
            pushAttr("inplace", VTRUE)
        
        when oneparam:
            mgk(@[x])
        else:
            mgk(@[x, y])

        when not inplace:
            return stack.pop()
    else:
        when inplace:
            discard invalidOperation(operation)
        else:
            return invalidOperation(operation)

#=======================================
# Overloads
#=======================================

# TODO(VM/values/operators) [`+`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `+`*(x: Value, y: Value): Value =
    ## add given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerAdd(x.i, y.i)
        of Integer    || BigInteger     :   (when BignumSupport: return newInteger(toBig(x.i) + y.bi))
        of BigInteger || Integer        :   (when BignumSupport: return newInteger(x.bi + toBig(y.i)))
        of BigInteger || BigInteger     :   (when BignumSupport: return newInteger(x.bi + y.bi))
        of Integer    || Floating       :   return newFloating(x.i + y.f)
        of BigInteger || Floating       :   (when defined(GMP): return newFloating(x.bi + y.f))
        of Integer    || Rational       :   return newRational(x.i + y.rat)
        of BigInteger || Rational       :   (when defined(GMP): return newRational(x.bi + y.rat))
        of Integer    || Complex        :   return newComplex(float(x.i) + y.z)

        of Floating   || Integer        :   return newFloating(x.f + float(y.i))
        of Floating   || BigInteger     :   (when defined(GMP): return newFloating(x.f + y.bi))
        of Floating   || Floating       :   return newFloating(x.f + y.f)
        of Floating   || Rational       :   return newRational(toRational(x.f) + y.rat)
        of Floating   || Complex        :   return newComplex(x.f + y.z)

        of Rational   || Integer        :   return newRational(x.rat + y.i)
        of Rational   || BigInteger     :   (when defined(GMP): return newRational(x.rat + y.bi))
        of Rational   || Floating       :   return newRational(x.rat + toRational(y.f))
        of Rational   || Rational       :   return newRational(x.rat + y.rat)

        of Complex    || Integer        :   return newComplex(x.z + float(y.i))
        of Complex    || Floating       :   return newComplex(x.z + y.f)
        of Complex    || Rational       :   return newComplex(x.z + toFloat(y.rat))
        of Complex    || Complex        :   return newComplex(x.z + y.z)
        
        of Color      || Color          :   return newColor(x.l + y.l)
        of Quantity   || Integer        :   return newQuantity(x.q + y.i)
        of Quantity   || BigInteger     :   (when defined(GMP): return newQuantity(x.q + y.bi))
        of Quantity   || Floating       :   return newQuantity(x.q + y.f)
        of Quantity   || Rational       :   return newQuantity(x.q + y.rat)
        of Quantity   || Quantity       :   return newQuantity(x.q + y.q)
        else:
            objectOperationOrNothing("add", AddM)

proc `+=`*(x: var Value, y: Value) =
    ## add given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutating operation

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerAddI(x, y.i)
        of Integer    || BigInteger     :   (when BignumSupport: x = newInteger(toBig(x.i) + y.bi))
        of BigInteger || Integer        :   (when BignumSupport: x.bi += toBig(y.i))
        of BigInteger || BigInteger     :   (when BignumSupport: x.bi += y.bi)
        of Integer    || Floating       :   x = newFloating(x.i + y.f)
        of BigInteger || Floating       :   (when defined(GMP): x = newFloating(x.bi + y.f))
        of Integer    || Rational       :   x = newRational(x.i + y.rat)
        of BigInteger || Rational       :   (when defined(GMP): x = newRational(x.bi + y.rat))
        of Integer    || Complex        :   x = newComplex(float(x.i) + y.z)

        of Floating   || Integer        :   x.f += float(y.i)
        of Floating   || BigInteger     :   (when defined(GMP): x = newFloating(x.f + y.bi))
        of Floating   || Floating       :   x.f += y.f
        of Floating   || Rational       :   x = newRational(toRational(x.f) + y.rat)
        of Floating   || Complex        :   x = newComplex(x.f + y.z)

        of Rational   || Integer        :   x.rat += y.i
        of Rational   || BigInteger     :   (when defined(GMP): x.rat += y.bi)
        of Rational   || Floating       :   x.rat += toRational(y.f)
        of Rational   || Rational       :   x.rat += y.rat

        of Complex    || Integer        :   x.z += float(y.i)
        of Complex    || Floating       :   x.z += y.f
        of Complex    || Rational       :   x.z += toFloat(y.rat)
        of Complex    || Complex        :   x.z += y.z
        
        of Color      || Color          :   x.l += y.l
        of Quantity   || Integer        :   x.q += y.i
        of Quantity   || BigInteger     :   (when defined(GMP): x.q += y.bi)
        of Quantity   || Floating       :   x.q += y.f
        of Quantity   || Rational       :   x.q += y.rat
        of Quantity   || Quantity       :   x.q += y.q
        else:
            objectOperationOrNothing("add", AddM, inplace=true)

# TODO(VM/values/operators) [`inc`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc inc*(x: Value): Value =
    ## increment given value and return the result

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: return normalIntegerInc(x.i)
            else: (when BignumSupport: return newInteger(x.bi+toBig(1)))
        of Floating: return newFloating(x.f+1.0)
        of Rational: return newRational(x.rat+1)
        of Complex: return newComplex(x.z+1.0)
        of Quantity: return newQuantity(x.q + 1)
        else:
            objectOperationOrNothing("inc", IncM, oneparam=true)

proc incI*(x: var Value) =
    ## increment given value
    ## and store back the result
    ## 
    ## **Hint:** In-place, mutating operation

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: normalIntegerIncI(x)
            else: (when BignumSupport: inc(x.bi, 1))
        of Floating: x.f += 1.0
        of Rational: x.rat += 1
        of Complex: x.z = x.z + 1.0
        of Quantity: x.q += 1
        else:
            objectOperationOrNothing("inc", IncM, oneparam=true, inplace=true)

# TODO(VM/values/operators) [`-`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `-`*(x: Value, y: Value): Value = 
    ## subtract given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerSub(x.i, y.i)
        of Integer    || BigInteger     :   (when BignumSupport: return newInteger(toBig(x.i) - y.bi))
        of BigInteger || Integer        :   (when BignumSupport: return newInteger(x.bi - toBig(y.i)))
        of BigInteger || BigInteger     :   (when BignumSupport: return newInteger(x.bi - y.bi))
        of Integer    || Floating       :   return newFloating(x.i - y.f)
        of BigInteger || Floating       :   (when defined(GMP): return newFloating(x.bi - y.f))
        of Integer    || Rational       :   return newRational(x.i - y.rat)
        of BigInteger || Rational       :   (when defined(GMP): return newRational(x.bi - y.rat))
        of Integer    || Complex        :   return newComplex(float(x.i) - y.z)

        of Floating   || Integer        :   return newFloating(x.f - float(y.i))
        of Floating   || BigInteger     :   (when defined(GMP): return newFloating(x.f - y.bi))
        of Floating   || Floating       :   return newFloating(x.f - y.f)
        of Floating   || Rational       :   return newRational(toRational(x.f) - y.rat)
        of Floating   || Complex        :   return newComplex(x.f - y.z)

        of Rational   || Integer        :   return newRational(x.rat - y.i)
        of Rational   || BigInteger     :   (when defined(GMP): return newRational(x.rat - y.bi))
        of Rational   || Floating       :   return newRational(x.rat - toRational(y.f))
        of Rational   || Rational       :   return newRational(x.rat - y.rat)

        of Complex    || Integer        :   return newComplex(x.z - float(y.i))
        of Complex    || Floating       :   return newComplex(x.z - y.f)
        of Complex    || Rational       :   return newComplex(x.z - toFloat(y.rat))
        of Complex    || Complex        :   return newComplex(x.z - y.z)
        
        of Color      || Color          :   return newColor(x.l - y.l)
        of Quantity   || Integer        :   return newQuantity(x.q - y.i)
        of Quantity   || BigInteger     :   (when defined(GMP): return newQuantity(x.q - y.bi))
        of Quantity   || Floating       :   return newQuantity(x.q - y.f)
        of Quantity   || Rational       :   return newQuantity(x.q - y.rat)
        of Quantity   || Quantity       :   return newQuantity(x.q - y.q)
        else:
            objectOperationOrNothing("sub", SubM)

proc `-=`*(x: var Value, y: Value) = 
    ## subtract given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutating operation

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerSubI(x, y.i)
        of Integer    || BigInteger     :   (when BignumSupport: x = newInteger(toBig(x.i) - y.bi))
        of BigInteger || Integer        :   (when BignumSupport: x.bi -= toBig(y.i))
        of BigInteger || BigInteger     :   (when BignumSupport: x.bi -= y.bi)
        of Integer    || Floating       :   x = newFloating(x.i - y.f)
        of BigInteger || Floating       :   (when defined(GMP): x = newFloating(x.bi - y.f))
        of Integer    || Rational       :   x = newRational(x.i - y.rat)
        of BigInteger || Rational       :   (when defined(GMP): x = newRational(x.bi - y.rat))
        of Integer    || Complex        :   x = newComplex(float(x.i) - y.z)

        of Floating   || Integer        :   x.f -= float(y.i)
        of Floating   || BigInteger     :   (when defined(GMP): x = newFloating(x.f - y.bi))
        of Floating   || Floating       :   x.f -= y.f
        of Floating   || Rational       :   x = newRational(toRational(x.f) - y.rat)
        of Floating   || Complex        :   x = newComplex(x.f - y.z)

        of Rational   || Integer        :   x.rat -= y.i
        of Rational   || BigInteger     :   (when defined(GMP): x.rat -= y.bi)
        of Rational   || Floating       :   x.rat -= toRational(y.f)
        of Rational   || Rational       :   x.rat -= y.rat

        of Complex    || Integer        :   x.z -= float(y.i)
        of Complex    || Floating       :   x.z -= y.f
        of Complex    || Rational       :   x.z -= toFloat(y.rat)
        of Complex    || Complex        :   x.z -= y.z
        
        of Color      || Color          :   x.l -= y.l
        of Quantity   || Integer        :   x.q -= y.i
        of Quantity   || BigInteger     :   (when defined(GMP): x.q -= y.bi)
        of Quantity   || Floating       :   x.q -= y.f
        of Quantity   || Rational       :   x.q -= y.rat
        of Quantity   || Quantity       :   x.q -= y.q
        else:
            objectOperationOrNothing("sub", SubM, inplace=true)

# TODO(VM/values/operators) [`dec`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc dec*(x: Value): Value =
    ## decrement given value and return the result

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: return normalIntegerDec(x.i)
            else: (when BignumSupport: return newInteger(x.bi-toBig(1)))
        of Floating: return newFloating(x.f-1.0)
        of Rational: return newRational(x.rat-1)
        of Complex: return newComplex(x.z-1.0)
        of Quantity: return newQuantity(x.q - 1)
        else:
            objectOperationOrNothing("dec", DecM, oneparam=true)

proc decI*(x: var Value) =
    ## increment given value
    ## and store back the result
    ## 
    ## **Hint:** In-place, mutating operation

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: normalIntegerDecI(x)
            else: (when BignumSupport: dec(x.bi, 1))
        of Floating: x.f -= 1.0
        of Rational: x.rat -= 1
        of Complex: x.z = x.z - 1.0
        of Quantity: x.q -= 1
        else:
            objectOperationOrNothing("dec", DecM, oneparam=true, inplace=true)

# TODO(VM/values/operators) [`*`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `*`*(x: Value, y: Value): Value =
    ## multiply given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerMul(x.i, y.i)
        of Integer    || BigInteger     :   (when BignumSupport: return newInteger(toBig(x.i) * y.bi))
        of BigInteger || Integer        :   (when BignumSupport: return newInteger(x.bi * toBig(y.i)))
        of BigInteger || BigInteger     :   (when BignumSupport: return newInteger(x.bi * y.bi))
        of Integer    || Floating       :   return newFloating(x.i * y.f)
        of BigInteger || Floating       :   (when defined(GMP): return newFloating(x.bi * y.f))
        of Integer    || Rational       :   return newRational(x.i * y.rat)
        of BigInteger || Rational       :   (when defined(GMP): return newRational(x.bi * y.rat))
        of Integer    || Complex        :   return newComplex(float(x.i) * y.z)
        of Integer    || Quantity       :   return newQuantity(x.i * y.q)
        of BigInteger || Quantity       :   (when defined(GMP): return newQuantity(x.bi * y.q))
        of Integer    || Unit           :   return newQuantity(x, y.u)
        of BigInteger || Unit           :   (when defined(GMP): return newQuantity(x, y.u))

        of Floating   || Integer        :   return newFloating(x.f * float(y.i))
        of Floating   || BigInteger     :   (when defined(GMP): return newFloating(x.f * y.bi))
        of Floating   || Floating       :   return newFloating(x.f * y.f)
        of Floating   || Rational       :   return newRational(toRational(x.f) * y.rat)
        of Floating   || Complex        :   return newComplex(x.f * y.z)
        of Floating   || Quantity       :   return newQuantity(x.f * y.q)
        of Floating   || Unit           :   return newQuantity(x, y.u)

        of Rational   || Integer        :   return newRational(x.rat * y.i)
        of Rational   || BigInteger     :   (when defined(GMP): return newRational(x.rat * y.bi))
        of Rational   || Floating       :   return newRational(x.rat * toRational(y.f))
        of Rational   || Rational       :   return newRational(x.rat * y.rat)
        of Rational   || Quantity       :   return newQuantity(x.rat * y.q)
        of Rational   || Unit           :   return newQuantity(x, y.u)

        of Complex    || Integer        :   return newComplex(x.z * float(y.i))
        of Complex    || Floating       :   return newComplex(x.z * y.f)
        of Complex    || Rational       :   return newComplex(x.z * toFloat(y.rat))
        of Complex    || Complex        :   return newComplex(x.z * y.z)
        
        of Quantity   || Integer        :   return newQuantity(x.q * y.i)
        of Quantity   || BigInteger     :   (when defined(GMP): return newQuantity(x.q * y.bi))
        of Quantity   || Floating       :   return newQuantity(x.q * y.f)
        of Quantity   || Rational       :   return newQuantity(x.q * y.rat)
        of Quantity   || Quantity       :   return newQuantity(x.q * y.q)

        of Unit       || Integer        :   return newQuantity(y, x.u)
        of Unit       || BigInteger     :   (when defined(GMP): return newQuantity(y, x.u))
        of Unit       || Floating       :   return newQuantity(y, x.u)
        of Unit       || Rational       :   return newQuantity(y, x.u)
        of Unit       || Quantity       :   return newQuantity(y, x.u)
        of Unit       || Unit           :   return newUnit(flatten(x.u & y.u))

        else:
            objectOperationOrNothing("mul", MulM)

proc `*=`*(x: var Value, y: Value) =
    ## multiply given values
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerMulI(x, y.i)
        of Integer    || BigInteger     :   (when BignumSupport: x = newInteger(toBig(x.i) * y.bi))
        of BigInteger || Integer        :   (when BignumSupport: x.bi *= toBig(y.i))
        of BigInteger || BigInteger     :   (when BignumSupport: x.bi *= y.bi)
        of Integer    || Floating       :   x = newFloating(x.i * y.f)
        of BigInteger || Floating       :   (when defined(GMP): x = newFloating(x.bi * y.f))
        of Integer    || Rational       :   x = newRational(x.i * y.rat)
        of BigInteger || Rational       :   (when defined(GMP): x = newRational(x.bi * y.rat))
        of Integer    || Complex        :   x = newComplex(float(x.i) * y.z)
        of Integer    || Quantity       :   x = newQuantity(x.i * y.q)
        of BigInteger || Quantity       :   (when defined(GMP): x = newQuantity(x.bi * y.q))
        of Integer    || Unit           :   x = newQuantity(x, y.u)
        of BigInteger || Unit           :   (when defined(GMP): x = newQuantity(x, y.u))

        of Floating   || Integer        :   x.f *= float(y.i)
        of Floating   || BigInteger     :   (when defined(GMP): x = newFloating(x.f * y.bi))
        of Floating   || Floating       :   x.f *= y.f
        of Floating   || Rational       :   x = newRational(toRational(x.f) * y.rat)
        of Floating   || Complex        :   x = newComplex(x.f * y.z)
        of Floating   || Quantity       :   x = newQuantity(x.f * y.q)
        of Floating   || Unit           :   x = newQuantity(x, y.u)

        of Rational   || Integer        :   x.rat *= y.i
        of Rational   || BigInteger     :   (when defined(GMP): x.rat *= y.bi)
        of Rational   || Floating       :   x.rat *= toRational(y.f)
        of Rational   || Rational       :   x.rat *= y.rat
        of Rational   || Quantity       :   x = newQuantity(x.rat * y.q)
        of Rational   || Unit           :   x = newQuantity(x, y.u)

        of Complex    || Integer        :   x.z *= float(y.i)
        of Complex    || Floating       :   x.z *= y.f
        of Complex    || Rational       :   x.z *= toFloat(y.rat)
        of Complex    || Complex        :   x.z *= y.z
        
        of Quantity   || Integer        :   x.q *= y.i
        of Quantity   || BigInteger     :   (when defined(GMP): x.q *= y.bi)
        of Quantity   || Floating       :   x.q *= y.f
        of Quantity   || Rational       :   x.q *= y.rat
        of Quantity   || Quantity       :   x.q *= y.q

        of Unit       || Integer        :   x = newQuantity(y, x.u)
        of Unit       || BigInteger     :   (when defined(GMP): x = newQuantity(y, x.u))
        of Unit       || Floating       :   x = newQuantity(y, x.u)
        of Unit       || Rational       :   x = newQuantity(y, x.u)
        of Unit       || Quantity       :   x = newQuantity(y, x.u)
        of Unit       || Unit           :   x.u = flatten(x.u & y.u)

        else:
            objectOperationOrNothing("mul", MulM, inplace=true)

# TODO(VM/values/operators) [`neg`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc neg*(x: Value): Value =
    ## negate given value and return the result

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: return normalIntegerNeg(x.i)
            else: (when defined(GMP): return newInteger(neg(x.bi)))
        of Floating: return newFloating(x.f*(-1.0))
        of Rational: return newRational(neg(x.rat))
        of Complex: return newComplex(x.z*(-1.0))
        of Quantity: return newQuantity(x.q*(-1))
        else:
            objectOperationOrNothing("neg", NegM, oneparam=true)

proc negI*(x: var Value) =
    ## negate given value
    ## and store back the result
    ## 
    ## **Hint:** In-place, mutating operation

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: normalIntegerNegI(x)
            else: (when defined(GMP): negI(x.bi))
        of Floating: x.f *= -1.0
        of Rational: x.rat *= -1
        of Complex: x.z *= -1.0
        of Quantity: x.q *= -1
        else:
            objectOperationOrNothing("neg", NegM, oneparam=true, inplace=true)

# TODO(VM/values/operators) [`/`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `/`*(x: Value, y: Value): Value =
    ## divide (integer division) given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerDiv(x.i, y.i)
        of Integer    || BigInteger     :   (when BignumSupport: return newInteger(toBig(x.i) div notZero(y.bi)))
        of BigInteger || Integer        :   (when BignumSupport: return newInteger(x.bi div toBig(notZero(y.i))))
        of BigInteger || BigInteger     :   (when BignumSupport: return newInteger(x.bi div notZero(y.bi)))
        of Integer    || Floating       :   return newFloating(x.i / notZero(y.f))
        of BigInteger || Floating       :   (when defined(GMP): return newFloating(x.bi / notZero(y.f)))
        of Integer    || Rational       :   return newInteger(toRational(x.i) div notZero(y.rat))
        of BigInteger || Rational       :   (when defined(GMP): return newInteger(toRational(x.bi) div notZero(y.rat)))
        of Integer    || Complex        :   return newComplex(float(x.i) / notZero(y.z))

        of Floating   || Integer        :   return newFloating(x.f / float(notZero(y.i)))
        of Floating   || BigInteger     :   (when defined(GMP): return newFloating(x.f / notZero(y.bi)))
        of Floating   || Floating       :   return newFloating(x.f / notZero(y.f))
        of Floating   || Rational       :   return newInteger(toRational(x.f) div notZero(y.rat))
        of Floating   || Complex        :   return newComplex(x.f / notZero(y.z))

        of Rational   || Integer        :   return newRational(x.rat / toRational(notZero(y.i)))
        of Rational   || BigInteger     :   (when defined(GMP): return newRational(x.rat / toRational(notZero(y.bi))))
        of Rational   || Floating       :   return newRational(x.rat / toRational(notZero(y.f)))
        of Rational   || Rational       :   return newRational(x.rat / notZero(y.rat))

        of Complex    || Integer        :   return newComplex(x.z / float(notZero(y.i)))
        of Complex    || Floating       :   return newComplex(x.z / notZero(y.f))
        of Complex    || Rational       :   return newComplex(x.z / toFloat(notZero(y.rat)))
        of Complex    || Complex        :   return newComplex(x.z / notZero(y.z))
        
        of Quantity   || Integer        :   return newQuantity(x.q / y.i)
        of Quantity   || BigInteger     :   (when defined(GMP): return newQuantity(x.q / y.bi))
        of Quantity   || Floating       :   return newQuantity(x.q / y.f)
        of Quantity   || Rational       :   return newQuantity(x.q / y.rat)
        of Quantity   || Quantity       :   return newQuantity(x.q / y.q)
        else:
            objectOperationOrNothing("div", DivM)

proc `/=`*(x: var Value, y: Value) =
    ## divide (integer division) given values
    ## and store the result in the first one 
    ## 
    ## **Hint:** In-place, mutating operation

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerDivI(x, y.i)
        of Integer    || BigInteger     :   (when BignumSupport: x = newInteger(toBig(x.i) div notZero(y.bi)))
        of BigInteger || Integer        :   (when defined(GMP): divI(x.bi, notZero(y.i)))
        of BigInteger || BigInteger     :   (when defined(GMP): divI(x.bi, notZero(y.bi)))
        of Integer    || Floating       :   x = newFloating(x.i / notZero(y.f))
        of BigInteger || Floating       :   (when defined(GMP): x = newFloating(x.bi / notZero(y.f)))
        of Integer    || Rational       :   x = newInteger(toRational(x.i) div notZero(y.rat))
        of BigInteger || Rational       :   (when defined(GMP): x = newInteger(toRational(x.bi) div notZero(y.rat)))
        of Integer    || Complex        :   x = newComplex(float(x.i) / notZero(y.z))

        of Floating   || Integer        :   x.f /= float(notZero(y.i))
        of Floating   || BigInteger     :   (when defined(GMP): x = newFloating(x.f / notZero(y.bi)))
        of Floating   || Floating       :   x.f /= notZero(y.f)
        of Floating   || Rational       :   x = newInteger(toRational(x.f) div notZero(y.rat))
        of Floating   || Complex        :   x = newComplex(x.f / notZero(y.z))

        of Rational   || Integer        :   x.rat /= toRational(notZero(y.i))
        of Rational   || BigInteger     :   (when defined(GMP): x = newRational(x.rat / toRational(notZero(y.bi))))
        of Rational   || Floating       :   x.rat /= toRational(notZero(y.f))
        of Rational   || Rational       :   x.rat /= notZero(y.rat)

        of Complex    || Integer        :   x.z /= float(notZero(y.i))
        of Complex    || Floating       :   x.z /= notZero(y.f)
        of Complex    || Rational       :   x.z /= toFloat(notZero(y.rat))
        of Complex    || Complex        :   x.z /= notZero(y.z)
        
        of Quantity   || Integer        :   x.q /= y.i
        of Quantity   || BigInteger     :   (when defined(GMP): x.q /= y.bi)
        of Quantity   || Floating       :   x.q /= y.f
        of Quantity   || Rational       :   x.q /= y.rat
        of Quantity   || Quantity       :   x.q /= y.q
        else:
            objectOperationOrNothing("div", DivM, inplace=true)

# TODO(VM/values/operators) [`//`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `//`*(x: Value, y: Value): Value =
    ## divide (floating-point division) given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerFDiv(x.i, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): return newInteger(x.i // notZero(y.bi)))
        of Integer    || Floating       :   return newFloating(float(x.i) / notZero(y.f))
        of BigInteger || Floating       :   (when defined(GMP): return newFloating(x.bi / notZero(y.f)))
        of Integer    || Rational       :   return newRational(x.i / notZero(y.rat))
        of BigInteger || Rational       :   (when defined(GMP): return newRational(x.bi / notZero(y.rat)))

        of Floating   || Integer        :   return newFloating(x.f / float(notZero(y.i)))
        of Floating   || BigInteger     :   (when defined(GMP): return newFloating(x.f / notZero(y.bi)))
        of Floating   || Floating       :   return newFloating(x.f / notZero(y.f))
        of Floating   || Rational       :   return newRational(toRational(x.f) / notZero(y.rat))

        of Rational   || Integer        :   return newRational(x.rat / notZero(y.i))
        of Rational   || BigInteger     :   (when defined(GMP): return newRational(x.rat / toRational(notZero(y.bi))))
        of Rational   || Floating       :   return newRational(x.rat / toRational(notZero(y.f)))
        of Rational   || Rational       :   return newRational(x.rat / notZero(y.rat))
        
        of Quantity   || Integer        :   return newQuantity(x.q // y.i)
        of Quantity   || BigInteger     :   (when defined(GMP): return newQuantity(x.q // y.bi))
        of Quantity   || Floating       :   return newQuantity(x.q // y.f)
        of Quantity   || Rational       :   return newQuantity(x.q // y.rat)
        of Quantity   || Quantity       :   return newQuantity(x.q // y.q)
        else:
            objectOperationOrNothing("fdiv", FDivM)

proc `//=`*(x: var Value, y: Value) =
    ## divide (floating-point division) given values
    ## and store the result in the first one 
    ## 
    ## **Hint:** In-place, mutating operation
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerFDivI(x, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): x = newInteger(x.i // notZero(y.bi)))
        of Integer    || Floating       :   x = newFloating(float(x.i) / notZero(y.f))
        of BigInteger || Floating       :   (when defined(GMP): x = newFloating(x.bi / notZero(y.f)))
        of Integer    || Rational       :   x = newRational(x.i / notZero(y.rat))
        of BigInteger || Rational       :   (when defined(GMP): x = newRational(x.bi / notZero(y.rat)))

        of Floating   || Integer        :   x.f /= float(notZero(y.i))
        of Floating   || BigInteger     :   (when defined(GMP): x = newFloating(x.f / notZero(y.bi)))
        of Floating   || Floating       :   x.f /= notZero(y.f)
        of Floating   || Rational       :   x = newRational(toRational(x.f) / notZero(y.rat))

        of Rational   || Integer        :   x.rat /= notZero(y.i)
        of Rational   || BigInteger     :   (when defined(GMP): x = newRational(x.rat / toRational(notZero(y.bi))))
        of Rational   || Floating       :   x.rat /= toRational(notZero(y.f))
        of Rational   || Rational       :   x.rat /= notZero(y.rat)
        
        of Quantity   || Integer        :   x.q //= y.i
        of Quantity   || BigInteger     :   (when defined(GMP): x.q //= y.bi)
        of Quantity   || Floating       :   x.q //= y.f
        of Quantity   || Rational       :   x.q //= y.rat
        of Quantity   || Quantity       :   x.q //= y.q
        else:
            objectOperationOrNothing("fdiv", FDivM, inplace=true)

# TODO(VM/values/operators) [`%`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `%`*(x: Value, y: Value): Value =
    ## perform the modulo operation between given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerMod(x.i, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): return newInteger(toBig(x.i) mod notZero(y.bi)))
        of BigInteger || Integer        :   (when defined(GMP): return newInteger(x.bi mod toBig(notZero(y.i))))
        of BigInteger || BigInteger     :   (when defined(GMP): return newInteger(x.bi mod notZero(y.bi)))
        of Integer    || Floating       :   return newFloating(float(x.i) mod notZero(y.f))
        of Integer    || Rational       :   return newRational(toRational(x.i) mod notZero(y.rat))
        of BigInteger || Rational       :   (when defined(GMP): return newRational(toRational(x.bi) mod notZero(y.rat)))

        of Floating   || Integer        :   return newFloating(x.f mod float(notZero(y.i)))
        of Floating   || Floating       :   return newFloating(x.f mod notZero(y.f))
        of Floating   || Rational       :   return newRational(toRational(x.f) mod notZero(y.rat))

        of Rational   || Integer        :   return newRational(x.rat mod toRational(notZero(y.i)))
        of Rational   || BigInteger     :   (when defined(GMP): return newRational(x.rat mod toRational(notZero(y.bi))))
        of Rational   || Floating       :   return newRational(x.rat mod toRational(notZero(y.f)))
        of Rational   || Rational       :   return newRational(x.rat mod notZero(y.rat))
        
        # of Quantity   || Integer        :   return newQuantity(x.q % y.i)
        # of Quantity   || BigInteger     :   (when BignumSupport: return newQuantity(x.q % y.bi))
        # of Quantity   || Floating       :   return newQuantity(x.q % y.f)
        # of Quantity   || Rational       :   return newQuantity(x.q % y.rat)
        # of Quantity   || Quantity       :   return newQuantity(x.q % y.q)
        else:
            objectOperationOrNothing("mod", ModM)

proc `%=`*(x: var Value, y: Value) =
    ## perform the modulo operation between given values
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerModI(x, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): x = newInteger(toBig(x.i) mod notZero(y.bi)))
        of BigInteger || Integer        :   (when defined(GMP): modI(x.bi, toBig(notZero(y.i))))
        of BigInteger || BigInteger     :   (when defined(GMP): modI(x.bi, notZero(y.bi)))
        of Integer    || Floating       :   x = newFloating(float(x.i) mod notZero(y.f))
        of Integer    || Rational       :   x = newRational(toRational(x.i) mod notZero(y.rat))
        of BigInteger || Rational       :   (when defined(GMP): x = newRational(toRational(x.bi) mod notZero(y.rat)))

        of Floating   || Integer        :   x.f = x.f mod float(notZero(y.i))
        of Floating   || Floating       :   x.f = x.f mod notZero(y.f)
        of Floating   || Rational       :   x = newRational(toRational(x.f) mod notZero(y.rat))

        of Rational   || Integer        :   x.rat = x.rat mod toRational(notZero(y.i))
        of Rational   || BigInteger     :   (when defined(GMP): x.rat = x.rat mod toRational(notZero(y.bi)))
        of Rational   || Floating       :   x.rat = x.rat mod toRational(notZero(y.f))
        of Rational   || Rational       :   x.rat = x.rat mod notZero(y.rat)
        
        # of Quantity   || Integer        :   x.q %= y.i
        # of Quantity   || Floating       :   x.q %= y.f
        # of Quantity   || Rational       :   x.q %= y.rat
        # of Quantity   || Quantity       :   x.q %= y.q
        else:
            objectOperationOrNothing("mod", ModM, inplace=true)

# TODO(VM/values/operators) [`/%`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `/%`*(x: Value, y: Value): Value =
    ## perform the divmod operation between given values
    ## and return the result as a *tuple* Block value
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerDivMod(x.i, y.i)
        of Integer    || BigInteger     :   
            when defined(GMP): 
                let dm=divmod(x.i, notZero(y.bi))
                return newBlock(@[newInteger(dm[0]), newInteger(dm[1])])
        of BigInteger || Integer        :   
            when defined(GMP): 
                let dm=divmod(x.bi, notZero(y.i))
                return newBlock(@[newInteger(dm[0]), newInteger(dm[1])])
        of BigInteger || BigInteger     :   
            when defined(GMP): 
                let dm=divmod(x.bi, notZero(y.bi))
                return newBlock(@[newInteger(dm[0]), newInteger(dm[1])])
        of Integer    || Floating       :   return newBlock(@[x/y, x%y])
        of BigInteger || Floating       :   return newBlock(@[x/y, x%y])
        of Integer    || Rational       :   return newBlock(@[x/y, x%y])
        of BigInteger || Rational       :   return newBlock(@[x/y, x%y])

        of Floating   || Integer        :   return newBlock(@[x/y, x%y])
        of Floating   || Floating       :   return newBlock(@[x/y, x%y])
        of Floating   || Rational       :   return newBlock(@[x/y, x%y])

        of Rational   || Integer        :   return newBlock(@[x/y, x%y])
        of Rational   || BigInteger     :   return newBlock(@[x/y, x%y])
        of Rational   || Floating       :   return newBlock(@[x/y, x%y])
        of Rational   || Rational       :   return newBlock(@[x/y, x%y])
        
        # of Quantity   || Integer        :   return newBlock(@[x/y, x%y])
        # of Quantity   || BigInteger     :   return newBlock(@[x/y, x%y])
        # of Quantity   || Floating       :   return newBlock(@[x/y, x%y])
        # of Quantity   || Rational       :   return newBlock(@[x/y, x%y])
        # of Quantity   || Quantity       :   return newBlock(@[x/y, x%y])
        else:
            return invalidOperation("divmod")

proc `/%=`*(x: var Value, y: Value) =
    ## perform the divmod operation between given values
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation
    
    x = x /% y

# TODO(VM/values/operators) [`^`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `^`*(x: Value, y: Value): Value =
    ## perform the power operation between given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerPow(x.i, y.i)
        of BigInteger || Integer        :   (when defined(GMP): return newInteger(pow(x.bi, culong(y.i))))
        of Integer    || Floating       :   return newFloating(pow(float(x.i), y.f))
        of BigInteger || Floating       :   (when defined(GMP): return newFloating(pow(x.bi, y.f)))
        of Integer    || Rational       :   return newRational(pow(float(x.i), toFloat(y.rat)))
        of BigInteger || Rational       :   (when defined(GMP): return newRational(pow(x.bi, toFloat(y.rat))))

        of Floating   || Integer        :   return newFloating(pow(x.f, float(y.i)))
        of Floating   || BigInteger     :   (when defined(GMP): return newFloating(pow(x.f, y.bi)))
        of Floating   || Floating       :   return newFloating(pow(x.f, y.f))

        of Rational   || Integer        :   return newRational(x.rat ^ y.i)
        of Rational   || Floating       :   discard notZero(x.rat); return newRational(x.rat ^ y.f)

        of Complex    || Integer        :   return newComplex(pow(x.z, float(y.i)))
        of Complex    || Floating       :   return newComplex(pow(x.z, y.f))
        of Complex    || Complex        :   return newComplex(pow(x.z, y.z))
        
        of Quantity   || Integer        :   return newQuantity(x.q ^ y.i)
        # of Quantity   || BigInteger     :   return newQuantity(x.q ^ y.bi)
        # of Quantity   || Floating       :   return newQuantity(x.q ^ y.f)
        # of Quantity   || Rational       :   return newQuantity(x.q ^ y.rat)
        # of Quantity   || Quantity       :   return newQuantity(x.q ^ y.q)
        else:
            objectOperationOrNothing("pow", PowM)

proc `^=`*(x: var Value, y: Value) =
    ## perform the power operation between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerPowI(x, y.i)
        of BigInteger || Integer        :   (when defined(GMP): powI(x.bi, culong(y.i)))
        of Integer    || Floating       :   x = newFloating(pow(float(x.i), y.f))
        of BigInteger || Floating       :   (when defined(GMP): x = newFloating(pow(x.bi, y.f)))
        of Integer    || Rational       :   x = newRational(pow(float(x.i), toFloat(y.rat)))
        of BigInteger || Rational       :   (when defined(GMP): x = newRational(pow(x.bi, toFloat(y.rat))))

        of Floating   || Integer        :   x.f = pow(x.f, float(y.i))
        of Floating   || BigInteger     :   (when defined(GMP): x = newFloating(pow(x.f, y.bi)))
        of Floating   || Floating       :   x.f = pow(x.f, y.f)

        of Rational   || Integer        :   x = newRational(x.rat ^ y.i)
        of Rational   || Floating       :   x = newRational(x.rat ^ y.f)

        of Complex    || Integer        :   x.z = pow(x.z, float(y.i))
        of Complex    || Floating       :   x.z = pow(x.z, y.f)
        of Complex    || Complex        :   x.z = pow(x.z, y.z)
        
        of Quantity   || Integer        :   x.q ^= y.i
        # of Quantity   || BigInteger     :   x.q ^= y.bi
        # of Quantity   || Floating       :   x.q ^= y.f
        # of Quantity   || Rational       :   x.q ^= y.rat
        # of Quantity   || Quantity       :   x.q ^= y.q
        else:
            objectOperationOrNothing("pow", PowM, inplace=true)

# TODO(VM/values/operators) [`&&`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `&&`*(x: Value, y: Value): Value =
    ## perform binary-AND between given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerAnd(x.i, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): return newInteger(toBig(x.i) and y.bi))
        of BigInteger || Integer        :   (when defined(GMP): return newInteger(x.bi and toBig(y.i)))
        of BigInteger || BigInteger     :   (when defined(GMP): return newInteger(x.bi and y.bi))
        of Integer    || Binary         :   return newBinary(numberToBinary(x.i) and y.n)

        of Binary     || Integer        :   return newBinary(x.n and numberToBinary(y.i))
        of Binary     || Binary         :   return newBinary(x.n and y.n)

        else:
            return invalidOperation("and")

proc `&&=`*(x: var Value, y: Value) =
    ## perform binary-AND between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerAndI(x, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): x = newInteger(toBig(x.i) and y.bi))
        of BigInteger || Integer        :   (when defined(GMP): andI(x.bi, toBig(y.i)))
        of BigInteger || BigInteger     :   (when defined(GMP): andI(x.bi, y.bi))
        of Integer    || Binary         :   x = newBinary(numberToBinary(x.i) and y.n)

        of Binary     || Integer        :   x.n = x.n and numberToBinary(y.i)
        of Binary     || Binary         :   x.n = x.n and y.n

        else:
            discard invalidOperation("and")

# TODO(VM/values/operators) [`||`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `||`*(x: Value, y: Value): Value =
    ## perform binary-OR between given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerOr(x.i, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): return newInteger(toBig(x.i) or y.bi))
        of BigInteger || Integer        :   (when defined(GMP): return newInteger(x.bi or toBig(y.i)))
        of BigInteger || BigInteger     :   (when defined(GMP): return newInteger(x.bi or y.bi))
        of Integer    || Binary         :   return newBinary(numberToBinary(x.i) or y.n)

        of Binary     || Integer        :   return newBinary(x.n or numberToBinary(y.i))
        of Binary     || Binary         :   return newBinary(x.n or y.n)

        else:
            return invalidOperation("or")

proc `||=`*(x: var Value, y: Value) =
    ## perform binary-OR between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerOrI(x, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): x = newInteger(toBig(x.i) or y.bi))
        of BigInteger || Integer        :   (when defined(GMP): orI(x.bi, toBig(y.i)))
        of BigInteger || BigInteger     :   (when defined(GMP): orI(x.bi, y.bi))
        of Integer    || Binary         :   x = newBinary(numberToBinary(x.i) or y.n)

        of Binary     || Integer        :   x.n = x.n or numberToBinary(y.i)
        of Binary     || Binary         :   x.n = x.n or y.n

        else:
            discard invalidOperation("or")

# TODO(VM/values/operators) [`^^`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `^^`*(x: Value, y: Value): Value =
    ## perform binary-XOR between given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerXor(x.i, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): return newInteger(toBig(x.i) xor y.bi))
        of BigInteger || Integer        :   (when defined(GMP): return newInteger(x.bi xor toBig(y.i)))
        of BigInteger || BigInteger     :   (when defined(GMP): return newInteger(x.bi xor y.bi))
        of Integer    || Binary         :   return newBinary(numberToBinary(x.i) xor y.n)

        of Binary     || Integer        :   return newBinary(x.n xor numberToBinary(y.i))
        of Binary     || Binary         :   return newBinary(x.n xor y.n)

        else:
            return invalidOperation("xor")

proc `^^=`*(x: var Value, y: Value) =
    ## perform binary-XOR between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerXorI(x, y.i)
        of Integer    || BigInteger     :   (when defined(GMP): x = newInteger(toBig(x.i) xor y.bi))
        of BigInteger || Integer        :   (when defined(GMP): xorI(x.bi, toBig(y.i)))
        of BigInteger || BigInteger     :   (when defined(GMP): xorI(x.bi, y.bi))
        of Integer    || Binary         :   x = newBinary(numberToBinary(x.i) xor y.n)

        of Binary     || Integer        :   x.n = x.n xor numberToBinary(y.i)
        of Binary     || Binary         :   x.n = x.n xor y.n

        else:
            discard invalidOperation("xor")

# TODO(VM/values/operators) [`!!`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `!!`*(x: Value): Value =
    ## perform binary-NOT on given value and return the result

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: return normalIntegerNot(x.i)
            else: (when defined(GMP): return newInteger(not x.bi))
        of Binary: return newBinary(not x.n)
        else:
            return invalidOperation("not")

proc `!!=`*(x: var Value) =
    ## perform binary-NOT on given value
    ## and store back the result
    ## 
    ## **Hint:** In-place, mutating operation

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: normalIntegerNotI(x)
            else: (when defined(GMP): notI(x.bi))
        of Binary: x.n = not x.n
        else:
            discard invalidOperation("not")

# TODO(VM/values/operators) [`<<`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `<<`*(x: Value, y: Value): Value =
    ## perform binary left-shift between given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerShl(x.i, y.i)
        of BigInteger || Integer        :   (when defined(GMP): return newInteger(x.bi shl culong(y.i)))
        else:
            return invalidOperation("shl")

proc `<<=`*(x: var Value, y: Value) =
    ## perform binary left-shift between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerShlI(x, y.i)
        of BigInteger || Integer        :   (when defined(GMP): shlI(x.bi, culong(y.i)))
        else:
            discard invalidOperation("shl")
    
# TODO(VM/values/operators) [`>>`] Verify for Web builds
#  we should also check whether big integers work too!
#  (the same applies to its in-place equivalent)
#  labels: unit-test, web, :integer

proc `>>`*(x: Value, y: Value): Value =
    ## perform binary right-shift between given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerShr(x.i, y.i)
        of BigInteger || Integer        :   (when defined(GMP): return newInteger(x.bi shr culong(y.i)))
        else:
            return invalidOperation("shr")

proc `>>=`*(x: var Value, y: Value) =
    ## perform binary right-shift between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   normalIntegerShrI(x, y.i)
        of BigInteger || Integer        :   (when defined(GMP): shrI(x.bi, culong(y.i)))
        else:
            discard invalidOperation("shl")
