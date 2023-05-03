#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/custom/quantities/preprocessor.nim
#=======================================================

## Macro preprocessor for the VQuantity module
## 
## The whole module works solely at compile-time and
## is used to define the base units, prefixes, units,
## constants and properties for the VQuantity module.

#=======================================
# Libraries
#=======================================

import macros, math, sequtils, strscans, strutils, tables

# yes, we are using the system's rational type, since
# it's not GMP-based in any case, but only for the values
# that can be encoded without the help of the GMP library
import std/rationals

#=======================================
# Types
#=======================================

type
    Atom = tuple
        kind: string
        expo: int

    CTRational = Rational[int]

    Quantity = tuple
        original: CTRational
        value: CTRational
        signature: int64
        atoms: seq[Atom]
        base: bool

    Constant = tuple
        definition: string
        value: Quantity
        precalculated: bool
        description: string

#=======================================
# Variables
#=======================================

var
    baseUnits           {.compileTime.} : seq[string]
    properties          {.compileTime.} : OrderedTable[int64,string]
    propertyExamples    {.compileTime.} : OrderedTable[string,string]
    prefixes            {.compileTime.} : OrderedTable[string, tuple[sym: string, val: int]]
    defs                {.compileTime.} : OrderedTable[string, Quantity]
    units               {.compileTime.} : OrderedTable[string, string]
    constants           {.compileTime.} : OrderedTable[string,Constant]

    parsable            {.compileTime.} : OrderedTable[string, (string, string)]

#=======================================
# Constants
#=======================================

const
    MagicPower = 6.0

    dimList = ["L", "T", "K", "M", "I", "N", "J", "C", "B", "A", "S"]
    expos = ["⁻³", "⁻²", "⁻¹", "", "", "²", "³", "⁴", "⁵"]
    expot = {
        "⁻⁵": -5,
        "⁻⁴": -4,
        "⁻³": -3,
        "⁻²": -2,
        "⁻¹": -1,
        "²": 2,
        "³": 3,
        "⁴": 4,
        "⁵": 5
    }.toTable

#=======================================
# Templates
#=======================================

template prefixId(str: string): string =
    str & "_Prefix"

template unitId(str: string): string =
    str & "_CoreUnit"
 
template getProperty(q: Quantity): string =
    properties.getOrDefault(q.signature, "NOT FOUND!")

#=======================================
# Helpers
#=======================================

# The std library doesn't support this!
func `^`(x: CTRational, y: int): CTRational =
    if y < 0:
        result.num = x.den ^ -y
        result.den = x.num ^ -y
    else:
        result.num = x.num ^ y
        result.den = x.den ^ y

proc getDefined(str: string): Quantity =
    let (pref, unit) = parsable[str]
    result = defs[unit]

    if pref != "No":
        var prefVal = toRational(pow(10.0, abs(float(prefixes[pref].val))))
        if prefixes[pref].val < 0:
            prefVal = reciprocal(prefVal)

        result.value *= prefVal
        result.original *= prefVal

proc getConverted(q: Quantity): CTRational =
    result = q.value
    if not q.base:
        for atom in q.atoms:
            let atomUnit = getDefined(atom.kind)
            result *= atomUnit.value ^ atom.expo

#=======================================
# Constructors
#=======================================

proc newQuantity(v: CTRational, atoms: seq[Atom], base: static bool = false): Quantity =
    result.original = v
    result.value = v
    result.atoms = atoms

    result.signature = 
        when base:
            int64(pow(MagicPower, float(baseUnits.find(atoms[0].kind))))
        else:
            result.atoms.map(proc (item:Atom): int64 =
                let got = getDefined(item.kind)
                got.signature * item.expo
            ).foldl(a + b, int64(0))

    when not base:
        result.value = result.getConverted()

    result.base = base

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

proc parseQuantity*(s: string): Quantity =
    proc parseValue(str: string): CTRational =
        if str.contains(":"):
            let parts = str.replace("pi", $(PI)).split(":")
            return toRational(parseFloat(parts[0]) / parseFloat(parts[1]))
        else:
            return toRational(parseFloat(str))

    var components = s.split(" ")

    return newQuantity(
        parseValue(components[0]),
        parseAtoms(components[1])
    )

