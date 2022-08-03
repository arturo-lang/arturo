######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Comparison.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Comparison"

    # TODO(Comparison) add built-in function for "approximately equal"
    #  This could serve in cases where we want to compare between weirdly-rounded floating-point numbers and integers, e.g.: 3.0000001 and 3.
    #  But: we'll obviously have to somehow "define" this... approximate equality.
    #  labels: library, enhancement, open discussion

    builtin "equal?",
        alias       = equal, 
        rule        = InfixPrecedence,
        description = "check if valueA = valueB (equality)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            equal? 5 2            ; => false
            equal? 5 6-1          ; => true
            
            print 3=3             ; true
        """:
            ##########################################################
            push(newLogical(x == y))

    builtin "greater?",
        alias       = greaterthan, 
        rule        = InfixPrecedence,
        description = "check if valueA > valueB (greater than)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            greater? 5 2          ; => true
            greater? 5 6-1        ; => false
            
            print 3>2             ; true
        """:
            ##########################################################
            push(newLogical(x > y))

    builtin "greaterOrEqual?",
        alias       = greaterequal, 
        rule        = InfixPrecedence,
        description = "check if valueA >= valueB (greater than or equal)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            greaterOrEqual? 5 2   ; => true
            greaterOrEqual? 5 4-1 ; => false
            
            print 2>=2            ; true
        """:
            ##########################################################
            push(newLogical(x >= y))

    builtin "less?",
        alias       = lessthan, 
        rule        = InfixPrecedence,
        description = "check if valueA < valueB (less than)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            less? 5 2             ; => false
            less? 5 6+1           ; => true
            
            print 2<3             ; true
        """:
            ##########################################################
            push(newLogical(x < y))

    builtin "lessOrEqual?",
        alias       = equalless, 
        rule        = InfixPrecedence,
        description = "check if valueA =< valueB (less than or equal)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            lessOrEqual? 5 2      ; => false
            lessOrEqual? 5 6-1    ; => true
            
            print 2=<3            ; true
        """:
            ##########################################################
            push(newLogical(x <= y))
                
    builtin "notEqual?",
        alias       = lessgreater, 
        rule        = InfixPrecedence,
        description = "check if valueA <> valueB (not equal)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            notEqual? 5 2         ; => true
            notEqual? 5 6-1       ; => false
            
            print 2<>3            ; true
        """:
            ##########################################################
            push(newLogical(x != y))

    builtin "same?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given values are exactly the same (identity)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            same? 1 2           ; => false
            same? 3 3           ; => true
            same? 3 3.0         ; => false
        """:
            ##########################################################
            push(newLogical(identical(x, y)))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)