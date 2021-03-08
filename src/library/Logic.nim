######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Logic.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/[common, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Logic"

    builtin "all?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if all values in given block are true",
        args        = {
            "conditions"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            if all? @[2>1 "DONE"=upper "done" true] 
                -> print "yes, all are true"
            ; yes, all are true

            print all? @[true false true true]
            ; false
        """:
            ##########################################################
            # check if empty
            if x.a.len==0: 
                stack.push(newBoolean(false))
                return

            var allOK = true

            for item in x.a:
                if item!=VTRUE:
                    allOK = false
                    stack.push(newBoolean(false))
                    break

            if allOK:
                stack.push(newBoolean(true))

    builtin "and?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical AND for the given values",
        args        = {
            "valueA": {Boolean},
            "valueB": {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            x: 2
            y: 5
            
            if and? x=2 y>5 [
                print "yep, that's correct!"]
            ]
            
            ; yep, that's correct!
        """:
            ##########################################################
            stack.push(newBoolean(x.b and y.b))

    builtin "any?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if any of the values in given block is true",
        args        = {
            "conditions"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            if any? @[false 3=4 2>1] 
                -> print "yes, one (or more) of the values is true"
            ; yes, one (or more) of the values is true

            print any? @[false false false]
            ; false
        """:
            ##########################################################
            # check if empty
            if x.a.len==0: 
                stack.push(newBoolean(false))
                return
            
            var anyOK = false
            for item in x.a:
                if item==VTRUE:
                    anyOK = true
                    stack.push(newBoolean(true))
                    break
                
            if not anyOK:
                stack.push(newBoolean(false))

    constant "false",
        alias       = unaliased,
        description = "the FALSE/0 boolean constant":
            VFALSE

    builtin "false?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "returns true if given value is false; otherwise, it returns false",
        args        = {
            "value" : {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(not x.b))

    builtin "nand?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical NAND for the given values",
        args        = {
            "valueA": {Boolean},
            "valueB": {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            x: 2
            y: 3
            
            if? nand? x=2 y=3 [
                print "yep, that's correct!"]
            ]
            else [
                print "nope, that's not correct"
            ]
            
            ; nope, that's not correct
        """:
            ##########################################################
            stack.push(newBoolean(not (x.b and y.b)))

    builtin "nor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical NAND for the given values",
        args        = {
            "valueA": {Boolean},
            "valueB": {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            x: 2
            y: 3
            
            if? nor? x>2 y=3 [
                print "yep, that's correct!"]
            ]
            else [
                print "nope, that's not correct"
            ]
            
            ; nope, that's not correct
        """:
            ##########################################################
            stack.push(newBoolean(not (x.b or y.b)))

    builtin "not?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical complement of the given value",
        args        = {
            "value" : {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            ready: false
            if not? ready [
                print "we're still not ready!"
            ]
            
            ; we're still not ready!
        """:
            ##########################################################
            stack.push(newBoolean(not x.b))

    builtin "or?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical OR for the given values",
        args        = {
            "valueA": {Boolean},
            "valueB": {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            x: 2
            y: 4
            
            if or? x=2 y>5 [
                print "yep, that's correct!"]
            ]
            
            ; yep, that's correct!
        """:
            ##########################################################
            stack.push(newBoolean(x.b or y.b))

    constant "true",
        alias       = unaliased,
        description = "the TRUE/1 boolean constant":
            VTRUE

    builtin "true?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "returns true if given value is true; otherwise, it returns false",
        args        = {
            "value" : {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(x)

    builtin "xnor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical XNOR for the given values",
        args        = {
            "valueA": {Boolean},
            "valueB": {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            x: 2
            y: 3
            
            if? xnor? x=2 y=3 [
                print "yep, that's correct!"]
            ]
            else [
                print "nope, that's not correct"
            ]
            
            ; yep, that's not correct
        """:
            ##########################################################
            stack.push(newBoolean(not (x.b xor y.b)))

    builtin "xnor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical XNOR for the given values",
        args        = {
            "valueA": {Boolean},
            "valueB": {Boolean}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            x: 2
            y: 3
            
            if? xor? x=2 y=3 [
                print "yep, that's correct!"]
            ]
            else [
                print "nope, that's not correct"
            ]
            
            ; nope, that's not correct
        """:
            ##########################################################
            stack.push(newBoolean(x.b xor y.b))
            
#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)