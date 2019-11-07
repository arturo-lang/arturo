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

proc Array_first*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("first", f.req)

    result = A(0)[0]

proc Array_filter*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("filter", f.req)

    result = ARR(A(0).filter((x) => FN(1).execute(x).b))

proc Array_filterI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("filter!", f.req)

    A(0).keepIf((x) => FN(1).execute(x).b)

    result = v[0]

proc Array_last*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("last", f.req)

    result = A(0)[^1]

proc Array_map*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("map", f.req)

    result = ARR(A(0).map((x) => FN(1).execute(x)))

proc Array_mapI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("map!", f.req)

    A(0).apply((x) => FN(1).execute(x))

    result = v[0]

proc Array_pop*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("pop", f.req)

    result = A(0)[^1]

proc Array_popI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("pop!", f.req)

    result = A(0).pop()

proc Array_range*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("range", f.req)

    if I(0)<I(1):    
        result = ARR(toSeq(I(0)..I(1)).map((x) => INT(x)))
    else:
        result = ARR(toSeq(countdown(I(0),I(1))).map((x) => INT(x)))    

proc Array_rotate*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("rotate", f.req)

    let step = 
        if v.len==2: (-1)*I(1)
        else: -1

    result = ARR(A(0).rotatedLeft(step))

proc Array_rotateI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("rotate!", f.req)

    let step = 
        if v.len==2: (-1)*I(1)
        else: -1

    A(0).rotateLeft(step)
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

proc Array_sort*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("sort", f.req)

    proc opCmp(l: Value, r: Value): int =
        if (l.lt(r) or l.eq(r)): -1
        else: 1

    result = ARR(A(0).sorted(opCmp))

proc Array_sortI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("sort!", f.req)

    proc opCmp(l: Value, r: Value): int =
        if (l.lt(r) or l.eq(r)): -1
        else: 1

    A(0).sort(opCmp)
    result = v[0]

proc Array_swap*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("swap", f.req)

    result = ARR(A(0))
    swap(result.a[I(1)], result.a[I(2)])

proc Array_swapI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("swap!", f.req)

    swap(A(0)[I(1)], A(0)[I(2)])

    result = v[0]

proc Array_unique*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("unique", f.req)

    result = ARR(@[])

    var i = 0
    while i < A(0).len:
        if findValueInArray(result.a, A(0)[i])==(-1):
            result.a.add(A(0)[i])
        inc(i)

proc Array_uniqueI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("unique!", f.req)

    result = ARR(@[])

    var i = 0
    while i < A(0).len:
        if findValueInArray(result.a, A(0)[i])==(-1):
            result.a.add(A(0)[i])
        inc(i)

    A(0) = result.a

proc Array_zip*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("zip", f.req)

    result = ARR(@[])
    let m = min(A(0).len, A(1).len)
    newSeq(result.a,m)

    var i = 0
    while i <= m:
        result.a[i] = ARR(@[A(0)[i], A(1)[i]])
        inc(i)

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/array":

        test "all":
            check(eq( callFunction("all",@[ARR(@[TRUE,TRUE,TRUE])]), TRUE ))
            check(eq( callFunction("all",@[ARR(@[TRUE,TRUE,FALSE])]), FALSE ))

        test "any":
            check(eq( callFunction("any",@[ARR(@[TRUE,TRUE,TRUE])]), TRUE ))
            check(eq( callFunction("any",@[ARR(@[TRUE,TRUE,FALSE])]), TRUE ))
            check(eq( callFunction("any",@[ARR(@[FALSE,FALSE,FALSE])]), FALSE ))

        test "first":
            check(eq( callFunction("first",@[ARR(@[INT(1),INT(2),INT(3),INT(4)])]), INT(1) ))

        test "last":
            check(eq( callFunction("last",@[ARR(@[INT(1),INT(2),INT(3),INT(4)])]), INT(4) ))

        test "pop":
            check(eq( callFunction("pop",@[ARR(@[INT(1),INT(2),INT(3),INT(4)])]), INT(4) ))

        test "range":
            check(eq( callFunction("range",@[INT(0),INT(3)]), ARR(@[INT(0),INT(1),INT(2),INT(3)]) ))
            check(eq( callFunction("range",@[INT(3),INT(0)]), ARR(@[INT(3),INT(2),INT(1),INT(0)]) ))

        test "rotate":
            check(eq( callFunction("rotate",@[ARR(@[INT(1),INT(2),INT(3),INT(4)])]), ARR(@[INT(4),INT(1),INT(2),INT(3)]) ))
            check(eq( callFunction("rotate",@[ARR(@[INT(1),INT(2),INT(3),INT(4)]),INT(1)]), ARR(@[INT(4),INT(1),INT(2),INT(3)]) ))
            check(eq( callFunction("rotate",@[ARR(@[INT(1),INT(2),INT(3),INT(4)]),INT(-1)]), ARR(@[INT(2),INT(3),INT(4),INT(1)]) ))

        test "shuffle":
            check(not eq( callFunction("shuffle",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)])]), ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]) ))

        test "sort":
            check(eq( callFunction("sort",@[ARR(@[INT(5),INT(2),INT(1),INT(4),INT(3)])]), ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5)]) ))
            check(eq( callFunction("sort",@[ARR(@[STR("gamma"),STR("beta"),STR("alpha")])]), ARR(@[STR("alpha"),STR("beta"),STR("gamma")]) ))

        test "swap":
            check(eq( callFunction("swap",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0),INT(2)]), ARR(@[INT(3),INT(2),INT(1)]) ))

        test "unique":
            check(eq( callFunction("unique",@[ARR(@[INT(1),INT(2),INT(3),INT(2),INT(3),INT(1),INT(2),INT(3),INT(1)])]), ARR(@[INT(1),INT(2),INT(3)]) ))
            check(eq( callFunction("unique",@[ARR(@[INT(1),INT(2),INT(2),INT(2),INT(3),INT(3),INT(2),INT(3),INT(1)])]), ARR(@[INT(1),INT(2),INT(3)]) ))

        test "zip":
            check(eq( callFunction("zip",@[ARR(@[INT(1),INT(2),INT(3)]),ARR(@[STR("a"),STR("b")])]), ARR(@[ARR(@[INT(1),STR("a")]),ARR(@[INT(2),STR("b")])]) ))
