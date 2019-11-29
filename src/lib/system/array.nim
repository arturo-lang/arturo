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
    let v0 = VALID(0,AV)

    if xl.list.len==1:
        var i = 0
        while i < A(v0).len:
            if not B(A(v0)[i]): return FALSE
            inc(i)
        result = TRUE
    else:
        let v1 = VALID(1,FV)
        var i = 0
        while i < A(v0).len:
            if not B(FN(v1).execute(A(v0)[i])): return FALSE
            inc(i)
        result = TRUE

proc Array_any*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    if xl.list.len==1:
        var i = 0
        while i < A(v0).len:
            if B(A(v0)[i]): return TRUE
            inc(i)
        result = FALSE
    else:
        let v1 = VALID(1,FV)
        var i = 0
        while i < A(v0).len:
            if not B(FN(v1).execute(A(v0)[i])): return TRUE
            inc(i)
        result = FALSE

proc Array_count*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)
    let v1 = VALID(1,FV)

    var cnt = 0
    var i = 0
    while i < A(v0).len:
        if B(FN(v1).execute(A(v0)[i])):
            inc(cnt)
        inc(i)

    result = SINT(cnt)

proc Array_first*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    if xl.list.len==1:
        result = A(v0)[0]
    else:
        result = ARR(A(v0)[0..I(VALID(1,IV))-1])

proc Array_filter*[F,X,V](f: F, xl: X): V {.inline.} =
    let v1 = VALID(1,FV)
    result = ARR(A(VALID(0,AV)).filter((x) => B(FN(v1).execute(x))))

proc Array_filterI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        let v1 = VALID(1,FV)
        A(DEST).keepIf((x) => B(FN(v1).execute(x)))
        return DEST

    # let v0 = VALID(0,AV)
    # let v1 = VALID(1,FV)
    # A(v0).keepIf((x) => B(FN(v1).execute(x)))

    # result = v0

proc Array_fold*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)
    let v2 = VALID(2,FV)

    result = VALID(1,ANY)
    var i = 0
    while i<A(v0).len:
        result = FN(v2).execute(ARR(@[result,A(v0)[i]]))
        inc(i)

proc Array_last*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    if xl.list.len==1:
        result = A(v0)[^1]
    else:
        result = ARR(A(v0)[A(v0).len-I(VALID(1,IV))..^1])

proc Array_map*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)
    let v1 = VALID(1,FV)

    result = ARR(A(v0).map((x) => FN(v1).execute(x)))

proc Array_mapI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        let v1 = VALID(1,FV)
        A(DEST).apply((x) => FN(v1).execute(x))
        return DEST
    # let v0 = VALID(0,AV)
    # let v1 = VALID(1,FV)

    # A(v0).apply((x) => FN(v1).execute(x))

    # result = v0

proc Array_permutations*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    var ret: seq[Value]
 
    permutate(A(v0), proc(s: seq[Value])= 
        ret.add(ARR(s))
    )

    result = ARR(ret)

proc Array_pop*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = A(v0)[^1]

proc Array_popI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        return A(DEST).pop()
        
    # let v0 = VALID(0,AV)

    # result = A(v0).pop()

proc Array_range*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV)
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

proc Array_rangeBy*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV)
    let v1 = VALID(1,IV)
    let v2 = VALID(2,IV)

    if I(v0)<I(v1):   
        result = ARR(@[])
        var i = I(v0)
        while i <= I(v1):
            A(result).add(SINT(i))
            inc(i,I(v2))
    else:
        result = ARR(@[])
        var i = I(v0)
        while i >= I(v1):
            A(result).add(SINT(i))
            dec(i,I(v2))   

proc Array_rotate*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    let step = 
        if xl.list.len==2: (-1)*I(VALID(1,IV))
        else: -1

    result = ARR(A(v0).rotatedLeft(step))

