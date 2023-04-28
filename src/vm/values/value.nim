#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/value.nim
#=======================================================

## Arturo's main Value object.

#=======================================
# Libraries
#=======================================

import hashes, macros
import sequtils, strutils, sugar
import tables, times, unicode

when not defined(WEB):
    import net except Socket

when not defined(NOSQLITE):
    import db_sqlite as sqlite
    #import db_mysql as mysql

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

when defined(NOGMP):
   import vm/errors

import vm/opcodes

import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vquantity, vrange, vrational, vregex, vsocket, vsymbol, vversion]

import vm/values/types
import vm/values/flags
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

    VTRUE*          = makeConst Value(kind: Logical, flags: ValueFlags(True))         ## constant True
    VFALSE*         = makeConst Value(kind: Logical, flags: ValueFlags(False))        ## constant False
    VMAYBE*         = makeConst Value(kind: Logical, flags: ValueFlags(Maybe))        ## constant Maybe

    VNULL*          = makeConst Value(kind: Null)                                     ## constant Null

    VEMPTYSTR*      = makeConst Value(kind: String, s: "")                                    ## constant ""
    VEMPTYARR*      = makeConst Value(kind: Block, a: @[], data: nil)                         ## constant []
    VEMPTYDICT*     = makeConst Value(kind: Dictionary, d: newOrderedTable[string,Value]())  ## constant #[]

    VSTRINGT*       = makeConst Value(kind: Type, tpKind: BuiltinType, t: String)     ## constant ``:string``
    VINTEGERT*      = makeConst Value(kind: Type, tpKind: BuiltinType, t: Integer)    ## constant ``:integer``

    #--------

    NoAliasBinding*     = AliasBinding(precedence: PostfixPrecedence, name: nil)

#=======================================
# Variables
#=======================================

var 
    TypeLookup = initOrderedTable[string,Value]()

    # global action references
    DoAdd*, DoSub*, DoMul*, DoDiv*, DoFdiv*, DoMod*, DoPow*                 : BuiltinAction
    DoNeg*, DoInc*, DoDec*                                                  : BuiltinAction
    DoBNot*, DoBAnd*, DoBOr*, DoShl*, DoShr*                                : BuiltinAction
    DoNot*, DoAnd*, DoOr*                                                   : BuiltinAction
    DoEq*, DoNe*, DoGt*, DoGe*, DoLt*, DoLe*                                : BuiltinAction
    DoGet*, DoSet*                                                          : BuiltinAction
    DoIf*, DoIfE*, DoUnless*, DoUnlessE*, DoElse*, DoSwitch*, DoWhile*      : BuiltinAction
    DoReturn*, DoBreak*, DoContinue*                                        : BuiltinAction
    DoTo*                                                                   : BuiltinAction
    DoArray*, DoDict*, DoFunc*, DoRange*                                    : BuiltinAction
    DoLoop*, DoMap*, DoSelect*                                              : BuiltinAction
    DoSize*, DoReplace*, DoSplit*, DoJoin*, DoReverse*, DoAppend*           : BuiltinAction
    DoPrint*                                                                : BuiltinAction

#=======================================
# Forward Declarations
#=======================================

func newDictionary*(d: sink ValueDict = newOrderedTable[string,Value]()): Value {.inline.}
func valueAsString*(v: Value): string {.inline,enforceNoRaises.}
func hash*(v: Value): Hash {.inline.}

#=======================================
# Converters
#=======================================

converter toDateTimeRef*(dt: ref DateTime): DateTime = dt[]
converter toOrderedTableRef*(valueDict: sink ValueDictObj): ValueDict =
    result = newOrderedTable[string, Value](0)
    result[] = valueDict

#=======================================
# Helpers
#=======================================

template isNull*(val: Value): bool  = val.kind == Null
template isFalse*(val: Value): bool = IsFalse in val.flags
template isMaybe*(val: Value): bool = IsMaybe in val.flags
template isTrue*(val: Value): bool  = IsTrue in val.flags

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
    newInteger(int(i))

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
    Value(kind: Floating, f: float(f))

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

    if fre.kind==Integer: r = float(fre.i)
    else: r = fre.f

    if fim.kind==Integer: i = float(fim.i)
    else: i = fim.f

    newComplex(r,i)

func newRational*(rat: VRational): Value {.inline, enforceNoRaises.} =
    ## create Rational value from VRational
    Value(kind: Rational, rat: rat)

when not defined(NOGMP):
    func newRational*(n: int | float | Int): Value {.inline.} =
        ## create Rational value from int, float or Int
        Value(kind: Rational, rat: toRational(n))

    func newRational*(num: int | float | Int, den: int | float | Int): Value {.inline.} = 
        ## create Rational value from numerator + denominator (int, float or Int)
        Value(kind: Rational, rat: toRational(num, den))
