#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: vm/values/custom/vquantity.nim
#=======================================================

## The internal `:quantity` & `:unit` types

#=======================================
# Libraries
#=======================================

import algorithm, std/enumutils, math, parseutils, sequtils, strutils, tables

when not defined(WEB):
    import asyncdispatch, httpClient, std/json

when defined(GMP):
    import helpers/bignums as BignumsHelper

import vm/values/custom/vrational
import vm/errors

#=======================================
# Includes
#=======================================

include quantities/definitions

#=======================================
# Compile-time Configuration
#=======================================

const
    useAtomsCache = true

#=======================================
# Types
#=======================================

type
    # private

    AtomExponent        = -5..5
    QuantityValue       = VRational
    QuantitySignature   = int64

    Prefix          = generatePrefixDefinitions()
    CoreUnit        = generateUnitDefinitions()

    SubUnitKind = enum
        Core
        User

    SubUnit = object
        case kind: SubUnitKind:
            of Core:
                core: CoreUnit
            of User:
                name: string

    PrefixedUnit = tuple
        p: Prefix
        u: SubUnit

    Atom = tuple
        unit: PrefixedUnit
        power: AtomExponent

    Atoms = seq[Atom]

    Quantity = tuple
        original        : QuantityValue
        value           : QuantityValue
        signature       : QuantitySignature
        atoms           : Atoms
        base            : bool
        withUserUnits   : bool

    # public

    VUnit* = Atoms
    VQuantity* = Quantity

#=======================================
# Compile-Time Warnings
#=======================================

when sizeof(Quantity) > 48:
    {.warning: "Quantity's inner object is large which will impact performance".}
    {.hints: on.}
    {.hint: "Quantity's inner type is currently " & $sizeof(Quantity) & ".".}
    {.hints: off.}

#=======================================
# Constants
#=======================================

const
    AtomExponents = ["⁻⁵", "⁻⁴", "⁻³", "⁻²", "⁻¹", "", "", "²", "³", "⁴", "⁵"]
    NoUnitFound {.used.} = getNoUnitFound() 

let
    Powers = [
        1 // int(pow(10.0,18.0)), 0 // 1, 0 // 1,
        1 // int(pow(10.0,15.0)), 0 // 1, 0 // 1,
        1 // int(pow(10.0,12.0)), 0 // 1, 0 // 1,
        1 // int(pow(10.0,9.0)), 0 // 1, 0 // 1,
        1 // int(pow(10.0,6.0)), 0 // 1, 0 // 1,
        1 // int(pow(10.0,3.0)), 1 // 100, 1 // 10, 
        1 // 1, 10 // 1, 100 // 1, 
        int(pow(10.0,3.0)) // 1, 0 // 1, 0 // 1,
        int(pow(10.0,6.0)) // 1, 0 // 1, 0 // 1,
        int(pow(10.0,9.0)) // 1, 0 // 1, 0 // 1,
        int(pow(10.0,12.0)) // 1, 0 // 1, 0 // 1,
        int(pow(10.0,15.0)) // 1, 0 // 1, 0 // 1,
        int(pow(10.0,18.0)) // 1
    ]

#=======================================
# Variables
#=======================================

var
    AtomsCache {.used.} : Table[string,Atoms]

    Properties          : Table[QuantitySignature, string]
    Quantities          : Table[SubUnit, Quantity]
    UserUnits           : Table[string, string]

    LastSignature       : QuantitySignature = int(pow(6.0,11.0))
    SignatureStep       : QuantitySignature = int(pow(6.0,20.0))

    ExchangeRates       : Table[string, float]

#=======================================
# Useful Constants
#=======================================

generateConstantDefinitions()

#=======================================
# Forward declarations
#=======================================

proc toQuantity*(vstr: string, atoms: Atoms): Quantity
proc `$`*(q: Quantity): string 
proc inspect*(q: Quantity)

