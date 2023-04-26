#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/bignums.nim
#=======================================================

# Code initially based on Nim GMP wrapper
# (c) Copyright 2014 Will Szumski

# TODO(Helper/bignums) Is there any way *not* to use the GMP/MPFR library?
#  Right now, Arturo's BigNum handling capabilities are based exclusively on the GMP & MPFR libraries, and available only in the "full" builds. Could we replace them - with whatever shortcomings this might bring? For example: https://bellard.org/libbf/ seems like a good-enough candidate. It's small, fast enough - apparently - written in C, supports Integers and Floats + it's MIT-licensed.
#  Of course, we could just use it for the MINI builds - for its lack of external dependencies. Or use it for both. Or just have 2 different "full" builds: one with the GMP dependency, and one - slower but - without any dependencies. This could get messy, implementation-wise, but it's definitely doable.
#  labels: helpers, enhancement, open discussion

#=======================================
# Libraries
#=======================================

import math, os

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

proc getInt*(x: Int): int =
    return int(mpz_get_ui(x[]))

proc fitsInt*(x: Int): bool =
    return mpz_fits_ulong_p(x[]) != 0

proc fitsDouble*(x: Float): bool =
    if mpfr_fits_uint_p(x[], MPFR_RNDN)==0:
        return false
    else:
        return true

func sign*(x: Int): cint =
    mpz_sgn(x[])

func canonicalize*(x: Rat) =
    mpq_canonicalize(x[])

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
            mpz_init_set_ui(result[], (x shr 32).uint32)
            mpz_mul_2exp(result[], result[], 32)
            mpz_add_ui(result[], result[], (x.uint32))
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

func newRat*(x: culong): Rat =
    new(result, finalizeRat)
    mpq_init(result[])
    mpq_set_ui(result[], x, 1)
    canonicalize(result)

func newRat*(x, y: culong): Rat =
    new(result,finalizeRat)
    mpq_init(result[])
    mpq_set_ui(result[], x, y)
    canonicalize(result)

func newRat*(x: int = 0): Rat =
    new(result, finalizeRat)
    mpq_init(result[])
    when isLLP64():
        if x.fitsLLP64Long:
            mpq_set_si(result[], x.clong, 1)
        elif x.fitsLLP64ULong:
            mpq_set_ui(result[], x.culong, 1)
        else:
            mpq_set_ui(result[], (x shr 32).uint32, 1)
            mpq_mul_2exp(result[], result[], 32)
            mpq_add(result[], result[], newRat(x.uint32)[])
    else:
        mpq_set_si(result[], x.clong, 1)
    canonicalize(result)

func newRat*(x, y: int): Rat =
    new(result, finalizeRat)
    mpq_init(result[])
    when isLLP64():
        if x.fitsLLP64Long:
            mpq_set_si(result[], x.clong, y.clong)
        elif x.fitsLLP64ULong:
            mpq_set_ui(result[], x.culong, y.culong)
        else:
            # needs fix!
            mpq_set_ui(result[], (x shr 32).uint32, 1)
            mpq_mul_2exp(result[], result[], 32)
            mpq_add(result[], result[], newRat(x.uint32)[])
    else:
        mpq_set_si(result[], x.clong, y.culong)
    canonicalize(result)

func newRat*(x, y: Int): Rat =
    new(result,finalizeRat)
    mpq_init(result[])
    mpq_set_num(result[], x[])
    mpq_set_den(result[], y[])
    canonicalize(result)

func newRat*(x: float): Rat =
    new(result,finalizeRat)
    debugEcho "newRat with float"
    mpq_init(result[])
    mpq_set_d(result[], x)
    canonicalize(result)

func newRat*(x: Int): Rat =
    new(result,finalizeRat)
    mpq_init(result[])
    mpq_set_z(result[], x[])
    canonicalize(result)

func newRat*(s: string, base: cint = 10): Rat =
    validBase(base)
    new(result, finalizeRat)
    mpq_init(result[])
    if mpq_set_str(result[], s, base) == -1:
        raise newException(ValueError, "String not in correct base")
    canonicalize(result)

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
            mpz_init_set_si(result[], x.clong)
        elif x.fitsLLP64ULong:
            mpz_init_set_ui(result[], x.culong)
        else:
            mpz_init_set_ui(result[], (x shr 32).uint32)
            mpz_mul_2exp(result[], result[], 32)
            mpz_add_ui(result[], result[], (x.uint32))
    else:
        mpz_init_set_si(result[], x.clong)

