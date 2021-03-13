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

import hashes, math, sequtils, strformat
import strutils, sugar, tables, times, unicode

import db_sqlite as sqlite
#import db_mysql as mysql

import extras/bignum

import helpers/colors as ColorsHelper

#=======================================
# Types
#=======================================

type
    ValueArray* = seq[Value]
    ValueDict*  = OrderedTable[string,Value]

    Byte = byte
    ByteArray*  = seq[Byte]

    IntArray*   = seq[int]

    BuiltinAction = proc ()

    SymbolKind* = enum
        thickarrowleft  # <=
        thickarrowright # =>
        arrowleft       # <-
        arrowright      # ->
        doublearrowleft # <<
        doublearrowright# >>

        equalless       # =<
        greaterequal    # >=
        lessgreater     # <>

        lesscolon       # <:
        minuscolon      # -:
        
        tilde           # ~
        exclamation     # !
        question        # ?
        doublequestion  # ??
        at              # @
        sharp           # #
        dollar          # $
        percent         # %
        caret           # ^
        ampersand       # &
        asterisk        # *
        minus           # -
        doubleminus     # --
        underscore      # _
        equal           # =
        plus            # +
        doubleplus      # ++

        lessthan        # <
        greaterthan     # >
       
        slash           # /
        doubleslash     # //
        backslash       #
        doublebackslash #
        pipe            # |     

        ellipsis        # ..
        dotslash        # ./
        colon           # :
        doublecolon     # ::
        doublepipe      # ||

        slashedzero     # ø

        unaliased       # used only for builtins

    ValueKind* = enum
        Null            = 0
        Boolean         = 1
        Integer         = 2
        Floating        = 3
        Type            = 4
        Char            = 5
        String          = 6
        Word            = 7
        Literal         = 8
        Label           = 9
        Attribute       = 10
        AttributeLabel  = 11
        Path            = 12
        PathLabel       = 13
        Symbol          = 14
        Date            = 15
        Binary          = 16
        Dictionary      = 17
        Function        = 18
        Inline          = 19
        Block           = 20
        Database        = 21
        Bytecode        = 22

        Nothing         = 23
        Any             = 24

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

    Value* {.acyclic.} = ref object 
        info*: string
        custom*: Value
        case kind*: ValueKind:
            of Null,
               Nothing,
               Any:        discard 

            of Boolean:     b*  : bool
            of Integer:  
                case iKind*: IntegerKind:
                    of NormalInteger:   i*  : int
                    of BigInteger:      bi* : Int    
            of Floating:    f*  : float
            of Type:        
                t*  : ValueKind
                case tpKind*: TypeKind:
                    of UserType:
                        name*       : string
                        prototype*  : Value
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
            of Date:        
                e*     : ValueDict         
                eobj*  : DateTime
            of Binary:      n*  : ByteArray
            of Inline,
               Block:       
                   a*   : ValueArray
                   #refs*: IntArray
            of Dictionary:  d*  : ValueDict
            of Function:    
                case fnKind*: FunctionKind:
                    of UserFunction:
                        params* : Value         
                        main*   : Value
                        imports*: Value
                        exports*: Value
                        exportable*: bool
                    of BuiltinFunction:
                        fname*  : string
                        alias*  : SymbolKind
                        prec*   : PrecedenceKind
                        module* : string
                        fdesc*  : string
                        arity*  : int
                        args*   : OrderedTable[string,ValueSpec]
                        attrs*  : OrderedTable[string,(ValueSpec,string)]
                        returns*: ValueSpec
                        example*: string
                        action* : BuiltinAction

            of Database:
                case dbKind*: DatabaseKind:
                    of SqliteDatabase: sqlitedb*: sqlite.DbConn
                    of MysqlDatabase: discard
                    #mysqldb*: mysql.DbConn
            of Bytecode:
                consts*: ValueArray
                instrs*: ByteArray

#=======================================
# Constants
#=======================================

