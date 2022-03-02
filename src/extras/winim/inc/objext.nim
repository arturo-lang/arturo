#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winerror
import winuser
import objbase
import commctrl
import commdlg
#include <oleacc.h>
#include <objsafe.h>
#include <olectl.h>
#include <activscp.h>
#include <oledlg.h>
type
  AnnoScope* = int32
  OLE_XPOS_PIXELS* = int32
  OLE_YPOS_PIXELS* = int32
  OLE_XSIZE_PIXELS* = int32
  OLE_YSIZE_PIXELS* = int32
  OLE_TRISTATE* = int32
  SCRIPTLANGUAGEVERSION* = int32
  TSCRIPTSTATE* = int32
  SCRIPTTRACEINFO* = int32
  SCRIPTTHREADSTATE* = int32
  SCRIPTGCTYPE* = int32
  SCRIPTUICITEM* = int32
  SCRIPTUICHANDLING* = int32
  OLEUIPASTEFLAG* = int32
  SCRIPTTHREADID* = DWORD
  MSAAMENUINFO* {.pure.} = object
    dwMSAASignature*: DWORD
    cchWText*: DWORD
    pszWText*: LPWSTR
  LPMSAAMENUINFO* = ptr MSAAMENUINFO
  IAccessible* {.pure.} = object
    lpVtbl*: ptr IAccessibleVtbl
  IAccessibleVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_accParent*: proc(self: ptr IAccessible, ppdispParent: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_accChildCount*: proc(self: ptr IAccessible, pcountChildren: ptr LONG): HRESULT {.stdcall.}
    get_accChild*: proc(self: ptr IAccessible, varChildID: VARIANT, ppdispChild: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_accName*: proc(self: ptr IAccessible, varID: VARIANT, pszName: ptr BSTR): HRESULT {.stdcall.}
    get_accValue*: proc(self: ptr IAccessible, varID: VARIANT, pszValue: ptr BSTR): HRESULT {.stdcall.}
    get_accDescription*: proc(self: ptr IAccessible, varID: VARIANT, pszDescription: ptr BSTR): HRESULT {.stdcall.}
    get_accRole*: proc(self: ptr IAccessible, varID: VARIANT, pvarRole: ptr VARIANT): HRESULT {.stdcall.}
    get_accState*: proc(self: ptr IAccessible, varID: VARIANT, pvarState: ptr VARIANT): HRESULT {.stdcall.}
    get_accHelp*: proc(self: ptr IAccessible, varID: VARIANT, pszHelp: ptr BSTR): HRESULT {.stdcall.}
    get_accHelpTopic*: proc(self: ptr IAccessible, pszHelpFile: ptr BSTR, varID: VARIANT, pidTopic: ptr LONG): HRESULT {.stdcall.}
    get_accKeyboardShortcut*: proc(self: ptr IAccessible, varID: VARIANT, pszKeyboardShortcut: ptr BSTR): HRESULT {.stdcall.}
    get_accFocus*: proc(self: ptr IAccessible, pvarID: ptr VARIANT): HRESULT {.stdcall.}
    get_accSelection*: proc(self: ptr IAccessible, pvarID: ptr VARIANT): HRESULT {.stdcall.}
    get_accDefaultAction*: proc(self: ptr IAccessible, varID: VARIANT, pszDefaultAction: ptr BSTR): HRESULT {.stdcall.}
    accSelect*: proc(self: ptr IAccessible, flagsSelect: LONG, varID: VARIANT): HRESULT {.stdcall.}
    accLocation*: proc(self: ptr IAccessible, pxLeft: ptr LONG, pyTop: ptr LONG, pcxWidth: ptr LONG, pcyHeight: ptr LONG, varID: VARIANT): HRESULT {.stdcall.}
    accNavigate*: proc(self: ptr IAccessible, navDir: LONG, varStart: VARIANT, pvarEnd: ptr VARIANT): HRESULT {.stdcall.}
    accHitTest*: proc(self: ptr IAccessible, xLeft: LONG, yTop: LONG, pvarID: ptr VARIANT): HRESULT {.stdcall.}
    accDoDefaultAction*: proc(self: ptr IAccessible, varID: VARIANT): HRESULT {.stdcall.}
    put_accName*: proc(self: ptr IAccessible, varID: VARIANT, pszName: BSTR): HRESULT {.stdcall.}
    put_accValue*: proc(self: ptr IAccessible, varID: VARIANT, pszValue: BSTR): HRESULT {.stdcall.}
  LPACCESSIBLE* = ptr IAccessible
  IAccessibleHandler* {.pure.} = object
    lpVtbl*: ptr IAccessibleHandlerVtbl
  IAccessibleHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AccessibleObjectFromID*: proc(self: ptr IAccessibleHandler, hwnd: LONG, lObjectID: LONG, pIAccessible: ptr LPACCESSIBLE): HRESULT {.stdcall.}
  LPACCESSIBLEHANDLER* = ptr IAccessibleHandler
  MSAAPROPID* = GUID
  IObjectSafety* {.pure.} = object
    lpVtbl*: ptr IObjectSafetyVtbl
  IObjectSafetyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetInterfaceSafetyOptions*: proc(self: ptr IObjectSafety, riid: REFIID, pdwSupportedOptions: ptr DWORD, pdwEnabledOptions: ptr DWORD): HRESULT {.stdcall.}
    SetInterfaceSafetyOptions*: proc(self: ptr IObjectSafety, riid: REFIID, dwOptionSetMask: DWORD, dwEnabledOptions: DWORD): HRESULT {.stdcall.}
  LPOBJECTSAFETY* = ptr IObjectSafety
  OCPFIPARAMS* {.pure.} = object
    cbStructSize*: ULONG
    hWndOwner*: HWND
    x*: int32
    y*: int32
    lpszCaption*: LPCOLESTR
    cObjects*: ULONG
    lplpUnk*: ptr LPUNKNOWN
    cPages*: ULONG
    lpPages*: ptr CLSID
    lcid*: LCID
    dispidInitialProperty*: DISPID
  LPOCPFIPARAMS* = ptr OCPFIPARAMS
  FONTDESC* {.pure.} = object
    cbSizeofstruct*: UINT
    lpstrName*: LPOLESTR
    cySize*: CY
    sWeight*: SHORT
    sCharset*: SHORT
    fItalic*: WINBOOL
    fUnderline*: WINBOOL
    fStrikethrough*: WINBOOL
  LPFONTDESC* = ptr FONTDESC
  PICTDESC_UNION1_bmp* {.pure.} = object
    hbitmap*: HBITMAP
    hpal*: HPALETTE
  PICTDESC_UNION1_wmf* {.pure.} = object
    hmeta*: HMETAFILE
    xExt*: int32
    yExt*: int32
  PICTDESC_UNION1_icon* {.pure.} = object
    hicon*: HICON
  PICTDESC_UNION1_emf* {.pure.} = object
    hemf*: HENHMETAFILE
  PICTDESC_UNION1* {.pure, union.} = object
    bmp*: PICTDESC_UNION1_bmp
    wmf*: PICTDESC_UNION1_wmf
    icon*: PICTDESC_UNION1_icon
    emf*: PICTDESC_UNION1_emf
  PICTDESC* {.pure.} = object
    cbSizeofstruct*: UINT
    picType*: UINT
    union1*: PICTDESC_UNION1
  LPPICTDESC* = ptr PICTDESC
  OLE_XPOS_CONTAINER* = float32
  OLE_YPOS_CONTAINER* = float32
  OLE_XSIZE_CONTAINER* = float32
  OLE_YSIZE_CONTAINER* = float32
  OLE_OPTEXCLUSIVE* = VARIANT_BOOL
  OLE_CANCELBOOL* = VARIANT_BOOL
  OLE_ENABLEDEFAULTBOOL* = VARIANT_BOOL
  IActiveScriptParse64* {.pure.} = object
    lpVtbl*: ptr IActiveScriptParse64Vtbl
  IActiveScriptParse64Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InitNew*: proc(self: ptr IActiveScriptParse64): HRESULT {.stdcall.}
    AddScriptlet*: proc(self: ptr IActiveScriptParse64, pstrDefaultName: LPCOLESTR, pstrCode: LPCOLESTR, pstrItemName: LPCOLESTR, pstrSubItemName: LPCOLESTR, pstrEventName: LPCOLESTR, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORDLONG, ulStartingLineNumber: ULONG, dwFlags: DWORD, pbstrName: ptr BSTR, pexcepinfo: ptr EXCEPINFO): HRESULT {.stdcall.}
    ParseScriptText*: proc(self: ptr IActiveScriptParse64, pstrCode: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORDLONG, ulStartingLineNumber: ULONG, dwFlags: DWORD, pvarResult: ptr VARIANT, pexcepinfo: ptr EXCEPINFO): HRESULT {.stdcall.}
when winimCpu64:
  type
    IActiveScriptParse* = IActiveScriptParse64
type
  IActiveScriptParse32* {.pure.} = object
    lpVtbl*: ptr IActiveScriptParse32Vtbl
  IActiveScriptParse32Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InitNew*: proc(self: ptr IActiveScriptParse32): HRESULT {.stdcall.}
    AddScriptlet*: proc(self: ptr IActiveScriptParse32, pstrDefaultName: LPCOLESTR, pstrCode: LPCOLESTR, pstrItemName: LPCOLESTR, pstrSubItemName: LPCOLESTR, pstrEventName: LPCOLESTR, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORD, ulStartingLineNumber: ULONG, dwFlags: DWORD, pbstrName: ptr BSTR, pexcepinfo: ptr EXCEPINFO): HRESULT {.stdcall.}
    ParseScriptText*: proc(self: ptr IActiveScriptParse32, pstrCode: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORD, ulStartingLineNumber: ULONG, dwFlags: DWORD, pvarResult: ptr VARIANT, pexcepinfo: ptr EXCEPINFO): HRESULT {.stdcall.}
when winimCpu32:
  type
    IActiveScriptParse* = IActiveScriptParse32
type
  PIActiveScriptParse* = ptr IActiveScriptParse
  IActiveScriptParseProcedureOld64* {.pure.} = object
    lpVtbl*: ptr IActiveScriptParseProcedureOld64Vtbl
  IActiveScriptParseProcedureOld64Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParseProcedureText*: proc(self: ptr IActiveScriptParseProcedureOld64, pstrCode: LPCOLESTR, pstrFormalParams: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORDLONG, ulStartingLineNumber: ULONG, dwFlags: DWORD, ppdisp: ptr ptr IDispatch): HRESULT {.stdcall.}
when winimCpu64:
  type
    IActiveScriptParseProcedureOld* = IActiveScriptParseProcedureOld64
type
  IActiveScriptParseProcedureOld32* {.pure.} = object
    lpVtbl*: ptr IActiveScriptParseProcedureOld32Vtbl
  IActiveScriptParseProcedureOld32Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParseProcedureText*: proc(self: ptr IActiveScriptParseProcedureOld32, pstrCode: LPCOLESTR, pstrFormalParams: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORD, ulStartingLineNumber: ULONG, dwFlags: DWORD, ppdisp: ptr ptr IDispatch): HRESULT {.stdcall.}
when winimCpu32:
  type
    IActiveScriptParseProcedureOld* = IActiveScriptParseProcedureOld32
type
  PIActiveScriptParseProcedureOld* = ptr IActiveScriptParseProcedureOld
  IActiveScriptParseProcedure64* {.pure.} = object
    lpVtbl*: ptr IActiveScriptParseProcedure64Vtbl
  IActiveScriptParseProcedure64Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParseProcedureText*: proc(self: ptr IActiveScriptParseProcedure64, pstrCode: LPCOLESTR, pstrFormalParams: LPCOLESTR, pstrProcedureName: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORDLONG, ulStartingLineNumber: ULONG, dwFlags: DWORD, ppdisp: ptr ptr IDispatch): HRESULT {.stdcall.}
when winimCpu64:
  type
    IActiveScriptParseProcedure* = IActiveScriptParseProcedure64
type
  IActiveScriptParseProcedure32* {.pure.} = object
    lpVtbl*: ptr IActiveScriptParseProcedure32Vtbl
  IActiveScriptParseProcedure32Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParseProcedureText*: proc(self: ptr IActiveScriptParseProcedure32, pstrCode: LPCOLESTR, pstrFormalParams: LPCOLESTR, pstrProcedureName: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORD, ulStartingLineNumber: ULONG, dwFlags: DWORD, ppdisp: ptr ptr IDispatch): HRESULT {.stdcall.}
when winimCpu32:
  type
    IActiveScriptParseProcedure* = IActiveScriptParseProcedure32
type
  PIActiveScriptParseProcedure* = ptr IActiveScriptParseProcedure
  IActiveScriptParseProcedure2_64* {.pure.} = object
    lpVtbl*: ptr IActiveScriptParseProcedure2_64Vtbl
  IActiveScriptParseProcedure2_64Vtbl* {.pure, inheritable.} = object of IActiveScriptParseProcedure64Vtbl
when winimCpu64:
  type
    IActiveScriptParseProcedure2* = IActiveScriptParseProcedure2_64
type
  IActiveScriptParseProcedure2_32* {.pure.} = object
    lpVtbl*: ptr IActiveScriptParseProcedure2_32Vtbl
  IActiveScriptParseProcedure2_32Vtbl* {.pure, inheritable.} = object of IActiveScriptParseProcedure32Vtbl
when winimCpu32:
  type
    IActiveScriptParseProcedure2* = IActiveScriptParseProcedure2_32
type
  PIActiveScriptParseProcedure2* = ptr IActiveScriptParseProcedure2
  LPFNOLEUIHOOK* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): UINT {.stdcall.}
  TOLEUIINSERTOBJECTW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCWSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCWSTR
    hResource*: HRSRC
    clsid*: CLSID
    lpszFile*: LPWSTR
    cchFile*: UINT
    cClsidExclude*: UINT
    lpClsidExclude*: LPCLSID
    iid*: IID
    oleRender*: DWORD
    lpFormatEtc*: LPFORMATETC
    lpIOleClientSite*: LPOLECLIENTSITE
    lpIStorage*: LPSTORAGE
    ppvObj*: ptr LPVOID
    sc*: SCODE
    hMetaPict*: HGLOBAL
  POLEUIINSERTOBJECTW* = ptr TOLEUIINSERTOBJECTW
  LPOLEUIINSERTOBJECTW* = ptr TOLEUIINSERTOBJECTW
  TOLEUIINSERTOBJECTA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCSTR
    hResource*: HRSRC
    clsid*: CLSID
    lpszFile*: LPSTR
    cchFile*: UINT
    cClsidExclude*: UINT
    lpClsidExclude*: LPCLSID
    iid*: IID
    oleRender*: DWORD
    lpFormatEtc*: LPFORMATETC
    lpIOleClientSite*: LPOLECLIENTSITE
    lpIStorage*: LPSTORAGE
    ppvObj*: ptr LPVOID
    sc*: SCODE
    hMetaPict*: HGLOBAL
  POLEUIINSERTOBJECTA* = ptr TOLEUIINSERTOBJECTA
  LPOLEUIINSERTOBJECTA* = ptr TOLEUIINSERTOBJECTA
  OLEUIPASTEENTRYW* {.pure.} = object
    fmtetc*: FORMATETC
    lpstrFormatName*: LPCWSTR
    lpstrResultText*: LPCWSTR
    dwFlags*: DWORD
    dwScratchSpace*: DWORD
  POLEUIPASTEENTRYW* = ptr OLEUIPASTEENTRYW
  LPOLEUIPASTEENTRYW* = ptr OLEUIPASTEENTRYW
  OLEUIPASTEENTRYA* {.pure.} = object
    fmtetc*: FORMATETC
    lpstrFormatName*: LPCSTR
    lpstrResultText*: LPCSTR
    dwFlags*: DWORD
    dwScratchSpace*: DWORD
  POLEUIPASTEENTRYA* = ptr OLEUIPASTEENTRYA
  LPOLEUIPASTEENTRYA* = ptr OLEUIPASTEENTRYA
  TOLEUIPASTESPECIALW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCWSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCWSTR
    hResource*: HRSRC
    lpSrcDataObj*: LPDATAOBJECT
    arrPasteEntries*: LPOLEUIPASTEENTRYW
    cPasteEntries*: int32
    arrLinkTypes*: ptr UINT
    cLinkTypes*: int32
    cClsidExclude*: UINT
    lpClsidExclude*: LPCLSID
    nSelectedIndex*: int32
    fLink*: WINBOOL
    hMetaPict*: HGLOBAL
    sizel*: SIZEL
  POLEUIPASTESPECIALW* = ptr TOLEUIPASTESPECIALW
  LPOLEUIPASTESPECIALW* = ptr TOLEUIPASTESPECIALW
  TOLEUIPASTESPECIALA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCSTR
    hResource*: HRSRC
    lpSrcDataObj*: LPDATAOBJECT
    arrPasteEntries*: LPOLEUIPASTEENTRYA
    cPasteEntries*: int32
    arrLinkTypes*: ptr UINT
    cLinkTypes*: int32
    cClsidExclude*: UINT
    lpClsidExclude*: LPCLSID
    nSelectedIndex*: int32
    fLink*: WINBOOL
    hMetaPict*: HGLOBAL
    sizel*: SIZEL
  POLEUIPASTESPECIALA* = ptr TOLEUIPASTESPECIALA
  LPOLEUIPASTESPECIALA* = ptr TOLEUIPASTESPECIALA
  IOleUILinkContainerW* {.pure.} = object
    lpVtbl*: ptr IOleUILinkContainerWVtbl
  IOleUILinkContainerWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetNextLink*: proc(self: ptr IOleUILinkContainerW, dwLink: DWORD): DWORD {.stdcall.}
    SetLinkUpdateOptions*: proc(self: ptr IOleUILinkContainerW, dwLink: DWORD, dwUpdateOpt: DWORD): HRESULT {.stdcall.}
    GetLinkUpdateOptions*: proc(self: ptr IOleUILinkContainerW, dwLink: DWORD, lpdwUpdateOpt: ptr DWORD): HRESULT {.stdcall.}
    SetLinkSource*: proc(self: ptr IOleUILinkContainerW, dwLink: DWORD, lpszDisplayName: LPWSTR, lenFileName: ULONG, pchEaten: ptr ULONG, fValidateSource: WINBOOL): HRESULT {.stdcall.}
    GetLinkSource*: proc(self: ptr IOleUILinkContainerW, dwLink: DWORD, lplpszDisplayName: ptr LPWSTR, lplenFileName: ptr ULONG, lplpszFullLinkType: ptr LPWSTR, lplpszShortLinkType: ptr LPWSTR, lpfSourceAvailable: ptr WINBOOL, lpfIsSelected: ptr WINBOOL): HRESULT {.stdcall.}
    OpenLinkSource*: proc(self: ptr IOleUILinkContainerW, dwLink: DWORD): HRESULT {.stdcall.}
    UpdateLink*: proc(self: ptr IOleUILinkContainerW, dwLink: DWORD, fErrorMessage: WINBOOL, fReserved: WINBOOL): HRESULT {.stdcall.}
    CancelLink*: proc(self: ptr IOleUILinkContainerW, dwLink: DWORD): HRESULT {.stdcall.}
  LPOLEUILINKCONTAINERW* = ptr IOleUILinkContainerW
  IOleUILinkContainerA* {.pure.} = object
    lpVtbl*: ptr IOleUILinkContainerAVtbl
  IOleUILinkContainerAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetNextLink*: proc(self: ptr IOleUILinkContainerA, dwLink: DWORD): DWORD {.stdcall.}
    SetLinkUpdateOptions*: proc(self: ptr IOleUILinkContainerA, dwLink: DWORD, dwUpdateOpt: DWORD): HRESULT {.stdcall.}
    GetLinkUpdateOptions*: proc(self: ptr IOleUILinkContainerA, dwLink: DWORD, lpdwUpdateOpt: ptr DWORD): HRESULT {.stdcall.}
    SetLinkSource*: proc(self: ptr IOleUILinkContainerA, dwLink: DWORD, lpszDisplayName: LPSTR, lenFileName: ULONG, pchEaten: ptr ULONG, fValidateSource: WINBOOL): HRESULT {.stdcall.}
    GetLinkSource*: proc(self: ptr IOleUILinkContainerA, dwLink: DWORD, lplpszDisplayName: ptr LPSTR, lplenFileName: ptr ULONG, lplpszFullLinkType: ptr LPSTR, lplpszShortLinkType: ptr LPSTR, lpfSourceAvailable: ptr WINBOOL, lpfIsSelected: ptr WINBOOL): HRESULT {.stdcall.}
    OpenLinkSource*: proc(self: ptr IOleUILinkContainerA, dwLink: DWORD): HRESULT {.stdcall.}
    UpdateLink*: proc(self: ptr IOleUILinkContainerA, dwLink: DWORD, fErrorMessage: WINBOOL, fReserved: WINBOOL): HRESULT {.stdcall.}
    CancelLink*: proc(self: ptr IOleUILinkContainerA, dwLink: DWORD): HRESULT {.stdcall.}
  LPOLEUILINKCONTAINERA* = ptr IOleUILinkContainerA
  TOLEUIEDITLINKSW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCWSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCWSTR
    hResource*: HRSRC
    lpOleUILinkContainer*: LPOLEUILINKCONTAINERW
  POLEUIEDITLINKSW* = ptr TOLEUIEDITLINKSW
  LPOLEUIEDITLINKSW* = ptr TOLEUIEDITLINKSW
  TOLEUIEDITLINKSA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCSTR
    hResource*: HRSRC
    lpOleUILinkContainer*: LPOLEUILINKCONTAINERA
  POLEUIEDITLINKSA* = ptr TOLEUIEDITLINKSA
  LPOLEUIEDITLINKSA* = ptr TOLEUIEDITLINKSA
  TOLEUICHANGEICONW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCWSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCWSTR
    hResource*: HRSRC
    hMetaPict*: HGLOBAL
    clsid*: CLSID
    szIconExe*: array[MAX_PATH, WCHAR]
    cchIconExe*: int32
  POLEUICHANGEICONW* = ptr TOLEUICHANGEICONW
  LPOLEUICHANGEICONW* = ptr TOLEUICHANGEICONW
  TOLEUICHANGEICONA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCSTR
    hResource*: HRSRC
    hMetaPict*: HGLOBAL
    clsid*: CLSID
    szIconExe*: array[MAX_PATH, CHAR]
    cchIconExe*: int32
  POLEUICHANGEICONA* = ptr TOLEUICHANGEICONA
  LPOLEUICHANGEICONA* = ptr TOLEUICHANGEICONA
  TOLEUICONVERTW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCWSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCWSTR
    hResource*: HRSRC
    clsid*: CLSID
    clsidConvertDefault*: CLSID
    clsidActivateDefault*: CLSID
    clsidNew*: CLSID
    dvAspect*: DWORD
    wFormat*: WORD
    fIsLinkedObject*: WINBOOL
    hMetaPict*: HGLOBAL
    lpszUserType*: LPWSTR
    fObjectsIconChanged*: WINBOOL
    lpszDefLabel*: LPWSTR
    cClsidExclude*: UINT
    lpClsidExclude*: LPCLSID
  POLEUICONVERTW* = ptr TOLEUICONVERTW
  LPOLEUICONVERTW* = ptr TOLEUICONVERTW
  TOLEUICONVERTA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCSTR
    hResource*: HRSRC
    clsid*: CLSID
    clsidConvertDefault*: CLSID
    clsidActivateDefault*: CLSID
    clsidNew*: CLSID
    dvAspect*: DWORD
    wFormat*: WORD
    fIsLinkedObject*: WINBOOL
    hMetaPict*: HGLOBAL
    lpszUserType*: LPSTR
    fObjectsIconChanged*: WINBOOL
    lpszDefLabel*: LPSTR
    cClsidExclude*: UINT
    lpClsidExclude*: LPCLSID
  POLEUICONVERTA* = ptr TOLEUICONVERTA
  LPOLEUICONVERTA* = ptr TOLEUICONVERTA
  TOLEUIBUSYW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCWSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCWSTR
    hResource*: HRSRC
    hTask*: HTASK
    lphWndDialog*: ptr HWND
  POLEUIBUSYW* = ptr TOLEUIBUSYW
  LPOLEUIBUSYW* = ptr TOLEUIBUSYW
  TOLEUIBUSYA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCSTR
    hResource*: HRSRC
    hTask*: HTASK
    lphWndDialog*: ptr HWND
  POLEUIBUSYA* = ptr TOLEUIBUSYA
  LPOLEUIBUSYA* = ptr TOLEUIBUSYA
  TOLEUICHANGESOURCEW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCWSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCWSTR
    hResource*: HRSRC
    lpOFN*: ptr OPENFILENAMEW
    dwReserved1*: array[4, DWORD]
    lpOleUILinkContainer*: LPOLEUILINKCONTAINERW
    dwLink*: DWORD
    lpszDisplayName*: LPWSTR
    nFileLength*: ULONG
    lpszFrom*: LPWSTR
    lpszTo*: LPWSTR
  POLEUICHANGESOURCEW* = ptr TOLEUICHANGESOURCEW
  LPOLEUICHANGESOURCEW* = ptr TOLEUICHANGESOURCEW
  TOLEUICHANGESOURCEA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    hWndOwner*: HWND
    lpszCaption*: LPCSTR
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    hInstance*: HINSTANCE
    lpszTemplate*: LPCSTR
    hResource*: HRSRC
    lpOFN*: ptr OPENFILENAMEA
    dwReserved1*: array[4, DWORD]
    lpOleUILinkContainer*: LPOLEUILINKCONTAINERA
    dwLink*: DWORD
    lpszDisplayName*: LPSTR
    nFileLength*: ULONG
    lpszFrom*: LPSTR
    lpszTo*: LPSTR
  POLEUICHANGESOURCEA* = ptr TOLEUICHANGESOURCEA
  LPOLEUICHANGESOURCEA* = ptr TOLEUICHANGESOURCEA
  IOleUIObjInfoW* {.pure.} = object
    lpVtbl*: ptr IOleUIObjInfoWVtbl
  IOleUIObjInfoWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetObjectInfo*: proc(self: ptr IOleUIObjInfoW, dwObject: DWORD, lpdwObjSize: ptr DWORD, lplpszLabel: ptr LPWSTR, lplpszType: ptr LPWSTR, lplpszShortType: ptr LPWSTR, lplpszLocation: ptr LPWSTR): HRESULT {.stdcall.}
    GetConvertInfo*: proc(self: ptr IOleUIObjInfoW, dwObject: DWORD, lpClassID: ptr CLSID, lpwFormat: ptr WORD, lpConvertDefaultClassID: ptr CLSID, lplpClsidExclude: ptr LPCLSID, lpcClsidExclude: ptr UINT): HRESULT {.stdcall.}
    ConvertObject*: proc(self: ptr IOleUIObjInfoW, dwObject: DWORD, clsidNew: REFCLSID): HRESULT {.stdcall.}
    GetViewInfo*: proc(self: ptr IOleUIObjInfoW, dwObject: DWORD, phMetaPict: ptr HGLOBAL, pdvAspect: ptr DWORD, pnCurrentScale: ptr int32): HRESULT {.stdcall.}
    SetViewInfo*: proc(self: ptr IOleUIObjInfoW, dwObject: DWORD, hMetaPict: HGLOBAL, dvAspect: DWORD, nCurrentScale: int32, bRelativeToOrig: WINBOOL): HRESULT {.stdcall.}
  LPOLEUIOBJINFOW* = ptr IOleUIObjInfoW
  IOleUIObjInfoA* {.pure.} = object
    lpVtbl*: ptr IOleUIObjInfoAVtbl
  IOleUIObjInfoAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetObjectInfo*: proc(self: ptr IOleUIObjInfoA, dwObject: DWORD, lpdwObjSize: ptr DWORD, lplpszLabel: ptr LPSTR, lplpszType: ptr LPSTR, lplpszShortType: ptr LPSTR, lplpszLocation: ptr LPSTR): HRESULT {.stdcall.}
    GetConvertInfo*: proc(self: ptr IOleUIObjInfoA, dwObject: DWORD, lpClassID: ptr CLSID, lpwFormat: ptr WORD, lpConvertDefaultClassID: ptr CLSID, lplpClsidExclude: ptr LPCLSID, lpcClsidExclude: ptr UINT): HRESULT {.stdcall.}
    ConvertObject*: proc(self: ptr IOleUIObjInfoA, dwObject: DWORD, clsidNew: REFCLSID): HRESULT {.stdcall.}
    GetViewInfo*: proc(self: ptr IOleUIObjInfoA, dwObject: DWORD, phMetaPict: ptr HGLOBAL, pdvAspect: ptr DWORD, pnCurrentScale: ptr int32): HRESULT {.stdcall.}
    SetViewInfo*: proc(self: ptr IOleUIObjInfoA, dwObject: DWORD, hMetaPict: HGLOBAL, dvAspect: DWORD, nCurrentScale: int32, bRelativeToOrig: WINBOOL): HRESULT {.stdcall.}
  LPOLEUIOBJINFOA* = ptr IOleUIObjInfoA
  IOleUILinkInfoW* {.pure.} = object
    lpVtbl*: ptr IOleUILinkInfoWVtbl
  IOleUILinkInfoWVtbl* {.pure, inheritable.} = object of IOleUILinkContainerWVtbl
    GetLastUpdate*: proc(self: ptr IOleUILinkInfoW, dwLink: DWORD, lpLastUpdate: ptr FILETIME): HRESULT {.stdcall.}
  LPOLEUILINKINFOW* = ptr IOleUILinkInfoW
  IOleUILinkInfoA* {.pure.} = object
    lpVtbl*: ptr IOleUILinkInfoAVtbl
  IOleUILinkInfoAVtbl* {.pure, inheritable.} = object of IOleUILinkContainerAVtbl
    GetLastUpdate*: proc(self: ptr IOleUILinkInfoA, dwLink: DWORD, lpLastUpdate: ptr FILETIME): HRESULT {.stdcall.}
  LPOLEUILINKINFOA* = ptr IOleUILinkInfoA
  LPOLEUIGNRLPROPSW* = ptr OLEUIGNRLPROPSW
  OLEUIVIEWPROPSW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    dwReserved1*: array[2, DWORD]
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    dwReserved2*: array[3, DWORD]
    lpOP*: ptr OLEUIOBJECTPROPSW
    nScaleMin*: int32
    nScaleMax*: int32
  LPOLEUIVIEWPROPSW* = ptr OLEUIVIEWPROPSW
  OLEUILINKPROPSW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    dwReserved1*: array[2, DWORD]
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    dwReserved2*: array[3, DWORD]
    lpOP*: ptr OLEUIOBJECTPROPSW
  LPOLEUILINKPROPSW* = ptr OLEUILINKPROPSW
  OLEUIOBJECTPROPSW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    lpPS*: LPPROPSHEETHEADERW
    dwObject*: DWORD
    lpObjInfo*: LPOLEUIOBJINFOW
    dwLink*: DWORD
    lpLinkInfo*: LPOLEUILINKINFOW
    lpGP*: LPOLEUIGNRLPROPSW
    lpVP*: LPOLEUIVIEWPROPSW
    lpLP*: LPOLEUILINKPROPSW
  OLEUIGNRLPROPSW* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    dwReserved1*: array[2, DWORD]
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    dwReserved2*: array[3, DWORD]
    lpOP*: ptr OLEUIOBJECTPROPSW
  POLEUIGNRLPROPSW* = ptr OLEUIGNRLPROPSW
  LPOLEUIGNRLPROPSA* = ptr OLEUIGNRLPROPSA
  OLEUIVIEWPROPSA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    dwReserved1*: array[2, DWORD]
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    dwReserved2*: array[3, DWORD]
    lpOP*: ptr OLEUIOBJECTPROPSA
    nScaleMin*: int32
    nScaleMax*: int32
  LPOLEUIVIEWPROPSA* = ptr OLEUIVIEWPROPSA
  OLEUILINKPROPSA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    dwReserved1*: array[2, DWORD]
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    dwReserved2*: array[3, DWORD]
    lpOP*: ptr OLEUIOBJECTPROPSA
  LPOLEUILINKPROPSA* = ptr OLEUILINKPROPSA
  OLEUIOBJECTPROPSA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    lpPS*: LPPROPSHEETHEADERA
    dwObject*: DWORD
    lpObjInfo*: LPOLEUIOBJINFOA
    dwLink*: DWORD
    lpLinkInfo*: LPOLEUILINKINFOA
    lpGP*: LPOLEUIGNRLPROPSA
    lpVP*: LPOLEUIVIEWPROPSA
    lpLP*: LPOLEUILINKPROPSA
  OLEUIGNRLPROPSA* {.pure.} = object
    cbStruct*: DWORD
    dwFlags*: DWORD
    dwReserved1*: array[2, DWORD]
    lpfnHook*: LPFNOLEUIHOOK
    lCustData*: LPARAM
    dwReserved2*: array[3, DWORD]
    lpOP*: ptr OLEUIOBJECTPROPSA
  POLEUIGNRLPROPSA* = ptr OLEUIGNRLPROPSA
  POLEUIVIEWPROPSW* = ptr OLEUIVIEWPROPSW
  POLEUIVIEWPROPSA* = ptr OLEUIVIEWPROPSA
  POLEUILINKPROPSW* = ptr OLEUILINKPROPSW
  POLEUILINKPROPSA* = ptr OLEUILINKPROPSA
  POLEUIOBJECTPROPSW* = ptr OLEUIOBJECTPROPSW
  LPOLEUIOBJECTPROPSW* = ptr OLEUIOBJECTPROPSW
  POLEUIOBJECTPROPSA* = ptr OLEUIOBJECTPROPSA
  LPOLEUIOBJECTPROPSA* = ptr OLEUIOBJECTPROPSA
const
  LIBID_Accessibility* = DEFINE_GUID("1ea4dbf0-3c3b-11cf-810c-00aa00389b71")
  IID_IAccessibleHandler* = DEFINE_GUID("03022430-abc4-11d0-bde2-00aa001a1953")
  IID_IAccIdentity* = DEFINE_GUID("7852b78d-1cfd-41c1-a615-9c0c85960b5f")
  IID_IAccPropServer* = DEFINE_GUID("76c0dbbb-15e0-4e7b-b61b-20eeea2001e0")
  IID_IAccPropServices* = DEFINE_GUID("6e26e776-04f0-495d-80e4-3330352e3169")
  IID_IAccPropMgrInternal* = DEFINE_GUID("2bd370a9-3e7f-4edd-8a85-f8fed1f8e51f")
  CLSID_AccPropServices* = DEFINE_GUID("b5f8350b-0548-48b1-a6ee-88bd00b4a5e7")
  IIS_IsOleaccProxy* = DEFINE_GUID("902697fa-80e4-4560-802a-a13f22a64709")
  MSAA_MENU_SIG* = 0xAA0DF00D'i32
  PROPID_ACC_NAME* = DEFINE_GUID("608d3df8-8128-4aa7-a428-f55e49267291")
  PROPID_ACC_VALUE* = DEFINE_GUID("123fe443-211a-4615-9527-c45a7e93717a")
  PROPID_ACC_DESCRIPTION* = DEFINE_GUID("4d48dfe4-bd3f-491f-a648-492d6f20c588")
  PROPID_ACC_ROLE* = DEFINE_GUID("cb905ff2-7bd1-4c05-b3c8-e6c241364d70")
  PROPID_ACC_STATE* = DEFINE_GUID("a8d4d5b0-0a21-42d0-a5c0-514e984f457b")
  PROPID_ACC_HELP* = DEFINE_GUID("c831e11f-44db-4a99-9768-cb8f978b7231")
  PROPID_ACC_KEYBOARDSHORTCUT* = DEFINE_GUID("7d9bceee-7d1e-4979-9382-5180f4172c34")
  PROPID_ACC_DEFAULTACTION* = DEFINE_GUID("180c072b-c27f-43c7-9922-f63562a4632b")
  PROPID_ACC_HELPTOPIC* = DEFINE_GUID("787d1379-8ede-440b-8aec-11f7bf9030b3")
  PROPID_ACC_FOCUS* = DEFINE_GUID("6eb335df-1c29-4127-b12c-dee9fd157f2b")
  PROPID_ACC_SELECTION* = DEFINE_GUID("b99d073c-d731-405b-9061-d95e8f842984")
  PROPID_ACC_PARENT* = DEFINE_GUID("474c22b6-ffc2-467a-b1b5-e958b4657330")
  PROPID_ACC_NAV_UP* = DEFINE_GUID("016e1a2b-1a4e-4767-8612-3386f66935ec")
  PROPID_ACC_NAV_DOWN* = DEFINE_GUID("031670ed-3cdf-48d2-9613-138f2dd8a668")
  PROPID_ACC_NAV_LEFT* = DEFINE_GUID("228086cb-82f1-4a39-8705-dcdc0fff92f5")
  PROPID_ACC_NAV_RIGHT* = DEFINE_GUID("cd211d9f-e1cb-4fe5-a77c-920b884d095b")
  PROPID_ACC_NAV_PREV* = DEFINE_GUID("776d3891-c73b-4480-b3f6-076a16a15af6")
  PROPID_ACC_NAV_NEXT* = DEFINE_GUID("1cdc5455-8cd9-4c92-a371-3939a2fe3eee")
  PROPID_ACC_NAV_FIRSTCHILD* = DEFINE_GUID("cfd02558-557b-4c67-84f9-2a09fce40749")
  PROPID_ACC_NAV_LASTCHILD* = DEFINE_GUID("302ecaa5-48d5-4f8d-b671-1a8d20a77832")
  PROPID_ACC_ROLEMAP* = DEFINE_GUID("f79acda2-140d-4fe6-8914-208476328269")
  PROPID_ACC_VALUEMAP* = DEFINE_GUID("da1c3d79-fc5c-420e-b399-9d1533549e75")
  PROPID_ACC_STATEMAP* = DEFINE_GUID("43946c5e-0ac0-4042-b525-07bbdbe17fa7")
  PROPID_ACC_DESCRIPTIONMAP* = DEFINE_GUID("1ff1435f-8a14-477b-b226-a0abe279975d")
  PROPID_ACC_DODEFAULTACTION* = DEFINE_GUID("1ba09523-2e3b-49a6-a059-59682a3c48fd")
  NAVDIR_MIN* = 0
  NAVDIR_UP* = 0x1
  NAVDIR_DOWN* = 0x2
  NAVDIR_LEFT* = 0x3
  NAVDIR_RIGHT* = 0x4
  NAVDIR_NEXT* = 0x5
  NAVDIR_PREVIOUS* = 0x6
  NAVDIR_FIRSTCHILD* = 0x7
  NAVDIR_LASTCHILD* = 0x8
  NAVDIR_MAX* = 0x9
  SELFLAG_NONE* = 0
  SELFLAG_TAKEFOCUS* = 0x1
  SELFLAG_TAKESELECTION* = 0x2
  SELFLAG_EXTENDSELECTION* = 0x4
  SELFLAG_ADDSELECTION* = 0x8
  SELFLAG_REMOVESELECTION* = 0x10
  SELFLAG_VALID* = 0x1f
  STATE_SYSTEM_NORMAL* = 0
  STATE_SYSTEM_HASPOPUP* = 0x40000000
  ROLE_SYSTEM_TITLEBAR* = 0x1
  ROLE_SYSTEM_MENUBAR* = 0x2
  ROLE_SYSTEM_SCROLLBAR* = 0x3
  ROLE_SYSTEM_GRIP* = 0x4
  ROLE_SYSTEM_SOUND* = 0x5
  ROLE_SYSTEM_CURSOR* = 0x6
  ROLE_SYSTEM_CARET* = 0x7
  ROLE_SYSTEM_ALERT* = 0x8
  ROLE_SYSTEM_WINDOW* = 0x9
  ROLE_SYSTEM_CLIENT* = 0xa
  ROLE_SYSTEM_MENUPOPUP* = 0xb
  ROLE_SYSTEM_MENUITEM* = 0xc
  ROLE_SYSTEM_TOOLTIP* = 0xd
  ROLE_SYSTEM_APPLICATION* = 0xe
  ROLE_SYSTEM_DOCUMENT* = 0xf
  ROLE_SYSTEM_PANE* = 0x10
  ROLE_SYSTEM_CHART* = 0x11
  ROLE_SYSTEM_DIALOG* = 0x12
  ROLE_SYSTEM_BORDER* = 0x13
  ROLE_SYSTEM_GROUPING* = 0x14
  ROLE_SYSTEM_SEPARATOR* = 0x15
  ROLE_SYSTEM_TOOLBAR* = 0x16
  ROLE_SYSTEM_STATUSBAR* = 0x17
  ROLE_SYSTEM_TABLE* = 0x18
  ROLE_SYSTEM_COLUMNHEADER* = 0x19
  ROLE_SYSTEM_ROWHEADER* = 0x1a
  ROLE_SYSTEM_COLUMN* = 0x1b
  ROLE_SYSTEM_ROW* = 0x1c
  ROLE_SYSTEM_CELL* = 0x1d
  ROLE_SYSTEM_LINK* = 0x1e
  ROLE_SYSTEM_HELPBALLOON* = 0x1f
  ROLE_SYSTEM_CHARACTER* = 0x20
  ROLE_SYSTEM_LIST* = 0x21
  ROLE_SYSTEM_LISTITEM* = 0x22
  ROLE_SYSTEM_OUTLINE* = 0x23
  ROLE_SYSTEM_OUTLINEITEM* = 0x24
  ROLE_SYSTEM_PAGETAB* = 0x25
  ROLE_SYSTEM_PROPERTYPAGE* = 0x26
  ROLE_SYSTEM_INDICATOR* = 0x27
  ROLE_SYSTEM_GRAPHIC* = 0x28
  ROLE_SYSTEM_STATICTEXT* = 0x29
  ROLE_SYSTEM_TEXT* = 0x2a
  ROLE_SYSTEM_PUSHBUTTON* = 0x2b
  ROLE_SYSTEM_CHECKBUTTON* = 0x2c
  ROLE_SYSTEM_RADIOBUTTON* = 0x2d
  ROLE_SYSTEM_COMBOBOX* = 0x2e
  ROLE_SYSTEM_DROPLIST* = 0x2f
  ROLE_SYSTEM_PROGRESSBAR* = 0x30
  ROLE_SYSTEM_DIAL* = 0x31
  ROLE_SYSTEM_HOTKEYFIELD* = 0x32
  ROLE_SYSTEM_SLIDER* = 0x33
  ROLE_SYSTEM_SPINBUTTON* = 0x34
  ROLE_SYSTEM_DIAGRAM* = 0x35
  ROLE_SYSTEM_ANIMATION* = 0x36
  ROLE_SYSTEM_EQUATION* = 0x37
  ROLE_SYSTEM_BUTTONDROPDOWN* = 0x38
  ROLE_SYSTEM_BUTTONMENU* = 0x39
  ROLE_SYSTEM_BUTTONDROPDOWNGRID* = 0x3a
  ROLE_SYSTEM_WHITESPACE* = 0x3b
  ROLE_SYSTEM_PAGETABLIST* = 0x3c
  ROLE_SYSTEM_CLOCK* = 0x3d
  ROLE_SYSTEM_SPLITBUTTON* = 0x3e
  ROLE_SYSTEM_IPADDRESS* = 0x3f
  ROLE_SYSTEM_OUTLINEBUTTON* = 0x40
  DISPID_ACC_PARENT* = -5000
  DISPID_ACC_CHILDCOUNT* = -5001
  DISPID_ACC_CHILD* = -5002
  DISPID_ACC_NAME* = -5003
  DISPID_ACC_VALUE* = -5004
  DISPID_ACC_DESCRIPTION* = -5005
  DISPID_ACC_ROLE* = -5006
  DISPID_ACC_STATE* = -5007
  DISPID_ACC_HELP* = -5008
  DISPID_ACC_HELPTOPIC* = -5009
  DISPID_ACC_KEYBOARDSHORTCUT* = -5010
  DISPID_ACC_FOCUS* = -5011
  DISPID_ACC_SELECTION* = -5012
  DISPID_ACC_DEFAULTACTION* = -5013
  DISPID_ACC_SELECT* = -5014
  DISPID_ACC_LOCATION* = -5015
  DISPID_ACC_NAVIGATE* = -5016
  DISPID_ACC_HITTEST* = -5017
  DISPID_ACC_DODEFAULTACTION* = -5018
  IID_IAccessible* = DEFINE_GUID("618736e0-3c3d-11cf-810c-00aa00389b71")
  ANNO_THIS* = 0
  ANNO_CONTAINER* = 1
  INTERFACESAFE_FOR_UNTRUSTED_CALLER* = 0x00000001
  INTERFACESAFE_FOR_UNTRUSTED_DATA* = 0x00000002
  INTERFACE_USES_DISPEX* = 0x00000004
  INTERFACE_USES_SECURITY_MANAGER* = 0x00000008
  IID_IObjectSafety* = DEFINE_GUID("cb5bdc81-93c1-11cf-8f20-00805f2cd064")
  CLSID_CFontPropPage* = DEFINE_GUID("0be35200-8f91-11ce-9de3-00aa004bb851")
  CLSID_CColorPropPage* = DEFINE_GUID("0be35201-8f91-11ce-9de3-00aa004bb851")
  CLSID_CPicturePropPage* = DEFINE_GUID("0be35202-8f91-11ce-9de3-00aa004bb851")
  CLSID_PersistPropset* = DEFINE_GUID("fb8f0821-0164-101b-84ed-08002b2ec713")
  CLSID_ConvertVBX* = DEFINE_GUID("fb8f0822-0164-101b-84ed-08002b2ec713")
  CLSID_StdFont* = DEFINE_GUID("0be35203-8f91-11ce-9de3-00aa004bb851")
  CLSID_StdPicture* = DEFINE_GUID("0be35204-8f91-11ce-9de3-00aa004bb851")
  GUID_HIMETRIC* = DEFINE_GUID("66504300-be0f-101a-8bbb-00aa00300cab")
  GUID_COLOR* = DEFINE_GUID("66504301-be0f-101a-8bbb-00aa00300cab")
  GUID_XPOSPIXEL* = DEFINE_GUID("66504302-be0f-101a-8bbb-00aa00300cab")
  GUID_YPOSPIXEL* = DEFINE_GUID("66504303-be0f-101a-8bbb-00aa00300cab")
  GUID_XSIZEPIXEL* = DEFINE_GUID("66504304-be0f-101a-8bbb-00aa00300cab")
  GUID_YSIZEPIXEL* = DEFINE_GUID("66504305-be0f-101a-8bbb-00aa00300cab")
  GUID_XPOS* = DEFINE_GUID("66504306-be0f-101a-8bbb-00aa00300cab")
  GUID_YPOS* = DEFINE_GUID("66504307-be0f-101a-8bbb-00aa00300cab")
  GUID_XSIZE* = DEFINE_GUID("66504308-be0f-101a-8bbb-00aa00300cab")
  GUID_YSIZE* = DEFINE_GUID("66504309-be0f-101a-8bbb-00aa00300cab")
  GUID_TRISTATE* = DEFINE_GUID("6650430a-be0f-101a-8bbb-00aa00300cab")
  GUID_OPTIONVALUEEXCLUSIVE* = DEFINE_GUID("6650430b-be0f-101a-8bbb-00aa00300cab")
  GUID_CHECKVALUEEXCLUSIVE* = DEFINE_GUID("6650430c-be0f-101a-8bbb-00aa00300cab")
  GUID_FONTNAME* = DEFINE_GUID("6650430d-be0f-101a-8bbb-00aa00300cab")
  GUID_FONTSIZE* = DEFINE_GUID("6650430e-be0f-101a-8bbb-00aa00300cab")
  GUID_FONTBOLD* = DEFINE_GUID("6650430f-be0f-101a-8bbb-00aa00300cab")
  GUID_FONTITALIC* = DEFINE_GUID("66504310-be0f-101a-8bbb-00aa00300cab")
  GUID_FONTUNDERSCORE* = DEFINE_GUID("66504311-be0f-101a-8bbb-00aa00300cab")
  GUID_FONTSTRIKETHROUGH* = DEFINE_GUID("66504312-be0f-101a-8bbb-00aa00300cab")
  GUID_HANDLE* = DEFINE_GUID("66504313-be0f-101a-8bbb-00aa00300cab")
  PICTYPE_UNINITIALIZED* = -1
  PICTYPE_NONE* = 0
  PICTYPE_BITMAP* = 1
  PICTYPE_METAFILE* = 2
  PICTYPE_ICON* = 3
  PICTYPE_ENHMETAFILE* = 4
  triUnchecked* = 0
  triChecked* = 1
  triGray* = 2
template STD_CTL_SCODE*(n: untyped): HRESULT = MAKE_SCODE(SEVERITY_ERROR, FACILITY_CONTROL, n)
const
  CTL_E_ILLEGALFUNCTIONCALL* = STD_CTL_SCODE(5)
  CTL_E_OVERFLOW* = STD_CTL_SCODE(6)
  CTL_E_OUTOFMEMORY* = STD_CTL_SCODE(7)
  CTL_E_DIVISIONBYZERO* = STD_CTL_SCODE(11)
  CTL_E_OUTOFSTRINGSPACE* = STD_CTL_SCODE(14)
  CTL_E_OUTOFSTACKSPACE* = STD_CTL_SCODE(28)
  CTL_E_BADFILENAMEORNUMBER* = STD_CTL_SCODE(52)
  CTL_E_FILENOTFOUND* = STD_CTL_SCODE(53)
  CTL_E_BADFILEMODE* = STD_CTL_SCODE(54)
  CTL_E_FILEALREADYOPEN* = STD_CTL_SCODE(55)
  CTL_E_DEVICEIOERROR* = STD_CTL_SCODE(57)
  CTL_E_FILEALREADYEXISTS* = STD_CTL_SCODE(58)
  CTL_E_BADRECORDLENGTH* = STD_CTL_SCODE(59)
  CTL_E_DISKFULL* = STD_CTL_SCODE(61)
  CTL_E_BADRECORDNUMBER* = STD_CTL_SCODE(63)
  CTL_E_BADFILENAME* = STD_CTL_SCODE(64)
  CTL_E_TOOMANYFILES* = STD_CTL_SCODE(67)
  CTL_E_DEVICEUNAVAILABLE* = STD_CTL_SCODE(68)
  CTL_E_PERMISSIONDENIED* = STD_CTL_SCODE(70)
  CTL_E_DISKNOTREADY* = STD_CTL_SCODE(71)
  CTL_E_PATHFILEACCESSERROR* = STD_CTL_SCODE(75)
  CTL_E_PATHNOTFOUND* = STD_CTL_SCODE(76)
  CTL_E_INVALIDPATTERNSTRING* = STD_CTL_SCODE(93)
  CTL_E_INVALIDUSEOFNULL* = STD_CTL_SCODE(94)
  CTL_E_INVALIDFILEFORMAT* = STD_CTL_SCODE(321)
  CTL_E_INVALIDPROPERTYVALUE* = STD_CTL_SCODE(380)
  CTL_E_INVALIDPROPERTYARRAYINDEX* = STD_CTL_SCODE(381)
  CTL_E_SETNOTSUPPORTEDATRUNTIME* = STD_CTL_SCODE(382)
  CTL_E_SETNOTSUPPORTED* = STD_CTL_SCODE(383)
  CTL_E_NEEDPROPERTYARRAYINDEX* = STD_CTL_SCODE(385)
  CTL_E_SETNOTPERMITTED* = STD_CTL_SCODE(387)
  CTL_E_GETNOTSUPPORTEDATRUNTIME* = STD_CTL_SCODE(393)
  CTL_E_GETNOTSUPPORTED* = STD_CTL_SCODE(394)
  CTL_E_PROPERTYNOTFOUND* = STD_CTL_SCODE(422)
  CTL_E_INVALIDCLIPBOARDFORMAT* = STD_CTL_SCODE(460)
  CTL_E_INVALIDPICTURE* = STD_CTL_SCODE(481)
  CTL_E_PRINTERERROR* = STD_CTL_SCODE(482)
  CTL_E_CANTSAVEFILETOTEMP* = STD_CTL_SCODE(735)
  CTL_E_SEARCHTEXTNOTFOUND* = STD_CTL_SCODE(744)
  CTL_E_REPLACEMENTSTOOLONG* = STD_CTL_SCODE(746)
template CUSTOM_CTL_SCODE*(n: untyped): HRESULT = MAKE_SCODE(SEVERITY_ERROR, FACILITY_CONTROL, n)
const
  CTL_E_CUSTOM_FIRST* = CUSTOM_CTL_SCODE(600)
  CONNECT_E_FIRST* = MAKE_SCODE(SEVERITY_ERROR,FACILITY_ITF,0x0200)
  CONNECT_E_LAST* = MAKE_SCODE(SEVERITY_ERROR,FACILITY_ITF,0x020F)
  CONNECT_S_FIRST* = MAKE_SCODE(SEVERITY_SUCCESS,FACILITY_ITF,0x0200)
  CONNECT_S_LAST* = MAKE_SCODE(SEVERITY_SUCCESS,FACILITY_ITF,0x020F)
  CONNECT_E_NOCONNECTION* = CONNECT_E_FIRST+0
  CONNECT_E_ADVISELIMIT* = CONNECT_E_FIRST+1
  CONNECT_E_CANNOTCONNECT* = CONNECT_E_FIRST+2
  CONNECT_E_OVERRIDDEN* = CONNECT_E_FIRST+3
  SELFREG_E_FIRST* = MAKE_SCODE(SEVERITY_ERROR,FACILITY_ITF,0x0200)
  SELFREG_E_LAST* = MAKE_SCODE(SEVERITY_ERROR,FACILITY_ITF,0x020F)
  SELFREG_S_FIRST* = MAKE_SCODE(SEVERITY_SUCCESS,FACILITY_ITF,0x0200)
  SELFREG_S_LAST* = MAKE_SCODE(SEVERITY_SUCCESS,FACILITY_ITF,0x020F)
  SELFREG_E_TYPELIB* = SELFREG_E_FIRST+0
  SELFREG_E_CLASS* = SELFREG_E_FIRST+1
  PERPROP_E_FIRST* = MAKE_SCODE(SEVERITY_ERROR,FACILITY_ITF,0x0200)
  PERPROP_E_LAST* = MAKE_SCODE(SEVERITY_ERROR,FACILITY_ITF,0x020F)
  PERPROP_S_FIRST* = MAKE_SCODE(SEVERITY_SUCCESS,FACILITY_ITF,0x0200)
  PERPROP_S_LAST* = MAKE_SCODE(SEVERITY_SUCCESS,FACILITY_ITF,0x020F)
  PERPROP_E_NOPAGEAVAILABLE* = PERPROP_E_FIRST+0
  OLEIVERB_PROPERTIES* = -7
  VT_STREAMED_PROPSET* = 73
  VT_STORED_PROPSET* = 74
  VT_BLOB_PROPSET* = 75
  VT_VERBOSE_ENUM* = 76
  VT_COLOR* = VT_I4
  VT_XPOS_PIXELS* = VT_I4
  VT_YPOS_PIXELS* = VT_I4
  VT_XSIZE_PIXELS* = VT_I4
  VT_YSIZE_PIXELS* = VT_I4
  VT_XPOS_HIMETRIC* = VT_I4
  VT_YPOS_HIMETRIC* = VT_I4
  VT_XSIZE_HIMETRIC* = VT_I4
  VT_YSIZE_HIMETRIC* = VT_I4
  VT_TRISTATE* = VT_I2
  VT_OPTEXCLUSIVE* = VT_BOOL
  VT_FONT* = VT_DISPATCH
  VT_PICTURE* = VT_DISPATCH
  VT_HANDLE* = VT_I4
  OCM_BASE* = WM_USER+0x1c00
  OCM_COMMAND* = OCM_BASE+WM_COMMAND
  OCM_CTLCOLORBTN* = OCM_BASE+WM_CTLCOLORBTN
  OCM_CTLCOLOREDIT* = OCM_BASE+WM_CTLCOLOREDIT
  OCM_CTLCOLORDLG* = OCM_BASE+WM_CTLCOLORDLG
  OCM_CTLCOLORLISTBOX* = OCM_BASE+WM_CTLCOLORLISTBOX
  OCM_CTLCOLORMSGBOX* = OCM_BASE+WM_CTLCOLORMSGBOX
  OCM_CTLCOLORSCROLLBAR* = OCM_BASE+WM_CTLCOLORSCROLLBAR
  OCM_CTLCOLORSTATIC* = OCM_BASE+WM_CTLCOLORSTATIC
  OCM_DRAWITEM* = OCM_BASE+WM_DRAWITEM
  OCM_MEASUREITEM* = OCM_BASE+WM_MEASUREITEM
  OCM_DELETEITEM* = OCM_BASE+WM_DELETEITEM
  OCM_VKEYTOITEM* = OCM_BASE+WM_VKEYTOITEM
  OCM_CHARTOITEM* = OCM_BASE+WM_CHARTOITEM
  OCM_COMPAREITEM* = OCM_BASE+WM_COMPAREITEM
  OCM_HSCROLL* = OCM_BASE+WM_HSCROLL
  OCM_VSCROLL* = OCM_BASE+WM_VSCROLL
  OCM_PARENTNOTIFY* = OCM_BASE+WM_PARENTNOTIFY
  OCM_NOTIFY* = OCM_BASE+WM_NOTIFY
  LP_DEFAULT* = 0x00
  LP_MONOCHROME* = 0x01
  LP_VGACOLOR* = 0x02
  LP_COLOR* = 0x04
  DISPID_AUTOSIZE* = -500
  DISPID_BACKCOLOR* = -501
  DISPID_BACKSTYLE* = -502
  DISPID_BORDERCOLOR* = -503
  DISPID_BORDERSTYLE* = -504
  DISPID_BORDERWIDTH* = -505
  DISPID_DRAWMODE* = -507
  DISPID_DRAWSTYLE* = -508
  DISPID_DRAWWIDTH* = -509
  DISPID_FILLCOLOR* = -510
  DISPID_FILLSTYLE* = -511
  DISPID_FONT* = -512
  DISPID_FORECOLOR* = -513
  DISPID_ENABLED* = -514
  DISPID_HWND* = -515
  DISPID_TABSTOP* = -516
  DISPID_TEXT* = -517
  DISPID_CAPTION* = -518
  DISPID_BORDERVISIBLE* = -519
  DISPID_APPEARANCE* = -520
  DISPID_MOUSEPOINTER* = -521
  DISPID_MOUSEICON* = -522
  DISPID_PICTURE* = -523
  DISPID_VALID* = -524
  DISPID_READYSTATE* = -525
  DISPID_LISTINDEX* = -526
  DISPID_SELECTED* = -527
  DISPID_LIST* = -528
  DISPID_COLUMN* = -529
  DISPID_LISTCOUNT* = -531
  DISPID_MULTISELECT* = -532
  DISPID_MAXLENGTH* = -533
  DISPID_PASSWORDCHAR* = -534
  DISPID_SCROLLBARS* = -535
  DISPID_WORDWRAP* = -536
  DISPID_MULTILINE* = -537
  DISPID_NUMBEROFROWS* = -538
  DISPID_NUMBEROFCOLUMNS* = -539
  DISPID_DISPLAYSTYLE* = -540
  DISPID_GROUPNAME* = -541
  DISPID_IMEMODE* = -542
  DISPID_ACCELERATOR* = -543
  DISPID_ENTERKEYBEHAVIOR* = -544
  DISPID_TABKEYBEHAVIOR* = -545
  DISPID_SELTEXT* = -546
  DISPID_SELSTART* = -547
  DISPID_SELLENGTH* = -548
  DISPID_REFRESH* = -550
  DISPID_DOCLICK* = -551
  DISPID_ABOUTBOX* = -552
  DISPID_ADDITEM* = -553
  DISPID_CLEAR* = -554
  DISPID_REMOVEITEM* = -555
  DISPID_CLICK* = -600
  DISPID_DBLCLICK* = -601
  DISPID_KEYDOWN* = -602
  DISPID_KEYPRESS* = -603
  DISPID_KEYUP* = -604
  DISPID_MOUSEDOWN* = -605
  DISPID_MOUSEMOVE* = -606
  DISPID_MOUSEUP* = -607
  DISPID_ERROREVENT* = -608
  DISPID_READYSTATECHANGE* = -609
  DISPID_CLICK_VALUE* = -610
  DISPID_RIGHTTOLEFT* = -611
  DISPID_TOPTOBOTTOM* = -612
  DISPID_THIS* = -613
  DISPID_AMBIENT_BACKCOLOR* = -701
  DISPID_AMBIENT_DISPLAYNAME* = -702
  DISPID_AMBIENT_FONT* = -703
  DISPID_AMBIENT_FORECOLOR* = -704
  DISPID_AMBIENT_LOCALEID* = -705
  DISPID_AMBIENT_MESSAGEREFLECT* = -706
  DISPID_AMBIENT_SCALEUNITS* = -707
  DISPID_AMBIENT_TEXTALIGN* = -708
  DISPID_AMBIENT_USERMODE* = -709
  DISPID_AMBIENT_UIDEAD* = -710
  DISPID_AMBIENT_SHOWGRABHANDLES* = -711
  DISPID_AMBIENT_SHOWHATCHING* = -712
  DISPID_AMBIENT_DISPLAYASDEFAULT* = -713
  DISPID_AMBIENT_SUPPORTSMNEMONICS* = -714
  DISPID_AMBIENT_AUTOCLIP* = -715
  DISPID_AMBIENT_APPEARANCE* = -716
  DISPID_AMBIENT_CODEPAGE* = -725
  DISPID_AMBIENT_PALETTE* = -726
  DISPID_AMBIENT_CHARSET* = -727
  DISPID_AMBIENT_TRANSFERPRIORITY* = -728
  DISPID_AMBIENT_RIGHTTOLEFT* = -732
  DISPID_AMBIENT_TOPTOBOTTOM* = -733
  DISPID_Name* = -800
  DISPID_Delete* = -801
  DISPID_Object* = -802
  DISPID_Parent* = -803
  DISPID_FONT_NAME* = 0
  DISPID_FONT_SIZE* = 2
  DISPID_FONT_BOLD* = 3
  DISPID_FONT_ITALIC* = 4
  DISPID_FONT_UNDER* = 5
  DISPID_FONT_STRIKE* = 6
  DISPID_FONT_WEIGHT* = 7
  DISPID_FONT_CHARSET* = 8
  DISPID_FONT_CHANGED* = 9
  DISPID_PICT_HANDLE* = 0
  DISPID_PICT_HPAL* = 2
  DISPID_PICT_TYPE* = 3
  DISPID_PICT_WIDTH* = 4
  DISPID_PICT_HEIGHT* = 5
  DISPID_PICT_RENDER* = 6
  CATID_ActiveScript* = DEFINE_GUID("f0b7a1a1-9847-11cf-8f20-00805f2cd064")
  CATID_ActiveScriptParse* = DEFINE_GUID("f0b7a1a2-9847-11cf-8f20-00805f2cd064")
  CATID_ActiveScriptEncode* = DEFINE_GUID("f0b7a1a3-9847-11cf-8f20-00805f2cd064")
  OID_VBSSIP* = DEFINE_GUID("1629f04e-2799-4db5-8fe5-ace10f17ebab")
  OID_JSSIP* = DEFINE_GUID("06c9e010-38ce-11d4-a2a3-00104bd35090")
  OID_WSFSIP* = DEFINE_GUID("1a610570-38ce-11d4-a2a3-00104bd35090")
  SCRIPTITEM_ISVISIBLE* = 0x00000002
  SCRIPTITEM_ISSOURCE* = 0x00000004
  SCRIPTITEM_GLOBALMEMBERS* = 0x00000008
  SCRIPTITEM_ISPERSISTENT* = 0x00000040
  SCRIPTITEM_CODEONLY* = 0x00000200
  SCRIPTITEM_NOCODE* = 0x00000400
  SCRIPTITEM_ALL_FLAGS* = SCRIPTITEM_ISSOURCE or SCRIPTITEM_ISVISIBLE or SCRIPTITEM_ISPERSISTENT or SCRIPTITEM_GLOBALMEMBERS or SCRIPTITEM_NOCODE or SCRIPTITEM_CODEONLY
  SCRIPTTYPELIB_ISCONTROL* = 0x00000010
  SCRIPTTYPELIB_ISPERSISTENT* = 0x00000040
  SCRIPTTYPELIB_ALL_FLAGS* = SCRIPTTYPELIB_ISCONTROL or SCRIPTTYPELIB_ISPERSISTENT
  SCRIPTTEXT_DELAYEXECUTION* = 0x00000001
  SCRIPTTEXT_ISVISIBLE* = 0x00000002
  SCRIPTTEXT_ISEXPRESSION* = 0x00000020
  SCRIPTTEXT_ISPERSISTENT* = 0x00000040
  SCRIPTTEXT_HOSTMANAGESSOURCE* = 0x00000080
  SCRIPTTEXT_ISXDOMAIN* = 0x00000100
  SCRIPTTEXT_ALL_FLAGS* = SCRIPTTEXT_DELAYEXECUTION or SCRIPTTEXT_ISVISIBLE or SCRIPTTEXT_ISEXPRESSION or SCRIPTTEXT_ISPERSISTENT or SCRIPTTEXT_HOSTMANAGESSOURCE or SCRIPTTEXT_ISXDOMAIN
  SCRIPTPROC_ISEXPRESSION* = 0x00000020
  SCRIPTPROC_HOSTMANAGESSOURCE* = 0x00000080
  SCRIPTPROC_IMPLICIT_THIS* = 0x00000100
  SCRIPTPROC_IMPLICIT_PARENTS* = 0x00000200
  SCRIPTPROC_ISXDOMAIN* = 0x00000400
  SCRIPTPROC_ALL_FLAGS* = SCRIPTPROC_HOSTMANAGESSOURCE or SCRIPTPROC_ISEXPRESSION or SCRIPTPROC_IMPLICIT_THIS or SCRIPTPROC_IMPLICIT_PARENTS or SCRIPTPROC_ISXDOMAIN
  SCRIPTINFO_IUNKNOWN* = 0x00000001
  SCRIPTINFO_ITYPEINFO* = 0x00000002
  SCRIPTINFO_ALL_FLAGS* = SCRIPTINFO_IUNKNOWN or SCRIPTINFO_ITYPEINFO
  SCRIPTINTERRUPT_DEBUG* = 0x00000001
  SCRIPTINTERRUPT_RAISEEXCEPTION* = 0x00000002
  SCRIPTINTERRUPT_ALL_FLAGS* = SCRIPTINTERRUPT_DEBUG or SCRIPTINTERRUPT_RAISEEXCEPTION
  SCRIPTSTAT_STATEMENT_COUNT* = 0x1
  SCRIPTSTAT_INSTRUCTION_COUNT* = 0x2
  SCRIPTSTAT_INTSTRUCTION_TIME* = 0x3
  SCRIPTSTAT_TOTAL_TIME* = 0x4
  SCRIPT_ENCODE_SECTION* = 0x1
  SCRIPT_ENCODE_DEFAULT_LANGUAGE* = 0x1
  SCRIPT_ENCODE_NO_ASP_LANGUAGE* = 0x2
  SCRIPTPROP_NAME* = 0x0
  SCRIPTPROP_MAJORVERSION* = 0x1
  SCRIPTPROP_MINORVERSION* = 0x2
  SCRIPTPROP_BUILDNUMBER* = 0x3
  SCRIPTPROP_DELAYEDEVENTSINKING* = 0x1000
  SCRIPTPROP_CATCHEXCEPTION* = 0x1001
  SCRIPTPROP_CONVERSIONLCID* = 0x1002
  SCRIPTPROP_HOSTSTACKREQUIRED* = 0x1003
  SCRIPTPROP_DEBUGGER* = 0x1100
  SCRIPTPROP_JITDEBUG* = 0x1101
  SCRIPTPROP_GCCONTROLSOFTCLOSE* = 0x2000
  SCRIPTPROP_INTEGERMODE* = 0x3000
  SCRIPTPROP_STRINGCOMPAREINSTANCE* = 0x3001
  SCRIPTPROP_INVOKEVERSIONING* = 0x4000
  SCRIPTPROP_HACK_FIBERSUPPORT* = 0x70000000
  SCRIPTPROP_HACK_TRIDENTEVENTSINK* = 0x70000001
  SCRIPTPROP_ABBREVIATE_GLOBALNAME_RESOLUTION* = 0x70000002
  SCRIPTPROP_HOSTKEEPALIVE* = 0x70000004
  SCRIPT_E_RECORDED* = 0x86664004'i32
  SCRIPT_E_REPORTED* = 0x80020101'i32
  SCRIPT_E_PROPAGATE* = 0x80020102'i32
  SCRIPTLANGUAGEVERSION_DEFAULT* = 0
  SCRIPTLANGUAGEVERSION_5_7* = 1
  SCRIPTLANGUAGEVERSION_5_8* = 2
  SCRIPTLANGUAGEVERSION_MAX* = 255
  SCRIPTSTATE_UNINITIALIZED* = 0
  SCRIPTSTATE_INITIALIZED* = 5
  SCRIPTSTATE_STARTED* = 1
  SCRIPTSTATE_CONNECTED* = 2
  SCRIPTSTATE_DISCONNECTED* = 3
  SCRIPTSTATE_CLOSED* = 4
  SCRIPTTRACEINFO_SCRIPTSTART* = 0
  SCRIPTTRACEINFO_SCRIPTEND* = 1
  SCRIPTTRACEINFO_COMCALLSTART* = 2
  SCRIPTTRACEINFO_COMCALLEND* = 3
  SCRIPTTRACEINFO_CREATEOBJSTART* = 4
  SCRIPTTRACEINFO_CREATEOBJEND* = 5
  SCRIPTTRACEINFO_GETOBJSTART* = 6
  SCRIPTTRACEINFO_GETOBJEND* = 7
  SCRIPTTHREADSTATE_NOTINSCRIPT* = 0
  SCRIPTTHREADSTATE_RUNNING* = 1
  SCRIPTGCTYPE_NORMAL* = 0
  SCRIPTGCTYPE_EXHAUSTIVE* = 1
  SCRIPTUICITEM_INPUTBOX* = 1
  SCRIPTUICITEM_MSGBOX* = 2
  SCRIPTUICHANDLING_ALLOW* = 0
  SCRIPTUICHANDLING_NOUIERROR* = 1
  SCRIPTUICHANDLING_NOUIDEFAULT* = 2
  SCRIPTTHREADID_CURRENT* = SCRIPTTHREADID(-1)
  SCRIPTTHREADID_BASE* = SCRIPTTHREADID(-2)
  SCRIPTTHREADID_ALL* = SCRIPTTHREADID(-3)
  IID_IActiveScriptSite* = DEFINE_GUID("db01a1e3-a42b-11cf-8f20-00805f2cd064")
  IID_IActiveScriptError* = DEFINE_GUID("eae1ba61-a4ed-11cf-8f20-00805f2cd064")
  IID_IActiveScriptError64* = DEFINE_GUID("b21fb2a1-5b8f-4963-8c21-21450f84ed7f")
  IID_IActiveScriptSiteWindow* = DEFINE_GUID("d10f6761-83e9-11cf-8f20-00805f2cd064")
  IID_IActiveScriptSiteUIControl* = DEFINE_GUID("aedae97e-d7ee-4796-b960-7f092ae844ab")
  IID_IActiveScriptSiteInterruptPoll* = DEFINE_GUID("539698a0-cdca-11cf-a5eb-00aa0047a063")
  IID_IActiveScript* = DEFINE_GUID("bb1a2ae1-a4f9-11cf-8f20-00805f2cd064")
  IID_IActiveScriptParse32* = DEFINE_GUID("bb1a2ae2-a4f9-11cf-8f20-00805f2cd064")
  IID_IActiveScriptParse64* = DEFINE_GUID("c7ef7658-e1ee-480e-97ea-d52cb4d76d17")
  IID_IActiveScriptParseProcedureOld32* = DEFINE_GUID("1cff0050-6fdd-11d0-9328-00a0c90dcaa9")
  IID_IActiveScriptParseProcedureOld64* = DEFINE_GUID("21f57128-08c9-4638-ba12-22d15d88dc5c")
  IID_IActiveScriptParseProcedure32* = DEFINE_GUID("aa5b6a80-b834-11d0-932f-00a0c90dcaa9")
  IID_IActiveScriptParseProcedure64* = DEFINE_GUID("c64713b6-e029-4cc5-9200-438b72890b6a")
  IID_IActiveScriptParseProcedure2_32* = DEFINE_GUID("71ee5b20-fb04-11d1-b3a8-00a0c911e8b2")
  IID_IActiveScriptParseProcedure2_64* = DEFINE_GUID("fe7c4271-210c-448d-9f54-76dab7047b28")
  IID_IActiveScriptEncode* = DEFINE_GUID("bb1a2ae3-a4f9-11cf-8f20-00805f2cd064")
  IID_IActiveScriptHostEncode* = DEFINE_GUID("bee9b76e-cfe3-11d1-b747-00c04fc2b085")
  IID_IBindEventHandler* = DEFINE_GUID("63cdbcb0-c1b1-11d0-9336-00a0c90dcaa9")
  IID_IActiveScriptStats* = DEFINE_GUID("b8da6310-e19b-11d0-933c-00a0c90dcaa9")
  IID_IActiveScriptProperty* = DEFINE_GUID("4954e0d0-fbc7-11d1-8410-006008c3fbfc")
  IID_ITridentEventSink* = DEFINE_GUID("1dc9ca50-06ef-11d2-8415-006008c3fbfc")
  IID_IActiveScriptGarbageCollector* = DEFINE_GUID("6aa2c4a0-2b53-11d4-a2a0-00104bd35090")
  IID_IActiveScriptSIPInfo* = DEFINE_GUID("764651d0-38de-11d4-a2a3-00104bd35090")
  IID_IActiveScriptSiteTraceInfo* = DEFINE_GUID("4b7272ae-1955-4bfe-98b0-780621888569")
  IID_IActiveScriptTraceInfo* = DEFINE_GUID("c35456e7-bebf-4a1b-86a9-24d56be8b369")
  IID_IActiveScriptStringCompare* = DEFINE_GUID("58562769-ed52-42f7-8403-4963514e1f11")
  IDC_OLEUIHELP* = 99
  IDC_IO_CREATENEW* = 2100
  IDC_IO_CREATEFROMFILE* = 2101
  IDC_IO_LINKFILE* = 2102
  IDC_IO_OBJECTTYPELIST* = 2103
  IDC_IO_DISPLAYASICON* = 2104
  IDC_IO_CHANGEICON* = 2105
  IDC_IO_FILE* = 2106
  IDC_IO_FILEDISPLAY* = 2107
  IDC_IO_RESULTIMAGE* = 2108
  IDC_IO_RESULTTEXT* = 2109
  IDC_IO_ICONDISPLAY* = 2110
  IDC_IO_OBJECTTYPETEXT* = 2111
  IDC_IO_FILETEXT* = 2112
  IDC_IO_FILETYPE* = 2113
  IDC_IO_INSERTCONTROL* = 2114
  IDC_IO_ADDCONTROL* = 2115
  IDC_IO_CONTROLTYPELIST* = 2116
  IDC_PS_PASTE* = 500
  IDC_PS_PASTELINK* = 501
  IDC_PS_SOURCETEXT* = 502
  IDC_PS_PASTELIST* = 503
  IDC_PS_PASTELINKLIST* = 504
  IDC_PS_DISPLAYLIST* = 505
  IDC_PS_DISPLAYASICON* = 506
  IDC_PS_ICONDISPLAY* = 507
  IDC_PS_CHANGEICON* = 508
  IDC_PS_RESULTIMAGE* = 509
  IDC_PS_RESULTTEXT* = 510
  IDC_CI_GROUP* = 120
  IDC_CI_CURRENT* = 121
  IDC_CI_CURRENTICON* = 122
  IDC_CI_DEFAULT* = 123
  IDC_CI_DEFAULTICON* = 124
  IDC_CI_FROMFILE* = 125
  IDC_CI_FROMFILEEDIT* = 126
  IDC_CI_ICONLIST* = 127
  IDC_CI_LABEL* = 128
  IDC_CI_LABELEDIT* = 129
  IDC_CI_BROWSE* = 130
  IDC_CI_ICONDISPLAY* = 131
  IDC_CV_OBJECTTYPE* = 150
  IDC_CV_DISPLAYASICON* = 152
  IDC_CV_CHANGEICON* = 153
  IDC_CV_ACTIVATELIST* = 154
  IDC_CV_CONVERTTO* = 155
  IDC_CV_ACTIVATEAS* = 156
  IDC_CV_RESULTTEXT* = 157
  IDC_CV_CONVERTLIST* = 158
  IDC_CV_ICONDISPLAY* = 165
  IDC_EL_CHANGESOURCE* = 201
  IDC_EL_AUTOMATIC* = 202
  IDC_EL_CANCELLINK* = 209
  IDC_EL_UPDATENOW* = 210
  IDC_EL_OPENSOURCE* = 211
  IDC_EL_MANUAL* = 212
  IDC_EL_LINKSOURCE* = 216
  IDC_EL_LINKTYPE* = 217
  IDC_EL_LINKSLISTBOX* = 206
  IDC_EL_COL1* = 220
  IDC_EL_COL2* = 221
  IDC_EL_COL3* = 222
  IDC_BZ_RETRY* = 600
  IDC_BZ_ICON* = 601
  IDC_BZ_MESSAGE1* = 602
  IDC_BZ_SWITCHTO* = 604
  IDC_UL_METER* = 1029
  IDC_UL_STOP* = 1030
  IDC_UL_PERCENT* = 1031
  IDC_UL_PROGRESS* = 1032
  IDC_PU_LINKS* = 900
  IDC_PU_TEXT* = 901
  IDC_PU_CONVERT* = 902
  IDC_PU_ICON* = 908
  IDC_GP_OBJECTNAME* = 1009
  IDC_GP_OBJECTTYPE* = 1010
  IDC_GP_OBJECTSIZE* = 1011
  IDC_GP_CONVERT* = 1013
  IDC_GP_OBJECTICON* = 1014
  IDC_GP_OBJECTLOCATION* = 1022
  IDC_VP_PERCENT* = 1000
  IDC_VP_CHANGEICON* = 1001
  IDC_VP_EDITABLE* = 1002
  IDC_VP_ASICON* = 1003
  IDC_VP_RELATIVE* = 1005
  IDC_VP_SPIN* = 1006
  IDC_VP_SCALETXT* = 1034
  IDC_VP_ICONDISPLAY* = 1021
  IDC_VP_RESULTIMAGE* = 1033
  IDC_LP_OPENSOURCE* = 1006
  IDC_LP_UPDATENOW* = 1007
  IDC_LP_BREAKLINK* = 1008
  IDC_LP_LINKSOURCE* = 1012
  IDC_LP_CHANGESOURCE* = 1015
  IDC_LP_AUTOMATIC* = 1016
  IDC_LP_MANUAL* = 1017
  IDC_LP_DATE* = 1018
  IDC_LP_TIME* = 1019
  IDD_INSERTOBJECT* = 1000
  IDD_CHANGEICON* = 1001
  IDD_CONVERT* = 1002
  IDD_PASTESPECIAL* = 1003
  IDD_EDITLINKS* = 1004
  IDD_BUSY* = 1006
  IDD_UPDATELINKS* = 1007
  IDD_CHANGESOURCE* = 1009
  IDD_INSERTFILEBROWSE* = 1010
  IDD_CHANGEICONBROWSE* = 1011
  IDD_CONVERTONLY* = 1012
  IDD_CHANGESOURCE4* = 1013
  IDD_GNRLPROPS* = 1100
  IDD_VIEWPROPS* = 1101
  IDD_LINKPROPS* = 1102
  IDD_CONVERT4* = 1103
  IDD_CONVERTONLY4* = 1104
  IDD_EDITLINKS4* = 1105
  IDD_GNRLPROPS4* = 1106
  IDD_LINKPROPS4* = 1107
  IDD_PASTESPECIAL4* = 1108
  IDD_CANNOTUPDATELINK* = 1008
  IDD_LINKSOURCEUNAVAILABLE* = 1020
  IDD_SERVERNOTFOUND* = 1023
  IDD_OUTOFMEMORY* = 1024
  IDD_SERVERNOTREGW* = 1021
  IDD_LINKTYPECHANGEDW* = 1022
  IDD_SERVERNOTREGA* = 1025
  IDD_LINKTYPECHANGEDA* = 1026
  OLESTDDELIM* = "\\"
  SZOLEUI_MSG_HELP* = "OLEUI_MSG_HELP"
  SZOLEUI_MSG_ENDDIALOG* = "OLEUI_MSG_ENDDIALOG"
  SZOLEUI_MSG_BROWSE* = "OLEUI_MSG_BROWSE"
  SZOLEUI_MSG_CHANGEICON* = "OLEUI_MSG_CHANGEICON"
  SZOLEUI_MSG_CLOSEBUSYDIALOG* = "OLEUI_MSG_CLOSEBUSYDIALOG"
  SZOLEUI_MSG_CONVERT* = "OLEUI_MSG_CONVERT"
  SZOLEUI_MSG_CHANGESOURCE* = "OLEUI_MSG_CHANGESOURCE"
  SZOLEUI_MSG_ADDCONTROL* = "OLEUI_MSG_ADDCONTRO"
  SZOLEUI_MSG_BROWSE_OFN* = "OLEUI_MSG_BROWSE_OFN"
  ID_BROWSE_CHANGEICON* = 1
  ID_BROWSE_INSERTFILE* = 2
  ID_BROWSE_ADDCONTROL* = 3
  ID_BROWSE_CHANGESOURCE* = 4
  OLEUI_FALSE* = 0
  OLEUI_SUCCESS* = 1
  OLEUI_OK* = 1
  OLEUI_CANCEL* = 2
  OLEUI_ERR_STANDARDMIN* = 100
  OLEUI_ERR_OLEMEMALLOC* = 100
  OLEUI_ERR_STRUCTURENULL* = 101
  OLEUI_ERR_STRUCTUREINVALID* = 102
  OLEUI_ERR_CBSTRUCTINCORRECT* = 103
  OLEUI_ERR_HWNDOWNERINVALID* = 104
  OLEUI_ERR_LPSZCAPTIONINVALID* = 105
  OLEUI_ERR_LPFNHOOKINVALID* = 106
  OLEUI_ERR_HINSTANCEINVALID* = 107
  OLEUI_ERR_LPSZTEMPLATEINVALID* = 108
  OLEUI_ERR_HRESOURCEINVALID* = 109
  OLEUI_ERR_FINDTEMPLATEFAILURE* = 110
  OLEUI_ERR_LOADTEMPLATEFAILURE* = 111
  OLEUI_ERR_DIALOGFAILURE* = 112
  OLEUI_ERR_LOCALMEMALLOC* = 113
  OLEUI_ERR_GLOBALMEMALLOC* = 114
  OLEUI_ERR_LOADSTRING* = 115
  OLEUI_ERR_STANDARDMAX* = 116
  IOF_SHOWHELP* = 0x00000001
  IOF_SELECTCREATENEW* = 0x00000002
  IOF_SELECTCREATEFROMFILE* = 0x00000004
  IOF_CHECKLINK* = 0x00000008
  IOF_CHECKDISPLAYASICON* = 0x00000010
  IOF_CREATENEWOBJECT* = 0x00000020
  IOF_CREATEFILEOBJECT* = 0x00000040
  IOF_CREATELINKOBJECT* = 0x00000080
  IOF_DISABLELINK* = 0x00000100
  IOF_VERIFYSERVERSEXIST* = 0x00000200
  IOF_DISABLEDISPLAYASICON* = 0x00000400
  IOF_HIDECHANGEICON* = 0x00000800
  IOF_SHOWINSERTCONTROL* = 0x00001000
  IOF_SELECTCREATECONTROL* = 0x00002000
  OLEUI_IOERR_LPSZFILEINVALID* = OLEUI_ERR_STANDARDMAX+0
  OLEUI_IOERR_LPSZLABELINVALID* = OLEUI_ERR_STANDARDMAX+1
  OLEUI_IOERR_HICONINVALID* = OLEUI_ERR_STANDARDMAX+2
  OLEUI_IOERR_LPFORMATETCINVALID* = OLEUI_ERR_STANDARDMAX+3
  OLEUI_IOERR_PPVOBJINVALID* = OLEUI_ERR_STANDARDMAX+4
  OLEUI_IOERR_LPIOLECLIENTSITEINVALID* = OLEUI_ERR_STANDARDMAX+5
  OLEUI_IOERR_LPISTORAGEINVALID* = OLEUI_ERR_STANDARDMAX+6
  OLEUI_IOERR_SCODEHASERROR* = OLEUI_ERR_STANDARDMAX+7
  OLEUI_IOERR_LPCLSIDEXCLUDEINVALID* = OLEUI_ERR_STANDARDMAX+8
  OLEUI_IOERR_CCHFILEINVALID* = OLEUI_ERR_STANDARDMAX+9
  OLEUIPASTE_ENABLEICON* = 2048
  OLEUIPASTE_PASTEONLY* = 0
  OLEUIPASTE_PASTE* = 512
  OLEUIPASTE_LINKANYTYPE* = 1024
  OLEUIPASTE_LINKTYPE1* = 1
  OLEUIPASTE_LINKTYPE2* = 2
  OLEUIPASTE_LINKTYPE3* = 4
  OLEUIPASTE_LINKTYPE4* = 8
  OLEUIPASTE_LINKTYPE5* = 16
  OLEUIPASTE_LINKTYPE6* = 32
  OLEUIPASTE_LINKTYPE7* = 64
  OLEUIPASTE_LINKTYPE8* = 128
  PS_MAXLINKTYPES* = 8
  PSF_SHOWHELP* = 0x00000001
  PSF_SELECTPASTE* = 0x00000002
  PSF_SELECTPASTELINK* = 0x00000004
  PSF_CHECKDISPLAYASICON* = 0x00000008
  PSF_DISABLEDISPLAYASICON* = 0x00000010
  PSF_HIDECHANGEICON* = 0x00000020
  PSF_STAYONCLIPBOARDCHANGE* = 0x00000040
  PSF_NOREFRESHDATAOBJECT* = 0x00000080
  OLEUI_IOERR_SRCDATAOBJECTINVALID* = OLEUI_ERR_STANDARDMAX+0
  OLEUI_IOERR_ARRPASTEENTRIESINVALID* = OLEUI_ERR_STANDARDMAX+1
  OLEUI_IOERR_ARRLINKTYPESINVALID* = OLEUI_ERR_STANDARDMAX+2
  OLEUI_PSERR_CLIPBOARDCHANGED* = OLEUI_ERR_STANDARDMAX+3
  OLEUI_PSERR_GETCLIPBOARDFAILED* = OLEUI_ERR_STANDARDMAX+4
  OLEUI_ELERR_LINKCNTRNULL* = OLEUI_ERR_STANDARDMAX+0
  OLEUI_ELERR_LINKCNTRINVALID* = OLEUI_ERR_STANDARDMAX+1
  ELF_SHOWHELP* = 0x00000001
  ELF_DISABLEUPDATENOW* = 0x00000002
  ELF_DISABLEOPENSOURCE* = 0x00000004
  ELF_DISABLECHANGESOURCE* = 0x00000008
  ELF_DISABLECANCELLINK* = 0x00000010
  CIF_SHOWHELP* = 0x00000001
  CIF_SELECTCURRENT* = 0x00000002
  CIF_SELECTDEFAULT* = 0x00000004
  CIF_SELECTFROMFILE* = 0x00000008
  CIF_USEICONEXE* = 0x00000010
  OLEUI_CIERR_MUSTHAVECLSID* = OLEUI_ERR_STANDARDMAX+0
  OLEUI_CIERR_MUSTHAVECURRENTMETAFILE* = OLEUI_ERR_STANDARDMAX+1
  OLEUI_CIERR_SZICONEXEINVALID* = OLEUI_ERR_STANDARDMAX+2
  PROP_HWND_CHGICONDLG* = "HWND_CIDLG"
  CF_SHOWHELPBUTTON* = 0x00000001
  CF_SETCONVERTDEFAULT* = 0x00000002
  CF_SETACTIVATEDEFAULT* = 0x00000004
  CF_SELECTCONVERTTO* = 0x00000008
  CF_SELECTACTIVATEAS* = 0x00000010
  CF_DISABLEDISPLAYASICON* = 0x00000020
  CF_DISABLEACTIVATEAS* = 0x00000040
  CF_HIDECHANGEICON* = 0x00000080
  CF_CONVERTONLY* = 0x00000100
  OLEUI_CTERR_CLASSIDINVALID* = OLEUI_ERR_STANDARDMAX+1
  OLEUI_CTERR_DVASPECTINVALID* = OLEUI_ERR_STANDARDMAX+2
  OLEUI_CTERR_CBFORMATINVALID* = OLEUI_ERR_STANDARDMAX+3
  OLEUI_CTERR_HMETAPICTINVALID* = OLEUI_ERR_STANDARDMAX+4
  OLEUI_CTERR_STRINGINVALID* = OLEUI_ERR_STANDARDMAX+5
  BZ_DISABLECANCELBUTTON* = 0x00000001
  BZ_DISABLESWITCHTOBUTTON* = 0x00000002
  BZ_DISABLERETRYBUTTON* = 0x00000004
  BZ_NOTRESPONDINGDIALOG* = 0x00000008
  OLEUI_BZERR_HTASKINVALID* = OLEUI_ERR_STANDARDMAX+0
  OLEUI_BZ_SWITCHTOSELECTED* = OLEUI_ERR_STANDARDMAX+1
  OLEUI_BZ_RETRYSELECTED* = OLEUI_ERR_STANDARDMAX+2
  OLEUI_BZ_CALLUNBLOCKED* = OLEUI_ERR_STANDARDMAX+3
  CSF_SHOWHELP* = 0x00000001
  CSF_VALIDSOURCE* = 0x00000002
  CSF_ONLYGETSOURCE* = 0x00000004
  CSF_EXPLORER* = 0x00000008
  OLEUI_CSERR_LINKCNTRNULL* = OLEUI_ERR_STANDARDMAX+0
  OLEUI_CSERR_LINKCNTRINVALID* = OLEUI_ERR_STANDARDMAX+1
  OLEUI_CSERR_FROMNOTNULL* = OLEUI_ERR_STANDARDMAX+2
  OLEUI_CSERR_TONOTNULL* = OLEUI_ERR_STANDARDMAX+3
  OLEUI_CSERR_SOURCENULL* = OLEUI_ERR_STANDARDMAX+4
  OLEUI_CSERR_SOURCEINVALID* = OLEUI_ERR_STANDARDMAX+5
  OLEUI_CSERR_SOURCEPARSERROR* = OLEUI_ERR_STANDARDMAX+6
  OLEUI_CSERR_SOURCEPARSEERROR* = OLEUI_ERR_STANDARDMAX+6
  VPF_SELECTRELATIVE* = 0x00000001
  VPF_DISABLERELATIVE* = 0x00000002
  VPF_DISABLESCALE* = 0x00000004
  OPF_OBJECTISLINK* = 0x00000001
  OPF_NOFILLDEFAULT* = 0x00000002
  OPF_SHOWHELP* = 0x00000004
  OPF_DISABLECONVERT* = 0x00000008
  OLEUI_OPERR_SUBPROPNULL* = OLEUI_ERR_STANDARDMAX+0
  OLEUI_OPERR_SUBPROPINVALID* = OLEUI_ERR_STANDARDMAX+1
  OLEUI_OPERR_PROPSHEETNULL* = OLEUI_ERR_STANDARDMAX+2
  OLEUI_OPERR_PROPSHEETINVALID* = OLEUI_ERR_STANDARDMAX+3
  OLEUI_OPERR_SUPPROP* = OLEUI_ERR_STANDARDMAX+4
  OLEUI_OPERR_PROPSINVALID* = OLEUI_ERR_STANDARDMAX+5
  OLEUI_OPERR_PAGESINCORRECT* = OLEUI_ERR_STANDARDMAX+6
  OLEUI_OPERR_INVALIDPAGES* = OLEUI_ERR_STANDARDMAX+7
  OLEUI_OPERR_NOTSUPPORTED* = OLEUI_ERR_STANDARDMAX+8
  OLEUI_OPERR_DLGPROCNOTNULL* = OLEUI_ERR_STANDARDMAX+9
  OLEUI_OPERR_LPARAMNOTZERO* = OLEUI_ERR_STANDARDMAX+10
  OLEUI_GPERR_STRINGINVALID* = OLEUI_ERR_STANDARDMAX+11
  OLEUI_GPERR_CLASSIDINVALID* = OLEUI_ERR_STANDARDMAX+12
  OLEUI_GPERR_LPCLSIDEXCLUDEINVALID* = OLEUI_ERR_STANDARDMAX+13
  OLEUI_GPERR_CBFORMATINVALID* = OLEUI_ERR_STANDARDMAX+14
  OLEUI_VPERR_METAPICTINVALID* = OLEUI_ERR_STANDARDMAX+15
  OLEUI_VPERR_DVASPECTINVALID* = OLEUI_ERR_STANDARDMAX+16
  OLEUI_LPERR_LINKCNTRNULL* = OLEUI_ERR_STANDARDMAX+17
  OLEUI_LPERR_LINKCNTRINVALID* = OLEUI_ERR_STANDARDMAX+18
  OLEUI_OPERR_PROPERTYSHEET* = OLEUI_ERR_STANDARDMAX+19
  OLEUI_OPERR_OBJINFOINVALID* = OLEUI_ERR_STANDARDMAX+20
  OLEUI_OPERR_LINKINFOINVALID* = OLEUI_ERR_STANDARDMAX+21
  OLEUI_QUERY_GETCLASSID* = 0xFF00
  OLEUI_QUERY_LINKBROKEN* = 0xFF01
type
  LPFNLRESULTFROMOBJECT* = proc (riid: REFIID, wParam: WPARAM, punk: LPUNKNOWN): LRESULT {.stdcall.}
  LPFNOBJECTFROMLRESULT* = proc (lResult: LRESULT, riid: REFIID, wParam: WPARAM, ppvObject: ptr pointer): HRESULT {.stdcall.}
  LPFNACCESSIBLEOBJECTFROMWINDOW* = proc (hwnd: HWND, dwId: DWORD, riid: REFIID, ppvObject: ptr pointer): HRESULT {.stdcall.}
  LPFNACCESSIBLEOBJECTFROMPOINT* = proc (ptScreen: POINT, ppacc: ptr ptr IAccessible, pvarChild: ptr VARIANT): HRESULT {.stdcall.}
  LPFNCREATESTDACCESSIBLEOBJECT* = proc (hwnd: HWND, idObject: LONG, riid: REFIID, ppvObject: ptr pointer): HRESULT {.stdcall.}
  LPFNACCESSIBLECHILDREN* = proc (paccContainer: ptr IAccessible, iChildStart: LONG, cChildren: LONG, rgvarChildren: ptr VARIANT, pcObtained: ptr LONG): HRESULT {.stdcall.}
  IAccIdentity* {.pure.} = object
    lpVtbl*: ptr IAccIdentityVtbl
  IAccIdentityVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetIdentityString*: proc(self: ptr IAccIdentity, dwIDChild: DWORD, ppIDString: ptr ptr BYTE, pdwIDStringLen: ptr DWORD): HRESULT {.stdcall.}
  IAccPropServer* {.pure.} = object
    lpVtbl*: ptr IAccPropServerVtbl
  IAccPropServerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPropValue*: proc(self: ptr IAccPropServer, pIDString: ptr BYTE, dwIDStringLen: DWORD, idProp: MSAAPROPID, pvarValue: ptr VARIANT, pfHasProp: ptr WINBOOL): HRESULT {.stdcall.}
  IAccPropServices* {.pure.} = object
    lpVtbl*: ptr IAccPropServicesVtbl
  IAccPropServicesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetPropValue*: proc(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, idProp: MSAAPROPID, `var`: VARIANT): HRESULT {.stdcall.}
    SetPropServer*: proc(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, paProps: ptr MSAAPROPID, cProps: int32, pServer: ptr IAccPropServer, annoScope: AnnoScope): HRESULT {.stdcall.}
    ClearProps*: proc(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, paProps: ptr MSAAPROPID, cProps: int32): HRESULT {.stdcall.}
    SetHwndProp*: proc(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, idProp: MSAAPROPID, `var`: VARIANT): HRESULT {.stdcall.}
    SetHwndPropStr*: proc(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, idProp: MSAAPROPID, str: LPCWSTR): HRESULT {.stdcall.}
    SetHwndPropServer*: proc(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, paProps: ptr MSAAPROPID, cProps: int32, pServer: ptr IAccPropServer, annoScope: AnnoScope): HRESULT {.stdcall.}
    ClearHwndProps*: proc(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, paProps: ptr MSAAPROPID, cProps: int32): HRESULT {.stdcall.}
    ComposeHwndIdentityString*: proc(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, ppIDString: ptr ptr BYTE, pdwIDStringLen: ptr DWORD): HRESULT {.stdcall.}
    DecomposeHwndIdentityString*: proc(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, phwnd: ptr HWND, pidObject: ptr DWORD, pidChild: ptr DWORD): HRESULT {.stdcall.}
    SetHmenuProp*: proc(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, idProp: MSAAPROPID, `var`: VARIANT): HRESULT {.stdcall.}
    SetHmenuPropStr*: proc(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, idProp: MSAAPROPID, str: LPCWSTR): HRESULT {.stdcall.}
    SetHmenuPropServer*: proc(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, paProps: ptr MSAAPROPID, cProps: int32, pServer: ptr IAccPropServer, annoScope: AnnoScope): HRESULT {.stdcall.}
    ClearHmenuProps*: proc(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, paProps: ptr MSAAPROPID, cProps: int32): HRESULT {.stdcall.}
    ComposeHmenuIdentityString*: proc(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, ppIDString: ptr ptr BYTE, pdwIDStringLen: ptr DWORD): HRESULT {.stdcall.}
    DecomposeHmenuIdentityString*: proc(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, phmenu: ptr HMENU, pidChild: ptr DWORD): HRESULT {.stdcall.}
  IActiveScriptError* {.pure.} = object
    lpVtbl*: ptr IActiveScriptErrorVtbl
  IActiveScriptErrorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetExceptionInfo*: proc(self: ptr IActiveScriptError, pexcepinfo: ptr EXCEPINFO): HRESULT {.stdcall.}
    GetSourcePosition*: proc(self: ptr IActiveScriptError, pdwSourceContext: ptr DWORD, pulLineNumber: ptr ULONG, plCharacterPosition: ptr LONG): HRESULT {.stdcall.}
    GetSourceLineText*: proc(self: ptr IActiveScriptError, pbstrSourceLine: ptr BSTR): HRESULT {.stdcall.}
  IActiveScriptSite* {.pure.} = object
    lpVtbl*: ptr IActiveScriptSiteVtbl
  IActiveScriptSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetLCID*: proc(self: ptr IActiveScriptSite, plcid: ptr LCID): HRESULT {.stdcall.}
    GetItemInfo*: proc(self: ptr IActiveScriptSite, pstrName: LPCOLESTR, dwReturnMask: DWORD, ppiunkItem: ptr ptr IUnknown, ppti: ptr ptr ITypeInfo): HRESULT {.stdcall.}
    GetDocVersionString*: proc(self: ptr IActiveScriptSite, pbstrVersion: ptr BSTR): HRESULT {.stdcall.}
    OnScriptTerminate*: proc(self: ptr IActiveScriptSite, pvarResult: ptr VARIANT, pexcepinfo: ptr EXCEPINFO): HRESULT {.stdcall.}
    OnStateChange*: proc(self: ptr IActiveScriptSite, ssScriptState: TSCRIPTSTATE): HRESULT {.stdcall.}
    OnScriptError*: proc(self: ptr IActiveScriptSite, pscripterror: ptr IActiveScriptError): HRESULT {.stdcall.}
    OnEnterScript*: proc(self: ptr IActiveScriptSite): HRESULT {.stdcall.}
    OnLeaveScript*: proc(self: ptr IActiveScriptSite): HRESULT {.stdcall.}
  IActiveScriptError64* {.pure.} = object
    lpVtbl*: ptr IActiveScriptError64Vtbl
  IActiveScriptError64Vtbl* {.pure, inheritable.} = object of IActiveScriptErrorVtbl
    GetSourcePosition64*: proc(self: ptr IActiveScriptError64, pdwSourceContext: ptr DWORDLONG, pulLineNumber: ptr ULONG, plCharacterPosition: ptr LONG): HRESULT {.stdcall.}
  IActiveScriptSiteWindow* {.pure.} = object
    lpVtbl*: ptr IActiveScriptSiteWindowVtbl
  IActiveScriptSiteWindowVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetWindow*: proc(self: ptr IActiveScriptSiteWindow, phwnd: ptr HWND): HRESULT {.stdcall.}
    EnableModeless*: proc(self: ptr IActiveScriptSiteWindow, fEnable: WINBOOL): HRESULT {.stdcall.}
  IActiveScriptSiteUIControl* {.pure.} = object
    lpVtbl*: ptr IActiveScriptSiteUIControlVtbl
  IActiveScriptSiteUIControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetUIBehavior*: proc(self: ptr IActiveScriptSiteUIControl, UicItem: SCRIPTUICITEM, pUicHandling: ptr SCRIPTUICHANDLING): HRESULT {.stdcall.}
  IActiveScriptSiteInterruptPoll* {.pure.} = object
    lpVtbl*: ptr IActiveScriptSiteInterruptPollVtbl
  IActiveScriptSiteInterruptPollVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryContinue*: proc(self: ptr IActiveScriptSiteInterruptPoll): HRESULT {.stdcall.}
  IActiveScript* {.pure.} = object
    lpVtbl*: ptr IActiveScriptVtbl
  IActiveScriptVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetScriptSite*: proc(self: ptr IActiveScript, pass: ptr IActiveScriptSite): HRESULT {.stdcall.}
    GetScriptSite*: proc(self: ptr IActiveScript, riid: REFIID, ppvObject: ptr pointer): HRESULT {.stdcall.}
    SetScriptState*: proc(self: ptr IActiveScript, ss: TSCRIPTSTATE): HRESULT {.stdcall.}
    GetScriptState*: proc(self: ptr IActiveScript, pssState: ptr TSCRIPTSTATE): HRESULT {.stdcall.}
    Close*: proc(self: ptr IActiveScript): HRESULT {.stdcall.}
    AddNamedItem*: proc(self: ptr IActiveScript, pstrName: LPCOLESTR, dwFlags: DWORD): HRESULT {.stdcall.}
    AddTypeLib*: proc(self: ptr IActiveScript, rguidTypeLib: REFGUID, dwMajor: DWORD, dwMinor: DWORD, dwFlags: DWORD): HRESULT {.stdcall.}
    GetScriptDispatch*: proc(self: ptr IActiveScript, pstrItemName: LPCOLESTR, ppdisp: ptr ptr IDispatch): HRESULT {.stdcall.}
    GetCurrentScriptThreadID*: proc(self: ptr IActiveScript, pstidThread: ptr SCRIPTTHREADID): HRESULT {.stdcall.}
    GetScriptThreadID*: proc(self: ptr IActiveScript, dwWin32ThreadId: DWORD, pstidThread: ptr SCRIPTTHREADID): HRESULT {.stdcall.}
    GetScriptThreadState*: proc(self: ptr IActiveScript, stidThread: SCRIPTTHREADID, pstsState: ptr SCRIPTTHREADSTATE): HRESULT {.stdcall.}
    InterruptScriptThread*: proc(self: ptr IActiveScript, stidThread: SCRIPTTHREADID, pexcepinfo: ptr EXCEPINFO, dwFlags: DWORD): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IActiveScript, ppscript: ptr ptr IActiveScript): HRESULT {.stdcall.}
  IActiveScriptEncode* {.pure.} = object
    lpVtbl*: ptr IActiveScriptEncodeVtbl
  IActiveScriptEncodeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EncodeSection*: proc(self: ptr IActiveScriptEncode, pchIn: LPCOLESTR, cchIn: DWORD, pchOut: LPOLESTR, cchOut: DWORD, pcchRet: ptr DWORD): HRESULT {.stdcall.}
    DecodeScript*: proc(self: ptr IActiveScriptEncode, pchIn: LPCOLESTR, cchIn: DWORD, pchOut: LPOLESTR, cchOut: DWORD, pcchRet: ptr DWORD): HRESULT {.stdcall.}
    GetEncodeProgId*: proc(self: ptr IActiveScriptEncode, pbstrOut: ptr BSTR): HRESULT {.stdcall.}
  IActiveScriptHostEncode* {.pure.} = object
    lpVtbl*: ptr IActiveScriptHostEncodeVtbl
  IActiveScriptHostEncodeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EncodeScriptHostFile*: proc(self: ptr IActiveScriptHostEncode, bstrInFile: BSTR, pbstrOutFile: ptr BSTR, cFlags: ULONG, bstrDefaultLang: BSTR): HRESULT {.stdcall.}
  IBindEventHandler* {.pure.} = object
    lpVtbl*: ptr IBindEventHandlerVtbl
  IBindEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    BindHandler*: proc(self: ptr IBindEventHandler, pstrEvent: LPCOLESTR, pdisp: ptr IDispatch): HRESULT {.stdcall.}
  IActiveScriptStats* {.pure.} = object
    lpVtbl*: ptr IActiveScriptStatsVtbl
  IActiveScriptStatsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetStat*: proc(self: ptr IActiveScriptStats, stid: DWORD, pluHi: ptr ULONG, pluLo: ptr ULONG): HRESULT {.stdcall.}
    GetStatEx*: proc(self: ptr IActiveScriptStats, guid: REFGUID, pluHi: ptr ULONG, pluLo: ptr ULONG): HRESULT {.stdcall.}
    ResetStats*: proc(self: ptr IActiveScriptStats): HRESULT {.stdcall.}
  IActiveScriptProperty* {.pure.} = object
    lpVtbl*: ptr IActiveScriptPropertyVtbl
  IActiveScriptPropertyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetProperty*: proc(self: ptr IActiveScriptProperty, dwProperty: DWORD, pvarIndex: ptr VARIANT, pvarValue: ptr VARIANT): HRESULT {.stdcall.}
    SetProperty*: proc(self: ptr IActiveScriptProperty, dwProperty: DWORD, pvarIndex: ptr VARIANT, pvarValue: ptr VARIANT): HRESULT {.stdcall.}
  ITridentEventSink* {.pure.} = object
    lpVtbl*: ptr ITridentEventSinkVtbl
  ITridentEventSinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FireEvent*: proc(self: ptr ITridentEventSink, pstrEvent: LPCOLESTR, pdp: ptr DISPPARAMS, pvarRes: ptr VARIANT, pei: ptr EXCEPINFO): HRESULT {.stdcall.}
  IActiveScriptGarbageCollector* {.pure.} = object
    lpVtbl*: ptr IActiveScriptGarbageCollectorVtbl
  IActiveScriptGarbageCollectorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CollectGarbage*: proc(self: ptr IActiveScriptGarbageCollector, scriptgctype: SCRIPTGCTYPE): HRESULT {.stdcall.}
  IActiveScriptSIPInfo* {.pure.} = object
    lpVtbl*: ptr IActiveScriptSIPInfoVtbl
  IActiveScriptSIPInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSIPOID*: proc(self: ptr IActiveScriptSIPInfo, poid_sip: ptr GUID): HRESULT {.stdcall.}
  IActiveScriptSiteTraceInfo* {.pure.} = object
    lpVtbl*: ptr IActiveScriptSiteTraceInfoVtbl
  IActiveScriptSiteTraceInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SendScriptTraceInfo*: proc(self: ptr IActiveScriptSiteTraceInfo, stiEventType: SCRIPTTRACEINFO, guidContextID: GUID, dwScriptContextCookie: DWORD, lScriptStatementStart: LONG, lScriptStatementEnd: LONG, dwReserved: DWORD64): HRESULT {.stdcall.}
  IActiveScriptTraceInfo* {.pure.} = object
    lpVtbl*: ptr IActiveScriptTraceInfoVtbl
  IActiveScriptTraceInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StartScriptTracing*: proc(self: ptr IActiveScriptTraceInfo, pSiteTraceInfo: ptr IActiveScriptSiteTraceInfo, guidContextID: GUID): HRESULT {.stdcall.}
    StopScriptTracing*: proc(self: ptr IActiveScriptTraceInfo): HRESULT {.stdcall.}
  IActiveScriptStringCompare* {.pure.} = object
    lpVtbl*: ptr IActiveScriptStringCompareVtbl
  IActiveScriptStringCompareVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StrComp*: proc(self: ptr IActiveScriptStringCompare, bszStr1: BSTR, bszStr2: BSTR, iRet: ptr LONG): HRESULT {.stdcall.}
