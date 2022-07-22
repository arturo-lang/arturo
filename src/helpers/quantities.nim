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
        AngleUnit
        SpeedUnit
        WeightUnit
        CapacityUnit
        TemperatureUnit

        # Error value
        NoUnit

    UnitName* = enum
        # Currency
        AED, ALL, ARS, AUD, BGN, BRL, BTC, CAD, CHF, CLP, 
        CNY, COP, CRC, CZK, DZD, EGP, ETB, EUR, GBP, HKD,
        IDR, ILS, INR, IRR, ISK, JPY, KES, KRW, MXN, MYR,
        NGN, NOK, NZD, PAB, PHP, PLN, QAR, RSD, RUB, SEK,
        SGD, SOS, THB, TRY, UAH, USD, UYU, VND, XAF, XAG,
        XAU, XOF, ZAR

        # Length
        M, CM, MM, KM, IN, FT, FM, YD, MI, NMI

        # Area
        M2, CM2, MM2, KM2, IN2, FT2, YD2, MI2, AC, HA

        # Volume
        M3, CM3, MM3, KM3, IN3, FT3, YD3, MI3, L, ML, PT, QT, GAL

        # Pressure
        ATM, BAR, PA

        # Energy
        J, KJ, MJ, WH, KWH, ERG

        # Angle
        DEG, RAD

        # Speed
        KPH, MPH, KN

        # Weight
        G, MG, KG, T, ST, OZ, LB

        # Capacity
        BIT, B, KB, MB, GB, TB

        # Temperature
        C, F, K

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
        CM: 0.01,
        MM: 0.001,
        KM: 1000.0,
        IN: 0.0254,
        FT: 0.3048,
        FM: 1.8288,
        YD: 0.9144,
        MI: 1609.34,
        NMI: 1852.0,

        # Area
        M2: 1.0, 
        CM2: 0.0001, 
        MM2: 1e-6,
        KM2: 1000000.0,
        IN2: 0.00064516,
        FT2: 0.092903,
        YD2: 0.836127,
        MI2: 2592931.2786432, 
        AC: 4046.86,
        HA: 10000.0,

        # Volume
        M3: 1.0, 
        CM3: 1e-6,
        MM3: 1e-9,
        KM3: 1e+9,
        IN3: 1.63871e-5,
        FT3: 0.0283168, 
        YD3: 0.764555, 
        MI3: 4.168e+9, 
        L: 0.001,
        ML: 1e-6, 
        PT: 0.000473, 
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
        WH: 3600.0,
        KWH: 3.6e+6,
        ERG: 1e-7,

        # Angle
        DEG: 1.0,
        RAD: 57.2958,

        # Speed
        KPH: 1.0,
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

        # Capacity
        BIT: 1.0, 
        B: 8.0, 
        KB: 8.0 * 1024, 
        MB: 8.0 * 1024 * 1024, 
        GB: 8.0 * 1024 * 1024 * 1024, 
        TB: 8.0 * 1024 * 1024 * 1024

    }.toTable

    ErrorQuantity* = QuantitySpec(kind: NoUnit, name: NoName)

#=======================================
# Helpers
#=======================================

func quantityKindForName(un: UnitName): UnitKind =
    case un:
        of AED..ZAR     :   CurrencyUnit
        of M..NMI       :   LengthUnit
        of M2..HA       :   AreaUnit
        of M3..GAL      :   VolumeUnit
        of ATM..PA      :   PressureUnit
        of DEG..RAD     :   AngleUnit
        of J..ERG       :   EnergyUnit
        of KPH..KN      :   SpeedUnit
        of G..LB        :   WeightUnit
        of BIT..TB      :   CapacityUnit
        of C..K         :   TemperatureUnit
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
    case qs.kind:
        of CurrencyUnit     : $(qs.name)
        of TemperatureUnit  : "°" & $(qs.name)
        else: 
            toLowerAscii($(qs.name)).replace("2","²").replace("3", "³")

proc `stringify`*(uk: UnitKind): string =
    toLowerAscii($(uk)).replace("unit","")

#=======================================
# Methods
#=======================================

proc getQuantityMultiplier*(src: QuantitySpec, tgt: QuantitySpec): float =
    if src.kind != tgt.kind: return CannotConvertQuantity

    if src.kind == CurrencyUnit:
        return getExchangeRate(src.name, tgt.name)
    else:
        return ConversionRatio[src.name] / ConversionRatio[tgt.name]

proc getCleanCorrelatedUnit*(b: QuantitySpec, a: QuantitySpec): QuantitySpec = 
    let s = ($(a.name)).replace("2","").replace("3","")
    if ($(b.name)).contains("2"):
        return QuantitySpec(kind: b.kind, name: parseEnum[UnitName](s & "2"))
    elif ($(b.name)).contains("3"):
        return QuantitySpec(kind: b.kind, name: parseEnum[UnitName](s & "3"))
    else:
        return b