const
    NoValues* = @[]

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

let VTRUE*  = Value(kind: Boolean, b: true)
let VFALSE* = Value(kind: Boolean, b: false)

let VNULL* = Value(kind: Null)

let VNOTHING* = Value(kind: Nothing)

#=======================================
# Variables
#=======================================

var 
    TypeLookup = initOrderedTable[string,Value]()
    DoDebug* = false

#=======================================
# Helpers
#=======================================

## forward declarations
proc newDictionary*(d: ValueDict = initOrderedTable[string,Value]()): Value {.inline.}

proc newNull*(): Value {.inline.} =
    VNULL

proc newNothing*(): Value {.inline.} =
    VNOTHING

proc newBoolean*(b: bool): Value {.inline.} =
    if b: VTRUE
    else: VFALSE

proc newBoolean*(i: int): Value {.inline.} =
    if i==0: newBoolean(false)
    else: newBoolean(true)

proc newInteger*(bi: Int): Value {.inline.} =
    result = Value(kind: Integer, iKind: BigInteger, bi: bi)

proc newInteger*(i: int): Value {.inline.} =
    # if i in 0..10:
    #     case i:
    #         of 0: result = I0
    #         of 1: result = I1
    #         of 2: result = I2
    #         of 3: result = I3
    #         of 4: result = I4
    #         of 5: result = I5
    #         of 6: result = I6
    #         of 7: result = I7
    #         of 8: result = I8
    #         of 9: result = I9
    #         of 10: result = I10
    #         else: discard # shouldn't reach here
    # else:
    result = Value(kind: Integer, iKind: NormalInteger, i: i)

proc newInteger*(i: int64): Value {.inline.} =
    newInteger((int)(i))

proc newInteger*(i: string): Value {.inline.} =
    try:
        newInteger(parseInt(i))
    except ValueError:
        # value out of range
        newInteger(newInt(i))

proc newBigInteger*(i: int): Value {.inline.} =
    result = Value(kind: Integer, iKind: BigInteger, bi: newInt(i))

proc newFloating*(f: float): Value {.inline.} =
    Value(kind: Floating, f: f)

proc newFloating*(f: int): Value {.inline.} =
    Value(kind: Floating, f: (float)(f))

proc newFloating*(f: string): Value {.inline.} =
    newFloating(parseFloat(f))

proc newType*(t: ValueKind): Value {.inline.} =
    Value(kind: Type, tpKind: BuiltinType, t: t)

proc newUserType*(n: string, p: Value = VNULL): Value {.inline.} =
    if TypeLookup.hasKey(n):
        return TypeLookup[n]
    else:
        result = Value(kind: Type, tpKind: UserType, t: Dictionary, name: n, prototype: p)
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

proc newFunction*(params: Value, main: Value, imports: Value = VNULL, exports: Value = VNULL, exportable: bool): Value {.inline.} =
    Value(kind: Function, fnKind: UserFunction, params: params, main: main, imports: imports, exports: exports, exportable: exportable)

proc newBuiltin*(name: string, al: SymbolKind, pr: PrecedenceKind, md: string, desc: string, ar: int, ag: OrderedTable[string,ValueSpec], at: OrderedTable[string,(ValueSpec,string)], ret: ValueSpec, exa: string, act: BuiltinAction): Value {.inline.} =
    Value(
        kind    : Function, 
        fnKind  : BuiltinFunction, 
        fname   : name, 
        alias   : al, 
        prec    : pr,
        module  : md, 
        fdesc   : desc, 
        arity   : ar, 
        args    : ag, 
        attrs   : at, 
        returns : ret, 
        example : exa, 
        action  : act
    )

proc newDatabase*(db: sqlite.DbConn): Value {.inline.} =
    Value(kind: Database, dbKind: SqliteDatabase, sqlitedb: db)

