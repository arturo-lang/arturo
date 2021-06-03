######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/values/logic.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/values/value

#=======================================
# Methods
#=======================================

proc Not*(x: logical): logical {.noSideEffect.} =
    if x==True: return False
    elif x==False: return True
    else: return Maybe