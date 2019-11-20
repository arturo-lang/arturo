import math

type Rat* = ref mpq_t
  ## A Rat represents a quotient a/b of arbitrary precision.

proc finalizeRat(z: Rat) =
  # Finalizer - release the memory allocated to the mpq.
  mpq_clear(z[])

proc numRef(x: Rat): Int =
  # Returns the numerator of `x`. The result is a reference to `x`'s numerator.
  result = cast[ref mpz_t](x[].mpq_numref)

proc denomRef(x: Rat): Int =
  # Returns the denominator of `x`. The result is a reference to `x`'s denominator.
  result = cast[ref mpz_t](x[].mpq_denref)

proc newRat*(): Rat =
  ## Creates a new Rat and set it to 0/1.
  new(result, finalizeRat)
  mpq_init(result[])

proc newRat*(f: float): Rat =
  ## Creates a new Rat and set it to the value of `f`. There is no rounding,
  ## this conversion is exact.
  if classify(f) == fcNan or f == Inf or f == NegInf:
    raise newException(ValueError, "Rat does not support NaN, Inf and NegInf")
  new(result, finalizeRat)
  mpq_set_d(result[], f)

proc newRat*(a, b: Int): Rat =
  ## Creates a new Rat with numerator `a` and denominator `b`.
  if b.sign == 0: raise newException(DivByZeroError, "Division by zero")
  result = newRat()
  discard result.numRef.set(a)
  discard result.denomRef.set(b)
  mpq_canonicalize(result[])

proc newRat*(a, b: culong): Rat =
  ## Creates a new Rat with numerator `a` and denominator `b`.
  if b == 0: raise newException(DivByZeroError, "Division by zero")
  result = newRat()
  mpq_set_ui(result[], a, b)
  mpq_canonicalize(result[])

proc newRat*(a: clong, b: culong): Rat =
  ## Creates a new Rat with numerator `a` and denominator `b`.
  if b == 0: raise newException(DivByZeroError, "Division by zero")
  result = newRat()
  mpq_set_si(result[], a, b)
  mpq_canonicalize(result[])

proc newRat*(a: Int, b: int | culong): Rat =
  ## Creates a new Rat with numerator `a` and denominator `b`.
  newRat(a, newInt(b))

proc newRat*(a: culong | int, b: Int): Rat =
  ## Creates a new Rat with numerator `a` and denominator `b`.
  newRat(newInt(a), b)

proc newRat*(a, b: int): Rat =
  ## Creates a new Rat with numerator `a` and denominator `b`.
  when isLLP64():
    if a.fitsLLP64Long and b.fitsLLP64ULong: return newRat(a.clong, b.culong)
    if a.fitsLLP64ULong and b.fitsLLP64ULong: return newRat(a.culong, b.culong)
    return newRat(newInt(a), newInt(b))
  else:
    if b >= 0: return newRat(a.clong, b.culong)
    if a >= 0 and b >= 0: return newRat(a.culong, b.culong)
    return newRat(newInt(a), newInt(b))

proc newRat*(s: string, base: cint = 10): Rat =
  ## Allocates and returns a new Rat set to `s`, interpreted in the given `base`.
  validBase(base)
  result = newRat()
  if mpq_set_str(result[], s, base) == -1:
    raise newException(ValueError, "String not in correct base")
  mpq_canonicalize(result[])

proc newRat*(x: Int): Rat =
  ## Creates a new Rat and set it to `x`/1.
  result = newRat()
  mpq_set_z(result[], x[])

proc newRat*(x: culong): Rat =
  ## Creates a new Rat and set it to `x`/1.
  newRat(x, 1)

proc newRat*(x: int): Rat =
  ## Creates a new Rat and set it to `x`/1.
  when isLLP64():
    newRat(x, 1)
  else:
    newRat(x.clong, 1)

proc clear*(z: Rat) =
  ## Clears the allocated space used by the rational.
  ##
  ## This normally happens on a finalizer call, but if you want immediate
  ## deallocation you can call it.
  GCunref(z)
  finalizeRat(z)

proc clone*(z: Rat): Rat =
  ## Returns a clone of `z`.
  result = newRat()
  mpq_set(result[], z[])

proc `$`*(z: Rat, base: range[(2.cint) .. (36.cint)] = 10): string =
  ## The stringify operator for a Rat argument. Returns `z` converted to a
  ## string in the given `base`.
  result = newString(digits(z.numRef, base) + digits(z.denomRef, base) + 3)
  result.setLen(mpq_get_str(result, base, z[]).len)

proc num*(x: Rat): Int =
  ## Returns the numerator of `x`.
  result = newInt()
  mpq_get_num(result[], x[])

