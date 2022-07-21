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

        NoName

    QuantitySpec* = object
        kind*: UnitKind
        name*: UnitName

#=======================================
# Helpers
#=======================================

func quantityKindForName(un: UnitName): UnitKind =
    case un:
        of AED..ZAR:
            CurrencyUnit
        else:
            NoUnit

#=======================================
# Overloads
#=======================================

proc `$`*(qs: QuantitySpec): string =
    toLowerAscii($(qs.name))

#=======================================
# Methods
#=======================================

proc parseQuantitySpec*(str: string): QuantitySpec =
    let unitName = parseEnum[UnitName](toUpperAscii(str))
    let unitKind = quantityKindForName(unitName)

    QuantitySpec(kind: unitKind, name: unitName)