# proc newDatabase*(db: mysql.DbConn): Value {.inline.} =
#     Value(kind: Database, dbKind: MysqlDatabase, mysqldb: db)

proc newBytecode*(c: ValueArray, i: ByteArray): Value {.inline.} =
    Value(kind: Bytecode, consts: c, instrs: i)

proc newInline*(a: ValueArray = @[]): Value {.inline.} = #, refs: seq[int] = @[]): Value {.inline.} = 
    Value(kind: Inline, a: a)#, refs: refs)

proc newBlock*(a: ValueArray = @[]): Value {.inline.} = #, refs: seq[int] = @[]): Value {.inline.} =
    Value(kind: Block, a: a)#, refs: refs)

proc newIntegerBlock*[T](a: seq[T]): Value {.inline.} =
    newBlock(a.map(proc (x:T):Value = newInteger((int)(x))))

proc newStringBlock*(a: seq[string]): Value {.inline.} =
    newBlock(a.map(proc (x:string):Value = newString($x)))

proc copyValue*(v: Value): Value {.inline.} =
    case v.kind:
        of Null:        result = VNULL
        of Boolean:     result = newBoolean(v.b)
        of Integer:     
            if v.iKind == NormalInteger: result = newInteger(v.i)
            else: result = newInteger(v.bi)
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
        of Block:       result = newBlock(v.a)

        of Dictionary:  result = newDictionary(v.d)

        of Function:    result = newFunction(v.params, v.main, v.imports, v.exports, v.exportable)

        of Database:    
            if v.dbKind == SqliteDatabase: result = newDatabase(v.sqlitedb)
            #elif v.dbKind == MysqlDatabase: result = newDatabase(v.mysqldb)

        else: discard

proc indexOfValue*(a: seq[Value], item: Value): int {.inline.}=
    ## Returns the first index of `item` in `a` or -1 if not found. This requires
    ## appropriate `items` and `==` operations to work.
    result = 0
    for i in items(a):
        if item == i: return
        if item.kind in [Word, Label] and i.kind in [Word, Label] and item.s==i.s: return
        inc(result)
    result = -1

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

#=======================================
# Methods
#=======================================

proc `+`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    return newInteger(x.i+y.bi)
                else:
                    try:
                        return newInteger(x.i+y.i)
                    except OverflowDefect:
                        return newInteger(newInt(x.i)+y.i)
            else:
                if y.iKind==BigInteger:
                    return newInteger(x.bi+y.bi)
                else:
                    return newInteger(x.bi+y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f+y.f)
                else: return newFloating(x.f+(float)(y.i))
            else:
                return newFloating((float)(x.i)+y.f)

proc `+=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    x = newInteger(x.i+y.bi)
                else:
                    try:
                        x.i += y.i
                    except OverflowDefect:
                        x = newInteger(newInt(x.i)+y.i)
            else:
                if y.iKind==BigInteger:
                    x.bi += y.bi
                else:
                    x.bi += y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f += y.f
                else: x.f += (float)(y.i)
            else:
                x = newFloating((float)(x.i)+y.f)

proc `-`*(x: Value, y: Value): Value = 
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    return newInteger(x.i-y.bi)
                else:
                    try:
                        return newInteger(x.i-y.i)
                    except OverflowDefect:
                        return newInteger(newInt(x.i)-y.i)
            else:
                if y.iKind==BigInteger:
                    return newInteger(x.bi-y.bi)
                else:
                    return newInteger(x.bi-y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f-y.f)
                else: return newFloating(x.f-(float)(y.i))
            else:
                return newFloating((float)(x.i)-y.f)

proc `-=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    x = newInteger(x.i-y.bi)
                else:
                    try:
                        x.i -= y.i
                    except OverflowDefect:
                        x = newInteger(newInt(x.i)-y.i)
            else:
                if y.iKind==BigInteger:
                    x.bi -= y.bi
                else:
                    x.bi -= y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f -= y.f
                else: x.f -= (float)(y.i)
            else:
                x = newFloating((float)(x.i)-y.f)

