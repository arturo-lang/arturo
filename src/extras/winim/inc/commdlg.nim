#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import wingdi
import winuser
import objbase
import commctrl
#include <commdlg.h>
type
  LPOFNHOOKPROC* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT_PTR {.stdcall.}
  OPENFILENAME_NT4A* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hInstance*: HINSTANCE
    lpstrFilter*: LPCSTR
    lpstrCustomFilter*: LPSTR
    nMaxCustFilter*: DWORD
    nFilterIndex*: DWORD
    lpstrFile*: LPSTR
    nMaxFile*: DWORD
    lpstrFileTitle*: LPSTR
    nMaxFileTitle*: DWORD
    lpstrInitialDir*: LPCSTR
    lpstrTitle*: LPCSTR
    Flags*: DWORD
    nFileOffset*: WORD
    nFileExtension*: WORD
    lpstrDefExt*: LPCSTR
    lCustData*: LPARAM
    lpfnHook*: LPOFNHOOKPROC
    lpTemplateName*: LPCSTR
  LPOPENFILENAME_NT4A* = ptr OPENFILENAME_NT4A
  OPENFILENAME_NT4W* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hInstance*: HINSTANCE
    lpstrFilter*: LPCWSTR
    lpstrCustomFilter*: LPWSTR
    nMaxCustFilter*: DWORD
    nFilterIndex*: DWORD
    lpstrFile*: LPWSTR
    nMaxFile*: DWORD
    lpstrFileTitle*: LPWSTR
    nMaxFileTitle*: DWORD
    lpstrInitialDir*: LPCWSTR
    lpstrTitle*: LPCWSTR
    Flags*: DWORD
    nFileOffset*: WORD
    nFileExtension*: WORD
    lpstrDefExt*: LPCWSTR
    lCustData*: LPARAM
    lpfnHook*: LPOFNHOOKPROC
    lpTemplateName*: LPCWSTR
  LPOPENFILENAME_NT4W* = ptr OPENFILENAME_NT4W
  OPENFILENAMEA* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hInstance*: HINSTANCE
    lpstrFilter*: LPCSTR
    lpstrCustomFilter*: LPSTR
    nMaxCustFilter*: DWORD
    nFilterIndex*: DWORD
    lpstrFile*: LPSTR
    nMaxFile*: DWORD
    lpstrFileTitle*: LPSTR
    nMaxFileTitle*: DWORD
    lpstrInitialDir*: LPCSTR
    lpstrTitle*: LPCSTR
    Flags*: DWORD
    nFileOffset*: WORD
    nFileExtension*: WORD
    lpstrDefExt*: LPCSTR
    lCustData*: LPARAM
    lpfnHook*: LPOFNHOOKPROC
    lpTemplateName*: LPCSTR
    pvReserved*: pointer
    dwReserved*: DWORD
    FlagsEx*: DWORD
  LPOPENFILENAMEA* = ptr OPENFILENAMEA
  OPENFILENAMEW* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hInstance*: HINSTANCE
    lpstrFilter*: LPCWSTR
    lpstrCustomFilter*: LPWSTR
    nMaxCustFilter*: DWORD
    nFilterIndex*: DWORD
    lpstrFile*: LPWSTR
    nMaxFile*: DWORD
    lpstrFileTitle*: LPWSTR
    nMaxFileTitle*: DWORD
    lpstrInitialDir*: LPCWSTR
    lpstrTitle*: LPCWSTR
    Flags*: DWORD
    nFileOffset*: WORD
    nFileExtension*: WORD
    lpstrDefExt*: LPCWSTR
    lCustData*: LPARAM
    lpfnHook*: LPOFNHOOKPROC
    lpTemplateName*: LPCWSTR
    pvReserved*: pointer
    dwReserved*: DWORD
    FlagsEx*: DWORD
  LPOPENFILENAMEW* = ptr OPENFILENAMEW
  OFNOTIFYA* {.pure.} = object
    hdr*: NMHDR
    lpOFN*: LPOPENFILENAMEA
    pszFile*: LPSTR
  LPOFNOTIFYA* = ptr OFNOTIFYA
  OFNOTIFYW* {.pure.} = object
    hdr*: NMHDR
    lpOFN*: LPOPENFILENAMEW
    pszFile*: LPWSTR
  LPOFNOTIFYW* = ptr OFNOTIFYW
  OFNOTIFYEXA* {.pure.} = object
    hdr*: NMHDR
    lpOFN*: LPOPENFILENAMEA
    psf*: LPVOID
    pidl*: LPVOID
  LPOFNOTIFYEXA* = ptr OFNOTIFYEXA
  OFNOTIFYEXW* {.pure.} = object
    hdr*: NMHDR
    lpOFN*: LPOPENFILENAMEW
    psf*: LPVOID
    pidl*: LPVOID
  LPOFNOTIFYEXW* = ptr OFNOTIFYEXW
  LPCCHOOKPROC* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT_PTR {.stdcall.}
  TCHOOSECOLORA* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hInstance*: HWND
    rgbResult*: COLORREF
    lpCustColors*: ptr COLORREF
    Flags*: DWORD
    lCustData*: LPARAM
    lpfnHook*: LPCCHOOKPROC
    lpTemplateName*: LPCSTR
  LPCHOOSECOLORA* = ptr TCHOOSECOLORA
  TCHOOSECOLORW* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hInstance*: HWND
    rgbResult*: COLORREF
    lpCustColors*: ptr COLORREF
    Flags*: DWORD
    lCustData*: LPARAM
    lpfnHook*: LPCCHOOKPROC
    lpTemplateName*: LPCWSTR
  LPCHOOSECOLORW* = ptr TCHOOSECOLORW
  LPFRHOOKPROC* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT_PTR {.stdcall.}
  FINDREPLACEA* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hInstance*: HINSTANCE
    Flags*: DWORD
    lpstrFindWhat*: LPSTR
    lpstrReplaceWith*: LPSTR
    wFindWhatLen*: WORD
    wReplaceWithLen*: WORD
    lCustData*: LPARAM
    lpfnHook*: LPFRHOOKPROC
    lpTemplateName*: LPCSTR
  LPFINDREPLACEA* = ptr FINDREPLACEA
  FINDREPLACEW* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hInstance*: HINSTANCE
    Flags*: DWORD
    lpstrFindWhat*: LPWSTR
    lpstrReplaceWith*: LPWSTR
    wFindWhatLen*: WORD
    wReplaceWithLen*: WORD
    lCustData*: LPARAM
    lpfnHook*: LPFRHOOKPROC
    lpTemplateName*: LPCWSTR
  LPFINDREPLACEW* = ptr FINDREPLACEW
  LPCFHOOKPROC* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT_PTR {.stdcall.}
  TCHOOSEFONTA* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hDC*: HDC
    lpLogFont*: LPLOGFONTA
    iPointSize*: INT
    Flags*: DWORD
    rgbColors*: COLORREF
    lCustData*: LPARAM
    lpfnHook*: LPCFHOOKPROC
    lpTemplateName*: LPCSTR
    hInstance*: HINSTANCE
    lpszStyle*: LPSTR
    nFontType*: WORD
    MISSING_ALIGNMENT*: WORD
    nSizeMin*: INT
    nSizeMax*: INT
  LPCHOOSEFONTA* = ptr TCHOOSEFONTA
  TCHOOSEFONTW* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hDC*: HDC
    lpLogFont*: LPLOGFONTW
    iPointSize*: INT
    Flags*: DWORD
    rgbColors*: COLORREF
    lCustData*: LPARAM
    lpfnHook*: LPCFHOOKPROC
    lpTemplateName*: LPCWSTR
    hInstance*: HINSTANCE
    lpszStyle*: LPWSTR
    nFontType*: WORD
    MISSING_ALIGNMENT*: WORD
    nSizeMin*: INT
    nSizeMax*: INT
  LPCHOOSEFONTW* = ptr TCHOOSEFONTW
  LPPRINTHOOKPROC* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT_PTR {.stdcall.}
  LPSETUPHOOKPROC* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT_PTR {.stdcall.}
