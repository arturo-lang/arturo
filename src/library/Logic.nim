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

import vm/lib
import vm/[exec]

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
            ;;;;
            print all? @[true false true true]
            ; false
        """:
            ##########################################################
            let blk = cleanBlock(x.a)
            # check if empty
            if blk.len==0: 
                push(newBoolean(false))
                return

            var allOK = true

            for item in blk:
                var val: Value
                if item.kind == Block: 
                    discard execBlock(item)
                    val = pop()
                else:
                    val = item

                if val!=VTRUE:
                    allOK = false
                    push(newBoolean(false))
                    break

            if allOK:
                push(newBoolean(true))

    builtin "and?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical AND for the given values",
        args        = {
            "valueA": {Boolean,Block},
            "valueB": {Boolean,Block}
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
            if x.kind==Boolean and y.kind==Boolean:
                push(newBoolean(x.b and y.b))
            else:
                if x.kind==Block:
                    if y.kind==Block:
                        # block block
                        discard execBlock(x)
                        if not pop().b:
                            push(newBoolean(false))
                            return

                        discard execBlock(y)
                        push(newBoolean(pop().b))
                    else:
                        # block boolean
                        discard execBlock(x)
                        push(newBoolean(pop().b and y.b))
                else:
                    # boolean block
                    if not x.b:
                        push(newBoolean(false))
                        return

                    discard execBlock(y)
                    push(newBoolean(pop().b))


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
            ;;;;
            print any? @[false false false]
            ; false
        """:
            ##########################################################
            let blk = cleanBlock(x.a)
            # check if empty
            if blk.len==0: 
                push(newBoolean(false))
                return
            
            var anyOK = false
            for item in blk:
                var val: Value
                if item.kind == Block: 
                    discard execBlock(item)
                    val = pop()
                else:
                    val = item

                if val==VTRUE:
                    anyOK = true
                    push(newBoolean(true))
                    break
                
            if not anyOK:
                push(newBoolean(false))

    constant "false",
        alias       = unaliased,
        description = "the FALSE logical constant":
            VFALSE

    builtin "false?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "returns true if given value is false; otherwise, it returns false",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            print false? 1 = 2          ; true
            print false? 1 <> 2         ; false
            print false? odd? 2         ; true

            print false? [1 2 3]        ; false
        """:
            ##########################################################
            if x.kind != Boolean: push(newBoolean(false))
            else: push(newBoolean(not x.b))

    constant "maybe",
        alias       = unaliased,
        description = "the MAYBE logical constant":
            VMAYBE

    builtin "nand?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical NAND for the given values",
        args        = {
            "valueA": {Boolean,Block},
            "valueB": {Boolean,Block}
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
            if x.kind==Boolean and y.kind==Boolean:
                push(newBoolean(not (x.b and y.b)))
            else:
                if x.kind==Block:
                    if y.kind==Block:
                        # block block
                        discard execBlock(x)
                        if not pop().b:
                            push(newBoolean(true))
                            return

                        discard execBlock(y)
                        push(newBoolean(not pop().b))
                    else:
                        # block boolean
                        discard execBlock(x)
                        push(newBoolean(not (pop().b and y.b)))
                else:
                    # boolean block
                    if not x.b:
                        push(newBoolean(true))
                        return

                    discard execBlock(y)
                    push(newBoolean(not pop().b))

    builtin "nor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical NAND for the given values",
        args        = {
            "valueA": {Boolean,Block},
            "valueB": {Boolean,Block}
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
            if x.kind==Boolean and y.kind==Boolean:
                push(newBoolean(not(x.b or y.b)))
            else:
                if x.kind==Block:
                    if y.kind==Block:
                        # block block
                        discard execBlock(x)
                        if pop().b:
                            push(newBoolean(false))
                            return

                        discard execBlock(y)
                        push(newBoolean(not pop().b))
                    else:
                        # block boolean
                        discard execBlock(x)
                        push(newBoolean(not(pop().b or y.b)))
                else:
                    # boolean block
                    if x.b:
                        push(newBoolean(false))
                        return

                    discard execBlock(y)
                    push(newBoolean(not pop().b))

    builtin "not?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical complement of the given value",
        args        = {
            "value" : {Boolean,Block}
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
            if x.kind==Boolean:
                push(newBoolean(not x.b))
            else:
                discard execBlock(x)
                push(newBoolean(not pop().b))

    builtin "or?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical OR for the given values",
        args        = {
            "valueA": {Boolean,Block},
            "valueB": {Boolean,Block}
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
            if x.kind==Boolean and y.kind==Boolean:
                push(newBoolean(x.b or y.b))
            else:
                if x.kind==Block:
                    if y.kind==Block:
                        # block block
                        discard execBlock(x)
                        if pop().b:
                            push(newBoolean(true))
                            return

                        discard execBlock(y)
                        push(newBoolean(pop().b))
                    else:
                        # block boolean
                        discard execBlock(x)
                        push(newBoolean(pop().b or y.b))
                else:
                    # boolean block
                    if x.b:
                        push(newBoolean(true))
                        return

                    discard execBlock(y)
                    push(newBoolean(pop().b))

    constant "true",
        alias       = unaliased,
        description = "the TRUE logical constant":
            VTRUE

    builtin "true?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "returns true if given value is true; otherwise, it returns false",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            print true? 1 = 2           ; false
            print true? 1 <> 2          ; true
            print true? even? 2         ; true

            print true? [1 2 3]         ; false
        """:
            ##########################################################
            if x.kind != Boolean: push(newBoolean(false))
            else: push(x)

    builtin "xnor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical XNOR for the given values",
        args        = {
            "valueA": {Boolean,Block},
            "valueB": {Boolean,Block}
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
            var a: bool
            var b: bool
            if x.kind == Boolean: 
                a = x.b
            else:
                discard execBlock(x)
                a = pop().b

            if y.kind == Boolean: 
                b = y.b
            else:
                discard execBlock(y)
                b = pop().b

            push(newBoolean(not (a xor b)))

    builtin "xor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical XOR for the given values",
        args        = {
            "valueA": {Boolean,Block},
            "valueB": {Boolean,Block}
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
            var a: bool
            var b: bool
            if x.kind == Boolean: 
                a = x.b
            else:
                discard execBlock(x)
                a = pop().b

            if y.kind == Boolean: 
                b = y.b
            else:
                discard execBlock(y)
                b = pop().b

            push(newBoolean(a xor b))
            
#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)