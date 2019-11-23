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

proc isPrime*(n: uint32): bool =
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
 
proc isPrime*(n: int32): bool =
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

proc pollardG*(n: var Int, m: Int) {.inline.} =
    discard mul(n,n,n)
    discard add(n,n,1)
    discard `mod`(n,n,m)

proc pollardRho*(n: Int): Int =
    var x = newInt(2)
    var y = newInt(2)
    var d = newInt(1)
    var z = newInt(1)

    var count = 0
    var t = newInt(0)

    while true:
        pollardG(x,n)
        pollardG(y,n)
        pollardG(y,n)

        discard abs(t,sub(t,x,y))
        discard `mod`(t,t,n)
        discard mul(z,z,t)

        inc(count)
        if count==100:
            discard gcd(d,z,n)
            if cmp(d,1)!=0:
                break
            discard set(z,1)
            count = 0

    if cmp(d,n)==0:
        return newInt(0)
    else:
        return d

proc primeFactors*(num: Int): seq[Int] =
    result = @[]
    var n = num

    if n.probablyPrime(10)!=0:
        result.add(n)

    let factor1 = pollardRho(num)
    if factor1==0:
        return @[]

    if factor1.probablyPrime(10)==0:
        return @[]

    let factor2 = n div factor1
    if factor2.probablyPrime(10)==0:
        return @[factor1]

    result.add(factor1)
    result.add(factor2)

#[######################################################
    Functions
  ======================================================]#

proc Math_abs*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV)

    result = SINT(abs(I(v0)))

proc Math_acos*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(arccos(R(v0)))

proc Math_acosh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(arccosh(R(v0)))

proc Math_asin*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(arcsin(R(v0)))

proc Math_asinh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(arcsinh(R(v0)))

proc Math_atan*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(arctan(R(v0)))

proc Math_atanh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(arctanh(R(v0)))

proc Math_avg*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = A(v0)[0]

    var i = 1
    while i < A(v0).len:
        result = result ++ A(v0)[i]
        inc(i)

    result = REAL(float32(I(result) / A(v0).len))

proc Math_ceil*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(ceil(R(v0)))

proc Math_cos*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(cos(R(v0)))

proc Math_cosh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(cosh(R(v0)))

proc Math_csec*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(csc(R(v0)))

proc Math_csech*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(csch(R(v0)))

proc Math_ctan*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(cot(R(v0)))

proc Math_ctanh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(coth(R(v0)))

proc Math_exp*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(exp(R(v0)))

proc Math_floor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(floor(R(v0)))

proc Math_gcd*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    var current = I(A(v0)[0])
    var i = 1
    while i<A(v0).len:
        current = gcd(current,I(A(v0)[i]))
        inc(i)

    result = SINT(current)

proc Math_inc*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    result = v0 ++ 1

proc Math_isEven*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    if v0.kind==IV:
        result = BOOL((I(v0) mod 2)==0)
    else:
        result = BOOL(BI(v0).even())

proc Math_isOdd*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    if v0.kind==IV:
        result = BOOL((I(v0) mod 2)!=0)
    else:
        result = BOOL(BI(v0).odd())

proc Math_isPrime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    if v0.kind==IV:
        if isPrime(I(v0).uint32): result = TRUE
        else: result = FALSE
    else:
        if probablyPrime(BI(v0),25)==0: result = FALSE
        else: result = TRUE

proc Math_lcm*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    var current = I(A(v0)[0])
    var i = 1
    while i<A(v0).len:
        current = lcm(current,I(A(v0)[i]))
        inc(i)

    result = SINT(current)

proc Math_ln*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(ln(R(v0)))

proc Math_log*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)
    let v1 = VALID(1,RV)

    result = REAL(log(R(v0),R(v1)))

proc Math_log2*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(log2(R(v0)))

proc Math_log10*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(log10(R(v0)))

proc Math_max*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = A(v0)[0]
    var i = 1
    while i<A(v0).len:
        if A(v0)[i].gt(result):
            result = A(v0)[i]
        inc(i)

proc Math_min*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = A(v0)[0]
    var i = 1
    while i<A(v0).len:
        if A(v0)[i].lt(result):
            result = A(v0)[i]
        inc(i)

proc Math_neg*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|RV|BIV)

    case v0.kind
        of IV: result = SINT(-1 * I(v0))
        of RV: result = REAL(float32(-1.0 * R(v0)))
        of BIV: result = BIGINT(-1 * BI(v0))
        else: discard

proc Math_pi*[F,X,V](f: F, xl: X): V {.inline.} =
    result = REAL(PI)

proc Math_primeFactors*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    if v0.kind==IV:
        result = INTARR(primeFactors(I(v0)))
    else:
        result = BIGINTARR(primeFactors(BI(v0)))

proc Math_product*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = A(v0)[0]

    var i = 1
    while i < A(v0).len:
        result = result ** A(v0)[i]
        inc(i)

proc Math_random*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV)
    let v1 = VALID(1,IV)

    randomize()

    result = SINT(rand(I(v0)..I(v1)))

proc Math_round*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(round(R(v0)))

proc Math_sec*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(sec(R(v0)))

proc Math_sech*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(sech(R(v0)))

proc Math_shl*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v0 = VALID(0,IV|BIV)
    let v1 = VALID(1,IV)

    if v0.kind==IV:
        result = SINT(I(v0) shl I(v1))
    else:
        result = BIGINT(BI(v0) shl culong(I(v1)))

proc Math_shr*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v0 = VALID(0,IV|BIV)
    let v1 = VALID(1,IV)

    if v0.kind==IV:
        result = SINT(I(v0) shr I(v1))
    else:
        result = BIGINT(BI(v0) shr culong(I(v1)))

proc Math_sin*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(sin(R(v0)))

proc Math_sinh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(sinh(R(v0)))

proc Math_sqrt*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(sqrt(R(v0)))

proc Math_sum*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = A(v0)[0]

    var i = 1
    while i < A(v0).len:
        result = result ++ A(v0)[i]
        inc(i)

proc Math_tan*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(tan(R(v0)))

proc Math_tanh*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,RV)

    result = REAL(tanh(R(v0)))

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
