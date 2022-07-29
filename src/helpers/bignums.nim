######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/bignums.nim
######################################################

# Code based on Nim GMP wrapper
# (c) Copyright 2014 Will Szumski

#=======================================
# Libraries
#=======================================

import os

import extras/gmp
import extras/mpfr
export gmp

#=======================================
# Types
#=======================================

type 
    Int* = ref mpz_t
    Float* = ref mpfr
    Rat* = ref mpq_t

#=======================================
# Constants
#=======================================

const
    FloatOverflow* = -18966.18966

#=======================================
# Helpers
#=======================================

func validBase(base: cint) =
    if base < -36 or (base > -2 and base < 2) or base > 62:
        raise newException(ValueError, "Invalid base")

func isLLP64: bool {.compileTime.} =
    sizeof(clong) != sizeof(int)

when defined(windows):
    const LLP64_ULONG_MAX = 0xFFFFFFFF

    proc fitsLLP64Long(x: int): bool =
        return x >= low(clong) and x <= high(clong)

    proc fitsLLP64ULong(x: int): bool =
        return x >= 0 and x <= LLP64_ULONG_MAX

proc fitsDouble*(x: Float): bool =
    if mpfr_fits_uint_p(x[], MPFR_RNDN)==0:
        return false
    else:
        return true

func sign*(x: Int): cint =
    mpz_sgn(x[])

#=======================================
# Constructors
#=======================================

func newInt*(x: culong): Int =
    new(result, finalizeInt)
    mpz_init_set_ui(result[], x)

func newInt*(x: int = 0): Int =
    new(result, finalizeInt)
    when isLLP64():
        if x.fitsLLP64Long:
            mpz_init_set_si(result[], x.clong)
        elif x.fitsLLP64ULong:
            mpz_init_set_ui(result[], x.culong)
        else:
            mpz_init(result[])
            if x < 0: result[].mp_size = -1 else: result[].mp_size = 1
            if x < 0 and x > low(int):
                result[].mp_d[] = (-x).mp_limb_t
            else:
                result[].mp_d[] = x.mp_limb_t
    else:
        mpz_init_set_si(result[], x.clong)

func newInt*(x: Float): Int =
    new(result,finalizeInt)
    mpz_init(result[])
    mpz_set_d(result[], mpfr_get_d(x[], MPFR_RNDN))

func newInt*(s: string, base: cint = 10): Int =
    validBase(base)
    new(result, finalizeInt)
    if mpz_init_set_str(result[], s, base) == -1:
        raise newException(ValueError, "String not in correct base")

func newFloat*(x: float): Float =
    new(result, finalizeFloat)
    mpfr_init(result[])
    mpfr_set_d(result[], x, MPFR_RNDN)

func newFloat*(x: culong): Float =
    new(result, finalizeFloat)
    mpfr_init(result[])
    mpfr_set_ui(result[], x, MPFR_RNDN)

func newFloat*(x: int = 0): Float =
    new(result, finalizeFloat)
    mpfr_init(result[])
    mpfr_set_si(result[], x.clong, MPFR_RNDN)

func newFloat*(x: Int): Float =
    new(result,finalizeFloat)
    mpfr_init(result[])
    mpfr_set_z(result[], x[], MPFR_RNDN)

func newFloat*(s: string, base: cint = 10): Float =
    validBase(base)
    new(result, finalizeFloat)
    mpfr_init(result[])
    if mpfr_set_str(result[], s, base, MPFR_RNDN) == -1:
        raise newException(ValueError, "String not in correct base")

#=======================================
# Setters
#=======================================

func set*(z, x: Int): Int =
    result = z
    mpz_set(result[], x[])

func set*(z: Int, x: culong): Int =
    result = z
    mpz_set_ui(result[], x)

func set*(z: Int, x: int): Int =
    result = z
    when isLLP64():
        if x.fitsLLP64Long:
            mpz_set_si(result[], x.clong)
        elif x.fitsLLP64ULong:
            mpz_set_ui(result[], x.culong)
        else:
            if x < 0: result[].mp_size = -1 else: result[].mp_size = 1
            if x < 0 and x > low(int):
                result[].mp_d[] = (-x).mp_limb_t
            else:
                result[].mp_d[] = x.mp_limb_t
    else:
        mpz_set_si(result[], x.clong)

func set*(z: Int, s: string, base: cint = 10): Int =
    validBase(base)
    result = z
    if mpz_set_str(result[], s, base) == -1:
        raise newException(ValueError, "String not in correct base")

#=======================================
# Converters
#=======================================

func toCLong*(x: Int): clong =
    mpz_get_si(x[])

func toCDouble*(x: Float): cdouble =
    var outOfRange = false
    var floatVal: float
  
    floatVal = mpfr_get_d(x[], MPFR_RNDN)
    
    return floatVal

#=======================================
# Overloads
#=======================================

#-----------------------
# Comparison
#-----------------------

func cmp*(x, y: Int): cint =
    result = mpz_cmp(x[], y[])
    if result < 0:
        result = -1
    elif result > 0:
        result = 1

func cmp*(x: Int, y: culong): cint =
    result = mpz_cmp_ui(x[], y)
    if result < 0:
        result = -1
    elif result > 0:
        result = 1

