#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <wingdi.h>
type
  FXPT16DOT16* = int32
  LPFXPT16DOT16* = ptr int32
  FXPT2DOT30* = int32
  LPFXPT2DOT30* = ptr int32
  DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY* = int32
  DISPLAYCONFIG_SCANLINE_ORDERING* = int32
  DISPLAYCONFIG_SCALING* = int32
  DISPLAYCONFIG_ROTATION* = int32
  DISPLAYCONFIG_MODE_INFO_TYPE* = int32
  DISPLAYCONFIG_PIXELFORMAT* = int32
  DISPLAYCONFIG_TOPOLOGY_ID* = int32
  DISPLAYCONFIG_DEVICE_INFO_TYPE* = int32
  LCSCSTYPE* = LONG
  LCSGAMUTMATCH* = LONG
  COLOR16* = USHORT
when winimUnicode:
  type
    BCHAR* = WCHAR
when winimAnsi:
  type
    BCHAR* = BYTE
type
  DRAWPATRECT* {.pure.} = object
    ptPosition*: POINT
    ptSize*: POINT
    wStyle*: WORD
    wPattern*: WORD
  PDRAWPATRECT* = ptr DRAWPATRECT
  PSINJECTDATA* {.pure.} = object
    DataBytes*: DWORD
    InjectionPoint*: WORD
    PageNumber*: WORD
  PPSINJECTDATA* = ptr PSINJECTDATA
  PSFEATURE_OUTPUT* {.pure.} = object
    bPageIndependent*: WINBOOL
    bSetPageDevice*: WINBOOL
  PPSFEATURE_OUTPUT* = ptr PSFEATURE_OUTPUT
  PSFEATURE_CUSTPAPER* {.pure.} = object
    lOrientation*: LONG
    lWidth*: LONG
    lHeight*: LONG
    lWidthOffset*: LONG
    lHeightOffset*: LONG
  PPSFEATURE_CUSTPAPER* = ptr PSFEATURE_CUSTPAPER
  XFORM* {.pure.} = object
    eM11*: FLOAT
    eM12*: FLOAT
    eM21*: FLOAT
    eM22*: FLOAT
    eDx*: FLOAT
    eDy*: FLOAT
  PXFORM* = ptr XFORM
  LPXFORM* = ptr XFORM
  BITMAP* {.pure.} = object
    bmType*: LONG
    bmWidth*: LONG
    bmHeight*: LONG
    bmWidthBytes*: LONG
    bmPlanes*: WORD
    bmBitsPixel*: WORD
    bmBits*: LPVOID
  PBITMAP* = ptr BITMAP
  NPBITMAP* = ptr BITMAP
  LPBITMAP* = ptr BITMAP
  RGBQUAD* {.pure.} = object
    rgbBlue*: BYTE
    rgbGreen*: BYTE
    rgbRed*: BYTE
    rgbReserved*: BYTE
  LPRGBQUAD* = ptr RGBQUAD
  CIEXYZ* {.pure.} = object
    ciexyzX*: FXPT2DOT30
    ciexyzY*: FXPT2DOT30
    ciexyzZ*: FXPT2DOT30
  LPCIEXYZ* = ptr CIEXYZ
  CIEXYZTRIPLE* {.pure.} = object
    ciexyzRed*: CIEXYZ
    ciexyzGreen*: CIEXYZ
    ciexyzBlue*: CIEXYZ
  LPCIEXYZTRIPLE* = ptr CIEXYZTRIPLE
  LOGCOLORSPACEA* {.pure.} = object
    lcsSignature*: DWORD
    lcsVersion*: DWORD
    lcsSize*: DWORD
    lcsCSType*: LCSCSTYPE
    lcsIntent*: LCSGAMUTMATCH
    lcsEndpoints*: CIEXYZTRIPLE
    lcsGammaRed*: DWORD
    lcsGammaGreen*: DWORD
    lcsGammaBlue*: DWORD
    lcsFilename*: array[MAX_PATH, CHAR]
  LPLOGCOLORSPACEA* = ptr LOGCOLORSPACEA
  LOGCOLORSPACEW* {.pure.} = object
    lcsSignature*: DWORD
    lcsVersion*: DWORD
    lcsSize*: DWORD
    lcsCSType*: LCSCSTYPE
    lcsIntent*: LCSGAMUTMATCH
    lcsEndpoints*: CIEXYZTRIPLE
    lcsGammaRed*: DWORD
    lcsGammaGreen*: DWORD
    lcsGammaBlue*: DWORD
    lcsFilename*: array[MAX_PATH, WCHAR]
  LPLOGCOLORSPACEW* = ptr LOGCOLORSPACEW
  BITMAPCOREHEADER* {.pure.} = object
    bcSize*: DWORD
    bcWidth*: WORD
    bcHeight*: WORD
    bcPlanes*: WORD
    bcBitCount*: WORD
  LPBITMAPCOREHEADER* = ptr BITMAPCOREHEADER
  PBITMAPCOREHEADER* = ptr BITMAPCOREHEADER
  BITMAPINFOHEADER* {.pure.} = object
    biSize*: DWORD
    biWidth*: LONG
    biHeight*: LONG
    biPlanes*: WORD
    biBitCount*: WORD
    biCompression*: DWORD
    biSizeImage*: DWORD
    biXPelsPerMeter*: LONG
    biYPelsPerMeter*: LONG
    biClrUsed*: DWORD
    biClrImportant*: DWORD
  LPBITMAPINFOHEADER* = ptr BITMAPINFOHEADER
  PBITMAPINFOHEADER* = ptr BITMAPINFOHEADER
  BITMAPV4HEADER* {.pure.} = object
    bV4Size*: DWORD
    bV4Width*: LONG
    bV4Height*: LONG
    bV4Planes*: WORD
    bV4BitCount*: WORD
    bV4V4Compression*: DWORD
    bV4SizeImage*: DWORD
    bV4XPelsPerMeter*: LONG
    bV4YPelsPerMeter*: LONG
    bV4ClrUsed*: DWORD
    bV4ClrImportant*: DWORD
    bV4RedMask*: DWORD
    bV4GreenMask*: DWORD
    bV4BlueMask*: DWORD
    bV4AlphaMask*: DWORD
    bV4CSType*: DWORD
    bV4Endpoints*: CIEXYZTRIPLE
    bV4GammaRed*: DWORD
    bV4GammaGreen*: DWORD
    bV4GammaBlue*: DWORD
  LPBITMAPV4HEADER* = ptr BITMAPV4HEADER
  PBITMAPV4HEADER* = ptr BITMAPV4HEADER
  BITMAPV5HEADER* {.pure.} = object
    bV5Size*: DWORD
    bV5Width*: LONG
    bV5Height*: LONG
    bV5Planes*: WORD
    bV5BitCount*: WORD
    bV5Compression*: DWORD
    bV5SizeImage*: DWORD
    bV5XPelsPerMeter*: LONG
    bV5YPelsPerMeter*: LONG
    bV5ClrUsed*: DWORD
    bV5ClrImportant*: DWORD
    bV5RedMask*: DWORD
    bV5GreenMask*: DWORD
    bV5BlueMask*: DWORD
    bV5AlphaMask*: DWORD
    bV5CSType*: DWORD
    bV5Endpoints*: CIEXYZTRIPLE
    bV5GammaRed*: DWORD
    bV5GammaGreen*: DWORD
    bV5GammaBlue*: DWORD
    bV5Intent*: DWORD
    bV5ProfileData*: DWORD
    bV5ProfileSize*: DWORD
    bV5Reserved*: DWORD
  LPBITMAPV5HEADER* = ptr BITMAPV5HEADER
  PBITMAPV5HEADER* = ptr BITMAPV5HEADER
  BITMAPINFO* {.pure.} = object
    bmiHeader*: BITMAPINFOHEADER
    bmiColors*: array[1, RGBQUAD]
  LPBITMAPINFO* = ptr BITMAPINFO
  PBITMAPINFO* = ptr BITMAPINFO
  RGBTRIPLE* {.pure.} = object
    rgbtBlue*: BYTE
    rgbtGreen*: BYTE
    rgbtRed*: BYTE
  BITMAPCOREINFO* {.pure.} = object
    bmciHeader*: BITMAPCOREHEADER
    bmciColors*: array[1, RGBTRIPLE]
  LPBITMAPCOREINFO* = ptr BITMAPCOREINFO
  PBITMAPCOREINFO* = ptr BITMAPCOREINFO
  BITMAPFILEHEADER* {.pure, packed.} = object
    bfType*: WORD
    bfSize*: DWORD
    bfReserved1*: WORD
    bfReserved2*: WORD
    bfOffBits*: DWORD
  LPBITMAPFILEHEADER* = ptr BITMAPFILEHEADER
  PBITMAPFILEHEADER* = ptr BITMAPFILEHEADER
  FONTSIGNATURE* {.pure.} = object
    fsUsb*: array[4, DWORD]
    fsCsb*: array[2, DWORD]
  PFONTSIGNATURE* = ptr FONTSIGNATURE
  LPFONTSIGNATURE* = ptr FONTSIGNATURE
  CHARSETINFO* {.pure.} = object
    ciCharset*: UINT
    ciACP*: UINT
    fs*: FONTSIGNATURE
  PCHARSETINFO* = ptr CHARSETINFO
  NPCHARSETINFO* = ptr CHARSETINFO
  LPCHARSETINFO* = ptr CHARSETINFO
  LOCALESIGNATURE* {.pure.} = object
    lsUsb*: array[4, DWORD]
    lsCsbDefault*: array[2, DWORD]
    lsCsbSupported*: array[2, DWORD]
  PLOCALESIGNATURE* = ptr LOCALESIGNATURE
  LPLOCALESIGNATURE* = ptr LOCALESIGNATURE
  HANDLETABLE* {.pure.} = object
    objectHandle*: array[1, HGDIOBJ]
  PHANDLETABLE* = ptr HANDLETABLE
  LPHANDLETABLE* = ptr HANDLETABLE
  METARECORD* {.pure.} = object
    rdSize*: DWORD
    rdFunction*: WORD
    rdParm*: array[1, WORD]
  PMETARECORD* = ptr METARECORD
  LPMETARECORD* = ptr METARECORD
  METAFILEPICT* {.pure.} = object
    mm*: LONG
    xExt*: LONG
    yExt*: LONG
    hMF*: HMETAFILE
  LPMETAFILEPICT* = ptr METAFILEPICT
  METAHEADER* {.pure, packed.} = object
    mtType*: WORD
    mtHeaderSize*: WORD
    mtVersion*: WORD
    mtSize*: DWORD
    mtNoObjects*: WORD
    mtMaxRecord*: DWORD
    mtNoParameters*: WORD
  PMETAHEADER* = ptr METAHEADER
  LPMETAHEADER* = ptr METAHEADER
  ENHMETARECORD* {.pure.} = object
    iType*: DWORD
    nSize*: DWORD
    dParm*: array[1, DWORD]
  PENHMETARECORD* = ptr ENHMETARECORD
  LPENHMETARECORD* = ptr ENHMETARECORD
  ENHMETAHEADER* {.pure.} = object
    iType*: DWORD
    nSize*: DWORD
    rclBounds*: RECTL
    rclFrame*: RECTL
    dSignature*: DWORD
    nVersion*: DWORD
    nBytes*: DWORD
    nRecords*: DWORD
    nHandles*: WORD
    sReserved*: WORD
    nDescription*: DWORD
    offDescription*: DWORD
    nPalEntries*: DWORD
    szlDevice*: SIZEL
    szlMillimeters*: SIZEL
    cbPixelFormat*: DWORD
    offPixelFormat*: DWORD
    bOpenGL*: DWORD
    szlMicrometers*: SIZEL
  PENHMETAHEADER* = ptr ENHMETAHEADER
  LPENHMETAHEADER* = ptr ENHMETAHEADER
  TEXTMETRICA* {.pure.} = object
    tmHeight*: LONG
    tmAscent*: LONG
    tmDescent*: LONG
    tmInternalLeading*: LONG
    tmExternalLeading*: LONG
    tmAveCharWidth*: LONG
    tmMaxCharWidth*: LONG
    tmWeight*: LONG
    tmOverhang*: LONG
    tmDigitizedAspectX*: LONG
    tmDigitizedAspectY*: LONG
    tmFirstChar*: BYTE
    tmLastChar*: BYTE
    tmDefaultChar*: BYTE
    tmBreakChar*: BYTE
    tmItalic*: BYTE
    tmUnderlined*: BYTE
    tmStruckOut*: BYTE
    tmPitchAndFamily*: BYTE
    tmCharSet*: BYTE
  PTEXTMETRICA* = ptr TEXTMETRICA
  NPTEXTMETRICA* = ptr TEXTMETRICA
  LPTEXTMETRICA* = ptr TEXTMETRICA
  TEXTMETRICW* {.pure.} = object
    tmHeight*: LONG
    tmAscent*: LONG
    tmDescent*: LONG
    tmInternalLeading*: LONG
    tmExternalLeading*: LONG
    tmAveCharWidth*: LONG
    tmMaxCharWidth*: LONG
    tmWeight*: LONG
    tmOverhang*: LONG
    tmDigitizedAspectX*: LONG
    tmDigitizedAspectY*: LONG
    tmFirstChar*: WCHAR
    tmLastChar*: WCHAR
    tmDefaultChar*: WCHAR
    tmBreakChar*: WCHAR
    tmItalic*: BYTE
    tmUnderlined*: BYTE
    tmStruckOut*: BYTE
    tmPitchAndFamily*: BYTE
    tmCharSet*: BYTE
  PTEXTMETRICW* = ptr TEXTMETRICW
  NPTEXTMETRICW* = ptr TEXTMETRICW
  LPTEXTMETRICW* = ptr TEXTMETRICW
  NEWTEXTMETRICA* {.pure.} = object
    tmHeight*: LONG
    tmAscent*: LONG
    tmDescent*: LONG
    tmInternalLeading*: LONG
    tmExternalLeading*: LONG
    tmAveCharWidth*: LONG
    tmMaxCharWidth*: LONG
    tmWeight*: LONG
    tmOverhang*: LONG
    tmDigitizedAspectX*: LONG
    tmDigitizedAspectY*: LONG
    tmFirstChar*: BYTE
    tmLastChar*: BYTE
    tmDefaultChar*: BYTE
    tmBreakChar*: BYTE
    tmItalic*: BYTE
    tmUnderlined*: BYTE
    tmStruckOut*: BYTE
    tmPitchAndFamily*: BYTE
    tmCharSet*: BYTE
    ntmFlags*: DWORD
    ntmSizeEM*: UINT
    ntmCellHeight*: UINT
    ntmAvgWidth*: UINT
  PNEWTEXTMETRICA* = ptr NEWTEXTMETRICA
  NPNEWTEXTMETRICA* = ptr NEWTEXTMETRICA
  LPNEWTEXTMETRICA* = ptr NEWTEXTMETRICA
  NEWTEXTMETRICW* {.pure.} = object
    tmHeight*: LONG
    tmAscent*: LONG
    tmDescent*: LONG
    tmInternalLeading*: LONG
    tmExternalLeading*: LONG
    tmAveCharWidth*: LONG
    tmMaxCharWidth*: LONG
    tmWeight*: LONG
    tmOverhang*: LONG
    tmDigitizedAspectX*: LONG
    tmDigitizedAspectY*: LONG
    tmFirstChar*: WCHAR
    tmLastChar*: WCHAR
    tmDefaultChar*: WCHAR
    tmBreakChar*: WCHAR
    tmItalic*: BYTE
    tmUnderlined*: BYTE
    tmStruckOut*: BYTE
    tmPitchAndFamily*: BYTE
    tmCharSet*: BYTE
    ntmFlags*: DWORD
    ntmSizeEM*: UINT
    ntmCellHeight*: UINT
    ntmAvgWidth*: UINT
  PNEWTEXTMETRICW* = ptr NEWTEXTMETRICW
  NPNEWTEXTMETRICW* = ptr NEWTEXTMETRICW
  LPNEWTEXTMETRICW* = ptr NEWTEXTMETRICW
  PELARRAY* {.pure.} = object
    paXCount*: LONG
    paYCount*: LONG
    paXExt*: LONG
    paYExt*: LONG
    paRGBs*: BYTE
  PPELARRAY* = ptr PELARRAY
  NPPELARRAY* = ptr PELARRAY
  LPPELARRAY* = ptr PELARRAY
  LOGBRUSH* {.pure.} = object
    lbStyle*: UINT
    lbColor*: COLORREF
    lbHatch*: ULONG_PTR
  PLOGBRUSH* = ptr LOGBRUSH
  NPLOGBRUSH* = ptr LOGBRUSH
  LPLOGBRUSH* = ptr LOGBRUSH
  LOGBRUSH32* {.pure.} = object
    lbStyle*: UINT
    lbColor*: COLORREF
    lbHatch*: ULONG
  PLOGBRUSH32* = ptr LOGBRUSH32
  NPLOGBRUSH32* = ptr LOGBRUSH32
  LPLOGBRUSH32* = ptr LOGBRUSH32
  PATTERN* = LOGBRUSH
  PPATTERN* = ptr PATTERN
  NPPATTERN* = ptr PATTERN
  LPPATTERN* = ptr PATTERN
  LOGPEN* {.pure.} = object
    lopnStyle*: UINT
    lopnWidth*: POINT
    lopnColor*: COLORREF
  PLOGPEN* = ptr LOGPEN
  NPLOGPEN* = ptr LOGPEN
  LPLOGPEN* = ptr LOGPEN
  EXTLOGPEN* {.pure.} = object
    elpPenStyle*: DWORD
    elpWidth*: DWORD
    elpBrushStyle*: UINT
    elpColor*: COLORREF
    elpHatch*: ULONG_PTR
    elpNumEntries*: DWORD
    elpStyleEntry*: array[1, DWORD]
  PEXTLOGPEN* = ptr EXTLOGPEN
  NPEXTLOGPEN* = ptr EXTLOGPEN
  LPEXTLOGPEN* = ptr EXTLOGPEN
  EXTLOGPEN32* {.pure.} = object
    elpPenStyle*: DWORD
    elpWidth*: DWORD
    elpBrushStyle*: UINT
    elpColor*: COLORREF
    elpHatch*: ULONG
    elpNumEntries*: DWORD
    elpStyleEntry*: array[1, DWORD]
  PEXTLOGPEN32* = ptr EXTLOGPEN32
  NPEXTLOGPEN32* = ptr EXTLOGPEN32
  LPEXTLOGPEN32* = ptr EXTLOGPEN32
  PALETTEENTRY* {.pure.} = object
    peRed*: BYTE
    peGreen*: BYTE
    peBlue*: BYTE
    peFlags*: BYTE
  PPALETTEENTRY* = ptr PALETTEENTRY
  LPPALETTEENTRY* = ptr PALETTEENTRY
  LOGPALETTE* {.pure.} = object
    palVersion*: WORD
    palNumEntries*: WORD
    palPalEntry*: array[1, PALETTEENTRY]
  PLOGPALETTE* = ptr LOGPALETTE
  NPLOGPALETTE* = ptr LOGPALETTE
  LPLOGPALETTE* = ptr LOGPALETTE
const
  LF_FACESIZE* = 32
type
  LOGFONTA* {.pure.} = object
    lfHeight*: LONG
    lfWidth*: LONG
    lfEscapement*: LONG
    lfOrientation*: LONG
    lfWeight*: LONG
    lfItalic*: BYTE
    lfUnderline*: BYTE
    lfStrikeOut*: BYTE
    lfCharSet*: BYTE
    lfOutPrecision*: BYTE
    lfClipPrecision*: BYTE
    lfQuality*: BYTE
    lfPitchAndFamily*: BYTE
    lfFaceName*: array[LF_FACESIZE, CHAR]
  PLOGFONTA* = ptr LOGFONTA
  NPLOGFONTA* = ptr LOGFONTA
  LPLOGFONTA* = ptr LOGFONTA
  LOGFONTW* {.pure.} = object
    lfHeight*: LONG
    lfWidth*: LONG
    lfEscapement*: LONG
    lfOrientation*: LONG
    lfWeight*: LONG
    lfItalic*: BYTE
    lfUnderline*: BYTE
    lfStrikeOut*: BYTE
    lfCharSet*: BYTE
    lfOutPrecision*: BYTE
    lfClipPrecision*: BYTE
    lfQuality*: BYTE
    lfPitchAndFamily*: BYTE
    lfFaceName*: array[LF_FACESIZE, WCHAR]
  PLOGFONTW* = ptr LOGFONTW
  NPLOGFONTW* = ptr LOGFONTW
  LPLOGFONTW* = ptr LOGFONTW
const
  LF_FULLFACESIZE* = 64
type
  ENUMLOGFONTA* {.pure.} = object
    elfLogFont*: LOGFONTA
    elfFullName*: array[LF_FULLFACESIZE, BYTE]
    elfStyle*: array[LF_FACESIZE, BYTE]
  LPENUMLOGFONTA* = ptr ENUMLOGFONTA
  ENUMLOGFONTW* {.pure.} = object
    elfLogFont*: LOGFONTW
    elfFullName*: array[LF_FULLFACESIZE, WCHAR]
    elfStyle*: array[LF_FACESIZE, WCHAR]
  LPENUMLOGFONTW* = ptr ENUMLOGFONTW
  ENUMLOGFONTEXA* {.pure.} = object
    elfLogFont*: LOGFONTA
    elfFullName*: array[LF_FULLFACESIZE, BYTE]
    elfStyle*: array[LF_FACESIZE, BYTE]
    elfScript*: array[LF_FACESIZE, BYTE]
  LPENUMLOGFONTEXA* = ptr ENUMLOGFONTEXA
  ENUMLOGFONTEXW* {.pure.} = object
    elfLogFont*: LOGFONTW
    elfFullName*: array[LF_FULLFACESIZE, WCHAR]
    elfStyle*: array[LF_FACESIZE, WCHAR]
    elfScript*: array[LF_FACESIZE, WCHAR]
  LPENUMLOGFONTEXW* = ptr ENUMLOGFONTEXW
  PANOSE* {.pure.} = object
    bFamilyType*: BYTE
    bSerifStyle*: BYTE
    bWeight*: BYTE
    bProportion*: BYTE
    bContrast*: BYTE
    bStrokeVariation*: BYTE
    bArmStyle*: BYTE
    bLetterform*: BYTE
    bMidline*: BYTE
    bXHeight*: BYTE
  LPPANOSE* = ptr PANOSE
const
  ELF_VENDOR_SIZE* = 4
type
  EXTLOGFONTA* {.pure.} = object
    elfLogFont*: LOGFONTA
    elfFullName*: array[LF_FULLFACESIZE, BYTE]
    elfStyle*: array[LF_FACESIZE, BYTE]
    elfVersion*: DWORD
    elfStyleSize*: DWORD
    elfMatch*: DWORD
    elfReserved*: DWORD
    elfVendorId*: array[ELF_VENDOR_SIZE, BYTE]
    elfCulture*: DWORD
    elfPanose*: PANOSE
  PEXTLOGFONTA* = ptr EXTLOGFONTA
  NPEXTLOGFONTA* = ptr EXTLOGFONTA
  LPEXTLOGFONTA* = ptr EXTLOGFONTA
  EXTLOGFONTW* {.pure.} = object
    elfLogFont*: LOGFONTW
    elfFullName*: array[LF_FULLFACESIZE, WCHAR]
    elfStyle*: array[LF_FACESIZE, WCHAR]
    elfVersion*: DWORD
    elfStyleSize*: DWORD
    elfMatch*: DWORD
    elfReserved*: DWORD
    elfVendorId*: array[ELF_VENDOR_SIZE, BYTE]
    elfCulture*: DWORD
    elfPanose*: PANOSE
  PEXTLOGFONTW* = ptr EXTLOGFONTW
  NPEXTLOGFONTW* = ptr EXTLOGFONTW
  LPEXTLOGFONTW* = ptr EXTLOGFONTW
const
  CCHDEVICENAME* = 32
type
  DEVMODEA_UNION1_STRUCT1* {.pure.} = object
    dmOrientation*: int16
    dmPaperSize*: int16
    dmPaperLength*: int16
    dmPaperWidth*: int16
    dmScale*: int16
    dmCopies*: int16
    dmDefaultSource*: int16
    dmPrintQuality*: int16
  DEVMODEA_UNION1_STRUCT2* {.pure.} = object
    dmPosition*: POINTL
    dmDisplayOrientation*: DWORD
    dmDisplayFixedOutput*: DWORD
  DEVMODEA_UNION1* {.pure, union.} = object
    struct1*: DEVMODEA_UNION1_STRUCT1
    struct2*: DEVMODEA_UNION1_STRUCT2
const
  CCHFORMNAME* = 32
