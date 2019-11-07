#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/logical.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Logical_and*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("and",[BV,IV])

    case v0.kind
        of BV:
            if not v0.b: return FALSE
            if xl.list[1].validate("and",[BV]).b: return TRUE
            else: return FALSE
        of IV:
            result = INT(bitand(v0.i, xl.list[1].validate("and",[IV]).i))
        else: discard

proc Logical_nand*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("nand",[BV,IV])

    case v0.kind
        of BV:
            if not v0.b: return TRUE
            if xl.list[1].validate("nand",[BV]).b: return FALSE
            else: return TRUE
        of IV:
            result = INT(bitnot(bitand(v0.i, xl.list[1].validate("nand",[IV]).i)))
        else: discard

proc Logical_nor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("nor",[BV,IV])

    case v0.kind
        of BV:
            if v0.b: return FALSE
            if xl.list[1].validate("nor",[BV]).b: return FALSE
            else: return TRUE
        of IV:
            result = INT(bitnot(bitor(v0.i, xl.list[1].validate("nor",[IV]).i)))
        else: discard

proc Logical_not*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("not",[BV,IV])

    case v0.kind
        of BV:
            if v0.b: result = FALSE
            else: result = TRUE
        of IV:
            result = INT(bitnot(v0.i))
        else: discard

proc Logical_or*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("or",[BV,IV])

    case v0.kind
        of BV:
            if v0.b: return TRUE
            if xl.list[1].validate("or",[BV]).b: return TRUE
            else: return FALSE
        of IV:
            result = INT(bitor(v0.i, xl.list[1].validate("or",[IV]).i))
        else: discard

proc Logical_xnor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("xnor",[BV,IV])

    case v0.kind
        of BV:
            let v1 = xl.list[1].validate("xnor",[BV])
            result = BOOL( (v0.b and v1.b) or ((not v0.b) and (not v1.b)) )
        of IV:
            result = INT(bitnot(bitxor(v0.i, xl.list[1].validate("xnor",[IV]).i)))
        else: discard

proc Logical_xor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = xl.list[0].validate("xor",[BV,IV])

    case v0.kind
        of BV:
            let v1 = xl.list[1].validate("xor",[BV])
            result = BOOL( (v0.b and (not v1.b)) or ((not v0.b) and v1.b) )
        of IV:
            result = INT(bitxor(v0.i, xl.list[1].validate("xor",[IV]).i))
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