func cmp*(x: Int, y: int): cint =
    when isLLP64():
        if y.fitsLLP64Long:
            result = mpz_cmp_si(x[], y.clong)
        elif y.fitsLLP64ULong:
            return x.cmp(y.culong)
        else:
            var size: cint
            if y < 0: size = -1 else: size = 1
            if x[].mp_size != size:
                if x[].mp_size != 0:
                    result = x[].mp_size
                else:
                    if size == -1: result = 1 else: result = -1
            else:
                var op1, op2: mp_limb_t
                if size == -1 and y > low(int):
                    op1 = (-y).mp_limb_t
                    op2 = x[].mp_d[]
                else:
                    if y == low(int):
                        op1 = y.mp_limb_t
                        op2 = x[].mp_d[]
                    else:
                        op1 = x[].mp_d[]
                        op2 = y.mp_limb_t

                if op1 == op2:
                    result = 0
                elif op1 > op2:
                    result = 1
                else:
                    result = -1
    else:
        result = mpz_cmp_si(x[], y.clong)

    if result < 0:
        result = -1
    elif result > 0:
        result = 1

func cmp*(x, y: Float): cint =
    result = mpfr_cmp(x[], y[])
    if result < 0:
        result = -1
    elif result > 0:
        result = 1

func cmp*(x: Float, y: culong): cint =
    result = mpfr_cmp_ui(x[], y)
    if result < 0:
        result = -1
    elif result > 0:
        result = 1

func cmp*(x: Float, y: cdouble): cint =
    result = mpfr_cmp_d(x[], y)
    if result < 0:
        result = -1
    elif result > 0:
        result = 1

func cmp*(x: Float, y: int): cint =
    when isLLP64():
        if y.fitsLLP64Long:
            result = mpfr_cmp_si(x[], y.clong)
        elif y.fitsLLP64ULong:
            return x.cmp(y.culong)
        else:
            var size: cint
            if y < 0: size = -1 else: size = 1
            if x[].mp_size != size:
                if x[].mp_size != 0:
                    result = x[].mp_size
                else:
                    if size == -1: result = 1 else: result = -1
            else:
                var op1, op2: mp_limb_t
                if size == -1 and y > low(int):
                    op1 = (-y).mp_limb_t
                    op2 = x[].mp_d[]
                else:
                    if y == low(int):
                        op1 = y.mp_limb_t
                        op2 = x[].mp_d[]
                    else:
                        op1 = x[].mp_d[]
                        op2 = y.mp_limb_t

                if op1 == op2:
                    result = 0
                elif op1 > op2:
                    result = 1
                else:
                    result = -1
    else:
        result = mpfr_cmp_si(x[], y.clong)

    if result < 0:
        result = -1
    elif result > 0:
        result = 1

func `==`*(x: Int, y: int | culong | Int): bool =
    cmp(x, y) == 0

func `==`*(x: int | culong, y: Int): bool =
    cmp(y, x) == 0

func `==`*(x: Float, y: int | float | culong | Float): bool =
    cmp(x, y) == 0

func `==`*(x: float | int | culong, y: Float): bool =
    cmp(y, x) == 0

func `<`*(x: Int, y: int | culong | Int): bool =
    cmp(x, y) == -1

func `<`*(x: int | culong, y: Int): bool =
    cmp(y, x) == 1

func `<=`*(x: Int, y: int | culong | Int): bool =
    let c = cmp(x, y)
    c == 0 or c == -1

func `<=`*(x: int | culong, y: Int): bool =
    let c = cmp(y, x)
    c == 0 or c == 1

#-----------------------
# Arithmetic operators
#-----------------------

func add*(z, x, y: Int): Int =
    result = z
    mpz_add(result[], x[], y[])

func add*(z, x: Int, y: culong): Int =
    result = z
    mpz_add_ui(result[], x[], y)

func add*(z, x: Int, y: int): Int =
    when isLLP64():
        if y.fitsLLP64ULong: z.add(x, y.culong) else: z.add(x, newInt(y))
    else:
        if y >= 0: z.add(x, y.culong) else: z.add(x, newInt(y))

func inc*(z: Int, x: int | culong | Int) =
    discard z.add(z, x)

func `+`*(x: Int, y: int | culong | Int): Int =
    newInt().add(x, y)

func `+`*(x: int | culong, y: Int): Int =
    newInt().add(y, x)

func `+`*(x: float, y: Int): float =
    var res = newFloat()
    mpfr_add_z(res[], newFloat(x)[], y[], MPFR_RNDN)
    result = toCDouble(res)

func `+`*(x:Int, y: float): float =
    let res = newFloat()
    mpfr_add_d(res[], newFloat(x)[], y, MPFR_RNDN)
    result = toCDouble(res)

func `+=`*(z: Int, x: int | culong | Int) =
    z.inc(x)

func sub*(z, x, y: Int): Int =
    result = z
    mpz_sub(result[], x[], y[])

func sub*(z, x: Int, y: culong): Int =
    result = z
    mpz_sub_ui(result[], x[], y)

func sub*(z: Int, x: culong, y: Int): Int =
    result = z
    mpz_ui_sub(result[], x, y[])

func sub*(z, x: Int, y: int): Int =
    when isLLP64():
        if y.fitsLLP64ULong: z.sub(x, y.culong) else: z.sub(x, newInt(y))
    else:
        if y >= 0: z.sub(x, y.culong) else: z.sub(x, newInt(y))