#=======================================
# Helpers
#=======================================

func copyQuantity*(q: Quantity): Quantity =
    (
        original: copyRational(q.original),
        value: copyRational(q.value),
        signature: q.signature,
        atoms: q.atoms,
        base: q.base,
        withUserUnits: q.withUserUnits
    )

func `==`(a, b: SubUnit): bool =
    if a.kind != b.kind: return false
    return
        case a.kind:
            of Core: a.core == b.core
            of User: a.name == b.name

# NOT USED

# func isUnitless(q: Quantity): bool {.inline.} =
#     return q.signature == 0

func isCurrency(q: Quantity): bool {.inline.} =
    return q.signature == (static parsePropertyFormula("C"))

func isTemperature(q: Quantity): bool {.inline.} =
    return q.signature == (static parsePropertyFormula("K"))

proc getExchangeRate(curr: string): float =
    let s = toLowerAscii(curr)
    if ExchangeRates.len == 0:
        when not defined(WEB):
            let url = "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.min.json"
            let content = waitFor (newAsyncHttpClient().getContent(url))
            let response = parseJson(content)
            for (k,v) in pairs(response["usd"]):
                if likely(v.kind == JFloat):
                    ExchangeRates[k] = v.fnum
                else:
                    ExchangeRates[k] = float(v.num)

    return ExchangeRates[s]

proc getPrimitive(unit: PrefixedUnit): Quantity =
    result = copyQuantity(Quantities[unit.u])
    if unlikely(result.isCurrency() and isZero(result.value)):
        let xrate = getExchangeRate((symbolName(unit.u.core)).replace("_CoreUnit",""))
        Quantities[unit.u].value = reciprocal(toRational(xrate))
        result.value = reciprocal(toRational(xrate))
    elif unit.p != No_Prefix:
        result.value *= Powers[ord(unit.p) + 18]

proc getSignature*(atoms: Atoms): QuantitySignature =
    for atom in atoms:
        let prim = getPrimitive(atom.unit)
        result += prim.signature * atom.power

proc getValue(atoms: Atoms): QuantityValue =
    result = 1//1
    for atom in atoms:
        let prim = getPrimitive(atom.unit)
        result *= prim.value ^ atom.power

proc flatten*(atoms: Atoms): Atoms =
    var cnts: OrderedTable[PrefixedUnit, int]

    for atom in atoms:
        if cnts.hasKeyOrPut(atom.unit, atom.power):
            cnts[atom.unit] += atom.power

    for (unit, power) in pairs(cnts):
        if power != 0:
            result.add (unit: unit, power: AtomExponent(power))

proc reverse*(atoms: Atoms): Atoms =
    for atom in atoms:
        result.add (unit: atom.unit, power: AtomExponent(-atom.power))

proc unitAlaCarte*(str: string): PrefixedUnit = 
    let subu = SubUnit(kind: User, name: str)
    
    result = (No_Prefix, subu)

    var newQuantity = toQuantity("1", @[])
    newQuantity.signature = LastSignature
    newQuantity.base = true
    LastSignature += SignatureStep
    Quantities[subu] = newQuantity
    UserUnits[str] = str

#=======================================
# Parsers
#=======================================

proc parseSubUnit*(str: string): PrefixedUnit = 
    generateUnitParser()

    if result.u.kind==Core and result.u.core == No_CoreUnit:
        result = unitAlaCarte(str)

proc parseAtoms*(str: string): Atoms = 
    proc parseAtom(at: string, denominator: static bool=false): Atom =
        var i = 0
        var unitStr: string
        while i < at.len and at[i] notin '2'..'9':
            unitStr.add at[i]
            inc i

        result.unit = parseSubUnit(unitStr)
        result.power = 1
        if i < at.len:
            result.power = parseInt(at[i..^1])

        when denominator:
            result.power = -result.power

    when useAtomsCache:
        if AtomsCache.hasKey(str):
            return AtomsCache[str]

    let parts = str.split("/")

    if parts[0].len > 0:
        for atomStr in parts[0].split("."):
            if atomStr != "1":
                result.add parseAtom(atomStr)

    if parts.len > 1:
        for atomStr in parts[1].split("."):
            result.add parseAtom(atomStr, denominator=true)

    when useAtomsCache:
        AtomsCache[str] = result

