#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import uxtheme
#include <dwmapi.h>
type
  DWMWINDOWATTRIBUTE* = int32
  DWMNCRENDERINGPOLICY* = int32
  DWMFLIP3DWINDOWPOLICY* = int32
  DWM_SOURCE_FRAME_SAMPLING* = int32
  DWMTRANSITION_OWNEDWINDOW_TARGET* = int32
  GESTURE_TYPE* = int32
  DWM_SHOWCONTACT_ENUM* = int32
  DWM_TAB_WINDOW_REQUIREMENTS* = int32
  HTHUMBNAIL* = HANDLE
  DWM_FRAME_COUNT* = ULONGLONG
  QPC_TIME* = ULONGLONG
  DWM_BLURBEHIND* {.pure.} = object
    dwFlags*: DWORD
    fEnable*: BOOL
    hRgnBlur*: HRGN
    fTransitionOnMaximized*: BOOL
  PDWM_BLURBEHIND* = ptr DWM_BLURBEHIND
  PHTHUMBNAIL* = ptr HTHUMBNAIL
  DWM_THUMBNAIL_PROPERTIES* {.pure.} = object
    dwFlags*: DWORD
    rcDestination*: RECT
    rcSource*: RECT
    opacity*: BYTE
    fVisible*: BOOL
    fSourceClientAreaOnly*: BOOL
  PDWM_THUMBNAIL_PROPERTIES* = ptr DWM_THUMBNAIL_PROPERTIES
const
  DWM_BB_ENABLE* = 0x00000001
  DWM_BB_BLURREGION* = 0x00000002
  DWM_BB_TRANSITIONONMAXIMIZED* = 0x00000004
  DWMWA_NCRENDERING_ENABLED* = 1
  DWMWA_NCRENDERING_POLICY* = 2
  DWMWA_TRANSITIONS_FORCEDISABLED* = 3
  DWMWA_ALLOW_NCPAINT* = 4
  DWMWA_CAPTION_BUTTON_BOUNDS* = 5
  DWMWA_NONCLIENT_RTL_LAYOUT* = 6
  DWMWA_FORCE_ICONIC_REPRESENTATION* = 7
  DWMWA_FLIP3D_POLICY* = 8
  DWMWA_EXTENDED_FRAME_BOUNDS* = 9
  DWMWA_HAS_ICONIC_BITMAP* = 10
  DWMWA_DISALLOW_PEEK* = 11
  DWMWA_EXCLUDED_FROM_PEEK* = 12
  DWMWA_CLOAK* = 13
  DWMWA_CLOAKED* = 14
  DWMWA_FREEZE_REPRESENTATION* = 15
  DWMWA_LAST* = 16
  DWMNCRP_USEWINDOWSTYLE* = 0
  DWMNCRP_DISABLED* = 1
  DWMNCRP_ENABLED* = 2
  DWMNCRP_LAST* = 3
  DWMFLIP3D_DEFAULT* = 0
  DWMFLIP3D_EXCLUDEBELOW* = 1
  DWMFLIP3D_EXCLUDEABOVE* = 2
  DWMFLIP3D_LAST* = 3
  DWM_CLOAKED_APP* = 0x00000001
  DWM_CLOAKED_SHELL* = 0x00000002
  DWM_CLOAKED_INHERITED* = 0x00000004
  DWM_TNP_RECTDESTINATION* = 0x00000001
  DWM_TNP_RECTSOURCE* = 0x00000002
  DWM_TNP_OPACITY* = 0x00000004
  DWM_TNP_VISIBLE* = 0x00000008
  DWM_TNP_SOURCECLIENTAREAONLY* = 0x00000010
  DWM_SOURCE_FRAME_SAMPLING_POINT* = 0
  DWM_SOURCE_FRAME_SAMPLING_COVERAGE* = 1
  DWM_SOURCE_FRAME_SAMPLING_LAST* = 2
  c_DwmMaxQueuedBuffers* = 8
  c_DwmMaxMonitors* = 16
  c_DwmMaxAdapters* = 16
  DWM_FRAME_DURATION_DEFAULT* = -1
  DWM_EC_DISABLECOMPOSITION* = 0
  DWM_EC_ENABLECOMPOSITION* = 1
  DWM_SIT_DISPLAYFRAME* = 0x00000001
  DWMTRANSITION_OWNEDWINDOW_NULL* = -1
  DWMTRANSITION_OWNEDWINDOW_REPOSITION* = 0
  GT_PEN_TAP* = 0
  GT_PEN_DOUBLETAP* = 1
  GT_PEN_RIGHTTAP* = 2
  GT_PEN_PRESSANDHOLD* = 3
  GT_PEN_PRESSANDHOLDABORT* = 4
  GT_TOUCH_TAP* = 5
  GT_TOUCH_DOUBLETAP* = 6
  GT_TOUCH_RIGHTTAP* = 7
  GT_TOUCH_PRESSANDHOLD* = 8
  GT_TOUCH_PRESSANDHOLDABORT* = 9
  GT_TOUCH_PRESSANDTAP* = 10
  DWMSC_DOWN* = 0x00000001
  DWMSC_UP* = 0x00000002
  DWMSC_DRAG* = 0x00000004
  DWMSC_HOLD* = 0x00000008
  DWMSC_PENBARREL* = 0x00000010
  DWMSC_NONE* = 0x00000000
  DWMSC_ALL* = 0xFFFFFFFF'i32
  DWMTWR_NONE* = 0x0000
  DWMTWR_IMPLEMENTED_BY_SYSTEM* = 0x0001
  DWMTWR_WINDOW_RELATIONSHIP* = 0x0002
  DWMTWR_WINDOW_STYLES* = 0x0004
  DWMTWR_WINDOW_REGION* = 0x0008
  DWMTWR_WINDOW_DWM_ATTRIBUTES* = 0x0010
  DWMTWR_WINDOW_MARGINS* = 0x0020
  DWMTWR_TABBING_ENABLED* = 0x0040
  DWMTWR_USER_POLICY* = 0x0080
  DWMTWR_GROUP_POLICY* = 0x0100
  DWMTWR_APP_COMPAT* = 0x0200
