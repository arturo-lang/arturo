import macros, math, parseutils
import sequtils, strutils, sugar, tables

import vm/values/custom/vrational

type
    # CAREFUL:
    # The order matters! It's used for the signature calculation
    # by `getQuantityType`.

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

    Unit = enum
        M = "m",
        S = "s",
        HR = "hr",
        IN = "in",
        FT = "ft",
        UError = "unit-error"

    UnitKind = enum
        KLength             = "Length"
        KTime               = "Time"
        KTemperature        = "Temperature"
        KMass               = "Mass"
        KCurrent            = "Current"
        KSubstance          = "Substance"
        KLuminosity         = "Luminosity"
        KCurrency           = "Currency"
        KInformation        = "Information"
        KAngle              = "Angle"
    
    QuantityType = enum
        TAcceleration       = "Acceleration"
        TActivity           = "Activity"
        TAngle              = "Angle"
        TAngularMomentum    = "Angular Momentum"
        TAngularVelocity    = "Angular Velocity"
        TArea               = "Area"
        TAreaDensity        = "Area Density"
        TCapacitance        = "Capacitance"
        TCharge             = "Charge"
        TConductance        = "Conductance"
        TCurrency           = "Currency"
        TCurrent            = "Current"
        TDensity            = "Density"
        TElastance          = "Elastance"
        TEnergy             = "Energy"
        TForce              = "Force"
        TFrequency          = "Frequency"
        TIlluminance        = "Illuminance"
        TInductance         = "Inductance"
        TInformation        = "Information"
        TJolt               = "Jolt"
        TLength             = "Length"
        TLuminousPower      = "Luminous Power"
        TMagnetism          = "Magnetism"
        TMass               = "Mass"
        TMolarConcentration = "Molar Concentration"
        TMomentum           = "Momentum"
        TPotential          = "Potential"
        TPower              = "Power"
        TPressure           = "Pressure"
        TRadiation          = "Radiation"
        TRadiationExposure  = "Radiation Exposure"
        TResistance         = "Resistance"
        TSnap               = "Snap"
        TSpecificVolume     = "Specific Volume"
        TSpeed              = "Speed"
        TSubstance          = "Substance"
        TTemperature        = "Temperature"
        TTime               = "Time"
        TUnitless           = "Unitless"
        TViscosity          = "Viscosity"
        TVolume             = "Volume"
        TVolumetricFlow     = "Volumetric Flow"
        TWaveNumber         = "Wave Number"
        TYank               = "Yank"

        TUnknown            = "Unknown Quantity type"

    QuantityTypeSignature = int64

    UnitArray = seq[Unit]
    Units = tuple
        n: UnitArray
        d: UnitArray

    Quantity = tuple
        value: float
        converted: float
        tp: QuantityType
        units: Units
        base: bool

{.hints: on.} # Apparently we cannot disable just `Name` hints?
#{.hint: "Quantity's inner type is currently " & $sizeof(VQuantityObj) & ".".}
{.hint: "Quantity's inner type is currently " & $sizeof(Quantity) & ".".}
{.hints: off.}