proc `*`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    return newInteger(x.i*y.bi)
                else:
                    try:
                        return newInteger(x.i*y.i)
                    except OverflowDefect:
                        return newInteger(newInt(x.i)*y.i)
            else:
                if y.iKind==BigInteger:
                    return newInteger(x.bi*y.bi)
                else:
                    return newInteger(x.bi*y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f*y.f)
                else: return newFloating(x.f*(float)(y.i))
            else:
                return newFloating((float)(x.i)*y.f)

proc `*=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    x = newInteger(x.i*y.bi)
                else:
                    try:
                        x.i *= y.i
                    except OverflowDefect:
                        x = newInteger(newInt(x.i)*y.i)
            else:
                if y.iKind==BigInteger:
                    x.bi *= y.bi
                else:
                    x.bi *= y.i
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f *= y.f
                else: x.f *= (float)(y.i)
            else:
                x = newFloating((float)(x.i)*y.f)

proc `/`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    return newInteger(x.i div y.bi)
                else:
                    return newInteger(x.i div y.i)
            else:
                if y.iKind==BigInteger:
                    return newInteger(x.bi div y.bi)
                else:
                    return newInteger(x.bi div y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(x.f/y.f)
                else: return newFloating(x.f/(float)(y.i))
            else:
                return newFloating((float)(x.i)/y.f)

proc `/=`*(x: var Value, y: Value) =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        x = VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    x = newInteger(x.i div y.bi)
                else:
                    try:
                        x = newInteger(x.i div y.i)
                    except OverflowDefect:
                        x = newInteger(newInt(x.i) div y.i)
            else:
                if y.iKind==BigInteger:
                    x = newInteger(x.bi div y.bi)
                else:
                    x = newInteger(x.bi div y.i)
        else:
            if x.kind==Floating:
                if y.kind==Floating: x.f /= y.f
                else: x.f /= (float)(y.i)
            else:
                x = newFloating((float)(x.i)/y.f)

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
            if y.iKind==BigInteger:
                return newInteger(x.i mod y.bi)
            else:
                return newInteger(x.i mod y.i)
        else:
            if y.iKind==BigInteger:
                return newInteger(x.bi mod y.bi)
            else:
                return newInteger(x.bi mod y.i)

proc `%=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==NormalInteger: x.i = x.i mod y.i
            else: x = newInteger(x.i mod y.bi)
        else:
            if y.iKind==NormalInteger: x = newInteger(x.bi mod y.i)
            else: x = newInteger(x.bi mod y.bi)

proc `^`*(x: Value, y: Value): Value =
    if not (x.kind in [Integer, Floating]) or not (y.kind in [Integer, Floating]):
        return VNULL
    else:
        if x.kind==Integer and y.kind==Integer:
            if x.iKind==NormalInteger:
                if y.iKind==BigInteger:
                    echo "ERROR"
                    return VNULL
                    #stack.push(newInteger(pow(x.iy.bi))
                else:
                    try:
                        return newInteger(x.i^y.i)
                    except OverflowDefect:
                        return newInteger(pow(x.i,(culong)(y.i)))
            else:
                if y.iKind==BigInteger:
                    echo "ERROR"
                    return VNULL
                    #stack.push(newInteger(x.bi div y.bi))
                else:
                    return newInteger(pow(x.bi,(culong)(y.i)))
        else:
            if x.kind==Floating:
                if y.kind==Floating: return newFloating(pow(x.f,y.f))
                else: return newFloating(pow(x.f,(float)(y.i)))
            else:
                return newFloating(pow((float)(x.i),y.f))

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
                else: x = newFloating(pow(x.f,(float)(y.i)))
            else:
                x = newFloating(pow((float)(x.i),y.f))