proc getFinalUnitAfterOperation*(op: string, argA: QuantitySpec, argB: QuantitySpec): QuantitySpec =
    let tup = (argA, argB)

    case op:
        of "mul":
            if argA.kind == LengthUnit and argB.kind == LengthUnit and argA.name in M..MI:
                return QuantitySpec(kind: AreaUnit, name: parseEnum[UnitName]($(argA.name)&"2"))

            if ((argA.name in M..MI) or (argA.name in M2..MI2)) and (argB.kind in {LengthUnit,AreaUnit}) and argA.kind!=argB.kind:
               return QuantitySpec(kind: VolumeUnit, name: parseEnum[UnitName](($(argA.name)).replace("2","")&"3"))

            # if tup == (M,M): return QuantitySpec(kind: AreaUnit, name: M2)
            # elif tup == (CM,CM): return QuantitySpec(kind: AreaUnit, name: CM2)
            # elif tup == (MM,MM): return QuantitySpec(kind: AreaUnit, name: MM2)
            # elif tup == (KM,KM): return QuantitySpec(kind: AreaUnit, name: KM2)
            # elif tup == (IN,IN): return QuantitySpec(kind: AreaUnit, name: IN2)
            # elif tup == (FT,FT): return QuantitySpec(kind: AreaUnit, name: FT2)
            # elif tup == (YD,YD): return QuantitySpec(kind: AreaUnit, name: YD2)
            # elif tup == (MI,MI): return QuantitySpec(kind: AreaUnit, name: MI2)
            # elif (tup == (M,M2)) or (tup == (M2,M)): return QuantitySpec(kind: VolumeUnit, name: M3)
            # elif (tup == (CM,CM2)) or (tup == (CM2,CM)): return QuantitySpec(kind: VolumeUnit, name: CM3)
            # elif (tup == (MM,MM2)) or (tup == (MM2,MM)): return QuantitySpec(kind: VolumeUnit, name: MM3)
            # elif (tup == (KM,KM2)) or (tup == (KM2,KM)): return QuantitySpec(kind: VolumeUnit, name: KM3)
            # elif (tup == (IN,IN2)) or (tup == (IN2,IN)): return QuantitySpec(kind: VolumeUnit, name: IN3)
            # elif (tup == (FT,FT2)) or (tup == (FT2,FT)): return QuantitySpec(kind: VolumeUnit, name: FT3)
            # elif (tup == (YD,YD2)) or (tup == (YD2,YD)): return QuantitySpec(kind: VolumeUnit, name: YD3)
            # elif (tup == (MI,MI2)) or (tup == (MI2,MI)): return QuantitySpec(kind: VolumeUnit, name: MI3)
            else: return ErrorQuantity
        of "div", "mod", "fdiv":
            if ((argA.name in M2..MI2)) and (argB.kind==LengthUnit):
               return QuantitySpec(kind: LengthUnit, name: parseEnum[UnitName](($(argA.name)).replace("2","")))

            if ((argA.name in M3..MI3)) and (argB.kind==LengthUnit):
               return QuantitySpec(kind: AreaUnit, name: parseEnum[UnitName](($(argA.name)).replace("3","2")))

            if ((argA.name in M3..MI3)) and (argB.kind==AreaUnit) and argA.kind!=argB.kind:
               return QuantitySpec(kind: LengthUnit, name: parseEnum[UnitName](($(argA.name)).replace("3","")))
            # if tup == (M2,M): return QuantitySpec(kind: LengthUnit, name: M)
            # elif tup == (CM2,CM): return QuantitySpec(kind: LengthUnit, name: CM)
            # elif tup == (KM2,KM): return QuantitySpec(kind: LengthUnit, name: KM)
            # elif tup == (IN2,IN): return QuantitySpec(kind: LengthUnit, name: IN)
            # elif tup == (FT2,FT): return QuantitySpec(kind: LengthUnit, name: FT)
            # elif tup == (YD2,YD): return QuantitySpec(kind: LengthUnit, name: YD)
            # elif tup == (MI2,MI): return QuantitySpec(kind: LengthUnit, name: MI)
            # elif tup == (M3,M): return QuantitySpec(kind: AreaUnit, name: M2)
            # elif tup == (CM3,CM): return QuantitySpec(kind: AreaUnit, name: CM2)
            # elif tup == (MM3,MM): return QuantitySpec(kind: AreaUnit, name: MM2)
            # elif tup == (KM3,KM): return QuantitySpec(kind: AreaUnit, name: KM2)
            # elif tup == (IN3,IN): return QuantitySpec(kind: AreaUnit, name: IN2)
            # elif tup == (FT3,FT): return QuantitySpec(kind: AreaUnit, name: FT2)
            # elif tup == (YD3,YD): return QuantitySpec(kind: AreaUnit, name: YD2)
            # elif tup == (MI3,MI): return QuantitySpec(kind: AreaUnit, name: MI2)
            # elif tup == (M3,M2): return QuantitySpec(kind: LengthUnit, name: M)
            # elif tup == (CM3,CM2): return QuantitySpec(kind: LengthUnit, name: CM)
            # elif tup == (MM3,MM2): return QuantitySpec(kind: LengthUnit, name: MM)
            # elif tup == (KM3,KM2): return QuantitySpec(kind: LengthUnit, name: KM)
            # elif tup == (IN3,IN2): return QuantitySpec(kind: LengthUnit, name: IN)
            # elif tup == (FT3,FT2): return QuantitySpec(kind: LengthUnit, name: FT)
            # elif tup == (YD3,YD2): return QuantitySpec(kind: LengthUnit, name: YD)
            # elif tup == (MI3,MI2): return QuantitySpec(kind: LengthUnit, name: MI)
            # else: return ErrorQuantity
        else:
            discard

    return ErrorQuantity

proc parseQuantitySpec*(str: string): QuantitySpec =
    let unitName = parseEnum[UnitName](toUpperAscii(str))
    let unitKind = quantityKindForName(unitName)

    QuantitySpec(kind: unitKind, name: unitName)