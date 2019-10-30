#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/numbers.nim
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

proc Numbers_IsPrime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)
    if isPrime(I(0).uint32): result = TRUE
    else: result = FALSE
