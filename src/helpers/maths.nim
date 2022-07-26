######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/math.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, bitops, std/math, sequtils, sugar

when defined(WEB):
    import std/jsbigints
elif not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import vm/values/value

#=======================================
# Methods
#=======================================

func addmod*[T: SomeInteger](a, b, modulus: T): T =
    let a_m = if a < modulus: a else: a mod modulus
    if b == 0.T: return a_m
    let b_m = if b < modulus: b else: b mod modulus
 
    let b_from_m = modulus - b_m
    if a_m >= b_from_m: return a_m - b_from_m
    return a_m + b_m 
 
func mulmod*[T: SomeInteger](a, b, modulus: T): T =
    var a_m = if a < modulus: a else: a mod modulus
    var b_m = if b < modulus: b else: b mod modulus
    if b_m > a_m: swap(a_m, b_m)
    while b_m > 0.T:
        if (b_m and 1) == 1: result = addmod(result, a_m, modulus)
        a_m = (a_m shl 1) - (if a_m >= (modulus - a_m): modulus else: 0)
        b_m = b_m shr 1
 
func expmod*[T: SomeInteger](base, exponent, modulus: T): T =
    result = 1
    var (e, b) = (exponent, base)
    while e > 0.T:
        if (e and 1) == 1: result = mulmod(result, b, modulus)
        e = e shr 1
        b = mulmod(b, b, modulus)
 
func miller_rabin_test*[T: SomeInteger](num: T, witnesses: seq[uint64]): bool =
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
 
func selectWitnesses*[T: SomeInteger](num: T): seq[uint64] =
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
 