#=======================================
# Constructors
#=======================================

proc toQuantity*(v: QuantityValue, atoms: Atoms): Quantity =
    result.original = copyRational(v)
    result.value = copyRational(v)

    for atom in atoms:
        let prim = getPrimitive(atom.unit)
        result.signature += prim.signature * atom.power
        result.value *= prim.value ^ atom.power

        if unlikely(atom.unit.u.kind == User):
            result.withUserUnits = true

        result.atoms.add(atom)

when defined(GMP):
    proc toQuantity*(v: int | float | Int, atoms: Atoms): Quantity {.inline.} =
        result = toQuantity(toRational(v), atoms)
else:
    proc toQuantity*(v: int | float, atoms: Atoms): Quantity {.inline.} =
        result = toQuantity(toRational(v), atoms)

proc parseValue(s: string): QuantityValue =
    if s.contains("."):
        result = toRational(parseFloat(s))
    elif s.contains(":"):
        let ratParts = s.split(":")
        try:
            result = toRational(parseInt(ratparts[0]), parseInt(ratparts[1]))
        except ValueError:
            when defined(GMP):
                result = toRational(newInt(ratparts[0]), newInt(ratparts[1]))
    else:
        try:
            result = toRational(parseInt(s))
        except ValueError:
            when defined(GMP):
                result = toRational(newInt(s))

proc toQuantity*(str: string): Quantity =
    let parts = str.split(" ")

    # Warning: we should be able to parse rational numbers as well!
    let value = parseValue(parts[0])
    let atoms = parseAtoms(parts[1])

    result = toQuantity(value, atoms)

proc toQuantity*(vstr: string, atoms: Atoms): Quantity =
    # used mainly for the constants!
    result = toQuantity(parseValue(vstr), atoms)

#=======================================
# Methods
#=======================================

proc getProperty*(q: Quantity): string =
    Properties.getOrDefault(q.signature, "Unknown").toLowerAscii()

proc getProperty*(atoms: Atoms): string =
    Properties.getOrDefault(getSignature(atoms), "Unknown").toLowerAscii()