proc `&&`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                return newInteger(x.i and y.bi)
            else:
                return newInteger(x.i and y.i)
        else:
            if y.iKind==BigInteger:
                return newInteger(x.bi and y.bi)
            else:
                return newInteger(x.bi and y.i)

proc `&&=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                x = newInteger(x.i and y.bi)
            else:
                x = newInteger(x.i and y.i)
        else:
            if y.iKind==BigInteger:
                x = newInteger(x.bi and y.bi)
            else:
                x = newInteger(x.bi and y.i)

proc `||`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                return newInteger(x.i or y.bi)
            else:
                return newInteger(x.i or y.i)
        else:
            if y.iKind==BigInteger:
                return newInteger(x.bi or y.bi)
            else:
                return newInteger(x.bi or y.i)

proc `||=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                x = newInteger(x.i or y.bi)
            else:
                x = newInteger(x.i or y.i)
        else:
            if y.iKind==BigInteger:
                x = newInteger(x.bi or y.bi)
            else:
                x = newInteger(x.bi or y.i)

proc `^^`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                return newInteger(x.i xor y.bi)
            else:
                return newInteger(x.i xor y.i)
        else:
            if y.iKind==BigInteger:
                return newInteger(x.bi xor y.bi)
            else:
                return newInteger(x.bi xor y.i)

proc `^^=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                x = newInteger(x.i xor y.bi)
            else:
                x = newInteger(x.i xor y.i)
        else:
            if y.iKind==BigInteger:
                x = newInteger(x.bi xor y.bi)
            else:
                x = newInteger(x.bi xor y.i)

proc `>>`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                # not valid
                return VNULL
            else:
                return newInteger(x.i shr y.i)
        else:
            if y.iKind==BigInteger:
                # not valid
                return VNULL
            else:
                return newInteger(x.bi shr (culong)(y.i))

proc `>>=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                # not valid
                x = VNULL
            else:
                x = newInteger(x.i shr y.i)
        else:
            if y.iKind==BigInteger:
                # not valid
                x = VNULL
            else:
                x = newInteger(x.bi shr (culong)(y.i))

