######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/colors.nim
######################################################

#=======================================
# Libraries
#=======================================

from algorithm import binarySearch

import math, random, sequtils
import strutils, sugar

#=======================================
# Types
#=======================================

type
    VColor* = distinct uint32

    RGB* = tuple[r: int, g: int, b: int, a: int]
    HSL* = tuple[h: int, s: float, l: float, a: float]
    HSV* = tuple[h: int, s: float, v: float, a: float]
    Palette = seq[VColor]

#=======================================
# Constants
#=======================================

const
    clAcidGreen* = VColor(0xB0BF1AFF)
    clAlgaeGreen* = VColor(0x64E986FF)
    clAliceBlue* = VColor(0xF0F8FFFF)
    clAlienGray* = VColor(0x736F6EFF)
    clAlienGreen* = VColor(0x6CC417FF)
    clAloeVeraGreen* = VColor(0x98F516FF)
    clAntiqueBronze* = VColor(0x665D1EFF)
    clAntiqueWhite* = VColor(0xFAEBD7FF)
    clAquamarine* = VColor(0x7FFFD4FF)
    clAquamarineStone* = VColor(0x348781FF)
    clArmyBrown* = VColor(0x827B60FF)
    clArmyGreen* = VColor(0x4B5320FF)
    clAshGray* = VColor(0x666362FF)
    clAshWhite* = VColor(0xE9E4D4FF)
    clAvocadoGreen* = VColor(0xB2C248FF)
    clAztechPurple* = VColor(0x893BFFFF)
    clAzure* = VColor(0xF0FFFFFF)
    clAzureBlue* = VColor(0x4863A0FF)
    clBabyBlue* = VColor(0x95B9C7FF)
    clBabyPink* = VColor(0xFAAFBAFF)
    clBakersBrown* = VColor(0x5C3317FF)
    clBalloonBlue* = VColor(0x2B60DEFF)
    clBananaYellow* = VColor(0xF5E216FF)
    clBashfulPink* = VColor(0xC25283FF)
    clBasketBallOrange* = VColor(0xF88158FF)
    clBattleshipGray* = VColor(0x848482FF)
    clBeanRed* = VColor(0xF75D59FF)
    clBeer* = VColor(0xFBB117FF)
    clBeetleGreen* = VColor(0x4C787EFF)
    clBeeYellow* = VColor(0xE9AB17FF)
    clBeige* = VColor(0xF5F5DCFF)
    clBisque* = VColor(0xFFE4C4FF)
    clBlack* = VColor(0x000000FF)
    clBlackBean* = VColor(0x3D0C02FF)
    clBlackCat* = VColor(0x413839FF)
    clBlackCow* = VColor(0x4C4646FF)
    clBlackEel* = VColor(0x463E3FFF)
    clBlanchedAlmond* = VColor(0xFFEBCDFF)
    clBlonde* = VColor(0xFBF6D9FF)
    clBloodNight* = VColor(0x551606FF)
    clBloodRed* = VColor(0x7E3517FF)
    clBlossomPink* = VColor(0xF9B7FFFF)
    clBlue* = VColor(0x0000FFFF)
    clBlueAngel* = VColor(0xB7CEECFF)
    clBlueberryBlue* = VColor(0x0041C2FF)
    clBlueDiamond* = VColor(0x4EE2ECFF)
    clBlueDress* = VColor(0x157DECFF)
    clBlueEyes* = VColor(0x1569C7FF)
    clBlueGray* = VColor(0x98AFC7FF)
    clBlueGreen* = VColor(0x7BCCB5FF)
    clBlueHosta* = VColor(0x77BFC7FF)
    clBlueIvy* = VColor(0x3090C7FF)
    clBlueJay* = VColor(0x2B547EFF)
    clBlueKoi* = VColor(0x659EC7FF)
    clBlueLagoon* = VColor(0x8EEBECFF)
    clBlueLotus* = VColor(0x6960ECFF)
    clBlueMossGreen* = VColor(0x3C565BFF)
    clBlueOrchid* = VColor(0x1F45FCFF)
    clBlueRibbon* = VColor(0x306EFFFF)
    clBlueTurquoise* = VColor(0x43C6DBFF)
    clBlueViolet* = VColor(0x8A2BE2FF)
    clBlueWhale* = VColor(0x342D7EFF)
    clBlueZircon* = VColor(0x57FEFFFF)
    clBlush* = VColor(0xFFE6E8FF)
    clBlushPink* = VColor(0xE6A9ECFF)
    clBlushRed* = VColor(0xE56E94FF)
    clBoldYellow* = VColor(0xF9DB24FF)
    clBrass* = VColor(0xB5A642FF)
    clBrightBlue* = VColor(0x0909FFFF)
    clBrightCyan* = VColor(0x0AFFFFFF)
    clBrightGold* = VColor(0xFDD017FF)
    clBrightGreen* = VColor(0x66FF00FF)
    clBrightLilac* = VColor(0xD891EFFF)
    clBrightMaroon* = VColor(0xC32148FF)
    clBrightNavyBlue* = VColor(0x1974D2FF)
    clBrightNeonPink* = VColor(0xF433FFFF)
    clBrightOrange* = VColor(0xFF5F1FFF)
    clBrightPurple* = VColor(0x6A0DADFF)
    clBrightTurquoise* = VColor(0x16E2F5FF)
    clBronze* = VColor(0xCD7F32FF)
    clBrown* = VColor(0xA52A2AFF)
    clBrownBear* = VColor(0x835C3BFF)
    clBrownSand* = VColor(0xEE9A4DFF)
    clBrownSugar* = VColor(0xE2A76FFF)
    clBulletShell* = VColor(0xAF9B60FF)
    clBurgundy* = VColor(0x8C001AFF)
    clBurlyWood* = VColor(0xDEB887FF)
    clBurntPink* = VColor(0xC12267FF)
    clButterflyBlue* = VColor(0x38ACECFF)
    clCadetBlue* = VColor(0x5F9EA0FF)
    clCadillacPink* = VColor(0xE38AAEFF)
    clCamelBrown* = VColor(0xC19A6BFF)
    clCamouflageGreen* = VColor(0x78866BFF)
    clCanaryBlue* = VColor(0x2916F5FF)
    clCanaryYellow* = VColor(0xFFEF00FF)
    clCantaloupe* = VColor(0xFFA62FFF)
    clCaramel* = VColor(0xC68E17FF)
    clCarbonGray* = VColor(0x625D5DFF)
    clCarbonRed* = VColor(0xA70D2AFF)
    clCardboardBrown* = VColor(0xEDDA74FF)
    clCarnationPink* = VColor(0xF778A1FF)
    clCarrotOrange* = VColor(0xF88017FF)
    clCeleste* = VColor(0x50EBECFF)
    clChameleonGreen* = VColor(0xBDF516FF)
    clChampagne* = VColor(0xF7E7CEFF)
    clCharcoal* = VColor(0x34282CFF)
    clCharcoalBlue* = VColor(0x36454FFF)
    clChartreuse* = VColor(0x7FFF00FF)
    clCherryRed* = VColor(0xC24641FF)
    clChestnut* = VColor(0x954535FF)
    clChestnutRed* = VColor(0xC34A2CFF)
    clChilliPepper* = VColor(0xC11B17FF)
    clChocolate* = VColor(0xD2691EFF)
    clChocolateBrown* = VColor(0x3F000FFF)
    clCinnamon* = VColor(0xC58917FF)
    clClemantisViolet* = VColor(0x842DCEFF)
    clCloudyGray* = VColor(0x6D6968FF)
    clCloverGreen* = VColor(0x3EA055FF)
    clCobaltBlue* = VColor(0x0020C2FF)
    clCoffee* = VColor(0x6F4E37FF)
    clColumbiaBlue* = VColor(0x87AFC7FF)
    clConstructionConeOrange* = VColor(0xF87431FF)
    clCookieBrown* = VColor(0xC7A317FF)
    clCopper* = VColor(0xB87333FF)
    clCopperRed* = VColor(0xCB6D51FF)
    clCoral* = VColor(0xFF7F50FF)
    clCoralBlue* = VColor(0xAFDCECFF)
    clCornflowerBlue* = VColor(0x6495EDFF)
    clCornsilk* = VColor(0xFFF8DCFF)
    clCornYellow* = VColor(0xFFF380FF)
    clCotton* = VColor(0xFBFBF9FF)
    clCottonCandy* = VColor(0xFCDFFFFF)
    clCranberry* = VColor(0x9F000FFF)
    clCream* = VColor(0xFFFFCCFF)
    clCrimson* = VColor(0xDC143CFF)
    clCrimsonPurple* = VColor(0xE238ECFF)
    clCrocusPurple* = VColor(0x9172ECFF)
    clCrystalBlue* = VColor(0x5CB3FFFF)
    clCyan* = VColor(0x00FFFFFF)
    clCyanOpaque* = VColor(0x92C7C7FF)
    clDarkBisque* = VColor(0xB86500FF)
    clDarkBlonde* = VColor(0xF0E2B6FF)
    clDarkBlue* = VColor(0x00008BFF)
    clDarkBlueGrey* = VColor(0x29465BFF)
    clDarkBrown* = VColor(0x654321FF)
    clDarkCarnationPink* = VColor(0xC12283FF)
    clDarkCoffee* = VColor(0x3B2F2FFF)
    clDarkCyan* = VColor(0x008B8BFF)
    clDarkForestGreen* = VColor(0x254117FF)
    clDarkGoldenRod* = VColor(0xB8860BFF)
    clDarkGray* = VColor(0x3A3B3CFF)
    clDarkGreen* = VColor(0x006400FF)
    clDarkHotPink* = VColor(0xF660ABFF)
    clDarkKhaki* = VColor(0xBDB76BFF)
    clDarkLimeGreen* = VColor(0x41A317FF)
    clDarkMagenta* = VColor(0x8B008BFF)
    clDarkMint* = VColor(0x31906EFF)
    clDarkMoccasin* = VColor(0x827839FF)
    clDarkOliveGreen* = VColor(0x556B2FFF)
    clDarkOrange* = VColor(0xFF8C00FF)
    clDarkOrchid* = VColor(0x9932CCFF)
    clDarkPink* = VColor(0xE75480FF)
    clDarkPurple* = VColor(0x4B0150FF)
    clDarkRaspberry* = VColor(0x872657FF)
    clDarkRed* = VColor(0x8B0000FF)
    clDarkSalmon* = VColor(0xE9967AFF)
    clDarkSeaGreen* = VColor(0x8FBC8FFF)
    clDarkSienna* = VColor(0x8A4117FF)
    clDarkSlate* = VColor(0x2B3856FF)
    clDarkSlateBlue* = VColor(0x483D8BFF)
    clDarkSlateGray* = VColor(0x25383CFF)
    clDarkTurquoise* = VColor(0x00CED1FF)
    clDarkViolet* = VColor(0x9400D3FF)
    clDarkYellow* = VColor(0x8B8000FF)
    clDaySkyBlue* = VColor(0x82CAFFFF)
    clDeepEmeraldGreen* = VColor(0x046307FF)
    clDeepMauve* = VColor(0xDF73D4FF)
    clDeepPeach* = VColor(0xFFCBA4FF)
    clDeepPeriwinkle* = VColor(0x5453A6FF)
    clDeepPink* = VColor(0xFF1493FF)
    clDeepPurple* = VColor(0x36013FFF)
    clDeepRed* = VColor(0x800517FF)
    clDeepRose* = VColor(0xFBBBB9FF)
    clDeepSea* = VColor(0x3B9C9CFF)
    clDeepSeaBlue* = VColor(0x123456FF)
    clDeepSeaGreen* = VColor(0x306754FF)
    clDeepSkyBlue* = VColor(0x00BFFFFF)
    clDeepTeal* = VColor(0x033E3EFF)
    clDeepTurquoise* = VColor(0x48CCCDFF)
    clDeepYellow* = VColor(0xF6BE00FF)
    clDeerBrown* = VColor(0xE6BF83FF)
    clDenimBlue* = VColor(0x79BAECFF)
    clDenimDarkBlue* = VColor(0x151B8DFF)
    clDesertSand* = VColor(0xEDC9AFFF)
    clDimGray* = VColor(0x696969FF)
    clDimorphothecaMagenta* = VColor(0xE3319DFF)
    clDinosaurGreen* = VColor(0x73A16CFF)
    clDodgerBlue* = VColor(0x1E90FFFF)
    clDollarBillGreen* = VColor(0x85BB65FF)
    clDonutPink* = VColor(0xFAAFBEFF)
    clDragonGreen* = VColor(0x6AFB92FF)
    clDullGreenYellow* = VColor(0xB1FB17FF)
    clDullPurple* = VColor(0x7F525DFF)
    clDullSeaGreen* = VColor(0x4E8975FF)
    clEarthBlue* = VColor(0x0000A5FF)
    clEarthGreen* = VColor(0x34A56FFF)
    clEggplant* = VColor(0x614051FF)
    clEggShell* = VColor(0xFFF9E3FF)
    clElectricBlue* = VColor(0x9AFEFFFF)
    clEmerald* = VColor(0x50C878FF)
    clEmeraldGreen* = VColor(0x5FFB17FF)
    clFallForestGreen* = VColor(0x4E9258FF)
    clFallLeafBrown* = VColor(0xC8B560FF)
    clFernGreen* = VColor(0x667C26FF)
    clFerrariRed* = VColor(0xF70D1AFF)
    clFireBrick* = VColor(0xB22222FF)
    clFireEngineRed* = VColor(0xF62817FF)
    clFlamingoPink* = VColor(0xF9A7B0FF)
    clFloralWhite* = VColor(0xFFFAF0FF)
    clForestGreen* = VColor(0x228B22FF)
    clFrenchLilac* = VColor(0x86608EFF)
    clFrogGreen* = VColor(0x99C68EFF)
    clGainsboro* = VColor(0xDCDCDCFF)
    clGhostWhite* = VColor(0xF8F8FFFF)
    clGingerBrown* = VColor(0xC9BE62FF)
    clGlacialBlueIce* = VColor(0x368BC1FF)
    clGold* = VColor(0xFFD700FF)
    clGoldenBlonde* = VColor(0xFBE7A1FF)
    clGoldenBrown* = VColor(0xEAC117FF)
    clGoldenRod* = VColor(0xDAA520FF)
    clGoldenSilk* = VColor(0xF3E3C3FF)
    clGoldenYellow* = VColor(0xFFDF00FF)
    clGranite* = VColor(0x837E7CFF)
    clGrape* = VColor(0x5E5A80FF)
    clGrapefruit* = VColor(0xDC381FFF)
    clGray* = VColor(0x808080FF)
    clGrayBrown* = VColor(0x3D3635FF)
    clGrayCloud* = VColor(0xB6B6B4FF)
    clGrayDolphin* = VColor(0x5C5858FF)
    clGrayGoose* = VColor(0xD1D0CEFF)
    clGrayishTurquoise* = VColor(0x5E7D7EFF)
    clGrayWolf* = VColor(0x504A4BFF)
    clGreen* = VColor(0x008000FF)
    clGreenApple* = VColor(0x4CC417FF)
    clGreenishBlue* = VColor(0x307D7EFF)
    clGreenOnion* = VColor(0x6AA121FF)
    clGreenPeas* = VColor(0x89C35CFF)
    clGreenPepper* = VColor(0x4AA02CFF)
    clGreenSnake* = VColor(0x6CBB3CFF)
    clGreenThumb* = VColor(0xB5EAAAFF)
    clGreenYellow* = VColor(0xADFF2FFF)
    clGulfBlue* = VColor(0xC9DFECFF)
    clGunmetal* = VColor(0x2C3539FF)
    clHalloweenOrange* = VColor(0xE66C2CFF)
    clHarvestGold* = VColor(0xEDE275FF)
    clHazel* = VColor(0x8E7618FF)
    clHazelGreen* = VColor(0x617C58FF)
    clHeavenlyBlue* = VColor(0xC6DEFFFF)
    clHeliotropePurple* = VColor(0xD462FFFF)
    clHoneyDew* = VColor(0xF0FFF0FF)
    clHotDeepPink* = VColor(0xF52887FF)
    clHotPink* = VColor(0xFF69B4FF)
    clHummingbirdGreen* = VColor(0x7FE817FF)
    clIceberg* = VColor(0x56A5ECFF)
    clIguanaGreen* = VColor(0x9CB071FF)
    clIndianRed* = VColor(0xCD5C5CFF)
    clIndianSaffron* = VColor(0xFF7722FF)
    clIndigo* = VColor(0x4B0082FF)
    clIridium* = VColor(0x3D3C3AFF)
    clIronGray* = VColor(0x52595DFF)
    clIvory* = VColor(0xFFFFF0FF)
    clJade* = VColor(0x00A36CFF)
    clJadeGreen* = VColor(0x5EFB6EFF)
    clJasminePurple* = VColor(0xA23BECFF)
    clJeansBlue* = VColor(0xA0CFECFF)
    clJellyfish* = VColor(0x46C7C7FF)
    clJetGray* = VColor(0x616D7EFF)
    clJungleGreen* = VColor(0x347C2CFF)
    clKellyGreen* = VColor(0x4CC552FF)
    clKhaki* = VColor(0xF0E68CFF)
    clKhakiRose* = VColor(0xC5908EFF)
    clLapisBlue* = VColor(0x15317EFF)
    clLavaRed* = VColor(0xE42217FF)
    clLavender* = VColor(0xE6E6FAFF)
    clLavenderBlue* = VColor(0xE3E4FAFF)
    clLavenderBlush* = VColor(0xFFF0F5FF)
    clLavenderPinocchio* = VColor(0xEBDDE2FF)
    clLavenderPurple* = VColor(0x967BB6FF)
    clLawnGreen* = VColor(0x7CFC00FF)
    clLemonChiffon* = VColor(0xFFFACDFF)
    clLightAquamarine* = VColor(0x93FFE8FF)
    clLightBlack* = VColor(0x454545FF)
    clLightBlue* = VColor(0xADD8E6FF)
    clLightBrown* = VColor(0xB5651DFF)
    clLightCopper* = VColor(0xDA8A67FF)
    clLightCoral* = VColor(0xF08080FF)
    clLightCyan* = VColor(0xE0FFFFFF)
    clLightDayBlue* = VColor(0xADDFFFFF)
    clLightFrenchBeige* = VColor(0xC8AD7FFF)
    clLightGold* = VColor(0xF1E5ACFF)
    clLightGoldenRodYellow* = VColor(0xFAFAD2FF)
    clLightGray* = VColor(0xD3D3D3FF)
    clLightGreen* = VColor(0x90EE90FF)
    clLightJade* = VColor(0xC3FDB8FF)
    clLightOrange* = VColor(0xFED8B1FF)
    clLightPink* = VColor(0xFFB6C1FF)
    clLightPurple* = VColor(0x8467D7FF)
    clLightPurpleBlue* = VColor(0x728FCEFF)
    clLightRed* = VColor(0xFFCCCBFF)
    clLightRose* = VColor(0xFBCFCDFF)
    clLightRoseGreen* = VColor(0xDBF9DBFF)
    clLightSalmon* = VColor(0xFFA07AFF)
    clLightSalmonRose* = VColor(0xF9966BFF)
    clLightSeaGreen* = VColor(0x20B2AAFF)
    clLightSkyBlue* = VColor(0x87CEFAFF)
    clLightSlate* = VColor(0xCCFFFFFF)
    clLightSlateBlue* = VColor(0x736AFFFF)
    clLightSlateGray* = VColor(0x778899FF)
    clLightSteelBlue* = VColor(0xB0CFDEFF)
    clLightWhite* = VColor(0xFFFFF7FF)
    clLightYellow* = VColor(0xFFFFE0FF)
    clLilac* = VColor(0xC8A2C8FF)
    clLime* = VColor(0x00FF00FF)
    clLimeGreen* = VColor(0x32CD32FF)
    clLimeMintGreen* = VColor(0x36F57FFF)
    clLinen* = VColor(0xFAF0E6FF)
    clLipstickPink* = VColor(0xC48793FF)
    clLovelyPurple* = VColor(0x7F38ECFF)
    clLoveRed* = VColor(0xE41B17FF)
    clMacaroniAndCheese* = VColor(0xF2BB66FF)
    clMacawBlueGreen* = VColor(0x43BFC7FF)
    clMagenta* = VColor(0xFF00FFFF)
    clMagicMint* = VColor(0xAAF0D1FF)
    clMahogany* = VColor(0xC04000FF)
    clMangoOrange* = VColor(0xFF8040FF)
    clMarbleBlue* = VColor(0x566D7EFF)
    clMaroon* = VColor(0x800000FF)
    clMauve* = VColor(0xE0B0FFFF)
    clMauveTaupe* = VColor(0x915F6DFF)
    clMediumAquaMarine* = VColor(0x66CDAAFF)
    clMediumBlue* = VColor(0x0000CDFF)
    clMediumForestGreen* = VColor(0x347235FF)
    clMediumOrchid* = VColor(0xBA55D3FF)
    clMediumPurple* = VColor(0x9370DBFF)
    clMediumSeaGreen* = VColor(0x3CB371FF)
    clMediumSlateBlue* = VColor(0x7B68EEFF)
    clMediumSpringGreen* = VColor(0x00FA9AFF)
    clMediumTeal* = VColor(0x045F5FFF)
    clMediumTurquoise* = VColor(0x48D1CCFF)
    clMediumVioletRed* = VColor(0xC71585FF)
    clMetallicGold* = VColor(0xD4AF37FF)
    clMetallicSilver* = VColor(0xBCC6CCFF)
    clMiddayBlue* = VColor(0x3BB9FFFF)
    clMidnight* = VColor(0x2B1B17FF)
    clMidnightBlue* = VColor(0x191970FF)
    clMilkChocolate* = VColor(0x513B1CFF)
    clMilkWhite* = VColor(0xFEFCFFFF)
    clMint* = VColor(0x3EB489FF)
    clMintCream* = VColor(0xF5FFFAFF)
    clMintGreen* = VColor(0x98FF98FF)
    clMistBlue* = VColor(0x646D7EFF)
    clMistyRose* = VColor(0xFFE4E1FF)
    clMoccasin* = VColor(0xFFE4B5FF)
    clMocha* = VColor(0x493D26FF)
    clMustardYellow* = VColor(0xFFDB58FF)
    clNavajoWhite* = VColor(0xFFDEADFF)
    clNavy* = VColor(0x000080FF)
    clNebulaGreen* = VColor(0x59E817FF)
    clNeonBlue* = VColor(0x1589FFFF)
    clNeonGreen* = VColor(0x16F529FF)
    clNeonHotPink* = VColor(0xFD349CFF)
    clNeonOrange* = VColor(0xFF6700FF)
    clNeonPink* = VColor(0xF535AAFF)
    clNeonPurple* = VColor(0x9D00FFFF)
    clNeonRed* = VColor(0xFD1C03FF)
    clNeonYellow* = VColor(0xFFFF33FF)
    clNeonYellowGreen* = VColor(0xDAEE01FF)
    clNewMidnightBlue* = VColor(0x0000A0FF)
    clNight* = VColor(0x0C090AFF)
    clNightBlue* = VColor(0x151B54FF)
    clNorthernLightsBlue* = VColor(0x78C7C7FF)
    clOakBrown* = VColor(0x806517FF)
    clOceanBlue* = VColor(0x2B65ECFF)
    clOffWhite* = VColor(0xF8F0E3FF)
    clOil* = VColor(0x3B3131FF)
    clOldBurgundy* = VColor(0x43302EFF)
    clOldLace* = VColor(0xFDF5E6FF)
    clOlive* = VColor(0x808000FF)
    clOliveDrab* = VColor(0x6B8E23FF)
    clOliveGreen* = VColor(0xBAB86CFF)
    clOrange* = VColor(0xFFA500FF)
    clOrangeGold* = VColor(0xD4A017FF)
    clOrangeRed* = VColor(0xFF4500FF)
    clOrangeSalmon* = VColor(0xC47451FF)
    clOrangeYellow* = VColor(0xFFAE42FF)
    clOrchid* = VColor(0xDA70D6FF)
    clOrchidPurple* = VColor(0xB048B5FF)
    clOrganicBrown* = VColor(0xE3F9A6FF)
    clPaleBlueLily* = VColor(0xCFECECFF)
    clPaleGoldenRod* = VColor(0xEEE8AAFF)
    clPaleGreen* = VColor(0x98FB98FF)
    clPaleLilac* = VColor(0xDCD0FFFF)
    clPaleSilver* = VColor(0xC9C0BBFF)
    clPaleTurquoise* = VColor(0xAFEEEEFF)
    clPaleVioletRed* = VColor(0xDB7093FF)
    clPapayaOrange* = VColor(0xE56717FF)
    clPapayaWhip* = VColor(0xFFEFD5FF)
    clParchment* = VColor(0xFFFFC2FF)
    clParrotGreen* = VColor(0x12AD2BFF)
    clPastelBlue* = VColor(0xB4CFECFF)
    clPastelGreen* = VColor(0x77DD77FF)
    clPastelLightBlue* = VColor(0xD5D6EAFF)
    clPastelOrange* = VColor(0xF8B88BFF)
    clPastelPink* = VColor(0xFEA3AAFF)
    clPastelPurple* = VColor(0xF2A2E8FF)
    clPastelRed* = VColor(0xF67280FF)
    clPastelViolet* = VColor(0xD291BCFF)
    clPastelYellow* = VColor(0xFAF884FF)
    clPeach* = VColor(0xFFE5B4FF)
    clPeachPuff* = VColor(0xFFDAB9FF)
    clPeaGreen* = VColor(0x52D017FF)
    clPearl* = VColor(0xFDEEF4FF)
    clPeriwinkle* = VColor(0xCCCCFFFF)
    clPeriwinklePink* = VColor(0xE9CFECFF)
    clPeriwinklePurple* = VColor(0x7575CFFF)
    clPeru* = VColor(0xCD853FFF)
    clPigPink* = VColor(0xFDD7E4FF)
    clPineGreen* = VColor(0x387C44FF)
    clPink* = VColor(0xFFC0CBFF)
    clPinkBrown* = VColor(0xC48189FF)
    clPinkBubbleGum* = VColor(0xFFDFDDFF)
    clPinkCoral* = VColor(0xE77471FF)
    clPinkCupcake* = VColor(0xE45E9DFF)
    clPinkDaisy* = VColor(0xE799A3FF)
    clPinkLemonade* = VColor(0xE4287CFF)
    clPinkPlum* = VColor(0xB93B8FFF)
    clPinkRose* = VColor(0xE7A1B0FF)
    clPinkViolet* = VColor(0xCA226BFF)
    clPistachioGreen* = VColor(0x9DC209FF)
    clPlatinum* = VColor(0xE5E4E2FF)
    clPlatinumGray* = VColor(0x797979FF)
    clPlatinumSilver* = VColor(0xCECECEFF)
    clPlum* = VColor(0xDDA0DDFF)
    clPlumPie* = VColor(0x7D0541FF)
    clPlumPurple* = VColor(0x583759FF)
    clPlumVelvet* = VColor(0x7D0552FF)
    clPowderBlue* = VColor(0xB0E0E6FF)
    clPuce* = VColor(0x7F5A58FF)
    clPumpkinOrange* = VColor(0xF87217FF)
    clPurple* = VColor(0x800080FF)
    clPurpleAmethyst* = VColor(0x6C2DC7FF)
    clPurpleDaffodil* = VColor(0xB041FFFF)
    clPurpleDragon* = VColor(0xC38EC7FF)
    clPurpleFlower* = VColor(0xA74AC7FF)
    clPurpleHaze* = VColor(0x4E387EFF)
    clPurpleIris* = VColor(0x571B7EFF)
    clPurpleJam* = VColor(0x6A287EFF)
    clPurpleLily* = VColor(0x550A35FF)
    clPurpleMaroon* = VColor(0x810541FF)
    clPurpleMimosa* = VColor(0x9E7BFFFF)
    clPurpleMonster* = VColor(0x461B7EFF)
    clPurpleNavy* = VColor(0x4E5180FF)
    clPurplePink* = VColor(0xD16587FF)
    clPurplePlum* = VColor(0x8E35EFFF)
    clPurpleSageBush* = VColor(0x7A5DC7FF)
    clPurpleThistle* = VColor(0xD2B9D3FF)
    clPurpleViolet* = VColor(0x8D38C9FF)
    clRaspberry* = VColor(0xE30B5DFF)
    clRaspberryPurple* = VColor(0xB3446CFF)
    clRatGray* = VColor(0x6D7B8DFF)
    clRebeccaPurple* = VColor(0x663399FF)
    clRed* = VColor(0xFF0000FF)
    clRedBlood* = VColor(0x660000FF)
    clRedDirt* = VColor(0x7F5217FF)
    clRedFox* = VColor(0xC35817FF)
    clRice* = VColor(0xFAF5EFFF)
    clRichLilac* = VColor(0xB666D2FF)
    clRobinEggBlue* = VColor(0xBDEDFFFF)
    clRoguePink* = VColor(0xC12869FF)
    clRomanSilver* = VColor(0x838996FF)
    clRose* = VColor(0xE8ADAAFF)
    clRoseDust* = VColor(0x997070FF)
    clRoseGold* = VColor(0xECC5C0FF)
    clRoseRed* = VColor(0xC21E56FF)
    clRosyBrown* = VColor(0xBC8F8FFF)
    clRosyFinch* = VColor(0x7F4E52FF)
    clRosyPink* = VColor(0xB38481FF)
    clRoyalBlue* = VColor(0x4169E1FF)
    clRubberDuckyYellow* = VColor(0xFFD801FF)
    clRubyRed* = VColor(0xF62217FF)
    clRust* = VColor(0xC36241FF)
    clSaddleBrown* = VColor(0x8B4513FF)
    clSaffron* = VColor(0xFBB917FF)
    clSaffronRed* = VColor(0x931314FF)
    clSage* = VColor(0xBCB88AFF)
    clSageGreen* = VColor(0x848B79FF)
    clSaladGreen* = VColor(0xA1C935FF)
    clSalmon* = VColor(0xFA8072FF)
    clSand* = VColor(0xC2B280FF)
    clSandstone* = VColor(0x786D5FFF)
    clSandyBrown* = VColor(0xF4A460FF)
    clSangria* = VColor(0x7E3817FF)
    clSapphireBlue* = VColor(0x2554C7FF)
    clScarlet* = VColor(0xFF2400FF)
    clSchoolBusYellow* = VColor(0xE8A317FF)
    clSeaBlue* = VColor(0xC2DFFFFF)
    clSeafoamGreen* = VColor(0x3EA99FFF)
    clSeaGreen* = VColor(0x2E8B57FF)
    clSeaShell* = VColor(0xFFF5EEFF)
    clSeaTurtleGreen* = VColor(0x438D80FF)
    clSeaweedGreen* = VColor(0x437C17FF)
    clSedona* = VColor(0xCC6600FF)
    clSepia* = VColor(0x7F462CFF)
    clSepiaBrown* = VColor(0x704214FF)
    clShamrockGreen* = VColor(0x347C17FF)
    clShockingOrange* = VColor(0xE55B3CFF)
    clSienna* = VColor(0xA0522DFF)
    clSilkBlue* = VColor(0x488AC7FF)
    clSilver* = VColor(0xC0C0C0FF)
    clSilverPink* = VColor(0xC4AEADFF)
    clSkyBlue* = VColor(0x87CEEBFF)
    clSkyBlueDress* = VColor(0x6698FFFF)
    clSlateBlue* = VColor(0x6A5ACDFF)
    clSlateBlueGrey* = VColor(0x737CA1FF)
    clSlateGraniteGray* = VColor(0x657383FF)
    clSlateGray* = VColor(0x708090FF)
    clSlimeGreen* = VColor(0xBCE954FF)
    clSmokeyGray* = VColor(0x726E6DFF)
    clSnow* = VColor(0xFFFAFAFF)
    clSoftIvory* = VColor(0xFAF0DDFF)
    clSonicSilver* = VColor(0x757575FF)
    clSpringGreen* = VColor(0x00FF7FFF)
    clSteelBlue* = VColor(0x4682B4FF)
    clStoplightGoGreen* = VColor(0x57E964FF)
    clSunriseOrange* = VColor(0xE67451FF)
    clSunYellow* = VColor(0xFFE87CFF)
    clTan* = VColor(0xD2B48CFF)
    clTanBrown* = VColor(0xECE5B6FF)
    clTangerine* = VColor(0xE78A61FF)
    clTaupe* = VColor(0x483C32FF)
    clTeaGreen* = VColor(0xCCFB5DFF)
    clTeal* = VColor(0x008080FF)
    clThistle* = VColor(0xD8BFD8FF)
    clTiffanyBlue* = VColor(0x81D8D0FF)
    clTigerOrange* = VColor(0xC88141FF)
    clTomato* = VColor(0xFF6347FF)
    clTomatoSauceRed* = VColor(0xB21807FF)
    clTronBlue* = VColor(0x7DFDFEFF)
    clTulipPink* = VColor(0xC25A7CFF)
    clTurquoise* = VColor(0x40E0D0FF)
    clTyrianPurple* = VColor(0xC45AECFF)
    clUnbleachedSilk* = VColor(0xFFDDCAFF)
    clValentineRed* = VColor(0xE55451FF)
    clVampireGray* = VColor(0x565051FF)
    clVanilla* = VColor(0xF3E5ABFF)
    clVelvetMaroon* = VColor(0x7E354DFF)
    clVenomGreen* = VColor(0x728C00FF)
    clViolaPurple* = VColor(0x7E587EFF)
    clViolet* = VColor(0xEE82EEFF)
    clVioletRed* = VColor(0xF6358AFF)
    clWater* = VColor(0xEBF4FAFF)
    clWatermelonPink* = VColor(0xFC6C85FF)
    clWesternCharcoal* = VColor(0x49413FFF)
    clWheat* = VColor(0xF5DEB3FF)
    clWhite* = VColor(0xFFFFFFFF)
    clWhiteChocolate* = VColor(0xEDE6D6FF)
    clWhiteSmoke* = VColor(0xF5F5F5FF)
    clWindowsBlue* = VColor(0x357EC7FF)
    clWineRed* = VColor(0x990012FF)
    clWisteriaPurple* = VColor(0xC6AEC7FF)
    clWood* = VColor(0x966F33FF)
    clYellow* = VColor(0xFFFF00FF)
    clYellowGreen* = VColor(0x9ACD32FF)
    clYellowGreenGrosbeak* = VColor(0xE2F516FF)
    clYellowLawnGreen* = VColor(0x87F717FF)
    clZombieGreen* = VColor(0x54C571FF)

    colorNames = [
        ("acidGreen", clAcidGreen),
        ("algaeGreen", clAlgaeGreen),
        ("aliceBlue", clAliceBlue),
        ("alienGray", clAlienGray),
        ("alienGreen", clAlienGreen),
        ("aloeVeraGreen", clAloeVeraGreen),
        ("antiqueBronze", clAntiqueBronze),
        ("antiqueWhite", clAntiqueWhite),
        ("aquamarine", clAquamarine),
        ("aquamarineStone", clAquamarineStone),
        ("armyBrown", clArmyBrown),
        ("armyGreen", clArmyGreen),
        ("ashGray", clAshGray),
        ("ashWhite", clAshWhite),
        ("avocadoGreen", clAvocadoGreen),
        ("aztechPurple", clAztechPurple),
        ("azure", clAzure),
        ("azureBlue", clAzureBlue),
        ("babyBlue", clBabyBlue),
        ("babyPink", clBabyPink),
        ("bakersBrown", clBakersBrown),
        ("balloonBlue", clBalloonBlue),
        ("bananaYellow", clBananaYellow),
        ("bashfulPink", clBashfulPink),
        ("basketBallOrange", clBasketBallOrange),
        ("battleshipGray", clBattleshipGray),
        ("beanRed", clBeanRed),
        ("beer", clBeer),
        ("beetleGreen", clBeetleGreen),
        ("beeYellow", clBeeYellow),
        ("beige", clBeige),
        ("bisque", clBisque),
        ("black", clBlack),
        ("blackBean", clBlackBean),
        ("blackCat", clBlackCat),
        ("blackCow", clBlackCow),
        ("blackEel", clBlackEel),
        ("blanchedAlmond", clBlanchedAlmond),
        ("blonde", clBlonde),
        ("bloodNight", clBloodNight),
        ("bloodRed", clBloodRed),
        ("blossomPink", clBlossomPink),
        ("blue", clBlue),
        ("blueAngel", clBlueAngel),
        ("blueberryBlue", clBlueberryBlue),
        ("blueDiamond", clBlueDiamond),
        ("blueDress", clBlueDress),
        ("blueEyes", clBlueEyes),
        ("blueGray", clBlueGray),
        ("blueGreen", clBlueGreen),
        ("blueHosta", clBlueHosta),
        ("blueIvy", clBlueIvy),
        ("blueJay", clBlueJay),
        ("blueKoi", clBlueKoi),
        ("blueLagoon", clBlueLagoon),
        ("blueLotus", clBlueLotus),
        ("blueMossGreen", clBlueMossGreen),
        ("blueOrchid", clBlueOrchid),
        ("blueRibbon", clBlueRibbon),
        ("blueTurquoise", clBlueTurquoise),
        ("blueViolet", clBlueViolet),
        ("blueWhale", clBlueWhale),
        ("blueZircon", clBlueZircon),
        ("blush", clBlush),
        ("blushPink", clBlushPink),
        ("blushRed", clBlushRed),
        ("boldYellow", clBoldYellow),
        ("brass", clBrass),
        ("brightBlue", clBrightBlue),
        ("brightCyan", clBrightCyan),
        ("brightGold", clBrightGold),
        ("brightGreen", clBrightGreen),
        ("brightLilac", clBrightLilac),
        ("brightMaroon", clBrightMaroon),
        ("brightNavyBlue", clBrightNavyBlue),
        ("brightNeonPink", clBrightNeonPink),
        ("brightOrange", clBrightOrange),
        ("brightPurple", clBrightPurple),
        ("brightTurquoise", clBrightTurquoise),
        ("bronze", clBronze),
        ("brown", clBrown),
        ("brownBear", clBrownBear),
        ("brownSand", clBrownSand),
        ("brownSugar", clBrownSugar),
        ("bulletShell", clBulletShell),
        ("burgundy", clBurgundy),
        ("burlyWood", clBurlyWood),
        ("burntPink", clBurntPink),
        ("butterflyBlue", clButterflyBlue),
        ("cadetBlue", clCadetBlue),
        ("cadillacPink", clCadillacPink),
        ("camelBrown", clCamelBrown),
        ("camouflageGreen", clCamouflageGreen),
        ("canaryBlue", clCanaryBlue),
        ("canaryYellow", clCanaryYellow),
        ("cantaloupe", clCantaloupe),
        ("caramel", clCaramel),
        ("carbonGray", clCarbonGray),
        ("carbonRed", clCarbonRed),
        ("cardboardBrown", clCardboardBrown),
        ("carnationPink", clCarnationPink),
        ("carrotOrange", clCarrotOrange),
        ("celeste", clCeleste),
        ("chameleonGreen", clChameleonGreen),
        ("champagne", clChampagne),
        ("charcoal", clCharcoal),
        ("charcoalBlue", clCharcoalBlue),
        ("chartreuse", clChartreuse),
        ("cherryRed", clCherryRed),
        ("chestnut", clChestnut),
        ("chestnutRed", clChestnutRed),
        ("chilliPepper", clChilliPepper),
        ("chocolate", clChocolate),
        ("chocolateBrown", clChocolateBrown),
        ("cinnamon", clCinnamon),
        ("clemantisViolet", clClemantisViolet),
        ("cloudyGray", clCloudyGray),
        ("cloverGreen", clCloverGreen),
        ("cobaltBlue", clCobaltBlue),
        ("coffee", clCoffee),
        ("columbiaBlue", clColumbiaBlue),
        ("constructionConeOrange", clConstructionConeOrange),
        ("cookieBrown", clCookieBrown),
        ("copper", clCopper),
        ("copperRed", clCopperRed),
        ("coral", clCoral),
        ("coralBlue", clCoralBlue),
        ("cornflowerBlue", clCornflowerBlue),
        ("cornsilk", clCornsilk),
        ("cornYellow", clCornYellow),
        ("cotton", clCotton),
        ("cottonCandy", clCottonCandy),
        ("cranberry", clCranberry),
        ("cream", clCream),
        ("crimson", clCrimson),
        ("crimsonPurple", clCrimsonPurple),
        ("crocusPurple", clCrocusPurple),
        ("crystalBlue", clCrystalBlue),
        ("cyan", clCyan),
        ("cyanOpaque", clCyanOpaque),
        ("darkBisque", clDarkBisque),
        ("darkBlonde", clDarkBlonde),
        ("darkBlue", clDarkBlue),
        ("darkBlueGrey", clDarkBlueGrey),
        ("darkBrown", clDarkBrown),
        ("darkCarnationPink", clDarkCarnationPink),
        ("darkCoffee", clDarkCoffee),
        ("darkCyan", clDarkCyan),
        ("darkForestGreen", clDarkForestGreen),
        ("darkGoldenRod", clDarkGoldenRod),
        ("darkGray", clDarkGray),
        ("darkGray", clDarkGray),
        ("darkGreen", clDarkGreen),
        ("darkHotPink", clDarkHotPink),
        ("darkKhaki", clDarkKhaki),
        ("darkLimeGreen", clDarkLimeGreen),
        ("darkMagenta", clDarkMagenta),
        ("darkMint", clDarkMint),
        ("darkMoccasin", clDarkMoccasin),
        ("darkOliveGreen", clDarkOliveGreen),
        ("darkOrange", clDarkOrange),
        ("darkOrchid", clDarkOrchid),
        ("darkPink", clDarkPink),
        ("darkPurple", clDarkPurple),
        ("darkRaspberry", clDarkRaspberry),
        ("darkRed", clDarkRed),
        ("darkSalmon", clDarkSalmon),
        ("darkSeaGreen", clDarkSeaGreen),
        ("darkSienna", clDarkSienna),
        ("darkSlate", clDarkSlate),
        ("darkSlateBlue", clDarkSlateBlue),
        ("darkSlateGray", clDarkSlateGray),
        ("darkTurquoise", clDarkTurquoise),
        ("darkViolet", clDarkViolet),
        ("darkYellow", clDarkYellow),
        ("daySkyBlue", clDaySkyBlue),
        ("deepEmeraldGreen", clDeepEmeraldGreen),
        ("deepMauve", clDeepMauve),
        ("deepPeach", clDeepPeach),
        ("deepPeriwinkle", clDeepPeriwinkle),
        ("deepPink", clDeepPink),
        ("deepPurple", clDeepPurple),
        ("deepRed", clDeepRed),
        ("deepRose", clDeepRose),
        ("deepSea", clDeepSea),
        ("deepSeaBlue", clDeepSeaBlue),
        ("deepSeaGreen", clDeepSeaGreen),
        ("deepSkyBlue", clDeepSkyBlue),
        ("deepTeal", clDeepTeal),
        ("deepTurquoise", clDeepTurquoise),
        ("deepYellow", clDeepYellow),
        ("deerBrown", clDeerBrown),
        ("denimBlue", clDenimBlue),
        ("denimDarkBlue", clDenimDarkBlue),
        ("desertSand", clDesertSand),
        ("dimGray", clDimGray),
        ("dimorphothecaMagenta", clDimorphothecaMagenta),
        ("dinosaurGreen", clDinosaurGreen),
        ("dodgerBlue", clDodgerBlue),
        ("dollarBillGreen", clDollarBillGreen),
        ("donutPink", clDonutPink),
        ("dragonGreen", clDragonGreen),
        ("dullGreenYellow", clDullGreenYellow),
        ("dullPurple", clDullPurple),
        ("dullSeaGreen", clDullSeaGreen),
        ("earthBlue", clEarthBlue),
        ("earthGreen", clEarthGreen),
        ("eggplant", clEggplant),
        ("eggShell", clEggShell),
        ("electricBlue", clElectricBlue),
        ("emerald", clEmerald),
        ("emeraldGreen", clEmeraldGreen),
        ("fallForestGreen", clFallForestGreen),
        ("fallLeafBrown", clFallLeafBrown),
        ("fernGreen", clFernGreen),
        ("ferrariRed", clFerrariRed),
        ("fireBrick", clFireBrick),
        ("fireEngineRed", clFireEngineRed),
        ("flamingoPink", clFlamingoPink),
        ("floralWhite", clFloralWhite),
        ("forestGreen", clForestGreen),
        ("frenchLilac", clFrenchLilac),
        ("frogGreen", clFrogGreen),
        ("gainsboro", clGainsboro),
        ("ghostWhite", clGhostWhite),
        ("gingerBrown", clGingerBrown),
        ("glacialBlueIce", clGlacialBlueIce),
        ("gold", clGold),
        ("goldenBlonde", clGoldenBlonde),
        ("goldenBrown", clGoldenBrown),
        ("goldenRod", clGoldenRod),
        ("goldenSilk", clGoldenSilk),
        ("goldenYellow", clGoldenYellow),
        ("granite", clGranite),
        ("grape", clGrape),
        ("grapefruit", clGrapefruit),
        ("gray", clGray),
        ("grayBrown", clGrayBrown),
        ("grayCloud", clGrayCloud),
        ("grayDolphin", clGrayDolphin),
        ("grayGoose", clGrayGoose),
        ("grayishTurquoise", clGrayishTurquoise),
        ("grayWolf", clGrayWolf),
        ("green", clGreen),
        ("greenApple", clGreenApple),
        ("greenishBlue", clGreenishBlue),
        ("greenOnion", clGreenOnion),
        ("greenPeas", clGreenPeas),
        ("greenPepper", clGreenPepper),
        ("greenSnake", clGreenSnake),
        ("greenThumb", clGreenThumb),
        ("greenYellow", clGreenYellow),
        ("gulfBlue", clGulfBlue),
        ("gunmetal", clGunmetal),
        ("halloweenOrange", clHalloweenOrange),
        ("harvestGold", clHarvestGold),
        ("hazel", clHazel),
        ("hazelGreen", clHazelGreen),
        ("heavenlyBlue", clHeavenlyBlue),
        ("heliotropePurple", clHeliotropePurple),
        ("honeyDew", clHoneyDew),
        ("hotDeepPink", clHotDeepPink),
        ("hotPink", clHotPink),
        ("hummingbirdGreen", clHummingbirdGreen),
        ("iceberg", clIceberg),
        ("iguanaGreen", clIguanaGreen),
        ("indianRed", clIndianRed),
        ("indianSaffron", clIndianSaffron),
        ("indigo", clIndigo),
        ("iridium", clIridium),
        ("ironGray", clIronGray),
        ("ivory", clIvory),
        ("jade", clJade),
        ("jadeGreen", clJadeGreen),
        ("jasminePurple", clJasminePurple),
        ("jeansBlue", clJeansBlue),
        ("jellyfish", clJellyfish),
        ("jetGray", clJetGray),
        ("jungleGreen", clJungleGreen),
        ("kellyGreen", clKellyGreen),
        ("khaki", clKhaki),
        ("khakiRose", clKhakiRose),
        ("lapisBlue", clLapisBlue),
        ("lavaRed", clLavaRed),
        ("lavender", clLavender),
        ("lavenderBlue", clLavenderBlue),
        ("lavenderBlush", clLavenderBlush),
        ("lavenderPinocchio", clLavenderPinocchio),
        ("lavenderPurple", clLavenderPurple),
        ("lawnGreen", clLawnGreen),
        ("lemonChiffon", clLemonChiffon),
        ("lightAquamarine", clLightAquamarine),
        ("lightBlack", clLightBlack),
        ("lightBlue", clLightBlue),
        ("lightBrown", clLightBrown),
        ("lightCopper", clLightCopper),
        ("lightCoral", clLightCoral),
        ("lightCyan", clLightCyan),
        ("lightDayBlue", clLightDayBlue),
        ("lightFrenchBeige", clLightFrenchBeige),
        ("lightGold", clLightGold),
        ("lightGoldenRodYellow", clLightGoldenRodYellow),
        ("lightGray", clLightGray),
        ("lightGreen", clLightGreen),
        ("lightJade", clLightJade),
        ("lightOrange", clLightOrange),
        ("lightPink", clLightPink),
        ("lightPurple", clLightPurple),
        ("lightPurpleBlue", clLightPurpleBlue),
        ("lightRed", clLightRed),
        ("lightRose", clLightRose),
        ("lightRoseGreen", clLightRoseGreen),
        ("lightSalmon", clLightSalmon),
        ("lightSalmonRose", clLightSalmonRose),
        ("lightSeaGreen", clLightSeaGreen),
        ("lightSkyBlue", clLightSkyBlue),
        ("lightSlate", clLightSlate),
        ("lightSlateBlue", clLightSlateBlue),
        ("lightSlateGray", clLightSlateGray),
        ("lightSteelBlue", clLightSteelBlue),
        ("lightWhite", clLightWhite),
        ("lightYellow", clLightYellow),
        ("lilac", clLilac),
        ("lime", clLime),
        ("limeGreen", clLimeGreen),
        ("limeMintGreen", clLimeMintGreen),
        ("linen", clLinen),
        ("lipstickPink", clLipstickPink),
        ("lovelyPurple", clLovelyPurple),
        ("loveRed", clLoveRed),
        ("macaroniAndCheese", clMacaroniAndCheese),
        ("macawBlueGreen", clMacawBlueGreen),
        ("magenta", clMagenta),
        ("magicMint", clMagicMint),
        ("mahogany", clMahogany),
        ("mangoOrange", clMangoOrange),
        ("marbleBlue", clMarbleBlue),
        ("maroon", clMaroon),
        ("mauve", clMauve),
        ("mauveTaupe", clMauveTaupe),
        ("mediumAquaMarine", clMediumAquaMarine),
        ("mediumBlue", clMediumBlue),
        ("mediumForestGreen", clMediumForestGreen),
        ("mediumOrchid", clMediumOrchid),
        ("mediumPurple", clMediumPurple),
        ("mediumSeaGreen", clMediumSeaGreen),
        ("mediumSlateBlue", clMediumSlateBlue),
        ("mediumSpringGreen", clMediumSpringGreen),
        ("mediumTeal", clMediumTeal),
        ("mediumTurquoise", clMediumTurquoise),
        ("mediumVioletRed", clMediumVioletRed),
        ("metallicGold", clMetallicGold),
        ("metallicSilver", clMetallicSilver),
        ("middayBlue", clMiddayBlue),
        ("midnight", clMidnight),
        ("midnightBlue", clMidnightBlue),
        ("milkChocolate", clMilkChocolate),
        ("milkWhite", clMilkWhite),
        ("mint", clMint),
        ("mintCream", clMintCream),
        ("mintGreen", clMintGreen),
        ("mistBlue", clMistBlue),
        ("mistyRose", clMistyRose),
        ("moccasin", clMoccasin),
        ("mocha", clMocha),
        ("mustardYellow", clMustardYellow),
        ("navajoWhite", clNavajoWhite),
        ("navy", clNavy),
        ("nebulaGreen", clNebulaGreen),
        ("neonBlue", clNeonBlue),
        ("neonGreen", clNeonGreen),
        ("neonHotPink", clNeonHotPink),
        ("neonOrange", clNeonOrange),
        ("neonPink", clNeonPink),
        ("neonPurple", clNeonPurple),
        ("neonRed", clNeonRed),
        ("neonYellow", clNeonYellow),
        ("neonYellowGreen", clNeonYellowGreen),
        ("newMidnightBlue", clNewMidnightBlue),
        ("night", clNight),
        ("nightBlue", clNightBlue),
        ("northernLightsBlue", clNorthernLightsBlue),
        ("oakBrown", clOakBrown),
        ("oceanBlue", clOceanBlue),
        ("offWhite", clOffWhite),
        ("oil", clOil),
        ("oldBurgundy", clOldBurgundy),
        ("oldLace", clOldLace),
        ("olive", clOlive),
        ("oliveDrab", clOliveDrab),
        ("oliveGreen", clOliveGreen),
        ("orange", clOrange),
        ("orangeGold", clOrangeGold),
        ("orangeRed", clOrangeRed),
        ("orangeSalmon", clOrangeSalmon),
        ("orangeYellow", clOrangeYellow),
        ("orchid", clOrchid),
        ("orchidPurple", clOrchidPurple),
        ("organicBrown", clOrganicBrown),
        ("paleBlueLily", clPaleBlueLily),
        ("paleGoldenRod", clPaleGoldenRod),
        ("paleGreen", clPaleGreen),
        ("paleLilac", clPaleLilac),
        ("paleSilver", clPaleSilver),
        ("paleTurquoise", clPaleTurquoise),
        ("paleVioletRed", clPaleVioletRed),
        ("papayaOrange", clPapayaOrange),
        ("papayaWhip", clPapayaWhip),
        ("parchment", clParchment),
        ("parrotGreen", clParrotGreen),
        ("pastelBlue", clPastelBlue),
        ("pastelGreen", clPastelGreen),
        ("pastelLightBlue", clPastelLightBlue),
        ("pastelOrange", clPastelOrange),
        ("pastelPink", clPastelPink),
        ("pastelPurple", clPastelPurple),
        ("pastelRed", clPastelRed),
        ("pastelViolet", clPastelViolet),
        ("pastelYellow", clPastelYellow),
        ("peach", clPeach),
        ("peachPuff", clPeachPuff),
        ("peaGreen", clPeaGreen),
        ("pearl", clPearl),
        ("periwinkle", clPeriwinkle),
        ("periwinklePink", clPeriwinklePink),
        ("periwinklePurple", clPeriwinklePurple),
        ("peru", clPeru),
        ("pigPink", clPigPink),
        ("pineGreen", clPineGreen),
        ("pink", clPink),
        ("pinkBrown", clPinkBrown),
        ("pinkBubbleGum", clPinkBubbleGum),
        ("pinkCoral", clPinkCoral),
        ("pinkCupcake", clPinkCupcake),
        ("pinkDaisy", clPinkDaisy),
        ("pinkLemonade", clPinkLemonade),
        ("pinkPlum", clPinkPlum),
        ("pinkRose", clPinkRose),
        ("pinkViolet", clPinkViolet),
        ("pistachioGreen", clPistachioGreen),
        ("platinum", clPlatinum),
        ("platinumGray", clPlatinumGray),
        ("platinumSilver", clPlatinumSilver),
        ("plum", clPlum),
        ("plumPie", clPlumPie),
        ("plumPurple", clPlumPurple),
        ("plumVelvet", clPlumVelvet),
        ("powderBlue", clPowderBlue),
        ("puce", clPuce),
        ("pumpkinOrange", clPumpkinOrange),
        ("purple", clPurple),
        ("purpleAmethyst", clPurpleAmethyst),
        ("purpleDaffodil", clPurpleDaffodil),
        ("purpleDragon", clPurpleDragon),
        ("purpleFlower", clPurpleFlower),
        ("purpleHaze", clPurpleHaze),
        ("purpleIris", clPurpleIris),
        ("purpleJam", clPurpleJam),
        ("purpleLily", clPurpleLily),
        ("purpleMaroon", clPurpleMaroon),
        ("purpleMimosa", clPurpleMimosa),
        ("purpleMonster", clPurpleMonster),
        ("purpleNavy", clPurpleNavy),
        ("purplePink", clPurplePink),
        ("purplePlum", clPurplePlum),
        ("purpleSageBush", clPurpleSageBush),
        ("purpleThistle", clPurpleThistle),
        ("purpleViolet", clPurpleViolet),
        ("raspberry", clRaspberry),
        ("raspberryPurple", clRaspberryPurple),
        ("ratGray", clRatGray),
        ("rebeccaPurple", clRebeccaPurple),
        ("red", clRed),
        ("redBlood", clRedBlood),
        ("redDirt", clRedDirt),
        ("redFox", clRedFox),
        ("rice", clRice),
        ("richLilac", clRichLilac),
        ("robinEggBlue", clRobinEggBlue),
        ("roguePink", clRoguePink),
        ("romanSilver", clRomanSilver),
        ("rose", clRose),
        ("roseDust", clRoseDust),
        ("roseGold", clRoseGold),
        ("roseRed", clRoseRed),
        ("rosyBrown", clRosyBrown),
        ("rosyFinch", clRosyFinch),
        ("rosyPink", clRosyPink),
        ("royalBlue", clRoyalBlue),
        ("rubberDuckyYellow", clRubberDuckyYellow),
        ("rubyRed", clRubyRed),
        ("rust", clRust),
        ("saddleBrown", clSaddleBrown),
        ("saffron", clSaffron),
        ("saffronRed", clSaffronRed),
        ("sage", clSage),
        ("sageGreen", clSageGreen),
        ("saladGreen", clSaladGreen),
        ("salmon", clSalmon),
        ("sand", clSand),
        ("sandstone", clSandstone),
        ("sandyBrown", clSandyBrown),
        ("sangria", clSangria),
        ("sapphireBlue", clSapphireBlue),
        ("scarlet", clScarlet),
        ("schoolBusYellow", clSchoolBusYellow),
        ("seaBlue", clSeaBlue),
        ("seafoamGreen", clSeafoamGreen),
        ("seaGreen", clSeaGreen),
        ("seaShell", clSeaShell),
        ("seaTurtleGreen", clSeaTurtleGreen),
        ("seaweedGreen", clSeaweedGreen),
        ("sedona", clSedona),
        ("sepia", clSepia),
        ("sepiaBrown", clSepiaBrown),
        ("shamrockGreen", clShamrockGreen),
        ("shockingOrange", clShockingOrange),
        ("sienna", clSienna),
        ("silkBlue", clSilkBlue),
        ("silver", clSilver),
        ("silverPink", clSilverPink),
        ("skyBlue", clSkyBlue),
        ("skyBlueDress", clSkyBlueDress),
        ("slateBlue", clSlateBlue),
        ("slateBlueGrey", clSlateBlueGrey),
        ("slateGraniteGray", clSlateGraniteGray),
        ("slateGray", clSlateGray),
        ("slimeGreen", clSlimeGreen),
        ("smokeyGray", clSmokeyGray),
        ("snow", clSnow),
        ("softIvory", clSoftIvory),
        ("sonicSilver", clSonicSilver),
        ("springGreen", clSpringGreen),
        ("steelBlue", clSteelBlue),
        ("stoplightGoGreen", clStoplightGoGreen),
        ("sunriseOrange", clSunriseOrange),
        ("sunYellow", clSunYellow),
        ("tan", clTan),
        ("tanBrown", clTanBrown),
        ("tangerine", clTangerine),
        ("taupe", clTaupe),
        ("teaGreen", clTeaGreen),
        ("teal", clTeal),
        ("thistle", clThistle),
        ("tiffanyBlue", clTiffanyBlue),
        ("tigerOrange", clTigerOrange),
        ("tomato", clTomato),
        ("tomatoSauceRed", clTomatoSauceRed),
        ("tronBlue", clTronBlue),
        ("tulipPink", clTulipPink),
        ("turquoise", clTurquoise),
        ("tyrianPurple", clTyrianPurple),
        ("unbleachedSilk", clUnbleachedSilk),
        ("valentineRed", clValentineRed),
        ("vampireGray", clVampireGray),
        ("vanilla", clVanilla),
        ("velvetMaroon", clVelvetMaroon),
        ("venomGreen", clVenomGreen),
        ("violaPurple", clViolaPurple),
        ("violet", clViolet),
        ("violetRed", clVioletRed),
        ("water", clWater),
        ("watermelonPink", clWatermelonPink),
        ("westernCharcoal", clWesternCharcoal),
        ("wheat", clWheat),
        ("white", clWhite),
        ("whiteChocolate", clWhiteChocolate),
        ("whiteSmoke", clWhiteSmoke),
        ("windowsBlue", clWindowsBlue),
        ("wineRed", clWineRed),
        ("wisteriaPurple", clWisteriaPurple),
        ("wood", clWood),
        ("yellow", clYellow),
        ("yellowGreen", clYellowGreen),
        ("yellowGreenGrosbeak", clYellowGreenGrosbeak),
        ("yellowLawnGreen", clYellowLawnGreen),
        ("zombieGreen", clZombieGreen)
    ]

