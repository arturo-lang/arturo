#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/custom/vlogical.nim
#=======================================================

## The internal `:logical` type

#=======================================
# Libraries
#=======================================

import vm/values/flags

#=======================================
# Types
#=======================================

type 
    VLogical* = distinct ValueFlags

#=======================================
# Constants
#=======================================

const 
    True*    = VLogical({IsTrue})
    False*   = VLogical({IsFalse})
    Maybe*   = VLogical({IsMaybe})

#=======================================
# Overloads
#=======================================

proc `==`*(a, b: VLogical): bool {.borrow.}

#=======================================
# Methods
#=======================================

func And*(x,y: VLogical): VLogical {.inline,enforceNoRaises.} =
    if x==False: return False
    if y==False: return False
    if x==True and y==True: return True
    else: return Maybe

func Not*(x: VLogical): VLogical {.inline,enforceNoRaises.} =
    if x==True: return False
    elif x==False: return True
    else: return Maybe
    
func Or*(x,y: VLogical): VLogical {.inline,enforceNoRaises.} =
    if x==True: return True
    if y==True: return True
    if x==False and y==False: return False
    else: return Maybe

func Xor*(x,y: VLogical): VLogical {.inline,enforceNoRaises.} =
    return And(Or(x,y),Not(And(x,y)))

func Nand*(x,y: VLogical): VLogical {.inline,enforceNoRaises.} =
    return Not(And(x,y))

func Nor*(x,y: VLogical): VLogical {.inline,enforceNoRaises.} =
    return Not(Or(x,y))

func Xnor*(x,y: VLogical): VLogical {.inline,enforceNoRaises.} =
    return Not(Xor(x,y))

func `$`*(b: VLogical): string  {.enforceNoRaises.} =
    if b==True: return "true"
    elif b==False: return "false"
    else: return "maybe"