when winimCpu64:
  type
    TPRINTDLGA* {.pure.} = object
      lStructSize*: DWORD
      hwndOwner*: HWND
      hDevMode*: HGLOBAL
      hDevNames*: HGLOBAL
      hDC*: HDC
      Flags*: DWORD
      nFromPage*: WORD
      nToPage*: WORD
      nMinPage*: WORD
      nMaxPage*: WORD
      nCopies*: WORD
      hInstance*: HINSTANCE
      lCustData*: LPARAM
      lpfnPrintHook*: LPPRINTHOOKPROC
      lpfnSetupHook*: LPSETUPHOOKPROC
      lpPrintTemplateName*: LPCSTR
      lpSetupTemplateName*: LPCSTR
      hPrintTemplate*: HGLOBAL
      hSetupTemplate*: HGLOBAL
when winimCpu32:
  type
    TPRINTDLGA* {.pure, packed.} = object
      lStructSize*: DWORD
      hwndOwner*: HWND
      hDevMode*: HGLOBAL
      hDevNames*: HGLOBAL
      hDC*: HDC
      Flags*: DWORD
      nFromPage*: WORD
      nToPage*: WORD
      nMinPage*: WORD
      nMaxPage*: WORD
      nCopies*: WORD
      hInstance*: HINSTANCE
      lCustData*: LPARAM
      lpfnPrintHook*: LPPRINTHOOKPROC
      lpfnSetupHook*: LPSETUPHOOKPROC
      lpPrintTemplateName*: LPCSTR
      lpSetupTemplateName*: LPCSTR
      hPrintTemplate*: HGLOBAL
      hSetupTemplate*: HGLOBAL
