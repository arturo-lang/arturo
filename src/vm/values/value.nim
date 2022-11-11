#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/value.nim
#=======================================================

## Arturo's main Value object.

# TODO(VM/values/value) General cleanup needed
#  There are various pieces of commented-out code that make the final result pretty much illegible. Let's clean this up.
#  labels: vm, values, cleanup

#=======================================
# Libraries
#=======================================

import hashes, lenientops
import macros, math, sequtils, strutils
import sugar, tables, times, unicode

when not defined(NOSQLITE):
    import db_sqlite as sqlite
    #import db_mysql as mysql

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

when not defined(WEB):
    import vm/errors

import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol]

import vm/values/clean
import vm/values/types
export types

#=======================================
# Pragmas
#=======================================

{.push overflowChecks: on.}

#=======================================
# Constants
#=======================================

const
    NoValues*       = @[]

#=======================================
# Fixed Values
#=======================================

template makeConst(v: Value): untyped =
  var res = v
  res.readOnly = true
  res

let
    I0*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 0)      ## constant 0
    I1*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 1)      ## constant 1
    I2*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 2)      ## constant 2
    I3*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 3)      ## constant 3
    I4*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 4)      ## constant 4
    I5*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 5)      ## constant 5
    I6*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 6)      ## constant 6
    I7*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 7)      ## constant 7
    I8*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 8)      ## constant 8
    I9*             = makeConst Value(kind: Integer, iKind: NormalInteger, i: 9)      ## constant 9
    I10*            = makeConst Value(kind: Integer, iKind: NormalInteger, i: 10)     ## constant 10
    I11*            = makeConst Value(kind: Integer, iKind: NormalInteger, i: 11)     ## constant 11
    I12*            = makeConst Value(kind: Integer, iKind: NormalInteger, i: 12)     ## constant 12
    I13*            = makeConst Value(kind: Integer, iKind: NormalInteger, i: 13)     ## constant 13
    I14*            = makeConst Value(kind: Integer, iKind: NormalInteger, i: 14)     ## constant 14
    I15*            = makeConst Value(kind: Integer, iKind: NormalInteger, i: 15)     ## constant 15

    I1M*            = makeConst Value(kind: Integer, iKind: NormalInteger, i: -1)     ## constant -1

    F0*             = makeConst Value(kind: Floating, f: 0.0)                         ## constant 0.0
    F1*             = makeConst Value(kind: Floating, f: 1.0)                         ## constant 1.0
    F2*             = makeConst Value(kind: Floating, f: 2.0)                         ## constant 2.0

    F1M*            = makeConst Value(kind: Floating, f: -1.0)                        ## constant -1.0

    VTRUE*          = makeConst Value(kind: Logical, flags: {ValueFlag.isTrue})                 ## constant True
    VFALSE*         = makeConst Value(kind: Logical, flags: {ValueFlag.isFalse})                       ## constant False
    VMAYBE*         = makeConst Value(kind: Logical, flags: {ValueFlag.isMaybe})                ## constant Maybe

    VNULL*          = makeConst Value(kind: Null)                                     ## constant Null

    VEMPTYSTR*      = makeConst Value(kind: String, s: "")                                    ## constant ""
    VEMPTYARR*      = makeConst Value(kind: Block, a: @[], data: nil)                         ## constant []
    VEMPTYDICT*     = makeConst Value(kind: Dictionary, d: initOrderedTable[string,Value]())  ## constant #[]

    VSTRINGT*       = makeConst Value(kind: Type, tpKind: BuiltinType, t: String)     ## constant ``:string``
    VINTEGERT*      = makeConst Value(kind: Type, tpKind: BuiltinType, t: Integer)    ## constant ``:integer``

    #--------

    NoAliasBinding*     = AliasBinding(precedence: PostfixPrecedence, name: nil)

#=======================================
# Variables
#=======================================

var 
    TypeLookup = initOrderedTable[string,Value]()

    # global implementation references
    AddF*, SubF*, MulF*, DivF*, FdivF*, ModF*, PowF*            : Value
    NegF*, BNotF*, BAndF*, BOrF*, ShlF*, ShrF*                  : Value
    NotF*, AndF*, OrF*                                          : Value 
    EqF*, NeF*, GtF*, GeF*, LtF*, LeF*                          : Value
    IfF*, IfEF*, UnlessF*, ElseF*, SwitchF*, WhileF*, ReturnF*  : Value
    ToF*, PrintF*                                               : Value
    GetF*, SetF*                                                : Value
    ArrayF*, DictF*, FuncF*                                     : Value
    RangeF*, LoopF*, MapF*, SelectF*                            : Value
    SizeF*, ReplaceF*, SplitF*, JoinF*, ReverseF*               : Value 
    IncF*, DecF*                                                : Value

#=======================================
# Forward Declarations
#=======================================

func newDictionary*(d: sink ValueDict = initOrderedTable[string,Value]()): Value {.inline.}
func valueAsString*(v: Value): string {.inline,enforceNoRaises.}
proc `+`*(x: Value, y: Value): Value
proc `-`*(x: Value, y: Value): Value
proc `*`*(x: Value, y: Value): Value
proc `/`*(x: Value, y: Value): Value
proc `//`*(x: Value, y: Value): Value
func hash*(v: Value): Hash {.inline.}

#=======================================
# Constructors
#=======================================

proc newLogical*(b: VLogical): Value {.inline, enforceNoRaises.} =
    if b==True: VTRUE
    elif b==False: VFALSE
    else: VMAYBE

proc newLogical*(b: bool): Value {.inline, enforceNoRaises.} =
    if b: VTRUE
    else: VFALSE

proc newLogical*(s: string): Value {.inline, enforceNoRaises.} =
    ## create Logical value from string
    if s=="true": newLogical(True)
    elif s=="false": newLogical(False)
    else: newLogical(Maybe)

proc newLogical*(i: int): Value {.inline, enforceNoRaises.} =
    ## create Logical value from int
    if i==1: newLogical(True)
    elif i==0: newLogical(False)
    else: newLogical(Maybe)

when defined(WEB):
    proc newInteger*(bi: JsBigInt): Value {.inline.} =
        result = Value(kind: Integer, iKind: BigInteger, bi: bi)

when not defined(NOGMP):
    proc newInteger*(bi: Int): Value {.inline.} =
        result = Value(kind: Integer, iKind: BigInteger, bi: bi)

func newInteger*(i: int): Value {.inline, enforceNoRaises.} =
    ## create Integer value from int
    result = Value(kind: Integer, iKind: NormalInteger, i: i)

func newInteger*(i: int64): Value {.inline, enforceNoRaises.} =
    ## create Integer value from int64
    newInteger((int)(i))

proc newInteger*(i: string, lineno: int = 1): Value {.inline.} =
    ## create Integer value from string
    try:
        return newInteger(parseInt(i))
    except ValueError:
        when defined(WEB):
            return newInteger(big(i.cstring))
        elif not defined(NOGMP):
            return newInteger(newInt(i))
        else:
            RuntimeError_IntegerParsingOverflow(lineno, i)

func newBigInteger*(i: int): Value {.inline.} =
    ## create Integer (BigInteger) value from int
    when defined(WEB):
        result = Value(kind: Integer, iKind: BigInteger, bi: big(i))
    elif not defined(NOGMP):
        result = Value(kind: Integer, iKind: BigInteger, bi: newInt(i))

func newFloating*(f: float): Value {.inline, enforceNoRaises.} =
    ## create Floating value from float
    Value(kind: Floating, f: f)

func newFloating*(f: int): Value {.inline, enforceNoRaises.} =
    ## create Floating value from int
    Value(kind: Floating, f: (float)(f))

proc newFloating*(f: string): Value {.inline.} =
    ## create Floating value from string
    return newFloating(parseFloat(f))

func newComplex*(com: VComplex): Value {.inline.} =
    ## create Complex value from VComplex
    Value(kind: Complex, z: com)

func newComplex*(fre: float, fim: float): Value {.inline.} =
    ## create Complex value from real + imaginary parts (float)
    Value(kind: Complex, z: VComplex(re: fre, im: fim))

