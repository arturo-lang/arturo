#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/math.nim
  * @description: number-related & math operations
  *****************************************************************]#

#[######################################################
    Helpers
  ======================================================]#

proc isPrime*(n: uint32): bool {.noSideEffect.} =
    case n
        of 0, 1: return false
        of 2, 7, 61: return true
        else: discard
 
    var
        nm1 = n-1
        d = nm1.int
        s = 0
        n = n.uint64
 
    while d mod 2 == 0:
        d = d shr 1
        s += 1
 
    for a in [2, 7, 61]:
        var
            x = 1.uint64
            p = a.uint64
            dr = d
 
        while dr > 0:
            if dr mod 2 == 1:
                x = x * p mod n
            p = p * p mod n
            dr = dr shr 1
 
        if x == 1 or x.uint32 == nm1:
            continue
 
        var r = 1
        while true:
            if r >= s: return false

            x = x * x mod n

            if x == 1: return false
            if x.uint32 == nm1: break

            inc(r)
 
    return true
 
proc isPrime*(n: int32): bool {.noSideEffect.} =
    n >= 0 and n.uint32.isPrime

proc primeFactors*(n: int): seq[int] =    
    var res: seq[int] = @[]
    var maxq = int(floor(sqrt(float(n))))
    var d = 1
    var q: int = (n %% 2) and 2 or 3  
    while (q <= maxq) and ((n %% q) != 0):
        q = 1 + d*4 - int(d /% 2)*2
        d += 1
    if q <= maxq:        
        var q1: seq[int] = primeFactors(n /% q)
        var q2: seq[int] = primeFactors(q)
        res = concat(q2, q1, res)
    else: 
        res.add(n)    
    result = res


#[######################################################
    Functions
  ======================================================]#

proc Math_abs*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = INT(abs(I(0)))

proc Math_acos*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(arccos(R(0)))

proc Math_acosh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(arccosh(R(0)))

proc Math_asin*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(arcsin(R(0)))

proc Math_asinh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(arcsinh(R(0)))

proc Math_atan*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(arctan(R(0)))

proc Math_atanh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(arctanh(R(0)))

proc Math_avg*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = A(0)[0]

    var i = 1
    while i < A(0).len:
        result = result + A(0)[i]
        inc(i)

    result = REAL(result.i / A(0).len)

proc Math_ceil*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(ceil(R(0)))

proc Math_cos*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(cos(R(0)))

proc Math_cosh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(cosh(R(0)))

proc Math_csec*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(csc(R(0)))

proc Math_csech*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(csch(R(0)))

proc Math_ctan*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(cot(R(0)))

proc Math_ctanh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(coth(R(0)))

proc Math_exp*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(exp(R(0)))

proc Math_floor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(floor(R(0)))

proc Math_gcd*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var current = A(0)[0].i
    var i = 1
    while i<A(0).len:
        current = gcd(current,A(0)[i].i)
        inc(i)

    result = INT(current)

proc Math_inc*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        result = INT(I(0)+1)
    else:
        result = BIGINT(BI(0)+1)

proc Math_incI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        I(0) += 1
        result = v[0]
    else:
        BI(0) += 1
        result = v[0]

proc Math_isEven*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        result = BOOL((I(0) mod 2)==0)
    else:
        result = BOOL(BI(0).even())

proc Math_isOdd*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        result = BOOL((I(0) mod 2)!=0)
    else:
        result = BOOL(BI(0).odd())

proc Math_isPrime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        if isPrime(I(0).uint32): result = TRUE
        else: result = FALSE
    else:
        if probablyPrime(BI(0),25)==0: result = FALSE
        else: result = TRUE

proc Math_lcm*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var current = A(0)[0].i
    var i = 1
    while i<A(0).len:
        current = lcm(current,A(0)[i].i)
        inc(i)

    result = INT(current)

proc Math_ln*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(ln(R(0)))

proc Math_log*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(log(R(0),R(1)))

proc Math_log2*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(log2(R(0)))

proc Math_log10*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(log10(R(0)))

proc Math_max*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = A(0)[0]
    var i = 1
    while i<A(0).len:
        if A(0)[i].gt(result):
            result = A(0)[i]
        inc(i)

proc Math_min*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = A(0)[0]
    var i = 1
    while i<A(0).len:
        if A(0)[i].lt(result):
            result = A(0)[i]
        inc(i)

proc Math_primeFactors*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = INTARR(primeFactors(I(0)))

proc Math_product*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = A(0)[0]

    var i = 1
    while i < A(0).len:
        result = result * A(0)[i]
        inc(i)

proc Math_random*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    randomize()

    result = INT(rand(I(0)..I(1)))

proc Math_round*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(round(R(0)))

proc Math_sec*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(sec(R(0)))

proc Math_sech*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(sech(R(0)))

proc Math_shl*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        result = INT(I(0) shl I(1))
    else:
        result = BIGINT(BI(0) shl culong(I(1)))

proc Math_shlI*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        I(0) = I(0) shl I(1)
        result = v[0]
    else:
        BI(0) = BI(0) shl culong(I(1))
        result = v[0]

