#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
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

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import vm/values/custom/vrational

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

# Benchmarking
{.hints: on.}
{.hint: "Quantity's inner type is currently " & $sizeof(Quantity) & ".".}
{.hints: off.}

#=======================================
# Constants
#=======================================

const
    AtomExponents = ["⁻⁵", "⁻⁴", "⁻³", "⁻²", "⁻¹", "", "", "²", "³", "⁴", "⁵"]

    NoUnitFound = getNoUnitFound()

#=======================================
# Variables
#=======================================

var
    AtomsCache {.used.} : Table[string,Atoms]

    Properties          : Table[QuantitySignature, string]
    Quantities          : Table[SubUnit, Quantity]
    UserUnits           : Table[string, string]

    LastSignature       : QuantitySignature = static int(pow(6.0,11.0))
    SignatureStep       : QuantitySignature = static int(pow(6.0,20.0))

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

func `==`(a, b: SubUnit): bool =
    if a.kind != b.kind: return false
    return
        case a.kind:
            of Core: a.core == b.core
            of User: a.name == b.name

func isUnitless(q: Quantity): bool {.inline.} =
    return q.signature == 0

func isCurrency(q: Quantity): bool {.inline.} =
    return q.signature == (static parsePropertyFormula("C"))

func isTemperature(q: Quantity): bool {.inline.} =
    return q.signature == (static parsePropertyFormula("K"))

proc getExchangeRate(curr: string): float =
    let s = toLowerAscii(curr)
    let url = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/" & s & "/usd.json"
    let content = waitFor (newAsyncHttpClient().getContent(url))
    let response = parseJson(content)
    return response["usd"].fnum

proc getPrimitive(unit: PrefixedUnit): Quantity =
    result = Quantities[unit.u]

    if unlikely(result.isCurrency() and isZero(result.value)):
        let xrate = getExchangeRate((symbolName(unit.u.core)).replace("_CoreUnit",""))
        Quantities[unit.u].value = toRational(xrate)
        result.value = toRational(xrate)
    elif unit.p != No_Prefix:
        result.value *= pow(float(10), float(ord(unit.p)))

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
    result.original = v
    result.value = v

    for atom in atoms:
        let prim = getPrimitive(atom.unit)
        result.signature += prim.signature * atom.power
        result.value *= prim.value ^ atom.power

        if unlikely(atom.unit.u.kind == User):
            result.withUserUnits = true

        result.atoms.add(atom)

