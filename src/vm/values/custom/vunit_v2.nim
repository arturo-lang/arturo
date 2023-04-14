#=======================================
# Libraries
#=======================================

import macros, math, parseutils, sequtils, strutils, tables, std/sets

import vm/values/custom/vrational

#=======================================
# Types
#=======================================

type
    UnitPrefix = enum
        PQuecto = (-30, "q")
        PRonto  = (-27, "r")
        PYocto  = (-24, "y")
        PZepto  = (-21, "z")
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
        PZetta  = ( 21, "Z")
        PYotta  = ( 24, "Y")
        PRonna  = ( 27, "R")
        PQuetta = ( 30, "Q")

        PError  = ( 50, "error")

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

        UError = "error"

    UnitTypeObj = (UnitPrefix, UnitType, UnitFamily)

    UnitComponent = object
        #p: UnitPrefix
        e: UnitExponent
        t: UnitTypeObj

    VUnit = OrderedSet[UnitComponent]

    Quantity = ref object
        value: VRational
        unit: VUnit

    FamilyComponent = (UnitExponent, UnitFamily)

    VFamily = (UnitFamily, openArray[FamilyComponent])

    QuantityObj = typeof(Quantity()[])

const 
    units = {
        M: (1.0, FLength),
        IN: (0.0254, FLength),
        FT: (0.3048, FLength)
    }

# Benchmarking
{.hints: on.} # Apparently we cannot disable just `Name` hints?
{.hint: "Quantity's inner type is currently " & $sizeof(QuantityObj) & ".".}
{.hint: "VUnit's inner type is currently " & $sizeof(VUnit) & ".".}
{.hint: "UnitComponent's inner type is currently " & $sizeof(UnitComponent) & ".".}
{.hints: off.}

const
    UnitExponentStrings = ["⁻³", "⁻²", "⁻¹", "", "", "²", "³", "⁴", "⁵", "error"]
    EError = 6.UnitExponent

#=======================================
# Compile-time helpers
#=======================================

func codi(fc: FamilyComponent): uint8 =
    let (e, f) = fc
    result = (abs(ord(e)) shl 5).uint8 or f.uint8
    if ord(e) < 0: result = result or 0x80

func codify(fcs: varargs[FamilyComponent]): uint32 =
    result = 0
    for fc in fcs:
        result = result shl 8
        if fc != (EError, FError):
            result = result or codi(fc)

template `^`(uf: UnitFamily, ue: int): FamilyComponent =
    (UnitExponent(ue), uf)

template xx(): FamilyComponent =
    (EError, FError)

#=======================================
# Definitions
#=======================================

let
    Rules = {
        codify(FLength^2): FArea,
        codify(FLength^3): FVolume,
        codify(FLength^1, FTime^(-1)): FSpeed,
        codify(FLength^1, FTime^(-2)): FAccel,
        codify(FWeight^1, FLength^(-2)): FForce
    }

    Ratios = {
        M: 1 // 1,
        YD: 1143 // 1250,

        G: 1 // 1,

        S: 1 // 1,
        HR: 3600 // 1
    }.toTable

#=======================================
# Macros
#=======================================

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
# Parsers
#=======================================

generateEnumParser(UnitPrefix, PError)
generateEnumParser(UnitType, UError)

func parseQuantity(s: string): Quantity =
    func parsePart(k: string): seq[tuple[pref: UnitPrefix, exp: int, utp: UnitType]] =
        for p in k.split("."):
            result.add((PNone, 1, UError))
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
            if result[^1].utp == UError:
                result[^1].pref = parseUnitPrefix($(tp[0]))
                result[^1].utp = parseUnitType(tp[1..tp.len-1])

    var parts = s.split(" ")
    var f: float
    discard parseFloat(parts[0], f)
    parts = parts[1].split("/")
    var pos = parts[0]
    var neg: string = ""
    if parts.len > 1:
        neg = parts[1]

    var ucs: VUnit

    var parsedUcs = parsePart(pos)
    for (up, pe, ut) in parsedUcs:
        when ucs is seq[UnitComponent]:
            ucs.add(UnitComponent(p: up, e: UnitExponent(pe), t: ut))
        elif ucs is HashSet[UnitComponent]:
            ucs.incl(UnitComponent(p: up, e: UnitExponent(pe), t: ut))

    if neg.len > 0:
        parsedUcs = parsePart(neg)
        for (up, pe, ut) in parsedUcs:
            when ucs is seq[UnitComponent]:
                ucs.add(UnitComponent(p: up, e: UnitExponent(-pe), t: ut))
            elif ucs is HashSet[UnitComponent]:
                ucs.incl(UnitComponent(p: up, e: UnitExponent(-pe), t: ut))
    
    return Quantity(
        value: toRational(f),
        unit: ucs
    )

