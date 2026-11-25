#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/values/types.nim
#=======================================================

## The main type definitions for the VM.

#=======================================
# Libraries
#=======================================

import std/[deques, tables, times, unicode, setutils]

when not defined(WEB):
    import std/asyncfutures, std/osproc

when defined(SQLITE):
    import extras/db_connector/db_sqlite as sqlite

when defined(WEB):
    import std/jsbigints

when defined(GMP):
    import helpers/bignums

import vm/opcodes
import vm/values/custom/[vbinary, vcolor, vcomplex, verror, vevent, vlogical, vquantity, vrange, vrational, vregex, vsymbol, vtask, vversion]
import vm/values/flags

when defined(NANBOX):
    import std/macros

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

    SymSlots*   = object
        vals*: seq[Value]

    ScopeEntry* = tuple[id: int32, prev: Value, stamp: uint64]
    ScopeFrame* = object
        serial*: uint64
        entries*: seq[ScopeEntry]

    Translation* = ref object
        constants*: ValueArray
        instructions*: VBinary

    IntArray*   = seq[int]

    BuiltinAction*  = proc ()
    ModuleDef*      = proc(moduleName: string)

    # TODO(VM/values/types) add new `:matrix` type?
    #  this would normally go with a separate Linear Algebra-related stdlib module
    #  labels: vm, values, enhancement, open discussion

    # TODO(VM/values/types) add new `:typeset` type?
    #  or... could this be encapsulated in our existing `:type` values?
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
        Task            = 40
        Event           = 41
        Channel         = 42

        Nothing         = 43
        Any             = 44

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
                paramIds*   : seq[int32]    # their symbol ids, resolved on first call
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
        mparamIds*  : seq[int32]    # their symbol ids, resolved on first call
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
                when defined(SQLITE):
                    db* : sqlite.DbConn
            else:
                discard

    VTask* = ref object
        state*       : VTaskState        # bookkeeping for `done?` / `cancel`
        name*        : string            # optional symbolic name (`do.async.as: "fetch-1"`); shown in print/inspect for debugging. empty = unnamed
        when not defined(WEB):
            future*  : Future[Value]    # the actual handle a producer (e.g. `request.async`) feeds
            process* : Process          # the underlying OS process (for subprocess-backed tasks); nil otherwise
            cancelHandle* : proc() {.closure.}  # invoked by `cancel` for in-process tasks; closes the live handle (file, http client, …) so the future actually unwinds. nil for subprocess-backed tasks.

    VChannel* = ref object
        name*         : string              # symbolic identity for `print` / `inspect`
        capacity*     : int                 # 0 = unbuffered, -1 = unbounded, N > 0 = bounded
        closed*       : bool                # once true, sends raise, recvs drain then return null
        when not defined(WEB):
            buffer*      : Deque[Value]                       # buffered items
            senders*     : Deque[tuple[v: Value, f: Future[void]]]  # parked while full
            receivers*   : Deque[Future[Value]]                # parked while empty

    ValueRef* {.final,acyclic.} = ref object
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
               AttributeLabel:
                   s*  : string
                   sid*: int32
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
                   cachedTrans* : Translation   # set only on read-only (constant) blocks
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
                        when defined(SQLITE):
                            sqlitedb*: sqlite.DbConn
                    of MysqlDatabase: discard
                    #mysqldb*: mysql.DbConn
            of Socket:
                when not defined(WEB):
                    sock*: VSocket
            of Bytecode:
                trans*: Translation
            of Task:
                tsk*: VTask
            of Event:
                evt*: VEvent
            of Channel:
                when not defined(WEB):
                    chn*: VChannel

    ValueObj* = typeof(ValueRef()[])

    # With -d:NANBOX, a Value is a single 64-bit word
    # (see: NaN-boxing, below)
    NanBoxedValue* = object
        bits*: uint64

    Value* = (when defined(NANBOX): NanBoxedValue else: ValueRef)

#=======================================
# NaN-boxing
#=======================================

