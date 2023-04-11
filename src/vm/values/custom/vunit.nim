#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/custom/vunit.nim
#=======================================================

## Unit definition for the internal `:quantity` type

#=======================================
# Libraries
#=======================================

import std/enumutils, macros, strutils, tables

when not defined(WEB):
    import asyncdispatch, httpClient, std/json, strformat

#=======================================
# Types
#=======================================

const 
    Prefixes = {
        "T"     : (1e+12, "tera"),
        "G"     : (1e+9, "giga"),
        "M"     : (1e+6, "mega"),
        "k"     : (1e+3, "kilo"),
        "h"     : (1e+2, "hecto"),
        "da"    : (1e+1, "deca"),
        "d"     : (1e-1, "deci"),
        "c"     : (1e-2, "centi"),
        "m"     : (1e-3, "milli"),
        "μ"     : (1e-6, "micro"),
        "n"     : (1e-9, "nano"),
        "p"     : (1e-12, "pico"),
        "f"     : (1e-15, "femto")
    }

type
    UnitKind* = enum
        Currency
        Length
        Area
        Volume
        Pressure
        Energy
        Power
        Force
        Radioactivity
        Angle
        Speed
        Weight
        Information
        Time
        Temperature

        Invalid

    UnitSymbolKind* = enum
        Lowercase
        Uppercase
        Capitalized
        Custom

    UnitSpec* = object
        alias: string
        symbol: string
        ratio: float

    UnitType* = enum
        # Currency
        AED, ALL, ARS, AUD, BGN, BHD, BNB, BND, BOB, BRL, BTC, BWP, 
        CAD, CHF, CLP, CNY, COP, CRC, CZK, DKK, DOP, DZD, EGP, ETB,
        ETH, EUR, FJD, GBP, HKD, HNL, HRK, HUF, IDR, ILS, INR, IRR, 
        ISK, JMD, JOD, JPY, KES, KRW, KWD, KYD, KZT, LBP, LKR, MAD, 
        MDL, MKD, MXN, MUR, MYR, NAD, NGN, NIO, NOK, NPR, NZD, OMR, 
        PAB, PEN, PGK, PHP, PKR, PLN, PYG, QAR, RON, RSD, RUB, SAR,
        SCR, SEK, SGD, SLL, SOS, SVC, THB, TND, TRY, TTD, TWD, TZS, 
        UAH, UGX, USD, UYU, UZS, VND, XAF, XAG, XAU, XOF, YER, ZAR, 
        ZMW

        # Length
        M, TM, GM, KM, HM, DAM, DM, CM, MM, UM, NM, PM, FM
        IN, FT, FTM, YD, ANG, LY, PC, AU, CHAIN, ROD, FUR, MI, NMI

        # Area
        M2, TM2, GM2, KM2, HM2, DAM2, DM2, CM2, MM2, UM2, NM2, PM2, FM2
        IN2, FT2, FTM2, YD2, ANG2, LY2, PC2, AU2, CHAIN2, ROD2, FUR2, MI2, NMI2, AC, ARE, HA

        # Volume
        M3, TM3, GM3, KM3, HM3, DAM3, DM3, CM3, MM3, UM3, NM3, PM3, FM3
        IN3, FT3, FTM3, YD3, ANG3, LY3, PC3, AU3, CHAIN3, ROD3, FUR3, MI3, NMI3
        L, HL, DAL, DL, CL, ML
        FLOZ, TSP, TBSP, CUP, PT, QT, GAL

        # Pressure
        PA, TPA, GPA, KPA, HPA, DAPA, DPA, CPA, MPA, UPA, NPA, PPA, FPA
        ATM, BAR, TORR, PSI, MMHG, INHG, MMH2O, INH2O

        # Energy
        J, KJ, MJ, CAL, KCAL, WH, KWH, ERG

        # Power
        W, KW, HP

        # Force
        N, DYN, KGF, LBF, PDL, KIP

        # Radioactivity
        BQ, CI, RD

        # Angle
        DEG, RAD

        # Speed
        KPH, MPS, MPH, KN

        # Weight
        G, MG, KG, T, ST, OZ, LB, CT, OZT, LBT

        # Information
        BIT, B, KB, MB, GB, TB, KIB, MIB, GIB, TIB, 

        # Time
        MIN, H, D, WK, MO, YR, S, MS, NS

        # Temperature
        C, F, K, R

        ###

        UnitError

    VUnit* = distinct uint32

