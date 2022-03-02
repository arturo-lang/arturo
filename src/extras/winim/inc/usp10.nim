#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winerror
import wingdi
#include <usp10.h>
type
  SCRIPT_CACHE* = pointer
  SCRIPT_STRING_ANALYSIS* = pointer
  OPENTYPE_TAG* = ULONG
const
  USPBUILD* = 0400
  SCRIPT_UNDEFINED* = 0
  UNISCRIBE_OPENTYPE* = 0x0100
  SCRIPT_TAG_UNKNOWN* = 0x00000000
  USP_E_SCRIPT_NOT_IN_FONT* = MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x200)
  SGCM_RTL* = 0x00000001
  SSA_PASSWORD* = 0x00000001
  SSA_TAB* = 0x00000002
  SSA_CLIP* = 0x00000004
  SSA_FIT* = 0x00000008
  SSA_DZWG* = 0x00000010
  SSA_FALLBACK* = 0x00000020
  SSA_BREAK* = 0x00000040
  SSA_GLYPHS* = 0x00000080
  SSA_RTL* = 0x00000100
  SSA_GCP* = 0x00000200
  SSA_HOTKEY* = 0x00000400
  SSA_METAFILE* = 0x00000800
  SSA_LINK* = 0x00001000
  SSA_HIDEHOTKEY* = 0x00002000
  SSA_HOTKEYONLY* = 0x00002400
  SSA_FULLMEASURE* = 0x04000000
  SSA_LPKANSIFALLBACK* = 0x08000000
  SSA_PIDX* = 0x10000000
  SSA_LAYOUTRTL* = 0x20000000
  SSA_DONTGLYPH* = 0x40000000
  SSA_NOKASHIDA* = 0x80000000'i32
  SIC_COMPLEX* = 1
  SIC_ASCIIDIGIT* = 2
  SIC_NEUTRAL* = 4
  SCRIPT_DIGITSUBSTITUTE_CONTEXT* = 0
  SCRIPT_DIGITSUBSTITUTE_NONE* = 1
  SCRIPT_DIGITSUBSTITUTE_NATIONAL* = 2
  SCRIPT_DIGITSUBSTITUTE_TRADITIONAL* = 3
  SCRIPT_JUSTIFY_NONE* = 0
  SCRIPT_JUSTIFY_ARABIC_BLANK* = 1
  SCRIPT_JUSTIFY_CHARACTER* = 2
  SCRIPT_JUSTIFY_RESERVED1* = 3
  SCRIPT_JUSTIFY_BLANK* = 4
  SCRIPT_JUSTIFY_RESERVED2* = 5
  SCRIPT_JUSTIFY_RESERVED3* = 6
  SCRIPT_JUSTIFY_ARABIC_NORMAL* = 7
  SCRIPT_JUSTIFY_ARABIC_KASHIDA* = 8
  SCRIPT_JUSTIFY_ARABIC_ALEF* = 9
  SCRIPT_JUSTIFY_ARABIC_HA* = 10
  SCRIPT_JUSTIFY_ARABIC_RA* = 11
  SCRIPT_JUSTIFY_ARABIC_BA* = 12
  SCRIPT_JUSTIFY_ARABIC_BARA* = 13
  SCRIPT_JUSTIFY_ARABIC_SEEN* = 14
  SCRIPT_JUSTIFY_ARABIC_SEEN_M* = 15