func sub*(z: Int, x: int, y: Int): Int =
    when isLLP64():
        if x.fitsLLP64ULong: z.sub(x.culong, y) else: z.sub(newInt(x), y)
    else:
        if x >= 0: z.sub(x.culong, y) else: z.sub(newInt(x), y)

func dec*(z: Int, x: int | culong | Int) =
    discard z.sub(z, x)

func `-`*(x: Int, y: int | culong | Int): Int =
    newInt().sub(x, y)

func `-`*(x: int | culong, y: Int): Int =
    newInt().sub(x, y)

func `-`*(x: float, y: Int): float =
    var res = newFloat()
    mpfr_sub_z(res[], newFloat(x)[], y[], MPFR_RNDN)
    result = toCDouble(res)

func `-`*(x:Int, y: float): float =
    let res = newFloat()
    mpfr_sub_d(res[], newFloat(x)[], y, MPFR_RNDN)
    result = toCDouble(res)

func `-=`*(z: Int, x: int | culong | Int) =
    z.dec(x)

func mul*(z, x, y: Int): Int =
    result = z
    mpz_mul(result[], x[], y[])

func mul*(z, x: Int, y: culong): Int =
    result = z
    mpz_mul_ui(result[], x[], y)

func mul*(z, x: Float, y: Int): Float =
    result = z
    mpfr_mul_z(result[], x[], y[], MPFR_RNDN)

func mul*(z, x: Int, y: int): Int =
    result = z
    when isLLP64():
        if y.fitsLLP64Long:
            mpz_mul_si(result[], x[], y.clong)
        elif y.fitsLLP64ULong:
            mpz_mul_ui(result[], x[], y.culong)
        else:
            mpz_mul(result[], x[], newInt(y)[])
    else:
        mpz_mul_si(result[], x[], y.clong)

func `*`*(x: Int, y: int | culong | Int): Int =
    newInt().mul(x, y)

func `*`*(x: int | culong, y: Int): Int =
    newInt().mul(y, x)

func `*`*(x: float, y: Int): float =
    var res = newFloat()
    mpfr_mul_z(res[], newFloat(x)[], y[], MPFR_RNDN)
    result = toCDouble(res)

func `*`*(x:Int, y: float): float =
    let res = newFloat()
    mpfr_mul_d(res[], newFloat(x)[], y, MPFR_RNDN)
    result = toCDouble(res)

func `*=`*(z: Int, x: int | culong | Int) =
    discard z.mul(z, x)

func `div`*(z, x, y: Int): Int =
    if y == 0: raise newException(DivByZeroDefect, "Division by zero")
    result = z
    mpz_tdiv_q(result[], x[], y[])

func `div`*(z, x: Int, y: culong): Int =
    if y == 0: raise newException(DivByZeroDefect, "Division by zero")
    result = z
    discard mpz_tdiv_q_ui(result[], x[], y)

func `div`*(z, x: Int, y: int): Int =
    when isLLP64():
        if y.fitsLLP64ULong: z.`div`(x, y.culong) else: z.`div`(x, newInt(y))
    else:
        if y >= 0: z.`div`(x, y.culong) else: z.`div`(x, newInt(y))

func `div`*(x: Int, y: int | culong | Int): Int =
    newInt().`div`(x, y)

func `div`*(x: int | culong, y: Int): Int =
    newInt().`div`(newInt(x), y)

func `div`*(z, x, y: Float): Float =
    result = z
    mpfr_div(result[], x[], y[], MPFR_RNDN)

func `div`* (z, x: Float, y: int): Float =
    mpfr_div(result[], x[], newFloat(newInt(y))[], MPFR_RNDN)

func `div`* (z, x: Float, y: Int): Float =
    result = z
    mpfr_div(result[], x[], newFloat(y)[], MPFR_RNDN)

func `div`* (z, x: Float, y: float): Float =
    result = z
    mpfr_div_d(result[], x[], y, MPFR_RNDN)

func fdiv*(z, x, y: Int): Int =
    if y == 0: raise newException(DivByZeroDefect, "Division by zero")
    result = z
    mpz_fdiv_q(result[], x[], y[])

func fdiv*(z, x: Int, y: culong): Int =
    if y == 0: raise newException(DivByZeroDefect, "Division by zero")
    result = z
    discard mpz_fdiv_q_ui(result[], x[], y)

func fdiv*(z, x: Int, y: int): Int =
    when isLLP64():
        if y.fitsLLP64ULong: z.fdiv(x, y.culong) else: z.fdiv(x, newInt(y))
    else:
        if y >= 0: z.fdiv(x, y.culong) else: z.fdiv(x, newInt(y))

func fdiv*(x: Int, y: int | culong | Int): Int =
    newInt().fdiv(x, y)

func fdiv*(x: int | culong, y: Int): Int =
    newInt().fdiv(newInt(x), y)

func `//`*(x: Int, y: int | culong | Int): Int =
    fdiv(x, y)

func `//`*(x: int | culong, y: Int): Int =
    fdiv(x, y)

func `/`*(x: Float, y: Float | int | Int): Float =
    newFloat().div(x, y)

func `/`*(x: Float, y: float): Float = 
    newFloat().div(x, y)

func `/`*(x: float, y: Int): float =
    var res = newFloat()
    mpfr_div_z(res[], newFloat(x)[], y[], MPFR_RNDN)
    result = toCDouble(res)

func `/`*(x: Int, y: float): float =
    let res = newFloat()
    mpfr_div_d(res[], newFloat(x)[], y, MPFR_RNDN)
    result = toCDouble(res)

