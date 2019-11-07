#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/reflection.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Reflection_inspect*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("inspect", f.req)

    echo v[0].inspect()
    result = v[0]

proc Reflection_type*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("type", f.req)

    result = STR(valueKindToPrintable($(v[0].kind)))

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
