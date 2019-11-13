#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/time.nim
  * @description: Date and Time manipulation
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Time_benchmark*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    let t0 = epochTime()
    discard FN(0).execute(NULL)
    let elapsed = (epochTime() - t0).formatFloat(format = ffDecimal, precision = 3)

    result = REAL(elapsed)

proc Time_delay*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    sleep(I(0))

    result = v[0]
    

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/math":

#         test "avg":
#             check(eq( callFunction("avg",@[ARR(@[INT(2),INT(4)])]), REAL(3.0) ))