func set*(z: Int, s: string, base: cint = 10): Int =
    validBase(base)
    result = z
    if mpz_set_str(result[], s, base) == -1:
        raise newException(ValueError, "String not in correct base")

func set*(z, x: Rat): Rat =
    result = z
    mpq_set(result[], x[])

func set*(z: Rat, x: culong): Rat =
    result = z
    mpq_set_ui(result[], x, 1)

func set*(z: Rat, x: int): Rat =
    result = z
    when isLLP64():
        if x.fitsLLP64Long:
            mpq_set_si(result[], x.clong, 1)
        elif x.fitsLLP64ULong:
            mpq_set_ui(result[], x.culong, 1)
        else:
            mpq_set_ui(result[], (x shr 32).uint32, 1)
            mpq_mul_2exp(result[], result[], 32)
            mpq_add(result[], result[], newRat(x.uint32)[])
    else:
        mpq_set_si(result[], x.clong, 1)

func set*(z: Rat, x: float): Rat =
    result = z
    mpq_set_d(result[], x)

func set*(z: Rat, s: string, base: cint = 10): Rat =
    validBase(base)
    result = z
    if mpq_set_str(result[], s, base) == -1:
        raise newException(ValueError, "String not in correct base")
    canonicalize(result)

#=======================================
# Converters
#=======================================

func toCLong*(x: Int): clong =
    mpz_get_si(x[])

func toCDouble*(x: Float): cdouble =
    return mpfr_get_d(x[], MPFR_RNDN)

func toCDouble*(x: Rat): cdouble =
    return mpq_get_d(x[])

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

# TODO(Bignums/cmp) should properly handle LLP64 mode
#  labels: critical, bug, windows
func cmp*(x: Int, y: int): cint =
    # when isLLP64():
    #     if y.fitsLLP64Long:
    #         result = mpz_cmp_si(x[], y.clong)
    #     elif y.fitsLLP64ULong:
    #         return x.cmp(y.culong)
    #     else:
    #         var size: cint
    #         if y < 0: size = -1 else: size = 1
    #         if x[].mp_size != size:
    #             if x[].mp_size != 0:
    #                 result = x[].mp_size
    #             else:
    #                 if size == -1: result = 1 else: result = -1
    #         else:
    #             var op1, op2: mp_limb_t
    #             if size == -1 and y > low(int):
    #                 op1 = (-y).mp_limb_t
    #                 op2 = x[].mp_d[]
    #             else:
    #                 if y == low(int):
    #                     op1 = y.mp_limb_t
    #                     op2 = x[].mp_d[]
    #                 else:
    #                     op1 = x[].mp_d[]
    #                     op2 = y.mp_limb_t

    #             if op1 == op2:
    #                 result = 0
    #             elif op1 > op2:
    #                 result = 1
    #             else:
    #                 result = -1
    # else:
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
    # when isLLP64():
    #     if y.fitsLLP64Long:
    #         result = mpfr_cmp_si(x[], y.clong)
    #     elif y.fitsLLP64ULong:
    #         return x.cmp(y.culong)
    #     else:
    #         var size: cint
    #         if y < 0: size = -1 else: size = 1
    #         if x[].mp_size != size:
    #             if x[].mp_size != 0:
    #                 result = x[].mp_size
    #             else:
    #                 if size == -1: result = 1 else: result = -1
    #         else:
    #             var op1, op2: mp_limb_t
    #             if size == -1 and y > low(int):
    #                 op1 = (-y).mp_limb_t
    #                 op2 = x[].mp_d[]
    #             else:
    #                 if y == low(int):
    #                     op1 = y.mp_limb_t
    #                     op2 = x[].mp_d[]
    #                 else:
    #                     op1 = x[].mp_d[]
    #                     op2 = y.mp_limb_t

    #             if op1 == op2:
    #                 result = 0
    #             elif op1 > op2:
    #                 result = 1
    #             else:
    #                 result = -1
    # else:
    result = mpfr_cmp_si(x[], y.clong)

    if result < 0:
        result = -1
    elif result > 0:
        result = 1

func cmp*(x: Rat, y: Rat): cint =
    result = mpq_cmp(x[], y[])
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

func `==`*(x, y: Rat): bool =
    cmp(x, y) == 0

func `<`*(x: Int, y: int | culong | Int): bool =
    cmp(x, y) == -1

func `<`*(x: int | culong, y: Int): bool =
    cmp(y, x) == 1

func `<`*(x, y: Rat): bool =
    cmp(x, y) == -1

func `<=`*(x: Int, y: int | culong | Int): bool =
    let c = cmp(x, y)
    c == 0 or c == -1

