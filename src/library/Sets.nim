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
                    Syms[x.s] = newBlock(toSeq(symmetricDifference(toHashSet(Syms[x.s].a), toHashSet(y.a))))
                else:
                    stack.push(newBlock(toSeq(symmetricDifference(toHashSet(x.a), toHashSet(y.a)))))
            else:
                if x.kind==Literal:
                    Syms[x.s] = newBlock(toSeq(difference(toHashSet(Syms[x.s].a), toHashSet(y.a))))
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
                Syms[x.s] = newBlock(toSeq(intersection(toHashSet(Syms[x.s].a), toHashSet(y.a))))
            else:
                stack.push(newBlock(toSeq(intersection(toHashSet(x.a), toHashSet(y.a)))))

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
                Syms[x.s] = newBlock(toSeq(union(toHashSet(Syms[x.s].a), toHashSet(y.a))))
            else:
                stack.push(newBlock(toSeq(union(toHashSet(x.a), toHashSet(y.a)))))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)