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

import strutils, tables

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
        J, KJ, MJ, WH, KWH, ERG, HP

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
        M: 1.0,
        CM: 0.01,
        MM: 0.001,
        KM: 1000.0,
        IN: 0.0254,
        FT: 0.3048,
        FM: 1.8288,
        YD: 0.9144,
        MI: 1609.34,
        NMI: 1852.0
    }.toTable

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
        of J..HP        :   EnergyUnit
        of KPH..KN      :   SpeedUnit
        of G..LB        :   WeightUnit
        of BIT..TB      :   CapacityUnit
        of C..K         :   TemperatureUnit
        else:
            NoUnit

#=======================================
# Overloads
#=======================================

proc `$`*(qs: QuantitySpec): string =
    toLowerAscii($(qs.name)).replace("2","²").replace("3", "³")

#=======================================
# Methods
#=======================================

proc getQuantityMultiplier*(src: QuantitySpec, tgt: QuantitySpec): float =
    if src.kind != tgt.kind: return CannotConvertQuantity

    return ConversionRatio[src.name] / ConversionRatio[tgt.name]

proc parseQuantitySpec*(str: string): QuantitySpec =
    let unitName = parseEnum[UnitName](toUpperAscii(str))
    let unitKind = quantityKindForName(unitName)

    QuantitySpec(kind: unitKind, name: unitName)