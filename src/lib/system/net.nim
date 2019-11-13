#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/net.nim
  * @description: network-related operations
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Net_download*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    var client = newHttpClient()
    result = STR(client.getContent(S(0)))

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/math":

#         test "avg":
#             check(eq( callFunction("avg",@[ARR(@[INT(2),INT(4)])]), REAL(3.0) ))