#=======================================
# Templates
#=======================================

template colorFromRGB*(r, g, b: int, a = 0xff): VColor =
    VColor(r shl 24 or g shl 16 or b shl 8 or a)

template colorFromRGB*(rgb: RGB): VColor =
    VColor(rgb.r shl 24 or rgb.g shl 16 or rgb.b shl 8 or rgb.a)

#=======================================
# Converters
#=======================================

func RGBfromColor*(c: VColor): RGB =
    result.r = c.int shr 24 and 0xff
    result.g = c.int shr 16 and 0xff
    result.b = c.int shr 8 and 0xff
    result.a = c.int and 0xff

func RGBAfromColor*(c: VColor): RGB =
    result.r = c.int shr 24 and 0xff
    result.g = c.int shr 16 and 0xff
    result.b = c.int shr 8 and 0xff
    result.a = c.int and 0xff

func HSLtoRGB*(hsl: HSL): RGB =
    func hueToRGB(p, q, t: float): float =
        var T = t
        if t<0: T += 1.0
        if t>1: T -= 1.0

        if T < 1/6.0: return (p+(q-p)*6*T)
        if T < 1/2.0: return q
        if T < 2/3.0: return (p+(q-p)*(2/3.0-T)*6)
        return p

    let h = hsl.h/360
    let s = hsl.s
    let l = hsl.l
    let a = (hsl.a*255).round

    var r = 0.0
    var g = 0.0
    var b = 0.0
    
    if s == 0.0:
        r = l
        g = l
        b = l
    else:
        var q: float
        if l<0.5:   q = l * (1+s)
        else:       q = l + s - l * s

        let p = 2*l - q
        r = (hueToRGB(p, q, h + 1/3.0) * 255).round
        g = (hueToRGB(p, q, h) * 255).round
        b = (hueToRGB(p, q, h - 1/3.0) * 255).round

    return ((int)r, (int)g, (int)b, (int)a)

