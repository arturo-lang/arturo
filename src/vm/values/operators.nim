#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/operators.nim
#=======================================================

## Arithmetic & logical operators for Value objects.

#=======================================
# Libraries
#=======================================

import lenientops, math, strutils

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import helpers/intrinsics
import helpers/maths

import vm/errors

import vm/values/types
import vm/values/value
import vm/values/printable

import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vquantity, vrange, vrational, vversion]

#=======================================
# Constants
#=======================================

const
    GMP = not defined(NOGMP)

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
{.push overflowChecks: on.}
proc safeMulI[T: SomeInteger](x: var T, y: T) {.inline, noSideEffect.} =
    x = x * y

func safePow[T: SomeNumber](x: T, y: Natural): T =
    case y
    of 0: result = 1
    of 1: result = x
    of 2: result = x * x
    of 3: result = x * x * x
    else:
        var (x, y) = (x, y)
        result = 1
        while true:
            if (y and 1) != 0:
                safeMulI(result, x)
            y = y shr 1
            if y == 0:
                break
            safeMulI(x, x)

{.pop.}

func powIntWithOverflow(a,b:int, res: var int): bool =
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

template getValuePair(): untyped =
    let xKind {.inject.} = x.kind
    let yKind {.inject.} = y.kind

    (cast[uint32](ord(xKind)) shl 16.uint32) or 
    (cast[uint32](ord(yKind))) or  
    (cast[uint32](cast[uint32](xKind==Integer) * cast[uint32](x.iKind==BigInteger)) shl 31) or
    (cast[uint32](cast[uint32](yKind==Integer) * cast[uint32](y.iKind==BigInteger)) shl 15)

proc `||`(va: static[ValueKind | IntegerKind], vb: static[ValueKind | IntegerKind]): uint32 {.compileTime.}=
    when va is ValueKind:
        result = cast[uint32](ord(va)) shl 16
    elif va is IntegerKind:
        when va == NormalInteger:
            result = cast[uint32](ord(Integer)) shl 16
        elif va == BigInteger:
            result = cast[uint32](ord(Integer)) shl 16 or (1.uint32 shl 31)

    when vb is ValueKind:
        result = result or cast[uint32](ord(vb))
    elif vb is IntegerKind:
        when vb == NormalInteger:
            result = result or cast[uint32](ord(Integer))
        elif vb == BigInteger:
            result = result or cast[uint32](ord(Integer)) or (1.uint32 shl 15)

template notZero(v: untyped): untyped =
    when v is VRational:
        if unlikely(v.num==0):
            RuntimeError_DivisionByZero()
    elif v is VComplex:
        if unlikely(v.re==0 and v.im==0):
            RuntimeError_DivisionByZero()
    else:
        if unlikely(v==0):
            RuntimeError_DivisionByZero()
    v

proc invalidOperation(op: string, x: Value, y: Value = nil): Value =
    when not defined(WEB):
        if y.isNil:
            RuntimeError_InvalidOperation(op, valueKind(x, withBigInfo=true), "")
        else:
            RuntimeError_InvalidOperation(op, valueKind(x, withBigInfo=true), valueKind(y, withBigInfo=true))
    VNULL

template invalidOperation(op: string): untyped =
    when declared(y):
        invalidOperation(op, x, y)
    else:
        invalidOperation(op, x)

#=======================================
# Templates
#=======================================

template normalIntegerOperation*(): bool =
    ## check if both operands (x,y) are Integers, but not GMP-style BigNums
    when not declared(xKind):
        let xKind {.inject.} = x.kind
        when declared(y):
            let yKind {.inject.} = y.kind

    when declared(y):
        likely(xKind==Integer) and likely(x.iKind==NormalInteger) and likely(yKind==Integer) and likely(y.iKind==NormalInteger)
    else:
        likely(xKind==Integer) and likely(x.iKind==NormalInteger)

template normalIntegerAdd*(x, y: int): untyped =
    ## add two normal Integer values, checking for overflow
    ## and return result
    var res: int
    if unlikely(addIntWithOverflow(x, y, res)):
        when not defined(NOGMP):
            newInteger(toNewBig(x) + toBig(y))
        else:
            RuntimeError_IntegerOperationOverflow("add", $x, $y)
            VNULL
    else:
        newInteger(res)

template normalIntegerInc*(x: int): untyped =
    ## increment a normal Integer value by 1, checking for overflow
    ## and return result
    var res: int
    if unlikely(addIntWithOverflow(x, 1, res)):
        when not defined(NOGMP):
            newInteger(toNewBig(x) + toBig(1))
        else:
            RuntimeError_IntegerOperationOverflow("inc", $x, "")
            VNULL
    else:
        newInteger(res)

template normalIntegerSub*(x, y: int): untyped =
    ## subtract two normal Integer values, checking for overflow
    ## and return result
    var res: int
    if unlikely(subIntWithOverflow(x, y, res)):
        when not defined(NOGMP):
            newInteger(toNewBig(x) - toBig(y))
        else:
            RuntimeError_IntegerOperationOverflow("sub", $x, $y)
            VNULL
    else:
        newInteger(res)

template normalIntegerDec*(x: int): untyped =
    ## decrement a normal Integer value by 1, checking for overflow
    ## and return result
    var res: int
    if unlikely(subIntWithOverflow(x, 1, res)):
        when not defined(NOGMP):
            newInteger(toNewBig(x) - toBig(1))
        else:
            RuntimeError_IntegerOperationOverflow("dec", $x, "")
            VNULL
    else:
        newInteger(res)

