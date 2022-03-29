######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
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

import sequtils, std/sets, sugar

import helpers/arrays

import vm/lib

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
            "symmetric" : ({Logical},"get the symmetric difference")
        },
        returns     = {Block,Nothing},
        example     = """
            print difference [1 2 3 4] [3 4 5 6]
            ; 1 2
            ..........
            a: [1 2 3 4]
            b: [3 4 5 6]
            difference 'a b
            ; a: [1 2]
            ..........
            print difference.symmetric [1 2 3 4] [3 4 5 6]
            ; 1 2 5 6
        """:
            ##########################################################
            if (popAttr("symmetric")!=VNULL):
                if x.kind==Literal:
                    SetInPlace(newBlock(toSeq(symmetricDifference(toHashSet(cleanBlock(InPlace.a)), toHashSet(cleanBlock(y.a))))))
                else:
                    push(newBlock(toSeq(symmetricDifference(toHashSet(cleanBlock(x.a)), toHashSet(cleanBlock(y.a))))))
            else:
                if x.kind==Literal:
                    SetInPlace(newBlock(toSeq(difference(toHashSet(cleanBlock(InPlace.a)), toHashSet(cleanBlock(y.a))))))
                else:
                    push(newBlock(toSeq(difference(toHashSet(cleanBlock(x.a)), toHashSet(cleanBlock(y.a))))))

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
            ..........
            a: [1 2 3 4]
            b: [3 4 5 6]
            intersection 'a b
            ; a: [3 4]
        """:
            ##########################################################
            if x.kind==Literal:
                SetInPlace(newBlock(toSeq(intersection(toHashSet(cleanBlock(InPlace.a)), toHashSet(cleanBlock(y.a))))))
            else:
                push(newBlock(toSeq(intersection(toHashSet(cleanBlock(x.a)), toHashSet(cleanBlock(y.a))))))

    builtin "powerset",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return the powerset of given set",
        args        = {
            "set"   : {Block,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            powerset [1 2 3]
            ;  [[] [1] [2] [1 3] [3] [1 2] [2 3] [1 2 3]]
        """:
            ##########################################################
            if x.kind==Literal:
                SetInPlace(newBlock(toSeq(powerset(toHashSet(cleanBlock(InPlace.a)))).map((hs) => newBlock(toSeq(hs)))))
            else:
                push(newBlock(toSeq(powerset(toHashSet(cleanBlock(x.a))).map((hs) => newBlock(toSeq(hs))))))

    builtin "subset?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given set is a subset of second set",
        args        = {
            "setA"  : {Block},
            "setB"  : {Block}
        },
        attrs       = {
            "proper": ({Logical},"check if proper subset")
        },
        returns     = {Logical},
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
                    push(newLogical(false))
                else:
                    var contains = true
                    let xblk = cleanBlock(x.a)
                    let yblk = cleanBlock(y.a)
                    for item in xblk:
                        if item notin yblk:
                            contains = false
                            break

                    push(newLogical(contains))
            else:
                if x == y:
                    push(newLogical(true))
                else:
                    var contains = true
                    let xblk = cleanBlock(x.a)
                    let yblk = cleanBlock(y.a)
                    for item in xblk:
                        if item notin yblk:
                            contains = false
                            break

                    push(newLogical(contains))

    builtin "superset?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given set is a superset of second set",
        args        = {
            "setA"  : {Block},
            "setB"  : {Block}
        },
        attrs       = {
            "proper": ({Logical},"check if proper superset")
        },
        returns     = {Logical},
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
                    push(newLogical(false))
                else:
                    var contains = true
                    let xblk = cleanBlock(x.a)
                    let yblk = cleanBlock(y.a)
                    for item in yblk:
                        if item notin xblk:
                            contains = false
                            break

                    push(newLogical(contains))
            else:
                if x == y:
                    push(newLogical(true))
                else:
                    var contains = true
                    let xblk = cleanBlock(x.a)
                    let yblk = cleanBlock(y.a)
                    for item in yblk:
                        if item notin xblk:
                            contains = false
                            break

                    push(newLogical(contains))

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
            ..........
            a: [1 2 3 4]
            b: [3 4 5 6]
            union 'a b
            ; a: [1 2 3 4 5 6]
        """:
            ##########################################################
            if x.kind==Literal:
                SetInPlace(newBlock(toSeq(union(toHashSet(cleanBlock(InPlace.a)), toHashSet(cleanBlock(y.a))))))
            else:
                push(newBlock(toSeq(union(toHashSet(cleanBlock(x.a)), toHashSet(cleanBlock(y.a))))))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)