######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Numbers.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import math, random, sequtils, sugar
import extras/bignum

import helpers/math as MathHelper

import vm/[common, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Numbers"

    builtin "abs",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get the absolute value for given integer",
        args        = {
            "value" : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print abs 6       ; 6
            print abs 6-7     ; 1
        """:
            ##########################################################
            if x.iKind==NormalInteger: 
                stack.push(newInteger(abs(x.i)))
            else:
                stack.push(newInteger(abs(x.bi)))

    builtin "acos",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse cosine of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\acos) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(arccos(x.f)))

    builtin "acosh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic cosine of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\acosh) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(arccosh(x.f)))

    builtin "asin",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse sine of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\asin) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(arcsin(x.f)))

    builtin "asinh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic sine of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\asinh) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(arcsinh(x.f)))

    builtin "atan",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse tangent of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\atan) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(arctan(x.f)))

    builtin "atanh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic tangent of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\atanh) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(arctanh(x.f)))

    builtin "average",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get average from given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print average [2 4 5 6 7 2 3]
            ; 4.142857142857143
        """:
            ##########################################################
            var res = F0.copyValue

            for num in x.a:
                res += num

            res //= newFloating(x.a.len)

            stack.push(res)

    builtin "cos",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the cosine of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\cos) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(cos(x.f)))

    builtin "cosh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cosine of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\cosh) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(cosh(x.f)))

    builtin "csec",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the cosecant of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\csec) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(csc(x.f)))

    builtin "csech",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cosecant of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\csech) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(csch(x.f)))

    builtin "ctan",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the cotangent of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\ctan) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(cot(x.f)))

    builtin "ctanh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cotangent of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\ctanh) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(coth(x.f)))

    constant "epsilon",
        alias       = unaliased,
        description = "The constant e, Euler's number":
            newFloating(E)

    builtin "even?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given number is even",
        args        = {
            "number"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            even? 4           ; => true
            even? 3           ; => false
            
            print select 1..10 => even?       ; 2 4 6 8 10
        """:
            ##########################################################
            stack.push(newBoolean(x % I2 == I0))

    builtin "exp",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the exponential function for given value",
        args        = {
            "value" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\exp) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(exp(x.f)))

    builtin "factors",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get list of factors for given integer",
        args        = {
            "number"    : {Integer}
        },
        attrs       = {
            "prime" : ({Boolean},"get only prime factors")
        },
        returns     = {Block},
        example     = """
            factors 16          ; => [1 2 4 8 16]
            factors.prime 16    ; => [2]
        """:
            ##########################################################
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

    builtin "gamma",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the gamma function for given value",
        args        = {
            "value" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\gamma) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(gamma(x.f)))

    builtin "gcd",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate greatest common divisor for given collection of integers",
        args        = {
            "numbers"   : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print gcd [48 60 120]         ; 12
        """:
            ##########################################################
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

    builtin "median",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get median from given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Null},
        example     = """
            print median [2 4 5 6 7 2 3]
            ; 6
            
            print median [1 5 2 3 4 7 9 8]
            ; 3.5
        """:
            ##########################################################
            if x.a.len==0: 
                stack.push(VNULL)
            else:
                let first = x.a[(x.a.len-1) div 2]
                let second = x.a[((x.a.len-1) div 2)+1]

                if x.a.len mod 2 == 1:
                    stack.push(first) 
                else:
                    stack.push((first + second)//I2)

    builtin "negative?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given number is negative",
        args        = {
            "number"    : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            negative? 5       ; => false
            negative? 6-7     ; => true 
        """:
            ##########################################################
            if x.kind==Integer and x.iKind==BigInteger:
                stack.push(newBoolean(negative(x.bi)))
            else:
                stack.push(newBoolean(x < I0))

    builtin "odd?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given number is odd",
        args        = {
            "number"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            odd? 4            ; => false
            odd? 3            ; => true
            
            print select 1..10 => odd?       ; 1 3 5 7 9
        """:
            ##########################################################
            stack.push(newBoolean(x % I2 == I1))

    constant "pi",
        alias       = unaliased,
        description = "The number π, mathematical constant":
            newFloating(PI)

    builtin "positive?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given number is positive",
        args        = {
            "number"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            positive? 5       ; => true
            positive? 6-7     ; => false
        """:
            ##########################################################
            if x.kind==Integer and x.iKind==BigInteger:
                stack.push(newBoolean(positive(x.bi)))
            else:
                stack.push(newBoolean(x > I0))
        
    builtin "prime?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given integer is prime",
        args        = {
            "number"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            prime? 2          ; => true
            prime? 6          ; => false
            prime? 11         ; => true
            
            ; let's check the 14th Mersenne:
            ; 53113799281676709868958820655246862732959311772703192319944413
            ; 82004035598608522427391625022652292856688893294862465010153465
            ; 79337652707239409519978766587351943831270835393219031728127
            
            prime? (2^607)-1  ; => true
        """:
            ##########################################################
            if x.iKind==NormalInteger:
                stack.push(newBoolean(isPrime(x.i.uint64)))
            else:
                stack.push(newBoolean(probablyPrime(x.bi,25)>0))

    builtin "product",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the product of all values in given list",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating},
        example     = """
            print product [3 4]       ; 12
            print product [1 2 4 6]   ; 48
            
            print product 1..10       ; 3628800
        """:
            ##########################################################
            var i = 0
            var product = I1.copyValue
            while i<x.a.len:
                product *= x.a[i]
                i += 1

            stack.push(product)

    builtin "random",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get a random integer between given limits",
        args        = {
            "lowerLimit"    : {Integer},
            "upperLimit"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            rnd: random 0 60          ; rnd: (a random number between 0 and 60)
        """:
            ##########################################################
            stack.push(newInteger(rand(x.i..y.i)))

    builtin "range",
        alias       = ellipsis, 
        rule        = InfixPrecedence,
        description = "get list of numbers in given range (inclusive)",
        args        = {
            "from"  : {Integer},
            "to"    : {Integer}
        },
        attrs       = {
            "step"  : ({Integer},"use step between range values")
        },
        returns     = {Block},
        example     = """
            print range 1 4       ; 1 2 3 4
            1..10                 ; [1 2 3 4 5 6 7 8 9 10]
        """:
            ##########################################################
            var res = newBlock()

            var step = 1
            if (let aStep = popAttr("step"); aStep != VNULL):
                step = aStep.i

            if x.i < y.i:
                var j = x.i
                while j <= y.i:
                    res.a.add(newInteger(j))
                    j += step
            else:
                var j = x.i
                while j >= y.i:
                    res.a.add(newInteger(j))
                    j -= step

            stack.push(res)

    builtin "round",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "round given value to zero decimal places",
        args        = {
            "value" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\round) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(round(x.f)))

    builtin "sec",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the secant of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\sec) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(sec(x.f)))

    builtin "sech",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic secant of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\sech) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(sech(x.f)))

    builtin "sin",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the sine of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\sin) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(sin(x.f)))

    builtin "sinh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic sine of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\sinh) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(sinh(x.f)))

    builtin "sqrt",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get square root of given value",
        args        = {
            "value" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\sqrt) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            if x.kind==Integer: stack.push(newFloating(sqrt((float)x.i)))
            else: stack.push(newFloating(sqrt(x.f)))

    builtin "sum",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the sum of all values in given list",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating},
        example     = """
            print sum [3 4]           ; 7
            print sum [1 2 4 6]       ; 13
            
            print sum 1..10           ; 55
        """:
            ##########################################################
            var i = 0
            var sum = I0.copyValue
            while i<x.a.len:
                sum += x.a[i]
                i += 1

            stack.push(sum)

    builtin "tan",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the tangent of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\tan) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(tan(x.f)))

    builtin "tanh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic tangent of given angle",
        args        = {
            "angle" : {Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        # TODO(Numbers\tanh) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            stack.push(newFloating(tanh(x.f)))

    builtin "zero?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given number is zero",
        args        = {
            "number"    : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            zero? 5-5         ; => true
            zero? 4           ; => false
        """:
            ##########################################################
            if x.kind==Integer and x.iKind==BigInteger:
                stack.push(newBoolean(isZero(x.bi)))
            else:
                stack.push(newBoolean(x == I0))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)