######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/value.nim
######################################################

#=======================================
# Libraries
#=======================================

import colors, complex, hashes, lenientops
import math, sequtils, strformat, strutils
import sugar, tables, times, unicode

when not defined(NOSQLITE):
    import db_sqlite as sqlite
    #import db_mysql as mysql

when not defined(NOGMP):
    import extras/bignum

import helpers/colors as ColorsHelper

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
        thickarrowleft      # <=
        thickarrowright     # =>
        thickarrowboth      # <=>
        arrowleft           # <-
        arrowright          # ->
        arrowboth           # <->
        doublearrowleft     # <<
        doublearrowright    # >>
        triplearrowleft     # <<<
        triplearrowright    # >>>
        longarrowleft       # <--
        longarrowright      # -->
        longarrowboth       # <-->
        longthickarrowleft  # <==
        longthickarrowright # ==>
        longthickarrowboth  # <==>
        tilderight          # ~>
        tildeleft           # <~
        tildeboth           # <~>

        equalless           # =<
        greaterequal        # >=
        lessgreater         # <>

        lesscolon           # <:
        minuscolon          # -:
        greatercolon        # >:
        
        tilde               # ~
        exclamation         # !
        question            # ?
        doublequestion      # ??
        at                  # @
        sharp               # #
        dollar              # $
        percent             # %
        caret               # ^
        ampersand           # &
        asterisk            # *
        minus               # -
        doubleminus         # --
        underscore          # _
        equal               # =
        doubleequal         # ==
        plus                # +
        doubleplus          # ++

        lessthan            # <
        greaterthan         # >
       
        slash               # /
        doubleslash         # //
        backslash           #
        doublebackslash     #
        pipe                # |     

        ellipsis            # ..
        longellipsis        # ...
        dotslash            # ./
        colon               # :
        doublecolon         # ::
        doublepipe          # ||

        slashedzero         # ø
        infinite            # ∞

        unaliased           # used only for builtins

    ValueKind* = enum
        Null            = 0
        Logical         = 1
        Integer         = 2
        Floating        = 3
        Complex         = 4
        Version         = 5
        Type            = 6
        Char            = 7
        String          = 8
        Word            = 9
        Literal         = 10
        Label           = 11
        Attribute       = 12
        AttributeLabel  = 13
        Path            = 14
        PathLabel       = 15
        Symbol          = 16
        Color           = 17
        Date            = 18
        Binary          = 19
        Dictionary      = 20
        Function        = 21
        Inline          = 22
        Block           = 23
        Database        = 24
        Bytecode        = 25

        Newline         = 26
        Nothing         = 27
        Any             = 28

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

    SymbolDict*   = OrderedTable[SymbolKind,AliasBinding]

    logical* = enum
        False = 0, 
        True = 1,
        Maybe = 2

    Value* {.acyclic.} = ref object 
        info*: string
        custom*: Value
        case kind*: ValueKind:
            of Null,
               Nothing,
               Any:        discard 
            of Logical:     b*  : logical
            of Integer:  
                case iKind*: IntegerKind:
                    of NormalInteger:   i*  : int
                    of BigInteger:      
                        when not defined(NOGMP):
                            bi* : Int    
                        else:
                            discard
            of Floating:    f*  : float
            of Complex:     z*  : Complex64
            of Version: 
                major*   : int
                minor*   : int
                patch*   : int
                extra*   : string
            of Type:        
                t*  : ValueKind
                case tpKind*: TypeKind:
                    of UserType:
                        name*       : string
                        prototype*  : Value
                        methods*    : Value
                        inherits*   : Value
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
            of Symbol:      m*  : SymbolKind
            of Color:       l*  : Color
            of Date:        
                e*     : ValueDict         
                eobj*  : DateTime
            of Binary:      n*  : ByteArray
            of Inline,
               Block:       
                   a*   : ValueArray
                   script* : string
                   #refs*: IntArray
            of Dictionary:  d*  : ValueDict
            of Function:    
                args*   : OrderedTable[string,ValueSpec]
                attrs*  : OrderedTable[string,(ValueSpec,string)]
                returns*: ValueSpec
                example*: string
                case fnKind*: FunctionKind:
                    of UserFunction:
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

