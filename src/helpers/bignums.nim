######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/bignums.nim
######################################################

#=======================================
# Libraries
#=======================================

import os

import extras/gmp

type 
    Int* = ref mpz_t

# type Int* = ref mpz_t
## An Int represents a signed multi-precision integer.

func isLLP64: bool {.compileTime.} =
  # LLP64 programming model
  sizeof(clong) != sizeof(int)

{.push hints: off.}

# DECLARED_BUT_NOT_USED

when defined(windows):
  const LLP64_ULONG_MAX = 0xFFFFFFFF

  proc fitsLLP64Long(x: int): bool =
    # Returns whether `x` fits in a LLP64 signed long int.
    return x >= low(clong) and x <= high(clong)

  proc fitsLLP64ULong(x: int): bool =
    # Returns whether `x` fits in a LLP64 unsigned long int.
    return x >= 0 and x <= LLP64_ULONG_MAX

{.pop.}

func validBase(base: cint) =
  # Validates the given base.
  if base < -36 or (base > -2 and base < 2) or base > 62:
    raise newException(ValueError, "Invalid base")



func newInt*(x: culong): Int =
  ## Allocates and returns a new Int set to `x`.
  new(result, finalizeInt)
  mpz_init_set_ui(result[], x)

func newInt*(x: int = 0): Int =
  ## Allocates and returns a new Int set to `x`.
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

func newInt*(s: string, base: cint = 10): Int =
  ## Allocates and returns a new Int set to `s`, interpreted in the given `base`.
  validBase(base)
  new(result, finalizeInt)
  if mpz_init_set_str(result[], s, base) == -1:
    raise newException(ValueError, "String not in correct base")

func clear*(z: Int) =
  ## Clears the allocated space used by the number.
  ##
  ## This normally happens on a finalizer call, but if you want immediate
  ## deallocation you can call it.
  GCunref(z)
  finalizeInt(z)

func clone*(z: Int): Int =
  ## Returns a clone of `z`.
  new(result, finalizeInt)
  mpz_init_set(result[], z[])

func digits*(z: Int, base: range[(2.cint) .. (62.cint)] = 10): csize_t =
  ## Returns the size of `z` measured in number of digits in the given `base`.
  ## The sign of `z` is ignored, just the absolute value is used.
  mpz_sizeinbase(z[], base)

func `$`*(z: Int, base: cint = 10): string =
  ## The stringify operator for an Int argument. Returns `z` converted to a
  ## string in the given `base`.
  validBase(base)
  result = newString(digits(z, base) + 2)
  result.setLen(mpz_get_str((cstring)result, base, z[]).len)

func set*(z, x: Int): Int =
  ## Sets `z` to `x` and returns `z`.
  result = z
  mpz_set(result[], x[])

func set*(z: Int, x: culong): Int =
  ## Sets `z` to `x` and returns `z`.
  result = z
  mpz_set_ui(result[], x)

func set*(z: Int, x: int): Int =
  ## Sets `z` to `x` and returns `z`.
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
  ## Sets `z` to the value of `s`, interpreted in the given `base`, and returns `z`.
  validBase(base)
  result = z
  if mpz_set_str(result[], s, base) == -1:
    raise newException(ValueError, "String not in correct base")

func swap*(x: Int, y: Int) =
  ## Swaps the values `x` and `y` efficiently.
  mpz_swap(x[], y[])

func cmp*(x, y: Int): cint =
  ## Compares `x` and `y` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
  result = mpz_cmp(x[], y[])
  if result < 0:
    result = -1
  elif result > 0:
    result = 1

func cmp*(x: Int, y: culong): cint =
  ## Compares `x` and `y` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
  result = mpz_cmp_ui(x[], y)
  if result < 0:
    result = -1
  elif result > 0:
    result = 1

func cmp*(x: Int, y: int): cint =
  ## Compares `x` and `y` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
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

