#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
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
    import extras/db_connector/db_sqlite as sqlite
    #import db_mysql as mysql

when defined(WEB):
    import std/jsbigints

when defined(GMP):
    import helpers/bignums as BignumsHelper

when (not defined(GMP)) and (not defined(WEB)):
   import vm/errors

import vm/opcodes

import vm/values/custom/[vbinary, vcolor, vcomplex, verror, vlogical, vquantity, vrange, vrational, vregex, vsymbol, vversion]

when not defined(WEB):
    import vm/values/custom/[vsocket]

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
    VANY*           = makeConst Value(kind: Any)                                      ## constant Any

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

func newBlock*(a: sink ValueArray = @[], data: sink Value = nil): Value {.inline.}
func newDictionary*(d: sink ValueDict = newOrderedTable[string,Value]()): Value {.inline.}
func valueAsString*(v: Value): string {.inline.}
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

func canBeInlined(v: Value): bool  =
    for item in v.a:
        if item.kind == Label:
            return false
        elif item.kind == Block:
            if not canBeInlined(item):
                return false
    return true

#=======================================
# Constructors
#=======================================

proc newLogical*(b: VLogical): Value {.inline.} =
    if b==True: VTRUE
    elif b==False: VFALSE
    else: VMAYBE

proc newLogical*(b: bool): Value {.inline.} =
    if b: VTRUE
    else: VFALSE

proc newLogical*(s: string): Value {.inline.} =
    ## create Logical value from string
    if s=="true": newLogical(True)
    elif s=="false": newLogical(False)
    else: newLogical(Maybe)

proc newLogical*(i: int): Value {.inline.} =
    ## create Logical value from int
    if i==1: newLogical(True)
    elif i==0: newLogical(False)
    else: newLogical(Maybe)

when defined(WEB):
    proc newInteger*(bi: JsBigInt): Value {.inline.} =
        result = Value(kind: Integer, iKind: BigInteger, bi: bi)

when defined(GMP):
    proc newInteger*(bi: Int): Value {.inline.} =
        result = Value(kind: Integer, iKind: BigInteger, bi: bi)

func newInteger*(i: int): Value {.inline.} =
    ## create Integer value from int
    result = Value(kind: Integer, iKind: NormalInteger, i: i)

func newInteger*(i: int64): Value {.inline.} =
    ## create Integer value from int64
    newInteger(int(i))

proc newInteger*(i: string, lineno: int = 1): Value {.inline.} =
    ## create Integer value from string
    try:
        return newInteger(parseInt(i))
    except ValueError:
        when defined(WEB):
            return newInteger(big(i.cstring))
        elif defined(GMP):
            return newInteger(newInt(i))
        else:
            Error_IntegerParsingOverflow(i)

func newBigInteger*(i: int): Value {.inline.} =
    ## create Integer (BigInteger) value from int
    when defined(WEB):
        result = Value(kind: Integer, iKind: BigInteger, bi: big(i))
    elif defined(GMP):
        result = Value(kind: Integer, iKind: BigInteger, bi: newInt(i))

func newFloating*(f: float): Value {.inline.} =
    ## create Floating value from float
    Value(kind: Floating, f: f)

func newFloating*(f: int): Value {.inline.} =
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

func newRational*(rat: VRational): Value {.inline.} =
    ## create Rational value from VRational
    Value(kind: Rational, rat: rat)

when defined(GMP):
    func newRational*(n: int | float | Int): Value {.inline.} =
        ## create Rational value from int, float or Int
        Value(kind: Rational, rat: toRational(n))

    func newRational*(num: int | float | Int, den: int | float | Int): Value {.inline.} = 
        ## create Rational value from numerator + denominator (int, float or Int)
        Value(kind: Rational, rat: toRational(num, den))

    func newRational*(rat: Rat): Value {.inline.} =
        ## create Rational value from Rat
        Value(kind: Rational, rat: toRational(rat))
