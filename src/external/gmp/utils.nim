import gmp
import math

{.deadCodeElim: on.}
{.push hints: off.}
{.experimental.}

################################################################################
# multi-precision ints
################################################################################


proc finalise(a: ref mpz_t) =
  mpz_clear(a[])
 
proc new_mpz*(): ref mpz_t =
  new(result,finalise)
  mpz_init(result[])
  
proc init_mpz*(): mpz_t =
  mpz_init(result)

#converter toPtr*(a: var mpz_t): ptr mpz_t =
#  a.addr

proc init_mpz*(enc: string, base: cint = 10): mpz_t =
  if mpz_init_set_str(result,enc, base) != 0:
    raise newException(ValueError,enc & " represents an invalid value") 

converter convert*(a: int): mpz_t =
  when sizeof(clong) != sizeof(int): # LLP64 programming model
    mpz_init(result)
    if a < 0: result.mp_size = -1 else: result.mp_size = (a != 0).cint
    if a < 0 and a > low(int):
      result.mp_d[] = (-a).mp_limb_t
    else:
      result.mp_d[] = a.mp_limb_t
  else:
    mpz_init_set_si(result, a)

converter convert*(a: mpf_t): mpz_t =
  result = init_mpz()
  mpz_set_f(result, a)

proc to_mpz*(a: mpf_t): mpz_t =
  result = init_mpz()
  mpz_set_f(result, a)

proc to_mpz*(a: clong): mpz_t =
  mpz_init_set_si(result,a)

proc init_mpz*(val: clong): mpz_t =
  mpz_init_set_si(result,val)
  
proc new_mpz*(val: clong): ref mpz_t =
  new(result,finalise)
  mpz_init_set_si(result[],val)
  
template mpz_p*(a: clong{lit}): mpz_ptr {.deprecated.} =
  # weird interaction with destructor, so use new for now
  # should stay alive whilst in scope, hence inject
  var temp = new_mpz(a)
  temp[].addr    
  
proc new_mpz*(enc: string, base: cint = 10): ref mpz_t =
  new(result,finalise)
  if mpz_init_set_str(result[],enc, base) != 0: 
    raise newException(ValueError,enc & " represents an invalid value")

#NOTE: default params don't work with static 
proc alloc_mpz_t*(shared: static[bool]): ptr mpz_t =
  when shared:
    #FIXME: U variant doesn't compile at the moment
    result = createShared(mpz_t,sizeof(mpz_t))
  else:
    result = cast[ptr mpz_t](alloc0(sizeof(mpz_t)))
  mpz_init(result)
  
proc dealloc_mpz_t*(a: ptr mpz_t, shared: static[bool]) =
  mpz_clear(a)
  when shared:
    # FIXME: freeShared currently bugged (won't compile)
    discard reallocShared(a,0)
  else:
    dealloc(a)

proc `==`*(a,b: mpz_t): bool =
  return mpz_cmp(a,b) == 0
  
proc `<`*(a,b: mpz_t): bool =
  return mpz_cmp(a,b) < 0

proc `<=`*(a,b: mpz_t): bool =
  let t = mpz_cmp(a,b)
  t < 0 or t == 0

proc cmp*(a,b: mpz_t): int =
  return mpz_cmp(a,b)  

proc `$`*(a: mpz_t, base: cint = 10): string =
  result = newString(mpz_sizeinbase(a, base) + 1)
  return $mpz_get_str(result,base,a)
  
proc `$`*(a: ptr mpz_t, base: cint = 10): string =
  result = newString(mpz_sizeinbase(a, base) + 1)
  return $mpz_get_str(result,base,a)
  
proc copy*(a: mpz_t): mpz_t =
  ## you must use this function in instead of assignment
  mpz_set(result,a)
  return result
  
# careful when copying values!!!
proc destroy*(a: var mpz_t) {.destructor.} =
  mpz_clear(a)


################################################################################
# multi-precision floats
################################################################################

proc finalise(a: ref mpf_t) =
  mpf_clear(a[])

proc init_mpf*(): mpf_t =
  mpf_init(result)
  
proc init_mpf*(enc: string, base: cint = 10): mpf_t =
  ## Set the value of rop from the string in str. The string is of the form ‘M@N’
  ## or, if the base is 10 or less, alternatively ‘MeN’. ‘M’ is the mantissa and 
  ## ‘N’ is the exponent. The # mantissa is always in the specified base. The 
  ## exponent is either in the specified base or, if base is negative, in decimal. 
  ## The decimal point expected is taken from the current  locale, on systems 
  ## providing localeconv.
  ##
  ## The argument base may be in the ranges 2 to 62, or −62 to −2. Negative values 
  ## are used to specify that the exponent is in decimal.
  ##
  ## For bases up to 36, case is ignored; upper-case and lower-case letters have the 
  ## same value; for bases 37 to 62, upper-case letter represent the usual 10..35 
  ## while lower-case  letter represent 36..61.
  ##
  ## Unlike the corresponding mpz function, the base will not be determined from the
  ## leading characters of the string if base is 0. This is so that numbers like 
  ## ‘0.23’ are not  interpreted as octal.
  ##
  ## White space is allowed in the string, and is simply ignored. [This is not really 
  ## true; white-space is ignored in the beginning of the string and within the 
  ## mantissa, but not in  other places, such as after a minus sign or in the exponent. 
  if mpf_init_set_str(result,enc,base) != 0:
    # have to free memory even on failure
    mpf_clear(result)
    raise newException(ValueError,enc & " represents an invalid value")
    
