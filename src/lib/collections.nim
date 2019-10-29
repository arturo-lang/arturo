#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/collection.nim
  *****************************************************************]#

import random

#[######################################################
    Functions
  ======================================================]#

proc Collections_Filter*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    result = valueFromArray(A(0).filter(proc(x: Value): bool = FN(1).execute(x).b))

proc Collections_Shuffle*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    randomize()
    result = valueFromArray(A(0))
    shuffle(result.a)

proc Collections_Size*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    case v[0].kind
        of AV: result = valueFromInteger(A(0).len)
        of SV: result = valueFromInteger(S(0).len)
        of DV: result = valueFromInteger(D(0).len)
        else: discard

proc Collections_Slice*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    case v[0].kind
        of AV: 
            if v.len==3: result = valueFromArray(A(0)[I(1)..I(2)])
            else: result = valueFromArray(A(0)[I(1)..^1])
        of SV: 
            if v.len==3: result = valueFromString(S(0)[I(1)..I(2)])
            else: result = valueFromString(S(0)[I(1)..^1])
        else: discard