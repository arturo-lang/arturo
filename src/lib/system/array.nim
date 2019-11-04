#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/array.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Array_filter*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("filter", f.req)

    result = ARR(A(0).filter(proc(x: Value): bool = FN(1).execute(x).b))

proc Array_shuffle*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("shuffle", f.req)

    randomize()
    result = ARR(A(0))
    shuffle(result.a)

proc Array_slice*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("slice", f.req)

    case v[0].kind
        of AV: 
            if v.len==3: result = ARR(A(0)[I(1)..I(2)])
            else: result = ARR(A(0)[I(1)..^1])
        of SV: 
            if v.len==3: result = STR(S(0)[I(1)..I(2)])
            else: result = STR(S(0)[I(1)..^1])
        else: discard