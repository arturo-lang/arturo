#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Sets.nim
#=======================================================

## The main Sets module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import sequtils, sugar

import helpers/sets

import vm/lib

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    builtin "difference",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "return the difference of given sets",
        args        = {
            "setA"  : {Block,Literal, PathLiteral},
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
            #=======================================================
            dispatchWithLiteral:
                Block(a):
                    on symmetric: toSeq(symmetricDifference(toOrderedSet(a), toOrderedSet(y.a)))
                    _:            toSeq(difference(toOrderedSet(a), toOrderedSet(y.a)))

    builtin "intersection",
        alias       = VSymbol.intersection, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "return the intersection of given sets",
        args        = {
            "setA"  : {Block,Literal, PathLiteral},
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
            #=======================================================
            dispatchWithLiteral:
                Block(a): toSeq(intersection(toOrderedSet(a), toOrderedSet(y.a)))

    builtin "powerset",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "return the powerset of given set",
        args        = {
            "set"   : {Block,Literal, PathLiteral}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            powerset [1 2 3]
            ;  [[] [1] [2] [1 3] [3] [1 2] [2 3] [1 2 3]]
        """:
            #=======================================================
            dispatchWithLiteral:
                Block(a): toSeq(powerset(toOrderedSet(a)).map((hs) => newBlock(toSeq(hs))))

    builtin "union",
        alias       = VSymbol.union, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "return the union of given sets",
        args        = {
            "setA"  : {Block,Literal, PathLiteral},
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
            #=======================================================
            dispatchWithLiteral:
                Block(a): toSeq(union(toOrderedSet(a), toOrderedSet(y.a)))

    #----------------------------
    # Predicates
    #----------------------------

    builtin "disjoint?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given sets are disjoint (they have no common elements)",
        args        = {
            "setA"  : {Block},
            "setB"  : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            disjoint? [1 2 3 4] [3 4 5 6]
            ; => false

            disjoint? [1 2 3 4] [5 6 7 8]
            ; => true
        """:
            #=======================================================
            push(newLogical(disjoint(toOrderedSet(x.a), toOrderedSet(y.a))))

    builtin "intersect?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given sets intersect (they have at least one common element)",
        args        = {
            "setA"  : {Block},
            "setB"  : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            intersect? @1..10 @8..12
            ; => true

            intersect? ["one" "two" "three"] ["three" "four" "five"]
            ; => true

            intersect? ["one" "two" "three"] ["four" "five" "six"]
            ; => false
        """:
            #=======================================================
            let res = intersection(toOrderedSet(x.a), toOrderedSet(y.a))
            if len(res) >= 0:
                push(VTRUE)
            else:
                push(VFALSE)

    builtin "subset?",
        alias       = subsetorequal, 
        op          = opNop,
        rule        = InfixPrecedence,
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
            #=======================================================
            if (hadAttr("proper")):
                if x == y: 
                    push(newLogical(false))
                else:
                    var contains = true
                    let xblk = x.a
                    let yblk = y.a
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
                    let xblk = x.a
                    let yblk = y.a
                    for item in xblk:
                        if item notin yblk:
                            contains = false
                            break

                    push(newLogical(contains))

    builtin "superset?",
        alias       = supersetorequal, 
        op          = opNop,
        rule        = InfixPrecedence,
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
            #=======================================================
            if (hadAttr("proper")):
                if x == y: 
                    push(newLogical(false))
                else:
                    var contains = true
                    let xblk = x.a
                    let yblk = y.a
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
                    let xblk = x.a
                    let yblk = y.a
                    for item in yblk:
                        if item notin xblk:
                            contains = false
                            break

                    push(newLogical(contains))
