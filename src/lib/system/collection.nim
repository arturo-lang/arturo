#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/collection.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Collection_size*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("size", f.req)

    case v[0].kind
        of AV: result = INT(A(0).len)
        of SV: result = INT(S(0).len)
        of DV: result = INT(D(0).list.len)
        else: discard