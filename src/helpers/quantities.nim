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

import strutils

#=======================================
# Types
#=======================================

type
    UnitKind* = enum
        CurrencyUnit
        LengthUnit
        AreaUnit
        VolumeUnit
        SpeedUnit
        WeightUnit
        TimeUnit
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
        M, CM, MM, KM, IN, FT, FM, YD, MI

        # Area
        M2, CM2, MM2, KM2, IN2, FT2, YD2, MI2, AC

        # Volume
        M3, CM3, MM3, KM3, IN3, FT3, YD3, MI3, L, ML, PT, QT, GAL

        # Speed
        KPH, MPH, KN

        # Weight
        G, MG, KG, T, ST, OZ, LB

        # Temperature
        C, F, K

        NoName

    QuantitySpec* = object
        kind*: UnitKind
        name*: UnitName

#=======================================
# Helpers
#=======================================

func quantityKindForName(un: UnitName): UnitKind =
    case un:
        of AED..ZAR     :   CurrencyUnit
        of M..MI        :   LengthUnit
        of M2..AC       :   AreaUnit
        of M3..GAL      :   VolumeUnit
        of KPH..KN      :   SpeedUnit
        of G..LB        :   WeightUnit
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

proc parseQuantitySpec*(str: string): QuantitySpec =
    let unitName = parseEnum[UnitName](toUpperAscii(str))
    let unitKind = quantityKindForName(unitName)

    QuantitySpec(kind: unitKind, name: unitName)