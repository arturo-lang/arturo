######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/value.nim
######################################################

# TODO(VM/values/value) General cleanup needed
#  There are various pieces of commented-out code that make the final result pretty much illegible. Let's clean this up.
#  labels: vm, values, cleanup

#=======================================
# Libraries
#=======================================

import complex, hashes, lenientops
import math, rationals, sequtils, strformat
import strutils, sugar, tables, times, unicode

when not defined(NOSQLITE):
    import db_sqlite as sqlite
    #import db_mysql as mysql

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import helpers/colors as ColorsHelper
import helpers/quantities as QuantitiesHelper
import helpers/regex as RegexHelper
import helpers/terminal as TerminalHelper

when not defined(WEB):
    import vm/errors

#=======================================
# Types
#=======================================
 
type
    ValueArray* = seq[Value]
    ValueDict*  = OrderedTable[string,Value]

    Byte* = byte
    ByteArray*  = seq[Byte]

    Translation* = (ValueArray, ByteArray) # (constants, instructions)

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

    ObjectSpec* = ref object
        name*       : string
        prototype*  : Value
        methods*    : Value
        inherits*   : Value

    SymbolDict*   = OrderedTable[SymbolKind,AliasBinding]

    logical* = enum
        False = 0, 
        True = 1,
        Maybe = 2

    Value* {.acyclic.} = ref object 
        info*: string
        # TODO(VM/values/value) remove unused `.custom` field
        #  and... rename the corresponding field in Object values
        #  labels: vm, values, cleanup, easy

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
            of Complex:     z*  : Complex64
            of Rational:    rat*  : Rational[int]
            of Version: 
                major*   : int
                minor*   : int
                patch*   : int
                extra*   : string
            of Type:        
                t*  : ValueKind
                case tpKind*: TypeKind:
                    of UserType:
                        ts* : ObjectSpec
                    of BuiltinType:
                        discard

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
            of Regex:       rx* : RegexObj
            of Quantity:
                nm*: Value
                unit*: QuantitySpec
            of Color:       l*  : VColor
            of Date:        
                e*     : ValueDict         
                eobj*  : DateTime
            of Binary:      n*  : ByteArray
            of Inline,
               Block:       
                   a*   : ValueArray
                   data* : Value
                   #refs*: IntArray
            of Dictionary:  d*  : ValueDict
            of Object:
                o*: ValueDict
                os*: ObjectSpec
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
                consts*: ValueArray
                instrs*: ByteArray

            of Newline:
                line*: int

#=======================================
# Constants
#=======================================

const
    NoValues*       = @[]
    NoTranslation*  = (@[],@[])

#=======================================
# Fixed Values
#=======================================

let I0*  = Value(kind: Integer, iKind: NormalInteger, i: 0)
let I1*  = Value(kind: Integer, iKind: NormalInteger, i: 1)
let I2*  = Value(kind: Integer, iKind: NormalInteger, i: 2)
let I3*  = Value(kind: Integer, iKind: NormalInteger, i: 3)
let I4*  = Value(kind: Integer, iKind: NormalInteger, i: 4)
let I5*  = Value(kind: Integer, iKind: NormalInteger, i: 5)
let I6*  = Value(kind: Integer, iKind: NormalInteger, i: 6)
let I7*  = Value(kind: Integer, iKind: NormalInteger, i: 7)
let I8*  = Value(kind: Integer, iKind: NormalInteger, i: 8)
let I9*  = Value(kind: Integer, iKind: NormalInteger, i: 9)
let I10* = Value(kind: Integer, iKind: NormalInteger, i: 10)

let I1M* = Value(kind: Integer, iKind: NormalInteger, i: -1)

let F0*  = Value(kind: Floating, f: 0.0)
let F1*  = Value(kind: Floating, f: 1.0)

let VTRUE*  = Value(kind: Logical, b: True)
let VFALSE* = Value(kind: Logical, b: False)
let VMAYBE* = Value(kind: Logical, b: Maybe)

let VNULL* = Value(kind: Null)

let VNOTHING* = Value(kind: Nothing)

#=======================================
# Variables
#=======================================

var 
    TypeLookup = initOrderedTable[string,Value]()
    #DoDebug* = false

#=======================================
# Forward Declarations
#=======================================

func newDictionary*(d: ValueDict = initOrderedTable[string,Value]()): Value {.inline.}
func `$`(v: Value): string {.inline.}
proc `+`*(x: Value, y: Value): Value
proc `-`*(x: Value, y: Value): Value
proc `*`*(x: Value, y: Value): Value
proc `/`*(x: Value, y: Value): Value
proc `//`*(x: Value, y: Value): Value
func hash*(v: Value): Hash {.inline.}

#=======================================
# Helpers
#=======================================

when defined(WEB):
    var stdout: string = ""

    proc resetStdout*()=
        stdout = ""

    proc write*(buffer: var string, str: string) =
        buffer &= str
    
    proc flushFile*(buffer: var string) =
        echo buffer

template newNull*(): Value =
    VNULL

template newNothing*(): Value =
    VNOTHING

proc newLogical*(b: logical): Value {.inline.} =
    if b==True: VTRUE
    elif b==False: VFALSE
    else: VMAYBE

proc newLogical*(b: bool): Value {.inline.} =
    if b: VTRUE
    else: VFALSE

proc newLogical*(s: string): Value {.inline.} =
    if s=="true": newLogical(True)
    elif s=="false": newLogical(False)
    else: newLogical(Maybe)

proc newLogical*(i: int): Value {.inline.} =
    if i==1: newLogical(True)
    elif i==0: newLogical(False)
    else: newLogical(Maybe)

when defined(WEB):
    proc newInteger*(bi: JsBigInt): Value {.inline.} =
        result = Value(kind: Integer, iKind: BigInteger, bi: bi)

when not defined(NOGMP):
    proc newInteger*(bi: Int): Value {.inline.} =
        result = Value(kind: Integer, iKind: BigInteger, bi: bi)

func newInteger*(i: int): Value {.inline.} =
    result = Value(kind: Integer, iKind: NormalInteger, i: i)

func newInteger*(i: int64): Value {.inline.} =
    newInteger((int)(i))

proc newInteger*(i: string, lineno: int = 1): Value {.inline.} =
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
    when defined(WEB):
        result = Value(kind: Integer, iKind: BigInteger, bi: big(i))
    elif not defined(NOGMP):
        result = Value(kind: Integer, iKind: BigInteger, bi: newInt(i))

func newFloating*(f: float): Value {.inline.} =
    Value(kind: Floating, f: f)

func newFloating*(f: int): Value {.inline.} =
    Value(kind: Floating, f: (float)(f))

proc newFloating*(f: string): Value {.inline.} =
    return newFloating(parseFloat(f))

func newComplex*(com: Complex64): Value {.inline.} =
    Value(kind: Complex, z: com)

func newComplex*(fre: float, fim: float): Value {.inline.} =
    Value(kind: Complex, z: Complex64(re: fre, im: fim))

func newComplex*(fre: Value, fim: Value): Value {.inline.} =
    var r: float
    var i: float

    if fre.kind==Integer: r = (float)(fre.i)
    else: r = fre.f

    if fim.kind==Integer: i = (float)(fim.i)
    else: i = fim.f

    newComplex(r,i)

