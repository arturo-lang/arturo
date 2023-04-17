import macros, strutils, tables

var
    CTBaseUnits* {.compileTime.}: seq[string]
    CTUnitList {.compileTime.}: seq[(string,string)]
    CTUnitKindList {.compileTime.}: seq[(string, string)]
    CTUnitAliases {.compileTime.}: Table[string, string]
    CTUnitKinds {.compileTime.}: Table[string, string]
    CTDerivedUnits {.compileTime.}: Table[string, string]

    CTQuantityKindList {.compileTime.}: seq[(string, string)]
    CTQuantitySignatureList {.compileTime.}: seq[(int64, string)]

proc defineQuantity*(name: string, signatures: varargs[int64]) =
    let enumName = "Q" & name.replace(" ","")

    CTQuantityKindList.add((enumName, name))
    for sign in signatures:
        CTQuantitySignatureList.add((sign, enumName))

proc define*(unit: string, name: string, definition: string, aliases: varargs[string]) =
    let enumName = "U" & unit
    CTUnitList.add((enumName, name))

    for alias in aliases:
        CTUnitAliases[alias] = $(unit)

    if definition != "":
        if definition[0] in 'A'..'Z':
            CTBaseUnits.add("U" & unit)
            let enumKindName = "K" & definition
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
            newIdentNode(errorPrefix[0].toUpperAscii() & "Error"),
            newLit(errorPrefix & "-error")
        )

template getUnits*(): untyped = 
    generateEnum(CTUnitList, "unit")

template getUnitKinds*(): untyped =
    generateEnum(CTUnitKindList)

template getQuantityKinds*(): untyped =
    generateEnum(CTQuantityKindList)

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