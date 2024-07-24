#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/custom/vsymbol.nim
#=======================================================

## The internal `:symbol` type

#=======================================
# Types
#=======================================
# TODO(values/custom/vsymbol) add symbol for `**`
#  apart from the use this could have in Grafito (which could most like be attached to something like `any`)
#  it seems inconsistent to have `++`, `--`, etc but not this one...
#  labels: vm,values,enhancement

type 
    VSymbol* = enum
        thickarrowleft           = "<="
        thickarrowright          = "=>"
        thickarrowboth           = "<=>"
        thickarrowdoubleleft     = "<<="
        thickarrowdoubleright    = "=>>"
        thickarrowdoubleboth     = "<<=>>"
        arrowleft                = "<-"
        arrowright               = "->"
        arrowboth                = "<->"
        arrowdoubleleft          = "<<-"
        arrowdoubleright         = "->>"
        arrowdoubleboth          = "<<->>"
        reversearrowleft         = "-<"
        reversearrowright        = ">-"
        reversearrowboth         = ">-<"
        reversearrowdoubleleft   = "-<<"
        reversearrowdoubleright  = ">>-"
        reversearrowdoubleboth   = ">>-<<"
        doublearrowleft          = "<<"
        doublearrowright         = ">>"
        triplearrowleft          = "<<<"
        triplearrowright         = ">>>"
        longarrowleft            = "<--"
        longarrowright           = "-->"
        longarrowboth            = "<-->"
        longthickarrowleft       = "<=="
        longthickarrowright      = "==>"
        longthickarrowboth       = "<==>"
        tildeleft                = "<~"
        tilderight               = "~>"
        tildeboth                = "<~>"
        triangleright            = "|>"
        triangleleft             = "<|"
        triangleboth             = "<|>"

        equalless                = "=<"
        greaterequal             = ">="
        lessgreater              = "<>"
        
        lesscolon                = "<:"
        minuscolon               = "-:"
        greatercolon             = ">:"

        tilde                    = "~"
        exclamation              = "!"
        doubleexclamation        = "!!"
        question                 = "?"
        doublequestion           = "??"
        at                       = "@"
        sharp                    = "#"
        doublesharp              = "##"
        triplesharp              = "###"
        quadruplesharp           = "####"
        quintuplesharp           = "#####"
        sextuplesharp            = "######"
        dollar                   = "$"
        percent                  = "%"
        caret                    = "^"
        ampersand                = "&"
        asterisk                 = "*"
        doubleasterisk           = "**"
        minus                    = "-"
        doubleminus              = "--"
        equal                    = "="
        doubleequal              = "=="
        approxequal              = "=~"
        plus                     = "+"
        doubleplus               = "++"
        lessthan                 = "<"
        greaterthan              = ">"
        slash                    = "/"
        slashpercent             = "/%"
        doubleslash              = "//"
        backslash                = "\\"
        doublebackslash          = "\\\\"
        pipe                     = "|"
        turnstile                = "|-"
        doubleturnstile          = "|="

        ellipsis                 = ".."
        longellipsis             = "..."
        dotslash                 = "./"
        colon                    = ":"
        doublecolon              = "::"
        colonequal               = ":="
        doublepipe               = "||"

        slashedzero              = "∅"
        infinite                 = "∞"
        summation                = "∑"
        product                  = "∏"
        intersection             = "∩"
        union                    = "∪"
        subset                   = "⊂"
        superset                 = "⊃"
        subsetorequal            = "⊆"
        supersetorequal          = "⊇"
        element                  = "∈"
        notelement               = "∉"
        logicaland               = "∧"
        logicalor                = "∨"
        logicalxor               = "⊻"
        logicalnand              = "⊼"
        logicalnot               = "¬"

        unaliased