func newRational*(rat: Rational[int]): Value {.inline.} =
    Value(kind: Rational, rat: rat)

func newRational*(num: int, den: int): Value {.inline.} =
    Value(kind: Rational, rat: initRational(num, den))

func newRational*(n: int): Value {.inline.} =
    Value(kind: Rational, rat: toRational(n))

func newRational*(n: float): Value {.inline.} =
    Value(kind: Rational, rat: toRational(n))

func newRational*(num: Value, den: Value): Value {.inline.} =
    newRational(num.i, den.i)

func newVersion*(v: string): Value {.inline.} =
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
    Value(kind: Version, major: parseInt(parts[0]), 
                         minor: parseInt(parts[1]), 
                         patch: parseInt(parts[2]), 
                         extra: extraPart)

func newType*(t: ValueKind): Value {.inline.} =
    Value(kind: Type, tpKind: BuiltinType, t: t)

proc newUserType*(n: string, p: Value = VNULL): Value {.inline.} =
    if TypeLookup.hasKey(n):
        return TypeLookup[n]
    else:
        result = Value(kind: Type, tpKind: UserType, t: Dictionary, name: n, prototype: p, inherits: VNULL)
        TypeLookup[n] = result

proc newType*(t: string): Value {.inline.} =
    try:
        newType(parseEnum[ValueKind](t.capitalizeAscii()))
    except ValueError:
        newUserType(t)

func newChar*(c: Rune): Value {.inline.} =
    Value(kind: Char, c: c)

func newChar*(c: char): Value {.inline.} =
    Value(kind: Char, c: ($c).runeAt(0))

func newChar*(c: string): Value {.inline.} =
    Value(kind: Char, c: c.runeAt(0))

func newString*(s: string, dedented: bool = false): Value {.inline.} =
    if not dedented: Value(kind: String, s: s)
    else: Value(kind: String, s: unicode.strip(dedent(s)))

func newString*(s: cstring, dedented: bool = false): Value {.inline.} =
    newString($(s), dedented)

func newWord*(w: string): Value {.inline.} =
    Value(kind: Word, s: w)

func newLiteral*(l: string): Value {.inline.} =
    Value(kind: Literal, s: l)

func newLabel*(l: string): Value {.inline.} =
    Value(kind: Label, s: l)

func newAttribute*(a: string): Value {.inline.} =
    Value(kind: Attribute, r: a)

func newAttributeLabel*(a: string): Value {.inline.} =
    Value(kind: AttributeLabel, r: a)

func newPath*(p: ValueArray): Value {.inline.} =
    Value(kind: Path, p: p)

func newPathLabel*(p: ValueArray): Value {.inline.} =
    Value(kind: PathLabel, p: p)

func newSymbol*(m: SymbolKind): Value {.inline.} =
    Value(kind: Symbol, m: m)

func newSymbol*(m: string): Value {.inline.} =
    newSymbol(parseEnum[SymbolKind](m))

func newSymbolLiteral*(m: SymbolKind): Value {.inline.} =
    Value(kind: SymbolLiteral, m: m)

func newSymbolLiteral*(m: string): Value {.inline.} =
    newSymbolLiteral(parseEnum[SymbolKind](m))

func newQuantity*(nm: Value, unit: QuantitySpec): Value {.inline.} =
    Value(kind: Quantity, nm: nm, unit: unit)

proc newQuantity*(nm: Value, name: UnitName): Value {.inline.} =
    newQuantity(nm, newQuantitySpec(name))

proc convertToTemperatureUnit*(v: Value, src: UnitName, tgt: UnitName): Value =
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
    var fromK = fromKind
    var toK = toKind
    if fromK==NoUnit: fromK = quantityKindForName(fromU)
    if toK==NoUnit: toK = quantityKindForName(toU)

    if fromK!=toK:
        when not defined(WEB):
            RuntimeError_CannotConvertQuantity($(nm), stringify(fromU), stringify(fromK), stringify(toU), stringify(toK))
    
    if toK == TemperatureUnit:
        return convertToTemperatureUnit(nm, fromU, toU)
    else:
        let fmultiplier = getQuantityMultiplier(fromU, toU, isCurrency=fromK==CurrencyUnit)
        if fmultiplier == 1.0:
            return nm
        else:
            return nm * newFloating(fmultiplier)

func newRegex*(rx: RegexObj): Value {.inline.} =
    Value(kind: Regex, rx: rx)

func newRegex*(rx: string): Value {.inline.} =
    newRegex(newRegexObj(rx))

func newColor*(l: VColor): Value {.inline.} =
    Value(kind: Color, l: l)

func newColor*(rgb: RGB): Value {.inline.} =
    newColor(colorFromRGB(rgb))

func newColor*(l: string): Value {.inline.} =
    newColor(parseColor(l))

func newDate*(dt: DateTime): Value {.inline.} =
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
    Value(kind: Date, e: edict, eobj: dt)

func newBinary*(n: ByteArray = @[]): Value {.inline.} =
    Value(kind: Binary, n: n)

func newDictionary*(d: ValueDict = initOrderedTable[string,Value]()): Value {.inline.} =
    Value(kind: Dictionary, d: d)

func newObject*(o: ValueDict = initOrderedTable[string,Value](), tp: Value): Value {.inline.} =
    Value(kind: Object, o: o, cust: tp)

proc newObject*(args: ValueArray, tp: Value, initializer: proc (self: Value, tp: Value), o: ValueDict = initOrderedTable[string,Value]()): Value {.inline.} =
    var fields = o
    var i = 0
    while i<args.len and i<tp.prototype.a.len:
        let k = tp.prototype.a[i]
        fields[k.s] = args[i]
        i += 1

    result = newObject(fields, tp)
    
    initializer(result, tp)

func newFunction*(params: Value, main: Value, imports: Value = VNULL, exports: Value = VNULL, exportable: bool = false, memoize: bool = false): Value {.inline.} =
    Value(kind: Function, fnKind: UserFunction, params: params, main: main, imports: imports, exports: exports, exportable: exportable, memoize: memoize)

func newBuiltin*(name: string, al: SymbolKind, pr: PrecedenceKind, desc: string, ar: int, ag: OrderedTable[string,ValueSpec], at: OrderedTable[string,(ValueSpec,string)], ret: ValueSpec, exa: string, act: BuiltinAction): Value {.inline.} =
    Value(
        kind    : Function, 
        fnKind  : BuiltinFunction, 
        fname   : name, 
        alias   : al, 
        prec    : pr,
        info    : desc, 
        arity   : ar, 
        args    : ag, 
        attrs   : at, 
        returns : ret, 
        example : exa, 
        action  : act
    )

when not defined(NOSQLITE):
    proc newDatabase*(db: sqlite.DbConn): Value {.inline.} =
        Value(kind: Database, dbKind: SqliteDatabase, sqlitedb: db)

# proc newDatabase*(db: mysql.DbConn): Value {.inline.} =
#     Value(kind: Database, dbKind: MysqlDatabase, mysqldb: db)

func newBytecode*(c: ValueArray, i: ByteArray): Value {.inline.} =
    Value(kind: Bytecode, consts: c, instrs: i)

func newInline*(a: ValueArray = @[]): Value {.inline.} = #, refs: seq[int] = @[]): Value {.inline.} = 
    Value(kind: Inline, a: a)#, refs: refs)