template normalIntegerMul*(x, y: int): untyped =
    ## multiply two normal Integer values, checking for overflow
    ## and return result
    var res: int
    if unlikely(mulIntWithOverflow(x, y, res)):
        when not defined(NOGMP):
            newInteger(toNewBig(x) * toBig(y))
        else:
            RuntimeError_IntegerOperationOverflow("mul", $x, $y)
            VNULL
    else:
        newInteger(res)

template normalIntegerNeg*(x: int): untyped =
    ## negate a normal Integer value, checking for overflow
    ## and return result
    var res: int
    if unlikely(mulIntWithOverflow(x, -1, res)):
        when not defined(NOGMP):
            newInteger(toNewBig(x) * toBig(-1))
        else:
            RuntimeError_IntegerOperationOverflow("neg", $x, "")
            VNULL
    else:
        newInteger(res)

template normalIntegerDiv*(x, y: int): untyped =
    ## divide (integer division) two normal Integer values, checking for DivisionByZero
    ## and return result
    newInteger(x div notZero(y))

template normalIntegerFDiv*(x, y: int): untyped =
    ## divide (floating-point division) two normal Integer values, checking for DivisionByZero
    ## and return result
    newFloating(x / notZero(y))

template normalIntegerMod*(x, y: int): untyped =
    ## modulo two normal Integer values, checking for DivisionByZero
    ## and return result
    newInteger(x mod notZero(y))

template normalIntegerDivMod*(x, y: int): untyped =
    ## divide+modulo (integer division) two normal Integer values, checking for DivisionByZero
    ## and return result
    let dm = divmod(x, notZero(y))
    newBlock(@[newInteger(dm[0]), newInteger(dm[1])])

template normalIntegerPow*(x, y: int): untyped =
    ## get the power of two normal Integer values, checking for overflow
    ## and return result
    if likely(y >= 0):
        var res: int
        if unlikely(powIntWithOverflow(x, y, res)):
            when not defined(NOGMP):
                when defined(WEB):
                    newInteger(big(x) ** big(y))
                else:
                    newInteger(pow(x, culong(y)))
            else:
                RuntimeError_IntegerOperationOverflow("pow", $x, $y)
                VNULL
        else:
            newInteger(res)
    else:
        newFloating(pow(float(x), float(y)))

template normalIntegerAnd*(x, y: int): untyped =
    ## bitwise AND two normal Integer values
    ## and return result
    newInteger(x and y)

template normalIntegerOr*(x, y: int): untyped =
    ## bitwise OR two normal Integer values
    ## and return result
    newInteger(x or y)

template normalIntegerXor*(x, y: int): untyped =
    ## bitwise XOR two normal Integer values
    ## and return result
    newInteger(x xor y)

template normalIntegerNot*(x: int): untyped =
    ## bitwise NOT of a normal Integer value
    ## and return result
    newInteger(not x)

template normalIntegerShl*(x, y: int): untyped =
    ## bitwise shift left two normal Integer values
    ## and return result
    newInteger(x shl y)

template normalIntegerShr*(x, y: int): untyped =
    ## bitwise shift right two normal Integer values
    ## and return result
    newInteger(x shr y)

#=======================================
# Methods
#=======================================

proc convertToTemperatureUnit*(v: Value, src: UnitName, tgt: UnitName): Value =
    ## convert given temperature value ``v`` from ``src`` unit to ``tgt``
    case src:
        of C:
            if tgt==F: return v * newFloating(9/5) + newInteger(32)
            elif tgt==K: return v + newFloating(273.15)
            else: return v * newFloating(9/5) + newFloating(491.67)
        of F:
            if tgt==C: return (v - newInteger(32)) * newFloating(5/9)
            elif tgt==K: return (v - newInteger(32)) * newFloating(5/9) + newFloating(273.15)
            else: return v + newFloating(459.67)
        of K: 
            if tgt==C: return v - newFloating(273.15)
            elif tgt==F: return (v-newFloating(273.15)) * newFloating(9/5) + newInteger(32)
            else: return v * newFloating(1.8)
        of R:
            if tgt==C: return (v - newFloating(491.67)) * newFloating(5/9)
            elif tgt==F: return v - newFloating(459.67)
            else: return v * newFloating(5/9)

        else: discard

proc convertQuantityValue*(nm: Value, fromU: UnitName, toU: UnitName, fromKind = NoUnit, toKind = NoUnit, op = ""): Value =
    ## convert given quantity value ``nm`` from ``fromU`` unit to ``toU`` 
    var fromK = fromKind
    var toK = toKind
    if fromK==NoUnit: fromK = quantityKindForName(fromU)
    if toK==NoUnit: toK = quantityKindForName(toU)

    if unlikely(fromK!=toK):
        when not defined(WEB):
            RuntimeError_CannotConvertQuantity(valueAsString(nm), stringify(fromU), stringify(fromK), stringify(toU), stringify(toK))
    
    if toK == TemperatureUnit:
        return convertToTemperatureUnit(nm, fromU, toU)
    else:
        let fmultiplier = getQuantityMultiplier(fromU, toU, isCurrency=fromK==CurrencyUnit)
        if fmultiplier == 1.0:
            return nm
        else:
            return nm * newFloating(fmultiplier)

#=======================================
# Overloads
#=======================================

# TODO(VM/values/value) Verify that all errors are properly thrown
#  Various core arithmetic operations between Value values may lead to errors. Are we catching - and reporting - them all properly?
#  labels: vm, values, error handling, unit-test

