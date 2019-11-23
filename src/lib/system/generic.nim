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
    let v0 = VALID(0,AV|SV)

    case v0.kind
        of AV: result = ARR(A(v0) & VALID(1,ANY))
        of SV: result = STR(S(v0) & S(VALID(1,SV)))
        else: discard

proc Generic_appendI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV)

    case v0.kind
        of AV: 
            A(v0).add(VALID(1,ANY))
            result = v0
        of SV: 
            S(v0).add(S(VALID(1,SV)))
            result = v0
        else: discard

proc Generic_contains*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)

    case v0.kind
         of AV: result = BOOL(findValueInArray(v0,VALID(1,ANY))!=(-1))
         of SV: 
            let v1 = VALID(1,SV)
            if unlikely(S(v1).isRegex()):
                result = BOOL(S(v0).contains(re(prepareRegex(S(v1)))))
            else:
                result = BOOL(S(v0).contains(S(v1)))
         of DV: result = BOOL(findValueInArray(D(v0).values,VALID(1,ANY))!=(-1))
         else: discard

proc Generic_delete*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)
    let v1 = VALID(1,ANY)

    result = v0--v1

proc Generic_deleteI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)
    let v1 = VALID(1,ANY)

    case v0.kind
        of AV: result = v0--v1; A(v0) = A(result)
        of SV: result = v0--v1; S(v0) = S(result)
        of DV: result = v0--v1; D(v0) = D(result)
        else: discard

proc Generic_deleteBy*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)

    case v0.kind
        of AV: 
            result = valueCopy(v0)
            A(result).delete(I(VALID(1,IV)))
        of SV: 
            let v1 = VALID(1,IV)
            result = valueCopy(v0)
            S(result).delete(I(v1),I(v1))
        of DV: 
            let v1 = VALID(1,SV)
            result = valueCopy(v0)
            var i = 0
            while i < D(result).len:
                if D(result)[i][0] == S(v1).hash:
                    D(result).del(i)
                inc(i)
        else: discard

proc Generic_deleteByI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)

    case v0.kind
        of AV: 
            A(v0).delete(I(VALID(1,IV)))
            result = v0
        of SV: 
            let v1 = VALID(1,IV)
            S(v0).delete(I(v1),I(v1))
            result = v0
        of DV: 
            let v1 = VALID(1,SV)
            var i = 0
            while i < D(v0).len:
                if D(v0)[i][0] == S(v1).hash:
                    D(v0).del(i)
                inc(i)
            result = v0
        else: discard

proc Generic_get*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].evaluate()#VALID(0,AV|SV|DV)

    {.computedGoTo.}
    case v0.kind
        of AV: result = A(v0)[I(EVAL(1))]#A(v0)[I(VALID(1,IV))]
        of SV: result = STR($(S(v0)[I(EVAL(1))]))##VALID(1,IV))]))
        of DV: result = D(v0).getValueForKey(S(EVAL(1)))#VALID(1,SV)))
        else: discard

proc Generic_index*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV)

    case v0.kind
        of AV: result = SINT(findValueInArray(A(v0),VALID(1,ANY)))
        of SV: result = SINT(S(v0).find(S(VALID(1,SV))))
        else: discard 

proc Generic_isEmpty*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)

    case v0.kind
        of AV: result = BOOL(A(v0).len==0)
        of SV: result = BOOL(S(v0).len==0)
        of DV: result = BOOL(D(v0).len==0)
        else: discard

proc Generic_prepend*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV)

    case v0.kind
        of AV: result = ARR(VALID(1,ANY) & A(v0))
        of SV: result = STR(S(VALID(1,SV)) & S(v0))
        else: discard

proc Generic_prependI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV)

    case v0.kind
        of AV: 
            A(v0).insert(VALID(1,ANY))
            result = v0
        of SV: 
            S(v0) = S(VALID(1,SV)) & S(v0)
            result = v0
        else: discard

proc Generic_reverse*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV)

    case v0.kind
        of AV: result = ARR(A(v0).reversed())
        of SV: 
            var ret = newString(S(v0).len)
            var i = 0
            while i<S(v0).len:
                ret[S(v0).high-i] = S(v0)[i]
                inc(i)
            
            result = STR(ret)
        else: discard

proc Generic_reverseI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV)

    case v0.kind
        of AV: 
            A(v0).reverse()
            result = v0
        of SV: 
            var i = 0
            while i<S(v0).high div 2:
                swap(S(v0)[i],S(v0)[S(v0).high - i])
                inc(i)
            
            result = v0
        else: discard

proc Generic_set*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)

    case v0.kind
        of AV: 
            result = valueCopy(v0)
            A(result)[I(VALID(1,IV))] = VALID(2,ANY)
        of SV: 
            result = valueCopy(v0)
            S(result)[I(VALID(1,IV))] = S(VALID(2,SV))[0]
        of DV: 
            result = valueCopy(v0)
            D(result).updateOrSet(S(VALID(1,SV)),VALID(2,ANY))
        else: discard

proc Generic_setI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)

    case v0.kind
        of AV: 
            A(v0)[I(VALID(1,IV))] = VALID(2,ANY)
            result = v0
        of DV: 
            D(v0).updateOrSet(S(VALID(1,SV)),VALID(2,ANY))
            result = v0
        of SV: 
            S(v0)[I(VALID(1,IV))] = S(VALID(2,SV))[0]
            result = v0
        else: discard

proc Generic_size*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV|DV)

    case v0.kind
        of AV: result = SINT(A(v0).len)
        of SV: result = SINT(S(v0).len)
        of DV: result = SINT(D(v0).len)
        else: discard

proc Generic_slice*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|SV)

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