proc denom*(x: Rat): Int =
  ## Returns the denominator of `x`.
  result = newInt()
  mpq_get_den(result[], x[])

proc setNum*(z: Rat, x: int | culong | Int): Rat =
  ## Sets the numerator of `z` to `x` and returns `z`.
  result = z
  discard result.numRef.set(x)
  mpq_canonicalize(result[])

proc setDenom*(z: Rat, x: int | culong | Int): Rat =
  ## Sets the denominator of `z` to `x` and returns `z`.
  if x == 0: raise newException(DivByZeroError, "Division by zero")
  result = z
  discard result.denomRef.set(x)
  mpq_canonicalize(result[])

proc set*(z: Rat, x: Rat): Rat =
  ## Sets `z` to `x` and returns `z`.
  result = z
  mpq_set(z[], x[])

proc set*(z: Rat, x: float): Rat =
  ## Sets `z` to `x` and returns `z`.
  if classify(x) == fcNan or x == Inf or x == NegInf:
    raise newException(ValueError, "Rat does not support NaN, Inf and NegInf")
  result = z
  mpq_set_d(z[], x)

proc set*(z: Rat, a, b: Int): Rat =
  ## Sets `z` to `a`/`b` and returns `z`.
  if b.sign == 0: raise newException(DivByZeroError, "Division by zero")
  result = z
  discard result.numRef.set(a)
  discard result.denomRef.set(b)
  mpq_canonicalize(result[])

proc set*(z: Rat, a, b: culong): Rat =
  ## Sets `z` to `a`/`b` and returns `z`.
  if b == 0: raise newException(DivByZeroError, "Division by zero")
  result = z
  mpq_set_ui(result[], a, b)
  mpq_canonicalize(result[])

proc set*(z: Rat, a: clong, b: culong): Rat =
  ## Sets `z` to `a`/`b` and returns `z`.
  if b == 0: raise newException(DivByZeroError, "Division by zero")
  result = z
  mpq_set_si(result[], a, b)
  mpq_canonicalize(result[])

proc set*(z: Rat, a: Int, b: int | culong): Rat =
  ## Sets `z` to `a`/`b` and returns `z`.
  z.set(a, newInt(b))

proc set*(z: Rat, a: culong | int, b: Int): Rat =
  ## Sets `z` to `a`/`b` and returns `z`.
  z.set(newInt(a), b)

proc set*(z: Rat, a, b: int): Rat =
  ## Sets `z` to `a`/`b` and returns `z`.
  when isLLP64():
    if a.fitsLLP64Long and b.fitsLLP64ULong: return z.set(a.clong, b.culong)
    if a.fitsLLP64ULong and b.fitsLLP64ULong: return z.set(a.culong, b.culong)
    return z.set(newInt(a), newInt(b))
  else:
    if b >= 0: return z.set(a.clong, b.culong)
    if a >= 0 and b >= 0: return z.set(a.culong, b.culong)
    return z.set(newInt(a), newInt(b))

proc set*(z: Rat, x: Int): Rat =
  ## Creates a new Rat and set it to `x`/1.
  result = z
  mpq_set_z(result[], x[])

proc set*(z: Rat, x: culong): Rat =
  ## Creates a new Rat and set it to `x`/1.
  z.set(x, 1)

proc set*(z: Rat, x: int): Rat =
  ## Creates a new Rat and set it to `x`/1.
  when isLLP64():
    z.set(x, 1)
  else:
    z.set(x.clong, 1)

proc swap*(x: Rat, y: Rat) =
  ## Swaps the values `x` and `y` efficiently.
  mpq_swap(x[], y[])

proc cmp*(x, y: Rat): cint =
  ## Compares `x` and `y` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
  result = mpq_cmp(x[], y[])
  if result < 0:
    result = -1
  elif result > 0:
    result = 1

proc cmp*(x: Rat, a, b: Int): cint =
  ## Compares `x` and `a`/`b` and returns:
  ## ::
  ##   -1 if x <  a/b
  ##    0 if x == a/b
  ##   +1 if x >  a/b
  x.cmp(newRat(a, b))

proc cmp*(x: Rat, a, b: culong): cint =
  ## Compares `x` and `a`/`b` and returns:
  ## ::
  ##   -1 if x <  a/b
  ##    0 if x == a/b
  ##   +1 if x >  a/b
  result = mpq_cmp_ui(x[], a, b)
  if result < 0:
    result = -1
  elif result > 0:
    result = 1

