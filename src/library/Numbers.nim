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
            "value" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print abs 6       ; 6
            print abs 6-7     ; 1
        """:
            ##########################################################
            if x.kind==Integer:
                if x.iKind==NormalInteger: 
                    stack.push(newInteger(abs(x.i)))
                else:
                    stack.push(newInteger(abs(x.bi)))
            else:
                stack.push(newFloating(abs(x.f)))

    builtin "acos",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse cosine of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print acos 0            ; 1.570796326794897
            print acos 0.3          ; 1.266103672779499
            print acos 1.0          ; 0.0
        """:
            ##########################################################
            stack.push(newFloating(arccos(asFloat(x))))

    builtin "acosh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic cosine of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print acosh 1.0         ; 0.0
            print acosh 2           ; 1.316957896924817
            print acosh 5.0         ; 2.292431669561178
        """:
            ##########################################################
            stack.push(newFloating(arccosh(asFloat(x))))

    builtin "asin",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse sine of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print asin 0            ; 0.0
            print asin 0.3          ; 0.3046926540153975
            print asin 1.0          ; 1.570796326794897
        """:
            ##########################################################
            stack.push(newFloating(arcsin(asFloat(x))))

    builtin "asinh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic sine of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print asinh 0           ; 0.0
            print asinh 0.3         ; 0.2956730475634224
            print asinh 1.0         ; 0.881373587019543
        """:
            ##########################################################
            stack.push(newFloating(arcsinh(asFloat(x))))

    builtin "atan",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse tangent of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print atan 0            ; 0.0
            print atan 0.3          ; 0.2914567944778671
            print atan 1.0          ; 0.7853981633974483
        """:
            ##########################################################
            stack.push(newFloating(arctan(asFloat(x))))

    builtin "atanh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic tangent of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print atanh 0           ; 0.0
            print atanh 0.3         ; 0.3095196042031118
            print atanh 1.0         ; inf
        """:
            ##########################################################
            stack.push(newFloating(arctanh(asFloat(x))))

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

    builtin "ceil",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the smallest integer not smaller than given value",
        args        = {
            "value" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print ceil 2.1          ; 3
            print ceil 2.9          ; 3
            print ceil neg 3.5      ; -3
            print ceil 4            ; 4
        """:
            ##########################################################
            stack.push(newInteger((int)(ceil(asFloat(x)))))

    builtin "cos",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the cosine of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print cos 0             ; 1.0
            print cos 0.3           ; 0.955336489125606
            print cos 1.0           ; 0.5403023058681398
        """:
            ##########################################################
            stack.push(newFloating(cos(asFloat(x))))

    builtin "cosh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cosine of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print cosh 0            ; 1.0
            print cosh 0.3          ; 1.04533851412886
            print cosh 1.0          ; 1.543080634815244
        """:
            ##########################################################
            stack.push(newFloating(cosh(asFloat(x))))

    builtin "csec",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the cosecant of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print csec 0            ; inf
            print csec 0.3          ; 3.383863361824123
            print csec 1.0          ; 1.188395105778121
        """:
            ##########################################################
            stack.push(newFloating(csc(asFloat(x))))

    builtin "csech",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cosecant of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print csech 0           ; inf
            print csech 0.3         ; 3.283853396698424
            print csech 1.0         ; 0.8509181282393216
        """:
            ##########################################################
            stack.push(newFloating(csch(asFloat(x))))

    builtin "ctan",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the cotangent of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print ctan 0            ; inf
            print ctan 0.3          ; 3.232728143765828
            print ctan 1.0          ; 0.6420926159343308
        """:
            ##########################################################
            stack.push(newFloating(cot(asFloat(x))))

    builtin "ctanh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cotangent of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print ctanh 0           ; inf
            print ctanh 0.3         ; 3.432738430321741
            print ctanh 1.0         ; 1.313035285499331
        """:
            ##########################################################
            stack.push(newFloating(coth(asFloat(x))))

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
            "value" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print exp 1.0       ; 2.718281828459045
            print exp 0         ; 1.0
            print exp neg 1.0   ; 0.3678794411714423
        """:
            ##########################################################
            stack.push(newFloating(exp(asFloat(x))))

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

    builtin "floor",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the largest integer not greater than given value",
        args        = {
            "value" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print floor 2.1         ; 2
            print floor 2.9         ; 2
            print floor neg 3.5     ; -4
            print floor 4           ; 4
        """:
            ##########################################################
            stack.push(newInteger((int)(floor(asFloat(x)))))

    builtin "gamma",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the gamma function for given value",
        args        = {
            "value" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print gamma 3.0         ; 2.0
            print gamma 10.0        ; 362880.0
            print gamma 15          ; 87178291199.99985
        """:
            ##########################################################
            stack.push(newFloating(gamma(asFloat(x))))

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

    builtin "ln",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the natural logarithm of given value",
        args        = {
            "value" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print ln 1.0            ; 0.0
            print ln 0              ; -inf
            print ln neg 7.0        ; nan
        """:
            ##########################################################
            stack.push(newFloating(ln(asFloat(x))))

    builtin "log",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the logarithm of value using given base",
        args        = {
            "value" : {Integer,Floating},
            "base"  : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print log 9 3           ; 2.0
            print log 32.0 2.0      ; 5.0
            print log 0.0 2         ; -inf
            print log 100.0 10.0    ; 2.0
        """:
            ##########################################################
            stack.push(newFloating(log(asFloat(x),asFloat(y))))

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
        description = "round given value",
        args        = {
            "value" : {Integer,Floating}
        },
        attrs       = {
            "to"    : ({Integer},"round to given decimal places")
        },
        returns     = {Floating},
        example     = """
            print round 2.1         ; 2.0
            print round 2.9         ; 3.0
            print round 6           ; 6.0

            print round pi          ; 3.0
            print round.to:5 pi     ; 3.14159
            print round.to:2 pi     ; 3.14
        """:
            ##########################################################
            var places = 0
            if (let aTo = popAttr("to"); aTo != VNULL):
                places = aTo.i
                
            stack.push(newFloating(round(asFloat(x), places)))

    builtin "sec",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the secant of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print sec 0             ; 1.0
            print sec 0.3           ; 1.046751601538086
            print sec 1.0           ; 1.850815717680925
        """:
            ##########################################################
            stack.push(newFloating(sec(asFloat(x))))

    builtin "sech",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic secant of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print sech 0            ; 1.0
            print sech 0.3          ; 0.9566279119002483
            print sech 1.0          ; 0.6480542736638855
        """:
            ##########################################################
            stack.push(newFloating(sech(asFloat(x))))

    builtin "sin",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the sine of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print sin 0             ; 0.0
            print sin 0.3           ; 0.2955202066613395
            print sin 1.0           ; 0.8414709848078965
        """:
            ##########################################################
            stack.push(newFloating(sin(asFloat(x))))

    builtin "sinh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic sine of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print sinh 0            ; 0.0
            print sinh 0.3          ; 0.3045202934471426
            print sinh 1.0          ; 1.175201193643801
        """:
            ##########################################################
            stack.push(newFloating(sinh(asFloat(x))))

    builtin "sqrt",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get square root of given value",
        args        = {
            "value" : {Integer,Floating}
        },
        attrs       = {
            "integer"   : ({Boolean},"get the integer square root")
        },
        returns     = {Floating},
        example     = """
            print sqrt 4            ; 2.0
            print sqrt 16.0         ; 4.0
            print sqrt 1.45         ; 1.20415945787923
        """:
            ##########################################################
            if (popAttr("integer") != VNULL):
                if x.iKind == NormalInteger:
                    stack.push(newInteger(isqrt(x.i)))
                else:
                    stack.push(newInteger(isqrt(x.bi)))
            else:
                stack.push(newFloating(sqrt(asFloat(x))))

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
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print tan 0             ; 0.0
            print tan 0.3           ; 0.3093362496096232
            print tan 1.0           ; 1.557407724654902
        """:
            ##########################################################
            stack.push(newFloating(tan(asFloat(x))))

    builtin "tanh",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic tangent of given angle",
        args        = {
            "angle" : {Integer,Floating}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print tanh 0            ; 0.0
            print tanh 0.3          ; 0.2913126124515909
            print tanh 1.0          ; 0.7615941559557649
        """:
            ##########################################################
            stack.push(newFloating(tanh(asFloat(x))))

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