func `&`(a: string): Quantity =
    parseQuantity(a)

#=======================================
# Helpers
#=======================================

# func typeIndex(vu: VUnit, tp: UnitType): int =
#     when vu is seq[UnitComponent]:
#         for i in 0..vu.len-1:
#             if vu[i].t == tp:
#                 return i
#     elif vu is HashSet[UnitComponent]:
#         for 
#     return -1

func getFamily(ut: UnitType): UnitFamily =
    case ut
        of M, IN, FT, YD, ANG, LY, PC, AU, CHAIN, ROD, FUR, MI, NMI: return FLength
        of AC, ARE, HA: return FArea
        of S,HR: return FTime
        of G: return FWeight
        else:
            discard

func getFamily(uc: UnitComponent): UnitFamily {.inline.} =
    getFamily(uc.t)

#=======================================
# Comparison
#=======================================

func `==`(a: UnitComponent, b: UnitComponent): bool {.inline.} =
    a.p == b.p and a.e == b.e and a.t == b.t

func conforming(auc: UnitComponent, buc: UnitComponent): bool {.inline.} =
    getFamily(auc) == getFamily(buc)

func conforming(a: VUnit, b: VUnit, sameExponents: static bool = false): bool =
    if a.len != b.len:
        return false

    # for i in 0..a.len-1:
    #     when sameExponents:
    #         if (not conforming(a[i], b[i])) or a[i].e != b[i].e:
    #             return false
    #     else:
    #         if not conforming(a[i], b[i]):
    #             return false

    return true

func conforming(a: Quantity, b: Quantity, strict: static bool = false): bool {.inline.} =
    conforming(a.unit, b.unit, sameExponents=strict)

proc ratio*(a: UnitComponent, b: UnitComponent): VRational =
    result = (Ratios[a.t] / Ratios[b.t]) * toRational(pow(10, float(a.p) - float(b.p)))
    if a.e < 0:
        result = 1 / result

proc ratio*(a: VUnit, b: VUnit): VRational =
    var ratio = 1 // 1

    # when VUnit is seq[UnitComponent]:
    #     for i in 0..a.len-1:
    #         ratio *= a[i].ratio(b[i])
    # else:
    #     for i in items(a:
    #         ratio *= i.ratio(b[i])

    return ratio

#=======================================
# Operations
#=======================================

proc convert*(q: Quantity, vu: VUnit): Quantity {.inline.}

func `+`(ea: UnitExponent, eb: UnitExponent): UnitExponent {.inline.} =
    UnitExponent(ord(ea) + ord(eb))

func `-`(ea: UnitExponent, eb: UnitExponent): UnitExponent {.inline.} =
    UnitExponent(ord(ea) - ord(eb))

func `-`(ue: UnitExponent): UnitExponent {.inline.} =
    UnitExponent(-ord(ue))

func `*`(a: VUnit, b: VUnit): VUnit {.inline.} =
    result = a

    # for i in 0..b.len-1:
    #     #let idx = typeIndex(result, b[i].t)
    #     #if idx == -1:
    #         result.add b[i]
        #else:
        #    result[idx].e = result[idx].e + b[i].e

func `/`(a: VUnit, b: VUnit): VUnit {.inline.} =
    result = a

    # for i in 0..b.len-1:
    #     #let idx = typeIndex(result, b[i].t)
    #    # if idx == -1:
    #         result.add b[i]
    #         result[result.len-1].e = -result[result.len-1].e
        #else:
            #result[idx].e = result[idx].e - b[i].e

proc `+`(a: Quantity, b: Quantity): Quantity {.inline.} =
    if not conforming(a, b, strict=true):
        raise newException(ValueError, "Cannot add quantities with different units")

    Quantity(
        value: a.value + convert(b, a.unit).value,
        unit: a.unit
    )

