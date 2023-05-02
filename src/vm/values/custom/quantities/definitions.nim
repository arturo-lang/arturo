#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/custom/quantities/definitions.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import preprocessor

#=======================================
# Core definitions
#=======================================

static:
    #----------------------------------------------------------------------------------------------------
    # Properties
    #----------------------------------------------------------------------------------------------------
    #            name                           formula
    #----------------------------------------------------------------------------------------------------
    defProperty "Acceleration",                 "L·T⁻²"
    defProperty "Action",                       "L²·M·T⁻¹"                    
    defProperty "Angle",                        "A"  
    defProperty "Angular Velocity",             "T⁻¹·A"
    defProperty "Area",                         "L²"
    defProperty "Area Density",                 "L⁻²·M"
    defProperty "Capacitance",                  "L⁻²·M⁻¹·T⁴·I²"
    defProperty "Charge",                       "T·I"     
    defProperty "Conductance",                  "L⁻²·M⁻¹·T³·I²"
    defProperty "Currency",                     "C"           
    defProperty "Current",                      "I"
    defProperty "Current Density",              "L⁻²·I"
    defProperty "Data-transfer Rate",           "T⁻¹·B"
    defProperty "Density",                      "L⁻³·M"
    defProperty "Elastance",                    "L²·M·T⁻⁴·I⁻²"                
    defProperty "Electric Field",               "L·M·T⁻³·I⁻¹"
    defProperty "Electricity Price",            "L⁻²·M⁻¹·T²·C"
    defProperty "Energy",                       "L²·M·T⁻²"
    defProperty "Entropy",                      "L²·M·T⁻²·K⁻¹"
    defProperty "Force",                        "L·M·T⁻²"
    defProperty "Frequency",                    "T⁻¹"
    defProperty "Heat Flux",                    "M·T⁻³"
    defProperty "Illuminance",                  "L⁻²·J"
    defProperty "Inductance",                   "L²·M·T⁻²·I⁻²"
    defProperty "Information",                  "B"
    defProperty "Jerk",                         "L·T⁻³"
    defProperty "Kinematic Viscosity",          "L²·T⁻¹"
    defProperty "Length",                       "L"
    defProperty "Luminosity",                   "J"      
    defProperty "Luminous Flux",                "J·S"
    defProperty "Magnetic Flux",                "L²·M·T⁻²·I⁻¹"
    defProperty "Magnetic Flux Density",        "M·T⁻²·I⁻¹"
    defProperty "Magnetic Field Strength",      "L⁻¹·I"
    defProperty "Mass",                         "M"
    defProperty "Mass Flow Rate",               "M·T⁻¹"
    defProperty "Molar Concentration",          "L⁻³·N"
    defProperty "Mole Flow Rate",               "N·T⁻¹"
    defProperty "Moment of Inertia",            "L²·M"
    defProperty "Momentum",                     "L·M·T⁻¹"
    defProperty "Permeability",                 "L·M·T⁻²·I⁻²"
    defProperty "Permittivity",                 "L⁻³·M⁻¹·T⁴·I²"
    defProperty "Potential",                    "L²·M·T⁻³·I⁻¹"
    defProperty "Power",                        "L²·M·T⁻³"
    defProperty "Pressure",                     "L⁻¹·M·T⁻²"
    defProperty "Radiation",                    "L²·T⁻²"
    defProperty "Radiation Exposure",           "M⁻¹·T·I"
    defProperty "Resistance",                   "L²·M·T⁻³·I⁻²"
    defProperty "Resistivity",                  "L³·M·T⁻³·I⁻²"
    defProperty "Salary",                       "T⁻¹·C"
    defProperty "Solid Angle",                  "S" 
    defProperty "Specific Volume",              "L³·M⁻¹"
    defProperty "Speed",                        "L·T⁻¹"
    defProperty "Snap",                         "L·T⁻⁴"
    defProperty "Substance",                    "N"              
    defProperty "Surface Tension",              "M·T⁻²"
    defProperty "Temperature",                  "K"
    defProperty "Thermal Conductivity",         "L·M·T⁻³·K⁻¹"
    defProperty "Thermal Insulance",            "M⁻¹·T³·K"
    defProperty "Time",                         "T"
    defProperty "Unitless",                     ""           
    defProperty "Viscosity",                    "L⁻¹·M·T⁻¹"
    defProperty "Volume",                       "L³"
    defProperty "Volumetric Flow",              "L³·T⁻¹"
    defProperty "Wave Number",                  "L⁻¹"

    #----------------------------------------------------------------------------------------------------
    # Prefixes
    #----------------------------------------------------------------------------------------------------
    #          name         symbol      definition 
    #----------------------------------------------------------------------------------------------------
    defPrefix "a",          "a",        -18
    defPrefix "f",          "f",        -15
    defPrefix "p",          "p",        -12
    defPrefix "n",          "n",        -9
    defPrefix "u",          "μ",        -6
    defPrefix "m",          "m",        -3
    defPrefix "c",          "c",        -2
    defPrefix "d",          "d",        -1
    defPrefix "No",         "",         0
    defPrefix "da",         "da",       1
    defPrefix "h",          "h",        2
    defPrefix "k",          "k",        3
    defPrefix "M",          "M",        6
    defPrefix "G",          "G",        9
    defPrefix "T",          "T",        12
    defPrefix "P",          "P",        15
    defPrefix "E",          "E",        18

    #---------------------------------------------------------------------------------------------------------------------------
    # Base units
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     unit kind                   aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "m",        "m",        true,       "Length",                   "meter", "metre", "meters", "metres"
    defUnit "s",        "s",        true,       "Time",                     "second", "seconds"
    defUnit "K",        "K",        true,       "Temperature",              "kelvin", "kelvins"
    defUnit "g",        "g",        true,       "Mass",                     "gram", "grams"
    defUnit "A",        "A",        true,       "Current",                  "amp", "amps", "ampere", "amperes"
    defUnit "mol",      "mol",      true,       "Substance",                "mole", "moles"
    defUnit "cd",       "cd",       true,       "Luminosity",               "candela", "candelas"
    defUnit "USD",      "$",        false,      "Currency",                 "dollar", "dollars"
    defUnit "B",        "B",        true,       "Information",              "byte", "bytes"
    defUnit "rad",      "rad",      false,      "Angle",                    "radian", "radians"
    defUnit "sr",       "sr",       false,      "Solid Angle",              "steradian", "steradians"

    #---------------------------------------------------------------------------------------------------------------------------
    # Length units (base: m)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "in",       "in",       false,      "127:5000 m",               "inch", "inches"
    defUnit "ft",       "ft",       false,      "12 in",                    "foot", "feet"
    defUnit "yd",       "yd",       false,      "3 ft",                     "yard", "yards"
    defUnit "ftm",      "ftm",      false,      "1 yd",                     "fathom", "fathoms"
    defUnit "rod",      "rod",      false,      "5.5 yd",                   "rods"
    defUnit "mi",       "mi",       false,      "5280 ft",                  "mile", "miles"
    defUnit "fur",      "fur",      false,      "1:8 mi",                   "furlong", "furlongs"
    defUnit "nmi",      "nmi",      false,      "1852 m",                   "nauticalMile", "nauticalMiles"
    defUnit "ang",      "Å",        false,      "1e-10 m",                  "angstrom", "angstroms"
    defUnit "au",       "au",       false,      "149597870700 m",           "astronomicalUnit", "astronomicalUnits"
    defUnit "ly",       "ly",       false,      "9460730472580800 m",       "lightYear", "lightYears"
    defUnit "px",       "px",       true,       "1:96 in",                  "pixel", "pixels"
    defUnit "pt",       "pt",       true,       "1:72 in",                  "point", "points"
    defUnit "pc",       "pc",       true,       "12 pt",                    "pica", "picas"

    #---------------------------------------------------------------------------------------------------------------------------
    # Area units (base: m^2)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "sqin",     "in²",      false,      "1 in2",                    "squareInch", "squareInches"
    defUnit "sqft",     "ft²",      false,      "1 ft2",                    "squareFoot", "squareFeet"
    defUnit "ac",       "ac",       false,      "4840 yd2",                 "acre", "acres"
    defUnit "are",      "are",      false,      "100 m2",                   "ares"
    defUnit "ha",       "ha",       false,      "100 are",                  "hectare", "hectares"
    defUnit "barn",     "b",        false,      "100 ftm2",                 "barns"

    #---------------------------------------------------------------------------------------------------------------------------
    # Volume units (base: m^3)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "L",        "L",        true,       "1000 cm3",                 "l", "liter", "liters"
    defUnit "gal",      "gal",      false,      "231 in3",                  "gals", "gallon", "gallons"
    defUnit "bbl",      "bbl",      false,      "42 gal",                   "barrel", "barrels"
    defUnit "qt",       "qt",       false,      "1:4 gal",                  "quart", "quarts"
    defUnit "p",        "p",        false,      "1:2 qt",                   "pint", "pints"
    defUnit "cup",      "cup",      false,      "1:2 p",                    "cups"
    defUnit "floz",     "floz",     false,      "1:8 cup",                  "fluidOunce", "fluidOunces"
    defUnit "tbsp",     "tbsp",     false,      "1:2 floz",                 "tablespoon", "tablespoons"
    defUnit "tsp",      "tsp",      false,      "1:3 tbsp",                 "teaspoon", "teaspoons"
    defUnit "bu",       "bu",       false,      "2150.42 in3",              "bushel", "bushels"
    defUnit "cord",     "cord",     false,      "128 ft3",                  "cords"
    
    #---------------------------------------------------------------------------------------------------------------------------
    # Time units (base: s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "min",      "min",      false,      "60 s",                     "minute", "minutes"
    defUnit "h",        "h",       false,       "60 min",                   "hour", "hours", "hr", "hrs"
    defUnit "day",      "day",      false,      "24 hr",                    "days"
    defUnit "wk",       "wk",       false,      "7 days",                   "week", "weeks"
    defUnit "mo",       "mo",       false,      "2629746 s",                "month", "months"
    defUnit "yr",       "yr",       false,      "31556952 s",               "year", "years"

    #---------------------------------------------------------------------------------------------------------------------------
    # Mass units (base: g)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "lb",       "lb",       false,      "45359237:100000 g",        "pound", "pounds"
    defUnit "slug",     "slug",     false,      "14.59390 kg",              "slugs"
    defUnit "oz",       "oz",       false,      "1:16 lb",                  "ounce", "ounces"
    defUnit "ct",       "ct",       false,      "1:5 g",                    "carat", "carats"
    defUnit "t",        "t",        false,      "1000 kg",                  "tonne", "tonnes", "metricTon", "metricTons"
    defUnit "ton",      "ST",       false,      "2000 lb",                  "tons", "shortTon", "shortTons"
    defUnit "lt",       "LT",       false,      "2240 lb",                  "longTon", "longTons"
    defUnit "st",       "st",       false,      "14 lb",                    "stone", "stones"
    defUnit "Da",       "Da",       false,      "1.66053906660e-27 kg",     "dalton", "daltons", "AMU"
    defUnit "gr",       "gr",       false,      "64.79891 mg",              "grain", "grains"
    defUnit "dwt",      "dwt",      false,      "24 gr",                    "pennyweight", "pennyweights"
    defUnit "ozt",      "ozt",      false,      "20 dwt",                   "troyOunce", "troyOunces"
    defUnit "lbt",      "lbt",      false,      "12 ozt",                   "troyPound", "troyPounds"
    
    #---------------------------------------------------------------------------------------------------------------------------
    # Speed units (base: m/s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "mps",      "m/s",      false,      "1 m/s",                    "meterPerSecond", "metersPerSecond"
    defUnit "kph",      "km/h",     false,      "1000:3600 m/s",            "kilometerPerHour", "kilometersPerHour"
    defUnit "mph",      "mph",      false,      "5280:3600 ft/s",           "milePerHour", "milesPerHour"
    defUnit "kn",       "kn",       false,      "1852:3600 m/s",            "knot", "knots"
    defUnit "fps",      "ft/s",     false,      "1:3600 ft/s",              "footPerSecond", "feetPerSecond"
    defUnit "mach",     "mach",     false,      "340.29 m/s",               "machs"

    #---------------------------------------------------------------------------------------------------------------------------
    # Acceleration units (base: m/s2)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Gal",      "Gal",      false,      "1 cm/s2",                  "galileo", "galileos"

    #---------------------------------------------------------------------------------------------------------------------------
    # Force units (base: N = 1 kg.m/s2)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "N",        "N",        true,       "1 kg.m/s2",                "newton", "newtons"
    defUnit "dyn",      "dyn",      false,      "1e-5 N",                   "dyne", "dynes"
    defUnit "lbf",      "lbf",      false,      "4.44822 N",                "poundsForce"
    defUnit "kgf",      "kgf",      false,      "9.80665 N",                "kilogramsForce"
    defUnit "pdl",      "pdl",      false,      "1 lb.ft/s2",               "poundal", "poundals"

    #---------------------------------------------------------------------------------------------------------------------------
    # Pressure units (base: Pa = 1 N/m2)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Pa",       "Pa",       true,       "1 N/m2",                   "pascal", "pascals"
    defUnit "atm",      "atm",      false,      "101325 Pa",                "atmosphere", "atmospheres"
    defUnit "bar",      "bar",      true,       "100000 Pa",                "bars"
    defUnit "pz",       "pz",       false,      "10 kPa",                   "pieze"
    defUnit "Ba",       "Ba",       false,      "1 dyn/cm2",                "barye", "baryes"
    defUnit "mmHg",     "mmHg",     false,      "133.3223684 Pa",           "millimeterOfMercury", "millimetersOfMercury"
    defUnit "psi",      "psi",      false,      "6894.757293 Pa",           "poundPerSquareInch", "poundsPerSquareInch"
    defUnit "Torr",     "Torr",     false,      "133.3223684 Pa",           "torr", "torrs"

    #---------------------------------------------------------------------------------------------------------------------------
    # Energy units (base: J = 1 N.m)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "J",        "J",        true,       "1 N.m",                    "joule", "joules"
    defUnit "Wh",       "Wh",       true,       "3600 J",                   "wattHour", "wattHours"
    defUnit "cal",      "cal",      true,       "4.184 J",                  "calorie", "calories"
    defUnit "BTU",      "BTU",      false,      "1055.05585262 J",          "britishThermalUnit", "britishThermalUnits"
    defUnit "eV",       "eV",       true,       "1.602176565e-19 J",        "electronVolt", "electronVolts"
    defUnit "erg",      "erg",      false,      "1e-7 J",                   "ergs"
    defUnit "th",       "th",       false,      "4.1868 MJ",                "thermie", "thermies"
    defUnit "thm",      "thm",      false,      "105.506 MJ",               "therm", "therms"

    #---------------------------------------------------------------------------------------------------------------------------
    # Power units (base: W = 1 J/s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "W",        "W",        true,       "1 J/s",                    "watt", "watts"
    defUnit "hp",       "hp",       false,      "745.69987158227 W",        "horsepower"

    #---------------------------------------------------------------------------------------------------------------------------
    # Electrical current units (base: A)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "statA",    "statA",    false,      "3.335641e-10 A",           "statampere", "statamperes"
    defUnit "abA",      "abA",      false,      "10 A",                     "abampere", "abamperes"
    defUnit "Bi",       "Bi",       false,      "10 A",                     "biot", "biots"

    #---------------------------------------------------------------------------------------------------------------------------
    # Potential units (base: V = 1 W/A)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "V",        "V",        true,       "1 W/A",                    "volt", "volts"
    defUnit "statV",    "statV",    false,      "299.792458 V",             "statvolt", "statvolts"
    defUnit "abV",      "abV",      false,      "1e-8 V",                   "abvolt", "abvolts"

    #---------------------------------------------------------------------------------------------------------------------------
    # Resistance units (base: Ohm = 1 V/A)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Ohm",      "Ω",        true,       "1 V/A",                    "ohm", "ohms"
    defUnit "statOhm",  "statΩ",    false,      "8.987551787e11 ohm",       "statohm", "statohms"
    defUnit "abOhm",    "abΩ",      false,      "1e-9 Ohm",                 "abohm", "abohms"

    #---------------------------------------------------------------------------------------------------------------------------
    # Conductance units (base: S = 1 A/V)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "S",        "S",        true,       "1 A/V",                    "siemens"

    #---------------------------------------------------------------------------------------------------------------------------
    # Charge units (base: C = 1 A.s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "C",        "C",        true,       "1 A.s",                    "coulomb", "coulombs"
    defUnit "statC",    "statC",    false,      "3.335641e-10 C",           "statcoulomb", "statcoulombs"
    defUnit "abC",      "abC",      false,      "10 C",                     "abcoulomb", "abcoulombs"
    defUnit "Fr",       "Fr",       false,      "1 statC",                  "franklin", "franklins"

    #---------------------------------------------------------------------------------------------------------------------------
    # Capacitance units (base: F = 1 C/V)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "F",        "F",        true,       "1 C/V",                    "farad", "farads"

    #---------------------------------------------------------------------------------------------------------------------------
    # Elastance units (base: 1/F)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Daraf",    "daraf",    true,       "1 1/F"                   

    #---------------------------------------------------------------------------------------------------------------------------
    # Inductance units (base: H = 1 V.s/A)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "H",        "H",        true,       "1 V.s/A",                  "henry", "henrys"
    defUnit "abH",      "abH",      false,      "1e-9 H",                   "abhenry", "abhenrys"

    #---------------------------------------------------------------------------------------------------------------------------
    # Magnetic flux units (base: Wb = 1 V.s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Wb",       "Wb",       true,       "1 V.s",                    "weber", "webers"
    defUnit "Mx",       "Mx",       true,       "1e-8 Wb",                  "maxwell", "maxwells"

    #---------------------------------------------------------------------------------------------------------------------------
    # Magnetic flux density units (base: T = 1 Wb/m2)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "T",        "T",        true,       "1 Wb/m2",                  "tesla", "teslas"
    defUnit "G",        "G",        true,       "1e-4 T",                   "gauss"

    #---------------------------------------------------------------------------------------------------------------------------
    # Temperature units (base: K)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "degC",     "°C",       false,      "1 K",                      "celsius", "oC"
    defUnit "degF",     "°F",       false,      "5:9 K",                    "fahrenheit", "oF"
    defUnit "degR",     "°R",       false,      "5:9 K",                    "rankine", "oR"

    #---------------------------------------------------------------------------------------------------------------------------
    # Information units (base: B)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "b",        "b",        true,       "1:8 B",                    "bit", "bits"
    defUnit "KiB",      "KiB",      false,      "1024 B",                   "kibibyte", "kibibytes"
    defUnit "MiB",      "MiB",      false,      "1024 KiB",                 "mebibyte", "mebibytes"
    defUnit "GiB",      "GiB",      false,      "1024 MiB",                 "gibibyte", "gibibytes"
    defUnit "TiB",      "TiB",      false,      "1024 GiB",                 "tebibyte", "tebibytes"
    defUnit "PiB",      "PiB",      false,      "1024 TiB",                 "pebibyte", "pebibytes"
    defUnit "EiB",      "EiB",      false,      "1024 PiB",                 "exbibyte", "exbibytes"

    #---------------------------------------------------------------------------------------------------------------------------
    # Angle units (base: rad)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "deg",      "°",        false,      "pi:180 rad",               "degree", "degrees"
    defUnit "grad",     "grad",     false,      "pi:200 rad",               "gradian", "gradians"
    defUnit "arcmin",   "'",        false,      "pi:10800 rad",             "arcminute", "arcminutes"
    defUnit "arcsec",   "''",       false,      "pi:648000 rad",            "arcsecond", "arcseconds"

    #---------------------------------------------------------------------------------------------------------------------------
    # Catalytic activity units (base: mol/s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "kat",      "kat",      true,       "1 mol/s",                  "katal", "katals"

    #---------------------------------------------------------------------------------------------------------------------------
    # Frequency units (base: Hz = 1/s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Hz",       "Hz",       true,       "1 1/s",                    "hertz"

    #---------------------------------------------------------------------------------------------------------------------------
    # Radiation units (base: Bq = 1/s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Bq",       "Bq",       true,       "1 1/s",                    "becquerel", "becquerels"
    defUnit "Ci",       "Ci",       true,       "3.7e10 Bq",                "curie", "curies"

    #---------------------------------------------------------------------------------------------------------------------------
    # Radiation exposure units (base: Gy = J/kg)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Gy",       "Gy",       true,       "1 J/kg",                   "gray", "grays"
    defUnit "Sv",       "Sv",       true,       "1 J/kg",                   "sievert", "sieverts"
    defUnit "R",        "R",        true,       "1e-2 Gy",                  "roentgen", "roentgens"

    #---------------------------------------------------------------------------------------------------------------------------
    # Viscosity units (base: Pa.s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "P",        "P",        true,       "1 dPa.s",                  "poise", "poises"

    #---------------------------------------------------------------------------------------------------------------------------
    # Kinematic viscosity units (base: St = m2/s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "St",       "St",       true,       "1 m2/s",                   "stokes"

    #---------------------------------------------------------------------------------------------------------------------------
    # Angular velocity units (base: rpm = rad/s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "rpm",      "rpm",      true,       "0.1047 rad/s",             "rpms"

    #---------------------------------------------------------------------------------------------------------------------------
    # Thermal insulance units (base: m2.K/W)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "clo",      "clo",      false,      "0.155 m2.K/W",             "clos"

    #---------------------------------------------------------------------------------------------------------------------------
    # Data-transfer rate units (base: bit/s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "bps",      "bps",      true,       "1 bit/s"

    #---------------------------------------------------------------------------------------------------------------------------
    # Illuminance units (base: lx = cd/m2)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "lx",       "lx",       true,       "1 cd/m2",                  "lux", "luxes"
    defUnit "Lb",       "Lb",       false,      "1:pi cd/cm2",              "lambert", "lamberts"

    #---------------------------------------------------------------------------------------------------------------------------
    # Luminous flux units (base: lm = cd.sr)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "lm",       "lm",       true,       "1 cd.sr",                  "lumen", "lumens"

    #----------------------------------------------------------------------------------------------------
    # Currencies
    #----------------------------------------------------------------------------------------------------
    #           name        symbol
    #----------------------------------------------------------------------------------------------------
    defCurrency "AED",      "د.إ"       # UAE Dinar
    defCurrency "ALL",      "Lek"       # Albania Lek
    defCurrency "ARS",      "$"         # Argentina Peso
    defCurrency "AUD",      "$"         # Australia Dollar
    defCurrency "BGN",      "лв"        # Bulgaria Lev
    defCurrency "BHD",      "BD"        # Bahrain Dinar
    defCurrency "BNB",      "BNB"       # Binance Coin
    defCurrency "BND",      "$"         # Brunei Darussalam Dollar
    defCurrency "BOB",      "$b"        # Bolivia Bolíviano
    defCurrency "BRL",      "R$"        # Brazil Real
    defCurrency "BTC",      "₿"         # Bitcoin
    defCurrency "BWP",      "P"         # Botswana Pula
    defCurrency "CAD",      "$"         # Canada Dollar
    defCurrency "CHF",      "CHF"       # Switzerland Franc
    defCurrency "CLP",      "$"         # Chile Peso
    defCurrency "CNY",      "¥"         # China Yuan Renminbi
    defCurrency "COP",      "$"         # Colombia Peso
    defCurrency "CRC",      "₡"         # Costa Rica Colon
    defCurrency "CZK",      "Kč"        # Czech Republic Koruna
    defCurrency "DKK",      "kr"        # Denmark Krone
    defCurrency "DOP",      "RD$"       # Dominican Republic Peso
    defCurrency "DZD",      "دج"        # Algeria Dinar
    defCurrency "EGP",      "£"         # Egypt Pound
    defCurrency "ETB",      "Br"        # Ethiopia Birr
    defCurrency "ETH",      "Ξ"         # Ethereum
    defCurrency "EUR",      "€"         # Euro
    defCurrency "FJD",      "$"         # Fiji Dollar
    defCurrency "GBP",      "£"         # United Kingdom Pound
    defCurrency "HKD",      "$"         # Hong Kong Dollar
    defCurrency "HNL",      "L"         # Honduras Lempira
    defCurrency "HRK",      "kn"        # Croatia Kuna
    defCurrency "HUF",      "Ft"        # Hungary Forint
    defCurrency "IDR",      "Rp"        # Indonesia Rupiah
    defCurrency "ILS",      "₪"         # Israel Shekel
    defCurrency "INR",      "₹"         # India Rupee
    defCurrency "IRR",      "﷼"         # Iran Rial
    defCurrency "ISK",      "kr"        # Iceland Krona
    defCurrency "JMD",      "J$"        # Jamaica Dollar
    defCurrency "JOD",      "JD"        # Jordan Dinar
    defCurrency "JPY",      "¥"         # Japan Yen
    defCurrency "KES",      "KSh"       # Kenya Shilling
    defCurrency "KRW",      "₩"         # Korea (South) Won
    defCurrency "KWD",      "KD"        # Kuwait Dinar
    defCurrency "KYD",      "$"         # Cayman Islands Dollar
    defCurrency "KZT",      "₸"         # Kazakhstan Tenge
    defCurrency "LBP",      "£"         # Lebanon Pound
    defCurrency "LKR",      "₨"         # Sri Lanka Rupee
    defCurrency "MAD",      "MAD"       # Morocco Dirham
    defCurrency "MDL",      "lei"       # Moldova Leu
    defCurrency "MKD",      "ден"       # Macedonia Denar
    defCurrency "MXN",      "$"         # Mexico Peso
    defCurrency "MUR",      "₨"         # Mauritius Rupee
    defCurrency "MYR",      "RM"        # Malaysia Ringgit
    defCurrency "NAD",      "$"         # Namibia Dollar
    defCurrency "NGN",      "₦"         # Nigeria Naira
    defCurrency "NIO",      "C$"        # Nicaragua Cordoba
    defCurrency "NOK",      "kr"        # Norway Krone
    defCurrency "NPR",      "₨"         # Nepal Rupee
    defCurrency "NZD",      "$"         # New Zealand Dollar
    defCurrency "OMR",      "﷼"         # Oman Rial
    defCurrency "PAB",      "B/."       # Panama Balboa
    defCurrency "PEN",      "S/."       # Peru Sol
    defCurrency "PGK",      "K"         # Papua New Guinea Kina
    defCurrency "PHP",      "₱"         # Philippines Peso
    defCurrency "PKR",      "₨"         # Pakistan Rupee
    defCurrency "PLN",      "zł"        # Poland Zloty
    defCurrency "PYG",      "Gs"        # Paraguay Guarani
    defCurrency "QAR",      "﷼"         # Qatar Riyal
    defCurrency "RON",      "lei"       # Romania Leu
    defCurrency "RSD",      "Дин."      # Serbia Dinar
    defCurrency "RUB",      "₽"         # Russia Ruble
    defCurrency "SAR",      "﷼"         # Saudi Arabia Riyal
    defCurrency "SCR",      "₨"         # Seychelles Rupee
    defCurrency "SEK",      "kr"        # Sweden Krona
    defCurrency "SGD",      "$"         # Singapore Dollar
    defCurrency "SLL",      "Le"        # Sierra Leone Leone
    defCurrency "SOS",      "S"         # Somalia Shilling
    defCurrency "SVC",      "$"         # El Salvador Colon
    defCurrency "THB",      "฿"         # Thailand Baht
    defCurrency "TND",      "د.ت"       # Tunisia Dinar
    defCurrency "TRY",      "₺"         # Turkey Lira
    defCurrency "TTD",      "TT$"       # Trinidad and Tobago Dollar
    defCurrency "TWD",      "NT$"       # Taiwan New Dollar
    defCurrency "TZS",      "TSh"       # Tanzania Shilling
    defCurrency "UAH",      "₴"         # Ukraine Hryvnia
    defCurrency "UGX",      "USh"       # Uganda Shilling
    defCurrency "UYU",      "$U"        # Uruguay Peso
    defCurrency "UZS",      "лв"        # Uzbekistan Som
    defCurrency "VES",      "Bs"        # Venezuela Bolivar
    defCurrency "VND",      "₫"         # Vietnam Dong
    defCurrency "XAF",      "FCFA"      # Central Africa CFA Franc
    defCurrency "XAG",      "XAG"       # Silver
    defCurrency "XAU",      "XAU"       # Gold
    defCurrency "XOF",      "CFA"       # West Africa CFA France
    defCurrency "YER",      "﷼"         # Yemen Rial
    defCurrency "ZAR",      "R"         # South Africa Rand
    defCurrency "ZMW",      "ZK"        # Zambia Kwacha

    #-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    # Constants
    #-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #           name                            pre-calculate?      definition                      description
    #-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    defConstant "alphaParticleMass",            false,              "6.64465675e-27 kg",            "the mass of an alpha particle"
    defConstant "angstromStar",                 false,              "1:10000000000 m",              "one ten-billionth of a meter"
    defConstant "atomicMass",                   false,              "1.660538921e-27 kg",           "the mass of an atomic mass unit"
    defConstant "avogadroConstant",             false,              "6.02214129e23 1/mol",          "the number of atoms in 12 grams of carbon-12"
    defConstant "bohrRadius",                   false,              "5.2917721092e-11 m",           "the radius of the first Bohr orbit of the hydrogen atom"
    defConstant "boltzmannConstant",            false,              "1.3806488e-23 J/K",            "the ratio of the universal gas constant to Avogadro's number"
    defConstant "classicalElectronRadius",      false,              "2.8179403267e-15 m",           "the radius of an electron"
    defConstant "conductanceQuantum",           true,               "7.7480917346e-5 S",            "the conductance of a superconductor"
    defConstant "deuteronMass",                 false,              "3.3435830926e-27 kg",          "the mass of a deuteron"
    defConstant "electronCharge",               false,              "1.602176565e-19 C",            "the charge of an electron"
    defConstant "electronMass",                 false,              "9.10938215e-31 kg",            "the mass of an electron"
    defConstant "electronMassEnergy",           false,              "8.18710506e-14 J",             "the energy equivalent of the mass of an electron"
    defConstant "gravitationalConstant",        false,              "6.6743e-11 m3/kg.s2",          "the gravitational constant"
    defConstant "hartreeEnergy",                false,              "4.35974434e-18 J",             "the energy of the ground state of the hydrogen atom"
    defConstant "helionMass",                   false,              "5.00641234e-27 kg",            "the mass of a helion"
    defConstant "impedanceOfVacuum",            true,               "376.730313461 ohm",            "the impedance of free space"
    defConstant "inverseConductanceQuantum",    false,              "12906.4037217 ohm",            "the inverse of the conductance of a superconductor"
    defConstant "josephsonConstant",            true,               "483597.891e9 Hz/V",            "The inverse of the flux quantum"
    defConstant "magneticFluxQuantum",          false,              "2.067833758e-15 Wb",           "the magnetic flux of a superconductor"
    defConstant "molarGasConstant",             true,               "8.3144621 J/mol.K",            "the universal gas constant"
    defConstant "muonMass",                     false,              "1.883531475e-28 kg",           "the mass of a muon"
    defConstant "neutronMass",                  false,              "1.674927351e-27 kg",           "the mass of a neutron"
    defConstant "planckConstant",               false,              "6.62606957e-34 J.s",           "the ratio of the energy of a photon to its frequency"
    defConstant "planckLength",                 false,              "1.616199e-35 m",               "the length of the Planck scale"
    defConstant "planckMass",                   false,              "2.17651e-8 kg",                "the mass of the Planck scale"
    defConstant "planckTemperature",            false,              "1.416833e32 K",                "the temperature of the Planck scale"
    defConstant "planckTime",                   false,              "5.39116e-44 s",                "the time of the Planck scale"
    defConstant "protonMass",                   false,              "1.672621777e-27 kg",           "the mass of a proton"
    defConstant "protonMassEnergy",             false,              "1.503277484e-10 J",            "the energy equivalent of the mass of a proton"
    defConstant "reducedPlanckConstant",        false,              "1.054571726e-34 J.s",          "the ratio of the energy of a photon to its frequency"
    defConstant "rydbergConstant",              true,               "10973731.56853955 1/m",        "the Rydberg constant"
    defConstant "speedOfLight",                 true,               "299792458 m/s",                "the speed of light in a vacuum"
    defConstant "standardGasVolume",            true,               "22.41410e-3 m3/mol",           "the volume of one mole of an ideal gas at standard temperature and pressure"
    defConstant "standardPressure",             true,               "100 kPa",                      "the standard pressure"
    defConstant "standardTemperature",          true,               "273.15 K",                     "the standard temperature"
    defConstant "tauMass",                      false,              "3.16747e-27 kg",               "the mass of a tau"
    defConstant "thomsonCrossSection",          false,              "6.652458734e-29 m2",           "the cross section of an electron"
    defConstant "tritonMass",                   false,              "5.007356665e-27 kg",           "the mass of a triton"
    defConstant "vacuumPermeability",           true,               "1.2566370614e-6 N/A2",         "the permeability of free space"
    defConstant "vacuumPermittivity",           false,              "8.854187817e-12 F/m",          "the permittivity of free space"
    defConstant "vonKlitzingConstant",          true,               "25812.8074434 ohm",            "the resistance of a superconductor"
