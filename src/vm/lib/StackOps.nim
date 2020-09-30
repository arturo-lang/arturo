######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/StackOps.nim
######################################################

import strutils, tables

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Push*():untyped =
    discard
    # we do not need to do anything, just leave the value there
    # as it's already been pushed

template Pop*():untyped =
    require(opPop)

    let doDiscard = (getAttr("discard") != VNULL)

    if x.i==1:
        if doDiscard: discard stack.pop()
        else: discard
    else:
        if doDiscard: 
            var i = 0
            while i<x.i:
                discard stack.pop()
                i+=1
        else:
            var res: ValueArray = @[]
            var i = 0
            while i<x.i:
                res.add stack.pop()
                i+=1
            stack.push(newArray(res))
            
    emptyAttrs()   