#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/math.nim
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


#[######################################################
    Functions
  ======================================================]#

proc Math_isPrime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("isPrime", f.req)

    if v[0].kind==IV:
        if isPrime(I(0).uint32): result = TRUE
        else: result = FALSE
    else:
        if probablyPrime(BI(0),25)==0: result = FALSE
        else: result = TRUE

proc Math_product*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("product", f.req)

    result = A(0)[0]

    var i = 1
    while i < A(0).len:
        result = result * A(0)[i]
        inc(i)

proc Math_shl*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v = xl.validate("shl", f.req)

    if v[0].kind==IV:
        result = INT(I(0) shl I(1))
    else:
        result = BIGINT(BI(0) shl culong(I(1)))

proc Math_shlI*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v = xl.validate("shl!", f.req)

    if v[0].kind==IV:
        I(0) = I(0) shl I(1)
        result = v[0]
    else:
        BI(0) = BI(0) shl culong(I(1))
        result = v[0]

proc Math_shr*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v = xl.validate("shl", f.req)

    if v[0].kind==IV:
        result = INT(I(0) shr I(1))
    else:
        result = BIGINT(BI(0) shr culong(I(1)))

proc Math_shrI*[F,X,V](f: F, xl: X): V  {.inline.} =
    let v = xl.validate("shr!", f.req)

    if v[0].kind==IV:
        I(0) = I(0) shr I(1)
        result = v[0]
    else:
        BI(0) = BI(0) shr culong(I(1))
        result = v[0]

proc Math_sum*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("sum", f.req)

    result = A(0)[0]

    var i = 1
    while i < A(0).len:
        result = result + A(0)[i]
        inc(i)

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/math":

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

        test "product":
            check(eq( callFunction("product",@[ARR(@[INT(1),INT(2),INT(3)])]), INT(6) ))

        test "shl":
            check(eq( callFunction("shl",@[INT(10),INT(2)]), INT(40) ))

        test "shr":
            check(eq( callFunction("shr",@[INT(10),INT(2)]), INT(2) ))

        test "sum":
            check(eq( callFunction("sum",@[ARR(@[INT(1),INT(2),INT(3)])]), INT(6) ))
