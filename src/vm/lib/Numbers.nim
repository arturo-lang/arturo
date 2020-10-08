######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Numbers.nim
######################################################

#=======================================
# Libraries
#=======================================

import extras/bignum, math, sequtils

import vm/stack, vm/value

#=======================================
# Helpers
#=======================================

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

proc factors*(n: int): seq[int] =
    var res: seq[int] = @[]

    var i = 1
    while i < n-1:
        if n mod i == 0:
            res.add(i)
        i += 1

    res.add(n)

    result = res

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

proc factors*(n: Int): seq[Int] =
    var res: seq[Int] = @[]

    var i = newInt(1)
    while i < n-1:
        if n mod i == 0:
            res.add(i)
        i += 1

    res.add(n)

    result = res

#=======================================
# Methods
#=======================================

template Random*():untyped =
    require(opRandom)

    stack.push(newInteger(rand(x.i..y.i)))

template Abs*():untyped = 
    require(opAbs)

    stack.push(newInteger(abs(x.i)))

template Acos*():untyped = 
    require(opAcos)

    stack.push(newFloating(arccos(x.f)))

template Acosh*():untyped = 
    require(opAcosh)

    stack.push(newFloating(arccosh(x.f)))

template Asin*():untyped = 
    require(opAsin)

    stack.push(newFloating(arcsin(x.f)))

template Asinh*():untyped = 
    require(opAsinh)

    stack.push(newFloating(arcsinh(x.f)))

template Atan*():untyped = 
    require(opAtan)

    stack.push(newFloating(arctan(x.f)))

template Atanh*():untyped = 
    require(opAtanh)

    stack.push(newFloating(arctanh(x.f)))

template Cos*():untyped = 
    require(opAcos)

    stack.push(newFloating(cos(x.f)))

template Cosh*():untyped = 
    require(opCosh)

    stack.push(newFloating(cosh(x.f)))

template Csec*():untyped = 
    require(opCsec)

    stack.push(newFloating(csc(x.f)))

template Csech*():untyped = 
    require(opCsech)

    stack.push(newFloating(csch(x.f)))

template Ctan*():untyped = 
    require(opCtan)

    stack.push(newFloating(cot(x.f)))

template Ctanh*():untyped = 
    require(opCtanh)

    stack.push(newFloating(coth(x.f)))

template Sec*():untyped = 
    require(opSec)

    stack.push(newFloating(sec(x.f)))

template Sech*():untyped = 
    require(opSech)

    stack.push(newFloating(sech(x.f)))

template Sin*():untyped = 
    require(opSin)

    stack.push(newFloating(sin(x.f)))

template Sinh*():untyped = 
    require(opSinh)

    stack.push(newFloating(sinh(x.f)))

template Tan*():untyped = 
    require(opTan)

    stack.push(newFloating(tan(x.f)))

template Tanh*():untyped = 
    require(opTanh)

    stack.push(newFloating(tanh(x.f)))

template Sqrt*():untyped =
    require(opSqrt)

    if x.kind==Integer: stack.push(newFloating(sqrt((float)x.i)))
    else: stack.push(newFloating(sqrt(x.f)))

template Average*():untyped =
    require(opAverage)

    var res = 0.0

    for num in x.a:
        if num.kind==Integer:
            res += (float)num.i
        elif num.kind==Floating:
            res += num.f

    res = res / (float)(x.a.len)

    if (float)(toInt(res))==res:
        stack.push(newInteger(toInt(res)))
    else:
        stack.push(newFloating(res))

template Median*():untyped =
    require(opMedian)

    if x.a.len==0: 
        stack.push(VNULL)
    else:
        let first = x.a[(x.a.len-1) div 2]
        let second = x.a[((x.a.len-1) div 2)+1]

        if x.a.len mod 2 == 1:
            stack.push(first) 
        else:
            var res = 0.0

            if first.kind==Integer:
                if second.kind==Integer:
                    res = ((float)(first.i) + (float)(second.i))/2
                elif second.kind==Floating:
                    res = ((float)(first.i) + second.f)/2
            elif first.kind==Floating:
                if second.kind==Integer:
                    res = (first.f + (float)(second.i))/2
                elif second.kind==Floating:
                    res = (first.f + second.f)/2

            if (float)(toInt(res))==res:
                stack.push(newInteger(toInt(res)))
            else:
                stack.push(newFloating(res))

template Gcd*():untyped =
    require(opGcd)

    var current = x.a[0].i

    var i = 1

    while i<x.a.len:
        current = gcd(current, x.a[i].i)
        inc(i)

    stack.push(newInteger(current))

template Prime*():untyped =
    require(opPrime)

    if x.iKind==NormalInteger:
        stack.push(newBoolean(isPrime(x.i.uint32)))
    else:
        stack.push(newBoolean(probablyPrime(x.bi,10)==0))

template Factors*():untyped =
    require(opPrime)

    var prime = false
    if (popAttr("prime") != VNULL): prime = true

    if x.iKind==NormalInteger:
        if prime:
            stack.push(newBlock(primeFactors(x.i).map((x)=>newInteger(x))))
        else:
            stack.push(newBlock(factors(x.i).map((x)=>newInteger(x))))
    else:
        if prime:
            stack.push(newBlock(primeFactors(x.bi).map((x)=>newInteger(x))))
        else:
            stack.push(newBlock(factors(x.bi).map((x)=>newInteger(x))))

template Sum*():untyped =
    require(opSum)

    var i = 0
    var sum = I0
    while i<x.a.len:
        sum = sum + x.a[i]
        i += 1

    stack.push(sum)

template Product*():untyped =
    require(opProduct)

    var i = 0
    var product = I1
    while i<x.a.len:
        product = product * x.a[i]
        i += 1

    stack.push(product)