else:
    func newRational*(n: int | float): Value {.inline.} =
        ## create Rational value from int or float
        Value(kind: Rational, rat: toRational(n))

    func newRational*(num: int | float, den: int | float): Value {.inline.} = 
        ## create Rational value from numerator + denominator (int or float)
        Value(kind: Rational, rat: toRational(num, den))

func newRational*(num: Value, den: Value): Value {.inline.} =
    ## create Rational value from numerator + denominator (Value)
    if num.kind == Integer and den.kind == Integer:
        if num.iKind == NormalInteger:
            if den.iKind == NormalInteger:
                return newRational(num.i, den.i)
            else:
                when defined(GMP):
                    return newRational(num.i, den.bi)
        else:
            when defined(GMP):
                if den.iKind == NormalInteger:
                    return newRational(num.bi, den.i)
                else:
                    return newRational(num.bi, den.bi)
    else:
        if num.kind == Integer:
            if num.iKind == NormalInteger:
                return newRational(num.i, den.f)
            else:
                when defined(GMP):
                    return newRational(num.bi, den.f)
        else:
            if den.kind == Integer:
                if den.iKind == NormalInteger:
                    return newRational(num.f, den.i)
                else:
                    when defined(GMP):
                        return newRational(num.f, den.bi)
            else:
                return newRational(num.f, den.f)

func newVersion*(v: string): Value {.inline.} =
    ## create Version value from string
    Value(kind: Version, version: newVVersion(v))

func newVersion*(v: VVersion): Value {.inline.} =
    ## create Version value from VVersion
    Value(kind: Version, version: v)

func newType*(t: ValueKind): Value {.inline.} =
    ## create Type (BuiltinType) value from ValueKind
    Value(kind: Type, tpKind: BuiltinType, t: t)

proc newUserType*(tid: string, proto: Prototype = nil): Value {.inline.} =
    setType(tid, proto)
    Value(kind: Type, tpKind: UserType, t: Object, tid: tid)

proc newType*(t: string): Value {.inline.} =
    ## create Type value from string
    try:
        newType(parseEnum[ValueKind](t.capitalizeAscii()))
    except ValueError:
        newUserType(t)

func newChar*(c: Rune): Value {.inline.} =
    ## create Char value from Rune
    Value(kind: Char, c: c)

func newChar*(c: char): Value {.inline.} =
    ## create Char value from char
    Value(kind: Char, c: ($c).runeAt(0))

func newChar*(c: string): Value {.inline.} =
    ## create Char value from string
    Value(kind: Char, c: c.runeAt(0))

func newString*(s: sink string, dedented: static bool = false): Value {.inline.} =
    ## create String value from string
    when not dedented: 
        Value(kind: String, s: s)
    else: 
        Value(kind: String, s: unicode.strip(dedent(s)))

func newString*(s: cstring, dedented: static bool = false): Value {.inline.} =
    ## create String value from cstring
    newString($(s), dedented)

func newWord*(w: sink string): Value {.inline.} =
    ## create Word value from string
    Value(kind: Word, s: w)

func newLiteral*(l: sink string): Value {.inline.} =
    ## create Literal value from string
    Value(kind: Literal, s: l)

func newLabel*(l: sink string): Value {.inline.} =
    ## create Label value from string
    Value(kind: Label, s: l)

func newAttribute*(a: sink string): Value {.inline.} =
    ## create Attribute value from string
    Value(kind: Attribute, s: a)

func newAttributeLabel*(a: sink string): Value {.inline.} =
    ## create AttributeLabel value from string
    Value(kind: AttributeLabel, s: a)

func newPath*(p: sink ValueArray): Value {.inline.} =
    ## create Path value from ValueArray
    Value(kind: Path, p: p)

func newPathLabel*(p: sink ValueArray): Value {.inline.} =
    ## create PathLabel value from ValueArray
    Value(kind: PathLabel, p: p)

func newPathLiteral*(p: sink ValueArray): Value {.inline.} =
    ## create PathLiteral value from ValueArray
    Value(kind: PathLiteral, p: p)

