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
#include <imm.h>
#include <dimm.h>
type
  HIMC* = HANDLE
  HIMCC* = HANDLE
  LPHKL* = ptr HKL
  LPUINT* = ptr UINT
  COMPOSITIONFORM* {.pure.} = object
    dwStyle*: DWORD
    ptCurrentPos*: POINT
    rcArea*: RECT
  PCOMPOSITIONFORM* = ptr COMPOSITIONFORM
  NPCOMPOSITIONFORM* = ptr COMPOSITIONFORM
  LPCOMPOSITIONFORM* = ptr COMPOSITIONFORM
  CANDIDATEFORM* {.pure.} = object
    dwIndex*: DWORD
    dwStyle*: DWORD
    ptCurrentPos*: POINT
    rcArea*: RECT
  PCANDIDATEFORM* = ptr CANDIDATEFORM
  NPCANDIDATEFORM* = ptr CANDIDATEFORM
  LPCANDIDATEFORM* = ptr CANDIDATEFORM
  CANDIDATELIST* {.pure.} = object
    dwSize*: DWORD
    dwStyle*: DWORD
    dwCount*: DWORD
    dwSelection*: DWORD
    dwPageStart*: DWORD
    dwPageSize*: DWORD
    dwOffset*: array[1, DWORD]
  PCANDIDATELIST* = ptr CANDIDATELIST
  NPCANDIDATELIST* = ptr CANDIDATELIST
  LPCANDIDATELIST* = ptr CANDIDATELIST
  REGISTERWORDA* {.pure.} = object
    lpReading*: LPSTR
    lpWord*: LPSTR
  PREGISTERWORDA* = ptr REGISTERWORDA
  NPREGISTERWORDA* = ptr REGISTERWORDA
  LPREGISTERWORDA* = ptr REGISTERWORDA
  REGISTERWORDW* {.pure.} = object
    lpReading*: LPWSTR
    lpWord*: LPWSTR
  PREGISTERWORDW* = ptr REGISTERWORDW
  NPREGISTERWORDW* = ptr REGISTERWORDW
  LPREGISTERWORDW* = ptr REGISTERWORDW
  RECONVERTSTRING* {.pure.} = object
    dwSize*: DWORD
    dwVersion*: DWORD
    dwStrLen*: DWORD
    dwStrOffset*: DWORD
    dwCompStrLen*: DWORD
    dwCompStrOffset*: DWORD
    dwTargetStrLen*: DWORD
    dwTargetStrOffset*: DWORD
  PRECONVERTSTRING* = ptr RECONVERTSTRING
  NPRECONVERTSTRING* = ptr RECONVERTSTRING
  LPRECONVERTSTRING* = ptr RECONVERTSTRING
const
  STYLE_DESCRIPTION_SIZE* = 32
type
  STYLEBUFA* {.pure.} = object
    dwStyle*: DWORD
    szDescription*: array[STYLE_DESCRIPTION_SIZE, CHAR]
  PSTYLEBUFA* = ptr STYLEBUFA
  NPSTYLEBUFA* = ptr STYLEBUFA
  LPSTYLEBUFA* = ptr STYLEBUFA
  STYLEBUFW* {.pure.} = object
    dwStyle*: DWORD
    szDescription*: array[STYLE_DESCRIPTION_SIZE, WCHAR]
  PSTYLEBUFW* = ptr STYLEBUFW
  NPSTYLEBUFW* = ptr STYLEBUFW
  LPSTYLEBUFW* = ptr STYLEBUFW
const
  IMEMENUITEM_STRING_SIZE* = 80
type
  IMEMENUITEMINFOA* {.pure.} = object
    cbSize*: UINT
    fType*: UINT
    fState*: UINT
    wID*: UINT
    hbmpChecked*: HBITMAP
    hbmpUnchecked*: HBITMAP
    dwItemData*: DWORD
    szString*: array[IMEMENUITEM_STRING_SIZE, CHAR]
    hbmpItem*: HBITMAP
  PIMEMENUITEMINFOA* = ptr IMEMENUITEMINFOA
  NPIMEMENUITEMINFOA* = ptr IMEMENUITEMINFOA
  LPIMEMENUITEMINFOA* = ptr IMEMENUITEMINFOA
  IMEMENUITEMINFOW* {.pure.} = object
    cbSize*: UINT
    fType*: UINT
    fState*: UINT
    wID*: UINT
    hbmpChecked*: HBITMAP
    hbmpUnchecked*: HBITMAP
    dwItemData*: DWORD
    szString*: array[IMEMENUITEM_STRING_SIZE, WCHAR]
    hbmpItem*: HBITMAP
  PIMEMENUITEMINFOW* = ptr IMEMENUITEMINFOW
  NPIMEMENUITEMINFOW* = ptr IMEMENUITEMINFOW
  LPIMEMENUITEMINFOW* = ptr IMEMENUITEMINFOW
  IMECHARPOSITION* {.pure.} = object
    dwSize*: DWORD
    dwCharPos*: DWORD
    pt*: POINT
    cLineHeight*: UINT
    rcDocument*: RECT
  PIMECHARPOSITION* = ptr IMECHARPOSITION
  NPIMECHARPOSITION* = ptr IMECHARPOSITION
  LPIMECHARPOSITION* = ptr IMECHARPOSITION
