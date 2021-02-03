######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Comparison.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/[common, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Comparison"

    builtin "equal?",
        alias       = equal, 
        rule        = InfixPrecedence,
        description = "check if valueA = valueB (equality)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            equal? 5 2            ; => false
            equal? 5 6-1          ; => true
            
            print 3=3             ; true
        """:
            ##########################################################
            stack.push(newBoolean(x == y))

    builtin "greater?",
        alias       = greaterthan, 
        rule        = InfixPrecedence,
        description = "check if valueA > valueB (greater than)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            greater? 5 2          ; => true
            greater? 5 6-1        ; => false
            
            print 3>2             ; true
        """:
            ##########################################################
            stack.push(newBoolean(x > y))

    builtin "greaterOrEqual?",
        alias       = greaterequal, 
        rule        = InfixPrecedence,
        description = "check if valueA >= valueB (greater than or equal)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            greaterOrEqual? 5 2   ; => true
            greaterOrEqual? 5 4-1 ; => false
            
            print 2>=2            ; true
        """:
            ##########################################################
            stack.push(newBoolean(x >= y))

    builtin "less?",
        alias       = lessthan, 
        rule        = InfixPrecedence,
        description = "check if valueA < valueB (less than)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            less? 5 2             ; => false
            less? 5 6+1           ; => true
            
            print 2<3             ; true
        """:
            ##########################################################
            stack.push(newBoolean(x < y))

    builtin "lessOrEqual?",
        alias       = equalless, 
        rule        = InfixPrecedence,
        description = "check if valueA =< valueB (less than or equal)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            lessOrEqual? 5 2      ; => false
            lessOrEqual? 5 6-1    ; => true
            
            print 2=<3            ; true
        """:
            ##########################################################
            stack.push(newBoolean(x <= y))
                
    builtin "notEqual?",
        alias       = lessgreater, 
        rule        = InfixPrecedence,
        description = "check if valueA <> valueB (not equal)",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            notEqual? 5 2         ; => true
            notEqual? 5 6-1       ; => false
            
            print 2<>3            ; true
        """:
            ##########################################################
            stack.push(newBoolean(x != y))
            
#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)