type
  UNSIGNED_RATIO* {.pure.} = object
    uiNumerator*: UINT32
    uiDenominator*: UINT32
  DWM_TIMING_INFO* {.pure.} = object
    cbSize*: UINT32
    rateRefresh*: UNSIGNED_RATIO
    qpcRefreshPeriod*: QPC_TIME
    rateCompose*: UNSIGNED_RATIO
    qpcVBlank*: QPC_TIME
    cRefresh*: DWM_FRAME_COUNT
    cDXRefresh*: UINT
    qpcCompose*: QPC_TIME
    cFrame*: DWM_FRAME_COUNT
    cDXPresent*: UINT
    cRefreshFrame*: DWM_FRAME_COUNT
    cFrameSubmitted*: DWM_FRAME_COUNT
    cDXPresentSubmitted*: UINT
    cFrameConfirmed*: DWM_FRAME_COUNT
    cDXPresentConfirmed*: UINT
    cRefreshConfirmed*: DWM_FRAME_COUNT
    cDXRefreshConfirmed*: UINT
    cFramesLate*: DWM_FRAME_COUNT
    cFramesOutstanding*: UINT
    cFrameDisplayed*: DWM_FRAME_COUNT
    qpcFrameDisplayed*: QPC_TIME
    cRefreshFrameDisplayed*: DWM_FRAME_COUNT
    cFrameComplete*: DWM_FRAME_COUNT
    qpcFrameComplete*: QPC_TIME
    cFramePending*: DWM_FRAME_COUNT
    qpcFramePending*: QPC_TIME
    cFramesDisplayed*: DWM_FRAME_COUNT
    cFramesComplete*: DWM_FRAME_COUNT
    cFramesPending*: DWM_FRAME_COUNT
    cFramesAvailable*: DWM_FRAME_COUNT
    cFramesDropped*: DWM_FRAME_COUNT
    cFramesMissed*: DWM_FRAME_COUNT
    cRefreshNextDisplayed*: DWM_FRAME_COUNT
    cRefreshNextPresented*: DWM_FRAME_COUNT
    cRefreshesDisplayed*: DWM_FRAME_COUNT
    cRefreshesPresented*: DWM_FRAME_COUNT
    cRefreshStarted*: DWM_FRAME_COUNT
    cPixelsReceived*: ULONGLONG
    cPixelsDrawn*: ULONGLONG
    cBuffersEmpty*: DWM_FRAME_COUNT
  DWM_PRESENT_PARAMETERS* {.pure.} = object
    cbSize*: UINT32
    fQueue*: BOOL
    cRefreshStart*: DWM_FRAME_COUNT
    cBuffer*: UINT
    fUseSourceRate*: BOOL
    rateSource*: UNSIGNED_RATIO
    cRefreshesPerFrame*: UINT
    eSampling*: DWM_SOURCE_FRAME_SAMPLING
  MIL_MATRIX3X2D* {.pure.} = object
    S_11*: DOUBLE
    S_12*: DOUBLE
    S_21*: DOUBLE
    S_22*: DOUBLE
    DX*: DOUBLE
    DY*: DOUBLE
