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

import dynlib, os, strutils

import vm/[value]

#=======================================
# Types
#=======================================

# The most stupid hack of the century
# but it kinda works - better than nothing!

type
    V_V_Caller*      = proc()                               {.nimcall.}
    I_P_Caller*      = proc(a: int):pointer                 {.nimcall.}
    S_P_Caller*      = proc(a: cstring):pointer             {.nimcall.}
    I_V_Caller*      = proc(a: int)                         {.nimcall.}
    F_V_Caller*      = proc(a: float)                       {.nimcall.}
    S_V_Caller*      = proc(a: cstring)                     {.nimcall.}
    II_V_Caller*     = proc(a: int, b:int)                  {.nimcall.}
    IF_V_Caller*     = proc(a: int, b: float)               {.nimcall.}
    IS_V_Caller*     = proc(a: int, b:cstring)              {.nimcall.}
    FI_V_Caller*     = proc(a: float, b:int)                {.nimcall.}
    FF_V_Caller*     = proc(a: float, b:float)              {.nimcall.}
    FS_V_Caller*     = proc(a: float, b:cstring)            {.nimcall.}
    SI_V_Caller*     = proc(a: cstring, b:int)              {.nimcall.}
    SF_V_Caller*     = proc(a: cstring, b:float)            {.nimcall.}
    SS_V_Caller*     = proc(a: cstring, b:cstring)          {.nimcall.}

    V_I_Caller*      = proc():int                           {.nimcall.}
    I_I_Caller*      = proc(a: int):int                     {.nimcall.}
    F_I_Caller*      = proc(a: float):int                   {.nimcall.}
    S_I_Caller*      = proc(a: cstring):int                 {.nimcall.}
    II_I_Caller*     = proc(a: int, b:int):int              {.nimcall.}
    IF_I_Caller*     = proc(a: int, b: float):int           {.nimcall.}
    IS_I_Caller*     = proc(a: int, b:cstring):int          {.nimcall.}
    FI_I_Caller*     = proc(a: float, b:int):int            {.nimcall.}
    FF_I_Caller*     = proc(a: float, b:float):int          {.nimcall.}
    FS_I_Caller*     = proc(a: float, b:cstring):int        {.nimcall.}
    SI_I_Caller*     = proc(a: cstring, b:int):int          {.nimcall.}
    SF_I_Caller*     = proc(a: cstring, b:float):int        {.nimcall.}
    SS_I_Caller*     = proc(a: cstring, b:cstring):int      {.nimcall.}

    V_F_Caller*      = proc():float                         {.nimcall.}
    I_F_Caller*      = proc(a: int):float                   {.nimcall.}
    F_F_Caller*      = proc(a: float):float                 {.nimcall.}
    S_F_Caller*      = proc(a: cstring):float               {.nimcall.}
    II_F_Caller*     = proc(a: int, b:int):float            {.nimcall.}
    IF_F_Caller*     = proc(a: int, b: float):float         {.nimcall.}
    IS_F_Caller*     = proc(a: int, b:cstring):float        {.nimcall.}
    FI_F_Caller*     = proc(a: float, b:int):float          {.nimcall.}
    FF_F_Caller*     = proc(a: float, b:float):float        {.nimcall.}
    FS_F_Caller*     = proc(a: float, b:cstring):float      {.nimcall.}
    SI_F_Caller*     = proc(a: cstring, b:int):float        {.nimcall.}
    SF_F_Caller*     = proc(a: cstring, b:float):float      {.nimcall.}
    SS_F_Caller*     = proc(a: cstring, b:cstring):float    {.nimcall.}

    V_S_Caller*      = proc():cstring                       {.nimcall.}
    I_S_Caller*      = proc(a: int):cstring                 {.nimcall.}
    F_S_Caller*      = proc(a: float):cstring               {.nimcall.}
    S_S_Caller*      = proc(a: cstring):cstring             {.nimcall.}
    II_S_Caller*     = proc(a: int, b:int):cstring          {.nimcall.}
    IF_S_Caller*     = proc(a: int, b: float):cstring       {.nimcall.}
    IS_S_Caller*     = proc(a: int, b:cstring):cstring      {.nimcall.}
    FI_S_Caller*     = proc(a: float, b:int):cstring        {.nimcall.}
    FF_S_Caller*     = proc(a: float, b:float):cstring      {.nimcall.}
    FS_S_Caller*     = proc(a: float, b:cstring):cstring    {.nimcall.}
    SI_S_Caller*     = proc(a: cstring, b:int):cstring      {.nimcall.}
    SF_S_Caller*     = proc(a: cstring, b:float):cstring    {.nimcall.}
    SS_S_Caller*     = proc(a: cstring, b:cstring):cstring  {.nimcall.}

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