func `<=`*(x: int | culong, y: Int): bool =
    let c = cmp(y, x)
    c == 0 or c == 1

func `<=`*(x, y: Rat): bool =
    let c = cmp(x, y)
    c == 0 or c == -1

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

func add*(z, x, y: Rat): Rat =
    result = z
    mpq_add(result[], x[], y[])

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

func `+`*(x: Rat, y: Rat): Rat =
    newRat().add(x, y)

func `+=`*(x, y: Rat) =
    discard x.add(x, y)

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

func sub*(z, x, y: Rat): Rat =
    result = z
    mpq_sub(result[], x[], y[])

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

func `-`*(x: Rat, y: Rat): Rat =
    newRat().sub(x, y)

func `-=`*(z: Int, x: int | culong | Int) =
    z.dec(x)

func `-=`*(x, y: Rat) =
    discard x.sub(x, y)

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

func mul*(z, x, y: Rat): Rat =
    result = z
    mpq_mul(result[], x[], y[])

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

func `*`*(x: Rat, y: Rat): Rat =
    newRat().mul(x, y)

func `*=`*(z: Int, x: int | culong | Int) =
    discard z.mul(z, x)

func `*=`*(x, y: Rat) =
    discard x.mul(x, y)

func neg*(x: Rat): Rat =
    mpq_neg(result[], x[])

func inv*(x: Rat): Rat =
    mpq_inv(result[], x[])

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

func `div`*(z, x, y: Rat): Rat =
    result = z
    mpq_div(result[], x[], y[])

func `divI`*(x: Int, y: int | culong | Int) = 
    discard x.`div`(x, y)

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

func `/`*(x: Rat, y: Rat): Rat =
    newRat().div(x, y)

func `/=`*(x, y: Rat) =
    discard x.div(x, y)

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

func `modI`*(x: Int, y: int | culong | Int) = 
    discard x.`mod`(x, y)

func modInverse*(z, g, n: Int): bool =
    mpz_invert(z[], g[], n[]) != 0

func modInverse*(g: Int, n: Int): Int =
    result = newInt()
    discard modInverse(result, g, n)

func modInverse*(g: Int, n: int | culong): Int =
    modInverse(g, newInt(n))

func modInverse*(g: int | culong, n: Int): Int =
    modInverse(newInt(g), n)

func divMod*(q, r, x, y: Int): tuple[q, r: Int] =
    if y == 0: raise newException(DivByZeroDefect, "Division by zero")
    result = (q: q, r: r)
    mpz_tdiv_qr(q[], r[], x[], y[])

func divMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
    if y == 0: raise newException(DivByZeroDefect, "Division by zero")
    result = (q: q, r: r)
    discard mpz_tdiv_qr_ui(q[], r[], x[], y)

func divMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
    when isLLP64():
        if y.fitsLLP64ULong: divMod(q, r, x, y.culong) else: divMod(q, r, x, newInt(y))
    else:
        if y >= 0: divMod(q, r, x, y.culong) else: divMod(q, r, x, newInt(y))

func divMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
    divMod(newInt(), newInt(), x, y)

func divMod*(x: int | culong, y: Int): tuple[q, r: Int] =
    divMod(newInt(), newInt(), newInt(x), y)

func pow*(z, x: Int, y: culong): Int =
    result = z
    mpz_pow_ui(z[], x[], y)

func pow*(z: Int, x, y: culong): Int =
    result = z
    mpz_ui_pow_ui(z[], x, y)

func pow*(x: culong | Int, y: culong): Int =
    newInt().pow(x, y)

func powI*(x: Int, y: culong) =
    mpz_pow_ui(x[], x[], y)

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

func pow*(x: Rat, y: int): Rat =
    result = newRat()
    discard result.set(x)
    for i in 1 ..< y:
        discard result.mul(result, x)

func pow*(x: Rat, y: float): Rat =
    let res = pow(float(toCDouble(x)), y)
    result = newRat(res)

func `^`*(x: int | culong | Int, y: culong): Int =
    pow(x, y)

func `^`*(x: Rat, y: int): Rat =
    pow(x, y)

func `^`*(x: Rat, y: float): Rat =
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

func `andI`*(x: Int, y: culong | int) =
    mpz_and(x[], x[], newInt(y)[])

func `andI`*(x: Int, y: Int) =
    mpz_and(x[], x[], y[])

func `and`*(x: Int, y: int | culong): Int =
    x and newInt(y)

func `and`*(x: int | culong, y: Int): Int =
    newInt(x) and y

func `or`*(z, x, y: Int): Int =
    result = z
    mpz_ior(z[], x[], y[])

