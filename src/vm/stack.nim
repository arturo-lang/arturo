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

const StackSize* = 200
const AttrsSize* = 10

#=======================================
# Globals
#=======================================

var Stack*{.threadvar.}: seq[Value]
var Attrs*{.threadvar.}: seq[Value]
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

template pushAttr*(v: Value) =
    Attrs[AP] = v
    AP += 1

template popAttr*(): Value =
    AP -= 1
    Attrs[AP]

template attrTop*(): Value =
    Stack[AP-1]

template emptyAttrs*() =
    AP = 0

proc getAttr*(attr: string): Value =
    var tmp = AP
    while tmp>0:
        if Attrs[tmp-1].r == attr: 
            return Attrs[tmp-2]
        tmp -= 2

    return VNULL

proc popAttr*(attr: string): Value =
    var tmp = AP
    while tmp>0:
        if Attrs[tmp-1].r == attr: 
            result = Attrs[tmp-2]
            delete(Attrs,tmp-2,tmp-1)
            AP -= 2
            return
        tmp -= 2

    return VNULL

proc getAttrsDict*(): Value =
    result = newDictionary()
    var tmp = AP
    while tmp>0:
        result.d[Attrs[tmp-1].r] = Attrs[tmp-2]
    
        tmp -= 2

    emptyAttrs()
