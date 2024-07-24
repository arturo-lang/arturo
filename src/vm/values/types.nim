#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/types.nim
#=======================================================

## The main type definitions for the VM.

#=======================================
# Libraries
#=======================================

import std/[tables, times, unicode, setutils]

when not defined(NOSQLITE):
    import extras/db_connector/db_sqlite as sqlite

when defined(WEB):
    import std/jsbigints

when defined(GMP):
    import helpers/bignums

import vm/opcodes
import vm/values/custom/[vbinary, vcolor, vcomplex, verror, vlogical, vquantity, vrange, vrational, vregex, vsymbol, vversion]
import vm/values/flags

when not defined(WEB):
    import vm/values/custom/[vsocket]

#=======================================
# Types
#=======================================

type
    ValueArray* = seq[Value]

    ValueDictObj*   = OrderedTable[string, Value]
    ValueDict*      = OrderedTableRef[string, Value]

    SymTable*   = Table[string, Value]

    Translation* = ref object
        constants*: ValueArray
        instructions*: VBinary

    IntArray*   = seq[int]

    BuiltinAction* = proc ()

    # TODO(VM/values/types) add new `:matrix` type?
    #  this would normally go with a separate Linear Algebra-related stdlib module
    #  labels: vm, values, enhancement, open discussion

    # TODO(VM/values/types) add new `:typeset` type?
    #  or... could this be encapsulated in our existing `:type` values?
    #  labels: vm, values, enhancement, open discussion

    # TODO(Vm/values/types) add new `:exception` type?
    #  this could work well with a new potential `try?`/`catch` syntax, 
    #  or a `throw` method
    #  labels: vm, values, enhancement, open discussion

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
        PathLiteral     = 17
        Symbol          = 18
        SymbolLiteral   = 19

        Unit            = 20
        Quantity        = 21
        Error           = 22
        ErrorKind       = 23
        Regex           = 24
        Color           = 25
        Date            = 26
        Binary          = 27
        Dictionary      = 28
        Object          = 29
        Store           = 30
        Function        = 31
        Method          = 32
        Inline          = 33
        Block           = 34
        Module          = 35
        Range           = 36
        Database        = 37
        Socket          = 38    
        Bytecode        = 39

        Nothing         = 40
        Any             = 41

    ValueSpec* = set[ValueKind]

    IntegerKind* = enum
        NormalInteger
        BigInteger

    FunctionKind* = enum
        UserFunction
        BuiltinFunction

    StoreKind* = enum
        NativeStore
        JsonStore
        SqliteStore
        UndefinedStore

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
        name*           : string
        content*        : ValueDict
        inherits*       : Value
        fields*         : ValueDict
        super*          : ValueDict

    MagicMethodInternal* = 
        proc (values: ValueArray)

    MagicMethod* = enum
        ConstructorM        = "init"

        GetM                = "get"
        SetM                = "set"

        ChangingM           = "changing"
        ChangedM            = "changed"

        CompareM            = "compare"
        EqualQM             = "equal?"
        LessQM              = "less?"
        GreaterQM           = "greater?"

        AddM                = "add"
        SubM                = "sub"
        MulM                = "mul"
        DivM                = "div"
        FDivM               = "fdiv"
        ModM                = "mod"
        PowM                = "pow"

        IncM                = "inc"
        DecM                = "dec"

        NegM                = "neg"

        KeyQM               = "key?"
        ContainsQM          = "contains?"

        AppendM             = "append"
        RemoveM             = "remove"

        ToStringM           = "string"
        ToIntegerM          = "integer"
        ToFloatingM         = "floating"
        ToRationalM         = "rational"
        ToComplexM          = "complex"
        ToQuantityM         = "quantity"
        ToLogicalM          = "logical"
        ToBlockM            = "block"
        ToDictionaryM       = "dictionary"

    MagicMethods* = Table[MagicMethod, MagicMethodInternal]

    SymbolDict*   = OrderedTable[VSymbol,AliasBinding]

    ValueInfo* = ref object
        descr*          : string
        module*         : string

        when defined(DOCGEN):
            line*       : int

        case kind*: ValueKind:
            of Function, Method:
                args*       : OrderedTable[string,ValueSpec]
                attrs*      : OrderedTable[string,(ValueSpec,string)]
                returns*    : ValueSpec
                when defined(DOCGEN):
                    example*    : string
                path*       : ref string
            else:
                discard

    VFunction* = ref object
        arity*  : int8

        case fnKind*: FunctionKind:
            of UserFunction:
                params*     : seq[string]
                main*       : Value
                imports*    : Value
                exports*    : Value
                memoize*    : bool
                inline*     : bool
                bcode*      : Value
            of BuiltinFunction:
                op*         : OpCode
                action*     : BuiltinAction

    VMethod* = ref object
        marity*     : int8
        mparams*    : seq[string]
        mmain*      : Value
        mbcode*     : Value
        mdistinct*  : bool
        mpublic*    : bool

    VStore* = ref object
        data*       : ValueDict     # the actual data
        path*       : string        # the path to the store

        global*     : bool          # whether the store is global (saved in the main ~/.arturo/stores folder) or not
        loaded*     : bool          # has the store been loaded (=read from disk) yet?
        autosave*   : bool          # should the store be saved automatically after every change?
        pending*    : bool          # are there pending changes to be saved?
        
        forceLoad*  : proc(store:VStore)    # ensureLoaded wrapped as a field proc

        case kind*: StoreKind:
            of SqliteStore:
                when not defined(NOSQLITE):
                    db* : sqlite.DbConn
            else:
                discard

    # TODO(VM/values/types) Re-optimize Value object size
    #  Quantity + Rational values specifically
    #  labels: vm, values, enhancement
    Value* {.final,acyclic.} = ref object
        info*   : ValueInfo

        ln*     : uint32
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
                        elif defined(GMP):
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
                    of UserType:    tid* : string
                    of BuiltinType: discard
            of Char:        c*  : Rune
            of String,
               Word,
               Literal,
               Label,
               Attribute,
               AttributeLabel:       s*  : string
            of Path,
               PathLabel,
               PathLiteral      :   p*  : ValueArray
            of Symbol,
               SymbolLiteral:
                m*  : VSymbol
            of Regex:       rx* : VRegex
            of Unit:        u*  : VUnit
            of Quantity:    q*  : VQuantity
            of Error: 
                err*: VError
            of ErrorKind:
                errKind*: VErrorKind
            of Color:       l*  : VColor
            of Date:
                e*     : ValueDict
                eobj*  : ref DateTime
            of Binary:      n*  : VBinary
            of Inline,
               Block:
                   a*       : ValueArray
                   data*    : Value
            of Module:
                singleton*  : Value
            of Range:
                rng*    : VRange
            of Dictionary:  d*  : ValueDict
            of Object:
                proto*  : Prototype 
                o*      : ValueDict 
                magic*  : MagicMethods
            of Store:
                sto*: VStore
            of Function:
                funcType*: VFunction
            of Method:
                methType*: VMethod
            of Database:
                case dbKind*: DatabaseKind:
                    of SqliteDatabase:
                        when not defined(NOSQLITE):
                            sqlitedb*: sqlite.DbConn
                    of MysqlDatabase: discard
                    #mysqldb*: mysql.DbConn
            of Socket:
                when not defined(WEB):
                    sock*: VSocket
            of Bytecode:
                trans*: Translation

    ValueObj = typeof(Value()[])