proc newDictionary*(d: ValueDict = initOrderedTable[string,Value]()): Value {.inline.}
proc `$`(v: Value): string {.inline.}
proc hash*(v: Value): Hash {.inline.}

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

proc newNull*(): Value {.inline.} =
    VNULL

proc newNothing*(): Value {.inline.} =
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

when not defined(NOGMP):
    proc newInteger*(bi: Int): Value {.inline.} =
        result = Value(kind: Integer, iKind: BigInteger, bi: bi)

proc newInteger*(i: int): Value {.inline.} =
    result = Value(kind: Integer, iKind: NormalInteger, i: i)

proc newInteger*(i: int64): Value {.inline.} =
    newInteger((int)(i))

proc newInteger*(i: string, lineno: int = 1): Value {.inline.} =
    try:
        return newInteger(parseInt(i))
    except ValueError:
        when not defined(NOGMP):
            return newInteger(newInt(i))
        else:
            RuntimeError_IntegerParsingOverflow(lineno, i)

proc newBigInteger*(i: int): Value {.inline.} =
    when not defined(NOGMP):
        result = Value(kind: Integer, iKind: BigInteger, bi: newInt(i))

proc newFloating*(f: float): Value {.inline.} =
    Value(kind: Floating, f: f)

proc newFloating*(f: int): Value {.inline.} =
    Value(kind: Floating, f: (float)(f))

proc newFloating*(f: string): Value {.inline.} =
    newFloating(parseFloat(f))

proc newComplex*(com: Complex64): Value {.inline} =
    Value(kind: Complex, z: com)

proc newComplex*(fre: float, fim: float): Value {.inline.} =
    Value(kind: Complex, z: Complex64(re: fre, im: fim))

proc newComplex*(fre: Value, fim: Value): Value {.inline} =
    var r: float
    var i: float

    if fre.kind==Integer: r = (float)(fre.i)
    else: r = fre.f

    if fim.kind==Integer: i = (float)(fim.i)
    else: i = fim.f

    newComplex(r,i)

proc newVersion*(v: string): Value {.inline.} =
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

proc newType*(t: ValueKind): Value {.inline.} =
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

proc newChar*(c: Rune): Value {.inline.} =
    Value(kind: Char, c: c)

proc newChar*(c: char): Value {.inline.} =
    Value(kind: Char, c: ($c).runeAt(0))

proc newChar*(c: string): Value {.inline.} =
    Value(kind: Char, c: c.runeAt(0))

proc newString*(s: string, dedented: bool = false): Value {.inline.} =
    if not dedented: Value(kind: String, s: s)
    else: Value(kind: String, s: unicode.strip(dedent(s)))

proc newString*(s: cstring, dedented: bool = false): Value {.inline.} =
    newString($(s), dedented)

proc newWord*(w: string): Value {.inline.} =
    Value(kind: Word, s: w)

proc newLiteral*(l: string): Value {.inline.} =
    Value(kind: Literal, s: l)

proc newLabel*(l: string): Value {.inline.} =
    Value(kind: Label, s: l)

proc newAttribute*(a: string): Value {.inline.} =
    Value(kind: Attribute, r: a)

proc newAttributeLabel*(a: string): Value {.inline.} =
    Value(kind: AttributeLabel, r: a)

proc newPath*(p: ValueArray): Value {.inline.} =
    Value(kind: Path, p: p)

proc newPathLabel*(p: ValueArray): Value {.inline.} =
    Value(kind: PathLabel, p: p)

proc newSymbol*(m: SymbolKind): Value {.inline.} =
    Value(kind: Symbol, m: m)

proc newSymbol*(m: string): Value {.inline.} =
    newSymbol(parseEnum[SymbolKind](m))

proc newColor*(l: colors.Color): Value {.inline.} =
    Value(kind: Color, l: l)

proc newColor*(rgb: RGB): Value {.inline.} =
    newColor(rgb(rgb.r, rgb.g, rgb.b))

proc newColor*(l: string): Value {.inline.} =
    newColor(parseColor(l))

proc newDate*(dt: DateTime): Value {.inline.} =
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