func newSymbol*(m: VSymbol): Value {.inline.} =
    ## create Symbol value from VSymbol
    Value(kind: Symbol, m: m)

func newSymbol*(m: sink string): Value {.inline.} =
    ## create Symbol value from string
    newSymbol(parseEnum[VSymbol](m))

func newSymbolLiteral*(m: VSymbol): Value {.inline.} =
    ## create SymbolLiteral value from VSymbol
    Value(kind: SymbolLiteral, m: m)

func newSymbolLiteral*(m: string): Value {.inline.} =
    ## create SymbolLiteral value from string
    newSymbolLiteral(parseEnum[VSymbol](m))

proc newUnit*(u: VUnit): Value {.inline.} =
    ## create Unit value from VUnit
    Value(kind: Unit, u: u)

proc newUnit*(u: string): Value {.inline.} =
    ## create Unit value from string
    newUnit(parseAtoms(u))

proc newQuantity*(v: Value, atoms: VUnit): Value {.inline.} =
    ## create Quantity value from a numerical value ``v`` (Value) + ``atoms`` (VUnit)
    result = Value(kind: Quantity)
    if v.kind == Integer: 
        if v.iKind == NormalInteger:
            result.q = toQuantity(v.i, atoms)
        else:
            when defined(GMP):
                result.q = toQuantity(v.bi, atoms)
    elif v.kind == Floating:
        result.q = toQuantity(v.f, atoms)
    else:
        result.q = toQuantity(v.rat, atoms)

proc newQuantity*(v: Value, atoms: string): Value {.inline.} =
    ## create Quantity value from a numerical value ``v`` (Value) + ``atoms`` (string)
    newQuantity(v, parseAtoms(atoms))

proc newQuantity*(q: VQuantity, copy: static bool = false): Value {.inline.} =
    ## create Quantity value from QuantityValue ``q`` (VQuantity)
    when copy:
        Value(kind: Quantity, q: toQuantity(q.original, q.atoms))
    else:
        Value(kind: Quantity, q: q)

proc newErrorKind*(): Value {.inline.} =
    Value(kind: ErrorKind, errKind: VErrorKind(label: "Generic Error"))

proc newErrorKind*(label: string, description: string = ""): Value {.inline.} =
    Value(kind: ErrorKind, errKind: VErrorKind(label: label, description: description))

proc newErrorKind*(errKind: VErrorKind = RuntimeErr): Value {.inline.} =
    Value(kind: ErrorKind, errKind: errKind)

proc newError*(error: ref Exception | CatchableError | Defect): Value {.inline.} =
    result = Value(kind: Error, err: VError(kind: RuntimeErr))
    result.err.msg = error.msg

proc newError*(kind: VErrorKind = RuntimeErr, msg: string = ""): Value {.inline.} =
    result = Value(kind: Error, err: VError(kind: kind))
    result.err.msg = msg

proc newError*(err: VError): Value {.inline.} =
    Value(kind: Error, err: err)

func newRegex*(rx: sink VRegex): Value {.inline.} =
    ## create Regex value from VRegex
    Value(kind: Regex, rx: rx)

func newRegex*(rx: string, rflags: string = ""): Value {.inline.} =
    ## create Regex value from string
    newRegex(newRegexObj(rx, rflags))

func newColor*(l: VColor): Value {.inline.} =
    ## create Color value from VColor
    Value(kind: Color, l: l)

func newColor*(rgb: RGB): Value {.inline.} =
    ## create Color value from RGB
    newColor(colorFromRGB(rgb))

func newColor*(l: string): Value {.inline.} =
    ## create Color value from string
    newColor(parseColor(l))

func newDate*(dt: sink DateTime): Value {.inline.} =
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

func newBinary*(n: VBinary = @[]): Value {.inline.} =
    ## create Binary value from VBinary
    Value(kind: Binary, n: n)

