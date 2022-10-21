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

