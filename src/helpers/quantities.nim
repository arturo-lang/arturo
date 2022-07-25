######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/quantities.nim
######################################################

#=======================================
# Libraries
#=======================================

import std/json, strformat, strutils, tables

when not defined(WEB):
    import asyncdispatch, httpClient

#=======================================
# Types
#=======================================

type
    UnitKind* = enum
        CurrencyUnit
        LengthUnit
        AreaUnit
        VolumeUnit
        PressureUnit
        EnergyUnit
        ForceUnit
        RadioactivityUnit
        AngleUnit
        SpeedUnit
        WeightUnit
        InformationUnit
        TimeUnit
        TemperatureUnit

        # Error value
        NoUnit

    UnitName* = enum
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
        M, DM, CM, MM, MIM, NM, KM, IN, FT, FM, YD, ANG, LY, PC, MI, NMI

        # Area
        M2, DM2, CM2, MM2, MIM2, NM2, KM2, IN2, FT2, YD2, ANG2, MI2, AC, A, HA

        # Volume
        M3, DM3, CM3, MM3, MIM3, NM3, KM3, IN3, FT3, YD3, ANG3, MI3, L, DL, CL, ML, FLOZ, TSP, TBSP, PT, QT, GAL

        # Pressure
        ATM, BAR, PA

        # Energy
        J, KJ, MJ, CAL, KCAL, WH, KWH, ERG

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
        MIN, HR, D, WK, MO, YR, S, MS, NS

        # Temperature
        C, F, K, R

        # Error value
        NoName

    QuantitySpec* = object
        kind*: UnitKind
        name*: UnitName
        
#=======================================
# Constants
#=======================================

const
    CannotConvertQuantity* = -18966.0
    ConversionRatio = {
        # Length
        M: 1.0,
        DM: 0.1,
        CM: 0.01,
        MM: 0.001,
        MIM: 1e-6,
        NM: 1e-9,
        KM: 1000.0,
        IN: 0.0254,
        FT: 0.3048,
        FM: 1.8288,
        YD: 0.9144,
        ANG: 1e-10,
        LY: 9.461e+15,
        PC: 3.086e+16,
        MI: 1609.34,
        NMI: 1852.0,

        # Area
        M2: 1.0, 
        DM2: 0.01,
        CM2: 0.0001, 
        MM2: 1e-6,
        MIM2: 1e-12,
        NM2: 1e-18,
        KM2: 1000000.0,
        IN2: 0.00064516,
        FT2: 0.092903,
        YD2: 0.836127,
        ANG2: 1e-20,
        MI2: 2592931.2786432, 
        AC: 4046.86,
        A: 100.0,
        HA: 10000.0,

        # Volume
        M3: 1.0, 
        DM3: 0.001,
        CM3: 1e-6,
        MM3: 1e-9,
        MIM3: 1e-18,
        NM3: 1e-27,
        KM3: 1e+9,
        IN3: 1.63871e-5,
        FT3: 0.0283168, 
        YD3: 0.764555, 
        ANG3: 1e-30,
        MI3: 4.168e+9, 
        L: 0.001,
        DL: 0.0001,
        CL: 1e-5,
        ML: 1e-6, 
        FLOZ: 2.95735e-5,
        PT: 0.000473, 
        TSP: 4.9289e-6,
        TBSP: 1.47868e-5,
        QT: 0.000946353, 
        GAL: 0.00378541,

        # Pressure
        ATM: 1.0,
        BAR: 0.986923,
        PA: 9.86923e-6,

        # Energy
        J: 1.0,
        KJ: 1000.0,
        MJ: 1000000.0,
        CAL: 4.184,
        KCAL: 4184.0,
        WH: 3600.0,
        KWH: 3.6e+6,
        ERG: 1e-7,

        # Force
        N: 1.0, 
        DYN: 1e-5, 
        KGF: 9.80665, 
        LBF: 8.89644, 
        PDL: 0.138255, 
        KIP: 4448.22,

        # Radioactivity
        BQ: 1.0,
        CI: 3.7e+10,
        RD: 1000000.0,

        # Angle
        DEG: 1.0,
        RAD: 57.2958,

        # Speed
        KPH: 1.0,
        MPS: 3.6,
        MPH: 1.60934,
        KN: 1.85,

        # Weight
        G: 1.0, 
        MG: 0.001, 
        KG: 1000.0, 
        T: 1000000.0, 
        ST: 6350.29, 
        OZ: 28.3495, 
        LB: 453.592,
        CT: 0.2,
        OZT: 31.1035,
        LBT: 373.242,

        # Capacity
        BIT: 1.0, 
        B: 8.0, 
        KB: 8.0 * 1000, 
        MB: 8.0 * 1000 * 1000, 
        GB: 8.0 * 1000 * 1000 * 1000, 
        TB: 8.0 * 1000 * 1000 * 1000,
        KIB: 8.0 * 1024, 
        MIB: 8.0 * 1024 * 1024, 
        GIB: 8.0 * 1024 * 1024 * 1024, 
        TIB: 8.0 * 1024 * 1024 * 1024,

        # Time
        MIN: 1.0, 
        HR: 60.0, 
        D: 1440.0,
        WK: 10080.0,
        MO: 43800.0,
        YR: 526000.0,
        S: 0.0166667,
        MS: 1.66667e-5, 
        NS: 1.66667e-11

    }.toTable

    ErrorQuantity* = QuantitySpec(kind: NoUnit, name: NoName)
    NumericQuantity* = QuantitySpec(kind: NoUnit, name: B)