func `mod`*(z, x, y: Int): Int =
    if y == 0: raise newException(DivByZeroDefect, "Division by zero")
    result = z
    mpz_tdiv_r(result[], x[], y[])

func `mod`*(z, x: Int, y: culong): Int =
    if y == 0: raise newException(DivByZeroDefect, "Division by zero")
    result = z
    discard mpz_tdiv_r_ui(result[], x[], y)

func `mod`*(z, x: Int, y: int): Int =
    when isLLP64():
        if y.fitsLLP64ULong: z.`mod`(x, y.culong) else: z.`mod`(x, newInt(y))
    else:
        if y >= 0: z.`mod`(x, y.culong) else: z.`mod`(x, newInt(y))

func `mod`*(x: Int, y: int | culong | Int): Int =
    newInt().`mod`(x, y)

func `mod`*(x: int | culong, y: Int): Int =
    newInt().`mod`(newInt(x), y)

func pow*(z, x: Int, y: culong): Int =
    result = z
    mpz_pow_ui(z[], x[], y)

func pow*(z: Int, x, y: culong): Int =
    result = z
    mpz_ui_pow_ui(z[], x, y)

func pow*(x: culong | Int, y: culong): Int =
    newInt().pow(x, y)

func pow*(x: int, y: culong): Int =
    when isLLP64():
        if x.fitsLLP64ULong: pow(x.culong, y) else: pow(newInt(x), y)
    else:
        if x >= 0: pow(x.culong, y) else: pow(newInt(x), y)

func pow*(x: float, y: Int): float =
    var res = newFloat()
    mpfr_pow_z(res[], newFloat(x)[], y[], MPFR_RNDN)
    result = toCDouble(res)

func pow*(x: Int, y: float): float =
    let res = newFloat()
    mpfr_pow(res[], newFloat(x)[], newFloat(y)[], MPFR_RNDN)
    result = toCDouble(res)

func `^`*(x: int | culong | Int, y: culong): Int =
    pow(x, y)

func exp*(z, x: Int, y: culong, m: Int): Int =
    if m.sign == 0: return z.pow(x, y)
    result = z
    mpz_powm_ui(z[], x[], y, m[])

func exp*(z, x, y, m: Int): Int =
    result = z
    mpz_powm(z[], x[], y[], m[])

func exp*(x: Int, y: Int, m: Int): Int =
    newInt().exp(x, y, m)

func exp*(x: Int, y: culong, m: Int): Int =
    newInt().exp(x, y, m)

func exp*(x: Int, y: culong, m: int | culong): Int =
    exp(x, y, newInt(m))

func exp*(x: int | culong, y: culong, m: Int): Int =
    exp(newInt(x), y, m)

func sqrt*(z, x: Int): Int =
    result = z
    mpz_sqrt(z[], x[])

func sqrt*(x: Int): Int =
    newInt().sqrt(x)

#-----------------------
# Bitwise operators
#-----------------------

func `and`*(z, x, y: Int): Int =
    result = z
    mpz_and(z[], x[], y[])

func `and`*(x, y: Int): Int =
    newInt().`and`(x, y)

func `and`*(x: Int, y: int | culong): Int =
    x and newInt(y)

func `and`*(x: int | culong, y: Int): Int =
    newInt(x) and y

func `or`*(z, x, y: Int): Int =
    result = z
    mpz_ior(z[], x[], y[])

func `or`*(x, y: Int): Int =
    newInt().`or`(x, y)

func `or`*(x: Int, y: int | culong): Int =
    x or newInt(y)

func `or`*(x: int | culong, y: Int): Int =
    newInt(x) or y

func `xor`*(z, x, y: Int): Int =
    result = z
    mpz_xor(z[], x[], y[])

func `xor`*(x, y: Int): Int =
    newInt().`xor`(x, y)

func `xor`*(x: Int, y: int | culong): Int =
    x xor newInt(y)

func `xor`*(x: int | culong, y: Int): Int =
    newInt(x) xor y

func `not`*(z, x: Int): Int =
    result = z
    mpz_com(z[], x[])

func `not`*(x: Int): Int =
    newInt().`not` x

func `shr`*(z, x: Int, y: culong): Int =
    result = z
    mpz_fdiv_q_2exp(z[], x[], y)

func `shr`*(x: Int, y: culong): Int =
    newInt().`shr`(x, y)

func `shl`*(z, x: Int, y: culong): Int =
    result = z
    mpz_mul_2exp(z[], x[], y)

func `shl`*(x: Int, y: culong): Int =
    newInt().`shl`(x, y)

#-----------------------
# Output
#-----------------------

func digits*(z: Int, base: range[(2.cint) .. (62.cint)] = 10): csize_t =
    mpz_sizeinbase(z[], base)

func `$`*(z: Int, base: cint = 10): string =
    validBase(base)
    result = newString(digits(z, base) + 2)
    result.setLen(mpz_get_str((cstring)result, base, z[]).len)

# func `$`*(z: Float, base: range[(2.cint) .. (62.cint)] = 10, n_digits = 0): string =
#     # let outOfRange = toCDouble(z)
#     # if base == 10 and outOfRange != FloatOverflow:
#     #     return $outOfRange
  
