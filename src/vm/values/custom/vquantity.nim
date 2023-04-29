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

import algorithm, math, parseutils, sequtils, strutils, tables

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import vm/values/custom/vrational
import vquantity/preprocessor

#=======================================
# Compile-time Configuration
#=======================================

const
    useAtomsCache = true

#=======================================
# Core definitions
#=======================================

static:
    #----------------------------------------------------------------------------------------------------
    # Dimensions
    #----------------------------------------------------------------------------------------------------
    #             name                          formula
    #----------------------------------------------------------------------------------------------------
    defDimension "Acceleration",                "L·T⁻²"
    defDimension "Action",                      "L²·M·T⁻¹"                    
    defDimension "Angle",                       "A"  
    defDimension "Angular Velocity",            "T⁻¹·A"
    defDimension "Area",                        "L²"
    defDimension "Area Density",                "L⁻²·M"
    defDimension "Capacitance",                 "L⁻²·M⁻¹·T⁴·I²"
    defDimension "Charge",                      "T·I"     
    defDimension "Conductance",                 "L⁻²·M⁻¹·T³·I²"
    defDimension "Currency",                    "C"           
    defDimension "Current",                     "I"
    defDimension "Current Density",             "L⁻²·I"
    defDimension "Data-transfer Rate",          "T⁻¹·B"
    defDimension "Density",                     "L⁻³·M"
    defDimension "Elastance",                   "L²·M·T⁻⁴·I⁻²"                
    defDimension "Electric Field",              "L·M·T⁻³·I⁻¹"
    defDimension "Energy",                      "L²·M·T⁻²"
    defDimension "Entropy",                     "L²·M·T⁻²·K⁻¹"
    defDimension "Force",                       "L·M·T⁻²"
    defDimension "Frequency",                   "T⁻¹"
    defDimension "Heat Flux",                   "M·T⁻³"
    defDimension "Illuminance",                 "L⁻²·J"
    defDimension "Inductance",                  "L²·M·T⁻²·I⁻²"
    defDimension "Information",                 "B"
    defDimension "Jerk",                        "L·T⁻³"
    defDimension "Kinematic Viscosity",         "L²·T⁻¹"
    defDimension "Length",                      "L"
    defDimension "Luminosity",                  "J"      
    defDimension "Luminous Flux",               "J·S"
    defDimension "Magnetic Flux",               "L²·M·T⁻²·I⁻¹"
    defDimension "Magnetic Flux Density",       "M·T⁻²·I⁻¹"
    defDimension "Magnetic Field Strength",     "L⁻¹·I"
    defDimension "Mass",                        "M"
    defDimension "Mass Flow Rate",              "M·T⁻¹"
    defDimension "Molar Concentration",         "L⁻³·N"
    defDimension "Mole Flow Rate",              "N·T⁻¹"
    defDimension "Moment of Inertia",           "L²·M"
    defDimension "Momentum",                    "L·M·T⁻¹"
    defDimension "Permeability",                "L·M·T⁻²·I⁻²"
    defDimension "Permittivity",                "L⁻³·M⁻¹·T⁴·I²"
    defDimension "Potential",                   "L²·M·T⁻³·I⁻¹"
    defDimension "Power",                       "L²·M·T⁻³"
    defDimension "Pressure",                    "L⁻¹·M·T⁻²"
    defDimension "Radiation",                   "L²·T⁻²"
    defDimension "Radiation Exposure",          "M⁻¹·T·I"
    defDimension "Resistance",                  "L²·M·T⁻³·I⁻²"
    defDimension "Resistivity",                 "L³·M·T⁻³·I⁻²"
    defDimension "Salary",                      "T⁻¹·C"
    defDimension "Solid Angle",                 "S" 
    defDimension "Specific Volume",             "L³·M⁻¹"
    defDimension "Speed",                       "L·T⁻¹"
    defDimension "Snap",                        "L·T⁻⁴"
    defDimension "Substance",                   "N"              
    defDimension "Surface Tension",             "M·T⁻²"
    defDimension "Temperature",                 "K"
    defDimension "Thermal Conductivity",        "L·M·T⁻³·K⁻¹"
    defDimension "Time",                        "T"
    defDimension "Unitless",                    ""           
    defDimension "Viscosity",                   "L⁻¹·M·T⁻¹"
    defDimension "Volume",                      "L³"
    defDimension "Volumetric Flow",             "L³·T⁻¹"
    defDimension "Wave Number",                 "L⁻¹"

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
    #defUnit "psc",      "pc",       false,      "3.26156 ly",               "parsec", "parsecs"
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
    defUnit "are",      "are",      false,      "100 m2",                   "are", "ares"
    defUnit "ha",       "ha",       false,      "100 are",                  "hectare", "hectares"

    #---------------------------------------------------------------------------------------------------------------------------
    # Volume units (base: m^3)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "L",        "L",        true,       "1000 cm3",                 "l", "liter", "liters"
    defUnit "gal",      "gal",      false,      "231 in3",                  "gallon", "gallons"
    defUnit "bbl",      "bbl",      false,      "42 gal",                   "barrel", "barrels"
    defUnit "qt",       "qt",       false,      "1:4 gal",                  "quart", "quarts"
    defUnit "pt",       "pt",       false,      "1:2 qt",                   "pint", "pints"
    defUnit "cup",      "cup",      false,      "1:2 pt",                   "cup", "cups"
    defUnit "floz",     "floz",     false,      "1:8 cup",                  "fluidOunce", "fluidOunces"
    defUnit "tbsp",     "tbsp",     false,      "1:2 floz",                 "tablespoon", "tablespoons"
    defUnit "tsp",      "tsp",      false,      "1:3 tbsp",                 "teaspoon", "teaspoons"
    
    #---------------------------------------------------------------------------------------------------------------------------
    # Time units (base: s)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "min",      "min",      false,      "60 s",                     "minute", "minutes"
    defUnit "hr",       "hr",       false,      "60 min",                   "hour", "hours"
    defUnit "day",      "day",      false,      "24 hr",                    "day", "days"
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
    defUnit "ton",      "ST",       false,      "2000 lb",                  "ton", "tons", "shortTon", "shortTons"
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
    defUnit "mach",     "mach",     false,      "340.29 m/s",               "mach", "machs"

    #---------------------------------------------------------------------------------------------------------------------------
    # Acceleration units (base: m/s2)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Gal",      "Gal",      false,      "1 cm/s2",                  "gal", "gals", "galileo"

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
    defUnit "bar",      "bar",      true,       "100000 Pa",                "bar", "bars"
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
    defUnit "cal",      "cal",      true,       "4.184 J",                  "calorie", "calories"
    defUnit "BTU",      "BTU",      false,      "1055.05585262 J",          "britishThermalUnit", "britishThermalUnits"
    defUnit "eV",       "eV",       true,       "1.602176565e-19 J",        "electronVolt", "electronVolts"
    defUnit "erg",      "erg",      false,      "1e-7 J",                   "erg", "ergs"

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

    #---------------------------------------------------------------------------------------------------------------------------
    # Potential units (base: V = 1 W/A)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "V",        "V",        true,       "1 W/A",                    "volt", "volts"
    defUnit "statV",    "statV",    false,      "299.792458 V",             "statvolt", "statvolts"

    #---------------------------------------------------------------------------------------------------------------------------
    # Resistance units (base: Ohm = 1 V/A)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "Ohm",      "Ω",        true,       "1 V/A",                    "ohm", "ohms"
    defUnit "statOhm",  "statΩ",    false,      "8.987551787e11 ohm",       "statohm", "statohms"

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
    defUnit "G",        "G",        true,       "1e-4 T",                   "gauss", "gauss"

    #---------------------------------------------------------------------------------------------------------------------------
    # Temperature units (base: K)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "degC",     "°C",       false,      "",                         "celsius"
    defUnit "degF",     "°F",       false,      "",                         "fahrenheit"
    defUnit "degR",     "°R",       false,      "",                         "rankine"

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

    #---------------------------------------------------------------------------------------------------------------------------
    # Luminous flux units (base: lm = cd.sr)
    #---------------------------------------------------------------------------------------------------------------------------
    #       name        symbol      prefix?     definition                  aliases
    #---------------------------------------------------------------------------------------------------------------------------
    defUnit "lm",       "lm",       true,       "1 cd.sr",                  "lumen", "lumens"

    #----------------------------------------------------------------------------------------------------
    # Constants
    #----------------------------------------------------------------------------------------------------
    #           name                            pre-calculate?      definition
    #----------------------------------------------------------------------------------------------------
    defConstant "alphaParticleMass",            false,              "6.64465675e-27 kg"
    defConstant "angstromStar",                 false,              "1:10000000000 m"
    defConstant "atomicMass",                   false,              "1.660538921e-27 kg"
    defConstant "avogadroConstant",             false,              "6.02214129e23 1/mol"       # avogadro
    defConstant "bohrRadius",                   false,              "5.2917721092e-11 m"
    defConstant "boltzmannConstant",            false,              "1.3806488e-23 J/K"
    defConstant "classicalElectronRadius",      false,              "2.8179403267e-15 m"
    defConstant "conductanceQuantum",           true,               "7.7480917346e-5 S"
    defConstant "deuteronMass",                 false,              "3.3435830926e-27 kg"
    defConstant "electronCharge",               false,              "1.602176565e-19 C"
    defConstant "electronMass",                 false,              "9.10938215e-31 kg"
    defConstant "electronMassEnergy",           false,              "8.18710506e-14 J"
    defConstant "elementaryCharge",             false,              "1.602176565e-19 C"
    defConstant "gravitationalConstant",        false,              "6.6743e-11 m3/kg.s2"
    defConstant "hartreeEnergy",                false,              "4.35974434e-18 J"
    defConstant "helionMass",                   false,              "5.00641234e-27 kg"
    defConstant "impedanceOfVacuum",            true,               "376.730313461 ohm"
    defConstant "inverseConductanceQuantum",    false,              "12906.4037217 ohm"
    defConstant "josephsonConstant",            true,               "483597.891e9 Hz/V"
    defConstant "magneticFluxQuantum",          false,              "2.067833758e-15 Wb"
    defConstant "molarGasConstant",             true,               "8.3144621 J/mol.K"
    defConstant "muonMass",                     false,              "1.883531475e-28 kg"
    defConstant "neutronMass",                  false,              "1.674927351e-27 kg"
    defConstant "planckConstant",               false,              "6.62606957e-34 J.s"
    defConstant "planckLength",                 false,              "1.616199e-35 m"
    defConstant "planckMass",                   false,              "2.17651e-8 kg"
    defConstant "planckTemperature",            false,              "1.416833e32 K"
    defConstant "planckTime",                   false,              "5.39116e-44 s"
    defConstant "protonMass",                   false,              "1.672621777e-27 kg"
    defConstant "protonMassEnergy",             false,              "1.503277484e-10 J"
    defConstant "reducedPlanckConstant",        false,              "1.054571726e-34 J.s"
    defConstant "rydbergConstant",              true,               "10973731.56853955 1/m"     # rydberg
    defConstant "speedOfLight",                 true,               "299792458 m/s"
    defConstant "standardGasVolume",            true,               "22.41410e-3 m3/mol"
    defConstant "standardPressure",             true,               "100 kPa"
    defConstant "standardTemperature",          true,               "273.15 K"
    defConstant "tauMass",                      false,              "3.16747e-27 kg"
    defConstant "thomsonCrossSection",          false,              "6.652458734e-29 m2"
    defConstant "tritonMass",                   false,              "5.007356665e-27 kg"
    defConstant "unifiedMass",                  false,              "1.660538921e-27 kg"
    defConstant "vacuumPermeability",           true,               "1.2566370614e-6 N/A2"
    defConstant "vacuumPermittivity",           false,              "8.854187817e-12 F/m"       # epsilon0
    defConstant "vonKlitzingConstant",          true,               "25812.8074434 ohm"    