proc LresultFromObject*(riid: REFIID, wParam: WPARAM, punk: LPUNKNOWN): LRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc ObjectFromLresult*(lResult: LRESULT, riid: REFIID, wParam: WPARAM, ppvObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc WindowFromAccessibleObject*(P1: ptr IAccessible, phwnd: ptr HWND): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc AccessibleObjectFromWindow*(hwnd: HWND, dwId: DWORD, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc AccessibleObjectFromEvent*(hwnd: HWND, dwId: DWORD, dwChildId: DWORD, ppacc: ptr ptr IAccessible, pvarChild: ptr VARIANT): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc AccessibleObjectFromPoint*(ptScreen: POINT, ppacc: ptr ptr IAccessible, pvarChild: ptr VARIANT): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc AccessibleChildren*(paccContainer: ptr IAccessible, iChildStart: LONG, cChildren: LONG, rgvarChildren: ptr VARIANT, pcObtained: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc GetRoleTextA*(lRole: DWORD, lpszRole: LPSTR, cchRoleMax: UINT): UINT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc GetRoleTextW*(lRole: DWORD, lpszRole: LPWSTR, cchRoleMax: UINT): UINT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc GetStateTextA*(lStateBit: DWORD, lpszState: LPSTR, cchState: UINT): UINT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc GetStateTextW*(lStateBit: DWORD, lpszState: LPWSTR, cchState: UINT): UINT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc GetOleaccVersionInfo*(pVer: ptr DWORD, pBuild: ptr DWORD): VOID {.winapi, stdcall, dynlib: "oleacc", importc.}
proc CreateStdAccessibleObject*(hwnd: HWND, idObject: LONG, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc CreateStdAccessibleProxyA*(hwnd: HWND, pClassName: LPCSTR, idObject: LONG, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc CreateStdAccessibleProxyW*(hwnd: HWND, pClassName: LPCWSTR, idObject: LONG, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc.}
proc DllRegisterServer*(): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc DllUnregisterServer*(): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc OleCreatePropertyFrame*(hwndOwner: HWND, x: UINT, y: UINT, lpszCaption: LPCOLESTR, cObjects: ULONG, ppUnk: ptr LPUNKNOWN, cPages: ULONG, pPageClsID: LPCLSID, lcid: LCID, dwReserved: DWORD, pvReserved: LPVOID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleCreatePropertyFrameIndirect*(lpParams: LPOCPFIPARAMS): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleTranslateColor*(clr: OLE_COLOR, hpal: HPALETTE, lpcolorref: ptr COLORREF): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleCreateFontIndirect*(lpFontDesc: LPFONTDESC, riid: REFIID, lplpvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleCreatePictureIndirect*(lpPictDesc: LPPICTDESC, riid: REFIID, fOwn: WINBOOL, lplpvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleLoadPicture*(lpstream: LPSTREAM, lSize: LONG, fRunmode: WINBOOL, riid: REFIID, lplpvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleLoadPictureEx*(lpstream: LPSTREAM, lSize: LONG, fRunmode: WINBOOL, riid: REFIID, xSizeDesired: DWORD, ySizeDesired: DWORD, dwFlags: DWORD, lplpvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleLoadPicturePath*(szURLorPath: LPOLESTR, punkCaller: LPUNKNOWN, dwReserved: DWORD, clrReserved: OLE_COLOR, riid: REFIID, ppvRet: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleLoadPictureFile*(varFileName: VARIANT, lplpdispPicture: ptr LPDISPATCH): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleLoadPictureFileEx*(varFileName: VARIANT, xSizeDesired: DWORD, ySizeDesired: DWORD, dwFlags: DWORD, lplpdispPicture: ptr LPDISPATCH): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleSavePictureFile*(lpdispPicture: LPDISPATCH, bstrFileName: BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleIconToCursor*(hinstExe: HINSTANCE, hIcon: HICON): HCURSOR {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleUIAddVerbMenuW*(lpOleObj: LPOLEOBJECT, lpszShortType: LPCWSTR, hMenu: HMENU, uPos: UINT, uIDVerbMin: UINT, uIDVerbMax: UINT, bAddConvert: WINBOOL, idConvert: UINT, lphMenu: ptr HMENU): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIAddVerbMenuA*(lpOleObj: LPOLEOBJECT, lpszShortType: LPCSTR, hMenu: HMENU, uPos: UINT, uIDVerbMin: UINT, uIDVerbMax: UINT, bAddConvert: WINBOOL, idConvert: UINT, lphMenu: ptr HMENU): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIInsertObjectW*(P1: LPOLEUIINSERTOBJECTW): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIInsertObjectA*(P1: LPOLEUIINSERTOBJECTA): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIPasteSpecialW*(P1: LPOLEUIPASTESPECIALW): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIPasteSpecialA*(P1: LPOLEUIPASTESPECIALA): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIEditLinksW*(P1: LPOLEUIEDITLINKSW): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIEditLinksA*(P1: LPOLEUIEDITLINKSA): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIChangeIconW*(P1: LPOLEUICHANGEICONW): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIChangeIconA*(P1: LPOLEUICHANGEICONA): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIConvertW*(P1: LPOLEUICONVERTW): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIConvertA*(P1: LPOLEUICONVERTA): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUICanConvertOrActivateAs*(rClsid: REFCLSID, fIsLinkedObject: WINBOOL, wFormat: WORD): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIBusyW*(P1: LPOLEUIBUSYW): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIBusyA*(P1: LPOLEUIBUSYA): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIChangeSourceW*(P1: LPOLEUICHANGESOURCEW): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIChangeSourceA*(P1: LPOLEUICHANGESOURCEA): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIObjectPropertiesW*(P1: LPOLEUIOBJECTPROPSW): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIObjectPropertiesA*(P1: LPOLEUIOBJECTPROPSA): UINT {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIUpdateLinksW*(lpOleUILinkCntr: LPOLEUILINKCONTAINERW, hwndParent: HWND, lpszTitle: LPWSTR, cLinks: int32): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc.}
proc OleUIUpdateLinksA*(lpOleUILinkCntr: LPOLEUILINKCONTAINERA, hwndParent: HWND, lpszTitle: LPSTR, cLinks: int32): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc.}
proc `bmp=`*(self: var PICTDESC, x: PICTDESC_UNION1_bmp) {.inline.} = self.union1.bmp = x
proc bmp*(self: PICTDESC): PICTDESC_UNION1_bmp {.inline.} = self.union1.bmp
proc bmp*(self: var PICTDESC): var PICTDESC_UNION1_bmp {.inline.} = self.union1.bmp
proc `wmf=`*(self: var PICTDESC, x: PICTDESC_UNION1_wmf) {.inline.} = self.union1.wmf = x
proc wmf*(self: PICTDESC): PICTDESC_UNION1_wmf {.inline.} = self.union1.wmf
proc wmf*(self: var PICTDESC): var PICTDESC_UNION1_wmf {.inline.} = self.union1.wmf
proc `icon=`*(self: var PICTDESC, x: PICTDESC_UNION1_icon) {.inline.} = self.union1.icon = x
proc icon*(self: PICTDESC): PICTDESC_UNION1_icon {.inline.} = self.union1.icon
proc icon*(self: var PICTDESC): var PICTDESC_UNION1_icon {.inline.} = self.union1.icon
proc `emf=`*(self: var PICTDESC, x: PICTDESC_UNION1_emf) {.inline.} = self.union1.emf = x
proc emf*(self: PICTDESC): PICTDESC_UNION1_emf {.inline.} = self.union1.emf
proc emf*(self: var PICTDESC): var PICTDESC_UNION1_emf {.inline.} = self.union1.emf
proc get_accParent*(self: ptr IAccessible, ppdispParent: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accParent(self, ppdispParent)
proc get_accChildCount*(self: ptr IAccessible, pcountChildren: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accChildCount(self, pcountChildren)
proc get_accChild*(self: ptr IAccessible, varChildID: VARIANT, ppdispChild: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accChild(self, varChildID, ppdispChild)
proc get_accName*(self: ptr IAccessible, varID: VARIANT, pszName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accName(self, varID, pszName)
proc get_accValue*(self: ptr IAccessible, varID: VARIANT, pszValue: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accValue(self, varID, pszValue)
proc get_accDescription*(self: ptr IAccessible, varID: VARIANT, pszDescription: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accDescription(self, varID, pszDescription)
proc get_accRole*(self: ptr IAccessible, varID: VARIANT, pvarRole: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accRole(self, varID, pvarRole)
proc get_accState*(self: ptr IAccessible, varID: VARIANT, pvarState: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accState(self, varID, pvarState)
proc get_accHelp*(self: ptr IAccessible, varID: VARIANT, pszHelp: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accHelp(self, varID, pszHelp)
proc get_accHelpTopic*(self: ptr IAccessible, pszHelpFile: ptr BSTR, varID: VARIANT, pidTopic: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accHelpTopic(self, pszHelpFile, varID, pidTopic)
proc get_accKeyboardShortcut*(self: ptr IAccessible, varID: VARIANT, pszKeyboardShortcut: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accKeyboardShortcut(self, varID, pszKeyboardShortcut)
proc get_accFocus*(self: ptr IAccessible, pvarID: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accFocus(self, pvarID)
proc get_accSelection*(self: ptr IAccessible, pvarID: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accSelection(self, pvarID)
proc get_accDefaultAction*(self: ptr IAccessible, varID: VARIANT, pszDefaultAction: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_accDefaultAction(self, varID, pszDefaultAction)
proc accSelect*(self: ptr IAccessible, flagsSelect: LONG, varID: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.accSelect(self, flagsSelect, varID)
proc accLocation*(self: ptr IAccessible, pxLeft: ptr LONG, pyTop: ptr LONG, pcxWidth: ptr LONG, pcyHeight: ptr LONG, varID: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.accLocation(self, pxLeft, pyTop, pcxWidth, pcyHeight, varID)
proc accNavigate*(self: ptr IAccessible, navDir: LONG, varStart: VARIANT, pvarEnd: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.accNavigate(self, navDir, varStart, pvarEnd)
proc accHitTest*(self: ptr IAccessible, xLeft: LONG, yTop: LONG, pvarID: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.accHitTest(self, xLeft, yTop, pvarID)
proc accDoDefaultAction*(self: ptr IAccessible, varID: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.accDoDefaultAction(self, varID)
proc put_accName*(self: ptr IAccessible, varID: VARIANT, pszName: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_accName(self, varID, pszName)
proc put_accValue*(self: ptr IAccessible, varID: VARIANT, pszValue: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_accValue(self, varID, pszValue)
proc AccessibleObjectFromID*(self: ptr IAccessibleHandler, hwnd: LONG, lObjectID: LONG, pIAccessible: ptr LPACCESSIBLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AccessibleObjectFromID(self, hwnd, lObjectID, pIAccessible)
proc GetIdentityString*(self: ptr IAccIdentity, dwIDChild: DWORD, ppIDString: ptr ptr BYTE, pdwIDStringLen: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIdentityString(self, dwIDChild, ppIDString, pdwIDStringLen)
proc GetPropValue*(self: ptr IAccPropServer, pIDString: ptr BYTE, dwIDStringLen: DWORD, idProp: MSAAPROPID, pvarValue: ptr VARIANT, pfHasProp: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropValue(self, pIDString, dwIDStringLen, idProp, pvarValue, pfHasProp)
proc SetPropValue*(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, idProp: MSAAPROPID, `var`: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPropValue(self, pIDString, dwIDStringLen, idProp, `var`)
proc SetPropServer*(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, paProps: ptr MSAAPROPID, cProps: int32, pServer: ptr IAccPropServer, annoScope: AnnoScope): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPropServer(self, pIDString, dwIDStringLen, paProps, cProps, pServer, annoScope)
proc ClearProps*(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, paProps: ptr MSAAPROPID, cProps: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearProps(self, pIDString, dwIDStringLen, paProps, cProps)
proc SetHwndProp*(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, idProp: MSAAPROPID, `var`: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHwndProp(self, hwnd, idObject, idChild, idProp, `var`)
proc SetHwndPropStr*(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, idProp: MSAAPROPID, str: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHwndPropStr(self, hwnd, idObject, idChild, idProp, str)
proc SetHwndPropServer*(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, paProps: ptr MSAAPROPID, cProps: int32, pServer: ptr IAccPropServer, annoScope: AnnoScope): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHwndPropServer(self, hwnd, idObject, idChild, paProps, cProps, pServer, annoScope)
proc ClearHwndProps*(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, paProps: ptr MSAAPROPID, cProps: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearHwndProps(self, hwnd, idObject, idChild, paProps, cProps)
proc ComposeHwndIdentityString*(self: ptr IAccPropServices, hwnd: HWND, idObject: DWORD, idChild: DWORD, ppIDString: ptr ptr BYTE, pdwIDStringLen: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ComposeHwndIdentityString(self, hwnd, idObject, idChild, ppIDString, pdwIDStringLen)
proc DecomposeHwndIdentityString*(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, phwnd: ptr HWND, pidObject: ptr DWORD, pidChild: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DecomposeHwndIdentityString(self, pIDString, dwIDStringLen, phwnd, pidObject, pidChild)
proc SetHmenuProp*(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, idProp: MSAAPROPID, `var`: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHmenuProp(self, hmenu, idChild, idProp, `var`)
proc SetHmenuPropStr*(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, idProp: MSAAPROPID, str: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHmenuPropStr(self, hmenu, idChild, idProp, str)
proc SetHmenuPropServer*(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, paProps: ptr MSAAPROPID, cProps: int32, pServer: ptr IAccPropServer, annoScope: AnnoScope): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHmenuPropServer(self, hmenu, idChild, paProps, cProps, pServer, annoScope)
proc ClearHmenuProps*(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, paProps: ptr MSAAPROPID, cProps: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearHmenuProps(self, hmenu, idChild, paProps, cProps)
proc ComposeHmenuIdentityString*(self: ptr IAccPropServices, hmenu: HMENU, idChild: DWORD, ppIDString: ptr ptr BYTE, pdwIDStringLen: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ComposeHmenuIdentityString(self, hmenu, idChild, ppIDString, pdwIDStringLen)
proc DecomposeHmenuIdentityString*(self: ptr IAccPropServices, pIDString: ptr BYTE, dwIDStringLen: DWORD, phmenu: ptr HMENU, pidChild: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DecomposeHmenuIdentityString(self, pIDString, dwIDStringLen, phmenu, pidChild)
proc GetInterfaceSafetyOptions*(self: ptr IObjectSafety, riid: REFIID, pdwSupportedOptions: ptr DWORD, pdwEnabledOptions: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInterfaceSafetyOptions(self, riid, pdwSupportedOptions, pdwEnabledOptions)
proc SetInterfaceSafetyOptions*(self: ptr IObjectSafety, riid: REFIID, dwOptionSetMask: DWORD, dwEnabledOptions: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetInterfaceSafetyOptions(self, riid, dwOptionSetMask, dwEnabledOptions)
proc GetLCID*(self: ptr IActiveScriptSite, plcid: ptr LCID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLCID(self, plcid)
proc GetItemInfo*(self: ptr IActiveScriptSite, pstrName: LPCOLESTR, dwReturnMask: DWORD, ppiunkItem: ptr ptr IUnknown, ppti: ptr ptr ITypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemInfo(self, pstrName, dwReturnMask, ppiunkItem, ppti)
proc GetDocVersionString*(self: ptr IActiveScriptSite, pbstrVersion: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDocVersionString(self, pbstrVersion)
proc OnScriptTerminate*(self: ptr IActiveScriptSite, pvarResult: ptr VARIANT, pexcepinfo: ptr EXCEPINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnScriptTerminate(self, pvarResult, pexcepinfo)
proc OnStateChange*(self: ptr IActiveScriptSite, ssScriptState: TSCRIPTSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnStateChange(self, ssScriptState)
proc OnScriptError*(self: ptr IActiveScriptSite, pscripterror: ptr IActiveScriptError): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnScriptError(self, pscripterror)
proc OnEnterScript*(self: ptr IActiveScriptSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnEnterScript(self)
proc OnLeaveScript*(self: ptr IActiveScriptSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnLeaveScript(self)
proc GetExceptionInfo*(self: ptr IActiveScriptError, pexcepinfo: ptr EXCEPINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExceptionInfo(self, pexcepinfo)
proc GetSourcePosition*(self: ptr IActiveScriptError, pdwSourceContext: ptr DWORD, pulLineNumber: ptr ULONG, plCharacterPosition: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSourcePosition(self, pdwSourceContext, pulLineNumber, plCharacterPosition)
proc GetSourceLineText*(self: ptr IActiveScriptError, pbstrSourceLine: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSourceLineText(self, pbstrSourceLine)
proc GetSourcePosition64*(self: ptr IActiveScriptError64, pdwSourceContext: ptr DWORDLONG, pulLineNumber: ptr ULONG, plCharacterPosition: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSourcePosition64(self, pdwSourceContext, pulLineNumber, plCharacterPosition)
proc GetWindow*(self: ptr IActiveScriptSiteWindow, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWindow(self, phwnd)
proc EnableModeless*(self: ptr IActiveScriptSiteWindow, fEnable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableModeless(self, fEnable)
proc GetUIBehavior*(self: ptr IActiveScriptSiteUIControl, UicItem: SCRIPTUICITEM, pUicHandling: ptr SCRIPTUICHANDLING): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUIBehavior(self, UicItem, pUicHandling)
proc QueryContinue*(self: ptr IActiveScriptSiteInterruptPoll): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryContinue(self)
proc SetScriptSite*(self: ptr IActiveScript, pass: ptr IActiveScriptSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetScriptSite(self, pass)
proc GetScriptSite*(self: ptr IActiveScript, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetScriptSite(self, riid, ppvObject)
proc SetScriptState*(self: ptr IActiveScript, ss: TSCRIPTSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetScriptState(self, ss)
proc GetScriptState*(self: ptr IActiveScript, pssState: ptr TSCRIPTSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetScriptState(self, pssState)
proc Close*(self: ptr IActiveScript): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Close(self)
proc AddNamedItem*(self: ptr IActiveScript, pstrName: LPCOLESTR, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddNamedItem(self, pstrName, dwFlags)
proc AddTypeLib*(self: ptr IActiveScript, rguidTypeLib: REFGUID, dwMajor: DWORD, dwMinor: DWORD, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddTypeLib(self, rguidTypeLib, dwMajor, dwMinor, dwFlags)
proc GetScriptDispatch*(self: ptr IActiveScript, pstrItemName: LPCOLESTR, ppdisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetScriptDispatch(self, pstrItemName, ppdisp)
proc GetCurrentScriptThreadID*(self: ptr IActiveScript, pstidThread: ptr SCRIPTTHREADID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentScriptThreadID(self, pstidThread)
proc GetScriptThreadID*(self: ptr IActiveScript, dwWin32ThreadId: DWORD, pstidThread: ptr SCRIPTTHREADID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetScriptThreadID(self, dwWin32ThreadId, pstidThread)
proc GetScriptThreadState*(self: ptr IActiveScript, stidThread: SCRIPTTHREADID, pstsState: ptr SCRIPTTHREADSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetScriptThreadState(self, stidThread, pstsState)
proc InterruptScriptThread*(self: ptr IActiveScript, stidThread: SCRIPTTHREADID, pexcepinfo: ptr EXCEPINFO, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InterruptScriptThread(self, stidThread, pexcepinfo, dwFlags)
proc Clone*(self: ptr IActiveScript, ppscript: ptr ptr IActiveScript): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppscript)
proc InitNew*(self: ptr IActiveScriptParse32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitNew(self)
proc AddScriptlet*(self: ptr IActiveScriptParse32, pstrDefaultName: LPCOLESTR, pstrCode: LPCOLESTR, pstrItemName: LPCOLESTR, pstrSubItemName: LPCOLESTR, pstrEventName: LPCOLESTR, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORD, ulStartingLineNumber: ULONG, dwFlags: DWORD, pbstrName: ptr BSTR, pexcepinfo: ptr EXCEPINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddScriptlet(self, pstrDefaultName, pstrCode, pstrItemName, pstrSubItemName, pstrEventName, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, pbstrName, pexcepinfo)
proc ParseScriptText*(self: ptr IActiveScriptParse32, pstrCode: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORD, ulStartingLineNumber: ULONG, dwFlags: DWORD, pvarResult: ptr VARIANT, pexcepinfo: ptr EXCEPINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseScriptText(self, pstrCode, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, pvarResult, pexcepinfo)
proc InitNew*(self: ptr IActiveScriptParse64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitNew(self)
proc AddScriptlet*(self: ptr IActiveScriptParse64, pstrDefaultName: LPCOLESTR, pstrCode: LPCOLESTR, pstrItemName: LPCOLESTR, pstrSubItemName: LPCOLESTR, pstrEventName: LPCOLESTR, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORDLONG, ulStartingLineNumber: ULONG, dwFlags: DWORD, pbstrName: ptr BSTR, pexcepinfo: ptr EXCEPINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddScriptlet(self, pstrDefaultName, pstrCode, pstrItemName, pstrSubItemName, pstrEventName, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, pbstrName, pexcepinfo)
proc ParseScriptText*(self: ptr IActiveScriptParse64, pstrCode: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORDLONG, ulStartingLineNumber: ULONG, dwFlags: DWORD, pvarResult: ptr VARIANT, pexcepinfo: ptr EXCEPINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseScriptText(self, pstrCode, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, pvarResult, pexcepinfo)
proc ParseProcedureText*(self: ptr IActiveScriptParseProcedureOld32, pstrCode: LPCOLESTR, pstrFormalParams: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORD, ulStartingLineNumber: ULONG, dwFlags: DWORD, ppdisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseProcedureText(self, pstrCode, pstrFormalParams, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, ppdisp)
proc ParseProcedureText*(self: ptr IActiveScriptParseProcedureOld64, pstrCode: LPCOLESTR, pstrFormalParams: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORDLONG, ulStartingLineNumber: ULONG, dwFlags: DWORD, ppdisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseProcedureText(self, pstrCode, pstrFormalParams, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, ppdisp)
proc ParseProcedureText*(self: ptr IActiveScriptParseProcedure32, pstrCode: LPCOLESTR, pstrFormalParams: LPCOLESTR, pstrProcedureName: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORD, ulStartingLineNumber: ULONG, dwFlags: DWORD, ppdisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseProcedureText(self, pstrCode, pstrFormalParams, pstrProcedureName, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, ppdisp)
proc ParseProcedureText*(self: ptr IActiveScriptParseProcedure64, pstrCode: LPCOLESTR, pstrFormalParams: LPCOLESTR, pstrProcedureName: LPCOLESTR, pstrItemName: LPCOLESTR, punkContext: ptr IUnknown, pstrDelimiter: LPCOLESTR, dwSourceContextCookie: DWORDLONG, ulStartingLineNumber: ULONG, dwFlags: DWORD, ppdisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseProcedureText(self, pstrCode, pstrFormalParams, pstrProcedureName, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, ppdisp)
proc EncodeSection*(self: ptr IActiveScriptEncode, pchIn: LPCOLESTR, cchIn: DWORD, pchOut: LPOLESTR, cchOut: DWORD, pcchRet: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EncodeSection(self, pchIn, cchIn, pchOut, cchOut, pcchRet)
proc DecodeScript*(self: ptr IActiveScriptEncode, pchIn: LPCOLESTR, cchIn: DWORD, pchOut: LPOLESTR, cchOut: DWORD, pcchRet: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DecodeScript(self, pchIn, cchIn, pchOut, cchOut, pcchRet)
proc GetEncodeProgId*(self: ptr IActiveScriptEncode, pbstrOut: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEncodeProgId(self, pbstrOut)
proc EncodeScriptHostFile*(self: ptr IActiveScriptHostEncode, bstrInFile: BSTR, pbstrOutFile: ptr BSTR, cFlags: ULONG, bstrDefaultLang: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EncodeScriptHostFile(self, bstrInFile, pbstrOutFile, cFlags, bstrDefaultLang)
proc BindHandler*(self: ptr IBindEventHandler, pstrEvent: LPCOLESTR, pdisp: ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindHandler(self, pstrEvent, pdisp)
proc GetStat*(self: ptr IActiveScriptStats, stid: DWORD, pluHi: ptr ULONG, pluLo: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStat(self, stid, pluHi, pluLo)
proc GetStatEx*(self: ptr IActiveScriptStats, guid: REFGUID, pluHi: ptr ULONG, pluLo: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStatEx(self, guid, pluHi, pluLo)
proc ResetStats*(self: ptr IActiveScriptStats): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetStats(self)
proc GetProperty*(self: ptr IActiveScriptProperty, dwProperty: DWORD, pvarIndex: ptr VARIANT, pvarValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, dwProperty, pvarIndex, pvarValue)
proc SetProperty*(self: ptr IActiveScriptProperty, dwProperty: DWORD, pvarIndex: ptr VARIANT, pvarValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProperty(self, dwProperty, pvarIndex, pvarValue)
proc FireEvent*(self: ptr ITridentEventSink, pstrEvent: LPCOLESTR, pdp: ptr DISPPARAMS, pvarRes: ptr VARIANT, pei: ptr EXCEPINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FireEvent(self, pstrEvent, pdp, pvarRes, pei)
proc CollectGarbage*(self: ptr IActiveScriptGarbageCollector, scriptgctype: SCRIPTGCTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CollectGarbage(self, scriptgctype)
proc GetSIPOID*(self: ptr IActiveScriptSIPInfo, poid_sip: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSIPOID(self, poid_sip)
proc SendScriptTraceInfo*(self: ptr IActiveScriptSiteTraceInfo, stiEventType: SCRIPTTRACEINFO, guidContextID: GUID, dwScriptContextCookie: DWORD, lScriptStatementStart: LONG, lScriptStatementEnd: LONG, dwReserved: DWORD64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendScriptTraceInfo(self, stiEventType, guidContextID, dwScriptContextCookie, lScriptStatementStart, lScriptStatementEnd, dwReserved)
proc StartScriptTracing*(self: ptr IActiveScriptTraceInfo, pSiteTraceInfo: ptr IActiveScriptSiteTraceInfo, guidContextID: GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartScriptTracing(self, pSiteTraceInfo, guidContextID)
proc StopScriptTracing*(self: ptr IActiveScriptTraceInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StopScriptTracing(self)
proc StrComp*(self: ptr IActiveScriptStringCompare, bszStr1: BSTR, bszStr2: BSTR, iRet: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrComp(self, bszStr1, bszStr2, iRet)
proc GetNextLink*(self: ptr IOleUILinkContainerW, dwLink: DWORD): DWORD {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNextLink(self, dwLink)
proc SetLinkUpdateOptions*(self: ptr IOleUILinkContainerW, dwLink: DWORD, dwUpdateOpt: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLinkUpdateOptions(self, dwLink, dwUpdateOpt)
proc GetLinkUpdateOptions*(self: ptr IOleUILinkContainerW, dwLink: DWORD, lpdwUpdateOpt: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLinkUpdateOptions(self, dwLink, lpdwUpdateOpt)
proc SetLinkSource*(self: ptr IOleUILinkContainerW, dwLink: DWORD, lpszDisplayName: LPWSTR, lenFileName: ULONG, pchEaten: ptr ULONG, fValidateSource: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLinkSource(self, dwLink, lpszDisplayName, lenFileName, pchEaten, fValidateSource)
proc GetLinkSource*(self: ptr IOleUILinkContainerW, dwLink: DWORD, lplpszDisplayName: ptr LPWSTR, lplenFileName: ptr ULONG, lplpszFullLinkType: ptr LPWSTR, lplpszShortLinkType: ptr LPWSTR, lpfSourceAvailable: ptr WINBOOL, lpfIsSelected: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLinkSource(self, dwLink, lplpszDisplayName, lplenFileName, lplpszFullLinkType, lplpszShortLinkType, lpfSourceAvailable, lpfIsSelected)
proc OpenLinkSource*(self: ptr IOleUILinkContainerW, dwLink: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenLinkSource(self, dwLink)
proc UpdateLink*(self: ptr IOleUILinkContainerW, dwLink: DWORD, fErrorMessage: WINBOOL, fReserved: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateLink(self, dwLink, fErrorMessage, fReserved)
proc CancelLink*(self: ptr IOleUILinkContainerW, dwLink: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CancelLink(self, dwLink)
proc GetNextLink*(self: ptr IOleUILinkContainerA, dwLink: DWORD): DWORD {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNextLink(self, dwLink)
proc SetLinkUpdateOptions*(self: ptr IOleUILinkContainerA, dwLink: DWORD, dwUpdateOpt: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLinkUpdateOptions(self, dwLink, dwUpdateOpt)
proc GetLinkUpdateOptions*(self: ptr IOleUILinkContainerA, dwLink: DWORD, lpdwUpdateOpt: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLinkUpdateOptions(self, dwLink, lpdwUpdateOpt)
proc SetLinkSource*(self: ptr IOleUILinkContainerA, dwLink: DWORD, lpszDisplayName: LPSTR, lenFileName: ULONG, pchEaten: ptr ULONG, fValidateSource: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLinkSource(self, dwLink, lpszDisplayName, lenFileName, pchEaten, fValidateSource)
proc GetLinkSource*(self: ptr IOleUILinkContainerA, dwLink: DWORD, lplpszDisplayName: ptr LPSTR, lplenFileName: ptr ULONG, lplpszFullLinkType: ptr LPSTR, lplpszShortLinkType: ptr LPSTR, lpfSourceAvailable: ptr WINBOOL, lpfIsSelected: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLinkSource(self, dwLink, lplpszDisplayName, lplenFileName, lplpszFullLinkType, lplpszShortLinkType, lpfSourceAvailable, lpfIsSelected)
proc OpenLinkSource*(self: ptr IOleUILinkContainerA, dwLink: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenLinkSource(self, dwLink)
proc UpdateLink*(self: ptr IOleUILinkContainerA, dwLink: DWORD, fErrorMessage: WINBOOL, fReserved: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateLink(self, dwLink, fErrorMessage, fReserved)
proc CancelLink*(self: ptr IOleUILinkContainerA, dwLink: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CancelLink(self, dwLink)
proc GetObjectInfo*(self: ptr IOleUIObjInfoW, dwObject: DWORD, lpdwObjSize: ptr DWORD, lplpszLabel: ptr LPWSTR, lplpszType: ptr LPWSTR, lplpszShortType: ptr LPWSTR, lplpszLocation: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectInfo(self, dwObject, lpdwObjSize, lplpszLabel, lplpszType, lplpszShortType, lplpszLocation)
proc GetConvertInfo*(self: ptr IOleUIObjInfoW, dwObject: DWORD, lpClassID: ptr CLSID, lpwFormat: ptr WORD, lpConvertDefaultClassID: ptr CLSID, lplpClsidExclude: ptr LPCLSID, lpcClsidExclude: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConvertInfo(self, dwObject, lpClassID, lpwFormat, lpConvertDefaultClassID, lplpClsidExclude, lpcClsidExclude)
proc ConvertObject*(self: ptr IOleUIObjInfoW, dwObject: DWORD, clsidNew: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConvertObject(self, dwObject, clsidNew)
proc GetViewInfo*(self: ptr IOleUIObjInfoW, dwObject: DWORD, phMetaPict: ptr HGLOBAL, pdvAspect: ptr DWORD, pnCurrentScale: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewInfo(self, dwObject, phMetaPict, pdvAspect, pnCurrentScale)
proc SetViewInfo*(self: ptr IOleUIObjInfoW, dwObject: DWORD, hMetaPict: HGLOBAL, dvAspect: DWORD, nCurrentScale: int32, bRelativeToOrig: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetViewInfo(self, dwObject, hMetaPict, dvAspect, nCurrentScale, bRelativeToOrig)
proc GetObjectInfo*(self: ptr IOleUIObjInfoA, dwObject: DWORD, lpdwObjSize: ptr DWORD, lplpszLabel: ptr LPSTR, lplpszType: ptr LPSTR, lplpszShortType: ptr LPSTR, lplpszLocation: ptr LPSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectInfo(self, dwObject, lpdwObjSize, lplpszLabel, lplpszType, lplpszShortType, lplpszLocation)
proc GetConvertInfo*(self: ptr IOleUIObjInfoA, dwObject: DWORD, lpClassID: ptr CLSID, lpwFormat: ptr WORD, lpConvertDefaultClassID: ptr CLSID, lplpClsidExclude: ptr LPCLSID, lpcClsidExclude: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConvertInfo(self, dwObject, lpClassID, lpwFormat, lpConvertDefaultClassID, lplpClsidExclude, lpcClsidExclude)
proc ConvertObject*(self: ptr IOleUIObjInfoA, dwObject: DWORD, clsidNew: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConvertObject(self, dwObject, clsidNew)
proc GetViewInfo*(self: ptr IOleUIObjInfoA, dwObject: DWORD, phMetaPict: ptr HGLOBAL, pdvAspect: ptr DWORD, pnCurrentScale: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewInfo(self, dwObject, phMetaPict, pdvAspect, pnCurrentScale)
proc SetViewInfo*(self: ptr IOleUIObjInfoA, dwObject: DWORD, hMetaPict: HGLOBAL, dvAspect: DWORD, nCurrentScale: int32, bRelativeToOrig: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetViewInfo(self, dwObject, hMetaPict, dvAspect, nCurrentScale, bRelativeToOrig)
proc GetLastUpdate*(self: ptr IOleUILinkInfoW, dwLink: DWORD, lpLastUpdate: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLastUpdate(self, dwLink, lpLastUpdate)
proc GetLastUpdate*(self: ptr IOleUILinkInfoA, dwLink: DWORD, lpLastUpdate: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLastUpdate(self, dwLink, lpLastUpdate)
converter winimConverterIAccessibleToIDispatch*(x: ptr IAccessible): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIAccessibleToIUnknown*(x: ptr IAccessible): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccessibleHandlerToIUnknown*(x: ptr IAccessibleHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccIdentityToIUnknown*(x: ptr IAccIdentity): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccPropServerToIUnknown*(x: ptr IAccPropServer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccPropServicesToIUnknown*(x: ptr IAccPropServices): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectSafetyToIUnknown*(x: ptr IObjectSafety): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptSiteToIUnknown*(x: ptr IActiveScriptSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptErrorToIUnknown*(x: ptr IActiveScriptError): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptError64ToIActiveScriptError*(x: ptr IActiveScriptError64): ptr IActiveScriptError = cast[ptr IActiveScriptError](x)
converter winimConverterIActiveScriptError64ToIUnknown*(x: ptr IActiveScriptError64): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptSiteWindowToIUnknown*(x: ptr IActiveScriptSiteWindow): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptSiteUIControlToIUnknown*(x: ptr IActiveScriptSiteUIControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptSiteInterruptPollToIUnknown*(x: ptr IActiveScriptSiteInterruptPoll): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptToIUnknown*(x: ptr IActiveScript): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptParse32ToIUnknown*(x: ptr IActiveScriptParse32): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptParse64ToIUnknown*(x: ptr IActiveScriptParse64): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptParseProcedureOld32ToIUnknown*(x: ptr IActiveScriptParseProcedureOld32): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptParseProcedureOld64ToIUnknown*(x: ptr IActiveScriptParseProcedureOld64): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptParseProcedure32ToIUnknown*(x: ptr IActiveScriptParseProcedure32): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptParseProcedure64ToIUnknown*(x: ptr IActiveScriptParseProcedure64): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptParseProcedure2_32ToIActiveScriptParseProcedure32*(x: ptr IActiveScriptParseProcedure2_32): ptr IActiveScriptParseProcedure32 = cast[ptr IActiveScriptParseProcedure32](x)
converter winimConverterIActiveScriptParseProcedure2_32ToIUnknown*(x: ptr IActiveScriptParseProcedure2_32): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptParseProcedure2_64ToIActiveScriptParseProcedure64*(x: ptr IActiveScriptParseProcedure2_64): ptr IActiveScriptParseProcedure64 = cast[ptr IActiveScriptParseProcedure64](x)
converter winimConverterIActiveScriptParseProcedure2_64ToIUnknown*(x: ptr IActiveScriptParseProcedure2_64): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptEncodeToIUnknown*(x: ptr IActiveScriptEncode): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptHostEncodeToIUnknown*(x: ptr IActiveScriptHostEncode): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBindEventHandlerToIUnknown*(x: ptr IBindEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptStatsToIUnknown*(x: ptr IActiveScriptStats): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptPropertyToIUnknown*(x: ptr IActiveScriptProperty): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITridentEventSinkToIUnknown*(x: ptr ITridentEventSink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptGarbageCollectorToIUnknown*(x: ptr IActiveScriptGarbageCollector): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptSIPInfoToIUnknown*(x: ptr IActiveScriptSIPInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptSiteTraceInfoToIUnknown*(x: ptr IActiveScriptSiteTraceInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptTraceInfoToIUnknown*(x: ptr IActiveScriptTraceInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveScriptStringCompareToIUnknown*(x: ptr IActiveScriptStringCompare): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleUILinkContainerWToIUnknown*(x: ptr IOleUILinkContainerW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleUILinkContainerAToIUnknown*(x: ptr IOleUILinkContainerA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleUIObjInfoWToIUnknown*(x: ptr IOleUIObjInfoW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleUIObjInfoAToIUnknown*(x: ptr IOleUIObjInfoA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleUILinkInfoWToIOleUILinkContainerW*(x: ptr IOleUILinkInfoW): ptr IOleUILinkContainerW = cast[ptr IOleUILinkContainerW](x)
converter winimConverterIOleUILinkInfoWToIUnknown*(x: ptr IOleUILinkInfoW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleUILinkInfoAToIOleUILinkContainerA*(x: ptr IOleUILinkInfoA): ptr IOleUILinkContainerA = cast[ptr IOleUILinkContainerA](x)
converter winimConverterIOleUILinkInfoAToIUnknown*(x: ptr IOleUILinkInfoA): ptr IUnknown = cast[ptr IUnknown](x)
when winimUnicode:
  type
    TOLEUIINSERTOBJECT* = TOLEUIINSERTOBJECTW
    POLEUIINSERTOBJECT* = POLEUIINSERTOBJECTW
    LPOLEUIINSERTOBJECT* = LPOLEUIINSERTOBJECTW
    OLEUIPASTEENTRY* = OLEUIPASTEENTRYW
    POLEUIPASTEENTRY* = POLEUIPASTEENTRYW
    LPOLEUIPASTEENTRY* = LPOLEUIPASTEENTRYW
    TOLEUIPASTESPECIAL* = TOLEUIPASTESPECIALW
    POLEUIPASTESPECIAL* = POLEUIPASTESPECIALW
    LPOLEUIPASTESPECIAL* = LPOLEUIPASTESPECIALW
    IOleUILinkContainer* = IOleUILinkContainerW
    LPOLEUILINKCONTAINER* = LPOLEUILINKCONTAINERW
    TOLEUIEDITLINKS* = TOLEUIEDITLINKSW
    POLEUIEDITLINKS* = POLEUIEDITLINKSW
    LPOLEUIEDITLINKS* = LPOLEUIEDITLINKSW
    TOLEUICHANGEICON* = TOLEUICHANGEICONW
    POLEUICHANGEICON* = POLEUICHANGEICONW
    LPOLEUICHANGEICON* = LPOLEUICHANGEICONW
    TOLEUICONVERT* = TOLEUICONVERTW
    POLEUICONVERT* = POLEUICONVERTW
    LPOLEUICONVERT* = LPOLEUICONVERTW
    TOLEUIBUSY* = TOLEUIBUSYW
    POLEUIBUSY* = POLEUIBUSYW
    LPOLEUIBUSY* = LPOLEUIBUSYW
    TOLEUICHANGESOURCE* = TOLEUICHANGESOURCEW
    POLEUICHANGESOURCE* = POLEUICHANGESOURCEW
    LPOLEUICHANGESOURCE* = LPOLEUICHANGESOURCEW
    IOleUIObjInfo* = IOleUIObjInfoW
    LPOLEUIOBJINFO* = LPOLEUIOBJINFOW
    IOleUILinkInfo* = IOleUILinkInfoW
    LPOLEUILINKINFO* = LPOLEUILINKINFOW
    OLEUIGNRLPROPS* = OLEUIGNRLPROPSW
    POLEUIGNRLPROPS* = POLEUIGNRLPROPSW
    LPOLEUIGNRLPROPS* = LPOLEUIGNRLPROPSW
    OLEUIVIEWPROPS* = OLEUIVIEWPROPSW
    POLEUIVIEWPROPS* = POLEUIVIEWPROPSW
    LPOLEUIVIEWPROPS* = LPOLEUIVIEWPROPSW
    OLEUILINKPROPS* = OLEUILINKPROPSW
    POLEUILINKPROPS* = POLEUILINKPROPSW
    LPOLEUILINKPROPS* = LPOLEUILINKPROPSW
    OLEUIOBJECTPROPS* = OLEUIOBJECTPROPSW
    POLEUIOBJECTPROPS* = POLEUIOBJECTPROPSW
    LPOLEUIOBJECTPROPS* = LPOLEUIOBJECTPROPSW
  const
    IDD_SERVERNOTREG* = IDD_SERVERNOTREGW
    IDD_LINKTYPECHANGED* = IDD_LINKTYPECHANGEDW
  proc GetRoleText*(lRole: DWORD, lpszRole: LPWSTR, cchRoleMax: UINT): UINT {.winapi, stdcall, dynlib: "oleacc", importc: "GetRoleTextW".}
  proc GetStateText*(lStateBit: DWORD, lpszState: LPWSTR, cchState: UINT): UINT {.winapi, stdcall, dynlib: "oleacc", importc: "GetStateTextW".}
  proc CreateStdAccessibleProxy*(hwnd: HWND, pClassName: LPCWSTR, idObject: LONG, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc: "CreateStdAccessibleProxyW".}
  proc OleUIAddVerbMenu*(lpOleObj: LPOLEOBJECT, lpszShortType: LPCWSTR, hMenu: HMENU, uPos: UINT, uIDVerbMin: UINT, uIDVerbMax: UINT, bAddConvert: WINBOOL, idConvert: UINT, lphMenu: ptr HMENU): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIAddVerbMenuW".}
  proc OleUIInsertObject*(P1: LPOLEUIINSERTOBJECTW): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIInsertObjectW".}
  proc OleUIPasteSpecial*(P1: LPOLEUIPASTESPECIALW): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIPasteSpecialW".}
  proc OleUIEditLinks*(P1: LPOLEUIEDITLINKSW): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIEditLinksW".}
  proc OleUIChangeIcon*(P1: LPOLEUICHANGEICONW): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIChangeIconW".}
  proc OleUIConvert*(P1: LPOLEUICONVERTW): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIConvertW".}
  proc OleUIBusy*(P1: LPOLEUIBUSYW): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIBusyW".}
  proc OleUIChangeSource*(P1: LPOLEUICHANGESOURCEW): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIChangeSourceW".}
  proc OleUIObjectProperties*(P1: LPOLEUIOBJECTPROPSW): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIObjectPropertiesW".}
  proc OleUIUpdateLinks*(lpOleUILinkCntr: LPOLEUILINKCONTAINERW, hwndParent: HWND, lpszTitle: LPWSTR, cLinks: int32): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIUpdateLinksW".}
when winimAnsi:
  type
    TOLEUIINSERTOBJECT* = TOLEUIINSERTOBJECTA
    POLEUIINSERTOBJECT* = POLEUIINSERTOBJECTA
    LPOLEUIINSERTOBJECT* = LPOLEUIINSERTOBJECTA
    OLEUIPASTEENTRY* = OLEUIPASTEENTRYA
    POLEUIPASTEENTRY* = POLEUIPASTEENTRYA
    LPOLEUIPASTEENTRY* = LPOLEUIPASTEENTRYA
    TOLEUIPASTESPECIAL* = TOLEUIPASTESPECIALA
    POLEUIPASTESPECIAL* = POLEUIPASTESPECIALA
    LPOLEUIPASTESPECIAL* = LPOLEUIPASTESPECIALA
    IOleUILinkContainer* = IOleUILinkContainerA
    LPOLEUILINKCONTAINER* = LPOLEUILINKCONTAINERA
    TOLEUIEDITLINKS* = TOLEUIEDITLINKSA
    POLEUIEDITLINKS* = POLEUIEDITLINKSA
    LPOLEUIEDITLINKS* = LPOLEUIEDITLINKSA
    TOLEUICHANGEICON* = TOLEUICHANGEICONA
    POLEUICHANGEICON* = POLEUICHANGEICONA
    LPOLEUICHANGEICON* = LPOLEUICHANGEICONA
    TOLEUICONVERT* = TOLEUICONVERTA
    POLEUICONVERT* = POLEUICONVERTA
    LPOLEUICONVERT* = LPOLEUICONVERTA
    TOLEUIBUSY* = TOLEUIBUSYA
    POLEUIBUSY* = POLEUIBUSYA
    LPOLEUIBUSY* = LPOLEUIBUSYA
    TOLEUICHANGESOURCE* = TOLEUICHANGESOURCEA
    POLEUICHANGESOURCE* = POLEUICHANGESOURCEA
    LPOLEUICHANGESOURCE* = LPOLEUICHANGESOURCEA
    IOleUIObjInfo* = IOleUIObjInfoA
    LPOLEUIOBJINFO* = LPOLEUIOBJINFOA
    IOleUILinkInfo* = IOleUILinkInfoA
    LPOLEUILINKINFO* = LPOLEUILINKINFOA
    OLEUIGNRLPROPS* = OLEUIGNRLPROPSA
    POLEUIGNRLPROPS* = POLEUIGNRLPROPSA
    LPOLEUIGNRLPROPS* = LPOLEUIGNRLPROPSA
    OLEUIVIEWPROPS* = OLEUIVIEWPROPSA
    POLEUIVIEWPROPS* = POLEUIVIEWPROPSA
    LPOLEUIVIEWPROPS* = LPOLEUIVIEWPROPSA
    OLEUILINKPROPS* = OLEUILINKPROPSA
    POLEUILINKPROPS* = POLEUILINKPROPSA
    LPOLEUILINKPROPS* = LPOLEUILINKPROPSA
    OLEUIOBJECTPROPS* = OLEUIOBJECTPROPSA
    POLEUIOBJECTPROPS* = POLEUIOBJECTPROPSA
    LPOLEUIOBJECTPROPS* = LPOLEUIOBJECTPROPSA
  const
    IDD_SERVERNOTREG* = IDD_SERVERNOTREGA
    IDD_LINKTYPECHANGED* = IDD_LINKTYPECHANGEDA
  proc GetRoleText*(lRole: DWORD, lpszRole: LPSTR, cchRoleMax: UINT): UINT {.winapi, stdcall, dynlib: "oleacc", importc: "GetRoleTextA".}
  proc GetStateText*(lStateBit: DWORD, lpszState: LPSTR, cchState: UINT): UINT {.winapi, stdcall, dynlib: "oleacc", importc: "GetStateTextA".}
  proc CreateStdAccessibleProxy*(hwnd: HWND, pClassName: LPCSTR, idObject: LONG, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleacc", importc: "CreateStdAccessibleProxyA".}
  proc OleUIAddVerbMenu*(lpOleObj: LPOLEOBJECT, lpszShortType: LPCSTR, hMenu: HMENU, uPos: UINT, uIDVerbMin: UINT, uIDVerbMax: UINT, bAddConvert: WINBOOL, idConvert: UINT, lphMenu: ptr HMENU): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIAddVerbMenuA".}
  proc OleUIInsertObject*(P1: LPOLEUIINSERTOBJECTA): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIInsertObjectA".}
  proc OleUIPasteSpecial*(P1: LPOLEUIPASTESPECIALA): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIPasteSpecialA".}
  proc OleUIEditLinks*(P1: LPOLEUIEDITLINKSA): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIEditLinksA".}
  proc OleUIChangeIcon*(P1: LPOLEUICHANGEICONA): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIChangeIconA".}
  proc OleUIConvert*(P1: LPOLEUICONVERTA): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIConvertA".}
  proc OleUIBusy*(P1: LPOLEUIBUSYA): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIBusyA".}
  proc OleUIChangeSource*(P1: LPOLEUICHANGESOURCEA): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIChangeSourceA".}
  proc OleUIObjectProperties*(P1: LPOLEUIOBJECTPROPSA): UINT {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIObjectPropertiesA".}
  proc OleUIUpdateLinks*(lpOleUILinkCntr: LPOLEUILINKCONTAINERA, hwndParent: HWND, lpszTitle: LPSTR, cLinks: int32): WINBOOL {.winapi, stdcall, dynlib: "oledlg", importc: "OleUIUpdateLinksA".}
when winimCpu64:
  const
    IID_IActiveScriptParse* = IID_IActiveScriptParse64
    IID_IActiveScriptParseProcedureOld* = IID_IActiveScriptParseProcedureOld64
    IID_IActiveScriptParseProcedure* = IID_IActiveScriptParseProcedure64
    IID_IActiveScriptParseProcedure2* = IID_IActiveScriptParseProcedure2_64
when winimCpu32:
  const
    IID_IActiveScriptParse* = IID_IActiveScriptParse32
    IID_IActiveScriptParseProcedureOld* = IID_IActiveScriptParseProcedureOld32
    IID_IActiveScriptParseProcedure* = IID_IActiveScriptParseProcedure32
    IID_IActiveScriptParseProcedure2* = IID_IActiveScriptParseProcedure2_32
