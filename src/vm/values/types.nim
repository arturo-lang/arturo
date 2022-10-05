######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/types.nim
######################################################

#=======================================
# Libraries
#=======================================

import tables, times, unicode

when not defined(NOSQLITE):
    import db_sqlite as sqlite

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums

import helpers/bytes

import vm/values/custom/[vcolor, vcomplex, vquantity, vrational, vregex]

#=======================================
# Types
#=======================================
 
type
    ValueArray* = seq[Value]
    ValueDict*  = OrderedTable[string,Value]

    Translation* = ref object
        constants*: ValueArray
        instructions*: ByteArray

    IntArray*   = seq[int]

    BuiltinAction* = proc ()

    SymbolKind* = enum
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

    # TODO(VM/values/value) add new `:matrix` type?
    #  this would normally go with a separate Linear Algebra-related stdlib module
    #  labels: vm, values, enhancement, open discussion

    # TODO(VM/values/value) add new `:typeset` type?
    #  or... could this be encapsulated in our existing `:type` values?
    #  labels: vm, values, enhancement, open discussion

    # TODO(VM/values/value) add new lazy-sequence/range type?
    #  Right now, declaring a block or a range - e.g. `1..10` - actually pushes all required elements into a new block.
    #  If their number is quite high, then there are some obvious performance-related drawbacks.
    #  It would be great if we could define some special sequences, only by their limits - including infinity - and have our regular functions, especially iterators, operate on them!
    #  labels: vm, values, library, enhancement, open discussion
    ValueKind* = enum
        Null            = 0
        Logical         = 1
        Integer         = 2
        Floating        = 3
        Complex         = 4
        Rational        = 5
        Version         = 6
        Type            = 7
        Char            = 8
        String          = 9
        Word            = 10
        Literal         = 11
        Label           = 12
        Attribute       = 13
        AttributeLabel  = 14
        Path            = 15
        PathLabel       = 16
        Symbol          = 17
        SymbolLiteral   = 18

        Quantity        = 19
        Regex           = 20
        Color           = 21
        Date            = 22
        Binary          = 23
        Dictionary      = 24
        Object          = 25
        Function        = 26
        Inline          = 27
        Block           = 28
        Database        = 29
        Bytecode        = 30

        Newline         = 31
        Nothing         = 32
        Any             = 33

    ValueSpec* = set[ValueKind]

    IntegerKind* = enum
        NormalInteger
        BigInteger

    FunctionKind* = enum
        UserFunction
        BuiltinFunction

    TypeKind* = enum
        UserType
        BuiltinType

    DatabaseKind* = enum
        SqliteDatabase
        MysqlDatabase

    PrecedenceKind* = enum
        InfixPrecedence
        PrefixPrecedence
        PostfixPrecedence

    AliasBinding* = object
        precedence*: PrecedenceKind
        name*:       Value

    Prototype* = ref object
        name*       : string
        fields*     : ValueArray
        methods*    : ValueDict
        inherits*   : Prototype

    SymbolDict*   = OrderedTable[SymbolKind,AliasBinding]

    logical* = enum
        False = 0, 
        True = 1,
        Maybe = 2

    Value* {.acyclic.} = ref object 
        info*: string

        case kind*: ValueKind:
            of Null,
               Nothing,
               Any:        discard 
            of Logical:     b*  : logical
            of Integer:  
                case iKind*: IntegerKind:
                    # TODO(VM/values/value) Wrap Normal and BigInteger in one type
                    #  Perhaps, we could do that via class inheritance, with the two types inheriting a new `Integer` type, provided that it's properly benchmarked first.
                    #  labels: vm, values, enhancement, benchmark, open discussion 
                    of NormalInteger:   i*  : int
                    of BigInteger:      
                        when defined(WEB):
                            bi* : JsBigInt
                        elif not defined(NOGMP):
                            bi* : Int    
                        else:
                            discard
            of Floating: f*: float
            of Complex:     z*  : VComplex
            of Rational:    rat*  : VRational
            of Version: 
                major*   : int
                minor*   : int
                patch*   : int
                extra*   : string
            of Type:        
                t*  : ValueKind
                case tpKind*: TypeKind:
                    of UserType:    ts* : Prototype
                    of BuiltinType: discard
            of Char:        c*  : Rune
            of String,
               Word,
               Literal,
               Label:       s*  : string
            of Attribute,
               AttributeLabel:   r*  : string
            of Path,
               PathLabel:   p*  : ValueArray
            of Symbol,
               SymbolLiteral:      
                   m*  : SymbolKind
            of Regex:       rx* : VRegex
            of Quantity:
                nm*: Value
                unit*: VQuantity
            of Color:       l*  : VColor
            of Date:        
                e*     : ValueDict         
                eobj*  : DateTime
            of Binary:      n*  : ByteArray
            of Inline,
               Block:       
                   a*       : ValueArray
                   data*    : Value
                   dirty*   : bool
            of Dictionary:  d*  : ValueDict
            of Object:
                o*: ValueDict   # fields
                proto*: Prototype # custom type pointer
            of Function:    
                args*   : OrderedTable[string,ValueSpec]
                attrs*  : OrderedTable[string,(ValueSpec,string)]
                returns*: ValueSpec
                example*: string
                case fnKind*: FunctionKind:
                    of UserFunction:
                        # TODO(VM/values/value) merge Function `params` and `args` into one field?
                        #  labels: vm, values, enhancement
                        params*     : Value
                        main*       : Value
                        imports*    : Value
                        exports*    : Value
                        exportable* : bool
                        memoize*    : bool
                    of BuiltinFunction:
                        fname*      : string
                        alias*      : SymbolKind
                        prec*       : PrecedenceKind
                        # TODO(VM/values/value) `arity` should be common to both User and BuiltIn functions
                        #  Usually, when we want to get a User function's arity, we access its `params.a.len` - this doesn't make any sense. Plus, it's slower.
                        #  labels: vm, values, enhancement
                        arity*      : int
                        action*     : BuiltinAction

            of Database:
                case dbKind*: DatabaseKind:
                    of SqliteDatabase: 
                        when not defined(NOSQLITE):
                            sqlitedb*: sqlite.DbConn
                    of MysqlDatabase: discard
                    #mysqldb*: mysql.DbConn
            of Bytecode:
                trans*: Translation

            of Newline:
                line*: int
