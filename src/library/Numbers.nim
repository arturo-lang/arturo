#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: library/Numbers.nim
#=======================================================

## The main Numbers module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import math, random, sequtils, sugar

when defined(WEB):
    import std/jsbigints

when defined(GMP):
    import helpers/bignums as BignumsHelper

import helpers/maths
import helpers/ranges
import vm/values/custom/vrange
import vm/values/custom/vquantity

import vm/errors

import vm/lib

#=======================================
# Helpers
#=======================================

template processTrigonometric(fun: untyped): untyped =
    var v = x
    if xKind == Quantity:
        v = newQuantity(x.q.convertTo(parseAtoms("rad")))

    if v.kind==Complex: push(newComplex(fun(v.z)))
    elif v.kind==Rational: push(newRational(fun(toFloat(v.rat))))
    else: push(newFloating(fun(asFloat(v))))

#=======================================
# Definitions
#=======================================

# TODO(Numbers) add `cbrt` built-in function
#  the goal would be to have a function that returns the cubic root of a number
#  potential use: https://rosettacode.org/wiki/Cubic_special_primes
#  labels: library, enhancement, new feature
 
proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    builtin "abs",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get the absolute value for given integer",
        args        = {
            "value" : {Integer,Floating,Complex,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating},
        example     = """
            print abs 6                 ; 6
            print abs 6-7               ; 1
            ..........
            abs to :complex @[pi 1] 
            ; => 3.296908309475615
        """:
            #=======================================================
            if xKind==Integer:
                if x.iKind==NormalInteger: 
                    push(newInteger(abs(x.i)))
                else:
                    when defined(WEB) or defined(GMP):
                        push(newInteger(abs(x.bi)))
            elif xKind==Floating:
                push(newFloating(abs(x.f)))
            elif xKind==Complex:
                push(newFloating(abs(x.z)))
            else:
                push(newRational(abs(x.rat)))

    builtin "acos",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse cosine of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print acos 0                ; 1.570796326794897
            print acos 0.3              ; 1.266103672779499
            print acos 1.0              ; 0.0
            ..........
            acos to :complex @[pi 1]
            ; => 0.3222532939814587-1.86711439316026i
        """:
            #=======================================================
            processTrigonometric(arccos)

    builtin "acosh",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic cosine of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print acosh 1.0             ; 0.0
            print acosh 2               ; 1.316957896924817
            print acosh 5.0             ; 2.292431669561178
            ..........
            acosh to :complex @[pi 1]
            ; => 1.86711439316026+0.3222532939814587i
        """:
            #=======================================================
            processTrigonometric(arccosh)

    builtin "acsec",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse cosecant of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print acsec 0               ; nan
            print acsec 1.0             ; 1.570796326794897
            print acsec 10              ; 0.1001674211615598
            ..........
            acsec to :complex @[pi 1]
            ; => 0.2918255976444114-0.0959139808172324i
        """:
            #=======================================================
            processTrigonometric(arccsc)

    builtin "acsech",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic cosecant of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print acsech 0              ; inf
            print acsech 1.0            ; 0.0
            print acsech 10             ; 0.09983407889920758
            ..........
            acsech to :complex @[pi 1]
            ; => 0.2862356627279947-0.08847073864038091i
        """:
            #=======================================================
            processTrigonometric(arccsch)

    builtin "actan",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse cotangent of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print actan 0                   ; 1.570796326794897
            print actan 1                   ; 0.7853981633974483
            print actan 10.0                ; 0.09966865249116204
            ..........
            actan to :complex @[pi 1]
            ; => 0.2834557524705047-0.08505998507745414i
        """:
            #=======================================================
            processTrigonometric(arccot)

    builtin "actanh",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic cotangent of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print actanh 0                  ; nan
            print actanh 1                  ; inf
            print actanh 10.0               ; 0.1003353477310756
            ..........
            actanh to :complex @[pi 1]
            ; => 0.2946214403408572-0.09996750087543603i
        """:
            #=======================================================
            processTrigonometric(arccoth)

    builtin "angle",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the phase angle of given number",
        args        = {
            "number" : {Complex}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            a: to complex [1 1]     ; a: 1.0+1.0i
            print angle a           ; 0.7853981633974483
        """:
            #=======================================================
            push(newFloating(phase(x.z)))

    builtin "asec",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse secant of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print asec 0                ; nan
            print asec 45               ; 1.548572275176629
            print asec 5                ; 1.369438406004566
            ..........
            asec to :complex @[pi 1]
            ; => 1.278970729150485+0.09591398081723231i
        """:
            #=======================================================
            processTrigonometric(arcsec)

    builtin "asech",
        alias       = unaliased,
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic secant of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print asech 0               ; inf
            print asech 0.45            ; 1.436685652839686
            print asech 1               ; 0.0
            ..........
            asech to :complex @[pi 1]
            ; => 0.09591398081723221-1.278970729150485i
        """:
            #=======================================================
            processTrigonometric(arcsech)

    builtin "asin",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse sine of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print asin 0                ; 0.0
            print asin 0.3              ; 0.3046926540153975
            print asin 1.0              ; 1.570796326794897
            ..........
            asin to :complex @[pi 1]
            ; => 1.248543032813438+1.867114393160262i
        """:
            #=======================================================
            processTrigonometric(arcsin)

    builtin "asinh",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic sine of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print asinh 0               ; 0.0
            print asinh 0.3             ; 0.2956730475634224
            print asinh 1.0             ; 0.881373587019543
            ..........
            asinh to :complex @[pi 1]
            ; => 1.904627686970658+0.2955850342116299i
        """:
            #=======================================================
            processTrigonometric(arcsinh)

    builtin "atan",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse tangent of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print atan 0                ; 0.0
            print atan 0.3              ; 0.2914567944778671
            print atan 1.0              ; 0.7853981633974483
            ..........
            atan to :complex @[pi 1]
            ; => 1.287340574324392+0.08505998507745416i
        """:
            #=======================================================
            processTrigonometric(arctan)

    builtin "atan2",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse tangent of y / x",
        args        = {
            "y"     : {Integer,Floating,Rational},
            "x"     : {Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            atan2 1 1           ; 0.7853981633974483
            atan2 1 1.5         ; 0.9827937232473291
        """:
            #=======================================================
            push(newFloating(arctan2(asFloat(y), asFloat(x))))

    builtin "atanh",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the inverse hyperbolic tangent of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print atanh 0               ; 0.0
            print atanh 0.3             ; 0.3095196042031118
            print atanh 1.0             ; inf
            ..........
            atanh to :complex @[pi 1]
            ; => 0.2946214403408571+1.470828825919461i
        """:
            #=======================================================
            processTrigonometric(arctanh)

    builtin "ceil",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the smallest integer not smaller than given value",
        args        = {
            "value" : {Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print ceil 2.1                      ; 3
            print ceil 2.9                      ; 3
            print ceil neg 3.5                  ; -3
            print ceil 4                        ; 4
            print ceil to :rational @[neg 7 2]  ; -3
        """:
            #=======================================================
            push(newInteger(int(ceil(asFloat(x)))))

    builtin "clamp",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "force value within given range",
        args        = {
            "number" : {Integer, Floating, Rational},
            "range"  : {Range, Block}
        },
        attrs       = NoAttrs,
        returns     = {Integer, Floating, Rational},
        example     = """
            clamp 2 1..3                        ; 2
            clamp 0 1..3                        ; 1
            clamp 4 1..3                        ; 3
            clamp 4 3..1                        ; 3
            clamp 5 range.step: 2 0 5           ; 4
            
            clamp 4.5 0..6                      ; 4.5
            clamp to :rational [1 5] 0..1       ; 1/5
            
            clamp 4.5 [1 2.5]                   ; 2.5
            clamp 2 [5 10]                      ; 5
            clamp 2 [10 5]                      ; 5
            clamp 2.5 @[1 to :rational [5 2]]   ; 2.5
        """:
            #=======================================================
            case y.kind
            of Range:
                if not y.rng.numeric:
                    Error_IncompatibleValueType("clamp", valueKind(y), "numeric range")
                
                if (let minElem = y.rng.min()[1]; x.asFloat < float(minElem.i)): push(minElem)
                elif (let maxElem = y.rng.max()[1]; x.asFloat > float(maxElem.i)): push(maxElem)
                else: push(x)       
            of Block:
                y.requireBlockSize(2)
                let firstElem {.cursor} = y.a[0]
                let secondElem {.cursor} = y.a[1]
                firstElem.requireValue({Integer, Floating, Rational})
                secondElem.requireValue({Integer, Floating, Rational})
                
                let minElem = min([firstElem, secondElem])
                let maxElem = max([firstElem, secondElem])
                
                if x.asFloat < minElem.asFloat: push(minElem)
                elif x.asFloat > maxElem.asFloat: push(maxElem)
                else: push(x)  
                    
            else:
                discard
             
    builtin "conj",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the complex conjugate of given number",
        args        = {
            "number" : {Complex}
        },
        attrs       = NoAttrs,
        returns     = {Complex},
        example     = """
            b: to :complex [1 2]        ; b: 1.0+2.0i
            print conj b                ; 1.0-2.0i
        """:
            #=======================================================
            push(newComplex(conjugate(x.z)))

    builtin "cos",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the cosine of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print cos 0                 ; 1.0
            print cos 0.3               ; 0.955336489125606
            print cos 1.0               ; 0.5403023058681398
            ..........
            cos to :complex [1 1]
            ; => 0.8337300251311491-0.9888977057628651i
        """:
            #=======================================================
            processTrigonometric(cos)

    builtin "cosh",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cosine of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print cosh 0                ; 1.0
            print cosh 0.3              ; 1.04533851412886
            print cosh 1.0              ; 1.543080634815244
            ..........
            cosh to :complex [2 1]
            ; => 2.032723007019666+3.0518977991518i
        """:
            #=======================================================
            processTrigonometric(cosh)

    builtin "csec",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the cosecant of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print csec 0                ; inf
            print csec 0.3              ; 3.383863361824123
            print csec 1.0              ; 1.188395105778121
            ..........
            csec to :complex [1 1]  
            ; => 0.6215180171704283-0.3039310016284264i
        """:
            #=======================================================
            processTrigonometric(csc)

    builtin "csech",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cosecant of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print csech 0               ; inf
            print csech 0.3             ; 3.283853396698424
            print csech 1.0             ; 0.8509181282393216
            ..........
            csech to :complex [1 1]
            ; => 0.3039310016284264-0.6215180171704283i
        """:
            #=======================================================
            processTrigonometric(csch)

    builtin "ctan",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the cotangent of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print ctan 0                ; inf
            print ctan 0.3              ; 3.232728143765828
            print ctan 1.0              ; 0.6420926159343308
            ..........
            ctan to :complex [1 1]
            ; => 0.2176215618544027-0.8680141428959249i
        """:
            #=======================================================
            processTrigonometric(cot)

    builtin "ctanh",
        alias       = unaliased,
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic cotangent of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print ctanh 0               ; inf
            print ctanh 0.3             ; 3.432738430321741
            print ctanh 1.0             ; 1.313035285499331
            ..........
            ctanh to :complex [1 1]
            ; => 0.8680141428959249-0.2176215618544027i
        """:
            #=======================================================
            processTrigonometric(coth)

    builtin "denominator",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get the denominator of given number",
        args        = {
            "number"    : {Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            num: to :rational 12.4      ; num: 62/5
            print denominator num
            ; => 5
            ..........
            print denominator 10
            ; => 1
        """:
            #=======================================================
            var rat: VRational

            if xKind==Rational:
                rat = x.rat
            elif xKind==Integer:
                rat = toRational(x.i)
            else:
                rat = toRational(x.f)

            if rat.rKind == NormalRational:
                push(newInteger(getDenominator(rat)))
            else:
                push(newInteger(getDenominator(rat, big=true)))

    builtin "digits",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "convert a number into an array of digits or an array of digits back into a number",
        args        = {
            "number" : {Integer, Block},
        },
        attrs       = {
            "base"  : ({Integer},"use given based (default: 10)")
        },
        returns     = {Block},
        example     = """
            digits 123
            ; => [1 2 3]

            digits [1 2 3]
            ; => 123
            
            digits 0
            ; => [0]

            digits neg 12345
            ; => [1 2 3 4 5]

            ; digits 1231231231231231231231231231023
            ; => [1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 0 2 3]
        """:
            #=======================================================
            var base = 10
            if checkAttr("base"):
                base = aBase.i

            if x.kind == Block:
                var digits = x.a
                var composedNumber = 0
                for digit in digits:
                    requireValue(digit, {Integer})
                    composedNumber = composedNumber * base + digit.i
                push newInteger(composedNumber)
            else:
                if x.iKind == NormalInteger:
                    push newBlock(getDigits(x.i, base).map((z)=>newInteger(z)))
                else:
                    when defined(WEB) or defined(GMP):
                        push newBlock(getDigits(x.bi, base).map((z)=>newInteger(z)))

    builtin "exp",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the exponential function for given value",
        args        = {
            "value" : {Integer,Floating,Complex,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print exp 1.0           ; 2.718281828459045
            print exp 0             ; 1.0
            print exp neg 1.0       ; 0.3678794411714423
            ..........
            exp to :complex @[pi 1]
            ; => 12.50296958887651+19.47222141884161i
        """:
            #=======================================================
            if xKind==Complex: push(newComplex(exp(x.z)))
            else: push(newFloating(exp(asFloat(x))))

    builtin "factorial",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the factorial of given value",
        args        = {
            "value" : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            factorial 1         ; => 1
            factorial 5         ; => 120
            factorial 20        ; => 2432902008176640000
        """:
            #=======================================================
            if unlikely(x.iKind == BigInteger):
                Error_InvalidOperation("factorial", valueKind(x, withBigInfo=true), "")
            else:
                push(factorial(x.i))

    builtin "factors",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get list of factors for given integer",
        args        = {
            "number"    : {Integer}
        },
        attrs       = {
            "prime" : ({Logical},"prime factorization")
        },
        returns     = {Block},
        example     = """
            factors 16                                  ; => [1 2 4 8 16]
            ..........
            factors.prime 48                            ; => [2 2 2 2 3]
            unique factors.prime 48                     ; => [2 3]
            
            factors.prime 18446744073709551615123120
            ; => [2 2 2 2 3 5 61 141529 26970107 330103811]
        """:
            #=======================================================
            var prime = false
            if (hadAttr("prime")): prime = true

            if x.iKind==NormalInteger:
                if prime:
                    push(newBlock(primeFactorization(x.i).map((x)=>newInteger(x))))
                else:
                    push(newBlock(factors(x.i).map((x)=>newInteger(x))))
            else:
                when defined(WEB) or defined(GMP):
                    # TODO(Numbers\factors) `.prime` not working for Web builds
                    # labels: web,enhancement
                    if prime:
                        when not defined(WEB):
                            push(newBlock(primeFactorization(x.bi).map((x)=>newInteger(x))))
                        else:
                            discard
                    else:
                        push(newBlock(factors(x.bi).map((x)=>newInteger(x))))

    builtin "floor",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the largest integer not greater than given value",
        args        = {
            "value" : {Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print floor 2.1                     ; 2
            print floor 2.9                     ; 2
            print floor neg 3.5                 ; -4
            print floor 4                       ; 4
            print floor to :rational @[neg 7 2] ; -4
        """:
            #=======================================================
            push(newInteger(int(floor(asFloat(x)))))

    when not defined(WEB):
        builtin "gamma",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "calculate the gamma function for given value",
            args        = {
                "value" : {Integer,Floating,Rational}
            },
            attrs       = NoAttrs,
            returns     = {Floating},
            example     = """
            print gamma 3.0         ; 2.0
            print gamma 10.0        ; 362880.0
            print gamma 15          ; 87178291199.99985
            """:
                #=======================================================
                push(newFloating(gamma(asFloat(x))))

    builtin "gcd",
        alias       = unaliased, 
        op          = opNop,
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
            #=======================================================
            var current = x.a[0]
            requireValue(current, {Integer})

            var i = 1
            # TODO(Numbers\gcd) not working for Web builds
            # labels: web,enhancement
            while i<x.a.len:
                let elem {.cursor.} = x.a[i]
                requireValue(elem, {Integer})

                if current.iKind==NormalInteger:
                    if elem.iKind==BigInteger:
                        when defined(GMP):
                            current = newInteger(gcd(current.i, elem.bi))
                    else:
                        current = newInteger(gcd(current.i, elem.i))
                else:
                    when defined(GMP):
                        if elem.iKind==BigInteger:
                            current = newInteger(gcd(current.bi, elem.bi))
                        else:
                            current = newInteger(gcd(current.bi, elem.i))
                inc(i)

            push(current)

    builtin "hypot",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the hypotenuse of a right-angle triangle with given base and height",
        args        = {
            "base"  : {Integer,Floating,Rational},
            "height": {Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print hypot 3 4
            ; 5.0

            print hypot 4.0 5.0
            ; 6.403124237432849
        """:
            #=======================================================
            push(newFloating(hypot(asFloat(x), asFloat(y))))

    builtin "lcm",
        alias       = unaliased,
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "calculate least common multiplier for given collection of integers",
        args        = {
            "numbers"   : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            print lcm [48 60 120]         ; 240
        """:
            #=======================================================
            var current = x.a[0]
            requireValue(current, {Integer})

            var i = 1
            # TODO(Numbers\lcm) not working for Web builds
            # labels: web,enhancement
            while i<x.a.len:
                let elem {.cursor.} = x.a[i]
                requireValue(elem, {Integer})

                if current.iKind==NormalInteger:
                    if elem.iKind==BigInteger:
                        when defined(GMP):
                            current = newInteger(lcm(current.i, elem.bi))
                    else:
                        current = newInteger(lcm(current.i, elem.i))
                else:
                    when defined(GMP):
                        if elem.iKind==BigInteger:
                            current = newInteger(lcm(current.bi, elem.bi))
                        else:
                            current = newInteger(lcm(current.bi, elem.i))
                inc(i)

            push(current)

    builtin "ln",
        alias       = unaliased, 
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "calculate the natural logarithm of given value",
        args        = {
            "value" : {Integer,Floating,Complex,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print ln 1.0                ; 0.0
            print ln 0                  ; -inf
            print ln neg 7.0            ; nan
            ..........
            ln to :complex @[pi 1]
            ; => 1.19298515341341+0.308169071115985i
        """:
            #=======================================================
            if xKind==Complex: push(newComplex(ln(x.z)))
            else: push(newFloating(ln(asFloat(x))))

    builtin "log",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the logarithm of value using given base",
        args        = {
            "value" : {Integer,Floating,Rational},
            "base"  : {Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print log 9 3           ; 2.0
            print log 32.0 2.0      ; 5.0
            print log 0.0 2         ; -inf
            print log 100.0 10.0    ; 2.0
        """:
            #=======================================================
            push(newFloating(log(asFloat(x),asFloat(y))))

    builtin "numerator",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get the numerator of given number",
        args        = {
            "number"    : {Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            num: to :rational 12.4      ; num: 62/5
            print numerator num
            ; => 62
            ..........
            print numerator 10
            ; => 10
        """:
            #=======================================================
            var rat: VRational

            if xKind==Rational:
                rat = x.rat
            elif xKind==Integer:
                rat = toRational(x.i)
            else:
                rat = toRational(x.f)

            if rat.rKind == NormalRational:
                push(newInteger(getNumerator(rat)))
            else:
                push(newInteger(getNumerator(rat, big=true)))

    when defined(GMP):
        # TODO(Numbers\powmod) not working for Web builds
        # labels: web,enhancement
        builtin "powmod",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "modular exponentation: calculate the result of (base^exponent) % divider",
            args        = {
                "base"      : {Integer},
                "exponent"  : {Integer},
                "divider"   : {Integer}
            },
            attrs       = NoAttrs,
            returns     = {Integer,Null},
            example     = """
                powmod 1 10 3   ; => 1
                powmod 3 2 6    ; => 3
                powmod 5 5 15   ; => 5
                powmod 2 3 5    ; => 3
                powmod 2 4 5    ; => 1

                print (powmod 2 168277 673109) = (2 ^ 168277) % 673109
                ; true

            """:
                #=======================================================
                push(powmod(x, y, z))
        
    builtin "product",
        alias       = product, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the product of all values in given list",
        args        = {
            "collection"    : {Block,Range}
        },
        attrs       = {
            "cartesian"  : ({Logical},"return the cartesian product of given sublists")
        },
        returns     = {Integer,Floating,Rational},
        example     = """
            print product [3 4]       ; 12
            print product [1 2 4 6]   ; 48
            print product []          ; 1
            ..........
            print product 1..10       ; 3628800
            ..........
            product.cartesian [[A B C][D E]]
            ; => [[A D] [A E] [B D] [B E] [C D] [C E]]
        """:
            #=======================================================
            if (hadAttr("cartesian")):
                let blk = x.a.map((z)=>z.a)
                push(newBlock(cartesianProduct(blk).map((z) => newBlock(z))))
            else:
                var product = I1.copyValue
                if xKind==Range:
                    for item in items(x.rng):
                        product *= item
                    push(product)
                else:
                    var i = 0
                    while i<x.a.len:
                        product *= x.a[i]
                        i += 1

                    push(product)

    builtin "random",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get a random integer between given limits",
        args        = {
            "lowerLimit"    : {Integer, Floating, Rational},
            "upperLimit"    : {Integer, Floating, Rational}
        },
        attrs       = NoAttrs,
        returns     = {Integer, Floating},
        example     = """
            rnd: random 0 60          ; rnd: (a random number between 0 and 60)
        """:
            #=======================================================
            if xKind==Integer and yKind==Integer:
                push(newInteger(rand(x.i..y.i)))
            else:
                push(newFloating(rand(asFloat(x)..asFloat(y))))

    builtin "reciprocal",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the reciprocal of given number",
        args        = {
            "value" : {Integer,Floating,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Rational},
        example     = """
            r: to :rational [3 2]

            print reciprocal r
            ; 2/3
            ..........
            reciprocal 3        ; => 1/3
            reciprocal 3.2      ; => 5/16
        """:
            #=======================================================
            if xKind==Integer:
                push(newRational(reciprocal(toRational(x.i))))
            elif xKind==Floating:
                push(newRational(reciprocal(toRational(x.f))))
            else:
                push(newRational(reciprocal(x.rat)))

    builtin "round",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "round given value",
        args        = {
            "value" : {Integer,Floating,Rational}
        },
        attrs       = {
            "to"    : ({Integer},"round to given decimal places")
        },
        returns     = {Floating},
        example     = """
            print round 2.1                     ; 2.0
            print round 2.9                     ; 3.0
            print round 6                       ; 6.0

            print round to :rational [29 10]    ; 3.0
            print round to :rational [21 10]    ; 2.0
            print round to :rational [5 2]      ; 3.0

            print round pi          ; 3.0
            ..........
            print round.to:5 pi     ; 3.14159
            print round.to:2 pi     ; 3.14
        """:
            #=======================================================
            var places = 0
            if checkAttr("to"):
                places = aTo.i
                
            push(newFloating(round(asFloat(x), places)))

    builtin "sec",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the secant of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print sec 0                 ; 1.0
            print sec 0.3               ; 1.046751601538086
            print sec 1.0               ; 1.850815717680925
            ..........
            sec to :complex [1 1]
            ; => 0.4983370305551868+0.591083841721045i
        """:
            #=======================================================
            processTrigonometric(sec)

    builtin "sech",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic secant of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print sech 0                ; 1.0
            print sech 0.3              ; 0.9566279119002483
            print sech 1.0              ; 0.6480542736638855
            ..........
            sech to :complex [1 1]
            ; => 0.4983370305551868-0.5910838417210451i
        """:
            #=======================================================
            processTrigonometric(sech)

    builtin "sin",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the sine of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print sin 0                 ; 0.0
            print sin 0.3               ; 0.2955202066613395
            print sin 1.0               ; 0.8414709848078965
            ..........
            sin to :complex [1 1]
            ; => 0.4983370305551868-0.5910838417210451i
        """:
            #=======================================================
            processTrigonometric(sin)

    builtin "sinh",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic sine of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print sinh 0                ; 0.0
            print sinh 0.3              ; 0.3045202934471426
            print sinh 1.0              ; 1.175201193643801
            ..........
            sinh to :complex [1 1]
            ; => 0.6349639147847361+1.298457581415977i
        """:
            #=======================================================
            processTrigonometric(sinh)

    builtin "sqrt",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get square root of given value",
        args        = {
            "value" : {Integer,Floating,Complex,Rational}
        },
        attrs       = {
            "integer"   : ({Logical},"get the integer square root")
        },
        returns     = {Floating},
        example     = """
            print sqrt 4                ; 2.0
            print sqrt 16.0             ; 4.0
            print sqrt 1.45             ; 1.20415945787923
            ..........
            sqrt to :complex @[pi 1]
            ; => 1.794226987182141+0.2786715413222365i
        """:
            #=======================================================
            if (hadAttr("integer")):
                when defined(WEB) or defined(GMP):
                    if x.iKind == NormalInteger:
                        push(newInteger(isqrt(x.i)))
                    else:
                        push(newInteger(isqrt(x.bi)))
                else:
                    push(newInteger(isqrt(x.i)))
            elif xKind==Complex: push(newComplex(sqrt(x.z)))
            else: push(newFloating(sqrt(asFloat(x))))

    builtin "sum",
        alias       = summation, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the sum of all values in given list",
        args        = {
            "collection"    : {Block,Range}
        },
        attrs       = NoAttrs,
        returns     = {Integer,Floating,Rational},
        example     = """
            print sum [3 4]           ; 7
            print sum [1 2 4 6]       ; 13
            ..........
            print sum 1..10           ; 55
        """:
            #=======================================================
            var sum = I0.copyValue
            if xKind==Range:
                for item in items(x.rng):
                    sum += item
            else:
                var i = 0
                while i<x.a.len:
                    sum += x.a[i]
                    i += 1

            push(sum)

    builtin "tan",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the tangent of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print tan 0                 ; 0.0
            print tan 0.3               ; 0.3093362496096232
            print tan 1.0               ; 1.557407724654902
            ..........
            tan to :complex [1 1]
            ; => 0.2717525853195119+1.083923327338695i
        """:
            #=======================================================
            processTrigonometric(tan)

    builtin "tanh",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the hyperbolic tangent of given angle",
        args        = {
            "angle" : {Integer,Floating,Complex,Rational,Quantity}
        },
        attrs       = NoAttrs,
        returns     = {Floating,Complex},
        example     = """
            print tanh 0            ; 0.0
            print tanh 0.3          ; 0.2913126124515909
            print tanh 1.0          ; 0.7615941559557649
            ..........
            tanh to :complex [1 1]
            ; => 1.083923327338695+0.2717525853195117i
        """:
            #=======================================================
            processTrigonometric(tanh)
            
    #----------------------------
    # Predicates
    #----------------------------

    builtin "even?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given number is even",
        args        = {
            "number"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            even? 4           ; => true
            even? 3           ; => false
            ..........
            print select 1..10 => even?       ; 2 4 6 8 10
        """:
            #=======================================================
            push(newLogical(x % I2 == I0))

    builtin "infinite?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check whether given value is an infinite one",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            infinite? 4             ; false
            infinite? infinite      ; true
            infinite? ∞             ; true
            ..........
            a: infinite
            infinite? a             ; true
            
            b: 0
            infinite? b             ; false
        """:
            #=======================================================
            if xKind == Floating and (x.f == Inf or x.f == NegInf):
                push(VTRUE)
            else:
                push(VFALSE)

    builtin "negative?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given number is negative",
        args        = {
            "number"    : {Integer,Floating,Complex,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            negative? 5       ; => false
            negative? 6-7     ; => true 
        """:
            #=======================================================
            if xKind==Integer:
                if x.iKind==BigInteger:
                    when defined(WEB):
                        push(newLogical(x.bi < big(0)))
                    elif defined(GMP):
                        push(newLogical(negative(x.bi)))
                else:
                    push(newLogical(x < I0))
            elif xKind==Floating:
                push(newLogical(x.f < 0.0))
            elif xKind==Rational:
                push(newLogical(isNegative(x.rat)))
            elif xKind==Complex:
                push(newLogical(x.z.re < 0.0 or (x.z.re == 0.0 and x.z.im < 0.0)))

    builtin "odd?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given number is odd",
        args        = {
            "number"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            odd? 4            ; => false
            odd? 3            ; => true
            ..........
            print select 1..10 => odd?       ; 1 3 5 7 9
        """:
            #=======================================================
            push(newLogical(x % I2 == I1))

    builtin "positive?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given number is positive",
        args        = {
            "number"    : {Integer,Floating,Complex,Rational}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            positive? 5       ; => true
            positive? 6-7     ; => false
        """:
            #=======================================================
            if xKind==Integer:
                if x.iKind==BigInteger:
                    when defined(WEB):
                        push(newLogical(x.bi > big(0)))
                    elif defined(GMP):
                        push(newLogical(positive(x.bi)))
                else:
                    push(newLogical(x > I0))
            elif xKind==Floating:
                push(newLogical(x.f > 0.0))
            elif xKind==Rational:
                push(newLogical(isPositive(x.rat)))
            elif xKind==Complex:
                push(newLogical(x.z.re > 0.0 or (x.z.re == 0.0 and x.z.im > 0.0)))

    builtin "prime?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given integer is prime",
        args        = {
            "number"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            prime? 2          ; => true
            prime? 6          ; => false
            prime? 11         ; => true
            ..........
            ; let's check the 14th Mersenne:
            ; 53113799281676709868958820655246862732959311772703192319944413
            ; 82004035598608522427391625022652292856688893294862465010153465
            ; 79337652707239409519978766587351943831270835393219031728127
            
            prime? (2^607)-1  ; => true
        """:
            #=======================================================
            if x.iKind==NormalInteger:
                push(newLogical(isPrime(x.i.uint64)))
            else:
                # TODO(Numbers\prime?) not working for Web builds
                # labels: web,enhancement
                when defined(GMP):
                    push(newLogical(probablyPrime(x.bi,25)>0))

    #----------------------------
    # Constants
    #----------------------------

    constant "epsilon",
        alias       = unaliased,
        description = "the constant e, Euler's number":
            newFloating(E)

    constant "infinite",
        alias       = infinite,
        description = "the IEEE floating point value of positive infinity":
            newFloating(Inf)

    constant "pi",
        alias       = unaliased,
        description = "the number pi, mathematical constant":
            newFloating(PI)

    constant "tau",
        alias       = unaliased,
        description = "the number tau, mathematical constant":
            newFloating(TAU)
