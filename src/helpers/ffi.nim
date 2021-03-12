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

import dynlib, sequtils, sugar

import vm/[errors, globals, value]

#=======================================
# Types
#=======================================

type
    V_VCaller*      = proc()                {.nimcall.}
    I_VCaller*      = proc(a: int)          {.nimcall.}
    S_VCaller*      = proc(a: cstring)      {.nimcall.}
    V_ICaller*      = proc():int            {.nimcall.}
    I_ICaller*      = proc(a: int):int      {.nimcall.}
    S_ICaller*      = proc(a: cstring):int  {.nimcall.}

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

template checkRunner*(r: pointer):untyped =
    if r == nil:
        echo "Error loading '" & meth & 
             "' function from library at: " & path
        quit(QuitFailure)

#=======================================
# Methods
#=======================================

proc execForeignMethod*(path: string, meth: string, params: ValueArray = @[], expected: ValueKind = Nothing): Value =
    result = VNULL

    let lib = loadLibrary(path)

    case expected
        of Nothing:
            if params.len==0:
                let runner = cast[V_VCaller](lib.symAddr(meth))
                checkRunner(runner)
                runner()
            elif params.len==1:
                case params[0].kind
                    of Integer:
                        let runner = cast[I_VCaller](lib.symAddr(meth))
                        checkRunner(runner)
                        runner(params[0].i)
                    of String:
                        let runner = cast[S_VCaller](lib.symAddr(meth))
                        checkRunner(runner)
                        runner(cstring(params[0].s))
                    else:
                        discard
        of Integer:
            if params.len==0:
                let runner = cast[V_ICaller](lib.symAddr(meth))
                checkRunner(runner)
                result = newInteger(runner())
            elif params.len==1:
                case params[0].kind
                    of Integer:
                        let runner = cast[I_ICaller](lib.symAddr(meth))
                        checkRunner(runner)
                        result = newInteger(runner(params[0].i))
                    of String:
                        let runner = cast[S_ICaller](lib.symAddr(meth))
                        checkRunner(runner)
                        result = newInteger(runner(cstring(params[0].s)))
                    else:
                        discard
        else:
            discard

    unloadLibrary(lib)
