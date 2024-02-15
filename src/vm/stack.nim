#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/stack.nim
#=======================================================

## Stack implementation for the VM

#=======================================
# Libraries
#=======================================

import macros, strutils, tables

import vm/profiler
import vm/values/value

#=======================================
# Constants
#=======================================

# TODO(VM/stack) Re-consider the starting values for our StackSize
#  How does it influence the overall performance? This has to be thoroughly tested & benchmarked.
#  labels: vm, benchmark, unit-test
const StackSize* = 100000   ## The initial stack size

#=======================================
# Variables
#=======================================

var
    # stack
    Stack*                  : ValueArray                        ## The main stack
    SP*                     : int                               ## The main stack pointer
    Attrs*                  : SymTable                          ## The attributes table

#=======================================
# Methods
#=======================================

# Main stack

template push*(v: Value) = 
    ## push given value onto the stack
    hookProcProfiler("stack/push"):
        Stack[SP] = v
        SP += 1

template push*(v: ValueArray, a: int, b: int, reversed=false, doMove=false) =
    ## push values from given array onto the stack, using ``a`` and ``b`` as 
    ## index delimiters
    when reversed:
        var j = b - 1
        while j >= a:
            push(when doMove: move v[j] else: v[j])
            j -= 1
    else:
        var j = a
        while j < b:
            push(when doMove: move v[j] else: v[j])
            j += 1

template pop*(): Value = 
    ## pop last value from the stack
    when defined(PROFILER):
        hookProcProfiler("stack/pop"):
            SP -= 1
            discard Stack[SP]
    else:
        SP -= 1
    move Stack[SP]

template popN*(n: int) =
    ## simulate popping ``n`` values from the stack
    ## 
    ## **Hint**: This doesn't return any value whatsoever; 
    ## all it does is decrease the stack pointer accordingly
    SP -= n

template peek*(pos: int): Value =
    ## return last ``pos`` value from the stack, 
    ## without popping it
    Stack[SP-1-pos]

template sTop*(): Value =
    ## get top-most value from the stack
    Stack[SP-1]

template squeeze*(pos: int, v: Value) =
    ## forcefully insert given value at given position 
    ## in the stack (``pos`` being the distance from 
    ## the top of the stack)
    when pos==1:
        let tmp = Stack[SP-1]
        Stack[SP-1] = v
        Stack[SP] = tmp
    elif pos==2:
        let tmp = Stack[SP-2]
        Stack[SP-2] = v
        Stack[SP] = Stack[SP-1]
        Stack[SP-1] = tmp
    SP += 1

template sTopsFrom*(start: int): ValueArray =
    ## return a range of values from the stack, using ``start`` 
    ## as a starting index, without popping them
    Stack[start..SP-1]

template emptyStack*() =
    ## empty the stack
    ## 
    ## **Hint:** This doesn't involve deleting any elements; 
    ## all this does is to reset the stack pointer to zero
    SP = 0

template createMainStack*() =
    ## initialize the main stack
    newSeq(Stack, StackSize)
    emptyStack()

# Attributes table

template pushAttr*(label: string, v: Value) =
    ## set attribute ``label`` to given value
    Attrs[label] = v

template emptyAttrs*() =
    ## empty the attributes table
    Attrs = initTable[string,Value]()

template createAttrsStack*() =
    ## initialize the attributes table
    emptyAttrs()

proc getAttr*(attr: string): Value {.inline,enforceNoRaises.} =
    ## get attribute ``attr`` from the attributes table
    ## 
    ## **Hint:** Returns ``VNULL`` if attribute doesn't exist
    Attrs.getOrDefault(attr, VNULL)

proc popAttr*(attr: string): Value {.inline,enforceNoRaises.} =
    ## pop attribute ``attr`` from the attributes table
    ## 
    ## **Hint:** Returns ``nil`` if attribute doesn't exist
    result = nil
    hookProcProfiler("stack/popAttr"):
        discard Attrs.pop(attr, result)

macro checkAttrUnsafeImpl*(name: untyped): untyped =
    ## check if attribute ``name`` exists in the attributes table
    ## 
    ## **Hint:** To be normally used with ``if`` statements (as 
    ## a condition)
    let attrName =  ident('a' & ($name).capitalizeAscii())
    result = quote do:
        (let `attrName` = popAttr(`name`); (not `attrName`.isNil))

macro checkAttrImpl*(name: untyped): untyped =
    ## check if attribute ``name`` exists in the attributes table
    ## 
    ## **Hint:** To be normally used with ``if`` statements (as 
    ## a condition)
    let attrName =  ident('a' & ($name).capitalizeAscii())
    let attrTName = ident('t' & ($name).capitalizeAscii())
    let attrField = newStrLitNode('.' & ($name))
    result = quote do:
        (let `attrName` = popAttr(`name`); (not `attrName`.isNil) and (`attrName`.kind in `attrTName` or showWrongAttributeTypeError(currentBuiltinName, `attrField`,`attrName`,`attrTName`)))

template checkAttr*(name: untyped, doValidate=true): untyped =
    when doValidate:
        checkAttrImpl(name)
    else:
        checkAttrUnsafeImpl(name)

template hadAttr*(attr: string): bool = 
    ## check if attribute ``attr`` exists in the attributes table
    ## and pop it, if it does
    (not popAttr(attr).isNil)

proc getAttrsDict*(): Value =
    ## get the attributes table as a Dictionary value
    result = newDictionary(Attrs)

    emptyAttrs()