func newComplex*(fre: Value, fim: Value): Value {.inline.} =
    ## create Complex value from real + imaginary parts (Value)
    var r: float
    var i: float

    if fre.kind==Integer: r = (float)(fre.i)
    else: r = fre.f

    if fim.kind==Integer: i = (float)(fim.i)
    else: i = fim.f

    newComplex(r,i)

func newRational*(rat: VRational): Value {.inline, enforceNoRaises.} =
    ## create Rational value from VRational
    Value(kind: Rational, rat: rat)

func newRational*(num: int, den: int): Value {.inline.} =
    ## create Rational value from numerator + denominator (int)
    Value(kind: Rational, rat: initRational(num, den))

func newRational*(n: int): Value {.inline.} =
    ## create Rational value from int
    Value(kind: Rational, rat: toRational(n))

func newRational*(n: float): Value {.inline.} =
    ## create Rational value from float
    Value(kind: Rational, rat: toRational(n))

func newRational*(num: Value, den: Value): Value {.inline, enforceNoRaises.} =
    ## create Rational value from numerator + denominator (Value)
    newRational(num.i, den.i)

func newVersion*(v: string): Value {.inline.} =
    ## create Version value from string
    var numPart = ""
    var extraPart = ""
    var lastIndex : int
    for i, c in v:
        lastIndex = i
        if c notin {'+','-'}:
            numPart.add(c)
        else:
            extraPart &= c
            break

    extraPart &= v[lastIndex+1 .. ^1]

    let parts: seq[string] = numPart.split(".")
    Value(kind: Version,
        version: VVersion(
            major: parseInt(parts[0]),
            minor: parseInt(parts[1]),
            patch: parseInt(parts[2]),
            extra: extraPart
        )
    )

func newType*(t: ValueKind): Value {.inline, enforceNoRaises.} =
    ## create Type (BuiltinType) value from ValueKind
    Value(kind: Type, tpKind: BuiltinType, t: t)

proc newUserType*(n: string, f: ValueArray = @[]): Value {.inline.} =
    ## create Type (UserType) value from string
    if (let lookup = TypeLookup.getOrDefault(n, nil); not lookup.isNil):
        return lookup
    else:
        result = Value(kind: Type, tpKind: UserType, t: Object, ts: Prototype(name: n, fields: f, methods: initOrderedTable[string,Value](), inherits: nil))
        TypeLookup[n] = result

proc newType*(t: string): Value {.inline.} =
    ## create Type value from string
    try:
        newType(parseEnum[ValueKind](t.capitalizeAscii()))
    except ValueError:
        newUserType(t)

func newChar*(c: Rune): Value {.inline, enforceNoRaises.} =
    ## create Char value from Rune
    Value(kind: Char, c: c)

func newChar*(c: char): Value {.inline.} =
    ## create Char value from char
    Value(kind: Char, c: ($c).runeAt(0))

func newChar*(c: string): Value {.inline.} =
    ## create Char value from string
    Value(kind: Char, c: c.runeAt(0))

func newString*(s: sink string, dedented: static bool = false): Value {.inline, enforceNoRaises.} =
    ## create String value from string
    when not dedented: 
        Value(kind: String, s: s)
    else: 
        Value(kind: String, s: unicode.strip(dedent(s)))

func newString*(s: cstring, dedented: static bool = false): Value {.inline, enforceNoRaises.} =
    ## create String value from cstring
    newString($(s), dedented)

func newWord*(w: sink string): Value {.inline, enforceNoRaises.} =
    ## create Word value from string
    Value(kind: Word, s: w)

func newLiteral*(l: sink string): Value {.inline, enforceNoRaises.} =
    ## create Literal value from string
    Value(kind: Literal, s: l)

func newLabel*(l: sink string): Value {.inline, enforceNoRaises.} =
    ## create Label value from string
    Value(kind: Label, s: l)

func newAttribute*(a: sink string): Value {.inline, enforceNoRaises.} =
    ## create Attribute value from string
    Value(kind: Attribute, s: a)

func newAttributeLabel*(a: sink string): Value {.inline, enforceNoRaises.} =
    ## create AttributeLabel value from string
    Value(kind: AttributeLabel, s: a)

func newPath*(p: sink ValueArray): Value {.inline, enforceNoRaises.} =
    ## create Path value from ValueArray
    Value(kind: Path, p: p)

func newPathLabel*(p: sink ValueArray): Value {.inline, enforceNoRaises.} =
    ## create PathLabel value from ValueArray
    Value(kind: PathLabel, p: p)

func newSymbol*(m: VSymbol): Value {.inline, enforceNoRaises.} =
    ## create Symbol value from VSymbol
    Value(kind: Symbol, m: m)

func newSymbol*(m: sink string): Value {.inline.} =
    ## create Symbol value from string
    newSymbol(parseEnum[VSymbol](m))

func newSymbolLiteral*(m: VSymbol): Value {.inline, enforceNoRaises.} =
    ## create SymbolLiteral value from VSymbol
    Value(kind: SymbolLiteral, m: m)

func newSymbolLiteral*(m: string): Value {.inline.} =
    ## create SymbolLiteral value from string
    newSymbolLiteral(parseEnum[VSymbol](m))

func newQuantity*(nm: Value, unit: VQuantity): Value {.inline, enforceNoRaises.} =
    ## create Quantity value from numerica value ``nm`` (Value) + ``unit`` (VQuantity)
    Value(kind: Quantity, nm: nm, unit: unit)

proc newQuantity*(nm: Value, name: UnitName): Value {.inline.} =
    ## create Quantity value from numerica value ``nm`` (Value) + unit ``name`` (UnitName)
    newQuantity(nm, newQuantitySpec(name))

proc convertToTemperatureUnit*(v: Value, src: UnitName, tgt: UnitName): Value =
    ## convert given temperature value ``v`` from ``src`` unit to ``tgt``
    case src:
        of C:
            if tgt==F: return v * newFloating(9/5) + newInteger(32)
            elif tgt==K: return v + newFloating(273.15)
            else: return v * newFloating(9/5) + newFloating(491.67)
        of F:
            if tgt==C: return (v - newInteger(32)) * newFloating(5/9)
            elif tgt==K: return (v - newInteger(32)) * newFloating(5/9) + newFloating(273.15)
            else: return v + newFloating(459.67)
        of K: 
            if tgt==C: return v - newFloating(273.15)
            elif tgt==F: return (v-newFloating(273.15)) * newFloating(9/5) + newInteger(32)
            else: return v * newFloating(1.8)
        of R:
            if tgt==C: return (v - newFloating(491.67)) * newFloating(5/9)
            elif tgt==F: return v - newFloating(459.67)
            else: return v * newFloating(5/9)

        else: discard

proc convertQuantityValue*(nm: Value, fromU: UnitName, toU: UnitName, fromKind = NoUnit, toKind = NoUnit, op = ""): Value =
    ## convert given quantity value ``nm`` from ``fromU`` unit to ``toU`` 
    var fromK = fromKind
    var toK = toKind
    if fromK==NoUnit: fromK = quantityKindForName(fromU)
    if toK==NoUnit: toK = quantityKindForName(toU)

    if unlikely(fromK!=toK):
        when not defined(WEB):
            RuntimeError_CannotConvertQuantity(valueAsString(nm), stringify(fromU), stringify(fromK), stringify(toU), stringify(toK))
    
    if toK == TemperatureUnit:
        return convertToTemperatureUnit(nm, fromU, toU)
    else:
        let fmultiplier = getQuantityMultiplier(fromU, toU, isCurrency=fromK==CurrencyUnit)
        if fmultiplier == 1.0:
            return nm
        else:
            return nm * newFloating(fmultiplier)

func newRegex*(rx: sink VRegex): Value {.inline, enforceNoRaises.} =
    ## create Regex value from VRegex
    Value(kind: Regex, rx: rx)

func newRegex*(rx: string): Value {.inline.} =
    ## create Regex value from string
    newRegex(newRegexObj(rx))

func newColor*(l: VColor): Value {.inline, enforceNoRaises.} =
    ## create Color value from VColor
    Value(kind: Color, l: l)

func newColor*(rgb: RGB): Value {.inline.} =
    ## create Color value from RGB
    newColor(colorFromRGB(rgb))

func newColor*(l: string): Value {.inline.} =
    ## create Color value from string
    newColor(parseColor(l))