func HSVtoRGB*(hsv: HSV): RGB =
    let h = (((float)hsv.h)/360)
    let s = hsv.s
    let v = hsv.v
    let a = (hsv.a*255).round

    var r = 0.0
    var g = 0.0
    var b = 0.0

    let hI = (float)(h*6)
    let f = (float)(h*6 - hI)
    let p = v * (1 - s)
    let q = v * (float)(1 - f*s)
    let t = v * (float)(1 - (1 - f) * s)
    
    if hI==0: (r, g, b) = (v, t, p)
    elif hI==1: (r, g, b) = (q, v, p)
    elif hI==2: (r, g, b) = (p, v, t)
    elif hI==3: (r, g, b) = (p, q, v)
    elif hI==4: (r, g, b) = (t, p, v)
    elif hI==5: (r, g, b) = (v, p, q)

    r = 255*r
    g = 255*g
    b = 255*b

    return ((int)r, (int)g, (int)b, (int)a)

func RGBtoHSL*(c: VColor): HSL =
    let rgb = RGBfromColor(c)

    let R = rgb.r / 255
    let G = rgb.g / 255
    let B = rgb.b / 255
    let a = rgb.a / 255

    let cMax = max(@[R,G,B])
    let cMin = min(@[R,G,B])
    let D = cMax - cMin

    var h,s,l : float

    if D==0:    h = 0
    elif cMax==R:
        h = (G-B)/D
        if G<B: h += 6.0
    elif cMax==G:   h = (B-R)/D + 2
    elif cMax==B:   h = ((R-G)/D) + 4

    h /= 6.0
    h = (360*h).round

    l = (cMax + cMin)/2

    if D==0:
        s = 0
    else:
        s = D / (1 - abs(2*l - 1))

    return ((int)h,s,l,a)

