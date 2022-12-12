#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Sockets.nim
#=======================================================

## The main Sockets module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import net

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =
        
    builtin "download",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "download file from url to disk",
        args        = {
            "url"   : {String}
        },
        attrs       = {
            "as"    : ({String},"set target file")
        },
        returns     = {Nothing},
        example     = """
        """:
            #=======================================================
            when defined(SAFE): RuntimeError_OperationNotPermitted("")
            discard

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
