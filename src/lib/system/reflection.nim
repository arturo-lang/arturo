#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/reflection.nim
  * @description: runtime reflection
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Reflection_inspect*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,ANY)

    echo v0.inspect()
    result = v0

proc Reflection_isArray*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==AV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_isBigint*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==BIV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_isBool*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==BV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_isDict*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==DV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_isFunc*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==FV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_isInt*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==IV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_isNull*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==NV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_isReal*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==RV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_isString*[F,X,V](f: F, xl: X): V {.inline.} =
    if EVAL(0).kind==SV:
        result = TRUE
    else:
        result = FALSE

proc Reflection_type*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,ANY)

    result = STR(valueKindToPrintable(v0.kind))

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/reflection":

        test "type":
            check(eq( callFunction("type",@[INT(1)]), STR("int") ))
            check(eq( callFunction("type",@[BIGINT("1123131313123123131231231231231")]), STR("bigInt") ))
            check(eq( callFunction("type",@[STR("hello")]), STR("str") ))
            check(eq( callFunction("type",@[TRUE]), STR("bool") ))
            check(eq( callFunction("type",@[ARR(@[INT(1),INT(2),STR("boom")])]), STR("array") ))