func RGBtoHSV*(c: VColor): HSV =
    let rgb = RGBfromColor(c)

    let R = rgb.r / 255
    let G = rgb.g / 255
    let B = rgb.b / 255
    let a = rgb.a / 255

    let cMax = max(@[R,G,B])
    let cMin = min(@[R,G,B])
    let D = cMax - cMin

    var s = 0.0
    var v = cMax*100.0

    if cMax != 0.0:
        s = D / cMax * 100
    
    var h = 0.0
    if s != 0.0:
        if R == cMax:   h = (G - B) / D
        elif G == cMax: h = 2 + (B - R) / D
        elif B == cMax: h = 4 + (R - G) / D

        h *= 60.0

        if h < 0:   h += 360.0

    return ((int)h,s/100.0,v/100.0,a)

#=======================================
# Helpers
#=======================================

func satPlus(a, b: int): int {.inline.} =
    result = a +% b
    if result > 255: result = 255

func satMinus(a, b: int): int {.inline.} =
    result = a -% b
    if result < 0: result = 0

func colorNameCmp(x: tuple[name: string, col: VColor], y: string): int =
    result = cmpIgnoreCase(x.name, y)

#=======================================
# Overloads
#=======================================

func `==` *(a, b: VColor): bool {.borrow.}

func `+`*(a, b: VColor): VColor =
    let A = RGBfromColor(a)
    let B = RGBfromColor(b)

    colorFromRGB(
        satPlus(A.r, B.r),
        satPlus(A.g, B.g),
        satPlus(A.b, B.b),
        satPlus(A.a, B.a)
    )

