######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/ffi.nim
######################################################

# TODO(Helpers/ffi) Re-visit & re-implement the whole thing
#  Current, this "works". However, even if it works, it's not the best way to do it. Plus, we're totally limited regarding what type of functions we can "import".
#  labels: helpers, enhancement, cleanup, open discussion

when not defined(WEB):
    #=======================================
    # Libraries
    #=======================================

    import dynlib, os, strutils

    import vm/[errors, values/value]

    #=======================================
    # Types
    #=======================================

    # The most stupid hack of the century
    # but it kinda works - better than nothing!

    type
        V_Caller*      = proc():pointer                         {.nimcall.}
        I_Caller*      = proc(a: int):pointer                   {.nimcall.}
        F_Caller*      = proc(a: float):pointer                 {.nimcall.}
        S_Caller*      = proc(a: cstring):pointer               {.nimcall.}
        II_Caller*     = proc(a: int, b:int):pointer            {.nimcall.}
        IF_Caller*     = proc(a: int, b: float):pointer         {.nimcall.}
        IS_Caller*     = proc(a: int, b:cstring):pointer        {.nimcall.}
        FI_Caller*     = proc(a: float, b:int):pointer          {.nimcall.}
        FF_Caller*     = proc(a: float, b:float):pointer        {.nimcall.}
        FS_Caller*     = proc(a: float, b:cstring):pointer      {.nimcall.}
        SI_Caller*     = proc(a: cstring, b:int):pointer        {.nimcall.}
        SF_Caller*     = proc(a: cstring, b:float):pointer      {.nimcall.}
        SS_Caller*     = proc(a: cstring, b:cstring):pointer    {.nimcall.}

    #=======================================
    # Helpers
    #=======================================

    proc loadLibrary*(path: string): LibHandle =
        result = loadLib(path)

        if result == nil:
            RuntimeError_LibraryNotLoaded(path)

    proc unloadLibrary*(lib: LibHandle) =
        unloadLib(lib)

    template checkRunner*(r: pointer):untyped =
        if r == nil:
            RuntimeError_LibrarySymbolNotFound(resolvedPath, meth)

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

    func resolveLibrary*(path: string): string =
        let (_, _, extension) = splitFile(path)
        if extension != "":
            result = path
        else:
            result = DynlibFormat % [path]

    func boolToInt*(v: Value): int =
        if v.b==True: result = 1
        else: result = 0

    #=======================================
    # Methods
    #=======================================

    proc execForeignMethod*(path: string, meth: string, params: ValueArray = @[], expected: ValueKind = Nothing): Value =
        try:
            # set result to :null
            result = VNULL

            # load library
            let resolvedPath = resolveLibrary(path)
            let lib = loadLibrary(resolvedPath)

            # the variable that will store 
            # the return value from the function
            var got: pointer

            # execute given method
            # depending on the params given

            if params.len==0:
                got = callFunc0(V_Caller)
            elif params.len==1:
                case params[0].kind
                    of Logical      :   got = callFunc1(I_Caller, boolToInt(params[0]))
                    of Integer      :   got = callFunc1(I_Caller, params[0].i)
                    of Floating     :   got = callFunc1(F_Caller, params[0].f)
                    of String       :   got = callFunc1(S_Caller, cstring(params[0].s))
                    else: discard
            elif params.len==2:
                case params[0].kind
                    of Logical: 
                        case params[1].kind
                            of Logical      :   got = callFunc2(II_Caller, boolToInt(params[0]), boolToInt(params[1]))
                            of Integer      :   got = callFunc2(II_Caller, boolToInt(params[0]), params[1].i)
                            of Floating     :   got = callFunc2(IF_Caller, boolToInt(params[0]), params[1].f)
                            of String       :   got = callFunc2(IS_Caller, boolToInt(params[0]), cstring(params[1].s))
                            else: discard
                    of Integer: 
                        case params[1].kind
                            of Logical      :   got = callFunc2(II_Caller, params[0].i, boolToInt(params[1]))
                            of Integer      :   got = callFunc2(II_Caller, params[0].i, params[1].i)
                            of Floating     :   got = callFunc2(IF_Caller, params[0].i, params[1].f)
                            of String       :   got = callFunc2(IS_Caller, params[0].i, cstring(params[1].s))
                            else: discard
                    of Floating:
                        case params[1].kind
                            of Logical      :   got = callFunc2(FI_Caller, params[0].f, boolToInt(params[1]))
                            of Integer      :   got = callFunc2(FI_Caller, params[0].f, params[1].i)
                            of Floating     :   got = callFunc2(FF_Caller, params[0].f, params[1].f)
                            of String       :   got = callFunc2(FS_Caller, params[0].f, cstring(params[1].s))
                            else: discard
                    of String: 
                        case params[1].kind
                            of Logical      :   got = callFunc2(SI_Caller, cstring(params[0].s), boolToInt(params[1]))
                            of Integer      :   got = callFunc2(SI_Caller, cstring(params[0].s), params[1].i)
                            of Floating     :   got = callFunc2(SF_Caller, cstring(params[0].s), params[1].f)
                            of String       :   got = callFunc2(SS_Caller, cstring(params[0].s), cstring(params[1].s))
                            else: discard
                    else: discard
            else: discard

            # convert returned value
            # depending on what's expected

            case expected
                of Logical:
                    result = newLogical(cast[int](got))

                of Integer:
                    result = newInteger(cast[int](got))
                
                of Floating:
                    result = newFloating(cast[float](got))

                of String:
                    result = newString(cast[cstring](got))

                else: discard

            # unload the library
            unloadLibrary(lib)

        except VMError as e:
            raise e

        except:
            RuntimeError_ErrorLoadingLibrarySymbol(path, meth)