#=======================================
# Types
#=======================================

type
    AtomExponent        = -5..5
    QuantityValue*      = VRational
    QuantitySignature   = int64

    Prefix          = generatePrefixDefinitions()
    CoreUnit        = generateUnitDefinitions()

    UnitKind = enum
        Core
        User

    Unit = object
        case kind: UnitKind:
            of Core:
                core: CoreUnit
            of User:
                name: string

    PrefixedUnit* = tuple
        p: Prefix
        u: Unit

    Atom = tuple
        unit: PrefixedUnit
        power: AtomExponent

    Atoms* = seq[Atom]

    QuantityFlag = enum
        IsBase
        IsTemperature
        IsCurrency

    Quantity = tuple
        original    : QuantityValue
        value       : QuantityValue
        signature   : QuantitySignature
        atoms       : Atoms
        flags       : set[QuantityFlag]

    VQuantity* = Quantity

# Benchmarking
{.hints: on.} # Apparently we cannot disable just `Name` hints?
{.hint: "Quantity's inner type is currently " & $sizeof(Quantity) & ".".}
{.hints: off.}

func `==`(a, b: Unit): bool =
    if a.kind != b.kind: return false
    return
        case a.kind:
            of Core: a.core == b.core
            of User: a.name == b.name

#=======================================
# Constants
#=======================================

