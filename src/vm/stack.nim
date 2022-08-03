######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/stack.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import strformat

import tables

import vm/values/value

#=======================================
# Constants
#=======================================

# TODO(VM/stack) Re-consider the starting values for our StackSize & AttrsSize
#  How does it influence the overall performance? This has to be thoroughly tested & benchmarked.
#  labels: vm, benchmark, unit-test
const StackSize* = 100000
const AttrsSize* = 10

var
    # stack
    Stack*                  : seq[Value]
    Attrs*                  : OrderedTable[string,Value]
    SP*, AP*, CSP*          : int

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

template popN*(n: int) =
    SP -= n

template peek*(pos: int): Value =
    Stack[SP-1-pos]

template sTop*(): Value =
    Stack[SP-1]

template sTopsFrom*(start: int): ValueArray =
    Stack[start..SP-1]

template emptyStack*() =
    SP = 0

template createMainStack*() =
    newSeq(Stack, StackSize)
    emptyStack()

## Attributes stack

template pushAttr*(label: string, v: Value) =
    Attrs[label] = v

template emptyAttrs*() =
    Attrs = initOrderedTable[string,Value]()

template createAttrsStack*() =
    emptyAttrs()

proc getAttr*(attr: string): Value =
    Attrs.getOrDefault(attr, VNULL)

proc popAttr*(attr: string): Value =
    result = Attrs.getOrDefault(attr, VNULL)
    Attrs.del(attr)

proc getAttrsDict*(): Value =
    result = newDictionary(Attrs)

    emptyAttrs()

# Debugging

proc dumpStack*() =
    var i = 0
    while i < SP:
        when not defined(WEB):
            stdout.write fmt("{i}: ")
        var item = Stack[i]

        item.dump(0, false)

        i += 1

# when defined(VERBOSE):

#     proc printAttrs*() =
#         for k,v in pairs(Attrs):
#             echo k & " => " & $(v)
