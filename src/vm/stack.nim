######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: vm/stack.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, tables

import vm/value

#=======================================
# Constants
#=======================================

const StackSize* = 100000
const AttrsSize* = 10

#=======================================
# Globals
#=======================================

var Stack*{.threadvar.}: seq[Value]
var Attrs*: OrderedTable[string,Value]
var SP*: int
var AP*: int
var CSP*: int

#=======================================
# Methods
#=======================================

## Main stack

template push*(v: Value) = 
    Stack[SP] = v
    SP += 1

template pop*(): Value = 
    SP -= 1
    Stack[SP]

template sTop*(): Value =
    Stack[SP-1]

template sTopsFrom*(start: int): ValueArray =
    Stack[start..SP-1]

template emptyStack*() =
    SP = 0

## Attributes stack

template pushAttr*(label: string, v: Value) =
    Attrs[label] = v
    # Attrs[AP] = v
    # AP += 1

# template popAttr*(): Value =

#     AP -= 1
#     Attrs[AP]

# template attrTop*(): Value =
#     Stack[AP-1]

template emptyAttrs*() =
    Attrs = initOrderedTable[string,Value]()

proc printAttrs*() =
    for k,v in pairs(Attrs):
        echo k & " => " & $(v)
    # var tmp = AP
    # while tmp>0:
    #     echo "attr: " & Attrs[tmp-1].r & " => " & $(Attrs[tmp-2])
    #     tmp -= 2

proc getAttr*(attr: string): Value =
    Attrs.getOrDefault(attr, VNULL)
    # var tmp = AP
    # while tmp>0:
    #     if Attrs[tmp-1].r == attr: 
    #         return Attrs[tmp-2]
    #     tmp -= 2

    # return VNULL

proc popAttr*(attr: string): Value =
    result = Attrs.getOrDefault(attr, VNULL)
    Attrs.del(attr)
    # if Attrs.hasKey(attr):
    #     return 
    # echo "trying to popAttr: " & attr
    # var tmp = AP
    # echo "after tmp=AP"
    # while tmp>0:
    #     echo "in while tmp>0"
    #     if Attrs[tmp-1].r == attr: 
    #         echo "- found it"
    #         result = Attrs[tmp-2]
    #         echo "deleting"
    #         echo "AP=" & $(AP) & " tmp=" & $(tmp)
    #         echo "deleting: " & $(tmp-1)
    #         Attrs.delete(tmp-1)
    #         echo "deleting: " & $(tmp-1)
    #         Attrs.delete(tmp-1)
    #         #delete(Attrs,tmp-2,tmp-1)
    #         AP -= 2
    #         echo "before returning: AP=" & $(AP)
    #         #printAttrs()
    #         return
    #     echo "after if - before tmp-=2: " & $(tmp)
    #     tmp -= 2
    #     echo "after tmp-=2: " & $(tmp)

    # echo "- not found"
    # #printAttrs()

    # return VNULL

proc getAttrsDict*(): Value =
    result = newDictionary(Attrs)
    # result = newDictionary()
    # var tmp = AP
    # while tmp>0:
    #     result.d[Attrs[tmp-1].r] = Attrs[tmp-2]
    
    #     tmp -= 2

    emptyAttrs()
