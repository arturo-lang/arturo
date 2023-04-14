#=======================================
# Libraries
#=======================================

import algorithm, macros, math, parseutils, sequtils, strutils, tables

import vm/values/custom/vrational

#=======================================
# Types
#=======================================

type
    UnitPrefix = enum
        PAtto   = (-18, "a")
        PFemto  = (-15, "f")
        PPico   = (-12, "p")
        PNano   = ( -9, "n")
        PMicro  = ( -6, "u")
        PMilli  = ( -3, "m")
        PCenti  = ( -2, "c")
        PDeci   = ( -1, "d")
        PNone   = (  0, "")
        PDeka   = (  1, "da")
        PHecto  = (  2, "h")
        PKilo   = (  3, "k")
        PMega   = (  6, "M")
        PGiga   = (  9, "G")
        PTera   = ( 12, "T")
        PPeta   = ( 15, "P")
        PExa    = ( 18, "E")

        PError  = ( 50, "prefix-error")

    UnitType = enum
        # Length
        M = "m"
        IN = "in"
        FT = "ft"
        YD = "yd"
        ANG = "ang"
        LY = "ly"
        PC = "pc"
        AU = "au"
        CHAIN = "chain"
        ROD = "rod"
        FUR = "fur"
        MI = "mi"
        NMI = "nmi"

        # Area
        AC = "ac"
        ARE = "are"
        HA = "ha"

        # Time
        S = "s"
        HR = "hr"

        # Weight
        G = "g"

        TError = "type-error"

    UnitExponent = -3..6

    UnitFamily = enum
        FCurrency = "currency"
        FLength   = "length"
        FArea     = "area"
        FVolume   = "volume"
        FPressure = "pressure"
        FEnergy   = "energy"
        FPower    = "power"
        FForce    = "force"
        FRadio    = "radioactivity"
        FAngle    = "angle"
        FSpeed    = "speed"
        FAccel    = "acceleration"
        FWeight   = "weight"
        FInfo     = "information"
        FTime     = "time"
        FTemp     = "temperature"

        FError    = "error"

    Unit = tuple
        p: UnitPrefix
        t: UnitType
        e: UnitExponent

    Units = seq[Unit]

    VQuantity = tuple
        value: VRational
        units: Units

    # VQuantityObj = typeof(VQuantity()[])

# Benchmarking
{.hints: on.} # Apparently we cannot disable just `Name` hints?
#{.hint: "Quantity's inner type is currently " & $sizeof(VQuantityObj) & ".".}
{.hint: "Unit's inner type is currently " & $sizeof(Unit) & ".".}
{.hints: off.}

const
    UnitExponentStrings = ["⁻³", "⁻²", "⁻¹", "", "", "²", "³", "⁴", "⁵", "error"]

# 1 N = 1 kg*m/s²

let
    BaseUnits = [(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M),(PNone,M)]
    # Unit ratios as rationals (with numerator and denominator as integers)
    UnitRatios = [
        1 // 1, # M
        254 // 10000, # IN  
        3048 // 10000, # FT
        9144 // 10000, # YD
    ]
    #UnitRatios = [1.0, 0.0254, 0.3048, 0.9144, 1.0e-10, 9.4605284e15, 3.08567758e16, 1.495978707e11, 20.1168, 5.0292, 1.609344, 1852.0]

#=======================================
# Macros
#=======================================

func `$`(qu: VQuantity): string {.inline.}

macro parseEnumFromString*(enumToParse: typedesc, argSym: typed, default: typed): untyped =
    let enumType    = enumToParse.getTypeInst[1]
    let enumItems   = enumType.getImpl[2]

    result = nnkCaseStmt.newTree(argSym)

    var fStr = ""

    for f in enumItems:
        if f.kind == nnkEmpty: continue

        var enumCase: NimNode
        case f.kind
            of nnkSym, nnkIdent: fStr = f.strVal
            of nnkEnumFieldDef:
                enumCase = f[0]
                case f[1].kind
                    of nnkStrLit: fStr = f[1].strVal
                    of nnkTupleConstr:
                        fStr = f[1][1].strVal
                    of nnkIntLit:
                        fStr = f[0].strVal
                    else:
                        let fAst = f[0].getImpl
                        if fAst.kind == nnkStrLit:
                            fStr = fAst.strVal
                        else:
                            error("Invalid syntax!", f[1])
            else: discard
    
        result.add nnkOfBranch.newTree(newLit(fStr),  enumCase)

    result.add nnkElse.newTree(default)

macro generateEnumParser*(en: untyped, def: untyped) = 
    let parserName = ident("parse" & en.strVal)

    return quote do:
        proc `parserName`(p: string): `en` {.inline.} =
            parseEnumFromString(`en`, p, `def`)

#=======================================
# Helpers
#=======================================

func getFamily(ut: UnitType): UnitFamily =
    case ut
        of M..NMI   : FLength
        of AC..HA   : FArea
        of S..HR    : FTime
        of G        : FWeight
        of TError   : FError

func arrange*(un: var seq[Unit]) =
    sort(un, cmp = proc (x, y: Unit): int =
        let fx = getFamily(x.t)
        let fy = getFamily(y.t)
        if fx == fy:
            return ord(x.t) - ord(y.t)
        else:
            return ord(fx) - ord(fy)
    )

