#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/logical.nim
  * @description: logical and bitwise operations
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Logical_and*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,BV|IV)

    {.computedGoTo.}
    case v0.kind
        of BV:
            if not B(v0): return FALSE
            if B(VALID(1,BV)): return TRUE
            else: return FALSE
        of IV:
            result = SINT(bitand(I(v0), I(VALID(1,IV))))
        else: discard

proc Logical_nand*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,BV|IV)

    {.computedGoTo.}
    case v0.kind
        of BV:
            if not B(v0): return TRUE
            if B(VALID(1,BV)): return FALSE
            else: return TRUE
        of IV:
            result = SINT(bitnot(bitand(I(v0), I(VALID(1,IV)))))
        else: discard

proc Logical_nor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,BV|IV)

    {.computedGoTo.}
    case v0.kind
        of BV:
            if B(v0): return FALSE
            if B(VALID(1,BV)): return FALSE
            else: return TRUE
        of IV:
            result = SINT(bitnot(bitor(I(v0), I(VALID(1,IV)))))
        else: discard

proc Logical_not*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,BV|IV)

    {.computedGoTo.}
    case v0.kind
        of BV:
            if B(v0): result = FALSE
            else: result = TRUE
        of IV:
            result = SINT(bitnot(I(v0)))
        else: discard

proc Logical_or*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,BV|IV)

    {.computedGoTo.}
    case v0.kind
        of BV:
            if B(v0): return TRUE
            if B(VALID(1,BV)): return TRUE
            else: return FALSE
        of IV:
            result = SINT(bitor(I(v0), I(VALID(1,IV))))
        else: discard

proc Logical_xnor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,BV|IV)

    {.computedGoTo.}
    case v0.kind
        of BV:
            let v1 = VALID(1,BV)
            result = BOOL( (B(v0) and B(v1)) or ((not B(v0)) and (not B(v1))) )
        of IV:
            result = SINT(bitnot(bitxor(I(v0), I(VALID(1,IV)))))
        else: discard

proc Logical_xor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,BV|IV)

    {.computedGoTo.}
    case v0.kind
        of BV:
            let v1 = VALID(1,BV)
            result = BOOL( (B(v0) and (not B(v1))) or ((not B(v0)) and B(v1)) )
        of IV:
            result = SINT(bitxor(I(v0), I(VALID(1,IV))))
        else: discard

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/logical":

        test "and":
            check(eq( callFunction("and",@[TRUE,TRUE]), TRUE ))
            check(eq( callFunction("and",@[TRUE,FALSE]), FALSE ))
            check(eq( callFunction("and",@[FALSE,TRUE]), FALSE ))
            check(eq( callFunction("and",@[FALSE,FALSE]), FALSE ))
            check(eq( callFunction("and",@[INT(10),INT(3)]), INT(2) ))

        test "nand":
            check(eq( callFunction("nand",@[TRUE,TRUE]), FALSE ))
            check(eq( callFunction("nand",@[TRUE,FALSE]), TRUE ))
            check(eq( callFunction("nand",@[FALSE,TRUE]), TRUE ))
            check(eq( callFunction("nand",@[FALSE,FALSE]), TRUE ))
            check(eq( callFunction("nand",@[INT(10),INT(3)]), INT(-3) ))

        test "nor":
            check(eq( callFunction("nor",@[TRUE,TRUE]), FALSE ))
            check(eq( callFunction("nor",@[TRUE,FALSE]), FALSE ))
            check(eq( callFunction("nor",@[FALSE,TRUE]), FALSE ))
            check(eq( callFunction("nor",@[FALSE,FALSE]), TRUE ))
            check(eq( callFunction("nor",@[INT(10),INT(3)]), INT(-12) ))

        test "not":
            check(eq( callFunction("not",@[TRUE]), FALSE ))
            check(eq( callFunction("not",@[FALSE]), TRUE ))

        test "or":
            check(eq( callFunction("or",@[TRUE,TRUE]), TRUE ))
            check(eq( callFunction("or",@[TRUE,FALSE]), TRUE ))
            check(eq( callFunction("or",@[FALSE,TRUE]), TRUE ))
            check(eq( callFunction("or",@[FALSE,FALSE]), FALSE ))
            check(eq( callFunction("or",@[INT(10),INT(3)]), INT(11) ))

        test "xnor":
            check(eq( callFunction("xnor",@[TRUE,TRUE]), TRUE ))
            check(eq( callFunction("xnor",@[TRUE,FALSE]), FALSE ))
            check(eq( callFunction("xnor",@[FALSE,TRUE]), FALSE ))
            check(eq( callFunction("xnor",@[FALSE,FALSE]), TRUE ))
            check(eq( callFunction("xnor",@[INT(10),INT(3)]), INT(-10) ))

        test "xor":
            check(eq( callFunction("xor",@[TRUE,TRUE]), FALSE ))
            check(eq( callFunction("xor",@[TRUE,FALSE]), TRUE ))
            check(eq( callFunction("xor",@[FALSE,TRUE]), TRUE ))
            check(eq( callFunction("xor",@[FALSE,FALSE]), FALSE ))
            check(eq( callFunction("xor",@[INT(10),INT(3)]), INT(9) ))
