#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: library/Comparison.nim
#=======================================================

## The main Comparison module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/lib

#=======================================
# Definitions
#=======================================

# TODO(Comparison) add built-in function for "approximately equal"
#  This could serve in cases where we want to compare between weirdly-rounded floating-point numbers and integers, e.g.: 3.0000001 and 3.
#  But: we'll obviously have to somehow "define" this... approximate equality.
#  labels: library, enhancement, open discussion

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    # TODO(Comparison\compare) verify it's working right
    #  The main problem seems to be this vague `else:`.
    #  In a few words: Even comparisons that are simply not possible will return 1 (!)
    #  see also: https://github.com/arturo-lang/arturo/pull/1139#issuecomment-1509404906
    #  labels: library, critical, bug
    builtin "compare",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "compare given values and return -1, 0, or 1 based on the result",
        args        = {
            "valueA": {Any},
            "valueB": {Any}
        },
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            compare 1 2           ; => -1
            compare 3 3           ; => 0
            compare 4 3           ; => 1
        """:
            #=======================================================
            if x < y:
                push(I1M)
            elif x == y:
                push(I0)
            else:
                push(I1)

    #----------------------------
    # Predicates
    #----------------------------

    # TODO(Comparison\between?): deprecate the support for some types
    # Right now this uses a generic algorithm and :any as entry, but does it even makes sense?
    #
    # ```art
    # between? #[user: "Rick"] #[user: "Rick"] #[user: "Rick"]
    # ``` 
    #
    # The above code returns true, but what is the sense of seeing if a dictionary is between other two.
    # I think this should be good to limit what types can be between other ones.
    # labels: library, open-discussion
    builtin "between?",
        alias       = thickarrowboth, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "check if given value is between the given values (inclusive)",
        args        = {
            "value"     : {Any},
            "rangeFrom" : {Any},
            "rangeTo"   : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            between? 1 2 3      ; => false
            between? 2 0 3      ; => true
            between? 3 2 3      ; => true
            between? 3 3 2      ; => true

            1 <=> 2 3           ; => false
            1 <=> 3 2           ; => false
            2 <=> 0 3           ; => true
            2 <=> 3 0           ; => true
            3 <=> 2 3           ; => true  
        """:
            #=======================================================
            template isBetween(target, lower, upper: untyped) =
                if (target == lower or target == upper) or (target > lower and target < upper):
                    push VTRUE
                else:
                    push VFALSE
        
            if y < z: x.isBetween(y, z)
            else: x.isBetween(z, y)

    builtin "equal?",
        alias       = equal, 
        op          = opEq,
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
            #=======================================================
            push(newLogical(x == y))

    builtin "greater?",
        alias       = greaterthan, 
        op          = opGt,
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
            #=======================================================
            push(newLogical(x > y))

    builtin "greaterOrEqual?",
        alias       = greaterequal, 
        op          = opGe,
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
            #=======================================================
            push(newLogical(x >= y))

    builtin "less?",
        alias       = lessthan, 
        op          = opLt,
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
            #=======================================================
            push(newLogical(x < y))

    builtin "lessOrEqual?",
        alias       = equalless, 
        op          = opLe,
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
            #=======================================================
            push(newLogical(x <= y))
                
    builtin "notEqual?",
        alias       = lessgreater, 
        op          = opNe,
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
            #=======================================================
            push(newLogical(x != y))

    builtin "same?",
        alias       = unaliased, 
        op          = opNop,
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
            #=======================================================
            push(newLogical(identical(x, y)))

