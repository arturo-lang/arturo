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

when not defined(WEB):
    import asyncdispatch, httpClient, std/json, strformat

#=======================================
# Types
#=======================================

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

    VUnit* = distinct uint32

#=======================================
# Borrows
#=======================================

proc `==`*(a, b: VUnit): bool {.borrow.}

#=======================================
# Compile-time helpers
#=======================================

proc Define*(tp: UnitType, al: string, rat: float = 1.0, sym: string | UnitSymbolKind = Lowercase): (UnitType, UnitSpec) {.compileTime.} =
    when sym is UnitSymbolKind:
        return (tp, UnitSpec(alias: al.toUpperAscii(), symbolKind: sym, ratio: rat))
    elif sym is string:
        return (tp, UnitSpec(alias: al.toUpperAscii(), symbolKind: Custom, symbol: sym, ratio: rat))

proc `||`(a, b: static[UnitType]): uint32 {.compileTime.}=
    result = (cast[uint32](ord(a)) shl 16) or
             (cast[uint32](ord(b)))

#=======================================
# Constants
#=======================================

const 
    UnitSpecs* = [
        # Length
        Define(M,         "meter"),
        Define(DM,        "decimeter",        0.1,),
        Define(CM,        "centimeter",       0.01),
        Define(MM,        "millimeter",       0.001),
        Define(MIM,       "micrometer",       1e-6,               "μm"),
        Define(NM,        "nanometer",        1e-9),
        Define(PM,        "picometer",        1e-12),
        Define(KM,        "kilometer",        1000.0),
        Define(IN,        "inch",             0.0254),
        Define(FT,        "feet",             0.3048),
        Define(FM,        "fathom",           1.8288),
        Define(YD,        "yard",             0.9144),
        Define(ANG,       "angstrom",         1e-10,              "Å"),
        Define(LY,        "lightyear",        9.461e+15),
        Define(PC,        "parsec",           3.086e+16),
        Define(AU,        "",                 1.496e+11),
        Define(CHAIN,     "",                 20.1168),
        Define(ROD,       "",                 5.0292),
        Define(FUR,       "furlong",          201.168),
        Define(MI,        "mile",             1609.34),
        Define(NMI,       "",                 1852.0),

        # Area
        Define(M2, "squareMeter"),
        Define(M3, "cubicMeter"),
    ].toTable

#=======================================
# Helpers
#=======================================

template getUnitPair(a, b: UnitType): untyped = 
    (cast[uint32](ord(a)) shl 16.uint32) or 
    (cast[uint32](ord(b))) 

template getUnitSpec(vu: UnitType): UnitSpec =
    UnitSpecs[vu]

func getUnitKind*(unit: UnitType): UnitKind {.enforceNoRaises.} =
    case unit:
        of AED..ZMW     :   Currency
        of M..NMI       :   Length
        of M2..HA       :   Area
        of M3..GAL      :   Volume
        of ATM..PA      :   Pressure
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
        (cast[uint32](ord(getUnitKind(unit))) shl 16)
    )

template unit*(vunit: VUnit): UnitType =
    UnitType(cast[uint32](vunit) and 0xFFFF)

template kind*(vunit: VUnit): UnitKind =
    UnitKind(cast[uint32](vunit) shr 16)

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
    let unit = vu.unit
    let spec = getUnitSpec(unit)
    result = 
        case spec.symbolKind:
            of Uppercase:
                ($(unit)).toUpperAscii()
            of Lowercase:
                ($(unit)).toLowerAscii()
            of Capitalized:
                ($(unit)).capitalizeAscii()
            else:
                spec.symbol

    result = result.replace("2","²").replace("3","³")

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
        return getUnitSpec(unitFrom.unit).ratio / getUnitSpec(unitTo.unit).ratio

import helpers/benchmark
import strutils, tables

template bmark(ttl:string, action:untyped):untyped =
    echo "----------------------"
    echo ttl
    echo "----------------------"
    benchmark "":
        for i in 1..1_000_000:
            action

when isMainModule:
    let v = parseUnit("M")
    let x = parseUnit("M3")

    echo "$: " & $(v)
    echo ".unit: " & $(v.unit)
    echo ".kind: " & $(v.kind)
    echo ".ratio: " & $(getRatio(v, ~> KM))

    var vu: VUnit
    bmark "parseUnit":
        vu = parseUnit("M")
        vu = parseUnit("m2")
        vu = parseUnit("meters")
