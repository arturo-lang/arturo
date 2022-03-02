#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import wingdi
import commctrl
import shellapi
#include <uxtheme.h>
type
  BP_BUFFERFORMAT* = int32
  BP_ANIMATIONSTYLE* = int32
  WINDOWTHEMEATTRIBUTETYPE* = int32
  THEMESIZE* = int32
  PROPERTYORIGIN* = int32
  HPAINTBUFFER* = HANDLE
  HANIMATIONBUFFER* = HANDLE
  BP_PAINTPARAMS* {.pure.} = object
    cbSize*: DWORD
    dwFlags*: DWORD
    prcExclude*: ptr RECT
    pBlendFunction*: ptr BLENDFUNCTION
  PBP_PAINTPARAMS* = ptr BP_PAINTPARAMS
  BP_ANIMATIONPARAMS* {.pure.} = object
    cbSize*: DWORD
    dwFlags*: DWORD
    style*: BP_ANIMATIONSTYLE
    dwDuration*: DWORD
  PBP_ANIMATIONPARAMS* = ptr BP_ANIMATIONPARAMS
  WTA_OPTIONS* {.pure.} = object
    dwFlags*: DWORD
    dwMask*: DWORD
  PWTA_OPTIONS* = ptr WTA_OPTIONS
  DTT_CALLBACK_PROC* = proc (hdc: HDC, pszText: LPWSTR, cchText: int32, prc: LPRECT, dwFlags: UINT, lParam: LPARAM): int32 {.stdcall.}
  DTTOPTS* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    crText*: COLORREF
    crBorder*: COLORREF
    crShadow*: COLORREF
    iTextShadowType*: int32
    ptShadowOffset*: POINT
    iBorderSize*: int32
    iFontPropId*: int32
    iColorPropId*: int32
    iStateId*: int32
    fApplyOverlay*: WINBOOL
    iGlowSize*: int32
    pfnDrawTextCallback*: DTT_CALLBACK_PROC
    lParam*: LPARAM
  PDTTOPTS* = ptr DTTOPTS
  MARGINS* {.pure.} = object
    cxLeftWidth*: int32
    cxRightWidth*: int32
    cyTopHeight*: int32
    cyBottomHeight*: int32
  PMARGINS* = ptr MARGINS
const
  MAX_INTLIST_COUNT* = 402
type
  INTLIST* {.pure.} = object
    iValueCount*: int32
    iValues*: array[MAX_INTLIST_COUNT, int32]
  PINTLIST* = ptr INTLIST
  DTBGOPTS* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    rcClip*: RECT
  PDTBGOPTS* = ptr DTBGOPTS
