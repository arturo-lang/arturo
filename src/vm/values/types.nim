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

import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol, vversion]
import vm/values/flags

#=======================================
# Types
#=======================================

type
    ValueArray* = seq[Value]
    ValueDict*  = OrderedTable[string, Value]

    SymTable*   = Table[string, Value]

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

    ValueInfo* = ref object
        descr*          : string
        module*         : string

        when defined(DOCGEN):
            line*       : int

        case kind*: ValueKind:
            of Function:
                args*       : OrderedTable[string,ValueSpec]
                attrs*      : OrderedTable[string,(ValueSpec,string)]
                returns*    : ValueSpec
                example*    : string
            else:
                discard

    VFunction* = ref object
        arity*  : int8
        case fnKind*: FunctionKind:
            of UserFunction:
                # TODO(VM/values/types) merge Function `params` and `args` into one field?
                #  labels: vm, values, enhancement
                params*     : seq[string]
                main*       : Value
                imports*    : Value
                exports*    : Value
                memoize*    : bool
                inline*     : bool
                bcode*      : Value
            of BuiltinFunction:
                action*     : BuiltinAction

    Value* {.final,acyclic.} = ref object
        info*   : ValueInfo
        flags*  : ValueFlags

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
    FuncObj = typeof(VFunction()[])

# Benchmarking
{.hints: on.} # Apparently we cannot disable just `Name` hints?
{.hint: "Value's inner type is currently " & $sizeof(ValueObj) & ".".}
{.hint: "Function's inner type is currently " & $sizeof(FuncObj) & ".".}
{.hints: off.}

when sizeof(ValueObj) > 72: # At time of writing it was '72', 8 - 64 bit integers seems like a good warning site? Can always go smaller
    {.warning: "'Value's inner object is large which will impact performance".}

#=======================================
# Accessors
#=======================================

# Flags

template readonly*(val: Value): bool = IsReadOnly in val.flags
template `readonly=`*(val: Value, newVal: bool) = val.flags[IsReadOnly] = newVal

template dirty*(val: Value): bool = IsDirty in val.flags
template `dirty=`*(val: Value, newVal: bool) = val.flags[IsDirty] = newVal

template dynamic*(val: Value): bool = IsDynamic in val.flags
template `dynamic=`*(val: Value, newVal: bool) = val.flags[IsDynamic] = newVal

template b*(val: Value): VLogical = VLogical(val.flags - NonLogicalF)
template `b=`*(val: Value, newVal: VLogical) = val.flags = val.flags - LogicalF + newVal

template info*(val: Value): lent string =
    if val.infoRef.isNil:
        ""
    else:
        val.infoRef[]
template `info=`*(val: Value, newVal: string) =
    if val.infoRef.isNil:
        new val.infoRef
    val.infoRef[] = newVal

template makeAccessor(field, subfield: untyped) =
    template subfield*(val: Value): typeof(val.field.subfield) =
        val.field.subfield

    template `subfield=`*(val: Value, newVal: typeof(val.field.subfield)) =
        val.field.subfield = newVal

# Info

makeAccessor(info, descr)
makeAccessor(info, module)
makeAccessor(info, args)
makeAccessor(info, attrs)
makeAccessor(info, returns)
makeAccessor(info, example)

# Version

makeAccessor(version, major)
makeAccessor(version, minor)
makeAccessor(version, patch)
makeAccessor(version, extra)

# Function

makeAccessor(funcType, arity)
makeAccessor(funcType, fnKind)
makeAccessor(funcType, params)
makeAccessor(funcType, main)
makeAccessor(funcType, imports)
makeAccessor(funcType, exports)
makeAccessor(funcType, memoize)
makeAccessor(funcType, bcode)
makeAccessor(funcType, inline)
makeAccessor(funcType, action)