proc newBinary*(n: ByteArray = @[]): Value {.inline.} =
    Value(kind: Binary, n: n)

proc newDictionary*(d: ValueDict = initOrderedTable[string,Value]()): Value {.inline.} =
    Value(kind: Dictionary, d: d)

proc newFunction*(params: Value, main: Value, imports: Value = VNULL, exports: Value = VNULL, exportable: bool = false, memoize: bool = false): Value {.inline.} =
    Value(kind: Function, fnKind: UserFunction, params: params, main: main, imports: imports, exports: exports, exportable: exportable, memoize: memoize)

proc newBuiltin*(name: string, al: SymbolKind, pr: PrecedenceKind, desc: string, ar: int, ag: OrderedTable[string,ValueSpec], at: OrderedTable[string,(ValueSpec,string)], ret: ValueSpec, exa: string, act: BuiltinAction): Value {.inline.} =
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

proc newBytecode*(c: ValueArray, i: ByteArray): Value {.inline.} =
    Value(kind: Bytecode, consts: c, instrs: i)

proc newInline*(a: ValueArray = @[]): Value {.inline.} = #, refs: seq[int] = @[]): Value {.inline.} = 
    Value(kind: Inline, a: a)#, refs: refs)

proc newBlock*(a: ValueArray = @[], script: string = ""): Value {.inline.} = #, refs: seq[int] = @[]): Value {.inline.} =
    Value(kind: Block, a: a, script: script)#, refs: refs)

proc newIntegerBlock*[T](a: seq[T]): Value {.inline.} =
    newBlock(a.map(proc (x:T):Value = newInteger((int)(x))))

proc newStringBlock*(a: seq[string]): Value {.inline.} =
    newBlock(a.map(proc (x:string):Value = newString($x)))

proc newStringBlock*(a: seq[cstring]): Value {.inline.} =
    newBlock(a.map(proc (x:cstring):Value = newString(x)))

proc newNewline*(l: int): Value {.inline.} =
    #echo "VALUE: adding newline: " & $(l)
    Value(kind: Newline, line: l)

proc copyValue*(v: Value): Value {.inline.} =
    case v.kind:
        of Null:        result = VNULL
        of Logical:     result = newLogical(v.b)
        of Integer:     
            if v.iKind == NormalInteger: result = newInteger(v.i)
            else:
                when not defined(NOGMP): 
                    result = newInteger(v.bi)
        of Floating:    result = newFloating(v.f)
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
        of Block:       result = newBlock(v.a.map((vv)=>copyValue(vv)))

        of Dictionary:  result = newDictionary(v.d)

        of Function:    result = newFunction(v.params, v.main, v.imports, v.exports, v.exportable, v.memoize)

        of Database:    
            when not defined(NOSQLITE):
                if v.dbKind == SqliteDatabase: result = newDatabase(v.sqlitedb)
                #elif v.dbKind == MysqlDatabase: result = newDatabase(v.mysqldb)

        else: discard

proc addChild*(parent: Value, child: Value) {.inline.} =
    parent.a.add(child)

proc asFloat*(v: Value): float = 
    # get number value forcefully as a float
    if v.kind == Floating:
        result = v.f
    else:
        result = (float)(v.i)

proc getArity*(x: Value): int =
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