func newBlock*(a: ValueArray = @[], data = VNULL): Value {.inline.} = #, refs: seq[int] = @[]): Value {.inline.} =
    Value(kind: Block, a: a, data: data)#, refs: refs)

func newIntegerBlock*[T](a: seq[T]): Value {.inline.} =
    newBlock(a.map(proc (x:T):Value = newInteger((int)(x))))

proc newStringBlock*(a: seq[string]): Value {.inline.} =
    newBlock(a.map(proc (x:string):Value = newString($x)))

proc newStringBlock*(a: seq[cstring]): Value {.inline.} =
    newBlock(a.map(proc (x:cstring):Value = newString(x)))

func newNewline*(l: int): Value {.inline.} =
    #echo "VALUE: adding newline: " & $(l)
    Value(kind: Newline, line: l)

proc newStringDictionary*(a: Table[string, string]): Value =
    result = newDictionary()
    for k,v in a.pairs:
        result.d[k] = newString(v)

proc newStringDictionary*(a: TableRef[string, seq[string]], collapseBlocks=false): Value =
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
    case v.kind:
        of Null:        result = VNULL
        of Logical:     result = newLogical(v.b)
        of Integer:     
            if v.iKind == NormalInteger: result = newInteger(v.i)
            else:
                when defined(WEB) or not defined(NOGMP): 
                    result = newInteger(v.bi)
        of Floating:    result = newFloating(v.f)
        of Complex:     result = newComplex(v.z)
        of Rational:    result = newRational(v.rat)
        of Type:        
            if v.tpKind==BuiltinType:
                result = newType(v.t)
            else:
                result = newUserType(v.name, v.prototype)
        of Char:        result = newChar(v.c)

        of String:      result = newString(v.s)
        of Word:        result = newWord(v.s)
        of Literal:     result = newLiteral(v.s)
        of Label:       result = newLabel(v.s)

        of Attribute:        result = newAttribute(v.r)
        of AttributeLabel:   result = newAttributeLabel(v.r)

        of Path:        result = newPath(v.p)
        of PathLabel:   result = newPathLabel(v.p)

        of Symbol:      result = newSymbol(v.m)
        of Date:        result = newDate(v.eobj)
        of Binary:      result = newBinary(v.n)

        of Inline:      result = newInline(v.a)
        of Block:       result = newBlock(v.a.map((vv)=>copyValue(vv)), copyValue(v.data))

        of Dictionary:  result = newDictionary(v.d)
        of Object:      result = newObject(v.o, v.cust)

        of Function:    result = newFunction(v.params, v.main, v.imports, v.exports, v.exportable, v.memoize)

        of Database:    
            when not defined(NOSQLITE):
                if v.dbKind == SqliteDatabase: result = newDatabase(v.sqlitedb)
                #elif v.dbKind == MysqlDatabase: result = newDatabase(v.mysqldb)

        else: discard

func addChild*(parent: Value, child: Value) {.inline.} =
    parent.a.add(child)

func removeChildren*(parent: Value, rng: Slice[int]) {.inline.} =
    parent.a.delete(rng)

func asFloat*(v: Value): float = 
    # get number value forcefully as a float
    if v.kind == Floating:
        result = v.f
    else:
        result = (float)(v.i)

func asInt*(v: Value): int = 
    # get number value forcefully as an int
    if v.kind == Integer:
        result = v.i
    else:
        result = (int)(v.f)

func getArity*(x: Value): int =
    if x.fnKind==BuiltinFunction:
        return x.arity
    else:
        return x.params.a.len

template cleanBlock*(va: ValueArray, inplace: bool = false): untyped =
    when not defined(NOERRORLINES):
        when inplace:
            va.keepIf((vv) => vv.kind != Newline)
        else:
            @(va.filter((vv) => vv.kind != Newline))
    else:
        when inplace:
            discard
        else:
            va

#=======================================
# Methods
#=======================================

# TODO(VM/values/value) Verify that all errors are properly thrown
#  Various core arithmetic operations between Value values may lead to errors. Are we catching - and reporting - them all properly?
#  labels: vm, values, error handling, unit-test