#     var exp: mp_exp_t
#     var str = newString(n_digits + 1)
#     var coeff = $mpfr_get_str((cstring)str,exp,base,(csize_t)n_digits,z[],MPFR_RNDN)
#     coeff.insert(".", abs(exp))
#     return "str: " & str & ", coeff: " & coeff & ", exp: " & $exp
#     if (exp != 0):  return coeff & "e" & (if exp>0: "+" else: "") & $exp
#     if coeff == "": return "0.0"
#     result = coeff

#=======================================
# Methods
#=======================================

func positive*(x: Int): bool =
    x.sign >= 0

func negative*(x: Int): bool =
    x.sign < 0

func isZero*(x: Int): bool =
    x.sign == 0

func odd*(z: Int): bool =
    mpz_odd_p(z[]) != 0

func even*(z: Int): bool =
    mpz_even_p(z[]) != 0

func fac*(z, x: Int): Int =
    if x < 2:
        if x.negative:
            raise newException(RangeDefect, "Negative factorial")
        else:
            return z.set(1)

    result = z.set(2)
    var
        x0 = newInt(2)
        x1 = newInt(10)
        i = x // x0 - 1

    while i.sign == 1:
        x0 += x1
        x1 += 8
        result *= x0
        i.dec(1)

    if x.odd: result *= x

func fac*(z: Int, x: culong): Int =
    result = z
    mpz_fac_ui(result[], x)

func fac*(z: Int, x: int): Int =
    if x < 2:
        if x < 0:
            raise newException(RangeDefect, "Negative factorial")
        else:
            return z.set(1)

    result = z

    when isLLP64():
        if x.fitsLLP64ULong: discard z.fac(x.culong) else: discard z.fac(newInt(x))
    else:
        discard z.fac(x.culong)

func fac*(x: int | culong | Int): Int =
    newInt().fac(x)

func abs*(z, x: Int): Int =
    result = z
    mpz_abs(result[], x[])

func abs*(x: Int): Int =
    newInt().abs(x)

func gcd*(z, x, y: Int): Int =
    result = z
    mpz_gcd(z[], x[], y[])

func gcd*(z, x: Int, y: culong): Int =
    result = z
    discard mpz_gcd_ui(z[], x[], y)

func gcd*(z, x: Int, y: int): Int =
    when isLLP64():
        if y.fitsLLP64ULong: z.gcd(x, y.culong) else: z.gcd(x, newInt(y))
    else:
        if y >= 0: z.gcd(x, y.culong) else: z.gcd(x, newInt(y))

func gcd*(x: Int, y: int | culong | Int): Int =
    newInt().gcd(x, y)

func gcd*(x: int | culong, y: Int): Int =
    newInt().gcd(newInt(x), y)

func probablyPrime*(x: Int, n: cint): cint =
    mpz_probab_prime_p(x[], n)

func nextPrime*(z, x: Int): Int =
    result = z
    mpz_nextprime(z[], x[])

func nextPrime*(x: Int): Int =
    newInt().nextPrime(x)

#=======================================
# Destructors
#=======================================

func clear*(z: Int) =
    GCunref(z)
    finalizeInt(z)

func clear*(z: Float) =
    GCunref(z)
    finalizeFloat(z)

func clear*(z: Rat) =
    GCunref(z)
    finalizeRat(z)

# func clone*(z: Int): Int =
#     ## Returns a clone of `z`.
#     new(result, finalizeInt)
#     mpz_init_set(result[], z[])


# func swap*(x: Int, y: Int) =
#     ## Swaps the values `x` and `y` efficiently.
#     mpz_swap(x[], y[])

# func addMul*(z, x, y: Int): Int =
#     ## Increments `z` by `x` times `y`.
#     result = z
#     mpz_addmul(result[], x[], y[])

# func addMul*(z, x: Int, y: culong): Int =
#     ## Increments `z` by `x` times `y`.
#     result = z
#     mpz_addmul_ui(result[], x[], y)

# func addMul*(z, x: Int, y: int): Int =
#     ## Increments `z` by `x` times `y`.
#     when isLLP64():
#         if y.fitsLLP64ULong: z.addMul(x, y.culong) else: z.addMul(x, newInt(y))
#     else:
#         if y >= 0: z.addMul(x, y.culong) else: z.addMul(x, newInt(y))

# func addMul*(z: Int, x: int | culong, y: Int): Int =
#     ## Increments `z` by `x` times `y`.
#     z.addMul(y, x)

# func addMul*(z: Int, x: int | culong, y: int | culong): Int =
#     ## Increments `z` by `x` times `y`.
#     z.addMul(newInt(x), y)

# func subMul*(z, x, y: Int): Int =
#     ## Decrements `z` by `x` times `y`.
#     result = z
#     mpz_submul(result[], x[], y[])

# func subMul*(z, x: Int, y: culong): Int =
#     ## Decrements `z` by `x` times `y`.
#     result = z
#     mpz_submul_ui(result[], x[], y)

# func subMul*(z, x: Int, y: int): Int =
#     ## Decrements `z` by `x` times `y`.
#     when isLLP64():
#         if y.fitsLLP64ULong: z.subMul(x, y.culong) else: z.subMul(x, newInt(y))
#     else:
#         if y >= 0: z.subMul(x, y.culong) else: z.subMul(x, newInt(y))

# func subMul*(z: Int, x: int | culong, y: Int): Int =
#     ## Decrements `z` by `x` times `y`.
#     z.subMul(y, x)

