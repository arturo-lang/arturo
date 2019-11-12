#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/generic.nim
  * @description: generic Array/Dictionary/String operations
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Generic_append*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = ARR(A(0) & v[1])
        of SV: result = STR(S(0) & S(1))
        else: discard

proc Generic_appendI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: 
            A(0).add(v[1])
            result = v[0]
        of SV: 
            S(0).add(S(1))
            result = v[0]
        else: discard

proc Generic_contains*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
         of AV: result = BOOL(findValueInArray(v[0],v[1])!=(-1))
         of SV: 
            if unlikely(S(0).isRegex()):
                result = BOOL(S(0).contains(re(prepareRegex(S(1)))))
            else:
                result = BOOL(S(0).contains(S(1)))
         of DV: result = BOOL(findValueInArray(D(0).values,v[1])!=(-1))
         else: discard

proc Generic_delete*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = v[0]-v[1]
        of SV: result = v[0]-v[1]
        of DV: result = v[0]-v[1]
        else: discard

proc Generic_deleteI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = v[0]-v[1]; v[0].a = result.a
        of SV: result = v[0]-v[1]; v[0].s = result.s
        of DV: result = v[0]-v[1]; v[0].d = result.d
        else: discard

proc Generic_deleteBy*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: 
            result = valueCopy(v[0])
            result.a.delete(I(1))
        of SV: 
            result = valueCopy(v[0])
            result.s.delete(I(1),I(1))
        of DV: 
            result = valueCopy(v[0])
            var i = 0
            while i < result.d.list.len:
                if result.d.list[i][0] == S(1):
                    result.d.list.del(i)
                inc(i)
        else: discard

proc Generic_deleteByI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: 
            A(0).delete(I(1))
            result = v[0]
        of SV: 
            S(0).delete(I(1),I(1))
            result = v[0]
        of DV: 
            var i = 0
            while i < D(0).list.len:
                if D(0).list[i][0] == S(1):
                    D(0).list.del(i)
                inc(i)
            result = v[0]
        else: discard

proc Generic_get*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = A(0)[I(1)]
        of DV: result = D(0).getValueForKey(S(1))
        of SV: result = STR($(S(0)[I(1)]))
        else: discard

proc Generic_isEmpty*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = BOOL(A(0).len==0)
        of DV: result = BOOL(D(0).list.len==0)
        of SV: result = BOOL(S(0).len==0)
        else: discard

proc Generic_reverse*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = ARR(A(0).reversed())
        of SV: 
            var ret = newString(S(0).len)
            var i = 0
            while i<S(0).len:
                ret[S(0).high-i] = S(0)[i]
                inc(i)
            
            result = STR(ret)
        else: discard

proc Generic_reverseI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: 
            A(0).reverse()
            result = v[0]
        of SV: 
            var i = 0
            while i<S(0).high div 2:
                swap(S(0)[i],S(0)[S(0).high - i])
                inc(i)
            
            result = v[0]
        else: discard

proc Generic_set*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: 
            result = valueCopy(v[0])
            result.a[I(1)] = v[2]
        of DV: 
            result = valueCopy(v[0])
            result.d.updateOrSet(S(1),v[2])
        of SV: 
            result = valueCopy(v[0])
            result.s[I(1)] = S(2)[0]
        else: discard

proc Generic_setI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: 
            A(0)[I(1)] = v[2]
            result = v[0]
        of DV: 
            D(0).updateOrSet(S(1),v[2])
            result = v[0]
        of SV: 
            S(0)[I(1)] = S(2)[0]
            result = v[0]
        else: discard

proc Generic_size*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = INT(A(0).len)
        of SV: result = INT(S(0).len)
        of DV: result = INT(D(0).list.len)
        else: discard

proc Generic_slice*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: 
            if v.len==3: result = ARR(A(0)[I(1)..I(2)])
            else: result = ARR(A(0)[I(1)..^1])
        of SV: 
            if v.len==3: result = STR(S(0)[I(1)..I(2)])
            else: result = STR(S(0)[I(1)..^1])
        else: discard

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/generic":

        test "append":
            check(eq( callFunction("append",@[STR("hello"),STR("world")]), STR("helloworld") ))
            check(eq( callFunction("append",@[ARR(@[INT(1),INT(2)]),INT(3)]), ARR(@[INT(1),INT(2),INT(3)]) ))

        test "contains":
            check(eq( callFunction("contains",@[STR("hello"),STR("hell")]), TRUE ))
            check(eq( callFunction("contains",@[STR("world"),STR("hell")]), FALSE ))
            check(eq( callFunction("contains",@[ARR(@[INT(1),INT(2)]),INT(2)]), TRUE ))
            check(eq( callFunction("contains",@[ARR(@[INT(1),INT(2)]),INT(3)]), FALSE ))

        test "delete":
            check(eq( callFunction("delete",@[STR("hello"),STR("l")]), STR("heo") ))
            check(eq( callFunction("delete",@[ARR(@[INT(1),INT(2),INT(3)]),INT(2)]), ARR(@[INT(1),INT(3)]) ))

        test "deleteBy":
            check(eq( callFunction("deleteBy",@[STR("hello"),INT(0)]), STR("ello") ))
            check(eq( callFunction("deleteBy",@[ARR(@[INT(1),INT(2),INT(3)]),INT(2)]), ARR(@[INT(1),INT(2)]) ))

        test "get":
            check(eq( callFunction("get",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0)]), INT(1) ))
            check(eq( callFunction("get",@[STR("hello"),INT(0)]), STR("h") ))

        test "isEmpty":
            check(eq( callFunction("isEmpty",@[STR("hello")]), FALSE ))
            check(eq( callFunction("isEmpty",@[STR("")]), TRUE ))
            check(eq( callFunction("isEmpty",@[ARR(@[INT(1),INT(2),INT(3)])]), FALSE ))
            check(eq( callFunction("isEmpty",@[ARR(@[])]), TRUE ))

        test "reverse":
            check(eq( callFunction("reverse",@[ARR(@[INT(1),INT(2),INT(3)])]), ARR(@[INT(3),INT(2),INT(1)]) ))

        test "set":
            check(eq( callFunction("set",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0),STR("one")]), ARR(@[STR("one"),INT(2),INT(3)]) ))
            check(eq( callFunction("set",@[STR("hello"),INT(0),STR("x")]), STR("xello") ))

        test "size":
            check(eq( callFunction("size",@[STR("hello")]), INT(5) ))
            check(eq( callFunction("size",@[ARR(@[INT(1),INT(2)])]), INT(2) ))

        test "slice":
            check(eq( callFunction("slice",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]),INT(0),INT(3)]), ARR(@[INT(1),INT(2),INT(3),INT(4)]) ))