const
    AtomExponents = ["⁻⁵", "⁻⁴", "⁻³", "⁻²", "⁻¹", "", "", "²", "³", "⁴", "⁵"]

#=======================================
# Variables
#=======================================

var
    AtomsCache {.used.} : Table[string,Atoms]

    Dimensions          : Table[QuantitySignature, string]
    Quantities          : Table[Unit, Quantity]
    UserUnits           : Table[string,string]

#=======================================
# Useful Constants
#=======================================

generateConstantDefinitions()

#=======================================
# Helpers
#=======================================

proc `$`*(q: Quantity): string 

func isUnitless(q: Quantity): bool {.inline.} =
    return q.signature == 0

proc getPrimitive(unit: PrefixedUnit): Quantity =
    result = Quantities[unit.u]

    # Warning: This may be losing information for too-low or too-high values!
    result.value *= toRational(pow(float(10), float(ord(unit.p))))

proc getSignature(atoms: Atoms): QuantitySignature =
    for atom in atoms:
        let prim = getPrimitive(atom.unit)
        result += prim.signature * atom.power

proc getValue(atoms: Atoms): QuantityValue =
    result = 1//1
    for atom in atoms:
        let prim = getPrimitive(atom.unit)
        result *= prim.value ^ atom.power

proc flatten*(atoms: Atoms): Atoms =
    var cnts: OrderedTable[PrefixedUnit, int]

    for atom in atoms:
        if cnts.hasKeyOrPut(atom.unit, atom.power):
            cnts[atom.unit] += atom.power

    for (unit, power) in pairs(cnts):
        result.add (unit: unit, power: AtomExponent(power))