#=======================================
# Constants
#=======================================

let 
    NoPrototypeFound* = Prototype(name: "prototype-error")

#=======================================
# Variables
#=======================================

var
    TypeLookup*: OrderedTable[string,Prototype]

#=======================================
# Compile-Time Warnings
#=======================================

when sizeof(ValueObj) > 64:
    type
        FuncObj = typeof(VFunction()[])

    {.warning: "Value's inner object is large which will impact performance".}
    {.hints: on.} # Apparently we cannot disable just `Name` hints?
    {.hint: "Value's inner type is currently " & $sizeof(ValueObj) & ".".}
    {.hint: "Function's inner type is currently " & $sizeof(FuncObj) & ".".}
    {.hints: off.}

#=======================================
# Accessors
#=======================================

# Flags

template readonly*(val: Value): bool = IsReadOnly in val.flags
template `readonly=`*(val: Value, newVal: bool) = val.flags[IsReadOnly] = newVal

template dynamic*(val: Value): bool = IsDynamic in val.flags
template `dynamic=`*(val: Value, newVal: bool) = val.flags[IsDynamic] = newVal

template b*(val: Value): VLogical = VLogical(val.flags - NonLogicalF)
template `b=`*(val: Value, newVal: VLogical) = val.flags = val.flags - LogicalF + newVal

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
when defined(DOCGEN):
    makeAccessor(info, example)
