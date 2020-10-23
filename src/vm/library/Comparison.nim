######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Comparison.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template IsEqual*():untyped =
    # EXAMPLE:
    # equal? 5 2            ; => false
    # equal? 5 6-1          ; => true
    #
    # print 3=3             ; true

    require(opEq)
    stack.push(newBoolean(x == y))

template IsGreater*():untyped =
    # EXAMPLE:
    # greater? 5 2          ; => true
    # greater? 5 6-1        ; => false
    #
    # print 3>2             ; true

    require(opGt)
    stack.push(newBoolean(x > y))

template IsGreaterOrEqual*():untyped =
    # EXAMPLE:
    # greaterOrEqual? 5 2   ; => true
    # greaterOrEqual? 5 4-1 ; => false
    #
    # print 2>=2            ; true

    require(opGe)
    stack.push(newBoolean(x >= y))

template IsLess*():untyped =
    # EXAMPLE:
    # less? 5 2             ; => false
    # less? 5 6+1           ; => true
    #
    # print 2<3             ; true

    require(opLt)
    stack.push(newBoolean(x < y))

template IsLessOrEqual*():untyped =
    # EXAMPLE:
    # lessOrEqual? 5 2      ; => false
    # lessOrEqual? 5 6-1    ; => true
    #
    # print 2=<3            ; true

    require(opGe)
    stack.push(newBoolean(x <= y))
            
template IsNotEqual*():untyped =
    # EXAMPLE:
    # notEqual? 5 2         ; => true
    # notEqual? 5 6-1       ; => false
    #
    # print 2<>3            ; true

    require(opNe)
    stack.push(newBoolean(x != y))
            