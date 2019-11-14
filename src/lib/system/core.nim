#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/core.nim
  * @description: core operations
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Core_exec*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = FN(0).execute(v[1])

proc Core_if*[F,X,V](f: F, xl: X): V {.inline.} =
    if xl.list[0].validate("if",[BV]).b:
        result = xl.list[1].validate("if",[FV]).f.execute(NULL)
    else:
        if xl.list.len == 3:
            result = xl.list[2].validate("if",[FV]).f.execute(NULL)
        else:
            result = FALSE

proc Core_import*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    result = importModule(S(0))

proc Core_loop*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV:
            var i = 0
            while i < A(0).len:
                result = FN(1).execute(A(0)[i])
                inc(i)
        of DV:
            for val in D(0).list:
                result = FN(1).execute(ARR(@[STR(val[0]),val[1]]))
        of BV:
            if not B(0): return NULL
            while true:
                result = FN(1).execute(NULL)
                if not xl.list[0].evaluate().b: break
        of IV:
            var i = 0
            while i < I(0):
                result = FN(1).execute(NULL)
                inc(i)

        else: result = NULL

proc Core_new*[F,X,V](f: F, xl: X): V {.inline.} =
    let v =  xl.validate(f)

    result = valueCopy(v[0])

proc Core_panic*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    ProgramPanic(S(0))

proc Core_return*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var ret = newException(ReturnValue, "return")
    ret.value = v[0]

    raise ret

proc Core_syms*[F,X,V](f: F, xl: X): V {.inline.} =
    inspectStack()

    result = NULL

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/core":
    