type
  DEVMODEA_UNION2* {.pure, union.} = object
    dmDisplayFlags*: DWORD
    dmNup*: DWORD
  DEVMODEA* {.pure.} = object
    dmDeviceName*: array[CCHDEVICENAME, BYTE]
    dmSpecVersion*: WORD
    dmDriverVersion*: WORD
    dmSize*: WORD
    dmDriverExtra*: WORD
    dmFields*: DWORD
    union1*: DEVMODEA_UNION1
    dmColor*: int16
    dmDuplex*: int16
    dmYResolution*: int16
    dmTTOption*: int16
    dmCollate*: int16
    dmFormName*: array[CCHFORMNAME, BYTE]
    dmLogPixels*: WORD
    dmBitsPerPel*: DWORD
    dmPelsWidth*: DWORD
    dmPelsHeight*: DWORD
    union2*: DEVMODEA_UNION2
    dmDisplayFrequency*: DWORD
    dmICMMethod*: DWORD
    dmICMIntent*: DWORD
    dmMediaType*: DWORD
    dmDitherType*: DWORD
    dmReserved1*: DWORD
    dmReserved2*: DWORD
    dmPanningWidth*: DWORD
    dmPanningHeight*: DWORD
  PDEVMODEA* = ptr DEVMODEA
  NPDEVMODEA* = ptr DEVMODEA
  LPDEVMODEA* = ptr DEVMODEA
  DEVMODEW_UNION1_STRUCT1* {.pure.} = object
    dmOrientation*: int16
    dmPaperSize*: int16
    dmPaperLength*: int16
    dmPaperWidth*: int16
    dmScale*: int16
    dmCopies*: int16
    dmDefaultSource*: int16
    dmPrintQuality*: int16
  DEVMODEW_UNION1_STRUCT2* {.pure.} = object
    dmPosition*: POINTL
    dmDisplayOrientation*: DWORD
    dmDisplayFixedOutput*: DWORD
  DEVMODEW_UNION1* {.pure, union.} = object
    struct1*: DEVMODEW_UNION1_STRUCT1
    struct2*: DEVMODEW_UNION1_STRUCT2
  DEVMODEW_UNION2* {.pure, union.} = object
    dmDisplayFlags*: DWORD
    dmNup*: DWORD
  DEVMODEW* {.pure.} = object
    dmDeviceName*: array[CCHDEVICENAME, WCHAR]
    dmSpecVersion*: WORD
    dmDriverVersion*: WORD
    dmSize*: WORD
    dmDriverExtra*: WORD
    dmFields*: DWORD
    union1*: DEVMODEW_UNION1
    dmColor*: int16
    dmDuplex*: int16
    dmYResolution*: int16
    dmTTOption*: int16
    dmCollate*: int16
    dmFormName*: array[CCHFORMNAME, WCHAR]
    dmLogPixels*: WORD
    dmBitsPerPel*: DWORD
    dmPelsWidth*: DWORD
    dmPelsHeight*: DWORD
    union2*: DEVMODEW_UNION2
    dmDisplayFrequency*: DWORD
    dmICMMethod*: DWORD
    dmICMIntent*: DWORD
    dmMediaType*: DWORD
    dmDitherType*: DWORD
    dmReserved1*: DWORD
    dmReserved2*: DWORD
    dmPanningWidth*: DWORD
    dmPanningHeight*: DWORD
  PDEVMODEW* = ptr DEVMODEW
  NPDEVMODEW* = ptr DEVMODEW
  LPDEVMODEW* = ptr DEVMODEW
  DISPLAY_DEVICEA* {.pure.} = object
    cb*: DWORD
    DeviceName*: array[32, CHAR]
    DeviceString*: array[128, CHAR]
    StateFlags*: DWORD
    DeviceID*: array[128, CHAR]
    DeviceKey*: array[128, CHAR]
  PDISPLAY_DEVICEA* = ptr DISPLAY_DEVICEA
  LPDISPLAY_DEVICEA* = ptr DISPLAY_DEVICEA
  DISPLAY_DEVICEW* {.pure.} = object
    cb*: DWORD
    DeviceName*: array[32, WCHAR]
    DeviceString*: array[128, WCHAR]
    StateFlags*: DWORD
    DeviceID*: array[128, WCHAR]
    DeviceKey*: array[128, WCHAR]
  PDISPLAY_DEVICEW* = ptr DISPLAY_DEVICEW
  LPDISPLAY_DEVICEW* = ptr DISPLAY_DEVICEW
  RGNDATAHEADER* {.pure.} = object
    dwSize*: DWORD
    iType*: DWORD
    nCount*: DWORD
    nRgnSize*: DWORD
    rcBound*: RECT
  PRGNDATAHEADER* = ptr RGNDATAHEADER
  RGNDATA* {.pure.} = object
    rdh*: RGNDATAHEADER
    Buffer*: array[1, char]
  PRGNDATA* = ptr RGNDATA
  NPRGNDATA* = ptr RGNDATA
  LPRGNDATA* = ptr RGNDATA
  ABC* {.pure.} = object
    abcA*: int32
    abcB*: UINT
    abcC*: int32
  PABC* = ptr ABC
  NPABC* = ptr ABC
  LPABC* = ptr ABC
  ABCFLOAT* {.pure.} = object
    abcfA*: FLOAT
    abcfB*: FLOAT
    abcfC*: FLOAT
  PABCFLOAT* = ptr ABCFLOAT
  NPABCFLOAT* = ptr ABCFLOAT
  LPABCFLOAT* = ptr ABCFLOAT
  OUTLINETEXTMETRICA* {.pure.} = object
    otmSize*: UINT
    otmTextMetrics*: TEXTMETRICA
    otmFiller*: BYTE
    otmPanoseNumber*: PANOSE
    otmfsSelection*: UINT
    otmfsType*: UINT
    otmsCharSlopeRise*: int32
    otmsCharSlopeRun*: int32
    otmItalicAngle*: int32
    otmEMSquare*: UINT
    otmAscent*: int32
    otmDescent*: int32
    otmLineGap*: UINT
    otmsCapEmHeight*: UINT
    otmsXHeight*: UINT
    otmrcFontBox*: RECT
    otmMacAscent*: int32
    otmMacDescent*: int32
    otmMacLineGap*: UINT
    otmusMinimumPPEM*: UINT
    otmptSubscriptSize*: POINT
    otmptSubscriptOffset*: POINT
    otmptSuperscriptSize*: POINT
    otmptSuperscriptOffset*: POINT
    otmsStrikeoutSize*: UINT
    otmsStrikeoutPosition*: int32
    otmsUnderscoreSize*: int32
    otmsUnderscorePosition*: int32
    otmpFamilyName*: PSTR
    otmpFaceName*: PSTR
    otmpStyleName*: PSTR
    otmpFullName*: PSTR
  POUTLINETEXTMETRICA* = ptr OUTLINETEXTMETRICA
  NPOUTLINETEXTMETRICA* = ptr OUTLINETEXTMETRICA
  LPOUTLINETEXTMETRICA* = ptr OUTLINETEXTMETRICA
  OUTLINETEXTMETRICW* {.pure.} = object
    otmSize*: UINT
    otmTextMetrics*: TEXTMETRICW
    otmFiller*: BYTE
    otmPanoseNumber*: PANOSE
    otmfsSelection*: UINT
    otmfsType*: UINT
    otmsCharSlopeRise*: int32
    otmsCharSlopeRun*: int32
    otmItalicAngle*: int32
    otmEMSquare*: UINT
    otmAscent*: int32
    otmDescent*: int32
    otmLineGap*: UINT
    otmsCapEmHeight*: UINT
    otmsXHeight*: UINT
    otmrcFontBox*: RECT
    otmMacAscent*: int32
    otmMacDescent*: int32
    otmMacLineGap*: UINT
    otmusMinimumPPEM*: UINT
    otmptSubscriptSize*: POINT
    otmptSubscriptOffset*: POINT
    otmptSuperscriptSize*: POINT
    otmptSuperscriptOffset*: POINT
    otmsStrikeoutSize*: UINT
    otmsStrikeoutPosition*: int32
    otmsUnderscoreSize*: int32
    otmsUnderscorePosition*: int32
    otmpFamilyName*: PSTR
    otmpFaceName*: PSTR
    otmpStyleName*: PSTR
    otmpFullName*: PSTR
  POUTLINETEXTMETRICW* = ptr OUTLINETEXTMETRICW
  NPOUTLINETEXTMETRICW* = ptr OUTLINETEXTMETRICW
  LPOUTLINETEXTMETRICW* = ptr OUTLINETEXTMETRICW
  POLYTEXTA* {.pure.} = object
    x*: int32
    y*: int32
    n*: UINT
    lpstr*: LPCSTR
    uiFlags*: UINT
    rcl*: RECT
    pdx*: ptr int32
  PPOLYTEXTA* = ptr POLYTEXTA
  NPPOLYTEXTA* = ptr POLYTEXTA
  LPPOLYTEXTA* = ptr POLYTEXTA
  POLYTEXTW* {.pure.} = object
    x*: int32
    y*: int32
    n*: UINT
    lpstr*: LPCWSTR
    uiFlags*: UINT
    rcl*: RECT
    pdx*: ptr int32
  PPOLYTEXTW* = ptr POLYTEXTW
  NPPOLYTEXTW* = ptr POLYTEXTW
  LPPOLYTEXTW* = ptr POLYTEXTW
  FIXED* {.pure.} = object
    fract*: WORD
    value*: int16
  MAT2* {.pure.} = object
    eM11*: FIXED
    eM12*: FIXED
    eM21*: FIXED
    eM22*: FIXED
  LPMAT2* = ptr MAT2
  GLYPHMETRICS* {.pure.} = object
    gmBlackBoxX*: UINT
    gmBlackBoxY*: UINT
    gmptGlyphOrigin*: POINT
    gmCellIncX*: int16
    gmCellIncY*: int16
  LPGLYPHMETRICS* = ptr GLYPHMETRICS
  POINTFX* {.pure.} = object
    x*: FIXED
    y*: FIXED
  LPPOINTFX* = ptr POINTFX
  TTPOLYCURVE* {.pure.} = object
    wType*: WORD
    cpfx*: WORD
    apfx*: array[1, POINTFX]
  LPTTPOLYCURVE* = ptr TTPOLYCURVE
  TTPOLYGONHEADER* {.pure.} = object
    cb*: DWORD
    dwType*: DWORD
    pfxStart*: POINTFX
  LPTTPOLYGONHEADER* = ptr TTPOLYGONHEADER
  GCP_RESULTSA* {.pure.} = object
    lStructSize*: DWORD
    lpOutString*: LPSTR
    lpOrder*: ptr UINT
    lpDx*: ptr int32
    lpCaretPos*: ptr int32
    lpClass*: LPSTR
    lpGlyphs*: LPWSTR
    nGlyphs*: UINT
    nMaxFit*: int32
  LPGCP_RESULTSA* = ptr GCP_RESULTSA
  GCP_RESULTSW* {.pure.} = object
    lStructSize*: DWORD
    lpOutString*: LPWSTR
    lpOrder*: ptr UINT
    lpDx*: ptr int32
    lpCaretPos*: ptr int32
    lpClass*: LPSTR
    lpGlyphs*: LPWSTR
    nGlyphs*: UINT
    nMaxFit*: int32
  LPGCP_RESULTSW* = ptr GCP_RESULTSW
  RASTERIZER_STATUS* {.pure.} = object
    nSize*: int16
    wFlags*: int16
    nLanguageID*: int16
  LPRASTERIZER_STATUS* = ptr RASTERIZER_STATUS
  PIXELFORMATDESCRIPTOR* {.pure.} = object
    nSize*: WORD
    nVersion*: WORD
    dwFlags*: DWORD
    iPixelType*: BYTE
    cColorBits*: BYTE
    cRedBits*: BYTE
    cRedShift*: BYTE
    cGreenBits*: BYTE
    cGreenShift*: BYTE
    cBlueBits*: BYTE
    cBlueShift*: BYTE
    cAlphaBits*: BYTE
    cAlphaShift*: BYTE
    cAccumBits*: BYTE
    cAccumRedBits*: BYTE
    cAccumGreenBits*: BYTE
    cAccumBlueBits*: BYTE
    cAccumAlphaBits*: BYTE
    cDepthBits*: BYTE
    cStencilBits*: BYTE
    cAuxBuffers*: BYTE
    iLayerType*: BYTE
    bReserved*: BYTE
    dwLayerMask*: DWORD
    dwVisibleMask*: DWORD
    dwDamageMask*: DWORD
  PPIXELFORMATDESCRIPTOR* = ptr PIXELFORMATDESCRIPTOR
  LPPIXELFORMATDESCRIPTOR* = ptr PIXELFORMATDESCRIPTOR
  OLDFONTENUMPROCA* = proc (P1: ptr LOGFONTA, P2: ptr TEXTMETRICA, P3: DWORD, P4: LPARAM): int32 {.stdcall.}
  FONTENUMPROCA* = OLDFONTENUMPROCA
  OLDFONTENUMPROCW* = proc (P1: ptr LOGFONTW, P2: ptr TEXTMETRICW, P3: DWORD, P4: LPARAM): int32 {.stdcall.}
  FONTENUMPROCW* = OLDFONTENUMPROCW
  WCRANGE* {.pure.} = object
    wcLow*: WCHAR
    cGlyphs*: USHORT
  PWCRANGE* = ptr WCRANGE
  LPWCRANGE* = ptr WCRANGE
  GLYPHSET* {.pure.} = object
    cbThis*: DWORD
    flAccel*: DWORD
    cGlyphsSupported*: DWORD
    cRanges*: DWORD
    ranges*: array[1, WCRANGE]
  PGLYPHSET* = ptr GLYPHSET
  LPGLYPHSET* = ptr GLYPHSET
const
  MM_MAX_NUMAXES* = 16
type
  DESIGNVECTOR* {.pure.} = object
    dvReserved*: DWORD
    dvNumAxes*: DWORD
    dvValues*: array[MM_MAX_NUMAXES, LONG]
  PDESIGNVECTOR* = ptr DESIGNVECTOR
  LPDESIGNVECTOR* = ptr DESIGNVECTOR
const
  MM_MAX_AXES_NAMELEN* = 16
type
  AXISINFOA* {.pure.} = object
    axMinValue*: LONG
    axMaxValue*: LONG
    axAxisName*: array[MM_MAX_AXES_NAMELEN, BYTE]
  PAXISINFOA* = ptr AXISINFOA
  LPAXISINFOA* = ptr AXISINFOA
  AXISINFOW* {.pure.} = object
    axMinValue*: LONG
    axMaxValue*: LONG
    axAxisName*: array[MM_MAX_AXES_NAMELEN, WCHAR]
  PAXISINFOW* = ptr AXISINFOW
  LPAXISINFOW* = ptr AXISINFOW
  AXESLISTA* {.pure.} = object
    axlReserved*: DWORD
    axlNumAxes*: DWORD
    axlAxisInfo*: array[MM_MAX_NUMAXES, AXISINFOA]
  PAXESLISTA* = ptr AXESLISTA
  LPAXESLISTA* = ptr AXESLISTA
  AXESLISTW* {.pure.} = object
    axlReserved*: DWORD
    axlNumAxes*: DWORD
    axlAxisInfo*: array[MM_MAX_NUMAXES, AXISINFOW]
  PAXESLISTW* = ptr AXESLISTW
  LPAXESLISTW* = ptr AXESLISTW
  ENUMLOGFONTEXDVA* {.pure.} = object
    elfEnumLogfontEx*: ENUMLOGFONTEXA
    elfDesignVector*: DESIGNVECTOR
  PENUMLOGFONTEXDVA* = ptr ENUMLOGFONTEXDVA
  LPENUMLOGFONTEXDVA* = ptr ENUMLOGFONTEXDVA
  ENUMLOGFONTEXDVW* {.pure.} = object
    elfEnumLogfontEx*: ENUMLOGFONTEXW
    elfDesignVector*: DESIGNVECTOR
  PENUMLOGFONTEXDVW* = ptr ENUMLOGFONTEXDVW
  LPENUMLOGFONTEXDVW* = ptr ENUMLOGFONTEXDVW
  NEWTEXTMETRICEXA* {.pure.} = object
    ntmTm*: NEWTEXTMETRICA
    ntmFontSig*: FONTSIGNATURE
  ENUMTEXTMETRICA* {.pure.} = object
    etmNewTextMetricEx*: NEWTEXTMETRICEXA
    etmAxesList*: AXESLISTA
  PENUMTEXTMETRICA* = ptr ENUMTEXTMETRICA
  LPENUMTEXTMETRICA* = ptr ENUMTEXTMETRICA
  NEWTEXTMETRICEXW* {.pure.} = object
    ntmTm*: NEWTEXTMETRICW
    ntmFontSig*: FONTSIGNATURE
  ENUMTEXTMETRICW* {.pure.} = object
    etmNewTextMetricEx*: NEWTEXTMETRICEXW
    etmAxesList*: AXESLISTW
  PENUMTEXTMETRICW* = ptr ENUMTEXTMETRICW
  LPENUMTEXTMETRICW* = ptr ENUMTEXTMETRICW
  DDRAWMARSHCALLBACKMARSHAL* = proc (hGdiObj: HGDIOBJ, pGdiRef: LPVOID, ppDDrawRef: ptr LPVOID): HRESULT {.stdcall.}
  DDRAWMARSHCALLBACKUNMARSHAL* = proc (pData: LPVOID, phdc: ptr HDC, ppDDrawRef: ptr LPVOID): HRESULT {.stdcall.}
  DDRAWMARSHCALLBACKRELEASE* = proc (pDDrawRef: LPVOID): HRESULT {.stdcall.}
  GDIREGISTERDDRAWPACKET* {.pure.} = object
    dwSize*: DWORD
    dwVersion*: DWORD
    pfnDdMarshal*: DDRAWMARSHCALLBACKMARSHAL
    pfnDdUnmarshal*: DDRAWMARSHCALLBACKUNMARSHAL
    pfnDdRelease*: DDRAWMARSHCALLBACKRELEASE
  PGDIREGISTERDDRAWPACKET* = ptr GDIREGISTERDDRAWPACKET
  TRIVERTEX* {.pure.} = object
    x*: LONG
    y*: LONG
    Red*: COLOR16
    Green*: COLOR16
    Blue*: COLOR16
    Alpha*: COLOR16
  PTRIVERTEX* = ptr TRIVERTEX
  LPTRIVERTEX* = ptr TRIVERTEX
  GRADIENT_TRIANGLE* {.pure.} = object
    Vertex1*: ULONG
    Vertex2*: ULONG
    Vertex3*: ULONG
  PGRADIENT_TRIANGLE* = ptr GRADIENT_TRIANGLE
  LPGRADIENT_TRIANGLE* = ptr GRADIENT_TRIANGLE
  GRADIENT_RECT* {.pure.} = object
    UpperLeft*: ULONG
    LowerRight*: ULONG
  PGRADIENT_RECT* = ptr GRADIENT_RECT
  LPGRADIENT_RECT* = ptr GRADIENT_RECT
  BLENDFUNCTION* {.pure.} = object
    BlendOp*: BYTE
    BlendFlags*: BYTE
    SourceConstantAlpha*: BYTE
    AlphaFormat*: BYTE
  PBLENDFUNCTION* = ptr BLENDFUNCTION
  DIBSECTION* {.pure.} = object
    dsBm*: BITMAP
    dsBmih*: BITMAPINFOHEADER
    dsBitfields*: array[3, DWORD]
    dshSection*: HANDLE
    dsOffset*: DWORD
  LPDIBSECTION* = ptr DIBSECTION
  PDIBSECTION* = ptr DIBSECTION
  COLORADJUSTMENT* {.pure.} = object
    caSize*: WORD
    caFlags*: WORD
    caIlluminantIndex*: WORD
    caRedGamma*: WORD
    caGreenGamma*: WORD
    caBlueGamma*: WORD
    caReferenceBlack*: WORD
    caReferenceWhite*: WORD
    caContrast*: SHORT
    caBrightness*: SHORT
    caColorfulness*: SHORT
    caRedGreenTint*: SHORT
  PCOLORADJUSTMENT* = ptr COLORADJUSTMENT
  LPCOLORADJUSTMENT* = ptr COLORADJUSTMENT
  DOCINFOA* {.pure.} = object
    cbSize*: int32
    lpszDocName*: LPCSTR
    lpszOutput*: LPCSTR
    lpszDatatype*: LPCSTR
    fwType*: DWORD
  LPDOCINFOA* = ptr DOCINFOA
  DOCINFOW* {.pure.} = object
    cbSize*: int32
    lpszDocName*: LPCWSTR
    lpszOutput*: LPCWSTR
    lpszDatatype*: LPCWSTR
    fwType*: DWORD
  LPDOCINFOW* = ptr DOCINFOW
  KERNINGPAIR* {.pure.} = object
    wFirst*: WORD
    wSecond*: WORD
    iKernAmount*: int32
  LPKERNINGPAIR* = ptr KERNINGPAIR
  EMR* {.pure.} = object
    iType*: DWORD
    nSize*: DWORD
  PEMR* = ptr EMR
  EMRTEXT* {.pure.} = object
    ptlReference*: POINTL
    nChars*: DWORD
    offString*: DWORD
    fOptions*: DWORD
    rcl*: RECTL
    offDx*: DWORD
  PEMRTEXT* = ptr EMRTEXT
  EMRABORTPATH* {.pure.} = object
    emr*: EMR
  PEMRABORTPATH* = ptr EMRABORTPATH
  EMRBEGINPATH* = EMRABORTPATH
  PEMRBEGINPATH* = ptr EMRABORTPATH
  EMRENDPATH* = EMRABORTPATH
  PEMRENDPATH* = ptr EMRABORTPATH
  EMRCLOSEFIGURE* = EMRABORTPATH
  PEMRCLOSEFIGURE* = ptr EMRABORTPATH
  EMRFLATTENPATH* = EMRABORTPATH
  PEMRFLATTENPATH* = ptr EMRABORTPATH
  EMRWIDENPATH* = EMRABORTPATH
  PEMRWIDENPATH* = ptr EMRABORTPATH
  EMRSETMETARGN* = EMRABORTPATH
  PEMRSETMETARGN* = ptr EMRABORTPATH
  EMRSAVEDC* = EMRABORTPATH
  PEMRSAVEDC* = ptr EMRABORTPATH
  EMRREALIZEPALETTE* = EMRABORTPATH
  PEMRREALIZEPALETTE* = ptr EMRABORTPATH
  EMRSELECTCLIPPATH* {.pure.} = object
    emr*: EMR
    iMode*: DWORD
  PEMRSELECTCLIPPATH* = ptr EMRSELECTCLIPPATH
  EMRSETBKMODE* = EMRSELECTCLIPPATH
  PEMRSETBKMODE* = ptr EMRSELECTCLIPPATH
  EMRSETMAPMODE* = EMRSELECTCLIPPATH
  PEMRSETMAPMODE* = ptr EMRSELECTCLIPPATH
  EMRSETLAYOUT* = EMRSELECTCLIPPATH
  PEMRSETLAYOUT* = ptr EMRSELECTCLIPPATH
  EMRSETPOLYFILLMODE* = EMRSELECTCLIPPATH
  PEMRSETPOLYFILLMODE* = ptr EMRSELECTCLIPPATH
  EMRSETROP2* = EMRSELECTCLIPPATH
  PEMRSETROP2* = ptr EMRSELECTCLIPPATH
  EMRSETSTRETCHBLTMODE* = EMRSELECTCLIPPATH
  PEMRSETSTRETCHBLTMODE* = ptr EMRSELECTCLIPPATH
  EMRSETICMMODE* = EMRSELECTCLIPPATH
  PEMRSETICMMODE* = ptr EMRSELECTCLIPPATH
  EMRSETTEXTALIGN* = EMRSELECTCLIPPATH
  PEMRSETTEXTALIGN* = ptr EMRSELECTCLIPPATH
  EMRSETMITERLIMIT* {.pure.} = object
    emr*: EMR
    eMiterLimit*: FLOAT
  PEMRSETMITERLIMIT* = ptr EMRSETMITERLIMIT
  EMRRESTOREDC* {.pure.} = object
    emr*: EMR
    iRelative*: LONG
  PEMRRESTOREDC* = ptr EMRRESTOREDC
  EMRSETARCDIRECTION* {.pure.} = object
    emr*: EMR
    iArcDirection*: DWORD
  PEMRSETARCDIRECTION* = ptr EMRSETARCDIRECTION
  EMRSETMAPPERFLAGS* {.pure.} = object
    emr*: EMR
    dwFlags*: DWORD
  PEMRSETMAPPERFLAGS* = ptr EMRSETMAPPERFLAGS
  EMRSETBKCOLOR* {.pure.} = object
    emr*: EMR
    crColor*: COLORREF
  PEMRSETBKCOLOR* = ptr EMRSETBKCOLOR
  EMRSETTEXTCOLOR* = EMRSETBKCOLOR
  PEMRSETTEXTCOLOR* = ptr EMRSETBKCOLOR
  EMRSELECTOBJECT* {.pure.} = object
    emr*: EMR
    ihObject*: DWORD
  PEMRSELECTOBJECT* = ptr EMRSELECTOBJECT
  EMRDELETEOBJECT* = EMRSELECTOBJECT
  PEMRDELETEOBJECT* = ptr EMRSELECTOBJECT
  EMRSELECTPALETTE* {.pure.} = object
    emr*: EMR
    ihPal*: DWORD
  PEMRSELECTPALETTE* = ptr EMRSELECTPALETTE
  EMRRESIZEPALETTE* {.pure.} = object
    emr*: EMR
    ihPal*: DWORD
    cEntries*: DWORD
  PEMRRESIZEPALETTE* = ptr EMRRESIZEPALETTE
  EMRSETPALETTEENTRIES* {.pure.} = object
    emr*: EMR
    ihPal*: DWORD
    iStart*: DWORD
    cEntries*: DWORD
    aPalEntries*: array[1, PALETTEENTRY]
  PEMRSETPALETTEENTRIES* = ptr EMRSETPALETTEENTRIES
  EMRSETCOLORADJUSTMENT* {.pure.} = object
    emr*: EMR
    ColorAdjustment*: COLORADJUSTMENT
  PEMRSETCOLORADJUSTMENT* = ptr EMRSETCOLORADJUSTMENT
  EMRGDICOMMENT* {.pure.} = object
    emr*: EMR
    cbData*: DWORD
    Data*: array[1, BYTE]
  PEMRGDICOMMENT* = ptr EMRGDICOMMENT
  EMREOF* {.pure.} = object
    emr*: EMR
    nPalEntries*: DWORD
    offPalEntries*: DWORD
    nSizeLast*: DWORD
  PEMREOF* = ptr EMREOF
  EMRLINETO* {.pure.} = object
    emr*: EMR
    ptl*: POINTL
  PEMRLINETO* = ptr EMRLINETO
  EMRMOVETOEX* = EMRLINETO
  PEMRMOVETOEX* = ptr EMRLINETO
  EMROFFSETCLIPRGN* {.pure.} = object
    emr*: EMR
    ptlOffset*: POINTL
  PEMROFFSETCLIPRGN* = ptr EMROFFSETCLIPRGN
  EMRFILLPATH* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
  PEMRFILLPATH* = ptr EMRFILLPATH
  EMRSTROKEANDFILLPATH* = EMRFILLPATH
  PEMRSTROKEANDFILLPATH* = ptr EMRFILLPATH
  EMRSTROKEPATH* = EMRFILLPATH
  PEMRSTROKEPATH* = ptr EMRFILLPATH
  EMREXCLUDECLIPRECT* {.pure.} = object
    emr*: EMR
    rclClip*: RECTL
  PEMREXCLUDECLIPRECT* = ptr EMREXCLUDECLIPRECT
  EMRINTERSECTCLIPRECT* = EMREXCLUDECLIPRECT
  PEMRINTERSECTCLIPRECT* = ptr EMREXCLUDECLIPRECT
  EMRSETVIEWPORTORGEX* {.pure.} = object
    emr*: EMR
    ptlOrigin*: POINTL
  PEMRSETVIEWPORTORGEX* = ptr EMRSETVIEWPORTORGEX
  EMRSETWINDOWORGEX* = EMRSETVIEWPORTORGEX
  PEMRSETWINDOWORGEX* = ptr EMRSETVIEWPORTORGEX
  EMRSETBRUSHORGEX* = EMRSETVIEWPORTORGEX
  PEMRSETBRUSHORGEX* = ptr EMRSETVIEWPORTORGEX
  EMRSETVIEWPORTEXTEX* {.pure.} = object
    emr*: EMR
    szlExtent*: SIZEL
  PEMRSETVIEWPORTEXTEX* = ptr EMRSETVIEWPORTEXTEX
  EMRSETWINDOWEXTEX* = EMRSETVIEWPORTEXTEX
  PEMRSETWINDOWEXTEX* = ptr EMRSETVIEWPORTEXTEX
  EMRSCALEVIEWPORTEXTEX* {.pure.} = object
    emr*: EMR
    xNum*: LONG
    xDenom*: LONG
    yNum*: LONG
    yDenom*: LONG
  PEMRSCALEVIEWPORTEXTEX* = ptr EMRSCALEVIEWPORTEXTEX
  EMRSCALEWINDOWEXTEX* = EMRSCALEVIEWPORTEXTEX
  PEMRSCALEWINDOWEXTEX* = ptr EMRSCALEVIEWPORTEXTEX
  EMRSETWORLDTRANSFORM* {.pure.} = object
    emr*: EMR
    xform*: XFORM
  PEMRSETWORLDTRANSFORM* = ptr EMRSETWORLDTRANSFORM
  EMRMODIFYWORLDTRANSFORM* {.pure.} = object
    emr*: EMR
    xform*: XFORM
    iMode*: DWORD
  PEMRMODIFYWORLDTRANSFORM* = ptr EMRMODIFYWORLDTRANSFORM
  EMRSETPIXELV* {.pure.} = object
    emr*: EMR
    ptlPixel*: POINTL
    crColor*: COLORREF
  PEMRSETPIXELV* = ptr EMRSETPIXELV
  EMREXTFLOODFILL* {.pure.} = object
    emr*: EMR
    ptlStart*: POINTL
    crColor*: COLORREF
    iMode*: DWORD
  PEMREXTFLOODFILL* = ptr EMREXTFLOODFILL
  EMRELLIPSE* {.pure.} = object
    emr*: EMR
    rclBox*: RECTL
  PEMRELLIPSE* = ptr EMRELLIPSE
  EMRRECTANGLE* = EMRELLIPSE
  PEMRRECTANGLE* = ptr EMRELLIPSE
  EMRROUNDRECT* {.pure.} = object
    emr*: EMR
    rclBox*: RECTL
    szlCorner*: SIZEL
  PEMRROUNDRECT* = ptr EMRROUNDRECT
  EMRARC* {.pure.} = object
    emr*: EMR
    rclBox*: RECTL
    ptlStart*: POINTL
    ptlEnd*: POINTL
  PEMRARC* = ptr EMRARC
  EMRARCTO* = EMRARC
  PEMRARCTO* = ptr EMRARC
  EMRCHORD* = EMRARC
  PEMRCHORD* = ptr EMRARC
  EMRPIE* = EMRARC
  PEMRPIE* = ptr EMRARC
  EMRANGLEARC* {.pure.} = object
    emr*: EMR
    ptlCenter*: POINTL
    nRadius*: DWORD
    eStartAngle*: FLOAT
    eSweepAngle*: FLOAT
  PEMRANGLEARC* = ptr EMRANGLEARC
  EMRPOLYLINE* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    cptl*: DWORD
    aptl*: array[1, POINTL]
  PEMRPOLYLINE* = ptr EMRPOLYLINE
  EMRPOLYBEZIER* = EMRPOLYLINE
  PEMRPOLYBEZIER* = ptr EMRPOLYLINE
  EMRPOLYGON* = EMRPOLYLINE
  PEMRPOLYGON* = ptr EMRPOLYLINE
  EMRPOLYBEZIERTO* = EMRPOLYLINE
  PEMRPOLYBEZIERTO* = ptr EMRPOLYLINE
  EMRPOLYLINETO* = EMRPOLYLINE
  PEMRPOLYLINETO* = ptr EMRPOLYLINE
  EMRPOLYLINE16* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    cpts*: DWORD
    apts*: array[1, POINTS]
  PEMRPOLYLINE16* = ptr EMRPOLYLINE16
  EMRPOLYBEZIER16* = EMRPOLYLINE16
  PEMRPOLYBEZIER16* = ptr EMRPOLYLINE16
  EMRPOLYGON16* = EMRPOLYLINE16
  PEMRPOLYGON16* = ptr EMRPOLYLINE16
  EMRPOLYBEZIERTO16* = EMRPOLYLINE16
  PEMRPOLYBEZIERTO16* = ptr EMRPOLYLINE16
  EMRPOLYLINETO16* = EMRPOLYLINE16
  PEMRPOLYLINETO16* = ptr EMRPOLYLINE16
  EMRPOLYDRAW* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    cptl*: DWORD
    aptl*: array[1, POINTL]
    abTypes*: array[1, BYTE]
  PEMRPOLYDRAW* = ptr EMRPOLYDRAW
  EMRPOLYDRAW16* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    cpts*: DWORD
    apts*: array[1, POINTS]
    abTypes*: array[1, BYTE]
  PEMRPOLYDRAW16* = ptr EMRPOLYDRAW16
  EMRPOLYPOLYLINE* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    nPolys*: DWORD
    cptl*: DWORD
    aPolyCounts*: array[1, DWORD]
    aptl*: array[1, POINTL]
  PEMRPOLYPOLYLINE* = ptr EMRPOLYPOLYLINE
  EMRPOLYPOLYGON* = EMRPOLYPOLYLINE
  PEMRPOLYPOLYGON* = ptr EMRPOLYPOLYLINE
  EMRPOLYPOLYLINE16* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    nPolys*: DWORD
    cpts*: DWORD
    aPolyCounts*: array[1, DWORD]
    apts*: array[1, POINTS]
  PEMRPOLYPOLYLINE16* = ptr EMRPOLYPOLYLINE16
  EMRPOLYPOLYGON16* = EMRPOLYPOLYLINE16
  PEMRPOLYPOLYGON16* = ptr EMRPOLYPOLYLINE16
  EMRINVERTRGN* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    cbRgnData*: DWORD
    RgnData*: array[1, BYTE]
  PEMRINVERTRGN* = ptr EMRINVERTRGN
  EMRPAINTRGN* = EMRINVERTRGN
  PEMRPAINTRGN* = ptr EMRINVERTRGN
  EMRFILLRGN* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    cbRgnData*: DWORD
    ihBrush*: DWORD
    RgnData*: array[1, BYTE]
  PEMRFILLRGN* = ptr EMRFILLRGN
  EMRFRAMERGN* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    cbRgnData*: DWORD
    ihBrush*: DWORD
    szlStroke*: SIZEL
    RgnData*: array[1, BYTE]
  PEMRFRAMERGN* = ptr EMRFRAMERGN
  EMREXTSELECTCLIPRGN* {.pure.} = object
    emr*: EMR
    cbRgnData*: DWORD
    iMode*: DWORD
    RgnData*: array[1, BYTE]
  PEMREXTSELECTCLIPRGN* = ptr EMREXTSELECTCLIPRGN
  EMREXTTEXTOUTA* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    iGraphicsMode*: DWORD
    exScale*: FLOAT
    eyScale*: FLOAT
    emrtext*: EMRTEXT
  PEMREXTTEXTOUTA* = ptr EMREXTTEXTOUTA
  EMREXTTEXTOUTW* = EMREXTTEXTOUTA
  PEMREXTTEXTOUTW* = ptr EMREXTTEXTOUTA
  EMRPOLYTEXTOUTA* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    iGraphicsMode*: DWORD
    exScale*: FLOAT
    eyScale*: FLOAT
    cStrings*: LONG
    aemrtext*: array[1, EMRTEXT]
  PEMRPOLYTEXTOUTA* = ptr EMRPOLYTEXTOUTA
  EMRPOLYTEXTOUTW* = EMRPOLYTEXTOUTA
  PEMRPOLYTEXTOUTW* = ptr EMRPOLYTEXTOUTA
  EMRBITBLT* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    xDest*: LONG
    yDest*: LONG
    cxDest*: LONG
    cyDest*: LONG
    dwRop*: DWORD
    xSrc*: LONG
    ySrc*: LONG
    xformSrc*: XFORM
    crBkColorSrc*: COLORREF
    iUsageSrc*: DWORD
    offBmiSrc*: DWORD
    cbBmiSrc*: DWORD
    offBitsSrc*: DWORD
    cbBitsSrc*: DWORD
  PEMRBITBLT* = ptr EMRBITBLT
  EMRSTRETCHBLT* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    xDest*: LONG
    yDest*: LONG
    cxDest*: LONG
    cyDest*: LONG
    dwRop*: DWORD
    xSrc*: LONG
    ySrc*: LONG
    xformSrc*: XFORM
    crBkColorSrc*: COLORREF
    iUsageSrc*: DWORD
    offBmiSrc*: DWORD
    cbBmiSrc*: DWORD
    offBitsSrc*: DWORD
    cbBitsSrc*: DWORD
    cxSrc*: LONG
    cySrc*: LONG
  PEMRSTRETCHBLT* = ptr EMRSTRETCHBLT
  EMRMASKBLT* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    xDest*: LONG
    yDest*: LONG
    cxDest*: LONG
    cyDest*: LONG
    dwRop*: DWORD
    xSrc*: LONG
    ySrc*: LONG
    xformSrc*: XFORM
    crBkColorSrc*: COLORREF
    iUsageSrc*: DWORD
    offBmiSrc*: DWORD
    cbBmiSrc*: DWORD
    offBitsSrc*: DWORD
    cbBitsSrc*: DWORD
    xMask*: LONG
    yMask*: LONG
    iUsageMask*: DWORD
    offBmiMask*: DWORD
    cbBmiMask*: DWORD
    offBitsMask*: DWORD
    cbBitsMask*: DWORD
  PEMRMASKBLT* = ptr EMRMASKBLT
  EMRPLGBLT* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    aptlDest*: array[3, POINTL]
    xSrc*: LONG
    ySrc*: LONG
    cxSrc*: LONG
    cySrc*: LONG
    xformSrc*: XFORM
    crBkColorSrc*: COLORREF
    iUsageSrc*: DWORD
    offBmiSrc*: DWORD
    cbBmiSrc*: DWORD
    offBitsSrc*: DWORD
    cbBitsSrc*: DWORD
    xMask*: LONG
    yMask*: LONG
    iUsageMask*: DWORD
    offBmiMask*: DWORD
    cbBmiMask*: DWORD
    offBitsMask*: DWORD
    cbBitsMask*: DWORD
  PEMRPLGBLT* = ptr EMRPLGBLT
  EMRSETDIBITSTODEVICE* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    xDest*: LONG
    yDest*: LONG
    xSrc*: LONG
    ySrc*: LONG
    cxSrc*: LONG
    cySrc*: LONG
    offBmiSrc*: DWORD
    cbBmiSrc*: DWORD
    offBitsSrc*: DWORD
    cbBitsSrc*: DWORD
    iUsageSrc*: DWORD
    iStartScan*: DWORD
    cScans*: DWORD
  PEMRSETDIBITSTODEVICE* = ptr EMRSETDIBITSTODEVICE
  EMRSTRETCHDIBITS* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    xDest*: LONG
    yDest*: LONG
    xSrc*: LONG
    ySrc*: LONG
    cxSrc*: LONG
    cySrc*: LONG
    offBmiSrc*: DWORD
    cbBmiSrc*: DWORD
    offBitsSrc*: DWORD
    cbBitsSrc*: DWORD
    iUsageSrc*: DWORD
    dwRop*: DWORD
    cxDest*: LONG
    cyDest*: LONG
  PEMRSTRETCHDIBITS* = ptr EMRSTRETCHDIBITS
  EMREXTCREATEFONTINDIRECTW* {.pure.} = object
    emr*: EMR
    ihFont*: DWORD
    elfw*: EXTLOGFONTW
  PEMREXTCREATEFONTINDIRECTW* = ptr EMREXTCREATEFONTINDIRECTW
  EMRCREATEPALETTE* {.pure.} = object
    emr*: EMR
    ihPal*: DWORD
    lgpl*: LOGPALETTE
  PEMRCREATEPALETTE* = ptr EMRCREATEPALETTE
  EMRCREATEPEN* {.pure.} = object
    emr*: EMR
    ihPen*: DWORD
    lopn*: LOGPEN
  PEMRCREATEPEN* = ptr EMRCREATEPEN
  EMREXTCREATEPEN* {.pure.} = object
    emr*: EMR
    ihPen*: DWORD
    offBmi*: DWORD
    cbBmi*: DWORD
    offBits*: DWORD
    cbBits*: DWORD
    elp*: EXTLOGPEN
  PEMREXTCREATEPEN* = ptr EMREXTCREATEPEN
  EMRCREATEBRUSHINDIRECT* {.pure.} = object
    emr*: EMR
    ihBrush*: DWORD
    lb*: LOGBRUSH32
  PEMRCREATEBRUSHINDIRECT* = ptr EMRCREATEBRUSHINDIRECT
  EMRCREATEMONOBRUSH* {.pure.} = object
    emr*: EMR
    ihBrush*: DWORD
    iUsage*: DWORD
    offBmi*: DWORD
    cbBmi*: DWORD
    offBits*: DWORD
    cbBits*: DWORD
  PEMRCREATEMONOBRUSH* = ptr EMRCREATEMONOBRUSH
  EMRCREATEDIBPATTERNBRUSHPT* {.pure.} = object
    emr*: EMR
    ihBrush*: DWORD
    iUsage*: DWORD
    offBmi*: DWORD
    cbBmi*: DWORD
    offBits*: DWORD
    cbBits*: DWORD
  PEMRCREATEDIBPATTERNBRUSHPT* = ptr EMRCREATEDIBPATTERNBRUSHPT
  EMRFORMAT* {.pure.} = object
    dSignature*: DWORD
    nVersion*: DWORD
    cbData*: DWORD
    offData*: DWORD
  PEMRFORMAT* = ptr EMRFORMAT
  EMRGLSRECORD* {.pure.} = object
    emr*: EMR
    cbData*: DWORD
    Data*: array[1, BYTE]
  PEMRGLSRECORD* = ptr EMRGLSRECORD
  EMRGLSBOUNDEDRECORD* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    cbData*: DWORD
    Data*: array[1, BYTE]
  PEMRGLSBOUNDEDRECORD* = ptr EMRGLSBOUNDEDRECORD
  EMRPIXELFORMAT* {.pure.} = object
    emr*: EMR
    pfd*: PIXELFORMATDESCRIPTOR
  PEMRPIXELFORMAT* = ptr EMRPIXELFORMAT
  EMRCREATECOLORSPACE* {.pure.} = object
    emr*: EMR
    ihCS*: DWORD
    lcs*: LOGCOLORSPACEA
  PEMRCREATECOLORSPACE* = ptr EMRCREATECOLORSPACE
  EMRSETCOLORSPACE* {.pure.} = object
    emr*: EMR
    ihCS*: DWORD
  PEMRSETCOLORSPACE* = ptr EMRSETCOLORSPACE
  EMRSELECTCOLORSPACE* = EMRSETCOLORSPACE
  PEMRSELECTCOLORSPACE* = ptr EMRSETCOLORSPACE
  EMRDELETECOLORSPACE* = EMRSETCOLORSPACE
  PEMRDELETECOLORSPACE* = ptr EMRSETCOLORSPACE
  EMREXTESCAPE* {.pure.} = object
    emr*: EMR
    iEscape*: INT
    cbEscData*: INT
    EscData*: array[1, BYTE]
  PEMREXTESCAPE* = ptr EMREXTESCAPE
  EMRDRAWESCAPE* = EMREXTESCAPE
  PEMRDRAWESCAPE* = ptr EMREXTESCAPE
  EMRNAMEDESCAPE* {.pure.} = object
    emr*: EMR
    iEscape*: INT
    cbDriver*: INT
    cbEscData*: INT
    EscData*: array[1, BYTE]
  PEMRNAMEDESCAPE* = ptr EMRNAMEDESCAPE
  EMRSETICMPROFILE* {.pure.} = object
    emr*: EMR
    dwFlags*: DWORD
    cbName*: DWORD
    cbData*: DWORD
    Data*: array[1, BYTE]
  PEMRSETICMPROFILE* = ptr EMRSETICMPROFILE
  EMRSETICMPROFILEA* = EMRSETICMPROFILE
  PEMRSETICMPROFILEA* = ptr EMRSETICMPROFILE
  EMRSETICMPROFILEW* = EMRSETICMPROFILE
  PEMRSETICMPROFILEW* = ptr EMRSETICMPROFILE
  EMRCREATECOLORSPACEW* {.pure.} = object
    emr*: EMR
    ihCS*: DWORD
    lcs*: LOGCOLORSPACEW
    dwFlags*: DWORD
    cbData*: DWORD
    Data*: array[1, BYTE]
  PEMRCREATECOLORSPACEW* = ptr EMRCREATECOLORSPACEW
  EMRCOLORMATCHTOTARGET* {.pure.} = object
    emr*: EMR
    dwAction*: DWORD
    dwFlags*: DWORD
    cbName*: DWORD
    cbData*: DWORD
    Data*: array[1, BYTE]
  PEMRCOLORMATCHTOTARGET* = ptr EMRCOLORMATCHTOTARGET
  EMRCOLORCORRECTPALETTE* {.pure.} = object
    emr*: EMR
    ihPalette*: DWORD
    nFirstEntry*: DWORD
    nPalEntries*: DWORD
    nReserved*: DWORD
  PEMRCOLORCORRECTPALETTE* = ptr EMRCOLORCORRECTPALETTE
  EMRALPHABLEND* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    xDest*: LONG
    yDest*: LONG
    cxDest*: LONG
    cyDest*: LONG
    dwRop*: DWORD
    xSrc*: LONG
    ySrc*: LONG
    xformSrc*: XFORM
    crBkColorSrc*: COLORREF
    iUsageSrc*: DWORD
    offBmiSrc*: DWORD
    cbBmiSrc*: DWORD
    offBitsSrc*: DWORD
    cbBitsSrc*: DWORD
    cxSrc*: LONG
    cySrc*: LONG
  PEMRALPHABLEND* = ptr EMRALPHABLEND
  EMRGRADIENTFILL* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    nVer*: DWORD
    nTri*: DWORD
    ulMode*: ULONG
    Ver*: array[1, TRIVERTEX]
  PEMRGRADIENTFILL* = ptr EMRGRADIENTFILL
  EMRTRANSPARENTBLT* {.pure.} = object
    emr*: EMR
    rclBounds*: RECTL
    xDest*: LONG
    yDest*: LONG
    cxDest*: LONG
    cyDest*: LONG
    dwRop*: DWORD
    xSrc*: LONG
    ySrc*: LONG
    xformSrc*: XFORM
    crBkColorSrc*: COLORREF
    iUsageSrc*: DWORD
    offBmiSrc*: DWORD
    cbBmiSrc*: DWORD
    offBitsSrc*: DWORD
    cbBitsSrc*: DWORD
    cxSrc*: LONG
    cySrc*: LONG
  PEMRTRANSPARENTBLT* = ptr EMRTRANSPARENTBLT
  POINTFLOAT* {.pure.} = object
    x*: FLOAT
    y*: FLOAT
  PPOINTFLOAT* = ptr POINTFLOAT
  GLYPHMETRICSFLOAT* {.pure.} = object
    gmfBlackBoxX*: FLOAT
    gmfBlackBoxY*: FLOAT
    gmfptGlyphOrigin*: POINTFLOAT
    gmfCellIncX*: FLOAT
    gmfCellIncY*: FLOAT
  PGLYPHMETRICSFLOAT* = ptr GLYPHMETRICSFLOAT
  LPGLYPHMETRICSFLOAT* = ptr GLYPHMETRICSFLOAT
  LAYERPLANEDESCRIPTOR* {.pure.} = object
    nSize*: WORD
    nVersion*: WORD
    dwFlags*: DWORD
    iPixelType*: BYTE
    cColorBits*: BYTE
    cRedBits*: BYTE
    cRedShift*: BYTE
    cGreenBits*: BYTE
    cGreenShift*: BYTE
    cBlueBits*: BYTE
    cBlueShift*: BYTE
    cAlphaBits*: BYTE
    cAlphaShift*: BYTE
    cAccumBits*: BYTE
    cAccumRedBits*: BYTE
    cAccumGreenBits*: BYTE
    cAccumBlueBits*: BYTE
    cAccumAlphaBits*: BYTE
    cDepthBits*: BYTE
    cStencilBits*: BYTE
    cAuxBuffers*: BYTE
    iLayerPlane*: BYTE
    bReserved*: BYTE
    crTransparent*: COLORREF
  PLAYERPLANEDESCRIPTOR* = ptr LAYERPLANEDESCRIPTOR
  LPLAYERPLANEDESCRIPTOR* = ptr LAYERPLANEDESCRIPTOR
  WGLSWAP* {.pure.} = object
    hdc*: HDC
    uiFlags*: UINT
  PWGLSWAP* = ptr WGLSWAP
  LPWGLSWAP* = ptr WGLSWAP
