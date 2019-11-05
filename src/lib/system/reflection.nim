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