proc reverse*(atoms: Atoms): Atoms =
    for atom in atoms:
        result.add (unit: atom.unit, power: AtomExponent(-atom.power))

#=======================================
# Parsers
#=======================================

proc parseUnit*(str: string): PrefixedUnit = 
    generateUnitParser()

proc parseAtoms*(str: string): Atoms = 
    proc parseAtom(at: string, denominator: static bool=false): Atom =
        var i = 0
        var unitStr: string
        while i < at.len and at[i] notin '2'..'9':
            unitStr.add at[i]
            inc i

        result.unit = parseUnit(unitStr)
        result.power = 1
        if i < at.len:
            result.power = parseInt(at[i..^1])

        when denominator:
            result.power = -result.power

    when useAtomsCache:
        if AtomsCache.hasKey(str):
            return AtomsCache[str]

    let parts = str.split("/")

    for atomStr in parts[0].split("."):
        if atomStr != "1":
            result.add parseAtom(atomStr)

    if parts.len > 1:
        for atomStr in parts[1].split("."):
            result.add parseAtom(atomStr, denominator=true)

    when useAtomsCache:
        AtomsCache[str] = result

#=======================================
# Constructors
#=======================================

proc toQuantity*(v: QuantityValue, atoms: Atoms): Quantity =
    result.original = v
    result.value = v

    for atom in atoms:
        let prim = getPrimitive(atom.unit)
        result.signature += prim.signature * atom.power
        result.value *= prim.value ^ atom.power

        result.atoms.add(atom)