const
  IMC_GETCANDIDATEPOS* = 0x0007
  IMC_SETCANDIDATEPOS* = 0x0008
  IMC_GETCOMPOSITIONFONT* = 0x0009
  IMC_SETCOMPOSITIONFONT* = 0x000A
  IMC_GETCOMPOSITIONWINDOW* = 0x000B
  IMC_SETCOMPOSITIONWINDOW* = 0x000C
  IMC_GETSTATUSWINDOWPOS* = 0x000F
  IMC_SETSTATUSWINDOWPOS* = 0x0010
  IMC_CLOSESTATUSWINDOW* = 0x0021
  IMC_OPENSTATUSWINDOW* = 0x0022
  NI_OPENCANDIDATE* = 0x0010
  NI_CLOSECANDIDATE* = 0x0011
  NI_SELECTCANDIDATESTR* = 0x0012
  NI_CHANGECANDIDATELIST* = 0x0013
  NI_FINALIZECONVERSIONRESULT* = 0x0014
  NI_COMPOSITIONSTR* = 0x0015
  NI_SETCANDIDATE_PAGESTART* = 0x0016
  NI_SETCANDIDATE_PAGESIZE* = 0x0017
  NI_IMEMENUSELECTED* = 0x0018
  ISC_SHOWUICANDIDATEWINDOW* = 0x00000001
  ISC_SHOWUICOMPOSITIONWINDOW* = 0x80000000'i32
  ISC_SHOWUIGUIDELINE* = 0x40000000
  ISC_SHOWUIALLCANDIDATEWINDOW* = 0x0000000F
  ISC_SHOWUIALL* = 0xC000000F'i32
  CPS_COMPLETE* = 0x0001
  CPS_CONVERT* = 0x0002
  CPS_REVERT* = 0x0003
  CPS_CANCEL* = 0x0004
  MOD_LEFT* = 0x8000
  MOD_RIGHT* = 0x4000
  MOD_ON_KEYUP* = 0x0800
  MOD_IGNORE_ALL_MODIFIER* = 0x0400
  IME_CHOTKEY_IME_NONIME_TOGGLE* = 0x10
  IME_CHOTKEY_SHAPE_TOGGLE* = 0x11
  IME_CHOTKEY_SYMBOL_TOGGLE* = 0x12
  IME_JHOTKEY_CLOSE_OPEN* = 0x30
  IME_KHOTKEY_SHAPE_TOGGLE* = 0x50
  IME_KHOTKEY_HANJACONVERT* = 0x51
  IME_KHOTKEY_ENGLISH* = 0x52
  IME_THOTKEY_IME_NONIME_TOGGLE* = 0x70
  IME_THOTKEY_SHAPE_TOGGLE* = 0x71
  IME_THOTKEY_SYMBOL_TOGGLE* = 0x72
  IME_HOTKEY_DSWITCH_FIRST* = 0x100
  IME_HOTKEY_DSWITCH_LAST* = 0x11F
  IME_HOTKEY_PRIVATE_FIRST* = 0x200
  IME_ITHOTKEY_RESEND_RESULTSTR* = 0x200
  IME_ITHOTKEY_PREVIOUS_COMPOSITION* = 0x201
  IME_ITHOTKEY_UISTYLE_TOGGLE* = 0x202
  IME_ITHOTKEY_RECONVERTSTRING* = 0x203
  IME_HOTKEY_PRIVATE_LAST* = 0x21F
  GCS_COMPREADSTR* = 0x0001
  GCS_COMPREADATTR* = 0x0002
  GCS_COMPREADCLAUSE* = 0x0004
  GCS_COMPSTR* = 0x0008
  GCS_COMPATTR* = 0x0010
  GCS_COMPCLAUSE* = 0x0020
  GCS_CURSORPOS* = 0x0080
  GCS_DELTASTART* = 0x0100
  GCS_RESULTREADSTR* = 0x0200
  GCS_RESULTREADCLAUSE* = 0x0400
  GCS_RESULTSTR* = 0x0800
  GCS_RESULTCLAUSE* = 0x1000
  CS_INSERTCHAR* = 0x2000
  CS_NOMOVECARET* = 0x4000
  IMEVER_0310* = 0x0003000A
  IMEVER_0400* = 0x00040000
  IME_PROP_AT_CARET* = 0x00010000
  IME_PROP_SPECIAL_UI* = 0x00020000
  IME_PROP_CANDLIST_START_FROM_1* = 0x00040000
  IME_PROP_UNICODE* = 0x00080000
  IME_PROP_COMPLETE_ON_UNSELECT* = 0x00100000
  UI_CAP_2700* = 0x00000001
  UI_CAP_ROT90* = 0x00000002
  UI_CAP_ROTANY* = 0x00000004
  SCS_CAP_COMPSTR* = 0x00000001
  SCS_CAP_MAKEREAD* = 0x00000002
  SCS_CAP_SETRECONVERTSTRING* = 0x00000004
  SELECT_CAP_CONVERSION* = 0x00000001
  SELECT_CAP_SENTENCE* = 0x00000002
  GGL_LEVEL* = 0x00000001
  GGL_INDEX* = 0x00000002
  GGL_STRING* = 0x00000003
  GGL_PRIVATE* = 0x00000004
  GL_LEVEL_NOGUIDELINE* = 0x00000000
  GL_LEVEL_FATAL* = 0x00000001
  GL_LEVEL_ERROR* = 0x00000002
  GL_LEVEL_WARNING* = 0x00000003
  GL_LEVEL_INFORMATION* = 0x00000004
  GL_ID_UNKNOWN* = 0x00000000
  GL_ID_NOMODULE* = 0x00000001
  GL_ID_NODICTIONARY* = 0x00000010
  GL_ID_CANNOTSAVE* = 0x00000011
  GL_ID_NOCONVERT* = 0x00000020
  GL_ID_TYPINGERROR* = 0x00000021
  GL_ID_TOOMANYSTROKE* = 0x00000022
  GL_ID_READINGCONFLICT* = 0x00000023
  GL_ID_INPUTREADING* = 0x00000024
  GL_ID_INPUTRADICAL* = 0x00000025
  GL_ID_INPUTCODE* = 0x00000026
  GL_ID_INPUTSYMBOL* = 0x00000027
  GL_ID_CHOOSECANDIDATE* = 0x00000028
  GL_ID_REVERSECONVERSION* = 0x00000029
  GL_ID_PRIVATE_FIRST* = 0x00008000
  GL_ID_PRIVATE_LAST* = 0x0000FFFF
  IGP_PROPERTY* = 0x00000004
  IGP_CONVERSION* = 0x00000008
  IGP_SENTENCE* = 0x0000000c
  IGP_UI* = 0x00000010
  IGP_SETCOMPSTR* = 0x00000014
  IGP_SELECT* = 0x00000018
  SCS_SETSTR* = GCS_COMPREADSTR or GCS_COMPSTR
  SCS_CHANGEATTR* = GCS_COMPREADATTR or GCS_COMPATTR
  SCS_CHANGECLAUSE* = GCS_COMPREADCLAUSE or GCS_COMPCLAUSE
  SCS_SETRECONVERTSTRING* = 0x00010000
  SCS_QUERYRECONVERTSTRING* = 0x00020000
  ATTR_INPUT* = 0x00
  ATTR_TARGET_CONVERTED* = 0x01
  ATTR_CONVERTED* = 0x02
  ATTR_TARGET_NOTCONVERTED* = 0x03
  ATTR_INPUT_ERROR* = 0x04
  ATTR_FIXEDCONVERTED* = 0x05
  CFS_DEFAULT* = 0x0000
  CFS_RECT* = 0x0001
  CFS_POINT* = 0x0002
  CFS_FORCE_POSITION* = 0x0020
  CFS_CANDIDATEPOS* = 0x0040
  CFS_EXCLUDE* = 0x0080
  GCL_CONVERSION* = 0x0001
  GCL_REVERSECONVERSION* = 0x0002
  GCL_REVERSE_LENGTH* = 0x0003
  IME_CMODE_ALPHANUMERIC* = 0x0000
  IME_CMODE_NATIVE* = 0x0001
  IME_CMODE_CHINESE* = IME_CMODE_NATIVE
  IME_CMODE_HANGEUL* = IME_CMODE_NATIVE
  IME_CMODE_HANGUL* = IME_CMODE_NATIVE
  IME_CMODE_JAPANESE* = IME_CMODE_NATIVE
  IME_CMODE_KATAKANA* = 0x0002
  IME_CMODE_LANGUAGE* = 0x0003
  IME_CMODE_FULLSHAPE* = 0x0008
  IME_CMODE_ROMAN* = 0x0010
  IME_CMODE_CHARCODE* = 0x0020
  IME_CMODE_HANJACONVERT* = 0x0040
  IME_CMODE_SOFTKBD* = 0x0080
  IME_CMODE_NOCONVERSION* = 0x0100
  IME_CMODE_EUDC* = 0x0200
  IME_CMODE_SYMBOL* = 0x0400
  IME_CMODE_FIXED* = 0x0800
  IME_CMODE_RESERVED* = 0xF0000000'i32
  IME_SMODE_NONE* = 0x0000
  IME_SMODE_PLAURALCLAUSE* = 0x0001
  IME_SMODE_SINGLECONVERT* = 0x0002
  IME_SMODE_AUTOMATIC* = 0x0004
  IME_SMODE_PHRASEPREDICT* = 0x0008
  IME_SMODE_CONVERSATION* = 0x0010
  IME_SMODE_RESERVED* = 0x0000F000
  IME_CAND_UNKNOWN* = 0x0000
  IME_CAND_READ* = 0x0001
  IME_CAND_CODE* = 0x0002
  IME_CAND_MEANING* = 0x0003
  IME_CAND_RADICAL* = 0x0004
  IME_CAND_STROKE* = 0x0005
  IMN_CLOSESTATUSWINDOW* = 0x0001
  IMN_OPENSTATUSWINDOW* = 0x0002
  IMN_CHANGECANDIDATE* = 0x0003
  IMN_CLOSECANDIDATE* = 0x0004
  IMN_OPENCANDIDATE* = 0x0005
  IMN_SETCONVERSIONMODE* = 0x0006
  IMN_SETSENTENCEMODE* = 0x0007
  IMN_SETOPENSTATUS* = 0x0008
  IMN_SETCANDIDATEPOS* = 0x0009
  IMN_SETCOMPOSITIONFONT* = 0x000A
  IMN_SETCOMPOSITIONWINDOW* = 0x000B
  IMN_SETSTATUSWINDOWPOS* = 0x000C
  IMN_GUIDELINE* = 0x000D
  IMN_PRIVATE* = 0x000E
  IMR_COMPOSITIONWINDOW* = 0x0001
  IMR_CANDIDATEWINDOW* = 0x0002
  IMR_COMPOSITIONFONT* = 0x0003
  IMR_RECONVERTSTRING* = 0x0004
  IMR_CONFIRMRECONVERTSTRING* = 0x0005
  IMR_QUERYCHARPOSITION* = 0x0006
  IMR_DOCUMENTFEED* = 0x0007
  IMM_ERROR_NODATA* = -1
  IMM_ERROR_GENERAL* = -2
  IME_CONFIG_GENERAL* = 1
  IME_CONFIG_REGISTERWORD* = 2
  IME_CONFIG_SELECTDICTIONARY* = 3
  IME_ESC_QUERY_SUPPORT* = 0x0003
  IME_ESC_RESERVED_FIRST* = 0x0004
  IME_ESC_RESERVED_LAST* = 0x07FF
  IME_ESC_PRIVATE_FIRST* = 0x0800
  IME_ESC_PRIVATE_LAST* = 0x0FFF
  IME_ESC_SEQUENCE_TO_INTERNAL* = 0x1001
  IME_ESC_GET_EUDC_DICTIONARY* = 0x1003
  IME_ESC_SET_EUDC_DICTIONARY* = 0x1004
  IME_ESC_MAX_KEY* = 0x1005
  IME_ESC_IME_NAME* = 0x1006
  IME_ESC_SYNC_HOTKEY* = 0x1007
  IME_ESC_HANJA_MODE* = 0x1008
  IME_ESC_AUTOMATA* = 0x1009
  IME_ESC_PRIVATE_HOTKEY* = 0x100a
  IME_ESC_GETHELPFILENAME* = 0x100b
  IME_REGWORD_STYLE_EUDC* = 0x00000001
  IME_REGWORD_STYLE_USER_FIRST* = 0x80000000'i32
  IME_REGWORD_STYLE_USER_LAST* = 0xFFFFFFFF'i32
  IACE_CHILDREN* = 0x0001
  IACE_DEFAULT* = 0x0010
  IACE_IGNORENOCONTEXT* = 0x0020
  IGIMIF_RIGHTMENU* = 0x0001
  IGIMII_CMODE* = 0x0001
  IGIMII_SMODE* = 0x0002
  IGIMII_CONFIGURE* = 0x0004
  IGIMII_TOOLS* = 0x0008
  IGIMII_HELP* = 0x0010
  IGIMII_OTHER* = 0x0020
  IGIMII_INPUTTOOLS* = 0x0040
  IMFT_RADIOCHECK* = 0x00001
  IMFT_SEPARATOR* = 0x00002
  IMFT_SUBMENU* = 0x00004
  IMFS_GRAYED* = MFS_GRAYED
  IMFS_DISABLED* = MFS_DISABLED
  IMFS_CHECKED* = MFS_CHECKED
  IMFS_HILITE* = MFS_HILITE
  IMFS_ENABLED* = MFS_ENABLED
  IMFS_UNCHECKED* = MFS_UNCHECKED
  IMFS_UNHILITE* = MFS_UNHILITE
  IMFS_DEFAULT* = MFS_DEFAULT
  SOFTKEYBOARD_TYPE_T1* = 0x0001
  SOFTKEYBOARD_TYPE_C1* = 0x0002
  LIBID_ActiveIMM* = DEFINE_GUID("4955dd30-b159-11d0-8fcf-00aa006bcc59")
  IID_IEnumInputContext* = DEFINE_GUID("09b5eab0-f997-11d1-93d4-0060b067b86e")
  IID_IActiveIMMRegistrar* = DEFINE_GUID("b3458082-bd00-11d1-939b-0060b067b86e")
  IID_IActiveIMMMessagePumpOwner* = DEFINE_GUID("b5cf2cfa-8aeb-11d1-9364-0060b067b86e")
  IID_IActiveIMMApp* = DEFINE_GUID("08c0e040-62d1-11d1-9326-0060b067b86e")
  IID_IActiveIMMIME* = DEFINE_GUID("08c03411-f96b-11d0-a475-00aa006bcc59")
  IID_IActiveIME* = DEFINE_GUID("6fe20962-d077-11d0-8fe7-00aa006bcc59")
  IID_IActiveIME2* = DEFINE_GUID("e1c4bf0e-2d53-11d2-93e1-0060b067b86e")
  IID_IEnumRegisterWordA* = DEFINE_GUID("08c03412-f96b-11d0-a475-00aa006bcc59")
  IID_IEnumRegisterWordW* = DEFINE_GUID("4955dd31-b159-11d0-8fcf-00aa006bcc59")
  CLSID_CActiveIMM* = DEFINE_GUID("4955dd33-b159-11d0-8fcf-00aa006bcc59")
  IGP_GETIMEVERSION* = DWORD(-4)
