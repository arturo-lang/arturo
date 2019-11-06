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

proc Array_all*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("all", f.req)

    if v.len==1:
        var i = 0
        while i < A(0).len:
            if not A(0)[i].b: return FALSE
            inc(i)
        result = TRUE
    else:
        var i = 0
        while i < A(0).len:
            if not FN(1).execute(A(0)[i]).b: return FALSE
            inc(i)
        result = TRUE

proc Array_any*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("any", f.req)

    if v.len==1:
        var i = 0
        while i < A(0).len:
            if A(0)[i].b: return TRUE
            inc(i)
        result = FALSE
    else:
        var i = 0
        while i < A(0).len:
            if not FN(1).execute(A(0)[i]).b: return TRUE
            inc(i)
        result = FALSE

proc Array_filter*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("filter", f.req)

    result = ARR(A(0).filter((x) => FN(1).execute(x).b))

proc Array_filterI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("filter!", f.req)

    A(0).keepIf((x) => FN(1).execute(x).b)

    result = v[0]

proc Array_map*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("map", f.req)

    result = ARR(A(0).map((x) => FN(1).execute(x)))

proc Array_mapI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("map!", f.req)

    A(0).apply((x) => FN(1).execute(x))

    result = v[0]

proc Array_sample*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("sample", f.req)

    randomize()
    result = sample(A(0))

proc Array_shuffle*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("shuffle", f.req)

    randomize()
    result = ARR(A(0))
    shuffle(result.a)

proc Array_shuffleI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("shuffle!", f.req)

    randomize()
    result = v[0]
    shuffle(result.a)

proc Array_swap*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("swap", f.req)

    result = ARR(A(0))
    swap(result.a[I(1)], result.a[I(2)])

proc Array_swapI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("swap!", f.req)

    swap(A(0)[I(1)], A(0)[I(2)])

    result = v[0]

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/array":

        test "shuffle":
            check(not eq( callFunction("shuffle",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)])]), ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]) ))

        test "swap":
            check(eq( callFunction("swap",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0),INT(2)]), ARR(@[INT(3),INT(2),INT(1)]) ))