const
  R2_BLACK* = 1
  R2_NOTMERGEPEN* = 2
  R2_MASKNOTPEN* = 3
  R2_NOTCOPYPEN* = 4
  R2_MASKPENNOT* = 5
  R2_NOT* = 6
  R2_XORPEN* = 7
  R2_NOTMASKPEN* = 8
  R2_MASKPEN* = 9
  R2_NOTXORPEN* = 10
  R2_NOP* = 11
  R2_MERGENOTPEN* = 12
  R2_COPYPEN* = 13
  R2_MERGEPENNOT* = 14
  R2_MERGEPEN* = 15
  R2_WHITE* = 16
  R2_LAST* = 16
  SRCCOPY* = DWORD 0x00CC0020
  SRCPAINT* = DWORD 0x00EE0086
  SRCAND* = DWORD 0x008800C6
  SRCINVERT* = DWORD 0x00660046
  SRCERASE* = DWORD 0x00440328
  NOTSRCCOPY* = DWORD 0x00330008
  NOTSRCERASE* = DWORD 0x001100A6
  MERGECOPY* = DWORD 0x00C000CA
  MERGEPAINT* = DWORD 0x00BB0226
  PATCOPY* = DWORD 0x00F00021
  PATPAINT* = DWORD 0x00FB0A09
  PATINVERT* = DWORD 0x005A0049
  DSTINVERT* = DWORD 0x00550009
  BLACKNESS* = DWORD 0x00000042
  WHITENESS* = DWORD 0x00FF0062
  NOMIRRORBITMAP* = DWORD 0x80000000'i32
  CAPTUREBLT* = DWORD 0x40000000
  GDI_ERROR* = 0xFFFFFFFF'i32
  HGDI_ERROR* = HANDLE 0xFFFFFFFF'i32
  ERROR* = 0
  NULLREGION* = 1
  SIMPLEREGION* = 2
  COMPLEXREGION* = 3
  RGN_ERROR* = ERROR
  RGN_AND* = 1
  RGN_OR* = 2
  RGN_XOR* = 3
  RGN_DIFF* = 4
  RGN_COPY* = 5
  RGN_MIN* = RGN_AND
  RGN_MAX* = RGN_COPY
  BLACKONWHITE* = 1
  WHITEONBLACK* = 2
  COLORONCOLOR* = 3
  HALFTONE* = 4
  MAXSTRETCHBLTMODE* = 4
  STRETCH_ANDSCANS* = BLACKONWHITE
  STRETCH_ORSCANS* = WHITEONBLACK
  STRETCH_DELETESCANS* = COLORONCOLOR
  STRETCH_HALFTONE* = HALFTONE
  ALTERNATE* = 1
  WINDING* = 2
  POLYFILL_LAST* = 2
  LAYOUT_RTL* = 0x00000001
  LAYOUT_BTT* = 0x00000002
  LAYOUT_VBH* = 0x00000004
  LAYOUT_ORIENTATIONMASK* = LAYOUT_RTL or LAYOUT_BTT or LAYOUT_VBH
  LAYOUT_BITMAPORIENTATIONPRESERVED* = 0x00000008
  TA_NOUPDATECP* = 0
  TA_UPDATECP* = 1
  TA_LEFT* = 0
  TA_RIGHT* = 2
  TA_CENTER* = 6
  TA_TOP* = 0
  TA_BOTTOM* = 8
  TA_BASELINE* = 24
  TA_RTLREADING* = 256
  TA_MASK* = TA_BASELINE+TA_CENTER+TA_UPDATECP+TA_RTLREADING
  VTA_BASELINE* = TA_BASELINE
  VTA_LEFT* = TA_BOTTOM
  VTA_RIGHT* = TA_TOP
  VTA_CENTER* = TA_CENTER
  VTA_BOTTOM* = TA_RIGHT
  VTA_TOP* = TA_LEFT
  ETO_OPAQUE* = 0x0002
  ETO_CLIPPED* = 0x0004
  ETO_GLYPH_INDEX* = 0x0010
  ETO_RTLREADING* = 0x0080
  ETO_NUMERICSLOCAL* = 0x0400
  ETO_NUMERICSLATIN* = 0x0800
  ETO_IGNORELANGUAGE* = 0x1000
  ETO_PDY* = 0x2000
  ETO_REVERSE_INDEX_MAP* = 0x10000
  ASPECT_FILTERING* = 0x0001
  DCB_RESET* = 0x0001
  DCB_ACCUMULATE* = 0x0002
  DCB_DIRTY* = DCB_ACCUMULATE
  DCB_SET* = DCB_RESET or DCB_ACCUMULATE
  DCB_ENABLE* = 0x0004
  DCB_DISABLE* = 0x0008
  META_SETBKCOLOR* = 0x0201
  META_SETBKMODE* = 0x0102
  META_SETMAPMODE* = 0x0103
  META_SETROP2* = 0x0104
  META_SETRELABS* = 0x0105
  META_SETPOLYFILLMODE* = 0x0106
  META_SETSTRETCHBLTMODE* = 0x0107
  META_SETTEXTCHAREXTRA* = 0x0108
  META_SETTEXTCOLOR* = 0x0209
  META_SETTEXTJUSTIFICATION* = 0x020A
  META_SETWINDOWORG* = 0x020B
  META_SETWINDOWEXT* = 0x020C
  META_SETVIEWPORTORG* = 0x020D
  META_SETVIEWPORTEXT* = 0x020E
  META_OFFSETWINDOWORG* = 0x020F
  META_SCALEWINDOWEXT* = 0x0410
  META_OFFSETVIEWPORTORG* = 0x0211
  META_SCALEVIEWPORTEXT* = 0x0412
  META_LINETO* = 0x0213
  META_MOVETO* = 0x0214
  META_EXCLUDECLIPRECT* = 0x0415
  META_INTERSECTCLIPRECT* = 0x0416
  META_ARC* = 0x0817
  META_ELLIPSE* = 0x0418
  META_FLOODFILL* = 0x0419
  META_PIE* = 0x081A
  META_RECTANGLE* = 0x041B
  META_ROUNDRECT* = 0x061C
  META_PATBLT* = 0x061D
  META_SAVEDC* = 0x001E
  META_SETPIXEL* = 0x041F
  META_OFFSETCLIPRGN* = 0x0220
  META_TEXTOUT* = 0x0521
  META_BITBLT* = 0x0922
  META_STRETCHBLT* = 0x0B23
  META_POLYGON* = 0x0324
  META_POLYLINE* = 0x0325
  META_ESCAPE* = 0x0626
  META_RESTOREDC* = 0x0127
  META_FILLREGION* = 0x0228
  META_FRAMEREGION* = 0x0429
  META_INVERTREGION* = 0x012A
  META_PAINTREGION* = 0x012B
  META_SELECTCLIPREGION* = 0x012C
  META_SELECTOBJECT* = 0x012D
  META_SETTEXTALIGN* = 0x012E
  META_CHORD* = 0x0830
  META_SETMAPPERFLAGS* = 0x0231
  META_EXTTEXTOUT* = 0x0a32
  META_SETDIBTODEV* = 0x0d33
  META_SELECTPALETTE* = 0x0234
  META_REALIZEPALETTE* = 0x0035
  META_ANIMATEPALETTE* = 0x0436
  META_SETPALENTRIES* = 0x0037
  META_POLYPOLYGON* = 0x0538
  META_RESIZEPALETTE* = 0x0139
  META_DIBBITBLT* = 0x0940
  META_DIBSTRETCHBLT* = 0x0b41
  META_DIBCREATEPATTERNBRUSH* = 0x0142
  META_STRETCHDIB* = 0x0f43
  META_EXTFLOODFILL* = 0x0548
  META_SETLAYOUT* = 0x0149
  META_DELETEOBJECT* = 0x01f0
  META_CREATEPALETTE* = 0x00f7
  META_CREATEPATTERNBRUSH* = 0x01F9
  META_CREATEPENINDIRECT* = 0x02FA
  META_CREATEFONTINDIRECT* = 0x02FB
  META_CREATEBRUSHINDIRECT* = 0x02FC
  META_CREATEREGION* = 0x06FF
  NEWFRAME* = 1
  abortDoc* = 2
  NEXTBAND* = 3
  SETCOLORTABLE* = 4
  GETCOLORTABLE* = 5
  FLUSHOUTPUT* = 6
  DRAFTMODE* = 7
  QUERYESCSUPPORT* = 8
  setAbortProc* = 9
  startDoc* = 10
  endDoc* = 11
  GETPHYSPAGESIZE* = 12
  GETPRINTINGOFFSET* = 13
  GETSCALINGFACTOR* = 14
  MFCOMMENT* = 15
  GETPENWIDTH* = 16
  SETCOPYCOUNT* = 17
  SELECTPAPERSOURCE* = 18
  DEVICEDATA* = 19
  PASSTHROUGH* = 19
  GETTECHNOLGY* = 20
  GETTECHNOLOGY* = 20
  SETLINECAP* = 21
  SETLINEJOIN* = 22
  setMiterLimit* = 23
  BANDINFO* = 24
  DRAWPATTERNRECT* = 25
  GETVECTORPENSIZE* = 26
  GETVECTORBRUSHSIZE* = 27
  ENABLEDUPLEX* = 28
  GETSETPAPERBINS* = 29
  GETSETPRINTORIENT* = 30
  ENUMPAPERBINS* = 31
  SETDIBSCALING* = 32
  EPSPRINTING* = 33
  ENUMPAPERMETRICS* = 34
  GETSETPAPERMETRICS* = 35
  POSTSCRIPT_DATA* = 37
  POSTSCRIPT_IGNORE* = 38
  MOUSETRAILS* = 39
  GETDEVICEUNITS* = 42
  GETEXTENDEDTEXTMETRICS* = 256
  GETEXTENTTABLE* = 257
  GETPAIRKERNTABLE* = 258
  GETTRACKKERNTABLE* = 259
  extTextout* = 512
  GETFACENAME* = 513
  DOWNLOADFACE* = 514
  ENABLERELATIVEWIDTHS* = 768
  ENABLEPAIRKERNING* = 769
  SETKERNTRACK* = 770
  SETALLJUSTVALUES* = 771
  SETCHARSET* = 772
  stretchBlt* = 2048
  METAFILE_DRIVER* = 2049
  GETSETSCREENPARAMS* = 3072
  QUERYDIBSUPPORT* = 3073
  beginPath* = 4096
  CLIP_TO_PATH* = 4097
  endPath* = 4098
  EXT_DEVICE_CAPS* = 4099
  RESTORE_CTM* = 4100
  SAVE_CTM* = 4101
  setArcDirection* = 4102
  SET_BACKGROUND_COLOR* = 4103
  SET_POLY_MODE* = 4104
  SET_SCREEN_ANGLE* = 4105
  SET_SPREAD* = 4106
  TRANSFORM_CTM* = 4107
  SET_CLIP_BOX* = 4108
  SET_BOUNDS* = 4109
  SET_MIRROR_MODE* = 4110
  OPENCHANNEL* = 4110
  DOWNLOADHEADER* = 4111
  CLOSECHANNEL* = 4112
  POSTSCRIPT_PASSTHROUGH* = 4115
  ENCAPSULATED_POSTSCRIPT* = 4116
  POSTSCRIPT_IDENTIFY* = 4117
  POSTSCRIPT_INJECTION* = 4118
  CHECKJPEGFORMAT* = 4119
  CHECKPNGFORMAT* = 4120
  GET_PS_FEATURESETTING* = 4121
  GDIPLUS_TS_QUERYVER* = 4122
  GDIPLUS_TS_RECORD* = 4123
  MILCORE_TS_QUERYVER_RESULT_FALSE* = 0x0
  MILCORE_TS_QUERYVER_RESULT_TRUE* = 0x7FFFFFFF
  SPCLPASSTHROUGH2* = 4568
  PSIDENT_GDICENTRIC* = 0
  PSIDENT_PSCENTRIC* = 1
  PSINJECT_BEGINSTREAM* = 1
  PSINJECT_PSADOBE* = 2
  PSINJECT_PAGESATEND* = 3
  PSINJECT_PAGES* = 4
  PSINJECT_DOCNEEDEDRES* = 5
  PSINJECT_DOCSUPPLIEDRES* = 6
  PSINJECT_PAGEORDER* = 7
  PSINJECT_ORIENTATION* = 8
  PSINJECT_BOUNDINGBOX* = 9
  PSINJECT_DOCUMENTPROCESSCOLORS* = 10
  PSINJECT_COMMENTS* = 11
  PSINJECT_BEGINDEFAULTS* = 12
  PSINJECT_ENDDEFAULTS* = 13
  PSINJECT_BEGINPROLOG* = 14
  PSINJECT_ENDPROLOG* = 15
  PSINJECT_BEGINSETUP* = 16
  PSINJECT_ENDSETUP* = 17
  PSINJECT_TRAILER* = 18
  PSINJECT_EOF* = 19
  PSINJECT_ENDSTREAM* = 20
  PSINJECT_DOCUMENTPROCESSCOLORSATEND* = 21
  PSINJECT_PAGENUMBER* = 100
  PSINJECT_BEGINPAGESETUP* = 101
  PSINJECT_ENDPAGESETUP* = 102
  PSINJECT_PAGETRAILER* = 103
  PSINJECT_PLATECOLOR* = 104
  PSINJECT_SHOWPAGE* = 105
  PSINJECT_PAGEBBOX* = 106
  PSINJECT_ENDPAGECOMMENTS* = 107
  PSINJECT_VMSAVE* = 200
  PSINJECT_VMRESTORE* = 201
  FEATURESETTING_NUP* = 0
  FEATURESETTING_OUTPUT* = 1
  FEATURESETTING_PSLEVEL* = 2
  FEATURESETTING_CUSTPAPER* = 3
  FEATURESETTING_MIRROR* = 4
  FEATURESETTING_NEGATIVE* = 5
  FEATURESETTING_PROTOCOL* = 6
  FEATURESETTING_PRIVATE_BEGIN* = 0x1000
  FEATURESETTING_PRIVATE_END* = 0x1FFF
  PSPROTOCOL_ASCII* = 0
  PSPROTOCOL_BCP* = 1
  PSPROTOCOL_TBCP* = 2
  PSPROTOCOL_BINARY* = 3
  QDI_SETDIBITS* = 1
  QDI_GETDIBITS* = 2
  QDI_DIBTOSCREEN* = 4
  QDI_STRETCHDIB* = 8
  SP_NOTREPORTED* = 0x4000
  SP_ERROR* = -1
  SP_APPABORT* = -2
  SP_USERABORT* = -3
  SP_OUTOFDISK* = -4
  SP_OUTOFMEMORY* = -5
  PR_JOBSTATUS* = 0x0000
  OBJ_PEN* = 1
  OBJ_BRUSH* = 2
  OBJ_DC* = 3
  OBJ_METADC* = 4
  OBJ_PAL* = 5
  OBJ_FONT* = 6
  OBJ_BITMAP* = 7
  OBJ_REGION* = 8
  OBJ_METAFILE* = 9
  OBJ_MEMDC* = 10
  OBJ_EXTPEN* = 11
  OBJ_ENHMETADC* = 12
  OBJ_ENHMETAFILE* = 13
  OBJ_COLORSPACE* = 14
  GDI_OBJ_LAST* = OBJ_COLORSPACE
  MWT_IDENTITY* = 1
  MWT_LEFTMULTIPLY* = 2
  MWT_RIGHTMULTIPLY* = 3
  MWT_MIN* = MWT_IDENTITY
  MWT_MAX* = MWT_RIGHTMULTIPLY
  CS_ENABLE* = 0x00000001
  CS_DISABLE* = 0x00000002
  CS_DELETE_TRANSFORM* = 0x00000003
  LCS_SIGNATURE* = 0x50534F43
  LCS_sRGB* = 0x73524742
  LCS_WINDOWS_COLOR_SPACE* = 0x57696E20
  LCS_CALIBRATED_RGB* = 0x00000000
  LCS_GM_BUSINESS* = 0x00000001
  LCS_GM_GRAPHICS* = 0x00000002
  LCS_GM_IMAGES* = 0x00000004
  LCS_GM_ABS_COLORIMETRIC* = 0x00000008
  CM_OUT_OF_GAMUT* = 255
  CM_IN_GAMUT* = 0
  ICM_ADDPROFILE* = 1
  ICM_DELETEPROFILE* = 2
  ICM_QUERYPROFILE* = 3
  ICM_SETDEFAULTPROFILE* = 4
  ICM_REGISTERICMATCHER* = 5
  ICM_UNREGISTERICMATCHER* = 6
  ICM_QUERYMATCH* = 7
  PROFILE_LINKED* = 0x4C494E4B
  PROFILE_EMBEDDED* = 0x4D424544
  BI_RGB* = 0
  BI_RLE8* = 1
  BI_RLE4* = 2
  BI_BITFIELDS* = 3
  BI_JPEG* = 4
  BI_PNG* = 5
  TCI_SRCCHARSET* = 1
  TCI_SRCCODEPAGE* = 2
  TCI_SRCFONTSIG* = 3
  TCI_SRCLOCALE* = 0x1000
  TMPF_FIXED_PITCH* = 0x01
  TMPF_VECTOR* = 0x02
  TMPF_DEVICE* = 0x08
  TMPF_TRUETYPE* = 0x04
  NTM_REGULAR* = 0x00000040
  NTM_BOLD* = 0x00000020
  NTM_ITALIC* = 0x00000001
  NTM_NONNEGATIVE_AC* = 0x00010000
  NTM_PS_OPENTYPE* = 0x00020000
  NTM_TT_OPENTYPE* = 0x00040000
  NTM_MULTIPLEMASTER* = 0x00080000
  NTM_TYPE1* = 0x00100000
  NTM_DSIG* = 0x00200000
  OUT_DEFAULT_PRECIS* = 0
  OUT_STRING_PRECIS* = 1
  OUT_CHARACTER_PRECIS* = 2
  OUT_STROKE_PRECIS* = 3
  OUT_TT_PRECIS* = 4
  OUT_DEVICE_PRECIS* = 5
  OUT_RASTER_PRECIS* = 6
  OUT_TT_ONLY_PRECIS* = 7
  OUT_OUTLINE_PRECIS* = 8
  OUT_SCREEN_OUTLINE_PRECIS* = 9
  OUT_PS_ONLY_PRECIS* = 10
  CLIP_DEFAULT_PRECIS* = 0
  CLIP_CHARACTER_PRECIS* = 1
  CLIP_STROKE_PRECIS* = 2
  CLIP_MASK* = 0xf
  CLIP_LH_ANGLES* = 1 shl 4
  CLIP_TT_ALWAYS* = 2 shl 4
  CLIP_DFA_DISABLE* = 4 shl 4
  CLIP_EMBEDDED* = 8 shl 4
  DEFAULT_QUALITY* = 0
  DRAFT_QUALITY* = 1
  PROOF_QUALITY* = 2
  NONANTIALIASED_QUALITY* = 3
  ANTIALIASED_QUALITY* = 4
  CLEARTYPE_QUALITY* = 5
  CLEARTYPE_NATURAL_QUALITY* = 6
  DEFAULT_PITCH* = 0
  FIXED_PITCH* = 1
  VARIABLE_PITCH* = 2
  MONO_FONT* = 8
  ANSI_CHARSET* = 0
  DEFAULT_CHARSET* = 1
  SYMBOL_CHARSET* = 2
  SHIFTJIS_CHARSET* = 128
  HANGEUL_CHARSET* = 129
  HANGUL_CHARSET* = 129
  GB2312_CHARSET* = 134
  CHINESEBIG5_CHARSET* = 136
  OEM_CHARSET* = 255
  JOHAB_CHARSET* = 130
  HEBREW_CHARSET* = 177
  ARABIC_CHARSET* = 178
  GREEK_CHARSET* = 161
  TURKISH_CHARSET* = 162
  VIETNAMESE_CHARSET* = 163
  THAI_CHARSET* = 222
  EASTEUROPE_CHARSET* = 238
  RUSSIAN_CHARSET* = 204
  MAC_CHARSET* = 77
  BALTIC_CHARSET* = 186
  FS_LATIN1* = 0x00000001
  FS_LATIN2* = 0x00000002
  FS_CYRILLIC* = 0x00000004
  FS_GREEK* = 0x00000008
  FS_TURKISH* = 0x00000010
  FS_HEBREW* = 0x00000020
  FS_ARABIC* = 0x00000040
  FS_BALTIC* = 0x00000080
  FS_VIETNAMESE* = 0x00000100
  FS_THAI* = 0x00010000
  FS_JISJAPAN* = 0x00020000
  FS_CHINESESIMP* = 0x00040000
  FS_WANSUNG* = 0x00080000
  FS_CHINESETRAD* = 0x00100000
  FS_JOHAB* = 0x00200000
  FS_SYMBOL* = 0x80000000'i32
  FF_DONTCARE* = 0 shl 4
  FF_ROMAN* = 1 shl 4
  FF_SWISS* = 2 shl 4
  FF_MODERN* = 3 shl 4
  FF_SCRIPT* = 4 shl 4
  FF_DECORATIVE* = 5 shl 4
  FW_DONTCARE* = 0
  FW_THIN* = 100
  FW_EXTRALIGHT* = 200
  FW_LIGHT* = 300
  FW_NORMAL* = 400
  FW_MEDIUM* = 500
  FW_SEMIBOLD* = 600
  FW_BOLD* = 700
  FW_EXTRABOLD* = 800
  FW_HEAVY* = 900
  FW_ULTRALIGHT* = FW_EXTRALIGHT
  FW_REGULAR* = FW_NORMAL
  FW_DEMIBOLD* = FW_SEMIBOLD
  FW_ULTRABOLD* = FW_EXTRABOLD
  FW_BLACK* = FW_HEAVY
  PANOSE_COUNT* = 10
  PAN_FAMILYTYPE_INDEX* = 0
  PAN_SERIFSTYLE_INDEX* = 1
  PAN_WEIGHT_INDEX* = 2
  PAN_PROPORTION_INDEX* = 3
  PAN_CONTRAST_INDEX* = 4
  PAN_STROKEVARIATION_INDEX* = 5
  PAN_ARMSTYLE_INDEX* = 6
  PAN_LETTERFORM_INDEX* = 7
  PAN_MIDLINE_INDEX* = 8
  PAN_XHEIGHT_INDEX* = 9
  PAN_CULTURE_LATIN* = 0
  PAN_ANY* = 0
  PAN_NO_FIT* = 1
  PAN_FAMILY_TEXT_DISPLAY* = 2
  PAN_FAMILY_SCRIPT* = 3
  PAN_FAMILY_DECORATIVE* = 4
  PAN_FAMILY_PICTORIAL* = 5
  PAN_SERIF_COVE* = 2
  PAN_SERIF_OBTUSE_COVE* = 3
  PAN_SERIF_SQUARE_COVE* = 4
  PAN_SERIF_OBTUSE_SQUARE_COVE* = 5
  PAN_SERIF_SQUARE* = 6
  PAN_SERIF_THIN* = 7
  PAN_SERIF_BONE* = 8
  PAN_SERIF_EXAGGERATED* = 9
  PAN_SERIF_TRIANGLE* = 10
  PAN_SERIF_NORMAL_SANS* = 11
  PAN_SERIF_OBTUSE_SANS* = 12
  PAN_SERIF_PERP_SANS* = 13
  PAN_SERIF_FLARED* = 14
  PAN_SERIF_ROUNDED* = 15
  PAN_WEIGHT_VERY_LIGHT* = 2
  PAN_WEIGHT_LIGHT* = 3
  PAN_WEIGHT_THIN* = 4
  PAN_WEIGHT_BOOK* = 5
  PAN_WEIGHT_MEDIUM* = 6
  PAN_WEIGHT_DEMI* = 7
  PAN_WEIGHT_BOLD* = 8
  PAN_WEIGHT_HEAVY* = 9
  PAN_WEIGHT_BLACK* = 10
  PAN_WEIGHT_NORD* = 11
  PAN_PROP_OLD_STYLE* = 2
  PAN_PROP_MODERN* = 3
  PAN_PROP_EVEN_WIDTH* = 4
  PAN_PROP_EXPANDED* = 5
  PAN_PROP_CONDENSED* = 6
  PAN_PROP_VERY_EXPANDED* = 7
  PAN_PROP_VERY_CONDENSED* = 8
  PAN_PROP_MONOSPACED* = 9
  PAN_CONTRAST_NONE* = 2
  PAN_CONTRAST_VERY_LOW* = 3
  PAN_CONTRAST_LOW* = 4
  PAN_CONTRAST_MEDIUM_LOW* = 5
  PAN_CONTRAST_MEDIUM* = 6
  PAN_CONTRAST_MEDIUM_HIGH* = 7
  PAN_CONTRAST_HIGH* = 8
  PAN_CONTRAST_VERY_HIGH* = 9
  PAN_STROKE_GRADUAL_DIAG* = 2
  PAN_STROKE_GRADUAL_TRAN* = 3
  PAN_STROKE_GRADUAL_VERT* = 4
  PAN_STROKE_GRADUAL_HORZ* = 5
  PAN_STROKE_RAPID_VERT* = 6
  PAN_STROKE_RAPID_HORZ* = 7
  PAN_STROKE_INSTANT_VERT* = 8
  PAN_STRAIGHT_ARMS_HORZ* = 2
  PAN_STRAIGHT_ARMS_WEDGE* = 3
  PAN_STRAIGHT_ARMS_VERT* = 4
  PAN_STRAIGHT_ARMS_SINGLE_SERIF* = 5
  PAN_STRAIGHT_ARMS_DOUBLE_SERIF* = 6
  PAN_BENT_ARMS_HORZ* = 7
  PAN_BENT_ARMS_WEDGE* = 8
  PAN_BENT_ARMS_VERT* = 9
  PAN_BENT_ARMS_SINGLE_SERIF* = 10
  PAN_BENT_ARMS_DOUBLE_SERIF* = 11
  PAN_LETT_NORMAL_CONTACT* = 2
  PAN_LETT_NORMAL_WEIGHTED* = 3
  PAN_LETT_NORMAL_BOXED* = 4
  PAN_LETT_NORMAL_FLATTENED* = 5
  PAN_LETT_NORMAL_ROUNDED* = 6
  PAN_LETT_NORMAL_OFF_CENTER* = 7
  PAN_LETT_NORMAL_SQUARE* = 8
  PAN_LETT_OBLIQUE_CONTACT* = 9
  PAN_LETT_OBLIQUE_WEIGHTED* = 10
  PAN_LETT_OBLIQUE_BOXED* = 11
  PAN_LETT_OBLIQUE_FLATTENED* = 12
  PAN_LETT_OBLIQUE_ROUNDED* = 13
  PAN_LETT_OBLIQUE_OFF_CENTER* = 14
  PAN_LETT_OBLIQUE_SQUARE* = 15
  PAN_MIDLINE_STANDARD_TRIMMED* = 2
  PAN_MIDLINE_STANDARD_POINTED* = 3
  PAN_MIDLINE_STANDARD_SERIFED* = 4
  PAN_MIDLINE_HIGH_TRIMMED* = 5
  PAN_MIDLINE_HIGH_POINTED* = 6
  PAN_MIDLINE_HIGH_SERIFED* = 7
  PAN_MIDLINE_CONSTANT_TRIMMED* = 8
  PAN_MIDLINE_CONSTANT_POINTED* = 9
  PAN_MIDLINE_CONSTANT_SERIFED* = 10
  PAN_MIDLINE_LOW_TRIMMED* = 11
  PAN_MIDLINE_LOW_POINTED* = 12
  PAN_MIDLINE_LOW_SERIFED* = 13
  PAN_XHEIGHT_CONSTANT_SMALL* = 2
  PAN_XHEIGHT_CONSTANT_STD* = 3
  PAN_XHEIGHT_CONSTANT_LARGE* = 4
  PAN_XHEIGHT_DUCKING_SMALL* = 5
  PAN_XHEIGHT_DUCKING_STD* = 6
  PAN_XHEIGHT_DUCKING_LARGE* = 7
  ELF_VERSION* = 0
  ELF_CULTURE_LATIN* = 0
  RASTER_FONTTYPE* = 0x0001
  DEVICE_FONTTYPE* = 0x002
  TRUETYPE_FONTTYPE* = 0x004
  PC_RESERVED* = 0x01
  PC_EXPLICIT* = 0x02
  PC_NOCOLLAPSE* = 0x04
  TRANSPARENT* = 1
  OPAQUE* = 2
  BKMODE_LAST* = 2
  GM_COMPATIBLE* = 1
  GM_ADVANCED* = 2
  GM_LAST* = 2
  PT_CLOSEFIGURE* = 0x01
  PT_LINETO* = 0x02
  PT_BEZIERTO* = 0x04
  PT_MOVETO* = 0x06
  MM_TEXT* = 1
  MM_LOMETRIC* = 2
  MM_HIMETRIC* = 3
  MM_LOENGLISH* = 4
  MM_HIENGLISH* = 5
  MM_TWIPS* = 6
  MM_ISOTROPIC* = 7
  MM_ANISOTROPIC* = 8
  MM_MIN* = MM_TEXT
  MM_MAX* = MM_ANISOTROPIC
  MM_MAX_FIXEDSCALE* = MM_TWIPS
  ABSOLUTE* = 1
  RELATIVE* = 2
  WHITE_BRUSH* = 0
  LTGRAY_BRUSH* = 1
  GRAY_BRUSH* = 2
  DKGRAY_BRUSH* = 3
  BLACK_BRUSH* = 4
  NULL_BRUSH* = 5
  HOLLOW_BRUSH* = NULL_BRUSH
  WHITE_PEN* = 6
  BLACK_PEN* = 7
  NULL_PEN* = 8
  OEM_FIXED_FONT* = 10
  ANSI_FIXED_FONT* = 11
  ANSI_VAR_FONT* = 12
  SYSTEM_FONT* = 13
  DEVICE_DEFAULT_FONT* = 14
  DEFAULT_PALETTE* = 15
  SYSTEM_FIXED_FONT* = 16
  DEFAULT_GUI_FONT* = 17
  DC_BRUSH* = 18
  DC_PEN* = 19
  STOCK_LAST* = 19
  CLR_INVALID* = 0xFFFFFFFF'i32
  BS_SOLID* = 0
  BS_NULL* = 1
  BS_HOLLOW* = BS_NULL
  BS_HATCHED* = 2
  BS_PATTERN* = 3
  BS_INDEXED* = 4
  BS_DIBPATTERN* = 5
  BS_DIBPATTERNPT* = 6
  BS_PATTERN8X8* = 7
  BS_DIBPATTERN8X8* = 8
  BS_MONOPATTERN* = 9
  HS_HORIZONTAL* = 0
  HS_VERTICAL* = 1
  HS_FDIAGONAL* = 2
  HS_BDIAGONAL* = 3
  HS_CROSS* = 4
  HS_DIAGCROSS* = 5
  HS_API_MAX* = 12
  PS_SOLID* = 0
  PS_DASH* = 1
  PS_DOT* = 2
  PS_DASHDOT* = 3
  PS_DASHDOTDOT* = 4
  PS_NULL* = 5
  PS_INSIDEFRAME* = 6
  PS_USERSTYLE* = 7
  PS_ALTERNATE* = 8
  PS_STYLE_MASK* = 0x0000000F
  PS_ENDCAP_ROUND* = 0x00000000
  PS_ENDCAP_SQUARE* = 0x00000100
  PS_ENDCAP_FLAT* = 0x00000200
  PS_ENDCAP_MASK* = 0x00000F00
  PS_JOIN_ROUND* = 0x00000000
  PS_JOIN_BEVEL* = 0x00001000
  PS_JOIN_MITER* = 0x00002000
  PS_JOIN_MASK* = 0x0000F000
  PS_COSMETIC* = 0x00000000
  PS_GEOMETRIC* = 0x00010000
  PS_TYPE_MASK* = 0x000F0000
  AD_COUNTERCLOCKWISE* = 1
  AD_CLOCKWISE* = 2
  DRIVERVERSION* = 0
  TECHNOLOGY* = 2
  HORZSIZE* = 4
  VERTSIZE* = 6
  HORZRES* = 8
  VERTRES* = 10
  BITSPIXEL* = 12
  PLANES* = 14
  NUMBRUSHES* = 16
  NUMPENS* = 18
  NUMMARKERS* = 20
  NUMFONTS* = 22
  NUMCOLORS* = 24
  PDEVICESIZE* = 26
  CURVECAPS* = 28
  LINECAPS* = 30
  POLYGONALCAPS* = 32
  TEXTCAPS* = 34
  CLIPCAPS* = 36
  RASTERCAPS* = 38
  ASPECTX* = 40
  ASPECTY* = 42
  ASPECTXY* = 44
  LOGPIXELSX* = 88
  LOGPIXELSY* = 90
  SIZEPALETTE* = 104
  NUMRESERVED* = 106
  COLORRES* = 108
  PHYSICALWIDTH* = 110
  PHYSICALHEIGHT* = 111
  PHYSICALOFFSETX* = 112
  PHYSICALOFFSETY* = 113
  SCALINGFACTORX* = 114
  SCALINGFACTORY* = 115
  VREFRESH* = 116
  DESKTOPVERTRES* = 117
  DESKTOPHORZRES* = 118
  BLTALIGNMENT* = 119
  SHADEBLENDCAPS* = 120
  COLORMGMTCAPS* = 121
  DT_PLOTTER* = 0
  DT_RASDISPLAY* = 1
  DT_RASPRINTER* = 2
  DT_RASCAMERA* = 3
  DT_CHARSTREAM* = 4
  DT_METAFILE* = 5
  DT_DISPFILE* = 6
  CC_NONE* = 0
  CC_CIRCLES* = 1
  CC_PIE* = 2
  CC_CHORD* = 4
  CC_ELLIPSES* = 8
  CC_WIDE* = 16
  CC_STYLED* = 32
  CC_WIDESTYLED* = 64
  CC_INTERIORS* = 128
  CC_ROUNDRECT* = 256
  LC_NONE* = 0
  LC_POLYLINE* = 2
  LC_MARKER* = 4
  LC_POLYMARKER* = 8
  LC_WIDE* = 16
  LC_STYLED* = 32
  LC_WIDESTYLED* = 64
  LC_INTERIORS* = 128
  PC_NONE* = 0
  PC_POLYGON* = 1
  PC_RECTANGLE* = 2
  PC_WINDPOLYGON* = 4
  PC_TRAPEZOID* = 4
  PC_SCANLINE* = 8
  PC_WIDE* = 16
  PC_STYLED* = 32
  PC_WIDESTYLED* = 64
  PC_INTERIORS* = 128
  PC_POLYPOLYGON* = 256
  PC_PATHS* = 512
  CP_NONE* = 0
  CP_RECTANGLE* = 1
  CP_REGION* = 2
  TC_OP_CHARACTER* = 0x00000001
  TC_OP_STROKE* = 0x00000002
  TC_CP_STROKE* = 0x00000004
  TC_CR_90* = 0x00000008
  TC_CR_ANY* = 0x00000010
  TC_SF_X_YINDEP* = 0x00000020
  TC_SA_DOUBLE* = 0x00000040
  TC_SA_INTEGER* = 0x00000080
  TC_SA_CONTIN* = 0x00000100
  TC_EA_DOUBLE* = 0x00000200
  TC_IA_ABLE* = 0x00000400
  TC_UA_ABLE* = 0x00000800
  TC_SO_ABLE* = 0x00001000
  TC_RA_ABLE* = 0x00002000
  TC_VA_ABLE* = 0x00004000
  TC_RESERVED* = 0x00008000
  TC_SCROLLBLT* = 0x00010000
  RC_BITBLT* = 1
  RC_BANDING* = 2
  RC_SCALING* = 4
  RC_BITMAP64* = 8
  RC_GDI20_OUTPUT* = 0x0010
  RC_GDI20_STATE* = 0x0020
  RC_SAVEBITMAP* = 0x0040
  RC_DI_BITMAP* = 0x0080
  RC_PALETTE* = 0x0100
  RC_DIBTODEV* = 0x0200
  RC_BIGFONT* = 0x0400
  RC_STRETCHBLT* = 0x0800
  RC_FLOODFILL* = 0x1000
  RC_STRETCHDIB* = 0x2000
  RC_OP_DX_OUTPUT* = 0x4000
  RC_DEVBITS* = 0x8000
  SB_NONE* = 0x00000000
  SB_CONST_ALPHA* = 0x00000001
  SB_PIXEL_ALPHA* = 0x00000002
  SB_PREMULT_ALPHA* = 0x00000004
  SB_GRAD_RECT* = 0x00000010
  SB_GRAD_TRI* = 0x00000020
  CM_NONE* = 0x00000000
  CM_DEVICE_ICM* = 0x00000001
  CM_GAMMA_RAMP* = 0x00000002
  CM_CMYK_COLOR* = 0x00000004
  DIB_RGB_COLORS* = 0
  DIB_PAL_COLORS* = 1
  SYSPAL_ERROR* = 0
  SYSPAL_STATIC* = 1
  SYSPAL_NOSTATIC* = 2
  SYSPAL_NOSTATIC256* = 3
  CBM_INIT* = 0x04
  FLOODFILLBORDER* = 0
  FLOODFILLSURFACE* = 1
  DM_SPECVERSION* = 0x0401
  DM_ORIENTATION* = 0x00000001
  DM_PAPERSIZE* = 0x00000002
  DM_PAPERLENGTH* = 0x00000004
  DM_PAPERWIDTH* = 0x00000008
  DM_SCALE* = 0x00000010
  DM_POSITION* = 0x00000020
  DM_NUP* = 0x00000040
  DM_DISPLAYORIENTATION* = 0x00000080
  DM_COPIES* = 0x00000100
  DM_DEFAULTSOURCE* = 0x00000200
  DM_PRINTQUALITY* = 0x00000400
  DM_COLOR* = 0x00000800
  DM_DUPLEX* = 0x00001000
  DM_YRESOLUTION* = 0x00002000
  DM_TTOPTION* = 0x00004000
  DM_COLLATE* = 0x00008000
  DM_FORMNAME* = 0x00010000
  DM_LOGPIXELS* = 0x00020000
  DM_BITSPERPEL* = 0x00040000
  DM_PELSWIDTH* = 0x00080000
  DM_PELSHEIGHT* = 0x00100000
  DM_DISPLAYFLAGS* = 0x00200000
  DM_DISPLAYFREQUENCY* = 0x00400000
  DM_ICMMETHOD* = 0x00800000
  DM_ICMINTENT* = 0x01000000
  DM_MEDIATYPE* = 0x02000000
  DM_DITHERTYPE* = 0x04000000
  DM_PANNINGWIDTH* = 0x08000000
  DM_PANNINGHEIGHT* = 0x10000000
  DM_DISPLAYFIXEDOUTPUT* = 0x20000000
  DMORIENT_PORTRAIT* = 1
  DMORIENT_LANDSCAPE* = 2
  DMPAPER_LETTER* = 1
  DMPAPER_FIRST* = DMPAPER_LETTER
  DMPAPER_LETTERSMALL* = 2
  DMPAPER_TABLOID* = 3
  DMPAPER_LEDGER* = 4
  DMPAPER_LEGAL* = 5
  DMPAPER_STATEMENT* = 6
  DMPAPER_EXECUTIVE* = 7
  DMPAPER_A3* = 8
  DMPAPER_A4* = 9
  DMPAPER_A4SMALL* = 10
  DMPAPER_A5* = 11
  DMPAPER_B4* = 12
  DMPAPER_B5* = 13
  DMPAPER_FOLIO* = 14
  DMPAPER_QUARTO* = 15
  DMPAPER_10X14* = 16
  DMPAPER_11X17* = 17
  DMPAPER_NOTE* = 18
  DMPAPER_ENV_9* = 19
  DMPAPER_ENV_10* = 20
  DMPAPER_ENV_11* = 21
  DMPAPER_ENV_12* = 22
  DMPAPER_ENV_14* = 23
  DMPAPER_CSHEET* = 24
  DMPAPER_DSHEET* = 25
  DMPAPER_ESHEET* = 26
  DMPAPER_ENV_DL* = 27
  DMPAPER_ENV_C5* = 28
  DMPAPER_ENV_C3* = 29
  DMPAPER_ENV_C4* = 30
  DMPAPER_ENV_C6* = 31
  DMPAPER_ENV_C65* = 32
  DMPAPER_ENV_B4* = 33
  DMPAPER_ENV_B5* = 34
  DMPAPER_ENV_B6* = 35
  DMPAPER_ENV_ITALY* = 36
  DMPAPER_ENV_MONARCH* = 37
  DMPAPER_ENV_PERSONAL* = 38
  DMPAPER_FANFOLD_US* = 39
  DMPAPER_FANFOLD_STD_GERMAN* = 40
  DMPAPER_FANFOLD_LGL_GERMAN* = 41
  DMPAPER_ISO_B4* = 42
  DMPAPER_JAPANESE_POSTCARD* = 43
  DMPAPER_9X11* = 44
  DMPAPER_10X11* = 45
  DMPAPER_15X11* = 46
  DMPAPER_ENV_INVITE* = 47
  DMPAPER_RESERVED_48* = 48
  DMPAPER_RESERVED_49* = 49
  DMPAPER_LETTER_EXTRA* = 50
  DMPAPER_LEGAL_EXTRA* = 51
  DMPAPER_TABLOID_EXTRA* = 52
  DMPAPER_A4_EXTRA* = 53
  DMPAPER_LETTER_TRANSVERSE* = 54
  DMPAPER_A4_TRANSVERSE* = 55
  DMPAPER_LETTER_EXTRA_TRANSVERSE* = 56
  DMPAPER_A_PLUS* = 57
  DMPAPER_B_PLUS* = 58
  DMPAPER_LETTER_PLUS* = 59
  DMPAPER_A4_PLUS* = 60
  DMPAPER_A5_TRANSVERSE* = 61
  DMPAPER_B5_TRANSVERSE* = 62
  DMPAPER_A3_EXTRA* = 63
  DMPAPER_A5_EXTRA* = 64
  DMPAPER_B5_EXTRA* = 65
  DMPAPER_A2* = 66
  DMPAPER_A3_TRANSVERSE* = 67
  DMPAPER_A3_EXTRA_TRANSVERSE* = 68
  DMPAPER_DBL_JAPANESE_POSTCARD* = 69
  DMPAPER_A6* = 70
  DMPAPER_JENV_KAKU2* = 71
  DMPAPER_JENV_KAKU3* = 72
  DMPAPER_JENV_CHOU3* = 73
  DMPAPER_JENV_CHOU4* = 74
  DMPAPER_LETTER_ROTATED* = 75
  DMPAPER_A3_ROTATED* = 76
  DMPAPER_A4_ROTATED* = 77
  DMPAPER_A5_ROTATED* = 78
  DMPAPER_B4_JIS_ROTATED* = 79
  DMPAPER_B5_JIS_ROTATED* = 80
  DMPAPER_JAPANESE_POSTCARD_ROTATED* = 81
  DMPAPER_DBL_JAPANESE_POSTCARD_ROTATED* = 82
  DMPAPER_A6_ROTATED* = 83
  DMPAPER_JENV_KAKU2_ROTATED* = 84
  DMPAPER_JENV_KAKU3_ROTATED* = 85
  DMPAPER_JENV_CHOU3_ROTATED* = 86
  DMPAPER_JENV_CHOU4_ROTATED* = 87
  DMPAPER_B6_JIS* = 88
  DMPAPER_B6_JIS_ROTATED* = 89
  DMPAPER_12X11* = 90
  DMPAPER_JENV_YOU4* = 91
  DMPAPER_JENV_YOU4_ROTATED* = 92
  DMPAPER_P16K* = 93
  DMPAPER_P32K* = 94
  DMPAPER_P32KBIG* = 95
  DMPAPER_PENV_1* = 96
  DMPAPER_PENV_2* = 97
  DMPAPER_PENV_3* = 98
  DMPAPER_PENV_4* = 99
  DMPAPER_PENV_5* = 100
  DMPAPER_PENV_6* = 101
  DMPAPER_PENV_7* = 102
  DMPAPER_PENV_8* = 103
  DMPAPER_PENV_9* = 104
  DMPAPER_PENV_10* = 105
  DMPAPER_P16K_ROTATED* = 106
  DMPAPER_P32K_ROTATED* = 107
  DMPAPER_P32KBIG_ROTATED* = 108
  DMPAPER_PENV_1_ROTATED* = 109
  DMPAPER_PENV_2_ROTATED* = 110
  DMPAPER_PENV_3_ROTATED* = 111
  DMPAPER_PENV_4_ROTATED* = 112
  DMPAPER_PENV_5_ROTATED* = 113
  DMPAPER_PENV_6_ROTATED* = 114
  DMPAPER_PENV_7_ROTATED* = 115
  DMPAPER_PENV_8_ROTATED* = 116
  DMPAPER_PENV_9_ROTATED* = 117
  DMPAPER_PENV_10_ROTATED* = 118
  DMPAPER_LAST* = DMPAPER_PENV_10_ROTATED
  DMPAPER_USER* = 256
  DMBIN_UPPER* = 1
  DMBIN_FIRST* = DMBIN_UPPER
  DMBIN_ONLYONE* = 1
  DMBIN_LOWER* = 2
  DMBIN_MIDDLE* = 3
  DMBIN_MANUAL* = 4
  DMBIN_ENVELOPE* = 5
  DMBIN_ENVMANUAL* = 6
  DMBIN_AUTO* = 7
  DMBIN_TRACTOR* = 8
  DMBIN_SMALLFMT* = 9
  DMBIN_LARGEFMT* = 10
  DMBIN_LARGECAPACITY* = 11
  DMBIN_CASSETTE* = 14
  DMBIN_FORMSOURCE* = 15
  DMBIN_LAST* = DMBIN_FORMSOURCE
  DMBIN_USER* = 256
  DMRES_DRAFT* = -1
  DMRES_LOW* = -2
  DMRES_MEDIUM* = -3
  DMRES_HIGH* = -4
  DMCOLOR_MONOCHROME* = 1
  DMCOLOR_COLOR* = 2
  DMDUP_SIMPLEX* = 1
  DMDUP_VERTICAL* = 2
  DMDUP_HORIZONTAL* = 3
  DMTT_BITMAP* = 1
  DMTT_DOWNLOAD* = 2
  DMTT_SUBDEV* = 3
  DMTT_DOWNLOAD_OUTLINE* = 4
  DMCOLLATE_FALSE* = 0
  DMCOLLATE_TRUE* = 1
  DMDO_DEFAULT* = 0
  DMDO_90* = 1
  DMDO_180* = 2
  DMDO_270* = 3
  DMDFO_DEFAULT* = 0
  DMDFO_STRETCH* = 1
  DMDFO_CENTER* = 2
  DM_INTERLACED* = 0x00000002
  DMDISPLAYFLAGS_TEXTMODE* = 0x00000004
  DMNUP_SYSTEM* = 1
  DMNUP_ONEUP* = 2
  DMICMMETHOD_NONE* = 1
  DMICMMETHOD_SYSTEM* = 2
  DMICMMETHOD_DRIVER* = 3
  DMICMMETHOD_DEVICE* = 4
  DMICMMETHOD_USER* = 256
  DMICM_SATURATE* = 1
  DMICM_CONTRAST* = 2
  DMICM_COLORIMETRIC* = 3
  DMICM_ABS_COLORIMETRIC* = 4
  DMICM_USER* = 256
  DMMEDIA_STANDARD* = 1
  DMMEDIA_TRANSPARENCY* = 2
  DMMEDIA_GLOSSY* = 3
  DMMEDIA_USER* = 256
  DMDITHER_NONE* = 1
  DMDITHER_COARSE* = 2
  DMDITHER_FINE* = 3
  DMDITHER_LINEART* = 4
  DMDITHER_ERRORDIFFUSION* = 5
  DMDITHER_RESERVED6* = 6
  DMDITHER_RESERVED7* = 7
  DMDITHER_RESERVED8* = 8
  DMDITHER_RESERVED9* = 9
  DMDITHER_GRAYSCALE* = 10
  DMDITHER_USER* = 256
  DISPLAY_DEVICE_ATTACHED_TO_DESKTOP* = 0x00000001
  DISPLAY_DEVICE_MULTI_DRIVER* = 0x00000002
  DISPLAY_DEVICE_PRIMARY_DEVICE* = 0x00000004
  DISPLAY_DEVICE_MIRRORING_DRIVER* = 0x00000008
  DISPLAY_DEVICE_VGA_COMPATIBLE* = 0x00000010
  DISPLAY_DEVICE_REMOVABLE* = 0x00000020
  DISPLAY_DEVICE_ACC_DRIVER* = 0x00000040
  DISPLAY_DEVICE_TS_COMPATIBLE* = 0x00200000
  DISPLAY_DEVICE_UNSAFE_MODES_ON* = 0x00080000
  DISPLAY_DEVICE_MODESPRUNED* = 0x08000000
  DISPLAY_DEVICE_REMOTE* = 0x04000000
  DISPLAY_DEVICE_DISCONNECT* = 0x02000000
  DISPLAY_DEVICE_ACTIVE* = 0x00000001
  DISPLAY_DEVICE_ATTACHED* = 0x00000002
  DISPLAYCONFIG_MAXPATH* = 1024
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_OTHER* = int32(-1)
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_HD15* = int32 0
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SVIDEO* = int32 1
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_COMPOSITE_VIDEO* = int32 2
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_COMPONENT_VIDEO* = int32 3
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DVI* = int32 4
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_HDMI* = int32 5
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_LVDS* = int32 6
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_D_JPN* = int32 8
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SDI* = int32 9
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_EXTERNAL* = int32 10
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_EMBEDDED* = int32 11
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_UDI_EXTERNAL* = int32 12
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_UDI_EMBEDDED* = int32 13
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SDTVDONGLE* = int32 14
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INTERNAL* = int32 0x80000000'i32
  DISPLAYCONFIG_OUTPUT_TECHNOLOGY_FORCE_UINT32* = int32 0xFFFFFFFF'i32
  DISPLAYCONFIG_SCANLINE_ORDERING_UNSPECIFIED* = 0
  DISPLAYCONFIG_SCANLINE_ORDERING_PROGRESSIVE* = 1
  DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED* = 2
  DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED_UPPERFIELDFIRST* = 2
  DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED_LOWERFIELDFIRST* = 3
  DISPLAYCONFIG_SCANLINE_ORDERING_FORCE_UINT32* = 0xFFFFFFFF'i32
  DISPLAYCONFIG_SCALING_IDENTITY* = 1
  DISPLAYCONFIG_SCALING_CENTERED* = 2
  DISPLAYCONFIG_SCALING_STRETCHED* = 3
  DISPLAYCONFIG_SCALING_ASPECTRATIOCENTEREDMAX* = 4
  DISPLAYCONFIG_SCALING_CUSTOM* = 5
  DISPLAYCONFIG_SCALING_PREFERRED* = 128
  DISPLAYCONFIG_SCALING_FORCE_UINT32* = 0xFFFFFFFF'i32
  DISPLAYCONFIG_ROTATION_IDENTITY* = 1
  DISPLAYCONFIG_ROTATION_ROTATE90* = 2
  DISPLAYCONFIG_ROTATION_ROTATE180* = 3
  DISPLAYCONFIG_ROTATION_ROTATE270* = 4
  DISPLAYCONFIG_ROTATION_FORCE_UINT32* = 0xFFFFFFFF'i32
  DISPLAYCONFIG_MODE_INFO_TYPE_SOURCE* = 1
  DISPLAYCONFIG_MODE_INFO_TYPE_TARGET* = 2
  DISPLAYCONFIG_MODE_INFO_TYPE_FORCE_UINT32* = 0xFFFFFFFF'i32
  DISPLAYCONFIG_PIXELFORMAT_8BPP* = 1
  DISPLAYCONFIG_PIXELFORMAT_16BPP* = 2
  DISPLAYCONFIG_PIXELFORMAT_24BPP* = 3
  DISPLAYCONFIG_PIXELFORMAT_32BPP* = 4
  DISPLAYCONFIG_PIXELFORMAT_NONGDI* = 5
  DISPLAYCONFIG_PIXELFORMAT_FORCE_UINT32* = 0xffffffff'i32
  DISPLAYCONFIG_PATH_MODE_IDX_INVALID* = 0xffffffff'i32
  DISPLAYCONFIG_SOURCE_IN_USE* = 0x1
  DISPLAYCONFIG_TARGET_IN_USE* = 0x00000001
  DISPLAYCONFIG_TARGET_FORCIBLE* = 0x00000002
  DISPLAYCONFIG_TARGET_FORCED_AVAILABILITY_BOOT* = 0x00000004
  DISPLAYCONFIG_TARGET_FORCED_AVAILABILITY_PATH* = 0x00000008
  DISPLAYCONFIG_TARGET_FORCED_AVAILABILITY_SYSTEM* = 0x00000010
  DISPLAYCONFIG_PATH_ACTIVE* = 0x1
  DISPLAYCONFIG_TOPOLOGY_INTERNAL* = 0x1
  DISPLAYCONFIG_TOPOLOGY_CLONE* = 0x2
  DISPLAYCONFIG_TOPOLOGY_EXTEND* = 0x4
  DISPLAYCONFIG_TOPOLOGY_EXTERNAL* = 0x8
  DISPLAYCONFIG_TOPOLOGY_FORCE_UINT32* = 0xFFFFFFFF'i32
  DISPLAYCONFIG_DEVICE_INFO_GET_SOURCE_NAME* = 1
  DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_NAME* = 2
  DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_PREFERRED_MODE* = 3
  DISPLAYCONFIG_DEVICE_INFO_GET_ADAPTER_NAME* = 4
  DISPLAYCONFIG_DEVICE_INFO_SET_TARGET_PERSISTENCE* = 5
  DISPLAYCONFIG_DEVICE_INFO_FORCE_UINT32* = 0xFFFFFFFF'i32
  QDC_ALL_PATHS* = 0x00000001
  QDC_ONLY_ACTIVE_PATHS* = 0x00000002
  QDC_DATABASE_CURRENT* = 0x00000004
  SDC_TOPOLOGY_INTERNAL* = 0x00000001
  SDC_TOPOLOGY_CLONE* = 0x00000002
  SDC_TOPOLOGY_EXTEND* = 0x00000004
  SDC_TOPOLOGY_EXTERNAL* = 0x00000008
  SDC_TOPOLOGY_SUPPLIED* = 0x00000010
  SDC_USE_DATABASE_CURRENT* = SDC_TOPOLOGY_INTERNAL or SDC_TOPOLOGY_CLONE or SDC_TOPOLOGY_EXTEND or SDC_TOPOLOGY_EXTERNAL
  SDC_USE_SUPPLIED_DISPLAY_CONFIG* = 0x00000020
  SDC_VALIDATE* = 0x00000040
  SDC_APPLY* = 0x00000080
  SDC_NO_OPTIMIZATION* = 0x00000100
  SDC_SAVE_TO_DATABASE* = 0x00000200
  SDC_ALLOW_CHANGES* = 0x00000400
  SDC_PATH_PERSIST_IF_REQUIRED* = 0x00000800
  SDC_FORCE_MODE_ENUMERATION* = 0x00001000
  SDC_ALLOW_PATH_ORDER_CHANGES* = 0x00002000
  RDH_RECTANGLES* = 1
  SYSRGN* = 4
  GGO_METRICS* = 0
  GGO_BITMAP* = 1
  GGO_NATIVE* = 2
  GGO_BEZIER* = 3
  GGO_GRAY2_BITMAP* = 4
  GGO_GRAY4_BITMAP* = 5
  GGO_GRAY8_BITMAP* = 6
  GGO_GLYPH_INDEX* = 0x0080
  GGO_UNHINTED* = 0x0100
  TT_POLYGON_TYPE* = 24
  TT_PRIM_LINE* = 1
  TT_PRIM_QSPLINE* = 2
  TT_PRIM_CSPLINE* = 3
  GCP_DBCS* = 0x0001
  GCP_REORDER* = 0x0002
  GCP_USEKERNING* = 0x0008
  GCP_GLYPHSHAPE* = 0x0010
  GCP_LIGATE* = 0x0020
  GCP_DIACRITIC* = 0x0100
  GCP_KASHIDA* = 0x0400
  GCP_ERROR* = 0x8000
  FLI_MASK* = 0x103B
  GCP_JUSTIFY* = 0x00010000
  FLI_GLYPHS* = 0x00040000
  GCP_CLASSIN* = 0x00080000
  GCP_MAXEXTENT* = 0x00100000
  GCP_JUSTIFYIN* = 0x00200000
  GCP_DISPLAYZWG* = 0x00400000
  GCP_SYMSWAPOFF* = 0x00800000
  GCP_NUMERICOVERRIDE* = 0x01000000
  GCP_NEUTRALOVERRIDE* = 0x02000000
  GCP_NUMERICSLATIN* = 0x04000000
  GCP_NUMERICSLOCAL* = 0x08000000
  GCPCLASS_LATIN* = 1
  GCPCLASS_HEBREW* = 2
  GCPCLASS_ARABIC* = 2
  GCPCLASS_NEUTRAL* = 3
  GCPCLASS_LOCALNUMBER* = 4
  GCPCLASS_LATINNUMBER* = 5
  GCPCLASS_LATINNUMERICTERMINATOR* = 6
  GCPCLASS_LATINNUMERICSEPARATOR* = 7
  GCPCLASS_NUMERICSEPARATOR* = 8
  GCPCLASS_PREBOUNDLTR* = 0x80
  GCPCLASS_PREBOUNDRTL* = 0x40
  GCPCLASS_POSTBOUNDLTR* = 0x20
  GCPCLASS_POSTBOUNDRTL* = 0x10
  GCPGLYPH_LINKBEFORE* = 0x8000
  GCPGLYPH_LINKAFTER* = 0x4000
  TT_AVAILABLE* = 0x0001
  TT_ENABLED* = 0x0002
  PFD_TYPE_RGBA* = 0
  PFD_TYPE_COLORINDEX* = 1
  PFD_MAIN_PLANE* = 0
  PFD_OVERLAY_PLANE* = 1
  PFD_UNDERLAY_PLANE* = -1
  PFD_DOUBLEBUFFER* = 0x00000001
  PFD_STEREO* = 0x00000002
  PFD_DRAW_TO_WINDOW* = 0x00000004
  PFD_DRAW_TO_BITMAP* = 0x00000008
  PFD_SUPPORT_GDI* = 0x00000010
  PFD_SUPPORT_OPENGL* = 0x00000020
  PFD_GENERIC_FORMAT* = 0x00000040
  PFD_NEED_PALETTE* = 0x00000080
  PFD_NEED_SYSTEM_PALETTE* = 0x00000100
  PFD_SWAP_EXCHANGE* = 0x00000200
  PFD_SWAP_COPY* = 0x00000400
  PFD_SWAP_LAYER_BUFFERS* = 0x00000800
  PFD_GENERIC_ACCELERATED* = 0x00001000
  PFD_SUPPORT_DIRECTDRAW* = 0x00002000
  PFD_DIRECT3D_ACCELERATED* = 0x00004000
  PFD_SUPPORT_COMPOSITION* = 0x00008000
  PFD_DEPTH_DONTCARE* = 0x20000000
  PFD_DOUBLEBUFFER_DONTCARE* = 0x40000000
  PFD_STEREO_DONTCARE* = 0x80000000'i32
  DC_BINADJUST* = 19
  DC_EMF_COMPLIANT* = 20
  DC_DATATYPE_PRODUCED* = 21
  DC_COLLATE* = 22
  DC_MANUFACTURER* = 23
  DC_MODEL* = 24
  DC_PERSONALITY* = 25
  DC_PRINTRATE* = 26
  DC_PRINTRATEUNIT* = 27
  PRINTRATEUNIT_PPM* = 1
  PRINTRATEUNIT_CPS* = 2
  PRINTRATEUNIT_LPM* = 3
  PRINTRATEUNIT_IPM* = 4
  DC_PRINTERMEM* = 28
  DC_MEDIAREADY* = 29
  DC_STAPLE* = 30
  DC_PRINTRATEPPM* = 31
  DC_COLORDEVICE* = 32
  DC_NUP* = 33
  DC_MEDIATYPENAMES* = 34
  DC_MEDIATYPES* = 35
  DCTT_BITMAP* = 0x0000001
  DCTT_DOWNLOAD* = 0x0000002
  DCTT_SUBDEV* = 0x0000004
  DCTT_DOWNLOAD_OUTLINE* = 0x0000008
  DCBA_FACEUPNONE* = 0x0000
  DCBA_FACEUPCENTER* = 0x0001
  DCBA_FACEUPLEFT* = 0x0002
  DCBA_FACEUPRIGHT* = 0x0003
  DCBA_FACEDOWNNONE* = 0x0100
  DCBA_FACEDOWNCENTER* = 0x0101
  DCBA_FACEDOWNLEFT* = 0x0102
  DCBA_FACEDOWNRIGHT* = 0x0103
  GS_8BIT_INDICES* = 0x00000001
  GGI_MARK_NONEXISTING_GLYPHS* = 0X0001
  FR_PRIVATE* = 0x10
  FR_NOT_ENUM* = 0x20
  GDIREGISTERDDRAWPACKETVERSION* = 0x1
  AC_SRC_OVER* = 0x00
  AC_SRC_ALPHA* = 0x01
  GRADIENT_FILL_RECT_H* = 0x00000000
  GRADIENT_FILL_RECT_V* = 0x00000001
  GRADIENT_FILL_TRIANGLE* = 0x00000002
  GRADIENT_FILL_OP_FLAG* = 0x000000ff
  CA_NEGATIVE* = 0x0001
  CA_LOG_FILTER* = 0x0002
  ILLUMINANT_DEVICE_DEFAULT* = 0
  ILLUMINANT_A* = 1
  ILLUMINANT_B* = 2
  ILLUMINANT_C* = 3
  ILLUMINANT_D50* = 4
  ILLUMINANT_D55* = 5
  ILLUMINANT_D65* = 6
  ILLUMINANT_D75* = 7
  ILLUMINANT_F2* = 8
  ILLUMINANT_MAX_INDEX* = ILLUMINANT_F2
  ILLUMINANT_TUNGSTEN* = ILLUMINANT_A
  ILLUMINANT_DAYLIGHT* = ILLUMINANT_C
  ILLUMINANT_FLUORESCENT* = ILLUMINANT_F2
  ILLUMINANT_NTSC* = ILLUMINANT_C
  RGB_GAMMA_MIN* = WORD 02500
  RGB_GAMMA_MAX* = WORD 65000
  REFERENCE_WHITE_MIN* = WORD 6000
  REFERENCE_WHITE_MAX* = WORD 10000
  REFERENCE_BLACK_MIN* = WORD 0
  REFERENCE_BLACK_MAX* = WORD 4000
  COLOR_ADJ_MIN* = SHORT(-100)
  COLOR_ADJ_MAX* = SHORT 100
  DI_APPBANDING* = 0x00000001
  DI_ROPS_READ_DESTINATION* = 0x00000002
  FONTMAPPER_MAX* = 10
  ICM_OFF* = 1
  ICM_ON* = 2
  ICM_QUERY* = 3
  ICM_DONE_OUTSIDEDC* = 4
  ENHMETA_SIGNATURE* = 0x464D4520
  ENHMETA_STOCK_OBJECT* = 0x80000000'i32
  emrHEADER* = 1
  emrPOLYBEZIER* = 2
  emrPOLYGON* = 3
  emrPOLYLINE* = 4
  emrPOLYBEZIERTO* = 5
  emrPOLYLINETO* = 6
  emrPOLYPOLYLINE* = 7
  emrPOLYPOLYGON* = 8
  emrSETWINDOWEXTEX* = 9
  emrSETWINDOWORGEX* = 10
  emrSETVIEWPORTEXTEX* = 11
  emrSETVIEWPORTORGEX* = 12
  emrSETBRUSHORGEX* = 13
  emrEOF* = 14
  emrSETPIXELV* = 15
  emrSETMAPPERFLAGS* = 16
  emrSETMAPMODE* = 17
  emrSETBKMODE* = 18
  emrSETPOLYFILLMODE* = 19
  emrSETROP2* = 20
  emrSETSTRETCHBLTMODE* = 21
  emrSETTEXTALIGN* = 22
  emrSETCOLORADJUSTMENT* = 23
  emrSETTEXTCOLOR* = 24
  emrSETBKCOLOR* = 25
  emrOFFSETCLIPRGN* = 26
  emrMOVETOEX* = 27
  emrSETMETARGN* = 28
  emrEXCLUDECLIPRECT* = 29
  emrINTERSECTCLIPRECT* = 30
  emrSCALEVIEWPORTEXTEX* = 31
  emrSCALEWINDOWEXTEX* = 32
  emrSAVEDC* = 33
  emrRESTOREDC* = 34
  emrSETWORLDTRANSFORM* = 35
  emrMODIFYWORLDTRANSFORM* = 36
  emrSELECTOBJECT* = 37
  emrCREATEPEN* = 38
  emrCREATEBRUSHINDIRECT* = 39
  emrDELETEOBJECT* = 40
  emrANGLEARC* = 41
  emrELLIPSE* = 42
  emrRECTANGLE* = 43
  emrROUNDRECT* = 44
  emrARC* = 45
  emrCHORD* = 46
  emrPIE* = 47
  emrSELECTPALETTE* = 48
  emrCREATEPALETTE* = 49
  emrSETPALETTEENTRIES* = 50
  emrRESIZEPALETTE* = 51
  emrREALIZEPALETTE* = 52
  emrEXTFLOODFILL* = 53
  emrLINETO* = 54
  emrARCTO* = 55
  emrPOLYDRAW* = 56
  emrSETARCDIRECTION* = 57
  emrSETMITERLIMIT* = 58
  emrBEGINPATH* = 59
  emrENDPATH* = 60
  emrCLOSEFIGURE* = 61
  emrFILLPATH* = 62
  emrSTROKEANDFILLPATH* = 63
  emrSTROKEPATH* = 64
  emrFLATTENPATH* = 65
  emrWIDENPATH* = 66
  emrSELECTCLIPPATH* = 67
  emrABORTPATH* = 68
  emrGDICOMMENT* = 70
  emrFILLRGN* = 71
  emrFRAMERGN* = 72
  emrINVERTRGN* = 73
  emrPAINTRGN* = 74
  emrEXTSELECTCLIPRGN* = 75
  emrBITBLT* = 76
  emrSTRETCHBLT* = 77
  emrMASKBLT* = 78
  emrPLGBLT* = 79
  emrSETDIBITSTODEVICE* = 80
  emrSTRETCHDIBITS* = 81
  emrEXTCREATEFONTINDIRECTW* = 82
  emrEXTTEXTOUTA* = 83
  emrEXTTEXTOUTW* = 84
  emrPOLYBEZIER16* = 85
  emrPOLYGON16* = 86
  emrPOLYLINE16* = 87
  emrPOLYBEZIERTO16* = 88
  emrPOLYLINETO16* = 89
  emrPOLYPOLYLINE16* = 90
  emrPOLYPOLYGON16* = 91
  emrPOLYDRAW16* = 92
  emrCREATEMONOBRUSH* = 93
  emrCREATEDIBPATTERNBRUSHPT* = 94
  emrEXTCREATEPEN* = 95
  emrPOLYTEXTOUTA* = 96
  emrPOLYTEXTOUTW* = 97
  emrSETICMMODE* = 98
  emrCREATECOLORSPACE* = 99
  emrSETCOLORSPACE* = 100
  emrDELETECOLORSPACE* = 101
  emrGLSRECORD* = 102
  emrGLSBOUNDEDRECORD* = 103
  emrPIXELFORMAT* = 104
  emrRESERVED_105* = 105
  emrRESERVED_106* = 106
  emrRESERVED_107* = 107
  emrRESERVED_108* = 108
  emrRESERVED_109* = 109
  emrRESERVED_110* = 110
  emrCOLORCORRECTPALETTE* = 111
  emrSETICMPROFILEA* = 112
  emrSETICMPROFILEW* = 113
  emrALPHABLEND* = 114
  emrSETLAYOUT* = 115
  emrTRANSPARENTBLT* = 116
  emrRESERVED_117* = 117
  emrGRADIENTFILL* = 118
  emrRESERVED_119* = 119
  emrRESERVED_120* = 120
  emrCOLORMATCHTOTARGETW* = 121
  emrCREATECOLORSPACEW* = 122
  emrMIN* = 1
  emrMAX* = 122
  SETICMPROFILE_EMBEDED* = 0x00000001
  CREATECOLORSPACE_EMBEDED* = 0x00000001
  COLORMATCHTOTARGET_EMBEDED* = 0x00000001
  GDICOMMENT_IDENTIFIER* = 0x43494447
  GDICOMMENT_WINDOWS_METAFILE* = 0x80000001'i32
  GDICOMMENT_BEGINGROUP* = 0x00000002
  GDICOMMENT_ENDGROUP* = 0x00000003
  GDICOMMENT_MULTIFORMATS* = 0x40000004
  EPS_SIGNATURE* = 0x46535045
  GDICOMMENT_UNICODE_STRING* = 0x00000040
  GDICOMMENT_UNICODE_END* = 0x00000080
  WGL_FONT_LINES* = 0
  WGL_FONT_POLYGONS* = 1
  LPD_DOUBLEBUFFER* = 0x00000001
  LPD_STEREO* = 0x00000002
  LPD_SUPPORT_GDI* = 0x00000010
  LPD_SUPPORT_OPENGL* = 0x00000020
  LPD_SHARE_DEPTH* = 0x00000040
  LPD_SHARE_STENCIL* = 0x00000080
  LPD_SHARE_ACCUM* = 0x00000100
  LPD_SWAP_EXCHANGE* = 0x00000200
  LPD_SWAP_COPY* = 0x00000400
  LPD_TRANSPARENT* = 0x00001000
  LPD_TYPE_RGBA* = 0
  LPD_TYPE_COLORINDEX* = 1
  WGL_SWAP_MAIN_PLANE* = 0x00000001
  WGL_SWAP_OVERLAY1* = 0x00000002
  WGL_SWAP_OVERLAY2* = 0x00000004
  WGL_SWAP_OVERLAY3* = 0x00000008
  WGL_SWAP_OVERLAY4* = 0x00000010
  WGL_SWAP_OVERLAY5* = 0x00000020
  WGL_SWAP_OVERLAY6* = 0x00000040
  WGL_SWAP_OVERLAY7* = 0x00000080
  WGL_SWAP_OVERLAY8* = 0x00000100
  WGL_SWAP_OVERLAY9* = 0x00000200
  WGL_SWAP_OVERLAY10* = 0x00000400
  WGL_SWAP_OVERLAY11* = 0x00000800
  WGL_SWAP_OVERLAY12* = 0x00001000
  WGL_SWAP_OVERLAY13* = 0x00002000
  WGL_SWAP_OVERLAY14* = 0x00004000
  WGL_SWAP_OVERLAY15* = 0x00008000
  WGL_SWAP_UNDERLAY1* = 0x00010000
  WGL_SWAP_UNDERLAY2* = 0x00020000
  WGL_SWAP_UNDERLAY3* = 0x00040000
  WGL_SWAP_UNDERLAY4* = 0x00080000
  WGL_SWAP_UNDERLAY5* = 0x00100000
  WGL_SWAP_UNDERLAY6* = 0x00200000
  WGL_SWAP_UNDERLAY7* = 0x00400000
  WGL_SWAP_UNDERLAY8* = 0x00800000
  WGL_SWAP_UNDERLAY9* = 0x01000000
  WGL_SWAP_UNDERLAY10* = 0x02000000
  WGL_SWAP_UNDERLAY11* = 0x04000000
  WGL_SWAP_UNDERLAY12* = 0x08000000
  WGL_SWAP_UNDERLAY13* = 0x10000000
  WGL_SWAP_UNDERLAY14* = 0x20000000
  WGL_SWAP_UNDERLAY15* = 0x40000000
  WGL_SWAPMULTIPLE_MAX* = 16
  STAMP_AXESLIST* = 0x08006C61
  STAMP_DESIGNVECTOR* = 0x08007664
