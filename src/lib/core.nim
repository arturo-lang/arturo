#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/core.nim
  *****************************************************************]#

import bitops

#[######################################################
    Functions
  ======================================================]#

proc Core_And*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = f.validateOne(xl.list[0],[BV,IV])

    case v0.kind
        of BV:
            if not v0.b: return FALSE
            if f.validateOne(xl.list[1],[BV]).b: return TRUE
        of IV:
            result = valueFromInteger(bitand(v0.i, f.validateOne(xl.list[1],[IV]).i))
        else: discard

proc Core_If*[F,X,V](f: F, xl: X): V {.inline.} =
    if f.validateOne(xl.list[0],[BV]).b:
        result = f.validateOne(xl.list[1],[FV]).f.execute(NULL)
    else:
        if xl.list.len == 3:
            result = f.validateOne(xl.list[2],[FV]).f.execute(NULL)
        else:
            result = FALSE

proc Core_Get*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    case v[0].kind
        of arrayValue: result = A(0)[I(1)]
        of dictionaryValue: result = D(0).getValueForKey(S(1))
        else: result = NULL

proc Core_Loop*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    case v[0].kind
        of AV:
            var i = 0
            while i < A(0).len:
                result = FN(1).execute(A(0)[i])
                inc(i)
        of DV:
            for val in D(0):
                result = FN(1).execute(valueFromArray(@[valueFromString(val[0]),val[1]]))
        of BV:
            if not B(0): return NULL
            while true:
                result = FN(1).execute(NULL)
                if not xl.list[0].evaluate().b: break
        of IV:
            var i = 0
            while i < I(0):
                result = FN(1).execute(NULL)
                inc(i)

        else: result = NULL

proc Core_Not*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = f.validateOne(xl.list[0],[BV,IV])

    case v0.kind
        of BV:
            if v0.b: result = TRUE
            else: result = FALSE
        of IV:
            result = valueFromInteger(bitnot(v0.i))
        else: discard

proc Core_Or*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = f.validateOne(xl.list[0],[BV,IV])

    case v0.kind
        of BV:
            if v0.b: return TRUE
            if f.validateOne(xl.list[1],[BV]).b: return TRUE
        of IV:
            result = valueFromInteger(bitor(v0.i, f.validateOne(xl.list[1],[IV]).i))
        else: discard

proc Core_Print*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)
    
    echo v[0].stringify(quoted=false)
    result = v[0]

proc Core_Product*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    result = A(0)[0]

    var i = 1
    while i < A(0).len:
        result = result * A(0)[i]
        inc(i)

proc Core_Range*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    if I(0)<I(1):    
        result = valueFromArray(toSeq(I(0)..I(1)).map(proc (x: int): Value = valueFromInteger(x)))
    else:
        result = valueFromArray(toSeq(countdown(I(0),I(1))).map(proc (x: int): Value = valueFromInteger(x)))    

proc Core_Return*[F,X,V](f: F, xl: X): V {.inline.} = 
    let v = f.validate(xl)

    var ret = newException(ReturnValue, "return")
    ret.value = v[0]

    raise ret

proc Core_Sum*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = f.validate(xl)

    result = A(0)[0]

    var i = 1
    while i < A(0).len:
        result = result + A(0)[i]
        inc(i)

proc Core_Syms*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = f.validateOne(xl.list[0],[BV,IV])

    inspectStack()

    result = NULL

proc Core_Xor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = f.validateOne(xl.list[0],[BV,IV])

    case v0.kind
        of BV:
            let v1 = f.validateOne(xl.list[1],[BV])
            if (v0.b and (not v1.b)) or ((not v0.b) and v1.b):
                result = TRUE
            else:
                result = FALSE
        of IV:
            result = valueFromInteger(bitxor(v0.i, f.validateOne(xl.list[1],[IV]).i))
        else: discard
