######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Path.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/env, vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Module*():untyped =
    require(opModule)

    stack.push(newString("/usr/local/lib/arturo/" & x.s & ".art"))

template Relative*():untyped =
    require(opRelative)

    stack.push(newString(joinPath(env.currentPath(),x.s)))