func `or`*(x, y: Int): Int =
    newInt().`or`(x, y)

func `orI`*(x: Int, y: culong | int) =
    mpz_ior(x[], x[], newInt(y)[])

func `orI`*(x: Int, y: Int) =
    mpz_ior(x[], x[], y[])

func `or`*(x: Int, y: int | culong): Int =
    x or newInt(y)

func `or`*(x: int | culong, y: Int): Int =
    newInt(x) or y

func `xor`*(z, x, y: Int): Int =
    result = z
    mpz_xor(z[], x[], y[])

func `xor`*(x, y: Int): Int =
    newInt().`xor`(x, y)

func `xorI`*(x: Int, y: culong | int) =
    mpz_xor(x[], x[], newInt(y)[])

func `xorI`*(x: Int, y: Int) =
    mpz_xor(x[], x[], y[])

func `xor`*(x: Int, y: int | culong): Int =
    x xor newInt(y)

func `xor`*(x: int | culong, y: Int): Int =
    newInt(x) xor y

func `not`*(z, x: Int): Int =
    result = z
    mpz_com(z[], x[])

func `not`*(x: Int): Int =
    newInt().`not` x

func `notI`*(x: Int) =
    mpz_com(x[], x[])

func `shr`*(z, x: Int, y: culong): Int =
    result = z
    mpz_fdiv_q_2exp(z[], x[], y)

func `shr`*(x: Int, y: culong): Int =
    newInt().`shr`(x, y)

func `shrI`*(x: Int, y: culong) =
    mpz_fdiv_q_2exp(x[], x[], y)

func `shl`*(z, x: Int, y: culong): Int =
    result = z
    mpz_mul_2exp(z[], x[], y)

func `shl`*(x: Int, y: culong): Int =
    newInt().`shl`(x, y)

func `shlI`*(x: Int, y: culong) =
    mpz_mul_2exp(x[], x[], y)

#-----------------------
# Output
#-----------------------

func digits*(z: Int, base: range[(2.cint) .. (62.cint)] = 10): csize_t =
    mpz_sizeinbase(z[], base)

func digits*(z: mpz_ptr, base: range[(2.cint) .. (62.cint)] = 10): csize_t =
    mpz_sizeinbase(z, base)

func numerator*(x: Rat): Int =
    result = newInt()
    mpq_get_num(result[], x[])
    
func denominator*(x: Rat): Int =
    result = newInt()
    mpq_get_den(result[], x[])

func `$`*(z: Int, base: cint = 10): string =
    validBase(base)
    result = newString(digits(z, base) + 2)
    result.setLen(mpz_get_str(cstring(result), base, z[]).len)

func `$`*(z: Float): string =
    result = newString(32)
    var exp = 0
    result.setLen(mpfr_get_str(cstring(result), exp, 10, 0, z[], MPFR_RNDN).len)

func `$`*(z: Rat, base: range[(2.cint) .. (62.cint)] = 10): string =
    validBase(base)
    result = newString(digits(mpq_numref(z[]), base) + digits(mpq_denref(z[]), base) + 3)
    result.setLen(mpq_get_str(cstring(result), base, z[]).len)

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

func abs*(z, x: Rat): Rat =
    result = z
    mpq_abs(result[], x[])

func abs*(x: Rat): Rat =
    newRat().abs(x)

func neg*(z, x: Int): Int =
    result = z
    mpz_neg(result[], x[])

func neg*(x: Int): Int =
    newInt().neg(x)

func negI*(x: Int) =
    mpz_neg(x[], x[])

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
    
func lcm*(z, x, y: Int): Int =
    result = z
    mpz_lcm(z[], x[], y[])

func lcm*(z, x: Int, y: culong): Int =
    result = z
    mpz_lcm_ui(z[], x[], y)

func lcm*(z, x: Int, y: int): Int =
    when isLLP64():
        if y.fitsLLP64ULong: z.lcm(x, y.culong) else: z.lcm(x, newInt(y))
    else:
        if y >= 0: z.lcm(x, y.culong) else: z.lcm(x, newInt(y))

func lcm*(x: Int, y: int | culong | Int): Int =
    newInt().lcm(x, y)

func lcm*(x: int | culong, y: Int): Int =
    newInt().lcm(newInt(x), y)

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

func clear*(z: Int) {.inline.} =
    GCunref(z)
    finalizeInt(z)

func clear*(z: Float) {.inline.} =
    GCunref(z)
    finalizeFloat(z)

func clear*(z: Rat) {.inline.} =
    GCunref(z)
    finalizeRat(z)
