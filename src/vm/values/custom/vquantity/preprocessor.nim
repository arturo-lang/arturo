import macros, math, sequtils, strscans, strutils, tables

import vm/values/custom/vrational

type
    Atom = tuple
        kind: string
        expo: int

    Quantity = tuple
        original: VRational
        value: VRational
        signature: int64
        atoms: seq[Atom]
        base: bool

var
    baseUnits {.compileTime.}: seq[string]
    dimensions {.compileTime.}: OrderedTable[int64,string]
    prefixes {.compileTime.}: OrderedTable[string, tuple[sym: string, val: VRational]]
    defs {.compileTime.}: OrderedTable[string, Quantity]
    units {.compileTime.}: OrderedTable[string, string]

    parsable {.compileTime.}: OrderedTable[string, (string, string)]
    currencyUnits {.compileTime.}: seq[string]
    temperatureUnits {.compileTime.}: seq[string]

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

template prefixId(str: string): string =
    str & "_Prefix"

template unitId(str: string): string =
    str & "_Unit"
 
template getDimension(q: Quantity): string =
    dimensions.getOrDefault(q.signature, "NOT FOUND!")

proc getDefined*(str: string): Quantity =
    let (pref, unit) = parsable[str]
    result = defs[unit]

    if pref != "No":
        result.value *= prefixes[pref].val
        result.original *= prefixes[pref].val

proc getConverted(q: Quantity): VRational =
    result = q.value
    if not q.base:
        for atom in q.atoms:
            let atomUnit = getDefined(atom.kind)
            result *= atomUnit.value ^ atom.expo

proc newQuantity(v: float, atoms: seq[Atom], base: static bool = false): Quantity =
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

proc parseQuantity*(s: string): Quantity =
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

    return newQuantity(
        parseValue(components[0]),
        parseAtoms(components[1])
    )

proc parseDimensionFormula*(str: string):int64 =
    proc getTypeAndExpo(s: string): tuple[tp: string, exp: int] =
        result.exp = 1
        var x: char
        var y: string
        if scanf(s, "$c$*", x, y):
            result.tp = $(x)
            if y != "":
                result.exp = expot[y]
        else:
            raise newException(ValueError, "Invalid dimension pattern: " & s)

    if str.len == 0: return 

    let parts = str.split("·")
    var dims: OrderedTable[string,int]

    for part in parts:
        let (tp, exp) = getTypeAndExpo(part)
        dims[tp] = exp

    var sign = 0.0
    for (tp, exp) in dims.pairs:
        sign += pow(MagicPower, float(dimList.find(tp))) * float(exp)

    echo $(dims)

    return int64(sign)

proc defDimension*(quantity: string, formula: string = "") =
    echo "parsing: " & formula
    let signature = parseDimensionFormula(formula)
    echo "signature is: " & $(signature)

    if dimensions.hasKey(signature):
        raise newException(ValueError, "Dimension already defined: " & quantity & " => " & dimensions[signature])
    dimensions[signature] = quantity

proc defPrefix*(prefix, symbol: string, value: int) =
    var prefVal = toRational(pow(10.0, abs(float(value))))
    if value < 0:
        prefVal = reciprocal(prefVal)
    prefixes[prefix] = (sym: symbol, val: prefVal)

proc defUnit*(unit: string, symbol: string, prefixed: bool, definition: string, aliases: varargs[string]) =
    echo "defining: " & unit
    units[unit] = symbol
    if definition != "":
        if definition[0] in 'A'..'Z':
            baseUnits.add(unit)
            defs[unit] = newQuantity(1.0, @[(kind: unit, expo: 1)], base=true)

            if unit=="USD":
                currencyUnits.add(unit)
        else:
            defs[unit] = parseQuantity(definition)

        for alias in aliases:
            parsable[alias] = ("No", unit)

        parsable[unit] = ("No", unit)
        
        if prefixed: 
            for prefix, (sym, val) in prefixes:
                if prefix != "No":
                    let prefixedUnit = prefix & unit
                    parsable[prefixedUnit] = (prefix, unit)
    else:
        temperatureUnits.add(unit)

proc defCurrency*(currency: string, symbol: string) =
    currencyUnits.add(currency)
    defUnit(currency, symbol, false, "")

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
        echo "\t\t===> " & $quantity.getDimension()
        echo "\t.atoms = " & $(quantity.atoms)
        echo "\t.base = " & $(quantity.base)
        echo ""

    # echo $(parsable)

    # echo $(parseQuantity("1 kg/m2"))

    # debugAdd "1 m", "1 m"
    # debugAdd "1 m", "3 m"
    # debugAdd "1 m", "1 yd"

    # debugAdd "3 m", "2 yd"

    # debugMul "2 m", "3 m" 
    # debugMul "2 m", "3 yd" 

macro generatePrefixDefinitions*(): untyped =
    let res = nnkEnumTy.newTree(
        newEmptyNode()
    )

    for (prefix, content) in pairs(prefixes):
        let (symbol, value) = content
        let exponent = log10(value).int
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
        newIdentNode("No_Unit"),
        newLit("")
    )

    res

macro generateDimensions*(): untyped =
    let items = nnkTableConstr.newTree()

    for (signature,dimension) in pairs(dimensions):
        items.add nnkExprColonExpr.newTree(
            newLit(signature),
            newLit(dimension)
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
                        newIdentNode("Unit"),
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
                            newIdentNode("Unit"),
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
                                    newIdentNode("Unit"),
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
                                    newIdentNode("Unit"),
                                    nnkExprColonExpr.newTree(
                                        newIdentNode("kind"),
                                        newIdentNode("Core")
                                    ),
                                    nnkExprColonExpr.newTree(
                                        newIdentNode("core"),
                                        newIdentNode("No_Unit")
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )

macro generateQuantities*(): untyped =
    let items = nnkTableConstr.newTree()

    for (unit,quantity) in pairs(defs):
        var atoms = nnkBracket.newTree()
        for atom in quantity.atoms:
            let (expo, kind) = parsable[atom.kind]
            atoms.add nnkTupleConstr.newTree(
                nnkTupleConstr.newTree(
                    newIdentNode(prefixId(expo)),
                    nnkObjConstr.newTree(
                        newIdentNode("Unit"),
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

        let atomsSeq = nnkPrefix.newTree(
            newIdentNode("@"),
            atoms
        )

        var flags = nnkCurly.newTree()
        if quantity.base:
            flags.add newIdentNode("IsBase")

        if temperatureUnits.contains(unit):
            flags.add newIdentNode("IsTemperature")

        if currencyUnits.contains(unit):
            flags.add newIdentNode("IsCurrency")

        items.add nnkExprColonExpr.newTree(
            nnkObjConstr.newTree(
                newIdentNode("Unit"),
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
                flags
            )
        )

    nnkDotExpr.newTree(
        items,
        newIdentNode("toTable")
    )

dumpAstGen:
    (VQuantity)(1)
    @[(one,two), (three,four)]

dumpAstGen:
    case str:
        of "a", "b", "c": result = (No_Prefix, m_Unit)
        of "d", "e", "f": (No_Prefix, s_Unit)
        else:
            (No_Prefix, No_Unit)

    {IsBase, IsTemperature}

    Unit(kind: CoreUnit, core: m_Unit)

    AtomExponent(1)

dumpAstGen:
    if UserUnits.hasKey(Unit(kind: User, name: str)):
        result = Unit(kind: User, name: str)
    else:
        result = Unit(kind: CoreUnit, core: No_Unit)