template callFunc0(t:untyped):untyped =
    let runner = cast[t](lib.symAddr(meth))
    checkRunner(runner)
    runner()

template callFunc1(t:untyped, arg1:untyped):untyped =
    let runner = cast[t](lib.symAddr(meth))
    checkRunner(runner)
    runner(arg1)

template callFunc2(t:untyped, arg1:untyped, arg2:untyped):untyped =
    let runner = cast[t](lib.symAddr(meth))
    checkRunner(runner)
    runner(arg1,arg2)

proc resolveLibrary*(path: string): string =
    let (_, _, extension) = splitFile(path)
    if extension != "":
        result = path
    else:
        result = DynlibFormat % [path]

    echo "trying to load library: " & result

#=======================================
# Methods
#=======================================

proc execForeignMethod*(path: string, meth: string, params: ValueArray = @[], expected: ValueKind = Nothing): Value =
    result = VNULL

    let lib = loadLibrary(resolveLibrary(path))

    case expected
        of Nothing:
            echo "expecting :NOTHING"
            if params.len==0:
                callFunc0(V_V_Caller)
            elif params.len==1:
                case params[0].kind
                    of Integer: callFunc1(I_V_Caller, params[0].i)
                    of Floating: callFunc1(F_V_Caller, params[0].f)
                    of String: callFunc1(S_V_Caller, cstring(params[0].s))
                    else: discard
            elif params.len==2:
                case params[0].kind
                    of Integer: 
                        case params[1].kind
                            of Integer: callFunc2(II_V_Caller, params[0].i, params[1].i)
                            of Floating: callFunc2(IF_V_Caller, params[0].i, params[1].f)
                            of String: callFunc2(IS_V_Caller, params[0].i, cstring(params[1].s))
                            else: discard
                    of Floating:
                        case params[1].kind
                            of Integer: callFunc2(FI_V_Caller, params[0].f, params[1].i)
                            of Floating: callFunc2(FF_V_Caller, params[0].f, params[1].f)
                            of String: callFunc2(FS_V_Caller, params[0].f, cstring(params[1].s))
                            else: discard
                    of String: 
                        case params[1].kind
                            of Integer: callFunc2(SI_V_Caller, cstring(params[0].s), params[1].i)
                            of Floating: callFunc2(SF_V_Caller, cstring(params[0].s), params[1].f)
                            of String: callFunc2(SS_V_Caller, cstring(params[0].s), cstring(params[1].s))
                            else: discard
                    else: discard

        of Integer:
            echo "expecting :INTEGER"
            if params.len==0:
                result = newInteger(callFunc0(V_I_Caller))
            elif params.len==1:
                case params[0].kind
                    of Integer: 
                        echo "with param[0] as :INTEGER"
                        result = newInteger(callFunc1(I_I_Caller, params[0].i))
                        echo "got: " & $(result)
                        let point = callFunc1(I_P_Caller, params[0].i)
                        echo "got: " & $(cast[int](point))
                    of Floating: result = newInteger(callFunc1(F_I_Caller, params[0].f))
                    of String: result = newInteger(callFunc1(S_I_Caller, cstring(params[0].s)))
                    else: discard
            elif params.len==2:
                case params[0].kind
                    of Integer: 
                        case params[1].kind
                            of Integer: result = newInteger(callFunc2(II_I_Caller, params[0].i, params[1].i))
                            of Floating: result = newInteger(callFunc2(IF_I_Caller, params[0].i, params[1].f))
                            of String: result = newInteger(callFunc2(IS_I_Caller, params[0].i, cstring(params[1].s)))
                            else: discard
                    of Floating:
                        case params[1].kind
                            of Integer: result = newInteger(callFunc2(FI_I_Caller, params[0].f, params[1].i))
                            of Floating: result = newInteger(callFunc2(FF_I_Caller, params[0].f, params[1].f))
                            of String: result = newInteger(callFunc2(FS_I_Caller, params[0].f, cstring(params[1].s)))
                            else: discard
                    of String: 
                        case params[1].kind
                            of Integer: result = newInteger(callFunc2(SI_I_Caller, cstring(params[0].s), params[1].i))
                            of Floating: result = newInteger(callFunc2(SF_I_Caller, cstring(params[0].s), params[1].f))
                            of String: result = newInteger(callFunc2(SS_I_Caller, cstring(params[0].s), cstring(params[1].s)))
                            else: discard
                    else: discard

        of Floating:
            if params.len==0:
                result = newFloating(callFunc0(V_F_Caller))
            elif params.len==1:
                case params[0].kind
                    of Integer: result = newFloating(callFunc1(I_F_Caller, params[0].i))
                    of Floating: result = newFloating(callFunc1(F_F_Caller, params[0].f))
                    of String: result = newFloating(callFunc1(S_F_Caller, cstring(params[0].s)))
                    else: discard
            elif params.len==2:
                case params[0].kind
                    of Integer: 
                        case params[1].kind
                            of Integer: result = newFloating(callFunc2(II_F_Caller, params[0].i, params[1].i))
                            of Floating: result = newFloating(callFunc2(IF_F_Caller, params[0].i, params[1].f))
                            of String: result = newFloating(callFunc2(IS_F_Caller, params[0].i, cstring(params[1].s)))
                            else: discard
                    of Floating:
                        case params[1].kind
                            of Integer: result = newFloating(callFunc2(FI_F_Caller, params[0].f, params[1].i))
                            of Floating: result = newFloating(callFunc2(FF_F_Caller, params[0].f, params[1].f))
                            of String: result = newFloating(callFunc2(FS_F_Caller, params[0].f, cstring(params[1].s)))
                            else: discard
                    of String: 
                        case params[1].kind
                            of Integer: result = newFloating(callFunc2(SI_F_Caller, cstring(params[0].s), params[1].i))
                            of Floating: result = newFloating(callFunc2(SF_F_Caller, cstring(params[0].s), params[1].f))
                            of String: result = newFloating(callFunc2(SS_F_Caller, cstring(params[0].s), cstring(params[1].s)))
                            else: discard
                    else: discard

        of String:
            echo "expecting :STRING"
            if params.len==0:
                result = newString(callFunc0(V_S_Caller))
            elif params.len==1:
                case params[0].kind
                    of Integer: result = newString(callFunc1(I_S_Caller, params[0].i))
                    of Floating: result = newString(callFunc1(F_S_Caller, params[0].f))
                    of String: 
                        result = newString(callFunc1(S_S_Caller, cstring(params[0].s)))
                        echo "got: " & $(result)
                        let point = callFunc1(S_P_Caller, cstring(params[0].s))
                        echo "got: " & $(cast[int](point))
                        echo "got: " & $(cast[cstring](point))
                    else: discard
            elif params.len==2:
                case params[0].kind
                    of Integer: 
                        case params[1].kind
                            of Integer: result = newString(callFunc2(II_S_Caller, params[0].i, params[1].i))
                            of Floating: result = newString(callFunc2(IF_S_Caller, params[0].i, params[1].f))
                            of String: result = newString(callFunc2(IS_S_Caller, params[0].i, cstring(params[1].s)))
                            else: discard
                    of Floating:
                        case params[1].kind
                            of Integer: result = newString(callFunc2(FI_S_Caller, params[0].f, params[1].i))
                            of Floating: result = newString(callFunc2(FF_S_Caller, params[0].f, params[1].f))
                            of String: result = newString(callFunc2(FS_S_Caller, params[0].f, cstring(params[1].s)))
                            else: discard
                    of String: 
                        case params[1].kind
                            of Integer: result = newString(callFunc2(SI_S_Caller, cstring(params[0].s), params[1].i))
                            of Floating: result = newString(callFunc2(SF_S_Caller, cstring(params[0].s), params[1].f))
                            of String: result = newString(callFunc2(SS_S_Caller, cstring(params[0].s), cstring(params[1].s)))
                            else: discard
                    else: discard

        else: discard

    unloadLibrary(lib)