when not defined(NOGMP):
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
            when not defined(NOGMP):
                result = toRational(newInt(ratparts[0]), newInt(ratparts[1]))
    else:
        try:
            result = toRational(parseInt(s))
        except ValueError:
            when not defined(NOGMP):
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
        else:
            echo "ERROR!"
    elif fromU == degC_CoreUnit:
        if toU == K_CoreUnit:
            result = v + 273.15
        elif toU == degF_CoreUnit:
            result = v * (9//5) + 32
        elif toU == degR_CoreUnit:
            result = (v + 273.15) * (9//5)
        else:
            echo "ERROR!"
    elif fromU == degF_CoreUnit:
        if toU == K_CoreUnit:
            result = (v + 459.67) * (5//9)
        elif toU == degC_CoreUnit:
            result = (v - 32) * (5//9)
        elif toU == degR_CoreUnit:
            result = v + 459.67
        else:
            echo "ERROR!"
    elif fromU == degR_CoreUnit:
        if toU == K_CoreUnit:
            result = v * (5//9)
        elif toU == degC_CoreUnit:
            result = (v - 491.67) * (5//9)
        elif toU == degF_CoreUnit:
            result = v - 459.67
    else:
        echo "ERROR!"

proc convertTo*(q: Quantity, atoms: Atoms): Quantity =
    if q.signature != getSignature(atoms):
        raise newException(ValueError, "Cannot convert quantities with different dimensions.")

    if q.atoms == atoms:
        return q

    let newVal = q.value/getValue(atoms)
    result = toQuantity(newVal, atoms)

proc convertQuantity*(q: Quantity, atoms: Atoms): Quantity =
    if unlikely(isTemperature(q)):
        if q.signature != getSignature(atoms):
            raise newException(ValueError, "Cannot convert quantities with different dimensions.")
        
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

proc getBaseUnits*(q: Quantity): Atoms =
    result = flatten(toBase(q))

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

when not defined(NOGMP):
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

when not defined(NOGMP):
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

when not defined(NOGMP):
    func `>`*(a: Quantity, b: Int): bool =
        return a.original > b

    func `>`*(a: Int, b: Quantity): bool =
        return a > b.original

#=======================================
# Operators
#=======================================

proc `+`*(a, b: Quantity): Quantity =
    if not (a =~ b):
        raise newException(ValueError, "Cannot add quantities with different dimensions.")

    let convB = b.convertTo(a.atoms)

    # echo "quantity A: " & $(a)
    # echo "quantity B: " & $(b)
    # echo "\tconverted: " & $(convB)

    result = toQuantity(a.original + convB.original, a.atoms)

proc `+`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original + b, a.atoms)

when not defined(NOGMP):
    proc `+`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original + b, a.atoms)

proc `+=`*(a: var Quantity, b: Quantity) =
    if not (a =~ b):
        raise newException(ValueError, "Cannot add quantities with different dimensions.")

    let convB = b.convertTo(a.atoms)

    # echo "quantity A: " & $(a)
    # echo "quantity B: " & $(b)
    # echo "\tconverted: " & $(convB)

    a.original += convB.original

proc `+=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original += b

when not defined(NOGMP):
    proc `+=`*(a: var Quantity, b: Int) =
        a.original += b

proc `-`*(a, b: Quantity): Quantity =
    if not (a =~ b):
        raise newException(ValueError, "Cannot subtract quantities with different dimensions.")

    let convB = b.convertTo(a.atoms)

    # echo "quantity A: " & $(a)
    # echo "quantity B: " & $(b)
    # echo "\tconverted: " & $(convB)

    result = toQuantity(a.original - convB.original, a.atoms)

proc `-`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original - b, a.atoms)

when not defined(NOGMP):
    proc `-`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original - b, a.atoms)

proc `-=`*(a: var Quantity, b: Quantity) =
    if not (a =~ b):
        raise newException(ValueError, "Cannot subtract quantities with different dimensions.")

    let convB = b.convertTo(a.atoms)

    # echo "quantity A: " & $(a)
    # echo "quantity B: " & $(b)
    # echo "\tconverted: " & $(convB)

    a.original -= convB.original

proc `-=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original -= b

when not defined(NOGMP):
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

when not defined(NOGMP):
    proc `*`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original * b, a.atoms)

    proc `*`*(a: Int, b: Quantity): Quantity =
        result = toQuantity(a * b.original, b.atoms)

proc `*=`*(a: var Quantity, b: Quantity) =
    a = a * b

proc `*=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original *= b

when not defined(NOGMP):
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

when not defined(NOGMP):
    proc `/`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original / b, a.atoms)

proc `/=`*(a: var Quantity, b: Quantity) =
    a = a / b

proc `/=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original /= b

when not defined(NOGMP):
    proc `/=`*(a: var Quantity, b: Int) =
        a.original /= b

# TODO(VQuantity) should `/` & `//` implementations be the same?
#  labels: values, open discussion
proc `//`*(a: Quantity, b: int | float | Quantity | QuantityValue): Quantity =
    a / b

when not defined(NOGMP):
    proc `//`*(a: Quantity, b: Int): Quantity =
        a / b

proc `//=`*(a: var Quantity, b: int | float | Quantity | QuantityValue) =
    a = a // b

when not defined(NOGMP):
    proc `//=`*(a: var Quantity, b: Int) =
        a = a // b

proc `^`*(a: Quantity, b: int): Quantity =
    result = a

    var i = 1
    while i < b:
        result *= a
        inc i

proc `^=`*(a: var Quantity, b: int) =
    a = a ^ b

#=======================================
# String converters
#=======================================

func `$`*(expo: AtomExponent): string =
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

proc codify*(q: Quantity): string =
    result = ($q.original).replace("/",":") & "`"
    
    result &= ($(q.atoms)).replace("·",".")
                          .replace("¹","")
                          .replace("²","2")
                          .replace("³","3")
                          .replace("⁴","4")

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
    Quantities = generateQuantities()

    generateConstants()

#=======================================
# Testing
#=======================================

initQuantities()

# for (n,q) in pairs(Quantities):
#     echo $(n)
#     inspect(q)
#     echo "--"

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