type
  SCRIPT_CONTROL* {.pure.} = object
    uDefaultLanguage* {.bitsize:16.}: DWORD
    fContextDigits* {.bitsize:1.}: DWORD
    fInvertPreBoundDir* {.bitsize:1.}: DWORD
    fInvertPostBoundDir* {.bitsize:1.}: DWORD
    fLinkStringBefore* {.bitsize:1.}: DWORD
    fLinkStringAfter* {.bitsize:1.}: DWORD
    fNeutralOverride* {.bitsize:1.}: DWORD
    fNumericOverride* {.bitsize:1.}: DWORD
    fLegacyBidiClass* {.bitsize:1.}: DWORD
    fMergeNeutralItems* {.bitsize:1.}: DWORD
    fUseStandardBidi* {.bitsize:1.}: DWORD
    fReserved* {.bitsize:6.}: DWORD
  SCRIPT_STATE* {.pure.} = object
    uBidiLevel* {.bitsize:5.}: WORD
    fOverrideDirection* {.bitsize:1.}: WORD
    fInhibitSymSwap* {.bitsize:1.}: WORD
    fCharShape* {.bitsize:1.}: WORD
    fDigitSubstitute* {.bitsize:1.}: WORD
    fInhibitLigate* {.bitsize:1.}: WORD
    fDisplayZWG* {.bitsize:1.}: WORD
    fArabicNumContext* {.bitsize:1.}: WORD
    fGcpClusters* {.bitsize:1.}: WORD
    fReserved* {.bitsize:1.}: WORD
    fEngineReserved* {.bitsize:2.}: WORD
  SCRIPT_ANALYSIS* {.pure.} = object
    eScript* {.bitsize:10.}: WORD
    fRTL* {.bitsize:1.}: WORD
    fLayoutRTL* {.bitsize:1.}: WORD
    fLinkBefore* {.bitsize:1.}: WORD
    fLinkAfter* {.bitsize:1.}: WORD
    fLogicalOrder* {.bitsize:1.}: WORD
    fNoGlyphIndex* {.bitsize:1.}: WORD
    s*: SCRIPT_STATE
  SCRIPT_ITEM* {.pure.} = object
    iCharPos*: int32
    a*: SCRIPT_ANALYSIS
  SCRIPT_VISATTR* {.pure.} = object
    uJustification* {.bitsize:4.}: WORD
    fClusterStart* {.bitsize:1.}: WORD
    fDiacritic* {.bitsize:1.}: WORD
    fZeroWidth* {.bitsize:1.}: WORD
    fReserved* {.bitsize:1.}: WORD
    fShapeReserved* {.bitsize:8.}: WORD
  GOFFSET* {.pure.} = object
    du*: LONG
    dv*: LONG
  SCRIPT_LOGATTR* {.pure.} = object
    fSoftBreak* {.bitsize:1.}: BYTE
    fWhiteSpace* {.bitsize:1.}: BYTE
    fCharStop* {.bitsize:1.}: BYTE
    fWordStop* {.bitsize:1.}: BYTE
    fInvalid* {.bitsize:1.}: BYTE
    fReserved* {.bitsize:3.}: BYTE
  SCRIPT_PROPERTIES* {.pure.} = object
    langid* {.bitsize:16.}: DWORD
    fNumeric* {.bitsize:1.}: DWORD
    fComplex* {.bitsize:1.}: DWORD
    fNeedsWordBreaking* {.bitsize:1.}: DWORD
    fNeedsCaretInfo* {.bitsize:1.}: DWORD
    bCharSet* {.bitsize:8.}: DWORD
    fControl* {.bitsize:1.}: DWORD
    fPrivateUseArea* {.bitsize:1.}: DWORD
    fNeedsCharacterJustify* {.bitsize:1.}: DWORD
    fInvalidGlyph* {.bitsize:1.}: DWORD
    fInvalidLogAttr* {.bitsize:1.}: DWORD
    fCDM* {.bitsize:1.}: DWORD
    fAmbiguousCharSet* {.bitsize:1.}: DWORD
    fClusterSizeVaries* {.bitsize:1.}: DWORD
    fRejectInvalid* {.bitsize:1.}: DWORD
  SCRIPT_FONTPROPERTIES* {.pure.} = object
    cBytes*: int32
    wgBlank*: WORD
    wgDefault*: WORD
    wgInvalid*: WORD
    wgKashida*: WORD
    iKashidaWidth*: int32
  SCRIPT_TABDEF* {.pure.} = object
    cTabStops*: int32
    iScale*: int32
    pTabStops*: ptr int32
    iTabOrigin*: int32
  SCRIPT_DIGITSUBSTITUTE* {.pure.} = object
    NationalDigitLanguage* {.bitsize:16.}: DWORD
    TraditionalDigitLanguage* {.bitsize:16.}: DWORD
    DigitSubstitute* {.bitsize:8.}: DWORD
    dwReserved*: DWORD
  OPENTYPE_FEATURE_RECORD* {.pure.} = object
    tagFeature*: OPENTYPE_TAG
    lParameter*: LONG
  TEXTRANGE_PROPERTIES* {.pure.} = object
    potfRecords*: ptr OPENTYPE_FEATURE_RECORD
    cotfRecords*: int32
  SCRIPT_CHARPROP* {.pure.} = object
    fCanGlyphAlone* {.bitsize:1.}: WORD
    reserved* {.bitsize:15.}: WORD
  SCRIPT_GLYPHPROP* {.pure.} = object
    sva*: SCRIPT_VISATTR
    reserved*: WORD