proc init_mpf*(val: float): mpf_t =
  mpf_init_set_d(result,val)
  
proc new_mpf*(val: float): ref mpf_t =
  new(result,finalise)
  mpf_init_set_d(result[],val)
  
proc init_mpf*(val: clong): mpf_t =
  mpf_init_set_si(result,val)
  
proc to_mpf*(a: float): mpf_t =
  result = init_mpf(a)
  
template mpf_p*(a: float{lit}): mpf_ptr  {.deprecated.} =
  ## no longer used now we have nimified function params
  # inject so it is finalised when goes out of scope
  var temp = new_mpf(a)
  temp[].addr    
  
proc to_mpf*(a: mpz_t): mpf_t =
  result = init_mpf()
  mpf_set_z(result,a)
  
#converter toPtr*(a: var mpf_t): ptr mpf_t =
#  a.addr
  
converter convert*(a: float): mpf_t =
  a.toMpf

proc copy*(a: mpf_t): mpf_t =
  ## you must use this function instead of assignment
  mpf_set(result,a)
  return result

proc toFloat*(a: var mpf_t): float =
  result = mpf_get_d(a)
  if result == 0.0 and mpf_cmp_d(a,0.0) != 0:
    raise newException(ValueError, "number too small")
  if result == Inf:
    raise newException(ValueError, "number too large")

proc `$`*(a: mpf_t, base: cint = 10, n_digits = 10): string =
  var outOfRange = false
  var floatVal: float
  
  #May have to remove this due to system specific behaviour
  floatVal = mpf_get_d(a)
  if floatVal == 0.0 and mpf_cmp_d(a,0.0) != 0:
    outOfRange = true
  if floatVal == Inf:
    outOfRange = true
  
  # case: fits in float      
  if base == 10 and not outOfRange:
    return $floatVal
  
  var exp: mp_exp_t
  # +1 for possible minus sign
  var str = newString(n_digits + 1)
  let coeff = $mpf_get_str(str,exp,base,n_digits,a)
  if (exp != 0):
    return coeff & "e" & $exp
  if coeff == "":
    return "0.0"
  result = coeff
  
proc `==`*(a,b: mpf_t): bool =
  return mpf_cmp(a,b) == 0
  
proc `<`*(a,b: mpf_t): bool =
  return mpf_cmp(a,b) < 0

proc `<=`*(a,b: mpf_t): bool =
  let t = mpf_cmp(a,b)
  t < 0 or t == 0

proc cmp*(a,b: mpf_t): int =
  return mpf_cmp(a,b)
  
proc destroy*(a: var mpf_t) {.destructor.} =
  mpf_clear(a)
  
converter convert*(a: mpz_t): mpf_t =
  result = init_mpf()
  mpf_set_z(result,a)

{.pop.}

when isMainModule:
  proc testEq() =
    var t1 = new(mpz_t)
    var t2 = new(mpz_t)
    var t3 = new(mpz_t)
    
    discard mpz_init_set_str(t1[].addr,"123",10)
    discard mpz_init_set_str(t2[].addr,"123",10)
    discard mpz_init_set_str(t3[].addr,"124",10)
    assert t1[] == t2[]
    assert t2[] != t3[]
    assert t1[] < t3[]
    assert t3[] > t1[]
    assert t3[].cmp(t1[]) > 0
    
  proc testAlloc =
    var t = alloc_mpz_t(true)
    assert (($t) == "0")
    dealloc_mpz_t(t,true)
    
  proc testFloatConv =
    var t = 123.456.toMpf
    #echo 123.4.mpf_t # converter doesn't work
    assert ($t == "123.456")
  
  proc testToPtr =
    var t: mpz_t = 0
    var t2: mpz_t = 5
    mpz_add(t,t2,t)
    assert ($t == "5")
    var f: mpf_t = 0.0
    var f2: mpf_t = 5.0
    mpf_add(f,f2,f)
    assert ($f == "5.0")

  proc testToFloat =
  
    var tooSmall = false
    try:
      var f = init_mpf("1e-11043")
      discard f.toFloat()
    except:
      var e = getCurrentException()
      assert e of ValueError
      tooSmall = true 
    assert(tooSmall)
    
    var tooLarge = false
    try:
      var f = init_mpf("1e1104367")
      echo f.toFloat()
    except:
      var e = getCurrentException()
      assert e of ValueError
      tooLarge = true     
    assert(tooLarge)
    
    # check we don't get an excpetion in the case of zero
    var f = init_mpf(0.0)
    discard f.toFloat()

  proc testLiteralHelpers =
    # test should stay alive whilst in scope
    let test = mpz_p(123)
    GC_fullcollect()
    assert($test == "123")
    
    var res: mpz_t = init_mpz(0)
    mpz_add(res.addr,mpz_p(5),mpz_p(19))
    
    # a bit clunky 
    assert res == mpz_p(24)[]
    
  proc oneFinaliser =
    #TODO: should increment global count when debug mode 
    let test = mpz_p(123)
    GC_fullcollect()   
    
  testEq()
  testAlloc()
  testFloatConv()
  testToPtr()
  testToFloat()
  testLiteralHelpers()
  
  GC_fullcollect() 
  echo "before oneFinaliser"
  oneFinaliser()
  echo "after oneFinaliser"
  GC_fullcollect()
  echo "after GC_fullcollect"
  
