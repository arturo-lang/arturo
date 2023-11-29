#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Types.nim
#=======================================================

## The main Types module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

#=======================================
# Definitions
#=======================================

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------

    builtin "type",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get type of given value",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Type},
        example     = """
            print type 18966          ; :integer
            print type "hello world"  ; :string
        """:
            #=======================================================
            if xKind != Object:
                push(newType(xKind))
            else:
                push(newUserType(x.proto.name))

    #----------------------------
    # Predicates
    #----------------------------