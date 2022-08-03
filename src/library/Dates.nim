######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Dates.nim
######################################################

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

    when defined(VERBOSE):
        echo "- Importing: Dates"

    # TODO(Dates) more potential built-in function candidates?
    #  we could also make use of our recently-added `:quantity` values
    #  labels: library, enhancement, open discussion

    builtin "after",
        alias       = unaliased, 
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
            ##########################################################
            var nanoseconds, milliseconds, seconds,
                minutes, hours, days, weeks,
                months, years = 0

            if (let aNanoseconds = popAttr("nanoseconds"); aNanoseconds != VNULL):      nanoseconds = aNanoseconds.i
            if (let aMilliseconds = popAttr("milliseconds"); aMilliseconds != VNULL):   milliseconds = aMilliseconds.i
            if (let aSeconds = popAttr("seconds"); aSeconds != VNULL):                  seconds = aSeconds.i
            if (let aMinutes = popAttr("minutes"); aMinutes != VNULL):                  minutes = aMinutes.i
            if (let aHours = popAttr("hours"); aHours != VNULL):                        hours = aHours.i
            if (let aDays = popAttr("days"); aDays != VNULL):                           days = aDays.i
            if (let aWeeks = popAttr("weeks"); aWeeks != VNULL):                        weeks = aWeeks.i
            if (let aMonths = popAttr("months"); aMonths != VNULL):                     months = aMonths.i
            if (let aYears = popAttr("years"); aYears != VNULL):                        years = aYears.i

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
            
            if x.kind==Literal:
                SetInPlace(newDate(InPlace.eobj + ti))
            else:
                push(newDate(x.eobj + ti))

    builtin "before",
        alias       = unaliased, 
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
            ##########################################################
            var nanoseconds, milliseconds, seconds,
                minutes, hours, days, weeks,
                months, years = 0

            if (let aNanoseconds = popAttr("nanoseconds"); aNanoseconds != VNULL):      nanoseconds = aNanoseconds.i
            if (let aMilliseconds = popAttr("milliseconds"); aMilliseconds != VNULL):   milliseconds = aMilliseconds.i
            if (let aSeconds = popAttr("seconds"); aSeconds != VNULL):                  seconds = aSeconds.i
            if (let aMinutes = popAttr("minutes"); aMinutes != VNULL):                  minutes = aMinutes.i
            if (let aHours = popAttr("hours"); aHours != VNULL):                        hours = aHours.i
            if (let aDays = popAttr("days"); aDays != VNULL):                           days = aDays.i
            if (let aWeeks = popAttr("weeks"); aWeeks != VNULL):                        weeks = aWeeks.i
            if (let aMonths = popAttr("months"); aMonths != VNULL):                     months = aMonths.i
            if (let aYears = popAttr("years"); aYears != VNULL):                        years = aYears.i

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
            
            if x.kind==Literal:
                SetInPlace(newDate(InPlace.eobj - ti))
            else:
                push(newDate(x.eobj - ti))

    builtin "leap?",
        alias       = unaliased, 
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
            ##########################################################
            if x.kind==Integer:
                push(newLogical(isLeapYear(x.i)))
            else:
                push(newLogical(isLeapYear(x.e["year"].i)))

    builtin "now",
        alias       = unaliased, 
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
            ##########################################################
            push(newDate(now()))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)