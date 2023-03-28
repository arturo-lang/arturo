#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Logic.nim
#=======================================================

## The main Logic module 
## (part of the standard library)

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

    builtin "all?",
        alias       = unaliased, 
        op          = opNop,
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
            #=======================================================
            # check if empty
            if x.a.len==0: 
                push(newLogical(false))
                return

            var allOK = true

            for item in x.a:
                var val {.cursor.}: Value
                if item.kind == Block: 
                    execUnscoped(item)
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
        alias       = logicaland, 
        op          = opAnd,
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
            #=======================================================
            if xKind==Logical and yKind==Logical:
                push(newLogical(And(x.b,y.b)))
            else:
                if xKind==Block:
                    if yKind==Block:
                        # block block
                        execUnscoped(x)
                        if isFalse(move stack.pop()):
                            push(newLogical(false))
                            return

                        execUnscoped(y)
                        push(newLogical(pop().b))
                    else:
                        # block logical
                        execUnscoped(x)
                        push(newLogical(And(pop().b,y.b)))
                else:
                    # logical block
                    if isFalse(x):
                        push(newLogical(false))
                        return

                    execUnscoped(y)
                    push(newLogical(pop().b))

    builtin "any?",
        alias       = unaliased, 
        op          = opNop,
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
            #=======================================================
            # check if empty
            if x.a.len==0: 
                push(newLogical(false))
                return
            
            var anyOK = false
            for item in x.a:
                var val: Value
                if item.kind == Block: 
                    execUnscoped(item)
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
        op          = opNop,
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
            #=======================================================
            if xKind != Logical: push(newLogical(false))
            else: push(newLogical(Not(x.b)))

    constant "maybe",
        alias       = unaliased,
        description = "the MAYBE logical constant":
            VMAYBE

    builtin "nand?",
        alias       = logicalnand, 
        op          = opNop,
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
            #=======================================================
            if xKind==Logical and yKind==Logical:
                push(newLogical(NAnd(x.b, y.b)))
            else:
                if xKind==Block:
                    if yKind==Block:
                        # block block
                        execUnscoped(x)
                        if isFalse(move stack.pop()):
                            push(newLogical(true))
                            return

                        execUnscoped(y)
                        push(newLogical(Not(pop().b)))
                    else:
                        # block logical
                        execUnscoped(x)
                        push(newLogical(Nand(pop().b, y.b)))
                else:
                    # logical block
                    if isFalse(x):
                        push(newLogical(true))
                        return

                    execUnscoped(y)
                    push(newLogical(Not(pop().b)))

    builtin "nor?",
        alias       = unaliased, 
        op          = opNop,
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
            #=======================================================
            if xKind==Logical and yKind==Logical:
                push(newLogical(Nor(x.b, y.b)))
            else:
                if xKind==Block:
                    if yKind==Block:
                        # block block
                        execUnscoped(x)
                        if isTrue(move stack.pop()):
                            push(newLogical(false))
                            return

                        execUnscoped(y)
                        push(newLogical(Not(pop().b)))
                    else:
                        # block logical
                        execUnscoped(x)
                        push(newLogical(Nor(pop().b, y.b)))
                else:
                    # logical block
                    if isTrue(x):
                        push(newLogical(false))
                        return

                    execUnscoped(y)
                    push(newLogical(Not(pop().b)))

    builtin "not?",
        alias       = logicalnot, 
        op          = opNot,
        rule        = PrefixPrecedence,
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
            #=======================================================
            if xKind==Logical:
                push(newLogical(Not(x.b)))
            else:
                execUnscoped(x)
                push(newLogical(Not(pop().b)))

    builtin "or?",
        alias       = logicalor, 
        op          = opOr,
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
            #=======================================================
            if xKind==Logical and yKind==Logical:
                push(newLogical(Or(x.b, y.b)))
            else:
                if xKind==Block:
                    if yKind==Block:
                        # block block
                        execUnscoped(x)
                        if isTrue(move stack.pop()):
                            push(newLogical(true))
                            return

                        execUnscoped(y)
                        push(newLogical(pop().b))
                    else:
                        # block logical
                        execUnscoped(x)
                        push(newLogical(Or(pop().b, y.b)))
                else:
                    # logical block
                    if isTrue(x):
                        push(newLogical(true))
                        return

                    execUnscoped(y)
                    push(newLogical(pop().b))

    constant "true",
        alias       = unaliased,
        description = "the TRUE logical constant":
            VTRUE

    builtin "true?",
        alias       = unaliased, 
        op          = opNop,
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
            #=======================================================
            if xKind != Logical: push(newLogical(false))
            else: push(x)

    builtin "xnor?",
        alias       = unaliased, 
        op          = opNop,
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
            #=======================================================
            var a: VLogical
            var b: VLogical
            if xKind == Logical: 
                a = x.b
            else:
                execUnscoped(x)
                a = pop().b

            if yKind == Logical: 
                b = y.b
            else:
                execUnscoped(y)
                b = pop().b

            push(newLogical(Xnor(a, b)))

    builtin "xor?",
        alias       = logicalxor, 
        op          = opNop,
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
            #=======================================================
            var a: VLogical
            var b: VLogical
            if xKind == Logical: 
                a = x.b
            else:
                execUnscoped(x)
                a = pop().b

            if yKind == Logical: 
                b = y.b
            else:
                execUnscoped(y)
                b = pop().b

            push(newLogical(Xor(a, b)))
            
#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)