const
    BaseUnits = [M, S]
    QuantityTypeSignatures = {
        int64(-312_078)         : TElastance,
        int64(-312_058)         : TResistance,
        int64(-312_038)         : TInductance,
        int64(-152_058)         : TPotential,
        int64(-152_040)         : TMagnetism,
        int64(-152_038)         : TMagnetism,
        int64(-7997)            : TSpecificVolume,
        int64(-79)              : TSnap,
        int64(-59)              : TJolt,
        int64(-39)              : TAcceleration,
        int64(-38)              : TRadiation,
        int64(-20)              : TFrequency,
        int64(-19)              : TSpeed,
        int64(-18)              : TViscosity,
        int64(-17)              : TVolumetricFlow,
        int64(-1)               : TWavenumber,
        int64(0)                : TUnitless,
        int64(1)                : TLength,
        int64(2)                : TArea,
        int64(3)                : TVolume,
        int64(20)               : TTime,
        int64(400)              : TTemperature,
        int64(7941)             : TYank,
        int64(7942)             : TPower,
        int64(7959)             : TPressure,
        int64(7961)             : TForce,
        int64(7962)             : TEnergy,
        int64(7979)             : TViscosity,
        int64(7981)             : TMomentum,
        int64(7982)             : TAngularMomentum,
        int64(7997)             : TDensity,
        int64(7998)             : TAreaDensity,
        int64(8000)             : TMass,
        int64(152_020)          : TRadiationExposure,
        int64(159_999)          : TMagnetism,
        int64(160_000)          : TCurrent,
        int64(160_020)          : TCharge,
        int64(312_058)          : TConductance,
        int64(312_078)          : TCapacitance,
        int64(3_199_980)        : TActivity,
        int64(3_199_997)        : TMolarConcentration,
        int64(3_200_000)        : TSubstance,
        int64(63_999_998)       : TIlluminance,
        int64(64_000_000)       : TLuminousPower,
        int64(1_280_000_000)    : TCurrency,
        int64(25_600_000_000)   : TInformation,
        int64(511_999_999_980)  : TAngularVelocity,
        int64(512_000_000_000)  : TAngle
    }.toTable

    UnitKinds = {
        M: KLength,
        IN: KLength,
        FT: KLength,
        S: KTime,
        HR: KTime,
    }.toTable

    Unity = 1.0

func parseQuantity(s: string): Quantity
func newQuantity(v: float, units: Units): Quantity

# const

#     UnitDefinitions= {
#         "M": parseQuantity("1 m"),
#         "IN": parseQuantity("127/5000 m")
#     }.toTable



#     RubyUnits::Unit.define('meter') do |unit|
#   unit.scalar    = 1
#   unit.numerator = %w[<meter>]
#   unit.aliases   = %w[m meter meters metre metres]
#   unit.kind      = :length
# end

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

generateEnumParser(UnitPrefix, PError)
generateEnumParser(Unit, UError)

template getTypeBySignature(signature: QuantityTypeSignature): QuantityType =
    QuantityTypeSignatures.getOrDefault(signature, TUnknown)

func getQuantityType(units: Units): QuantityType =
    var vector = newSeq[int64](ord(UnitKind.high) + 1)
    for unit in units.n:
        vector[ord(UnitKinds[unit])] += 1
    for unit in units.d:
        vector[ord(UnitKinds[unit])] -= 1

    for index, item in vector:
        vector[index] = item * (int(pow(float(20),float(index))))

    return getTypeBySignature(vector.foldl(a + b, int64(0)))

proc debugGetType(units: Units) =
    echo "getting signature for: "
    echo "    - numerator: " & (if units.n.len == 0: "--" else: units.n.map((x) => $(x)).join(" * "))
    echo "    - denominator: " & (if units.d.len == 0: "--" else: units.d.map((x) => $(x)).join(" * "))

    echo "    = " & $(getQuantityType(units))
    echo "--------------------------------"

func parseUnits(s: string): Units =
    func parsePart(k: string): UnitArray =
        for p in k.split("."):
            var tp = ""
            var i = 0
            while i < p.len and p[i] notin {'1','2','3','4','5'}:
                tp.add p[i]
                i += 1
            
            var exp = 1
            if p.len > i:
                discard parseInt(p[i..p.len-1], exp)

            let utp = parseUnit(tp)

            for i in 0 ..< exp:
                result.add(utp)

    let parts = s.split("/")

    var pos, neg: UnitArray

    if parts.len > 0:
        pos = parsePart(parts[0])
    if parts.len > 1:
        neg = parsePart(parts[1])

    result = (
        n: pos,
        d: neg
    )

# func `$`(q: Units): string =
#     $(q[])

func checkIfBase(units: Units): bool =
    for unit in units.n:
        if not BaseUnits.contains(unit):
            return false
    for unit in units.d:
        if not BaseUnits.contains(unit):
           return false

    return true