when not defined(NOGMP):
    proc toQuantity*(v: int | float | Int, atoms: Atoms): Quantity {.inline.} =
        result = toQuantity(toRational(v), atoms)
else:
    proc toQuantity*(v: int | float, atoms: Atoms): Quantity {.inline.} =
        result = toQuantity(toRational(v), atoms)

proc parseValue(s: string): QuantityValue =
    if s.contains("."):
        result = toRational(parseFloat(s))
    elif s.contains(":"):
        let ratParts = s.split(":")
        try:
            result = toRational(parseInt(ratparts[0]), parseInt(ratparts[1]))
        except ValueError:
            when not defined(NOGMP):
                result = toRational(newInt(ratparts[0]), newInt(ratparts[1]))
    else:
        try:
            result = toRational(parseInt(s))
        except ValueError:
            when not defined(NOGMP):
                result = toRational(newInt(s))

proc toQuantity*(str: string): Quantity =
    let parts = str.split(" ")

    # Warning: we should be able to parse rational numbers as well!
    let value = parseValue(parts[0])
    let atoms = parseAtoms(parts[1])

    result = toQuantity(value, atoms)

proc toQuantity*(vstr: string, atoms: Atoms): Quantity =
    echo "defining ---> " & $(vstr)
    result = toQuantity(parseValue(vstr), atoms)

#=======================================
# Methods
#=======================================

proc getDimension*(q: Quantity): string =
    Dimensions.getOrDefault(q.signature, "Unknown")

proc convertTo*(q: Quantity, atoms: Atoms): Quantity =
    if q.signature != getSignature(atoms):
        raise newException(ValueError, "Cannot convert quantities with different dimensions.")

    if q.atoms == atoms:
        return q

    # Solution 1
    # var leftSide = 1.0
    # var rightSide = 1.0

    # for atom in q.atoms:
    #     let prim = getPrimitive(atom.unit)
    #     leftSide *= pow(prim.value, float(atom.power))

    # for atom in atoms:
    #     let prim = getPrimitive(atom.unit)
    #     rightSide *= pow(prim.value, float(atom.power))

    # let newVal = q.original * leftSide / rightSide

    # Solution 2
    let newVal = q.value/getValue(atoms)
    result = toQuantity(newVal, atoms)

proc toBase*(q: Quantity): Atoms =
    for atom in q.atoms:
        let prim = getPrimitive(atom.unit)
        if IsBase in prim.flags:
            result.add atom
            continue
        else:
            result.add toBase(prim)

proc getBaseUnits*(q: Quantity): Atoms =
    result = flatten(toBase(q))

#=======================================
# Comparison
#=======================================

func `=~`(a, b: Quantity): bool =
    return a.signature == b.signature

#=======================================
# Operators
#=======================================

proc `+`*(a, b: Quantity): Quantity =
    if not (a =~ b):
        raise newException(ValueError, "Cannot add quantities with different dimensions.")

    let convB = b.convertTo(a.atoms)

    # echo "quantity A: " & $(a)
    # echo "quantity B: " & $(b)
    # echo "\tconverted: " & $(convB)

    result = toQuantity(a.original + convB.original, a.atoms)

proc `+`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original + b, a.atoms)

when not defined(NOGMP):
    proc `+`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original + b, a.atoms)

proc `+=`*(a: var Quantity, b: Quantity) =
    if not (a =~ b):
        raise newException(ValueError, "Cannot add quantities with different dimensions.")

    let convB = b.convertTo(a.atoms)

    # echo "quantity A: " & $(a)
    # echo "quantity B: " & $(b)
    # echo "\tconverted: " & $(convB)

    a.original += convB.original