func newDictionary*(d: sink ValueDict = newOrderedTable[string,Value]()): Value {.inline.} =
    ## create Dictionary value from ValueDict
    Value(kind: Dictionary, d: d)

func newDictionary*(d: sink SymTable): Value {.inline.} =
    ## create Dictionary value from SymTable
    newDictionary(toSeq(d.pairs).toOrderedTable)

func newObject*(proto: sink Prototype, o: sink ValueDict = newOrderedTable[string,Value](), magic: MagicMethods = MagicMethods()): Value {.inline.} =
    ## create Object value from ValueDict with given prototype
    Value(kind: Object, proto: proto, o: o, magic: magic)

# proc newObject*(args: ValueArray, prot: Prototype, initializer: proc (self: Value, prot: Prototype), o: ValueDict = newOrderedTable[string,Value]()): Value {.inline.} =
#     ## create Object value from ValueArray with given prototype 
#     ## and initializer function
#     var fields = o
#     var i = 0

#     while i<args.len and i<prot.fields.len:
#         let k = prot.fields[i]
#         fields[k.s] = args[i]
#         i += 1

#     result = newObject(fields, prot)

#     initializer(result, prot)

# proc newObject*(args: ValueDict, prot: Prototype, initializer: proc (self: Value, prot: Prototype), o: ValueDict = newOrderedTable[string,Value]()): Value {.inline.} =
#     ## create Object value from ValueDict with given prototype 
#     ## and initializer function, using another object ``o`` as 
#     ## a parent object
#     var fields = o
#     for k,v in pairs(args):
#         for item in prot.fields:
#             if item.s == k:
#                 fields[k] = v

#     result = newObject(fields, prot)
    
#     initializer(result, prot)

proc newStore*(sto: VStore): Value {.inline.} =
    ## create Store value from VStore
    Value(kind: Store, sto: sto)

func newFunction*(params: seq[string], main: Value, imports: Value = nil, exports: Value = nil, memoize: bool = false, inline: bool = false): Value {.inline.} =
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

func newMethod*(params: seq[string], main: Value, isDistinct: bool = false, isPublic: bool = false, injectThis: static bool = true): Value {.inline.} =
    Value(
        kind: Method,
        info: nil,
        methType: VMethod(
            marity: int8(params.len) + (when injectThis: 1 else: 0),
            mparams: (when injectThis: "this" & params else: params),
            mmain: main,
            mbcode: nil,
            mdistinct: isDistinct,
            mpublic: isPublic
        )
    )

