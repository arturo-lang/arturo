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
        # TODO(Sets\difference) add example for documentation
        #  labels: library,documentation,easy
        example     = """
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
        # TODO(Sets\intersection) add example for documentation
        #  labels: library,documentation,easy
        example     = """
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
        # TODO(Sets\union) add example for documentation
        #  labels: library,documentation,easy
        example     = """
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