func `-`*(a, b: VColor): VColor =
    let A = RGBfromColor(a)
    let B = RGBfromColor(b)

    colorFromRGB(
        satMinus(A.r, B.r),
        satMinus(A.g, B.g),
        satMinus(A.b, B.b),
        satMinus(A.a, B.a)
    )

func `$`*(c: VColor): string =
    if (c.int and 0xff) < 0xff:
        result = '#' & toHex(int(c), 8)
    else:
        result = '#' & toHex(c.int shr 8, 6)

#=======================================
# Constructors
#=======================================

func colorFromShortHex*(s: string): VColor =
    let token = s[0] & s[0] & s[1] & s[1] & s[2] & s[2] & "FF"
    result = VColor(parseHexInt(token))

func colorFromHex*(s: string): VColor =
    result = VColor(parseHexInt(s) shl 8 or 0xff)

func colorFromHexWithAlpha*(s: string): VColor =
    result = VColor(parseHexInt(s))

func colorByName*(name: string): VColor =
    var idx = binarySearch(colorNames, name, colorNameCmp)
    if idx < 0: raise newException(ValueError, "unknown color: " & name)
    result = colorNames[idx][1]

func parseColor*(str: string): VColor =
    var s = str
    if s[0]=='#': s = str[1..^1]
    try:
        if s.len==3:    result = colorFromShortHex(s)
        elif s.len==6:  result = colorFromHex(s)
        elif s.len==8:  result = colorFromHexWithAlpha(s)
        else:           result = colorByName(s)
    except:
        result = colorByName(s)

