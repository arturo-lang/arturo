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

    QuantitySpec* = (UnitKind, UnitName)

#=======================================
# Helpers
#=======================================

#=======================================
# Methods
#=======================================

proc parseQuantitySpec*(str: string): QuantitySpec =
    (CurrencyUnit,USD)