######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
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
        returns     = {Logical},
        example     = """
        if all? @[2>1 "DONE"=upper "done" true] 
            -> print "yes, all are true"
        ; yes, all are true
        ..........
        print all? @[true false true true]
        ; false
        """:
            ##########################################################
            let blk = cleanBlock(x.a)
            # check if empty
            if blk.len==0: 
                push(newLogical(false))
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
                    push(newLogical(false))
                    break

            if allOK:
                push(newLogical(true))

    builtin "and?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical AND for the given values",
        args        = {
            "valueA": {Logical,Block},
            "valueB": {Logical,Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
        x: 2
        y: 5
        
        if and? x=2 y>5 [
            print "yep, that's correct!"]
        ]
        
        ; yep, that's correct!
        """:
            ##########################################################
            if x.kind==Logical and y.kind==Logical:
                push(newLogical(And(x.b,y.b)))
            else:
                if x.kind==Block:
                    if y.kind==Block:
                        # block block
                        discard execBlock(x)
                        if Not(pop().b)==True:
                            push(newLogical(false))
                            return

                        discard execBlock(y)
                        push(newLogical(pop().b))
                    else:
                        # block logical
                        discard execBlock(x)
                        push(newLogical(And(pop().b,y.b)))
                else:
                    # logical block
                    if Not(x.b)==True:
                        push(newLogical(false))
                        return

                    discard execBlock(y)
                    push(newLogical(pop().b))


    builtin "any?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if any of the values in given block is true",
        args        = {
            "conditions"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
        if any? @[false 3=4 2>1] 
            -> print "yes, one (or more) of the values is true"
        ; yes, one (or more) of the values is true
        ..........
        print any? @[false false false]
        ; false
        """:
            ##########################################################
            let blk = cleanBlock(x.a)
            # check if empty
            if blk.len==0: 
                push(newLogical(false))
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
                    push(newLogical(true))
                    break
                
            if not anyOK:
                push(newLogical(false))

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
        returns     = {Logical},
        example     = """
        print false? 1 = 2          ; true
        print false? 1 <> 2         ; false
        print false? odd? 2         ; true

        print false? [1 2 3]        ; false
        """:
            ##########################################################
            if x.kind != Logical: push(newLogical(false))
            else: push(newLogical(Not(x.b)))

    constant "maybe",
        alias       = unaliased,
        description = "the MAYBE logical constant":
            VMAYBE

    builtin "nand?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical NAND for the given values",
        args        = {
            "valueA": {Logical,Block},
            "valueB": {Logical,Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
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
            if x.kind==Logical and y.kind==Logical:
                push(newLogical(Not(And(x.b, y.b))))
            else:
                if x.kind==Block:
                    if y.kind==Block:
                        # block block
                        discard execBlock(x)
                        if Not(pop().b)==True:
                            push(newLogical(true))
                            return

                        discard execBlock(y)
                        push(newLogical(Not(pop().b)))
                    else:
                        # block logical
                        discard execBlock(x)
                        push(newLogical(Not(And(pop().b, y.b))))
                else:
                    # logical block
                    if Not(x.b)==True:
                        push(newLogical(true))
                        return

                    discard execBlock(y)
                    push(newLogical(Not(pop().b)))

    builtin "nor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical NOR for the given values",
        args        = {
            "valueA": {Logical,Block},
            "valueB": {Logical,Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
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
            if x.kind==Logical and y.kind==Logical:
                push(newLogical(Not(Or(x.b, y.b))))
            else:
                if x.kind==Block:
                    if y.kind==Block:
                        # block block
                        discard execBlock(x)
                        if pop().b==True:
                            push(newLogical(false))
                            return

                        discard execBlock(y)
                        push(newLogical(Not(pop().b)))
                    else:
                        # block logical
                        discard execBlock(x)
                        push(newLogical(Not(Or(pop().b, y.b))))
                else:
                    # logical block
                    if x.b==True:
                        push(newLogical(false))
                        return

                    discard execBlock(y)
                    push(newLogical(Not(pop().b)))

    builtin "not?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical complement of the given value",
        args        = {
            "value" : {Logical,Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
        ready: false
        if not? ready [
            print "we're still not ready!"
        ]
        
        ; we're still not ready!
        """:
            ##########################################################
            if x.kind==Logical:
                push(newLogical(Not(x.b)))
            else:
                discard execBlock(x)
                push(newLogical(Not(pop().b)))

    builtin "or?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical OR for the given values",
        args        = {
            "valueA": {Logical,Block},
            "valueB": {Logical,Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
        x: 2
        y: 4
        
        if or? x=2 y>5 [
            print "yep, that's correct!"]
        ]
        
        ; yep, that's correct!
        """:
            ##########################################################
            if x.kind==Logical and y.kind==Logical:
                push(newLogical(Or(x.b, y.b)))
            else:
                if x.kind==Block:
                    if y.kind==Block:
                        # block block
                        discard execBlock(x)
                        if pop().b==True:
                            push(newLogical(true))
                            return

                        discard execBlock(y)
                        push(newLogical(pop().b))
                    else:
                        # block logical
                        discard execBlock(x)
                        push(newLogical(Or(pop().b, y.b)))
                else:
                    # logical block
                    if x.b==True:
                        push(newLogical(true))
                        return

                    discard execBlock(y)
                    push(newLogical(pop().b))

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
        returns     = {Logical},
        example     = """
        print true? 1 = 2           ; false
        print true? 1 <> 2          ; true
        print true? even? 2         ; true

        print true? [1 2 3]         ; false
        """:
            ##########################################################
            if x.kind != Logical: push(newLogical(false))
            else: push(x)

    builtin "xnor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical XNOR for the given values",
        args        = {
            "valueA": {Logical,Block},
            "valueB": {Logical,Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
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
            var a: logical
            var b: logical
            if x.kind == Logical: 
                a = x.b
            else:
                discard execBlock(x)
                a = pop().b

            if y.kind == Logical: 
                b = y.b
            else:
                discard execBlock(y)
                b = pop().b

            push(newLogical(Not(Xor(a, b))))

    builtin "xor?",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "return the logical XOR for the given values",
        args        = {
            "valueA": {Logical,Block},
            "valueB": {Logical,Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
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
            var a: logical
            var b: logical
            if x.kind == Logical: 
                a = x.b
            else:
                discard execBlock(x)
                a = pop().b

            if y.kind == Logical: 
                b = y.b
            else:
                discard execBlock(y)
                b = pop().b

            push(newLogical(Xor(a, b)))
            
#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)