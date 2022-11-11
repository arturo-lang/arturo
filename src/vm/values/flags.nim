#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/flags.nim
#=======================================================

#=======================================
# Types
#=======================================

type
    ValueFlag* = enum
        IsReadOnly      # Value has to be copied on assignment

        IsDirty         # For blocks: it may contain Newline values
        IsDynamic       # For blocks: it has to be re-evaluated
                        #             prior to execution
                    
        IsTrue          # Logical TRUE
        IsFalse         # Logical FALSE
        IsMaybe         # Logical MAYBE

    ValueFlags* = set[ValueFlag]
