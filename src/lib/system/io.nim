#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/io.nim
  * @description: File input/output
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Io_read*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(readFile(S(v0)))

proc Io_write*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    writeFile(S(v0),S(v1))
    result = v1

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