# func subMul*(z: Int, x: int | culong, y: int | culong): Int =
#     ## Increments `z` by `x` times `y`.
#     z.subMul(newInt(x), y)

# template countupImpl(incr: stmt) {.immediate, dirty.} =
#   when a is int or a is culong:
#     var res = newInt(a)
#   else:
#     var res = a.clone

#   while res <= b:
#     yield res
#     incr

# iterator countup*(a: Int, b: int | culong | Int, step: int | culong | Int): Int {.inline.} =
#   ## Counts from `a` up to `b` with the given `step` count.
#   countupImpl: inc(res, step)

# iterator countup*(a: int | culong, b: Int, step: Int): Int {.inline.} =
#   ## Counts from `a` up to `b` with the given `step` count.
#   countupImpl: inc(res, step)

# iterator countup*(a: int | culong, b: int | culong, step: Int): Int {.inline.} =
#   ## Counts from `a` up to `b` with the given `step` count.
#   countupImpl: inc(res, step)

# iterator countup*(a: int | culong, b: Int, step: int | culong): Int {.inline.} =
#   ## Counts from `a` up to `b` with the given `step` count.
#   countupImpl: inc(res, step)

# iterator `..`*(a: Int, b: int | culong | Int): Int {.inline.} =
#   ## An alias for `countup`.
#   let step = 1
#   countupImpl: inc(res, step)

# iterator `..`*(a: int | culong, b: Int): Int {.inline.} =
#   ## An alias for `countup`.
#   let step = 1
#   countupImpl: inc(res, step)

# func modInverse*(z, g, n: Int): bool =
#     ## Computes the inverse of `g` modulo `n` and put the result in `z`. If the
#     ## inverse exists, the return value is `true` and `z` will satisfy
#     ## 0 < `z` < abs(`n`). If an inverse doesn't exist the return value is `false`
#     ## and `z` is undefined. The behaviour of this proc is undefined when `n` is
#     ## zero.
#     mpz_invert(z[], g[], n[]) != 0

# func modInverse*(g: Int, n: Int): Int =
#     ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
#     ## return value is undefined. The behaviour of this proc is undefined when `n`
#     ## is zero.
#     result = newInt()
#     discard modInverse(result, g, n)

# func modInverse*(g: Int, n: int | culong): Int =
#     ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
#     ## return value is undefined. The behaviour of this proc is undefined when `n`
#     ## is zero.
#     modInverse(g, newInt(n))

# func modInverse*(g: int | culong, n: Int): Int =
#     ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
#     ## return value is undefined. The behaviour of this proc is undefined when `n`
#     ## is zero.
#     modInverse(newInt(g), n)

# func divMod*(q, r, x, y: Int): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `divMod` implements truncated division towards zero.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = (q: q, r: r)
#     mpz_tdiv_qr(q[], r[], x[], y[])

# func divMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `divMod` implements truncated division towards zero.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = (q: q, r: r)
#     discard mpz_tdiv_qr_ui(q[], r[], x[], y)

# func divMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `divMod` implements truncated division towards zero.
#     when isLLP64():
#         if y.fitsLLP64ULong: divMod(q, r, x, y.culong) else: divMod(q, r, x, newInt(y))
#     else:
#         if y >= 0: divMod(q, r, x, y.culong) else: divMod(q, r, x, newInt(y))

# func divMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
#     ## Returns a tuple consisting of the quotient and remainder resulting from x/y
#     ## for `y` != 0.
#     ## `divMod` implements truncated division towards zero.
#     divMod(newInt(), newInt(), x, y)

# func divMod*(x: int | culong, y: Int): tuple[q, r: Int] =
#     ## Returns a tuple consisting of the quotient and remainder resulting from x/y
#     ## for `y` != 0.
#     ## `divMod` implements truncated division towards zero.
#     divMod(newInt(), newInt(), newInt(x), y)

# func fmod*(z, x, y: Int): Int =
#     ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
#     ## `fmod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = z
#     mpz_fdiv_r(result[], x[], y[])

# func fmod*(z, x: Int, y: culong): Int =
#     ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
#     ## `fmod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = z
#     discard mpz_fdiv_r_ui(result[], x[], y)

# func fmod*(z, x: Int, y: int): Int =
#     ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
#     ## `fmod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     when isLLP64():
#         if y.fitsLLP64ULong: z.fmod(x, y.culong) else: z.fmod(x, newInt(y))
#     else:
#         if y >= 0: z.fmod(x, y.culong) else: z.fmod(x, newInt(y))

# func fmod*(x: Int, y: int | culong | Int): Int =
#     ## Returns the remainder x/y for `y` != 0.
#     ## `fmod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     newInt().fmod(x, y)

# func fmod*(x: int | culong, y: Int): Int =
#     ## Returns the remainder x/y for `y` != 0.
#     ## `fmod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     newInt().fmod(newInt(x), y)

# func `\\`*(x: Int, y: int | culong | Int): Int =
#     ## Returns the remainder x/y for `y` != 0.
#     ## `\\` implements truncated division towards negative infinity.
#     fmod(x, y)

# func `\\`*(x: int | culong, y: Int): Int =
#     ## Returns the remainder x/y for `y` != 0.
#     ## `\\` implements truncated division towards negative infinity.
#     fmod(x, y)

# func fdivMod*(q, r, x, y: Int): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `fdivMod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = (q: q, r: r)
#     mpz_fdiv_qr(q[], r[], x[], y[])

