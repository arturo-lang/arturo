#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Statistics.nim
#=======================================================

## The main Statistics module
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, stats, sugar

import helpers/ranges, helpers/statistics

import vm/lib

import vm/values/custom/[vrange]

#=======================================
# Definitions
#=======================================

# TODO(Statistics) more potential built-in function candidates?
#  labels: library, enhancement, open discussion

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    builtin "average",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get average from given collection of numbers",
        args        = {
            "collection"    : {Block,Range}
        },
        attrs       = NoAttrs,
        returns     = {Floating},
        example     = """
            print average [2 4 5 6 7 2 3]
            ; 4.142857142857143
        """:
            #=======================================================
            dispatch:
                Block(items):
                    var res = F0.copyValue
                    for num in items: res += num
                    res //= newFloating(items.len)
                    push(res)
                Range(rng):
                    var res = F0.copyValue
                    for item in items(rng): res += item
                    res //= newFloating(rng.len)
                    push(res)

    builtin "deviation",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get population standard deviation of given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "sample"    : ({Logical},"calculate the sample standard deviation")
        },
        returns     = {Floating},
        example     = """
            arr:  [1 2 3 4]
            arr2: [3 120 4 7 87 2 6 34]

            print deviation arr         ; 1.118033988749895
            print deviation arr2        ; 42.70959347734417

            deviation.sample arr        ; => 1.290994448735806
            deviation.sample arr2       ; => 45.65847597731914
        """:
            #=======================================================
            dispatch:
                Block(a):
                    on sample: push newFloating(standardDeviationS(a.map((z)=>(requireValue(z,{Integer,Floating}); asFloat(z)))))
                    _:         push newFloating(standardDeviation(a.map((z)=>(requireValue(z,{Integer,Floating}); asFloat(z)))))

    builtin "kurtosis",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get population kurtosis of given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "sample"    : ({Logical},"calculate the sample kurtosis")
        },
        returns     = {Floating},
        example     = """
            arr:  [1 2 3 4]
            arr2: [3 120 4 7 87 2 6 34]

            print kurtosis arr          ; -1.36
            print kurtosis arr2         ; -0.3863717894076322

            kurtosis.sample arr         ; => -1.200000000000001
            kurtosis.sample arr2        ; => 0.5886192422439724
        """:
            #=======================================================
            dispatch:
                Block(a):
                    on sample: push newFloating(kurtosisS(a.map((z)=>(requireValue(z,{Integer,Floating}); asFloat(z)))))
                    _:         push newFloating(kurtosis(a.map((z)=>(requireValue(z,{Integer,Floating}); asFloat(z)))))

    builtin "median",
        alias       = unaliased,
        op          = opNop,
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
            #=======================================================
            dispatch:
                Block(a):
                    if a.len == 0:
                        push(VNULL)
                    elif a.len < 6 and a.len mod 2 == 0:
                        let sorted = a.sorted()
                        let secondPos = sorted.len div 2
                        let first = sorted[secondPos - 1]
                        let second = sorted[secondPos]
                        push ((first + second)//I2)
                    else:
                        let secondPos = a.len div 2
                        if a.len mod 2 == 1:
                            push a.quickSelect(secondPos)
                        else:
                            let first = a.quickSelect(secondPos - 1)
                            let second = a.quickSelect(secondPos)
                            push ((first + second)//I2)

    builtin "skewness",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get population skewness of given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "sample"    : ({Logical},"calculate the sample skewness")
        },
        returns     = {Floating},
        example     = """
            arr:  [1 2 3 4]
            arr2: [3 120 4 7 87 2 6 34]

            print skewness arr          ; 0.0
            print skewness arr2         ; 1.127950016816592

            skewness.sample arr         ; => 0.0
            skewness.sample arr2        ; => 1.40680083744453
        """:
            #=======================================================
            dispatch:
                Block(a):
                    on sample: push newFloating(skewnessS(a.map((z)=>(requireValue(z,{Integer,Floating}); asFloat(z)))))
                    _:         push newFloating(skewness(a.map((z)=>(requireValue(z,{Integer,Floating}); asFloat(z)))))

    builtin "variance",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get population variance of given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "sample"    : ({Logical},"calculate the sample variance")
        },
        returns     = {Floating},
        example     = """
            arr:  [1 2 3 4]
            arr2: [3 120 4 7 87 2 6 34]

            print variance arr          ; 1.25
            print variance arr2         ; 1824.109375

            variance.sample arr         ; => 1.666666666666667
            variance.sample arr2        ; => 2084.696428571428
        """:
            #=======================================================
            dispatch:
                Block(a):
                    on sample: push newFloating(varianceS(a.map((z)=>(requireValue(z,{Integer,Floating}); asFloat(z)))))
                    _:         push newFloating(variance(a.map((z)=>(requireValue(z,{Integer,Floating}); asFloat(z)))))