proc cmp*(x: Rat, a: clong, b: culong): cint =
  ## Compares `x` and `a`/`b` and returns:
  ## ::
  ##   -1 if x <  a/b
  ##    0 if x == a/b
  ##   +1 if x >  a/b
  result = mpq_cmp_si(x[], a, b)
  if result < 0:
    result = -1
  elif result > 0:
    result = 1

proc cmp*(x: Rat, a: Int, b: int | culong): cint =
  ## Compares `x` and `a`/`b` and returns:
  ## ::
  ##   -1 if x <  a/b
  ##    0 if x == a/b
  ##   +1 if x >  a/b
  x.cmp(a, newInt(b))

proc cmp*(x: Rat, a: culong | int, b: Int): cint =
  ## Compares `x` and `a`/`b` and returns:
  ## ::
  ##   -1 if x <  a/b
  ##    0 if x == a/b
  ##   +1 if x >  a/b
  x.cmp(newInt(a), b)

proc cmp*(x: Rat, a, b: int): cint =
  ## Compares `x` and `a`/`b` and returns:
  ## ::
  ##   -1 if x <  a/b
  ##    0 if x == a/b
  ##   +1 if x >  a/b
  when isLLP64():
    if a.fitsLLP64Long and b.fitsLLP64ULong: return x.cmp(a.clong, b.culong)
    if a.fitsLLP64ULong and b.fitsLLP64ULong: return x.cmp(a.culong, b.culong)
    return x.cmp(newInt(a), newInt(b))
  else:
    if b >= 0: return x.cmp(a.clong, b.culong)
    if a >= 0 and b >= 0: return x.cmp(a.culong, b.culong)
    return x.cmp(newInt(a), newInt(b))

proc cmp*(x: Rat, y: culong | Int): cint =
  ## Compares `x` and `y`/`1` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
  x.cmp(y, 1)

proc cmp*(x: Rat, y: int): cint =
  ## Compares `x` and `y`/`1` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
  when isLLP64():
    x.cmp(y, 1)
  else:
    x.cmp(y.clong, 1)

proc `==`*(x, y: Rat): bool =
  ## Returns whether `x` equals `y`.
  mpq_equal(x[], y[]) != 0

proc `==`*(x: Rat, y: int | culong | Int): bool =
  ## Returns whether `x` equals `y`.
  cmp(x, y) == 0

proc `==`*(x: int | culong | Int, y: Rat): bool =
  ## Returns whether `x` equals `y`.
  result = cmp(y, x) == 0

proc `<`*(x: Rat, y: int | culong | Int | Rat): bool =
  ## Returns whether `x` is less than `y`.
  cmp(x, y) == -1

proc `<`*(x: int | culong | Int, y: Rat): bool =
  ## Returns whether `x` is less than `y`.
  cmp(y, x) == 1

proc `<=`*(x: Rat, y: int | culong | Int | Rat): bool =
  ## Returns whether `x` is less than or equal `y`.
  let c = cmp(x, y)
  c == 0 or c == -1

proc `<=`*(x: int | culong | Int, y: Rat): bool =
  ## Returns whether `x` is less than or equal `y`.
  let c = cmp(y, x)
  c == 0 or c == 1

proc sign*(x: Rat): cint =
  ## Allows faster testing for negative, zero, and positive. Returns:
  ## ::
  ##   -1 if x <  0
  ##    0 if x == 0
  ##   +1 if x >  0
  mpq_sgn(x[])

proc positive*(x: Rat): bool =
  ## Returns whether `x` is positive or zero.
  x.sign >= 0

proc negative*(x: Rat): bool =
  ## Returns whether `x` is negative.
  x.sign < 0

proc isZero*(x: Rat): bool =
  ## Returns whether `x` is zero.
  x.sign == 0

proc abs*(z, x: Rat): Rat =
  ## Sets `z` to |x| (the absolute value of `x`) and returns `z`.
  result = z
  mpq_abs(result[], x[])

proc abs*(x: Rat): Rat =
  ## Returns the absolute value of `x`.
  newRat().abs(x)

proc add*(z, x, y: Rat): Rat =
  ## Sets `z` to the sum x+y and returns `z`.
  result = z
  mpq_add(result[], x[], y[])

proc add*(z: Rat, x: Rat, y: int | culong | Int): Rat =
  ## Sets `z` to the sum x+y and returns `z`.
  z.add(x, newRat(y))

proc `+`*(x: Rat, y: int | culong | Int | Rat): Rat =
  ## Returns the sum x+y.
  newRat().add(x, y)

proc `+`*(x: int | culong | Int, y: Rat): Rat =
  ## Returns the sum x+y.
  newRat().add(y, x)

proc sub*(z, x, y: Rat): Rat =
  ## Sets `z` to the difference x.y and returns `z`.
  result = z
  mpq_sub(result[], x[], y[])