const
  GBF_DIRECT* = 0x00000001
  GBF_COPY* = 0x00000002
  GBF_VALIDBITS* = GBF_DIRECT or GBF_COPY
  BPBF_COMPATIBLEBITMAP* = 0
  BPBF_DIB* = 1
  BPBF_TOPDOWNDIB* = 2
  BPBF_TOPDOWNMONODIB* = 3
  BPPF_ERASE* = 0x00000001
  BPPF_NOCLIP* = 0x00000002
  BPPF_NONCLIENT* = 0x00000004
  BPAS_NONE* = 0
  BPAS_LINEAR* = 1
  BPAS_CUBIC* = 2
  BPAS_SINE* = 3
  WTA_NONCLIENT* = 1
  WTNCA_NODRAWCAPTION* = 0x00000001
  WTNCA_NODRAWICON* = 0x00000002
  WTNCA_NOSYSMENU* = 0x00000004
  WTNCA_NOMIRRORHELP* = 0x00000008
  WTNCA_VALIDBITS* = WTNCA_NODRAWCAPTION or WTNCA_NODRAWICON or WTNCA_NOSYSMENU or WTNCA_NOMIRRORHELP
  OTD_FORCE_RECT_SIZING* = 0x00000001
  OTD_NONCLIENT* = 0x00000002
  OTD_VALIDBITS* = OTD_FORCE_RECT_SIZING or OTD_NONCLIENT
  DTT_GRAYED* = 0x1
  DTT_TEXTCOLOR* = 1 shl 0
  DTT_BORDERCOLOR* = 1 shl 1
  DTT_SHADOWCOLOR* = 1 shl 2
  DTT_SHADOWTYPE* = 1 shl 3
  DTT_SHADOWOFFSET* = 1 shl 4
  DTT_BORDERSIZE* = 1 shl 5
  DTT_FONTPROP* = 1 shl 6
  DTT_COLORPROP* = 1 shl 7
  DTT_STATEID* = 1 shl 8
  DTT_CALCRECT* = 1 shl 9
  DTT_APPLYOVERLAY* = 1 shl 10
  DTT_GLOWSIZE* = 1 shl 11
  DTT_CALLBACK* = 1 shl 12
  DTT_COMPOSITED* = 1 shl 13
  DTT_VALIDBITS* = DTT_TEXTCOLOR or DTT_BORDERCOLOR or DTT_SHADOWCOLOR or DTT_SHADOWTYPE or DTT_SHADOWOFFSET or DTT_BORDERSIZE or DTT_FONTPROP or DTT_COLORPROP or DTT_STATEID or DTT_CALCRECT or DTT_APPLYOVERLAY or DTT_GLOWSIZE or DTT_COMPOSITED
  TS_MIN* = 0
  TS_TRUE* = 1
  TS_DRAW* = 2
  HTTB_BACKGROUNDSEG* = 0x0000
  HTTB_FIXEDBORDER* = 0x0002
  HTTB_CAPTION* = 0x0004
  HTTB_RESIZINGBORDER_LEFT* = 0x0010
  HTTB_RESIZINGBORDER_TOP* = 0x0020
  HTTB_RESIZINGBORDER_RIGHT* = 0x0040
  HTTB_RESIZINGBORDER_BOTTOM* = 0x0080
  HTTB_RESIZINGBORDER* = HTTB_RESIZINGBORDER_LEFT or HTTB_RESIZINGBORDER_TOP or HTTB_RESIZINGBORDER_RIGHT or HTTB_RESIZINGBORDER_BOTTOM
  HTTB_SIZINGTEMPLATE* = 0x0100
  HTTB_SYSTEMSIZINGMARGINS* = 0x0200
  PO_STATE* = 0
  PO_PART* = 1
  PO_CLASS* = 2
  PO_GLOBAL* = 3
  PO_NOTFOUND* = 4
  ETDT_DISABLE* = 0x00000001
  ETDT_ENABLE* = 0x00000002
  ETDT_USETABTEXTURE* = 0x00000004
  ETDT_ENABLETAB* = ETDT_ENABLE or ETDT_USETABTEXTURE
  ETDT_USEAEROWIZARDTABTEXTURE* = 0x00000008
  ETDT_ENABLEAEROWIZARDTAB* = ETDT_ENABLE or ETDT_USEAEROWIZARDTABTEXTURE
  ETDT_VALIDBITS* = ETDT_DISABLE or ETDT_ENABLE or ETDT_USETABTEXTURE or ETDT_USEAEROWIZARDTABTEXTURE
  STAP_ALLOW_NONCLIENT* = 1 shl 0
  STAP_ALLOW_CONTROLS* = 1 shl 1
  STAP_ALLOW_WEBCONTENT* = 1 shl 2
  SZ_THDOCPROP_DISPLAYNAME* = "DisplayName"
  SZ_THDOCPROP_CANONICALNAME* = "ThemeName"
  SZ_THDOCPROP_TOOLTIP* = "ToolTip"
  SZ_THDOCPROP_AUTHOR* = "author"
  DTPB_WINDOWDC* = 0x00000001
  DTPB_USECTLCOLORSTATIC* = 0x00000002
  DTPB_USEERASEBKGND* = 0x00000004
  DTBG_CLIPRECT* = 0x00000001
  DTBG_DRAWSOLID* = 0x00000002
  DTBG_OMITBORDER* = 0x00000004
  DTBG_OMITCONTENT* = 0x00000008
  DTBG_COMPUTINGREGION* = 0x00000010
  DTBG_MIRRORDC* = 0x00000020
  DTBG_NOMIRROR* = 0x00000040
  DTBG_VALIDBITS* = DTBG_CLIPRECT or DTBG_DRAWSOLID or DTBG_OMITBORDER or DTBG_OMITCONTENT or DTBG_COMPUTINGREGION or DTBG_MIRRORDC or DTBG_NOMIRROR
