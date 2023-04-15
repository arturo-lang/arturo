#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/custom/vquantity.nim
#=======================================================

## The internal `:quantity` type

#=======================================
# Libraries
#=======================================

import macros, parseutils, strutils, tables

include vquantity/preprocessor

#=======================================
# Core definitions
#=======================================

static:
    #----------------------------------------------------------------------------------------------------
    # Quantities
    #----------------------------------------------------------------------------------------------------
    #              name                     signatures
    #----------------------------------------------------------------------------------------------------
    defineQuantity "Acceleration",          -39
    defineQuantity "Activity",              3_199_980
    defineQuantity "Angle",                 512_000_000_000
    defineQuantity "Angular Momentum",      7981
    defineQuantity "Angular Velocity",      511_999_999_980
    defineQuantity "Area",                  2
    defineQuantity "Area Density",          7998
    defineQuantity "Capacitance",           312_078
    defineQuantity "Charge",                160_020
    defineQuantity "Conductance",           312_058
    defineQuantity "Currency",              1_280_000_000
    defineQuantity "Current",               160_000
    defineQuantity "Density",               7997
    defineQuantity "Elastance",             312_078
    defineQuantity "Energy",                7962
    defineQuantity "Force",                 7961
    defineQuantity "Frequency",             20
    defineQuantity "Illuminance",           63_999_998
    defineQuantity "Inductance",            312_038
    defineQuantity "Information",           25_600_000_000
    defineQuantity "Jolt",                  59
    defineQuantity "Length",                1
    defineQuantity "Luminous Power",        64_000_000
    defineQuantity "Magnetism",             -152_040, -152_038, 159_999
    defineQuantity "Mass",                  8000
    defineQuantity "Molar Concentration",   3_199_997
    defineQuantity "Momentum",              7981
    defineQuantity "Potential",             -152_058
    defineQuantity "Power",                 7942
    defineQuantity "Pressure",              7959
    defineQuantity "Radiation",             -38
    defineQuantity "Radiation Exposure",    152_020
    defineQuantity "Resistance",            -312_058
    defineQuantity "Specific Volume",       -7997
    defineQuantity "Speed",                 -19
    defineQuantity "Snap",                  -79
    defineQuantity "Substance",             3_200_000
    defineQuantity "Temperature",           400
    defineQuantity "Time",                  20
    defineQuantity "Unitless",              0
    defineQuantity "Viscosity",             -18, 7979
    defineQuantity "Volume",                3
    defineQuantity "Volumetric Flow",       -17
    defineQuantity "Wave Number",           -1
    defineQuantity "Yank",                  7941

    #----------------------------------------------------------------------------------------------------
    # Base units
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      unit kind                   aliases
    #----------------------------------------------------------------------------------------------------
    define "M",         "m",        "Length",                   "meter", "metre", "meters", "metres"
    define "S",         "s",        "Time",                     "second", "seconds"
    define "K",         "K",        "Temperature",              "kelvin", "kelvins"
    define "G",         "g",        "Mass",                     "gram", "grams"
    define "A",         "A",        "Current",                  "amp", "amps", "ampere", "amperes"
    define "MOL",       "mol",      "Substance",                "mole", "moles"
    define "CD",        "cd",       "Luminosity",               "candela", "candelas"
    define "USD",       "usd",      "Currency",                 "dollar", "dollars"
    define "B",         "B",        "Information",              "byte", "bytes"
    define "RAD",       "rad",      "Angle",                    "radian", "radians"

    #----------------------------------------------------------------------------------------------------
    # Length units (base: m)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "IN",        "in",       "127/5000 m",               "inch", "inches"
    define "FT",        "ft",       "12 in",                    "foot", "feet"
    define "YD",        "yd",       "3 ft",                     "yard", "yards"
    define "MI",        "mi",       "5280 ft",                  "mile", "miles"
    define "NMI",       "nmi",      "1852 m",                   "nauticalMile", "nauticalMiles"
    define "AU",        "au",       "149597870700 m",           "astronomicalUnit", "astronomicalUnits"
    define "LY",        "ly",       "9460730472580800 m",       "lightYear", "lightYears"
    define "PC",        "pc",       "3.26156 ly",               "parsec", "parsecs"

    #----------------------------------------------------------------------------------------------------
    # Area units (base: m^2)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "AC",        "ac",       "4840 yd2",                 "acre", "acres"
    define "ARE",       "are",      "100 m2",                   "are", "ares"
    define "HA",        "ha",       "100 are",                  "hectare", "hectares"

    #----------------------------------------------------------------------------------------------------
    # Volume units (base: m^3)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "L",         "l",        "1000 cm3",                 "liter", "liters"
    define "TSP",       "tsp",      "5 mL",                     "teaspoon", "teaspoons"
    define "TBS",       "tbs",      "3 tsp",                    "tablespoon", "tablespoons"
    define "FLOZ",      "floz",     "2 tbs",                    "fluidOunce", "fluidOunces"
    define "CUP",       "cup",      "8 floz",                   "cup", "cups"
    define "PT",        "pt",       "2 cup",                    "pint", "pints"
    define "QT",        "qt",       "2 pt",                     "quart", "quarts"
    define "GAL",       "gal",      "4 qt",                     "gallon", "gallons"
    define "BARREL",    "bbl",      "42 gal",                   "barrel", "barrels"
    
    #----------------------------------------------------------------------------------------------------
    # Time units (base: s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "MIN",       "min",      "60 s",                     "minute", "minutes"
    define "HR",        "hr",       "60 min",                   "hour", "hours"
    define "DAY",       "day",      "24 hr",                    "day", "days"
    define "WK",        "wk",       "7 day",                    "week", "weeks"
    define "MO",        "mo",       "2629746 s",                "month", "months"
    define "YR",        "yr",       "31556952 s",               "year", "years"
    define "DECADE",    "decade",   "10 yr",                    "decade", "decades"
    define "CENTURY",   "century",  "100 yr",                   "century", "centuries"

    #----------------------------------------------------------------------------------------------------
    # Mass units (base: g)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "LB",        "lb",       "45359237/100000000 g",     "pound", "pounds"
    define "OZ",        "oz",       "1/16 lb",                  "ounce", "ounces"
    define "TON",       "ton",      "2000 lb",                  "ton", "tons"
    define "ST",        "st",       "14 lb",                    "stone", "stones"
    
    


#=======================================
# Types
#=======================================

type
    Unit            = getUnits()
    UnitKind        = getUnitKinds()
    QuantityKind    = getQuantityKinds()

    QuantitySignature = int64

    UnitArray = seq[Unit]
    Units = tuple
        n: UnitArray        # numerator
        d: UnitArray        # denominator

    Quantity = tuple
        original: float     # the original value
        value: float        # the value after conversion to base units
        tp: QuantityKind    # the quantity kind
        units: Units        # the units
        base: bool          # whether the value is a base value

#=======================================
# Constants
#=======================================

const
    BaseUnits = getBaseUnits()
    QuantitySignatures: Table[QuantitySignature, QuantityKind] = getQuantitySignatures()


when isMainModule:
    for i in items(Unit):
        echo $i

    for i in items(UnitKind):
        echo $i

    echo $(BaseUnits)
    echo $(QuantitySignatures)