func isPrime*[T: SomeInteger](n: T): bool =
    let primes = @[2u64, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
    if n <= primes[^1].T: return (n in primes)
    let modp47 = 614889782588491410u
    if gcd(n, modp47) != 1: return false
    let witnesses = selectWitnesses(n)
    miller_rabin_test(n, witnesses)

when not defined(NOGMP):
    func pollardG*(n: var Int, m: Int) {.inline.} =
        discard mul(n,n,n)
        discard add(n,n,1)
        discard `mod`(n,n,m)

    func pollardRho*(n: Int): Int =
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

# func factors*(n: int): seq[int] =
#     var res: seq[int] = @[]

#     var i = 1
#     let s = (int)sqrt((float) n)
#     while i <= s: #n-1:
#         if n mod i == 0:
#             res.add(i)
#             res.add(n div i)
#         i += 1

#     # res.add(n)

#     result = res

func factors*(n: int): seq[int] =
    var tail: seq[int] = @[]
    result = @[]

    var i = 1
    let s = (int)sqrt((float)n)
    while i <= s:
        if n mod i == 0:
            let d = n div i
            if i != d: tail.add(d)
            result.add(i)
        i += 1

    tail.reverse()
    result &= tail

func primeFactorization*(n: int): seq[int] =
    var x = n
    if x==0: return
    result = @[]
    while x mod 2 == 0:
        result.add(2)
        x = x div 2

    var i = 3
    while i <= (int)sqrt((float)x):
        while x mod i == 0:
            result.add(i)
            x = x div i
        i += 2

    if x>2:
        result.add(x)
    
    sort(result)

func primeFactors*(n: int): seq[int] =   
    factors(n).filter((x)=>isPrime(x.uint64)) 

func getDigits*(n: int, base: int = 10): seq[int] =
    if n == 0: return @[0]

    var num = n
    if num < 0: num = num * (-1)

    while num > 0:
        result.add(num mod base)
        num = num div base

    result.reverse()

when defined(WEB):
    func abs*(n: JsBigInt): JsBigInt =
        if n < big(0):
            big(-1) * n
        else:
            n

    func getDigits*(n: JsBigInt, base: int = 10): seq[int] =
        let bigZero = big(0)
        let bigBase = big(base)
        if n == bigZero: return @[0]

        var num = n
        if num < bigZero: num = num * big(-1)
        while num > bigZero:
            result.add((int)(toNumber(num mod bigBase)))
            num = num div bigBase

        result.reverse()

    func isqrt*[T: SomeSignedInt | JsBigInt](x: T): T =
        when T is JsBigInt:
            let bigZero = big(0)
            let bigOne = big(1)
            let bigTwo = big(2)
        else:
            let bigZero = 0
            let bigOne = 1
            let bigTwo = 2

        result = bigZero
        var q = bigOne
    
        while q <= x:
            q = q shl bigTwo
    
        var z = x
        while q > bigOne:
            q = q shr bigTwo
            let t = z - result - q
            result = result shr bigOne
            if t >= bigZero:
                z = t
                result += q

    func factors*(n: JsBigInt): seq[JsBigInt] =
        let bigZero = big(0)
        let bigOne = big(1)

        var tail: seq[JsBigInt] = @[]
        result = @[]
        
        var i = bigOne
        let s = isqrt(n)
        while i <= s:
            if n mod i == bigZero:
                let d = n div i
                if i != d: tail.add(d)
                result.add(i)
                
            i += bigOne

        tail.reverse()
        result &= tail

elif not defined(NOGMP):
    func getDigits*(n: Int, base: int = 10): seq[int] =
        if n == 0: return @[0]

        var num = n
        if num < 0: num = num * (-1)
        while num > 0:
            result.add(toCLong(num mod base))
            num = num div base

        result.reverse()

    func primeFactors*(num: Int): seq[Int] =
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
        
    func primeFactorization*(n: Int): seq[Int] =
        var x = n
        if x==0: return
        result = @[]
        #var d = newInt(1)
        #var m = newInt(1)
        while x mod 2 == 0:
            result.add(newInt(2))
            discard `div`(x, x, 2)

        var i = newInt(3)
        while i <= sqrt(x):
            #m = `mod`(x,i)
            #discard `mod`(m,x,i)
            while x mod i==0:
                result.add(i)
                x = x div i
                #(x,m) = divMod(x,i)
                #discard divMod(x,m,x,i)

            i = nextPrime(i)

        if x>2:
            result.add(x)
        
        sort(result)

    func factors*(n: Int): seq[Int] =
        var tail: seq[Int] = @[]
        result = @[]
        var i = newInt(1)
        let s = sqrt(n)
        while i <= s:
            if n mod i == 0:
                let d = n div i
                if i != d: tail.add(d)
                result.add(i)
                
            i += 1

        tail.reverse()
        result &= tail

    func isqrt*[T: SomeSignedInt | Int](x: T): T =
        when T is Int:
            result = newInt()
            var q = newInt(1)
        else:
            result = 0
            var q = T(1)
    
        while q <= x:
            q = q shl 2
    
        var z = x
        while q > 1:
            q = q shr 2
            let t = z - result - q
            result = result shr 1
            if t >= 0:
                z = t
                result += q

    func powmod*(x: Value, y: Value, z: Value): Value =
        var X : Value = x
        var Z : Value = z
        if x.iKind==NormalInteger: X = newBigInteger(x.i)
        if z.iKind==NormalInteger: Z = newBigInteger(z.i)

        if y.iKind==NormalInteger:
            newInteger(exp(X.bi, (culong)(y.i), Z.bi))
        else:
            newInteger(exp(X.bi, y.bi, Z.bi))
else:
    func isqrt*(x: int): int =
        result = 0
        var q = 1
    
        while q <= x:
            q = q shl 2
    
        var z = x
        while q > 1:
            q = q shr 2
            let t = z - result - q
            result = result shr 1
            if t >= 0:
                z = t
                result += q

proc cartesianProduct*[T](a: varargs[seq[T]]): seq[seq[T]] =
    if a.len == 1:
        for x in a[0]:
          result.add(@[x])
    else:
        for x in a[0]:
            for s in cartesianProduct(a[1..^1]):
                result.add(x & s)