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