proc convertTemperature*(v: QuantityValue, fromU: CoreUnit, toU: CoreUnit): QuantityValue =
    if fromU == toU:
        return v

    if fromU == K_CoreUnit:
        if toU == degC_CoreUnit:
            result = v - 273.15
        elif toU == degF_CoreUnit:
            result = v * (9//5) - 459.67
        elif toU == degR_CoreUnit:
            result = v * (9//5)
    elif fromU == degC_CoreUnit:
        if toU == K_CoreUnit:
            result = v + 273.15
        elif toU == degF_CoreUnit:
            result = v * (9//5) + 32
        elif toU == degR_CoreUnit:
            result = (v + 273.15) * (9//5)
    elif fromU == degF_CoreUnit:
        if toU == K_CoreUnit:
            result = (v + 459.67) * (5//9)
        elif toU == degC_CoreUnit:
            result = (v - 32) * (5//9)
        elif toU == degR_CoreUnit:
            result = v + 459.67
    elif fromU == degR_CoreUnit:
        if toU == K_CoreUnit:
            result = v * (5//9)
        elif toU == degC_CoreUnit:
            result = (v - 491.67) * (5//9)
        elif toU == degF_CoreUnit:
            result = v - 459.67

proc convertTo*(q: Quantity, atoms: Atoms): Quantity =
    if q.signature != getSignature(atoms):
        Error_CannotConvertDifferentDimensions(getProperty(q), getProperty(atoms))

    if q.atoms == atoms:
        return q

    result = toQuantity(q.value/getValue(atoms), atoms)

proc convertQuantity*(q: Quantity, atoms: Atoms): Quantity =
    if unlikely(isTemperature(q)):
        if q.signature != getSignature(atoms):
            Error_CannotConvertDifferentDimensions(getProperty(q), getProperty(atoms))
        
        result = toQuantity(convertTemperature(q.original, q.atoms[0].unit.u.core, atoms[0].unit.u.core), atoms)
    else:
        result = q.convertTo(atoms)

proc toBase*(q: Quantity): Atoms =
    for atom in q.atoms:
        let prim = getPrimitive(atom.unit)
        if prim.base:
            result.add atom
            continue
        else:
            result.add toBase(prim)

proc toBase*(atoms: Atoms): Atoms =
    for atom in atoms:
        let prim = getPrimitive(atom.unit)
        if prim.base:
            result.add atom
            continue
        else:
            result.add toBase(prim)

proc getBaseUnits*(q: Quantity): Atoms =
    result = flatten(toBase(q))

proc getBaseUnits*(atoms: Atoms): Atoms =
    result = flatten(toBase(atoms))

proc defineNewUserUnit*(name: string, symbol: string, description: string, definition: string) =
    UserUnits[name] = symbol
    let q = toQuantity(definition)
    Quantities[SubUnit(kind: User, name: name)] = q
    Properties[q.signature] = description

proc defineNewUserUnit*(name: string, symbol: string, description: string, definition: Quantity) =
    UserUnits[name] = symbol
    Quantities[SubUnit(kind: User, name: name)] = definition
    Properties[definition.signature] = description

proc defineNewUserUnit*(name: string, symbol: string, description: string, definition: Atoms) =
    UserUnits[name] = symbol
    let q = toQuantity(1, definition)
    Quantities[SubUnit(kind: User, name: name)] = q
    Properties[q.signature] = description

proc defineNewProperty*(name: string, definition: Quantity) =
    Properties[definition.signature] = name

proc defineNewProperty*(name: string, definition: Atoms) =
    Properties[getSignature(definition)] = name

#=======================================
# Comparison
#=======================================

func `=~`*(a, b: Quantity): bool {.inline.} =
    return a.signature == b.signature

proc `=~`*(a: Quantity, b: Atoms): bool {.inline.} =
    return a.signature == getSignature(b)

proc `=~`*(a: Atoms, b: Quantity): bool {.inline.} =
    return getSignature(a) == b.signature

proc `=~`*(a: Atoms, b: Atoms): bool {.inline.} =
    return getSignature(a) == getSignature(b)

proc `==`*(a, b: Quantity): bool =
    if not (a =~ b):
        return false

    let convB = b.convertTo(a.atoms)

    return a.original == convB.original

func `==`*(a: Quantity, b: int | float | QuantityValue): bool =
    return a.original == b

func `==`*(a: int | float | QuantityValue, b: Quantity): bool =
    return a == b.original

when defined(GMP):
    func `==`*(a: Quantity, b: Int): bool =
        return a.original == b

    func `==`*(a: Int, b: Quantity): bool =
        return a == b.original

proc `<`*(a, b: Quantity): bool =
    if not (a =~ b):
        return false

    let convB = b.convertTo(a.atoms)

    return a.original < convB.original

func `<`*(a: Quantity, b: int | float | QuantityValue): bool =
    return a.original < b

func `<`*(a: int | float | QuantityValue, b: Quantity): bool =
    return a < b.original

when defined(GMP):
    func `<`*(a: Quantity, b: Int): bool =
        return a.original < b

    func `<`*(a: Int, b: Quantity): bool =
        return a < b.original

proc `>`*(a, b: Quantity): bool =
    if not (a =~ b):
        return false

    let convB = b.convertTo(a.atoms)

    return a.original > convB.original

func `>`*(a: Quantity, b: int | float | QuantityValue): bool =
    return a.original > b

func `>`*(a: int | float | QuantityValue, b: Quantity): bool =
    return a > b.original

when defined(GMP):
    func `>`*(a: Quantity, b: Int): bool =
        return a.original > b

    func `>`*(a: Int, b: Quantity): bool =
        return a > b.original

#=======================================
# Operators
#=======================================

proc `+`*(a, b: Quantity): Quantity =
    if not (a =~ b):
        Error_CannotConvertDifferentDimensions(getProperty(a), getProperty(b))

    let convB = b.convertTo(a.atoms)

    result = toQuantity(a.original + convB.original, a.atoms)

proc `+`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original + b, a.atoms)

when defined(GMP):
    proc `+`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original + b, a.atoms)

proc `+=`*(a: var Quantity, b: Quantity) =
    if not (a =~ b):
        Error_CannotConvertDifferentDimensions(getProperty(a), getProperty(b))

    let convB = b.convertTo(a.atoms)

    a.original += convB.original

proc `+=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original += b

when defined(GMP):
    proc `+=`*(a: var Quantity, b: Int) =
        a.original += b

proc `-`*(a, b: Quantity): Quantity =
    if not (a =~ b):
        Error_CannotConvertDifferentDimensions(getProperty(a), getProperty(b))

    let convB = b.convertTo(a.atoms)

    result = toQuantity(a.original - convB.original, a.atoms)

proc `-`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original - b, a.atoms)

when defined(GMP):
    proc `-`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original - b, a.atoms)

proc `-=`*(a: var Quantity, b: Quantity) =
    if not (a =~ b):
        Error_CannotConvertDifferentDimensions(getProperty(a), getProperty(b))

    let convB = b.convertTo(a.atoms)

    a.original -= convB.original

proc `-=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original -= b

when defined(GMP):
    proc `-=`*(a: var Quantity, b: Int) =
        a.original -= b

proc `*`*(a, b: Quantity): Quantity =
    if a =~ b:
        let convB = b.convertTo(a.atoms)
        result = toQuantity(a.original * convB.original, flatten(a.atoms & convB.atoms))
    else:
        result = toQuantity(a.original * b.original, flatten(a.atoms & b.atoms))

proc `*`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original * b, a.atoms)

proc `*`*(a: int | float | QuantityValue, b: Quantity): Quantity =
    result = toQuantity(a * b.original, b.atoms)

when defined(GMP):
    proc `*`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original * b, a.atoms)

    proc `*`*(a: Int, b: Quantity): Quantity =
        result = toQuantity(a * b.original, b.atoms)

proc `*=`*(a: var Quantity, b: Quantity) =
    a = a * b

proc `*=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original *= b

when defined(GMP):
    proc `*=`*(a: var Quantity, b: Int) =
        a.original *= b

proc `/`*(a, b: Quantity): Quantity =
    if a =~ b:
        let convB = b.convertTo(a.atoms)
        result = toQuantity(a.original / convB.original, flatten(a.atoms & reverse(convB.atoms)))
    else:
        result = toQuantity(a.original / b.original, flatten(a.atoms & reverse(b.atoms)))

proc `/`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original / b, a.atoms)

when defined(GMP):
    proc `/`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original / b, a.atoms)

proc `/=`*(a: var Quantity, b: Quantity) =
    a = a / b

proc `/=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original /= b

when defined(GMP):
    proc `/=`*(a: var Quantity, b: Int) =
        a.original /= b

proc `//`*(a: Quantity, b: int | float | Quantity | QuantityValue): Quantity =
    a / b

when defined(GMP):
    proc `//`*(a: Quantity, b: Int): Quantity =
        a / b

proc `//=`*(a: var Quantity, b: int | float | Quantity | QuantityValue) =
    a = a // b

when defined(GMP):
    proc `//=`*(a: var Quantity, b: Int) =
        a = a // b

proc `^`*(a: Quantity, b: int): Quantity =
    result = a

    var i = 1
    while i < b:
        result = result * a
        inc i

proc `^=`*(a: var Quantity, b: int) =
    a = a ^ b

#=======================================
# String converters
#=======================================

func `$`(expo: AtomExponent): string =
    AtomExponents[expo + 5]

proc `$`*(unit: SubUnit): string =
    case unit.kind:
        of Core: $(unit.core)
        of User: UserUnits[unit.name]

proc `$`*(punit: PrefixedUnit): string =
    $(punit.p) & $(punit.u)

proc `$`*(atom: Atom): string =
    $(atom.unit) & $(atom.power)

proc `$`*(atoms: Atoms, oneline: static bool=false): string =
    when not oneline:
        var pos: seq[string]
        var neg: seq[string]

        for atom in atoms:
            if atom.power > 0:
                pos.add $(atom)
            else:
                neg.add $(atom)

        if pos.len > 0:
            result = pos.join("·")

            if neg.len > 0:
                result &= "/" & (neg.join("·")).replace("⁻¹", "").replace("⁻", "")
        else:
            result = neg.join("·")
    else:
        result = atoms.mapIt($it).join("·")

proc `$`*(q: Quantity): string =
    if unlikely(q.isCurrency()):
        result = stringify(q.original, CurrencyRational) & " " & $q.atoms
    elif unlikely(q.isTemperature()):
        result = stringify(q.original, TemperatureRational) & (if q.atoms[0].unit.u.core == K_CoreUnit: " " else: "") & $q.atoms
    else:
        result = stringify(q.original) & " " & $q.atoms

func codify*(expo: AtomExponent): string =
    if expo notin [-1, 1]:
        $(abs(expo))
    else:
        ""

proc codify*(unit: SubUnit): string =
    case unit.kind:
        of Core: (symbolName(unit.core)).replace("_CoreUnit","")
        of User: UserUnits[unit.name]

proc codify*(punit: PrefixedUnit): string =
    $(punit.p) & codify(punit.u)

proc codify*(atom: Atom): string =
    codify(atom.unit) & codify(atom.power)

proc codify*(atoms: Atoms): string =
    var pos: seq[string]
    var neg: seq[string]

    for atom in atoms:
        if atom.power > 0:
            pos.add codify(atom)
        else:
            neg.add codify(atom)

    result = pos.join(".")

    if neg.len > 0:
        result &= "/" & (neg.join(".")).replace("⁻¹", "").replace("⁻", "")

proc codify*(q: Quantity): string =
    result = ($q.original).replace("/",":") & "`"
    
    result &= codify(q.atoms)

proc inspect*(q: Quantity) =
    echo "----------------------------------------"
    echo $(q)
    echo "----------------------------------------"
    echo ".original: ", q.original
    echo ".value: ", q.value
    echo ".signature: ", q.signature, " => ", getProperty(q)
    echo ".base: ", q.base
    echo ".atoms: "

    for atom in q.atoms:
        echo "    - (", atom, ") = "
        echo "        .prefix: ", atom.unit.p
        echo "        .unit: ", atom.unit.u
        echo "        .power: ", atom.power

    echo ".base units: ", `$`(getBaseUnits(q), oneline=true)
    
    echo ""

#=======================================
# Setup
#=======================================

proc initQuantities*() =
    Properties = generateProperties()

    when not defined(WEB):
        Quantities = generateQuantities()

    addRuntimeQuantities()

    when defined(GMP):
        generateConstants()

#=======================================
# Testing
#=======================================

initQuantities()

when isMainModule:
    import helpers/benchmark
    import random, strutils

    template bmark(ttl:string, action:untyped):untyped =
        echo "----------------------"
        echo ttl
        echo "----------------------"
        benchmark "":
            for i in 1..1_000_000:
                action
