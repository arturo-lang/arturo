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
    discard FN(v[0]).execute(NULL)
    let elapsed = (epochTime() - t0).formatFloat(format = ffDecimal, precision = 3)

    result = REAL(elapsed)

proc Time_datetime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    case v[0].kind
        of SV:
            var dt: DateTime
            if xl.list.len==2:
                dt = parse(S(v[0]), S(v[1]))
            else:
                dt = parse(S(v[0]), "dd-MM-yyyy HH:mm:ss")

            result = INT(int(toUnix(dt.toTime())))
        of IV:
            let dt = fromUnix(int64(I(0))).local
            var tf: TimeFormat

            if xl.list.len==2:
                tf = initTimeFormat(S(v[1]))
            else:
                tf = initTimeFormat("dd-MM-yyyy HH:mm:ss")

            result = STR(dt.format(tf))
        else: discard

proc Time_day*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = fromUnix(int64(I(0))).local

    result = STR($(dt.weekday))

proc Time_dayOfMonth*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = fromUnix(int64(I(0))).local

    result = INT(dt.monthday)

proc Time_dayOfYear*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = fromUnix(int64(I(0))).local

    result = INT(dt.yearday)

proc Time_delay*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    sleep(I(0))

    result = v[0]

proc Time_hours*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = fromUnix(int64(I(0))).local

    result = INT(dt.hour)

proc Time_minutes*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = fromUnix(int64(I(0))).local

    result = INT(dt.minute)

proc Time_month*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = fromUnix(int64(I(0))).local

    result = STR($(dt.month))

proc Time_now*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = INT(int(toUnix(getTime())))

proc Time_seconds*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = fromUnix(int64(I(0))).local

    result = INT(dt.second)

proc Time_year*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let dt = fromUnix(int64(I(0))).local

    result = STR(dt.year)

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/math":

#         test "avg":
#             check(eq( callFunction("avg",@[ARR(@[INT(2),INT(4)])]), REAL(3.0) ))

