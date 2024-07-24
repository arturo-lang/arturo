#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/flags.nim
#=======================================================

## Miscellaneous flags/switches for Value objects

#=======================================
# Libraries
#=======================================

import std/setutils

#=======================================
# Types
#=======================================

type
    ValueFlag* = enum
        IsReadOnly      # Value has to be copied on assignment

        IsDynamic       # For blocks: it has to be re-evaluated
                        #             prior to execution
                    
        IsTrue          # Logical TRUE
        IsFalse         # Logical FALSE
        IsMaybe         # Logical MAYBE

    ValueFlags* = set[ValueFlag]

#=======================================
# Constants
#=======================================

const
    LogicalF*    = {IsTrue, IsFalse, IsMaybe}
    NonLogicalF* = ValueFlag.fullSet - LogicalF
