#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/array.nim
  * @description: Array/List manipulation
  *****************************************************************]#

#[######################################################
    Helpers
  ======================================================]#

proc permutate*(s: seq[Value], emit: proc(emit:seq[Value]) ) =
    var s = @s
    if s.len == 0: 
        emit(s)
        return
 
    var rc : proc(np: int)
    rc = proc(np: int) = 
 
        if np == 1: 
            emit(s)
            return
 
        var 
            np1 = np - 1
            pp = s.len - np1
 
        rc(np1) # recurs prior swaps
 
        for i in countDown(pp, 1):
            swap s[i], s[i-1]
            rc(np1) # recurs swap 
 
        let w = s[0]
        s[0..<pp] = s[1..pp]
        s[pp] = w
 
    rc(s.len)

#[######################################################
    Functions
  ======================================================]#

#**********************************************
# @example: all
# if [all #(true 2>1)] { print "yep" }
# #= yep
#**********************************************

proc Array_all*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v.len==1:
        var i = 0
        while i < A(v[0]).len:
            if not B(A(v[0])[i]): return FALSE
            inc(i)
        result = TRUE
    else:
        var i = 0
        while i < A(v[0]).len:
            if not B(FN(v[1]).execute(A(v[0])[i])): return FALSE
            inc(i)
        result = TRUE

proc Array_any*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v.len==1:
        var i = 0
        while i < A(v[0]).len:
            if B(A(v[0])[i]): return TRUE
            inc(i)
        result = FALSE
    else:
        var i = 0
        while i < A(v[0]).len:
            if not B(FN(v[1]).execute(A(v[0])[i])): return TRUE
            inc(i)
        result = FALSE

proc Array_count*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var cnt = 0
    var i = 0
    while i < A(v[0]).len:
        if B(FN(v[1]).execute(A(v[0])[i])):
            inc(cnt)
        inc(i)

    result = SINT(cnt)

proc Array_first*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = A(v[0])[0]

proc Array_filter*[F,X,V](f: F, xl: X): V {.inline.} =
    result = ARR(A(VALID(0,AV)).filter((x) => B(FN(VALID(1,FV)).execute(x))))

proc Array_filterI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    #A(v[0]).keepIf((x) => B(FN(v[1]).execute(x)))

    result = v[0]

proc Array_fold*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = v[1]

    var i = 0
    while i<A(v[0]).len:
        result = FN(v[2]).execute(ARR(@[result,A(v[0])[i]]))
        inc(i)

proc Array_last*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = A(v[0])[^1]

proc Array_map*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = ARR(A(v[0]).map((x) => FN(v[1]).execute(x)))

proc Array_mapI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    #A(v[0]).apply((x) => FN(v[1]).execute(x))

    result = v[0]

proc Array_permutations*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var ret: seq[Value]
 
    permutate(A(v[0]), proc(s: seq[Value])= 
        ret.add(ARR(s))
    )

    result = ARR(ret)

proc Array_pop*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = A(v[0])[^1]

proc Array_popI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    #result = A(v[0]).pop()

proc Array_range*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV)#xl.validate(f)
    let v1 = VALID(1,IV)

    if I(v0)<I(v1): 
        var ret: seq[Value]
        var i = I(v0)
        while i <= I(v1):
            ret.add(SINT(i))
            inc(i)

        result = ARR(ret)
    else:
        var ret: seq[Value]
        var i = I(v0)
        while i >= I(v1):
            ret.add(SINT(i))
            dec(i)

        result = ARR(ret)

    # if I(v[0])<I(v[1]):   
    #     result = ARR(@[])
    #     var i = I(v[0])
    #     while i <= I(v[1]):
    #         A(result).add(SINT(i))
    #         inc(i)
    # else:
    #     result = ARR(@[])
    #     var i = I(v[0])
    #     while i >= I(v[1]):
    #         result.a.add(INT(i))
    #         dec(i)    

proc Array_rangeBy*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    # if I(v[0])<I(v[1]):   
    #     result = ARR(@[])
    #     var i = I(v[0])
    #     while i <= I(v[1]):
    #         result.a.add(INT(i))
    #         inc(i,I(v[2]))
    # else:
    #     result = ARR(@[])
    #     var i = I(v[0])
    #     while i >= I(v[1]):
    #         result.a.add(INT(i))
    #         dec(i,I(v[2]))   

proc Array_rotate*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let step = 
        if v.len==2: (-1)*I(v[1])
        else: -1

    result = ARR(A(v[0]).rotatedLeft(step))

proc Array_rotateI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    # let step = 
    #     if v.len==2: (-1)*I(v[1])
    #     else: -1

    # A(v[0]).rotateLeft(step)
    result = v[0]

proc Array_sample*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    randomize()
    result = sample(A(v[0]))

proc Array_shuffle*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    randomize()
    result = ARR(A(v[0]))
    #shuffle(result.a)

proc Array_shuffleI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    # randomize()
    # result = v[0]
    # shuffle(result.a)

proc Array_sort*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    proc opCmp(l: Value, r: Value): int =
        if (l.lt(r) or l.eq(r)): -1
        else: 1

    result = ARR(A(v[0]).sorted(opCmp))

proc Array_sortI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    # proc opCmp(l: Value, r: Value): int =
    #     if (l.lt(r) or l.eq(r)): -1
    #     else: 1

    # A(v[0]).sort(opCmp)
    # result = v[0]

proc Array_swap*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = ARR(A(v[0]))
    #swap(A(result)[I(v[1])], A(result)[I(v[2])])

proc Array_swapI*[F,X,V](f: F, xl: X): V {.inline.} =
    #let v = xl.validate(f)
    let v0 = VALID(0,AV)#xl.list[0].validate("swap!",AV)
    let v1 = VALID(1,IV)#xl.list[1].validate("swap!",IV)
    let v2 = VALID(2,IV)#xl.list[2].validate("swap!",IV)
    swap(A(v0)[I(v1)], A(v0)[I(v2)])

    result = v0 # [0]

proc Array_unique*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = ARR(@[])

    # var i = 0
    # while i < A(v[0]).len:
    #     if findValueInArray(result.a, A(v[0])[i])==(-1):
    #         result.a.add(A(v[0])[i])
    #     inc(i)

proc Array_uniqueI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = ARR(@[])

    # var i = 0
    # while i < A(v[0]).len:
    #     if findValueInArray(result.a, A(v[0])[i])==(-1):
    #         result.a.add(A(v[0])[i])
    #     inc(i)

    # A(v[0]) = result.a

proc Array_zip*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = ARR(@[])
    # let m = min(A(v[0]).len, A(v[1]).len)
    # newSeq(result.a,m)

    # var i = 0
    # while i <= m:
    #     result.a[i] = ARR(@[A(v[0])[i], A(v[1])[i]])
    #     inc(i)

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