proc `-`(a: Quantity, b: Quantity): Quantity {.inline.} =
    if not conforming(a, b, strict=true):
        raise newException(ValueError, "Cannot subtract quantities with different units")

    Quantity(
        value: a.value - convert(b, a.unit).value,
        unit: a.unit
    )

func `*`(q: Quantity, a: float): Quantity {.inline.} =
    Quantity(
        value: q.value * toRational(a),
        unit: q.unit
    )

func `*`(a: float, q: Quantity): Quantity {.inline.} =
    Quantity(
        value: q.value * toRational(a),
        unit: q.unit
    )

func `*`(q: Quantity, a: Quantity): Quantity {.inline.} =
    Quantity(
        value: q.value * a.value,
        unit: q.unit * a.unit
    )

func `/`(q: Quantity, a: float): Quantity {.inline.} =
    Quantity(
        value: q.value / toRational(a),
        unit: q.unit
    )

func `/`(q: Quantity, a: Quantity): Quantity {.inline.} =
    Quantity(
        value: q.value / a.value,
        unit: q.unit / a.unit
    )

#=======================================
# Printing
#=======================================

template `$`(ue: UnitExponent): string =
    UnitExponentStrings[ue + 3]

func `$`(uc: UnitComponent): string {.inline.} =
    result = $uc.p & (if uc.e == 0: "" else: $uc.t & $uc.e)

func `$`(u: VUnit): string {.inline.} =
    var positives: seq[string]
    var negatives: seq[string]

    when VUnit is seq[UnitComponent]:
        for i in 0..u.len-1:
            if u[i].e < 0:
                negatives.add($u[i])
            else:
                positives.add($u[i])
    else:
        for i in items(u):
            if i.e < 0:
                negatives &= $i
            else:
                positives &= $i

    if positives.len > 0:
        let negs = negatives.map(proc(s: string): string = s.replace("⁻","").replace("¹","")).join("·")
        result = positives.join("·") & (if negs.len > 0: "/" & negs else: "")
    else:
        result = negatives.join("·")

func `$`(q: Quantity): string {.inline.} =
    try:
        result = $(toFloat(q.value)) & " " & $q.unit
    except ValueError:
        result = $(q.value) & " " & $q.unit

#=======================================
# Testing
#=======================================

proc convert*(q: Quantity, vu: VUnit): Quantity {.inline.} =
    if not conforming(q.unit, vu):
        raise newException(ValueError, "Cannot convert between incompatible units")

    result = Quantity(
        value: q.value * ratio(q.unit, vu),
        unit: vu
    )
    echo $(q) & " to " & $(vu) & " ~> " & $(result)

template Q(v: float, pr: UnitPrefix, tp: UnitType, ex: UnitExponent): Quantity =
    Quantity(value: toRational(v), unit: @[UnitComponent(p: pr, e: ex, t: tp)])

template Q(v: float, uc: varargs[UnitComponent]): Quantity =
    when VUnit is seq[UnitComponent]:
        Quantity(value: toRational(v), unit: VUnit(@uc))
    else:
        Quantity(value: toRational(v), unit: VUnit(toHashSet(uc)))

