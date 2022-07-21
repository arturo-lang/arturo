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

    UnitName* = enum
        AUD, CAD, EUR, USD

    QuantitySpec* = object
        kind*: UnitKind
        name*: UnitName

#=======================================
# Helpers
#=======================================

#=======================================
# Overloads
#=======================================

proc `$`*(qs: QuantitySpec): string =
    $(qs.name)

#=======================================
# Methods
#=======================================

proc parseQuantitySpec*(str: string): QuantitySpec =
    echo "parsing quantity spec: " & str
    QuantitySpec(kind: CurrencyUnit, name: USD)