#=======================================
# Borrows
#=======================================

proc `==`*(a, b: VUnit): bool {.borrow.}

#=======================================
# Compile-time helpers
#=======================================

proc Define*(unit: UnitType, al: string, rat: float = 1.0, sym: string | UnitSymbolKind = Lowercase): (UnitType, UnitSpec) {.compileTime.} =
    when sym is UnitSymbolKind:
        return (unit, UnitSpec(alias: al.toUpperAscii(), symbolKind: sym, ratio: rat))
    elif sym is string:
        return (unit, UnitSpec(alias: al.toUpperAscii(), symbolKind: Custom, symbol: sym, ratio: rat))

proc Derivative*(unit: UnitType, prefix: string, sym: string | UnitSymbolKind = Lowercase): (UnitType, UnitSpec) {.compileTime.} =
    return (unit, UnitSpec(alias: prefix & unit.name.toUpperAscii(), symbolKind: Custom, symbol: prefix & unit.name, ratio: Prefixes[prefix]))

proc `||`(a, b: static[UnitType]): uint32 {.compileTime.}=
    result = (cast[uint32](ord(a)) shl 16) or
             (cast[uint32](ord(b)))

#=======================================
# Constants
#=======================================

# Area
#         M2: 1.0, 
#         DM2: 0.01,
#         CM2: 0.0001, 
#         MM2: 1e-6,
#         MIM2: 1e-12,
#         NM2: 1e-18,
#         KM2: 1000000.0,
#         IN2: 0.00064516,
#         FT2: 0.092903,
#         YD2: 0.836127,
#         ANG2: 1e-20,
#         MI2: 2592931.2786432, 
#         AC: 4046.86,
#         A: 100.0,
#         HA: 10000.0,

#         # Volume
#         M3: 1.0, 
#         DM3: 0.001,
#         CM3: 1e-6,
#         MM3: 1e-9,
#         MIM3: 1e-18,
#         NM3: 1e-27,
#         KM3: 1e+9,
#         IN3: 1.63871e-5,
#         FT3: 0.0283168, 
#         YD3: 0.764555, 
#         ANG3: 1e-30,
#         MI3: 4.168e+9, 
#         L: 0.001,
#         DL: 0.0001,
#         CL: 1e-5,
#         ML: 1e-6, 
#         FLOZ: 2.95735e-5,
#         PT: 0.000473, 
#         TSP: 4.9289e-6,
#         TBSP: 1.47868e-5,
#         CP: 0.000236588,
#         QT: 0.000946353, 
#         GAL: 0.00378541,

#         # Pressure
#         ATM: 1.0,
#         BAR: 0.986923,
#         PA: 9.86923e-6,

#         # Energy
#         J: 1.0,
#         KJ: 1000.0,
#         MJ: 1000000.0,
#         CAL: 4.184,
#         KCAL: 4184.0,
#         WH: 3600.0,
#         KWH: 3.6e+6,
#         ERG: 1e-7,

#         # Power
#         W: 1.0,
#         KW: 1000.0, 
#         HP: 735.499,

#         # Force
#         N: 1.0, 
#         DYN: 1e-5, 
#         KGF: 9.80665, 
#         LBF: 8.89644, 
#         PDL: 0.138255, 
#         KIP: 4448.22,

#         # Radioactivity
#         BQ: 1.0,
#         CI: 3.7e+10,
#         RD: 1000000.0,

#         # Angle
#         DEG: 1.0,
#         RAD: 57.2958,

#         # Speed
#         KPH: 1.0,
#         MPS: 3.6,
#         MPH: 1.60934,
#         KN: 1.85,

#         # Weight
#         G: 1.0, 
#         MG: 0.001, 
#         KG: 1000.0, 
#         T: 1000000.0, 
#         ST: 6350.29, 
#         OZ: 28.3495, 
#         LB: 453.592,
#         CT: 0.2,
#         OZT: 31.1035,
#         LBT: 373.242,

