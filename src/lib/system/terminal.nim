#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/terminal.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Terminal_clear*[F,X,V](f: F, xl: X): V {.inline.} =
    eraseScreen()
    result = NULL

proc Terminal_input*[F,X,V](f: F, xl: X): V {.inline.} =
    result = STR(readLine(stdin))

proc Terminal_inputChar*[F,X,V](f: F, xl: X): V {.inline.} =
    result = STR($(getch()))

proc Terminal_print*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    echo v[0].stringify(quoted=false)
    result = v[0]

proc Terminal_prints*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    write(stdout,v[0].stringify(quoted=false))
    flushFile(stdout)

    result = v[0]  

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/core":

#         test "get":
#             check(eq( callFunction("get",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0)]), INT(1) ))