func newDate*(dt: sink DateTime): Value {.inline, enforceNoRaises.} =
    ## create Date value from DateTime
    let edict = {
        "hour"      : newInteger(dt.hour),
        "minute"    : newInteger(dt.minute),
        "second"    : newInteger(dt.second),
        "nanosecond": newInteger(dt.nanosecond),
        "day"       : newInteger(dt.monthday),
        "Day"       : newString($(dt.weekday)),
        "days"      : newInteger(dt.yearday),
        "month"     : newInteger(ord(dt.month)),
        "Month"     : newString($(dt.month)),
        "year"      : newInteger(dt.year),
        "utc"       : newInteger(dt.utcOffset)
    }.toOrderedTable
    let newTime = new DateTime
    newTime[] = dt
    Value(kind: Date, e: edict, eobj: newTime)

func newBinary*(n: VBinary = @[]): Value {.inline, enforceNoRaises.} =
    ## create Binary value from VBinary
    Value(kind: Binary, n: n)

func newDictionary*(d: sink ValueDict = initOrderedTable[string,Value]()): Value {.inline, enforceNoRaises.} =
    ## create Dictionary value from ValueDict
    Value(kind: Dictionary, d: d)

func newObject*(o: sink ValueDict = initOrderedTable[string,Value](), proto: sink Prototype): Value {.inline, enforceNoRaises.} =
    ## create Object value from ValueDict with given prototype
    Value(kind: Object, o: o, proto: proto)

proc newObject*(args: ValueArray, prot: Prototype, initializer: proc (self: Value, prot: Prototype), o: ValueDict = initOrderedTable[string,Value]()): Value {.inline.} =
    ## create Object value from ValueArray with given prototype 
    ## and initializer function
    var fields = o
    var i = 0
    while i<args.len and i<prot.fields.len:
        let k = prot.fields[i]
        fields[k.s] = args[i]
        i += 1

    result = newObject(fields, prot)
    
    initializer(result, prot)

proc newObject*(args: ValueDict, prot: Prototype, initializer: proc (self: Value, prot: Prototype), o: ValueDict = initOrderedTable[string,Value]()): Value {.inline.} =
    ## create Object value from ValueDict with given prototype 
    ## and initializer function, using another object ``o`` as 
    ## a parent object
    var fields = o
    for k,v in pairs(args):
        for item in prot.fields:
            if item.s == k:
                fields[k] = v

    result = newObject(fields, prot)
    
    initializer(result, prot)

func newFunction*(params: Value, main: Value, imports: Value = nil, exports: Value = nil, memoize: bool = false, inline: bool = false): Value {.inline, enforceNoRaises.} =
    ## create Function (UserFunction) value with given parameters, ``main`` body, etc
    Value(
        kind: Function,
        funcType: VFunction(
            fnKind: UserFunction,
            arity: params.a.len,
            params: params,
            main: main,
            imports: imports,
            exports: exports,
            memoize: memoize,
            inline: inline,
            bcode: nil
        )
    )

func newBuiltin*(desc: sink string, ar: int, ag: sink OrderedTable[string,ValueSpec], at: sink OrderedTable[string,(ValueSpec,string)], ret: ValueSpec, exa: sink string, act: BuiltinAction): Value {.inline, enforceNoRaises.} =
    ## create Function (BuiltinFunction) value with given details
    Value(
        kind: Function,
        info: desc,
        funcType: VFunction(
            fnKind: BuiltinFunction,
            arity: ar,
            args: ag,
            attrs: at,
            returns: ret,
            example: exa,
            action: act
        )
    )

when not defined(NOSQLITE):
    proc newDatabase*(db: sqlite.DbConn): Value {.inline.} =
        ## create Database value from DbConn
        Value(kind: Database, dbKind: SqliteDatabase, sqlitedb: db)

# proc newDatabase*(db: mysql.DbConn): Value {.inline.} =
#     Value(kind: Database, dbKind: MysqlDatabase, mysqldb: db)

func newBytecode*(t: sink Translation): Value {.inline, enforceNoRaises.} =
    ## create Bytecode value from Translation
    Value(kind: Bytecode, trans: t)

func newInline*(a: sink ValueArray = @[], dirty = false): Value {.inline, enforceNoRaises.} =
    ## create Inline value from ValueArray
    let flags =
        if dirty:
            {isDirty}
        else:
            {}
    Value(kind: Inline, a: a, flags: flags)

func newBlock*(a: sink ValueArray = @[], data: sink Value = nil, dirty = false): Value {.inline, enforceNoRaises.} =
    ## create Block value from ValueArray
    let flags =
        if dirty:
            {isDirty}
        else:
            {}
    Value(kind: Block, a: a, data: data, flags: flags)

func newIntegerBlock*[T](a: sink seq[T]): Value {.inline, enforceNoRaises.} =
    ## create Block value from an array of ints
    newBlock(a.map(proc (x:T):Value = newInteger((int)(x))))

proc newStringBlock*(a: sink seq[string]): Value {.inline, enforceNoRaises.} =
    ## create Block value from an array of strings
    newBlock(a.map(proc (x:string):Value = newString($x)))

proc newStringBlock*(a: sink seq[cstring]): Value {.inline, enforceNoRaises.} =
    ## create Block value from an array of cstrings
    newBlock(a.map(proc (x:cstring):Value = newString(x)))

func newNewline*(l: int): Value {.inline, enforceNoRaises.} =
    ## create Newline value with given line number
    Value(kind: Newline, line: l)

proc newStringDictionary*(a: Table[string, string]): Value =
    ## create Dictionary value from a string-string Table
    result = newDictionary()
    for k,v in a.pairs:
        result.d[k] = newString(v)

proc newStringDictionary*(a: TableRef[string, seq[string]], collapseBlocks=false): Value =
    ## create Dictionary value from a string-seq[string] TableRef
    result = newDictionary()
    for k,v in a.pairs:
        if collapseBlocks:
            if v.len==1:
                result.d[k] = newString(v[0])
            elif v.len==0:
                result.d[k] = newString("")
            else:
                result.d[k] = newStringBlock(v)
        else:
            result.d[k] = newStringBlock(v)

proc copyValue*(v: Value): Value {.inline.} =
    ## copy given value (deep copy) and return 
    ## the result
    ## 
    ## **Hint**: extensively use for pointer disambiguation, 
    ## ``new`` and value copying, in general (when needed)
    case v.kind:
        of Null:        result = VNULL
        of Logical:     result = newLogical(v.b)
        of Integer:     
            if likely(v.iKind == NormalInteger): 
                result = newInteger(v.i)
            else:
                when defined(WEB) or not defined(NOGMP): 
                    result = newInteger(v.bi)
        of Floating:    result = newFloating(v.f)
        of Complex:     result = newComplex(v.z)
        of Rational:    result = newRational(v.rat)
        of Type:        
            if likely(v.tpKind==BuiltinType):
                result = newType(v.t)
            else:
                result = newUserType(v.ts.name, v.ts.fields)
        of Char:        result = newChar(v.c)

        of String:      result = newString(v.s)
        of Word:        result = newWord(v.s)
        of Literal:     result = newLiteral(v.s)
        of Label:       result = newLabel(v.s)

        of Attribute:        result = newAttribute(v.s)
        of AttributeLabel:   result = newAttributeLabel(v.s)

        of Path:        result = newPath(v.p)
        of PathLabel:   result = newPathLabel(v.p)

        of Symbol:      result = newSymbol(v.m)
        of Date:        result = newDate(v.eobj[])
        of Binary:      result = newBinary(v.n)

        of Inline:      result = newInline(v.a)
        of Block:       
            if v.data.isNil: 
                let newValues = cleanedBlockValuesCopy(v)
                result = Value(kind: Block, a: newValues)
            else:
                result = newBlock(v.a.map((vv)=>copyValue(vv)), copyValue(v.data))

        of Dictionary:  result = newDictionary(v.d)
        of Object:      result = newObject(v.o, v.proto)

        of Function:    result = newFunction(v.params, v.main, v.imports, v.exports, v.memoize, v.inline)

        of Database:    
            when not defined(NOSQLITE):
                if v.dbKind == SqliteDatabase: result = newDatabase(v.sqlitedb)
                #elif v.dbKind == MysqlDatabase: result = newDatabase(v.mysqldb)

        of Regex:
            result = newRegex(v.rx)

        of Newline:
            echo "found NEWLINE when copying value!"
        else: 
            echo "found UNSUPPORTED value when copying value!"
            discard