type
  LPPRINTDLGA* = ptr TPRINTDLGA
when winimCpu64:
  type
    TPRINTDLGW* {.pure.} = object
      lStructSize*: DWORD
      hwndOwner*: HWND
      hDevMode*: HGLOBAL
      hDevNames*: HGLOBAL
      hDC*: HDC
      Flags*: DWORD
      nFromPage*: WORD
      nToPage*: WORD
      nMinPage*: WORD
      nMaxPage*: WORD
      nCopies*: WORD
      hInstance*: HINSTANCE
      lCustData*: LPARAM
      lpfnPrintHook*: LPPRINTHOOKPROC
      lpfnSetupHook*: LPSETUPHOOKPROC
      lpPrintTemplateName*: LPCWSTR
      lpSetupTemplateName*: LPCWSTR
      hPrintTemplate*: HGLOBAL
      hSetupTemplate*: HGLOBAL
when winimCpu32:
  type
    TPRINTDLGW* {.pure, packed.} = object
      lStructSize*: DWORD
      hwndOwner*: HWND
      hDevMode*: HGLOBAL
      hDevNames*: HGLOBAL
      hDC*: HDC
      Flags*: DWORD
      nFromPage*: WORD
      nToPage*: WORD
      nMinPage*: WORD
      nMaxPage*: WORD
      nCopies*: WORD
      hInstance*: HINSTANCE
      lCustData*: LPARAM
      lpfnPrintHook*: LPPRINTHOOKPROC
      lpfnSetupHook*: LPSETUPHOOKPROC
      lpPrintTemplateName*: LPCWSTR
      lpSetupTemplateName*: LPCWSTR
      hPrintTemplate*: HGLOBAL
      hSetupTemplate*: HGLOBAL
type
  LPPRINTDLGW* = ptr TPRINTDLGW
  PRINTPAGERANGE* {.pure.} = object
    nFromPage*: DWORD
    nToPage*: DWORD
  LPPRINTPAGERANGE* = ptr PRINTPAGERANGE
  TPRINTDLGEXA* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hDevMode*: HGLOBAL
    hDevNames*: HGLOBAL
    hDC*: HDC
    Flags*: DWORD
    Flags2*: DWORD
    ExclusionFlags*: DWORD
    nPageRanges*: DWORD
    nMaxPageRanges*: DWORD
    lpPageRanges*: LPPRINTPAGERANGE
    nMinPage*: DWORD
    nMaxPage*: DWORD
    nCopies*: DWORD
    hInstance*: HINSTANCE
    lpPrintTemplateName*: LPCSTR
    lpCallback*: LPUNKNOWN
    nPropertyPages*: DWORD
    lphPropertyPages*: ptr HPROPSHEETPAGE
    nStartPage*: DWORD
    dwResultAction*: DWORD
  LPPRINTDLGEXA* = ptr TPRINTDLGEXA
  TPRINTDLGEXW* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hDevMode*: HGLOBAL
    hDevNames*: HGLOBAL
    hDC*: HDC
    Flags*: DWORD
    Flags2*: DWORD
    ExclusionFlags*: DWORD
    nPageRanges*: DWORD
    nMaxPageRanges*: DWORD
    lpPageRanges*: LPPRINTPAGERANGE
    nMinPage*: DWORD
    nMaxPage*: DWORD
    nCopies*: DWORD
    hInstance*: HINSTANCE
    lpPrintTemplateName*: LPCWSTR
    lpCallback*: LPUNKNOWN
    nPropertyPages*: DWORD
    lphPropertyPages*: ptr HPROPSHEETPAGE
    nStartPage*: DWORD
    dwResultAction*: DWORD
  LPPRINTDLGEXW* = ptr TPRINTDLGEXW
  DEVNAMES* {.pure.} = object
    wDriverOffset*: WORD
    wDeviceOffset*: WORD
    wOutputOffset*: WORD
    wDefault*: WORD
  LPDEVNAMES* = ptr DEVNAMES
  LPPAGESETUPHOOK* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT_PTR {.stdcall.}
  LPPAGEPAINTHOOK* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT_PTR {.stdcall.}
  TPAGESETUPDLGA* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hDevMode*: HGLOBAL
    hDevNames*: HGLOBAL
    Flags*: DWORD
    ptPaperSize*: POINT
    rtMinMargin*: RECT
    rtMargin*: RECT
    hInstance*: HINSTANCE
    lCustData*: LPARAM
    lpfnPageSetupHook*: LPPAGESETUPHOOK
    lpfnPagePaintHook*: LPPAGEPAINTHOOK
    lpPageSetupTemplateName*: LPCSTR
    hPageSetupTemplate*: HGLOBAL
  LPPAGESETUPDLGA* = ptr TPAGESETUPDLGA
  TPAGESETUPDLGW* {.pure.} = object
    lStructSize*: DWORD
    hwndOwner*: HWND
    hDevMode*: HGLOBAL
    hDevNames*: HGLOBAL
    Flags*: DWORD
    ptPaperSize*: POINT
    rtMinMargin*: RECT
    rtMargin*: RECT
    hInstance*: HINSTANCE
    lCustData*: LPARAM
    lpfnPageSetupHook*: LPPAGESETUPHOOK
    lpfnPagePaintHook*: LPPAGEPAINTHOOK
    lpPageSetupTemplateName*: LPCWSTR
    hPageSetupTemplate*: HGLOBAL
  LPPAGESETUPDLGW* = ptr TPAGESETUPDLGW