when isMainModule:

    # import helpers/benchmark
    # import strutils

    # template bmark(ttl:string, action:untyped):untyped =
    #     echo "----------------------"
    #     echo ttl
    #     echo "----------------------"
    #     benchmark "":
    #         for i in 1..100_000:
    #             action

    # bmark "parseUnitPrefix":
    #     let x = parseUnitPrefix("a")
    #     let y = parseUnitPrefix("m")
    #     let z = parseUnitPrefix("da")
    #     #let k = $(z)

    # let k = parseUnitPrefix("u")
    # echo $(k)
    # echo $(ord(k))

    let xM = UnitComponent(p: PNone, e: 1, t: M)
    let xS = UnitComponent(p: PNone, e: 1, t: S)
    let xKM = UnitComponent(p: PKilo, e: 1, t: M)
    let xMS = UnitComponent(p: PMilli, e: 1, t: S)
    let xHR = UnitComponent(p: PNone, e: 1, t: HR)
    let xYD = UnitComponent(p: PNone, e: 1, t: YD)
    let xM2 = UnitComponent(p: PNone, e: 2, t: M)
    let xM3 = UnitComponent(p: PNone, e: 3, t: M)

    let perS = UnitComponent(p: PNone, e: -1, t: S)
    let perHR = UnitComponent(p: PNone, e: -1, t: HR)

    # discard (Q(1, xM)).convert(@[xKM])
    # discard (Q(1, xKM)).convert(@[xM])
    # discard (Q(1, xYD)).convert(@[xM])
    # discard (Q(1, xM)).convert(@[xYD])
    # discard (Q(1, xMS)).convert(@[xS])
    # discard (Q(1, xS)).convert(@[xMS])
    # discard (Q(1, xM, perS)).convert(@[xKM, perHR])
    # discard (Q(1, xM, perS)).convert(@[xKM, perS])
    # discard (Q(1, xYD, perS)).convert(@[xYD, perHR])
    # discard (Q(1, xYD, perS)).convert(@[xM, perS])
    # discard (Q(1, xYD, perS)).convert(@[xKM, perHR])
    # discard (Q(1, xM, perS)).convert(@[xM, perHR])
    # discard (Q(1, xM, perHR)).convert(@[xM, perS])
    # discard (Q(1, xKM, perS)).convert(@[xKM, perHR])
    # discard (Q(1, xYD, perS)).convert(@[xYD, perHR])
    # discard (Q(1, xM, perHR)).convert(@[xM, perS])
    # discard (Q(1, xKM, perHR)).convert(@[xKM, perS])

    # let sqm2 = Q(2, xM) * Q(3, xM)
    # echo "2m * 3m = " & $(sqm2)

    # let sqm3 = Q(2, xM) * Q(3, xM) * Q(4, xM)
    # echo "2m * 3m * 4m = " & $(sqm3)

    # let sqm4 = Q(2, xM) * Q(3, xM) * Q(4, xM) * Q(5, xM)
    # echo "2m * 3m * 4m * 5m = " & $(sqm4)

    # let sqm5 = Q(2, xM) * Q(3, xM) * Q(4, xM) * Q(5, xM) * Q(6, xM)
    # echo "2m * 3m * 4m * 5m * 6m = " & $(sqm5)

    # let sqm6 = Q(2, xM2) * Q(3, xM)
    # echo "2m^2 * 3m = " & $(sqm6)

    # let sqm7 = Q(2, xM) * Q(3, xM2)
    # echo "2m * 3m^2 = " & $(sqm7)

    # echo "2m + 3m = " & $(Q(2, xM) + Q(3, xM))
    # echo "2m + 1yd = " & $(Q(2, xM) + Q(1, xYD))
    # echo "2m/s + 3m/s = " & $(Q(2, xM, perS) + Q(3, xM, perS))
    # echo "2m/s + 3m/hr = " & $(Q(2, xM, perS) + Q(3, xM, perHR))

    # echo $(&"2.34 m.g/s.m")

    echo $(&"1.2 m/s")
    echo $(&"1.2 m/s")
    echo $(&"1.2 m/s2")
    echo $(&"1.2 m/s2")
    echo $(&"1.2 m2/s")
    echo $(&"1.2 m2/s")
    echo $(&"1.2 m2/s2")
    echo $(&"1.2 m2/s2")
    echo $(&"1.2 m2/s3")
    echo $(&"1.2 m2/s3")
    echo $(&"1.2 m3/s")
    echo $(&"1.2 m3/s")
    echo $(&"1.2 m3/s2")
    echo $(&"1.2 m3/s2")
    echo $(&"1.2 m3/s3")
    echo $(&"1.2 m3/s3")

    echo $(&"1.2 m/s")
    echo $(&"1.2 m/s")
    echo $(&"1.2 m/s2")
    echo $(&"1.2 m/s2")
    echo $(&"1.2 m2/s")
    echo $(&"1.2 m2/s")
    echo $(&"1.2 m2/s2")
    echo $(&"1.2 m2/s2")
    echo $(&"1.2 m2/s3")
    echo $(&"1.2 m2/s3")
    echo $(&"1.2 m3/s")
    echo $(&"1.2 m3/s")
    echo $(&"1.2 m3/s2")
    echo $(&"1.2 m3/s2")
    echo $(&"1.2 m3/s3")
    echo $(&"1.2 m3/s3")

    echo $(units)


    # let z = toHashSet([xM2, xS])
    # let y = toHashSet([xS, xM2])
    # echo $(z == y)
    # echo $(z)