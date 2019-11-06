#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/dictionary.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Dictionary_hasKey*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("hasKey", f.req)

    result = BOOL(S(1) in D(0).keys())  

proc Dictionary_keys*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("keys", f.req)

    result = STRARR(D(0).keys())

proc Dictionary_values*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate("values", f.req)

    result = ARR(D(0).values())

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/dictionary":

#         test "shuffle":
#             check(not eq( callFunction("shuffle",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)])]), ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]) ))

#         test "swap":
#             check(eq( callFunction("swap",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0),INT(2)]), ARR(@[INT(3),INT(2),INT(1)]) ))