proc `+`*(x: Value, y: Value): Value =
    if x.kind==Color and y.kind==Color:
        return newColor(x.l + y.l)
    if not (x.kind in [Integer, Floating, Complex, Rational]) or not (y.kind in [Integer, Floating, Complex, Rational]):
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
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        return newInteger(x.i+y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            return newInteger(big(x.i)+big(y.i))
                        elif not defined(NOGMP):
                            return newInteger(newInt(x.i)+y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("add", $(x), $(y))
                else:
                    when defined(WEB):
                        return newInteger(big(x.i)+y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i+y.bi)
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi+y.bi)
                    else:
                        return newInteger(x.bi+big(y.i))
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi+y.bi)
                    else:
                        return newInteger(x.bi+y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f+y.f)
                elif y.kind==Complex: return newComplex(x.f+y.z)
                elif y.kind==Rational: return newRational(toRational(x.f) + y.rat)
                else: 
                    if y.iKind==NormalInteger:
                        return newFloating(x.f+y.i)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f+y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(x.z+(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z+y.f)
                elif y.kind==Rational: return VNULL
                else: return newComplex(x.z+y.z)
            elif x.kind==Rational:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newRational(x.rat+y.i)
                    else: return VNULL
                elif y.kind==Floating: return newRational(x.rat+toRational(y.f))
                elif y.kind==Complex: return VNULL
                else: return newRational(x.rat+y.rat)
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
                        return newFloating(x.i+y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi+y.f)
                elif y.kind==Rational: return newRational(x.i+y.rat)
                else: return newComplex((float)(x.i)+y.z)

proc `+=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Complex, Rational]) or not (y.kind in [Integer, Floating, Complex, Rational]):
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
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        x.i += y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)+big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)+y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("add", $(x), $(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)+y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i+y.bi)
                    
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        x.bi += y.bi
                    else:
                        x.bi += big(y.i)
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
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
                    if y.iKind==NormalInteger: x = newComplex(x.z + (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z + y.f)
                elif y.kind==Rational: discard
                else: x.z += y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x.rat += y.i
                    else: discard
                elif y.kind==Floating: x.rat += toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat += y.rat
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
                        x = newFloating(x.i+y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi+y.f)
                elif y.kind==Rational: x = newRational(x.i+y.rat)
                else: x = newComplex((float)(x.i)+y.z)

proc `-`*(x: Value, y: Value): Value = 
    if x.kind==Color and y.kind==Color:
        return newColor(x.l - y.l)
    if not (x.kind in [Integer, Floating, Complex, Rational]) or not (y.kind in [Integer, Floating, Complex, Rational]):
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
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        return newInteger(x.i-y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            return newInteger(big(x.i)-big(y.i))
                        elif not defined(NOGMP):
                            return newInteger(newInt(x.i)-y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("sub", $(x), $(y))
                else:
                    when defined(WEB):
                        return newInteger(big(x.i)-y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i-y.bi)
                    
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi-y.bi)
                    else:
                        return newInteger(x.bi-big(y.i))
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi-y.bi)
                    else:
                        return newInteger(x.bi-y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f-y.f)
                elif y.kind==Complex: return newComplex(x.f-y.z)
                elif y.kind==Rational: return newRational(toRational(x.f)-y.rat)
                else: 
                    if y.iKind==NormalInteger:
                        return newFloating(x.f-y.i)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f-y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(x.z-(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z-y.f)
                elif y.kind==Rational: return VNULL
                else: return newComplex(x.z-y.z)
            elif x.kind==Rational:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newRational(x.rat-y.i)
                    else: return VNULL
                elif y.kind==Floating: return newRational(x.rat-toRational(y.f))
                elif y.kind==Complex: return VNULL
                else: return newRational(x.rat-y.rat)
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
                        return newFloating(x.i-y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi-y.f)
                elif y.kind==Rational: return newRational(x.i-y.rat)
                else: return newComplex((float)(x.i)-y.z)

proc `-=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Complex, Rational]) or not (y.kind in [Integer, Floating, Complex, Rational]):
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
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        x.i -= y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)-big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)-y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("sub", $(x), $(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)-y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i-y.bi)
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        x.bi -= y.bi
                    else:
                        x.bi -= big(y.i)
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
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
                    if y.iKind==NormalInteger: x = newComplex(x.z - (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z - y.f)
                elif y.kind==Rational: discard
                else: x.z -= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x.rat -= y.i
                    else: discard
                elif y.kind==Floating: x.rat -= toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat -= y.rat
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
                        x = newFloating(x.i-y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi-y.f)
                elif y.kind==Rational: x = newRational(x.i-y.rat)
                else: x = newComplex((float)(x.i)-y.z)

proc `*`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating, Complex, Rational]) or not (y.kind in [Integer, Floating, Complex, Rational]):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("mul", x.unit, y.unit)
                if finalSpec == ErrorQuantity:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("mul", $(x), $(y), stringify(x.unit.kind), stringify(y.unit.kind))
                else:
                    return newQuantity(x.nm * convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                return newQuantity(x.nm * y, x.unit)
        else:
            return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        return newInteger(x.i*y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            return newInteger(big(x.i)*big(y.i))
                        elif not defined(NOGMP):
                            return newInteger(newInt(x.i)*y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("mul", $(x), $(y))
                else:
                    when defined(WEB):
                        return newInteger(big(x.i)*y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i*y.bi)
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi*y.bi)
                    else:
                        return newInteger(x.bi*big(y.i))
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi*y.bi)
                    else:
                        return newInteger(x.bi*y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f*y.f)
                elif y.kind==Complex: return newComplex(x.f*y.z)
                elif y.kind==Rational: return newRational(toRational(x.f)*y.rat)
                else:
                    if y.iKind==NormalInteger:
                        return newFloating(x.f*y.i)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f * y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(x.z*(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z*y.f)
                elif y.kind==Rational: return VNULL
                else: return newComplex(x.z*y.z)
            elif x.kind==Rational:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newRational(x.rat*y.i)
                    else: return VNULL
                elif y.kind==Floating: return newRational(x.rat*toRational(y.f))
                elif y.kind==Complex: return VNULL
                else: return newRational(x.rat*y.rat)
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
                        return newFloating(x.i*y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi * y.f)
                elif y.kind==Rational: return newRational(x.i*y.rat)
                else: return newComplex((float)(x.i)*y.z)

proc `*=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Complex, Rational]) or not (y.kind in [Integer, Floating, Complex, Rational]):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("mul", x.unit, y.unit)
                if finalSpec == ErrorQuantity:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("mul", $(x), $(y), stringify(x.unit.kind), stringify(y.unit.kind))
                else:
                    x = newQuantity(x.nm * convertQuantityValue(y.nm, y.unit.name, getCleanCorrelatedUnit(y.unit, x.unit).name), finalSpec)
            else:
                x.nm *= y
        else:
            x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        x.i *= y.i
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i)*big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i)*y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("mul", $(x), $(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i)*y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i*y.bi)
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        x.bi *= y.bi
                    else:
                        x.bi *= big(y.i)
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
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
                    if y.iKind==NormalInteger: x = newComplex(x.z * (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z * y.f)
                else: x.z *= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x.rat *= y.i
                    else: discard
                elif y.kind==Floating: x.rat *= toRational(y.f)
                elif y.kind==Complex: discard
                else: x.rat *= y.rat
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
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
    if not (x.kind in [Integer, Floating, Complex, Rational]) or not (y.kind in [Integer, Floating, Complex, Rational]):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("div", x.unit, y.unit)
                if finalSpec == ErrorQuantity:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("div", $(x), $(y), stringify(x.unit.kind), stringify(y.unit.kind))
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
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    return newInteger(x.i div y.i)
                else:
                    when defined(WEB):
                        return newInteger(big(x.i) div y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i div y.bi)
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi div y.bi)
                    else:
                        return newInteger(x.bi div big(y.i))
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi div y.bi)
                    else:
                        return newInteger(x.bi div y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f/y.f)
                elif y.kind==Complex: return newComplex(x.f/y.z)
                elif y.kind==Rational: return newInteger(toRational(x.f) div y.rat)
                else: 
                    if y.iKind==NormalInteger:
                        return newFloating(x.f/y.i)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.f / y.bi)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(x.z/(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z/y.f)
                elif y.kind==Rational: return VNULL
                else: return newComplex(x.z/y.z)
            elif x.kind==Rational:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newInteger(x.rat div toRational(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newInteger(x.rat div toRational(y.f))
                elif y.kind==Complex: return VNULL
                else: return newInteger(x.rat div y.rat)
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
                        return newFloating(x.i/y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi/y.f)
                elif y.kind==Rational: return newInteger(toRational(x.i) div y.rat)
                else: return newComplex((float)(x.i)/y.z)

proc `/=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Complex, Rational]) or not (y.kind in [Integer, Floating, Complex, Rational]):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("div", x.unit, y.unit)
                if finalSpec == ErrorQuantity:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("div", $(x), $(y), stringify(x.unit.kind), stringify(y.unit.kind))
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
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        x = newInteger(x.i div y.i)
                    except OverflowDefect:
                        when defined(WEB):
                            x = newInteger(big(x.i) div big(y.i))
                        elif not defined(NOGMP):
                            x = newInteger(newInt(x.i) div y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("div", $(x), $(y))
                else:
                    when defined(WEB):
                        x = newInteger(big(x.i) div y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i div y.bi)
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        x = newInteger(x.bi div y.bi)
                    else:
                        x = newInteger(x.bi div big(y.i))
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
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
                    if y.iKind==NormalInteger: x = newComplex(x.z / (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z / y.f)
                else: x.z /= y.z
            elif x.kind==Rational:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x = newInteger(x.rat div toRational(y.i))
                    else: discard
                elif y.kind==Floating: x = newInteger(x.rat div toRational(y.f))
                elif y.kind==Complex: discard
                else: x = newInteger(x.rat div y.rat)
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
                        x = newFloating(x.i/y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi/y.f)
                elif y.kind==Rational: x = newInteger(toRational(x.i) div y.rat)
                else: x = newComplex((float)(x.i)/y.z)

proc `//`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating, Rational]) or not (y.kind in [Integer, Floating, Rational]):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("fdiv", x.unit, y.unit)
                if finalSpec == ErrorQuantity:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("fdiv", $(x), $(y), stringify(x.unit.kind), stringify(y.unit.kind))
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
                    if y.iKind==NormalInteger:
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
                    if x.iKind==NormalInteger:
                        return newFloating((float)(x.i)/y.f)
                    else:
                        when not defined(NOGMP):
                            return newFloating(x.bi/y.f)
                else: return newRational(x.i / y.rat)


