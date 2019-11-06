#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/generic.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Generic_append*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("append", f.req)

    case v[0].kind
        of AV: result = ARR(A(0) & v[1])
        of SV: result = STR(S(0) & S(1))
        else: discard

proc Generic_appendI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("append!", f.req)

    case v[0].kind
        of AV: 
            A(0).add(v[1])
            result = v[0]
        of SV: 
            S(0).add(S(1))
            result = v[0]
        else: discard

proc Generic_contains*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("contains", f.req)

    case v[0].kind
         of AV: result = BOOL(findValueInArray(v[0],v[1])!=(-1))
         of SV: result = BOOL(S(0).contains(S(1)))
         of DV: result = BOOL(findValueInArray(D(0).values,v[1])!=(-1))
         else: discard

proc Generic_reverse*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("reverse", f.req)

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
    let v = xl.validate("reverse!", f.req)

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

proc Generic_size*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("size", f.req)

    case v[0].kind
        of AV: result = INT(A(0).len)
        of SV: result = INT(S(0).len)
        of DV: result = INT(D(0).list.len)
        else: discard

proc Generic_slice*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("slice", f.req)

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

        test "reverse":
            check(eq( callFunction("reverse",@[ARR(@[INT(1),INT(2),INT(3)])]), ARR(@[INT(3),INT(2),INT(1)]) ))

        test "size":
            check(eq( callFunction("size",@[STR("hello")]), INT(5) ))
            check(eq( callFunction("size",@[ARR(@[INT(1),INT(2)])]), INT(2) ))

        test "slice":
            check(eq( callFunction("slice",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]),INT(0),INT(3)]), ARR(@[INT(1),INT(2),INT(3),INT(4)]) ))