type
  IMCENUMPROC* = proc (P1: HIMC, P2: LPARAM): WINBOOL {.stdcall.}
  REGISTERWORDENUMPROCA* = proc (P1: LPCSTR, P2: DWORD, P3: LPCSTR, P4: LPVOID): int32 {.stdcall.}
  REGISTERWORDENUMPROCW* = proc (P1: LPCWSTR, P2: DWORD, P3: LPCWSTR, P4: LPVOID): int32 {.stdcall.}
  INPUTCONTEXT_lfFont* {.pure, union.} = object
    A*: LOGFONTA
    W*: LOGFONTW
  INPUTCONTEXT* {.pure.} = object
    hWnd*: HWND
    fOpen*: WINBOOL
    ptStatusWndPos*: POINT
    ptSoftKbdPos*: POINT
    fdwConversion*: DWORD
    fdwSentence*: DWORD
    lfFont*: INPUTCONTEXT_lfFont
    cfCompForm*: COMPOSITIONFORM
    cfCandForm*: array[4, CANDIDATEFORM]
    hCompStr*: HIMCC
    hCandInfo*: HIMCC
    hGuideLine*: HIMCC
    hPrivate*: HIMCC
    dwNumMsgBuf*: DWORD
    hMsgBuf*: HIMCC
    fdwInit*: DWORD
    dwReserve*: array[3, DWORD]
  IMEINFO* {.pure.} = object
    dwPrivateDataSize*: DWORD
    fdwProperty*: DWORD
    fdwConversionCaps*: DWORD
    fdwSentenceCaps*: DWORD
    fdwUICaps*: DWORD
    fdwSCSCaps*: DWORD
    fdwSelectCaps*: DWORD
  IEnumInputContext* {.pure.} = object
    lpVtbl*: ptr IEnumInputContextVtbl
  IEnumInputContextVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Clone*: proc(self: ptr IEnumInputContext, ppEnum: ptr ptr IEnumInputContext): HRESULT {.stdcall.}
    Next*: proc(self: ptr IEnumInputContext, ulCount: ULONG, rgInputContext: ptr HIMC, pcFetched: ptr ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumInputContext): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumInputContext, ulCount: ULONG): HRESULT {.stdcall.}
  IActiveIMMRegistrar* {.pure.} = object
    lpVtbl*: ptr IActiveIMMRegistrarVtbl
  IActiveIMMRegistrarVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RegisterIME*: proc(self: ptr IActiveIMMRegistrar, rclsid: REFCLSID, lgid: LANGID, pszIconFile: LPCWSTR, pszDesc: LPCWSTR): HRESULT {.stdcall.}
    UnregisterIME*: proc(self: ptr IActiveIMMRegistrar, rclsid: REFCLSID): HRESULT {.stdcall.}
  IActiveIMMMessagePumpOwner* {.pure.} = object
    lpVtbl*: ptr IActiveIMMMessagePumpOwnerVtbl
  IActiveIMMMessagePumpOwnerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Start*: proc(self: ptr IActiveIMMMessagePumpOwner): HRESULT {.stdcall.}
    End*: proc(self: ptr IActiveIMMMessagePumpOwner): HRESULT {.stdcall.}
    OnTranslateMessage*: proc(self: ptr IActiveIMMMessagePumpOwner, pMsg: ptr MSG): HRESULT {.stdcall.}
    Pause*: proc(self: ptr IActiveIMMMessagePumpOwner, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Resume*: proc(self: ptr IActiveIMMMessagePumpOwner, dwCookie: DWORD): HRESULT {.stdcall.}
  IEnumRegisterWordA* {.pure.} = object
    lpVtbl*: ptr IEnumRegisterWordAVtbl
  IEnumRegisterWordAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Clone*: proc(self: ptr IEnumRegisterWordA, ppEnum: ptr ptr IEnumRegisterWordA): HRESULT {.stdcall.}
    Next*: proc(self: ptr IEnumRegisterWordA, ulCount: ULONG, rgRegisterWord: ptr REGISTERWORDA, pcFetched: ptr ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumRegisterWordA): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumRegisterWordA, ulCount: ULONG): HRESULT {.stdcall.}
  IEnumRegisterWordW* {.pure.} = object
    lpVtbl*: ptr IEnumRegisterWordWVtbl
  IEnumRegisterWordWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Clone*: proc(self: ptr IEnumRegisterWordW, ppEnum: ptr ptr IEnumRegisterWordW): HRESULT {.stdcall.}
    Next*: proc(self: ptr IEnumRegisterWordW, ulCount: ULONG, rgRegisterWord: ptr REGISTERWORDW, pcFetched: ptr ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumRegisterWordW): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumRegisterWordW, ulCount: ULONG): HRESULT {.stdcall.}
  IActiveIMMApp* {.pure.} = object
    lpVtbl*: ptr IActiveIMMAppVtbl
  IActiveIMMAppVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AssociateContext*: proc(self: ptr IActiveIMMApp, hWnd: HWND, hIME: HIMC, phPrev: ptr HIMC): HRESULT {.stdcall.}
    ConfigureIMEA*: proc(self: ptr IActiveIMMApp, hKL: HKL, hWnd: HWND, dwMode: DWORD, pData: ptr REGISTERWORDA): HRESULT {.stdcall.}
    ConfigureIMEW*: proc(self: ptr IActiveIMMApp, hKL: HKL, hWnd: HWND, dwMode: DWORD, pData: ptr REGISTERWORDW): HRESULT {.stdcall.}
    CreateContext*: proc(self: ptr IActiveIMMApp, phIMC: ptr HIMC): HRESULT {.stdcall.}
    DestroyContext*: proc(self: ptr IActiveIMMApp, hIME: HIMC): HRESULT {.stdcall.}
    EnumRegisterWordA*: proc(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szRegister: LPSTR, pData: LPVOID, pEnum: ptr ptr IEnumRegisterWordA): HRESULT {.stdcall.}
    EnumRegisterWordW*: proc(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR, pData: LPVOID, pEnum: ptr ptr IEnumRegisterWordW): HRESULT {.stdcall.}
    EscapeA*: proc(self: ptr IActiveIMMApp, hKL: HKL, hIMC: HIMC, uEscape: UINT, pData: LPVOID, plResult: ptr LRESULT): HRESULT {.stdcall.}
    EscapeW*: proc(self: ptr IActiveIMMApp, hKL: HKL, hIMC: HIMC, uEscape: UINT, pData: LPVOID, plResult: ptr LRESULT): HRESULT {.stdcall.}
    GetCandidateListA*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, uBufLen: UINT, pCandList: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetCandidateListW*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, uBufLen: UINT, pCandList: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetCandidateListCountA*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, pdwListSize: ptr DWORD, pdwBufLen: ptr DWORD): HRESULT {.stdcall.}
    GetCandidateListCountW*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, pdwListSize: ptr DWORD, pdwBufLen: ptr DWORD): HRESULT {.stdcall.}
    GetCandidateWindow*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, pCandidate: ptr CANDIDATEFORM): HRESULT {.stdcall.}
    GetCompositionFontA*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, plf: ptr LOGFONTA): HRESULT {.stdcall.}
    GetCompositionFontW*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, plf: ptr LOGFONTW): HRESULT {.stdcall.}
    GetCompositionStringA*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, plCopied: ptr LONG, pBuf: LPVOID): HRESULT {.stdcall.}
    GetCompositionStringW*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, plCopied: ptr LONG, pBuf: LPVOID): HRESULT {.stdcall.}
    GetCompositionWindow*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, pCompForm: ptr COMPOSITIONFORM): HRESULT {.stdcall.}
    GetContext*: proc(self: ptr IActiveIMMApp, hWnd: HWND, phIMC: ptr HIMC): HRESULT {.stdcall.}
    GetConversionListA*: proc(self: ptr IActiveIMMApp, hKL: HKL, hIMC: HIMC, pSrc: LPSTR, uBufLen: UINT, uFlag: UINT, pDst: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetConversionListW*: proc(self: ptr IActiveIMMApp, hKL: HKL, hIMC: HIMC, pSrc: LPWSTR, uBufLen: UINT, uFlag: UINT, pDst: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetConversionStatus*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, pfdwConversion: ptr DWORD, pfdwSentence: ptr DWORD): HRESULT {.stdcall.}
    GetDefaultIMEWnd*: proc(self: ptr IActiveIMMApp, hWnd: HWND, phDefWnd: ptr HWND): HRESULT {.stdcall.}
    GetDescriptionA*: proc(self: ptr IActiveIMMApp, hKL: HKL, uBufLen: UINT, szDescription: LPSTR, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetDescriptionW*: proc(self: ptr IActiveIMMApp, hKL: HKL, uBufLen: UINT, szDescription: LPWSTR, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetGuideLineA*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, pBuf: LPSTR, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    GetGuideLineW*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, pBuf: LPWSTR, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    GetIMEFileNameA*: proc(self: ptr IActiveIMMApp, hKL: HKL, uBufLen: UINT, szFileName: LPSTR, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetIMEFileNameW*: proc(self: ptr IActiveIMMApp, hKL: HKL, uBufLen: UINT, szFileName: LPWSTR, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetOpenStatus*: proc(self: ptr IActiveIMMApp, hIMC: HIMC): HRESULT {.stdcall.}
    GetProperty*: proc(self: ptr IActiveIMMApp, hKL: HKL, fdwIndex: DWORD, pdwProperty: ptr DWORD): HRESULT {.stdcall.}
    GetRegisterWordStyleA*: proc(self: ptr IActiveIMMApp, hKL: HKL, nItem: UINT, pStyleBuf: ptr STYLEBUFA, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetRegisterWordStyleW*: proc(self: ptr IActiveIMMApp, hKL: HKL, nItem: UINT, pStyleBuf: ptr STYLEBUFW, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetStatusWindowPos*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, pptPos: ptr POINT): HRESULT {.stdcall.}
    GetVirtualKey*: proc(self: ptr IActiveIMMApp, hWnd: HWND, puVirtualKey: ptr UINT): HRESULT {.stdcall.}
    InstallIMEA*: proc(self: ptr IActiveIMMApp, szIMEFileName: LPSTR, szLayoutText: LPSTR, phKL: ptr HKL): HRESULT {.stdcall.}
    InstallIMEW*: proc(self: ptr IActiveIMMApp, szIMEFileName: LPWSTR, szLayoutText: LPWSTR, phKL: ptr HKL): HRESULT {.stdcall.}
    IsIME*: proc(self: ptr IActiveIMMApp, hKL: HKL): HRESULT {.stdcall.}
    IsUIMessageA*: proc(self: ptr IActiveIMMApp, hWndIME: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
    IsUIMessageW*: proc(self: ptr IActiveIMMApp, hWndIME: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
    NotifyIME*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwAction: DWORD, dwIndex: DWORD, dwValue: DWORD): HRESULT {.stdcall.}
    RegisterWordA*: proc(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szRegister: LPSTR): HRESULT {.stdcall.}
    RegisterWordW*: proc(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR): HRESULT {.stdcall.}
    ReleaseContext*: proc(self: ptr IActiveIMMApp, hWnd: HWND, hIMC: HIMC): HRESULT {.stdcall.}
    SetCandidateWindow*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, pCandidate: ptr CANDIDATEFORM): HRESULT {.stdcall.}
    SetCompositionFontA*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, plf: ptr LOGFONTA): HRESULT {.stdcall.}
    SetCompositionFontW*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, plf: ptr LOGFONTW): HRESULT {.stdcall.}
    SetCompositionStringA*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, pComp: LPVOID, dwCompLen: DWORD, pRead: LPVOID, dwReadLen: DWORD): HRESULT {.stdcall.}
    SetCompositionStringW*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, pComp: LPVOID, dwCompLen: DWORD, pRead: LPVOID, dwReadLen: DWORD): HRESULT {.stdcall.}
    SetCompositionWindow*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, pCompForm: ptr COMPOSITIONFORM): HRESULT {.stdcall.}
    SetConversionStatus*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, fdwConversion: DWORD, fdwSentence: DWORD): HRESULT {.stdcall.}
    SetOpenStatus*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, fOpen: WINBOOL): HRESULT {.stdcall.}
    SetStatusWindowPos*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, pptPos: ptr POINT): HRESULT {.stdcall.}
    SimulateHotKey*: proc(self: ptr IActiveIMMApp, hWnd: HWND, dwHotKeyID: DWORD): HRESULT {.stdcall.}
    UnregisterWordA*: proc(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szUnregister: LPSTR): HRESULT {.stdcall.}
    UnregisterWordW*: proc(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szUnregister: LPWSTR): HRESULT {.stdcall.}
    Activate*: proc(self: ptr IActiveIMMApp, fRestoreLayout: WINBOOL): HRESULT {.stdcall.}
    Deactivate*: proc(self: ptr IActiveIMMApp): HRESULT {.stdcall.}
    OnDefWindowProc*: proc(self: ptr IActiveIMMApp, hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.stdcall.}
    FilterClientWindows*: proc(self: ptr IActiveIMMApp, aaClassList: ptr ATOM, uSize: UINT): HRESULT {.stdcall.}
    GetCodePageA*: proc(self: ptr IActiveIMMApp, hKL: HKL, uCodePage: ptr UINT): HRESULT {.stdcall.}
    GetLangId*: proc(self: ptr IActiveIMMApp, hKL: HKL, plid: ptr LANGID): HRESULT {.stdcall.}
    AssociateContextEx*: proc(self: ptr IActiveIMMApp, hWnd: HWND, hIMC: HIMC, dwFlags: DWORD): HRESULT {.stdcall.}
    DisableIME*: proc(self: ptr IActiveIMMApp, idThread: DWORD): HRESULT {.stdcall.}
    GetImeMenuItemsA*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwFlags: DWORD, dwType: DWORD, pImeParentMenu: ptr IMEMENUITEMINFOA, pImeMenu: ptr IMEMENUITEMINFOA, dwSize: DWORD, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    GetImeMenuItemsW*: proc(self: ptr IActiveIMMApp, hIMC: HIMC, dwFlags: DWORD, dwType: DWORD, pImeParentMenu: ptr IMEMENUITEMINFOW, pImeMenu: ptr IMEMENUITEMINFOW, dwSize: DWORD, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    EnumInputContext*: proc(self: ptr IActiveIMMApp, idThread: DWORD, ppEnum: ptr ptr IEnumInputContext): HRESULT {.stdcall.}
  IActiveIMMIME* {.pure.} = object
    lpVtbl*: ptr IActiveIMMIMEVtbl
  IActiveIMMIMEVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AssociateContext*: proc(self: ptr IActiveIMMIME, hWnd: HWND, hIME: HIMC, phPrev: ptr HIMC): HRESULT {.stdcall.}
    ConfigureIMEA*: proc(self: ptr IActiveIMMIME, hKL: HKL, hWnd: HWND, dwMode: DWORD, pData: ptr REGISTERWORDA): HRESULT {.stdcall.}
    ConfigureIMEW*: proc(self: ptr IActiveIMMIME, hKL: HKL, hWnd: HWND, dwMode: DWORD, pData: ptr REGISTERWORDW): HRESULT {.stdcall.}
    CreateContext*: proc(self: ptr IActiveIMMIME, phIMC: ptr HIMC): HRESULT {.stdcall.}
    DestroyContext*: proc(self: ptr IActiveIMMIME, hIME: HIMC): HRESULT {.stdcall.}
    EnumRegisterWordA*: proc(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szRegister: LPSTR, pData: LPVOID, pEnum: ptr ptr IEnumRegisterWordA): HRESULT {.stdcall.}
    EnumRegisterWordW*: proc(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR, pData: LPVOID, pEnum: ptr ptr IEnumRegisterWordW): HRESULT {.stdcall.}
    EscapeA*: proc(self: ptr IActiveIMMIME, hKL: HKL, hIMC: HIMC, uEscape: UINT, pData: LPVOID, plResult: ptr LRESULT): HRESULT {.stdcall.}
    EscapeW*: proc(self: ptr IActiveIMMIME, hKL: HKL, hIMC: HIMC, uEscape: UINT, pData: LPVOID, plResult: ptr LRESULT): HRESULT {.stdcall.}
    GetCandidateListA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, uBufLen: UINT, pCandList: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetCandidateListW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, uBufLen: UINT, pCandList: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetCandidateListCountA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pdwListSize: ptr DWORD, pdwBufLen: ptr DWORD): HRESULT {.stdcall.}
    GetCandidateListCountW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pdwListSize: ptr DWORD, pdwBufLen: ptr DWORD): HRESULT {.stdcall.}
    GetCandidateWindow*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, pCandidate: ptr CANDIDATEFORM): HRESULT {.stdcall.}
    GetCompositionFontA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, plf: ptr LOGFONTA): HRESULT {.stdcall.}
    GetCompositionFontW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, plf: ptr LOGFONTW): HRESULT {.stdcall.}
    GetCompositionStringA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, plCopied: ptr LONG, pBuf: LPVOID): HRESULT {.stdcall.}
    GetCompositionStringW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, plCopied: ptr LONG, pBuf: LPVOID): HRESULT {.stdcall.}
    GetCompositionWindow*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pCompForm: ptr COMPOSITIONFORM): HRESULT {.stdcall.}
    GetContext*: proc(self: ptr IActiveIMMIME, hWnd: HWND, phIMC: ptr HIMC): HRESULT {.stdcall.}
    GetConversionListA*: proc(self: ptr IActiveIMMIME, hKL: HKL, hIMC: HIMC, pSrc: LPSTR, uBufLen: UINT, uFlag: UINT, pDst: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetConversionListW*: proc(self: ptr IActiveIMMIME, hKL: HKL, hIMC: HIMC, pSrc: LPWSTR, uBufLen: UINT, uFlag: UINT, pDst: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetConversionStatus*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pfdwConversion: ptr DWORD, pfdwSentence: ptr DWORD): HRESULT {.stdcall.}
    GetDefaultIMEWnd*: proc(self: ptr IActiveIMMIME, hWnd: HWND, phDefWnd: ptr HWND): HRESULT {.stdcall.}
    GetDescriptionA*: proc(self: ptr IActiveIMMIME, hKL: HKL, uBufLen: UINT, szDescription: LPSTR, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetDescriptionW*: proc(self: ptr IActiveIMMIME, hKL: HKL, uBufLen: UINT, szDescription: LPWSTR, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetGuideLineA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, pBuf: LPSTR, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    GetGuideLineW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, pBuf: LPWSTR, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    GetIMEFileNameA*: proc(self: ptr IActiveIMMIME, hKL: HKL, uBufLen: UINT, szFileName: LPSTR, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetIMEFileNameW*: proc(self: ptr IActiveIMMIME, hKL: HKL, uBufLen: UINT, szFileName: LPWSTR, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetOpenStatus*: proc(self: ptr IActiveIMMIME, hIMC: HIMC): HRESULT {.stdcall.}
    GetProperty*: proc(self: ptr IActiveIMMIME, hKL: HKL, fdwIndex: DWORD, pdwProperty: ptr DWORD): HRESULT {.stdcall.}
    GetRegisterWordStyleA*: proc(self: ptr IActiveIMMIME, hKL: HKL, nItem: UINT, pStyleBuf: ptr STYLEBUFA, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetRegisterWordStyleW*: proc(self: ptr IActiveIMMIME, hKL: HKL, nItem: UINT, pStyleBuf: ptr STYLEBUFW, puCopied: ptr UINT): HRESULT {.stdcall.}
    GetStatusWindowPos*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pptPos: ptr POINT): HRESULT {.stdcall.}
    GetVirtualKey*: proc(self: ptr IActiveIMMIME, hWnd: HWND, puVirtualKey: ptr UINT): HRESULT {.stdcall.}
    InstallIMEA*: proc(self: ptr IActiveIMMIME, szIMEFileName: LPSTR, szLayoutText: LPSTR, phKL: ptr HKL): HRESULT {.stdcall.}
    InstallIMEW*: proc(self: ptr IActiveIMMIME, szIMEFileName: LPWSTR, szLayoutText: LPWSTR, phKL: ptr HKL): HRESULT {.stdcall.}
    IsIME*: proc(self: ptr IActiveIMMIME, hKL: HKL): HRESULT {.stdcall.}
    IsUIMessageA*: proc(self: ptr IActiveIMMIME, hWndIME: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
    IsUIMessageW*: proc(self: ptr IActiveIMMIME, hWndIME: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
    NotifyIME*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwAction: DWORD, dwIndex: DWORD, dwValue: DWORD): HRESULT {.stdcall.}
    RegisterWordA*: proc(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szRegister: LPSTR): HRESULT {.stdcall.}
    RegisterWordW*: proc(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR): HRESULT {.stdcall.}
    ReleaseContext*: proc(self: ptr IActiveIMMIME, hWnd: HWND, hIMC: HIMC): HRESULT {.stdcall.}
    SetCandidateWindow*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pCandidate: ptr CANDIDATEFORM): HRESULT {.stdcall.}
    SetCompositionFontA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, plf: ptr LOGFONTA): HRESULT {.stdcall.}
    SetCompositionFontW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, plf: ptr LOGFONTW): HRESULT {.stdcall.}
    SetCompositionStringA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, pComp: LPVOID, dwCompLen: DWORD, pRead: LPVOID, dwReadLen: DWORD): HRESULT {.stdcall.}
    SetCompositionStringW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, pComp: LPVOID, dwCompLen: DWORD, pRead: LPVOID, dwReadLen: DWORD): HRESULT {.stdcall.}
    SetCompositionWindow*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pCompForm: ptr COMPOSITIONFORM): HRESULT {.stdcall.}
    SetConversionStatus*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, fdwConversion: DWORD, fdwSentence: DWORD): HRESULT {.stdcall.}
    SetOpenStatus*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, fOpen: WINBOOL): HRESULT {.stdcall.}
    SetStatusWindowPos*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pptPos: ptr POINT): HRESULT {.stdcall.}
    SimulateHotKey*: proc(self: ptr IActiveIMMIME, hWnd: HWND, dwHotKeyID: DWORD): HRESULT {.stdcall.}
    UnregisterWordA*: proc(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szUnregister: LPSTR): HRESULT {.stdcall.}
    UnregisterWordW*: proc(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szUnregister: LPWSTR): HRESULT {.stdcall.}
    GenerateMessage*: proc(self: ptr IActiveIMMIME, hIMC: HIMC): HRESULT {.stdcall.}
    LockIMC*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, ppIMC: ptr ptr INPUTCONTEXT): HRESULT {.stdcall.}
    UnlockIMC*: proc(self: ptr IActiveIMMIME, hIMC: HIMC): HRESULT {.stdcall.}
    GetIMCLockCount*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, pdwLockCount: ptr DWORD): HRESULT {.stdcall.}
    CreateIMCC*: proc(self: ptr IActiveIMMIME, dwSize: DWORD, phIMCC: ptr HIMCC): HRESULT {.stdcall.}
    DestroyIMCC*: proc(self: ptr IActiveIMMIME, hIMCC: HIMCC): HRESULT {.stdcall.}
    LockIMCC*: proc(self: ptr IActiveIMMIME, hIMCC: HIMCC, ppv: ptr pointer): HRESULT {.stdcall.}
    UnlockIMCC*: proc(self: ptr IActiveIMMIME, hIMCC: HIMCC): HRESULT {.stdcall.}
    ReSizeIMCC*: proc(self: ptr IActiveIMMIME, hIMCC: HIMCC, dwSize: DWORD, phIMCC: ptr HIMCC): HRESULT {.stdcall.}
    GetIMCCSize*: proc(self: ptr IActiveIMMIME, hIMCC: HIMCC, pdwSize: ptr DWORD): HRESULT {.stdcall.}
    GetIMCCLockCount*: proc(self: ptr IActiveIMMIME, hIMCC: HIMCC, pdwLockCount: ptr DWORD): HRESULT {.stdcall.}
    GetHotKey*: proc(self: ptr IActiveIMMIME, dwHotKeyID: DWORD, puModifiers: ptr UINT, puVKey: ptr UINT, phKL: ptr HKL): HRESULT {.stdcall.}
    SetHotKey*: proc(self: ptr IActiveIMMIME, dwHotKeyID: DWORD, uModifiers: UINT, uVKey: UINT, hKL: HKL): HRESULT {.stdcall.}
    CreateSoftKeyboard*: proc(self: ptr IActiveIMMIME, uType: UINT, hOwner: HWND, x: int32, y: int32, phSoftKbdWnd: ptr HWND): HRESULT {.stdcall.}
    DestroySoftKeyboard*: proc(self: ptr IActiveIMMIME, hSoftKbdWnd: HWND): HRESULT {.stdcall.}
    ShowSoftKeyboard*: proc(self: ptr IActiveIMMIME, hSoftKbdWnd: HWND, nCmdShow: int32): HRESULT {.stdcall.}
    GetCodePageA*: proc(self: ptr IActiveIMMIME, hKL: HKL, uCodePage: ptr UINT): HRESULT {.stdcall.}
    GetLangId*: proc(self: ptr IActiveIMMIME, hKL: HKL, plid: ptr LANGID): HRESULT {.stdcall.}
    KeybdEvent*: proc(self: ptr IActiveIMMIME, lgidIME: LANGID, bVk: BYTE, bScan: BYTE, dwFlags: DWORD, dwExtraInfo: DWORD): HRESULT {.stdcall.}
    LockModal*: proc(self: ptr IActiveIMMIME): HRESULT {.stdcall.}
    UnlockModal*: proc(self: ptr IActiveIMMIME): HRESULT {.stdcall.}
    AssociateContextEx*: proc(self: ptr IActiveIMMIME, hWnd: HWND, hIMC: HIMC, dwFlags: DWORD): HRESULT {.stdcall.}
    DisableIME*: proc(self: ptr IActiveIMMIME, idThread: DWORD): HRESULT {.stdcall.}
    GetImeMenuItemsA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwFlags: DWORD, dwType: DWORD, pImeParentMenu: ptr IMEMENUITEMINFOA, pImeMenu: ptr IMEMENUITEMINFOA, dwSize: DWORD, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    GetImeMenuItemsW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, dwFlags: DWORD, dwType: DWORD, pImeParentMenu: ptr IMEMENUITEMINFOW, pImeMenu: ptr IMEMENUITEMINFOW, dwSize: DWORD, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    EnumInputContext*: proc(self: ptr IActiveIMMIME, idThread: DWORD, ppEnum: ptr ptr IEnumInputContext): HRESULT {.stdcall.}
    RequestMessageA*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.stdcall.}
    RequestMessageW*: proc(self: ptr IActiveIMMIME, hIMC: HIMC, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.stdcall.}
    SendIMCA*: proc(self: ptr IActiveIMMIME, hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.stdcall.}
    SendIMCW*: proc(self: ptr IActiveIMMIME, hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.stdcall.}
    IsSleeping*: proc(self: ptr IActiveIMMIME): HRESULT {.stdcall.}
  IActiveIME* {.pure.} = object
    lpVtbl*: ptr IActiveIMEVtbl
  IActiveIMEVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Inquire*: proc(self: ptr IActiveIME, dwSystemInfoFlags: DWORD, pIMEInfo: ptr IMEINFO, szWndClass: LPWSTR, pdwPrivate: ptr DWORD): HRESULT {.stdcall.}
    ConversionList*: proc(self: ptr IActiveIME, hIMC: HIMC, szSource: LPWSTR, uFlag: UINT, uBufLen: UINT, pDest: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.stdcall.}
    Configure*: proc(self: ptr IActiveIME, hKL: HKL, hWnd: HWND, dwMode: DWORD, pRegisterWord: ptr REGISTERWORDW): HRESULT {.stdcall.}
    Destroy*: proc(self: ptr IActiveIME, uReserved: UINT): HRESULT {.stdcall.}
    Escape*: proc(self: ptr IActiveIME, hIMC: HIMC, uEscape: UINT, pData: pointer, plResult: ptr LRESULT): HRESULT {.stdcall.}
    SetActiveContext*: proc(self: ptr IActiveIME, hIMC: HIMC, fFlag: WINBOOL): HRESULT {.stdcall.}
    ProcessKey*: proc(self: ptr IActiveIME, hIMC: HIMC, uVirKey: UINT, lParam: DWORD, pbKeyState: ptr BYTE): HRESULT {.stdcall.}
    Notify*: proc(self: ptr IActiveIME, hIMC: HIMC, dwAction: DWORD, dwIndex: DWORD, dwValue: DWORD): HRESULT {.stdcall.}
    Select*: proc(self: ptr IActiveIME, hIMC: HIMC, fSelect: WINBOOL): HRESULT {.stdcall.}
    SetCompositionString*: proc(self: ptr IActiveIME, hIMC: HIMC, dwIndex: DWORD, pComp: pointer, dwCompLen: DWORD, pRead: pointer, dwReadLen: DWORD): HRESULT {.stdcall.}
    ToAsciiEx*: proc(self: ptr IActiveIME, uVirKey: UINT, uScanCode: UINT, pbKeyState: ptr BYTE, fuState: UINT, hIMC: HIMC, pdwTransBuf: ptr DWORD, puSize: ptr UINT): HRESULT {.stdcall.}
    RegisterWord*: proc(self: ptr IActiveIME, szReading: LPWSTR, dwStyle: DWORD, szString: LPWSTR): HRESULT {.stdcall.}
    UnregisterWord*: proc(self: ptr IActiveIME, szReading: LPWSTR, dwStyle: DWORD, szString: LPWSTR): HRESULT {.stdcall.}
    GetRegisterWordStyle*: proc(self: ptr IActiveIME, nItem: UINT, pStyleBuf: ptr STYLEBUFW, puBufSize: ptr UINT): HRESULT {.stdcall.}
    EnumRegisterWord*: proc(self: ptr IActiveIME, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR, pData: LPVOID, ppEnum: ptr ptr IEnumRegisterWordW): HRESULT {.stdcall.}
    GetCodePageA*: proc(self: ptr IActiveIME, uCodePage: ptr UINT): HRESULT {.stdcall.}
    GetLangId*: proc(self: ptr IActiveIME, plid: ptr LANGID): HRESULT {.stdcall.}
  IActiveIME2* {.pure.} = object
    lpVtbl*: ptr IActiveIME2Vtbl
  IActiveIME2Vtbl* {.pure, inheritable.} = object of IActiveIMEVtbl
    Sleep*: proc(self: ptr IActiveIME2): HRESULT {.stdcall.}
    Unsleep*: proc(self: ptr IActiveIME2, fDead: WINBOOL): HRESULT {.stdcall.}
