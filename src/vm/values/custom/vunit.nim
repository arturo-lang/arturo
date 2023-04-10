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

import std/enumutils, strutils, tables

#=======================================
# Types
#=======================================

type
    UnitFamily* = enum
        Currency
        Length
        Area
        Volume
        Pressure
        Energy
        Force
        Radioactivity
        Angle
        Speed
        Weight
        Information
        Time
        Temperature

    UnitSymbolKind* = enum
        Lowercase
        Uppercase
        Capitalized
        Custom

    UnitSpec* = object
        alias: string
        kind: UnitFamily
        case symbolKind: UnitSymbolKind:
            of Custom:
                symbol: string
            else:
                discard
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
        M, DM, CM, MM, MIM, NM, PM, KM, IN, FT, FM, YD, ANG, LY, PC, AU, CHAIN, ROD, FUR, MI, NMI

        # Area
        M2, DM2, CM2, MM2, MIM2, NM2, KM2, IN2, FT2, YD2, ANG2, MI2, AC, A, HA

        # Volume
        M3, DM3, CM3, MM3, MIM3, NM3, KM3, IN3, FT3, YD3, ANG3, MI3, L, DL, CL, ML, FLOZ, TSP, TBSP, CP, PT, QT, GAL

        # Pressure
        ATM, BAR, PA

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

    VUnit* = distinct UnitType

#=======================================
# Borrows
#=======================================

proc `==`*(x, y: VUnit): bool {.borrow.}
proc symbolName*(x: VUnit): string {.borrow.}

#=======================================
# Compile-time helpers
#=======================================

proc getUnitFamily*(vu: UnitType): UnitFamily {.compileTime.} =
    result = 
        case vu:
            of M..NMI: Length
            of M2: Area
            of M3: Volume
            else: Temperature

proc Unit*(vu: UnitType, al: string, rat: float = 1.0, sym: string | UnitSymbolKind = Lowercase): (VUnit, UnitSpec) {.compileTime.} =
    when sym is UnitSymbolKind:
        return (VUnit(vu), UnitSpec(alias: al, kind: getUnitFamily(vu), symbolKind: sym, ratio: rat))
    elif sym is string:
        return (VUnit(vu), UnitSpec(alias: al, kind: getUnitFamily(vu), symbolKind: Custom, symbol: sym, ratio: rat))

proc `||`(a, b: static[UnitType]): uint32 {.compileTime.}=
    result = (cast[uint32](ord(a)) shl 16) or
             (cast[uint32](ord(b)))

proc `~>`*(a: UnitType): VUnit {.compileTime.} =
    VUnit(a)

#=======================================
# Constants
#=======================================

const 
    UnitSpecs* = [
        # Length
        Unit(M,         "meter"),
        Unit(DM,        "decimeter",        0.1,),
        Unit(CM,        "centimeter",       0.01),
        Unit(MM,        "millimeter",       0.001),
        Unit(MIM,       "micrometer",       1e-6,               "μm"),
        Unit(NM,        "nanometer",        1e-9),
        Unit(PM,        "picometer",        1e-12),
        Unit(KM,        "kilometer",        1000.0),
        Unit(IN,        "inch",             0.0254),
        Unit(FT,        "feet",             0.3048),
        Unit(FM,        "fathom",           1.8288),
        Unit(YD,        "yard",             0.9144),
        Unit(ANG,       "angstrom",         1e-10,              "Å"),
        Unit(LY,        "lightyear",        9.461e+15),
        Unit(PC,        "parsec",           3.086e+16),
        Unit(AU,        "",                 1.496e+11),
        Unit(CHAIN,     "",                 20.1168),
        Unit(ROD,       "",                 5.0292),
        Unit(FUR,       "furlong",          201.168),
        Unit(MI,        "mile",             1609.34),
        Unit(NMI,       "",                 1852.0),

        # Area
        Unit(M2, "squareMeter"),
        Unit(M3, "cubicMeter"),
    ].toTable

#=======================================
# Helpers
#=======================================

template getUnitPair(a, b: VUnit): untyped = 
    (cast[uint32](ord(a)) shl 16.uint32) or 
    (cast[uint32](ord(b))) 

template getUnitSpec(vu: VUnit): UnitSpec =
    UnitSpecs[vu]

proc parseUnit*(str: string): VUnit =
    try:
        return VUnit(parseEnum[UnitType](str))
    except ValueError:
        for vunit,vspec in UnitSpecs:
            if vspec.alias == str or (vspec.alias & "s") == str:
                return vunit

    raise newException(ValueError, "unknown unit: " & str)

#=======================================
# Overloads
#=======================================

# operations

func `*`*(a, b: VUnit): VUnit =
    let qp = getUnitPair(a, b)
    result = 
        case qp:
            of M || M: ~> M2
            of M || M2, M2 || M: ~> M3
            else: ~> UnitError

# output

proc `$`*(vu: VUnit): string {.inline.} =
    let spec = getUnitSpec(vu)
    result = 
        case spec.symbolKind:
            of Uppercase:
                (vu.symbolName).toUpperAscii()
            of Lowercase:
                (vu.symbolName).toLowerAscii()
            of Capitalized:
                (vu.symbolName).capitalizeAscii()
            else:
                spec.symbol

    result = result.replace("2","²").replace("3","³")

when isMainModule:
    let v = parseUnit("M")

    echo $(typeof(v))

    echo $(v)