func newFunctionFromDefinition*(params: ValueArray, main: Value, imports: Value = nil, exports: Value = nil, memoize: bool = false, forceInline: bool = false, inPath: ref string = nil): Value {.inline.} =
    ## create Function value with given parameters,
    ## generate type checkers, and process info if necessary
    
    # TODO(VM/values/value) Verify inlining safety  in `newFunctionFromDefinition`
    #  labels: library, benchmark, open discussion
    var inline = forceInline
    if not inline:
        if canBeInlined(main):
            inline = true

    var argTypes = initOrderedTable[string,ValueSpec]()

    if params.countIt(it.kind == Type) > 0:
        var args: seq[string]
        var body: ValueArray

        var i = 0
        while i < params.len:
            let varName = params[i]
            args.add(params[i].s)
            argTypes[params[i].s] = {}
            if i+1 < params.len and params[i+1].kind == Type:
                var typeArr: ValueArray

                while i+1 < params.len and params[i+1].kind == Type:
                    typeArr.add(newWord("is?"))
                    typeArr.add(params[i+1])
                    argTypes[varName.s].incl(params[i+1].t)
                    typeArr.add(varName)
                    i += 1

                body.add(newWord("ensure"))
                if typeArr.len == 3:
                    body.add(newBlock(typeArr))
                else:
                    body.add(newBlock(@[
                        newWord("any?"),
                        newWord("array"),
                        newBlock(typeArr)
                    ]))
            else:
                argTypes[varName.s].incl(Any)
            i += 1

        var mainBody: ValueArray = main.a
        mainBody.insert(body)

        result = newFunction(args,newBlock(mainBody),imports,exports,memoize,inline)
    else:
        if params.len > 0:
            for arg in params:
                argTypes[arg.s] = {Any}
        else:
            argTypes[""] = {Nothing}
        result = newFunction(params.map((w)=>w.s),main,imports,exports,memoize,inline)

    result.info = ValueInfo(kind: Function)

    if not main.data.isNil:
        if main.data.kind==Dictionary:

            if (let descriptionData = main.data.d.getOrDefault("description", nil); not descriptionData.isNil):
                result.info.descr = descriptionData.s
                result.info.module = ""

            if main.data.d.hasKey("options") and main.data.d["options"].kind==Dictionary:
                var options = initOrderedTable[string,(ValueSpec,string)]()
                for (k,v) in pairs(main.data.d["options"].d):
                    if v.kind==Type:
                        options[k] = ({v.t}, "")
                    elif v.kind==String:
                        options[k] = ({Logical}, v.s)
                    elif v.kind==Block:
                        var vspec: ValueSpec
                        var i = 0
                        while i < v.a.len and v.a[i].kind==Type:
                            vspec.incl(v.a[i].t)
                            i += 1
                        if v.a[i].kind==String:
                            options[k] = (vspec, v.a[i].s)
                        else:
                            options[k] = (vspec, "")

                result.info.attrs = options

            if (let returnsData = main.data.d.getOrDefault("returns", nil); not returnsData.isNil):
                if returnsData.kind==Type:
                    result.info.returns = {returnsData.t}
                else:
                    var returns: ValueSpec
                    for tp in returnsData.a:
                        returns.incl(tp.t)
                    result.info.returns = returns

            when defined(DOCGEN):
                if (let exampleData = main.data.d.getOrDefault("example", nil); not exampleData.isNil):
                    result.info.example = exampleData.s

    result.info.args = argTypes
    result.info.path = inPath

# TODO(VM/values/value) `newMethodFromDefinition` redundant?
#  could we possibly "merge" it with `newFunctionFromDefinition` or 
#  at least create e.g. a template?
#  labels: values, enhancement, cleanup
func newMethodFromDefinition*(params: ValueArray, main: Value, isDistinct: bool = false, isPublic: bool = false, inPath: ref string = nil): Value {.inline.} =
    ## create Method value with given parameters,
    ## generate type checkers, and process info if necessary

    var argTypes = initOrderedTable[string,ValueSpec]()

    if params.countIt(it.kind == Type) > 0:
        var args: seq[string]
        var body: ValueArray

        var i = 0
        while i < params.len:
            let varName = params[i]
            args.add(params[i].s)
            argTypes[params[i].s] = {}
            if i+1 < params.len and params[i+1].kind == Type:
                var typeArr: ValueArray

                while i+1 < params.len and params[i+1].kind == Type:
                    typeArr.add(newWord("is?"))
                    typeArr.add(params[i+1])
                    argTypes[varName.s].incl(params[i+1].t)
                    typeArr.add(varName)
                    i += 1

                body.add(newWord("ensure"))
                if typeArr.len == 3:
                    body.add(newBlock(typeArr))
                else:
                    body.add(newBlock(@[
                        newWord("any?"),
                        newWord("array"),
                        newBlock(typeArr)
                    ]))
            else:
                argTypes[varName.s].incl(Any)
            i += 1

        var mainBody: ValueArray = main.a
        mainBody.insert(body)

        result = newMethod(args,newBlock(mainBody),isDistinct,isPublic)
    else:
        if params.len > 0:
            for arg in params:
                argTypes[arg.s] = {Any}
        else:
            argTypes[""] = {Nothing}
        result = newMethod(params.map((w)=>w.s),main,isDistinct,isPublic)

    result.info = ValueInfo(kind: Method)

    if not main.data.isNil:
        if main.data.kind==Dictionary:

            if (let descriptionData = main.data.d.getOrDefault("description", nil); not descriptionData.isNil):
                result.info.descr = descriptionData.s
                result.info.module = ""

            if main.data.d.hasKey("options") and main.data.d["options"].kind==Dictionary:
                var options = initOrderedTable[string,(ValueSpec,string)]()
                for (k,v) in pairs(main.data.d["options"].d):
                    if v.kind==Type:
                        options[k] = ({v.t}, "")
                    elif v.kind==String:
                        options[k] = ({Logical}, v.s)
                    elif v.kind==Block:
                        var vspec: ValueSpec
                        var i = 0
                        while i < v.a.len and v.a[i].kind==Type:
                            vspec.incl(v.a[i].t)
                            i += 1
                        if v.a[i].kind==String:
                            options[k] = (vspec, v.a[i].s)
                        else:
                            options[k] = (vspec, "")

                result.info.attrs = options

            if (let returnsData = main.data.d.getOrDefault("returns", nil); not returnsData.isNil):
                if returnsData.kind==Type:
                    result.info.returns = {returnsData.t}
                else:
                    var returns: ValueSpec
                    for tp in returnsData.a:
                        returns.incl(tp.t)
                    result.info.returns = returns

            when defined(DOCGEN):
                if (let exampleData = main.data.d.getOrDefault("example", nil); not exampleData.isNil):
                    result.info.example = exampleData.s

    result.info.args = argTypes
    result.info.path = inPath