type
  GOBJENUMPROC* = proc (P1: LPVOID, P2: LPARAM): int32 {.stdcall.}
  LINEDDAPROC* = proc (P1: int32, P2: int32, P3: LPARAM): VOID {.stdcall.}
when winimUnicode:
  type
    LPDEVMODE* = LPDEVMODEW
when winimAnsi:
  type
    LPDEVMODE* = LPDEVMODEA
type
  LPFNDEVMODE* = proc (P1: HWND, P2: HMODULE, P3: LPDEVMODE, P4: LPSTR, P5: LPSTR, P6: LPDEVMODE, P7: LPSTR, P8: UINT): UINT {.stdcall.}
  LPFNDEVCAPS* = proc (P1: LPSTR, P2: LPSTR, P3: UINT, P4: LPSTR, P5: LPDEVMODE): DWORD {.stdcall.}
  GDIMARSHALLOC* = proc (dwSize: DWORD, pGdiRef: LPVOID): PVOID {.stdcall.}
  MFENUMPROC* = proc (hdc: HDC, lpht: ptr HANDLETABLE, lpMR: ptr METARECORD, nObj: int32, lParam: LPARAM): int32 {.stdcall.}
  ENHMFENUMPROC* = proc (hdc: HDC, lpht: ptr HANDLETABLE, lpmr: ptr ENHMETARECORD, hHandles: int32, data: LPARAM): int32 {.stdcall.}
  ABORTPROC* = proc (P1: HDC, P2: int32): WINBOOL {.stdcall.}
  ICMENUMPROCA* = proc (P1: LPSTR, P2: LPARAM): int32 {.stdcall.}
  ICMENUMPROCW* = proc (P1: LPWSTR, P2: LPARAM): int32 {.stdcall.}
  DISPLAYCONFIG_RATIONAL* {.pure.} = object
    Numerator*: UINT32
    Denominator*: UINT32
  DISPLAYCONFIG_2DREGION* {.pure.} = object
    cx*: UINT32
    cy*: UINT32
  DISPLAYCONFIG_VIDEO_SIGNAL_INFO* {.pure.} = object
    pixelRate*: UINT64
    hSyncFreq*: DISPLAYCONFIG_RATIONAL
    vSyncFreq*: DISPLAYCONFIG_RATIONAL
    activeSize*: DISPLAYCONFIG_2DREGION
    totalSize*: DISPLAYCONFIG_2DREGION
    videoStandard*: UINT32
    scanLineOrdering*: DISPLAYCONFIG_SCANLINE_ORDERING
  DISPLAYCONFIG_SOURCE_MODE* {.pure.} = object
    width*: UINT32
    height*: UINT32
    pixelFormat*: DISPLAYCONFIG_PIXELFORMAT
    position*: POINTL
  DISPLAYCONFIG_TARGET_MODE* {.pure.} = object
    targetVideoSignalInfo*: DISPLAYCONFIG_VIDEO_SIGNAL_INFO
  DISPLAYCONFIG_MODE_INFO_UNION1* {.pure, union.} = object
    targetMode*: DISPLAYCONFIG_TARGET_MODE
    sourceMode*: DISPLAYCONFIG_SOURCE_MODE
  DISPLAYCONFIG_MODE_INFO* {.pure.} = object
    infoType*: DISPLAYCONFIG_MODE_INFO_TYPE
    id*: UINT32
    adapterId*: LUID
    union1*: DISPLAYCONFIG_MODE_INFO_UNION1
  DISPLAYCONFIG_PATH_SOURCE_INFO* {.pure.} = object
    adapterId*: LUID
    id*: UINT32
    modeInfoIdx*: UINT32
    statusFlags*: UINT32
  DISPLAYCONFIG_PATH_TARGET_INFO* {.pure.} = object
    adapterId*: LUID
    id*: UINT32
    modeInfoIdx*: UINT32
    outputTechnology*: DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY
    rotation*: DISPLAYCONFIG_ROTATION
    scaling*: DISPLAYCONFIG_SCALING
    refreshRate*: DISPLAYCONFIG_RATIONAL
    scanLineOrdering*: DISPLAYCONFIG_SCANLINE_ORDERING
    targetAvailable*: WINBOOL
    statusFlags*: UINT32
  DISPLAYCONFIG_PATH_INFO* {.pure.} = object
    sourceInfo*: DISPLAYCONFIG_PATH_SOURCE_INFO
    targetInfo*: DISPLAYCONFIG_PATH_TARGET_INFO
    flags*: UINT32
  DISPLAYCONFIG_DEVICE_INFO_HEADER* {.pure.} = object
    `type`*: DISPLAYCONFIG_DEVICE_INFO_TYPE
    size*: UINT32
    adapterId*: LUID
    id*: UINT32
  DISPLAYCONFIG_SOURCE_DEVICE_NAME* {.pure.} = object
    header*: DISPLAYCONFIG_DEVICE_INFO_HEADER
    viewGdiDeviceName*: array[CCHDEVICENAME, WCHAR]
  DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS_UNION1_STRUCT1* {.pure.} = object
    friendlyNameFromEdid* {.bitsize:1.}: UINT32
    friendlyNameForced* {.bitsize:1.}: UINT32
    edidIdsValid* {.bitsize:1.}: UINT32
    reserved* {.bitsize:29.}: UINT32
  DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS_UNION1* {.pure, union.} = object
    struct1*: DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS_UNION1_STRUCT1
    value*: UINT32
  DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS* {.pure.} = object
    union1*: DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS_UNION1
  DISPLAYCONFIG_TARGET_DEVICE_NAME* {.pure.} = object
    header*: DISPLAYCONFIG_DEVICE_INFO_HEADER
    flags*: DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS
    outputTechnology*: DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY
    edidManufactureId*: UINT16
    edidProductCodeId*: UINT16
    connectorInstance*: UINT32
    monitorFriendlyDeviceName*: array[64, WCHAR]
    monitorDevicePath*: array[128, WCHAR]
  DISPLAYCONFIG_TARGET_PREFERRED_MODE* {.pure.} = object
    header*: DISPLAYCONFIG_DEVICE_INFO_HEADER
    width*: UINT32
    height*: UINT32
    targetMode*: DISPLAYCONFIG_TARGET_MODE
  DISPLAYCONFIG_ADAPTER_NAME* {.pure.} = object
    header*: DISPLAYCONFIG_DEVICE_INFO_HEADER
    adapterDevicePath*: array[128, WCHAR]
  DISPLAYCONFIG_SET_TARGET_PERSISTENCE_UNION1_STRUCT1* {.pure.} = object
    bootPersistenceOn* {.bitsize:1.}: UINT32
    reserved* {.bitsize:31.}: UINT32
  DISPLAYCONFIG_SET_TARGET_PERSISTENCE_UNION1* {.pure, union.} = object
    struct1*: DISPLAYCONFIG_SET_TARGET_PERSISTENCE_UNION1_STRUCT1
    value*: UINT32
  DISPLAYCONFIG_SET_TARGET_PERSISTENCE* {.pure.} = object
    header*: DISPLAYCONFIG_DEVICE_INFO_HEADER
    union1*: DISPLAYCONFIG_SET_TARGET_PERSISTENCE_UNION1