proc parsePropertyFormula*(str: string):int64 =
    proc getTypeAndExpo(s: string): tuple[tp: string, exp: int] =
        result.exp = 1
        var x: char
        var y: string
        if scanf(s, "$c$*", x, y):
            result.tp = $(x)
            if y != "":
                result.exp = expot[y]
        else:
            raise newException(ValueError, "Invalid property pattern: " & s)

    if str.len == 0: return 

    let parts = str.split("·")
    var dims: OrderedTable[string,int]

    for part in parts:
        let (tp, exp) = getTypeAndExpo(part)
        dims[tp] = exp

    var sign = 0.0
    for (tp, exp) in dims.pairs:
        sign += pow(MagicPower, float(dimList.find(tp))) * float(exp)

    return int64(sign)

#=======================================
# Methods
#=======================================

proc defProperty*(quantity: string, formula: string = "", example: string = "") =
    let signature = parsePropertyFormula(formula)

    if properties.hasKey(signature):
        raise newException(ValueError, "Property already defined: " & quantity & " => " & properties[signature])
    properties[signature] = quantity
    propertyExamples[quantity] = example

proc defPrefix*(prefix, symbol: string, value: int) =
    prefixes[prefix] = (sym: symbol, val: value)

proc defUnit*(unit: string, symbol: string, prefixed: bool, definition: string, aliases: varargs[string]) =
    units[unit] = symbol

    if definition[0] in 'A'..'Z':
        baseUnits.add(unit)
        defs[unit] = newQuantity(1//1, @[(kind: unit, expo: 1)], base=true)
    else:
        defs[unit] = parseQuantity(definition)

    for alias in aliases:
        if parsable.hasKey(alias):
            raise newException(ValueError, "Parsable already defined: " & alias)
        parsable[alias] = ("No", unit)

    if parsable.hasKey(unit):
        raise newException(ValueError, "Parsable already defined: " & unit)
    parsable[unit] = ("No", unit)
    
    if prefixed: 
        for prefix, (sym, val) in prefixes:
            if prefix != "No":
                let prefixedUnit = prefix & unit
                if parsable.hasKey(prefixedUnit):
                    raise newException(ValueError, "Parsable already defined: " & prefixedUnit)
                parsable[prefixedUnit] = (prefix, unit)

proc defConstant*(name: string, precalculated: bool, definition: string, description: string) =
    if precalculated:
        constants[name] = (
            definition: definition, 
            value: parseQuantity(definition),
            precalculated: precalculated,
            description: description
        )
    else:
        constants[name] = (
            definition: definition, 
            value: newQuantity(1//1, @[(kind: name, expo: 1)], base=true),
            precalculated: precalculated,
            description: description
        )

proc defCurrency*(currency: string, symbol: string) =
    defUnit(currency, symbol, false, "0 USD")

#=======================================
# Macros & Generators
#=======================================

# Overloads

proc newLit(ct: CTRational): NimNode =
    nnkObjConstr.newTree(
        newIdentNode("VRational"),
        nnkExprColonExpr.newTree(
            newIdentNode("rKind"),
            newIdentNode("NormalRational")
        ),
        nnkExprColonExpr.newTree(
            newIdentNode("num"),
            newLit(ct.num)
        ),
        nnkExprColonExpr.newTree(
            newIdentNode("den"),
            newLit(ct.den)
        )
    )

# Helpers

proc getAtomsSeq(ats: seq[Atom]): NimNode =
    var atoms = nnkBracket.newTree()
    for atom in ats:
        let (expo, kind) = parsable[atom.kind]
        atoms.add nnkTupleConstr.newTree(
            nnkTupleConstr.newTree(
                newIdentNode(prefixId(expo)),
                nnkObjConstr.newTree(
                    newIdentNode("SubUnit"),
                    nnkExprColonExpr.newTree(
                        newIdentNode("kind"),
                        newIdentNode("Core")
                    ),
                    nnkExprColonExpr.newTree(
                        newIdentNode("core"),
                        newIdentNode(unitId(kind))
                    )
                )
            ),
            nnkCall.newTree(
                newIdentNode("AtomExponent"),
                newLit(atom.expo)
            )
        )

    result = nnkPrefix.newTree(
        newIdentNode("@"),
        atoms
    )

# Main

macro generatePrefixDefinitions*(): untyped =
    let res = nnkEnumTy.newTree(
        newEmptyNode()
    )

    for (prefix, content) in pairs(prefixes):
        let (symbol, value) = content
        var exponent = value

        res.add nnkEnumFieldDef.newTree(
            newIdentNode(prefixId(prefix)),
            nnkTupleConstr.newTree(
                newLit(exponent),
                newLit(symbol)
            )
        )

    res

macro generateUnitDefinitions*(): untyped =
    let res = nnkEnumTy.newTree(
        newEmptyNode()
    )

    for (unit, symbol) in pairs(units):
        res.add nnkEnumFieldDef.newTree(
            newIdentNode(unitId(unit)),
            newLit(symbol)
        )

    res.add nnkEnumFieldDef.newTree(
        newIdentNode("No_CoreUnit"),
        newLit("")
    )

    res

macro generateConstantDefinitions*(): untyped =
    let res = nnkVarSection.newTree()

    for (name, content) in pairs(constants):
        res.add nnkIdentDefs.newTree(
            nnkPostfix.newTree(
                newIdentNode("*"),
                newIdentNode(name)
            ),
            newIdentNode("Quantity"),
            newEmptyNode()
        )

    res

macro generateProperties*(): untyped =
    let items = nnkTableConstr.newTree()

    for (signature,property) in pairs(properties):
        items.add nnkExprColonExpr.newTree(
            newLit(signature),
            newLit(property)
        )

    nnkDotExpr.newTree(
        items,
        newIdentNode("toTable")
    )

macro generateParsables*(): untyped =
    let items = nnkTableConstr.newTree()

    for (parsable,content) in pairs(parsable):
        let (prefix, unit) = content

        items.add nnkExprColonExpr.newTree(
            newLit(parsable),
            nnkTupleConstr.newTree(
                newIdentNode(prefixId(prefix)),
                newIdentNode(unitId(unit))
            )
        )

    nnkDotExpr.newTree(
        items,
        newIdentNode("toTable")
    )

macro generateUnitParser*(): untyped =
    var reverseParsable: OrderedTable[(string, string), seq[string]]

    for (parsable, content) in pairs(parsable):
        if not reverseParsable.hasKey(content):
            reverseParsable[content] = @[]

        reverseParsable[content].add parsable

    var res = nnkCaseStmt.newTree(
        newIdentNode("str")
    )

    for (ret, parsables) in pairs(reverseParsable):
        var subres = nnkOfBranch.newTree()

        for pars in parsables:
            subres.add newLit(pars)

        subres.add nnkStmtList.newTree(
            nnkAsgn.newTree(
                newIdentNode("result"),
                nnkTupleConstr.newTree(
                    newIdentNode(prefixId(ret[0])),
                    nnkObjConstr.newTree(
                        newIdentNode("SubUnit"),
                        nnkExprColonExpr.newTree(
                            newIdentNode("kind"),
                            newIdentNode("Core")
                        ),
                        nnkExprColonExpr.newTree(
                            newIdentNode("core"),
                            newIdentNode(unitId(ret[1]))
                        )
                    )
                )
            )
        )
        res.add subres

    res.add nnkElse.newTree(
        nnkStmtList.newTree(
            nnkIfStmt.newTree(
                nnkElifBranch.newTree(
                    nnkCall.newTree(
                        nnkDotExpr.newTree(
                            newIdentNode("Quantities"),
                            newIdentNode("hasKey")
                        ),
                        nnkObjConstr.newTree(
                            newIdentNode("SubUnit"),
                            nnkExprColonExpr.newTree(
                                newIdentNode("kind"),
                                newIdentNode("User")
                            ),
                            nnkExprColonExpr.newTree(
                                newIdentNode("name"),
                                newIdentNode("str")
                            )
                        )
                    ),
                    nnkStmtList.newTree(
                        nnkAsgn.newTree(
                            newIdentNode("result"),
                            nnkTupleConstr.newTree(
                                newIdentNode("No_Prefix"),
                                nnkObjConstr.newTree(
                                    newIdentNode("SubUnit"),
                                    nnkExprColonExpr.newTree(
                                        newIdentNode("kind"),
                                        newIdentNode("User")
                                    ),
                                    nnkExprColonExpr.newTree(
                                        newIdentNode("name"),
                                        newIdentNode("str")
                                    )
                                )
                            )
                        )
                    )
                ),
                nnkElse.newTree(
                    nnkStmtList.newTree(
                        nnkAsgn.newTree(
                            newIdentNode("result"),
                            nnkTupleConstr.newTree(
                                newIdentNode("No_Prefix"),
                                nnkObjConstr.newTree(
                                    newIdentNode("SubUnit"),
                                    nnkExprColonExpr.newTree(
                                        newIdentNode("kind"),
                                        newIdentNode("Core")
                                    ),
                                    nnkExprColonExpr.newTree(
                                        newIdentNode("core"),
                                        newIdentNode("No_CoreUnit")
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )

macro getNoUnitFound*(): untyped =
    nnkTupleConstr.newTree(
        newIdentNode("No_Prefix"),
        nnkObjConstr.newTree(
            newIdentNode("SubUnit"),
            nnkExprColonExpr.newTree(
                newIdentNode("kind"),
                newIdentNode("Core")
            ),
            nnkExprColonExpr.newTree(
                newIdentNode("core"),
                newIdentNode("No_CoreUnit")
            )
        )
    )

macro generateQuantities*(): untyped =
    let items = nnkTableConstr.newTree()

    for (unit,quantity) in pairs(defs):
        var atomsSeq = getAtomsSeq(quantity.atoms)

        items.add nnkExprColonExpr.newTree(
            nnkObjConstr.newTree(
                newIdentNode("SubUnit"),
                nnkExprColonExpr.newTree(
                    newIdentNode("kind"),
                    newIdentNode("Core")
                ),
                nnkExprColonExpr.newTree(
                    newIdentNode("core"),
                    newIdentNode(unitId(unit))
                )
            ),
            nnkTupleConstr.newTree(
                newLit(quantity.original),
                newLit(quantity.value),
                newLit(quantity.signature),
                atomsSeq,
                newLit(quantity.base)
            )
        )

    nnkDotExpr.newTree(
        items,
        newIdentNode("toTable")
    )

macro generateConstants*(): untyped =
    let res = nnkStmtList.newTree()
    for (name, content) in pairs(constants):
        let (definition, quantity, precalculated, description) = content

        if precalculated:
            res.add nnkAsgn.newTree(
                newIdentNode(name),
                nnkTupleConstr.newTree(
                    newLit(quantity.original),
                    newLit(quantity.value),
                    newLit(quantity.signature),
                    getAtomsSeq(quantity.atoms),
                    newLit(false)
                )
            )
        else:
            res.add nnkAsgn.newTree(
                newIdentNode(name),
                nnkCall.newTree(
                    newIdentNode("toQuantity"),
                    newLit(definition.split(" ")[0]),
                    getAtomsSeq(parseAtoms(definition.split(" ")[1]))
                )
            )

    res

macro addPhysicalConstants*(): untyped =
    let res = nnkStmtList.newTree()

    for (name, content) in pairs(constants):
        res.add nnkCommand.newTree(
            newIdentNode("constant"),
            newLit(name),
            nnkExprEqExpr.newTree(
                newIdentNode("alias"),
                newIdentNode("unaliased")
            ),
            nnkExprEqExpr.newTree(
                newIdentNode("description"),
                newLit(content.description)
            ),
            nnkStmtList.newTree(
                nnkCall.newTree(
                    newIdentNode("newQuantity"),
                    newIdentNode(name)
                )
            )
        )

    res

macro addPropertyPredicates*(): untyped =
    let res = nnkStmtList.newTree()

    for (signature,property) in pairs(properties):
        let cleanProperty = $(property[0].toLowerAscii()) & (property[1..^1]).replace("-","").replace(" ","")
        let predName = cleanProperty & "?"
        res.add nnkCommand.newTree(
            newIdentNode("builtin"),
            newLit(predName),
            nnkExprEqExpr.newTree(
                newIdentNode("alias"),
                newIdentNode("unaliased")
            ),
            nnkExprEqExpr.newTree(
                newIdentNode("op"),
                newIdentNode("opNop")
            ),
            nnkExprEqExpr.newTree(
                newIdentNode("rule"),
                newIdentNode("PrefixPrecedence")
            ),
            nnkExprEqExpr.newTree(
                newIdentNode("description"),
                newLit("checks if given quantity describes " & property)
            ),
            nnkExprEqExpr.newTree(
                newIdentNode("args"),
                nnkTableConstr.newTree(
                    nnkExprColonExpr.newTree(
                        newLit("value"),
                        nnkCurly.newTree(
                            newIdentNode("Quantity")
                        )
                    )
                )
            ),
            nnkExprEqExpr.newTree(
                newIdentNode("attrs"),
                newIdentNode("NoAttrs")
            ),
            nnkExprEqExpr.newTree(
                newIdentNode("returns"),
                nnkCurly.newTree(
                    newIdentNode("Logical")
                )
            ),
            nnkExprEqExpr.newTree(
                newIdentNode("example"),
                newLit("            " & predName & " " & propertyExamples[property] & "\n            ; => true\n        ")
            ),
            nnkStmtList.newTree(
                nnkCall.newTree(
                    newIdentNode("push"),
                    nnkCall.newTree(
                        newIdentNode("newLogical"),
                        nnkInfix.newTree(
                            newIdentNode("=="),
                            nnkCall.newTree(
                            newIdentNode("getProperty"),
                            nnkDotExpr.newTree(
                                newIdentNode("x"),
                                newIdentNode("q")
                            )
                            ),
                            newLit(property)
                        )
                    )
                )
            )
        )

    res



#=======================================
# Debugging
#=======================================

# Overloads

# * we don't really need them, but they are
#   useful for debugging, at the compiler level only!

proc `+`(a, b: Quantity): Quantity =
    newQuantity(
        a.value + b.value,
        a.atoms
    )

proc `*`(a, b: Quantity): Quantity =
    newQuantity(
        a.original * b.original,
        a.atoms & b.atoms
    )

proc `$`*(q: Quantity): string =
    result &= $(q.original)

    var tbl: OrderedTable[string,int]
    
    for atom in q.atoms:
        if tbl.hasKeyOrPut(atom.kind, atom.expo):
            tbl[atom.kind] += atom.expo
        else:
            tbl[atom.kind] = atom.expo
    
    var num, den: seq[string]

    for (unit,expo) in tbl.pairs:
        if expo > 0:
            num.add(unit & expos[expo + 3])
        else:
            den.add(unit & expos[expo + 3])

    if num.len > 0:
        result &= " " & num.join("·")
    else:
        result &= " 1"

    if den.len > 0:
        result &= "/" & den.join("·")

# Main debugging routines

proc debugAdd(a,b:string) =
    let pA = parseQuantity(a)
    let pB = parseQuantity(b)
    echo a & " + " & b & " = " & $(pA + pB)

proc debugMul(a,b:string) =
    let pA = parseQuantity(a)
    let pB = parseQuantity(b)
    echo a & " * " & b & " = " & $(pA * pB)

proc printUnits*() =
    for unit, quantity in defs:
        echo unit & " = "
        echo "\t.original = " & $(quantity.original)
        echo "\t.value = " & $(quantity.value)
        echo "\t\t.signature = " & $(quantity.signature)
        echo "\t\t===> " & $quantity.getProperty()
        echo "\t.atoms = " & $(quantity.atoms)
        echo "\t.base = " & $(quantity.base)
        echo ""

    echo $(constants)