#=======================================
# Helpers
#=======================================

func asFloat*(v: Value): float {.enforceNoRaises.} = 
    ## get numeric value forcefully as a float
    ## 
    ## **Hint:** We have to make sure the value is 
    ## either an Integer or a Floating value
    if v.kind == Floating:
        result = v.f
    else:
        result = (float)(v.i)

func asInt*(v: Value): int {.enforceNoRaises.} = 
    ## get numeric value forcefully as an int
    ## 
    ## **Hint:** We have to make sure the value is 
    ## either an Integer or a Floating value
    if v.kind == Integer:
        result = v.i
    else:
        result = (int)(v.f)

func getArity*(x: Value): int {.enforceNoRaises.} =
    ## get arity of given Function value
    return x.arity

proc safeMulI[T: SomeInteger](x: var T, y: T) {.inline, noSideEffect.} =
    x = x * y

func safePow[T: SomeNumber](x: T, y: Natural): T =
    case y
    of 0: result = 1
    of 1: result = x
    of 2: result = x * x
    of 3: result = x * x * x
    else:
        var (x, y) = (x, y)
        result = 1
        while true:
            if (y and 1) != 0:
                safeMulI(result, x)
            y = y shr 1
            if y == 0:
                break
            safeMulI(x, x)

func valueAsString*(v: Value): string {.inline,enforceNoRaises.} =
    ## get numeric value forcefully as a string
    ## 
    ## **Hint:** We have to make sure the value is 
    ## either an Integer, Floating, Rational or Complex value

    # This works only for number values, which is precisely
    # what we need for this module.
    # The proper `$` implementation is in `values/printable`.
    case v.kind:
        of Integer:
            if likely(v.iKind == NormalInteger): 
                result = $v.i
            else:
                when defined(WEB) or not defined(NOGMP): 
                    result = $v.bi
        of Floating:
            result = $v.f
        of Rational:
            result = $v.rat
        of Complex:
            result = $v.z
        else:
            result = ""

#=======================================
# Methods
#=======================================

# TODO(VM/values/value) Verify that all errors are properly thrown
#  Various core arithmetic operations between Value values may lead to errors. Are we catching - and reporting - them all properly?
#  labels: vm, values, error handling, unit-test