proc sub*(z: Rat, x: Rat, y: int | culong | Int): Rat =
  ## Sets `z` to the difference x.y and returns `z`.
  z.sub(x, newRat(y))

proc `-`*(x: Rat, y: int | culong | Int | Rat): Rat =
  ## Returns the difference x-y.
  newRat().sub(x, y)

proc `-`*(x: int | culong | Int, y: Rat): Rat =
  ## Returns the difference x-y.
  newRat().sub(y, x)

proc inc*(z: Rat, x: int | culong | Int | Rat) =
  ## Increments `z` by `x`.
  discard z.add(z, x)

proc dec*(z: Rat, x: int | culong | Int | Rat) =
  ## Decrements `z` by `x`.
  discard z.sub(z, x)

proc `+=`*(z: Rat, x: int | culong | Int | Rat) =
  ## Increments `z` by `x`.
  z.inc(x)

proc `-=`*(z: Rat, x: int | culong | Int | Rat) =
  ## Decrements `z` by `x`.
  z.dec(x)

proc mul*(z, x, y: Rat): Rat =
  ## Sets `z` to the product x*y and returns `z`.
  result = z
  mpq_mul(result[], x[], y[])

proc mul*(z: Rat, x: Rat, y: int | culong | Int): Rat =
  ## Sets `z` to the product x*y and returns `z`.
  z.mul(x, newRat(y))

proc `*`*(x: Rat, y: int | culong | Int | Rat): Rat =
  ## Returns the product x*y.
  newRat().mul(x, y)

proc `*`*(x: int | culong | Int, y: Rat): Rat =
  ## Returns the product x*y.
  newRat().mul(y, x)

proc `*=`*(z: Rat, x: int | culong | Int | Rat) =
  discard z.mul(z, x)

proc divide*(z, x, y: Rat): Rat =
  ## Sets `z` to the quotient x/y and returns `z`.
  if y.sign == 0: raise newException(DivByZeroError, "Division by zero")
  result = z
  mpq_div(z[], x[], y[])

proc divide*(z: Rat, x: Rat, y: int | culong | Int): Rat =
  ## Sets `z` to the quotient x/y and returns `z`.
  z.divide(x, newRat(y))

proc divide*(z: Rat, x: int | culong | Int, y: Rat): Rat =
  ## Sets `z` to the quotient x/y and returns `z`.
  z.divide(newRat(x), y)

proc `/`*(x: Rat, y: int | culong | Int | Rat): Rat =
  ## Returns the quotient x/y.
  newRat().divide(x, y)

proc `/`*(x: int | culong | Int, y: Rat): Rat =
  ## Returns the quotient x/y.
  newRat().divide(x, y)

proc `/=`*(z: Rat, x: int | culong | Int | Rat) =
  discard z.divide(z, x)

proc `/`*(x: Int, y: int | culong | Int): Rat =
  ## Returns a Rat with numerator `x` and denominator `y`.
  newRat(x, y)

proc `/`*(x: int | culong, y: Int): Rat =
  ## Returns a Rat with numerator `x` and denominator `y`.
  newRat(x, y)

proc inv*(z, x: Rat): Rat =
  ## Sets `z` to 1/`x` and returns `z`.
  if x.sign == 0: raise newException(DivByZeroError, "Division by zero")
  result = z
  mpq_inv(z[], x[])

proc reciprocal*(x: Rat): Rat =
  ## Returns 1/`x`.
  newRat().inv(x)

proc toFloat*(x: Rat): float =
  ## Returns the nearest float value for `x`.
  mpq_get_d(x[])

proc toFloatExact*(x: Rat): tuple[r: float, e: bool] =
  ## Returns the nearest float value for `x` in `r`, and a bool in `e` indicating
  ## whether `r` represents `x` exactly.
  result.r = x.toFloat
  if not (classify(result.r) == fcNan or result.r == Inf or result.r == NegInf):
    result.e = newRat(result.r) == x

proc isInt*(x: Rat): bool =
  ## Returns whether the denominator of `x` is 1.
  x.denomRef.cmp(1.culong) == 0

proc toInt*(x: Rat): Int =
  ## Converts `x` to an Int. Conversion rounds towards zero if `x` does not
  ## contain an integer value.
  x.numRef div x.denomRef

proc neg*(z, x: Rat): Rat =
  ## Sets `z` to -`x` and returns `z`.
  result = z
  mpq_neg(z[], x[])

proc `-`*(x: Rat): Rat =
  ## Unary `-` operator for a Rat. Negates `x`.
  newRat().neg(x)