#         # Capacity
#         BIT: 1.0, 
#         B: 8.0, 
#         KB: 8.0 * 1000, 
#         MB: 8.0 * 1000 * 1000, 
#         GB: 8.0 * 1000 * 1000 * 1000, 
#         TB: 8.0 * 1000 * 1000 * 1000,
#         KIB: 8.0 * 1024, 
#         MIB: 8.0 * 1024 * 1024, 
#         GIB: 8.0 * 1024 * 1024 * 1024, 
#         TIB: 8.0 * 1024 * 1024 * 1024,

#         # Time
#         MIN: 1.0, 
#         H: 60.0, 
#         D: 1440.0,
#         WK: 10080.0,
#         MO: 43800.0,
#         YR: 526000.0,
#         S: 0.0166667,
#         MS: 1.66667e-5, 
#         NS: 1.66667e-11

type
    UnitDef = (UnitType,string,string,float,seq[string])

macro generateUnits*(units: static[openArray[UnitDef]]): untyped =
    var group = nnkBracket.newTree()

    for def in units:
        let name = def[0]
        let symbol = def[1]
        let alias = def[2]
        let ratio = def[3]
        let derived = def[4]

        group.add nnkTupleConstr.newTree(
            newLit(name),
            nnkObjConstr.newTree(
                newIdentNode("UnitSpec"),
                nnkExprColonExpr.newTree(
                    newIdentNode("alias"),
                    newLit(alias)
                ),
                nnkExprColonExpr.newTree(
                    newIdentNode("symbol"),
                    newLit(symbol)
                ),
                nnkExprColonExpr.newTree(
                    newIdentNode("ratio"),
                    newLit(ratio)
                )
            )
        )

        if derived != @[]:
            for pref in Prefixes:
                let shortPref = pref[0]
                let longPref = pref[1][1]
                let rat = pref[1][0]

                if shortPref notin derived:
                    continue

                let newAlias = 
                    if alias == "":
                        ""
                    else:
                        longPref & alias

                let newSymbol = 
                    if symbol == "":
                        ""
                    else:
                        shortPref & symbol

                var enumNode: NimNode
                if shortPref == "μ":
                    enumNode = newIdentNode("U" & $(name))
                else:
                    enumNode = newIdentNode((shortPref).toUpperAscii() & $(name))

                group.add nnkTupleConstr.newTree(
                    enumNode,
                    nnkObjConstr.newTree(
                        newIdentNode("UnitSpec"),
                        nnkExprColonExpr.newTree(
                            newIdentNode("alias"),
                            newLit(newAlias)
                        ),
                        nnkExprColonExpr.newTree(
                            newIdentNode("symbol"),
                            newLit(newSymbol)
                        ),
                        nnkExprColonExpr.newTree(
                            newIdentNode("ratio"),
                            newLit(ratio * rat)
                        )
                    )
                )

    result = nnkStmtList.newTree()
    result.add group

template Base(n: UnitType, alias: string = "", derive: seq[string] | bool = true, symbol: string = ""): UnitDef =
    var symb = 
        if symbol == "":
            ($(n)).toLowerAscii()
        else:
            symbol
    
    symb = symb.replace("2","²").replace("3","³")
    when derive is bool:
        var toDerive: seq[string]
        for pref in Prefixes:
            toDerive.add pref[0]
        (n, symb, alias, 1.0, toDerive)
    else:
        (n, symb, alias, 1.0, derive)

template Derived(n: UnitType, alias: string, ratio: float, symbol: string = ""): UnitDef =
    var symb = 
        if symbol == "":
            ($(n)).toLowerAscii()
        else:
            symbol
    
    symb = symb.replace("2","²").replace("3","³")
    (n, symb, alias, ratio, @[])

