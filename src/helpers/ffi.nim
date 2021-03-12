######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/ffi.nim
######################################################

#=======================================
# Libraries
#=======================================

import dynlib

import vm/[errors, globals, value]

#=======================================
# Types
#=======================================

type
    VVCaller*       = proc() {.nimcall.}

#=======================================
# Helpers
#=======================================

proc loadLibrary*(path: string): LibHandle =
    result = loadLib(path)

    if result == nil:
        echo "Error loading library"
        quit(QuitFailure)

proc unloadLibrary*(lib: LibHandle) =
    unloadLib(lib)

#=======================================
# Methods
#=======================================

proc execForeignMethod*(path: string, meth: string): Value =
    let lib = loadLibrary(path)
    let runner = cast[VVCaller](lib.symAddr(meth))

    if runner == nil:
        echo "Error loading '" & meth & 
             "' function from library at: " & path
        quit(QuitFailure)

    runner()

    unloadLibrary(lib)
    
    return VNULL
