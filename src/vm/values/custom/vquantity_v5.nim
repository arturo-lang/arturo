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
    define "m",         "m",        "Length",                   "meter", "metre", "meters", "metres"
    define "s",         "s",        "Time",                     "second", "seconds"
    define "K",         "K",        "Temperature",              "kelvin", "kelvins"
    define "g",         "g",        "Mass",                     "gram", "grams"
    define "A",         "A",        "Current",                  "amp", "amps", "ampere", "amperes"
    define "mol",       "mol",      "Substance",                "mole", "moles"
    define "cd",        "cd",       "Luminosity",               "candela", "candelas"
    define "usd",       "usd",      "Currency",                 "dollar", "dollars"
    define "B",         "B",        "Information",              "byte", "bytes"
    define "rad",       "rad",      "Angle",                    "radian", "radians"

    #----------------------------------------------------------------------------------------------------
    # Length units (base: m)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "in",        "in",       "127/5000 m",               "inch", "inches"
    define "ft",        "ft",       "12 in",                    "foot", "feet"
    define "yd",        "yd",       "3 ft",                     "yard", "yards"
    define "ftm",       "ftm",      "1 yd",                     "fathom", "fathoms"
    define "rod",       "rod",      "5.5 yd",                   "rods"
    define "mi",        "mi",       "5280 ft",                  "mile", "miles"
    define "fur",       "fur",      "1/8 mi",                   "furlong", "furlongs"
    define "nmi",       "nmi",      "1852 m",                   "nauticalMile", "nauticalMiles"
    define "ang",       "Å",        "1e-10 m",                  "angstrom", "angstroms"
    define "au",        "au",       "149597870700 m",           "astronomicalUnit", "astronomicalUnits"
    define "ly",        "ly",       "9460730472580800 m",       "lightYear", "lightYears"
    define "pc",        "pc",       "3.26156 ly",               "parsec", "parsecs"

    #----------------------------------------------------------------------------------------------------
    # Area units (base: m^2)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "ac",        "ac",       "4840 yd2",                 "acre", "acres"
    define "are",       "are",      "100 m2",                   "are", "ares"
    define "ha",        "ha",       "100 are",                  "hectare", "hectares"

    #----------------------------------------------------------------------------------------------------
    # Volume units (base: m^3)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "l",         "l",        "1000 cm3",                 "liter", "liters"
    define "tsp",       "tsp",      "5 mL",                     "teaspoon", "teaspoons"
    define "tbsp",      "tbsp",     "3 tsp",                    "tablespoon", "tablespoons"
    define "floz",      "floz",     "2 tbsp",                   "fluidOunce", "fluidOunces"
    define "cup",       "cup",      "8 floz",                   "cup", "cups"
    define "pt",        "pt",       "2 cup",                    "pint", "pints"
    define "qt",        "qt",       "2 pt",                     "quart", "quarts"
    define "gal",       "gal",      "4 qt",                     "gallon", "gallons"
    define "bbl",       "bbl",      "42 gal",                   "barrel", "barrels"
    
    #----------------------------------------------------------------------------------------------------
    # Time units (base: s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "min",       "min",      "60 s",                     "minute", "minutes"
    define "hr",        "hr",       "60 min",                   "hour", "hours"
    define "day",       "day",      "24 hr",                    "day", "days"
    define "wk",        "wk",       "7 day",                    "week", "weeks"
    define "mo",        "mo",       "2629746 s",                "month", "months"
    define "yr",        "yr",       "31556952 s",               "year", "years"

    #----------------------------------------------------------------------------------------------------
    # Mass units (base: g)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "lb",        "lb",       "45359237/100000000 g",     "pound", "pounds"
    define "oz",        "oz",       "1/16 lb",                  "ounce", "ounces"
    define "ct",        "ct",       "1/5 g",                    "carat", "carats"
    define "ton",       "ton",      "2000 lb",                  "ton", "tons"
    define "st",        "st",       "14 lb",                    "stone", "stones"
    
    #----------------------------------------------------------------------------------------------------
    # Speed units (base: m/s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "mps",       "m/s",      "1 m/s",                    "meterPerSecond", "metersPerSecond"
    define "kph",       "km/h",     "1000/3600 m/s",            "kilometerPerHour", "kilometersPerHour"
    define "mph",       "mph",      "5280/3600 ft/s",           "milePerHour", "milesPerHour"
    define "kn",        "kn",       "1852/3600 m/s",            "knot", "knots"
    define "fps",       "ft/s",     "1/3600 ft/s",              "footPerSecond", "feetPerSecond"
    define "mach",      "mach",     "340.29 m/s",               "mach", "machs"

    #----------------------------------------------------------------------------------------------------
    # Force units (base: N = 1 kg.m/s2)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "N",         "N",        "1 kg.m/s2",                "newton", "newtons"
    define "dyn",       "dyn",      "1e-5 N",                   "dyne", "dynes"
    define "lbf",       "lbf",      "4.44822 N",                "poundsForce"
    define "kgf",       "kgf",      "9.80665 N",                "kilogramsForce"
    define "pdl",       "pdl",      "1 lb.ft/s2",               "poundal", "poundals"

    #----------------------------------------------------------------------------------------------------
    # Pressure units (base: Pa = 1 N/m2)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "Pa",        "Pa",       "1 N/m2",                   "pascal", "pascals"
    define "atm",       "atm",      "101325 Pa",                "atmosphere", "atmospheres"
    define "bar",       "bar",      "100000 Pa",                "bar", "bars"
    define "mmHg",      "mmHg",     "133.3223684 Pa",           "millimeterOfMercury", "millimetersOfMercury"
    define "psi",       "psi",      "6894.757293 Pa",           "poundPerSquareInch", "poundsPerSquareInch"
    define "Torr",      "Torr",     "133.3223684 Pa",           "torr", "torrs"

    #----------------------------------------------------------------------------------------------------
    # Energy units (base: J = 1 N.m)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "J",         "J",        "1 N.m",                    "joule", "joules"
    define "cal",       "cal",      "4.184 J",                  "calorie", "calories"
    define "BTU",       "BTU",      "1055.05585262 J",          "britishThermalUnit", "britishThermalUnits"
    define "eV",        "eV",       "1.602176565e-19 J",        "electronVolt", "electronVolts"
    define "erg",       "erg",      "1e-7 J",                   "erg", "ergs"

    #----------------------------------------------------------------------------------------------------
    # Power units (base: W = 1 J/s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "W",         "W",        "1 J/s",                    "watt", "watts"
    define "hp",        "hp",       "745.69987158227 W",        "horsepower"

    #----------------------------------------------------------------------------------------------------
    # Potential units (base: V = 1 W/A)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "V",         "V",        "1 W/A",                    "volt", "volts"

    #----------------------------------------------------------------------------------------------------
    # Resistance units (base: Ohm = 1 V/A)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "Ohm",       "Ω",      "1 V/A",                    "ohm", "ohms"

    #----------------------------------------------------------------------------------------------------
    # Conductance units (base: S = 1 A/V)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "S",         "S",        "1 A/V",                    "siemens"

    #----------------------------------------------------------------------------------------------------
    # Charge units (base: C = 1 A.s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "C",         "C",        "1 A.s",                    "coulomb", "coulombs"

    #----------------------------------------------------------------------------------------------------
    # Capacitance units (base: F = 1 C/V)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "F",         "F",        "1 C/V",                    "farad", "farads"

    #----------------------------------------------------------------------------------------------------
    # Inductance units (base: H = 1 V.s/A)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "H",         "H",        "1 V.s/A",                  "henry", "henrys"

    #----------------------------------------------------------------------------------------------------
    # Magnetic flux units (base: Wb = 1 V.s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "Wb",        "Wb",       "1 V.s",                    "weber", "webers"
    define "Mx",        "Mx",       "1e-8 Wb",                  "maxwell", "maxwells"

    #----------------------------------------------------------------------------------------------------
    # Magnetic flux density units (base: T = 1 Wb/m2)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "T",         "T",        "1 Wb/m2",                  "tesla", "teslas"
    define "G",         "G",        "1e-4 T",                   "gauss", "gauss"

    #----------------------------------------------------------------------------------------------------
    # Temperature units (base: K)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "degC",      "°C",       "",                         "celsius"
    define "degF",      "°F",       "",                         "fahrenheit"
    define "degR",      "°R",       "",                         "rankine"

    #----------------------------------------------------------------------------------------------------
    # Angle units (base: rad)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "deg",       "°",        "pi/180 rad",               "degree", "degrees"
    define "grad",      "grad",     "pi/200 rad",               "gradian", "gradians"
    define "arcmin",    "'",        "pi/10800 rad",             "arcminute", "arcminutes"
    define "arcsec",    "''",       "pi/648000 rad",            "arcsecond", "arcseconds"

    #----------------------------------------------------------------------------------------------------
    # Catalytic activity units (base: mol/s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "kat",       "kat",      "1 mol/s",                  "katal", "katals"

    #----------------------------------------------------------------------------------------------------
    # Frequency units (base: Hz = 1/s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "Hz",        "Hz",       "1 1/s",                    "hertz"

    #----------------------------------------------------------------------------------------------------
    # Radiation units (base: Bq = 1/s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "Bq",        "Bq",       "1 1/s",                    "becquerel", "becquerels"
    define "Ci",        "Ci",       "3.7e10 Bq",                "curie", "curies"

    #----------------------------------------------------------------------------------------------------
    # Radiation exposure units (base: Gy = J/kg)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "Gy",        "Gy",       "1 J/kg",                   "gray", "grays"
    define "Sv",        "Sv",       "1 J/kg",                   "sievert", "sieverts"
    define "R",         "R",        "1e-2 Gy",                  "roentgen", "roentgens"

    #----------------------------------------------------------------------------------------------------
    # Viscosity units (base: Pa.s)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "P",         "P",        "1 dPa.s",                  "poise", "poises"

    #----------------------------------------------------------------------------------------------------
    # Illuminance units (base: lx = cd/m2)
    #----------------------------------------------------------------------------------------------------
    #      name         symbol      definition                  aliases
    #----------------------------------------------------------------------------------------------------
    define "lx",        "lx",       "1 cd/m2",                  "lux", "luxes"

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