proc Math_shr*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        result = INT(I(0) shr I(1))
    else:
        result = BIGINT(BI(0) shr culong(I(1)))

proc Math_shrI*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==IV:
        I(0) = I(0) shr I(1)
        result = v[0]
    else:
        BI(0) = BI(0) shr culong(I(1))
        result = v[0]

proc Math_sin*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(sin(R(0)))

proc Math_sinh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(sinh(R(0)))

proc Math_sqrt*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(sqrt(R(0)))

proc Math_sum*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = A(0)[0]

    var i = 1
    while i < A(0).len:
        result = result + A(0)[i]
        inc(i)

proc Math_tan*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(tan(R(0)))

proc Math_tanh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = REAL(tanh(R(0)))

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/math":

        test "avg":
            check(eq( callFunction("avg",@[ARR(@[INT(2),INT(4)])]), REAL(3.0) ))

        test "gcd":
            check(eq( callFunction("gcd",@[ARR(@[INT(2),INT(3),INT(4)])]), INT(1) ))

        test "isEven":
            check(eq( callFunction("isEven",@[INT(2)]), TRUE ))
            check(eq( callFunction("isEven",@[INT(3)]), FALSE ))
            check(eq( callFunction("isEven",@[INT(4)]), TRUE ))
            check(eq( callFunction("isEven",@[INT(5)]), FALSE ))
            check(eq( callFunction("isEven",@[INT(6)]), TRUE ))
            check(eq( callFunction("isEven",@[BIGINT("170141183460469231731687303715884105727")]), FALSE ))
            check(eq( callFunction("isEven",@[BIGINT("170141183460469231731687303715884105728")]), TRUE ))

        test "isOdd":
            check(eq( callFunction("isOdd",@[INT(2)]), FALSE ))
            check(eq( callFunction("isOdd",@[INT(3)]), TRUE ))
            check(eq( callFunction("isOdd",@[INT(4)]), FALSE ))
            check(eq( callFunction("isOdd",@[INT(5)]), TRUE ))
            check(eq( callFunction("isOdd",@[INT(6)]), FALSE ))
            check(eq( callFunction("isOdd",@[BIGINT("170141183460469231731687303715884105727")]), TRUE ))
            check(eq( callFunction("isOdd",@[BIGINT("170141183460469231731687303715884105728")]), FALSE ))

        test "isPrime":
            check(eq( callFunction("isPrime",@[INT(2)]), TRUE ))
            check(eq( callFunction("isPrime",@[INT(3)]), TRUE ))
            check(eq( callFunction("isPrime",@[INT(4)]), FALSE ))
            check(eq( callFunction("isPrime",@[INT(5)]), TRUE ))
            check(eq( callFunction("isPrime",@[INT(6)]), FALSE ))
            check(eq( callFunction("isPrime",@[INT(7)]), TRUE ))
            check(eq( callFunction("isPrime",@[INT(13)]), TRUE ))
            check(eq( callFunction("isPrime",@[INT(982451653)]), TRUE ))
            check(eq( callFunction("isPrime",@[INT(982451655)]), FALSE ))
            check(eq( callFunction("isPrime",@[BIGINT("170141183460469231731687303715884105727")]), TRUE ))
            check(eq( callFunction("isPrime",@[BIGINT("170141183460469231731687303715884105729")]), FALSE ))
            check(eq( callFunction("isPrime",@[BIGINT("20988936657440586486151264256610222593863921")]), TRUE ))
            check(eq( callFunction("isPrime",@[BIGINT("20988936657440586486151264256610222593863927")]), FALSE ))

        test "lcm":
            check(eq( callFunction("lcm",@[ARR(@[INT(2),INT(3),INT(4)])]), INT(12) ))

        test "max":
            check(eq( callFunction("max",@[ARR(@[INT(2),INT(3),INT(4)])]), INT(4) ))

        test "min":
            check(eq( callFunction("min",@[ARR(@[INT(2),INT(3),INT(4)])]), INT(2) ))

        test "product":
            check(eq( callFunction("product",@[ARR(@[INT(1),INT(2),INT(3)])]), INT(6) ))

        test "random":
            check(lt( callFunction("random",@[INT(1),INT(10)]), INT(11) ))
            check(lt( callFunction("random",@[INT(1),INT(10)]), INT(11) ))
            check(lt( callFunction("random",@[INT(1),INT(10)]), INT(11) ))
            check(lt( callFunction("random",@[INT(1),INT(10)]), INT(11) ))
            check(lt( callFunction("random",@[INT(1),INT(10)]), INT(11) ))

        test "shl":
            check(eq( callFunction("shl",@[INT(10),INT(2)]), INT(40) ))

        test "shr":
            check(eq( callFunction("shr",@[INT(10),INT(2)]), INT(2) ))

        test "sqrt":
            check(eq( callFunction("sqrt",@[REAL(4.0)]), REAL(2.0) ))

        test "sum":
            check(eq( callFunction("sum",@[ARR(@[INT(1),INT(2),INT(3)])]), INT(6) ))