proc `+`*(x: Value, y: Value): Value =
    ## add given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerAdd(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(toBig(x.i) + y.bi))
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi + toBig(y.i)))
        of BigInteger || BigInteger     :   (when GMP: return newInteger(x.bi + y.bi))
        of Integer    || Floating       :   return newFloating(x.i + y.f)
        of BigInteger || Floating       :   (when GMP: return newFloating(x.bi + y.f))
        of Integer    || Rational       :   return newRational(x.i + y.rat)
        of Integer    || Complex        :   return newComplex(float(x.i) + y.z)

        of Floating   || Integer        :   return newFloating(x.f + float(y.i))
        of Floating   || BigInteger     :   (when GMP: return newFloating(x.f + y.bi))
        of Floating   || Floating       :   return newFloating(x.f + y.f)
        of Floating   || Rational       :   return newRational(toRational(x.f) + y.rat)
        of Floating   || Complex        :   return newComplex(x.f + y.z)

        of Rational   || Integer        :   return newRational(x.rat + y.i)
        of Rational   || Floating       :   return newRational(x.rat + toRational(y.f))
        of Rational   || Rational       :   return newRational(x.rat + y.rat)

        of Complex    || Integer        :   return newComplex(x.z + float(y.i))
        of Complex    || Floating       :   return newComplex(x.z + y.f)
        of Complex    || Complex        :   return newComplex(x.z + y.z)
        
        of Color      || Color          :   return newColor(x.l + y.l)
        of Quantity   || Integer        :   return newQuantity(x.nm + y, x.unit)
        of Quantity   || Floating       :   return newQuantity(x.nm + y, x.unit)
        of Quantity   || Rational       :   return newQuantity(x.nm + y, x.unit)
        of Quantity   || Quantity       :
            if x.unit.name == y.unit.name:
                return newQuantity(x.nm + y.nm, x.unit)
            else:
                return newQuantity(x.nm + convertQuantityValue(y.nm, y.unit.name, x.unit.name), x.unit)
        else:
            return invalidOperation("add")
{.push overflowChecks: on.}
proc `+=`*(x: var Value, y: Value) =
    ## add given values 
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutating operation
    if x.kind==Color and y.kind==Color:
        x.l = x.l + y.l
    elif not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.name == y.unit.name:
                    x.nm += y.nm
                else:
                    x.nm += convertQuantityValue(y.nm, y.unit.name, x.unit.name)
            else:
                x.nm += y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        x.i += y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)+big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)+y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("add", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)+y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i+y.bi)
                    
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        x.bi += y.bi
                    else:
                        x.bi += big(y.i)
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        x.bi += y.bi
                    else:
                        x.bi += y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f += y.f
                elif y.kind==Complex: x = newComplex(x.f + y.z)
                elif y.kind==Rational: x = newRational(toRational(x.f) + y.rat)
                else: 
                    if y.iKind == NormalInteger:
                        x.f = x.f + y.i
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f + y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(x.z + float(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z + y.f)
                elif y.kind==Rational: discard
                else: x.z += y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x.rat += y.i
                    else: discard
                elif y.kind==Floating: x.rat += toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat += y.rat
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(x.i+y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi+y.f)
                elif y.kind==Rational: x = newRational(x.i+y.rat)
                else: x = newComplex(float(x.i)+y.z)
{.pop.}
proc inc*(x: Value): Value =
    ## increment given value and return the result

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: return normalIntegerInc(x.i)
            else: (when GMP: return newInteger(x.bi+toBig(1)))
        of Floating: return newFloating(x.f+1.0)
        of Rational: return newRational(x.rat+1)
        of Complex: return newComplex(x.z+1.0)
        of Quantity: return newQuantity(x.nm + I1, x.unit)
        else:
            return invalidOperation("inc")

proc `-`*(x: Value, y: Value): Value = 
    ## subtract given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerSub(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(toBig(x.i) - y.bi))
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi - toBig(y.i)))
        of BigInteger || BigInteger     :   (when GMP: return newInteger(x.bi - y.bi))
        of Integer    || Floating       :   return newFloating(x.i - y.f)
        of BigInteger || Floating       :   (when GMP: return newFloating(x.bi - y.f))
        of Integer    || Rational       :   return newRational(x.i - y.rat)
        of Integer    || Complex        :   return newComplex(float(x.i) - y.z)

        of Floating   || Integer        :   return newFloating(x.f - float(y.i))
        of Floating   || BigInteger     :   (when GMP: return newFloating(x.f - y.bi))
        of Floating   || Floating       :   return newFloating(x.f - y.f)
        of Floating   || Rational       :   return newRational(toRational(x.f) - y.rat)
        of Floating   || Complex        :   return newComplex(x.f - y.z)

        of Rational   || Integer        :   return newRational(x.rat - y.i)
        of Rational   || Floating       :   return newRational(x.rat - toRational(y.f))
        of Rational   || Rational       :   return newRational(x.rat - y.rat)

        of Complex    || Integer        :   return newComplex(x.z - float(y.i))
        of Complex    || Floating       :   return newComplex(x.z - y.f)
        of Complex    || Complex        :   return newComplex(x.z - y.z)
        
        of Color      || Color          :   return newColor(x.l - y.l)
        of Quantity   || Integer        :   return newQuantity(x.nm - y, x.unit)
        of Quantity   || Floating       :   return newQuantity(x.nm - y, x.unit)
        of Quantity   || Rational       :   return newQuantity(x.nm - y, x.unit)
        of Quantity   || Quantity       :
            if x.unit.name == y.unit.name:
                return newQuantity(x.nm - y.nm, x.unit)
            else:
                return newQuantity(x.nm - convertQuantityValue(y.nm, y.unit.name, x.unit.name), x.unit)
        else:
            return invalidOperation("sub")
{.push overflowChecks: on.}
proc `-=`*(x: var Value, y: Value) =
    ## subtract given values and 
    ## store the result in the first value
    ## 
    ## **Hint:** In-place, mutating operation
    if x.kind==Color and y.kind==Color:
        x.l = x.l - y.l 
    elif not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.name == y.unit.name:
                    x.nm -= y.nm
                else:
                    x.nm -= convertQuantityValue(y.nm, y.unit.name, x.unit.name)
            else:
                x.nm -= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        x.i -= y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)-big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)-y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("sub", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)-y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i-y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        x.bi -= y.bi
                    else:
                        x.bi -= big(y.i)
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        x.bi -= y.bi
                    else:
                        x.bi -= y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f -= y.f
                elif y.kind==Complex: x = newComplex(x.f - y.z)
                elif y.kind==Rational: x = newRational(toRational(x.f) - y.rat)
                else: 
                    if y.iKind == NormalInteger:
                        x.f = x.f - y.i
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f - y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(x.z - float(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z - y.f)
                elif y.kind==Rational: discard
                else: x.z -= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x.rat -= y.i
                    else: discard
                elif y.kind==Floating: x.rat -= toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat -= y.rat
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(x.i-y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi-y.f)
                elif y.kind==Rational: x = newRational(x.i-y.rat)
                else: x = newComplex(float(x.i)-y.z)
{.pop.}
proc dec*(x: Value): Value =
    ## decrement given value and return the result

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: return normalIntegerDec(x.i)
            else: (when GMP: return newInteger(x.bi-toBig(1)))
        of Floating: return newFloating(x.f-1.0)
        of Rational: return newRational(x.rat-1)
        of Complex: return newComplex(x.z-1.0)
        of Quantity: return newQuantity(x.nm - I1, x.unit)
        else:
            return invalidOperation("dec")

proc `*`*(x: Value, y: Value): Value =
    ## multiply given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerMul(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(toBig(x.i) * y.bi))
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi * toBig(y.i)))
        of BigInteger || BigInteger     :   (when GMP: return newInteger(x.bi * y.bi))
        of Integer    || Floating       :   return newFloating(x.i * y.f)
        of BigInteger || Floating       :   (when GMP: return newFloating(x.bi * y.f))
        of Integer    || Rational       :   return newRational(x.i * y.rat)
        of Integer    || Complex        :   return newComplex(float(x.i) * y.z)
        of Integer    || Quantity       :   return newQuantity(x * y.nm, y.unit)

        of Floating   || Integer        :   return newFloating(x.f * float(y.i))
        of Floating   || BigInteger     :   (when GMP: return newFloating(x.f * y.bi))
        of Floating   || Floating       :   return newFloating(x.f * y.f)
        of Floating   || Rational       :   return newRational(toRational(x.f) * y.rat)
        of Floating   || Complex        :   return newComplex(x.f * y.z)

        of Rational   || Integer        :   return newRational(x.rat * y.i)
        of Rational   || Floating       :   return newRational(x.rat * toRational(y.f))
        of Rational   || Rational       :   return newRational(x.rat * y.rat)

        of Complex    || Integer        :   return newComplex(x.z * float(y.i))
        of Complex    || Floating       :   return newComplex(x.z * y.f)
        of Complex    || Complex        :   return newComplex(x.z * y.z)
        
        of Quantity   || Integer        :   return newQuantity(x.nm * y, x.unit)
        of Quantity   || Floating       :   return newQuantity(x.nm * y, x.unit)
        of Quantity   || Rational       :   return newQuantity(x.nm * y, x.unit)
        of Quantity   || Quantity       :
            let finalSpec = getFinalUnitAfterOperation("mul", x.unit, y.unit)
            if unlikely(finalSpec == ErrorQuantity):
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("mul", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
            else:
                return newQuantity(x.nm * convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
        else:
            return invalidOperation("mul")
{.push overflowChecks: on.}
proc `*=`*(x: var Value, y: Value) =
    ## multiply given values 
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("mul", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("mul", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                else:
                    x = newQuantity(x.nm * convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                x.nm *= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        safeMulI(x.i, y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)*big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)*y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("mul", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)*y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i*y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        x.bi *= y.bi
                    else:
                        x.bi *= big(y.i)
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        x.bi *= y.bi
                    else:
                        x.bi *= y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f *= y.f
                elif y.kind==Complex: x = newComplex(x.f * y.z)
                elif y.kind==Rational: x = newRational(toRational(x.f) * y.rat)
                else: 
                    if y.iKind == NormalInteger:
                        x.f = x.f * y.i
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f * y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(x.z * float(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z * y.f)
                else: x.z *= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x.rat *= y.i
                    else: discard
                elif y.kind==Floating: x.rat *= toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat *= y.rat
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(x.i*y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi*y.f)
                elif y.kind==Rational: x = newRational(x.i * y.rat)
                else: x = newComplex(float(x.i)*y.z)
{.pop.}


proc neg*(x: Value): Value =
    ## negate given value and return the result

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: return normalIntegerNeg(x.i)
            else: (when GMP: return newInteger(x.bi+toBig(1)))
        of Floating: return newFloating(x.f*(-1.0))
        of Rational: return newRational(x.rat*(-1))
        of Complex: return newComplex(x.z*(-1.0))
        of Quantity: return newQuantity(x.nm * I1M, x.unit)
        else:
            return invalidOperation("neg")

proc `/`*(x: Value, y: Value): Value =
    ## divide (integer division) given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerDiv(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(toBig(x.i) div notZero(y.bi)))
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi div toBig(notZero(y.i))))
        of BigInteger || BigInteger     :   (when GMP: return newInteger(x.bi div notZero(y.bi)))
        of Integer    || Floating       :   return newFloating(x.i / notZero(y.f))
        of BigInteger || Floating       :   (when GMP: return newFloating(x.bi / notZero(y.f)))
        of Integer    || Rational       :   return newInteger(toRational(x.i) div notZero(y.rat))
        of Integer    || Complex        :   return newComplex(float(x.i) / notZero(y.z))

        of Floating   || Integer        :   return newFloating(x.f / float(notZero(y.i)))
        of Floating   || BigInteger     :   (when GMP: return newFloating(x.f / notZero(y.bi)))
        of Floating   || Floating       :   return newFloating(x.f / notZero(y.f))
        of Floating   || Rational       :   return newInteger(toRational(x.f) div notZero(y.rat))
        of Floating   || Complex        :   return newComplex(x.f / notZero(y.z))

        of Rational   || Integer        :   return newInteger(x.rat div toRational(notZero(y.i)))
        of Rational   || Floating       :   return newInteger(x.rat div toRational(notZero(y.f)))
        of Rational   || Rational       :   return newInteger(x.rat div notZero(y.rat))

        of Complex    || Integer        :   return newComplex(x.z / float(notZero(y.i)))
        of Complex    || Floating       :   return newComplex(x.z / notZero(y.f))
        of Complex    || Complex        :   return newComplex(x.z / notZero(y.z))
        
        of Quantity   || Integer        :   return newQuantity(x.nm / y, x.unit)
        of Quantity   || Floating       :   return newQuantity(x.nm / y, x.unit)
        of Quantity   || Rational       :   return newQuantity(x.nm / y, x.unit)
        of Quantity   || Quantity       :
            let finalSpec = getFinalUnitAfterOperation("div", x.unit, y.unit)
            if unlikely(finalSpec == ErrorQuantity):
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("div", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
            elif finalSpec == NumericQuantity:
                return x.nm / y.nm
            else:
                return newQuantity(x.nm / convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
        else:
            return invalidOperation("div")
{.push overflowChecks: on.}
proc `/=`*(x: var Value, y: Value) =
    ## divide (integer division) given values 
    ## and store the result in the first one 
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("div", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("div", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                elif finalSpec == NumericQuantity:
                    x = x.nm / y.nm
                else:
                    x = newQuantity(x.nm / convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                x.nm /= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        x.i = x.i div y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i) div big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i) div y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("div", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i) div y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i div y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        x = newInteger(x.bi div y.bi)
                    else:
                        x = newInteger(x.bi div big(y.i))
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        x = newInteger(x.bi div y.bi)
                    else:
                        x = newInteger(x.bi div y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f /= y.f
                elif y.kind==Complex: x = newComplex(x.f / y.z)
                elif y.kind==Rational: x = newInteger(toRational(x.f) div y.rat)
                else:                     
                    if y.iKind == NormalInteger:
                        x.f = x.f / y.i
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f / y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(x.z / float(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z / y.f)
                else: x.z /= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newInteger(x.rat div toRational(y.i))
                    else: discard
                elif y.kind==Floating: x = newInteger(x.rat div toRational(y.f))
                elif y.kind==Complex: discard
                else: x = newInteger(x.rat div y.rat)
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(x.i/y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi/y.f)
                elif y.kind==Rational: x = newInteger(toRational(x.i) div y.rat)
                else: x = newComplex(float(x.i)/y.z)
{.pop.}
proc `//`*(x: Value, y: Value): Value =
    ## divide (floating-point division) given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerFDiv(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(x.i // notZero(y.bi)))
        of Integer    || Floating       :   return newFloating(float(x.i) / notZero(y.f))
        of BigInteger || Floating       :   (when GMP: return newFloating(x.bi / notZero(y.f)))
        of Integer    || Rational       :   return newRational(x.i / notZero(y.rat))

        of Floating   || Integer        :   return newFloating(x.f / float(notZero(y.i)))
        of Floating   || BigInteger     :   (when GMP: return newFloating(x.f / notZero(y.bi)))
        of Floating   || Floating       :   return newFloating(x.f / notZero(y.f))
        of Floating   || Rational       :   return newRational(toRational(x.f) / notZero(y.rat))

        of Rational   || Integer        :   return newRational(x.rat / notZero(y.i))
        of Rational   || Floating       :   return newRational(x.rat / toRational(notZero(y.f)))
        of Rational   || Rational       :   return newRational(x.rat / notZero(y.rat))
        
        of Quantity   || Integer        :   return newQuantity(x.nm // y, x.unit)
        of Quantity   || Floating       :   return newQuantity(x.nm // y, x.unit)
        of Quantity   || Rational       :   return newQuantity(x.nm // y, x.unit)
        of Quantity   || Quantity       :
            let finalSpec = getFinalUnitAfterOperation("fdiv", x.unit, y.unit)
            if unlikely(finalSpec == ErrorQuantity):
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("fdiv", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
            elif finalSpec == NumericQuantity:
                return x.nm // y.nm
            else:
                return newQuantity(x.nm // convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
        else:
            return invalidOperation("fdiv")

{.push overflowChecks: on.}
proc `//=`*(x: var Value, y: Value) =
    ## divide (floating-point division) given values 
    ## and store the result in the first one 
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer, Floating, Rational}) or not (y.kind in {Integer, Floating, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("fdiv", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("fdiv", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                elif finalSpec == NumericQuantity:
                    x = x.nm // y.nm
                else:
                    x = newQuantity(x.nm // convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                x.nm //= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            x = newFloating(x.i / y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f /= y.f
                elif y.kind==Rational: x = newRational(toRational(x.f)/y.rat)
                else: 
                    if y.iKind == NormalInteger:
                        x.f = x.f / float(y.i)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f / y.bi)
            elif x.kind==Rational:
                if y.kind==Floating: x.rat /= toRational(y.f)
                elif y.kind==Rational: x.rat /= y.rat
                else: x.rat /= y.i
            else:
                if y.kind==Floating:
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(float(x.i)/y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi/y.f)
                else: x = newRational(x.i / y.rat)
{.pop.}

proc `%`*(x: Value, y: Value): Value =
    ## perform the modulo operation between given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerMod(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(toBig(x.i) mod notZero(y.bi)))
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi mod toBig(notZero(y.i))))
        of BigInteger || BigInteger     :   (when GMP: return newInteger(x.bi mod notZero(y.bi)))
        of Integer    || Floating       :   return newFloating(float(x.i) / notZero(y.f))
        of BigInteger || Floating       :   (when GMP: return newFloating(x.bi / notZero(y.f)))
        of Integer    || Rational       :   return newRational(toRational(x.i) mod notZero(y.rat))

        of Floating   || Integer        :   return newFloating(x.f mod float(notZero(y.i)))
        of Floating   || Floating       :   return newFloating(x.f mod notZero(y.f))
        of Floating   || Rational       :   return newRational(toRational(x.f) mod notZero(y.rat))

        of Rational   || Integer        :   return newRational(x.rat mod toRational(notZero(y.i)))
        of Rational   || Floating       :   return newRational(x.rat mod toRational(notZero(y.f)))
        of Rational   || Rational       :   return newRational(x.rat mod notZero(y.rat))
        
        of Quantity   || Integer        :   return newQuantity(x.nm % y, x.unit)
        of Quantity   || Floating       :   return newQuantity(x.nm % y, x.unit)
        of Quantity   || Rational       :   return newQuantity(x.nm % y, x.unit)
        of Quantity   || Quantity       :
            let finalSpec = getFinalUnitAfterOperation("mod", x.unit, y.unit)
            if unlikely(finalSpec == ErrorQuantity):
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("mod", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
            elif finalSpec == NumericQuantity:
                return x.nm % y.nm
            else:
                return newQuantity(x.nm % convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
        else:
            return invalidOperation("mod")

{.push overflowChecks: on.}
proc `%=`*(x: var Value, y: Value) =
    ## perform the modulo operation between given values
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer,Floating,Rational}) or not (y.kind in {Integer,Floating,Rational}):
        if (x.kind == Quantity and y.kind == Quantity) and (x.unit.kind==y.unit.kind):
            if x.unit.name == y.unit.name:
                x.nm %= y.nm
            else:
                x.nm %= convertQuantityValue(y.nm, y.unit.name, x.unit.name)
        else:
            if unlikely(x.unit.kind != y.unit.kind):
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("mod", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
            else:
                x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger): 
                    x.i = x.i mod y.i
                else: 
                    when defined(WEB):
                        x = newInteger(big(x.i) mod y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i mod y.bi)
            else:
                when defined(WEB):
                    if likely(y.iKind==NormalInteger): 
                        x = newInteger(x.bi mod big(y.i))
                    else: 
                        x = newInteger(x.bi mod y.bi)
                elif not defined(NOGMP):
                    if likely(y.iKind==NormalInteger): 
                        x = newInteger(x.bi mod y.i)
                    else: 
                        x = newInteger(x.bi mod y.bi)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x = newFloating(x.f mod y.f)
                elif y.kind==Rational: x = newRational(toRational(x.f) mod y.rat)
                else: 
                    if likely(y.iKind==NormalInteger):
                        x = newFloating(x.f mod float(y.i))
            elif x.kind==Rational:
                if y.kind==Floating: x = newRational(x.rat mod toRational(y.f))
                elif y.kind==Rational: x = newRational(x.rat mod y.rat)
                else: x = newRational(x.rat mod toRational(y.i))
            else:
                if y.kind==Rational:
                    x = newRational(toRational(x.i) mod y.rat)
                else:
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(float(x.i) mod y.f)
{.pop.}
proc `/%`*(x: Value, y: Value): Value =
    ## perform the divmod operation between given values
    ## and return the result as a *tuple* Block value
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerDivMod(x.i, y.i)
        of Integer    || BigInteger     :   
            when GMP: 
                let dm=divmod(x.i, notZero(y.bi))
                return newBlock(@[newInteger(dm[0]), newInteger(dm[1])])
        of BigInteger || Integer        :   
            when GMP: 
                let dm=divmod(x.bi, notZero(y.i))
                return newBlock(@[newInteger(dm[0]), newInteger(dm[1])])
        of BigInteger || BigInteger     :   
            when GMP: 
                let dm=divmod(x.bi, notZero(y.bi))
                return newBlock(@[newInteger(dm[0]), newInteger(dm[1])])
        of Integer    || Floating       :   return newBlock(@[x/y, x%y])
        of BigInteger || Floating       :   return newBlock(@[x/y, x%y])
        of Integer    || Rational       :   return newBlock(@[x/y, x%y])

        of Floating   || Integer        :   return newBlock(@[x/y, x%y])
        of Floating   || Floating       :   return newBlock(@[x/y, x%y])
        of Floating   || Rational       :   return newBlock(@[x/y, x%y])

        of Rational   || Integer        :   return newBlock(@[x/y, x%y])
        of Rational   || Floating       :   return newBlock(@[x/y, x%y])
        of Rational   || Rational       :   return newBlock(@[x/y, x%y])
        
        of Quantity   || Integer        :   return newBlock(@[x/y, x%y])
        of Quantity   || Floating       :   return newBlock(@[x/y, x%y])
        of Quantity   || Rational       :   return newBlock(@[x/y, x%y])
        of Quantity   || Quantity       :   return newBlock(@[x/y, x%y])
        else:
            return invalidOperation("divmod")

{.push overflowChecks: on.}
proc `/%=`*(x: var Value, y: Value) =
    ## perform the divmod operation between given values
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer,Floating,Rational}) or not (y.kind in {Integer,Floating,Rational}):
        x = newBlock(@[x/y, x%y])
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    x = newBlock(@[x/y, x%y])
                else:
                    when defined(WEB):
                        x = newBlock(@[x/y, x%y])
                    elif not defined(NOGMP):
                        let dm = divmod(x.i, y.bi)
                        x = newBlock(@[newInteger(dm.q), newInteger(dm.r)])
            else:
                when defined(WEB):
                    x = newBlock(@[x/y, x%y])
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        let dm = divmod(x.bi, y.bi)
                        x = newBlock(@[newInteger(dm.q), newInteger(dm.r)])
                    else:
                        let dm = divmod(x.bi, y.i)
                        x = newBlock(@[newInteger(dm.q), newInteger(dm.r)])
        else:
            if x.kind==Floating:
                if y.kind==Floating: x = newBlock(@[x/y, x%y])
                elif y.kind==Rational: x = newBlock(@[x/y, x%y])
                else: 
                    if likely(y.iKind==NormalInteger):
                        x = newBlock(@[x/y, x%y])
                    else:
                        discard
                        # when not defined(NOGMP):
                        #     return newFloating(x.f mod y.bi)
            elif x.kind==Rational:
                if y.kind==Floating: x = newBlock(@[x/y, x%y])
                elif y.kind==Rational: x = newBlock(@[x/y, x%y])
                else: x = newBlock(@[x/y, x%y])
            else:
                if y.kind==Rational:
                    x = newBlock(@[x/y, x%y])
                else:
                    if likely(x.iKind==NormalInteger):
                        x = newBlock(@[x/y, x%y])
                    else:
                        discard
{.pop.}
proc `^`*(x: Value, y: Value): Value =
    ## perform the power operation between given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerPow(x.i, y.i)
        of BigInteger || Integer        :   (when GMP: return newInteger(pow(x.bi, culong(y.i))))
        of Integer    || Floating       :   return newFloating(pow(float(x.i), y.f))
        of BigInteger || Floating       :   (when GMP: return newFloating(pow(x.bi, y.f)))

        of Floating   || Integer        :   return newFloating(pow(x.f, float(y.i)))
        of Floating   || BigInteger     :   (when GMP: return newFloating(pow(x.f, y.bi)))
        of Floating   || Floating       :   return newFloating(pow(x.f, y.f))

        of Rational   || Integer        :   return newRational(normalIntegerPow(x.rat.num, y.i), normalIntegerPow(x.rat.den, y.i))
        of Rational   || Floating       :   discard notZero(x.rat.den); return newRational(pow(float(x.rat.num), y.f) / pow(float(x.rat.den), y.f))

        of Complex    || Integer        :   return newComplex(pow(x.z, float(y.i)))
        of Complex    || Floating       :   return newComplex(pow(x.z, y.f))
        of Complex    || Complex        :   return newComplex(pow(x.z, y.z))
        
        of Quantity   || Integer        :   
            case y.i:
                of 0: return newInteger(1)
                of 1: return x
                of 2: return x * x
                of 3: return x * x * x
                else:
                    RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
        of Quantity   || Floating       :
            case y.f:
                of 0.0: return newInteger(1)
                of 1.0: return x
                of 2.0: return x * x
                of 3.0: return x * x * x
                else:
                    RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
        else:
            return invalidOperation("pow")

{.push overflowChecks: on.}
proc `^=`*(x: var Value, y: Value) =
    ## perform the power operation between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating}):
        if x.kind == Quantity:
            if y.kind==Integer and (y.i > 0 and y.i < 4):
                if y.i == 1: discard
                elif y.i == 2: x *= x
                elif y.i == 3: x *= x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            elif y.kind==Floating and (y.f > 0 and y.f < 4):
                if y.f == 1.0: discard
                elif y.f == 2.0: x *= x
                elif y.f == 3.0: x *= x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            else:
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
        else: 
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            let res = pow(float(x.i),float(y.i))
            x = newInteger(int(res))
        else:
            if x.kind==Floating:
                if y.kind==Floating: x = newFloating(pow(x.f,y.f))
                elif y.kind==Complex: discard
                else: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(pow(x.f,float(y.i)))
                    else:
                        when not defined(NOGMP):
                            x = newFloating(pow(x.f,y.bi))
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(pow(x.z,float(y.i)))
                    else: discard
                elif y.kind==Floating: x = newComplex(pow(x.z,y.f))
                else: x = newComplex(pow(x.z,y.z))
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newRational(safePow(x.rat.num,y.i),safePow(x.rat.den,y.i))
                    else: discard
                elif y.kind==Floating: x = newRational(pow(float(x.rat.num), y.f) / pow(float(x.rat.den), y.f))
                else: discard
            else:
                if y.kind==Floating:
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(pow(float(x.i),y.f))
                    else:
                        when not defined(NOGMP):
                            x = newFloating(pow(x.bi,y.f))
                else: discard
{.pop.}
proc `&&`*(x: Value, y: Value): Value =
    ## perform binary-AND between given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerAnd(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(toBig(x.i) and y.bi))
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi and toBig(y.i)))
        of BigInteger || BigInteger     :   (when GMP: return newInteger(x.bi and y.bi))
        of Integer    || Binary         :   return newBinary(numberToBinary(x.i) and y.n)

        of Binary     || Integer        :   return newBinary(x.n and numberToBinary(y.i))
        of Binary     || Binary         :   return newBinary(x.n and y.n)

        else:
            return invalidOperation("and")

{.push overflowChecks: on.}
proc `&&=`*(x: var Value, y: Value) =
    ## perform binary-and between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        x = newBinary(a and b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i and y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) and y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i and y.bi)
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi and y.bi)
                else:
                    x = newInteger(x.bi and big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi and y.bi)
                else:
                    x = newInteger(x.bi and y.i)
{.pop.}
proc `||`*(x: Value, y: Value): Value =
    ## perform binary-OR between given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerOr(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(toBig(x.i) or y.bi))
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi or toBig(y.i)))
        of BigInteger || BigInteger     :   (when GMP: return newInteger(x.bi or y.bi))
        of Integer    || Binary         :   return newBinary(numberToBinary(x.i) or y.n)

        of Binary     || Integer        :   return newBinary(x.n or numberToBinary(y.i))
        of Binary     || Binary         :   return newBinary(x.n or y.n)

        else:
            return invalidOperation("or")
{.push overflowChecks: on.}
proc `||=`*(x: var Value, y: Value) =
    ## perform binary-or between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        x = newBinary(a or b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i or y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) or y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i or y.bi)
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi or y.bi)
                else:
                    x = newInteger(x.bi or big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi or y.bi)
                else:
                    x = newInteger(x.bi or y.i)
{.pop.}
proc `^^`*(x: Value, y: Value): Value =
    ## perform binary-XOR between given values and return the result
    
    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerXor(x.i, y.i)
        of Integer    || BigInteger     :   (when GMP: return newInteger(toBig(x.i) xor y.bi))
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi xor toBig(y.i)))
        of BigInteger || BigInteger     :   (when GMP: return newInteger(x.bi xor y.bi))
        of Integer    || Binary         :   return newBinary(numberToBinary(x.i) xor y.n)

        of Binary     || Integer        :   return newBinary(x.n xor numberToBinary(y.i))
        of Binary     || Binary         :   return newBinary(x.n xor y.n)

        else:
            return invalidOperation("xor")
{.push overflowChecks: on.}
proc `^^=`*(x: var Value, y: Value) =
    ## perform binary-xor between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        x = newBinary(a xor b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i xor y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) xor y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i xor y.bi)
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi xor y.bi)
                else:
                    x = newInteger(x.bi xor big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi xor y.bi)
                else:
                    x = newInteger(x.bi xor y.i)
{.pop.}
proc `!!`*(x: Value): Value =
    ## perform binary-NOT on given value and return the result

    case x.kind:
        of Integer:
            if x.iKind==NormalInteger: return normalIntegerNot(x.i)
            else: (when GMP: return newInteger(not x.bi))
        of Binary: return newBinary(not x.n)
        else:
            return invalidOperation("not")

{.push overflowChecks: on.}
proc `!!=`*(x: var Value) =
    ## perform binary-not for given value
    ## and store the result back in it
    ## 
    ## **Hint:** In-place, mutation operation
    if x.kind == Binary:
        x = newBinary(not x.n)
    elif not (x.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            x = newInteger(not x.i)
        else:
            when not defined(NOGMP):
                x = newInteger(not x.bi)

{.pop.}
proc `<<`*(x: Value, y: Value): Value =
    ## perform binary left-shift between given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerShl(x.i, y.i)
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi shl culong(y.i)))
        else:
            return invalidOperation("shl")
    
{.push overflowChecks: on.}
proc `<<=`*(x: var Value, y: Value) =
    ## perform binary-left-shift between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i shl y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) shl y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shl",valueAsString(x), valueAsString(y))
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi shl y.bi)
                else:
                    x = newInteger(x.bi shl big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    RuntimeError_NumberOutOfPermittedRange("shl",valueAsString(x), valueAsString(y))
                else:
                    x = newInteger(x.bi shl culong(y.i))

{.pop.}
proc `>>`*(x: Value, y: Value): Value =
    ## perform binary right-shift between given values and return the result

    let pair = getValuePair()
    case pair:
        of Integer    || Integer        :   return normalIntegerShr(x.i, y.i)
        of BigInteger || Integer        :   (when GMP: return newInteger(x.bi shr culong(y.i)))
        else:
            return invalidOperation("shr")

{.push overflowChecks: on.}
proc `>>=`*(x: var Value, y: Value) =
    ## perform binary-right-shift between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i shr y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) shr y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shr",valueAsString(x), valueAsString(y))
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi shr y.bi)
                else:
                    x = newInteger(x.bi shr big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    RuntimeError_NumberOutOfPermittedRange("shr",valueAsString(x), valueAsString(y))
                else:
                    x = newInteger(x.bi shr culong(y.i))

proc factorial*(x: Value): Value =
    ## calculate factorial of given value
    if not (x.kind == Integer):
        return VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if x.i < 21:
                when defined(WEB):
                    if x.i < 13:
                        return newInteger(fac(x.i))
                    else:
                        let items = (toSeq(1..x.i)).map((w)=>newInteger(w))
                        var res = newInteger(1)
                        for item in items:
                            res = res * item
                        return res
                else:
                    return newInteger(fac(x.i))
            else:
                when defined(WEB):
                    let items = (toSeq(1..x.i)).map((w)=>newInteger(w))
                    var res = newInteger(1)
                    for item in items:
                        res = res * item
                elif defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("factorial",valueAsString(x), "")
                else:
                    return newInteger(newInt().fac(x.i))
        else:
            when not defined(WEB):
                RuntimeError_NumberOutOfPermittedRange("factorial",valueAsString(x), "")
{.pop.}