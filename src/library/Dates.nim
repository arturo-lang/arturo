######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Dates.nim
######################################################

#=======================================
# Methods
#=======================================

builtin "now",
    alias       = unaliased, 
    precedence  = PrefixPrecedence,
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
        stack.push(newDate(now()))
