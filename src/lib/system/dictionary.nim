#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/dictionary.nim
  * @description: Dictionary/Hash manipulation
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Dictionary_hasKey*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,DV)

    result = BOOL(S(VALID(1,SV)) in D(v0).keys())  

proc Dictionary_keys*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,DV)

    result = STRARR(D(v0).keys())

proc Dictionary_values*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,DV)

    result = ARR(D(v0).values())

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