func `==`*(x: Int, y: int | culong | Int): bool =
  ## Returns whether `x` equals `y`.
  cmp(x, y) == 0

func `==`*(x: int | culong, y: Int): bool =
  ## Returns whether `x` equals `y`.
  cmp(y, x) == 0

func `<`*(x: Int, y: int | culong | Int): bool =
  ## Returns whether `x` is less than `y`.
  cmp(x, y) == -1

func `<`*(x: int | culong, y: Int): bool =
  ## Returns whether `x` is less than `y`.
  cmp(y, x) == 1

func `<=`*(x: Int, y: int | culong | Int): bool =
  ## Returns whether `x` is less than or equal `y`.
  let c = cmp(x, y)
  c == 0 or c == -1

func `<=`*(x: int | culong, y: Int): bool =
  ## Returns whether `x` is less than or equal `y`.
  let c = cmp(y, x)
  c == 0 or c == 1

func sign*(x: Int): cint =
  ## Allows faster testing for negative, zero, and positive. Returns:
  ## ::
  ##   -1 if x <  0
  ##    0 if x == 0
  ##   +1 if x >  0
  mpz_sgn(x[])

func positive*(x: Int): bool =
  ## Returns whether `x` is positive or zero.
  x.sign >= 0

func negative*(x: Int): bool =
  ## Returns whether `x` is negative.
  x.sign < 0

func isZero*(x: Int): bool =
  ## Returns whether `x` is zero.
  x.sign == 0

func abs*(z, x: Int): Int =
  ## Sets `z` to |x| (the absolute value of `x`) and returns `z`.
  result = z
  mpz_abs(result[], x[])

func abs*(x: Int): Int =
  ## Returns the absolute value of `x`.
  newInt().abs(x)

func add*(z, x, y: Int): Int =
  ## Sets `z` to the sum x+y and returns `z`.
  result = z
  mpz_add(result[], x[], y[])

func add*(z, x: Int, y: culong): Int =
  ## Sets `z` to the sum x+y and returns `z`.
  result = z
  mpz_add_ui(result[], x[], y)

func add*(z, x: Int, y: int): Int =
  ## Sets `z` to the sum x+y and returns `z`.
  when isLLP64():
    if y.fitsLLP64ULong: z.add(x, y.culong) else: z.add(x, newInt(y))
  else:
    if y >= 0: z.add(x, y.culong) else: z.add(x, newInt(y))

func `+`*(x: Int, y: int | culong | Int): Int =
  ## Returns the sum x+y.
  newInt().add(x, y)

func `+`*(x: int | culong, y: Int): Int =
  ## Returns the sum x+y.
  newInt().add(y, x)

func sub*(z, x, y: Int): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  result = z
  mpz_sub(result[], x[], y[])

func sub*(z, x: Int, y: culong): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  result = z
  mpz_sub_ui(result[], x[], y)

func sub*(z: Int, x: culong, y: Int): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  result = z
  mpz_ui_sub(result[], x, y[])

func sub*(z, x: Int, y: int): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  when isLLP64():
    if y.fitsLLP64ULong: z.sub(x, y.culong) else: z.sub(x, newInt(y))
  else:
    if y >= 0: z.sub(x, y.culong) else: z.sub(x, newInt(y))

func sub*(z: Int, x: int, y: Int): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  when isLLP64():
    if x.fitsLLP64ULong: z.sub(x.culong, y) else: z.sub(newInt(x), y)
  else:
    if x >= 0: z.sub(x.culong, y) else: z.sub(newInt(x), y)

func `-`*(x: Int, y: int | culong | Int): Int =
  ## Returns the difference x-y.
  newInt().sub(x, y)

func `-`*(x: int | culong, y: Int): Int =
  ## Returns the difference x-y.
  newInt().sub(x, y)

func addMul*(z, x, y: Int): Int =
  ## Increments `z` by `x` times `y`.
  result = z
  mpz_addmul(result[], x[], y[])

