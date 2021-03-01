######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Sets.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import sequtils, std/sets

import vm/[common, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Sets"

    builtin "difference",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return the difference of given sets",
        args        = {
            "setA"  : {Block,Literal},
            "setB"  : {Block}
        },
        attrs       = {
            "symmetric" : ({Boolean},"get the symmetric difference")
        },
        returns     = {Block,Nothing},
        example     = """
            print difference [1 2 3 4] [3 4 5 6]
            ; 1 2

            a: [1 2 3 4]
            b: [3 4 5 6]
            difference 'a b
            ; a: [1 2]

            print difference.symmetric [1 2 3 4] [3 4 5 6]
            ; 1 2 5 6
        """:
            ##########################################################
            if (popAttr("symmetric")!=VNULL):
                if x.kind==Literal:
                    SetInPlace(newBlock(toSeq(symmetricDifference(toHashSet(InPlace.a), toHashSet(y.a)))))
                else:
                    stack.push(newBlock(toSeq(symmetricDifference(toHashSet(x.a), toHashSet(y.a)))))
            else:
                if x.kind==Literal:
                    SetInPlace(newBlock(toSeq(difference(toHashSet(InPlace.a), toHashSet(y.a)))))
                else:
                    stack.push(newBlock(toSeq(difference(toHashSet(x.a), toHashSet(y.a)))))

    builtin "intersection",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return the intersection of given sets",
        args        = {
            "setA"  : {Block,Literal},
            "setB"  : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            print intersection [1 2 3 4] [3 4 5 6]
            ; 3 4

            a: [1 2 3 4]
            b: [3 4 5 6]
            intersection 'a b
            ; a: [3 4]
        """:
            ##########################################################
            if x.kind==Literal:
                SetInPlace(newBlock(toSeq(intersection(toHashSet(InPlace.a), toHashSet(y.a)))))
            else:
                stack.push(newBlock(toSeq(intersection(toHashSet(x.a), toHashSet(y.a)))))

    builtin "subset?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given set is a subset of second set",
        args        = {
            "setA"  : {Block},
            "setB"  : {Block}
        },
        attrs       = {
            "proper": ({Boolean},"check if proper subset")
        },
        returns     = {Boolean},
        example     = """
            subset? [1 3] [1 2 3 4]
            ; => true

            subset?.proper [1 3] [1 2 3 4]
            ; => true

            subset? [1 3] [3 5 6]
            ; => false

            subset? [1 3] [1 3]
            ; => true

            subset?.proper [1 3] [1 3]
            ; => false
        """:
            ##########################################################
            if (popAttr("proper")!=VNULL):
                if x == y: 
                    stack.push(newBoolean(false))
                else:
                    var contains = true
                    for item in x.a:
                        if item notin y.a:
                            contains = false
                            break

                    stack.push(newBoolean(contains))
            else:
                if x == y:
                    stack.push(newBoolean(true))
                else:
                    var contains = true
                    for item in x.a:
                        if item notin y.a:
                            contains = false
                            break

                    stack.push(newBoolean(contains))

    builtin "superset?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given set is a superset of second set",
        args        = {
            "setA"  : {Block},
            "setB"  : {Block}
        },
        attrs       = {
            "proper": ({Boolean},"check if proper superset")
        },
        returns     = {Boolean},
        example     = """
            superset? [1 2 3 4] [1 3]
            ; => true

            superset?.proper [1 2 3 4] [1 3]
            ; => true

            superset? [3 5 6] [1 3]
            ; => false

            superset? [1 3] [1 3]
            ; => true

            superset?.proper [1 3] [1 3]
            ; => false
        """:
            ##########################################################
            if (popAttr("proper")!=VNULL):
                if x == y: 
                    stack.push(newBoolean(false))
                else:
                    var contains = true
                    for item in y.a:
                        if item notin x.a:
                            contains = false
                            break

                    stack.push(newBoolean(contains))
            else:
                if x == y:
                    stack.push(newBoolean(true))
                else:
                    var contains = true
                    for item in y.a:
                        if item notin x.a:
                            contains = false
                            break

                    stack.push(newBoolean(contains))

    builtin "union",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return the union of given sets",
        args        = {
            "setA"  : {Block,Literal},
            "setB"  : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            print union [1 2 3 4] [3 4 5 6]
            ; 1 2 3 4 5 6

            a: [1 2 3 4]
            b: [3 4 5 6]
            union 'a b
            ; a: [1 2 3 4 5 6]
        """:
            ##########################################################
            if x.kind==Literal:
                SetInPlace(newBlock(toSeq(union(toHashSet(InPlace.a), toHashSet(y.a)))))
            else:
                stack.push(newBlock(toSeq(union(toHashSet(x.a), toHashSet(y.a)))))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)