# With -d:NANBOX, a Value is a single 64-bit word: the values that fit in it
# are held right there (no allocation, no reference counting) and everything
# else is a pointer to a ValueRef on the heap.
#
# An IEEE 754 double is laid out like this:
#
#   S[Exponent-][Mantissa------------------------------------------]
#   1 sign bit, 11 exponent bits, 52 mantissa bits
#
# and any double with all of its exponent bits set is a NaN - there are
# lots of different bit patterns for it, but we need just one. All the others
# are free for us to use.
#
# Here, the top 16 bits of a Value tell what it is:
#
#   top 16 bits      | what it is          | the rest (48 bits)
#   -----------------|---------------------|------------------------------
#   0x0000           | pointer to ValueRef | the address (0 = nil)
#   0x0001           | -                   | (unused)
#   0x0002 .. 0xFFF2 | Floating            | its bits + 2^49 (with the top 16)
#   0xFFF3 .. 0xFFFA | -                   | (unused)
#   0xFFFB           | Type (built-in)     | the ValueKind it stands for
#   0xFFFC           | Char                | its code point
#   0xFFFD           | Null, Any, Logical  | 0: null, 1: any, 2: false,
#                    |                     | 3: true, 4: maybe
#   0xFFFE           | -                   | (unused)
#   0xFFFF           | Integer             | its value: 48 bits, signed
#
# Why so:
#
# - A pointer is held as it is: no tag, no masking. On 64-bit systems,
#   addresses only use the lower 48 bits, so the top 16 bits are always 0.
#   And all-zero is nil - which is what the memory we get from Nim
#   (new sequence items, fields, results) starts as.
#
# - A Floating is held with 2^49 added to its bits - so that 0.0 is not
#   all-zero (that's nil), and that no double ends up in 0x0000 or 0x0001.
#   Doubles go up to 0xFFF0... (-inf), so they end up between 0x0002...
#   and 0xFFF2... - and every NaN is held as the same one, so that none of
#   them gets in the way of the other kinds.
#
# - A built-in Type (:integer, :string, ...) is the ValueKind it stands for;
#   user-defined types are regular ValueRefs.
#
# - A Char is its code point (a Rune: 32 bits).
#
# - Null, Any & the three Logicals are just a number each: comparing them
#   is comparing the bits.
#
# - An Integer that doesn't fit in 48 bits (beyond ±140737488355327) is
#   a regular ValueRef on the heap. Values are always constructed through
#   newInteger, so the inline form is used whenever possible.

