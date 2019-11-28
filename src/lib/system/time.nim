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
    let v0 = VALID(0,FV)
    
    let t0 = epochTime()
    discard FN(v0).execute(NULL)
    let elapsed = (epochTime() - t0).formatFloat(format = ffDecimal, precision = 3)

    result = REAL(elapsed)

proc Time_datetime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV|IV)

    case v0.kind
        of SV:
            var dt: DateTime
            if xl.list.len==2:
                dt = parse(S(v0), S(VALID(1,SV)))
            else:
                dt = parse(S(v0), "dd-MM-yyyy HH:mm:ss")

            result = SINT(int(toUnix(dt.toTime())))
        of IV:
            let dt = fromUnix(int64(I(v0))).local
            var tf: TimeFormat

            if xl.list.len==2:
                tf = initTimeFormat(S(VALID(1,SV)))
            else:
                tf = initTimeFormat("dd-MM-yyyy HH:mm:ss")

            result = STR(dt.format(tf))
        else: discard

proc Time_day*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    let dt = ( if v0.kind==IV: fromUnix(int64(I(v0))).local else: fromUnix(toInt(BI(v0))).local )

    result = STR($(dt.weekday))

proc Time_dayOfMonth*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BV)

    let dt = ( if v0.kind==IV: fromUnix(int64(I(v0))).local else: fromUnix(toInt(BI(v0))).local )

    result = SINT(dt.monthday)

proc Time_dayOfYear*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    let dt = ( if v0.kind==IV: fromUnix(int64(I(v0))).local else: fromUnix(toInt(BI(v0))).local )

    result = SINT(dt.yearday)

proc Time_delay*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV)

    sleep(I(v0))

    result = v0

proc Time_hours*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    let dt = ( if v0.kind==IV: fromUnix(int64(I(v0))).local else: fromUnix(toInt(BI(v0))).local )

    result = SINT(dt.hour)

proc Time_minutes*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    let dt = ( if v0.kind==IV: fromUnix(int64(I(v0))).local else: fromUnix(toInt(BI(v0))).local )

    result = SINT(dt.minute)

proc Time_month*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    let dt = ( if v0.kind==IV: fromUnix(int64(I(v0))).local else: fromUnix(toInt(BI(v0))).local )

    result = STR($(dt.month))

proc Time_now*[F,X,V](f: F, xl: X): V {.inline.} =
    result = SINT(int(toUnix(getTime())))

proc Time_seconds*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    let dt = ( if v0.kind==IV: fromUnix(int64(I(v0))).local else: fromUnix(toInt(BI(v0))).local )

    result = SINT(dt.second)

proc Time_year*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV|BIV)

    let dt = ( if v0.kind==IV: fromUnix(int64(I(v0))).local else: fromUnix(toInt(BI(v0))).local )

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