func addMul*(z, x: Int, y: culong): Int =
  ## Increments `z` by `x` times `y`.
  result = z
  mpz_addmul_ui(result[], x[], y)

func addMul*(z, x: Int, y: int): Int =
  ## Increments `z` by `x` times `y`.
  when isLLP64():
    if y.fitsLLP64ULong: z.addMul(x, y.culong) else: z.addMul(x, newInt(y))
  else:
    if y >= 0: z.addMul(x, y.culong) else: z.addMul(x, newInt(y))

func addMul*(z: Int, x: int | culong, y: Int): Int =
  ## Increments `z` by `x` times `y`.
  z.addMul(y, x)

func addMul*(z: Int, x: int | culong, y: int | culong): Int =
  ## Increments `z` by `x` times `y`.
  z.addMul(newInt(x), y)

func subMul*(z, x, y: Int): Int =
  ## Decrements `z` by `x` times `y`.
  result = z
  mpz_submul(result[], x[], y[])

func subMul*(z, x: Int, y: culong): Int =
  ## Decrements `z` by `x` times `y`.
  result = z
  mpz_submul_ui(result[], x[], y)

func subMul*(z, x: Int, y: int): Int =
  ## Decrements `z` by `x` times `y`.
  when isLLP64():
    if y.fitsLLP64ULong: z.subMul(x, y.culong) else: z.subMul(x, newInt(y))
  else:
    if y >= 0: z.subMul(x, y.culong) else: z.subMul(x, newInt(y))

func subMul*(z: Int, x: int | culong, y: Int): Int =
  ## Decrements `z` by `x` times `y`.
  z.subMul(y, x)

func subMul*(z: Int, x: int | culong, y: int | culong): Int =
  ## Increments `z` by `x` times `y`.
  z.subMul(newInt(x), y)

func inc*(z: Int, x: int | culong | Int) =
  ## Increments `z` by `x`.
  discard z.add(z, x)

func dec*(z: Int, x: int | culong | Int) =
  ## Decrements `z` by `x`.
  discard z.sub(z, x)

func `+=`*(z: Int, x: int | culong | Int) =
  ## Increments `z` by `x`.
  z.inc(x)

func `-=`*(z: Int, x: int | culong | Int) =
  ## Decrements `z` by `x`.
  z.dec(x)

func mul*(z, x, y: Int): Int =
  ## Sets `z` to the product x*y and returns `z`.
  result = z
  mpz_mul(result[], x[], y[])

func mul*(z, x: Int, y: culong): Int =
  ## Sets `z` to the product x*y and returns `z`.
  result = z
  mpz_mul_ui(result[], x[], y)

func mul*(z, x: Int, y: int): Int =
  ## Sets `z` to the product x*y and returns `z`.
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
  ## Returns the product x*y.
  newInt().mul(x, y)

func `*`*(x: int | culong, y: Int): Int =
  ## Returns the product x*y.
  newInt().mul(y, x)

func `*=`*(z: Int, x: int | culong | Int) =
  discard z.mul(z, x)

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

func `and`*(z, x, y: Int): Int =
  ## Sets `z` = `x` bitwise-and `y` and returns `z`.
  result = z
  mpz_and(z[], x[], y[])

func `and`*(x, y: Int): Int =
  ## Returns `x` bitwise-and `y`.
  newInt().`and`(x, y)

func `and`*(x: Int, y: int | culong): Int =
  ## Returns `x` bitwise-and `y`.
  x and newInt(y)

func `and`*(x: int | culong, y: Int): Int =
  ## Returns `x` bitwise-and `y`.
  newInt(x) and y

func `or`*(z, x, y: Int): Int =
  ## Sets `z` = `x` bitwise inclusive-or `y` and returns `z`.
  result = z
  mpz_ior(z[], x[], y[])

func `or`*(x, y: Int): Int =
  ## Returns `x` bitwise inclusive-or `y`.
  newInt().`or`(x, y)