proc AddFontResourceA*(P1: LPCSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AddFontResourceW*(P1: LPCWSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AnimatePalette*(hPal: HPALETTE, iStartIndex: UINT, cEntries: UINT, ppe: ptr PALETTEENTRY): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc Arc*(hdc: HDC, x1: int32, y1: int32, x2: int32, y2: int32, x3: int32, y3: int32, x4: int32, y4: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc BitBlt*(hdc: HDC, x: int32, y: int32, cx: int32, cy: int32, hdcSrc: HDC, x1: int32, y1: int32, rop: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CancelDC*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc Chord*(hdc: HDC, x1: int32, y1: int32, x2: int32, y2: int32, x3: int32, y3: int32, x4: int32, y4: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ChoosePixelFormat*(hdc: HDC, ppfd: ptr PIXELFORMATDESCRIPTOR): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CloseMetaFile*(hdc: HDC): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CombineRgn*(hrgnDst: HRGN, hrgnSrc1: HRGN, hrgnSrc2: HRGN, iMode: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CopyMetaFileA*(P1: HMETAFILE, P2: LPCSTR): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CopyMetaFileW*(P1: HMETAFILE, P2: LPCWSTR): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateBitmap*(nWidth: int32, nHeight: int32, nPlanes: UINT, nBitCount: UINT, lpBits: pointer): HBITMAP {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateBitmapIndirect*(pbm: ptr BITMAP): HBITMAP {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateBrushIndirect*(plbrush: ptr LOGBRUSH): HBRUSH {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateCompatibleBitmap*(hdc: HDC, cx: int32, cy: int32): HBITMAP {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateDiscardableBitmap*(hdc: HDC, cx: int32, cy: int32): HBITMAP {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateCompatibleDC*(hdc: HDC): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateDCA*(pwszDriver: LPCSTR, pwszDevice: LPCSTR, pszPort: LPCSTR, pdm: ptr DEVMODEA): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateDCW*(pwszDriver: LPCWSTR, pwszDevice: LPCWSTR, pszPort: LPCWSTR, pdm: ptr DEVMODEW): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateDIBitmap*(hdc: HDC, pbmih: ptr BITMAPINFOHEADER, flInit: DWORD, pjBits: pointer, pbmi: ptr BITMAPINFO, iUsage: UINT): HBITMAP {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateDIBPatternBrush*(h: HGLOBAL, iUsage: UINT): HBRUSH {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateDIBPatternBrushPt*(lpPackedDIB: pointer, iUsage: UINT): HBRUSH {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateEllipticRgn*(x1: int32, y1: int32, x2: int32, y2: int32): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateEllipticRgnIndirect*(lprect: ptr RECT): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateFontIndirectA*(lplf: ptr LOGFONTA): HFONT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateFontIndirectW*(lplf: ptr LOGFONTW): HFONT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateFontA*(cHeight: int32, cWidth: int32, cEscapement: int32, cOrientation: int32, cWeight: int32, bItalic: DWORD, bUnderline: DWORD, bStrikeOut: DWORD, iCharSet: DWORD, iOutPrecision: DWORD, iClipPrecision: DWORD, iQuality: DWORD, iPitchAndFamily: DWORD, pszFaceName: LPCSTR): HFONT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateFontW*(cHeight: int32, cWidth: int32, cEscapement: int32, cOrientation: int32, cWeight: int32, bItalic: DWORD, bUnderline: DWORD, bStrikeOut: DWORD, iCharSet: DWORD, iOutPrecision: DWORD, iClipPrecision: DWORD, iQuality: DWORD, iPitchAndFamily: DWORD, pszFaceName: LPCWSTR): HFONT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateHatchBrush*(iHatch: int32, color: COLORREF): HBRUSH {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateICA*(pszDriver: LPCSTR, pszDevice: LPCSTR, pszPort: LPCSTR, pdm: ptr DEVMODEA): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateICW*(pszDriver: LPCWSTR, pszDevice: LPCWSTR, pszPort: LPCWSTR, pdm: ptr DEVMODEW): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateMetaFileA*(pszFile: LPCSTR): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateMetaFileW*(pszFile: LPCWSTR): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreatePalette*(plpal: ptr LOGPALETTE): HPALETTE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreatePen*(iStyle: int32, cWidth: int32, color: COLORREF): HPEN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreatePenIndirect*(plpen: ptr LOGPEN): HPEN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreatePolyPolygonRgn*(pptl: ptr POINT, pc: ptr INT, cPoly: int32, iMode: int32): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreatePatternBrush*(hbm: HBITMAP): HBRUSH {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateRectRgn*(x1: int32, y1: int32, x2: int32, y2: int32): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateRectRgnIndirect*(lprect: ptr RECT): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateRoundRectRgn*(x1: int32, y1: int32, x2: int32, y2: int32, w: int32, h: int32): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateScalableFontResourceA*(fdwHidden: DWORD, lpszFont: LPCSTR, lpszFile: LPCSTR, lpszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateScalableFontResourceW*(fdwHidden: DWORD, lpszFont: LPCWSTR, lpszFile: LPCWSTR, lpszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateSolidBrush*(color: COLORREF): HBRUSH {.winapi, stdcall, dynlib: "gdi32", importc.}
proc DeleteDC*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc DeleteMetaFile*(hmf: HMETAFILE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc DeleteObject*(ho: HGDIOBJ): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc DescribePixelFormat*(hdc: HDC, iPixelFormat: int32, nBytes: UINT, ppfd: LPPIXELFORMATDESCRIPTOR): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc DeviceCapabilitiesA*(pDevice: LPCSTR, pPort: LPCSTR, fwCapability: WORD, pOutput: LPSTR, pDevMode: ptr DEVMODEA): int32 {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeviceCapabilitiesW*(pDevice: LPCWSTR, pPort: LPCWSTR, fwCapability: WORD, pOutput: LPWSTR, pDevMode: ptr DEVMODEW): int32 {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DrawEscape*(hdc: HDC, iEscape: int32, cjIn: int32, lpIn: LPCSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc Ellipse*(hdc: HDC, left: int32, top: int32, right: int32, bottom: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumFontFamiliesExA*(hdc: HDC, lpLogfont: LPLOGFONTA, lpProc: FONTENUMPROCA, lParam: LPARAM, dwFlags: DWORD): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumFontFamiliesExW*(hdc: HDC, lpLogfont: LPLOGFONTW, lpProc: FONTENUMPROCW, lParam: LPARAM, dwFlags: DWORD): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumFontFamiliesA*(hdc: HDC, lpLogfont: LPCSTR, lpProc: FONTENUMPROCA, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumFontFamiliesW*(hdc: HDC, lpLogfont: LPCWSTR, lpProc: FONTENUMPROCW, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumFontsA*(hdc: HDC, lpLogfont: LPCSTR, lpProc: FONTENUMPROCA, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumFontsW*(hdc: HDC, lpLogfont: LPCWSTR, lpProc: FONTENUMPROCW, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumObjects*(hdc: HDC, nType: int32, lpFunc: GOBJENUMPROC, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EqualRgn*(hrgn1: HRGN, hrgn2: HRGN): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc Escape*(hdc: HDC, iEscape: int32, cjIn: int32, pvIn: LPCSTR, pvOut: LPVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ExtEscape*(hdc: HDC, iEscape: int32, cjInput: int32, lpInData: LPCSTR, cjOutput: int32, lpOutData: LPSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ExcludeClipRect*(hdc: HDC, left: int32, top: int32, right: int32, bottom: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ExtCreateRegion*(lpx: ptr XFORM, nCount: DWORD, lpData: ptr RGNDATA): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ExtFloodFill*(hdc: HDC, x: int32, y: int32, color: COLORREF, `type`: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc FillRgn*(hdc: HDC, hrgn: HRGN, hbr: HBRUSH): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc FloodFill*(hdc: HDC, x: int32, y: int32, color: COLORREF): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc FrameRgn*(hdc: HDC, hrgn: HRGN, hbr: HBRUSH, w: int32, h: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetROP2*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetAspectRatioFilterEx*(hdc: HDC, lpsize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetBkColor*(hdc: HDC): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetDCBrushColor*(hdc: HDC): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetDCPenColor*(hdc: HDC): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetBkMode*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetBitmapBits*(hbit: HBITMAP, cb: LONG, lpvBits: LPVOID): LONG {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetBitmapDimensionEx*(hbit: HBITMAP, lpsize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetBoundsRect*(hdc: HDC, lprect: LPRECT, flags: UINT): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetBrushOrgEx*(hdc: HDC, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharWidthA*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharWidthW*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharWidth32A*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharWidth32W*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharWidthFloatA*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: PFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharWidthFloatW*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: PFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharABCWidthsA*(hdc: HDC, wFirst: UINT, wLast: UINT, lpABC: LPABC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharABCWidthsW*(hdc: HDC, wFirst: UINT, wLast: UINT, lpABC: LPABC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharABCWidthsFloatA*(hdc: HDC, iFirst: UINT, iLast: UINT, lpABC: LPABCFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharABCWidthsFloatW*(hdc: HDC, iFirst: UINT, iLast: UINT, lpABC: LPABCFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetClipBox*(hdc: HDC, lprect: LPRECT): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetClipRgn*(hdc: HDC, hrgn: HRGN): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetMetaRgn*(hdc: HDC, hrgn: HRGN): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCurrentObject*(hdc: HDC, `type`: UINT): HGDIOBJ {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCurrentPositionEx*(hdc: HDC, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetDeviceCaps*(hdc: HDC, index: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetDIBits*(hdc: HDC, hbm: HBITMAP, start: UINT, cLines: UINT, lpvBits: LPVOID, lpbmi: LPBITMAPINFO, usage: UINT): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetFontData*(hdc: HDC, dwTable: DWORD, dwOffset: DWORD, pvBuffer: PVOID, cjBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetGlyphOutlineA*(hdc: HDC, uChar: UINT, fuFormat: UINT, lpgm: LPGLYPHMETRICS, cjBuffer: DWORD, pvBuffer: LPVOID, lpmat2: ptr MAT2): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetGlyphOutlineW*(hdc: HDC, uChar: UINT, fuFormat: UINT, lpgm: LPGLYPHMETRICS, cjBuffer: DWORD, pvBuffer: LPVOID, lpmat2: ptr MAT2): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetGraphicsMode*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetMapMode*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetMetaFileBitsEx*(hMF: HMETAFILE, cbBuffer: UINT, lpData: LPVOID): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetMetaFileA*(lpName: LPCSTR): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetMetaFileW*(lpName: LPCWSTR): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetNearestColor*(hdc: HDC, color: COLORREF): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetNearestPaletteIndex*(h: HPALETTE, color: COLORREF): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetObjectType*(h: HGDIOBJ): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetOutlineTextMetricsA*(hdc: HDC, cjCopy: UINT, potm: LPOUTLINETEXTMETRICA): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetOutlineTextMetricsW*(hdc: HDC, cjCopy: UINT, potm: LPOUTLINETEXTMETRICW): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetPaletteEntries*(hpal: HPALETTE, iStart: UINT, cEntries: UINT, pPalEntries: LPPALETTEENTRY): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetPixel*(hdc: HDC, x: int32, y: int32): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetPixelFormat*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetPolyFillMode*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetRasterizerCaps*(lpraststat: LPRASTERIZER_STATUS, cjBytes: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetRandomRgn*(hdc: HDC, hrgn: HRGN, i: INT): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetRegionData*(hrgn: HRGN, nCount: DWORD, lpRgnData: LPRGNDATA): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetRgnBox*(hrgn: HRGN, lprc: LPRECT): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetStockObject*(i: int32): HGDIOBJ {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetStretchBltMode*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetSystemPaletteEntries*(hdc: HDC, iStart: UINT, cEntries: UINT, pPalEntries: LPPALETTEENTRY): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetSystemPaletteUse*(hdc: HDC): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextCharacterExtra*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextAlign*(hdc: HDC): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextColor*(hdc: HDC): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextExtentPointA*(hdc: HDC, lpString: LPCSTR, c: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextExtentPointW*(hdc: HDC, lpString: LPCWSTR, c: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextExtentPoint32A*(hdc: HDC, lpString: LPCSTR, c: int32, psizl: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextExtentPoint32W*(hdc: HDC, lpString: LPCWSTR, c: int32, psizl: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextExtentExPointA*(hdc: HDC, lpszString: LPCSTR, cchString: int32, nMaxExtent: int32, lpnFit: LPINT, lpnDx: LPINT, lpSize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextExtentExPointW*(hdc: HDC, lpszString: LPCWSTR, cchString: int32, nMaxExtent: int32, lpnFit: LPINT, lpnDx: LPINT, lpSize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextCharset*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextCharsetInfo*(hdc: HDC, lpSig: LPFONTSIGNATURE, dwFlags: DWORD): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc TranslateCharsetInfo*(lpSrc: ptr DWORD, lpCs: LPCHARSETINFO, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetFontLanguageInfo*(hdc: HDC): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharacterPlacementA*(hdc: HDC, lpString: LPCSTR, nCount: int32, nMexExtent: int32, lpResults: LPGCP_RESULTSA, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharacterPlacementW*(hdc: HDC, lpString: LPCWSTR, nCount: int32, nMexExtent: int32, lpResults: LPGCP_RESULTSW, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetFontUnicodeRanges*(hdc: HDC, lpgs: LPGLYPHSET): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetGlyphIndicesA*(hdc: HDC, lpstr: LPCSTR, c: int32, pgi: LPWORD, fl: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetGlyphIndicesW*(hdc: HDC, lpstr: LPCWSTR, c: int32, pgi: LPWORD, fl: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextExtentPointI*(hdc: HDC, pgiIn: LPWORD, cgi: int32, psize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextExtentExPointI*(hdc: HDC, lpwszString: LPWORD, cwchString: int32, nMaxExtent: int32, lpnFit: LPINT, lpnDx: LPINT, lpSize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharWidthI*(hdc: HDC, giFirst: UINT, cgi: UINT, pgi: LPWORD, piWidths: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetCharABCWidthsI*(hdc: HDC, giFirst: UINT, cgi: UINT, pgi: LPWORD, pabc: LPABC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AddFontResourceExA*(name: LPCSTR, fl: DWORD, res: PVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AddFontResourceExW*(name: LPCWSTR, fl: DWORD, res: PVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RemoveFontResourceExA*(name: LPCSTR, fl: DWORD, pdv: PVOID): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RemoveFontResourceExW*(name: LPCWSTR, fl: DWORD, pdv: PVOID): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AddFontMemResourceEx*(pFileView: PVOID, cjSize: DWORD, pvResrved: PVOID, pNumFonts: ptr DWORD): HANDLE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RemoveFontMemResourceEx*(h: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateFontIndirectExA*(P1: ptr ENUMLOGFONTEXDVA): HFONT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateFontIndirectExW*(P1: ptr ENUMLOGFONTEXDVW): HFONT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetViewportExtEx*(hdc: HDC, lpsize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetViewportOrgEx*(hdc: HDC, lppoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetWindowExtEx*(hdc: HDC, lpsize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetWindowOrgEx*(hdc: HDC, lppoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc IntersectClipRect*(hdc: HDC, left: int32, top: int32, right: int32, bottom: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc InvertRgn*(hdc: HDC, hrgn: HRGN): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc LineDDA*(xStart: int32, yStart: int32, xEnd: int32, yEnd: int32, lpProc: LINEDDAPROC, data: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc LineTo*(hdc: HDC, x: int32, y: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc MaskBlt*(hdcDest: HDC, xDest: int32, yDest: int32, width: int32, height: int32, hdcSrc: HDC, xSrc: int32, ySrc: int32, hbmMask: HBITMAP, xMask: int32, yMask: int32, rop: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PlgBlt*(hdcDest: HDC, lpPoint: ptr POINT, hdcSrc: HDC, xSrc: int32, ySrc: int32, width: int32, height: int32, hbmMask: HBITMAP, xMask: int32, yMask: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc OffsetClipRgn*(hdc: HDC, x: int32, y: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc OffsetRgn*(hrgn: HRGN, x: int32, y: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PatBlt*(hdc: HDC, x: int32, y: int32, w: int32, h: int32, rop: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc Pie*(hdc: HDC, left: int32, top: int32, right: int32, bottom: int32, xr1: int32, yr1: int32, xr2: int32, yr2: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PlayMetaFile*(hdc: HDC, hmf: HMETAFILE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PaintRgn*(hdc: HDC, hrgn: HRGN): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PolyPolygon*(hdc: HDC, apt: ptr POINT, asz: ptr INT, csz: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PtInRegion*(hrgn: HRGN, x: int32, y: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PtVisible*(hdc: HDC, x: int32, y: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RectInRegion*(hrgn: HRGN, lprect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RectVisible*(hdc: HDC, lprect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc Rectangle*(hdc: HDC, left: int32, top: int32, right: int32, bottom: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RestoreDC*(hdc: HDC, nSavedDC: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ResetDCA*(hdc: HDC, lpdm: ptr DEVMODEA): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ResetDCW*(hdc: HDC, lpdm: ptr DEVMODEW): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RealizePalette*(hdc: HDC): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RemoveFontResourceA*(lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RemoveFontResourceW*(lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc RoundRect*(hdc: HDC, left: int32, top: int32, right: int32, bottom: int32, width: int32, height: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ResizePalette*(hpal: HPALETTE, n: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SaveDC*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SelectClipRgn*(hdc: HDC, hrgn: HRGN): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ExtSelectClipRgn*(hdc: HDC, hrgn: HRGN, mode: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetMetaRgn*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SelectObject*(hdc: HDC, h: HGDIOBJ): HGDIOBJ {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SelectPalette*(hdc: HDC, hPal: HPALETTE, bForceBkgd: WINBOOL): HPALETTE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetBkColor*(hdc: HDC, color: COLORREF): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetDCBrushColor*(hdc: HDC, color: COLORREF): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetDCPenColor*(hdc: HDC, color: COLORREF): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetBkMode*(hdc: HDC, mode: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetBitmapBits*(hbm: HBITMAP, cb: DWORD, pvBits: pointer): LONG {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetBoundsRect*(hdc: HDC, lprect: ptr RECT, flags: UINT): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetDIBits*(hdc: HDC, hbm: HBITMAP, start: UINT, cLines: UINT, lpBits: pointer, lpbmi: ptr BITMAPINFO, ColorUse: UINT): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetDIBitsToDevice*(hdc: HDC, xDest: int32, yDest: int32, w: DWORD, h: DWORD, xSrc: int32, ySrc: int32, StartScan: UINT, cLines: UINT, lpvBits: pointer, lpbmi: ptr BITMAPINFO, ColorUse: UINT): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetMapperFlags*(hdc: HDC, flags: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetGraphicsMode*(hdc: HDC, iMode: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetMapMode*(hdc: HDC, iMode: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetLayout*(hdc: HDC, l: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetLayout*(hdc: HDC): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetMetaFileBitsEx*(cbBuffer: UINT, lpData: ptr BYTE): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetPaletteEntries*(hpal: HPALETTE, iStart: UINT, cEntries: UINT, pPalEntries: ptr PALETTEENTRY): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetPixel*(hdc: HDC, x: int32, y: int32, color: COLORREF): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetPixelV*(hdc: HDC, x: int32, y: int32, color: COLORREF): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetPixelFormat*(hdc: HDC, format: int32, ppfd: ptr PIXELFORMATDESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetPolyFillMode*(hdc: HDC, mode: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc StretchBlt*(hdcDest: HDC, xDest: int32, yDest: int32, wDest: int32, hDest: int32, hdcSrc: HDC, xSrc: int32, ySrc: int32, wSrc: int32, hSrc: int32, rop: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetRectRgn*(hrgn: HRGN, left: int32, top: int32, right: int32, bottom: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc StretchDIBits*(hdc: HDC, xDest: int32, yDest: int32, DestWidth: int32, DestHeight: int32, xSrc: int32, ySrc: int32, SrcWidth: int32, SrcHeight: int32, lpBits: pointer, lpbmi: ptr BITMAPINFO, iUsage: UINT, rop: DWORD): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetROP2*(hdc: HDC, rop2: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetStretchBltMode*(hdc: HDC, mode: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetSystemPaletteUse*(hdc: HDC, use: UINT): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetTextCharacterExtra*(hdc: HDC, extra: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetTextColor*(hdc: HDC, color: COLORREF): COLORREF {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetTextAlign*(hdc: HDC, align: UINT): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetTextJustification*(hdc: HDC, extra: int32, count: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc UpdateColors*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AlphaBlend*(hdcDest: HDC, xoriginDest: int32, yoriginDest: int32, wDest: int32, hDest: int32, hdcSrc: HDC, xoriginSrc: int32, yoriginSrc: int32, wSrc: int32, hSrc: int32, ftn: BLENDFUNCTION): WINBOOL {.winapi, stdcall, dynlib: "msimg32", importc.}
proc GdiAlphaBlend*(hdcDest: HDC, xoriginDest: int32, yoriginDest: int32, wDest: int32, hDest: int32, hdcSrc: HDC, xoriginSrc: int32, yoriginSrc: int32, wSrc: int32, hSrc: int32, ftn: BLENDFUNCTION): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc TransparentBlt*(hdcDest: HDC, xoriginDest: int32, yoriginDest: int32, wDest: int32, hDest: int32, hdcSrc: HDC, xoriginSrc: int32, yoriginSrc: int32, wSrc: int32, hSrc: int32, crTransparent: UINT): WINBOOL {.winapi, stdcall, dynlib: "msimg32", importc.}
proc GdiTransparentBlt*(hdcDest: HDC, xoriginDest: int32, yoriginDest: int32, wDest: int32, hDest: int32, hdcSrc: HDC, xoriginSrc: int32, yoriginSrc: int32, wSrc: int32, hSrc: int32, crTransparent: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GradientFill*(hdc: HDC, pVertex: PTRIVERTEX, nVertex: ULONG, pMesh: PVOID, nMesh: ULONG, ulMode: ULONG): WINBOOL {.winapi, stdcall, dynlib: "msimg32", importc.}
proc GdiGradientFill*(hdc: HDC, pVertex: PTRIVERTEX, nVertex: ULONG, pMesh: PVOID, nMesh: ULONG, ulMode: ULONG): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PlayMetaFileRecord*(hdc: HDC, lpHandleTable: LPHANDLETABLE, lpMR: LPMETARECORD, noObjs: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumMetaFile*(hdc: HDC, hmf: HMETAFILE, lpProc: MFENUMPROC, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CloseEnhMetaFile*(hdc: HDC): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CopyEnhMetaFileA*(hEnh: HENHMETAFILE, lpFileName: LPCSTR): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CopyEnhMetaFileW*(hEnh: HENHMETAFILE, lpFileName: LPCWSTR): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateEnhMetaFileA*(hdc: HDC, lpFilename: LPCSTR, lprc: ptr RECT, lpDesc: LPCSTR): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateEnhMetaFileW*(hdc: HDC, lpFilename: LPCWSTR, lprc: ptr RECT, lpDesc: LPCWSTR): HDC {.winapi, stdcall, dynlib: "gdi32", importc.}
proc DeleteEnhMetaFile*(hmf: HENHMETAFILE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumEnhMetaFile*(hdc: HDC, hmf: HENHMETAFILE, lpProc: ENHMFENUMPROC, lpParam: LPVOID, lpRect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetEnhMetaFileA*(lpName: LPCSTR): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetEnhMetaFileW*(lpName: LPCWSTR): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetEnhMetaFileBits*(hEMF: HENHMETAFILE, nSize: UINT, lpData: LPBYTE): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetEnhMetaFileDescriptionA*(hemf: HENHMETAFILE, cchBuffer: UINT, lpDescription: LPSTR): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetEnhMetaFileDescriptionW*(hemf: HENHMETAFILE, cchBuffer: UINT, lpDescription: LPWSTR): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetEnhMetaFileHeader*(hemf: HENHMETAFILE, nSize: UINT, lpEnhMetaHeader: LPENHMETAHEADER): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetEnhMetaFilePaletteEntries*(hemf: HENHMETAFILE, nNumEntries: UINT, lpPaletteEntries: LPPALETTEENTRY): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetEnhMetaFilePixelFormat*(hemf: HENHMETAFILE, cbBuffer: UINT, ppfd: ptr PIXELFORMATDESCRIPTOR): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetWinMetaFileBits*(hemf: HENHMETAFILE, cbData16: UINT, pData16: LPBYTE, iMapMode: INT, hdcRef: HDC): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PlayEnhMetaFile*(hdc: HDC, hmf: HENHMETAFILE, lprect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PlayEnhMetaFileRecord*(hdc: HDC, pht: LPHANDLETABLE, pmr: ptr ENHMETARECORD, cht: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetEnhMetaFileBits*(nSize: UINT, pb: ptr BYTE): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetWinMetaFileBits*(nSize: UINT, lpMeta16Data: ptr BYTE, hdcRef: HDC, lpMFP: ptr METAFILEPICT): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GdiComment*(hdc: HDC, nSize: UINT, lpData: ptr BYTE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextMetricsA*(hdc: HDC, lptm: LPTEXTMETRICA): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextMetricsW*(hdc: HDC, lptm: LPTEXTMETRICW): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AngleArc*(hdc: HDC, x: int32, y: int32, r: DWORD, StartAngle: FLOAT, SweepAngle: FLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PolyPolyline*(hdc: HDC, apt: ptr POINT, asz: ptr DWORD, csz: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetWorldTransform*(hdc: HDC, lpxf: LPXFORM): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetWorldTransform*(hdc: HDC, lpxf: ptr XFORM): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ModifyWorldTransform*(hdc: HDC, lpxf: ptr XFORM, mode: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CombineTransform*(lpxfOut: LPXFORM, lpxf1: ptr XFORM, lpxf2: ptr XFORM): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateDIBSection*(hdc: HDC, lpbmi: ptr BITMAPINFO, usage: UINT, ppvBits: ptr pointer, hSection: HANDLE, offset: DWORD): HBITMAP {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetDIBColorTable*(hdc: HDC, iStart: UINT, cEntries: UINT, prgbq: ptr RGBQUAD): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetDIBColorTable*(hdc: HDC, iStart: UINT, cEntries: UINT, prgbq: ptr RGBQUAD): UINT {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetColorAdjustment*(hdc: HDC, lpca: ptr COLORADJUSTMENT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetColorAdjustment*(hdc: HDC, lpca: LPCOLORADJUSTMENT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateHalftonePalette*(hdc: HDC): HPALETTE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc StartDocA*(hdc: HDC, lpdi: ptr DOCINFOA): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc StartDocW*(hdc: HDC, lpdi: ptr DOCINFOW): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EndDoc*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc StartPage*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EndPage*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AbortDoc*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetAbortProc*(hdc: HDC, lpProc: ABORTPROC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc AbortPath*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ArcTo*(hdc: HDC, left: int32, top: int32, right: int32, bottom: int32, xr1: int32, yr1: int32, xr2: int32, yr2: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc BeginPath*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CloseFigure*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EndPath*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc FillPath*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc FlattenPath*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetPath*(hdc: HDC, apt: LPPOINT, aj: LPBYTE, cpt: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PathToRegion*(hdc: HDC): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PolyDraw*(hdc: HDC, apt: ptr POINT, aj: ptr BYTE, cpt: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SelectClipPath*(hdc: HDC, mode: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetArcDirection*(hdc: HDC, dir: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetMiterLimit*(hdc: HDC, limit: FLOAT, old: PFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc StrokeAndFillPath*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc StrokePath*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc WidenPath*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ExtCreatePen*(iPenStyle: DWORD, cWidth: DWORD, plbrush: ptr LOGBRUSH, cStyle: DWORD, pstyle: ptr DWORD): HPEN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetMiterLimit*(hdc: HDC, plimit: PFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetArcDirection*(hdc: HDC): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetObjectA*(h: HANDLE, c: int32, pv: LPVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetObjectW*(h: HANDLE, c: int32, pv: LPVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc MoveToEx*(hdc: HDC, x: int32, y: int32, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc TextOutA*(hdc: HDC, x: int32, y: int32, lpString: LPCSTR, c: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc TextOutW*(hdc: HDC, x: int32, y: int32, lpString: LPCWSTR, c: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ExtTextOutA*(hdc: HDC, x: int32, y: int32, options: UINT, lprect: ptr RECT, lpString: LPCSTR, c: UINT, lpDx: ptr INT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ExtTextOutW*(hdc: HDC, x: int32, y: int32, options: UINT, lprect: ptr RECT, lpString: LPCWSTR, c: UINT, lpDx: ptr INT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PolyTextOutA*(hdc: HDC, ppt: ptr POLYTEXTA, nstrings: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PolyTextOutW*(hdc: HDC, ppt: ptr POLYTEXTW, nstrings: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreatePolygonRgn*(pptl: ptr POINT, cPoint: int32, iMode: int32): HRGN {.winapi, stdcall, dynlib: "gdi32", importc.}
proc DPtoLP*(hdc: HDC, lppt: LPPOINT, c: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc LPtoDP*(hdc: HDC, lppt: LPPOINT, c: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc Polygon*(hdc: HDC, apt: ptr POINT, cpt: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc Polyline*(hdc: HDC, apt: ptr POINT, cpt: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PolyBezier*(hdc: HDC, apt: ptr POINT, cpt: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PolyBezierTo*(hdc: HDC, apt: ptr POINT, cpt: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc PolylineTo*(hdc: HDC, apt: ptr POINT, cpt: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetViewportExtEx*(hdc: HDC, x: int32, y: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetViewportOrgEx*(hdc: HDC, x: int32, y: int32, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetWindowExtEx*(hdc: HDC, x: int32, y: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetWindowOrgEx*(hdc: HDC, x: int32, y: int32, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc OffsetViewportOrgEx*(hdc: HDC, x: int32, y: int32, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc OffsetWindowOrgEx*(hdc: HDC, x: int32, y: int32, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ScaleViewportExtEx*(hdc: HDC, xn: int32, dx: int32, yn: int32, yd: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ScaleWindowExtEx*(hdc: HDC, xn: int32, xd: int32, yn: int32, yd: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetBitmapDimensionEx*(hbm: HBITMAP, w: int32, h: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetBrushOrgEx*(hdc: HDC, x: int32, y: int32, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextFaceA*(hdc: HDC, c: int32, lpName: LPSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetTextFaceW*(hdc: HDC, c: int32, lpName: LPWSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetKerningPairsA*(hdc: HDC, nPairs: DWORD, lpKernPair: LPKERNINGPAIR): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetKerningPairsW*(hdc: HDC, nPairs: DWORD, lpKernPair: LPKERNINGPAIR): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetDCOrgEx*(hdc: HDC, lppt: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc FixBrushOrgEx*(hdc: HDC, x: int32, y: int32, ptl: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc UnrealizeObject*(h: HGDIOBJ): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GdiFlush*(): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GdiSetBatchLimit*(dw: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GdiGetBatchLimit*(): DWORD {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetICMMode*(hdc: HDC, mode: int32): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CheckColorsInGamut*(hdc: HDC, lpRGBTriple: LPVOID, dlpBuffer: LPVOID, nCount: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetColorSpace*(hdc: HDC): HCOLORSPACE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetLogColorSpaceA*(hColorSpace: HCOLORSPACE, lpBuffer: LPLOGCOLORSPACEA, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetLogColorSpaceW*(hColorSpace: HCOLORSPACE, lpBuffer: LPLOGCOLORSPACEW, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateColorSpaceA*(lplcs: LPLOGCOLORSPACEA): HCOLORSPACE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc CreateColorSpaceW*(lplcs: LPLOGCOLORSPACEW): HCOLORSPACE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetColorSpace*(hdc: HDC, hcs: HCOLORSPACE): HCOLORSPACE {.winapi, stdcall, dynlib: "gdi32", importc.}
proc DeleteColorSpace*(hcs: HCOLORSPACE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetICMProfileA*(hdc: HDC, pBufSize: LPDWORD, pszFilename: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetICMProfileW*(hdc: HDC, pBufSize: LPDWORD, pszFilename: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetICMProfileA*(hdc: HDC, lpFileName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetICMProfileW*(hdc: HDC, lpFileName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc GetDeviceGammaRamp*(hdc: HDC, lpRamp: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc SetDeviceGammaRamp*(hdc: HDC, lpRamp: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ColorMatchToTarget*(hdc: HDC, hdcTarget: HDC, action: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumICMProfilesA*(hdc: HDC, lpProc: ICMENUMPROCA, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc EnumICMProfilesW*(hdc: HDC, lpProc: ICMENUMPROCW, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc.}
proc UpdateICMRegKeyA*(reserved: DWORD, lpszCMID: LPSTR, lpszFileName: LPSTR, command: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc UpdateICMRegKeyW*(reserved: DWORD, lpszCMID: LPWSTR, lpszFileName: LPWSTR, command: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc ColorCorrectPalette*(hdc: HDC, hPal: HPALETTE, deFirst: DWORD, num: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc wglCopyContext*(P1: HGLRC, P2: HGLRC, P3: UINT): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglCreateContext*(P1: HDC): HGLRC {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglCreateLayerContext*(P1: HDC, P2: int32): HGLRC {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglDeleteContext*(P1: HGLRC): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglGetCurrentContext*(): HGLRC {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglGetCurrentDC*(): HDC {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglGetProcAddress*(P1: LPCSTR): PROC {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglMakeCurrent*(P1: HDC, P2: HGLRC): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglShareLists*(P1: HGLRC, P2: HGLRC): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglUseFontBitmapsA*(P1: HDC, P2: DWORD, P3: DWORD, P4: DWORD): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglUseFontBitmapsW*(P1: HDC, P2: DWORD, P3: DWORD, P4: DWORD): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc SwapBuffers*(P1: HDC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc.}
proc wglUseFontOutlinesA*(P1: HDC, P2: DWORD, P3: DWORD, P4: DWORD, P5: FLOAT, P6: FLOAT, P7: int32, P8: LPGLYPHMETRICSFLOAT): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglUseFontOutlinesW*(P1: HDC, P2: DWORD, P3: DWORD, P4: DWORD, P5: FLOAT, P6: FLOAT, P7: int32, P8: LPGLYPHMETRICSFLOAT): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglDescribeLayerPlane*(P1: HDC, P2: int32, P3: int32, P4: UINT, P5: LPLAYERPLANEDESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglSetLayerPaletteEntries*(P1: HDC, P2: int32, P3: int32, P4: int32, P5: ptr COLORREF): int32 {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglGetLayerPaletteEntries*(P1: HDC, P2: int32, P3: int32, P4: int32, P5: ptr COLORREF): int32 {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglRealizeLayerPalette*(P1: HDC, P2: int32, P3: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglSwapLayerBuffers*(P1: HDC, P2: UINT): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc.}
proc wglSwapMultipleBuffers*(P1: UINT, P2: ptr WGLSWAP): DWORD {.winapi, stdcall, dynlib: "opengl32", importc.}
template MAKEROP4*(fore: untyped, back: untyped): DWORD = DWORD((back shl 8) and 0xff000000) or DWORD(fore)
template GetCValue*(cmyk: untyped): BYTE = BYTE((cmyk shr 24) and 0xff)
template GetMValue*(cmyk: untyped): BYTE = BYTE((cmyk shr 16) and 0xff)
template GetYValue*(cmyk: untyped): BYTE = BYTE((cmyk shr 8) and 0xff)
template GetKValue*(cmyk: untyped): BYTE = BYTE((cmyk) and 0xff)
template CMYK*(c: untyped, m: untyped, y: untyped, k: untyped): COLORREF = COLORREF(COLORREF(k) or COLORREF(y shl 8) or COLORREF(m shl 16) or COLORREF(c shl 24))
template MAKEPOINTS*(l: untyped): POINTS = POINTS(x: SHORT(l and 0xffff), y: SHORT(l shr 16 and 0xffff))
template RGB*(r: untyped, g: untyped, b: untyped): COLORREF = COLORREF(COLORREF(r and 0xff) or (COLORREF(g and 0xff) shl 8) or (COLORREF(b and 0xff) shl 16))
template PALETTERGB*(r: untyped, g: untyped, b: untyped): COLORREF = COLORREF(RGB(r, g, b) or 0x02000000)
template GetRValue*(c: untyped): BYTE = BYTE((c) and 0xff)
template GetGValue*(c: untyped): BYTE = BYTE((c shr 8) and 0xff)
template GetBValue*(c: untyped): BYTE = BYTE((c shr 16) and 0xff)
template PALETTEINDEX*(i: untyped): COLORREF = COLORREF(i and 0xff) or 0x01000000
proc `dmOrientation=`*(self: var DEVMODEA, x: int16) {.inline.} = self.union1.struct1.dmOrientation = x
proc dmOrientation*(self: DEVMODEA): int16 {.inline.} = self.union1.struct1.dmOrientation
proc dmOrientation*(self: var DEVMODEA): var int16 {.inline.} = self.union1.struct1.dmOrientation
proc `dmPaperSize=`*(self: var DEVMODEA, x: int16) {.inline.} = self.union1.struct1.dmPaperSize = x
proc dmPaperSize*(self: DEVMODEA): int16 {.inline.} = self.union1.struct1.dmPaperSize
proc dmPaperSize*(self: var DEVMODEA): var int16 {.inline.} = self.union1.struct1.dmPaperSize
proc `dmPaperLength=`*(self: var DEVMODEA, x: int16) {.inline.} = self.union1.struct1.dmPaperLength = x
proc dmPaperLength*(self: DEVMODEA): int16 {.inline.} = self.union1.struct1.dmPaperLength
proc dmPaperLength*(self: var DEVMODEA): var int16 {.inline.} = self.union1.struct1.dmPaperLength
proc `dmPaperWidth=`*(self: var DEVMODEA, x: int16) {.inline.} = self.union1.struct1.dmPaperWidth = x
proc dmPaperWidth*(self: DEVMODEA): int16 {.inline.} = self.union1.struct1.dmPaperWidth
proc dmPaperWidth*(self: var DEVMODEA): var int16 {.inline.} = self.union1.struct1.dmPaperWidth
proc `dmScale=`*(self: var DEVMODEA, x: int16) {.inline.} = self.union1.struct1.dmScale = x
proc dmScale*(self: DEVMODEA): int16 {.inline.} = self.union1.struct1.dmScale
proc dmScale*(self: var DEVMODEA): var int16 {.inline.} = self.union1.struct1.dmScale
proc `dmCopies=`*(self: var DEVMODEA, x: int16) {.inline.} = self.union1.struct1.dmCopies = x
proc dmCopies*(self: DEVMODEA): int16 {.inline.} = self.union1.struct1.dmCopies
proc dmCopies*(self: var DEVMODEA): var int16 {.inline.} = self.union1.struct1.dmCopies
proc `dmDefaultSource=`*(self: var DEVMODEA, x: int16) {.inline.} = self.union1.struct1.dmDefaultSource = x
proc dmDefaultSource*(self: DEVMODEA): int16 {.inline.} = self.union1.struct1.dmDefaultSource
proc dmDefaultSource*(self: var DEVMODEA): var int16 {.inline.} = self.union1.struct1.dmDefaultSource
proc `dmPrintQuality=`*(self: var DEVMODEA, x: int16) {.inline.} = self.union1.struct1.dmPrintQuality = x
proc dmPrintQuality*(self: DEVMODEA): int16 {.inline.} = self.union1.struct1.dmPrintQuality
proc dmPrintQuality*(self: var DEVMODEA): var int16 {.inline.} = self.union1.struct1.dmPrintQuality
proc `dmPosition=`*(self: var DEVMODEA, x: POINTL) {.inline.} = self.union1.struct2.dmPosition = x
proc dmPosition*(self: DEVMODEA): POINTL {.inline.} = self.union1.struct2.dmPosition
proc dmPosition*(self: var DEVMODEA): var POINTL {.inline.} = self.union1.struct2.dmPosition
proc `dmDisplayOrientation=`*(self: var DEVMODEA, x: DWORD) {.inline.} = self.union1.struct2.dmDisplayOrientation = x
proc dmDisplayOrientation*(self: DEVMODEA): DWORD {.inline.} = self.union1.struct2.dmDisplayOrientation
proc dmDisplayOrientation*(self: var DEVMODEA): var DWORD {.inline.} = self.union1.struct2.dmDisplayOrientation
proc `dmDisplayFixedOutput=`*(self: var DEVMODEA, x: DWORD) {.inline.} = self.union1.struct2.dmDisplayFixedOutput = x
proc dmDisplayFixedOutput*(self: DEVMODEA): DWORD {.inline.} = self.union1.struct2.dmDisplayFixedOutput
proc dmDisplayFixedOutput*(self: var DEVMODEA): var DWORD {.inline.} = self.union1.struct2.dmDisplayFixedOutput
proc `dmDisplayFlags=`*(self: var DEVMODEA, x: DWORD) {.inline.} = self.union2.dmDisplayFlags = x
proc dmDisplayFlags*(self: DEVMODEA): DWORD {.inline.} = self.union2.dmDisplayFlags
proc dmDisplayFlags*(self: var DEVMODEA): var DWORD {.inline.} = self.union2.dmDisplayFlags
proc `dmNup=`*(self: var DEVMODEA, x: DWORD) {.inline.} = self.union2.dmNup = x
proc dmNup*(self: DEVMODEA): DWORD {.inline.} = self.union2.dmNup
proc dmNup*(self: var DEVMODEA): var DWORD {.inline.} = self.union2.dmNup
proc `dmOrientation=`*(self: var DEVMODEW, x: int16) {.inline.} = self.union1.struct1.dmOrientation = x
proc dmOrientation*(self: DEVMODEW): int16 {.inline.} = self.union1.struct1.dmOrientation
proc dmOrientation*(self: var DEVMODEW): var int16 {.inline.} = self.union1.struct1.dmOrientation
proc `dmPaperSize=`*(self: var DEVMODEW, x: int16) {.inline.} = self.union1.struct1.dmPaperSize = x
proc dmPaperSize*(self: DEVMODEW): int16 {.inline.} = self.union1.struct1.dmPaperSize
proc dmPaperSize*(self: var DEVMODEW): var int16 {.inline.} = self.union1.struct1.dmPaperSize
proc `dmPaperLength=`*(self: var DEVMODEW, x: int16) {.inline.} = self.union1.struct1.dmPaperLength = x
proc dmPaperLength*(self: DEVMODEW): int16 {.inline.} = self.union1.struct1.dmPaperLength
proc dmPaperLength*(self: var DEVMODEW): var int16 {.inline.} = self.union1.struct1.dmPaperLength
proc `dmPaperWidth=`*(self: var DEVMODEW, x: int16) {.inline.} = self.union1.struct1.dmPaperWidth = x
proc dmPaperWidth*(self: DEVMODEW): int16 {.inline.} = self.union1.struct1.dmPaperWidth
proc dmPaperWidth*(self: var DEVMODEW): var int16 {.inline.} = self.union1.struct1.dmPaperWidth
proc `dmScale=`*(self: var DEVMODEW, x: int16) {.inline.} = self.union1.struct1.dmScale = x
proc dmScale*(self: DEVMODEW): int16 {.inline.} = self.union1.struct1.dmScale
proc dmScale*(self: var DEVMODEW): var int16 {.inline.} = self.union1.struct1.dmScale
proc `dmCopies=`*(self: var DEVMODEW, x: int16) {.inline.} = self.union1.struct1.dmCopies = x
proc dmCopies*(self: DEVMODEW): int16 {.inline.} = self.union1.struct1.dmCopies
proc dmCopies*(self: var DEVMODEW): var int16 {.inline.} = self.union1.struct1.dmCopies
proc `dmDefaultSource=`*(self: var DEVMODEW, x: int16) {.inline.} = self.union1.struct1.dmDefaultSource = x
proc dmDefaultSource*(self: DEVMODEW): int16 {.inline.} = self.union1.struct1.dmDefaultSource
proc dmDefaultSource*(self: var DEVMODEW): var int16 {.inline.} = self.union1.struct1.dmDefaultSource
proc `dmPrintQuality=`*(self: var DEVMODEW, x: int16) {.inline.} = self.union1.struct1.dmPrintQuality = x
proc dmPrintQuality*(self: DEVMODEW): int16 {.inline.} = self.union1.struct1.dmPrintQuality
proc dmPrintQuality*(self: var DEVMODEW): var int16 {.inline.} = self.union1.struct1.dmPrintQuality
proc `dmPosition=`*(self: var DEVMODEW, x: POINTL) {.inline.} = self.union1.struct2.dmPosition = x
proc dmPosition*(self: DEVMODEW): POINTL {.inline.} = self.union1.struct2.dmPosition
proc dmPosition*(self: var DEVMODEW): var POINTL {.inline.} = self.union1.struct2.dmPosition
proc `dmDisplayOrientation=`*(self: var DEVMODEW, x: DWORD) {.inline.} = self.union1.struct2.dmDisplayOrientation = x
proc dmDisplayOrientation*(self: DEVMODEW): DWORD {.inline.} = self.union1.struct2.dmDisplayOrientation
proc dmDisplayOrientation*(self: var DEVMODEW): var DWORD {.inline.} = self.union1.struct2.dmDisplayOrientation
proc `dmDisplayFixedOutput=`*(self: var DEVMODEW, x: DWORD) {.inline.} = self.union1.struct2.dmDisplayFixedOutput = x
proc dmDisplayFixedOutput*(self: DEVMODEW): DWORD {.inline.} = self.union1.struct2.dmDisplayFixedOutput
proc dmDisplayFixedOutput*(self: var DEVMODEW): var DWORD {.inline.} = self.union1.struct2.dmDisplayFixedOutput
proc `dmDisplayFlags=`*(self: var DEVMODEW, x: DWORD) {.inline.} = self.union2.dmDisplayFlags = x
proc dmDisplayFlags*(self: DEVMODEW): DWORD {.inline.} = self.union2.dmDisplayFlags
proc dmDisplayFlags*(self: var DEVMODEW): var DWORD {.inline.} = self.union2.dmDisplayFlags
proc `dmNup=`*(self: var DEVMODEW, x: DWORD) {.inline.} = self.union2.dmNup = x
proc dmNup*(self: DEVMODEW): DWORD {.inline.} = self.union2.dmNup
proc dmNup*(self: var DEVMODEW): var DWORD {.inline.} = self.union2.dmNup
proc `targetMode=`*(self: var DISPLAYCONFIG_MODE_INFO, x: DISPLAYCONFIG_TARGET_MODE) {.inline.} = self.union1.targetMode = x
proc targetMode*(self: DISPLAYCONFIG_MODE_INFO): DISPLAYCONFIG_TARGET_MODE {.inline.} = self.union1.targetMode
proc targetMode*(self: var DISPLAYCONFIG_MODE_INFO): var DISPLAYCONFIG_TARGET_MODE {.inline.} = self.union1.targetMode
proc `sourceMode=`*(self: var DISPLAYCONFIG_MODE_INFO, x: DISPLAYCONFIG_SOURCE_MODE) {.inline.} = self.union1.sourceMode = x
proc sourceMode*(self: DISPLAYCONFIG_MODE_INFO): DISPLAYCONFIG_SOURCE_MODE {.inline.} = self.union1.sourceMode
proc sourceMode*(self: var DISPLAYCONFIG_MODE_INFO): var DISPLAYCONFIG_SOURCE_MODE {.inline.} = self.union1.sourceMode
proc `friendlyNameFromEdid=`*(self: var DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS, x: UINT32) {.inline.} = self.union1.struct1.friendlyNameFromEdid = x
proc friendlyNameFromEdid*(self: DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS): UINT32 {.inline.} = self.union1.struct1.friendlyNameFromEdid
proc `friendlyNameForced=`*(self: var DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS, x: UINT32) {.inline.} = self.union1.struct1.friendlyNameForced = x
proc friendlyNameForced*(self: DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS): UINT32 {.inline.} = self.union1.struct1.friendlyNameForced
proc `edidIdsValid=`*(self: var DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS, x: UINT32) {.inline.} = self.union1.struct1.edidIdsValid = x
proc edidIdsValid*(self: DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS): UINT32 {.inline.} = self.union1.struct1.edidIdsValid
proc `reserved=`*(self: var DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS, x: UINT32) {.inline.} = self.union1.struct1.reserved = x
proc reserved*(self: DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS): UINT32 {.inline.} = self.union1.struct1.reserved
proc `value=`*(self: var DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS, x: UINT32) {.inline.} = self.union1.value = x
proc value*(self: DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS): UINT32 {.inline.} = self.union1.value
proc value*(self: var DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS): var UINT32 {.inline.} = self.union1.value
proc `bootPersistenceOn=`*(self: var DISPLAYCONFIG_SET_TARGET_PERSISTENCE, x: UINT32) {.inline.} = self.union1.struct1.bootPersistenceOn = x
proc bootPersistenceOn*(self: DISPLAYCONFIG_SET_TARGET_PERSISTENCE): UINT32 {.inline.} = self.union1.struct1.bootPersistenceOn
proc `reserved=`*(self: var DISPLAYCONFIG_SET_TARGET_PERSISTENCE, x: UINT32) {.inline.} = self.union1.struct1.reserved = x
proc reserved*(self: DISPLAYCONFIG_SET_TARGET_PERSISTENCE): UINT32 {.inline.} = self.union1.struct1.reserved
proc `value=`*(self: var DISPLAYCONFIG_SET_TARGET_PERSISTENCE, x: UINT32) {.inline.} = self.union1.value = x
proc value*(self: DISPLAYCONFIG_SET_TARGET_PERSISTENCE): UINT32 {.inline.} = self.union1.value
proc value*(self: var DISPLAYCONFIG_SET_TARGET_PERSISTENCE): var UINT32 {.inline.} = self.union1.value
when winimUnicode:
  type
    LOGCOLORSPACE* = LOGCOLORSPACEW
    LPLOGCOLORSPACE* = LPLOGCOLORSPACEW
    TEXTMETRIC* = TEXTMETRICW
    PTEXTMETRIC* = PTEXTMETRICW
    NPTEXTMETRIC* = NPTEXTMETRICW
    LPTEXTMETRIC* = LPTEXTMETRICW
    NEWTEXTMETRIC* = NEWTEXTMETRICW
    PNEWTEXTMETRIC* = PNEWTEXTMETRICW
    NPNEWTEXTMETRIC* = NPNEWTEXTMETRICW
    LPNEWTEXTMETRIC* = LPNEWTEXTMETRICW
    NEWTEXTMETRICEX* = NEWTEXTMETRICEXW
    LOGFONT* = LOGFONTW
    PLOGFONT* = PLOGFONTW
    NPLOGFONT* = NPLOGFONTW
    LPLOGFONT* = LPLOGFONTW
    ENUMLOGFONT* = ENUMLOGFONTW
    LPENUMLOGFONT* = LPENUMLOGFONTW
    ENUMLOGFONTEX* = ENUMLOGFONTEXW
    LPENUMLOGFONTEX* = LPENUMLOGFONTEXW
    EXTLOGFONT* = EXTLOGFONTW
    PEXTLOGFONT* = PEXTLOGFONTW
    NPEXTLOGFONT* = NPEXTLOGFONTW
    LPEXTLOGFONT* = LPEXTLOGFONTW
    DEVMODE* = DEVMODEW
    PDEVMODE* = PDEVMODEW
    NPDEVMODE* = NPDEVMODEW
    DISPLAY_DEVICE* = DISPLAY_DEVICEW
    PDISPLAY_DEVICE* = PDISPLAY_DEVICEW
    LPDISPLAY_DEVICE* = LPDISPLAY_DEVICEW
    OUTLINETEXTMETRIC* = OUTLINETEXTMETRICW
    POUTLINETEXTMETRIC* = POUTLINETEXTMETRICW
    NPOUTLINETEXTMETRIC* = NPOUTLINETEXTMETRICW
    LPOUTLINETEXTMETRIC* = LPOUTLINETEXTMETRICW
    POLYTEXT* = POLYTEXTW
    PPOLYTEXT* = PPOLYTEXTW
    NPPOLYTEXT* = NPPOLYTEXTW
    LPPOLYTEXT* = LPPOLYTEXTW
    GCP_RESULTS* = GCP_RESULTSW
    LPGCP_RESULTS* = LPGCP_RESULTSW
    OLDFONTENUMPROC* = OLDFONTENUMPROCW
    FONTENUMPROC* = FONTENUMPROCW
    AXISINFO* = AXISINFOW
    PAXISINFO* = PAXISINFOW
    LPAXISINFO* = LPAXISINFOW
    AXESLIST* = AXESLISTW
    PAXESLIST* = PAXESLISTW
    LPAXESLIST* = LPAXESLISTW
    ENUMLOGFONTEXDV* = ENUMLOGFONTEXDVW
    PENUMLOGFONTEXDV* = PENUMLOGFONTEXDVW
    LPENUMLOGFONTEXDV* = LPENUMLOGFONTEXDVW
    ENUMTEXTMETRIC* = ENUMTEXTMETRICW
    PENUMTEXTMETRIC* = PENUMTEXTMETRICW
    LPENUMTEXTMETRIC* = LPENUMTEXTMETRICW
    DOCINFO* = DOCINFOW
    LPDOCINFO* = LPDOCINFOW
    ICMENUMPROC* = ICMENUMPROCW
  proc AddFontResource*(P1: LPCWSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "AddFontResourceW".}
  proc CopyMetaFile*(P1: HMETAFILE, P2: LPCWSTR): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc: "CopyMetaFileW".}
  proc CreateDC*(pwszDriver: LPCWSTR, pwszDevice: LPCWSTR, pszPort: LPCWSTR, pdm: ptr DEVMODEW): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "CreateDCW".}
  proc CreateFontIndirect*(lplf: ptr LOGFONTW): HFONT {.winapi, stdcall, dynlib: "gdi32", importc: "CreateFontIndirectW".}
  proc CreateFont*(cHeight: int32, cWidth: int32, cEscapement: int32, cOrientation: int32, cWeight: int32, bItalic: DWORD, bUnderline: DWORD, bStrikeOut: DWORD, iCharSet: DWORD, iOutPrecision: DWORD, iClipPrecision: DWORD, iQuality: DWORD, iPitchAndFamily: DWORD, pszFaceName: LPCWSTR): HFONT {.winapi, stdcall, dynlib: "gdi32", importc: "CreateFontW".}
  proc CreateIC*(pszDriver: LPCWSTR, pszDevice: LPCWSTR, pszPort: LPCWSTR, pdm: ptr DEVMODEW): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "CreateICW".}
  proc CreateMetaFile*(pszFile: LPCWSTR): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "CreateMetaFileW".}
  proc CreateScalableFontResource*(fdwHidden: DWORD, lpszFont: LPCWSTR, lpszFile: LPCWSTR, lpszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "CreateScalableFontResourceW".}
  proc DeviceCapabilities*(pDevice: LPCWSTR, pPort: LPCWSTR, fwCapability: WORD, pOutput: LPWSTR, pDevMode: ptr DEVMODEW): int32 {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeviceCapabilitiesW".}
  proc EnumFontFamiliesEx*(hdc: HDC, lpLogfont: LPLOGFONTW, lpProc: FONTENUMPROCW, lParam: LPARAM, dwFlags: DWORD): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "EnumFontFamiliesExW".}
  proc EnumFontFamilies*(hdc: HDC, lpLogfont: LPCWSTR, lpProc: FONTENUMPROCW, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "EnumFontFamiliesW".}
  proc EnumFonts*(hdc: HDC, lpLogfont: LPCWSTR, lpProc: FONTENUMPROCW, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "EnumFontsW".}
  proc GetCharWidth*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharWidthW".}
  proc GetCharWidth32*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharWidth32W".}
  proc GetCharWidthFloat*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: PFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharWidthFloatW".}
  proc GetCharABCWidths*(hdc: HDC, wFirst: UINT, wLast: UINT, lpABC: LPABC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharABCWidthsW".}
  proc GetCharABCWidthsFloat*(hdc: HDC, iFirst: UINT, iLast: UINT, lpABC: LPABCFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharABCWidthsFloatW".}
  proc GetGlyphOutline*(hdc: HDC, uChar: UINT, fuFormat: UINT, lpgm: LPGLYPHMETRICS, cjBuffer: DWORD, pvBuffer: LPVOID, lpmat2: ptr MAT2): DWORD {.winapi, stdcall, dynlib: "gdi32", importc: "GetGlyphOutlineW".}
  proc GetMetaFile*(lpName: LPCWSTR): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc: "GetMetaFileW".}
  proc GetOutlineTextMetrics*(hdc: HDC, cjCopy: UINT, potm: LPOUTLINETEXTMETRICW): UINT {.winapi, stdcall, dynlib: "gdi32", importc: "GetOutlineTextMetricsW".}
  proc GetTextExtentPoint*(hdc: HDC, lpString: LPCWSTR, c: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextExtentPointW".}
  proc GetTextExtentPoint32*(hdc: HDC, lpString: LPCWSTR, c: int32, psizl: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextExtentPoint32W".}
  proc GetTextExtentExPoint*(hdc: HDC, lpszString: LPCWSTR, cchString: int32, nMaxExtent: int32, lpnFit: LPINT, lpnDx: LPINT, lpSize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextExtentExPointW".}
  proc GetCharacterPlacement*(hdc: HDC, lpString: LPCWSTR, nCount: int32, nMexExtent: int32, lpResults: LPGCP_RESULTSW, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharacterPlacementW".}
  proc GetGlyphIndices*(hdc: HDC, lpstr: LPCWSTR, c: int32, pgi: LPWORD, fl: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc: "GetGlyphIndicesW".}
  proc AddFontResourceEx*(name: LPCWSTR, fl: DWORD, res: PVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "AddFontResourceExW".}
  proc RemoveFontResourceEx*(name: LPCWSTR, fl: DWORD, pdv: PVOID): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "RemoveFontResourceExW".}
  proc CreateFontIndirectEx*(P1: ptr ENUMLOGFONTEXDVW): HFONT {.winapi, stdcall, dynlib: "gdi32", importc: "CreateFontIndirectExW".}
  proc ResetDC*(hdc: HDC, lpdm: ptr DEVMODEW): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "ResetDCW".}
  proc RemoveFontResource*(lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "RemoveFontResourceW".}
  proc CopyEnhMetaFile*(hEnh: HENHMETAFILE, lpFileName: LPCWSTR): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc: "CopyEnhMetaFileW".}
  proc CreateEnhMetaFile*(hdc: HDC, lpFilename: LPCWSTR, lprc: ptr RECT, lpDesc: LPCWSTR): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "CreateEnhMetaFileW".}
  proc GetEnhMetaFile*(lpName: LPCWSTR): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc: "GetEnhMetaFileW".}
  proc GetEnhMetaFileDescription*(hemf: HENHMETAFILE, cchBuffer: UINT, lpDescription: LPWSTR): UINT {.winapi, stdcall, dynlib: "gdi32", importc: "GetEnhMetaFileDescriptionW".}
  proc GetTextMetrics*(hdc: HDC, lptm: LPTEXTMETRICW): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextMetricsW".}
  proc StartDoc*(hdc: HDC, lpdi: ptr DOCINFOW): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "StartDocW".}
  proc GetObject*(h: HANDLE, c: int32, pv: LPVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "GetObjectW".}
  proc TextOut*(hdc: HDC, x: int32, y: int32, lpString: LPCWSTR, c: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "TextOutW".}
  proc ExtTextOut*(hdc: HDC, x: int32, y: int32, options: UINT, lprect: ptr RECT, lpString: LPCWSTR, c: UINT, lpDx: ptr INT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "ExtTextOutW".}
  proc PolyTextOut*(hdc: HDC, ppt: ptr POLYTEXTW, nstrings: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "PolyTextOutW".}
  proc GetTextFace*(hdc: HDC, c: int32, lpName: LPWSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextFaceW".}
  proc GetKerningPairs*(hdc: HDC, nPairs: DWORD, lpKernPair: LPKERNINGPAIR): DWORD {.winapi, stdcall, dynlib: "gdi32", importc: "GetKerningPairsW".}
  proc EnumICMProfiles*(hdc: HDC, lpProc: ICMENUMPROCW, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "EnumICMProfilesW".}
  proc UpdateICMRegKey*(reserved: DWORD, lpszCMID: LPWSTR, lpszFileName: LPWSTR, command: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "UpdateICMRegKeyW".}
  proc GetLogColorSpace*(hColorSpace: HCOLORSPACE, lpBuffer: LPLOGCOLORSPACEW, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetLogColorSpaceW".}
  proc CreateColorSpace*(lplcs: LPLOGCOLORSPACEW): HCOLORSPACE {.winapi, stdcall, dynlib: "gdi32", importc: "CreateColorSpaceW".}
  proc GetICMProfile*(hdc: HDC, pBufSize: LPDWORD, pszFilename: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetICMProfileW".}
  proc SetICMProfile*(hdc: HDC, lpFileName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "SetICMProfileW".}
  proc wglUseFontBitmaps*(P1: HDC, P2: DWORD, P3: DWORD, P4: DWORD): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc: "wglUseFontBitmapsW".}
  proc wglUseFontOutlines*(P1: HDC, P2: DWORD, P3: DWORD, P4: DWORD, P5: FLOAT, P6: FLOAT, P7: int32, P8: LPGLYPHMETRICSFLOAT): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc: "wglUseFontOutlinesW".}
when winimAnsi:
  type
    LOGCOLORSPACE* = LOGCOLORSPACEA
    LPLOGCOLORSPACE* = LPLOGCOLORSPACEA
    TEXTMETRIC* = TEXTMETRICA
    PTEXTMETRIC* = PTEXTMETRICA
    NPTEXTMETRIC* = NPTEXTMETRICA
    LPTEXTMETRIC* = LPTEXTMETRICA
    NEWTEXTMETRIC* = NEWTEXTMETRICA
    PNEWTEXTMETRIC* = PNEWTEXTMETRICA
    NPNEWTEXTMETRIC* = NPNEWTEXTMETRICA
    LPNEWTEXTMETRIC* = LPNEWTEXTMETRICA
    NEWTEXTMETRICEX* = NEWTEXTMETRICEXA
    LOGFONT* = LOGFONTA
    PLOGFONT* = PLOGFONTA
    NPLOGFONT* = NPLOGFONTA
    LPLOGFONT* = LPLOGFONTA
    ENUMLOGFONT* = ENUMLOGFONTA
    LPENUMLOGFONT* = LPENUMLOGFONTA
    ENUMLOGFONTEX* = ENUMLOGFONTEXA
    LPENUMLOGFONTEX* = LPENUMLOGFONTEXA
    EXTLOGFONT* = EXTLOGFONTA
    PEXTLOGFONT* = PEXTLOGFONTA
    NPEXTLOGFONT* = NPEXTLOGFONTA
    LPEXTLOGFONT* = LPEXTLOGFONTA
    DEVMODE* = DEVMODEA
    PDEVMODE* = PDEVMODEA
    NPDEVMODE* = NPDEVMODEA
    DISPLAY_DEVICE* = DISPLAY_DEVICEA
    PDISPLAY_DEVICE* = PDISPLAY_DEVICEA
    LPDISPLAY_DEVICE* = LPDISPLAY_DEVICEA
    OUTLINETEXTMETRIC* = OUTLINETEXTMETRICA
    POUTLINETEXTMETRIC* = POUTLINETEXTMETRICA
    NPOUTLINETEXTMETRIC* = NPOUTLINETEXTMETRICA
    LPOUTLINETEXTMETRIC* = LPOUTLINETEXTMETRICA
    POLYTEXT* = POLYTEXTA
    PPOLYTEXT* = PPOLYTEXTA
    NPPOLYTEXT* = NPPOLYTEXTA
    LPPOLYTEXT* = LPPOLYTEXTA
    GCP_RESULTS* = GCP_RESULTSA
    LPGCP_RESULTS* = LPGCP_RESULTSA
    OLDFONTENUMPROC* = OLDFONTENUMPROCA
    FONTENUMPROC* = FONTENUMPROCA
    AXISINFO* = AXISINFOA
    PAXISINFO* = PAXISINFOA
    LPAXISINFO* = LPAXISINFOA
    AXESLIST* = AXESLISTA
    PAXESLIST* = PAXESLISTA
    LPAXESLIST* = LPAXESLISTA
    ENUMLOGFONTEXDV* = ENUMLOGFONTEXDVA
    PENUMLOGFONTEXDV* = PENUMLOGFONTEXDVA
    LPENUMLOGFONTEXDV* = LPENUMLOGFONTEXDVA
    ENUMTEXTMETRIC* = ENUMTEXTMETRICA
    PENUMTEXTMETRIC* = PENUMTEXTMETRICA
    LPENUMTEXTMETRIC* = LPENUMTEXTMETRICA
    DOCINFO* = DOCINFOA
    LPDOCINFO* = LPDOCINFOA
    ICMENUMPROC* = ICMENUMPROCA
  proc AddFontResource*(P1: LPCSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "AddFontResourceA".}
  proc CopyMetaFile*(P1: HMETAFILE, P2: LPCSTR): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc: "CopyMetaFileA".}
  proc CreateDC*(pwszDriver: LPCSTR, pwszDevice: LPCSTR, pszPort: LPCSTR, pdm: ptr DEVMODEA): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "CreateDCA".}
  proc CreateFontIndirect*(lplf: ptr LOGFONTA): HFONT {.winapi, stdcall, dynlib: "gdi32", importc: "CreateFontIndirectA".}
  proc CreateFont*(cHeight: int32, cWidth: int32, cEscapement: int32, cOrientation: int32, cWeight: int32, bItalic: DWORD, bUnderline: DWORD, bStrikeOut: DWORD, iCharSet: DWORD, iOutPrecision: DWORD, iClipPrecision: DWORD, iQuality: DWORD, iPitchAndFamily: DWORD, pszFaceName: LPCSTR): HFONT {.winapi, stdcall, dynlib: "gdi32", importc: "CreateFontA".}
  proc CreateIC*(pszDriver: LPCSTR, pszDevice: LPCSTR, pszPort: LPCSTR, pdm: ptr DEVMODEA): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "CreateICA".}
  proc CreateMetaFile*(pszFile: LPCSTR): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "CreateMetaFileA".}
  proc CreateScalableFontResource*(fdwHidden: DWORD, lpszFont: LPCSTR, lpszFile: LPCSTR, lpszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "CreateScalableFontResourceA".}
  proc DeviceCapabilities*(pDevice: LPCSTR, pPort: LPCSTR, fwCapability: WORD, pOutput: LPSTR, pDevMode: ptr DEVMODEA): int32 {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeviceCapabilitiesA".}
  proc EnumFontFamiliesEx*(hdc: HDC, lpLogfont: LPLOGFONTA, lpProc: FONTENUMPROCA, lParam: LPARAM, dwFlags: DWORD): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "EnumFontFamiliesExA".}
  proc EnumFontFamilies*(hdc: HDC, lpLogfont: LPCSTR, lpProc: FONTENUMPROCA, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "EnumFontFamiliesA".}
  proc EnumFonts*(hdc: HDC, lpLogfont: LPCSTR, lpProc: FONTENUMPROCA, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "EnumFontsA".}
  proc GetCharWidth*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharWidthA".}
  proc GetCharWidth32*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: LPINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharWidth32A".}
  proc GetCharWidthFloat*(hdc: HDC, iFirst: UINT, iLast: UINT, lpBuffer: PFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharWidthFloatA".}
  proc GetCharABCWidths*(hdc: HDC, wFirst: UINT, wLast: UINT, lpABC: LPABC): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharABCWidthsA".}
  proc GetCharABCWidthsFloat*(hdc: HDC, iFirst: UINT, iLast: UINT, lpABC: LPABCFLOAT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharABCWidthsFloatA".}
  proc GetGlyphOutline*(hdc: HDC, uChar: UINT, fuFormat: UINT, lpgm: LPGLYPHMETRICS, cjBuffer: DWORD, pvBuffer: LPVOID, lpmat2: ptr MAT2): DWORD {.winapi, stdcall, dynlib: "gdi32", importc: "GetGlyphOutlineA".}
  proc GetMetaFile*(lpName: LPCSTR): HMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc: "GetMetaFileA".}
  proc GetOutlineTextMetrics*(hdc: HDC, cjCopy: UINT, potm: LPOUTLINETEXTMETRICA): UINT {.winapi, stdcall, dynlib: "gdi32", importc: "GetOutlineTextMetricsA".}
  proc GetTextExtentPoint*(hdc: HDC, lpString: LPCSTR, c: int32, lpsz: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextExtentPointA".}
  proc GetTextExtentPoint32*(hdc: HDC, lpString: LPCSTR, c: int32, psizl: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextExtentPoint32A".}
  proc GetTextExtentExPoint*(hdc: HDC, lpszString: LPCSTR, cchString: int32, nMaxExtent: int32, lpnFit: LPINT, lpnDx: LPINT, lpSize: LPSIZE): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextExtentExPointA".}
  proc GetCharacterPlacement*(hdc: HDC, lpString: LPCSTR, nCount: int32, nMexExtent: int32, lpResults: LPGCP_RESULTSA, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc: "GetCharacterPlacementA".}
  proc GetGlyphIndices*(hdc: HDC, lpstr: LPCSTR, c: int32, pgi: LPWORD, fl: DWORD): DWORD {.winapi, stdcall, dynlib: "gdi32", importc: "GetGlyphIndicesA".}
  proc AddFontResourceEx*(name: LPCSTR, fl: DWORD, res: PVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "AddFontResourceExA".}
  proc RemoveFontResourceEx*(name: LPCSTR, fl: DWORD, pdv: PVOID): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "RemoveFontResourceExA".}
  proc CreateFontIndirectEx*(P1: ptr ENUMLOGFONTEXDVA): HFONT {.winapi, stdcall, dynlib: "gdi32", importc: "CreateFontIndirectExA".}
  proc ResetDC*(hdc: HDC, lpdm: ptr DEVMODEA): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "ResetDCA".}
  proc RemoveFontResource*(lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "RemoveFontResourceA".}
  proc CopyEnhMetaFile*(hEnh: HENHMETAFILE, lpFileName: LPCSTR): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc: "CopyEnhMetaFileA".}
  proc CreateEnhMetaFile*(hdc: HDC, lpFilename: LPCSTR, lprc: ptr RECT, lpDesc: LPCSTR): HDC {.winapi, stdcall, dynlib: "gdi32", importc: "CreateEnhMetaFileA".}
  proc GetEnhMetaFile*(lpName: LPCSTR): HENHMETAFILE {.winapi, stdcall, dynlib: "gdi32", importc: "GetEnhMetaFileA".}
  proc GetEnhMetaFileDescription*(hemf: HENHMETAFILE, cchBuffer: UINT, lpDescription: LPSTR): UINT {.winapi, stdcall, dynlib: "gdi32", importc: "GetEnhMetaFileDescriptionA".}
  proc GetTextMetrics*(hdc: HDC, lptm: LPTEXTMETRICA): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextMetricsA".}
  proc StartDoc*(hdc: HDC, lpdi: ptr DOCINFOA): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "StartDocA".}
  proc GetObject*(h: HANDLE, c: int32, pv: LPVOID): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "GetObjectA".}
  proc TextOut*(hdc: HDC, x: int32, y: int32, lpString: LPCSTR, c: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "TextOutA".}
  proc ExtTextOut*(hdc: HDC, x: int32, y: int32, options: UINT, lprect: ptr RECT, lpString: LPCSTR, c: UINT, lpDx: ptr INT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "ExtTextOutA".}
  proc PolyTextOut*(hdc: HDC, ppt: ptr POLYTEXTA, nstrings: int32): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "PolyTextOutA".}
  proc GetTextFace*(hdc: HDC, c: int32, lpName: LPSTR): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "GetTextFaceA".}
  proc GetKerningPairs*(hdc: HDC, nPairs: DWORD, lpKernPair: LPKERNINGPAIR): DWORD {.winapi, stdcall, dynlib: "gdi32", importc: "GetKerningPairsA".}
  proc EnumICMProfiles*(hdc: HDC, lpProc: ICMENUMPROCA, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "gdi32", importc: "EnumICMProfilesA".}
  proc UpdateICMRegKey*(reserved: DWORD, lpszCMID: LPSTR, lpszFileName: LPSTR, command: UINT): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "UpdateICMRegKeyA".}
  proc GetLogColorSpace*(hColorSpace: HCOLORSPACE, lpBuffer: LPLOGCOLORSPACEA, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetLogColorSpaceA".}
  proc CreateColorSpace*(lplcs: LPLOGCOLORSPACEA): HCOLORSPACE {.winapi, stdcall, dynlib: "gdi32", importc: "CreateColorSpaceA".}
  proc GetICMProfile*(hdc: HDC, pBufSize: LPDWORD, pszFilename: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "GetICMProfileA".}
  proc SetICMProfile*(hdc: HDC, lpFileName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "gdi32", importc: "SetICMProfileA".}
  proc wglUseFontBitmaps*(P1: HDC, P2: DWORD, P3: DWORD, P4: DWORD): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc: "wglUseFontBitmapsA".}
  proc wglUseFontOutlines*(P1: HDC, P2: DWORD, P3: DWORD, P4: DWORD, P5: FLOAT, P6: FLOAT, P7: int32, P8: LPGLYPHMETRICSFLOAT): WINBOOL {.winapi, stdcall, dynlib: "opengl32", importc: "wglUseFontOutlinesA".}
