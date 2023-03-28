#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Dates.nim
#=======================================================

## The main Dates module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import times

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    # TODO(Dates) more potential built-in function candidates?
    #  we could also make use of our recently-added `:quantity` values
    #  labels: library, enhancement, open discussion

    builtin "after",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get date after given one using interval",
        args        = {
            "date"  : {Literal, Date}
        },
        attrs       = {
            "nanoseconds"   : ({Integer},"add given number of nanoseconds"),
            "milliseconds"  : ({Integer},"add given number of milliseconds"),
            "seconds"       : ({Integer},"add given number of seconds"),
            "minutes"       : ({Integer},"add given number of minutes"),
            "hours"         : ({Integer},"add given number of hours"),
            "days"          : ({Integer},"add given number of days"),
            "weeks"         : ({Integer},"add given number of weeks"),
            "months"        : ({Integer},"add given number of months"),
            "years"         : ({Integer},"add given number of years")
        },
        returns     = {Date},
        example     = """
            print now
            ; 2021-03-22T11:25:30+01:00

            print after.weeks:2 now
            ; 2021-04-05T11:25:42+02:00
        """:
            #=======================================================
            var nanoseconds, milliseconds, seconds,
                minutes, hours, days, weeks,
                months, years = 0

            if checkAttr("nanoseconds"):      nanoseconds = aNanoseconds.i
            if checkAttr("milliseconds"):   milliseconds = aMilliseconds.i
            if checkAttr("seconds"):                  seconds = aSeconds.i
            if checkAttr("minutes"):                  minutes = aMinutes.i
            if checkAttr("hours"):                        hours = aHours.i
            if checkAttr("days"):                           days = aDays.i
            if checkAttr("weeks"):                        weeks = aWeeks.i
            if checkAttr("months"):                     months = aMonths.i
            if checkAttr("years"):                        years = aYears.i

            let ti = initTimeInterval(
                nanoseconds=nanoseconds, 
                milliseconds=milliseconds,
                seconds=seconds,
                minutes=minutes,
                hours=hours,
                days=days,
                weeks=weeks,
                months=months,
                years=years
            )
            
            if xKind==Literal:
                ensureInPlace()
                SetInPlace(newDate(InPlaced.eobj + ti))
            else:
                push(newDate(x.eobj + ti))

    builtin "before",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get date before given one using interval",
        args        = {
            "date"  : {Date}
        },
        attrs       = {
            "nanoseconds"   : ({Integer},"subtract given number of nanoseconds"),
            "milliseconds"  : ({Integer},"subtract given number of milliseconds"),
            "seconds"       : ({Integer},"subtract given number of seconds"),
            "minutes"       : ({Integer},"subtract given number of minutes"),
            "hours"         : ({Integer},"subtract given number of hours"),
            "days"          : ({Integer},"subtract given number of days"),
            "weeks"         : ({Integer},"subtract given number of weeks"),
            "months"        : ({Integer},"subtract given number of months"),
            "years"         : ({Integer},"subtract given number of years")
        },
        returns     = {Date},
        example     = """
            print now
            ; 2021-03-22T11:27:00+01:00
            
            print before.weeks:2 now
            ; 2021-03-08T11:27:14+01:00

            print before.years:1 now
            ; 2020-03-22T11:27:23+01:00
        """:
            #=======================================================
            var nanoseconds, milliseconds, seconds,
                minutes, hours, days, weeks,
                months, years = 0

            if checkAttr("nanoseconds"):      nanoseconds = aNanoseconds.i
            if checkAttr("milliseconds"):   milliseconds = aMilliseconds.i
            if checkAttr("seconds"):                  seconds = aSeconds.i
            if checkAttr("minutes"):                  minutes = aMinutes.i
            if checkAttr("hours"):                        hours = aHours.i
            if checkAttr("days"):                           days = aDays.i
            if checkAttr("weeks"):                        weeks = aWeeks.i
            if checkAttr("months"):                     months = aMonths.i
            if checkAttr("years"):                        years = aYears.i

            let ti = initTimeInterval(
                nanoseconds=nanoseconds, 
                milliseconds=milliseconds,
                seconds=seconds,
                minutes=minutes,
                hours=hours,
                days=days,
                weeks=weeks,
                months=months,
                years=years
            )
            
            if xKind==Literal:
                ensureInPlace()
                SetInPlace(newDate(InPlaced.eobj - ti))
            else:
                push(newDate(x.eobj - ti))

    builtin "friday?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given date is a Friday",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print friday? now       ; false
        """:
            #=======================================================
            push(newLogical(x.eobj.weekday == dFri))

    builtin "future?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given date is in the future",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            futureDate: after.weeks:2 now

            print future? now           ; false
            print future? futureDate    ; true
        """:
            #=======================================================
            push(newLogical(x.eobj > now()))

    builtin "leap?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given year is a leap year",
        args        = {
            "year"  : {Integer,Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print leap? now     ; false

            print map 2019..2021 => leap? 
            ; false true false
        """:
            #=======================================================
            if xKind==Integer:
                push(newLogical(isLeapYear(x.i)))
            else:
                push(newLogical(isLeapYear(x.e["year"].i)))

    builtin "monday?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given date is a Monday",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print sunday? now       ; false
        """:
            #=======================================================
            push(newLogical(x.eobj.weekday == dMon))

    builtin "now",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get date/time now",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Date},
        example     = """
            print now           ; 2020-10-23T14:16:13+02:00
            
            time: now
            inspect time
            
            ; [ :date
            ;       hour        : 14 :integer
            ;       minute      : 16 :integer
            ;       second      : 55 :integer
            ;       nanosecond  : 82373000 :integer
            ;       day         : 23 :integer
            ;       Day         : Friday :string
            ;       month       : 10 :integer
            ;       Month       : October :string
            ;       year        : 2020 :integer
            ;       utc         : -7200 :integer
            ; ]
            
            print now\year      ; 2020
        """:
            #=======================================================
            push(newDate(now()))

    
    builtin "past?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given date is in the past",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            pastDate: before.weeks:2 now
            futureDate: after.weeks:1 now

            print past? futureDate      ; false
            print past? pastDate        ; true

            print past? now             ; true ("now" has already become past...)
        """:
            #=======================================================
            push(newLogical(now() > x.eobj))

    builtin "saturday?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given date is a Saturday",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print saturday? now     ; false
        """:
            #=======================================================
            push(newLogical(x.eobj.weekday == dSat))

    builtin "sunday?",
        alias       = unaliased,
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "check if given date is a Sunday",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print sunday? now       ; false
        """:
            #=======================================================
            push(newLogical(x.eobj.weekday == dSun))

    builtin "thursday?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given date is a Thursday",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print thursday? now     ; false
        """:
            #=======================================================
            push(newLogical(x.eobj.weekday == dThu))

    builtin "today?",
        alias       = unaliased,
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "check if given date is today",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print today? now                    ; true
            
            print today? after.hours: 24 now    ; false
        """:
            #=======================================================
            let rightNow = now()

            push(newLogical(x.eobj.year == rightNow.year and
                            x.eobj.yearday == rightNow.yearday))

    builtin "tuesday?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given date is a Tuesday",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print tuesday? now      ; true
        """:
            #=======================================================
            push(newLogical(x.eobj.weekday == dTue))

    builtin "wednesday?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given date is a Wednesday",
        args        = {
            "date"  : {Date}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print wednesday? now    ; false
        """:
            #=======================================================
            push(newLogical(x.eobj.weekday == dWed))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)