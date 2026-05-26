#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/values/custom/vchannel.nim
#=======================================================

## Internal representation for the `:channel` value.
##
## A channel is a typed, ordered, point-to-point stream between fibers.
## It carries a symbolic name (used for `print` / `inspect`) plus the
## state needed for cooperative send/receive — full state, buffer,
## park queues, and capacity wire up in later commits.

when not defined(WEB):
    #=======================================
    # Types
    #=======================================

    type
        VChannel* = ref object
            name*: string