proc ScriptFreeCache*(psc: ptr SCRIPT_CACHE): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptItemize*(pwcInChars: ptr WCHAR, cInChars: int32, cMaxItems: int32, psControl: ptr SCRIPT_CONTROL, psState: ptr SCRIPT_STATE, pItems: ptr SCRIPT_ITEM, pcItems: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptLayout*(cRuns: int32, pbLevel: ptr BYTE, piVisualToLogical: ptr int32, piLogicalToVisual: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptShape*(hdc: HDC, psc: ptr SCRIPT_CACHE, pwcChars: ptr WCHAR, cChars: int32, cMaxGlyphs: int32, psa: ptr SCRIPT_ANALYSIS, pwOutGlyphs: ptr WORD, pwLogClust: ptr WORD, psva: ptr SCRIPT_VISATTR, pcGlyphs: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptPlace*(hdc: HDC, psc: ptr SCRIPT_CACHE, pwGlyphs: ptr WORD, cGlyphs: int32, psva: ptr SCRIPT_VISATTR, psa: ptr SCRIPT_ANALYSIS, piAdvance: ptr int32, pGoffset: ptr GOFFSET, pABC: ptr ABC): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptTextOut*(hdc: HDC, psc: ptr SCRIPT_CACHE, x: int32, y: int32, fuOptions: UINT, lprc: ptr RECT, psa: ptr SCRIPT_ANALYSIS, pwcReserved: ptr WCHAR, iReserved: int32, pwGlyphs: ptr WORD, cGlyphs: int32, piAdvance: ptr int32, piJustify: ptr int32, pGoffset: ptr GOFFSET): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptJustify*(psva: ptr SCRIPT_VISATTR, piAdvance: ptr int32, cGlyphs: int32, iDx: int32, iMinKashida: int32, piJustify: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptBreak*(pwcChars: ptr WCHAR, cChars: int32, psa: ptr SCRIPT_ANALYSIS, psla: ptr SCRIPT_LOGATTR): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptCPtoX*(iCP: int32, fTrailing: WINBOOL, cChars: int32, cGlyphs: int32, pwLogClust: ptr WORD, psva: ptr SCRIPT_VISATTR, piAdvance: ptr int32, psa: ptr SCRIPT_ANALYSIS, piX: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptXtoCP*(iX: int32, cChars: int32, cGlyphs: int32, pwLogClust: ptr WORD, psva: ptr SCRIPT_VISATTR, piAdvance: ptr int32, psa: ptr SCRIPT_ANALYSIS, piCP: ptr int32, piTrailing: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetLogicalWidths*(psa: ptr SCRIPT_ANALYSIS, cChars: int32, cGlyphs: int32, piGlyphWidth: ptr int32, pwLogClust: ptr WORD, psva: ptr SCRIPT_VISATTR, piDx: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptApplyLogicalWidth*(piDx: ptr int32, cChars: int32, cGlyphs: int32, pwLogClust: ptr WORD, psva: ptr SCRIPT_VISATTR, piAdvance: ptr int32, psa: ptr SCRIPT_ANALYSIS, pABC: ptr ABC, piJustify: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetCMap*(hdc: HDC, psc: ptr SCRIPT_CACHE, pwcInChars: ptr WCHAR, cChars: int32, dwFlags: DWORD, pwOutGlyphs: ptr WORD): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetGlyphABCWidth*(hdc: HDC, psc: ptr SCRIPT_CACHE, wGlyph: WORD, pABC: ptr ABC): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetProperties*(ppSp: ptr ptr ptr SCRIPT_PROPERTIES, piNumScripts: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetFontProperties*(hdc: HDC, psc: ptr SCRIPT_CACHE, sfp: ptr SCRIPT_FONTPROPERTIES): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptCacheGetHeight*(hdc: HDC, psc: ptr SCRIPT_CACHE, tmHeight: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptStringAnalyse*(hdc: HDC, pString: pointer, cString: int32, cGlyphs: int32, iCharset: int32, dwFlags: DWORD, iReqWidth: int32, psControl: ptr SCRIPT_CONTROL, psState: ptr SCRIPT_STATE, piDx: ptr int32, pTabdef: ptr SCRIPT_TABDEF, pbInClass: ptr BYTE, pssa: ptr SCRIPT_STRING_ANALYSIS): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptStringFree*(pssa: ptr SCRIPT_STRING_ANALYSIS): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptString_pSize*(ssa: SCRIPT_STRING_ANALYSIS): ptr SIZE {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptString_pcOutChars*(ssa: SCRIPT_STRING_ANALYSIS): ptr int32 {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptString_pLogAttr*(ssa: SCRIPT_STRING_ANALYSIS): ptr SCRIPT_LOGATTR {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptStringGetOrder*(ssa: SCRIPT_STRING_ANALYSIS, puOrder: ptr UINT): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptStringCPtoX*(ssa: SCRIPT_STRING_ANALYSIS, icp: int32, fTrailing: WINBOOL, pX: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptStringXtoCP*(ssa: SCRIPT_STRING_ANALYSIS, iX: int32, piCh: ptr int32, piTrailing: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptStringGetLogicalWidths*(ssa: SCRIPT_STRING_ANALYSIS, piDx: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptStringValidate*(ssa: SCRIPT_STRING_ANALYSIS): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptStringOut*(ssa: SCRIPT_STRING_ANALYSIS, iX: int32, iY: int32, uOptions: UINT, prc: ptr RECT, iMinSel: int32, iMaxSel: int32, fDisabled: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptIsComplex*(pwcInChars: ptr WCHAR, cInChars: int32, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptRecordDigitSubstitution*(Locale: LCID, psds: ptr SCRIPT_DIGITSUBSTITUTE): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptApplyDigitSubstitution*(psds: ptr SCRIPT_DIGITSUBSTITUTE, psc: ptr SCRIPT_CONTROL, pss: ptr SCRIPT_STATE): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptShapeOpenType*(hdc: HDC, psc: ptr SCRIPT_CACHE, psa: ptr SCRIPT_ANALYSIS, tagScript: OPENTYPE_TAG, tagLangSys: OPENTYPE_TAG, rcRangeChars: ptr int32, rpRangeProperties: ptr ptr TEXTRANGE_PROPERTIES, cRanges: int32, pwcChars: ptr WCHAR, cChars: int32, cMaxGlyphs: int32, pwLogClust: ptr WORD, pCharProps: ptr SCRIPT_CHARPROP, pwOutGlyphs: ptr WORD, pOutGlyphProps: ptr SCRIPT_GLYPHPROP, pcGlyphs: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptPlaceOpenType*(hdc: HDC, psc: ptr SCRIPT_CACHE, psa: ptr SCRIPT_ANALYSIS, tagScript: OPENTYPE_TAG, tagLangSys: OPENTYPE_TAG, rcRangeChars: ptr int32, rpRangeProperties: ptr ptr TEXTRANGE_PROPERTIES, cRanges: int32, pwcChars: ptr WCHAR, pwLogClust: ptr WORD, pCharProps: ptr SCRIPT_CHARPROP, cChars: int32, pwGlyphs: ptr WORD, pGlyphProps: ptr SCRIPT_GLYPHPROP, cGlyphs: int32, piAdvance: ptr int32, pGoffset: ptr GOFFSET, pABC: ptr ABC): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptItemizeOpenType*(pwcInChars: ptr WCHAR, cInChars: int32, cMaxItems: int32, psControl: ptr SCRIPT_CONTROL, psState: ptr SCRIPT_STATE, pItems: ptr SCRIPT_ITEM, pScriptTags: ptr OPENTYPE_TAG, pcItems: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetFontScriptTags*(hdc: HDC, psc: ptr SCRIPT_CACHE, psa: ptr SCRIPT_ANALYSIS, cMaxTags: int32, pScriptTags: ptr OPENTYPE_TAG, pcTags: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetFontLanguageTags*(hdc: HDC, psc: ptr SCRIPT_CACHE, psa: ptr SCRIPT_ANALYSIS, tagScript: OPENTYPE_TAG, cMaxTags: int32, pLangsysTags: ptr OPENTYPE_TAG, pcTags: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetFontFeatureTags*(hdc: HDC, psc: ptr SCRIPT_CACHE, psa: ptr SCRIPT_ANALYSIS, tagScript: OPENTYPE_TAG, tagLangSys: OPENTYPE_TAG, cMaxTags: int32, pFeatureTags: ptr OPENTYPE_TAG, pcTags: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptGetFontAlternateGlyphs*(hdc: HDC, psc: ptr SCRIPT_CACHE, psa: ptr SCRIPT_ANALYSIS, tagScript: OPENTYPE_TAG, tagLangSys: OPENTYPE_TAG, tagFeature: OPENTYPE_TAG, wGlyphId: WORD, cMaxAlternates: int32, pAlternateGlyphs: ptr WORD, pcAlternates: ptr int32): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptSubstituteSingleGlyph*(hdc: HDC, psc: ptr SCRIPT_CACHE, psa: ptr SCRIPT_ANALYSIS, tagScript: OPENTYPE_TAG, tagLangSys: OPENTYPE_TAG, tagFeature: OPENTYPE_TAG, lParameter: LONG, wGlyphId: WORD, pwOutGlyphId: ptr WORD): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
proc ScriptPositionSingleGlyph*(hdc: HDC, psc: ptr SCRIPT_CACHE, psa: ptr SCRIPT_ANALYSIS, tagScript: OPENTYPE_TAG, tagLangSys: OPENTYPE_TAG, tagFeature: OPENTYPE_TAG, lParameter: LONG, wGlyphId: WORD, iAdvance: int32, GOffset: GOFFSET, piOutAdvance: ptr int32, pOutGoffset: ptr GOFFSET): HRESULT {.winapi, stdcall, dynlib: "usp10", importc.}