proc `//=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Rational]) or not (y.kind in [Integer, Floating, Rational]):
        if x.kind == Quantity:
            if y.kind == Quantity:
                let finalSpec = getFinalUnitAfterOperation("fdiv", x.unit, y.unit)
                if finalSpec == ErrorQuantity:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("fdiv", $(x), $(y), stringify(x.unit.kind), stringify(y.unit.kind))
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
                    if x.iKind==NormalInteger:
                        x = newFloating((float)(x.i)/y.f)
                    else:
                        when not defined(NOGMP):
                            x = newFloating(x.bi/y.f)
                else: x = newRational(x.i / y.rat)
                
proc `%`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer,Floating,Rational]) or not (y.kind in [Integer,Floating,Rational]):
        if (x.kind == Quantity and y.kind == Quantity) and (x.unit.kind==y.unit.kind):
            if x.unit.name == y.unit.name:
                return newQuantity(x.nm % y.nm, x.unit)
            else:
                return newQuantity(x.nm % convertQuantityValue(y.nm, y.unit.name, x.unit.name), x.unit)
        else:
            if x.unit.kind != y.unit.kind:
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("mod", $(x), $(y), stringify(x.unit.kind), stringify(y.unit.kind))
            else:
                return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    return newInteger(x.i mod y.i)
                else:
                    when defined(WEB):
                        return newInteger(big(x.i) mod y.bi)
                    elif not defined(NOGMP):
                        return newInteger(x.i mod y.bi)
            else:
                when defined(WEB):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi mod y.bi)
                    else:
                        return newInteger(x.bi mod big(y.i))
                elif not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi mod y.bi)
                    else:
                        return newInteger(x.bi mod y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f mod y.f)
                elif y.kind==Rational: return newRational(toRational(x.f) mod y.rat)
                else: 
                    if y.iKind==NormalInteger:
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
                    if x.iKind==NormalInteger:
                        return newFloating((float)(x.i) mod y.f)
                    else:
                        discard
                        # when not defined(NOGMP):
                        #     return newFloating(x.bi mod y.f)

proc `%=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer,Floating,Rational]) or not (y.kind in [Integer,Floating,Rational]):
        if (x.kind == Quantity and y.kind == Quantity) and (x.unit.kind==y.unit.kind):
            if x.unit.name == y.unit.name:
                x.nm %= y.nm
            else:
                x.nm %= convertQuantityValue(y.nm, y.unit.name, x.unit.name)
        else:
            if x.unit.kind != y.unit.kind:
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("mod", $(x), $(y), stringify(x.unit.kind), stringify(y.unit.kind))
            else:
                x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger: 
                    x.i = x.i mod y.i
                else: 
                    when defined(WEB):
                        x = newInteger(big(x.i) mod y.bi)
                    elif not defined(NOGMP):
                        x = newInteger(x.i mod y.bi)
            else:
                when defined(WEB):
                    if y.iKind==NormalInteger: 
                        x = newInteger(x.bi mod big(y.i))
                    else: 
                        x = newInteger(x.bi mod y.bi)
                elif not defined(NOGMP):
                    if y.iKind==NormalInteger: 
                        x = newInteger(x.bi mod y.i)
                    else: 
                        x = newInteger(x.bi mod y.bi)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x = newFloating(x.f mod y.f)
                elif y.kind==Rational: x = newRational(toRational(x.f) mod y.rat)
                else: 
                    if y.iKind==NormalInteger:
                        x = newFloating(x.f mod (float)(y.i))
            elif x.kind==Rational:
                if y.kind==Floating: x = newRational(x.rat mod toRational(y.f))
                elif y.kind==Rational: x = newRational(x.rat mod y.rat)
                else: x = newRational(x.rat mod toRational(y.i))
            else:
                if y.kind==Rational:
                    x = newRational(toRational(x.i) mod y.rat)
                else:
                    if x.iKind==NormalInteger:
                        x = newFloating((float)(x.i) mod y.f)

proc `/%`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer,Floating,Rational]) or not (y.kind in [Integer,Floating,Rational]):
        return newBlock(@[x/y, x%y])
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
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
                    if y.iKind==BigInteger:
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
                    if y.iKind==NormalInteger:
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
                    if x.iKind==NormalInteger:
                        return newBlock(@[x/y, x%y])
                    else:
                        discard