else:
    func newRational*(n: int | float): Value {.inline.} =
        ## create Rational value from int or float
        Value(kind: Rational, rat: toRational(n))

    func newRational*(num: int | float, den: int | float): Value {.inline.} = 
        ## create Rational value from numerator + denominator (int or float)
        Value(kind: Rational, rat: toRational(num, den))

func newRational*(num: Value, den: Value): Value {.inline, enforceNoRaises.} =
    ## create Rational value from numerator + denominator (Value)
    if num.kind == Integer and den.kind == Integer:
        if num.iKind == NormalInteger:
            if den.iKind == NormalInteger:
                return newRational(num.i, den.i)
            else:
                when not defined(NOGMP):
                    return newRational(num.i, den.bi)
        else:
            when not defined(NOGMP):
                if den.iKind == NormalInteger:
                    return newRational(num.bi, den.i)
                else:
                    return newRational(num.bi, den.bi)
    else:
        if num.kind == Integer:
            if num.iKind == NormalInteger:
                return newRational(num.i, den.f)
            else:
                when not defined(NOGMP):
                    return newRational(num.bi, den.f)
        else:
            if den.kind == Integer:
                if den.iKind == NormalInteger:
                    return newRational(num.f, den.i)
                else:
                    when not defined(NOGMP):
                        return newRational(num.f, den.bi)
            else:
                return newRational(num.f, den.f)

func newVersion*(v: string): Value {.inline.} =
    ## create Version value from string
    var numPart: string
    var extraPart: string
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

func newVersion*(v: VVersion): Value {.inline, enforceNoRaises.} =
    ## create Version value from VVersion
    Value(kind: Version, version: v)

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

func newQuantity*(v: Value, atoms: Atoms): Value {.inline, enforceNoRaises.} =
    ## create Quantity value from a numerical value ``v`` (Value) + ``atoms`` (Atoms)
    if v.kind == Integer:
        if v.iKind == NormalInteger:
            return newQuantity(v.i, atoms)
        else:
            when not defined(NOGMP):
                return newQuantity(v.bi, atoms)
    elif v.kind == Float:
        return newQuantity(v.f, atoms)
    else:
        return newQuantity(v.rat, atoms)

func newQuantity*(v: Value, atoms: string): Value {.inline.} =
    ## create Quantity value from a numerical value ``v`` (Value) + ``atoms`` (string)
    newQuantity(v, parseAtoms(atoms))

func newRegex*(rx: sink VRegex): Value {.inline, enforceNoRaises.} =
    ## create Regex value from VRegex
    Value(kind: Regex, rx: rx)

func newRegex*(rx: string, rflags: string = ""): Value {.inline.} =
    ## create Regex value from string
    newRegex(newRegexObj(rx, rflags))

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

func newDictionary*(d: sink ValueDict = newOrderedTable[string,Value]()): Value {.inline, enforceNoRaises.} =
    ## create Dictionary value from ValueDict
    Value(kind: Dictionary, d: d)

func newDictionary*(d: sink SymTable): Value {.inline, enforceNoRaises.} =
    ## create Dictionary value from SymTable
    newDictionary(toSeq(d.pairs).toOrderedTable)

func newObject*(o: sink ValueDict = newOrderedTable[string,Value](), proto: sink Prototype): Value {.inline, enforceNoRaises.} =
    ## create Object value from ValueDict with given prototype
    Value(kind: Object, o: o, proto: proto)

proc newObject*(args: ValueArray, prot: Prototype, initializer: proc (self: Value, prot: Prototype), o: ValueDict = newOrderedTable[string,Value]()): Value {.inline.} =
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

proc newObject*(args: ValueDict, prot: Prototype, initializer: proc (self: Value, prot: Prototype), o: ValueDict = newOrderedTable[string,Value]()): Value {.inline.} =
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

proc newStore*(sto: VStore): Value {.inline, enforceNoRaises.} =
    ## create Store value from VStore
    Value(kind: Store, sto: sto)

func newFunction*(params: seq[string], main: Value, imports: Value = nil, exports: Value = nil, memoize: bool = false, inline: bool = false): Value {.inline, enforceNoRaises.} =
    ## create Function (UserFunction) value with given parameters, ``main`` body, etc
    Value(
        kind: Function,
        info: nil,
        funcType: VFunction(
            fnKind: UserFunction,
            arity: int8(params.len),
            params: params,
            main: main,
            imports: imports,
            exports: exports,
            memoize: memoize,
            inline: inline,
            bcode: nil
        )
    )