const
  IID_IPrintDialogCallback* = DEFINE_GUID("5852a2c3-6530-11d1-b6a3-0000f8757bf9")
  IID_IPrintDialogServices* = DEFINE_GUID("509aaeda-5639-11d1-b6a1-0000f8757bf9")
  OFN_READONLY* = 0x1
  OFN_OVERWRITEPROMPT* = 0x2
  OFN_HIDEREADONLY* = 0x4
  OFN_NOCHANGEDIR* = 0x8
  OFN_SHOWHELP* = 0x10
  OFN_ENABLEHOOK* = 0x20
  OFN_ENABLETEMPLATE* = 0x40
  OFN_ENABLETEMPLATEHANDLE* = 0x80
  OFN_NOVALIDATE* = 0x100
  OFN_ALLOWMULTISELECT* = 0x200
  OFN_EXTENSIONDIFFERENT* = 0x400
  OFN_PATHMUSTEXIST* = 0x800
  OFN_FILEMUSTEXIST* = 0x1000
  OFN_CREATEPROMPT* = 0x2000
  OFN_SHAREAWARE* = 0x4000
  OFN_NOREADONLYRETURN* = 0x8000
  OFN_NOTESTFILECREATE* = 0x10000
  OFN_NONETWORKBUTTON* = 0x20000
  OFN_NOLONGNAMES* = 0x40000
  OFN_EXPLORER* = 0x80000
  OFN_NODEREFERENCELINKS* = 0x100000
  OFN_LONGNAMES* = 0x200000
  OFN_ENABLEINCLUDENOTIFY* = 0x400000
  OFN_ENABLESIZING* = 0x800000
  OFN_DONTADDTORECENT* = 0x2000000
  OFN_FORCESHOWHIDDEN* = 0x10000000
  OFN_EX_NOPLACESBAR* = 0x1
  OFN_SHAREFALLTHROUGH* = 2
  OFN_SHARENOWARN* = 1
  OFN_SHAREWARN* = 0
  CDN_INITDONE* = CDN_FIRST
  CDN_SELCHANGE* = CDN_FIRST-1
  CDN_FOLDERCHANGE* = CDN_FIRST-2
  CDN_SHAREVIOLATION* = CDN_FIRST-3
  CDN_HELP* = CDN_FIRST-4
  CDN_FILEOK* = CDN_FIRST-5
  CDN_TYPECHANGE* = CDN_FIRST-6
  CDN_INCLUDEITEM* = CDN_FIRST-7
  CDM_FIRST* = WM_USER+100
  CDM_LAST* = WM_USER+200
  CDM_GETSPEC* = CDM_FIRST
  CDM_GETFILEPATH* = CDM_FIRST+1
  CDM_GETFOLDERPATH* = CDM_FIRST+2
  CDM_GETFOLDERIDLIST* = CDM_FIRST+3
  CDM_SETCONTROLTEXT* = CDM_FIRST+4
  CDM_HIDECONTROL* = CDM_FIRST+5
  CDM_SETDEFEXT* = CDM_FIRST+6
  CC_RGBINIT* = 0x1
  CC_FULLOPEN* = 0x2
  CC_PREVENTFULLOPEN* = 0x4
  CC_SHOWHELP* = 0x8
  CC_ENABLEHOOK* = 0x10
  CC_ENABLETEMPLATE* = 0x20
  CC_ENABLETEMPLATEHANDLE* = 0x40
  CC_SOLIDCOLOR* = 0x80
  CC_ANYCOLOR* = 0x100
  FR_DOWN* = 0x1
  FR_WHOLEWORD* = 0x2
  FR_MATCHCASE* = 0x4
  FR_FINDNEXT* = 0x8
  FR_REPLACE* = 0x10
  FR_REPLACEALL* = 0x20
  FR_DIALOGTERM* = 0x40
  FR_SHOWHELP* = 0x80
  FR_ENABLEHOOK* = 0x100
  FR_ENABLETEMPLATE* = 0x200
  FR_NOUPDOWN* = 0x400
  FR_NOMATCHCASE* = 0x800
  FR_NOWHOLEWORD* = 0x1000
  FR_ENABLETEMPLATEHANDLE* = 0x2000
  FR_HIDEUPDOWN* = 0x4000
  FR_HIDEMATCHCASE* = 0x8000
  FR_HIDEWHOLEWORD* = 0x10000
  FR_RAW* = 0x20000
  FR_MATCHDIAC* = 0x20000000
  FR_MATCHKASHIDA* = 0x40000000
  FR_MATCHALEFHAMZA* = 0x80000000'i32
  CF_SCREENFONTS* = 0x1
  CF_PRINTERFONTS* = 0x2
  CF_BOTH* = CF_SCREENFONTS or CF_PRINTERFONTS
  CF_SHOWHELP* = 0x4
  CF_ENABLEHOOK* = 0x8
  CF_ENABLETEMPLATE* = 0x10
  CF_ENABLETEMPLATEHANDLE* = 0x20
  CF_INITTOLOGFONTSTRUCT* = 0x40
  CF_USESTYLE* = 0x80
  CF_EFFECTS* = 0x100
  CF_APPLY* = 0x200
  CF_ANSIONLY* = 0x400
  CF_SCRIPTSONLY* = CF_ANSIONLY
  CF_NOVECTORFONTS* = 0x800
  CF_NOOEMFONTS* = CF_NOVECTORFONTS
  CF_NOSIMULATIONS* = 0x1000
  CF_LIMITSIZE* = 0x2000
  CF_FIXEDPITCHONLY* = 0x4000
  CF_WYSIWYG* = 0x8000
  CF_FORCEFONTEXIST* = 0x10000
  CF_SCALABLEONLY* = 0x20000
  CF_TTONLY* = 0x40000
  CF_NOFACESEL* = 0x80000
  CF_NOSTYLESEL* = 0x100000
  CF_NOSIZESEL* = 0x200000
  CF_SELECTSCRIPT* = 0x400000
  CF_NOSCRIPTSEL* = 0x800000
  CF_NOVERTFONTS* = 0x1000000
  CF_INACTIVEFONTS* = 0x02000000
  SIMULATED_FONTTYPE* = 0x8000
  PRINTER_FONTTYPE* = 0x4000
  SCREEN_FONTTYPE* = 0x2000
  BOLD_FONTTYPE* = 0x100
  ITALIC_FONTTYPE* = 0x200
  REGULAR_FONTTYPE* = 0x400
  PS_OPENTYPE_FONTTYPE* = 0x10000
  TT_OPENTYPE_FONTTYPE* = 0x20000
  TYPE1_FONTTYPE* = 0x40000
  SYMBOL_FONTTYPE* = 0x80000
  WM_CHOOSEFONT_GETLOGFONT* = WM_USER+1
  WM_CHOOSEFONT_SETLOGFONT* = WM_USER+101
  WM_CHOOSEFONT_SETFLAGS* = WM_USER+102
  LBSELCHSTRINGA* = "commdlg_LBSelChangedNotify"
  SHAREVISTRINGA* = "commdlg_ShareViolation"
  FILEOKSTRINGA* = "commdlg_FileNameOK"
  COLOROKSTRINGA* = "commdlg_ColorOK"
  SETRGBSTRINGA* = "commdlg_SetRGBColor"
  HELPMSGSTRINGA* = "commdlg_help"
  FINDMSGSTRINGA* = "commdlg_FindReplace"
  LBSELCHSTRINGW* = "commdlg_LBSelChangedNotify"
  SHAREVISTRINGW* = "commdlg_ShareViolation"
  FILEOKSTRINGW* = "commdlg_FileNameOK"
  COLOROKSTRINGW* = "commdlg_ColorOK"
  SETRGBSTRINGW* = "commdlg_SetRGBColor"
  HELPMSGSTRINGW* = "commdlg_help"
  FINDMSGSTRINGW* = "commdlg_FindReplace"
  CD_LBSELNOITEMS* = -1
  CD_LBSELCHANGE* = 0
  CD_LBSELSUB* = 1
  CD_LBSELADD* = 2
  PD_ALLPAGES* = 0x0
  PD_SELECTION* = 0x1
  PD_PAGENUMS* = 0x2
  PD_NOSELECTION* = 0x4
  PD_NOPAGENUMS* = 0x8
  PD_COLLATE* = 0x10
  PD_PRINTTOFILE* = 0x20
  PD_PRINTSETUP* = 0x40
  PD_NOWARNING* = 0x80
  PD_RETURNDC* = 0x100
  PD_RETURNIC* = 0x200
  PD_RETURNDEFAULT* = 0x400
  PD_SHOWHELP* = 0x800
  PD_ENABLEPRINTHOOK* = 0x1000
  PD_ENABLESETUPHOOK* = 0x2000
  PD_ENABLEPRINTTEMPLATE* = 0x4000
  PD_ENABLESETUPTEMPLATE* = 0x8000
  PD_ENABLEPRINTTEMPLATEHANDLE* = 0x10000
  PD_ENABLESETUPTEMPLATEHANDLE* = 0x20000
  PD_USEDEVMODECOPIES* = 0x40000
  PD_USEDEVMODECOPIESANDCOLLATE* = 0x40000
  PD_DISABLEPRINTTOFILE* = 0x80000
  PD_HIDEPRINTTOFILE* = 0x100000
  PD_NONETWORKBUTTON* = 0x200000
  PD_CURRENTPAGE* = 0x400000
  PD_NOCURRENTPAGE* = 0x800000
  PD_EXCLUSIONFLAGS* = 0x1000000
  PD_USELARGETEMPLATE* = 0x10000000
  PD_EXCL_COPIESANDCOLLATE* = DM_COPIES or DM_COLLATE
  START_PAGE_GENERAL* = 0xffffffff'i32
  PD_RESULT_CANCEL* = 0
  PD_RESULT_PRINT* = 1
  PD_RESULT_APPLY* = 2
  DN_DEFAULTPRN* = 0x1
  WM_PSD_PAGESETUPDLG* = WM_USER
  WM_PSD_FULLPAGERECT* = WM_USER+1
  WM_PSD_MINMARGINRECT* = WM_USER+2
  WM_PSD_MARGINRECT* = WM_USER+3
  WM_PSD_GREEKTEXTRECT* = WM_USER+4
  WM_PSD_ENVSTAMPRECT* = WM_USER+5
  WM_PSD_YAFULLPAGERECT* = WM_USER+6
  PSD_DEFAULTMINMARGINS* = 0x0
  PSD_INWININIINTLMEASURE* = 0x0
  PSD_MINMARGINS* = 0x1
  PSD_MARGINS* = 0x2
  PSD_INTHOUSANDTHSOFINCHES* = 0x4
  PSD_INHUNDREDTHSOFMILLIMETERS* = 0x8
  PSD_DISABLEMARGINS* = 0x10
  PSD_DISABLEPRINTER* = 0x20
  PSD_NOWARNING* = 0x80
  PSD_DISABLEORIENTATION* = 0x100
  PSD_RETURNDEFAULT* = 0x400
  PSD_DISABLEPAPER* = 0x200
  PSD_SHOWHELP* = 0x800
  PSD_ENABLEPAGESETUPHOOK* = 0x2000
  PSD_ENABLEPAGESETUPTEMPLATE* = 0x8000
  PSD_ENABLEPAGESETUPTEMPLATEHANDLE* = 0x20000
  PSD_ENABLEPAGEPAINTHOOK* = 0x40000
  PSD_DISABLEPAGEPAINTING* = 0x80000
  PSD_NONETWORKBUTTON* = 0x200000
  OPENFILENAME_SIZE_VERSION_400A* = 0x00000088
  OPENFILENAME_SIZE_VERSION_400W* = 0x00000088