func newBuiltin*(desc: sink string, modl: sink string, line: int, ar: int8, ag: sink OrderedTable[string,ValueSpec], at: sink OrderedTable[string,(ValueSpec,string)], ret: ValueSpec, exa: sink string, opc: OpCode, act: BuiltinAction): Value {.inline.} =
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

func newBytecode*(t: sink Translation): Value {.inline.} =
    ## create Bytecode value from Translation
    Value(kind: Bytecode, trans: t)

func newInline*(a: sink ValueArray = @[]): Value {.inline.} =
    ## create Inline value from ValueArray
    Value(kind: Inline, a: a)

func newBlock*(a: sink ValueArray = @[], data: sink Value = nil): Value {.inline.} =
    ## create Block value from ValueArray
    Value(kind: Block, a: a, data: data)

func newBlock*(a: (Value, Value)): Value {.inline.} =
    ## create Block value from tuple of two values
    newBlock(@[a[0], a[1]])

func newIntegerBlock*[T](a: sink seq[T]): Value {.inline.} =
    ## create Block value from an array of ints
    newBlock(a.map(proc (x:T):Value = newInteger(int(x))))

proc newStringBlock*(a: sink seq[string]): Value {.inline.} =
    ## create Block value from an array of strings
    newBlock(a.map(proc (x:string):Value = newString($x)))

proc newStringBlock*(a: sink seq[cstring]): Value {.inline.} =
    ## create Block value from an array of cstrings
    newBlock(a.map(proc (x:cstring):Value = newString(x)))

proc newWordBlock*(a: sink seq[string]): Value {.inline.} =
    ## create Block value from an array of strings
    newBlock(a.map(proc (x:string):Value = newWord(x)))

proc newModule*(singleton: Value): Value {.inline.} =
    Value(kind: Module, singleton: singleton)

proc newRange*(start: int, stop: int, step: int, infinite: bool, numeric: bool, forward: bool): Value {.inline.} =
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

proc newRange*(rng: VRange): Value {.inline.} =
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

# TODO(VM/values/value) add better unit-tests for deep copies
#  right now, in tests/unittests/deepcopies, we're testing integers
#  strings, blocks and dictionaries. The tests could/should cover pretty
#  much every type (nested or not)
#  labels: values, unit-test