proc `/%=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer,Floating,Rational]) or not (y.kind in [Integer,Floating,Rational]):
        x = newBlock(@[x/y, x%y])
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
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
                    if y.iKind==BigInteger:
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
                    if y.iKind==NormalInteger:
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
                    if x.iKind==NormalInteger:
                        x = newBlock(@[x/y, x%y])
                    else:
                        discard

proc `^`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        if x.kind == Quantity:
            if y.kind==Integer and (y.i > 0 and y.i < 4):
                if y.i == 1: return x
                elif y.i == 2: return x * x
                elif y.i == 3: return x * x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", $(x), $(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            elif y.kind==Floating and (y.f > 0 and y.f < 4):
                if y.f == 1.0: return x
                elif y.f == 2.0: return x * x
                elif y.f == 3.0: return x * x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", $(x), $(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            else:
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("pow", $(x), $(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
        else: 
            return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        if y.i >= 0:
                            return newInteger(x.i^y.i)
                        else:
                            return newFloating(pow(asFloat(x),asFloat(y)))
                    except OverflowDefect:
                        when defined(WEB):
                            return newInteger(big(x.i) ** big(y.i))
                        elif not defined(NOGMP):
                            return newInteger(pow(x.i,(culong)(y.i)))
                        else:
                            RuntimeError_IntegerOperationOverflow("pow", $(x), $(y))
                else:
                    when defined(WEB):
                        return newInteger(big(x.i) ** y.bi)
                    elif not defined(NOGMP):
                        RuntimeError_NumberOutOfPermittedRange("pow",$(x), $(y))
            else:
                when defined(WEB):
                    if y.iKind==NormalInteger: 
                        return newInteger(x.bi ** big(y.i))
                    else: 
                        return newInteger(x.bi ** y.bi)
                elif not defined(NOGMP):
                    if y.iKind==NormalInteger:
                        return newInteger(pow(x.bi,(culong)(y.i)))
                    else:
                        RuntimeError_NumberOutOfPermittedRange("pow",$(x), $(y))
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(pow(x.f,y.f))
                elif y.kind==Complex: return VNULL
                else: 
                    if y.iKind==NormalInteger:
                        return newFloating(pow(x.f,(float)(y.i)))
                    else:
                        when not defined(NOGMP):
                            return newFloating(pow(x.f,y.bi))
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(pow(x.z,(float)(y.i)))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(pow(x.z,y.f))
                else: return newComplex(pow(x.z,y.z))
            else:
                if y.kind==Floating: 
                    if x.iKind==NormalInteger:
                        return newFloating(pow((float)(x.i),y.f))
                    else:
                        when not defined(NOGMP):
                            return newFloating(pow(x.bi,y.f))
                else: return VNULL

proc `^=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        if x.kind == Quantity:
            if y.kind==Integer and (y.i > 0 and y.i < 4):
                if y.i == 1: discard
                elif y.i == 2: x *= x
                elif y.i == 3: x *= x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", $(x), $(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            elif y.kind==Floating and (y.f > 0 and y.f < 4):
                if y.f == 1.0: discard
                elif y.f == 2.0: x *= x
                elif y.f == 3.0: x *= x * x
                else:
                    when not defined(WEB):
                        RuntimeError_IncompatibleQuantityOperation("pow", $(x), $(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
            else:
                when not defined(WEB):
                    RuntimeError_IncompatibleQuantityOperation("pow", $(x), $(y), stringify(x.unit.kind), ":" & toLowerAscii($(y.kind)))
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
                    if x.iKind==NormalInteger:
                        x = newFloating(pow(x.f,(float)(y.i)))
                    else:
                        when not defined(NOGMP):
                            x = newFloating(pow(x.f,y.bi))
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x = newComplex(pow(x.z,(float)(y.i)))
                    else: discard
                elif y.kind==Floating: x = newComplex(pow(x.z,y.f))
                else: x = newComplex(pow(x.z,y.z))
            else:
                if y.kind==Floating:
                    if x.iKind==NormalInteger:
                        x = newFloating(pow((float)(x.i),y.f))
                    else:
                        when not defined(NOGMP):
                            x = newFloating(pow(x.bi,y.f))
                else: discard

proc `&&`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                return newInteger(x.i and y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) and y.bi)
                elif not defined(NOGMP):
                    return newInteger(x.i and y.bi)
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    return newInteger(x.bi and y.bi)
                else:
                    return newInteger(x.bi and big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    return newInteger(x.bi and y.bi)
                else:
                    return newInteger(x.bi and y.i)

proc `&&=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                x = newInteger(x.i and y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) and y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i and y.bi)
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    x = newInteger(x.bi and y.bi)
                else:
                    x = newInteger(x.bi and big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    x = newInteger(x.bi and y.bi)
                else:
                    x = newInteger(x.bi and y.i)

proc `||`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                return newInteger(x.i or y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) or y.bi)
                elif not defined(NOGMP):
                    return newInteger(x.i or y.bi)
                
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    return newInteger(x.bi or y.bi)
                else:
                    return newInteger(x.bi or big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    return newInteger(x.bi or y.bi)
                else:
                    return newInteger(x.bi or y.i)

proc `||=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                x = newInteger(x.i or y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) or y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i or y.bi)
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    x = newInteger(x.bi or y.bi)
                else:
                    x = newInteger(x.bi or big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    x = newInteger(x.bi or y.bi)
                else:
                    x = newInteger(x.bi or y.i)

proc `^^`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                return newInteger(x.i xor y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) xor y.bi)
                elif not defined(NOGMP):
                    return newInteger(x.i xor y.bi)
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    return newInteger(x.bi xor y.bi)
                else:
                    return newInteger(x.bi xor big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    return newInteger(x.bi xor y.bi)
                else:
                    return newInteger(x.bi xor y.i)

proc `^^=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                x = newInteger(x.i xor y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) xor y.bi)
                elif not defined(NOGMP):
                    x = newInteger(x.i xor y.bi)
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    x = newInteger(x.bi xor y.bi)
                else:
                    x = newInteger(x.bi xor big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    x = newInteger(x.bi xor y.bi)
                else:
                    x = newInteger(x.bi xor y.i)

proc `>>`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                return newInteger(x.i shr y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) shr y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shr",$(x), $(y))
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    return newInteger(x.bi shr y.bi)
                else:
                    return newInteger(x.bi shr big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    RuntimeError_NumberOutOfPermittedRange("shr",$(x), $(y))
                else:
                    return newInteger(x.bi shr (culong)(y.i))

proc `>>=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                x = newInteger(x.i shr y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) shr y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shr",$(x), $(y))
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    x = newInteger(x.bi shr y.bi)
                else:
                    x = newInteger(x.bi shr big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    RuntimeError_NumberOutOfPermittedRange("shr",$(x), $(y))
                else:
                    x = newInteger(x.bi shr (culong)(y.i))

proc `<<`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                return newInteger(x.i shl y.i)
            else:
                when defined(WEB):
                    return newInteger(big(x.i) shl y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shl",$(x), $(y))
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    return newInteger(x.bi shl y.bi)
                else:
                    return newInteger(x.bi shl big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    RuntimeError_NumberOutOfPermittedRange("shl",$(x), $(y))
                else:
                    return newInteger(x.bi shl (culong)(y.i))

proc `<<=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                x = newInteger(x.i shl y.i)
            else:
                when defined(WEB):
                    x = newInteger(big(x.i) shl y.bi)
                elif not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shl",$(x), $(y))
        else:
            when defined(WEB):
                if y.iKind==BigInteger:
                    x = newInteger(x.bi shl y.bi)
                else:
                    x = newInteger(x.bi shl big(y.i))
            elif not defined(NOGMP):
                if y.iKind==BigInteger:
                    RuntimeError_NumberOutOfPermittedRange("shl",$(x), $(y))
                else:
                    x = newInteger(x.bi shl (culong)(y.i))

proc `!!`*(x: Value): Value =
    if not (x.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            return newInteger(not x.i)
        else:
            when not defined(NOGMP):
                return newInteger(not x.bi)

proc `!!=`*(x: var Value) =
    if not (x.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
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
    if not (x.kind == Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
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
                    RuntimeError_NumberOutOfPermittedRange("factorial",$(x), "")
                else:
                    return newInteger(newInt().fac(x.i))
        else:
            when not defined(WEB):
                RuntimeError_NumberOutOfPermittedRange("factorial",$(x), "")

func `$`*(b: logical): string =
    if b==True: return "true"
    elif b==False: return "false"
    else: return "maybe"

func `$`(s: SymbolKind): string =
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

func `$`(v: Value): string {.inline.} =
    case v.kind:
        of Null         : return "null"
        of Logical      : return $(v.b)
        of Integer      : 
            if v.iKind==NormalInteger: return $(v.i)
            else:
                when defined(WEB) or not defined(NOGMP): 
                    return $(v.bi)
        of Version      : return fmt("{v.major}.{v.minor}.{v.patch}{v.extra}")
        of Floating     : 
            #if v.fKind==NormalFloating: 
            if v.f==Inf: return "∞"
            elif v.f==NegInf: return "-∞"
            else: return $(v.f)
            # else:
            #     when defined(WEB) or not defined(NOGMP): 
            #         return $(v.bf)
        of Complex      : return $(v.z.re) & (if v.z.im >= 0: "+" else: "") & $(v.z.im) & "i"
        of Rational     : return $(v.rat)
        of Type         : 
            if v.tpKind==BuiltinType:
                return ":" & ($v.t).toLowerAscii()
            else:
                return ":" & v.name
        of Char         : return $(v.c)
        of String,
           Word, 
           Literal,
           Label        : return v.s
        of Attribute,
           AttributeLabel    : return v.r
        of Path,
           PathLabel    :
            result = v.p.map((x) => $(x)).join("\\")

        of Color        :
            return $(v.l)
        of Symbol,
           SymbolLiteral:
            return $(v.m)
        of Quantity:
            return $(v.nm) & stringify(v.unit.name)
        of Regex:
            return $(v.rx)
        of Date     : return $(v.eobj)
        of Binary   : return v.n.map((child) => fmt"{child:X}").join(" ")
        of Inline,
           Block     :
            # result = "["
            # for i,child in v.a:
            #     result &= $(child) & " "
            # result &= "]"

            result = "[" & cleanBlock(v.a).map((child) => $(child)).join(" ") & "]"

        of Dictionary   :
            var items: seq[string] = @[]
            for key,value in v.d:
                items.add(key  & ":" & $(value))

            result = "[" & items.join(" ") & "]"

        of Object       :
            var items: seq[string] = @[]
            for key,value in v.o:
                items.add(key  & ":" & $(value))

            result = "[" & items.join(" ") & "]"

        of Function     : 
            result = ""
            if v.fnKind==UserFunction:
                result &= "<function>" & $(v.params)
                result &= "(" & fmt("{cast[ByteAddress](v.main):#X}") & ")"
            else:
                result &= "<function:builtin>" 

        of Database:
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: result = fmt("<database>({cast[ByteAddress](v.sqlitedb):#X})")
                #elif v.dbKind==MysqlDatabase: result = fmt("[mysql db] {cast[ByteAddress](v.mysqldb):#X}")

        of Bytecode:
            result = "<bytecode>"
        
        of Newline: discard
        of Nothing: discard
        of ANY: discard

proc dump*(v: Value, level: int=0, isLast: bool=false, muted: bool=false) {.exportc.} = 
    proc dumpPrimitive(str: string, v: Value) =
        if not muted:   stdout.write fmt("{bold(greenColor)}{str}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("{str} :{($(v.kind)).toLowerAscii()}")

    proc dumpIdentifier(v: Value) =
        if not muted:   stdout.write fmt("{resetColor}{v.s}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("{v.s} :{($(v.kind)).toLowerAscii()}")

    proc dumpAttribute(v: Value) =
        if not muted:   stdout.write fmt("{resetColor}{v.r}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("{v.r} :{($(v.kind)).toLowerAscii()}")

    proc dumpSymbol(v: Value) =
        if not muted:   stdout.write fmt("{resetColor}{v.m}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("{v.m} :{($(v.kind)).toLowerAscii()}")

    proc dumpBinary(b: Byte) =
        if not muted:   stdout.write fmt("{resetColor}{fg(grayColor)}{b:X} {resetColor}")
        else:           stdout.write fmt("{b:X} ")

    proc dumpBlockStart(v: Value) =
        var tp = ($(v.kind)).toLowerAscii()
        if v.kind==Object: tp = v.cust.name
        if not muted:   stdout.write fmt("{bold(magentaColor)}[{fg(grayColor)} :{tp}{resetColor}\n")
        else:           stdout.write fmt("[ :{tp}\n")

    proc dumpBlockEnd() =
        for i in 0..level-1: stdout.write "\t"
        if not muted:   stdout.write fmt("{bold(magentaColor)}]{resetColor}")
        else:           stdout.write fmt("]")

    for i in 0..level-1: stdout.write "\t"

    case v.kind:
        of Null         : dumpPrimitive("null",v)
        of Logical      : dumpPrimitive($(v.b), v)
        of Integer      : 
            if v.iKind==NormalInteger: dumpPrimitive($(v.i), v)
            else: 
                when defined(WEB) or not defined(NOGMP):
                    dumpPrimitive($(v.bi), v)
        of Floating     :
            #if v.fKind==NormalFloating:
            if v.f==Inf: dumpPrimitive("∞", v)
            elif v.f==NegInf: dumpPrimitive("-∞", v)
            else: dumpPrimitive($(v.f), v)
            # else:
            #     when not defined(WEB) and not defined(NOGMP): 
            #         dumpPrimitive($(v.bf), v)
        of Complex      : dumpPrimitive($(v.z.re) & (if v.z.im >= 0: "+" else: "") & $(v.z.im) & "i", v)
        of Rational     : dumpPrimitive($(v.rat), v)
        of Version      : dumpPrimitive(fmt("{v.major}.{v.minor}.{v.patch}{v.extra}"), v)
        of Type         : 
            if v.tpKind==BuiltinType:
                dumpPrimitive(($(v.t)).toLowerAscii(), v)
            else:
                dumpPrimitive(v.name, v)
        of Char         : dumpPrimitive($(v.c), v)
        of String       : dumpPrimitive(v.s, v)
        
        of Word,
           Literal,
           Label        : dumpIdentifier(v)

        of Attribute,
           AttributeLabel    : dumpAttribute(v)

        of Path,
           PathLabel    :
            dumpBlockStart(v)

            for i,child in v.p:
                dump(child, level+1, i==(v.a.len-1), muted=muted)

            stdout.write "\n"

            dumpBlockEnd()

        of Symbol, 
           SymbolLiteral: dumpSymbol(v)

        of Quantity     : dumpPrimitive($(v.nm) & ":" & stringify(v.unit.name), v)

        of Regex        : dumpPrimitive($(v.rx), v)

        of Color        : dumpPrimitive($(v.l), v)

        of Date         : 
            dumpBlockStart(v)

            let keys = toSeq(v.e.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.e:
                    for i in 0..level: stdout.write "\t"

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()

        of Binary       : 
            dumpBlockStart(v)

            for i in 0..level: stdout.write "\t"
            for i,child in v.n:
                dumpBinary(child)
                if (i+1) mod 20 == 0:
                    stdout.write "\n"
                    for i in 0..level: stdout.write "\t"
            
            stdout.write "\n"

            dumpBlockEnd()

        of Inline,
            Block        :
            dumpBlockStart(v)
            let blk = cleanBlock(v.a)
            for i,child in blk:
                dump(child, level+1, i==(blk.len-1), muted=muted)

            stdout.write "\n"

            dumpBlockEnd()

        of Dictionary   : 
            dumpBlockStart(v)

            let keys = toSeq(v.d.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.d:
                    for i in 0..level: stdout.write "\t"

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()
        
        of Object   : 
            dumpBlockStart(v)

            let keys = toSeq(v.o.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.o:
                    for i in 0..level: stdout.write "\t"

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()

        of Function     : 
            dumpBlockStart(v)

            if v.fnKind==UserFunction:
                dump(v.params, level+1, false, muted=muted)
                dump(v.main, level+1, true, muted=muted)
            else:
                for i in 0..level: stdout.write "\t"
                stdout.write "(builtin)"

            stdout.write "\n"

            dumpBlockEnd()

        of Database     :
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: stdout.write fmt("[sqlite db] {cast[ByteAddress](v.sqlitedb):#X}")
                #elif v.dbKind==MysqlDatabase: stdout.write fmt("[mysql db] {cast[ByteAddress](v.mysqldb):#X}")
        
        of Bytecode     : stdout.write("<bytecode>")

        of Newline      : discard
        of Nothing      : discard
        of ANY          : discard

    if not isLast:
        stdout.write "\n"

# TODO Fix pretty-printing for unwrapped blocks
#  Indentation is not working right for inner dictionaries and blocks
#  Check: `print as.pretty.code.unwrapped info.get 'get`
#  labels: values,enhancement,library
func codify*(v: Value, pretty = false, unwrapped = false, level: int=0, isLast: bool=false, isKeyVal: bool=false, safeStrings: bool = false): string {.inline.} =
    result = ""

    if pretty:
        if isKeyVal:
            result &= " "
        else:
            for i in 0..level-1: result &= "\t"

    case v.kind:
        of Null         : result &= "null"
        of Logical      : result &= $(v.b)
        of Integer      :
            if v.iKind==NormalInteger: result &= $(v.i)
            else: 
                when defined(WEB) or not defined(NOGMP):
                    result &= $(v.bi)
        of Floating     : result &= $(v.f)
        of Complex      : result &= fmt("to :complex [{v.z.re} {v.z.im}]")
        of Rational     : result &= fmt("to :rational [{v.rat.num} {v.rat.den}]")
        of Version      : result &= fmt("{v.major}.{v.minor}.{v.patch}{v.extra}")
        of Type         : 
            if v.tpKind==BuiltinType:
                result &= ":" & ($v.t).toLowerAscii()
            else:
                result &= ":" & v.name
        of Char         : result &= "`" & $(v.c) & "`"
        of String       : 
            if safeStrings:
                result &= "««" & v.s & "»»"
            else:
                if countLines(v.s)>1 or v.s.contains("\""):
                    var splitl = join(toSeq(splitLines(v.s)),"\n" & repeat("\t",level+1))
                    result &= "{\n" & repeat("\t",level+1) & splitl & "\n" & repeat("\t",level) & "}"
                else:
                    result &= escape(v.s)
        of Word         : result &= v.s
        of Literal      : result &= "'" & v.s
        of Label        : result &= v.s & ":"
        of Attribute         : result &= "." & v.r
        of AttributeLabel    : result &= "." & v.r & ":"
        of Symbol       :  result &= $(v.m)
        of SymbolLiteral: result &= "'" & $(v.m)
        of Quantity     : result &= $(v.nm) & ":" & toLowerAscii($(v.unit.name))
        of Regex        : result &= "{/" & $(v.rx) & "/}"
        of Color        : result &= $(v.l)

        of Inline, Block:
            if not (pretty and unwrapped and level==0):
                if v.kind==Inline: result &= "("
                else: result &= "["

            if pretty:
                result &= "\n"
            
            var parts: seq[string] = @[]
            let blk = cleanBlock(v.a)
            for i,child in blk:
                parts.add(codify(child,pretty,unwrapped,level+1, i==(blk.len-1), safeStrings=safeStrings))

            result &= parts.join(" ")

            if pretty:
                result &= "\n"
                for i in 0..level-1: result &= "\t"

            if not (pretty and unwrapped and level==0):
                if v.kind==Inline: result &= ")"
                else: result &= "]"

        of Dictionary:
            if not (pretty and unwrapped and level==0):
                result &= "#["

            if pretty:
                result &= "\n"

            let keys = toSeq(v.d.keys)

            if keys.len > 0:

                for k,v in pairs(v.d):
                    if pretty:
                        if not (unwrapped):
                            for i in 0..level: result &= "\t"
                        else:
                            for i in 0..level-1: result &= "\t"
                        result &= k & ":"
                    else:
                        result &= k & ": "

                    result &= codify(v,pretty,unwrapped,level+1, false, isKeyVal=true, safeStrings=safeStrings) 

                    if not pretty:
                        result &= " "

            if pretty:
                for i in 0..level-1: result &= "\t"
            
            if not (pretty and unwrapped and level==0):
                result &= "]"

        of Function:
            result &= "function "
            result &= codify(v.params,pretty,unwrapped,level+1, false, safeStrings=safeStrings)
            result &= " "
            result &= codify(v.main,pretty,unwrapped,level+1, true, safeStrings=safeStrings)

        else:
            result &= ""
    
    if pretty:
        if not isLast:
            result &= "\n"

func sameValue*(x: Value, y: Value): bool {.inline.}=
    if x.kind in [Integer, Floating] and y.kind in [Integer, Floating]:
        if x.kind==Integer:
            if y.kind==Integer: 
                if x.iKind==NormalInteger and y.iKind==NormalInteger:
                    return x.i==y.i
                elif x.iKind==NormalInteger and y.iKind==BigInteger:
                    when defined(WEB):
                        return big(x.i)==y.bi
                    elif not defined(NOGMP):
                        return x.i==y.bi
                elif x.iKind==BigInteger and y.iKind==NormalInteger:
                    when defined(WEB):
                        return x.bi==big(y.i)
                    elif not defined(NOGMP):
                        return x.bi==y.i
                else:
                    when defined(WEB) or not defined(NOGMP):
                        return x.bi==y.bi
            else: 
                if x.iKind==NormalInteger:
                    return (float)(x.i)==y.f
                else:
                    when defined(WEB):
                        return x.bi==big((int)(y.f))
                    elif not defined(NOGMP):
                        return (x.bi)==(int)(y.f)
        else:
            if y.kind==Integer: 
                if y.iKind==NormalInteger:
                    return x.f==(float)(y.i)
                elif y.iKind==BigInteger:
                    when defined(WEB):
                        return big((int)(x.f))==y.bi
                    elif not defined(NOGMP):
                        return (int)(x.f)==y.bi        
            else: return x.f==y.f
    else:
        if x.kind != y.kind: return false

        case x.kind:
            of Null: return true
            of Logical: return x.b == y.b
            of Complex: return x.z == y.z
            of Rational: return x.rat == y.rat
            of Version:
                return x.major == y.major and x.minor == y.minor and x.patch == y.patch and x.extra == y.extra
            of Type: 
                if x.tpKind != y.tpKind: return false
                if x.tpKind==BuiltinType:
                    return x.t == y.t
                else:
                    return x.name == y.name
            of Char: return x.c == y.c
            of String,
               Word,
               Label,
               Literal: return x.s == y.s
            of Attribute,
               AttributeLabel: return x.r == y.r
            of Symbol,
               SymbolLiteral: return x.m == y.m
            of Quantity: return x.nm == y.nm and x.unit == y.unit
            of Regex: return x.rx == y.rx
            of Color: return x.l == y.l
            of Inline,
               Block:
                let cleanX = cleanBlock(x.a)
                let cleanY = cleanBlock(y.a)
                if cleanX.len != cleanY.len: return false

                for i,child in cleanX:
                    if not (sameValue(child,cleanY[i])): return false

                return true
            of Dictionary:
                if x.d.len != y.d.len: return false

                for k,v in pairs(x.d):
                    if not y.d.hasKey(k): return false
                    if not (sameValue(v,y.d[k])): return false

                return true
            of Object:
                if x.o.len != y.o.len: return false

                for k,v in pairs(x.o):
                    if not y.o.hasKey(k): return false
                    if not (sameValue(v,y.o[k])): return false

                if x.cust != y.cust: return false

                return true
            of Function:
                if x.fnKind==UserFunction:
                    return sameValue(x.params, y.params) and sameValue(x.main, y.main) and x.exports == y.exports
                else:
                    return x.fname == y.fname
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
    case v.kind:
        of Null         : result = 0
        of Logical      : result = cast[Hash](v.b)
        of Integer      : 
            if v.iKind==NormalInteger: result = cast[Hash](v.i)
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
           Label        : result = hash(v.s)

        of Attribute,
           AttributeLabel    : result = hash(v.r)

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
                result = result !& hash(v.imports)
                result = result !& hash(v.exports)
                result = result !& hash(v.exportable)
                result = result !& hash(v.memoize)
                result = !$ result
                #echo "result is:" & $(result)
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
