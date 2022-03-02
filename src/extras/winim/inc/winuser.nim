#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import wingdi
#include <winuser.h>
#include <tvout.h>
type
  FEEDBACK_TYPE* = int32
  POINTER_BUTTON_CHANGE_TYPE* = int32
  POINTER_DEVICE_TYPE* = int32
  POINTER_DEVICE_CURSOR_TYPE* = int32
  INPUT_MESSAGE_DEVICE_TYPE* = int32
  INPUT_MESSAGE_ORIGIN_ID* = int32
  AR_STATE* = int32
  PAR_STATE* = ptr int32
  ORIENTATION_PREFERENCE* = int32
  HDWP* = HANDLE
  LPMENUTEMPLATEA* = PVOID
  LPMENUTEMPLATEW* = PVOID
  HDEVNOTIFY* = PVOID
  HPOWERNOTIFY* = HANDLE
  HTOUCHINPUT* = HANDLE
  POINTER_INPUT_TYPE* = DWORD
  HELPPOLY* = DWORD
  HRAWINPUT* = HANDLE
  HGESTUREINFO* = HANDLE
  NAMEENUMPROCA* = proc (P1: LPSTR, P2: LPARAM): WINBOOL {.stdcall.}
  WINSTAENUMPROCA* = NAMEENUMPROCA
  NAMEENUMPROCW* = proc (P1: LPWSTR, P2: LPARAM): WINBOOL {.stdcall.}
  WINSTAENUMPROCW* = NAMEENUMPROCW
  DESKTOPENUMPROCA* = NAMEENUMPROCA
  DESKTOPENUMPROCW* = NAMEENUMPROCW
  CREATESTRUCTA* {.pure.} = object
    lpCreateParams*: LPVOID
    hInstance*: HINSTANCE
    hMenu*: HMENU
    hwndParent*: HWND
    cy*: int32
    cx*: int32
    y*: int32
    x*: int32
    style*: LONG
    lpszName*: LPCSTR
    lpszClass*: LPCSTR
    dwExStyle*: DWORD
  CBT_CREATEWNDA* {.pure.} = object
    lpcs*: ptr CREATESTRUCTA
    hwndInsertAfter*: HWND
  LPCBT_CREATEWNDA* = ptr CBT_CREATEWNDA
  CREATESTRUCTW* {.pure.} = object
    lpCreateParams*: LPVOID
    hInstance*: HINSTANCE
    hMenu*: HMENU
    hwndParent*: HWND
    cy*: int32
    cx*: int32
    y*: int32
    x*: int32
    style*: LONG
    lpszName*: LPCWSTR
    lpszClass*: LPCWSTR
    dwExStyle*: DWORD
  CBT_CREATEWNDW* {.pure.} = object
    lpcs*: ptr CREATESTRUCTW
    hwndInsertAfter*: HWND
  LPCBT_CREATEWNDW* = ptr CBT_CREATEWNDW
  CBTACTIVATESTRUCT* {.pure.} = object
    fMouse*: WINBOOL
    hWndActive*: HWND
  LPCBTACTIVATESTRUCT* = ptr CBTACTIVATESTRUCT
  WTSSESSION_NOTIFICATION* {.pure.} = object
    cbSize*: DWORD
    dwSessionId*: DWORD
  PWTSSESSION_NOTIFICATION* = ptr WTSSESSION_NOTIFICATION
  SHELLHOOKINFO* {.pure.} = object
    hwnd*: HWND
    rc*: RECT
  LPSHELLHOOKINFO* = ptr SHELLHOOKINFO
  EVENTMSG* {.pure.} = object
    message*: UINT
    paramL*: UINT
    paramH*: UINT
    time*: DWORD
    hwnd*: HWND
  PEVENTMSGMSG* = ptr EVENTMSG
  NPEVENTMSGMSG* = ptr EVENTMSG
  LPEVENTMSGMSG* = ptr EVENTMSG
  PEVENTMSG* = ptr EVENTMSG
  NPEVENTMSG* = ptr EVENTMSG
  LPEVENTMSG* = ptr EVENTMSG
  CWPSTRUCT* {.pure.} = object
    lParam*: LPARAM
    wParam*: WPARAM
    message*: UINT
    hwnd*: HWND
  PCWPSTRUCT* = ptr CWPSTRUCT
  NPCWPSTRUCT* = ptr CWPSTRUCT
  LPCWPSTRUCT* = ptr CWPSTRUCT
  CWPRETSTRUCT* {.pure.} = object
    lResult*: LRESULT
    lParam*: LPARAM
    wParam*: WPARAM
    message*: UINT
    hwnd*: HWND
  PCWPRETSTRUCT* = ptr CWPRETSTRUCT
  NPCWPRETSTRUCT* = ptr CWPRETSTRUCT
  LPCWPRETSTRUCT* = ptr CWPRETSTRUCT
  KBDLLHOOKSTRUCT* {.pure.} = object
    vkCode*: DWORD
    scanCode*: DWORD
    flags*: DWORD
    time*: DWORD
    dwExtraInfo*: ULONG_PTR
  LPKBDLLHOOKSTRUCT* = ptr KBDLLHOOKSTRUCT
  PKBDLLHOOKSTRUCT* = ptr KBDLLHOOKSTRUCT
  MSLLHOOKSTRUCT* {.pure.} = object
    pt*: POINT
    mouseData*: DWORD
    flags*: DWORD
    time*: DWORD
    dwExtraInfo*: ULONG_PTR
  LPMSLLHOOKSTRUCT* = ptr MSLLHOOKSTRUCT
  PMSLLHOOKSTRUCT* = ptr MSLLHOOKSTRUCT
  DEBUGHOOKINFO* {.pure.} = object
    idThread*: DWORD
    idThreadInstaller*: DWORD
    lParam*: LPARAM
    wParam*: WPARAM
    code*: int32
  PDEBUGHOOKINFO* = ptr DEBUGHOOKINFO
  NPDEBUGHOOKINFO* = ptr DEBUGHOOKINFO
  LPDEBUGHOOKINFO* = ptr DEBUGHOOKINFO
  MOUSEHOOKSTRUCT* {.pure.} = object
    pt*: POINT
    hwnd*: HWND
    wHitTestCode*: UINT
    dwExtraInfo*: ULONG_PTR
  LPMOUSEHOOKSTRUCT* = ptr MOUSEHOOKSTRUCT
  PMOUSEHOOKSTRUCT* = ptr MOUSEHOOKSTRUCT
  MOUSEHOOKSTRUCTEX* {.pure.} = object
    unnamed*: MOUSEHOOKSTRUCT
    mouseData*: DWORD
  LPMOUSEHOOKSTRUCTEX* = ptr MOUSEHOOKSTRUCTEX
  PMOUSEHOOKSTRUCTEX* = ptr MOUSEHOOKSTRUCTEX
  HARDWAREHOOKSTRUCT* {.pure.} = object
    hwnd*: HWND
    message*: UINT
    wParam*: WPARAM
    lParam*: LPARAM
  LPHARDWAREHOOKSTRUCT* = ptr HARDWAREHOOKSTRUCT
  PHARDWAREHOOKSTRUCT* = ptr HARDWAREHOOKSTRUCT
  MOUSEMOVEPOINT* {.pure.} = object
    x*: int32
    y*: int32
    time*: DWORD
    dwExtraInfo*: ULONG_PTR
  PMOUSEMOVEPOINT* = ptr MOUSEMOVEPOINT
  LPMOUSEMOVEPOINT* = ptr MOUSEMOVEPOINT
  USEROBJECTFLAGS* {.pure.} = object
    fInherit*: WINBOOL
    fReserved*: WINBOOL
    dwFlags*: DWORD
  PUSEROBJECTFLAGS* = ptr USEROBJECTFLAGS
  WNDPROC* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): LRESULT {.stdcall.}
  WNDCLASSEXA* {.pure.} = object
    cbSize*: UINT
    style*: UINT
    lpfnWndProc*: WNDPROC
    cbClsExtra*: int32
    cbWndExtra*: int32
    hInstance*: HINSTANCE
    hIcon*: HICON
    hCursor*: HCURSOR
    hbrBackground*: HBRUSH
    lpszMenuName*: LPCSTR
    lpszClassName*: LPCSTR
    hIconSm*: HICON
  PWNDCLASSEXA* = ptr WNDCLASSEXA
  NPWNDCLASSEXA* = ptr WNDCLASSEXA
  LPWNDCLASSEXA* = ptr WNDCLASSEXA
  WNDCLASSEXW* {.pure.} = object
    cbSize*: UINT
    style*: UINT
    lpfnWndProc*: WNDPROC
    cbClsExtra*: int32
    cbWndExtra*: int32
    hInstance*: HINSTANCE
    hIcon*: HICON
    hCursor*: HCURSOR
    hbrBackground*: HBRUSH
    lpszMenuName*: LPCWSTR
    lpszClassName*: LPCWSTR
    hIconSm*: HICON
  PWNDCLASSEXW* = ptr WNDCLASSEXW
  NPWNDCLASSEXW* = ptr WNDCLASSEXW
  LPWNDCLASSEXW* = ptr WNDCLASSEXW
  WNDCLASSA* {.pure.} = object
    style*: UINT
    lpfnWndProc*: WNDPROC
    cbClsExtra*: int32
    cbWndExtra*: int32
    hInstance*: HINSTANCE
    hIcon*: HICON
    hCursor*: HCURSOR
    hbrBackground*: HBRUSH
    lpszMenuName*: LPCSTR
    lpszClassName*: LPCSTR
  PWNDCLASSA* = ptr WNDCLASSA
  NPWNDCLASSA* = ptr WNDCLASSA
  LPWNDCLASSA* = ptr WNDCLASSA
  WNDCLASSW* {.pure.} = object
    style*: UINT
    lpfnWndProc*: WNDPROC
    cbClsExtra*: int32
    cbWndExtra*: int32
    hInstance*: HINSTANCE
    hIcon*: HICON
    hCursor*: HCURSOR
    hbrBackground*: HBRUSH
    lpszMenuName*: LPCWSTR
    lpszClassName*: LPCWSTR
  PWNDCLASSW* = ptr WNDCLASSW
  NPWNDCLASSW* = ptr WNDCLASSW
  LPWNDCLASSW* = ptr WNDCLASSW
  MSG* {.pure.} = object
    hwnd*: HWND
    message*: UINT
    wParam*: WPARAM
    lParam*: LPARAM
    time*: DWORD
    pt*: POINT
  PMSG* = ptr MSG
  NPMSG* = ptr MSG
  LPMSG* = ptr MSG
  MINMAXINFO* {.pure.} = object
    ptReserved*: POINT
    ptMaxSize*: POINT
    ptMaxPosition*: POINT
    ptMinTrackSize*: POINT
    ptMaxTrackSize*: POINT
  PMINMAXINFO* = ptr MINMAXINFO
  LPMINMAXINFO* = ptr MINMAXINFO
  COPYDATASTRUCT* {.pure.} = object
    dwData*: ULONG_PTR
    cbData*: DWORD
    lpData*: PVOID
  PCOPYDATASTRUCT* = ptr COPYDATASTRUCT
  MDINEXTMENU* {.pure.} = object
    hmenuIn*: HMENU
    hmenuNext*: HMENU
    hwndNext*: HWND
  PMDINEXTMENU* = ptr MDINEXTMENU
  LPMDINEXTMENU* = ptr MDINEXTMENU
  POWERBROADCAST_SETTING* {.pure.} = object
    PowerSetting*: GUID
    DataLength*: DWORD
    Data*: array[1, UCHAR]
  PPOWERBROADCAST_SETTING* = ptr POWERBROADCAST_SETTING
  WINDOWPOS* {.pure.} = object
    hwnd*: HWND
    hwndInsertAfter*: HWND
    x*: int32
    y*: int32
    cx*: int32
    cy*: int32
    flags*: UINT
  LPWINDOWPOS* = ptr WINDOWPOS
  PWINDOWPOS* = ptr WINDOWPOS
  NCCALCSIZE_PARAMS* {.pure.} = object
    rgrc*: array[3, RECT]
    lppos*: PWINDOWPOS
  LPNCCALCSIZE_PARAMS* = ptr NCCALCSIZE_PARAMS
  TTRACKMOUSEEVENT* {.pure.} = object
    cbSize*: DWORD
    dwFlags*: DWORD
    hwndTrack*: HWND
    dwHoverTime*: DWORD
  LPTRACKMOUSEEVENT* = ptr TTRACKMOUSEEVENT
  ACCEL* {.pure.} = object
    fVirt*: BYTE
    key*: WORD
    cmd*: WORD
  LPACCEL* = ptr ACCEL
  PAINTSTRUCT* {.pure.} = object
    hdc*: HDC
    fErase*: WINBOOL
    rcPaint*: RECT
    fRestore*: WINBOOL
    fIncUpdate*: WINBOOL
    rgbReserved*: array[32, BYTE]
  PPAINTSTRUCT* = ptr PAINTSTRUCT
  NPPAINTSTRUCT* = ptr PAINTSTRUCT
  LPPAINTSTRUCT* = ptr PAINTSTRUCT
  LPCREATESTRUCTA* = ptr CREATESTRUCTA
  LPCREATESTRUCTW* = ptr CREATESTRUCTW
  WINDOWPLACEMENT* {.pure.} = object
    length*: UINT
    flags*: UINT
    showCmd*: UINT
    ptMinPosition*: POINT
    ptMaxPosition*: POINT
    rcNormalPosition*: RECT
  PWINDOWPLACEMENT* = ptr WINDOWPLACEMENT
  LPWINDOWPLACEMENT* = ptr WINDOWPLACEMENT
  NMHDR* {.pure.} = object
    hwndFrom*: HWND
    idFrom*: UINT_PTR
    code*: UINT
  LPNMHDR* = ptr NMHDR
  STYLESTRUCT* {.pure.} = object
    styleOld*: DWORD
    styleNew*: DWORD
  LPSTYLESTRUCT* = ptr STYLESTRUCT
  MEASUREITEMSTRUCT* {.pure.} = object
    CtlType*: UINT
    CtlID*: UINT
    itemID*: UINT
    itemWidth*: UINT
    itemHeight*: UINT
    itemData*: ULONG_PTR
  PMEASUREITEMSTRUCT* = ptr MEASUREITEMSTRUCT
  LPMEASUREITEMSTRUCT* = ptr MEASUREITEMSTRUCT
  DRAWITEMSTRUCT* {.pure.} = object
    CtlType*: UINT
    CtlID*: UINT
    itemID*: UINT
    itemAction*: UINT
    itemState*: UINT
    hwndItem*: HWND
    hDC*: HDC
    rcItem*: RECT
    itemData*: ULONG_PTR
  PDRAWITEMSTRUCT* = ptr DRAWITEMSTRUCT
  LPDRAWITEMSTRUCT* = ptr DRAWITEMSTRUCT
  DELETEITEMSTRUCT* {.pure.} = object
    CtlType*: UINT
    CtlID*: UINT
    itemID*: UINT
    hwndItem*: HWND
    itemData*: ULONG_PTR
  PDELETEITEMSTRUCT* = ptr DELETEITEMSTRUCT
  LPDELETEITEMSTRUCT* = ptr DELETEITEMSTRUCT
  COMPAREITEMSTRUCT* {.pure.} = object
    CtlType*: UINT
    CtlID*: UINT
    hwndItem*: HWND
    itemID1*: UINT
    itemData1*: ULONG_PTR
    itemID2*: UINT
    itemData2*: ULONG_PTR
    dwLocaleId*: DWORD
  PCOMPAREITEMSTRUCT* = ptr COMPAREITEMSTRUCT
  LPCOMPAREITEMSTRUCT* = ptr COMPAREITEMSTRUCT
  BSMINFO* {.pure.} = object
    cbSize*: UINT
    hdesk*: HDESK
    hwnd*: HWND
    luid*: LUID
  PBSMINFO* = ptr BSMINFO
  PHDEVNOTIFY* = ptr HDEVNOTIFY
  PHPOWERNOTIFY* = ptr HPOWERNOTIFY
  UPDATELAYEREDWINDOWINFO* {.pure.} = object
    cbSize*: DWORD
    hdcDst*: HDC
    pptDst*: ptr POINT
    psize*: ptr SIZE
    hdcSrc*: HDC
    pptSrc*: ptr POINT
    crKey*: COLORREF
    pblend*: ptr BLENDFUNCTION
    dwFlags*: DWORD
    prcDirty*: ptr RECT
  PUPDATELAYEREDWINDOWINFO* = ptr UPDATELAYEREDWINDOWINFO
  FLASHWINFO* {.pure.} = object
    cbSize*: UINT
    hwnd*: HWND
    dwFlags*: DWORD
    uCount*: UINT
    dwTimeout*: DWORD
  PFLASHWINFO* = ptr FLASHWINFO
  DLGTEMPLATE* {.pure, packed.} = object
    style*: DWORD
    dwExtendedStyle*: DWORD
    cdit*: WORD
    x*: int16
    y*: int16
    cx*: int16
    cy*: int16
  LPDLGTEMPLATEA* = ptr DLGTEMPLATE
  LPDLGTEMPLATEW* = ptr DLGTEMPLATE
  LPCDLGTEMPLATEA* = ptr DLGTEMPLATE
  LPCDLGTEMPLATEW* = ptr DLGTEMPLATE
  DLGITEMTEMPLATE* {.pure, packed.} = object
    style*: DWORD
    dwExtendedStyle*: DWORD
    x*: int16
    y*: int16
    cx*: int16
    cy*: int16
    id*: WORD
  PDLGITEMTEMPLATEA* = ptr DLGITEMTEMPLATE
  PDLGITEMTEMPLATEW* = ptr DLGITEMTEMPLATE
  LPDLGITEMTEMPLATEA* = ptr DLGITEMTEMPLATE
  LPDLGITEMTEMPLATEW* = ptr DLGITEMTEMPLATE
  MOUSEINPUT* {.pure.} = object
    dx*: LONG
    dy*: LONG
    mouseData*: DWORD
    dwFlags*: DWORD
    time*: DWORD
    dwExtraInfo*: ULONG_PTR
  PMOUSEINPUT* = ptr MOUSEINPUT
  LPMOUSEINPUT* = ptr MOUSEINPUT
  KEYBDINPUT* {.pure.} = object
    wVk*: WORD
    wScan*: WORD
    dwFlags*: DWORD
    time*: DWORD
    dwExtraInfo*: ULONG_PTR
  PKEYBDINPUT* = ptr KEYBDINPUT
  LPKEYBDINPUT* = ptr KEYBDINPUT
  HARDWAREINPUT* {.pure.} = object
    uMsg*: DWORD
    wParamL*: WORD
    wParamH*: WORD
  PHARDWAREINPUT* = ptr HARDWAREINPUT
  LPHARDWAREINPUT* = ptr HARDWAREINPUT
  INPUT_UNION1* {.pure, union.} = object
    mi*: MOUSEINPUT
    ki*: KEYBDINPUT
    hi*: HARDWAREINPUT
  INPUT* {.pure.} = object
    `type`*: DWORD
    union1*: INPUT_UNION1
  PINPUT* = ptr INPUT
  LPINPUT* = ptr INPUT
  TOUCHINPUT* {.pure.} = object
    x*: LONG
    y*: LONG
    hSource*: HANDLE
    dwID*: DWORD
    dwFlags*: DWORD
    dwMask*: DWORD
    dwTime*: DWORD
    dwExtraInfo*: ULONG_PTR
    cxContact*: DWORD
    cyContact*: DWORD
  PTOUCHINPUT* = ptr TOUCHINPUT
  PCTOUCHINPUT* = ptr TOUCHINPUT
  POINTER_FLAGS* = UINT32
  TOUCH_FLAGS* = UINT32
  TOUCH_MASK* = UINT32
  PEN_FLAGS* = UINT32
  PEN_MASK* = UINT32
  TOUCH_HIT_TESTING_PROXIMITY_EVALUATION* {.pure.} = object
    score*: UINT16
    adjustedPoint*: POINT
  PTOUCH_HIT_TESTING_PROXIMITY_EVALUATION* = ptr TOUCH_HIT_TESTING_PROXIMITY_EVALUATION
  TOUCH_HIT_TESTING_INPUT* {.pure.} = object
    pointerId*: UINT32
    point*: POINT
    boundingBox*: RECT
    nonOccludedBoundingBox*: RECT
    orientation*: UINT32
  PTOUCH_HIT_TESTING_INPUT* = ptr TOUCH_HIT_TESTING_INPUT
  LASTINPUTINFO* {.pure.} = object
    cbSize*: UINT
    dwTime*: DWORD
  PLASTINPUTINFO* = ptr LASTINPUTINFO
  MENUINFO* {.pure.} = object
    cbSize*: DWORD
    fMask*: DWORD
    dwStyle*: DWORD
    cyMax*: UINT
    hbrBack*: HBRUSH
    dwContextHelpID*: DWORD
    dwMenuData*: ULONG_PTR
  LPMENUINFO* = ptr MENUINFO
  TPMPARAMS* {.pure.} = object
    cbSize*: UINT
    rcExclude*: RECT
  LPTPMPARAMS* = ptr TPMPARAMS
  LPCMENUINFO* = ptr MENUINFO
  MENUGETOBJECTINFO* {.pure.} = object
    dwFlags*: DWORD
    uPos*: UINT
    hmenu*: HMENU
    riid*: PVOID
    pvObj*: PVOID
  PMENUGETOBJECTINFO* = ptr MENUGETOBJECTINFO
  MENUITEMINFOA* {.pure.} = object
    cbSize*: UINT
    fMask*: UINT
    fType*: UINT
    fState*: UINT
    wID*: UINT
    hSubMenu*: HMENU
    hbmpChecked*: HBITMAP
    hbmpUnchecked*: HBITMAP
    dwItemData*: ULONG_PTR
    dwTypeData*: LPSTR
    cch*: UINT
    hbmpItem*: HBITMAP
  LPMENUITEMINFOA* = ptr MENUITEMINFOA
  MENUITEMINFOW* {.pure.} = object
    cbSize*: UINT
    fMask*: UINT
    fType*: UINT
    fState*: UINT
    wID*: UINT
    hSubMenu*: HMENU
    hbmpChecked*: HBITMAP
    hbmpUnchecked*: HBITMAP
    dwItemData*: ULONG_PTR
    dwTypeData*: LPWSTR
    cch*: UINT
    hbmpItem*: HBITMAP
  LPMENUITEMINFOW* = ptr MENUITEMINFOW
  LPCMENUITEMINFOA* = ptr MENUITEMINFOA
  LPCMENUITEMINFOW* = ptr MENUITEMINFOW
  DROPSTRUCT* {.pure.} = object
    hwndSource*: HWND
    hwndSink*: HWND
    wFmt*: DWORD
    dwData*: ULONG_PTR
    ptDrop*: POINT
    dwControlData*: DWORD
  PDROPSTRUCT* = ptr DROPSTRUCT
  LPDROPSTRUCT* = ptr DROPSTRUCT
  DRAWTEXTPARAMS* {.pure.} = object
    cbSize*: UINT
    iTabLength*: int32
    iLeftMargin*: int32
    iRightMargin*: int32
    uiLengthDrawn*: UINT
  LPDRAWTEXTPARAMS* = ptr DRAWTEXTPARAMS
  HELPINFO* {.pure.} = object
    cbSize*: UINT
    iContextType*: int32
    iCtrlId*: int32
    hItemHandle*: HANDLE
    dwContextId*: DWORD_PTR
    MousePos*: POINT
  LPHELPINFO* = ptr HELPINFO
  MSGBOXCALLBACK* = proc (lpHelpInfo: LPHELPINFO): VOID {.stdcall.}
  MSGBOXPARAMSA* {.pure.} = object
    cbSize*: UINT
    hwndOwner*: HWND
    hInstance*: HINSTANCE
    lpszText*: LPCSTR
    lpszCaption*: LPCSTR
    dwStyle*: DWORD
    lpszIcon*: LPCSTR
    dwContextHelpId*: DWORD_PTR
    lpfnMsgBoxCallback*: MSGBOXCALLBACK
    dwLanguageId*: DWORD
  PMSGBOXPARAMSA* = ptr MSGBOXPARAMSA
  LPMSGBOXPARAMSA* = ptr MSGBOXPARAMSA
  MSGBOXPARAMSW* {.pure.} = object
    cbSize*: UINT
    hwndOwner*: HWND
    hInstance*: HINSTANCE
    lpszText*: LPCWSTR
    lpszCaption*: LPCWSTR
    dwStyle*: DWORD
    lpszIcon*: LPCWSTR
    dwContextHelpId*: DWORD_PTR
    lpfnMsgBoxCallback*: MSGBOXCALLBACK
    dwLanguageId*: DWORD
  PMSGBOXPARAMSW* = ptr MSGBOXPARAMSW
  LPMSGBOXPARAMSW* = ptr MSGBOXPARAMSW
  MENUITEMTEMPLATEHEADER* {.pure.} = object
    versionNumber*: WORD
    offset*: WORD
  PMENUITEMTEMPLATEHEADER* = ptr MENUITEMTEMPLATEHEADER
  MENUITEMTEMPLATE* {.pure.} = object
    mtOption*: WORD
    mtID*: WORD
    mtString*: array[1, WCHAR]
  PMENUITEMTEMPLATE* = ptr MENUITEMTEMPLATE
  ICONINFO* {.pure.} = object
    fIcon*: WINBOOL
    xHotspot*: DWORD
    yHotspot*: DWORD
    hbmMask*: HBITMAP
    hbmColor*: HBITMAP
  PICONINFO* = ptr ICONINFO
  CURSORSHAPE* {.pure.} = object
    xHotSpot*: int32
    yHotSpot*: int32
    cx*: int32
    cy*: int32
    cbWidth*: int32
    Planes*: BYTE
    BitsPixel*: BYTE
  LPCURSORSHAPE* = ptr CURSORSHAPE
  ICONINFOEXA* {.pure.} = object
    cbSize*: DWORD
    fIcon*: WINBOOL
    xHotspot*: DWORD
    yHotspot*: DWORD
    hbmMask*: HBITMAP
    hbmColor*: HBITMAP
    wResID*: WORD
    szModName*: array[MAX_PATH, CHAR]
    szResName*: array[MAX_PATH, CHAR]
  PICONINFOEXA* = ptr ICONINFOEXA
  ICONINFOEXW* {.pure.} = object
    cbSize*: DWORD
    fIcon*: WINBOOL
    xHotspot*: DWORD
    yHotspot*: DWORD
    hbmMask*: HBITMAP
    hbmColor*: HBITMAP
    wResID*: WORD
    szModName*: array[MAX_PATH, WCHAR]
    szResName*: array[MAX_PATH, WCHAR]
  PICONINFOEXW* = ptr ICONINFOEXW
  SCROLLINFO* {.pure.} = object
    cbSize*: UINT
    fMask*: UINT
    nMin*: int32
    nMax*: int32
    nPage*: UINT
    nPos*: int32
    nTrackPos*: int32
  LPSCROLLINFO* = ptr SCROLLINFO
  LPCSCROLLINFO* = ptr SCROLLINFO
  MDICREATESTRUCTA* {.pure.} = object
    szClass*: LPCSTR
    szTitle*: LPCSTR
    hOwner*: HANDLE
    x*: int32
    y*: int32
    cx*: int32
    cy*: int32
    style*: DWORD
    lParam*: LPARAM
  LPMDICREATESTRUCTA* = ptr MDICREATESTRUCTA
  MDICREATESTRUCTW* {.pure.} = object
    szClass*: LPCWSTR
    szTitle*: LPCWSTR
    hOwner*: HANDLE
    x*: int32
    y*: int32
    cx*: int32
    cy*: int32
    style*: DWORD
    lParam*: LPARAM
  LPMDICREATESTRUCTW* = ptr MDICREATESTRUCTW
  CLIENTCREATESTRUCT* {.pure.} = object
    hWindowMenu*: HANDLE
    idFirstChild*: UINT
  LPCLIENTCREATESTRUCT* = ptr CLIENTCREATESTRUCT
  MULTIKEYHELPA* {.pure.} = object
    mkSize*: DWORD
    mkKeylist*: CHAR
    szKeyphrase*: array[1, CHAR]
  PMULTIKEYHELPA* = ptr MULTIKEYHELPA
  LPMULTIKEYHELPA* = ptr MULTIKEYHELPA
  MULTIKEYHELPW* {.pure.} = object
    mkSize*: DWORD
    mkKeylist*: WCHAR
    szKeyphrase*: array[1, WCHAR]
  PMULTIKEYHELPW* = ptr MULTIKEYHELPW
  LPMULTIKEYHELPW* = ptr MULTIKEYHELPW
  HELPWININFOA* {.pure.} = object
    wStructSize*: int32
    x*: int32
    y*: int32
    dx*: int32
    dy*: int32
    wMax*: int32
    rgchMember*: array[2, CHAR]
  PHELPWININFOA* = ptr HELPWININFOA
  LPHELPWININFOA* = ptr HELPWININFOA
  HELPWININFOW* {.pure.} = object
    wStructSize*: int32
    x*: int32
    y*: int32
    dx*: int32
    dy*: int32
    wMax*: int32
    rgchMember*: array[2, WCHAR]
  PHELPWININFOW* = ptr HELPWININFOW
  LPHELPWININFOW* = ptr HELPWININFOW
  TOUCHPREDICTIONPARAMETERS* {.pure.} = object
    cbSize*: UINT
    dwLatency*: UINT
    dwSampleTime*: UINT
    bUseHWTimeStamp*: UINT
  PTOUCHPREDICTIONPARAMETERS* = ptr TOUCHPREDICTIONPARAMETERS
  NONCLIENTMETRICSA* {.pure.} = object
    cbSize*: UINT
    iBorderWidth*: int32
    iScrollWidth*: int32
    iScrollHeight*: int32
    iCaptionWidth*: int32
    iCaptionHeight*: int32
    lfCaptionFont*: LOGFONTA
    iSmCaptionWidth*: int32
    iSmCaptionHeight*: int32
    lfSmCaptionFont*: LOGFONTA
    iMenuWidth*: int32
    iMenuHeight*: int32
    lfMenuFont*: LOGFONTA
    lfStatusFont*: LOGFONTA
    lfMessageFont*: LOGFONTA
    iPaddedBorderWidth*: int32
  PNONCLIENTMETRICSA* = ptr NONCLIENTMETRICSA
  LPNONCLIENTMETRICSA* = ptr NONCLIENTMETRICSA
  NONCLIENTMETRICSW* {.pure.} = object
    cbSize*: UINT
    iBorderWidth*: int32
    iScrollWidth*: int32
    iScrollHeight*: int32
    iCaptionWidth*: int32
    iCaptionHeight*: int32
    lfCaptionFont*: LOGFONTW
    iSmCaptionWidth*: int32
    iSmCaptionHeight*: int32
    lfSmCaptionFont*: LOGFONTW
    iMenuWidth*: int32
    iMenuHeight*: int32
    lfMenuFont*: LOGFONTW
    lfStatusFont*: LOGFONTW
    lfMessageFont*: LOGFONTW
    iPaddedBorderWidth*: int32
  PNONCLIENTMETRICSW* = ptr NONCLIENTMETRICSW
  LPNONCLIENTMETRICSW* = ptr NONCLIENTMETRICSW
  MINIMIZEDMETRICS* {.pure.} = object
    cbSize*: UINT
    iWidth*: int32
    iHorzGap*: int32
    iVertGap*: int32
    iArrange*: int32
  PMINIMIZEDMETRICS* = ptr MINIMIZEDMETRICS
  LPMINIMIZEDMETRICS* = ptr MINIMIZEDMETRICS
  ICONMETRICSA* {.pure.} = object
    cbSize*: UINT
    iHorzSpacing*: int32
    iVertSpacing*: int32
    iTitleWrap*: int32
    lfFont*: LOGFONTA
  PICONMETRICSA* = ptr ICONMETRICSA
  LPICONMETRICSA* = ptr ICONMETRICSA
  ICONMETRICSW* {.pure.} = object
    cbSize*: UINT
    iHorzSpacing*: int32
    iVertSpacing*: int32
    iTitleWrap*: int32
    lfFont*: LOGFONTW
  PICONMETRICSW* = ptr ICONMETRICSW
  LPICONMETRICSW* = ptr ICONMETRICSW
  ANIMATIONINFO* {.pure.} = object
    cbSize*: UINT
    iMinAnimate*: int32
  LPANIMATIONINFO* = ptr ANIMATIONINFO
  SERIALKEYSA* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    lpszActivePort*: LPSTR
    lpszPort*: LPSTR
    iBaudRate*: UINT
    iPortState*: UINT
    iActive*: UINT
  LPSERIALKEYSA* = ptr SERIALKEYSA
  SERIALKEYSW* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    lpszActivePort*: LPWSTR
    lpszPort*: LPWSTR
    iBaudRate*: UINT
    iPortState*: UINT
    iActive*: UINT
  LPSERIALKEYSW* = ptr SERIALKEYSW
  HIGHCONTRASTA* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    lpszDefaultScheme*: LPSTR
  LPHIGHCONTRASTA* = ptr HIGHCONTRASTA
  HIGHCONTRASTW* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    lpszDefaultScheme*: LPWSTR
  LPHIGHCONTRASTW* = ptr HIGHCONTRASTW
  VIDEOPARAMETERS* {.pure.} = object
    Guid*: GUID
    dwOffset*: ULONG
    dwCommand*: ULONG
    dwFlags*: ULONG
    dwMode*: ULONG
    dwTVStandard*: ULONG
    dwAvailableModes*: ULONG
    dwAvailableTVStandard*: ULONG
    dwFlickerFilter*: ULONG
    dwOverScanX*: ULONG
    dwOverScanY*: ULONG
    dwMaxUnscaledX*: ULONG
    dwMaxUnscaledY*: ULONG
    dwPositionX*: ULONG
    dwPositionY*: ULONG
    dwBrightness*: ULONG
    dwContrast*: ULONG
    dwCPType*: ULONG
    dwCPCommand*: ULONG
    dwCPStandard*: ULONG
    dwCPKey*: ULONG
    bCP_APSTriggerBits*: ULONG
    bOEMCopyProtection*: array[256, UCHAR]
  PVIDEOPARAMETERS* = ptr VIDEOPARAMETERS
  LPVIDEOPARAMETERS* = ptr VIDEOPARAMETERS
  FILTERKEYS* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    iWaitMSec*: DWORD
    iDelayMSec*: DWORD
    iRepeatMSec*: DWORD
    iBounceMSec*: DWORD
  LPFILTERKEYS* = ptr FILTERKEYS
  STICKYKEYS* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
  LPSTICKYKEYS* = ptr STICKYKEYS
  MOUSEKEYS* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    iMaxSpeed*: DWORD
    iTimeToMaxSpeed*: DWORD
    iCtrlSpeed*: DWORD
    dwReserved1*: DWORD
    dwReserved2*: DWORD
  LPMOUSEKEYS* = ptr MOUSEKEYS
  ACCESSTIMEOUT* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    iTimeOutMSec*: DWORD
  LPACCESSTIMEOUT* = ptr ACCESSTIMEOUT
  SOUNDSENTRYA* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    iFSTextEffect*: DWORD
    iFSTextEffectMSec*: DWORD
    iFSTextEffectColorBits*: DWORD
    iFSGrafEffect*: DWORD
    iFSGrafEffectMSec*: DWORD
    iFSGrafEffectColor*: DWORD
    iWindowsEffect*: DWORD
    iWindowsEffectMSec*: DWORD
    lpszWindowsEffectDLL*: LPSTR
    iWindowsEffectOrdinal*: DWORD
  LPSOUNDSENTRYA* = ptr SOUNDSENTRYA
  SOUNDSENTRYW* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    iFSTextEffect*: DWORD
    iFSTextEffectMSec*: DWORD
    iFSTextEffectColorBits*: DWORD
    iFSGrafEffect*: DWORD
    iFSGrafEffectMSec*: DWORD
    iFSGrafEffectColor*: DWORD
    iWindowsEffect*: DWORD
    iWindowsEffectMSec*: DWORD
    lpszWindowsEffectDLL*: LPWSTR
    iWindowsEffectOrdinal*: DWORD
  LPSOUNDSENTRYW* = ptr SOUNDSENTRYW
  TOGGLEKEYS* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
  LPTOGGLEKEYS* = ptr TOGGLEKEYS
  MONITORINFO* {.pure.} = object
    cbSize*: DWORD
    rcMonitor*: RECT
    rcWork*: RECT
    dwFlags*: DWORD
  LPMONITORINFO* = ptr MONITORINFO
  AUDIODESCRIPTION* {.pure.} = object
    cbSize*: UINT
    Enabled*: WINBOOL
    Locale*: LCID
  LPAUDIODESCRIPTION* = ptr AUDIODESCRIPTION
  MONITORINFOEXA_STRUCT1* {.pure.} = object
    cbSize*: DWORD
    rcMonitor*: RECT
    rcWork*: RECT
    dwFlags*: DWORD
  MONITORINFOEXA* {.pure.} = object
    struct1*: MONITORINFOEXA_STRUCT1
    szDevice*: array[CCHDEVICENAME, CHAR]
  LPMONITORINFOEXA* = ptr MONITORINFOEXA
  MONITORINFOEXW_STRUCT1* {.pure.} = object
    cbSize*: DWORD
    rcMonitor*: RECT
    rcWork*: RECT
    dwFlags*: DWORD
  MONITORINFOEXW* {.pure.} = object
    struct1*: MONITORINFOEXW_STRUCT1
    szDevice*: array[CCHDEVICENAME, WCHAR]
  LPMONITORINFOEXW* = ptr MONITORINFOEXW
  GUITHREADINFO* {.pure.} = object
    cbSize*: DWORD
    flags*: DWORD
    hwndActive*: HWND
    hwndFocus*: HWND
    hwndCapture*: HWND
    hwndMenuOwner*: HWND
    hwndMoveSize*: HWND
    hwndCaret*: HWND
    rcCaret*: RECT
  PGUITHREADINFO* = ptr GUITHREADINFO
  LPGUITHREADINFO* = ptr GUITHREADINFO
  CURSORINFO* {.pure.} = object
    cbSize*: DWORD
    flags*: DWORD
    hCursor*: HCURSOR
    ptScreenPos*: POINT
  PCURSORINFO* = ptr CURSORINFO
  LPCURSORINFO* = ptr CURSORINFO
  WINDOWINFO* {.pure.} = object
    cbSize*: DWORD
    rcWindow*: RECT
    rcClient*: RECT
    dwStyle*: DWORD
    dwExStyle*: DWORD
    dwWindowStatus*: DWORD
    cxWindowBorders*: UINT
    cyWindowBorders*: UINT
    atomWindowType*: ATOM
    wCreatorVersion*: WORD
  PWINDOWINFO* = ptr WINDOWINFO
  LPWINDOWINFO* = ptr WINDOWINFO
const
  CCHILDREN_TITLEBAR* = 5
type
  TITLEBARINFO* {.pure.} = object
    cbSize*: DWORD
    rcTitleBar*: RECT
    rgstate*: array[CCHILDREN_TITLEBAR + 1, DWORD]
  PTITLEBARINFO* = ptr TITLEBARINFO
  LPTITLEBARINFO* = ptr TITLEBARINFO
  TITLEBARINFOEX* {.pure.} = object
    cbSize*: DWORD
    rcTitleBar*: RECT
    rgstate*: array[CCHILDREN_TITLEBAR + 1, DWORD]
    rgrect*: array[CCHILDREN_TITLEBAR + 1, RECT]
  PTITLEBARINFOEX* = ptr TITLEBARINFOEX
  LPTITLEBARINFOEX* = ptr TITLEBARINFOEX
  MENUBARINFO* {.pure.} = object
    cbSize*: DWORD
    rcBar*: RECT
    hMenu*: HMENU
    hwndMenu*: HWND
    fBarFocused* {.bitsize:1.}: WINBOOL
    fFocused* {.bitsize:1.}: WINBOOL
  PMENUBARINFO* = ptr MENUBARINFO
  LPMENUBARINFO* = ptr MENUBARINFO
const
  CCHILDREN_SCROLLBAR* = 5
type
  SCROLLBARINFO* {.pure.} = object
    cbSize*: DWORD
    rcScrollBar*: RECT
    dxyLineButton*: int32
    xyThumbTop*: int32
    xyThumbBottom*: int32
    reserved*: int32
    rgstate*: array[CCHILDREN_SCROLLBAR + 1, DWORD]
  PSCROLLBARINFO* = ptr SCROLLBARINFO
  LPSCROLLBARINFO* = ptr SCROLLBARINFO
  COMBOBOXINFO* {.pure.} = object
    cbSize*: DWORD
    rcItem*: RECT
    rcButton*: RECT
    stateButton*: DWORD
    hwndCombo*: HWND
    hwndItem*: HWND
    hwndList*: HWND
  PCOMBOBOXINFO* = ptr COMBOBOXINFO
  LPCOMBOBOXINFO* = ptr COMBOBOXINFO
  ALTTABINFO* {.pure.} = object
    cbSize*: DWORD
    cItems*: int32
    cColumns*: int32
    cRows*: int32
    iColFocus*: int32
    iRowFocus*: int32
    cxItem*: int32
    cyItem*: int32
    ptStart*: POINT
  PALTTABINFO* = ptr ALTTABINFO
  LPALTTABINFO* = ptr ALTTABINFO
  RAWINPUTHEADER* {.pure.} = object
    dwType*: DWORD
    dwSize*: DWORD
    hDevice*: HANDLE
    wParam*: WPARAM
  PRAWINPUTHEADER* = ptr RAWINPUTHEADER
  LPRAWINPUTHEADER* = ptr RAWINPUTHEADER
  RAWMOUSE_UNION1_STRUCT1* {.pure.} = object
    usButtonFlags*: USHORT
    usButtonData*: USHORT
  RAWMOUSE_UNION1* {.pure, union.} = object
    ulButtons*: ULONG
    struct1*: RAWMOUSE_UNION1_STRUCT1
  RAWMOUSE* {.pure.} = object
    usFlags*: USHORT
    union1*: RAWMOUSE_UNION1
    ulRawButtons*: ULONG
    lLastX*: LONG
    lLastY*: LONG
    ulExtraInformation*: ULONG
  PRAWMOUSE* = ptr RAWMOUSE
  LPRAWMOUSE* = ptr RAWMOUSE
  RAWKEYBOARD* {.pure.} = object
    MakeCode*: USHORT
    Flags*: USHORT
    Reserved*: USHORT
    VKey*: USHORT
    Message*: UINT
    ExtraInformation*: ULONG
  PRAWKEYBOARD* = ptr RAWKEYBOARD
  LPRAWKEYBOARD* = ptr RAWKEYBOARD
  RAWHID* {.pure.} = object
    dwSizeHid*: DWORD
    dwCount*: DWORD
    bRawData*: array[1, BYTE]
  PRAWHID* = ptr RAWHID
  LPRAWHID* = ptr RAWHID
  RAWINPUT_data* {.pure, union.} = object
    mouse*: RAWMOUSE
    keyboard*: RAWKEYBOARD
    hid*: RAWHID
  RAWINPUT* {.pure.} = object
    header*: RAWINPUTHEADER
    data*: RAWINPUT_data
  PRAWINPUT* = ptr RAWINPUT
  LPRAWINPUT* = ptr RAWINPUT
  RID_DEVICE_INFO_MOUSE* {.pure.} = object
    dwId*: DWORD
    dwNumberOfButtons*: DWORD
    dwSampleRate*: DWORD
    fHasHorizontalWheel*: WINBOOL
  PRID_DEVICE_INFO_MOUSE* = ptr RID_DEVICE_INFO_MOUSE
  RID_DEVICE_INFO_KEYBOARD* {.pure.} = object
    dwType*: DWORD
    dwSubType*: DWORD
    dwKeyboardMode*: DWORD
    dwNumberOfFunctionKeys*: DWORD
    dwNumberOfIndicators*: DWORD
    dwNumberOfKeysTotal*: DWORD
  PRID_DEVICE_INFO_KEYBOARD* = ptr RID_DEVICE_INFO_KEYBOARD
  RID_DEVICE_INFO_HID* {.pure.} = object
    dwVendorId*: DWORD
    dwProductId*: DWORD
    dwVersionNumber*: DWORD
    usUsagePage*: USHORT
    usUsage*: USHORT
  PRID_DEVICE_INFO_HID* = ptr RID_DEVICE_INFO_HID
  RID_DEVICE_INFO_UNION1* {.pure, union.} = object
    mouse*: RID_DEVICE_INFO_MOUSE
    keyboard*: RID_DEVICE_INFO_KEYBOARD
    hid*: RID_DEVICE_INFO_HID
  RID_DEVICE_INFO* {.pure.} = object
    cbSize*: DWORD
    dwType*: DWORD
    union1*: RID_DEVICE_INFO_UNION1
  PRID_DEVICE_INFO* = ptr RID_DEVICE_INFO
  LPRID_DEVICE_INFO* = ptr RID_DEVICE_INFO
  RAWINPUTDEVICE* {.pure.} = object
    usUsagePage*: USHORT
    usUsage*: USHORT
    dwFlags*: DWORD
    hwndTarget*: HWND
  PRAWINPUTDEVICE* = ptr RAWINPUTDEVICE
  LPRAWINPUTDEVICE* = ptr RAWINPUTDEVICE
  PCRAWINPUTDEVICE* = ptr RAWINPUTDEVICE
  RAWINPUTDEVICELIST* {.pure.} = object
    hDevice*: HANDLE
    dwType*: DWORD
  PRAWINPUTDEVICELIST* = ptr RAWINPUTDEVICELIST
  CHANGEFILTERSTRUCT* {.pure.} = object
    cbSize*: DWORD
    ExtStatus*: DWORD
  PCHANGEFILTERSTRUCT* = ptr CHANGEFILTERSTRUCT
  GESTUREINFO* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    dwID*: DWORD
    hwndTarget*: HWND
    ptsLocation*: POINTS
    dwInstanceID*: DWORD
    dwSequenceID*: DWORD
    ullArguments*: ULONGLONG
    cbExtraArgs*: UINT
  PGESTUREINFO* = ptr GESTUREINFO
  PCGESTUREINFO* = ptr GESTUREINFO
  GESTURENOTIFYSTRUCT* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
    hwndTarget*: HWND
    ptsLocation*: POINTS
    dwInstanceID*: DWORD
  PGESTURENOTIFYSTRUCT* = ptr GESTURENOTIFYSTRUCT
  GESTURECONFIG* {.pure.} = object
    dwID*: DWORD
    dwWant*: DWORD
    dwBlock*: DWORD
  PGESTURECONFIG* = ptr GESTURECONFIG
template MAKEINTRESOURCE*(i: untyped): untyped = cast[LPTSTR](i and 0xffff)
const
  RT_CURSOR* = MAKEINTRESOURCE(1)
  RT_BITMAP* = MAKEINTRESOURCE(2)
  RT_ICON* = MAKEINTRESOURCE(3)
  RT_MENU* = MAKEINTRESOURCE(4)
  RT_DIALOG* = MAKEINTRESOURCE(5)
  RT_STRING* = MAKEINTRESOURCE(6)
  RT_FONTDIR* = MAKEINTRESOURCE(7)
  RT_FONT* = MAKEINTRESOURCE(8)
  RT_ACCELERATOR* = MAKEINTRESOURCE(9)
  RT_RCDATA* = MAKEINTRESOURCE(10)
  RT_MESSAGETABLE* = MAKEINTRESOURCE(11)
  DIFFERENCE* = 11
  RT_VERSION* = MAKEINTRESOURCE(16)
  RT_DLGINCLUDE* = MAKEINTRESOURCE(17)
  RT_PLUGPLAY* = MAKEINTRESOURCE(19)
  RT_VXD* = MAKEINTRESOURCE(20)
  RT_ANICURSOR* = MAKEINTRESOURCE(21)
  RT_ANIICON* = MAKEINTRESOURCE(22)
  RT_HTML* = MAKEINTRESOURCE(23)
  RT_MANIFEST* = MAKEINTRESOURCE(24)
  CREATEPROCESS_MANIFEST_RESOURCE_ID* = MAKEINTRESOURCE(1)
  ISOLATIONAWARE_MANIFEST_RESOURCE_ID* = MAKEINTRESOURCE(2)
  ISOLATIONAWARE_NOSTATICIMPORT_MANIFEST_RESOURCE_ID* = MAKEINTRESOURCE(3)
  MINIMUM_RESERVED_MANIFEST_RESOURCE_ID* = MAKEINTRESOURCE(1)
  MAXIMUM_RESERVED_MANIFEST_RESOURCE_ID* = MAKEINTRESOURCE(16)
  SB_HORZ* = 0
  SB_VERT* = 1
  SB_CTL* = 2
  SB_BOTH* = 3
  SB_LINEUP* = 0
  SB_LINELEFT* = 0
  SB_LINEDOWN* = 1
  SB_LINERIGHT* = 1
  SB_PAGEUP* = 2
  SB_PAGELEFT* = 2
  SB_PAGEDOWN* = 3
  SB_PAGERIGHT* = 3
  SB_THUMBPOSITION* = 4
  SB_THUMBTRACK* = 5
  SB_TOP* = 6
  SB_LEFT* = 6
  SB_BOTTOM* = 7
  SB_RIGHT* = 7
  SB_ENDSCROLL* = 8
  SW_HIDE* = 0
  SW_SHOWNORMAL* = 1
  SW_NORMAL* = 1
  SW_SHOWMINIMIZED* = 2
  SW_SHOWMAXIMIZED* = 3
  SW_MAXIMIZE* = 3
  SW_SHOWNOACTIVATE* = 4
  SW_SHOW* = 5
  SW_MINIMIZE* = 6
  SW_SHOWMINNOACTIVE* = 7
  SW_SHOWNA* = 8
  SW_RESTORE* = 9
  SW_SHOWDEFAULT* = 10
  SW_FORCEMINIMIZE* = 11
  SW_MAX* = 11
  HIDE_WINDOW* = 0
  SHOW_OPENWINDOW* = 1
  SHOW_ICONWINDOW* = 2
  SHOW_FULLSCREEN* = 3
  SHOW_OPENNOACTIVATE* = 4
  SW_PARENTCLOSING* = 1
  SW_OTHERZOOM* = 2
  SW_PARENTOPENING* = 3
  SW_OTHERUNZOOM* = 4
  AW_HOR_POSITIVE* = 0x00000001
  AW_HOR_NEGATIVE* = 0x00000002
  AW_VER_POSITIVE* = 0x00000004
  AW_VER_NEGATIVE* = 0x00000008
  AW_CENTER* = 0x00000010
  AW_HIDE* = 0x00010000
  AW_ACTIVATE* = 0x00020000
  AW_SLIDE* = 0x00040000
  AW_BLEND* = 0x00080000
  KF_EXTENDED* = 0x0100
  KF_DLGMODE* = 0x0800
  KF_MENUMODE* = 0x1000
  KF_ALTDOWN* = 0x2000
  KF_REPEAT* = 0x4000
  KF_UP* = 0x8000
  VK_LBUTTON* = 0x01
  VK_RBUTTON* = 0x02
  VK_CANCEL* = 0x03
  VK_MBUTTON* = 0x04
  VK_XBUTTON1* = 0x05
  VK_XBUTTON2* = 0x06
  VK_BACK* = 0x08
  VK_TAB* = 0x09
  VK_CLEAR* = 0x0C
  VK_RETURN* = 0x0D
  VK_SHIFT* = 0x10
  VK_CONTROL* = 0x11
  VK_MENU* = 0x12
  VK_PAUSE* = 0x13
  VK_CAPITAL* = 0x14
  VK_KANA* = 0x15
  VK_HANGEUL* = 0x15
  VK_HANGUL* = 0x15
  VK_JUNJA* = 0x17
  VK_FINAL* = 0x18
  VK_HANJA* = 0x19
  VK_KANJI* = 0x19
  VK_ESCAPE* = 0x1B
  VK_CONVERT* = 0x1C
  VK_NONCONVERT* = 0x1D
  VK_ACCEPT* = 0x1E
  VK_MODECHANGE* = 0x1F
  VK_SPACE* = 0x20
  VK_PRIOR* = 0x21
  VK_NEXT* = 0x22
  VK_END* = 0x23
  VK_HOME* = 0x24
  VK_LEFT* = 0x25
  VK_UP* = 0x26
  VK_RIGHT* = 0x27
  VK_DOWN* = 0x28
  VK_SELECT* = 0x29
  VK_PRINT* = 0x2A
  VK_EXECUTE* = 0x2B
  VK_SNAPSHOT* = 0x2C
  VK_INSERT* = 0x2D
  VK_DELETE* = 0x2E
  VK_HELP* = 0x2F
  VK_LWIN* = 0x5B
  VK_RWIN* = 0x5C
  VK_APPS* = 0x5D
  VK_SLEEP* = 0x5F
  VK_NUMPAD0* = 0x60
  VK_NUMPAD1* = 0x61
  VK_NUMPAD2* = 0x62
  VK_NUMPAD3* = 0x63
  VK_NUMPAD4* = 0x64
  VK_NUMPAD5* = 0x65
  VK_NUMPAD6* = 0x66
  VK_NUMPAD7* = 0x67
  VK_NUMPAD8* = 0x68
  VK_NUMPAD9* = 0x69
  VK_MULTIPLY* = 0x6A
  VK_ADD* = 0x6B
  VK_SEPARATOR* = 0x6C
  VK_SUBTRACT* = 0x6D
  VK_DECIMAL* = 0x6E
  VK_DIVIDE* = 0x6F
  VK_F1* = 0x70
  VK_F2* = 0x71
  VK_F3* = 0x72
  VK_F4* = 0x73
  VK_F5* = 0x74
  VK_F6* = 0x75
  VK_F7* = 0x76
  VK_F8* = 0x77
  VK_F9* = 0x78
  VK_F10* = 0x79
  VK_F11* = 0x7A
  VK_F12* = 0x7B
  VK_F13* = 0x7C
  VK_F14* = 0x7D
  VK_F15* = 0x7E
  VK_F16* = 0x7F
  VK_F17* = 0x80
  VK_F18* = 0x81
  VK_F19* = 0x82
  VK_F20* = 0x83
  VK_F21* = 0x84
  VK_F22* = 0x85
  VK_F23* = 0x86
  VK_F24* = 0x87
  VK_NUMLOCK* = 0x90
  VK_SCROLL* = 0x91
  VK_OEM_NEC_EQUAL* = 0x92
  VK_OEM_FJ_JISHO* = 0x92
  VK_OEM_FJ_MASSHOU* = 0x93
  VK_OEM_FJ_TOUROKU* = 0x94
  VK_OEM_FJ_LOYA* = 0x95
  VK_OEM_FJ_ROYA* = 0x96
  VK_LSHIFT* = 0xA0
  VK_RSHIFT* = 0xA1
  VK_LCONTROL* = 0xA2
  VK_RCONTROL* = 0xA3
  VK_LMENU* = 0xA4
  VK_RMENU* = 0xA5
  VK_BROWSER_BACK* = 0xA6
  VK_BROWSER_FORWARD* = 0xA7
  VK_BROWSER_REFRESH* = 0xA8
  VK_BROWSER_STOP* = 0xA9
  VK_BROWSER_SEARCH* = 0xAA
  VK_BROWSER_FAVORITES* = 0xAB
  VK_BROWSER_HOME* = 0xAC
  VK_VOLUME_MUTE* = 0xAD
  VK_VOLUME_DOWN* = 0xAE
  VK_VOLUME_UP* = 0xAF
  VK_MEDIA_NEXT_TRACK* = 0xB0
  VK_MEDIA_PREV_TRACK* = 0xB1
  VK_MEDIA_STOP* = 0xB2
  VK_MEDIA_PLAY_PAUSE* = 0xB3
  VK_LAUNCH_MAIL* = 0xB4
  VK_LAUNCH_MEDIA_SELECT* = 0xB5
  VK_LAUNCH_APP1* = 0xB6
  VK_LAUNCH_APP2* = 0xB7
  VK_OEM_1* = 0xBA
  VK_OEM_PLUS* = 0xBB
  VK_OEM_COMMA* = 0xBC
  VK_OEM_MINUS* = 0xBD
  VK_OEM_PERIOD* = 0xBE
  VK_OEM_2* = 0xBF
  VK_OEM_3* = 0xC0
  VK_OEM_4* = 0xDB
  VK_OEM_5* = 0xDC
  VK_OEM_6* = 0xDD
  VK_OEM_7* = 0xDE
  VK_OEM_8* = 0xDF
  VK_OEM_AX* = 0xE1
  VK_OEM_102* = 0xE2
  VK_ICO_HELP* = 0xE3
  VK_ICO_00* = 0xE4
  VK_PROCESSKEY* = 0xE5
  VK_ICO_CLEAR* = 0xE6
  VK_PACKET* = 0xE7
  VK_OEM_RESET* = 0xE9
  VK_OEM_JUMP* = 0xEA
  VK_OEM_PA1* = 0xEB
  VK_OEM_PA2* = 0xEC
  VK_OEM_PA3* = 0xED
  VK_OEM_WSCTRL* = 0xEE
  VK_OEM_CUSEL* = 0xEF
  VK_OEM_ATTN* = 0xF0
  VK_OEM_FINISH* = 0xF1
  VK_OEM_COPY* = 0xF2
  VK_OEM_AUTO* = 0xF3
  VK_OEM_ENLW* = 0xF4
  VK_OEM_BACKTAB* = 0xF5
  VK_ATTN* = 0xF6
  VK_CRSEL* = 0xF7
  VK_EXSEL* = 0xF8
  VK_EREOF* = 0xF9
  VK_PLAY* = 0xFA
  VK_ZOOM* = 0xFB
  VK_NONAME* = 0xFC
  VK_PA1* = 0xFD
  VK_OEM_CLEAR* = 0xFE
  WH_MIN* = -1
  WH_MSGFILTER* = -1
  WH_JOURNALRECORD* = 0
  WH_JOURNALPLAYBACK* = 1
  WH_KEYBOARD* = 2
  WH_GETMESSAGE* = 3
  WH_CALLWNDPROC* = 4
  WH_CBT* = 5
  WH_SYSMSGFILTER* = 6
  WH_MOUSE* = 7
  WH_HARDWARE* = 8
  WH_DEBUG* = 9
  WH_SHELL* = 10
  WH_FOREGROUNDIDLE* = 11
  WH_CALLWNDPROCRET* = 12
  WH_KEYBOARD_LL* = 13
  WH_MOUSE_LL* = 14
  WH_MAX* = 14
  WH_MINHOOK* = WH_MIN
  WH_MAXHOOK* = WH_MAX
  HC_ACTION* = 0
  HC_GETNEXT* = 1
  HC_SKIP* = 2
  HC_NOREMOVE* = 3
  HC_NOREM* = HC_NOREMOVE
  HC_SYSMODALON* = 4
  HC_SYSMODALOFF* = 5
  HCBT_MOVESIZE* = 0
  HCBT_MINMAX* = 1
  HCBT_QS* = 2
  HCBT_CREATEWND* = 3
  HCBT_DESTROYWND* = 4
  HCBT_ACTIVATE* = 5
  HCBT_CLICKSKIPPED* = 6
  HCBT_KEYSKIPPED* = 7
  HCBT_SYSCOMMAND* = 8
  HCBT_SETFOCUS* = 9
  WTS_CONSOLE_CONNECT* = 0x1
  WTS_CONSOLE_DISCONNECT* = 0x2
  WTS_REMOTE_CONNECT* = 0x3
  WTS_REMOTE_DISCONNECT* = 0x4
  WTS_SESSION_LOGON* = 0x5
  WTS_SESSION_LOGOFF* = 0x6
  WTS_SESSION_LOCK* = 0x7
  WTS_SESSION_UNLOCK* = 0x8
  WTS_SESSION_REMOTE_CONTROL* = 0x9
  WTS_SESSION_CREATE* = 0xa
  WTS_SESSION_TERMINATE* = 0xb
  MSGF_DIALOGBOX* = 0
  MSGF_MESSAGEBOX* = 1
  MSGF_MENU* = 2
  MSGF_SCROLLBAR* = 5
  MSGF_NEXTWINDOW* = 6
  MSGF_MAX* = 8
  MSGF_USER* = 4096
  HSHELL_WINDOWCREATED* = 1
  HSHELL_WINDOWDESTROYED* = 2
  HSHELL_ACTIVATESHELLWINDOW* = 3
  HSHELL_WINDOWACTIVATED* = 4
  HSHELL_GETMINRECT* = 5
  HSHELL_REDRAW* = 6
  HSHELL_TASKMAN* = 7
  HSHELL_LANGUAGE* = 8
  HSHELL_SYSMENU* = 9
  HSHELL_ENDTASK* = 10
  HSHELL_ACCESSIBILITYSTATE* = 11
  HSHELL_APPCOMMAND* = 12
  HSHELL_WINDOWREPLACED* = 13
  HSHELL_WINDOWREPLACING* = 14
  HSHELL_MONITORCHANGED* = 16
  HSHELL_HIGHBIT* = 0x8000
  HSHELL_FLASH* = HSHELL_REDRAW or HSHELL_HIGHBIT
  HSHELL_RUDEAPPACTIVATED* = HSHELL_WINDOWACTIVATED or HSHELL_HIGHBIT
  ACCESS_STICKYKEYS* = 0x0001
  ACCESS_FILTERKEYS* = 0x0002
  ACCESS_MOUSEKEYS* = 0x0003
  APPCOMMAND_BROWSER_BACKWARD* = 1
  APPCOMMAND_BROWSER_FORWARD* = 2
  APPCOMMAND_BROWSER_REFRESH* = 3
  APPCOMMAND_BROWSER_STOP* = 4
  APPCOMMAND_BROWSER_SEARCH* = 5
  APPCOMMAND_BROWSER_FAVORITES* = 6
  APPCOMMAND_BROWSER_HOME* = 7
  APPCOMMAND_VOLUME_MUTE* = 8
  APPCOMMAND_VOLUME_DOWN* = 9
  APPCOMMAND_VOLUME_UP* = 10
  APPCOMMAND_MEDIA_NEXTTRACK* = 11
  APPCOMMAND_MEDIA_PREVIOUSTRACK* = 12
  APPCOMMAND_MEDIA_STOP* = 13
  APPCOMMAND_MEDIA_PLAY_PAUSE* = 14
  APPCOMMAND_LAUNCH_MAIL* = 15
  APPCOMMAND_LAUNCH_MEDIA_SELECT* = 16
  APPCOMMAND_LAUNCH_APP1* = 17
  APPCOMMAND_LAUNCH_APP2* = 18
  APPCOMMAND_BASS_DOWN* = 19
  APPCOMMAND_BASS_BOOST* = 20
  APPCOMMAND_BASS_UP* = 21
  APPCOMMAND_TREBLE_DOWN* = 22
  APPCOMMAND_TREBLE_UP* = 23
  APPCOMMAND_MICROPHONE_VOLUME_MUTE* = 24
  APPCOMMAND_MICROPHONE_VOLUME_DOWN* = 25
  APPCOMMAND_MICROPHONE_VOLUME_UP* = 26
  APPCOMMAND_HELP* = 27
  APPCOMMAND_FIND* = 28
  APPCOMMAND_NEW* = 29
  APPCOMMAND_OPEN* = 30
  APPCOMMAND_CLOSE* = 31
  APPCOMMAND_SAVE* = 32
  APPCOMMAND_PRINT* = 33
  APPCOMMAND_UNDO* = 34
  APPCOMMAND_REDO* = 35
  APPCOMMAND_COPY* = 36
  APPCOMMAND_CUT* = 37
  APPCOMMAND_PASTE* = 38
  APPCOMMAND_REPLY_TO_MAIL* = 39
  APPCOMMAND_FORWARD_MAIL* = 40
  APPCOMMAND_SEND_MAIL* = 41
  APPCOMMAND_SPELL_CHECK* = 42
  APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE* = 43
  APPCOMMAND_MIC_ON_OFF_TOGGLE* = 44
  APPCOMMAND_CORRECTION_LIST* = 45
  APPCOMMAND_MEDIA_PLAY* = 46
  APPCOMMAND_MEDIA_PAUSE* = 47
  APPCOMMAND_MEDIA_RECORD* = 48
  APPCOMMAND_MEDIA_FAST_FORWARD* = 49
  APPCOMMAND_MEDIA_REWIND* = 50
  APPCOMMAND_MEDIA_CHANNEL_UP* = 51
  APPCOMMAND_MEDIA_CHANNEL_DOWN* = 52
  APPCOMMAND_DELETE* = 53
  APPCOMMAND_DWM_FLIP3D* = 54
  FAPPCOMMAND_MOUSE* = 0x8000
  FAPPCOMMAND_KEY* = 0
  FAPPCOMMAND_OEM* = 0x1000
  FAPPCOMMAND_MASK* = 0xF000
  LLKHF_EXTENDED* = KF_EXTENDED shr 8
  LLKHF_INJECTED* = 0x00000010
  LLKHF_ALTDOWN* = KF_ALTDOWN shr 8
  LLKHF_UP* = KF_UP shr 8
  LLMHF_INJECTED* = 0x00000001
  HKL_PREV* = 0
  HKL_NEXT* = 1
  KLF_ACTIVATE* = 0x00000001
  KLF_SUBSTITUTE_OK* = 0x00000002
  KLF_REORDER* = 0x00000008
  KLF_REPLACELANG* = 0x00000010
  KLF_NOTELLSHELL* = 0x00000080
  KLF_SETFORPROCESS* = 0x00000100
  KLF_SHIFTLOCK* = 0x00010000
  KLF_RESET* = 0x40000000
  INPUTLANGCHANGE_SYSCHARSET* = 0x0001
  INPUTLANGCHANGE_FORWARD* = 0x0002
  INPUTLANGCHANGE_BACKWARD* = 0x0004
  KL_NAMELENGTH* = 9
  GMMP_USE_DISPLAY_POINTS* = 1
  GMMP_USE_HIGH_RESOLUTION_POINTS* = 2
  DESKTOP_READOBJECTS* = 0x0001
  DESKTOP_CREATEWINDOW* = 0x0002
  DESKTOP_CREATEMENU* = 0x0004
  DESKTOP_HOOKCONTROL* = 0x0008
  DESKTOP_JOURNALRECORD* = 0x0010
  DESKTOP_JOURNALPLAYBACK* = 0x0020
  DESKTOP_ENUMERATE* = 0x0040
  DESKTOP_WRITEOBJECTS* = 0x0080
  DESKTOP_SWITCHDESKTOP* = 0x0100
  DF_ALLOWOTHERACCOUNTHOOK* = 0x0001
  WINSTA_ENUMDESKTOPS* = 0x0001
  WINSTA_READATTRIBUTES* = 0x0002
  WINSTA_ACCESSCLIPBOARD* = 0x0004
  WINSTA_CREATEDESKTOP* = 0x0008
  WINSTA_WRITEATTRIBUTES* = 0x0010
  WINSTA_ACCESSGLOBALATOMS* = 0x0020
  WINSTA_EXITWINDOWS* = 0x0040
  WINSTA_ENUMERATE* = 0x0100
  WINSTA_READSCREEN* = 0x0200
  WINSTA_ALL_ACCESS* = WINSTA_ENUMDESKTOPS or WINSTA_READATTRIBUTES or WINSTA_ACCESSCLIPBOARD or WINSTA_CREATEDESKTOP or WINSTA_WRITEATTRIBUTES or WINSTA_ACCESSGLOBALATOMS or WINSTA_EXITWINDOWS or WINSTA_ENUMERATE or WINSTA_READSCREEN
  CWF_CREATE_ONLY* = 0x00000001
  WSF_VISIBLE* = 0x0001
  UOI_FLAGS* = 1
  UOI_NAME* = 2
  UOI_TYPE* = 3
  UOI_USER_SID* = 4
  UOI_HEAPSIZE* = 5
  UOI_IO* = 6
  GWL_WNDPROC* = -4
  GWL_HINSTANCE* = -6
  GWL_HWNDPARENT* = -8
  GWL_STYLE* = -16
  GWL_EXSTYLE* = -20
  GWL_USERDATA* = -21
  GWL_ID* = -12
  GWLP_WNDPROC* = -4
  GWLP_HINSTANCE* = -6
  GWLP_HWNDPARENT* = -8
  GWLP_USERDATA* = -21
  GWLP_ID* = -12
  GCL_MENUNAME* = -8
  GCL_HBRBACKGROUND* = -10
  GCL_HCURSOR* = -12
  GCL_HICON* = -14
  GCL_HMODULE* = -16
  GCL_CBWNDEXTRA* = -18
  GCL_CBCLSEXTRA* = -20
  GCL_WNDPROC* = -24
  GCL_STYLE* = -26
  GCW_ATOM* = -32
  GCL_HICONSM* = -34
  GCLP_MENUNAME* = -8
  GCLP_HBRBACKGROUND* = -10
  GCLP_HCURSOR* = -12
  GCLP_HICON* = -14
  GCLP_HMODULE* = -16
  GCLP_WNDPROC* = -24
  GCLP_HICONSM* = -34
  WM_NULL* = 0x0000
  WM_CREATE* = 0x0001
  WM_DESTROY* = 0x0002
  WM_MOVE* = 0x0003
  WM_SIZE* = 0x0005
  WM_ACTIVATE* = 0x0006
  WA_INACTIVE* = 0
  WA_ACTIVE* = 1
  WA_CLICKACTIVE* = 2
  WM_SETFOCUS* = 0x0007
  WM_KILLFOCUS* = 0x0008
  WM_ENABLE* = 0x000A
  WM_SETREDRAW* = 0x000B
  WM_SETTEXT* = 0x000C
  WM_GETTEXT* = 0x000D
  WM_GETTEXTLENGTH* = 0x000E
  WM_PAINT* = 0x000F
  WM_CLOSE* = 0x0010
  WM_QUERYENDSESSION* = 0x0011
  WM_QUERYOPEN* = 0x0013
  WM_ENDSESSION* = 0x0016
  WM_QUIT* = 0x0012
  WM_ERASEBKGND* = 0x0014
  WM_SYSCOLORCHANGE* = 0x0015
  WM_SHOWWINDOW* = 0x0018
  WM_WININICHANGE* = 0x001A
  WM_SETTINGCHANGE* = WM_WININICHANGE
  WM_DEVMODECHANGE* = 0x001B
  WM_ACTIVATEAPP* = 0x001C
  WM_FONTCHANGE* = 0x001D
  WM_TIMECHANGE* = 0x001E
  WM_CANCELMODE* = 0x001F
  WM_SETCURSOR* = 0x0020
  WM_MOUSEACTIVATE* = 0x0021
  WM_CHILDACTIVATE* = 0x0022
  WM_QUEUESYNC* = 0x0023
  WM_GETMINMAXINFO* = 0x0024
  WM_PAINTICON* = 0x0026
  WM_ICONERASEBKGND* = 0x0027
  WM_NEXTDLGCTL* = 0x0028
  WM_SPOOLERSTATUS* = 0x002A
  WM_DRAWITEM* = 0x002B
  WM_MEASUREITEM* = 0x002C
  WM_DELETEITEM* = 0x002D
  WM_VKEYTOITEM* = 0x002E
  WM_CHARTOITEM* = 0x002F
  WM_SETFONT* = 0x0030
  WM_GETFONT* = 0x0031
  WM_SETHOTKEY* = 0x0032
  WM_GETHOTKEY* = 0x0033
  WM_QUERYDRAGICON* = 0x0037
  WM_COMPAREITEM* = 0x0039
  WM_GETOBJECT* = 0x003D
  WM_COMPACTING* = 0x0041
  WM_COMMNOTIFY* = 0x0044
  WM_WINDOWPOSCHANGING* = 0x0046
  WM_WINDOWPOSCHANGED* = 0x0047
  WM_POWER* = 0x0048
  PWR_OK* = 1
  PWR_FAIL* = -1
  PWR_SUSPENDREQUEST* = 1
  PWR_SUSPENDRESUME* = 2
  PWR_CRITICALRESUME* = 3
  WM_COPYDATA* = 0x004A
  WM_CANCELJOURNAL* = 0x004B
  WM_NOTIFY* = 0x004E
  WM_INPUTLANGCHANGEREQUEST* = 0x0050
  WM_INPUTLANGCHANGE* = 0x0051
  WM_TCARD* = 0x0052
  WM_HELP* = 0x0053
  WM_USERCHANGED* = 0x0054
  WM_NOTIFYFORMAT* = 0x0055
  NFR_ANSI* = 1
  NFR_UNICODE* = 2
  NF_QUERY* = 3
  NF_REQUERY* = 4
  WM_CONTEXTMENU* = 0x007B
  WM_STYLECHANGING* = 0x007C
  WM_STYLECHANGED* = 0x007D
  WM_DISPLAYCHANGE* = 0x007E
  WM_GETICON* = 0x007F
  WM_SETICON* = 0x0080
  WM_NCCREATE* = 0x0081
  WM_NCDESTROY* = 0x0082
  WM_NCCALCSIZE* = 0x0083
  WM_NCHITTEST* = 0x0084
  WM_NCPAINT* = 0x0085
  WM_NCACTIVATE* = 0x0086
  WM_GETDLGCODE* = 0x0087
  WM_SYNCPAINT* = 0x0088
  WM_NCMOUSEMOVE* = 0x00A0
  WM_NCLBUTTONDOWN* = 0x00A1
  WM_NCLBUTTONUP* = 0x00A2
  WM_NCLBUTTONDBLCLK* = 0x00A3
  WM_NCRBUTTONDOWN* = 0x00A4
  WM_NCRBUTTONUP* = 0x00A5
  WM_NCRBUTTONDBLCLK* = 0x00A6
  WM_NCMBUTTONDOWN* = 0x00A7
  WM_NCMBUTTONUP* = 0x00A8
  WM_NCMBUTTONDBLCLK* = 0x00A9
  WM_NCXBUTTONDOWN* = 0x00AB
  WM_NCXBUTTONUP* = 0x00AC
  WM_NCXBUTTONDBLCLK* = 0x00AD
  WM_INPUT_DEVICE_CHANGE* = 0x00fe
  WM_INPUT* = 0x00FF
  WM_KEYFIRST* = 0x0100
  WM_KEYDOWN* = 0x0100
  WM_KEYUP* = 0x0101
  WM_CHAR* = 0x0102
  WM_DEADCHAR* = 0x0103
  WM_SYSKEYDOWN* = 0x0104
  WM_SYSKEYUP* = 0x0105
  WM_SYSCHAR* = 0x0106
  WM_SYSDEADCHAR* = 0x0107
  WM_UNICHAR* = 0x0109
  WM_KEYLAST* = 0x0109
  UNICODE_NOCHAR* = 0xFFFF
  WM_IME_STARTCOMPOSITION* = 0x010D
  WM_IME_ENDCOMPOSITION* = 0x010E
  WM_IME_COMPOSITION* = 0x010F
  WM_IME_KEYLAST* = 0x010F
  WM_INITDIALOG* = 0x0110
  WM_COMMAND* = 0x0111
  WM_SYSCOMMAND* = 0x0112
  WM_TIMER* = 0x0113
  WM_HSCROLL* = 0x0114
  WM_VSCROLL* = 0x0115
  WM_INITMENU* = 0x0116
  WM_INITMENUPOPUP* = 0x0117
  WM_MENUSELECT* = 0x011F
  WM_GESTURE* = 0x0119
  WM_GESTURENOTIFY* = 0x011A
  WM_MENUCHAR* = 0x0120
  WM_ENTERIDLE* = 0x0121
  WM_MENURBUTTONUP* = 0x0122
  WM_MENUDRAG* = 0x0123
  WM_MENUGETOBJECT* = 0x0124
  WM_UNINITMENUPOPUP* = 0x0125
  WM_MENUCOMMAND* = 0x0126
  WM_CHANGEUISTATE* = 0x0127
  WM_UPDATEUISTATE* = 0x0128
  WM_QUERYUISTATE* = 0x0129
  UIS_SET* = 1
  UIS_CLEAR* = 2
  UIS_INITIALIZE* = 3
  UISF_HIDEFOCUS* = 0x1
  UISF_HIDEACCEL* = 0x2
  UISF_ACTIVE* = 0x4
  WM_CTLCOLORMSGBOX* = 0x0132
  WM_CTLCOLOREDIT* = 0x0133
  WM_CTLCOLORLISTBOX* = 0x0134
  WM_CTLCOLORBTN* = 0x0135
  WM_CTLCOLORDLG* = 0x0136
  WM_CTLCOLORSCROLLBAR* = 0x0137
  WM_CTLCOLORSTATIC* = 0x0138
  MN_GETHMENU* = 0x01E1
  WM_MOUSEFIRST* = 0x0200
  WM_MOUSEMOVE* = 0x0200
  WM_LBUTTONDOWN* = 0x0201
  WM_LBUTTONUP* = 0x0202
  WM_LBUTTONDBLCLK* = 0x0203
  WM_RBUTTONDOWN* = 0x0204
  WM_RBUTTONUP* = 0x0205
  WM_RBUTTONDBLCLK* = 0x0206
  WM_MBUTTONDOWN* = 0x0207
  WM_MBUTTONUP* = 0x0208
  WM_MBUTTONDBLCLK* = 0x0209
  WM_MOUSEWHEEL* = 0x020A
  WM_XBUTTONDOWN* = 0x020B
  WM_XBUTTONUP* = 0x020C
  WM_XBUTTONDBLCLK* = 0x020D
  WM_MOUSEHWHEEL* = 0x020e
  WM_MOUSELAST* = 0x020e
  WHEEL_DELTA* = 120
  XBUTTON1* = 0x0001
  XBUTTON2* = 0x0002
  WM_PARENTNOTIFY* = 0x0210
  WM_ENTERMENULOOP* = 0x0211
  WM_EXITMENULOOP* = 0x0212
  WM_NEXTMENU* = 0x0213
  WM_SIZING* = 0x0214
  WM_CAPTURECHANGED* = 0x0215
  WM_MOVING* = 0x0216
  WM_POWERBROADCAST* = 0x0218
  PBT_APMQUERYSUSPEND* = 0x0000
  PBT_APMQUERYSTANDBY* = 0x0001
  PBT_APMQUERYSUSPENDFAILED* = 0x0002
  PBT_APMQUERYSTANDBYFAILED* = 0x0003
  PBT_APMSUSPEND* = 0x0004
  PBT_APMSTANDBY* = 0x0005
  PBT_APMRESUMECRITICAL* = 0x0006
  PBT_APMRESUMESUSPEND* = 0x0007
  PBT_APMRESUMESTANDBY* = 0x0008
  PBTF_APMRESUMEFROMFAILURE* = 0x00000001
  PBT_APMBATTERYLOW* = 0x0009
  PBT_APMPOWERSTATUSCHANGE* = 0x000A
  PBT_APMOEMEVENT* = 0x000B
  PBT_APMRESUMEAUTOMATIC* = 0x0012
  PBT_POWERSETTINGCHANGE* = 32787
  WM_DEVICECHANGE* = 0x0219
  WM_MDICREATE* = 0x0220
  WM_MDIDESTROY* = 0x0221
  WM_MDIACTIVATE* = 0x0222
  WM_MDIRESTORE* = 0x0223
  WM_MDINEXT* = 0x0224
  WM_MDIMAXIMIZE* = 0x0225
  WM_MDITILE* = 0x0226
  WM_MDICASCADE* = 0x0227
  WM_MDIICONARRANGE* = 0x0228
  WM_MDIGETACTIVE* = 0x0229
  WM_MDISETMENU* = 0x0230
  WM_ENTERSIZEMOVE* = 0x0231
  WM_EXITSIZEMOVE* = 0x0232
  WM_DROPFILES* = 0x0233
  WM_MDIREFRESHMENU* = 0x0234
  WM_POINTERDEVICECHANGE* = 0x238
  WM_POINTERDEVICEINRANGE* = 0x239
  WM_POINTERDEVICEOUTOFRANGE* = 0x23a
  WM_TOUCH* = 0x0240
  WM_NCPOINTERUPDATE* = 0x0241
  WM_NCPOINTERDOWN* = 0x0242
  WM_NCPOINTERUP* = 0x0243
  WM_POINTERUPDATE* = 0x0245
  WM_POINTERDOWN* = 0x0246
  WM_POINTERUP* = 0x0247
  WM_POINTERENTER* = 0x0249
  WM_POINTERLEAVE* = 0x024a
  WM_POINTERACTIVATE* = 0x024b
  WM_POINTERCAPTURECHANGED* = 0x024c
  WM_TOUCHHITTESTING* = 0x024d
  WM_POINTERWHEEL* = 0x024e
  WM_POINTERHWHEEL* = 0x024f
  WM_IME_SETCONTEXT* = 0x0281
  WM_IME_NOTIFY* = 0x0282
  WM_IME_CONTROL* = 0x0283
  WM_IME_COMPOSITIONFULL* = 0x0284
  WM_IME_SELECT* = 0x0285
  WM_IME_CHAR* = 0x0286
  WM_IME_REQUEST* = 0x0288
  WM_IME_KEYDOWN* = 0x0290
  WM_IME_KEYUP* = 0x0291
  WM_MOUSEHOVER* = 0x02A1
  WM_MOUSELEAVE* = 0x02A3
  WM_NCMOUSEHOVER* = 0x02A0
  WM_NCMOUSELEAVE* = 0x02A2
  WM_WTSSESSION_CHANGE* = 0x02B1
  WM_TABLET_FIRST* = 0x02c0
  WM_TABLET_LAST* = 0x02df
  WM_CUT* = 0x0300
  WM_COPY* = 0x0301
  WM_PASTE* = 0x0302
  WM_CLEAR* = 0x0303
  WM_UNDO* = 0x0304
  WM_RENDERFORMAT* = 0x0305
  WM_RENDERALLFORMATS* = 0x0306
  WM_DESTROYCLIPBOARD* = 0x0307
  WM_DRAWCLIPBOARD* = 0x0308
  WM_PAINTCLIPBOARD* = 0x0309
  WM_VSCROLLCLIPBOARD* = 0x030A
  WM_SIZECLIPBOARD* = 0x030B
  WM_ASKCBFORMATNAME* = 0x030C
  WM_CHANGECBCHAIN* = 0x030D
  WM_HSCROLLCLIPBOARD* = 0x030E
  WM_QUERYNEWPALETTE* = 0x030F
  WM_PALETTEISCHANGING* = 0x0310
  WM_PALETTECHANGED* = 0x0311
  WM_HOTKEY* = 0x0312
  WM_PRINT* = 0x0317
  WM_PRINTCLIENT* = 0x0318
  WM_APPCOMMAND* = 0x0319
  WM_THEMECHANGED* = 0x031A
  WM_CLIPBOARDUPDATE* = 0x031d
  WM_DWMCOMPOSITIONCHANGED* = 0x031e
  WM_DWMNCRENDERINGCHANGED* = 0x031f
  WM_DWMCOLORIZATIONCOLORCHANGED* = 0x0320
  WM_DWMWINDOWMAXIMIZEDCHANGE* = 0x0321
  WM_DWMSENDICONICTHUMBNAIL* = 0x0323
  WM_DWMSENDICONICLIVEPREVIEWBITMAP* = 0x0326
  WM_GETTITLEBARINFOEX* = 0x033f
  WM_HANDHELDFIRST* = 0x0358
  WM_HANDHELDLAST* = 0x035F
  WM_AFXFIRST* = 0x0360
  WM_AFXLAST* = 0x037F
  WM_PENWINFIRST* = 0x0380
  WM_PENWINLAST* = 0x038F
  WM_APP* = 0x8000
  WM_USER* = 0x0400
  WMSZ_LEFT* = 1
  WMSZ_RIGHT* = 2
  WMSZ_TOP* = 3
  WMSZ_TOPLEFT* = 4
  WMSZ_TOPRIGHT* = 5
  WMSZ_BOTTOM* = 6
  WMSZ_BOTTOMLEFT* = 7
  WMSZ_BOTTOMRIGHT* = 8
  HTERROR* = -2
  HTTRANSPARENT* = -1
  HTNOWHERE* = 0
  HTCLIENT* = 1
  HTCAPTION* = 2
  HTSYSMENU* = 3
  HTGROWBOX* = 4
  HTSIZE* = HTGROWBOX
  HTMENU* = 5
  HTHSCROLL* = 6
  HTVSCROLL* = 7
  HTMINBUTTON* = 8
  HTMAXBUTTON* = 9
  HTLEFT* = 10
  HTRIGHT* = 11
  HTTOP* = 12
  HTTOPLEFT* = 13
  HTTOPRIGHT* = 14
  HTBOTTOM* = 15
  HTBOTTOMLEFT* = 16
  HTBOTTOMRIGHT* = 17
  HTBORDER* = 18
  HTREDUCE* = HTMINBUTTON
  HTZOOM* = HTMAXBUTTON
  HTSIZEFIRST* = HTLEFT
  HTSIZELAST* = HTBOTTOMRIGHT
  HTOBJECT* = 19
  HTCLOSE* = 20
  HTHELP* = 21
  SMTO_NORMAL* = 0x0000
  SMTO_BLOCK* = 0x0001
  SMTO_ABORTIFHUNG* = 0x0002
  SMTO_NOTIMEOUTIFNOTHUNG* = 0x0008
  SMTO_ERRORONEXIT* = 0x0020
  MA_ACTIVATE* = 1
  MA_ACTIVATEANDEAT* = 2
  MA_NOACTIVATE* = 3
  MA_NOACTIVATEANDEAT* = 4
  ICON_SMALL* = 0
  ICON_BIG* = 1
  ICON_SMALL2* = 2
  SIZE_RESTORED* = 0
  SIZE_MINIMIZED* = 1
  SIZE_MAXIMIZED* = 2
  SIZE_MAXSHOW* = 3
  SIZE_MAXHIDE* = 4
  SIZENORMAL* = SIZE_RESTORED
  SIZEICONIC* = SIZE_MINIMIZED
  SIZEFULLSCREEN* = SIZE_MAXIMIZED
  SIZEZOOMSHOW* = SIZE_MAXSHOW
  SIZEZOOMHIDE* = SIZE_MAXHIDE
  WVR_ALIGNTOP* = 0x0010
  WVR_ALIGNLEFT* = 0x0020
  WVR_ALIGNBOTTOM* = 0x0040
  WVR_ALIGNRIGHT* = 0x0080
  WVR_HREDRAW* = 0x0100
  WVR_VREDRAW* = 0x0200
  WVR_REDRAW* = WVR_HREDRAW or WVR_VREDRAW
  WVR_VALIDRECTS* = 0x0400
  MK_LBUTTON* = 0x0001
  MK_RBUTTON* = 0x0002
  MK_SHIFT* = 0x0004
  MK_CONTROL* = 0x0008
  MK_MBUTTON* = 0x0010
  MK_XBUTTON1* = 0x0020
  MK_XBUTTON2* = 0x0040
  TME_HOVER* = 0x00000001
  TME_LEAVE* = 0x00000002
  TME_NONCLIENT* = 0x00000010
  TME_QUERY* = 0x40000000
  TME_CANCEL* = 0x80000000'i32
  HOVER_DEFAULT* = 0xFFFFFFFF'i32
  WS_OVERLAPPED* = 0x00000000
  WS_POPUP* = 0x80000000'i32
  WS_CHILD* = 0x40000000
  WS_MINIMIZE* = 0x20000000
  WS_VISIBLE* = 0x10000000
  WS_DISABLED* = 0x08000000
  WS_CLIPSIBLINGS* = 0x04000000
  WS_CLIPCHILDREN* = 0x02000000
  WS_MAXIMIZE* = 0x01000000
  WS_CAPTION* = 0x00C00000
  WS_BORDER* = 0x00800000
  WS_DLGFRAME* = 0x00400000
  WS_VSCROLL* = 0x00200000
  WS_HSCROLL* = 0x00100000
  WS_SYSMENU* = 0x00080000
  WS_THICKFRAME* = 0x00040000
  WS_GROUP* = 0x00020000
  WS_TABSTOP* = 0x00010000
  WS_MINIMIZEBOX* = 0x00020000
  WS_MAXIMIZEBOX* = 0x00010000
  WS_TILED* = WS_OVERLAPPED
  WS_ICONIC* = WS_MINIMIZE
  WS_SIZEBOX* = WS_THICKFRAME
  WS_OVERLAPPEDWINDOW* = WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_THICKFRAME or WS_MINIMIZEBOX or WS_MAXIMIZEBOX
  WS_TILEDWINDOW* = WS_OVERLAPPEDWINDOW
  WS_POPUPWINDOW* = WS_POPUP or WS_BORDER or WS_SYSMENU
  WS_CHILDWINDOW* = WS_CHILD
  WS_EX_DLGMODALFRAME* = 0x00000001
  WS_EX_NOPARENTNOTIFY* = 0x00000004
  WS_EX_TOPMOST* = 0x00000008
  WS_EX_ACCEPTFILES* = 0x00000010
  WS_EX_TRANSPARENT* = 0x00000020
  WS_EX_MDICHILD* = 0x00000040
  WS_EX_TOOLWINDOW* = 0x00000080
  WS_EX_WINDOWEDGE* = 0x00000100
  WS_EX_CLIENTEDGE* = 0x00000200
  WS_EX_CONTEXTHELP* = 0x00000400
  WS_EX_RIGHT* = 0x00001000
  WS_EX_LEFT* = 0x00000000
  WS_EX_RTLREADING* = 0x00002000
  WS_EX_LTRREADING* = 0x00000000
  WS_EX_LEFTSCROLLBAR* = 0x00004000
  WS_EX_RIGHTSCROLLBAR* = 0x00000000
  WS_EX_CONTROLPARENT* = 0x00010000
  WS_EX_STATICEDGE* = 0x00020000
  WS_EX_APPWINDOW* = 0x00040000
  WS_EX_OVERLAPPEDWINDOW* = WS_EX_WINDOWEDGE or WS_EX_CLIENTEDGE
  WS_EX_PALETTEWINDOW* = WS_EX_WINDOWEDGE or WS_EX_TOOLWINDOW or WS_EX_TOPMOST
  WS_EX_LAYERED* = 0x00080000
  WS_EX_NOINHERITLAYOUT* = 0x00100000
  WS_EX_NOREDIRECTIONBITMAP* = 0x00200000
  WS_EX_LAYOUTRTL* = 0x00400000
  WS_EX_COMPOSITED* = 0x02000000
  WS_EX_NOACTIVATE* = 0x08000000
  CS_VREDRAW* = 0x0001
  CS_HREDRAW* = 0x0002
  CS_DBLCLKS* = 0x0008
  CS_OWNDC* = 0x0020
  CS_CLASSDC* = 0x0040
  CS_PARENTDC* = 0x0080
  CS_NOCLOSE* = 0x0200
  CS_SAVEBITS* = 0x0800
  CS_BYTEALIGNCLIENT* = 0x1000
  CS_BYTEALIGNWINDOW* = 0x2000
  CS_GLOBALCLASS* = 0x4000
  CS_IME* = 0x00010000
  CS_DROPSHADOW* = 0x00020000
  PRF_CHECKVISIBLE* = 0x00000001
  PRF_NONCLIENT* = 0x00000002
  PRF_CLIENT* = 0x00000004
  PRF_ERASEBKGND* = 0x00000008
  PRF_CHILDREN* = 0x00000010
  PRF_OWNED* = 0x00000020
  BDR_RAISEDOUTER* = 0x0001
  BDR_SUNKENOUTER* = 0x0002
  BDR_RAISEDINNER* = 0x0004
  BDR_SUNKENINNER* = 0x0008
  BDR_OUTER* = BDR_RAISEDOUTER or BDR_SUNKENOUTER
  BDR_INNER* = BDR_RAISEDINNER or BDR_SUNKENINNER
  BDR_RAISED* = BDR_RAISEDOUTER or BDR_RAISEDINNER
  BDR_SUNKEN* = BDR_SUNKENOUTER or BDR_SUNKENINNER
  EDGE_RAISED* = BDR_RAISEDOUTER or BDR_RAISEDINNER
  EDGE_SUNKEN* = BDR_SUNKENOUTER or BDR_SUNKENINNER
  EDGE_ETCHED* = BDR_SUNKENOUTER or BDR_RAISEDINNER
  EDGE_BUMP* = BDR_RAISEDOUTER or BDR_SUNKENINNER
  BF_LEFT* = 0x0001
  BF_TOP* = 0x0002
  BF_RIGHT* = 0x0004
  BF_BOTTOM* = 0x0008
  BF_TOPLEFT* = BF_TOP or BF_LEFT
  BF_TOPRIGHT* = BF_TOP or BF_RIGHT
  BF_BOTTOMLEFT* = BF_BOTTOM or BF_LEFT
  BF_BOTTOMRIGHT* = BF_BOTTOM or BF_RIGHT
  BF_RECT* = BF_LEFT or BF_TOP or BF_RIGHT or BF_BOTTOM
  BF_DIAGONAL* = 0x0010
  BF_DIAGONAL_ENDTOPRIGHT* = BF_DIAGONAL or BF_TOP or BF_RIGHT
  BF_DIAGONAL_ENDTOPLEFT* = BF_DIAGONAL or BF_TOP or BF_LEFT
  BF_DIAGONAL_ENDBOTTOMLEFT* = BF_DIAGONAL or BF_BOTTOM or BF_LEFT
  BF_DIAGONAL_ENDBOTTOMRIGHT* = BF_DIAGONAL or BF_BOTTOM or BF_RIGHT
  BF_MIDDLE* = 0x0800
  BF_SOFT* = 0x1000
  BF_ADJUST* = 0x2000
  BF_FLAT* = 0x4000
  BF_MONO* = 0x8000
  DFC_CAPTION* = 1
  DFC_MENU* = 2
  DFC_SCROLL* = 3
  DFC_BUTTON* = 4
  DFC_POPUPMENU* = 5
  DFCS_CAPTIONCLOSE* = 0x0000
  DFCS_CAPTIONMIN* = 0x0001
  DFCS_CAPTIONMAX* = 0x0002
  DFCS_CAPTIONRESTORE* = 0x0003
  DFCS_CAPTIONHELP* = 0x0004
  DFCS_MENUARROW* = 0x0000
  DFCS_MENUCHECK* = 0x0001
  DFCS_MENUBULLET* = 0x0002
  DFCS_MENUARROWRIGHT* = 0x0004
  DFCS_SCROLLUP* = 0x0000
  DFCS_SCROLLDOWN* = 0x0001
  DFCS_SCROLLLEFT* = 0x0002
  DFCS_SCROLLRIGHT* = 0x0003
  DFCS_SCROLLCOMBOBOX* = 0x0005
  DFCS_SCROLLSIZEGRIP* = 0x0008
  DFCS_SCROLLSIZEGRIPRIGHT* = 0x0010
  DFCS_BUTTONCHECK* = 0x0000
  DFCS_BUTTONRADIOIMAGE* = 0x0001
  DFCS_BUTTONRADIOMASK* = 0x0002
  DFCS_BUTTONRADIO* = 0x0004
  DFCS_BUTTON3STATE* = 0x0008
  DFCS_BUTTONPUSH* = 0x0010
  DFCS_INACTIVE* = 0x0100
  DFCS_PUSHED* = 0x0200
  DFCS_CHECKED* = 0x0400
  DFCS_TRANSPARENT* = 0x0800
  DFCS_HOT* = 0x1000
  DFCS_ADJUSTRECT* = 0x2000
  DFCS_FLAT* = 0x4000
  DFCS_MONO* = 0x8000
  DC_ACTIVE* = 0x0001
  DC_SMALLCAP* = 0x0002
  DC_ICON* = 0x0004
  DC_TEXT* = 0x0008
  DC_INBUTTON* = 0x0010
  DC_GRADIENT* = 0x0020
  DC_BUTTONS* = 0x1000
  IDANI_OPEN* = 1
  IDANI_CAPTION* = 3
  CF_TEXT* = 1
  CF_BITMAP* = 2
  CF_METAFILEPICT* = 3
  CF_SYLK* = 4
  CF_DIF* = 5
  CF_TIFF* = 6
  CF_OEMTEXT* = 7
  CF_DIB* = 8
  CF_PALETTE* = 9
  CF_PENDATA* = 10
  CF_RIFF* = 11
  CF_WAVE* = 12
  CF_UNICODETEXT* = 13
  CF_ENHMETAFILE* = 14
  CF_HDROP* = 15
  CF_LOCALE* = 16
  CF_DIBV5* = 17
  CF_MAX* = 18
  CF_OWNERDISPLAY* = 0x0080
  CF_DSPTEXT* = 0x0081
  CF_DSPBITMAP* = 0x0082
  CF_DSPMETAFILEPICT* = 0x0083
  CF_DSPENHMETAFILE* = 0x008E
  CF_PRIVATEFIRST* = 0x0200
  CF_PRIVATELAST* = 0x02FF
  CF_GDIOBJFIRST* = 0x0300
  CF_GDIOBJLAST* = 0x03FF
  FVIRTKEY* = TRUE
  FNOINVERT* = 0x02
  FSHIFT* = 0x04
  FCONTROL* = 0x08
  FALT* = 0x10
  WPF_SETMINPOSITION* = 0x0001
  WPF_RESTORETOMAXIMIZED* = 0x0002
  WPF_ASYNCWINDOWPLACEMENT* = 0x0004
  ODT_MENU* = 1
  ODT_LISTBOX* = 2
  ODT_COMBOBOX* = 3
  ODT_BUTTON* = 4
  ODT_STATIC* = 5
  ODA_DRAWENTIRE* = 0x0001
  ODA_SELECT* = 0x0002
  ODA_FOCUS* = 0x0004
  ODS_SELECTED* = 0x0001
  ODS_GRAYED* = 0x0002
  ODS_DISABLED* = 0x0004
  ODS_CHECKED* = 0x0008
  ODS_FOCUS* = 0x0010
  ODS_DEFAULT* = 0x0020
  ODS_COMBOBOXEDIT* = 0x1000
  ODS_HOTLIGHT* = 0x0040
  ODS_INACTIVE* = 0x0080
  ODS_NOACCEL* = 0x0100
  ODS_NOFOCUSRECT* = 0x0200
  PM_NOREMOVE* = 0x0000
  PM_REMOVE* = 0x0001
  PM_NOYIELD* = 0x0002
  QS_MOUSEMOVE* = 0x0002
  QS_MOUSEBUTTON* = 0x0004
  QS_MOUSE* = QS_MOUSEMOVE or QS_MOUSEBUTTON
  QS_KEY* = 0x0001
  QS_RAWINPUT* = 0x0400
  QS_TOUCH* = 0x0800
  QS_POINTER* = 0x1000
  QS_INPUT* = QS_MOUSE or QS_KEY or QS_RAWINPUT or QS_TOUCH or QS_POINTER
  PM_QS_INPUT* = QS_INPUT shl 16
  QS_POSTMESSAGE* = 0x0008
  QS_HOTKEY* = 0x0080
  QS_TIMER* = 0x0010
  PM_QS_POSTMESSAGE* = (QS_POSTMESSAGE or QS_HOTKEY or QS_TIMER) shl 16
  QS_PAINT* = 0x0020
  PM_QS_PAINT* = QS_PAINT shl 16
  QS_SENDMESSAGE* = 0x0040
  PM_QS_SENDMESSAGE* = QS_SENDMESSAGE shl 16
  MOD_ALT* = 0x0001
  MOD_CONTROL* = 0x0002
  MOD_SHIFT* = 0x0004
  MOD_WIN* = 0x0008
  MOD_NOREPEAT* = 0x4000
  IDHOT_SNAPWINDOW* = -1
  IDHOT_SNAPDESKTOP* = -2
  ENDSESSION_CLOSEAPP* = 0x00000001
  ENDSESSION_CRITICAL* = 0x40000000
  ENDSESSION_LOGOFF* = 0x80000000'i32
  EWX_LOGOFF* = 0x00000000
  EWX_SHUTDOWN* = 0x00000001
  EWX_REBOOT* = 0x00000002
  EWX_FORCE* = 0x00000004
  EWX_POWEROFF* = 0x00000008
  EWX_FORCEIFHUNG* = 0x00000010
  EWX_QUICKRESOLVE* = 0x00000020
  EWX_RESTARTAPPS* = 0x00000040
  EWX_HYBRID_SHUTDOWN* = 0x00400000
  EWX_BOOTOPTIONS* = 0x01000000
  BSM_ALLCOMPONENTS* = 0x00000000
  BSM_VXDS* = 0x00000001
  BSM_NETDRIVER* = 0x00000002
  BSM_INSTALLABLEDRIVERS* = 0x00000004
  BSM_APPLICATIONS* = 0x00000008
  BSM_ALLDESKTOPS* = 0x00000010
  BSF_QUERY* = 0x00000001
  BSF_IGNORECURRENTTASK* = 0x00000002
  BSF_FLUSHDISK* = 0x00000004
  BSF_NOHANG* = 0x00000008
  BSF_POSTMESSAGE* = 0x00000010
  BSF_FORCEIFHUNG* = 0x00000020
  BSF_NOTIMEOUTIFNOTHUNG* = 0x00000040
  BSF_ALLOWSFW* = 0x00000080
  BSF_SENDNOTIFYMESSAGE* = 0x00000100
  BSF_RETURNHDESK* = 0x00000200
  BSF_LUID* = 0x00000400
  BROADCAST_QUERY_DENY* = 0x424D5144
  DEVICE_NOTIFY_WINDOW_HANDLE* = 0x00000000
  DEVICE_NOTIFY_SERVICE_HANDLE* = 0x00000001
  DEVICE_NOTIFY_ALL_INTERFACE_CLASSES* = 0x00000004
  CW_USEDEFAULT* = int32 0x80000000'i32
  HWND_BROADCAST* = HWND 0xffff
  HWND_MESSAGE* = HWND(-3)
  HWND_DESKTOP* = HWND 0
  ISMEX_NOSEND* = 0x00000000
  ISMEX_SEND* = 0x00000001
  ISMEX_NOTIFY* = 0x00000002
  ISMEX_CALLBACK* = 0x00000004
  ISMEX_REPLIED* = 0x00000008
  PW_CLIENTONLY* = 0x00000001
  LWA_COLORKEY* = 0x00000001
  LWA_ALPHA* = 0x00000002
  ULW_COLORKEY* = 0x00000001
  ULW_ALPHA* = 0x00000002
  ULW_OPAQUE* = 0x00000004
  ULW_EX_NORESIZE* = 0x00000008
  FLASHW_STOP* = 0
  FLASHW_CAPTION* = 0x00000001
  FLASHW_TRAY* = 0x00000002
  FLASHW_ALL* = FLASHW_CAPTION or FLASHW_TRAY
  FLASHW_TIMER* = 0x00000004
  FLASHW_TIMERNOFG* = 0x0000000c
  WDA_NONE* = 0x00000000
  WDA_MONITOR* = 0x00000001
  SWP_NOSIZE* = 0x0001
  SWP_NOMOVE* = 0x0002
  SWP_NOZORDER* = 0x0004
  SWP_NOREDRAW* = 0x0008
  SWP_NOACTIVATE* = 0x0010
  SWP_FRAMECHANGED* = 0x0020
  SWP_SHOWWINDOW* = 0x0040
  SWP_HIDEWINDOW* = 0x0080
  SWP_NOCOPYBITS* = 0x0100
  SWP_NOOWNERZORDER* = 0x0200
  SWP_NOSENDCHANGING* = 0x0400
  SWP_DRAWFRAME* = SWP_FRAMECHANGED
  SWP_NOREPOSITION* = SWP_NOOWNERZORDER
  SWP_DEFERERASE* = 0x2000
  SWP_ASYNCWINDOWPOS* = 0x4000
  HWND_TOP* = HWND 0
  HWND_BOTTOM* = HWND 1
  HWND_TOPMOST* = HWND(-1)
  HWND_NOTOPMOST* = HWND(-2)
  DLGWINDOWEXTRA* = 30
  KEYEVENTF_EXTENDEDKEY* = 0x0001
  KEYEVENTF_KEYUP* = 0x0002
  KEYEVENTF_UNICODE* = 0x0004
  KEYEVENTF_SCANCODE* = 0x0008
  MOUSEEVENTF_MOVE* = 0x0001
  MOUSEEVENTF_LEFTDOWN* = 0x0002
  MOUSEEVENTF_LEFTUP* = 0x0004
  MOUSEEVENTF_RIGHTDOWN* = 0x0008
  MOUSEEVENTF_RIGHTUP* = 0x0010
  MOUSEEVENTF_MIDDLEDOWN* = 0x0020
  MOUSEEVENTF_MIDDLEUP* = 0x0040
  MOUSEEVENTF_XDOWN* = 0x0080
  MOUSEEVENTF_XUP* = 0x0100
  MOUSEEVENTF_WHEEL* = 0x0800
  MOUSEEVENTF_HWHEEL* = 0x01000
  MOUSEEVENTF_MOVE_NOCOALESCE* = 0x2000
  MOUSEEVENTF_VIRTUALDESK* = 0x4000
  MOUSEEVENTF_ABSOLUTE* = 0x8000
  INPUT_MOUSE* = 0
  INPUT_KEYBOARD* = 1
  INPUT_HARDWARE* = 2
  TOUCHEVENTF_MOVE* = 0x0001
  TOUCHEVENTF_DOWN* = 0x0002
  TOUCHEVENTF_UP* = 0x0004
  TOUCHEVENTF_INRANGE* = 0x0008
  TOUCHEVENTF_PRIMARY* = 0x0010
  TOUCHEVENTF_NOCOALESCE* = 0x0020
  TOUCHEVENTF_PEN* = 0x0040
  TOUCHEVENTF_PALM* = 0x0080
  TOUCHINPUTMASKF_TIMEFROMSYSTEM* = 0x0001
  TOUCHINPUTMASKF_EXTRAINFO* = 0x0002
  TOUCHINPUTMASKF_CONTACTAREA* = 0x0004
  TWF_FINETOUCH* = 0x00000001
  TWF_WANTPALM* = 0x00000002
  POINTER_FLAG_NONE* = 0x00000000
  POINTER_FLAG_NEW* = 0x00000001
  POINTER_FLAG_INRANGE* = 0x00000002
  POINTER_FLAG_INCONTACT* = 0x00000004
  POINTER_FLAG_FIRSTBUTTON* = 0x00000010
  POINTER_FLAG_SECONDBUTTON* = 0x00000020
  POINTER_FLAG_THIRDBUTTON* = 0x00000040
  POINTER_FLAG_FOURTHBUTTON* = 0x00000080
  POINTER_FLAG_FIFTHBUTTON* = 0x00000100
  POINTER_FLAG_PRIMARY* = 0x00002000
  POINTER_FLAG_CONFIDENCE* = 0x00004000
  POINTER_FLAG_CANCELED* = 0x00008000
  POINTER_FLAG_DOWN* = 0x00010000
  POINTER_FLAG_UPDATE* = 0x00020000
  POINTER_FLAG_UP* = 0x00040000
  POINTER_FLAG_WHEEL* = 0x00080000
  POINTER_FLAG_HWHEEL* = 0x00100000
  POINTER_FLAG_CAPTURECHANGED* = 0x00200000
  POINTER_MOD_SHIFT* = 0x0004
  POINTER_MOD_CTRL* = 0x0008
  TOUCH_FLAG_NONE* = 0x00000000
  TOUCH_MASK_NONE* = 0x00000000
  TOUCH_MASK_CONTACTAREA* = 0x00000001
  TOUCH_MASK_ORIENTATION* = 0x00000002
  TOUCH_MASK_PRESSURE* = 0x00000004
  PEN_FLAG_NONE* = 0x00000000
  PEN_FLAG_BARREL* = 0x00000001
  PEN_FLAG_INVERTED* = 0x00000002
  PEN_FLAG_ERASER* = 0x00000004
  PEN_MASK_NONE* = 0x00000000
  PEN_MASK_PRESSURE* = 0x00000001
  PEN_MASK_ROTATION* = 0x00000002
  PEN_MASK_TILT_X* = 0x00000004
  PEN_MASK_TILT_Y* = 0x00000008
  POINTER_MESSAGE_FLAG_NEW* = 0x00000001
  POINTER_MESSAGE_FLAG_INRANGE* = 0x00000002
  POINTER_MESSAGE_FLAG_INCONTACT* = 0x00000004
  POINTER_MESSAGE_FLAG_FIRSTBUTTON* = 0x00000010
  POINTER_MESSAGE_FLAG_SECONDBUTTON* = 0x00000020
  POINTER_MESSAGE_FLAG_THIRDBUTTON* = 0x00000040
  POINTER_MESSAGE_FLAG_FOURTHBUTTON* = 0x00000080
  POINTER_MESSAGE_FLAG_FIFTHBUTTON* = 0x00000100
  POINTER_MESSAGE_FLAG_PRIMARY* = 0x00002000
  POINTER_MESSAGE_FLAG_CONFIDENCE* = 0x00004000
  POINTER_MESSAGE_FLAG_CANCELED* = 0x00008000
  PA_ACTIVATE* = MA_ACTIVATE
  PA_NOACTIVATE* = MA_NOACTIVATE
  MAX_TOUCH_COUNT* = 256
  TOUCH_FEEDBACK_DEFAULT* = 0x1
  TOUCH_FEEDBACK_INDIRECT* = 0x2
  TOUCH_FEEDBACK_NONE* = 0x3
  TOUCH_HIT_TESTING_DEFAULT* = 0x0
  TOUCH_HIT_TESTING_CLIENT* = 0x1
  TOUCH_HIT_TESTING_NONE* = 0x2
  TOUCH_HIT_TESTING_PROXIMITY_CLOSEST* = 0x0
  TOUCH_HIT_TESTING_PROXIMITY_FARTHEST* = 0xfff
  GWFS_INCLUDE_ANCESTORS* = 0x00000001
  PT_POINTER* = 0x00000001
  PT_TOUCH* = 0x00000002
  PT_PEN* = 0x00000003
  PT_MOUSE* = 0x00000004
  FEEDBACK_TOUCH_CONTACTVISUALIZATION* = 1
  FEEDBACK_PEN_BARRELVISUALIZATION* = 2
  FEEDBACK_PEN_TAP* = 3
  FEEDBACK_PEN_DOUBLETAP* = 4
  FEEDBACK_PEN_PRESSANDHOLD* = 5
  FEEDBACK_PEN_RIGHTTAP* = 6
  FEEDBACK_TOUCH_TAP* = 7
  FEEDBACK_TOUCH_DOUBLETAP* = 8
  FEEDBACK_TOUCH_PRESSANDHOLD* = 9
  FEEDBACK_TOUCH_RIGHTTAP* = 10
  FEEDBACK_GESTURE_PRESSANDTAP* = 11
  FEEDBACK_MAX* = 0xffffffff'i32
  POINTER_CHANGE_NONE* = 0
  POINTER_CHANGE_FIRSTBUTTON_DOWN* = 1
  POINTER_CHANGE_FIRSTBUTTON_UP* = 2
  POINTER_CHANGE_SECONDBUTTON_DOWN* = 3
  POINTER_CHANGE_SECONDBUTTON_UP* = 4
  POINTER_CHANGE_THIRDBUTTON_DOWN* = 5
  POINTER_CHANGE_THIRDBUTTON_UP* = 6
  POINTER_CHANGE_FOURTHBUTTON_DOWN* = 7
  POINTER_CHANGE_FOURTHBUTTON_UP* = 8
  POINTER_CHANGE_FIFTHBUTTON_DOWN* = 9
  POINTER_CHANGE_FIFTHBUTTON_UP* = 10
  MAPVK_VK_TO_VSC* = 0
  MAPVK_VSC_TO_VK* = 1
  MAPVK_VK_TO_CHAR* = 2
  MAPVK_VSC_TO_VK_EX* = 3
  MAPVK_VK_TO_VSC_EX* = 4
  MWMO_WAITALL* = 0x0001
  MWMO_ALERTABLE* = 0x0002
  MWMO_INPUTAVAILABLE* = 0x0004
  QS_ALLPOSTMESSAGE* = 0x0100
  QS_ALLEVENTS* = QS_INPUT or QS_POSTMESSAGE or QS_TIMER or QS_PAINT or QS_HOTKEY
  QS_ALLINPUT* = QS_INPUT or QS_POSTMESSAGE or QS_TIMER or QS_PAINT or QS_HOTKEY or QS_SENDMESSAGE
  USER_TIMER_MAXIMUM* = 0x7FFFFFFF
  USER_TIMER_MINIMUM* = 0x0000000A
  TIMERV_DEFAULT_COALESCING* = 0
  TIMERV_NO_COALESCING* = 0xffffffff'i32
  TIMERV_COALESCING_MIN* = 1
  TIMERV_COALESCING_MAX* = 0x7ffffff5
  SM_CXSCREEN* = 0
  SM_CYSCREEN* = 1
  SM_CXVSCROLL* = 2
  SM_CYHSCROLL* = 3
  SM_CYCAPTION* = 4
  SM_CXBORDER* = 5
  SM_CYBORDER* = 6
  SM_CXDLGFRAME* = 7
  SM_CYDLGFRAME* = 8
  SM_CYVTHUMB* = 9
  SM_CXHTHUMB* = 10
  SM_CXICON* = 11
  SM_CYICON* = 12
  SM_CXCURSOR* = 13
  SM_CYCURSOR* = 14
  SM_CYMENU* = 15
  SM_CXFULLSCREEN* = 16
  SM_CYFULLSCREEN* = 17
  SM_CYKANJIWINDOW* = 18
  SM_MOUSEPRESENT* = 19
  SM_CYVSCROLL* = 20
  SM_CXHSCROLL* = 21
  SM_DEBUG* = 22
  SM_SWAPBUTTON* = 23
  SM_RESERVED1* = 24
  SM_RESERVED2* = 25
  SM_RESERVED3* = 26
  SM_RESERVED4* = 27
  SM_CXMIN* = 28
  SM_CYMIN* = 29
  SM_CXSIZE* = 30
  SM_CYSIZE* = 31
  SM_CXFRAME* = 32
  SM_CYFRAME* = 33
  SM_CXMINTRACK* = 34
  SM_CYMINTRACK* = 35
  SM_CXDOUBLECLK* = 36
  SM_CYDOUBLECLK* = 37
  SM_CXICONSPACING* = 38
  SM_CYICONSPACING* = 39
  SM_MENUDROPALIGNMENT* = 40
  SM_PENWINDOWS* = 41
  SM_DBCSENABLED* = 42
  SM_CMOUSEBUTTONS* = 43
  SM_CXFIXEDFRAME* = SM_CXDLGFRAME
  SM_CYFIXEDFRAME* = SM_CYDLGFRAME
  SM_CXSIZEFRAME* = SM_CXFRAME
  SM_CYSIZEFRAME* = SM_CYFRAME
  SM_SECURE* = 44
  SM_CXEDGE* = 45
  SM_CYEDGE* = 46
  SM_CXMINSPACING* = 47
  SM_CYMINSPACING* = 48
  SM_CXSMICON* = 49
  SM_CYSMICON* = 50
  SM_CYSMCAPTION* = 51
  SM_CXSMSIZE* = 52
  SM_CYSMSIZE* = 53
  SM_CXMENUSIZE* = 54
  SM_CYMENUSIZE* = 55
  SM_ARRANGE* = 56
  SM_CXMINIMIZED* = 57
  SM_CYMINIMIZED* = 58
  SM_CXMAXTRACK* = 59
  SM_CYMAXTRACK* = 60
  SM_CXMAXIMIZED* = 61
  SM_CYMAXIMIZED* = 62
  SM_NETWORK* = 63
  SM_CLEANBOOT* = 67
  SM_CXDRAG* = 68
  SM_CYDRAG* = 69
  SM_SHOWSOUNDS* = 70
  SM_CXMENUCHECK* = 71
  SM_CYMENUCHECK* = 72
  SM_SLOWMACHINE* = 73
  SM_MIDEASTENABLED* = 74
  SM_MOUSEWHEELPRESENT* = 75
  SM_XVIRTUALSCREEN* = 76
  SM_YVIRTUALSCREEN* = 77
  SM_CXVIRTUALSCREEN* = 78
  SM_CYVIRTUALSCREEN* = 79
  SM_CMONITORS* = 80
  SM_SAMEDISPLAYFORMAT* = 81
  SM_IMMENABLED* = 82
  SM_CXFOCUSBORDER* = 83
  SM_CYFOCUSBORDER* = 84
  SM_TABLETPC* = 86
  SM_MEDIACENTER* = 87
  SM_STARTER* = 88
  SM_SERVERR2* = 89
  SM_MOUSEHORIZONTALWHEELPRESENT* = 91
  SM_CXPADDEDBORDER* = 92
  SM_DIGITIZER* = 94
  SM_MAXIMUMTOUCHES* = 95
  SM_CMETRICS* = 97
  SM_REMOTESESSION* = 0x1000
  SM_SHUTTINGDOWN* = 0x2000
  SM_REMOTECONTROL* = 0x2001
  SM_CARETBLINKINGENABLED* = 0x2002
  SM_CONVERTIBLESLATEMODE* = 0x2003
  SM_SYSTEMDOCKED* = 0x2004
  PMB_ACTIVE* = 0x00000001
  MNC_IGNORE* = 0
  MNC_CLOSE* = 1
  MNC_EXECUTE* = 2
  MNC_SELECT* = 3
  MNS_NOCHECK* = 0x80000000'i32
  MNS_MODELESS* = 0x40000000
  MNS_DRAGDROP* = 0x20000000
  MNS_AUTODISMISS* = 0x10000000
  MNS_NOTIFYBYPOS* = 0x08000000
  MNS_CHECKORBMP* = 0x04000000
  MIM_MAXHEIGHT* = 0x00000001
  MIM_BACKGROUND* = 0x00000002
  MIM_HELPID* = 0x00000004
  MIM_MENUDATA* = 0x00000008
  MIM_STYLE* = 0x00000010
  MIM_APPLYTOSUBMENUS* = 0x80000000'i32
  MND_CONTINUE* = 0
  MND_ENDMENU* = 1
  MNGOF_TOPGAP* = 0x00000001
  MNGOF_BOTTOMGAP* = 0x00000002
  MNGO_NOINTERFACE* = 0x00000000
  MNGO_NOERROR* = 0x00000001
  MIIM_STATE* = 0x00000001
  MIIM_ID* = 0x00000002
  MIIM_SUBMENU* = 0x00000004
  MIIM_CHECKMARKS* = 0x00000008
  MIIM_TYPE* = 0x00000010
  MIIM_DATA* = 0x00000020
  MIIM_STRING* = 0x00000040
  MIIM_BITMAP* = 0x00000080
  MIIM_FTYPE* = 0x00000100
  HBMMENU_CALLBACK* = HBITMAP(-1)
  HBMMENU_SYSTEM* = HBITMAP 1
  HBMMENU_MBAR_RESTORE* = HBITMAP 2
  HBMMENU_MBAR_MINIMIZE* = HBITMAP 3
  HBMMENU_MBAR_CLOSE* = HBITMAP 5
  HBMMENU_MBAR_CLOSE_D* = HBITMAP 6
  HBMMENU_MBAR_MINIMIZE_D* = HBITMAP 7
  HBMMENU_POPUP_CLOSE* = HBITMAP 8
  HBMMENU_POPUP_RESTORE* = HBITMAP 9
  HBMMENU_POPUP_MAXIMIZE* = HBITMAP 10
  HBMMENU_POPUP_MINIMIZE* = HBITMAP 11
  GMDI_USEDISABLED* = 0x0001
  GMDI_GOINTOPOPUPS* = 0x0002
  TPM_LEFTBUTTON* = 0x0000
  TPM_RIGHTBUTTON* = 0x0002
  TPM_LEFTALIGN* = 0x0000
  TPM_CENTERALIGN* = 0x0004
  TPM_RIGHTALIGN* = 0x0008
  TPM_TOPALIGN* = 0x0000
  TPM_VCENTERALIGN* = 0x0010
  TPM_BOTTOMALIGN* = 0x0020
  TPM_HORIZONTAL* = 0x0000
  TPM_VERTICAL* = 0x0040
  TPM_NONOTIFY* = 0x0080
  TPM_RETURNCMD* = 0x0100
  TPM_RECURSE* = 0x0001
  TPM_HORPOSANIMATION* = 0x0400
  TPM_HORNEGANIMATION* = 0x0800
  TPM_VERPOSANIMATION* = 0x1000
  TPM_VERNEGANIMATION* = 0x2000
  TPM_NOANIMATION* = 0x4000
  TPM_LAYOUTRTL* = 0x8000
  TPM_WORKAREA* = 0x10000
  DOF_EXECUTABLE* = 0x8001
  DOF_DOCUMENT* = 0x8002
  DOF_DIRECTORY* = 0x8003
  DOF_MULTIPLE* = 0x8004
  DOF_PROGMAN* = 0x0001
  DOF_SHELLDATA* = 0x0002
  DO_DROPFILE* = 0x454C4946
  DO_PRINTFILE* = 0x544E5250
  DT_TOP* = 0x00000000
  DT_LEFT* = 0x00000000
  DT_CENTER* = 0x00000001
  DT_RIGHT* = 0x00000002
  DT_VCENTER* = 0x00000004
  DT_BOTTOM* = 0x00000008
  DT_WORDBREAK* = 0x00000010
  DT_SINGLELINE* = 0x00000020
  DT_EXPANDTABS* = 0x00000040
  DT_TABSTOP* = 0x00000080
  DT_NOCLIP* = 0x00000100
  DT_EXTERNALLEADING* = 0x00000200
  DT_CALCRECT* = 0x00000400
  DT_NOPREFIX* = 0x00000800
  DT_INTERNAL* = 0x00001000
  DT_EDITCONTROL* = 0x00002000
  DT_PATH_ELLIPSIS* = 0x00004000
  DT_END_ELLIPSIS* = 0x00008000
  DT_MODIFYSTRING* = 0x00010000
  DT_RTLREADING* = 0x00020000
  DT_WORD_ELLIPSIS* = 0x00040000
  DT_NOFULLWIDTHCHARBREAK* = 0x00080000
  DT_HIDEPREFIX* = 0x00100000
  DT_PREFIXONLY* = 0x00200000
  DST_COMPLEX* = 0x0000
  DST_TEXT* = 0x0001
  DST_PREFIXTEXT* = 0x0002
  DST_ICON* = 0x0003
  DST_BITMAP* = 0x0004
  DSS_NORMAL* = 0x0000
  DSS_UNION* = 0x0010
  DSS_DISABLED* = 0x0020
  DSS_MONO* = 0x0080
  DSS_HIDEPREFIX* = 0x0200
  DSS_PREFIXONLY* = 0x0400
  DSS_RIGHT* = 0x8000
  ASFW_ANY* = DWORD(-1)
  LSFW_LOCK* = 1
  LSFW_UNLOCK* = 2
  DCX_WINDOW* = 0x00000001
  DCX_CACHE* = 0x00000002
  DCX_NORESETATTRS* = 0x00000004
  DCX_CLIPCHILDREN* = 0x00000008
  DCX_CLIPSIBLINGS* = 0x00000010
  DCX_PARENTCLIP* = 0x00000020
  DCX_EXCLUDERGN* = 0x00000040
  DCX_INTERSECTRGN* = 0x00000080
  DCX_EXCLUDEUPDATE* = 0x00000100
  DCX_INTERSECTUPDATE* = 0x00000200
  DCX_LOCKWINDOWUPDATE* = 0x00000400
  DCX_VALIDATE* = 0x00200000
  RDW_INVALIDATE* = 0x0001
  RDW_INTERNALPAINT* = 0x0002
  RDW_ERASE* = 0x0004
  RDW_VALIDATE* = 0x0008
  RDW_NOINTERNALPAINT* = 0x0010
  RDW_NOERASE* = 0x0020
  RDW_NOCHILDREN* = 0x0040
  RDW_ALLCHILDREN* = 0x0080
  RDW_UPDATENOW* = 0x0100
  RDW_ERASENOW* = 0x0200
  RDW_FRAME* = 0x0400
  RDW_NOFRAME* = 0x0800
  SW_SCROLLCHILDREN* = 0x0001
  SW_INVALIDATE* = 0x0002
  SW_ERASE* = 0x0004
  SW_SMOOTHSCROLL* = 0x0010
  ESB_ENABLE_BOTH* = 0x0000
  ESB_DISABLE_BOTH* = 0x0003
  ESB_DISABLE_LEFT* = 0x0001
  ESB_DISABLE_RIGHT* = 0x0002
  ESB_DISABLE_UP* = 0x0001
  ESB_DISABLE_DOWN* = 0x0002
  ESB_DISABLE_LTUP* = ESB_DISABLE_LEFT
  ESB_DISABLE_RTDN* = ESB_DISABLE_RIGHT
  HELPINFO_WINDOW* = 0x0001
  HELPINFO_MENUITEM* = 0x0002
  MB_OK* = 0x00000000
  MB_OKCANCEL* = 0x00000001
  MB_ABORTRETRYIGNORE* = 0x00000002
  MB_YESNOCANCEL* = 0x00000003
  MB_YESNO* = 0x00000004
  MB_RETRYCANCEL* = 0x00000005
  MB_CANCELTRYCONTINUE* = 0x00000006
  MB_ICONHAND* = 0x00000010
  MB_ICONQUESTION* = 0x00000020
  MB_ICONEXCLAMATION* = 0x00000030
  MB_ICONASTERISK* = 0x00000040
  MB_USERICON* = 0x00000080
  MB_ICONWARNING* = MB_ICONEXCLAMATION
  MB_ICONERROR* = MB_ICONHAND
  MB_ICONINFORMATION* = MB_ICONASTERISK
  MB_ICONSTOP* = MB_ICONHAND
  MB_DEFBUTTON1* = 0x00000000
  MB_DEFBUTTON2* = 0x00000100
  MB_DEFBUTTON3* = 0x00000200
  MB_DEFBUTTON4* = 0x00000300
  MB_APPLMODAL* = 0x00000000
  MB_SYSTEMMODAL* = 0x00001000
  MB_TASKMODAL* = 0x00002000
  MB_HELP* = 0x00004000
  MB_NOFOCUS* = 0x00008000
  MB_SETFOREGROUND* = 0x00010000
  MB_DEFAULT_DESKTOP_ONLY* = 0x00020000
  MB_TOPMOST* = 0x00040000
  MB_RIGHT* = 0x00080000
  MB_RTLREADING* = 0x00100000
  MB_SERVICE_NOTIFICATION* = 0x00200000
  MB_SERVICE_NOTIFICATION_NT3X* = 0x00040000
  MB_TYPEMASK* = 0x0000000F
  MB_ICONMASK* = 0x000000F0
  MB_DEFMASK* = 0x00000F00
  MB_MODEMASK* = 0x00003000
  MB_MISCMASK* = 0x0000C000
  CWP_ALL* = 0x0000
  CWP_SKIPINVISIBLE* = 0x0001
  CWP_SKIPDISABLED* = 0x0002
  CWP_SKIPTRANSPARENT* = 0x0004
  CTLCOLOR_MSGBOX* = 0
  CTLCOLOR_EDIT* = 1
  CTLCOLOR_LISTBOX* = 2
  CTLCOLOR_BTN* = 3
  CTLCOLOR_DLG* = 4
  CTLCOLOR_SCROLLBAR* = 5
  CTLCOLOR_STATIC* = 6
  CTLCOLOR_MAX* = 7
  COLOR_SCROLLBAR* = 0
  COLOR_BACKGROUND* = 1
  COLOR_ACTIVECAPTION* = 2
  COLOR_INACTIVECAPTION* = 3
  COLOR_MENU* = 4
  COLOR_WINDOW* = 5
  COLOR_WINDOWFRAME* = 6
  COLOR_MENUTEXT* = 7
  COLOR_WINDOWTEXT* = 8
  COLOR_CAPTIONTEXT* = 9
  COLOR_ACTIVEBORDER* = 10
  COLOR_INACTIVEBORDER* = 11
  COLOR_APPWORKSPACE* = 12
  COLOR_HIGHLIGHT* = 13
  COLOR_HIGHLIGHTTEXT* = 14
  COLOR_BTNFACE* = 15
  COLOR_BTNSHADOW* = 16
  COLOR_GRAYTEXT* = 17
  COLOR_BTNTEXT* = 18
  COLOR_INACTIVECAPTIONTEXT* = 19
  COLOR_BTNHIGHLIGHT* = 20
  COLOR_3DDKSHADOW* = 21
  COLOR_3DLIGHT* = 22
  COLOR_INFOTEXT* = 23
  COLOR_INFOBK* = 24
  COLOR_HOTLIGHT* = 26
  COLOR_GRADIENTACTIVECAPTION* = 27
  COLOR_GRADIENTINACTIVECAPTION* = 28
  COLOR_MENUHILIGHT* = 29
  COLOR_MENUBAR* = 30
  COLOR_DESKTOP* = COLOR_BACKGROUND
  COLOR_3DFACE* = COLOR_BTNFACE
  COLOR_3DSHADOW* = COLOR_BTNSHADOW
  COLOR_3DHIGHLIGHT* = COLOR_BTNHIGHLIGHT
  COLOR_3DHILIGHT* = COLOR_BTNHIGHLIGHT
  COLOR_BTNHILIGHT* = COLOR_BTNHIGHLIGHT
  GW_HWNDFIRST* = 0
  GW_HWNDLAST* = 1
  GW_HWNDNEXT* = 2
  GW_HWNDPREV* = 3
  GW_OWNER* = 4
  GW_CHILD* = 5
  GW_ENABLEDPOPUP* = 6
  GW_MAX* = 6
  MF_INSERT* = 0x00000000
  MF_CHANGE* = 0x00000080
  MF_APPEND* = 0x00000100
  MF_DELETE* = 0x00000200
  MF_REMOVE* = 0x00001000
  MF_BYCOMMAND* = 0x00000000
  MF_BYPOSITION* = 0x00000400
  MF_SEPARATOR* = 0x00000800
  MF_ENABLED* = 0x00000000
  MF_GRAYED* = 0x00000001
  MF_DISABLED* = 0x00000002
  MF_UNCHECKED* = 0x00000000
  MF_CHECKED* = 0x00000008
  MF_USECHECKBITMAPS* = 0x00000200
  MF_STRING* = 0x00000000
  MF_BITMAP* = 0x00000004
  MF_OWNERDRAW* = 0x00000100
  MF_POPUP* = 0x00000010
  MF_MENUBARBREAK* = 0x00000020
  MF_MENUBREAK* = 0x00000040
  MF_UNHILITE* = 0x00000000
  MF_HILITE* = 0x00000080
  MF_DEFAULT* = 0x00001000
  MF_SYSMENU* = 0x00002000
  MF_HELP* = 0x00004000
  MF_RIGHTJUSTIFY* = 0x00004000
  MF_MOUSESELECT* = 0x00008000
  MF_END* = 0x00000080
  MFT_STRING* = MF_STRING
  MFT_BITMAP* = MF_BITMAP
  MFT_MENUBARBREAK* = MF_MENUBARBREAK
  MFT_MENUBREAK* = MF_MENUBREAK
  MFT_OWNERDRAW* = MF_OWNERDRAW
  MFT_RADIOCHECK* = 0x00000200
  MFT_SEPARATOR* = MF_SEPARATOR
  MFT_RIGHTORDER* = 0x00002000
  MFT_RIGHTJUSTIFY* = MF_RIGHTJUSTIFY
  MFS_GRAYED* = 0x00000003
  MFS_DISABLED* = MFS_GRAYED
  MFS_CHECKED* = MF_CHECKED
  MFS_HILITE* = MF_HILITE
  MFS_ENABLED* = MF_ENABLED
  MFS_UNCHECKED* = MF_UNCHECKED
  MFS_UNHILITE* = MF_UNHILITE
  MFS_DEFAULT* = MF_DEFAULT
  SC_SIZE* = 0xF000
  SC_MOVE* = 0xF010
  SC_MINIMIZE* = 0xF020
  SC_MAXIMIZE* = 0xF030
  SC_NEXTWINDOW* = 0xF040
  SC_PREVWINDOW* = 0xF050
  SC_CLOSE* = 0xF060
  SC_VSCROLL* = 0xF070
  SC_HSCROLL* = 0xF080
  SC_MOUSEMENU* = 0xF090
  SC_KEYMENU* = 0xF100
  SC_ARRANGE* = 0xF110
  SC_RESTORE* = 0xF120
  SC_TASKLIST* = 0xF130
  SC_SCREENSAVE* = 0xF140
  SC_HOTKEY* = 0xF150
  SC_DEFAULT* = 0xF160
  SC_MONITORPOWER* = 0xF170
  SC_CONTEXTHELP* = 0xF180
  SC_SEPARATOR* = 0xF00F
  SCF_ISSECURE* = 0x00000001
  SC_ICON* = SC_MINIMIZE
  SC_ZOOM* = SC_MAXIMIZE
  IDC_ARROW* = MAKEINTRESOURCE(32512)
  IDC_IBEAM* = MAKEINTRESOURCE(32513)
  IDC_WAIT* = MAKEINTRESOURCE(32514)
  IDC_CROSS* = MAKEINTRESOURCE(32515)
  IDC_UPARROW* = MAKEINTRESOURCE(32516)
  IDC_SIZE* = MAKEINTRESOURCE(32640)
  IDC_ICON* = MAKEINTRESOURCE(32641)
  IDC_SIZENWSE* = MAKEINTRESOURCE(32642)
  IDC_SIZENESW* = MAKEINTRESOURCE(32643)
  IDC_SIZEWE* = MAKEINTRESOURCE(32644)
  IDC_SIZENS* = MAKEINTRESOURCE(32645)
  IDC_SIZEALL* = MAKEINTRESOURCE(32646)
  IDC_NO* = MAKEINTRESOURCE(32648)
  IDC_HAND* = MAKEINTRESOURCE(32649)
  IDC_APPSTARTING* = MAKEINTRESOURCE(32650)
  IDC_HELP* = MAKEINTRESOURCE(32651)
  IMAGE_BITMAP* = 0
  IMAGE_ICON* = 1
  IMAGE_CURSOR* = 2
  IMAGE_ENHMETAFILE* = 3
  LR_DEFAULTCOLOR* = 0x0000
  LR_MONOCHROME* = 0x0001
  LR_COLOR* = 0x0002
  LR_COPYRETURNORG* = 0x0004
  LR_COPYDELETEORG* = 0x0008
  LR_LOADFROMFILE* = 0x0010
  LR_LOADTRANSPARENT* = 0x0020
  LR_DEFAULTSIZE* = 0x0040
  LR_VGACOLOR* = 0x0080
  LR_LOADMAP3DCOLORS* = 0x1000
  LR_CREATEDIBSECTION* = 0x2000
  LR_COPYFROMRESOURCE* = 0x4000
  LR_SHARED* = 0x8000
  DI_MASK* = 0x0001
  DI_IMAGE* = 0x0002
  DI_NORMAL* = 0x0003
  DI_COMPAT* = 0x0004
  DI_DEFAULTSIZE* = 0x0008
  DI_NOMIRROR* = 0x0010
  RES_ICON* = 1
  RES_CURSOR* = 2
  OBM_CLOSE* = 32754
  OBM_UPARROW* = 32753
  OBM_DNARROW* = 32752
  OBM_RGARROW* = 32751
  OBM_LFARROW* = 32750
  OBM_REDUCE* = 32749
  OBM_ZOOM* = 32748
  OBM_RESTORE* = 32747
  OBM_REDUCED* = 32746
  OBM_ZOOMD* = 32745
  OBM_RESTORED* = 32744
  OBM_UPARROWD* = 32743
  OBM_DNARROWD* = 32742
  OBM_RGARROWD* = 32741
  OBM_LFARROWD* = 32740
  OBM_MNARROW* = 32739
  OBM_COMBO* = 32738
  OBM_UPARROWI* = 32737
  OBM_DNARROWI* = 32736
  OBM_RGARROWI* = 32735
  OBM_LFARROWI* = 32734
  OBM_OLD_CLOSE* = 32767
  OBM_SIZE* = 32766
  OBM_OLD_UPARROW* = 32765
  OBM_OLD_DNARROW* = 32764
  OBM_OLD_RGARROW* = 32763
  OBM_OLD_LFARROW* = 32762
  OBM_BTSIZE* = 32761
  OBM_CHECK* = 32760
  OBM_CHECKBOXES* = 32759
  OBM_BTNCORNERS* = 32758
  OBM_OLD_REDUCE* = 32757
  OBM_OLD_ZOOM* = 32756
  OBM_OLD_RESTORE* = 32755
  OCR_NORMAL* = 32512
  OCR_IBEAM* = 32513
  OCR_WAIT* = 32514
  OCR_CROSS* = 32515
  OCR_UP* = 32516
  OCR_SIZE* = 32640
  OCR_ICON* = 32641
  OCR_SIZENWSE* = 32642
  OCR_SIZENESW* = 32643
  OCR_SIZEWE* = 32644
  OCR_SIZENS* = 32645
  OCR_SIZEALL* = 32646
  OCR_ICOCUR* = 32647
  OCR_NO* = 32648
  OCR_HAND* = 32649
  OCR_APPSTARTING* = 32650
  OIC_SAMPLE* = 32512
  OIC_HAND* = 32513
  OIC_QUES* = 32514
  OIC_BANG* = 32515
  OIC_NOTE* = 32516
  OIC_WINLOGO* = 32517
  OIC_WARNING* = OIC_BANG
  OIC_ERROR* = OIC_HAND
  OIC_INFORMATION* = OIC_NOTE
  OIC_SHIELD* = 32518
  ORD_LANGDRIVER* = 1
  IDI_APPLICATION* = MAKEINTRESOURCE(32512)
  IDI_HAND* = MAKEINTRESOURCE(32513)
  IDI_QUESTION* = MAKEINTRESOURCE(32514)
  IDI_EXCLAMATION* = MAKEINTRESOURCE(32515)
  IDI_ASTERISK* = MAKEINTRESOURCE(32516)
  IDI_WINLOGO* = MAKEINTRESOURCE(32517)
  IDI_SHIELD* = MAKEINTRESOURCE(32518)
  IDI_WARNING* = IDI_EXCLAMATION
  IDI_ERROR* = IDI_HAND
  IDI_INFORMATION* = IDI_ASTERISK
  IDOK* = 1
  IDCANCEL* = 2
  IDABORT* = 3
  IDRETRY* = 4
  IDIGNORE* = 5
  IDYES* = 6
  IDNO* = 7
  IDCLOSE* = 8
  IDHELP* = 9
  IDTRYAGAIN* = 10
  IDCONTINUE* = 11
  IDTIMEOUT* = 32000
  ES_LEFT* = 0x0000
  ES_CENTER* = 0x0001
  ES_RIGHT* = 0x0002
  ES_MULTILINE* = 0x0004
  ES_UPPERCASE* = 0x0008
  ES_LOWERCASE* = 0x0010
  ES_PASSWORD* = 0x0020
  ES_AUTOVSCROLL* = 0x0040
  ES_AUTOHSCROLL* = 0x0080
  ES_NOHIDESEL* = 0x0100
  ES_OEMCONVERT* = 0x0400
  ES_READONLY* = 0x0800
  ES_WANTRETURN* = 0x1000
  ES_NUMBER* = 0x2000
  EN_SETFOCUS* = 0x0100
  EN_KILLFOCUS* = 0x0200
  EN_CHANGE* = 0x0300
  EN_UPDATE* = 0x0400
  EN_ERRSPACE* = 0x0500
  EN_MAXTEXT* = 0x0501
  EN_HSCROLL* = 0x0601
  EN_VSCROLL* = 0x0602
  EN_ALIGN_LTR_EC* = 0x0700
  EN_ALIGN_RTL_EC* = 0x0701
  EC_LEFTMARGIN* = 0x0001
  EC_RIGHTMARGIN* = 0x0002
  EC_USEFONTINFO* = 0xffff
  EMSIS_COMPOSITIONSTRING* = 0x0001
  EIMES_GETCOMPSTRATONCE* = 0x0001
  EIMES_CANCELCOMPSTRINFOCUS* = 0x0002
  EIMES_COMPLETECOMPSTRKILLFOCUS* = 0x0004
  EM_GETSEL* = 0x00B0
  EM_SETSEL* = 0x00B1
  EM_GETRECT* = 0x00B2
  EM_SETRECT* = 0x00B3
  EM_SETRECTNP* = 0x00B4
  EM_SCROLL* = 0x00B5
  EM_LINESCROLL* = 0x00B6
  EM_SCROLLCARET* = 0x00B7
  EM_GETMODIFY* = 0x00B8
  EM_SETMODIFY* = 0x00B9
  EM_GETLINECOUNT* = 0x00BA
  EM_LINEINDEX* = 0x00BB
  EM_SETHANDLE* = 0x00BC
  EM_GETHANDLE* = 0x00BD
  EM_GETTHUMB* = 0x00BE
  EM_LINELENGTH* = 0x00C1
  EM_REPLACESEL* = 0x00C2
  EM_GETLINE* = 0x00C4
  EM_LIMITTEXT* = 0x00C5
  EM_CANUNDO* = 0x00C6
  EM_UNDO* = 0x00C7
  EM_FMTLINES* = 0x00C8
  EM_LINEFROMCHAR* = 0x00C9
  EM_SETTABSTOPS* = 0x00CB
  EM_SETPASSWORDCHAR* = 0x00CC
  EM_EMPTYUNDOBUFFER* = 0x00CD
  EM_GETFIRSTVISIBLELINE* = 0x00CE
  EM_SETREADONLY* = 0x00CF
  EM_SETWORDBREAKPROC* = 0x00D0
  EM_GETWORDBREAKPROC* = 0x00D1
  EM_GETPASSWORDCHAR* = 0x00D2
  EM_SETMARGINS* = 0x00D3
  EM_GETMARGINS* = 0x00D4
  EM_SETLIMITTEXT* = EM_LIMITTEXT
  EM_GETLIMITTEXT* = 0x00D5
  EM_POSFROMCHAR* = 0x00D6
  EM_CHARFROMPOS* = 0x00D7
  EM_SETIMESTATUS* = 0x00D8
  EM_GETIMESTATUS* = 0x00D9
  WB_LEFT* = 0
  WB_RIGHT* = 1
  WB_ISDELIMITER* = 2
  BS_PUSHBUTTON* = 0x00000000
  BS_DEFPUSHBUTTON* = 0x00000001
  BS_CHECKBOX* = 0x00000002
  BS_AUTOCHECKBOX* = 0x00000003
  BS_RADIOBUTTON* = 0x00000004
  BS_3STATE* = 0x00000005
  BS_AUTO3STATE* = 0x00000006
  BS_GROUPBOX* = 0x00000007
  BS_USERBUTTON* = 0x00000008
  BS_AUTORADIOBUTTON* = 0x00000009
  BS_PUSHBOX* = 0x0000000A
  BS_OWNERDRAW* = 0x0000000B
  BS_TYPEMASK* = 0x0000000F
  BS_LEFTTEXT* = 0x00000020
  BS_TEXT* = 0x00000000
  BS_ICON* = 0x00000040
  BS_BITMAP* = 0x00000080
  BS_LEFT* = 0x00000100
  BS_RIGHT* = 0x00000200
  BS_CENTER* = 0x00000300
  BS_TOP* = 0x00000400
  BS_BOTTOM* = 0x00000800
  BS_VCENTER* = 0x00000C00
  BS_PUSHLIKE* = 0x00001000
  BS_MULTILINE* = 0x00002000
  BS_NOTIFY* = 0x00004000
  BS_FLAT* = 0x00008000
  BS_RIGHTBUTTON* = BS_LEFTTEXT
  BN_CLICKED* = 0
  BN_PAINT* = 1
  BN_HILITE* = 2
  BN_UNHILITE* = 3
  BN_DISABLE* = 4
  BN_DOUBLECLICKED* = 5
  BN_PUSHED* = BN_HILITE
  BN_UNPUSHED* = BN_UNHILITE
  BN_DBLCLK* = BN_DOUBLECLICKED
  BN_SETFOCUS* = 6
  BN_KILLFOCUS* = 7
  BM_GETCHECK* = 0x00F0
  BM_SETCHECK* = 0x00F1
  BM_GETSTATE* = 0x00F2
  BM_SETSTATE* = 0x00F3
  BM_SETSTYLE* = 0x00F4
  BM_CLICK* = 0x00F5
  BM_GETIMAGE* = 0x00F6
  BM_SETIMAGE* = 0x00F7
  BM_SETDONTCLICK* = 0x00f8
  BST_UNCHECKED* = 0x0000
  BST_CHECKED* = 0x0001
  BST_INDETERMINATE* = 0x0002
  BST_PUSHED* = 0x0004
  BST_FOCUS* = 0x0008
  SS_LEFT* = 0x00000000
  SS_CENTER* = 0x00000001
  SS_RIGHT* = 0x00000002
  SS_ICON* = 0x00000003
  SS_BLACKRECT* = 0x00000004
  SS_GRAYRECT* = 0x00000005
  SS_WHITERECT* = 0x00000006
  SS_BLACKFRAME* = 0x00000007
  SS_GRAYFRAME* = 0x00000008
  SS_WHITEFRAME* = 0x00000009
  SS_USERITEM* = 0x0000000A
  SS_SIMPLE* = 0x0000000B
  SS_LEFTNOWORDWRAP* = 0x0000000C
  SS_OWNERDRAW* = 0x0000000D
  SS_BITMAP* = 0x0000000E
  SS_ENHMETAFILE* = 0x0000000F
  SS_ETCHEDHORZ* = 0x00000010
  SS_ETCHEDVERT* = 0x00000011
  SS_ETCHEDFRAME* = 0x00000012
  SS_TYPEMASK* = 0x0000001F
  SS_REALSIZECONTROL* = 0x00000040
  SS_NOPREFIX* = 0x00000080
  SS_NOTIFY* = 0x00000100
  SS_CENTERIMAGE* = 0x00000200
  SS_RIGHTJUST* = 0x00000400
  SS_REALSIZEIMAGE* = 0x00000800
  SS_SUNKEN* = 0x00001000
  SS_EDITCONTROL* = 0x00002000
  SS_ENDELLIPSIS* = 0x00004000
  SS_PATHELLIPSIS* = 0x00008000
  SS_WORDELLIPSIS* = 0x0000C000
  SS_ELLIPSISMASK* = 0x0000C000
  STM_SETICON* = 0x0170
  STM_GETICON* = 0x0171
  STM_SETIMAGE* = 0x0172
  STM_GETIMAGE* = 0x0173
  STN_CLICKED* = 0
  STN_DBLCLK* = 1
  STN_ENABLE* = 2
  STN_DISABLE* = 3
  STM_MSGMAX* = 0x0174
  WC_DIALOG* = MAKEINTATOM(0x8002)
  DWL_MSGRESULT* = 0
  DWL_DLGPROC* = 4
  DWL_USER* = 8
  DWLP_MSGRESULT* = 0
  DWLP_DLGPROC* = DWLP_MSGRESULT+sizeof(LRESULT)
type
  DLGPROC* = proc (P1: HWND, P2: UINT, P3: WPARAM, P4: LPARAM): INT_PTR {.stdcall.}
const
  DWLP_USER* = DWLP_DLGPROC+sizeof(DLGPROC)
  DDL_READWRITE* = 0x0000
  DDL_READONLY* = 0x0001
  DDL_HIDDEN* = 0x0002
  DDL_SYSTEM* = 0x0004
  DDL_DIRECTORY* = 0x0010
  DDL_ARCHIVE* = 0x0020
  DDL_POSTMSGS* = 0x2000
  DDL_DRIVES* = 0x4000
  DDL_EXCLUSIVE* = 0x8000
  DS_ABSALIGN* = 0x01
  DS_SYSMODAL* = 0x02
  DS_LOCALEDIT* = 0x20
  DS_SETFONT* = 0x40
  DS_MODALFRAME* = 0x80
  DS_NOIDLEMSG* = 0x100
  DS_SETFOREGROUND* = 0x200
  DS_3DLOOK* = 0x0004
  DS_FIXEDSYS* = 0x0008
  DS_NOFAILCREATE* = 0x0010
  DS_CONTROL* = 0x0400
  DS_CENTER* = 0x0800
  DS_CENTERMOUSE* = 0x1000
  DS_CONTEXTHELP* = 0x2000
  DS_SHELLFONT* = DS_SETFONT or DS_FIXEDSYS
  DS_USEPIXELS* = 0x8000
  DM_GETDEFID* = WM_USER+0
  DM_SETDEFID* = WM_USER+1
  DM_REPOSITION* = WM_USER+2
  DC_HASDEFID* = 0x534B
  DLGC_WANTARROWS* = 0x0001
  DLGC_WANTTAB* = 0x0002
  DLGC_WANTALLKEYS* = 0x0004
  DLGC_WANTMESSAGE* = 0x0004
  DLGC_HASSETSEL* = 0x0008
  DLGC_DEFPUSHBUTTON* = 0x0010
  DLGC_UNDEFPUSHBUTTON* = 0x0020
  DLGC_RADIOBUTTON* = 0x0040
  DLGC_WANTCHARS* = 0x0080
  DLGC_STATIC* = 0x0100
  DLGC_BUTTON* = 0x2000
  LB_CTLCODE* = 0
  LB_OKAY* = 0
  LB_ERR* = -1
  LB_ERRSPACE* = -2
  LBN_ERRSPACE* = -2
  LBN_SELCHANGE* = 1
  LBN_DBLCLK* = 2
  LBN_SELCANCEL* = 3
  LBN_SETFOCUS* = 4
  LBN_KILLFOCUS* = 5
  LB_ADDSTRING* = 0x0180
  LB_INSERTSTRING* = 0x0181
  LB_DELETESTRING* = 0x0182
  LB_SELITEMRANGEEX* = 0x0183
  LB_RESETCONTENT* = 0x0184
  LB_SETSEL* = 0x0185
  LB_SETCURSEL* = 0x0186
  LB_GETSEL* = 0x0187
  LB_GETCURSEL* = 0x0188
  LB_GETTEXT* = 0x0189
  LB_GETTEXTLEN* = 0x018A
  LB_GETCOUNT* = 0x018B
  LB_SELECTSTRING* = 0x018C
  LB_DIR* = 0x018D
  LB_GETTOPINDEX* = 0x018E
  LB_FINDSTRING* = 0x018F
  LB_GETSELCOUNT* = 0x0190
  LB_GETSELITEMS* = 0x0191
  LB_SETTABSTOPS* = 0x0192
  LB_GETHORIZONTALEXTENT* = 0x0193
  LB_SETHORIZONTALEXTENT* = 0x0194
  LB_SETCOLUMNWIDTH* = 0x0195
  LB_ADDFILE* = 0x0196
  LB_SETTOPINDEX* = 0x0197
  LB_GETITEMRECT* = 0x0198
  LB_GETITEMDATA* = 0x0199
  LB_SETITEMDATA* = 0x019A
  LB_SELITEMRANGE* = 0x019B
  LB_SETANCHORINDEX* = 0x019C
  LB_GETANCHORINDEX* = 0x019D
  LB_SETCARETINDEX* = 0x019E
  LB_GETCARETINDEX* = 0x019F
  LB_SETITEMHEIGHT* = 0x01A0
  LB_GETITEMHEIGHT* = 0x01A1
  LB_FINDSTRINGEXACT* = 0x01A2
  LB_SETLOCALE* = 0x01A5
  LB_GETLOCALE* = 0x01A6
  LB_SETCOUNT* = 0x01A7
  LB_INITSTORAGE* = 0x01A8
  LB_ITEMFROMPOINT* = 0x01A9
  LB_MULTIPLEADDSTRING* = 0x01B1
  LB_GETLISTBOXINFO* = 0x01B2
  LB_MSGMAX* = 0x01B3
  LBS_NOTIFY* = 0x0001
  LBS_SORT* = 0x0002
  LBS_NOREDRAW* = 0x0004
  LBS_MULTIPLESEL* = 0x0008
  LBS_OWNERDRAWFIXED* = 0x0010
  LBS_OWNERDRAWVARIABLE* = 0x0020
  LBS_HASSTRINGS* = 0x0040
  LBS_USETABSTOPS* = 0x0080
  LBS_NOINTEGRALHEIGHT* = 0x0100
  LBS_MULTICOLUMN* = 0x0200
  LBS_WANTKEYBOARDINPUT* = 0x0400
  LBS_EXTENDEDSEL* = 0x0800
  LBS_DISABLENOSCROLL* = 0x1000
  LBS_NODATA* = 0x2000
  LBS_NOSEL* = 0x4000
  LBS_COMBOBOX* = 0x8000
  LBS_STANDARD* = LBS_NOTIFY or LBS_SORT or WS_VSCROLL or WS_BORDER
  CB_OKAY* = 0
  CB_ERR* = -1
  CB_ERRSPACE* = -2
  CBN_ERRSPACE* = -1
  CBN_SELCHANGE* = 1
  CBN_DBLCLK* = 2
  CBN_SETFOCUS* = 3
  CBN_KILLFOCUS* = 4
  CBN_EDITCHANGE* = 5
  CBN_EDITUPDATE* = 6
  CBN_DROPDOWN* = 7
  CBN_CLOSEUP* = 8
  CBN_SELENDOK* = 9
  CBN_SELENDCANCEL* = 10
  CBS_SIMPLE* = 0x0001
  CBS_DROPDOWN* = 0x0002
  CBS_DROPDOWNLIST* = 0x0003
  CBS_OWNERDRAWFIXED* = 0x0010
  CBS_OWNERDRAWVARIABLE* = 0x0020
  CBS_AUTOHSCROLL* = 0x0040
  CBS_OEMCONVERT* = 0x0080
  CBS_SORT* = 0x0100
  CBS_HASSTRINGS* = 0x0200
  CBS_NOINTEGRALHEIGHT* = 0x0400
  CBS_DISABLENOSCROLL* = 0x0800
  CBS_UPPERCASE* = 0x2000
  CBS_LOWERCASE* = 0x4000
  CB_GETEDITSEL* = 0x0140
  CB_LIMITTEXT* = 0x0141
  CB_SETEDITSEL* = 0x0142
  CB_ADDSTRING* = 0x0143
  CB_DELETESTRING* = 0x0144
  CB_DIR* = 0x0145
  CB_GETCOUNT* = 0x0146
  CB_GETCURSEL* = 0x0147
  CB_GETLBTEXT* = 0x0148
  CB_GETLBTEXTLEN* = 0x0149
  CB_INSERTSTRING* = 0x014A
  CB_RESETCONTENT* = 0x014B
  CB_FINDSTRING* = 0x014C
  CB_SELECTSTRING* = 0x014D
  CB_SETCURSEL* = 0x014E
  CB_SHOWDROPDOWN* = 0x014F
  CB_GETITEMDATA* = 0x0150
  CB_SETITEMDATA* = 0x0151
  CB_GETDROPPEDCONTROLRECT* = 0x0152
  CB_SETITEMHEIGHT* = 0x0153
  CB_GETITEMHEIGHT* = 0x0154
  CB_SETEXTENDEDUI* = 0x0155
  CB_GETEXTENDEDUI* = 0x0156
  CB_GETDROPPEDSTATE* = 0x0157
  CB_FINDSTRINGEXACT* = 0x0158
  CB_SETLOCALE* = 0x0159
  CB_GETLOCALE* = 0x015A
  CB_GETTOPINDEX* = 0x015b
  CB_SETTOPINDEX* = 0x015c
  CB_GETHORIZONTALEXTENT* = 0x015d
  CB_SETHORIZONTALEXTENT* = 0x015e
  CB_GETDROPPEDWIDTH* = 0x015f
  CB_SETDROPPEDWIDTH* = 0x0160
  CB_INITSTORAGE* = 0x0161
  CB_MULTIPLEADDSTRING* = 0x0163
  CB_GETCOMBOBOXINFO* = 0x0164
  CB_MSGMAX* = 0x0165
  SBS_HORZ* = 0x0000
  SBS_VERT* = 0x0001
  SBS_TOPALIGN* = 0x0002
  SBS_LEFTALIGN* = 0x0002
  SBS_BOTTOMALIGN* = 0x0004
  SBS_RIGHTALIGN* = 0x0004
  SBS_SIZEBOXTOPLEFTALIGN* = 0x0002
  SBS_SIZEBOXBOTTOMRIGHTALIGN* = 0x0004
  SBS_SIZEBOX* = 0x0008
  SBS_SIZEGRIP* = 0x0010
  SBM_SETPOS* = 0x00E0
  SBM_GETPOS* = 0x00E1
  SBM_SETRANGE* = 0x00E2
  SBM_SETRANGEREDRAW* = 0x00E6
  SBM_GETRANGE* = 0x00E3
  SBM_ENABLE_ARROWS* = 0x00E4
  SBM_SETSCROLLINFO* = 0x00E9
  SBM_GETSCROLLINFO* = 0x00EA
  SBM_GETSCROLLBARINFO* = 0x00EB
  SIF_RANGE* = 0x0001
  SIF_PAGE* = 0x0002
  SIF_POS* = 0x0004
  SIF_DISABLENOSCROLL* = 0x0008
  SIF_TRACKPOS* = 0x0010
  SIF_ALL* = SIF_RANGE or SIF_PAGE or SIF_POS or SIF_TRACKPOS
  MDIS_ALLCHILDSTYLES* = 0x0001
  MDITILE_VERTICAL* = 0x0000
  MDITILE_HORIZONTAL* = 0x0001
  MDITILE_SKIPDISABLED* = 0x0002
  MDITILE_ZORDER* = 0x0004
  HELP_CONTEXT* = 0x0001
  HELP_QUIT* = 0x0002
  HELP_INDEX* = 0x0003
  HELP_CONTENTS* = 0x0003
  HELP_HELPONHELP* = 0x0004
  HELP_SETINDEX* = 0x0005
  HELP_SETCONTENTS* = 0x0005
  HELP_CONTEXTPOPUP* = 0x0008
  HELP_FORCEFILE* = 0x0009
  HELP_KEY* = 0x0101
  HELP_COMMAND* = 0x0102
  HELP_PARTIALKEY* = 0x0105
  HELP_MULTIKEY* = 0x0201
  HELP_SETWINPOS* = 0x0203
  HELP_CONTEXTMENU* = 0x000a
  HELP_FINDER* = 0x000b
  HELP_WM_HELP* = 0x000c
  HELP_SETPOPUP_POS* = 0x000d
  HELP_TCARD* = 0x8000
  HELP_TCARD_DATA* = 0x0010
  HELP_TCARD_OTHER_CALLER* = 0x0011
  IDH_NO_HELP* = 28440
  IDH_MISSING_CONTEXT* = 28441
  IDH_GENERIC_HELP_BUTTON* = 28442
  IDH_OK* = 28443
  IDH_CANCEL* = 28444
  IDH_HELP* = 28445
  GR_GDIOBJECTS* = 0
  GR_USEROBJECTS* = 1
  GR_GDIOBJECTS_PEAK* = 2
  GR_USEROBJECTS_PEAK* = 4
  GR_GLOBAL* = HANDLE(-2)
  SPI_GETBEEP* = 0x0001
  SPI_SETBEEP* = 0x0002
  SPI_GETMOUSE* = 0x0003
  SPI_SETMOUSE* = 0x0004
  SPI_GETBORDER* = 0x0005
  SPI_SETBORDER* = 0x0006
  SPI_GETKEYBOARDSPEED* = 0x000A
  SPI_SETKEYBOARDSPEED* = 0x000B
  SPI_LANGDRIVER* = 0x000C
  SPI_ICONHORIZONTALSPACING* = 0x000D
  SPI_GETSCREENSAVETIMEOUT* = 0x000E
  SPI_SETSCREENSAVETIMEOUT* = 0x000F
  SPI_GETSCREENSAVEACTIVE* = 0x0010
  SPI_SETSCREENSAVEACTIVE* = 0x0011
  SPI_GETGRIDGRANULARITY* = 0x0012
  SPI_SETGRIDGRANULARITY* = 0x0013
  SPI_SETDESKWALLPAPER* = 0x0014
  SPI_SETDESKPATTERN* = 0x0015
  SPI_GETKEYBOARDDELAY* = 0x0016
  SPI_SETKEYBOARDDELAY* = 0x0017
  SPI_ICONVERTICALSPACING* = 0x0018
  SPI_GETICONTITLEWRAP* = 0x0019
  SPI_SETICONTITLEWRAP* = 0x001A
  SPI_GETMENUDROPALIGNMENT* = 0x001B
  SPI_SETMENUDROPALIGNMENT* = 0x001C
  SPI_SETDOUBLECLKWIDTH* = 0x001D
  SPI_SETDOUBLECLKHEIGHT* = 0x001E
  SPI_GETICONTITLELOGFONT* = 0x001F
  SPI_SETDOUBLECLICKTIME* = 0x0020
  SPI_SETMOUSEBUTTONSWAP* = 0x0021
  SPI_SETICONTITLELOGFONT* = 0x0022
  SPI_GETFASTTASKSWITCH* = 0x0023
  SPI_SETFASTTASKSWITCH* = 0x0024
  SPI_SETDRAGFULLWINDOWS* = 0x0025
  SPI_GETDRAGFULLWINDOWS* = 0x0026
  SPI_GETNONCLIENTMETRICS* = 0x0029
  SPI_SETNONCLIENTMETRICS* = 0x002A
  SPI_GETMINIMIZEDMETRICS* = 0x002B
  SPI_SETMINIMIZEDMETRICS* = 0x002C
  SPI_GETICONMETRICS* = 0x002D
  SPI_SETICONMETRICS* = 0x002E
  SPI_SETWORKAREA* = 0x002F
  SPI_GETWORKAREA* = 0x0030
  SPI_SETPENWINDOWS* = 0x0031
  SPI_GETHIGHCONTRAST* = 0x0042
  SPI_SETHIGHCONTRAST* = 0x0043
  SPI_GETKEYBOARDPREF* = 0x0044
  SPI_SETKEYBOARDPREF* = 0x0045
  SPI_GETSCREENREADER* = 0x0046
  SPI_SETSCREENREADER* = 0x0047
  SPI_GETANIMATION* = 0x0048
  SPI_SETANIMATION* = 0x0049
  SPI_GETFONTSMOOTHING* = 0x004A
  SPI_SETFONTSMOOTHING* = 0x004B
  SPI_SETDRAGWIDTH* = 0x004C
  SPI_SETDRAGHEIGHT* = 0x004D
  SPI_SETHANDHELD* = 0x004E
  SPI_GETLOWPOWERTIMEOUT* = 0x004F
  SPI_GETPOWEROFFTIMEOUT* = 0x0050
  SPI_SETLOWPOWERTIMEOUT* = 0x0051
  SPI_SETPOWEROFFTIMEOUT* = 0x0052
  SPI_GETLOWPOWERACTIVE* = 0x0053
  SPI_GETPOWEROFFACTIVE* = 0x0054
  SPI_SETLOWPOWERACTIVE* = 0x0055
  SPI_SETPOWEROFFACTIVE* = 0x0056
  SPI_SETCURSORS* = 0x0057
  SPI_SETICONS* = 0x0058
  SPI_GETDEFAULTINPUTLANG* = 0x0059
  SPI_SETDEFAULTINPUTLANG* = 0x005A
  SPI_SETLANGTOGGLE* = 0x005B
  SPI_GETWINDOWSEXTENSION* = 0x005C
  SPI_SETMOUSETRAILS* = 0x005D
  SPI_GETMOUSETRAILS* = 0x005E
  SPI_SETSCREENSAVERRUNNING* = 0x0061
  SPI_SCREENSAVERRUNNING* = SPI_SETSCREENSAVERRUNNING
  SPI_GETFILTERKEYS* = 0x0032
  SPI_SETFILTERKEYS* = 0x0033
  SPI_GETTOGGLEKEYS* = 0x0034
  SPI_SETTOGGLEKEYS* = 0x0035
  SPI_GETMOUSEKEYS* = 0x0036
  SPI_SETMOUSEKEYS* = 0x0037
  SPI_GETSHOWSOUNDS* = 0x0038
  SPI_SETSHOWSOUNDS* = 0x0039
  SPI_GETSTICKYKEYS* = 0x003A
  SPI_SETSTICKYKEYS* = 0x003B
  SPI_GETACCESSTIMEOUT* = 0x003C
  SPI_SETACCESSTIMEOUT* = 0x003D
  SPI_GETSERIALKEYS* = 0x003E
  SPI_SETSERIALKEYS* = 0x003F
  SPI_GETSOUNDSENTRY* = 0x0040
  SPI_SETSOUNDSENTRY* = 0x0041
  SPI_GETSNAPTODEFBUTTON* = 0x005F
  SPI_SETSNAPTODEFBUTTON* = 0x0060
  SPI_GETMOUSEHOVERWIDTH* = 0x0062
  SPI_SETMOUSEHOVERWIDTH* = 0x0063
  SPI_GETMOUSEHOVERHEIGHT* = 0x0064
  SPI_SETMOUSEHOVERHEIGHT* = 0x0065
  SPI_GETMOUSEHOVERTIME* = 0x0066
  SPI_SETMOUSEHOVERTIME* = 0x0067
  SPI_GETWHEELSCROLLLINES* = 0x0068
  SPI_SETWHEELSCROLLLINES* = 0x0069
  SPI_GETMENUSHOWDELAY* = 0x006A
  SPI_SETMENUSHOWDELAY* = 0x006B
  SPI_GETWHEELSCROLLCHARS* = 0x006C
  SPI_SETWHEELSCROLLCHARS* = 0x006D
  SPI_GETSHOWIMEUI* = 0x006E
  SPI_SETSHOWIMEUI* = 0x006F
  SPI_GETMOUSESPEED* = 0x0070
  SPI_SETMOUSESPEED* = 0x0071
  SPI_GETSCREENSAVERRUNNING* = 0x0072
  SPI_GETDESKWALLPAPER* = 0x0073
  SPI_GETAUDIODESCRIPTION* = 0x0074
  SPI_SETAUDIODESCRIPTION* = 0x0075
  SPI_GETSCREENSAVESECURE* = 0x0076
  SPI_SETSCREENSAVESECURE* = 0x0077
  SPI_GETHUNGAPPTIMEOUT* = 0x0078
  SPI_SETHUNGAPPTIMEOUT* = 0x0079
  SPI_GETWAITTOKILLTIMEOUT* = 0x007a
  SPI_SETWAITTOKILLTIMEOUT* = 0x007b
  SPI_GETWAITTOKILLSERVICETIMEOUT* = 0x007c
  SPI_SETWAITTOKILLSERVICETIMEOUT* = 0x007d
  SPI_GETMOUSEDOCKTHRESHOLD* = 0x007e
  SPI_SETMOUSEDOCKTHRESHOLD* = 0x007f
  SPI_GETPENDOCKTHRESHOLD* = 0x0080
  SPI_SETPENDOCKTHRESHOLD* = 0x0081
  SPI_GETWINARRANGING* = 0x0082
  SPI_SETWINARRANGING* = 0x0083
  SPI_GETMOUSEDRAGOUTTHRESHOLD* = 0x0084
  SPI_SETMOUSEDRAGOUTTHRESHOLD* = 0x0085
  SPI_GETPENDRAGOUTTHRESHOLD* = 0x0086
  SPI_SETPENDRAGOUTTHRESHOLD* = 0x0087
  SPI_GETMOUSESIDEMOVETHRESHOLD* = 0x0088
  SPI_SETMOUSESIDEMOVETHRESHOLD* = 0x0089
  SPI_GETPENSIDEMOVETHRESHOLD* = 0x008a
  SPI_SETPENSIDEMOVETHRESHOLD* = 0x008b
  SPI_GETDRAGFROMMAXIMIZE* = 0x008c
  SPI_SETDRAGFROMMAXIMIZE* = 0x008d
  SPI_GETSNAPSIZING* = 0x008e
  SPI_SETSNAPSIZING* = 0x008f
  SPI_GETDOCKMOVING* = 0x0090
  SPI_SETDOCKMOVING* = 0x0091
  SPI_GETTOUCHPREDICTIONPARAMETERS* = 0x009c
  SPI_SETTOUCHPREDICTIONPARAMETERS* = 0x009d
  SPI_GETLOGICALDPIOVERRIDE* = 0x009e
  SPI_SETLOGICALDPIOVERRIDE* = 0x009f
  SPI_GETMOUSECORNERCLIPLENGTH* = 0x00a0
  SPI_SETMOUSECORNERCLIPLENGTH* = 0x00a1
  SPI_GETMENURECT* = 0x00a2
  SPI_SETMENURECT* = 0x00a3
  SPI_GETACTIVEWINDOWTRACKING* = 0x1000
  SPI_SETACTIVEWINDOWTRACKING* = 0x1001
  SPI_GETMENUANIMATION* = 0x1002
  SPI_SETMENUANIMATION* = 0x1003
  SPI_GETCOMBOBOXANIMATION* = 0x1004
  SPI_SETCOMBOBOXANIMATION* = 0x1005
  SPI_GETLISTBOXSMOOTHSCROLLING* = 0x1006
  SPI_SETLISTBOXSMOOTHSCROLLING* = 0x1007
  SPI_GETGRADIENTCAPTIONS* = 0x1008
  SPI_SETGRADIENTCAPTIONS* = 0x1009
  SPI_GETKEYBOARDCUES* = 0x100A
  SPI_SETKEYBOARDCUES* = 0x100B
  SPI_GETMENUUNDERLINES* = SPI_GETKEYBOARDCUES
  SPI_SETMENUUNDERLINES* = SPI_SETKEYBOARDCUES
  SPI_GETACTIVEWNDTRKZORDER* = 0x100C
  SPI_SETACTIVEWNDTRKZORDER* = 0x100D
  SPI_GETHOTTRACKING* = 0x100E
  SPI_SETHOTTRACKING* = 0x100F
  SPI_GETMENUFADE* = 0x1012
  SPI_SETMENUFADE* = 0x1013
  SPI_GETSELECTIONFADE* = 0x1014
  SPI_SETSELECTIONFADE* = 0x1015
  SPI_GETTOOLTIPANIMATION* = 0x1016
  SPI_SETTOOLTIPANIMATION* = 0x1017
  SPI_GETTOOLTIPFADE* = 0x1018
  SPI_SETTOOLTIPFADE* = 0x1019
  SPI_GETCURSORSHADOW* = 0x101A
  SPI_SETCURSORSHADOW* = 0x101B
  SPI_GETMOUSESONAR* = 0x101C
  SPI_SETMOUSESONAR* = 0x101D
  SPI_GETMOUSECLICKLOCK* = 0x101E
  SPI_SETMOUSECLICKLOCK* = 0x101F
  SPI_GETMOUSEVANISH* = 0x1020
  SPI_SETMOUSEVANISH* = 0x1021
  SPI_GETFLATMENU* = 0x1022
  SPI_SETFLATMENU* = 0x1023
  SPI_GETDROPSHADOW* = 0x1024
  SPI_SETDROPSHADOW* = 0x1025
  SPI_GETBLOCKSENDINPUTRESETS* = 0x1026
  SPI_SETBLOCKSENDINPUTRESETS* = 0x1027
  SPI_GETUIEFFECTS* = 0x103E
  SPI_SETUIEFFECTS* = 0x103F
  SPI_GETDISABLEOVERLAPPEDCONTENT* = 0x1040
  SPI_SETDISABLEOVERLAPPEDCONTENT* = 0x1041
  SPI_GETCLIENTAREAANIMATION* = 0x1042
  SPI_SETCLIENTAREAANIMATION* = 0x1043
  SPI_GETCLEARTYPE* = 0x1048
  SPI_SETCLEARTYPE* = 0x1049
  SPI_GETSPEECHRECOGNITION* = 0x104a
  SPI_SETSPEECHRECOGNITION* = 0x104b
  SPI_GETCARETBROWSING* = 0x104c
  SPI_SETCARETBROWSING* = 0x104d
  SPI_GETTHREADLOCALINPUTSETTINGS* = 0x104e
  SPI_SETTHREADLOCALINPUTSETTINGS* = 0x104f
  SPI_GETSYSTEMLANGUAGEBAR* = 0x1050
  SPI_SETSYSTEMLANGUAGEBAR* = 0x1051
  SPI_GETFOREGROUNDLOCKTIMEOUT* = 0x2000
  SPI_SETFOREGROUNDLOCKTIMEOUT* = 0x2001
  SPI_GETACTIVEWNDTRKTIMEOUT* = 0x2002
  SPI_SETACTIVEWNDTRKTIMEOUT* = 0x2003
  SPI_GETFOREGROUNDFLASHCOUNT* = 0x2004
  SPI_SETFOREGROUNDFLASHCOUNT* = 0x2005
  SPI_GETCARETWIDTH* = 0x2006
  SPI_SETCARETWIDTH* = 0x2007
  SPI_GETMOUSECLICKLOCKTIME* = 0x2008
  SPI_SETMOUSECLICKLOCKTIME* = 0x2009
  SPI_GETFONTSMOOTHINGTYPE* = 0x200A
  SPI_SETFONTSMOOTHINGTYPE* = 0x200B
  FE_FONTSMOOTHINGSTANDARD* = 0x0001
  FE_FONTSMOOTHINGCLEARTYPE* = 0x0002
  FE_FONTSMOOTHINGDOCKING* = 0x8000
  SPI_GETFONTSMOOTHINGCONTRAST* = 0x200C
  SPI_SETFONTSMOOTHINGCONTRAST* = 0x200D
  SPI_GETFOCUSBORDERWIDTH* = 0x200E
  SPI_SETFOCUSBORDERWIDTH* = 0x200F
  SPI_GETFOCUSBORDERHEIGHT* = 0x2010
  SPI_SETFOCUSBORDERHEIGHT* = 0x2011
  SPI_GETFONTSMOOTHINGORIENTATION* = 0x2012
  SPI_SETFONTSMOOTHINGORIENTATION* = 0x2013
  SPI_GETMINIMUMHITRADIUS* = 0x2014
  SPI_SETMINIMUMHITRADIUS* = 0x2015
  SPI_GETMESSAGEDURATION* = 0x2016
  SPI_SETMESSAGEDURATION* = 0x2017
  SPI_GETCONTACTVISUALIZATION* = 0x2018
  SPI_SETCONTACTVISUALIZATION* = 0x2019
  SPI_GETGESTUREVISUALIZATION* = 0x201a
  SPI_SETGESTUREVISUALIZATION* = 0x201b
  CONTACTVISUALIZATION_OFF* = 0x0000
  CONTACTVISUALIZATION_ON* = 0x0001
  CONTACTVISUALIZATION_PRESENTATIONMODE* = 0x0002
  GESTUREVISUALIZATION_OFF* = 0x0000
  GESTUREVISUALIZATION_ON* = 0x001f
  GESTUREVISUALIZATION_TAP* = 0x0001
  GESTUREVISUALIZATION_DOUBLETAP* = 0x0002
  GESTUREVISUALIZATION_PRESSANDTAP* = 0x0004
  GESTUREVISUALIZATION_PRESSANDHOLD* = 0x0008
  GESTUREVISUALIZATION_RIGHTTAP* = 0x0010
  MAX_TOUCH_PREDICTION_FILTER_TAPS* = 3
  TOUCHPREDICTIONPARAMETERS_DEFAULT_LATENCY* = 8
  TOUCHPREDICTIONPARAMETERS_DEFAULT_SAMPLETIME* = 8
  TOUCHPREDICTIONPARAMETERS_DEFAULT_USE_HW_TIMESTAMP* = 1
  TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_DELTA* = 0.001f
  TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_MIN* = 0.9f
  TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_MAX* = 0.999f
  TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_LEARNING_RATE* = 0.001f
  TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_EXPO_SMOOTH_ALPHA* = 0.99f
  MAX_LOGICALDPIOVERRIDE* = 2
  MIN_LOGICALDPIOVERRIDE* = -2
  FE_FONTSMOOTHINGORIENTATIONBGR* = 0x0000
  FE_FONTSMOOTHINGORIENTATIONRGB* = 0x0001
  SPIF_UPDATEINIFILE* = 0x0001
  SPIF_SENDWININICHANGE* = 0x0002
  SPIF_SENDCHANGE* = SPIF_SENDWININICHANGE
  METRICS_USEDEFAULT* = -1
  ARW_BOTTOMLEFT* = 0x0000
  ARW_BOTTOMRIGHT* = 0x0001
  ARW_TOPLEFT* = 0x0002
  ARW_TOPRIGHT* = 0x0003
  ARW_STARTMASK* = 0x0003
  ARW_STARTRIGHT* = 0x0001
  ARW_STARTTOP* = 0x0002
  ARW_LEFT* = 0x0000
  ARW_RIGHT* = 0x0000
  ARW_UP* = 0x0004
  ARW_DOWN* = 0x0004
  ARW_HIDE* = 0x0008
  SERKF_SERIALKEYSON* = 0x00000001
  SERKF_AVAILABLE* = 0x00000002
  SERKF_INDICATOR* = 0x00000004
  HCF_HIGHCONTRASTON* = 0x00000001
  HCF_AVAILABLE* = 0x00000002
  HCF_HOTKEYACTIVE* = 0x00000004
  HCF_CONFIRMHOTKEY* = 0x00000008
  HCF_HOTKEYSOUND* = 0x00000010
  HCF_INDICATOR* = 0x00000020
  HCF_HOTKEYAVAILABLE* = 0x00000040
  HCF_LOGONDESKTOP* = 0x00000100
  HCF_DEFAULTDESKTOP* = 0x00000200
  CDS_UPDATEREGISTRY* = 0x00000001
  CDS_TEST* = 0x00000002
  CDS_FULLSCREEN* = 0x00000004
  CDS_GLOBAL* = 0x00000008
  CDS_SET_PRIMARY* = 0x00000010
  CDS_VIDEOPARAMETERS* = 0x00000020
  CDS_ENABLE_UNSAFE_MODES* = 0x00000100
  CDS_DISABLE_UNSAFE_MODES* = 0x00000200
  CDS_RESET* = 0x40000000
  CDS_RESET_EX* = 0x20000000
  CDS_NORESET* = 0x10000000
  VP_COMMAND_GET* = 0x0001
  VP_COMMAND_SET* = 0x0002
  VP_FLAGS_TV_MODE* = 0x0001
  VP_FLAGS_TV_STANDARD* = 0x0002
  VP_FLAGS_FLICKER* = 0x0004
  VP_FLAGS_OVERSCAN* = 0x0008
  VP_FLAGS_MAX_UNSCALED* = 0x0010
  VP_FLAGS_POSITION* = 0x0020
  VP_FLAGS_BRIGHTNESS* = 0x0040
  VP_FLAGS_CONTRAST* = 0x0080
  VP_FLAGS_COPYPROTECT* = 0x0100
  VP_MODE_WIN_GRAPHICS* = 0x0001
  VP_MODE_TV_PLAYBACK* = 0x0002
  VP_TV_STANDARD_NTSC_M* = 0x0001
  VP_TV_STANDARD_NTSC_M_J* = 0x0002
  VP_TV_STANDARD_PAL_B* = 0x0004
  VP_TV_STANDARD_PAL_D* = 0x0008
  VP_TV_STANDARD_PAL_H* = 0x0010
  VP_TV_STANDARD_PAL_I* = 0x0020
  VP_TV_STANDARD_PAL_M* = 0x0040
  VP_TV_STANDARD_PAL_N* = 0x0080
  VP_TV_STANDARD_SECAM_B* = 0x0100
  VP_TV_STANDARD_SECAM_D* = 0x0200
  VP_TV_STANDARD_SECAM_G* = 0x0400
  VP_TV_STANDARD_SECAM_H* = 0x0800
  VP_TV_STANDARD_SECAM_K* = 0x1000
  VP_TV_STANDARD_SECAM_K1* = 0x2000
  VP_TV_STANDARD_SECAM_L* = 0x4000
  VP_TV_STANDARD_WIN_VGA* = 0x8000
  VP_TV_STANDARD_NTSC_433* = 0x00010000
  VP_TV_STANDARD_PAL_G* = 0x00020000
  VP_TV_STANDARD_PAL_60* = 0x00040000
  VP_TV_STANDARD_SECAM_L1* = 0x00080000
  VP_CP_TYPE_APS_TRIGGER* = 0x0001
  VP_CP_TYPE_MACROVISION* = 0x0002
  VP_CP_CMD_ACTIVATE* = 0x0001
  VP_CP_CMD_DEACTIVATE* = 0x0002
  VP_CP_CMD_CHANGE* = 0x0004
  DISP_CHANGE_SUCCESSFUL* = 0
  DISP_CHANGE_RESTART* = 1
  DISP_CHANGE_FAILED* = -1
  DISP_CHANGE_BADMODE* = -2
  DISP_CHANGE_NOTUPDATED* = -3
  DISP_CHANGE_BADFLAGS* = -4
  DISP_CHANGE_BADPARAM* = -5
  DISP_CHANGE_BADDUALVIEW* = -6
  ENUM_CURRENT_SETTINGS* = DWORD(-1)
  ENUM_REGISTRY_SETTINGS* = DWORD(-2)
  EDS_RAWMODE* = 0x00000002
  EDD_GET_DEVICE_INTERFACE_NAME* = 0x00000001
  FKF_FILTERKEYSON* = 0x00000001
  FKF_AVAILABLE* = 0x00000002
  FKF_HOTKEYACTIVE* = 0x00000004
  FKF_CONFIRMHOTKEY* = 0x00000008
  FKF_HOTKEYSOUND* = 0x00000010
  FKF_INDICATOR* = 0x00000020
  FKF_CLICKON* = 0x00000040
  SKF_STICKYKEYSON* = 0x00000001
  SKF_AVAILABLE* = 0x00000002
  SKF_HOTKEYACTIVE* = 0x00000004
  SKF_CONFIRMHOTKEY* = 0x00000008
  SKF_HOTKEYSOUND* = 0x00000010
  SKF_INDICATOR* = 0x00000020
  SKF_AUDIBLEFEEDBACK* = 0x00000040
  SKF_TRISTATE* = 0x00000080
  SKF_TWOKEYSOFF* = 0x00000100
  SKF_LALTLATCHED* = 0x10000000
  SKF_LCTLLATCHED* = 0x04000000
  SKF_LSHIFTLATCHED* = 0x01000000
  SKF_RALTLATCHED* = 0x20000000
  SKF_RCTLLATCHED* = 0x08000000
  SKF_RSHIFTLATCHED* = 0x02000000
  SKF_LWINLATCHED* = 0x40000000
  SKF_RWINLATCHED* = 0x80000000'i32
  SKF_LALTLOCKED* = 0x00100000
  SKF_LCTLLOCKED* = 0x00040000
  SKF_LSHIFTLOCKED* = 0x00010000
  SKF_RALTLOCKED* = 0x00200000
  SKF_RCTLLOCKED* = 0x00080000
  SKF_RSHIFTLOCKED* = 0x00020000
  SKF_LWINLOCKED* = 0x00400000
  SKF_RWINLOCKED* = 0x00800000
  MKF_MOUSEKEYSON* = 0x00000001
  MKF_AVAILABLE* = 0x00000002
  MKF_HOTKEYACTIVE* = 0x00000004
  MKF_CONFIRMHOTKEY* = 0x00000008
  MKF_HOTKEYSOUND* = 0x00000010
  MKF_INDICATOR* = 0x00000020
  MKF_MODIFIERS* = 0x00000040
  MKF_REPLACENUMBERS* = 0x00000080
  MKF_LEFTBUTTONSEL* = 0x10000000
  MKF_RIGHTBUTTONSEL* = 0x20000000
  MKF_LEFTBUTTONDOWN* = 0x01000000
  MKF_RIGHTBUTTONDOWN* = 0x02000000
  MKF_MOUSEMODE* = 0x80000000'i32
  ATF_TIMEOUTON* = 0x00000001
  ATF_ONOFFFEEDBACK* = 0x00000002
  SSGF_NONE* = 0
  SSGF_DISPLAY* = 3
  SSTF_NONE* = 0
  SSTF_CHARS* = 1
  SSTF_BORDER* = 2
  SSTF_DISPLAY* = 3
  SSWF_NONE* = 0
  SSWF_TITLE* = 1
  SSWF_WINDOW* = 2
  SSWF_DISPLAY* = 3
  SSWF_CUSTOM* = 4
  SSF_SOUNDSENTRYON* = 0x00000001
  SSF_AVAILABLE* = 0x00000002
  SSF_INDICATOR* = 0x00000004
  TKF_TOGGLEKEYSON* = 0x00000001
  TKF_AVAILABLE* = 0x00000002
  TKF_HOTKEYACTIVE* = 0x00000004
  TKF_CONFIRMHOTKEY* = 0x00000008
  TKF_HOTKEYSOUND* = 0x00000010
  TKF_INDICATOR* = 0x00000020
  SLE_ERROR* = 0x00000001
  SLE_MINORERROR* = 0x00000002
  SLE_WARNING* = 0x00000003
  MONITOR_DEFAULTTONULL* = 0x00000000
  MONITOR_DEFAULTTOPRIMARY* = 0x00000001
  MONITOR_DEFAULTTONEAREST* = 0x00000002
  MONITORINFOF_PRIMARY* = 0x00000001
  WINEVENT_OUTOFCONTEXT* = 0x0000
  WINEVENT_SKIPOWNTHREAD* = 0x0001
  WINEVENT_SKIPOWNPROCESS* = 0x0002
  WINEVENT_INCONTEXT* = 0x0004
  CHILDID_SELF* = 0
  INDEXID_OBJECT* = 0
  INDEXID_CONTAINER* = 0
  OBJID_WINDOW* = LONG 0x00000000
  OBJID_SYSMENU* = LONG 0xFFFFFFFF'i32
  OBJID_TITLEBAR* = LONG 0xFFFFFFFE'i32
  OBJID_MENU* = LONG 0xFFFFFFFD'i32
  OBJID_CLIENT* = LONG 0xFFFFFFFC'i32
  OBJID_VSCROLL* = LONG 0xFFFFFFFB'i32
  OBJID_HSCROLL* = LONG 0xFFFFFFFA'i32
  OBJID_SIZEGRIP* = LONG 0xFFFFFFF9'i32
  OBJID_CARET* = LONG 0xFFFFFFF8'i32
  OBJID_CURSOR* = LONG 0xFFFFFFF7'i32
  OBJID_ALERT* = LONG 0xFFFFFFF6'i32
  OBJID_SOUND* = LONG 0xFFFFFFF5'i32
  OBJID_QUERYCLASSNAMEIDX* = LONG 0xFFFFFFF4'i32
  OBJID_NATIVEOM* = LONG 0xFFFFFFF0'i32
  EVENT_MIN* = 0x00000001
  EVENT_MAX* = 0x7FFFFFFF
  EVENT_SYSTEM_SOUND* = 0x0001
  EVENT_SYSTEM_ALERT* = 0x0002
  EVENT_SYSTEM_FOREGROUND* = 0x0003
  EVENT_SYSTEM_MENUSTART* = 0x0004
  EVENT_SYSTEM_MENUEND* = 0x0005
  EVENT_SYSTEM_MENUPOPUPSTART* = 0x0006
  EVENT_SYSTEM_MENUPOPUPEND* = 0x0007
  EVENT_SYSTEM_CAPTURESTART* = 0x0008
  EVENT_SYSTEM_CAPTUREEND* = 0x0009
  EVENT_SYSTEM_MOVESIZESTART* = 0x000A
  EVENT_SYSTEM_MOVESIZEEND* = 0x000B
  EVENT_SYSTEM_CONTEXTHELPSTART* = 0x000C
  EVENT_SYSTEM_CONTEXTHELPEND* = 0x000D
  EVENT_SYSTEM_DRAGDROPSTART* = 0x000E
  EVENT_SYSTEM_DRAGDROPEND* = 0x000F
  EVENT_SYSTEM_DIALOGSTART* = 0x0010
  EVENT_SYSTEM_DIALOGEND* = 0x0011
  EVENT_SYSTEM_SCROLLINGSTART* = 0x0012
  EVENT_SYSTEM_SCROLLINGEND* = 0x0013
  EVENT_SYSTEM_SWITCHSTART* = 0x0014
  EVENT_SYSTEM_SWITCHEND* = 0x0015
  EVENT_SYSTEM_MINIMIZESTART* = 0x0016
  EVENT_SYSTEM_MINIMIZEEND* = 0x0017
  EVENT_SYSTEM_DESKTOPSWITCH* = 0x0020
  EVENT_SYSTEM_SWITCHER_APPGRABBED* = 0x0024
  EVENT_SYSTEM_SWITCHER_APPOVERTARGET* = 0x0025
  EVENT_SYSTEM_SWITCHER_APPDROPPED* = 0x0026
  EVENT_SYSTEM_SWITCHER_CANCELLED* = 0x0027
  EVENT_SYSTEM_IME_KEY_NOTIFICATION* = 0x0029
  EVENT_SYSTEM_END* = 0x00ff
  EVENT_OEM_DEFINED_START* = 0x0101
  EVENT_OEM_DEFINED_END* = 0x01ff
  EVENT_UIA_EVENTID_START* = 0x4e00
  EVENT_UIA_EVENTID_END* = 0x4eff
  EVENT_UIA_PROPID_START* = 0x7500
  EVENT_UIA_PROPID_END* = 0x75ff
  EVENT_CONSOLE_CARET* = 0x4001
  EVENT_CONSOLE_UPDATE_REGION* = 0x4002
  EVENT_CONSOLE_UPDATE_SIMPLE* = 0x4003
  EVENT_CONSOLE_UPDATE_SCROLL* = 0x4004
  EVENT_CONSOLE_LAYOUT* = 0x4005
  EVENT_CONSOLE_START_APPLICATION* = 0x4006
  EVENT_CONSOLE_END_APPLICATION* = 0x4007
  CONSOLE_CARET_SELECTION* = 0x0001
  CONSOLE_CARET_VISIBLE* = 0x0002
  EVENT_CONSOLE_END* = 0x40ff
  EVENT_OBJECT_CREATE* = 0x8000
  EVENT_OBJECT_DESTROY* = 0x8001
  EVENT_OBJECT_SHOW* = 0x8002
  EVENT_OBJECT_HIDE* = 0x8003
  EVENT_OBJECT_REORDER* = 0x8004
  EVENT_OBJECT_FOCUS* = 0x8005
  EVENT_OBJECT_SELECTION* = 0x8006
  EVENT_OBJECT_SELECTIONADD* = 0x8007
  EVENT_OBJECT_SELECTIONREMOVE* = 0x8008
  EVENT_OBJECT_SELECTIONWITHIN* = 0x8009
  EVENT_OBJECT_STATECHANGE* = 0x800A
  EVENT_OBJECT_LOCATIONCHANGE* = 0x800B
  EVENT_OBJECT_NAMECHANGE* = 0x800C
  EVENT_OBJECT_DESCRIPTIONCHANGE* = 0x800D
  EVENT_OBJECT_VALUECHANGE* = 0x800E
  EVENT_OBJECT_PARENTCHANGE* = 0x800F
  EVENT_OBJECT_HELPCHANGE* = 0x8010
  EVENT_OBJECT_DEFACTIONCHANGE* = 0x8011
  EVENT_OBJECT_ACCELERATORCHANGE* = 0x8012
  EVENT_OBJECT_INVOKED* = 0x8013
  EVENT_OBJECT_TEXTSELECTIONCHANGED* = 0x8014
  EVENT_OBJECT_CONTENTSCROLLED* = 0x8015
  EVENT_SYSTEM_ARRANGMENTPREVIEW* = 0x8016
  EVENT_OBJECT_CLOAKED* = 0x8017
  EVENT_OBJECT_UNCLOAKED* = 0x8018
  EVENT_OBJECT_LIVEREGIONCHANGED* = 0x8019
  EVENT_OBJECT_HOSTEDOBJECTSINVALIDATED* = 0x8020
  EVENT_OBJECT_DRAGSTART* = 0x8021
  EVENT_OBJECT_DRAGCANCEL* = 0x8022
  EVENT_OBJECT_DRAGCOMPLETE* = 0x8023
  EVENT_OBJECT_DRAGENTER* = 0x8024
  EVENT_OBJECT_DRAGLEAVE* = 0x8025
  EVENT_OBJECT_DRAGDROPPED* = 0x8026
  EVENT_OBJECT_IME_SHOW* = 0x8027
  EVENT_OBJECT_IME_HIDE* = 0x8028
  EVENT_OBJECT_IME_CHANGE* = 0x8029
  EVENT_OBJECT_END* = 0x80ff
  EVENT_AIA_START* = 0xa000
  EVENT_AIA_END* = 0xafff
  SOUND_SYSTEM_STARTUP* = 1
  SOUND_SYSTEM_SHUTDOWN* = 2
  SOUND_SYSTEM_BEEP* = 3
  SOUND_SYSTEM_ERROR* = 4
  SOUND_SYSTEM_QUESTION* = 5
  SOUND_SYSTEM_WARNING* = 6
  SOUND_SYSTEM_INFORMATION* = 7
  SOUND_SYSTEM_MAXIMIZE* = 8
  SOUND_SYSTEM_MINIMIZE* = 9
  SOUND_SYSTEM_RESTOREUP* = 10
  SOUND_SYSTEM_RESTOREDOWN* = 11
  SOUND_SYSTEM_APPSTART* = 12
  SOUND_SYSTEM_FAULT* = 13
  SOUND_SYSTEM_APPEND* = 14
  SOUND_SYSTEM_MENUCOMMAND* = 15
  SOUND_SYSTEM_MENUPOPUP* = 16
  CSOUND_SYSTEM* = 16
  ALERT_SYSTEM_INFORMATIONAL* = 1
  ALERT_SYSTEM_WARNING* = 2
  ALERT_SYSTEM_ERROR* = 3
  ALERT_SYSTEM_QUERY* = 4
  ALERT_SYSTEM_CRITICAL* = 5
  CALERT_SYSTEM* = 6
  GUI_CARETBLINKING* = 0x00000001
  GUI_INMOVESIZE* = 0x00000002
  GUI_INMENUMODE* = 0x00000004
  GUI_SYSTEMMENUMODE* = 0x00000008
  GUI_POPUPMENUMODE* = 0x00000010
  USER_DEFAULT_SCREEN_DPI* = 96
  STATE_SYSTEM_UNAVAILABLE* = 0x00000001
  STATE_SYSTEM_SELECTED* = 0x00000002
  STATE_SYSTEM_FOCUSED* = 0x00000004
  STATE_SYSTEM_PRESSED* = 0x00000008
  STATE_SYSTEM_CHECKED* = 0x00000010
  STATE_SYSTEM_MIXED* = 0x00000020
  STATE_SYSTEM_INDETERMINATE* = STATE_SYSTEM_MIXED
  STATE_SYSTEM_READONLY* = 0x00000040
  STATE_SYSTEM_HOTTRACKED* = 0x00000080
  STATE_SYSTEM_DEFAULT* = 0x00000100
  STATE_SYSTEM_EXPANDED* = 0x00000200
  STATE_SYSTEM_COLLAPSED* = 0x00000400
  STATE_SYSTEM_BUSY* = 0x00000800
  STATE_SYSTEM_FLOATING* = 0x00001000
  STATE_SYSTEM_MARQUEED* = 0x00002000
  STATE_SYSTEM_ANIMATED* = 0x00004000
  STATE_SYSTEM_INVISIBLE* = 0x00008000
  STATE_SYSTEM_OFFSCREEN* = 0x00010000
  STATE_SYSTEM_SIZEABLE* = 0x00020000
  STATE_SYSTEM_MOVEABLE* = 0x00040000
  STATE_SYSTEM_SELFVOICING* = 0x00080000
  STATE_SYSTEM_FOCUSABLE* = 0x00100000
  STATE_SYSTEM_SELECTABLE* = 0x00200000
  STATE_SYSTEM_LINKED* = 0x00400000
  STATE_SYSTEM_TRAVERSED* = 0x00800000
  STATE_SYSTEM_MULTISELECTABLE* = 0x01000000
  STATE_SYSTEM_EXTSELECTABLE* = 0x02000000
  STATE_SYSTEM_ALERT_LOW* = 0x04000000
  STATE_SYSTEM_ALERT_MEDIUM* = 0x08000000
  STATE_SYSTEM_ALERT_HIGH* = 0x10000000
  STATE_SYSTEM_PROTECTED* = 0x20000000
  STATE_SYSTEM_VALID* = 0x3FFFFFFF
  CURSOR_SHOWING* = 0x00000001
  CURSOR_SUPPRESSED* = 0x00000002
  WS_ACTIVECAPTION* = 0x0001
  GA_PARENT* = 1
  GA_ROOT* = 2
  GA_ROOTOWNER* = 3
  RIM_INPUT* = 0
  RIM_INPUTSINK* = 1
  RIM_TYPEMOUSE* = 0
  RIM_TYPEKEYBOARD* = 1
  RIM_TYPEHID* = 2
  RI_MOUSE_LEFT_BUTTON_DOWN* = 0x0001
  RI_MOUSE_LEFT_BUTTON_UP* = 0x0002
  RI_MOUSE_RIGHT_BUTTON_DOWN* = 0x0004
  RI_MOUSE_RIGHT_BUTTON_UP* = 0x0008
  RI_MOUSE_MIDDLE_BUTTON_DOWN* = 0x0010
  RI_MOUSE_MIDDLE_BUTTON_UP* = 0x0020
  RI_MOUSE_BUTTON_4_DOWN* = 0x0040
  RI_MOUSE_BUTTON_4_UP* = 0x0080
  RI_MOUSE_BUTTON_5_DOWN* = 0x0100
  RI_MOUSE_BUTTON_5_UP* = 0x0200
  RI_MOUSE_WHEEL* = 0x0400
  RI_MOUSE_BUTTON_1_DOWN* = RI_MOUSE_LEFT_BUTTON_DOWN
  RI_MOUSE_BUTTON_1_UP* = RI_MOUSE_LEFT_BUTTON_UP
  RI_MOUSE_BUTTON_2_DOWN* = RI_MOUSE_RIGHT_BUTTON_DOWN
  RI_MOUSE_BUTTON_2_UP* = RI_MOUSE_RIGHT_BUTTON_UP
  RI_MOUSE_BUTTON_3_DOWN* = RI_MOUSE_MIDDLE_BUTTON_DOWN
  RI_MOUSE_BUTTON_3_UP* = RI_MOUSE_MIDDLE_BUTTON_UP
  MOUSE_MOVE_RELATIVE* = 0
  MOUSE_MOVE_ABSOLUTE* = 1
  MOUSE_VIRTUAL_DESKTOP* = 0x02
  MOUSE_ATTRIBUTES_CHANGED* = 0x04
  MOUSE_MOVE_NOCOALESCE* = 0x08
  KEYBOARD_OVERRUN_MAKE_CODE* = 0xFF
  RI_KEY_MAKE* = 0
  RI_KEY_BREAK* = 1
  RI_KEY_E0* = 2
  RI_KEY_E1* = 4
  RI_KEY_TERMSRV_SET_LED* = 8
  RI_KEY_TERMSRV_SHADOW* = 0x10
  RID_INPUT* = 0x10000003
  RID_HEADER* = 0x10000005
  RIDI_PREPARSEDDATA* = 0x20000005
  RIDI_DEVICENAME* = 0x20000007
  RIDI_DEVICEINFO* = 0x2000000b
  RIDEV_REMOVE* = 0x00000001
  RIDEV_EXCLUDE* = 0x00000010
  RIDEV_PAGEONLY* = 0x00000020
  RIDEV_NOLEGACY* = 0x00000030
  RIDEV_INPUTSINK* = 0x00000100
  RIDEV_CAPTUREMOUSE* = 0x00000200
  RIDEV_NOHOTKEYS* = 0x00000200
  RIDEV_APPKEYS* = 0x00000400
  RIDEV_EXINPUTSINK* = 0x00001000
  RIDEV_DEVNOTIFY* = 0x00002000
  RIDEV_EXMODEMASK* = 0x000000F0
  GIDC_ARRIVAL* = 1
  GIDC_REMOVAL* = 2
  POINTER_DEVICE_PRODUCT_STRING_MAX* = 520
  PDC_ARRIVAL* = 0x001
  PDC_REMOVAL* = 0x002
  PDC_ORIENTATION_0* = 0x004
  PDC_ORIENTATION_90* = 0x008
  PDC_ORIENTATION_180* = 0x010
  PDC_ORIENTATION_270* = 0x020
  PDC_MODE_DEFAULT* = 0x040
  PDC_MODE_CENTERED* = 0x080
  PDC_MAPPING_CHANGE* = 0x100
  PDC_RESOLUTION* = 0x200
  PDC_ORIGIN* = 0x400
  PDC_MODE_ASPECTRATIOPRESERVED* = 0x800
  POINTER_DEVICE_TYPE_INTEGRATED_PEN* = 0x00000001
  POINTER_DEVICE_TYPE_EXTERNAL_PEN* = 0x00000002
  POINTER_DEVICE_TYPE_TOUCH* = 0x00000003
  POINTER_DEVICE_TYPE_MAX* = 0xffffffff'i32
  POINTER_DEVICE_CURSOR_TYPE_UNKNOWN* = 0x00000000
  POINTER_DEVICE_CURSOR_TYPE_TIP* = 0x00000001
  POINTER_DEVICE_CURSOR_TYPE_ERASER* = 0x00000002
  POINTER_DEVICE_CURSOR_TYPE_MAX* = 0xffffffff'i32
  MSGFLT_ADD* = 1
  MSGFLT_REMOVE* = 2
  MSGFLTINFO_NONE* = 0
  MSGFLTINFO_ALREADYALLOWED_FORWND* = 1
  MSGFLTINFO_ALREADYDISALLOWED_FORWND* = 2
  MSGFLTINFO_ALLOWED_HIGHER* = 3
  MSGFLT_RESET* = 0
  MSGFLT_ALLOW* = 1
  MSGFLT_DISALLOW* = 2
  GF_BEGIN* = 0x00000001
  GF_INERTIA* = 0x00000002
  GF_END* = 0x00000004
  GID_BEGIN* = 1
  GID_END* = 2
  GID_ZOOM* = 3
  GID_PAN* = 4
  GID_ROTATE* = 5
  GID_TWOFINGERTAP* = 6
  GID_PRESSANDTAP* = 7
  GID_ROLLOVER* = GID_PRESSANDTAP
  GC_ALLGESTURES* = 0x00000001
  GC_ZOOM* = 0x00000001
  GC_PAN* = 0x00000001
  GC_PAN_WITH_SINGLE_FINGER_VERTICALLY* = 0x00000002
  GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY* = 0x00000004
  GC_PAN_WITH_GUTTER* = 0x00000008
  GC_PAN_WITH_INERTIA* = 0x00000010
  GC_ROTATE* = 0x00000001
  GC_TWOFINGERTAP* = 0x00000001
  GC_PRESSANDTAP* = 0x00000001
  GC_ROLLOVER* = GC_PRESSANDTAP
  GESTURECONFIGMAXCOUNT* = 256
  GCF_INCLUDE_ANCESTORS* = 0x00000001
  NID_INTEGRATED_TOUCH* = 0x00000001
  NID_EXTERNAL_TOUCH* = 0x00000002
  NID_INTEGRATED_PEN* = 0x00000004
  NID_EXTERNAL_PEN* = 0x00000008
  NID_MULTI_INPUT* = 0x00000040
  NID_READY* = 0x00000080
  MAX_STR_BLOCKREASON* = 256
  IMDT_UNAVAILABLE* = 0x00000000
  IMDT_KEYBOARD* = 0x00000001
  IMDT_MOUSE* = 0x00000002
  IMDT_TOUCH* = 0x00000004
  IMDT_PEN* = 0x00000008
  IMO_UNAVAILABLE* = 0x00000000
  IMO_HARDWARE* = 0x00000001
  IMO_INJECTED* = 0x00000002
  IMO_SYSTEM* = 0x00000004
  AR_ENABLED* = 0x0
  AR_DISABLED* = 0x1
  AR_SUPPRESSED* = 0x2
  AR_REMOTESESSION* = 0x4
  AR_MULTIMON* = 0x8
  AR_NOSENSOR* = 0x10
  AR_NOT_SUPPORTED* = 0x20
  AR_DOCKED* = 0x40
  AR_LAPTOP* = 0x80
  ORIENTATION_PREFERENCE_NONE* = 0x0
  ORIENTATION_PREFERENCE_LANDSCAPE* = 0x1
  ORIENTATION_PREFERENCE_PORTRAIT* = 0x2
  ORIENTATION_PREFERENCE_LANDSCAPE_FLIPPED* = 0x4
  ORIENTATION_PREFERENCE_PORTRAIT_FLIPPED* = 0x8
  RT_GROUP_CURSOR* = MAKEINTRESOURCE(1+DIFFERENCE)
  RT_GROUP_ICON* = MAKEINTRESOURCE(3+DIFFERENCE)
  SETWALLPAPER_DEFAULT* = cast[LPWSTR](-1)
  WHEEL_PAGESCROLL* = 0xffffffff'i32
type
  TIMERPROC* = proc (P1: HWND, P2: UINT, P3: UINT_PTR, P4: DWORD): VOID {.stdcall.}
  GRAYSTRINGPROC* = proc (P1: HDC, P2: LPARAM, P3: int32): WINBOOL {.stdcall.}
  WNDENUMPROC* = proc (P1: HWND, P2: LPARAM): WINBOOL {.stdcall.}
  HOOKPROC* = proc (code: int32, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.}
  SENDASYNCPROC* = proc (P1: HWND, P2: UINT, P3: ULONG_PTR, P4: LRESULT): VOID {.stdcall.}
  PROPENUMPROCA* = proc (P1: HWND, P2: LPCSTR, P3: HANDLE): WINBOOL {.stdcall.}
  PROPENUMPROCW* = proc (P1: HWND, P2: LPCWSTR, P3: HANDLE): WINBOOL {.stdcall.}
  PROPENUMPROCEXA* = proc (P1: HWND, P2: LPSTR, P3: HANDLE, P4: ULONG_PTR): WINBOOL {.stdcall.}
  PROPENUMPROCEXW* = proc (P1: HWND, P2: LPWSTR, P3: HANDLE, P4: ULONG_PTR): WINBOOL {.stdcall.}
  EDITWORDBREAKPROCA* = proc (lpch: LPSTR, ichCurrent: int32, cch: int32, code: int32): int32 {.stdcall.}
  EDITWORDBREAKPROCW* = proc (lpch: LPWSTR, ichCurrent: int32, cch: int32, code: int32): int32 {.stdcall.}
  DRAWSTATEPROC* = proc (hdc: HDC, lData: LPARAM, wData: WPARAM, cx: int32, cy: int32): WINBOOL {.stdcall.}
  PREGISTERCLASSNAMEW* = proc (P1: LPCWSTR): BOOLEAN {.stdcall.}
  MONITORENUMPROC* = proc (P1: HMONITOR, P2: HDC, P3: LPRECT, P4: LPARAM): WINBOOL {.stdcall.}
  WINEVENTPROC* = proc (hWinEventHook: HWINEVENTHOOK, event: DWORD, hwnd: HWND, idObject: LONG, idChild: LONG, idEventThread: DWORD, dwmsEventTime: DWORD): VOID {.stdcall.}
  POINTER_INFO* {.pure.} = object
    pointerType*: POINTER_INPUT_TYPE
    pointerId*: UINT32
    frameId*: UINT32
    pointerFlags*: POINTER_FLAGS
    sourceDevice*: HANDLE
    hwndTarget*: HWND
    ptPixelLocation*: POINT
    ptHimetricLocation*: POINT
    ptPixelLocationRaw*: POINT
    ptHimetricLocationRaw*: POINT
    dwTime*: DWORD
    historyCount*: UINT32
    InputData*: INT32
    dwKeyStates*: DWORD
    PerformanceCount*: UINT64
    ButtonChangeType*: POINTER_BUTTON_CHANGE_TYPE
  POINTER_TOUCH_INFO* {.pure.} = object
    pointerInfo*: POINTER_INFO
    touchFlags*: TOUCH_FLAGS
    touchMask*: TOUCH_MASK
    rcContact*: RECT
    rcContactRaw*: RECT
    orientation*: UINT32
    pressure*: UINT32
  POINTER_PEN_INFO* {.pure.} = object
    pointerInfo*: POINTER_INFO
    penFlags*: PEN_FLAGS
    penMask*: PEN_MASK
    pressure*: UINT32
    rotation*: UINT32
    tiltX*: INT32
    tiltY*: INT32
  POINTER_DEVICE_INFO* {.pure.} = object
    displayOrientation*: DWORD
    device*: HANDLE
    pointerDeviceType*: POINTER_DEVICE_TYPE
    monitor*: HMONITOR
    startingCursorId*: ULONG
    maxActiveContacts*: USHORT
    productString*: array[POINTER_DEVICE_PRODUCT_STRING_MAX, WCHAR]
  POINTER_DEVICE_PROPERTY* {.pure.} = object
    logicalMin*: INT32
    logicalMax*: INT32
    physicalMin*: INT32
    physicalMax*: INT32
    unit*: UINT32
    unitExponent*: UINT32
    usagePageId*: USHORT
    usageId*: USHORT
  POINTER_DEVICE_CURSOR_INFO* {.pure.} = object
    cursorId*: UINT32
    cursor*: POINTER_DEVICE_CURSOR_TYPE
  INPUT_MESSAGE_SOURCE* {.pure.} = object
    deviceType*: INPUT_MESSAGE_DEVICE_TYPE
    originId*: INPUT_MESSAGE_ORIGIN_ID
  INPUT_TRANSFORM_UNION1_STRUCT1* {.pure.} = object
    m11*: float32
    m12*: float32
    m13*: float32
    m14*: float32
    m21*: float32
    m22*: float32
    m23*: float32
    m24*: float32
    m31*: float32
    m32*: float32
    m33*: float32
    m34*: float32
    m41*: float32
    m42*: float32
    m43*: float32
    m44*: float32
  INPUT_TRANSFORM_UNION1* {.pure, union.} = object
    struct1*: INPUT_TRANSFORM_UNION1_STRUCT1
    m*: array[4, array[4, float32]]
  INPUT_TRANSFORM* {.pure.} = object
    union1*: INPUT_TRANSFORM_UNION1
  MENUTEMPLATEA* {.pure.} = object
  MENUTEMPLATEW* {.pure.} = object
proc wvsprintfA*(P1: LPSTR, P2: LPCSTR, arglist: va_list): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc wvsprintfW*(P1: LPWSTR, P2: LPCWSTR, arglist: va_list): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc wsprintfA*(P1: LPSTR, P2: LPCSTR): int32 {.winapi, cdecl, varargs, dynlib: "user32", importc.}
proc wsprintfW*(P1: LPWSTR, P2: LPCWSTR): int32 {.winapi, cdecl, varargs, dynlib: "user32", importc.}
proc LoadKeyboardLayoutA*(pwszKLID: LPCSTR, Flags: UINT): HKL {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadKeyboardLayoutW*(pwszKLID: LPCWSTR, Flags: UINT): HKL {.winapi, stdcall, dynlib: "user32", importc.}
proc ActivateKeyboardLayout*(hkl: HKL, Flags: UINT): HKL {.winapi, stdcall, dynlib: "user32", importc.}
proc ToUnicodeEx*(wVirtKey: UINT, wScanCode: UINT, lpKeyState: ptr BYTE, pwszBuff: LPWSTR, cchBuff: int32, wFlags: UINT, dwhkl: HKL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc UnloadKeyboardLayout*(hkl: HKL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyboardLayoutNameA*(pwszKLID: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyboardLayoutNameW*(pwszKLID: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyboardLayoutList*(nBuff: int32, lpList: ptr HKL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyboardLayout*(idThread: DWORD): HKL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMouseMovePointsEx*(cbSize: UINT, lppt: LPMOUSEMOVEPOINT, lpptBuf: LPMOUSEMOVEPOINT, nBufPoints: int32, resolution: DWORD): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateDesktopA*(lpszDesktop: LPCSTR, lpszDevice: LPCSTR, pDevmode: LPDEVMODEA, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES): HDESK {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateDesktopW*(lpszDesktop: LPCWSTR, lpszDevice: LPCWSTR, pDevmode: LPDEVMODEW, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES): HDESK {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateDesktopExA*(lpszDesktop: LPCSTR, lpszDevice: LPCSTR, pDevmode: ptr DEVMODEA, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES, ulHeapSize: ULONG, pvoid: PVOID): HDESK {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateDesktopExW*(lpszDesktop: LPCWSTR, lpszDevice: LPCWSTR, pDevmode: ptr DEVMODEW, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES, ulHeapSize: ULONG, pvoid: PVOID): HDESK {.winapi, stdcall, dynlib: "user32", importc.}
proc OpenDesktopA*(lpszDesktop: LPCSTR, dwFlags: DWORD, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HDESK {.winapi, stdcall, dynlib: "user32", importc.}
proc OpenDesktopW*(lpszDesktop: LPCWSTR, dwFlags: DWORD, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HDESK {.winapi, stdcall, dynlib: "user32", importc.}
proc OpenInputDesktop*(dwFlags: DWORD, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HDESK {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDesktopsA*(hwinsta: HWINSTA, lpEnumFunc: DESKTOPENUMPROCA, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDesktopsW*(hwinsta: HWINSTA, lpEnumFunc: DESKTOPENUMPROCW, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDesktopWindows*(hDesktop: HDESK, lpfn: WNDENUMPROC, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SwitchDesktop*(hDesktop: HDESK): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetThreadDesktop*(hDesktop: HDESK): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CloseDesktop*(hDesktop: HDESK): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetThreadDesktop*(dwThreadId: DWORD): HDESK {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateWindowStationA*(lpwinsta: LPCSTR, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES): HWINSTA {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateWindowStationW*(lpwinsta: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES): HWINSTA {.winapi, stdcall, dynlib: "user32", importc.}
proc OpenWindowStationA*(lpszWinSta: LPCSTR, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HWINSTA {.winapi, stdcall, dynlib: "user32", importc.}
proc OpenWindowStationW*(lpszWinSta: LPCWSTR, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HWINSTA {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumWindowStationsA*(lpEnumFunc: WINSTAENUMPROCA, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumWindowStationsW*(lpEnumFunc: WINSTAENUMPROCW, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CloseWindowStation*(hWinSta: HWINSTA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetProcessWindowStation*(hWinSta: HWINSTA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetProcessWindowStation*(): HWINSTA {.winapi, stdcall, dynlib: "user32", importc.}
proc SetUserObjectSecurity*(hObj: HANDLE, pSIRequested: PSECURITY_INFORMATION, pSID: PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetUserObjectSecurity*(hObj: HANDLE, pSIRequested: PSECURITY_INFORMATION, pSID: PSECURITY_DESCRIPTOR, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetUserObjectInformationA*(hObj: HANDLE, nIndex: int32, pvInfo: PVOID, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetUserObjectInformationW*(hObj: HANDLE, nIndex: int32, pvInfo: PVOID, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetUserObjectInformationA*(hObj: HANDLE, nIndex: int32, pvInfo: PVOID, nLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetUserObjectInformationW*(hObj: HANDLE, nIndex: int32, pvInfo: PVOID, nLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsHungAppWindow*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DisableProcessWindowsGhosting*(): VOID {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterWindowMessageA*(lpString: LPCSTR): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterWindowMessageW*(lpString: LPCWSTR): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc TrackMouseEvent*(lpEventTrack: LPTRACKMOUSEEVENT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawEdge*(hdc: HDC, qrc: LPRECT, edge: UINT, grfFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawFrameControl*(P1: HDC, P2: LPRECT, P3: UINT, P4: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawCaption*(hwnd: HWND, hdc: HDC, lprect: ptr RECT, flags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawAnimatedRects*(hwnd: HWND, idAni: int32, lprcFrom: ptr RECT, lprcTo: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMessageA*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMessageW*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc TranslateMessage*(lpMsg: ptr MSG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DispatchMessageA*(lpMsg: ptr MSG): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc DispatchMessageW*(lpMsg: ptr MSG): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMessageQueue*(cMessagesMax: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PeekMessageA*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PeekMessageW*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterHotKey*(hWnd: HWND, id: int32, fsModifiers: UINT, vk: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UnregisterHotKey*(hWnd: HWND, id: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ExitWindowsEx*(uFlags: UINT, dwReason: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SwapMouseButton*(fSwap: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMessagePos*(): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMessageTime*(): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMessageExtraInfo*(): LPARAM {.winapi, stdcall, dynlib: "user32", importc.}
proc GetUnpredictedMessagePos*(): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc IsWow64Message*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMessageExtraInfo*(lParam: LPARAM): LPARAM {.winapi, stdcall, dynlib: "user32", importc.}
proc SendMessageA*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc SendMessageW*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc SendMessageTimeoutA*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, fuFlags: UINT, uTimeout: UINT, lpdwResult: PDWORD_PTR): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc SendMessageTimeoutW*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, fuFlags: UINT, uTimeout: UINT, lpdwResult: PDWORD_PTR): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc SendNotifyMessageA*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SendNotifyMessageW*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SendMessageCallbackA*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, lpResultCallBack: SENDASYNCPROC, dwData: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SendMessageCallbackW*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, lpResultCallBack: SENDASYNCPROC, dwData: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc BroadcastSystemMessageExA*(flags: DWORD, lpInfo: LPDWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM, pbsmInfo: PBSMINFO): LONG32 {.winapi, stdcall, dynlib: "user32", importc.}
proc BroadcastSystemMessageExW*(flags: DWORD, lpInfo: LPDWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM, pbsmInfo: PBSMINFO): LONG32 {.winapi, stdcall, dynlib: "user32", importc.}
proc BroadcastSystemMessageA*(flags: DWORD, lpInfo: LPDWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LONG32 {.winapi, stdcall, dynlib: "user32", importc.}
proc BroadcastSystemMessageW*(flags: DWORD, lpInfo: LPDWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LONG32 {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterPowerSettingNotification*(hRecipient: HANDLE, PowerSettingGuid: LPCGUID, Flags: DWORD): HPOWERNOTIFY {.winapi, stdcall, dynlib: "user32", importc.}
proc UnregisterPowerSettingNotification*(Handle: HPOWERNOTIFY): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterSuspendResumeNotification*(hRecipient: HANDLE, Flags: DWORD): HPOWERNOTIFY {.winapi, stdcall, dynlib: "user32", importc.}
proc UnregisterSuspendResumeNotification*(Handle: HPOWERNOTIFY): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PostMessageA*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PostMessageW*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PostThreadMessageA*(idThread: DWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PostThreadMessageW*(idThread: DWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc AttachThreadInput*(idAttach: DWORD, idAttachTo: DWORD, fAttach: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ReplyMessage*(lResult: LRESULT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc WaitMessage*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc WaitForInputIdle*(hProcess: HANDLE, dwMilliseconds: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc DefWindowProcA*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc DefWindowProcW*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc PostQuitMessage*(nExitCode: int32): VOID {.winapi, stdcall, dynlib: "user32", importc.}
proc InSendMessage*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc InSendMessageEx*(lpReserved: LPVOID): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDoubleClickTime*(): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc SetDoubleClickTime*(P1: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterClassA*(lpWndClass: ptr WNDCLASSA): ATOM {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterClassW*(lpWndClass: ptr WNDCLASSW): ATOM {.winapi, stdcall, dynlib: "user32", importc.}
proc UnregisterClassA*(lpClassName: LPCSTR, hInstance: HINSTANCE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UnregisterClassW*(lpClassName: LPCWSTR, hInstance: HINSTANCE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassInfoA*(hInstance: HINSTANCE, lpClassName: LPCSTR, lpWndClass: LPWNDCLASSA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassInfoW*(hInstance: HINSTANCE, lpClassName: LPCWSTR, lpWndClass: LPWNDCLASSW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterClassExA*(P1: ptr WNDCLASSEXA): ATOM {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterClassExW*(P1: ptr WNDCLASSEXW): ATOM {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassInfoExA*(hInstance: HINSTANCE, lpszClass: LPCSTR, lpwcx: LPWNDCLASSEXA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassInfoExW*(hInstance: HINSTANCE, lpszClass: LPCWSTR, lpwcx: LPWNDCLASSEXW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CallWindowProcA*(lpPrevWndFunc: WNDPROC, hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc CallWindowProcW*(lpPrevWndFunc: WNDPROC, hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterDeviceNotificationA*(hRecipient: HANDLE, NotificationFilter: LPVOID, Flags: DWORD): HDEVNOTIFY {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterDeviceNotificationW*(hRecipient: HANDLE, NotificationFilter: LPVOID, Flags: DWORD): HDEVNOTIFY {.winapi, stdcall, dynlib: "user32", importc.}
proc UnregisterDeviceNotification*(Handle: HDEVNOTIFY): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateWindowExA*(dwExStyle: DWORD, lpClassName: LPCSTR, lpWindowName: LPCSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateWindowExW*(dwExStyle: DWORD, lpClassName: LPCWSTR, lpWindowName: LPCWSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc IsWindow*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsMenu*(hMenu: HMENU): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsChild*(hWndParent: HWND, hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DestroyWindow*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShowWindow*(hWnd: HWND, nCmdShow: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc AnimateWindow*(hWnd: HWND, dwTime: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UpdateLayeredWindow*(hWnd: HWND, hdcDst: HDC, pptDst: ptr POINT, psize: ptr SIZE, hdcSrc: HDC, pptSrc: ptr POINT, crKey: COLORREF, pblend: ptr BLENDFUNCTION, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UpdateLayeredWindowIndirect*(hWnd: HWND, pULWInfo: ptr UPDATELAYEREDWINDOWINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetLayeredWindowAttributes*(hwnd: HWND, pcrKey: ptr COLORREF, pbAlpha: ptr BYTE, pdwFlags: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PrintWindow*(hwnd: HWND, hdcBlt: HDC, nFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetLayeredWindowAttributes*(hwnd: HWND, crKey: COLORREF, bAlpha: BYTE, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShowWindowAsync*(hWnd: HWND, nCmdShow: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc FlashWindow*(hWnd: HWND, bInvert: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc FlashWindowEx*(pfwi: PFLASHWINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShowOwnedPopups*(hWnd: HWND, fShow: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc OpenIcon*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CloseWindow*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc MoveWindow*(hWnd: HWND, X: int32, Y: int32, nWidth: int32, nHeight: int32, bRepaint: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowPos*(hWnd: HWND, hWndInsertAfter: HWND, X: int32, Y: int32, cx: int32, cy: int32, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowPlacement*(hWnd: HWND, lpwndpl: ptr WINDOWPLACEMENT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowPlacement*(hWnd: HWND, lpwndpl: ptr WINDOWPLACEMENT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowDisplayAffinity*(hWnd: HWND, pdwAffinity: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowDisplayAffinity*(hWnd: HWND, dwAffinity: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc BeginDeferWindowPos*(nNumWindows: int32): HDWP {.winapi, stdcall, dynlib: "user32", importc.}
proc DeferWindowPos*(hWinPosInfo: HDWP, hWnd: HWND, hWndInsertAfter: HWND, x: int32, y: int32, cx: int32, cy: int32, uFlags: UINT): HDWP {.winapi, stdcall, dynlib: "user32", importc.}
proc EndDeferWindowPos*(hWinPosInfo: HDWP): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsWindowVisible*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsIconic*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc AnyPopup*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc BringWindowToTop*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsZoomed*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateDialogParamA*(hInstance: HINSTANCE, lpTemplateName: LPCSTR, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateDialogParamW*(hInstance: HINSTANCE, lpTemplateName: LPCWSTR, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateDialogIndirectParamA*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEA, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateDialogIndirectParamW*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEW, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc DialogBoxParamA*(hInstance: HINSTANCE, lpTemplateName: LPCSTR, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): INT_PTR {.winapi, stdcall, dynlib: "user32", importc.}
proc DialogBoxParamW*(hInstance: HINSTANCE, lpTemplateName: LPCWSTR, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): INT_PTR {.winapi, stdcall, dynlib: "user32", importc.}
proc DialogBoxIndirectParamA*(hInstance: HINSTANCE, hDialogTemplate: LPCDLGTEMPLATEA, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): INT_PTR {.winapi, stdcall, dynlib: "user32", importc.}
proc DialogBoxIndirectParamW*(hInstance: HINSTANCE, hDialogTemplate: LPCDLGTEMPLATEW, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): INT_PTR {.winapi, stdcall, dynlib: "user32", importc.}
proc EndDialog*(hDlg: HWND, nResult: INT_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDlgItem*(hDlg: HWND, nIDDlgItem: int32): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc SetDlgItemInt*(hDlg: HWND, nIDDlgItem: int32, uValue: UINT, bSigned: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDlgItemInt*(hDlg: HWND, nIDDlgItem: int32, lpTranslated: ptr WINBOOL, bSigned: WINBOOL): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc SetDlgItemTextA*(hDlg: HWND, nIDDlgItem: int32, lpString: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetDlgItemTextW*(hDlg: HWND, nIDDlgItem: int32, lpString: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDlgItemTextA*(hDlg: HWND, nIDDlgItem: int32, lpString: LPSTR, cchMax: int32): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDlgItemTextW*(hDlg: HWND, nIDDlgItem: int32, lpString: LPWSTR, cchMax: int32): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc CheckDlgButton*(hDlg: HWND, nIDButton: int32, uCheck: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CheckRadioButton*(hDlg: HWND, nIDFirstButton: int32, nIDLastButton: int32, nIDCheckButton: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsDlgButtonChecked*(hDlg: HWND, nIDButton: int32): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc SendDlgItemMessageA*(hDlg: HWND, nIDDlgItem: int32, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc SendDlgItemMessageW*(hDlg: HWND, nIDDlgItem: int32, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetNextDlgGroupItem*(hDlg: HWND, hCtl: HWND, bPrevious: WINBOOL): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetNextDlgTabItem*(hDlg: HWND, hCtl: HWND, bPrevious: WINBOOL): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDlgCtrlID*(hWnd: HWND): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDialogBaseUnits*(): LONG32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DefDlgProcA*(hDlg: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc DefDlgProcW*(hDlg: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc CallMsgFilterA*(lpMsg: LPMSG, nCode: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CallMsgFilterW*(lpMsg: LPMSG, nCode: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc OpenClipboard*(hWndNewOwner: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CloseClipboard*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClipboardSequenceNumber*(): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClipboardOwner*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc SetClipboardViewer*(hWndNewViewer: HWND): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClipboardViewer*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeClipboardChain*(hWndRemove: HWND, hWndNewNext: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetClipboardData*(uFormat: UINT, hMem: HANDLE): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClipboardData*(uFormat: UINT): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterClipboardFormatA*(lpszFormat: LPCSTR): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterClipboardFormatW*(lpszFormat: LPCWSTR): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc CountClipboardFormats*(): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumClipboardFormats*(format: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClipboardFormatNameA*(format: UINT, lpszFormatName: LPSTR, cchMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClipboardFormatNameW*(format: UINT, lpszFormatName: LPWSTR, cchMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc EmptyClipboard*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsClipboardFormatAvailable*(format: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPriorityClipboardFormat*(paFormatPriorityList: ptr UINT, cFormats: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetOpenClipboardWindow*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc AddClipboardFormatListener*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RemoveClipboardFormatListener*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetUpdatedClipboardFormats*(lpuiFormats: PUINT, cFormats: UINT, pcFormatsOut: PUINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CharToOemA*(lpszSrc: LPCSTR, lpszDst: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CharToOemW*(lpszSrc: LPCWSTR, lpszDst: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc OemToCharA*(lpszSrc: LPCSTR, lpszDst: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc OemToCharW*(lpszSrc: LPCSTR, lpszDst: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CharToOemBuffA*(lpszSrc: LPCSTR, lpszDst: LPSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CharToOemBuffW*(lpszSrc: LPCWSTR, lpszDst: LPSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc OemToCharBuffA*(lpszSrc: LPCSTR, lpszDst: LPSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc OemToCharBuffW*(lpszSrc: LPCSTR, lpszDst: LPWSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CharUpperA*(lpsz: LPSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharUpperW*(lpsz: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharUpperBuffA*(lpsz: LPSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc CharUpperBuffW*(lpsz: LPWSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc CharLowerA*(lpsz: LPSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharLowerW*(lpsz: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharLowerBuffA*(lpsz: LPSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc CharLowerBuffW*(lpsz: LPWSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc CharNextA*(lpsz: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharNextW*(lpsz: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharPrevA*(lpszStart: LPCSTR, lpszCurrent: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharPrevW*(lpszStart: LPCWSTR, lpszCurrent: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharNextExA*(CodePage: WORD, lpCurrentChar: LPCSTR, dwFlags: DWORD): LPSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc CharPrevExA*(CodePage: WORD, lpStart: LPCSTR, lpCurrentChar: LPCSTR, dwFlags: DWORD): LPSTR {.winapi, stdcall, dynlib: "user32", importc.}
proc AnsiToOem*(lpszSrc: LPCSTR, lpszDst: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "CharToOemA".}
proc OemToAnsi*(lpszSrc: LPCSTR, lpszDst: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "OemToCharA".}
proc AnsiToOemBuff*(lpszSrc: LPCSTR, lpszDst: LPSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "CharToOemBuffA".}
proc OemToAnsiBuff*(lpszSrc: LPCSTR, lpszDst: LPSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "OemToCharBuffA".}
proc AnsiUpper*(lpsz: LPSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc: "CharUpperA".}
proc AnsiUpperBuff*(lpsz: LPSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc: "CharUpperBuffA".}
proc AnsiLower*(lpsz: LPSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc: "CharLowerA".}
proc AnsiLowerBuff*(lpsz: LPSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc: "CharLowerBuffA".}
proc AnsiNext*(lpsz: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc: "CharNextA".}
proc AnsiPrev*(lpszStart: LPCSTR, lpszCurrent: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc: "CharPrevA".}
proc IsCharAlphaA*(ch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsCharAlphaW*(ch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsCharAlphaNumericA*(ch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsCharAlphaNumericW*(ch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsCharUpperA*(ch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsCharUpperW*(ch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsCharLowerA*(ch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsCharLowerW*(ch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetFocus*(hWnd: HWND): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetActiveWindow*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetFocus*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKBCodePage*(): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyState*(nVirtKey: int32): SHORT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetAsyncKeyState*(vKey: int32): SHORT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyboardState*(lpKeyState: PBYTE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetKeyboardState*(lpKeyState: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyNameTextA*(lParam: LONG, lpString: LPSTR, cchSize: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyNameTextW*(lParam: LONG, lpString: LPWSTR, cchSize: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetKeyboardType*(nTypeFlag: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc ToAscii*(uVirtKey: UINT, uScanCode: UINT, lpKeyState: ptr BYTE, lpChar: LPWORD, uFlags: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc ToAsciiEx*(uVirtKey: UINT, uScanCode: UINT, lpKeyState: ptr BYTE, lpChar: LPWORD, uFlags: UINT, dwhkl: HKL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc ToUnicode*(wVirtKey: UINT, wScanCode: UINT, lpKeyState: ptr BYTE, pwszBuff: LPWSTR, cchBuff: int32, wFlags: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc OemKeyScan*(wOemChar: WORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc VkKeyScanA*(ch: CHAR): SHORT {.winapi, stdcall, dynlib: "user32", importc.}
proc VkKeyScanW*(ch: WCHAR): SHORT {.winapi, stdcall, dynlib: "user32", importc.}
proc VkKeyScanExA*(ch: CHAR, dwhkl: HKL): SHORT {.winapi, stdcall, dynlib: "user32", importc.}
proc VkKeyScanExW*(ch: WCHAR, dwhkl: HKL): SHORT {.winapi, stdcall, dynlib: "user32", importc.}
proc keybd_event*(bVk: BYTE, bScan: BYTE, dwFlags: DWORD, dwExtraInfo: ULONG_PTR): VOID {.winapi, stdcall, dynlib: "user32", importc.}
proc mouse_event*(dwFlags: DWORD, dx: DWORD, dy: DWORD, dwData: DWORD, dwExtraInfo: ULONG_PTR): VOID {.winapi, stdcall, dynlib: "user32", importc.}
proc SendInput*(cInputs: UINT, pInputs: LPINPUT, cbSize: int32): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetTouchInputInfo*(hTouchInput: HTOUCHINPUT, cInputs: UINT, pInputs: PTOUCHINPUT, cbSize: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CloseTouchInputHandle*(hTouchInput: HTOUCHINPUT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterTouchWindow*(hwnd: HWND, ulFlags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UnregisterTouchWindow*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsTouchWindow*(hwnd: HWND, pulFlags: PULONG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc InitializeTouchInjection*(maxCount: UINT32, dwMode: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc InjectTouchInput*(count: UINT32, contacts: ptr POINTER_TOUCH_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerType*(pointerId: UINT32, pointerType: ptr POINTER_INPUT_TYPE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerCursorId*(pointerId: UINT32, cursorId: ptr UINT32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerInfo*(pointerId: UINT32, pointerInfo: ptr POINTER_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerInfoHistory*(pointerId: UINT32, entriesCount: ptr UINT32, pointerInfo: ptr POINTER_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerFrameInfo*(pointerId: UINT32, pointerCount: ptr UINT32, pointerInfo: ptr POINTER_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerFrameInfoHistory*(pointerId: UINT32, entriesCount: ptr UINT32, pointerCount: ptr UINT32, pointerInfo: ptr POINTER_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerTouchInfo*(pointerId: UINT32, touchInfo: ptr POINTER_TOUCH_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerTouchInfoHistory*(pointerId: UINT32, entriesCount: ptr UINT32, touchInfo: ptr POINTER_TOUCH_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerFrameTouchInfo*(pointerId: UINT32, pointerCount: ptr UINT32, touchInfo: ptr POINTER_TOUCH_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerFrameTouchInfoHistory*(pointerId: UINT32, entriesCount: ptr UINT32, pointerCount: ptr UINT32, touchInfo: ptr POINTER_TOUCH_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerPenInfo*(pointerId: UINT32, penInfo: ptr POINTER_PEN_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerPenInfoHistory*(pointerId: UINT32, entriesCount: ptr UINT32, penInfo: ptr POINTER_PEN_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerFramePenInfo*(pointerId: UINT32, pointerCount: ptr UINT32, penInfo: ptr POINTER_PEN_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerFramePenInfoHistory*(pointerId: UINT32, entriesCount: ptr UINT32, pointerCount: ptr UINT32, penInfo: ptr POINTER_PEN_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SkipPointerFrameMessages*(pointerId: UINT32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterPointerInputTarget*(hwnd: HWND, pointerType: POINTER_INPUT_TYPE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UnregisterPointerInputTarget*(hwnd: HWND, pointerType: POINTER_INPUT_TYPE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnableMouseInPointer*(fEnable: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsMouseInPointerEnabled*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterTouchHitTestingWindow*(hwnd: HWND, value: ULONG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EvaluateProximityToRect*(controlBoundingBox: ptr RECT, pHitTestingInput: ptr TOUCH_HIT_TESTING_INPUT, pProximityEval: ptr TOUCH_HIT_TESTING_PROXIMITY_EVALUATION): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EvaluateProximityToPolygon*(numVertices: UINT32, controlPolygon: ptr POINT, pHitTestingInput: ptr TOUCH_HIT_TESTING_INPUT, pProximityEval: ptr TOUCH_HIT_TESTING_PROXIMITY_EVALUATION): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PackTouchHitTestingProximityEvaluation*(pHitTestingInput: ptr TOUCH_HIT_TESTING_INPUT, pProximityEval: ptr TOUCH_HIT_TESTING_PROXIMITY_EVALUATION): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowFeedbackSetting*(hwnd: HWND, feedback: FEEDBACK_TYPE, dwFlags: DWORD, pSize: ptr UINT32, config: pointer): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowFeedbackSetting*(hwnd: HWND, feedback: FEEDBACK_TYPE, dwFlags: DWORD, size: UINT32, configuration: pointer): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetLastInputInfo*(plii: PLASTINPUTINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc MapVirtualKeyA*(uCode: UINT, uMapType: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc MapVirtualKeyW*(uCode: UINT, uMapType: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc MapVirtualKeyExA*(uCode: UINT, uMapType: UINT, dwhkl: HKL): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc MapVirtualKeyExW*(uCode: UINT, uMapType: UINT, dwhkl: HKL): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetInputState*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetQueueStatus*(flags: UINT): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetCapture*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc SetCapture*(hWnd: HWND): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc ReleaseCapture*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc MsgWaitForMultipleObjects*(nCount: DWORD, pHandles: ptr HANDLE, fWaitAll: WINBOOL, dwMilliseconds: DWORD, dwWakeMask: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc MsgWaitForMultipleObjectsEx*(nCount: DWORD, pHandles: ptr HANDLE, dwMilliseconds: DWORD, dwWakeMask: DWORD, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc SetTimer*(hWnd: HWND, nIDEvent: UINT_PTR, uElapse: UINT, lpTimerFunc: TIMERPROC): UINT_PTR {.winapi, stdcall, dynlib: "user32", importc.}
proc KillTimer*(hWnd: HWND, uIDEvent: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsWindowUnicode*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnableWindow*(hWnd: HWND, bEnable: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsWindowEnabled*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadAcceleratorsA*(hInstance: HINSTANCE, lpTableName: LPCSTR): HACCEL {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadAcceleratorsW*(hInstance: HINSTANCE, lpTableName: LPCWSTR): HACCEL {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateAcceleratorTableA*(paccel: LPACCEL, cAccel: int32): HACCEL {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateAcceleratorTableW*(paccel: LPACCEL, cAccel: int32): HACCEL {.winapi, stdcall, dynlib: "user32", importc.}
proc DestroyAcceleratorTable*(hAccel: HACCEL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CopyAcceleratorTableA*(hAccelSrc: HACCEL, lpAccelDst: LPACCEL, cAccelEntries: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc CopyAcceleratorTableW*(hAccelSrc: HACCEL, lpAccelDst: LPACCEL, cAccelEntries: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc TranslateAcceleratorA*(hWnd: HWND, hAccTable: HACCEL, lpMsg: LPMSG): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc TranslateAcceleratorW*(hWnd: HWND, hAccTable: HACCEL, lpMsg: LPMSG): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc SetCoalescableTimer*(hWnd: HWND, nIDEvent: UINT_PTR, uElapse: UINT, lpTimerFunc: TIMERPROC, uToleranceDelay: ULONG): UINT_PTR {.winapi, stdcall, dynlib: "user32", importc.}
proc GetSystemMetrics*(nIndex: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadMenuA*(hInstance: HINSTANCE, lpMenuName: LPCSTR): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadMenuW*(hInstance: HINSTANCE, lpMenuName: LPCWSTR): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadMenuIndirectA*(lpMenuTemplate: ptr MENUTEMPLATEA): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadMenuIndirectW*(lpMenuTemplate: ptr MENUTEMPLATEW): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenu*(hWnd: HWND): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMenu*(hWnd: HWND, hMenu: HMENU): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeMenuA*(hMenu: HMENU, cmd: UINT, lpszNewItem: LPCSTR, cmdInsert: UINT, flags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeMenuW*(hMenu: HMENU, cmd: UINT, lpszNewItem: LPCWSTR, cmdInsert: UINT, flags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc HiliteMenuItem*(hWnd: HWND, hMenu: HMENU, uIDHiliteItem: UINT, uHilite: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuStringA*(hMenu: HMENU, uIDItem: UINT, lpString: LPSTR, cchMax: int32, flags: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuStringW*(hMenu: HMENU, uIDItem: UINT, lpString: LPWSTR, cchMax: int32, flags: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuState*(hMenu: HMENU, uId: UINT, uFlags: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawMenuBar*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetSystemMenu*(hWnd: HWND, bRevert: WINBOOL): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateMenu*(): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc CreatePopupMenu*(): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc DestroyMenu*(hMenu: HMENU): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CheckMenuItem*(hMenu: HMENU, uIDCheckItem: UINT, uCheck: UINT): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc EnableMenuItem*(hMenu: HMENU, uIDEnableItem: UINT, uEnable: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetSubMenu*(hMenu: HMENU, nPos: int32): HMENU {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuItemID*(hMenu: HMENU, nPos: int32): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuItemCount*(hMenu: HMENU): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc InsertMenuA*(hMenu: HMENU, uPosition: UINT, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc InsertMenuW*(hMenu: HMENU, uPosition: UINT, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc AppendMenuA*(hMenu: HMENU, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc AppendMenuW*(hMenu: HMENU, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ModifyMenuA*(hMnu: HMENU, uPosition: UINT, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ModifyMenuW*(hMnu: HMENU, uPosition: UINT, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RemoveMenu*(hMenu: HMENU, uPosition: UINT, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DeleteMenu*(hMenu: HMENU, uPosition: UINT, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMenuItemBitmaps*(hMenu: HMENU, uPosition: UINT, uFlags: UINT, hBitmapUnchecked: HBITMAP, hBitmapChecked: HBITMAP): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuCheckMarkDimensions*(): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc TrackPopupMenu*(hMenu: HMENU, uFlags: UINT, x: int32, y: int32, nReserved: int32, hWnd: HWND, prcRect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc TrackPopupMenuEx*(P1: HMENU, P2: UINT, P3: int32, P4: int32, P5: HWND, P6: LPTPMPARAMS): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuInfo*(P1: HMENU, P2: LPMENUINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMenuInfo*(P1: HMENU, P2: LPCMENUINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EndMenu*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CalculatePopupWindowPosition*(anchorPoint: ptr POINT, windowSize: ptr SIZE, flags: UINT, excludeRect: ptr RECT, popupWindowPosition: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc InsertMenuItemA*(hmenu: HMENU, item: UINT, fByPosition: WINBOOL, lpmi: LPCMENUITEMINFOA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc InsertMenuItemW*(hmenu: HMENU, item: UINT, fByPosition: WINBOOL, lpmi: LPCMENUITEMINFOW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuItemInfoA*(hmenu: HMENU, item: UINT, fByPosition: WINBOOL, lpmii: LPMENUITEMINFOA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuItemInfoW*(hmenu: HMENU, item: UINT, fByPosition: WINBOOL, lpmii: LPMENUITEMINFOW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMenuItemInfoA*(hmenu: HMENU, item: UINT, fByPositon: WINBOOL, lpmii: LPCMENUITEMINFOA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMenuItemInfoW*(hmenu: HMENU, item: UINT, fByPositon: WINBOOL, lpmii: LPCMENUITEMINFOW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuDefaultItem*(hMenu: HMENU, fByPos: UINT, gmdiFlags: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMenuDefaultItem*(hMenu: HMENU, uItem: UINT, fByPos: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuItemRect*(hWnd: HWND, hMenu: HMENU, uItem: UINT, lprcItem: LPRECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc MenuItemFromPoint*(hWnd: HWND, hMenu: HMENU, ptScreen: POINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DragObject*(hwndParent: HWND, hwndFrom: HWND, fmt: UINT, data: ULONG_PTR, hcur: HCURSOR): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc DragDetect*(hwnd: HWND, pt: POINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawIcon*(hDC: HDC, X: int32, Y: int32, hIcon: HICON): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawTextA*(hdc: HDC, lpchText: LPCSTR, cchText: int32, lprc: LPRECT, format: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawTextW*(hdc: HDC, lpchText: LPCWSTR, cchText: int32, lprc: LPRECT, format: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawTextExA*(hdc: HDC, lpchText: LPSTR, cchText: int32, lprc: LPRECT, format: UINT, lpdtp: LPDRAWTEXTPARAMS): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawTextExW*(hdc: HDC, lpchText: LPWSTR, cchText: int32, lprc: LPRECT, format: UINT, lpdtp: LPDRAWTEXTPARAMS): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GrayStringA*(hDC: HDC, hBrush: HBRUSH, lpOutputFunc: GRAYSTRINGPROC, lpData: LPARAM, nCount: int32, X: int32, Y: int32, nWidth: int32, nHeight: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GrayStringW*(hDC: HDC, hBrush: HBRUSH, lpOutputFunc: GRAYSTRINGPROC, lpData: LPARAM, nCount: int32, X: int32, Y: int32, nWidth: int32, nHeight: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawStateA*(hdc: HDC, hbrFore: HBRUSH, qfnCallBack: DRAWSTATEPROC, lData: LPARAM, wData: WPARAM, x: int32, y: int32, cx: int32, cy: int32, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawStateW*(hdc: HDC, hbrFore: HBRUSH, qfnCallBack: DRAWSTATEPROC, lData: LPARAM, wData: WPARAM, x: int32, y: int32, cx: int32, cy: int32, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc TabbedTextOutA*(hdc: HDC, x: int32, y: int32, lpString: LPCSTR, chCount: int32, nTabPositions: int32, lpnTabStopPositions: ptr INT, nTabOrigin: int32): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc TabbedTextOutW*(hdc: HDC, x: int32, y: int32, lpString: LPCWSTR, chCount: int32, nTabPositions: int32, lpnTabStopPositions: ptr INT, nTabOrigin: int32): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc GetTabbedTextExtentA*(hdc: HDC, lpString: LPCSTR, chCount: int32, nTabPositions: int32, lpnTabStopPositions: ptr INT): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetTabbedTextExtentW*(hdc: HDC, lpString: LPCWSTR, chCount: int32, nTabPositions: int32, lpnTabStopPositions: ptr INT): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc UpdateWindow*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetActiveWindow*(hWnd: HWND): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetForegroundWindow*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc PaintDesktop*(hdc: HDC): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SwitchToThisWindow*(hwnd: HWND, fUnknown: WINBOOL): VOID {.winapi, stdcall, dynlib: "user32", importc.}
proc SetForegroundWindow*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc AllowSetForegroundWindow*(dwProcessId: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc LockSetForegroundWindow*(uLockCode: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc WindowFromDC*(hDC: HDC): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDC*(hWnd: HWND): HDC {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDCEx*(hWnd: HWND, hrgnClip: HRGN, flags: DWORD): HDC {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowDC*(hWnd: HWND): HDC {.winapi, stdcall, dynlib: "user32", importc.}
proc ReleaseDC*(hWnd: HWND, hDC: HDC): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc BeginPaint*(hWnd: HWND, lpPaint: LPPAINTSTRUCT): HDC {.winapi, stdcall, dynlib: "user32", importc.}
proc EndPaint*(hWnd: HWND, lpPaint: ptr PAINTSTRUCT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetUpdateRect*(hWnd: HWND, lpRect: LPRECT, bErase: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetUpdateRgn*(hWnd: HWND, hRgn: HRGN, bErase: WINBOOL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowRgn*(hWnd: HWND, hRgn: HRGN, bRedraw: WINBOOL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowRgn*(hWnd: HWND, hRgn: HRGN): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowRgnBox*(hWnd: HWND, lprc: LPRECT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc ExcludeUpdateRgn*(hDC: HDC, hWnd: HWND): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc InvalidateRect*(hWnd: HWND, lpRect: ptr RECT, bErase: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ValidateRect*(hWnd: HWND, lpRect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc InvalidateRgn*(hWnd: HWND, hRgn: HRGN, bErase: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ValidateRgn*(hWnd: HWND, hRgn: HRGN): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RedrawWindow*(hWnd: HWND, lprcUpdate: ptr RECT, hrgnUpdate: HRGN, flags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc LockWindowUpdate*(hWndLock: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ScrollWindow*(hWnd: HWND, XAmount: int32, YAmount: int32, lpRect: ptr RECT, lpClipRect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ScrollDC*(hDC: HDC, dx: int32, dy: int32, lprcScroll: ptr RECT, lprcClip: ptr RECT, hrgnUpdate: HRGN, lprcUpdate: LPRECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ScrollWindowEx*(hWnd: HWND, dx: int32, dy: int32, prcScroll: ptr RECT, prcClip: ptr RECT, hrgnUpdate: HRGN, prcUpdate: LPRECT, flags: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc SetScrollPos*(hWnd: HWND, nBar: int32, nPos: int32, bRedraw: WINBOOL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetScrollPos*(hWnd: HWND, nBar: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc SetScrollRange*(hWnd: HWND, nBar: int32, nMinPos: int32, nMaxPos: int32, bRedraw: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetScrollRange*(hWnd: HWND, nBar: int32, lpMinPos: LPINT, lpMaxPos: LPINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShowScrollBar*(hWnd: HWND, wBar: int32, bShow: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnableScrollBar*(hWnd: HWND, wSBflags: UINT, wArrows: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetPropA*(hWnd: HWND, lpString: LPCSTR, hData: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetPropW*(hWnd: HWND, lpString: LPCWSTR, hData: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPropA*(hWnd: HWND, lpString: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPropW*(hWnd: HWND, lpString: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc RemovePropA*(hWnd: HWND, lpString: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc RemovePropW*(hWnd: HWND, lpString: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumPropsExA*(hWnd: HWND, lpEnumFunc: PROPENUMPROCEXA, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumPropsExW*(hWnd: HWND, lpEnumFunc: PROPENUMPROCEXW, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumPropsA*(hWnd: HWND, lpEnumFunc: PROPENUMPROCA): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumPropsW*(hWnd: HWND, lpEnumFunc: PROPENUMPROCW): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowTextA*(hWnd: HWND, lpString: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowTextW*(hWnd: HWND, lpString: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowTextA*(hWnd: HWND, lpString: LPSTR, nMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowTextW*(hWnd: HWND, lpString: LPWSTR, nMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowTextLengthA*(hWnd: HWND): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowTextLengthW*(hWnd: HWND): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClientRect*(hWnd: HWND, lpRect: LPRECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowRect*(hWnd: HWND, lpRect: LPRECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc AdjustWindowRect*(lpRect: LPRECT, dwStyle: DWORD, bMenu: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc AdjustWindowRectEx*(lpRect: LPRECT, dwStyle: DWORD, bMenu: WINBOOL, dwExStyle: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowContextHelpId*(P1: HWND, P2: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowContextHelpId*(P1: HWND): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc SetMenuContextHelpId*(P1: HMENU, P2: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuContextHelpId*(P1: HMENU): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc MessageBoxA*(hWnd: HWND, lpText: LPCSTR, lpCaption: LPCSTR, uType: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc MessageBoxW*(hWnd: HWND, lpText: LPCWSTR, lpCaption: LPCWSTR, uType: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc MessageBoxExA*(hWnd: HWND, lpText: LPCSTR, lpCaption: LPCSTR, uType: UINT, wLanguageId: WORD): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc MessageBoxExW*(hWnd: HWND, lpText: LPCWSTR, lpCaption: LPCWSTR, uType: UINT, wLanguageId: WORD): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc MessageBoxIndirectA*(lpmbp: ptr MSGBOXPARAMSA): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc MessageBoxIndirectW*(lpmbp: ptr MSGBOXPARAMSW): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc MessageBeep*(uType: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShowCursor*(bShow: WINBOOL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc SetCursorPos*(X: int32, Y: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetCursor*(hCursor: HCURSOR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc.}
proc GetCursorPos*(lpPoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ClipCursor*(lpRect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClipCursor*(lpRect: LPRECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetCursor*(): HCURSOR {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateCaret*(hWnd: HWND, hBitmap: HBITMAP, nWidth: int32, nHeight: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetCaretBlinkTime*(): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc SetCaretBlinkTime*(uMSeconds: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DestroyCaret*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc HideCaret*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShowCaret*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetCaretPos*(X: int32, Y: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetCaretPos*(lpPoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ClientToScreen*(hWnd: HWND, lpPoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ScreenToClient*(hWnd: HWND, lpPoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc MapWindowPoints*(hWndFrom: HWND, hWndTo: HWND, lpPoints: LPPOINT, cPoints: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc WindowFromPoint*(Point: POINT): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc ChildWindowFromPoint*(hWndParent: HWND, Point: POINT): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc ChildWindowFromPointEx*(hwnd: HWND, pt: POINT, flags: UINT): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc SetPhysicalCursorPos*(X: int32, Y: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPhysicalCursorPos*(lpPoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc LogicalToPhysicalPoint*(hWnd: HWND, lpPoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PhysicalToLogicalPoint*(hWnd: HWND, lpPoint: LPPOINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc WindowFromPhysicalPoint*(Point: POINT): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetSysColor*(nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetSysColorBrush*(nIndex: int32): HBRUSH {.winapi, stdcall, dynlib: "user32", importc.}
proc SetSysColors*(cElements: int32, lpaElements: ptr INT, lpaRgbValues: ptr COLORREF): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawFocusRect*(hDC: HDC, lprc: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc FillRect*(hDC: HDC, lprc: ptr RECT, hbr: HBRUSH): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc FrameRect*(hDC: HDC, lprc: ptr RECT, hbr: HBRUSH): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc InvertRect*(hDC: HDC, lprc: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetRect*(lprc: LPRECT, xLeft: int32, yTop: int32, xRight: int32, yBottom: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetRectEmpty*(lprc: LPRECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CopyRect*(lprcDst: LPRECT, lprcSrc: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc InflateRect*(lprc: LPRECT, dx: int32, dy: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IntersectRect*(lprcDst: LPRECT, lprcSrc1: ptr RECT, lprcSrc2: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UnionRect*(lprcDst: LPRECT, lprcSrc1: ptr RECT, lprcSrc2: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SubtractRect*(lprcDst: LPRECT, lprcSrc1: ptr RECT, lprcSrc2: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc OffsetRect*(lprc: LPRECT, dx: int32, dy: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsRectEmpty*(lprc: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EqualRect*(lprc1: ptr RECT, lprc2: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PtInRect*(lprc: ptr RECT, pt: POINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowWord*(hWnd: HWND, nIndex: int32): WORD {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowWord*(hWnd: HWND, nIndex: int32, wNewWord: WORD): WORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowLongA*(hWnd: HWND, nIndex: int32): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowLongW*(hWnd: HWND, nIndex: int32): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowLongA*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowLongW*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassWord*(hWnd: HWND, nIndex: int32): WORD {.winapi, stdcall, dynlib: "user32", importc.}
proc SetClassWord*(hWnd: HWND, nIndex: int32, wNewWord: WORD): WORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassLongA*(hWnd: HWND, nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassLongW*(hWnd: HWND, nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc SetClassLongA*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc SetClassLongW*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc GetProcessDefaultLayout*(pdwDefaultLayout: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetProcessDefaultLayout*(dwDefaultLayout: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDesktopWindow*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetParent*(hWnd: HWND): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc SetParent*(hWndChild: HWND, hWndNewParent: HWND): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumChildWindows*(hWndParent: HWND, lpEnumFunc: WNDENUMPROC, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc FindWindowA*(lpClassName: LPCSTR, lpWindowName: LPCSTR): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc FindWindowW*(lpClassName: LPCWSTR, lpWindowName: LPCWSTR): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc FindWindowExA*(hWndParent: HWND, hWndChildAfter: HWND, lpszClass: LPCSTR, lpszWindow: LPCSTR): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc FindWindowExW*(hWndParent: HWND, hWndChildAfter: HWND, lpszClass: LPCWSTR, lpszWindow: LPCWSTR): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetShellWindow*(): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterShellHookWindow*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DeregisterShellHookWindow*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumWindows*(lpEnumFunc: WNDENUMPROC, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumThreadWindows*(dwThreadId: DWORD, lpfn: WNDENUMPROC, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassNameA*(hWnd: HWND, lpClassName: LPSTR, nMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetClassNameW*(hWnd: HWND, lpClassName: LPWSTR, nMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetTopWindow*(hWnd: HWND): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowThreadProcessId*(hWnd: HWND, lpdwProcessId: LPDWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc IsGUIThread*(bConvert: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetLastActivePopup*(hWnd: HWND): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindow*(hWnd: HWND, uCmd: UINT): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowsHookA*(nFilterType: int32, pfnFilterProc: HOOKPROC): HHOOK {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowsHookW*(nFilterType: int32, pfnFilterProc: HOOKPROC): HHOOK {.winapi, stdcall, dynlib: "user32", importc.}
proc UnhookWindowsHook*(nCode: int32, pfnFilterProc: HOOKPROC): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowsHookExA*(idHook: int32, lpfn: HOOKPROC, hmod: HINSTANCE, dwThreadId: DWORD): HHOOK {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWindowsHookExW*(idHook: int32, lpfn: HOOKPROC, hmod: HINSTANCE, dwThreadId: DWORD): HHOOK {.winapi, stdcall, dynlib: "user32", importc.}
proc UnhookWindowsHookEx*(hhk: HHOOK): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CallNextHookEx*(hhk: HHOOK, nCode: int32, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc CheckMenuRadioItem*(hmenu: HMENU, first: UINT, last: UINT, check: UINT, flags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadBitmapA*(hInstance: HINSTANCE, lpBitmapName: LPCSTR): HBITMAP {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadBitmapW*(hInstance: HINSTANCE, lpBitmapName: LPCWSTR): HBITMAP {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadCursorA*(hInstance: HINSTANCE, lpCursorName: LPCSTR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadCursorW*(hInstance: HINSTANCE, lpCursorName: LPCWSTR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadCursorFromFileA*(lpFileName: LPCSTR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadCursorFromFileW*(lpFileName: LPCWSTR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateCursor*(hInst: HINSTANCE, xHotSpot: int32, yHotSpot: int32, nWidth: int32, nHeight: int32, pvANDPlane: pointer, pvXORPlane: pointer): HCURSOR {.winapi, stdcall, dynlib: "user32", importc.}
proc DestroyCursor*(hCursor: HCURSOR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetSystemCursor*(hcur: HCURSOR, id: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadIconA*(hInstance: HINSTANCE, lpIconName: LPCSTR): HICON {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadIconW*(hInstance: HINSTANCE, lpIconName: LPCWSTR): HICON {.winapi, stdcall, dynlib: "user32", importc.}
proc PrivateExtractIconsA*(szFileName: LPCSTR, nIconIndex: int32, cxIcon: int32, cyIcon: int32, phicon: ptr HICON, piconid: ptr UINT, nIcons: UINT, flags: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc PrivateExtractIconsW*(szFileName: LPCWSTR, nIconIndex: int32, cxIcon: int32, cyIcon: int32, phicon: ptr HICON, piconid: ptr UINT, nIcons: UINT, flags: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateIcon*(hInstance: HINSTANCE, nWidth: int32, nHeight: int32, cPlanes: BYTE, cBitsPixel: BYTE, lpbANDbits: ptr BYTE, lpbXORbits: ptr BYTE): HICON {.winapi, stdcall, dynlib: "user32", importc.}
proc DestroyIcon*(hIcon: HICON): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc LookupIconIdFromDirectory*(presbits: PBYTE, fIcon: WINBOOL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc LookupIconIdFromDirectoryEx*(presbits: PBYTE, fIcon: WINBOOL, cxDesired: int32, cyDesired: int32, Flags: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateIconFromResource*(presbits: PBYTE, dwResSize: DWORD, fIcon: WINBOOL, dwVer: DWORD): HICON {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateIconFromResourceEx*(presbits: PBYTE, dwResSize: DWORD, fIcon: WINBOOL, dwVer: DWORD, cxDesired: int32, cyDesired: int32, Flags: UINT): HICON {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadImageA*(hInst: HINSTANCE, name: LPCSTR, `type`: UINT, cx: int32, cy: int32, fuLoad: UINT): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadImageW*(hInst: HINSTANCE, name: LPCWSTR, `type`: UINT, cx: int32, cy: int32, fuLoad: UINT): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc CopyImage*(h: HANDLE, `type`: UINT, cx: int32, cy: int32, flags: UINT): HANDLE {.winapi, stdcall, dynlib: "user32", importc.}
proc DrawIconEx*(hdc: HDC, xLeft: int32, yTop: int32, hIcon: HICON, cxWidth: int32, cyWidth: int32, istepIfAniCur: UINT, hbrFlickerFreeDraw: HBRUSH, diFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateIconIndirect*(piconinfo: PICONINFO): HICON {.winapi, stdcall, dynlib: "user32", importc.}
proc CopyIcon*(hIcon: HICON): HICON {.winapi, stdcall, dynlib: "user32", importc.}
proc GetIconInfo*(hIcon: HICON, piconinfo: PICONINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetIconInfoExA*(hicon: HICON, piconinfo: PICONINFOEXA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetIconInfoExW*(hicon: HICON, piconinfo: PICONINFOEXW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsDialogMessageA*(hDlg: HWND, lpMsg: LPMSG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsDialogMessageW*(hDlg: HWND, lpMsg: LPMSG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc MapDialogRect*(hDlg: HWND, lpRect: LPRECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DlgDirListA*(hDlg: HWND, lpPathSpec: LPSTR, nIDListBox: int32, nIDStaticPath: int32, uFileType: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DlgDirListW*(hDlg: HWND, lpPathSpec: LPWSTR, nIDListBox: int32, nIDStaticPath: int32, uFileType: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DlgDirSelectExA*(hwndDlg: HWND, lpString: LPSTR, chCount: int32, idListBox: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DlgDirSelectExW*(hwndDlg: HWND, lpString: LPWSTR, chCount: int32, idListBox: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DlgDirListComboBoxA*(hDlg: HWND, lpPathSpec: LPSTR, nIDComboBox: int32, nIDStaticPath: int32, uFiletype: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DlgDirListComboBoxW*(hDlg: HWND, lpPathSpec: LPWSTR, nIDComboBox: int32, nIDStaticPath: int32, uFiletype: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc DlgDirSelectComboBoxExA*(hwndDlg: HWND, lpString: LPSTR, cchOut: int32, idComboBox: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DlgDirSelectComboBoxExW*(hwndDlg: HWND, lpString: LPWSTR, cchOut: int32, idComboBox: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetScrollInfo*(hwnd: HWND, nBar: int32, lpsi: LPCSCROLLINFO, redraw: WINBOOL): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc GetScrollInfo*(hwnd: HWND, nBar: int32, lpsi: LPSCROLLINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DefFrameProcA*(hWnd: HWND, hWndMDIClient: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc DefFrameProcW*(hWnd: HWND, hWndMDIClient: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc DefMDIChildProcA*(hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc DefMDIChildProcW*(hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc TranslateMDISysAccel*(hWndClient: HWND, lpMsg: LPMSG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ArrangeIconicWindows*(hWnd: HWND): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateMDIWindowA*(lpClassName: LPCSTR, lpWindowName: LPCSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hInstance: HINSTANCE, lParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc CreateMDIWindowW*(lpClassName: LPCWSTR, lpWindowName: LPCWSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hInstance: HINSTANCE, lParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc TileWindows*(hwndParent: HWND, wHow: UINT, lpRect: ptr RECT, cKids: UINT, lpKids: ptr HWND): WORD {.winapi, stdcall, dynlib: "user32", importc.}
proc CascadeWindows*(hwndParent: HWND, wHow: UINT, lpRect: ptr RECT, cKids: UINT, lpKids: ptr HWND): WORD {.winapi, stdcall, dynlib: "user32", importc.}
proc WinHelpA*(hWndMain: HWND, lpszHelp: LPCSTR, uCommand: UINT, dwData: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc WinHelpW*(hWndMain: HWND, lpszHelp: LPCWSTR, uCommand: UINT, dwData: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetGuiResources*(hProcess: HANDLE, uiFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeDisplaySettingsA*(lpDevMode: LPDEVMODEA, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeDisplaySettingsW*(lpDevMode: LPDEVMODEW, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeDisplaySettingsExA*(lpszDeviceName: LPCSTR, lpDevMode: LPDEVMODEA, hwnd: HWND, dwflags: DWORD, lParam: LPVOID): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeDisplaySettingsExW*(lpszDeviceName: LPCWSTR, lpDevMode: LPDEVMODEW, hwnd: HWND, dwflags: DWORD, lParam: LPVOID): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDisplaySettingsA*(lpszDeviceName: LPCSTR, iModeNum: DWORD, lpDevMode: LPDEVMODEA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDisplaySettingsW*(lpszDeviceName: LPCWSTR, iModeNum: DWORD, lpDevMode: LPDEVMODEW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDisplaySettingsExA*(lpszDeviceName: LPCSTR, iModeNum: DWORD, lpDevMode: LPDEVMODEA, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDisplaySettingsExW*(lpszDeviceName: LPCWSTR, iModeNum: DWORD, lpDevMode: LPDEVMODEW, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDisplayDevicesA*(lpDevice: LPCSTR, iDevNum: DWORD, lpDisplayDevice: PDISPLAY_DEVICEA, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDisplayDevicesW*(lpDevice: LPCWSTR, iDevNum: DWORD, lpDisplayDevice: PDISPLAY_DEVICEW, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDisplayConfigBufferSizes*(flags: UINT32, numPathArrayElements: ptr UINT32, numModeInfoArrayElements: ptr UINT32): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc SetDisplayConfig*(numPathArrayElements: UINT32, pathArray: ptr DISPLAYCONFIG_PATH_INFO, numModeInfoArrayElements: UINT32, modeInfoArray: ptr DISPLAYCONFIG_MODE_INFO, flags: UINT32): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc QueryDisplayConfig*(flags: UINT32, numPathArrayElements: ptr UINT32, pathArray: ptr DISPLAYCONFIG_PATH_INFO, numModeInfoArrayElements: ptr UINT32, modeInfoArray: ptr DISPLAYCONFIG_MODE_INFO, currentTopologyId: ptr DISPLAYCONFIG_TOPOLOGY_ID): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc DisplayConfigGetDeviceInfo*(requestPacket: ptr DISPLAYCONFIG_DEVICE_INFO_HEADER): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc DisplayConfigSetDeviceInfo*(setPacket: ptr DISPLAYCONFIG_DEVICE_INFO_HEADER): LONG {.winapi, stdcall, dynlib: "user32", importc.}
proc SystemParametersInfoA*(uiAction: UINT, uiParam: UINT, pvParam: PVOID, fWinIni: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SystemParametersInfoW*(uiAction: UINT, uiParam: UINT, pvParam: PVOID, fWinIni: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetDebugErrorLevel*(dwLevel: DWORD): VOID {.winapi, stdcall, dynlib: "user32", importc.}
proc SetLastErrorEx*(dwErrCode: DWORD, dwType: DWORD): VOID {.winapi, stdcall, dynlib: "user32", importc.}
proc InternalGetWindowText*(hWnd: HWND, pString: LPWSTR, cchMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc CancelShutdown*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc MonitorFromPoint*(pt: POINT, dwFlags: DWORD): HMONITOR {.winapi, stdcall, dynlib: "user32", importc.}
proc MonitorFromRect*(lprc: LPCRECT, dwFlags: DWORD): HMONITOR {.winapi, stdcall, dynlib: "user32", importc.}
proc MonitorFromWindow*(hwnd: HWND, dwFlags: DWORD): HMONITOR {.winapi, stdcall, dynlib: "user32", importc.}
proc EndTask*(hWnd: HWND, fShutDown: WINBOOL, fForce: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SoundSentry*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMonitorInfoA*(hMonitor: HMONITOR, lpmi: LPMONITORINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMonitorInfoW*(hMonitor: HMONITOR, lpmi: LPMONITORINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc EnumDisplayMonitors*(hdc: HDC, lprcClip: LPCRECT, lpfnEnum: MONITORENUMPROC, dwData: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc NotifyWinEvent*(event: DWORD, hwnd: HWND, idObject: LONG, idChild: LONG): VOID {.winapi, stdcall, dynlib: "user32", importc.}
proc SetWinEventHook*(eventMin: DWORD, eventMax: DWORD, hmodWinEventProc: HMODULE, pfnWinEventProc: WINEVENTPROC, idProcess: DWORD, idThread: DWORD, dwFlags: DWORD): HWINEVENTHOOK {.winapi, stdcall, dynlib: "user32", importc.}
proc IsWinEventHookInstalled*(event: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UnhookWinEvent*(hWinEventHook: HWINEVENTHOOK): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetGUIThreadInfo*(idThread: DWORD, pgui: PGUITHREADINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc BlockInput*(fBlockIt: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowModuleFileNameA*(hwnd: HWND, pszFileName: LPSTR, cchFileNameMax: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowModuleFileNameW*(hwnd: HWND, pszFileName: LPWSTR, cchFileNameMax: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc SetProcessDPIAware*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsProcessDPIAware*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetCursorInfo*(pci: PCURSORINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetWindowInfo*(hwnd: HWND, pwi: PWINDOWINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetTitleBarInfo*(hwnd: HWND, pti: PTITLEBARINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetMenuBarInfo*(hwnd: HWND, idObject: LONG, idItem: LONG, pmbi: PMENUBARINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetScrollBarInfo*(hwnd: HWND, idObject: LONG, psbi: PSCROLLBARINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetComboBoxInfo*(hwndCombo: HWND, pcbi: PCOMBOBOXINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetAncestor*(hwnd: HWND, gaFlags: UINT): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc RealChildWindowFromPoint*(hwndParent: HWND, ptParentClientCoords: POINT): HWND {.winapi, stdcall, dynlib: "user32", importc.}
proc RealGetWindowClassA*(hwnd: HWND, ptszClassName: LPSTR, cchClassNameMax: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc RealGetWindowClassW*(hwnd: HWND, ptszClassName: LPWSTR, cchClassNameMax: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetAltTabInfoA*(hwnd: HWND, iItem: int32, pati: PALTTABINFO, pszItemText: LPSTR, cchItemText: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetAltTabInfoW*(hwnd: HWND, iItem: int32, pati: PALTTABINFO, pszItemText: LPWSTR, cchItemText: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetListBoxInfo*(hwnd: HWND): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc LockWorkStation*(): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc UserHandleGrantAccess*(hUserHandle: HANDLE, hJob: HANDLE, bGrant: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetRawInputData*(hRawInput: HRAWINPUT, uiCommand: UINT, pData: LPVOID, pcbSize: PUINT, cbSizeHeader: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetRawInputDeviceInfoA*(hDevice: HANDLE, uiCommand: UINT, pData: LPVOID, pcbSize: PUINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetRawInputDeviceInfoW*(hDevice: HANDLE, uiCommand: UINT, pData: LPVOID, pcbSize: PUINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetRawInputBuffer*(pData: PRAWINPUT, pcbSize: PUINT, cbSizeHeader: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterRawInputDevices*(pRawInputDevices: PCRAWINPUTDEVICE, uiNumDevices: UINT, cbSize: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetRegisteredRawInputDevices*(pRawInputDevices: PRAWINPUTDEVICE, puiNumDevices: PUINT, cbSize: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetRawInputDeviceList*(pRawInputDeviceList: PRAWINPUTDEVICELIST, puiNumDevices: PUINT, cbSize: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc DefRawInputProc*(paRawInput: ptr PRAWINPUT, nInput: INT, cbSizeHeader: UINT): LRESULT {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerDevices*(deviceCount: ptr UINT32, pointerDevices: ptr POINTER_DEVICE_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerDevice*(device: HANDLE, pointerDevice: ptr POINTER_DEVICE_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerDeviceProperties*(device: HANDLE, propertyCount: ptr UINT32, pointerProperties: ptr POINTER_DEVICE_PROPERTY): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc RegisterPointerDeviceNotifications*(window: HWND, notifyRange: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerDeviceRects*(device: HANDLE, pointerDeviceRect: ptr RECT, displayRect: ptr RECT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerDeviceCursors*(device: HANDLE, cursorCount: ptr UINT32, deviceCursors: ptr POINTER_DEVICE_CURSOR_INFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetRawPointerDeviceData*(pointerId: UINT32, historyCount: UINT32, propertiesCount: UINT32, pProperties: ptr POINTER_DEVICE_PROPERTY, pValues: ptr LONG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeWindowMessageFilter*(message: UINT, dwFlag: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ChangeWindowMessageFilterEx*(hwnd: HWND, message: UINT, action: DWORD, pChangeFilterStruct: PCHANGEFILTERSTRUCT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetGestureInfo*(hGestureInfo: HGESTUREINFO, pGestureInfo: PGESTUREINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetGestureExtraArgs*(hGestureInfo: HGESTUREINFO, cbExtraArgs: UINT, pExtraArgs: PBYTE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc CloseGestureInfoHandle*(hGestureInfo: HGESTUREINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetGestureConfig*(hwnd: HWND, dwReserved: DWORD, cIDs: UINT, pGestureConfig: PGESTURECONFIG, cbSize: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetGestureConfig*(hwnd: HWND, dwReserved: DWORD, dwFlags: DWORD, pcIDs: PUINT, pGestureConfig: PGESTURECONFIG, cbSize: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShutdownBlockReasonCreate*(hWnd: HWND, pwszReason: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShutdownBlockReasonQuery*(hWnd: HWND, pwszBuff: LPWSTR, pcchBuff: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ShutdownBlockReasonDestroy*(hWnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetCurrentInputMessageSource*(inputMessageSource: ptr INPUT_MESSAGE_SOURCE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetCIMSSM*(inputMessageSource: ptr INPUT_MESSAGE_SOURCE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetAutoRotationState*(pState: PAR_STATE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetDisplayAutoRotationPreferences*(pOrientation: ptr ORIENTATION_PREFERENCE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetDisplayAutoRotationPreferences*(orientation: ORIENTATION_PREFERENCE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc IsImmersiveProcess*(hProcess: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc SetProcessRestrictionExemption*(fEnableExemption: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc GetPointerInputTransform*(pointerId: UINT32, historyCount: UINT32, inputTransform: ptr UINT32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PostAppMessageA*(idThread: DWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PostThreadMessageA".}
proc PostAppMessageW*(idThread: DWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PostThreadMessageW".}
proc GetNextWindow*(hWnd: HWND, uCmd: UINT): HWND {.winapi, stdcall, dynlib: "user32", importc: "GetWindow".}
proc CopyCursor*(hIcon: HICON): HICON {.winapi, stdcall, dynlib: "user32", importc: "CopyIcon".}
template MAKEINTRESOURCEA*(i: untyped): untyped = cast[LPSTR](i and 0xffff)
template MAKEINTRESOURCEW*(i: untyped): untyped = cast[LPWSTR](i and 0xffff)
template IS_INTRESOURCE*(r: untyped): bool = cast[int](r) shr 16 == 0
template GET_APPCOMMAND_LPARAM*(lParam: untyped): SHORT = cast[SHORT](HIWORD(lParam) and (not WORD FAPPCOMMAND_MASK))
template GET_DEVICE_LPARAM*(lParam: untyped): WORD = HIWORD(lParam) and WORD FAPPCOMMAND_MASK
template GET_MOUSEORKEY_LPARAM*(lParam: untyped): WORD = HIWORD(lParam) and WORD FAPPCOMMAND_MASK
template GET_FLAGS_LPARAM*(lParam: untyped): WORD = LOWORD(lParam)
template GET_KEYSTATE_LPARAM*(lParam: untyped): WORD = LOWORD(lParam)
template POINTSTOPOINT*(pt: POINT, pts: POINTS) = pt.x = pts.x; pt.y = pts.y
template POINTTOPOINTS*(pt: POINT): POINTS = POINTS(x: int16 pt.x, y: int16 pt.y)
template MAKEWPARAM*(l: untyped, h: untyped): WPARAM = WPARAM MAKELONG(l, h)
template MAKELPARAM*(l: untyped, h: untyped): LPARAM = LPARAM MAKELONG(l, h)
template MAKELRESULT*(l: untyped, h: untyped): LRESULT = LRESULT MAKELONG(l, h)
template GET_WHEEL_DELTA_WPARAM*(wParam: untyped): SHORT = cast[SHORT](HIWORD(wParam))
template GET_KEYSTATE_WPARAM*(wParam: untyped): WORD = LOWORD(wParam)
template GET_NCHITTEST_WPARAM*(wParam: untyped): SHORT = cast[SHORT](LOWORD(wParam))
template GET_XBUTTON_WPARAM*(wParam: untyped): WORD = HIWORD(wParam)
template TOUCH_COORD_TO_PIXEL*(L: untyped): LONG = LONG((int L) / 100)
template GET_POINTERID_WPARAM*(wParam: untyped): WORD = LOWORD(wParam)
template IS_POINTER_FLAG_SET_WPARAM*(wParam: untyped, flag: untyped): bool = (DWORD(HIWORD(wParam)) and DWORD flag) == DWORD flag
template IS_POINTER_NEW_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_NEW)
template IS_POINTER_INRANGE_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_INRANGE)
template IS_POINTER_INCONTACT_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_INCONTACT)
template IS_POINTER_FIRSTBUTTON_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_FIRSTBUTTON)
template IS_POINTER_SECONDBUTTON_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_SECONDBUTTON)
template IS_POINTER_THIRDBUTTON_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_THIRDBUTTON)
template IS_POINTER_FOURTHBUTTON_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_FOURTHBUTTON)
template IS_POINTER_FIFTHBUTTON_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_FIFTHBUTTON)
template IS_POINTER_PRIMARY_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_PRIMARY)
template HAS_POINTER_CONFIDENCE_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_CONFIDENCE)
template IS_POINTER_CANCELED_WPARAM*(wParam: untyped): bool = IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_CANCELED)
template GET_RAWINPUT_CODE_WPARAM*(wParam: untyped): WPARAM = WPARAM(wParam and 0xff)
template GET_SC_WPARAM*(wParam: untyped): LONG = LONG(wParam and 0xfff0)
template RIDEV_EXMODE*(mode: untyped): DWORD = DWORD(mode and RIDEV_EXMODEMASK)
template GET_DEVICE_CHANGE_WPARAM*(wParam: untyped): WPARAM = WPARAM(LOWORD(wParam))
template GET_DEVICE_CHANGE_LPARAM*(lParam: untyped): LPARAM = LPARAM(LOWORD(lParam))
template GID_ROTATE_ANGLE_TO_ARGUMENT*(arg: untyped): USHORT = USHORT((arg + 2.0 * 3.14159265) / (4.0 * 3.14159265) * 65535.0)
template GID_ROTATE_ANGLE_FROM_ARGUMENT*(arg: untyped): DOUBLE = (((arg.DOUBLE / 65535.0) * 4.0 * 3.14159265) - 2.0 * 3.14159265)
proc ExitWindows*(dwReserved: DWORD, uReserved: UINT): WINBOOL {.winapi, inline.} = ExitWindowsEx(EWX_LOGOFF, 0xFFFFFFFF'i32)
proc EnumTaskWindows*(hTask: HANDLE, lpfn: WNDENUMPROC, lParam: LPARAM): WINBOOL {.winapi, inline.} = EnumThreadWindows(DWORD hTask, lpfn, lParam)
proc GetWindowTask*(hWnd: HWND): DWORD {.winapi, inline.} = GetWindowThreadProcessId(hWnd, nil)
proc DefHookProc*(nCode: int32, wParam: WPARAM, lParam: LPARAM, phhk: ptr HHOOK): LRESULT {.winapi, inline.} = CallNextHookEx(phhk[], nCode, wParam, lParam)
when winimAnsi:
  proc CreateWindowEx*(dwExStyle: DWORD, lpClassName: LPCSTR, lpWindowName: LPCSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.winapi, stdcall, dynlib: "user32", importc: "CreateWindowExA".}
proc CreateWindowA*(lpClassName: LPCSTR, lpWindowName: LPCSTR, dwStyle: DWORD, x: int32, y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.winapi, inline.} = CreateWindowExA(0, lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam)
when winimUnicode:
  proc CreateWindowEx*(dwExStyle: DWORD, lpClassName: LPCWSTR, lpWindowName: LPCWSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.winapi, stdcall, dynlib: "user32", importc: "CreateWindowExW".}
proc CreateWindowW*(lpClassName: LPCWSTR, lpWindowName: LPCWSTR, dwStyle: DWORD, x: int32, y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.winapi, inline.} = CreateWindowExW(0, lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam)
when winimAnsi:
  proc CreateDialogParam*(hInstance: HINSTANCE, lpTemplateName: LPCSTR, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc: "CreateDialogParamA".}
proc CreateDialogA*(hInstance: HINSTANCE, lpName: LPCSTR, hWndParent: HWND, lpDialogFunc: DLGPROC): HWND {.winapi, inline.} = CreateDialogParamA(hInstance, lpName, hWndParent, lpDialogFunc, 0)
when winimUnicode:
  proc CreateDialogParam*(hInstance: HINSTANCE, lpTemplateName: LPCWSTR, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc: "CreateDialogParamW".}
proc CreateDialogW*(hInstance: HINSTANCE, lpName: LPCWSTR, hWndParent: HWND, lpDialogFunc: DLGPROC): HWND {.winapi, inline.} = CreateDialogParamW(hInstance, lpName, hWndParent, lpDialogFunc, 0)
when winimAnsi:
  proc CreateDialogIndirectParam*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEA, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc: "CreateDialogIndirectParamA".}
proc CreateDialogIndirectA*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEA, hWndParent: HWND, lpDialogFunc: DLGPROC): HWND {.winapi, inline.} = CreateDialogIndirectParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
when winimUnicode:
  proc CreateDialogIndirectParam*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEW, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc: "CreateDialogIndirectParamW".}
proc CreateDialogIndirectW*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEW, hWndParent: HWND, lpDialogFunc: DLGPROC): HWND {.winapi, inline.} = CreateDialogIndirectParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
when winimAnsi:
  proc DialogBoxParam*(hInstance: HINSTANCE, lpTemplateName: LPCSTR, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): INT_PTR {.winapi, stdcall, dynlib: "user32", importc: "DialogBoxParamA".}
proc DialogBoxA*(hInstance: HINSTANCE, lpTemplate: LPCSTR, hWndParent: HWND, lpDialogFunc: DLGPROC): INT_PTR {.winapi, inline.} = DialogBoxParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
when winimUnicode:
  proc DialogBoxParam*(hInstance: HINSTANCE, lpTemplateName: LPCWSTR, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): INT_PTR {.winapi, stdcall, dynlib: "user32", importc: "DialogBoxParamW".}
proc DialogBoxW*(hInstance: HINSTANCE, lpTemplate: LPCWSTR, hWndParent: HWND, lpDialogFunc: DLGPROC): INT_PTR {.winapi, inline.} = DialogBoxParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
when winimAnsi:
  proc DialogBoxIndirectParam*(hInstance: HINSTANCE, hDialogTemplate: LPCDLGTEMPLATEA, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): INT_PTR {.winapi, stdcall, dynlib: "user32", importc: "DialogBoxIndirectParamA".}
proc DialogBoxIndirectA*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEA, hWndParent: HWND, lpDialogFunc: DLGPROC): INT_PTR {.winapi, inline.} = DialogBoxIndirectParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
when winimUnicode:
  proc DialogBoxIndirectParam*(hInstance: HINSTANCE, hDialogTemplate: LPCDLGTEMPLATEW, hWndParent: HWND, lpDialogFunc: DLGPROC, dwInitParam: LPARAM): INT_PTR {.winapi, stdcall, dynlib: "user32", importc: "DialogBoxIndirectParamW".}
proc DialogBoxIndirectW*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEW, hWndParent: HWND, lpDialogFunc: DLGPROC): INT_PTR {.winapi, inline.} = DialogBoxIndirectParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
proc `mi=`*(self: var INPUT, x: MOUSEINPUT) {.inline.} = self.union1.mi = x
proc mi*(self: INPUT): MOUSEINPUT {.inline.} = self.union1.mi
proc mi*(self: var INPUT): var MOUSEINPUT {.inline.} = self.union1.mi
proc `ki=`*(self: var INPUT, x: KEYBDINPUT) {.inline.} = self.union1.ki = x
proc ki*(self: INPUT): KEYBDINPUT {.inline.} = self.union1.ki
proc ki*(self: var INPUT): var KEYBDINPUT {.inline.} = self.union1.ki
proc `hi=`*(self: var INPUT, x: HARDWAREINPUT) {.inline.} = self.union1.hi = x
proc hi*(self: INPUT): HARDWAREINPUT {.inline.} = self.union1.hi
proc hi*(self: var INPUT): var HARDWAREINPUT {.inline.} = self.union1.hi
proc `cbSize=`*(self: var MONITORINFOEXA, x: DWORD) {.inline.} = self.struct1.cbSize = x
proc cbSize*(self: MONITORINFOEXA): DWORD {.inline.} = self.struct1.cbSize
proc cbSize*(self: var MONITORINFOEXA): var DWORD {.inline.} = self.struct1.cbSize
proc `rcMonitor=`*(self: var MONITORINFOEXA, x: RECT) {.inline.} = self.struct1.rcMonitor = x
proc rcMonitor*(self: MONITORINFOEXA): RECT {.inline.} = self.struct1.rcMonitor
proc rcMonitor*(self: var MONITORINFOEXA): var RECT {.inline.} = self.struct1.rcMonitor
proc `rcWork=`*(self: var MONITORINFOEXA, x: RECT) {.inline.} = self.struct1.rcWork = x
proc rcWork*(self: MONITORINFOEXA): RECT {.inline.} = self.struct1.rcWork
proc rcWork*(self: var MONITORINFOEXA): var RECT {.inline.} = self.struct1.rcWork
proc `dwFlags=`*(self: var MONITORINFOEXA, x: DWORD) {.inline.} = self.struct1.dwFlags = x
proc dwFlags*(self: MONITORINFOEXA): DWORD {.inline.} = self.struct1.dwFlags
proc dwFlags*(self: var MONITORINFOEXA): var DWORD {.inline.} = self.struct1.dwFlags
proc `cbSize=`*(self: var MONITORINFOEXW, x: DWORD) {.inline.} = self.struct1.cbSize = x
proc cbSize*(self: MONITORINFOEXW): DWORD {.inline.} = self.struct1.cbSize
proc cbSize*(self: var MONITORINFOEXW): var DWORD {.inline.} = self.struct1.cbSize
proc `rcMonitor=`*(self: var MONITORINFOEXW, x: RECT) {.inline.} = self.struct1.rcMonitor = x
proc rcMonitor*(self: MONITORINFOEXW): RECT {.inline.} = self.struct1.rcMonitor
proc rcMonitor*(self: var MONITORINFOEXW): var RECT {.inline.} = self.struct1.rcMonitor
proc `rcWork=`*(self: var MONITORINFOEXW, x: RECT) {.inline.} = self.struct1.rcWork = x
proc rcWork*(self: MONITORINFOEXW): RECT {.inline.} = self.struct1.rcWork
proc rcWork*(self: var MONITORINFOEXW): var RECT {.inline.} = self.struct1.rcWork
proc `dwFlags=`*(self: var MONITORINFOEXW, x: DWORD) {.inline.} = self.struct1.dwFlags = x
proc dwFlags*(self: MONITORINFOEXW): DWORD {.inline.} = self.struct1.dwFlags
proc dwFlags*(self: var MONITORINFOEXW): var DWORD {.inline.} = self.struct1.dwFlags
proc `ulButtons=`*(self: var RAWMOUSE, x: ULONG) {.inline.} = self.union1.ulButtons = x
proc ulButtons*(self: RAWMOUSE): ULONG {.inline.} = self.union1.ulButtons
proc ulButtons*(self: var RAWMOUSE): var ULONG {.inline.} = self.union1.ulButtons
proc `usButtonFlags=`*(self: var RAWMOUSE, x: USHORT) {.inline.} = self.union1.struct1.usButtonFlags = x
proc usButtonFlags*(self: RAWMOUSE): USHORT {.inline.} = self.union1.struct1.usButtonFlags
proc usButtonFlags*(self: var RAWMOUSE): var USHORT {.inline.} = self.union1.struct1.usButtonFlags
proc `usButtonData=`*(self: var RAWMOUSE, x: USHORT) {.inline.} = self.union1.struct1.usButtonData = x
proc usButtonData*(self: RAWMOUSE): USHORT {.inline.} = self.union1.struct1.usButtonData
proc usButtonData*(self: var RAWMOUSE): var USHORT {.inline.} = self.union1.struct1.usButtonData
proc `mouse=`*(self: var RID_DEVICE_INFO, x: RID_DEVICE_INFO_MOUSE) {.inline.} = self.union1.mouse = x
proc mouse*(self: RID_DEVICE_INFO): RID_DEVICE_INFO_MOUSE {.inline.} = self.union1.mouse
proc mouse*(self: var RID_DEVICE_INFO): var RID_DEVICE_INFO_MOUSE {.inline.} = self.union1.mouse
proc `keyboard=`*(self: var RID_DEVICE_INFO, x: RID_DEVICE_INFO_KEYBOARD) {.inline.} = self.union1.keyboard = x
proc keyboard*(self: RID_DEVICE_INFO): RID_DEVICE_INFO_KEYBOARD {.inline.} = self.union1.keyboard
proc keyboard*(self: var RID_DEVICE_INFO): var RID_DEVICE_INFO_KEYBOARD {.inline.} = self.union1.keyboard
proc `hid=`*(self: var RID_DEVICE_INFO, x: RID_DEVICE_INFO_HID) {.inline.} = self.union1.hid = x
proc hid*(self: RID_DEVICE_INFO): RID_DEVICE_INFO_HID {.inline.} = self.union1.hid
proc hid*(self: var RID_DEVICE_INFO): var RID_DEVICE_INFO_HID {.inline.} = self.union1.hid
proc `m11=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m11 = x
proc m11*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m11
proc m11*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m11
proc `m12=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m12 = x
proc m12*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m12
proc m12*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m12
proc `m13=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m13 = x
proc m13*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m13
proc m13*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m13
proc `m14=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m14 = x
proc m14*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m14
proc m14*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m14
proc `m21=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m21 = x
proc m21*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m21
proc m21*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m21
proc `m22=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m22 = x
proc m22*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m22
proc m22*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m22
proc `m23=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m23 = x
proc m23*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m23
proc m23*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m23
proc `m24=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m24 = x
proc m24*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m24
proc m24*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m24
proc `m31=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m31 = x
proc m31*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m31
proc m31*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m31
proc `m32=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m32 = x
proc m32*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m32
proc m32*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m32
proc `m33=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m33 = x
proc m33*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m33
proc m33*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m33
proc `m34=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m34 = x
proc m34*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m34
proc m34*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m34
proc `m41=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m41 = x
proc m41*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m41
proc m41*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m41
proc `m42=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m42 = x
proc m42*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m42
proc m42*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m42
proc `m43=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m43 = x
proc m43*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m43
proc m43*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m43
proc `m44=`*(self: var INPUT_TRANSFORM, x: float32) {.inline.} = self.union1.struct1.m44 = x
proc m44*(self: INPUT_TRANSFORM): float32 {.inline.} = self.union1.struct1.m44
proc m44*(self: var INPUT_TRANSFORM): var float32 {.inline.} = self.union1.struct1.m44
proc `m=`*(self: var INPUT_TRANSFORM, x: array[4, array[4, float32]]) {.inline.} = self.union1.m = x
proc m*(self: INPUT_TRANSFORM): array[4, array[4, float32]] {.inline.} = self.union1.m
proc m*(self: var INPUT_TRANSFORM): var array[4, array[4, float32]] {.inline.} = self.union1.m
when winimUnicode:
  type
    MENUTEMPLATE* = MENUTEMPLATEW
    LPMENUTEMPLATE* = LPMENUTEMPLATEW
    PROPENUMPROC* = PROPENUMPROCW
    PROPENUMPROCEX* = PROPENUMPROCEXW
    EDITWORDBREAKPROC* = EDITWORDBREAKPROCW
    WINSTAENUMPROC* = WINSTAENUMPROCW
    DESKTOPENUMPROC* = DESKTOPENUMPROCW
    CBT_CREATEWND* = CBT_CREATEWNDW
    LPCBT_CREATEWND* = LPCBT_CREATEWNDW
    WNDCLASSEX* = WNDCLASSEXW
    PWNDCLASSEX* = PWNDCLASSEXW
    NPWNDCLASSEX* = NPWNDCLASSEXW
    LPWNDCLASSEX* = LPWNDCLASSEXW
    WNDCLASS* = WNDCLASSW
    PWNDCLASS* = PWNDCLASSW
    NPWNDCLASS* = NPWNDCLASSW
    LPWNDCLASS* = LPWNDCLASSW
    CREATESTRUCT* = CREATESTRUCTW
    LPCREATESTRUCT* = LPCREATESTRUCTW
    LPDLGTEMPLATE* = LPDLGTEMPLATEW
    LPCDLGTEMPLATE* = LPCDLGTEMPLATEW
    PDLGITEMTEMPLATE* = PDLGITEMTEMPLATEW
    LPDLGITEMTEMPLATE* = LPDLGITEMTEMPLATEW
    MENUITEMINFO* = MENUITEMINFOW
    LPMENUITEMINFO* = LPMENUITEMINFOW
    LPCMENUITEMINFO* = LPCMENUITEMINFOW
    MSGBOXPARAMS* = MSGBOXPARAMSW
    PMSGBOXPARAMS* = PMSGBOXPARAMSW
    LPMSGBOXPARAMS* = LPMSGBOXPARAMSW
    ICONINFOEX* = ICONINFOEXW
    PICONINFOEX* = PICONINFOEXW
    MDICREATESTRUCT* = MDICREATESTRUCTW
    LPMDICREATESTRUCT* = LPMDICREATESTRUCTW
    MULTIKEYHELP* = MULTIKEYHELPW
    PMULTIKEYHELP* = PMULTIKEYHELPW
    LPMULTIKEYHELP* = LPMULTIKEYHELPW
    HELPWININFO* = HELPWININFOW
    PHELPWININFO* = PHELPWININFOW
    LPHELPWININFO* = LPHELPWININFOW
    NONCLIENTMETRICS* = NONCLIENTMETRICSW
    PNONCLIENTMETRICS* = PNONCLIENTMETRICSW
    LPNONCLIENTMETRICS* = LPNONCLIENTMETRICSW
    ICONMETRICS* = ICONMETRICSW
    PICONMETRICS* = PICONMETRICSW
    LPICONMETRICS* = LPICONMETRICSW
    SERIALKEYS* = SERIALKEYSW
    LPSERIALKEYS* = LPSERIALKEYSW
    HIGHCONTRAST* = HIGHCONTRASTW
    LPHIGHCONTRAST* = LPHIGHCONTRASTW
    TSOUNDSENTRY* = SOUNDSENTRYW
    LPSOUNDSENTRY* = LPSOUNDSENTRYW
    MONITORINFOEX* = MONITORINFOEXW
    LPMONITORINFOEX* = LPMONITORINFOEXW
  proc wvsprintf*(P1: LPWSTR, P2: LPCWSTR, arglist: va_list): int32 {.winapi, stdcall, dynlib: "user32", importc: "wvsprintfW".}
  proc wsprintf*(P1: LPWSTR, P2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "user32", importc: "wsprintfW".}
  proc LoadKeyboardLayout*(pwszKLID: LPCWSTR, Flags: UINT): HKL {.winapi, stdcall, dynlib: "user32", importc: "LoadKeyboardLayoutW".}
  proc GetKeyboardLayoutName*(pwszKLID: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetKeyboardLayoutNameW".}
  proc CreateDesktop*(lpszDesktop: LPCWSTR, lpszDevice: LPCWSTR, pDevmode: LPDEVMODEW, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES): HDESK {.winapi, stdcall, dynlib: "user32", importc: "CreateDesktopW".}
  proc CreateDesktopEx*(lpszDesktop: LPCWSTR, lpszDevice: LPCWSTR, pDevmode: ptr DEVMODEW, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES, ulHeapSize: ULONG, pvoid: PVOID): HDESK {.winapi, stdcall, dynlib: "user32", importc: "CreateDesktopExW".}
  proc OpenDesktop*(lpszDesktop: LPCWSTR, dwFlags: DWORD, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HDESK {.winapi, stdcall, dynlib: "user32", importc: "OpenDesktopW".}
  proc EnumDesktops*(hwinsta: HWINSTA, lpEnumFunc: DESKTOPENUMPROCW, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumDesktopsW".}
  proc CreateWindowStation*(lpwinsta: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES): HWINSTA {.winapi, stdcall, dynlib: "user32", importc: "CreateWindowStationW".}
  proc OpenWindowStation*(lpszWinSta: LPCWSTR, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HWINSTA {.winapi, stdcall, dynlib: "user32", importc: "OpenWindowStationW".}
  proc EnumWindowStations*(lpEnumFunc: WINSTAENUMPROCW, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumWindowStationsW".}
  proc GetUserObjectInformation*(hObj: HANDLE, nIndex: int32, pvInfo: PVOID, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetUserObjectInformationW".}
  proc SetUserObjectInformation*(hObj: HANDLE, nIndex: int32, pvInfo: PVOID, nLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetUserObjectInformationW".}
  proc RegisterWindowMessage*(lpString: LPCWSTR): UINT {.winapi, stdcall, dynlib: "user32", importc: "RegisterWindowMessageW".}
  proc GetMessage*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetMessageW".}
  proc DispatchMessage*(lpMsg: ptr MSG): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DispatchMessageW".}
  proc PeekMessage*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PeekMessageW".}
  proc SendMessage*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "SendMessageW".}
  proc SendMessageTimeout*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, fuFlags: UINT, uTimeout: UINT, lpdwResult: PDWORD_PTR): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "SendMessageTimeoutW".}
  proc SendNotifyMessage*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SendNotifyMessageW".}
  proc SendMessageCallback*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, lpResultCallBack: SENDASYNCPROC, dwData: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SendMessageCallbackW".}
  proc BroadcastSystemMessageEx*(flags: DWORD, lpInfo: LPDWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM, pbsmInfo: PBSMINFO): LONG32 {.winapi, stdcall, dynlib: "user32", importc: "BroadcastSystemMessageExW".}
  proc BroadcastSystemMessage*(flags: DWORD, lpInfo: LPDWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LONG32 {.winapi, stdcall, dynlib: "user32", importc: "BroadcastSystemMessageW".}
  proc RegisterDeviceNotification*(hRecipient: HANDLE, NotificationFilter: LPVOID, Flags: DWORD): HDEVNOTIFY {.winapi, stdcall, dynlib: "user32", importc: "RegisterDeviceNotificationW".}
  proc PostMessage*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PostMessageW".}
  proc PostThreadMessage*(idThread: DWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PostThreadMessageW".}
  proc DefWindowProc*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DefWindowProcW".}
  proc CallWindowProc*(lpPrevWndFunc: WNDPROC, hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "CallWindowProcW".}
  proc RegisterClass*(lpWndClass: ptr WNDCLASSW): ATOM {.winapi, stdcall, dynlib: "user32", importc: "RegisterClassW".}
  proc UnregisterClass*(lpClassName: LPCWSTR, hInstance: HINSTANCE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "UnregisterClassW".}
  proc GetClassInfo*(hInstance: HINSTANCE, lpClassName: LPCWSTR, lpWndClass: LPWNDCLASSW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetClassInfoW".}
  proc RegisterClassEx*(P1: ptr WNDCLASSEXW): ATOM {.winapi, stdcall, dynlib: "user32", importc: "RegisterClassExW".}
  proc GetClassInfoEx*(hInstance: HINSTANCE, lpszClass: LPCWSTR, lpwcx: LPWNDCLASSEXW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetClassInfoExW".}
  proc SetDlgItemText*(hDlg: HWND, nIDDlgItem: int32, lpString: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetDlgItemTextW".}
  proc GetDlgItemText*(hDlg: HWND, nIDDlgItem: int32, lpString: LPWSTR, cchMax: int32): UINT {.winapi, stdcall, dynlib: "user32", importc: "GetDlgItemTextW".}
  proc SendDlgItemMessage*(hDlg: HWND, nIDDlgItem: int32, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "SendDlgItemMessageW".}
  proc DefDlgProc*(hDlg: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DefDlgProcW".}
  proc CallMsgFilter*(lpMsg: LPMSG, nCode: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "CallMsgFilterW".}
  proc RegisterClipboardFormat*(lpszFormat: LPCWSTR): UINT {.winapi, stdcall, dynlib: "user32", importc: "RegisterClipboardFormatW".}
  proc GetClipboardFormatName*(format: UINT, lpszFormatName: LPWSTR, cchMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetClipboardFormatNameW".}
  proc CharToOem*(lpszSrc: LPCWSTR, lpszDst: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "CharToOemW".}
  proc OemToChar*(lpszSrc: LPCSTR, lpszDst: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "OemToCharW".}
  proc CharToOemBuff*(lpszSrc: LPCWSTR, lpszDst: LPSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "CharToOemBuffW".}
  proc OemToCharBuff*(lpszSrc: LPCSTR, lpszDst: LPWSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "OemToCharBuffW".}
  proc CharUpper*(lpsz: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "user32", importc: "CharUpperW".}
  proc CharUpperBuff*(lpsz: LPWSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc: "CharUpperBuffW".}
  proc CharLower*(lpsz: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "user32", importc: "CharLowerW".}
  proc CharLowerBuff*(lpsz: LPWSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc: "CharLowerBuffW".}
  proc CharNext*(lpsz: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "user32", importc: "CharNextW".}
  proc CharPrev*(lpszStart: LPCWSTR, lpszCurrent: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "user32", importc: "CharPrevW".}
  proc IsCharAlpha*(ch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsCharAlphaW".}
  proc IsCharAlphaNumeric*(ch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsCharAlphaNumericW".}
  proc IsCharUpper*(ch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsCharUpperW".}
  proc IsCharLower*(ch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsCharLowerW".}
  proc GetKeyNameText*(lParam: LONG, lpString: LPWSTR, cchSize: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetKeyNameTextW".}
  proc VkKeyScan*(ch: WCHAR): SHORT {.winapi, stdcall, dynlib: "user32", importc: "VkKeyScanW".}
  proc VkKeyScanEx*(ch: WCHAR, dwhkl: HKL): SHORT {.winapi, stdcall, dynlib: "user32", importc: "VkKeyScanExW".}
  proc MapVirtualKey*(uCode: UINT, uMapType: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "MapVirtualKeyW".}
  proc MapVirtualKeyEx*(uCode: UINT, uMapType: UINT, dwhkl: HKL): UINT {.winapi, stdcall, dynlib: "user32", importc: "MapVirtualKeyExW".}
  proc LoadAccelerators*(hInstance: HINSTANCE, lpTableName: LPCWSTR): HACCEL {.winapi, stdcall, dynlib: "user32", importc: "LoadAcceleratorsW".}
  proc CreateAcceleratorTable*(paccel: LPACCEL, cAccel: int32): HACCEL {.winapi, stdcall, dynlib: "user32", importc: "CreateAcceleratorTableW".}
  proc CopyAcceleratorTable*(hAccelSrc: HACCEL, lpAccelDst: LPACCEL, cAccelEntries: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "CopyAcceleratorTableW".}
  proc TranslateAccelerator*(hWnd: HWND, hAccTable: HACCEL, lpMsg: LPMSG): int32 {.winapi, stdcall, dynlib: "user32", importc: "TranslateAcceleratorW".}
  proc LoadMenu*(hInstance: HINSTANCE, lpMenuName: LPCWSTR): HMENU {.winapi, stdcall, dynlib: "user32", importc: "LoadMenuW".}
  proc LoadMenuIndirect*(lpMenuTemplate: ptr MENUTEMPLATEW): HMENU {.winapi, stdcall, dynlib: "user32", importc: "LoadMenuIndirectW".}
  proc ChangeMenu*(hMenu: HMENU, cmd: UINT, lpszNewItem: LPCWSTR, cmdInsert: UINT, flags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "ChangeMenuW".}
  proc GetMenuString*(hMenu: HMENU, uIDItem: UINT, lpString: LPWSTR, cchMax: int32, flags: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetMenuStringW".}
  proc InsertMenu*(hMenu: HMENU, uPosition: UINT, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "InsertMenuW".}
  proc AppendMenu*(hMenu: HMENU, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "AppendMenuW".}
  proc ModifyMenu*(hMnu: HMENU, uPosition: UINT, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "ModifyMenuW".}
  proc InsertMenuItem*(hmenu: HMENU, item: UINT, fByPosition: WINBOOL, lpmi: LPCMENUITEMINFOW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "InsertMenuItemW".}
  proc GetMenuItemInfo*(hmenu: HMENU, item: UINT, fByPosition: WINBOOL, lpmii: LPMENUITEMINFOW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetMenuItemInfoW".}
  proc SetMenuItemInfo*(hmenu: HMENU, item: UINT, fByPositon: WINBOOL, lpmii: LPCMENUITEMINFOW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetMenuItemInfoW".}
  proc DrawText*(hdc: HDC, lpchText: LPCWSTR, cchText: int32, lprc: LPRECT, format: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "DrawTextW".}
  proc DrawTextEx*(hdc: HDC, lpchText: LPWSTR, cchText: int32, lprc: LPRECT, format: UINT, lpdtp: LPDRAWTEXTPARAMS): int32 {.winapi, stdcall, dynlib: "user32", importc: "DrawTextExW".}
  proc GrayString*(hDC: HDC, hBrush: HBRUSH, lpOutputFunc: GRAYSTRINGPROC, lpData: LPARAM, nCount: int32, X: int32, Y: int32, nWidth: int32, nHeight: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GrayStringW".}
  proc DrawState*(hdc: HDC, hbrFore: HBRUSH, qfnCallBack: DRAWSTATEPROC, lData: LPARAM, wData: WPARAM, x: int32, y: int32, cx: int32, cy: int32, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "DrawStateW".}
  proc TabbedTextOut*(hdc: HDC, x: int32, y: int32, lpString: LPCWSTR, chCount: int32, nTabPositions: int32, lpnTabStopPositions: ptr INT, nTabOrigin: int32): LONG {.winapi, stdcall, dynlib: "user32", importc: "TabbedTextOutW".}
  proc GetTabbedTextExtent*(hdc: HDC, lpString: LPCWSTR, chCount: int32, nTabPositions: int32, lpnTabStopPositions: ptr INT): DWORD {.winapi, stdcall, dynlib: "user32", importc: "GetTabbedTextExtentW".}
  proc SetProp*(hWnd: HWND, lpString: LPCWSTR, hData: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetPropW".}
  proc GetProp*(hWnd: HWND, lpString: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "user32", importc: "GetPropW".}
  proc RemoveProp*(hWnd: HWND, lpString: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "user32", importc: "RemovePropW".}
  proc EnumPropsEx*(hWnd: HWND, lpEnumFunc: PROPENUMPROCEXW, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "user32", importc: "EnumPropsExW".}
  proc EnumProps*(hWnd: HWND, lpEnumFunc: PROPENUMPROCW): int32 {.winapi, stdcall, dynlib: "user32", importc: "EnumPropsW".}
  proc SetWindowText*(hWnd: HWND, lpString: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetWindowTextW".}
  proc GetWindowText*(hWnd: HWND, lpString: LPWSTR, nMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetWindowTextW".}
  proc GetWindowTextLength*(hWnd: HWND): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetWindowTextLengthW".}
  proc MessageBox*(hWnd: HWND, lpText: LPCWSTR, lpCaption: LPCWSTR, uType: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "MessageBoxW".}
  proc MessageBoxEx*(hWnd: HWND, lpText: LPCWSTR, lpCaption: LPCWSTR, uType: UINT, wLanguageId: WORD): int32 {.winapi, stdcall, dynlib: "user32", importc: "MessageBoxExW".}
  proc MessageBoxIndirect*(lpmbp: ptr MSGBOXPARAMSW): int32 {.winapi, stdcall, dynlib: "user32", importc: "MessageBoxIndirectW".}
  proc GetWindowLong*(hWnd: HWND, nIndex: int32): LONG {.winapi, stdcall, dynlib: "user32", importc: "GetWindowLongW".}
  proc SetWindowLong*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): LONG {.winapi, stdcall, dynlib: "user32", importc: "SetWindowLongW".}
  proc GetClassLong*(hWnd: HWND, nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc: "GetClassLongW".}
  proc SetClassLong*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): DWORD {.winapi, stdcall, dynlib: "user32", importc: "SetClassLongW".}
  proc FindWindow*(lpClassName: LPCWSTR, lpWindowName: LPCWSTR): HWND {.winapi, stdcall, dynlib: "user32", importc: "FindWindowW".}
  proc FindWindowEx*(hWndParent: HWND, hWndChildAfter: HWND, lpszClass: LPCWSTR, lpszWindow: LPCWSTR): HWND {.winapi, stdcall, dynlib: "user32", importc: "FindWindowExW".}
  proc GetClassName*(hWnd: HWND, lpClassName: LPWSTR, nMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetClassNameW".}
  proc SetWindowsHook*(nFilterType: int32, pfnFilterProc: HOOKPROC): HHOOK {.winapi, stdcall, dynlib: "user32", importc: "SetWindowsHookW".}
  proc SetWindowsHookEx*(idHook: int32, lpfn: HOOKPROC, hmod: HINSTANCE, dwThreadId: DWORD): HHOOK {.winapi, stdcall, dynlib: "user32", importc: "SetWindowsHookExW".}
  proc LoadBitmap*(hInstance: HINSTANCE, lpBitmapName: LPCWSTR): HBITMAP {.winapi, stdcall, dynlib: "user32", importc: "LoadBitmapW".}
  proc LoadCursor*(hInstance: HINSTANCE, lpCursorName: LPCWSTR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc: "LoadCursorW".}
  proc LoadCursorFromFile*(lpFileName: LPCWSTR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc: "LoadCursorFromFileW".}
  proc LoadIcon*(hInstance: HINSTANCE, lpIconName: LPCWSTR): HICON {.winapi, stdcall, dynlib: "user32", importc: "LoadIconW".}
  proc PrivateExtractIcons*(szFileName: LPCWSTR, nIconIndex: int32, cxIcon: int32, cyIcon: int32, phicon: ptr HICON, piconid: ptr UINT, nIcons: UINT, flags: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "PrivateExtractIconsW".}
  proc LoadImage*(hInst: HINSTANCE, name: LPCWSTR, `type`: UINT, cx: int32, cy: int32, fuLoad: UINT): HANDLE {.winapi, stdcall, dynlib: "user32", importc: "LoadImageW".}
  proc GetIconInfoEx*(hicon: HICON, piconinfo: PICONINFOEXW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetIconInfoExW".}
  proc IsDialogMessage*(hDlg: HWND, lpMsg: LPMSG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsDialogMessageW".}
  proc DlgDirList*(hDlg: HWND, lpPathSpec: LPWSTR, nIDListBox: int32, nIDStaticPath: int32, uFileType: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "DlgDirListW".}
  proc DlgDirSelectEx*(hwndDlg: HWND, lpString: LPWSTR, chCount: int32, idListBox: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "DlgDirSelectExW".}
  proc DlgDirListComboBox*(hDlg: HWND, lpPathSpec: LPWSTR, nIDComboBox: int32, nIDStaticPath: int32, uFiletype: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "DlgDirListComboBoxW".}
  proc DlgDirSelectComboBoxEx*(hwndDlg: HWND, lpString: LPWSTR, cchOut: int32, idComboBox: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "DlgDirSelectComboBoxExW".}
  proc DefFrameProc*(hWnd: HWND, hWndMDIClient: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DefFrameProcW".}
  proc DefMDIChildProc*(hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DefMDIChildProcW".}
  proc CreateMDIWindow*(lpClassName: LPCWSTR, lpWindowName: LPCWSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hInstance: HINSTANCE, lParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc: "CreateMDIWindowW".}
  proc WinHelp*(hWndMain: HWND, lpszHelp: LPCWSTR, uCommand: UINT, dwData: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "WinHelpW".}
  proc ChangeDisplaySettings*(lpDevMode: LPDEVMODEW, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "user32", importc: "ChangeDisplaySettingsW".}
  proc ChangeDisplaySettingsEx*(lpszDeviceName: LPCWSTR, lpDevMode: LPDEVMODEW, hwnd: HWND, dwflags: DWORD, lParam: LPVOID): LONG {.winapi, stdcall, dynlib: "user32", importc: "ChangeDisplaySettingsExW".}
  proc EnumDisplaySettings*(lpszDeviceName: LPCWSTR, iModeNum: DWORD, lpDevMode: LPDEVMODEW): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumDisplaySettingsW".}
  proc EnumDisplaySettingsEx*(lpszDeviceName: LPCWSTR, iModeNum: DWORD, lpDevMode: LPDEVMODEW, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumDisplaySettingsExW".}
  proc EnumDisplayDevices*(lpDevice: LPCWSTR, iDevNum: DWORD, lpDisplayDevice: PDISPLAY_DEVICEW, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumDisplayDevicesW".}
  proc SystemParametersInfo*(uiAction: UINT, uiParam: UINT, pvParam: PVOID, fWinIni: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SystemParametersInfoW".}
  proc GetMonitorInfo*(hMonitor: HMONITOR, lpmi: LPMONITORINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetMonitorInfoW".}
  proc GetWindowModuleFileName*(hwnd: HWND, pszFileName: LPWSTR, cchFileNameMax: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "GetWindowModuleFileNameW".}
  proc RealGetWindowClass*(hwnd: HWND, ptszClassName: LPWSTR, cchClassNameMax: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "RealGetWindowClassW".}
  proc GetAltTabInfo*(hwnd: HWND, iItem: int32, pati: PALTTABINFO, pszItemText: LPWSTR, cchItemText: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetAltTabInfoW".}
  proc GetRawInputDeviceInfo*(hDevice: HANDLE, uiCommand: UINT, pData: LPVOID, pcbSize: PUINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "GetRawInputDeviceInfoW".}
  proc PostAppMessage*(idThread: DWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PostThreadMessageW".}
  proc CreateWindow*(lpClassName: LPCWSTR, lpWindowName: LPCWSTR, dwStyle: DWORD, x: int32, y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.winapi, inline.} = CreateWindowExW(0, lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam)
  proc CreateDialog*(hInstance: HINSTANCE, lpName: LPCWSTR, hWndParent: HWND, lpDialogFunc: DLGPROC): HWND {.winapi, inline.} = CreateDialogParamW(hInstance, lpName, hWndParent, lpDialogFunc, 0)
  proc CreateDialogIndirect*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEW, hWndParent: HWND, lpDialogFunc: DLGPROC): HWND {.winapi, inline.} = CreateDialogIndirectParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
  proc DialogBox*(hInstance: HINSTANCE, lpTemplate: LPCWSTR, hWndParent: HWND, lpDialogFunc: DLGPROC): INT_PTR {.winapi, inline.} = DialogBoxParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
  proc DialogBoxIndirect*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEW, hWndParent: HWND, lpDialogFunc: DLGPROC): INT_PTR {.winapi, inline.} = DialogBoxIndirectParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
when winimAnsi:
  type
    MENUTEMPLATE* = MENUTEMPLATEA
    LPMENUTEMPLATE* = LPMENUTEMPLATEA
    PROPENUMPROC* = PROPENUMPROCA
    PROPENUMPROCEX* = PROPENUMPROCEXA
    EDITWORDBREAKPROC* = EDITWORDBREAKPROCA
    WINSTAENUMPROC* = WINSTAENUMPROCA
    DESKTOPENUMPROC* = DESKTOPENUMPROCA
    CBT_CREATEWND* = CBT_CREATEWNDA
    LPCBT_CREATEWND* = LPCBT_CREATEWNDA
    WNDCLASSEX* = WNDCLASSEXA
    PWNDCLASSEX* = PWNDCLASSEXA
    NPWNDCLASSEX* = NPWNDCLASSEXA
    LPWNDCLASSEX* = LPWNDCLASSEXA
    WNDCLASS* = WNDCLASSA
    PWNDCLASS* = PWNDCLASSA
    NPWNDCLASS* = NPWNDCLASSA
    LPWNDCLASS* = LPWNDCLASSA
    CREATESTRUCT* = CREATESTRUCTA
    LPCREATESTRUCT* = LPCREATESTRUCTA
    LPDLGTEMPLATE* = LPDLGTEMPLATEA
    LPCDLGTEMPLATE* = LPCDLGTEMPLATEA
    PDLGITEMTEMPLATE* = PDLGITEMTEMPLATEA
    LPDLGITEMTEMPLATE* = LPDLGITEMTEMPLATEA
    MENUITEMINFO* = MENUITEMINFOA
    LPMENUITEMINFO* = LPMENUITEMINFOA
    LPCMENUITEMINFO* = LPCMENUITEMINFOA
    MSGBOXPARAMS* = MSGBOXPARAMSA
    PMSGBOXPARAMS* = PMSGBOXPARAMSA
    LPMSGBOXPARAMS* = LPMSGBOXPARAMSA
    ICONINFOEX* = ICONINFOEXA
    PICONINFOEX* = PICONINFOEXA
    MDICREATESTRUCT* = MDICREATESTRUCTA
    LPMDICREATESTRUCT* = LPMDICREATESTRUCTA
    MULTIKEYHELP* = MULTIKEYHELPA
    PMULTIKEYHELP* = PMULTIKEYHELPA
    LPMULTIKEYHELP* = LPMULTIKEYHELPA
    HELPWININFO* = HELPWININFOA
    PHELPWININFO* = PHELPWININFOA
    LPHELPWININFO* = LPHELPWININFOA
    NONCLIENTMETRICS* = NONCLIENTMETRICSA
    PNONCLIENTMETRICS* = PNONCLIENTMETRICSA
    LPNONCLIENTMETRICS* = LPNONCLIENTMETRICSA
    ICONMETRICS* = ICONMETRICSA
    PICONMETRICS* = PICONMETRICSA
    LPICONMETRICS* = LPICONMETRICSA
    SERIALKEYS* = SERIALKEYSA
    LPSERIALKEYS* = LPSERIALKEYSA
    HIGHCONTRAST* = HIGHCONTRASTA
    LPHIGHCONTRAST* = LPHIGHCONTRASTA
    TSOUNDSENTRY* = SOUNDSENTRYA
    LPSOUNDSENTRY* = LPSOUNDSENTRYA
    MONITORINFOEX* = MONITORINFOEXA
    LPMONITORINFOEX* = LPMONITORINFOEXA
  proc wvsprintf*(P1: LPSTR, P2: LPCSTR, arglist: va_list): int32 {.winapi, stdcall, dynlib: "user32", importc: "wvsprintfA".}
  proc wsprintf*(P1: LPSTR, P2: LPCSTR): int32 {.winapi, stdcall, dynlib: "user32", importc: "wsprintfA".}
  proc LoadKeyboardLayout*(pwszKLID: LPCSTR, Flags: UINT): HKL {.winapi, stdcall, dynlib: "user32", importc: "LoadKeyboardLayoutA".}
  proc GetKeyboardLayoutName*(pwszKLID: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetKeyboardLayoutNameA".}
  proc CreateDesktop*(lpszDesktop: LPCSTR, lpszDevice: LPCSTR, pDevmode: LPDEVMODEA, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES): HDESK {.winapi, stdcall, dynlib: "user32", importc: "CreateDesktopA".}
  proc CreateDesktopEx*(lpszDesktop: LPCSTR, lpszDevice: LPCSTR, pDevmode: ptr DEVMODEA, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES, ulHeapSize: ULONG, pvoid: PVOID): HDESK {.winapi, stdcall, dynlib: "user32", importc: "CreateDesktopExA".}
  proc OpenDesktop*(lpszDesktop: LPCSTR, dwFlags: DWORD, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HDESK {.winapi, stdcall, dynlib: "user32", importc: "OpenDesktopA".}
  proc EnumDesktops*(hwinsta: HWINSTA, lpEnumFunc: DESKTOPENUMPROCA, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumDesktopsA".}
  proc CreateWindowStation*(lpwinsta: LPCSTR, dwFlags: DWORD, dwDesiredAccess: ACCESS_MASK, lpsa: LPSECURITY_ATTRIBUTES): HWINSTA {.winapi, stdcall, dynlib: "user32", importc: "CreateWindowStationA".}
  proc OpenWindowStation*(lpszWinSta: LPCSTR, fInherit: WINBOOL, dwDesiredAccess: ACCESS_MASK): HWINSTA {.winapi, stdcall, dynlib: "user32", importc: "OpenWindowStationA".}
  proc EnumWindowStations*(lpEnumFunc: WINSTAENUMPROCA, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumWindowStationsA".}
  proc GetUserObjectInformation*(hObj: HANDLE, nIndex: int32, pvInfo: PVOID, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetUserObjectInformationA".}
  proc SetUserObjectInformation*(hObj: HANDLE, nIndex: int32, pvInfo: PVOID, nLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetUserObjectInformationA".}
  proc RegisterWindowMessage*(lpString: LPCSTR): UINT {.winapi, stdcall, dynlib: "user32", importc: "RegisterWindowMessageA".}
  proc GetMessage*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetMessageA".}
  proc DispatchMessage*(lpMsg: ptr MSG): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DispatchMessageA".}
  proc PeekMessage*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: UINT, wMsgFilterMax: UINT, wRemoveMsg: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PeekMessageA".}
  proc SendMessage*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "SendMessageA".}
  proc SendMessageTimeout*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, fuFlags: UINT, uTimeout: UINT, lpdwResult: PDWORD_PTR): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "SendMessageTimeoutA".}
  proc SendNotifyMessage*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SendNotifyMessageA".}
  proc SendMessageCallback*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM, lpResultCallBack: SENDASYNCPROC, dwData: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SendMessageCallbackA".}
  proc BroadcastSystemMessageEx*(flags: DWORD, lpInfo: LPDWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM, pbsmInfo: PBSMINFO): LONG32 {.winapi, stdcall, dynlib: "user32", importc: "BroadcastSystemMessageExA".}
  proc BroadcastSystemMessage*(flags: DWORD, lpInfo: LPDWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LONG32 {.winapi, stdcall, dynlib: "user32", importc: "BroadcastSystemMessageA".}
  proc RegisterDeviceNotification*(hRecipient: HANDLE, NotificationFilter: LPVOID, Flags: DWORD): HDEVNOTIFY {.winapi, stdcall, dynlib: "user32", importc: "RegisterDeviceNotificationA".}
  proc PostMessage*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PostMessageA".}
  proc PostThreadMessage*(idThread: DWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PostThreadMessageA".}
  proc DefWindowProc*(hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DefWindowProcA".}
  proc CallWindowProc*(lpPrevWndFunc: WNDPROC, hWnd: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "CallWindowProcA".}
  proc RegisterClass*(lpWndClass: ptr WNDCLASSA): ATOM {.winapi, stdcall, dynlib: "user32", importc: "RegisterClassA".}
  proc UnregisterClass*(lpClassName: LPCSTR, hInstance: HINSTANCE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "UnregisterClassA".}
  proc GetClassInfo*(hInstance: HINSTANCE, lpClassName: LPCSTR, lpWndClass: LPWNDCLASSA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetClassInfoA".}
  proc RegisterClassEx*(P1: ptr WNDCLASSEXA): ATOM {.winapi, stdcall, dynlib: "user32", importc: "RegisterClassExA".}
  proc GetClassInfoEx*(hInstance: HINSTANCE, lpszClass: LPCSTR, lpwcx: LPWNDCLASSEXA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetClassInfoExA".}
  proc SetDlgItemText*(hDlg: HWND, nIDDlgItem: int32, lpString: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetDlgItemTextA".}
  proc GetDlgItemText*(hDlg: HWND, nIDDlgItem: int32, lpString: LPSTR, cchMax: int32): UINT {.winapi, stdcall, dynlib: "user32", importc: "GetDlgItemTextA".}
  proc SendDlgItemMessage*(hDlg: HWND, nIDDlgItem: int32, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "SendDlgItemMessageA".}
  proc DefDlgProc*(hDlg: HWND, Msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DefDlgProcA".}
  proc CallMsgFilter*(lpMsg: LPMSG, nCode: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "CallMsgFilterA".}
  proc RegisterClipboardFormat*(lpszFormat: LPCSTR): UINT {.winapi, stdcall, dynlib: "user32", importc: "RegisterClipboardFormatA".}
  proc GetClipboardFormatName*(format: UINT, lpszFormatName: LPSTR, cchMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetClipboardFormatNameA".}
  proc CharToOem*(lpszSrc: LPCSTR, lpszDst: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "CharToOemA".}
  proc OemToChar*(lpszSrc: LPCSTR, lpszDst: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "OemToCharA".}
  proc CharToOemBuff*(lpszSrc: LPCSTR, lpszDst: LPSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "CharToOemBuffA".}
  proc OemToCharBuff*(lpszSrc: LPCSTR, lpszDst: LPSTR, cchDstLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "OemToCharBuffA".}
  proc CharUpper*(lpsz: LPSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc: "CharUpperA".}
  proc CharUpperBuff*(lpsz: LPSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc: "CharUpperBuffA".}
  proc CharLower*(lpsz: LPSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc: "CharLowerA".}
  proc CharLowerBuff*(lpsz: LPSTR, cchLength: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc: "CharLowerBuffA".}
  proc CharNext*(lpsz: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc: "CharNextA".}
  proc CharPrev*(lpszStart: LPCSTR, lpszCurrent: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "user32", importc: "CharPrevA".}
  proc IsCharAlpha*(ch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsCharAlphaA".}
  proc IsCharAlphaNumeric*(ch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsCharAlphaNumericA".}
  proc IsCharUpper*(ch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsCharUpperA".}
  proc IsCharLower*(ch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsCharLowerA".}
  proc GetKeyNameText*(lParam: LONG, lpString: LPSTR, cchSize: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetKeyNameTextA".}
  proc VkKeyScan*(ch: CHAR): SHORT {.winapi, stdcall, dynlib: "user32", importc: "VkKeyScanA".}
  proc VkKeyScanEx*(ch: CHAR, dwhkl: HKL): SHORT {.winapi, stdcall, dynlib: "user32", importc: "VkKeyScanExA".}
  proc MapVirtualKey*(uCode: UINT, uMapType: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "MapVirtualKeyA".}
  proc MapVirtualKeyEx*(uCode: UINT, uMapType: UINT, dwhkl: HKL): UINT {.winapi, stdcall, dynlib: "user32", importc: "MapVirtualKeyExA".}
  proc LoadAccelerators*(hInstance: HINSTANCE, lpTableName: LPCSTR): HACCEL {.winapi, stdcall, dynlib: "user32", importc: "LoadAcceleratorsA".}
  proc CreateAcceleratorTable*(paccel: LPACCEL, cAccel: int32): HACCEL {.winapi, stdcall, dynlib: "user32", importc: "CreateAcceleratorTableA".}
  proc CopyAcceleratorTable*(hAccelSrc: HACCEL, lpAccelDst: LPACCEL, cAccelEntries: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "CopyAcceleratorTableA".}
  proc TranslateAccelerator*(hWnd: HWND, hAccTable: HACCEL, lpMsg: LPMSG): int32 {.winapi, stdcall, dynlib: "user32", importc: "TranslateAcceleratorA".}
  proc LoadMenu*(hInstance: HINSTANCE, lpMenuName: LPCSTR): HMENU {.winapi, stdcall, dynlib: "user32", importc: "LoadMenuA".}
  proc LoadMenuIndirect*(lpMenuTemplate: ptr MENUTEMPLATEA): HMENU {.winapi, stdcall, dynlib: "user32", importc: "LoadMenuIndirectA".}
  proc ChangeMenu*(hMenu: HMENU, cmd: UINT, lpszNewItem: LPCSTR, cmdInsert: UINT, flags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "ChangeMenuA".}
  proc GetMenuString*(hMenu: HMENU, uIDItem: UINT, lpString: LPSTR, cchMax: int32, flags: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetMenuStringA".}
  proc InsertMenu*(hMenu: HMENU, uPosition: UINT, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "InsertMenuA".}
  proc AppendMenu*(hMenu: HMENU, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "AppendMenuA".}
  proc ModifyMenu*(hMnu: HMENU, uPosition: UINT, uFlags: UINT, uIDNewItem: UINT_PTR, lpNewItem: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "ModifyMenuA".}
  proc InsertMenuItem*(hmenu: HMENU, item: UINT, fByPosition: WINBOOL, lpmi: LPCMENUITEMINFOA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "InsertMenuItemA".}
  proc GetMenuItemInfo*(hmenu: HMENU, item: UINT, fByPosition: WINBOOL, lpmii: LPMENUITEMINFOA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetMenuItemInfoA".}
  proc SetMenuItemInfo*(hmenu: HMENU, item: UINT, fByPositon: WINBOOL, lpmii: LPCMENUITEMINFOA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetMenuItemInfoA".}
  proc DrawText*(hdc: HDC, lpchText: LPCSTR, cchText: int32, lprc: LPRECT, format: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "DrawTextA".}
  proc DrawTextEx*(hdc: HDC, lpchText: LPSTR, cchText: int32, lprc: LPRECT, format: UINT, lpdtp: LPDRAWTEXTPARAMS): int32 {.winapi, stdcall, dynlib: "user32", importc: "DrawTextExA".}
  proc GrayString*(hDC: HDC, hBrush: HBRUSH, lpOutputFunc: GRAYSTRINGPROC, lpData: LPARAM, nCount: int32, X: int32, Y: int32, nWidth: int32, nHeight: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GrayStringA".}
  proc DrawState*(hdc: HDC, hbrFore: HBRUSH, qfnCallBack: DRAWSTATEPROC, lData: LPARAM, wData: WPARAM, x: int32, y: int32, cx: int32, cy: int32, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "DrawStateA".}
  proc TabbedTextOut*(hdc: HDC, x: int32, y: int32, lpString: LPCSTR, chCount: int32, nTabPositions: int32, lpnTabStopPositions: ptr INT, nTabOrigin: int32): LONG {.winapi, stdcall, dynlib: "user32", importc: "TabbedTextOutA".}
  proc GetTabbedTextExtent*(hdc: HDC, lpString: LPCSTR, chCount: int32, nTabPositions: int32, lpnTabStopPositions: ptr INT): DWORD {.winapi, stdcall, dynlib: "user32", importc: "GetTabbedTextExtentA".}
  proc SetProp*(hWnd: HWND, lpString: LPCSTR, hData: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetPropA".}
  proc GetProp*(hWnd: HWND, lpString: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "user32", importc: "GetPropA".}
  proc RemoveProp*(hWnd: HWND, lpString: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "user32", importc: "RemovePropA".}
  proc EnumPropsEx*(hWnd: HWND, lpEnumFunc: PROPENUMPROCEXA, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "user32", importc: "EnumPropsExA".}
  proc EnumProps*(hWnd: HWND, lpEnumFunc: PROPENUMPROCA): int32 {.winapi, stdcall, dynlib: "user32", importc: "EnumPropsA".}
  proc SetWindowText*(hWnd: HWND, lpString: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SetWindowTextA".}
  proc GetWindowText*(hWnd: HWND, lpString: LPSTR, nMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetWindowTextA".}
  proc GetWindowTextLength*(hWnd: HWND): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetWindowTextLengthA".}
  proc MessageBox*(hWnd: HWND, lpText: LPCSTR, lpCaption: LPCSTR, uType: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "MessageBoxA".}
  proc MessageBoxEx*(hWnd: HWND, lpText: LPCSTR, lpCaption: LPCSTR, uType: UINT, wLanguageId: WORD): int32 {.winapi, stdcall, dynlib: "user32", importc: "MessageBoxExA".}
  proc MessageBoxIndirect*(lpmbp: ptr MSGBOXPARAMSA): int32 {.winapi, stdcall, dynlib: "user32", importc: "MessageBoxIndirectA".}
  proc GetWindowLong*(hWnd: HWND, nIndex: int32): LONG {.winapi, stdcall, dynlib: "user32", importc: "GetWindowLongA".}
  proc SetWindowLong*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): LONG {.winapi, stdcall, dynlib: "user32", importc: "SetWindowLongA".}
  proc GetClassLong*(hWnd: HWND, nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc: "GetClassLongA".}
  proc SetClassLong*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): DWORD {.winapi, stdcall, dynlib: "user32", importc: "SetClassLongA".}
  proc FindWindow*(lpClassName: LPCSTR, lpWindowName: LPCSTR): HWND {.winapi, stdcall, dynlib: "user32", importc: "FindWindowA".}
  proc FindWindowEx*(hWndParent: HWND, hWndChildAfter: HWND, lpszClass: LPCSTR, lpszWindow: LPCSTR): HWND {.winapi, stdcall, dynlib: "user32", importc: "FindWindowExA".}
  proc GetClassName*(hWnd: HWND, lpClassName: LPSTR, nMaxCount: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "GetClassNameA".}
  proc SetWindowsHook*(nFilterType: int32, pfnFilterProc: HOOKPROC): HHOOK {.winapi, stdcall, dynlib: "user32", importc: "SetWindowsHookA".}
  proc SetWindowsHookEx*(idHook: int32, lpfn: HOOKPROC, hmod: HINSTANCE, dwThreadId: DWORD): HHOOK {.winapi, stdcall, dynlib: "user32", importc: "SetWindowsHookExA".}
  proc LoadBitmap*(hInstance: HINSTANCE, lpBitmapName: LPCSTR): HBITMAP {.winapi, stdcall, dynlib: "user32", importc: "LoadBitmapA".}
  proc LoadCursor*(hInstance: HINSTANCE, lpCursorName: LPCSTR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc: "LoadCursorA".}
  proc LoadCursorFromFile*(lpFileName: LPCSTR): HCURSOR {.winapi, stdcall, dynlib: "user32", importc: "LoadCursorFromFileA".}
  proc LoadIcon*(hInstance: HINSTANCE, lpIconName: LPCSTR): HICON {.winapi, stdcall, dynlib: "user32", importc: "LoadIconA".}
  proc PrivateExtractIcons*(szFileName: LPCSTR, nIconIndex: int32, cxIcon: int32, cyIcon: int32, phicon: ptr HICON, piconid: ptr UINT, nIcons: UINT, flags: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "PrivateExtractIconsA".}
  proc LoadImage*(hInst: HINSTANCE, name: LPCSTR, `type`: UINT, cx: int32, cy: int32, fuLoad: UINT): HANDLE {.winapi, stdcall, dynlib: "user32", importc: "LoadImageA".}
  proc GetIconInfoEx*(hicon: HICON, piconinfo: PICONINFOEXA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetIconInfoExA".}
  proc IsDialogMessage*(hDlg: HWND, lpMsg: LPMSG): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "IsDialogMessageA".}
  proc DlgDirList*(hDlg: HWND, lpPathSpec: LPSTR, nIDListBox: int32, nIDStaticPath: int32, uFileType: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "DlgDirListA".}
  proc DlgDirSelectEx*(hwndDlg: HWND, lpString: LPSTR, chCount: int32, idListBox: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "DlgDirSelectExA".}
  proc DlgDirListComboBox*(hDlg: HWND, lpPathSpec: LPSTR, nIDComboBox: int32, nIDStaticPath: int32, uFiletype: UINT): int32 {.winapi, stdcall, dynlib: "user32", importc: "DlgDirListComboBoxA".}
  proc DlgDirSelectComboBoxEx*(hwndDlg: HWND, lpString: LPSTR, cchOut: int32, idComboBox: int32): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "DlgDirSelectComboBoxExA".}
  proc DefFrameProc*(hWnd: HWND, hWndMDIClient: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DefFrameProcA".}
  proc DefMDIChildProc*(hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "user32", importc: "DefMDIChildProcA".}
  proc CreateMDIWindow*(lpClassName: LPCSTR, lpWindowName: LPCSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hInstance: HINSTANCE, lParam: LPARAM): HWND {.winapi, stdcall, dynlib: "user32", importc: "CreateMDIWindowA".}
  proc WinHelp*(hWndMain: HWND, lpszHelp: LPCSTR, uCommand: UINT, dwData: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "WinHelpA".}
  proc ChangeDisplaySettings*(lpDevMode: LPDEVMODEA, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "user32", importc: "ChangeDisplaySettingsA".}
  proc ChangeDisplaySettingsEx*(lpszDeviceName: LPCSTR, lpDevMode: LPDEVMODEA, hwnd: HWND, dwflags: DWORD, lParam: LPVOID): LONG {.winapi, stdcall, dynlib: "user32", importc: "ChangeDisplaySettingsExA".}
  proc EnumDisplaySettings*(lpszDeviceName: LPCSTR, iModeNum: DWORD, lpDevMode: LPDEVMODEA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumDisplaySettingsA".}
  proc EnumDisplaySettingsEx*(lpszDeviceName: LPCSTR, iModeNum: DWORD, lpDevMode: LPDEVMODEA, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumDisplaySettingsExA".}
  proc EnumDisplayDevices*(lpDevice: LPCSTR, iDevNum: DWORD, lpDisplayDevice: PDISPLAY_DEVICEA, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "EnumDisplayDevicesA".}
  proc SystemParametersInfo*(uiAction: UINT, uiParam: UINT, pvParam: PVOID, fWinIni: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "SystemParametersInfoA".}
  proc GetMonitorInfo*(hMonitor: HMONITOR, lpmi: LPMONITORINFO): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetMonitorInfoA".}
  proc GetWindowModuleFileName*(hwnd: HWND, pszFileName: LPSTR, cchFileNameMax: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "GetWindowModuleFileNameA".}
  proc RealGetWindowClass*(hwnd: HWND, ptszClassName: LPSTR, cchClassNameMax: UINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "RealGetWindowClassA".}
  proc GetAltTabInfo*(hwnd: HWND, iItem: int32, pati: PALTTABINFO, pszItemText: LPSTR, cchItemText: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "GetAltTabInfoA".}
  proc GetRawInputDeviceInfo*(hDevice: HANDLE, uiCommand: UINT, pData: LPVOID, pcbSize: PUINT): UINT {.winapi, stdcall, dynlib: "user32", importc: "GetRawInputDeviceInfoA".}
  proc PostAppMessage*(idThread: DWORD, Msg: UINT, wParam: WPARAM, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc: "PostThreadMessageA".}
  proc CreateWindow*(lpClassName: LPCSTR, lpWindowName: LPCSTR, dwStyle: DWORD, x: int32, y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.winapi, inline.} = CreateWindowExA(0, lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam)
  proc CreateDialog*(hInstance: HINSTANCE, lpName: LPCSTR, hWndParent: HWND, lpDialogFunc: DLGPROC): HWND {.winapi, inline.} = CreateDialogParamA(hInstance, lpName, hWndParent, lpDialogFunc, 0)
  proc CreateDialogIndirect*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEA, hWndParent: HWND, lpDialogFunc: DLGPROC): HWND {.winapi, inline.} = CreateDialogIndirectParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
  proc DialogBox*(hInstance: HINSTANCE, lpTemplate: LPCSTR, hWndParent: HWND, lpDialogFunc: DLGPROC): INT_PTR {.winapi, inline.} = DialogBoxParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
  proc DialogBoxIndirect*(hInstance: HINSTANCE, lpTemplate: LPCDLGTEMPLATEA, hWndParent: HWND, lpDialogFunc: DLGPROC): INT_PTR {.winapi, inline.} = DialogBoxIndirectParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, 0)
when winimCpu64:
  const
    CONSOLE_APPLICATION_16BIT* = 0x0000
    GUI_16BITTASK* = 0x00000000
  proc GetWindowLongPtrA*(hWnd: HWND, nIndex: int32): LONG_PTR {.winapi, stdcall, dynlib: "user32", importc.}
  proc GetWindowLongPtrW*(hWnd: HWND, nIndex: int32): LONG_PTR {.winapi, stdcall, dynlib: "user32", importc.}
  proc SetWindowLongPtrA*(hWnd: HWND, nIndex: int32, dwNewLong: LONG_PTR): LONG_PTR {.winapi, stdcall, dynlib: "user32", importc.}
  proc SetWindowLongPtrW*(hWnd: HWND, nIndex: int32, dwNewLong: LONG_PTR): LONG_PTR {.winapi, stdcall, dynlib: "user32", importc.}
  proc GetClassLongPtrA*(hWnd: HWND, nIndex: int32): ULONG_PTR {.winapi, stdcall, dynlib: "user32", importc.}
  proc GetClassLongPtrW*(hWnd: HWND, nIndex: int32): ULONG_PTR {.winapi, stdcall, dynlib: "user32", importc.}
  proc SetClassLongPtrA*(hWnd: HWND, nIndex: int32, dwNewLong: LONG_PTR): ULONG_PTR {.winapi, stdcall, dynlib: "user32", importc.}
  proc SetClassLongPtrW*(hWnd: HWND, nIndex: int32, dwNewLong: LONG_PTR): ULONG_PTR {.winapi, stdcall, dynlib: "user32", importc.}
when winimUnicode and winimCpu64:
  proc GetWindowLongPtr*(hWnd: HWND, nIndex: int32): LONG_PTR {.winapi, stdcall, dynlib: "user32", importc: "GetWindowLongPtrW".}
  proc SetWindowLongPtr*(hWnd: HWND, nIndex: int32, dwNewLong: LONG_PTR): LONG_PTR {.winapi, stdcall, dynlib: "user32", importc: "SetWindowLongPtrW".}
  proc GetClassLongPtr*(hWnd: HWND, nIndex: int32): ULONG_PTR {.winapi, stdcall, dynlib: "user32", importc: "GetClassLongPtrW".}
  proc SetClassLongPtr*(hWnd: HWND, nIndex: int32, dwNewLong: LONG_PTR): ULONG_PTR {.winapi, stdcall, dynlib: "user32", importc: "SetClassLongPtrW".}
when winimAnsi and winimCpu64:
  proc GetWindowLongPtr*(hWnd: HWND, nIndex: int32): LONG_PTR {.winapi, stdcall, dynlib: "user32", importc: "GetWindowLongPtrA".}
  proc SetWindowLongPtr*(hWnd: HWND, nIndex: int32, dwNewLong: LONG_PTR): LONG_PTR {.winapi, stdcall, dynlib: "user32", importc: "SetWindowLongPtrA".}
  proc GetClassLongPtr*(hWnd: HWND, nIndex: int32): ULONG_PTR {.winapi, stdcall, dynlib: "user32", importc: "GetClassLongPtrA".}
  proc SetClassLongPtr*(hWnd: HWND, nIndex: int32, dwNewLong: LONG_PTR): ULONG_PTR {.winapi, stdcall, dynlib: "user32", importc: "SetClassLongPtrA".}
when winimCpu32:
  const
    CONSOLE_APPLICATION_16BIT* = 0x0001
    GUI_16BITTASK* = 0x00000020
  proc GetWindowLongPtrA*(hWnd: HWND, nIndex: int32): LONG {.winapi, stdcall, dynlib: "user32", importc: "GetWindowLongA".}
  proc GetWindowLongPtrW*(hWnd: HWND, nIndex: int32): LONG {.winapi, stdcall, dynlib: "user32", importc: "GetWindowLongW".}
  proc SetWindowLongPtrA*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): LONG {.winapi, stdcall, dynlib: "user32", importc: "SetWindowLongA".}
  proc SetWindowLongPtrW*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): LONG {.winapi, stdcall, dynlib: "user32", importc: "SetWindowLongW".}
  proc GetClassLongPtrA*(hWnd: HWND, nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc: "GetClassLongA".}
  proc GetClassLongPtrW*(hWnd: HWND, nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc: "GetClassLongW".}
  proc SetClassLongPtrA*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): DWORD {.winapi, stdcall, dynlib: "user32", importc: "SetClassLongA".}
  proc SetClassLongPtrW*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): DWORD {.winapi, stdcall, dynlib: "user32", importc: "SetClassLongW".}
when winimUnicode and winimCpu32:
  proc GetWindowLongPtr*(hWnd: HWND, nIndex: int32): LONG {.winapi, stdcall, dynlib: "user32", importc: "GetWindowLongW".}
  proc SetWindowLongPtr*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): LONG {.winapi, stdcall, dynlib: "user32", importc: "SetWindowLongW".}
  proc GetClassLongPtr*(hWnd: HWND, nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc: "GetClassLongW".}
  proc SetClassLongPtr*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): DWORD {.winapi, stdcall, dynlib: "user32", importc: "SetClassLongW".}
when winimAnsi and winimCpu32:
  proc GetWindowLongPtr*(hWnd: HWND, nIndex: int32): LONG {.winapi, stdcall, dynlib: "user32", importc: "GetWindowLongA".}
  proc SetWindowLongPtr*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): LONG {.winapi, stdcall, dynlib: "user32", importc: "SetWindowLongA".}
  proc GetClassLongPtr*(hWnd: HWND, nIndex: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc: "GetClassLongA".}
  proc SetClassLongPtr*(hWnd: HWND, nIndex: int32, dwNewLong: LONG): DWORD {.winapi, stdcall, dynlib: "user32", importc: "SetClassLongA".}