const 
    UnitSpecs* = (generateUnits [
        #---------------------
        # Length
        #---------------------
           Base(    M,          "meter",                                    ),
        Derived(    IN,         "inch",             0.0254,                 ),
        Derived(    FT,         "feet",             0.3048,                 ),
        Derived(    FTM,        "fathom",           1.8288,                 ),
        Derived(    YD,         "yard",             0.9144,                 ),
        Derived(    ANG,        "angstrom",         1e-10,                  "Å"),
        Derived(    LY,         "lightyear",        9.461e+15,              ),
        Derived(    PC,         "parsec",           3.086e+16,              ),
        Derived(    AU,         "",                 1.496e+11,              ),
        Derived(    CHAIN,      "",                 20.1168,                ),
        Derived(    ROD,        "",                 5.0292,                 ),
        Derived(    FUR,        "",                 201.168,                ),
        Derived(    MI,         "mile",             1609.34,                ),
        Derived(    NMI,        "nauticalMile",     1852.0,                 ),

        #---------------------
        # Area
        #---------------------
           Base(    M2,         "meter2",                                   ),    
        Derived(    IN2,        "inch2",            6.4516e-4,              ),
        Derived(    FT2,        "feet2",            0.092903,               ),
        Derived(    FTM2,       "fathom2",          3.3058,                 ),
        Derived(    YD2,        "yard2",            0.836127,               ),
        Derived(   ANG2,        "angstrom2",        1e-20,                  "Å2"),
        Derived(    LY2,        "lightyear2",       8.95054e+31,            ),
        Derived(    PC2,        "parsec2",          9.537e+32,              ),
        Derived(    AU2,        "",                 2.247e+22,              ),
        Derived(    CHAIN2,     "",                 404.687,                ),
        Derived(    ROD2,       "",                 25.2929,                ),
        Derived(    FUR2,       "furlong2",         40468.7,                ),
        Derived(    MI2,        "mile2",            2.58999e+6,             ),
        Derived(    NMI2,       "nauticalMile2",    3.452e+6,               ),
        Derived(    AC,         "acre",             4046.87,                ),
        Derived(    ARE,        "",                 100.0,                  ),
        Derived(    HA,         "hectare",          10000.0,                ),

        #---------------------
        # Volume
        #---------------------
           Base(    M3,         "meter3",                                   ),
        Derived(    IN3,        "inch3",            1.6387e-5,              ),
        Derived(    FT3,        "feet3",            0.0283168,              ),
        Derived(    FTM3,       "fathom3",          0.546807,               ),
        Derived(    YD3,        "yard3",            0.764555,               ),
        Derived(    ANG3,       "angstrom3",        1e-30,                  "Å3"),
        Derived(    LY3,        "lightyear3",       8.95054e+47,            ),
        Derived(    PC3,        "parsec3",          9.537e+48,              ),
        Derived(    AU3,        "",                 1.148e+38,              ),
        Derived(    CHAIN3,     "",                 8093.74,                ),
        Derived(    ROD3,       "",                 508.929,                ),
        Derived(    FUR3,       "furlong3",         809373.0,               ),
        Derived(    MI3,        "mile3",            4.168e+9,               ),
        Derived(    NMI3,       "nauticalMile3",    6.854e+9,               ),
           Base(    L,          "liter",            @["m", "c", "d", "da", "h"]),
        Derived(    FLOZ,       "fluidOunce",       2.9574e-5,              ),
        Derived(    TSP,        "teaspoon",         4.9289e-6,              ),
        Derived(    TBSP,       "tablespoon",       1.4787e-5,              ),
        Derived(    CUP,        "",                 2.3659e-4,              ),
        Derived(    PT,         "pint",             4.7318e-4,              ),
        Derived(    QT,         "quart",            9.4635e-4,              ),
        Derived(    GAL,        "gallon",           3.7854e-3,              ),

        #---------------------
        # Pressure
        #---------------------
           Base(    PA,         "pascal",           true,                   "Pa"),
        Derived(    ATM,        "atmosphere",       101325.0,               ),
        Derived(    BAR,        "bar",              100000.0,               ),
        Derived(    TORR,       "torr",             133.322,                "Torr"),
        Derived(    PSI,        "",                 6894.76,                ),
        Derived(    MMHG,       "",                 133.322,                "mmHg"),
        Derived(    INHG,       "",                 3386.39,                "inHg"),
        Derived(    MMH2O,      "",                 9.80665,                "mmH₂O"),
        Derived(    INH2O,      "",                 249.082,                "inH₂O")

    ]).toTable