proc ImmInstallIMEA*(lpszIMEFileName: LPCSTR, lpszLayoutText: LPCSTR): HKL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmInstallIMEW*(lpszIMEFileName: LPCWSTR, lpszLayoutText: LPCWSTR): HKL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetDefaultIMEWnd*(P1: HWND): HWND {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetDescriptionA*(P1: HKL, P2: LPSTR, uBufLen: UINT): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetDescriptionW*(P1: HKL, P2: LPWSTR, uBufLen: UINT): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetIMEFileNameA*(P1: HKL, P2: LPSTR, uBufLen: UINT): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetIMEFileNameW*(P1: HKL, P2: LPWSTR, uBufLen: UINT): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetProperty*(P1: HKL, P2: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmIsIME*(P1: HKL): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSimulateHotKey*(P1: HWND, P2: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmCreateContext*(): HIMC {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmDestroyContext*(P1: HIMC): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetContext*(P1: HWND): HIMC {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmReleaseContext*(P1: HWND, P2: HIMC): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmAssociateContext*(P1: HWND, P2: HIMC): HIMC {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmAssociateContextEx*(P1: HWND, P2: HIMC, P3: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCompositionStringA*(P1: HIMC, P2: DWORD, P3: LPVOID, P4: DWORD): LONG {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCompositionStringW*(P1: HIMC, P2: DWORD, P3: LPVOID, P4: DWORD): LONG {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetCompositionStringA*(P1: HIMC, dwIndex: DWORD, lpComp: LPVOID, P4: DWORD, lpRead: LPVOID, P6: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetCompositionStringW*(P1: HIMC, dwIndex: DWORD, lpComp: LPVOID, P4: DWORD, lpRead: LPVOID, P6: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCandidateListCountA*(P1: HIMC, lpdwListCount: LPDWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCandidateListCountW*(P1: HIMC, lpdwListCount: LPDWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCandidateListA*(P1: HIMC, deIndex: DWORD, P3: LPCANDIDATELIST, dwBufLen: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCandidateListW*(P1: HIMC, deIndex: DWORD, P3: LPCANDIDATELIST, dwBufLen: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetGuideLineA*(P1: HIMC, dwIndex: DWORD, P3: LPSTR, dwBufLen: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetGuideLineW*(P1: HIMC, dwIndex: DWORD, P3: LPWSTR, dwBufLen: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetConversionStatus*(P1: HIMC, P2: LPDWORD, P3: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetConversionStatus*(P1: HIMC, P2: DWORD, P3: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetOpenStatus*(P1: HIMC): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetOpenStatus*(P1: HIMC, P2: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCompositionFontA*(P1: HIMC, P2: LPLOGFONTA): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCompositionFontW*(P1: HIMC, P2: LPLOGFONTW): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetCompositionFontA*(P1: HIMC, P2: LPLOGFONTA): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetCompositionFontW*(P1: HIMC, P2: LPLOGFONTW): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmConfigureIMEA*(P1: HKL, P2: HWND, P3: DWORD, P4: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmConfigureIMEW*(P1: HKL, P2: HWND, P3: DWORD, P4: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmEscapeA*(P1: HKL, P2: HIMC, P3: UINT, P4: LPVOID): LRESULT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmEscapeW*(P1: HKL, P2: HIMC, P3: UINT, P4: LPVOID): LRESULT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetConversionListA*(P1: HKL, P2: HIMC, P3: LPCSTR, P4: LPCANDIDATELIST, dwBufLen: DWORD, uFlag: UINT): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetConversionListW*(P1: HKL, P2: HIMC, P3: LPCWSTR, P4: LPCANDIDATELIST, dwBufLen: DWORD, uFlag: UINT): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmNotifyIME*(P1: HIMC, dwAction: DWORD, dwIndex: DWORD, dwValue: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetStatusWindowPos*(P1: HIMC, P2: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetStatusWindowPos*(P1: HIMC, P2: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCompositionWindow*(P1: HIMC, P2: LPCOMPOSITIONFORM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetCompositionWindow*(P1: HIMC, P2: LPCOMPOSITIONFORM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetCandidateWindow*(P1: HIMC, P2: DWORD, P3: LPCANDIDATEFORM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmSetCandidateWindow*(P1: HIMC, P2: LPCANDIDATEFORM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmIsUIMessageA*(P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmIsUIMessageW*(P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetVirtualKey*(P1: HWND): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmRegisterWordA*(P1: HKL, lpszReading: LPCSTR, P3: DWORD, lpszRegister: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmRegisterWordW*(P1: HKL, lpszReading: LPCWSTR, P3: DWORD, lpszRegister: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmUnregisterWordA*(P1: HKL, lpszReading: LPCSTR, P3: DWORD, lpszUnregister: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmUnregisterWordW*(P1: HKL, lpszReading: LPCWSTR, P3: DWORD, lpszUnregister: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetRegisterWordStyleA*(P1: HKL, nItem: UINT, P3: LPSTYLEBUFA): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetRegisterWordStyleW*(P1: HKL, nItem: UINT, P3: LPSTYLEBUFW): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmEnumRegisterWordA*(P1: HKL, P2: REGISTERWORDENUMPROCA, lpszReading: LPCSTR, P4: DWORD, lpszRegister: LPCSTR, P6: LPVOID): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmEnumRegisterWordW*(P1: HKL, P2: REGISTERWORDENUMPROCW, lpszReading: LPCWSTR, P4: DWORD, lpszRegister: LPCWSTR, P6: LPVOID): UINT {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmDisableIME*(P1: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmEnumInputContext*(idThread: DWORD, lpfn: IMCENUMPROC, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetImeMenuItemsA*(P1: HIMC, P2: DWORD, P3: DWORD, P4: LPIMEMENUITEMINFOA, P5: LPIMEMENUITEMINFOA, P6: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmGetImeMenuItemsW*(P1: HIMC, P2: DWORD, P3: DWORD, P4: LPIMEMENUITEMINFOW, P5: LPIMEMENUITEMINFOW, P6: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc.}
proc ImmDisableTextFrameService*(idThread: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc.}
proc Clone*(self: ptr IEnumInputContext, ppEnum: ptr ptr IEnumInputContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc Next*(self: ptr IEnumInputContext, ulCount: ULONG, rgInputContext: ptr HIMC, pcFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, ulCount, rgInputContext, pcFetched)
proc Reset*(self: ptr IEnumInputContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Skip*(self: ptr IEnumInputContext, ulCount: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, ulCount)
proc RegisterIME*(self: ptr IActiveIMMRegistrar, rclsid: REFCLSID, lgid: LANGID, pszIconFile: LPCWSTR, pszDesc: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterIME(self, rclsid, lgid, pszIconFile, pszDesc)
proc UnregisterIME*(self: ptr IActiveIMMRegistrar, rclsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterIME(self, rclsid)
proc Start*(self: ptr IActiveIMMMessagePumpOwner): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Start(self)
proc End*(self: ptr IActiveIMMMessagePumpOwner): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.End(self)
proc OnTranslateMessage*(self: ptr IActiveIMMMessagePumpOwner, pMsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnTranslateMessage(self, pMsg)
proc Pause*(self: ptr IActiveIMMMessagePumpOwner, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Pause(self, pdwCookie)
proc Resume*(self: ptr IActiveIMMMessagePumpOwner, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resume(self, dwCookie)
proc AssociateContext*(self: ptr IActiveIMMApp, hWnd: HWND, hIME: HIMC, phPrev: ptr HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AssociateContext(self, hWnd, hIME, phPrev)
proc ConfigureIMEA*(self: ptr IActiveIMMApp, hKL: HKL, hWnd: HWND, dwMode: DWORD, pData: ptr REGISTERWORDA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConfigureIMEA(self, hKL, hWnd, dwMode, pData)
proc ConfigureIMEW*(self: ptr IActiveIMMApp, hKL: HKL, hWnd: HWND, dwMode: DWORD, pData: ptr REGISTERWORDW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConfigureIMEW(self, hKL, hWnd, dwMode, pData)
proc CreateContext*(self: ptr IActiveIMMApp, phIMC: ptr HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateContext(self, phIMC)
proc DestroyContext*(self: ptr IActiveIMMApp, hIME: HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DestroyContext(self, hIME)
proc EnumRegisterWordA*(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szRegister: LPSTR, pData: LPVOID, pEnum: ptr ptr IEnumRegisterWordA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumRegisterWordA(self, hKL, szReading, dwStyle, szRegister, pData, pEnum)
proc EnumRegisterWordW*(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR, pData: LPVOID, pEnum: ptr ptr IEnumRegisterWordW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumRegisterWordW(self, hKL, szReading, dwStyle, szRegister, pData, pEnum)
proc EscapeA*(self: ptr IActiveIMMApp, hKL: HKL, hIMC: HIMC, uEscape: UINT, pData: LPVOID, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EscapeA(self, hKL, hIMC, uEscape, pData, plResult)
proc EscapeW*(self: ptr IActiveIMMApp, hKL: HKL, hIMC: HIMC, uEscape: UINT, pData: LPVOID, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EscapeW(self, hKL, hIMC, uEscape, pData, plResult)
proc GetCandidateListA*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, uBufLen: UINT, pCandList: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateListA(self, hIMC, dwIndex, uBufLen, pCandList, puCopied)
proc GetCandidateListW*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, uBufLen: UINT, pCandList: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateListW(self, hIMC, dwIndex, uBufLen, pCandList, puCopied)
proc GetCandidateListCountA*(self: ptr IActiveIMMApp, hIMC: HIMC, pdwListSize: ptr DWORD, pdwBufLen: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateListCountA(self, hIMC, pdwListSize, pdwBufLen)
proc GetCandidateListCountW*(self: ptr IActiveIMMApp, hIMC: HIMC, pdwListSize: ptr DWORD, pdwBufLen: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateListCountW(self, hIMC, pdwListSize, pdwBufLen)
proc GetCandidateWindow*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, pCandidate: ptr CANDIDATEFORM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateWindow(self, hIMC, dwIndex, pCandidate)
proc GetCompositionFontA*(self: ptr IActiveIMMApp, hIMC: HIMC, plf: ptr LOGFONTA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionFontA(self, hIMC, plf)
proc GetCompositionFontW*(self: ptr IActiveIMMApp, hIMC: HIMC, plf: ptr LOGFONTW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionFontW(self, hIMC, plf)
proc GetCompositionStringA*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, plCopied: ptr LONG, pBuf: LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionStringA(self, hIMC, dwIndex, dwBufLen, plCopied, pBuf)
proc GetCompositionStringW*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, plCopied: ptr LONG, pBuf: LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionStringW(self, hIMC, dwIndex, dwBufLen, plCopied, pBuf)
proc GetCompositionWindow*(self: ptr IActiveIMMApp, hIMC: HIMC, pCompForm: ptr COMPOSITIONFORM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionWindow(self, hIMC, pCompForm)
proc GetContext*(self: ptr IActiveIMMApp, hWnd: HWND, phIMC: ptr HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContext(self, hWnd, phIMC)
proc GetConversionListA*(self: ptr IActiveIMMApp, hKL: HKL, hIMC: HIMC, pSrc: LPSTR, uBufLen: UINT, uFlag: UINT, pDst: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConversionListA(self, hKL, hIMC, pSrc, uBufLen, uFlag, pDst, puCopied)
proc GetConversionListW*(self: ptr IActiveIMMApp, hKL: HKL, hIMC: HIMC, pSrc: LPWSTR, uBufLen: UINT, uFlag: UINT, pDst: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConversionListW(self, hKL, hIMC, pSrc, uBufLen, uFlag, pDst, puCopied)
proc GetConversionStatus*(self: ptr IActiveIMMApp, hIMC: HIMC, pfdwConversion: ptr DWORD, pfdwSentence: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConversionStatus(self, hIMC, pfdwConversion, pfdwSentence)
proc GetDefaultIMEWnd*(self: ptr IActiveIMMApp, hWnd: HWND, phDefWnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultIMEWnd(self, hWnd, phDefWnd)
proc GetDescriptionA*(self: ptr IActiveIMMApp, hKL: HKL, uBufLen: UINT, szDescription: LPSTR, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescriptionA(self, hKL, uBufLen, szDescription, puCopied)
proc GetDescriptionW*(self: ptr IActiveIMMApp, hKL: HKL, uBufLen: UINT, szDescription: LPWSTR, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescriptionW(self, hKL, uBufLen, szDescription, puCopied)
proc GetGuideLineA*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, pBuf: LPSTR, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGuideLineA(self, hIMC, dwIndex, dwBufLen, pBuf, pdwResult)
proc GetGuideLineW*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, pBuf: LPWSTR, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGuideLineW(self, hIMC, dwIndex, dwBufLen, pBuf, pdwResult)
proc GetIMEFileNameA*(self: ptr IActiveIMMApp, hKL: HKL, uBufLen: UINT, szFileName: LPSTR, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIMEFileNameA(self, hKL, uBufLen, szFileName, puCopied)
proc GetIMEFileNameW*(self: ptr IActiveIMMApp, hKL: HKL, uBufLen: UINT, szFileName: LPWSTR, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIMEFileNameW(self, hKL, uBufLen, szFileName, puCopied)
proc GetOpenStatus*(self: ptr IActiveIMMApp, hIMC: HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOpenStatus(self, hIMC)
proc GetProperty*(self: ptr IActiveIMMApp, hKL: HKL, fdwIndex: DWORD, pdwProperty: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, hKL, fdwIndex, pdwProperty)
proc GetRegisterWordStyleA*(self: ptr IActiveIMMApp, hKL: HKL, nItem: UINT, pStyleBuf: ptr STYLEBUFA, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRegisterWordStyleA(self, hKL, nItem, pStyleBuf, puCopied)
proc GetRegisterWordStyleW*(self: ptr IActiveIMMApp, hKL: HKL, nItem: UINT, pStyleBuf: ptr STYLEBUFW, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRegisterWordStyleW(self, hKL, nItem, pStyleBuf, puCopied)
proc GetStatusWindowPos*(self: ptr IActiveIMMApp, hIMC: HIMC, pptPos: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStatusWindowPos(self, hIMC, pptPos)
proc GetVirtualKey*(self: ptr IActiveIMMApp, hWnd: HWND, puVirtualKey: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVirtualKey(self, hWnd, puVirtualKey)
proc InstallIMEA*(self: ptr IActiveIMMApp, szIMEFileName: LPSTR, szLayoutText: LPSTR, phKL: ptr HKL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InstallIMEA(self, szIMEFileName, szLayoutText, phKL)
proc InstallIMEW*(self: ptr IActiveIMMApp, szIMEFileName: LPWSTR, szLayoutText: LPWSTR, phKL: ptr HKL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InstallIMEW(self, szIMEFileName, szLayoutText, phKL)
proc IsIME*(self: ptr IActiveIMMApp, hKL: HKL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsIME(self, hKL)
proc IsUIMessageA*(self: ptr IActiveIMMApp, hWndIME: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsUIMessageA(self, hWndIME, msg, wParam, lParam)
proc IsUIMessageW*(self: ptr IActiveIMMApp, hWndIME: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsUIMessageW(self, hWndIME, msg, wParam, lParam)
proc NotifyIME*(self: ptr IActiveIMMApp, hIMC: HIMC, dwAction: DWORD, dwIndex: DWORD, dwValue: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NotifyIME(self, hIMC, dwAction, dwIndex, dwValue)
proc mRegisterWordA*(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szRegister: LPSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterWordA(self, hKL, szReading, dwStyle, szRegister)
proc mRegisterWordW*(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterWordW(self, hKL, szReading, dwStyle, szRegister)
proc ReleaseContext*(self: ptr IActiveIMMApp, hWnd: HWND, hIMC: HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseContext(self, hWnd, hIMC)
proc SetCandidateWindow*(self: ptr IActiveIMMApp, hIMC: HIMC, pCandidate: ptr CANDIDATEFORM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCandidateWindow(self, hIMC, pCandidate)
proc SetCompositionFontA*(self: ptr IActiveIMMApp, hIMC: HIMC, plf: ptr LOGFONTA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionFontA(self, hIMC, plf)
proc SetCompositionFontW*(self: ptr IActiveIMMApp, hIMC: HIMC, plf: ptr LOGFONTW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionFontW(self, hIMC, plf)
proc SetCompositionStringA*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, pComp: LPVOID, dwCompLen: DWORD, pRead: LPVOID, dwReadLen: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionStringA(self, hIMC, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
proc SetCompositionStringW*(self: ptr IActiveIMMApp, hIMC: HIMC, dwIndex: DWORD, pComp: LPVOID, dwCompLen: DWORD, pRead: LPVOID, dwReadLen: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionStringW(self, hIMC, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
proc SetCompositionWindow*(self: ptr IActiveIMMApp, hIMC: HIMC, pCompForm: ptr COMPOSITIONFORM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionWindow(self, hIMC, pCompForm)
proc SetConversionStatus*(self: ptr IActiveIMMApp, hIMC: HIMC, fdwConversion: DWORD, fdwSentence: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetConversionStatus(self, hIMC, fdwConversion, fdwSentence)
proc SetOpenStatus*(self: ptr IActiveIMMApp, hIMC: HIMC, fOpen: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOpenStatus(self, hIMC, fOpen)
proc SetStatusWindowPos*(self: ptr IActiveIMMApp, hIMC: HIMC, pptPos: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetStatusWindowPos(self, hIMC, pptPos)
proc SimulateHotKey*(self: ptr IActiveIMMApp, hWnd: HWND, dwHotKeyID: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SimulateHotKey(self, hWnd, dwHotKeyID)
proc UnregisterWordA*(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szUnregister: LPSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterWordA(self, hKL, szReading, dwStyle, szUnregister)
proc UnregisterWordW*(self: ptr IActiveIMMApp, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szUnregister: LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterWordW(self, hKL, szReading, dwStyle, szUnregister)
proc Activate*(self: ptr IActiveIMMApp, fRestoreLayout: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Activate(self, fRestoreLayout)
proc Deactivate*(self: ptr IActiveIMMApp): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Deactivate(self)
proc OnDefWindowProc*(self: ptr IActiveIMMApp, hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDefWindowProc(self, hWnd, Msg, wParam, lParam, plResult)
proc FilterClientWindows*(self: ptr IActiveIMMApp, aaClassList: ptr ATOM, uSize: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FilterClientWindows(self, aaClassList, uSize)
proc GetCodePageA*(self: ptr IActiveIMMApp, hKL: HKL, uCodePage: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCodePageA(self, hKL, uCodePage)
proc GetLangId*(self: ptr IActiveIMMApp, hKL: HKL, plid: ptr LANGID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLangId(self, hKL, plid)
proc AssociateContextEx*(self: ptr IActiveIMMApp, hWnd: HWND, hIMC: HIMC, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AssociateContextEx(self, hWnd, hIMC, dwFlags)
proc DisableIME*(self: ptr IActiveIMMApp, idThread: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DisableIME(self, idThread)
proc GetImeMenuItemsA*(self: ptr IActiveIMMApp, hIMC: HIMC, dwFlags: DWORD, dwType: DWORD, pImeParentMenu: ptr IMEMENUITEMINFOA, pImeMenu: ptr IMEMENUITEMINFOA, dwSize: DWORD, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImeMenuItemsA(self, hIMC, dwFlags, dwType, pImeParentMenu, pImeMenu, dwSize, pdwResult)
proc GetImeMenuItemsW*(self: ptr IActiveIMMApp, hIMC: HIMC, dwFlags: DWORD, dwType: DWORD, pImeParentMenu: ptr IMEMENUITEMINFOW, pImeMenu: ptr IMEMENUITEMINFOW, dwSize: DWORD, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImeMenuItemsW(self, hIMC, dwFlags, dwType, pImeParentMenu, pImeMenu, dwSize, pdwResult)
proc EnumInputContext*(self: ptr IActiveIMMApp, idThread: DWORD, ppEnum: ptr ptr IEnumInputContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumInputContext(self, idThread, ppEnum)
proc AssociateContext*(self: ptr IActiveIMMIME, hWnd: HWND, hIME: HIMC, phPrev: ptr HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AssociateContext(self, hWnd, hIME, phPrev)
proc ConfigureIMEA*(self: ptr IActiveIMMIME, hKL: HKL, hWnd: HWND, dwMode: DWORD, pData: ptr REGISTERWORDA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConfigureIMEA(self, hKL, hWnd, dwMode, pData)
proc ConfigureIMEW*(self: ptr IActiveIMMIME, hKL: HKL, hWnd: HWND, dwMode: DWORD, pData: ptr REGISTERWORDW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConfigureIMEW(self, hKL, hWnd, dwMode, pData)
proc CreateContext*(self: ptr IActiveIMMIME, phIMC: ptr HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateContext(self, phIMC)
proc DestroyContext*(self: ptr IActiveIMMIME, hIME: HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DestroyContext(self, hIME)
proc EnumRegisterWordA*(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szRegister: LPSTR, pData: LPVOID, pEnum: ptr ptr IEnumRegisterWordA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumRegisterWordA(self, hKL, szReading, dwStyle, szRegister, pData, pEnum)
proc EnumRegisterWordW*(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR, pData: LPVOID, pEnum: ptr ptr IEnumRegisterWordW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumRegisterWordW(self, hKL, szReading, dwStyle, szRegister, pData, pEnum)
proc EscapeA*(self: ptr IActiveIMMIME, hKL: HKL, hIMC: HIMC, uEscape: UINT, pData: LPVOID, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EscapeA(self, hKL, hIMC, uEscape, pData, plResult)
proc EscapeW*(self: ptr IActiveIMMIME, hKL: HKL, hIMC: HIMC, uEscape: UINT, pData: LPVOID, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EscapeW(self, hKL, hIMC, uEscape, pData, plResult)
proc GetCandidateListA*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, uBufLen: UINT, pCandList: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateListA(self, hIMC, dwIndex, uBufLen, pCandList, puCopied)
proc GetCandidateListW*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, uBufLen: UINT, pCandList: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateListW(self, hIMC, dwIndex, uBufLen, pCandList, puCopied)
proc GetCandidateListCountA*(self: ptr IActiveIMMIME, hIMC: HIMC, pdwListSize: ptr DWORD, pdwBufLen: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateListCountA(self, hIMC, pdwListSize, pdwBufLen)
proc GetCandidateListCountW*(self: ptr IActiveIMMIME, hIMC: HIMC, pdwListSize: ptr DWORD, pdwBufLen: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateListCountW(self, hIMC, pdwListSize, pdwBufLen)
proc GetCandidateWindow*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, pCandidate: ptr CANDIDATEFORM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCandidateWindow(self, hIMC, dwIndex, pCandidate)
proc GetCompositionFontA*(self: ptr IActiveIMMIME, hIMC: HIMC, plf: ptr LOGFONTA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionFontA(self, hIMC, plf)
proc GetCompositionFontW*(self: ptr IActiveIMMIME, hIMC: HIMC, plf: ptr LOGFONTW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionFontW(self, hIMC, plf)
proc GetCompositionStringA*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, plCopied: ptr LONG, pBuf: LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionStringA(self, hIMC, dwIndex, dwBufLen, plCopied, pBuf)
proc GetCompositionStringW*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, plCopied: ptr LONG, pBuf: LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionStringW(self, hIMC, dwIndex, dwBufLen, plCopied, pBuf)
proc GetCompositionWindow*(self: ptr IActiveIMMIME, hIMC: HIMC, pCompForm: ptr COMPOSITIONFORM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionWindow(self, hIMC, pCompForm)
proc GetContext*(self: ptr IActiveIMMIME, hWnd: HWND, phIMC: ptr HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContext(self, hWnd, phIMC)
proc GetConversionListA*(self: ptr IActiveIMMIME, hKL: HKL, hIMC: HIMC, pSrc: LPSTR, uBufLen: UINT, uFlag: UINT, pDst: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConversionListA(self, hKL, hIMC, pSrc, uBufLen, uFlag, pDst, puCopied)
proc GetConversionListW*(self: ptr IActiveIMMIME, hKL: HKL, hIMC: HIMC, pSrc: LPWSTR, uBufLen: UINT, uFlag: UINT, pDst: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConversionListW(self, hKL, hIMC, pSrc, uBufLen, uFlag, pDst, puCopied)
proc GetConversionStatus*(self: ptr IActiveIMMIME, hIMC: HIMC, pfdwConversion: ptr DWORD, pfdwSentence: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConversionStatus(self, hIMC, pfdwConversion, pfdwSentence)
proc GetDefaultIMEWnd*(self: ptr IActiveIMMIME, hWnd: HWND, phDefWnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultIMEWnd(self, hWnd, phDefWnd)
proc GetDescriptionA*(self: ptr IActiveIMMIME, hKL: HKL, uBufLen: UINT, szDescription: LPSTR, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescriptionA(self, hKL, uBufLen, szDescription, puCopied)
proc GetDescriptionW*(self: ptr IActiveIMMIME, hKL: HKL, uBufLen: UINT, szDescription: LPWSTR, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescriptionW(self, hKL, uBufLen, szDescription, puCopied)
proc GetGuideLineA*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, pBuf: LPSTR, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGuideLineA(self, hIMC, dwIndex, dwBufLen, pBuf, pdwResult)
proc GetGuideLineW*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, dwBufLen: DWORD, pBuf: LPWSTR, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGuideLineW(self, hIMC, dwIndex, dwBufLen, pBuf, pdwResult)
proc GetIMEFileNameA*(self: ptr IActiveIMMIME, hKL: HKL, uBufLen: UINT, szFileName: LPSTR, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIMEFileNameA(self, hKL, uBufLen, szFileName, puCopied)
proc GetIMEFileNameW*(self: ptr IActiveIMMIME, hKL: HKL, uBufLen: UINT, szFileName: LPWSTR, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIMEFileNameW(self, hKL, uBufLen, szFileName, puCopied)
proc GetOpenStatus*(self: ptr IActiveIMMIME, hIMC: HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOpenStatus(self, hIMC)
proc GetProperty*(self: ptr IActiveIMMIME, hKL: HKL, fdwIndex: DWORD, pdwProperty: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, hKL, fdwIndex, pdwProperty)
proc GetRegisterWordStyleA*(self: ptr IActiveIMMIME, hKL: HKL, nItem: UINT, pStyleBuf: ptr STYLEBUFA, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRegisterWordStyleA(self, hKL, nItem, pStyleBuf, puCopied)
proc GetRegisterWordStyleW*(self: ptr IActiveIMMIME, hKL: HKL, nItem: UINT, pStyleBuf: ptr STYLEBUFW, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRegisterWordStyleW(self, hKL, nItem, pStyleBuf, puCopied)
proc GetStatusWindowPos*(self: ptr IActiveIMMIME, hIMC: HIMC, pptPos: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStatusWindowPos(self, hIMC, pptPos)
proc GetVirtualKey*(self: ptr IActiveIMMIME, hWnd: HWND, puVirtualKey: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVirtualKey(self, hWnd, puVirtualKey)
proc InstallIMEA*(self: ptr IActiveIMMIME, szIMEFileName: LPSTR, szLayoutText: LPSTR, phKL: ptr HKL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InstallIMEA(self, szIMEFileName, szLayoutText, phKL)
proc InstallIMEW*(self: ptr IActiveIMMIME, szIMEFileName: LPWSTR, szLayoutText: LPWSTR, phKL: ptr HKL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InstallIMEW(self, szIMEFileName, szLayoutText, phKL)
proc IsIME*(self: ptr IActiveIMMIME, hKL: HKL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsIME(self, hKL)
proc IsUIMessageA*(self: ptr IActiveIMMIME, hWndIME: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsUIMessageA(self, hWndIME, msg, wParam, lParam)
proc IsUIMessageW*(self: ptr IActiveIMMIME, hWndIME: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsUIMessageW(self, hWndIME, msg, wParam, lParam)
proc NotifyIME*(self: ptr IActiveIMMIME, hIMC: HIMC, dwAction: DWORD, dwIndex: DWORD, dwValue: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NotifyIME(self, hIMC, dwAction, dwIndex, dwValue)
proc mRegisterWordA*(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szRegister: LPSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterWordA(self, hKL, szReading, dwStyle, szRegister)
proc mRegisterWordW*(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterWordW(self, hKL, szReading, dwStyle, szRegister)
proc ReleaseContext*(self: ptr IActiveIMMIME, hWnd: HWND, hIMC: HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseContext(self, hWnd, hIMC)
proc SetCandidateWindow*(self: ptr IActiveIMMIME, hIMC: HIMC, pCandidate: ptr CANDIDATEFORM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCandidateWindow(self, hIMC, pCandidate)
proc SetCompositionFontA*(self: ptr IActiveIMMIME, hIMC: HIMC, plf: ptr LOGFONTA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionFontA(self, hIMC, plf)
proc SetCompositionFontW*(self: ptr IActiveIMMIME, hIMC: HIMC, plf: ptr LOGFONTW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionFontW(self, hIMC, plf)
proc SetCompositionStringA*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, pComp: LPVOID, dwCompLen: DWORD, pRead: LPVOID, dwReadLen: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionStringA(self, hIMC, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
proc SetCompositionStringW*(self: ptr IActiveIMMIME, hIMC: HIMC, dwIndex: DWORD, pComp: LPVOID, dwCompLen: DWORD, pRead: LPVOID, dwReadLen: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionStringW(self, hIMC, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
proc SetCompositionWindow*(self: ptr IActiveIMMIME, hIMC: HIMC, pCompForm: ptr COMPOSITIONFORM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionWindow(self, hIMC, pCompForm)
proc SetConversionStatus*(self: ptr IActiveIMMIME, hIMC: HIMC, fdwConversion: DWORD, fdwSentence: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetConversionStatus(self, hIMC, fdwConversion, fdwSentence)
proc SetOpenStatus*(self: ptr IActiveIMMIME, hIMC: HIMC, fOpen: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOpenStatus(self, hIMC, fOpen)
proc SetStatusWindowPos*(self: ptr IActiveIMMIME, hIMC: HIMC, pptPos: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetStatusWindowPos(self, hIMC, pptPos)
proc SimulateHotKey*(self: ptr IActiveIMMIME, hWnd: HWND, dwHotKeyID: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SimulateHotKey(self, hWnd, dwHotKeyID)
proc UnregisterWordA*(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPSTR, dwStyle: DWORD, szUnregister: LPSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterWordA(self, hKL, szReading, dwStyle, szUnregister)
proc UnregisterWordW*(self: ptr IActiveIMMIME, hKL: HKL, szReading: LPWSTR, dwStyle: DWORD, szUnregister: LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterWordW(self, hKL, szReading, dwStyle, szUnregister)
proc GenerateMessage*(self: ptr IActiveIMMIME, hIMC: HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GenerateMessage(self, hIMC)
proc LockIMC*(self: ptr IActiveIMMIME, hIMC: HIMC, ppIMC: ptr ptr INPUTCONTEXT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockIMC(self, hIMC, ppIMC)
proc UnlockIMC*(self: ptr IActiveIMMIME, hIMC: HIMC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnlockIMC(self, hIMC)
proc GetIMCLockCount*(self: ptr IActiveIMMIME, hIMC: HIMC, pdwLockCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIMCLockCount(self, hIMC, pdwLockCount)
proc CreateIMCC*(self: ptr IActiveIMMIME, dwSize: DWORD, phIMCC: ptr HIMCC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateIMCC(self, dwSize, phIMCC)
proc DestroyIMCC*(self: ptr IActiveIMMIME, hIMCC: HIMCC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DestroyIMCC(self, hIMCC)
proc LockIMCC*(self: ptr IActiveIMMIME, hIMCC: HIMCC, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockIMCC(self, hIMCC, ppv)
proc UnlockIMCC*(self: ptr IActiveIMMIME, hIMCC: HIMCC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnlockIMCC(self, hIMCC)
proc ReSizeIMCC*(self: ptr IActiveIMMIME, hIMCC: HIMCC, dwSize: DWORD, phIMCC: ptr HIMCC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReSizeIMCC(self, hIMCC, dwSize, phIMCC)
proc GetIMCCSize*(self: ptr IActiveIMMIME, hIMCC: HIMCC, pdwSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIMCCSize(self, hIMCC, pdwSize)
proc GetIMCCLockCount*(self: ptr IActiveIMMIME, hIMCC: HIMCC, pdwLockCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIMCCLockCount(self, hIMCC, pdwLockCount)
proc GetHotKey*(self: ptr IActiveIMMIME, dwHotKeyID: DWORD, puModifiers: ptr UINT, puVKey: ptr UINT, phKL: ptr HKL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHotKey(self, dwHotKeyID, puModifiers, puVKey, phKL)
proc SetHotKey*(self: ptr IActiveIMMIME, dwHotKeyID: DWORD, uModifiers: UINT, uVKey: UINT, hKL: HKL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHotKey(self, dwHotKeyID, uModifiers, uVKey, hKL)
proc CreateSoftKeyboard*(self: ptr IActiveIMMIME, uType: UINT, hOwner: HWND, x: int32, y: int32, phSoftKbdWnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateSoftKeyboard(self, uType, hOwner, x, y, phSoftKbdWnd)
proc DestroySoftKeyboard*(self: ptr IActiveIMMIME, hSoftKbdWnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DestroySoftKeyboard(self, hSoftKbdWnd)
proc ShowSoftKeyboard*(self: ptr IActiveIMMIME, hSoftKbdWnd: HWND, nCmdShow: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowSoftKeyboard(self, hSoftKbdWnd, nCmdShow)
proc GetCodePageA*(self: ptr IActiveIMMIME, hKL: HKL, uCodePage: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCodePageA(self, hKL, uCodePage)
proc GetLangId*(self: ptr IActiveIMMIME, hKL: HKL, plid: ptr LANGID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLangId(self, hKL, plid)
proc KeybdEvent*(self: ptr IActiveIMMIME, lgidIME: LANGID, bVk: BYTE, bScan: BYTE, dwFlags: DWORD, dwExtraInfo: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.KeybdEvent(self, lgidIME, bVk, bScan, dwFlags, dwExtraInfo)
proc LockModal*(self: ptr IActiveIMMIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockModal(self)
proc UnlockModal*(self: ptr IActiveIMMIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnlockModal(self)
proc AssociateContextEx*(self: ptr IActiveIMMIME, hWnd: HWND, hIMC: HIMC, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AssociateContextEx(self, hWnd, hIMC, dwFlags)
proc DisableIME*(self: ptr IActiveIMMIME, idThread: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DisableIME(self, idThread)
proc GetImeMenuItemsA*(self: ptr IActiveIMMIME, hIMC: HIMC, dwFlags: DWORD, dwType: DWORD, pImeParentMenu: ptr IMEMENUITEMINFOA, pImeMenu: ptr IMEMENUITEMINFOA, dwSize: DWORD, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImeMenuItemsA(self, hIMC, dwFlags, dwType, pImeParentMenu, pImeMenu, dwSize, pdwResult)
proc GetImeMenuItemsW*(self: ptr IActiveIMMIME, hIMC: HIMC, dwFlags: DWORD, dwType: DWORD, pImeParentMenu: ptr IMEMENUITEMINFOW, pImeMenu: ptr IMEMENUITEMINFOW, dwSize: DWORD, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImeMenuItemsW(self, hIMC, dwFlags, dwType, pImeParentMenu, pImeMenu, dwSize, pdwResult)
proc EnumInputContext*(self: ptr IActiveIMMIME, idThread: DWORD, ppEnum: ptr ptr IEnumInputContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumInputContext(self, idThread, ppEnum)
proc RequestMessageA*(self: ptr IActiveIMMIME, hIMC: HIMC, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestMessageA(self, hIMC, wParam, lParam, plResult)
proc RequestMessageW*(self: ptr IActiveIMMIME, hIMC: HIMC, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestMessageW(self, hIMC, wParam, lParam, plResult)
proc SendIMCA*(self: ptr IActiveIMMIME, hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendIMCA(self, hWnd, uMsg, wParam, lParam, plResult)
proc SendIMCW*(self: ptr IActiveIMMIME, hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendIMCW(self, hWnd, uMsg, wParam, lParam, plResult)
proc IsSleeping*(self: ptr IActiveIMMIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsSleeping(self)
proc Inquire*(self: ptr IActiveIME, dwSystemInfoFlags: DWORD, pIMEInfo: ptr IMEINFO, szWndClass: LPWSTR, pdwPrivate: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Inquire(self, dwSystemInfoFlags, pIMEInfo, szWndClass, pdwPrivate)
proc ConversionList*(self: ptr IActiveIME, hIMC: HIMC, szSource: LPWSTR, uFlag: UINT, uBufLen: UINT, pDest: ptr CANDIDATELIST, puCopied: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConversionList(self, hIMC, szSource, uFlag, uBufLen, pDest, puCopied)
proc Configure*(self: ptr IActiveIME, hKL: HKL, hWnd: HWND, dwMode: DWORD, pRegisterWord: ptr REGISTERWORDW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Configure(self, hKL, hWnd, dwMode, pRegisterWord)
proc Destroy*(self: ptr IActiveIME, uReserved: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Destroy(self, uReserved)
proc Escape*(self: ptr IActiveIME, hIMC: HIMC, uEscape: UINT, pData: pointer, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Escape(self, hIMC, uEscape, pData, plResult)
proc SetActiveContext*(self: ptr IActiveIME, hIMC: HIMC, fFlag: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetActiveContext(self, hIMC, fFlag)
proc ProcessKey*(self: ptr IActiveIME, hIMC: HIMC, uVirKey: UINT, lParam: DWORD, pbKeyState: ptr BYTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProcessKey(self, hIMC, uVirKey, lParam, pbKeyState)
proc Notify*(self: ptr IActiveIME, hIMC: HIMC, dwAction: DWORD, dwIndex: DWORD, dwValue: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Notify(self, hIMC, dwAction, dwIndex, dwValue)
proc Select*(self: ptr IActiveIME, hIMC: HIMC, fSelect: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Select(self, hIMC, fSelect)
proc SetCompositionString*(self: ptr IActiveIME, hIMC: HIMC, dwIndex: DWORD, pComp: pointer, dwCompLen: DWORD, pRead: pointer, dwReadLen: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionString(self, hIMC, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
proc ToAsciiEx*(self: ptr IActiveIME, uVirKey: UINT, uScanCode: UINT, pbKeyState: ptr BYTE, fuState: UINT, hIMC: HIMC, pdwTransBuf: ptr DWORD, puSize: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ToAsciiEx(self, uVirKey, uScanCode, pbKeyState, fuState, hIMC, pdwTransBuf, puSize)
proc mRegisterWord*(self: ptr IActiveIME, szReading: LPWSTR, dwStyle: DWORD, szString: LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterWord(self, szReading, dwStyle, szString)
proc UnregisterWord*(self: ptr IActiveIME, szReading: LPWSTR, dwStyle: DWORD, szString: LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterWord(self, szReading, dwStyle, szString)
proc GetRegisterWordStyle*(self: ptr IActiveIME, nItem: UINT, pStyleBuf: ptr STYLEBUFW, puBufSize: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRegisterWordStyle(self, nItem, pStyleBuf, puBufSize)
proc EnumRegisterWord*(self: ptr IActiveIME, szReading: LPWSTR, dwStyle: DWORD, szRegister: LPWSTR, pData: LPVOID, ppEnum: ptr ptr IEnumRegisterWordW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumRegisterWord(self, szReading, dwStyle, szRegister, pData, ppEnum)
proc GetCodePageA*(self: ptr IActiveIME, uCodePage: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCodePageA(self, uCodePage)
proc GetLangId*(self: ptr IActiveIME, plid: ptr LANGID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLangId(self, plid)
proc Sleep*(self: ptr IActiveIME2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Sleep(self)
proc Unsleep*(self: ptr IActiveIME2, fDead: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unsleep(self, fDead)
proc Clone*(self: ptr IEnumRegisterWordA, ppEnum: ptr ptr IEnumRegisterWordA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc Next*(self: ptr IEnumRegisterWordA, ulCount: ULONG, rgRegisterWord: ptr REGISTERWORDA, pcFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, ulCount, rgRegisterWord, pcFetched)
proc Reset*(self: ptr IEnumRegisterWordA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Skip*(self: ptr IEnumRegisterWordA, ulCount: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, ulCount)
proc Clone*(self: ptr IEnumRegisterWordW, ppEnum: ptr ptr IEnumRegisterWordW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc Next*(self: ptr IEnumRegisterWordW, ulCount: ULONG, rgRegisterWord: ptr REGISTERWORDW, pcFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, ulCount, rgRegisterWord, pcFetched)
proc Reset*(self: ptr IEnumRegisterWordW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Skip*(self: ptr IEnumRegisterWordW, ulCount: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, ulCount)
converter winimConverterIEnumInputContextToIUnknown*(x: ptr IEnumInputContext): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveIMMRegistrarToIUnknown*(x: ptr IActiveIMMRegistrar): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveIMMMessagePumpOwnerToIUnknown*(x: ptr IActiveIMMMessagePumpOwner): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveIMMAppToIUnknown*(x: ptr IActiveIMMApp): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveIMMIMEToIUnknown*(x: ptr IActiveIMMIME): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveIMEToIUnknown*(x: ptr IActiveIME): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveIME2ToIActiveIME*(x: ptr IActiveIME2): ptr IActiveIME = cast[ptr IActiveIME](x)
converter winimConverterIActiveIME2ToIUnknown*(x: ptr IActiveIME2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumRegisterWordAToIUnknown*(x: ptr IEnumRegisterWordA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumRegisterWordWToIUnknown*(x: ptr IEnumRegisterWordW): ptr IUnknown = cast[ptr IUnknown](x)
when winimUnicode:
  type
    REGISTERWORD* = REGISTERWORDW
    PREGISTERWORD* = PREGISTERWORDW
    NPREGISTERWORD* = NPREGISTERWORDW
    LPREGISTERWORD* = LPREGISTERWORDW
    STYLEBUF* = STYLEBUFW
    PSTYLEBUF* = PSTYLEBUFW
    NPSTYLEBUF* = NPSTYLEBUFW
    LPSTYLEBUF* = LPSTYLEBUFW
    IMEMENUITEMINFO* = IMEMENUITEMINFOW
    PIMEMENUITEMINFO* = PIMEMENUITEMINFOW
    NPIMEMENUITEMINFO* = NPIMEMENUITEMINFOW
    LPIMEMENUITEMINFO* = LPIMEMENUITEMINFOW
    REGISTERWORDENUMPROC* = REGISTERWORDENUMPROCW
  proc ImmInstallIME*(lpszIMEFileName: LPCWSTR, lpszLayoutText: LPCWSTR): HKL {.winapi, stdcall, dynlib: "imm32", importc: "ImmInstallIMEW".}
  proc ImmGetDescription*(P1: HKL, P2: LPWSTR, uBufLen: UINT): UINT {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetDescriptionW".}
  proc ImmGetIMEFileName*(P1: HKL, P2: LPWSTR, uBufLen: UINT): UINT {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetIMEFileNameW".}
  proc ImmGetCompositionString*(P1: HIMC, P2: DWORD, P3: LPVOID, P4: DWORD): LONG {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetCompositionStringW".}
  proc ImmSetCompositionString*(P1: HIMC, dwIndex: DWORD, lpComp: LPVOID, P4: DWORD, lpRead: LPVOID, P6: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmSetCompositionStringW".}
  proc ImmGetCandidateListCount*(P1: HIMC, lpdwListCount: LPDWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetCandidateListCountW".}
  proc ImmGetCandidateList*(P1: HIMC, deIndex: DWORD, P3: LPCANDIDATELIST, dwBufLen: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetCandidateListW".}
  proc ImmGetGuideLine*(P1: HIMC, dwIndex: DWORD, P3: LPWSTR, dwBufLen: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetGuideLineW".}
  proc ImmGetCompositionFont*(P1: HIMC, P2: LPLOGFONTW): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetCompositionFontW".}
  proc ImmSetCompositionFont*(P1: HIMC, P2: LPLOGFONTW): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmSetCompositionFontW".}
  proc ImmConfigureIME*(P1: HKL, P2: HWND, P3: DWORD, P4: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmConfigureIMEW".}
  proc ImmEscape*(P1: HKL, P2: HIMC, P3: UINT, P4: LPVOID): LRESULT {.winapi, stdcall, dynlib: "imm32", importc: "ImmEscapeW".}
  proc ImmGetConversionList*(P1: HKL, P2: HIMC, P3: LPCWSTR, P4: LPCANDIDATELIST, dwBufLen: DWORD, uFlag: UINT): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetConversionListW".}
  proc ImmIsUIMessage*(P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmIsUIMessageW".}
  proc ImmRegisterWord*(P1: HKL, lpszReading: LPCWSTR, P3: DWORD, lpszRegister: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmRegisterWordW".}
  proc ImmUnregisterWord*(P1: HKL, lpszReading: LPCWSTR, P3: DWORD, lpszUnregister: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmUnregisterWordW".}
  proc ImmGetRegisterWordStyle*(P1: HKL, nItem: UINT, P3: LPSTYLEBUFW): UINT {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetRegisterWordStyleW".}
  proc ImmEnumRegisterWord*(P1: HKL, P2: REGISTERWORDENUMPROCW, lpszReading: LPCWSTR, P4: DWORD, lpszRegister: LPCWSTR, P6: LPVOID): UINT {.winapi, stdcall, dynlib: "imm32", importc: "ImmEnumRegisterWordW".}
  proc ImmGetImeMenuItems*(P1: HIMC, P2: DWORD, P3: DWORD, P4: LPIMEMENUITEMINFOW, P5: LPIMEMENUITEMINFOW, P6: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetImeMenuItemsW".}
when winimAnsi:
  type
    REGISTERWORD* = REGISTERWORDA
    PREGISTERWORD* = PREGISTERWORDA
    NPREGISTERWORD* = NPREGISTERWORDA
    LPREGISTERWORD* = LPREGISTERWORDA
    STYLEBUF* = STYLEBUFA
    PSTYLEBUF* = PSTYLEBUFA
    NPSTYLEBUF* = NPSTYLEBUFA
    LPSTYLEBUF* = LPSTYLEBUFA
    IMEMENUITEMINFO* = IMEMENUITEMINFOA
    PIMEMENUITEMINFO* = PIMEMENUITEMINFOA
    NPIMEMENUITEMINFO* = NPIMEMENUITEMINFOA
    LPIMEMENUITEMINFO* = LPIMEMENUITEMINFOA
    REGISTERWORDENUMPROC* = REGISTERWORDENUMPROCA
  proc ImmInstallIME*(lpszIMEFileName: LPCSTR, lpszLayoutText: LPCSTR): HKL {.winapi, stdcall, dynlib: "imm32", importc: "ImmInstallIMEA".}
  proc ImmGetDescription*(P1: HKL, P2: LPSTR, uBufLen: UINT): UINT {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetDescriptionA".}
  proc ImmGetIMEFileName*(P1: HKL, P2: LPSTR, uBufLen: UINT): UINT {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetIMEFileNameA".}
  proc ImmGetCompositionString*(P1: HIMC, P2: DWORD, P3: LPVOID, P4: DWORD): LONG {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetCompositionStringA".}
  proc ImmSetCompositionString*(P1: HIMC, dwIndex: DWORD, lpComp: LPVOID, P4: DWORD, lpRead: LPVOID, P6: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmSetCompositionStringA".}
  proc ImmGetCandidateListCount*(P1: HIMC, lpdwListCount: LPDWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetCandidateListCountA".}
  proc ImmGetCandidateList*(P1: HIMC, deIndex: DWORD, P3: LPCANDIDATELIST, dwBufLen: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetCandidateListA".}
  proc ImmGetGuideLine*(P1: HIMC, dwIndex: DWORD, P3: LPSTR, dwBufLen: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetGuideLineA".}
  proc ImmGetCompositionFont*(P1: HIMC, P2: LPLOGFONTA): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetCompositionFontA".}
  proc ImmSetCompositionFont*(P1: HIMC, P2: LPLOGFONTA): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmSetCompositionFontA".}
  proc ImmConfigureIME*(P1: HKL, P2: HWND, P3: DWORD, P4: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmConfigureIMEA".}
  proc ImmEscape*(P1: HKL, P2: HIMC, P3: UINT, P4: LPVOID): LRESULT {.winapi, stdcall, dynlib: "imm32", importc: "ImmEscapeA".}
  proc ImmGetConversionList*(P1: HKL, P2: HIMC, P3: LPCSTR, P4: LPCANDIDATELIST, dwBufLen: DWORD, uFlag: UINT): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetConversionListA".}
  proc ImmIsUIMessage*(P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmIsUIMessageA".}
  proc ImmRegisterWord*(P1: HKL, lpszReading: LPCSTR, P3: DWORD, lpszRegister: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmRegisterWordA".}
  proc ImmUnregisterWord*(P1: HKL, lpszReading: LPCSTR, P3: DWORD, lpszUnregister: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "imm32", importc: "ImmUnregisterWordA".}
  proc ImmGetRegisterWordStyle*(P1: HKL, nItem: UINT, P3: LPSTYLEBUFA): UINT {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetRegisterWordStyleA".}
  proc ImmEnumRegisterWord*(P1: HKL, P2: REGISTERWORDENUMPROCA, lpszReading: LPCSTR, P4: DWORD, lpszRegister: LPCSTR, P6: LPVOID): UINT {.winapi, stdcall, dynlib: "imm32", importc: "ImmEnumRegisterWordA".}
  proc ImmGetImeMenuItems*(P1: HIMC, P2: DWORD, P3: DWORD, P4: LPIMEMENUITEMINFOA, P5: LPIMEMENUITEMINFOA, P6: DWORD): DWORD {.winapi, stdcall, dynlib: "imm32", importc: "ImmGetImeMenuItemsA".}