proc `+=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original += b

when not defined(NOGMP):
    proc `+=`*(a: var Quantity, b: Int) =
        a.original += b

proc `-`*(a, b: Quantity): Quantity =
    if not (a =~ b):
        raise newException(ValueError, "Cannot subtract quantities with different dimensions.")

    let convB = b.convertTo(a.atoms)

    # echo "quantity A: " & $(a)
    # echo "quantity B: " & $(b)
    # echo "\tconverted: " & $(convB)

    result = toQuantity(a.original - convB.original, a.atoms)

proc `-`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original - b, a.atoms)

when not defined(NOGMP):
    proc `-`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original - b, a.atoms)

proc `-=`*(a: var Quantity, b: Quantity) =
    if not (a =~ b):
        raise newException(ValueError, "Cannot subtract quantities with different dimensions.")

    let convB = b.convertTo(a.atoms)

    # echo "quantity A: " & $(a)
    # echo "quantity B: " & $(b)
    # echo "\tconverted: " & $(convB)

    a.original -= convB.original

proc `-=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original -= b

when not defined(NOGMP):
    proc `-=`*(a: var Quantity, b: Int) =
        a.original -= b

proc `*`*(a, b: Quantity): Quantity =
    if a =~ b:
        let convB = b.convertTo(a.atoms)
        result = toQuantity(a.original * convB.original, flatten(a.atoms & convB.atoms))
    else:
        result = toQuantity(a.original * b.original, flatten(a.atoms & b.atoms))

proc `*`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original * b, a.atoms)

proc `*`*(a: int | float | QuantityValue, b: Quantity): Quantity =
    result = toQuantity(a * b.original, b.atoms)

when not defined(NOGMP):
    proc `*`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original * b, a.atoms)

    proc `*`*(a: Int, b: Quantity): Quantity =
        result = toQuantity(a * b.original, b.atoms)

proc `*=`*(a: var Quantity, b: Quantity) =
    a = a * b

proc `*=`*(a: var Quantity, b: int | float | QuantityValue) =
    a.original *= b

when not defined(NOGMP):
    proc `*=`*(a: var Quantity, b: Int) =
        a.original *= b

proc `/`*(a, b: Quantity): Quantity =
    if a =~ b:
        let convB = b.convertTo(a.atoms)
        result = toQuantity(a.original / convB.original, flatten(a.atoms & reverse(convB.atoms)))
    else:
        result = toQuantity(a.original / b.original, flatten(a.atoms & reverse(b.atoms)))

proc `/`*(a: Quantity, b: int | float | QuantityValue): Quantity =
    result = toQuantity(a.original / b, a.atoms)

when not defined(NOGMP):
    proc `/`*(a: Quantity, b: Int): Quantity =
        result = toQuantity(a.original / b, a.atoms)

#=======================================
# String converters
#=======================================

func `$`*(expo: AtomExponent): string =
    AtomExponents[expo + 5]

proc `$`*(unit: Unit): string =
    case unit.kind:
        of Core: $(unit.core)
        of User: UserUnits[unit.name]

proc `$`*(punit: PrefixedUnit): string =
    $(punit.p) & $(punit.u)

proc `$`*(atom: Atom): string =
    $(atom.unit) & $(atom.power)

proc `$`*(atoms: Atoms, oneline: static bool=false): string =
    when not oneline:
        var pos: seq[string]
        var neg: seq[string]

        for atom in atoms:
            if atom.power > 0:
                pos.add $(atom)
            else:
                neg.add $(atom)

        if pos.len > 0:
            result = pos.join("·")

            if neg.len > 0:
                result &= "/" & (neg.join("·")).replace("⁻¹", "").replace("⁻", "")
        else:
            result = neg.join("·")
    else:
        result = atoms.mapIt($it).join("·")

proc `$`*(q: Quantity): string =
    result = $q.original & " " & $q.atoms

proc codify*(q: Quantity): string =
    result = ($q.original).replace("/",":") & "`"
    
    result &= ($(q.atoms)).replace("·",".")
                          .replace("¹","")
                          .replace("²","2")
                          .replace("³","3")
                          .replace("⁴","4")

proc inspect*(q: Quantity) =
    echo "----------------------------------------"
    echo $(q)
    echo "----------------------------------------"
    echo ".original: ", q.original
    echo ".value: ", q.value
    echo ".signature: ", q.signature, " => ", getDimension(q)
    echo ".flags: ", q.flags
    echo ".atoms: "

    for atom in q.atoms:
        echo "    - (", atom, ") = "
        echo "        .prefix: ", atom.unit.p
        echo "        .unit: ", atom.unit.u
        echo "        .power: ", atom.power

    echo ".base units: ", `$`(getBaseUnits(q), oneline=true)
    
    echo ""