#=======================================
# Helpers
#=======================================

# Constructor & accesors

func resolveUnitKind*(unit: UnitType): UnitKind {.enforceNoRaises.} =
    case unit:
        of AED..ZMW     :   Currency
        of M..NMI       :   Length
        of M2..HA       :   Area
        of M3..GAL      :   Volume
        of PA..INH2O    :   Pressure
        of DEG..RAD     :   Angle
        of J..ERG       :   Energy
        of W..HP        :   Power
        of N..KIP       :   Force
        of BQ..RD       :   Radioactivity
        of KPH..KN      :   Speed
        of G..LBT       :   Weight
        of BIT..TIB     :   Information
        of MIN..NS      :   Time
        of C..R         :   Temperature
        of UnitError    :   Invalid

func `~>`*(unit: UnitType): VUnit {.inline,enforceNoRaises.} =
    result = VUnit(
        (cast[uint32](ord(unit))) or
        (cast[uint32](ord(resolveUnitKind(unit))) shl 16)
    )

template unit*(vunit: VUnit): UnitType =
    UnitType(cast[uint32](vunit) and 0xFFFF)

template kind*(vunit: VUnit): UnitKind =
    UnitKind(cast[uint32](vunit) shr 16)

# Matching

template getUnitPair(a, b: UnitType): untyped = 
    (cast[uint32](ord(a)) shl 16.uint32) or 
    (cast[uint32](ord(b))) 

# Conversion

proc getExchangeRate(src: VUnit, tgt: VUnit): float =
    when not defined(WEB):
        let s = toLowerAscii($(src.unit))
        let t = toLowerAscii($(tgt.unit))
        let url = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/{s}/{t}.json".fmt
        let content = waitFor (newAsyncHttpClient().getContent(url))
        let response = parseJson(content)
        return response[t].fnum
    else:
        return 1.0

#=======================================
# Overloads
#=======================================

# operations

func `*`*(a, b: VUnit): VUnit =
    let qp = getUnitPair(a.unit, b.unit)
    result = 
        case qp:
            of M || M: ~> M2
            of M || M2, M2 || M: ~> M3
            else: ~> UnitError

# output

proc `$`*(vu: VUnit): string {.inline.} =
    let spec = UnitSpecs[vu.unit]
    result = spec.symbol

#=======================================
# Methods
#=======================================

proc parseUnit*(str: string): VUnit =
    try:
        return ~> parseEnum[UnitType](str.toUpperAscii())
    except ValueError:
        let s = str.toUpperAscii()
        for unit,vspec in UnitSpecs:
            if vspec.alias == s or (vspec.alias & "S") == s:
                return ~> unit

    raise newException(ValueError, "unknown unit: " & str)

proc getRatio*(unitFrom: VUnit, unitTo: VUnit): float {.inline.} =
    if unitFrom==unitTo: return 1.0
    if unitFrom.kind != unitTo.kind: return 0.0

    if unitFrom.kind == Currency:
        return getExchangeRate(unitFrom, unitTo)
    else:
        return UnitSpecs[unitFrom.unit].ratio / UnitSpecs[unitTo.unit].ratio

# import helpers/benchmark
# import strutils, tables

# template bmark(ttl:string, action:untyped):untyped =
#     echo "----------------------"
#     echo ttl
#     echo "----------------------"
#     benchmark "":
#         for i in 1..1_000_000:
#             action

when isMainModule:
    let v = parseUnit("M")
    let x = parseUnit("M3")

    echo "$: " & $(v)
    echo ".unit: " & $(v.unit)
    echo ".kind: " & $(v.kind)
    echo ".ratio: " & $(getRatio(v, ~> KM))

    echo $(UnitSpecs)
    # var vu: VUnit
    # bmark "parseUnit":
    #     vu = parseUnit("M")
    #     vu = parseUnit("m2")
    #     vu = parseUnit("meters")