# func fdivMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `fdivMod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = (q: q, r: r)
#     discard mpz_fdiv_qr_ui(q[], r[], x[], y)

# func fdivMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `fdivMod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     when isLLP64():
#         if y.fitsLLP64ULong: fdivMod(q, r, x, y.culong) else: fdivMod(q, r, x, newInt(y))
#     else:
#         if y >= 0: fdivMod(q, r, x, y.culong) else: fdivMod(q, r, x, newInt(y))

# func fdivMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
#     ## Returns a tuple consisting of the quotient and remainder resulting from x/y
#     ## for `y` != 0.
#     ## `fdivMod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     fdivMod(newInt(), newInt(), x, y)

# func fdivMod*(x: int | culong, y: Int): tuple[q, r: Int] =
#     ## Returns a tuple consisting of the quotient and remainder resulting from x/y
#     ## for `y` != 0.
#     ## `fdivMod` implements truncated division towards negative infinity.
#     ## The f stands for “floor”.
#     fdivMod(newInt(), newInt(), newInt(x), y)

# func cdiv*(z, x, y: Int): Int =
#     ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
#     ## `cdiv` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = z
#     mpz_cdiv_q(result[], x[], y[])

# func cdiv*(z, x: Int, y: culong): Int =
#     ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
#     ## `cdiv` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = z
#     discard mpz_cdiv_q_ui(result[], x[], y)

# func cdiv*(z, x: Int, y: int): Int =
#     ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
#     ## `cdiv` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     when isLLP64():
#         if y.fitsLLP64ULong: z.cdiv(x, y.culong) else: z.cdiv(x, newInt(y))
#     else:
#         if y >= 0: z.cdiv(x, y.culong) else: z.cdiv(x, newInt(y))

# func cdiv*(x: Int, y: int | culong | Int): Int =
#     ## Returns the quotient x/y for `y` != 0.
#     ## `cdiv` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     newInt().cdiv(x, y)

# func cdiv*(x: int | culong, y: Int): Int =
#     ## Returns the quotient x/y for `y` != 0.
#     ## `cdiv` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     newInt().cdiv(newInt(x), y)

# func cmod*(z, x, y: Int): Int =
#     ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
#     ## `cmod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = z
#     mpz_cdiv_r(result[], x[], y[])

# func cmod*(z, x: Int, y: culong): Int =
#     ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
#     ## `cmod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = z
#     discard mpz_cdiv_r_ui(result[], x[], y)

# func cmod*(z, x: Int, y: int): Int =
#     ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
#     ## `cmod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     when isLLP64():
#         if y.fitsLLP64ULong: z.cmod(x, y.culong) else: z.cmod(x, newInt(y))
#     else:
#         if y >= 0: z.cmod(x, y.culong) else: z.cmod(x, newInt(y))

# func cmod*(x: Int, y: int | culong | Int): Int =
#     ## Returns the remainder x/y for `y` != 0.
#     ## `cmod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     newInt().cmod(x, y)

# func cmod*(x: int | culong, y: Int): Int =
#     ## Returns the remainder x/y for `y` != 0.
#     ## `cmod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     newInt().cmod(newInt(x), y)

# func cdivMod*(q, r, x, y: Int): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `cdivMod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = (q: q, r: r)
#     mpz_cdiv_qr(q[], r[], x[], y[])

# func cdivMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `cdivMod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     if y == 0: raise newException(DivByZeroDefect, "Division by zero")
#     result = (q: q, r: r)
#     discard mpz_cdiv_qr_ui(q[], r[], x[], y)

# func cdivMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
#     ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
#     ## `y` != 0 and returns the tuple (`q`, `r`).
#     ## `cdivMod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     when isLLP64():
#         if y.fitsLLP64ULong: cdivMod(q, r, x, y.culong) else: cdivMod(q, r, x, newInt(y))
#     else:
#         if y >= 0: cdivMod(q, r, x, y.culong) else: cdivMod(q, r, x, newInt(y))

# func cdivMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
#     ## Returns a tuple consisting of the quotient and remainder resulting from x/y
#     ## for `y` != 0.
#     ## `cdivMod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     cdivMod(newInt(), newInt(), x, y)

# func cdivMod*(x: int | culong, y: Int): tuple[q, r: Int] =
#     ## Returns a tuple consisting of the quotient and remainder resulting from x/y
#     ## for `y` != 0.
#     ## `cdivMod` implements truncated division towards positive infinity.
#     ## The c stands for “ceil”.
#     cdivMod(newInt(), newInt(), newInt(x), y)

# proc mulRange*(z: Int, a: int | culong | Int, b: int | culong | Int): Int =
#   ## Sets `z` to the product of all values in the range [a, b] inclusively and
#   ## returns `z`.
#   ## If a > b (empty range), the result is 1.
#   when (a is int or a is culong) and (b is int or b is culong):
#     var a = cast[b.type](a)
#     var zero = cast[b.type](0)
#   elif b is culong:
#     var zero = cast[b.type](0)
#   else:
#     var zero = 0

#   if a > b: return z.set(1)                 # empty range
#   if a <= 0 and b >= zero: return z.set(0)  # range includes 0

#   result = z

#   # Can use fac proc if a = 1 or a = 2
#   if a == 1 or a == 2:
#     discard z.fac(b)
#   else:
#     # Slow
#     discard z.set(a)
#     for i in a + 1 .. b:
#       z *= i

