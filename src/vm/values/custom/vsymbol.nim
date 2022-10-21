######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/custom/vsymbol.nim
######################################################

#=======================================
# Types
#=======================================

type 
    VSymbol* = enum
        thickarrowleft          # <=
        thickarrowright         # =>
        thickarrowboth          # <=>
        thickarrowdoubleleft    # <<=
        thickarrowdoubleright   # =>>
        thickarrowdoubleboth    # <<=>>
        arrowleft               # <-
        arrowright              # ->
        arrowboth               # <->
        arrowdoubleleft         # <<-
        arrowdoubleright        # ->>
        arrowdoubleboth         # <<->>
        reversearrowleft        # -<
        reversearrowright       # >-
        reversearrowboth        # >-<
        reversearrowdoubleleft  # -<<
        reversearrowdoubleright # >>-
        reversearrowdoubleboth  # >>-<<
        doublearrowleft         # <<
        doublearrowright        # >>
        triplearrowleft         # <<<
        triplearrowright        # >>>
        longarrowleft           # <--
        longarrowright          # -->
        longarrowboth           # <-->
        longthickarrowleft      # <==
        longthickarrowright     # ==>
        longthickarrowboth      # <==>
        tildeleft               # <~
        tilderight              # ~>
        tildeboth               # <~>
        triangleleft            # <|
        triangleright           # |>
        triangleboth            # <|>

        equalless               # =<
        greaterequal            # >=
        lessgreater             # <>

        lesscolon               # <:
        minuscolon              # -:
        greatercolon            # >:

        tilde                   # ~
        exclamation             # !
        doubleexclamation       # !!
        question                # ?
        doublequestion          # ??
        at                      # @
        sharp                   # #
        doublesharp             # ## 
        triplesharp             # ###
        quadruplesharp          # ####
        quintuplesharp          # #####
        sextuplesharp           # ######
        dollar                  # $
        percent                 # %
        caret                   # ^
        ampersand               # &
        asterisk                # *
        minus                   # -
        doubleminus             # --
        underscore              # _
        equal                   # =
        doubleequal             # ==
        approxequal             # =~
        plus                    # +
        doubleplus              # ++

        lessthan                # <
        greaterthan             # >
       
        slash                   # /
        slashpercent            # %/
        doubleslash             # //
        backslash               # 
        doublebackslash         #
        logicaland              #
        logicalor               #
        pipe                    # |     
        turnstile               # |-
        doubleturnstile         # |=

        ellipsis                # ..
        longellipsis            # ...
        dotslash                # ./
        colon                   # :
        doublecolon             # ::
        doublepipe              # ||

        slashedzero             # ø
        infinite                # ∞

        unaliased               # used only for builtins

#=======================================
# Methods
#=======================================

func `$`*(s: VSymbol): string {.enforceNoRaises.} =
    case s:
        of thickarrowleft           : result = "<="
        of thickarrowright          : result = "=>"
        of thickarrowboth           : result = "<=>"
        of thickarrowdoubleleft     : result = "<<="
        of thickarrowdoubleright    : result = "=>>"
        of thickarrowdoubleboth     : result = "<<=>>"
        of arrowleft                : result = "<-"
        of arrowright               : result = "->"
        of arrowboth                : result = "<->"
        of arrowdoubleleft          : result = "<<-"
        of arrowdoubleright         : result = "->>"
        of arrowdoubleboth          : result = "<<->>"
        of reversearrowleft         : result = "-<"
        of reversearrowright        : result = ">-"
        of reversearrowboth         : result = ">-<"
        of reversearrowdoubleleft   : result = "-<<"
        of reversearrowdoubleright  : result = ">>-"
        of reversearrowdoubleboth   : result = ">>-<<"
        of doublearrowleft          : result = "<<"
        of doublearrowright         : result = ">>"
        of triplearrowleft          : result = "<<<"
        of triplearrowright         : result = ">>>"
        of longarrowleft            : result = "<--"
        of longarrowright           : result = "-->"
        of longarrowboth            : result = "<-->"
        of longthickarrowleft       : result = "<=="
        of longthickarrowright      : result = "==>"
        of longthickarrowboth       : result = "<==>"
        of tildeleft                : result = "<~"
        of tilderight               : result = "~>"
        of tildeboth                : result = "<~>"
        of triangleright            : result = "|>"
        of triangleleft             : result = "<|"
        of triangleboth             : result = "<|>"

        of equalless                : result = "=<"
        of greaterequal             : result = ">="
        of lessgreater              : result = "<>"

        of lesscolon                : result = "<:"
        of minuscolon               : result = "-:"
        of greatercolon             : result = ">:"

        of tilde                    : result = "~"
        of exclamation              : result = "!"
        of doubleexclamation        : result = "!!"
        of question                 : result = "?"
        of doublequestion           : result = "??"
        of at                       : result = "@"
        of sharp                    : result = "#"
        of doublesharp              : result = "##"
        of triplesharp              : result = "###"
        of quadruplesharp           : result = "####"
        of quintuplesharp           : result = "#####"
        of sextuplesharp            : result = "######"
        of dollar                   : result = "$"
        of percent                  : result = "%"
        of caret                    : result = "^"
        of ampersand                : result = "&"
        of asterisk                 : result = "*"
        of minus                    : result = "-"
        of doubleminus              : result = "--"
        of underscore               : result = "_"
        of equal                    : result = "="
        of doubleequal              : result = "=="
        of approxequal              : result = "=~"
        of plus                     : result = "+"
        of doubleplus               : result = "++"
        of lessthan                 : result = "<"
        of greaterthan              : result = ">"
        of slash                    : result = "/"
        of slashpercent             : result = "/%"
        of doubleslash              : result = "//"
        of backslash                : result = "\\"
        of doublebackslash          : result = "\\\\"
        of logicaland               : result = "/\\"
        of logicalor                : result = "\\/"
        of pipe                     : result = "|"
        of turnstile                : result = "|-"
        of doubleturnstile          : result = "|="

        of ellipsis                 : result = ".."
        of longellipsis             : result = "..."
        of dotslash                 : result = "./"
        of colon                    : result = ":"
        of doublecolon              : result = "::"
        of doublepipe               : result = "||"

        of slashedzero              : result = "ø"
        of infinite                 : result = "∞"

        of unaliased                : discard