func `*=`(a: var Units, b: Unit) =
    for i in 0 ..< a.len:
        if a[i].t == b.t and a[i].p == b.p:
            a[i].e = a[i].e + b.e
            return

    a.add(b)

func `*=`(a: var Units, b: Units) =
    for i in 0 ..< b.len:
        a *= b[i]

proc toBaseUnit*(q: VQuantity): VQuantity =
    #result = new VQuantity
    result.value = q.value
    for unit in q.units:
        let bu = BaseUnits[ord(unit.t)]
        result.units.add(
            (p: bu[0], t: bu[1], e: unit.e)
        )
        result.value *= UnitRatios[ord(unit.t)]
        result.value *= toRational(pow(10, float(unit.p) - float(bu[0])))

func `+`(a: Units, b: Units): Units =
    result = a
    result *= b

proc `+`(qa: VQuantity, qb: VQuantity): VQuantity =
    let finalQa = qa.toBaseUnit
    let finalQb = qb.toBaseUnit

    if finalQa.units == finalQb.units:
        #result = new VQuantity
        result.value = finalQa.value + finalQb.value
        result.units = finalQa.units
    else:
        debugEcho("Cannot add quantities with different units!")
        result = (value: 0//1, units: @[Unit((p: PNone, t: TError, e: UnitExponent(0)))])

func `*`(qa: VQuantity, qb: VQuantity): VQuantity =
    #result = new VQuantity
    result.value = qa.value * qb.value
    result.units = qa.units
    result.units *= qb.units

func stringify(ue: UnitExponent, withNegatives: static bool = true): string {.inline.} =
    UnitExponentStrings[(when withNegatives: ue else: abs(ue)) + 3]

func stringify(un: Unit, withNegatives: static bool = true): string {.inline.} =
    result = $un.p & $un.t
    if un.e != 0:
        result.add stringify(un.e, withNegatives)

func `$`(uns: Units): string {.inline.} =
    let positives = uns.filterIt(it.e > 0)
    let negatives = uns.filterIt(it.e < 0)

    if positives.len > 0:
        result = positives.map(proc (u: Unit): string = stringify(u)).join("·")
        if negatives.len > 0:
            result &= "/"
            result &= negatives.map(proc (u: Unit): string = stringify(u, false)).join("·")
    else:
        result = negatives.map(proc (u: Unit): string = stringify(u)).join("·")

func `$`(qu: VQuantity): string {.inline.} =
    result = $(toFloat(qu.value))
    if qu.units.len > 0:
        result.add " " & $qu.units

#=======================================
# Parsers
#=======================================

generateEnumParser(UnitPrefix, PError)
generateEnumParser(UnitType, TError)

func parseUnits(s: string): Units =
    func parsePart(k: string): seq[tuple[pref: UnitPrefix, exp: int, utp: UnitType]] =
        for p in k.split("."):
            result.add((PNone, 1, TError))
            var tp = ""
            var i = 0
            while i < p.len and p[i] notin {'1','2','3','4','5'}:
                tp.add p[i]
                i += 1
            result[^1].exp = 1
            if p.len > i:
                discard parseInt(p[i..p.len-1], result[^1].exp)

            result[^1].utp = parseUnitType(tp)
            result[^1].pref = PNone
            if result[^1].utp == TError:
                result[^1].pref = parseUnitPrefix($(tp[0]))
                result[^1].utp = parseUnitType(tp[1..tp.len-1])

    let parts = s.split("/")
    var pos = parts[0]
    var neg: string = ""
    if parts.len > 1:
        neg = parts[1]

    var parsedUcs = parsePart(pos)
    for (up, pe, ut) in parsedUcs:
        result *= (p: up, t: ut, e: UnitExponent(pe))

    if neg.len > 0:
        parsedUcs = parsePart(neg)
        for (up, pe, ut) in parsedUcs:
            result *= (p: up, t: ut, e: UnitExponent(-pe))

    arrange(result)

func parseQuantity(s: string): VQuantity =
    var parts = s.split(" ")
    var f: float
    discard parseFloat(parts[0], f)
    
    let ucs = parseUnits(parts[1])
    
    return (
        value: toRational(f),
        units: ucs
    )

func `&`(a: string): VQuantity =
    parseQuantity(a)

proc debugParse(s: string) =
    echo $(&s)

proc debugAdd(a, b: string) =
    let aq = &a
    let bq = &b
    echo $aq & " + " & $bq & " = " & $(aq + bq)

proc debugMul(a, b: string) =
    let aq = &a
    let bq = &b
    echo $aq & " * " & $bq & " = " & $(aq * bq)

when isMainModule:
    debugParse "1 m"
    debugParse "3 m2"
    debugParse "4 m/s"
    debugParse "5 s.m/s2"
    debugParse "6 m"
    debugParse "7 kg.m2/s"

    debugAdd("2 m", "4 m")
    debugAdd("2 m", "3 yd")
    debugAdd("3 yd", "2 m")
    debugAdd("2 cm", "4 m")

    echo $(static &"3 m")
    # debugAdd("2 m", "4 s")

    # debugMul("3 m", "4 m")
    # debugMul("3 m", "4 s")
    # debugMul("3 m", "4 m/s")
    # debugMul("3 m2", "4 m")