func newBuiltin*(desc: sink string, modl: sink string, line: int, ar: int8, ag: sink OrderedTable[string,ValueSpec], at: sink OrderedTable[string,(ValueSpec,string)], ret: ValueSpec, exa: sink string, opc: OpCode, act: BuiltinAction): Value {.inline, enforceNoRaises.} =
    ## create Function (BuiltinFunction) value with given details
    result = Value(
        kind: Function,
        info: ValueInfo(
            descr: desc,
            module: modl,
            kind: Function,
            args: ag,
            attrs: at,
            returns: ret
        ),
        funcType: VFunction(
            fnKind: BuiltinFunction,
            arity: ar,
            op: opc,
            action: act
        )
    )
    when defined(DOCGEN):
        result.info.example = exa
        result.info.line = line

when not defined(NOSQLITE):
    proc newDatabase*(db: sqlite.DbConn): Value {.inline.} =
        ## create Database value from DbConn
        Value(kind: Database, dbKind: SqliteDatabase, sqlitedb: db)

when not defined(WEB):
    proc newSocket*(sock: VSocket): Value {.inline.} =
        ## create Socket value from Socket
        Value(kind: Socket, sock: sock)

# proc newDatabase*(db: mysql.DbConn): Value {.inline.} =
#     Value(kind: Database, dbKind: MysqlDatabase, mysqldb: db)

func newBytecode*(t: sink Translation): Value {.inline, enforceNoRaises.} =
    ## create Bytecode value from Translation
    Value(kind: Bytecode, trans: t)

func newInline*(a: sink ValueArray = @[]): Value {.inline, enforceNoRaises.} =
    ## create Inline value from ValueArray
    Value(kind: Inline, a: a)

func newBlock*(a: sink ValueArray = @[], data: sink Value = nil): Value {.inline, enforceNoRaises.} =
    ## create Block value from ValueArray
    Value(kind: Block, a: a, data: data)

func newBlock*(a: (Value, Value)): Value {.inline, enforceNoRaises.} =
    ## create Block value from tuple of two values
    newBlock(@[a[0], a[1]])

func newIntegerBlock*[T](a: sink seq[T]): Value {.inline, enforceNoRaises.} =
    ## create Block value from an array of ints
    newBlock(a.map(proc (x:T):Value = newInteger(int(x))))

proc newStringBlock*(a: sink seq[string]): Value {.inline, enforceNoRaises.} =
    ## create Block value from an array of strings
    newBlock(a.map(proc (x:string):Value = newString($x)))

proc newStringBlock*(a: sink seq[cstring]): Value {.inline, enforceNoRaises.} =
    ## create Block value from an array of cstrings
    newBlock(a.map(proc (x:cstring):Value = newString(x)))

proc newWordBlock*(a: sink seq[string]): Value {.inline, enforceNoRaises.} =
    ## create Block value from an array of strings
    newBlock(a.map(proc (x:string):Value = newWord(x)))

proc newRange*(start: int, stop: int, step: int, infinite: bool, numeric: bool, forward: bool): Value {.inline,enforceNoRaises.} =
    Value(kind: Range, rng: 
        VRange(
            start: start, 
            stop: stop, 
            step: step, 
            infinite: infinite, 
            numeric: numeric, 
            forward: forward
        )
    )

proc newRange*(rng: VRange): Value {.inline, enforceNoRaises.} =
    Value(kind: Range, rng: rng)

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
        of Version:     result = newVersion(v.version)
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

        of Symbol:          result = newSymbol(v.m)
        of SymbolLiteral:   result = newSymbolLiteral(v.m)
        of Regex:           result = newRegex(v.rx)
        of Quantity:        result = newQuantity(copyValue(v.nm), v.unit)
        of Color:           result = newColor(v.l)
        of Date:            result = newDate(v.eobj[])
        of Binary:          result = newBinary(v.n)
        of Inline:          result = newInline(v.a)
        of Block:       
            if v.data.isNil: 
                result = Value(kind: Block, a: v.a)
            else:
                result = newBlock(v.a.map((vv)=>copyValue(vv)), copyValue(v.data))
        of Range:
            result = newRange(v.rng.start, v.rng.stop, v.rng.step, v.rng.infinite, v.rng.numeric, v.rng.forward)

        of Dictionary:  result = newDictionary(v.d[])
        of Object:      result = newObject(v.o[], v.proto)
        of Store:       result = newStore(v.sto)

        of Function:    
            if v.fnKind == UserFunction:
                result = newFunction(v.params, v.main, v.imports, v.exports, v.memoize, v.inline)
            else:
                when defined(DOCGEN):
                    result = newBuiltin(v.info.descr, v.info.module, v.info.line, v.arity, v.info.args, v.info.attrs, v.info.returns, v.info.example, v.op, v.action)
                else:
                    result = newBuiltin(v.info.descr, v.info.module, 0, v.arity, v.info.args, v.info.attrs, v.info.returns, "", v.op, v.action)

        of Database:    
            when not defined(NOSQLITE):
                if v.dbKind == SqliteDatabase: result = newDatabase(v.sqlitedb)
                #elif v.dbKind == MysqlDatabase: result = newDatabase(v.mysqldb)

        of Socket:
            when not defined(WEB):
                result = newSocket(initSocket(v.sock.socket, v.sock.protocol, v.sock.address, Port(v.sock.port)))

        of Bytecode:
            result = newBytecode(v.trans)

        of Nothing, Any:
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
        result = float(v.i)