proc DwmDefWindowProc*(hWnd: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): BOOL {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmEnableBlurBehindWindow*(hWnd: HWND, pBlurBehind: ptr DWM_BLURBEHIND): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmEnableComposition*(uCompositionAction: UINT): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmEnableMMCSS*(fEnableMMCSS: BOOL): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmExtendFrameIntoClientArea*(hWnd: HWND, pMarInset: ptr MARGINS): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmGetColorizationColor*(pcrColorization: ptr DWORD, pfOpaqueBlend: ptr BOOL): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmGetCompositionTimingInfo*(hwnd: HWND, pTimingInfo: ptr DWM_TIMING_INFO): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmGetWindowAttribute*(hwnd: HWND, dwAttribute: DWORD, pvAttribute: PVOID, cbAttribute: DWORD): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmIsCompositionEnabled*(pfEnabled: ptr BOOL): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmModifyPreviousDxFrameDuration*(hwnd: HWND, cRefreshes: INT, fRelative: BOOL): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmQueryThumbnailSourceSize*(hThumbnail: HTHUMBNAIL, pSize: PSIZE): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmRegisterThumbnail*(hwndDestination: HWND, hwndSource: HWND, phThumbnailId: PHTHUMBNAIL): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmSetDxFrameDuration*(hwnd: HWND, cRefreshes: INT): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmSetPresentParameters*(hwnd: HWND, pPresentParams: ptr DWM_PRESENT_PARAMETERS): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmSetWindowAttribute*(hwnd: HWND, dwAttribute: DWORD, pvAttribute: LPCVOID, cbAttribute: DWORD): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmUnregisterThumbnail*(hThumbnailId: HTHUMBNAIL): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmUpdateThumbnailProperties*(hThumbnailId: HTHUMBNAIL, ptnProperties: ptr DWM_THUMBNAIL_PROPERTIES): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmSetIconicThumbnail*(hwnd: HWND, hbmp: HBITMAP, dwSITFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmSetIconicLivePreviewBitmap*(hwnd: HWND, hbmp: HBITMAP, pptClient: ptr POINT, dwSITFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmInvalidateIconicBitmaps*(hwnd: HWND): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmAttachMilContent*(hwnd: HWND): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmDetachMilContent*(hwnd: HWND): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmFlush*(): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmGetGraphicsStreamTransformHint*(uIndex: UINT, pTransform: ptr MIL_MATRIX3X2D): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmGetGraphicsStreamClient*(uIndex: UINT, pClientUuid: ptr GUID): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmGetTransportAttributes*(pfIsRemoting: ptr BOOL, pfIsConnected: ptr BOOL, pDwGeneration: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmTransitionOwnedWindow*(hwnd: HWND, target: DWMTRANSITION_OWNEDWINDOW_TARGET): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmRenderGesture*(gt: GESTURE_TYPE, cContacts: UINT, pdwPointerID: ptr DWORD, pPoints: ptr POINT): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmTetherContact*(dwPointerID: DWORD, fEnable: BOOL, ptTether: POINT): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmShowContact*(dwPointerID: DWORD, eShowContact: DWM_SHOWCONTACT_ENUM): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
proc DwmGetUnmetTabRequirements*(appWindow: HWND, value: ptr DWM_TAB_WINDOW_REQUIREMENTS): HRESULT {.winapi, stdcall, dynlib: "dwmapi", importc.}