proc `+`*(x: Value, y: Value): Value =
    if x.kind==Color and y.kind==Color:
        return newColor(x.l + y.l)
    if not (x.kind in [Integer, Floating, Complex]) or not (y.kind in [Integer, Floating, Complex]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        return newInteger(x.i+y.i)
                    except OverflowDefect:
                        when not defined(NOGMP):
                            return newInteger(newInt(x.i)+y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("add", $(x), $(y))
                else:
                    when not defined(NOGMP):
                        return newInteger(x.i+y.bi)
            else:
                when not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi+y.bi)
                    else:
                        return newInteger(x.bi+y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f+y.f)
                elif y.kind==Complex: return newComplex(x.f+y.z)
                else: return newFloating(x.f+y.i)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(x.z+(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z+y.f)
                else: return newComplex(x.z+y.z)
            else:
                if y.kind==Floating: return newFloating(x.i+y.f)
                else: return newComplex((float)(x.i)+y.z)

proc `+=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Complex]) or not (y.kind in [Integer, Floating, Complex]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        x.i += y.i
                    except OverflowDefect:
                        when not defined(NOGMP):
                            x = newInteger(newInt(x.i)+y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("add", $(x), $(y))
                else:
                    when not defined(NOGMP):
                        x = newInteger(x.i+y.bi)
                    
            else:
                when not defined(NOGMP):
                    if y.iKind==BigInteger:
                        x.bi += y.bi
                    else:
                        x.bi += y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f += y.f
                elif y.kind==Complex: x = newComplex(x.f + y.z)
                else: x.f = x.f + y.i
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x = newComplex(x.z + (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z + y.f)
                else: x.z += y.z
            else:
                if y.kind==Floating: x = newFloating(x.i+y.f)
                else: x = newComplex((float)(x.i)+y.z)

proc `-`*(x: Value, y: Value): Value = 
    if x.kind==Color and y.kind==Color:
        return newColor(x.l - y.l)
    if not (x.kind in [Integer, Floating, Complex]) or not (y.kind in [Integer, Floating, Complex]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        return newInteger(x.i-y.i)
                    except OverflowDefect:
                        when not defined(NOGMP):
                            return newInteger(newInt(x.i)-y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("sub", $(x), $(y))
                else:
                    when not defined(NOGMP):
                        return newInteger(x.i-y.bi)
                    
            else:
                when not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi-y.bi)
                    else:
                        return newInteger(x.bi-y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f-y.f)
                elif y.kind==Complex: return newComplex(x.f-y.z)
                else: return newFloating(x.f-y.i)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(x.z-(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z-y.f)
                else: return newComplex(x.z-y.z)
            else:
                if y.kind==Floating: return newFloating(x.i-y.f)
                else: return newComplex((float)(x.i)-y.z)

proc `-=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Complex]) or not (y.kind in [Integer, Floating, Complex]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        x.i -= y.i
                    except OverflowDefect:
                        when not defined(NOGMP):
                            x = newInteger(newInt(x.i)-y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("sub", $(x), $(y))
                else:
                    when not defined(NOGMP):
                        x = newInteger(x.i-y.bi)
            else:
                when not defined(NOGMP):
                    if y.iKind==BigInteger:
                        x.bi -= y.bi
                    else:
                        x.bi -= y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f -= y.f
                elif y.kind==Complex: x = newComplex(x.f - y.z)
                else: x.f = x.f - y.i
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x = newComplex(x.z - (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z - y.f)
                else: x.z -= y.z
            else:
                if y.kind==Floating: x = newFloating(x.i-y.f)
                else: x = newComplex((float)(x.i)-y.z)

proc `*`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating, Complex]) or not (y.kind in [Integer, Floating, Complex]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        return newInteger(x.i*y.i)
                    except OverflowDefect:
                        when not defined(NOGMP):
                            return newInteger(newInt(x.i)*y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("mul", $(x), $(y))
                else:
                    when not defined(NOGMP):
                        return newInteger(x.i*y.bi)
            else:
                when not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi*y.bi)
                    else:
                        return newInteger(x.bi*y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f*y.f)
                elif y.kind==Complex: return newComplex(x.f*y.z)
                else: return newFloating(x.f*y.i)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(x.z*(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z*y.f)
                else: return newComplex(x.z*y.z)
            else:
                if y.kind==Floating: return newFloating(x.i*y.f)
                else: return newComplex((float)(x.i)*y.z)

proc `*=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Complex]) or not (y.kind in [Integer, Floating, Complex]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        x.i *= y.i
                    except OverflowDefect:
                        when not defined(NOGMP):
                            x = newInteger(newInt(x.i)*y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("mul", $(x), $(y))
                else:
                    when not defined(NOGMP):
                        x = newInteger(x.i*y.bi)
            else:
                when not defined(NOGMP):
                    if y.iKind==BigInteger:
                        x.bi *= y.bi
                    else:
                        x.bi *= y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f *= y.f
                elif y.kind==Complex: x = newComplex(x.f * y.z)
                else: x.f = x.f * y.i
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x = newComplex(x.z * (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z * y.f)
                else: x.z *= y.z
            else:
                if y.kind==Floating: x = newFloating(x.i*y.f)
                else: x = newComplex((float)(x.i)*y.z)

proc `/`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating, Complex]) or not (y.kind in [Integer, Floating, Complex]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    return newInteger(x.i div y.i)
                else:
                    when not defined(NOGMP):
                        return newInteger(x.i div y.bi)
            else:
                when not defined(NOGMP):
                    if y.iKind==BigInteger:
                        return newInteger(x.bi div y.bi)
                    else:
                        return newInteger(x.bi div y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f/y.f)
                elif y.kind==Complex: return newComplex(x.f/y.z)
                else: return newFloating(x.f/y.i)
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(x.z/(float)(y.i))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(x.z/y.f)
                else: return newComplex(x.z/y.z)
            else:
                if y.kind==Floating: return newFloating(x.i/y.f)
                else: return newComplex((float)(x.i)/y.z)

proc `/=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating, Complex]) or not (y.kind in [Integer, Floating, Complex]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==NormalInteger:
                    try:
                        x = newInteger(x.i div y.i)
                    except OverflowDefect:
                        when not defined(NOGMP):
                            x = newInteger(newInt(x.i) div y.i)
                        else:
                            RuntimeError_IntegerOperationOverflow("div", $(x), $(y))
                else:
                    when not defined(NOGMP):
                        x = newInteger(x.i div y.bi)
            else:
                when not defined(NOGMP):
                    if y.iKind==BigInteger:
                        x = newInteger(x.bi div y.bi)
                    else:
                        x = newInteger(x.bi div y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f /= y.f
                elif y.kind==Complex: x = newComplex(x.f / y.z)
                else: x.f = x.f / y.i
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x = newComplex(x.z / (float)(y.i))
                    else: discard
                elif y.kind==Floating: x = newComplex(x.z / y.f)
                else: x.z /= y.z
            else:
                if y.kind==Floating: x = newFloating(x.i / y.f)
                else: x = newComplex((float)(x.i)/y.z)

proc `//`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            return newFloating(x.i / y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f / y.f)
                else: return newFloating(x.f/(float)(y.i))
            else:
                return newFloating((float)(x.i)/y.f)

proc `//=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            x = newFloating(x.i / y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f /= y.f
                else: x.f /= (float)(y.i)
            else:
                x = newFloating((float)(x.i)/y.f)

proc `%`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                return newInteger(x.i mod y.i)
            else:
                when not defined(NOGMP):
                    return newInteger(x.i mod y.bi)
        else:
            when not defined(NOGMP):
                if y.iKind==BigInteger:
                    return newInteger(x.bi mod y.bi)
                else:
                    return newInteger(x.bi mod y.i)

proc `%=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger: 
                x.i = x.i mod y.i
            else: 
                when not defined(NOGMP):
                    x = newInteger(x.i mod y.bi)
        else:
            when not defined(NOGMP):
                if y.iKind==NormalInteger: 
                    x = newInteger(x.bi mod y.i)
                else: 
                    x = newInteger(x.bi mod y.bi)

proc `^`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
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
                        when not defined(NOGMP):
                            return newInteger(pow(x.i,(culong)(y.i)))
                        else:
                            RuntimeError_IntegerOperationOverflow("pow", $(x), $(y))
                else:
                    when not defined(NOGMP):
                        RuntimeError_NumberOutOfPermittedRange("pow",$(x), $(y))
            else:
                when not defined(NOGMP):
                    if y.iKind==NormalInteger:
                        return newInteger(pow(x.bi,(culong)(y.i)))
                    else:
                        RuntimeError_NumberOutOfPermittedRange("pow",$(x), $(y))
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(pow(x.f,y.f))
                elif y.kind==Complex: return VNULL
                else: return newFloating(pow(x.f,(float)(y.i)))
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: return newComplex(pow(x.z,(float)(y.i)))
                    else: return VNULL
                elif y.kind==Floating: return newComplex(pow(x.z,y.f))
                else: return newComplex(pow(x.z,y.z))
            else:
                if y.kind==Floating: return newFloating(pow((float)(x.i),y.f))
                else: return VNULL

proc `^=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            let res = pow((float)x.i,(float)y.i)
            x = newInteger((int)res)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x = newFloating(pow(x.f,y.f))
                elif y.kind==Complex: discard
                else: x = newFloating(pow(x.f,(float)(y.i)))
            elif x.kind==Complex:
                if y.kind==Integer:
                    if y.iKind==NormalInteger: x = newComplex(pow(x.z,(float)(y.i)))
                    else: discard
                elif y.kind==Floating: x = newComplex(pow(x.z,y.f))
                else: x = newComplex(pow(x.z,y.z))
            else:
                if y.kind==Floating: x = newFloating(pow((float)(x.i),y.f))
                else: discard

proc `&&`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger:
                return newInteger(x.i and y.i)
            else:
                when not defined(NOGMP):
                    return newInteger(x.i and y.bi)
        else:
            when not defined(NOGMP):
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
                when not defined(NOGMP):
                    x = newInteger(x.i and y.bi)
        else:
            when not defined(NOGMP):
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
                when not defined(NOGMP):
                    return newInteger(x.i or y.bi)
                
        else:
            when not defined(NOGMP):
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
                when not defined(NOGMP):
                    x = newInteger(x.i or y.bi)
        else:
            when not defined(NOGMP):
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
                when not defined(NOGMP):
                    return newInteger(x.i xor y.bi)
        else:
            when not defined(NOGMP):
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
                when not defined(NOGMP):
                    x = newInteger(x.i xor y.bi)
        else:
            when not defined(NOGMP):
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
                when not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shr",$(x), $(y))
        else:
            when not defined(NOGMP):
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
               when not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shr",$(x), $(y))
        else:
            when not defined(NOGMP):
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
                when not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shl",$(x), $(y))
        else:
            when not defined(NOGMP):
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
                when not defined(NOGMP):
                    RuntimeError_NumberOutOfPermittedRange("shl",$(x), $(y))
        else:
            when not defined(NOGMP):
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

proc `$`*(b: logical): string =
    if b==True: return "true"
    elif b==False: return "false"
    else: return "maybe"

proc `$`(s: SymbolKind): string =
    case s:
        of thickarrowleft       : result = "<="
        of thickarrowright      : result = "=>"
        of thickarrowboth       : result = "<=>"
        of arrowleft            : result = "<-"
        of arrowright           : result = "->"
        of arrowboth            : result = "<->"
        of doublearrowleft      : result = "<<"
        of doublearrowright     : result = ">>"
        of triplearrowleft      : result = "<<<"
        of triplearrowright     : result = ">>>"
        of longarrowleft        : result = "<--"
        of longarrowright       : result = "-->"
        of longarrowboth        : result = "<-->"
        of longthickarrowleft   : result = "<=="
        of longthickarrowright  : result = "==>"
        of longthickarrowboth   : result = "<==>"
        of tilderight           : result = "~>"
        of tildeleft            : result = "<~"
        of tildeboth            : result = "<~>"

        of equalless            : result = "=<"
        of greaterequal         : result = ">="
        of lessgreater          : result = "<>"

        of lesscolon            : result = "<:"
        of minuscolon           : result = "-:"
        of greatercolon         : result = ">:"

        of tilde                : result = "~"
        of exclamation          : result = "!"
        of question             : result = "?"
        of doublequestion       : result = "??"
        of at                   : result = "@"
        of sharp                : result = "#"
        of dollar               : result = "$"
        of percent              : result = "%"
        of caret                : result = "^"
        of ampersand            : result = "&"
        of asterisk             : result = "*"
        of minus                : result = "-"
        of doubleminus          : result = "--"
        of underscore           : result = "_"
        of equal                : result = "="
        of doubleequal          : result = "=="
        of plus                 : result = "+"
        of doubleplus           : result = "++"
        of lessthan             : result = "<"
        of greaterthan          : result = ">"
        of slash                : result = "/"
        of doubleslash          : result = "//"
        of backslash            : result = "\\"
        of doublebackslash      : result = "\\\\"
        of pipe                 : result = "|"

        of ellipsis             : result = ".."
        of longellipsis         : result = "..."
        of dotslash             : result = "./"
        of colon                : result = ":"
        of doublecolon          : result = "::"
        of doublepipe           : result = "||"

        of slashedzero          : result = "ø"
        of infinite             : result = "∞"

        of unaliased            : discard

proc `$`(v: Value): string {.inline.} =
    case v.kind:
        of Null         : return "null"
        of Logical      : return $(v.b)
        of Integer      : 
            if v.iKind==NormalInteger: return $(v.i)
            else:
                when not defined(NOGMP): 
                    return $(v.bi)
        of Version      : return fmt("{v.major}.{v.minor}.{v.patch}{v.extra}")
        of Floating     : 
            if v.f==Inf: return "∞"
            elif v.f==NegInf: return "-∞"
            else: return $(v.f)
        of Complex      : return $(v.z.re) & (if v.z.im >= 0: "+" else: "") & $(v.z.im) & "i"
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
        of Symbol       :
            return $(v.m)

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
        if not v.custom.isNil(): tp = v.custom.name
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
                when not defined(NOGMP):
                    dumpPrimitive($(v.bi), v)
        of Floating     : 
            if v.f==Inf: dumpPrimitive("∞", v)
            elif v.f==NegInf: dumpPrimitive("-∞", v)
            else: dumpPrimitive($(v.f), v)
        of Complex      : dumpPrimitive($(v.z.re) & (if v.z.im >= 0: "+" else: "") & $(v.z.im) & "i", v)
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

        of Symbol       : dumpSymbol(v)

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
proc codify*(v: Value, pretty = false, unwrapped = false, level: int=0, isLast: bool=false, isKeyVal: bool=false, safeStrings: bool = false): string {.inline.} =
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
                when not defined(NOGMP):
                    result &= $(v.bi)
        of Floating     : result &= $(v.f)
        of Complex      : result &= fmt("to :complex [{v.z.re} {v.z.im}]")
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

proc sameValue*(x: Value, y: Value): bool {.inline.}=
    if x.kind in [Integer, Floating] and y.kind in [Integer, Floating]:
        if x.kind==Integer:
            if y.kind==Integer: 
                if x.iKind==NormalInteger and y.iKind==NormalInteger:
                    return x.i==y.i
                elif x.iKind==NormalInteger and y.iKind==BigInteger:
                    when not defined(NOGMP):
                        return x.i==y.bi
                elif x.iKind==BigInteger and y.iKind==NormalInteger:
                    when not defined(NOGMP):
                        return x.bi==y.i
                else:
                    when not defined(NOGMP):
                        return x.bi==y.bi
            else: 
                if x.iKind==NormalInteger:
                    return (float)(x.i)==y.f
                else:
                    when not defined(NOGMP):
                        return (x.bi)==(int)(y.f)
        else:
            if y.kind==Integer: 
                if y.iKind==NormalInteger:
                    return x.f==(float)(y.i)
                elif y.iKind==BigInteger:
                    when not defined(NOGMP):
                        return (int)(x.f)==y.bi        
            else: return x.f==y.f
    else:
        if x.kind != y.kind: return false

        case x.kind:
            of Null: return true
            of Logical: return x.b == y.b
            of Complex: return x.z == y.z
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
            of Symbol: return x.m == y.m
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
                # if not x.custom.isNil and x.custom.methods.d.hasKey("print"):
                #     push y
                #     push x
                #     callFunction(x.custom.methods.d["compare"])
                #     return pop().b
                # else:
                if x.d.len != y.d.len: return false

                for k,v in pairs(x.d):
                    if not y.d.hasKey(k): return false
                    if not (sameValue(v,y.d[k])): return false

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
proc hash*(v: Value): Hash {.inline.}=
    case v.kind:
        of Null         : result = 0
        of Logical      : result = cast[Hash](v.b)
        of Integer      : 
            if v.iKind==NormalInteger: result = cast[Hash](v.i)
            else: 
                when not defined(NOGMP):
                    result = cast[Hash](v.bi)
        of Floating     : result = cast[Hash](v.f)
        of Complex      : 
            result = 1
            result = result !& cast[Hash](v.z.re)
            result = result !& cast[Hash](v.z.im)
            result = !$ result
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

        of Symbol       : result = cast[Hash](ord(v.m))
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
