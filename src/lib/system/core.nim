#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/core.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Core_and*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("and",[BV,IV])

    case v0.kind
        of BV:
            if not v0.b: return FALSE
            if xl.list[1].validate("and",[BV]).b: return TRUE
            else: return FALSE
        of IV:
            result = INT(bitand(v0.i, xl.list[1].validate("and",[IV]).i))
        else: discard

proc Core_get*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("get", f.req)

    case v[0].kind
        of arrayValue: result = A(0)[I(1)]
        of dictionaryValue: result = D(0).getValueForKey(S(1))
        else: result = NULL

proc Core_input*[F,X,V](f: F, xl: X): V {.inline.} =
    result = STR(readLine(stdin))

proc Core_if*[F,X,V](f: F, xl: X): V {.inline.} =
    if xl.list[0].validate("if",[BV]).b:
        result = xl.list[1].validate("if",[FV]).f.execute(NULL)
    else:
        if xl.list.len == 3:
            result = xl.list[2].validate("if",[FV]).f.execute(NULL)
        else:
            result = FALSE

proc Core_loop*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("loop", f.req)

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

proc Core_not*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("not",[BV,IV])

    case v0.kind
        of BV:
            if v0.b: result = FALSE
            else: result = TRUE
        of IV:
            result = INT(bitnot(v0.i))
        else: discard

proc Core_or*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("or",[BV,IV])

    case v0.kind
        of BV:
            if v0.b: return TRUE
            if xl.list[1].validate("or",[BV]).b: return TRUE
            else: return FALSE
        of IV:
            result = INT(bitor(v0.i, xl.list[1].validate("or",[IV]).i))
        else: discard

proc Core_panic*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("panic", f.req)

    ProgramPanic(S(0))

proc Core_print*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("print", f.req)

    echo v[0].stringify(quoted=false)
    result = v[0]

proc Core_range*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("range", f.req)

    if I(0)<I(1):    
        result = ARR(toSeq(I(0)..I(1)).map((x) => INT(x)))
    else:
        result = ARR(toSeq(countdown(I(0),I(1))).map((x) => INT(x)))    

proc Core_return*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("return", f.req)

    var ret = newException(ReturnValue, "return")
    ret.value = v[0]

    raise ret

proc Core_Xor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("xor",[BV,IV])

    case v0.kind
        of BV:
            let v1 = xl.list[1].validate("xor",[BV])
            if (v0.b and (not v1.b)) or ((not v0.b) and v1.b):
                result = TRUE
            else:
                result = FALSE
        of IV:
            result = INT(bitxor(v0.i, xl.list[1].validate("xor",[IV]).i))
        else: discard

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/core":

        test "and":
            check(eq( callFunction("and",@[TRUE,TRUE]), TRUE ))
            check(eq( callFunction("and",@[TRUE,FALSE]), FALSE ))
            check(eq( callFunction("and",@[FALSE,TRUE]), FALSE ))
            check(eq( callFunction("and",@[FALSE,FALSE]), FALSE ))
            check(eq( callFunction("and",@[INT(10),INT(3)]), INT(2) ))

        test "get":
            check(eq( callFunction("get",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0)]), INT(1) ))

        test "not":
            check(eq( callFunction("not",@[TRUE]), FALSE ))
            check(eq( callFunction("not",@[FALSE]), TRUE ))

        test "or":
            check(eq( callFunction("or",@[TRUE,TRUE]), TRUE ))
            check(eq( callFunction("or",@[TRUE,FALSE]), TRUE ))
            check(eq( callFunction("or",@[FALSE,TRUE]), TRUE ))
            check(eq( callFunction("or",@[FALSE,FALSE]), FALSE ))
            check(eq( callFunction("or",@[INT(10),INT(3)]), INT(11) ))

        test "print":
            check(eq( callFunction("print",@[STR("done")]), STR("done") ))

        test "xor":
            check(eq( callFunction("xor",@[TRUE,TRUE]), FALSE ))
            check(eq( callFunction("xor",@[TRUE,FALSE]), TRUE ))
            check(eq( callFunction("xor",@[FALSE,TRUE]), TRUE ))
            check(eq( callFunction("xor",@[FALSE,FALSE]), FALSE ))
            check(eq( callFunction("xor",@[INT(10),INT(3)]), INT(9) ))