proc `<<`*(x: Value, y: Value): Value =
    if not (x.kind==Integer) or not (y.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                # not valid
                return VNULL
            else:
                # not valid
                return newInteger(x.i shl y.i)
        else:
            if y.iKind==BigInteger:
                # not valid
                return VNULL
            else:
                return newInteger(x.bi shl (culong)(y.i))

proc `<<=`*(x: var Value, y: Value) =
    if not (x.kind==Integer) or not (y.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            if y.iKind==BigInteger:
                # not valid
                x = VNULL
            else:
                x = newInteger(x.i shl y.i)
        else:
            if y.iKind==BigInteger:
                # not valid
                x = VNULL
            else:
                x = newInteger(x.bi shl (culong)(y.i))

proc `!!`*(x: Value): Value =
    if not (x.kind==Integer):
        return VNULL
    else:
        if x.iKind==NormalInteger:
            return newInteger(not x.i)
        else:
            return newInteger(not x.bi)

proc `!!=`*(x: var Value) =
    if not (x.kind==Integer):
        x = VNULL
    else:
        if x.iKind==NormalInteger:
            x = newInteger(not x.i)
        else:
            x = newInteger(not x.bi)

proc `==`*(x: Value, y: Value): bool =
    if x.kind in [Integer, Floating] and y.kind in [Integer, Floating]:
        if x.kind==Integer:
            if y.kind==Integer: 
                if x.iKind==NormalInteger and y.iKind==NormalInteger:
                    return x.i==y.i
                elif x.iKind==NormalInteger and y.iKind==BigInteger:
                    return x.i==y.bi
                elif x.iKind==BigInteger and y.iKind==NormalInteger:
                    return x.bi==y.i
                else:
                    return x.bi==y.bi
            else: 
                if x.iKind==NormalInteger:
                    return (float)(x.i)==y.f
                else:
                    return (x.bi)==(int)(y.f)
        else:
            if y.kind==Integer: 
                if y.iKind==NormalInteger:
                    return x.f==(float)(y.i)
                elif y.iKind==BigInteger:
                    return (int)(x.f)==y.bi        
            else: return x.f==y.f
    else:
        if x.kind != y.kind: return false

        case x.kind:
            of Null: return true
            of Boolean: return x.b == y.b
            of Type: return x.t == y.t
            of Char: return x.c == y.c
            of String,
               Word,
               Label,
               Literal: return x.s == y.s
            of Attribute,
               AttributeLabel: return x.r == y.r
            of Symbol: return x.m == y.m
            of Inline,
               Block:
                if x.a.len != y.a.len: return false

                for i,child in x.a:
                    if not (child==y.a[i]): return false

                return true
            of Dictionary:
                if x.d.len != y.d.len: return false

                for k,v in pairs(x.d):
                    if not y.d.hasKey(k): return false
                    if not (v==y.d[k]): return false

                return true
            of Function:
                if x.fnKind==UserFunction:
                    return x.params == y.params and x.main == y.main and x.exports == y.exports
                else:
                    return x.fname == y.fname
            of Database:
                if x.dbKind != y.dbKind: return false

                if x.dbKind==SqliteDatabase: return cast[ByteAddress](x.sqlitedb) == cast[ByteAddress](y.sqlitedb)
                #elif x.dbKind==MysqlDatabase: return cast[ByteAddress](x.mysqldb) == cast[ByteAddress](y.mysqldb)
            of Date:
                return x.eobj == y.eobj
            else:
                return false

proc `<`*(x: Value, y: Value): bool =
    if x.kind in [Integer, Floating] and y.kind in [Integer, Floating]:
        if x.kind==Integer:
            if y.kind==Integer: 
                if x.iKind==NormalInteger and y.iKind==NormalInteger:
                    return x.i<y.i
                elif x.iKind==NormalInteger and y.iKind==BigInteger:
                    return x.i<y.bi
                elif x.iKind==BigInteger and y.iKind==NormalInteger:
                    return x.bi<y.i
                else:
                    return x.bi<y.bi
            else: 
                if x.iKind==NormalInteger:
                    return (float)(x.i)<y.f
                else:
                    return (x.bi)<(int)(y.f)
        else:
            if y.kind==Integer: 
                if y.iKind==NormalInteger:
                    return x.f<(float)(y.i)
                elif y.iKind==BigInteger:
                    return (int)(x.f)<y.bi        
            else: return x.f<y.f
    else:
        case x.kind:
            of Null: return false
            of Boolean: return false
            of Type: return false
            of Char: return $(x.c) < $(y.c)
            of String,
               Word,
               Label,
               Literal: return x.s < y.s
            of Symbol: return false
            of Inline,
               Block:
                return x.a.len < y.a.len
            else:
                return false

proc `>`*(x: Value, y: Value): bool =
    if x.kind in [Integer, Floating] and y.kind in [Integer, Floating]:
        if x.kind==Integer:
            if y.kind==Integer: 
                if x.iKind==NormalInteger and y.iKind==NormalInteger:
                    return x.i>y.i
                elif x.iKind==NormalInteger and y.iKind==BigInteger:
                    return x.i>y.bi
                elif x.iKind==BigInteger and y.iKind==NormalInteger:
                    return x.bi>y.i
                else:
                    return x.bi>y.bi
            else: 
                if x.iKind==NormalInteger:
                    return (float)(x.i)>y.f
                else:
                    return (x.bi)>(int)(y.f)
        else:
            if y.kind==Integer: 
                if y.iKind==NormalInteger:
                    return x.f>(float)(y.i)
                elif y.iKind==BigInteger:
                    return (int)(x.f)>y.bi        
            else: return x.f>y.f
    else:
        case x.kind:
            of Null: return false
            of Boolean: return false
            of Type: return false
            of Char: return $(x.c) > $(y.c)
            of String,
               Word,
               Label,
               Literal: return x.s > y.s
            of Symbol: return false
            of Inline,
               Block:
                return x.a.len > y.a.len
            else:
                return false

proc `<=`*(x: Value, y: Value): bool =
    x < y or x == y

proc `>=`*(x: Value, y: Value): bool =
    x > y or x == y

proc `!=`*(x: Value, y: Value): bool =
    not (x == y)

proc cmp*(x: Value, y: Value): int =
    if x < y:
        return -1
    elif x > y:
        return 1
    else:
        return 0

proc `$`*(v: Value): string {.inline.} =
    case v.kind:
        of Null         : return "null"
        of Boolean      : return $(v.b)
        of Integer      : 
            if v.iKind==NormalInteger: return $(v.i)
            else: return $(v.bi)
        of Floating     : return $(v.f)
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
        of Symbol       :
            case v.m:
                of thickarrowleft   : return "<="
                of thickarrowright  : return "=>"
                of arrowleft        : return "<-"
                of arrowright       : return "->"
                of doublearrowleft  : return "<<"
                of doublearrowright : return ">>"

                of equalless        : return "=<"
                of greaterequal     : return ">="
                of lessgreater      : return "<>"

                of lesscolon        : return "<:"
                of minuscolon       : return "-:"

                of tilde            : return "~"
                of exclamation      : return "!"
                of question         : return "?"
                of doublequestion   : return "??"
                of at               : return "@"
                of sharp            : return "#"
                of dollar           : return "$"
                of percent          : return "%"
                of caret            : return "^"
                of ampersand        : return "&"
                of asterisk         : return "*"
                of minus            : return "-"
                of doubleminus      : return "--"
                of underscore       : return "_"
                of equal            : return "="
                of plus             : return "+"
                of doubleplus       : return "++"
                of lessthan         : return "<"
                of greaterthan      : return ">"
                of slash            : return "/"
                of doubleslash      : return "//"
                of backslash        : return "\\"
                of doublebackslash  : return "\\\\"
                of pipe             : return "|"

                of ellipsis         : return ".."
                of dotslash         : return "./"
                of colon            : return ":"
                of doublecolon      : return "::"
                of doublepipe       : return "||"

                of slashedzero      : return "ø"

                of unaliased        : discard

        of Date     : return $(v.eobj)
        of Binary   : discard
        of Inline,
           Block     :
            # result = "["
            # for i,child in v.a:
            #     result &= $(child) & " "
            # result &= "]"

            result = "[" & v.a.map((child) => $(child)).join(" ") & "]"

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
            if v.dbKind==SqliteDatabase: result = fmt("<database>({cast[ByteAddress](v.sqlitedb):#X})")
            #elif v.dbKind==MysqlDatabase: result = fmt("[mysql db] {cast[ByteAddress](v.mysqldb):#X}")

        of Bytecode:
            result = "<bytecode>"
            
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
        if not muted:   stdout.write fmt("{resetColor}<{v.m}>{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("<{v.m}> :{($(v.kind)).toLowerAscii()}")

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
        of Boolean      : dumpPrimitive($(v.b), v)
        of Integer      : 
            if v.iKind==NormalInteger: dumpPrimitive($(v.i), v)
            else: dumpPrimitive($(v.bi), v)
        of Floating     : dumpPrimitive($(v.f), v)
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

        of Binary       : discard

        of Inline,
           Block        :
            dumpBlockStart(v)

            for i,child in v.a:
                dump(child, level+1, i==(v.a.len-1), muted=muted)

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
            if v.dbKind==SqliteDatabase: stdout.write fmt("[sqlite db] {cast[ByteAddress](v.sqlitedb):#X}")
            #elif v.dbKind==MysqlDatabase: stdout.write fmt("[mysql db] {cast[ByteAddress](v.mysqldb):#X}")
        
        of Bytecode     : stdout.write("<bytecode>")

        of Nothing      : discard
        of ANY          : discard

    if not isLast:
        stdout.write "\n"

# TODO Fix pretty-printing for unwrapped blocks
#  Indentation is not working right for inner dictionaries and blocks
#  Check: `print as.pretty.code.unwrapped info.get 'get`
proc codify*(v: Value, pretty = false, unwrapped = false, level: int=0, isLast: bool=false, isKeyVal: bool=false, safeStrings: bool = false): string {.inline.} =
    result = ""

    if pretty:
        if isKeyVal:
            result &= " "
        else:
            for i in 0..level-1: result &= "\t"

    case v.kind:
        of Null         : result &= "null"
        of Boolean      : 
            if v.b: result &= "true"
            else:   result &= "false"
        of Integer      :
            if v.iKind==NormalInteger: result &= $(v.i)
            else: result &= $(v.bi)
        of Floating     : result &= $(v.f)
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
        of Symbol       : 
            case v.m:
                of thickarrowleft   : result &= "<="
                of thickarrowright  : result &= "=>"
                of arrowleft        : result &= "<-"
                of arrowright       : result &= "->"
                of doublearrowleft  : result &= "<<"
                of doublearrowright : result &= ">>"

                of equalless        : result &= "=<"
                of greaterequal     : result &= ">="
                of lessgreater      : result &= "<>"

                of lesscolon        : result &= "<:"
                of minuscolon       : result &= "-:"

                of tilde            : result &= "~"
                of exclamation      : result &= "!"
                of question         : result &= "?"
                of doublequestion   : result &= "??"
                of at               : result &= "@"
                of sharp            : result &= "#"
                of dollar           : result &= "$"
                of percent          : result &= "%"
                of caret            : result &= "^"
                of ampersand        : result &= "&"
                of asterisk         : result &= "*"
                of minus            : result &= "-"
                of doubleminus      : result &= "--"
                of underscore       : result &= "_"
                of equal            : result &= "="
                of plus             : result &= "+"
                of doubleplus       : result &= "++"
                of lessthan         : result &= "<"
                of greaterthan      : result &= ">"
                of slash            : result &= "/"
                of doubleslash      : result &= "//"
                of backslash        : result &= "\\"
                of doublebackslash  : result &= "\\\\"
                of pipe             : result &= "|"

                of ellipsis         : result &= ".."
                of dotslash         : result &= "./"
                of colon            : result &= ":"
                of doublecolon      : result &= "::"
                of doublepipe       : result &= "||"

                of slashedzero      : result &= "ø"

                of unaliased             : discard

        of Inline, Block:
            if not (pretty and unwrapped and level==0):
                if v.kind==Inline: result &= "("
                else: result &= "["

            if pretty:
                result &= "\n"
            
            var parts: seq[string] = @[]
            for i,child in v.a:
                parts.add(codify(child,pretty,unwrapped,level+1, i==(v.a.len-1), safeStrings=safeStrings))

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

# TODO(Value\hash) Verify hashing is done right
#  labels: vm,unit-test
proc hash*(v: Value): Hash {.inline.}=
    case v.kind:
        of Null         : result = 0
        of Boolean      : result = cast[Hash](v.b)
        of Integer      : 
            if v.iKind==NormalInteger: result = cast[Hash](v.i)
            else: result = cast[Hash](v.bi)
        of Floating     : result = cast[Hash](v.f)
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
            result = cast[Hash](unsafeAddr v)
            # result = hash(v.params) !& hash(v.main)
            # result = !$ result
        of Database:
            if v.dbKind==SqliteDatabase: result = cast[Hash](cast[ByteAddress](v.sqlitedb))
            #elif v.dbKind==MysqlDatabase: result = cast[Hash](cast[ByteAddress](v.mysqldb))

        of Bytecode:
            result = cast[Hash](unsafeAddr v)

        of Nothing      : result = 0
        of ANY          : result = 0