proc defineNewUserUnit*(name: string, symbol: string, definition: string) =
    UserUnits[name] = symbol
    Quantities[Unit(kind: User, name: name)] = toQuantity(definition)

#=======================================
# Setup
#=======================================

proc initQuantities*() =
    Dimensions = generateDimensions()
    Quantities = generateQuantities()

    echo "BEFORE"
    generateConstants()
    echo "AFTER"

    # planckMass = toQuantity(parseValue("2.176434e-8"), parseAtoms("1/kg"))

#=======================================
# Testing
#=======================================
static:
    printUnits()



import helpers/benchmark
import random, strutils

template bmark(ttl:string, action:untyped):untyped =
    echo "----------------------"
    echo ttl
    echo "----------------------"
    benchmark "":
        for i in 1..1_000_000:
            action

const
    pwrs = [
        1.int64, 
        6.int64,
        36.int64, 
        216.int64, 
        1296.int64,
        7776.int64,
        46656.int64,
        279936.int64,
        1679616.int64,
        10077696.int64,
        60466176.int64,
        362797056.int64,
        2176782336,
        2176782337,
        2176782338,
        2176782339,
        2176782340,
        2176782341,
        2176782342,
        2176782343,
        2176782344,
        2176782345,
        2176782346,
        2176782347,
        2176782348,
        2176782349,
        2176782350
    ]

