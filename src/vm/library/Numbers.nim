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

import bitops, math, sequtils, sugar

import extras/bignum
import vm/stack, vm/value

#=======================================
# Helpers
#=======================================

proc addmod*[T: SomeInteger](a, b, modulus: T): T =
    let a_m = if a < modulus: a else: a mod modulus
    if b == 0.T: return a_m
    let b_m = if b < modulus: b else: b mod modulus
 
    let b_from_m = modulus - b_m
    if a_m >= b_from_m: return a_m - b_from_m
    return a_m + b_m 
 
proc mulmod*[T: SomeInteger](a, b, modulus: T): T =
    var a_m = if a < modulus: a else: a mod modulus
    var b_m = if b < modulus: b else: b mod modulus
    if b_m > a_m: swap(a_m, b_m)
    while b_m > 0.T:
        if (b_m and 1) == 1: result = addmod(result, a_m, modulus)
        a_m = (a_m shl 1) - (if a_m >= (modulus - a_m): modulus else: 0)
        b_m = b_m shr 1
 
proc expmod*[T: SomeInteger](base, exponent, modulus: T): T =
    result = 1
    var (e, b) = (exponent, base)
    while e > 0.T:
        if (e and 1) == 1: result = mulmod(result, b, modulus)
        e = e shr 1
        b = mulmod(b, b, modulus)
 
proc miller_rabin_test[T: SomeInteger](num: T, witnesses: seq[uint64]): bool =
    var d = num - 1
    let (neg_one_mod, n) = (d, d)
    d = d shr countTrailingZeroBits(d)
    for b in witnesses:               
        if b.T mod num == 0: continue 
        var s = d
        var y = expmod(b.T, d, num)
        while s != n and y != 1 and y != neg_one_mod:
            y = mulmod(y, y, num)
            s = s shl 1
        if y != neg_one_mod and (s and 1) != 1: return false
    true
 
proc selectWitnesses[T: SomeInteger](num: T): seq[uint64] =
    if num < 341_531u:
        result = @[9345883071009581737u64]
    elif num < 1_050_535_501u:
        result = @[336781006125u64, 9639812373923155u64]
    elif num < 350_269_456_337u:
        result = @[4230279247111683200u64, 14694767155120705706u64, 16641139526367750375u64]
    elif num < 55_245_642_489_451u:
        result = @[2u64, 141889084524735u64, 1199124725622454117u64, 11096072698276303650u64]
    elif num < 7_999_252_175_582_851u:
        result = @[2u64, 4130806001517u64, 149795463772692060u64, 186635894390467037u64, 3967304179347715805u64]
    elif num < 585_226_005_592_931_977u:
        result = @[2u64, 123635709730000u64, 9233062284813009u64, 43835965440333360u64, 761179012939631437u64, 1263739024124850375u64]
    elif num.uint64 < 18_446_744_073_709_551_615u64:
        result = @[2u64, 325, 9375, 28178, 450775, 9780504, 1795265022]  
    else:
        result = @[2u64, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
 
proc isPrime*[T: SomeInteger](n: T): bool =
    let primes = @[2u64, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
    if n <= primes[^1].T: return (n in primes)
    let modp47 = 614889782588491410u
    if gcd(n, modp47) != 1: return false
    let witnesses = selectWitnesses(n)
    miller_rabin_test(n, witnesses)

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

proc factors*(n: int): seq[int] =
    var res: seq[int] = @[]

    var i = 1
    while i < n-1:
        if n mod i == 0:
            res.add(i)
        i += 1

    res.add(n)

    result = res

proc primeFactors*(n: int): seq[int] =   
    factors(n).filter((x)=>isPrime(x.uint64)) 

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

template Abs*():untyped = 
    require(opAbs)

    if x.iKind==NormalInteger: 
        stack.push(newInteger(abs(x.i)))
    else:
        stack.push(newInteger(abs(x.bi)))

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

template Factors*():untyped =
    require(opFactors)

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

template Gcd*():untyped =
    require(opGcd)

    var current = x.a[0]

    var i = 1

    while i<x.a.len:
        if current.iKind==NormalInteger:
            if x.a[i].iKind==BigInteger:
                current = newInteger(gcd(current.i, x.a[i].bi))
            else:
                current = newInteger(gcd(current.i, x.a[i].i))
        else:
            if x.a[i].iKind==BigInteger:
                current = newInteger(gcd(current.bi, x.a[i].bi))
            else:
                current = newInteger(gcd(current.bi, x.a[i].i))
        inc(i)

    stack.push(current)

template IsEven*():untyped =
    require(opEven)

    stack.push(newBoolean(x % I2 == I0))

template IsNegative*():untyped =
    require(opNegative)

    if x.kind==Integer and x.iKind==BigInteger:
        stack.push(newBoolean(negative(x.bi)))
    else:
        stack.push(newBoolean(x < I0))

template IsOdd*():untyped =
    require(opOdd)

    stack.push(newBoolean(x % I2 == I1))

template IsPositive*():untyped =
    require(opPositive)

    if x.kind==Integer and x.iKind==BigInteger:
        stack.push(newBoolean(positive(x.bi)))
    else:
        stack.push(newBoolean(x > I0))
    
template IsPrime*():untyped =
    require(opPrime)

    if x.iKind==NormalInteger:
        stack.push(newBoolean(isPrime(x.i.uint64)))
    else:
        stack.push(newBoolean(probablyPrime(x.bi,25)>0))

template IsZero*():untyped =
    require(opZero)

    if x.kind==Integer and x.iKind==BigInteger:
        stack.push(newBoolean(isZero(x.bi)))
    else:
        stack.push(newBoolean(x == I0))

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

template Product*():untyped =
    require(opProduct)

    var i = 0
    var product = I1
    while i<x.a.len:
        product = product * x.a[i]
        i += 1

    stack.push(product)

template Random*():untyped =
    require(opRandom)

    stack.push(newInteger(rand(x.i..y.i)))

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

template Sqrt*():untyped =
    require(opSqrt)

    if x.kind==Integer: stack.push(newFloating(sqrt((float)x.i)))
    else: stack.push(newFloating(sqrt(x.f)))

template Sum*():untyped =
    require(opSum)

    var i = 0
    var sum = I0
    while i<x.a.len:
        sum = sum + x.a[i]
        i += 1

    stack.push(sum)

template Tan*():untyped = 
    require(opTan)

    stack.push(newFloating(tan(x.f)))

template Tanh*():untyped = 
    require(opTanh)

    stack.push(newFloating(tanh(x.f)))
