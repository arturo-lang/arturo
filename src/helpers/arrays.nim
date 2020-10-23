######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: helpers/arrays.nim
######################################################

#=======================================
# Libraries
#=======================================

import ../vm/value

#=======================================
# Methods
#=======================================

proc flattened*(v: Value): Value =
    result = newBlock()

    for item in v.a:
        if item.kind==Block:
            for subitem in flattened(item).a:
                result.a.add(subitem)
        else:
            result.a.add(item)
