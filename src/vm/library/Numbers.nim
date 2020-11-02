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
# Methods
#=======================================

template Abs*():untyped = 
    # EXAMPLE:
    # print abs 6       ; 6
    # print abs 6-7     ; 1

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
    # EXAMPLE:
    # print average [2 4 5 6 7 2 3]
    # ; 4.142857142857143

    require(opAverage)

    var res = F0.copyValue

    for num in x.a:
        res += num

    res //= newFloating(x.a.len)

    stack.push(res)

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
    # EXAMPLE:
    # factors 16          ; => [1 2 4 8 16]
    # factors.prime 16    ; => [2]

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
    # EXAMPLE:
    # print gcd [48 60 120]         ; 12

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
    # EXAMPLE:
    # even? 4           ; => true
    # even? 3           ; => false
    #
    # print select 1..10 => even?       ; 2 4 6 8 10

    require(opEven)

    stack.push(newBoolean(x % I2 == I0))

template IsNegative*():untyped =
    # EXAMPLE:
    # negative? 5       ; => false
    # negative? 6-7     ; => true   

    require(opNegative)

    if x.kind==Integer and x.iKind==BigInteger:
        stack.push(newBoolean(negative(x.bi)))
    else:
        stack.push(newBoolean(x < I0))

template IsOdd*():untyped =
    # EXAMPLE:
    # odd? 4            ; => false
    # odd? 3            ; => true
    #
    # print select 1..10 => odd?       ; 1 3 5 7 9

    require(opOdd)

    stack.push(newBoolean(x % I2 == I1))

template IsPositive*():untyped =
    # EXAMPLE:
    # positive? 5       ; => true
    # positive? 6-7     ; => false

    require(opPositive)

    if x.kind==Integer and x.iKind==BigInteger:
        stack.push(newBoolean(positive(x.bi)))
    else:
        stack.push(newBoolean(x > I0))
    
template IsPrime*():untyped =
    # EXAMPLE:
    # prime? 2          ; => true
    # prime? 6          ; => false
    # prime? 11         ; => true
    #
    # ; let's check the 14th Mersenne:
    # ; 53113799281676709868958820655246862732959311772703192319944413
    # ; 82004035598608522427391625022652292856688893294862465010153465
    # ; 79337652707239409519978766587351943831270835393219031728127
    #
    # prime? (2^607)-1  ; => true

    require(opPrime)

    if x.iKind==NormalInteger:
        stack.push(newBoolean(isPrime(x.i.uint64)))
    else:
        stack.push(newBoolean(probablyPrime(x.bi,25)>0))

template IsZero*():untyped =
    # EXAMPLE:
    # zero? 5-5         ; => true
    # zero? 4           ; => false

    require(opZero)

    if x.kind==Integer and x.iKind==BigInteger:
        stack.push(newBoolean(isZero(x.bi)))
    else:
        stack.push(newBoolean(x == I0))

template Median*():untyped =
    # EXAMPLE:
    # print median [2 4 5 6 7 2 3]
    # ; 6
    #
    # print median [1 5 2 3 4 7 9 8]
    # ; 3.5

    require(opMedian)

    if x.a.len==0: 
        stack.push(VNULL)
    else:
        let first = x.a[(x.a.len-1) div 2]
        let second = x.a[((x.a.len-1) div 2)+1]

        if x.a.len mod 2 == 1:
            stack.push(first) 
        else:
            stack.push((first + second)//I2)

template Product*():untyped =
    # EXAMPLE:
    # print product [3 4]       ; 12
    # print product [1 2 4 6]   ; 48
    #
    # print product 1..10       ; 3628800

    require(opProduct)

    var i = 0
    var product = I1.copyValue
    while i<x.a.len:
        product *= x.a[i]
        i += 1

    stack.push(product)

template Random*():untyped =
    # EXAMPLE:
    # rnd: random 0 60          ; rnd: (a random number between 0 and 60)
    
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
    # EXAMPLE:
    # print sum [3 4]           ; 7
    # print sum [1 2 4 6]       ; 13
    #
    # print sum 1..10           ; 55

    require(opSum)

    var i = 0
    var sum = I0.copyValue
    while i<x.a.len:
        sum += x.a[i]
        i += 1

    stack.push(sum)

template Tan*():untyped = 
    require(opTan)

    stack.push(newFloating(tan(x.f)))

template Tanh*():untyped = 
    require(opTanh)

    stack.push(newFloating(tanh(x.f)))