when isMainModule:
    var x: Quantity
    # bmark "10_000":
    #     x = toQuantity("3.0 m.kg2/s")

    initQuantities()

    # echo $(toQuantity("3 yd"))
    # echo $(toQuantity("3.0 m.kg2/s"))
    # echo $(toQuantity("3 ang"))

    # let threeYD = toQuantity("3 yd")
    # let twoM = toQuantity("2 m")
    # echo "3yd ->"
    # inspect threeYD
    # echo "3yd + 1 ->"
    # inspect threeYD + 1
    # echo "3yd - 1 ->"
    # inspect threeYD - 1
    # echo "3yd * 3 ->"
    # inspect threeYD * 3

    # echo "2m"
    # inspect twoM
    # echo "2m + 1 ->"
    # inspect twoM + 1
    # echo "2m - 1 ->"
    # inspect twoM - 1
    # echo "2m * 3 ->"
    # inspect twoM * 3

    # echo "2m + 3yd ->"
    # inspect twoM + threeYD
    # echo "3yd + 2m ->"
    # inspect threeYD + twoM

    # echo "2m * 3yd ->"
    # inspect twoM * threeYD
    # echo "3yd * 2m ->"
    # inspect threeYD * twoM
    # # inspect toQuantity("3.0 m.kg2/s")
    # # inspect toQuantity("3 ang")

    # # inspect toQuantity("3 USD")

    # # echo $(Quantities)
    # # inspect Quantities[Unit(kind: Core, core: USD_Unit)]
    # # inspect toQuantity("3.0 EUR")
    # # # echo $(toQuantity("3 zf"))
    # echo "Converting 3yd to meters"
    # inspect (toQuantity("3 yd")).convertTo(parseAtoms("m"))

    # echo "Converting 3m to yards"
    # inspect (toQuantity("3 m")).convertTo(parseAtoms("yd"))

    # echo "Converting 3yd2 to meters2"
    # inspect (toQuantity("3 yd2")).convertTo(parseAtoms("m2"))

    # echo "Converting 3m2 to yards2"
    # inspect (toQuantity("3 m2")).convertTo(parseAtoms("yd2"))

    # toBase(toQuantity("3 W"))

    # echo "Converting 3m to yards2"
    # inspect (toQuantity("3 m")).convertTo(parseAtoms("yd2"))

    # echo "Converting 300cm to meters"
    # inspect (toQuantity("300 cm")).convertTo(parseAtoms("m"))

    # echo "Converting 3m to cm"
    # inspect (toQuantity("3 m")).convertTo(parseAtoms("cm"))

    # echo "Convert 3yd to m" # 2.7432
    # inspect (toQuantity("3 yd")).convertTo(parseAtoms("m"))

    # echo "Convert 3m to yd" # 3.28084
    # inspect (toQuantity("3 m")).convertTo(parseAtoms("yd"))

    # echo "Convert 300cm to yd"
    # inspect (toQuantity("300 cm")).convertTo(parseAtoms("yd"))

    # echo "Convert 1kg to lb"
    # inspect (toQuantity("1 kg")).convertTo(parseAtoms("lb"))

    # echo "Convert 2m2 to yd2"
    # inspect (toQuantity("2 m2")).convertTo(parseAtoms("yd2"))

    # echo "Convert 2yd2 to m2"
    # inspect (toQuantity("2 yd2")).convertTo(parseAtoms("m2"))

    # echo "Convert 3N to kg.m/s2"
    # inspect (toQuantity("3 N")).convertTo(parseAtoms("kg.m/s2"))

    # echo "Convert 3kg.m/s2 to N"
    # inspect (toQuantity("3 kg.m/s2")).convertTo(parseAtoms("N"))

    # inspect (toQuantity("5 Pa"))

    # inspect (toQuantity("3 H"))

    # echo "Adding 3m and 2yd"
    # inspect (toQuantity("3 m")) + (toQuantity("2 yd"))

    # echo "Adding 2yd and 3m"
    # inspect (toQuantity("2 yd")) + (toQuantity("3 m"))

    # echo "Subtracting 3m and 2yd"
    # inspect (toQuantity("3 m")) - (toQuantity("2 yd"))

    # echo "multiplying 3m and 2yd"
    # inspect (toQuantity("3 m")) * (toQuantity("2 yd"))

    # echo "multiplying 2yd and 3m"
    # inspect (toQuantity("2 yd")) * (toQuantity("3 m"))

    # echo "dividing 3m and 3m"
    # inspect (toQuantity("3 m")) / (toQuantity("3 m"))

    # echo "dividing 3m2 and 3m"
    # inspect (toQuantity("3 m2")) / (toQuantity("3 m"))

    # echo "dividing 3m3 and 3m"
    # inspect (toQuantity("3 m3")) / (toQuantity("3 m"))

    # echo "dividing 3m3 and 3m2"
    inspect (toQuantity("3 m3")) / (toQuantity("3 m2"))

    defineNewUserUnit("zf", "Zf", "1 bit/m.s")

    echo $(Quantities[Unit(kind:User, name:"zf")])

    echo $(toQuantity("3 zf") + toQuantity("12 bit/yd.s"))

    echo $(toQuantity("3 m") + toQuantity("12 yd"))
    #echo $(toQuantity("3 s/m") + toQuantity("12 zf"))

    echo $(toQuantity("3 days") + toQuantity("1 week"))

    echo $(toQuantity("15 km/hr") * toQuantity("30 min"))

    echo $(toQuantity("0 g") + toQuantity("1 ozt"))

    # proc getSign1(x: float): float {.inline.} =
    #     if x < 12:
    #         return pow(6.0, x)
    #     else:
    #         return pow(6.0, float(12)) + 12-x

    # proc getSign2(x: float): float {.inline.} =
    #     float(pwrs[int(x)])
    #     # if x < 12:
    #     #     return pow(6.0, x)
    #     # else:
    #     #     return pow(6.0, float(12)) + 12-x

    # proc getSign3(x: float): float {.inline.} =
    #     return pow(6.0, min(x, 12.0)) + max(x-12,0)
    #     # if x < 12:
    #     #     return pow(6.0, x)
    #     # else:
    #     #     return pow(6.0, float(12)) + 12-x

    # randomize()

    # var ss: seq[float]

    # for i in 0..<10:
    #     ss.add(float(rand(0..20)))

    # echo $(ss)

    # var i: float
    # bmark "sign 1":
    #     for j in ss:
    #         i = getSign1(j)

    # echo "i = ", i

    # bmark "sign 2":
    #     for j in ss:
    #         i = getSign2(j)

    # echo "i = ", i

    # bmark "sign 3":
    #     for j in ss:
    #         i = getSign3(j)

    # echo "i = ", i
    echo $(speedOfLight)
    echo $(gravitationalConstant)
    echo $(angstromStar)