#=======================================
# Helpers
#=======================================

func quantityKindForName*(un: UnitName): UnitKind {.inline.} =
    case un:
        of AED..ZMW     :   CurrencyUnit
        of M..NMI       :   LengthUnit
        of M2..HA       :   AreaUnit
        of M3..GAL      :   VolumeUnit
        of ATM..PA      :   PressureUnit
        of DEG..RAD     :   AngleUnit
        of J..ERG       :   EnergyUnit
        of N..KIP       :   ForceUnit
        of BQ..RD       :   RadioactivityUnit
        of KPH..KN      :   SpeedUnit
        of G..LBT       :   WeightUnit
        of BIT..TIB     :   InformationUnit
        of MIN..NS      :   TimeUnit
        of C..R         :   TemperatureUnit
        else:
            NoUnit

proc getExchangeRate(src: UnitName, tgt: UnitName): float =
    let s = toLowerAscii($(src))
    let t = toLowerAscii($(tgt))
    let url = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/{s}/{t}.json".fmt
    let content = waitFor (newAsyncHttpClient().getContent(url))
    let response = parseJson(content)
    return response[t].fnum

#=======================================
# Overloads
#=======================================

proc `$`*(qs: QuantitySpec): string =
    let un = qs.name
    result = toLowerAscii($(un))
    case un:
        of AED..ZMW, J, MJ, N, B..TB    : result = toUpperAscii(result)
        of PA, BQ, CI, RD               : result = capitalizeAscii(result)
        of C..R                         : result = "°" & toUpperAscii(result)
        of MIM, MIM2, MIM3              : result = result.replace("mim","μm")
        of ANG, ANG2, ANG3              : result = result.replace("ang","Å")
        of KIB..TIB                     : result = toUpperAscii(result).replace("I","i")

        of FLOZ     : result = "fl.oz"
        of KJ       : result = "kJ"
        of WH       : result = "Wh"
        of KWH      : result = "kWh"
        of DEG      : result = "°"
        of KPH      : result = "km/h"
        of MPS      : result = "m/s"
        of OZT      : result = "oz.t"
        of LBT      : result = "lb.t"
        of BIT      : result = "b"

        else:
            discard
    
    result = result.replace("2","²").replace("3","³")

proc `stringify`*(uk: UnitKind): string =
    toLowerAscii($(uk)).replace("unit","")

#=======================================
# Methods
#=======================================

proc newQuantitySpec*(un: UnitName): QuantitySpec {.inline.} =
    QuantitySpec(kind: quantityKindForName(un), name: un)

proc getQuantityMultiplier*(src: QuantitySpec, tgt: QuantitySpec): float =
    if src.kind != tgt.kind: return CannotConvertQuantity

    if src.kind == CurrencyUnit:
        return getExchangeRate(src.name, tgt.name)
    else:
        return ConversionRatio[src.name] / ConversionRatio[tgt.name]

proc getQuantityMultiplier*(src: UnitName, tgt: UnitName, isCurrency=false): float =
    # let srcKind = quantityKindForName(src)
    # let tgtKind = quantityKindForName(tgt)
    # if srcKind != tgtKind: return CannotConvertQuantity

    if isCurrency:
        return getExchangeRate(src, tgt)
    else:
        return ConversionRatio[src] / ConversionRatio[tgt]

proc getCleanCorrelatedUnit*(b: QuantitySpec, a: QuantitySpec): QuantitySpec = 
    var s = ($(a.name)).replace("2","").replace("3","")
    
    if ($(b.name)).contains("2")    :   s &= "2"
    elif ($(b.name)).contains("3")  :   s &= "3"

    return QuantitySpec(kind: b.kind, name: parseEnum[UnitName](s))

proc getFinalUnitAfterOperation*(op: string, argA: QuantitySpec, argB: QuantitySpec): QuantitySpec =
    case op:
        of "mul":
            if argA.kind == LengthUnit and argB.kind == LengthUnit and argA.name in M..MI:
                return newQuantitySpec(parseEnum[UnitName]($(argA.name)&"2"))

            elif ((argA.name in M..MI) or (argA.name in M2..MI2)) and (argB.kind in {LengthUnit,AreaUnit}) and argA.kind!=argB.kind:
               return newQuantitySpec(parseEnum[UnitName](($(argA.name)).replace("2","")&"3"))

        of "div", "mod", "fdiv":
            if ((argA.name in M2..MI2)) and (argB.kind==LengthUnit):
               return newQuantitySpec(parseEnum[UnitName](($(argA.name)).replace("2","")))

            elif ((argA.name in M3..MI3)) and (argB.kind==LengthUnit):
               return newQuantitySpec(parseEnum[UnitName](($(argA.name)).replace("3","2")))

            elif ((argA.name in M3..MI3)) and (argB.kind==AreaUnit) and argA.kind!=argB.kind:
               return newQuantitySpec(parseEnum[UnitName](($(argA.name)).replace("3","")))

            else:
                return NumericQuantity

        else:
            discard

    return ErrorQuantity

proc parseQuantitySpec*(str: string): QuantitySpec =
    let unitName = parseEnum[UnitName](toUpperAscii(str))
    newQuantitySpec(unitName)