type
  IPrintDialogCallback* {.pure.} = object
    lpVtbl*: ptr IPrintDialogCallbackVtbl
  IPrintDialogCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InitDone*: proc(self: ptr IPrintDialogCallback): HRESULT {.stdcall.}
    SelectionChange*: proc(self: ptr IPrintDialogCallback): HRESULT {.stdcall.}
    HandleMessage*: proc(self: ptr IPrintDialogCallback, hDlg: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, pResult: ptr LRESULT): HRESULT {.stdcall.}
  IPrintDialogServices* {.pure.} = object
    lpVtbl*: ptr IPrintDialogServicesVtbl
  IPrintDialogServicesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentDevMode*: proc(self: ptr IPrintDialogServices, pDevMode: LPDEVMODE, pcbSize: ptr UINT): HRESULT {.stdcall.}
    GetCurrentPrinterName*: proc(self: ptr IPrintDialogServices, pPrinterName: LPTSTR, pcchSize: ptr UINT): HRESULT {.stdcall.}
    GetCurrentPortName*: proc(self: ptr IPrintDialogServices, pPortName: LPTSTR, pcchSize: ptr UINT): HRESULT {.stdcall.}
proc GetOpenFileNameA*(P1: LPOPENFILENAMEA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc GetOpenFileNameW*(P1: LPOPENFILENAMEW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc GetSaveFileNameA*(P1: LPOPENFILENAMEA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc GetSaveFileNameW*(P1: LPOPENFILENAMEW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc GetFileTitleA*(P1: LPCSTR, P2: LPSTR, P3: WORD): int16 {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc GetFileTitleW*(P1: LPCWSTR, P2: LPWSTR, P3: WORD): int16 {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc ChooseColorA*(P1: LPCHOOSECOLORA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc ChooseColorW*(P1: LPCHOOSECOLORW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc FindTextA*(P1: LPFINDREPLACEA): HWND {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc FindTextW*(P1: LPFINDREPLACEW): HWND {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc ReplaceTextA*(P1: LPFINDREPLACEA): HWND {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc ReplaceTextW*(P1: LPFINDREPLACEW): HWND {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc ChooseFontA*(P1: LPCHOOSEFONTA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc ChooseFontW*(P1: LPCHOOSEFONTW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc PrintDlgA*(P1: LPPRINTDLGA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc PrintDlgW*(P1: LPPRINTDLGW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc PrintDlgExA*(P1: LPPRINTDLGEXA): HRESULT {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc PrintDlgExW*(P1: LPPRINTDLGEXW): HRESULT {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc CommDlgExtendedError*(): DWORD {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc PageSetupDlgA*(P1: LPPAGESETUPDLGA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc PageSetupDlgW*(P1: LPPAGESETUPDLGW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc.}
proc InitDone*(self: ptr IPrintDialogCallback): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitDone(self)
proc SelectionChange*(self: ptr IPrintDialogCallback): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectionChange(self)
proc HandleMessage*(self: ptr IPrintDialogCallback, hDlg: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, pResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleMessage(self, hDlg, uMsg, wParam, lParam, pResult)
proc GetCurrentDevMode*(self: ptr IPrintDialogServices, pDevMode: LPDEVMODE, pcbSize: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentDevMode(self, pDevMode, pcbSize)
proc GetCurrentPrinterName*(self: ptr IPrintDialogServices, pPrinterName: LPTSTR, pcchSize: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentPrinterName(self, pPrinterName, pcchSize)
proc GetCurrentPortName*(self: ptr IPrintDialogServices, pPortName: LPTSTR, pcchSize: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentPortName(self, pPortName, pcchSize)
converter winimConverterIPrintDialogCallbackToIUnknown*(x: ptr IPrintDialogCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPrintDialogServicesToIUnknown*(x: ptr IPrintDialogServices): ptr IUnknown = cast[ptr IUnknown](x)
when winimUnicode:
  type
    OPENFILENAME_NT4* = OPENFILENAME_NT4W
    LPOPENFILENAME_NT4* = LPOPENFILENAME_NT4W
    OPENFILENAME* = OPENFILENAMEW
    LPOPENFILENAME* = LPOPENFILENAMEW
    OFNOTIFY* = OFNOTIFYW
    LPOFNOTIFY* = LPOFNOTIFYW
    OFNOTIFYEX* = OFNOTIFYEXW
    LPOFNOTIFYEX* = LPOFNOTIFYEXW
    TCHOOSECOLOR* = TCHOOSECOLORW
    LPCHOOSECOLOR* = LPCHOOSECOLORW
    FINDREPLACE* = FINDREPLACEW
    LPFINDREPLACE* = LPFINDREPLACEW
    TCHOOSEFONT* = TCHOOSEFONTW
    LPCHOOSEFONT* = LPCHOOSEFONTW
    TPRINTDLG* = TPRINTDLGW
    LPPRINTDLG* = LPPRINTDLGW
    TPRINTDLGEX* = TPRINTDLGEXW
    LPPRINTDLGEX* = LPPRINTDLGEXW
    TPAGESETUPDLG* = TPAGESETUPDLGW
    LPPAGESETUPDLG* = LPPAGESETUPDLGW
  const
    OPENFILENAME_SIZE_VERSION_400* = OPENFILENAME_SIZE_VERSION_400W
    LBSELCHSTRING* = LBSELCHSTRINGW
    SHAREVISTRING* = SHAREVISTRINGW
    FILEOKSTRING* = FILEOKSTRINGW
    COLOROKSTRING* = COLOROKSTRINGW
    SETRGBSTRING* = SETRGBSTRINGW
    HELPMSGSTRING* = HELPMSGSTRINGW
    FINDMSGSTRING* = FINDMSGSTRINGW
  proc GetOpenFileName*(P1: LPOPENFILENAMEW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "GetOpenFileNameW".}
  proc GetSaveFileName*(P1: LPOPENFILENAMEW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "GetSaveFileNameW".}
  proc GetFileTitle*(P1: LPCWSTR, P2: LPWSTR, P3: WORD): int16 {.winapi, stdcall, dynlib: "comdlg32", importc: "GetFileTitleW".}
  proc ChooseColor*(P1: LPCHOOSECOLORW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "ChooseColorW".}
  proc FindText*(P1: LPFINDREPLACEW): HWND {.winapi, stdcall, dynlib: "comdlg32", importc: "FindTextW".}
  proc ReplaceText*(P1: LPFINDREPLACEW): HWND {.winapi, stdcall, dynlib: "comdlg32", importc: "ReplaceTextW".}
  proc ChooseFont*(P1: LPCHOOSEFONTW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "ChooseFontW".}
  proc PrintDlg*(P1: LPPRINTDLGW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "PrintDlgW".}
  proc PrintDlgEx*(P1: LPPRINTDLGEXW): HRESULT {.winapi, stdcall, dynlib: "comdlg32", importc: "PrintDlgExW".}
  proc PageSetupDlg*(P1: LPPAGESETUPDLGW): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "PageSetupDlgW".}
when winimAnsi:
  type
    OPENFILENAME_NT4* = OPENFILENAME_NT4A
    LPOPENFILENAME_NT4* = LPOPENFILENAME_NT4A
    OPENFILENAME* = OPENFILENAMEA
    LPOPENFILENAME* = LPOPENFILENAMEA
    OFNOTIFY* = OFNOTIFYA
    LPOFNOTIFY* = LPOFNOTIFYA
    OFNOTIFYEX* = OFNOTIFYEXA
    LPOFNOTIFYEX* = LPOFNOTIFYEXA
    TCHOOSECOLOR* = TCHOOSECOLORA
    LPCHOOSECOLOR* = LPCHOOSECOLORA
    FINDREPLACE* = FINDREPLACEA
    LPFINDREPLACE* = LPFINDREPLACEA
    TCHOOSEFONT* = TCHOOSEFONTA
    LPCHOOSEFONT* = LPCHOOSEFONTA
    TPRINTDLG* = TPRINTDLGA
    LPPRINTDLG* = LPPRINTDLGA
    TPRINTDLGEX* = TPRINTDLGEXA
    LPPRINTDLGEX* = LPPRINTDLGEXA
    TPAGESETUPDLG* = TPAGESETUPDLGA
    LPPAGESETUPDLG* = LPPAGESETUPDLGA
  const
    OPENFILENAME_SIZE_VERSION_400* = OPENFILENAME_SIZE_VERSION_400A
    LBSELCHSTRING* = LBSELCHSTRINGA
    SHAREVISTRING* = SHAREVISTRINGA
    FILEOKSTRING* = FILEOKSTRINGA
    COLOROKSTRING* = COLOROKSTRINGA
    SETRGBSTRING* = SETRGBSTRINGA
    HELPMSGSTRING* = HELPMSGSTRINGA
    FINDMSGSTRING* = FINDMSGSTRINGA
  proc GetOpenFileName*(P1: LPOPENFILENAMEA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "GetOpenFileNameA".}
  proc GetSaveFileName*(P1: LPOPENFILENAMEA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "GetSaveFileNameA".}
  proc GetFileTitle*(P1: LPCSTR, P2: LPSTR, P3: WORD): int16 {.winapi, stdcall, dynlib: "comdlg32", importc: "GetFileTitleA".}
  proc ChooseColor*(P1: LPCHOOSECOLORA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "ChooseColorA".}
  proc FindText*(P1: LPFINDREPLACEA): HWND {.winapi, stdcall, dynlib: "comdlg32", importc: "FindTextA".}
  proc ReplaceText*(P1: LPFINDREPLACEA): HWND {.winapi, stdcall, dynlib: "comdlg32", importc: "ReplaceTextA".}
  proc ChooseFont*(P1: LPCHOOSEFONTA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "ChooseFontA".}
  proc PrintDlg*(P1: LPPRINTDLGA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "PrintDlgA".}
  proc PrintDlgEx*(P1: LPPRINTDLGEXA): HRESULT {.winapi, stdcall, dynlib: "comdlg32", importc: "PrintDlgExA".}
  proc PageSetupDlg*(P1: LPPAGESETUPDLGA): WINBOOL {.winapi, stdcall, dynlib: "comdlg32", importc: "PageSetupDlgA".}