# proc mulRange*(a: int | culong | Int, b: int | culong | Int): Int =
#   ## Returns the product of all values in the range [a, b] inclusively.
#   ## If a > b (empty range), the result is 1.
#   newInt().mulRange(a, b)

# func binom*(z, n: Int, k: culong): Int =
#     ## Sets `z` to the binomial coefficient of (`n`, `k`) and returns `z`.
#     result = z
#     mpz_bin_ui(z[], n[], k)

# func binom*(z: Int, n, k: culong): Int =
#     ## Sets `z` to the binomial coefficient of (`n`, `k`) and returns `z`.
#     result = z
#     mpz_bin_uiui(z[], n, k)

# proc binom*(n, k: Int): Int =
#   ## Returns the binomial coefficient of (`n`, `k`).
#   if k.sign <= 0: return newInt(1)
#   var a = newInt().mulRange(n - k + 1, n)
#   var b = newInt().mulRange(1, k)
#   return newInt().`div`(a, b)

# proc binom*(n: culong | Int, k: culong): Int =
#   ## Returns the binomial coefficient of (`n`, `k`).
#   newInt().binom(n, k)

# proc binom*(n: int | culong, k: Int): Int =
#   ## Returns the binomial coefficient of (`n`, `k`).
#   binom(newInt(n), k)

# proc binom*(n: Int, k: int): Int =
#   ## Returns the binomial coefficient of (`n`, `k`).
#   if k <= 0: return newInt(1)
#   when isLLP64():
#     if k.fitsLLP64Ulong:
#       result = binom(n, k.culong)
#     else:
#       result = binom(n, newInt(k))
#   else:
#     result = binom(n, k.culong)

# func bit*(x: Int, i: culong): cint =
#     ## Returns the value of the `i`'th bit of `x`.
#     mpz_tstbit(x[], i)

# func setBit*(z: Int, i: culong): Int =
#     ## Sets the i`'th bit of `z` and returns the resulting Int.
#     result = z
#     mpz_setbit(z[], i)

# func clearBit*(z: Int, i: culong): Int =
#     ## Clears the i`'th bit of `z` and returns the resulting Int.
#     result = z
#     mpz_clrbit(z[], i)

# func complementBit*(z: Int, i: culong): Int =
#     ## Complements the i`'th bit of `z` and returns the resulting Int.
#     result = z
#     mpz_combit(z[], i)

# func bitLen*(x: Int): csize_t =
#     ## Returns the length of the absolute value of `x` in bits.
#     digits(x, 2)

# func lcm*(z, x, y: Int): Int =
#     ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
#     result = z
#     mpz_lcm(z[], x[], y[])

# func lcm*(z, x: Int, y: culong): Int =
#     ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
#     result = z
#     mpz_lcm_ui(z[], x[], y)

# func lcm*(z, x: Int, y: int): Int =
#     ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
#     when isLLP64():
#         if y.fitsLLP64ULong: z.lcm(x, y.culong) else: z.lcm(x, newInt(y))
#     else:
#         if y >= 0: z.lcm(x, y.culong) else: z.lcm(x, newInt(y))

# func lcm*(x: Int, y: int | culong | Int): Int =
#     ## Returns the least common multiple of `x` and `y`.
#     newInt().lcm(x, y)

# func lcm*(x: int | culong, y: Int): Int =
#     ## Returns the least common multiple of `x` and `y`.
#     newInt().lcm(newInt(x), y)

# func fitsCULong*(x: Int): bool =
#     ## Returns whether `x` fits in a culong.
#     mpz_fits_ulong_p(x[]) != 0

# func fitsCLong*(x: Int): bool =
#     ## Returns whether `x` fits in a clong.
#     mpz_fits_slong_p(x[]) != 0

# func fitsInt*(x: Int): bool =
#     ## Returns whether `x` fits in an int.
#     when isLLP64():
#         if x[].mp_size < -1 or x[].mp_size > 1: return false
#         if x[].mp_size == 0: return true
#         if x[].mp_size > 0: return (x[].mp_d[]).uint <= high(int).uint
#         return x.cmp(low(int)) >= 0
#     else:
#         x.fitsClong

# func toCULong*(x: Int): culong =
#     ## Returns the value of `x` as a culong.
#     ## If `x` is too big to fit a culong then just the least significant bits that
#     ## do fit are returned. The sign of `x` is ignored, only the absolute value is
#     ## used. To find out if the value will fit, use the proc `fitsCULong`.
#     mpz_get_ui(x[])

# func toInt*(x: Int): int =
#     ## If `x` fits into an int returns the value of `x`. Otherwise returns the
#     ## least significant part of `x`, with the same sign as `x`.
#     ## If `x` is too big to fit in an int, the returned result is probably not
#     ## very useful. To find out if the value will fit, use the proc `fitsInt`.
#     when isLLP64():
#         if x[].mp_size > 0: return (x[].mp_d[]).int
#         if x[].mp_size < 0: return -1 - ((x[].mp_d[]).uint - 1).int
#         return 0
#     else:
#         x.toCLong

# func neg*(z, x: Int): Int =
#     ## Sets `z` to -`x` and returns `z`.
#     result = z
#     mpz_neg(z[], x[])

# func `-`*(x: Int): Int =
#     ## Unary `-` operator for an Int. Negates `x`.
#     newInt().neg(x)