proc Array_rotateI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        let step = 
            if xl.list.len==2: (-1)*I(VALID(1,IV))
            else: -1

        A(DEST).rotateLeft(step)    
        return DEST

    # let v0 = VALID(0,AV)

    # let step = 
    #     if xl.list.len==2: (-1)*I(VALID(1,IV))
    #     else: -1

    # A(v0).rotateLeft(step)
    # result = v0

proc Array_sample*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = sample(A(v0))

proc Array_shuffle*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = ARR(A(v0))
    shuffle(A(result))

proc Array_shuffleI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        randomize()
        shuffle(A(DEST))
        return DEST

    # let v0 = VALID(0,AV)

    # randomize()
    # result = v0
    # shuffle(A(result))

proc Array_sort*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    proc opCmp(l: Value, r: Value): int =
        if (l.lt(r) or l.eq(r)): -1
        else: 1

    result = ARR(A(v0).sorted(opCmp))

proc Array_sortI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        proc opCmp(l: Value, r: Value): int =
            if (l.lt(r) or l.eq(r)): -1
            else: 1

        A(DEST).sort(opCmp)  
        return DEST
    # let v0 = VALID(0,AV)

    # proc opCmp(l: Value, r: Value): int =
    #     if (l.lt(r) or l.eq(r)): -1
    #     else: 1

    # A(v0).sort(opCmp)
    # result = v0

proc Array_sortBy*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)
    let v1 = VALID(1,FV)

    proc opCmp(l: Value, r: Value): int =
        let lv = FN(v1).execute(l)
        let rv = FN(v1).execute(r)

        if (lv.lt(rv) or lv.eq(rv)): -1
        else: 1

    result = ARR(A(v0).sorted(opCmp))

proc Array_sortByI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        let v1 = VALID(1,FV)

        proc opCmp(l: Value, r: Value): int =
            let lv = FN(v1).execute(l)
            let rv = FN(v1).execute(r)

            if (lv.lt(rv) or lv.eq(rv)): -1
            else: 1

        A(DEST).sort(opCmp)
        return DEST
    # let v0 = VALID(0,AV)
    # let v1 = VALID(1,FV)

    # proc opCmp(l: Value, r: Value): int =
    #     let lv = FN(v1).execute(l)
    #     let rv = FN(v1).execute(r)

    #     if (lv.lt(rv) or lv.eq(rv)): -1
    #     else: 1

    # A(v0).sort(opCmp)
    # result = v0

proc Array_swap*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)
    let v1 = VALID(1,IV)
    let v2 = VALID(2,IV)

    result = ARR(A(v0))
    swap(A(result)[I(v1)], A(result)[I(v2)])

proc Array_swapI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        let v1 = VALID(1,IV)
        let v2 = VALID(2,IV)

        swap(A(DEST)[I(v1)],A(DEST)[I(v2)])
        return DEST
    # let v0 = VALID(0,AV)
    # let v1 = VALID(1,IV)
    # let v2 = VALID(2,IV)

    # swap(A(v0)[I(v1)], A(v0)[I(v2)])
    # result = v0

proc Array_unique*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    result = ARR(@[])

    var i = 0
    while i < A(v0).len:
        if findValueInArray(A(result), A(v0)[i])==(-1):
            A(result).add(A(v0)[i])
        inc(i)

proc Array_uniqueI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        var ret = ARR(@[])

        var i = 0
        while i < A(DEST).len:
            if findValueInArray(A(ret), A(DEST)[i])==(-1):
                A(ret).add(A(DEST)[i])
            inc(i)

        A(DEST) = A(ret)
    # let v0 = VALID(0,AV)

    # result = ARR(@[])

    # var i = 0
    # while i < A(v0).len:
    #     if findValueInArray(A(result), A(v0)[i])==(-1):
    #         A(result).add(A(v0)[i])
    #     inc(i)

    # A(v0) = A(result)

proc Array_zip*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)
    let v1 = VALID(1,AV)

    result = ARR(@[])
    let m = min(A(v0).len, A(v1).len)
    newSeq(A(result),m)

    var i = 0
    while i <= m:
        A(result)[i] = ARR(@[A(v0)[i], A(v1)[i]])
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
