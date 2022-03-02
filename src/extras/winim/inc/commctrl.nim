#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import winuser
import winnls
import objbase
#include <commctrl.h>
#include <prsht.h>
#include <commoncontrols.h>
type
  TVITEMPART* = int32
  TASKDIALOG_FLAGS* = int32
  TASKDIALOG_MESSAGES* = int32
  TASKDIALOG_NOTIFICATIONS* = int32
  TASKDIALOG_ELEMENTS* = int32
  TASKDIALOG_ICON_ELEMENTS* = int32
  TASKDIALOG_COMMON_BUTTON_FLAGS* = int32
  MONTHDAYSTATE* = DWORD
  LPMONTHDAYSTATE* = ptr DWORD
  HDPA* = HANDLE
  HDSA* = HANDLE
  HIMAGELIST* = HANDLE
  HPROPSHEETPAGE* = HANDLE
  HTREEITEM* = HANDLE
  PROPSHEETPAGE_RESOURCE* = LPCDLGTEMPLATE
  PROPSHEETPAGEA_UNION1* {.pure, union.} = object
    pszTemplate*: LPCSTR
    pResource*: LPCDLGTEMPLATE
  PROPSHEETPAGEA_UNION2* {.pure, union.} = object
    hIcon*: HICON
    pszIcon*: LPCSTR
  LPFNPSPCALLBACKA* = proc (hwnd: HWND, uMsg: UINT, ppsp: ptr PROPSHEETPAGEA): UINT {.stdcall.}
  PROPSHEETPAGEA* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    hInstance*: HINSTANCE
    union1*: PROPSHEETPAGEA_UNION1
    union2*: PROPSHEETPAGEA_UNION2
    pszTitle*: LPCSTR
    pfnDlgProc*: DLGPROC
    lParam*: LPARAM
    pfnCallback*: LPFNPSPCALLBACKA
    pcRefParent*: ptr UINT
    pszHeaderTitle*: LPCSTR
    pszHeaderSubTitle*: LPCSTR
    hActCtx*: HANDLE
  LPPROPSHEETPAGEA* = ptr PROPSHEETPAGEA
  LPCPROPSHEETPAGEA* = ptr PROPSHEETPAGEA
  PROPSHEETPAGEW_UNION1* {.pure, union.} = object
    pszTemplate*: LPCWSTR
    pResource*: LPCDLGTEMPLATE
  PROPSHEETPAGEW_UNION2* {.pure, union.} = object
    hIcon*: HICON
    pszIcon*: LPCWSTR
  LPFNPSPCALLBACKW* = proc (hwnd: HWND, uMsg: UINT, ppsp: ptr PROPSHEETPAGEW): UINT {.stdcall.}
  PROPSHEETPAGEW* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    hInstance*: HINSTANCE
    union1*: PROPSHEETPAGEW_UNION1
    union2*: PROPSHEETPAGEW_UNION2
    pszTitle*: LPCWSTR
    pfnDlgProc*: DLGPROC
    lParam*: LPARAM
    pfnCallback*: LPFNPSPCALLBACKW
    pcRefParent*: ptr UINT
    pszHeaderTitle*: LPCWSTR
    pszHeaderSubTitle*: LPCWSTR
    hActCtx*: HANDLE
  LPPROPSHEETPAGEW* = ptr PROPSHEETPAGEW
  LPCPROPSHEETPAGEW* = ptr PROPSHEETPAGEW
  PROPSHEETHEADERA_UNION1* {.pure, union.} = object
    hIcon*: HICON
    pszIcon*: LPCSTR
  PROPSHEETHEADERA_UNION2* {.pure, union.} = object
    nStartPage*: UINT
    pStartPage*: LPCSTR
  PROPSHEETHEADERA_UNION3* {.pure, union.} = object
    ppsp*: LPCPROPSHEETPAGEA
    phpage*: ptr HPROPSHEETPAGE
  PFNPROPSHEETCALLBACK* = proc (P1: HWND, P2: UINT, P3: LPARAM): int32 {.stdcall.}
  PROPSHEETHEADERA_UNION4* {.pure, union.} = object
    hbmWatermark*: HBITMAP
    pszbmWatermark*: LPCSTR
  PROPSHEETHEADERA_UNION5* {.pure, union.} = object
    hbmHeader*: HBITMAP
    pszbmHeader*: LPCSTR
  PROPSHEETHEADERA* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    hwndParent*: HWND
    hInstance*: HINSTANCE
    union1*: PROPSHEETHEADERA_UNION1
    pszCaption*: LPCSTR
    nPages*: UINT
    union2*: PROPSHEETHEADERA_UNION2
    union3*: PROPSHEETHEADERA_UNION3
    pfnCallback*: PFNPROPSHEETCALLBACK
    union4*: PROPSHEETHEADERA_UNION4
    hplWatermark*: HPALETTE
    union5*: PROPSHEETHEADERA_UNION5
  LPPROPSHEETHEADERA* = ptr PROPSHEETHEADERA
  LPCPROPSHEETHEADERA* = ptr PROPSHEETHEADERA
  PROPSHEETHEADERW_UNION1* {.pure, union.} = object
    hIcon*: HICON
    pszIcon*: LPCWSTR
  PROPSHEETHEADERW_UNION2* {.pure, union.} = object
    nStartPage*: UINT
    pStartPage*: LPCWSTR
  PROPSHEETHEADERW_UNION3* {.pure, union.} = object
    ppsp*: LPCPROPSHEETPAGEW
    phpage*: ptr HPROPSHEETPAGE
  PROPSHEETHEADERW_UNION4* {.pure, union.} = object
    hbmWatermark*: HBITMAP
    pszbmWatermark*: LPCWSTR
  PROPSHEETHEADERW_UNION5* {.pure, union.} = object
    hbmHeader*: HBITMAP
    pszbmHeader*: LPCWSTR
  PROPSHEETHEADERW* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    hwndParent*: HWND
    hInstance*: HINSTANCE
    union1*: PROPSHEETHEADERW_UNION1
    pszCaption*: LPCWSTR
    nPages*: UINT
    union2*: PROPSHEETHEADERW_UNION2
    union3*: PROPSHEETHEADERW_UNION3
    pfnCallback*: PFNPROPSHEETCALLBACK
    union4*: PROPSHEETHEADERW_UNION4
    hplWatermark*: HPALETTE
    union5*: PROPSHEETHEADERW_UNION5
  LPPROPSHEETHEADERW* = ptr PROPSHEETHEADERW
  LPCPROPSHEETHEADERW* = ptr PROPSHEETHEADERW
  PSHNOTIFY* {.pure.} = object
    hdr*: NMHDR
    lParam*: LPARAM
  LPPSHNOTIFY* = ptr PSHNOTIFY
  TINITCOMMONCONTROLSEX* {.pure.} = object
    dwSize*: DWORD
    dwICC*: DWORD
  LPINITCOMMONCONTROLSEX* = ptr TINITCOMMONCONTROLSEX
  COLORSCHEME* {.pure.} = object
    dwSize*: DWORD
    clrBtnHighlight*: COLORREF
    clrBtnShadow*: COLORREF
  LPCOLORSCHEME* = ptr COLORSCHEME
  TNMTOOLTIPSCREATED* {.pure.} = object
    hdr*: NMHDR
    hwndToolTips*: HWND
  LPNMTOOLTIPSCREATED* = ptr TNMTOOLTIPSCREATED
  NMMOUSE* {.pure.} = object
    hdr*: NMHDR
    dwItemSpec*: DWORD_PTR
    dwItemData*: DWORD_PTR
    pt*: POINT
    dwHitInfo*: LPARAM
  LPNMMOUSE* = ptr NMMOUSE
  TNMCLICK* = NMMOUSE
  LPNMCLICK* = LPNMMOUSE
  NMOBJECTNOTIFY* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    piid*: ptr IID
    pObject*: pointer
    hResult*: HRESULT
    dwFlags*: DWORD
  LPNMOBJECTNOTIFY* = ptr NMOBJECTNOTIFY
  NMKEY* {.pure.} = object
    hdr*: NMHDR
    nVKey*: UINT
    uFlags*: UINT
  LPNMKEY* = ptr NMKEY
  TNMCHAR* {.pure.} = object
    hdr*: NMHDR
    ch*: UINT
    dwItemPrev*: DWORD
    dwItemNext*: DWORD
  LPNMCHAR* = ptr TNMCHAR
  TNMCUSTOMTEXT* {.pure.} = object
    hdr*: NMHDR
    hDC*: HDC
    lpString*: LPCWSTR
    nCount*: int32
    lpRect*: LPRECT
    uFormat*: UINT
    fLink*: WINBOOL
  LPNMCUSTOMTEXT* = ptr TNMCUSTOMTEXT
  TNMCUSTOMDRAW* {.pure.} = object
    hdr*: NMHDR
    dwDrawStage*: DWORD
    hdc*: HDC
    rc*: RECT
    dwItemSpec*: DWORD_PTR
    uItemState*: UINT
    lItemlParam*: LPARAM
  LPNMCUSTOMDRAW* = ptr TNMCUSTOMDRAW
  NMTTCUSTOMDRAW* {.pure.} = object
    nmcd*: TNMCUSTOMDRAW
    uDrawFlags*: UINT
  LPNMTTCUSTOMDRAW* = ptr NMTTCUSTOMDRAW
  NMCUSTOMSPLITRECTINFO* {.pure.} = object
    hdr*: NMHDR
    rcClient*: RECT
    rcButton*: RECT
    rcSplit*: RECT
  LPNMCUSTOMSPLITRECTINFO* = ptr NMCUSTOMSPLITRECTINFO
  IMAGELISTDRAWPARAMS* {.pure.} = object
    cbSize*: DWORD
    himl*: HIMAGELIST
    i*: int32
    hdcDst*: HDC
    x*: int32
    y*: int32
    cx*: int32
    cy*: int32
    xBitmap*: int32
    yBitmap*: int32
    rgbBk*: COLORREF
    rgbFg*: COLORREF
    fStyle*: UINT
    dwRop*: DWORD
    fState*: DWORD
    Frame*: DWORD
    crEffect*: COLORREF
  LPIMAGELISTDRAWPARAMS* = ptr IMAGELISTDRAWPARAMS
  IMAGEINFO* {.pure.} = object
    hbmImage*: HBITMAP
    hbmMask*: HBITMAP
    Unused1*: int32
    Unused2*: int32
    rcImage*: RECT
  LPIMAGEINFO* = ptr IMAGEINFO
  HD_TEXTFILTERA* {.pure.} = object
    pszText*: LPSTR
    cchTextMax*: INT
  LPHD_TEXTFILTERA* = ptr HD_TEXTFILTERA
  HD_TEXTFILTERW* {.pure.} = object
    pszText*: LPWSTR
    cchTextMax*: INT
  LPHD_TEXTFILTERW* = ptr HD_TEXTFILTERW
  HDITEMA* {.pure.} = object
    mask*: UINT
    cxy*: int32
    pszText*: LPSTR
    hbm*: HBITMAP
    cchTextMax*: int32
    fmt*: int32
    lParam*: LPARAM
    iImage*: int32
    iOrder*: int32
    `type`*: UINT
    pvFilter*: pointer
    state*: UINT
  LPHDITEMA* = ptr HDITEMA
  HDITEMW* {.pure.} = object
    mask*: UINT
    cxy*: int32
    pszText*: LPWSTR
    hbm*: HBITMAP
    cchTextMax*: int32
    fmt*: int32
    lParam*: LPARAM
    iImage*: int32
    iOrder*: int32
    `type`*: UINT
    pvFilter*: pointer
    state*: UINT
  LPHDITEMW* = ptr HDITEMW
  HDLAYOUT* {.pure.} = object
    prc*: ptr RECT
    pwpos*: ptr WINDOWPOS
  LPHDLAYOUT* = ptr HDLAYOUT
  HDHITTESTINFO* {.pure.} = object
    pt*: POINT
    flags*: UINT
    iItem*: int32
  LPHDHITTESTINFO* = ptr HDHITTESTINFO
  NMHEADERA* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    iButton*: int32
    pitem*: ptr HDITEMA
  HD_NOTIFYA* = NMHEADERA
  NMHEADERW* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    iButton*: int32
    pitem*: ptr HDITEMW
  HD_NOTIFYW* = NMHEADERW
when winimUnicode:
  type
    NMHEADER* = NMHEADERW
when winimAnsi:
  type
    NMHEADER* = NMHEADERA
type
  HD_NOTIFY* = NMHEADER
  LPNMHEADERA* = ptr NMHEADERA
  LPNMHEADERW* = ptr NMHEADERW
  NMHDDISPINFOW* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    mask*: UINT
    pszText*: LPWSTR
    cchTextMax*: int32
    iImage*: int32
    lParam*: LPARAM
  LPNMHDDISPINFOW* = ptr NMHDDISPINFOW
  NMHDDISPINFOA* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    mask*: UINT
    pszText*: LPSTR
    cchTextMax*: int32
    iImage*: int32
    lParam*: LPARAM
  LPNMHDDISPINFOA* = ptr NMHDDISPINFOA
  NMHDFILTERBTNCLICK* {.pure.} = object
    hdr*: NMHDR
    iItem*: INT
    rc*: RECT
  LPNMHDFILTERBTNCLICK* = ptr NMHDFILTERBTNCLICK
when winimCpu64:
  type
    TBBUTTON* {.pure.} = object
      iBitmap*: int32
      idCommand*: int32
      fsState*: BYTE
      fsStyle*: BYTE
      bReserved*: array[6, BYTE]
      dwData*: DWORD_PTR
      iString*: INT_PTR
when winimCpu32:
  type
    TBBUTTON* {.pure.} = object
      iBitmap*: int32
      idCommand*: int32
      fsState*: BYTE
      fsStyle*: BYTE
      bReserved*: array[2, BYTE]
      dwData*: DWORD_PTR
      iString*: INT_PTR
type
  LPCTBBUTTON* = ptr TBBUTTON
  COLORMAP* {.pure.} = object
    `from`*: COLORREF
    to*: COLORREF
  LPCOLORMAP* = ptr COLORMAP
  NMTBCUSTOMDRAW* {.pure.} = object
    nmcd*: TNMCUSTOMDRAW
    hbrMonoDither*: HBRUSH
    hbrLines*: HBRUSH
    hpenLines*: HPEN
    clrText*: COLORREF
    clrMark*: COLORREF
    clrTextHighlight*: COLORREF
    clrBtnFace*: COLORREF
    clrBtnHighlight*: COLORREF
    clrHighlightHotTrack*: COLORREF
    rcText*: RECT
    nStringBkMode*: int32
    nHLStringBkMode*: int32
    iListGap*: int32
  LPNMTBCUSTOMDRAW* = ptr NMTBCUSTOMDRAW
  TTBADDBITMAP* {.pure.} = object
    hInst*: HINSTANCE
    nID*: UINT_PTR
  LPTBADDBITMAP* = ptr TTBADDBITMAP
  TBSAVEPARAMSA* {.pure.} = object
    hkr*: HKEY
    pszSubKey*: LPCSTR
    pszValueName*: LPCSTR
  LPTBSAVEPARAMSA* = ptr TBSAVEPARAMSA
  TBSAVEPARAMSW* {.pure.} = object
    hkr*: HKEY
    pszSubKey*: LPCWSTR
    pszValueName*: LPCWSTR
  LPTBSAVEPARAMW* = ptr TBSAVEPARAMSW
  TBINSERTMARK* {.pure.} = object
    iButton*: int32
    dwFlags*: DWORD
  LPTBINSERTMARK* = ptr TBINSERTMARK
  TTBREPLACEBITMAP* {.pure.} = object
    hInstOld*: HINSTANCE
    nIDOld*: UINT_PTR
    hInstNew*: HINSTANCE
    nIDNew*: UINT_PTR
    nButtons*: int32
  LPTBREPLACEBITMAP* = ptr TTBREPLACEBITMAP
  TBBUTTONINFOA* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    idCommand*: int32
    iImage*: int32
    fsState*: BYTE
    fsStyle*: BYTE
    cx*: WORD
    lParam*: DWORD_PTR
    pszText*: LPSTR
    cchText*: int32
  LPTBBUTTONINFOA* = ptr TBBUTTONINFOA
  TBBUTTONINFOW* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    idCommand*: int32
    iImage*: int32
    fsState*: BYTE
    fsStyle*: BYTE
    cx*: WORD
    lParam*: DWORD_PTR
    pszText*: LPWSTR
    cchText*: int32
  LPTBBUTTONINFOW* = ptr TBBUTTONINFOW
  TBMETRICS* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    cxPad*: int32
    cyPad*: int32
    cxBarPad*: int32
    cyBarPad*: int32
    cxButtonSpacing*: int32
    cyButtonSpacing*: int32
  LPTBMETRICS* = ptr TBMETRICS
  NMTBHOTITEM* {.pure.} = object
    hdr*: NMHDR
    idOld*: int32
    idNew*: int32
    dwFlags*: DWORD
  LPNMTBHOTITEM* = ptr NMTBHOTITEM
  NMTBSAVE* {.pure.} = object
    hdr*: NMHDR
    pData*: ptr DWORD
    pCurrent*: ptr DWORD
    cbData*: UINT
    iItem*: int32
    cButtons*: int32
    tbButton*: TBBUTTON
  LPNMTBSAVE* = ptr NMTBSAVE
  NMTBRESTORE* {.pure.} = object
    hdr*: NMHDR
    pData*: ptr DWORD
    pCurrent*: ptr DWORD
    cbData*: UINT
    iItem*: int32
    cButtons*: int32
    cbBytesPerRecord*: int32
    tbButton*: TBBUTTON
  LPNMTBRESTORE* = ptr NMTBRESTORE
  NMTBGETINFOTIPA* {.pure.} = object
    hdr*: NMHDR
    pszText*: LPSTR
    cchTextMax*: int32
    iItem*: int32
    lParam*: LPARAM
  LPNMTBGETINFOTIPA* = ptr NMTBGETINFOTIPA
  NMTBGETINFOTIPW* {.pure.} = object
    hdr*: NMHDR
    pszText*: LPWSTR
    cchTextMax*: int32
    iItem*: int32
    lParam*: LPARAM
  LPNMTBGETINFOTIPW* = ptr NMTBGETINFOTIPW
  NMTBDISPINFOA* {.pure.} = object
    hdr*: NMHDR
    dwMask*: DWORD
    idCommand*: int32
    lParam*: DWORD_PTR
    iImage*: int32
    pszText*: LPSTR
    cchText*: int32
  LPNMTBDISPINFOA* = ptr NMTBDISPINFOA
  NMTBDISPINFOW* {.pure.} = object
    hdr*: NMHDR
    dwMask*: DWORD
    idCommand*: int32
    lParam*: DWORD_PTR
    iImage*: int32
    pszText*: LPWSTR
    cchText*: int32
  LPNMTBDISPINFOW* = ptr NMTBDISPINFOW
  NMTOOLBARA* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    tbButton*: TBBUTTON
    cchText*: int32
    pszText*: LPSTR
    rcButton*: RECT
  TBNOTIFYA* = NMTOOLBARA
  NMTOOLBARW* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    tbButton*: TBBUTTON
    cchText*: int32
    pszText*: LPWSTR
    rcButton*: RECT
  TBNOTIFYW* = NMTOOLBARW
  LPNMTOOLBARA* = ptr NMTOOLBARA
  LPTBNOTIFYA* = LPNMTOOLBARA
  LPNMTOOLBARW* = ptr NMTOOLBARW
  LPTBNOTIFYW* = LPNMTOOLBARW
when winimUnicode:
  type
    NMTOOLBAR* = NMTOOLBARW
when winimAnsi:
  type
    NMTOOLBAR* = NMTOOLBARA
type
  TBNOTIFY* = NMTOOLBAR
when winimUnicode:
  type
    LPNMTOOLBAR* = LPNMTOOLBARW
when winimAnsi:
  type
    LPNMTOOLBAR* = LPNMTOOLBARA
type
  LPTBNOTIFY* = LPNMTOOLBAR
  REBARINFO* {.pure.} = object
    cbSize*: UINT
    fMask*: UINT
    himl*: HIMAGELIST
  LPREBARINFO* = ptr REBARINFO
  REBARBANDINFOA* {.pure.} = object
    cbSize*: UINT
    fMask*: UINT
    fStyle*: UINT
    clrFore*: COLORREF
    clrBack*: COLORREF
    lpText*: LPSTR
    cch*: UINT
    iImage*: int32
    hwndChild*: HWND
    cxMinChild*: UINT
    cyMinChild*: UINT
    cx*: UINT
    hbmBack*: HBITMAP
    wID*: UINT
    cyChild*: UINT
    cyMaxChild*: UINT
    cyIntegral*: UINT
    cxIdeal*: UINT
    lParam*: LPARAM
    cxHeader*: UINT
    rcChevronLocation*: RECT
    uChevronState*: UINT
  LPREBARBANDINFOA* = ptr REBARBANDINFOA
  LPCREBARBANDINFOA* = ptr REBARBANDINFOA
  REBARBANDINFOW* {.pure.} = object
    cbSize*: UINT
    fMask*: UINT
    fStyle*: UINT
    clrFore*: COLORREF
    clrBack*: COLORREF
    lpText*: LPWSTR
    cch*: UINT
    iImage*: int32
    hwndChild*: HWND
    cxMinChild*: UINT
    cyMinChild*: UINT
    cx*: UINT
    hbmBack*: HBITMAP
    wID*: UINT
    cyChild*: UINT
    cyMaxChild*: UINT
    cyIntegral*: UINT
    cxIdeal*: UINT
    lParam*: LPARAM
    cxHeader*: UINT
    rcChevronLocation*: RECT
    uChevronState*: UINT
  LPREBARBANDINFOW* = ptr REBARBANDINFOW
  LPCREBARBANDINFOW* = ptr REBARBANDINFOW
  NMREBARCHILDSIZE* {.pure.} = object
    hdr*: NMHDR
    uBand*: UINT
    wID*: UINT
    rcChild*: RECT
    rcBand*: RECT
  LPNMREBARCHILDSIZE* = ptr NMREBARCHILDSIZE
  NMREBAR* {.pure.} = object
    hdr*: NMHDR
    dwMask*: DWORD
    uBand*: UINT
    fStyle*: UINT
    wID*: UINT
    lParam*: LPARAM
  LPNMREBAR* = ptr NMREBAR
  NMRBAUTOSIZE* {.pure.} = object
    hdr*: NMHDR
    fChanged*: WINBOOL
    rcTarget*: RECT
    rcActual*: RECT
  LPNMRBAUTOSIZE* = ptr NMRBAUTOSIZE
  NMREBARCHEVRON* {.pure.} = object
    hdr*: NMHDR
    uBand*: UINT
    wID*: UINT
    lParam*: LPARAM
    rc*: RECT
    lParamNM*: LPARAM
  LPNMREBARCHEVRON* = ptr NMREBARCHEVRON
  NMREBARSPLITTER* {.pure.} = object
    hdr*: NMHDR
    rcSizing*: RECT
  LPNMREBARSPLITTER* = ptr NMREBARSPLITTER
  NMREBARAUTOBREAK* {.pure.} = object
    hdr*: NMHDR
    uBand*: UINT
    wID*: UINT
    lParam*: LPARAM
    uMsg*: UINT
    fStyleCurrent*: UINT
    fAutoBreak*: WINBOOL
  LPNMREBARAUTOBREAK* = ptr NMREBARAUTOBREAK
  RBHITTESTINFO* {.pure.} = object
    pt*: POINT
    flags*: UINT
    iBand*: int32
  LPRBHITTESTINFO* = ptr RBHITTESTINFO
  TTTOOLINFOA* {.pure.} = object
    cbSize*: UINT
    uFlags*: UINT
    hwnd*: HWND
    uId*: UINT_PTR
    rect*: RECT
    hinst*: HINSTANCE
    lpszText*: LPSTR
    lParam*: LPARAM
    lpReserved*: pointer
  LPTTTOOLINFOA* = ptr TTTOOLINFOA
  LPTOOLINFOA* = LPTTTOOLINFOA
  TTTOOLINFOW* {.pure.} = object
    cbSize*: UINT
    uFlags*: UINT
    hwnd*: HWND
    uId*: UINT_PTR
    rect*: RECT
    hinst*: HINSTANCE
    lpszText*: LPWSTR
    lParam*: LPARAM
    lpReserved*: pointer
  LPTTTOOLINFOW* = ptr TTTOOLINFOW
  LPTOOLINFOW* = LPTTTOOLINFOW
  TOOLINFOA* = TTTOOLINFOA
  TOOLINFOW* = TTTOOLINFOW
when winimUnicode:
  type
    LPTTTOOLINFO* = LPTTTOOLINFOW
when winimAnsi:
  type
    LPTTTOOLINFO* = LPTTTOOLINFOA
type
  LPTOOLINFO* = LPTTTOOLINFO
  PTOOLINFOA* = ptr TTTOOLINFOA
  PTOOLINFOW* = ptr TTTOOLINFOW
  TTGETTITLE* {.pure.} = object
    dwSize*: DWORD
    uTitleBitmap*: UINT
    cch*: UINT
    pszTitle*: ptr WCHAR
  PTTGETTITLE* = ptr TTGETTITLE
  TTHITTESTINFOW* {.pure.} = object
    hwnd*: HWND
    pt*: POINT
    ti*: TTTOOLINFOW
  LPTTHITTESTINFOW* = ptr TTHITTESTINFOW
  LPHITTESTINFOW* = LPTTHITTESTINFOW
  TTHITTESTINFOA* {.pure.} = object
    hwnd*: HWND
    pt*: POINT
    ti*: TTTOOLINFOA
  LPTTHITTESTINFOA* = ptr TTHITTESTINFOA
  LPHITTESTINFOA* = LPTTHITTESTINFOA
when winimUnicode:
  type
    LPTTHITTESTINFO* = LPTTHITTESTINFOW
when winimAnsi:
  type
    LPTTHITTESTINFO* = LPTTHITTESTINFOA
type
  LPHITTESTINFO* = LPTTHITTESTINFO
  NMTTDISPINFOW* {.pure.} = object
    hdr*: NMHDR
    lpszText*: LPWSTR
    szText*: array[80, WCHAR]
    hinst*: HINSTANCE
    uFlags*: UINT
    lParam*: LPARAM
  TOOLTIPTEXTW* = NMTTDISPINFOW
  NMTTDISPINFOA* {.pure.} = object
    hdr*: NMHDR
    lpszText*: LPSTR
    szText*: array[80, char]
    hinst*: HINSTANCE
    uFlags*: UINT
    lParam*: LPARAM
  TOOLTIPTEXTA* = NMTTDISPINFOA
  LPNMTTDISPINFOA* = ptr NMTTDISPINFOA
  LPTOOLTIPTEXTA* = LPNMTTDISPINFOA
  LPNMTTDISPINFOW* = ptr NMTTDISPINFOW
  LPTOOLTIPTEXTW* = LPNMTTDISPINFOW
when winimUnicode:
  type
    NMTTDISPINFO* = NMTTDISPINFOW
when winimAnsi:
  type
    NMTTDISPINFO* = NMTTDISPINFOA
type
  TOOLTIPTEXT* = NMTTDISPINFO
when winimUnicode:
  type
    LPNMTTDISPINFO* = LPNMTTDISPINFOW
when winimAnsi:
  type
    LPNMTTDISPINFO* = LPNMTTDISPINFOA
type
  LPTOOLTIPTEXT* = LPNMTTDISPINFO
  DRAGLISTINFO* {.pure.} = object
    uNotification*: UINT
    hWnd*: HWND
    ptCursor*: POINT
  LPDRAGLISTINFO* = ptr DRAGLISTINFO
  UDACCEL* {.pure.} = object
    nSec*: UINT
    nInc*: UINT
  LPUDACCEL* = ptr UDACCEL
  NMUPDOWN* {.pure.} = object
    hdr*: NMHDR
    iPos*: int32
    iDelta*: int32
  LPNMUPDOWN* = ptr NMUPDOWN
  PBRANGE* {.pure.} = object
    iLow*: int32
    iHigh*: int32
  PPBRANGE* = ptr PBRANGE
const
  MAX_LINKID_TEXT* = 48
  L_MAX_URL_LENGTH* = 2084
type
  LITEM* {.pure.} = object
    mask*: UINT
    iLink*: int32
    state*: UINT
    stateMask*: UINT
    szID*: array[MAX_LINKID_TEXT, WCHAR]
    szUrl*: array[L_MAX_URL_LENGTH, WCHAR]
  PLITEM* = ptr LITEM
  LHITTESTINFO* {.pure.} = object
    pt*: POINT
    item*: LITEM
  PLHITTESTINFO* = ptr LHITTESTINFO
  NMLINK* {.pure.} = object
    hdr*: NMHDR
    item*: LITEM
  PNMLINK* = ptr NMLINK
  LVITEMA* {.pure.} = object
    mask*: UINT
    iItem*: int32
    iSubItem*: int32
    state*: UINT
    stateMask*: UINT
    pszText*: LPSTR
    cchTextMax*: int32
    iImage*: int32
    lParam*: LPARAM
    iIndent*: int32
    iGroupId*: int32
    cColumns*: UINT
    puColumns*: PUINT
    piColFmt*: ptr int32
    iGroup*: int32
  LPLVITEMA* = ptr LVITEMA
  LVITEMW* {.pure.} = object
    mask*: UINT
    iItem*: int32
    iSubItem*: int32
    state*: UINT
    stateMask*: UINT
    pszText*: LPWSTR
    cchTextMax*: int32
    iImage*: int32
    lParam*: LPARAM
    iIndent*: int32
    iGroupId*: int32
    cColumns*: UINT
    puColumns*: PUINT
    piColFmt*: ptr int32
    iGroup*: int32
  LPLVITEMW* = ptr LVITEMW
  LVFINDINFOA* {.pure.} = object
    flags*: UINT
    psz*: LPCSTR
    lParam*: LPARAM
    pt*: POINT
    vkDirection*: UINT
  LPFINDINFOA* = ptr LVFINDINFOA
  LVFINDINFOW* {.pure.} = object
    flags*: UINT
    psz*: LPCWSTR
    lParam*: LPARAM
    pt*: POINT
    vkDirection*: UINT
  LPFINDINFOW* = ptr LVFINDINFOW
  LVHITTESTINFO* {.pure.} = object
    pt*: POINT
    flags*: UINT
    iItem*: int32
    iSubItem*: int32
    iGroup*: int32
  LPLVHITTESTINFO* = ptr LVHITTESTINFO
  LVCOLUMNA* {.pure.} = object
    mask*: UINT
    fmt*: int32
    cx*: int32
    pszText*: LPSTR
    cchTextMax*: int32
    iSubItem*: int32
    iImage*: int32
    iOrder*: int32
    cxMin*: int32
    cxDefault*: int32
    cxIdeal*: int32
  LPLVCOLUMNA* = ptr LVCOLUMNA
  LVCOLUMNW* {.pure.} = object
    mask*: UINT
    fmt*: int32
    cx*: int32
    pszText*: LPWSTR
    cchTextMax*: int32
    iSubItem*: int32
    iImage*: int32
    iOrder*: int32
    cxMin*: int32
    cxDefault*: int32
    cxIdeal*: int32
  LPLVCOLUMNW* = ptr LVCOLUMNW
  LVBKIMAGEA* {.pure.} = object
    ulFlags*: ULONG
    hbm*: HBITMAP
    pszImage*: LPSTR
    cchImageMax*: UINT
    xOffsetPercent*: int32
    yOffsetPercent*: int32
  LPLVBKIMAGEA* = ptr LVBKIMAGEA
  LVBKIMAGEW* {.pure.} = object
    ulFlags*: ULONG
    hbm*: HBITMAP
    pszImage*: LPWSTR
    cchImageMax*: UINT
    xOffsetPercent*: int32
    yOffsetPercent*: int32
  LPLVBKIMAGEW* = ptr LVBKIMAGEW
  LVGROUP* {.pure.} = object
    cbSize*: UINT
    mask*: UINT
    pszHeader*: LPWSTR
    cchHeader*: int32
    pszFooter*: LPWSTR
    cchFooter*: int32
    iGroupId*: int32
    stateMask*: UINT
    state*: UINT
    uAlign*: UINT
    pszSubtitle*: LPWSTR
    cchSubtitle*: UINT
    pszTask*: LPWSTR
    cchTask*: UINT
    pszDescriptionTop*: LPWSTR
    cchDescriptionTop*: UINT
    pszDescriptionBottom*: LPWSTR
    cchDescriptionBottom*: UINT
    iTitleImage*: int32
    iExtendedImage*: int32
    iFirstItem*: int32
    cItems*: UINT
    pszSubsetTitle*: LPWSTR
    cchSubsetTitle*: UINT
  PLVGROUP* = ptr LVGROUP
  LVGROUPMETRICS* {.pure.} = object
    cbSize*: UINT
    mask*: UINT
    Left*: UINT
    Top*: UINT
    Right*: UINT
    Bottom*: UINT
    crLeft*: COLORREF
    crTop*: COLORREF
    crRight*: COLORREF
    crBottom*: COLORREF
    crHeader*: COLORREF
    crFooter*: COLORREF
  PLVGROUPMETRICS* = ptr LVGROUPMETRICS
  PFNLVGROUPCOMPARE* = proc (P1: int32, P2: int32, P3: pointer): int32 {.stdcall.}
  LVINSERTGROUPSORTED* {.pure.} = object
    pfnGroupCompare*: PFNLVGROUPCOMPARE
    pvData*: pointer
    lvGroup*: LVGROUP
  PLVINSERTGROUPSORTED* = ptr LVINSERTGROUPSORTED
  LVTILEVIEWINFO* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    dwFlags*: DWORD
    sizeTile*: SIZE
    cLines*: int32
    rcLabelMargin*: RECT
  PLVTILEVIEWINFO* = ptr LVTILEVIEWINFO
  LVTILEINFO* {.pure.} = object
    cbSize*: UINT
    iItem*: int32
    cColumns*: UINT
    puColumns*: PUINT
    piColFmt*: ptr int32
  PLVTILEINFO* = ptr LVTILEINFO
  LVINSERTMARK* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    iItem*: int32
    dwReserved*: DWORD
  LPLVINSERTMARK* = ptr LVINSERTMARK
  LVSETINFOTIP* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    pszText*: LPWSTR
    iItem*: int32
    iSubItem*: int32
  PLVSETINFOTIP* = ptr LVSETINFOTIP
  LVFOOTERINFO* {.pure.} = object
    mask*: UINT
    pszText*: LPWSTR
    cchTextMax*: int32
    cItems*: UINT
  LPLVFOOTERINFO* = ptr LVFOOTERINFO
  LVFOOTERITEM* {.pure.} = object
    mask*: UINT
    iItem*: int32
    pszText*: LPWSTR
    cchTextMax*: int32
    state*: UINT
    stateMask*: UINT
  LPLVFOOTERITEM* = ptr LVFOOTERITEM
  LVITEMINDEX* {.pure.} = object
    iItem*: int32
    iGroup*: int32
  PLVITEMINDEX* = ptr LVITEMINDEX
  NMLISTVIEW* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    iSubItem*: int32
    uNewState*: UINT
    uOldState*: UINT
    uChanged*: UINT
    ptAction*: POINT
    lParam*: LPARAM
  LPNMLISTVIEW* = ptr NMLISTVIEW
  NMITEMACTIVATE* {.pure.} = object
    hdr*: NMHDR
    iItem*: int32
    iSubItem*: int32
    uNewState*: UINT
    uOldState*: UINT
    uChanged*: UINT
    ptAction*: POINT
    lParam*: LPARAM
    uKeyFlags*: UINT
  LPNMITEMACTIVATE* = ptr NMITEMACTIVATE
  NMLVCUSTOMDRAW* {.pure.} = object
    nmcd*: TNMCUSTOMDRAW
    clrText*: COLORREF
    clrTextBk*: COLORREF
    iSubItem*: int32
    dwItemType*: DWORD
    clrFace*: COLORREF
    iIconEffect*: int32
    iIconPhase*: int32
    iPartId*: int32
    iStateId*: int32
    rcText*: RECT
    uAlign*: UINT
  LPNMLVCUSTOMDRAW* = ptr NMLVCUSTOMDRAW
  NMLVCACHEHINT* {.pure.} = object
    hdr*: NMHDR
    iFrom*: int32
    iTo*: int32
  LPNMLVCACHEHINT* = ptr NMLVCACHEHINT
  LPNM_CACHEHINT* = LPNMLVCACHEHINT
  PNM_CACHEHINT* = LPNMLVCACHEHINT
  NM_CACHEHINT* = NMLVCACHEHINT
  NMLVFINDITEMA* {.pure.} = object
    hdr*: NMHDR
    iStart*: int32
    lvfi*: LVFINDINFOA
  LPNMLVFINDITEMA* = ptr NMLVFINDITEMA
  NMLVFINDITEMW* {.pure.} = object
    hdr*: NMHDR
    iStart*: int32
    lvfi*: LVFINDINFOW
  LPNMLVFINDITEMW* = ptr NMLVFINDITEMW
  PNM_FINDITEMA* = LPNMLVFINDITEMA
  LPNM_FINDITEMA* = LPNMLVFINDITEMA
  NM_FINDITEMA* = NMLVFINDITEMA
  PNM_FINDITEMW* = LPNMLVFINDITEMW
  LPNM_FINDITEMW* = LPNMLVFINDITEMW
  NM_FINDITEMW* = NMLVFINDITEMW
  NMLVODSTATECHANGE* {.pure.} = object
    hdr*: NMHDR
    iFrom*: int32
    iTo*: int32
    uNewState*: UINT
    uOldState*: UINT
  LPNMLVODSTATECHANGE* = ptr NMLVODSTATECHANGE
  PNM_ODSTATECHANGE* = LPNMLVODSTATECHANGE
  LPNM_ODSTATECHANGE* = LPNMLVODSTATECHANGE
  NM_ODSTATECHANGE* = NMLVODSTATECHANGE
  NMLVDISPINFOA* {.pure.} = object
    hdr*: NMHDR
    item*: LVITEMA
  LV_DISPINFOA* = NMLVDISPINFOA
  NMLVDISPINFOW* {.pure.} = object
    hdr*: NMHDR
    item*: LVITEMW
  LV_DISPINFOW* = NMLVDISPINFOW
when winimUnicode:
  type
    NMLVDISPINFO* = NMLVDISPINFOW
when winimAnsi:
  type
    NMLVDISPINFO* = NMLVDISPINFOA
type
  LV_DISPINFO* = NMLVDISPINFO
  LPNMLVDISPINFOA* = ptr NMLVDISPINFOA
  LPNMLVDISPINFOW* = ptr NMLVDISPINFOW
  NMLVKEYDOWN* {.pure, packed.} = object
    hdr*: NMHDR
    wVKey*: WORD
    flags*: UINT
  LV_KEYDOWN* = NMLVKEYDOWN
  LPNMLVKEYDOWN* = ptr NMLVKEYDOWN
  NMLVLINK* {.pure.} = object
    hdr*: NMHDR
    link*: LITEM
    iItem*: int32
    iSubItem*: int32
  PNMLVLINK* = ptr NMLVLINK
  NMLVGETINFOTIPA* {.pure.} = object
    hdr*: NMHDR
    dwFlags*: DWORD
    pszText*: LPSTR
    cchTextMax*: int32
    iItem*: int32
    iSubItem*: int32
    lParam*: LPARAM
  LPNMLVGETINFOTIPA* = ptr NMLVGETINFOTIPA
  NMLVGETINFOTIPW* {.pure.} = object
    hdr*: NMHDR
    dwFlags*: DWORD
    pszText*: LPWSTR
    cchTextMax*: int32
    iItem*: int32
    iSubItem*: int32
    lParam*: LPARAM
  LPNMLVGETINFOTIPW* = ptr NMLVGETINFOTIPW
  NMLVSCROLL* {.pure.} = object
    hdr*: NMHDR
    dx*: int32
    dy*: int32
  LPNMLVSCROLL* = ptr NMLVSCROLL
  TNMTVSTATEIMAGECHANGING* {.pure.} = object
    hdr*: NMHDR
    hti*: HTREEITEM
    iOldStateImageIndex*: int32
    iNewStateImageIndex*: int32
  LPNMTVSTATEIMAGECHANGING* = ptr TNMTVSTATEIMAGECHANGING
  TVITEMA* {.pure.} = object
    mask*: UINT
    hItem*: HTREEITEM
    state*: UINT
    stateMask*: UINT
    pszText*: LPSTR
    cchTextMax*: int32
    iImage*: int32
    iSelectedImage*: int32
    cChildren*: int32
    lParam*: LPARAM
  LPTVITEMA* = ptr TVITEMA
  TVITEMW* {.pure.} = object
    mask*: UINT
    hItem*: HTREEITEM
    state*: UINT
    stateMask*: UINT
    pszText*: LPWSTR
    cchTextMax*: int32
    iImage*: int32
    iSelectedImage*: int32
    cChildren*: int32
    lParam*: LPARAM
  LPTVITEMW* = ptr TVITEMW
  TVITEMEXA* {.pure.} = object
    mask*: UINT
    hItem*: HTREEITEM
    state*: UINT
    stateMask*: UINT
    pszText*: LPSTR
    cchTextMax*: int32
    iImage*: int32
    iSelectedImage*: int32
    cChildren*: int32
    lParam*: LPARAM
    iIntegral*: int32
    uStateEx*: UINT
    hwnd*: HWND
    iExpandedImage*: int32
    iReserved*: int32
  LPTVITEMEXA* = ptr TVITEMEXA
  TVITEMEXW* {.pure.} = object
    mask*: UINT
    hItem*: HTREEITEM
    state*: UINT
    stateMask*: UINT
    pszText*: LPWSTR
    cchTextMax*: int32
    iImage*: int32
    iSelectedImage*: int32
    cChildren*: int32
    lParam*: LPARAM
    iIntegral*: int32
    uStateEx*: UINT
    hwnd*: HWND
    iExpandedImage*: int32
    iReserved*: int32
  LPTVITEMEXW* = ptr TVITEMEXW
  TVINSERTSTRUCTA_UNION1* {.pure, union.} = object
    itemex*: TVITEMEXA
    item*: TV_ITEMA
  TVINSERTSTRUCTA* {.pure.} = object
    hParent*: HTREEITEM
    hInsertAfter*: HTREEITEM
    union1*: TVINSERTSTRUCTA_UNION1
  LPTVINSERTSTRUCTA* = ptr TVINSERTSTRUCTA
  TVINSERTSTRUCTW_UNION1* {.pure, union.} = object
    itemex*: TVITEMEXW
    item*: TV_ITEMW
  TVINSERTSTRUCTW* {.pure.} = object
    hParent*: HTREEITEM
    hInsertAfter*: HTREEITEM
    union1*: TVINSERTSTRUCTW_UNION1
  LPTVINSERTSTRUCTW* = ptr TVINSERTSTRUCTW
  TVHITTESTINFO* {.pure.} = object
    pt*: POINT
    flags*: UINT
    hItem*: HTREEITEM
  LPTVHITTESTINFO* = ptr TVHITTESTINFO
  PFNTVCOMPARE* = proc (lParam1: LPARAM, lParam2: LPARAM, lParamSort: LPARAM): int32 {.stdcall.}
  TVSORTCB* {.pure.} = object
    hParent*: HTREEITEM
    lpfnCompare*: PFNTVCOMPARE
    lParam*: LPARAM
  LPTVSORTCB* = ptr TVSORTCB
  NMTREEVIEWA* {.pure.} = object
    hdr*: NMHDR
    action*: UINT
    itemOld*: TVITEMA
    itemNew*: TVITEMA
    ptDrag*: POINT
  LPNMTREEVIEWA* = ptr NMTREEVIEWA
  NMTREEVIEWW* {.pure.} = object
    hdr*: NMHDR
    action*: UINT
    itemOld*: TVITEMW
    itemNew*: TVITEMW
    ptDrag*: POINT
  LPNMTREEVIEWW* = ptr NMTREEVIEWW
  NMTVDISPINFOA* {.pure.} = object
    hdr*: NMHDR
    item*: TVITEMA
  TV_DISPINFOA* = NMTVDISPINFOA
  NMTVDISPINFOW* {.pure.} = object
    hdr*: NMHDR
    item*: TVITEMW
  TV_DISPINFOW* = NMTVDISPINFOW
when winimUnicode:
  type
    NMTVDISPINFO* = NMTVDISPINFOW
when winimAnsi:
  type
    NMTVDISPINFO* = NMTVDISPINFOA
type
  TV_DISPINFO* = NMTVDISPINFO
  LPNMTVDISPINFOA* = ptr NMTVDISPINFOA
  LPNMTVDISPINFOW* = ptr NMTVDISPINFOW
  NMTVDISPINFOEXA* {.pure.} = object
    hdr*: NMHDR
    item*: TVITEMEXA
  LPNMTVDISPINFOEXA* = ptr NMTVDISPINFOEXA
  NMTVDISPINFOEXW* {.pure.} = object
    hdr*: NMHDR
    item*: TVITEMEXW
  LPNMTVDISPINFOEXW* = ptr NMTVDISPINFOEXW
  TV_DISPINFOEXA* = NMTVDISPINFOEXA
  TV_DISPINFOEXW* = NMTVDISPINFOEXW
when winimUnicode:
  type
    NMTVDISPINFOEX* = NMTVDISPINFOEXW
when winimAnsi:
  type
    NMTVDISPINFOEX* = NMTVDISPINFOEXA
type
  TV_DISPINFOEX* = NMTVDISPINFOEX
  NMTVKEYDOWN* {.pure, packed.} = object
    hdr*: NMHDR
    wVKey*: WORD
    flags*: UINT
  TV_KEYDOWN* = NMTVKEYDOWN
  LPNMTVKEYDOWN* = ptr NMTVKEYDOWN
  NMTVCUSTOMDRAW* {.pure.} = object
    nmcd*: TNMCUSTOMDRAW
    clrText*: COLORREF
    clrTextBk*: COLORREF
    iLevel*: int32
  LPNMTVCUSTOMDRAW* = ptr NMTVCUSTOMDRAW
  NMTVGETINFOTIPA* {.pure.} = object
    hdr*: NMHDR
    pszText*: LPSTR
    cchTextMax*: int32
    hItem*: HTREEITEM
    lParam*: LPARAM
  LPNMTVGETINFOTIPA* = ptr NMTVGETINFOTIPA
  NMTVGETINFOTIPW* {.pure.} = object
    hdr*: NMHDR
    pszText*: LPWSTR
    cchTextMax*: int32
    hItem*: HTREEITEM
    lParam*: LPARAM
  LPNMTVGETINFOTIPW* = ptr NMTVGETINFOTIPW
  COMBOBOXEXITEMA* {.pure.} = object
    mask*: UINT
    iItem*: INT_PTR
    pszText*: LPSTR
    cchTextMax*: int32
    iImage*: int32
    iSelectedImage*: int32
    iOverlay*: int32
    iIndent*: int32
    lParam*: LPARAM
  PCOMBOBOXEXITEMA* = ptr COMBOBOXEXITEMA
  PCCOMBOEXITEMA* = ptr COMBOBOXEXITEMA
  COMBOBOXEXITEMW* {.pure.} = object
    mask*: UINT
    iItem*: INT_PTR
    pszText*: LPWSTR
    cchTextMax*: int32
    iImage*: int32
    iSelectedImage*: int32
    iOverlay*: int32
    iIndent*: int32
    lParam*: LPARAM
  PCOMBOBOXEXITEMW* = ptr COMBOBOXEXITEMW
  PCCOMBOEXITEMW* = ptr COMBOBOXEXITEMW
  NMCOMBOBOXEXA* {.pure.} = object
    hdr*: NMHDR
    ceItem*: COMBOBOXEXITEMA
  PNMCOMBOBOXEXA* = ptr NMCOMBOBOXEXA
  NMCOMBOBOXEXW* {.pure.} = object
    hdr*: NMHDR
    ceItem*: COMBOBOXEXITEMW
  PNMCOMBOBOXEXW* = ptr NMCOMBOBOXEXW
const
  CBEMAXSTRLEN* = 260
type
  NMCBEDRAGBEGINW* {.pure.} = object
    hdr*: NMHDR
    iItemid*: int32
    szText*: array[CBEMAXSTRLEN, WCHAR]
  LPNMCBEDRAGBEGINW* = ptr NMCBEDRAGBEGINW
  PNMCBEDRAGBEGINW* = ptr NMCBEDRAGBEGINW
  NMCBEDRAGBEGINA* {.pure.} = object
    hdr*: NMHDR
    iItemid*: int32
    szText*: array[CBEMAXSTRLEN, char]
  LPNMCBEDRAGBEGINA* = ptr NMCBEDRAGBEGINA
  PNMCBEDRAGBEGINA* = ptr NMCBEDRAGBEGINA
  NMCBEENDEDITW* {.pure.} = object
    hdr*: NMHDR
    fChanged*: WINBOOL
    iNewSelection*: int32
    szText*: array[CBEMAXSTRLEN, WCHAR]
    iWhy*: int32
  LPNMCBEENDEDITW* = ptr NMCBEENDEDITW
  PNMCBEENDEDITW* = ptr NMCBEENDEDITW
  NMCBEENDEDITA* {.pure.} = object
    hdr*: NMHDR
    fChanged*: WINBOOL
    iNewSelection*: int32
    szText*: array[CBEMAXSTRLEN, char]
    iWhy*: int32
  LPNMCBEENDEDITA* = ptr NMCBEENDEDITA
  PNMCBEENDEDITA* = ptr NMCBEENDEDITA
  TCITEMHEADERA* {.pure.} = object
    mask*: UINT
    lpReserved1*: UINT
    lpReserved2*: UINT
    pszText*: LPSTR
    cchTextMax*: int32
    iImage*: int32
  LPTCITEMHEADERA* = ptr TCITEMHEADERA
  TCITEMHEADERW* {.pure.} = object
    mask*: UINT
    lpReserved1*: UINT
    lpReserved2*: UINT
    pszText*: LPWSTR
    cchTextMax*: int32
    iImage*: int32
  LPTCITEMHEADERW* = ptr TCITEMHEADERW
  TCITEMA* {.pure.} = object
    mask*: UINT
    dwState*: DWORD
    dwStateMask*: DWORD
    pszText*: LPSTR
    cchTextMax*: int32
    iImage*: int32
    lParam*: LPARAM
  LPTCITEMA* = ptr TCITEMA
  TCITEMW* {.pure.} = object
    mask*: UINT
    dwState*: DWORD
    dwStateMask*: DWORD
    pszText*: LPWSTR
    cchTextMax*: int32
    iImage*: int32
    lParam*: LPARAM
  LPTCITEMW* = ptr TCITEMW
  TCHITTESTINFO* {.pure.} = object
    pt*: POINT
    flags*: UINT
  LPTCHITTESTINFO* = ptr TCHITTESTINFO
  NMTCKEYDOWN* {.pure, packed.} = object
    hdr*: NMHDR
    wVKey*: WORD
    flags*: UINT
  TC_KEYDOWN* = NMTCKEYDOWN
  MCHITTESTINFO* {.pure.} = object
    cbSize*: UINT
    pt*: POINT
    uHit*: UINT
    st*: SYSTEMTIME
    rc*: RECT
    iOffset*: int32
    iRow*: int32
    iCol*: int32
  PMCHITTESTINFO* = ptr MCHITTESTINFO
  MCGRIDINFO* {.pure.} = object
    cbSize*: UINT
    dwPart*: DWORD
    dwFlags*: DWORD
    iCalendar*: int32
    iRow*: int32
    iCol*: int32
    bSelected*: WINBOOL
    stStart*: SYSTEMTIME
    stEnd*: SYSTEMTIME
    rc*: RECT
    pszName*: PWSTR
    cchName*: int
  PMCGRIDINFO* = ptr MCGRIDINFO
  NMSELCHANGE* {.pure.} = object
    nmhdr*: NMHDR
    stSelStart*: SYSTEMTIME
    stSelEnd*: SYSTEMTIME
  LPNMSELCHANGE* = ptr NMSELCHANGE
  NMDAYSTATE* {.pure.} = object
    nmhdr*: NMHDR
    stStart*: SYSTEMTIME
    cDayState*: int32
    prgDayState*: LPMONTHDAYSTATE
  LPNMDAYSTATE* = ptr NMDAYSTATE
  NMSELECT* = NMSELCHANGE
  LPNMSELECT* = ptr NMSELCHANGE
  NMVIEWCHANGE* {.pure.} = object
    nmhdr*: NMHDR
    dwOldView*: DWORD
    dwNewView*: DWORD
  LPNMVIEWCHANGE* = ptr NMVIEWCHANGE
  DATETIMEPICKERINFO* {.pure.} = object
    cbSize*: DWORD
    rcCheck*: RECT
    stateCheck*: DWORD
    rcButton*: RECT
    stateButton*: DWORD
    hwndEdit*: HWND
    hwndUD*: HWND
    hwndDropDown*: HWND
  LPDATETIMEPICKERINFO* = ptr DATETIMEPICKERINFO
  NMDATETIMECHANGE* {.pure.} = object
    nmhdr*: NMHDR
    dwFlags*: DWORD
    st*: SYSTEMTIME
  LPNMDATETIMECHANGE* = ptr NMDATETIMECHANGE
  NMDATETIMESTRINGA* {.pure.} = object
    nmhdr*: NMHDR
    pszUserString*: LPCSTR
    st*: SYSTEMTIME
    dwFlags*: DWORD
  LPNMDATETIMESTRINGA* = ptr NMDATETIMESTRINGA
  NMDATETIMESTRINGW* {.pure.} = object
    nmhdr*: NMHDR
    pszUserString*: LPCWSTR
    st*: SYSTEMTIME
    dwFlags*: DWORD
  LPNMDATETIMESTRINGW* = ptr NMDATETIMESTRINGW
  NMDATETIMEWMKEYDOWNA* {.pure.} = object
    nmhdr*: NMHDR
    nVirtKey*: int32
    pszFormat*: LPCSTR
    st*: SYSTEMTIME
  LPNMDATETIMEWMKEYDOWNA* = ptr NMDATETIMEWMKEYDOWNA
  NMDATETIMEWMKEYDOWNW* {.pure.} = object
    nmhdr*: NMHDR
    nVirtKey*: int32
    pszFormat*: LPCWSTR
    st*: SYSTEMTIME
  LPNMDATETIMEWMKEYDOWNW* = ptr NMDATETIMEWMKEYDOWNW
  NMDATETIMEFORMATA* {.pure.} = object
    nmhdr*: NMHDR
    pszFormat*: LPCSTR
    st*: SYSTEMTIME
    pszDisplay*: LPCSTR
    szDisplay*: array[64, CHAR]
  LPNMDATETIMEFORMATA* = ptr NMDATETIMEFORMATA
  NMDATETIMEFORMATW* {.pure.} = object
    nmhdr*: NMHDR
    pszFormat*: LPCWSTR
    st*: SYSTEMTIME
    pszDisplay*: LPCWSTR
    szDisplay*: array[64, WCHAR]
  LPNMDATETIMEFORMATW* = ptr NMDATETIMEFORMATW
  NMDATETIMEFORMATQUERYA* {.pure.} = object
    nmhdr*: NMHDR
    pszFormat*: LPCSTR
    szMax*: SIZE
  LPNMDATETIMEFORMATQUERYA* = ptr NMDATETIMEFORMATQUERYA
  NMDATETIMEFORMATQUERYW* {.pure.} = object
    nmhdr*: NMHDR
    pszFormat*: LPCWSTR
    szMax*: SIZE
  LPNMDATETIMEFORMATQUERYW* = ptr NMDATETIMEFORMATQUERYW
  NMIPADDRESS* {.pure.} = object
    hdr*: NMHDR
    iField*: int32
    iValue*: int32
  LPNMIPADDRESS* = ptr NMIPADDRESS
  NMPGSCROLL* {.pure, packed.} = object
    hdr*: NMHDR
    fwKeys*: WORD
    rcParent*: RECT
    iDir*: int32
    iXpos*: int32
    iYpos*: int32
    iScroll*: int32
  LPNMPGSCROLL* = ptr NMPGSCROLL
  NMPGCALCSIZE* {.pure.} = object
    hdr*: NMHDR
    dwFlag*: DWORD
    iWidth*: int32
    iHeight*: int32
  LPNMPGCALCSIZE* = ptr NMPGCALCSIZE
  NMPGHOTITEM* {.pure.} = object
    hdr*: NMHDR
    idOld*: int32
    idNew*: int32
    dwFlags*: DWORD
  LPNMPGHOTITEM* = ptr NMPGHOTITEM
  BUTTON_IMAGELIST* {.pure.} = object
    himl*: HIMAGELIST
    margin*: RECT
    uAlign*: UINT
  PBUTTON_IMAGELIST* = ptr BUTTON_IMAGELIST
  NMBCHOTITEM* {.pure.} = object
    hdr*: NMHDR
    dwFlags*: DWORD
  LPNMBCHOTITEM* = ptr NMBCHOTITEM
  BUTTON_SPLITINFO* {.pure.} = object
    mask*: UINT
    himlGlyph*: HIMAGELIST
    uSplitStyle*: UINT
    size*: SIZE
  PBUTTON_SPLITINFO* = ptr BUTTON_SPLITINFO
  NMBCDROPDOWN* {.pure.} = object
    hdr*: NMHDR
    rcButton*: RECT
  LPNMBCDROPDOWN* = ptr NMBCDROPDOWN
  EDITBALLOONTIP* {.pure.} = object
    cbStruct*: DWORD
    pszTitle*: LPCWSTR
    pszText*: LPCWSTR
    ttiIcon*: INT
  PEDITBALLOONTIP* = ptr EDITBALLOONTIP
  PFNDAENUMCALLBACK* = proc (p: pointer, pData: pointer): int32 {.stdcall.}
  PFNDSAENUMCALLBACK* = PFNDAENUMCALLBACK
  PFNDAENUMCALLBACKCONST* = proc (p: pointer, pData: pointer): int32 {.stdcall.}
  PFNDSAENUMCALLBACKCONST* = PFNDAENUMCALLBACKCONST
  PFNDACOMPARE* = proc (p1: pointer, p2: pointer, lParam: LPARAM): int32 {.stdcall.}
  PFNDSACOMPARE* = PFNDACOMPARE
  PFNDACOMPARECONST* = proc (p1: pointer, p2: pointer, lParam: LPARAM): int32 {.stdcall.}
  PFNDSACOMPARECONST* = PFNDACOMPARECONST
  PFNDPAENUMCALLBACK* = PFNDAENUMCALLBACK
  PFNDPAENUMCALLBACKCONST* = PFNDAENUMCALLBACKCONST
  PFNDPACOMPARE* = PFNDACOMPARE
  PFNDPACOMPARECONST* = PFNDACOMPARECONST
when winimUnicode:
  type
    TTTOOLINFO* = TTTOOLINFOW
when winimAnsi:
  type
    TTTOOLINFO* = TTTOOLINFOA
type
  TOOLINFO* = TTTOOLINFO
const
  MAXPROPPAGES* = 100
  PSP_DEFAULT* = 0x00000000
  PSP_DLGINDIRECT* = 0x00000001
  PSP_USEHICON* = 0x00000002
  PSP_USEICONID* = 0x00000004
  PSP_USETITLE* = 0x00000008
  PSP_RTLREADING* = 0x00000010
  PSP_HASHELP* = 0x00000020
  PSP_USEREFPARENT* = 0x00000040
  PSP_USECALLBACK* = 0x00000080
  PSP_PREMATURE* = 0x00000400
  PSP_HIDEHEADER* = 0x00000800
  PSP_USEHEADERTITLE* = 0x00001000
  PSP_USEHEADERSUBTITLE* = 0x00002000
  PSP_USEFUSIONCONTEXT* = 0x00004000
  PSPCB_ADDREF* = 0
  PSPCB_RELEASE* = 1
  PSPCB_CREATE* = 2
  PSH_DEFAULT* = 0x00000000
  PSH_PROPTITLE* = 0x00000001
  PSH_USEHICON* = 0x00000002
  PSH_USEICONID* = 0x00000004
  PSH_PROPSHEETPAGE* = 0x00000008
  PSH_WIZARDHASFINISH* = 0x00000010
  PSH_WIZARD* = 0x00000020
  PSH_USEPSTARTPAGE* = 0x00000040
  PSH_NOAPPLYNOW* = 0x00000080
  PSH_USECALLBACK* = 0x00000100
  PSH_HASHELP* = 0x00000200
  PSH_MODELESS* = 0x00000400
  PSH_RTLREADING* = 0x00000800
  PSH_WIZARDCONTEXTHELP* = 0x00001000
  PSH_WIZARD97* = 0x01000000
  PSH_WATERMARK* = 0x00008000
  PSH_USEHBMWATERMARK* = 0x00010000
  PSH_USEHPLWATERMARK* = 0x00020000
  PSH_STRETCHWATERMARK* = 0x00040000
  PSH_HEADER* = 0x00080000
  PSH_USEHBMHEADER* = 0x00100000
  PSH_USEPAGELANG* = 0x00200000
  PSH_WIZARD_LITE* = 0x00400000
  PSH_NOCONTEXTHELP* = 0x02000000
  PSCB_INITIALIZED* = 1
  PSCB_PRECREATE* = 2
  PSCB_BUTTONPRESSED* = 3
  PSN_FIRST* = 0-200
  PSN_LAST* = 0-299
  PSN_SETACTIVE* = PSN_FIRST-0
  PSN_KILLACTIVE* = PSN_FIRST-1
  PSN_APPLY* = PSN_FIRST-2
  PSN_RESET* = PSN_FIRST-3
  PSN_HELP* = PSN_FIRST-5
  PSN_WIZBACK* = PSN_FIRST-6
  PSN_WIZNEXT* = PSN_FIRST-7
  PSN_WIZFINISH* = PSN_FIRST-8
  PSN_QUERYCANCEL* = PSN_FIRST-9
  PSN_GETOBJECT* = PSN_FIRST-10
  PSN_TRANSLATEACCELERATOR* = PSN_FIRST-12
  PSN_QUERYINITIALFOCUS* = PSN_FIRST-13
  PSNRET_NOERROR* = 0
  PSNRET_INVALID* = 1
  PSNRET_INVALID_NOCHANGEPAGE* = 2
  PSNRET_MESSAGEHANDLED* = 3
  PSM_SETCURSEL* = WM_USER+101
  PSM_REMOVEPAGE* = WM_USER+102
  PSM_ADDPAGE* = WM_USER+103
  PSM_CHANGED* = WM_USER+104
  PSM_RESTARTWINDOWS* = WM_USER+105
  PSM_REBOOTSYSTEM* = WM_USER+106
  PSM_CANCELTOCLOSE* = WM_USER+107
  PSM_QUERYSIBLINGS* = WM_USER+108
  PSM_UNCHANGED* = WM_USER+109
  PSM_APPLY* = WM_USER+110
  PSM_SETTITLEA* = WM_USER+111
  PSM_SETTITLEW* = WM_USER+120
  PSM_SETWIZBUTTONS* = WM_USER+112
  PSWIZB_BACK* = 0x00000001
  PSWIZB_NEXT* = 0x00000002
  PSWIZB_FINISH* = 0x00000004
  PSWIZB_DISABLEDFINISH* = 0x00000008
  PSM_PRESSBUTTON* = WM_USER+113
  PSBTN_BACK* = 0
  PSBTN_NEXT* = 1
  PSBTN_FINISH* = 2
  PSBTN_OK* = 3
  PSBTN_APPLYNOW* = 4
  PSBTN_CANCEL* = 5
  PSBTN_HELP* = 6
  PSBTN_MAX* = 6
  PSM_SETCURSELID* = WM_USER+114
  PSM_SETFINISHTEXTA* = WM_USER+115
  PSM_SETFINISHTEXTW* = WM_USER+121
  PSM_GETTABCONTROL* = WM_USER+116
  PSM_ISDIALOGMESSAGE* = WM_USER+117
  PSM_GETCURRENTPAGEHWND* = WM_USER+118
  PSM_INSERTPAGE* = WM_USER+119
  PSM_SETHEADERTITLEA* = WM_USER+125
  PSM_SETHEADERTITLEW* = WM_USER+126
  PSM_SETHEADERSUBTITLEA* = WM_USER+127
  PSM_SETHEADERSUBTITLEW* = WM_USER+128
  PSM_HWNDTOINDEX* = WM_USER+129
  PSM_INDEXTOHWND* = WM_USER+130
  PSM_PAGETOINDEX* = WM_USER+131
  PSM_INDEXTOPAGE* = WM_USER+132
  PSM_IDTOINDEX* = WM_USER+133
  PSM_INDEXTOID* = WM_USER+134
  PSM_GETRESULT* = WM_USER+135
  PSM_RECALCPAGESIZES* = WM_USER+136
  ID_PSRESTARTWINDOWS* = 0x2
  ID_PSREBOOTSYSTEM* = ID_PSRESTARTWINDOWS or 0x1
  WIZ_CXDLG* = 276
  WIZ_CYDLG* = 140
  WIZ_CXBMP* = 80
  WIZ_BODYX* = 92
  WIZ_BODYCX* = 184
  PROP_SM_CXDLG* = 212
  PROP_SM_CYDLG* = 188
  PROP_MED_CXDLG* = 227
  PROP_MED_CYDLG* = 215
  PROP_LG_CXDLG* = 252
  PROP_LG_CYDLG* = 218
  ICC_LISTVIEW_CLASSES* = 0x1
  ICC_TREEVIEW_CLASSES* = 0x2
  ICC_BAR_CLASSES* = 0x4
  ICC_TAB_CLASSES* = 0x8
  ICC_UPDOWN_CLASS* = 0x10
  ICC_PROGRESS_CLASS* = 0x20
  ICC_HOTKEY_CLASS* = 0x40
  ICC_ANIMATE_CLASS* = 0x80
  ICC_WIN95_CLASSES* = 0xff
  ICC_DATE_CLASSES* = 0x100
  ICC_USEREX_CLASSES* = 0x200
  ICC_COOL_CLASSES* = 0x400
  ICC_INTERNET_CLASSES* = 0x800
  ICC_PAGESCROLLER_CLASS* = 0x1000
  ICC_NATIVEFNTCTL_CLASS* = 0x2000
  ICC_STANDARD_CLASSES* = 0x4000
  ICC_LINK_CLASS* = 0x8000
  ODT_HEADER* = 100
  ODT_TAB* = 101
  ODT_LISTVIEW* = 102
  LVM_FIRST* = 0x1000
  TV_FIRST* = 0x1100
  HDM_FIRST* = 0x1200
  TCM_FIRST* = 0x1300
  PGM_FIRST* = 0x1400
  ECM_FIRST* = 0x1500
  BCM_FIRST* = 0x1600
  CBM_FIRST* = 0x1700
  CCM_FIRST* = 0x2000
  CCM_LAST* = CCM_FIRST+0x200
  CCM_SETBKCOLOR* = CCM_FIRST+1
  CCM_SETCOLORSCHEME* = CCM_FIRST+2
  CCM_GETCOLORSCHEME* = CCM_FIRST+3
  CCM_GETDROPTARGET* = CCM_FIRST+4
  CCM_SETUNICODEFORMAT* = CCM_FIRST+5
  CCM_GETUNICODEFORMAT* = CCM_FIRST+6
  CCM_SETVERSION* = CCM_FIRST+0x7
  CCM_GETVERSION* = CCM_FIRST+0x8
  CCM_SETNOTIFYWINDOW* = CCM_FIRST+0x9
  CCM_SETWINDOWTHEME* = CCM_FIRST+0xb
  CCM_DPISCALE* = CCM_FIRST+0xc
  COMCTL32_VERSION* = 6
  INFOTIPSIZE* = 1024
  NM_FIRST* = 0-0
  NM_OUTOFMEMORY* = NM_FIRST-1
  NM_CLICK* = NM_FIRST-2
  NM_DBLCLK* = NM_FIRST-3
  NM_RETURN* = NM_FIRST-4
  NM_RCLICK* = NM_FIRST-5
  NM_RDBLCLK* = NM_FIRST-6
  NM_SETFOCUS* = NM_FIRST-7
  NM_KILLFOCUS* = NM_FIRST-8
  NM_CUSTOMDRAW* = NM_FIRST-12
  NM_HOVER* = NM_FIRST-13
  NM_NCHITTEST* = NM_FIRST-14
  NM_KEYDOWN* = NM_FIRST-15
  NM_RELEASEDCAPTURE* = NM_FIRST-16
  NM_SETCURSOR* = NM_FIRST-17
  NM_CHAR* = NM_FIRST-18
  NM_TOOLTIPSCREATED* = NM_FIRST-19
  NM_LDOWN* = NM_FIRST-20
  NM_RDOWN* = NM_FIRST-21
  NM_THEMECHANGED* = NM_FIRST-22
  NM_FONTCHANGED* = NM_FIRST-23
  NM_CUSTOMTEXT* = NM_FIRST-24
  NM_TVSTATEIMAGECHANGING* = NM_FIRST-24
  NM_LAST* = 0-99
  LVN_FIRST* = 0-100
  LVN_LAST* = 0-199
  HDN_FIRST* = 0-300
  HDN_LAST* = 0-399
  TVN_FIRST* = 0-400
  TVN_LAST* = 0-499
  TTN_FIRST* = 0-520
  TTN_LAST* = 0-549
  TCN_FIRST* = 0-550
  TCN_LAST* = 0-580
  CDN_FIRST* = 0-601
  CDN_LAST* = 0-699
  TBN_FIRST* = 0-700
  TBN_LAST* = 0-720
  UDN_FIRST* = 0-721
  UDN_LAST* = 0-729
  DTN_FIRST* = 0-740
  DTN_LAST* = 0-745
  MCN_FIRST* = 0-746
  MCN_LAST* = 0-752
  DTN_FIRST2* = 0-753
  DTN_LAST2* = 0-799
  CBEN_FIRST* = 0-800
  CBEN_LAST* = 0-830
  RBN_FIRST* = 0-831
  RBN_LAST* = 0-859
  IPN_FIRST* = 0-860
  IPN_LAST* = 0-879
  SBN_FIRST* = 0-880
  SBN_LAST* = 0-899
  PGN_FIRST* = 0-900
  PGN_LAST* = 0-950
  WMN_FIRST* = 0-1000
  WMN_LAST* = 0-1200
  BCN_FIRST* = 0-1250
  BCN_LAST* = 0-1350
  TRBN_FIRST* = 0-1501
  TRBN_LAST* = 0-1519
  MSGF_COMMCTRL_BEGINDRAG* = 0x4200
  MSGF_COMMCTRL_SIZEHEADER* = 0x4201
  MSGF_COMMCTRL_DRAGSELECT* = 0x4202
  MSGF_COMMCTRL_TOOLBARCUST* = 0x4203
  CDRF_DODEFAULT* = 0x0
  CDRF_NEWFONT* = 0x2
  CDRF_SKIPDEFAULT* = 0x4
  CDRF_DOERASE* = 0x8
  CDRF_SKIPPOSTPAINT* = 0x100
  CDRF_NOTIFYPOSTPAINT* = 0x10
  CDRF_NOTIFYITEMDRAW* = 0x20
  CDRF_NOTIFYSUBITEMDRAW* = 0x20
  CDRF_NOTIFYPOSTERASE* = 0x40
  CDDS_PREPAINT* = 0x1
  CDDS_POSTPAINT* = 0x2
  CDDS_PREERASE* = 0x3
  CDDS_POSTERASE* = 0x4
  CDDS_ITEM* = 0x10000
  CDDS_ITEMPREPAINT* = CDDS_ITEM or CDDS_PREPAINT
  CDDS_ITEMPOSTPAINT* = CDDS_ITEM or CDDS_POSTPAINT
  CDDS_ITEMPREERASE* = CDDS_ITEM or CDDS_PREERASE
  CDDS_ITEMPOSTERASE* = CDDS_ITEM or CDDS_POSTERASE
  CDDS_SUBITEM* = 0x20000
  CDIS_SELECTED* = 0x1
  CDIS_GRAYED* = 0x2
  CDIS_DISABLED* = 0x4
  CDIS_CHECKED* = 0x8
  CDIS_FOCUS* = 0x10
  CDIS_DEFAULT* = 0x20
  CDIS_HOT* = 0x40
  CDIS_MARKED* = 0x80
  CDIS_INDETERMINATE* = 0x100
  CDIS_SHOWKEYBOARDCUES* = 0x200
  CDIS_NEARHOT* = 0x0400
  CDIS_OTHERSIDEHOT* = 0x0800
  CDIS_DROPHILITED* = 0x1000
  NM_GETCUSTOMSPLITRECT* = BCN_FIRST+0x0003
  CLR_NONE* = 0xffffffff'i32
  CLR_DEFAULT* = 0xff000000'i32
  ILC_MASK* = 0x1
  ILC_COLOR* = 0x0
  ILC_COLORDDB* = 0xfe
  ILC_COLOR4* = 0x4
  ILC_COLOR8* = 0x8
  ILC_COLOR16* = 0x10
  ILC_COLOR24* = 0x18
  ILC_COLOR32* = 0x20
  ILC_PALETTE* = 0x800
  ILC_MIRROR* = 0x2000
  ILC_PERITEMMIRROR* = 0x8000
  ILC_ORIGINALSIZE* = 0x00010000
  ILC_HIGHQUALITYSCALE* = 0x00020000
  ILD_NORMAL* = 0x0
  ILD_TRANSPARENT* = 0x1
  ILD_MASK* = 0x10
  ILD_IMAGE* = 0x20
  ILD_ROP* = 0x40
  ILD_BLEND25* = 0x2
  ILD_BLEND50* = 0x4
  ILD_OVERLAYMASK* = 0xf00
  ILD_PRESERVEALPHA* = 0x1000
  ILD_SCALE* = 0x2000
  ILD_DPISCALE* = 0x4000
  ILD_ASYNC* = 0x8000
  ILD_SELECTED* = ILD_BLEND50
  ILD_FOCUS* = ILD_BLEND25
  ILD_BLEND* = ILD_BLEND50
  CLR_HILIGHT* = CLR_DEFAULT
  ILS_NORMAL* = 0x0
  ILS_GLOW* = 0x1
  ILS_SHADOW* = 0x2
  ILS_SATURATE* = 0x4
  ILS_ALPHA* = 0x8
  ILGT_NORMAL* = 0x0
  ILGT_ASYNC* = 0x1
  HBITMAP_CALLBACK* = HBITMAP(-1)
  ILCF_MOVE* = 0x0
  ILCF_SWAP* = 0x1
  ILP_NORMAL* = 0
  ILP_DOWNLEVEL* = 1
  WC_HEADERA* = "SysHeader32"
  WC_HEADERW* = "SysHeader32"
  HDS_HORZ* = 0x0
  HDS_BUTTONS* = 0x2
  HDS_HOTTRACK* = 0x4
  HDS_HIDDEN* = 0x8
  HDS_DRAGDROP* = 0x40
  HDS_FULLDRAG* = 0x80
  HDS_FILTERBAR* = 0x100
  HDS_FLAT* = 0x200
  HDS_CHECKBOXES* = 0x400
  HDS_NOSIZING* = 0x800
  HDS_OVERFLOW* = 0x1000
  HDFT_ISSTRING* = 0x0
  HDFT_ISNUMBER* = 0x1
  HDFT_ISDATE* = 0x2
  HDFT_HASNOVALUE* = 0x8000
  HDI_WIDTH* = 0x1
  HDI_HEIGHT* = HDI_WIDTH
  HDI_TEXT* = 0x2
  HDI_FORMAT* = 0x4
  HDI_LPARAM* = 0x8
  HDI_BITMAP* = 0x10
  HDI_IMAGE* = 0x20
  HDI_DI_SETITEM* = 0x40
  HDI_ORDER* = 0x80
  HDI_FILTER* = 0x100
  HDI_STATE* = 0x0200
  HDF_LEFT* = 0x0
  HDF_RIGHT* = 0x1
  HDF_CENTER* = 0x2
  HDF_JUSTIFYMASK* = 0x3
  HDF_RTLREADING* = 0x4
  HDF_OWNERDRAW* = 0x8000
  HDF_STRING* = 0x4000
  HDF_BITMAP* = 0x2000
  HDF_BITMAP_ON_RIGHT* = 0x1000
  HDF_IMAGE* = 0x800
  HDF_SORTUP* = 0x400
  HDF_SORTDOWN* = 0x200
  HDF_CHECKBOX* = 0x40
  HDF_CHECKED* = 0x80
  HDF_FIXEDWIDTH* = 0x100
  HDF_SPLITBUTTON* = 0x1000000
  HDIS_FOCUSED* = 0x1
  HDM_GETITEMCOUNT* = HDM_FIRST+0
  HDM_INSERTITEMA* = HDM_FIRST+1
  HDM_INSERTITEMW* = HDM_FIRST+10
  HDM_DELETEITEM* = HDM_FIRST+2
  HDM_GETITEMA* = HDM_FIRST+3
  HDM_GETITEMW* = HDM_FIRST+11
  HDM_SETITEMA* = HDM_FIRST+4
  HDM_SETITEMW* = HDM_FIRST+12
  HDM_LAYOUT* = HDM_FIRST+5
  HHT_NOWHERE* = 0x1
  HHT_ONHEADER* = 0x2
  HHT_ONDIVIDER* = 0x4
  HHT_ONDIVOPEN* = 0x8
  HHT_ONFILTER* = 0x10
  HHT_ONFILTERBUTTON* = 0x20
  HHT_ABOVE* = 0x100
  HHT_BELOW* = 0x200
  HHT_TORIGHT* = 0x400
  HHT_TOLEFT* = 0x800
  HHT_ONITEMSTATEICON* = 0x1000
  HHT_ONDROPDOWN* = 0x2000
  HHT_ONOVERFLOW* = 0x4000
  HDSIL_NORMAL* = 0
  HDSIL_STATE* = 1
  HDM_HITTEST* = HDM_FIRST+6
  HDM_GETITEMRECT* = HDM_FIRST+7
  HDM_SETIMAGELIST* = HDM_FIRST+8
  HDM_GETIMAGELIST* = HDM_FIRST+9
  HDM_ORDERTOINDEX* = HDM_FIRST+15
  HDM_CREATEDRAGIMAGE* = HDM_FIRST+16
  HDM_GETORDERARRAY* = HDM_FIRST+17
  HDM_SETORDERARRAY* = HDM_FIRST+18
  HDM_SETHOTDIVIDER* = HDM_FIRST+19
  HDM_SETBITMAPMARGIN* = HDM_FIRST+20
  HDM_GETBITMAPMARGIN* = HDM_FIRST+21
  HDM_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  HDM_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  HDM_SETFILTERCHANGETIMEOUT* = HDM_FIRST+22
  HDM_EDITFILTER* = HDM_FIRST+23
  HDM_CLEARFILTER* = HDM_FIRST+24
  HDM_GETITEMDROPDOWNRECT* = HDM_FIRST+25
  HDM_GETOVERFLOWRECT* = HDM_FIRST+26
  HDM_GETFOCUSEDITEM* = HDM_FIRST+27
  HDM_SETFOCUSEDITEM* = HDM_FIRST+28
  HDN_ITEMCHANGINGA* = HDN_FIRST-0
  HDN_ITEMCHANGINGW* = HDN_FIRST-20
  HDN_ITEMCHANGEDA* = HDN_FIRST-1
  HDN_ITEMCHANGEDW* = HDN_FIRST-21
  HDN_ITEMCLICKA* = HDN_FIRST-2
  HDN_ITEMCLICKW* = HDN_FIRST-22
  HDN_ITEMDBLCLICKA* = HDN_FIRST-3
  HDN_ITEMDBLCLICKW* = HDN_FIRST-23
  HDN_DIVIDERDBLCLICKA* = HDN_FIRST-5
  HDN_DIVIDERDBLCLICKW* = HDN_FIRST-25
  HDN_BEGINTRACKA* = HDN_FIRST-6
  HDN_BEGINTRACKW* = HDN_FIRST-26
  HDN_ENDTRACKA* = HDN_FIRST-7
  HDN_ENDTRACKW* = HDN_FIRST-27
  HDN_TRACKA* = HDN_FIRST-8
  HDN_TRACKW* = HDN_FIRST-28
  HDN_GETDISPINFOA* = HDN_FIRST-9
  HDN_GETDISPINFOW* = HDN_FIRST-29
  HDN_BEGINDRAG* = HDN_FIRST-10
  HDN_ENDDRAG* = HDN_FIRST-11
  HDN_FILTERCHANGE* = HDN_FIRST-12
  HDN_FILTERBTNCLICK* = HDN_FIRST-13
  HDN_BEGINFILTEREDIT* = HDN_FIRST-14
  HDN_ENDFILTEREDIT* = HDN_FIRST-15
  HDN_ITEMSTATEICONCLICK* = HDN_FIRST-16
  HDN_ITEMKEYDOWN* = HDN_FIRST-17
  HDN_DROPDOWN* = HDN_FIRST-18
  HDN_OVERFLOWCLICK* = HDN_FIRST-19
  TOOLBARCLASSNAMEW* = "ToolbarWindow32"
  TOOLBARCLASSNAMEA* = "ToolbarWindow32"
  CMB_MASKED* = 0x2
  TBSTATE_CHECKED* = 0x1
  TBSTATE_PRESSED* = 0x2
  TBSTATE_ENABLED* = 0x4
  TBSTATE_HIDDEN* = 0x8
  TBSTATE_INDETERMINATE* = 0x10
  TBSTATE_WRAP* = 0x20
  TBSTATE_ELLIPSES* = 0x40
  TBSTATE_MARKED* = 0x80
  TBSTYLE_BUTTON* = 0x0
  TBSTYLE_SEP* = 0x1
  TBSTYLE_CHECK* = 0x2
  TBSTYLE_GROUP* = 0x4
  TBSTYLE_CHECKGROUP* = TBSTYLE_GROUP or TBSTYLE_CHECK
  TBSTYLE_DROPDOWN* = 0x8
  TBSTYLE_AUTOSIZE* = 0x10
  TBSTYLE_NOPREFIX* = 0x20
  TBSTYLE_TOOLTIPS* = 0x100
  TBSTYLE_WRAPABLE* = 0x200
  TBSTYLE_ALTDRAG* = 0x400
  TBSTYLE_FLAT* = 0x800
  TBSTYLE_LIST* = 0x1000
  TBSTYLE_CUSTOMERASE* = 0x2000
  TBSTYLE_REGISTERDROP* = 0x4000
  TBSTYLE_TRANSPARENT* = 0x8000
  TBSTYLE_EX_DRAWDDARROWS* = 0x1
  BTNS_BUTTON* = TBSTYLE_BUTTON
  BTNS_SEP* = TBSTYLE_SEP
  BTNS_CHECK* = TBSTYLE_CHECK
  BTNS_GROUP* = TBSTYLE_GROUP
  BTNS_CHECKGROUP* = TBSTYLE_CHECKGROUP
  BTNS_DROPDOWN* = TBSTYLE_DROPDOWN
  BTNS_AUTOSIZE* = TBSTYLE_AUTOSIZE
  BTNS_NOPREFIX* = TBSTYLE_NOPREFIX
  BTNS_SHOWTEXT* = 0x40
  BTNS_WHOLEDROPDOWN* = 0x80
  TBSTYLE_EX_MULTICOLUMN* = 0x2
  TBSTYLE_EX_VERTICAL* = 0x4
  TBSTYLE_EX_MIXEDBUTTONS* = 0x8
  TBSTYLE_EX_HIDECLIPPEDBUTTONS* = 0x10
  TBSTYLE_EX_DOUBLEBUFFER* = 0x80
  TBCDRF_NOEDGES* = 0x10000
  TBCDRF_HILITEHOTTRACK* = 0x20000
  TBCDRF_NOOFFSET* = 0x40000
  TBCDRF_NOMARK* = 0x80000
  TBCDRF_NOETCHEDEFFECT* = 0x100000
  TBCDRF_BLENDICON* = 0x200000
  TBCDRF_NOBACKGROUND* = 0x400000
  TBCDRF_USECDCOLORS* = 0x00800000
  TB_ENABLEBUTTON* = WM_USER+1
  TB_CHECKBUTTON* = WM_USER+2
  TB_PRESSBUTTON* = WM_USER+3
  TB_HIDEBUTTON* = WM_USER+4
  TB_INDETERMINATE* = WM_USER+5
  TB_MARKBUTTON* = WM_USER+6
  TB_ISBUTTONENABLED* = WM_USER+9
  TB_ISBUTTONCHECKED* = WM_USER+10
  TB_ISBUTTONPRESSED* = WM_USER+11
  TB_ISBUTTONHIDDEN* = WM_USER+12
  TB_ISBUTTONINDETERMINATE* = WM_USER+13
  TB_ISBUTTONHIGHLIGHTED* = WM_USER+14
  TB_SETSTATE* = WM_USER+17
  TB_GETSTATE* = WM_USER+18
  TB_ADDBITMAP* = WM_USER+19
  HINST_COMMCTRL* = HINSTANCE(-1)
  IDB_STD_SMALL_COLOR* = 0
  IDB_STD_LARGE_COLOR* = 1
  IDB_VIEW_SMALL_COLOR* = 4
  IDB_VIEW_LARGE_COLOR* = 5
  IDB_HIST_SMALL_COLOR* = 8
  IDB_HIST_LARGE_COLOR* = 9
  IDB_HIST_NORMAL* = 12
  IDB_HIST_HOT* = 13
  IDB_HIST_DISABLED* = 14
  IDB_HIST_PRESSED* = 15
  STD_CUT* = 0
  STD_COPY* = 1
  STD_PASTE* = 2
  STD_UNDO* = 3
  STD_REDOW* = 4
  STD_DELETE* = 5
  STD_FILENEW* = 6
  STD_FILEOPEN* = 7
  STD_FILESAVE* = 8
  STD_PRINTPRE* = 9
  STD_PROPERTIES* = 10
  STD_HELP* = 11
  STD_FIND* = 12
  STD_REPLACE* = 13
  STD_PRINT* = 14
  VIEW_LARGEICONS* = 0
  VIEW_SMALLICONS* = 1
  VIEW_LIST* = 2
  VIEW_DETAILS* = 3
  VIEW_SORTNAME* = 4
  VIEW_SORTSIZE* = 5
  VIEW_SORTDATE* = 6
  VIEW_SORTTYPE* = 7
  VIEW_PARENTFOLDER* = 8
  VIEW_NETCONNECT* = 9
  VIEW_NETDISCONNECT* = 10
  VIEW_NEWFOLDER* = 11
  VIEW_VIEWMENU* = 12
  HIST_BACK* = 0
  HIST_FORWARD* = 1
  HIST_FAVORITES* = 2
  HIST_ADDTOFAVORITES* = 3
  HIST_VIEWTREE* = 4
  TB_ADDBUTTONSA* = WM_USER+20
  TB_INSERTBUTTONA* = WM_USER+21
  TB_DELETEBUTTON* = WM_USER+22
  TB_GETBUTTON* = WM_USER+23
  TB_BUTTONCOUNT* = WM_USER+24
  TB_COMMANDTOINDEX* = WM_USER+25
  TB_SAVERESTOREA* = WM_USER+26
  TB_SAVERESTOREW* = WM_USER+76
  TB_CUSTOMIZE* = WM_USER+27
  TB_ADDSTRINGA* = WM_USER+28
  TB_ADDSTRINGW* = WM_USER+77
  TB_GETITEMRECT* = WM_USER+29
  TB_BUTTONSTRUCTSIZE* = WM_USER+30
  TB_SETBUTTONSIZE* = WM_USER+31
  TB_SETBITMAPSIZE* = WM_USER+32
  TB_AUTOSIZE* = WM_USER+33
  TB_GETTOOLTIPS* = WM_USER+35
  TB_SETTOOLTIPS* = WM_USER+36
  TB_SETPARENT* = WM_USER+37
  TB_SETROWS* = WM_USER+39
  TB_GETROWS* = WM_USER+40
  TB_SETCMDID* = WM_USER+42
  TB_CHANGEBITMAP* = WM_USER+43
  TB_GETBITMAP* = WM_USER+44
  TB_GETBUTTONTEXTA* = WM_USER+45
  TB_GETBUTTONTEXTW* = WM_USER+75
  TB_REPLACEBITMAP* = WM_USER+46
  TB_SETINDENT* = WM_USER+47
  TB_SETIMAGELIST* = WM_USER+48
  TB_GETIMAGELIST* = WM_USER+49
  TB_LOADIMAGES* = WM_USER+50
  TB_GETRECT* = WM_USER+51
  TB_SETHOTIMAGELIST* = WM_USER+52
  TB_GETHOTIMAGELIST* = WM_USER+53
  TB_SETDISABLEDIMAGELIST* = WM_USER+54
  TB_GETDISABLEDIMAGELIST* = WM_USER+55
  TB_SETSTYLE* = WM_USER+56
  TB_GETSTYLE* = WM_USER+57
  TB_GETBUTTONSIZE* = WM_USER+58
  TB_SETBUTTONWIDTH* = WM_USER+59
  TB_SETMAXTEXTROWS* = WM_USER+60
  TB_GETTEXTROWS* = WM_USER+61
  TB_GETOBJECT* = WM_USER+62
  TB_GETHOTITEM* = WM_USER+71
  TB_SETHOTITEM* = WM_USER+72
  TB_SETANCHORHIGHLIGHT* = WM_USER+73
  TB_GETANCHORHIGHLIGHT* = WM_USER+74
  TB_MAPACCELERATORA* = WM_USER+78
  TBIMHT_AFTER* = 0x1
  TBIMHT_BACKGROUND* = 0x2
  TB_GETINSERTMARK* = WM_USER+79
  TB_SETINSERTMARK* = WM_USER+80
  TB_INSERTMARKHITTEST* = WM_USER+81
  TB_MOVEBUTTON* = WM_USER+82
  TB_GETMAXSIZE* = WM_USER+83
  TB_SETEXTENDEDSTYLE* = WM_USER+84
  TB_GETEXTENDEDSTYLE* = WM_USER+85
  TB_GETPADDING* = WM_USER+86
  TB_SETPADDING* = WM_USER+87
  TB_SETINSERTMARKCOLOR* = WM_USER+88
  TB_GETINSERTMARKCOLOR* = WM_USER+89
  TB_SETCOLORSCHEME* = CCM_SETCOLORSCHEME
  TB_GETCOLORSCHEME* = CCM_GETCOLORSCHEME
  TB_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  TB_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  TB_MAPACCELERATORW* = WM_USER+90
  TBBF_LARGE* = 0x1
  TB_GETBITMAPFLAGS* = WM_USER+41
  TBIF_IMAGE* = 0x1
  TBIF_TEXT* = 0x2
  TBIF_STATE* = 0x4
  TBIF_STYLE* = 0x8
  TBIF_LPARAM* = 0x10
  TBIF_COMMAND* = 0x20
  TBIF_SIZE* = 0x40
  TBIF_BYINDEX* = 0x80000000'i32
  TB_GETBUTTONINFOW* = WM_USER+63
  TB_SETBUTTONINFOW* = WM_USER+64
  TB_GETBUTTONINFOA* = WM_USER+65
  TB_SETBUTTONINFOA* = WM_USER+66
  TB_INSERTBUTTONW* = WM_USER+67
  TB_ADDBUTTONSW* = WM_USER+68
  TB_HITTEST* = WM_USER+69
  TB_SETDRAWTEXTFLAGS* = WM_USER+70
  TB_GETSTRINGW* = WM_USER+91
  TB_GETSTRINGA* = WM_USER+92
  TB_SETBOUNDINGSIZE* = WM_USER+93
  TB_SETHOTITEM2* = WM_USER+94
  TB_HASACCELERATOR* = WM_USER+95
  TB_SETLISTGAP* = WM_USER+96
  TB_GETIMAGELISTCOUNT* = WM_USER+98
  TB_GETIDEALSIZE* = WM_USER+99
  TBMF_PAD* = 0x1
  TBMF_BARPAD* = 0x2
  TBMF_BUTTONSPACING* = 0x4
  TB_GETMETRICS* = WM_USER+101
  TB_SETMETRICS* = WM_USER+102
  TB_GETITEMDROPDOWNRECT* = WM_USER+103
  TB_SETPRESSEDIMAGELIST* = WM_USER+104
  TB_GETPRESSEDIMAGELIST* = WM_USER+105
  TB_SETWINDOWTHEME* = CCM_SETWINDOWTHEME
  TBN_GETBUTTONINFOA* = TBN_FIRST-0
  TBN_BEGINDRAG* = TBN_FIRST-1
  TBN_ENDDRAG* = TBN_FIRST-2
  TBN_BEGINADJUST* = TBN_FIRST-3
  TBN_ENDADJUST* = TBN_FIRST-4
  TBN_RESET* = TBN_FIRST-5
  TBN_QUERYINSERT* = TBN_FIRST-6
  TBN_QUERYDELETE* = TBN_FIRST-7
  TBN_TOOLBARCHANGE* = TBN_FIRST-8
  TBN_CUSTHELP* = TBN_FIRST-9
  TBN_DROPDOWN* = TBN_FIRST-10
  TBN_GETOBJECT* = TBN_FIRST-12
  HICF_OTHER* = 0x0
  HICF_MOUSE* = 0x1
  HICF_ARROWKEYS* = 0x2
  HICF_ACCELERATOR* = 0x4
  HICF_DUPACCEL* = 0x8
  HICF_ENTERING* = 0x10
  HICF_LEAVING* = 0x20
  HICF_RESELECT* = 0x40
  HICF_LMOUSE* = 0x80
  HICF_TOGGLEDROPDOWN* = 0x100
  TBN_HOTITEMCHANGE* = TBN_FIRST-13
  TBN_DRAGOUT* = TBN_FIRST-14
  TBN_DELETINGBUTTON* = TBN_FIRST-15
  TBN_GETDISPINFOA* = TBN_FIRST-16
  TBN_GETDISPINFOW* = TBN_FIRST-17
  TBN_GETINFOTIPA* = TBN_FIRST-18
  TBN_GETINFOTIPW* = TBN_FIRST-19
  TBN_GETBUTTONINFOW* = TBN_FIRST-20
  TBN_RESTORE* = TBN_FIRST-21
  TBN_SAVE* = TBN_FIRST-22
  TBN_INITCUSTOMIZE* = TBN_FIRST-23
  TBNRF_HIDEHELP* = 0x1
  TBNRF_ENDCUSTOMIZE* = 0x2
  TBN_WRAPHOTITEM* = TBN_FIRST-24
  TBN_DUPACCELERATOR* = TBN_FIRST-25
  TBN_WRAPACCELERATOR* = TBN_FIRST-26
  TBN_DRAGOVER* = TBN_FIRST-27
  TBN_MAPACCELERATOR* = TBN_FIRST-28
  TBNF_IMAGE* = 0x1
  TBNF_TEXT* = 0x2
  TBNF_DI_SETITEM* = 0x10000000
  TBDDRET_DEFAULT* = 0
  TBDDRET_NODEFAULT* = 1
  TBDDRET_TREATPRESSED* = 2
  REBARCLASSNAMEW* = "ReBarWindow32"
  REBARCLASSNAMEA* = "ReBarWindow32"
  RBIM_IMAGELIST* = 0x1
  RBS_TOOLTIPS* = 0x100
  RBS_VARHEIGHT* = 0x200
  RBS_BANDBORDERS* = 0x400
  RBS_FIXEDORDER* = 0x800
  RBS_REGISTERDROP* = 0x1000
  RBS_AUTOSIZE* = 0x2000
  RBS_VERTICALGRIPPER* = 0x4000
  RBS_DBLCLKTOGGLE* = 0x8000
  RBBS_BREAK* = 0x1
  RBBS_FIXEDSIZE* = 0x2
  RBBS_CHILDEDGE* = 0x4
  RBBS_HIDDEN* = 0x8
  RBBS_NOVERT* = 0x10
  RBBS_FIXEDBMP* = 0x20
  RBBS_VARIABLEHEIGHT* = 0x40
  RBBS_GRIPPERALWAYS* = 0x80
  RBBS_NOGRIPPER* = 0x100
  RBBS_USECHEVRON* = 0x200
  RBBS_HIDETITLE* = 0x400
  RBBS_TOPALIGN* = 0x800
  RBBIM_STYLE* = 0x1
  RBBIM_COLORS* = 0x2
  RBBIM_TEXT* = 0x4
  RBBIM_IMAGE* = 0x8
  RBBIM_CHILD* = 0x10
  RBBIM_CHILDSIZE* = 0x20
  RBBIM_SIZE* = 0x40
  RBBIM_BACKGROUND* = 0x80
  RBBIM_ID* = 0x100
  RBBIM_IDEALSIZE* = 0x200
  RBBIM_LPARAM* = 0x400
  RBBIM_HEADERSIZE* = 0x800
  RBBIM_CHEVRONLOCATION* = 0x00001000
  RBBIM_CHEVRONSTATE* = 0x00002000
  RB_INSERTBANDA* = WM_USER+1
  RB_DELETEBAND* = WM_USER+2
  RB_GETBARINFO* = WM_USER+3
  RB_SETBARINFO* = WM_USER+4
  RB_SETBANDINFOA* = WM_USER+6
  RB_SETPARENT* = WM_USER+7
  RB_HITTEST* = WM_USER+8
  RB_GETRECT* = WM_USER+9
  RB_INSERTBANDW* = WM_USER+10
  RB_SETBANDINFOW* = WM_USER+11
  RB_GETBANDCOUNT* = WM_USER+12
  RB_GETROWCOUNT* = WM_USER+13
  RB_GETROWHEIGHT* = WM_USER+14
  RB_IDTOINDEX* = WM_USER+16
  RB_GETTOOLTIPS* = WM_USER+17
  RB_SETTOOLTIPS* = WM_USER+18
  RB_SETBKCOLOR* = WM_USER+19
  RB_GETBKCOLOR* = WM_USER+20
  RB_SETTEXTCOLOR* = WM_USER+21
  RB_GETTEXTCOLOR* = WM_USER+22
  RBSTR_CHANGERECT* = 0x1
  RB_SIZETORECT* = WM_USER+23
  RB_SETCOLORSCHEME* = CCM_SETCOLORSCHEME
  RB_GETCOLORSCHEME* = CCM_GETCOLORSCHEME
  RB_BEGINDRAG* = WM_USER+24
  RB_ENDDRAG* = WM_USER+25
  RB_DRAGMOVE* = WM_USER+26
  RB_GETBARHEIGHT* = WM_USER+27
  RB_GETBANDINFOW* = WM_USER+28
  RB_GETBANDINFOA* = WM_USER+29
  RB_MINIMIZEBAND* = WM_USER+30
  RB_MAXIMIZEBAND* = WM_USER+31
  RB_GETDROPTARGET* = CCM_GETDROPTARGET
  RB_GETBANDBORDERS* = WM_USER+34
  RB_SHOWBAND* = WM_USER+35
  RB_SETPALETTE* = WM_USER+37
  RB_GETPALETTE* = WM_USER+38
  RB_MOVEBAND* = WM_USER+39
  RB_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  RB_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  RB_GETBANDMARGINS* = WM_USER+40
  RB_SETWINDOWTHEME* = CCM_SETWINDOWTHEME
  RB_SETEXTENDEDSTYLE* = WM_USER+41
  RB_GETEXTENDEDSTYLE* = WM_USER+42
  RB_PUSHCHEVRON* = WM_USER+43
  RB_SETBANDWIDTH* = WM_USER+44
  RBN_HEIGHTCHANGE* = RBN_FIRST-0
  RBN_GETOBJECT* = RBN_FIRST-1
  RBN_LAYOUTCHANGED* = RBN_FIRST-2
  RBN_AUTOSIZE* = RBN_FIRST-3
  RBN_BEGINDRAG* = RBN_FIRST-4
  RBN_ENDDRAG* = RBN_FIRST-5
  RBN_DELETINGBAND* = RBN_FIRST-6
  RBN_DELETEDBAND* = RBN_FIRST-7
  RBN_CHILDSIZE* = RBN_FIRST-8
  RBN_CHEVRONPUSHED* = RBN_FIRST-10
  RBN_SPLITTERDRAG* = RBN_FIRST-11
  RBN_MINMAX* = RBN_FIRST-21
  RBN_AUTOBREAK* = RBN_FIRST-22
  RBNM_ID* = 0x1
  RBNM_STYLE* = 0x2
  RBNM_LPARAM* = 0x4
  RBAB_AUTOSIZE* = 0x1
  RBAB_ADDBAND* = 0x2
  RBHT_NOWHERE* = 0x1
  RBHT_CAPTION* = 0x2
  RBHT_CLIENT* = 0x3
  RBHT_GRABBER* = 0x4
  RBHT_CHEVRON* = 0x8
  RBHT_SPLITTER* = 0x10
  TOOLTIPS_CLASSW* = "tooltips_class32"
  TOOLTIPS_CLASSA* = "tooltips_class32"
  TTS_ALWAYSTIP* = 0x1
  TTS_NOPREFIX* = 0x2
  TTS_NOANIMATE* = 0x10
  TTS_NOFADE* = 0x20
  TTS_BALLOON* = 0x40
  TTS_CLOSE* = 0x80
  TTS_USEVISUALSTYLE* = 0x100
  TTF_IDISHWND* = 0x1
  TTF_CENTERTIP* = 0x2
  TTF_RTLREADING* = 0x4
  TTF_SUBCLASS* = 0x10
  TTF_TRACK* = 0x20
  TTF_ABSOLUTE* = 0x80
  TTF_TRANSPARENT* = 0x100
  TTF_PARSELINKS* = 0x1000
  TTF_DI_SETITEM* = 0x8000
  TTDT_AUTOMATIC* = 0
  TTDT_RESHOW* = 1
  TTDT_AUTOPOP* = 2
  TTDT_INITIAL* = 3
  TTI_NONE* = 0
  TTI_INFO* = 1
  TTI_WARNING* = 2
  TTI_ERROR* = 3
  TTI_INFO_LARGE* = 4
  TTI_WARNING_LARGE* = 5
  TTI_ERROR_LARGE* = 6
  TTM_ACTIVATE* = WM_USER+1
  TTM_SETDELAYTIME* = WM_USER+3
  TTM_ADDTOOLA* = WM_USER+4
  TTM_ADDTOOLW* = WM_USER+50
  TTM_DELTOOLA* = WM_USER+5
  TTM_DELTOOLW* = WM_USER+51
  TTM_NEWTOOLRECTA* = WM_USER+6
  TTM_NEWTOOLRECTW* = WM_USER+52
  TTM_RELAYEVENT* = WM_USER+7
  TTM_GETTOOLINFOA* = WM_USER+8
  TTM_GETTOOLINFOW* = WM_USER+53
  TTM_SETTOOLINFOA* = WM_USER+9
  TTM_SETTOOLINFOW* = WM_USER+54
  TTM_HITTESTA* = WM_USER+10
  TTM_HITTESTW* = WM_USER+55
  TTM_GETTEXTA* = WM_USER+11
  TTM_GETTEXTW* = WM_USER+56
  TTM_UPDATETIPTEXTA* = WM_USER+12
  TTM_UPDATETIPTEXTW* = WM_USER+57
  TTM_GETTOOLCOUNT* = WM_USER+13
  TTM_ENUMTOOLSA* = WM_USER+14
  TTM_ENUMTOOLSW* = WM_USER+58
  TTM_GETCURRENTTOOLA* = WM_USER+15
  TTM_GETCURRENTTOOLW* = WM_USER+59
  TTM_WINDOWFROMPOINT* = WM_USER+16
  TTM_TRACKACTIVATE* = WM_USER+17
  TTM_TRACKPOSITION* = WM_USER+18
  TTM_SETTIPBKCOLOR* = WM_USER+19
  TTM_SETTIPTEXTCOLOR* = WM_USER+20
  TTM_GETDELAYTIME* = WM_USER+21
  TTM_GETTIPBKCOLOR* = WM_USER+22
  TTM_GETTIPTEXTCOLOR* = WM_USER+23
  TTM_SETMAXTIPWIDTH* = WM_USER+24
  TTM_GETMAXTIPWIDTH* = WM_USER+25
  TTM_SETMARGIN* = WM_USER+26
  TTM_GETMARGIN* = WM_USER+27
  TTM_POP* = WM_USER+28
  TTM_UPDATE* = WM_USER+29
  TTM_GETBUBBLESIZE* = WM_USER+30
  TTM_ADJUSTRECT* = WM_USER+31
  TTM_SETTITLEA* = WM_USER+32
  TTM_SETTITLEW* = WM_USER+33
  TTM_POPUP* = WM_USER+34
  TTM_GETTITLE* = WM_USER+35
  TTM_SETWINDOWTHEME* = CCM_SETWINDOWTHEME
  TTN_GETDISPINFOA* = TTN_FIRST-0
  TTN_GETDISPINFOW* = TTN_FIRST-10
  TTN_SHOW* = TTN_FIRST-1
  TTN_POP* = TTN_FIRST-2
  TTN_LINKCLICK* = TTN_FIRST-3
when winimUnicode:
  const
    TTN_GETDISPINFO* = TTN_GETDISPINFOW
when winimAnsi:
  const
    TTN_GETDISPINFO* = TTN_GETDISPINFOA
const
  TTN_NEEDTEXT* = TTN_GETDISPINFO
  TTN_NEEDTEXTA* = TTN_GETDISPINFOA
  TTN_NEEDTEXTW* = TTN_GETDISPINFOW
  SBARS_SIZEGRIP* = 0x100
  SBARS_TOOLTIPS* = 0x800
  SBT_TOOLTIPS* = 0x800
  STATUSCLASSNAMEW* = "msctls_statusbar32"
  STATUSCLASSNAMEA* = "msctls_statusbar32"
  SB_SETTEXTA* = WM_USER+1
  SB_SETTEXTW* = WM_USER+11
  SB_GETTEXTA* = WM_USER+2
  SB_GETTEXTW* = WM_USER+13
  SB_GETTEXTLENGTHA* = WM_USER+3
  SB_GETTEXTLENGTHW* = WM_USER+12
  SB_SETPARTS* = WM_USER+4
  SB_GETPARTS* = WM_USER+6
  SB_GETBORDERS* = WM_USER+7
  SB_SETMINHEIGHT* = WM_USER+8
  SB_SIMPLE* = WM_USER+9
  SB_GETRECT* = WM_USER+10
  SB_ISSIMPLE* = WM_USER+14
  SB_SETICON* = WM_USER+15
  SB_SETTIPTEXTA* = WM_USER+16
  SB_SETTIPTEXTW* = WM_USER+17
  SB_GETTIPTEXTA* = WM_USER+18
  SB_GETTIPTEXTW* = WM_USER+19
  SB_GETICON* = WM_USER+20
  SB_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  SB_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  SBT_OWNERDRAW* = 0x1000
  SBT_NOBORDERS* = 0x100
  SBT_POPOUT* = 0x200
  SBT_RTLREADING* = 0x400
  SBT_NOTABPARSING* = 0x800
  SB_SETBKCOLOR* = CCM_SETBKCOLOR
  SBN_SIMPLEMODECHANGE* = SBN_FIRST-0
  SB_SIMPLEID* = 0xff
  MINSYSCOMMAND* = SC_SIZE
  TRACKBAR_CLASSA* = "msctls_trackbar32"
  TRACKBAR_CLASSW* = "msctls_trackbar32"
  TBS_AUTOTICKS* = 0x1
  TBS_VERT* = 0x2
  TBS_HORZ* = 0x0
  TBS_TOP* = 0x4
  TBS_BOTTOM* = 0x0
  TBS_LEFT* = 0x4
  TBS_RIGHT* = 0x0
  TBS_BOTH* = 0x8
  TBS_NOTICKS* = 0x10
  TBS_ENABLESELRANGE* = 0x20
  TBS_FIXEDLENGTH* = 0x40
  TBS_NOTHUMB* = 0x80
  TBS_TOOLTIPS* = 0x100
  TBS_REVERSED* = 0x200
  TBS_DOWNISLEFT* = 0x400
  TBS_NOTIFYBEFOREMOVE* = 0x800
  TBS_TRANSPARENTBKGND* = 0x1000
  TBM_GETPOS* = WM_USER
  TBM_GETRANGEMIN* = WM_USER+1
  TBM_GETRANGEMAX* = WM_USER+2
  TBM_GETTIC* = WM_USER+3
  TBM_SETTIC* = WM_USER+4
  TBM_SETPOS* = WM_USER+5
  TBM_SETRANGE* = WM_USER+6
  TBM_SETRANGEMIN* = WM_USER+7
  TBM_SETRANGEMAX* = WM_USER+8
  TBM_CLEARTICS* = WM_USER+9
  TBM_SETSEL* = WM_USER+10
  TBM_SETSELSTART* = WM_USER+11
  TBM_SETSELEND* = WM_USER+12
  TBM_GETPTICS* = WM_USER+14
  TBM_GETTICPOS* = WM_USER+15
  TBM_GETNUMTICS* = WM_USER+16
  TBM_GETSELSTART* = WM_USER+17
  TBM_GETSELEND* = WM_USER+18
  TBM_CLEARSEL* = WM_USER+19
  TBM_SETTICFREQ* = WM_USER+20
  TBM_SETPAGESIZE* = WM_USER+21
  TBM_GETPAGESIZE* = WM_USER+22
  TBM_SETLINESIZE* = WM_USER+23
  TBM_GETLINESIZE* = WM_USER+24
  TBM_GETTHUMBRECT* = WM_USER+25
  TBM_GETCHANNELRECT* = WM_USER+26
  TBM_SETTHUMBLENGTH* = WM_USER+27
  TBM_GETTHUMBLENGTH* = WM_USER+28
  TBM_SETTOOLTIPS* = WM_USER+29
  TBM_GETTOOLTIPS* = WM_USER+30
  TBM_SETTIPSIDE* = WM_USER+31
  TBTS_TOP* = 0
  TBTS_LEFT* = 1
  TBTS_BOTTOM* = 2
  TBTS_RIGHT* = 3
  TBM_SETBUDDY* = WM_USER+32
  TBM_GETBUDDY* = WM_USER+33
  TBM_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  TBM_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  TB_LINEUP* = 0
  TB_LINEDOWN* = 1
  TB_PAGEUP* = 2
  TB_PAGEDOWN* = 3
  TB_THUMBPOSITION* = 4
  TB_THUMBTRACK* = 5
  TB_TOP* = 6
  TB_BOTTOM* = 7
  TB_ENDTRACK* = 8
  TBCD_TICS* = 0x1
  TBCD_THUMB* = 0x2
  TBCD_CHANNEL* = 0x3
  TRBN_THUMBPOSCHANGING* = TRBN_FIRST-1
  DL_BEGINDRAG* = WM_USER+133
  DL_DRAGGING* = WM_USER+134
  DL_DROPPED* = WM_USER+135
  DL_CANCELDRAG* = WM_USER+136
  DL_CURSORSET* = 0
  DL_STOPCURSOR* = 1
  DL_COPYCURSOR* = 2
  DL_MOVECURSOR* = 3
  DRAGLISTMSGSTRING* = "commctrl_DragListMsg"
  UPDOWN_CLASSA* = "msctls_updown32"
  UPDOWN_CLASSW* = "msctls_updown32"
  UD_MAXVAL* = 0x7fff
  UD_MINVAL* = -UD_MAXVAL
  UDS_WRAP* = 0x1
  UDS_SETBUDDYINT* = 0x2
  UDS_ALIGNRIGHT* = 0x4
  UDS_ALIGNLEFT* = 0x8
  UDS_AUTOBUDDY* = 0x10
  UDS_ARROWKEYS* = 0x20
  UDS_HORZ* = 0x40
  UDS_NOTHOUSANDS* = 0x80
  UDS_HOTTRACK* = 0x100
  UDM_SETRANGE* = WM_USER+101
  UDM_GETRANGE* = WM_USER+102
  UDM_SETPOS* = WM_USER+103
  UDM_GETPOS* = WM_USER+104
  UDM_SETBUDDY* = WM_USER+105
  UDM_GETBUDDY* = WM_USER+106
  UDM_SETACCEL* = WM_USER+107
  UDM_GETACCEL* = WM_USER+108
  UDM_SETBASE* = WM_USER+109
  UDM_GETBASE* = WM_USER+110
  UDM_SETRANGE32* = WM_USER+111
  UDM_GETRANGE32* = WM_USER+112
  UDM_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  UDM_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  UDM_SETPOS32* = WM_USER+113
  UDM_GETPOS32* = WM_USER+114
  UDN_DELTAPOS* = UDN_FIRST-1
  PROGRESS_CLASSA* = "msctls_progress32"
  PROGRESS_CLASSW* = "msctls_progress32"
  PBS_SMOOTH* = 0x1
  PBS_VERTICAL* = 0x4
  PBM_SETRANGE* = WM_USER+1
  PBM_SETPOS* = WM_USER+2
  PBM_DELTAPOS* = WM_USER+3
  PBM_SETSTEP* = WM_USER+4
  PBM_STEPIT* = WM_USER+5
  PBM_SETRANGE32* = WM_USER+6
  PBM_GETRANGE* = WM_USER+7
  PBM_GETPOS* = WM_USER+8
  PBM_SETBARCOLOR* = WM_USER+9
  PBM_SETBKCOLOR* = CCM_SETBKCOLOR
  PBS_MARQUEE* = 0x8
  PBM_SETMARQUEE* = WM_USER+10
  PBM_GETSTEP* = WM_USER+13
  PBM_GETBKCOLOR* = WM_USER+14
  PBM_GETBARCOLOR* = WM_USER+15
  PBM_SETSTATE* = WM_USER+16
  PBM_GETSTATE* = WM_USER+17
  PBS_SMOOTHREVERSE* = 0x10
  PBST_NORMAL* = 1
  PBST_ERROR* = 2
  PBST_PAUSED* = 3
  HOTKEYF_SHIFT* = 0x1
  HOTKEYF_CONTROL* = 0x2
  HOTKEYF_ALT* = 0x4
  HOTKEYF_EXT* = 0x8
  HKCOMB_NONE* = 0x1
  HKCOMB_S* = 0x2
  HKCOMB_C* = 0x4
  HKCOMB_A* = 0x8
  HKCOMB_SC* = 0x10
  HKCOMB_SA* = 0x20
  HKCOMB_CA* = 0x40
  HKCOMB_SCA* = 0x80
  HKM_SETHOTKEY* = WM_USER+1
  HKM_GETHOTKEY* = WM_USER+2
  HKM_SETRULES* = WM_USER+3
  HOTKEY_CLASSA* = "msctls_hotkey32"
  HOTKEY_CLASSW* = "msctls_hotkey32"
  CCS_TOP* = 0x1
  CCS_NOMOVEY* = 0x2
  CCS_BOTTOM* = 0x3
  CCS_NORESIZE* = 0x4
  CCS_NOPARENTALIGN* = 0x8
  CCS_ADJUSTABLE* = 0x20
  CCS_NODIVIDER* = 0x40
  CCS_VERT* = 0x80
  CCS_LEFT* = CCS_VERT or CCS_TOP
  CCS_RIGHT* = CCS_VERT or CCS_BOTTOM
  CCS_NOMOVEX* = CCS_VERT or CCS_NOMOVEY
  INVALID_LINK_INDEX* = -1
  WC_LINK* = "SysLink"
  WC_LISTVIEWA* = "SysListView32"
  WC_LISTVIEWW* = "SysListView32"
  LVS_ICON* = 0x0
  LVS_REPORT* = 0x1
  LVS_SMALLICON* = 0x2
  LVS_LIST* = 0x3
  LVS_TYPEMASK* = 0x3
  LVS_SINGLESEL* = 0x4
  LVS_SHOWSELALWAYS* = 0x8
  LVS_SORTASCENDING* = 0x10
  LVS_SORTDESCENDING* = 0x20
  LVS_SHAREIMAGELISTS* = 0x40
  LVS_NOLABELWRAP* = 0x80
  LVS_AUTOARRANGE* = 0x100
  LVS_EDITLABELS* = 0x200
  LVS_OWNERDATA* = 0x1000
  LVS_NOSCROLL* = 0x2000
  LVS_TYPESTYLEMASK* = 0xfc00
  LVS_ALIGNTOP* = 0x0
  LVS_ALIGNLEFT* = 0x800
  LVS_ALIGNMASK* = 0xc00
  LVS_OWNERDRAWFIXED* = 0x400
  LVS_NOCOLUMNHEADER* = 0x4000
  LVS_NOSORTHEADER* = 0x8000
  LVM_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  LVM_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  LVM_GETBKCOLOR* = LVM_FIRST+0
  LVM_SETBKCOLOR* = LVM_FIRST+1
  LVM_GETIMAGELIST* = LVM_FIRST+2
  LVSIL_NORMAL* = 0
  LVSIL_SMALL* = 1
  LVSIL_STATE* = 2
  LVSIL_GROUPHEADER* = 3
  LVM_SETIMAGELIST* = LVM_FIRST+3
  LVM_GETITEMCOUNT* = LVM_FIRST+4
  LVIF_TEXT* = 0x1
  LVIF_IMAGE* = 0x2
  LVIF_PARAM* = 0x4
  LVIF_STATE* = 0x8
  LVIF_INDENT* = 0x10
  LVIF_NORECOMPUTE* = 0x800
  LVIF_GROUPID* = 0x100
  LVIF_COLUMNS* = 0x200
  LVIF_COLFMT* = 0x10000
  LVIS_FOCUSED* = 0x1
  LVIS_SELECTED* = 0x2
  LVIS_CUT* = 0x4
  LVIS_DROPHILITED* = 0x8
  LVIS_GLOW* = 0x10
  LVIS_ACTIVATING* = 0x20
  LVIS_OVERLAYMASK* = 0xf00
  LVIS_STATEIMAGEMASK* = 0xF000
  I_INDENTCALLBACK* = -1
  I_GROUPIDCALLBACK* = -1
  I_GROUPIDNONE* = -2
  I_IMAGECALLBACK* = -1
  I_IMAGENONE* = -2
  I_COLUMNSCALLBACK* = UINT(-1)
  LVM_GETITEMA* = LVM_FIRST+5
  LVM_GETITEMW* = LVM_FIRST+75
  LVM_SETITEMA* = LVM_FIRST+6
  LVM_SETITEMW* = LVM_FIRST+76
  LVM_INSERTITEMA* = LVM_FIRST+7
  LVM_INSERTITEMW* = LVM_FIRST+77
  LVM_DELETEITEM* = LVM_FIRST+8
  LVM_DELETEALLITEMS* = LVM_FIRST+9
  LVM_GETCALLBACKMASK* = LVM_FIRST+10
  LVM_SETCALLBACKMASK* = LVM_FIRST+11
  LVNI_ALL* = 0x0
  LVNI_FOCUSED* = 0x1
  LVNI_SELECTED* = 0x2
  LVNI_CUT* = 0x4
  LVNI_DROPHILITED* = 0x8
  LVNI_STATEMASK* = LVNI_FOCUSED or LVNI_SELECTED or LVNI_CUT or LVNI_DROPHILITED
  LVNI_VISIBLEORDER* = 0x10
  LVNI_PREVIOUS* = 0x20
  LVNI_VISIBLEONLY* = 0x40
  LVNI_SAMEGROUPONLY* = 0x80
  LVNI_ABOVE* = 0x100
  LVNI_BELOW* = 0x200
  LVNI_TOLEFT* = 0x400
  LVNI_TORIGHT* = 0x800
  LVNI_DIRECTIONMASK* = LVNI_ABOVE or LVNI_BELOW or LVNI_TOLEFT or LVNI_TORIGHT
  LVM_GETNEXTITEM* = LVM_FIRST+12
  LVFI_PARAM* = 0x1
  LVFI_STRING* = 0x2
  LVFI_PARTIAL* = 0x8
  LVFI_WRAP* = 0x20
  LVFI_NEARESTXY* = 0x40
  LVM_FINDITEMA* = LVM_FIRST+13
  LVM_FINDITEMW* = LVM_FIRST+83
  LVIR_BOUNDS* = 0
  LVIR_ICON* = 1
  LVIR_LABEL* = 2
  LVIR_SELECTBOUNDS* = 3
  LVM_GETITEMRECT* = LVM_FIRST+14
  LVM_SETITEMPOSITION* = LVM_FIRST+15
  LVM_GETITEMPOSITION* = LVM_FIRST+16
  LVM_GETSTRINGWIDTHA* = LVM_FIRST+17
  LVM_GETSTRINGWIDTHW* = LVM_FIRST+87
  LVHT_NOWHERE* = 0x1
  LVHT_ONITEMICON* = 0x2
  LVHT_ONITEMLABEL* = 0x4
  LVHT_ONITEMSTATEICON* = 0x8
  LVHT_ONITEM* = LVHT_ONITEMICON or LVHT_ONITEMLABEL or LVHT_ONITEMSTATEICON
  LVHT_ABOVE* = 0x8
  LVHT_BELOW* = 0x10
  LVHT_TORIGHT* = 0x20
  LVHT_TOLEFT* = 0x40
  LVHT_EX_GROUP_HEADER* = 0x10000000
  LVHT_EX_GROUP_FOOTER* = 0x20000000
  LVHT_EX_GROUP_COLLAPSE* = 0x40000000
  LVHT_EX_GROUP_BACKGROUND* = 0x80000000'i32
  LVHT_EX_GROUP_STATEICON* = 0x01000000
  LVHT_EX_GROUP_SUBSETLINK* = 0x02000000
  LVHT_EX_GROUP* = LVHT_EX_GROUP_BACKGROUND or LVHT_EX_GROUP_COLLAPSE or LVHT_EX_GROUP_FOOTER or LVHT_EX_GROUP_HEADER or LVHT_EX_GROUP_STATEICON or LVHT_EX_GROUP_SUBSETLINK
  LVHT_EX_ONCONTENTS* = 0x04000000
  LVM_HITTEST* = LVM_FIRST+18
  LVM_ENSUREVISIBLE* = LVM_FIRST+19
  LVM_SCROLL* = LVM_FIRST+20
  LVM_REDRAWITEMS* = LVM_FIRST+21
  LVA_DEFAULT* = 0x0
  LVA_ALIGNLEFT* = 0x1
  LVA_ALIGNTOP* = 0x2
  LVA_SNAPTOGRID* = 0x5
  LVM_ARRANGE* = LVM_FIRST+22
  LVM_EDITLABELA* = LVM_FIRST+23
  LVM_EDITLABELW* = LVM_FIRST+118
  LVM_GETEDITCONTROL* = LVM_FIRST+24
  LVCF_FMT* = 0x1
  LVCF_WIDTH* = 0x2
  LVCF_TEXT* = 0x4
  LVCF_SUBITEM* = 0x8
  LVCF_IMAGE* = 0x10
  LVCF_ORDER* = 0x20
  LVCF_MINWIDTH* = 0x40
  LVCF_DEFAULTWIDTH* = 0x80
  LVCF_IDEALWIDTH* = 0x100
  LVCFMT_LEFT* = 0x0
  LVCFMT_RIGHT* = 0x1
  LVCFMT_CENTER* = 0x2
  LVCFMT_JUSTIFYMASK* = 0x3
  LVCFMT_IMAGE* = 0x800
  LVCFMT_BITMAP_ON_RIGHT* = 0x1000
  LVCFMT_COL_HAS_IMAGES* = 0x8000
  LVCFMT_FIXED_WIDTH* = 0x100
  LVCFMT_NO_DPI_SCALE* = 0x40000
  LVCFMT_FIXED_RATIO* = 0x80000
  LVCFMT_LINE_BREAK* = 0x100000
  LVCFMT_FILL* = 0x200000
  LVCFMT_WRAP* = 0x400000
  LVCFMT_NO_TITLE* = 0x800000
  LVCFMT_SPLITBUTTON* = 0x1000000
  LVCFMT_TILE_PLACEMENTMASK* = LVCFMT_LINE_BREAK or LVCFMT_FILL
  LVM_GETCOLUMNA* = LVM_FIRST+25
  LVM_GETCOLUMNW* = LVM_FIRST+95
  LVM_SETCOLUMNA* = LVM_FIRST+26
  LVM_SETCOLUMNW* = LVM_FIRST+96
  LVM_INSERTCOLUMNA* = LVM_FIRST+27
  LVM_INSERTCOLUMNW* = LVM_FIRST+97
  LVM_DELETECOLUMN* = LVM_FIRST+28
  LVM_GETCOLUMNWIDTH* = LVM_FIRST+29
  LVSCW_AUTOSIZE* = -1
  LVSCW_AUTOSIZE_USEHEADER* = -2
  LVM_SETCOLUMNWIDTH* = LVM_FIRST+30
  LVM_GETHEADER* = LVM_FIRST+31
  LVM_CREATEDRAGIMAGE* = LVM_FIRST+33
  LVM_GETVIEWRECT* = LVM_FIRST+34
  LVM_GETTEXTCOLOR* = LVM_FIRST+35
  LVM_SETTEXTCOLOR* = LVM_FIRST+36
  LVM_GETTEXTBKCOLOR* = LVM_FIRST+37
  LVM_SETTEXTBKCOLOR* = LVM_FIRST+38
  LVM_GETTOPINDEX* = LVM_FIRST+39
  LVM_GETCOUNTPERPAGE* = LVM_FIRST+40
  LVM_GETORIGIN* = LVM_FIRST+41
  LVM_UPDATE* = LVM_FIRST+42
  LVM_SETITEMSTATE* = LVM_FIRST+43
  LVM_GETITEMSTATE* = LVM_FIRST+44
  LVM_GETITEMTEXTA* = LVM_FIRST+45
  LVM_GETITEMTEXTW* = LVM_FIRST+115
  LVM_SETITEMTEXTA* = LVM_FIRST+46
  LVM_SETITEMTEXTW* = LVM_FIRST+116
  LVSICF_NOINVALIDATEALL* = 0x1
  LVSICF_NOSCROLL* = 0x2
  LVM_SETITEMCOUNT* = LVM_FIRST+47
  LVM_SORTITEMS* = LVM_FIRST+48
  LVM_SETITEMPOSITION32* = LVM_FIRST+49
  LVM_GETSELECTEDCOUNT* = LVM_FIRST+50
  LVM_GETITEMSPACING* = LVM_FIRST+51
  LVM_GETISEARCHSTRINGA* = LVM_FIRST+52
  LVM_GETISEARCHSTRINGW* = LVM_FIRST+117
  LVM_SETICONSPACING* = LVM_FIRST+53
  LVM_SETEXTENDEDLISTVIEWSTYLE* = LVM_FIRST+54
  LVM_GETEXTENDEDLISTVIEWSTYLE* = LVM_FIRST+55
  LVS_EX_GRIDLINES* = 0x1
  LVS_EX_SUBITEMIMAGES* = 0x2
  LVS_EX_CHECKBOXES* = 0x4
  LVS_EX_TRACKSELECT* = 0x8
  LVS_EX_HEADERDRAGDROP* = 0x10
  LVS_EX_FULLROWSELECT* = 0x20
  LVS_EX_ONECLICKACTIVATE* = 0x40
  LVS_EX_TWOCLICKACTIVATE* = 0x80
  LVS_EX_FLATSB* = 0x100
  LVS_EX_REGIONAL* = 0x200
  LVS_EX_INFOTIP* = 0x400
  LVS_EX_UNDERLINEHOT* = 0x800
  LVS_EX_UNDERLINECOLD* = 0x1000
  LVS_EX_MULTIWORKAREAS* = 0x2000
  LVS_EX_LABELTIP* = 0x4000
  LVS_EX_BORDERSELECT* = 0x8000
  LVS_EX_DOUBLEBUFFER* = 0x10000
  LVS_EX_HIDELABELS* = 0x20000
  LVS_EX_SINGLEROW* = 0x40000
  LVS_EX_SNAPTOGRID* = 0x80000
  LVS_EX_SIMPLESELECT* = 0x100000
  LVS_EX_JUSTIFYCOLUMNS* = 0x200000
  LVS_EX_TRANSPARENTBKGND* = 0x400000
  LVS_EX_TRANSPARENTSHADOWTEXT* = 0x800000
  LVS_EX_AUTOAUTOARRANGE* = 0x1000000
  LVS_EX_HEADERINALLVIEWS* = 0x2000000
  LVS_EX_AUTOCHECKSELECT* = 0x8000000
  LVS_EX_AUTOSIZECOLUMNS* = 0x10000000
  LVS_EX_COLUMNSNAPPOINTS* = 0x40000000
  LVS_EX_COLUMNOVERFLOW* = 0x80000000'i32
  LVM_GETSUBITEMRECT* = LVM_FIRST+56
  LVM_SUBITEMHITTEST* = LVM_FIRST+57
  LVM_SETCOLUMNORDERARRAY* = LVM_FIRST+58
  LVM_GETCOLUMNORDERARRAY* = LVM_FIRST+59
  LVM_SETHOTITEM* = LVM_FIRST+60
  LVM_GETHOTITEM* = LVM_FIRST+61
  LVM_SETHOTCURSOR* = LVM_FIRST+62
  LVM_GETHOTCURSOR* = LVM_FIRST+63
  LVM_APPROXIMATEVIEWRECT* = LVM_FIRST+64
  LV_MAX_WORKAREAS* = 16
  LVM_SETWORKAREAS* = LVM_FIRST+65
  LVM_GETWORKAREAS* = LVM_FIRST+70
  LVM_GETNUMBEROFWORKAREAS* = LVM_FIRST+73
  LVM_GETSELECTIONMARK* = LVM_FIRST+66
  LVM_SETSELECTIONMARK* = LVM_FIRST+67
  LVM_SETHOVERTIME* = LVM_FIRST+71
  LVM_GETHOVERTIME* = LVM_FIRST+72
  LVM_SETTOOLTIPS* = LVM_FIRST+74
  LVM_GETTOOLTIPS* = LVM_FIRST+78
  LVM_SORTITEMSEX* = LVM_FIRST+81
  LVBKIF_SOURCE_NONE* = 0x0
  LVBKIF_SOURCE_HBITMAP* = 0x1
  LVBKIF_SOURCE_URL* = 0x2
  LVBKIF_SOURCE_MASK* = 0x3
  LVBKIF_STYLE_NORMAL* = 0x0
  LVBKIF_STYLE_TILE* = 0x10
  LVBKIF_STYLE_MASK* = 0x10
  LVBKIF_FLAG_TILEOFFSET* = 0x100
  LVBKIF_TYPE_WATERMARK* = 0x10000000
  LVBKIF_FLAG_ALPHABLEND* = 0x20000000
  LVM_SETBKIMAGEA* = LVM_FIRST+68
  LVM_SETBKIMAGEW* = LVM_FIRST+138
  LVM_GETBKIMAGEA* = LVM_FIRST+69
  LVM_GETBKIMAGEW* = LVM_FIRST+139
  LVM_SETSELECTEDCOLUMN* = LVM_FIRST+140
  LVM_SETTILEWIDTH* = LVM_FIRST+141
  LV_VIEW_ICON* = 0x0
  LV_VIEW_DETAILS* = 0x1
  LV_VIEW_SMALLICON* = 0x2
  LV_VIEW_LIST* = 0x3
  LV_VIEW_TILE* = 0x4
  LV_VIEW_MAX* = 0x4
  LVM_SETVIEW* = LVM_FIRST+142
  LVM_GETVIEW* = LVM_FIRST+143
  LVGF_NONE* = 0x0
  LVGF_HEADER* = 0x1
  LVGF_FOOTER* = 0x2
  LVGF_STATE* = 0x4
  LVGF_ALIGN* = 0x8
  LVGF_GROUPID* = 0x10
  LVGF_SUBTITLE* = 0x100
  LVGF_TASK* = 0x200
  LVGF_DESCRIPTIONTOP* = 0x400
  LVGF_DESCRIPTIONBOTTOM* = 0x800
  LVGF_TITLEIMAGE* = 0x1000
  LVGF_EXTENDEDIMAGE* = 0x2000
  LVGF_ITEMS* = 0x4000
  LVGF_SUBSET* = 0x00008000
  LVGF_SUBSETITEMS* = 0x10000
  LVGS_NORMAL* = 0x0
  LVGS_COLLAPSED* = 0x1
  LVGS_HIDDEN* = 0x2
  LVGS_NOHEADER* = 0x4
  LVGS_COLLAPSIBLE* = 0x8
  LVGS_FOCUSED* = 0x10
  LVGS_SELECTED* = 0x20
  LVGS_SUBSETED* = 0x40
  LVGS_SUBSETLINKFOCUSED* = 0x80
  LVGA_HEADER_LEFT* = 0x1
  LVGA_HEADER_CENTER* = 0x2
  LVGA_HEADER_RIGHT* = 0x4
  LVGA_FOOTER_LEFT* = 0x8
  LVGA_FOOTER_CENTER* = 0x10
  LVGA_FOOTER_RIGHT* = 0x20
  LVM_INSERTGROUP* = LVM_FIRST+145
  LVM_SETGROUPINFO* = LVM_FIRST+147
  LVM_GETGROUPINFO* = LVM_FIRST+149
  LVM_REMOVEGROUP* = LVM_FIRST+150
  LVM_MOVEGROUP* = LVM_FIRST+151
  LVM_GETGROUPCOUNT* = LVM_FIRST+152
  LVM_GETGROUPINFOBYINDEX* = LVM_FIRST+153
  LVM_MOVEITEMTOGROUP* = LVM_FIRST+154
  LVGGR_GROUP* = 0
  LVGGR_HEADER* = 1
  LVGGR_LABEL* = 2
  LVGGR_SUBSETLINK* = 3
  LVM_GETGROUPRECT* = LVM_FIRST+98
  LVGMF_NONE* = 0x0
  LVGMF_BORDERSIZE* = 0x1
  LVGMF_BORDERCOLOR* = 0x2
  LVGMF_TEXTCOLOR* = 0x4
  LVM_SETGROUPMETRICS* = LVM_FIRST+155
  LVM_GETGROUPMETRICS* = LVM_FIRST+156
  LVM_ENABLEGROUPVIEW* = LVM_FIRST+157
  LVM_SORTGROUPS* = LVM_FIRST+158
  LVM_INSERTGROUPSORTED* = LVM_FIRST+159
  LVM_REMOVEALLGROUPS* = LVM_FIRST+160
  LVM_HASGROUP* = LVM_FIRST+161
  LVM_GETGROUPSTATE* = LVM_FIRST+92
  LVM_GETFOCUSEDGROUP* = LVM_FIRST+93
  LVTVIF_AUTOSIZE* = 0x0
  LVTVIF_FIXEDWIDTH* = 0x1
  LVTVIF_FIXEDHEIGHT* = 0x2
  LVTVIF_FIXEDSIZE* = 0x3
  LVTVIF_EXTENDED* = 0x4
  LVTVIM_TILESIZE* = 0x1
  LVTVIM_COLUMNS* = 0x2
  LVTVIM_LABELMARGIN* = 0x4
  LVM_SETTILEVIEWINFO* = LVM_FIRST+162
  LVM_GETTILEVIEWINFO* = LVM_FIRST+163
  LVM_SETTILEINFO* = LVM_FIRST+164
  LVM_GETTILEINFO* = LVM_FIRST+165
  LVIM_AFTER* = 0x1
  LVM_SETINSERTMARK* = LVM_FIRST+166
  LVM_GETINSERTMARK* = LVM_FIRST+167
  LVM_INSERTMARKHITTEST* = LVM_FIRST+168
  LVM_GETINSERTMARKRECT* = LVM_FIRST+169
  LVM_SETINSERTMARKCOLOR* = LVM_FIRST+170
  LVM_GETINSERTMARKCOLOR* = LVM_FIRST+171
  LVM_SETINFOTIP* = LVM_FIRST+173
  LVM_GETSELECTEDCOLUMN* = LVM_FIRST+174
  LVM_ISGROUPVIEWENABLED* = LVM_FIRST+175
  LVM_GETOUTLINECOLOR* = LVM_FIRST+176
  LVM_SETOUTLINECOLOR* = LVM_FIRST+177
  LVM_CANCELEDITLABEL* = LVM_FIRST+179
  LVM_MAPINDEXTOID* = LVM_FIRST+180
  LVM_MAPIDTOINDEX* = LVM_FIRST+181
  LVM_ISITEMVISIBLE* = LVM_FIRST+182
  LVM_GETEMPTYTEXT* = LVM_FIRST+204
  LVM_GETFOOTERRECT* = LVM_FIRST+205
  LVFF_ITEMCOUNT* = 0x1
  LVM_GETFOOTERINFO* = LVM_FIRST+206
  LVM_GETFOOTERITEMRECT* = LVM_FIRST+207
  LVFIF_TEXT* = 0x1
  LVFIF_STATE* = 0x2
  LVFIS_FOCUSED* = 0x1
  LVM_GETFOOTERITEM* = LVM_FIRST+208
  LVM_GETITEMINDEXRECT* = LVM_FIRST+209
  LVM_SETITEMINDEXSTATE* = LVM_FIRST+210
  LVM_GETNEXTITEMINDEX* = LVM_FIRST+211
  LVKF_ALT* = 0x1
  LVKF_CONTROL* = 0x2
  LVKF_SHIFT* = 0x4
  LVCDI_ITEM* = 0x0
  LVCDI_GROUP* = 0x1
  LVCDI_ITEMSLIST* = 0x2
  LVCDRF_NOSELECT* = 0x10000
  LVCDRF_NOGROUPFRAME* = 0x20000
  LVN_ITEMCHANGING* = LVN_FIRST-0
  LVN_ITEMCHANGED* = LVN_FIRST-1
  LVN_INSERTITEM* = LVN_FIRST-2
  LVN_DELETEITEM* = LVN_FIRST-3
  LVN_DELETEALLITEMS* = LVN_FIRST-4
  LVN_BEGINLABELEDITA* = LVN_FIRST-5
  LVN_BEGINLABELEDITW* = LVN_FIRST-75
  LVN_ENDLABELEDITA* = LVN_FIRST-6
  LVN_ENDLABELEDITW* = LVN_FIRST-76
  LVN_COLUMNCLICK* = LVN_FIRST-8
  LVN_BEGINDRAG* = LVN_FIRST-9
  LVN_BEGINRDRAG* = LVN_FIRST-11
  LVN_ODCACHEHINT* = LVN_FIRST-13
  LVN_ODFINDITEMA* = LVN_FIRST-52
  LVN_ODFINDITEMW* = LVN_FIRST-79
  LVN_ITEMACTIVATE* = LVN_FIRST-14
  LVN_ODSTATECHANGED* = LVN_FIRST-15
  LVN_HOTTRACK* = LVN_FIRST-21
  LVN_GETDISPINFOA* = LVN_FIRST-50
  LVN_GETDISPINFOW* = LVN_FIRST-77
  LVN_SETDISPINFOA* = LVN_FIRST-51
  LVN_SETDISPINFOW* = LVN_FIRST-78
  LVIF_DI_SETITEM* = 0x1000
  LVN_KEYDOWN* = LVN_FIRST-55
  LVN_MARQUEEBEGIN* = LVN_FIRST-56
  LVGIT_UNFOLDED* = 0x1
  LVN_GETINFOTIPA* = LVN_FIRST-57
  LVN_GETINFOTIPW* = LVN_FIRST-58
  LVNSCH_DEFAULT* = -1
  LVNSCH_ERROR* = -2
  LVNSCH_IGNORE* = -3
  LVN_INCREMENTALSEARCHA* = LVN_FIRST-62
  LVN_INCREMENTALSEARCHW* = LVN_FIRST-63
  LVN_COLUMNDROPDOWN* = LVN_FIRST-64
  LVN_COLUMNOVERFLOWCLICK* = LVN_FIRST-66
  LVN_BEGINSCROLL* = LVN_FIRST-80
  LVN_ENDSCROLL* = LVN_FIRST-81
  LVN_LINKCLICK* = LVN_FIRST-84
  EMF_CENTERED* = 0x1
  LVN_GETEMPTYMARKUP* = LVN_FIRST-87
  WC_TREEVIEWA* = "SysTreeView32"
  WC_TREEVIEWW* = "SysTreeView32"
  TVS_HASBUTTONS* = 0x1
  TVS_HASLINES* = 0x2
  TVS_LINESATROOT* = 0x4
  TVS_EDITLABELS* = 0x8
  TVS_DISABLEDRAGDROP* = 0x10
  TVS_SHOWSELALWAYS* = 0x20
  TVS_RTLREADING* = 0x40
  TVS_NOTOOLTIPS* = 0x80
  TVS_CHECKBOXES* = 0x100
  TVS_TRACKSELECT* = 0x200
  TVS_SINGLEEXPAND* = 0x400
  TVS_INFOTIP* = 0x800
  TVS_FULLROWSELECT* = 0x1000
  TVS_NOSCROLL* = 0x2000
  TVS_NONEVENHEIGHT* = 0x4000
  TVS_NOHSCROLL* = 0x8000
  TVS_EX_NOSINGLECOLLAPSE* = 0x1
  TVS_EX_MULTISELECT* = 0x2
  TVS_EX_DOUBLEBUFFER* = 0x4
  TVS_EX_NOINDENTSTATE* = 0x8
  TVS_EX_RICHTOOLTIP* = 0x10
  TVS_EX_AUTOHSCROLL* = 0x20
  TVS_EX_FADEINOUTEXPANDOS* = 0x40
  TVS_EX_PARTIALCHECKBOXES* = 0x80
  TVS_EX_EXCLUSIONCHECKBOXES* = 0x100
  TVS_EX_DIMMEDCHECKBOXES* = 0x200
  TVS_EX_DRAWIMAGEASYNC* = 0x400
  TVIF_TEXT* = 0x1
  TVIF_IMAGE* = 0x2
  TVIF_PARAM* = 0x4
  TVIF_STATE* = 0x8
  TVIF_HANDLE* = 0x10
  TVIF_SELECTEDIMAGE* = 0x20
  TVIF_CHILDREN* = 0x40
  TVIF_INTEGRAL* = 0x80
  TVIF_STATEEX* = 0x100
  TVIF_EXPANDEDIMAGE* = 0x200
  TVIS_SELECTED* = 0x2
  TVIS_CUT* = 0x4
  TVIS_DROPHILITED* = 0x8
  TVIS_BOLD* = 0x10
  TVIS_EXPANDED* = 0x20
  TVIS_EXPANDEDONCE* = 0x40
  TVIS_EXPANDPARTIAL* = 0x80
  TVIS_OVERLAYMASK* = 0xf00
  TVIS_STATEIMAGEMASK* = 0xF000
  TVIS_USERMASK* = 0xF000
  TVIS_EX_FLAT* = 0x1
  TVIS_EX_DISABLED* = 0x2
  TVIS_EX_ALL* = 0x0002
  I_CHILDRENCALLBACK* = -1
  I_CHILDRENAUTO* = -2
  TVM_INSERTITEMA* = TV_FIRST+0
  TVM_INSERTITEMW* = TV_FIRST+50
  TVM_DELETEITEM* = TV_FIRST+1
  TVM_EXPAND* = TV_FIRST+2
  TVE_COLLAPSE* = 0x1
  TVE_EXPAND* = 0x2
  TVE_TOGGLE* = 0x3
  TVE_EXPANDPARTIAL* = 0x4000
  TVE_COLLAPSERESET* = 0x8000
  TVM_GETITEMRECT* = TV_FIRST+4
  TVM_GETCOUNT* = TV_FIRST+5
  TVM_GETINDENT* = TV_FIRST+6
  TVM_SETINDENT* = TV_FIRST+7
  TVM_GETIMAGELIST* = TV_FIRST+8
  TVSIL_NORMAL* = 0
  TVSIL_STATE* = 2
  TVM_SETIMAGELIST* = TV_FIRST+9
  TVM_GETNEXTITEM* = TV_FIRST+10
  TVGN_ROOT* = 0x0
  TVGN_NEXT* = 0x1
  TVGN_PREVIOUS* = 0x2
  TVGN_PARENT* = 0x3
  TVGN_CHILD* = 0x4
  TVGN_FIRSTVISIBLE* = 0x5
  TVGN_NEXTVISIBLE* = 0x6
  TVGN_PREVIOUSVISIBLE* = 0x7
  TVGN_DROPHILITE* = 0x8
  TVGN_CARET* = 0x9
  TVGN_LASTVISIBLE* = 0xa
  TVGN_NEXTSELECTED* = 0xb
  TVSI_NOSINGLEEXPAND* = 0x8000
  TVM_SELECTITEM* = TV_FIRST+11
  TVM_GETITEMA* = TV_FIRST+12
  TVM_GETITEMW* = TV_FIRST+62
  TVM_SETITEMA* = TV_FIRST+13
  TVM_SETITEMW* = TV_FIRST+63
  TVM_EDITLABELA* = TV_FIRST+14
  TVM_EDITLABELW* = TV_FIRST+65
  TVM_GETEDITCONTROL* = TV_FIRST+15
  TVM_GETVISIBLECOUNT* = TV_FIRST+16
  TVM_HITTEST* = TV_FIRST+17
  TVHT_NOWHERE* = 0x1
  TVHT_ONITEMICON* = 0x2
  TVHT_ONITEMLABEL* = 0x4
  TVHT_ONITEMSTATEICON* = 0x40
  TVHT_ONITEM* = TVHT_ONITEMICON or TVHT_ONITEMLABEL or TVHT_ONITEMSTATEICON
  TVHT_ONITEMINDENT* = 0x8
  TVHT_ONITEMBUTTON* = 0x10
  TVHT_ONITEMRIGHT* = 0x20
  TVHT_ABOVE* = 0x100
  TVHT_BELOW* = 0x200
  TVHT_TORIGHT* = 0x400
  TVHT_TOLEFT* = 0x800
  TVM_CREATEDRAGIMAGE* = TV_FIRST+18
  TVM_SORTCHILDREN* = TV_FIRST+19
  TVM_ENSUREVISIBLE* = TV_FIRST+20
  TVM_SORTCHILDRENCB* = TV_FIRST+21
  TVM_ENDEDITLABELNOW* = TV_FIRST+22
  TVM_GETISEARCHSTRINGA* = TV_FIRST+23
  TVM_GETISEARCHSTRINGW* = TV_FIRST+64
  TVM_SETTOOLTIPS* = TV_FIRST+24
  TVM_GETTOOLTIPS* = TV_FIRST+25
  TVM_SETINSERTMARK* = TV_FIRST+26
  TVM_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  TVM_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  TVM_SETITEMHEIGHT* = TV_FIRST+27
  TVM_GETITEMHEIGHT* = TV_FIRST+28
  TVM_SETBKCOLOR* = TV_FIRST+29
  TVM_SETTEXTCOLOR* = TV_FIRST+30
  TVM_GETBKCOLOR* = TV_FIRST+31
  TVM_GETTEXTCOLOR* = TV_FIRST+32
  TVM_SETSCROLLTIME* = TV_FIRST+33
  TVM_GETSCROLLTIME* = TV_FIRST+34
  TVM_SETBORDER* = TV_FIRST+35
  TVSBF_XBORDER* = 0x1
  TVSBF_YBORDER* = 0x2
  TVM_SETINSERTMARKCOLOR* = TV_FIRST+37
  TVM_GETINSERTMARKCOLOR* = TV_FIRST+38
  TVM_GETITEMSTATE* = TV_FIRST+39
  TVM_SETLINECOLOR* = TV_FIRST+40
  TVM_GETLINECOLOR* = TV_FIRST+41
  TVM_MAPACCIDTOHTREEITEM* = TV_FIRST+42
  TVM_MAPHTREEITEMTOACCID* = TV_FIRST+43
  TVM_SETEXTENDEDSTYLE* = TV_FIRST+44
  TVM_GETEXTENDEDSTYLE* = TV_FIRST+45
  TVM_SETHOT* = TV_FIRST+58
  TVM_SETAUTOSCROLLINFO* = TV_FIRST+59
  TVM_GETSELECTEDCOUNT* = TV_FIRST+70
  TVM_SHOWINFOTIP* = TV_FIRST+71
  TVGIPR_BUTTON* = 0x0001
  TVM_GETITEMPARTRECT* = TV_FIRST+72
  TVN_SELCHANGINGA* = TVN_FIRST-1
  TVN_SELCHANGINGW* = TVN_FIRST-50
  TVN_SELCHANGEDA* = TVN_FIRST-2
  TVN_SELCHANGEDW* = TVN_FIRST-51
  TVC_UNKNOWN* = 0x0
  TVC_BYMOUSE* = 0x1
  TVC_BYKEYBOARD* = 0x2
  TVN_GETDISPINFOA* = TVN_FIRST-3
  TVN_GETDISPINFOW* = TVN_FIRST-52
  TVN_SETDISPINFOA* = TVN_FIRST-4
  TVN_SETDISPINFOW* = TVN_FIRST-53
  TVIF_DI_SETITEM* = 0x1000
  TVN_ITEMEXPANDINGA* = TVN_FIRST-5
  TVN_ITEMEXPANDINGW* = TVN_FIRST-54
  TVN_ITEMEXPANDEDA* = TVN_FIRST-6
  TVN_ITEMEXPANDEDW* = TVN_FIRST-55
  TVN_BEGINDRAGA* = TVN_FIRST-7
  TVN_BEGINDRAGW* = TVN_FIRST-56
  TVN_BEGINRDRAGA* = TVN_FIRST-8
  TVN_BEGINRDRAGW* = TVN_FIRST-57
  TVN_DELETEITEMA* = TVN_FIRST-9
  TVN_DELETEITEMW* = TVN_FIRST-58
  TVN_BEGINLABELEDITA* = TVN_FIRST-10
  TVN_BEGINLABELEDITW* = TVN_FIRST-59
  TVN_ENDLABELEDITA* = TVN_FIRST-11
  TVN_ENDLABELEDITW* = TVN_FIRST-60
  TVN_KEYDOWN* = TVN_FIRST-12
  TVN_GETINFOTIPA* = TVN_FIRST-13
  TVN_GETINFOTIPW* = TVN_FIRST-14
  TVN_SINGLEEXPAND* = TVN_FIRST-15
  TVNRET_DEFAULT* = 0
  TVNRET_SKIPOLD* = 1
  TVNRET_SKIPNEW* = 2
  TVN_ITEMCHANGINGA* = TVN_FIRST-16
  TVN_ITEMCHANGINGW* = TVN_FIRST-17
  TVN_ITEMCHANGEDA* = TVN_FIRST-18
  TVN_ITEMCHANGEDW* = TVN_FIRST-19
  TVN_ASYNCDRAW* = TVN_FIRST-20
  TVCDRF_NOIMAGES* = 0x10000
  WC_COMBOBOXEXW* = "ComboBoxEx32"
  WC_COMBOBOXEXA* = "ComboBoxEx32"
  CBEIF_TEXT* = 0x1
  CBEIF_IMAGE* = 0x2
  CBEIF_SELECTEDIMAGE* = 0x4
  CBEIF_OVERLAY* = 0x8
  CBEIF_INDENT* = 0x10
  CBEIF_LPARAM* = 0x20
  CBEIF_DI_SETITEM* = 0x10000000
  CBEM_INSERTITEMA* = WM_USER+1
  CBEM_SETIMAGELIST* = WM_USER+2
  CBEM_GETIMAGELIST* = WM_USER+3
  CBEM_GETITEMA* = WM_USER+4
  CBEM_SETITEMA* = WM_USER+5
  CBEM_DELETEITEM* = CB_DELETESTRING
  CBEM_GETCOMBOCONTROL* = WM_USER+6
  CBEM_GETEDITCONTROL* = WM_USER+7
  CBEM_SETEXSTYLE* = WM_USER+8
  CBEM_SETEXTENDEDSTYLE* = WM_USER+14
  CBEM_GETEXSTYLE* = WM_USER+9
  CBEM_GETEXTENDEDSTYLE* = WM_USER+9
  CBEM_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  CBEM_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  CBEM_HASEDITCHANGED* = WM_USER+10
  CBEM_INSERTITEMW* = WM_USER+11
  CBEM_SETITEMW* = WM_USER+12
  CBEM_GETITEMW* = WM_USER+13
  CBEM_SETWINDOWTHEME* = CCM_SETWINDOWTHEME
  CBES_EX_NOEDITIMAGE* = 0x1
  CBES_EX_NOEDITIMAGEINDENT* = 0x2
  CBES_EX_PATHWORDBREAKPROC* = 0x4
  CBES_EX_NOSIZELIMIT* = 0x8
  CBES_EX_CASESENSITIVE* = 0x10
  CBES_EX_TEXTENDELLIPSIS* = 0x00000020
  CBEN_GETDISPINFOA* = CBEN_FIRST-0
  CBEN_INSERTITEM* = CBEN_FIRST-1
  CBEN_DELETEITEM* = CBEN_FIRST-2
  CBEN_BEGINEDIT* = CBEN_FIRST-4
  CBEN_ENDEDITA* = CBEN_FIRST-5
  CBEN_ENDEDITW* = CBEN_FIRST-6
  CBEN_GETDISPINFOW* = CBEN_FIRST-7
  CBEN_DRAGBEGINA* = CBEN_FIRST-8
  CBEN_DRAGBEGINW* = CBEN_FIRST-9
  CBENF_KILLFOCUS* = 1
  CBENF_RETURN* = 2
  CBENF_ESCAPE* = 3
  CBENF_DROPDOWN* = 4
  WC_TABCONTROLA* = "SysTabControl32"
  WC_TABCONTROLW* = "SysTabControl32"
  TCS_SCROLLOPPOSITE* = 0x1
  TCS_BOTTOM* = 0x2
  TCS_RIGHT* = 0x2
  TCS_MULTISELECT* = 0x4
  TCS_FLATBUTTONS* = 0x8
  TCS_FORCEICONLEFT* = 0x10
  TCS_FORCELABELLEFT* = 0x20
  TCS_HOTTRACK* = 0x40
  TCS_VERTICAL* = 0x80
  TCS_TABS* = 0x0
  TCS_BUTTONS* = 0x100
  TCS_SINGLELINE* = 0x0
  TCS_MULTILINE* = 0x200
  TCS_RIGHTJUSTIFY* = 0x0
  TCS_FIXEDWIDTH* = 0x400
  TCS_RAGGEDRIGHT* = 0x800
  TCS_FOCUSONBUTTONDOWN* = 0x1000
  TCS_OWNERDRAWFIXED* = 0x2000
  TCS_TOOLTIPS* = 0x4000
  TCS_FOCUSNEVER* = 0x8000
  TCS_EX_FLATSEPARATORS* = 0x1
  TCS_EX_REGISTERDROP* = 0x2
  TCM_GETIMAGELIST* = TCM_FIRST+2
  TCM_SETIMAGELIST* = TCM_FIRST+3
  TCM_GETITEMCOUNT* = TCM_FIRST+4
  TCIF_TEXT* = 0x1
  TCIF_IMAGE* = 0x2
  TCIF_RTLREADING* = 0x4
  TCIF_PARAM* = 0x8
  TCIF_STATE* = 0x10
  TCIS_BUTTONPRESSED* = 0x1
  TCIS_HIGHLIGHTED* = 0x2
  TCM_GETITEMA* = TCM_FIRST+5
  TCM_GETITEMW* = TCM_FIRST+60
  TCM_SETITEMA* = TCM_FIRST+6
  TCM_SETITEMW* = TCM_FIRST+61
  TCM_INSERTITEMA* = TCM_FIRST+7
  TCM_INSERTITEMW* = TCM_FIRST+62
  TCM_DELETEITEM* = TCM_FIRST+8
  TCM_DELETEALLITEMS* = TCM_FIRST+9
  TCM_GETITEMRECT* = TCM_FIRST+10
  TCM_GETCURSEL* = TCM_FIRST+11
  TCM_SETCURSEL* = TCM_FIRST+12
  TCHT_NOWHERE* = 0x1
  TCHT_ONITEMICON* = 0x2
  TCHT_ONITEMLABEL* = 0x4
  TCHT_ONITEM* = TCHT_ONITEMICON or TCHT_ONITEMLABEL
  TCM_HITTEST* = TCM_FIRST+13
  TCM_SETITEMEXTRA* = TCM_FIRST+14
  TCM_ADJUSTRECT* = TCM_FIRST+40
  TCM_SETITEMSIZE* = TCM_FIRST+41
  TCM_REMOVEIMAGE* = TCM_FIRST+42
  TCM_SETPADDING* = TCM_FIRST+43
  TCM_GETROWCOUNT* = TCM_FIRST+44
  TCM_GETTOOLTIPS* = TCM_FIRST+45
  TCM_SETTOOLTIPS* = TCM_FIRST+46
  TCM_GETCURFOCUS* = TCM_FIRST+47
  TCM_SETCURFOCUS* = TCM_FIRST+48
  TCM_SETMINTABWIDTH* = TCM_FIRST+49
  TCM_DESELECTALL* = TCM_FIRST+50
  TCM_HIGHLIGHTITEM* = TCM_FIRST+51
  TCM_SETEXTENDEDSTYLE* = TCM_FIRST+52
  TCM_GETEXTENDEDSTYLE* = TCM_FIRST+53
  TCM_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  TCM_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  TCN_KEYDOWN* = TCN_FIRST-0
  TCN_SELCHANGE* = TCN_FIRST-1
  TCN_SELCHANGING* = TCN_FIRST-2
  TCN_GETOBJECT* = TCN_FIRST-3
  TCN_FOCUSCHANGE* = TCN_FIRST-4
  ANIMATE_CLASSW* = "SysAnimate32"
  ANIMATE_CLASSA* = "SysAnimate32"
  ACS_CENTER* = 0x1
  ACS_TRANSPARENT* = 0x2
  ACS_AUTOPLAY* = 0x4
  ACS_TIMER* = 0x8
  ACM_OPENA* = WM_USER+100
  ACM_OPENW* = WM_USER+103
  ACM_PLAY* = WM_USER+101
  ACM_STOP* = WM_USER+102
  ACM_ISPLAYING* = WM_USER+104
  ACN_START* = 1
  ACN_STOP* = 2
  MONTHCAL_CLASSW* = "SysMonthCal32"
  MONTHCAL_CLASSA* = "SysMonthCal32"
  MCM_FIRST* = 0x1000
  MCM_GETCURSEL* = MCM_FIRST+1
  MCM_SETCURSEL* = MCM_FIRST+2
  MCM_GETMAXSELCOUNT* = MCM_FIRST+3
  MCM_SETMAXSELCOUNT* = MCM_FIRST+4
  MCM_GETSELRANGE* = MCM_FIRST+5
  MCM_SETSELRANGE* = MCM_FIRST+6
  MCM_GETMONTHRANGE* = MCM_FIRST+7
  MCM_SETDAYSTATE* = MCM_FIRST+8
  MCM_GETMINREQRECT* = MCM_FIRST+9
  MCM_SETCOLOR* = MCM_FIRST+10
  MCM_GETCOLOR* = MCM_FIRST+11
  MCSC_BACKGROUND* = 0
  MCSC_TEXT* = 1
  MCSC_TITLEBK* = 2
  MCSC_TITLETEXT* = 3
  MCSC_MONTHBK* = 4
  MCSC_TRAILINGTEXT* = 5
  MCM_SETTODAY* = MCM_FIRST+12
  MCM_GETTODAY* = MCM_FIRST+13
  MCM_HITTEST* = MCM_FIRST+14
  MCHT_TITLE* = 0x10000
  MCHT_CALENDAR* = 0x20000
  MCHT_TODAYLINK* = 0x30000
  MCHT_CALENDARCONTROL* = 0x100000
  MCHT_NEXT* = 0x1000000
  MCHT_PREV* = 0x2000000
  MCHT_NOWHERE* = 0x0
  MCHT_TITLEBK* = MCHT_TITLE
  MCHT_TITLEMONTH* = MCHT_TITLE or 0x1
  MCHT_TITLEYEAR* = MCHT_TITLE or 0x2
  MCHT_TITLEBTNNEXT* = MCHT_TITLE or MCHT_NEXT or 0x3
  MCHT_TITLEBTNPREV* = MCHT_TITLE or MCHT_PREV or 0x3
  MCHT_CALENDARBK* = MCHT_CALENDAR
  MCHT_CALENDARDATE* = MCHT_CALENDAR or 0x1
  MCHT_CALENDARDATENEXT* = MCHT_CALENDARDATE or MCHT_NEXT
  MCHT_CALENDARDATEPREV* = MCHT_CALENDARDATE or MCHT_PREV
  MCHT_CALENDARDAY* = MCHT_CALENDAR or 0x2
  MCHT_CALENDARWEEKNUM* = MCHT_CALENDAR or 0x3
  MCHT_CALENDARDATEMIN* = MCHT_CALENDAR or 0x4
  MCHT_CALENDARDATEMAX* = MCHT_CALENDAR or 0x5
  MCM_SETFIRSTDAYOFWEEK* = MCM_FIRST+15
  MCM_GETFIRSTDAYOFWEEK* = MCM_FIRST+16
  MCM_GETRANGE* = MCM_FIRST+17
  MCM_SETRANGE* = MCM_FIRST+18
  MCM_GETMONTHDELTA* = MCM_FIRST+19
  MCM_SETMONTHDELTA* = MCM_FIRST+20
  MCM_GETMAXTODAYWIDTH* = MCM_FIRST+21
  MCM_SETUNICODEFORMAT* = CCM_SETUNICODEFORMAT
  MCM_GETUNICODEFORMAT* = CCM_GETUNICODEFORMAT
  MCMV_MONTH* = 0
  MCMV_YEAR* = 1
  MCMV_DECADE* = 2
  MCMV_CENTURY* = 3
  MCMV_MAX* = MCMV_CENTURY
  MCM_GETCURRENTVIEW* = MCM_FIRST+22
  MCM_GETCALENDARCOUNT* = MCM_FIRST+23
  MCGIP_CALENDARCONTROL* = 0
  MCGIP_NEXT* = 1
  MCGIP_PREV* = 2
  MCGIP_FOOTER* = 3
  MCGIP_CALENDAR* = 4
  MCGIP_CALENDARHEADER* = 5
  MCGIP_CALENDARBODY* = 6
  MCGIP_CALENDARROW* = 7
  MCGIP_CALENDARCELL* = 8
  MCGIF_DATE* = 01
  MCGIF_RECT* = 0x2
  MCGIF_NAME* = 0x4
  MCM_GETCALENDARGRIDINFO* = MCM_FIRST+24
  MCM_GETCALID* = MCM_FIRST+27
  MCM_SETCALID* = MCM_FIRST+28
  MCM_SIZERECTTOMIN* = MCM_FIRST+29
  MCM_SETCALENDARBORDER* = MCM_FIRST+30
  MCM_GETCALENDARBORDER* = MCM_FIRST+31
  MCM_SETCURRENTVIEW* = MCM_FIRST+32
  MCN_SELCHANGE* = MCN_FIRST-3
  MCN_GETDAYSTATE* = MCN_FIRST+3
  MCN_SELECT* = MCN_FIRST
  MCN_VIEWCHANGE* = MCN_FIRST-4
  MCS_DAYSTATE* = 0x1
  MCS_MULTISELECT* = 0x2
  MCS_WEEKNUMBERS* = 0x4
  MCS_NOTODAYCIRCLE* = 0x8
  MCS_NOTODAY* = 0x10
  MCS_NOTRAILINGDATES* = 0x40
  MCS_SHORTDAYSOFWEEK* = 0x80
  MCS_NOSELCHANGEONNAV* = 0x100
  GMR_VISIBLE* = 0
  GMR_DAYSTATE* = 1
  DATETIMEPICK_CLASSW* = "SysDateTimePick32"
  DATETIMEPICK_CLASSA* = "SysDateTimePick32"
  DTM_FIRST* = 0x1000
  DTM_GETSYSTEMTIME* = DTM_FIRST+1
  DTM_SETSYSTEMTIME* = DTM_FIRST+2
  DTM_GETRANGE* = DTM_FIRST+3
  DTM_SETRANGE* = DTM_FIRST+4
  DTM_SETFORMATA* = DTM_FIRST+5
  DTM_SETFORMATW* = DTM_FIRST+50
  DTM_SETMCCOLOR* = DTM_FIRST+6
  DTM_GETMCCOLOR* = DTM_FIRST+7
  DTM_GETMONTHCAL* = DTM_FIRST+8
  DTM_SETMCFONT* = DTM_FIRST+9
  DTM_GETMCFONT* = DTM_FIRST+10
  DTM_SETMCSTYLE* = DTM_FIRST+11
  DTM_GETMCSTYLE* = DTM_FIRST+12
  DTM_CLOSEMONTHCAL* = DTM_FIRST+13
  DTM_GETDATETIMEPICKERINFO* = DTM_FIRST+14
  DTM_GETIDEALSIZE* = DTM_FIRST+15
  DTS_UPDOWN* = 0x1
  DTS_SHOWNONE* = 0x2
  DTS_SHORTDATEFORMAT* = 0x0
  DTS_LONGDATEFORMAT* = 0x4
  DTS_SHORTDATECENTURYFORMAT* = 0xc
  DTS_TIMEFORMAT* = 0x9
  DTS_APPCANPARSE* = 0x10
  DTS_RIGHTALIGN* = 0x20
  DTN_DATETIMECHANGE* = DTN_FIRST2-6
  DTN_USERSTRINGA* = DTN_FIRST2-5
  DTN_USERSTRINGW* = DTN_FIRST-5
  DTN_WMKEYDOWNA* = DTN_FIRST2-4
  DTN_WMKEYDOWNW* = DTN_FIRST-4
  DTN_FORMATA* = DTN_FIRST2-3
  DTN_FORMATW* = DTN_FIRST-3
  DTN_FORMATQUERYA* = DTN_FIRST2-2
  DTN_FORMATQUERYW* = DTN_FIRST-2
  DTN_DROPDOWN* = DTN_FIRST2-1
  DTN_CLOSEUP* = DTN_FIRST2
  GDTR_MIN* = 0x1
  GDTR_MAX* = 0x2
  GDT_ERROR* = -1
  GDT_VALID* = 0
  GDT_NONE* = 1
  IPM_CLEARADDRESS* = WM_USER+100
  IPM_SETADDRESS* = WM_USER+101
  IPM_GETADDRESS* = WM_USER+102
  IPM_SETRANGE* = WM_USER+103
  IPM_SETFOCUS* = WM_USER+104
  IPM_ISBLANK* = WM_USER+105
  WC_IPADDRESSW* = "SysIPAddress32"
  WC_IPADDRESSA* = "SysIPAddress32"
  IPN_FIELDCHANGED* = IPN_FIRST-0
  WC_PAGESCROLLERW* = "SysPager"
  WC_PAGESCROLLERA* = "SysPager"
  PGS_VERT* = 0x0
  PGS_HORZ* = 0x1
  PGS_AUTOSCROLL* = 0x2
  PGS_DRAGNDROP* = 0x4
  PGF_INVISIBLE* = 0
  PGF_NORMAL* = 1
  PGF_GRAYED* = 2
  PGF_DEPRESSED* = 4
  PGF_HOT* = 8
  PGB_TOPORLEFT* = 0
  PGB_BOTTOMORRIGHT* = 1
  PGM_SETCHILD* = PGM_FIRST+1
  PGM_RECALCSIZE* = PGM_FIRST+2
  PGM_FORWARDMOUSE* = PGM_FIRST+3
  PGM_SETBKCOLOR* = PGM_FIRST+4
  PGM_GETBKCOLOR* = PGM_FIRST+5
  PGM_SETBORDER* = PGM_FIRST+6
  PGM_GETBORDER* = PGM_FIRST+7
  PGM_SETPOS* = PGM_FIRST+8
  PGM_GETPOS* = PGM_FIRST+9
  PGM_SETBUTTONSIZE* = PGM_FIRST+10
  PGM_GETBUTTONSIZE* = PGM_FIRST+11
  PGM_GETBUTTONSTATE* = PGM_FIRST+12
  PGM_GETDROPTARGET* = CCM_GETDROPTARGET
  PGM_SETSCROLLINFO* = PGM_FIRST+13
  PGN_SCROLL* = PGN_FIRST-1
  PGF_SCROLLUP* = 1
  PGF_SCROLLDOWN* = 2
  PGF_SCROLLLEFT* = 4
  PGF_SCROLLRIGHT* = 8
  PGK_SHIFT* = 1
  PGK_CONTROL* = 2
  PGK_MENU* = 4
  PGN_CALCSIZE* = PGN_FIRST-2
  PGF_CALCWIDTH* = 1
  PGF_CALCHEIGHT* = 2
  PGN_HOTITEMCHANGE* = PGN_FIRST-3
  WC_NATIVEFONTCTLW* = "NativeFontCtl"
  WC_NATIVEFONTCTLA* = "NativeFontCtl"
  NFS_EDIT* = 0x1
  NFS_STATIC* = 0x2
  NFS_LISTCOMBO* = 0x4
  NFS_BUTTON* = 0x8
  NFS_ALL* = 0x10
  NFS_USEFONTASSOC* = 0x20
  WC_BUTTONA* = "Button"
  WC_BUTTONW* = "Button"
  BUTTON_IMAGELIST_ALIGN_LEFT* = 0
  BUTTON_IMAGELIST_ALIGN_RIGHT* = 1
  BUTTON_IMAGELIST_ALIGN_TOP* = 2
  BUTTON_IMAGELIST_ALIGN_BOTTOM* = 3
  BUTTON_IMAGELIST_ALIGN_CENTER* = 4
  BCM_GETIDEALSIZE* = BCM_FIRST+0x1
  BCM_SETIMAGELIST* = BCM_FIRST+0x2
  BCM_GETIMAGELIST* = BCM_FIRST+0x3
  BCM_SETTEXTMARGIN* = BCM_FIRST+0x4
  BCM_GETTEXTMARGIN* = BCM_FIRST+0x5
  BCN_HOTITEMCHANGE* = BCN_FIRST+0x1
  BST_HOT* = 0x0200
  BST_DROPDOWNPUSHED* = 0x0400
  BS_SPLITBUTTON* = 0xc
  BS_DEFSPLITBUTTON* = 0xd
  BS_COMMANDLINK* = 0xe
  BS_DEFCOMMANDLINK* = 0xf
  BCSIF_GLYPH* = 0x0001
  BCSIF_IMAGE* = 0x0002
  BCSIF_STYLE* = 0x0004
  BCSIF_SIZE* = 0x0008
  BCSS_NOSPLIT* = 0x0001
  BCSS_STRETCH* = 0x0002
  BCSS_ALIGNLEFT* = 0x0004
  BCSS_IMAGE* = 0x0008
  BCM_SETDROPDOWNSTATE* = BCM_FIRST+0x6
  BCM_SETSPLITINFO* = BCM_FIRST+0x7
  BCM_GETSPLITINFO* = BCM_FIRST+0x8
  BCM_SETNOTE* = BCM_FIRST+0x9
  BCM_GETNOTE* = BCM_FIRST+0xa
  BCM_GETNOTELENGTH* = BCM_FIRST+0xb
  BCM_SETSHIELD* = BCM_FIRST+0xc
  BCN_DROPDOWN* = BCN_FIRST+0x0002
  WC_STATICA* = "Static"
  WC_STATICW* = "Static"
  WC_EDITA* = "Edit"
  WC_EDITW* = "Edit"
  EM_SETCUEBANNER* = ECM_FIRST+1
  EM_GETCUEBANNER* = ECM_FIRST+2
  EM_SHOWBALLOONTIP* = ECM_FIRST+3
  EM_HIDEBALLOONTIP* = ECM_FIRST+4
  EM_SETHILITE* = ECM_FIRST+5
  EM_GETHILITE* = ECM_FIRST+6
  EM_NOSETFOCUS* = ECM_FIRST+7
  EM_TAKEFOCUS* = ECM_FIRST+8
  WC_LISTBOXA* = "ListBox"
  WC_LISTBOXW* = "ListBox"
  WC_COMBOBOXA* = "ComboBox"
  WC_COMBOBOXW* = "ComboBox"
  CB_SETMINVISIBLE* = CBM_FIRST+1
  CB_GETMINVISIBLE* = CBM_FIRST+2
  CB_SETCUEBANNER* = CBM_FIRST+3
  CB_GETCUEBANNER* = CBM_FIRST+4
  WC_SCROLLBARA* = "ScrollBar"
  WC_SCROLLBARW* = "ScrollBar"
  LWS_TRANSPARENT* = 0x1
  LWS_IGNORERETURN* = 0x2
  LWS_NOPREFIX* = 0x4
  LWS_USEVISUALSTYLE* = 0x8
  LWS_USECUSTOMTEXT* = 0x10
  LWS_RIGHT* = 0x20
  LIF_ITEMINDEX* = 0x1
  LIF_STATE* = 0x2
  LIF_ITEMID* = 0x4
  LIF_URL* = 0x8
  LIS_FOCUSED* = 0x1
  LIS_ENABLED* = 0x2
  LIS_VISITED* = 0x4
  LIS_HOTTRACK* = 0x8
  LIS_DEFAULTCOLORS* = 0x10
  LM_HITTEST* = WM_USER+0x300
  LM_GETIDEALHEIGHT* = WM_USER+0x301
  LM_SETITEM* = WM_USER+0x302
  LM_GETITEM* = WM_USER+0x303
  TDF_ENABLE_HYPERLINKS* = 0x1
  TDF_USE_HICON_MAIN* = 0x2
  TDF_USE_HICON_FOOTER* = 0x4
  TDF_ALLOW_DIALOG_CANCELLATION* = 0x8
  TDF_USE_COMMAND_LINKS* = 0x10
  TDF_USE_COMMAND_LINKS_NO_ICON* = 0x20
  TDF_EXPAND_FOOTER_AREA* = 0x40
  TDF_EXPANDED_BY_DEFAULT* = 0x80
  TDF_VERIFICATION_FLAG_CHECKED* = 0x100
  TDF_SHOW_PROGRESS_BAR* = 0x0200
  TDF_SHOW_MARQUEE_PROGRESS_BAR* = 0x0400
  TDF_CALLBACK_TIMER* = 0x0800
  TDF_POSITION_RELATIVE_TO_WINDOW* = 0x1000
  TDF_RTL_LAYOUT* = 0x2000
  TDF_NO_DEFAULT_RADIO_BUTTON* = 0x4000
  TDF_CAN_BE_MINIMIZED* = 0x8000
  TDF_NO_SET_FOREGROUND* = 0x10000
  TDF_SIZE_TO_CONTENT* = 0x1000000
  TDM_NAVIGATE_PAGE* = WM_USER+101
  TDM_CLICK_BUTTON* = WM_USER+102
  TDM_SET_MARQUEE_PROGRESS_BAR* = WM_USER+103
  TDM_SET_PROGRESS_BAR_STATE* = WM_USER+104
  TDM_SET_PROGRESS_BAR_RANGE* = WM_USER+105
  TDM_SET_PROGRESS_BAR_POS* = WM_USER+106
  TDM_SET_PROGRESS_BAR_MARQUEE* = WM_USER+107
  TDM_SET_ELEMENT_TEXT* = WM_USER+108
  TDM_CLICK_RADIO_BUTTON* = WM_USER+110
  TDM_ENABLE_BUTTON* = WM_USER+111
  TDM_ENABLE_RADIO_BUTTON* = WM_USER+112
  TDM_CLICK_VERIFICATION* = WM_USER+113
  TDM_UPDATE_ELEMENT_TEXT* = WM_USER+114
  TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE* = WM_USER+115
  TDM_UPDATE_ICON* = WM_USER+116
  TDN_CREATED* = 0
  TDN_NAVIGATED* = 1
  TDN_BUTTON_CLICKED* = 2
  TDN_HYPERLINK_CLICKED* = 3
  TDN_TIMER* = 4
  TDN_DESTROYED* = 5
  TDN_RADIO_BUTTON_CLICKED* = 6
  TDN_DIALOG_CONSTRUCTED* = 7
  TDN_VERIFICATION_CLICKED* = 8
  TDN_HELP* = 9
  TDN_EXPANDO_BUTTON_CLICKED* = 10
  TDE_CONTENT* = 0
  TDE_EXPANDED_INFORMATION* = 1
  TDE_FOOTER* = 2
  TDE_MAIN_INSTRUCTION* = 3
  TDIE_ICON_MAIN* = 0
  TDIE_ICON_FOOTER* = 1
  TD_WARNING_ICON* = MAKEINTRESOURCEW(-1)
  TD_ERROR_ICON* = MAKEINTRESOURCEW(-2)
  TD_INFORMATION_ICON* = MAKEINTRESOURCEW(-3)
  TD_SHIELD_ICON* = MAKEINTRESOURCEW(-4)
  TDCBF_OK_BUTTON* = 0x1
  TDCBF_YES_BUTTON* = 0x2
  TDCBF_NO_BUTTON* = 0x4
  TDCBF_CANCEL_BUTTON* = 0x8
  TDCBF_RETRY_BUTTON* = 0x10
  TDCBF_CLOSE_BUTTON* = 0x20
  DA_LAST* = 0x7fffffff
  DA_ERR* = -1
  DSA_APPEND* = DA_LAST
  DSA_ERR* = DA_ERR
  DPAM_SORTED* = 0x1
  DPAM_NORMAL* = 0x2
  DPAM_UNION* = 0x4
  DPAM_INTERSECT* = 0x8
  DPAMM_MERGE* = 1
  DPAMM_DELETE* = 2
  DPAMM_INSERT* = 3
  DPAS_SORTED* = 0x1
  DPAS_INSERTBEFORE* = 0x2
  DPAS_INSERTAFTER* = 0x4
  DPA_APPEND* = DA_LAST
  DPA_ERR* = DA_ERR
  WSB_PROP_CYVSCROLL* = 0x1
  WSB_PROP_CXHSCROLL* = 0x2
  WSB_PROP_CYHSCROLL* = 0x4
  WSB_PROP_CXVSCROLL* = 0x8
  WSB_PROP_CXHTHUMB* = 0x10
  WSB_PROP_CYVTHUMB* = 0x20
  WSB_PROP_VBKGCOLOR* = 0x40
  WSB_PROP_HBKGCOLOR* = 0x80
  WSB_PROP_VSTYLE* = 0x100
  WSB_PROP_HSTYLE* = 0x200
  WSB_PROP_WINSTYLE* = 0x400
  WSB_PROP_PALETTE* = 0x800
  WSB_PROP_MASK* = 0xfff
  FSB_FLAT_MODE* = 2
  FSB_ENCARTA_MODE* = 1
  FSB_REGULAR_MODE* = 0
  LIM_SMALL* = 0
  LIM_LARGE* = 1
  ILIF_ALPHA* = 0x1
  ILIF_LOWQUALITY* = 0x2
  ILDRF_IMAGELOWQUALITY* = 0x1
  ILDRF_OVERLAYLOWQUALITY* = 0x10
  ILR_DEFAULT* = 0x0
  ILR_HORIZONTAL_LEFT* = 0x0
  ILR_HORIZONTAL_CENTER* = 0x1
  ILR_HORIZONTAL_RIGHT* = 0x2
  ILR_VERTICAL_TOP* = 0x0
  ILR_VERTICAL_CENTER* = 0x10
  ILR_VERTICAL_BOTTOM* = 0x20
  ILR_SCALE_CLIP* = 0x0
  ILR_SCALE_ASPECTRATIO* = 0x100
  ILGOS_ALWAYS* = 0x0
  ILGOS_FROMSTANDBY* = 0x1
  ILFIP_ALWAYS* = 0x0
  ILFIP_FROMSTANDBY* = 0x1
  ILDI_PURGE* = 0x1
  ILDI_STANDBY* = 0x2
  ILDI_RESETACCESS* = 0x4
  ILDI_QUERYACCESS* = 0x8
  IID_IImageList* = DEFINE_GUID("46eb5926-582e-4017-9fdf-e8998daa0950")
  IID_IImageList2* = DEFINE_GUID("192b9d83-50fc-457b-90a0-2b82a8b5dae1")
  LIBID_CommonControlObjects* = DEFINE_GUID("bcada15b-b428-420c-8d28-023590924c9f")
  CLSID_ImageList* = DEFINE_GUID("7c476ba2-02b1-48f4-8048-b24619ddc058")
  BCCL_NOGLYPH* = HIMAGELIST(-1)
  LPSTR_TEXTCALLBACKA* = cast[LPSTR](-1)
  LPSTR_TEXTCALLBACKW* = cast[LPWSTR](-1)
  TVI_FIRST* = HTREEITEM(-0xffff)
  TVI_LAST* = HTREEITEM(-0xfffe)
  TVI_ROOT* = HTREEITEM(-0x10000)
  TVI_SORT* = HTREEITEM(-0xfffd)
  LM_GETIDEALSIZE* = LM_GETIDEALHEIGHT
type
  LPFNADDPROPSHEETPAGE* = proc (P1: HPROPSHEETPAGE, P2: LPARAM): WINBOOL {.stdcall.}
  LPFNADDPROPSHEETPAGES* = proc (P1: LPVOID, P2: LPFNADDPROPSHEETPAGE, P3: LPARAM): WINBOOL {.stdcall.}
  PFNLVCOMPARE* = proc (P1: LPARAM, P2: LPARAM, P3: LPARAM): int32 {.stdcall.}
  PFTASKDIALOGCALLBACK* = proc (hwnd: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM, lpRefData: LONG_PTR): HRESULT {.stdcall.}
  DPASTREAMINFO* {.pure.} = object
    iPos*: int32
    pvItem*: pointer
  PFNDPASTREAM* = proc (pinfo: ptr DPASTREAMINFO, pstream: ptr IStream, pvInstData: pointer): HRESULT {.stdcall.}
  PFNDPAMERGE* = proc (uMsg: UINT, pvDest: pointer, pvSrc: pointer, lParam: LPARAM): pointer {.stdcall.}
  PFNDPAMERGECONST* = proc (uMsg: UINT, pvDest: pointer, pvSrc: pointer, lParam: LPARAM): pointer {.stdcall.}
  SUBCLASSPROC* = proc (hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, uIdSubclass: UINT_PTR, dwRefData: DWORD_PTR): LRESULT {.stdcall.}
  NMTRBTHUMBPOSCHANGING* {.pure.} = object
    hdr*: NMHDR
    dwPos*: DWORD
    nReason*: int32
  NMLVEMPTYMARKUP* {.pure.} = object
    hdr*: NMHDR
    dwFlags*: DWORD
    szMarkup*: array[L_MAX_URL_LENGTH, WCHAR]
  TVGETITEMPARTRECTINFO* {.pure.} = object
    hti*: HTREEITEM
    prc*: ptr RECT
    partID*: TVITEMPART
  NMTVITEMCHANGE* {.pure.} = object
    hdr*: NMHDR
    uChanged*: UINT
    hItem*: HTREEITEM
    uStateNew*: UINT
    uStateOld*: UINT
    lParam*: LPARAM
  NMTVASYNCDRAW* {.pure.} = object
    hdr*: NMHDR
    pimldp*: ptr IMAGELISTDRAWPARAMS
    hr*: HRESULT
    hItem*: HTREEITEM
    lParam*: LPARAM
    dwRetFlags*: DWORD
    iRetImageIndex*: int32
  TASKDIALOG_BUTTON* {.pure, packed.} = object
    nButtonID*: int32
    pszButtonText*: PCWSTR
  TASKDIALOGCONFIG_UNION1* {.pure, union.} = object
    hMainIcon*: HICON
    pszMainIcon*: PCWSTR
  TASKDIALOGCONFIG_UNION2* {.pure, union.} = object
    hFooterIcon*: HICON
    pszFooterIcon*: PCWSTR
  TASKDIALOGCONFIG* {.pure, packed.} = object
    cbSize*: UINT
    hwndParent*: HWND
    hInstance*: HINSTANCE
    dwFlags*: TASKDIALOG_FLAGS
    dwCommonButtons*: TASKDIALOG_COMMON_BUTTON_FLAGS
    pszWindowTitle*: PCWSTR
    union1*: TASKDIALOGCONFIG_UNION1
    pszMainInstruction*: PCWSTR
    pszContent*: PCWSTR
    cButtons*: UINT
    pButtons*: ptr TASKDIALOG_BUTTON
    nDefaultButton*: int32
    cRadioButtons*: UINT
    pRadioButtons*: ptr TASKDIALOG_BUTTON
    nDefaultRadioButton*: int32
    pszVerificationText*: PCWSTR
    pszExpandedInformation*: PCWSTR
    pszExpandedControlText*: PCWSTR
    pszCollapsedControlText*: PCWSTR
    union2*: TASKDIALOGCONFIG_UNION2
    pszFooter*: PCWSTR
    pfCallback*: PFTASKDIALOGCALLBACK
    lpCallbackData*: LONG_PTR
    cxWidth*: UINT
  IMAGELISTSTATS* {.pure.} = object
    cbSize*: DWORD
    cAlloc*: int32
    cUsed*: int32
    cStandby*: int32
  IImageList* {.pure.} = object
    lpVtbl*: ptr IImageListVtbl
  IImageListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Add*: proc(self: ptr IImageList, hbmImage: HBITMAP, hbmMask: HBITMAP, pi: ptr int32): HRESULT {.stdcall.}
    ReplaceIcon*: proc(self: ptr IImageList, i: int32, hicon: HICON, pi: ptr int32): HRESULT {.stdcall.}
    SetOverlayImage*: proc(self: ptr IImageList, iImage: int32, iOverlay: int32): HRESULT {.stdcall.}
    Replace*: proc(self: ptr IImageList, i: int32, hbmImage: HBITMAP, hbmMask: HBITMAP): HRESULT {.stdcall.}
    AddMasked*: proc(self: ptr IImageList, hbmImage: HBITMAP, crMask: COLORREF, pi: ptr int32): HRESULT {.stdcall.}
    Draw*: proc(self: ptr IImageList, pimldp: ptr IMAGELISTDRAWPARAMS): HRESULT {.stdcall.}
    Remove*: proc(self: ptr IImageList, i: int32): HRESULT {.stdcall.}
    GetIcon*: proc(self: ptr IImageList, i: int32, flags: UINT, picon: ptr HICON): HRESULT {.stdcall.}
    GetImageInfo*: proc(self: ptr IImageList, i: int32, pImageInfo: ptr IMAGEINFO): HRESULT {.stdcall.}
    Copy*: proc(self: ptr IImageList, iDst: int32, punkSrc: ptr IUnknown, iSrc: int32, uFlags: UINT): HRESULT {.stdcall.}
    Merge*: proc(self: ptr IImageList, i1: int32, punk2: ptr IUnknown, i2: int32, dx: int32, dy: int32, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IImageList, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetImageRect*: proc(self: ptr IImageList, i: int32, prc: ptr RECT): HRESULT {.stdcall.}
    GetIconSize*: proc(self: ptr IImageList, cx: ptr int32, cy: ptr int32): HRESULT {.stdcall.}
    SetIconSize*: proc(self: ptr IImageList, cx: int32, cy: int32): HRESULT {.stdcall.}
    GetImageCount*: proc(self: ptr IImageList, pi: ptr int32): HRESULT {.stdcall.}
    SetImageCount*: proc(self: ptr IImageList, uNewCount: UINT): HRESULT {.stdcall.}
    SetBkColor*: proc(self: ptr IImageList, clrBk: COLORREF, pclr: ptr COLORREF): HRESULT {.stdcall.}
    GetBkColor*: proc(self: ptr IImageList, pclr: ptr COLORREF): HRESULT {.stdcall.}
    BeginDrag*: proc(self: ptr IImageList, iTrack: int32, dxHotspot: int32, dyHotspot: int32): HRESULT {.stdcall.}
    EndDrag*: proc(self: ptr IImageList): HRESULT {.stdcall.}
    DragEnter*: proc(self: ptr IImageList, hwndLock: HWND, x: int32, y: int32): HRESULT {.stdcall.}
    DragLeave*: proc(self: ptr IImageList, hwndLock: HWND): HRESULT {.stdcall.}
    DragMove*: proc(self: ptr IImageList, x: int32, y: int32): HRESULT {.stdcall.}
    SetDragCursorImage*: proc(self: ptr IImageList, punk: ptr IUnknown, iDrag: int32, dxHotspot: int32, dyHotspot: int32): HRESULT {.stdcall.}
    DragShowNolock*: proc(self: ptr IImageList, fShow: WINBOOL): HRESULT {.stdcall.}
    GetDragImage*: proc(self: ptr IImageList, ppt: ptr POINT, pptHotspot: ptr POINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetItemFlags*: proc(self: ptr IImageList, i: int32, dwFlags: ptr DWORD): HRESULT {.stdcall.}
    GetOverlayImage*: proc(self: ptr IImageList, iOverlay: int32, piIndex: ptr int32): HRESULT {.stdcall.}
  IImageList2* {.pure.} = object
    lpVtbl*: ptr IImageList2Vtbl
  IImageList2Vtbl* {.pure, inheritable.} = object of IImageListVtbl
    Resize*: proc(self: ptr IImageList2, cxNewIconSize: int32, cyNewIconSize: int32): HRESULT {.stdcall.}
    GetOriginalSize*: proc(self: ptr IImageList2, iImage: int32, dwFlags: DWORD, pcx: ptr int32, pcy: ptr int32): HRESULT {.stdcall.}
    SetOriginalSize*: proc(self: ptr IImageList2, iImage: int32, cx: int32, cy: int32): HRESULT {.stdcall.}
    SetCallback*: proc(self: ptr IImageList2, punk: ptr IUnknown): HRESULT {.stdcall.}
    GetCallback*: proc(self: ptr IImageList2, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    ForceImagePresent*: proc(self: ptr IImageList2, iImage: int32, dwFlags: DWORD): HRESULT {.stdcall.}
    DiscardImages*: proc(self: ptr IImageList2, iFirstImage: int32, iLastImage: int32, dwFlags: DWORD): HRESULT {.stdcall.}
    PreloadImages*: proc(self: ptr IImageList2, pimldp: ptr IMAGELISTDRAWPARAMS): HRESULT {.stdcall.}
    GetStatistics*: proc(self: ptr IImageList2, pils: ptr IMAGELISTSTATS): HRESULT {.stdcall.}
    Initialize*: proc(self: ptr IImageList2, cx: int32, cy: int32, flags: UINT, cInitial: int32, cGrow: int32): HRESULT {.stdcall.}
    Replace2*: proc(self: ptr IImageList2, i: int32, hbmImage: HBITMAP, hbmMask: HBITMAP, punk: ptr IUnknown, dwFlags: DWORD): HRESULT {.stdcall.}
    ReplaceFromImageList*: proc(self: ptr IImageList2, i: int32, pil: ptr IImageList, iSrc: int32, punk: ptr IUnknown, dwFlags: DWORD): HRESULT {.stdcall.}
proc CreatePropertySheetPageA*(constPropSheetPagePointer: LPCPROPSHEETPAGEA): HPROPSHEETPAGE {.winapi, stdcall, dynlib: "comctl32", importc.}
proc CreatePropertySheetPageW*(constPropSheetPagePointer: LPCPROPSHEETPAGEW): HPROPSHEETPAGE {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DestroyPropertySheetPage*(P1: HPROPSHEETPAGE): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc PropertySheetA*(P1: LPCPROPSHEETHEADERA): INT_PTR {.winapi, stdcall, dynlib: "comctl32", importc.}
proc PropertySheetW*(P1: LPCPROPSHEETHEADERW): INT_PTR {.winapi, stdcall, dynlib: "comctl32", importc.}
proc InitCommonControls*(): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc InitCommonControlsEx*(P1: ptr TINITCOMMONCONTROLSEX): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Create*(cx: int32, cy: int32, flags: UINT, cInitial: int32, cGrow: int32): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Destroy*(himl: HIMAGELIST): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_GetImageCount*(himl: HIMAGELIST): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_SetImageCount*(himl: HIMAGELIST, uNewCount: UINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Add*(himl: HIMAGELIST, hbmImage: HBITMAP, hbmMask: HBITMAP): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_ReplaceIcon*(himl: HIMAGELIST, i: int32, hicon: HICON): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_SetBkColor*(himl: HIMAGELIST, clrBk: COLORREF): COLORREF {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_GetBkColor*(himl: HIMAGELIST): COLORREF {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_SetOverlayImage*(himl: HIMAGELIST, iImage: int32, iOverlay: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Draw*(himl: HIMAGELIST, i: int32, hdcDst: HDC, x: int32, y: int32, fStyle: UINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Replace*(himl: HIMAGELIST, i: int32, hbmImage: HBITMAP, hbmMask: HBITMAP): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_AddMasked*(himl: HIMAGELIST, hbmImage: HBITMAP, crMask: COLORREF): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_DrawEx*(himl: HIMAGELIST, i: int32, hdcDst: HDC, x: int32, y: int32, dx: int32, dy: int32, rgbBk: COLORREF, rgbFg: COLORREF, fStyle: UINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_DrawIndirect*(pimldp: ptr IMAGELISTDRAWPARAMS): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Remove*(himl: HIMAGELIST, i: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_GetIcon*(himl: HIMAGELIST, i: int32, flags: UINT): HICON {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_LoadImageA*(hi: HINSTANCE, lpbmp: LPCSTR, cx: int32, cGrow: int32, crMask: COLORREF, uType: UINT, uFlags: UINT): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_LoadImageW*(hi: HINSTANCE, lpbmp: LPCWSTR, cx: int32, cGrow: int32, crMask: COLORREF, uType: UINT, uFlags: UINT): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Copy*(himlDst: HIMAGELIST, iDst: int32, himlSrc: HIMAGELIST, iSrc: int32, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_BeginDrag*(himlTrack: HIMAGELIST, iTrack: int32, dxHotspot: int32, dyHotspot: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_EndDrag*(): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_DragEnter*(hwndLock: HWND, x: int32, y: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_DragLeave*(hwndLock: HWND): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_DragMove*(x: int32, y: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_SetDragCursorImage*(himlDrag: HIMAGELIST, iDrag: int32, dxHotspot: int32, dyHotspot: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_DragShowNolock*(fShow: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_GetDragImage*(ppt: ptr POINT, pptHotspot: ptr POINT): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Read*(pstm: LPSTREAM): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Write*(himl: HIMAGELIST, pstm: LPSTREAM): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_ReadEx*(dwFlags: DWORD, pstm: LPSTREAM, riid: REFIID, ppv: ptr PVOID): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_WriteEx*(himl: HIMAGELIST, dwFlags: DWORD, pstm: LPSTREAM): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_GetIconSize*(himl: HIMAGELIST, cx: ptr int32, cy: ptr int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_SetIconSize*(himl: HIMAGELIST, cx: int32, cy: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_GetImageInfo*(himl: HIMAGELIST, i: int32, pImageInfo: ptr IMAGEINFO): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Merge*(himl1: HIMAGELIST, i1: int32, himl2: HIMAGELIST, i2: int32, dx: int32, dy: int32): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_Duplicate*(himl: HIMAGELIST): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc.}
proc HIMAGELIST_QueryInterface*(himl: HIMAGELIST, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc CreateToolbarEx*(hwnd: HWND, ws: DWORD, wID: UINT, nBitmaps: int32, hBMInst: HINSTANCE, wBMID: UINT_PTR, lpButtons: LPCTBBUTTON, iNumButtons: int32, dxButton: int32, dyButton: int32, dxBitmap: int32, dyBitmap: int32, uStructSize: UINT): HWND {.winapi, stdcall, dynlib: "comctl32", importc.}
proc CreateMappedBitmap*(hInstance: HINSTANCE, idBitmap: INT_PTR, wFlags: UINT, lpColorMap: LPCOLORMAP, iNumMaps: int32): HBITMAP {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DrawStatusTextA*(hDC: HDC, lprc: LPCRECT, pszText: LPCSTR, uFlags: UINT): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DrawStatusTextW*(hDC: HDC, lprc: LPCRECT, pszText: LPCWSTR, uFlags: UINT): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc CreateStatusWindowA*(style: LONG, lpszText: LPCSTR, hwndParent: HWND, wID: UINT): HWND {.winapi, stdcall, dynlib: "comctl32", importc.}
proc CreateStatusWindowW*(style: LONG, lpszText: LPCWSTR, hwndParent: HWND, wID: UINT): HWND {.winapi, stdcall, dynlib: "comctl32", importc.}
proc MenuHelp*(uMsg: UINT, wParam: WPARAM, lParam: LPARAM, hMainMenu: HMENU, hInst: HINSTANCE, hwndStatus: HWND, lpwIDs: ptr UINT): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ShowHideMenuCtl*(hWnd: HWND, uFlags: UINT_PTR, lpInfo: LPINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc GetEffectiveClientRect*(hWnd: HWND, lprc: LPRECT, lpInfo: ptr INT): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc MakeDragList*(hLB: HWND): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DrawInsert*(handParent: HWND, hLB: HWND, nItem: int32): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc LBItemFromPt*(hLB: HWND, pt: POINT, bAutoScroll: WINBOOL): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc CreateUpDownControl*(dwStyle: DWORD, x: int32, y: int32, cx: int32, cy: int32, hParent: HWND, nID: int32, hInst: HINSTANCE, hBuddy: HWND, nUpper: int32, nLower: int32, nPos: int32): HWND {.winapi, stdcall, dynlib: "comctl32", importc.}
proc TaskDialogIndirect*(pTaskConfig: ptr TASKDIALOGCONFIG, pnButton: ptr int32, pnRadioButton: ptr int32, pfVerificationFlagChecked: ptr WINBOOL): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc TaskDialog*(hwndOwner: HWND, hInstance: HINSTANCE, pszWindowTitle: PCWSTR, pszMainInstruction: PCWSTR, pszContent: PCWSTR, dwCommonButtons: TASKDIALOG_COMMON_BUTTON_FLAGS, pszIcon: PCWSTR, pnButton: ptr int32): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc InitMUILanguage*(uiLang: LANGID): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc GetMUILanguage*(): LANGID {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_Create*(cbItem: int32, cItemGrow: int32): HDSA {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_Destroy*(hdsa: HDSA): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_DestroyCallback*(hdsa: HDSA, pfnCB: PFNDAENUMCALLBACK, pData: pointer): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_DeleteItem*(hdsa: HDSA, i: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_DeleteAllItems*(hdsa: HDSA): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_EnumCallback*(hdsa: HDSA, pfnCB: PFNDAENUMCALLBACK, pData: pointer): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_InsertItem*(hdsa: HDSA, i: int32, pitem: pointer): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_GetItemPtr*(hdsa: HDSA, i: int32): PVOID {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_GetItem*(hdsa: HDSA, i: int32, pitem: pointer): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_SetItem*(hdsa: HDSA, i: int32, pitem: pointer): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_Clone*(hdsa: HDSA): HDSA {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_GetSize*(hdsa: HDSA): ULONGLONG {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DSA_Sort*(pdsa: HDSA, pfnCompare: PFNDACOMPARE, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_Create*(cItemGrow: int32): HDPA {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_CreateEx*(cpGrow: int32, hheap: HANDLE): HDPA {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_Clone*(hdpa: HDPA, hdpaNew: HDPA): HDPA {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_Destroy*(hdpa: HDPA): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_DestroyCallback*(hdpa: HDPA, pfnCB: PFNDAENUMCALLBACK, pData: pointer): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_DeletePtr*(hdpa: HDPA, i: int32): PVOID {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_DeleteAllPtrs*(hdpa: HDPA): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_EnumCallback*(hdpa: HDPA, pfnCB: PFNDAENUMCALLBACK, pData: pointer): void {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_Grow*(pdpa: HDPA, cp: int32): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_InsertPtr*(hdpa: HDPA, i: int32, p: pointer): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_SetPtr*(hdpa: HDPA, i: int32, p: pointer): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_GetPtr*(hdpa: HDPA, i: INT_PTR): PVOID {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_GetPtrIndex*(hdpa: HDPA, p: pointer): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_GetSize*(hdpa: HDPA): ULONGLONG {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_Sort*(hdpa: HDPA, pfnCompare: PFNDACOMPARE, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_LoadStream*(phdpa: ptr HDPA, pfn: PFNDPASTREAM, pstream: ptr IStream, pvInstData: pointer): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_SaveStream*(hdpa: HDPA, pfn: PFNDPASTREAM, pstream: ptr IStream, pvInstData: pointer): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_Merge*(hdpaDest: HDPA, hdpaSrc: HDPA, dwFlags: DWORD, pfnCompare: PFNDACOMPARE, pfnMerge: PFNDPAMERGE, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DPA_Search*(hdpa: HDPA, pFind: pointer, iStart: int32, pfnCompare: PFNDACOMPARE, lParam: LPARAM, options: UINT): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc Str_SetPtrW*(ppsz: ptr LPWSTR, psz: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc COMCTL32_TrackMouseEvent*(lpEventTrack: LPTRACKMOUSEEVENT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc: "_TrackMouseEvent".}
proc FlatSB_EnableScrollBar*(P1: HWND, P2: int32, P3: UINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_ShowScrollBar*(P1: HWND, code: int32, P3: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_GetScrollRange*(P1: HWND, code: int32, P3: LPINT, P4: LPINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_GetScrollInfo*(P1: HWND, code: int32, P3: LPSCROLLINFO): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_GetScrollPos*(P1: HWND, code: int32): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_GetScrollProp*(P1: HWND, propIndex: int32, P3: LPINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_SetScrollPos*(P1: HWND, code: int32, pos: int32, fRedraw: WINBOOL): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_SetScrollInfo*(P1: HWND, code: int32, P3: LPSCROLLINFO, fRedraw: WINBOOL): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_SetScrollRange*(P1: HWND, code: int32, min: int32, max: int32, fRedraw: WINBOOL): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_SetScrollProp*(P1: HWND, index: UINT, newValue: INT_PTR, P4: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc FlatSB_SetScrollPropPtr*(P1: HWND, index: UINT, newValue: INT_PTR, P4: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc: "FlatSB_SetScrollProp".}
proc InitializeFlatSB*(P1: HWND): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc UninitializeFlatSB*(P1: HWND): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc SetWindowSubclass*(hWnd: HWND, pfnSubclass: SUBCLASSPROC, uIdSubclass: UINT_PTR, dwRefData: DWORD_PTR): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc GetWindowSubclass*(hWnd: HWND, pfnSubclass: SUBCLASSPROC, uIdSubclass: UINT_PTR, pdwRefData: ptr DWORD_PTR): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc RemoveWindowSubclass*(hWnd: HWND, pfnSubclass: SUBCLASSPROC, uIdSubclass: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DefSubclassProc*(hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc DrawShadowText*(hdc: HDC, pszText: LPCWSTR, cch: UINT, prc: ptr RECT, dwFlags: DWORD, crText: COLORREF, crShadow: COLORREF, ixOffset: int32, iyOffset: int32): int32 {.winapi, stdcall, dynlib: "comctl32", importc.}
proc LoadIconMetric*(hinst: HINSTANCE, pszName: PCWSTR, lims: int32, phico: ptr HICON): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc LoadIconWithScaleDown*(hinst: HINSTANCE, pszName: PCWSTR, cx: int32, cy: int32, phico: ptr HICON): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
proc ImageList_CoCreateInstance*(rclsid: REFCLSID, punkOuter: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "comctl32", importc.}
template HANDLE_WM_NOTIFY*(hwnd: HWND, wParam: WPARAM, lParam: LPARAM, fn: proc(hwnd: HWND, wParam: WPARAM, nmhdr: ptr NMHDR)) = fn(hwnd, wParam, cast[ptr NMHDR](lParam))
template FORWARD_WM_NOTIFY*(hwnd: HWND, idFrom: int32, pnmhdr: ptr NMHDR, fn: SendMessage.type|PostMessage.type): untyped = fn(hwnd, WM_NOTIFY, WPARAM idFrom, cast[LPARAM](pnmhdr))
template INDEXTOOVERLAYMASK*(i: untyped): untyped = i shl 8
template INDEXTOSTATEIMAGEMASK*(i: untyped): untyped = i shl 12
template MAKEIPRANGE*(low: BYTE, high: BYTE): LPARAM = (high.LPARAM shl 8) + low.LPARAM
template MAKEIPADDRESS*(b1: BYTE, b2: BYTE, b3: BYTE, b4: BYTE): LPARAM = (b1.LPARAM shl 24) + (b2.LPARAM shl 16) + (b3.LPARAM shl 8) + (b4.LPARAM)
template FIRST_IPADDRESS*(x: LPARAM): BYTE = cast[BYTE](x shr 24)
template SECOND_IPADDRESS*(x: LPARAM): BYTE = cast[BYTE](x shr 16)
template THIRD_IPADDRESS*(x: LPARAM): BYTE = cast[BYTE](x shr 8)
template FOURTH_IPADDRESS*(x: LPARAM): BYTE = cast[BYTE](x)
when winimUnicode:
  const
    ACM_OPEN* = ACM_OPENW
when winimAnsi:
  const
    ACM_OPEN* = ACM_OPENA
template Animate_Open*(hwnd: HWND, szName: LPTSTR): BOOL = discardable BOOL SendMessage(hwnd, ACM_OPEN, 0, cast[LPARAM](szName))
template Animate_Close*(hwnd: HWND): BOOL = Animate_Open(hwnd, NULL)
when winimUnicode:
  const
    ANIMATE_CLASS* = ANIMATE_CLASSW
when winimAnsi:
  const
    ANIMATE_CLASS* = ANIMATE_CLASSA
template Animate_Create*(hwndP: HWND, id: UINT, dwStyle: DWORD, hInstance: HINSTANCE): HWND = CreateWindow(ANIMATE_CLASS, NULL, dwStyle, 0, 0, 0, 0, hwndP, id, hInstance, NULL)
template Animate_IsPlaying*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, ACM_ISPLAYING, 0, 0)
template Animate_OpenEx*(hwnd: HWND, hInst: HINSTANCE, szName: LPTSTR): BOOL = discardable BOOL SendMessage(hwnd, ACM_OPEN, cast[WPARAM](hInst), cast[LPARAM](szName))
template Animate_Play*(hwnd: HWND, `from`: UINT, `to`: UINT, rep: UINT): BOOL = discardable BOOL SendMessage(hwnd, ACM_PLAY, cast[WPARAM](rep), cast[LPARAM](MAKELONG(`from`, `to`)))
template Animate_Seek*(hwnd: HWND, frame: UINT): BOOL = Animate_Play(hwnd, frame, frame, 1)
template Animate_Stop*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, ACM_STOP, 0, 0)
template Button_GetIdealSize*(hwnd: HWND, psize: ptr SIZE): BOOL = discardable BOOL SendMessage(hwnd, BCM_GETIDEALSIZE, 0, cast[LPARAM](psize))
template Button_GetImageList*(hwnd: HWND, pbuttonImagelist: PBUTTON_IMAGELIST): BOOL = discardable BOOL SendMessage(hwnd, BCM_GETIMAGELIST, 0, cast[LPARAM](pbuttonImagelist))
template Button_GetNote*(hwnd: HWND, psz: LPCWSTR, pcc: int32): BOOL = discardable BOOL SendMessage(hwnd, BCM_GETNOTE, cast[WPARAM](pcc), cast[LPARAM](psz))
template Button_GetNoteLength*(hwnd: HWND): LRESULT = discardable LRESULT SendMessage(hwnd, BCM_GETNOTELENGTH, 0, 0)
template Button_GetSplitInfo*(hwnd: HWND, pInfo: ptr BUTTON_SPLITINFO): BOOL = discardable BOOL SendMessage(hwnd, BCM_GETSPLITINFO, 0, cast[LPARAM](pInfo))
template Button_GetTextMargin*(hwnd: HWND, pmargin: ptr RECT): BOOL = discardable BOOL SendMessage(hwnd, BCM_GETTEXTMARGIN, 0, cast[LPARAM](pmargin))
template Button_SetDropDownState*(hwnd: HWND, fDropDown: BOOL): BOOL = discardable BOOL SendMessage(hwnd, BCM_SETDROPDOWNSTATE, cast[WPARAM](fDropDown), 0)
template Button_SetElevationRequiredState*(hwnd: HWND, fRequired: BOOL): LRESULT = discardable LRESULT SendMessage(hwnd, BCM_SETSHIELD, 0, cast[LPARAM](fRequired))
template Button_SetImageList*(hwnd: HWND, pbuttonImagelist: PBUTTON_IMAGELIST): BOOL = discardable BOOL SendMessage(hwnd, BCM_SETIMAGELIST, 0, cast[LPARAM](pbuttonImagelist))
template Button_SetNote*(hwnd: HWND, psz: PCWSTR): BOOL = discardable BOOL SendMessage(hwnd, BCM_SETNOTE, 0, cast[LPARAM](psz))
template Button_SetSplitInfo*(hwnd: HWND, pInfo: ptr BUTTON_SPLITINFO): BOOL = discardable BOOL SendMessage(hwnd, BCM_SETSPLITINFO, 0, cast[LPARAM](pInfo))
template Button_SetTextMargin*(hwnd: HWND, pmargin: ptr RECT): BOOL = discardable BOOL SendMessage(hwnd, BCM_SETTEXTMARGIN, 0, cast[LPARAM](pmargin))
template ComboBox_GetCueBannerText*(hwnd: HWND, lpwText: LPWSTR, cchText: int32): BOOL = discardable BOOL SendMessage(hwnd, CB_GETCUEBANNER, cast[WPARAM](lpwText), cast[LPARAM](cchText))
template ComboBox_GetMinVisible*(hwnd: HWND): INT = discardable INT SendMessage(hwnd, CB_GETMINVISIBLE, 0, 0)
template ComboBox_SetCueBannerText*(hwnd: HWND, lpcwText: LPCWSTR): BOOL = discardable BOOL SendMessage(hwnd, CB_SETCUEBANNER, 0, cast[LPARAM](lpcwText))
template ComboBox_SetMinVisible*(hwnd: HWND, iMinVisible: INT): BOOL = discardable BOOL SendMessage(hwnd, CB_SETMINVISIBLE, cast[WPARAM](iMinVisible), 0)
template DateTime_CloseMonthCal*(hdp: HWND): LRESULT = discardable LRESULT SendMessage(hdp, DTM_CLOSEMONTHCAL, 0, 0)
template DateTime_GetDateTimePickerInfo*(hdp: HWND, pdtpi: ptr DATETIMEPICKERINFO): LRESULT = discardable LRESULT SendMessage(hdp, DTM_GETDATETIMEPICKERINFO, 0, cast[LPARAM](pdtpi))
template DateTime_GetIdealSize*(hdp: HWND, psize: SIZE): BOOL = discardable BOOL SendMessage(hdp, DTM_GETIDEALSIZE, 0, cast[LPARAM](psize))
template DateTime_GetMonthCal*(hdp: HWND): HWND = discardable HWND SendMessage(hdp, DTM_GETMONTHCAL, 0, 0)
template DateTime_GetMonthCalColor*(hdp: HWND, iColor: int32): COLORREF = discardable COLORREF SendMessage(hdp, DTM_GETMCCOLOR, cast[WPARAM](iColor), 0)
template DateTime_GetMonthCalFont*(hdp: HWND): HFONT = discardable HFONT SendMessage(hdp, DTM_GETMCFONT, 0, 0)
template DateTime_GetMonthCalStyle*(hdp: HWND): LRESULT = discardable LRESULT SendMessage(hdp, DTM_GETMCSTYLE, 0, 0)
template DateTime_GetRange*(hdp: HWND, rgst: LPSYSTEMTIME): DWORD = discardable DWORD SendMessage(hdp, DTM_GETRANGE, 0, cast[LPARAM](rgst))
template DateTime_GetSystemtime*(hdp: HWND, pst: LPSYSTEMTIME): DWORD = discardable DWORD SendMessage(hdp, DTM_GETSYSTEMTIME, 0, cast[LPARAM](pst))
when winimUnicode:
  const
    DTM_SETFORMAT* = DTM_SETFORMATW
when winimAnsi:
  const
    DTM_SETFORMAT* = DTM_SETFORMATA
template DateTime_SetFormat*(hdp: HWND, sz: LPCTSTR): void = SendMessage(hdp, DTM_SETFORMAT, 0, cast[LPARAM](sz))
template DateTime_SetMonthCalColor*(hdp: HWND, iColor: int32, clr: COLORREF): COLORREF = discardable COLORREF SendMessage(hdp, DTM_SETMCCOLOR, cast[WPARAM](iColor), cast[LPARAM](clr))
template DateTime_SetMonthCalFont*(hdp: HWND, hfont: HFONT, fRedraw: int32): void = SendMessage(hdp, DTM_SETMCFONT, cast[WPARAM](hfont), cast[LPARAM](fRedraw))
template DateTime_SetMonthCalStyle*(hdp: HWND, dwStyle: DWORD): LRESULT = discardable LRESULT SendMessage(hdp, DTM_SETMCSTYLE, 0, cast[LPARAM](dwStyle))
template DateTime_SetRange*(hdp: HWND, gd: DWORD, rgst: LPSYSTEMTIME): BOOL = discardable BOOL SendMessage(hdp, DTM_SETRANGE, cast[WPARAM](gd), cast[LPARAM](rgst))
template DateTime_SetSystemtime*(hdp: HWND, gd: DWORD, pst: LPSYSTEMTIME): BOOL = discardable BOOL SendMessage(hdp, DTM_SETSYSTEMTIME, cast[WPARAM](gd), cast[LPARAM](pst))
template DPA_AppendPtr*(hdpa: HDPA, pitem: pointer): int32 = DPA_InsertPtr(hdpa, DA_LAST, pitem)
template DPA_FastDeleteLastPtr*(hdpa: HDPA): void = cast[ptr int32](hdpa)[].dec
template DPA_GetPtrPtr*(hdpa: HDPA): ptr pointer = discardable (cast[ptr ptr pointer](cast[int](hdpa) + sizeof(pointer)))[]
template DPA_FastGetPtr*(hdpa: HDPA, i: int32): ptr pointer = discardable cast[ptr pointer](cast[int](DPA_GetPtrPtr(hdpa)) + sizeof(pointer) * i)
template DPA_GetPtrCount*(hdpa: HDPA): int32 = discardable int32 cast[ptr int32](hdpa)[]
template DPA_SetPtrCount*(hdpa: HDPA, cItems: int32): int32 = (cast[ptr int32](hdpa)[] = cItems; discardable int32 cItems)
template DPA_SortedInsertPtr*(hdpa: HDPA, pFind: pointer, iStart: int32, pfnCompare: PFNDPACOMPARE, lParam: LPARAM, options: UINT, pitem: pointer): int32 = DPA_InsertPtr(hdpa, DPA_Search(hdpa, pFind, iStart, pfnCompare, lParam, options or DPAS_SORTED), pitem)
template DSA_AppendItem*(hdsa: HDSA, pitem: pointer): int32 = DSA_InsertItem(hdsa, DA_LAST, pitem)
template DSA_GetItemCount*(hdsa: HDSA): int32 = discardable int32 cast[ptr int32](hdsa)[]
template Edit_GetCueBannerText*(hwnd: HWND, lpwText: LPCWSTR, cchText: LONG): BOOL = discardable BOOL SendMessage(hwnd, EM_GETCUEBANNER, cast[WPARAM](lpwText), cast[LPARAM](cchText))
template Edit_GetHilite*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, EM_GETHILITE, 0, 0)
template Edit_HideBalloonTip*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, EM_HIDEBALLOONTIP, 0, 0)
template Edit_NoSetFocus*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, EM_NOSETFOCUS, 0, 0)
template Edit_SetCueBannerText*(hwnd: HWND, lpcwText: LPCWSTR): BOOL = discardable BOOL SendMessage(hwnd, EM_SETCUEBANNER, 0, cast[LPARAM](lpcwText))
template Edit_SetHilite*(hwnd: HWND, ichStart: int32, ichEnd: int32): void = SendMessage(hwnd, EM_SETHILITE, cast[WPARAM](ichStart), cast[LPARAM](ichEnd))
template Edit_ShowBalloonTip*(hwnd: HWND, peditballoontip: PEDITBALLOONTIP): BOOL = discardable BOOL SendMessage(hwnd, EM_SHOWBALLOONTIP, 0, cast[LPARAM](peditballoontip))
template Edit_TakeFocus*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, EM_TAKEFOCUS, 0, 0)
template Header_ClearAllFilters*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, HDM_CLEARFILTER, cast[WPARAM](-1), 0)
template Header_ClearFilter*(hwnd: HWND, i: int32): int32 = discardable int32 SendMessage(hwnd, HDM_CLEARFILTER, cast[WPARAM](i), 0)
template Header_CreateDragImage*(hwnd: HWND, i: int32): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, HDM_CREATEDRAGIMAGE, cast[WPARAM](i), 0)
template Header_DeleteItem*(hwndHD: HWND, i: int32): BOOL = discardable BOOL SendMessage(hwndHD, HDM_DELETEITEM, cast[WPARAM](i), 0)
template Header_EditFilter*(hwnd: HWND, i: int32, fDiscardChanges: BOOL): int32 = discardable int32 SendMessage(hwnd, HDM_EDITFILTER, cast[WPARAM](i), MAKELPARAM(fDiscardChanges, 0))
template Header_GetBitmapMargin*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, HDM_GETBITMAPMARGIN, 0, 0)
template Header_GetFocusedItem*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, HDM_GETFOCUSEDITEM, 0, 0)
template Header_GetImageList*(hwnd: HWND): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, HDM_GETIMAGELIST, 0, 0)
when winimUnicode:
  type
    LPHDITEM* = LPHDITEMW
when winimAnsi:
  type
    LPHDITEM* = LPHDITEMA
when winimUnicode:
  const
    HDM_GETITEM* = HDM_GETITEMW
when winimAnsi:
  const
    HDM_GETITEM* = HDM_GETITEMA
template Header_GetItem*(hwndHD: HWND, i: int32, phdi: LPHDITEM): BOOL = discardable BOOL SendMessage(hwndHD, HDM_GETITEM, cast[WPARAM](i), cast[LPARAM](phdi))
template Header_GetItemCount*(hwndHD: HWND): int32 = discardable int32 SendMessage(hwndHD, HDM_GETITEMCOUNT, 0, 0)
template Header_GetItemDropDownRect*(hwnd: HWND, iItem: int32, lprc: LPRECT): BOOL = discardable BOOL SendMessage(hwnd, HDM_GETITEMDROPDOWNRECT, cast[WPARAM](iItem), cast[LPARAM](lprc))
template Header_GetItemRect*(hwnd: HWND, iItem: int32, lprc: LPRECT): BOOL = discardable BOOL SendMessage(hwnd, HDM_GETITEMRECT, cast[WPARAM](iItem), cast[LPARAM](lprc))
template Header_GetOrderArray*(hwnd: HWND, iCount: int32, lpi: ptr int32): BOOL = discardable BOOL SendMessage(hwnd, HDM_GETORDERARRAY, cast[WPARAM](iCount), cast[LPARAM](lpi))
template Header_GetOverflowRect*(hwnd: HWND, lprc: LPRECT): BOOL = discardable BOOL SendMessage(hwnd, HDM_GETOVERFLOWRECT, 0, cast[LPARAM](lprc))
template Header_GetUnicodeFormat*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, HDM_GETUNICODEFORMAT, 0, 0)
when winimUnicode:
  const
    HDM_INSERTITEM* = HDM_INSERTITEMW
when winimAnsi:
  const
    HDM_INSERTITEM* = HDM_INSERTITEMA
template Header_InsertItem*(hwndHD: HWND, i: int32, phdi: LPHDITEM): int32 = discardable int32 SendMessage(hwndHD, HDM_INSERTITEM, cast[WPARAM](i), cast[LPARAM](phdi))
template Header_Layout*(hwndHD: HWND, playout: LPHDLAYOUT): BOOL = discardable BOOL SendMessage(hwndHD, HDM_LAYOUT, 0, cast[LPARAM](playout))
template Header_OrderToIndex*(hwnd: HWND, i: int32): int32 = discardable int32 SendMessage(hwnd, HDM_ORDERTOINDEX, cast[WPARAM](i), 0)
template Header_SetBitmapMargin*(hwnd: HWND, iWidth: int32): int32 = discardable int32 SendMessage(hwnd, HDM_SETBITMAPMARGIN, cast[WPARAM](iWidth), 0)
template Header_SetFilterChangeTimeout*(hwnd: HWND, i: int32): int32 = discardable int32 SendMessage(hwnd, HDM_SETFILTERCHANGETIMEOUT, 0, cast[LPARAM](i))
template Header_SetFocusedItem*(hwnd: HWND, iItem: int32): BOOL = discardable BOOL SendMessage(hwnd, HDM_SETFOCUSEDITEM, 0, cast[LPARAM](iItem))
template Header_SetHotDivider*(hwnd: HWND, fPos: BOOL, dw: DWORD): int32 = discardable int32 SendMessage(hwnd, HDM_SETHOTDIVIDER, cast[WPARAM](fPos), cast[LPARAM](dw))
template Header_SetImageList*(hwnd: HWND, himl: HIMAGELIST): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, HDM_SETIMAGELIST, 0, cast[LPARAM](himl))
when winimUnicode:
  const
    HDM_SETITEM* = HDM_SETITEMW
when winimAnsi:
  const
    HDM_SETITEM* = HDM_SETITEMA
template Header_SetItem*(hwndHD: HWND, i: int32, phdi: LPHDITEM): BOOL = discardable BOOL SendMessage(hwndHD, HDM_SETITEM, cast[WPARAM](i), cast[LPARAM](phdi))
template Header_SetOrderArray*(hwnd: HWND, iCount: int32, lpi: ptr int32): BOOL = discardable BOOL SendMessage(hwnd, HDM_SETORDERARRAY, cast[WPARAM](iCount), cast[LPARAM](lpi))
template Header_SetUnicodeFormat*(hwnd: HWND, fUnicode: BOOL): BOOL = discardable BOOL SendMessage(hwnd, HDM_SETUNICODEFORMAT, cast[WPARAM](fUnicode), 0)
template ImageList_AddIcon*(himl: HIMAGELIST, hicon: HICON): int32 = ImageList_ReplaceIcon(himl, -1, hicon)
template ImageList_ExtractIcon*(hi: HINSTANCE, himl: HIMAGELIST, i: int32): HICON = ImageList_GetIcon(himl, i, 0)
template ImageList_LoadBitmap*(hi: HINSTANCE, lpbmp: LPCTSTR, cx: int32, cGrow: int32, crMask: COLORREF): HIMAGELIST = ImageList_LoadImage(hi, lpbmp, cx, cGrow, crMask, IMAGE_BITMAP, 0)
template ImageList_RemoveAll*(himl: HIMAGELIST): BOOL = ImageList_Remove(himl, -1)
template ListView_ApproximateViewRect*(hwnd: HWND, iWidth: int32, iHeight: int32, iCount: int32): DWORD = discardable DWORD SendMessage(hwnd, LVM_APPROXIMATEVIEWRECT, cast[WPARAM](iCount), MAKELPARAM(iWidth, iHeight))
template ListView_Arrange*(hwnd: HWND, code: UINT): BOOL = discardable BOOL SendMessage(hwnd, LVM_ARRANGE, cast[WPARAM](code), 0)
template ListView_CancelEditLabel*(hwnd: HWND): void = SendMessage(hwnd, LVM_CANCELEDITLABEL, 0, 0)
template ListView_CreateDragImage*(hwnd: HWND, i: int32, lpptUpLeft: LPPOINT): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, LVM_CREATEDRAGIMAGE, cast[WPARAM](i), cast[LPARAM](lpptUpLeft))
template ListView_DeleteAllItems*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, LVM_DELETEALLITEMS, 0, 0)
template ListView_DeleteColumn*(hwnd: HWND, iCol: int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_DELETECOLUMN, cast[WPARAM](iCol), 0)
template ListView_DeleteItem*(hwnd: HWND, i: int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_DELETEITEM, cast[WPARAM](i), 0)
when winimUnicode:
  const
    LVM_EDITLABEL* = LVM_EDITLABELW
when winimAnsi:
  const
    LVM_EDITLABEL* = LVM_EDITLABELA
template ListView_EditLabel*(hwnd: HWND, i: int32): HWND = discardable HWND SendMessage(hwnd, LVM_EDITLABEL, cast[WPARAM](i), 0)
template ListView_EnableGroupView*(hwnd: HWND, fEnable: BOOL): int32 = discardable int32 SendMessage(hwnd, LVM_ENABLEGROUPVIEW, cast[WPARAM](fEnable), 0)
template ListView_EnsureVisible*(hwnd: HWND, i: int32, fPartialOK: BOOL): BOOL = discardable BOOL SendMessage(hwnd, LVM_ENSUREVISIBLE, cast[WPARAM](i), MAKELPARAM(fPartialOK, 0))
when winimUnicode:
  type
    LVFINDINFO* = LVFINDINFOW
when winimAnsi:
  type
    LVFINDINFO* = LVFINDINFOA
when winimUnicode:
  const
    LVM_FINDITEM* = LVM_FINDITEMW
when winimAnsi:
  const
    LVM_FINDITEM* = LVM_FINDITEMA
template ListView_FindItem*(hwnd: HWND, iStart: int32, plvfi: ptr LVFINDINFO): int32 = discardable int32 SendMessage(hwnd, LVM_FINDITEM, cast[WPARAM](iStart), cast[LPARAM](plvfi))
template ListView_GetBkColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, LVM_GETBKCOLOR, 0, 0)
when winimUnicode:
  type
    LPLVBKIMAGE* = LPLVBKIMAGEW
when winimAnsi:
  type
    LPLVBKIMAGE* = LPLVBKIMAGEA
when winimUnicode:
  const
    LVM_GETBKIMAGE* = LVM_GETBKIMAGEW
when winimAnsi:
  const
    LVM_GETBKIMAGE* = LVM_GETBKIMAGEA
template ListView_GetBkImage*(hwnd: HWND, plvbki: LPLVBKIMAGE): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETBKIMAGE, 0, cast[LPARAM](plvbki))
template ListView_GetCallbackMask*(hwnd: HWND): UINT = discardable UINT SendMessage(hwnd, LVM_GETCALLBACKMASK, 0, 0)
template ListView_GetCheckState*(hwnd: HWND, i: UINT): BOOL = discardable BOOL((SendMessage(hwnd, LVM_GETITEMSTATE, cast[WPARAM](i), LVIS_STATEIMAGEMASK) shr 12) - 1)
when winimUnicode:
  type
    LPLVCOLUMN* = LPLVCOLUMNW
when winimAnsi:
  type
    LPLVCOLUMN* = LPLVCOLUMNA
when winimUnicode:
  const
    LVM_GETCOLUMN* = LVM_GETCOLUMNW
when winimAnsi:
  const
    LVM_GETCOLUMN* = LVM_GETCOLUMNA
template ListView_GetColumn*(hwnd: HWND, iCol: int32, pcol: LPLVCOLUMN): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETCOLUMN, cast[WPARAM](iCol), cast[LPARAM](pcol))
template ListView_GetColumnOrderArray*(hwnd: HWND, iCount: int32, pi: ptr int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETCOLUMNORDERARRAY, cast[WPARAM](iCount), cast[LPARAM](pi))
template ListView_GetColumnWidth*(hwnd: HWND, iCol: int32): int32 = discardable int32 SendMessage(hwnd, LVM_GETCOLUMNWIDTH, cast[WPARAM](iCol), 0)
template ListView_GetCountPerPage*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, LVM_GETCOUNTPERPAGE, 0, 0)
template ListView_GetEditControl*(hwnd: HWND): HWND = discardable HWND SendMessage(hwnd, LVM_GETEDITCONTROL, 0, 0)
template ListView_GetEmptyText*(hwnd: HWND, pszText: PWSTR, cchText: UINT): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETEMPTYTEXT, cast[WPARAM](cchText), cast[LPARAM](pszText))
template ListView_GetExtendedListViewStyle*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0)
template ListView_GetFocusedGroup*(hwnd: HWND): INT = discardable INT SendMessage(hwnd, LVM_GETFOCUSEDGROUP, 0, 0)
template ListView_GetFooterInfo*(hwnd: HWND, plvfi: LPLVFOOTERINFO): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETFOOTERINFO, cast[WPARAM]((0)), cast[LPARAM](plvfi))
template ListView_GetFooterItem*(hwnd: HWND, iItem: UINT, pfi: ptr LVFOOTERITEM): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETFOOTERITEM, cast[WPARAM](iItem), cast[LPARAM](pfi))
template ListView_GetFooterItemRect*(hwnd: HWND, iItem: UINT, prc: ptr RECT): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETFOOTERITEMRECT, cast[WPARAM](iItem), cast[LPARAM](prc))
template ListView_GetFooterRect*(hwnd: HWND, prc: ptr RECT): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETFOOTERRECT, cast[WPARAM]((0)), cast[LPARAM](prc))
template ListView_GetGroupCount*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, LVM_GETGROUPCOUNT, 0, 0)
template ListView_GetGroupHeaderImageList*(hwnd: HWND): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, LVM_GETIMAGELIST, cast[WPARAM](LVSIL_GROUPHEADER), 0)
template ListView_GetGroupInfo*(hwnd: HWND, iGroupId: int32, pgrp: PLVGROUP): int32 = discardable int32 SendMessage(hwnd, LVM_GETGROUPINFO, cast[WPARAM](iGroupId), cast[LPARAM](pgrp))
template ListView_GetGroupInfoByIndex*(hwnd: HWND, iIndex: int32, pgrp: PLVGROUP): LRESULT = discardable LRESULT SendMessage(hwnd, LVM_GETGROUPINFOBYINDEX, cast[WPARAM](iIndex), cast[LPARAM](pgrp))
template ListView_GetGroupMetrics*(hwnd: HWND, pGroupMetrics: PLVGROUPMETRICS): void = SendMessage(hwnd, LVM_GETGROUPMETRICS, 0, cast[LPARAM](pGroupMetrics))
template ListView_GetGroupRect*(hwnd: HWND, iGroupId: int32, `type`: LONG, prc: ptr RECT): BOOL = (if prc.pointer != nil: cast[ptr RECT](cast[int](prc)).top = `type`; discardable BOOL SendMessage(hwnd, LVM_GETGROUPRECT, cast[WPARAM](iGroupId), cast[LPARAM](prc)))
template ListView_GetGroupState*(hwnd: HWND, dwGroupId: UINT, dwMask: UINT): UINT = discardable UINT SendMessage(hwnd, LVM_GETGROUPSTATE, cast[WPARAM](dwGroupId), cast[LPARAM](dwMask))
template ListView_GetHeader*(hwnd: HWND): HWND = discardable HWND SendMessage(hwnd, LVM_GETHEADER, 0, 0)
template ListView_GetHotCursor*(hwnd: HWND): HCURSOR = discardable HCURSOR SendMessage(hwnd, LVM_GETHOTCURSOR, 0, 0)
template ListView_GetHotItem*(hwnd: HWND): INT = discardable INT SendMessage(hwnd, LVM_GETHOTITEM, 0, 0)
template ListView_GetHoverTime*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, LVM_GETHOVERTIME, 0, 0)
template ListView_GetImageList*(hwnd: HWND, iImageList: int32): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, LVM_GETIMAGELIST, cast[WPARAM](iImageList), 0)
template ListView_GetInsertMark*(hwnd: HWND, lvim: LPLVINSERTMARK): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETINSERTMARK, 0, cast[LPARAM](lvim))
template ListView_GetInsertMarkColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, LVM_GETINSERTMARKCOLOR, 0, 0)
template ListView_GetInsertMarkRect*(hwnd: HWND, rc: LPRECT): int32 = discardable int32 SendMessage(hwnd, LVM_GETINSERTMARKRECT, 0, cast[LPARAM](rc))
when winimUnicode:
  const
    LVM_GETISEARCHSTRING* = LVM_GETISEARCHSTRINGW
when winimAnsi:
  const
    LVM_GETISEARCHSTRING* = LVM_GETISEARCHSTRINGA
template ListView_GetISearchString*(hwnd: HWND, lpsz: LPSTR): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETISEARCHSTRING, 0, cast[LPARAM](lpsz))
when winimUnicode:
  type
    LPLVITEM* = LPLVITEMW
when winimAnsi:
  type
    LPLVITEM* = LPLVITEMA
when winimUnicode:
  const
    LVM_GETITEM* = LVM_GETITEMW
when winimAnsi:
  const
    LVM_GETITEM* = LVM_GETITEMA
template ListView_GetItem*(hwnd: HWND, pitem: LPLVITEM): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETITEM, 0, cast[LPARAM](pitem))
template ListView_GetItemCount*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, LVM_GETITEMCOUNT, 0, 0)
template ListView_GetItemIndexRect*(hwnd: HWND, plvii: ptr LVITEMINDEX, iSubItem: LONG, code: LONG, prc: LPRECT): BOOL = (if prc.pointer != nil: (cast[ptr RECT](cast[int](prc)).top = iSubItem; cast[ptr RECT](cast[int](prc)).left = code); discardable BOOL SendMessage(hwnd, LVM_GETITEMINDEXRECT, cast[WPARAM](plvii), cast[LPARAM](prc)))
template ListView_GetItemPosition*(hwnd: HWND, i: int32, ppt: ptr POINT): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETITEMPOSITION, cast[WPARAM](i), cast[LPARAM](ppt))
template ListView_GetItemRect*(hwnd: HWND, i: int32, prc: ptr RECT, code: int32): BOOL = (if prc.pointer != nil: cast[ptr RECT](cast[int](prc)).left = code; discardable BOOL SendMessage(hwnd, LVM_GETITEMRECT, cast[WPARAM](i), cast[LPARAM](prc)))
template ListView_GetItemSpacing*(hwnd: HWND, fSmall: BOOL): DWORD = discardable DWORD SendMessage(hwnd, LVM_GETITEMSPACING, cast[WPARAM](fSmall), 0)
template ListView_GetItemState*(hwnd: HWND, i: int32, mask: UINT): UINT = discardable UINT SendMessage(hwnd, LVM_GETITEMSTATE, cast[WPARAM](i), cast[LPARAM](mask))
when winimUnicode:
  const
    LVM_GETITEMTEXT* = LVM_GETITEMTEXTW
when winimAnsi:
  const
    LVM_GETITEMTEXT* = LVM_GETITEMTEXTA
template ListView_GetItemText*(hwnd: HWND, i: int32, iSub: int32, text: LPTSTR, max: int32): void = (var lvi = LV_ITEM(iSubItem: iSub, cchTextMax: max, pszText: text); SendMessage(hwnd, LVM_GETITEMTEXT, cast[WPARAM](i), cast[LPARAM](addr lvi)))
template ListView_GetNextItem*(hwnd: HWND, i: int32, flags: UINT): int32 = discardable int32 SendMessage(hwnd, LVM_GETNEXTITEM, cast[WPARAM](i), MAKELPARAM(flags, 0))
template ListView_GetNextItemIndex*(hwnd: HWND, plvii: ptr LVITEMINDEX, flags: LPARAM): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETNEXTITEMINDEX, cast[WPARAM](plvii), MAKELPARAM(flags, 0))
template ListView_GetNumberOfWorkAreas*(hwnd: HWND, pnWorkAreas: ptr UINT): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETNUMBEROFWORKAREAS, 0, cast[LPARAM](pnWorkAreas))
template ListView_GetOrigin*(hwnd: HWND, ppt: LPPOINT): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETORIGIN, 0, cast[LPARAM](ppt))
template ListView_GetOutlineColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, LVM_GETOUTLINECOLOR, 0, 0)
template ListView_GetSelectedColumn*(hwnd: HWND): UINT = discardable UINT SendMessage(hwnd, LVM_GETSELECTEDCOLUMN, 0, 0)
template ListView_GetSelectedCount*(hwnd: HWND): UINT = discardable UINT SendMessage(hwnd, LVM_GETSELECTEDCOUNT, 0, 0)
template ListView_GetSelectionMark*(hwnd: HWND): INT = discardable INT SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0)
when winimUnicode:
  const
    LVM_GETSTRINGWIDTH* = LVM_GETSTRINGWIDTHW
when winimAnsi:
  const
    LVM_GETSTRINGWIDTH* = LVM_GETSTRINGWIDTHA
template ListView_GetStringWidth*(hwnd: HWND, psz: LPCSTR): int32 = discardable int32 SendMessage(hwnd, LVM_GETSTRINGWIDTH, 0, cast[LPARAM](psz))
template ListView_GetSubItemRect*(hwnd: HWND, iItem: int32, iSubItem: int32, code: int32, prc: LPRECT): BOOL = (if prc.pointer != nil: (cast[LPRECT](cast[int](prc)).top = iSubItem; cast[LPRECT](cast[int](prc)).left = code); discardable BOOL SendMessage(hwnd, LVM_GETSUBITEMRECT, cast[WPARAM](iItem), cast[LPARAM](prc)))
template ListView_GetTextBkColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, LVM_GETTEXTBKCOLOR, 0, 0)
template ListView_GetTextColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, LVM_GETTEXTCOLOR, 0, 0)
template ListView_GetTileInfo*(hwnd: HWND, pti: PLVTILEINFO): void = SendMessage(hwnd, LVM_GETTILEINFO, 0, cast[LPARAM](pti))
template ListView_GetTileViewInfo*(hwnd: HWND, ptvi: PLVTILEVIEWINFO): void = SendMessage(hwnd, LVM_GETTILEVIEWINFO, 0, cast[LPARAM](ptvi))
template ListView_GetToolTips*(hwnd: HWND): HWND = discardable HWND SendMessage(hwnd, LVM_GETTOOLTIPS, 0, 0)
template ListView_GetTopIndex*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, LVM_GETTOPINDEX, 0, 0)
template ListView_GetUnicodeFormat*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETUNICODEFORMAT, 0, 0)
template ListView_GetView*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, LVM_GETVIEW, 0, 0)
template ListView_GetViewRect*(hwnd: HWND, prc: ptr RECT): BOOL = discardable BOOL SendMessage(hwnd, LVM_GETVIEWRECT, 0, cast[LPARAM](prc))
template ListView_GetWorkAreas*(hwnd: HWND, nWorkAreas: INT, prc: LPRECT): void = SendMessage(hwnd, LVM_GETWORKAREAS, cast[WPARAM](nWorkAreas), cast[LPARAM](prc))
template ListView_HasGroup*(hwnd: HWND, dwGroupId: int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_HASGROUP, cast[WPARAM](dwGroupId), 0)
template ListView_HitTest*(hwnd: HWND, pinfo: LPLVHITTESTINFO): int32 = discardable int32 SendMessage(hwnd, LVM_HITTEST, 0, cast[LPARAM](pinfo))
when winimUnicode:
  const
    LVM_INSERTCOLUMN* = LVM_INSERTCOLUMNW
when winimAnsi:
  const
    LVM_INSERTCOLUMN* = LVM_INSERTCOLUMNA
template ListView_InsertColumn*(hwnd: HWND, iCol: int32, pcol: LPLVCOLUMN): int32 = discardable int32 SendMessage(hwnd, LVM_INSERTCOLUMN, cast[WPARAM](iCol), cast[LPARAM](pcol))
template ListView_InsertGroup*(hwnd: HWND, index: int32, pgrp: PLVGROUP): int32 = discardable int32 SendMessage(hwnd, LVM_INSERTGROUP, cast[WPARAM](index), cast[LPARAM](pgrp))
template ListView_InsertGroupSorted*(hwnd: HWND, structInsert: PLVINSERTGROUPSORTED): void = SendMessage(hwnd, LVM_INSERTGROUPSORTED, cast[WPARAM](structInsert), 0)
when winimUnicode:
  const
    LVM_INSERTITEM* = LVM_INSERTITEMW
when winimAnsi:
  const
    LVM_INSERTITEM* = LVM_INSERTITEMA
template ListView_InsertItem*(hwnd: HWND, pitem: LPLVITEM): int32 = discardable int32 SendMessage(hwnd, LVM_INSERTITEM, 0, cast[LPARAM](pitem))
template ListView_InsertMarkHitTest*(hwnd: HWND, point: LPPOINT, lvim: LPLVINSERTMARK): BOOL = discardable BOOL SendMessage(hwnd, LVM_INSERTMARKHITTEST, cast[WPARAM](point), cast[LPARAM](lvim))
template ListView_IsGroupViewEnabled*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, LVM_ISGROUPVIEWENABLED, 0, 0)
template ListView_IsItemVisible*(hwnd: HWND, index: UINT): UINT = discardable UINT SendMessage(hwnd, LVM_ISITEMVISIBLE, cast[WPARAM](index), 0)
template ListView_MapIDToIndex*(hwnd: HWND, id: UINT): UINT = discardable UINT SendMessage(hwnd, LVM_MAPIDTOINDEX, cast[WPARAM](id), 0)
template ListView_MapIndexToID*(hwnd: HWND, index: UINT): UINT = discardable UINT SendMessage(hwnd, LVM_MAPINDEXTOID, cast[WPARAM](index), 0)
template ListView_MoveGroup*(hwnd: HWND, iGroupId: int32, toIndex: int32): void = SendMessage(hwnd, LVM_MOVEGROUP, cast[WPARAM](iGroupId), cast[LPARAM](toIndex))
template ListView_MoveItemToGroup*(hwnd: HWND, idItemFrom: int32, idGroupTo: int32): void = SendMessage(hwnd, LVM_MOVEITEMTOGROUP, cast[WPARAM](idItemFrom), cast[LPARAM](idGroupTo))
template ListView_RedrawItems*(hwnd: HWND, iFirst: int32, iLast: int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_REDRAWITEMS, cast[WPARAM](iFirst), cast[LPARAM](iLast))
template ListView_RemoveAllGroups*(hwnd: HWND): void = SendMessage(hwnd, LVM_REMOVEALLGROUPS, 0, 0)
template ListView_RemoveGroup*(hwnd: HWND, iGroupId: int32): int32 = discardable int32 SendMessage(hwnd, LVM_REMOVEGROUP, cast[WPARAM](iGroupId), 0)
template ListView_Scroll*(hwnd: HWND, dx: int32, dy: int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_SCROLL, cast[WPARAM](dx), cast[LPARAM](dy))
template ListView_SetBkColor*(hwnd: HWND, clrBk: COLORREF): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETBKCOLOR, 0, cast[LPARAM](clrBk))
when winimUnicode:
  const
    LVM_SETBKIMAGE* = LVM_SETBKIMAGEW
when winimAnsi:
  const
    LVM_SETBKIMAGE* = LVM_SETBKIMAGEA
template ListView_SetBkImage*(hwnd: HWND, plvbki: LPLVBKIMAGE): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETBKIMAGE, 0, cast[LPARAM](plvbki))
template ListView_SetCallbackMask*(hwnd: HWND, mask: UINT): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETCALLBACKMASK, cast[WPARAM](mask), 0)
template ListView_SetItemState*(hwnd: HWND, i: int32, data: UINT, mask: UINT): void = (var lvi = LV_ITEM(stateMask: mask, state: data); SendMessage(hwnd, LVM_SETITEMSTATE, cast[WPARAM](i), cast[LPARAM](addr lvi)))
template ListView_SetCheckState*(hwnd: HWND, i: UINT, fCheck: BOOL) = ListView_SetItemState(hwnd, i, INDEXTOSTATEIMAGEMASK(if bool fCheck:2 else:1), LVIS_STATEIMAGEMASK)
when winimUnicode:
  const
    LVM_SETCOLUMN* = LVM_SETCOLUMNW
when winimAnsi:
  const
    LVM_SETCOLUMN* = LVM_SETCOLUMNA
template ListView_SetColumn*(hwnd: HWND, iCol: int32, pcol: LPLVCOLUMN): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETCOLUMN, cast[WPARAM](iCol), cast[LPARAM](pcol))
template ListView_SetColumnOrderArray*(hwnd: HWND, iCount: int32, pi: ptr int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETCOLUMNORDERARRAY, cast[WPARAM](iCount), cast[LPARAM](pi))
template ListView_SetColumnWidth*(hwnd: HWND, iCol: int32, cx: int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETCOLUMNWIDTH, cast[WPARAM](iCol), MAKELPARAM(cx, 0))
template ListView_SetExtendedListViewStyle*(hwnd: HWND, dw: DWORD): void = SendMessage(hwnd, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, cast[LPARAM](dw))
template ListView_SetExtendedListViewStyleEx*(hwnd: HWND, dwMask: DWORD, dw: DWORD): void = SendMessage(hwnd, LVM_SETEXTENDEDLISTVIEWSTYLE, cast[WPARAM](dwMask), cast[LPARAM](dw))
template ListView_SetGroupHeaderImageList*(hwnd: HWND, himl: HIMAGELIST): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, LVM_SETIMAGELIST, cast[WPARAM](LVSIL_GROUPHEADER), cast[LPARAM](himl))
template ListView_SetGroupInfo*(hwnd: HWND, iGroupId: int32, pgrp: PLVGROUP): int32 = discardable int32 SendMessage(hwnd, LVM_SETGROUPINFO, cast[WPARAM](iGroupId), cast[LPARAM](pgrp))
template ListView_SetGroupMetrics*(hwnd: HWND, pGroupMetrics: PLVGROUPMETRICS): void = SendMessage(hwnd, LVM_SETGROUPMETRICS, 0, cast[LPARAM](pGroupMetrics))
template ListView_SetGroupState*(hwnd: HWND, dwGroupId: UINT, dwMask: UINT, dwState: UINT): LRESULT = (var lvg = LVGROUP(cbSize: int32 sizeof(LVGROUP), mask: LVGF_STATE, stateMask: dwMask, state: dwState); discardable LRESULT SendMessage(hwnd, LVM_SETGROUPINFO, cast[WPARAM](dwGroupId), cast[LPARAM](addr lvg)))
template ListView_SetHotCursor*(hwnd: HWND, hcur: HCURSOR): HCURSOR = discardable HCURSOR SendMessage(hwnd, LVM_SETHOTCURSOR, 0, cast[LPARAM](hcur))
template ListView_SetHotItem*(hwnd: HWND, i: INT): INT = discardable INT SendMessage(hwnd, LVM_SETHOTITEM, cast[WPARAM](i), 0)
template ListView_SetHoverTime*(hwnd: HWND, dwHoverTimeMs: DWORD): void = SendMessage(hwnd, LVM_SETHOVERTIME, 0, cast[LPARAM](dwHoverTimeMs))
template ListView_SetIconSpacing*(hwnd: HWND, cx: int32, cy: int32): DWORD = discardable DWORD SendMessage(hwnd, LVM_SETICONSPACING, 0, MAKELONG(cx, cy))
template ListView_SetImageList*(hwnd: HWND, himl: HIMAGELIST, iImageList: int32): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, LVM_SETIMAGELIST, cast[WPARAM](iImageList), cast[LPARAM](himl))
template ListView_SetInfoTip*(hwnd: HWND, plvInfoTip: PLVSETINFOTIP): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETINFOTIP, 0, cast[LPARAM](plvInfoTip))
template ListView_SetInsertMark*(hwnd: HWND, lvim: LPLVINSERTMARK): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETINSERTMARK, 0, cast[LPARAM](lvim))
template ListView_SetInsertMarkColor*(hwnd: HWND, color: COLORREF): COLORREF = discardable COLORREF SendMessage(hwnd, LVM_SETINSERTMARKCOLOR, 0, cast[LPARAM](color))
when winimUnicode:
  const
    LVM_SETITEM* = LVM_SETITEMW
when winimAnsi:
  const
    LVM_SETITEM* = LVM_SETITEMA
template ListView_SetItem*(hwnd: HWND, pitem: LPLVITEM): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETITEM, 0, cast[LPARAM](pitem))
template ListView_SetItemCount*(hwnd: HWND, cItems: int32): void = SendMessage(hwnd, LVM_SETITEMCOUNT, cast[WPARAM](cItems), 0)
template ListView_SetItemCountEx*(hwnd: HWND, cItems: int32, dwFlags: DWORD): void = SendMessage(hwnd, LVM_SETITEMCOUNT, cast[WPARAM](cItems), cast[LPARAM](dwFlags))
template ListView_SetItemIndexState*(hwnd: HWND, plvii: ptr LVITEMINDEX, data: UINT, mask: UINT): HRESULT = (var lvi = LV_ITEM(stateMask: mask, state: data); discardable HRESULT SendMessage(hwnd, LVM_SETITEMINDEXSTATE, cast[WPARAM](plvii), cast[LPARAM](addr lvi)))
template ListView_SetItemPosition*(hwnd: HWND, i: int32, x: int32, y: int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETITEMPOSITION, cast[WPARAM](i), MAKELPARAM(x, y))
template ListView_SetItemPosition32*(hwnd: HWND, i: int32, x0: int32, y0: int32): void = (var p = POINT(x: x0, y: y0); SendMessage(hwnd, LVM_SETITEMPOSITION32, cast[WPARAM](i), cast[LPARAM](addr p)))
when winimUnicode:
  const
    LVM_SETITEMTEXT* = LVM_SETITEMTEXTW
when winimAnsi:
  const
    LVM_SETITEMTEXT* = LVM_SETITEMTEXTA
template ListView_SetItemText*(hwnd: HWND, i: int32, iSub: int32, text: LPCTSTR): void = (var lvi = LV_ITEM(iSubItem: iSub, pszText: text); SendMessage(hwnd, LVM_SETITEMTEXT, cast[WPARAM](i), cast[LPARAM](addr lvi)))
template ListView_SetOutlineColor*(hwnd: HWND, color: COLORREF): COLORREF = discardable COLORREF SendMessage(hwnd, LVM_SETOUTLINECOLOR, 0, cast[LPARAM](color))
template ListView_SetSelectedColumn*(hwnd: HWND, iCol: int32): void = SendMessage(hwnd, LVM_SETSELECTEDCOLUMN, cast[WPARAM](iCol), 0)
template ListView_SetSelectionMark*(hwnd: HWND, i: INT): INT = discardable INT SendMessage(hwnd, LVM_SETSELECTIONMARK, 0, cast[LPARAM](i))
template ListView_SetTextBkColor*(hwnd: HWND, clrTextBk: COLORREF): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETTEXTBKCOLOR, 0, cast[LPARAM](clrTextBk))
template ListView_SetTextColor*(hwnd: HWND, clrText: COLORREF): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETTEXTCOLOR, 0, cast[LPARAM](clrText))
template ListView_SetTileInfo*(hwnd: HWND, pti: PLVTILEINFO): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETTILEINFO, 0, cast[LPARAM](pti))
template ListView_SetTileViewInfo*(hwnd: HWND, ptvi: PLVTILEVIEWINFO): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETTILEVIEWINFO, 0, cast[LPARAM](ptvi))
template ListView_SetTileWidth*(hwnd: HWND, cpWidth: int32): void = SendMessage(hwnd, LVM_SETTILEWIDTH, cast[WPARAM](cpWidth), 0)
template ListView_SetToolTips*(hwnd: HWND, hwndNewHwnd: HWND): HWND = discardable HWND SendMessage(hwnd, LVM_SETTOOLTIPS, cast[WPARAM](hwndNewHwnd), 0)
template ListView_SetUnicodeFormat*(hwnd: HWND, fUnicode: BOOL): BOOL = discardable BOOL SendMessage(hwnd, LVM_SETUNICODEFORMAT, cast[WPARAM](fUnicode), 0)
template ListView_SetView*(hwnd: HWND, iView: DWORD): int32 = discardable int32 SendMessage(hwnd, LVM_SETVIEW, cast[WPARAM](iView), 0)
template ListView_SetWorkAreas*(hwnd: HWND, nWorkAreas: INT, prc: LPRECT): void = SendMessage(hwnd, LVM_SETWORKAREAS, cast[WPARAM](nWorkAreas), cast[LPARAM](prc))
template ListView_SortGroups*(hwnd: HWND, pfnGroupCompate: PFNLVGROUPCOMPARE, plv: LPVOID): int32 = discardable int32 SendMessage(hwnd, LVM_SORTGROUPS, cast[WPARAM](pfnGroupCompate), cast[LPARAM](plv))
template ListView_SortItems*(hwnd: HWND, pfnCompare: PFNLVCOMPARE, lPrm: LPARAM): BOOL = discardable BOOL SendMessage(hwnd, LVM_SORTITEMS, cast[WPARAM](lPrm), cast[LPARAM](pfnCompare))
template ListView_SortItemsEx*(hwnd: HWND, pfnCompare: PFNLVCOMPARE, lPrm: LPARAM): BOOL = discardable BOOL SendMessage(hwnd, LVM_SORTITEMSEX, cast[WPARAM](lPrm), cast[LPARAM](pfnCompare))
template ListView_SubItemHitTest*(hwnd: HWND, plvhti: LPLVHITTESTINFO): INT = discardable INT SendMessage(hwnd, LVM_SUBITEMHITTEST, 0, cast[LPARAM](plvhti))
template ListView_SubItemHitTestEx*(hwnd: HWND, plvhti: LPLVHITTESTINFO): INT = discardable INT SendMessage(hwnd, LVM_SUBITEMHITTEST, cast[WPARAM](-1), cast[LPARAM](plvhti))
template ListView_Update*(hwnd: HWND, i: int32): BOOL = discardable BOOL SendMessage(hwnd, LVM_UPDATE, cast[WPARAM](i), 0)
template MonthCal_GetCalendarBorder*(hmc: HWND): DWORD = discardable DWORD SendMessage(hmc, MCM_GETCALENDARBORDER, 0, 0)
template MonthCal_GetCalendarCount*(hmc: HWND): DWORD = discardable DWORD SendMessage(hmc, MCM_GETCALENDARCOUNT, 0, 0)
template MonthCal_GetCalendarGridInfo*(hmc: HWND, pmcGridInfo: ptr MCGRIDINFO): BOOL = discardable BOOL SendMessage(hmc, MCM_GETCALENDARGRIDINFO, 0, cast[LPARAM](pmcGridInfo))
template MonthCal_GetCALID*(hmc: HWND): CALID = discardable CALID SendMessage(hmc, MCM_GETCALID, 0, 0)
template MonthCal_GetColor*(hmc: HWND, iColor: INT): COLORREF = discardable COLORREF SendMessage(hmc, MCM_GETCOLOR, cast[WPARAM](iColor), 0)
template MonthCal_GetCurrentView*(hmc: HWND): DWORD = discardable DWORD SendMessage(hmc, MCM_GETCURRENTVIEW, 0, 0)
template MonthCal_GetCurSel*(hmc: HWND, pst: LPSYSTEMTIME): BOOL = discardable BOOL SendMessage(hmc, MCM_GETCURSEL, 0, cast[LPARAM](pst))
template MonthCal_GetFirstDayOfWeek*(hmc: HWND): DWORD = discardable DWORD SendMessage(hmc, MCM_GETFIRSTDAYOFWEEK, 0, 0)
template MonthCal_GetMaxSelCount*(hmc: HWND): DWORD = discardable DWORD SendMessage(hmc, MCM_GETMAXSELCOUNT, 0, 0)
template MonthCal_GetMaxTodayWidth*(hmc: HWND): DWORD = discardable DWORD SendMessage(hmc, MCM_GETMAXTODAYWIDTH, 0, 0)
template MonthCal_GetMinReqRect*(hmc: HWND, prc: LPRECT): BOOL = discardable BOOL SendMessage(hmc, MCM_GETMINREQRECT, 0, cast[LPARAM](prc))
template MonthCal_GetMonthDelta*(hmc: HWND): INT = discardable INT SendMessage(hmc, MCM_GETMONTHDELTA, 0, 0)
template MonthCal_GetMonthRange*(hmc: HWND, gmr: DWORD, rgst: LPSYSTEMTIME): INT = discardable INT SendMessage(hmc, MCM_GETMONTHRANGE, cast[WPARAM](gmr), cast[LPARAM](rgst))
template MonthCal_GetRange*(hmc: HWND, rgst: LPSYSTEMTIME): DWORD = discardable DWORD SendMessage(hmc, MCM_GETRANGE, 0, cast[LPARAM](rgst))
template MonthCal_GetSelRange*(hmc: HWND, rgst: LPSYSTEMTIME): BOOL = discardable BOOL SendMessage(hmc, MCM_GETSELRANGE, 0, cast[LPARAM](rgst))
template MonthCal_GetToday*(hmc: HWND, pst: LPSYSTEMTIME): BOOL = discardable BOOL SendMessage(hmc, MCM_GETTODAY, 0, cast[LPARAM](pst))
template MonthCal_GetUnicodeFormat*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, MCM_GETUNICODEFORMAT, 0, 0)
template MonthCal_HitTest*(hmc: HWND, pinfo: PMCHITTESTINFO): DWORD = discardable DWORD SendMessage(hmc, MCM_HITTEST, 0, cast[LPARAM](pinfo))
template MonthCal_SetCalendarBorder*(hmc: HWND, fset: BOOL, xyborder: int32): LRESULT = discardable LRESULT SendMessage(hmc, MCM_SETCALENDARBORDER, cast[WPARAM](fset), cast[LPARAM](xyborder))
template MonthCal_SetCALID*(hmc: HWND, calid: UINT): LRESULT = discardable LRESULT SendMessage(hmc, MCM_SETCALID, cast[WPARAM](calid), 0)
template MonthCal_SetColor*(hmc: HWND, iColor: INT, clr: COLORREF): COLORREF = discardable COLORREF SendMessage(hmc, MCM_SETCOLOR, cast[WPARAM](iColor), cast[LPARAM](clr))
template MonthCal_SetCurrentView*(hmc: HWND, dwNewView: DWORD): BOOL = discardable BOOL SendMessage(hmc, MCM_SETCURRENTVIEW, 0, cast[LPARAM](dwNewView))
template MonthCal_SetCurSel*(hmc: HWND, pst: LPSYSTEMTIME): BOOL = discardable BOOL SendMessage(hmc, MCM_SETCURSEL, 0, cast[LPARAM](pst))
template MonthCal_SetDayState*(hmc: HWND, cbds: INT, rgds: LPMONTHDAYSTATE): BOOL = discardable BOOL SendMessage(hmc, MCM_SETDAYSTATE, cast[WPARAM](cbds), cast[LPARAM](rgds))
template MonthCal_SetFirstDayOfWeek*(hmc: HWND, iDay: INT): DWORD = discardable DWORD SendMessage(hmc, MCM_SETFIRSTDAYOFWEEK, 0, cast[LPARAM](iDay))
template MonthCal_SetMaxSelCount*(hmc: HWND, n: UINT): BOOL = discardable BOOL SendMessage(hmc, MCM_SETMAXSELCOUNT, cast[WPARAM](n), 0)
template MonthCal_SetMonthDelta*(hmc: HWND, n: INT): INT = discardable INT SendMessage(hmc, MCM_SETMONTHDELTA, cast[WPARAM](n), 0)
template MonthCal_SetRange*(hmc: HWND, gd: DWORD, rgst: LPSYSTEMTIME): BOOL = discardable BOOL SendMessage(hmc, MCM_SETRANGE, cast[WPARAM](gd), cast[LPARAM](rgst))
template MonthCal_SetSelRange*(hmc: HWND, rgst: LPSYSTEMTIME): BOOL = discardable BOOL SendMessage(hmc, MCM_SETSELRANGE, 0, cast[LPARAM](rgst))
template MonthCal_SetToday*(hmc: HWND, pst: LPSYSTEMTIME): void = SendMessage(hmc, MCM_SETTODAY, 0, cast[LPARAM](pst))
template MonthCal_SetUnicodeFormat*(hwnd: HWND, fUnicode: BOOL): BOOL = discardable BOOL SendMessage(hwnd, MCM_SETUNICODEFORMAT, cast[WPARAM](fUnicode), 0)
template MonthCal_SizeRectToMin*(hmc: HWND, prc: RECT): LRESULT = discardable LRESULT SendMessage(hmc, MCM_SIZERECTTOMIN, 0, cast[LPARAM](prc))
template Pager_ForwardMouse*(hwnd: HWND, bForward: BOOL): void = SendMessage(hwnd, PGM_FORWARDMOUSE, cast[WPARAM](bForward), 0)
template Pager_GetBkColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, PGM_GETBKCOLOR, 0, 0)
template Pager_GetBorder*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, PGM_GETBORDER, 0, 0)
template Pager_GetButtonSize*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, PGM_GETBUTTONSIZE, 0, 0)
template Pager_GetButtonState*(hwnd: HWND, iButton: int32): DWORD = discardable DWORD SendMessage(hwnd, PGM_GETBUTTONSTATE, 0, cast[LPARAM](iButton))
template Pager_GetDropTarget*(hwnd: HWND, ppdt: ptr ptr IDropTarget): void = SendMessage(hwnd, PGM_GETDROPTARGET, 0, cast[LPARAM](ppdt))
template Pager_GetPos*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, PGM_GETPOS, 0, 0)
template Pager_RecalcSize*(hwnd: HWND): void = SendMessage(hwnd, PGM_RECALCSIZE, 0, 0)
template Pager_SetBkColor*(hwnd: HWND, clr: COLORREF): COLORREF = discardable COLORREF SendMessage(hwnd, PGM_SETBKCOLOR, 0, cast[LPARAM](clr))
template Pager_SetBorder*(hwnd: HWND, iBorder: int32): INT = discardable INT SendMessage(hwnd, PGM_SETBORDER, 0, cast[LPARAM](iBorder))
template Pager_SetButtonSize*(hwnd: HWND, iSize: int32): int32 = discardable int32 SendMessage(hwnd, PGM_SETBUTTONSIZE, 0, cast[LPARAM](iSize))
template Pager_SetChild*(hwnd: HWND, hwndChild: HWND): void = SendMessage(hwnd, PGM_SETCHILD, 0, cast[LPARAM](hwndChild))
template Pager_SetPos*(hwnd: HWND, iPos: int32): int32 = discardable int32 SendMessage(hwnd, PGM_SETPOS, 0, cast[LPARAM](iPos))
template Pager_SetScrollInfo*(hwnd: HWND, cTimeOut: UINT, cLinesPer: UINT, cPixelsPerLine: UINT): void = SendMessage(hwnd, PGM_SETSCROLLINFO, cast[WPARAM](cTimeOut), cast[LPARAM](MAKELONG(cLinesPer, cPixelsPerLine)))
template PropSheet_AddPage*(hDlg: HWND, hpage: HPROPSHEETPAGE): BOOL = discardable BOOL SendMessage(hDlg, PSM_ADDPAGE, 0, cast[LPARAM](hpage))
template PropSheet_Apply*(hDlg: HWND): BOOL = discardable BOOL SendMessage(hDlg, PSM_APPLY, 0, 0)
template PropSheet_CancelToClose*(hDlg: HWND): void = PostMessage(hDlg, PSM_CANCELTOCLOSE, 0, 0)
template PropSheet_Changed*(hDlg: HWND, hwnd: HWND): BOOL = discardable BOOL SendMessage(hDlg, PSM_CHANGED, cast[WPARAM](hwnd), 0)
template PropSheet_GetCurrentPageHwnd*(hDlg: HWND): HWND = discardable HWND SendMessage(hDlg, PSM_GETCURRENTPAGEHWND, 0, 0)
template PropSheet_GetResult*(hDlg: HWND): int32 = discardable int32 SendMessage(hDlg, PSM_GETRESULT, 0, 0)
template PropSheet_GetTabControl*(hDlg: HWND): HWND = discardable HWND SendMessage(hDlg, PSM_GETTABCONTROL, 0, 0)
template PropSheet_HwndToIndex*(hDlg: HWND, hwnd: HWND): int32 = discardable int32 SendMessage(hDlg, PSM_HWNDTOINDEX, cast[WPARAM](hwnd), 0)
template PropSheet_IdToIndex*(hDlg: HWND, id: int32): int32 = discardable int32 SendMessage(hDlg, PSM_IDTOINDEX, 0, cast[LPARAM](id))
template PropSheet_IndexToHwnd*(hDlg: HWND, i: int32): HWND = discardable HWND SendMessage(hDlg, PSM_INDEXTOHWND, cast[WPARAM](i), 0)
template PropSheet_IndexToId*(hDlg: HWND, i: int32): int32 = discardable int32 SendMessage(hDlg, PSM_INDEXTOID, cast[WPARAM](i), 0)
template PropSheet_IndexToPage*(hDlg: HWND, i: int32): HPROPSHEETPAGE = discardable HPROPSHEETPAGE SendMessage(hDlg, PSM_INDEXTOPAGE, cast[WPARAM](i), 0)
template PropSheet_InsertPage*(hDlg: HWND, index: HWND, hpage: HWND): BOOL = discardable BOOL SendMessage(hDlg, PSM_INSERTPAGE, cast[WPARAM](index), cast[LPARAM](hpage))
template PropSheet_IsDialogMessage*(hDlg: HWND, pMsg: LPMSG): BOOL = discardable BOOL SendMessage(hDlg, PSM_ISDIALOGMESSAGE, 0, cast[LPARAM](pMsg))
template PropSheet_PageToIndex*(hDlg: HWND, hpage: HPROPSHEETPAGE): int32 = discardable int32 SendMessage(hDlg, PSM_PAGETOINDEX, 0, cast[LPARAM](hpage))
template PropSheet_PressButton*(hDlg: HWND, iButton: int32): BOOL = PostMessage(hDlg, PSM_PRESSBUTTON, cast[WPARAM](iButton), 0)
template PropSheet_QuerySiblings*(hDlg: HWND, wParam: WPARAM, lParam: LPARAM): int32 = discardable int32 SendMessage(hDlg, PSM_QUERYSIBLINGS, cast[WPARAM](wParam), cast[LPARAM](lParam))
template PropSheet_RebootSystem*(hDlg: HWND): void = SendMessage(hDlg, PSM_REBOOTSYSTEM, 0, 0)
template PropSheet_RecalcPageSizes*(hDlg: HWND): BOOL = discardable BOOL SendMessage(hDlg, PSM_RECALCPAGESIZES, 0, 0)
template PropSheet_RemovePage*(hDlg: HWND, index: int32, hpage: HPROPSHEETPAGE): void = SendMessage(hDlg, PSM_REMOVEPAGE, cast[WPARAM](index), cast[LPARAM](hpage))
template PropSheet_RestartWindows*(hDlg: HWND): void = SendMessage(hDlg, PSM_RESTARTWINDOWS, 0, 0)
template PropSheet_SetCurSel*(hDlg: HWND, hpage: HPROPSHEETPAGE, index: UINT): BOOL = discardable BOOL SendMessage(hDlg, PSM_SETCURSEL, cast[WPARAM](index), cast[LPARAM](hpage))
template PropSheet_SetCurSelByID*(hDlg: HWND, id: int32): BOOL = discardable BOOL SendMessage(hDlg, PSM_SETCURSELID, 0, cast[LPARAM](id))
when winimUnicode:
  const
    PSM_SETFINISHTEXT* = PSM_SETFINISHTEXTW
when winimAnsi:
  const
    PSM_SETFINISHTEXT* = PSM_SETFINISHTEXTA
template PropSheet_SetFinishText*(hDlg: HWND, lpszText: LPTSTR): void = SendMessage(hDlg, PSM_SETFINISHTEXT, 0, cast[LPARAM](lpszText))
when winimUnicode:
  const
    PSM_SETHEADERSUBTITLE* = PSM_SETHEADERSUBTITLEW
when winimAnsi:
  const
    PSM_SETHEADERSUBTITLE* = PSM_SETHEADERSUBTITLEA
template PropSheet_SetHeaderSubTitle*(hDlg: HWND, index: int32, lpszText: LPCSTR): void = SendMessage(hDlg, PSM_SETHEADERSUBTITLE, cast[WPARAM](index), cast[LPARAM](lpszText))
when winimUnicode:
  const
    PSM_SETHEADERTITLE* = PSM_SETHEADERTITLEW
when winimAnsi:
  const
    PSM_SETHEADERTITLE* = PSM_SETHEADERTITLEA
template PropSheet_SetHeaderTitle*(hDlg: HWND, index: int32, lpszText: LPCTSTR): int32 = discardable int32 SendMessage(hDlg, PSM_SETHEADERTITLE, cast[WPARAM](index), cast[LPARAM](lpszText))
when winimUnicode:
  const
    PSM_SETTITLE* = PSM_SETTITLEW
when winimAnsi:
  const
    PSM_SETTITLE* = PSM_SETTITLEA
template PropSheet_SetTitle*(hDlg: HWND, wStyle: DWORD, lpszText: LPTSTR): void = SendMessage(hDlg, PSM_SETTITLE, cast[WPARAM](wStyle), cast[LPARAM](lpszText))
template PropSheet_SetWizButtons*(hDlg: HWND, dwFlags: DWORD): void = PostMessage(hDlg, PSM_SETWIZBUTTONS, 0, cast[LPARAM](dwFlags))
template PropSheet_SetWizButtons*(hDlg: HWND, iButton: int32): void = PostMessage(hDlg, PSM_PRESSBUTTON, cast[WPARAM](iButton), 0)
template PropSheet_UnChanged*(hDlg: HWND, hwnd: HWND): void = SendMessage(hDlg, PSM_UNCHANGED, cast[WPARAM](hwnd), 0)
template TabCtrl_AdjustRect*(hwnd: HWND, bLarger: BOOL, prc: ptr RECT): void = SendMessage(hwnd, TCM_ADJUSTRECT, cast[WPARAM](bLarger), cast[LPARAM](prc))
template TabCtrl_DeleteAllItems*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, TCM_DELETEALLITEMS, 0, 0)
template TabCtrl_DeleteItem*(hwnd: HWND, i: int32): BOOL = discardable BOOL SendMessage(hwnd, TCM_DELETEITEM, cast[WPARAM](i), 0)
template TabCtrl_DeselectAll*(hwnd: HWND, fExcludeFocus: UINT): void = SendMessage(hwnd, TCM_DESELECTALL, cast[WPARAM](fExcludeFocus), 0)
template TabCtrl_GetCurFocus*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, TCM_GETCURFOCUS, 0, 0)
template TabCtrl_GetCurSel*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, TCM_GETCURSEL, 0, 0)
template TabCtrl_GetExtendedStyle*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, TCM_GETEXTENDEDSTYLE, 0, 0)
template TabCtrl_GetImageList*(hwnd: HWND): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, TCM_GETIMAGELIST, 0, 0)
when winimUnicode:
  type
    LPTCITEM* = LPTCITEMW
when winimAnsi:
  type
    LPTCITEM* = LPTCITEMA
when winimUnicode:
  const
    TCM_GETITEM* = TCM_GETITEMW
when winimAnsi:
  const
    TCM_GETITEM* = TCM_GETITEMA
template TabCtrl_GetItem*(hwnd: HWND, iItem: int32, pitem: LPTCITEM): BOOL = discardable BOOL SendMessage(hwnd, TCM_GETITEM, cast[WPARAM](iItem), cast[LPARAM](pitem))
template TabCtrl_GetItemCount*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, TCM_GETITEMCOUNT, 0, 0)
template TabCtrl_GetItemRect*(hwnd: HWND, i: int32, prc: ptr RECT): BOOL = discardable BOOL SendMessage(hwnd, TCM_GETITEMRECT, cast[WPARAM](i), cast[LPARAM](prc))
template TabCtrl_GetRowCount*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, TCM_GETROWCOUNT, 0, 0)
template TabCtrl_GetToolTips*(hwnd: HWND): HWND = discardable HWND SendMessage(hwnd, TCM_GETTOOLTIPS, 0, 0)
template TabCtrl_GetUnicodeFormat*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, TCM_GETUNICODEFORMAT, 0, 0)
template TabCtrl_HighlightItem*(hwnd: HWND, i: INT, fHighlight: WORD): BOOL = discardable BOOL SendMessage(hwnd, TCM_HIGHLIGHTITEM, cast[WPARAM](i), MAKELONG(fHighlight, 0))
template TabCtrl_HitTest*(hwnd: HWND, pinfo: LPTCHITTESTINFO): int32 = discardable int32 SendMessage(hwnd, TCM_HITTEST, 0, cast[LPARAM](pinfo))
when winimUnicode:
  const
    TCM_INSERTITEM* = TCM_INSERTITEMW
when winimAnsi:
  const
    TCM_INSERTITEM* = TCM_INSERTITEMA
template TabCtrl_InsertItem*(hwnd: HWND, iItem: int32, pitem: LPTCITEM): int32 = discardable int32 SendMessage(hwnd, TCM_INSERTITEM, cast[WPARAM](iItem), cast[LPARAM](pitem))
template TabCtrl_RemoveImage*(hwnd: HWND, i: int32): void = SendMessage(hwnd, TCM_REMOVEIMAGE, cast[WPARAM](i), 0)
template TabCtrl_SetCurFocus*(hwnd: HWND, i: int32): void = SendMessage(hwnd, TCM_SETCURFOCUS, cast[WPARAM](i), 0)
template TabCtrl_SetCurSel*(hwnd: HWND, i: int32): int32 = discardable int32 SendMessage(hwnd, TCM_SETCURSEL, cast[WPARAM](i), 0)
template TabCtrl_SetExtendedStyle*(hwnd: HWND, dw: DWORD): DWORD = discardable DWORD SendMessage(hwnd, TCM_SETEXTENDEDSTYLE, 0, cast[LPARAM](dw))
template TabCtrl_SetImageList*(hwnd: HWND, himl: HIMAGELIST): BOOL = discardable BOOL SendMessage(hwnd, TCM_SETIMAGELIST, 0, cast[LPARAM](himl))
when winimUnicode:
  const
    TCM_SETITEM* = TCM_SETITEMW
when winimAnsi:
  const
    TCM_SETITEM* = TCM_SETITEMA
template TabCtrl_SetItem*(hwnd: HWND, iItem: int32, pitem: LPTCITEM): BOOL = discardable BOOL SendMessage(hwnd, TCM_SETITEM, cast[WPARAM](iItem), cast[LPARAM](pitem))
template TabCtrl_SetItemExtra*(hwndTC: HWND, cb: int32): BOOL = discardable BOOL SendMessage(hwndTC, TCM_SETITEMEXTRA, cast[WPARAM](cb), 0)
template TabCtrl_SetItemSize*(hwnd: HWND, x: int32, y: int32): DWORD = discardable DWORD SendMessage(hwnd, TCM_SETITEMSIZE, 0, MAKELPARAM(x, y))
template TabCtrl_SetMinTabWidth*(hwnd: HWND, x: int32): int32 = discardable int32 SendMessage(hwnd, TCM_SETMINTABWIDTH, 0, cast[LPARAM](x))
template TabCtrl_SetPadding*(hwnd: HWND, cx: int32, cy: int32): void = SendMessage(hwnd, TCM_SETPADDING, 0, MAKELPARAM(cx,cy))
template TabCtrl_SetToolTips*(hwnd: HWND, hwndTT: HWND): void = SendMessage(hwnd, TCM_SETTOOLTIPS, cast[WPARAM](hwndTT), 0)
template TabCtrl_SetUnicodeFormat*(hwnd: HWND, fUnicode: BOOL): BOOL = discardable BOOL SendMessage(hwnd, TCM_SETUNICODEFORMAT, cast[WPARAM](fUnicode), 0)
template TreeView_CreateDragImage*(hwnd: HWND, hitem: HTREEITEM): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, TVM_CREATEDRAGIMAGE, 0, cast[LPARAM](hitem))
template TreeView_DeleteAllItems*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, TVM_DELETEITEM, 0, cast[LPARAM](TVI_ROOT))
template TreeView_DeleteItem*(hwnd: HWND, hitem: HTREEITEM): BOOL = discardable BOOL SendMessage(hwnd, TVM_DELETEITEM, 0, cast[LPARAM](hitem))
when winimUnicode:
  const
    TVM_EDITLABEL* = TVM_EDITLABELW
when winimAnsi:
  const
    TVM_EDITLABEL* = TVM_EDITLABELA
template TreeView_EditLabel*(hwnd: HWND, hitem: HTREEITEM): HWND = discardable HWND SendMessage(hwnd, TVM_EDITLABEL, 0, cast[LPARAM](hitem))
template TreeView_EndEditLabelNow*(hwnd: HWND, fCancel: BOOL): BOOL = discardable BOOL SendMessage(hwnd, TVM_ENDEDITLABELNOW, cast[WPARAM](fCancel), 0)
template TreeView_EnsureVisible*(hwnd: HWND, hitem: HTREEITEM): BOOL = discardable BOOL SendMessage(hwnd, TVM_ENSUREVISIBLE, 0, cast[LPARAM](hitem))
template TreeView_Expand*(hwnd: HWND, hitem: HTREEITEM, code: UINT): BOOL = discardable BOOL SendMessage(hwnd, TVM_EXPAND, cast[WPARAM](code), cast[LPARAM](hitem))
template TreeView_GetBkColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, TVM_GETBKCOLOR, 0, 0)
template TreeView_GetCheckState*(hwnd: HWND, hti: HTREEITEM): UINT = discardable UINT((SendMessage(hwnd, TVM_GETITEMSTATE, cast[WPARAM](hti), TVIS_STATEIMAGEMASK) shr 12) - 1)
template TreeView_GetNextItem*(hwnd: HWND, hitem: HTREEITEM, code: UINT): HTREEITEM = discardable HTREEITEM SendMessage(hwnd, TVM_GETNEXTITEM, cast[WPARAM](code), cast[LPARAM](hitem))
template TreeView_GetChild*(hwnd: HWND, hitem: HTREEITEM): HTREEITEM = TreeView_GetNextItem(hwnd, hitem, TVGN_CHILD)
template TreeView_GetCount*(hwnd: HWND): UINT = discardable UINT SendMessage(hwnd, TVM_GETCOUNT, 0, 0)
template TreeView_GetDropHilight*(hwnd: HWND): HTREEITEM = TreeView_GetNextItem(hwnd, 0, TVGN_DROPHILITE)
template TreeView_GetEditControl*(hwnd: HWND): HWND = discardable HWND SendMessage(hwnd, TVM_GETEDITCONTROL, 0, 0)
template TreeView_GetExtendedStyle*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, TVM_GETEXTENDEDSTYLE, 0, 0)
template TreeView_GetFirstVisible*(hwnd: HWND): HTREEITEM = TreeView_GetNextItem(hwnd, 0, TVGN_FIRSTVISIBLE)
template TreeView_GetImageList*(hwnd: HWND, iImage: INT): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, TVM_GETIMAGELIST, cast[WPARAM](iImage), 0)
template TreeView_GetIndent*(hwnd: HWND): UINT = discardable UINT SendMessage(hwnd, TVM_GETINDENT, 0, 0)
template TreeView_GetInsertMarkColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, TVM_GETINSERTMARKCOLOR, 0, 0)
when winimUnicode:
  const
    TVM_GETISEARCHSTRING* = TVM_GETISEARCHSTRINGW
when winimAnsi:
  const
    TVM_GETISEARCHSTRING* = TVM_GETISEARCHSTRINGA
template TreeView_GetISearchString*(hwndTV: HWND, lpsz: LPTSTR): BOOL = discardable BOOL SendMessage(hwndTV, TVM_GETISEARCHSTRING, 0, cast[LPARAM](lpsz))
when winimUnicode:
  type
    LPTVITEM* = LPTVITEMW
when winimAnsi:
  type
    LPTVITEM* = LPTVITEMA
when winimUnicode:
  const
    TVM_GETITEM* = TVM_GETITEMW
when winimAnsi:
  const
    TVM_GETITEM* = TVM_GETITEMA
template TreeView_GetItem*(hwnd: HWND, pitem: LPTVITEM): BOOL = discardable BOOL SendMessage(hwnd, TVM_GETITEM, 0, cast[LPARAM](pitem))
template TreeView_GetItemHeight*(hwnd: HWND): int32 = discardable int32 SendMessage(hwnd, TVM_GETITEMHEIGHT, 0, 0)
template TreeView_GetItemPartRect*(hwnd: HWND, hitem: HTREEITEM, pRect: ptr RECT, pPartID: TVITEMPART): BOOL = (var info = TVGETITEMPARTRECTINFO(hti: hItem, prc: pRect, partID: pPartID); discardable BOOL SendMessage(hwnd, TVM_GETITEMPARTRECT, 0, cast[LPARAM](addr info)))
template TreeView_GetItemRect*(hwnd: HWND, hitem: HTREEITEM, prc: LPRECT, fItemRect: BOOL): BOOL = (cast[ptr HTREEITEM](prc)[] = hitem; discardable BOOL SendMessage(hwnd, TVM_GETITEMRECT, cast[WPARAM](fItemRect), cast[LPARAM](prc)))
template TreeView_GetItemState*(hwndTV: HWND, hti: HTREEITEM, mask: UINT): UINT = discardable UINT SendMessage(hwndTV, TVM_GETITEMSTATE, cast[WPARAM](hti), cast[LPARAM](mask))
template TreeView_GetLastVisible*(hwnd: HWND): HTREEITEM = TreeView_GetNextItem(hwnd, 0, TVGN_LASTVISIBLE)
template TreeView_GetLineColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, TVM_GETLINECOLOR, 0, 0)
template TreeView_GetNextSelected*(hwnd: HWND,  hitem: HTREEITEM): HTREEITEM = TreeView_GetNextItem (hwnd, hitem, TVGN_NEXTSELECTED)
template TreeView_GetNextSibling*(hwnd: HWND, hitem: HTREEITEM): HTREEITEM = TreeView_GetNextItem(hwnd, hitem, TVGN_NEXT)
template TreeView_GetNextVisible*(hwnd: HWND, hitem: HTREEITEM): HTREEITEM = TreeView_GetNextItem(hwnd, hitem, TVGN_NEXTVISIBLE)
template TreeView_GetParent*(hwnd: HWND, hitem: HTREEITEM): HTREEITEM = TreeView_GetNextItem(hwnd, hitem, TVGN_PARENT)
template TreeView_GetPrevSibling*(hwnd: HWND, hitem: HTREEITEM): HTREEITEM = TreeView_GetNextItem(hwnd, hitem, TVGN_PREVIOUS)
template TreeView_GetPrevVisible*(hwnd: HWND, hitem: HTREEITEM): HTREEITEM = TreeView_GetNextItem(hwnd, hitem, TVGN_PREVIOUSVISIBLE)
template TreeView_GetRoot*(hwnd: HWND): HTREEITEM = TreeView_GetNextItem(hwnd, 0, TVGN_ROOT)
template TreeView_GetScrollTime*(hwnd: HWND): UINT = discardable UINT SendMessage(hwnd, TVM_GETSCROLLTIME, 0, 0)
template TreeView_GetSelectedCount*(hwnd: HWND): DWORD = discardable DWORD SendMessage(hwnd, TVM_GETSELECTEDCOUNT, 0, 0)
template TreeView_GetSelection*(hwnd: HWND): HTREEITEM = TreeView_GetNextItem(hwnd, 0, TVGN_CARET)
template TreeView_GetTextColor*(hwnd: HWND): COLORREF = discardable COLORREF SendMessage(hwnd, TVM_GETTEXTCOLOR, 0, 0)
template TreeView_GetToolTips*(hwnd: HWND): HWND = discardable HWND SendMessage(hwnd, TVM_GETTOOLTIPS, 0, 0)
template TreeView_GetUnicodeFormat*(hwnd: HWND): BOOL = discardable BOOL SendMessage(hwnd, TVM_GETUNICODEFORMAT, 0, 0)
template TreeView_GetVisibleCount*(hwnd: HWND): UINT = discardable UINT SendMessage(hwnd, TVM_GETVISIBLECOUNT, 0, 0)
template TreeView_HitTest*(hwnd: HWND, lpht: LPTVHITTESTINFO): HTREEITEM = discardable HTREEITEM SendMessage(hwnd, TVM_HITTEST, 0, cast[LPARAM](lpht))
when winimUnicode:
  type
    LPTVINSERTSTRUCT* = LPTVINSERTSTRUCTW
when winimAnsi:
  type
    LPTVINSERTSTRUCT* = LPTVINSERTSTRUCTA
when winimUnicode:
  const
    TVM_INSERTITEM* = TVM_INSERTITEMW
when winimAnsi:
  const
    TVM_INSERTITEM* = TVM_INSERTITEMA
template TreeView_InsertItem*(hwnd: HWND, lpis: LPTVINSERTSTRUCT): HTREEITEM = discardable HTREEITEM SendMessage(hwnd, TVM_INSERTITEM, 0, cast[LPARAM](lpis))
template TreeView_MapAccIDToHTREEITEM*(hwnd: HWND, id: UINT): HTREEITEM = discardable HTREEITEM SendMessage(hwnd, TVM_MAPACCIDTOHTREEITEM, cast[WPARAM](id), 0)
template TreeView_MapHTREEITEMToAccID*(hwnd: HWND, htreeitem: HTREEITEM): UINT = discardable UINT SendMessage(hwnd, TVM_MAPHTREEITEMTOACCID, cast[WPARAM](htreeitem), 0)
template TreeView_Select*(hwnd: HWND, hitem: HTREEITEM, code: UINT): BOOL = discardable BOOL SendMessage(hwnd, TVM_SELECTITEM, cast[WPARAM](code), cast[LPARAM](hitem))
template TreeView_SelectDropTarget*(hwnd: HWND, hitem: HTREEITEM): BOOL = TreeView_Select(hwnd, hitem, TVGN_DROPHILITE)
template TreeView_SelectItem*(hwnd: HWND, hitem: HTREEITEM): BOOL = TreeView_Select(hwnd, hitem, TVGN_CARET)
template TreeView_SelectSetFirstVisible*(hwnd: HWND, hitem: HTREEITEM): BOOL = TreeView_Select(hwnd, hitem, TVGN_FIRSTVISIBLE)
template TreeView_SetAutoScrollInfo*(hwnd: HWND, uPixPerSec: UINT, uUpdateTime: UINT): LRESULT = discardable LRESULT SendMessage(hwnd, TVM_SETAUTOSCROLLINFO, cast[WPARAM](uPixPerSec), cast[LPARAM](uUpdateTime))
template TreeView_SetBkColor*(hwnd: HWND, clr: COLORREF): COLORREF = discardable COLORREF SendMessage(hwnd, TVM_SETBKCOLOR, 0, cast[LPARAM](clr))
template TreeView_SetBorder*(hwnd: HWND, dwFlags: DWORD, xBorder: SHORT, yBorder: SHORT): int32 = discardable int32 SendMessage(hwnd, TVM_SETBORDER, cast[WPARAM](dwFlags), MAKELPARAM(xBorder, yBorder))
when winimUnicode:
  type
    TVITEM* = TVITEMW
when winimAnsi:
  type
    TVITEM* = TVITEMA
when winimUnicode:
  const
    TVM_SETITEM* = TVM_SETITEMW
when winimAnsi:
  const
    TVM_SETITEM* = TVM_SETITEMA
template TreeView_SetItemState*(hwnd: HWND, hti: HTREEITEM, data: UINT, m: UINT): UINT = (var tvi = TVITEM(mask: TVIF_STATE, hItem: hti, stateMask: m, state: data); discardable UINT SendMessage(hwnd, TVM_SETITEM, 0, cast[LPARAM](addr tvi)))
template TreeView_SetCheckState*(hwnd: HWND, hti: HTREEITEM, fCheck: BOOL): UINT = TreeView_SetItemState(hwnd, hti, INDEXTOSTATEIMAGEMASK(if bool fCheck:2 else:1), TVIS_STATEIMAGEMASK)
template TreeView_SetExtendedStyle*(hwnd: HWND, dw: DWORD, mask: UINT): HRESULT = discardable HRESULT SendMessage(hwnd, TVM_SETEXTENDEDSTYLE, cast[WPARAM](mask), cast[LPARAM](dw))
template TreeView_SetHot*(hwnd: HWND, hitem: HTREEITEM): LRESULT = discardable LRESULT SendMessage(hwnd, TVM_SETHOT, 0, cast[LPARAM](hitem))
template TreeView_SetImageList*(hwnd: HWND, himl: HIMAGELIST, iImage: INT): HIMAGELIST = discardable HIMAGELIST SendMessage(hwnd, TVM_SETIMAGELIST, cast[WPARAM](iImage), cast[LPARAM](himl))
template TreeView_SetIndent*(hwnd: HWND, indent: INT): BOOL = discardable BOOL SendMessage(hwnd, TVM_SETINDENT, cast[WPARAM](indent), 0)
template TreeView_SetInsertMark*(hwnd: HWND, hItem: HTREEITEM, fAfter: BOOL): BOOL = discardable BOOL SendMessage(hwnd, TVM_SETINSERTMARK, cast[WPARAM](fAfter), cast[LPARAM](hItem))
template TreeView_SetInsertMarkColor*(hwnd: HWND, clr: COLORREF): COLORREF = discardable COLORREF SendMessage(hwnd, TVM_SETINSERTMARKCOLOR, 0, cast[LPARAM](clr))
template TreeView_SetItem*(hwnd: HWND, pitem: LPTVITEM): BOOL = discardable BOOL SendMessage(hwnd, TVM_SETITEM, 0, cast[LPARAM](pitem))
template TreeView_SetItemHeight*(hwnd: HWND, iHeight: SHORT): int32 = discardable int32 SendMessage(hwnd, TVM_SETITEMHEIGHT, cast[WPARAM](iHeight), 0)
template TreeView_SetLineColor*(hwnd: HWND, clr: COLORREF): COLORREF = discardable COLORREF SendMessage(hwnd, TVM_SETLINECOLOR, 0, cast[LPARAM](clr))
template TreeView_SetScrollTime*(hwnd: HWND, uTime: UINT): UINT = discardable UINT SendMessage(hwnd, TVM_SETSCROLLTIME, cast[WPARAM](uTime), 0)
template TreeView_SetTextColor*(hwnd: HWND, clr: COLORREF): COLORREF = discardable COLORREF SendMessage(hwnd, TVM_SETTEXTCOLOR, 0, cast[LPARAM](clr))
template TreeView_SetToolTips*(hwnd: HWND, hwndTT: HWND): HWND = discardable HWND SendMessage(hwnd, TVM_SETTOOLTIPS, cast[WPARAM](hwndTT), 0)
template TreeView_SetUnicodeFormat*(hwnd: HWND, fUnicode: BOOL): BOOL = discardable BOOL SendMessage(hwnd, TVM_SETUNICODEFORMAT, cast[WPARAM](fUnicode), 0)
template TreeView_ShowInfoTip*(hwnd: HWND, hitem: HTREEITEM): DWORD = discardable DWORD SendMessage(hwnd, TVM_SHOWINFOTIP, 0, cast[LPARAM](hitem))
template TreeView_SortChildren*(hwnd: HWND, hitem: HTREEITEM, recurse: BOOL): BOOL = discardable BOOL SendMessage(hwnd, TVM_SORTCHILDREN, cast[WPARAM](recurse), cast[LPARAM](hitem))
template TreeView_SortChildrenCB*(hwnd: HWND, psort: LPTVSORTCB, recurse: BOOL): BOOL = discardable BOOL SendMessage(hwnd, TVM_SORTCHILDRENCB, cast[WPARAM](recurse), cast[LPARAM](psort))
proc `pszTemplate=`*(self: var PROPSHEETPAGEA, x: LPCSTR) {.inline.} = self.union1.pszTemplate = x
proc pszTemplate*(self: PROPSHEETPAGEA): LPCSTR {.inline.} = self.union1.pszTemplate
proc pszTemplate*(self: var PROPSHEETPAGEA): var LPCSTR {.inline.} = self.union1.pszTemplate
proc `pResource=`*(self: var PROPSHEETPAGEA, x: LPCDLGTEMPLATE) {.inline.} = self.union1.pResource = x
proc pResource*(self: PROPSHEETPAGEA): LPCDLGTEMPLATE {.inline.} = self.union1.pResource
proc pResource*(self: var PROPSHEETPAGEA): var LPCDLGTEMPLATE {.inline.} = self.union1.pResource
proc `hIcon=`*(self: var PROPSHEETPAGEA, x: HICON) {.inline.} = self.union2.hIcon = x
proc hIcon*(self: PROPSHEETPAGEA): HICON {.inline.} = self.union2.hIcon
proc hIcon*(self: var PROPSHEETPAGEA): var HICON {.inline.} = self.union2.hIcon
proc `pszIcon=`*(self: var PROPSHEETPAGEA, x: LPCSTR) {.inline.} = self.union2.pszIcon = x
proc pszIcon*(self: PROPSHEETPAGEA): LPCSTR {.inline.} = self.union2.pszIcon
proc pszIcon*(self: var PROPSHEETPAGEA): var LPCSTR {.inline.} = self.union2.pszIcon
proc `pszTemplate=`*(self: var PROPSHEETPAGEW, x: LPCWSTR) {.inline.} = self.union1.pszTemplate = x
proc pszTemplate*(self: PROPSHEETPAGEW): LPCWSTR {.inline.} = self.union1.pszTemplate
proc pszTemplate*(self: var PROPSHEETPAGEW): var LPCWSTR {.inline.} = self.union1.pszTemplate
proc `pResource=`*(self: var PROPSHEETPAGEW, x: LPCDLGTEMPLATE) {.inline.} = self.union1.pResource = x
proc pResource*(self: PROPSHEETPAGEW): LPCDLGTEMPLATE {.inline.} = self.union1.pResource
proc pResource*(self: var PROPSHEETPAGEW): var LPCDLGTEMPLATE {.inline.} = self.union1.pResource
proc `hIcon=`*(self: var PROPSHEETPAGEW, x: HICON) {.inline.} = self.union2.hIcon = x
proc hIcon*(self: PROPSHEETPAGEW): HICON {.inline.} = self.union2.hIcon
proc hIcon*(self: var PROPSHEETPAGEW): var HICON {.inline.} = self.union2.hIcon
proc `pszIcon=`*(self: var PROPSHEETPAGEW, x: LPCWSTR) {.inline.} = self.union2.pszIcon = x
proc pszIcon*(self: PROPSHEETPAGEW): LPCWSTR {.inline.} = self.union2.pszIcon
proc pszIcon*(self: var PROPSHEETPAGEW): var LPCWSTR {.inline.} = self.union2.pszIcon
proc `hIcon=`*(self: var PROPSHEETHEADERA, x: HICON) {.inline.} = self.union1.hIcon = x
proc hIcon*(self: PROPSHEETHEADERA): HICON {.inline.} = self.union1.hIcon
proc hIcon*(self: var PROPSHEETHEADERA): var HICON {.inline.} = self.union1.hIcon
proc `pszIcon=`*(self: var PROPSHEETHEADERA, x: LPCSTR) {.inline.} = self.union1.pszIcon = x
proc pszIcon*(self: PROPSHEETHEADERA): LPCSTR {.inline.} = self.union1.pszIcon
proc pszIcon*(self: var PROPSHEETHEADERA): var LPCSTR {.inline.} = self.union1.pszIcon
proc `nStartPage=`*(self: var PROPSHEETHEADERA, x: UINT) {.inline.} = self.union2.nStartPage = x
proc nStartPage*(self: PROPSHEETHEADERA): UINT {.inline.} = self.union2.nStartPage
proc nStartPage*(self: var PROPSHEETHEADERA): var UINT {.inline.} = self.union2.nStartPage
proc `pStartPage=`*(self: var PROPSHEETHEADERA, x: LPCSTR) {.inline.} = self.union2.pStartPage = x
proc pStartPage*(self: PROPSHEETHEADERA): LPCSTR {.inline.} = self.union2.pStartPage
proc pStartPage*(self: var PROPSHEETHEADERA): var LPCSTR {.inline.} = self.union2.pStartPage
proc `ppsp=`*(self: var PROPSHEETHEADERA, x: LPCPROPSHEETPAGEA) {.inline.} = self.union3.ppsp = x
proc ppsp*(self: PROPSHEETHEADERA): LPCPROPSHEETPAGEA {.inline.} = self.union3.ppsp
proc ppsp*(self: var PROPSHEETHEADERA): var LPCPROPSHEETPAGEA {.inline.} = self.union3.ppsp
proc `phpage=`*(self: var PROPSHEETHEADERA, x: ptr HPROPSHEETPAGE) {.inline.} = self.union3.phpage = x
proc phpage*(self: PROPSHEETHEADERA): ptr HPROPSHEETPAGE {.inline.} = self.union3.phpage
proc phpage*(self: var PROPSHEETHEADERA): var ptr HPROPSHEETPAGE {.inline.} = self.union3.phpage
proc `hbmWatermark=`*(self: var PROPSHEETHEADERA, x: HBITMAP) {.inline.} = self.union4.hbmWatermark = x
proc hbmWatermark*(self: PROPSHEETHEADERA): HBITMAP {.inline.} = self.union4.hbmWatermark
proc hbmWatermark*(self: var PROPSHEETHEADERA): var HBITMAP {.inline.} = self.union4.hbmWatermark
proc `pszbmWatermark=`*(self: var PROPSHEETHEADERA, x: LPCSTR) {.inline.} = self.union4.pszbmWatermark = x
proc pszbmWatermark*(self: PROPSHEETHEADERA): LPCSTR {.inline.} = self.union4.pszbmWatermark
proc pszbmWatermark*(self: var PROPSHEETHEADERA): var LPCSTR {.inline.} = self.union4.pszbmWatermark
proc `hbmHeader=`*(self: var PROPSHEETHEADERA, x: HBITMAP) {.inline.} = self.union5.hbmHeader = x
proc hbmHeader*(self: PROPSHEETHEADERA): HBITMAP {.inline.} = self.union5.hbmHeader
proc hbmHeader*(self: var PROPSHEETHEADERA): var HBITMAP {.inline.} = self.union5.hbmHeader
proc `pszbmHeader=`*(self: var PROPSHEETHEADERA, x: LPCSTR) {.inline.} = self.union5.pszbmHeader = x
proc pszbmHeader*(self: PROPSHEETHEADERA): LPCSTR {.inline.} = self.union5.pszbmHeader
proc pszbmHeader*(self: var PROPSHEETHEADERA): var LPCSTR {.inline.} = self.union5.pszbmHeader
proc `hIcon=`*(self: var PROPSHEETHEADERW, x: HICON) {.inline.} = self.union1.hIcon = x
proc hIcon*(self: PROPSHEETHEADERW): HICON {.inline.} = self.union1.hIcon
proc hIcon*(self: var PROPSHEETHEADERW): var HICON {.inline.} = self.union1.hIcon
proc `pszIcon=`*(self: var PROPSHEETHEADERW, x: LPCWSTR) {.inline.} = self.union1.pszIcon = x
proc pszIcon*(self: PROPSHEETHEADERW): LPCWSTR {.inline.} = self.union1.pszIcon
proc pszIcon*(self: var PROPSHEETHEADERW): var LPCWSTR {.inline.} = self.union1.pszIcon
proc `nStartPage=`*(self: var PROPSHEETHEADERW, x: UINT) {.inline.} = self.union2.nStartPage = x
proc nStartPage*(self: PROPSHEETHEADERW): UINT {.inline.} = self.union2.nStartPage
proc nStartPage*(self: var PROPSHEETHEADERW): var UINT {.inline.} = self.union2.nStartPage
proc `pStartPage=`*(self: var PROPSHEETHEADERW, x: LPCWSTR) {.inline.} = self.union2.pStartPage = x
proc pStartPage*(self: PROPSHEETHEADERW): LPCWSTR {.inline.} = self.union2.pStartPage
proc pStartPage*(self: var PROPSHEETHEADERW): var LPCWSTR {.inline.} = self.union2.pStartPage
proc `ppsp=`*(self: var PROPSHEETHEADERW, x: LPCPROPSHEETPAGEW) {.inline.} = self.union3.ppsp = x
proc ppsp*(self: PROPSHEETHEADERW): LPCPROPSHEETPAGEW {.inline.} = self.union3.ppsp
proc ppsp*(self: var PROPSHEETHEADERW): var LPCPROPSHEETPAGEW {.inline.} = self.union3.ppsp
proc `phpage=`*(self: var PROPSHEETHEADERW, x: ptr HPROPSHEETPAGE) {.inline.} = self.union3.phpage = x
proc phpage*(self: PROPSHEETHEADERW): ptr HPROPSHEETPAGE {.inline.} = self.union3.phpage
proc phpage*(self: var PROPSHEETHEADERW): var ptr HPROPSHEETPAGE {.inline.} = self.union3.phpage
proc `hbmWatermark=`*(self: var PROPSHEETHEADERW, x: HBITMAP) {.inline.} = self.union4.hbmWatermark = x
proc hbmWatermark*(self: PROPSHEETHEADERW): HBITMAP {.inline.} = self.union4.hbmWatermark
proc hbmWatermark*(self: var PROPSHEETHEADERW): var HBITMAP {.inline.} = self.union4.hbmWatermark
proc `pszbmWatermark=`*(self: var PROPSHEETHEADERW, x: LPCWSTR) {.inline.} = self.union4.pszbmWatermark = x
proc pszbmWatermark*(self: PROPSHEETHEADERW): LPCWSTR {.inline.} = self.union4.pszbmWatermark
proc pszbmWatermark*(self: var PROPSHEETHEADERW): var LPCWSTR {.inline.} = self.union4.pszbmWatermark
proc `hbmHeader=`*(self: var PROPSHEETHEADERW, x: HBITMAP) {.inline.} = self.union5.hbmHeader = x
proc hbmHeader*(self: PROPSHEETHEADERW): HBITMAP {.inline.} = self.union5.hbmHeader
proc hbmHeader*(self: var PROPSHEETHEADERW): var HBITMAP {.inline.} = self.union5.hbmHeader
proc `pszbmHeader=`*(self: var PROPSHEETHEADERW, x: LPCWSTR) {.inline.} = self.union5.pszbmHeader = x
proc pszbmHeader*(self: PROPSHEETHEADERW): LPCWSTR {.inline.} = self.union5.pszbmHeader
proc pszbmHeader*(self: var PROPSHEETHEADERW): var LPCWSTR {.inline.} = self.union5.pszbmHeader
proc `itemex=`*(self: var TVINSERTSTRUCTA, x: TVITEMEXA) {.inline.} = self.union1.itemex = x
proc itemex*(self: TVINSERTSTRUCTA): TVITEMEXA {.inline.} = self.union1.itemex
proc itemex*(self: var TVINSERTSTRUCTA): var TVITEMEXA {.inline.} = self.union1.itemex
proc `item=`*(self: var TVINSERTSTRUCTA, x: TV_ITEMA) {.inline.} = self.union1.item = x
proc item*(self: TVINSERTSTRUCTA): TV_ITEMA {.inline.} = self.union1.item
proc item*(self: var TVINSERTSTRUCTA): var TV_ITEMA {.inline.} = self.union1.item
proc `itemex=`*(self: var TVINSERTSTRUCTW, x: TVITEMEXW) {.inline.} = self.union1.itemex = x
proc itemex*(self: TVINSERTSTRUCTW): TVITEMEXW {.inline.} = self.union1.itemex
proc itemex*(self: var TVINSERTSTRUCTW): var TVITEMEXW {.inline.} = self.union1.itemex
proc `item=`*(self: var TVINSERTSTRUCTW, x: TV_ITEMW) {.inline.} = self.union1.item = x
proc item*(self: TVINSERTSTRUCTW): TV_ITEMW {.inline.} = self.union1.item
proc item*(self: var TVINSERTSTRUCTW): var TV_ITEMW {.inline.} = self.union1.item
proc `hMainIcon=`*(self: var TASKDIALOGCONFIG, x: HICON) {.inline.} = self.union1.hMainIcon = x
proc hMainIcon*(self: TASKDIALOGCONFIG): HICON {.inline.} = self.union1.hMainIcon
proc hMainIcon*(self: var TASKDIALOGCONFIG): var HICON {.inline.} = self.union1.hMainIcon
proc `pszMainIcon=`*(self: var TASKDIALOGCONFIG, x: PCWSTR) {.inline.} = self.union1.pszMainIcon = x
proc pszMainIcon*(self: TASKDIALOGCONFIG): PCWSTR {.inline.} = self.union1.pszMainIcon
proc pszMainIcon*(self: var TASKDIALOGCONFIG): var PCWSTR {.inline.} = self.union1.pszMainIcon
proc `hFooterIcon=`*(self: var TASKDIALOGCONFIG, x: HICON) {.inline.} = self.union2.hFooterIcon = x
proc hFooterIcon*(self: TASKDIALOGCONFIG): HICON {.inline.} = self.union2.hFooterIcon
proc hFooterIcon*(self: var TASKDIALOGCONFIG): var HICON {.inline.} = self.union2.hFooterIcon
proc `pszFooterIcon=`*(self: var TASKDIALOGCONFIG, x: PCWSTR) {.inline.} = self.union2.pszFooterIcon = x
proc pszFooterIcon*(self: TASKDIALOGCONFIG): PCWSTR {.inline.} = self.union2.pszFooterIcon
proc pszFooterIcon*(self: var TASKDIALOGCONFIG): var PCWSTR {.inline.} = self.union2.pszFooterIcon
proc Add*(self: ptr IImageList, hbmImage: HBITMAP, hbmMask: HBITMAP, pi: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Add(self, hbmImage, hbmMask, pi)
proc ReplaceIcon*(self: ptr IImageList, i: int32, hicon: HICON, pi: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReplaceIcon(self, i, hicon, pi)
proc SetOverlayImage*(self: ptr IImageList, iImage: int32, iOverlay: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOverlayImage(self, iImage, iOverlay)
proc Replace*(self: ptr IImageList, i: int32, hbmImage: HBITMAP, hbmMask: HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Replace(self, i, hbmImage, hbmMask)
proc AddMasked*(self: ptr IImageList, hbmImage: HBITMAP, crMask: COLORREF, pi: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddMasked(self, hbmImage, crMask, pi)
proc Draw*(self: ptr IImageList, pimldp: ptr IMAGELISTDRAWPARAMS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Draw(self, pimldp)
proc Remove*(self: ptr IImageList, i: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Remove(self, i)
proc GetIcon*(self: ptr IImageList, i: int32, flags: UINT, picon: ptr HICON): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIcon(self, i, flags, picon)
proc GetImageInfo*(self: ptr IImageList, i: int32, pImageInfo: ptr IMAGEINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImageInfo(self, i, pImageInfo)
proc Copy*(self: ptr IImageList, iDst: int32, punkSrc: ptr IUnknown, iSrc: int32, uFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Copy(self, iDst, punkSrc, iSrc, uFlags)
proc Merge*(self: ptr IImageList, i1: int32, punk2: ptr IUnknown, i2: int32, dx: int32, dy: int32, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Merge(self, i1, punk2, i2, dx, dy, riid, ppv)
proc Clone*(self: ptr IImageList, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, riid, ppv)
proc GetImageRect*(self: ptr IImageList, i: int32, prc: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImageRect(self, i, prc)
proc GetIconSize*(self: ptr IImageList, cx: ptr int32, cy: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconSize(self, cx, cy)
proc SetIconSize*(self: ptr IImageList, cx: int32, cy: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIconSize(self, cx, cy)
proc GetImageCount*(self: ptr IImageList, pi: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImageCount(self, pi)
proc SetImageCount*(self: ptr IImageList, uNewCount: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetImageCount(self, uNewCount)
proc SetBkColor*(self: ptr IImageList, clrBk: COLORREF, pclr: ptr COLORREF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBkColor(self, clrBk, pclr)
proc GetBkColor*(self: ptr IImageList, pclr: ptr COLORREF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBkColor(self, pclr)
proc BeginDrag*(self: ptr IImageList, iTrack: int32, dxHotspot: int32, dyHotspot: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginDrag(self, iTrack, dxHotspot, dyHotspot)
proc EndDrag*(self: ptr IImageList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndDrag(self)
proc DragEnter*(self: ptr IImageList, hwndLock: HWND, x: int32, y: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragEnter(self, hwndLock, x, y)
proc DragLeave*(self: ptr IImageList, hwndLock: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragLeave(self, hwndLock)
proc DragMove*(self: ptr IImageList, x: int32, y: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragMove(self, x, y)
proc SetDragCursorImage*(self: ptr IImageList, punk: ptr IUnknown, iDrag: int32, dxHotspot: int32, dyHotspot: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDragCursorImage(self, punk, iDrag, dxHotspot, dyHotspot)
proc DragShowNolock*(self: ptr IImageList, fShow: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragShowNolock(self, fShow)
proc GetDragImage*(self: ptr IImageList, ppt: ptr POINT, pptHotspot: ptr POINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDragImage(self, ppt, pptHotspot, riid, ppv)
proc GetItemFlags*(self: ptr IImageList, i: int32, dwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemFlags(self, i, dwFlags)
proc GetOverlayImage*(self: ptr IImageList, iOverlay: int32, piIndex: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOverlayImage(self, iOverlay, piIndex)
proc Resize*(self: ptr IImageList2, cxNewIconSize: int32, cyNewIconSize: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resize(self, cxNewIconSize, cyNewIconSize)
proc GetOriginalSize*(self: ptr IImageList2, iImage: int32, dwFlags: DWORD, pcx: ptr int32, pcy: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOriginalSize(self, iImage, dwFlags, pcx, pcy)
proc SetOriginalSize*(self: ptr IImageList2, iImage: int32, cx: int32, cy: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOriginalSize(self, iImage, cx, cy)
proc SetCallback*(self: ptr IImageList2, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCallback(self, punk)
proc GetCallback*(self: ptr IImageList2, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCallback(self, riid, ppv)
proc ForceImagePresent*(self: ptr IImageList2, iImage: int32, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ForceImagePresent(self, iImage, dwFlags)
proc DiscardImages*(self: ptr IImageList2, iFirstImage: int32, iLastImage: int32, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DiscardImages(self, iFirstImage, iLastImage, dwFlags)
proc PreloadImages*(self: ptr IImageList2, pimldp: ptr IMAGELISTDRAWPARAMS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreloadImages(self, pimldp)
proc GetStatistics*(self: ptr IImageList2, pils: ptr IMAGELISTSTATS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStatistics(self, pils)
proc Initialize*(self: ptr IImageList2, cx: int32, cy: int32, flags: UINT, cInitial: int32, cGrow: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, cx, cy, flags, cInitial, cGrow)
proc Replace2*(self: ptr IImageList2, i: int32, hbmImage: HBITMAP, hbmMask: HBITMAP, punk: ptr IUnknown, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Replace2(self, i, hbmImage, hbmMask, punk, dwFlags)
proc ReplaceFromImageList*(self: ptr IImageList2, i: int32, pil: ptr IImageList, iSrc: int32, punk: ptr IUnknown, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReplaceFromImageList(self, i, pil, iSrc, punk, dwFlags)
converter winimConverterIImageListToIUnknown*(x: ptr IImageList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIImageList2ToIImageList*(x: ptr IImageList2): ptr IImageList = cast[ptr IImageList](x)
converter winimConverterIImageList2ToIUnknown*(x: ptr IImageList2): ptr IUnknown = cast[ptr IUnknown](x)
when winimUnicode:
  type
    LPNMLVDISPINFO* = LPNMLVDISPINFOW
    LPFNPSPCALLBACK* = LPFNPSPCALLBACKW
    PROPSHEETPAGE* = PROPSHEETPAGEW
    LPPROPSHEETPAGE* = LPPROPSHEETPAGEW
    LPCPROPSHEETPAGE* = LPCPROPSHEETPAGEW
    PROPSHEETHEADER* = PROPSHEETHEADERW
    LPPROPSHEETHEADER* = LPPROPSHEETHEADERW
    LPCPROPSHEETHEADER* = LPCPROPSHEETHEADERW
    HD_TEXTFILTER* = HD_TEXTFILTERW
    LPHD_TEXTFILTER* = LPHD_TEXTFILTERW
    HDITEM* = HDITEMW
    LPNMHEADER* = LPNMHEADERW
    NMHDDISPINFO* = NMHDDISPINFOW
    LPNMHDDISPINFO* = LPNMHDDISPINFOW
    TBSAVEPARAMS* = TBSAVEPARAMSW
    TBBUTTONINFO* = TBBUTTONINFOW
    LPTBBUTTONINFO* = LPTBBUTTONINFOW
    NMTBGETINFOTIP* = NMTBGETINFOTIPW
    LPNMTBGETINFOTIP* = LPNMTBGETINFOTIPW
    NMTBDISPINFO* = NMTBDISPINFOW
    LPNMTBDISPINFO* = LPNMTBDISPINFOW
    REBARBANDINFO* = REBARBANDINFOW
    LPREBARBANDINFO* = LPREBARBANDINFOW
    LPCREBARBANDINFO* = LPCREBARBANDINFOW
    PTOOLINFO* = PTOOLINFOW
    TTHITTESTINFO* = TTHITTESTINFOW
    LVITEM* = LVITEMW
    LVCOLUMN* = LVCOLUMNW
    LVBKIMAGE* = LVBKIMAGEW
    PNM_FINDITEM* = PNM_FINDITEMW
    LPNM_FINDITEM* = LPNM_FINDITEMW
    NM_FINDITEM* = NM_FINDITEMW
    NMLVFINDITEM* = NMLVFINDITEMW
    LPNMLVFINDITEM* = LPNMLVFINDITEMW
    NMLVGETINFOTIP* = NMLVGETINFOTIPW
    LPNMLVGETINFOTIP* = LPNMLVGETINFOTIPW
    TVITEMEX* = TVITEMEXW
    LPTVITEMEX* = LPTVITEMEXW
    TVINSERTSTRUCT* = TVINSERTSTRUCTW
    NMTREEVIEW* = NMTREEVIEWW
    LPNMTREEVIEW* = LPNMTREEVIEWW
    LPNMTVDISPINFO* = LPNMTVDISPINFOW
    LPNMTVDISPINFOEX* = LPNMTVDISPINFOEXW
    NMTVGETINFOTIP* = NMTVGETINFOTIPW
    LPNMTVGETINFOTIP* = LPNMTVGETINFOTIPW
    COMBOBOXEXITEM* = COMBOBOXEXITEMW
    PCOMBOBOXEXITEM* = PCOMBOBOXEXITEMW
    NMCOMBOBOXEX* = NMCOMBOBOXEXW
    PNMCOMBOBOXEX* = PNMCOMBOBOXEXW
    NMCBEDRAGBEGIN* = NMCBEDRAGBEGINW
    LPNMCBEDRAGBEGIN* = LPNMCBEDRAGBEGINW
    PNMCBEDRAGBEGIN* = PNMCBEDRAGBEGINW
    NMCBEENDEDIT* = NMCBEENDEDITW
    LPNMCBEENDEDIT* = LPNMCBEENDEDITW
    PNMCBEENDEDIT* = PNMCBEENDEDITW
    TCITEMHEADER* = TCITEMHEADERW
    LPTCITEMHEADER* = LPTCITEMHEADERW
    TCITEM* = TCITEMW
    NMDATETIMESTRING* = NMDATETIMESTRINGW
    LPNMDATETIMESTRING* = LPNMDATETIMESTRINGW
    NMDATETIMEWMKEYDOWN* = NMDATETIMEWMKEYDOWNW
    LPNMDATETIMEWMKEYDOWN* = LPNMDATETIMEWMKEYDOWNW
    NMDATETIMEFORMAT* = NMDATETIMEFORMATW
    LPNMDATETIMEFORMAT* = LPNMDATETIMEFORMATW
    NMDATETIMEFORMATQUERY* = NMDATETIMEFORMATQUERYW
    LPNMDATETIMEFORMATQUERY* = LPNMDATETIMEFORMATQUERYW
  const
    WC_HEADER* = WC_HEADERW
    HDN_ITEMCHANGING* = HDN_ITEMCHANGINGW
    HDN_ITEMCHANGED* = HDN_ITEMCHANGEDW
    HDN_ITEMCLICK* = HDN_ITEMCLICKW
    HDN_ITEMDBLCLICK* = HDN_ITEMDBLCLICKW
    HDN_DIVIDERDBLCLICK* = HDN_DIVIDERDBLCLICKW
    HDN_BEGINTRACK* = HDN_BEGINTRACKW
    HDN_ENDTRACK* = HDN_ENDTRACKW
    HDN_TRACK* = HDN_TRACKW
    HDN_GETDISPINFO* = HDN_GETDISPINFOW
    TOOLBARCLASSNAME* = TOOLBARCLASSNAMEW
    TB_GETBUTTONTEXT* = TB_GETBUTTONTEXTW
    TB_SAVERESTORE* = TB_SAVERESTOREW
    TB_ADDSTRING* = TB_ADDSTRINGW
    TB_MAPACCELERATOR* = TB_MAPACCELERATORW
    TB_GETBUTTONINFO* = TB_GETBUTTONINFOW
    TB_SETBUTTONINFO* = TB_SETBUTTONINFOW
    TB_INSERTBUTTON* = TB_INSERTBUTTONW
    TB_ADDBUTTONS* = TB_ADDBUTTONSW
    TB_GETSTRING* = TB_GETSTRINGW
    TBN_GETINFOTIP* = TBN_GETINFOTIPW
    TBN_GETDISPINFO* = TBN_GETDISPINFOW
    TBN_GETBUTTONINFO* = TBN_GETBUTTONINFOW
    REBARCLASSNAME* = REBARCLASSNAMEW
    RB_INSERTBAND* = RB_INSERTBANDW
    RB_SETBANDINFO* = RB_SETBANDINFOW
    RB_GETBANDINFO* = RB_GETBANDINFOW
    TOOLTIPS_CLASS* = TOOLTIPS_CLASSW
    TTM_ADDTOOL* = TTM_ADDTOOLW
    TTM_DELTOOL* = TTM_DELTOOLW
    TTM_NEWTOOLRECT* = TTM_NEWTOOLRECTW
    TTM_GETTOOLINFO* = TTM_GETTOOLINFOW
    TTM_SETTOOLINFO* = TTM_SETTOOLINFOW
    TTM_HITTEST* = TTM_HITTESTW
    TTM_GETTEXT* = TTM_GETTEXTW
    TTM_UPDATETIPTEXT* = TTM_UPDATETIPTEXTW
    TTM_ENUMTOOLS* = TTM_ENUMTOOLSW
    TTM_GETCURRENTTOOL* = TTM_GETCURRENTTOOLW
    TTM_SETTITLE* = TTM_SETTITLEW
    STATUSCLASSNAME* = STATUSCLASSNAMEW
    SB_GETTEXT* = SB_GETTEXTW
    SB_SETTEXT* = SB_SETTEXTW
    SB_GETTEXTLENGTH* = SB_GETTEXTLENGTHW
    SB_SETTIPTEXT* = SB_SETTIPTEXTW
    SB_GETTIPTEXT* = SB_GETTIPTEXTW
    TRACKBAR_CLASS* = TRACKBAR_CLASSW
    UPDOWN_CLASS* = UPDOWN_CLASSW
    PROGRESS_CLASS* = PROGRESS_CLASSW
    HOTKEY_CLASS* = HOTKEY_CLASSW
    WC_LISTVIEW* = WC_LISTVIEWW
    LPSTR_TEXTCALLBACK* = LPSTR_TEXTCALLBACKW
    LVN_ODFINDITEM* = LVN_ODFINDITEMW
    LVN_BEGINLABELEDIT* = LVN_BEGINLABELEDITW
    LVN_ENDLABELEDIT* = LVN_ENDLABELEDITW
    LVN_GETDISPINFO* = LVN_GETDISPINFOW
    LVN_SETDISPINFO* = LVN_SETDISPINFOW
    LVN_GETINFOTIP* = LVN_GETINFOTIPW
    LVN_INCREMENTALSEARCH* = LVN_INCREMENTALSEARCHW
    WC_TREEVIEW* = WC_TREEVIEWW
    TVN_SELCHANGING* = TVN_SELCHANGINGW
    TVN_SELCHANGED* = TVN_SELCHANGEDW
    TVN_GETDISPINFO* = TVN_GETDISPINFOW
    TVN_SETDISPINFO* = TVN_SETDISPINFOW
    TVN_ITEMEXPANDING* = TVN_ITEMEXPANDINGW
    TVN_ITEMEXPANDED* = TVN_ITEMEXPANDEDW
    TVN_BEGINDRAG* = TVN_BEGINDRAGW
    TVN_BEGINRDRAG* = TVN_BEGINRDRAGW
    TVN_DELETEITEM* = TVN_DELETEITEMW
    TVN_BEGINLABELEDIT* = TVN_BEGINLABELEDITW
    TVN_ENDLABELEDIT* = TVN_ENDLABELEDITW
    TVN_GETINFOTIP* = TVN_GETINFOTIPW
    TVN_ITEMCHANGING* = TVN_ITEMCHANGINGW
    TVN_ITEMCHANGED* = TVN_ITEMCHANGEDW
    WC_COMBOBOXEX* = WC_COMBOBOXEXW
    CBEM_INSERTITEM* = CBEM_INSERTITEMW
    CBEM_SETITEM* = CBEM_SETITEMW
    CBEM_GETITEM* = CBEM_GETITEMW
    CBEN_GETDISPINFO* = CBEN_GETDISPINFOW
    CBEN_DRAGBEGIN* = CBEN_DRAGBEGINW
    CBEN_ENDEDIT* = CBEN_ENDEDITW
    WC_TABCONTROL* = WC_TABCONTROLW
    MONTHCAL_CLASS* = MONTHCAL_CLASSW
    DATETIMEPICK_CLASS* = DATETIMEPICK_CLASSW
    DTN_USERSTRING* = DTN_USERSTRINGW
    DTN_WMKEYDOWN* = DTN_WMKEYDOWNW
    DTN_FORMAT* = DTN_FORMATW
    DTN_FORMATQUERY* = DTN_FORMATQUERYW
    WC_IPADDRESS* = WC_IPADDRESSW
    WC_PAGESCROLLER* = WC_PAGESCROLLERW
    WC_NATIVEFONTCTL* = WC_NATIVEFONTCTLW
    WC_BUTTON* = WC_BUTTONW
    WC_STATIC* = WC_STATICW
    WC_EDIT* = WC_EDITW
    WC_LISTBOX* = WC_LISTBOXW
    WC_COMBOBOX* = WC_COMBOBOXW
    WC_SCROLLBAR* = WC_SCROLLBARW
  proc CreatePropertySheetPage*(constPropSheetPagePointer: LPCPROPSHEETPAGEW): HPROPSHEETPAGE {.winapi, stdcall, dynlib: "comctl32", importc: "CreatePropertySheetPageW".}
  proc PropertySheet*(P1: LPCPROPSHEETHEADERW): INT_PTR {.winapi, stdcall, dynlib: "comctl32", importc: "PropertySheetW".}
  proc ImageList_LoadImage*(hi: HINSTANCE, lpbmp: LPCWSTR, cx: int32, cGrow: int32, crMask: COLORREF, uType: UINT, uFlags: UINT): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc: "ImageList_LoadImageW".}
  proc CreateStatusWindow*(style: LONG, lpszText: LPCWSTR, hwndParent: HWND, wID: UINT): HWND {.winapi, stdcall, dynlib: "comctl32", importc: "CreateStatusWindowW".}
  proc DrawStatusText*(hDC: HDC, lprc: LPCRECT, pszText: LPCWSTR, uFlags: UINT): void {.winapi, stdcall, dynlib: "comctl32", importc: "DrawStatusTextW".}
when winimAnsi:
  type
    LPNMLVDISPINFO* = LPNMLVDISPINFOA
    LPFNPSPCALLBACK* = LPFNPSPCALLBACKA
    PROPSHEETPAGE* = PROPSHEETPAGEA
    LPPROPSHEETPAGE* = LPPROPSHEETPAGEA
    LPCPROPSHEETPAGE* = LPCPROPSHEETPAGEA
    PROPSHEETHEADER* = PROPSHEETHEADERA
    LPPROPSHEETHEADER* = LPPROPSHEETHEADERA
    LPCPROPSHEETHEADER* = LPCPROPSHEETHEADERA
    HD_TEXTFILTER* = HD_TEXTFILTERA
    LPHD_TEXTFILTER* = LPHD_TEXTFILTERA
    HDITEM* = HDITEMA
    LPNMHEADER* = LPNMHEADERA
    NMHDDISPINFO* = NMHDDISPINFOA
    LPNMHDDISPINFO* = LPNMHDDISPINFOA
    TBSAVEPARAMS* = TBSAVEPARAMSA
    LPTBSAVEPARAMS* = LPTBSAVEPARAMSA
    TBBUTTONINFO* = TBBUTTONINFOA
    LPTBBUTTONINFO* = LPTBBUTTONINFOA
    NMTBGETINFOTIP* = NMTBGETINFOTIPA
    LPNMTBGETINFOTIP* = LPNMTBGETINFOTIPA
    NMTBDISPINFO* = NMTBDISPINFOA
    LPNMTBDISPINFO* = LPNMTBDISPINFOA
    REBARBANDINFO* = REBARBANDINFOA
    LPREBARBANDINFO* = LPREBARBANDINFOA
    LPCREBARBANDINFO* = LPCREBARBANDINFOA
    PTOOLINFO* = PTOOLINFOA
    TTHITTESTINFO* = TTHITTESTINFOA
    LVITEM* = LVITEMA
    LVCOLUMN* = LVCOLUMNA
    LVBKIMAGE* = LVBKIMAGEA
    PNM_FINDITEM* = PNM_FINDITEMA
    LPNM_FINDITEM* = LPNM_FINDITEMA
    NM_FINDITEM* = NM_FINDITEMA
    NMLVFINDITEM* = NMLVFINDITEMA
    LPNMLVFINDITEM* = LPNMLVFINDITEMA
    NMLVGETINFOTIP* = NMLVGETINFOTIPA
    LPNMLVGETINFOTIP* = LPNMLVGETINFOTIPA
    TVITEMEX* = TVITEMEXA
    LPTVITEMEX* = LPTVITEMEXA
    TVINSERTSTRUCT* = TVINSERTSTRUCTA
    NMTREEVIEW* = NMTREEVIEWA
    LPNMTREEVIEW* = LPNMTREEVIEWA
    LPNMTVDISPINFO* = LPNMTVDISPINFOA
    LPNMTVDISPINFOEX* = LPNMTVDISPINFOEXA
    NMTVGETINFOTIP* = NMTVGETINFOTIPA
    LPNMTVGETINFOTIP* = LPNMTVGETINFOTIPA
    COMBOBOXEXITEM* = COMBOBOXEXITEMA
    PCOMBOBOXEXITEM* = PCOMBOBOXEXITEMA
    NMCOMBOBOXEX* = NMCOMBOBOXEXA
    PNMCOMBOBOXEX* = PNMCOMBOBOXEXA
    NMCBEDRAGBEGIN* = NMCBEDRAGBEGINA
    LPNMCBEDRAGBEGIN* = LPNMCBEDRAGBEGINA
    PNMCBEDRAGBEGIN* = PNMCBEDRAGBEGINA
    NMCBEENDEDIT* = NMCBEENDEDITA
    LPNMCBEENDEDIT* = LPNMCBEENDEDITA
    PNMCBEENDEDIT* = PNMCBEENDEDITA
    TCITEMHEADER* = TCITEMHEADERA
    LPTCITEMHEADER* = LPTCITEMHEADERA
    TCITEM* = TCITEMA
    NMDATETIMESTRING* = NMDATETIMESTRINGA
    LPNMDATETIMESTRING* = LPNMDATETIMESTRINGA
    NMDATETIMEWMKEYDOWN* = NMDATETIMEWMKEYDOWNA
    LPNMDATETIMEWMKEYDOWN* = LPNMDATETIMEWMKEYDOWNA
    NMDATETIMEFORMAT* = NMDATETIMEFORMATA
    LPNMDATETIMEFORMAT* = LPNMDATETIMEFORMATA
    NMDATETIMEFORMATQUERY* = NMDATETIMEFORMATQUERYA
    LPNMDATETIMEFORMATQUERY* = LPNMDATETIMEFORMATQUERYA
  const
    WC_HEADER* = WC_HEADERA
    HDN_ITEMCHANGING* = HDN_ITEMCHANGINGA
    HDN_ITEMCHANGED* = HDN_ITEMCHANGEDA
    HDN_ITEMCLICK* = HDN_ITEMCLICKA
    HDN_ITEMDBLCLICK* = HDN_ITEMDBLCLICKA
    HDN_DIVIDERDBLCLICK* = HDN_DIVIDERDBLCLICKA
    HDN_BEGINTRACK* = HDN_BEGINTRACKA
    HDN_ENDTRACK* = HDN_ENDTRACKA
    HDN_TRACK* = HDN_TRACKA
    HDN_GETDISPINFO* = HDN_GETDISPINFOA
    TOOLBARCLASSNAME* = TOOLBARCLASSNAMEA
    TB_GETBUTTONTEXT* = TB_GETBUTTONTEXTA
    TB_SAVERESTORE* = TB_SAVERESTOREA
    TB_ADDSTRING* = TB_ADDSTRINGA
    TB_MAPACCELERATOR* = TB_MAPACCELERATORA
    TB_GETBUTTONINFO* = TB_GETBUTTONINFOA
    TB_SETBUTTONINFO* = TB_SETBUTTONINFOA
    TB_INSERTBUTTON* = TB_INSERTBUTTONA
    TB_ADDBUTTONS* = TB_ADDBUTTONSA
    TB_GETSTRING* = TB_GETSTRINGA
    TBN_GETINFOTIP* = TBN_GETINFOTIPA
    TBN_GETDISPINFO* = TBN_GETDISPINFOA
    TBN_GETBUTTONINFO* = TBN_GETBUTTONINFOA
    REBARCLASSNAME* = REBARCLASSNAMEA
    RB_INSERTBAND* = RB_INSERTBANDA
    RB_SETBANDINFO* = RB_SETBANDINFOA
    RB_GETBANDINFO* = RB_GETBANDINFOA
    TOOLTIPS_CLASS* = TOOLTIPS_CLASSA
    TTM_ADDTOOL* = TTM_ADDTOOLA
    TTM_DELTOOL* = TTM_DELTOOLA
    TTM_NEWTOOLRECT* = TTM_NEWTOOLRECTA
    TTM_GETTOOLINFO* = TTM_GETTOOLINFOA
    TTM_SETTOOLINFO* = TTM_SETTOOLINFOA
    TTM_HITTEST* = TTM_HITTESTA
    TTM_GETTEXT* = TTM_GETTEXTA
    TTM_UPDATETIPTEXT* = TTM_UPDATETIPTEXTA
    TTM_ENUMTOOLS* = TTM_ENUMTOOLSA
    TTM_GETCURRENTTOOL* = TTM_GETCURRENTTOOLA
    TTM_SETTITLE* = TTM_SETTITLEA
    STATUSCLASSNAME* = STATUSCLASSNAMEA
    SB_GETTEXT* = SB_GETTEXTA
    SB_SETTEXT* = SB_SETTEXTA
    SB_GETTEXTLENGTH* = SB_GETTEXTLENGTHA
    SB_SETTIPTEXT* = SB_SETTIPTEXTA
    SB_GETTIPTEXT* = SB_GETTIPTEXTA
    TRACKBAR_CLASS* = TRACKBAR_CLASSA
    UPDOWN_CLASS* = UPDOWN_CLASSA
    PROGRESS_CLASS* = PROGRESS_CLASSA
    HOTKEY_CLASS* = HOTKEY_CLASSA
    WC_LISTVIEW* = WC_LISTVIEWA
    LPSTR_TEXTCALLBACK* = LPSTR_TEXTCALLBACKA
    LVN_ODFINDITEM* = LVN_ODFINDITEMA
    LVN_BEGINLABELEDIT* = LVN_BEGINLABELEDITA
    LVN_ENDLABELEDIT* = LVN_ENDLABELEDITA
    LVN_GETDISPINFO* = LVN_GETDISPINFOA
    LVN_SETDISPINFO* = LVN_SETDISPINFOA
    LVN_GETINFOTIP* = LVN_GETINFOTIPA
    LVN_INCREMENTALSEARCH* = LVN_INCREMENTALSEARCHA
    WC_TREEVIEW* = WC_TREEVIEWA
    TVN_SELCHANGING* = TVN_SELCHANGINGA
    TVN_SELCHANGED* = TVN_SELCHANGEDA
    TVN_GETDISPINFO* = TVN_GETDISPINFOA
    TVN_SETDISPINFO* = TVN_SETDISPINFOA
    TVN_ITEMEXPANDING* = TVN_ITEMEXPANDINGA
    TVN_ITEMEXPANDED* = TVN_ITEMEXPANDEDA
    TVN_BEGINDRAG* = TVN_BEGINDRAGA
    TVN_BEGINRDRAG* = TVN_BEGINRDRAGA
    TVN_DELETEITEM* = TVN_DELETEITEMA
    TVN_BEGINLABELEDIT* = TVN_BEGINLABELEDITA
    TVN_ENDLABELEDIT* = TVN_ENDLABELEDITA
    TVN_GETINFOTIP* = TVN_GETINFOTIPA
    TVN_ITEMCHANGING* = TVN_ITEMCHANGINGA
    TVN_ITEMCHANGED* = TVN_ITEMCHANGEDA
    WC_COMBOBOXEX* = WC_COMBOBOXEXA
    CBEM_INSERTITEM* = CBEM_INSERTITEMA
    CBEM_SETITEM* = CBEM_SETITEMA
    CBEM_GETITEM* = CBEM_GETITEMA
    CBEN_GETDISPINFO* = CBEN_GETDISPINFOA
    CBEN_DRAGBEGIN* = CBEN_DRAGBEGINA
    CBEN_ENDEDIT* = CBEN_ENDEDITA
    WC_TABCONTROL* = WC_TABCONTROLA
    MONTHCAL_CLASS* = MONTHCAL_CLASSA
    DATETIMEPICK_CLASS* = DATETIMEPICK_CLASSA
    DTN_USERSTRING* = DTN_USERSTRINGA
    DTN_WMKEYDOWN* = DTN_WMKEYDOWNA
    DTN_FORMAT* = DTN_FORMATA
    DTN_FORMATQUERY* = DTN_FORMATQUERYA
    WC_IPADDRESS* = WC_IPADDRESSA
    WC_PAGESCROLLER* = WC_PAGESCROLLERA
    WC_NATIVEFONTCTL* = WC_NATIVEFONTCTLA
    WC_BUTTON* = WC_BUTTONA
    WC_STATIC* = WC_STATICA
    WC_EDIT* = WC_EDITA
    WC_LISTBOX* = WC_LISTBOXA
    WC_COMBOBOX* = WC_COMBOBOXA
    WC_SCROLLBAR* = WC_SCROLLBARA
  proc CreatePropertySheetPage*(constPropSheetPagePointer: LPCPROPSHEETPAGEA): HPROPSHEETPAGE {.winapi, stdcall, dynlib: "comctl32", importc: "CreatePropertySheetPageA".}
  proc PropertySheet*(P1: LPCPROPSHEETHEADERA): INT_PTR {.winapi, stdcall, dynlib: "comctl32", importc: "PropertySheetA".}
  proc ImageList_LoadImage*(hi: HINSTANCE, lpbmp: LPCSTR, cx: int32, cGrow: int32, crMask: COLORREF, uType: UINT, uFlags: UINT): HIMAGELIST {.winapi, stdcall, dynlib: "comctl32", importc: "ImageList_LoadImageA".}
  proc CreateStatusWindow*(style: LONG, lpszText: LPCSTR, hwndParent: HWND, wID: UINT): HWND {.winapi, stdcall, dynlib: "comctl32", importc: "CreateStatusWindowA".}
  proc DrawStatusText*(hDC: HDC, lprc: LPCRECT, pszText: LPCSTR, uFlags: UINT): void {.winapi, stdcall, dynlib: "comctl32", importc: "DrawStatusTextA".}
when winimCpu64:
  type
    PTBBUTTON* = ptr TBBUTTON
    LPTBBUTTON* = ptr TBBUTTON
  proc FlatSB_GetScrollPropPtr*(P1: HWND, propIndex: int32, P3: PINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc.}
when winimCpu32:
  type
    PTBBUTTON* = ptr TBBUTTON
    LPTBBUTTON* = ptr TBBUTTON
  proc FlatSB_GetScrollPropPtr*(P1: HWND, propIndex: int32, P3: LPINT): WINBOOL {.winapi, stdcall, dynlib: "comctl32", importc: "FlatSB_GetScrollProp".}