# TODO(VM/values/value) create proper constructor overloads for deep-copying
#  `newQuantity(.., copy=true)` would be the example. It should operate statically,
#  at runtime!
#  labels: values, enhancement, cleanup
proc copyValue*(v: Value): Value {.inline.} =
    ## copy given value (deep copy) and return 
    ## the result
    ## 
    ## **Hint**: extensively use for pointer disambiguation, 
    ## ``new`` and value copying, in general (when needed)

    case v.kind:
        of Null:            result = VNULL
        of Logical:         result = newLogical(v.b)
        of Integer:     
            if likely(v.iKind == NormalInteger): 
                result = newInteger(v.i)
            else:
                when defined(GMP): 
                    result = newInteger(copyInt(v.bi))
                else:
                    when defined(WEB):
                        result = newInteger(v.bi)
        of Floating:        result = newFloating(v.f)
        of Complex:         result = newComplex(v.z)
        of Rational:        result = newRational(copyRational(v.rat))
        of Version:         result = newVersion(v.version)
        of Type:        
            if likely(v.tpKind==BuiltinType):
                result = newType(v.t)
            else:
                result = newUserType(v.tid)#TypeExtension(v.ts.content[], copyValue(v.ts.inherits))
                #result.ts.name = v.ts.name
        of Char:            result = newChar(v.c)

        of String:          result = newString(v.s)
        of Word:            result = newWord(v.s)
        of Literal:         result = newLiteral(v.s)
        of Label:           result = newLabel(v.s)

        of Attribute:       result = newAttribute(v.s)
        of AttributeLabel:  result = newAttributeLabel(v.s)

        of Path:            result = newPath(v.p)
        of PathLabel:       result = newPathLabel(v.p)
        of PathLiteral:     result = newPathLiteral(v.p)

        of Symbol:          result = newSymbol(v.m)
        of SymbolLiteral:   result = newSymbolLiteral(v.m)
        of Regex:           result = newRegex(v.rx)
        of Unit:            result = newUnit(v.u)
        of Quantity:        result = newQuantity(v.q, copy=true)
        of Error:           result = newError(v.err)
        of ErrorKind:       result = newErrorKind(v.errKind)
        of Color:           result = newColor(v.l)
        of Date:            result = newDate(v.eobj[])
        of Binary:          result = newBinary(v.n)
        of Inline:          result = newInline(v.a)
        of Block:       
            if v.data.isNil: 
                result = newBlock(v.a.map((vv)=>copyValue(vv)))
            else:
                result = newBlock(v.a.map((vv)=>copyValue(vv)), copyValue(v.data))
        of Module:
            result = newModule(copyValue(v.singleton))
        of Range:
            result = newRange(v.rng.start, v.rng.stop, v.rng.step, v.rng.infinite, v.rng.numeric, v.rng.forward)

        of Dictionary:      
            let dcopy = newOrderedTable[string,Value]()
            for key,val in v.d:
                dcopy[key] = copyValue(val)
            result = newDictionary(dcopy)
        of Object:          result = newObject(v.proto, v.o[], v.magic)
        of Store:           result = newStore(v.sto)

        of Function:    
            if v.fnKind == UserFunction:
                result = newFunction(v.params, v.main, v.imports, v.exports, v.memoize, v.inline)
                if not v.info.isNil:
                    result.info = ValueInfo()
                    result.info[] = v.info[]
            else:
                when defined(DOCGEN):
                    result = newBuiltin(v.info.descr, v.info.module, v.info.line, v.arity, v.info.args, v.info.attrs, v.info.returns, v.info.example, v.op, v.action)
                else:
                    result = newBuiltin(v.info.descr, v.info.module, 0, v.arity, v.info.args, v.info.attrs, v.info.returns, "", v.op, v.action)
        of Method:
            result = newMethod(v.mparams, v.mmain, v.mdistinct, v.mpublic, injectThis=false)
            if not v.info.isNil:
                result.info = ValueInfo()
                result.info[] = v.info[]

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

func asFloat*(v: Value): float  = 
    ## get numeric value forcefully as a float
    ## 
    ## **Hint:** We have to make sure the value is 
    ## either an Integer, a Floating or a Rational value
    case v.kind
    of Floating:
        result = v.f
    of Integer:
        result = float(v.i)
    of Rational:
        result = toFloat(v.rat)
    else:
        discard


