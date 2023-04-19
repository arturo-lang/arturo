import math, std/rationals, sequtils, strutils, tables

type
    Atom = tuple
        kind: string
        expo: int

    Quantity = tuple
        original: float
        value: float
        signature: int64
        atoms: seq[Atom]
        base: bool

var
    baseUnits {.compileTime.}: seq[string]
    quantityKinds {.compileTime.}: seq[string]
    quantities {.compileTime.}: OrderedTable[int64,string]
    prefixes {.compileTime.}: OrderedTable[string, tuple[sym: string, val: float]]
    defs {.compileTime.}: OrderedTable[string, Quantity]
    unitKinds {.compileTime.}: OrderedTable[string, string]

    parsable {.compileTime.}: OrderedTable[string, (string, string)]
 
template getTypeBySignature(signature: int64): string =
    quantities.getOrDefault(signature, "NOT FOUND!")

proc getDefined*(str: string): Quantity =
    let (pref, unit) = parsable[str]
    result = defs[unit]

    if pref != "no":
        result.value *= prefixes[pref].val
        result.original *= prefixes[pref].val

# proc deepBaseAtoms(units: seq[Atom]): seq[Atom] =
#     var result: seq[Atom]
#     for unit in units:
#         if quantityKinds.find(getDefined(unit.kind).kind) != -1:
#             result.add(unit)
#         else:
#             result.add(deepBaseAtoms(getDefined(unit.kind).atoms))
#     return result

# proc getDeepSignature(q: Quantity): seq[int64] =
#     result = newSeq[int64](10)
#     for unit in q.atoms:
#         for idx, s in getDefined(unit.kind).signature:
#             result[idx] += s * unit.expo

#         # if quantityKinds.find(getDefined(unit.kind).kind) != -1:
#         #     result.add(unit)
#         # else:
#         #     result.add(deepBaseAtoms(getDefined(unit.kind).atoms))
#     return result
 
# proc getQuantityType(q: Quantity): (int64, string) =
#     var vector: Vector = newSeq[int64](baseUnits.len)
#     for index, item in q.signature:
#         vector[index] = item * (int(pow(float(20),float(index))))

#     let sign = vector.foldl(a + b, int64(0))
#     return (sign, getTypeBySignature(sign))

# proc getQuantityType(units: seq[Atom]): (string, int64, Vector) =
#     var vec = newSeq[int64](baseUnits.len)
 #     for index, item in 
#     for unit in units:
#         let vindx = quantityKinds.find(getDefined(unit.kind).kind)
#         vector

#     var vector: Vector = newSeq[int64](baseUnits.len)
#     when units is seq[Atom]:
        
#         for unit in deepBaseAtoms(units):
#             echo "unit: " & unit.kind & " " & $(unit.expo)
#             echo "def[unit.kind].kind = " & getDefined(unit.kind).kind

#             var vindx = quantityKinds.find(getDefined(unit.kind).kind)

#             if vindx != -1:
#                 vector[vindx] += unit.expo

#         for index, item in vector:
#             vector[index] = item * (int(pow(float(20),float(index))))

#         let sign = vector.foldl(a + b, int64(0))
#         return (getTypeBySignature(sign), sign, @[])
#     else:
#         var vindx = quantityKinds.find(units)

#         if vindx != -1:
#             vector[vindx] += 1

#         for index, item in vector:
#             vector[index] = item * (int(pow(float(20),float(index))))

#         let sign = vector.foldl(a + b, int64(0))
#         return (getTypeBySignature(sign), sign, returnable)

proc getConverted(unit: string): float =
    let got = getDefined(unit)
    if got.base:
        return got.value
    else:
        result = got.value
        for atom in got.atoms:
            result *= pow(getConverted(atom.kind), float(atom.expo))

proc parseQuantity*(s: string): Quantity =
    echo "processing: " & s
    proc parseValue(str: string): float =
        if str.contains("/"):
            let parts = str.replace("pi", $(PI)).split("/")
            return parseFloat(parts[0]) / parseFloat(parts[1])
        else:
            return parseFloat(str)

    proc parseAtoms(str: string): seq[Atom] =
        proc parseAtom(atstr: string, denominator: static bool=false): Atom =
            var i = 0
            while i < atstr.len and atstr[i] notin '2'..'9':
                result.kind.add atstr[i]
                inc i

            if i < atstr.len:
                result.expo = parseInt(atstr[i..^1])
            else:
                result.expo = 1

            when denominator:
                result.expo = -result.expo

        let parts = str.split("/")

        for part in parts[0].split("."):
            if part != "1":
                result.add parseAtom(part)

        if parts.len > 1:
            for part in parts[1].split("."):
                result.add parseAtom(part, denominator=true)

    var components = s.split(" ")
    result.original = parseValue(components[0])
    result.atoms = parseAtoms(components[1])
    result.value = result.original
    # result.signature = getDeepSignature(result)
    result.signature = result.atoms.map(proc (item:Atom): int64 =
        let got = getDefined(item.kind)
        got.signature * item.expo
    ).foldl(a + b, int64(0))
    #(result.kind, result.signature, result.parts) = getQuantityType(result.atoms)

    for atom in result.atoms:
        result.value *= pow(getConverted(atom.kind), float(atom.expo))

    echo "result: " & $(result)


proc defineQuantity*(quantity: string, signature: int64) =
    quantities[signature] = quantity

proc definePrefix*(prefix, symbol, value: string) =
    prefixes[prefix] = (sym: symbol, val: parseFloat(value))

proc define*(unit: string, symbol: string, prefixed: bool, definition: string, aliases: varargs[string]) =
    echo "defining: " & unit
    if definition != "":
        if definition[0] in 'A'..'Z':
            baseUnits.add(unit)
            quantityKinds.add(definition)
            #let (_, sign, parts) = getQuantityType(definition)
            # var sng = newSeq[int64](10)
            # sng[baseUnits.find(unit)] = 1
            let sign = int64(pow(20, float(baseUnits.find(unit))))
            defs[unit] = (original: 1.0, value: 1.0, signature: sign, atoms: @[(kind: unit, expo: 1)], base: true)
        else:
            defs[unit] = parseQuantity(definition)

        for alias in aliases:
            #defs[alias] = defs[unit]
            parsable[alias] = ("no", unit)

        parsable[unit] = ("no", unit)
        
        if prefixed:
            for prefix, (sym, val) in prefixes:
                if prefix != "no":
                    let prefixedUnit = prefix & unit
                    parsable[prefixedUnit] = (prefix, unit)
                    #  
                    
                    # defs[prefixedUnit] = (original: defs[unit].original * val, value: defs[unit].value * val, kind: defs[unit].kind, signature: defs[unit].signature, atoms: defs[unit].atoms, base: false)

proc printUnits*() =
    for unit, quantity in defs:
        echo unit & " = "
        echo "\t.original = " & $(quantity.original)
        echo "\t.value = " & $(quantity.value)
        #echo "\t.kind = " & quantity.kind & " (signature: " & $(quantity.signature) & ")"
        # echo "\t\t.signature = " & $(quantity.signature)
        # echo "\t\t===> " & $getQuantityType(quantity)
        echo "\t\t.signature = " & $(quantity.signature)
        echo "\t\t===> " & $getTypeBySignature(quantity.signature)
        echo "\t.atoms = " & $(quantity.atoms)
        echo "\t.base = " & $(quantity.base)
        echo ""

        echo $(parseQuantity("1 W/K"))

    echo $(parsable)

# V*s / A
# W*s / A2
# J*s / s*A2 = J / A2
# N*m / A2
# kg*m2 / A2*s2