var
    derivedQuantities {.compileTime.}: Table[Unit, Quantity]

proc newDerivedQuantity(v: float, units: Units): Quantity =
    result = (
        value: v,
        converted: v,
        tp:  getQuantityType(units),
        units: units,
        base: checkIfBase(units)
    )
    if not result.base:
        for unit in units.n:
            if derivedQuantities.contains(unit):
                result.converted *= derivedQuantities[unit].converted

        for unit in units.d:
            if derivedQuantities.contains(unit):
                result.converted /= derivedQuantities[unit].converted

proc derived(s: string): Quantity =
    let parts = s.split(" ")
    if parts.len == 2:
        let numparts = parts[0].split("/")
        let units = parseUnits(parts[1])

        var value: float
        if numparts.len > 1:
            value = toFloat(initRational(parseInt(numparts[0]), parseInt(numparts[1])))
        else:
            value = parseFloat(numparts[0])
        
        result = newDerivedQuantity(value, units)
    else:
        let units = parseUnits(s)
        result = newDerivedQuantity(Unity, units)

var
    CTBaseUnits {.compileTime.}: seq[string]
    CTUnitList {.compileTime.}: seq[(string,string)]
    CTUnitAliases {.compileTime.}: Table[string, string]
    CTUnitKinds {.compileTime.}: Table[string, UnitKind]
    CTDerivedUnits {.compileTime.}: Table[string, Quantity]

proc define(unit: string, name: string, aliases: seq[string], definition: UnitKind | string) {.compileTime.} =
    CTUnitList.add(("U" & unit, name))

    for alias in aliases:
        CTUnitAliases[alias] = unit

    when definition is UnitKind:
        CTBaseUnits.add(unit)
        CTUnitKinds[unit] = definition
    else:
        CTDerivedUnits[unit] = derived(definition)

static:
    define("M", "m", @["meter", "metre", "meters", "metres"], KLength)
    define("G", "g", @["gram", "grams"], KMass)
    define("S", "s", @["second", "seconds"], KTime)
    define("A", "A", @["ampere", "amperes", "amp", "amps"], KCurrent)
    define("K", "K", @["kelvin", "kelvins"], KTemperature)
    define("MOL", "mol", @["mole", "moles"], KSubstance)
    define("CD", "cd", @["candela", "candelas"], KLuminosity)

    define("IN", "in", @["inch", "inches"], "127/5000 m")
    define("FT", "ft", @["foot", "feet"], "12 in")
    define("HR", "hr", @["hour", "hours"], "3600 s")

    echo $(CTDerivedUnits)

macro getUnits(): untyped =
    result = nnkEnumTy.newTree(
        newEmptyNode()
    )

    for (un, name) in CTUnitList:
        result.add nnkEnumFieldDef.newTree(
            newIdentNode(un),
            newLit(name)
        )

type
    CTUnit = getUnits()

template defineU(unit: Unit, definition: string): (Unit, Quantity) =
    let res = derived(definition)
    derivedQuantities[unit] = res
    (unit, res)

const
    UnitDefinitions = [
        defineU(IN, "127/5000 m"),
        defineU(FT, "12 in"),
        defineU(HR, "3600 s")
    ].toTable

func newQuantity(v: float, tp: QuantityType, units: Units, base: bool): Quantity =
    result = (
        value: v,
        converted: v,
        tp: tp,
        units: units,
        base: base
    )

func newQuantity(v: float, units: Units): Quantity =
    result = (
        value: v,
        converted: v,
        tp:  getQuantityType(units),
        units: units,
        base: checkIfBase(units)
    )
    if not result.base:
        for unit in units.n:
            if UnitDefinitions.contains(unit):
                result.converted *= UnitDefinitions[unit].converted

        for unit in units.d:
            if UnitDefinitions.contains(unit):
                result.converted /= UnitDefinitions[unit].converted