#=======================================
# Methods
#=======================================

func alterColorValue*(c: VColor, f: float): VColor =
    var (r,g,b,a) = RGBfromColor(c)
    var pcent: float
    if f > 0:
        pcent = f
        r = satPlus(r, toInt(toFloat(r) * pcent))
        g = satPlus(g, toInt(toFloat(g) * pcent))
        b = satPlus(b, toInt(toFloat(b) * pcent))
        result = colorFromRGB(r, g, b, a)
    elif f < 0:
        pcent = (-1) * f
        r = satMinus(r, toInt(toFloat(r) * pcent))
        g = satMinus(g, toInt(toFloat(g) * pcent))
        b = satMinus(b, toInt(toFloat(b) * pcent))
        result = colorFromRGB(r, g, b, a)
    else:
        return c

func invertColor*(c: VColor): RGB =
    var hsl = RGBtoHSL(c)
    hsl.h += 180;
    if hsl.h > 360:
        hsl.h -= 360
    return HSLtoRGB(hsl)

func saturateColor*(c: VColor, diff: float): RGB =
    var hsl = RGBtoHSL(c)
    hsl.s = hsl.s + hsl.s * diff
    if hsl.s > 1: hsl.s = 1
    if hsl.s < 0: hsl.s = 0
    return HSLtoRGB(hsl)