func asInt*(v: Value): int {.enforceNoRaises.} = 
    ## get numeric value forcefully as an int
    ## 
    ## **Hint:** We have to make sure the value is 
    ## either an Integer or a Floating value
    if v.kind == Integer:
        result = v.i
    else:
        result = int(v.f)

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

template ensureStoreIsLoaded*(sto: VStore) =
    when compiles(ensureLoaded(sto)):
        ensureLoaded(sto)
    else:
        sto.forceLoad(sto)

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
        of Logical: return x.b == y.b
        of Complex: return x.z == y.z
        of Rational: return x.rat == y.rat
        of Version: return x.version == y.version
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
        of Range: return x.rng == y.rng
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
                return x.params == y.params and consideredEqual(x.main, y.main) and x.exports == y.exports
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

func hash*(v: Value): Hash {.inline.}=
    ## calculate the hash for given value
    result = hash(v.kind)
    case v.kind:
        of Null         : discard
        of Logical      : result = result !& cast[Hash](v.b)
        of Integer      : 
            if likely(v.iKind==NormalInteger): result = result !& cast[Hash](v.i)
            else: 
                when defined(WEB) or not defined(NOGMP):
                    result = result !& cast[Hash](v.bi)
        of Floating     : result = result !& cast[Hash](v.f)
        of Complex      : 
            result = result !& cast[Hash](v.z.re)
            result = result !& cast[Hash](v.z.im)
        of Rational     : result = result !& hash(v.rat)
        of Version      : 
            result = result !& cast[Hash](v.major)
            result = result !& cast[Hash](v.minor)
            result = result !& cast[Hash](v.patch)
            result = result !& hash(v.extra)
        of Type         : result = result !& cast[Hash](ord(v.t))
        of Char         : result = result !& cast[Hash](ord(v.c))
        of String       : result = result !& hash(v.s)
        
        of Word,
           Literal,
           Label,
           Attribute,
           AttributeLabel        : result = result !& hash(v.s)

        of Path,
           PathLabel    : 
            for i in v.p:
                result = result !& hash(i)

        of Symbol,
           SymbolLiteral: result = result !& cast[Hash](ord(v.m))

        of Quantity:
            result = result !& hash(v.nm)
            result = result !& hash(v.unit)

        of Regex: result = result !& hash(v.rx)

        of Color        : result = result !& cast[Hash](v.l)

        of Date         : discard

        of Binary       : discard

        of Inline,
           Block        :
            result = 1
            for i in v.a:
                result = result !& hash(i)

        of Range        :
            result = result !& hash(v.rng[])

        of Dictionary   : 
            for k,val in pairs(v.d):
                result = result !& hash(k)
                result = result !& hash(val)

        of Object       :
            for k,val in pairs(v.o):
                result = result !& hash(k)
                result = result !& hash(val)

        of Store        :
            result = result !& hash(v.sto.path)
            result = result !& hash(v.sto.kind)
        
        of Function     : 
            if v.fnKind==UserFunction:
                result = result !& hash(v.params)
                result = result !& hash(v.main)
                if not v.imports.isNil:
                    result = result !& hash(v.imports)

                if not v.exports.isNil:
                    result = result !& hash(v.exports)

                result = result !& hash(v.memoize)
                result = result !& hash(v.inline)
            else:
                result = result !& cast[Hash](unsafeAddr v)

        of Database:
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: result = result !& cast[Hash](cast[ByteAddress](v.sqlitedb))
                #elif v.dbKind==MysqlDatabase: result = cast[Hash](cast[ByteAddress](v.mysqldb))

        of Socket:
            when not defined(WEB):
                result = result !& hash(v.sock)

        of Bytecode:
            result = result !& cast[Hash](unsafeAddr v)

        of Nothing      : discard
        of ANY          : discard

    result = !$ result

{.pop.}