func `or`*(x: Int, y: int | culong): Int =
  ## Returns `x` bitwise inclusive-or `y`.
  x or newInt(y)

func `or`*(x: int | culong, y: Int): Int =
  ## Returns `x` bitwise inclusive-or `y`.
  newInt(x) or y

func `xor`*(z, x, y: Int): Int =
  ## Sets `z` = `x` bitwise exclusive-or `y` and returns `z`.
  result = z
  mpz_xor(z[], x[], y[])

func `xor`*(x, y: Int): Int =
  ## Returns `x` bitwise exclusive-or `y`.
  newInt().`xor`(x, y)

func `xor`*(x: Int, y: int | culong): Int =
  ## Returns `x` bitwise exclusive-or `y`.
  x xor newInt(y)

func `xor`*(x: int | culong, y: Int): Int =
  ## Returns `x` bitwise exclusive-or `y`.
  newInt(x) xor y

func `not`*(z, x: Int): Int =
  ## Sets `z` to the one's complement of `x` and returns `z`.
  result = z
  mpz_com(z[], x[])

func `not`*(x: Int): Int =
  ## Returns the one's complement of `x`.
  newInt().`not` x

func odd*(z: Int): bool =
  ## Returns whether `z` is odd.
  mpz_odd_p(z[]) != 0

func even*(z: Int): bool =
  ## Returns whether `z` is even.
  mpz_even_p(z[]) != 0

