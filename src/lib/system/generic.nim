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
        of AV: result = ARR(A(v[0]) & v[1])
        of SV: result = STR(S(v[0]) & S(v[1]))
        else: discard

proc Generic_appendI*[F,X,V](f: F, xl: X): V {.inline.} =
    #let v = xl.validate(f)
    let v0 = VALID(0,AV or SV)
    case v0.kind
        of AV: 
            A(v0).add(VALID(1,ANY))
            result = v0
        of SV: 
            S(v0).add(S(VALID(1,SV)))
            result = v0
        else: discard

proc Generic_contains*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
         of AV: result = BOOL(findValueInArray(v[0],v[1])!=(-1))
         of SV: 
            if unlikely(S(v[1]).isRegex()):
                result = BOOL(S(v[0]).contains(re(prepareRegex(S(v[1])))))
            else:
                result = BOOL(S(v[0]).contains(S(v[1])))
         of DV: result = BOOL(findValueInArray(D(v[0]).values,v[1])!=(-1))
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

    # case v[0].kind
    #     of AV: result = v[0]-v[1]; v[0].a = result.a
    #     of SV: result = v[0]-v[1]; v[0].s = result.s
    #     of DV: result = v[0]-v[1]; v[0].d = result.d
    #     else: discard

proc Generic_deleteBy*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    # case v[0].kind
    #     of AV: 
    #         result = valueCopy(v[0])
    #         result.a.delete(I(v[1]))
    #     of SV: 
    #         result = valueCopy(v[0])
    #         result.s.delete(I(v[1]),I(v[1]))
    #     of DV: 
    #         result = valueCopy(v[0])
    #         var i = 0
    #         while i < result.d.list.len:
    #             if result.d.list[i][0] == S(v[1]):
    #                 result.d.list.del(i)
    #             inc(i)
    #     else: discard

proc Generic_deleteByI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    # case v[0].kind
    #     of AV: 
    #         A(v[0]).delete(I(v[1]))
    #         result = v[0]
    #     of SV: 
    #         S(v[0]).delete(I(v[1]),I(v[1]))
    #         result = v[0]
    #     of DV: 
    #         var i = 0
    #         while i < D(0).list.len:
    #             if D(0).list[i][0] == S(v[1]):
    #                 D(0).list.del(i)
    #             inc(i)
    #         result = v[0]
    #     else: discard

proc Generic_get*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV or DV or SV)#xl.list[0].evaluate()
    #let v1 = VALID(1,xl.list[1].evaluate()

    case v0.kind
        of AV: result = A(v0)[I(VALID(1,IV))]
        of DV: result = D(v0).getValueForKey(S(VALID(1,SV)))
        of SV: result = STR($(S(v0)[I(VALID(1,IV))]))
        else: discard

proc Generic_index*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = SINT(findValueInArray(A(v[0]),v[1]))
        of SV: result = SINT(S(v[0]).find(S(v[1])))
        else: discard 

proc Generic_isEmpty*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = BOOL(A(v[0]).len==0)
        of DV: result = BOOL(D(v[0]).len==0)
        of SV: result = BOOL(S(v[0]).len==0)
        else: discard

proc Generic_reverse*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of AV: result = ARR(A(v[0]).reversed())
        of SV: 
            var ret = newString(S(v[0]).len)
            var i = 0
            while i<S(v[0]).len:
                ret[S(v[0]).high-i] = S(v[0])[i]
                inc(i)
            
            result = STR(ret)
        else: discard

proc Generic_reverseI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    # case v[0].kind
    #     of AV: 
    #         A(v[0]).reverse()
    #         result = v[0]
    #     of SV: 
    #         var i = 0
    #         while i<S(v[0]).high div 2:
    #             swap(S(v[0])[i],S(v[0])[S(v[0]).high - i])
    #             inc(i)
            
    #         result = v[0]
    #     else: discard

proc Generic_set*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.list.map((x)=>x.evaluate())#xl.validate(f)

    # case v[0].kind
    #     of AV: 
    #         result = valueCopy(v[0])
    #         result.a[I(v[1])] = v[2]
    #     of DV: 
    #         result = valueCopy(v[0])
    #         result.d.updateOrSet(S(v[1]),v[2])
    #     of SV: 
    #         result = valueCopy(v[0])
    #         result.s[I(v[1])] = S(v[2])[0]
    #     else: discard

proc Generic_setI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.list.map((x)=>x.evaluate())#xl.validate(f)

    case v[0].kind
        of AV: 
            A(v[0])[I(v[1])] = v[2]
            result = v[0]
        of DV: 
            D(v[0]).updateOrSet(S(v[1]),v[2])
            result = v[0]
        of SV: 
            S(v[0])[I(v[1])] = S(v[2])[0]
            result = v[0]
        else: discard

proc Generic_size*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV or SV or DV)
    #let v = xl.validate(f)

    case v0.kind
        of AV: result = SINT(A(v0).len)
        of SV: result = SINT(S(v0).len)
        of DV: result = SINT(D(v0).len)
        else: discard

proc Generic_slice*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV or SV)#xl.validate(f)

    case v0.kind
        of AV: 
            if xl.list.len==3: result = ARR(A(v0)[I(VALID(1,IV))..I(VALID(2,IV))])
            else: result = ARR(A(v0)[I(VALID(1,IV))..^1])
        of SV: 
            if xl.list.len==3: result = STR(S(v0)[I(VALID(1,IV))..I(VALID(2,IV))])
            else: result = STR(S(v0)[I(VALID(1,IV))..^1])
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