when defined(NANBOX):
    # The accessors are tiny & on every hot path: {.inline.} is
    # only a hint to the C compiler, so we insist
    when defined(gcc) or defined(clang) or defined(llvm_gcc):
        {.pragma: nbInline, inline, codegenDecl: "static inline __attribute__((always_inline)) $# $#$#".}
    else:
        {.pragma: nbInline, inline.}

    const
        NbPayload       = 0x0000_FFFF_FFFF_FFFF'u64
        NbIntegerTag    = 0xFFFF_0000_0000_0000'u64
        NbFloatingShift = 1'u64 shl 49
        NbTypeTag       = 0xFFFB_0000_0000_0000'u64
        NbCharTag       = 0xFFFC_0000_0000_0000'u64
        NbSingletonTag  = 0xFFFD_0000_0000_0000'u64
        NbNullBits*     = NbSingletonTag or 0
        NbFalseBits*    = NbSingletonTag or 2
        NbTrueBits*     = NbSingletonTag or 3
        NbMaybeBits*    = NbSingletonTag or 4
        NbIntegerMin*   = -(1 shl 47)
        NbIntegerMax*   = (1 shl 47) - 1

    # The hooks have to be declared before anything that contains a Value
    # gets its own ones generated
    proc `=wasMoved`*(v: var NanBoxedValue) {.nbInline.}
    proc `=destroy`*(v: NanBoxedValue) {.nbInline.}
    proc `=copy`*(d: var NanBoxedValue, s: NanBoxedValue) {.nbInline.}
    proc `=dup`*(s: NanBoxedValue): NanBoxedValue {.nbInline.}
    proc `=sink`*(d: var NanBoxedValue, s: NanBoxedValue) {.nbInline.}

    template nbTop(v: NanBoxedValue): uint64 = v.bits shr 48
    template isRef*(v: NanBoxedValue): bool = nbTop(v) == 0         # (nil included)
    template heapObj*(v: NanBoxedValue): ptr ValueObj = cast[ptr ValueObj](v.bits)
    template heapRef(v: NanBoxedValue): ValueRef = cast[ValueRef](cast[pointer](v.bits))
    template ownsRef(v: NanBoxedValue): bool = isRef(v) and v.bits != 0

    proc `=wasMoved`*(v: var NanBoxedValue) {.nbInline.} =
        v.bits = 0

    proc `=destroy`*(v: NanBoxedValue) {.nbInline.} =
        if ownsRef(v): GC_unref(heapRef(v))

    proc `=copy`*(d: var NanBoxedValue, s: NanBoxedValue) {.nbInline.} =
        if d.bits == s.bits: return
        if ownsRef(s): GC_ref(heapRef(s))
        if ownsRef(d): GC_unref(heapRef(d))
        d.bits = s.bits

    proc `=dup`*(s: NanBoxedValue): NanBoxedValue {.nbInline.} =
        if ownsRef(s): GC_ref(heapRef(s))
        result.bits = s.bits

    proc `=sink`*(d: var NanBoxedValue, s: NanBoxedValue) {.nbInline.} =
        if ownsRef(d): GC_unref(heapRef(d))
        d.bits = s.bits

    converter toValue*(r: sink ValueRef): NanBoxedValue {.nbInline.} =
        ## a heap value, as a Value (that holds a reference to it)
        result.bits = cast[uint64](cast[pointer](r))
        if not r.isNil: GC_ref(r)

    converter toValue*(n: typeof(nil)): NanBoxedValue {.nbInline.} =
        result.bits = 0

    proc isNil*(v: NanBoxedValue): bool {.nbInline.} = v.bits == 0
    proc `==`*(v: NanBoxedValue, n: typeof(nil)): bool {.nbInline.} = v.bits == 0

    template isInlineInteger*(v: NanBoxedValue): bool = nbTop(v) == 0xFFFF

    template isInlineFloating*(v: NanBoxedValue): bool = nbTop(v) >= 0x0002 and nbTop(v) <= 0xFFF2

    template isSingleton*(v: NanBoxedValue): bool = nbTop(v) == 0xFFFD

    func inlineSingleton*(k: ValueKind, l: VLogical = False): NanBoxedValue {.nbInline.} =
        NanBoxedValue(bits: NbSingletonTag or (
            case k:
                of Null: 0'u64
                of Any: 1'u64
                else:
                    if l == False: 2'u64
                    elif l == True: 3'u64
                    else: 4'u64
        ))

    template isInlineType*(v: NanBoxedValue): bool = nbTop(v) == 0xFFFB

    func inlineType*(t: ValueKind): NanBoxedValue {.nbInline.} =
        NanBoxedValue(bits: NbTypeTag or uint64(ord(t)))

    template isInlineChar*(v: NanBoxedValue): bool = nbTop(v) == 0xFFFC

    func inlineChar*(c: Rune): NanBoxedValue {.nbInline.} =
        NanBoxedValue(bits: NbCharTag or uint64(cast[uint32](c)))

    func inlineInteger*(i: int): NanBoxedValue {.nbInline.} =
        NanBoxedValue(bits: NbIntegerTag or (cast[uint64](i) and NbPayload))

    func inlineFloating*(f: float): NanBoxedValue {.nbInline.} =
        var b = cast[uint64](f)
        if f != f: b = 0x7FF8_0000_0000_0000'u64       # one NaN for all
        NanBoxedValue(bits: b + NbFloatingShift)

    # The fields of a ValueRef, on a Value

    proc otherKind(v: NanBoxedValue): ValueKind {.noinline.} =
        if isInlineChar(v): Char
        elif isInlineType(v): Type
        elif isSingleton(v):
            case v.bits and 0xFF:
                of 0: Null
                of 1: Any
                else: Logical
        else: Floating

    proc kind*(v: NanBoxedValue): ValueKind {.nbInline.} =
        if likely(isRef(v)): heapObj(v).kind
        elif isInlineInteger(v): Integer
        elif isInlineFloating(v): Floating
        else: otherKind(v)

    proc iKind*(v: NanBoxedValue): IntegerKind {.nbInline.} =
        if isRef(v): heapObj(v).iKind else: NormalInteger

    proc i*(v: NanBoxedValue): int {.nbInline.} =
        if isInlineInteger(v): cast[int](v.bits shl 16) shr 16
        else: heapObj(v).i

    proc `i=`*(v: var NanBoxedValue, x: int) {.nbInline.} =
        if isRef(v): heapObj(v).i = x
        elif x >= NbIntegerMin and x <= NbIntegerMax: v = inlineInteger(x)
        else: v = ValueRef(kind: Integer, iKind: NormalInteger, i: x)

    proc t*(v: NanBoxedValue): ValueKind {.nbInline.} =
        if isRef(v): heapObj(v).t
        else: ValueKind(v.bits and 0xFF)

    proc tpKind*(v: NanBoxedValue): TypeKind {.nbInline.} =
        if isRef(v): heapObj(v).tpKind else: BuiltinType

    proc c*(v: NanBoxedValue): Rune {.nbInline.} =
        if isRef(v): heapObj(v).c
        else: Rune(cast[int32](uint32(v.bits and 0xFFFF_FFFF'u64)))

    proc `c=`*(v: var NanBoxedValue, x: Rune) {.nbInline.} =
        if isRef(v): heapObj(v).c = x
        else: v = inlineChar(x)

    proc f*(v: NanBoxedValue): float {.nbInline.} =
        if isRef(v): heapObj(v).f
        else: cast[float](v.bits - NbFloatingShift)

    proc `f=`*(v: var NanBoxedValue, x: float) {.nbInline.} =
        if isRef(v): heapObj(v).f = x
        else: v = inlineFloating(x)

    proc flags*(v: NanBoxedValue): ValueFlags {.nbInline.} =
        if isRef(v): heapObj(v).flags
        elif isSingleton(v):
            case v.bits and 0xFF:
                of 2: ValueFlags(False)
                of 3: ValueFlags(True)
                of 4: ValueFlags(Maybe)
                else: {}
        else: {}

    proc `flags=`*(v: NanBoxedValue, x: ValueFlags) {.nbInline.} =
        if isRef(v): heapObj(v).flags = x

    proc info*(v: NanBoxedValue): ValueInfo {.nbInline.} =
        if isRef(v): heapObj(v).info else: nil

    proc `info=`*(v: NanBoxedValue, x: ValueInfo) {.nbInline.} =
        if isRef(v): heapObj(v).info = x

    proc ln*(v: NanBoxedValue): uint32 {.nbInline.} =
        if isRef(v): heapObj(v).ln else: 0

    proc `ln=`*(v: NanBoxedValue, x: uint32) {.nbInline.} =
        if isRef(v): heapObj(v).ln = x

    template `[]`*(v: NanBoxedValue): untyped = heapObj(v)[]

    macro refFields(names: varargs[untyped]): untyped =
        ## the fields that only heap values have: read & written in place
        result = newStmtList()
        for n in names:
            let name = postfix(n, "*")
            result.add quote do:
                template `name`(v: NanBoxedValue): untyped = heapObj(v).`n`

    refFields(bi, z, rat, version, tid, s, sid, p, m, rx, u, q, err, errKind,
              l, e, eobj, n, a, data, cachedTrans, singleton, rng, d, proto, o, magic,
              sto, funcType, methType, dbKind, trans, tsk, evt)
    when defined(SQLITE): refFields(sqlitedb)
    when not defined(WEB): refFields(sock, chn)

#=======================================
# Constants
#=======================================

let 
    NoPrototypeFound* = Prototype(name: "prototype-error")
    NoMagicMethod*: MagicMethodInternal = nil

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
template `readonly=`*(val: Value, newVal: bool) =
    var fl = val.flags; fl[IsReadOnly] = newVal; val.flags = fl

template dynamic*(val: Value): bool = IsDynamic in val.flags
template `dynamic=`*(val: Value, newVal: bool) =
    var fl = val.flags; fl[IsDynamic] = newVal; val.flags = fl

when defined(NANBOX):
    # (Logicals are held inline: no need to go through the flags)
    proc b*(val: Value): VLogical {.nbInline.} =
        case val.bits:
            of NbTrueBits: True
            of NbFalseBits: False
            of NbMaybeBits: Maybe
            else: VLogical(val.flags - NonLogicalF)
else:
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
makeAccessor(funcType, paramIds)
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
makeAccessor(methType, mparamIds)
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

    when defined(WEB):
        # JS backend trips the case-object guard on `x.iKind` if `kind != Integer`,
        # so guard the reads behind a short-circuit.
        (cast[uint32](ord(xKind)) shl 16.uint32) or
        (cast[uint32](ord(yKind))) or
        (if xKind==Integer and x.iKind==BigInteger: 1.uint32 shl 31 else: 0.uint32) or
        (if yKind==Integer and y.iKind==BigInteger: 1.uint32 shl 15 else: 0.uint32)
    else:
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

template fetch*(what: MagicMethods, magicMethodId: typed): untyped {.dirty.} =
    (let mgk = what.getOrDefault(magicMethodId); not mgk.isNil)

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
