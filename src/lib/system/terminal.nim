#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/terminal.nim
  * @description: interacting with the terminal
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
    let v0 = VALID(0,ANY)

    echo v0.stringify(quoted=false)
    result = v0

proc Terminal_prints*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,ANY)

    write(stdout,v0.stringify(quoted=false))
    flushFile(stdout)

    result = v0  

proc Terminal_shell*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    let (outp, _) = execCmdEx(S(v0))

    result = STR(outp)

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/core":

#         test "get":
#             check(eq( callFunction("get",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0)]), INT(1) ))