proc `+`*(x: Value, y: Value): Value =
    ## add given values and return the result
    if x.kind==Color and y.kind==Color:
        return newColor(x.l + y.l)
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.name == y.unit.name:
                    return newQuantity(x.nm + y.nm, x.unit)
                else:
                    return newQuantity(x.nm + convertQuantityValue(y.nm, y.unit.name, x.unit.name), x.unit)
            else:
                return newQuantity(x.nm + y, x.unit)
        else:
            return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        return newInteger(x.i+y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            return newInteger(big(x.i)+big(y.i))
                        elif not defined(NOGMP):
                            return newInteger(newInt(x.i)+y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("add", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        return newInteger(big(x.i)+y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i+y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi+y.bi)
                    else:
                        return newInteger(x.bi+big(y.i))
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi+y.bi)
                    else:
                        return newInteger(x.bi+y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f+y.f)
                elif y.kind==Complex: return newComplex(x.f+y.z)
                elif y.kind==Rational: return newRational(toRational(x.f) + y.rat)
                else: 
                    if likely(y.iKind==NormalInteger):
                        return newFloating(x.f+y.i)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f+y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newComplex(x.z+(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z+y.f)
                elif y.kind==Rational: return VNULL
                else: return newComplex(x.z+y.z)
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newRational(x.rat+y.i)
                    else: return VNULL
                elif y.kind==Floating: return newRational(x.rat+toRational(y.f))
                elif y.kind==Complex: return VNULL
                else: return newRational(x.rat+y.rat)
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        return newFloating(x.i+y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi+y.f)
                elif y.kind==Rational: return newRational(x.i+y.rat)
                else: return newComplex((float)(x.i)+y.z)

proc `+=`*(x: var Value, y: Value) =
    ## add given values 
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.name == y.unit.name:
                    x.nm += y.nm
                else:
                    x.nm += convertQuantityValue(y.nm, y.unit.name, x.unit.name)
            else:
                x.nm += y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        x.i += y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)+big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)+y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("add", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)+y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i+y.bi)
                    
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        x.bi += y.bi
                    else:
                        x.bi += big(y.i)
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        x.bi += y.bi
                    else:
                        x.bi += y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f += y.f
                elif y.kind==Complex: x = newComplex(x.f + y.z)
                elif y.kind==Rational: x = newRational(toRational(x.f) + y.rat)
                else: 
                    if y.iKind == NormalInteger:
                        x.f = x.f + y.i
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f + y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(x.z + (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z + y.f)
                elif y.kind==Rational: discard
                else: x.z += y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x.rat += y.i
                    else: discard
                elif y.kind==Floating: x.rat += toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat += y.rat
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(x.i+y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi+y.f)
                elif y.kind==Rational: x = newRational(x.i+y.rat)
                else: x = newComplex((float)(x.i)+y.z)

proc `-`*(x: Value, y: Value): Value = 
    ## subtract given values and return the result
    if x.kind==Color and y.kind==Color:
        return newColor(x.l - y.l)
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.name == y.unit.name:
                    return newQuantity(x.nm - y.nm, x.unit)
                else:
                    return newQuantity(x.nm - convertQuantityValue(y.nm, y.unit.name, x.unit.name), x.unit)
            else:
                return newQuantity(x.nm - y, x.unit)
        else:
            return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        return newInteger(x.i-y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            return newInteger(big(x.i)-big(y.i))
                        elif not defined(NOGMP):
                            return newInteger(newInt(x.i)-y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("sub", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        return newInteger(big(x.i)-y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i-y.bi)
                    
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi-y.bi)
                    else:
                        return newInteger(x.bi-big(y.i))
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi-y.bi)
                    else:
                        return newInteger(x.bi-y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f-y.f)
                elif y.kind==Complex: return newComplex(x.f-y.z)
                elif y.kind==Rational: return newRational(toRational(x.f)-y.rat)
                else: 
                    if likely(y.iKind==NormalInteger):
                        return newFloating(x.f-y.i)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f-y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newComplex(x.z-(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z-y.f)
                elif y.kind==Rational: return VNULL
                else: return newComplex(x.z-y.z)
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newRational(x.rat-y.i)
                    else: return VNULL
                elif y.kind==Floating: return newRational(x.rat-toRational(y.f))
                elif y.kind==Complex: return VNULL
                else: return newRational(x.rat-y.rat)
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        return newFloating(x.i-y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi-y.f)
                elif y.kind==Rational: return newRational(x.i-y.rat)
                else: return newComplex((float)(x.i)-y.z)

proc `-=`*(x: var Value, y: Value) =
    ## subtract given values and 
    ## store the result in the first value
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.name == y.unit.name:
                    x.nm -= y.nm
                else:
                    x.nm -= convertQuantityValue(y.nm, y.unit.name, x.unit.name)
            else:
                x.nm -= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        x.i -= y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)-big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)-y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("sub", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)-y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i-y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        x.bi -= y.bi
                    else:
                        x.bi -= big(y.i)
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        x.bi -= y.bi
                    else:
                        x.bi -= y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f -= y.f
                elif y.kind==Complex: x = newComplex(x.f - y.z)
                elif y.kind==Rational: x = newRational(toRational(x.f) - y.rat)
                else: 
                    if y.iKind == NormalInteger:
                        x.f = x.f - y.i
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f - y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(x.z - (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z - y.f)
                elif y.kind==Rational: discard
                else: x.z -= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x.rat -= y.i
                    else: discard
                elif y.kind==Floating: x.rat -= toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat -= y.rat
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(x.i-y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi-y.f)
                elif y.kind==Rational: x = newRational(x.i-y.rat)
                else: x = newComplex((float)(x.i)-y.z)

proc `*`*(x: Value, y: Value): Value =
    ## multiply given values 
    ## and return the result
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("mul", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("mul", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                else:
                    return newQuantity(x.nm * convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                return newQuantity(x.nm * y, x.unit)
        else:
            return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        return newInteger(x.i*y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            return newInteger(big(x.i)*big(y.i))
                        elif not defined(NOGMP):
                            return newInteger(newInt(x.i)*y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("mul", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        return newInteger(big(x.i)*y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i*y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi*y.bi)
                    else:
                        return newInteger(x.bi*big(y.i))
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi*y.bi)
                    else:
                        return newInteger(x.bi*y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f*y.f)
                elif y.kind==Complex: return newComplex(x.f*y.z)
                elif y.kind==Rational: return newRational(toRational(x.f)*y.rat)
                else:
                    if likely(y.iKind==NormalInteger):
                        return newFloating(x.f*y.i)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f * y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newComplex(x.z*(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z*y.f)
                elif y.kind==Rational: return VNULL
                else: return newComplex(x.z*y.z)
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newRational(x.rat*y.i)
                    else: return VNULL
                elif y.kind==Floating: return newRational(x.rat*toRational(y.f))
                elif y.kind==Complex: return VNULL
                else: return newRational(x.rat*y.rat)
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        return newFloating(x.i*y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi * y.f)
                elif y.kind==Rational: return newRational(x.i*y.rat)
                else: return newComplex((float)(x.i)*y.z)

proc `*=`*(x: var Value, y: Value) =
    ## multiply given values 
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("mul", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("mul", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                else:
                    x = newQuantity(x.nm * convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                x.nm *= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        safeMulI(x.i, y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)*big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)*y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("mul", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)*y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i*y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        x.bi *= y.bi
                    else:
                        x.bi *= big(y.i)
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        x.bi *= y.bi
                    else:
                        x.bi *= y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f *= y.f
                elif y.kind==Complex: x = newComplex(x.f * y.z)
                elif y.kind==Rational: x = newRational(toRational(x.f) * y.rat)
                else: 
                    if y.iKind == NormalInteger:
                        x.f = x.f * y.i
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f * y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(x.z * (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z * y.f)
                else: x.z *= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x.rat *= y.i
                    else: discard
                elif y.kind==Floating: x.rat *= toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat *= y.rat
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(x.i*y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi*y.f)
                elif y.kind==Rational: x = newRational(x.i * y.rat)
                else: x = newComplex((float)(x.i)*y.z)

# method `/`*(x: FloatingValue, y: Float): Float {.base.} =
#     discard
# method `/`*(x: NormalFloatingV, y: Float): Float = 
#     newFloat(x.fv) / y

# method `/`*(x: BigFloatingV, y: Float): Float =
#     x.fv / y

proc `/`*(x: Value, y: Value): Value =
    ## divide (integer division) given values 
    ## and return the result
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("div", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("div", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                elif finalSpec == NumericQuantity:
                    return x.nm / y.nm
                else:
                    return newQuantity(x.nm / convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                return newQuantity(x.nm / y, x.unit)
        else:
            return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    return newInteger(x.i div y.i)
                else:
                    when defined(WEB):
                        return newInteger(big(x.i) div y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i div y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi div y.bi)
                    else:
                        return newInteger(x.bi div big(y.i))
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi div y.bi)
                    else:
                        return newInteger(x.bi div y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f/y.f)
                elif y.kind==Complex: return newComplex(x.f/y.z)
                elif y.kind==Rational: return newInteger(toRational(x.f) div y.rat)
                else: 
                    if likely(y.iKind==NormalInteger):
                        return newFloating(x.f/y.i)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f / y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newComplex(x.z/(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z/y.f)
                elif y.kind==Rational: return VNULL
                else: return newComplex(x.z/y.z)
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newInteger(x.rat div toRational(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newInteger(x.rat div toRational(y.f))
                elif y.kind==Complex: return VNULL
                else: return newInteger(x.rat div y.rat)
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        return newFloating(x.i/y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi/y.f)
                elif y.kind==Rational: return newInteger(toRational(x.i) div y.rat)
                else: return newComplex((float)(x.i)/y.z)

proc `/=`*(x: var Value, y: Value) =
    ## divide (integer division) given values 
    ## and store the result in the first one 
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer, Floating, Complex, Rational}) or not (y.kind in {Integer, Floating, Complex, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("div", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("div", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                elif finalSpec == NumericQuantity:
                    x = x.nm / y.nm
                else:
                    x = newQuantity(x.nm / convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                x.nm /= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        x.i = x.i div y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i) div big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i) div y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("div", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i) div y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i div y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        x = newInteger(x.bi div y.bi)
                    else:
                        x = newInteger(x.bi div big(y.i))
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        x = newInteger(x.bi div y.bi)
                    else:
                        x = newInteger(x.bi div y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f /= y.f
                elif y.kind==Complex: x = newComplex(x.f / y.z)
                elif y.kind==Rational: x = newInteger(toRational(x.f) div y.rat)
                else:                     
                    if y.iKind == NormalInteger:
                        x.f = x.f / y.i
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f / y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(x.z / (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z / y.f)
                else: x.z /= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newInteger(x.rat div toRational(y.i))
                    else: discard
                elif y.kind==Floating: x = newInteger(x.rat div toRational(y.f))
                elif y.kind==Complex: discard
                else: x = newInteger(x.rat div y.rat)
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(x.i/y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi/y.f)
                elif y.kind==Rational: x = newInteger(toRational(x.i) div y.rat)
                else: x = newComplex((float)(x.i)/y.z)

proc `//`*(x: Value, y: Value): Value =
    ## divide (floating-point division) given values 
    ## and return the result
    if not (x.kind in {Integer, Floating, Rational}) or not (y.kind in {Integer, Floating, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("fdiv", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("fdiv", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                elif finalSpec == NumericQuantity:
                    return x.nm // y.nm
                else:
                    return newQuantity(x.nm // convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                return newQuantity(x.nm // y, x.unit)
        else:
            return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            return newFloating(x.i / y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f / y.f)
                elif y.kind==Rational: return newRational(toRational(x.f)/y.rat)
                else: 
                    if likely(y.iKind==NormalInteger):
                        return newFloating(x.f/(float)(y.i))
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f / y.bi)
            elif x.kind==Rational:
                if y.kind==Floating: return newRational(x.rat / toRational(y.f))
                elif y.kind==Rational: return newRational(x.rat / y.rat)
                else: return newRational(x.rat / y.i)
            else:
                if y.kind==Floating:
                    if likely(x.iKind==NormalInteger):
                        return newFloating((float)(x.i)/y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi/y.f)
                else: return newRational(x.i / y.rat)


proc `//=`*(x: var Value, y: Value) =
    ## divide (floating-point division) given values 
    ## and store the result in the first one 
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer, Floating, Rational}) or not (y.kind in {Integer, Floating, Rational}):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("fdiv", x.unit, y.unit)
                if unlikely(finalSpec == ErrorQuantity):
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("fdiv", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
                elif finalSpec == NumericQuantity:
                    x = x.nm // y.nm
                else:
                    x = newQuantity(x.nm // convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                x.nm //= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            x = newFloating(x.i / y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f /= y.f
                elif y.kind==Rational: x = newRational(toRational(x.f)/y.rat)
                else: 
                    if y.iKind == NormalInteger:
                        x.f = x.f / (float)(y.i)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.f / y.bi)
            elif x.kind==Rational:
                if y.kind==Floating: x.rat /= toRational(y.f)
                elif y.kind==Rational: x.rat /= y.rat
                else: x.rat /= y.i
            else:
                if y.kind==Floating:
                    if likely(x.iKind==NormalInteger):
                        x = newFloating((float)(x.i)/y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi/y.f)
                else: x = newRational(x.i / y.rat)
                
proc `%`*(x: Value, y: Value): Value =
    ## perform the modulo operation between given values 
    ## and return the result
    if not (x.kind in {Integer,Floating,Rational}) or not (y.kind in {Integer,Floating,Rational}):
        if (x.kind == Quantity and y.kind == Quantity) and (x.unit.kind==y.unit.kind):
            if x.unit.name == y.unit.name:
                return newQuantity(x.nm % y.nm, x.unit)
            else:
                return newQuantity(x.nm % convertQuantityValue(y.nm, y.unit.name, x.unit.name), x.unit)
        else:
            if unlikely(x.unit.kind != y.unit.kind):
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("mod", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
            else:
                return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    return newInteger(x.i mod y.i)
                else:
                    when defined(WEB):
                        return newInteger(big(x.i) mod y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i mod y.bi)
            else:
                when defined(WEB):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi mod y.bi)
                    else:
                        return newInteger(x.bi mod big(y.i))
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        return newInteger(x.bi mod y.bi)
                    else:
                        return newInteger(x.bi mod y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f mod y.f)
                elif y.kind==Rational: return newRational(toRational(x.f) mod y.rat)
                else: 
                    if likely(y.iKind==NormalInteger):
                        return newFloating(x.f mod (float)(y.i))
                    else:
                        discard
                        # when not defined(NOGMP):
                        #     return newFloating(x.f mod y.bi)
            elif x.kind==Rational:
                if y.kind==Floating: return newRational(x.rat mod toRational(y.f))
                elif y.kind==Rational: return newRational(x.rat mod y.rat)
                else: return newRational(x.rat mod toRational(y.i))
            else:
                if y.kind==Rational:
                    return newRational(toRational(x.i) mod y.rat)
                else:
                    if likely(x.iKind==NormalInteger):
                        return newFloating((float)(x.i) mod y.f)
                    else:
                        discard
                        # when not defined(NOGMP):
                        #     return newFloating(x.bi mod y.f)

proc `%=`*(x: var Value, y: Value) =
    ## perform the modulo operation between given values
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer,Floating,Rational}) or not (y.kind in {Integer,Floating,Rational}):
        if (x.kind == Quantity and y.kind == Quantity) and (x.unit.kind==y.unit.kind):
            if x.unit.name == y.unit.name:
                x.nm %= y.nm
            else:
                x.nm %= convertQuantityValue(y.nm, y.unit.name, x.unit.name)
        else:
            if unlikely(x.unit.kind != y.unit.kind):
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("mod", valueAsString(x), valueAsString(y), stringify(x.unit.kind), stringify(y.unit.kind))
            else:
                x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger): 
                    x.i = x.i mod y.i
                else: 
                    when defined(WEB):
                        x = newInteger(big(x.i) mod y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i mod y.bi)
            else:
                when defined(WEB):
                    if likely(y.iKind==NormalInteger): 
                        x = newInteger(x.bi mod big(y.i))
                    else: 
                        x = newInteger(x.bi mod y.bi)
                elif not defined(NOGMP):
                    if likely(y.iKind==NormalInteger): 
                        x = newInteger(x.bi mod y.i)
                    else: 
                        x = newInteger(x.bi mod y.bi)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x = newFloating(x.f mod y.f)
                elif y.kind==Rational: x = newRational(toRational(x.f) mod y.rat)
                else: 
                    if likely(y.iKind==NormalInteger):
                        x = newFloating(x.f mod (float)(y.i))
            elif x.kind==Rational:
                if y.kind==Floating: x = newRational(x.rat mod toRational(y.f))
                elif y.kind==Rational: x = newRational(x.rat mod y.rat)
                else: x = newRational(x.rat mod toRational(y.i))
            else:
                if y.kind==Rational:
                    x = newRational(toRational(x.i) mod y.rat)
                else:
                    if likely(x.iKind==NormalInteger):
                        x = newFloating((float)(x.i) mod y.f)

proc `/%`*(x: Value, y: Value): Value =
    ## perform the divmod operation between given values
    ## and return the result as a *tuple* Block value
    if not (x.kind in {Integer,Floating,Rational}) or not (y.kind in {Integer,Floating,Rational}):
        return newBlock(@[x/y, x%y])
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    return newBlock(@[x/y, x%y])
                else:
                    when defined(WEB):
                        return newBlock(@[x/y, x%y])
                    elif not defined(NOGMP):
                        let dm = divmod(x.i, y.bi)
                        return newBlock(@[newInteger(dm.q), newInteger(dm.r)])
            else:
                when defined(WEB):
                    return newBlock(@[x/y, x%y])
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        let dm = divmod(x.bi, y.bi)
                        return newBlock(@[newInteger(dm.q), newInteger(dm.r)])
                    else:
                        let dm = divmod(x.bi, y.i)
                        return newBlock(@[newInteger(dm.q), newInteger(dm.r)])
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newBlock(@[x/y, x%y])
                elif y.kind==Rational: return newBlock(@[x/y, x%y])
                else: 
                    if likely(y.iKind==NormalInteger):
                        return newBlock(@[x/y, x%y])
                    else:
                        discard
                        # when not defined(NOGMP):
                        #     return newFloating(x.f mod y.bi)
            elif x.kind==Rational:
                if y.kind==Floating: return newBlock(@[x/y, x%y])
                elif y.kind==Rational: return newBlock(@[x/y, x%y])
                else: return newBlock(@[x/y, x%y])
            else:
                if y.kind==Rational:
                    return newBlock(@[x/y, x%y])
                else:
                    if likely(x.iKind==NormalInteger):
                        return newBlock(@[x/y, x%y])
                    else:
                        discard

proc `/%=`*(x: var Value, y: Value) =
    ## perform the divmod operation between given values
    ## and store the result in the first one
    ## 
    ## **Hint:** In-place, mutating operation
    if not (x.kind in {Integer,Floating,Rational}) or not (y.kind in {Integer,Floating,Rational}):
        x = newBlock(@[x/y, x%y])
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    x = newBlock(@[x/y, x%y])
                else:
                    when defined(WEB):
                        x = newBlock(@[x/y, x%y])
                    elif not defined(NOGMP):
                        let dm = divmod(x.i, y.bi)
                        x = newBlock(@[newInteger(dm.q), newInteger(dm.r)])
            else:
                when defined(WEB):
                    x = newBlock(@[x/y, x%y])
                elif not defined(NOGMP):
                    if unlikely(y.iKind==BigInteger):
                        let dm = divmod(x.bi, y.bi)
                        x = newBlock(@[newInteger(dm.q), newInteger(dm.r)])
                    else:
                        let dm = divmod(x.bi, y.i)
                        x = newBlock(@[newInteger(dm.q), newInteger(dm.r)])
        else:
            if x.kind==Floating:
                if y.kind==Floating: x = newBlock(@[x/y, x%y])
                elif y.kind==Rational: x = newBlock(@[x/y, x%y])
                else: 
                    if likely(y.iKind==NormalInteger):
                        x = newBlock(@[x/y, x%y])
                    else:
                        discard
                        # when not defined(NOGMP):
                        #     return newFloating(x.f mod y.bi)
            elif x.kind==Rational:
                if y.kind==Floating: x = newBlock(@[x/y, x%y])
                elif y.kind==Rational: x = newBlock(@[x/y, x%y])
                else: x = newBlock(@[x/y, x%y])
            else:
                if y.kind==Rational:
                    x = newBlock(@[x/y, x%y])
                else:
                    if likely(x.iKind==NormalInteger):
                        x = newBlock(@[x/y, x%y])
                    else:
                        discard

proc `^`*(x: Value, y: Value): Value =
    ## perform the power operation between given values
    ## 
    if not (x.kind in {Integer, Floating}) or not (y.kind in {Integer, Floating}):
        if x.kind == Quantity:
            if y.kind==Integer and (y.i > 0 and y.i < 4):
                if y.i == 1: return x
                elif y.i == 2: return x * x
                elif y.i == 3: return x * x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            elif y.kind==Floating and (y.f > 0 and y.f < 4):
                if y.f == 1.0: return x
                elif y.f == 2.0: return x * x
                elif y.f == 3.0: return x * x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            else:
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
        else: 
            return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if likely(x.iKind==NormalInteger):
                if likely(y.iKind==NormalInteger):
                    try:
                        if y.i >= 0:
                            return newInteger(safePow(x.i,y.i))
                        else:
                            return newFloating(pow(asFloat(x),asFloat(y)))
                    except OverflowDefect:
                        when defined(WEB):
                            return newInteger(big(x.i) ** big(y.i))
                        elif not defined(NOGMP):
                            return newInteger(pow(x.i,(culong)(y.i)))
                        else:
                            RuntimeError_IntegerOperationOverflow("pow", valueAsString(x), valueAsString(y))
                else:
                    when defined(WEB):
                        return newInteger(big(x.i) ** y.bi)
                    elif not defined(NOGMP):
                        RuntimeError_NumberOutOfPermittedRange("pow",valueAsString(x), valueAsString(y))
            else:
                when defined(WEB):
                    if likely(y.iKind==NormalInteger): 
                        return newInteger(x.bi ** big(y.i))
                    else: 
                        return newInteger(x.bi ** y.bi)
                elif not defined(NOGMP):
                    if likely(y.iKind==NormalInteger):
                        return newInteger(pow(x.bi,(culong)(y.i)))
                    else:
                        RuntimeError_NumberOutOfPermittedRange("pow",valueAsString(x), valueAsString(y))
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(pow(x.f,y.f))
                elif y.kind==Complex: return VNULL
                else: 
                    if likely(y.iKind==NormalInteger):
                        return newFloating(pow(x.f,(float)(y.i)))
                    else:
                        when not defined(NOGMP):
                            return newFloating(pow(x.f,y.bi))
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): return newComplex(pow(x.z,(float)(y.i)))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(pow(x.z,y.f))
                else: return newComplex(pow(x.z,y.z))
            else:
                if y.kind==Floating: 
                    if likely(x.iKind==NormalInteger):
                        return newFloating(pow((float)(x.i),y.f))
                    else:
                        when not defined(NOGMP):
                            return newFloating(pow(x.bi,y.f))
                else: return VNULL

proc `^=`*(x: var Value, y: Value) =
    ## perform the power operation between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if not (x.kind in {Integer, Floating}) or not (y.kind in {Integer, Floating}):
        if x.kind == Quantity:
            if y.kind==Integer and (y.i > 0 and y.i < 4):
                if y.i == 1: discard
                elif y.i == 2: x *= x
                elif y.i == 3: x *= x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            elif y.kind==Floating and (y.f > 0 and y.f < 4):
                if y.f == 1.0: discard
                elif y.f == 2.0: x *= x
                elif y.f == 3.0: x *= x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            else:
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("pow", valueAsString(x), valueAsString(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
        else: 
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            let res = pow((float)x.i,(float)y.i)
            x = newInteger((int)res)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x = newFloating(pow(x.f,y.f))
                elif y.kind==Complex: discard
                else: 
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(pow(x.f,(float)(y.i)))
                    else:
                        when not defined(NOGMP):
                            x = newFloating(pow(x.f,y.bi))
            elif x.kind==Complex:
                if y.kind==Integer:
                    if likely(y.iKind==NormalInteger): x = newComplex(pow(x.z,(float)(y.i)))
                    else: discard
                elif y.kind==Floating: x = newComplex(pow(x.z,y.f))
                else: x = newComplex(pow(x.z,y.z))
            else:
                if y.kind==Floating:
                    if likely(x.iKind==NormalInteger):
                        x = newFloating(pow((float)(x.i),y.f))
                    else:
                        when not defined(NOGMP):
                            x = newFloating(pow(x.bi,y.f))
                else: discard

proc `&&`*(x: Value, y: Value): Value =
    ## perform binary-and between given values
    ## and return the result
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        return newBinary(a and b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                return newInteger(x.i and y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) and y.bi)
                elif not defined(NOGMP):
                    return newInteger(x.i and y.bi)
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    return newInteger(x.bi and y.bi)
                else:
                    return newInteger(x.bi and big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    return newInteger(x.bi and y.bi)
                else:
                    return newInteger(x.bi and y.i)

proc `&&=`*(x: var Value, y: Value) =
    ## perform binary-and between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        x = newBinary(a and b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i and y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) and y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i and y.bi)
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi and y.bi)
                else:
                    x = newInteger(x.bi and big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi and y.bi)
                else:
                    x = newInteger(x.bi and y.i)

proc `||`*(x: Value, y: Value): Value =
    ## perform binary-or between given values
    ## and return the result
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        return newBinary(a or b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                return newInteger(x.i or y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) or y.bi)
                elif not defined(NOGMP):
                    return newInteger(x.i or y.bi)
                
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    return newInteger(x.bi or y.bi)
                else:
                    return newInteger(x.bi or big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    return newInteger(x.bi or y.bi)
                else:
                    return newInteger(x.bi or y.i)

proc `||=`*(x: var Value, y: Value) =
    ## perform binary-or between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        x = newBinary(a or b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i or y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) or y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i or y.bi)
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi or y.bi)
                else:
                    x = newInteger(x.bi or big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi or y.bi)
                else:
                    x = newInteger(x.bi or y.i)

proc `^^`*(x: Value, y: Value): Value =
    ## perform binary-xor between given values
    ## and return the result
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        return newBinary(a xor b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                return newInteger(x.i xor y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) xor y.bi)
                elif not defined(NOGMP):
                    return newInteger(x.i xor y.bi)
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    return newInteger(x.bi xor y.bi)
                else:
                    return newInteger(x.bi xor big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    return newInteger(x.bi xor y.bi)
                else:
                    return newInteger(x.bi xor y.i)

proc `^^=`*(x: var Value, y: Value) =
    ## perform binary-xor between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if (x.kind == Binary or y.kind==Binary) and (x.kind in {Integer, Binary} and y.kind in {Integer, Binary}):
        var a = (if x.kind==Binary: x.n else: numberToBinary(x.i))
        var b = (if y.kind==Binary: y.n else: numberToBinary(y.i))
        x = newBinary(a xor b)
    elif not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i xor y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) xor y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i xor y.bi)
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi xor y.bi)
                else:
                    x = newInteger(x.bi xor big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi xor y.bi)
                else:
                    x = newInteger(x.bi xor y.i)

proc `>>`*(x: Value, y: Value): Value =
    ## perform binary-right-shift between given values
    ## and return the result
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                return newInteger(x.i shr y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) shr y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shr",valueAsString(x), valueAsString(y))
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    return newInteger(x.bi shr y.bi)
                else:
                    return newInteger(x.bi shr big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    RuntimeError_NumberOutOfPermittedRange("shr",valueAsString(x), valueAsString(y))
                else:
                    return newInteger(x.bi shr (culong)(y.i))

proc `>>=`*(x: var Value, y: Value) =
    ## perform binary-right-shift between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i shr y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) shr y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shr",valueAsString(x), valueAsString(y))
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi shr y.bi)
                else:
                    x = newInteger(x.bi shr big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    RuntimeError_NumberOutOfPermittedRange("shr",valueAsString(x), valueAsString(y))
                else:
                    x = newInteger(x.bi shr (culong)(y.i))

proc `<<`*(x: Value, y: Value): Value =
    ## perform binary-left-shift between given values
    ## and return the result
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                return newInteger(x.i shl y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) shl y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shl",valueAsString(x), valueAsString(y))
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    return newInteger(x.bi shl y.bi)
                else:
                    return newInteger(x.bi shl big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    RuntimeError_NumberOutOfPermittedRange("shl",valueAsString(x), valueAsString(y))
                else:
                    return newInteger(x.bi shl (culong)(y.i))

proc `<<=`*(x: var Value, y: Value) =
    ## perform binary-left-shift between given values
    ## and store the result in the first value
    ## 
    ## **Hint:** In-place, mutation operation
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if likely(y.iKind==NormalInteger):
                x = newInteger(x.i shl y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) shl y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shl",valueAsString(x), valueAsString(y))
        else:
            when defined(WEB):
                if unlikely(y.iKind==BigInteger):
                    x = newInteger(x.bi shl y.bi)
                else:
                    x = newInteger(x.bi shl big(y.i))
            elif not defined(NOGMP):
                if unlikely(y.iKind==BigInteger):
                    RuntimeError_NumberOutOfPermittedRange("shl",valueAsString(x), valueAsString(y))
                else:
                    x = newInteger(x.bi shl (culong)(y.i))

proc `!!`*(x: Value): Value =
    ## perform binary-not for given value
    ## and return the result
    if x.kind == Binary:
        return newBinary(not x.n)
    elif not (x.kind==Integer):
        return VNULL
    else:
        if likely(x.iKind==NormalInteger):
            return newInteger(not x.i)
        else:
            when not defined(NOGMP):
                return newInteger(not x.bi)

proc `!!=`*(x: var Value) =
    ## perform binary-not for given value
    ## and store the result back in it
    ## 
    ## **Hint:** In-place, mutation operation
    if x.kind == Binary:
        x = newBinary(not x.n)
    elif not (x.kind==Integer):
        x = VNULL
    else:
        if likely(x.iKind==NormalInteger):
            x = newInteger(not x.i)
        else:
            when not defined(NOGMP):
                x = newInteger(not x.bi)

# proc `==`*[T](x,y:ref T){.error.}
# proc `<`*[T](x,y:ref T){.error.}
# proc `>`*[T](x,y:ref T){.error.}
# proc `<=`*[T](x,y:ref T){.error.}
# proc `>=`*[T](x,y:ref T){.error.}
# proc `!=`*[T](x,y:ref T){.error.}
# proc cmp*[T](x,y:ref T){.error.}

proc factorial*(x: Value): Value =
    ## calculate factorial of given value
    if not (x.kind == Integer):
        return VNULL
    else:
        if likely(x.iKind==NormalInteger):
            if x.i < 21:
                when defined(WEB):
                    if x.i < 13:
                        return newInteger(fac(x.i))
                    else:
                        let items = (toSeq(1..x.i)).map((w)=>newInteger(w))
                        var res = newInteger(1)
                        for item in items:
                            res = res * item
                        return res
                else:
                    return newInteger(fac(x.i))
            else:
                when defined(WEB):
                    let items = (toSeq(1..x.i)).map((w)=>newInteger(w))
                    var res = newInteger(1)
                    for item in items:
                        res = res * item
                elif defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("factorial",valueAsString(x), "")
                else:
                    return newInteger(newInt().fac(x.i))
        else:
            when not defined(WEB):
                RuntimeError_NumberOutOfPermittedRange("factorial",valueAsString(x), "")

func consideredEqual*(x: Value, y: Value): bool {.inline,enforceNoRaises.} =
    ## check whether given values are to be considered equal
    ## 
    ## **Hint:** This is a helper function *solely* for the
    ## evaluator and should not be used anywhere else

    let xKind = x.kind
    let yKind = y.kind
    if xKind in {Word,Label,Attribute,AttributeLabel} and yKind in {Word,Label,Attribute,AttributeLabel}:
        return x.s == y.s

    if xKind != yKind: return false

    case xKind:
        of Integer:
            if x.iKind != y.iKind: return false
            when not defined(NOGMP):
                if likely(x.iKind == NormalInteger):
                    return x.i == y.i
                else:
                    return x.bi == y.bi
            else:
                return x.i == y.i
        of String, Literal:
            return x.s == y.s
        of Floating:
            return x.f == y.f
        of Block:
            {.linearScanEnd.}
            if x.a.len != y.a.len: return false
            for i in 0..x.a.high:
                if not consideredEqual(x.a[i], y.a[i]): return false
            return true
    
        #---------------------------

        of Null: return true
        of Logical: return x.flags - {isDirty, isDynamic, isReadOnly} == y.flags - {isDirty, isDynamic, isReadOnly}
        of Complex: return x.z == y.z
        of Rational: return x.rat == y.rat
        of Version:
            return x.major == y.major and x.minor == y.minor and x.patch == y.patch and x.extra == y.extra
        of Type: 
            if x.tpKind != y.tpKind: return false
            if x.tpKind==BuiltinType:
                return x.t == y.t
            else:
                return x.ts.name == y.ts.name
        of Char: return x.c == y.c
        of Symbol,
           SymbolLiteral: return x.m == y.m
        of Quantity: return x.nm == y.nm and x.unit == y.unit
        of Regex: return x.rx == y.rx
        of Color: return x.l == y.l
        of Inline:
            if x.a.len != y.a.len: return false
            for i in 0..x.a.high:
                if not consideredEqual(x.a[i], y.a[i]): return false
            return true
        of Dictionary:
            if x.d.len != y.d.len: return false

            for k,v in pairs(x.d):
                if not y.d.hasKey(k): return false
                if not consideredEqual(v,y.d[k]): return false

            return true
        of Object:
            if x.o.len != y.o.len: return false
            if x.proto != y.proto: return false

            for k,v in pairs(x.o):
                if not y.o.hasKey(k): return false
                if not consideredEqual(v,y.o[k]): return false

            return true
        of Function:
            if x.fnKind==UserFunction:
                return consideredEqual(x.params, y.params) and consideredEqual(x.main, y.main) and x.exports == y.exports
            else:
                return x.action == y.action
        of Binary:
            return x.n == y.n
        of Bytecode:
            return x.trans == y.trans
        of Database:
            if x.dbKind != y.dbKind: return false
            when not defined(NOSQLITE):
                if x.dbKind==SqliteDatabase: return cast[ByteAddress](x.sqlitedb) == cast[ByteAddress](y.sqlitedb)
                #elif x.dbKind==MysqlDatabase: return cast[ByteAddress](x.mysqldb) == cast[ByteAddress](y.mysqldb)
        of Date:
            return x.eobj == y.eobj
        else:
            return false

# TODO(Value\hash) Verify hashing is done right
#  labels: vm,unit-test
func hash*(v: Value): Hash {.inline.}=
    ## calculate the hash for given value
    case v.kind:
        of Null         : result = 0
        of Logical      : result = cast[Hash](v.b)
        of Integer      : 
            if likely(v.iKind==NormalInteger): result = cast[Hash](v.i)
            else: 
                when defined(WEB) or not defined(NOGMP):
                    result = cast[Hash](v.bi)
        of Floating     : result = cast[Hash](v.f)
        of Complex      : 
            result = 1
            result = result !& cast[Hash](v.z.re)
            result = result !& cast[Hash](v.z.im)
            result = !$ result
        of Rational     : result = hash(v.rat)
        of Version      : 
            result = 1
            result = result !& cast[Hash](v.major)
            result = result !& cast[Hash](v.minor)
            result = result !& cast[Hash](v.patch)
            result = result !& hash(v.extra)
            result = !$ result
        of Type         : result = cast[Hash](ord(v.t))
        of Char         : result = cast[Hash](ord(v.c))
        of String       : result = hash(v.s)
        
        of Word,
           Literal,
           Label,
           Attribute,
           AttributeLabel        : result = hash(v.s)

        of Path,
           PathLabel    : 
            result = 1
            for i in v.p:
                result = result !& hash(i)
            result = !$ result

        of Symbol,
           SymbolLiteral: result = cast[Hash](ord(v.m))

        of Quantity:
            result = 1
            result = result !& hash(v.nm)
            result = result !& hash(v.unit)
            result = !$ result

        of Regex: result = hash(v.rx)

        of Color        : result = cast[Hash](v.l)

        of Date         : discard

        of Binary       : discard

        of Inline,
           Block        :
            result = 1
            for i in v.a:
                result = result !& hash(i)
            result = !$ result

        of Dictionary   : 
            result = 1
            for k,v in pairs(v.d):
                result = result !& hash(k)
                result = result !& hash(v)

        of Object       :
            result = 1
            for k,v in pairs(v.o):
                result = result !& hash(k)
                result = result !& hash(v)
        
        of Function     : 
            if v.fnKind==UserFunction:
                result = 1
                result = result !& hash(v.params)
                result = result !& hash(v.main)
                if not v.imports.isNil:
                    result = result !& hash(v.imports)

                if not v.exports.isNil:
                    result = result !& hash(v.exports)

                result = result !& hash(v.memoize)
                result = result !& hash(v.inline)
                result = !$ result
            else:
                result = cast[Hash](unsafeAddr v)
            # result = hash(v.params) !& hash(v.main)
            # result = !$ result
        of Database:
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: result = cast[Hash](cast[ByteAddress](v.sqlitedb))
                #elif v.dbKind==MysqlDatabase: result = cast[Hash](cast[ByteAddress](v.mysqldb))

        of Bytecode:
            result = cast[Hash](unsafeAddr v)

        of Newline      : result = 0
        of Nothing      : result = 0
        of ANY          : result = 0

{.pop.}
