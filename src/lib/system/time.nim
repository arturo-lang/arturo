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

proc Time_month*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var f: TimeFormat
    if xl.list.len==2:
        f = initTimeFormat(S(1))
    else:
        f = initTimeFormat("dd-MM-yyyy")
    
    let dt = S(0).parse(f)

    result = STR($(dt.month))

proc Time_now*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = now()

    if v[0].kind == SV:
        result = STR(dt.format(S(0)))
    else:
        result = STR(dt.format("HH:mm:ss"))

proc Time_today*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = now()

    if v[0].kind == SV:
        result = STR(dt.format(S(0)))
    else:
        result = STR(dt.format("dd-MM-yyyy"))
    

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/math":

#         test "avg":
#             check(eq( callFunction("avg",@[ARR(@[INT(2),INT(4)])]), REAL(3.0) ))

