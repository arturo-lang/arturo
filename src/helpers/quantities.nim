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
        AUD, CAD, EUR, USD
        NoName

    QuantitySpec* = object
        kind*: UnitKind
        name*: UnitName

#=======================================
# Helpers
#=======================================

func quantityKindForName(un: UnitName): UnitKind =
    case un:
        of AUD, CAD, EUR, USD:
            CurrencyUnit
        else:
            NoUnit

#=======================================
# Overloads
#=======================================

proc `$`*(qs: QuantitySpec): string =
    $(qs.name)

#=======================================
# Methods
#=======================================

proc parseQuantitySpec*(str: string): QuantitySpec =
    echo "quantity to parse: |" & str & "|"
    let unitName = parseEnum[UnitName](toUpperAscii(str))
    let unitKind = quantityKindForName(unitName)

    QuantitySpec(kind: unitKind, name: unitName)