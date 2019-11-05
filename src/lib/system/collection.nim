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

proc Collection_append*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("append", f.req)

    case v[0].kind
        of AV: result = ARR(A(0) & v[1])
        of SV: result = STR(S(0) & S(1))
        else: discard

proc Collection_appendI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("append!", f.req)

    case v[0].kind
        of AV: 
            A(0).add(v[1])
            result = v[0]
        of SV: 
            S(0).add(S(1))
            result = v[0]
        else: discard

proc Collection_size*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("size", f.req)

    case v[0].kind
        of AV: result = INT(A(0).len)
        of SV: result = INT(S(0).len)
        of DV: result = INT(D(0).list.len)
        else: discard
