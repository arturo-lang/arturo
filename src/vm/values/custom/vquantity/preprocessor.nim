import macros, sequtils, strutils, tables

var
    CTBaseUnits* {.compileTime.}: seq[string]
    CTPrefixes* {.compileTime.}: Table[string, (string, float)]
    CTPrefixList* {.compileTime.}: seq[(string, string)]
    CTUnitList {.compileTime.}: seq[(string,string)]
    CTUnitKindList {.compileTime.}: seq[(string, string)]
    CTUnitKinds {.compileTime.}: Table[string, string]
    CTDerivedUnits {.compileTime.}: Table[string, string]

    CTQuantityKindList {.compileTime.}: seq[(string, string)]
    CTQuantitySignatureList {.compileTime.}: seq[(int64, string)]

    CTParsables {.compileTime.}: Table[string,(string,string)]

proc defineQuantity*(name: string, signatures: varargs[int64]) =
    let enumName = name.replace(" ","") & "_Q"

    CTQuantityKindList.add((enumName, name))
    for sign in signatures:
        CTQuantitySignatureList.add((sign, enumName))

proc definePrefix*(name: string, symbol: string, definition: string) =
    CTPrefixes[name & "_P"] = (symbol, definition.parseFloat)
    CTPrefixList.add((name & "_P", symbol))

proc define*(unit: string, name: string, withPrefixes: bool, definition: string, aliases: varargs[string]) =
    let enumName = unit & "_U"
    CTUnitList.add((enumName, name))

    CTParsables[unit] = ("no_P", enumName)

    for alias in aliases:
        CTParsables[alias] = ("no_P", enumName)

    if withPrefixes:
        for (prefix, res) in CTPrefixes.pairs:
            if prefix != "no_P":
                let (symbol, factor) = res
                if CTParsables.hasKey(prefix & unit):
                    echo "Warning: prefix " & prefix & " already defined for unit " & unit

                CTParsables[symbol & unit] = (prefix, enumName)

    if definition != "":
        if definition[0] in 'A'..'Z':
            CTBaseUnits.add(unit & "_U")
            let enumKindName = definition & "_K"
            CTUnitKindList.add((enumKindName, definition))
            CTUnitKinds[unit] = enumKindName
        elif definition is string:
            CTDerivedUnits[unit] = definition

macro generateEnum*(tlist: static[seq[(string,string)]], errorPrefix: static[string] = ""): untyped =
    result = nnkEnumTy.newTree(
        newEmptyNode()
    )

    for (un, name) in tlist:
        result.add nnkEnumFieldDef.newTree(
            newIdentNode(un),
            newLit(name)
        )

    if errorPrefix != "":
        result.add nnkEnumFieldDef.newTree(
            newIdentNode("Error" & errorPrefix[0].toUpperAscii()),
            newLit(errorPrefix & "-error")
        )

template getUnits*(): typedesc[enum] = 
    generateEnum(CTUnitList, "unit")

template getUnitKinds*(): typedesc[enum] =
    generateEnum(CTUnitKindList)

template getPrefixKinds*(): typedesc[enum] =
    generateEnum(CTPrefixList)

template getQuantityKinds*(): typedesc[enum] =
    generateEnum(CTQuantityKindList, "quantity")

macro getBaseUnits*(): untyped =
    result = nnkBracket.newTree()

    for unit in CTBaseUnits:
        result.add newIdentNode(unit)

macro getQuantitySignatures*(): untyped =
    var tbl = nnkTableConstr.newTree()
    for (sign, name) in CTQuantitySignatureList:
        tbl.add nnkExprColonExpr.newTree(
            nnkCall.newTree(
                newIdentNode("int64"),
                newLit(sign)
            ),
            newIdentNode(name)
        )

    return nnkDotExpr.newTree(
        tbl,
        newIdentNode("toTable")
    )

macro getParsables*(): untyped =
    var tbl = nnkTableConstr.newTree()
    for (str, res) in CTParsables.pairs:
        let (pref, unit) = res
        tbl.add nnkExprColonExpr.newTree(
            newLit(str),
            nnkTupleConstr.newTree(
                newIdentNode(pref),
                newIdentNode(unit)
            )
        )

    return nnkDotExpr.newTree(
        tbl,
        newIdentNode("toTable")
    )

macro getKnownQuantities*(): untyped =
    var tbl = nnkTableConstr.newTree()
    for (unit, kind) in CTUnitKinds.pairs:
        echo "unit: " & unit & " kind: " & kind
        tbl.add nnkExprColonExpr.newTree(
            newIdentNode(unit&"_U"),
            nnkTupleConstr.newTree(
                nnkExprColonExpr.newTree(
                    newIdentNode("original"),
                    newLit(1.0)
                ),
                nnkExprColonExpr.newTree(
                    newIdentNode("value"),
                    newLit(1.0)
                ),
                nnkExprColonExpr.newTree(
                    newIdentNode("tp"),
                    newIdentNode(kind)
                ),
                nnkExprColonExpr.newTree(
                    newIdentNode("units"),
                    nnkTupleConstr.newTree(
                        nnkExprColonExpr.newTree(
                            newIdentNode("n"),
                            nnkPrefix.newTree(
                                newIdentNode("@"),
                                nnkBracket.newTree(newIdentNode(unit&"_U"))
                            )
                        ),
                        nnkExprColonExpr.newTree(
                            newIdentNode("d"),
                            nnkPrefix.newTree(
                                newIdentNode("@"),
                                nnkBracket.newTree(newIdentNode("Error_U"))
                            )
                        )
                    )
                ),
                nnkExprColonExpr.newTree(
                    newIdentNode("base"),
                    newIdentNode("false")
                )
            )
        )

    return nnkDotExpr.newTree(
        tbl,
        newIdentNode("toTable")
    )


proc echoParsables*() =
    echo $(CTParsables)
    echo $(CTParsables.len)

    echo $(CTUnitList)
    echo $(CTUnitList.len)