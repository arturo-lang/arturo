#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/types.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import std/[tables, times, unicode, setutils]

when not defined(NOSQLITE):
    import db_sqlite as sqlite

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums

import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol]

#=======================================
# Types
#=======================================

type
    ValueArray* = seq[Value]
    ValueDict*  = OrderedTable[string, Value]

    Translation* = ref object
        constants*: ValueArray
        instructions*: VBinary

    IntArray*   = seq[int]

    BuiltinAction* = proc ()

    # TODO(VM/values/types add new `:matrix` type?
    #  this would normally go with a separate Linear Algebra-related stdlib module
    #  labels: vm, values, enhancement, open discussion

    # TODO(VM/values/types) add new `:typeset` type?
    #  or... could this be encapsulated in our existing `:type` values?
    #  labels: vm, values, enhancement, open discussion

    # TODO(VM/values/types) add new lazy-sequence/range type?
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
        doInit*     : proc (v:Value)
        doPrint*    : proc (v:Value): string
        doCompare*  : proc (a,b:Value): int
        inherits*   : Prototype

    SymbolDict*   = OrderedTable[VSymbol,AliasBinding]

    VFunction* = ref object
        args*   : OrderedTable[string,ValueSpec]
        attrs*  : OrderedTable[string,(ValueSpec,string)]
        arity*  : int
        returns*: ValueSpec
        example*: string
        case fnKind*: FunctionKind:
            of UserFunction:
                # TODO(VM/values/types) merge Function `params` and `args` into one field?
                #  labels: vm, values, enhancement
                params*     : Value
                main*       : Value
                imports*    : Value
                exports*    : Value
                memoize*    : bool
                inline*     : bool
                bcode*      : Value
            of BuiltinFunction:
                action*     : BuiltinAction
    VVersion* = ref object
        major*   : int
        minor*   : int
        patch*   : int
        extra*   : string

    ValueFlag* = enum
      isDirty, isDynamic, isReadOnly, isTrue, isMaybe

    ValueFlags* = set[ValueFlag]

    Value* {.final,acyclic.} = ref object
        info*: string
        flags*: ValueFlags

        case kind*: ValueKind:
            of Null,
               Nothing,
               Any,
               Logical:
                   discard
            of Integer:
                case iKind*: IntegerKind:
                    # TODO(VM/values/types) Wrap Normal and BigInteger in one type
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
                version*: VVersion
            of Type:
                t*  : ValueKind
                case tpKind*: TypeKind:
                    of UserType:    ts* : Prototype
                    of BuiltinType: discard
            of Char:        c*  : Rune
            of String,
               Word,
               Literal,
               Label,
               Attribute,
               AttributeLabel:       s*  : string
            of Path,
               PathLabel:   p*  : ValueArray
            of Symbol,
               SymbolLiteral:
                   m*  : VSymbol
            of Regex:       rx* : VRegex
            of Quantity:
                nm*: Value
                unit*: VQuantity
            of Color:       l*  : VColor
            of Date:
                e*     : ValueDict
                eobj*  : ref DateTime
            of Binary:      n*  : VBinary
            of Inline,
               Block:
                   a*       : ValueArray
                   data*    : Value
            of Dictionary:  d*  : ValueDict
            of Object:
                o*: ValueDict   # fields
                proto*: Prototype # custom type pointer
            of Function:
                funcType*: VFunction
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
    ValueObj = typeof(Value()[])

{.hints: on.} # Apparently we cannot disable just `Name` hints?
{.hint: "'Value's inner type is currently '" & $sizeof(ValueObj) & "'.".}
{.hints: off.}

when sizeof(ValueObj) > 72: # At time of writing it was '72', 8 - 64 bit integers seems like a good warning site? Can always go smaller
    {.warning: "'Value's inner object is large which will impact performance".}

proc readonly*(val: Value): bool {.inline.} = isReadOnly in val.flags
proc `readonly=`*(val: Value, newVal: bool) {.inline.} = val.flags[isReadOnly] = newVal

proc dirty*(val: Value): bool {.inline.} = isDirty in val.flags
proc `dirty=`*(val: Value, newVal: bool) {.inline.} = val.flags[isDirty] = newVal

proc b*(val: Value): VLogical {.inline.} =
    assert val.kind == Logical
    assert (val.flags * {isMaybe, isTrue}).len <= 1 # Ensure we do not have {isMaybe, isTrue}
    if val.flags * {isMaybe} == {isMaybe}:
        Maybe
    elif val.flags * {isTrue} == {isTrue}:
        True
    else:
        False

proc `b=`*(val: Value, newVal: VLogical) {.inline.} =
    assert val.kind == Logical
    case newVal
    of Maybe:
        val.flags.excl isTrue
        val.flags.incl isMaybe
    of True:
        val.flags.excl isMaybe
        val.flags.incl isTrue
    else:
        val.flags.excl {isMaybe, isTrue}


template makeVersionAccessor(name: untyped) =
    proc name*(val: Value): typeof(val.version.name) {.inline.} =
        assert val.kind == Version
        val.version.name

    proc `name=`*(val: Value, newVal: typeof(val.version.name)) {.inline.} =
        assert val.kind == Version
        val.version.name = newVal

makeVersionAccessor(major)
makeVersionAccessor(minor)
makeVersionAccessor(patch)
makeVersionAccessor(extra)

template makeFuncAccessor(name: untyped) =
    proc name*(val: Value): typeof(val.funcType.name) {.inline.} =
        assert val.kind == Function
        val.funcType.name

    proc `name=`*(val: Value, newVal: typeof(val.funcType.name)) {.inline.} =
        assert val.kind == Function
        val.funcType.name = newVal


makeFuncAccessor(args)
makeFuncAccessor(attrs)
makeFuncAccessor(arity)
makeFuncAccessor(returns)
makeFuncAccessor(example)
makeFuncAccessor(fnKind)
makeFuncAccessor(params)
makeFuncAccessor(main)
makeFuncAccessor(imports)
makeFuncAccessor(exports)
makeFuncAccessor(memoize)
makeFuncAccessor(bcode)
makeFuncAccessor(inline)
makeFuncAccessor(action)



converter toDateTime*(dt: ref DateTime): DateTime = dt[]