proc BeginPanningFeedback*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc UpdatePanningFeedback*(hwnd: HWND, lTotalOverpanOffsetX: LONG, lTotalOverpanOffsetY: LONG, fInInertia: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc EndPanningFeedback*(hwnd: HWND, fAnimateBack: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeBitmap*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, dwFlags: ULONG, phBitmap: ptr HBITMAP): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeStream*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, ppvStream: ptr pointer, pcbStream: ptr DWORD, hInst: HINSTANCE): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeTransitionDuration*(hTheme: HTHEME, iPartId: int32, iStateIdFrom: int32, iStateIdTo: int32, iPropId: int32, pdwDuration: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc BeginBufferedPaint*(hdcTarget: HDC, prcTarget: ptr RECT, dwFormat: BP_BUFFERFORMAT, pPaintParams: ptr BP_PAINTPARAMS, phdc: ptr HDC): HPAINTBUFFER {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc EndBufferedPaint*(hBufferedPaint: HPAINTBUFFER, fUpdateTarget: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetBufferedPaintTargetRect*(hBufferedPaint: HPAINTBUFFER, prc: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetBufferedPaintTargetDC*(hBufferedPaint: HPAINTBUFFER): HDC {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetBufferedPaintDC*(hBufferedPaint: HPAINTBUFFER): HDC {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetBufferedPaintBits*(hBufferedPaint: HPAINTBUFFER, ppbBuffer: ptr ptr RGBQUAD, pcxRow: ptr int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc BufferedPaintClear*(hBufferedPaint: HPAINTBUFFER, prc: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc BufferedPaintSetAlpha*(hBufferedPaint: HPAINTBUFFER, prc: ptr RECT, alpha: BYTE): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc BufferedPaintInit*(): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc BufferedPaintUnInit*(): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc BeginBufferedAnimation*(hwnd: HWND, hdcTarget: HDC, rcTarget: ptr RECT, dwFormat: BP_BUFFERFORMAT, pPaintParams: ptr BP_PAINTPARAMS, pAnimationParams: ptr BP_ANIMATIONPARAMS, phdcFrom: ptr HDC, phdcTo: ptr HDC): HANIMATIONBUFFER {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc EndBufferedAnimation*(hbpAnimation: HANIMATIONBUFFER, fUpdateTarget: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc BufferedPaintRenderAnimation*(hwnd: HWND, hdcTarget: HDC): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc BufferedPaintStopAllAnimations*(hwnd: HWND): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc IsCompositionActive*(): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc SetWindowThemeAttribute*(hwnd: HWND, eAttribute: WINDOWTHEMEATTRIBUTETYPE, pvAttribute: PVOID, cbAttribute: DWORD): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc OpenThemeData*(hwnd: HWND, pszClassList: LPCWSTR): HTHEME {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc OpenThemeDataEx*(hwnd: HWND, pszClassList: LPCWSTR, dwFlags: DWORD): HTHEME {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc CloseThemeData*(hTheme: HTHEME): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc DrawThemeBackground*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pRect: ptr RECT, pClipRect: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc DrawThemeText*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pszText: LPCWSTR, iCharCount: int32, dwTextFlags: DWORD, dwTextFlags2: DWORD, pRect: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc DrawThemeTextEx*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pszText: LPCWSTR, iCharCount: int32, dwFlags: DWORD, pRect: LPRECT, pOptions: ptr DTTOPTS): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeBackgroundContentRect*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pBoundingRect: ptr RECT, pContentRect: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeBackgroundExtent*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pContentRect: ptr RECT, pExtentRect: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemePartSize*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, prc: ptr RECT, eSize: THEMESIZE, psz: ptr SIZE): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeTextExtent*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pszText: LPCWSTR, iCharCount: int32, dwTextFlags: DWORD, pBoundingRect: ptr RECT, pExtentRect: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeTextMetrics*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, ptm: ptr TEXTMETRIC): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeBackgroundRegion*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pRect: ptr RECT, pRegion: ptr HRGN): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc HitTestThemeBackground*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, dwOptions: DWORD, pRect: ptr RECT, hrgn: HRGN, ptTest: POINT, pwHitTestCode: ptr WORD): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc DrawThemeEdge*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pDestRect: ptr RECT, uEdge: UINT, uFlags: UINT, pContentRect: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc DrawThemeIcon*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pRect: ptr RECT, himl: HIMAGELIST, iImageIndex: int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc IsThemePartDefined*(hTheme: HTHEME, iPartId: int32, iStateId: int32): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc IsThemeBackgroundPartiallyTransparent*(hTheme: HTHEME, iPartId: int32, iStateId: int32): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeColor*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, pColor: ptr COLORREF): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeMetric*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, iPropId: int32, piVal: ptr int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeString*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, pszBuff: LPWSTR, cchMaxBuffChars: int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeBool*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, pfVal: ptr WINBOOL): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeInt*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, piVal: ptr int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeEnumValue*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, piVal: ptr int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemePosition*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, pPoint: ptr POINT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeFont*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, iPropId: int32, pFont: ptr LOGFONTW): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeRect*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, pRect: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeMargins*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, iPropId: int32, prc: ptr RECT, pMargins: ptr MARGINS): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeIntList*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, pIntList: ptr INTLIST): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemePropertyOrigin*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, pOrigin: ptr PROPERTYORIGIN): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc SetWindowTheme*(hwnd: HWND, pszSubAppName: LPCWSTR, pszSubIdList: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeFilename*(hTheme: HTHEME, iPartId: int32, iStateId: int32, iPropId: int32, pszThemeFileName: LPWSTR, cchMaxBuffChars: int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeSysColor*(hTheme: HTHEME, iColorId: int32): COLORREF {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeSysColorBrush*(hTheme: HTHEME, iColorId: int32): HBRUSH {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeSysBool*(hTheme: HTHEME, iBoolId: int32): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeSysSize*(hTheme: HTHEME, iSizeId: int32): int32 {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeSysFont*(hTheme: HTHEME, iFontId: int32, plf: ptr LOGFONT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeSysString*(hTheme: HTHEME, iStringId: int32, pszStringBuff: LPWSTR, cchMaxStringChars: int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeSysInt*(hTheme: HTHEME, iIntId: int32, piValue: ptr int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc IsThemeActive*(): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc IsAppThemed*(): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetWindowTheme*(hwnd: HWND): HTHEME {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc EnableThemeDialogTexture*(hwnd: HWND, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc IsThemeDialogTextureEnabled*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeAppProperties*(): DWORD {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc SetThemeAppProperties*(dwFlags: DWORD): void {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetCurrentThemeName*(pszThemeFileName: LPWSTR, cchMaxNameChars: int32, pszColorBuff: LPWSTR, cchMaxColorChars: int32, pszSizeBuff: LPWSTR, cchMaxSizeChars: int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc GetThemeDocumentationProperty*(pszThemeName: LPCWSTR, pszPropertyName: LPCWSTR, pszValueBuff: LPWSTR, cchMaxValChars: int32): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc DrawThemeParentBackground*(hwnd: HWND, hdc: HDC, prc: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc DrawThemeParentBackgroundEx*(hwnd: HWND, hdc: HDC, dwFlags: DWORD, prc: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc EnableTheming*(fEnable: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
proc DrawThemeBackgroundEx*(hTheme: HTHEME, hdc: HDC, iPartId: int32, iStateId: int32, pRect: ptr RECT, pOptions: ptr DTBGOPTS): HRESULT {.winapi, stdcall, dynlib: "uxtheme", importc.}