func parseQuantity(s: string): Quantity =
    let parts = s.split(" ")
    if parts.len == 2:
        let numparts = parts[0].split("/")
        let units = parseUnits(parts[1])

        var value: float
        if numparts.len > 1:
            value = toFloat(initRational(parseInt(numparts[0]), parseInt(numparts[1])))
        else:
            value = parseFloat(numparts[0])
        
        result = newQuantity(value, units)
    else:
        let units = parseUnits(s)
        result = newQuantity(Unity, units)

func `+`(a, b: Quantity): Quantity =
    if a.tp == b.tp:
        result = newQuantity(a.converted + b.converted, a.tp, a.units, a.base)
    else:
        debugEcho "cannot add incompatible types"

func `-`(a, b: Quantity): Quantity =
    if a.tp == b.tp:
        result = newQuantity(a.converted - b.converted, a.tp, a.units, a.base)
    else:
        debugEcho "cannot subtract incompatible types"

func `*`(a, b: Quantity): Quantity =
    let newUnits = (n: a.units.n & b.units.n, d: a.units.d & b.units.d)
    result = newQuantity(a.converted * b.converted, getQuantityType(newUnits), newUnits, a.base and b.base)

# func `/`(a, b: Quantity): Quantity =
#     let newUnits = (n: a.units.n.remove(b.units.d), d: a.units.d & b.units.n)
#     result = newQuantity(a.converted / b.converted, getQuantityType(newUnits), newUnits, a.base and b.base)

func print(q: Quantity): string =
    result.add $(q.value) & " "
    var tbl = initCountTable[Unit]()
    for c in q.units.n:
        tbl.inc(c)

    var pos: seq[string]
    for k, v in tbl:
        var part = $(k)
        if v > 1:
            case v:
                of 2: part.add "²"
                of 3: part.add "³"
                else:
                    part.add "^" & $(v)
        pos.add(part)

    tbl = initCountTable[Unit]()
    for c in q.units.d:
        tbl.inc(c)

    var neg: seq[string]
    for k, v in tbl:
        var part = $(k)
        if v > 1:
            case v:
                of 2: part.add "²"
                of 3: part.add "³"
                else:
                    part.add "^" & $(v)
        neg.add(part)

    result &= pos.join("·")
    if neg.len > 0:
        result &= "/" & neg.join("·")

proc debugAdd(str: varargs[string]) =
    let qa = parseQuantity(str[0])
    let qb = parseQuantity(str[1])

    echo print(qa) & " + " & print(qb) & " = " & print(qa + qb)

proc debugSub(str: varargs[string]) =
    let qa = parseQuantity(str[0])
    let qb = parseQuantity(str[1])

    echo print(qa) & " - " & print(qb) & " = " & print(qa - qb)

proc debugMul(str: varargs[string]) =
    let qa = parseQuantity(str[0])
    let qb = parseQuantity(str[1])

    echo print(qa) & " * " & print(qb) & " = " & print(qa * qb)


when isMainModule:
    let pu1 = parseUnits("m/s")
    debugGetType(pu1)
    let pu2 = parseUnits("m/s2")
    debugGetType(pu2)

    echo $(parseQuantity("3 m/s"))

    echo $(parseQuantity("127/5000 m"))
    echo $(parseQuantity("5 in"))

    echo $(parseQuantity("2 m2"))
    echo $(parseQuantity("2 m3"))

    echo $(parseQuantity("2 in2"))
    echo $(parseQuantity("2 in3"))

    echo $(UnitDefinitions)

    echo "-----------------------------"

    debugAdd "2 m", "3 m"
    debugAdd "2 m", "3 in"

    debugAdd "2 m/s", "3 m/s"
    debugAdd "2 m/s", "3 in/s"
    debugAdd "3 m/s", "2000 m/hr"
    echo $(parseQuantity("5000 in"))
    debugAdd "3 m/s", "50000 in/hr"
    debugAdd "3 m/s", "1270 m/hr"
    echo $(parseQuantity("5 ft"))
    debugAdd "3 m", "5 ft"

    for ctunit in items(CTUnit):
        echo $(ctunit)