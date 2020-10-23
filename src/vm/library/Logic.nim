######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Logic.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template IsAnd*():untyped = 
    # EXAMPLE:
    # x: 2
    # y: 5
    #
    # if and? x=2 y>5 [
    # ____print "yep, that's correct!"]
    # ]
    #
    # ; yep, that's correct!

    require(opAnd)
    stack.push(newBoolean(x.b and y.b))

template IsNand*():untyped =
    # EXAMPLE:
    # x: 2
    # y: 3
    #
    # if? nand? x=2 y=3 [
    # ____print "yep, that's correct!"]
    # ]
    # else [
    # ____print "nope, that's not correct"
    #]
    #
    # ; nope, that's not correct

    require(opNand)
    stack.push(newBoolean(not (x.b and y.b)))

template IsNor*():untyped =
    # EXAMPLE:
    # x: 2
    # y: 3
    #
    # if? nor? x>2 y=3 [
    # ____print "yep, that's correct!"]
    # ]
    # else [
    # ____print "nope, that's not correct"
    #]
    #
    # ; nope, that's not correct

    require(opNor)
    stack.push(newBoolean(not (x.b or y.b)))

template IsNot*():untyped =
    # EXAMPLE:
    # ready: false
    # if not? ready [
    # ____print "we're still not ready!"
    # ]
    #
    # ; we're still not ready!

    require(opNot)
    stack.push(newBoolean(not x.b))

template IsOr*():untyped =
    # EXAMPLE:
    # x: 2
    # y: 4
    #
    # if or? x=2 y>5 [
    # ____print "yep, that's correct!"]
    # ]
    #
    # ; yep, that's correct!

    require(opOr)
    stack.push(newBoolean(x.b or y.b))

template IsXnor*():untyped =
    # EXAMPLE:
    # x: 2
    # y: 3
    #
    # if? xnor? x=2 y=3 [
    # ____print "yep, that's correct!"]
    # ]
    # else [
    # ____print "nope, that's not correct"
    #]
    #
    # ; yep, that's not correct

    require(opXnor)
    stack.push(newBoolean(not (x.b xor y.b)))

template IsXor*():untyped =
    # EXAMPLE:
    # x: 2
    # y: 3
    #
    # if? xor? x=2 y=3 [
    # ____print "yep, that's correct!"]
    # ]
    # else [
    # ____print "nope, that's not correct"
    #]
    #
    # ; nope, that's not correct

    require(opXor)
    stack.push(newBoolean(x.b xor y.b))