func asInt*(v: Value): int  = 
    ## get numeric value forcefully as an int
    ## 
    ## **Hint:** We have to make sure the value is 
    ## either an Integer or a Floating value
    if v.kind == Integer:
        result = v.i
    else:
        result = int(v.f)

func valueAsString*(v: Value): string {.inline.} =
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
                when defined(WEB) or defined(GMP): 
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

func consideredEqual*(x: Value, y: Value): bool {.inline.} =
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
            when defined(GMP):
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
                return x.tid == y.tid
        of Char: return x.c == y.c
        of Symbol,
           SymbolLiteral: return x.m == y.m
        of Unit: return x.u == y.u
        of Quantity: return x.q.original == y.q.original and x.q.atoms == y.q.atoms
        of Regex: return x.rx == y.rx
        of Color: return x.l == y.l
        of Inline:
            if x.a.len != y.a.len: return false
            for i in 0..x.a.high:
                if not consideredEqual(x.a[i], y.a[i]): return false
            return true
        of Module: return consideredEqual(x.singleton, y.singleton)
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
                if x.dbKind==SqliteDatabase: return cast[uint](x.sqlitedb) == cast[uint](y.sqlitedb)
                #elif x.dbKind==MysqlDatabase: return cast[uint](x.mysqldb) == cast[uint](y.mysqldb)
        of Date:
            return x.eobj == y.eobj
        else:
            return false

func hash*(v: Value): Hash {.inline.} =
    ## calculate the hash for given value
    # TODO(VM/values/value) update when Nim bug is resolved
    #  see: https://github.com/nim-lang/Nim/issues/23236
    when defined(WEB):
        var v = v
    
    result = hash(v.kind)
    
    case v.kind:
        of Null         : discard
        of Logical      : result = result !& cast[Hash](v.b)
        of Integer      : 
            if likely(v.iKind==NormalInteger): result = result !& cast[Hash](v.i)
            else: 
                when defined(WEB) or defined(GMP):
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
            result = result !& hash(v.prerelease)
            result = result !& hash(v.extra)
        of Type         : 
            result = result !& hash(v.tpKind)
            result = result !& cast[Hash](ord(v.t))
            result = result !& hash(v.tid)   
        of Char         : result = result !& cast[Hash](ord(v.c))
        of String       : result = result !& hash(v.s)
        
        of Word,
           Literal,
           Label,
           Attribute,
           AttributeLabel        : result = result !& hash(v.s)

        of Path,
           PathLabel,
           PathLiteral  : 
            for i in v.p:
                result = result !& hash(i)

        of Symbol,
           SymbolLiteral: result = result !& cast[Hash](ord(v.m))

        of Unit         : result = result !& hash(v.u)

        of Quantity     : result = result !& hash(v.q)

        of Regex        : result = result !& hash(v.rx)

        of Error        : result = result !& hash(v.err.kind.label)

        of ErrorKind    : result = result !& hash(v.errKind.label)

        of Color        : result = result !& cast[Hash](v.l)

        of Date         : discard

        of Binary       : discard

        of Inline,
           Block        :
            result = 1
            for i in v.a:
                result = result !& hash(i)

        of Module       :
            result = result !& hash(v.singleton)

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

        of Method       :
            result = result !& hash(v.mparams)
            result = result !& hash(v.mmain)
            result = result !& hash(v.mdistinct)
            result = result !& hash(v.mpublic)

        of Database:
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: result = result !& cast[Hash](cast[uint](v.sqlitedb))
                #elif v.dbKind==MysqlDatabase: result = cast[Hash](cast[uint](v.mysqldb))

        of Socket:
            when not defined(WEB):
                result = result !& hash(v.sock)

        of Bytecode:
            result = result !& cast[Hash](unsafeAddr v)

        of Nothing      : discard
        of ANY          : discard

    result = !$ result

{.pop.}