makeAccessor(info, path)

# Version

makeAccessor(version, major)
makeAccessor(version, minor)
makeAccessor(version, patch)
makeAccessor(version, prerelease)
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
makeAccessor(funcType, op)

# Method

makeAccessor(methType, marity)
makeAccessor(methType, mparams)
makeAccessor(methType, mmain)
makeAccessor(methType, mbcode)
makeAccessor(methType, mdistinct)
makeAccessor(methType, mpublic)

#=======================================
# Helpers
#=======================================

template getValuePair*(): untyped =
    ## get ValuePair value for given x and y Value objects
    ## so that we can check against given ValuePair's inside
    ## a case statement
    ##
    ## Caution: since it's a template, its value is meant to
    ## be assigned first to a variable and *then* we may use
    ## that variable. Doing something like `case getValuePair():`
    ## would lead to an infinite number of code repetitions!
    when not declared(xKind):
        let xKind {.inject.} = x.kind
    when not declared(yKind):
        let yKind {.inject.} = y.kind

    (cast[uint32](ord(xKind)) shl 16.uint32) or 
    (cast[uint32](ord(yKind))) or  
    (cast[uint32](cast[uint32](xKind==Integer) * cast[uint32](x.iKind==BigInteger)) shl 31) or
    (cast[uint32](cast[uint32](yKind==Integer) * cast[uint32](y.iKind==BigInteger)) shl 15)

proc `||`*(va: static[ValueKind | IntegerKind], vb: static[ValueKind | IntegerKind]): uint32 {.compileTime.}=
    ## generate a ValuePair value for given va and vb Value kinds
    ## the codes are produced statically, at compile time and are
    ## meant to be used solely in a case statement
    when va is ValueKind:
        result = cast[uint32](ord(va)) shl 16
    elif va is IntegerKind:
        when va == NormalInteger:
            result = cast[uint32](ord(Integer)) shl 16
        elif va == BigInteger:
            result = cast[uint32](ord(Integer)) shl 16 or (1.uint32 shl 31)

    when vb is ValueKind:
        result = result or cast[uint32](ord(vb))
    elif vb is IntegerKind:
        when vb == NormalInteger:
            result = result or cast[uint32](ord(Integer))
        elif vb == BigInteger:
            result = result or cast[uint32](ord(Integer)) or (1.uint32 shl 15)

template fetch*(what: MagicMethods, magicMethodId: MagicMethod): untyped {.dirty.} =
    (let mgk = what.getOrDefault(magicMethodId, nil); not mgk.isNil)

template `in`*(z: ValueKind, typeset: untyped): untyped {.dirty.} =
    contains(system.set[ValueKind](typeset), z)

#=======================================
# Methods
#=======================================

proc setType*(tid: string, proto: Prototype = nil) {.inline.} =
    if proto.isNil:
        discard TypeLookup.hasKeyOrPut(tid, nil)
    else:
        TypeLookup[tid] = proto

proc getType*(tid: string, safe: static bool = false): Prototype {.inline.} =
    when safe:
        return TypeLookup.getOrDefault(tid, NoPrototypeFound)
    else:
        return TypeLookup[tid]

proc newPrototype*(name: string, content: ValueDict, inherits: Value, fields: ValueDict = newOrderedTable[string,Value](), super: ValueDict = newOrderedTable[string,Value]()): Prototype {.inline.} =
    Prototype(name: name, content: content, inherits: inherits, fields: fields, super: super)