func `div`*(z, x, y: Int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `div` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_tdiv_q(result[], x[], y[])

func `div`*(z, x: Int, y: culong): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `div` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_tdiv_q_ui(result[], x[], y)

func `div`*(z, x: Int, y: int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `div` implements truncated division towards zero.
  when isLLP64():
    if y.fitsLLP64ULong: z.`div`(x, y.culong) else: z.`div`(x, newInt(y))
  else:
    if y >= 0: z.`div`(x, y.culong) else: z.`div`(x, newInt(y))

func `div`*(x: Int, y: int | culong | Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `div` implements truncated division towards zero.
  newInt().`div`(x, y)

func `div`*(x: int | culong, y: Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `div` implements truncated division towards zero.
  newInt().`div`(newInt(x), y)

func `mod`*(z, x, y: Int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `mod` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_tdiv_r(result[], x[], y[])

func `mod`*(z, x: Int, y: culong): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `mod` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_tdiv_r_ui(result[], x[], y)

func `mod`*(z, x: Int, y: int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `mod` implements truncated division towards zero.
  when isLLP64():
    if y.fitsLLP64ULong: z.`mod`(x, y.culong) else: z.`mod`(x, newInt(y))
  else:
    if y >= 0: z.`mod`(x, y.culong) else: z.`mod`(x, newInt(y))

func `mod`*(x: Int, y: int | culong | Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `mod` implements truncated division towards zero.
  newInt().`mod`(x, y)

func `mod`*(x: int | culong, y: Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `mod` implements truncated division towards zero.
  newInt().`mod`(newInt(x), y)

func modInverse*(z, g, n: Int): bool =
  ## Computes the inverse of `g` modulo `n` and put the result in `z`. If the
  ## inverse exists, the return value is `true` and `z` will satisfy
  ## 0 < `z` < abs(`n`). If an inverse doesn't exist the return value is `false`
  ## and `z` is undefined. The behaviour of this proc is undefined when `n` is
  ## zero.
  mpz_invert(z[], g[], n[]) != 0

func modInverse*(g: Int, n: Int): Int =
  ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
  ## return value is undefined. The behaviour of this proc is undefined when `n`
  ## is zero.
  result = newInt()
  discard modInverse(result, g, n)

func modInverse*(g: Int, n: int | culong): Int =
  ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
  ## return value is undefined. The behaviour of this proc is undefined when `n`
  ## is zero.
  modInverse(g, newInt(n))

func modInverse*(g: int | culong, n: Int): Int =
  ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
  ## return value is undefined. The behaviour of this proc is undefined when `n`
  ## is zero.
  modInverse(newInt(g), n)

func divMod*(q, r, x, y: Int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `divMod` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  mpz_tdiv_qr(q[], r[], x[], y[])

func divMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `divMod` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  discard mpz_tdiv_qr_ui(q[], r[], x[], y)

func divMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `divMod` implements truncated division towards zero.
  when isLLP64():
    if y.fitsLLP64ULong: divMod(q, r, x, y.culong) else: divMod(q, r, x, newInt(y))
  else:
    if y >= 0: divMod(q, r, x, y.culong) else: divMod(q, r, x, newInt(y))

func divMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `divMod` implements truncated division towards zero.
  divMod(newInt(), newInt(), x, y)

func divMod*(x: int | culong, y: Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `divMod` implements truncated division towards zero.
  divMod(newInt(), newInt(), newInt(x), y)

func fdiv*(z, x, y: Int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_fdiv_q(result[], x[], y[])

func fdiv*(z, x: Int, y: culong): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_fdiv_q_ui(result[], x[], y)

func fdiv*(z, x: Int, y: int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  when isLLP64():
    if y.fitsLLP64ULong: z.fdiv(x, y.culong) else: z.fdiv(x, newInt(y))
  else:
    if y >= 0: z.fdiv(x, y.culong) else: z.fdiv(x, newInt(y))

func fdiv*(x: Int, y: int | culong | Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  newInt().fdiv(x, y)

func fdiv*(x: int | culong, y: Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  newInt().fdiv(newInt(x), y)

func `//`*(x: Int, y: int | culong | Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `//` implements truncated division towards negative infinity.
  fdiv(x, y)

func `//`*(x: int | culong, y: Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `//` implements truncated division towards negative infinity.
  fdiv(x, y)

func fmod*(z, x, y: Int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_fdiv_r(result[], x[], y[])

func fmod*(z, x: Int, y: culong): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_fdiv_r_ui(result[], x[], y)

func fmod*(z, x: Int, y: int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  when isLLP64():
    if y.fitsLLP64ULong: z.fmod(x, y.culong) else: z.fmod(x, newInt(y))
  else:
    if y >= 0: z.fmod(x, y.culong) else: z.fmod(x, newInt(y))

func fmod*(x: Int, y: int | culong | Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  newInt().fmod(x, y)

func fmod*(x: int | culong, y: Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  newInt().fmod(newInt(x), y)

func `\\`*(x: Int, y: int | culong | Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `\\` implements truncated division towards negative infinity.
  fmod(x, y)

func `\\`*(x: int | culong, y: Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `\\` implements truncated division towards negative infinity.
  fmod(x, y)

func fdivMod*(q, r, x, y: Int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  mpz_fdiv_qr(q[], r[], x[], y[])

func fdivMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  discard mpz_fdiv_qr_ui(q[], r[], x[], y)

func fdivMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  when isLLP64():
    if y.fitsLLP64ULong: fdivMod(q, r, x, y.culong) else: fdivMod(q, r, x, newInt(y))
  else:
    if y >= 0: fdivMod(q, r, x, y.culong) else: fdivMod(q, r, x, newInt(y))

func fdivMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  fdivMod(newInt(), newInt(), x, y)

func fdivMod*(x: int | culong, y: Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  fdivMod(newInt(), newInt(), newInt(x), y)

func cdiv*(z, x, y: Int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_cdiv_q(result[], x[], y[])

func cdiv*(z, x: Int, y: culong): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_cdiv_q_ui(result[], x[], y)

func cdiv*(z, x: Int, y: int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  when isLLP64():
    if y.fitsLLP64ULong: z.cdiv(x, y.culong) else: z.cdiv(x, newInt(y))
  else:
    if y >= 0: z.cdiv(x, y.culong) else: z.cdiv(x, newInt(y))

func cdiv*(x: Int, y: int | culong | Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  newInt().cdiv(x, y)

func cdiv*(x: int | culong, y: Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  newInt().cdiv(newInt(x), y)

func cmod*(z, x, y: Int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_cdiv_r(result[], x[], y[])

func cmod*(z, x: Int, y: culong): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_cdiv_r_ui(result[], x[], y)

func cmod*(z, x: Int, y: int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  when isLLP64():
    if y.fitsLLP64ULong: z.cmod(x, y.culong) else: z.cmod(x, newInt(y))
  else:
    if y >= 0: z.cmod(x, y.culong) else: z.cmod(x, newInt(y))

func cmod*(x: Int, y: int | culong | Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  newInt().cmod(x, y)

func cmod*(x: int | culong, y: Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  newInt().cmod(newInt(x), y)

func cdivMod*(q, r, x, y: Int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  mpz_cdiv_qr(q[], r[], x[], y[])

func cdivMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  discard mpz_cdiv_qr_ui(q[], r[], x[], y)

func cdivMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  when isLLP64():
    if y.fitsLLP64ULong: cdivMod(q, r, x, y.culong) else: cdivMod(q, r, x, newInt(y))
  else:
    if y >= 0: cdivMod(q, r, x, y.culong) else: cdivMod(q, r, x, newInt(y))

func cdivMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  cdivMod(newInt(), newInt(), x, y)

func cdivMod*(x: int | culong, y: Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  cdivMod(newInt(), newInt(), newInt(x), y)

func fac*(z, x: Int): Int =
  ## Sets `z` to the factorial of `x` and returns `z`.
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
  ## Sets `z` to the factorial of `x` and returns `z`.
  result = z
  mpz_fac_ui(result[], x)

func fac*(z: Int, x: int): Int =
  ## Sets `z` to the factorial of `x` and returns `z`.
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
  ## Returns the factorial of `x`.
  newInt().fac(x)

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

func binom*(z, n: Int, k: culong): Int =
  ## Sets `z` to the binomial coefficient of (`n`, `k`) and returns `z`.
  result = z
  mpz_bin_ui(z[], n[], k)

func binom*(z: Int, n, k: culong): Int =
  ## Sets `z` to the binomial coefficient of (`n`, `k`) and returns `z`.
  result = z
  mpz_bin_uiui(z[], n, k)

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

func bit*(x: Int, i: culong): cint =
  ## Returns the value of the `i`'th bit of `x`.
  mpz_tstbit(x[], i)

func setBit*(z: Int, i: culong): Int =
  ## Sets the i`'th bit of `z` and returns the resulting Int.
  result = z
  mpz_setbit(z[], i)

func clearBit*(z: Int, i: culong): Int =
  ## Clears the i`'th bit of `z` and returns the resulting Int.
  result = z
  mpz_clrbit(z[], i)

func complementBit*(z: Int, i: culong): Int =
  ## Complements the i`'th bit of `z` and returns the resulting Int.
  result = z
  mpz_combit(z[], i)

func bitLen*(x: Int): csize_t =
  ## Returns the length of the absolute value of `x` in bits.
  digits(x, 2)

func pow*(z, x: Int, y: culong): Int =
  ## Sets `z` to `x` raised to `y` and returns `z`. The case 0^0 yields 1.
  result = z
  mpz_pow_ui(z[], x[], y)

func pow*(z: Int, x, y: culong): Int =
  ## Sets `z` to `x` raised to `y` and returns `z`. The case 0^0 yields 1.
  result = z
  mpz_ui_pow_ui(z[], x, y)

func pow*(x: culong | Int, y: culong): Int =
  ## Returns `x` raised to `y`. The case 0^0 yields 1.
  newInt().pow(x, y)

func pow*(x: int, y: culong): Int =
  ## Returns `x` raised to `y`. The case 0^0 yields 1.
  when isLLP64():
    if x.fitsLLP64ULong: pow(x.culong, y) else: pow(newInt(x), y)
  else:
    if x >= 0: pow(x.culong, y) else: pow(newInt(x), y)

func `^`*(x: int | culong | Int, y: culong): Int =
  ## Returns `x` raised to `y`. The case 0^0 yields 1.
  pow(x, y)

func exp*(z, x: Int, y: culong, m: Int): Int =
  ## Sets `z` to (`x` raised to `y`) modulo `m` and returns `z`.
  ## If `m` == 0, z = x^y.
  if m.sign == 0: return z.pow(x, y)
  result = z
  mpz_powm_ui(z[], x[], y, m[])

func exp*(z, x, y, m: Int): Int =
  ## Sets `z` to (`x` raised to `y`) modulo `m` and returns `z`.
  ## If `m` == 0, z = x^y.
  result = z
  mpz_powm(z[], x[], y[], m[])

func exp*(x: Int, y: Int, m: Int): Int =
  ## Returns (`x` raised to `y`) modulo `m`.
  ## If `m` == 0, z = x^y.
  newInt().exp(x, y, m)

func exp*(x: Int, y: culong, m: Int): Int =
  ## Returns (`x` raised to `y`) modulo `m`.
  ## If `m` == 0, z = x^y.
  newInt().exp(x, y, m)

func exp*(x: Int, y: culong, m: int | culong): Int =
  ## Returns (`x` raised to `y`) modulo `m`.
  ## If `m` == 0, z = x^y.
  exp(x, y, newInt(m))

func exp*(x: int | culong, y: culong, m: Int): Int =
  ## Returns (`x` raised to `y`) modulo `m`.
  ## If `m` == 0, z = x^y.
  exp(newInt(x), y, m)

func sqrt*(z, x: Int): Int =
    result = z
    mpz_sqrt(z[], x[])

func sqrt*(x: Int): Int =
  ## Returns the greatest common divisor of `x` and `y`.
  newInt().sqrt(x)

func gcd*(z, x, y: Int): Int =
  ## Sets `z` to the greatest common divisor of `x` and `y` and returns `z`.
  result = z
  mpz_gcd(z[], x[], y[])

func gcd*(z, x: Int, y: culong): Int =
  ## Sets `z` to the greatest common divisor of `x` and `y` and returns `z`.
  result = z
  discard mpz_gcd_ui(z[], x[], y)

func gcd*(z, x: Int, y: int): Int =
  ## Sets `z` to the greatest common divisor of `x` and `y` and returns `z`.
  when isLLP64():
    if y.fitsLLP64ULong: z.gcd(x, y.culong) else: z.gcd(x, newInt(y))
  else:
    if y >= 0: z.gcd(x, y.culong) else: z.gcd(x, newInt(y))

func gcd*(x: Int, y: int | culong | Int): Int =
  ## Returns the greatest common divisor of `x` and `y`.
  newInt().gcd(x, y)

func gcd*(x: int | culong, y: Int): Int =
  ## Returns the greatest common divisor of `x` and `y`.
  newInt().gcd(newInt(x), y)

func lcm*(z, x, y: Int): Int =
  ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
  result = z
  mpz_lcm(z[], x[], y[])

func lcm*(z, x: Int, y: culong): Int =
  ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
  result = z
  mpz_lcm_ui(z[], x[], y)

func lcm*(z, x: Int, y: int): Int =
  ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
  when isLLP64():
    if y.fitsLLP64ULong: z.lcm(x, y.culong) else: z.lcm(x, newInt(y))
  else:
    if y >= 0: z.lcm(x, y.culong) else: z.lcm(x, newInt(y))

func lcm*(x: Int, y: int | culong | Int): Int =
  ## Returns the least common multiple of `x` and `y`.
  newInt().lcm(x, y)

func lcm*(x: int | culong, y: Int): Int =
  ## Returns the least common multiple of `x` and `y`.
  newInt().lcm(newInt(x), y)

func `shl`*(z, x: Int, y: culong): Int =
  ## Sets `z` the `shift left` operation of `x` and `y` and returns `z`.
  result = z
  mpz_mul_2exp(z[], x[], y)

func `shl`*(x: Int, y: culong): Int =
  ## Computes the `shift left` operation of `x` and `y`.
  newInt().`shl`(x, y)

func `shr`*(z, x: Int, y: culong): Int =
  ## Sets `z` to the `shift right` operation of `x` and `y`.
  result = z
  mpz_fdiv_q_2exp(z[], x[], y)

func `shr`*(x: Int, y: culong): Int =
  ## Computes the `shift right` operation of `x` and `y`.
  newInt().`shr`(x, y)

func fitsCULong*(x: Int): bool =
  ## Returns whether `x` fits in a culong.
  mpz_fits_ulong_p(x[]) != 0

func fitsCLong*(x: Int): bool =
  ## Returns whether `x` fits in a clong.
  mpz_fits_slong_p(x[]) != 0

func fitsInt*(x: Int): bool =
  ## Returns whether `x` fits in an int.
  when isLLP64():
    if x[].mp_size < -1 or x[].mp_size > 1: return false
    if x[].mp_size == 0: return true
    if x[].mp_size > 0: return (x[].mp_d[]).uint <= high(int).uint
    return x.cmp(low(int)) >= 0
  else:
    x.fitsClong

func toCULong*(x: Int): culong =
  ## Returns the value of `x` as a culong.
  ## If `x` is too big to fit a culong then just the least significant bits that
  ## do fit are returned. The sign of `x` is ignored, only the absolute value is
  ## used. To find out if the value will fit, use the proc `fitsCULong`.
  mpz_get_ui(x[])

func toCLong*(x: Int): clong =
  ## If `x` fits into a clong returns the value of `x`. Otherwise returns the
  ## least significant part of `x`, with the same sign as `x`.
  ## If `x` is too big to fit in a clong, the returned result is probably not
  ## very useful. To find out if the value will fit, use the proc `fitsCLong`.
  mpz_get_si(x[])

func toInt*(x: Int): int =
  ## If `x` fits into an int returns the value of `x`. Otherwise returns the
  ## least significant part of `x`, with the same sign as `x`.
  ## If `x` is too big to fit in an int, the returned result is probably not
  ## very useful. To find out if the value will fit, use the proc `fitsInt`.
  when isLLP64():
    if x[].mp_size > 0: return (x[].mp_d[]).int
    if x[].mp_size < 0: return -1 - ((x[].mp_d[]).uint - 1).int
    return 0
  else:
    x.toCLong

func neg*(z, x: Int): Int =
  ## Sets `z` to -`x` and returns `z`.
  result = z
  mpz_neg(z[], x[])

func `-`*(x: Int): Int =
  ## Unary `-` operator for an Int. Negates `x`.
  newInt().neg(x)

func probablyPrime*(x: Int, n: cint): cint =
  ## Determines whether `x` is prime. Return 2 if `x` is definitely prime, return
  ## 1 if `x` is probably prime (without being certain), or return 0 if `x` is
  ## definitely composite.
  ## This proc does some trial divisions, then some Miller-Rabin probabilistic
  ## primality tests. The argument `n` controls how many such tests are done; a
  ## higher value will reduce the chances of a composite being returned as
  ## "probably prime". 25 is a reasonable number; a composite number will then
  ## be identified as a prime with a probability of less than 2^(-50).
  mpz_probab_prime_p(x[], n)

func nextPrime*(z, x: Int): Int =
  ## Sets `z` to the next prime greater than `x`.
  ## This proc uses a probabilistic algorithm to identify primes. For practical
  ## purposes it's adequate, the chance of a composite passing will be extremely
  ## small.
  result = z
  mpz_nextprime(z[], x[])

func nextPrime*(x: Int): Int =
  ## Returns the next prime greater than `x`.
  ## This proc uses a probabilistic algorithm to identify primes. For practical
  ## purposes it's adequate, the chance of a composite passing will be extremely
  ## small.
  newInt().nextPrime(x)
