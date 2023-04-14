import math, sequtils, strutils, sugar, tables

type
    UnitKind = enum
        KLength
        KTime
        KTemperature
        KMass
        KCurrent
        KSubstance
        KLuminosity
        KCurrency
        KInformation
        KAngle
    
    QuantityType = enum
        TAcceleration       = "Acceleration"
        TActivity           = "Activity"
        TAngle              = "Angle"
        TAngularMomentum    = "Angular Momentum"
        TAngularVelocity    = "Angular Velocity"
        TArea               = "Area"
        TAreaDensity        = "Area Density"
        TCapacitance        = "Capacitance"
        TCharge             = "Charge"
        TConductance        = "Conductance"
        TCurrency           = "Currency"
        TCurrent            = "Current"
        TDensity            = "Density"
        TElastance          = "Elastance"
        TEnergy             = "Energy"
        TForce              = "Force"
        TFrequency          = "Frequency"
        TIlluminance        = "Illuminance"
        TInductance         = "Inductance"
        TInformation        = "Information"
        TJolt               = "Jolt"
        TLength             = "Length"
        TLuminousPower      = "Luminous Power"
        TMagnetism          = "Magnetism"
        TMass               = "Mass"
        TMolarConcentration = "Molar Concentration"
        TMomentum           = "Momentum"
        TPotential          = "Potential"
        TPower              = "Power"
        TPressure           = "Pressure"
        TRadiation          = "Radiation"
        TRadiationExposure  = "Radiation Exposure"
        TResistance         = "Resistance"
        TSnap               = "Snap"
        TSpecificVolume     = "Specific Volume"
        TSpeed              = "Speed"
        TSubstance          = "Substance"
        TTemperature        = "Temperature"
        TTime               = "Time"
        TUnitless           = "Unitless"
        TViscosity          = "Viscosity"
        TVolume             = "Volume"
        TVolumetricFlow     = "Volumetric Flow"
        TWaveNumber         = "Wave Number"
        TYank               = "Yank"

        TUnknown            = "Unknown Quantity type"

    QuantityTypeSignature = int64

const
    QuantityTypeSignatures = {
        int64(-312_078)         : TElastance,
        int64(-312_058)         : TResistance,
        int64(-312_038)         : TInductance,
        int64(-152_058)         : TPotential,
        int64(-152_040)         : TMagnetism,
        int64(-152_038)         : TMagnetism,
        int64(-7997)            : TSpecificVolume,
        int64(-79)              : TSnap,
        int64(-59)              : TJolt,
        int64(-39)              : TAcceleration,
        int64(-38)              : TRadiation,
        int64(-20)              : TFrequency,
        int64(-19)              : TSpeed,
        int64(-18)              : TViscosity,
        int64(-17)              : TVolumetricFlow,
        int64(-1)               : TWavenumber,
        int64(0)                : TUnitless,
        int64(1)                : TLength,
        int64(2)                : TArea,
        int64(3)                : TVolume,
        int64(20)               : TTime,
        int64(400)              : TTemperature,
        int64(7941)             : TYank,
        int64(7942)             : TPower,
        int64(7959)             : TPressure,
        int64(7961)             : TForce,
        int64(7962)             : TEnergy,
        int64(7979)             : TViscosity,
        int64(7981)             : TMomentum,
        int64(7982)             : TAngularMomentum,
        int64(7997)             : TDensity,
        int64(7998)             : TAreaDensity,
        int64(8000)             : TMass,
        int64(152_020)          : TRadiationExposure,
        int64(159_999)          : TMagnetism,
        int64(160_000)          : TCurrent,
        int64(160_020)          : TCharge,
        int64(312_058)          : TConductance,
        int64(312_078)          : TCapacitance,
        int64(3_199_980)        : TActivity,
        int64(3_199_997)        : TMolarConcentration,
        int64(3_200_000)        : TSubstance,
        int64(63_999_998)       : TIlluminance,
        int64(64_000_000)       : TLuminousPower,
        int64(1_280_000_000)    : TCurrency,
        int64(25_600_000_000)   : TInformation,
        int64(511_999_999_980)  : TAngularVelocity,
        int64(512_000_000_000)  : TAngle
    }.toTable

template getTypeBySignature(signature: QuantityTypeSignature): QuantityType =
    QuantityTypeSignatures.getOrDefault(signature, TUnknown)

func getSignature(numerator, denominator: openArray[UnitKind]): QuantityTypeSignature =
    var vector = newSeq[int64](ord(UnitKind.high) + 1)
    for unit in numerator:
        vector[ord(unit)] += 1
    for unit in denominator:
        vector[ord(unit)] -= 1

    for index, item in vector:
        vector[index] = item * (int(pow(float(20),float(index))))

    result = vector.foldl(a + b, int64(0))
    # vector.each_with_index { |item, index| vector[index] = item * (20**index) }
    # @signature = vector.inject(0) { |acc, elem| acc + elem }

    # debugEcho $(vector)

    # return 0

proc debugGetSignature(numerator, denominator: openArray[UnitKind]) =
    echo "getting signature for: "
    echo "    - numerator: " & (if numerator.len == 0: "--" else: numerator.map((x) => $(x)).join(" * "))
    echo "    - denominator: " & (if denominator.len == 0: "--" else: denominator.map((x) => $(x)).join(" * "))

    let sign = getSignature(numerator, denominator)
    echo "    = " & $(getTypeBySignature(sign)) & " (" & $sign & ")"
    echo "--------------------------------"

when isMainModule:
    debugGetSignature([KLength], [])
    debugGetSignature([KLength, KLength], [])
    debugGetSignature([KLength, KLength, KLength], [])
    debugGetSignature([KLength], [KTime])
    debugGetSignature([KLength], [KTime, KTime])
    debugGetSignature([KMass], [KLength, KLength])
    debugGetSignature([KMass], [KLength, KLength, KLength])
    debugGetSignature([KLength, KMass], [KTime, KTime])