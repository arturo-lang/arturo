######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Statistics.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import sequtils, stats, sugar

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Numbers"

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

            push(res)

    builtin "deviation",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get population standard deviation of given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "sample"    : ({Boolean},"calculate the sample standard deviation")
        },
        returns     = {Floating},
        # TODO(Statistics\deviation) add documentation example
        #  labels: documentation, library, easy
        example     = """
        """:
            ##########################################################
            if (popAttr("sample") != VNULL):
                push newFloating(standardDeviationS(x.a.map((z)=>asFloat(z))))
            else:
                push newFloating(standardDeviation(x.a.map((z)=>asFloat(z))))

    builtin "kurtosis",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get population kurtosis of given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "sample"    : ({Boolean},"calculate the sample kurtosis")
        },
        returns     = {Floating},
        # TODO(Statistics\kurtosis) add documentation example
        #  labels: documentation, library, easy
        example     = """
        """:
            ##########################################################
            if (popAttr("sample") != VNULL):
                push newFloating(kurtosisS(x.a.map((z)=>asFloat(z))))
            else:
                push newFloating(kurtosis(x.a.map((z)=>asFloat(z))))

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
                push(VNULL)
            else:
                let first = x.a[(x.a.len-1) div 2]
                let second = x.a[((x.a.len-1) div 2)+1]

                if x.a.len mod 2 == 1:
                    push(first) 
                else:
                    push((first + second)//I2)

    builtin "skewness",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get population skewness of given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "sample"    : ({Boolean},"calculate the sample skewness")
        },
        returns     = {Floating},
        # TODO(Statistics\skewness) add documentation example
        #  labels: documentation, library, easy
        example     = """
        """:
            ##########################################################
            if (popAttr("sample") != VNULL):
                push newFloating(skewnessS(x.a.map((z)=>asFloat(z))))
            else:
                push newFloating(skewness(x.a.map((z)=>asFloat(z))))
    
    builtin "variance",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get population variance of given collection of numbers",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "sample"    : ({Boolean},"calculate the sample variance")
        },
        returns     = {Floating},
        # TODO(Statistics\variance) add documentation example
        #  labels: documentation, library, easy
        example     = """
        """:
            ##########################################################
            if (popAttr("sample") != VNULL):
                push newFloating(varianceS(x.a.map((z)=>asFloat(z))))
            else:
                push newFloating(variance(x.a.map((z)=>asFloat(z))))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)