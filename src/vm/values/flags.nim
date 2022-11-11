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
        ReadOnly    # Value has to be copied on assignment

        Dirty       # For blocks: it may contain Newline values
        Dynamic     # For blocks: it has to be re-evaluated
                    #             prior to execution
                    
        True        # Logical TRUE
        False       # Logical FALSE
        Maybe       # Logical MAYBE

    ValueFlags* = set[ValueFlag]