func blendColors*(c1: VColor, c2: VColor, balance: float): RGB =
    let rgb1 = RGBfromColor(c1)
    let rgb2 = RGBfromColor(c2)

    let w1 = 1.0 - balance
    let w2 = balance

    let r = (float)(rgb1.r) * w1 + (float)(rgb2.r) * w2
    let g = (float)(rgb1.g) * w1 + (float)(rgb2.g) * w2
    let b = (float)(rgb1.b) * w1 + (float)(rgb2.b) * w2
    let a = (float)(rgb1.a) * w1 + (float)(rgb2.a) * w2

    return ((int)(r.round), (int)(g.round), (int)(b.round), (int)(a.round))

func spinColor*(c: VColor, amount: int): VColor =
    var hsl = RGBtoHSL(c)
    let hue = (hsl.h + amount) mod 360
    if hue < 0: 
        hsl.h = hue + 360
    else:
        hsl.h = hue    
    
    return colorFromRGB(HSLtoRGB(hsl))

# Palettes

func triadPalette*(c: VColor): Palette =
    result = @[0, 120, 240].map((x) => spinColor(c, x))

func tetradPalette*(c: VColor): Palette =
    result = @[0, 90, 180, 270].map((x) => spinColor(c, x))

func splitPalette*(c: VColor): Palette =
    result = @[0, 72, 216].map((x) => spinColor(c, x))

func analogousPalette*(c: VColor, size: int): Palette =
    let slices = 30
    let part = (int)(360 / slices)

    var hsl = RGBtoHSL(c)
    hsl.h = ((hsl.h - (part * (size shr 1))) + 720) mod 360
                
    var i = 0
    while i < size:
        result.add(colorFromRGB(HSLtoRGB(hsl)))
        hsl.h = (hsl.h + part) mod 360
        inc i

func monochromePalette*(c: VColor, size: int): Palette =
    var hsv = RGBtoHSV(c)
    let modification = 1.0 / (float)(size)
    var i = 0
    while i < size:
        result.add(colorFromRGB(HSVtoRGB(hsv)))
        hsv.v = hsv.v - modification
        inc i

proc randomPalette*(c: VColor, size: int): Palette =
    let threshold = 0.2
    result.add(c)
    while len(result) < size:
        for col in triadPalette(c):
            if len(result) == size: return
            var r = rand(2*threshold) - threshold
            result.add(alterColorValue(col, r))
            result = result.deduplicate()