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
import winuser
import wincon
import winreg
import winnetwk
import objbase
import iphlpapi
import commctrl
import regstr
#include <shellapi.h>
#include <shlwapi.h>
#include <shlobj.h>
#include <shlguid.h>
#include <isguids.h>
#include <shldisp.h>
#include <knownfolders.h>
#include <shobjidl.h>
#include <objectarray.h>
#include <sherrors.h>
type
  ASSOCCLASS* = int32
  QUERY_USER_NOTIFICATION_STATE* = int32
  SHSTOCKICONID* = int32
  URL_SCHEME* = int32
  URL_PART* = int32
  TURLIS* = int32
  SHREGDEL_FLAGS* = int32
  SHREGENUM_FLAGS* = int32
  ASSOCSTR* = int32
  ASSOCKEY* = int32
  ASSOCDATA* = int32
  ASSOCENUM* = int32
  SHGFP_TYPE* = int32
  OfflineFolderStatus* = int32
  ShellFolderViewOptions* = int32
  ShellSpecialFolderConstants* = int32
  AUTOCOMPLETEOPTIONS* = int32
  ACENUMOPTION* = int32
  FOLDER_ENUM_MODE* = int32
  LPVIEWSETTINGS* = ptr char
  FOLDERFLAGS* = int32
  FOLDERVIEWMODE* = int32
  FOLDERLOGICALVIEWMODE* = int32
  FOLDERVIEWOPTIONS* = int32
  SVSIF* = int32
  SVGIO* = int32
  SVUIA_STATUS* = int32
  SORTDIRECTION* = int32
  FVTEXTTYPE* = int32
  VPWATERMARKFLAGS* = int32
  VPCOLORFLAGS* = int32
  CM_MASK* = int32
  CM_STATE* = int32
  CM_ENUM_FLAGS* = int32
  CM_SET_WIDTH_VALUE* = int32
  SIGDN* = int32
  DATAOBJ_GET_ITEM_FLAGS* = int32
  SIIGBF* = int32
  STGOP* = int32
  SIATTRIBFLAGS* = int32
  CATEGORYINFO_FLAGS* = int32
  CATSORT_FLAGS* = int32
  DSH_FLAGS* = int32
  SLR_FLAGS* = int32
  SLGP_FLAGS* = int32
  SPACTION* = int32
  SPTEXT* = int32
  THUMBBUTTONFLAGS* = int32
  THUMBBUTTONMASK* = int32
  TBPFLAG* = int32
  STPFLAG* = int32
  EXPLORER_BROWSER_OPTIONS* = int32
  EXPLORER_BROWSER_FILL_FLAGS* = int32
  PDOPSTATUS* = int32
  NAMESPACEWALKFLAG* = int32
  MP_POPUPFLAGS* = int32
  FILE_USAGE_TYPE* = int32
  FDE_OVERWRITE_RESPONSE* = int32
  FDE_SHAREVIOLATION_RESPONSE* = int32
  FDAP* = int32
  CDCONTROLSTATEF* = int32
  ASSOCIATIONLEVEL* = int32
  ASSOCIATIONTYPE* = int32
  NWMF* = int32
  ATTACHMENT_PROMPT* = int32
  ATTACHMENT_ACTION* = int32
  KF_CATEGORY* = int32
  FFFP_MODE* = int32
  SHARE_ROLE* = int32
  DEF_SHARE_ID* = int32
  NMCII_FLAGS* = int32
  NMCSAEI_FLAGS* = int32
  NSTCGNI* = int32
  NSTCSTYLE2* = int32
  NSTCFOLDERCAPABILITIES* = int32
  CPVIEW* = int32
  KNOWNDESTCATEGORY* = int32
  APPDOCLISTTYPE* = int32
  DESKTOP_SLIDESHOW_OPTIONS* = int32
  DESKTOP_SLIDESHOW_STATE* = int32
  DESKTOP_SLIDESHOW_DIRECTION* = int32
  DESKTOP_WALLPAPER_POSITION* = int32
  HOMEGROUPSHARINGCHOICES* = int32
  LIBRARYFOLDERFILTER* = int32
  LIBRARYOPTIONFLAGS* = int32
  DEFAULTSAVEFOLDERTYPE* = int32
  LIBRARYSAVEFLAGS* = int32
  PBM_EVENT* = int32
  PBM_SESSION_TYPE* = int32
  PBM_PLAY_STATE* = int32
  PBM_MUTE_STATE* = int32
  DEFAULT_FOLDER_MENU_RESTRICTIONS* = int32
  ACTIVATEOPTIONS* = int32
  LIBRARYMANAGEDIALOGOPTIONS* = int32
  ASSOC_FILTER* = int32
  UNDOCK_REASON* = int32
  MONITOR_APP_VISIBILITY* = int32
  PACKAGE_EXECUTION_STATE* = int32
  AHE_TYPE* = int32
  EC_HOST_UI_MODE* = int32
  APPLICATION_VIEW_STATE* = int32
  EDGE_GESTURE_KIND* = int32
  SHELL_LINK_DATA_FLAGS* = int32
  GPFIDL_FLAGS* = int32
  KNOWN_FOLDER_FLAG* = int32
  AUTOCOMPLETELISTOPTIONS* = int32
  FD_FLAGS* = int32
  DROPIMAGETYPE* = int32
  SHARD* = int32
  SCNRT_STATUS* = int32
  RESTRICTIONS* = int32
  OPEN_AS_INFO_FLAGS* = int32
  IESHORTCUTFLAGS* = int32
  HDROP* = HANDLE
  FILEOP_FLAGS* = WORD
  PRINTEROP_FLAGS* = WORD
  SRRF* = DWORD
  HUSKEY* = HANDLE
  ASSOCF* = DWORD
  SHGDNF* = DWORD
  SHCONTF* = DWORD
  SFGAOF* = ULONG
  SV3CVW3_FLAGS* = DWORD
  SICHINTF* = DWORD
  TRANSFER_SOURCE_FLAGS* = DWORD
  TRANSFER_ADVISE_STATE* = DWORD
  PROPERTYUI_NAME_FLAGS* = DWORD
  PROPERTYUI_FLAGS* = DWORD
  PROPERTYUI_FORMAT_FLAGS* = DWORD
  SPINITF* = DWORD
  SPBEGINF* = DWORD
  OPPROGDLGF* = DWORD
  PDMODE* = DWORD
  CDBE_ACTIONS* = DWORD
  FILEOPENDIALOGOPTIONS* = DWORD
  BROWSERFRAMEOPTIONS* = DWORD
  KF_DEFINITION_FLAGS* = DWORD
  KF_REDIRECTION_CAPABILITIES* = DWORD
  NSTCSTYLE* = DWORD
  NSTCROOTSTYLE* = DWORD
  NSTCITEMSTATE* = DWORD
  NSTCEHITTEST* = DWORD
  NSTCECLICKTYPE* = DWORD
  EXPLORERPANESTATE* = DWORD
  EXPCMDSTATE* = DWORD
  EXPCMDFLAGS* = DWORD
  HTHEME* = HANDLE
  HPSXA* = HANDLE
  DRAGINFOA* {.pure.} = object
    uSize*: UINT
    pt*: POINT
    fNC*: WINBOOL
    lpFileList*: LPSTR
    grfKeyState*: DWORD
  LPDRAGINFOA* = ptr DRAGINFOA
  DRAGINFOW* {.pure.} = object
    uSize*: UINT
    pt*: POINT
    fNC*: WINBOOL
    lpFileList*: LPWSTR
    grfKeyState*: DWORD
  LPDRAGINFOW* = ptr DRAGINFOW
  APPBARDATA* {.pure.} = object
    cbSize*: DWORD
    hWnd*: HWND
    uCallbackMessage*: UINT
    uEdge*: UINT
    rc*: RECT
    lParam*: LPARAM
  PAPPBARDATA* = ptr APPBARDATA
when winimCpu64:
  type
    SHFILEOPSTRUCTA* {.pure.} = object
      hwnd*: HWND
      wFunc*: UINT
      pFrom*: LPCSTR
      pTo*: LPCSTR
      fFlags*: FILEOP_FLAGS
      fAnyOperationsAborted*: WINBOOL
      hNameMappings*: LPVOID
      lpszProgressTitle*: PCSTR
when winimCpu32:
  type
    SHFILEOPSTRUCTA* {.pure, packed.} = object
      hwnd*: HWND
      wFunc*: UINT
      pFrom*: LPCSTR
      pTo*: LPCSTR
      fFlags*: FILEOP_FLAGS
      fAnyOperationsAborted*: WINBOOL
      hNameMappings*: LPVOID
      lpszProgressTitle*: PCSTR
type
  LPSHFILEOPSTRUCTA* = ptr SHFILEOPSTRUCTA
when winimCpu64:
  type
    SHFILEOPSTRUCTW* {.pure.} = object
      hwnd*: HWND
      wFunc*: UINT
      pFrom*: LPCWSTR
      pTo*: LPCWSTR
      fFlags*: FILEOP_FLAGS
      fAnyOperationsAborted*: WINBOOL
      hNameMappings*: LPVOID
      lpszProgressTitle*: PCWSTR
when winimCpu32:
  type
    SHFILEOPSTRUCTW* {.pure, packed.} = object
      hwnd*: HWND
      wFunc*: UINT
      pFrom*: LPCWSTR
      pTo*: LPCWSTR
      fFlags*: FILEOP_FLAGS
      fAnyOperationsAborted*: WINBOOL
      hNameMappings*: LPVOID
      lpszProgressTitle*: PCWSTR
type
  LPSHFILEOPSTRUCTW* = ptr SHFILEOPSTRUCTW
  SHNAMEMAPPINGA* {.pure.} = object
    pszOldPath*: LPSTR
    pszNewPath*: LPSTR
    cchOldPath*: int32
    cchNewPath*: int32
  LPSHNAMEMAPPINGA* = ptr SHNAMEMAPPINGA
  SHNAMEMAPPINGW* {.pure.} = object
    pszOldPath*: LPWSTR
    pszNewPath*: LPWSTR
    cchOldPath*: int32
    cchNewPath*: int32
  LPSHNAMEMAPPINGW* = ptr SHNAMEMAPPINGW
  SHELLEXECUTEINFOA_UNION1* {.pure, union.} = object
    hIcon*: HANDLE
    hMonitor*: HANDLE
  SHELLEXECUTEINFOA* {.pure.} = object
    cbSize*: DWORD
    fMask*: ULONG
    hwnd*: HWND
    lpVerb*: LPCSTR
    lpFile*: LPCSTR
    lpParameters*: LPCSTR
    lpDirectory*: LPCSTR
    nShow*: int32
    hInstApp*: HINSTANCE
    lpIDList*: pointer
    lpClass*: LPCSTR
    hkeyClass*: HKEY
    dwHotKey*: DWORD
    union1*: SHELLEXECUTEINFOA_UNION1
    hProcess*: HANDLE
  LPSHELLEXECUTEINFOA* = ptr SHELLEXECUTEINFOA
  SHELLEXECUTEINFOW_UNION1* {.pure, union.} = object
    hIcon*: HANDLE
    hMonitor*: HANDLE
  SHELLEXECUTEINFOW* {.pure.} = object
    cbSize*: DWORD
    fMask*: ULONG
    hwnd*: HWND
    lpVerb*: LPCWSTR
    lpFile*: LPCWSTR
    lpParameters*: LPCWSTR
    lpDirectory*: LPCWSTR
    nShow*: int32
    hInstApp*: HINSTANCE
    lpIDList*: pointer
    lpClass*: LPCWSTR
    hkeyClass*: HKEY
    dwHotKey*: DWORD
    union1*: SHELLEXECUTEINFOW_UNION1
    hProcess*: HANDLE
  LPSHELLEXECUTEINFOW* = ptr SHELLEXECUTEINFOW
  SHCREATEPROCESSINFOW* {.pure.} = object
    cbSize*: DWORD
    fMask*: ULONG
    hwnd*: HWND
    pszFile*: LPCWSTR
    pszParameters*: LPCWSTR
    pszCurrentDirectory*: LPCWSTR
    hUserToken*: HANDLE
    lpProcessAttributes*: LPSECURITY_ATTRIBUTES
    lpThreadAttributes*: LPSECURITY_ATTRIBUTES
    bInheritHandles*: WINBOOL
    dwCreationFlags*: DWORD
    lpStartupInfo*: LPSTARTUPINFOW
    lpProcessInformation*: LPPROCESS_INFORMATION
  PSHCREATEPROCESSINFOW* = ptr SHCREATEPROCESSINFOW
when winimCpu64:
  type
    SHQUERYRBINFO* {.pure.} = object
      cbSize*: DWORD
      i64Size*: int64
      i64NumItems*: int64
when winimCpu32:
  type
    SHQUERYRBINFO* {.pure, packed.} = object
      cbSize*: DWORD
      i64Size*: int64
      i64NumItems*: int64
type
  LPSHQUERYRBINFO* = ptr SHQUERYRBINFO
  NOTIFYICONDATAA_UNION1* {.pure, union.} = object
    uTimeout*: UINT
    uVersion*: UINT
  NOTIFYICONDATAA* {.pure.} = object
    cbSize*: DWORD
    hWnd*: HWND
    uID*: UINT
    uFlags*: UINT
    uCallbackMessage*: UINT
    hIcon*: HICON
    szTip*: array[128, CHAR]
    dwState*: DWORD
    dwStateMask*: DWORD
    szInfo*: array[256, CHAR]
    union1*: NOTIFYICONDATAA_UNION1
    szInfoTitle*: array[64, CHAR]
    dwInfoFlags*: DWORD
    guidItem*: GUID
    hBalloonIcon*: HICON
  PNOTIFYICONDATAA* = ptr NOTIFYICONDATAA
  NOTIFYICONDATAW_UNION1* {.pure, union.} = object
    uTimeout*: UINT
    uVersion*: UINT
  NOTIFYICONDATAW* {.pure.} = object
    cbSize*: DWORD
    hWnd*: HWND
    uID*: UINT
    uFlags*: UINT
    uCallbackMessage*: UINT
    hIcon*: HICON
    szTip*: array[128, WCHAR]
    dwState*: DWORD
    dwStateMask*: DWORD
    szInfo*: array[256, WCHAR]
    union1*: NOTIFYICONDATAW_UNION1
    szInfoTitle*: array[64, WCHAR]
    dwInfoFlags*: DWORD
    guidItem*: GUID
    hBalloonIcon*: HICON
  PNOTIFYICONDATAW* = ptr NOTIFYICONDATAW
  NOTIFYICONIDENTIFIER* {.pure.} = object
    cbSize*: DWORD
    hWnd*: HWND
    uID*: UINT
    guidItem*: GUID
  PNOTIFYICONIDENTIFIER* = ptr NOTIFYICONIDENTIFIER
  OPEN_PRINTER_PROPS_INFOA* {.pure.} = object
    dwSize*: DWORD
    pszSheetName*: LPSTR
    uSheetIndex*: UINT
    dwFlags*: DWORD
    bModal*: WINBOOL
  POPEN_PRINTER_PROPS_INFOA* = ptr OPEN_PRINTER_PROPS_INFOA
  OPEN_PRINTER_PROPS_INFOW* {.pure.} = object
    dwSize*: DWORD
    pszSheetName*: LPWSTR
    uSheetIndex*: UINT
    dwFlags*: DWORD
    bModal*: WINBOOL
  POPEN_PRINTER_PROPS_INFOW* = ptr OPEN_PRINTER_PROPS_INFOW
  NC_ADDRESS* {.pure.} = object
    pAddrInfo*: ptr NET_ADDRESS_INFO
    PortNumber*: USHORT
    PrefixLength*: BYTE
  PNC_ADDRESS* = ptr NC_ADDRESS
  PHUSKEY* = ptr HUSKEY
  IDefViewID* = IUnknown
  FolderItemVerb* {.pure.} = object
    lpVtbl*: ptr FolderItemVerbVtbl
  FolderItemVerbVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Application*: proc(self: ptr FolderItemVerb, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Parent*: proc(self: ptr FolderItemVerb, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Name*: proc(self: ptr FolderItemVerb, pbs: ptr BSTR): HRESULT {.stdcall.}
    DoIt*: proc(self: ptr FolderItemVerb): HRESULT {.stdcall.}
  FolderItemVerbs* {.pure.} = object
    lpVtbl*: ptr FolderItemVerbsVtbl
  FolderItemVerbsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Count*: proc(self: ptr FolderItemVerbs, plCount: ptr LONG): HRESULT {.stdcall.}
    get_Application*: proc(self: ptr FolderItemVerbs, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Parent*: proc(self: ptr FolderItemVerbs, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    Item*: proc(self: ptr FolderItemVerbs, index: VARIANT, ppid: ptr ptr FolderItemVerb): HRESULT {.stdcall.}
    NewEnum*: proc(self: ptr FolderItemVerbs, ppunk: ptr ptr IUnknown): HRESULT {.stdcall.}
  FolderItem* {.pure.} = object
    lpVtbl*: ptr FolderItemVtbl
  FolderItemVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Application*: proc(self: ptr FolderItem, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Parent*: proc(self: ptr FolderItem, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Name*: proc(self: ptr FolderItem, pbs: ptr BSTR): HRESULT {.stdcall.}
    put_Name*: proc(self: ptr FolderItem, bs: BSTR): HRESULT {.stdcall.}
    get_Path*: proc(self: ptr FolderItem, pbs: ptr BSTR): HRESULT {.stdcall.}
    get_GetLink*: proc(self: ptr FolderItem, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_GetFolder*: proc(self: ptr FolderItem, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_IsLink*: proc(self: ptr FolderItem, pb: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsFolder*: proc(self: ptr FolderItem, pb: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsFileSystem*: proc(self: ptr FolderItem, pb: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsBrowsable*: proc(self: ptr FolderItem, pb: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_ModifyDate*: proc(self: ptr FolderItem, pdt: ptr DATE): HRESULT {.stdcall.}
    put_ModifyDate*: proc(self: ptr FolderItem, dt: DATE): HRESULT {.stdcall.}
    get_Size*: proc(self: ptr FolderItem, pul: ptr LONG): HRESULT {.stdcall.}
    get_Type*: proc(self: ptr FolderItem, pbs: ptr BSTR): HRESULT {.stdcall.}
    Verbs*: proc(self: ptr FolderItem, ppfic: ptr ptr FolderItemVerbs): HRESULT {.stdcall.}
    InvokeVerb*: proc(self: ptr FolderItem, vVerb: VARIANT): HRESULT {.stdcall.}
  LPFOLDERITEM* = ptr FolderItem
  IAutoComplete* {.pure.} = object
    lpVtbl*: ptr IAutoCompleteVtbl
  IAutoCompleteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Init*: proc(self: ptr IAutoComplete, hwndEdit: HWND, punkACL: ptr IUnknown, pwszRegKeyPath: LPCWSTR, pwszQuickComplete: LPCWSTR): HRESULT {.stdcall.}
    Enable*: proc(self: ptr IAutoComplete, fEnable: WINBOOL): HRESULT {.stdcall.}
  LPAUTOCOMPLETE* = ptr IAutoComplete
  IAutoComplete2* {.pure.} = object
    lpVtbl*: ptr IAutoComplete2Vtbl
  IAutoComplete2Vtbl* {.pure, inheritable.} = object of IAutoCompleteVtbl
    SetOptions*: proc(self: ptr IAutoComplete2, dwFlag: DWORD): HRESULT {.stdcall.}
    GetOptions*: proc(self: ptr IAutoComplete2, pdwFlag: ptr DWORD): HRESULT {.stdcall.}
  LPAUTOCOMPLETE2* = ptr IAutoComplete2
  IEnumACString* {.pure.} = object
    lpVtbl*: ptr IEnumACStringVtbl
  IEnumACStringVtbl* {.pure, inheritable.} = object of IEnumStringVtbl
    NextItem*: proc(self: ptr IEnumACString, pszUrl: LPWSTR, cchMax: ULONG, pulSortIndex: ptr ULONG): HRESULT {.stdcall.}
    SetEnumOptions*: proc(self: ptr IEnumACString, dwOptions: DWORD): HRESULT {.stdcall.}
    GetEnumOptions*: proc(self: ptr IEnumACString, pdwOptions: ptr DWORD): HRESULT {.stdcall.}
  PENUMACSTRING* = ptr IEnumACString
  LPENUMACSTRING* = ptr IEnumACString
  CMINVOKECOMMANDINFO* {.pure.} = object
    cbSize*: DWORD
    fMask*: DWORD
    hwnd*: HWND
    lpVerb*: LPCSTR
    lpParameters*: LPCSTR
    lpDirectory*: LPCSTR
    nShow*: int32
    dwHotKey*: DWORD
    hIcon*: HANDLE
  LPCMINVOKECOMMANDINFO* = ptr CMINVOKECOMMANDINFO
  PCCMINVOKECOMMANDINFO* = ptr CMINVOKECOMMANDINFO
  CMINVOKECOMMANDINFOEX* {.pure.} = object
    cbSize*: DWORD
    fMask*: DWORD
    hwnd*: HWND
    lpVerb*: LPCSTR
    lpParameters*: LPCSTR
    lpDirectory*: LPCSTR
    nShow*: int32
    dwHotKey*: DWORD
    hIcon*: HANDLE
    lpTitle*: LPCSTR
    lpVerbW*: LPCWSTR
    lpParametersW*: LPCWSTR
    lpDirectoryW*: LPCWSTR
    lpTitleW*: LPCWSTR
    ptInvoke*: POINT
  LPCMINVOKECOMMANDINFOEX* = ptr CMINVOKECOMMANDINFOEX
  PCCMINVOKECOMMANDINFOEX* = ptr CMINVOKECOMMANDINFOEX
  IContextMenu* {.pure.} = object
    lpVtbl*: ptr IContextMenuVtbl
  IContextMenuVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryContextMenu*: proc(self: ptr IContextMenu, hmenu: HMENU, indexMenu: UINT, idCmdFirst: UINT, idCmdLast: UINT, uFlags: UINT): HRESULT {.stdcall.}
    InvokeCommand*: proc(self: ptr IContextMenu, pici: ptr CMINVOKECOMMANDINFO): HRESULT {.stdcall.}
    GetCommandString*: proc(self: ptr IContextMenu, idCmd: UINT_PTR, uType: UINT, pReserved: ptr UINT, pszName: ptr CHAR, cchMax: UINT): HRESULT {.stdcall.}
  LPCONTEXTMENU* = ptr IContextMenu
  IContextMenu2* {.pure.} = object
    lpVtbl*: ptr IContextMenu2Vtbl
  IContextMenu2Vtbl* {.pure, inheritable.} = object of IContextMenuVtbl
    HandleMenuMsg*: proc(self: ptr IContextMenu2, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
  LPCONTEXTMENU2* = ptr IContextMenu2
  IContextMenu3* {.pure.} = object
    lpVtbl*: ptr IContextMenu3Vtbl
  IContextMenu3Vtbl* {.pure, inheritable.} = object of IContextMenu2Vtbl
    HandleMenuMsg2*: proc(self: ptr IContextMenu3, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.stdcall.}
  LPCONTEXTMENU3* = ptr IContextMenu3
  IPersistFolder* {.pure.} = object
    lpVtbl*: ptr IPersistFolderVtbl
  IPersistFolderVtbl* {.pure, inheritable.} = object of IPersistVtbl
    Initialize*: proc(self: ptr IPersistFolder, pidl: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
  LPPERSISTFOLDER* = ptr IPersistFolder
  IEnumIDList* {.pure.} = object
    lpVtbl*: ptr IEnumIDListVtbl
  IEnumIDListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumIDList, celt: ULONG, rgelt: ptr PITEMID_CHILD, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumIDList, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumIDList): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumIDList, ppenum: ptr ptr IEnumIDList): HRESULT {.stdcall.}
  LPENUMIDLIST* = ptr IEnumIDList
  IShellFolder* {.pure.} = object
    lpVtbl*: ptr IShellFolderVtbl
  IShellFolderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParseDisplayName*: proc(self: ptr IShellFolder, hwnd: HWND, pbc: ptr IBindCtx, pszDisplayName: LPWSTR, pchEaten: ptr ULONG, ppidl: ptr PIDLIST_RELATIVE, pdwAttributes: ptr ULONG): HRESULT {.stdcall.}
    EnumObjects*: proc(self: ptr IShellFolder, hwnd: HWND, grfFlags: SHCONTF, ppenumIDList: ptr ptr IEnumIDList): HRESULT {.stdcall.}
    BindToObject*: proc(self: ptr IShellFolder, pidl: PCUIDLIST_RELATIVE, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    BindToStorage*: proc(self: ptr IShellFolder, pidl: PCUIDLIST_RELATIVE, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    CompareIDs*: proc(self: ptr IShellFolder, lParam: LPARAM, pidl1: PCUIDLIST_RELATIVE, pidl2: PCUIDLIST_RELATIVE): HRESULT {.stdcall.}
    CreateViewObject*: proc(self: ptr IShellFolder, hwndOwner: HWND, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetAttributesOf*: proc(self: ptr IShellFolder, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, rgfInOut: ptr SFGAOF): HRESULT {.stdcall.}
    GetUIObjectOf*: proc(self: ptr IShellFolder, hwndOwner: HWND, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, riid: REFIID, rgfReserved: ptr UINT, ppv: ptr pointer): HRESULT {.stdcall.}
    GetDisplayNameOf*: proc(self: ptr IShellFolder, pidl: PCUITEMID_CHILD, uFlags: SHGDNF, pName: ptr STRRET): HRESULT {.stdcall.}
    SetNameOf*: proc(self: ptr IShellFolder, hwnd: HWND, pidl: PCUITEMID_CHILD, pszName: LPCWSTR, uFlags: SHGDNF, ppidlOut: ptr PITEMID_CHILD): HRESULT {.stdcall.}
  LPSHELLFOLDER* = ptr IShellFolder
  EXTRASEARCH* {.pure.} = object
    guidSearch*: GUID
    wszFriendlyName*: array[80, WCHAR]
    wszUrl*: array[2084, WCHAR]
  LPEXTRASEARCH* = ptr EXTRASEARCH
  IEnumExtraSearch* {.pure.} = object
    lpVtbl*: ptr IEnumExtraSearchVtbl
  IEnumExtraSearchVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumExtraSearch, celt: ULONG, rgelt: ptr EXTRASEARCH, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumExtraSearch, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumExtraSearch): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumExtraSearch, ppenum: ptr ptr IEnumExtraSearch): HRESULT {.stdcall.}
  LPENUMEXTRASEARCH* = ptr IEnumExtraSearch
  FOLDERSETTINGS* {.pure.} = object
    ViewMode*: UINT
    fFlags*: UINT
  LPFOLDERSETTINGS* = ptr FOLDERSETTINGS
  LPCFOLDERSETTINGS* = ptr FOLDERSETTINGS
  PFOLDERSETTINGS* = ptr FOLDERSETTINGS
  LPFNSVADDPROPSHEETPAGE* = LPFNADDPROPSHEETPAGE
  LPTBBUTTONSB* = LPTBBUTTON
  IShellBrowser* {.pure.} = object
    lpVtbl*: ptr IShellBrowserVtbl
  IShellBrowserVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    InsertMenusSB*: proc(self: ptr IShellBrowser, hmenuShared: HMENU, lpMenuWidths: LPOLEMENUGROUPWIDTHS): HRESULT {.stdcall.}
    SetMenuSB*: proc(self: ptr IShellBrowser, hmenuShared: HMENU, holemenuRes: HOLEMENU, hwndActiveObject: HWND): HRESULT {.stdcall.}
    RemoveMenusSB*: proc(self: ptr IShellBrowser, hmenuShared: HMENU): HRESULT {.stdcall.}
    SetStatusTextSB*: proc(self: ptr IShellBrowser, pszStatusText: LPCWSTR): HRESULT {.stdcall.}
    EnableModelessSB*: proc(self: ptr IShellBrowser, fEnable: WINBOOL): HRESULT {.stdcall.}
    TranslateAcceleratorSB*: proc(self: ptr IShellBrowser, pmsg: ptr MSG, wID: WORD): HRESULT {.stdcall.}
    BrowseObject*: proc(self: ptr IShellBrowser, pidl: PCUIDLIST_RELATIVE, wFlags: UINT): HRESULT {.stdcall.}
    GetViewStateStream*: proc(self: ptr IShellBrowser, grfMode: DWORD, ppStrm: ptr ptr IStream): HRESULT {.stdcall.}
    GetControlWindow*: proc(self: ptr IShellBrowser, id: UINT, phwnd: ptr HWND): HRESULT {.stdcall.}
    SendControlMsg*: proc(self: ptr IShellBrowser, id: UINT, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, pret: ptr LRESULT): HRESULT {.stdcall.}
    QueryActiveShellView*: proc(self: ptr IShellBrowser, ppshv: ptr ptr IShellView): HRESULT {.stdcall.}
    OnViewWindowActive*: proc(self: ptr IShellBrowser, pshv: ptr IShellView): HRESULT {.stdcall.}
    SetToolbarItems*: proc(self: ptr IShellBrowser, lpButtons: LPTBBUTTONSB, nButtons: UINT, uFlags: UINT): HRESULT {.stdcall.}
  IShellView* {.pure.} = object
    lpVtbl*: ptr IShellViewVtbl
  IShellViewVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    TranslateAccelerator*: proc(self: ptr IShellView, pmsg: ptr MSG): HRESULT {.stdcall.}
    EnableModeless*: proc(self: ptr IShellView, fEnable: WINBOOL): HRESULT {.stdcall.}
    UIActivate*: proc(self: ptr IShellView, uState: UINT): HRESULT {.stdcall.}
    Refresh*: proc(self: ptr IShellView): HRESULT {.stdcall.}
    CreateViewWindow*: proc(self: ptr IShellView, psvPrevious: ptr IShellView, pfs: LPCFOLDERSETTINGS, psb: ptr IShellBrowser, prcView: ptr RECT, phWnd: ptr HWND): HRESULT {.stdcall.}
    DestroyViewWindow*: proc(self: ptr IShellView): HRESULT {.stdcall.}
    GetCurrentInfo*: proc(self: ptr IShellView, pfs: LPFOLDERSETTINGS): HRESULT {.stdcall.}
    AddPropertySheetPages*: proc(self: ptr IShellView, dwReserved: DWORD, pfn: LPFNSVADDPROPSHEETPAGE, lparam: LPARAM): HRESULT {.stdcall.}
    SaveViewState*: proc(self: ptr IShellView): HRESULT {.stdcall.}
    SelectItem*: proc(self: ptr IShellView, pidlItem: PCUITEMID_CHILD, uFlags: SVSIF): HRESULT {.stdcall.}
    GetItemObject*: proc(self: ptr IShellView, uItem: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  LPSHELLVIEW* = ptr IShellView
  SHELLVIEWID* = GUID
  SV2CVW2_PARAMS* {.pure.} = object
    cbSize*: DWORD
    psvPrev*: ptr IShellView
    pfs*: LPCFOLDERSETTINGS
    psbOwner*: ptr IShellBrowser
    prcView*: ptr RECT
    pvid*: ptr SHELLVIEWID
    hwndView*: HWND
  LPSV2CVW2_PARAMS* = ptr SV2CVW2_PARAMS
  DEPRECATED_HRESULT* = HRESULT
  ICommDlgBrowser* {.pure.} = object
    lpVtbl*: ptr ICommDlgBrowserVtbl
  ICommDlgBrowserVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnDefaultCommand*: proc(self: ptr ICommDlgBrowser, ppshv: ptr IShellView): HRESULT {.stdcall.}
    OnStateChange*: proc(self: ptr ICommDlgBrowser, ppshv: ptr IShellView, uChange: ULONG): HRESULT {.stdcall.}
    IncludeObject*: proc(self: ptr ICommDlgBrowser, ppshv: ptr IShellView, pidl: PCUITEMID_CHILD): HRESULT {.stdcall.}
  LPCOMMDLGBROWSER* = ptr ICommDlgBrowser
  ICommDlgBrowser2* {.pure.} = object
    lpVtbl*: ptr ICommDlgBrowser2Vtbl
  ICommDlgBrowser2Vtbl* {.pure, inheritable.} = object of ICommDlgBrowserVtbl
    Notify*: proc(self: ptr ICommDlgBrowser2, ppshv: ptr IShellView, dwNotifyType: DWORD): HRESULT {.stdcall.}
    GetDefaultMenuText*: proc(self: ptr ICommDlgBrowser2, ppshv: ptr IShellView, pszText: LPWSTR, cchMax: int32): HRESULT {.stdcall.}
    GetViewFlags*: proc(self: ptr ICommDlgBrowser2, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
  LPCOMMDLGBROWSER2* = ptr ICommDlgBrowser2
  LPSHELLBROWSER* = ptr IShellBrowser
  STGTRANSCONFIRMATION* = GUID
  LPSTGTRANSCONFIRMATION* = ptr GUID
  SHDRAGIMAGE* {.pure.} = object
    sizeDragImage*: SIZE
    ptOffset*: POINT
    hbmpDragImage*: HBITMAP
    crColorKey*: COLORREF
  LPSHDRAGIMAGE* = ptr SHDRAGIMAGE
  IShellExtInit* {.pure.} = object
    lpVtbl*: ptr IShellExtInitVtbl
  IShellExtInitVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IShellExtInit, pidlFolder: PCIDLIST_ABSOLUTE, pdtobj: ptr IDataObject, hkeyProgID: HKEY): HRESULT {.stdcall.}
  LPSHELLEXTINIT* = ptr IShellExtInit
  EXPPS* = UINT
  IShellPropSheetExt* {.pure.} = object
    lpVtbl*: ptr IShellPropSheetExtVtbl
  IShellPropSheetExtVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddPages*: proc(self: ptr IShellPropSheetExt, pfnAddPage: LPFNSVADDPROPSHEETPAGE, lParam: LPARAM): HRESULT {.stdcall.}
    ReplacePage*: proc(self: ptr IShellPropSheetExt, uPageID: EXPPS, pfnReplaceWith: LPFNSVADDPROPSHEETPAGE, lParam: LPARAM): HRESULT {.stdcall.}
  LPSHELLPROPSHEETEXT* = ptr IShellPropSheetExt
  IExtractImage* {.pure.} = object
    lpVtbl*: ptr IExtractImageVtbl
  IExtractImageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetLocation*: proc(self: ptr IExtractImage, pszPathBuffer: LPWSTR, cch: DWORD, pdwPriority: ptr DWORD, prgSize: ptr SIZE, dwRecClrDepth: DWORD, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
    Extract*: proc(self: ptr IExtractImage, phBmpThumbnail: ptr HBITMAP): HRESULT {.stdcall.}
  LPEXTRACTIMAGE* = ptr IExtractImage
  IExtractImage2* {.pure.} = object
    lpVtbl*: ptr IExtractImage2Vtbl
  IExtractImage2Vtbl* {.pure, inheritable.} = object of IExtractImageVtbl
    GetDateStamp*: proc(self: ptr IExtractImage2, pDateStamp: ptr FILETIME): HRESULT {.stdcall.}
  LPEXTRACTIMAGE2* = ptr IExtractImage2
  THUMBBUTTON* {.pure.} = object
    dwMask*: THUMBBUTTONMASK
    iId*: UINT
    iBitmap*: UINT
    hIcon*: HICON
    szTip*: array[260, WCHAR]
    dwFlags*: THUMBBUTTONFLAGS
  LPTHUMBBUTTON* = ptr THUMBBUTTON
  DELEGATEITEMID* {.pure, packed.} = object
    cbSize*: WORD
    wOuter*: WORD
    cbInner*: WORD
    rgb*: array[1, BYTE]
  PCDELEGATEITEMID* = ptr DELEGATEITEMID
  PDELEGATEITEMID* = ptr DELEGATEITEMID
  IBrowserFrameOptions* {.pure.} = object
    lpVtbl*: ptr IBrowserFrameOptionsVtbl
  IBrowserFrameOptionsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetFrameOptions*: proc(self: ptr IBrowserFrameOptions, dwMask: BROWSERFRAMEOPTIONS, pdwOptions: ptr BROWSERFRAMEOPTIONS): HRESULT {.stdcall.}
  LPBROWSERFRAMEOPTIONS* = ptr IBrowserFrameOptions
  SMDATA* {.pure.} = object
    dwMask*: DWORD
    dwFlags*: DWORD
    hmenu*: HMENU
    hwnd*: HWND
    uId*: UINT
    uIdParent*: UINT
    uIdAncestor*: UINT
    punk*: ptr IUnknown
    pidlFolder*: PIDLIST_ABSOLUTE
    pidlItem*: PUITEMID_CHILD
    psf*: ptr IShellFolder
    pvUserData*: pointer
  LPSMDATA* = ptr SMDATA
  SMINFO* {.pure.} = object
    dwMask*: DWORD
    dwType*: DWORD
    dwFlags*: DWORD
    iIcon*: int32
  PSMINFO* = ptr SMINFO
  EXPLORERPANE* = GUID
  REFEXPLORERPANE* = ptr EXPLORERPANE
  IExtractIconA* {.pure.} = object
    lpVtbl*: ptr IExtractIconAVtbl
  IExtractIconAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetIconLocation*: proc(self: ptr IExtractIconA, uFlags: UINT, pszIconFile: PSTR, cchMax: UINT, piIndex: ptr int32, pwFlags: ptr UINT): HRESULT {.stdcall.}
    Extract*: proc(self: ptr IExtractIconA, pszFile: PCSTR, nIconIndex: UINT, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIconSize: UINT): HRESULT {.stdcall.}
  LPEXTRACTICONA* = ptr IExtractIconA
  IExtractIconW* {.pure.} = object
    lpVtbl*: ptr IExtractIconWVtbl
  IExtractIconWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetIconLocation*: proc(self: ptr IExtractIconW, uFlags: UINT, pszIconFile: PWSTR, cchMax: UINT, piIndex: ptr int32, pwFlags: ptr UINT): HRESULT {.stdcall.}
    Extract*: proc(self: ptr IExtractIconW, pszFile: PCWSTR, nIconIndex: UINT, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIconSize: UINT): HRESULT {.stdcall.}
  LPEXTRACTICONW* = ptr IExtractIconW
  DATABLOCK_HEADER* {.pure.} = object
    cbSize*: DWORD
    dwSignature*: DWORD
  LPDATABLOCK_HEADER* = ptr DATABLOCK_HEADER
  LPDBLIST* = ptr DATABLOCK_HEADER
  NT_CONSOLE_PROPS* {.pure.} = object
    dbh*: DATABLOCK_HEADER
    wFillAttribute*: WORD
    wPopupFillAttribute*: WORD
    dwScreenBufferSize*: COORD
    dwWindowSize*: COORD
    dwWindowOrigin*: COORD
    nFont*: DWORD
    nInputBufferSize*: DWORD
    dwFontSize*: COORD
    uFontFamily*: UINT
    uFontWeight*: UINT
    FaceName*: array[LF_FACESIZE, WCHAR]
    uCursorSize*: UINT
    bFullScreen*: WINBOOL
    bQuickEdit*: WINBOOL
    bInsertMode*: WINBOOL
    bAutoPosition*: WINBOOL
    uHistoryBufferSize*: UINT
    uNumberOfHistoryBuffers*: UINT
    bHistoryNoDup*: WINBOOL
    ColorTable*: array[16, COLORREF]
  LPNT_CONSOLE_PROPS* = ptr NT_CONSOLE_PROPS
  NT_FE_CONSOLE_PROPS* {.pure.} = object
    dbh*: DATABLOCK_HEADER
    uCodePage*: UINT
  LPNT_FE_CONSOLE_PROPS* = ptr NT_FE_CONSOLE_PROPS
  EXP_DARWIN_LINK* {.pure.} = object
    dbh*: DATABLOCK_HEADER
    szDarwinID*: array[MAX_PATH, CHAR]
    szwDarwinID*: array[MAX_PATH, WCHAR]
  LPEXP_DARWIN_LINK* = ptr EXP_DARWIN_LINK
  EXP_SPECIAL_FOLDER* {.pure.} = object
    cbSize*: DWORD
    dwSignature*: DWORD
    idSpecialFolder*: DWORD
    cbOffset*: DWORD
  LPEXP_SPECIAL_FOLDER* = ptr EXP_SPECIAL_FOLDER
  EXP_SZ_LINK* {.pure.} = object
    cbSize*: DWORD
    dwSignature*: DWORD
    szTarget*: array[MAX_PATH, CHAR]
    swzTarget*: array[MAX_PATH, WCHAR]
  LPEXP_SZ_LINK* = ptr EXP_SZ_LINK
  ICopyHookA* {.pure.} = object
    lpVtbl*: ptr ICopyHookAVtbl
  ICopyHookAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CopyCallback*: proc(self: ptr ICopyHookA, hwnd: HWND, wFunc: UINT, wFlags: UINT, pszSrcFile: PCSTR, dwSrcAttribs: DWORD, pszDestFile: PCSTR, dwDestAttribs: DWORD): UINT {.stdcall.}
  LPCOPYHOOKA* = ptr ICopyHookA
  ICopyHookW* {.pure.} = object
    lpVtbl*: ptr ICopyHookWVtbl
  ICopyHookWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CopyCallback*: proc(self: ptr ICopyHookW, hwnd: HWND, wFunc: UINT, wFlags: UINT, pszSrcFile: PCWSTR, dwSrcAttribs: DWORD, pszDestFile: PCWSTR, dwDestAttribs: DWORD): UINT {.stdcall.}
  LPCOPYHOOKW* = ptr ICopyHookW
  IFileViewerSite* {.pure.} = object
    lpVtbl*: ptr IFileViewerSiteVtbl
  IFileViewerSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetPinnedWindow*: proc(self: ptr IFileViewerSite, hwnd: HWND): HRESULT {.stdcall.}
    GetPinnedWindow*: proc(self: ptr IFileViewerSite, phwnd: ptr HWND): HRESULT {.stdcall.}
  LPFILEVIEWERSITE* = ptr IFileViewerSite
  FVSHOWINFO* {.pure.} = object
    cbSize*: DWORD
    hwndOwner*: HWND
    iShow*: int32
    dwFlags*: DWORD
    rect*: RECT
    punkRel*: ptr IUnknown
    strNewFile*: array[MAX_PATH, OLECHAR]
  LPFVSHOWINFO* = ptr FVSHOWINFO
  IFileViewerA* {.pure.} = object
    lpVtbl*: ptr IFileViewerAVtbl
  IFileViewerAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ShowInitialize*: proc(self: ptr IFileViewerA, lpfsi: LPFILEVIEWERSITE): HRESULT {.stdcall.}
    Show*: proc(self: ptr IFileViewerA, pvsi: LPFVSHOWINFO): HRESULT {.stdcall.}
    PrintTo*: proc(self: ptr IFileViewerA, pszDriver: PSTR, fSuppressUI: WINBOOL): HRESULT {.stdcall.}
  LPFILEVIEWERA* = ptr IFileViewerA
  IFileViewerW* {.pure.} = object
    lpVtbl*: ptr IFileViewerWVtbl
  IFileViewerWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ShowInitialize*: proc(self: ptr IFileViewerW, lpfsi: LPFILEVIEWERSITE): HRESULT {.stdcall.}
    Show*: proc(self: ptr IFileViewerW, pvsi: LPFVSHOWINFO): HRESULT {.stdcall.}
    PrintTo*: proc(self: ptr IFileViewerW, pszDriver: PWSTR, fSuppressUI: WINBOOL): HRESULT {.stdcall.}
  LPFILEVIEWERW* = ptr IFileViewerW
  SHFOLDERCUSTOMSETTINGS* {.pure.} = object
    dwSize*: DWORD
    dwMask*: DWORD
    pvid*: ptr SHELLVIEWID
    pszWebViewTemplate*: LPWSTR
    cchWebViewTemplate*: DWORD
    pszWebViewTemplateVersion*: LPWSTR
    pszInfoTip*: LPWSTR
    cchInfoTip*: DWORD
    pclsid*: ptr CLSID
    dwFlags*: DWORD
    pszIconFile*: LPWSTR
    cchIconFile*: DWORD
    iIconIndex*: int32
    pszLogo*: LPWSTR
    cchLogo*: DWORD
  LPSHFOLDERCUSTOMSETTINGS* = ptr SHFOLDERCUSTOMSETTINGS
  BFFCALLBACK* = proc (hwnd: HWND, uMsg: UINT, lParam: LPARAM, lpData: LPARAM): int32 {.stdcall.}
  BROWSEINFOA* {.pure.} = object
    hwndOwner*: HWND
    pidlRoot*: PCIDLIST_ABSOLUTE
    pszDisplayName*: LPSTR
    lpszTitle*: LPCSTR
    ulFlags*: UINT
    lpfn*: BFFCALLBACK
    lParam*: LPARAM
    iImage*: int32
  PBROWSEINFOA* = ptr BROWSEINFOA
  LPBROWSEINFOA* = ptr BROWSEINFOA
  BROWSEINFOW* {.pure.} = object
    hwndOwner*: HWND
    pidlRoot*: PCIDLIST_ABSOLUTE
    pszDisplayName*: LPWSTR
    lpszTitle*: LPCWSTR
    ulFlags*: UINT
    lpfn*: BFFCALLBACK
    lParam*: LPARAM
    iImage*: int32
  PBROWSEINFOW* = ptr BROWSEINFOW
  LPBROWSEINFOW* = ptr BROWSEINFOW
  IThumbnailCapture* {.pure.} = object
    lpVtbl*: ptr IThumbnailCaptureVtbl
  IThumbnailCaptureVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CaptureThumbnail*: proc(self: ptr IThumbnailCapture, pMaxSize: ptr SIZE, pHTMLDoc2: ptr IUnknown, phbmThumbnail: ptr HBITMAP): HRESULT {.stdcall.}
  LPTHUMBNAILCAPTURE* = ptr IThumbnailCapture
  ENUMSHELLIMAGESTOREDATA* {.pure.} = object
    szPath*: array[MAX_PATH, WCHAR]
    ftTimeStamp*: FILETIME
  PENUMSHELLIMAGESTOREDATA* = ptr ENUMSHELLIMAGESTOREDATA
  IEnumShellImageStore* {.pure.} = object
    lpVtbl*: ptr IEnumShellImageStoreVtbl
  IEnumShellImageStoreVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Reset*: proc(self: ptr IEnumShellImageStore): HRESULT {.stdcall.}
    Next*: proc(self: ptr IEnumShellImageStore, celt: ULONG, prgElt: ptr PENUMSHELLIMAGESTOREDATA, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumShellImageStore, celt: ULONG): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumShellImageStore, ppEnum: ptr ptr IEnumShellImageStore): HRESULT {.stdcall.}
  LPENUMSHELLIMAGESTORE* = ptr IEnumShellImageStore
  IShellImageStore* {.pure.} = object
    lpVtbl*: ptr IShellImageStoreVtbl
  IShellImageStoreVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Open*: proc(self: ptr IShellImageStore, dwMode: DWORD, pdwLock: ptr DWORD): HRESULT {.stdcall.}
    Create*: proc(self: ptr IShellImageStore, dwMode: DWORD, pdwLock: ptr DWORD): HRESULT {.stdcall.}
    ReleaseLock*: proc(self: ptr IShellImageStore, pdwLock: ptr DWORD): HRESULT {.stdcall.}
    Close*: proc(self: ptr IShellImageStore, pdwLock: ptr DWORD): HRESULT {.stdcall.}
    Commit*: proc(self: ptr IShellImageStore, pdwLock: ptr DWORD): HRESULT {.stdcall.}
    IsLocked*: proc(self: ptr IShellImageStore): HRESULT {.stdcall.}
    GetMode*: proc(self: ptr IShellImageStore, pdwMode: ptr DWORD): HRESULT {.stdcall.}
    GetCapabilities*: proc(self: ptr IShellImageStore, pdwCapMask: ptr DWORD): HRESULT {.stdcall.}
    AddEntry*: proc(self: ptr IShellImageStore, pszName: PCWSTR, pftTimeStamp: ptr FILETIME, dwMode: DWORD, hImage: HBITMAP): HRESULT {.stdcall.}
    GetEntry*: proc(self: ptr IShellImageStore, pszName: PCWSTR, dwMode: DWORD, phImage: ptr HBITMAP): HRESULT {.stdcall.}
    DeleteEntry*: proc(self: ptr IShellImageStore, pszName: PCWSTR): HRESULT {.stdcall.}
    IsEntryInStore*: proc(self: ptr IShellImageStore, pszName: PCWSTR, pftTimeStamp: ptr FILETIME): HRESULT {.stdcall.}
    Enum*: proc(self: ptr IShellImageStore, ppEnum: ptr LPENUMSHELLIMAGESTORE): HRESULT {.stdcall.}
  LPSHELLIMAGESTORE* = ptr IShellImageStore
  BANDINFOSFB* {.pure.} = object
    dwMask*: DWORD
    dwStateMask*: DWORD
    dwState*: DWORD
    crBkgnd*: COLORREF
    crBtnLt*: COLORREF
    crBtnDk*: COLORREF
    wViewMode*: WORD
    wAlign*: WORD
    psf*: ptr IShellFolder
    pidl*: PIDLIST_ABSOLUTE
  PBANDINFOSFB* = ptr BANDINFOSFB
  WALLPAPEROPT* {.pure.} = object
    dwSize*: DWORD
    dwStyle*: DWORD
  LPWALLPAPEROPT* = ptr WALLPAPEROPT
  LPCWALLPAPEROPT* = ptr WALLPAPEROPT
  COMPONENTSOPT* {.pure.} = object
    dwSize*: DWORD
    fEnableComponents*: WINBOOL
    fActiveDesktop*: WINBOOL
  LPCOMPONENTSOPT* = ptr COMPONENTSOPT
  LPCCOMPONENTSOPT* = ptr COMPONENTSOPT
  COMPPOS* {.pure.} = object
    dwSize*: DWORD
    iLeft*: int32
    iTop*: int32
    dwWidth*: DWORD
    dwHeight*: DWORD
    izIndex*: int32
    fCanResize*: WINBOOL
    fCanResizeX*: WINBOOL
    fCanResizeY*: WINBOOL
    iPreferredLeftPercent*: int32
    iPreferredTopPercent*: int32
  LPCOMPPOS* = ptr COMPPOS
  LPCCOMPPOS* = ptr COMPPOS
  COMPSTATEINFO* {.pure.} = object
    dwSize*: DWORD
    iLeft*: int32
    iTop*: int32
    dwWidth*: DWORD
    dwHeight*: DWORD
    dwItemState*: DWORD
  LPCOMPSTATEINFO* = ptr COMPSTATEINFO
  LPCCOMPSTATEINFO* = ptr COMPSTATEINFO
  IE4COMPONENT* {.pure.} = object
    dwSize*: DWORD
    dwID*: DWORD
    iComponentType*: int32
    fChecked*: WINBOOL
    fDirty*: WINBOOL
    fNoScroll*: WINBOOL
    cpPos*: COMPPOS
    wszFriendlyName*: array[MAX_PATH, WCHAR]
    wszSource*: array[2084, WCHAR]
    wszSubscribedURL*: array[2084, WCHAR]
  LPIE4COMPONENT* = ptr IE4COMPONENT
  LPCIE4COMPONENT* = ptr IE4COMPONENT
  COMPONENT* {.pure.} = object
    dwSize*: DWORD
    dwID*: DWORD
    iComponentType*: int32
    fChecked*: WINBOOL
    fDirty*: WINBOOL
    fNoScroll*: WINBOOL
    cpPos*: COMPPOS
    wszFriendlyName*: array[MAX_PATH, WCHAR]
    wszSource*: array[2084, WCHAR]
    wszSubscribedURL*: array[2084, WCHAR]
    dwCurItemState*: DWORD
    csiOriginal*: COMPSTATEINFO
    csiRestored*: COMPSTATEINFO
  LPCOMPONENT* = ptr COMPONENT
  LPCCOMPONENT* = ptr COMPONENT
  IActiveDesktop* {.pure.} = object
    lpVtbl*: ptr IActiveDesktopVtbl
  IActiveDesktopVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ApplyChanges*: proc(self: ptr IActiveDesktop, dwFlags: DWORD): HRESULT {.stdcall.}
    GetWallpaper*: proc(self: ptr IActiveDesktop, pwszWallpaper: PWSTR, cchWallpaper: UINT, dwFlags: DWORD): HRESULT {.stdcall.}
    SetWallpaper*: proc(self: ptr IActiveDesktop, pwszWallpaper: PCWSTR, dwReserved: DWORD): HRESULT {.stdcall.}
    GetWallpaperOptions*: proc(self: ptr IActiveDesktop, pwpo: LPWALLPAPEROPT, dwReserved: DWORD): HRESULT {.stdcall.}
    SetWallpaperOptions*: proc(self: ptr IActiveDesktop, pwpo: LPCWALLPAPEROPT, dwReserved: DWORD): HRESULT {.stdcall.}
    GetPattern*: proc(self: ptr IActiveDesktop, pwszPattern: PWSTR, cchPattern: UINT, dwReserved: DWORD): HRESULT {.stdcall.}
    SetPattern*: proc(self: ptr IActiveDesktop, pwszPattern: PCWSTR, dwReserved: DWORD): HRESULT {.stdcall.}
    GetDesktopItemOptions*: proc(self: ptr IActiveDesktop, pco: LPCOMPONENTSOPT, dwReserved: DWORD): HRESULT {.stdcall.}
    SetDesktopItemOptions*: proc(self: ptr IActiveDesktop, pco: LPCCOMPONENTSOPT, dwReserved: DWORD): HRESULT {.stdcall.}
    AddDesktopItem*: proc(self: ptr IActiveDesktop, pcomp: LPCCOMPONENT, dwReserved: DWORD): HRESULT {.stdcall.}
    AddDesktopItemWithUI*: proc(self: ptr IActiveDesktop, hwnd: HWND, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.stdcall.}
    ModifyDesktopItem*: proc(self: ptr IActiveDesktop, pcomp: LPCCOMPONENT, dwFlags: DWORD): HRESULT {.stdcall.}
    RemoveDesktopItem*: proc(self: ptr IActiveDesktop, pcomp: LPCCOMPONENT, dwReserved: DWORD): HRESULT {.stdcall.}
    GetDesktopItemCount*: proc(self: ptr IActiveDesktop, pcItems: ptr int32, dwReserved: DWORD): HRESULT {.stdcall.}
    GetDesktopItem*: proc(self: ptr IActiveDesktop, nComponent: int32, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.stdcall.}
    GetDesktopItemByID*: proc(self: ptr IActiveDesktop, dwID: ULONG_PTR, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.stdcall.}
    GenerateDesktopItemHtml*: proc(self: ptr IActiveDesktop, pwszFileName: PCWSTR, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.stdcall.}
    AddUrl*: proc(self: ptr IActiveDesktop, hwnd: HWND, pszSource: PCWSTR, pcomp: LPCOMPONENT, dwFlags: DWORD): HRESULT {.stdcall.}
    GetDesktopItemBySource*: proc(self: ptr IActiveDesktop, pwszSource: PCWSTR, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.stdcall.}
  LPACTIVEDESKTOP* = ptr IActiveDesktop
  IActiveDesktopP* {.pure.} = object
    lpVtbl*: ptr IActiveDesktopPVtbl
  IActiveDesktopPVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetSafeMode*: proc(self: ptr IActiveDesktopP, dwFlags: DWORD): HRESULT {.stdcall.}
    EnsureUpdateHTML*: proc(self: ptr IActiveDesktopP): HRESULT {.stdcall.}
    SetScheme*: proc(self: ptr IActiveDesktopP, pwszSchemeName: PCWSTR, dwFlags: DWORD): HRESULT {.stdcall.}
    GetScheme*: proc(self: ptr IActiveDesktopP, pwszSchemeName: PWSTR, pdwcchBuffer: ptr DWORD, dwFlags: DWORD): HRESULT {.stdcall.}
  LPACTIVEDESKTOPP* = ptr IActiveDesktopP
  IADesktopP2* {.pure.} = object
    lpVtbl*: ptr IADesktopP2Vtbl
  IADesktopP2Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ReReadWallpaper*: proc(self: ptr IADesktopP2): HRESULT {.stdcall.}
    GetADObjectFlags*: proc(self: ptr IADesktopP2, pdwFlags: ptr DWORD, dwMask: DWORD): HRESULT {.stdcall.}
    UpdateAllDesktopSubscriptions*: proc(self: ptr IADesktopP2): HRESULT {.stdcall.}
    MakeDynamicChanges*: proc(self: ptr IADesktopP2, pOleObj: ptr IOleObject): HRESULT {.stdcall.}
  LPADESKTOPP2* = ptr IADesktopP2
const
  MAX_COLUMN_NAME_LEN* = 80
  MAX_COLUMN_DESC_LEN* = 128
type
  SHCOLUMNINFO* {.pure, packed.} = object
    scid*: SHCOLUMNID
    vt*: VARTYPE
    fmt*: DWORD
    cChars*: UINT
    csFlags*: DWORD
    wszTitle*: array[MAX_COLUMN_NAME_LEN, WCHAR]
    wszDescription*: array[MAX_COLUMN_DESC_LEN, WCHAR]
  LPSHCOLUMNINFO* = ptr SHCOLUMNINFO
  LPCSHCOLUMNINFO* = ptr SHCOLUMNINFO
  SHCOLUMNINIT* {.pure.} = object
    dwFlags*: ULONG
    dwReserved*: ULONG
    wszFolder*: array[MAX_PATH, WCHAR]
  LPSHCOLUMNINIT* = ptr SHCOLUMNINIT
  LPCSHCOLUMNINIT* = ptr SHCOLUMNINIT
  SHCOLUMNDATA* {.pure.} = object
    dwFlags*: ULONG
    dwFileAttributes*: DWORD
    dwReserved*: ULONG
    pwszExt*: ptr WCHAR
    wszFile*: array[MAX_PATH, WCHAR]
  LPSHCOLUMNDATA* = ptr SHCOLUMNDATA
  LPCSHCOLUMNDATA* = ptr SHCOLUMNDATA
  NRESARRAY* {.pure.} = object
    cItems*: UINT
    nr*: array[1, NETRESOURCE]
  LPNRESARRAY* = ptr NRESARRAY
  CIDA* {.pure.} = object
    cidl*: UINT
    aoffset*: array[1, UINT]
  LPIDA* = ptr CIDA
  FILEDESCRIPTORA* {.pure.} = object
    dwFlags*: DWORD
    clsid*: CLSID
    sizel*: SIZEL
    pointl*: POINTL
    dwFileAttributes*: DWORD
    ftCreationTime*: FILETIME
    ftLastAccessTime*: FILETIME
    ftLastWriteTime*: FILETIME
    nFileSizeHigh*: DWORD
    nFileSizeLow*: DWORD
    cFileName*: array[MAX_PATH, CHAR]
  LPFILEDESCRIPTORA* = ptr FILEDESCRIPTORA
  FILEDESCRIPTORW* {.pure.} = object
    dwFlags*: DWORD
    clsid*: CLSID
    sizel*: SIZEL
    pointl*: POINTL
    dwFileAttributes*: DWORD
    ftCreationTime*: FILETIME
    ftLastAccessTime*: FILETIME
    ftLastWriteTime*: FILETIME
    nFileSizeHigh*: DWORD
    nFileSizeLow*: DWORD
    cFileName*: array[MAX_PATH, WCHAR]
  LPFILEDESCRIPTORW* = ptr FILEDESCRIPTORW
  FILEGROUPDESCRIPTORA* {.pure.} = object
    cItems*: UINT
    fgd*: array[1, FILEDESCRIPTORA]
  LPFILEGROUPDESCRIPTORA* = ptr FILEGROUPDESCRIPTORA
  FILEGROUPDESCRIPTORW* {.pure.} = object
    cItems*: UINT
    fgd*: array[1, FILEDESCRIPTORW]
  LPFILEGROUPDESCRIPTORW* = ptr FILEGROUPDESCRIPTORW
  DROPFILES* {.pure.} = object
    pFiles*: DWORD
    pt*: POINT
    fNC*: WINBOOL
    fWide*: WINBOOL
  LPDROPFILES* = ptr DROPFILES
  SHChangeDWORDAsIDList* {.pure, packed.} = object
    cb*: USHORT
    dwItem1*: DWORD
    dwItem2*: DWORD
    cbZero*: USHORT
  LPSHChangeDWORDAsIDList* = ptr SHChangeDWORDAsIDList
  SHChangeUpdateImageIDList* {.pure, packed.} = object
    cb*: USHORT
    iIconIndex*: int32
    iCurIndex*: int32
    uFlags*: UINT
    dwProcessID*: DWORD
    szName*: array[MAX_PATH, WCHAR]
    cbZero*: USHORT
  LPSHChangeUpdateImageIDList* = ptr SHChangeUpdateImageIDList
  SHChangeProductKeyAsIDList* {.pure.} = object
    cb*: USHORT
    wszProductKey*: array[39, WCHAR]
    cbZero*: USHORT
  LPSHChangeProductKeyAsIDList* = ptr SHChangeProductKeyAsIDList
  SHDESCRIPTIONID* {.pure.} = object
    dwDescriptionId*: DWORD
    clsid*: CLSID
  LPSHDESCRIPTIONID* = ptr SHDESCRIPTIONID
  CABINETSTATE* {.pure.} = object
    cLength*: WORD
    nVersion*: WORD
    fFullPathTitle* {.bitsize:1.}: WINBOOL
    fSaveLocalView* {.bitsize:1.}: WINBOOL
    fNotShell* {.bitsize:1.}: WINBOOL
    fSimpleDefault* {.bitsize:1.}: WINBOOL
    fDontShowDescBar* {.bitsize:1.}: WINBOOL
    fNewWindowMode* {.bitsize:1.}: WINBOOL
    fShowCompColor* {.bitsize:1.}: WINBOOL
    fDontPrettyNames* {.bitsize:1.}: WINBOOL
    fAdminsCreateCommonGroups* {.bitsize:1.}: WINBOOL
    fUnusedFlags* {.bitsize:7.}: UINT
    fMenuEnumFilter*: UINT
  LPCABINETSTATE* = ptr CABINETSTATE
  OPENASINFO* {.pure.} = object
    pcszFile*: LPCWSTR
    pcszClass*: LPCWSTR
    oaifInFlags*: OPEN_AS_INFO_FLAGS
  POPENASINFO* = ptr OPENASINFO
const
  PIFNAMESIZE* = 30
  PIFSTARTLOCSIZE* = 63
  PIFPARAMSSIZE* = 64
  PIFDEFPATHSIZE* = 64
  PIFDEFFILESIZE* = 80
  PIFMAXFILEPATH* = 260
type
  PROPPRG* {.pure, packed.} = object
    flPrg*: WORD
    flPrgInit*: WORD
    achTitle*: array[PIFNAMESIZE, CHAR]
    achCmdLine*: array[PIFSTARTLOCSIZE+PIFPARAMSSIZE+1, CHAR]
    achWorkDir*: array[PIFDEFPATHSIZE, CHAR]
    wHotKey*: WORD
    achIconFile*: array[PIFDEFFILESIZE, CHAR]
    wIconIndex*: WORD
    dwEnhModeFlags*: DWORD
    dwRealModeFlags*: DWORD
    achOtherFile*: array[PIFDEFFILESIZE, CHAR]
    achPIFFile*: array[PIFMAXFILEPATH, CHAR]
  PPROPPRG* = ptr PROPPRG
  LPPROPPRG* = ptr PROPPRG
  LPCPROPPRG* = ptr PROPPRG
  QCMINFO_IDMAP_PLACEMENT* {.pure.} = object
    id*: UINT
    fFlags*: UINT
  QCMINFO_IDMAP* {.pure.} = object
    nMaxIds*: UINT
    pIdList*: array[1, QCMINFO_IDMAP_PLACEMENT]
  QCMINFO* {.pure.} = object
    hmenu*: HMENU
    indexMenu*: UINT
    idCmdFirst*: UINT
    idCmdLast*: UINT
    pIdMap*: ptr QCMINFO_IDMAP
  LPQCMINFO* = ptr QCMINFO
  TBINFO* {.pure.} = object
    cbuttons*: UINT
    uFlags*: UINT
  LPTBINFO* = ptr TBINFO
  DETAILSINFO* {.pure.} = object
    pidl*: PCUITEMID_CHILD
    fmt*: int32
    cxChar*: int32
    str*: STRRET
    iImage*: int32
  PDETAILSINFO* = ptr DETAILSINFO
  DFMICS* {.pure.} = object
    cbSize*: DWORD
    fMask*: DWORD
    lParam*: LPARAM
    idCmdFirst*: UINT
    idDefMax*: UINT
    pici*: LPCMINVOKECOMMANDINFO
    punkSite*: ptr IUnknown
  PDFMICS* = ptr DFMICS
  LPFNVIEWCALLBACK* = proc (psvOuter: ptr IShellView, psf: ptr IShellFolder, hwndMain: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
  CSFV* {.pure.} = object
    cbSize*: UINT
    pshf*: ptr IShellFolder
    psvOuter*: ptr IShellView
    pidl*: PCIDLIST_ABSOLUTE
    lEvents*: LONG
    pfnCallback*: LPFNVIEWCALLBACK
    fvm*: FOLDERVIEWMODE
  LPCSFV* = ptr CSFV
  SFV_SETITEMPOS* {.pure.} = object
    pidl*: PCUITEMID_CHILD
    pt*: POINT
  LPSFV_SETITEMPOS* = ptr SFV_SETITEMPOS
  PCSFV_SETITEMPOS* = ptr SFV_SETITEMPOS
  SHELLSTATEA* {.pure, packed.} = object
    fShowAllObjects* {.bitsize:1.}: WINBOOL
    fShowExtensions* {.bitsize:1.}: WINBOOL
    fNoConfirmRecycle* {.bitsize:1.}: WINBOOL
    fShowSysFiles* {.bitsize:1.}: WINBOOL
    fShowCompColor* {.bitsize:1.}: WINBOOL
    fDoubleClickInWebView* {.bitsize:1.}: WINBOOL
    fDesktopHTML* {.bitsize:1.}: WINBOOL
    fWin95Classic* {.bitsize:1.}: WINBOOL
    fDontPrettyPath* {.bitsize:1.}: WINBOOL
    fShowAttribCol* {.bitsize:1.}: WINBOOL
    fMapNetDrvBtn* {.bitsize:1.}: WINBOOL
    fShowInfoTip* {.bitsize:1.}: WINBOOL
    fHideIcons* {.bitsize:1.}: WINBOOL
    fWebView* {.bitsize:1.}: WINBOOL
    fFilter* {.bitsize:1.}: WINBOOL
    fShowSuperHidden* {.bitsize:1.}: WINBOOL
    fNoNetCrawling* {.bitsize:1.}: WINBOOL
    dwWin95Unused*: DWORD
    uWin95Unused*: UINT
    lParamSort*: LONG
    iSortDirection*: int32
    version*: UINT
    uNotUsed*: UINT
    fSepProcess* {.bitsize:1.}: WINBOOL
    fStartPanelOn* {.bitsize:1.}: WINBOOL
    fShowStartPage* {.bitsize:1.}: WINBOOL
    fAutoCheckSelect* {.bitsize:1.}: WINBOOL
    fIconsOnly* {.bitsize:1.}: WINBOOL
    fShowTypeOverlay* {.bitsize:1.}: WINBOOL
    fShowStatusBar* {.bitsize:1.}: WINBOOL
    fSpareFlags* {.bitsize:9.}: UINT
    padding*: array[2, byte]
  LPSHELLSTATEA* = ptr SHELLSTATEA
  SHELLSTATEW* {.pure, packed.} = object
    fShowAllObjects* {.bitsize:1.}: WINBOOL
    fShowExtensions* {.bitsize:1.}: WINBOOL
    fNoConfirmRecycle* {.bitsize:1.}: WINBOOL
    fShowSysFiles* {.bitsize:1.}: WINBOOL
    fShowCompColor* {.bitsize:1.}: WINBOOL
    fDoubleClickInWebView* {.bitsize:1.}: WINBOOL
    fDesktopHTML* {.bitsize:1.}: WINBOOL
    fWin95Classic* {.bitsize:1.}: WINBOOL
    fDontPrettyPath* {.bitsize:1.}: WINBOOL
    fShowAttribCol* {.bitsize:1.}: WINBOOL
    fMapNetDrvBtn* {.bitsize:1.}: WINBOOL
    fShowInfoTip* {.bitsize:1.}: WINBOOL
    fHideIcons* {.bitsize:1.}: WINBOOL
    fWebView* {.bitsize:1.}: WINBOOL
    fFilter* {.bitsize:1.}: WINBOOL
    fShowSuperHidden* {.bitsize:1.}: WINBOOL
    fNoNetCrawling* {.bitsize:1.}: WINBOOL
    dwWin95Unused*: DWORD
    uWin95Unused*: UINT
    lParamSort*: LONG
    iSortDirection*: int32
    version*: UINT
    uNotUsed*: UINT
    fSepProcess* {.bitsize:1.}: WINBOOL
    fStartPanelOn* {.bitsize:1.}: WINBOOL
    fShowStartPage* {.bitsize:1.}: WINBOOL
    fAutoCheckSelect* {.bitsize:1.}: WINBOOL
    fIconsOnly* {.bitsize:1.}: WINBOOL
    fShowTypeOverlay* {.bitsize:1.}: WINBOOL
    fShowStatusBar* {.bitsize:1.}: WINBOOL
    fSpareFlags* {.bitsize:9.}: UINT
    padding*: array[2, byte]
  LPSHELLSTATEW* = ptr SHELLSTATEW
  SHELLFLAGSTATE* {.pure.} = object
    fShowAllObjects* {.bitsize:1.}: WINBOOL
    fShowExtensions* {.bitsize:1.}: WINBOOL
    fNoConfirmRecycle* {.bitsize:1.}: WINBOOL
    fShowSysFiles* {.bitsize:1.}: WINBOOL
    fShowCompColor* {.bitsize:1.}: WINBOOL
    fDoubleClickInWebView* {.bitsize:1.}: WINBOOL
    fDesktopHTML* {.bitsize:1.}: WINBOOL
    fWin95Classic* {.bitsize:1.}: WINBOOL
    fDontPrettyPath* {.bitsize:1.}: WINBOOL
    fShowAttribCol* {.bitsize:1.}: WINBOOL
    fMapNetDrvBtn* {.bitsize:1.}: WINBOOL
    fShowInfoTip* {.bitsize:1.}: WINBOOL
    fHideIcons* {.bitsize:1.}: WINBOOL
    fAutoCheckSelect* {.bitsize:1.}: WINBOOL
    fIconsOnly* {.bitsize:1.}: WINBOOL
    fRestFlags* {.bitsize:1.}: UINT
  LPSHELLFLAGSTATE* = ptr SHELLFLAGSTATE
  AASHELLMENUFILENAME* {.pure.} = object
    cbTotal*: SHORT
    rgbReserved*: array[12, BYTE]
    szFileName*: array[1, WCHAR]
  LPAASHELLMENUFILENAME* = ptr AASHELLMENUFILENAME
  AASHELLMENUITEM* {.pure.} = object
    lpReserved1*: pointer
    iReserved*: int32
    uiReserved*: UINT
    lpName*: LPAASHELLMENUFILENAME
    psz*: LPWSTR
  LPAASHELLMENUITEM* = ptr AASHELLMENUITEM
  SMCSHCHANGENOTIFYSTRUCT* {.pure.} = object
    lEvent*: LONG
    pidl1*: PCIDLIST_ABSOLUTE
    pidl2*: PCIDLIST_ABSOLUTE
  PSMCSHCHANGENOTIFYSTRUCT* = ptr SMCSHCHANGENOTIFYSTRUCT
const
  ABM_NEW* = 0x00000000
  ABM_REMOVE* = 0x00000001
  ABM_QUERYPOS* = 0x00000002
  ABM_SETPOS* = 0x00000003
  ABM_GETSTATE* = 0x00000004
  ABM_GETTASKBARPOS* = 0x00000005
  ABM_ACTIVATE* = 0x00000006
  ABM_GETAUTOHIDEBAR* = 0x00000007
  ABM_SETAUTOHIDEBAR* = 0x00000008
  ABM_WINDOWPOSCHANGED* = 0x0000009
  ABM_SETSTATE* = 0x0000000a
  ABM_GETAUTOHIDEBAREX* = 0x0000000b
  ABM_SETAUTOHIDEBAREX* = 0x0000000c
  ABN_STATECHANGE* = 0x0000000
  ABN_POSCHANGED* = 0x0000001
  ABN_FULLSCREENAPP* = 0x0000002
  ABN_WINDOWARRANGE* = 0x0000003
  ABS_AUTOHIDE* = 0x0000001
  ABS_ALWAYSONTOP* = 0x0000002
  ABE_LEFT* = 0
  ABE_TOP* = 1
  ABE_RIGHT* = 2
  ABE_BOTTOM* = 3
  FO_MOVE* = 0x1
  FO_COPY* = 0x2
  FO_DELETE* = 0x3
  FO_RENAME* = 0x4
  FOF_MULTIDESTFILES* = 0x1
  FOF_CONFIRMMOUSE* = 0x2
  FOF_SILENT* = 0x4
  FOF_RENAMEONCOLLISION* = 0x8
  FOF_NOCONFIRMATION* = 0x10
  FOF_WANTMAPPINGHANDLE* = 0x20
  FOF_ALLOWUNDO* = 0x40
  FOF_FILESONLY* = 0x80
  FOF_SIMPLEPROGRESS* = 0x100
  FOF_NOCONFIRMMKDIR* = 0x200
  FOF_NOERRORUI* = 0x400
  FOF_NOCOPYSECURITYATTRIBS* = 0x800
  FOF_NORECURSION* = 0x1000
  FOF_NO_CONNECTED_ELEMENTS* = 0x2000
  FOF_WANTNUKEWARNING* = 0x4000
  FOF_NORECURSEREPARSE* = 0x8000
  FOF_NO_UI* = FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOERRORUI or FOF_NOCONFIRMMKDIR
  PO_DELETE* = 0x0013
  PO_RENAME* = 0x0014
  PO_PORTCHANGE* = 0x0020
  PO_REN_PORT* = 0x0034
  SE_ERR_FNF* = 2
  SE_ERR_PNF* = 3
  SE_ERR_ACCESSDENIED* = 5
  SE_ERR_OOM* = 8
  SE_ERR_DLLNOTFOUND* = 32
  SE_ERR_SHARE* = 26
  SE_ERR_ASSOCINCOMPLETE* = 27
  SE_ERR_DDETIMEOUT* = 28
  SE_ERR_DDEFAIL* = 29
  SE_ERR_DDEBUSY* = 30
  SE_ERR_NOASSOC* = 31
  SEE_MASK_DEFAULT* = 0x0
  SEE_MASK_CLASSNAME* = 0x1
  SEE_MASK_CLASSKEY* = 0x3
  SEE_MASK_IDLIST* = 0x4
  SEE_MASK_INVOKEIDLIST* = 0xc
  SEE_MASK_ICON* = 0x10
  SEE_MASK_HOTKEY* = 0x20
  SEE_MASK_NOCLOSEPROCESS* = 0x40
  SEE_MASK_CONNECTNETDRV* = 0x80
  SEE_MASK_NOASYNC* = 0x100
  SEE_MASK_FLAG_DDEWAIT* = SEE_MASK_NOASYNC
  SEE_MASK_DOENVSUBST* = 0x200
  SEE_MASK_FLAG_NO_UI* = 0x400
  SEE_MASK_UNICODE* = 0x4000
  SEE_MASK_NO_CONSOLE* = 0x8000
  SEE_MASK_ASYNCOK* = 0x100000
  SEE_MASK_HMONITOR* = 0x200000
  SEE_MASK_NOZONECHECKS* = 0x800000
  SEE_MASK_NOQUERYCLASSSTORE* = 0x1000000
  SEE_MASK_WAITFORINPUTIDLE* = 0x2000000
  SEE_MASK_FLAG_LOG_USAGE* = 0x4000000
  SEE_MASK_FLAG_HINST_IS_SITE* = 0x8000000
  ASSOCCLASS_SHELL_KEY* = 0
  ASSOCCLASS_PROGID_KEY* = 1
  ASSOCCLASS_PROGID_STR* = 2
  ASSOCCLASS_CLSID_KEY* = 3
  ASSOCCLASS_CLSID_STR* = 4
  ASSOCCLASS_APP_KEY* = 5
  ASSOCCLASS_APP_STR* = 6
  ASSOCCLASS_SYSTEM_STR* = 7
  ASSOCCLASS_FOLDER* = 8
  ASSOCCLASS_STAR* = 9
  ASSOCCLASS_FIXED_PROGID_STR* = 10
  ASSOCCLASS_PROTOCOL_STR* = 11
  SHERB_NOCONFIRMATION* = 0x00000001
  SHERB_NOPROGRESSUI* = 0x00000002
  SHERB_NOSOUND* = 0x00000004
  QUNS_NOT_PRESENT* = 1
  QUNS_BUSY* = 2
  QUNS_RUNNING_D3D_FULL_SCREEN* = 3
  QUNS_PRESENTATION_MODE* = 4
  QUNS_ACCEPTS_NOTIFICATIONS* = 5
  QUNS_QUIET_TIME* = 6
  QUNS_APP* = 7
  NIN_SELECT* = WM_USER+0
  NINF_KEY* = 0x1
  NIN_KEYSELECT* = NIN_SELECT or NINF_KEY
  NIN_BALLOONSHOW* = WM_USER+2
  NIN_BALLOONHIDE* = WM_USER+3
  NIN_BALLOONTIMEOUT* = WM_USER+4
  NIN_BALLOONUSERCLICK* = WM_USER+5
  NIN_POPUPOPEN* = WM_USER+6
  NIN_POPUPCLOSE* = WM_USER+7
  NIM_ADD* = 0x00000000
  NIM_MODIFY* = 0x00000001
  NIM_DELETE* = 0x00000002
  NIM_SETFOCUS* = 0x00000003
  NIM_SETVERSION* = 0x00000004
  NOTIFYICON_VERSION* = 3
  NOTIFYICON_VERSION_4* = 4
  NIF_MESSAGE* = 0x00000001
  NIF_ICON* = 0x00000002
  NIF_TIP* = 0x00000004
  NIF_STATE* = 0x00000008
  NIF_INFO* = 0x00000010
  NIF_GUID* = 0x00000020
  NIF_REALTIME* = 0x00000040
  NIF_SHOWTIP* = 0x00000080
  NIS_HIDDEN* = 0x00000001
  NIS_SHAREDICON* = 0x00000002
  NIIF_NONE* = 0x00000000
  NIIF_INFO* = 0x00000001
  NIIF_WARNING* = 0x00000002
  NIIF_ERROR* = 0x00000003
  NIIF_USER* = 0x00000004
  NIIF_ICON_MASK* = 0x0000000f
  NIIF_NOSOUND* = 0x00000010
  NIIF_LARGE_ICON* = 0x00000020
  NIIF_RESPECT_QUIET_TIME* = 0x00000080
  SHGFI_ICON* = 0x000000100
  SHGFI_DISPLAYNAME* = 0x000000200
  SHGFI_TYPENAME* = 0x000000400
  SHGFI_ATTRIBUTES* = 0x000000800
  SHGFI_ICONLOCATION* = 0x000001000
  SHGFI_EXETYPE* = 0x000002000
  SHGFI_SYSICONINDEX* = 0x000004000
  SHGFI_LINKOVERLAY* = 0x000008000
  SHGFI_SELECTED* = 0x000010000
  SHGFI_ATTR_SPECIFIED* = 0x000020000
  SHGFI_LARGEICON* = 0x000000000
  SHGFI_SMALLICON* = 0x000000001
  SHGFI_OPENICON* = 0x000000002
  SHGFI_SHELLICONSIZE* = 0x000000004
  SHGFI_PIDL* = 0x000000008
  SHGFI_USEFILEATTRIBUTES* = 0x000000010
  SHGFI_ADDOVERLAYS* = 0x000000020
  SHGFI_OVERLAYINDEX* = 0x000000040
  SHGSI_ICONLOCATION* = 0
  SHGSI_ICON* = SHGFI_ICON
  SHGSI_SYSICONINDEX* = SHGFI_SYSICONINDEX
  SHGSI_LINKOVERLAY* = SHGFI_LINKOVERLAY
  SHGSI_SELECTED* = SHGFI_SELECTED
  SHGSI_LARGEICON* = SHGFI_LARGEICON
  SHGSI_SMALLICON* = SHGFI_SMALLICON
  SHGSI_SHELLICONSIZE* = SHGFI_SHELLICONSIZE
  SIID_DOCNOASSOC* = 0
  SIID_DOCASSOC* = 1
  SIID_APPLICATION* = 2
  SIID_FOLDER* = 3
  SIID_FOLDEROPEN* = 4
  SIID_DRIVE525* = 5
  SIID_DRIVE35* = 6
  SIID_DRIVEREMOVE* = 7
  SIID_DRIVEFIXED* = 8
  SIID_DRIVENET* = 9
  SIID_DRIVENETDISABLED* = 10
  SIID_DRIVECD* = 11
  SIID_DRIVERAM* = 12
  SIID_WORLD* = 13
  SIID_SERVER* = 15
  SIID_PRINTER* = 16
  SIID_MYNETWORK* = 17
  SIID_FIND* = 22
  SIID_HELP* = 23
  SIID_SHARE* = 28
  SIID_LINK* = 29
  SIID_SLOWFILE* = 30
  SIID_RECYCLER* = 31
  SIID_RECYCLERFULL* = 32
  SIID_MEDIACDAUDIO* = 40
  SIID_LOCK* = 47
  SIID_AUTOLIST* = 49
  SIID_PRINTERNET* = 50
  SIID_SERVERSHARE* = 51
  SIID_PRINTERFAX* = 52
  SIID_PRINTERFAXNET* = 53
  SIID_PRINTERFILE* = 54
  SIID_STACK* = 55
  SIID_MEDIASVCD* = 56
  SIID_STUFFEDFOLDER* = 57
  SIID_DRIVEUNKNOWN* = 58
  SIID_DRIVEDVD* = 59
  SIID_MEDIADVD* = 60
  SIID_MEDIADVDRAM* = 61
  SIID_MEDIADVDRW* = 62
  SIID_MEDIADVDR* = 63
  SIID_MEDIADVDROM* = 64
  SIID_MEDIACDAUDIOPLUS* = 65
  SIID_MEDIACDRW* = 66
  SIID_MEDIACDR* = 67
  SIID_MEDIACDBURN* = 68
  SIID_MEDIABLANKCD* = 69
  SIID_MEDIACDROM* = 70
  SIID_AUDIOFILES* = 71
  SIID_IMAGEFILES* = 72
  SIID_VIDEOFILES* = 73
  SIID_MIXEDFILES* = 74
  SIID_FOLDERBACK* = 75
  SIID_FOLDERFRONT* = 76
  SIID_SHIELD* = 77
  SIID_WARNING* = 78
  SIID_INFO* = 79
  SIID_ERROR* = 80
  SIID_KEY* = 81
  SIID_SOFTWARE* = 82
  SIID_RENAME* = 83
  SIID_DELETE* = 84
  SIID_MEDIAAUDIODVD* = 85
  SIID_MEDIAMOVIEDVD* = 86
  SIID_MEDIAENHANCEDCD* = 87
  SIID_MEDIAENHANCEDDVD* = 88
  SIID_MEDIAHDDVD* = 89
  SIID_MEDIABLURAY* = 90
  SIID_MEDIAVCD* = 91
  SIID_MEDIADVDPLUSR* = 92
  SIID_MEDIADVDPLUSRW* = 93
  SIID_DESKTOPPC* = 94
  SIID_MOBILEPC* = 95
  SIID_USERS* = 96
  SIID_MEDIASMARTMEDIA* = 97
  SIID_MEDIACOMPACTFLASH* = 98
  SIID_DEVICECELLPHONE* = 99
  SIID_DEVICECAMERA* = 100
  SIID_DEVICEVIDEOCAMERA* = 101
  SIID_DEVICEAUDIOPLAYER* = 102
  SIID_NETWORKCONNECT* = 103
  SIID_INTERNET* = 104
  SIID_ZIPFILE* = 105
  SIID_SETTINGS* = 106
  SIID_DRIVEHDDVD* = 132
  SIID_DRIVEBD* = 133
  SIID_MEDIAHDDVDROM* = 134
  SIID_MEDIAHDDVDR* = 135
  SIID_MEDIAHDDVDRAM* = 136
  SIID_MEDIABDROM* = 137
  SIID_MEDIABDR* = 138
  SIID_MEDIABDRE* = 139
  SIID_CLUSTEREDDRIVE* = 140
  SIID_MAX_ICONS* = 175
  SIID_INVALID* = SHSTOCKICONID(-1)
  SHGNLI_PIDL* = 0x000000001
  SHGNLI_PREFIXNAME* = 0x000000002
  SHGNLI_NOUNIQUE* = 0x000000004
  SHGNLI_NOLNK* = 0x000000008
  SHGNLI_NOLOCNAME* = 0x000000010
  SHGNLI_USEURLEXT* = 0x000000020
  PRINTACTION_OPEN* = 0
  PRINTACTION_PROPERTIES* = 1
  PRINTACTION_NETINSTALL* = 2
  PRINTACTION_NETINSTALLLINK* = 3
  PRINTACTION_TESTPAGE* = 4
  PRINTACTION_OPENNETPRN* = 5
  PRINTACTION_DOCUMENTDEFAULTS* = 6
  PRINTACTION_SERVERPROPERTIES* = 7
  PRINT_PROP_FORCE_NAME* = 0x01
  OFFLINE_STATUS_LOCAL* = 0x0001
  OFFLINE_STATUS_REMOTE* = 0x0002
  OFFLINE_STATUS_INCOMPLETE* = 0x0004
  SHIL_LARGE* = 0
  SHIL_SMALL* = 1
  SHIL_EXTRALARGE* = 2
  SHIL_SYSSMALL* = 3
  SHIL_JUMBO* = 4
  SHIL_LAST* = SHIL_JUMBO
  WC_NETADDRESS* = "msctls_netaddress"
  NCM_GETADDRESS* = WM_USER+1
  NCM_SETALLOWTYPE* = WM_USER+2
  NCM_GETALLOWTYPE* = WM_USER+3
  NCM_DISPLAYERRORTIP* = WM_USER+4
  SZ_CONTENTTYPE_HTMLA* = "text/html"
  SZ_CONTENTTYPE_HTMLW* = "text/html"
  SZ_CONTENTTYPE_CDFA* = "application/x-cdf"
  SZ_CONTENTTYPE_CDFW* = "application/x-cdf"
  STIF_DEFAULT* = 0x00000000
  STIF_SUPPORT_HEX* = 0x00000001
  GCT_INVALID* = 0x0000
  GCT_LFNCHAR* = 0x0001
  GCT_SHORTCHAR* = 0x0002
  GCT_WILD* = 0x0004
  GCT_SEPARATOR* = 0x0008
  URL_SCHEME_INVALID* = -1
  URL_SCHEME_UNKNOWN* = 0
  URL_SCHEME_FTP* = 1
  URL_SCHEME_HTTP* = 2
  URL_SCHEME_GOPHER* = 3
  URL_SCHEME_MAILTO* = 4
  URL_SCHEME_NEWS* = 5
  URL_SCHEME_NNTP* = 6
  URL_SCHEME_TELNET* = 7
  URL_SCHEME_WAIS* = 8
  URL_SCHEME_FILE* = 9
  URL_SCHEME_MK* = 10
  URL_SCHEME_HTTPS* = 11
  URL_SCHEME_SHELL* = 12
  URL_SCHEME_SNEWS* = 13
  URL_SCHEME_LOCAL* = 14
  URL_SCHEME_JAVASCRIPT* = 15
  URL_SCHEME_VBSCRIPT* = 16
  URL_SCHEME_ABOUT* = 17
  URL_SCHEME_RES* = 18
  URL_SCHEME_MSSHELLROOTED* = 19
  URL_SCHEME_MSSHELLIDLIST* = 20
  URL_SCHEME_MSHELP* = 21
  URL_SCHEME_MAXVALUE* = 22
  URL_PART_NONE* = 0
  URL_PART_SCHEME* = 1
  URL_PART_HOSTNAME* = 2
  URL_PART_USERNAME* = 3
  URL_PART_PASSWORD* = 4
  URL_PART_PORT* = 5
  URL_PART_QUERY* = 6
  urlIsUrl* = 0
  urlIsOpaque* = 1
  urlIsNohistory* = 2
  urlIsFileurl* = 3
  urlIsAppliable* = 4
  urlIsDirectory* = 5
  urlIsHasquery* = 6
  urlUnescape* = 0x10000000
  URL_ESCAPE_UNSAFE* = 0x20000000
  URL_PLUGGABLE_PROTOCOL* = 0x40000000
  URL_WININET_COMPATIBILITY* = 0x80000000'i32
  URL_DONT_ESCAPE_EXTRA_INFO* = 0x02000000
  URL_DONT_UNESCAPE_EXTRA_INFO* = URL_DONT_ESCAPE_EXTRA_INFO
  URL_BROWSER_MODE* = URL_DONT_ESCAPE_EXTRA_INFO
  URL_ESCAPE_SPACES_ONLY* = 0x04000000
  URL_DONT_SIMPLIFY* = 0x08000000
  URL_NO_META* = URL_DONT_SIMPLIFY
  URL_UNESCAPE_INPLACE* = 0x00100000
  URL_CONVERT_IF_DOSPATH* = 0x00200000
  URL_UNESCAPE_HIGH_ANSI_ONLY* = 0x00400000
  URL_INTERNAL_PATH* = 0x00800000
  URL_FILE_USE_PATHURL* = 0x00010000
  URL_DONT_UNESCAPE* = 0x00020000
  URL_ESCAPE_PERCENT* = 0x00001000
  URL_ESCAPE_SEGMENT_ONLY* = 0x00002000
  URL_PARTFLAG_KEEPSCHEME* = 0x00000001
  URL_APPLY_DEFAULT* = 0x00000001
  URL_APPLY_GUESSSCHEME* = 0x00000002
  URL_APPLY_GUESSFILE* = 0x00000004
  URL_APPLY_FORCEAPPLY* = 0x00000008
  SRRF_RT_REG_NONE* = 0x00000001
  SRRF_RT_REG_SZ* = 0x00000002
  SRRF_RT_REG_EXPAND_SZ* = 0x00000004
  SRRF_RT_REG_BINARY* = 0x00000008
  SRRF_RT_REG_DWORD* = 0x00000010
  SRRF_RT_REG_MULTI_SZ* = 0x00000020
  SRRF_RT_REG_QWORD* = 0x00000040
  SRRF_RT_DWORD* = SRRF_RT_REG_BINARY or SRRF_RT_REG_DWORD
  SRRF_RT_QWORD* = SRRF_RT_REG_BINARY or SRRF_RT_REG_QWORD
  SRRF_RT_ANY* = 0x0000ffff
  SRRF_RM_ANY* = 0x00000000
  SRRF_RM_NORMAL* = 0x00010000
  SRRF_RM_SAFE* = 0x00020000
  SRRF_RM_SAFENETWORK* = 0x00040000
  SRRF_NOEXPAND* = 0x10000000
  SRRF_ZEROONFAILURE* = 0x20000000
  SHREGDEL_DEFAULT* = 0x00000000
  SHREGDEL_HKCU* = 0x00000001
  SHREGDEL_HKLM* = 0x00000010
  SHREGDEL_BOTH* = 0x00000011
  SHREGENUM_DEFAULT* = 0x00000000
  SHREGENUM_HKCU* = 0x00000001
  SHREGENUM_HKLM* = 0x00000010
  SHREGENUM_BOTH* = 0x00000011
  SHREGSET_HKCU* = 0x00000001
  SHREGSET_FORCE_HKCU* = 0x00000002
  SHREGSET_HKLM* = 0x00000004
  SHREGSET_FORCE_HKLM* = 0x00000008
  SHREGSET_DEFAULT* = SHREGSET_FORCE_HKCU or SHREGSET_HKLM
  ASSOCF_INIT_NOREMAPCLSID* = 0x00000001
  ASSOCF_INIT_BYEXENAME* = 0x00000002
  ASSOCF_OPEN_BYEXENAME* = 0x00000002
  ASSOCF_INIT_DEFAULTTOSTAR* = 0x00000004
  ASSOCF_INIT_DEFAULTTOFOLDER* = 0x00000008
  ASSOCF_NOUSERSETTINGS* = 0x00000010
  ASSOCF_NOTRUNCATE* = 0x00000020
  ASSOCF_VERIFY* = 0x00000040
  ASSOCF_REMAPRUNDLL* = 0x00000080
  ASSOCF_NOFIXUPS* = 0x00000100
  ASSOCF_IGNOREBASECLASS* = 0x00000200
  ASSOCF_INIT_IGNOREUNKNOWN* = 0x00000400
  ASSOCSTR_COMMAND* = 1
  ASSOCSTR_EXECUTABLE* = 2
  ASSOCSTR_FRIENDLYDOCNAME* = 3
  ASSOCSTR_FRIENDLYAPPNAME* = 4
  ASSOCSTR_NOOPEN* = 5
  ASSOCSTR_SHELLNEWVALUE* = 6
  ASSOCSTR_DDECOMMAND* = 7
  ASSOCSTR_DDEIFEXEC* = 8
  ASSOCSTR_DDEAPPLICATION* = 9
  ASSOCSTR_DDETOPIC* = 10
  ASSOCSTR_INFOTIP* = 11
  ASSOCSTR_QUICKTIP* = 12
  ASSOCSTR_TILEINFO* = 13
  ASSOCSTR_CONTENTTYPE* = 14
  ASSOCSTR_DEFAULTICON* = 15
  ASSOCSTR_SHELLEXTENSION* = 16
  ASSOCSTR_DROPTARGET* = 17
  ASSOCSTR_DELEGATEEXECUTE* = 18
  ASSOCSTR_MAX* = 19
  ASSOCKEY_SHELLEXECCLASS* = 1
  ASSOCKEY_APP* = 2
  ASSOCKEY_CLASS* = 3
  ASSOCKEY_BASECLASS* = 4
  ASSOCKEY_MAX* = 5
  ASSOCDATA_MSIDESCRIPTOR* = 1
  ASSOCDATA_NOACTIVATEHANDLER* = 2
  ASSOCDATA_QUERYCLASSSTORE* = 3
  ASSOCDATA_HASPERUSERASSOC* = 4
  ASSOCDATA_EDITFLAGS* = 5
  ASSOCDATA_VALUE* = 6
  ASSOCDATA_MAX* = 7
  ASSOCENUM_NONE* = 0
  SHGVSPB_PERUSER* = 0x00000001
  SHGVSPB_ALLUSERS* = 0x00000002
  SHGVSPB_PERFOLDER* = 0x00000004
  SHGVSPB_ALLFOLDERS* = 0x00000008
  SHGVSPB_INHERIT* = 0x00000010
  SHGVSPB_ROAM* = 0x00000020
  SHGVSPB_NOAUTODEFAULTS* = 0x80000000'i32
  SHGVSPB_FOLDER* = SHGVSPB_PERUSER or SHGVSPB_PERFOLDER
  SHGVSPB_FOLDERNODEFAULTS* = SHGVSPB_PERUSER or SHGVSPB_PERFOLDER or SHGVSPB_NOAUTODEFAULTS
  SHGVSPB_USERDEFAULTS* = SHGVSPB_PERUSER or SHGVSPB_ALLFOLDERS
  SHGVSPB_GLOBALDEAFAULTS* = SHGVSPB_ALLUSERS or SHGVSPB_ALLFOLDERS
  SHACF_DEFAULT* = 0x00000000
  SHACF_FILESYSTEM* = 0x00000001
  SHACF_URLHISTORY* = 0x00000002
  SHACF_URLMRU* = 0x00000004
  SHACF_URLALL* = SHACF_URLHISTORY or SHACF_URLMRU
  SHACF_USETAB* = 0x00000008
  SHACF_FILESYS_ONLY* = 0x00000010
  SHACF_FILESYS_DIRS* = 0x00000020
  SHACF_AUTOSUGGEST_FORCE_ON* = 0x10000000
  SHACF_AUTOSUGGEST_FORCE_OFF* = 0x20000000
  SHACF_AUTOAPPEND_FORCE_ON* = 0x40000000
  SHACF_AUTOAPPEND_FORCE_OFF* = 0x80000000'i32
  CTF_INSIST* = 0x00000001
  CTF_THREAD_REF* = 0x00000002
  CTF_PROCESS_REF* = 0x00000004
  CTF_COINIT* = 0x00000008
  CTF_FREELIBANDEXIT* = 0x00000010
  CTF_REF_COUNTED* = 0x00000020
  CTF_WAIT_ALLOWCOM* = 0x00000040
  DLLVER_PLATFORM_WINDOWS* = 0x00000001
  DLLVER_PLATFORM_NT* = 0x00000002
  DLLVER_MAJOR_MASK* = 0xFFFF000000000000
  DLLVER_MINOR_MASK* = 0x0000FFFF00000000
  DLLVER_BUILD_MASK* = 0x00000000FFFF0000'i32
  DLLVER_QFE_MASK* = 0x000000000000FFFF
  CSIDL_FLAG_CREATE* = 0x8000
  CSIDL_PERSONAL* = 0x0005
  CSIDL_MYPICTURES* = 0x0027
  CSIDL_APPDATA* = 0x001a
  CSIDL_MYMUSIC* = 0x000d
  CSIDL_MYVIDEO* = 0x000e
  SHGFP_TYPE_CURRENT* = 0
  SHGFP_TYPE_DEFAULT* = 1
  STR_MYDOCS_CLSID* = "{450D8FBA-AD25-11D0-98A8-0800361B1103}"
  PSGUID_INTERNETSHORTCUT* = DEFINE_GUID("000214a0-0000-0000-c000-000000000046")
  PSGUID_INTERNETSITE* = DEFINE_GUID("000214a1-0000-0000-c000-000000000046")
  IID_ICopyHookA* = DEFINE_GUID("000214ef-0000-0000-c000-000000000046")
  IID_IShellCopyHookA* = IID_ICopyHookA
  IID_ICopyHookW* = DEFINE_GUID("000214fc-0000-0000-c000-000000000046")
  IID_IShellCopyHookW* = IID_ICopyHookW
  IID_IShellLinkW* = DEFINE_GUID("000214f9-0000-0000-c000-000000000046")
  SID_LinkSite* = IID_IShellLinkW
  IID_IShellFolderViewCB* = DEFINE_GUID("2047e320-f2a9-11ce-ae65-08002b2e1262")
  SID_ShellFolderViewCB* = IID_IShellFolderViewCB
  IID_IShellBrowser* = DEFINE_GUID("000214e2-0000-0000-c000-000000000046")
  SID_SShellBrowser* = IID_IShellBrowser
  CLSID_ShellDesktop* = DEFINE_GUID("00021400-0000-0000-c000-000000000046")
  SID_SShellDesktop* = CLSID_ShellDesktop
  CLSID_NetworkDomain* = DEFINE_GUID("46e06680-4bf0-11d1-83ee-00a0c90dc849")
  CLSID_NetworkServer* = DEFINE_GUID("c0542a90-4bf0-11d1-83ee-00a0c90dc849")
  CLSID_NetworkShare* = DEFINE_GUID("54a754c0-4bf0-11d1-83ee-00a0c90dc849")
  CLSID_MyComputer* = DEFINE_GUID("20d04fe0-3aea-1069-a2d8-08002b30309d")
  CLSID_Internet* = DEFINE_GUID("871c5380-42a0-1069-a2ea-08002b30309d")
  CLSID_RecycleBin* = DEFINE_GUID("645ff040-5081-101b-9f08-00aa002f954e")
  CLSID_ControlPanel* = DEFINE_GUID("21ec2020-3aea-1069-a2dd-08002b30309d")
  CLSID_Printers* = DEFINE_GUID("2227a280-3aea-1069-a2de-08002b30309d")
  CLSID_MyDocuments* = DEFINE_GUID("450d8fba-ad25-11d0-98a8-0800361b1103")
  CATID_BrowsableShellExt* = DEFINE_GUID("00021490-0000-0000-c000-000000000046")
  CATID_BrowseInPlace* = DEFINE_GUID("00021491-0000-0000-c000-000000000046")
  CATID_DeskBand* = DEFINE_GUID("00021492-0000-0000-c000-000000000046")
  CATID_InfoBand* = DEFINE_GUID("00021493-0000-0000-c000-000000000046")
  CATID_CommBand* = DEFINE_GUID("00021494-0000-0000-c000-000000000046")
  FMTID_Intshcut* = DEFINE_GUID("000214a0-0000-0000-c000-000000000046")
  FMTID_InternetSite* = DEFINE_GUID("000214a1-0000-0000-c000-000000000046")
  CGID_Explorer* = DEFINE_GUID("000214d0-0000-0000-c000-000000000046")
  CGID_ShellDocView* = DEFINE_GUID("000214d1-0000-0000-c000-000000000046")
  CGID_ShellServiceObject* = DEFINE_GUID("000214d2-0000-0000-c000-000000000046")
  CGID_ExplorerBarDoc* = DEFINE_GUID("000214d3-0000-0000-c000-000000000046")
  IID_INewShortcutHookA* = DEFINE_GUID("000214e1-0000-0000-c000-000000000046")
  IID_IExtractIconA* = DEFINE_GUID("000214eb-0000-0000-c000-000000000046")
  IID_IShellDetails* = DEFINE_GUID("000214ec-0000-0000-c000-000000000046")
  IID_IFileViewerA* = DEFINE_GUID("000214f0-0000-0000-c000-000000000046")
  IID_IFileViewerSite* = DEFINE_GUID("000214f3-0000-0000-c000-000000000046")
  IID_IShellExecuteHookA* = DEFINE_GUID("000214f5-0000-0000-c000-000000000046")
  IID_IPropSheetPage* = DEFINE_GUID("000214f6-0000-0000-c000-000000000046")
  IID_INewShortcutHookW* = DEFINE_GUID("000214f7-0000-0000-c000-000000000046")
  IID_IFileViewerW* = DEFINE_GUID("000214f8-0000-0000-c000-000000000046")
  IID_IExtractIconW* = DEFINE_GUID("000214fa-0000-0000-c000-000000000046")
  IID_IShellExecuteHookW* = DEFINE_GUID("000214fb-0000-0000-c000-000000000046")
  IID_IQueryInfo* = DEFINE_GUID("00021500-0000-0000-c000-000000000046")
  IID_IBriefcaseStg* = DEFINE_GUID("8bce1fa1-0921-101b-b1ff-00dd010ccc48")
  IID_IURLSearchHook* = DEFINE_GUID("ac60f6a0-0fd9-11d0-99cb-00c04fd64497")
  IID_ISearchContext* = DEFINE_GUID("09f656a2-41af-480c-88f7-16cc0d164615")
  IID_IURLSearchHook2* = DEFINE_GUID("5ee44da4-6d32-46e3-86bc-07540dedd0e0")
  IID_IDefViewID* = DEFINE_GUID("985f64f0-d410-4e02-be22-da07f2b5c5e1")
  CLSID_FolderShortcut* = DEFINE_GUID("0afaced1-e828-11d1-9187-b532f1e9575d")
  IID_IDockingWindowSite* = DEFINE_GUID("2a342fc2-7b26-11d0-8ca9-00a0c92dbfe8")
  IID_IDockingWindowFrame* = DEFINE_GUID("47d2657a-7b27-11d0-8ca9-00a0c92dbfe8")
  IID_IShellIconOverlay* = DEFINE_GUID("7d688a70-c613-11d0-999b-00c04fd655e1")
  IID_IShellIconOverlayIdentifier* = DEFINE_GUID("0c6c4200-c589-11d0-999a-00c04fd655e1")
  CLSID_CFSIconOverlayManager* = DEFINE_GUID("63b51f81-c868-11d0-999c-00c04fd655e1")
  IID_IShellIconOverlayManager* = DEFINE_GUID("f10b5e34-dd3b-42a7-aa7d-2f4ec54bb09b")
  IID_IThumbnailCapture* = DEFINE_GUID("4ea39266-7211-409f-b622-f63dbd16c533")
  IID_IShellImageStore* = DEFINE_GUID("48c8118c-b924-11d1-98d5-00c04fb687da")
  CLSID_ShellThumbnailDiskCache* = DEFINE_GUID("1ebdcf80-a200-11d0-a3a4-00c04fd706ec")
  SID_DefView* = DEFINE_GUID("6d12fe80-7911-11cf-9534-0000c05bae0b")
  CGID_DefView* = DEFINE_GUID("4af07f10-d231-11d0-b942-00a0c90312e1")
  CLSID_MenuBand* = DEFINE_GUID("5b4dae26-b807-11d0-9815-00c04fd91972")
  IID_IShellFolderBand* = DEFINE_GUID("7fe80cc8-c247-11d0-b93a-00a0c90312e1")
  IID_IDefViewFrame* = DEFINE_GUID("710eb7a0-45ed-11d0-924a-0020afc7ac4d")
  VID_LargeIcons* = DEFINE_GUID("0057d0e0-3573-11cf-ae69-08002b2e1262")
  VID_SmallIcons* = DEFINE_GUID("089000c0-3573-11cf-ae69-08002b2e1262")
  VID_List* = DEFINE_GUID("0e1fa5e0-3573-11cf-ae69-08002b2e1262")
  VID_Details* = DEFINE_GUID("137e7700-3573-11cf-ae69-08002b2e1262")
  VID_Tile* = DEFINE_GUID("65f125e5-7be1-4810-ba9d-d271c8432ce3")
  VID_Content* = DEFINE_GUID("30c2c434-0889-4c8d-985d-a9f71830b0a9")
  VID_Thumbnails* = DEFINE_GUID("8bebb290-52d0-11d0-b7f4-00c04fd706ec")
  VID_ThumbStrip* = DEFINE_GUID("8eefa624-d1e9-445b-94b7-74fbce2ea11a")
  SID_SInPlaceBrowser* = DEFINE_GUID("1d2ae02b-3655-46cc-b63a-285988153bca")
  SID_SSearchBoxInfo* = DEFINE_GUID("142daa61-516b-4713-b49c-fb985ef82998")
  SID_CommandsPropertyBag* = DEFINE_GUID("6e043250-4416-485c-b143-e62a760d9fe5")
  IID_IDiscardableBrowserProperty* = DEFINE_GUID("49c3de7c-d329-11d0-ab73-00c04fc33e80")
  IID_IShellChangeNotify* = DEFINE_GUID("d82be2b1-5764-11d0-a96e-00c04fd705a2")
  CLSID_InternetShortcut* = DEFINE_GUID("fbf23b40-e3f0-101b-8488-00aa003e56f8")
  IID_IUniformResourceLocatorA* = DEFINE_GUID("fbf23b80-e3f0-101b-8488-00aa003e56f8")
  IID_IUniformResourceLocatorW* = DEFINE_GUID("cabb0da0-da57-11cf-9974-0020afd79762")
  LIBID_Shell32* = DEFINE_GUID("50a7e9b0-70ef-11d1-b75a-00a0c90564fe")
  IID_IFolderViewOC* = DEFINE_GUID("9ba05970-f6a8-11cf-a442-00a0c90a8f39")
  DIID_DShellFolderViewEvents* = DEFINE_GUID("62112aa2-ebe4-11cf-a5fb-0020afe7292d")
  IID_DShellFolderViewEvents* = DEFINE_GUID("62112aa2-ebe4-11cf-a5fb-0020afe7292d")
  CLSID_ShellFolderViewOC* = DEFINE_GUID("9ba05971-f6a8-11cf-a442-00a0c90a8f39")
  IID_DFConstraint* = DEFINE_GUID("4a3df050-23bd-11d2-939f-00a0c91eedba")
  IID_Folder* = DEFINE_GUID("bbcbde60-c3ff-11ce-8350-444553540000")
  IID_Folder2* = DEFINE_GUID("f0d2d8ef-3890-11d2-bf8b-00c04fb93661")
  OFS_INACTIVE* = -1
  OFS_ONLINE* = 0
  OFS_OFFLINE* = 1
  OFS_SERVERBACK* = 2
  OFS_DIRTYCACHE* = 3
  IID_Folder3* = DEFINE_GUID("a7ae5f64-c4d7-4d7f-9307-4d24ee54b841")
  IID_FolderItem* = DEFINE_GUID("fac32c80-cbe4-11ce-8350-444553540000")
  IID_FolderItem2* = DEFINE_GUID("edc817aa-92b8-11d1-b075-00c04fc33aa5")
  CLSID_ShellFolderItem* = DEFINE_GUID("2fe352ea-fd1f-11d2-b1f4-00c04f8eeb3e")
  IID_FolderItems* = DEFINE_GUID("744129e0-cbe5-11ce-8350-444553540000")
  IID_FolderItems2* = DEFINE_GUID("c94f0ad0-f363-11d2-a327-00c04f8eec7f")
  IID_FolderItems3* = DEFINE_GUID("eaa7c309-bbec-49d5-821d-64d966cb667f")
  IID_FolderItemVerb* = DEFINE_GUID("08ec3e00-50b0-11cf-960c-0080c7f4ee85")
  IID_FolderItemVerbs* = DEFINE_GUID("1f8352c0-50b0-11cf-960c-0080c7f4ee85")
  IID_IShellLinkDual* = DEFINE_GUID("88a05c00-f000-11ce-8350-444553540000")
  IID_IShellLinkDual2* = DEFINE_GUID("317ee249-f12e-11d2-b1e4-00c04f8eeb3e")
  CLSID_ShellLinkObject* = DEFINE_GUID("11219420-1768-11d1-95be-00609797ea4f")
  IID_IShellFolderViewDual* = DEFINE_GUID("e7a1af80-4d96-11cf-960c-0080c7f4ee85")
  IID_IShellFolderViewDual2* = DEFINE_GUID("31c147b6-0ade-4a3c-b514-ddf932ef6d17")
  IID_IShellFolderViewDual3* = DEFINE_GUID("29ec8e6c-46d3-411f-baaa-611a6c9cac66")
  CLSID_ShellFolderView* = DEFINE_GUID("62112aa1-ebe4-11cf-a5fb-0020afe7292d")
  SFVVO_SHOWALLOBJECTS* = 0x1
  SFVVO_SHOWEXTENSIONS* = 0x2
  SFVVO_SHOWCOMPCOLOR* = 0x8
  SFVVO_SHOWSYSFILES* = 0x20
  SFVVO_WIN95CLASSIC* = 0x40
  SFVVO_DOUBLECLICKINWEBVIEW* = 0x80
  SFVVO_DESKTOPHTML* = 0x200
  IID_IShellDispatch* = DEFINE_GUID("d8f015c0-c278-11ce-a49e-444553540000")
  IID_IShellDispatch2* = DEFINE_GUID("a4c6892c-3ba9-11d2-9dea-00c04fb16162")
  IID_IShellDispatch3* = DEFINE_GUID("177160ca-bb5a-411c-841d-bd38facdeaa0")
  IID_IShellDispatch4* = DEFINE_GUID("efd84b2d-4bcf-4298-be25-eb542a59fbda")
  IID_IShellDispatch5* = DEFINE_GUID("866738b9-6cf2-4de8-8767-f794ebe74f4e")
  IID_IShellDispatch6* = DEFINE_GUID("286e6f1b-7113-4355-9562-96b7e9d64c54")
  CLSID_Shell* = DEFINE_GUID("13709620-c279-11ce-a49e-444553540000")
  CLSID_ShellDispatchInproc* = DEFINE_GUID("0a89a860-d7b1-11ce-8350-444553540000")
  ssfDESKTOP* = 0x0
  ssfPROGRAMS* = 0x2
  ssfCONTROLS* = 0x3
  ssfPRINTERS* = 0x4
  ssfPERSONAL* = 0x5
  ssfFAVORITES* = 0x6
  ssfSTARTUP* = 0x7
  ssfRECENT* = 0x8
  ssfSENDTO* = 0x9
  ssfBITBUCKET* = 0xa
  ssfSTARTMENU* = 0xb
  ssfDESKTOPDIRECTORY* = 0x10
  ssfDRIVES* = 0x11
  ssfNETWORK* = 0x12
  ssfNETHOOD* = 0x13
  ssfFONTS* = 0x14
  ssfTEMPLATES* = 0x15
  ssfCOMMONSTARTMENU* = 0x16
  ssfCOMMONPROGRAMS* = 0x17
  ssfCOMMONSTARTUP* = 0x18
  ssfCOMMONDESKTOPDIR* = 0x19
  ssfAPPDATA* = 0x1a
  ssfPRINTHOOD* = 0x1b
  ssfLOCALAPPDATA* = 0x1c
  ssfALTSTARTUP* = 0x1d
  ssfCOMMONALTSTARTUP* = 0x1e
  ssfCOMMONFAVORITES* = 0x1f
  ssfINTERNETCACHE* = 0x20
  ssfCOOKIES* = 0x21
  ssfHISTORY* = 0x22
  ssfCOMMONAPPDATA* = 0x23
  ssfWINDOWS* = 0x24
  ssfSYSTEM* = 0x25
  ssfPROGRAMFILES* = 0x26
  ssfMYPICTURES* = 0x27
  ssfPROFILE* = 0x28
  ssfSYSTEMx86* = 0x29
  ssfPROGRAMFILESx86* = 0x30
  IID_IFileSearchBand* = DEFINE_GUID("2d91eea1-9932-11d2-be86-00a0c9a83da1")
  CLSID_FileSearchBand* = DEFINE_GUID("c4ee31f3-4768-11d2-be5c-00a0c9a83da1")
  IID_IWebWizardHost* = DEFINE_GUID("18bcc359-4990-4bfb-b951-3c83702be5f9")
  IID_INewWDEvents* = DEFINE_GUID("0751c551-7568-41c9-8e5b-e22e38919236")
  IID_IAutoComplete* = DEFINE_GUID("00bb2762-6a77-11d0-a535-00c04fd7d062")
  ACO_NONE* = 0x0
  ACO_AUTOSUGGEST* = 0x1
  ACO_AUTOAPPEND* = 0x2
  ACO_SEARCH* = 0x4
  ACO_FILTERPREFIXES* = 0x8
  ACO_USETAB* = 0x10
  ACO_UPDOWNKEYDROPSLIST* = 0x20
  ACO_RTLREADING* = 0x40
  ACO_WORD_FILTER* = 0x80
  ACO_NOPREFIXFILTERING* = 0x100
  IID_IAutoComplete2* = DEFINE_GUID("eac04bc0-3791-11d2-bb95-0060977b464c")
  ACEO_NONE* = 0x0
  ACEO_MOSTRECENTFIRST* = 0x1
  ACEO_FIRSTUNUSED* = 0x10000
  IID_IEnumACString* = DEFINE_GUID("8e74c210-cf9d-4eaf-a403-7356428f0a5a")
  IID_IDataObjectAsyncCapability* = DEFINE_GUID("3d8b0590-f691-11d2-8ea9-006097df5bd4")
  SID_SInternetExplorer* = IID_IWebBrowserApp
  CLSID_ProgressDialog* = DEFINE_GUID("f8383852-fcd3-11d1-a6b9-006097df5bd4")
  SID_SProgressUI* = CLSID_ProgressDialog
  CLSID_CUrlHistory* = DEFINE_GUID("3c374a40-bae4-11cf-bf7d-00aa006946ee")
  SID_SUrlHistory* = CLSID_CUrlHistory
  SID_SWebBrowserApp* = IID_IWebBrowserApp
  CLSID_CURLSearchHook* = DEFINE_GUID("cfbfae00-17a6-11d0-99cb-00c04fd64497")
  IID_IObjMgr* = DEFINE_GUID("00bb2761-6a77-11d0-a535-00c04fd7d062")
  IID_IACList* = DEFINE_GUID("77a130b0-94fd-11d0-a544-00c04fd7d062")
  IID_IACList2* = DEFINE_GUID("470141a0-5186-11d2-bbb6-0060977b464c")
  IID_ICurrentWorkingDirectory* = DEFINE_GUID("91956d21-9276-11d1-921a-006097df5bd4")
  CLSID_AutoComplete* = DEFINE_GUID("00bb2763-6a77-11d0-a535-00c04fd7d062")
  CLSID_ACLHistory* = DEFINE_GUID("00bb2764-6a77-11d0-a535-00c04fd7d062")
  CLSID_ACListISF* = DEFINE_GUID("03c036f1-a186-11d0-824a-00aa005b4383")
  CLSID_ACLMRU* = DEFINE_GUID("6756a641-de71-11d0-831b-00aa005b4383")
  CLSID_ACLMulti* = DEFINE_GUID("00bb2765-6a77-11d0-a535-00c04fd7d062")
  CLSID_ACLCustomMRU* = DEFINE_GUID("6935db93-21e8-4ccc-beb9-9fe3c77a297a")
  IID_IProgressDialog* = DEFINE_GUID("ebbc7c04-315e-11d2-b62f-006097df5bd4")
  SID_STopLevelBrowser* = DEFINE_GUID("4c96be40-915c-11cf-99d3-00aa004ae837")
  PSGUID_SHELLDETAILS* = DEFINE_GUID("28636aa6-953d-11d2-b5d6-00c04fd918d0")
  PID_FINDDATA* = 0
  PID_NETRESOURCE* = 1
  PID_DESCRIPTIONID* = 2
  PID_WHICHFOLDER* = 3
  PID_NETWORKLOCATION* = 4
  PID_COMPUTERNAME* = 5
  PID_DISPLAY_PROPERTIES* = 0
  PID_INTROTEXT* = 1
  PID_SYNC_COPY_IN* = 2
  PIDSI_ARTIST* = 2
  PIDSI_SONGTITLE* = 3
  PIDSI_ALBUM* = 4
  PIDSI_YEAR* = 5
  PIDSI_COMMENT* = 6
  PIDSI_TRACK* = 7
  PIDSI_GENRE* = 11
  PIDSI_LYRICS* = 12
  PID_MISC_STATUS* = 2
  PID_MISC_ACCESSCOUNT* = 3
  PID_MISC_OWNER* = 4
  PID_HTMLINFOTIPFILE* = 5
  PID_MISC_PICS* = 6
  PIDDRSI_PROTECTED* = 2
  PIDDRSI_DESCRIPTION* = 3
  PIDDRSI_PLAYCOUNT* = 4
  PIDDRSI_PLAYSTARTS* = 5
  PIDDRSI_PLAYEXPIRES* = 6
  PID_DISPLACED_FROM* = 2
  PID_DISPLACED_DATE* = 3
  PSGUID_BRIEFCASE* = DEFINE_GUID("328d8b21-7729-4bfc-954c-902b329d56b0")
  PSGUID_MISC* = DEFINE_GUID("9b174b34-40ff-11d2-a27e-00c04fc30871")
  PSGUID_WEBVIEW* = DEFINE_GUID("f2275480-f782-4291-bd94-f13693513aec")
  PSGUID_MUSIC* = DEFINE_GUID("56a3372e-ce9c-11d2-9f0e-006097c686f6")
  PSGUID_DRM* = DEFINE_GUID("aeac19e4-89ae-4508-b9b7-bb867abee2ed")
  PSGUID_VIDEO* = DEFINE_GUID("64440491-4c8b-11d1-8b70-080036b11a03")
  PSGUID_IMAGEPROPERTIES* = DEFINE_GUID("14b81da1-0135-4d31-96d9-6cbfc9671a99")
  PSGUID_CUSTOMIMAGEPROPERTIES* = DEFINE_GUID("7ecd8b0e-c136-4a9b-9411-4ebd6673ccc3")
  PSGUID_LIBRARYPROPERTIES* = DEFINE_GUID("5d76b67f-9b3d-44bb-b6ae-25da4f638a67")
  PSGUID_DISPLACED* = DEFINE_GUID("9b174b33-40ff-11d2-a27e-00c04fc30871")
  CLSID_FileTypes* = DEFINE_GUID("b091e540-83e3-11cf-a713-0020afd79762")
  CLSID_ActiveDesktop* = DEFINE_GUID("75048700-ef1f-11d0-9888-006097deacf9")
  IID_IActiveDesktop* = DEFINE_GUID("f490eb00-1240-11d1-9888-006097deacf9")
  IID_IActiveDesktopP* = DEFINE_GUID("52502ee0-ec80-11d0-89ab-00c04fc2972d")
  IID_IADesktopP2* = DEFINE_GUID("b22754e2-4574-11d1-9888-006097deacf9")
  IID_ISynchronizedCallBack* = DEFINE_GUID("74c26041-70d1-11d1-b75a-00a0c90564fe")
  IID_IQueryAssociations* = DEFINE_GUID("c46ca590-3c3f-11d2-bee6-0000f805ca57")
  CLSID_QueryAssociations* = DEFINE_GUID("a07034fd-6caa-4954-ac3f-97a27216f98a")
  IID_IColumnProvider* = DEFINE_GUID("e8025004-1c42-11d2-be2c-00a0c9a83da1")
  CLSID_LinkColumnProvider* = DEFINE_GUID("24f14f02-7b1c-11d1-838f-0000f80461cf")
  CGID_ShortCut* = DEFINE_GUID("93a68750-951a-11d1-946f-000000000000")
  IID_INamedPropertyBag* = DEFINE_GUID("fb700430-952c-11d1-946f-000000000000")
  CLSID_InternetButtons* = DEFINE_GUID("1e796980-9cc5-11d1-a83f-00c04fc99d61")
  CLSID_MSOButtons* = DEFINE_GUID("178f34b8-a282-11d2-86c5-00c04f8eea99")
  CLSID_ToolbarExtButtons* = DEFINE_GUID("2ce4b5d8-a28f-11d2-86c5-00c04f8eea99")
  CLSID_DarwinAppPublisher* = DEFINE_GUID("cfccc7a0-a282-11d1-9082-006008059382")
  CLSID_DocHostUIHandler* = DEFINE_GUID("7057e952-bd1b-11d1-8919-00c04fc2c836")
  FMTID_ShellDetails* = DEFINE_GUID("28636aa6-953d-11d2-b5d6-00c04fd918d0")
  FMTID_Storage* = DEFINE_GUID("b725f130-47ef-101a-a5f1-02608c9eebac")
  FMTID_ImageProperties* = DEFINE_GUID("14b81da1-0135-4d31-96d9-6cbfc9671a99")
  FMTID_CustomImageProperties* = DEFINE_GUID("7ecd8b0e-c136-4a9b-9411-4ebd6673ccc3")
  FMTID_LibraryProperties* = DEFINE_GUID("5d76b67f-9b3d-44bb-b6ae-25da4f638a67")
  FMTID_Displaced* = DEFINE_GUID("9b174b33-40ff-11d2-a27e-00c04fc30871")
  FMTID_Briefcase* = DEFINE_GUID("328d8b21-7729-4bfc-954c-902b329d56b0")
  FMTID_Misc* = DEFINE_GUID("9b174b34-40ff-11d2-a27e-00c04fc30871")
  FMTID_WebView* = DEFINE_GUID("f2275480-f782-4291-bd94-f13693513aec")
  FMTID_MUSIC* = DEFINE_GUID("56a3372e-ce9c-11d2-9f0e-006097c686f6")
  FMTID_DRM* = DEFINE_GUID("aeac19e4-89ae-4508-b9b7-bb867abee2ed")
  PIDVSI_STREAM_NAME* = 0x00000002
  PIDVSI_FRAME_WIDTH* = 0x00000003
  PIDVSI_FRAME_HEIGHT* = 0x00000004
  PIDVSI_TIMELENGTH* = 0x00000007
  PIDVSI_FRAME_COUNT* = 0x00000005
  PIDVSI_FRAME_RATE* = 0x00000006
  PIDVSI_DATA_RATE* = 0x00000008
  PIDVSI_SAMPLE_SIZE* = 0x00000009
  PIDVSI_COMPRESSION* = 0x0000000a
  PIDVSI_STREAM_NUMBER* = 0x0000000b
  PSGUID_AUDIO* = DEFINE_GUID("64440490-4c8b-11d1-8b70-080036b11a03")
  PIDASI_FORMAT* = 0x00000002
  PIDASI_TIMELENGTH* = 0x00000003
  PIDASI_AVG_DATA_RATE* = 0x00000004
  PIDASI_SAMPLE_RATE* = 0x00000005
  PIDASI_SAMPLE_SIZE* = 0x00000006
  PIDASI_CHANNEL_COUNT* = 0x00000007
  PIDASI_STREAM_NUMBER* = 0x00000008
  PIDASI_STREAM_NAME* = 0x00000009
  PIDASI_COMPRESSION* = 0x0000000a
  PSGUID_CONTROLPANEL* = DEFINE_GUID("305ca226-d286-468e-b848-2b2e8e697b74")
  PID_CONTROLPANEL_CATEGORY* = 2
  PSGUID_VOLUME* = DEFINE_GUID("9b174b35-40ff-11d2-a27e-00c04fc30871")
  PSGUID_SHARE* = DEFINE_GUID("d8c3986f-813b-449c-845d-87b95d674ade")
  PSGUID_LINK* = DEFINE_GUID("b9b4b3fc-2b51-4a42-b5d8-324146afcf25")
  PSGUID_QUERY_D* = DEFINE_GUID("49691c90-7e17-101a-a91c-08002b2ecda9")
  PSGUID_SUMMARYINFORMATION* = DEFINE_GUID("f29f85e0-4ff9-1068-ab91-08002b27b3d9")
  PSGUID_DOCUMENTSUMMARYINFORMATION* = DEFINE_GUID("d5cdd502-2e9c-101b-9397-08002b2cf9ae")
  PSGUID_MEDIAFILESUMMARYINFORMATION* = DEFINE_GUID("64440492-4c8b-11d1-8b70-080036b11a03")
  PSGUID_IMAGESUMMARYINFORMATION* = DEFINE_GUID("6444048f-4c8b-11d1-8b70-080036b11a03")
  PID_VOLUME_FREE* = 2
  PID_VOLUME_CAPACITY* = 3
  PID_VOLUME_FILESYSTEM* = 4
  PID_SHARE_CSC_STATUS* = 2
  PID_LINK_TARGET* = 2
  PID_LINK_TARGET_TYPE* = 3
  PID_QUERY_RANK* = 2
  FMTID_Volume* = DEFINE_GUID("9b174b35-40ff-11d2-a27e-00c04fc30871")
  FMTID_Query* = DEFINE_GUID("49691c90-7e17-101a-a91c-08002b2ecda9")
  CLSID_HWShellExecute* = DEFINE_GUID("ffb8655f-81b9-4fce-b89c-9a6ba76d13e7")
  CLSID_DragDropHelper* = DEFINE_GUID("4657278a-411b-11d2-839a-00c04fd918d0")
  CLSID_CAnchorBrowsePropertyPage* = DEFINE_GUID("3050f3bb-98b5-11cf-bb82-00aa00bdce0b")
  CLSID_CImageBrowsePropertyPage* = DEFINE_GUID("3050f3b3-98b5-11cf-bb82-00aa00bdce0b")
  CLSID_CDocBrowsePropertyPage* = DEFINE_GUID("3050f3b4-98b5-11cf-bb82-00aa00bdce0b")
  SID_STopWindow* = DEFINE_GUID("49e1b500-4636-11d3-97f7-00c04f45d0b3")
  SID_SGetViewFromViewDual* = DEFINE_GUID("889a935d-971e-4b12-b90c-24dfc9e1e5e8")
  CLSID_FolderItem* = DEFINE_GUID("fef10fa2-355e-4e06-9381-9b24d7f7cc88")
  CLSID_FolderItemsMultiLevel* = DEFINE_GUID("53c74826-ab99-4d33-aca4-3117f51d3788")
  CLSID_NewMenu* = DEFINE_GUID("d969a300-e7ff-11d0-a93b-00a0c90f2719")
  BHID_SFObject* = DEFINE_GUID("3981e224-f559-11d3-8e3a-00c04f6837d5")
  BHID_SFUIObject* = DEFINE_GUID("3981e225-f559-11d3-8e3a-00c04f6837d5")
  BHID_SFViewObject* = DEFINE_GUID("3981e226-f559-11d3-8e3a-00c04f6837d5")
  BHID_Storage* = DEFINE_GUID("3981e227-f559-11d3-8e3a-00c04f6837d5")
  BHID_Stream* = DEFINE_GUID("1cebb3ab-7c10-499a-a417-92ca16c4cb83")
  BHID_RandomAccessStream* = DEFINE_GUID("f16fc93b-77ae-4cfe-bda7-a866eea6878d")
  BHID_LinkTargetItem* = DEFINE_GUID("3981e228-f559-11d3-8e3a-00c04f6837d5")
  BHID_StorageEnum* = DEFINE_GUID("4621a4e3-f0d6-4773-8a9c-46e77b174840")
  BHID_Transfer* = DEFINE_GUID("d5e346a1-f753-4932-b403-4574800e2498")
  BHID_PropertyStore* = DEFINE_GUID("0384e1a4-1523-439c-a4c8-ab911052f586")
  BHID_ThumbnailHandler* = DEFINE_GUID("7b2e650a-8e20-4f4a-b09e-6597afc72fb0")
  BHID_EnumItems* = DEFINE_GUID("94f60519-2850-4924-aa5a-d15e84868039")
  BHID_DataObject* = DEFINE_GUID("b8c0bd9f-ed24-455c-83e6-d5390c4fe8c4")
  BHID_AssociationArray* = DEFINE_GUID("bea9ef17-82f1-4f60-9284-4f8db75c3be9")
  BHID_Filter* = DEFINE_GUID("38d08778-f557-4690-9ebf-ba54706ad8f7")
  BHID_EnumAssocHandlers* = DEFINE_GUID("b8ab0b9c-c2ec-4f7a-918d-314900e6280a")
  SID_CtxQueryAssociations* = DEFINE_GUID("faadfc40-b777-4b69-aa81-77035ef0e6e8")
  IID_IDocViewSite* = DEFINE_GUID("87d605e0-c511-11cf-89a9-00a0c9054129")
  CLSID_QuickLinks* = DEFINE_GUID("0e5cbf21-d15f-11d0-8301-00aa005b4383")
  CLSID_ISFBand* = DEFINE_GUID("d82be2b0-5764-11d0-a96e-00c04fd705a2")
  IID_CDefView* = DEFINE_GUID("4434ff80-ef4c-11ce-ae65-08002b2e1262")
  CLSID_ShellFldSetExt* = DEFINE_GUID("6d5313c0-8c62-11d1-b2cd-006097df8c11")
  SID_SMenuBandChild* = DEFINE_GUID("ed9cc020-08b9-11d1-9823-00c04fd91972")
  SID_SMenuBandParent* = DEFINE_GUID("8c278eec-3eab-11d1-8cb0-00c04fd918d0")
  SID_SMenuPopup* = DEFINE_GUID("d1e7afeb-6a2e-11d0-8c78-00c04fd918b4")
  SID_SMenuBandBottomSelected* = DEFINE_GUID("165ebaf4-6d51-11d2-83ad-00c04fd918d0")
  SID_SMenuBandBottom* = DEFINE_GUID("743ca664-0deb-11d1-9825-00c04fd91972")
  SID_MenuShellFolder* = DEFINE_GUID("a6c17eb4-2d65-11d2-838f-00c04fd918d0")
  SID_SMenuBandContextMenuModifier* = DEFINE_GUID("39545874-7162-465e-b783-2aa1874fef81")
  SID_SMenuBandBKContextMenu* = DEFINE_GUID("164bbd86-1d0d-4de0-9a3b-d9729647c2b8")
  CGID_MENUDESKBAR* = DEFINE_GUID("5c9f0a12-959e-11d0-a3a4-00a0c9082636")
  SID_SMenuBandTop* = DEFINE_GUID("9493a810-ec38-11d0-bc46-00aa006ce2f5")
  CLSID_MenuToolbarBase* = DEFINE_GUID("40b96610-b522-11d1-b3b4-00aa006efde7")
  IID_IBanneredBar* = DEFINE_GUID("596a9a94-013e-11d1-8d34-00a0c90f2719")
  CLSID_MenuBandSite* = DEFINE_GUID("e13ef4e4-d2f2-11d0-9816-00c04fd91972")
  SID_SCommDlgBrowser* = DEFINE_GUID("80f30233-b7df-11d2-a33b-006097df5bd4")
  CPFG_LOGON_USERNAME* = DEFINE_GUID("da15bbe8-954d-4fd3-b0f4-1fb5b90b174b")
  CPFG_LOGON_PASSWORD* = DEFINE_GUID("60624cfa-a477-47b1-8a8e-3a4a19981827")
  CPFG_SMARTCARD_USERNAME* = DEFINE_GUID("3e1ecf69-568c-4d96-9d59-46444174e2d6")
  CPFG_SMARTCARD_PIN* = DEFINE_GUID("4fe5263b-9181-46c1-b0a4-9dedd4db7dea")
  CPFG_CREDENTIAL_PROVIDER_LOGO* = DEFINE_GUID("2d837775-f6cd-464e-a745-482fd0b47493")
  CPFG_CREDENTIAL_PROVIDER_LABEL* = DEFINE_GUID("286bbff3-bad4-438f-b007-79b7267c3d48")
  FOLDERID_AccountPictures* = DEFINE_GUID("008ca0b1-55b4-4c56-b8a8-4de4b299d3be")
  FOLDERID_AddNewPrograms* = DEFINE_GUID("de61d971-5ebc-4f02-a3a9-6c82895e5c04")
  FOLDERID_AdminTools* = DEFINE_GUID("724ef170-a42d-4fef-9f26-b60e846fba4f")
  FOLDERID_AppsFolder* = DEFINE_GUID("1e87508d-89c2-42f0-8a7e-645a0f50ca58")
  FOLDERID_ApplicationShortcuts* = DEFINE_GUID("a3918781-e5f2-4890-b3d9-a7e54332328c")
  FOLDERID_AppUpdates* = DEFINE_GUID("a305ce99-f527-492b-8b1a-7e76fa98d6e4")
  FOLDERID_CDBurning* = DEFINE_GUID("9e52ab10-f80d-49df-acb8-4330f5687855")
  FOLDERID_ChangeRemovePrograms* = DEFINE_GUID("df7266ac-9274-4867-8d55-3bd661de872d")
  FOLDERID_CommonAdminTools* = DEFINE_GUID("d0384e7d-bac3-4797-8f14-cba229b392b5")
  FOLDERID_CommonOEMLinks* = DEFINE_GUID("c1bae2d0-10df-4334-bedd-7aa20b227a9d")
  FOLDERID_CommonPrograms* = DEFINE_GUID("0139d44e-6afe-49f2-8690-3dafcae6ffb8")
  FOLDERID_CommonStartMenu* = DEFINE_GUID("a4115719-d62e-491d-aa7c-e74b8be3b067")
  FOLDERID_CommonStartup* = DEFINE_GUID("82a5ea35-d9cd-47c5-9629-e15d2f714e6e")
  FOLDERID_CommonTemplates* = DEFINE_GUID("b94237e7-57ac-4347-9151-b08c6c32d1f7")
  FOLDERID_ComputerFolder* = DEFINE_GUID("0ac0837c-bbf8-452a-850d-79d08e667ca7")
  FOLDERID_ConflictFolder* = DEFINE_GUID("4bfefb45-347d-4006-a5be-ac0cb0567192")
  FOLDERID_ConnectionsFolder* = DEFINE_GUID("6f0cd92b-2e97-45d1-88ff-b0d186b8dedd")
  FOLDERID_Contacts* = DEFINE_GUID("56784854-c6cb-462b-8169-88e350acb882")
  FOLDERID_ControlPanelFolder* = DEFINE_GUID("82a74aeb-aeb4-465c-a014-d097ee346d63")
  FOLDERID_Cookies* = DEFINE_GUID("2b0f765d-c0e9-4171-908e-08a611b84ff6")
  FOLDERID_Desktop* = DEFINE_GUID("b4bfcc3a-db2c-424c-b029-7fe99a87c641")
  FOLDERID_DeviceMetadataStore* = DEFINE_GUID("5ce4a5e9-e4eb-479d-b89f-130c02886155")
  FOLDERID_Documents* = DEFINE_GUID("fdd39ad0-238f-46af-adb4-6c85480369c7")
  FOLDERID_DocumentsLibrary* = DEFINE_GUID("7b0db17d-9cd2-4a93-9733-46cc89022e7c")
  FOLDERID_Downloads* = DEFINE_GUID("374de290-123f-4565-9164-39c4925e467b")
  FOLDERID_Favorites* = DEFINE_GUID("1777f761-68ad-4d8a-87bd-30b759fa33dd")
  FOLDERID_Fonts* = DEFINE_GUID("fd228cb7-ae11-4ae3-864c-16f3910ab8fe")
  FOLDERID_Games* = DEFINE_GUID("cac52c1a-b53d-4edc-92d7-6b2e8ac19434")
  FOLDERID_GameTasks* = DEFINE_GUID("054fae61-4dd8-4787-80b6-090220c4b700")
  FOLDERID_History* = DEFINE_GUID("d9dc8a3b-b784-432e-a781-5a1130a75963")
  FOLDERID_HomeGroup* = DEFINE_GUID("52528a6b-b9e3-4add-b60d-588c2dba842d")
  FOLDERID_HomeGroupCurrentUser* = DEFINE_GUID("9b74b6a3-0dfd-4f11-9e78-5f7800f2e772")
  FOLDERID_ImplicitAppShortcuts* = DEFINE_GUID("bcb5256f-79f6-4cee-b725-dc34e402fd46")
  FOLDERID_InternetCache* = DEFINE_GUID("352481e8-33be-4251-ba85-6007caedcf9d")
  FOLDERID_InternetFolder* = DEFINE_GUID("4d9f7874-4e0c-4904-967b-40b0d20c3e4b")
  FOLDERID_Libraries* = DEFINE_GUID("1b3ea5dc-b587-4786-b4ef-bd1dc332aeae")
  FOLDERID_Links* = DEFINE_GUID("bfb9d5e0-c6a9-404c-b2b2-ae6db6af4968")
  FOLDERID_LocalAppData* = DEFINE_GUID("f1b32785-6fba-4fcf-9d55-7b8e7f157091")
  FOLDERID_LocalAppDataLow* = DEFINE_GUID("a520a1a4-1780-4ff6-bd18-167343c5af16")
  FOLDERID_LocalizedResourcesDir* = DEFINE_GUID("2a00375e-224c-49de-b8d1-440df7ef3ddc")
  FOLDERID_Music* = DEFINE_GUID("4bd8d571-6d19-48d3-be97-422220080e43")
  FOLDERID_MusicLibrary* = DEFINE_GUID("2112ab0a-c86a-4ffe-a368-0de96e47012e")
  FOLDERID_NetHood* = DEFINE_GUID("c5abbf53-e17f-4121-8900-86626fc2c973")
  FOLDERID_NetworkFolder* = DEFINE_GUID("d20beec4-5ca8-4905-ae3b-bf251ea09b53")
  FOLDERID_OriginalImages* = DEFINE_GUID("2c36c0aa-5812-4b87-bfd0-4cd0dfb19b39")
  FOLDERID_PhotoAlbums* = DEFINE_GUID("69d2cf90-fc33-4fb7-9a0c-ebb0f0fcb43c")
  FOLDERID_Pictures* = DEFINE_GUID("33e28130-4e1e-4676-835a-98395c3bc3bb")
  FOLDERID_PicturesLibrary* = DEFINE_GUID("a990ae9f-a03b-4e80-94bc-9912d7504104")
  FOLDERID_Playlists* = DEFINE_GUID("de92c1c7-837f-4f69-a3bb-86e631204a23")
  FOLDERID_PrintHood* = DEFINE_GUID("9274bd8d-cfd1-41c3-b35e-b13f55a758f4")
  FOLDERID_PrintersFolder* = DEFINE_GUID("76fc4e2d-d6ad-4519-a663-37bd56068185")
  FOLDERID_Profile* = DEFINE_GUID("5e6c858f-0e22-4760-9afe-ea3317b67173")
  FOLDERID_ProgramData* = DEFINE_GUID("62ab5d82-fdc1-4dc3-a9dd-070d1d495d97")
  FOLDERID_ProgramFiles* = DEFINE_GUID("905e63b6-c1bf-494e-b29c-65b732d3d21a")
  FOLDERID_ProgramFilesX64* = DEFINE_GUID("6d809377-6af0-444b-8957-a3773f02200e")
  FOLDERID_ProgramFilesX86* = DEFINE_GUID("7c5a40ef-a0fb-4bfc-874a-c0f2e0b9fa8e")
  FOLDERID_ProgramFilesCommon* = DEFINE_GUID("f7f1ed05-9f6d-47a2-aaae-29d317c6f066")
  FOLDERID_ProgramFilesCommonX64* = DEFINE_GUID("6365d5a7-0f0d-45e5-87f6-0da56b6a4f7d")
  FOLDERID_ProgramFilesCommonX86* = DEFINE_GUID("de974d24-d9c6-4d3e-bf91-f4455120b917")
  FOLDERID_Programs* = DEFINE_GUID("a77f5d77-2e2b-44c3-a6a2-aba601054a51")
  FOLDERID_Public* = DEFINE_GUID("dfdf76a2-c82a-4d63-906a-5644ac457385")
  FOLDERID_PublicDesktop* = DEFINE_GUID("c4aa340d-f20f-4863-afef-f87ef2e6ba25")
  FOLDERID_PublicDocuments* = DEFINE_GUID("ed4824af-dce4-45a8-81e2-fc7965083634")
  FOLDERID_PublicDownloads* = DEFINE_GUID("3d644c9b-1fb8-4f30-9b45-f670235f79c0")
  FOLDERID_PublicGameTasks* = DEFINE_GUID("debf2536-e1a8-4c59-b6a2-414586476aea")
  FOLDERID_PublicLibraries* = DEFINE_GUID("48daf80b-e6cf-4f4e-b800-0e69d84ee384")
  FOLDERID_PublicMusic* = DEFINE_GUID("3214fab5-9757-4298-bb61-92a9deaa44ff")
  FOLDERID_PublicPictures* = DEFINE_GUID("b6ebfb86-6907-413c-9af7-4fc2abf07cc5")
  FOLDERID_PublicRingtones* = DEFINE_GUID("e555ab60-153b-4d17-9f04-a5fe99fc15ec")
  FOLDERID_PublicUserTiles* = DEFINE_GUID("0482af6c-08f1-4c34-8c90-e17ec98b1e17")
  FOLDERID_PublicVideos* = DEFINE_GUID("2400183a-6185-49fb-a2d8-4a392a602ba3")
  FOLDERID_QuickLaunch* = DEFINE_GUID("52a4f021-7b75-48a9-9f6b-4b87a210bc8f")
  FOLDERID_Recent* = DEFINE_GUID("ae50c081-ebd2-438a-8655-8a092e34987a")
  FOLDERID_RecordedTVLibrary* = DEFINE_GUID("1a6fdba2-f42d-4358-a798-b74d745926c5")
  FOLDERID_RecycleBinFolder* = DEFINE_GUID("b7534046-3ecb-4c18-be4e-64cd4cb7d6ac")
  FOLDERID_ResourceDir* = DEFINE_GUID("8ad10c31-2adb-4296-a8f7-e4701232c972")
  FOLDERID_Ringtones* = DEFINE_GUID("c870044b-f49e-4126-a9c3-b52a1ff411e8")
  FOLDERID_RoamingAppData* = DEFINE_GUID("3eb685db-65f9-4cf6-a03a-e3ef65729f3d")
  FOLDERID_RoamingTiles* = DEFINE_GUID("00bcfc5a-ed94-4e48-96a1-3f6217f21990")
  FOLDERID_RoamedTileImages* = DEFINE_GUID("aaa8d5a5-f1d6-4259-baa8-78e7ef60835e")
  FOLDERID_SampleMusic* = DEFINE_GUID("b250c668-f57d-4ee1-a63c-290ee7d1aa1f")
  FOLDERID_SamplePictures* = DEFINE_GUID("c4900540-2379-4c75-844b-64e6faf8716b")
  FOLDERID_SamplePlaylists* = DEFINE_GUID("15ca69b3-30ee-49c1-ace1-6b5ec372afb5")
  FOLDERID_SampleVideos* = DEFINE_GUID("859ead94-2e85-48ad-a71a-0969cb56a6cd")
  FOLDERID_SavedGames* = DEFINE_GUID("4c5c32ff-bb9d-43b0-b5b4-2d72e54eaaa4")
  FOLDERID_SavedSearches* = DEFINE_GUID("7d1d3a04-debb-4115-95cf-2f29da2920da")
  FOLDERID_Screenshots* = DEFINE_GUID("b7bede81-df94-4682-a7d8-57a52620b86f")
  FOLDERID_SEARCH_MAPI* = DEFINE_GUID("98ec0e18-2098-4d44-8644-66979315a281")
  FOLDERID_SEARCH_CSC* = DEFINE_GUID("ee32e446-31ca-4aba-814f-a5ebd2fd6d5e")
  FOLDERID_SearchHome* = DEFINE_GUID("190337d1-b8ca-4121-a639-6d472d16972a")
  FOLDERID_SendTo* = DEFINE_GUID("8983036c-27c0-404b-8f08-102d10dcfd74")
  FOLDERID_SidebarDefaultParts* = DEFINE_GUID("7b396e54-9ec5-4300-be0a-2482ebae1a26")
  FOLDERID_SidebarParts* = DEFINE_GUID("a75d362e-50fc-4fb7-ac2c-a8beaa314493")
  FOLDERID_StartMenu* = DEFINE_GUID("625b53c3-ab48-4ec1-ba1f-a1ef4146fc19")
  FOLDERID_Startup* = DEFINE_GUID("b97d20bb-f46a-4c97-ba10-5e3608430854")
  FOLDERID_SyncManagerFolder* = DEFINE_GUID("43668bf8-c14e-49b2-97c9-747784d784b7")
  FOLDERID_SyncResultsFolder* = DEFINE_GUID("289a9a43-be44-4057-a41b-587a76d7e7f9")
  FOLDERID_SyncSetupFolder* = DEFINE_GUID("0f214138-b1d3-4a90-bba9-27cbc0c5389a")
  FOLDERID_System* = DEFINE_GUID("1ac14e77-02e7-4e5d-b744-2eb1ae5198b7")
  FOLDERID_SystemX86* = DEFINE_GUID("d65231b0-b2f1-4857-a4ce-a8e7c6ea7d27")
  FOLDERID_Templates* = DEFINE_GUID("a63293e8-664e-48db-a079-df759e0509f7")
  FOLDERID_UserPinned* = DEFINE_GUID("9e3995ab-1f9c-4f13-b827-48b24b6c7174")
  FOLDERID_UserProfiles* = DEFINE_GUID("0762d272-c50a-4bb0-a382-697dcd729b80")
  FOLDERID_UserProgramFiles* = DEFINE_GUID("5cd7aee2-2219-4a67-b85d-6c9ce15660cb")
  FOLDERID_UserProgramFilesCommon* = DEFINE_GUID("bcbd3057-ca5c-4622-b42d-bc56db0ae516")
  FOLDERID_UsersFiles* = DEFINE_GUID("f3ce0f7c-4901-4acc-8648-d5d44b04ef8f")
  FOLDERID_UsersLibraries* = DEFINE_GUID("a302545d-deff-464b-abe8-61c8648d939b")
  FOLDERID_Videos* = DEFINE_GUID("18989b1d-99b5-455b-841c-ab7c74e4ddfc")
  FOLDERID_VideosLibrary* = DEFINE_GUID("491e922f-5643-4af4-a7eb-4e7a138d8174")
  FOLDERID_Windows* = DEFINE_GUID("f38bf404-1d43-42f2-9305-67de0b28fc23")
  FOLDERTYPEID_Invalid* = DEFINE_GUID("57807898-8c4f-4462-bb63-71042380b109")
  FOLDERTYPEID_Generic* = DEFINE_GUID("5c4f28b5-f869-4e84-8e60-f11db97c5cc7")
  FOLDERTYPEID_GenericSearchResults* = DEFINE_GUID("7fde1a1e-8b31-49a5-93b8-6be14cfa4943")
  FOLDERTYPEID_GenericLibrary* = DEFINE_GUID("5f4eab9a-6833-4f61-899d-31cf46979d49")
  FOLDERTYPEID_Documents* = DEFINE_GUID("7d49d726-3c21-4f05-99aa-fdc2c9474656")
  FOLDERTYPEID_Pictures* = DEFINE_GUID("b3690e58-e961-423b-b687-386ebfd83239")
  FOLDERTYPEID_Music* = DEFINE_GUID("94d6ddcc-4a68-4175-a374-bd584a510b78")
  FOLDERTYPEID_Videos* = DEFINE_GUID("5fa96407-7e77-483c-ac93-691d05850de8")
  FOLDERTYPEID_UserFiles* = DEFINE_GUID("cd0fc69b-71e2-46e5-9690-5bcd9f57aab3")
  FOLDERTYPEID_UsersLibraries* = DEFINE_GUID("c4d98f09-6124-4fe0-9942-826416082da9")
  FOLDERTYPEID_OtherUsers* = DEFINE_GUID("b337fd00-9dd5-4635-a6d4-da33fd102b7a")
  FOLDERTYPEID_PublishedItems* = DEFINE_GUID("7f2f5b96-ff74-41da-afd8-1c78a5f3aea2")
  FOLDERTYPEID_Communications* = DEFINE_GUID("91475fe5-586b-4eba-8d75-d17434b8cdf6")
  FOLDERTYPEID_Contacts* = DEFINE_GUID("de2b70ec-9bf7-4a93-bd3d-243f7881d492")
  FOLDERTYPEID_StartMenu* = DEFINE_GUID("ef87b4cb-f2ce-4785-8658-4ca6c63e38c6")
  FOLDERTYPEID_RecordedTV* = DEFINE_GUID("5557a28f-5da6-4f83-8809-c2c98a11a6fa")
  FOLDERTYPEID_SavedGames* = DEFINE_GUID("d0363307-28cb-4106-9f23-2956e3e5e0e7")
  FOLDERTYPEID_OpenSearch* = DEFINE_GUID("8faf9629-1980-46ff-8023-9dceab9c3ee3")
  FOLDERTYPEID_SearchConnector* = DEFINE_GUID("982725ee-6f47-479e-b447-812bfa7d2e8f")
  FOLDERTYPEID_AccountPictures* = DEFINE_GUID("db2a5d8f-06e6-4007-aba6-af877d526ea6")
  FOLDERTYPEID_Games* = DEFINE_GUID("b689b0d0-76d3-4cbb-87f7-585d0e0ce070")
  FOLDERTYPEID_ControlPanelCategory* = DEFINE_GUID("de4f0660-fa10-4b8f-a494-068b20b22307")
  FOLDERTYPEID_ControlPanelClassic* = DEFINE_GUID("0c3794f3-b545-43aa-a329-c37430c58d2a")
  FOLDERTYPEID_Printers* = DEFINE_GUID("2c7bbec6-c844-4a0a-91fa-cef6f59cfda1")
  FOLDERTYPEID_RecycleBin* = DEFINE_GUID("d6d9e004-cd87-442b-9d57-5e0aeb4f6f72")
  FOLDERTYPEID_SoftwareExplorer* = DEFINE_GUID("d674391b-52d9-4e07-834e-67c98610f39d")
  FOLDERTYPEID_CompressedFolder* = DEFINE_GUID("80213e82-bcfd-4c4f-8817-bb27601267a9")
  FOLDERTYPEID_NetworkExplorer* = DEFINE_GUID("25cc242b-9a7c-4f51-80e0-7a2928febe42")
  FOLDERTYPEID_Searches* = DEFINE_GUID("0b0ba2e3-405f-415e-a6ee-cad625207853")
  FOLDERTYPEID_SearchHome* = DEFINE_GUID("834d8a44-0974-4ed6-866e-f203d80b3810")
  SYNCMGR_OBJECTID_Icon* = DEFINE_GUID("6dbc85c3-5d07-4c72-a777-7fec78072c06")
  SYNCMGR_OBJECTID_EventStore* = DEFINE_GUID("4bef34b9-a786-4075-ba88-0c2b9d89a98f")
  SYNCMGR_OBJECTID_ConflictStore* = DEFINE_GUID("d78181f4-2389-47e4-a960-60bcc2ed930b")
  SYNCMGR_OBJECTID_BrowseContent* = DEFINE_GUID("57cbb584-e9b4-47ae-a120-c4df3335dee2")
  SYNCMGR_OBJECTID_ShowSchedule* = DEFINE_GUID("edc6f3e3-8441-4109-adf3-6c1ca0b7de47")
  SYNCMGR_OBJECTID_QueryBeforeActivate* = DEFINE_GUID("d882d80b-e7aa-49ed-86b7-e6e1f714cdfe")
  SYNCMGR_OBJECTID_QueryBeforeDeactivate* = DEFINE_GUID("a0efc282-60e0-460e-9374-ea88513cfc80")
  SYNCMGR_OBJECTID_QueryBeforeEnable* = DEFINE_GUID("04cbf7f0-5beb-4de1-bc90-908345c480f6")
  SYNCMGR_OBJECTID_QueryBeforeDisable* = DEFINE_GUID("bb5f64aa-f004-4eb5-8e4d-26751966344c")
  SYNCMGR_OBJECTID_QueryBeforeDelete* = DEFINE_GUID("f76c3397-afb3-45d7-a59f-5a49e905437e")
  SYNCMGR_OBJECTID_EventLinkClick* = DEFINE_GUID("2203bdc1-1af1-4082-8c30-28399f41384c")
  EP_NavPane* = DEFINE_GUID("cb316b22-25f7-42b8-8a09-540d23a43c2f")
  EP_Commands* = DEFINE_GUID("d9745868-ca5f-4a76-91cd-f5a129fbb076")
  EP_Commands_Organize* = DEFINE_GUID("72e81700-e3ec-4660-bf24-3c3b7b648806")
  EP_Commands_View* = DEFINE_GUID("21f7c32d-eeaa-439b-bb51-37b96fd6a943")
  EP_DetailsPane* = DEFINE_GUID("43abf98b-89b8-472d-b9ce-e69b8229f019")
  EP_PreviewPane* = DEFINE_GUID("893c63d1-45c8-4d17-be19-223be71be365")
  EP_QueryPane* = DEFINE_GUID("65bcde4f-4f07-4f27-83a7-1afca4df7ddd")
  EP_AdvQueryPane* = DEFINE_GUID("b4e9db8b-34ba-4c39-b5cc-16a1bd2c411c")
  EP_StatusBar* = DEFINE_GUID("65fe56ce-5cfe-4bc4-ad8a-7ae3fe7e8f7c")
  EP_Ribbon* = DEFINE_GUID("d27524a8-c9f2-4834-a106-df8889fd4f37")
  CATID_LocationFactory* = DEFINE_GUID("965c4d51-8b76-4e57-80b7-564d2ea4b55e")
  CATID_LocationProvider* = DEFINE_GUID("1b3ca474-2614-414b-b813-1aceca3e3dd8")
  ItemCount_Property_GUID* = DEFINE_GUID("abbf5c45-5ccc-47b7-bb4e-87cb87bbd162")
  SelectedItemCount_Property_GUID* = DEFINE_GUID("8fe316d2-0e52-460a-9c1e-48f273d470a3")
  ItemIndex_Property_GUID* = DEFINE_GUID("92a053da-2969-4021-bf27-514cfc2e4a69")
  CATID_SearchableApplication* = DEFINE_GUID("366c292a-d9b3-4dbf-bb70-e62ec3d0bbbf")
  IID_IObjectArray* = DEFINE_GUID("92ca9dcd-5622-4bba-a805-5e9f541bd8c9")
  IID_IObjectCollection* = DEFINE_GUID("5632b1a4-e38a-400a-928a-d4cd63230295")
  COPYENGINE_S_YES* = HRESULT 0x00270001
  COPYENGINE_S_NOT_HANDLED* = HRESULT 0x00270003
  COPYENGINE_S_USER_RETRY* = HRESULT 0x00270004
  COPYENGINE_S_USER_IGNORED* = HRESULT 0x00270005
  COPYENGINE_S_MERGE* = HRESULT 0x00270006
  COPYENGINE_S_DONT_PROCESS_CHILDREN* = HRESULT 0x00270008
  COPYENGINE_S_ALREADY_DONE* = HRESULT 0x0027000a
  COPYENGINE_S_PENDING* = HRESULT 0x0027000b
  COPYENGINE_S_KEEP_BOTH* = HRESULT 0x0027000c
  COPYENGINE_S_CLOSE_PROGRAM* = HRESULT 0x0027000d
  COPYENGINE_S_COLLISIONRESOLVED* = HRESULT 0x0027000e
  COPYENGINE_S_PROGRESS_PAUSE* = HRESULT 0x0027000f
  COPYENGINE_E_USER_CANCELLED* = HRESULT 0x80270000'i32
  COPYENGINE_E_CANCELLED* = HRESULT 0x80270001'i32
  COPYENGINE_E_REQUIRES_ELEVATION* = HRESULT 0x80270002'i32
  COPYENGINE_E_SAME_FILE* = HRESULT 0x80270003'i32
  COPYENGINE_E_DIFF_DIR* = HRESULT 0x80270004'i32
  COPYENGINE_E_MANY_SRC_1_DEST* = HRESULT 0x80270005'i32
  COPYENGINE_E_DEST_SUBTREE* = HRESULT 0x80270009'i32
  COPYENGINE_E_DEST_SAME_TREE* = HRESULT 0x8027000a'i32
  COPYENGINE_E_FLD_IS_FILE_DEST* = HRESULT 0x8027000b'i32
  COPYENGINE_E_FILE_IS_FLD_DEST* = HRESULT 0x8027000c'i32
  COPYENGINE_E_FILE_TOO_LARGE* = HRESULT 0x8027000d'i32
  COPYENGINE_E_REMOVABLE_FULL* = HRESULT 0x8027000e'i32
  COPYENGINE_E_DEST_IS_RO_CD* = HRESULT 0x8027000f'i32
  COPYENGINE_E_DEST_IS_RW_CD* = HRESULT 0x80270010'i32
  COPYENGINE_E_DEST_IS_R_CD* = HRESULT 0x80270011'i32
  COPYENGINE_E_DEST_IS_RO_DVD* = HRESULT 0x80270012'i32
  COPYENGINE_E_DEST_IS_RW_DVD* = HRESULT 0x80270013'i32
  COPYENGINE_E_DEST_IS_R_DVD* = HRESULT 0x80270014'i32
  COPYENGINE_E_SRC_IS_RO_CD* = HRESULT 0x80270015'i32
  COPYENGINE_E_SRC_IS_RW_CD* = HRESULT 0x80270016'i32
  COPYENGINE_E_SRC_IS_R_CD* = HRESULT 0x80270017'i32
  COPYENGINE_E_SRC_IS_RO_DVD* = HRESULT 0x80270018'i32
  COPYENGINE_E_SRC_IS_RW_DVD* = HRESULT 0x80270019'i32
  COPYENGINE_E_SRC_IS_R_DVD* = HRESULT 0x8027001a'i32
  COPYENGINE_E_INVALID_FILES_SRC* = HRESULT 0x8027001b'i32
  COPYENGINE_E_INVALID_FILES_DEST* = HRESULT 0x8027001c'i32
  COPYENGINE_E_PATH_TOO_DEEP_SRC* = HRESULT 0x8027001d'i32
  COPYENGINE_E_PATH_TOO_DEEP_DEST* = HRESULT 0x8027001e'i32
  COPYENGINE_E_ROOT_DIR_SRC* = HRESULT 0x8027001f'i32
  COPYENGINE_E_ROOT_DIR_DEST* = HRESULT 0x80270020'i32
  COPYENGINE_E_ACCESS_DENIED_SRC* = HRESULT 0x80270021'i32
  COPYENGINE_E_ACCESS_DENIED_DEST* = HRESULT 0x80270022'i32
  COPYENGINE_E_PATH_NOT_FOUND_SRC* = HRESULT 0x80270023'i32
  COPYENGINE_E_PATH_NOT_FOUND_DEST* = HRESULT 0x80270024'i32
  COPYENGINE_E_NET_DISCONNECT_SRC* = HRESULT 0x80270025'i32
  COPYENGINE_E_NET_DISCONNECT_DEST* = HRESULT 0x80270026'i32
  COPYENGINE_E_SHARING_VIOLATION_SRC* = HRESULT 0x80270027'i32
  COPYENGINE_E_SHARING_VIOLATION_DEST* = HRESULT 0x80270028'i32
  COPYENGINE_E_ALREADY_EXISTS_NORMAL* = HRESULT 0x80270029'i32
  COPYENGINE_E_ALREADY_EXISTS_READONLY* = HRESULT 0x8027002a'i32
  COPYENGINE_E_ALREADY_EXISTS_SYSTEM* = HRESULT 0x8027002b'i32
  COPYENGINE_E_ALREADY_EXISTS_FOLDER* = HRESULT 0x8027002c'i32
  COPYENGINE_E_STREAM_LOSS* = HRESULT 0x8027002d'i32
  COPYENGINE_E_EA_LOSS* = HRESULT 0x8027002e'i32
  COPYENGINE_E_PROPERTY_LOSS* = HRESULT 0x8027002f'i32
  COPYENGINE_E_PROPERTIES_LOSS* = HRESULT 0x80270030'i32
  COPYENGINE_E_ENCRYPTION_LOSS* = HRESULT 0x80270031'i32
  COPYENGINE_E_DISK_FULL* = HRESULT 0x80270032'i32
  COPYENGINE_E_DISK_FULL_CLEAN* = HRESULT 0x80270033'i32
  COPYENGINE_E_EA_NOT_SUPPORTED* = HRESULT 0x80270034'i32
  COPYENGINE_E_CANT_REACH_SOURCE* = HRESULT 0x80270035'i32
  COPYENGINE_E_RECYCLE_UNKNOWN_ERROR* = HRESULT 0x80270035'i32
  COPYENGINE_E_RECYCLE_FORCE_NUKE* = HRESULT 0x80270036'i32
  COPYENGINE_E_RECYCLE_SIZE_TOO_BIG* = HRESULT 0x80270037'i32
  COPYENGINE_E_RECYCLE_PATH_TOO_LONG* = HRESULT 0x80270038'i32
  COPYENGINE_E_RECYCLE_BIN_NOT_FOUND* = HRESULT 0x8027003a'i32
  COPYENGINE_E_NEWFILE_NAME_TOO_LONG* = HRESULT 0x8027003b'i32
  COPYENGINE_E_NEWFOLDER_NAME_TOO_LONG* = HRESULT 0x8027003c'i32
  COPYENGINE_E_DIR_NOT_EMPTY* = HRESULT 0x8027003d'i32
  COPYENGINE_E_FAT_MAX_IN_ROOT* = HRESULT 0x8027003e'i32
  COPYENGINE_E_ACCESSDENIED_READONLY* = HRESULT 0x8027003f'i32
  COPYENGINE_E_REDIRECTED_TO_WEBPAGE* = HRESULT 0x80270040'i32
  COPYENGINE_E_SERVER_BAD_FILE_TYPE* = HRESULT 0x80270041'i32
  NETCACHE_E_NEGATIVE_CACHE* = HRESULT 0x80270100'i32
  EXECUTE_E_LAUNCH_APPLICATION* = HRESULT 0x80270101'i32
  SHELL_E_WRONG_BITDEPTH* = HRESULT 0x80270102'i32
  LINK_E_DELETE* = HRESULT 0x80270103'i32
  STORE_E_NEWER_VERSION_AVAILABLE* = HRESULT 0x80270104'i32
  LIBRARY_E_NO_SAVE_LOCATION* = HRESULT 0x80270200'i32
  LIBRARY_E_NO_ACCESSIBLE_LOCATION* = HRESULT 0x80270201'i32
  E_USERTILE_UNSUPPORTEDFILETYPE* = HRESULT 0x80270210'i32
  E_USERTILE_CHANGEDISABLED* = HRESULT 0x80270211'i32
  E_USERTILE_LARGEORDYNAMIC* = HRESULT 0x80270212'i32
  E_USERTILE_VIDEOFRAMESIZE* = HRESULT 0x80270213'i32
  E_USERTILE_FILESIZE* = HRESULT 0x80270214'i32
  IMM_ACC_DOCKING_E_INSUFFICIENTHEIGHT* = HRESULT 0x80270230'i32
  IMM_ACC_DOCKING_E_DOCKOCCUPIED* = HRESULT 0x80270231'i32
  IMSC_E_SHELL_COMPONENT_STARTUP_FAILURE* = HRESULT 0x80270233'i32
  E_TILE_NOTIFICATIONS_PLATFORM_FAILURE* = HRESULT 0x80270249'i32
  E_SHELL_EXTENSION_BLOCKED* = HRESULT 0x80270301'i32
  CMF_NORMAL* = 0x0
  CMF_DEFAULTONLY* = 0x1
  CMF_VERBSONLY* = 0x2
  CMF_EXPLORE* = 0x4
  CMF_NOVERBS* = 0x8
  CMF_CANRENAME* = 0x10
  CMF_NODEFAULT* = 0x20
  CMF_INCLUDESTATIC* = 0x40
  CMF_ITEMMENU* = 0x80
  CMF_EXTENDEDVERBS* = 0x100
  CMF_DISABLEDVERBS* = 0x200
  CMF_ASYNCVERBSTATE* = 0x400
  CMF_OPTIMIZEFORINVOKE* = 0x800
  CMF_SYNCCASCADEMENU* = 0x1000
  CMF_DONOTPICKDEFAULT* = 0x2000
  CMF_RESERVED* = 0xffff0000'i32
  GCS_VERBA* = 0x0
  GCS_HELPTEXTA* = 0x1
  GCS_VALIDATEA* = 0x2
  GCS_VERBW* = 0x4
  GCS_HELPTEXTW* = 0x5
  GCS_VALIDATEW* = 0x6
  GCS_VERBICONW* = 0x14
  GCS_UNICODE* = 0x4
  CMDSTR_NEWFOLDERA* = "NewFolder"
  CMDSTR_VIEWLISTA* = "ViewList"
  CMDSTR_VIEWDETAILSA* = "ViewDetails"
  CMDSTR_NEWFOLDERW* = "NewFolder"
  CMDSTR_VIEWLISTW* = "ViewList"
  CMDSTR_VIEWDETAILSW* = "ViewDetails"
  CMIC_MASK_HOTKEY* = SEE_MASK_HOTKEY
  CMIC_MASK_ICON* = SEE_MASK_ICON
  CMIC_MASK_FLAG_NO_UI* = SEE_MASK_FLAG_NO_UI
  CMIC_MASK_UNICODE* = SEE_MASK_UNICODE
  CMIC_MASK_NO_CONSOLE* = SEE_MASK_NO_CONSOLE
  CMIC_MASK_ASYNCOK* = SEE_MASK_ASYNCOK
  CMIC_MASK_NOASYNC* = SEE_MASK_NOASYNC
  CMIC_MASK_SHIFT_DOWN* = 0x10000000
  CMIC_MASK_CONTROL_DOWN* = 0x40000000
  CMIC_MASK_FLAG_LOG_USAGE* = SEE_MASK_FLAG_LOG_USAGE
  CMIC_MASK_NOZONECHECKS* = SEE_MASK_NOZONECHECKS
  CMIC_MASK_PTINVOKE* = 0x20000000
  IID_IContextMenu* = DEFINE_GUID("000214e4-0000-0000-c000-000000000046")
  IID_IContextMenu2* = DEFINE_GUID("000214f4-0000-0000-c000-000000000046")
  IID_IContextMenu3* = DEFINE_GUID("bcfce0a0-ec17-11d0-8d10-00a0c90f2719")
  IID_IExecuteCommand* = DEFINE_GUID("7f9185b0-cb92-43c5-80a9-92277a4f7b54")
  IID_IPersistFolder* = DEFINE_GUID("000214ea-0000-0000-c000-000000000046")
  IRTIR_TASK_NOT_RUNNING* = 0
  IRTIR_TASK_RUNNING* = 1
  IRTIR_TASK_SUSPENDED* = 2
  IRTIR_TASK_PENDING* = 3
  IRTIR_TASK_FINISHED* = 4
  IID_IRunnableTask* = DEFINE_GUID("85788d00-6807-11d0-b810-00c04fd706ec")
  TOID_NULL* = GUID_NULL
  ITSAT_DEFAULT_PRIORITY* = 0x10000000
  ITSAT_MAX_PRIORITY* = 0x7fffffff
  ITSAT_MIN_PRIORITY* = 0x00000000
  ITSSFLAG_COMPLETE_ON_DESTROY* = 0x0
  ITSSFLAG_KILL_ON_DESTROY* = 0x1
  ITSSFLAG_FLAGS_MASK* = 0x3
  ITSS_THREAD_DESTROY_DEFAULT_TIMEOUT* = 10*1000
  ITSS_THREAD_TERMINATE_TIMEOUT* = INFINITE
  ITSS_THREAD_TIMEOUT_NO_CHANGE* = INFINITE-1
  IID_IShellTaskScheduler* = DEFINE_GUID("6ccb7be0-6807-11d0-b810-00c04fd706ec")
  SID_ShellTaskScheduler* = IID_IShellTaskScheduler
  IID_IQueryCodePage* = DEFINE_GUID("c7b236ce-ee80-11d0-985f-006008059382")
  IID_IPersistFolder2* = DEFINE_GUID("1ac3d9f0-175c-11d1-95be-00609797ea4f")
  CSIDL_FLAG_DONT_VERIFY* = 0x4000
  CSIDL_FLAG_PFTI_TRACKTARGET* = CSIDL_FLAG_DONT_VERIFY
  IID_IPersistFolder3* = DEFINE_GUID("cef04fdf-fe72-11d2-87a5-00c04f6837cf")
  IID_IPersistIDList* = DEFINE_GUID("1079acfc-29bd-11d3-8e0d-00c04f6837d5")
  IID_IEnumIDList* = DEFINE_GUID("000214f2-0000-0000-c000-000000000046")
  IID_IEnumFullIDList* = DEFINE_GUID("d0191542-7954-4908-bc06-b2360bbe45ba")
  SHGDN_NORMAL* = 0x0
  SHGDN_INFOLDER* = 0x1
  SHGDN_FOREDITING* = 0x1000
  SHGDN_FORADDRESSBAR* = 0x4000
  SHGDN_FORPARSING* = 0x8000
  SHCONTF_CHECKING_FOR_CHILDREN* = 0x10
  SHCONTF_FOLDERS* = 0x20
  SHCONTF_NONFOLDERS* = 0x40
  SHCONTF_INCLUDEHIDDEN* = 0x80
  SHCONTF_INIT_ON_FIRST_NEXT* = 0x100
  SHCONTF_NETPRINTERSRCH* = 0x200
  SHCONTF_SHAREABLE* = 0x400
  SHCONTF_STORAGE* = 0x800
  SHCONTF_NAVIGATION_ENUM* = 0x1000
  SHCONTF_FASTITEMS* = 0x2000
  SHCONTF_FLATLIST* = 0x4000
  SHCONTF_ENABLE_ASYNC* = 0x8000
  SHCONTF_INCLUDESUPERHIDDEN* = 0x10000
  SHCIDS_ALLFIELDS* = 0x80000000'i32
  SHCIDS_CANONICALONLY* = 0x10000000
  SHCIDS_BITMASK* = 0xffff0000'i32
  SHCIDS_COLUMNMASK* = 0x0000ffff
  SFGAO_CANCOPY* = DROPEFFECT_COPY
  SFGAO_CANMOVE* = DROPEFFECT_MOVE
  SFGAO_CANLINK* = DROPEFFECT_LINK
  SFGAO_STORAGE* = 0x8
  SFGAO_CANRENAME* = 0x10
  SFGAO_CANDELETE* = 0x20
  SFGAO_HASPROPSHEET* = 0x40
  SFGAO_DROPTARGET* = 0x100
  SFGAO_CAPABILITYMASK* = 0x177
  SFGAO_SYSTEM* = 0x1000
  SFGAO_ENCRYPTED* = 0x2000
  SFGAO_ISSLOW* = 0x4000
  SFGAO_GHOSTED* = 0x8000
  SFGAO_LINK* = 0x10000
  SFGAO_SHARE* = 0x20000
  SFGAO_READONLY* = 0x40000
  SFGAO_HIDDEN* = 0x80000
  SFGAO_DISPLAYATTRMASK* = 0xfc000
  SFGAO_FILESYSANCESTOR* = 0x10000000
  SFGAO_FOLDER* = 0x20000000
  SFGAO_FILESYSTEM* = 0x40000000
  SFGAO_HASSUBFOLDER* = 0x80000000'i32
  SFGAO_CONTENTSMASK* = 0x80000000'i32
  SFGAO_VALIDATE* = 0x1000000
  SFGAO_REMOVABLE* = 0x2000000
  SFGAO_COMPRESSED* = 0x4000000
  SFGAO_BROWSABLE* = 0x8000000
  SFGAO_NONENUMERATED* = 0x100000
  SFGAO_NEWCONTENT* = 0x200000
  SFGAO_CANMONIKER* = 0x400000
  SFGAO_HASSTORAGE* = 0x400000
  SFGAO_STREAM* = 0x400000
  SFGAO_STORAGEANCESTOR* = 0x00800000
  SFGAO_STORAGECAPMASK* = 0x70c50008
  SFGAO_PKEYSFGAOMASK* = 0x81044000'i32
  STR_BIND_FORCE_FOLDER_SHORTCUT_RESOLVE* = "Force Folder Shortcut Resolve"
  STR_AVOID_DRIVE_RESTRICTION_POLICY* = "Avoid Drive Restriction Policy"
  STR_SKIP_BINDING_CLSID* = "Skip Binding CLSID"
  STR_PARSE_PREFER_FOLDER_BROWSING* = "Parse Prefer Folder Browsing"
  STR_DONT_PARSE_RELATIVE* = "Don't Parse Relative"
  STR_PARSE_TRANSLATE_ALIASES* = "Parse Translate Aliases"
  STR_PARSE_SKIP_NET_CACHE* = "Skip Net Resource Cache"
  STR_PARSE_SHELL_PROTOCOL_TO_FILE_OBJECTS* = "Parse Shell Protocol To File Objects"
  STR_TRACK_CLSID* = "Track the CLSID"
  STR_INTERNAL_NAVIGATE* = "Internal Navigation"
  STR_PARSE_PROPERTYSTORE* = "DelegateNamedProperties"
  STR_NO_VALIDATE_FILENAME_CHARS* = "NoValidateFilenameChars"
  STR_BIND_DELEGATE_CREATE_OBJECT* = "Delegate Object Creation"
  STR_PARSE_ALLOW_INTERNET_SHELL_FOLDERS* = "Allow binding to Internet shell folder handlers and negate STR_PARSE_PREFER_WEB_BROWSING"
  STR_PARSE_PREFER_WEB_BROWSING* = "Do not bind to Internet shell folder handlers"
  STR_PARSE_SHOW_NET_DIAGNOSTICS_UI* = "Show network diagnostics UI"
  STR_PARSE_DONT_REQUIRE_VALIDATED_URLS* = "Do not require validated URLs"
  STR_INTERNETFOLDER_PARSE_ONLY_URLMON_BINDABLE* = "Validate UR"
  BIND_INTERRUPTABLE* = 0xffffffff'i32
  STR_BIND_FOLDERS_READ_ONLY* = "Folders As Read Only"
  STR_BIND_FOLDER_ENUM_MODE* = "Folder Enum Mode"
  FEM_VIEWRESULT* = 0
  FEM_NAVIGATION* = 1
  IID_IObjectWithFolderEnumMode* = DEFINE_GUID("6a9d9026-0e6e-464c-b000-42ecc07de673")
  STR_PARSE_WITH_EXPLICIT_PROGID* = "ExplicitProgid"
  STR_PARSE_WITH_EXPLICIT_ASSOCAPP* = "ExplicitAssociationApp"
  STR_PARSE_EXPLICIT_ASSOCIATION_SUCCESSFUL* = "ExplicitAssociationSuccessful"
  STR_PARSE_AND_CREATE_ITEM* = "ParseAndCreateItem"
  STR_PROPERTYBAG_PARAM* = "SHBindCtxPropertyBag"
  STR_ENUM_ITEMS_FLAGS* = "SHCONTF"
  IID_IParseAndCreateItem* = DEFINE_GUID("67efed0e-e827-4408-b493-78f3982b685c")
  STR_ITEM_CACHE_CONTEXT* = "ItemCacheContext"
  IID_IShellFolder* = DEFINE_GUID("000214e6-0000-0000-c000-000000000046")
  IID_IEnumExtraSearch* = DEFINE_GUID("0e700be1-9db6-11d1-a1ce-00c04fd75d13")
  IID_IShellFolder2* = DEFINE_GUID("93f2f68c-1d1b-11d3-a30e-00c04f79abd1")
  FWF_NONE* = 0x0
  FWF_AUTOARRANGE* = 0x1
  FWF_ABBREVIATEDNAMES* = 0x2
  FWF_SNAPTOGRID* = 0x4
  FWF_OWNERDATA* = 0x8
  FWF_BESTFITWINDOW* = 0x10
  FWF_DESKTOP* = 0x20
  FWF_SINGLESEL* = 0x40
  FWF_NOSUBFOLDERS* = 0x80
  FWF_TRANSPARENT* = 0x100
  FWF_NOCLIENTEDGE* = 0x200
  FWF_NOSCROLL* = 0x400
  FWF_ALIGNLEFT* = 0x800
  FWF_NOICONS* = 0x1000
  FWF_SHOWSELALWAYS* = 0x2000
  FWF_NOVISIBLE* = 0x4000
  FWF_SINGLECLICKACTIVATE* = 0x8000
  FWF_NOWEBVIEW* = 0x10000
  FWF_HIDEFILENAMES* = 0x20000
  FWF_CHECKSELECT* = 0x40000
  FWF_NOENUMREFRESH* = 0x80000
  FWF_NOGROUPING* = 0x100000
  FWF_FULLROWSELECT* = 0x200000
  FWF_NOFILTERS* = 0x400000
  FWF_NOCOLUMNHEADER* = 0x800000
  FWF_NOHEADERINALLVIEWS* = 0x1000000
  FWF_EXTENDEDTILES* = 0x2000000
  FWF_TRICHECKSELECT* = 0x4000000
  FWF_AUTOCHECKSELECT* = 0x8000000
  FWF_NOBROWSERVIEWSTATE* = 0x10000000
  FWF_SUBSETGROUPS* = 0x20000000
  FWF_USESEARCHFOLDER* = 0x40000000
  FWF_ALLOWRTLREADING* = 0x80000000'i32
  FVM_AUTO* = -1
  FVM_FIRST* = 1
  FVM_ICON* = 1
  FVM_SMALLICON* = 2
  FVM_LIST* = 3
  FVM_DETAILS* = 4
  FVM_THUMBNAIL* = 5
  FVM_TILE* = 6
  FVM_THUMBSTRIP* = 7
  FVM_CONTENT* = 8
  FVM_LAST* = 8
  FLVM_UNSPECIFIED* = -1
  FLVM_FIRST* = 1
  FLVM_DETAILS* = 1
  FLVM_TILES* = 2
  FLVM_ICONS* = 3
  FLVM_LIST* = 4
  FLVM_CONTENT* = 5
  FLVM_LAST* = 5
  FVO_DEFAULT* = 0x0
  FVO_VISTALAYOUT* = 0x1
  FVO_CUSTOMPOSITION* = 0x2
  FVO_CUSTOMORDERING* = 0x4
  FVO_SUPPORTHYPERLINKS* = 0x8
  FVO_NOANIMATIONS* = 0x10
  FVO_NOSCROLLTIPS* = 0x20
  IID_IFolderViewOptions* = DEFINE_GUID("3cc974d2-b302-4d36-ad3e-06d93f695d3f")
  SVSI_DESELECT* = 0x0
  SVSI_SELECT* = 0x1
  SVSI_EDIT* = 0x3
  SVSI_DESELECTOTHERS* = 0x4
  SVSI_ENSUREVISIBLE* = 0x8
  SVSI_FOCUSED* = 0x10
  SVSI_TRANSLATEPT* = 0x20
  SVSI_SELECTIONMARK* = 0x40
  SVSI_POSITIONITEM* = 0x80
  SVSI_CHECK* = 0x100
  SVSI_CHECK2* = 0x200
  SVSI_KEYBOARDSELECT* = 0x401
  SVSI_NOTAKEFOCUS* = 0x40000000
  SVSI_NOSTATECHANGE* = UINT 0x80000000'i32
  SVGIO_BACKGROUND* = 0x0
  SVGIO_SELECTION* = 0x1
  SVGIO_ALLVIEW* = 0x2
  SVGIO_CHECKED* = 0x3
  SVGIO_TYPE_MASK* = 0xf
  SVGIO_FLAG_VIEWORDER* = 0x80000000'i32
  SVUIA_DEACTIVATE* = 0
  SVUIA_ACTIVATE_NOFOCUS* = 1
  SVUIA_ACTIVATE_FOCUS* = 2
  SVUIA_INPLACEACTIVATE* = 3
  IID_IShellView* = DEFINE_GUID("000214e3-0000-0000-c000-000000000046")
  SV2GV_CURRENTVIEW* = UINT(-1)
  SV2GV_DEFAULTVIEW* = UINT(-2)
  IID_IShellView2* = DEFINE_GUID("88e39e80-3578-11cf-ae69-08002b2e1262")
  SV3CVW3_DEFAULT* = 0x0
  SV3CVW3_NONINTERACTIVE* = 0x1
  SV3CVW3_FORCEVIEWMODE* = 0x2
  SV3CVW3_FORCEFOLDERFLAGS* = 0x4
  IID_IShellView3* = DEFINE_GUID("ec39fa88-f8af-41c5-8421-38bed28f4673")
  IID_IFolderView* = DEFINE_GUID("cde725b0-ccc9-4519-917e-325d72fab4ce")
  SID_SFolderView* = IID_IFolderView
  IID_ISearchBoxInfo* = DEFINE_GUID("6af6e03f-d664-4ef4-9626-f7e0ed36755e")
  SORT_DESCENDING* = -1
  SORT_ASCENDING* = 1
  FVST_EMPTYTEXT* = 0
  IID_IFolderView2* = DEFINE_GUID("1af3a467-214f-4298-908e-06b03e0b39f9")
  IID_IFolderViewSettings* = DEFINE_GUID("ae8c987d-8797-4ed3-be72-2a47dd938db0")
  IID_IPreviewHandlerVisuals* = DEFINE_GUID("196bf9a5-b346-4ef0-aa1e-5dcdb76768b1")
  VPWF_DEFAULT* = 0x0
  VPWF_ALPHABLEND* = 0x1
  VPCF_TEXT* = 1
  VPCF_BACKGROUND* = 2
  VPCF_SORTCOLUMN* = 3
  VPCF_SUBTEXT* = 4
  VPCF_TEXTBACKGROUND* = 5
  IID_IVisualProperties* = DEFINE_GUID("e693cf68-d967-4112-8763-99172aee5e5a")
  CDBOSC_SETFOCUS* = 0x00000000
  CDBOSC_KILLFOCUS* = 0x00000001
  CDBOSC_SELCHANGE* = 0x00000002
  CDBOSC_RENAME* = 0x00000003
  CDBOSC_STATECHANGE* = 0x00000004
  IID_ICommDlgBrowser* = DEFINE_GUID("000214f1-0000-0000-c000-000000000046")
  SID_SExplorerBrowserFrame* = IID_ICommDlgBrowser
  CDB2N_CONTEXTMENU_DONE* = 0x00000001
  CDB2N_CONTEXTMENU_START* = 0x00000002
  CDB2GVF_SHOWALLFILES* = 0x1
  CDB2GVF_ISFILESAVE* = 0x2
  CDB2GVF_ALLOWPREVIEWPANE* = 0x4
  CDB2GVF_NOSELECTVERB* = 0x8
  CDB2GVF_NOINCLUDEITEM* = 0x10
  CDB2GVF_ISFOLDERPICKER* = 0x20
  CDB2GVF_ADDSHIELD* = 0x40
  IID_ICommDlgBrowser2* = DEFINE_GUID("10339516-2894-11d2-9039-00c04f8eeb3e")
  IID_ICommDlgBrowser3* = DEFINE_GUID("c8ad25a1-3294-41ee-8165-71174bd01c57")
  CM_MASK_WIDTH* = 0x1
  CM_MASK_DEFAULTWIDTH* = 0x2
  CM_MASK_IDEALWIDTH* = 0x4
  CM_MASK_NAME* = 0x8
  CM_MASK_STATE* = 0x10
  CM_STATE_NONE* = 0x0
  CM_STATE_VISIBLE* = 0x1
  CM_STATE_FIXEDWIDTH* = 0x2
  CM_STATE_NOSORTBYFOLDERNESS* = 0x4
  CM_STATE_ALWAYSVISIBLE* = 0x8
  CM_ENUM_ALL* = 0x1
  CM_ENUM_VISIBLE* = 0x2
  CM_WIDTH_USEDEFAULT* = -1
  CM_WIDTH_AUTOSIZE* = -2
  IID_IColumnManager* = DEFINE_GUID("d8ec27bb-3f3b-4042-b10a-4acfd924d453")
  IID_IFolderFilterSite* = DEFINE_GUID("c0a651f5-b48b-11d2-b5ed-006097c686f6")
  IID_IFolderFilter* = DEFINE_GUID("9cc22886-dc8e-11d2-b1d0-00c04f8eeb3e")
  IID_IInputObjectSite* = DEFINE_GUID("f1db8392-7331-11d0-8c99-00a0c92dbfe8")
  IID_IInputObject* = DEFINE_GUID("68284faa-6a48-11d0-8c78-00c04fd918b4")
  IID_IInputObject2* = DEFINE_GUID("6915c085-510b-44cd-94af-28dfa56cf92b")
  IID_IShellIcon* = DEFINE_GUID("000214e5-0000-0000-c000-000000000046")
  SBSP_DEFBROWSER* = 0x0000
  SBSP_SAMEBROWSER* = 0x0001
  SBSP_NEWBROWSER* = 0x0002
  SBSP_DEFMODE* = 0x0000
  SBSP_OPENMODE* = 0x0010
  SBSP_EXPLOREMODE* = 0x0020
  SBSP_HELPMODE* = 0x0040
  SBSP_NOTRANSFERHIST* = 0x0080
  SBSP_ABSOLUTE* = 0x0000
  SBSP_RELATIVE* = 0x1000
  SBSP_PARENT* = 0x2000
  SBSP_NAVIGATEBACK* = 0x4000
  SBSP_NAVIGATEFORWARD* = 0x8000
  SBSP_ALLOW_AUTONAVIGATE* = 0x00010000
  SBSP_KEEPSAMETEMPLATE* = 0x00020000
  SBSP_KEEPWORDWHEELTEXT* = 0x00040000
  SBSP_ACTIVATE_NOFOCUS* = 0x00080000
  SBSP_CREATENOHISTORY* = 0x00100000
  SBSP_PLAYNOSOUND* = 0x00200000
  SBSP_CALLERUNTRUSTED* = 0x00800000
  SBSP_TRUSTFIRSTDOWNLOAD* = 0x01000000
  SBSP_UNTRUSTEDFORDOWNLOAD* = 0x02000000
  SBSP_NOAUTOSELECT* = 0x04000000
  SBSP_WRITENOHISTORY* = 0x08000000
  SBSP_TRUSTEDFORACTIVEX* = 0x10000000
  SBSP_FEEDNAVIGATION* = 0x20000000
  SBSP_REDIRECT* = 0x40000000
  SBSP_INITIATEDBYHLINKFRAME* = 0x80000000'i32
  FCW_STATUS* = 0x0001
  FCW_TOOLBAR* = 0x0002
  FCW_TREE* = 0x0003
  FCW_INTERNETBAR* = 0x0006
  FCW_PROGRESS* = 0x0008
  FCT_MERGE* = 0x0001
  FCT_CONFIGABLE* = 0x0002
  FCT_ADDTOEND* = 0x0004
  IID_IProfferService* = DEFINE_GUID("cb728b20-f786-11ce-92ad-00aa00a74cd0")
  SID_SProfferService* = IID_IProfferService
  STR_DONT_RESOLVE_LINK* = "Don't Resolve Link"
  STR_GET_ASYNC_HANDLER* = "GetAsyncHandler"
  SIGDN_NORMALDISPLAY* = 0x0
  SIGDN_PARENTRELATIVEPARSING* = int32 0x80018001'i32
  SIGDN_DESKTOPABSOLUTEPARSING* = int32 0x80028000'i32
  SIGDN_PARENTRELATIVEEDITING* = int32 0x80031001'i32
  SIGDN_DESKTOPABSOLUTEEDITING* = int32 0x8004c000'i32
  SIGDN_FILESYSPATH* = int32 0x80058000'i32
  SIGDN_URL* = int32 0x80068000'i32
  SIGDN_PARENTRELATIVEFORADDRESSBAR* = int32 0x8007c001'i32
  SIGDN_PARENTRELATIVE* = int32 0x80080001'i32
  SIGDN_PARENTRELATIVEFORUI* = int32 0x80094001'i32
  SICHINT_DISPLAY* = 0x0
  SICHINT_ALLFIELDS* = int32 0x80000000'i32
  SICHINT_CANONICAL* = 0x10000000
  SICHINT_TEST_FILESYSPATH_IF_NOT_EQUAL* = 0x20000000
  IID_IShellItem* = DEFINE_GUID("43826d1e-e718-42ee-bc55-a1e261c37bfe")
  DOGIF_DEFAULT* = 0x0
  DOGIF_TRAVERSE_LINK* = 0x1
  DOGIF_NO_HDROP* = 0x2
  DOGIF_NO_URL* = 0x4
  DOGIF_ONLY_IF_ONE* = 0x8
  STR_GPS_HANDLERPROPERTIESONLY* = "GPS_HANDLERPROPERTIESONLY"
  STR_GPS_FASTPROPERTIESONLY* = "GPS_FASTPROPERTIESONLY"
  STR_GPS_OPENSLOWITEM* = "GPS_OPENSLOWITEM"
  STR_GPS_DELAYCREATION* = "GPS_DELAYCREATION"
  STR_GPS_BESTEFFORT* = "GPS_BESTEFFORT"
  STR_GPS_NO_OPLOCK* = "GPS_NO_OPLOCK"
  IID_IShellItem2* = DEFINE_GUID("7e9fb0d3-919f-4307-ab2e-9b1860310c93")
  SIIGBF_RESIZETOFIT* = 0x0
  SIIGBF_BIGGERSIZEOK* = 0x1
  SIIGBF_MEMORYONLY* = 0x2
  SIIGBF_ICONONLY* = 0x4
  SIIGBF_THUMBNAILONLY* = 0x8
  SIIGBF_INCACHEONLY* = 0x10
  SIIGBF_CROPTOSQUARE* = 0x20
  SIIGBF_WIDETHUMBNAILS* = 0x40
  SIIGBF_ICONBACKGROUND* = 0x80
  SIIGBF_SCALEUP* = 0x100
  IID_IShellItemImageFactory* = DEFINE_GUID("bcc18b79-ba16-442f-80c4-8a59c30c463b")
  IID_IUserAccountChangeCallback* = DEFINE_GUID("a561e69a-b4b8-4113-91a5-64c6bcca3430")
  IID_IEnumShellItems* = DEFINE_GUID("70629033-e363-4a28-a567-0db78006e6d7")
  STGOP_MOVE* = 1
  STGOP_COPY* = 2
  STGOP_SYNC* = 3
  STGOP_REMOVE* = 5
  STGOP_RENAME* = 6
  STGOP_APPLYPROPERTIES* = 8
  STGOP_NEW* = 10
  TSF_NORMAL* = 0x0
  TSF_FAIL_EXIST* = 0x0
  TSF_RENAME_EXIST* = 0x1
  TSF_OVERWRITE_EXIST* = 0x2
  TSF_ALLOW_DECRYPTION* = 0x4
  TSF_NO_SECURITY* = 0x8
  TSF_COPY_CREATION_TIME* = 0x10
  TSF_COPY_WRITE_TIME* = 0x20
  TSF_USE_FULL_ACCESS* = 0x40
  TSF_DELETE_RECYCLE_IF_POSSIBLE* = 0x80
  TSF_COPY_HARD_LINK* = 0x100
  TSF_COPY_LOCALIZED_NAME* = 0x200
  TSF_MOVE_AS_COPY_DELETE* = 0x400
  TSF_SUSPEND_SHELLEVENTS* = 0x800
  TS_NONE* = 0x0
  TS_PERFORMING* = 0x1
  TS_PREPARING* = 0x2
  TS_INDETERMINATE* = 0x4
  IID_ITransferAdviseSink* = DEFINE_GUID("d594d0d8-8da7-457b-b3b4-ce5dbaac0b88")
  IID_ITransferSource* = DEFINE_GUID("00adb003-bde9-45c6-8e29-d09f9353e108")
  IID_IEnumResources* = DEFINE_GUID("2dd81fe3-a83c-4da9-a330-47249d345ba1")
  IID_IShellItemResources* = DEFINE_GUID("ff5693be-2ce0-4d48-b5c5-40817d1acdb9")
  IID_ITransferDestination* = DEFINE_GUID("48addd32-3ca5-4124-abe3-b5a72531b207")
  IID_IStreamAsync* = DEFINE_GUID("fe0b6665-e0ca-49b9-a178-2b5cb48d92a5")
  IID_IStreamUnbufferedInfo* = DEFINE_GUID("8a68fdda-1fdc-4c20-8ceb-416643b5a625")
  IID_IFileOperationProgressSink* = DEFINE_GUID("04b0f1a7-9490-44bc-96e1-4296a31252e2")
  SIATTRIBFLAGS_AND* = 0x1
  SIATTRIBFLAGS_OR* = 0x2
  SIATTRIBFLAGS_APPCOMPAT* = 0x3
  SIATTRIBFLAGS_MASK* = 0x3
  SIATTRIBFLAGS_ALLITEMS* = 0x4000
  IID_IShellItemArray* = DEFINE_GUID("b63ea76d-1f85-456f-a19c-48159efa858b")
  IID_IInitializeWithItem* = DEFINE_GUID("7f73be3f-fb79-493c-a6c7-7ee14e245841")
  IID_IObjectWithSelection* = DEFINE_GUID("1c9cd5bb-98e9-4491-a60f-31aacc72b83c")
  IID_IObjectWithBackReferences* = DEFINE_GUID("321a6a6a-d61f-4bf3-97ae-14be2986bb36")
  PUIFNF_DEFAULT* = 0x0
  PUIFNF_MNEMONIC* = 0x1
  PUIF_DEFAULT* = 0x0
  PUIF_RIGHTALIGN* = 0x1
  PUIF_NOLABELININFOTIP* = 0x2
  PUIFFDF_DEFAULT* = 0x0
  PUIFFDF_RIGHTTOLEFT* = 0x1
  PUIFFDF_SHORTFORMAT* = 0x2
  PUIFFDF_NOTIME* = 0x4
  PUIFFDF_FRIENDLYDATE* = 0x8
  IID_IPropertyUI* = DEFINE_GUID("757a7d9f-919a-4118-99d7-dbb208c8cc66")
  IID_ICategoryProvider* = DEFINE_GUID("9af64809-5864-4c26-a720-c1f78c086ee3")
  CATINFO_NORMAL* = 0x0
  CATINFO_COLLAPSED* = 0x1
  CATINFO_HIDDEN* = 0x2
  CATINFO_EXPANDED* = 0x4
  CATINFO_NOHEADER* = 0x8
  CATINFO_NOTCOLLAPSIBLE* = 0x10
  CATINFO_NOHEADERCOUNT* = 0x20
  CATINFO_SUBSETTED* = 0x40
  CATSORT_DEFAULT* = 0x0
  CATSORT_NAME* = 0x1
  IID_ICategorizer* = DEFINE_GUID("a3b14589-9174-49a8-89a3-06a1ae2b9ba7")
  DI_GETDRAGIMAGE* = "ShellGetDragImage"
  IID_IDropTargetHelper* = DEFINE_GUID("4657278b-411b-11d2-839a-00c04fd918d0")
  IID_IDragSourceHelper* = DEFINE_GUID("de5bf786-477a-11d2-839d-00c04fd918d0")
  DSH_ALLOWDROPDESCRIPTIONTEXT* = 0x1
  IID_IDragSourceHelper2* = DEFINE_GUID("83e07d0d-0c5f-4163-bf1a-60b274051e40")
  SLR_NO_UI* = 0x1
  SLR_ANY_MATCH* = 0x2
  SLR_UPDATE* = 0x4
  SLR_NOUPDATE* = 0x8
  SLR_NOSEARCH* = 0x10
  SLR_NOTRACK* = 0x20
  SLR_NOLINKINFO* = 0x40
  SLR_INVOKE_MSI* = 0x80
  SLR_NO_UI_WITH_MSG_PUMP* = 0x101
  SLR_OFFER_DELETE_WITHOUT_FILE* = 0x200
  SLR_KNOWNFOLDER* = 0x400
  SLR_MACHINE_IN_LOCAL_TARGET* = 0x800
  SLR_UPDATE_MACHINE_AND_SID* = 0x1000
  SLGP_SHORTPATH* = 0x1
  SLGP_UNCPRIORITY* = 0x2
  SLGP_RAWPATH* = 0x4
  SLGP_RELATIVEPRIORITY* = 0x8
  IID_IShellLinkA* = DEFINE_GUID("000214ee-0000-0000-c000-000000000046")
  IID_IShellLinkDataList* = DEFINE_GUID("45e2b4ae-b1c3-11d0-b92f-00a0c90312e1")
  IID_IResolveShellLink* = DEFINE_GUID("5cd52983-9449-11d2-963a-00c04f79adf0")
  SPINITF_NORMAL* = 0x0
  SPINITF_MODAL* = 0x1
  SPINITF_NOMINIMIZE* = 0x8
  IID_IActionProgressDialog* = DEFINE_GUID("49ff1172-eadc-446d-9285-156453a6431c")
  IID_IHWEventHandler* = DEFINE_GUID("c1fb73d0-ec3a-4ba2-b512-8cdb9187b6d1")
  IID_IHWEventHandler2* = DEFINE_GUID("cfcc809f-295d-42e8-9ffc-424b33c487e6")
  ARCONTENT_AUTORUNINF* = 0x00000002
  ARCONTENT_AUDIOCD* = 0x00000004
  ARCONTENT_DVDMOVIE* = 0x00000008
  ARCONTENT_BLANKCD* = 0x00000010
  ARCONTENT_BLANKDVD* = 0x00000020
  ARCONTENT_UNKNOWNCONTENT* = 0x00000040
  ARCONTENT_AUTOPLAYPIX* = 0x00000080
  ARCONTENT_AUTOPLAYMUSIC* = 0x00000100
  ARCONTENT_AUTOPLAYVIDEO* = 0x00000200
  ARCONTENT_VCD* = 0x00000400
  ARCONTENT_SVCD* = 0x00000800
  ARCONTENT_DVDAUDIO* = 0x00001000
  ARCONTENT_BLANKBD* = 0x00002000
  ARCONTENT_BLURAY* = 0x00004000
  ARCONTENT_CAMERASTORAGE* = 0x00008000
  ARCONTENT_CUSTOMEVENT* = 0x00010000
  ARCONTENT_NONE* = 0x00000000
  ARCONTENT_MASK* = 0x0001FFFE
  ARCONTENT_PHASE_UNKNOWN* = 0x00000000
  ARCONTENT_PHASE_PRESNIFF* = 0x10000000
  ARCONTENT_PHASE_SNIFFING* = 0x20000000
  ARCONTENT_PHASE_FINAL* = 0x40000000
  ARCONTENT_PHASE_MASK* = 0x70000000
  IID_IQueryCancelAutoPlay* = DEFINE_GUID("ddefe873-6997-4e68-be26-39b633adbe12")
  IID_IDynamicHWHandler* = DEFINE_GUID("dc2601d7-059e-42fc-a09d-2afd21b6d5f7")
  SPBEGINF_NORMAL* = 0x0
  SPBEGINF_AUTOTIME* = 0x2
  SPBEGINF_NOPROGRESSBAR* = 0x10
  SPBEGINF_MARQUEEPROGRESS* = 0x20
  SPBEGINF_NOCANCELBUTTON* = 0x40
  SPACTION_NONE* = 0
  SPACTION_MOVING* = 1
  SPACTION_COPYING* = 2
  SPACTION_RECYCLING* = 3
  SPACTION_APPLYINGATTRIBS* = 4
  SPACTION_DOWNLOADING* = 5
  SPACTION_SEARCHING_INTERNET* = 6
  SPACTION_CALCULATING* = 7
  SPACTION_UPLOADING* = 8
  SPACTION_SEARCHING_FILES* = 9
  SPACTION_DELETING* = 10
  SPACTION_RENAMING* = 11
  SPACTION_FORMATTING* = 12
  SPACTION_COPY_MOVING* = 13
  SPTEXT_ACTIONDESCRIPTION* = 1
  SPTEXT_ACTIONDETAIL* = 2
  IID_IActionProgress* = DEFINE_GUID("49ff1173-eadc-446d-9285-156453a6431c")
  IID_IShellExtInit* = DEFINE_GUID("000214e8-0000-0000-c000-000000000046")
  EXPPS_FILETYPES* = 0x1
  IID_IShellPropSheetExt* = DEFINE_GUID("000214e9-0000-0000-c000-000000000046")
  IID_IRemoteComputer* = DEFINE_GUID("000214fe-0000-0000-c000-000000000046")
  IID_IQueryContinue* = DEFINE_GUID("7307055c-b24a-486b-9f25-163e597a28a9")
  IID_IObjectWithCancelEvent* = DEFINE_GUID("f279b885-0ae9-4b85-ac06-ddecf9408941")
  IID_IUserNotification* = DEFINE_GUID("ba9711ba-5893-4787-a7e1-41277151550b")
  IID_IUserNotificationCallback* = DEFINE_GUID("19108294-0441-4aff-8013-fa0a730b0bea")
  IID_IUserNotification2* = DEFINE_GUID("215913cc-57eb-4fab-ab5a-e5fa7bea2a6c")
  IID_IItemNameLimits* = DEFINE_GUID("1df0d7f1-b267-4d28-8b10-12e23202a5c4")
  IID_ISearchFolderItemFactory* = DEFINE_GUID("a0ffbc28-5482-4366-be27-3e81e78e06c2")
  IEI_PRIORITY_MAX* = ITSAT_MAX_PRIORITY
  IEI_PRIORITY_MIN* = ITSAT_MIN_PRIORITY
  IEIT_PRIORITY_NORMAL* = ITSAT_DEFAULT_PRIORITY
  IEIFLAG_ASYNC* = 0x0001
  IEIFLAG_CACHE* = 0x0002
  IEIFLAG_ASPECT* = 0x0004
  IEIFLAG_OFFLINE* = 0x0008
  IEIFLAG_GLEAM* = 0x0010
  IEIFLAG_SCREEN* = 0x0020
  IEIFLAG_ORIGSIZE* = 0x0040
  IEIFLAG_NOSTAMP* = 0x0080
  IEIFLAG_NOBORDER* = 0x0100
  IEIFLAG_QUALITY* = 0x0200
  IEIFLAG_REFRESH* = 0x0400
  IID_IExtractImage* = DEFINE_GUID("bb2e617c-0920-11d1-9a0b-00c04fc2d6c1")
  IID_IExtractImage2* = DEFINE_GUID("953bb1ee-93b4-11d1-98a3-00c04fb687da")
  IID_IThumbnailHandlerFactory* = DEFINE_GUID("e35b4b2e-00da-4bc1-9f13-38bc11f5d417")
  IID_IParentAndItem* = DEFINE_GUID("b3a4b685-b685-4805-99d9-5dead2873236")
  IID_IDockingWindow* = DEFINE_GUID("012dd920-7b26-11d0-8ca9-00a0c92dbfe8")
  DBIM_MINSIZE* = 0x0001
  DBIM_MAXSIZE* = 0x0002
  DBIM_INTEGRAL* = 0x0004
  DBIM_ACTUAL* = 0x0008
  DBIM_TITLE* = 0x0010
  DBIM_MODEFLAGS* = 0x0020
  DBIM_BKCOLOR* = 0x0040
  DBIMF_NORMAL* = 0x0000
  DBIMF_FIXED* = 0x0001
  DBIMF_FIXEDBMP* = 0x0004
  DBIMF_VARIABLEHEIGHT* = 0x0008
  DBIMF_UNDELETEABLE* = 0x0010
  DBIMF_DEBOSSED* = 0x0020
  DBIMF_BKCOLOR* = 0x0040
  DBIMF_USECHEVRON* = 0x0080
  DBIMF_BREAK* = 0x0100
  DBIMF_ADDTOFRONT* = 0x0200
  DBIMF_TOPALIGN* = 0x0400
  DBIMF_NOGRIPPER* = 0x0800
  DBIMF_ALWAYSGRIPPER* = 0x1000
  DBIMF_NOMARGINS* = 0x2000
  DBIF_VIEWMODE_NORMAL* = 0x0000
  DBIF_VIEWMODE_VERTICAL* = 0x0001
  DBIF_VIEWMODE_FLOATING* = 0x0002
  DBIF_VIEWMODE_TRANSPARENT* = 0x0004
  DBID_BANDINFOCHANGED* = 0
  DBID_SHOWONLY* = 1
  DBID_MAXIMIZEBAND* = 2
  DBID_PUSHCHEVRON* = 3
  DBID_DELAYINIT* = 4
  DBID_FINISHINIT* = 5
  DBID_SETWINDOWTHEME* = 6
  DBID_PERMITAUTOHIDE* = 7
  DBPC_SELECTFIRST* = DWORD(-1)
  DBPC_SELECTLAST* = DWORD(-2)
  IID_IDeskBand* = DEFINE_GUID("eb0fe172-1a3a-11d0-89b3-00a0c90a90ac")
  CGID_DeskBand* = IID_IDeskBand
  IID_IDeskBandInfo* = DEFINE_GUID("77e425fc-cbf9-4307-ba6a-bb5727745661")
  IID_IDeskBand2* = DEFINE_GUID("79d16de4-abee-4021-8d9d-9169b261d657")
  IID_ITaskbarList* = DEFINE_GUID("56fdf342-fd6d-11d0-958a-006097c9a090")
  IID_ITaskbarList2* = DEFINE_GUID("602d4995-b13a-429b-a66e-1935e44f4317")
  THBF_ENABLED* = 0x0
  THBF_DISABLED* = 0x1
  THBF_DISMISSONCLICK* = 0x2
  THBF_NOBACKGROUND* = 0x4
  THBF_HIDDEN* = 0x8
  THBF_NONINTERACTIVE* = 0x10
  THB_BITMAP* = 0x1
  THB_ICON* = 0x2
  THB_TOOLTIP* = 0x4
  THB_FLAGS* = 0x8
  THBN_CLICKED* = 0x1800
  TBPF_NOPROGRESS* = 0x0
  TBPF_INDETERMINATE* = 0x1
  TBPF_NORMAL* = 0x2
  TBPF_ERROR* = 0x4
  TBPF_PAUSED* = 0x8
  IID_ITaskbarList3* = DEFINE_GUID("ea1afb91-9e28-4b86-90e9-9e9f8a5eefaf")
  STPF_NONE* = 0x0
  STPF_USEAPPTHUMBNAILALWAYS* = 0x1
  STPF_USEAPPTHUMBNAILWHENACTIVE* = 0x2
  STPF_USEAPPPEEKALWAYS* = 0x4
  STPF_USEAPPPEEKWHENACTIVE* = 0x8
  IID_ITaskbarList4* = DEFINE_GUID("c43dc798-95d1-4bea-9030-bb99e2983a1a")
  IID_IStartMenuPinnedList* = DEFINE_GUID("4cd19ada-25a5-4a32-b3b7-347bee5be36b")
  IID_ICDBurn* = DEFINE_GUID("3d73a659-e5d0-4d42-afc0-5121ba425c8d")
  IDD_WIZEXTN_FIRST* = 0x5000
  IDD_WIZEXTN_LAST* = 0x5100
  IID_IWizardSite* = DEFINE_GUID("88960f5b-422f-4e7b-8013-73415381c3c3")
  SID_WizardSite* = IID_IWizardSite
  IID_IWizardExtension* = DEFINE_GUID("c02ea696-86cc-491e-9b23-74394a0444a8")
  IID_IWebWizardExtension* = DEFINE_GUID("0e6b3f66-98d1-48c0-a222-fbde74e2fbc5")
  SID_WebWizardHost* = IID_IWebWizardExtension
  SHPWHF_NORECOMPRESS* = 0x00000001
  SHPWHF_NONETPLACECREATE* = 0x00000002
  SHPWHF_NOFILESELECTOR* = 0x00000004
  SHPWHF_USEMRU* = 0x00000008
  SHPWHF_ANYLOCATION* = 0x00000100
  SHPWHF_VALIDATEVIAWEBFOLDERS* = 0x00010000
  IID_IPublishingWizard* = DEFINE_GUID("aa9198bb-ccec-472d-beed-19a4f6733f7a")
  IID_IFolderViewHost* = DEFINE_GUID("1ea58f02-d55a-411d-b09e-9e65ac21605b")
  IID_IExplorerBrowserEvents* = DEFINE_GUID("361bbdc7-e6ee-4e13-be58-58e2240c810f")
  EBO_NONE* = 0x0
  EBO_NAVIGATEONCE* = 0x1
  EBO_SHOWFRAMES* = 0x2
  EBO_ALWAYSNAVIGATE* = 0x4
  EBO_NOTRAVELLOG* = 0x8
  EBO_NOWRAPPERWINDOW* = 0x10
  EBO_HTMLSHAREPOINTVIEW* = 0x20
  EBO_NOBORDER* = 0x40
  EBO_NOPERSISTVIEWSTATE* = 0x80
  EBF_NONE* = 0x0
  EBF_SELECTFROMDATAOBJECT* = 0x100
  EBF_NODROPTARGET* = 0x200
  IID_IExplorerBrowser* = DEFINE_GUID("dfd3b6b5-c10c-4be9-85f6-a66969f402f6")
  IID_IAccessibleObject* = DEFINE_GUID("95a391c5-9ed4-4c28-8401-ab9e06719e11")
  IID_IResultsFolder* = DEFINE_GUID("96e5ae6d-6ae1-4b1c-900c-c6480eaa8828")
  IID_IEnumObjects* = DEFINE_GUID("2c1c7e2e-2d0e-4059-831e-1e6f82335c2e")
  OPPROGDLG_DEFAULT* = 0x0
  OPPROGDLG_ENABLEPAUSE* = 0x80
  OPPROGDLG_ALLOWUNDO* = 0x100
  OPPROGDLG_DONTDISPLAYSOURCEPATH* = 0x200
  OPPROGDLG_DONTDISPLAYDESTPATH* = 0x400
  OPPROGDLG_NOMULTIDAYESTIMATES* = 0x800
  OPPROGDLG_DONTDISPLAYLOCATIONS* = 0x1000
  PDM_DEFAULT* = 0x0
  PDM_RUN* = 0x1
  PDM_PREFLIGHT* = 0x2
  PDM_UNDOING* = 0x4
  PDM_ERRORSBLOCKING* = 0x8
  PDM_INDETERMINATE* = 0x10
  PDOPS_RUNNING* = 1
  PDOPS_PAUSED* = 2
  PDOPS_CANCELLED* = 3
  PDOPS_STOPPED* = 4
  PDOPS_ERRORS* = 5
  IID_IOperationsProgressDialog* = DEFINE_GUID("0c9fb851-e5c9-43eb-a370-f0677b13874c")
  IID_IIOCancelInformation* = DEFINE_GUID("f5b0bf81-8cb5-4b1b-9449-1a159e0c733c")
  FOFX_NOSKIPJUNCTIONS* = 0x00010000
  FOFX_PREFERHARDLINK* = 0x00020000
  FOFX_SHOWELEVATIONPROMPT* = 0x00040000
  FOFX_RECYCLEONDELETE* = 0x00080000
  FOFX_EARLYFAILURE* = 0x00100000
  FOFX_PRESERVEFILEEXTENSIONS* = 0x00200000
  FOFX_KEEPNEWERFILE* = 0x00400000
  FOFX_NOCOPYHOOKS* = 0x00800000
  FOFX_NOMINIMIZEBOX* = 0x01000000
  FOFX_MOVEACLSACROSSVOLUMES* = 0x02000000
  FOFX_DONTDISPLAYSOURCEPATH* = 0x04000000
  FOFX_DONTDISPLAYDESTPATH* = 0x08000000
  FOFX_REQUIREELEVATION* = 0x10000000
  FOFX_ADDUNDORECORD* = 0x20000000
  FOFX_COPYASDOWNLOAD* = 0x40000000
  FOFX_DONTDISPLAYLOCATIONS* = 0x80000000'i32
  IID_IFileOperation* = DEFINE_GUID("947aab5f-0a5c-4c13-b4d6-4bf7836fc9f8")
  IID_IObjectProvider* = DEFINE_GUID("a6087428-3be3-4d73-b308-7c04a540bf1a")
  IID_INamespaceWalkCB* = DEFINE_GUID("d92995f8-cf5e-4a76-bf59-ead39ea2b97e")
  IID_INamespaceWalkCB2* = DEFINE_GUID("7ac7492b-c38e-438a-87db-68737844ff70")
  NSWF_DEFAULT* = 0x0
  NSWF_NONE_IMPLIES_ALL* = 0x1
  NSWF_ONE_IMPLIES_ALL* = 0x2
  NSWF_DONT_TRAVERSE_LINKS* = 0x4
  NSWF_DONT_ACCUMULATE_RESULT* = 0x8
  NSWF_TRAVERSE_STREAM_JUNCTIONS* = 0x10
  NSWF_FILESYSTEM_ONLY* = 0x20
  NSWF_SHOW_PROGRESS* = 0x40
  NSWF_FLAG_VIEWORDER* = 0x80
  NSWF_IGNORE_AUTOPLAY_HIDA* = 0x100
  NSWF_ASYNC* = 0x200
  NSWF_DONT_RESOLVE_LINKS* = 0x400
  NSWF_ACCUMULATE_FOLDERS* = 0x800
  NSWF_DONT_SORT* = 0x1000
  NSWF_USE_TRANSFER_MEDIUM* = 0x2000
  NSWF_DONT_TRAVERSE_STREAM_JUNCTIONS* = 0x4000
  NSWF_ANY_IMPLIES_ALL* = 0x8000
  NSWF_ENUMERATE_BEST_EFFORT* = 0x00010000
  NSWF_TRAVERSE_ONLY_STORAGE* = 0x00020000
  IID_INamespaceWalk* = DEFINE_GUID("57ced8a7-3f4a-432c-9350-30f24483f74f")
  ACDD_VISIBLE* = 0x1
  IID_IAutoCompleteDropDown* = DEFINE_GUID("3cd141f4-3c6a-11d2-bcaa-00c04fd929db")
  BSID_BANDADDED* = 0
  BSID_BANDREMOVED* = 1
  BSIM_STATE* = 0x00000001
  BSIM_STYLE* = 0x00000002
  BSSF_VISIBLE* = 0x00000001
  BSSF_NOTITLE* = 0x00000002
  BSSF_UNDELETEABLE* = 0x00001000
  BSIS_AUTOGRIPPER* = 0x00000000
  BSIS_NOGRIPPER* = 0x00000001
  BSIS_ALWAYSGRIPPER* = 0x00000002
  BSIS_LEFTALIGN* = 0x00000004
  BSIS_SINGLECLICK* = 0x00000008
  BSIS_NOCONTEXTMENU* = 0x00000010
  BSIS_NODROPTARGET* = 0x00000020
  BSIS_NOCAPTION* = 0x00000040
  BSIS_PREFERNOLINEBREAK* = 0x00000080
  BSIS_LOCKED* = 0x00000100
  BSIS_PRESERVEORDERDURINGLAYOUT* = 0x00000200
  BSIS_FIXEDORDER* = 0x00000400
  IID_IBandSite* = DEFINE_GUID("4cf504b0-de96-11d0-8b3f-00a0c911e8e5")
  SID_SBandSite* = IID_IBandSite
  CGID_BandSite* = IID_IBandSite
  IID_IModalWindow* = DEFINE_GUID("b4db1657-70d7-485e-8e3e-6fcb5a5c1802")
  PROPSTR_EXTENSIONCOMPLETIONSTATE* = "ExtensionCompletionState"
  CDBE_RET_DEFAULT* = 0x0
  CDBE_RET_DONTRUNOTHEREXTS* = 0x1
  CDBE_RET_STOPWIZARD* = 0x2
  IID_ICDBurnExt* = DEFINE_GUID("2271dcca-74fc-4414-8fb7-c56b05ace2d7")
  SID_CDWizardHost* = IID_ICDBurnExt
  CDBE_TYPE_MUSIC* = 0x1
  CDBE_TYPE_DATA* = 0x2
  CDBE_TYPE_ALL* = int32 0xffffffff'i32
  IID_IContextMenuSite* = DEFINE_GUID("0811aebe-0b87-4c54-9e72-548cf649016b")
  IID_IEnumReadyCallback* = DEFINE_GUID("61e00d45-8fff-4e60-924e-6537b61612dd")
  IID_IEnumerableView* = DEFINE_GUID("8c8bf236-1aec-495f-9894-91d57c3c686f")
  SID_EnumerableView* = IID_IEnumerableView
  IID_IInsertItem* = DEFINE_GUID("d2b57227-3d23-4b95-93c0-492bd454c356")
  MBHANDCID_PIDLSELECT* = 0
  IID_IMenuBand* = DEFINE_GUID("568804cd-cbd7-11d0-9816-00c04fd91972")
  IID_IFolderBandPriv* = DEFINE_GUID("47c01f95-e185-412c-b5c5-4f27df965aea")
  IID_IRegTreeItem* = DEFINE_GUID("a9521922-0812-4d44-9ec3-7fd38c726f3d")
  IID_IImageRecompress* = DEFINE_GUID("505f1513-6b3e-4892-a272-59f8889a4d3e")
  IID_IDeskBar* = DEFINE_GUID("eb0fe173-1a3a-11d0-89b3-00a0c90a90ac")
  MPOS_EXECUTE* = 0
  MPOS_FULLCANCEL* = 1
  MPOS_CANCELLEVEL* = 2
  MPOS_SELECTLEFT* = 3
  MPOS_SELECTRIGHT* = 4
  MPOS_CHILDTRACKING* = 5
  MPPF_SETFOCUS* = 0x1
  MPPF_INITIALSELECT* = 0x2
  MPPF_NOANIMATE* = 0x4
  MPPF_KEYBOARD* = 0x10
  MPPF_REPOSITION* = 0x20
  MPPF_FORCEZORDER* = 0x40
  MPPF_FINALSELECT* = 0x80
  MPPF_TOP* = 0x20000000
  MPPF_LEFT* = 0x40000000
  MPPF_RIGHT* = 0x60000000
  MPPF_BOTTOM* = int32 0x80000000'i32
  MPPF_POS_MASK* = int32 0xe0000000'i32
  MPPF_ALIGN_LEFT* = 0x2000000
  MPPF_ALIGN_RIGHT* = 0x4000000
  IID_IMenuPopup* = DEFINE_GUID("d1e7afeb-6a2e-11d0-8c78-00c04fd918b4")
  FUT_PLAYING* = 0
  FUT_EDITING* = 1
  FUT_GENERIC* = 2
  OF_CAP_CANSWITCHTO* = 0x0001
  OF_CAP_CANCLOSE* = 0x0002
  IID_IFileIsInUse* = DEFINE_GUID("64a1cbf0-3a1a-4461-9158-376969693950")
  FDEOR_DEFAULT* = 0
  FDEOR_ACCEPT* = 1
  FDEOR_REFUSE* = 2
  FDESVR_DEFAULT* = 0
  FDESVR_ACCEPT* = 1
  FDESVR_REFUSE* = 2
  FDAP_BOTTOM* = 0
  FDAP_TOP* = 1
  IID_IFileDialogEvents* = DEFINE_GUID("973510db-7d7f-452b-8975-74a85828d354")
  FOS_OVERWRITEPROMPT* = 0x2
  FOS_STRICTFILETYPES* = 0x4
  FOS_NOCHANGEDIR* = 0x8
  FOS_PICKFOLDERS* = 0x20
  FOS_FORCEFILESYSTEM* = 0x40
  FOS_ALLNONSTORAGEITEMS* = 0x80
  FOS_NOVALIDATE* = 0x100
  FOS_ALLOWMULTISELECT* = 0x200
  FOS_PATHMUSTEXIST* = 0x800
  FOS_FILEMUSTEXIST* = 0x1000
  FOS_CREATEPROMPT* = 0x2000
  FOS_SHAREAWARE* = 0x4000
  FOS_NOREADONLYRETURN* = 0x8000
  FOS_NOTESTFILECREATE* = 0x10000
  FOS_HIDEMRUPLACES* = 0x20000
  FOS_HIDEPINNEDPLACES* = 0x40000
  FOS_NODEREFERENCELINKS* = 0x100000
  FOS_DONTADDTORECENT* = 0x2000000
  FOS_FORCESHOWHIDDEN* = 0x10000000
  FOS_DEFAULTNOMINIMODE* = 0x20000000
  FOS_FORCEPREVIEWPANEON* = 0x40000000
  IID_IFileDialog* = DEFINE_GUID("42f85136-db7e-439c-85f1-e4075d135fc8")
  IID_IFileSaveDialog* = DEFINE_GUID("84bccd23-5fde-4cdb-aea4-af64b83d78ab")
  IID_IFileOpenDialog* = DEFINE_GUID("d57c7288-d4ad-4768-be02-9d969532d960")
  CDCS_INACTIVE* = 0x0
  CDCS_ENABLED* = 0x1
  CDCS_VISIBLE* = 0x2
  CDCS_ENABLEDVISIBLE* = 0x3
  IID_IFileDialogCustomize* = DEFINE_GUID("e6fdd21a-163f-4975-9c8c-a69f1ba37034")
  IID_IFileDialogControlEvents* = DEFINE_GUID("36116642-d713-4b97-9b83-7484a9d00433")
  IID_IFileDialog2* = DEFINE_GUID("61744fc7-85b5-4791-a9b0-272276309b13")
  AL_MACHINE* = 0
  AL_EFFECTIVE* = 1
  AL_USER* = 2
  AT_FILEEXTENSION* = 0
  AT_URLPROTOCOL* = 1
  AT_STARTMENUCLIENT* = 2
  AT_MIMETYPE* = 3
  IID_IApplicationAssociationRegistration* = DEFINE_GUID("4e530b0a-e611-4c77-a3ac-9031d022281b")
  IID_IApplicationAssociationRegistrationUI* = DEFINE_GUID("1f76a169-f994-40ac-8fc8-0959e8874710")
  IID_IDelegateFolder* = DEFINE_GUID("add8ba80-002b-11d0-8f0f-00c04fd7d062")
  BFO_NONE* = 0x0
  BFO_BROWSER_PERSIST_SETTINGS* = 0x1
  BFO_RENAME_FOLDER_OPTIONS_TOINTERNET* = 0x2
  BFO_BOTH_OPTIONS* = 0x4
  BIF_PREFER_INTERNET_SHORTCUT* = 0x8
  BFO_BROWSE_NO_IN_NEW_PROCESS* = 0x10
  BFO_ENABLE_HYPERLINK_TRACKING* = 0x20
  BFO_USE_IE_OFFLINE_SUPPORT* = 0x40
  BFO_SUBSTITUE_INTERNET_START_PAGE* = 0x80
  BFO_USE_IE_LOGOBANDING* = 0x100
  BFO_ADD_IE_TOCAPTIONBAR* = 0x200
  BFO_USE_DIALUP_REF* = 0x400
  BFO_USE_IE_TOOLBAR* = 0x800
  BFO_NO_PARENT_FOLDER_SUPPORT* = 0x1000
  BFO_NO_REOPEN_NEXT_RESTART* = 0x2000
  BFO_GO_HOME_PAGE* = 0x4000
  BFO_PREFER_IEPROCESS* = 0x8000
  BFO_SHOW_NAVIGATION_CANCELLED* = 0x10000
  BFO_USE_IE_STATUSBAR* = 0x20000
  BFO_QUERY_ALL* = int32 0xffffffff'i32
  IID_IBrowserFrameOptions* = DEFINE_GUID("10df43c8-1dbe-11d3-8b34-006097df5bd4")
  NWMF_UNLOADING* = 0x1
  NWMF_USERINITED* = 0x2
  NWMF_FIRST* = 0x4
  NWMF_OVERRIDEKEY* = 0x8
  NWMF_SHOWHELP* = 0x10
  NWMF_HTMLDIALOG* = 0x20
  NWMF_FROMDIALOGCHILD* = 0x40
  NWMF_USERREQUESTED* = 0x80
  NWMF_USERALLOWED* = 0x100
  NWMF_FORCEWINDOW* = 0x10000
  NWMF_FORCETAB* = 0x20000
  NWMF_SUGGESTWINDOW* = 0x40000
  NWMF_SUGGESTTAB* = 0x80000
  NWMF_INACTIVETAB* = 0x100000
  IID_INewWindowManager* = DEFINE_GUID("d2bc4c84-3f72-4a52-a604-7bcbf3982cbb")
  SID_SNewWindowManager* = IID_INewWindowManager
  ATTACHMENT_PROMPT_NONE* = 0x0
  ATTACHMENT_PROMPT_SAVE* = 0x1
  ATTACHMENT_PROMPT_EXEC* = 0x2
  ATTACHMENT_PROMPT_EXEC_OR_SAVE* = 0x3
  ATTACHMENT_ACTION_CANCEL* = 0x0
  ATTACHMENT_ACTION_SAVE* = 0x1
  ATTACHMENT_ACTION_EXEC* = 0x2
  IID_IAttachmentExecute* = DEFINE_GUID("73db1241-1e85-4581-8e4f-a81e1d0f8c57")
  SMDM_SHELLFOLDER* = 0x00000001
  SMDM_HMENU* = 0x00000002
  SMDM_TOOLBAR* = 0x00000004
  SMIM_TYPE* = 0x1
  SMIM_FLAGS* = 0x2
  SMIM_ICON* = 0x4
  SMIT_SEPARATOR* = 0x1
  SMIT_STRING* = 0x2
  SMIF_ICON* = 0x1
  SMIF_ACCELERATOR* = 0x2
  SMIF_DROPTARGET* = 0x4
  SMIF_SUBMENU* = 0x8
  SMIF_CHECKED* = 0x20
  SMIF_DROPCASCADE* = 0x40
  SMIF_HIDDEN* = 0x80
  SMIF_DISABLED* = 0x100
  SMIF_TRACKPOPUP* = 0x200
  SMIF_DEMOTED* = 0x400
  SMIF_ALTSTATE* = 0x800
  SMIF_DRAGNDROP* = 0x1000
  SMIF_NEW* = 0x2000
  SMC_INITMENU* = 0x00000001
  SMC_CREATE* = 0x00000002
  SMC_EXITMENU* = 0x00000003
  SMC_GETINFO* = 0x00000005
  SMC_GETSFINFO* = 0x00000006
  SMC_GETOBJECT* = 0x00000007
  SMC_GETSFOBJECT* = 0x00000008
  SMC_SFEXEC* = 0x00000009
  SMC_SFSELECTITEM* = 0x0000000A
  SMC_REFRESH* = 0x00000010
  SMC_DEMOTE* = 0x00000011
  SMC_PROMOTE* = 0x00000012
  SMC_DEFAULTICON* = 0x00000016
  SMC_NEWITEM* = 0x00000017
  SMC_CHEVRONEXPAND* = 0x00000019
  SMC_DISPLAYCHEVRONTIP* = 0x0000002A
  SMC_SETSFOBJECT* = 0x0000002D
  SMC_SHCHANGENOTIFY* = 0x0000002E
  SMC_CHEVRONGETTIP* = 0x0000002F
  SMC_SFDDRESTRICTED* = 0x00000030
  SMC_SFEXEC_MIDDLE* = 0x00000031
  SMC_GETAUTOEXPANDSTATE* = 0x00000041
  SMC_AUTOEXPANDCHANGE* = 0x00000042
  SMC_GETCONTEXTMENUMODIFIER* = 0x00000043
  SMC_GETBKCONTEXTMENU* = 0x00000044
  SMC_OPEN* = 0x00000045
  SMAE_EXPANDED* = 0x00000001
  SMAE_CONTRACTED* = 0x00000002
  SMAE_USER* = 0x00000004
  SMAE_VALID* = 0x00000007
  IID_IShellMenuCallback* = DEFINE_GUID("4ca300a1-9b8d-11d1-8b22-00c04fd918d0")
  SMINIT_DEFAULT* = 0x00000000
  SMINIT_RESTRICT_DRAGDROP* = 0x00000002
  SMINIT_TOPLEVEL* = 0x00000004
  SMINIT_CACHED* = 0x00000010
  SMINIT_AUTOEXPAND* = 0x00000100
  SMINIT_AUTOTOOLTIP* = 0x00000200
  SMINIT_DROPONCONTAINER* = 0x00000400
  SMINIT_VERTICAL* = 0x10000000
  SMINIT_HORIZONTAL* = 0x20000000
  ANCESTORDEFAULT* = UINT(-1)
  SMSET_TOP* = 0x10000000
  SMSET_BOTTOM* = 0x20000000
  SMSET_DONTOWN* = 0x00000001
  SMINV_REFRESH* = 0x00000001
  SMINV_ID* = 0x00000008
  IID_IShellMenu* = DEFINE_GUID("ee1f7637-e138-11d1-8379-00c04fd918d0")
  IID_IShellRunDll* = DEFINE_GUID("fce4bde0-4b68-4b80-8e9c-7426315a7388")
  KF_CATEGORY_VIRTUAL* = 1
  KF_CATEGORY_FIXED* = 2
  KF_CATEGORY_COMMON* = 3
  KF_CATEGORY_PERUSER* = 4
  KFDF_LOCAL_REDIRECT_ONLY* = 0x2
  KFDF_ROAMABLE* = 0x4
  KFDF_PRECREATE* = 0x8
  KFDF_STREAM* = 0x10
  KFDF_PUBLISHEXPANDEDPATH* = 0x20
  KF_REDIRECT_USER_EXCLUSIVE* = 0x1
  KF_REDIRECT_COPY_SOURCE_DACL* = 0x2
  KF_REDIRECT_OWNER_USER* = 0x4
  KF_REDIRECT_SET_OWNER_EXPLICIT* = 0x8
  KF_REDIRECT_CHECK_ONLY* = 0x10
  KF_REDIRECT_WITH_UI* = 0x20
  KF_REDIRECT_UNPIN* = 0x40
  KF_REDIRECT_PIN* = 0x80
  KF_REDIRECT_COPY_CONTENTS* = 0x200
  KF_REDIRECT_DEL_SOURCE_CONTENTS* = 0x400
  KF_REDIRECT_EXCLUDE_ALL_KNOWN_SUBFOLDERS* = 0x800
  KF_REDIRECTION_CAPABILITIES_ALLOW_ALL* = 0xff
  KF_REDIRECTION_CAPABILITIES_REDIRECTABLE* = 0x1
  KF_REDIRECTION_CAPABILITIES_DENY_ALL* = 0xfff00
  KF_REDIRECTION_CAPABILITIES_DENY_POLICY_REDIRECTED* = 0x100
  KF_REDIRECTION_CAPABILITIES_DENY_POLICY* = 0x200
  KF_REDIRECTION_CAPABILITIES_DENY_PERMISSIONS* = 0x400
  IID_IKnownFolder* = DEFINE_GUID("3aa7af7e-9b36-420c-a8e3-f77d4674a488")
  FFFP_EXACTMATCH* = 0
  FFFP_NEARESTPARENTMATCH* = 1
  IID_IKnownFolderManager* = DEFINE_GUID("8be2d872-86aa-4d47-b776-32cca40c7018")
  SHARE_ROLE_INVALID* = -1
  SHARE_ROLE_READER* = 0
  SHARE_ROLE_CONTRIBUTOR* = 1
  SHARE_ROLE_CO_OWNER* = 2
  SHARE_ROLE_OWNER* = 3
  SHARE_ROLE_CUSTOM* = 4
  SHARE_ROLE_MIXED* = 5
  DEFSHAREID_USERS* = 1
  DEFSHAREID_PUBLIC* = 2
  IID_ISharingConfigurationManager* = DEFINE_GUID("b4cd448a-9c86-4466-9201-2e62105b87ae")
  IID_IPreviousVersionsInfo* = DEFINE_GUID("76e54780-ad74-48e3-a695-3ba9a0aff10d")
  IID_IRelatedItem* = DEFINE_GUID("a73ce67a-8ab1-44f1-8d43-d2fcbf6b1cd0")
  IID_IIdentityName* = DEFINE_GUID("7d903fca-d6f9-4810-8332-946c0177e247")
  IID_IDelegateItem* = DEFINE_GUID("3c5a1c94-c951-4cb7-bb6d-3b93f30cce93")
  IID_ICurrentItem* = DEFINE_GUID("240a7174-d653-4a1d-a6d3-d4943cfbfe3d")
  IID_ITransferMediumItem* = DEFINE_GUID("77f295d5-2d6f-4e19-b8ae-322f3e721ab5")
  IID_IUseToBrowseItem* = DEFINE_GUID("05edda5c-98a3-4717-8adb-c5e7da991eb1")
  IID_IDisplayItem* = DEFINE_GUID("c6fd5997-9f6b-4888-8703-94e80e8cde3f")
  IID_IViewStateIdentityItem* = DEFINE_GUID("9d264146-a94f-4195-9f9f-3bb12ce0c955")
  IID_IPreviewItem* = DEFINE_GUID("36149969-0a8f-49c8-8b00-4aecb20222fb")
  IID_IDestinationStreamFactory* = DEFINE_GUID("8a87781b-39a7-4a1f-aab3-a39b9c34a7d9")
  NMCII_NONE* = 0x0
  NMCII_ITEMS* = 0x1
  NMCII_FOLDERS* = 0x2
  NMCSAEI_SELECT* = 0x0
  NMCSAEI_EDIT* = 0x1
  IID_INewMenuClient* = DEFINE_GUID("dcb07fdc-3bb5-451c-90be-966644fed7b0")
  SID_SNewMenuClient* = IID_INewMenuClient
  SID_SCommandBarState* = DEFINE_GUID("b99eaa5c-3850-4400-bc33-2ce534048bf8")
  IID_IInitializeWithBindCtx* = DEFINE_GUID("71c0d2bc-726d-45cc-a6c0-2e31c1db2159")
  IID_IShellItemFilter* = DEFINE_GUID("2659b475-eeb8-48b7-8f07-b378810f48cf")
  NSTCS_HASEXPANDOS* = 0x1
  NSTCS_HASLINES* = 0x2
  NSTCS_SINGLECLICKEXPAND* = 0x4
  NSTCS_FULLROWSELECT* = 0x8
  NSTCS_SPRINGEXPAND* = 0x10
  NSTCS_HORIZONTALSCROLL* = 0x20
  NSTCS_ROOTHASEXPANDO* = 0x40
  NSTCS_SHOWSELECTIONALWAYS* = 0x80
  NSTCS_NOINFOTIP* = 0x200
  NSTCS_EVENHEIGHT* = 0x400
  NSTCS_NOREPLACEOPEN* = 0x800
  NSTCS_DISABLEDRAGDROP* = 0x1000
  NSTCS_NOORDERSTREAM* = 0x2000
  NSTCS_RICHTOOLTIP* = 0x4000
  NSTCS_BORDER* = 0x8000
  NSTCS_NOEDITLABELS* = 0x10000
  NSTCS_TABSTOP* = 0x20000
  NSTCS_FAVORITESMODE* = 0x80000
  NSTCS_AUTOHSCROLL* = 0x100000
  NSTCS_FADEINOUTEXPANDOS* = 0x200000
  NSTCS_EMPTYTEXT* = 0x400000
  NSTCS_CHECKBOXES* = 0x800000
  NSTCS_PARTIALCHECKBOXES* = 0x1000000
  NSTCS_EXCLUSIONCHECKBOXES* = 0x2000000
  NSTCS_DIMMEDCHECKBOXES* = 0x4000000
  NSTCS_NOINDENTCHECKS* = 0x8000000
  NSTCS_ALLOWJUNCTIONS* = 0x10000000
  NSTCS_SHOWTABSBUTTON* = 0x20000000
  NSTCS_SHOWDELETEBUTTON* = 0x40000000
  NSTCS_SHOWREFRESHBUTTON* = int32 0x80000000'i32
  NSTCRS_VISIBLE* = 0x0
  NSTCRS_HIDDEN* = 0x1
  NSTCRS_EXPANDED* = 0x2
  NSTCIS_NONE* = 0x0
  NSTCIS_SELECTED* = 0x1
  NSTCIS_EXPANDED* = 0x2
  NSTCIS_BOLD* = 0x4
  NSTCIS_DISABLED* = 0x8
  NSTCIS_SELECTEDNOEXPAND* = 0x10
  NSTCGNI_NEXT* = 0
  NSTCGNI_NEXTVISIBLE* = 1
  NSTCGNI_PREV* = 2
  NSTCGNI_PREVVISIBLE* = 3
  NSTCGNI_PARENT* = 4
  NSTCGNI_CHILD* = 5
  NSTCGNI_FIRSTVISIBLE* = 6
  NSTCGNI_LASTVISIBLE* = 7
  IID_INameSpaceTreeControl* = DEFINE_GUID("028212a3-b627-47e9-8856-c14265554e4f")
  NSTCS2_DEFAULT* = 0x0
  NSTCS2_INTERRUPTNOTIFICATIONS* = 0x1
  NSTCS2_SHOWNULLSPACEMENU* = 0x2
  NSTCS2_DISPLAYPADDING* = 0x4
  NSTCS2_DISPLAYPINNEDONLY* = 0x8
  NTSCS2_NOSINGLETONAUTOEXPAND* = 0x10
  NTSCS2_NEVERINSERTNONENUMERATED* = 0x20
  IID_INameSpaceTreeControl2* = DEFINE_GUID("7cc7aed8-290e-49bc-8945-c1401cc9306c")
  NSTCS2_ALLMASK* = NSTCS2_INTERRUPTNOTIFICATIONS or NSTCS2_SHOWNULLSPACEMENU or NSTCS2_DISPLAYPADDING
  SID_SNavigationPane* = IID_INameSpaceTreeControl
  NSTCEHT_NOWHERE* = 0x1
  NSTCEHT_ONITEMICON* = 0x2
  NSTCEHT_ONITEMLABEL* = 0x4
  NSTCEHT_ONITEMINDENT* = 0x8
  NSTCEHT_ONITEMBUTTON* = 0x10
  NSTCEHT_ONITEMRIGHT* = 0x20
  NSTCEHT_ONITEMSTATEICON* = 0x40
  NSTCEHT_ONITEM* = 0x46
  NSTCEHT_ONITEMTABBUTTON* = 0x1000
  NSTCECT_LBUTTON* = 0x1
  NSTCECT_MBUTTON* = 0x2
  NSTCECT_RBUTTON* = 0x3
  NSTCECT_BUTTON* = 0x3
  NSTCECT_DBLCLICK* = 0x4
  IID_INameSpaceTreeControlEvents* = DEFINE_GUID("93d77985-b3d8-4484-8318-672cdda002ce")
  NSTCDHPOS_ONTOP* = -1
  IID_INameSpaceTreeControlDropHandler* = DEFINE_GUID("f9c665d6-c2f2-4c19-bf33-8322d7352f51")
  IID_INameSpaceTreeAccessible* = DEFINE_GUID("71f312de-43ed-4190-8477-e9536b82350b")
  IID_INameSpaceTreeControlCustomDraw* = DEFINE_GUID("2d3ba758-33ee-42d5-bb7b-5f3431d86c78")
  NSTCFC_NONE* = 0x0
  NSTCFC_PINNEDITEMFILTERING* = 0x1
  NSTCFC_DELAY_REGISTER_NOTIFY* = 0x2
  IID_INameSpaceTreeControlFolderCapabilities* = DEFINE_GUID("e9701183-e6b3-4ff2-8568-813615fec7be")
  E_PREVIEWHANDLER_DRM_FAIL* = HRESULT 0x86420001'i32
  E_PREVIEWHANDLER_NOAUTH* = HRESULT 0x86420002'i32
  E_PREVIEWHANDLER_NOTFOUND* = HRESULT 0x86420003'i32
  E_PREVIEWHANDLER_CORRUPT* = HRESULT 0x86420004'i32
  IID_IPreviewHandler* = DEFINE_GUID("8895b1c6-b41f-4c1c-a562-0d564250836f")
  IID_IPreviewHandlerFrame* = DEFINE_GUID("fec87aaf-35f9-447a-adb7-20234491401a")
  IID_ITrayDeskBand* = DEFINE_GUID("6d67e846-5b9c-4db8-9cbc-dde12f4254f1")
  IID_IBandHost* = DEFINE_GUID("b9075c7c-d48e-403f-ab99-d6c77a1084ac")
  SID_SBandHost* = IID_IBandHost
  EPS_DONTCARE* = 0x0
  EPS_DEFAULT_ON* = 0x1
  EPS_DEFAULT_OFF* = 0x2
  EPS_STATEMASK* = 0xffff
  EPS_INITIALSTATE* = 0x10000
  EPS_FORCE* = 0x20000
  IID_IExplorerPaneVisibility* = DEFINE_GUID("e07010ec-bc17-44c0-97b0-46c7c95b9edc")
  SID_ExplorerPaneVisibility* = IID_IExplorerPaneVisibility
  IID_IContextMenuCB* = DEFINE_GUID("3409e930-5a39-11d1-83fa-00a0c90dc849")
  IID_IDefaultExtractIconInit* = DEFINE_GUID("41ded17d-d6b3-4261-997d-88c60e4b1d58")
  ECS_ENABLED* = 0x0
  ECS_DISABLED* = 0x1
  ECS_HIDDEN* = 0x2
  ECS_CHECKBOX* = 0x4
  ECS_CHECKED* = 0x8
  ECS_RADIOCHECK* = 0x10
  ECF_DEFAULT* = 0x0
  ECF_HASSUBCOMMANDS* = 0x1
  ECF_HASSPLITBUTTON* = 0x2
  ECF_HIDELABEL* = 0x4
  ECF_ISSEPARATOR* = 0x8
  ECF_HASLUASHIELD* = 0x10
  ECF_SEPARATORBEFORE* = 0x20
  ECF_SEPARATORAFTER* = 0x40
  ECF_ISDROPDOWN* = 0x80
  ECF_TOGGLEABLE* = 0x100
  ECF_AUTOMENUICONS* = 0x200
  IID_IExplorerCommand* = DEFINE_GUID("a08ce4d0-fa25-44ab-b57c-c7b1c323e0b9")
  IID_IExplorerCommandState* = DEFINE_GUID("bddacb60-7657-47ae-8445-d23e1acf82ae")
  IID_IInitializeCommand* = DEFINE_GUID("85075acf-231f-40ea-9610-d26b7b58f638")
  IID_IEnumExplorerCommand* = DEFINE_GUID("a88826f8-186f-4987-aade-ea0cef8fbfe8")
  IID_IExplorerCommandProvider* = DEFINE_GUID("64961751-0835-43c0-8ffe-d57686530e64")
  IID_IInitializeNetworkFolder* = DEFINE_GUID("6e0f9881-42a8-4f2a-97f8-8af4e026d92d")
  CPVIEW_CLASSIC* = 0
  CPVIEW_ALLITEMS* = CPVIEW_CLASSIC
  CPVIEW_CATEGORY* = 1
  CPVIEW_HOME* = CPVIEW_CATEGORY
  IID_IOpenControlPanel* = DEFINE_GUID("d11ad862-66de-4df4-bf6c-1f5621996af1")
  IID_IComputerInfoChangeNotify* = DEFINE_GUID("0df60d92-6818-46d6-b358-d66170dde466")
  STR_FILE_SYS_BIND_DATA* = "File System Bind Data"
  IID_IFileSystemBindData* = DEFINE_GUID("01e18d10-4d8b-11d2-855d-006008059367")
  IID_IFileSystemBindData2* = DEFINE_GUID("3acf075f-71db-4afa-81f0-3fc4fdf2a5b8")
  KDC_FREQUENT* = 1
  KDC_RECENT* = 2
  IID_ICustomDestinationList* = DEFINE_GUID("6332debf-87b5-4670-90c0-5e57b408a49e")
  IID_IApplicationDestinations* = DEFINE_GUID("12337d35-94c6-48a0-bce7-6a9c69d4d600")
  ADLT_RECENT* = 0
  ADLT_FREQUENT* = 1
  IID_IApplicationDocumentLists* = DEFINE_GUID("3c594f9f-9f30-47a1-979a-c9e83d3d0a06")
  IID_IObjectWithAppUserModelID* = DEFINE_GUID("36db0196-9665-46d1-9ba7-d3709eecf9ed")
  IID_IObjectWithProgID* = DEFINE_GUID("71e806fb-8dee-46fc-bf8c-7748a8a1ae13")
  IID_IUpdateIDList* = DEFINE_GUID("6589b6d2-5f8d-4b9e-b7e0-23cdd9717d8c")
  IID_IDesktopGadget* = DEFINE_GUID("c1646bc4-f298-4f91-a204-eb2dd1709d1a")
  DSO_SHUFFLEIMAGES* = 0x1
  DSS_ENABLED* = 0x1
  DSS_SLIDESHOW* = 0x2
  DSS_DISABLED_BY_REMOTE_SESSION* = 0x4
  DSD_FORWARD* = 0
  DSD_BACKWARD* = 1
  DWPOS_CENTER* = 0
  DWPOS_TILE* = 1
  DWPOS_STRETCH* = 2
  DWPOS_FIT* = 3
  DWPOS_FILL* = 4
  DWPOS_SPAN* = 5
  IID_IDesktopWallpaper* = DEFINE_GUID("b92b56a9-8b55-4e14-9a89-0199bbb6f93b")
  HOMEGROUP_SECURITY_GROUP_MULTI* = "HUG"
  HOMEGROUP_SECURITY_GROUP* = "HomeUsers"
  HGSC_NONE* = 0x0
  HGSC_MUSICLIBRARY* = 0x1
  HGSC_PICTURESLIBRARY* = 0x2
  HGSC_VIDEOSLIBRARY* = 0x4
  HGSC_DOCUMENTSLIBRARY* = 0x8
  HGSC_PRINTERS* = 0x10
  IID_IHomeGroup* = DEFINE_GUID("7a3bd1d9-35a9-4fb3-a467-f48cac35e2d0")
  IID_IInitializeWithPropertyStore* = DEFINE_GUID("c3e12eb5-7d8d-44f8-b6dd-0e77b34d6de4")
  IID_IOpenSearchSource* = DEFINE_GUID("f0ee7333-e6fc-479b-9f25-a860c234a38e")
  LFF_FORCEFILESYSTEM* = 1
  LFF_STORAGEITEMS* = 2
  LFF_ALLITEMS* = 3
  LOF_DEFAULT* = 0x0
  LOF_PINNEDTONAVPANE* = 0x1
  LOF_MASK_ALL* = 0x1
  DSFT_DETECT* = 1
  DSFT_PRIVATE* = 2
  DSFT_PUBLIC* = 3
  LSF_FAILIFTHERE* = 0x0
  LSF_OVERRIDEEXISTING* = 0x1
  LSF_MAKEUNIQUENAME* = 0x2
  IID_IShellLibrary* = DEFINE_GUID("11a66efa-382e-451a-9234-1e0e12ef3085")
  PE_DUCKSESSION* = 1
  PE_UNDUCKSESSION* = 2
  IID_IPlaybackManagerEvents* = DEFINE_GUID("385cfb7d-4e0c-4106-912e-8cfb4c191f45")
  ST_COMMUNICATION* = 1
  ST_MEDIA* = 2
  PS_PLAYING* = 1
  PS_PAUSED* = 2
  PS_STOPPED* = 3
  MS_MUTED* = 1
  MS_UNMUTED* = 2
  IID_IPlaybackManager* = DEFINE_GUID("0f3c1b01-8199-4173-ba78-985882266f7a")
  DFMR_DEFAULT* = 0x0
  DFMR_NO_STATIC_VERBS* = 0x8
  DFMR_STATIC_VERBS_ONLY* = 0x10
  DFMR_NO_RESOURCE_VERBS* = 0x20
  DFMR_OPTIN_HANDLERS_ONLY* = 0x40
  DFMR_RESOURCE_AND_FOLDER_VERBS_ONLY* = 0x80
  DFMR_USE_SPECIFIED_HANDLERS* = 0x100
  DFMR_USE_SPECIFIED_VERBS* = 0x200
  DFMR_NO_ASYNC_VERBS* = 0x400
  IID_IDefaultFolderMenuInitialize* = DEFINE_GUID("7690aa79-f8fc-4615-a327-36f7d18f5d91")
  AO_NONE* = 0x0
  AO_DESIGNMODE* = 0x1
  AO_NOERRORUI* = 0x2
  AO_NOSPLASHSCREEN* = 0x4
  IID_IApplicationActivationManager* = DEFINE_GUID("2e941141-7f97-4756-ba1d-9decde894a3d")
  LIBID_ShellObjects* = DEFINE_GUID("50a7e9b1-70ef-11d1-b75a-00a0c90564fe")
  CLSID_DesktopWallpaper* = DEFINE_GUID("c2cf3110-460e-4fc1-b9d0-8a1c0c9cc4bd")
  CLSID_ShellFSFolder* = DEFINE_GUID("f3364ba0-65b9-11ce-a9ba-00aa004ae837")
  CLSID_NetworkPlaces* = DEFINE_GUID("208d2c60-3aea-1069-a2d7-08002b30309d")
  CLSID_ShellLink* = DEFINE_GUID("00021401-0000-0000-c000-000000000046")
  CLSID_QueryCancelAutoPlay* = DEFINE_GUID("331f1768-05a9-4ddd-b86e-dae34ddc998a")
  CLSID_DriveSizeCategorizer* = DEFINE_GUID("94357b53-ca29-4b78-83ae-e8fe7409134f")
  CLSID_DriveTypeCategorizer* = DEFINE_GUID("b0a8f3cf-4333-4bab-8873-1ccb1cada48b")
  CLSID_FreeSpaceCategorizer* = DEFINE_GUID("b5607793-24ac-44c7-82e2-831726aa6cb7")
  CLSID_TimeCategorizer* = DEFINE_GUID("3bb4118f-ddfd-4d30-a348-9fb5d6bf1afe")
  CLSID_SizeCategorizer* = DEFINE_GUID("55d7b852-f6d1-42f2-aa75-8728a1b2d264")
  CLSID_AlphabeticalCategorizer* = DEFINE_GUID("3c2654c6-7372-4f6b-b310-55d6128f49d2")
  CLSID_MergedCategorizer* = DEFINE_GUID("8e827c11-33e7-4bc1-b242-8cd9a1c2b304")
  CLSID_ImageProperties* = DEFINE_GUID("7ab770c7-0e23-4d7a-8aa2-19bfad479829")
  CLSID_PropertiesUI* = DEFINE_GUID("d912f8cf-0396-4915-884e-fb425d32943b")
  CLSID_UserNotification* = DEFINE_GUID("0010890e-8789-413c-adbc-48f5b511b3af")
  CLSID_CDBurn* = DEFINE_GUID("fbeb8a05-beee-4442-804e-409d6c4515e9")
  CLSID_TaskbarList* = DEFINE_GUID("56fdf344-fd6d-11d0-958a-006097c9a090")
  CLSID_StartMenuPin* = DEFINE_GUID("a2a9545d-a0c2-42b4-9708-a0b2badd77c8")
  CLSID_WebWizardHost* = DEFINE_GUID("c827f149-55c1-4d28-935e-57e47caed973")
  CLSID_PublishDropTarget* = DEFINE_GUID("cc6eeffb-43f6-46c5-9619-51d571967f7d")
  CLSID_PublishingWizard* = DEFINE_GUID("6b33163c-76a5-4b6c-bf21-45de9cd503a1")
  SID_PublishingWizard* = CLSID_PublishingWizard
  CLSID_InternetPrintOrdering* = DEFINE_GUID("add36aa8-751a-4579-a266-d66f5202ccbb")
  CLSID_FolderViewHost* = DEFINE_GUID("20b1cb23-6968-4eb9-b7d4-a66d00d07cee")
  CLSID_ExplorerBrowser* = DEFINE_GUID("71f96385-ddd6-48d3-a0c1-ae06e8b055fb")
  CLSID_ImageRecompress* = DEFINE_GUID("6e33091c-d2f8-4740-b55e-2e11d1477a2c")
  CLSID_TrayBandSiteService* = DEFINE_GUID("f60ad0a0-e5e1-45cb-b51a-e15b9f8b2934")
  CLSID_TrayDeskBand* = DEFINE_GUID("e6442437-6c68-4f52-94dd-2cfed267efb9")
  CLSID_AttachmentServices* = DEFINE_GUID("4125dd96-e03a-4103-8f70-e0597d803b9c")
  CLSID_DocPropShellExtension* = DEFINE_GUID("883373c3-bf89-11d1-be35-080036b11a03")
  CLSID_ShellItem* = DEFINE_GUID("9ac9fbe1-e0a2-4ad6-b4ee-e212013ea917")
  CLSID_NamespaceWalker* = DEFINE_GUID("72eb61e0-8672-4303-9175-f2e4c68b2e7c")
  CLSID_FileOperation* = DEFINE_GUID("3ad05575-8857-4850-9277-11b85bdb8e09")
  CLSID_FileOpenDialog* = DEFINE_GUID("dc1c5a9c-e88a-4dde-a5a1-60f82a20aef7")
  CLSID_FileSaveDialog* = DEFINE_GUID("c0b4e2f3-ba21-4773-8dba-335ec946eb8b")
  CLSID_KnownFolderManager* = DEFINE_GUID("4df0c730-df9d-4ae3-9153-aa6b82e9795a")
  CLSID_FSCopyHandler* = DEFINE_GUID("d197380a-0a79-4dc8-a033-ed882c2fa14b")
  CLSID_SharingConfigurationManager* = DEFINE_GUID("49f371e1-8c5c-4d9c-9a3b-54a6827f513c")
  CLSID_PreviousVersions* = DEFINE_GUID("596ab062-b4d2-4215-9f74-e9109b0a8153")
  CLSID_NetworkConnections* = DEFINE_GUID("7007acc7-3202-11d1-aad2-00805fc1270e")
  CLSID_NamespaceTreeControl* = DEFINE_GUID("ae054212-3535-4430-83ed-d501aa6680e6")
  CLSID_IENamespaceTreeControl* = DEFINE_GUID("ace52d03-e5cd-4b20-82ff-e71b11beae1d")
  CLSID_ScheduledTasks* = DEFINE_GUID("d6277990-4c6a-11cf-8d87-00aa0060f5bf")
  CLSID_ApplicationAssociationRegistration* = DEFINE_GUID("591209c7-767b-42b2-9fba-44ee4615f2c7")
  CLSID_ApplicationAssociationRegistrationUI* = DEFINE_GUID("1968106d-f3b5-44cf-890e-116fcb9ecef1")
  CLSID_SearchFolderItemFactory* = DEFINE_GUID("14010e02-bbbd-41f0-88e3-eda371216584")
  CLSID_OpenControlPanel* = DEFINE_GUID("06622d85-6856-4460-8de1-a81921b41c4b")
  CLSID_MailRecipient* = DEFINE_GUID("9e56be60-c50f-11cf-9a2c-00a0c90a90ce")
  CLSID_NetworkExplorerFolder* = DEFINE_GUID("f02c1a0d-be21-4350-88b0-7367fc96ef3c")
  CLSID_DestinationList* = DEFINE_GUID("77f10cf0-3db5-4966-b520-b7c54fd35ed6")
  CLSID_ApplicationDestinations* = DEFINE_GUID("86c14003-4d6b-4ef3-a7b4-0506663b2e68")
  CLSID_ApplicationDocumentLists* = DEFINE_GUID("86bec222-30f2-47e0-9f25-60d11cd75c28")
  CLSID_HomeGroup* = DEFINE_GUID("de77ba04-3c92-4d11-a1a5-42352a53e0e3")
  CLSID_ShellLibrary* = DEFINE_GUID("d9b3211d-e57f-4426-aaef-30a806add397")
  CLSID_AppStartupLink* = DEFINE_GUID("273eb5e7-88b0-4843-bfef-e2c81d43aae5")
  CLSID_EnumerableObjectCollection* = DEFINE_GUID("2d3468c1-36a7-43b6-ac24-d3f02fd9607a")
  CLSID_DesktopGadget* = DEFINE_GUID("924ccc1b-6562-4c85-8657-d177925222b6")
  CLSID_PlaybackManager* = DEFINE_GUID("29dfa654-a97f-47f0-bf26-9e41fb9488d9")
  CLSID_AccessibilityDockingService* = DEFINE_GUID("29ce1d46-b481-4aa0-a08a-d3ebc8aca402")
  CLSID_FrameworkInputPane* = DEFINE_GUID("d5120aa3-46ba-44c5-822d-ca8092c1fc72")
  CLSID_DefFolderMenu* = DEFINE_GUID("c63382be-7933-48d0-9ac8-85fb46be2fdd")
  CLSID_AppVisibility* = DEFINE_GUID("7e5fe3d9-985f-4908-91f9-ee19f9fd1514")
  CLSID_AppShellVerbHandler* = DEFINE_GUID("4ed3a719-cea8-4bd9-910d-e252f997afc2")
  CLSID_ExecuteUnknown* = DEFINE_GUID("e44e9428-bdbc-4987-a099-40dc8fd255e7")
  CLSID_PackageDebugSettings* = DEFINE_GUID("b1aec16f-2383-4852-b0e9-8f0b1dc66b4d")
  CLSID_ApplicationActivationManager* = DEFINE_GUID("45ba127d-10a8-46ea-8ab7-56ea9078943c")
  CLSID_ApplicationDesignModeSettings* = DEFINE_GUID("958a6fb5-dcb2-4faf-aafd-7fb054ad1a3b")
  CLSID_ExecuteFolder* = DEFINE_GUID("11dbb47c-a525-400b-9e80-a54615a090c0")
  LMD_DEFAULT* = 0x0
  LMD_ALLOWUNINDEXABLENETWORKLOCATIONS* = 0x1
  IID_IAssocHandlerInvoker* = DEFINE_GUID("92218cab-ecaa-4335-8133-807fd234c2ee")
  IID_IAssocHandler* = DEFINE_GUID("f04061ac-1659-4a3f-a954-775aa57fc083")
  IID_IEnumAssocHandlers* = DEFINE_GUID("973810ae-9599-4b88-9e4d-6ee98c9552da")
  ASSOC_FILTER_NONE* = 0x0
  ASSOC_FILTER_RECOMMENDED* = 0x1
  IID_IDataObjectProvider* = DEFINE_GUID("3d25f6d6-4b2a-433c-9184-7c33ad35d001")
  IID_IDataTransferManagerInterop* = DEFINE_GUID("3a3dcd6c-3eab-43dc-bcde-45671ce800c8")
  IID_IFrameworkInputPaneHandler* = DEFINE_GUID("226c537b-1e76-4d9e-a760-33db29922f18")
  IID_IFrameworkInputPane* = DEFINE_GUID("5752238b-24f0-495a-82f1-2fd593056796")
  PROP_CONTRACT_DELEGATE* = "ContractDelegate"
  IID_ISearchableApplication* = DEFINE_GUID("08922f8d-243a-49e3-a495-bd4f9cf8ab9e")
  UR_RESOLUTION_CHANGE* = 0
  UR_MONITOR_DISCONNECT* = 1
  IID_IAccessibilityDockingServiceCallback* = DEFINE_GUID("157733fd-a592-42e5-b594-248468c5a81b")
  IID_IAccessibilityDockingService* = DEFINE_GUID("8849dc22-cedf-4c95-998d-051419dd3f76")
  MAV_UNKNOWN* = 0
  MAV_NO_APP_VISIBLE* = 1
  MAV_APP_VISIBLE* = 2
  IID_IAppVisibilityEvents* = DEFINE_GUID("6584ce6b-7d82-49c2-89c9-c6bc02ba8c38")
  IID_IAppVisibility* = DEFINE_GUID("2246ea2d-caea-4444-a3c4-6de827e44313")
  PES_UNKNOWN* = 0
  PES_RUNNING* = 1
  PES_SUSPENDING* = 2
  PES_SUSPENDED* = 3
  PES_TERMINATED* = 4
  IID_IPackageExecutionStateChangeNotification* = DEFINE_GUID("1bb12a62-2ad8-432b-8ccf-0c2c52afcd5b")
  IID_IPackageDebugSettings* = DEFINE_GUID("f27c3930-8029-4ad1-94e3-3dba417810c1")
  AHE_DESKTOP* = 0
  AHE_IMMERSIVE* = 1
  IID_IExecuteCommandApplicationHostEnvironment* = DEFINE_GUID("18b21aa9-e184-4ff0-9f5e-f882d03771b3")
  ECHUIM_DESKTOP* = 0
  ECHUIM_IMMERSIVE* = 1
  ECHUIM_SYSTEM_LAUNCHER* = 2
  IID_IExecuteCommandHost* = DEFINE_GUID("4b6832a2-5f04-4c9d-b89d-727a15d103e7")
  SID_ExecuteCommandHost* = IID_IExecuteCommandHost
  AVS_FULLSCREEN_LANDSCAPE* = 0
  AVS_FILLED* = 1
  AVS_SNAPPED* = 2
  AVS_FULLSCREEN_PORTRAIT* = 3
  EGK_TOUCH* = 0
  EGK_KEYBOARD* = 1
  EGK_MOUSE* = 2
  IID_IApplicationDesignModeSettings* = DEFINE_GUID("2a3dee9a-e31d-46d6-8508-bcc597db3557")
  IID_IInitializeWithWindow* = DEFINE_GUID("3e68d4bd-7135-4d10-8018-9fb6d9f33fa1")
  IID_IHandlerInfo* = DEFINE_GUID("997706ef-f880-453b-8118-39e1a2d2655a")
  IID_IHandlerActivationHost* = DEFINE_GUID("35094a87-8bb1-4237-96c6-c417eebdb078")
  SID_SHandlerActivationHost* = IID_IHandlerActivationHost
  SID_ShellExecuteNamedPropertyStore* = DEFINE_GUID("eb84ada2-00ff-4992-8324-ed5ce061cb29")
  GIL_OPENICON* = 0x1
  GIL_FORSHELL* = 0x2
  GIL_ASYNC* = 0x20
  GIL_DEFAULTICON* = 0x40
  GIL_FORSHORTCUT* = 0x80
  GIL_CHECKSHIELD* = 0x200
  GIL_SIMULATEDOC* = 0x1
  GIL_PERINSTANCE* = 0x2
  GIL_PERCLASS* = 0x4
  GIL_NOTFILENAME* = 0x8
  GIL_DONTCACHE* = 0x10
  GIL_SHIELD* = 0x200
  GIL_FORCENOSHIELD* = 0x400
  ISIOI_ICONFILE* = 0x1
  ISIOI_ICONINDEX* = 0x2
  SIOM_OVERLAYINDEX* = 1
  SIOM_ICONINDEX* = 2
  SIOM_RESERVED_SHARED* = 0
  SIOM_RESERVED_LINK* = 1
  SIOM_RESERVED_SLOWFILE* = 2
  SIOM_RESERVED_DEFAULT* = 3
  OI_DEFAULT* = 0x0
  OI_ASYNC* = 0xffffeeee'i32
  IDO_SHGIOI_SHARE* = 0x0fffffff
  IDO_SHGIOI_LINK* = 0x0ffffffe
  IDO_SHGIOI_SLOWFILE* = 0x0fffffffd'i32
  IDO_SHGIOI_DEFAULT* = 0x0fffffffc'i32
  SLDF_DEFAULT* = 0x00000000
  SLDF_HAS_ID_LIST* = 0x00000001
  SLDF_HAS_LINK_INFO* = 0x00000002
  SLDF_HAS_NAME* = 0x00000004
  SLDF_HAS_RELPATH* = 0x00000008
  SLDF_HAS_WORKINGDIR* = 0x00000010
  SLDF_HAS_ARGS* = 0x00000020
  SLDF_HAS_ICONLOCATION* = 0x00000040
  SLDF_UNICODE* = 0x00000080
  SLDF_FORCE_NO_LINKINFO* = 0x00000100
  SLDF_HAS_EXP_SZ* = 0x00000200
  SLDF_RUN_IN_SEPARATE* = 0x00000400
  SLDF_HAS_LOGO3ID* = 0x00000800
  SLDF_HAS_DARWINID* = 0x00001000
  SLDF_RUNAS_USER* = 0x00002000
  SLDF_HAS_EXP_ICON_SZ* = 0x00004000
  SLDF_NO_PIDL_ALIAS* = 0x00008000
  SLDF_FORCE_UNCNAME* = 0x00010000
  SLDF_RUN_WITH_SHIMLAYER* = 0x00020000
  SLDF_FORCE_NO_LINKTRACK* = 0x00040000
  SLDF_ENABLE_TARGET_METADATA* = 0x00080000
  SLDF_DISABLE_LINK_PATH_TRACKING* = 0x00100000
  SLDF_DISABLE_KNOWNFOLDER_RELATIVE_TRACKING* = 0x00200000
  SLDF_NO_KF_ALIAS* = 0x00400000
  SLDF_ALLOW_LINK_TO_LINK* = 0x00800000
  SLDF_UNALIAS_ON_SAVE* = 0x01000000
  SLDF_PREFER_ENVIRONMENT_PATH* = 0x02000000
  SLDF_KEEP_LOCAL_IDLIST_FOR_UNC_TARGET* = 0x04000000
  SLDF_PERSIST_VOLUME_ID_RELATIVE* = 0x08000000
  SLDF_VALID* = 0x0ffff7ff
  SLDF_RESERVED* = int32 0x80000000'i32
  NT_CONSOLE_PROPS_SIG* = 0xa0000002'i32
  NT_FE_CONSOLE_PROPS_SIG* = 0xa0000004'i32
  EXP_DARWIN_ID_SIG* = 0xa0000006'i32
  EXP_SPECIAL_FOLDER_SIG* = 0xa0000005'i32
  EXP_SZ_LINK_SIG* = 0xa0000001'i32
  EXP_SZ_ICON_SIG* = 0xa0000007'i32
  EXP_PROPERTYSTORAGE_SIG* = 0xa0000009'i32
  FVSIF_RECT* = 0x00000001
  FVSIF_PINNED* = 0x00000002
  FVSIF_NEWFAILED* = 0x08000000
  FVSIF_NEWFILE* = 0x80000000'i32
  FVSIF_CANVIEWIT* = 0x40000000
  FCIDM_SHVIEWFIRST* = 0x0000
  FCIDM_SHVIEWLAST* = 0x7fff
  FCIDM_BROWSERFIRST* = 0xa000
  FCIDM_BROWSERLAST* = 0xbf00
  FCIDM_GLOBALFIRST* = 0x8000
  FCIDM_GLOBALLAST* = 0x9fff
  FCIDM_MENU_FILE* = FCIDM_GLOBALFIRST+0x0000
  FCIDM_MENU_EDIT* = FCIDM_GLOBALFIRST+0x0040
  FCIDM_MENU_VIEW* = FCIDM_GLOBALFIRST+0x0080
  FCIDM_MENU_VIEW_SEP_OPTIONS* = FCIDM_GLOBALFIRST+0x0081
  FCIDM_MENU_TOOLS* = FCIDM_GLOBALFIRST+0x00c0
  FCIDM_MENU_TOOLS_SEP_GOTO* = FCIDM_GLOBALFIRST+0x00c1
  FCIDM_MENU_HELP* = FCIDM_GLOBALFIRST+0x0100
  FCIDM_MENU_FIND* = FCIDM_GLOBALFIRST+0x0140
  FCIDM_MENU_EXPLORE* = FCIDM_GLOBALFIRST+0x0150
  FCIDM_MENU_FAVORITES* = FCIDM_GLOBALFIRST+0x0170
  FCIDM_TOOLBAR* = FCIDM_BROWSERFIRST+0
  FCIDM_STATUS* = FCIDM_BROWSERFIRST+1
  IDC_OFFLINE_HAND* = 103
  IDC_PANTOOL_HAND_OPEN* = 104
  IDC_PANTOOL_HAND_CLOSED* = 105
  PANE_NONE* = DWORD(-1)
  PANE_ZONE* = 1
  PANE_OFFLINE* = 2
  PANE_PRINTER* = 3
  PANE_SSL* = 4
  PANE_NAVIGATION* = 5
  PANE_PROGRESS* = 6
  PANE_PRIVACY* = 7
  GPFIDL_DEFAULT* = 0x0
  GPFIDL_ALTNAME* = 0x1
  GPFIDL_UNCPRINTER* = 0x2
  OFASI_EDIT* = 0x0001
  OFASI_OPENDESKTOP* = 0x0002
  REGSTR_PATH_SPECIAL_FOLDERS* = REGSTR_PATH_EXPLORER & "\\Shell Folders"
  CSIDL_DESKTOP* = 0x0000
  CSIDL_INTERNET* = 0x0001
  CSIDL_PROGRAMS* = 0x0002
  CSIDL_CONTROLS* = 0x0003
  CSIDL_PRINTERS* = 0x0004
  CSIDL_FAVORITES* = 0x0006
  CSIDL_STARTUP* = 0x0007
  CSIDL_RECENT* = 0x0008
  CSIDL_SENDTO* = 0x0009
  CSIDL_BITBUCKET* = 0x000a
  CSIDL_STARTMENU* = 0x000b
  CSIDL_MYDOCUMENTS* = CSIDL_PERSONAL
  CSIDL_DESKTOPDIRECTORY* = 0x0010
  CSIDL_DRIVES* = 0x0011
  CSIDL_NETWORK* = 0x0012
  CSIDL_NETHOOD* = 0x0013
  CSIDL_FONTS* = 0x0014
  CSIDL_TEMPLATES* = 0x0015
  CSIDL_COMMON_STARTMENU* = 0x0016
  CSIDL_COMMON_PROGRAMS* = 0x0017
  CSIDL_COMMON_STARTUP* = 0x0018
  CSIDL_COMMON_DESKTOPDIRECTORY* = 0x0019
  CSIDL_PRINTHOOD* = 0x001b
  CSIDL_LOCAL_APPDATA* = 0x001c
  CSIDL_ALTSTARTUP* = 0x001d
  CSIDL_COMMON_ALTSTARTUP* = 0x001e
  CSIDL_COMMON_FAVORITES* = 0x001f
  CSIDL_INTERNET_CACHE* = 0x0020
  CSIDL_COOKIES* = 0x0021
  CSIDL_HISTORY* = 0x0022
  CSIDL_COMMON_APPDATA* = 0x0023
  CSIDL_WINDOWS* = 0x0024
  CSIDL_SYSTEM* = 0x0025
  CSIDL_PROGRAM_FILES* = 0x0026
  CSIDL_PROFILE* = 0x0028
  CSIDL_SYSTEMX86* = 0x0029
  CSIDL_PROGRAM_FILESX86* = 0x002a
  CSIDL_PROGRAM_FILES_COMMON* = 0x002b
  CSIDL_PROGRAM_FILES_COMMONX86* = 0x002c
  CSIDL_COMMON_TEMPLATES* = 0x002d
  CSIDL_COMMON_DOCUMENTS* = 0x002e
  CSIDL_COMMON_ADMINTOOLS* = 0x002f
  CSIDL_ADMINTOOLS* = 0x0030
  CSIDL_CONNECTIONS* = 0x0031
  CSIDL_COMMON_MUSIC* = 0x0035
  CSIDL_COMMON_PICTURES* = 0x0036
  CSIDL_COMMON_VIDEO* = 0x0037
  CSIDL_RESOURCES* = 0x0038
  CSIDL_RESOURCES_LOCALIZED* = 0x0039
  CSIDL_COMMON_OEM_LINKS* = 0x003a
  CSIDL_CDBURN_AREA* = 0x003b
  CSIDL_COMPUTERSNEARME* = 0x003d
  CSIDL_FLAG_DONT_UNEXPAND* = 0x2000
  CSIDL_FLAG_NO_ALIAS* = 0x1000
  CSIDL_FLAG_PER_USER_INIT* = 0x0800
  CSIDL_FLAG_MASK* = 0xff00
  KF_FLAG_DEFAULT* = 0x00000000
  KF_FLAG_NO_APPCONTAINER_REDIRECTION* = 0x00010000
  KF_FLAG_CREATE* = 0x00008000
  KF_FLAG_DONT_VERIFY* = 0x00004000
  KF_FLAG_DONT_UNEXPAND* = 0x00002000
  KF_FLAG_NO_ALIAS* = 0x00001000
  KF_FLAG_INIT* = 0x00000800
  KF_FLAG_DEFAULT_PATH* = 0x00000400
  KF_FLAG_NOT_PARENT_RELATIVE* = 0x00000200
  KF_FLAG_SIMPLE_IDLIST* = 0x00000100
  KF_FLAG_ALIAS_ONLY* = 0x80000000'i32
  FCS_READ* = 0x00000001
  FCS_FORCEWRITE* = 0x00000002
  FCS_WRITE* = FCS_READ or FCS_FORCEWRITE
  FCS_FLAG_DRAGDROP* = 2
  FCSM_VIEWID* = 0x00000001
  FCSM_WEBVIEWTEMPLATE* = 0x00000002
  FCSM_INFOTIP* = 0x00000004
  FCSM_CLSID* = 0x00000008
  FCSM_ICONFILE* = 0x00000010
  FCSM_LOGO* = 0x00000020
  FCSM_FLAGS* = 0x00000040
  BIF_RETURNONLYFSDIRS* = 0x00000001
  BIF_DONTGOBELOWDOMAIN* = 0x00000002
  BIF_STATUSTEXT* = 0x00000004
  BIF_RETURNFSANCESTORS* = 0x00000008
  BIF_EDITBOX* = 0x00000010
  BIF_VALIDATE* = 0x00000020
  BIF_NEWDIALOGSTYLE* = 0x00000040
  BIF_USENEWUI* = BIF_NEWDIALOGSTYLE or BIF_EDITBOX
  BIF_BROWSEINCLUDEURLS* = 0x00000080
  BIF_UAHINT* = 0x00000100
  BIF_NONEWFOLDERBUTTON* = 0x00000200
  BIF_NOTRANSLATETARGETS* = 0x00000400
  BIF_BROWSEFORCOMPUTER* = 0x00001000
  BIF_BROWSEFORPRINTER* = 0x00002000
  BIF_BROWSEINCLUDEFILES* = 0x00004000
  BIF_SHAREABLE* = 0x00008000
  BIF_BROWSEFILEJUNCTIONS* = 0x00010000
  BFFM_INITIALIZED* = 1
  BFFM_SELCHANGED* = 2
  BFFM_VALIDATEFAILEDA* = 3
  BFFM_VALIDATEFAILEDW* = 4
  BFFM_IUNKNOWN* = 5
  BFFM_SETSTATUSTEXTA* = WM_USER+100
  BFFM_ENABLEOK* = WM_USER+101
  BFFM_SETSELECTIONA* = WM_USER+102
  BFFM_SETSELECTIONW* = WM_USER+103
  BFFM_SETSTATUSTEXTW* = WM_USER+104
  BFFM_SETOKTEXT* = WM_USER+105
  BFFM_SETEXPANDED* = WM_USER+106
  ISHCUTCMDID_DOWNLOADICON* = 0
  ISHCUTCMDID_INTSHORTCUTCREATE* = 1
  ISHCUTCMDID_COMMITHISTORY* = 2
  ISHCUTCMDID_SETUSERAWURL* = 3
  CMDID_INTSHORTCUTCREATE* = ISHCUTCMDID_INTSHORTCUTCREATE
  STR_PARSE_WITH_PROPERTIES* = "ParseWithProperties"
  STR_PARSE_PARTIAL_IDLIST* = "ParseOriginalItem"
  ACLO_NONE* = 0
  ACLO_CURRENTDIR* = 1
  ACLO_MYCOMPUTER* = 2
  ACLO_DESKTOP* = 4
  ACLO_FAVORITES* = 8
  ACLO_FILESYSONLY* = 16
  ACLO_FILESYSDIRS* = 32
  ACLO_VIRTUALNAMESPACE* = 64
  PROGDLG_NORMAL* = 0x00000000
  PROGDLG_MODAL* = 0x00000001
  PROGDLG_AUTOTIME* = 0x00000002
  PROGDLG_NOTIME* = 0x00000004
  PROGDLG_NOMINIMIZE* = 0x00000008
  PROGDLG_NOPROGRESSBAR* = 0x00000010
  PROGDLG_MARQUEEPROGRESS* = 0x00000020
  PROGDLG_NOCANCEL* = 0x00000040
  PDTIMER_RESET* = 0x00000001
  PDTIMER_PAUSE* = 0x00000002
  PDTIMER_RESUME* = 0x00000003
  DWFRF_NORMAL* = 0x0000
  DWFRF_DELETECONFIGDATA* = 0x0001
  DWFAF_HIDDEN* = 0x1
  DWFAF_GROUP1* = 0x2
  DWFAF_GROUP2* = 0x4
  DWFAF_AUTOHIDE* = 0x10
  IID_IEnumShellImageStore* = DEFINE_GUID("6dfd582b-92e3-11d1-98a3-00c04fb687da")
  SHIMSTCAPFLAG_LOCKABLE* = 0x0001
  SHIMSTCAPFLAG_PURGEABLE* = 0x0002
  ISFB_MASK_STATE* = 0x00000001
  ISFB_MASK_BKCOLOR* = 0x00000002
  ISFB_MASK_VIEWMODE* = 0x00000004
  ISFB_MASK_SHELLFOLDER* = 0x00000008
  ISFB_MASK_IDLIST* = 0x00000010
  ISFB_MASK_COLORS* = 0x00000020
  ISFB_STATE_DEFAULT* = 0x00000000
  ISFB_STATE_DEBOSSED* = 0x00000001
  ISFB_STATE_ALLOWRENAME* = 0x00000002
  ISFB_STATE_NOSHOWTEXT* = 0x00000004
  ISFB_STATE_CHANNELBAR* = 0x00000010
  ISFB_STATE_QLINKSMODE* = 0x00000020
  ISFB_STATE_FULLOPEN* = 0x00000040
  ISFB_STATE_NONAMESORT* = 0x00000080
  ISFB_STATE_BTNMINSIZE* = 0x00000100
  ISFBVIEWMODE_SMALLICONS* = 0x0001
  ISFBVIEWMODE_LARGEICONS* = 0x0002
  ISFBVIEWMODE_LOGOS* = 0x0003
  SFBID_PIDLCHANGED* = 0
  IID_IDeskBarClient* = DEFINE_GUID("eb0fe175-1a3a-11d0-89b3-00a0c90a90ac")
  DBC_GS_IDEAL* = 0
  DBC_GS_SIZEDOWN* = 1
  DBC_HIDE* = 0
  DBC_SHOW* = 1
  DBC_SHOWOBSCURE* = 2
  DBCID_EMPTY* = 0
  DBCID_ONDRAG* = 1
  DBCID_CLSIDOFBAR* = 2
  DBCID_RESIZE* = 3
  DBCID_GETBAR* = 4
  COMPONENT_TOP* = 0x3fffffff
  COMP_TYPE_HTMLDOC* = 0
  COMP_TYPE_PICTURE* = 1
  COMP_TYPE_WEBSITE* = 2
  COMP_TYPE_CONTROL* = 3
  COMP_TYPE_CFHTML* = 4
  COMP_TYPE_MAX* = 4
  IS_NORMAL* = 0x00000001
  IS_FULLSCREEN* = 0x00000002
  IS_SPLIT* = 0x00000004
  IS_VALIDSIZESTATEBITS* = IS_NORMAL or IS_SPLIT or IS_FULLSCREEN
  IS_VALIDSTATEBITS* = IS_NORMAL or IS_SPLIT or IS_FULLSCREEN or 0x80000000'i32 or 0x40000000
  AD_APPLY_SAVE* = 0x00000001
  AD_APPLY_HTMLGEN* = 0x00000002
  AD_APPLY_REFRESH* = 0x00000004
  AD_APPLY_ALL* = AD_APPLY_SAVE or AD_APPLY_HTMLGEN or AD_APPLY_REFRESH
  AD_APPLY_FORCE* = 0x00000008
  AD_APPLY_BUFFERED_REFRESH* = 0x00000010
  AD_APPLY_DYNAMICREFRESH* = 0x00000020
  AD_GETWP_BMP* = 0x00000000
  AD_GETWP_IMAGE* = 0x00000001
  AD_GETWP_LAST_APPLIED* = 0x00000002
  WPSTYLE_CENTER* = 0
  WPSTYLE_TILE* = 1
  WPSTYLE_STRETCH* = 2
  WPSTYLE_KEEPASPECT* = 3
  WPSTYLE_CROPTOFIT* = 4
  WPSTYLE_SPAN* = 5
  WPSTYLE_MAX* = 6
  COMP_ELEM_TYPE* = 0x00000001
  COMP_ELEM_CHECKED* = 0x00000002
  COMP_ELEM_DIRTY* = 0x00000004
  COMP_ELEM_NOSCROLL* = 0x00000008
  COMP_ELEM_POS_LEFT* = 0x00000010
  COMP_ELEM_POS_TOP* = 0x00000020
  COMP_ELEM_SIZE_WIDTH* = 0x00000040
  COMP_ELEM_SIZE_HEIGHT* = 0x00000080
  COMP_ELEM_POS_ZINDEX* = 0x00000100
  COMP_ELEM_SOURCE* = 0x00000200
  COMP_ELEM_FRIENDLYNAME* = 0x00000400
  COMP_ELEM_SUBSCRIBEDURL* = 0x00000800
  COMP_ELEM_ORIGINAL_CSI* = 0x00001000
  COMP_ELEM_RESTORED_CSI* = 0x00002000
  COMP_ELEM_CURITEMSTATE* = 0x00004000
  COMP_ELEM_ALL* = COMP_ELEM_TYPE or COMP_ELEM_CHECKED or COMP_ELEM_DIRTY or COMP_ELEM_NOSCROLL or COMP_ELEM_POS_LEFT or COMP_ELEM_SIZE_WIDTH or COMP_ELEM_SIZE_HEIGHT or COMP_ELEM_POS_ZINDEX or COMP_ELEM_SOURCE or COMP_ELEM_FRIENDLYNAME or COMP_ELEM_POS_TOP or COMP_ELEM_SUBSCRIBEDURL or COMP_ELEM_ORIGINAL_CSI or COMP_ELEM_RESTORED_CSI or COMP_ELEM_CURITEMSTATE
  DTI_ADDUI_DEFAULT* = 0x0
  DTI_ADDUI_DISPSUBWIZARD* = 0x1
  DTI_ADDUI_POSITIONITEM* = 0x2
  ADDURL_SILENT* = 0x1
  COMPONENT_DEFAULT_LEFT* = 0xffff
  COMPONENT_DEFAULT_TOP* = 0xffff
  SSM_CLEAR* = 0x0000
  SSM_SET* = 0x0001
  SSM_REFRESH* = 0x0002
  SSM_UPDATE* = 0x0004
  SCHEME_DISPLAY* = 0x0001
  SCHEME_EDIT* = 0x0002
  SCHEME_LOCAL* = 0x0004
  SCHEME_GLOBAL* = 0x0008
  SCHEME_REFRESH* = 0x0010
  SCHEME_UPDATE* = 0x0020
  SCHEME_DONOTUSE* = 0x0040
  SCHEME_CREATE* = 0x0080
  GADOF_DIRTY* = 0x00000001
  SHCDF_UPDATEITEM* = 0x00000001
  CFSTR_SHELLIDLIST* = "Shell IDList Array"
  CFSTR_SHELLIDLISTOFFSET* = "Shell Object Offsets"
  CFSTR_NETRESOURCES* = "Net Resource"
  CFSTR_FILEDESCRIPTORA* = "FileGroupDescriptor"
  CFSTR_FILEDESCRIPTORW* = "FileGroupDescriptorW"
  CFSTR_FILECONTENTS* = "FileContents"
  CFSTR_FILENAMEA* = "FileName"
  CFSTR_FILENAMEW* = "FileNameW"
  CFSTR_PRINTERGROUP* = "PrinterFriendlyName"
  CFSTR_FILENAMEMAPA* = "FileNameMap"
  CFSTR_FILENAMEMAPW* = "FileNameMapW"
  CFSTR_SHELLURL* = "UniformResourceLocator"
  CFSTR_INETURLA* = CFSTR_SHELLURL
  CFSTR_INETURLW* = "UniformResourceLocatorW"
  CFSTR_PREFERREDDROPEFFECT* = "Preferred DropEffect"
  CFSTR_PERFORMEDDROPEFFECT* = "Performed DropEffect"
  CFSTR_PASTESUCCEEDED* = "Paste Succeeded"
  CFSTR_INDRAGLOOP* = "InShellDragLoop"
  CFSTR_MOUNTEDVOLUME* = "MountedVolume"
  CFSTR_PERSISTEDDATAOBJECT* = "PersistedDataObject"
  CFSTR_TARGETCLSID* = "TargetCLSID"
  CFSTR_LOGICALPERFORMEDDROPEFFECT* = "Logical Performed DropEffect"
  CFSTR_AUTOPLAY_SHELLIDLISTS* = "Autoplay Enumerated IDList Array"
  CFSTR_UNTRUSTEDDRAGDROP* = "UntrustedDragDrop"
  CFSTR_FILE_ATTRIBUTES_ARRAY* = "File Attributes Array"
  CFSTR_INVOKECOMMAND_DROPPARAM* = "InvokeCommand DropParam"
  CFSTR_SHELLDROPHANDLER* = "DropHandlerCLSID"
  CFSTR_DROPDESCRIPTION* = "DropDescription"
  CFSTR_ZONEIDENTIFIER* = "ZoneIdentifier"
  DVASPECT_SHORTNAME* = 2
  DVASPECT_COPY* = 3
  DVASPECT_LINK* = 4
  FD_CLSID* = 0x1
  FD_SIZEPOINT* = 0x2
  FD_ATTRIBUTES* = 0x4
  FD_CREATETIME* = 0x8
  FD_ACCESSTIME* = 0x10
  FD_WRITESTIME* = 0x20
  FD_FILESIZE* = 0x40
  FD_PROGRESSUI* = 0x4000
  FD_LINKUI* = 0x8000
  FD_UNICODE* = int32 0x80000000'i32
  DROPIMAGE_INVALID* = -1
  DROPIMAGE_NONE* = 0
  DROPIMAGE_COPY* = DROPEFFECT_COPY
  DROPIMAGE_MOVE* = DROPEFFECT_MOVE
  DROPIMAGE_LINK* = DROPEFFECT_LINK
  DROPIMAGE_LABEL* = 6
  DROPIMAGE_WARNING* = 7
  DROPIMAGE_NOIMAGE* = 8
  SHCNRF_InterruptLevel* = 0x0001
  SHCNRF_ShellLevel* = 0x0002
  SHCNRF_RecursiveInterrupt* = 0x1000
  SHCNRF_NewDelivery* = 0x8000
  SHCNE_RENAMEITEM* = 0x00000001
  SHCNE_CREATE* = 0x00000002
  SHCNE_DELETE* = 0x00000004
  SHCNE_MKDIR* = 0x00000008
  SHCNE_RMDIR* = 0x00000010
  SHCNE_MEDIAINSERTED* = 0x00000020
  SHCNE_MEDIAREMOVED* = 0x00000040
  SHCNE_DRIVEREMOVED* = 0x00000080
  SHCNE_DRIVEADD* = 0x00000100
  SHCNE_NETSHARE* = 0x00000200
  SHCNE_NETUNSHARE* = 0x00000400
  SHCNE_ATTRIBUTES* = 0x00000800
  SHCNE_UPDATEDIR* = 0x00001000
  SHCNE_UPDATEITEM* = 0x00002000
  SHCNE_SERVERDISCONNECT* = 0x00004000
  SHCNE_UPDATEIMAGE* = 0x00008000
  SHCNE_DRIVEADDGUI* = 0x00010000
  SHCNE_RENAMEFOLDER* = 0x00020000
  SHCNE_FREESPACE* = 0x00040000
  SHCNE_EXTENDED_EVENT* = 0x04000000
  SHCNE_ASSOCCHANGED* = 0x08000000
  SHCNE_DISKEVENTS* = 0x0002381f
  SHCNE_GLOBALEVENTS* = 0x0c0581e0
  SHCNE_ALLEVENTS* = 0x7fffffff
  SHCNE_INTERRUPT* = 0x80000000'i32
  SHCNEE_ORDERCHANGED* = 2
  SHCNEE_MSI_CHANGE* = 4
  SHCNEE_MSI_UNINSTALL* = 5
  SHCNF_IDLIST* = 0x0000
  SHCNF_PATHA* = 0x0001
  SHCNF_PRINTERA* = 0x0002
  SHCNF_DWORD* = 0x0003
  SHCNF_PATHW* = 0x0005
  SHCNF_PRINTERW* = 0x0006
  SHCNF_TYPE* = 0x00ff
  SHCNF_FLUSH* = 0x1000
  SHCNF_FLUSHNOWAIT* = 0x3000
  SHCNF_NOTIFYRECURSIVE* = 0x10000
  QITIPF_DEFAULT* = 0x00000000
  QITIPF_USENAME* = 0x00000001
  QITIPF_LINKNOTARGET* = 0x00000002
  QITIPF_LINKUSETARGET* = 0x00000004
  QITIPF_USESLOWTIP* = 0x00000008
  QITIPF_SINGLELINE* = 0x00000010
  QIF_CACHED* = 0x00000001
  QIF_DONTEXPANDFOLDER* = 0x00000002
  SHARD_PIDL* = 0x00000001
  SHARD_PATHA* = 0x00000002
  SHARD_PATHW* = 0x00000003
  SHARD_APPIDINFO* = 0x00000004
  SHARD_APPIDINFOIDLIST* = 0x00000005
  SHARD_LINK* = 0x00000006
  SHARD_APPIDINFOLINK* = 0x00000007
  SHARD_SHELLITEM* = 0x00000008
  SCNRT_ENABLE* = 0
  SCNRT_DISABLE* = 1
  SHGDFIL_FINDDATA* = 1
  SHGDFIL_NETRESOURCE* = 2
  SHGDFIL_DESCRIPTIONID* = 3
  SHDID_ROOT_REGITEM* = 1
  SHDID_FS_FILE* = 2
  SHDID_FS_DIRECTORY* = 3
  SHDID_FS_OTHER* = 4
  SHDID_COMPUTER_DRIVE35* = 5
  SHDID_COMPUTER_DRIVE525* = 6
  SHDID_COMPUTER_REMOVABLE* = 7
  SHDID_COMPUTER_FIXED* = 8
  SHDID_COMPUTER_NETDRIVE* = 9
  SHDID_COMPUTER_CDROM* = 10
  SHDID_COMPUTER_RAMDISK* = 11
  SHDID_COMPUTER_OTHER* = 12
  SHDID_NET_DOMAIN* = 13
  SHDID_NET_SERVER* = 14
  SHDID_NET_SHARE* = 15
  SHDID_NET_RESTOFNET* = 16
  SHDID_NET_OTHER* = 17
  SHDID_COMPUTER_IMAGING* = 18
  SHDID_COMPUTER_AUDIO* = 19
  SHDID_COMPUTER_SHAREDDOCS* = 20
  SHDID_MOBILE_DEVICE* = 21
  PRF_VERIFYEXISTS* = 0x1
  PRF_TRYPROGRAMEXTENSIONS* = 0x2 or PRF_VERIFYEXISTS
  PRF_FIRSTDIRDEF* = 0x4
  PRF_DONTFINDLNK* = 0x8
  PRF_REQUIREABSOLUTE* = 0x10
  NUM_POINTS* = 3
  CABINETSTATE_VERSION* = 2
  PCS_FATAL* = 0x80000000'i32
  PCS_REPLACEDCHAR* = 0x00000001
  PCS_REMOVEDCHAR* = 0x00000002
  PCS_TRUNCATED* = 0x00000004
  PCS_PATHTOOLONG* = 0x00000008
  MM_ADDSEPARATOR* = 0x00000001
  MM_SUBMENUSHAVEIDS* = 0x00000002
  MM_DONTREMOVESEPS* = 0x00000004
  SHOP_PRINTERNAME* = 0x00000001
  SHOP_FILEPATH* = 0x00000002
  SHOP_VOLUMEGUID* = 0x00000004
  SHFMT_ID_DEFAULT* = 0xffff
  SHFMT_OPT_FULL* = 0x0001
  SHFMT_OPT_SYSONLY* = 0x0002
  SHFMT_ERROR* = 0xffffffff'i32
  SHFMT_CANCEL* = 0xfffffffe'i32
  SHFMT_NOFORMAT* = 0xfffffffd'i32
  REST_NONE* = 0x00000000
  REST_NORUN* = 0x00000001
  REST_NOCLOSE* = 0x00000002
  REST_NOSAVESET* = 0x00000004
  REST_NOFILEMENU* = 0x00000008
  REST_NOSETFOLDERS* = 0x00000010
  REST_NOSETTASKBAR* = 0x00000020
  REST_NODESKTOP* = 0x00000040
  REST_NOFIND* = 0x00000080
  REST_NODRIVES* = 0x00000100
  REST_NODRIVEAUTORUN* = 0x00000200
  REST_NODRIVETYPEAUTORUN* = 0x00000400
  REST_NONETHOOD* = 0x00000800
  REST_STARTBANNER* = 0x00001000
  REST_RESTRICTRUN* = 0x00002000
  REST_NOPRINTERTABS* = 0x00004000
  REST_NOPRINTERDELETE* = 0x00008000
  REST_NOPRINTERADD* = 0x00010000
  REST_NOSTARTMENUSUBFOLDERS* = 0x00020000
  REST_MYDOCSONNET* = 0x00040000
  REST_NOEXITTODOS* = 0x00080000
  REST_ENFORCESHELLEXTSECURITY* = 0x00100000
  REST_LINKRESOLVEIGNORELINKINFO* = 0x00200000
  REST_NOCOMMONGROUPS* = 0x00400000
  REST_SEPARATEDESKTOPPROCESS* = 0x00800000
  REST_NOWEB* = 0x01000000
  REST_NOTRAYCONTEXTMENU* = 0x02000000
  REST_NOVIEWCONTEXTMENU* = 0x04000000
  REST_NONETCONNECTDISCONNECT* = 0x08000000
  REST_STARTMENULOGOFF* = 0x10000000
  REST_NOSETTINGSASSIST* = 0x20000000
  REST_NOINTERNETICON* = 0x40000001
  REST_NORECENTDOCSHISTORY* = 0x40000002
  REST_NORECENTDOCSMENU* = 0x40000003
  REST_NOACTIVEDESKTOP* = 0x40000004
  REST_NOACTIVEDESKTOPCHANGES* = 0x40000005
  REST_NOFAVORITESMENU* = 0x40000006
  REST_CLEARRECENTDOCSONEXIT* = 0x40000007
  REST_CLASSICSHELL* = 0x40000008
  REST_NOCUSTOMIZEWEBVIEW* = 0x40000009
  REST_NOHTMLWALLPAPER* = 0x40000010
  REST_NOCHANGINGWALLPAPER* = 0x40000011
  REST_NODESKCOMP* = 0x40000012
  REST_NOADDDESKCOMP* = 0x40000013
  REST_NODELDESKCOMP* = 0x40000014
  REST_NOCLOSEDESKCOMP* = 0x40000015
  REST_NOCLOSE_DRAGDROPBAND* = 0x40000016
  REST_NOMOVINGBAND* = 0x40000017
  REST_NOEDITDESKCOMP* = 0x40000018
  REST_NORESOLVESEARCH* = 0x40000019
  REST_NORESOLVETRACK* = 0x4000001a
  REST_FORCECOPYACLWITHFILE* = 0x4000001b
  REST_NOLOGO3CHANNELNOTIFY* = 0x4000001c
  REST_NOFORGETSOFTWAREUPDATE* = 0x4000001d
  REST_NOSETACTIVEDESKTOP* = 0x4000001e
  REST_NOUPDATEWINDOWS* = 0x4000001f
  REST_NOCHANGESTARMENU* = 0x40000020
  REST_NOFOLDEROPTIONS* = 0x40000021
  REST_HASFINDCOMPUTERS* = 0x40000022
  REST_INTELLIMENUS* = 0x40000023
  REST_RUNDLGMEMCHECKBOX* = 0x40000024
  REST_ARP_ShowPostSetup* = 0x40000025
  REST_NOCSC* = 0x40000026
  REST_NOCONTROLPANEL* = 0x40000027
  REST_ENUMWORKGROUP* = 0x40000028
  REST_ARP_NOARP* = 0x40000029
  REST_ARP_NOREMOVEPAGE* = 0x4000002a
  REST_ARP_NOADDPAGE* = 0x4000002b
  REST_ARP_NOWINSETUPPAGE* = 0x4000002c
  REST_GREYMSIADS* = 0x4000002d
  REST_NOCHANGEMAPPEDDRIVELABEL* = 0x4000002e
  REST_NOCHANGEMAPPEDDRIVECOMMENT* = 0x4000002f
  REST_MaxRecentDocs* = 0x40000030
  REST_NONETWORKCONNECTIONS* = 0x40000031
  REST_FORCESTARTMENULOGOFF* = 0x40000032
  REST_NOWEBVIEW* = 0x40000033
  REST_NOCUSTOMIZETHISFOLDER* = 0x40000034
  REST_NOENCRYPTION* = 0x40000035
  REST_DONTSHOWSUPERHIDDEN* = 0x40000037
  REST_NOSHELLSEARCHBUTTON* = 0x40000038
  REST_NOHARDWARETAB* = 0x40000039
  REST_NORUNASINSTALLPROMPT* = 0x4000003a
  REST_PROMPTRUNASINSTALLNETPATH* = 0x4000003b
  REST_NOMANAGEMYCOMPUTERVERB* = 0x4000003c
  REST_DISALLOWRUN* = 0x4000003e
  REST_NOWELCOMESCREEN* = 0x4000003f
  REST_RESTRICTCPL* = 0x40000040
  REST_DISALLOWCPL* = 0x40000041
  REST_NOSMBALLOONTIP* = 0x40000042
  REST_NOSMHELP* = 0x40000043
  REST_NOWINKEYS* = 0x40000044
  REST_NOENCRYPTONMOVE* = 0x40000045
  REST_NOLOCALMACHINERUN* = 0x40000046
  REST_NOCURRENTUSERRUN* = 0x40000047
  REST_NOLOCALMACHINERUNONCE* = 0x40000048
  REST_NOCURRENTUSERRUNONCE* = 0x40000049
  REST_FORCEACTIVEDESKTOPON* = 0x4000004a
  REST_NOVIEWONDRIVE* = 0x4000004c
  REST_NONETCRAWL* = 0x4000004d
  REST_NOSHAREDDOCUMENTS* = 0x4000004e
  REST_NOSMMYDOCS* = 0x4000004f
  REST_NOSMMYPICS* = 0x40000050
  REST_ALLOWBITBUCKDRIVES* = 0x40000051
  REST_NONLEGACYSHELLMODE* = 0x40000052
  REST_NOCONTROLPANELBARRICADE* = 0x40000053
  REST_NOSTARTPAGE* = 0x40000054
  REST_NOAUTOTRAYNOTIFY* = 0x40000055
  REST_NOTASKGROUPING* = 0x40000056
  REST_NOCDBURNING* = 0x40000057
  REST_MYCOMPNOPROP* = 0x40000058
  REST_MYDOCSNOPROP* = 0x40000059
  REST_NOSTARTPANEL* = 0x4000005a
  REST_NODISPLAYAPPEARANCEPAGE* = 0x4000005b
  REST_NOTHEMESTAB* = 0x4000005c
  REST_NOVISUALSTYLECHOICE* = 0x4000005d
  REST_NOSIZECHOICE* = 0x4000005e
  REST_NOCOLORCHOICE* = 0x4000005f
  REST_SETVISUALSTYLE* = 0x40000060
  REST_STARTRUNNOHOMEPATH* = 0x40000061
  REST_NOUSERNAMEINSTARTPANEL* = 0x40000062
  REST_NOMYCOMPUTERICON* = 0x40000063
  REST_NOSMNETWORKPLACES* = 0x40000064
  REST_NOSMPINNEDLIST* = 0x40000065
  REST_NOSMMYMUSIC* = 0x40000066
  REST_NOSMEJECTPC* = 0x40000067
  REST_NOSMMOREPROGRAMS* = 0x40000068
  REST_NOSMMFUPROGRAMS* = 0x40000069
  REST_NOTRAYITEMSDISPLAY* = 0x4000006a
  REST_NOTOOLBARSONTASKBAR* = 0x4000006b
  REST_NOSMCONFIGUREPROGRAMS* = 0x4000006f
  REST_HIDECLOCK* = 0x40000070
  REST_NOLOWDISKSPACECHECKS* = 0x40000071
  REST_NOENTIRENETWORK* = 0x40000072
  REST_NODESKTOPCLEANUP* = 0x40000073
  REST_BITBUCKNUKEONDELETE* = 0x40000074
  REST_BITBUCKCONFIRMDELETE* = 0x40000075
  REST_BITBUCKNOPROP* = 0x40000076
  REST_NODISPBACKGROUND* = 0x40000077
  REST_NODISPSCREENSAVEPG* = 0x40000078
  REST_NODISPSETTINGSPG* = 0x40000079
  REST_NODISPSCREENSAVEPREVIEW* = 0x4000007a
  REST_NODISPLAYCPL* = 0x4000007b
  REST_HIDERUNASVERB* = 0x4000007c
  REST_NOTHUMBNAILCACHE* = 0x4000007d
  REST_NOSTRCMPLOGICAL* = 0x4000007e
  REST_NOPUBLISHWIZARD* = 0x4000007f
  REST_NOONLINEPRINTSWIZARD* = 0x40000080
  REST_NOWEBSERVICES* = 0x40000081
  REST_ALLOWUNHASHEDWEBVIEW* = 0x40000082
  REST_ALLOWLEGACYWEBVIEW* = 0x40000083
  REST_REVERTWEBVIEWSECURITY* = 0x40000084
  REST_INHERITCONSOLEHANDLES* = 0x40000086
  REST_SORTMAXITEMCOUNT* = 0x40000087
  REST_NOREMOTERECURSIVEEVENTS* = 0x40000089
  REST_NOREMOTECHANGENOTIFY* = 0x40000091
  REST_NOSIMPLENETIDLIST* = 0x40000092
  REST_NOENUMENTIRENETWORK* = 0x40000093
  REST_NODETAILSTHUMBNAILONNETWORK* = 0x40000094
  REST_NOINTERNETOPENWITH* = 0x40000095
  REST_DONTRETRYBADNETNAME* = 0x4000009b
  REST_ALLOWFILECLSIDJUNCTIONS* = 0x4000009c
  REST_NOUPNPINSTALL* = 0x4000009d
  REST_ARP_DONTGROUPPATCHES* = 0x400000ac
  REST_ARP_NOCHOOSEPROGRAMSPAGE* = 0x400000ad
  REST_NODISCONNECT* = 0x41000001
  REST_NOSECURITY* = 0x41000002
  REST_NOFILEASSOCIATE* = 0x41000003
  REST_ALLOWCOMMENTTOGGLE* = 0x41000004
  REST_USEDESKTOPINICACHE* = 0x41000005
  PPCF_ADDQUOTES* = 0x00000001
  PPCF_ADDARGUMENTS* = 0x00000003
  PPCF_NODIRECTORIES* = 0x00000010
  PPCF_FORCEQUALIFY* = 0x00000040
  PPCF_LONGESTPOSSIBLE* = 0x00000080
  OAIF_ALLOW_REGISTRATION* = 0x1
  OAIF_REGISTER_EXT* = 0x2
  OAIF_EXEC* = 0x4
  OAIF_FORCE_REGISTRATION* = 0x8
  OAIF_HIDE_REGISTRATION* = 0x20
  OAIF_URL_PROTOCOL* = 0x40
  OAIF_FILE_IS_URI* = 0x80
  VALIDATEUNC_CONNECT* = 0x0001
  VALIDATEUNC_NOUI* = 0x0002
  VALIDATEUNC_PRINT* = 0x0004
  VALIDATEUNC_PERSIST* = 0x0008
  VALIDATEUNC_VALID* = 0x000f
  OPENPROPS_NONE* = 0x0000
  OPENPROPS_INHIBITPIF* = 0x8000
  GETPROPS_NONE* = 0x0000
  SETPROPS_NONE* = 0x0000
  CLOSEPROPS_NONE* = 0x0000
  CLOSEPROPS_DISCARD* = 0x0001
  PIFSHPROGSIZE* = 64
  PIFSHDATASIZE* = 64
  IID_IInitializeObject* = DEFINE_GUID("4622ad16-ff23-11d0-8d34-00a0c90f2719")
  BMICON_LARGE* = 0
  BMICON_SMALL* = 1
  QCMINFO_PLACE_BEFORE* = 0
  QCMINFO_PLACE_AFTER* = 1
  TBIF_APPEND* = 0
  TBIF_PREPEND* = 1
  TBIF_REPLACE* = 2
  TBIF_DEFAULT* = 0x00000000
  TBIF_INTERNETBAR* = 0x00010000
  TBIF_STANDARDTOOLBAR* = 0x00020000
  TBIF_NOTOOLBAR* = 0x00030000
  SFVM_MERGEMENU* = 1
  SFVM_INVOKECOMMAND* = 2
  SFVM_GETHELPTEXT* = 3
  SFVM_GETTOOLTIPTEXT* = 4
  SFVM_GETBUTTONINFO* = 5
  SFVM_GETBUTTONS* = 6
  SFVM_INITMENUPOPUP* = 7
  SFVM_FSNOTIFY* = 14
  SFVM_WINDOWCREATED* = 15
  SFVM_GETDETAILSOF* = 23
  SFVM_COLUMNCLICK* = 24
  SFVM_QUERYFSNOTIFY* = 25
  SFVM_DEFITEMCOUNT* = 26
  SFVM_DEFVIEWMODE* = 27
  SFVM_UNMERGEMENU* = 28
  SFVM_UPDATESTATUSBAR* = 31
  SFVM_BACKGROUNDENUM* = 32
  SFVM_DIDDRAGDROP* = 36
  SFVM_SETISFV* = 39
  SFVM_THISIDLIST* = 41
  SFVM_ADDPROPERTYPAGES* = 47
  SFVM_BACKGROUNDENUMDONE* = 48
  SFVM_GETNOTIFY* = 49
  SFVM_GETSORTDEFAULTS* = 53
  SFVM_SIZE* = 57
  SFVM_GETZONE* = 58
  SFVM_GETPANE* = 59
  SFVM_GETHELPTOPIC* = 63
  SFVM_GETANIMATION* = 68
  SFVSOC_INVALIDATE_ALL* = 0x00000001
  SFVSOC_NOSCROLL* = LVSICF_NOSCROLL
  SFVS_SELECT_NONE* = 0x0
  SFVS_SELECT_ALLITEMS* = 0x1
  SFVS_SELECT_INVERT* = 0x2
  IID_IShellFolderView* = DEFINE_GUID("37a378c0-f82d-11ce-ae65-08002b2e1262")
  DFM_MERGECONTEXTMENU* = 1
  DFM_INVOKECOMMAND* = 2
  DFM_GETHELPTEXT* = 5
  DFM_WM_MEASUREITEM* = 6
  DFM_WM_DRAWITEM* = 7
  DFM_WM_INITMENUPOPUP* = 8
  DFM_VALIDATECMD* = 9
  DFM_MERGECONTEXTMENU_TOP* = 10
  DFM_GETHELPTEXTW* = 11
  DFM_INVOKECOMMANDEX* = 12
  DFM_MAPCOMMANDNAME* = 13
  DFM_GETDEFSTATICID* = 14
  DFM_GETVERBW* = 15
  DFM_GETVERBA* = 16
  DFM_MERGECONTEXTMENU_BOTTOM* = 17
  DFM_MODIFYQCMFLAGS* = 18
  DFM_CMD_DELETE* = UINT(-1)
  DFM_CMD_MOVE* = UINT(-2)
  DFM_CMD_COPY* = UINT(-3)
  DFM_CMD_LINK* = UINT(-4)
  DFM_CMD_PROPERTIES* = UINT(-5)
  DFM_CMD_NEWFOLDER* = UINT(-6)
  DFM_CMD_PASTE* = UINT(-7)
  DFM_CMD_VIEWLIST* = UINT(-8)
  DFM_CMD_VIEWDETAILS* = UINT(-9)
  DFM_CMD_PASTELINK* = UINT(-10)
  DFM_CMD_PASTESPECIAL* = UINT(-11)
  DFM_CMD_MODALPROP* = UINT(-12)
  DFM_CMD_RENAME* = UINT(-13)
  SFVM_REARRANGE* = 0x00000001
  SFVM_ADDOBJECT* = 0x00000003
  SFVM_REMOVEOBJECT* = 0x00000006
  SFVM_UPDATEOBJECT* = 0x00000007
  SFVM_GETSELECTEDOBJECTS* = 0x00000009
  SFVM_SETITEMPOS* = 0x0000000e
  SFVM_SETCLIPBOARD* = 0x00000010
  SFVM_SETPOINTS* = 0x00000017
  PID_IS_URL* = 2
  PID_IS_NAME* = 4
  PID_IS_WORKINGDIR* = 5
  PID_IS_HOTKEY* = 6
  PID_IS_SHOWCMD* = 7
  PID_IS_ICONINDEX* = 8
  PID_IS_ICONFILE* = 9
  PID_IS_WHATSNEW* = 10
  PID_IS_AUTHOR* = 11
  PID_IS_DESCRIPTION* = 12
  PID_IS_COMMENT* = 13
  PID_IS_ROAMED* = 15
  PID_INTSITE_WHATSNEW* = 2
  PID_INTSITE_AUTHOR* = 3
  PID_INTSITE_LASTVISIT* = 4
  PID_INTSITE_LASTMOD* = 5
  PID_INTSITE_VISITCOUNT* = 6
  PID_INTSITE_DESCRIPTION* = 7
  PID_INTSITE_COMMENT* = 8
  PID_INTSITE_FLAGS* = 9
  PID_INTSITE_CONTENTLEN* = 10
  PID_INTSITE_CONTENTCODE* = 11
  PID_INTSITE_RECURSE* = 12
  PID_INTSITE_WATCH* = 13
  PID_INTSITE_SUBSCRIPTION* = 14
  PID_INTSITE_URL* = 15
  PID_INTSITE_TITLE* = 16
  PID_INTSITE_CODEPAGE* = 18
  PID_INTSITE_TRACKING* = 19
  PID_INTSITE_ICONINDEX* = 20
  PID_INTSITE_ICONFILE* = 21
  PID_INTSITE_ROAMED* = 34
  PIDISF_RECENTLYCHANGED* = 0x00000001
  PIDISF_CACHEDSTICKY* = 0x00000002
  PIDISF_CACHEIMAGES* = 0x00000010
  PIDISF_FOLLOWALLLINKS* = 0x00000020
  PIDISM_GLOBAL* = 0
  PIDISM_WATCH* = 1
  PIDISM_DONTWATCH* = 2
  PIDISR_UP_TO_DATE* = 0
  PIDISR_NEEDS_ADD* = 1
  PIDISR_NEEDS_UPDATE* = 2
  PIDISR_NEEDS_DELETE* = 3
  SHELLSTATEVERSION_IE4* = 9
  SHELLSTATEVERSION_WIN2K* = 10
when winimUnicode:
  type
    SHELLSTATE* = SHELLSTATEW
when winimAnsi:
  type
    SHELLSTATE* = SHELLSTATEA
const
  SSF_SHOWALLOBJECTS* = 0x00000001
  SSF_SHOWEXTENSIONS* = 0x00000002
  SSF_HIDDENFILEEXTS* = 0x00000004
  SSF_SERVERADMINUI* = 0x00000004
  SSF_SHOWCOMPCOLOR* = 0x00000008
  SSF_SORTCOLUMNS* = 0x00000010
  SSF_SHOWSYSFILES* = 0x00000020
  SSF_DOUBLECLICKINWEBVIEW* = 0x00000080
  SSF_SHOWATTRIBCOL* = 0x00000100
  SSF_DESKTOPHTML* = 0x00000200
  SSF_WIN95CLASSIC* = 0x00000400
  SSF_DONTPRETTYPATH* = 0x00000800
  SSF_SHOWINFOTIP* = 0x00002000
  SSF_MAPNETDRVBUTTON* = 0x00001000
  SSF_NOCONFIRMRECYCLE* = 0x00008000
  SSF_HIDEICONS* = 0x00004000
  SSF_FILTER* = 0x00010000
  SSF_WEBVIEW* = 0x00020000
  SSF_SHOWSUPERHIDDEN* = 0x00040000
  SSF_SEPPROCESS* = 0x00080000
  SSF_NONETCRAWLING* = 0x00100000
  SSF_STARTPANELON* = 0x00200000
  SSF_SHOWSTARTPAGE* = 0x00400000
  SSF_AUTOCHECKSELECT* = 0x00800000
  SSF_ICONSONLY* = 0x01000000
  SSF_SHOWTYPEOVERLAY* = 0x02000000
  SSF_SHOWSTATUSBAR* = 0x04000000
  SHPPFW_NONE* = 0x00000000
  SHPPFW_DIRCREATE* = 0x00000001
  SHPPFW_DEFAULT* = SHPPFW_DIRCREATE
  SHPPFW_ASKDIRCREATE* = 0x00000002
  SHPPFW_IGNOREFILENAME* = 0x00000004
  SHPPFW_NOWRITECHECK* = 0x00000008
  SHPPFW_MEDIACHECKONLY* = 0x00000010
  IESHORTCUT_NEWBROWSER* = 0x01
  IESHORTCUT_OPENNEWTAB* = 0x02
  IESHORTCUT_FORCENAVIGATE* = 0x04
  IESHORTCUT_BACKGROUNDTAB* = 0x08
  CMIC_MASK_HASLINKNAME* = 0x00010000
  CMIC_MASK_FLAG_SEP_VDM* = 0x00040000
  CMIC_MASK_HASTITLE* = 0x00020000
  SHELLSTATE_SIZE_WIN2K* = 32
  ITSAT_DEFAULT_LPARAM* = not DWORD_PTR(0)
type
  PFNCANSHAREFOLDERW* = proc (pszPath: PCWSTR): HRESULT {.stdcall.}
  PFNSHOWSHAREFOLDERUIW* = proc (hwndParent: HWND, pszPath: PCWSTR): HRESULT {.stdcall.}
  DLLVERSIONINFO* {.pure.} = object
    cbSize*: DWORD
    dwMajorVersion*: DWORD
    dwMinorVersion*: DWORD
    dwBuildNumber*: DWORD
    dwPlatformID*: DWORD
  DLLGETVERSIONPROC* = proc (P1: ptr DLLVERSIONINFO): HRESULT {.stdcall.}
  LPFNDFMCALLBACK* = proc (psf: ptr IShellFolder, hwnd: HWND, pdtobj: ptr IDataObject, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
  ASSOCIATIONELEMENT* {.pure.} = object
    ac*: ASSOCCLASS
    hkClass*: HKEY
    pszClass*: PCWSTR
  SHFILEINFOA* {.pure.} = object
    hIcon*: HICON
    iIcon*: int32
    dwAttributes*: DWORD
    szDisplayName*: array[MAX_PATH, CHAR]
    szTypeName*: array[80, CHAR]
  SHFILEINFOW* {.pure.} = object
    hIcon*: HICON
    iIcon*: int32
    dwAttributes*: DWORD
    szDisplayName*: array[MAX_PATH, WCHAR]
    szTypeName*: array[80, WCHAR]
  SHSTOCKICONINFO* {.pure.} = object
    cbSize*: DWORD
    hIcon*: HICON
    iSysImageIndex*: int32
    iIcon*: int32
    szPath*: array[MAX_PATH, WCHAR]
  DLLVERSIONINFO2* {.pure.} = object
    info1*: DLLVERSIONINFO
    dwFlags*: DWORD
    ullVersion*: ULONGLONG
  PERSIST_FOLDER_TARGET_INFO* {.pure.} = object
    pidlTargetFolder*: PIDLIST_ABSOLUTE
    szTargetParsingName*: array[260, WCHAR]
    szNetworkProvider*: array[260, WCHAR]
    dwAttributes*: DWORD
    csidl*: int32
  SORTCOLUMN* {.pure.} = object
    propkey*: PROPERTYKEY
    direction*: SORTDIRECTION
  CM_COLUMNINFO* {.pure.} = object
    cbSize*: DWORD
    dwMask*: DWORD
    dwState*: DWORD
    uWidth*: UINT
    uDefaultWidth*: UINT
    uIdealWidth*: UINT
    wszName*: array[80, WCHAR]
  SHELL_ITEM_RESOURCE* {.pure.} = object
    guidType*: GUID
    szName*: array[260, WCHAR]
  TCATEGORY_INFO* {.pure.} = object
    cif*: CATEGORYINFO_FLAGS
    wszName*: array[260, WCHAR]
  DESKBANDINFO* {.pure.} = object
    dwMask*: DWORD
    ptMinSize*: POINTL
    ptMaxSize*: POINTL
    ptIntegral*: POINTL
    ptActual*: POINTL
    wszTitle*: array[256, WCHAR]
    dwModeFlags*: DWORD
    crBkgnd*: COLORREF
  BANDSITEINFO* {.pure.} = object
    dwMask*: DWORD
    dwState*: DWORD
    dwStyle*: DWORD
  KNOWNFOLDER_DEFINITION* {.pure.} = object
    category*: KF_CATEGORY
    pszName*: LPWSTR
    pszDescription*: LPWSTR
    fidParent*: KNOWNFOLDERID
    pszRelativePath*: LPWSTR
    pszParsingName*: LPWSTR
    pszTooltip*: LPWSTR
    pszLocalizedName*: LPWSTR
    pszIcon*: LPWSTR
    pszSecurity*: LPWSTR
    dwAttributes*: DWORD
    kfdFlags*: KF_DEFINITION_FLAGS
    ftidType*: FOLDERTYPEID
  IShellItem* {.pure.} = object
    lpVtbl*: ptr IShellItemVtbl
  IShellItemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    BindToHandler*: proc(self: ptr IShellItem, pbc: ptr IBindCtx, bhid: REFGUID, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetParent*: proc(self: ptr IShellItem, ppsi: ptr ptr IShellItem): HRESULT {.stdcall.}
    GetDisplayName*: proc(self: ptr IShellItem, sigdnName: SIGDN, ppszName: ptr LPWSTR): HRESULT {.stdcall.}
    GetAttributes*: proc(self: ptr IShellItem, sfgaoMask: SFGAOF, psfgaoAttribs: ptr SFGAOF): HRESULT {.stdcall.}
    Compare*: proc(self: ptr IShellItem, psi: ptr IShellItem, hint: SICHINTF, piOrder: ptr int32): HRESULT {.stdcall.}
  NSTCCUSTOMDRAW* {.pure.} = object
    psi*: ptr IShellItem
    uItemState*: UINT
    nstcis*: NSTCITEMSTATE
    pszText*: LPCWSTR
    iImage*: int32
    himl*: HIMAGELIST
    iLevel*: int32
    iIndent*: int32
  PREVIEWHANDLERFRAMEINFO* {.pure.} = object
    haccel*: HACCEL
    cAccelEntries*: UINT
  EXP_PROPERTYSTORAGE* {.pure, packed.} = object
    cbSize*: DWORD
    dwSignature*: DWORD
    abPropertyStorage*: array[1, BYTE]
  FILE_ATTRIBUTES_ARRAY* {.pure.} = object
    cItems*: UINT
    dwSumFileAttributes*: DWORD
    dwProductFileAttributes*: DWORD
    rgdwFileAttributes*: array[1, DWORD]
  DROPDESCRIPTION* {.pure.} = object
    `type`*: DROPIMAGETYPE
    szMessage*: array[MAX_PATH, WCHAR]
    szInsert*: array[MAX_PATH, WCHAR]
  SHChangeNotifyEntry* {.pure, packed.} = object
    pidl*: PCIDLIST_ABSOLUTE
    fRecursive*: WINBOOL
  TSHARDAPPIDINFO* {.pure.} = object
    psi*: ptr IShellItem
    pszAppID*: PCWSTR
  TSHARD_APPIDINFOIDLIST* {.pure.} = object
    pidl*: PCIDLIST_ABSOLUTE
    pszAppID*: PCWSTR
  IShellLinkW* {.pure.} = object
    lpVtbl*: ptr IShellLinkWVtbl
  IShellLinkWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPath*: proc(self: ptr IShellLinkW, pszFile: LPWSTR, cch: int32, pfd: ptr WIN32_FIND_DATAW, fFlags: DWORD): HRESULT {.stdcall.}
    GetIDList*: proc(self: ptr IShellLinkW, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    SetIDList*: proc(self: ptr IShellLinkW, pidl: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    GetDescription*: proc(self: ptr IShellLinkW, pszName: LPWSTR, cch: int32): HRESULT {.stdcall.}
    SetDescription*: proc(self: ptr IShellLinkW, pszName: LPCWSTR): HRESULT {.stdcall.}
    GetWorkingDirectory*: proc(self: ptr IShellLinkW, pszDir: LPWSTR, cch: int32): HRESULT {.stdcall.}
    SetWorkingDirectory*: proc(self: ptr IShellLinkW, pszDir: LPCWSTR): HRESULT {.stdcall.}
    GetArguments*: proc(self: ptr IShellLinkW, pszArgs: LPWSTR, cch: int32): HRESULT {.stdcall.}
    SetArguments*: proc(self: ptr IShellLinkW, pszArgs: LPCWSTR): HRESULT {.stdcall.}
    GetHotkey*: proc(self: ptr IShellLinkW, pwHotkey: ptr WORD): HRESULT {.stdcall.}
    SetHotkey*: proc(self: ptr IShellLinkW, wHotkey: WORD): HRESULT {.stdcall.}
    GetShowCmd*: proc(self: ptr IShellLinkW, piShowCmd: ptr int32): HRESULT {.stdcall.}
    SetShowCmd*: proc(self: ptr IShellLinkW, iShowCmd: int32): HRESULT {.stdcall.}
    GetIconLocation*: proc(self: ptr IShellLinkW, pszIconPath: LPWSTR, cch: int32, piIcon: ptr int32): HRESULT {.stdcall.}
    SetIconLocation*: proc(self: ptr IShellLinkW, pszIconPath: LPCWSTR, iIcon: int32): HRESULT {.stdcall.}
    SetRelativePath*: proc(self: ptr IShellLinkW, pszPathRel: LPCWSTR, dwReserved: DWORD): HRESULT {.stdcall.}
    Resolve*: proc(self: ptr IShellLinkW, hwnd: HWND, fFlags: DWORD): HRESULT {.stdcall.}
    SetPath*: proc(self: ptr IShellLinkW, pszFile: LPCWSTR): HRESULT {.stdcall.}
when winimUnicode:
  type
    IShellLink* = IShellLinkW
type
  IShellLinkA* {.pure.} = object
    lpVtbl*: ptr IShellLinkAVtbl
  IShellLinkAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPath*: proc(self: ptr IShellLinkA, pszFile: LPSTR, cch: int32, pfd: ptr WIN32_FIND_DATAA, fFlags: DWORD): HRESULT {.stdcall.}
    GetIDList*: proc(self: ptr IShellLinkA, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    SetIDList*: proc(self: ptr IShellLinkA, pidl: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    GetDescription*: proc(self: ptr IShellLinkA, pszName: LPSTR, cch: int32): HRESULT {.stdcall.}
    SetDescription*: proc(self: ptr IShellLinkA, pszName: LPCSTR): HRESULT {.stdcall.}
    GetWorkingDirectory*: proc(self: ptr IShellLinkA, pszDir: LPSTR, cch: int32): HRESULT {.stdcall.}
    SetWorkingDirectory*: proc(self: ptr IShellLinkA, pszDir: LPCSTR): HRESULT {.stdcall.}
    GetArguments*: proc(self: ptr IShellLinkA, pszArgs: LPSTR, cch: int32): HRESULT {.stdcall.}
    SetArguments*: proc(self: ptr IShellLinkA, pszArgs: LPCSTR): HRESULT {.stdcall.}
    GetHotkey*: proc(self: ptr IShellLinkA, pwHotkey: ptr WORD): HRESULT {.stdcall.}
    SetHotkey*: proc(self: ptr IShellLinkA, wHotkey: WORD): HRESULT {.stdcall.}
    GetShowCmd*: proc(self: ptr IShellLinkA, piShowCmd: ptr int32): HRESULT {.stdcall.}
    SetShowCmd*: proc(self: ptr IShellLinkA, iShowCmd: int32): HRESULT {.stdcall.}
    GetIconLocation*: proc(self: ptr IShellLinkA, pszIconPath: LPSTR, cch: int32, piIcon: ptr int32): HRESULT {.stdcall.}
    SetIconLocation*: proc(self: ptr IShellLinkA, pszIconPath: LPCSTR, iIcon: int32): HRESULT {.stdcall.}
    SetRelativePath*: proc(self: ptr IShellLinkA, pszPathRel: LPCSTR, dwReserved: DWORD): HRESULT {.stdcall.}
    Resolve*: proc(self: ptr IShellLinkA, hwnd: HWND, fFlags: DWORD): HRESULT {.stdcall.}
    SetPath*: proc(self: ptr IShellLinkA, pszFile: LPCSTR): HRESULT {.stdcall.}
when winimAnsi:
  type
    IShellLink* = IShellLinkA
type
  TSHARDAPPIDINFOLINK* {.pure.} = object
    psl*: ptr IShellLink
    pszAppID*: PCWSTR
  AUTO_SCROLL_DATA* {.pure.} = object
    iNextSample*: int32
    dwLastScroll*: DWORD
    bFull*: WINBOOL
    pts*: array[NUM_POINTS, POINT]
    dwTimes*: array[NUM_POINTS, DWORD]
  SFVM_PROPPAGE_DATA* {.pure.} = object
    dwReserved*: DWORD
    pfn*: LPFNADDPROPSHEETPAGE
    lParam*: LPARAM
  SFVM_HELPTOPIC_DATA* {.pure.} = object
    wszHelpFile*: array[MAX_PATH, WCHAR]
    wszHelpTopic*: array[MAX_PATH, WCHAR]
  ITEMSPACING* {.pure.} = object
    cxSmall*: int32
    cySmall*: int32
    cxLarge*: int32
    cyLarge*: int32
  IShellFolderViewCB* {.pure.} = object
    lpVtbl*: ptr IShellFolderViewCBVtbl
  IShellFolderViewCBVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    MessageSFVCB*: proc(self: ptr IShellFolderViewCB, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
  SFV_CREATE* {.pure.} = object
    cbSize*: UINT
    pshf*: ptr IShellFolder
    psvOuter*: ptr IShellView
    psfvcb*: ptr IShellFolderViewCB
  IContextMenuCB* {.pure.} = object
    lpVtbl*: ptr IContextMenuCBVtbl
  IContextMenuCBVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CallBack*: proc(self: ptr IContextMenuCB, psf: ptr IShellFolder, hwndOwner: HWND, pdtobj: ptr IDataObject, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
  DEFCONTEXTMENU* {.pure.} = object
    hwnd*: HWND
    pcmcb*: ptr IContextMenuCB
    pidlFolder*: PCIDLIST_ABSOLUTE
    psf*: ptr IShellFolder
    cidl*: UINT
    apidl*: PCUITEMID_CHILD_ARRAY
    punkAssociationInfo*: ptr IUnknown
    cKeys*: UINT
    aKeys*: ptr HKEY
  IQueryAssociations* {.pure.} = object
    lpVtbl*: ptr IQueryAssociationsVtbl
  IQueryAssociationsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Init*: proc(self: ptr IQueryAssociations, flags: ASSOCF, pszAssoc: LPCWSTR, hkProgid: HKEY, hwnd: HWND): HRESULT {.stdcall.}
    GetString*: proc(self: ptr IQueryAssociations, flags: ASSOCF, str: ASSOCSTR, pszExtra: LPCWSTR, pszOut: LPWSTR, pcchOut: ptr DWORD): HRESULT {.stdcall.}
    GetKey*: proc(self: ptr IQueryAssociations, flags: ASSOCF, key: ASSOCKEY, pszExtra: LPCWSTR, phkeyOut: ptr HKEY): HRESULT {.stdcall.}
    GetData*: proc(self: ptr IQueryAssociations, flags: ASSOCF, data: ASSOCDATA, pszExtra: LPCWSTR, pvOut: LPVOID, pcbOut: ptr DWORD): HRESULT {.stdcall.}
    GetEnum*: proc(self: ptr IQueryAssociations, flags: ASSOCF, assocenum: ASSOCENUM, pszExtra: LPCWSTR, riid: REFIID, ppvOut: ptr LPVOID): HRESULT {.stdcall.}
  IFolderViewOC* {.pure.} = object
    lpVtbl*: ptr IFolderViewOCVtbl
  IFolderViewOCVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    SetFolderView*: proc(self: ptr IFolderViewOC, pdisp: ptr IDispatch): HRESULT {.stdcall.}
  DShellFolderViewEvents* {.pure.} = object
    lpVtbl*: ptr DShellFolderViewEventsVtbl
  DShellFolderViewEventsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  DFConstraint* {.pure.} = object
    lpVtbl*: ptr DFConstraintVtbl
  DFConstraintVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Name*: proc(self: ptr DFConstraint, pbs: ptr BSTR): HRESULT {.stdcall.}
    get_Value*: proc(self: ptr DFConstraint, pv: ptr VARIANT): HRESULT {.stdcall.}
  FolderItems* {.pure.} = object
    lpVtbl*: ptr FolderItemsVtbl
  FolderItemsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Count*: proc(self: ptr FolderItems, plCount: ptr LONG): HRESULT {.stdcall.}
    get_Application*: proc(self: ptr FolderItems, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Parent*: proc(self: ptr FolderItems, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    Item*: proc(self: ptr FolderItems, index: VARIANT, ppid: ptr ptr FolderItem): HRESULT {.stdcall.}
    NewEnum*: proc(self: ptr FolderItems, ppunk: ptr ptr IUnknown): HRESULT {.stdcall.}
  Folder* {.pure.} = object
    lpVtbl*: ptr FolderVtbl
  FolderVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Title*: proc(self: ptr Folder, pbs: ptr BSTR): HRESULT {.stdcall.}
    get_Application*: proc(self: ptr Folder, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Parent*: proc(self: ptr Folder, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_ParentFolder*: proc(self: ptr Folder, ppsf: ptr ptr Folder): HRESULT {.stdcall.}
    Items*: proc(self: ptr Folder, ppid: ptr ptr FolderItems): HRESULT {.stdcall.}
    ParseName*: proc(self: ptr Folder, bName: BSTR, ppid: ptr ptr FolderItem): HRESULT {.stdcall.}
    NewFolder*: proc(self: ptr Folder, bName: BSTR, vOptions: VARIANT): HRESULT {.stdcall.}
    MoveHere*: proc(self: ptr Folder, vItem: VARIANT, vOptions: VARIANT): HRESULT {.stdcall.}
    CopyHere*: proc(self: ptr Folder, vItem: VARIANT, vOptions: VARIANT): HRESULT {.stdcall.}
    GetDetailsOf*: proc(self: ptr Folder, vItem: VARIANT, iColumn: int32, pbs: ptr BSTR): HRESULT {.stdcall.}
  Folder2* {.pure.} = object
    lpVtbl*: ptr Folder2Vtbl
  Folder2Vtbl* {.pure, inheritable.} = object of FolderVtbl
    get_Self*: proc(self: ptr Folder2, ppfi: ptr ptr FolderItem): HRESULT {.stdcall.}
    get_OfflineStatus*: proc(self: ptr Folder2, pul: ptr LONG): HRESULT {.stdcall.}
    Synchronize*: proc(self: ptr Folder2): HRESULT {.stdcall.}
    get_HaveToShowWebViewBarricade*: proc(self: ptr Folder2, pbHaveToShowWebViewBarricade: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    DismissedWebViewBarricade*: proc(self: ptr Folder2): HRESULT {.stdcall.}
  Folder3* {.pure.} = object
    lpVtbl*: ptr Folder3Vtbl
  Folder3Vtbl* {.pure, inheritable.} = object of Folder2Vtbl
    get_ShowWebViewBarricade*: proc(self: ptr Folder3, pbShowWebViewBarricade: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_ShowWebViewBarricade*: proc(self: ptr Folder3, bShowWebViewBarricade: VARIANT_BOOL): HRESULT {.stdcall.}
  FolderItem2* {.pure.} = object
    lpVtbl*: ptr FolderItem2Vtbl
  FolderItem2Vtbl* {.pure, inheritable.} = object of FolderItemVtbl
    InvokeVerbEx*: proc(self: ptr FolderItem2, vVerb: VARIANT, vArgs: VARIANT): HRESULT {.stdcall.}
    ExtendedProperty*: proc(self: ptr FolderItem2, bstrPropName: BSTR, pvRet: ptr VARIANT): HRESULT {.stdcall.}
  FolderItems2* {.pure.} = object
    lpVtbl*: ptr FolderItems2Vtbl
  FolderItems2Vtbl* {.pure, inheritable.} = object of FolderItemsVtbl
    InvokeVerbEx*: proc(self: ptr FolderItems2, vVerb: VARIANT, vArgs: VARIANT): HRESULT {.stdcall.}
  FolderItems3* {.pure.} = object
    lpVtbl*: ptr FolderItems3Vtbl
  FolderItems3Vtbl* {.pure, inheritable.} = object of FolderItems2Vtbl
    Filter*: proc(self: ptr FolderItems3, grfFlags: LONG, bstrFileSpec: BSTR): HRESULT {.stdcall.}
    get_Verbs*: proc(self: ptr FolderItems3, ppfic: ptr ptr FolderItemVerbs): HRESULT {.stdcall.}
  IShellLinkDual* {.pure.} = object
    lpVtbl*: ptr IShellLinkDualVtbl
  IShellLinkDualVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Path*: proc(self: ptr IShellLinkDual, pbs: ptr BSTR): HRESULT {.stdcall.}
    put_Path*: proc(self: ptr IShellLinkDual, bs: BSTR): HRESULT {.stdcall.}
    get_Description*: proc(self: ptr IShellLinkDual, pbs: ptr BSTR): HRESULT {.stdcall.}
    put_Description*: proc(self: ptr IShellLinkDual, bs: BSTR): HRESULT {.stdcall.}
    get_WorkingDirectory*: proc(self: ptr IShellLinkDual, pbs: ptr BSTR): HRESULT {.stdcall.}
    put_WorkingDirectory*: proc(self: ptr IShellLinkDual, bs: BSTR): HRESULT {.stdcall.}
    get_Arguments*: proc(self: ptr IShellLinkDual, pbs: ptr BSTR): HRESULT {.stdcall.}
    put_Arguments*: proc(self: ptr IShellLinkDual, bs: BSTR): HRESULT {.stdcall.}
    get_Hotkey*: proc(self: ptr IShellLinkDual, piHK: ptr int32): HRESULT {.stdcall.}
    put_Hotkey*: proc(self: ptr IShellLinkDual, iHK: int32): HRESULT {.stdcall.}
    get_ShowCommand*: proc(self: ptr IShellLinkDual, piShowCommand: ptr int32): HRESULT {.stdcall.}
    put_ShowCommand*: proc(self: ptr IShellLinkDual, iShowCommand: int32): HRESULT {.stdcall.}
    Resolve*: proc(self: ptr IShellLinkDual, fFlags: int32): HRESULT {.stdcall.}
    GetIconLocation*: proc(self: ptr IShellLinkDual, pbs: ptr BSTR, piIcon: ptr int32): HRESULT {.stdcall.}
    SetIconLocation*: proc(self: ptr IShellLinkDual, bs: BSTR, iIcon: int32): HRESULT {.stdcall.}
    Save*: proc(self: ptr IShellLinkDual, vWhere: VARIANT): HRESULT {.stdcall.}
  IShellLinkDual2* {.pure.} = object
    lpVtbl*: ptr IShellLinkDual2Vtbl
  IShellLinkDual2Vtbl* {.pure, inheritable.} = object of IShellLinkDualVtbl
    get_Target*: proc(self: ptr IShellLinkDual2, ppfi: ptr ptr FolderItem): HRESULT {.stdcall.}
  IShellFolderViewDual* {.pure.} = object
    lpVtbl*: ptr IShellFolderViewDualVtbl
  IShellFolderViewDualVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Application*: proc(self: ptr IShellFolderViewDual, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Parent*: proc(self: ptr IShellFolderViewDual, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Folder*: proc(self: ptr IShellFolderViewDual, ppid: ptr ptr Folder): HRESULT {.stdcall.}
    SelectedItems*: proc(self: ptr IShellFolderViewDual, ppid: ptr ptr FolderItems): HRESULT {.stdcall.}
    get_FocusedItem*: proc(self: ptr IShellFolderViewDual, ppid: ptr ptr FolderItem): HRESULT {.stdcall.}
    SelectItem*: proc(self: ptr IShellFolderViewDual, pvfi: ptr VARIANT, dwFlags: int32): HRESULT {.stdcall.}
    PopupItemMenu*: proc(self: ptr IShellFolderViewDual, pfi: ptr FolderItem, vx: VARIANT, vy: VARIANT, pbs: ptr BSTR): HRESULT {.stdcall.}
    get_Script*: proc(self: ptr IShellFolderViewDual, ppDisp: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_ViewOptions*: proc(self: ptr IShellFolderViewDual, plViewOptions: ptr LONG): HRESULT {.stdcall.}
  IShellFolderViewDual2* {.pure.} = object
    lpVtbl*: ptr IShellFolderViewDual2Vtbl
  IShellFolderViewDual2Vtbl* {.pure, inheritable.} = object of IShellFolderViewDualVtbl
    get_CurrentViewMode*: proc(self: ptr IShellFolderViewDual2, pViewMode: ptr UINT): HRESULT {.stdcall.}
    put_CurrentViewMode*: proc(self: ptr IShellFolderViewDual2, ViewMode: UINT): HRESULT {.stdcall.}
    SelectItemRelative*: proc(self: ptr IShellFolderViewDual2, iRelative: int32): HRESULT {.stdcall.}
  IShellFolderViewDual3* {.pure.} = object
    lpVtbl*: ptr IShellFolderViewDual3Vtbl
  IShellFolderViewDual3Vtbl* {.pure, inheritable.} = object of IShellFolderViewDual2Vtbl
    get_GroupBy*: proc(self: ptr IShellFolderViewDual3, pbstrGroupBy: ptr BSTR): HRESULT {.stdcall.}
    put_GroupBy*: proc(self: ptr IShellFolderViewDual3, bstrGroupBy: BSTR): HRESULT {.stdcall.}
    get_FolderFlags*: proc(self: ptr IShellFolderViewDual3, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
    put_FolderFlags*: proc(self: ptr IShellFolderViewDual3, dwFlags: DWORD): HRESULT {.stdcall.}
    get_SortColumns*: proc(self: ptr IShellFolderViewDual3, pbstrSortColumns: ptr BSTR): HRESULT {.stdcall.}
    put_SortColumns*: proc(self: ptr IShellFolderViewDual3, bstrSortColumns: BSTR): HRESULT {.stdcall.}
    put_IconSize*: proc(self: ptr IShellFolderViewDual3, iIconSize: int32): HRESULT {.stdcall.}
    get_IconSize*: proc(self: ptr IShellFolderViewDual3, piIconSize: ptr int32): HRESULT {.stdcall.}
    FilterView*: proc(self: ptr IShellFolderViewDual3, bstrFilterText: BSTR): HRESULT {.stdcall.}
  IShellDispatch* {.pure.} = object
    lpVtbl*: ptr IShellDispatchVtbl
  IShellDispatchVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Application*: proc(self: ptr IShellDispatch, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Parent*: proc(self: ptr IShellDispatch, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    NameSpace*: proc(self: ptr IShellDispatch, vDir: VARIANT, ppsdf: ptr ptr Folder): HRESULT {.stdcall.}
    BrowseForFolder*: proc(self: ptr IShellDispatch, Hwnd: LONG, Title: BSTR, Options: LONG, RootFolder: VARIANT, ppsdf: ptr ptr Folder): HRESULT {.stdcall.}
    Windows*: proc(self: ptr IShellDispatch, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    Open*: proc(self: ptr IShellDispatch, vDir: VARIANT): HRESULT {.stdcall.}
    Explore*: proc(self: ptr IShellDispatch, vDir: VARIANT): HRESULT {.stdcall.}
    MinimizeAll*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    UndoMinimizeALL*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    FileRun*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    CascadeWindows*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    TileVertically*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    TileHorizontally*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    ShutdownWindows*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    Suspend*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    EjectPC*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    SetTime*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    TrayProperties*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    Help*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    FindFiles*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    FindComputer*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    RefreshMenu*: proc(self: ptr IShellDispatch): HRESULT {.stdcall.}
    ControlPanelItem*: proc(self: ptr IShellDispatch, bstrDir: BSTR): HRESULT {.stdcall.}
  IShellDispatch2* {.pure.} = object
    lpVtbl*: ptr IShellDispatch2Vtbl
  IShellDispatch2Vtbl* {.pure, inheritable.} = object of IShellDispatchVtbl
    IsRestricted*: proc(self: ptr IShellDispatch2, Group: BSTR, Restriction: BSTR, plRestrictValue: ptr LONG): HRESULT {.stdcall.}
    ShellExecute*: proc(self: ptr IShellDispatch2, File: BSTR, vArgs: VARIANT, vDir: VARIANT, vOperation: VARIANT, vShow: VARIANT): HRESULT {.stdcall.}
    FindPrinter*: proc(self: ptr IShellDispatch2, name: BSTR, location: BSTR, model: BSTR): HRESULT {.stdcall.}
    GetSystemInformation*: proc(self: ptr IShellDispatch2, name: BSTR, pv: ptr VARIANT): HRESULT {.stdcall.}
    ServiceStart*: proc(self: ptr IShellDispatch2, ServiceName: BSTR, Persistent: VARIANT, pSuccess: ptr VARIANT): HRESULT {.stdcall.}
    ServiceStop*: proc(self: ptr IShellDispatch2, ServiceName: BSTR, Persistent: VARIANT, pSuccess: ptr VARIANT): HRESULT {.stdcall.}
    IsServiceRunning*: proc(self: ptr IShellDispatch2, ServiceName: BSTR, pRunning: ptr VARIANT): HRESULT {.stdcall.}
    CanStartStopService*: proc(self: ptr IShellDispatch2, ServiceName: BSTR, pCanStartStop: ptr VARIANT): HRESULT {.stdcall.}
    ShowBrowserBar*: proc(self: ptr IShellDispatch2, bstrClsid: BSTR, bShow: VARIANT, pSuccess: ptr VARIANT): HRESULT {.stdcall.}
  IShellDispatch3* {.pure.} = object
    lpVtbl*: ptr IShellDispatch3Vtbl
  IShellDispatch3Vtbl* {.pure, inheritable.} = object of IShellDispatch2Vtbl
    AddToRecent*: proc(self: ptr IShellDispatch3, varFile: VARIANT, bstrCategory: BSTR): HRESULT {.stdcall.}
  IShellDispatch4* {.pure.} = object
    lpVtbl*: ptr IShellDispatch4Vtbl
  IShellDispatch4Vtbl* {.pure, inheritable.} = object of IShellDispatch3Vtbl
    WindowsSecurity*: proc(self: ptr IShellDispatch4): HRESULT {.stdcall.}
    ToggleDesktop*: proc(self: ptr IShellDispatch4): HRESULT {.stdcall.}
    ExplorerPolicy*: proc(self: ptr IShellDispatch4, bstrPolicyName: BSTR, pValue: ptr VARIANT): HRESULT {.stdcall.}
    GetSetting*: proc(self: ptr IShellDispatch4, lSetting: LONG, pResult: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  IShellDispatch5* {.pure.} = object
    lpVtbl*: ptr IShellDispatch5Vtbl
  IShellDispatch5Vtbl* {.pure, inheritable.} = object of IShellDispatch4Vtbl
    WindowSwitcher*: proc(self: ptr IShellDispatch5): HRESULT {.stdcall.}
  IShellDispatch6* {.pure.} = object
    lpVtbl*: ptr IShellDispatch6Vtbl
  IShellDispatch6Vtbl* {.pure, inheritable.} = object of IShellDispatch5Vtbl
    SearchCommand*: proc(self: ptr IShellDispatch6): HRESULT {.stdcall.}
  IFileSearchBand* {.pure.} = object
    lpVtbl*: ptr IFileSearchBandVtbl
  IFileSearchBandVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    SetFocus*: proc(self: ptr IFileSearchBand): HRESULT {.stdcall.}
    SetSearchParameters*: proc(self: ptr IFileSearchBand, pbstrSearchID: ptr BSTR, bNavToResults: VARIANT_BOOL, pvarScope: ptr VARIANT, pvarQueryFile: ptr VARIANT): HRESULT {.stdcall.}
    get_SearchID*: proc(self: ptr IFileSearchBand, pbstrSearchID: ptr BSTR): HRESULT {.stdcall.}
    get_Scope*: proc(self: ptr IFileSearchBand, pvarScope: ptr VARIANT): HRESULT {.stdcall.}
    get_QueryFile*: proc(self: ptr IFileSearchBand, pvarFile: ptr VARIANT): HRESULT {.stdcall.}
  IWebWizardHost* {.pure.} = object
    lpVtbl*: ptr IWebWizardHostVtbl
  IWebWizardHostVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    FinalBack*: proc(self: ptr IWebWizardHost): HRESULT {.stdcall.}
    FinalNext*: proc(self: ptr IWebWizardHost): HRESULT {.stdcall.}
    Cancel*: proc(self: ptr IWebWizardHost): HRESULT {.stdcall.}
    put_Caption*: proc(self: ptr IWebWizardHost, bstrCaption: BSTR): HRESULT {.stdcall.}
    get_Caption*: proc(self: ptr IWebWizardHost, pbstrCaption: ptr BSTR): HRESULT {.stdcall.}
    put_Property*: proc(self: ptr IWebWizardHost, bstrPropertyName: BSTR, pvProperty: ptr VARIANT): HRESULT {.stdcall.}
    get_Property*: proc(self: ptr IWebWizardHost, bstrPropertyName: BSTR, pvProperty: ptr VARIANT): HRESULT {.stdcall.}
    SetWizardButtons*: proc(self: ptr IWebWizardHost, vfEnableBack: VARIANT_BOOL, vfEnableNext: VARIANT_BOOL, vfLastPage: VARIANT_BOOL): HRESULT {.stdcall.}
    SetHeaderText*: proc(self: ptr IWebWizardHost, bstrHeaderTitle: BSTR, bstrHeaderSubtitle: BSTR): HRESULT {.stdcall.}
  INewWDEvents* {.pure.} = object
    lpVtbl*: ptr INewWDEventsVtbl
  INewWDEventsVtbl* {.pure, inheritable.} = object of IWebWizardHostVtbl
    PassportAuthenticate*: proc(self: ptr INewWDEvents, bstrSignInUrl: BSTR, pvfAuthenitcated: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  IDataObjectAsyncCapability* {.pure.} = object
    lpVtbl*: ptr IDataObjectAsyncCapabilityVtbl
  IDataObjectAsyncCapabilityVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetAsyncMode*: proc(self: ptr IDataObjectAsyncCapability, fDoOpAsync: WINBOOL): HRESULT {.stdcall.}
    GetAsyncMode*: proc(self: ptr IDataObjectAsyncCapability, pfIsOpAsync: ptr WINBOOL): HRESULT {.stdcall.}
    StartOperation*: proc(self: ptr IDataObjectAsyncCapability, pbcReserved: ptr IBindCtx): HRESULT {.stdcall.}
    InOperation*: proc(self: ptr IDataObjectAsyncCapability, pfInAsyncOp: ptr WINBOOL): HRESULT {.stdcall.}
    EndOperation*: proc(self: ptr IDataObjectAsyncCapability, hResult: HRESULT, pbcReserved: ptr IBindCtx, dwEffects: DWORD): HRESULT {.stdcall.}
  IObjectArray* {.pure.} = object
    lpVtbl*: ptr IObjectArrayVtbl
  IObjectArrayVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCount*: proc(self: ptr IObjectArray, pcObjects: ptr UINT): HRESULT {.stdcall.}
    GetAt*: proc(self: ptr IObjectArray, uiIndex: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IObjectCollection* {.pure.} = object
    lpVtbl*: ptr IObjectCollectionVtbl
  IObjectCollectionVtbl* {.pure, inheritable.} = object of IObjectArrayVtbl
    AddObject*: proc(self: ptr IObjectCollection, punk: ptr IUnknown): HRESULT {.stdcall.}
    AddFromArray*: proc(self: ptr IObjectCollection, poaSource: ptr IObjectArray): HRESULT {.stdcall.}
    RemoveObjectAt*: proc(self: ptr IObjectCollection, uiIndex: UINT): HRESULT {.stdcall.}
    Clear*: proc(self: ptr IObjectCollection): HRESULT {.stdcall.}
  IExecuteCommand* {.pure.} = object
    lpVtbl*: ptr IExecuteCommandVtbl
  IExecuteCommandVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetKeyState*: proc(self: ptr IExecuteCommand, grfKeyState: DWORD): HRESULT {.stdcall.}
    SetParameters*: proc(self: ptr IExecuteCommand, pszParameters: LPCWSTR): HRESULT {.stdcall.}
    SetPosition*: proc(self: ptr IExecuteCommand, pt: POINT): HRESULT {.stdcall.}
    SetShowWindow*: proc(self: ptr IExecuteCommand, nShow: int32): HRESULT {.stdcall.}
    SetNoShowUI*: proc(self: ptr IExecuteCommand, fNoShowUI: WINBOOL): HRESULT {.stdcall.}
    SetDirectory*: proc(self: ptr IExecuteCommand, pszDirectory: LPCWSTR): HRESULT {.stdcall.}
    Execute*: proc(self: ptr IExecuteCommand): HRESULT {.stdcall.}
  IRunnableTask* {.pure.} = object
    lpVtbl*: ptr IRunnableTaskVtbl
  IRunnableTaskVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Run*: proc(self: ptr IRunnableTask): HRESULT {.stdcall.}
    Kill*: proc(self: ptr IRunnableTask, bWait: WINBOOL): HRESULT {.stdcall.}
    Suspend*: proc(self: ptr IRunnableTask): HRESULT {.stdcall.}
    Resume*: proc(self: ptr IRunnableTask): HRESULT {.stdcall.}
    IsRunning*: proc(self: ptr IRunnableTask): ULONG {.stdcall.}
  IShellTaskScheduler* {.pure.} = object
    lpVtbl*: ptr IShellTaskSchedulerVtbl
  IShellTaskSchedulerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddTask*: proc(self: ptr IShellTaskScheduler, prt: ptr IRunnableTask, rtoid: REFTASKOWNERID, lParam: DWORD_PTR, dwPriority: DWORD): HRESULT {.stdcall.}
    RemoveTasks*: proc(self: ptr IShellTaskScheduler, rtoid: REFTASKOWNERID, lParam: DWORD_PTR, bWaitIfRunning: WINBOOL): HRESULT {.stdcall.}
    CountTasks*: proc(self: ptr IShellTaskScheduler, rtoid: REFTASKOWNERID): UINT {.stdcall.}
    Status*: proc(self: ptr IShellTaskScheduler, dwReleaseStatus: DWORD, dwThreadTimeout: DWORD): HRESULT {.stdcall.}
  IQueryCodePage* {.pure.} = object
    lpVtbl*: ptr IQueryCodePageVtbl
  IQueryCodePageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCodePage*: proc(self: ptr IQueryCodePage, puiCodePage: ptr UINT): HRESULT {.stdcall.}
    SetCodePage*: proc(self: ptr IQueryCodePage, uiCodePage: UINT): HRESULT {.stdcall.}
  IPersistFolder2* {.pure.} = object
    lpVtbl*: ptr IPersistFolder2Vtbl
  IPersistFolder2Vtbl* {.pure, inheritable.} = object of IPersistFolderVtbl
    GetCurFolder*: proc(self: ptr IPersistFolder2, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.stdcall.}
  IPersistFolder3* {.pure.} = object
    lpVtbl*: ptr IPersistFolder3Vtbl
  IPersistFolder3Vtbl* {.pure, inheritable.} = object of IPersistFolder2Vtbl
    InitializeEx*: proc(self: ptr IPersistFolder3, pbc: ptr IBindCtx, pidlRoot: PCIDLIST_ABSOLUTE, ppfti: ptr PERSIST_FOLDER_TARGET_INFO): HRESULT {.stdcall.}
    GetFolderTargetInfo*: proc(self: ptr IPersistFolder3, ppfti: ptr PERSIST_FOLDER_TARGET_INFO): HRESULT {.stdcall.}
  IPersistIDList* {.pure.} = object
    lpVtbl*: ptr IPersistIDListVtbl
  IPersistIDListVtbl* {.pure, inheritable.} = object of IPersistVtbl
    SetIDList*: proc(self: ptr IPersistIDList, pidl: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    GetIDList*: proc(self: ptr IPersistIDList, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.stdcall.}
  IEnumFullIDList* {.pure.} = object
    lpVtbl*: ptr IEnumFullIDListVtbl
  IEnumFullIDListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumFullIDList, celt: ULONG, rgelt: ptr PIDLIST_ABSOLUTE, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumFullIDList, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumFullIDList): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumFullIDList, ppenum: ptr ptr IEnumFullIDList): HRESULT {.stdcall.}
  IObjectWithFolderEnumMode* {.pure.} = object
    lpVtbl*: ptr IObjectWithFolderEnumModeVtbl
  IObjectWithFolderEnumModeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetMode*: proc(self: ptr IObjectWithFolderEnumMode, feMode: FOLDER_ENUM_MODE): HRESULT {.stdcall.}
    GetMode*: proc(self: ptr IObjectWithFolderEnumMode, pfeMode: ptr FOLDER_ENUM_MODE): HRESULT {.stdcall.}
  IParseAndCreateItem* {.pure.} = object
    lpVtbl*: ptr IParseAndCreateItemVtbl
  IParseAndCreateItemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetItem*: proc(self: ptr IParseAndCreateItem, psi: ptr IShellItem): HRESULT {.stdcall.}
    GetItem*: proc(self: ptr IParseAndCreateItem, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IShellFolder2* {.pure.} = object
    lpVtbl*: ptr IShellFolder2Vtbl
  IShellFolder2Vtbl* {.pure, inheritable.} = object of IShellFolderVtbl
    GetDefaultSearchGUID*: proc(self: ptr IShellFolder2, pguid: ptr GUID): HRESULT {.stdcall.}
    EnumSearches*: proc(self: ptr IShellFolder2, ppenum: ptr ptr IEnumExtraSearch): HRESULT {.stdcall.}
    GetDefaultColumn*: proc(self: ptr IShellFolder2, dwRes: DWORD, pSort: ptr ULONG, pDisplay: ptr ULONG): HRESULT {.stdcall.}
    GetDefaultColumnState*: proc(self: ptr IShellFolder2, iColumn: UINT, pcsFlags: ptr SHCOLSTATEF): HRESULT {.stdcall.}
    GetDetailsEx*: proc(self: ptr IShellFolder2, pidl: PCUITEMID_CHILD, pscid: ptr SHCOLUMNID, pv: ptr VARIANT): HRESULT {.stdcall.}
    GetDetailsOf*: proc(self: ptr IShellFolder2, pidl: PCUITEMID_CHILD, iColumn: UINT, psd: ptr SHELLDETAILS): HRESULT {.stdcall.}
    MapColumnToSCID*: proc(self: ptr IShellFolder2, iColumn: UINT, pscid: ptr SHCOLUMNID): HRESULT {.stdcall.}
  IFolderViewOptions* {.pure.} = object
    lpVtbl*: ptr IFolderViewOptionsVtbl
  IFolderViewOptionsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetFolderViewOptions*: proc(self: ptr IFolderViewOptions, fvoMask: FOLDERVIEWOPTIONS, fvoFlags: FOLDERVIEWOPTIONS): HRESULT {.stdcall.}
    GetFolderViewOptions*: proc(self: ptr IFolderViewOptions, pfvoFlags: ptr FOLDERVIEWOPTIONS): HRESULT {.stdcall.}
  IShellView2* {.pure.} = object
    lpVtbl*: ptr IShellView2Vtbl
  IShellView2Vtbl* {.pure, inheritable.} = object of IShellViewVtbl
    GetView*: proc(self: ptr IShellView2, pvid: ptr SHELLVIEWID, uView: ULONG): HRESULT {.stdcall.}
    CreateViewWindow2*: proc(self: ptr IShellView2, lpParams: LPSV2CVW2_PARAMS): HRESULT {.stdcall.}
    HandleRename*: proc(self: ptr IShellView2, pidlNew: PCUITEMID_CHILD): HRESULT {.stdcall.}
    SelectAndPositionItem*: proc(self: ptr IShellView2, pidlItem: PCUITEMID_CHILD, uFlags: UINT, ppt: ptr POINT): HRESULT {.stdcall.}
  IShellView3* {.pure.} = object
    lpVtbl*: ptr IShellView3Vtbl
  IShellView3Vtbl* {.pure, inheritable.} = object of IShellView2Vtbl
    CreateViewWindow3*: proc(self: ptr IShellView3, psbOwner: ptr IShellBrowser, psvPrev: ptr IShellView, dwViewFlags: SV3CVW3_FLAGS, dwMask: FOLDERFLAGS, dwFlags: FOLDERFLAGS, fvMode: FOLDERVIEWMODE, pvid: ptr SHELLVIEWID, prcView: ptr RECT, phwndView: ptr HWND): HRESULT {.stdcall.}
  IFolderView* {.pure.} = object
    lpVtbl*: ptr IFolderViewVtbl
  IFolderViewVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentViewMode*: proc(self: ptr IFolderView, pViewMode: ptr UINT): HRESULT {.stdcall.}
    SetCurrentViewMode*: proc(self: ptr IFolderView, ViewMode: UINT): HRESULT {.stdcall.}
    GetFolder*: proc(self: ptr IFolderView, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    Item*: proc(self: ptr IFolderView, iItemIndex: int32, ppidl: ptr PITEMID_CHILD): HRESULT {.stdcall.}
    ItemCount*: proc(self: ptr IFolderView, uFlags: UINT, pcItems: ptr int32): HRESULT {.stdcall.}
    Items*: proc(self: ptr IFolderView, uFlags: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetSelectionMarkedItem*: proc(self: ptr IFolderView, piItem: ptr int32): HRESULT {.stdcall.}
    GetFocusedItem*: proc(self: ptr IFolderView, piItem: ptr int32): HRESULT {.stdcall.}
    GetItemPosition*: proc(self: ptr IFolderView, pidl: PCUITEMID_CHILD, ppt: ptr POINT): HRESULT {.stdcall.}
    GetSpacing*: proc(self: ptr IFolderView, ppt: ptr POINT): HRESULT {.stdcall.}
    GetDefaultSpacing*: proc(self: ptr IFolderView, ppt: ptr POINT): HRESULT {.stdcall.}
    GetAutoArrange*: proc(self: ptr IFolderView): HRESULT {.stdcall.}
    SelectItem*: proc(self: ptr IFolderView, iItem: int32, dwFlags: DWORD): HRESULT {.stdcall.}
    SelectAndPositionItems*: proc(self: ptr IFolderView, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, apt: ptr POINT, dwFlags: DWORD): HRESULT {.stdcall.}
  ISearchBoxInfo* {.pure.} = object
    lpVtbl*: ptr ISearchBoxInfoVtbl
  ISearchBoxInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCondition*: proc(self: ptr ISearchBoxInfo, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetText*: proc(self: ptr ISearchBoxInfo, ppsz: ptr LPWSTR): HRESULT {.stdcall.}
  IEnumShellItems* {.pure.} = object
    lpVtbl*: ptr IEnumShellItemsVtbl
  IEnumShellItemsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumShellItems, celt: ULONG, rgelt: ptr ptr IShellItem, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumShellItems, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumShellItems): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumShellItems, ppenum: ptr ptr IEnumShellItems): HRESULT {.stdcall.}
  IShellItemArray* {.pure.} = object
    lpVtbl*: ptr IShellItemArrayVtbl
  IShellItemArrayVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    BindToHandler*: proc(self: ptr IShellItemArray, pbc: ptr IBindCtx, bhid: REFGUID, riid: REFIID, ppvOut: ptr pointer): HRESULT {.stdcall.}
    GetPropertyStore*: proc(self: ptr IShellItemArray, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetPropertyDescriptionList*: proc(self: ptr IShellItemArray, keyType: REFPROPERTYKEY, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetAttributes*: proc(self: ptr IShellItemArray, AttribFlags: SIATTRIBFLAGS, sfgaoMask: SFGAOF, psfgaoAttribs: ptr SFGAOF): HRESULT {.stdcall.}
    GetCount*: proc(self: ptr IShellItemArray, pdwNumItems: ptr DWORD): HRESULT {.stdcall.}
    GetItemAt*: proc(self: ptr IShellItemArray, dwIndex: DWORD, ppsi: ptr ptr IShellItem): HRESULT {.stdcall.}
    EnumItems*: proc(self: ptr IShellItemArray, ppenumShellItems: ptr ptr IEnumShellItems): HRESULT {.stdcall.}
  IFolderView2* {.pure.} = object
    lpVtbl*: ptr IFolderView2Vtbl
  IFolderView2Vtbl* {.pure, inheritable.} = object of IFolderViewVtbl
    SetGroupBy*: proc(self: ptr IFolderView2, key: REFPROPERTYKEY, fAscending: WINBOOL): HRESULT {.stdcall.}
    GetGroupBy*: proc(self: ptr IFolderView2, pkey: ptr PROPERTYKEY, pfAscending: ptr WINBOOL): HRESULT {.stdcall.}
    SetViewProperty*: proc(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, propkey: REFPROPERTYKEY, propvar: REFPROPVARIANT): HRESULT {.stdcall.}
    GetViewProperty*: proc(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, propkey: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT): HRESULT {.stdcall.}
    SetTileViewProperties*: proc(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, pszPropList: LPCWSTR): HRESULT {.stdcall.}
    SetExtendedTileViewProperties*: proc(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, pszPropList: LPCWSTR): HRESULT {.stdcall.}
    SetText*: proc(self: ptr IFolderView2, iType: FVTEXTTYPE, pwszText: LPCWSTR): HRESULT {.stdcall.}
    SetCurrentFolderFlags*: proc(self: ptr IFolderView2, dwMask: DWORD, dwFlags: DWORD): HRESULT {.stdcall.}
    GetCurrentFolderFlags*: proc(self: ptr IFolderView2, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
    GetSortColumnCount*: proc(self: ptr IFolderView2, pcColumns: ptr int32): HRESULT {.stdcall.}
    SetSortColumns*: proc(self: ptr IFolderView2, rgSortColumns: ptr SORTCOLUMN, cColumns: int32): HRESULT {.stdcall.}
    GetSortColumns*: proc(self: ptr IFolderView2, rgSortColumns: ptr SORTCOLUMN, cColumns: int32): HRESULT {.stdcall.}
    GetItem*: proc(self: ptr IFolderView2, iItem: int32, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetVisibleItem*: proc(self: ptr IFolderView2, iStart: int32, fPrevious: WINBOOL, piItem: ptr int32): HRESULT {.stdcall.}
    GetSelectedItem*: proc(self: ptr IFolderView2, iStart: int32, piItem: ptr int32): HRESULT {.stdcall.}
    GetSelection*: proc(self: ptr IFolderView2, fNoneImpliesFolder: WINBOOL, ppsia: ptr ptr IShellItemArray): HRESULT {.stdcall.}
    GetSelectionState*: proc(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
    InvokeVerbOnSelection*: proc(self: ptr IFolderView2, pszVerb: LPCSTR): HRESULT {.stdcall.}
    SetViewModeAndIconSize*: proc(self: ptr IFolderView2, uViewMode: FOLDERVIEWMODE, iImageSize: int32): HRESULT {.stdcall.}
    GetViewModeAndIconSize*: proc(self: ptr IFolderView2, puViewMode: ptr FOLDERVIEWMODE, piImageSize: ptr int32): HRESULT {.stdcall.}
    SetGroupSubsetCount*: proc(self: ptr IFolderView2, cVisibleRows: UINT): HRESULT {.stdcall.}
    GetGroupSubsetCount*: proc(self: ptr IFolderView2, pcVisibleRows: ptr UINT): HRESULT {.stdcall.}
    SetRedraw*: proc(self: ptr IFolderView2, fRedrawOn: WINBOOL): HRESULT {.stdcall.}
    IsMoveInSameFolder*: proc(self: ptr IFolderView2): HRESULT {.stdcall.}
    DoRename*: proc(self: ptr IFolderView2): HRESULT {.stdcall.}
  IFolderViewSettings* {.pure.} = object
    lpVtbl*: ptr IFolderViewSettingsVtbl
  IFolderViewSettingsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetColumnPropertyList*: proc(self: ptr IFolderViewSettings, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetGroupByProperty*: proc(self: ptr IFolderViewSettings, pkey: ptr PROPERTYKEY, pfGroupAscending: ptr WINBOOL): HRESULT {.stdcall.}
    GetViewMode*: proc(self: ptr IFolderViewSettings, plvm: ptr FOLDERLOGICALVIEWMODE): HRESULT {.stdcall.}
    GetIconSize*: proc(self: ptr IFolderViewSettings, puIconSize: ptr UINT): HRESULT {.stdcall.}
    GetFolderFlags*: proc(self: ptr IFolderViewSettings, pfolderMask: ptr FOLDERFLAGS, pfolderFlags: ptr FOLDERFLAGS): HRESULT {.stdcall.}
    GetSortColumns*: proc(self: ptr IFolderViewSettings, rgSortColumns: ptr SORTCOLUMN, cColumnsIn: UINT, pcColumnsOut: ptr UINT): HRESULT {.stdcall.}
    GetGroupSubsetCount*: proc(self: ptr IFolderViewSettings, pcVisibleRows: ptr UINT): HRESULT {.stdcall.}
  IPreviewHandlerVisuals* {.pure.} = object
    lpVtbl*: ptr IPreviewHandlerVisualsVtbl
  IPreviewHandlerVisualsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetBackgroundColor*: proc(self: ptr IPreviewHandlerVisuals, color: COLORREF): HRESULT {.stdcall.}
    SetFont*: proc(self: ptr IPreviewHandlerVisuals, plf: ptr LOGFONTW): HRESULT {.stdcall.}
    SetTextColor*: proc(self: ptr IPreviewHandlerVisuals, color: COLORREF): HRESULT {.stdcall.}
  IVisualProperties* {.pure.} = object
    lpVtbl*: ptr IVisualPropertiesVtbl
  IVisualPropertiesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetWatermark*: proc(self: ptr IVisualProperties, hbmp: HBITMAP, vpwf: VPWATERMARKFLAGS): HRESULT {.stdcall.}
    SetColor*: proc(self: ptr IVisualProperties, vpcf: VPCOLORFLAGS, cr: COLORREF): HRESULT {.stdcall.}
    GetColor*: proc(self: ptr IVisualProperties, vpcf: VPCOLORFLAGS, pcr: ptr COLORREF): HRESULT {.stdcall.}
    SetItemHeight*: proc(self: ptr IVisualProperties, cyItemInPixels: int32): HRESULT {.stdcall.}
    GetItemHeight*: proc(self: ptr IVisualProperties, cyItemInPixels: ptr int32): HRESULT {.stdcall.}
    SetFont*: proc(self: ptr IVisualProperties, plf: ptr LOGFONTW, bRedraw: WINBOOL): HRESULT {.stdcall.}
    GetFont*: proc(self: ptr IVisualProperties, plf: ptr LOGFONTW): HRESULT {.stdcall.}
    SetTheme*: proc(self: ptr IVisualProperties, pszSubAppName: LPCWSTR, pszSubIdList: LPCWSTR): HRESULT {.stdcall.}
  ICommDlgBrowser3* {.pure.} = object
    lpVtbl*: ptr ICommDlgBrowser3Vtbl
  ICommDlgBrowser3Vtbl* {.pure, inheritable.} = object of ICommDlgBrowser2Vtbl
    OnColumnClicked*: proc(self: ptr ICommDlgBrowser3, ppshv: ptr IShellView, iColumn: int32): HRESULT {.stdcall.}
    GetCurrentFilter*: proc(self: ptr ICommDlgBrowser3, pszFileSpec: LPWSTR, cchFileSpec: int32): HRESULT {.stdcall.}
    OnPreViewCreated*: proc(self: ptr ICommDlgBrowser3, ppshv: ptr IShellView): HRESULT {.stdcall.}
  IColumnManager* {.pure.} = object
    lpVtbl*: ptr IColumnManagerVtbl
  IColumnManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetColumnInfo*: proc(self: ptr IColumnManager, propkey: REFPROPERTYKEY, pcmci: ptr CM_COLUMNINFO): HRESULT {.stdcall.}
    GetColumnInfo*: proc(self: ptr IColumnManager, propkey: REFPROPERTYKEY, pcmci: ptr CM_COLUMNINFO): HRESULT {.stdcall.}
    GetColumnCount*: proc(self: ptr IColumnManager, dwFlags: CM_ENUM_FLAGS, puCount: ptr UINT): HRESULT {.stdcall.}
    GetColumns*: proc(self: ptr IColumnManager, dwFlags: CM_ENUM_FLAGS, rgkeyOrder: ptr PROPERTYKEY, cColumns: UINT): HRESULT {.stdcall.}
    SetColumns*: proc(self: ptr IColumnManager, rgkeyOrder: ptr PROPERTYKEY, cVisible: UINT): HRESULT {.stdcall.}
  IFolderFilterSite* {.pure.} = object
    lpVtbl*: ptr IFolderFilterSiteVtbl
  IFolderFilterSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetFilter*: proc(self: ptr IFolderFilterSite, punk: ptr IUnknown): HRESULT {.stdcall.}
  IFolderFilter* {.pure.} = object
    lpVtbl*: ptr IFolderFilterVtbl
  IFolderFilterVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ShouldShow*: proc(self: ptr IFolderFilter, psf: ptr IShellFolder, pidlFolder: PCIDLIST_ABSOLUTE, pidlItem: PCUITEMID_CHILD): HRESULT {.stdcall.}
    GetEnumFlags*: proc(self: ptr IFolderFilter, psf: ptr IShellFolder, pidlFolder: PCIDLIST_ABSOLUTE, phwnd: ptr HWND, pgrfFlags: ptr DWORD): HRESULT {.stdcall.}
  IInputObjectSite* {.pure.} = object
    lpVtbl*: ptr IInputObjectSiteVtbl
  IInputObjectSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnFocusChangeIS*: proc(self: ptr IInputObjectSite, punkObj: ptr IUnknown, fSetFocus: WINBOOL): HRESULT {.stdcall.}
  IInputObject* {.pure.} = object
    lpVtbl*: ptr IInputObjectVtbl
  IInputObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    UIActivateIO*: proc(self: ptr IInputObject, fActivate: WINBOOL, pMsg: ptr MSG): HRESULT {.stdcall.}
    HasFocusIO*: proc(self: ptr IInputObject): HRESULT {.stdcall.}
    TranslateAcceleratorIO*: proc(self: ptr IInputObject, pMsg: ptr MSG): HRESULT {.stdcall.}
  IInputObject2* {.pure.} = object
    lpVtbl*: ptr IInputObject2Vtbl
  IInputObject2Vtbl* {.pure, inheritable.} = object of IInputObjectVtbl
    TranslateAcceleratorGlobal*: proc(self: ptr IInputObject2, pMsg: ptr MSG): HRESULT {.stdcall.}
  IShellIcon* {.pure.} = object
    lpVtbl*: ptr IShellIconVtbl
  IShellIconVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetIconOf*: proc(self: ptr IShellIcon, pidl: PCUITEMID_CHILD, flags: UINT, pIconIndex: ptr int32): HRESULT {.stdcall.}
  IProfferService* {.pure.} = object
    lpVtbl*: ptr IProfferServiceVtbl
  IProfferServiceVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ProfferService*: proc(self: ptr IProfferService, guidService: REFGUID, psp: ptr IServiceProvider, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    RevokeService*: proc(self: ptr IProfferService, dwCookie: DWORD): HRESULT {.stdcall.}
  IShellItem2* {.pure.} = object
    lpVtbl*: ptr IShellItem2Vtbl
  IShellItem2Vtbl* {.pure, inheritable.} = object of IShellItemVtbl
    GetPropertyStore*: proc(self: ptr IShellItem2, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetPropertyStoreWithCreateObject*: proc(self: ptr IShellItem2, flags: GETPROPERTYSTOREFLAGS, punkCreateObject: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetPropertyStoreForKeys*: proc(self: ptr IShellItem2, rgKeys: ptr PROPERTYKEY, cKeys: UINT, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetPropertyDescriptionList*: proc(self: ptr IShellItem2, keyType: REFPROPERTYKEY, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    Update*: proc(self: ptr IShellItem2, pbc: ptr IBindCtx): HRESULT {.stdcall.}
    GetProperty*: proc(self: ptr IShellItem2, key: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT): HRESULT {.stdcall.}
    GetCLSID*: proc(self: ptr IShellItem2, key: REFPROPERTYKEY, pclsid: ptr CLSID): HRESULT {.stdcall.}
    GetFileTime*: proc(self: ptr IShellItem2, key: REFPROPERTYKEY, pft: ptr FILETIME): HRESULT {.stdcall.}
    GetInt32*: proc(self: ptr IShellItem2, key: REFPROPERTYKEY, pi: ptr int32): HRESULT {.stdcall.}
    GetString*: proc(self: ptr IShellItem2, key: REFPROPERTYKEY, ppsz: ptr LPWSTR): HRESULT {.stdcall.}
    GetUInt32*: proc(self: ptr IShellItem2, key: REFPROPERTYKEY, pui: ptr ULONG): HRESULT {.stdcall.}
    GetUInt64*: proc(self: ptr IShellItem2, key: REFPROPERTYKEY, pull: ptr ULONGLONG): HRESULT {.stdcall.}
    GetBool*: proc(self: ptr IShellItem2, key: REFPROPERTYKEY, pf: ptr WINBOOL): HRESULT {.stdcall.}
  IShellItemImageFactory* {.pure.} = object
    lpVtbl*: ptr IShellItemImageFactoryVtbl
  IShellItemImageFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetImage*: proc(self: ptr IShellItemImageFactory, size: SIZE, flags: SIIGBF, phbm: ptr HBITMAP): HRESULT {.stdcall.}
  IUserAccountChangeCallback* {.pure.} = object
    lpVtbl*: ptr IUserAccountChangeCallbackVtbl
  IUserAccountChangeCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnPictureChange*: proc(self: ptr IUserAccountChangeCallback, pszUserName: LPCWSTR): HRESULT {.stdcall.}
  ITransferAdviseSink* {.pure.} = object
    lpVtbl*: ptr ITransferAdviseSinkVtbl
  ITransferAdviseSinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    UpdateProgress*: proc(self: ptr ITransferAdviseSink, ullSizeCurrent: ULONGLONG, ullSizeTotal: ULONGLONG, nFilesCurrent: int32, nFilesTotal: int32, nFoldersCurrent: int32, nFoldersTotal: int32): HRESULT {.stdcall.}
    UpdateTransferState*: proc(self: ptr ITransferAdviseSink, ts: TRANSFER_ADVISE_STATE): HRESULT {.stdcall.}
    ConfirmOverwrite*: proc(self: ptr ITransferAdviseSink, psiSource: ptr IShellItem, psiDestParent: ptr IShellItem, pszName: LPCWSTR): HRESULT {.stdcall.}
    ConfirmEncryptionLoss*: proc(self: ptr ITransferAdviseSink, psiSource: ptr IShellItem): HRESULT {.stdcall.}
    FileFailure*: proc(self: ptr ITransferAdviseSink, psi: ptr IShellItem, pszItem: LPCWSTR, hrError: HRESULT, pszRename: LPWSTR, cchRename: ULONG): HRESULT {.stdcall.}
    SubStreamFailure*: proc(self: ptr ITransferAdviseSink, psi: ptr IShellItem, pszStreamName: LPCWSTR, hrError: HRESULT): HRESULT {.stdcall.}
    PropertyFailure*: proc(self: ptr ITransferAdviseSink, psi: ptr IShellItem, pkey: ptr PROPERTYKEY, hrError: HRESULT): HRESULT {.stdcall.}
  ITransferSource* {.pure.} = object
    lpVtbl*: ptr ITransferSourceVtbl
  ITransferSourceVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Advise*: proc(self: ptr ITransferSource, psink: ptr ITransferAdviseSink, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr ITransferSource, dwCookie: DWORD): HRESULT {.stdcall.}
    SetProperties*: proc(self: ptr ITransferSource, pproparray: ptr IPropertyChangeArray): HRESULT {.stdcall.}
    OpenItem*: proc(self: ptr ITransferSource, psi: ptr IShellItem, flags: TRANSFER_SOURCE_FLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    MoveItem*: proc(self: ptr ITransferSource, psi: ptr IShellItem, psiParentDst: ptr IShellItem, pszNameDst: LPCWSTR, flags: TRANSFER_SOURCE_FLAGS, ppsiNew: ptr ptr IShellItem): HRESULT {.stdcall.}
    RecycleItem*: proc(self: ptr ITransferSource, psiSource: ptr IShellItem, psiParentDest: ptr IShellItem, flags: TRANSFER_SOURCE_FLAGS, ppsiNewDest: ptr ptr IShellItem): HRESULT {.stdcall.}
    RemoveItem*: proc(self: ptr ITransferSource, psiSource: ptr IShellItem, flags: TRANSFER_SOURCE_FLAGS): HRESULT {.stdcall.}
    RenameItem*: proc(self: ptr ITransferSource, psiSource: ptr IShellItem, pszNewName: LPCWSTR, flags: TRANSFER_SOURCE_FLAGS, ppsiNewDest: ptr ptr IShellItem): HRESULT {.stdcall.}
    LinkItem*: proc(self: ptr ITransferSource, psiSource: ptr IShellItem, psiParentDest: ptr IShellItem, pszNewName: LPCWSTR, flags: TRANSFER_SOURCE_FLAGS, ppsiNewDest: ptr ptr IShellItem): HRESULT {.stdcall.}
    ApplyPropertiesToItem*: proc(self: ptr ITransferSource, psiSource: ptr IShellItem, ppsiNew: ptr ptr IShellItem): HRESULT {.stdcall.}
    GetDefaultDestinationName*: proc(self: ptr ITransferSource, psiSource: ptr IShellItem, psiParentDest: ptr IShellItem, ppszDestinationName: ptr LPWSTR): HRESULT {.stdcall.}
    EnterFolder*: proc(self: ptr ITransferSource, psiChildFolderDest: ptr IShellItem): HRESULT {.stdcall.}
    LeaveFolder*: proc(self: ptr ITransferSource, psiChildFolderDest: ptr IShellItem): HRESULT {.stdcall.}
  IEnumResources* {.pure.} = object
    lpVtbl*: ptr IEnumResourcesVtbl
  IEnumResourcesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumResources, celt: ULONG, psir: ptr SHELL_ITEM_RESOURCE, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumResources, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumResources): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumResources, ppenumr: ptr ptr IEnumResources): HRESULT {.stdcall.}
  IShellItemResources* {.pure.} = object
    lpVtbl*: ptr IShellItemResourcesVtbl
  IShellItemResourcesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetAttributes*: proc(self: ptr IShellItemResources, pdwAttributes: ptr DWORD): HRESULT {.stdcall.}
    GetSize*: proc(self: ptr IShellItemResources, pullSize: ptr ULONGLONG): HRESULT {.stdcall.}
    GetTimes*: proc(self: ptr IShellItemResources, pftCreation: ptr FILETIME, pftWrite: ptr FILETIME, pftAccess: ptr FILETIME): HRESULT {.stdcall.}
    SetTimes*: proc(self: ptr IShellItemResources, pftCreation: ptr FILETIME, pftWrite: ptr FILETIME, pftAccess: ptr FILETIME): HRESULT {.stdcall.}
    GetResourceDescription*: proc(self: ptr IShellItemResources, pcsir: ptr SHELL_ITEM_RESOURCE, ppszDescription: ptr LPWSTR): HRESULT {.stdcall.}
    EnumResources*: proc(self: ptr IShellItemResources, ppenumr: ptr ptr IEnumResources): HRESULT {.stdcall.}
    SupportsResource*: proc(self: ptr IShellItemResources, pcsir: ptr SHELL_ITEM_RESOURCE): HRESULT {.stdcall.}
    OpenResource*: proc(self: ptr IShellItemResources, pcsir: ptr SHELL_ITEM_RESOURCE, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    CreateResource*: proc(self: ptr IShellItemResources, pcsir: ptr SHELL_ITEM_RESOURCE, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    MarkForDelete*: proc(self: ptr IShellItemResources): HRESULT {.stdcall.}
  ITransferDestination* {.pure.} = object
    lpVtbl*: ptr ITransferDestinationVtbl
  ITransferDestinationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Advise*: proc(self: ptr ITransferDestination, psink: ptr ITransferAdviseSink, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr ITransferDestination, dwCookie: DWORD): HRESULT {.stdcall.}
    CreateItem*: proc(self: ptr ITransferDestination, pszName: LPCWSTR, dwAttributes: DWORD, ullSize: ULONGLONG, flags: TRANSFER_SOURCE_FLAGS, riidItem: REFIID, ppvItem: ptr pointer, riidResources: REFIID, ppvResources: ptr pointer): HRESULT {.stdcall.}
  IStreamAsync* {.pure.} = object
    lpVtbl*: ptr IStreamAsyncVtbl
  IStreamAsyncVtbl* {.pure, inheritable.} = object of IStreamVtbl
    ReadAsync*: proc(self: ptr IStreamAsync, pv: pointer, cb: DWORD, pcbRead: LPDWORD, lpOverlapped: LPOVERLAPPED): HRESULT {.stdcall.}
    WriteAsync*: proc(self: ptr IStreamAsync, lpBuffer: pointer, cb: DWORD, pcbWritten: LPDWORD, lpOverlapped: LPOVERLAPPED): HRESULT {.stdcall.}
    OverlappedResult*: proc(self: ptr IStreamAsync, lpOverlapped: LPOVERLAPPED, lpNumberOfBytesTransferred: LPDWORD, bWait: WINBOOL): HRESULT {.stdcall.}
    CancelIo*: proc(self: ptr IStreamAsync): HRESULT {.stdcall.}
  IStreamUnbufferedInfo* {.pure.} = object
    lpVtbl*: ptr IStreamUnbufferedInfoVtbl
  IStreamUnbufferedInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSectorSize*: proc(self: ptr IStreamUnbufferedInfo, pcbSectorSize: ptr ULONG): HRESULT {.stdcall.}
  IFileOperationProgressSink* {.pure.} = object
    lpVtbl*: ptr IFileOperationProgressSinkVtbl
  IFileOperationProgressSinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StartOperations*: proc(self: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
    FinishOperations*: proc(self: ptr IFileOperationProgressSink, hrResult: HRESULT): HRESULT {.stdcall.}
    PreRenameItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, pszNewName: LPCWSTR): HRESULT {.stdcall.}
    PostRenameItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, pszNewName: LPCWSTR, hrRename: HRESULT, psiNewlyCreated: ptr IShellItem): HRESULT {.stdcall.}
    PreMoveItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR): HRESULT {.stdcall.}
    PostMoveItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR, hrMove: HRESULT, psiNewlyCreated: ptr IShellItem): HRESULT {.stdcall.}
    PreCopyItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR): HRESULT {.stdcall.}
    PostCopyItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR, hrCopy: HRESULT, psiNewlyCreated: ptr IShellItem): HRESULT {.stdcall.}
    PreDeleteItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem): HRESULT {.stdcall.}
    PostDeleteItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, hrDelete: HRESULT, psiNewlyCreated: ptr IShellItem): HRESULT {.stdcall.}
    PreNewItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR): HRESULT {.stdcall.}
    PostNewItem*: proc(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR, pszTemplateName: LPCWSTR, dwFileAttributes: DWORD, hrNew: HRESULT, psiNewItem: ptr IShellItem): HRESULT {.stdcall.}
    UpdateProgress*: proc(self: ptr IFileOperationProgressSink, iWorkTotal: UINT, iWorkSoFar: UINT): HRESULT {.stdcall.}
    ResetTimer*: proc(self: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
    PauseTimer*: proc(self: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
    ResumeTimer*: proc(self: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
  IInitializeWithItem* {.pure.} = object
    lpVtbl*: ptr IInitializeWithItemVtbl
  IInitializeWithItemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeWithItem, psi: ptr IShellItem, grfMode: DWORD): HRESULT {.stdcall.}
  IObjectWithSelection* {.pure.} = object
    lpVtbl*: ptr IObjectWithSelectionVtbl
  IObjectWithSelectionVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetSelection*: proc(self: ptr IObjectWithSelection, psia: ptr IShellItemArray): HRESULT {.stdcall.}
    GetSelection*: proc(self: ptr IObjectWithSelection, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IObjectWithBackReferences* {.pure.} = object
    lpVtbl*: ptr IObjectWithBackReferencesVtbl
  IObjectWithBackReferencesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RemoveBackReferences*: proc(self: ptr IObjectWithBackReferences): HRESULT {.stdcall.}
  IPropertyUI* {.pure.} = object
    lpVtbl*: ptr IPropertyUIVtbl
  IPropertyUIVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParsePropertyName*: proc(self: ptr IPropertyUI, pszName: LPCWSTR, pfmtid: ptr FMTID, ppid: ptr PROPID, pchEaten: ptr ULONG): HRESULT {.stdcall.}
    GetCannonicalName*: proc(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pwszText: LPWSTR, cchText: DWORD): HRESULT {.stdcall.}
    GetDisplayName*: proc(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, flags: PROPERTYUI_NAME_FLAGS, pwszText: LPWSTR, cchText: DWORD): HRESULT {.stdcall.}
    GetPropertyDescription*: proc(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pwszText: LPWSTR, cchText: DWORD): HRESULT {.stdcall.}
    GetDefaultWidth*: proc(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pcxChars: ptr ULONG): HRESULT {.stdcall.}
    GetFlags*: proc(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pflags: ptr PROPERTYUI_FLAGS): HRESULT {.stdcall.}
    FormatForDisplay*: proc(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, ppropvar: ptr PROPVARIANT, puiff: PROPERTYUI_FORMAT_FLAGS, pwszText: LPWSTR, cchText: DWORD): HRESULT {.stdcall.}
    GetHelpInfo*: proc(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pwszHelpFile: LPWSTR, cch: DWORD, puHelpID: ptr UINT): HRESULT {.stdcall.}
  ICategoryProvider* {.pure.} = object
    lpVtbl*: ptr ICategoryProviderVtbl
  ICategoryProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CanCategorizeOnSCID*: proc(self: ptr ICategoryProvider, pscid: ptr SHCOLUMNID): HRESULT {.stdcall.}
    GetDefaultCategory*: proc(self: ptr ICategoryProvider, pguid: ptr GUID, pscid: ptr SHCOLUMNID): HRESULT {.stdcall.}
    GetCategoryForSCID*: proc(self: ptr ICategoryProvider, pscid: ptr SHCOLUMNID, pguid: ptr GUID): HRESULT {.stdcall.}
    EnumCategories*: proc(self: ptr ICategoryProvider, penum: ptr ptr IEnumGUID): HRESULT {.stdcall.}
    GetCategoryName*: proc(self: ptr ICategoryProvider, pguid: ptr GUID, pszName: LPWSTR, cch: UINT): HRESULT {.stdcall.}
    CreateCategory*: proc(self: ptr ICategoryProvider, pguid: ptr GUID, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  ICategorizer* {.pure.} = object
    lpVtbl*: ptr ICategorizerVtbl
  ICategorizerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDescription*: proc(self: ptr ICategorizer, pszDesc: LPWSTR, cch: UINT): HRESULT {.stdcall.}
    GetCategory*: proc(self: ptr ICategorizer, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, rgCategoryIds: ptr DWORD): HRESULT {.stdcall.}
    GetCategoryInfo*: proc(self: ptr ICategorizer, dwCategoryId: DWORD, pci: ptr TCATEGORY_INFO): HRESULT {.stdcall.}
    CompareCategory*: proc(self: ptr ICategorizer, csfFlags: CATSORT_FLAGS, dwCategoryId1: DWORD, dwCategoryId2: DWORD): HRESULT {.stdcall.}
  IDropTargetHelper* {.pure.} = object
    lpVtbl*: ptr IDropTargetHelperVtbl
  IDropTargetHelperVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    DragEnter*: proc(self: ptr IDropTargetHelper, hwndTarget: HWND, pDataObject: ptr IDataObject, ppt: ptr POINT, dwEffect: DWORD): HRESULT {.stdcall.}
    DragLeave*: proc(self: ptr IDropTargetHelper): HRESULT {.stdcall.}
    DragOver*: proc(self: ptr IDropTargetHelper, ppt: ptr POINT, dwEffect: DWORD): HRESULT {.stdcall.}
    Drop*: proc(self: ptr IDropTargetHelper, pDataObject: ptr IDataObject, ppt: ptr POINT, dwEffect: DWORD): HRESULT {.stdcall.}
    Show*: proc(self: ptr IDropTargetHelper, fShow: WINBOOL): HRESULT {.stdcall.}
  IDragSourceHelper* {.pure.} = object
    lpVtbl*: ptr IDragSourceHelperVtbl
  IDragSourceHelperVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InitializeFromBitmap*: proc(self: ptr IDragSourceHelper, pshdi: LPSHDRAGIMAGE, pDataObject: ptr IDataObject): HRESULT {.stdcall.}
    InitializeFromWindow*: proc(self: ptr IDragSourceHelper, hwnd: HWND, ppt: ptr POINT, pDataObject: ptr IDataObject): HRESULT {.stdcall.}
  IDragSourceHelper2* {.pure.} = object
    lpVtbl*: ptr IDragSourceHelper2Vtbl
  IDragSourceHelper2Vtbl* {.pure, inheritable.} = object of IDragSourceHelperVtbl
    SetFlags*: proc(self: ptr IDragSourceHelper2, dwFlags: DWORD): HRESULT {.stdcall.}
  IShellLinkDataList* {.pure.} = object
    lpVtbl*: ptr IShellLinkDataListVtbl
  IShellLinkDataListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddDataBlock*: proc(self: ptr IShellLinkDataList, pDataBlock: pointer): HRESULT {.stdcall.}
    CopyDataBlock*: proc(self: ptr IShellLinkDataList, dwSig: DWORD, ppDataBlock: ptr pointer): HRESULT {.stdcall.}
    RemoveDataBlock*: proc(self: ptr IShellLinkDataList, dwSig: DWORD): HRESULT {.stdcall.}
    GetFlags*: proc(self: ptr IShellLinkDataList, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
    SetFlags*: proc(self: ptr IShellLinkDataList, dwFlags: DWORD): HRESULT {.stdcall.}
  IResolveShellLink* {.pure.} = object
    lpVtbl*: ptr IResolveShellLinkVtbl
  IResolveShellLinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ResolveShellLink*: proc(self: ptr IResolveShellLink, punkLink: ptr IUnknown, hwnd: HWND, fFlags: DWORD): HRESULT {.stdcall.}
  IActionProgressDialog* {.pure.} = object
    lpVtbl*: ptr IActionProgressDialogVtbl
  IActionProgressDialogVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IActionProgressDialog, flags: SPINITF, pszTitle: LPCWSTR, pszCancel: LPCWSTR): HRESULT {.stdcall.}
    Stop*: proc(self: ptr IActionProgressDialog): HRESULT {.stdcall.}
  IHWEventHandler* {.pure.} = object
    lpVtbl*: ptr IHWEventHandlerVtbl
  IHWEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IHWEventHandler, pszParams: LPCWSTR): HRESULT {.stdcall.}
    HandleEvent*: proc(self: ptr IHWEventHandler, pszDeviceID: LPCWSTR, pszAltDeviceID: LPCWSTR, pszEventType: LPCWSTR): HRESULT {.stdcall.}
    HandleEventWithContent*: proc(self: ptr IHWEventHandler, pszDeviceID: LPCWSTR, pszAltDeviceID: LPCWSTR, pszEventType: LPCWSTR, pszContentTypeHandler: LPCWSTR, pdataobject: ptr IDataObject): HRESULT {.stdcall.}
  IHWEventHandler2* {.pure.} = object
    lpVtbl*: ptr IHWEventHandler2Vtbl
  IHWEventHandler2Vtbl* {.pure, inheritable.} = object of IHWEventHandlerVtbl
    HandleEventWithHWND*: proc(self: ptr IHWEventHandler2, pszDeviceID: LPCWSTR, pszAltDeviceID: LPCWSTR, pszEventType: LPCWSTR, hwndOwner: HWND): HRESULT {.stdcall.}
  IQueryCancelAutoPlay* {.pure.} = object
    lpVtbl*: ptr IQueryCancelAutoPlayVtbl
  IQueryCancelAutoPlayVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AllowAutoPlay*: proc(self: ptr IQueryCancelAutoPlay, pszPath: LPCWSTR, dwContentType: DWORD, pszLabel: LPCWSTR, dwSerialNumber: DWORD): HRESULT {.stdcall.}
  IDynamicHWHandler* {.pure.} = object
    lpVtbl*: ptr IDynamicHWHandlerVtbl
  IDynamicHWHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDynamicInfo*: proc(self: ptr IDynamicHWHandler, pszDeviceID: LPCWSTR, dwContentType: DWORD, ppszAction: ptr LPWSTR): HRESULT {.stdcall.}
  IActionProgress* {.pure.} = object
    lpVtbl*: ptr IActionProgressVtbl
  IActionProgressVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Begin*: proc(self: ptr IActionProgress, action: SPACTION, flags: SPBEGINF): HRESULT {.stdcall.}
    UpdateProgress*: proc(self: ptr IActionProgress, ulCompleted: ULONGLONG, ulTotal: ULONGLONG): HRESULT {.stdcall.}
    UpdateText*: proc(self: ptr IActionProgress, sptext: SPTEXT, pszText: LPCWSTR, fMayCompact: WINBOOL): HRESULT {.stdcall.}
    QueryCancel*: proc(self: ptr IActionProgress, pfCancelled: ptr WINBOOL): HRESULT {.stdcall.}
    ResetCancel*: proc(self: ptr IActionProgress): HRESULT {.stdcall.}
    End*: proc(self: ptr IActionProgress): HRESULT {.stdcall.}
  IRemoteComputer* {.pure.} = object
    lpVtbl*: ptr IRemoteComputerVtbl
  IRemoteComputerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IRemoteComputer, pszMachine: LPCWSTR, bEnumerating: WINBOOL): HRESULT {.stdcall.}
  IQueryContinue* {.pure.} = object
    lpVtbl*: ptr IQueryContinueVtbl
  IQueryContinueVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryContinue*: proc(self: ptr IQueryContinue): HRESULT {.stdcall.}
  IObjectWithCancelEvent* {.pure.} = object
    lpVtbl*: ptr IObjectWithCancelEventVtbl
  IObjectWithCancelEventVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCancelEvent*: proc(self: ptr IObjectWithCancelEvent, phEvent: ptr HANDLE): HRESULT {.stdcall.}
  IUserNotification* {.pure.} = object
    lpVtbl*: ptr IUserNotificationVtbl
  IUserNotificationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetBalloonInfo*: proc(self: ptr IUserNotification, pszTitle: LPCWSTR, pszText: LPCWSTR, dwInfoFlags: DWORD): HRESULT {.stdcall.}
    SetBalloonRetry*: proc(self: ptr IUserNotification, dwShowTime: DWORD, dwInterval: DWORD, cRetryCount: UINT): HRESULT {.stdcall.}
    SetIconInfo*: proc(self: ptr IUserNotification, hIcon: HICON, pszToolTip: LPCWSTR): HRESULT {.stdcall.}
    Show*: proc(self: ptr IUserNotification, pqc: ptr IQueryContinue, dwContinuePollInterval: DWORD): HRESULT {.stdcall.}
    PlaySound*: proc(self: ptr IUserNotification, pszSoundName: LPCWSTR): HRESULT {.stdcall.}
  IUserNotificationCallback* {.pure.} = object
    lpVtbl*: ptr IUserNotificationCallbackVtbl
  IUserNotificationCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnBalloonUserClick*: proc(self: ptr IUserNotificationCallback, pt: ptr POINT): HRESULT {.stdcall.}
    OnLeftClick*: proc(self: ptr IUserNotificationCallback, pt: ptr POINT): HRESULT {.stdcall.}
    OnContextMenu*: proc(self: ptr IUserNotificationCallback, pt: ptr POINT): HRESULT {.stdcall.}
  IUserNotification2* {.pure.} = object
    lpVtbl*: ptr IUserNotification2Vtbl
  IUserNotification2Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetBalloonInfo*: proc(self: ptr IUserNotification2, pszTitle: LPCWSTR, pszText: LPCWSTR, dwInfoFlags: DWORD): HRESULT {.stdcall.}
    SetBalloonRetry*: proc(self: ptr IUserNotification2, dwShowTime: DWORD, dwInterval: DWORD, cRetryCount: UINT): HRESULT {.stdcall.}
    SetIconInfo*: proc(self: ptr IUserNotification2, hIcon: HICON, pszToolTip: LPCWSTR): HRESULT {.stdcall.}
    Show*: proc(self: ptr IUserNotification2, pqc: ptr IQueryContinue, dwContinuePollInterval: DWORD, pSink: ptr IUserNotificationCallback): HRESULT {.stdcall.}
    PlaySound*: proc(self: ptr IUserNotification2, pszSoundName: LPCWSTR): HRESULT {.stdcall.}
  IItemNameLimits* {.pure.} = object
    lpVtbl*: ptr IItemNameLimitsVtbl
  IItemNameLimitsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetValidCharacters*: proc(self: ptr IItemNameLimits, ppwszValidChars: ptr LPWSTR, ppwszInvalidChars: ptr LPWSTR): HRESULT {.stdcall.}
    GetMaxLength*: proc(self: ptr IItemNameLimits, pszName: LPCWSTR, piMaxNameLen: ptr int32): HRESULT {.stdcall.}
  ISearchFolderItemFactory* {.pure.} = object
    lpVtbl*: ptr ISearchFolderItemFactoryVtbl
  ISearchFolderItemFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetDisplayName*: proc(self: ptr ISearchFolderItemFactory, pszDisplayName: LPCWSTR): HRESULT {.stdcall.}
    SetFolderTypeID*: proc(self: ptr ISearchFolderItemFactory, ftid: FOLDERTYPEID): HRESULT {.stdcall.}
    SetFolderLogicalViewMode*: proc(self: ptr ISearchFolderItemFactory, flvm: FOLDERLOGICALVIEWMODE): HRESULT {.stdcall.}
    SetIconSize*: proc(self: ptr ISearchFolderItemFactory, iIconSize: int32): HRESULT {.stdcall.}
    SetVisibleColumns*: proc(self: ptr ISearchFolderItemFactory, cVisibleColumns: UINT, rgKey: ptr PROPERTYKEY): HRESULT {.stdcall.}
    SetSortColumns*: proc(self: ptr ISearchFolderItemFactory, cSortColumns: UINT, rgSortColumns: ptr SORTCOLUMN): HRESULT {.stdcall.}
    SetGroupColumn*: proc(self: ptr ISearchFolderItemFactory, keyGroup: REFPROPERTYKEY): HRESULT {.stdcall.}
    SetStacks*: proc(self: ptr ISearchFolderItemFactory, cStackKeys: UINT, rgStackKeys: ptr PROPERTYKEY): HRESULT {.stdcall.}
    SetScope*: proc(self: ptr ISearchFolderItemFactory, psiaScope: ptr IShellItemArray): HRESULT {.stdcall.}
    SetCondition*: proc(self: ptr ISearchFolderItemFactory, pCondition: ptr ICondition): HRESULT {.stdcall.}
    GetShellItem*: proc(self: ptr ISearchFolderItemFactory, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetIDList*: proc(self: ptr ISearchFolderItemFactory, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.stdcall.}
  IThumbnailHandlerFactory* {.pure.} = object
    lpVtbl*: ptr IThumbnailHandlerFactoryVtbl
  IThumbnailHandlerFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetThumbnailHandler*: proc(self: ptr IThumbnailHandlerFactory, pidlChild: PCUITEMID_CHILD, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IParentAndItem* {.pure.} = object
    lpVtbl*: ptr IParentAndItemVtbl
  IParentAndItemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetParentAndItem*: proc(self: ptr IParentAndItem, pidlParent: PCIDLIST_ABSOLUTE, psf: ptr IShellFolder, pidlChild: PCUITEMID_CHILD): HRESULT {.stdcall.}
    GetParentAndItem*: proc(self: ptr IParentAndItem, ppidlParent: ptr PIDLIST_ABSOLUTE, ppsf: ptr ptr IShellFolder, ppidlChild: ptr PITEMID_CHILD): HRESULT {.stdcall.}
  IDockingWindow* {.pure.} = object
    lpVtbl*: ptr IDockingWindowVtbl
  IDockingWindowVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    ShowDW*: proc(self: ptr IDockingWindow, fShow: WINBOOL): HRESULT {.stdcall.}
    CloseDW*: proc(self: ptr IDockingWindow, dwReserved: DWORD): HRESULT {.stdcall.}
    ResizeBorderDW*: proc(self: ptr IDockingWindow, prcBorder: LPCRECT, punkToolbarSite: ptr IUnknown, fReserved: WINBOOL): HRESULT {.stdcall.}
  IDeskBand* {.pure.} = object
    lpVtbl*: ptr IDeskBandVtbl
  IDeskBandVtbl* {.pure, inheritable.} = object of IDockingWindowVtbl
    GetBandInfo*: proc(self: ptr IDeskBand, dwBandID: DWORD, dwViewMode: DWORD, pdbi: ptr DESKBANDINFO): HRESULT {.stdcall.}
  IDeskBandInfo* {.pure.} = object
    lpVtbl*: ptr IDeskBandInfoVtbl
  IDeskBandInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDefaultBandWidth*: proc(self: ptr IDeskBandInfo, dwBandID: DWORD, dwViewMode: DWORD, pnWidth: ptr int32): HRESULT {.stdcall.}
  IDeskBand2* {.pure.} = object
    lpVtbl*: ptr IDeskBand2Vtbl
  IDeskBand2Vtbl* {.pure, inheritable.} = object of IDeskBandVtbl
    CanRenderComposited*: proc(self: ptr IDeskBand2, pfCanRenderComposited: ptr WINBOOL): HRESULT {.stdcall.}
    SetCompositionState*: proc(self: ptr IDeskBand2, fCompositionEnabled: WINBOOL): HRESULT {.stdcall.}
    GetCompositionState*: proc(self: ptr IDeskBand2, pfCompositionEnabled: ptr WINBOOL): HRESULT {.stdcall.}
  ITaskbarList* {.pure.} = object
    lpVtbl*: ptr ITaskbarListVtbl
  ITaskbarListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HrInit*: proc(self: ptr ITaskbarList): HRESULT {.stdcall.}
    AddTab*: proc(self: ptr ITaskbarList, hwnd: HWND): HRESULT {.stdcall.}
    DeleteTab*: proc(self: ptr ITaskbarList, hwnd: HWND): HRESULT {.stdcall.}
    ActivateTab*: proc(self: ptr ITaskbarList, hwnd: HWND): HRESULT {.stdcall.}
    SetActiveAlt*: proc(self: ptr ITaskbarList, hwnd: HWND): HRESULT {.stdcall.}
  ITaskbarList2* {.pure.} = object
    lpVtbl*: ptr ITaskbarList2Vtbl
  ITaskbarList2Vtbl* {.pure, inheritable.} = object of ITaskbarListVtbl
    MarkFullscreenWindow*: proc(self: ptr ITaskbarList2, hwnd: HWND, fFullscreen: WINBOOL): HRESULT {.stdcall.}
  ITaskbarList3* {.pure.} = object
    lpVtbl*: ptr ITaskbarList3Vtbl
  ITaskbarList3Vtbl* {.pure, inheritable.} = object of ITaskbarList2Vtbl
    SetProgressValue*: proc(self: ptr ITaskbarList3, hwnd: HWND, ullCompleted: ULONGLONG, ullTotal: ULONGLONG): HRESULT {.stdcall.}
    SetProgressState*: proc(self: ptr ITaskbarList3, hwnd: HWND, tbpFlags: TBPFLAG): HRESULT {.stdcall.}
    RegisterTab*: proc(self: ptr ITaskbarList3, hwndTab: HWND, hwndMDI: HWND): HRESULT {.stdcall.}
    UnregisterTab*: proc(self: ptr ITaskbarList3, hwndTab: HWND): HRESULT {.stdcall.}
    SetTabOrder*: proc(self: ptr ITaskbarList3, hwndTab: HWND, hwndInsertBefore: HWND): HRESULT {.stdcall.}
    SetTabActive*: proc(self: ptr ITaskbarList3, hwndTab: HWND, hwndMDI: HWND, dwReserved: DWORD): HRESULT {.stdcall.}
    ThumbBarAddButtons*: proc(self: ptr ITaskbarList3, hwnd: HWND, cButtons: UINT, pButton: LPTHUMBBUTTON): HRESULT {.stdcall.}
    ThumbBarUpdateButtons*: proc(self: ptr ITaskbarList3, hwnd: HWND, cButtons: UINT, pButton: LPTHUMBBUTTON): HRESULT {.stdcall.}
    ThumbBarSetImageList*: proc(self: ptr ITaskbarList3, hwnd: HWND, himl: HIMAGELIST): HRESULT {.stdcall.}
    SetOverlayIcon*: proc(self: ptr ITaskbarList3, hwnd: HWND, hIcon: HICON, pszDescription: LPCWSTR): HRESULT {.stdcall.}
    SetThumbnailTooltip*: proc(self: ptr ITaskbarList3, hwnd: HWND, pszTip: LPCWSTR): HRESULT {.stdcall.}
    SetThumbnailClip*: proc(self: ptr ITaskbarList3, hwnd: HWND, prcClip: ptr RECT): HRESULT {.stdcall.}
  ITaskbarList4* {.pure.} = object
    lpVtbl*: ptr ITaskbarList4Vtbl
  ITaskbarList4Vtbl* {.pure, inheritable.} = object of ITaskbarList3Vtbl
    SetTabProperties*: proc(self: ptr ITaskbarList4, hwndTab: HWND, stpFlags: STPFLAG): HRESULT {.stdcall.}
  IStartMenuPinnedList* {.pure.} = object
    lpVtbl*: ptr IStartMenuPinnedListVtbl
  IStartMenuPinnedListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RemoveFromList*: proc(self: ptr IStartMenuPinnedList, pitem: ptr IShellItem): HRESULT {.stdcall.}
  ICDBurn* {.pure.} = object
    lpVtbl*: ptr ICDBurnVtbl
  ICDBurnVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetRecorderDriveLetter*: proc(self: ptr ICDBurn, pszDrive: LPWSTR, cch: UINT): HRESULT {.stdcall.}
    Burn*: proc(self: ptr ICDBurn, hwnd: HWND): HRESULT {.stdcall.}
    HasRecordableDrive*: proc(self: ptr ICDBurn, pfHasRecorder: ptr WINBOOL): HRESULT {.stdcall.}
  IWizardSite* {.pure.} = object
    lpVtbl*: ptr IWizardSiteVtbl
  IWizardSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPreviousPage*: proc(self: ptr IWizardSite, phpage: ptr HPROPSHEETPAGE): HRESULT {.stdcall.}
    GetNextPage*: proc(self: ptr IWizardSite, phpage: ptr HPROPSHEETPAGE): HRESULT {.stdcall.}
    GetCancelledPage*: proc(self: ptr IWizardSite, phpage: ptr HPROPSHEETPAGE): HRESULT {.stdcall.}
  IWizardExtension* {.pure.} = object
    lpVtbl*: ptr IWizardExtensionVtbl
  IWizardExtensionVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddPages*: proc(self: ptr IWizardExtension, aPages: ptr HPROPSHEETPAGE, cPages: UINT, pnPagesAdded: ptr UINT): HRESULT {.stdcall.}
    GetFirstPage*: proc(self: ptr IWizardExtension, phpage: ptr HPROPSHEETPAGE): HRESULT {.stdcall.}
    GetLastPage*: proc(self: ptr IWizardExtension, phpage: ptr HPROPSHEETPAGE): HRESULT {.stdcall.}
  IWebWizardExtension* {.pure.} = object
    lpVtbl*: ptr IWebWizardExtensionVtbl
  IWebWizardExtensionVtbl* {.pure, inheritable.} = object of IWizardExtensionVtbl
    SetInitialURL*: proc(self: ptr IWebWizardExtension, pszURL: LPCWSTR): HRESULT {.stdcall.}
    SetErrorURL*: proc(self: ptr IWebWizardExtension, pszErrorURL: LPCWSTR): HRESULT {.stdcall.}
  IPublishingWizard* {.pure.} = object
    lpVtbl*: ptr IPublishingWizardVtbl
  IPublishingWizardVtbl* {.pure, inheritable.} = object of IWizardExtensionVtbl
    Initialize*: proc(self: ptr IPublishingWizard, pdo: ptr IDataObject, dwOptions: DWORD, pszServiceScope: LPCWSTR): HRESULT {.stdcall.}
    GetTransferManifest*: proc(self: ptr IPublishingWizard, phrFromTransfer: ptr HRESULT, pdocManifest: ptr ptr IXMLDOMDocument): HRESULT {.stdcall.}
  IFolderViewHost* {.pure.} = object
    lpVtbl*: ptr IFolderViewHostVtbl
  IFolderViewHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IFolderViewHost, hwndParent: HWND, pdo: ptr IDataObject, prc: ptr RECT): HRESULT {.stdcall.}
  IExplorerBrowserEvents* {.pure.} = object
    lpVtbl*: ptr IExplorerBrowserEventsVtbl
  IExplorerBrowserEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnNavigationPending*: proc(self: ptr IExplorerBrowserEvents, pidlFolder: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    OnViewCreated*: proc(self: ptr IExplorerBrowserEvents, psv: ptr IShellView): HRESULT {.stdcall.}
    OnNavigationComplete*: proc(self: ptr IExplorerBrowserEvents, pidlFolder: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    OnNavigationFailed*: proc(self: ptr IExplorerBrowserEvents, pidlFolder: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
  IExplorerBrowser* {.pure.} = object
    lpVtbl*: ptr IExplorerBrowserVtbl
  IExplorerBrowserVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IExplorerBrowser, hwndParent: HWND, prc: ptr RECT, pfs: ptr FOLDERSETTINGS): HRESULT {.stdcall.}
    Destroy*: proc(self: ptr IExplorerBrowser): HRESULT {.stdcall.}
    SetRect*: proc(self: ptr IExplorerBrowser, phdwp: ptr HDWP, rcBrowser: RECT): HRESULT {.stdcall.}
    SetPropertyBag*: proc(self: ptr IExplorerBrowser, pszPropertyBag: LPCWSTR): HRESULT {.stdcall.}
    SetEmptyText*: proc(self: ptr IExplorerBrowser, pszEmptyText: LPCWSTR): HRESULT {.stdcall.}
    SetFolderSettings*: proc(self: ptr IExplorerBrowser, pfs: ptr FOLDERSETTINGS): HRESULT {.stdcall.}
    Advise*: proc(self: ptr IExplorerBrowser, psbe: ptr IExplorerBrowserEvents, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IExplorerBrowser, dwCookie: DWORD): HRESULT {.stdcall.}
    SetOptions*: proc(self: ptr IExplorerBrowser, dwFlag: EXPLORER_BROWSER_OPTIONS): HRESULT {.stdcall.}
    GetOptions*: proc(self: ptr IExplorerBrowser, pdwFlag: ptr EXPLORER_BROWSER_OPTIONS): HRESULT {.stdcall.}
    BrowseToIDList*: proc(self: ptr IExplorerBrowser, pidl: PCUIDLIST_RELATIVE, uFlags: UINT): HRESULT {.stdcall.}
    BrowseToObject*: proc(self: ptr IExplorerBrowser, punk: ptr IUnknown, uFlags: UINT): HRESULT {.stdcall.}
    FillFromObject*: proc(self: ptr IExplorerBrowser, punk: ptr IUnknown, dwFlags: EXPLORER_BROWSER_FILL_FLAGS): HRESULT {.stdcall.}
    RemoveAll*: proc(self: ptr IExplorerBrowser): HRESULT {.stdcall.}
    GetCurrentView*: proc(self: ptr IExplorerBrowser, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IAccessibleObject* {.pure.} = object
    lpVtbl*: ptr IAccessibleObjectVtbl
  IAccessibleObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetAccessibleName*: proc(self: ptr IAccessibleObject, pszName: LPCWSTR): HRESULT {.stdcall.}
  IResultsFolder* {.pure.} = object
    lpVtbl*: ptr IResultsFolderVtbl
  IResultsFolderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddItem*: proc(self: ptr IResultsFolder, psi: ptr IShellItem): HRESULT {.stdcall.}
    AddIDList*: proc(self: ptr IResultsFolder, pidl: PCIDLIST_ABSOLUTE, ppidlAdded: ptr PITEMID_CHILD): HRESULT {.stdcall.}
    RemoveItem*: proc(self: ptr IResultsFolder, psi: ptr IShellItem): HRESULT {.stdcall.}
    RemoveIDList*: proc(self: ptr IResultsFolder, pidl: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    RemoveAll*: proc(self: ptr IResultsFolder): HRESULT {.stdcall.}
  IEnumObjects* {.pure.} = object
    lpVtbl*: ptr IEnumObjectsVtbl
  IEnumObjectsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumObjects, celt: ULONG, riid: REFIID, rgelt: ptr pointer, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumObjects, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumObjects): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumObjects, ppenum: ptr ptr IEnumObjects): HRESULT {.stdcall.}
  IOperationsProgressDialog* {.pure.} = object
    lpVtbl*: ptr IOperationsProgressDialogVtbl
  IOperationsProgressDialogVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StartProgressDialog*: proc(self: ptr IOperationsProgressDialog, hwndOwner: HWND, flags: OPPROGDLGF): HRESULT {.stdcall.}
    StopProgressDialog*: proc(self: ptr IOperationsProgressDialog): HRESULT {.stdcall.}
    SetOperation*: proc(self: ptr IOperationsProgressDialog, action: SPACTION): HRESULT {.stdcall.}
    SetMode*: proc(self: ptr IOperationsProgressDialog, mode: PDMODE): HRESULT {.stdcall.}
    UpdateProgress*: proc(self: ptr IOperationsProgressDialog, ullPointsCurrent: ULONGLONG, ullPointsTotal: ULONGLONG, ullSizeCurrent: ULONGLONG, ullSizeTotal: ULONGLONG, ullItemsCurrent: ULONGLONG, ullItemsTotal: ULONGLONG): HRESULT {.stdcall.}
    UpdateLocations*: proc(self: ptr IOperationsProgressDialog, psiSource: ptr IShellItem, psiTarget: ptr IShellItem, psiItem: ptr IShellItem): HRESULT {.stdcall.}
    ResetTimer*: proc(self: ptr IOperationsProgressDialog): HRESULT {.stdcall.}
    PauseTimer*: proc(self: ptr IOperationsProgressDialog): HRESULT {.stdcall.}
    ResumeTimer*: proc(self: ptr IOperationsProgressDialog): HRESULT {.stdcall.}
    GetMilliseconds*: proc(self: ptr IOperationsProgressDialog, pullElapsed: ptr ULONGLONG, pullRemaining: ptr ULONGLONG): HRESULT {.stdcall.}
    GetOperationStatus*: proc(self: ptr IOperationsProgressDialog, popstatus: ptr PDOPSTATUS): HRESULT {.stdcall.}
  IIOCancelInformation* {.pure.} = object
    lpVtbl*: ptr IIOCancelInformationVtbl
  IIOCancelInformationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetCancelInformation*: proc(self: ptr IIOCancelInformation, dwThreadID: DWORD, uMsgCancel: UINT): HRESULT {.stdcall.}
    GetCancelInformation*: proc(self: ptr IIOCancelInformation, pdwThreadID: ptr DWORD, puMsgCancel: ptr UINT): HRESULT {.stdcall.}
  IFileOperation* {.pure.} = object
    lpVtbl*: ptr IFileOperationVtbl
  IFileOperationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Advise*: proc(self: ptr IFileOperation, pfops: ptr IFileOperationProgressSink, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IFileOperation, dwCookie: DWORD): HRESULT {.stdcall.}
    SetOperationFlags*: proc(self: ptr IFileOperation, dwOperationFlags: DWORD): HRESULT {.stdcall.}
    SetProgressMessage*: proc(self: ptr IFileOperation, pszMessage: LPCWSTR): HRESULT {.stdcall.}
    SetProgressDialog*: proc(self: ptr IFileOperation, popd: ptr IOperationsProgressDialog): HRESULT {.stdcall.}
    SetProperties*: proc(self: ptr IFileOperation, pproparray: ptr IPropertyChangeArray): HRESULT {.stdcall.}
    SetOwnerWindow*: proc(self: ptr IFileOperation, hwndOwner: HWND): HRESULT {.stdcall.}
    ApplyPropertiesToItem*: proc(self: ptr IFileOperation, psiItem: ptr IShellItem): HRESULT {.stdcall.}
    ApplyPropertiesToItems*: proc(self: ptr IFileOperation, punkItems: ptr IUnknown): HRESULT {.stdcall.}
    RenameItem*: proc(self: ptr IFileOperation, psiItem: ptr IShellItem, pszNewName: LPCWSTR, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
    RenameItems*: proc(self: ptr IFileOperation, pUnkItems: ptr IUnknown, pszNewName: LPCWSTR): HRESULT {.stdcall.}
    MoveItem*: proc(self: ptr IFileOperation, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
    MoveItems*: proc(self: ptr IFileOperation, punkItems: ptr IUnknown, psiDestinationFolder: ptr IShellItem): HRESULT {.stdcall.}
    CopyItem*: proc(self: ptr IFileOperation, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszCopyName: LPCWSTR, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
    CopyItems*: proc(self: ptr IFileOperation, punkItems: ptr IUnknown, psiDestinationFolder: ptr IShellItem): HRESULT {.stdcall.}
    DeleteItem*: proc(self: ptr IFileOperation, psiItem: ptr IShellItem, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
    DeleteItems*: proc(self: ptr IFileOperation, punkItems: ptr IUnknown): HRESULT {.stdcall.}
    NewItem*: proc(self: ptr IFileOperation, psiDestinationFolder: ptr IShellItem, dwFileAttributes: DWORD, pszName: LPCWSTR, pszTemplateName: LPCWSTR, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
    PerformOperations*: proc(self: ptr IFileOperation): HRESULT {.stdcall.}
    GetAnyOperationsAborted*: proc(self: ptr IFileOperation, pfAnyOperationsAborted: ptr WINBOOL): HRESULT {.stdcall.}
  IObjectProvider* {.pure.} = object
    lpVtbl*: ptr IObjectProviderVtbl
  IObjectProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryObject*: proc(self: ptr IObjectProvider, guidObject: REFGUID, riid: REFIID, ppvOut: ptr pointer): HRESULT {.stdcall.}
  INamespaceWalkCB* {.pure.} = object
    lpVtbl*: ptr INamespaceWalkCBVtbl
  INamespaceWalkCBVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FoundItem*: proc(self: ptr INamespaceWalkCB, psf: ptr IShellFolder, pidl: PCUITEMID_CHILD): HRESULT {.stdcall.}
    EnterFolder*: proc(self: ptr INamespaceWalkCB, psf: ptr IShellFolder, pidl: PCUITEMID_CHILD): HRESULT {.stdcall.}
    LeaveFolder*: proc(self: ptr INamespaceWalkCB, psf: ptr IShellFolder, pidl: PCUITEMID_CHILD): HRESULT {.stdcall.}
    InitializeProgressDialog*: proc(self: ptr INamespaceWalkCB, ppszTitle: ptr LPWSTR, ppszCancel: ptr LPWSTR): HRESULT {.stdcall.}
  INamespaceWalkCB2* {.pure.} = object
    lpVtbl*: ptr INamespaceWalkCB2Vtbl
  INamespaceWalkCB2Vtbl* {.pure, inheritable.} = object of INamespaceWalkCBVtbl
    WalkComplete*: proc(self: ptr INamespaceWalkCB2, hr: HRESULT): HRESULT {.stdcall.}
  INamespaceWalk* {.pure.} = object
    lpVtbl*: ptr INamespaceWalkVtbl
  INamespaceWalkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Walk*: proc(self: ptr INamespaceWalk, punkToWalk: ptr IUnknown, dwFlags: DWORD, cDepth: int32, pnswcb: ptr INamespaceWalkCB): HRESULT {.stdcall.}
    GetIDArrayResult*: proc(self: ptr INamespaceWalk, pcItems: ptr UINT, prgpidl: ptr ptr PIDLIST_ABSOLUTE): HRESULT {.stdcall.}
  IAutoCompleteDropDown* {.pure.} = object
    lpVtbl*: ptr IAutoCompleteDropDownVtbl
  IAutoCompleteDropDownVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDropDownStatus*: proc(self: ptr IAutoCompleteDropDown, pdwFlags: ptr DWORD, ppwszString: ptr LPWSTR): HRESULT {.stdcall.}
    ResetEnumerator*: proc(self: ptr IAutoCompleteDropDown): HRESULT {.stdcall.}
  IBandSite* {.pure.} = object
    lpVtbl*: ptr IBandSiteVtbl
  IBandSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddBand*: proc(self: ptr IBandSite, punk: ptr IUnknown): HRESULT {.stdcall.}
    EnumBands*: proc(self: ptr IBandSite, uBand: UINT, pdwBandID: ptr DWORD): HRESULT {.stdcall.}
    QueryBand*: proc(self: ptr IBandSite, dwBandID: DWORD, ppstb: ptr ptr IDeskBand, pdwState: ptr DWORD, pszName: LPWSTR, cchName: int32): HRESULT {.stdcall.}
    SetBandState*: proc(self: ptr IBandSite, dwBandID: DWORD, dwMask: DWORD, dwState: DWORD): HRESULT {.stdcall.}
    RemoveBand*: proc(self: ptr IBandSite, dwBandID: DWORD): HRESULT {.stdcall.}
    GetBandObject*: proc(self: ptr IBandSite, dwBandID: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    SetBandSiteInfo*: proc(self: ptr IBandSite, pbsinfo: ptr BANDSITEINFO): HRESULT {.stdcall.}
    GetBandSiteInfo*: proc(self: ptr IBandSite, pbsinfo: ptr BANDSITEINFO): HRESULT {.stdcall.}
  IModalWindow* {.pure.} = object
    lpVtbl*: ptr IModalWindowVtbl
  IModalWindowVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Show*: proc(self: ptr IModalWindow, hwndOwner: HWND): HRESULT {.stdcall.}
  ICDBurnExt* {.pure.} = object
    lpVtbl*: ptr ICDBurnExtVtbl
  ICDBurnExtVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSupportedActionTypes*: proc(self: ptr ICDBurnExt, pdwActions: ptr CDBE_ACTIONS): HRESULT {.stdcall.}
  IContextMenuSite* {.pure.} = object
    lpVtbl*: ptr IContextMenuSiteVtbl
  IContextMenuSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    DoContextMenuPopup*: proc(self: ptr IContextMenuSite, punkContextMenu: ptr IUnknown, fFlags: UINT, pt: POINT): HRESULT {.stdcall.}
  IEnumReadyCallback* {.pure.} = object
    lpVtbl*: ptr IEnumReadyCallbackVtbl
  IEnumReadyCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EnumReady*: proc(self: ptr IEnumReadyCallback): HRESULT {.stdcall.}
  IEnumerableView* {.pure.} = object
    lpVtbl*: ptr IEnumerableViewVtbl
  IEnumerableViewVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetEnumReadyCallback*: proc(self: ptr IEnumerableView, percb: ptr IEnumReadyCallback): HRESULT {.stdcall.}
    CreateEnumIDListFromContents*: proc(self: ptr IEnumerableView, pidlFolder: PCIDLIST_ABSOLUTE, dwEnumFlags: DWORD, ppEnumIDList: ptr ptr IEnumIDList): HRESULT {.stdcall.}
  IInsertItem* {.pure.} = object
    lpVtbl*: ptr IInsertItemVtbl
  IInsertItemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InsertItem*: proc(self: ptr IInsertItem, pidl: PCUIDLIST_RELATIVE): HRESULT {.stdcall.}
  IMenuBand* {.pure.} = object
    lpVtbl*: ptr IMenuBandVtbl
  IMenuBandVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IsMenuMessage*: proc(self: ptr IMenuBand, pmsg: ptr MSG): HRESULT {.stdcall.}
    TranslateMenuMessage*: proc(self: ptr IMenuBand, pmsg: ptr MSG, plRet: ptr LRESULT): HRESULT {.stdcall.}
  IFolderBandPriv* {.pure.} = object
    lpVtbl*: ptr IFolderBandPrivVtbl
  IFolderBandPrivVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetCascade*: proc(self: ptr IFolderBandPriv, fCascade: WINBOOL): HRESULT {.stdcall.}
    SetAccelerators*: proc(self: ptr IFolderBandPriv, fAccelerators: WINBOOL): HRESULT {.stdcall.}
    SetNoIcons*: proc(self: ptr IFolderBandPriv, fNoIcons: WINBOOL): HRESULT {.stdcall.}
    SetNoText*: proc(self: ptr IFolderBandPriv, fNoText: WINBOOL): HRESULT {.stdcall.}
  IRegTreeItem* {.pure.} = object
    lpVtbl*: ptr IRegTreeItemVtbl
  IRegTreeItemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCheckState*: proc(self: ptr IRegTreeItem, pbCheck: ptr WINBOOL): HRESULT {.stdcall.}
    SetCheckState*: proc(self: ptr IRegTreeItem, bCheck: WINBOOL): HRESULT {.stdcall.}
  IImageRecompress* {.pure.} = object
    lpVtbl*: ptr IImageRecompressVtbl
  IImageRecompressVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RecompressImage*: proc(self: ptr IImageRecompress, psi: ptr IShellItem, cx: int32, cy: int32, iQuality: int32, pstg: ptr IStorage, ppstrmOut: ptr ptr IStream): HRESULT {.stdcall.}
  IDeskBar* {.pure.} = object
    lpVtbl*: ptr IDeskBarVtbl
  IDeskBarVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    SetClient*: proc(self: ptr IDeskBar, punkClient: ptr IUnknown): HRESULT {.stdcall.}
    GetClient*: proc(self: ptr IDeskBar, ppunkClient: ptr ptr IUnknown): HRESULT {.stdcall.}
    OnPosRectChangeDB*: proc(self: ptr IDeskBar, prc: ptr RECT): HRESULT {.stdcall.}
  IMenuPopup* {.pure.} = object
    lpVtbl*: ptr IMenuPopupVtbl
  IMenuPopupVtbl* {.pure, inheritable.} = object of IDeskBarVtbl
    Popup*: proc(self: ptr IMenuPopup, ppt: ptr POINTL, prcExclude: ptr RECTL, dwFlags: MP_POPUPFLAGS): HRESULT {.stdcall.}
    OnSelect*: proc(self: ptr IMenuPopup, dwSelectType: DWORD): HRESULT {.stdcall.}
    SetSubMenu*: proc(self: ptr IMenuPopup, pmp: ptr IMenuPopup, fSet: WINBOOL): HRESULT {.stdcall.}
  IFileIsInUse* {.pure.} = object
    lpVtbl*: ptr IFileIsInUseVtbl
  IFileIsInUseVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetAppName*: proc(self: ptr IFileIsInUse, ppszName: ptr LPWSTR): HRESULT {.stdcall.}
    GetUsage*: proc(self: ptr IFileIsInUse, pfut: ptr FILE_USAGE_TYPE): HRESULT {.stdcall.}
    GetCapabilities*: proc(self: ptr IFileIsInUse, pdwCapFlags: ptr DWORD): HRESULT {.stdcall.}
    GetSwitchToHWND*: proc(self: ptr IFileIsInUse, phwnd: ptr HWND): HRESULT {.stdcall.}
    CloseFile*: proc(self: ptr IFileIsInUse): HRESULT {.stdcall.}
  IShellItemFilter* {.pure.} = object
    lpVtbl*: ptr IShellItemFilterVtbl
  IShellItemFilterVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IncludeItem*: proc(self: ptr IShellItemFilter, psi: ptr IShellItem): HRESULT {.stdcall.}
    GetEnumFlagsForItem*: proc(self: ptr IShellItemFilter, psi: ptr IShellItem, pgrfFlags: ptr SHCONTF): HRESULT {.stdcall.}
  IFileDialog* {.pure.} = object
    lpVtbl*: ptr IFileDialogVtbl
  IFileDialogVtbl* {.pure, inheritable.} = object of IModalWindowVtbl
    SetFileTypes*: proc(self: ptr IFileDialog, cFileTypes: UINT, rgFilterSpec: ptr COMDLG_FILTERSPEC): HRESULT {.stdcall.}
    SetFileTypeIndex*: proc(self: ptr IFileDialog, iFileType: UINT): HRESULT {.stdcall.}
    GetFileTypeIndex*: proc(self: ptr IFileDialog, piFileType: ptr UINT): HRESULT {.stdcall.}
    Advise*: proc(self: ptr IFileDialog, pfde: ptr IFileDialogEvents, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IFileDialog, dwCookie: DWORD): HRESULT {.stdcall.}
    SetOptions*: proc(self: ptr IFileDialog, fos: FILEOPENDIALOGOPTIONS): HRESULT {.stdcall.}
    GetOptions*: proc(self: ptr IFileDialog, pfos: ptr FILEOPENDIALOGOPTIONS): HRESULT {.stdcall.}
    SetDefaultFolder*: proc(self: ptr IFileDialog, psi: ptr IShellItem): HRESULT {.stdcall.}
    SetFolder*: proc(self: ptr IFileDialog, psi: ptr IShellItem): HRESULT {.stdcall.}
    GetFolder*: proc(self: ptr IFileDialog, ppsi: ptr ptr IShellItem): HRESULT {.stdcall.}
    GetCurrentSelection*: proc(self: ptr IFileDialog, ppsi: ptr ptr IShellItem): HRESULT {.stdcall.}
    SetFileName*: proc(self: ptr IFileDialog, pszName: LPCWSTR): HRESULT {.stdcall.}
    GetFileName*: proc(self: ptr IFileDialog, pszName: ptr LPWSTR): HRESULT {.stdcall.}
    SetTitle*: proc(self: ptr IFileDialog, pszTitle: LPCWSTR): HRESULT {.stdcall.}
    SetOkButtonLabel*: proc(self: ptr IFileDialog, pszText: LPCWSTR): HRESULT {.stdcall.}
    SetFileNameLabel*: proc(self: ptr IFileDialog, pszLabel: LPCWSTR): HRESULT {.stdcall.}
    GetResult*: proc(self: ptr IFileDialog, ppsi: ptr ptr IShellItem): HRESULT {.stdcall.}
    AddPlace*: proc(self: ptr IFileDialog, psi: ptr IShellItem, fdap: FDAP): HRESULT {.stdcall.}
    SetDefaultExtension*: proc(self: ptr IFileDialog, pszDefaultExtension: LPCWSTR): HRESULT {.stdcall.}
    Close*: proc(self: ptr IFileDialog, hr: HRESULT): HRESULT {.stdcall.}
    SetClientGuid*: proc(self: ptr IFileDialog, guid: REFGUID): HRESULT {.stdcall.}
    ClearClientData*: proc(self: ptr IFileDialog): HRESULT {.stdcall.}
    SetFilter*: proc(self: ptr IFileDialog, pFilter: ptr IShellItemFilter): HRESULT {.stdcall.}
  IFileDialogEvents* {.pure.} = object
    lpVtbl*: ptr IFileDialogEventsVtbl
  IFileDialogEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnFileOk*: proc(self: ptr IFileDialogEvents, pfd: ptr IFileDialog): HRESULT {.stdcall.}
    OnFolderChanging*: proc(self: ptr IFileDialogEvents, pfd: ptr IFileDialog, psiFolder: ptr IShellItem): HRESULT {.stdcall.}
    OnFolderChange*: proc(self: ptr IFileDialogEvents, pfd: ptr IFileDialog): HRESULT {.stdcall.}
    OnSelectionChange*: proc(self: ptr IFileDialogEvents, pfd: ptr IFileDialog): HRESULT {.stdcall.}
    OnShareViolation*: proc(self: ptr IFileDialogEvents, pfd: ptr IFileDialog, psi: ptr IShellItem, pResponse: ptr FDE_SHAREVIOLATION_RESPONSE): HRESULT {.stdcall.}
    OnTypeChange*: proc(self: ptr IFileDialogEvents, pfd: ptr IFileDialog): HRESULT {.stdcall.}
    OnOverwrite*: proc(self: ptr IFileDialogEvents, pfd: ptr IFileDialog, psi: ptr IShellItem, pResponse: ptr FDE_OVERWRITE_RESPONSE): HRESULT {.stdcall.}
  IFileSaveDialog* {.pure.} = object
    lpVtbl*: ptr IFileSaveDialogVtbl
  IFileSaveDialogVtbl* {.pure, inheritable.} = object of IFileDialogVtbl
    SetSaveAsItem*: proc(self: ptr IFileSaveDialog, psi: ptr IShellItem): HRESULT {.stdcall.}
    SetProperties*: proc(self: ptr IFileSaveDialog, pStore: ptr IPropertyStore): HRESULT {.stdcall.}
    SetCollectedProperties*: proc(self: ptr IFileSaveDialog, pList: ptr IPropertyDescriptionList, fAppendDefault: WINBOOL): HRESULT {.stdcall.}
    GetProperties*: proc(self: ptr IFileSaveDialog, ppStore: ptr ptr IPropertyStore): HRESULT {.stdcall.}
    ApplyProperties*: proc(self: ptr IFileSaveDialog, psi: ptr IShellItem, pStore: ptr IPropertyStore, hwnd: HWND, pSink: ptr IFileOperationProgressSink): HRESULT {.stdcall.}
  IFileOpenDialog* {.pure.} = object
    lpVtbl*: ptr IFileOpenDialogVtbl
  IFileOpenDialogVtbl* {.pure, inheritable.} = object of IFileDialogVtbl
    GetResults*: proc(self: ptr IFileOpenDialog, ppenum: ptr ptr IShellItemArray): HRESULT {.stdcall.}
    GetSelectedItems*: proc(self: ptr IFileOpenDialog, ppsai: ptr ptr IShellItemArray): HRESULT {.stdcall.}
  IFileDialogCustomize* {.pure.} = object
    lpVtbl*: ptr IFileDialogCustomizeVtbl
  IFileDialogCustomizeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EnableOpenDropDown*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.stdcall.}
    AddMenu*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR): HRESULT {.stdcall.}
    AddPushButton*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR): HRESULT {.stdcall.}
    AddComboBox*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.stdcall.}
    AddRadioButtonList*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.stdcall.}
    AddCheckButton*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR, bChecked: WINBOOL): HRESULT {.stdcall.}
    AddEditBox*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszText: LPCWSTR): HRESULT {.stdcall.}
    AddSeparator*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.stdcall.}
    AddText*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszText: LPCWSTR): HRESULT {.stdcall.}
    SetControlLabel*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR): HRESULT {.stdcall.}
    GetControlState*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pdwState: ptr CDCONTROLSTATEF): HRESULT {.stdcall.}
    SetControlState*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwState: CDCONTROLSTATEF): HRESULT {.stdcall.}
    GetEditBoxText*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, ppszText: ptr ptr WCHAR): HRESULT {.stdcall.}
    SetEditBoxText*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszText: LPCWSTR): HRESULT {.stdcall.}
    GetCheckButtonState*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pbChecked: ptr WINBOOL): HRESULT {.stdcall.}
    SetCheckButtonState*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, bChecked: WINBOOL): HRESULT {.stdcall.}
    AddControlItem*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD, pszLabel: LPCWSTR): HRESULT {.stdcall.}
    RemoveControlItem*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD): HRESULT {.stdcall.}
    RemoveAllControlItems*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.stdcall.}
    GetControlItemState*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD, pdwState: ptr CDCONTROLSTATEF): HRESULT {.stdcall.}
    SetControlItemState*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD, dwState: CDCONTROLSTATEF): HRESULT {.stdcall.}
    GetSelectedControlItem*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pdwIDItem: ptr DWORD): HRESULT {.stdcall.}
    SetSelectedControlItem*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD): HRESULT {.stdcall.}
    StartVisualGroup*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR): HRESULT {.stdcall.}
    EndVisualGroup*: proc(self: ptr IFileDialogCustomize): HRESULT {.stdcall.}
    MakeProminent*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.stdcall.}
    SetControlItemText*: proc(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD, pszLabel: LPCWSTR): HRESULT {.stdcall.}
  IFileDialogControlEvents* {.pure.} = object
    lpVtbl*: ptr IFileDialogControlEventsVtbl
  IFileDialogControlEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnItemSelected*: proc(self: ptr IFileDialogControlEvents, pfdc: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD): HRESULT {.stdcall.}
    OnButtonClicked*: proc(self: ptr IFileDialogControlEvents, pfdc: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.stdcall.}
    OnCheckButtonToggled*: proc(self: ptr IFileDialogControlEvents, pfdc: ptr IFileDialogCustomize, dwIDCtl: DWORD, bChecked: WINBOOL): HRESULT {.stdcall.}
    OnControlActivating*: proc(self: ptr IFileDialogControlEvents, pfdc: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.stdcall.}
  IFileDialog2* {.pure.} = object
    lpVtbl*: ptr IFileDialog2Vtbl
  IFileDialog2Vtbl* {.pure, inheritable.} = object of IFileDialogVtbl
    SetCancelButtonLabel*: proc(self: ptr IFileDialog2, pszLabel: LPCWSTR): HRESULT {.stdcall.}
    SetNavigationRoot*: proc(self: ptr IFileDialog2, psi: ptr IShellItem): HRESULT {.stdcall.}
  IApplicationAssociationRegistration* {.pure.} = object
    lpVtbl*: ptr IApplicationAssociationRegistrationVtbl
  IApplicationAssociationRegistrationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryCurrentDefault*: proc(self: ptr IApplicationAssociationRegistration, pszQuery: LPCWSTR, atQueryType: ASSOCIATIONTYPE, alQueryLevel: ASSOCIATIONLEVEL, ppszAssociation: ptr LPWSTR): HRESULT {.stdcall.}
    QueryAppIsDefault*: proc(self: ptr IApplicationAssociationRegistration, pszQuery: LPCWSTR, atQueryType: ASSOCIATIONTYPE, alQueryLevel: ASSOCIATIONLEVEL, pszAppRegistryName: LPCWSTR, pfDefault: ptr WINBOOL): HRESULT {.stdcall.}
    QueryAppIsDefaultAll*: proc(self: ptr IApplicationAssociationRegistration, alQueryLevel: ASSOCIATIONLEVEL, pszAppRegistryName: LPCWSTR, pfDefault: ptr WINBOOL): HRESULT {.stdcall.}
    SetAppAsDefault*: proc(self: ptr IApplicationAssociationRegistration, pszAppRegistryName: LPCWSTR, pszSet: LPCWSTR, atSetType: ASSOCIATIONTYPE): HRESULT {.stdcall.}
    SetAppAsDefaultAll*: proc(self: ptr IApplicationAssociationRegistration, pszAppRegistryName: LPCWSTR): HRESULT {.stdcall.}
    ClearUserAssociations*: proc(self: ptr IApplicationAssociationRegistration): HRESULT {.stdcall.}
  IApplicationAssociationRegistrationUI* {.pure.} = object
    lpVtbl*: ptr IApplicationAssociationRegistrationUIVtbl
  IApplicationAssociationRegistrationUIVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    LaunchAdvancedAssociationUI*: proc(self: ptr IApplicationAssociationRegistrationUI, pszAppRegistryName: LPCWSTR): HRESULT {.stdcall.}
  IDelegateFolder* {.pure.} = object
    lpVtbl*: ptr IDelegateFolderVtbl
  IDelegateFolderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetItemAlloc*: proc(self: ptr IDelegateFolder, pmalloc: ptr IMalloc): HRESULT {.stdcall.}
  INewWindowManager* {.pure.} = object
    lpVtbl*: ptr INewWindowManagerVtbl
  INewWindowManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EvaluateNewWindow*: proc(self: ptr INewWindowManager, pszUrl: LPCWSTR, pszName: LPCWSTR, pszUrlContext: LPCWSTR, pszFeatures: LPCWSTR, fReplace: WINBOOL, dwFlags: DWORD, dwUserActionTime: DWORD): HRESULT {.stdcall.}
  IAttachmentExecute* {.pure.} = object
    lpVtbl*: ptr IAttachmentExecuteVtbl
  IAttachmentExecuteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetClientTitle*: proc(self: ptr IAttachmentExecute, pszTitle: LPCWSTR): HRESULT {.stdcall.}
    SetClientGuid*: proc(self: ptr IAttachmentExecute, guid: REFGUID): HRESULT {.stdcall.}
    SetLocalPath*: proc(self: ptr IAttachmentExecute, pszLocalPath: LPCWSTR): HRESULT {.stdcall.}
    SetFileName*: proc(self: ptr IAttachmentExecute, pszFileName: LPCWSTR): HRESULT {.stdcall.}
    SetSource*: proc(self: ptr IAttachmentExecute, pszSource: LPCWSTR): HRESULT {.stdcall.}
    SetReferrer*: proc(self: ptr IAttachmentExecute, pszReferrer: LPCWSTR): HRESULT {.stdcall.}
    CheckPolicy*: proc(self: ptr IAttachmentExecute): HRESULT {.stdcall.}
    Prompt*: proc(self: ptr IAttachmentExecute, hwnd: HWND, prompt: ATTACHMENT_PROMPT, paction: ptr ATTACHMENT_ACTION): HRESULT {.stdcall.}
    Save*: proc(self: ptr IAttachmentExecute): HRESULT {.stdcall.}
    Execute*: proc(self: ptr IAttachmentExecute, hwnd: HWND, pszVerb: LPCWSTR, phProcess: ptr HANDLE): HRESULT {.stdcall.}
    SaveWithUI*: proc(self: ptr IAttachmentExecute, hwnd: HWND): HRESULT {.stdcall.}
    ClearClientState*: proc(self: ptr IAttachmentExecute): HRESULT {.stdcall.}
  IShellMenuCallback* {.pure.} = object
    lpVtbl*: ptr IShellMenuCallbackVtbl
  IShellMenuCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CallbackSM*: proc(self: ptr IShellMenuCallback, psmd: LPSMDATA, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
  IShellMenu* {.pure.} = object
    lpVtbl*: ptr IShellMenuVtbl
  IShellMenuVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IShellMenu, psmc: ptr IShellMenuCallback, uId: UINT, uIdAncestor: UINT, dwFlags: DWORD): HRESULT {.stdcall.}
    GetMenuInfo*: proc(self: ptr IShellMenu, ppsmc: ptr ptr IShellMenuCallback, puId: ptr UINT, puIdAncestor: ptr UINT, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
    SetShellFolder*: proc(self: ptr IShellMenu, psf: ptr IShellFolder, pidlFolder: PCIDLIST_ABSOLUTE, hKey: HKEY, dwFlags: DWORD): HRESULT {.stdcall.}
    GetShellFolder*: proc(self: ptr IShellMenu, pdwFlags: ptr DWORD, ppidl: ptr PIDLIST_ABSOLUTE, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    SetMenu*: proc(self: ptr IShellMenu, hmenu: HMENU, hwnd: HWND, dwFlags: DWORD): HRESULT {.stdcall.}
    GetMenu*: proc(self: ptr IShellMenu, phmenu: ptr HMENU, phwnd: ptr HWND, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
    InvalidateItem*: proc(self: ptr IShellMenu, psmd: LPSMDATA, dwFlags: DWORD): HRESULT {.stdcall.}
    GetState*: proc(self: ptr IShellMenu, psmd: LPSMDATA): HRESULT {.stdcall.}
    SetMenuToolbar*: proc(self: ptr IShellMenu, punk: ptr IUnknown, dwFlags: DWORD): HRESULT {.stdcall.}
  IShellRunDll* {.pure.} = object
    lpVtbl*: ptr IShellRunDllVtbl
  IShellRunDllVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Run*: proc(self: ptr IShellRunDll, pszArgs: LPCWSTR): HRESULT {.stdcall.}
  IKnownFolder* {.pure.} = object
    lpVtbl*: ptr IKnownFolderVtbl
  IKnownFolderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetId*: proc(self: ptr IKnownFolder, pkfid: ptr KNOWNFOLDERID): HRESULT {.stdcall.}
    GetCategory*: proc(self: ptr IKnownFolder, pCategory: ptr KF_CATEGORY): HRESULT {.stdcall.}
    GetShellItem*: proc(self: ptr IKnownFolder, dwFlags: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetPath*: proc(self: ptr IKnownFolder, dwFlags: DWORD, ppszPath: ptr LPWSTR): HRESULT {.stdcall.}
    SetPath*: proc(self: ptr IKnownFolder, dwFlags: DWORD, pszPath: LPCWSTR): HRESULT {.stdcall.}
    GetIDList*: proc(self: ptr IKnownFolder, dwFlags: DWORD, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    GetFolderType*: proc(self: ptr IKnownFolder, pftid: ptr FOLDERTYPEID): HRESULT {.stdcall.}
    GetRedirectionCapabilities*: proc(self: ptr IKnownFolder, pCapabilities: ptr KF_REDIRECTION_CAPABILITIES): HRESULT {.stdcall.}
    GetFolderDefinition*: proc(self: ptr IKnownFolder, pKFD: ptr KNOWNFOLDER_DEFINITION): HRESULT {.stdcall.}
  IKnownFolderManager* {.pure.} = object
    lpVtbl*: ptr IKnownFolderManagerVtbl
  IKnownFolderManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FolderIdFromCsidl*: proc(self: ptr IKnownFolderManager, nCsidl: int32, pfid: ptr KNOWNFOLDERID): HRESULT {.stdcall.}
    FolderIdToCsidl*: proc(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID, pnCsidl: ptr int32): HRESULT {.stdcall.}
    GetFolderIds*: proc(self: ptr IKnownFolderManager, ppKFId: ptr ptr KNOWNFOLDERID, pCount: ptr UINT): HRESULT {.stdcall.}
    GetFolder*: proc(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID, ppkf: ptr ptr IKnownFolder): HRESULT {.stdcall.}
    GetFolderByName*: proc(self: ptr IKnownFolderManager, pszCanonicalName: LPCWSTR, ppkf: ptr ptr IKnownFolder): HRESULT {.stdcall.}
    RegisterFolder*: proc(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID, pKFD: ptr KNOWNFOLDER_DEFINITION): HRESULT {.stdcall.}
    UnregisterFolder*: proc(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID): HRESULT {.stdcall.}
    FindFolderFromPath*: proc(self: ptr IKnownFolderManager, pszPath: LPCWSTR, mode: FFFP_MODE, ppkf: ptr ptr IKnownFolder): HRESULT {.stdcall.}
    FindFolderFromIDList*: proc(self: ptr IKnownFolderManager, pidl: PCIDLIST_ABSOLUTE, ppkf: ptr ptr IKnownFolder): HRESULT {.stdcall.}
    Redirect*: proc(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID, hwnd: HWND, flags: KF_REDIRECT_FLAGS, pszTargetPath: LPCWSTR, cFolders: UINT, pExclusion: ptr KNOWNFOLDERID, ppszError: ptr LPWSTR): HRESULT {.stdcall.}
  ISharingConfigurationManager* {.pure.} = object
    lpVtbl*: ptr ISharingConfigurationManagerVtbl
  ISharingConfigurationManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateShare*: proc(self: ptr ISharingConfigurationManager, dsid: DEF_SHARE_ID, role: SHARE_ROLE): HRESULT {.stdcall.}
    DeleteShare*: proc(self: ptr ISharingConfigurationManager, dsid: DEF_SHARE_ID): HRESULT {.stdcall.}
    ShareExists*: proc(self: ptr ISharingConfigurationManager, dsid: DEF_SHARE_ID): HRESULT {.stdcall.}
    GetSharePermissions*: proc(self: ptr ISharingConfigurationManager, dsid: DEF_SHARE_ID, pRole: ptr SHARE_ROLE): HRESULT {.stdcall.}
    SharePrinters*: proc(self: ptr ISharingConfigurationManager): HRESULT {.stdcall.}
    StopSharingPrinters*: proc(self: ptr ISharingConfigurationManager): HRESULT {.stdcall.}
    ArePrintersShared*: proc(self: ptr ISharingConfigurationManager): HRESULT {.stdcall.}
  IPreviousVersionsInfo* {.pure.} = object
    lpVtbl*: ptr IPreviousVersionsInfoVtbl
  IPreviousVersionsInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AreSnapshotsAvailable*: proc(self: ptr IPreviousVersionsInfo, pszPath: LPCWSTR, fOkToBeSlow: WINBOOL, pfAvailable: ptr WINBOOL): HRESULT {.stdcall.}
  IRelatedItem* {.pure.} = object
    lpVtbl*: ptr IRelatedItemVtbl
  IRelatedItemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetItemIDList*: proc(self: ptr IRelatedItem, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    GetItem*: proc(self: ptr IRelatedItem, ppsi: ptr ptr IShellItem): HRESULT {.stdcall.}
  IIdentityName* {.pure.} = object
    lpVtbl*: ptr IIdentityNameVtbl
  IIdentityNameVtbl* {.pure, inheritable.} = object of IRelatedItemVtbl
  IDelegateItem* {.pure.} = object
    lpVtbl*: ptr IDelegateItemVtbl
  IDelegateItemVtbl* {.pure, inheritable.} = object of IRelatedItemVtbl
  ICurrentItem* {.pure.} = object
    lpVtbl*: ptr ICurrentItemVtbl
  ICurrentItemVtbl* {.pure, inheritable.} = object of IRelatedItemVtbl
  ITransferMediumItem* {.pure.} = object
    lpVtbl*: ptr ITransferMediumItemVtbl
  ITransferMediumItemVtbl* {.pure, inheritable.} = object of IRelatedItemVtbl
  IUseToBrowseItem* {.pure.} = object
    lpVtbl*: ptr IUseToBrowseItemVtbl
  IUseToBrowseItemVtbl* {.pure, inheritable.} = object of IRelatedItemVtbl
  IDisplayItem* {.pure.} = object
    lpVtbl*: ptr IDisplayItemVtbl
  IDisplayItemVtbl* {.pure, inheritable.} = object of IRelatedItemVtbl
  IViewStateIdentityItem* {.pure.} = object
    lpVtbl*: ptr IViewStateIdentityItemVtbl
  IViewStateIdentityItemVtbl* {.pure, inheritable.} = object of IRelatedItemVtbl
  IPreviewItem* {.pure.} = object
    lpVtbl*: ptr IPreviewItemVtbl
  IPreviewItemVtbl* {.pure, inheritable.} = object of IRelatedItemVtbl
  IDestinationStreamFactory* {.pure.} = object
    lpVtbl*: ptr IDestinationStreamFactoryVtbl
  IDestinationStreamFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDestinationStream*: proc(self: ptr IDestinationStreamFactory, ppstm: ptr ptr IStream): HRESULT {.stdcall.}
  INewMenuClient* {.pure.} = object
    lpVtbl*: ptr INewMenuClientVtbl
  INewMenuClientVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IncludeItems*: proc(self: ptr INewMenuClient, pflags: ptr NMCII_FLAGS): HRESULT {.stdcall.}
    SelectAndEditItem*: proc(self: ptr INewMenuClient, pidlItem: PCIDLIST_ABSOLUTE, flags: NMCSAEI_FLAGS): HRESULT {.stdcall.}
  IInitializeWithBindCtx* {.pure.} = object
    lpVtbl*: ptr IInitializeWithBindCtxVtbl
  IInitializeWithBindCtxVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeWithBindCtx, pbc: ptr IBindCtx): HRESULT {.stdcall.}
  INameSpaceTreeControl* {.pure.} = object
    lpVtbl*: ptr INameSpaceTreeControlVtbl
  INameSpaceTreeControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr INameSpaceTreeControl, hwndParent: HWND, prc: ptr RECT, nsctsFlags: NSTCSTYLE): HRESULT {.stdcall.}
    TreeAdvise*: proc(self: ptr INameSpaceTreeControl, punk: ptr IUnknown, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    TreeUnadvise*: proc(self: ptr INameSpaceTreeControl, dwCookie: DWORD): HRESULT {.stdcall.}
    AppendRoot*: proc(self: ptr INameSpaceTreeControl, psiRoot: ptr IShellItem, grfEnumFlags: SHCONTF, grfRootStyle: NSTCROOTSTYLE, pif: ptr IShellItemFilter): HRESULT {.stdcall.}
    InsertRoot*: proc(self: ptr INameSpaceTreeControl, iIndex: int32, psiRoot: ptr IShellItem, grfEnumFlags: SHCONTF, grfRootStyle: NSTCROOTSTYLE, pif: ptr IShellItemFilter): HRESULT {.stdcall.}
    RemoveRoot*: proc(self: ptr INameSpaceTreeControl, psiRoot: ptr IShellItem): HRESULT {.stdcall.}
    RemoveAllRoots*: proc(self: ptr INameSpaceTreeControl): HRESULT {.stdcall.}
    GetRootItems*: proc(self: ptr INameSpaceTreeControl, ppsiaRootItems: ptr ptr IShellItemArray): HRESULT {.stdcall.}
    SetItemState*: proc(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, nstcisMask: NSTCITEMSTATE, nstcisFlags: NSTCITEMSTATE): HRESULT {.stdcall.}
    GetItemState*: proc(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, nstcisMask: NSTCITEMSTATE, pnstcisFlags: ptr NSTCITEMSTATE): HRESULT {.stdcall.}
    GetSelectedItems*: proc(self: ptr INameSpaceTreeControl, psiaItems: ptr ptr IShellItemArray): HRESULT {.stdcall.}
    GetItemCustomState*: proc(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, piStateNumber: ptr int32): HRESULT {.stdcall.}
    SetItemCustomState*: proc(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, iStateNumber: int32): HRESULT {.stdcall.}
    EnsureItemVisible*: proc(self: ptr INameSpaceTreeControl, psi: ptr IShellItem): HRESULT {.stdcall.}
    SetTheme*: proc(self: ptr INameSpaceTreeControl, pszTheme: LPCWSTR): HRESULT {.stdcall.}
    GetNextItem*: proc(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, nstcgi: NSTCGNI, ppsiNext: ptr ptr IShellItem): HRESULT {.stdcall.}
    HitTest*: proc(self: ptr INameSpaceTreeControl, ppt: ptr POINT, ppsiOut: ptr ptr IShellItem): HRESULT {.stdcall.}
    GetItemRect*: proc(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, prect: ptr RECT): HRESULT {.stdcall.}
    CollapseAll*: proc(self: ptr INameSpaceTreeControl): HRESULT {.stdcall.}
  INameSpaceTreeControl2* {.pure.} = object
    lpVtbl*: ptr INameSpaceTreeControl2Vtbl
  INameSpaceTreeControl2Vtbl* {.pure, inheritable.} = object of INameSpaceTreeControlVtbl
    SetControlStyle*: proc(self: ptr INameSpaceTreeControl2, nstcsMask: NSTCSTYLE, nstcsStyle: NSTCSTYLE): HRESULT {.stdcall.}
    GetControlStyle*: proc(self: ptr INameSpaceTreeControl2, nstcsMask: NSTCSTYLE, pnstcsStyle: ptr NSTCSTYLE): HRESULT {.stdcall.}
    SetControlStyle2*: proc(self: ptr INameSpaceTreeControl2, nstcsMask: NSTCSTYLE2, nstcsStyle: NSTCSTYLE2): HRESULT {.stdcall.}
    GetControlStyle2*: proc(self: ptr INameSpaceTreeControl2, nstcsMask: NSTCSTYLE2, pnstcsStyle: ptr NSTCSTYLE2): HRESULT {.stdcall.}
  INameSpaceTreeControlEvents* {.pure.} = object
    lpVtbl*: ptr INameSpaceTreeControlEventsVtbl
  INameSpaceTreeControlEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnItemClick*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, nstceHitTest: NSTCEHITTEST, nstceClickType: NSTCECLICKTYPE): HRESULT {.stdcall.}
    OnPropertyItemCommit*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.stdcall.}
    OnItemStateChanging*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, nstcisMask: NSTCITEMSTATE, nstcisState: NSTCITEMSTATE): HRESULT {.stdcall.}
    OnItemStateChanged*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, nstcisMask: NSTCITEMSTATE, nstcisState: NSTCITEMSTATE): HRESULT {.stdcall.}
    OnSelectionChanged*: proc(self: ptr INameSpaceTreeControlEvents, psiaSelection: ptr IShellItemArray): HRESULT {.stdcall.}
    OnKeyboardInput*: proc(self: ptr INameSpaceTreeControlEvents, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.stdcall.}
    OnBeforeExpand*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.stdcall.}
    OnAfterExpand*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.stdcall.}
    OnBeginLabelEdit*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.stdcall.}
    OnEndLabelEdit*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.stdcall.}
    OnGetToolTip*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, pszTip: LPWSTR, cchTip: int32): HRESULT {.stdcall.}
    OnBeforeItemDelete*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.stdcall.}
    OnItemAdded*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, fIsRoot: WINBOOL): HRESULT {.stdcall.}
    OnItemDeleted*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, fIsRoot: WINBOOL): HRESULT {.stdcall.}
    OnBeforeContextMenu*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    OnAfterContextMenu*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, pcmIn: ptr IContextMenu, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    OnBeforeStateImageChange*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.stdcall.}
    OnGetDefaultIconIndex*: proc(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, piDefaultIcon: ptr int32, piOpenIcon: ptr int32): HRESULT {.stdcall.}
  INameSpaceTreeControlDropHandler* {.pure.} = object
    lpVtbl*: ptr INameSpaceTreeControlDropHandlerVtbl
  INameSpaceTreeControlDropHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnDragEnter*: proc(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, fOutsideSource: WINBOOL, grfKeyState: DWORD, pdwEffect: ptr DWORD): HRESULT {.stdcall.}
    OnDragOver*: proc(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, grfKeyState: DWORD, pdwEffect: ptr DWORD): HRESULT {.stdcall.}
    OnDragPosition*: proc(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, iNewPosition: int32, iOldPosition: int32): HRESULT {.stdcall.}
    OnDrop*: proc(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, iPosition: int32, grfKeyState: DWORD, pdwEffect: ptr DWORD): HRESULT {.stdcall.}
    OnDropPosition*: proc(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, iNewPosition: int32, iOldPosition: int32): HRESULT {.stdcall.}
    OnDragLeave*: proc(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem): HRESULT {.stdcall.}
  INameSpaceTreeAccessible* {.pure.} = object
    lpVtbl*: ptr INameSpaceTreeAccessibleVtbl
  INameSpaceTreeAccessibleVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnGetDefaultAccessibilityAction*: proc(self: ptr INameSpaceTreeAccessible, psi: ptr IShellItem, pbstrDefaultAction: ptr BSTR): HRESULT {.stdcall.}
    OnDoDefaultAccessibilityAction*: proc(self: ptr INameSpaceTreeAccessible, psi: ptr IShellItem): HRESULT {.stdcall.}
    OnGetAccessibilityRole*: proc(self: ptr INameSpaceTreeAccessible, psi: ptr IShellItem, pvarRole: ptr VARIANT): HRESULT {.stdcall.}
  INameSpaceTreeControlCustomDraw* {.pure.} = object
    lpVtbl*: ptr INameSpaceTreeControlCustomDrawVtbl
  INameSpaceTreeControlCustomDrawVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    PrePaint*: proc(self: ptr INameSpaceTreeControlCustomDraw, hdc: HDC, prc: ptr RECT, plres: ptr LRESULT): HRESULT {.stdcall.}
    PostPaint*: proc(self: ptr INameSpaceTreeControlCustomDraw, hdc: HDC, prc: ptr RECT): HRESULT {.stdcall.}
    ItemPrePaint*: proc(self: ptr INameSpaceTreeControlCustomDraw, hdc: HDC, prc: ptr RECT, pnstccdItem: ptr NSTCCUSTOMDRAW, pclrText: ptr COLORREF, pclrTextBk: ptr COLORREF, plres: ptr LRESULT): HRESULT {.stdcall.}
    ItemPostPaint*: proc(self: ptr INameSpaceTreeControlCustomDraw, hdc: HDC, prc: ptr RECT, pnstccdItem: ptr NSTCCUSTOMDRAW): HRESULT {.stdcall.}
  INameSpaceTreeControlFolderCapabilities* {.pure.} = object
    lpVtbl*: ptr INameSpaceTreeControlFolderCapabilitiesVtbl
  INameSpaceTreeControlFolderCapabilitiesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetFolderCapabilities*: proc(self: ptr INameSpaceTreeControlFolderCapabilities, nfcMask: NSTCFOLDERCAPABILITIES, pnfcValue: ptr NSTCFOLDERCAPABILITIES): HRESULT {.stdcall.}
  IPreviewHandler* {.pure.} = object
    lpVtbl*: ptr IPreviewHandlerVtbl
  IPreviewHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetWindow*: proc(self: ptr IPreviewHandler, hwnd: HWND, prc: ptr RECT): HRESULT {.stdcall.}
    SetRect*: proc(self: ptr IPreviewHandler, prc: ptr RECT): HRESULT {.stdcall.}
    DoPreview*: proc(self: ptr IPreviewHandler): HRESULT {.stdcall.}
    Unload*: proc(self: ptr IPreviewHandler): HRESULT {.stdcall.}
    SetFocus*: proc(self: ptr IPreviewHandler): HRESULT {.stdcall.}
    QueryFocus*: proc(self: ptr IPreviewHandler, phwnd: ptr HWND): HRESULT {.stdcall.}
    TranslateAccelerator*: proc(self: ptr IPreviewHandler, pmsg: ptr MSG): HRESULT {.stdcall.}
  IPreviewHandlerFrame* {.pure.} = object
    lpVtbl*: ptr IPreviewHandlerFrameVtbl
  IPreviewHandlerFrameVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetWindowContext*: proc(self: ptr IPreviewHandlerFrame, pinfo: ptr PREVIEWHANDLERFRAMEINFO): HRESULT {.stdcall.}
    TranslateAccelerator*: proc(self: ptr IPreviewHandlerFrame, pmsg: ptr MSG): HRESULT {.stdcall.}
  ITrayDeskBand* {.pure.} = object
    lpVtbl*: ptr ITrayDeskBandVtbl
  ITrayDeskBandVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ShowDeskBand*: proc(self: ptr ITrayDeskBand, clsid: REFCLSID): HRESULT {.stdcall.}
    HideDeskBand*: proc(self: ptr ITrayDeskBand, clsid: REFCLSID): HRESULT {.stdcall.}
    IsDeskBandShown*: proc(self: ptr ITrayDeskBand, clsid: REFCLSID): HRESULT {.stdcall.}
    DeskBandRegistrationChanged*: proc(self: ptr ITrayDeskBand): HRESULT {.stdcall.}
  IBandHost* {.pure.} = object
    lpVtbl*: ptr IBandHostVtbl
  IBandHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateBand*: proc(self: ptr IBandHost, rclsidBand: REFCLSID, fAvailable: WINBOOL, fVisible: WINBOOL, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    SetBandAvailability*: proc(self: ptr IBandHost, rclsidBand: REFCLSID, fAvailable: WINBOOL): HRESULT {.stdcall.}
    DestroyBand*: proc(self: ptr IBandHost, rclsidBand: REFCLSID): HRESULT {.stdcall.}
  IExplorerPaneVisibility* {.pure.} = object
    lpVtbl*: ptr IExplorerPaneVisibilityVtbl
  IExplorerPaneVisibilityVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPaneState*: proc(self: ptr IExplorerPaneVisibility, ep: REFEXPLORERPANE, peps: ptr EXPLORERPANESTATE): HRESULT {.stdcall.}
  IDefaultExtractIconInit* {.pure.} = object
    lpVtbl*: ptr IDefaultExtractIconInitVtbl
  IDefaultExtractIconInitVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetFlags*: proc(self: ptr IDefaultExtractIconInit, uFlags: UINT): HRESULT {.stdcall.}
    SetKey*: proc(self: ptr IDefaultExtractIconInit, hkey: HKEY): HRESULT {.stdcall.}
    SetNormalIcon*: proc(self: ptr IDefaultExtractIconInit, pszFile: LPCWSTR, iIcon: int32): HRESULT {.stdcall.}
    SetOpenIcon*: proc(self: ptr IDefaultExtractIconInit, pszFile: LPCWSTR, iIcon: int32): HRESULT {.stdcall.}
    SetShortcutIcon*: proc(self: ptr IDefaultExtractIconInit, pszFile: LPCWSTR, iIcon: int32): HRESULT {.stdcall.}
    SetDefaultIcon*: proc(self: ptr IDefaultExtractIconInit, pszFile: LPCWSTR, iIcon: int32): HRESULT {.stdcall.}
  IEnumExplorerCommand* {.pure.} = object
    lpVtbl*: ptr IEnumExplorerCommandVtbl
  IEnumExplorerCommandVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumExplorerCommand, celt: ULONG, pUICommand: ptr ptr IExplorerCommand, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumExplorerCommand, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumExplorerCommand): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumExplorerCommand, ppenum: ptr ptr IEnumExplorerCommand): HRESULT {.stdcall.}
  IExplorerCommand* {.pure.} = object
    lpVtbl*: ptr IExplorerCommandVtbl
  IExplorerCommandVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetTitle*: proc(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, ppszName: ptr LPWSTR): HRESULT {.stdcall.}
    GetIcon*: proc(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, ppszIcon: ptr LPWSTR): HRESULT {.stdcall.}
    GetToolTip*: proc(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, ppszInfotip: ptr LPWSTR): HRESULT {.stdcall.}
    GetCanonicalName*: proc(self: ptr IExplorerCommand, pguidCommandName: ptr GUID): HRESULT {.stdcall.}
    GetState*: proc(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, fOkToBeSlow: WINBOOL, pCmdState: ptr EXPCMDSTATE): HRESULT {.stdcall.}
    Invoke*: proc(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, pbc: ptr IBindCtx): HRESULT {.stdcall.}
    GetFlags*: proc(self: ptr IExplorerCommand, pFlags: ptr EXPCMDFLAGS): HRESULT {.stdcall.}
    EnumSubCommands*: proc(self: ptr IExplorerCommand, ppEnum: ptr ptr IEnumExplorerCommand): HRESULT {.stdcall.}
  IExplorerCommandState* {.pure.} = object
    lpVtbl*: ptr IExplorerCommandStateVtbl
  IExplorerCommandStateVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetState*: proc(self: ptr IExplorerCommandState, psiItemArray: ptr IShellItemArray, fOkToBeSlow: WINBOOL, pCmdState: ptr EXPCMDSTATE): HRESULT {.stdcall.}
  IInitializeCommand* {.pure.} = object
    lpVtbl*: ptr IInitializeCommandVtbl
  IInitializeCommandVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeCommand, pszCommandName: LPCWSTR, ppb: ptr IPropertyBag): HRESULT {.stdcall.}
  IExplorerCommandProvider* {.pure.} = object
    lpVtbl*: ptr IExplorerCommandProviderVtbl
  IExplorerCommandProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCommands*: proc(self: ptr IExplorerCommandProvider, punkSite: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetCommand*: proc(self: ptr IExplorerCommandProvider, rguidCommandId: REFGUID, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IInitializeNetworkFolder* {.pure.} = object
    lpVtbl*: ptr IInitializeNetworkFolderVtbl
  IInitializeNetworkFolderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeNetworkFolder, pidl: PCIDLIST_ABSOLUTE, pidlTarget: PCIDLIST_ABSOLUTE, uDisplayType: UINT, pszResName: LPCWSTR, pszProvider: LPCWSTR): HRESULT {.stdcall.}
  IOpenControlPanel* {.pure.} = object
    lpVtbl*: ptr IOpenControlPanelVtbl
  IOpenControlPanelVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Open*: proc(self: ptr IOpenControlPanel, pszName: LPCWSTR, pszPage: LPCWSTR, punkSite: ptr IUnknown): HRESULT {.stdcall.}
    GetPath*: proc(self: ptr IOpenControlPanel, pszName: LPCWSTR, pszPath: LPWSTR, cchPath: UINT): HRESULT {.stdcall.}
    GetCurrentView*: proc(self: ptr IOpenControlPanel, pView: ptr CPVIEW): HRESULT {.stdcall.}
  IComputerInfoChangeNotify* {.pure.} = object
    lpVtbl*: ptr IComputerInfoChangeNotifyVtbl
  IComputerInfoChangeNotifyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ComputerInfoChanged*: proc(self: ptr IComputerInfoChangeNotify): HRESULT {.stdcall.}
  IFileSystemBindData* {.pure.} = object
    lpVtbl*: ptr IFileSystemBindDataVtbl
  IFileSystemBindDataVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetFindData*: proc(self: ptr IFileSystemBindData, pfd: ptr WIN32_FIND_DATAW): HRESULT {.stdcall.}
    GetFindData*: proc(self: ptr IFileSystemBindData, pfd: ptr WIN32_FIND_DATAW): HRESULT {.stdcall.}
  IFileSystemBindData2* {.pure.} = object
    lpVtbl*: ptr IFileSystemBindData2Vtbl
  IFileSystemBindData2Vtbl* {.pure, inheritable.} = object of IFileSystemBindDataVtbl
    SetFileID*: proc(self: ptr IFileSystemBindData2, liFileID: LARGE_INTEGER): HRESULT {.stdcall.}
    GetFileID*: proc(self: ptr IFileSystemBindData2, pliFileID: ptr LARGE_INTEGER): HRESULT {.stdcall.}
    SetJunctionCLSID*: proc(self: ptr IFileSystemBindData2, clsid: REFCLSID): HRESULT {.stdcall.}
    GetJunctionCLSID*: proc(self: ptr IFileSystemBindData2, pclsid: ptr CLSID): HRESULT {.stdcall.}
  ICustomDestinationList* {.pure.} = object
    lpVtbl*: ptr ICustomDestinationListVtbl
  ICustomDestinationListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetAppID*: proc(self: ptr ICustomDestinationList, pszAppID: LPCWSTR): HRESULT {.stdcall.}
    BeginList*: proc(self: ptr ICustomDestinationList, pcMinSlots: ptr UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    AppendCategory*: proc(self: ptr ICustomDestinationList, pszCategory: LPCWSTR, poa: ptr IObjectArray): HRESULT {.stdcall.}
    AppendKnownCategory*: proc(self: ptr ICustomDestinationList, category: KNOWNDESTCATEGORY): HRESULT {.stdcall.}
    AddUserTasks*: proc(self: ptr ICustomDestinationList, poa: ptr IObjectArray): HRESULT {.stdcall.}
    CommitList*: proc(self: ptr ICustomDestinationList): HRESULT {.stdcall.}
    GetRemovedDestinations*: proc(self: ptr ICustomDestinationList, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    DeleteList*: proc(self: ptr ICustomDestinationList, pszAppID: LPCWSTR): HRESULT {.stdcall.}
    AbortList*: proc(self: ptr ICustomDestinationList): HRESULT {.stdcall.}
  IApplicationDestinations* {.pure.} = object
    lpVtbl*: ptr IApplicationDestinationsVtbl
  IApplicationDestinationsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetAppID*: proc(self: ptr IApplicationDestinations, pszAppID: LPCWSTR): HRESULT {.stdcall.}
    RemoveDestination*: proc(self: ptr IApplicationDestinations, punk: ptr IUnknown): HRESULT {.stdcall.}
    RemoveAllDestinations*: proc(self: ptr IApplicationDestinations): HRESULT {.stdcall.}
  IApplicationDocumentLists* {.pure.} = object
    lpVtbl*: ptr IApplicationDocumentListsVtbl
  IApplicationDocumentListsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetAppID*: proc(self: ptr IApplicationDocumentLists, pszAppID: LPCWSTR): HRESULT {.stdcall.}
    GetList*: proc(self: ptr IApplicationDocumentLists, listtype: APPDOCLISTTYPE, cItemsDesired: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IObjectWithAppUserModelID* {.pure.} = object
    lpVtbl*: ptr IObjectWithAppUserModelIDVtbl
  IObjectWithAppUserModelIDVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetAppID*: proc(self: ptr IObjectWithAppUserModelID, pszAppID: LPCWSTR): HRESULT {.stdcall.}
    GetAppID*: proc(self: ptr IObjectWithAppUserModelID, ppszAppID: ptr LPWSTR): HRESULT {.stdcall.}
  IObjectWithProgID* {.pure.} = object
    lpVtbl*: ptr IObjectWithProgIDVtbl
  IObjectWithProgIDVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetProgID*: proc(self: ptr IObjectWithProgID, pszProgID: LPCWSTR): HRESULT {.stdcall.}
    GetProgID*: proc(self: ptr IObjectWithProgID, ppszProgID: ptr LPWSTR): HRESULT {.stdcall.}
  IUpdateIDList* {.pure.} = object
    lpVtbl*: ptr IUpdateIDListVtbl
  IUpdateIDListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Update*: proc(self: ptr IUpdateIDList, pbc: ptr IBindCtx, pidlIn: PCUITEMID_CHILD, ppidlOut: ptr PITEMID_CHILD): HRESULT {.stdcall.}
  IDesktopGadget* {.pure.} = object
    lpVtbl*: ptr IDesktopGadgetVtbl
  IDesktopGadgetVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RunGadget*: proc(self: ptr IDesktopGadget, gadgetPath: LPCWSTR): HRESULT {.stdcall.}
  IDesktopWallpaper* {.pure.} = object
    lpVtbl*: ptr IDesktopWallpaperVtbl
  IDesktopWallpaperVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetWallpaper*: proc(self: ptr IDesktopWallpaper, monitorID: LPCWSTR, wallpaper: LPCWSTR): HRESULT {.stdcall.}
    GetWallpaper*: proc(self: ptr IDesktopWallpaper, monitorID: LPCWSTR, wallpaper: ptr LPWSTR): HRESULT {.stdcall.}
    GetMonitorDevicePathAt*: proc(self: ptr IDesktopWallpaper, monitorIndex: UINT, monitorID: ptr LPWSTR): HRESULT {.stdcall.}
    GetMonitorDevicePathCount*: proc(self: ptr IDesktopWallpaper, count: ptr UINT): HRESULT {.stdcall.}
    GetMonitorRECT*: proc(self: ptr IDesktopWallpaper, monitorID: LPCWSTR, displayRect: ptr RECT): HRESULT {.stdcall.}
    SetBackgroundColor*: proc(self: ptr IDesktopWallpaper, color: COLORREF): HRESULT {.stdcall.}
    GetBackgroundColor*: proc(self: ptr IDesktopWallpaper, color: ptr COLORREF): HRESULT {.stdcall.}
    SetPosition*: proc(self: ptr IDesktopWallpaper, position: DESKTOP_WALLPAPER_POSITION): HRESULT {.stdcall.}
    GetPosition*: proc(self: ptr IDesktopWallpaper, position: ptr DESKTOP_WALLPAPER_POSITION): HRESULT {.stdcall.}
    SetSlideshow*: proc(self: ptr IDesktopWallpaper, items: ptr IShellItemArray): HRESULT {.stdcall.}
    GetSlideshow*: proc(self: ptr IDesktopWallpaper, items: ptr ptr IShellItemArray): HRESULT {.stdcall.}
    SetSlideshowOptions*: proc(self: ptr IDesktopWallpaper, options: DESKTOP_SLIDESHOW_OPTIONS, slideshowTick: UINT): HRESULT {.stdcall.}
    GetSlideshowOptions*: proc(self: ptr IDesktopWallpaper, options: ptr DESKTOP_SLIDESHOW_OPTIONS, slideshowTick: ptr UINT): HRESULT {.stdcall.}
    AdvanceSlideshow*: proc(self: ptr IDesktopWallpaper, monitorID: LPCWSTR, direction: DESKTOP_SLIDESHOW_DIRECTION): HRESULT {.stdcall.}
    GetStatus*: proc(self: ptr IDesktopWallpaper, state: ptr DESKTOP_SLIDESHOW_STATE): HRESULT {.stdcall.}
    Enable*: proc(self: ptr IDesktopWallpaper, enable: WINBOOL): HRESULT {.stdcall.}
  IHomeGroup* {.pure.} = object
    lpVtbl*: ptr IHomeGroupVtbl
  IHomeGroupVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IsMember*: proc(self: ptr IHomeGroup, member: ptr WINBOOL): HRESULT {.stdcall.}
    ShowSharingWizard*: proc(self: ptr IHomeGroup, owner: HWND, sharingchoices: ptr HOMEGROUPSHARINGCHOICES): HRESULT {.stdcall.}
  IInitializeWithPropertyStore* {.pure.} = object
    lpVtbl*: ptr IInitializeWithPropertyStoreVtbl
  IInitializeWithPropertyStoreVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeWithPropertyStore, pps: ptr IPropertyStore): HRESULT {.stdcall.}
  IOpenSearchSource* {.pure.} = object
    lpVtbl*: ptr IOpenSearchSourceVtbl
  IOpenSearchSourceVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetResults*: proc(self: ptr IOpenSearchSource, hwnd: HWND, pszQuery: LPCWSTR, dwStartIndex: DWORD, dwCount: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IShellLibrary* {.pure.} = object
    lpVtbl*: ptr IShellLibraryVtbl
  IShellLibraryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    LoadLibraryFromItem*: proc(self: ptr IShellLibrary, psiLibrary: ptr IShellItem, grfMode: DWORD): HRESULT {.stdcall.}
    LoadLibraryFromKnownFolder*: proc(self: ptr IShellLibrary, kfidLibrary: REFKNOWNFOLDERID, grfMode: DWORD): HRESULT {.stdcall.}
    AddFolder*: proc(self: ptr IShellLibrary, psiLocation: ptr IShellItem): HRESULT {.stdcall.}
    RemoveFolder*: proc(self: ptr IShellLibrary, psiLocation: ptr IShellItem): HRESULT {.stdcall.}
    GetFolders*: proc(self: ptr IShellLibrary, lff: LIBRARYFOLDERFILTER, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    ResolveFolder*: proc(self: ptr IShellLibrary, psiFolderToResolve: ptr IShellItem, dwTimeout: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetDefaultSaveFolder*: proc(self: ptr IShellLibrary, dsft: DEFAULTSAVEFOLDERTYPE, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    SetDefaultSaveFolder*: proc(self: ptr IShellLibrary, dsft: DEFAULTSAVEFOLDERTYPE, psi: ptr IShellItem): HRESULT {.stdcall.}
    GetOptions*: proc(self: ptr IShellLibrary, plofOptions: ptr LIBRARYOPTIONFLAGS): HRESULT {.stdcall.}
    SetOptions*: proc(self: ptr IShellLibrary, lofMask: LIBRARYOPTIONFLAGS, lofOptions: LIBRARYOPTIONFLAGS): HRESULT {.stdcall.}
    GetFolderType*: proc(self: ptr IShellLibrary, pftid: ptr FOLDERTYPEID): HRESULT {.stdcall.}
    SetFolderType*: proc(self: ptr IShellLibrary, ftid: REFFOLDERTYPEID): HRESULT {.stdcall.}
    GetIcon*: proc(self: ptr IShellLibrary, ppszIcon: ptr LPWSTR): HRESULT {.stdcall.}
    SetIcon*: proc(self: ptr IShellLibrary, pszIcon: LPCWSTR): HRESULT {.stdcall.}
    Commit*: proc(self: ptr IShellLibrary): HRESULT {.stdcall.}
    Save*: proc(self: ptr IShellLibrary, psiFolderToSaveIn: ptr IShellItem, pszLibraryName: LPCWSTR, lsf: LIBRARYSAVEFLAGS, ppsiSavedTo: ptr ptr IShellItem): HRESULT {.stdcall.}
    SaveInKnownFolder*: proc(self: ptr IShellLibrary, kfidToSaveIn: REFKNOWNFOLDERID, pszLibraryName: LPCWSTR, lsf: LIBRARYSAVEFLAGS, ppsiSavedTo: ptr ptr IShellItem): HRESULT {.stdcall.}
  IPlaybackManagerEvents* {.pure.} = object
    lpVtbl*: ptr IPlaybackManagerEventsVtbl
  IPlaybackManagerEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnPlaybackManagerEvent*: proc(self: ptr IPlaybackManagerEvents, dwSessionId: DWORD, mediaEvent: PBM_EVENT): HRESULT {.stdcall.}
  IPlaybackManager* {.pure.} = object
    lpVtbl*: ptr IPlaybackManagerVtbl
  IPlaybackManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Advise*: proc(self: ptr IPlaybackManager, `type`: PBM_SESSION_TYPE, pEvents: ptr IPlaybackManagerEvents, pdwSessionId: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IPlaybackManager, dwSessionId: DWORD): HRESULT {.stdcall.}
    ChangeSessionState*: proc(self: ptr IPlaybackManager, dwSessionId: DWORD, state: PBM_PLAY_STATE, mute: PBM_MUTE_STATE): HRESULT {.stdcall.}
  IDefaultFolderMenuInitialize* {.pure.} = object
    lpVtbl*: ptr IDefaultFolderMenuInitializeVtbl
  IDefaultFolderMenuInitializeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IDefaultFolderMenuInitialize, hwnd: HWND, pcmcb: ptr IContextMenuCB, pidlFolder: PCIDLIST_ABSOLUTE, psf: ptr IShellFolder, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, punkAssociation: ptr IUnknown, cKeys: UINT, aKeys: ptr HKEY): HRESULT {.stdcall.}
    SetMenuRestrictions*: proc(self: ptr IDefaultFolderMenuInitialize, dfmrValues: DEFAULT_FOLDER_MENU_RESTRICTIONS): HRESULT {.stdcall.}
    GetMenuRestrictions*: proc(self: ptr IDefaultFolderMenuInitialize, dfmrMask: DEFAULT_FOLDER_MENU_RESTRICTIONS, pdfmrValues: ptr DEFAULT_FOLDER_MENU_RESTRICTIONS): HRESULT {.stdcall.}
    SetHandlerClsid*: proc(self: ptr IDefaultFolderMenuInitialize, rclsid: REFCLSID): HRESULT {.stdcall.}
  IApplicationActivationManager* {.pure.} = object
    lpVtbl*: ptr IApplicationActivationManagerVtbl
  IApplicationActivationManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ActivateApplication*: proc(self: ptr IApplicationActivationManager, appUserModelId: LPCWSTR, arguments: LPCWSTR, options: ACTIVATEOPTIONS, processId: ptr DWORD): HRESULT {.stdcall.}
    ActivateForFile*: proc(self: ptr IApplicationActivationManager, appUserModelId: LPCWSTR, itemArray: ptr IShellItemArray, verb: LPCWSTR, processId: ptr DWORD): HRESULT {.stdcall.}
    ActivateForProtocol*: proc(self: ptr IApplicationActivationManager, appUserModelId: LPCWSTR, itemArray: ptr IShellItemArray, processId: ptr DWORD): HRESULT {.stdcall.}
  IAssocHandlerInvoker* {.pure.} = object
    lpVtbl*: ptr IAssocHandlerInvokerVtbl
  IAssocHandlerInvokerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SupportsSelection*: proc(self: ptr IAssocHandlerInvoker): HRESULT {.stdcall.}
    Invoke*: proc(self: ptr IAssocHandlerInvoker): HRESULT {.stdcall.}
  IAssocHandler* {.pure.} = object
    lpVtbl*: ptr IAssocHandlerVtbl
  IAssocHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetName*: proc(self: ptr IAssocHandler, ppsz: ptr LPWSTR): HRESULT {.stdcall.}
    GetUIName*: proc(self: ptr IAssocHandler, ppsz: ptr LPWSTR): HRESULT {.stdcall.}
    GetIconLocation*: proc(self: ptr IAssocHandler, ppszPath: ptr LPWSTR, pIndex: ptr int32): HRESULT {.stdcall.}
    IsRecommended*: proc(self: ptr IAssocHandler): HRESULT {.stdcall.}
    MakeDefault*: proc(self: ptr IAssocHandler, pszDescription: LPCWSTR): HRESULT {.stdcall.}
    Invoke*: proc(self: ptr IAssocHandler, pdo: ptr IDataObject): HRESULT {.stdcall.}
    CreateInvoker*: proc(self: ptr IAssocHandler, pdo: ptr IDataObject, ppInvoker: ptr ptr IAssocHandlerInvoker): HRESULT {.stdcall.}
  IEnumAssocHandlers* {.pure.} = object
    lpVtbl*: ptr IEnumAssocHandlersVtbl
  IEnumAssocHandlersVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumAssocHandlers, celt: ULONG, rgelt: ptr ptr IAssocHandler, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
  IDataObjectProvider* {.pure.} = object
    lpVtbl*: ptr IDataObjectProviderVtbl
  IDataObjectProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDataObject*: proc(self: ptr IDataObjectProvider, dataObject: ptr ptr IDataObject): HRESULT {.stdcall.}
    SetDataObject*: proc(self: ptr IDataObjectProvider, dataObject: ptr IDataObject): HRESULT {.stdcall.}
  IDataTransferManagerInterop* {.pure.} = object
    lpVtbl*: ptr IDataTransferManagerInteropVtbl
  IDataTransferManagerInteropVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetForWindow*: proc(self: ptr IDataTransferManagerInterop, appWindow: HWND, riid: REFIID, dataTransferManager: ptr pointer): HRESULT {.stdcall.}
    ShowShareUIForWindow*: proc(self: ptr IDataTransferManagerInterop, appWindow: HWND): HRESULT {.stdcall.}
  IFrameworkInputPaneHandler* {.pure.} = object
    lpVtbl*: ptr IFrameworkInputPaneHandlerVtbl
  IFrameworkInputPaneHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Showing*: proc(self: ptr IFrameworkInputPaneHandler, prcInputPaneScreenLocation: ptr RECT, fEnsureFocusedElementInView: WINBOOL): HRESULT {.stdcall.}
    Hiding*: proc(self: ptr IFrameworkInputPaneHandler, fEnsureFocusedElementInView: WINBOOL): HRESULT {.stdcall.}
  IFrameworkInputPane* {.pure.} = object
    lpVtbl*: ptr IFrameworkInputPaneVtbl
  IFrameworkInputPaneVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Advise*: proc(self: ptr IFrameworkInputPane, pWindow: ptr IUnknown, pHandler: ptr IFrameworkInputPaneHandler, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    AdviseWithHWND*: proc(self: ptr IFrameworkInputPane, hwnd: HWND, pHandler: ptr IFrameworkInputPaneHandler, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IFrameworkInputPane, dwCookie: DWORD): HRESULT {.stdcall.}
    Location*: proc(self: ptr IFrameworkInputPane, prcInputPaneScreenLocation: ptr RECT): HRESULT {.stdcall.}
  ISearchableApplication* {.pure.} = object
    lpVtbl*: ptr ISearchableApplicationVtbl
  ISearchableApplicationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSearchWindow*: proc(self: ptr ISearchableApplication, hwnd: ptr HWND): HRESULT {.stdcall.}
  IAccessibilityDockingServiceCallback* {.pure.} = object
    lpVtbl*: ptr IAccessibilityDockingServiceCallbackVtbl
  IAccessibilityDockingServiceCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Undocked*: proc(self: ptr IAccessibilityDockingServiceCallback, undockReason: UNDOCK_REASON): HRESULT {.stdcall.}
  IAccessibilityDockingService* {.pure.} = object
    lpVtbl*: ptr IAccessibilityDockingServiceVtbl
  IAccessibilityDockingServiceVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetAvailableSize*: proc(self: ptr IAccessibilityDockingService, hMonitor: HMONITOR, pcxFixed: ptr UINT, pcyMax: ptr UINT): HRESULT {.stdcall.}
    DockWindow*: proc(self: ptr IAccessibilityDockingService, hwnd: HWND, hMonitor: HMONITOR, cyRequested: UINT, pCallback: ptr IAccessibilityDockingServiceCallback): HRESULT {.stdcall.}
    UndockWindow*: proc(self: ptr IAccessibilityDockingService, hwnd: HWND): HRESULT {.stdcall.}
  IAppVisibilityEvents* {.pure.} = object
    lpVtbl*: ptr IAppVisibilityEventsVtbl
  IAppVisibilityEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AppVisibilityOnMonitorChanged*: proc(self: ptr IAppVisibilityEvents, hMonitor: HMONITOR, previousMode: MONITOR_APP_VISIBILITY, currentMode: MONITOR_APP_VISIBILITY): HRESULT {.stdcall.}
    LauncherVisibilityChange*: proc(self: ptr IAppVisibilityEvents, currentVisibleState: WINBOOL): HRESULT {.stdcall.}
  IAppVisibility* {.pure.} = object
    lpVtbl*: ptr IAppVisibilityVtbl
  IAppVisibilityVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetAppVisibilityOnMonitor*: proc(self: ptr IAppVisibility, hMonitor: HMONITOR, pMode: ptr MONITOR_APP_VISIBILITY): HRESULT {.stdcall.}
    IsLauncherVisible*: proc(self: ptr IAppVisibility, pfVisible: ptr WINBOOL): HRESULT {.stdcall.}
    Advise*: proc(self: ptr IAppVisibility, pCallback: ptr IAppVisibilityEvents, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IAppVisibility, dwCookie: DWORD): HRESULT {.stdcall.}
  IPackageExecutionStateChangeNotification* {.pure.} = object
    lpVtbl*: ptr IPackageExecutionStateChangeNotificationVtbl
  IPackageExecutionStateChangeNotificationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnStateChanged*: proc(self: ptr IPackageExecutionStateChangeNotification, pszPackageFullName: LPCWSTR, pesNewState: PACKAGE_EXECUTION_STATE): HRESULT {.stdcall.}
  IPackageDebugSettings* {.pure.} = object
    lpVtbl*: ptr IPackageDebugSettingsVtbl
  IPackageDebugSettingsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EnableDebugging*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, debuggerCommandLine: LPCWSTR, environment: PZZWSTR): HRESULT {.stdcall.}
    DisableDebugging*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.stdcall.}
    Suspend*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.stdcall.}
    Resume*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.stdcall.}
    TerminateAllProcesses*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.stdcall.}
    SetTargetSessionId*: proc(self: ptr IPackageDebugSettings, sessionId: ULONG): HRESULT {.stdcall.}
    EnumerateBackgroundTasks*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, taskCount: ptr ULONG, taskIds: ptr LPCGUID, taskNames: ptr ptr LPCWSTR): HRESULT {.stdcall.}
    ActivateBackgroundTask*: proc(self: ptr IPackageDebugSettings, taskId: LPCGUID): HRESULT {.stdcall.}
    StartServicing*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.stdcall.}
    StopServicing*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.stdcall.}
    StartSessionRedirection*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, sessionId: ULONG): HRESULT {.stdcall.}
    StopSessionRedirection*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.stdcall.}
    GetPackageExecutionState*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, packageExecutionState: ptr PACKAGE_EXECUTION_STATE): HRESULT {.stdcall.}
    RegisterForPackageStateChanges*: proc(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, pPackageExecutionStateChangeNotification: ptr IPackageExecutionStateChangeNotification, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    UnregisterForPackageStateChanges*: proc(self: ptr IPackageDebugSettings, dwCookie: DWORD): HRESULT {.stdcall.}
  IExecuteCommandApplicationHostEnvironment* {.pure.} = object
    lpVtbl*: ptr IExecuteCommandApplicationHostEnvironmentVtbl
  IExecuteCommandApplicationHostEnvironmentVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetValue*: proc(self: ptr IExecuteCommandApplicationHostEnvironment, pahe: ptr AHE_TYPE): HRESULT {.stdcall.}
  IExecuteCommandHost* {.pure.} = object
    lpVtbl*: ptr IExecuteCommandHostVtbl
  IExecuteCommandHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetUIMode*: proc(self: ptr IExecuteCommandHost, pUIMode: ptr EC_HOST_UI_MODE): HRESULT {.stdcall.}
  IApplicationDesignModeSettings* {.pure.} = object
    lpVtbl*: ptr IApplicationDesignModeSettingsVtbl
  IApplicationDesignModeSettingsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetNativeDisplaySize*: proc(self: ptr IApplicationDesignModeSettings, sizeNativeDisplay: SIZE): HRESULT {.stdcall.}
    SetScaleFactor*: proc(self: ptr IApplicationDesignModeSettings, scaleFactor: DEVICE_SCALE_FACTOR): HRESULT {.stdcall.}
    SetApplicationViewState*: proc(self: ptr IApplicationDesignModeSettings, viewState: APPLICATION_VIEW_STATE): HRESULT {.stdcall.}
    ComputeApplicationSize*: proc(self: ptr IApplicationDesignModeSettings, psizeApplication: ptr SIZE): HRESULT {.stdcall.}
    IsApplicationViewStateSupported*: proc(self: ptr IApplicationDesignModeSettings, viewState: APPLICATION_VIEW_STATE, sizeNativeDisplay: SIZE, scaleFactor: DEVICE_SCALE_FACTOR, pfSupported: ptr WINBOOL): HRESULT {.stdcall.}
    TriggerEdgeGesture*: proc(self: ptr IApplicationDesignModeSettings, edgeGestureKind: EDGE_GESTURE_KIND): HRESULT {.stdcall.}
  IInitializeWithWindow* {.pure.} = object
    lpVtbl*: ptr IInitializeWithWindowVtbl
  IInitializeWithWindowVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeWithWindow, hwnd: HWND): HRESULT {.stdcall.}
  IHandlerInfo* {.pure.} = object
    lpVtbl*: ptr IHandlerInfoVtbl
  IHandlerInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetApplicationDisplayName*: proc(self: ptr IHandlerInfo, value: ptr LPWSTR): HRESULT {.stdcall.}
    GetApplicationPublisher*: proc(self: ptr IHandlerInfo, value: ptr LPWSTR): HRESULT {.stdcall.}
    GetApplicationIconReference*: proc(self: ptr IHandlerInfo, value: ptr LPWSTR): HRESULT {.stdcall.}
  IHandlerActivationHost* {.pure.} = object
    lpVtbl*: ptr IHandlerActivationHostVtbl
  IHandlerActivationHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    BeforeCoCreateInstance*: proc(self: ptr IHandlerActivationHost, clsidHandler: REFCLSID, itemsBeingActivated: ptr IShellItemArray, handlerInfo: ptr IHandlerInfo): HRESULT {.stdcall.}
    BeforeCreateProcess*: proc(self: ptr IHandlerActivationHost, applicationPath: LPCWSTR, commandLine: LPCWSTR, handlerInfo: ptr IHandlerInfo): HRESULT {.stdcall.}
  IShellIconOverlayIdentifier* {.pure.} = object
    lpVtbl*: ptr IShellIconOverlayIdentifierVtbl
  IShellIconOverlayIdentifierVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IsMemberOf*: proc(self: ptr IShellIconOverlayIdentifier, pwszPath: PCWSTR, dwAttrib: DWORD): HRESULT {.stdcall.}
    GetOverlayInfo*: proc(self: ptr IShellIconOverlayIdentifier, pwszIconFile: PWSTR, cchMax: int32, pIndex: ptr int32, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
    GetPriority*: proc(self: ptr IShellIconOverlayIdentifier, pIPriority: ptr int32): HRESULT {.stdcall.}
  IShellIconOverlayManager* {.pure.} = object
    lpVtbl*: ptr IShellIconOverlayManagerVtbl
  IShellIconOverlayManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetFileOverlayInfo*: proc(self: ptr IShellIconOverlayManager, pwszPath: PCWSTR, dwAttrib: DWORD, pIndex: ptr int32, dwflags: DWORD): HRESULT {.stdcall.}
    GetReservedOverlayInfo*: proc(self: ptr IShellIconOverlayManager, pwszPath: PCWSTR, dwAttrib: DWORD, pIndex: ptr int32, dwflags: DWORD, iReservedID: int32): HRESULT {.stdcall.}
    RefreshOverlayImages*: proc(self: ptr IShellIconOverlayManager, dwFlags: DWORD): HRESULT {.stdcall.}
    LoadNonloadedOverlayIdentifiers*: proc(self: ptr IShellIconOverlayManager): HRESULT {.stdcall.}
    OverlayIndexFromImageIndex*: proc(self: ptr IShellIconOverlayManager, iImage: int32, piIndex: ptr int32, fAdd: WINBOOL): HRESULT {.stdcall.}
  IShellIconOverlay* {.pure.} = object
    lpVtbl*: ptr IShellIconOverlayVtbl
  IShellIconOverlayVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetOverlayIndex*: proc(self: ptr IShellIconOverlay, pidl: PCUITEMID_CHILD, pIndex: ptr int32): HRESULT {.stdcall.}
    GetOverlayIconIndex*: proc(self: ptr IShellIconOverlay, pidl: PCUITEMID_CHILD, pIconIndex: ptr int32): HRESULT {.stdcall.}
  IShellExecuteHookA* {.pure.} = object
    lpVtbl*: ptr IShellExecuteHookAVtbl
  IShellExecuteHookAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Execute*: proc(self: ptr IShellExecuteHookA, pei: LPSHELLEXECUTEINFOA): HRESULT {.stdcall.}
  IShellExecuteHookW* {.pure.} = object
    lpVtbl*: ptr IShellExecuteHookWVtbl
  IShellExecuteHookWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Execute*: proc(self: ptr IShellExecuteHookW, pei: LPSHELLEXECUTEINFOW): HRESULT {.stdcall.}
  IURLSearchHook* {.pure.} = object
    lpVtbl*: ptr IURLSearchHookVtbl
  IURLSearchHookVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Translate*: proc(self: ptr IURLSearchHook, pwszSearchURL: PWSTR, cchBufferSize: DWORD): HRESULT {.stdcall.}
  ISearchContext* {.pure.} = object
    lpVtbl*: ptr ISearchContextVtbl
  ISearchContextVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSearchUrl*: proc(self: ptr ISearchContext, pbstrSearchUrl: ptr BSTR): HRESULT {.stdcall.}
    GetSearchText*: proc(self: ptr ISearchContext, pbstrSearchText: ptr BSTR): HRESULT {.stdcall.}
    GetSearchStyle*: proc(self: ptr ISearchContext, pdwSearchStyle: ptr DWORD): HRESULT {.stdcall.}
  IURLSearchHook2* {.pure.} = object
    lpVtbl*: ptr IURLSearchHook2Vtbl
  IURLSearchHook2Vtbl* {.pure, inheritable.} = object of IURLSearchHookVtbl
    TranslateWithSearchContext*: proc(self: ptr IURLSearchHook2, pwszSearchURL: PWSTR, cchBufferSize: DWORD, pSearchContext: ptr ISearchContext): HRESULT {.stdcall.}
  INewShortcutHookA* {.pure.} = object
    lpVtbl*: ptr INewShortcutHookAVtbl
  INewShortcutHookAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetReferent*: proc(self: ptr INewShortcutHookA, pcszReferent: PCSTR, hwnd: HWND): HRESULT {.stdcall.}
    GetReferent*: proc(self: ptr INewShortcutHookA, pszReferent: PSTR, cchReferent: int32): HRESULT {.stdcall.}
    SetFolder*: proc(self: ptr INewShortcutHookA, pcszFolder: PCSTR): HRESULT {.stdcall.}
    GetFolder*: proc(self: ptr INewShortcutHookA, pszFolder: PSTR, cchFolder: int32): HRESULT {.stdcall.}
    GetName*: proc(self: ptr INewShortcutHookA, pszName: PSTR, cchName: int32): HRESULT {.stdcall.}
    GetExtension*: proc(self: ptr INewShortcutHookA, pszExtension: PSTR, cchExtension: int32): HRESULT {.stdcall.}
  INewShortcutHookW* {.pure.} = object
    lpVtbl*: ptr INewShortcutHookWVtbl
  INewShortcutHookWVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetReferent*: proc(self: ptr INewShortcutHookW, pcszReferent: PCWSTR, hwnd: HWND): HRESULT {.stdcall.}
    GetReferent*: proc(self: ptr INewShortcutHookW, pszReferent: PWSTR, cchReferent: int32): HRESULT {.stdcall.}
    SetFolder*: proc(self: ptr INewShortcutHookW, pcszFolder: PCWSTR): HRESULT {.stdcall.}
    GetFolder*: proc(self: ptr INewShortcutHookW, pszFolder: PWSTR, cchFolder: int32): HRESULT {.stdcall.}
    GetName*: proc(self: ptr INewShortcutHookW, pszName: PWSTR, cchName: int32): HRESULT {.stdcall.}
    GetExtension*: proc(self: ptr INewShortcutHookW, pszExtension: PWSTR, cchExtension: int32): HRESULT {.stdcall.}
  IShellDetails* {.pure.} = object
    lpVtbl*: ptr IShellDetailsVtbl
  IShellDetailsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDetailsOf*: proc(self: ptr IShellDetails, pidl: PCUITEMID_CHILD, iColumn: UINT, pDetails: ptr SHELLDETAILS): HRESULT {.stdcall.}
    ColumnClick*: proc(self: ptr IShellDetails, iColumn: UINT): HRESULT {.stdcall.}
  IObjMgr* {.pure.} = object
    lpVtbl*: ptr IObjMgrVtbl
  IObjMgrVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Append*: proc(self: ptr IObjMgr, punk: ptr IUnknown): HRESULT {.stdcall.}
    Remove*: proc(self: ptr IObjMgr, punk: ptr IUnknown): HRESULT {.stdcall.}
  ICurrentWorkingDirectory* {.pure.} = object
    lpVtbl*: ptr ICurrentWorkingDirectoryVtbl
  ICurrentWorkingDirectoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDirectory*: proc(self: ptr ICurrentWorkingDirectory, pwzPath: PWSTR, cchSize: DWORD): HRESULT {.stdcall.}
    SetDirectory*: proc(self: ptr ICurrentWorkingDirectory, pwzPath: PCWSTR): HRESULT {.stdcall.}
  IACList* {.pure.} = object
    lpVtbl*: ptr IACListVtbl
  IACListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Expand*: proc(self: ptr IACList, pszExpand: PCWSTR): HRESULT {.stdcall.}
  IACList2* {.pure.} = object
    lpVtbl*: ptr IACList2Vtbl
  IACList2Vtbl* {.pure, inheritable.} = object of IACListVtbl
    SetOptions*: proc(self: ptr IACList2, dwFlag: DWORD): HRESULT {.stdcall.}
    GetOptions*: proc(self: ptr IACList2, pdwFlag: ptr DWORD): HRESULT {.stdcall.}
  IProgressDialog* {.pure.} = object
    lpVtbl*: ptr IProgressDialogVtbl
  IProgressDialogVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StartProgressDialog*: proc(self: ptr IProgressDialog, hwndParent: HWND, punkEnableModless: ptr IUnknown, dwFlags: DWORD, pvResevered: LPCVOID): HRESULT {.stdcall.}
    StopProgressDialog*: proc(self: ptr IProgressDialog): HRESULT {.stdcall.}
    SetTitle*: proc(self: ptr IProgressDialog, pwzTitle: PCWSTR): HRESULT {.stdcall.}
    SetAnimation*: proc(self: ptr IProgressDialog, hInstAnimation: HINSTANCE, idAnimation: UINT): HRESULT {.stdcall.}
    HasUserCancelled*: proc(self: ptr IProgressDialog): WINBOOL {.stdcall.}
    SetProgress*: proc(self: ptr IProgressDialog, dwCompleted: DWORD, dwTotal: DWORD): HRESULT {.stdcall.}
    SetProgress64*: proc(self: ptr IProgressDialog, ullCompleted: ULONGLONG, ullTotal: ULONGLONG): HRESULT {.stdcall.}
    SetLine*: proc(self: ptr IProgressDialog, dwLineNum: DWORD, pwzString: PCWSTR, fCompactPath: WINBOOL, pvResevered: LPCVOID): HRESULT {.stdcall.}
    SetCancelMsg*: proc(self: ptr IProgressDialog, pwzCancelMsg: PCWSTR, pvResevered: LPCVOID): HRESULT {.stdcall.}
    Timer*: proc(self: ptr IProgressDialog, dwTimerAction: DWORD, pvResevered: LPCVOID): HRESULT {.stdcall.}
  IDockingWindowSite* {.pure.} = object
    lpVtbl*: ptr IDockingWindowSiteVtbl
  IDockingWindowSiteVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    GetBorderDW*: proc(self: ptr IDockingWindowSite, punkObj: ptr IUnknown, prcBorder: ptr RECT): HRESULT {.stdcall.}
    RequestBorderSpaceDW*: proc(self: ptr IDockingWindowSite, punkObj: ptr IUnknown, pbw: LPCBORDERWIDTHS): HRESULT {.stdcall.}
    SetBorderSpaceDW*: proc(self: ptr IDockingWindowSite, punkObj: ptr IUnknown, pbw: LPCBORDERWIDTHS): HRESULT {.stdcall.}
  IDockingWindowFrame* {.pure.} = object
    lpVtbl*: ptr IDockingWindowFrameVtbl
  IDockingWindowFrameVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    AddToolbar*: proc(self: ptr IDockingWindowFrame, punkSrc: ptr IUnknown, pwszItem: PCWSTR, dwAddFlags: DWORD): HRESULT {.stdcall.}
    RemoveToolbar*: proc(self: ptr IDockingWindowFrame, punkSrc: ptr IUnknown, dwRemoveFlags: DWORD): HRESULT {.stdcall.}
    FindToolbar*: proc(self: ptr IDockingWindowFrame, pwszItem: PCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IShellFolderBand* {.pure.} = object
    lpVtbl*: ptr IShellFolderBandVtbl
  IShellFolderBandVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InitializeSFB*: proc(self: ptr IShellFolderBand, psf: ptr IShellFolder, pidl: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
    SetBandInfoSFB*: proc(self: ptr IShellFolderBand, pbi: PBANDINFOSFB): HRESULT {.stdcall.}
    GetBandInfoSFB*: proc(self: ptr IShellFolderBand, pbi: PBANDINFOSFB): HRESULT {.stdcall.}
  IDeskBarClient* {.pure.} = object
    lpVtbl*: ptr IDeskBarClientVtbl
  IDeskBarClientVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    SetDeskBarSite*: proc(self: ptr IDeskBarClient, punkSite: ptr IUnknown): HRESULT {.stdcall.}
    SetModeDBC*: proc(self: ptr IDeskBarClient, dwMode: DWORD): HRESULT {.stdcall.}
    UIActivateDBC*: proc(self: ptr IDeskBarClient, dwState: DWORD): HRESULT {.stdcall.}
    GetSize*: proc(self: ptr IDeskBarClient, dwWhich: DWORD, prc: LPRECT): HRESULT {.stdcall.}
  IColumnProvider* {.pure.} = object
    lpVtbl*: ptr IColumnProviderVtbl
  IColumnProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IColumnProvider, psci: LPCSHCOLUMNINIT): HRESULT {.stdcall.}
    GetColumnInfo*: proc(self: ptr IColumnProvider, dwIndex: DWORD, psci: ptr SHCOLUMNINFO): HRESULT {.stdcall.}
    GetItemData*: proc(self: ptr IColumnProvider, pscid: LPCSHCOLUMNID, pscd: LPCSHCOLUMNDATA, pvarData: ptr VARIANT): HRESULT {.stdcall.}
  IShellChangeNotify* {.pure.} = object
    lpVtbl*: ptr IShellChangeNotifyVtbl
  IShellChangeNotifyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnChange*: proc(self: ptr IShellChangeNotify, lEvent: LONG, pidl1: PCIDLIST_ABSOLUTE, pidl2: PCIDLIST_ABSOLUTE): HRESULT {.stdcall.}
  IQueryInfo* {.pure.} = object
    lpVtbl*: ptr IQueryInfoVtbl
  IQueryInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetInfoTip*: proc(self: ptr IQueryInfo, dwFlags: DWORD, ppwszTip: ptr PWSTR): HRESULT {.stdcall.}
    GetInfoFlags*: proc(self: ptr IQueryInfo, pdwFlags: ptr DWORD): HRESULT {.stdcall.}
  IDefViewFrame* {.pure.} = object
    lpVtbl*: ptr IDefViewFrameVtbl
  IDefViewFrameVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetWindowLV*: proc(self: ptr IDefViewFrame, phwnd: ptr HWND): HRESULT {.stdcall.}
    ReleaseWindowLV*: proc(self: ptr IDefViewFrame): HRESULT {.stdcall.}
    GetShellFolder*: proc(self: ptr IDefViewFrame, ppsf: ptr ptr IShellFolder): HRESULT {.stdcall.}
  IDocViewSite* {.pure.} = object
    lpVtbl*: ptr IDocViewSiteVtbl
  IDocViewSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnSetTitle*: proc(self: ptr IDocViewSite, pvTitle: ptr VARIANTARG): HRESULT {.stdcall.}
  IInitializeObject* {.pure.} = object
    lpVtbl*: ptr IInitializeObjectVtbl
  IInitializeObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeObject): HRESULT {.stdcall.}
  IBanneredBar* {.pure.} = object
    lpVtbl*: ptr IBanneredBarVtbl
  IBanneredBarVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetIconSize*: proc(self: ptr IBanneredBar, iIcon: DWORD): HRESULT {.stdcall.}
    GetIconSize*: proc(self: ptr IBanneredBar, piIcon: ptr DWORD): HRESULT {.stdcall.}
    SetBitmap*: proc(self: ptr IBanneredBar, hBitmap: HBITMAP): HRESULT {.stdcall.}
    GetBitmap*: proc(self: ptr IBanneredBar, phBitmap: ptr HBITMAP): HRESULT {.stdcall.}
  IShellFolderView* {.pure.} = object
    lpVtbl*: ptr IShellFolderViewVtbl
  IShellFolderViewVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Rearrange*: proc(self: ptr IShellFolderView, lParamSort: LPARAM): HRESULT {.stdcall.}
    GetArrangeParam*: proc(self: ptr IShellFolderView, plParamSort: ptr LPARAM): HRESULT {.stdcall.}
    ArrangeGrid*: proc(self: ptr IShellFolderView): HRESULT {.stdcall.}
    AutoArrange*: proc(self: ptr IShellFolderView): HRESULT {.stdcall.}
    GetAutoArrange*: proc(self: ptr IShellFolderView): HRESULT {.stdcall.}
    AddObject*: proc(self: ptr IShellFolderView, pidl: PUITEMID_CHILD, puItem: ptr UINT): HRESULT {.stdcall.}
    GetObject*: proc(self: ptr IShellFolderView, ppidl: ptr PITEMID_CHILD, uItem: UINT): HRESULT {.stdcall.}
    RemoveObject*: proc(self: ptr IShellFolderView, pidl: PUITEMID_CHILD, puItem: ptr UINT): HRESULT {.stdcall.}
    GetObjectCount*: proc(self: ptr IShellFolderView, puCount: ptr UINT): HRESULT {.stdcall.}
    SetObjectCount*: proc(self: ptr IShellFolderView, uCount: UINT, dwFlags: UINT): HRESULT {.stdcall.}
    UpdateObject*: proc(self: ptr IShellFolderView, pidlOld: PUITEMID_CHILD, pidlNew: PUITEMID_CHILD, puItem: ptr UINT): HRESULT {.stdcall.}
    RefreshObject*: proc(self: ptr IShellFolderView, pidl: PUITEMID_CHILD, puItem: ptr UINT): HRESULT {.stdcall.}
    SetRedraw*: proc(self: ptr IShellFolderView, bRedraw: WINBOOL): HRESULT {.stdcall.}
    GetSelectedCount*: proc(self: ptr IShellFolderView, puSelected: ptr UINT): HRESULT {.stdcall.}
    GetSelectedObjects*: proc(self: ptr IShellFolderView, pppidl: ptr ptr PCUITEMID_CHILD, puItems: ptr UINT): HRESULT {.stdcall.}
    IsDropOnSource*: proc(self: ptr IShellFolderView, pDropTarget: ptr IDropTarget): HRESULT {.stdcall.}
    GetDragPoint*: proc(self: ptr IShellFolderView, ppt: ptr POINT): HRESULT {.stdcall.}
    GetDropPoint*: proc(self: ptr IShellFolderView, ppt: ptr POINT): HRESULT {.stdcall.}
    MoveIcons*: proc(self: ptr IShellFolderView, pDataObject: ptr IDataObject): HRESULT {.stdcall.}
    SetItemPos*: proc(self: ptr IShellFolderView, pidl: PCUITEMID_CHILD, ppt: ptr POINT): HRESULT {.stdcall.}
    IsBkDropTarget*: proc(self: ptr IShellFolderView, pDropTarget: ptr IDropTarget): HRESULT {.stdcall.}
    SetClipboard*: proc(self: ptr IShellFolderView, bMove: WINBOOL): HRESULT {.stdcall.}
    SetPoints*: proc(self: ptr IShellFolderView, pDataObject: ptr IDataObject): HRESULT {.stdcall.}
    GetItemSpacing*: proc(self: ptr IShellFolderView, pSpacing: ptr ITEMSPACING): HRESULT {.stdcall.}
    SetCallback*: proc(self: ptr IShellFolderView, pNewCB: ptr IShellFolderViewCB, ppOldCB: ptr ptr IShellFolderViewCB): HRESULT {.stdcall.}
    Select*: proc(self: ptr IShellFolderView, dwFlags: UINT): HRESULT {.stdcall.}
    QuerySupport*: proc(self: ptr IShellFolderView, pdwSupport: ptr UINT): HRESULT {.stdcall.}
    SetAutomationObject*: proc(self: ptr IShellFolderView, pdisp: ptr IDispatch): HRESULT {.stdcall.}
  INamedPropertyBag* {.pure.} = object
    lpVtbl*: ptr INamedPropertyBagVtbl
  INamedPropertyBagVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ReadPropertyNPB*: proc(self: ptr INamedPropertyBag, pszBagname: PCWSTR, pszPropName: PCWSTR, pVar: ptr PROPVARIANT): HRESULT {.stdcall.}
    WritePropertyNPB*: proc(self: ptr INamedPropertyBag, pszBagname: PCWSTR, pszPropName: PCWSTR, pVar: ptr PROPVARIANT): HRESULT {.stdcall.}
    RemovePropertyNPB*: proc(self: ptr INamedPropertyBag, pszBagname: PCWSTR, pszPropName: PCWSTR): HRESULT {.stdcall.}
proc DragQueryFileA*(hDrop: HDROP, iFile: UINT, lpszFile: LPSTR, cch: UINT): UINT {.winapi, stdcall, dynlib: "shell32", importc.}
proc DragQueryFileW*(hDrop: HDROP, iFile: UINT, lpszFile: LPWSTR, cch: UINT): UINT {.winapi, stdcall, dynlib: "shell32", importc.}
proc DragQueryPoint*(hDrop: HDROP, ppt: ptr POINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc DragFinish*(hDrop: HDROP): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc DragAcceptFiles*(hWnd: HWND, fAccept: WINBOOL): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc ShellExecuteA*(hwnd: HWND, lpOperation: LPCSTR, lpFile: LPCSTR, lpParameters: LPCSTR, lpDirectory: LPCSTR, nShowCmd: INT): HINSTANCE {.winapi, stdcall, dynlib: "shell32", importc.}
proc ShellExecuteW*(hwnd: HWND, lpOperation: LPCWSTR, lpFile: LPCWSTR, lpParameters: LPCWSTR, lpDirectory: LPCWSTR, nShowCmd: INT): HINSTANCE {.winapi, stdcall, dynlib: "shell32", importc.}
proc FindExecutableA*(lpFile: LPCSTR, lpDirectory: LPCSTR, lpResult: LPSTR): HINSTANCE {.winapi, stdcall, dynlib: "shell32", importc.}
proc FindExecutableW*(lpFile: LPCWSTR, lpDirectory: LPCWSTR, lpResult: LPWSTR): HINSTANCE {.winapi, stdcall, dynlib: "shell32", importc.}
proc CommandLineToArgvW*(lpCmdLine: LPCWSTR, pNumArgs: ptr int32): ptr LPWSTR {.winapi, stdcall, dynlib: "shell32", importc.}
proc ShellAboutA*(hWnd: HWND, szApp: LPCSTR, szOtherStuff: LPCSTR, hIcon: HICON): INT {.winapi, stdcall, dynlib: "shell32", importc.}
proc ShellAboutW*(hWnd: HWND, szApp: LPCWSTR, szOtherStuff: LPCWSTR, hIcon: HICON): INT {.winapi, stdcall, dynlib: "shell32", importc.}
proc DuplicateIcon*(hInst: HINSTANCE, hIcon: HICON): HICON {.winapi, stdcall, dynlib: "shell32", importc.}
proc ExtractAssociatedIconA*(hInst: HINSTANCE, pszIconPath: LPSTR, piIcon: ptr WORD): HICON {.winapi, stdcall, dynlib: "shell32", importc.}
proc ExtractAssociatedIconW*(hInst: HINSTANCE, pszIconPath: LPWSTR, piIcon: ptr WORD): HICON {.winapi, stdcall, dynlib: "shell32", importc.}
proc ExtractAssociatedIconExA*(hInst: HINSTANCE, pszIconPath: LPSTR, piIconIndex: ptr WORD, piIconId: ptr WORD): HICON {.winapi, stdcall, dynlib: "shell32", importc.}
proc ExtractAssociatedIconExW*(hInst: HINSTANCE, pszIconPath: LPWSTR, piIconIndex: ptr WORD, piIconId: ptr WORD): HICON {.winapi, stdcall, dynlib: "shell32", importc.}
proc ExtractIconA*(hInst: HINSTANCE, pszExeFileName: LPCSTR, nIconIndex: UINT): HICON {.winapi, stdcall, dynlib: "shell32", importc.}
proc ExtractIconW*(hInst: HINSTANCE, pszExeFileName: LPCWSTR, nIconIndex: UINT): HICON {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHAppBarMessage*(dwMessage: DWORD, pData: PAPPBARDATA): UINT_PTR {.winapi, stdcall, dynlib: "shell32", importc.}
proc DoEnvironmentSubstA*(pszSrc: LPSTR, cchSrc: UINT): DWORD {.winapi, stdcall, dynlib: "shell32", importc.}
proc DoEnvironmentSubstW*(pszSrc: LPWSTR, cchSrc: UINT): DWORD {.winapi, stdcall, dynlib: "shell32", importc.}
proc ExtractIconExA*(lpszFile: LPCSTR, nIconIndex: int32, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIcons: UINT): UINT {.winapi, stdcall, dynlib: "shell32", importc.}
proc ExtractIconExW*(lpszFile: LPCWSTR, nIconIndex: int32, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIcons: UINT): UINT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHFileOperationA*(lpFileOp: LPSHFILEOPSTRUCTA): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHFileOperationW*(lpFileOp: LPSHFILEOPSTRUCTW): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHFreeNameMappings*(hNameMappings: HANDLE): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc ShellExecuteExA*(pExecInfo: ptr SHELLEXECUTEINFOA): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc ShellExecuteExW*(pExecInfo: ptr SHELLEXECUTEINFOW): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateProcessAsUserW*(pscpi: PSHCREATEPROCESSINFOW): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHEvaluateSystemCommandTemplate*(pszCmdTemplate: PCWSTR, ppszApplication: ptr PWSTR, ppszCommandLine: ptr PWSTR, ppszParameters: ptr PWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc AssocCreateForClasses*(rgClasses: ptr ASSOCIATIONELEMENT, cClasses: ULONG, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHQueryRecycleBinA*(pszRootPath: LPCSTR, pSHQueryRBInfo: LPSHQUERYRBINFO): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHQueryRecycleBinW*(pszRootPath: LPCWSTR, pSHQueryRBInfo: LPSHQUERYRBINFO): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHEmptyRecycleBinA*(hwnd: HWND, pszRootPath: LPCSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHEmptyRecycleBinW*(hwnd: HWND, pszRootPath: LPCWSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHQueryUserNotificationState*(pquns: ptr QUERY_USER_NOTIFICATION_STATE): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetPropertyStoreForWindow*(hwnd: HWND, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc Shell_NotifyIconA*(dwMessage: DWORD, lpData: PNOTIFYICONDATAA): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc Shell_NotifyIconW*(dwMessage: DWORD, lpData: PNOTIFYICONDATAW): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc Shell_NotifyIconGetRect*(identifier: ptr NOTIFYICONIDENTIFIER, iconLocation: ptr RECT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetFileInfoA*(pszPath: LPCSTR, dwFileAttributes: DWORD, psfi: ptr SHFILEINFOA, cbFileInfo: UINT, uFlags: UINT): DWORD_PTR {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetFileInfoW*(pszPath: LPCWSTR, dwFileAttributes: DWORD, psfi: ptr SHFILEINFOW, cbFileInfo: UINT, uFlags: UINT): DWORD_PTR {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetStockIconInfo*(siid: SHSTOCKICONID, uFlags: UINT, psii: ptr SHSTOCKICONINFO): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetDiskFreeSpaceExA*(pszDirectoryName: LPCSTR, pulFreeBytesAvailableToCaller: ptr ULARGE_INTEGER, pulTotalNumberOfBytes: ptr ULARGE_INTEGER, pulTotalNumberOfFreeBytes: ptr ULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetDiskFreeSpaceExW*(pszDirectoryName: LPCWSTR, pulFreeBytesAvailableToCaller: ptr ULARGE_INTEGER, pulTotalNumberOfBytes: ptr ULARGE_INTEGER, pulTotalNumberOfFreeBytes: ptr ULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetNewLinkInfoA*(pszLinkTo: LPCSTR, pszDir: LPCSTR, pszName: LPSTR, pfMustCopy: ptr WINBOOL, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetNewLinkInfoW*(pszLinkTo: LPCWSTR, pszDir: LPCWSTR, pszName: LPWSTR, pfMustCopy: ptr WINBOOL, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHInvokePrinterCommandA*(hwnd: HWND, uAction: UINT, lpBuf1: LPCSTR, lpBuf2: LPCSTR, fModal: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHInvokePrinterCommandW*(hwnd: HWND, uAction: UINT, lpBuf1: LPCWSTR, lpBuf2: LPCWSTR, fModal: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHLoadNonloadedIconOverlayIdentifiers*(): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHIsFileAvailableOffline*(pwszPath: PCWSTR, pdwStatus: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSetLocalizedName*(pszPath: PCWSTR, pszResModule: PCWSTR, idsRes: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHRemoveLocalizedName*(pszPath: PCWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetLocalizedName*(pszPath: PCWSTR, pszResModule: PWSTR, cch: UINT, pidsRes: ptr int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc ShellMessageBoxA*(hAppInst: HINSTANCE, hWnd: HWND, lpcText: LPCSTR, lpcTitle: LPCSTR, fuStyle: UINT): int32 {.winapi, cdecl, varargs, dynlib: "shlwapi", importc.}
proc ShellMessageBoxW*(hAppInst: HINSTANCE, hWnd: HWND, lpcText: LPCWSTR, lpcTitle: LPCWSTR, fuStyle: UINT): int32 {.winapi, cdecl, varargs, dynlib: "shlwapi", importc.}
proc IsLFNDriveA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc IsLFNDriveW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHEnumerateUnreadMailAccountsW*(hKeyUser: HKEY, dwIndex: DWORD, pszMailAddress: LPWSTR, cchMailAddress: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetUnreadMailCountW*(hKeyUser: HKEY, pszMailAddress: LPCWSTR, pdwCount: ptr DWORD, pFileTime: ptr FILETIME, pszShellExecuteCommand: LPWSTR, cchShellExecuteCommand: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSetUnreadMailCountW*(pszMailAddress: LPCWSTR, dwCount: DWORD, pszShellExecuteCommand: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHTestTokenMembership*(hToken: HANDLE, ulRID: ULONG): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetImageList*(iImageList: int32, riid: REFIID, ppvObj: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc InitNetworkAddressControl*(): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetDriveMedia*(pszDrive: PCWSTR, pdwMediaContent: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc StrChrA*(lpStart: LPCSTR, wMatch: WORD): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrChrW*(lpStart: LPCWSTR, wMatch: WCHAR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrChrIA*(lpStart: LPCSTR, wMatch: WORD): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrChrIW*(lpStart: LPCWSTR, wMatch: WCHAR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpNA*(lpStr1: LPCSTR, lpStr2: LPCSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpNW*(lpStr1: LPCWSTR, lpStr2: LPCWSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpNIA*(lpStr1: LPCSTR, lpStr2: LPCSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpNIW*(lpStr1: LPCWSTR, lpStr2: LPCWSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCSpnA*(lpStr: LPCSTR, lpSet: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCSpnW*(lpStr: LPCWSTR, lpSet: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCSpnIA*(lpStr: LPCSTR, lpSet: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCSpnIW*(lpStr: LPCWSTR, lpSet: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrDupA*(lpSrch: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrDupW*(lpSrch: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrFormatByteSizeA*(dw: DWORD, szBuf: LPSTR, uiBufSize: UINT): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrFormatByteSize64A*(qdw: LONGLONG, szBuf: LPSTR, uiBufSize: UINT): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrFormatByteSizeW*(qdw: LONGLONG, szBuf: LPWSTR, uiBufSize: UINT): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrFormatKBSizeW*(qdw: LONGLONG, szBuf: LPWSTR, uiBufSize: UINT): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrFormatKBSizeA*(qdw: LONGLONG, szBuf: LPSTR, uiBufSize: UINT): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrFromTimeIntervalA*(pszOut: LPSTR, cchMax: UINT, dwTimeMS: DWORD, digits: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrFromTimeIntervalW*(pszOut: LPWSTR, cchMax: UINT, dwTimeMS: DWORD, digits: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrIsIntlEqualA*(fCaseSens: WINBOOL, lpString1: LPCSTR, lpString2: LPCSTR, nChar: int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrIsIntlEqualW*(fCaseSens: WINBOOL, lpString1: LPCWSTR, lpString2: LPCWSTR, nChar: int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrNCatA*(psz1: LPSTR, psz2: LPCSTR, cchMax: int32): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrNCatW*(psz1: LPWSTR, psz2: LPCWSTR, cchMax: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrPBrkA*(psz: LPCSTR, pszSet: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrPBrkW*(psz: LPCWSTR, pszSet: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRChrA*(lpStart: LPCSTR, lpEnd: LPCSTR, wMatch: WORD): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRChrW*(lpStart: LPCWSTR, lpEnd: LPCWSTR, wMatch: WCHAR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRChrIA*(lpStart: LPCSTR, lpEnd: LPCSTR, wMatch: WORD): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRChrIW*(lpStart: LPCWSTR, lpEnd: LPCWSTR, wMatch: WCHAR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRStrIA*(lpSource: LPCSTR, lpLast: LPCSTR, lpSrch: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRStrIW*(lpSource: LPCWSTR, lpLast: LPCWSTR, lpSrch: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrSpnA*(psz: LPCSTR, pszSet: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrSpnW*(psz: LPCWSTR, pszSet: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrStrA*(lpFirst: LPCSTR, lpSrch: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrStrW*(lpFirst: LPCWSTR, lpSrch: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrStrIA*(lpFirst: LPCSTR, lpSrch: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrStrIW*(lpFirst: LPCWSTR, lpSrch: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrToIntA*(lpSrc: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrToIntW*(lpSrc: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrToIntExA*(pszString: LPCSTR, dwFlags: DWORD, piRet: ptr int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrToIntExW*(pszString: LPCWSTR, dwFlags: DWORD, piRet: ptr int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrToInt64ExA*(pszString: LPCSTR, dwFlags: DWORD, pllRet: ptr LONGLONG): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrToInt64ExW*(pszString: LPCWSTR, dwFlags: DWORD, pllRet: ptr LONGLONG): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrTrimA*(psz: LPSTR, pszTrimChars: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrTrimW*(psz: LPWSTR, pszTrimChars: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCatW*(psz1: LPWSTR, psz2: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpW*(psz1: LPCWSTR, psz2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpIW*(psz1: LPCWSTR, psz2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCpyW*(psz1: LPWSTR, psz2: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCpyNW*(psz1: LPWSTR, psz2: LPCWSTR, cchMax: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCatBuffW*(pszDest: LPWSTR, pszSrc: LPCWSTR, cchDestBuffSize: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCatBuffA*(pszDest: LPSTR, pszSrc: LPCSTR, cchDestBuffSize: int32): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc ChrCmpIA*(w1: WORD, w2: WORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc ChrCmpIW*(w1: WCHAR, w2: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc wvnsprintfA*(lpOut: LPSTR, cchLimitIn: int32, lpFmt: LPCSTR, arglist: va_list): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc wvnsprintfW*(lpOut: LPWSTR, cchLimitIn: int32, lpFmt: LPCWSTR, arglist: va_list): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc wnsprintfA*(lpOut: LPSTR, cchLimitIn: int32, lpFmt: LPCSTR): int32 {.winapi, cdecl, varargs, dynlib: "shlwapi", importc.}
proc wnsprintfW*(lpOut: LPWSTR, cchLimitIn: int32, lpFmt: LPCWSTR): int32 {.winapi, cdecl, varargs, dynlib: "shlwapi", importc.}
proc StrRetToStrA*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, ppsz: ptr LPSTR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRetToStrW*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, ppsz: ptr LPWSTR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRetToBufA*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, pszBuf: LPSTR, cchBuf: UINT): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRetToBufW*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, pszBuf: LPWSTR, cchBuf: UINT): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrRetToBSTR*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, pbstr: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHStrDupA*(psz: LPCSTR, ppwsz: ptr ptr WCHAR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHStrDupW*(psz: LPCWSTR, ppwsz: ptr ptr WCHAR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpLogicalW*(psz1: LPCWSTR, psz2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCatChainW*(pszDst: LPWSTR, cchDst: DWORD, ichAt: DWORD, pszSrc: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHLoadIndirectString*(pszSource: LPCWSTR, pszOutBuf: LPWSTR, cchOutBuf: UINT, ppvReserved: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc IsCharSpaceA*(wch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc IsCharSpaceW*(wch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpCA*(pszStr1: LPCSTR, pszStr2: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpCW*(pszStr1: LPCWSTR, pszStr2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpICA*(pszStr1: LPCSTR, pszStr2: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc StrCmpICW*(pszStr1: LPCWSTR, pszStr2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc IntlStrEqWorkerA*(fCaseSens: WINBOOL, lpString1: LPCSTR, lpString2: LPCSTR, nChar: int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc IntlStrEqWorkerW*(fCaseSens: WINBOOL, lpString1: LPCWSTR, lpString2: LPCWSTR, nChar: int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathAddBackslashA*(pszPath: LPSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathAddBackslashW*(pszPath: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathAddExtensionA*(pszPath: LPSTR, pszExt: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathAddExtensionW*(pszPath: LPWSTR, pszExt: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathAppendA*(pszPath: LPSTR, pMore: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathAppendW*(pszPath: LPWSTR, pMore: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathBuildRootA*(pszRoot: LPSTR, iDrive: int32): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathBuildRootW*(pszRoot: LPWSTR, iDrive: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCanonicalizeA*(pszBuf: LPSTR, pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCanonicalizeW*(pszBuf: LPWSTR, pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCombineA*(pszDest: LPSTR, pszDir: LPCSTR, pszFile: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCombineW*(pszDest: LPWSTR, pszDir: LPCWSTR, pszFile: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCompactPathA*(hDC: HDC, pszPath: LPSTR, dx: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCompactPathW*(hDC: HDC, pszPath: LPWSTR, dx: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCompactPathExA*(pszOut: LPSTR, pszSrc: LPCSTR, cchMax: UINT, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCompactPathExW*(pszOut: LPWSTR, pszSrc: LPCWSTR, cchMax: UINT, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCommonPrefixA*(pszFile1: LPCSTR, pszFile2: LPCSTR, achPath: LPSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCommonPrefixW*(pszFile1: LPCWSTR, pszFile2: LPCWSTR, achPath: LPWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFileExistsA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFileExistsW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindExtensionA*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindExtensionW*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindFileNameA*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindFileNameW*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindNextComponentA*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindNextComponentW*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindOnPathA*(pszPath: LPSTR, ppszOtherDirs: ptr LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindOnPathW*(pszPath: LPWSTR, ppszOtherDirs: ptr LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathGetArgsA*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathGetArgsW*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindSuffixArrayA*(pszPath: LPCSTR, apszSuffix: ptr LPCSTR, iArraySize: int32): LPCSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathFindSuffixArrayW*(pszPath: LPCWSTR, apszSuffix: ptr LPCWSTR, iArraySize: int32): LPCWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsLFNFileSpecA*(lpName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsLFNFileSpecW*(lpName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathGetCharTypeA*(ch: UCHAR): UINT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathGetCharTypeW*(ch: WCHAR): UINT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathGetDriveNumberA*(pszPath: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathGetDriveNumberW*(pszPath: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsDirectoryA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsDirectoryW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsDirectoryEmptyA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsDirectoryEmptyW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsFileSpecA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsFileSpecW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsPrefixA*(pszPrefix: LPCSTR, pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsPrefixW*(pszPrefix: LPCWSTR, pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsRelativeA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsRelativeW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsRootA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsRootW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsSameRootA*(pszPath1: LPCSTR, pszPath2: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsSameRootW*(pszPath1: LPCWSTR, pszPath2: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsUNCA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsUNCW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsNetworkPathA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsNetworkPathW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsUNCServerA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsUNCServerW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsUNCServerShareA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsUNCServerShareW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsContentTypeA*(pszPath: LPCSTR, pszContentType: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsContentTypeW*(pszPath: LPCWSTR, pszContentType: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsURLA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsURLW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathMakePrettyA*(pszPath: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathMakePrettyW*(pszPath: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathMatchSpecA*(pszFile: LPCSTR, pszSpec: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathMatchSpecW*(pszFile: LPCWSTR, pszSpec: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathParseIconLocationA*(pszIconFile: LPSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathParseIconLocationW*(pszIconFile: LPWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathQuoteSpacesA*(lpsz: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathQuoteSpacesW*(lpsz: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRelativePathToA*(pszPath: LPSTR, pszFrom: LPCSTR, dwAttrFrom: DWORD, pszTo: LPCSTR, dwAttrTo: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRelativePathToW*(pszPath: LPWSTR, pszFrom: LPCWSTR, dwAttrFrom: DWORD, pszTo: LPCWSTR, dwAttrTo: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveArgsA*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveArgsW*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveBackslashA*(pszPath: LPSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveBackslashW*(pszPath: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveBlanksA*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveBlanksW*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveExtensionA*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveExtensionW*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveFileSpecA*(pszPath: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRemoveFileSpecW*(pszPath: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRenameExtensionA*(pszPath: LPSTR, pszExt: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathRenameExtensionW*(pszPath: LPWSTR, pszExt: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathSearchAndQualifyA*(pszPath: LPCSTR, pszBuf: LPSTR, cchBuf: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathSearchAndQualifyW*(pszPath: LPCWSTR, pszBuf: LPWSTR, cchBuf: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathSetDlgItemPathA*(hDlg: HWND, id: int32, pszPath: LPCSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathSetDlgItemPathW*(hDlg: HWND, id: int32, pszPath: LPCWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathSkipRootA*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathSkipRootW*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathStripPathA*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathStripPathW*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathStripToRootA*(pszPath: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathStripToRootW*(pszPath: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathUnquoteSpacesA*(lpsz: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathUnquoteSpacesW*(lpsz: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathMakeSystemFolderA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathMakeSystemFolderW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathUnmakeSystemFolderA*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathUnmakeSystemFolderW*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsSystemFolderA*(pszPath: LPCSTR, dwAttrb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathIsSystemFolderW*(pszPath: LPCWSTR, dwAttrb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathUndecorateA*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathUndecorateW*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathUnExpandEnvStringsA*(pszPath: LPCSTR, pszBuf: LPSTR, cchBuf: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathUnExpandEnvStringsW*(pszPath: LPCWSTR, pszBuf: LPWSTR, cchBuf: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlCompareA*(psz1: LPCSTR, psz2: LPCSTR, fIgnoreSlash: WINBOOL): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlCompareW*(psz1: LPCWSTR, psz2: LPCWSTR, fIgnoreSlash: WINBOOL): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlCombineA*(pszBase: LPCSTR, pszRelative: LPCSTR, pszCombined: LPSTR, pcchCombined: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlCombineW*(pszBase: LPCWSTR, pszRelative: LPCWSTR, pszCombined: LPWSTR, pcchCombined: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlCanonicalizeA*(pszUrl: LPCSTR, pszCanonicalized: LPSTR, pcchCanonicalized: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlCanonicalizeW*(pszUrl: LPCWSTR, pszCanonicalized: LPWSTR, pcchCanonicalized: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlIsOpaqueA*(pszURL: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlIsOpaqueW*(pszURL: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlIsNoHistoryA*(pszURL: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlIsNoHistoryW*(pszURL: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlIsA*(pszUrl: LPCSTR, UrlIs: TURLIS): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlIsW*(pszUrl: LPCWSTR, UrlIs: TURLIS): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlGetLocationA*(psz1: LPCSTR): LPCSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlGetLocationW*(psz1: LPCWSTR): LPCWSTR {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlUnescapeA*(pszUrl: LPSTR, pszUnescaped: LPSTR, pcchUnescaped: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlUnescapeW*(pszUrl: LPWSTR, pszUnescaped: LPWSTR, pcchUnescaped: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlEscapeA*(pszUrl: LPCSTR, pszEscaped: LPSTR, pcchEscaped: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlEscapeW*(pszUrl: LPCWSTR, pszEscaped: LPWSTR, pcchEscaped: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlCreateFromPathA*(pszPath: LPCSTR, pszUrl: LPSTR, pcchUrl: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlCreateFromPathW*(pszPath: LPCWSTR, pszUrl: LPWSTR, pcchUrl: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCreateFromUrlA*(pszUrl: LPCSTR, pszPath: LPSTR, pcchPath: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc PathCreateFromUrlW*(pszUrl: LPCWSTR, pszPath: LPWSTR, pcchPath: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlHashA*(pszUrl: LPCSTR, pbHash: LPBYTE, cbHash: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlHashW*(pszUrl: LPCWSTR, pbHash: LPBYTE, cbHash: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlGetPartW*(pszIn: LPCWSTR, pszOut: LPWSTR, pcchOut: LPDWORD, dwPart: DWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlGetPartA*(pszIn: LPCSTR, pszOut: LPSTR, pcchOut: LPDWORD, dwPart: DWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlApplySchemeA*(pszIn: LPCSTR, pszOut: LPSTR, pcchOut: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc UrlApplySchemeW*(pszIn: LPCWSTR, pszOut: LPWSTR, pcchOut: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc HashData*(pbData: LPBYTE, cbData: DWORD, pbHash: LPBYTE, cbHash: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHDeleteEmptyKeyA*(hkey: HKEY, pszSubKey: LPCSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHDeleteEmptyKeyW*(hkey: HKEY, pszSubKey: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHDeleteKeyA*(hkey: HKEY, pszSubKey: LPCSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHDeleteKeyW*(hkey: HKEY, pszSubKey: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegDuplicateHKey*(hkey: HKEY): HKEY {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHDeleteValueA*(hkey: HKEY, pszSubKey: LPCSTR, pszValue: LPCSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHDeleteValueW*(hkey: HKEY, pszSubKey: LPCWSTR, pszValue: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHGetValueA*(hkey: HKEY, pszSubKey: LPCSTR, pszValue: LPCSTR, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHGetValueW*(hkey: HKEY, pszSubKey: LPCWSTR, pszValue: LPCWSTR, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHSetValueA*(hkey: HKEY, pszSubKey: LPCSTR, pszValue: LPCSTR, dwType: DWORD, pvData: LPCVOID, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHSetValueW*(hkey: HKEY, pszSubKey: LPCWSTR, pszValue: LPCWSTR, dwType: DWORD, pvData: LPCVOID, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetValueA*(hkey: HKEY, pszSubKey: LPCSTR, pszValue: LPCSTR, dwFlags: SRRF, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetValueW*(hkey: HKEY, pszSubKey: LPCWSTR, pszValue: LPCWSTR, dwFlags: SRRF, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHQueryValueExA*(hkey: HKEY, pszValue: LPCSTR, pdwReserved: ptr DWORD, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHQueryValueExW*(hkey: HKEY, pszValue: LPCWSTR, pdwReserved: ptr DWORD, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHEnumKeyExA*(hkey: HKEY, dwIndex: DWORD, pszName: LPSTR, pcchName: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHEnumKeyExW*(hkey: HKEY, dwIndex: DWORD, pszName: LPWSTR, pcchName: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHEnumValueA*(hkey: HKEY, dwIndex: DWORD, pszValueName: LPSTR, pcchValueName: LPDWORD, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHEnumValueW*(hkey: HKEY, dwIndex: DWORD, pszValueName: LPWSTR, pcchValueName: LPDWORD, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHQueryInfoKeyA*(hkey: HKEY, pcSubKeys: LPDWORD, pcchMaxSubKeyLen: LPDWORD, pcValues: LPDWORD, pcchMaxValueNameLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHQueryInfoKeyW*(hkey: HKEY, pcSubKeys: LPDWORD, pcchMaxSubKeyLen: LPDWORD, pcValues: LPDWORD, pcchMaxValueNameLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHCopyKeyA*(hkeySrc: HKEY, szSrcSubKey: LPCSTR, hkeyDest: HKEY, fReserved: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHCopyKeyW*(hkeySrc: HKEY, wszSrcSubKey: LPCWSTR, hkeyDest: HKEY, fReserved: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetPathA*(hKey: HKEY, pcszSubKey: LPCSTR, pcszValue: LPCSTR, pszPath: LPSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetPathW*(hKey: HKEY, pcszSubKey: LPCWSTR, pcszValue: LPCWSTR, pszPath: LPWSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegSetPathA*(hKey: HKEY, pcszSubKey: LPCSTR, pcszValue: LPCSTR, pcszPath: LPCSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegSetPathW*(hKey: HKEY, pcszSubKey: LPCWSTR, pcszValue: LPCWSTR, pcszPath: LPCWSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegCreateUSKeyA*(pszPath: LPCSTR, samDesired: REGSAM, hRelativeUSKey: HUSKEY, phNewUSKey: PHUSKEY, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegCreateUSKeyW*(pwzPath: LPCWSTR, samDesired: REGSAM, hRelativeUSKey: HUSKEY, phNewUSKey: PHUSKEY, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegOpenUSKeyA*(pszPath: LPCSTR, samDesired: REGSAM, hRelativeUSKey: HUSKEY, phNewUSKey: PHUSKEY, fIgnoreHKCU: WINBOOL): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegOpenUSKeyW*(pwzPath: LPCWSTR, samDesired: REGSAM, hRelativeUSKey: HUSKEY, phNewUSKey: PHUSKEY, fIgnoreHKCU: WINBOOL): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegQueryUSValueA*(hUSKey: HUSKEY, pszValue: LPCSTR, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, fIgnoreHKCU: WINBOOL, pvDefaultData: pointer, dwDefaultDataSize: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegQueryUSValueW*(hUSKey: HUSKEY, pwzValue: LPCWSTR, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, fIgnoreHKCU: WINBOOL, pvDefaultData: pointer, dwDefaultDataSize: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegWriteUSValueA*(hUSKey: HUSKEY, pszValue: LPCSTR, dwType: DWORD, pvData: pointer, cbData: DWORD, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegWriteUSValueW*(hUSKey: HUSKEY, pwzValue: LPCWSTR, dwType: DWORD, pvData: pointer, cbData: DWORD, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegDeleteUSValueA*(hUSKey: HUSKEY, pszValue: LPCSTR, delRegFlags: SHREGDEL_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegDeleteEmptyUSKeyW*(hUSKey: HUSKEY, pwzSubKey: LPCWSTR, delRegFlags: SHREGDEL_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegDeleteEmptyUSKeyA*(hUSKey: HUSKEY, pszSubKey: LPCSTR, delRegFlags: SHREGDEL_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegDeleteUSValueW*(hUSKey: HUSKEY, pwzValue: LPCWSTR, delRegFlags: SHREGDEL_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegEnumUSKeyA*(hUSKey: HUSKEY, dwIndex: DWORD, pszName: LPSTR, pcchName: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegEnumUSKeyW*(hUSKey: HUSKEY, dwIndex: DWORD, pwzName: LPWSTR, pcchName: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegEnumUSValueA*(hUSkey: HUSKEY, dwIndex: DWORD, pszValueName: LPSTR, pcchValueName: LPDWORD, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegEnumUSValueW*(hUSkey: HUSKEY, dwIndex: DWORD, pszValueName: LPWSTR, pcchValueName: LPDWORD, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegQueryInfoUSKeyA*(hUSKey: HUSKEY, pcSubKeys: LPDWORD, pcchMaxSubKeyLen: LPDWORD, pcValues: LPDWORD, pcchMaxValueNameLen: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegQueryInfoUSKeyW*(hUSKey: HUSKEY, pcSubKeys: LPDWORD, pcchMaxSubKeyLen: LPDWORD, pcValues: LPDWORD, pcchMaxValueNameLen: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegCloseUSKey*(hUSKey: HUSKEY): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetUSValueA*(pszSubKey: LPCSTR, pszValue: LPCSTR, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, fIgnoreHKCU: WINBOOL, pvDefaultData: pointer, dwDefaultDataSize: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetUSValueW*(pwzSubKey: LPCWSTR, pwzValue: LPCWSTR, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, fIgnoreHKCU: WINBOOL, pvDefaultData: pointer, dwDefaultDataSize: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegSetUSValueA*(pszSubKey: LPCSTR, pszValue: LPCSTR, dwType: DWORD, pvData: pointer, cbData: DWORD, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegSetUSValueW*(pwzSubKey: LPCWSTR, pwzValue: LPCWSTR, dwType: DWORD, pvData: pointer, cbData: DWORD, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetIntW*(hk: HKEY, pwzKey: LPCWSTR, iDefault: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetBoolUSValueA*(pszSubKey: LPCSTR, pszValue: LPCSTR, fIgnoreHKCU: WINBOOL, fDefault: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHRegGetBoolUSValueW*(pszSubKey: LPCWSTR, pszValue: LPCWSTR, fIgnoreHKCU: WINBOOL, fDefault: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocCreate*(clsid: CLSID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocQueryStringA*(flags: ASSOCF, str: ASSOCSTR, pszAssoc: LPCSTR, pszExtra: LPCSTR, pszOut: LPSTR, pcchOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocQueryStringW*(flags: ASSOCF, str: ASSOCSTR, pszAssoc: LPCWSTR, pszExtra: LPCWSTR, pszOut: LPWSTR, pcchOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocQueryStringByKeyA*(flags: ASSOCF, str: ASSOCSTR, hkAssoc: HKEY, pszExtra: LPCSTR, pszOut: LPSTR, pcchOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocQueryStringByKeyW*(flags: ASSOCF, str: ASSOCSTR, hkAssoc: HKEY, pszExtra: LPCWSTR, pszOut: LPWSTR, pcchOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocQueryKeyA*(flags: ASSOCF, key: ASSOCKEY, pszAssoc: LPCSTR, pszExtra: LPCSTR, phkeyOut: ptr HKEY): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocQueryKeyW*(flags: ASSOCF, key: ASSOCKEY, pszAssoc: LPCWSTR, pszExtra: LPCWSTR, phkeyOut: ptr HKEY): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocIsDangerous*(pszAssoc: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc AssocGetPerceivedType*(pszExt: LPCWSTR, ptype: ptr PERCEIVED, pflag: ptr PERCEIVEDFLAG, ppszType: ptr LPWSTR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHOpenRegStreamA*(hkey: HKEY, pszSubkey: LPCSTR, pszValue: LPCSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHOpenRegStreamW*(hkey: HKEY, pszSubkey: LPCWSTR, pszValue: LPCWSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHOpenRegStream2A*(hkey: HKEY, pszSubkey: LPCSTR, pszValue: LPCSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHOpenRegStream2W*(hkey: HKEY, pszSubkey: LPCWSTR, pszValue: LPCWSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHCreateStreamOnFileA*(pszFile: LPCSTR, grfMode: DWORD, ppstm: ptr ptr IStream): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHCreateStreamOnFileW*(pszFile: LPCWSTR, grfMode: DWORD, ppstm: ptr ptr IStream): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHCreateStreamOnFileEx*(pszFile: LPCWSTR, grfMode: DWORD, dwAttributes: DWORD, fCreate: WINBOOL, pstmTemplate: ptr IStream, ppstm: ptr ptr IStream): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc GetAcceptLanguagesA*(psz: LPSTR, pcch: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc GetAcceptLanguagesW*(psz: LPWSTR, pcch: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHGetViewStatePropertyBag*(pidl: LPCITEMIDLIST, pszBagName: LPCWSTR, dwFlags: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHAllocShared*(pvData: pointer, dwSize: DWORD, dwProcessId: DWORD): HANDLE {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHFreeShared*(hData: HANDLE, dwProcessId: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHLockShared*(hData: HANDLE, dwProcessId: DWORD): pointer {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHUnlockShared*(pvData: pointer): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHAutoComplete*(hwndEdit: HWND, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHSetThreadRef*(punk: ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHGetThreadRef*(ppunk: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHSkipJunction*(pbc: ptr IBindCtx, pclsid: ptr CLSID): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHCreateThreadRef*(pcRef: ptr LONG, ppunk: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHCreateThread*(pfnThreadProc: LPTHREAD_START_ROUTINE, pData: pointer, dwFlags: DWORD, pfnCallback: LPTHREAD_START_ROUTINE): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHReleaseThreadRef*(): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHCreateShellPalette*(hdc: HDC): HPALETTE {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc ColorRGBToHLS*(clrRGB: COLORREF, pwHue: ptr WORD, pwLuminance: ptr WORD, pwSaturation: ptr WORD): void {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc ColorHLSToRGB*(wHue: WORD, wLuminance: WORD, wSaturation: WORD): COLORREF {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc ColorAdjustLuma*(clrRGB: COLORREF, n: int32, fScale: WINBOOL): COLORREF {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc DllInstall*(bInstall: WINBOOL, pszCmdLine: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc IsInternetESCEnabled*(): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc.}
proc SHGetFolderPathW*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszPath: LPWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSimpleIDListFromPath*(pszPath: PCWSTR): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateItemFromIDList*(pidl: PCIDLIST_ABSOLUTE, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateItemFromParsingName*(pszPath: PCWSTR, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateItemWithParent*(pidlParent: PCIDLIST_ABSOLUTE, psfParent: ptr IShellFolder, pidl: PCUITEMID_CHILD, riid: REFIID, ppvItem: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateItemFromRelativeName*(psiParent: ptr IShellItem, pszName: PCWSTR, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateItemInKnownFolder*(kfid: REFKNOWNFOLDERID, dwKFFlags: DWORD, pszItem: PCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetIDListFromObject*(punk: ptr IUnknown, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetItemFromObject*(punk: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetPropertyStoreFromIDList*(pidl: PCIDLIST_ABSOLUTE, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetPropertyStoreFromParsingName*(pszPath: PCWSTR, pbc: ptr IBindCtx, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetNameFromIDList*(pidl: PCIDLIST_ABSOLUTE, sigdnName: SIGDN, ppszName: ptr PWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetItemFromDataObject*(pdtobj: ptr IDataObject, dwFlags: DATAOBJ_GET_ITEM_FLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateShellItemArray*(pidlParent: PCIDLIST_ABSOLUTE, psf: ptr IShellFolder, cidl: UINT, ppidl: PCUITEMID_CHILD_ARRAY, ppsiItemArray: ptr ptr IShellItemArray): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateShellItemArrayFromDataObject*(pdo: ptr IDataObject, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateShellItemArrayFromIDLists*(cidl: UINT, rgpidl: PCIDLIST_ABSOLUTE_ARRAY, ppsiItemArray: ptr ptr IShellItemArray): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateShellItemArrayFromShellItem*(psi: ptr IShellItem, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHAddDefaultPropertiesByExt*(pszExt: PCWSTR, pPropStore: ptr IPropertyStore): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateDefaultPropertiesOp*(psi: ptr IShellItem, ppFileOp: ptr ptr IFileOperation): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSetDefaultProperties*(hwnd: HWND, psi: ptr IShellItem, dwFileOpFlags: DWORD, pfops: ptr IFileOperationProgressSink): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateAssociationRegistration*(riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateDefaultExtractIcon*(riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SetCurrentProcessExplicitAppUserModelID*(AppID: PCWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc GetCurrentProcessExplicitAppUserModelID*(AppID: ptr PWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetTemporaryPropertyForItem*(psi: ptr IShellItem, propkey: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSetTemporaryPropertyForItem*(psi: ptr IShellItem, propkey: REFPROPERTYKEY, propvar: REFPROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHShowManageLibraryUI*(psiLibrary: ptr IShellItem, hwndOwner: HWND, pszTitle: LPCWSTR, pszInstruction: LPCWSTR, lmdOptions: LIBRARYMANAGEDIALOGOPTIONS): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHResolveLibrary*(psiLibrary: ptr IShellItem): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHAssocEnumHandlers*(pszExtra: PCWSTR, afFilter: ASSOC_FILTER, ppEnumHandler: ptr ptr IEnumAssocHandlers): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHAssocEnumHandlersForProtocolByApplication*(protocol: PCWSTR, riid: REFIID, enumHandlers: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetMalloc*(ppMalloc: ptr ptr IMalloc): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHAlloc*(cb: SIZE_T): pointer {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHFree*(pv: pointer): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetIconOverlayIndexA*(pszIconPath: LPCSTR, iIconIndex: int32): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetIconOverlayIndexW*(pszIconPath: LPCWSTR, iIconIndex: int32): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILClone*(pidl: PCUIDLIST_RELATIVE): PIDLIST_RELATIVE {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILCloneFirst*(pidl: PCUIDLIST_RELATIVE): PITEMID_CHILD {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILCombine*(pidl1: PCIDLIST_ABSOLUTE, pidl2: PCUIDLIST_RELATIVE): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILFree*(pidl: PIDLIST_RELATIVE): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILGetNext*(pidl: PCUIDLIST_RELATIVE): PUIDLIST_RELATIVE {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILGetSize*(pidl: PCUIDLIST_RELATIVE): UINT {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILFindChild*(pidlParent: PIDLIST_ABSOLUTE, pidlChild: PCIDLIST_ABSOLUTE): PUIDLIST_RELATIVE {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILFindLastID*(pidl: PCUIDLIST_RELATIVE): PUITEMID_CHILD {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILRemoveLastID*(pidl: PUIDLIST_RELATIVE): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILIsEqual*(pidl1: PCIDLIST_ABSOLUTE, pidl2: PCIDLIST_ABSOLUTE): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILIsParent*(pidl1: PCIDLIST_ABSOLUTE, pidl2: PCIDLIST_ABSOLUTE, fImmediate: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILSaveToStream*(pstm: ptr IStream, pidl: PCUIDLIST_RELATIVE): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILLoadFromStreamEx*(pstm: ptr IStream, pidl: ptr PIDLIST_RELATIVE): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILCreateFromPathA*(pszPath: PCSTR): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILCreateFromPathW*(pszPath: PCWSTR): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHILCreateFromPath*(pszPath: PCWSTR, ppidl: ptr PIDLIST_ABSOLUTE, rgfInOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc ILAppendID*(pidl: PIDLIST_RELATIVE, pmkid: LPCSHITEMID, fAppend: WINBOOL): PIDLIST_RELATIVE {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetPathFromIDListEx*(pidl: PCIDLIST_ABSOLUTE, pszPath: PWSTR, cchPath: DWORD, uOpts: GPFIDL_FLAGS): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetPathFromIDListA*(pidl: PCIDLIST_ABSOLUTE, pszPath: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetPathFromIDListW*(pidl: PCIDLIST_ABSOLUTE, pszPath: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateDirectory*(hwnd: HWND, pszPath: PCWSTR): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateDirectoryExA*(hwnd: HWND, pszPath: LPCSTR, psa: ptr SECURITY_ATTRIBUTES): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateDirectoryExW*(hwnd: HWND, pszPath: LPCWSTR, psa: ptr SECURITY_ATTRIBUTES): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHOpenFolderAndSelectItems*(pidlFolder: PCIDLIST_ABSOLUTE, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateShellItem*(pidlParent: PCIDLIST_ABSOLUTE, psfParent: ptr IShellFolder, pidl: PCUITEMID_CHILD, ppsi: ptr ptr IShellItem): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetSpecialFolderLocation*(hwnd: HWND, csidl: int32, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCloneSpecialIDList*(hwnd: HWND, csidl: int32, fCreate: WINBOOL): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetSpecialFolderPathA*(hwnd: HWND, pszPath: LPSTR, csidl: int32, fCreate: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetSpecialFolderPathW*(hwnd: HWND, pszPath: LPWSTR, csidl: int32, fCreate: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHFlushSFCache*(): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetFolderPathA*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszPath: LPSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetFolderLocation*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSetFolderPathA*(csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszPath: LPCSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSetFolderPathW*(csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszPath: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetFolderPathAndSubDirA*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszSubDir: LPCSTR, pszPath: LPSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetFolderPathAndSubDirW*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszSubDir: LPCWSTR, pszPath: LPWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetKnownFolderIDList*(rfid: REFKNOWNFOLDERID, dwFlags: DWORD, hToken: HANDLE, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSetKnownFolderPath*(rfid: REFKNOWNFOLDERID, dwFlags: DWORD, hToken: HANDLE, pszPath: PCWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetKnownFolderPath*(rfid: REFKNOWNFOLDERID, dwFlags: DWORD, hToken: HANDLE, ppszPath: ptr PWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetKnownFolderItem*(rfid: REFKNOWNFOLDERID, flags: KNOWN_FOLDER_FLAG, hToken: HANDLE, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetSetFolderCustomSettings*(pfcs: LPSHFOLDERCUSTOMSETTINGS, pszPath: PCWSTR, dwReadWrite: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHBrowseForFolderA*(lpbi: LPBROWSEINFOA): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHBrowseForFolderW*(lpbi: LPBROWSEINFOW): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHLoadInProc*(rclsid: REFCLSID): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetDesktopFolder*(ppshf: ptr ptr IShellFolder): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHChangeNotify*(wEventId: LONG, uFlags: UINT, dwItem1: LPCVOID, dwItem2: LPCVOID): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHAddToRecentDocs*(uFlags: UINT, pv: LPCVOID): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHHandleUpdateImage*(pidlExtra: PCIDLIST_ABSOLUTE): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHUpdateImageA*(pszHashItem: LPCSTR, iIndex: int32, uFlags: UINT, iImageIndex: int32): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHUpdateImageW*(pszHashItem: LPCWSTR, iIndex: int32, uFlags: UINT, iImageIndex: int32): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHChangeNotifyRegister*(hwnd: HWND, fSources: int32, fEvents: LONG, wMsg: UINT, cEntries: int32, pshcne: ptr SHChangeNotifyEntry): ULONG {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHChangeNotifyDeregister*(ulID: ULONG): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHChangeNotifyRegisterThread*(status: SCNRT_STATUS): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHChangeNotification_Lock*(hChange: HANDLE, dwProcId: DWORD, pppidl: ptr ptr PIDLIST_ABSOLUTE, plEvent: ptr LONG): HANDLE {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHChangeNotification_Unlock*(hLock: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetRealIDL*(psf: ptr IShellFolder, pidlSimple: PCUITEMID_CHILD, ppidlReal: ptr PITEMID_CHILD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetInstanceExplorer*(ppunk: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetDataFromIDListA*(psf: ptr IShellFolder, pidl: PCUITEMID_CHILD, nFormat: int32, pv: pointer, cb: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetDataFromIDListW*(psf: ptr IShellFolder, pidl: PCUITEMID_CHILD, nFormat: int32, pv: pointer, cb: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc RestartDialog*(hwnd: HWND, pszPrompt: PCWSTR, dwReturn: DWORD): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc RestartDialogEx*(hwnd: HWND, pszPrompt: PCWSTR, dwReturn: DWORD, dwReasonCode: DWORD): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCoCreateInstance*(pszCLSID: PCWSTR, pclsid: ptr CLSID, pUnkOuter: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateDataObject*(pidlFolder: PCIDLIST_ABSOLUTE, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, pdtInner: ptr IDataObject, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc CIDLData_CreateFromIDArray*(pidlFolder: PCIDLIST_ABSOLUTE, cidl: UINT, apidl: PCUIDLIST_RELATIVE_ARRAY, ppdtobj: ptr ptr IDataObject): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateStdEnumFmtEtc*(cfmt: UINT, afmt: ptr FORMATETC, ppenumFormatEtc: ptr ptr IEnumFORMATETC): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHDoDragDrop*(hwnd: HWND, pdata: ptr IDataObject, pdsrc: ptr IDropSource, dwEffect: DWORD, pdwEffect: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc DAD_SetDragImage*(him: HIMAGELIST, pptOffset: ptr POINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc DAD_DragEnterEx*(hwndTarget: HWND, ptStart: POINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc DAD_DragEnterEx2*(hwndTarget: HWND, ptStart: POINT, pdtObject: ptr IDataObject): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc DAD_ShowDragImage*(fShow: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc DAD_DragMove*(pt: POINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc DAD_DragLeave*(): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc DAD_AutoScroll*(hwnd: HWND, pad: ptr AUTO_SCROLL_DATA, pptNow: ptr POINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc ReadCabinetState*(pcs: ptr CABINETSTATE, cLength: int32): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc WriteCabinetState*(pcs: ptr CABINETSTATE): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathMakeUniqueName*(pszUniqueName: PWSTR, cchMax: UINT, pszTemplate: PCWSTR, pszLongPlate: PCWSTR, pszDir: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathQualify*(psz: PWSTR): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathIsExe*(pszPath: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathIsSlowA*(pszFile: LPCSTR, dwAttr: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathIsSlowW*(pszFile: LPCWSTR, dwAttr: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathCleanupSpec*(pszDir: PCWSTR, pszSpec: PWSTR): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathResolve*(pszPath: PWSTR, dirs: PZPCWSTR, fFlags: UINT): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc GetFileNameFromBrowse*(hwnd: HWND, pszFilePath: PWSTR, cchFilePath: UINT, pszWorkingDir: PCWSTR, pszDefExt: PCWSTR, pszFilters: PCWSTR, pszTitle: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc DriveType*(iDrive: int32): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc RealDriveType*(iDrive: int32, fOKToHitNet: WINBOOL): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc IsNetDrive*(iDrive: int32): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc Shell_MergeMenus*(hmDst: HMENU, hmSrc: HMENU, uInsert: UINT, uIDAdjust: UINT, uIDAdjustMax: UINT, uFlags: ULONG): UINT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHObjectProperties*(hwnd: HWND, shopObjectType: DWORD, pszObjectName: PCWSTR, pszPropertyPage: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHFormatDrive*(hwnd: HWND, drive: UINT, fmtID: UINT, options: UINT): DWORD {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreatePropSheetExtArray*(hKey: HKEY, pszSubKey: PCWSTR, max_iface: UINT): HPSXA {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHDestroyPropSheetExtArray*(hpsxa: HPSXA): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHAddFromPropSheetExtArray*(hpsxa: HPSXA, lpfnAddPage: LPFNADDPROPSHEETPAGE, lParam: LPARAM): UINT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHReplaceFromPropSheetExtArray*(hpsxa: HPSXA, uPageID: UINT, lpfnReplaceWith: LPFNADDPROPSHEETPAGE, lParam: LPARAM): UINT {.winapi, stdcall, dynlib: "shell32", importc.}
proc OpenRegStream*(hkey: HKEY, pszSubkey: PCWSTR, pszValue: PCWSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHFindFiles*(pidlFolder: PCIDLIST_ABSOLUTE, pidlSaveFile: PCIDLIST_ABSOLUTE): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathGetShortPath*(pszLongPath: PWSTR): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc PathYetAnotherMakeUniqueName*(pszUniqueName: PWSTR, pszPath: PCWSTR, pszShort: PCWSTR, pszFileSpec: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc Win32DeleteFile*(pszPath: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHRestricted*(rest: RESTRICTIONS): DWORD {.winapi, stdcall, dynlib: "shell32", importc.}
proc SignalFileOpen*(pidl: PCIDLIST_ABSOLUTE): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc AssocGetDetailsOfPropKey*(psf: ptr IShellFolder, pidl: PCUITEMID_CHILD, pkey: ptr PROPERTYKEY, pv: ptr VARIANT, pfFoundPropKey: ptr WINBOOL): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHStartNetConnectionDialogW*(hwnd: HWND, pszRemoteName: LPCWSTR, dwType: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHDefExtractIconA*(pszIconFile: LPCSTR, iIndex: int32, uFlags: UINT, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIconSize: UINT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHDefExtractIconW*(pszIconFile: LPCWSTR, iIndex: int32, uFlags: UINT, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIconSize: UINT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHOpenWithDialog*(hwndParent: HWND, poainfo: ptr OPENASINFO): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc Shell_GetImageLists*(phiml: ptr HIMAGELIST, phimlSmall: ptr HIMAGELIST): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc Shell_GetCachedImageIndex*(pwszIconPath: PCWSTR, iIconIndex: int32, uIconFlags: UINT): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc Shell_GetCachedImageIndexA*(pszIconPath: LPCSTR, iIconIndex: int32, uIconFlags: UINT): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc Shell_GetCachedImageIndexW*(pszIconPath: LPCWSTR, iIconIndex: int32, uIconFlags: UINT): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHValidateUNC*(hwndOwner: HWND, pszFile: PWSTR, fConnect: UINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc PifMgr_OpenProperties*(pszApp: PCWSTR, pszPIF: PCWSTR, hInf: UINT, flOpt: UINT): HANDLE {.winapi, stdcall, dynlib: "shell32", importc.}
proc PifMgr_GetProperties*(hProps: HANDLE, pszGroup: PCSTR, lpProps: pointer, cbProps: int32, flOpt: UINT): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc PifMgr_SetProperties*(hProps: HANDLE, pszGroup: PCSTR, lpProps: pointer, cbProps: int32, flOpt: UINT): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc PifMgr_CloseProperties*(hProps: HANDLE, flOpt: UINT): HANDLE {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHSetInstanceExplorer*(punk: ptr IUnknown): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc IsUserAnAdmin*(): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHShellFolderView_Message*(hwndMain: HWND, uMsg: UINT, lParam: LPARAM): LRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateShellFolderView*(pcsfv: ptr SFV_CREATE, ppsv: ptr ptr IShellView): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc CDefFolderMenu_Create2*(pidlFolder: PCIDLIST_ABSOLUTE, hwnd: HWND, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, psf: ptr IShellFolder, pfn: LPFNDFMCALLBACK, nKeys: UINT, ahkeys: ptr HKEY, ppcm: ptr ptr IContextMenu): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateDefaultContextMenu*(pdcm: ptr DEFCONTEXTMENU, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHOpenPropSheetW*(pszCaption: LPCWSTR, ahkeys: ptr HKEY, ckeys: UINT, pclsidDefault: ptr CLSID, pdtobj: ptr IDataObject, psb: ptr IShellBrowser, pStartPage: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHFind_InitMenuPopup*(hmenu: HMENU, hwndOwner: HWND, idCmdFirst: UINT, idCmdLast: UINT): ptr IContextMenu {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateShellFolderViewEx*(pcsfv: ptr CSFV, ppsv: ptr ptr IShellView): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
when winimUnicode:
  type
    LPSHELLSTATE* = LPSHELLSTATEW
when winimAnsi:
  type
    LPSHELLSTATE* = LPSHELLSTATEA
proc SHGetSetSettings*(lpss: LPSHELLSTATE, dwMask: DWORD, bSet: WINBOOL): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetSettings*(psfs: ptr SHELLFLAGSTATE, dwMask: DWORD): void {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHBindToParent*(pidl: PCIDLIST_ABSOLUTE, riid: REFIID, ppv: ptr pointer, ppidlLast: ptr PCUITEMID_CHILD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHBindToFolderIDListParent*(psfRoot: ptr IShellFolder, pidl: PCUIDLIST_RELATIVE, riid: REFIID, ppv: ptr pointer, ppidlLast: ptr PCUITEMID_CHILD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHBindToFolderIDListParentEx*(psfRoot: ptr IShellFolder, pidl: PCUIDLIST_RELATIVE, ppbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer, ppidlLast: ptr PCUITEMID_CHILD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHBindToObject*(psf: ptr IShellFolder, pidl: PCUIDLIST_RELATIVE, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHParseDisplayName*(pszName: PCWSTR, pbc: ptr IBindCtx, ppidl: ptr PIDLIST_ABSOLUTE, sfgaoIn: SFGAOF, psfgaoOut: ptr SFGAOF): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHPathPrepareForWriteA*(hwnd: HWND, punkEnableModless: ptr IUnknown, pszPath: LPCSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHPathPrepareForWriteW*(hwnd: HWND, punkEnableModless: ptr IUnknown, pszPath: LPCWSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SoftwareUpdateMessageBox*(hWnd: HWND, pszDistUnit: PCWSTR, dwFlags: DWORD, psdi: LPSOFTDISTINFO): DWORD {.winapi, stdcall, dynlib: "shdocvw", importc.}
proc SHPropStgCreate*(psstg: ptr IPropertySetStorage, fmtid: REFFMTID, pclsid: ptr CLSID, grfFlags: DWORD, grfMode: DWORD, dwDisposition: DWORD, ppstg: ptr ptr IPropertyStorage, puCodePage: ptr UINT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHPropStgReadMultiple*(pps: ptr IPropertyStorage, uCodePage: UINT, cpspec: ULONG, rgpspec: ptr PROPSPEC, rgvar: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHPropStgWriteMultiple*(pps: ptr IPropertyStorage, puCodePage: ptr UINT, cpspec: ULONG, rgpspec: ptr PROPSPEC, rgvar: ptr PROPVARIANT, propidNameFirst: PROPID): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateFileExtractIconW*(pszFile: LPCWSTR, dwFileAttributes: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHLimitInputEdit*(hwndEdit: HWND, psf: ptr IShellFolder): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHGetAttributesFromDataObject*(pdo: ptr IDataObject, dwAttributeMask: DWORD, pdwAttributes: ptr DWORD, pcItems: ptr UINT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHMultiFileProperties*(pdtobj: ptr IDataObject, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHMapPIDLToSystemImageListIndex*(pshf: ptr IShellFolder, pidl: PCUITEMID_CHILD, piIndexSel: ptr int32): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCLSIDFromString*(psz: PCWSTR, pclsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc SHCreateQueryCancelAutoPlayMoniker*(ppmoniker: ptr ptr IMoniker): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc PerUserInit*(): void {.winapi, stdcall, dynlib: "mydocs", importc.}
proc PickIconDlg*(hwnd: HWND, pszIconPath: PWSTR, cchIconPath: UINT, piIconIndex: ptr int32): int32 {.winapi, stdcall, dynlib: "shell32", importc.}
proc StgMakeUniqueName*(pstgParent: ptr IStorage, pszFileSpec: PCWSTR, grfMode: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc ImportPrivacySettings*(pszFilename: PCWSTR, pfParsePrivacyPreferences: ptr WINBOOL, pfParsePerSiteRules: ptr WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shdocvw", importc.}
proc `hIcon=`*(self: var SHELLEXECUTEINFOA, x: HANDLE) {.inline.} = self.union1.hIcon = x
proc hIcon*(self: SHELLEXECUTEINFOA): HANDLE {.inline.} = self.union1.hIcon
proc hIcon*(self: var SHELLEXECUTEINFOA): var HANDLE {.inline.} = self.union1.hIcon
proc `hMonitor=`*(self: var SHELLEXECUTEINFOA, x: HANDLE) {.inline.} = self.union1.hMonitor = x
proc hMonitor*(self: SHELLEXECUTEINFOA): HANDLE {.inline.} = self.union1.hMonitor
proc hMonitor*(self: var SHELLEXECUTEINFOA): var HANDLE {.inline.} = self.union1.hMonitor
proc `hIcon=`*(self: var SHELLEXECUTEINFOW, x: HANDLE) {.inline.} = self.union1.hIcon = x
proc hIcon*(self: SHELLEXECUTEINFOW): HANDLE {.inline.} = self.union1.hIcon
proc hIcon*(self: var SHELLEXECUTEINFOW): var HANDLE {.inline.} = self.union1.hIcon
proc `hMonitor=`*(self: var SHELLEXECUTEINFOW, x: HANDLE) {.inline.} = self.union1.hMonitor = x
proc hMonitor*(self: SHELLEXECUTEINFOW): HANDLE {.inline.} = self.union1.hMonitor
proc hMonitor*(self: var SHELLEXECUTEINFOW): var HANDLE {.inline.} = self.union1.hMonitor
proc `uTimeout=`*(self: var NOTIFYICONDATAA, x: UINT) {.inline.} = self.union1.uTimeout = x
proc uTimeout*(self: NOTIFYICONDATAA): UINT {.inline.} = self.union1.uTimeout
proc uTimeout*(self: var NOTIFYICONDATAA): var UINT {.inline.} = self.union1.uTimeout
proc `uVersion=`*(self: var NOTIFYICONDATAA, x: UINT) {.inline.} = self.union1.uVersion = x
proc uVersion*(self: NOTIFYICONDATAA): UINT {.inline.} = self.union1.uVersion
proc uVersion*(self: var NOTIFYICONDATAA): var UINT {.inline.} = self.union1.uVersion
proc `uTimeout=`*(self: var NOTIFYICONDATAW, x: UINT) {.inline.} = self.union1.uTimeout = x
proc uTimeout*(self: NOTIFYICONDATAW): UINT {.inline.} = self.union1.uTimeout
proc uTimeout*(self: var NOTIFYICONDATAW): var UINT {.inline.} = self.union1.uTimeout
proc `uVersion=`*(self: var NOTIFYICONDATAW, x: UINT) {.inline.} = self.union1.uVersion = x
proc uVersion*(self: NOTIFYICONDATAW): UINT {.inline.} = self.union1.uVersion
proc uVersion*(self: var NOTIFYICONDATAW): var UINT {.inline.} = self.union1.uVersion
proc Init*(self: ptr IQueryAssociations, flags: ASSOCF, pszAssoc: LPCWSTR, hkProgid: HKEY, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Init(self, flags, pszAssoc, hkProgid, hwnd)
proc GetString*(self: ptr IQueryAssociations, flags: ASSOCF, str: ASSOCSTR, pszExtra: LPCWSTR, pszOut: LPWSTR, pcchOut: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetString(self, flags, str, pszExtra, pszOut, pcchOut)
proc GetKey*(self: ptr IQueryAssociations, flags: ASSOCF, key: ASSOCKEY, pszExtra: LPCWSTR, phkeyOut: ptr HKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetKey(self, flags, key, pszExtra, phkeyOut)
proc GetData*(self: ptr IQueryAssociations, flags: ASSOCF, data: ASSOCDATA, pszExtra: LPCWSTR, pvOut: LPVOID, pcbOut: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetData(self, flags, data, pszExtra, pvOut, pcbOut)
proc GetEnum*(self: ptr IQueryAssociations, flags: ASSOCF, assocenum: ASSOCENUM, pszExtra: LPCWSTR, riid: REFIID, ppvOut: ptr LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnum(self, flags, assocenum, pszExtra, riid, ppvOut)
proc SetFolderView*(self: ptr IFolderViewOC, pdisp: ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolderView(self, pdisp)
proc get_Name*(self: ptr DFConstraint, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Name(self, pbs)
proc get_Value*(self: ptr DFConstraint, pv: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Value(self, pv)
proc get_Title*(self: ptr Folder, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Title(self, pbs)
proc get_Application*(self: ptr Folder, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Application(self, ppid)
proc get_Parent*(self: ptr Folder, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Parent(self, ppid)
proc get_ParentFolder*(self: ptr Folder, ppsf: ptr ptr Folder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ParentFolder(self, ppsf)
proc Items*(self: ptr Folder, ppid: ptr ptr FolderItems): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Items(self, ppid)
proc ParseName*(self: ptr Folder, bName: BSTR, ppid: ptr ptr FolderItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseName(self, bName, ppid)
proc NewFolder*(self: ptr Folder, bName: BSTR, vOptions: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NewFolder(self, bName, vOptions)
proc MoveHere*(self: ptr Folder, vItem: VARIANT, vOptions: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveHere(self, vItem, vOptions)
proc CopyHere*(self: ptr Folder, vItem: VARIANT, vOptions: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyHere(self, vItem, vOptions)
proc GetDetailsOf*(self: ptr Folder, vItem: VARIANT, iColumn: int32, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDetailsOf(self, vItem, iColumn, pbs)
proc get_Self*(self: ptr Folder2, ppfi: ptr ptr FolderItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Self(self, ppfi)
proc get_OfflineStatus*(self: ptr Folder2, pul: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_OfflineStatus(self, pul)
proc mSynchronize*(self: ptr Folder2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Synchronize(self)
proc get_HaveToShowWebViewBarricade*(self: ptr Folder2, pbHaveToShowWebViewBarricade: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_HaveToShowWebViewBarricade(self, pbHaveToShowWebViewBarricade)
proc DismissedWebViewBarricade*(self: ptr Folder2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DismissedWebViewBarricade(self)
proc get_ShowWebViewBarricade*(self: ptr Folder3, pbShowWebViewBarricade: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ShowWebViewBarricade(self, pbShowWebViewBarricade)
proc put_ShowWebViewBarricade*(self: ptr Folder3, bShowWebViewBarricade: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ShowWebViewBarricade(self, bShowWebViewBarricade)
proc get_Application*(self: ptr FolderItem, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Application(self, ppid)
proc get_Parent*(self: ptr FolderItem, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Parent(self, ppid)
proc get_Name*(self: ptr FolderItem, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Name(self, pbs)
proc put_Name*(self: ptr FolderItem, bs: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Name(self, bs)
proc get_Path*(self: ptr FolderItem, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Path(self, pbs)
proc get_GetLink*(self: ptr FolderItem, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_GetLink(self, ppid)
proc get_GetFolder*(self: ptr FolderItem, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_GetFolder(self, ppid)
proc get_IsLink*(self: ptr FolderItem, pb: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsLink(self, pb)
proc get_IsFolder*(self: ptr FolderItem, pb: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsFolder(self, pb)
proc get_IsFileSystem*(self: ptr FolderItem, pb: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsFileSystem(self, pb)
proc get_IsBrowsable*(self: ptr FolderItem, pb: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsBrowsable(self, pb)
proc get_ModifyDate*(self: ptr FolderItem, pdt: ptr DATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ModifyDate(self, pdt)
proc put_ModifyDate*(self: ptr FolderItem, dt: DATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ModifyDate(self, dt)
proc get_Size*(self: ptr FolderItem, pul: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Size(self, pul)
proc get_Type*(self: ptr FolderItem, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Type(self, pbs)
proc Verbs*(self: ptr FolderItem, ppfic: ptr ptr FolderItemVerbs): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Verbs(self, ppfic)
proc InvokeVerb*(self: ptr FolderItem, vVerb: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeVerb(self, vVerb)
proc InvokeVerbEx*(self: ptr FolderItem2, vVerb: VARIANT, vArgs: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeVerbEx(self, vVerb, vArgs)
proc ExtendedProperty*(self: ptr FolderItem2, bstrPropName: BSTR, pvRet: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExtendedProperty(self, bstrPropName, pvRet)
proc get_Count*(self: ptr FolderItems, plCount: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Count(self, plCount)
proc get_Application*(self: ptr FolderItems, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Application(self, ppid)
proc get_Parent*(self: ptr FolderItems, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Parent(self, ppid)
proc Item*(self: ptr FolderItems, index: VARIANT, ppid: ptr ptr FolderItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Item(self, index, ppid)
proc NewEnum*(self: ptr FolderItems, ppunk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NewEnum(self, ppunk)
proc InvokeVerbEx*(self: ptr FolderItems2, vVerb: VARIANT, vArgs: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeVerbEx(self, vVerb, vArgs)
proc Filter*(self: ptr FolderItems3, grfFlags: LONG, bstrFileSpec: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Filter(self, grfFlags, bstrFileSpec)
proc get_Verbs*(self: ptr FolderItems3, ppfic: ptr ptr FolderItemVerbs): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Verbs(self, ppfic)
proc get_Application*(self: ptr FolderItemVerb, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Application(self, ppid)
proc get_Parent*(self: ptr FolderItemVerb, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Parent(self, ppid)
proc get_Name*(self: ptr FolderItemVerb, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Name(self, pbs)
proc DoIt*(self: ptr FolderItemVerb): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoIt(self)
proc get_Count*(self: ptr FolderItemVerbs, plCount: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Count(self, plCount)
proc get_Application*(self: ptr FolderItemVerbs, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Application(self, ppid)
proc get_Parent*(self: ptr FolderItemVerbs, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Parent(self, ppid)
proc Item*(self: ptr FolderItemVerbs, index: VARIANT, ppid: ptr ptr FolderItemVerb): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Item(self, index, ppid)
proc NewEnum*(self: ptr FolderItemVerbs, ppunk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NewEnum(self, ppunk)
proc get_Path*(self: ptr IShellLinkDual, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Path(self, pbs)
proc put_Path*(self: ptr IShellLinkDual, bs: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Path(self, bs)
proc get_Description*(self: ptr IShellLinkDual, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Description(self, pbs)
proc put_Description*(self: ptr IShellLinkDual, bs: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Description(self, bs)
proc get_WorkingDirectory*(self: ptr IShellLinkDual, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_WorkingDirectory(self, pbs)
proc put_WorkingDirectory*(self: ptr IShellLinkDual, bs: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_WorkingDirectory(self, bs)
proc get_Arguments*(self: ptr IShellLinkDual, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Arguments(self, pbs)
proc put_Arguments*(self: ptr IShellLinkDual, bs: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Arguments(self, bs)
proc get_Hotkey*(self: ptr IShellLinkDual, piHK: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Hotkey(self, piHK)
proc put_Hotkey*(self: ptr IShellLinkDual, iHK: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Hotkey(self, iHK)
proc get_ShowCommand*(self: ptr IShellLinkDual, piShowCommand: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ShowCommand(self, piShowCommand)
proc put_ShowCommand*(self: ptr IShellLinkDual, iShowCommand: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ShowCommand(self, iShowCommand)
proc Resolve*(self: ptr IShellLinkDual, fFlags: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resolve(self, fFlags)
proc GetIconLocation*(self: ptr IShellLinkDual, pbs: ptr BSTR, piIcon: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconLocation(self, pbs, piIcon)
proc SetIconLocation*(self: ptr IShellLinkDual, bs: BSTR, iIcon: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIconLocation(self, bs, iIcon)
proc Save*(self: ptr IShellLinkDual, vWhere: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, vWhere)
proc get_Target*(self: ptr IShellLinkDual2, ppfi: ptr ptr FolderItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Target(self, ppfi)
proc get_Application*(self: ptr IShellFolderViewDual, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Application(self, ppid)
proc get_Parent*(self: ptr IShellFolderViewDual, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Parent(self, ppid)
proc get_Folder*(self: ptr IShellFolderViewDual, ppid: ptr ptr Folder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Folder(self, ppid)
proc SelectedItems*(self: ptr IShellFolderViewDual, ppid: ptr ptr FolderItems): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectedItems(self, ppid)
proc get_FocusedItem*(self: ptr IShellFolderViewDual, ppid: ptr ptr FolderItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FocusedItem(self, ppid)
proc SelectItem*(self: ptr IShellFolderViewDual, pvfi: ptr VARIANT, dwFlags: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectItem(self, pvfi, dwFlags)
proc PopupItemMenu*(self: ptr IShellFolderViewDual, pfi: ptr FolderItem, vx: VARIANT, vy: VARIANT, pbs: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PopupItemMenu(self, pfi, vx, vy, pbs)
proc get_Script*(self: ptr IShellFolderViewDual, ppDisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Script(self, ppDisp)
proc get_ViewOptions*(self: ptr IShellFolderViewDual, plViewOptions: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ViewOptions(self, plViewOptions)
proc get_CurrentViewMode*(self: ptr IShellFolderViewDual2, pViewMode: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentViewMode(self, pViewMode)
proc put_CurrentViewMode*(self: ptr IShellFolderViewDual2, ViewMode: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_CurrentViewMode(self, ViewMode)
proc SelectItemRelative*(self: ptr IShellFolderViewDual2, iRelative: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectItemRelative(self, iRelative)
proc get_GroupBy*(self: ptr IShellFolderViewDual3, pbstrGroupBy: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_GroupBy(self, pbstrGroupBy)
proc put_GroupBy*(self: ptr IShellFolderViewDual3, bstrGroupBy: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_GroupBy(self, bstrGroupBy)
proc get_FolderFlags*(self: ptr IShellFolderViewDual3, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FolderFlags(self, pdwFlags)
proc put_FolderFlags*(self: ptr IShellFolderViewDual3, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_FolderFlags(self, dwFlags)
proc get_SortColumns*(self: ptr IShellFolderViewDual3, pbstrSortColumns: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SortColumns(self, pbstrSortColumns)
proc put_SortColumns*(self: ptr IShellFolderViewDual3, bstrSortColumns: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_SortColumns(self, bstrSortColumns)
proc put_IconSize*(self: ptr IShellFolderViewDual3, iIconSize: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_IconSize(self, iIconSize)
proc get_IconSize*(self: ptr IShellFolderViewDual3, piIconSize: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IconSize(self, piIconSize)
proc FilterView*(self: ptr IShellFolderViewDual3, bstrFilterText: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FilterView(self, bstrFilterText)
proc get_Application*(self: ptr IShellDispatch, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Application(self, ppid)
proc get_Parent*(self: ptr IShellDispatch, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Parent(self, ppid)
proc NameSpace*(self: ptr IShellDispatch, vDir: VARIANT, ppsdf: ptr ptr Folder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NameSpace(self, vDir, ppsdf)
proc BrowseForFolder*(self: ptr IShellDispatch, Hwnd: LONG, Title: BSTR, Options: LONG, RootFolder: VARIANT, ppsdf: ptr ptr Folder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BrowseForFolder(self, Hwnd, Title, Options, RootFolder, ppsdf)
proc Windows*(self: ptr IShellDispatch, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Windows(self, ppid)
proc Open*(self: ptr IShellDispatch, vDir: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Open(self, vDir)
proc Explore*(self: ptr IShellDispatch, vDir: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Explore(self, vDir)
proc MinimizeAll*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MinimizeAll(self)
proc UndoMinimizeALL*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UndoMinimizeALL(self)
proc FileRun*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FileRun(self)
proc CascadeWindows*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CascadeWindows(self)
proc TileVertically*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TileVertically(self)
proc TileHorizontally*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TileHorizontally(self)
proc ShutdownWindows*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShutdownWindows(self)
proc Suspend*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Suspend(self)
proc EjectPC*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EjectPC(self)
proc SetTime*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTime(self)
proc TrayProperties*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TrayProperties(self)
proc Help*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Help(self)
proc FindFiles*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindFiles(self)
proc FindComputer*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindComputer(self)
proc RefreshMenu*(self: ptr IShellDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RefreshMenu(self)
proc ControlPanelItem*(self: ptr IShellDispatch, bstrDir: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ControlPanelItem(self, bstrDir)
proc IsRestricted*(self: ptr IShellDispatch2, Group: BSTR, Restriction: BSTR, plRestrictValue: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsRestricted(self, Group, Restriction, plRestrictValue)
proc ShellExecute*(self: ptr IShellDispatch2, File: BSTR, vArgs: VARIANT, vDir: VARIANT, vOperation: VARIANT, vShow: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShellExecute(self, File, vArgs, vDir, vOperation, vShow)
proc FindPrinter*(self: ptr IShellDispatch2, name: BSTR, location: BSTR, model: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindPrinter(self, name, location, model)
proc GetSystemInformation*(self: ptr IShellDispatch2, name: BSTR, pv: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSystemInformation(self, name, pv)
proc mServiceStart*(self: ptr IShellDispatch2, ServiceName: BSTR, Persistent: VARIANT, pSuccess: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ServiceStart(self, ServiceName, Persistent, pSuccess)
proc mServiceStop*(self: ptr IShellDispatch2, ServiceName: BSTR, Persistent: VARIANT, pSuccess: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ServiceStop(self, ServiceName, Persistent, pSuccess)
proc IsServiceRunning*(self: ptr IShellDispatch2, ServiceName: BSTR, pRunning: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsServiceRunning(self, ServiceName, pRunning)
proc CanStartStopService*(self: ptr IShellDispatch2, ServiceName: BSTR, pCanStartStop: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CanStartStopService(self, ServiceName, pCanStartStop)
proc ShowBrowserBar*(self: ptr IShellDispatch2, bstrClsid: BSTR, bShow: VARIANT, pSuccess: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowBrowserBar(self, bstrClsid, bShow, pSuccess)
proc AddToRecent*(self: ptr IShellDispatch3, varFile: VARIANT, bstrCategory: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddToRecent(self, varFile, bstrCategory)
proc WindowsSecurity*(self: ptr IShellDispatch4): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WindowsSecurity(self)
proc ToggleDesktop*(self: ptr IShellDispatch4): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ToggleDesktop(self)
proc ExplorerPolicy*(self: ptr IShellDispatch4, bstrPolicyName: BSTR, pValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExplorerPolicy(self, bstrPolicyName, pValue)
proc GetSetting*(self: ptr IShellDispatch4, lSetting: LONG, pResult: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSetting(self, lSetting, pResult)
proc WindowSwitcher*(self: ptr IShellDispatch5): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WindowSwitcher(self)
proc SearchCommand*(self: ptr IShellDispatch6): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SearchCommand(self)
proc SetFocus*(self: ptr IFileSearchBand): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFocus(self)
proc SetSearchParameters*(self: ptr IFileSearchBand, pbstrSearchID: ptr BSTR, bNavToResults: VARIANT_BOOL, pvarScope: ptr VARIANT, pvarQueryFile: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSearchParameters(self, pbstrSearchID, bNavToResults, pvarScope, pvarQueryFile)
proc get_SearchID*(self: ptr IFileSearchBand, pbstrSearchID: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SearchID(self, pbstrSearchID)
proc get_Scope*(self: ptr IFileSearchBand, pvarScope: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Scope(self, pvarScope)
proc get_QueryFile*(self: ptr IFileSearchBand, pvarFile: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_QueryFile(self, pvarFile)
proc FinalBack*(self: ptr IWebWizardHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FinalBack(self)
proc FinalNext*(self: ptr IWebWizardHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FinalNext(self)
proc Cancel*(self: ptr IWebWizardHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Cancel(self)
proc put_Caption*(self: ptr IWebWizardHost, bstrCaption: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Caption(self, bstrCaption)
proc get_Caption*(self: ptr IWebWizardHost, pbstrCaption: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Caption(self, pbstrCaption)
proc put_Property*(self: ptr IWebWizardHost, bstrPropertyName: BSTR, pvProperty: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Property(self, bstrPropertyName, pvProperty)
proc get_Property*(self: ptr IWebWizardHost, bstrPropertyName: BSTR, pvProperty: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Property(self, bstrPropertyName, pvProperty)
proc SetWizardButtons*(self: ptr IWebWizardHost, vfEnableBack: VARIANT_BOOL, vfEnableNext: VARIANT_BOOL, vfLastPage: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWizardButtons(self, vfEnableBack, vfEnableNext, vfLastPage)
proc SetHeaderText*(self: ptr IWebWizardHost, bstrHeaderTitle: BSTR, bstrHeaderSubtitle: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHeaderText(self, bstrHeaderTitle, bstrHeaderSubtitle)
proc PassportAuthenticate*(self: ptr INewWDEvents, bstrSignInUrl: BSTR, pvfAuthenitcated: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PassportAuthenticate(self, bstrSignInUrl, pvfAuthenitcated)
proc Init*(self: ptr IAutoComplete, hwndEdit: HWND, punkACL: ptr IUnknown, pwszRegKeyPath: LPCWSTR, pwszQuickComplete: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Init(self, hwndEdit, punkACL, pwszRegKeyPath, pwszQuickComplete)
proc Enable*(self: ptr IAutoComplete, fEnable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Enable(self, fEnable)
proc SetOptions*(self: ptr IAutoComplete2, dwFlag: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOptions(self, dwFlag)
proc GetOptions*(self: ptr IAutoComplete2, pdwFlag: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOptions(self, pdwFlag)
proc NextItem*(self: ptr IEnumACString, pszUrl: LPWSTR, cchMax: ULONG, pulSortIndex: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NextItem(self, pszUrl, cchMax, pulSortIndex)
proc SetEnumOptions*(self: ptr IEnumACString, dwOptions: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetEnumOptions(self, dwOptions)
proc GetEnumOptions*(self: ptr IEnumACString, pdwOptions: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnumOptions(self, pdwOptions)
proc SetAsyncMode*(self: ptr IDataObjectAsyncCapability, fDoOpAsync: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAsyncMode(self, fDoOpAsync)
proc GetAsyncMode*(self: ptr IDataObjectAsyncCapability, pfIsOpAsync: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAsyncMode(self, pfIsOpAsync)
proc StartOperation*(self: ptr IDataObjectAsyncCapability, pbcReserved: ptr IBindCtx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartOperation(self, pbcReserved)
proc InOperation*(self: ptr IDataObjectAsyncCapability, pfInAsyncOp: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InOperation(self, pfInAsyncOp)
proc EndOperation*(self: ptr IDataObjectAsyncCapability, hResult: HRESULT, pbcReserved: ptr IBindCtx, dwEffects: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndOperation(self, hResult, pbcReserved, dwEffects)
proc GetCount*(self: ptr IObjectArray, pcObjects: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCount(self, pcObjects)
proc GetAt*(self: ptr IObjectArray, uiIndex: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAt(self, uiIndex, riid, ppv)
proc AddObject*(self: ptr IObjectCollection, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddObject(self, punk)
proc AddFromArray*(self: ptr IObjectCollection, poaSource: ptr IObjectArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddFromArray(self, poaSource)
proc RemoveObjectAt*(self: ptr IObjectCollection, uiIndex: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveObjectAt(self, uiIndex)
proc Clear*(self: ptr IObjectCollection): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clear(self)
proc QueryContextMenu*(self: ptr IContextMenu, hmenu: HMENU, indexMenu: UINT, idCmdFirst: UINT, idCmdLast: UINT, uFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryContextMenu(self, hmenu, indexMenu, idCmdFirst, idCmdLast, uFlags)
proc InvokeCommand*(self: ptr IContextMenu, pici: ptr CMINVOKECOMMANDINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeCommand(self, pici)
proc GetCommandString*(self: ptr IContextMenu, idCmd: UINT_PTR, uType: UINT, pReserved: ptr UINT, pszName: ptr CHAR, cchMax: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCommandString(self, idCmd, uType, pReserved, pszName, cchMax)
proc HandleMenuMsg*(self: ptr IContextMenu2, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleMenuMsg(self, uMsg, wParam, lParam)
proc HandleMenuMsg2*(self: ptr IContextMenu3, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleMenuMsg2(self, uMsg, wParam, lParam, plResult)
proc SetKeyState*(self: ptr IExecuteCommand, grfKeyState: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetKeyState(self, grfKeyState)
proc SetParameters*(self: ptr IExecuteCommand, pszParameters: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetParameters(self, pszParameters)
proc SetPosition*(self: ptr IExecuteCommand, pt: POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPosition(self, pt)
proc SetShowWindow*(self: ptr IExecuteCommand, nShow: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetShowWindow(self, nShow)
proc SetNoShowUI*(self: ptr IExecuteCommand, fNoShowUI: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetNoShowUI(self, fNoShowUI)
proc SetDirectory*(self: ptr IExecuteCommand, pszDirectory: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDirectory(self, pszDirectory)
proc Execute*(self: ptr IExecuteCommand): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Execute(self)
proc Initialize*(self: ptr IPersistFolder, pidl: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pidl)
proc Run*(self: ptr IRunnableTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Run(self)
proc Kill*(self: ptr IRunnableTask, bWait: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Kill(self, bWait)
proc Suspend*(self: ptr IRunnableTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Suspend(self)
proc Resume*(self: ptr IRunnableTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resume(self)
proc IsRunning*(self: ptr IRunnableTask): ULONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsRunning(self)
proc AddTask*(self: ptr IShellTaskScheduler, prt: ptr IRunnableTask, rtoid: REFTASKOWNERID, lParam: DWORD_PTR, dwPriority: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddTask(self, prt, rtoid, lParam, dwPriority)
proc RemoveTasks*(self: ptr IShellTaskScheduler, rtoid: REFTASKOWNERID, lParam: DWORD_PTR, bWaitIfRunning: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveTasks(self, rtoid, lParam, bWaitIfRunning)
proc CountTasks*(self: ptr IShellTaskScheduler, rtoid: REFTASKOWNERID): UINT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CountTasks(self, rtoid)
proc Status*(self: ptr IShellTaskScheduler, dwReleaseStatus: DWORD, dwThreadTimeout: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Status(self, dwReleaseStatus, dwThreadTimeout)
proc GetCodePage*(self: ptr IQueryCodePage, puiCodePage: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCodePage(self, puiCodePage)
proc SetCodePage*(self: ptr IQueryCodePage, uiCodePage: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCodePage(self, uiCodePage)
proc GetCurFolder*(self: ptr IPersistFolder2, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurFolder(self, ppidl)
proc InitializeEx*(self: ptr IPersistFolder3, pbc: ptr IBindCtx, pidlRoot: PCIDLIST_ABSOLUTE, ppfti: ptr PERSIST_FOLDER_TARGET_INFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeEx(self, pbc, pidlRoot, ppfti)
proc GetFolderTargetInfo*(self: ptr IPersistFolder3, ppfti: ptr PERSIST_FOLDER_TARGET_INFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderTargetInfo(self, ppfti)
proc SetIDList*(self: ptr IPersistIDList, pidl: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIDList(self, pidl)
proc GetIDList*(self: ptr IPersistIDList, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDList(self, ppidl)
proc Next*(self: ptr IEnumIDList, celt: ULONG, rgelt: ptr PITEMID_CHILD, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumIDList, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumIDList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumIDList, ppenum: ptr ptr IEnumIDList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc Next*(self: ptr IEnumFullIDList, celt: ULONG, rgelt: ptr PIDLIST_ABSOLUTE, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumFullIDList, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumFullIDList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumFullIDList, ppenum: ptr ptr IEnumFullIDList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc SetMode*(self: ptr IObjectWithFolderEnumMode, feMode: FOLDER_ENUM_MODE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMode(self, feMode)
proc GetMode*(self: ptr IObjectWithFolderEnumMode, pfeMode: ptr FOLDER_ENUM_MODE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMode(self, pfeMode)
proc SetItem*(self: ptr IParseAndCreateItem, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetItem(self, psi)
proc GetItem*(self: ptr IParseAndCreateItem, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItem(self, riid, ppv)
proc ParseDisplayName*(self: ptr IShellFolder, hwnd: HWND, pbc: ptr IBindCtx, pszDisplayName: LPWSTR, pchEaten: ptr ULONG, ppidl: ptr PIDLIST_RELATIVE, pdwAttributes: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseDisplayName(self, hwnd, pbc, pszDisplayName, pchEaten, ppidl, pdwAttributes)
proc EnumObjects*(self: ptr IShellFolder, hwnd: HWND, grfFlags: SHCONTF, ppenumIDList: ptr ptr IEnumIDList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumObjects(self, hwnd, grfFlags, ppenumIDList)
proc BindToObject*(self: ptr IShellFolder, pidl: PCUIDLIST_RELATIVE, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindToObject(self, pidl, pbc, riid, ppv)
proc BindToStorage*(self: ptr IShellFolder, pidl: PCUIDLIST_RELATIVE, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindToStorage(self, pidl, pbc, riid, ppv)
proc CompareIDs*(self: ptr IShellFolder, lParam: LPARAM, pidl1: PCUIDLIST_RELATIVE, pidl2: PCUIDLIST_RELATIVE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CompareIDs(self, lParam, pidl1, pidl2)
proc CreateViewObject*(self: ptr IShellFolder, hwndOwner: HWND, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateViewObject(self, hwndOwner, riid, ppv)
proc GetAttributesOf*(self: ptr IShellFolder, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, rgfInOut: ptr SFGAOF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAttributesOf(self, cidl, apidl, rgfInOut)
proc GetUIObjectOf*(self: ptr IShellFolder, hwndOwner: HWND, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, riid: REFIID, rgfReserved: ptr UINT, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUIObjectOf(self, hwndOwner, cidl, apidl, riid, rgfReserved, ppv)
proc GetDisplayNameOf*(self: ptr IShellFolder, pidl: PCUITEMID_CHILD, uFlags: SHGDNF, pName: ptr STRRET): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayNameOf(self, pidl, uFlags, pName)
proc SetNameOf*(self: ptr IShellFolder, hwnd: HWND, pidl: PCUITEMID_CHILD, pszName: LPCWSTR, uFlags: SHGDNF, ppidlOut: ptr PITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetNameOf(self, hwnd, pidl, pszName, uFlags, ppidlOut)
proc Next*(self: ptr IEnumExtraSearch, celt: ULONG, rgelt: ptr EXTRASEARCH, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumExtraSearch, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumExtraSearch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumExtraSearch, ppenum: ptr ptr IEnumExtraSearch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc GetDefaultSearchGUID*(self: ptr IShellFolder2, pguid: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultSearchGUID(self, pguid)
proc EnumSearches*(self: ptr IShellFolder2, ppenum: ptr ptr IEnumExtraSearch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumSearches(self, ppenum)
proc GetDefaultColumn*(self: ptr IShellFolder2, dwRes: DWORD, pSort: ptr ULONG, pDisplay: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultColumn(self, dwRes, pSort, pDisplay)
proc GetDefaultColumnState*(self: ptr IShellFolder2, iColumn: UINT, pcsFlags: ptr SHCOLSTATEF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultColumnState(self, iColumn, pcsFlags)
proc GetDetailsEx*(self: ptr IShellFolder2, pidl: PCUITEMID_CHILD, pscid: ptr SHCOLUMNID, pv: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDetailsEx(self, pidl, pscid, pv)
proc GetDetailsOf*(self: ptr IShellFolder2, pidl: PCUITEMID_CHILD, iColumn: UINT, psd: ptr SHELLDETAILS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDetailsOf(self, pidl, iColumn, psd)
proc MapColumnToSCID*(self: ptr IShellFolder2, iColumn: UINT, pscid: ptr SHCOLUMNID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MapColumnToSCID(self, iColumn, pscid)
proc SetFolderViewOptions*(self: ptr IFolderViewOptions, fvoMask: FOLDERVIEWOPTIONS, fvoFlags: FOLDERVIEWOPTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolderViewOptions(self, fvoMask, fvoFlags)
proc GetFolderViewOptions*(self: ptr IFolderViewOptions, pfvoFlags: ptr FOLDERVIEWOPTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderViewOptions(self, pfvoFlags)
proc TranslateAccelerator*(self: ptr IShellView, pmsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAccelerator(self, pmsg)
proc EnableModeless*(self: ptr IShellView, fEnable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableModeless(self, fEnable)
proc UIActivate*(self: ptr IShellView, uState: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UIActivate(self, uState)
proc Refresh*(self: ptr IShellView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Refresh(self)
proc CreateViewWindow*(self: ptr IShellView, psvPrevious: ptr IShellView, pfs: LPCFOLDERSETTINGS, psb: ptr IShellBrowser, prcView: ptr RECT, phWnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateViewWindow(self, psvPrevious, pfs, psb, prcView, phWnd)
proc DestroyViewWindow*(self: ptr IShellView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DestroyViewWindow(self)
proc GetCurrentInfo*(self: ptr IShellView, pfs: LPFOLDERSETTINGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentInfo(self, pfs)
proc AddPropertySheetPages*(self: ptr IShellView, dwReserved: DWORD, pfn: LPFNSVADDPROPSHEETPAGE, lparam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPropertySheetPages(self, dwReserved, pfn, lparam)
proc SaveViewState*(self: ptr IShellView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveViewState(self)
proc SelectItem*(self: ptr IShellView, pidlItem: PCUITEMID_CHILD, uFlags: SVSIF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectItem(self, pidlItem, uFlags)
proc GetItemObject*(self: ptr IShellView, uItem: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemObject(self, uItem, riid, ppv)
proc GetView*(self: ptr IShellView2, pvid: ptr SHELLVIEWID, uView: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetView(self, pvid, uView)
proc CreateViewWindow2*(self: ptr IShellView2, lpParams: LPSV2CVW2_PARAMS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateViewWindow2(self, lpParams)
proc HandleRename*(self: ptr IShellView2, pidlNew: PCUITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleRename(self, pidlNew)
proc SelectAndPositionItem*(self: ptr IShellView2, pidlItem: PCUITEMID_CHILD, uFlags: UINT, ppt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectAndPositionItem(self, pidlItem, uFlags, ppt)
proc CreateViewWindow3*(self: ptr IShellView3, psbOwner: ptr IShellBrowser, psvPrev: ptr IShellView, dwViewFlags: SV3CVW3_FLAGS, dwMask: FOLDERFLAGS, dwFlags: FOLDERFLAGS, fvMode: FOLDERVIEWMODE, pvid: ptr SHELLVIEWID, prcView: ptr RECT, phwndView: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateViewWindow3(self, psbOwner, psvPrev, dwViewFlags, dwMask, dwFlags, fvMode, pvid, prcView, phwndView)
proc GetCurrentViewMode*(self: ptr IFolderView, pViewMode: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentViewMode(self, pViewMode)
proc SetCurrentViewMode*(self: ptr IFolderView, ViewMode: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCurrentViewMode(self, ViewMode)
proc GetFolder*(self: ptr IFolderView, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolder(self, riid, ppv)
proc Item*(self: ptr IFolderView, iItemIndex: int32, ppidl: ptr PITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Item(self, iItemIndex, ppidl)
proc ItemCount*(self: ptr IFolderView, uFlags: UINT, pcItems: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ItemCount(self, uFlags, pcItems)
proc Items*(self: ptr IFolderView, uFlags: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Items(self, uFlags, riid, ppv)
proc GetSelectionMarkedItem*(self: ptr IFolderView, piItem: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelectionMarkedItem(self, piItem)
proc GetFocusedItem*(self: ptr IFolderView, piItem: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFocusedItem(self, piItem)
proc GetItemPosition*(self: ptr IFolderView, pidl: PCUITEMID_CHILD, ppt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemPosition(self, pidl, ppt)
proc GetSpacing*(self: ptr IFolderView, ppt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSpacing(self, ppt)
proc GetDefaultSpacing*(self: ptr IFolderView, ppt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultSpacing(self, ppt)
proc GetAutoArrange*(self: ptr IFolderView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAutoArrange(self)
proc SelectItem*(self: ptr IFolderView, iItem: int32, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectItem(self, iItem, dwFlags)
proc SelectAndPositionItems*(self: ptr IFolderView, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, apt: ptr POINT, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectAndPositionItems(self, cidl, apidl, apt, dwFlags)
proc GetCondition*(self: ptr ISearchBoxInfo, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCondition(self, riid, ppv)
proc GetText*(self: ptr ISearchBoxInfo, ppsz: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetText(self, ppsz)
proc SetGroupBy*(self: ptr IFolderView2, key: REFPROPERTYKEY, fAscending: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGroupBy(self, key, fAscending)
proc GetGroupBy*(self: ptr IFolderView2, pkey: ptr PROPERTYKEY, pfAscending: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGroupBy(self, pkey, pfAscending)
proc SetViewProperty*(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, propkey: REFPROPERTYKEY, propvar: REFPROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetViewProperty(self, pidl, propkey, propvar)
proc GetViewProperty*(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, propkey: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewProperty(self, pidl, propkey, ppropvar)
proc SetTileViewProperties*(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, pszPropList: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTileViewProperties(self, pidl, pszPropList)
proc SetExtendedTileViewProperties*(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, pszPropList: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetExtendedTileViewProperties(self, pidl, pszPropList)
proc SetText*(self: ptr IFolderView2, iType: FVTEXTTYPE, pwszText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetText(self, iType, pwszText)
proc SetCurrentFolderFlags*(self: ptr IFolderView2, dwMask: DWORD, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCurrentFolderFlags(self, dwMask, dwFlags)
proc GetCurrentFolderFlags*(self: ptr IFolderView2, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentFolderFlags(self, pdwFlags)
proc GetSortColumnCount*(self: ptr IFolderView2, pcColumns: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSortColumnCount(self, pcColumns)
proc SetSortColumns*(self: ptr IFolderView2, rgSortColumns: ptr SORTCOLUMN, cColumns: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSortColumns(self, rgSortColumns, cColumns)
proc GetSortColumns*(self: ptr IFolderView2, rgSortColumns: ptr SORTCOLUMN, cColumns: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSortColumns(self, rgSortColumns, cColumns)
proc GetItem*(self: ptr IFolderView2, iItem: int32, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItem(self, iItem, riid, ppv)
proc GetVisibleItem*(self: ptr IFolderView2, iStart: int32, fPrevious: WINBOOL, piItem: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVisibleItem(self, iStart, fPrevious, piItem)
proc GetSelectedItem*(self: ptr IFolderView2, iStart: int32, piItem: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelectedItem(self, iStart, piItem)
proc GetSelection*(self: ptr IFolderView2, fNoneImpliesFolder: WINBOOL, ppsia: ptr ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelection(self, fNoneImpliesFolder, ppsia)
proc GetSelectionState*(self: ptr IFolderView2, pidl: PCUITEMID_CHILD, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelectionState(self, pidl, pdwFlags)
proc InvokeVerbOnSelection*(self: ptr IFolderView2, pszVerb: LPCSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeVerbOnSelection(self, pszVerb)
proc SetViewModeAndIconSize*(self: ptr IFolderView2, uViewMode: FOLDERVIEWMODE, iImageSize: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetViewModeAndIconSize(self, uViewMode, iImageSize)
proc GetViewModeAndIconSize*(self: ptr IFolderView2, puViewMode: ptr FOLDERVIEWMODE, piImageSize: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewModeAndIconSize(self, puViewMode, piImageSize)
proc SetGroupSubsetCount*(self: ptr IFolderView2, cVisibleRows: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGroupSubsetCount(self, cVisibleRows)
proc GetGroupSubsetCount*(self: ptr IFolderView2, pcVisibleRows: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGroupSubsetCount(self, pcVisibleRows)
proc SetRedraw*(self: ptr IFolderView2, fRedrawOn: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRedraw(self, fRedrawOn)
proc IsMoveInSameFolder*(self: ptr IFolderView2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsMoveInSameFolder(self)
proc DoRename*(self: ptr IFolderView2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoRename(self)
proc GetColumnPropertyList*(self: ptr IFolderViewSettings, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumnPropertyList(self, riid, ppv)
proc GetGroupByProperty*(self: ptr IFolderViewSettings, pkey: ptr PROPERTYKEY, pfGroupAscending: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGroupByProperty(self, pkey, pfGroupAscending)
proc GetViewMode*(self: ptr IFolderViewSettings, plvm: ptr FOLDERLOGICALVIEWMODE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewMode(self, plvm)
proc GetIconSize*(self: ptr IFolderViewSettings, puIconSize: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconSize(self, puIconSize)
proc GetFolderFlags*(self: ptr IFolderViewSettings, pfolderMask: ptr FOLDERFLAGS, pfolderFlags: ptr FOLDERFLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderFlags(self, pfolderMask, pfolderFlags)
proc GetSortColumns*(self: ptr IFolderViewSettings, rgSortColumns: ptr SORTCOLUMN, cColumnsIn: UINT, pcColumnsOut: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSortColumns(self, rgSortColumns, cColumnsIn, pcColumnsOut)
proc GetGroupSubsetCount*(self: ptr IFolderViewSettings, pcVisibleRows: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGroupSubsetCount(self, pcVisibleRows)
proc mSetBackgroundColor*(self: ptr IPreviewHandlerVisuals, color: COLORREF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBackgroundColor(self, color)
proc SetFont*(self: ptr IPreviewHandlerVisuals, plf: ptr LOGFONTW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFont(self, plf)
proc SetTextColor*(self: ptr IPreviewHandlerVisuals, color: COLORREF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTextColor(self, color)
proc SetWatermark*(self: ptr IVisualProperties, hbmp: HBITMAP, vpwf: VPWATERMARKFLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWatermark(self, hbmp, vpwf)
proc SetColor*(self: ptr IVisualProperties, vpcf: VPCOLORFLAGS, cr: COLORREF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetColor(self, vpcf, cr)
proc GetColor*(self: ptr IVisualProperties, vpcf: VPCOLORFLAGS, pcr: ptr COLORREF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColor(self, vpcf, pcr)
proc SetItemHeight*(self: ptr IVisualProperties, cyItemInPixels: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetItemHeight(self, cyItemInPixels)
proc GetItemHeight*(self: ptr IVisualProperties, cyItemInPixels: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemHeight(self, cyItemInPixels)
proc SetFont*(self: ptr IVisualProperties, plf: ptr LOGFONTW, bRedraw: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFont(self, plf, bRedraw)
proc GetFont*(self: ptr IVisualProperties, plf: ptr LOGFONTW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFont(self, plf)
proc SetTheme*(self: ptr IVisualProperties, pszSubAppName: LPCWSTR, pszSubIdList: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTheme(self, pszSubAppName, pszSubIdList)
proc OnDefaultCommand*(self: ptr ICommDlgBrowser, ppshv: ptr IShellView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDefaultCommand(self, ppshv)
proc OnStateChange*(self: ptr ICommDlgBrowser, ppshv: ptr IShellView, uChange: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnStateChange(self, ppshv, uChange)
proc IncludeObject*(self: ptr ICommDlgBrowser, ppshv: ptr IShellView, pidl: PCUITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IncludeObject(self, ppshv, pidl)
proc Notify*(self: ptr ICommDlgBrowser2, ppshv: ptr IShellView, dwNotifyType: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Notify(self, ppshv, dwNotifyType)
proc GetDefaultMenuText*(self: ptr ICommDlgBrowser2, ppshv: ptr IShellView, pszText: LPWSTR, cchMax: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultMenuText(self, ppshv, pszText, cchMax)
proc GetViewFlags*(self: ptr ICommDlgBrowser2, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewFlags(self, pdwFlags)
proc OnColumnClicked*(self: ptr ICommDlgBrowser3, ppshv: ptr IShellView, iColumn: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnColumnClicked(self, ppshv, iColumn)
proc GetCurrentFilter*(self: ptr ICommDlgBrowser3, pszFileSpec: LPWSTR, cchFileSpec: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentFilter(self, pszFileSpec, cchFileSpec)
proc OnPreViewCreated*(self: ptr ICommDlgBrowser3, ppshv: ptr IShellView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnPreViewCreated(self, ppshv)
proc SetColumnInfo*(self: ptr IColumnManager, propkey: REFPROPERTYKEY, pcmci: ptr CM_COLUMNINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetColumnInfo(self, propkey, pcmci)
proc GetColumnInfo*(self: ptr IColumnManager, propkey: REFPROPERTYKEY, pcmci: ptr CM_COLUMNINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumnInfo(self, propkey, pcmci)
proc GetColumnCount*(self: ptr IColumnManager, dwFlags: CM_ENUM_FLAGS, puCount: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumnCount(self, dwFlags, puCount)
proc GetColumns*(self: ptr IColumnManager, dwFlags: CM_ENUM_FLAGS, rgkeyOrder: ptr PROPERTYKEY, cColumns: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumns(self, dwFlags, rgkeyOrder, cColumns)
proc SetColumns*(self: ptr IColumnManager, rgkeyOrder: ptr PROPERTYKEY, cVisible: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetColumns(self, rgkeyOrder, cVisible)
proc SetFilter*(self: ptr IFolderFilterSite, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFilter(self, punk)
proc ShouldShow*(self: ptr IFolderFilter, psf: ptr IShellFolder, pidlFolder: PCIDLIST_ABSOLUTE, pidlItem: PCUITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShouldShow(self, psf, pidlFolder, pidlItem)
proc GetEnumFlags*(self: ptr IFolderFilter, psf: ptr IShellFolder, pidlFolder: PCIDLIST_ABSOLUTE, phwnd: ptr HWND, pgrfFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnumFlags(self, psf, pidlFolder, phwnd, pgrfFlags)
proc OnFocusChangeIS*(self: ptr IInputObjectSite, punkObj: ptr IUnknown, fSetFocus: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnFocusChangeIS(self, punkObj, fSetFocus)
proc UIActivateIO*(self: ptr IInputObject, fActivate: WINBOOL, pMsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UIActivateIO(self, fActivate, pMsg)
proc HasFocusIO*(self: ptr IInputObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HasFocusIO(self)
proc TranslateAcceleratorIO*(self: ptr IInputObject, pMsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAcceleratorIO(self, pMsg)
proc TranslateAcceleratorGlobal*(self: ptr IInputObject2, pMsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAcceleratorGlobal(self, pMsg)
proc GetIconOf*(self: ptr IShellIcon, pidl: PCUITEMID_CHILD, flags: UINT, pIconIndex: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconOf(self, pidl, flags, pIconIndex)
proc InsertMenusSB*(self: ptr IShellBrowser, hmenuShared: HMENU, lpMenuWidths: LPOLEMENUGROUPWIDTHS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InsertMenusSB(self, hmenuShared, lpMenuWidths)
proc SetMenuSB*(self: ptr IShellBrowser, hmenuShared: HMENU, holemenuRes: HOLEMENU, hwndActiveObject: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMenuSB(self, hmenuShared, holemenuRes, hwndActiveObject)
proc RemoveMenusSB*(self: ptr IShellBrowser, hmenuShared: HMENU): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveMenusSB(self, hmenuShared)
proc SetStatusTextSB*(self: ptr IShellBrowser, pszStatusText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetStatusTextSB(self, pszStatusText)
proc EnableModelessSB*(self: ptr IShellBrowser, fEnable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableModelessSB(self, fEnable)
proc TranslateAcceleratorSB*(self: ptr IShellBrowser, pmsg: ptr MSG, wID: WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAcceleratorSB(self, pmsg, wID)
proc BrowseObject*(self: ptr IShellBrowser, pidl: PCUIDLIST_RELATIVE, wFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BrowseObject(self, pidl, wFlags)
proc GetViewStateStream*(self: ptr IShellBrowser, grfMode: DWORD, ppStrm: ptr ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewStateStream(self, grfMode, ppStrm)
proc GetControlWindow*(self: ptr IShellBrowser, id: UINT, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetControlWindow(self, id, phwnd)
proc SendControlMsg*(self: ptr IShellBrowser, id: UINT, uMsg: UINT, wParam: WPARAM, lParam: LPARAM, pret: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendControlMsg(self, id, uMsg, wParam, lParam, pret)
proc QueryActiveShellView*(self: ptr IShellBrowser, ppshv: ptr ptr IShellView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryActiveShellView(self, ppshv)
proc OnViewWindowActive*(self: ptr IShellBrowser, pshv: ptr IShellView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnViewWindowActive(self, pshv)
proc SetToolbarItems*(self: ptr IShellBrowser, lpButtons: LPTBBUTTONSB, nButtons: UINT, uFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetToolbarItems(self, lpButtons, nButtons, uFlags)
proc ProfferService*(self: ptr IProfferService, guidService: REFGUID, psp: ptr IServiceProvider, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProfferService(self, guidService, psp, pdwCookie)
proc RevokeService*(self: ptr IProfferService, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RevokeService(self, dwCookie)
proc BindToHandler*(self: ptr IShellItem, pbc: ptr IBindCtx, bhid: REFGUID, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindToHandler(self, pbc, bhid, riid, ppv)
proc GetParent*(self: ptr IShellItem, ppsi: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetParent(self, ppsi)
proc GetDisplayName*(self: ptr IShellItem, sigdnName: SIGDN, ppszName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayName(self, sigdnName, ppszName)
proc GetAttributes*(self: ptr IShellItem, sfgaoMask: SFGAOF, psfgaoAttribs: ptr SFGAOF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAttributes(self, sfgaoMask, psfgaoAttribs)
proc Compare*(self: ptr IShellItem, psi: ptr IShellItem, hint: SICHINTF, piOrder: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Compare(self, psi, hint, piOrder)
proc GetPropertyStore*(self: ptr IShellItem2, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStore(self, flags, riid, ppv)
proc GetPropertyStoreWithCreateObject*(self: ptr IShellItem2, flags: GETPROPERTYSTOREFLAGS, punkCreateObject: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStoreWithCreateObject(self, flags, punkCreateObject, riid, ppv)
proc GetPropertyStoreForKeys*(self: ptr IShellItem2, rgKeys: ptr PROPERTYKEY, cKeys: UINT, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStoreForKeys(self, rgKeys, cKeys, flags, riid, ppv)
proc GetPropertyDescriptionList*(self: ptr IShellItem2, keyType: REFPROPERTYKEY, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyDescriptionList(self, keyType, riid, ppv)
proc Update*(self: ptr IShellItem2, pbc: ptr IBindCtx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Update(self, pbc)
proc GetProperty*(self: ptr IShellItem2, key: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, key, ppropvar)
proc GetCLSID*(self: ptr IShellItem2, key: REFPROPERTYKEY, pclsid: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCLSID(self, key, pclsid)
proc GetFileTime*(self: ptr IShellItem2, key: REFPROPERTYKEY, pft: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFileTime(self, key, pft)
proc GetInt32*(self: ptr IShellItem2, key: REFPROPERTYKEY, pi: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInt32(self, key, pi)
proc GetString*(self: ptr IShellItem2, key: REFPROPERTYKEY, ppsz: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetString(self, key, ppsz)
proc GetUInt32*(self: ptr IShellItem2, key: REFPROPERTYKEY, pui: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUInt32(self, key, pui)
proc GetUInt64*(self: ptr IShellItem2, key: REFPROPERTYKEY, pull: ptr ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUInt64(self, key, pull)
proc GetBool*(self: ptr IShellItem2, key: REFPROPERTYKEY, pf: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBool(self, key, pf)
proc GetImage*(self: ptr IShellItemImageFactory, size: SIZE, flags: SIIGBF, phbm: ptr HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImage(self, size, flags, phbm)
proc OnPictureChange*(self: ptr IUserAccountChangeCallback, pszUserName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnPictureChange(self, pszUserName)
proc Next*(self: ptr IEnumShellItems, celt: ULONG, rgelt: ptr ptr IShellItem, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumShellItems, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumShellItems): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumShellItems, ppenum: ptr ptr IEnumShellItems): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc UpdateProgress*(self: ptr ITransferAdviseSink, ullSizeCurrent: ULONGLONG, ullSizeTotal: ULONGLONG, nFilesCurrent: int32, nFilesTotal: int32, nFoldersCurrent: int32, nFoldersTotal: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateProgress(self, ullSizeCurrent, ullSizeTotal, nFilesCurrent, nFilesTotal, nFoldersCurrent, nFoldersTotal)
proc UpdateTransferState*(self: ptr ITransferAdviseSink, ts: TRANSFER_ADVISE_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateTransferState(self, ts)
proc ConfirmOverwrite*(self: ptr ITransferAdviseSink, psiSource: ptr IShellItem, psiDestParent: ptr IShellItem, pszName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConfirmOverwrite(self, psiSource, psiDestParent, pszName)
proc ConfirmEncryptionLoss*(self: ptr ITransferAdviseSink, psiSource: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConfirmEncryptionLoss(self, psiSource)
proc FileFailure*(self: ptr ITransferAdviseSink, psi: ptr IShellItem, pszItem: LPCWSTR, hrError: HRESULT, pszRename: LPWSTR, cchRename: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FileFailure(self, psi, pszItem, hrError, pszRename, cchRename)
proc SubStreamFailure*(self: ptr ITransferAdviseSink, psi: ptr IShellItem, pszStreamName: LPCWSTR, hrError: HRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SubStreamFailure(self, psi, pszStreamName, hrError)
proc PropertyFailure*(self: ptr ITransferAdviseSink, psi: ptr IShellItem, pkey: ptr PROPERTYKEY, hrError: HRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PropertyFailure(self, psi, pkey, hrError)
proc Advise*(self: ptr ITransferSource, psink: ptr ITransferAdviseSink, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, psink, pdwCookie)
proc Unadvise*(self: ptr ITransferSource, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwCookie)
proc SetProperties*(self: ptr ITransferSource, pproparray: ptr IPropertyChangeArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProperties(self, pproparray)
proc OpenItem*(self: ptr ITransferSource, psi: ptr IShellItem, flags: TRANSFER_SOURCE_FLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenItem(self, psi, flags, riid, ppv)
proc MoveItem*(self: ptr ITransferSource, psi: ptr IShellItem, psiParentDst: ptr IShellItem, pszNameDst: LPCWSTR, flags: TRANSFER_SOURCE_FLAGS, ppsiNew: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveItem(self, psi, psiParentDst, pszNameDst, flags, ppsiNew)
proc RecycleItem*(self: ptr ITransferSource, psiSource: ptr IShellItem, psiParentDest: ptr IShellItem, flags: TRANSFER_SOURCE_FLAGS, ppsiNewDest: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RecycleItem(self, psiSource, psiParentDest, flags, ppsiNewDest)
proc RemoveItem*(self: ptr ITransferSource, psiSource: ptr IShellItem, flags: TRANSFER_SOURCE_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveItem(self, psiSource, flags)
proc RenameItem*(self: ptr ITransferSource, psiSource: ptr IShellItem, pszNewName: LPCWSTR, flags: TRANSFER_SOURCE_FLAGS, ppsiNewDest: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RenameItem(self, psiSource, pszNewName, flags, ppsiNewDest)
proc LinkItem*(self: ptr ITransferSource, psiSource: ptr IShellItem, psiParentDest: ptr IShellItem, pszNewName: LPCWSTR, flags: TRANSFER_SOURCE_FLAGS, ppsiNewDest: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LinkItem(self, psiSource, psiParentDest, pszNewName, flags, ppsiNewDest)
proc ApplyPropertiesToItem*(self: ptr ITransferSource, psiSource: ptr IShellItem, ppsiNew: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplyPropertiesToItem(self, psiSource, ppsiNew)
proc GetDefaultDestinationName*(self: ptr ITransferSource, psiSource: ptr IShellItem, psiParentDest: ptr IShellItem, ppszDestinationName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultDestinationName(self, psiSource, psiParentDest, ppszDestinationName)
proc EnterFolder*(self: ptr ITransferSource, psiChildFolderDest: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnterFolder(self, psiChildFolderDest)
proc LeaveFolder*(self: ptr ITransferSource, psiChildFolderDest: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LeaveFolder(self, psiChildFolderDest)
proc Next*(self: ptr IEnumResources, celt: ULONG, psir: ptr SHELL_ITEM_RESOURCE, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, psir, pceltFetched)
proc Skip*(self: ptr IEnumResources, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumResources): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumResources, ppenumr: ptr ptr IEnumResources): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenumr)
proc GetAttributes*(self: ptr IShellItemResources, pdwAttributes: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAttributes(self, pdwAttributes)
proc GetSize*(self: ptr IShellItemResources, pullSize: ptr ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSize(self, pullSize)
proc GetTimes*(self: ptr IShellItemResources, pftCreation: ptr FILETIME, pftWrite: ptr FILETIME, pftAccess: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTimes(self, pftCreation, pftWrite, pftAccess)
proc SetTimes*(self: ptr IShellItemResources, pftCreation: ptr FILETIME, pftWrite: ptr FILETIME, pftAccess: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTimes(self, pftCreation, pftWrite, pftAccess)
proc GetResourceDescription*(self: ptr IShellItemResources, pcsir: ptr SHELL_ITEM_RESOURCE, ppszDescription: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetResourceDescription(self, pcsir, ppszDescription)
proc EnumResources*(self: ptr IShellItemResources, ppenumr: ptr ptr IEnumResources): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumResources(self, ppenumr)
proc SupportsResource*(self: ptr IShellItemResources, pcsir: ptr SHELL_ITEM_RESOURCE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SupportsResource(self, pcsir)
proc OpenResource*(self: ptr IShellItemResources, pcsir: ptr SHELL_ITEM_RESOURCE, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenResource(self, pcsir, riid, ppv)
proc CreateResource*(self: ptr IShellItemResources, pcsir: ptr SHELL_ITEM_RESOURCE, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateResource(self, pcsir, riid, ppv)
proc MarkForDelete*(self: ptr IShellItemResources): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MarkForDelete(self)
proc Advise*(self: ptr ITransferDestination, psink: ptr ITransferAdviseSink, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, psink, pdwCookie)
proc Unadvise*(self: ptr ITransferDestination, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwCookie)
proc CreateItem*(self: ptr ITransferDestination, pszName: LPCWSTR, dwAttributes: DWORD, ullSize: ULONGLONG, flags: TRANSFER_SOURCE_FLAGS, riidItem: REFIID, ppvItem: ptr pointer, riidResources: REFIID, ppvResources: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateItem(self, pszName, dwAttributes, ullSize, flags, riidItem, ppvItem, riidResources, ppvResources)
proc ReadAsync*(self: ptr IStreamAsync, pv: pointer, cb: DWORD, pcbRead: LPDWORD, lpOverlapped: LPOVERLAPPED): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReadAsync(self, pv, cb, pcbRead, lpOverlapped)
proc WriteAsync*(self: ptr IStreamAsync, lpBuffer: pointer, cb: DWORD, pcbWritten: LPDWORD, lpOverlapped: LPOVERLAPPED): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WriteAsync(self, lpBuffer, cb, pcbWritten, lpOverlapped)
proc OverlappedResult*(self: ptr IStreamAsync, lpOverlapped: LPOVERLAPPED, lpNumberOfBytesTransferred: LPDWORD, bWait: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OverlappedResult(self, lpOverlapped, lpNumberOfBytesTransferred, bWait)
proc CancelIo*(self: ptr IStreamAsync): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CancelIo(self)
proc GetSectorSize*(self: ptr IStreamUnbufferedInfo, pcbSectorSize: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSectorSize(self, pcbSectorSize)
proc StartOperations*(self: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartOperations(self)
proc FinishOperations*(self: ptr IFileOperationProgressSink, hrResult: HRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FinishOperations(self, hrResult)
proc PreRenameItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, pszNewName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreRenameItem(self, dwFlags, psiItem, pszNewName)
proc PostRenameItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, pszNewName: LPCWSTR, hrRename: HRESULT, psiNewlyCreated: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostRenameItem(self, dwFlags, psiItem, pszNewName, hrRename, psiNewlyCreated)
proc PreMoveItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreMoveItem(self, dwFlags, psiItem, psiDestinationFolder, pszNewName)
proc PostMoveItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR, hrMove: HRESULT, psiNewlyCreated: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostMoveItem(self, dwFlags, psiItem, psiDestinationFolder, pszNewName, hrMove, psiNewlyCreated)
proc PreCopyItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreCopyItem(self, dwFlags, psiItem, psiDestinationFolder, pszNewName)
proc PostCopyItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR, hrCopy: HRESULT, psiNewlyCreated: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostCopyItem(self, dwFlags, psiItem, psiDestinationFolder, pszNewName, hrCopy, psiNewlyCreated)
proc PreDeleteItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreDeleteItem(self, dwFlags, psiItem)
proc PostDeleteItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiItem: ptr IShellItem, hrDelete: HRESULT, psiNewlyCreated: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostDeleteItem(self, dwFlags, psiItem, hrDelete, psiNewlyCreated)
proc PreNewItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreNewItem(self, dwFlags, psiDestinationFolder, pszNewName)
proc PostNewItem*(self: ptr IFileOperationProgressSink, dwFlags: DWORD, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR, pszTemplateName: LPCWSTR, dwFileAttributes: DWORD, hrNew: HRESULT, psiNewItem: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostNewItem(self, dwFlags, psiDestinationFolder, pszNewName, pszTemplateName, dwFileAttributes, hrNew, psiNewItem)
proc UpdateProgress*(self: ptr IFileOperationProgressSink, iWorkTotal: UINT, iWorkSoFar: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateProgress(self, iWorkTotal, iWorkSoFar)
proc ResetTimer*(self: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetTimer(self)
proc PauseTimer*(self: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PauseTimer(self)
proc ResumeTimer*(self: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResumeTimer(self)
proc BindToHandler*(self: ptr IShellItemArray, pbc: ptr IBindCtx, bhid: REFGUID, riid: REFIID, ppvOut: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindToHandler(self, pbc, bhid, riid, ppvOut)
proc GetPropertyStore*(self: ptr IShellItemArray, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStore(self, flags, riid, ppv)
proc GetPropertyDescriptionList*(self: ptr IShellItemArray, keyType: REFPROPERTYKEY, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyDescriptionList(self, keyType, riid, ppv)
proc GetAttributes*(self: ptr IShellItemArray, AttribFlags: SIATTRIBFLAGS, sfgaoMask: SFGAOF, psfgaoAttribs: ptr SFGAOF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAttributes(self, AttribFlags, sfgaoMask, psfgaoAttribs)
proc GetCount*(self: ptr IShellItemArray, pdwNumItems: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCount(self, pdwNumItems)
proc GetItemAt*(self: ptr IShellItemArray, dwIndex: DWORD, ppsi: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemAt(self, dwIndex, ppsi)
proc EnumItems*(self: ptr IShellItemArray, ppenumShellItems: ptr ptr IEnumShellItems): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumItems(self, ppenumShellItems)
proc Initialize*(self: ptr IInitializeWithItem, psi: ptr IShellItem, grfMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, psi, grfMode)
proc SetSelection*(self: ptr IObjectWithSelection, psia: ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSelection(self, psia)
proc GetSelection*(self: ptr IObjectWithSelection, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelection(self, riid, ppv)
proc RemoveBackReferences*(self: ptr IObjectWithBackReferences): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveBackReferences(self)
proc ParsePropertyName*(self: ptr IPropertyUI, pszName: LPCWSTR, pfmtid: ptr FMTID, ppid: ptr PROPID, pchEaten: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParsePropertyName(self, pszName, pfmtid, ppid, pchEaten)
proc GetCannonicalName*(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pwszText: LPWSTR, cchText: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCannonicalName(self, fmtid, pid, pwszText, cchText)
proc GetDisplayName*(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, flags: PROPERTYUI_NAME_FLAGS, pwszText: LPWSTR, cchText: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayName(self, fmtid, pid, flags, pwszText, cchText)
proc GetPropertyDescription*(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pwszText: LPWSTR, cchText: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyDescription(self, fmtid, pid, pwszText, cchText)
proc GetDefaultWidth*(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pcxChars: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultWidth(self, fmtid, pid, pcxChars)
proc GetFlags*(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pflags: ptr PROPERTYUI_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFlags(self, fmtid, pid, pflags)
proc FormatForDisplay*(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, ppropvar: ptr PROPVARIANT, puiff: PROPERTYUI_FORMAT_FLAGS, pwszText: LPWSTR, cchText: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FormatForDisplay(self, fmtid, pid, ppropvar, puiff, pwszText, cchText)
proc GetHelpInfo*(self: ptr IPropertyUI, fmtid: REFFMTID, pid: PROPID, pwszHelpFile: LPWSTR, cch: DWORD, puHelpID: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHelpInfo(self, fmtid, pid, pwszHelpFile, cch, puHelpID)
proc CanCategorizeOnSCID*(self: ptr ICategoryProvider, pscid: ptr SHCOLUMNID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CanCategorizeOnSCID(self, pscid)
proc GetDefaultCategory*(self: ptr ICategoryProvider, pguid: ptr GUID, pscid: ptr SHCOLUMNID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultCategory(self, pguid, pscid)
proc GetCategoryForSCID*(self: ptr ICategoryProvider, pscid: ptr SHCOLUMNID, pguid: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCategoryForSCID(self, pscid, pguid)
proc EnumCategories*(self: ptr ICategoryProvider, penum: ptr ptr IEnumGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumCategories(self, penum)
proc GetCategoryName*(self: ptr ICategoryProvider, pguid: ptr GUID, pszName: LPWSTR, cch: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCategoryName(self, pguid, pszName, cch)
proc CreateCategory*(self: ptr ICategoryProvider, pguid: ptr GUID, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateCategory(self, pguid, riid, ppv)
proc GetDescription*(self: ptr ICategorizer, pszDesc: LPWSTR, cch: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescription(self, pszDesc, cch)
proc GetCategory*(self: ptr ICategorizer, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, rgCategoryIds: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCategory(self, cidl, apidl, rgCategoryIds)
proc GetCategoryInfo*(self: ptr ICategorizer, dwCategoryId: DWORD, pci: ptr TCATEGORY_INFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCategoryInfo(self, dwCategoryId, pci)
proc CompareCategory*(self: ptr ICategorizer, csfFlags: CATSORT_FLAGS, dwCategoryId1: DWORD, dwCategoryId2: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CompareCategory(self, csfFlags, dwCategoryId1, dwCategoryId2)
proc DragEnter*(self: ptr IDropTargetHelper, hwndTarget: HWND, pDataObject: ptr IDataObject, ppt: ptr POINT, dwEffect: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragEnter(self, hwndTarget, pDataObject, ppt, dwEffect)
proc DragLeave*(self: ptr IDropTargetHelper): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragLeave(self)
proc DragOver*(self: ptr IDropTargetHelper, ppt: ptr POINT, dwEffect: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragOver(self, ppt, dwEffect)
proc Drop*(self: ptr IDropTargetHelper, pDataObject: ptr IDataObject, ppt: ptr POINT, dwEffect: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Drop(self, pDataObject, ppt, dwEffect)
proc Show*(self: ptr IDropTargetHelper, fShow: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Show(self, fShow)
proc InitializeFromBitmap*(self: ptr IDragSourceHelper, pshdi: LPSHDRAGIMAGE, pDataObject: ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromBitmap(self, pshdi, pDataObject)
proc InitializeFromWindow*(self: ptr IDragSourceHelper, hwnd: HWND, ppt: ptr POINT, pDataObject: ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromWindow(self, hwnd, ppt, pDataObject)
proc SetFlags*(self: ptr IDragSourceHelper2, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFlags(self, dwFlags)
proc GetPath*(self: ptr IShellLinkA, pszFile: LPSTR, cch: int32, pfd: ptr WIN32_FIND_DATAA, fFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPath(self, pszFile, cch, pfd, fFlags)
proc GetIDList*(self: ptr IShellLinkA, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDList(self, ppidl)
proc SetIDList*(self: ptr IShellLinkA, pidl: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIDList(self, pidl)
proc GetDescription*(self: ptr IShellLinkA, pszName: LPSTR, cch: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescription(self, pszName, cch)
proc SetDescription*(self: ptr IShellLinkA, pszName: LPCSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDescription(self, pszName)
proc GetWorkingDirectory*(self: ptr IShellLinkA, pszDir: LPSTR, cch: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWorkingDirectory(self, pszDir, cch)
proc SetWorkingDirectory*(self: ptr IShellLinkA, pszDir: LPCSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWorkingDirectory(self, pszDir)
proc GetArguments*(self: ptr IShellLinkA, pszArgs: LPSTR, cch: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetArguments(self, pszArgs, cch)
proc SetArguments*(self: ptr IShellLinkA, pszArgs: LPCSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetArguments(self, pszArgs)
proc GetHotkey*(self: ptr IShellLinkA, pwHotkey: ptr WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHotkey(self, pwHotkey)
proc SetHotkey*(self: ptr IShellLinkA, wHotkey: WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHotkey(self, wHotkey)
proc GetShowCmd*(self: ptr IShellLinkA, piShowCmd: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetShowCmd(self, piShowCmd)
proc SetShowCmd*(self: ptr IShellLinkA, iShowCmd: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetShowCmd(self, iShowCmd)
proc GetIconLocation*(self: ptr IShellLinkA, pszIconPath: LPSTR, cch: int32, piIcon: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconLocation(self, pszIconPath, cch, piIcon)
proc SetIconLocation*(self: ptr IShellLinkA, pszIconPath: LPCSTR, iIcon: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIconLocation(self, pszIconPath, iIcon)
proc SetRelativePath*(self: ptr IShellLinkA, pszPathRel: LPCSTR, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRelativePath(self, pszPathRel, dwReserved)
proc Resolve*(self: ptr IShellLinkA, hwnd: HWND, fFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resolve(self, hwnd, fFlags)
proc SetPath*(self: ptr IShellLinkA, pszFile: LPCSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPath(self, pszFile)
proc GetPath*(self: ptr IShellLinkW, pszFile: LPWSTR, cch: int32, pfd: ptr WIN32_FIND_DATAW, fFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPath(self, pszFile, cch, pfd, fFlags)
proc GetIDList*(self: ptr IShellLinkW, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDList(self, ppidl)
proc SetIDList*(self: ptr IShellLinkW, pidl: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIDList(self, pidl)
proc GetDescription*(self: ptr IShellLinkW, pszName: LPWSTR, cch: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescription(self, pszName, cch)
proc SetDescription*(self: ptr IShellLinkW, pszName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDescription(self, pszName)
proc GetWorkingDirectory*(self: ptr IShellLinkW, pszDir: LPWSTR, cch: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWorkingDirectory(self, pszDir, cch)
proc SetWorkingDirectory*(self: ptr IShellLinkW, pszDir: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWorkingDirectory(self, pszDir)
proc GetArguments*(self: ptr IShellLinkW, pszArgs: LPWSTR, cch: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetArguments(self, pszArgs, cch)
proc SetArguments*(self: ptr IShellLinkW, pszArgs: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetArguments(self, pszArgs)
proc GetHotkey*(self: ptr IShellLinkW, pwHotkey: ptr WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHotkey(self, pwHotkey)
proc SetHotkey*(self: ptr IShellLinkW, wHotkey: WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHotkey(self, wHotkey)
proc GetShowCmd*(self: ptr IShellLinkW, piShowCmd: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetShowCmd(self, piShowCmd)
proc SetShowCmd*(self: ptr IShellLinkW, iShowCmd: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetShowCmd(self, iShowCmd)
proc GetIconLocation*(self: ptr IShellLinkW, pszIconPath: LPWSTR, cch: int32, piIcon: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconLocation(self, pszIconPath, cch, piIcon)
proc SetIconLocation*(self: ptr IShellLinkW, pszIconPath: LPCWSTR, iIcon: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIconLocation(self, pszIconPath, iIcon)
proc SetRelativePath*(self: ptr IShellLinkW, pszPathRel: LPCWSTR, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRelativePath(self, pszPathRel, dwReserved)
proc Resolve*(self: ptr IShellLinkW, hwnd: HWND, fFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resolve(self, hwnd, fFlags)
proc SetPath*(self: ptr IShellLinkW, pszFile: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPath(self, pszFile)
proc AddDataBlock*(self: ptr IShellLinkDataList, pDataBlock: pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddDataBlock(self, pDataBlock)
proc CopyDataBlock*(self: ptr IShellLinkDataList, dwSig: DWORD, ppDataBlock: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyDataBlock(self, dwSig, ppDataBlock)
proc RemoveDataBlock*(self: ptr IShellLinkDataList, dwSig: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveDataBlock(self, dwSig)
proc GetFlags*(self: ptr IShellLinkDataList, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFlags(self, pdwFlags)
proc SetFlags*(self: ptr IShellLinkDataList, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFlags(self, dwFlags)
proc ResolveShellLink*(self: ptr IResolveShellLink, punkLink: ptr IUnknown, hwnd: HWND, fFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResolveShellLink(self, punkLink, hwnd, fFlags)
proc Initialize*(self: ptr IActionProgressDialog, flags: SPINITF, pszTitle: LPCWSTR, pszCancel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, flags, pszTitle, pszCancel)
proc Stop*(self: ptr IActionProgressDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Stop(self)
proc Initialize*(self: ptr IHWEventHandler, pszParams: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pszParams)
proc HandleEvent*(self: ptr IHWEventHandler, pszDeviceID: LPCWSTR, pszAltDeviceID: LPCWSTR, pszEventType: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleEvent(self, pszDeviceID, pszAltDeviceID, pszEventType)
proc HandleEventWithContent*(self: ptr IHWEventHandler, pszDeviceID: LPCWSTR, pszAltDeviceID: LPCWSTR, pszEventType: LPCWSTR, pszContentTypeHandler: LPCWSTR, pdataobject: ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleEventWithContent(self, pszDeviceID, pszAltDeviceID, pszEventType, pszContentTypeHandler, pdataobject)
proc HandleEventWithHWND*(self: ptr IHWEventHandler2, pszDeviceID: LPCWSTR, pszAltDeviceID: LPCWSTR, pszEventType: LPCWSTR, hwndOwner: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleEventWithHWND(self, pszDeviceID, pszAltDeviceID, pszEventType, hwndOwner)
proc AllowAutoPlay*(self: ptr IQueryCancelAutoPlay, pszPath: LPCWSTR, dwContentType: DWORD, pszLabel: LPCWSTR, dwSerialNumber: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AllowAutoPlay(self, pszPath, dwContentType, pszLabel, dwSerialNumber)
proc GetDynamicInfo*(self: ptr IDynamicHWHandler, pszDeviceID: LPCWSTR, dwContentType: DWORD, ppszAction: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDynamicInfo(self, pszDeviceID, dwContentType, ppszAction)
proc Begin*(self: ptr IActionProgress, action: SPACTION, flags: SPBEGINF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin(self, action, flags)
proc UpdateProgress*(self: ptr IActionProgress, ulCompleted: ULONGLONG, ulTotal: ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateProgress(self, ulCompleted, ulTotal)
proc UpdateText*(self: ptr IActionProgress, sptext: SPTEXT, pszText: LPCWSTR, fMayCompact: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateText(self, sptext, pszText, fMayCompact)
proc QueryCancel*(self: ptr IActionProgress, pfCancelled: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryCancel(self, pfCancelled)
proc ResetCancel*(self: ptr IActionProgress): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetCancel(self)
proc End*(self: ptr IActionProgress): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.End(self)
proc Initialize*(self: ptr IShellExtInit, pidlFolder: PCIDLIST_ABSOLUTE, pdtobj: ptr IDataObject, hkeyProgID: HKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pidlFolder, pdtobj, hkeyProgID)
proc AddPages*(self: ptr IShellPropSheetExt, pfnAddPage: LPFNSVADDPROPSHEETPAGE, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPages(self, pfnAddPage, lParam)
proc ReplacePage*(self: ptr IShellPropSheetExt, uPageID: EXPPS, pfnReplaceWith: LPFNSVADDPROPSHEETPAGE, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReplacePage(self, uPageID, pfnReplaceWith, lParam)
proc Initialize*(self: ptr IRemoteComputer, pszMachine: LPCWSTR, bEnumerating: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pszMachine, bEnumerating)
proc QueryContinue*(self: ptr IQueryContinue): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryContinue(self)
proc GetCancelEvent*(self: ptr IObjectWithCancelEvent, phEvent: ptr HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCancelEvent(self, phEvent)
proc SetBalloonInfo*(self: ptr IUserNotification, pszTitle: LPCWSTR, pszText: LPCWSTR, dwInfoFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBalloonInfo(self, pszTitle, pszText, dwInfoFlags)
proc SetBalloonRetry*(self: ptr IUserNotification, dwShowTime: DWORD, dwInterval: DWORD, cRetryCount: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBalloonRetry(self, dwShowTime, dwInterval, cRetryCount)
proc SetIconInfo*(self: ptr IUserNotification, hIcon: HICON, pszToolTip: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIconInfo(self, hIcon, pszToolTip)
proc Show*(self: ptr IUserNotification, pqc: ptr IQueryContinue, dwContinuePollInterval: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Show(self, pqc, dwContinuePollInterval)
proc PlaySound*(self: ptr IUserNotification, pszSoundName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PlaySound(self, pszSoundName)
proc OnBalloonUserClick*(self: ptr IUserNotificationCallback, pt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnBalloonUserClick(self, pt)
proc OnLeftClick*(self: ptr IUserNotificationCallback, pt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnLeftClick(self, pt)
proc OnContextMenu*(self: ptr IUserNotificationCallback, pt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnContextMenu(self, pt)
proc SetBalloonInfo*(self: ptr IUserNotification2, pszTitle: LPCWSTR, pszText: LPCWSTR, dwInfoFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBalloonInfo(self, pszTitle, pszText, dwInfoFlags)
proc SetBalloonRetry*(self: ptr IUserNotification2, dwShowTime: DWORD, dwInterval: DWORD, cRetryCount: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBalloonRetry(self, dwShowTime, dwInterval, cRetryCount)
proc SetIconInfo*(self: ptr IUserNotification2, hIcon: HICON, pszToolTip: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIconInfo(self, hIcon, pszToolTip)
proc Show*(self: ptr IUserNotification2, pqc: ptr IQueryContinue, dwContinuePollInterval: DWORD, pSink: ptr IUserNotificationCallback): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Show(self, pqc, dwContinuePollInterval, pSink)
proc PlaySound*(self: ptr IUserNotification2, pszSoundName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PlaySound(self, pszSoundName)
proc GetValidCharacters*(self: ptr IItemNameLimits, ppwszValidChars: ptr LPWSTR, ppwszInvalidChars: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetValidCharacters(self, ppwszValidChars, ppwszInvalidChars)
proc GetMaxLength*(self: ptr IItemNameLimits, pszName: LPCWSTR, piMaxNameLen: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMaxLength(self, pszName, piMaxNameLen)
proc SetDisplayName*(self: ptr ISearchFolderItemFactory, pszDisplayName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDisplayName(self, pszDisplayName)
proc SetFolderTypeID*(self: ptr ISearchFolderItemFactory, ftid: FOLDERTYPEID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolderTypeID(self, ftid)
proc SetFolderLogicalViewMode*(self: ptr ISearchFolderItemFactory, flvm: FOLDERLOGICALVIEWMODE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolderLogicalViewMode(self, flvm)
proc SetIconSize*(self: ptr ISearchFolderItemFactory, iIconSize: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIconSize(self, iIconSize)
proc SetVisibleColumns*(self: ptr ISearchFolderItemFactory, cVisibleColumns: UINT, rgKey: ptr PROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVisibleColumns(self, cVisibleColumns, rgKey)
proc SetSortColumns*(self: ptr ISearchFolderItemFactory, cSortColumns: UINT, rgSortColumns: ptr SORTCOLUMN): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSortColumns(self, cSortColumns, rgSortColumns)
proc SetGroupColumn*(self: ptr ISearchFolderItemFactory, keyGroup: REFPROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGroupColumn(self, keyGroup)
proc SetStacks*(self: ptr ISearchFolderItemFactory, cStackKeys: UINT, rgStackKeys: ptr PROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetStacks(self, cStackKeys, rgStackKeys)
proc SetScope*(self: ptr ISearchFolderItemFactory, psiaScope: ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetScope(self, psiaScope)
proc SetCondition*(self: ptr ISearchFolderItemFactory, pCondition: ptr ICondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCondition(self, pCondition)
proc GetShellItem*(self: ptr ISearchFolderItemFactory, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetShellItem(self, riid, ppv)
proc GetIDList*(self: ptr ISearchFolderItemFactory, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDList(self, ppidl)
proc GetLocation*(self: ptr IExtractImage, pszPathBuffer: LPWSTR, cch: DWORD, pdwPriority: ptr DWORD, prgSize: ptr SIZE, dwRecClrDepth: DWORD, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLocation(self, pszPathBuffer, cch, pdwPriority, prgSize, dwRecClrDepth, pdwFlags)
proc Extract*(self: ptr IExtractImage, phBmpThumbnail: ptr HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Extract(self, phBmpThumbnail)
proc GetDateStamp*(self: ptr IExtractImage2, pDateStamp: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDateStamp(self, pDateStamp)
proc GetThumbnailHandler*(self: ptr IThumbnailHandlerFactory, pidlChild: PCUITEMID_CHILD, pbc: ptr IBindCtx, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetThumbnailHandler(self, pidlChild, pbc, riid, ppv)
proc SetParentAndItem*(self: ptr IParentAndItem, pidlParent: PCIDLIST_ABSOLUTE, psf: ptr IShellFolder, pidlChild: PCUITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetParentAndItem(self, pidlParent, psf, pidlChild)
proc GetParentAndItem*(self: ptr IParentAndItem, ppidlParent: ptr PIDLIST_ABSOLUTE, ppsf: ptr ptr IShellFolder, ppidlChild: ptr PITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetParentAndItem(self, ppidlParent, ppsf, ppidlChild)
proc ShowDW*(self: ptr IDockingWindow, fShow: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowDW(self, fShow)
proc CloseDW*(self: ptr IDockingWindow, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CloseDW(self, dwReserved)
proc ResizeBorderDW*(self: ptr IDockingWindow, prcBorder: LPCRECT, punkToolbarSite: ptr IUnknown, fReserved: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResizeBorderDW(self, prcBorder, punkToolbarSite, fReserved)
proc GetBandInfo*(self: ptr IDeskBand, dwBandID: DWORD, dwViewMode: DWORD, pdbi: ptr DESKBANDINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBandInfo(self, dwBandID, dwViewMode, pdbi)
proc GetDefaultBandWidth*(self: ptr IDeskBandInfo, dwBandID: DWORD, dwViewMode: DWORD, pnWidth: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultBandWidth(self, dwBandID, dwViewMode, pnWidth)
proc CanRenderComposited*(self: ptr IDeskBand2, pfCanRenderComposited: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CanRenderComposited(self, pfCanRenderComposited)
proc SetCompositionState*(self: ptr IDeskBand2, fCompositionEnabled: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCompositionState(self, fCompositionEnabled)
proc GetCompositionState*(self: ptr IDeskBand2, pfCompositionEnabled: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCompositionState(self, pfCompositionEnabled)
proc HrInit*(self: ptr ITaskbarList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HrInit(self)
proc AddTab*(self: ptr ITaskbarList, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddTab(self, hwnd)
proc DeleteTab*(self: ptr ITaskbarList, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteTab(self, hwnd)
proc ActivateTab*(self: ptr ITaskbarList, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ActivateTab(self, hwnd)
proc SetActiveAlt*(self: ptr ITaskbarList, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetActiveAlt(self, hwnd)
proc MarkFullscreenWindow*(self: ptr ITaskbarList2, hwnd: HWND, fFullscreen: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MarkFullscreenWindow(self, hwnd, fFullscreen)
proc SetProgressValue*(self: ptr ITaskbarList3, hwnd: HWND, ullCompleted: ULONGLONG, ullTotal: ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProgressValue(self, hwnd, ullCompleted, ullTotal)
proc SetProgressState*(self: ptr ITaskbarList3, hwnd: HWND, tbpFlags: TBPFLAG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProgressState(self, hwnd, tbpFlags)
proc RegisterTab*(self: ptr ITaskbarList3, hwndTab: HWND, hwndMDI: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterTab(self, hwndTab, hwndMDI)
proc UnregisterTab*(self: ptr ITaskbarList3, hwndTab: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterTab(self, hwndTab)
proc SetTabOrder*(self: ptr ITaskbarList3, hwndTab: HWND, hwndInsertBefore: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTabOrder(self, hwndTab, hwndInsertBefore)
proc SetTabActive*(self: ptr ITaskbarList3, hwndTab: HWND, hwndMDI: HWND, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTabActive(self, hwndTab, hwndMDI, dwReserved)
proc ThumbBarAddButtons*(self: ptr ITaskbarList3, hwnd: HWND, cButtons: UINT, pButton: LPTHUMBBUTTON): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ThumbBarAddButtons(self, hwnd, cButtons, pButton)
proc ThumbBarUpdateButtons*(self: ptr ITaskbarList3, hwnd: HWND, cButtons: UINT, pButton: LPTHUMBBUTTON): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ThumbBarUpdateButtons(self, hwnd, cButtons, pButton)
proc ThumbBarSetImageList*(self: ptr ITaskbarList3, hwnd: HWND, himl: HIMAGELIST): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ThumbBarSetImageList(self, hwnd, himl)
proc SetOverlayIcon*(self: ptr ITaskbarList3, hwnd: HWND, hIcon: HICON, pszDescription: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOverlayIcon(self, hwnd, hIcon, pszDescription)
proc SetThumbnailTooltip*(self: ptr ITaskbarList3, hwnd: HWND, pszTip: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetThumbnailTooltip(self, hwnd, pszTip)
proc SetThumbnailClip*(self: ptr ITaskbarList3, hwnd: HWND, prcClip: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetThumbnailClip(self, hwnd, prcClip)
proc SetTabProperties*(self: ptr ITaskbarList4, hwndTab: HWND, stpFlags: STPFLAG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTabProperties(self, hwndTab, stpFlags)
proc RemoveFromList*(self: ptr IStartMenuPinnedList, pitem: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveFromList(self, pitem)
proc GetRecorderDriveLetter*(self: ptr ICDBurn, pszDrive: LPWSTR, cch: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRecorderDriveLetter(self, pszDrive, cch)
proc Burn*(self: ptr ICDBurn, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Burn(self, hwnd)
proc HasRecordableDrive*(self: ptr ICDBurn, pfHasRecorder: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HasRecordableDrive(self, pfHasRecorder)
proc GetPreviousPage*(self: ptr IWizardSite, phpage: ptr HPROPSHEETPAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPreviousPage(self, phpage)
proc GetNextPage*(self: ptr IWizardSite, phpage: ptr HPROPSHEETPAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNextPage(self, phpage)
proc GetCancelledPage*(self: ptr IWizardSite, phpage: ptr HPROPSHEETPAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCancelledPage(self, phpage)
proc AddPages*(self: ptr IWizardExtension, aPages: ptr HPROPSHEETPAGE, cPages: UINT, pnPagesAdded: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPages(self, aPages, cPages, pnPagesAdded)
proc GetFirstPage*(self: ptr IWizardExtension, phpage: ptr HPROPSHEETPAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFirstPage(self, phpage)
proc GetLastPage*(self: ptr IWizardExtension, phpage: ptr HPROPSHEETPAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLastPage(self, phpage)
proc SetInitialURL*(self: ptr IWebWizardExtension, pszURL: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetInitialURL(self, pszURL)
proc SetErrorURL*(self: ptr IWebWizardExtension, pszErrorURL: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetErrorURL(self, pszErrorURL)
proc Initialize*(self: ptr IPublishingWizard, pdo: ptr IDataObject, dwOptions: DWORD, pszServiceScope: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pdo, dwOptions, pszServiceScope)
proc GetTransferManifest*(self: ptr IPublishingWizard, phrFromTransfer: ptr HRESULT, pdocManifest: ptr ptr IXMLDOMDocument): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTransferManifest(self, phrFromTransfer, pdocManifest)
proc Initialize*(self: ptr IFolderViewHost, hwndParent: HWND, pdo: ptr IDataObject, prc: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, hwndParent, pdo, prc)
proc OnNavigationPending*(self: ptr IExplorerBrowserEvents, pidlFolder: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnNavigationPending(self, pidlFolder)
proc OnViewCreated*(self: ptr IExplorerBrowserEvents, psv: ptr IShellView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnViewCreated(self, psv)
proc OnNavigationComplete*(self: ptr IExplorerBrowserEvents, pidlFolder: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnNavigationComplete(self, pidlFolder)
proc OnNavigationFailed*(self: ptr IExplorerBrowserEvents, pidlFolder: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnNavigationFailed(self, pidlFolder)
proc Initialize*(self: ptr IExplorerBrowser, hwndParent: HWND, prc: ptr RECT, pfs: ptr FOLDERSETTINGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, hwndParent, prc, pfs)
proc Destroy*(self: ptr IExplorerBrowser): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Destroy(self)
proc SetRect*(self: ptr IExplorerBrowser, phdwp: ptr HDWP, rcBrowser: RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRect(self, phdwp, rcBrowser)
proc SetPropertyBag*(self: ptr IExplorerBrowser, pszPropertyBag: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPropertyBag(self, pszPropertyBag)
proc SetEmptyText*(self: ptr IExplorerBrowser, pszEmptyText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetEmptyText(self, pszEmptyText)
proc SetFolderSettings*(self: ptr IExplorerBrowser, pfs: ptr FOLDERSETTINGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolderSettings(self, pfs)
proc Advise*(self: ptr IExplorerBrowser, psbe: ptr IExplorerBrowserEvents, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, psbe, pdwCookie)
proc Unadvise*(self: ptr IExplorerBrowser, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwCookie)
proc SetOptions*(self: ptr IExplorerBrowser, dwFlag: EXPLORER_BROWSER_OPTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOptions(self, dwFlag)
proc GetOptions*(self: ptr IExplorerBrowser, pdwFlag: ptr EXPLORER_BROWSER_OPTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOptions(self, pdwFlag)
proc BrowseToIDList*(self: ptr IExplorerBrowser, pidl: PCUIDLIST_RELATIVE, uFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BrowseToIDList(self, pidl, uFlags)
proc BrowseToObject*(self: ptr IExplorerBrowser, punk: ptr IUnknown, uFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BrowseToObject(self, punk, uFlags)
proc FillFromObject*(self: ptr IExplorerBrowser, punk: ptr IUnknown, dwFlags: EXPLORER_BROWSER_FILL_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FillFromObject(self, punk, dwFlags)
proc RemoveAll*(self: ptr IExplorerBrowser): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveAll(self)
proc GetCurrentView*(self: ptr IExplorerBrowser, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentView(self, riid, ppv)
proc SetAccessibleName*(self: ptr IAccessibleObject, pszName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAccessibleName(self, pszName)
proc AddItem*(self: ptr IResultsFolder, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddItem(self, psi)
proc AddIDList*(self: ptr IResultsFolder, pidl: PCIDLIST_ABSOLUTE, ppidlAdded: ptr PITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddIDList(self, pidl, ppidlAdded)
proc RemoveItem*(self: ptr IResultsFolder, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveItem(self, psi)
proc RemoveIDList*(self: ptr IResultsFolder, pidl: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveIDList(self, pidl)
proc RemoveAll*(self: ptr IResultsFolder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveAll(self)
proc Next*(self: ptr IEnumObjects, celt: ULONG, riid: REFIID, rgelt: ptr pointer, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, riid, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumObjects, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumObjects): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumObjects, ppenum: ptr ptr IEnumObjects): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc StartProgressDialog*(self: ptr IOperationsProgressDialog, hwndOwner: HWND, flags: OPPROGDLGF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartProgressDialog(self, hwndOwner, flags)
proc StopProgressDialog*(self: ptr IOperationsProgressDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StopProgressDialog(self)
proc SetOperation*(self: ptr IOperationsProgressDialog, action: SPACTION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOperation(self, action)
proc SetMode*(self: ptr IOperationsProgressDialog, mode: PDMODE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMode(self, mode)
proc UpdateProgress*(self: ptr IOperationsProgressDialog, ullPointsCurrent: ULONGLONG, ullPointsTotal: ULONGLONG, ullSizeCurrent: ULONGLONG, ullSizeTotal: ULONGLONG, ullItemsCurrent: ULONGLONG, ullItemsTotal: ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateProgress(self, ullPointsCurrent, ullPointsTotal, ullSizeCurrent, ullSizeTotal, ullItemsCurrent, ullItemsTotal)
proc UpdateLocations*(self: ptr IOperationsProgressDialog, psiSource: ptr IShellItem, psiTarget: ptr IShellItem, psiItem: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateLocations(self, psiSource, psiTarget, psiItem)
proc ResetTimer*(self: ptr IOperationsProgressDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetTimer(self)
proc PauseTimer*(self: ptr IOperationsProgressDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PauseTimer(self)
proc ResumeTimer*(self: ptr IOperationsProgressDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResumeTimer(self)
proc GetMilliseconds*(self: ptr IOperationsProgressDialog, pullElapsed: ptr ULONGLONG, pullRemaining: ptr ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMilliseconds(self, pullElapsed, pullRemaining)
proc GetOperationStatus*(self: ptr IOperationsProgressDialog, popstatus: ptr PDOPSTATUS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOperationStatus(self, popstatus)
proc SetCancelInformation*(self: ptr IIOCancelInformation, dwThreadID: DWORD, uMsgCancel: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCancelInformation(self, dwThreadID, uMsgCancel)
proc GetCancelInformation*(self: ptr IIOCancelInformation, pdwThreadID: ptr DWORD, puMsgCancel: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCancelInformation(self, pdwThreadID, puMsgCancel)
proc Advise*(self: ptr IFileOperation, pfops: ptr IFileOperationProgressSink, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, pfops, pdwCookie)
proc Unadvise*(self: ptr IFileOperation, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwCookie)
proc SetOperationFlags*(self: ptr IFileOperation, dwOperationFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOperationFlags(self, dwOperationFlags)
proc SetProgressMessage*(self: ptr IFileOperation, pszMessage: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProgressMessage(self, pszMessage)
proc SetProgressDialog*(self: ptr IFileOperation, popd: ptr IOperationsProgressDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProgressDialog(self, popd)
proc SetProperties*(self: ptr IFileOperation, pproparray: ptr IPropertyChangeArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProperties(self, pproparray)
proc SetOwnerWindow*(self: ptr IFileOperation, hwndOwner: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOwnerWindow(self, hwndOwner)
proc ApplyPropertiesToItem*(self: ptr IFileOperation, psiItem: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplyPropertiesToItem(self, psiItem)
proc ApplyPropertiesToItems*(self: ptr IFileOperation, punkItems: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplyPropertiesToItems(self, punkItems)
proc RenameItem*(self: ptr IFileOperation, psiItem: ptr IShellItem, pszNewName: LPCWSTR, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RenameItem(self, psiItem, pszNewName, pfopsItem)
proc RenameItems*(self: ptr IFileOperation, pUnkItems: ptr IUnknown, pszNewName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RenameItems(self, pUnkItems, pszNewName)
proc MoveItem*(self: ptr IFileOperation, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszNewName: LPCWSTR, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveItem(self, psiItem, psiDestinationFolder, pszNewName, pfopsItem)
proc MoveItems*(self: ptr IFileOperation, punkItems: ptr IUnknown, psiDestinationFolder: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveItems(self, punkItems, psiDestinationFolder)
proc CopyItem*(self: ptr IFileOperation, psiItem: ptr IShellItem, psiDestinationFolder: ptr IShellItem, pszCopyName: LPCWSTR, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyItem(self, psiItem, psiDestinationFolder, pszCopyName, pfopsItem)
proc CopyItems*(self: ptr IFileOperation, punkItems: ptr IUnknown, psiDestinationFolder: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyItems(self, punkItems, psiDestinationFolder)
proc DeleteItem*(self: ptr IFileOperation, psiItem: ptr IShellItem, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteItem(self, psiItem, pfopsItem)
proc DeleteItems*(self: ptr IFileOperation, punkItems: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteItems(self, punkItems)
proc NewItem*(self: ptr IFileOperation, psiDestinationFolder: ptr IShellItem, dwFileAttributes: DWORD, pszName: LPCWSTR, pszTemplateName: LPCWSTR, pfopsItem: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NewItem(self, psiDestinationFolder, dwFileAttributes, pszName, pszTemplateName, pfopsItem)
proc PerformOperations*(self: ptr IFileOperation): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PerformOperations(self)
proc GetAnyOperationsAborted*(self: ptr IFileOperation, pfAnyOperationsAborted: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAnyOperationsAborted(self, pfAnyOperationsAborted)
proc QueryObject*(self: ptr IObjectProvider, guidObject: REFGUID, riid: REFIID, ppvOut: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryObject(self, guidObject, riid, ppvOut)
proc FoundItem*(self: ptr INamespaceWalkCB, psf: ptr IShellFolder, pidl: PCUITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FoundItem(self, psf, pidl)
proc EnterFolder*(self: ptr INamespaceWalkCB, psf: ptr IShellFolder, pidl: PCUITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnterFolder(self, psf, pidl)
proc LeaveFolder*(self: ptr INamespaceWalkCB, psf: ptr IShellFolder, pidl: PCUITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LeaveFolder(self, psf, pidl)
proc InitializeProgressDialog*(self: ptr INamespaceWalkCB, ppszTitle: ptr LPWSTR, ppszCancel: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeProgressDialog(self, ppszTitle, ppszCancel)
proc WalkComplete*(self: ptr INamespaceWalkCB2, hr: HRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WalkComplete(self, hr)
proc Walk*(self: ptr INamespaceWalk, punkToWalk: ptr IUnknown, dwFlags: DWORD, cDepth: int32, pnswcb: ptr INamespaceWalkCB): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Walk(self, punkToWalk, dwFlags, cDepth, pnswcb)
proc GetIDArrayResult*(self: ptr INamespaceWalk, pcItems: ptr UINT, prgpidl: ptr ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDArrayResult(self, pcItems, prgpidl)
proc GetDropDownStatus*(self: ptr IAutoCompleteDropDown, pdwFlags: ptr DWORD, ppwszString: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDropDownStatus(self, pdwFlags, ppwszString)
proc ResetEnumerator*(self: ptr IAutoCompleteDropDown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetEnumerator(self)
proc AddBand*(self: ptr IBandSite, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddBand(self, punk)
proc EnumBands*(self: ptr IBandSite, uBand: UINT, pdwBandID: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumBands(self, uBand, pdwBandID)
proc QueryBand*(self: ptr IBandSite, dwBandID: DWORD, ppstb: ptr ptr IDeskBand, pdwState: ptr DWORD, pszName: LPWSTR, cchName: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryBand(self, dwBandID, ppstb, pdwState, pszName, cchName)
proc SetBandState*(self: ptr IBandSite, dwBandID: DWORD, dwMask: DWORD, dwState: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBandState(self, dwBandID, dwMask, dwState)
proc RemoveBand*(self: ptr IBandSite, dwBandID: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveBand(self, dwBandID)
proc GetBandObject*(self: ptr IBandSite, dwBandID: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBandObject(self, dwBandID, riid, ppv)
proc SetBandSiteInfo*(self: ptr IBandSite, pbsinfo: ptr BANDSITEINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBandSiteInfo(self, pbsinfo)
proc GetBandSiteInfo*(self: ptr IBandSite, pbsinfo: ptr BANDSITEINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBandSiteInfo(self, pbsinfo)
proc Show*(self: ptr IModalWindow, hwndOwner: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Show(self, hwndOwner)
proc GetSupportedActionTypes*(self: ptr ICDBurnExt, pdwActions: ptr CDBE_ACTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSupportedActionTypes(self, pdwActions)
proc DoContextMenuPopup*(self: ptr IContextMenuSite, punkContextMenu: ptr IUnknown, fFlags: UINT, pt: POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoContextMenuPopup(self, punkContextMenu, fFlags, pt)
proc EnumReady*(self: ptr IEnumReadyCallback): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumReady(self)
proc SetEnumReadyCallback*(self: ptr IEnumerableView, percb: ptr IEnumReadyCallback): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetEnumReadyCallback(self, percb)
proc CreateEnumIDListFromContents*(self: ptr IEnumerableView, pidlFolder: PCIDLIST_ABSOLUTE, dwEnumFlags: DWORD, ppEnumIDList: ptr ptr IEnumIDList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateEnumIDListFromContents(self, pidlFolder, dwEnumFlags, ppEnumIDList)
proc InsertItem*(self: ptr IInsertItem, pidl: PCUIDLIST_RELATIVE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InsertItem(self, pidl)
proc IsMenuMessage*(self: ptr IMenuBand, pmsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsMenuMessage(self, pmsg)
proc TranslateMenuMessage*(self: ptr IMenuBand, pmsg: ptr MSG, plRet: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateMenuMessage(self, pmsg, plRet)
proc SetCascade*(self: ptr IFolderBandPriv, fCascade: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCascade(self, fCascade)
proc SetAccelerators*(self: ptr IFolderBandPriv, fAccelerators: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAccelerators(self, fAccelerators)
proc SetNoIcons*(self: ptr IFolderBandPriv, fNoIcons: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetNoIcons(self, fNoIcons)
proc SetNoText*(self: ptr IFolderBandPriv, fNoText: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetNoText(self, fNoText)
proc GetCheckState*(self: ptr IRegTreeItem, pbCheck: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCheckState(self, pbCheck)
proc SetCheckState*(self: ptr IRegTreeItem, bCheck: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCheckState(self, bCheck)
proc RecompressImage*(self: ptr IImageRecompress, psi: ptr IShellItem, cx: int32, cy: int32, iQuality: int32, pstg: ptr IStorage, ppstrmOut: ptr ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RecompressImage(self, psi, cx, cy, iQuality, pstg, ppstrmOut)
proc SetClient*(self: ptr IDeskBar, punkClient: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetClient(self, punkClient)
proc GetClient*(self: ptr IDeskBar, ppunkClient: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClient(self, ppunkClient)
proc OnPosRectChangeDB*(self: ptr IDeskBar, prc: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnPosRectChangeDB(self, prc)
proc Popup*(self: ptr IMenuPopup, ppt: ptr POINTL, prcExclude: ptr RECTL, dwFlags: MP_POPUPFLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Popup(self, ppt, prcExclude, dwFlags)
proc OnSelect*(self: ptr IMenuPopup, dwSelectType: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnSelect(self, dwSelectType)
proc SetSubMenu*(self: ptr IMenuPopup, pmp: ptr IMenuPopup, fSet: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSubMenu(self, pmp, fSet)
proc GetAppName*(self: ptr IFileIsInUse, ppszName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAppName(self, ppszName)
proc GetUsage*(self: ptr IFileIsInUse, pfut: ptr FILE_USAGE_TYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUsage(self, pfut)
proc GetCapabilities*(self: ptr IFileIsInUse, pdwCapFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCapabilities(self, pdwCapFlags)
proc GetSwitchToHWND*(self: ptr IFileIsInUse, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSwitchToHWND(self, phwnd)
proc CloseFile*(self: ptr IFileIsInUse): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CloseFile(self)
proc OnFileOk*(self: ptr IFileDialogEvents, pfd: ptr IFileDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnFileOk(self, pfd)
proc OnFolderChanging*(self: ptr IFileDialogEvents, pfd: ptr IFileDialog, psiFolder: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnFolderChanging(self, pfd, psiFolder)
proc OnFolderChange*(self: ptr IFileDialogEvents, pfd: ptr IFileDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnFolderChange(self, pfd)
proc OnSelectionChange*(self: ptr IFileDialogEvents, pfd: ptr IFileDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnSelectionChange(self, pfd)
proc OnShareViolation*(self: ptr IFileDialogEvents, pfd: ptr IFileDialog, psi: ptr IShellItem, pResponse: ptr FDE_SHAREVIOLATION_RESPONSE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnShareViolation(self, pfd, psi, pResponse)
proc OnTypeChange*(self: ptr IFileDialogEvents, pfd: ptr IFileDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnTypeChange(self, pfd)
proc OnOverwrite*(self: ptr IFileDialogEvents, pfd: ptr IFileDialog, psi: ptr IShellItem, pResponse: ptr FDE_OVERWRITE_RESPONSE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnOverwrite(self, pfd, psi, pResponse)
proc SetFileTypes*(self: ptr IFileDialog, cFileTypes: UINT, rgFilterSpec: ptr COMDLG_FILTERSPEC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFileTypes(self, cFileTypes, rgFilterSpec)
proc SetFileTypeIndex*(self: ptr IFileDialog, iFileType: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFileTypeIndex(self, iFileType)
proc GetFileTypeIndex*(self: ptr IFileDialog, piFileType: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFileTypeIndex(self, piFileType)
proc Advise*(self: ptr IFileDialog, pfde: ptr IFileDialogEvents, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, pfde, pdwCookie)
proc Unadvise*(self: ptr IFileDialog, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwCookie)
proc SetOptions*(self: ptr IFileDialog, fos: FILEOPENDIALOGOPTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOptions(self, fos)
proc GetOptions*(self: ptr IFileDialog, pfos: ptr FILEOPENDIALOGOPTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOptions(self, pfos)
proc SetDefaultFolder*(self: ptr IFileDialog, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDefaultFolder(self, psi)
proc SetFolder*(self: ptr IFileDialog, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolder(self, psi)
proc GetFolder*(self: ptr IFileDialog, ppsi: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolder(self, ppsi)
proc GetCurrentSelection*(self: ptr IFileDialog, ppsi: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentSelection(self, ppsi)
proc SetFileName*(self: ptr IFileDialog, pszName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFileName(self, pszName)
proc GetFileName*(self: ptr IFileDialog, pszName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFileName(self, pszName)
proc SetTitle*(self: ptr IFileDialog, pszTitle: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTitle(self, pszTitle)
proc SetOkButtonLabel*(self: ptr IFileDialog, pszText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOkButtonLabel(self, pszText)
proc SetFileNameLabel*(self: ptr IFileDialog, pszLabel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFileNameLabel(self, pszLabel)
proc GetResult*(self: ptr IFileDialog, ppsi: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetResult(self, ppsi)
proc AddPlace*(self: ptr IFileDialog, psi: ptr IShellItem, fdap: FDAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPlace(self, psi, fdap)
proc SetDefaultExtension*(self: ptr IFileDialog, pszDefaultExtension: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDefaultExtension(self, pszDefaultExtension)
proc Close*(self: ptr IFileDialog, hr: HRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Close(self, hr)
proc SetClientGuid*(self: ptr IFileDialog, guid: REFGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetClientGuid(self, guid)
proc ClearClientData*(self: ptr IFileDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearClientData(self)
proc SetFilter*(self: ptr IFileDialog, pFilter: ptr IShellItemFilter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFilter(self, pFilter)
proc SetSaveAsItem*(self: ptr IFileSaveDialog, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSaveAsItem(self, psi)
proc SetProperties*(self: ptr IFileSaveDialog, pStore: ptr IPropertyStore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProperties(self, pStore)
proc SetCollectedProperties*(self: ptr IFileSaveDialog, pList: ptr IPropertyDescriptionList, fAppendDefault: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCollectedProperties(self, pList, fAppendDefault)
proc GetProperties*(self: ptr IFileSaveDialog, ppStore: ptr ptr IPropertyStore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperties(self, ppStore)
proc ApplyProperties*(self: ptr IFileSaveDialog, psi: ptr IShellItem, pStore: ptr IPropertyStore, hwnd: HWND, pSink: ptr IFileOperationProgressSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplyProperties(self, psi, pStore, hwnd, pSink)
proc GetResults*(self: ptr IFileOpenDialog, ppenum: ptr ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetResults(self, ppenum)
proc GetSelectedItems*(self: ptr IFileOpenDialog, ppsai: ptr ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelectedItems(self, ppsai)
proc EnableOpenDropDown*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableOpenDropDown(self, dwIDCtl)
proc AddMenu*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddMenu(self, dwIDCtl, pszLabel)
proc AddPushButton*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPushButton(self, dwIDCtl, pszLabel)
proc AddComboBox*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddComboBox(self, dwIDCtl)
proc AddRadioButtonList*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddRadioButtonList(self, dwIDCtl)
proc AddCheckButton*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR, bChecked: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddCheckButton(self, dwIDCtl, pszLabel, bChecked)
proc AddEditBox*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddEditBox(self, dwIDCtl, pszText)
proc AddSeparator*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddSeparator(self, dwIDCtl)
proc AddText*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddText(self, dwIDCtl, pszText)
proc SetControlLabel*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetControlLabel(self, dwIDCtl, pszLabel)
proc GetControlState*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pdwState: ptr CDCONTROLSTATEF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetControlState(self, dwIDCtl, pdwState)
proc SetControlState*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwState: CDCONTROLSTATEF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetControlState(self, dwIDCtl, dwState)
proc GetEditBoxText*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, ppszText: ptr ptr WCHAR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEditBoxText(self, dwIDCtl, ppszText)
proc SetEditBoxText*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetEditBoxText(self, dwIDCtl, pszText)
proc GetCheckButtonState*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pbChecked: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCheckButtonState(self, dwIDCtl, pbChecked)
proc SetCheckButtonState*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, bChecked: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCheckButtonState(self, dwIDCtl, bChecked)
proc AddControlItem*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD, pszLabel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddControlItem(self, dwIDCtl, dwIDItem, pszLabel)
proc RemoveControlItem*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveControlItem(self, dwIDCtl, dwIDItem)
proc RemoveAllControlItems*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveAllControlItems(self, dwIDCtl)
proc GetControlItemState*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD, pdwState: ptr CDCONTROLSTATEF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetControlItemState(self, dwIDCtl, dwIDItem, pdwState)
proc SetControlItemState*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD, dwState: CDCONTROLSTATEF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetControlItemState(self, dwIDCtl, dwIDItem, dwState)
proc GetSelectedControlItem*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pdwIDItem: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelectedControlItem(self, dwIDCtl, pdwIDItem)
proc SetSelectedControlItem*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSelectedControlItem(self, dwIDCtl, dwIDItem)
proc StartVisualGroup*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, pszLabel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartVisualGroup(self, dwIDCtl, pszLabel)
proc EndVisualGroup*(self: ptr IFileDialogCustomize): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndVisualGroup(self)
proc MakeProminent*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MakeProminent(self, dwIDCtl)
proc SetControlItemText*(self: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD, pszLabel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetControlItemText(self, dwIDCtl, dwIDItem, pszLabel)
proc OnItemSelected*(self: ptr IFileDialogControlEvents, pfdc: ptr IFileDialogCustomize, dwIDCtl: DWORD, dwIDItem: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnItemSelected(self, pfdc, dwIDCtl, dwIDItem)
proc OnButtonClicked*(self: ptr IFileDialogControlEvents, pfdc: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnButtonClicked(self, pfdc, dwIDCtl)
proc OnCheckButtonToggled*(self: ptr IFileDialogControlEvents, pfdc: ptr IFileDialogCustomize, dwIDCtl: DWORD, bChecked: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnCheckButtonToggled(self, pfdc, dwIDCtl, bChecked)
proc OnControlActivating*(self: ptr IFileDialogControlEvents, pfdc: ptr IFileDialogCustomize, dwIDCtl: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnControlActivating(self, pfdc, dwIDCtl)
proc SetCancelButtonLabel*(self: ptr IFileDialog2, pszLabel: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCancelButtonLabel(self, pszLabel)
proc SetNavigationRoot*(self: ptr IFileDialog2, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetNavigationRoot(self, psi)
proc QueryCurrentDefault*(self: ptr IApplicationAssociationRegistration, pszQuery: LPCWSTR, atQueryType: ASSOCIATIONTYPE, alQueryLevel: ASSOCIATIONLEVEL, ppszAssociation: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryCurrentDefault(self, pszQuery, atQueryType, alQueryLevel, ppszAssociation)
proc QueryAppIsDefault*(self: ptr IApplicationAssociationRegistration, pszQuery: LPCWSTR, atQueryType: ASSOCIATIONTYPE, alQueryLevel: ASSOCIATIONLEVEL, pszAppRegistryName: LPCWSTR, pfDefault: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryAppIsDefault(self, pszQuery, atQueryType, alQueryLevel, pszAppRegistryName, pfDefault)
proc QueryAppIsDefaultAll*(self: ptr IApplicationAssociationRegistration, alQueryLevel: ASSOCIATIONLEVEL, pszAppRegistryName: LPCWSTR, pfDefault: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryAppIsDefaultAll(self, alQueryLevel, pszAppRegistryName, pfDefault)
proc SetAppAsDefault*(self: ptr IApplicationAssociationRegistration, pszAppRegistryName: LPCWSTR, pszSet: LPCWSTR, atSetType: ASSOCIATIONTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppAsDefault(self, pszAppRegistryName, pszSet, atSetType)
proc SetAppAsDefaultAll*(self: ptr IApplicationAssociationRegistration, pszAppRegistryName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppAsDefaultAll(self, pszAppRegistryName)
proc ClearUserAssociations*(self: ptr IApplicationAssociationRegistration): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearUserAssociations(self)
proc LaunchAdvancedAssociationUI*(self: ptr IApplicationAssociationRegistrationUI, pszAppRegistryName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LaunchAdvancedAssociationUI(self, pszAppRegistryName)
proc SetItemAlloc*(self: ptr IDelegateFolder, pmalloc: ptr IMalloc): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetItemAlloc(self, pmalloc)
proc GetFrameOptions*(self: ptr IBrowserFrameOptions, dwMask: BROWSERFRAMEOPTIONS, pdwOptions: ptr BROWSERFRAMEOPTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFrameOptions(self, dwMask, pdwOptions)
proc EvaluateNewWindow*(self: ptr INewWindowManager, pszUrl: LPCWSTR, pszName: LPCWSTR, pszUrlContext: LPCWSTR, pszFeatures: LPCWSTR, fReplace: WINBOOL, dwFlags: DWORD, dwUserActionTime: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EvaluateNewWindow(self, pszUrl, pszName, pszUrlContext, pszFeatures, fReplace, dwFlags, dwUserActionTime)
proc SetClientTitle*(self: ptr IAttachmentExecute, pszTitle: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetClientTitle(self, pszTitle)
proc SetClientGuid*(self: ptr IAttachmentExecute, guid: REFGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetClientGuid(self, guid)
proc SetLocalPath*(self: ptr IAttachmentExecute, pszLocalPath: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLocalPath(self, pszLocalPath)
proc SetFileName*(self: ptr IAttachmentExecute, pszFileName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFileName(self, pszFileName)
proc SetSource*(self: ptr IAttachmentExecute, pszSource: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSource(self, pszSource)
proc SetReferrer*(self: ptr IAttachmentExecute, pszReferrer: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetReferrer(self, pszReferrer)
proc CheckPolicy*(self: ptr IAttachmentExecute): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CheckPolicy(self)
proc Prompt*(self: ptr IAttachmentExecute, hwnd: HWND, prompt: ATTACHMENT_PROMPT, paction: ptr ATTACHMENT_ACTION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Prompt(self, hwnd, prompt, paction)
proc Save*(self: ptr IAttachmentExecute): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self)
proc Execute*(self: ptr IAttachmentExecute, hwnd: HWND, pszVerb: LPCWSTR, phProcess: ptr HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Execute(self, hwnd, pszVerb, phProcess)
proc SaveWithUI*(self: ptr IAttachmentExecute, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveWithUI(self, hwnd)
proc ClearClientState*(self: ptr IAttachmentExecute): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearClientState(self)
proc CallbackSM*(self: ptr IShellMenuCallback, psmd: LPSMDATA, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CallbackSM(self, psmd, uMsg, wParam, lParam)
proc Initialize*(self: ptr IShellMenu, psmc: ptr IShellMenuCallback, uId: UINT, uIdAncestor: UINT, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, psmc, uId, uIdAncestor, dwFlags)
proc GetMenuInfo*(self: ptr IShellMenu, ppsmc: ptr ptr IShellMenuCallback, puId: ptr UINT, puIdAncestor: ptr UINT, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMenuInfo(self, ppsmc, puId, puIdAncestor, pdwFlags)
proc SetShellFolder*(self: ptr IShellMenu, psf: ptr IShellFolder, pidlFolder: PCIDLIST_ABSOLUTE, hKey: HKEY, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetShellFolder(self, psf, pidlFolder, hKey, dwFlags)
proc GetShellFolder*(self: ptr IShellMenu, pdwFlags: ptr DWORD, ppidl: ptr PIDLIST_ABSOLUTE, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetShellFolder(self, pdwFlags, ppidl, riid, ppv)
proc SetMenu*(self: ptr IShellMenu, hmenu: HMENU, hwnd: HWND, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMenu(self, hmenu, hwnd, dwFlags)
proc GetMenu*(self: ptr IShellMenu, phmenu: ptr HMENU, phwnd: ptr HWND, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMenu(self, phmenu, phwnd, pdwFlags)
proc InvalidateItem*(self: ptr IShellMenu, psmd: LPSMDATA, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvalidateItem(self, psmd, dwFlags)
proc GetState*(self: ptr IShellMenu, psmd: LPSMDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetState(self, psmd)
proc SetMenuToolbar*(self: ptr IShellMenu, punk: ptr IUnknown, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMenuToolbar(self, punk, dwFlags)
proc Run*(self: ptr IShellRunDll, pszArgs: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Run(self, pszArgs)
proc GetId*(self: ptr IKnownFolder, pkfid: ptr KNOWNFOLDERID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetId(self, pkfid)
proc GetCategory*(self: ptr IKnownFolder, pCategory: ptr KF_CATEGORY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCategory(self, pCategory)
proc GetShellItem*(self: ptr IKnownFolder, dwFlags: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetShellItem(self, dwFlags, riid, ppv)
proc GetPath*(self: ptr IKnownFolder, dwFlags: DWORD, ppszPath: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPath(self, dwFlags, ppszPath)
proc SetPath*(self: ptr IKnownFolder, dwFlags: DWORD, pszPath: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPath(self, dwFlags, pszPath)
proc GetIDList*(self: ptr IKnownFolder, dwFlags: DWORD, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDList(self, dwFlags, ppidl)
proc GetFolderType*(self: ptr IKnownFolder, pftid: ptr FOLDERTYPEID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderType(self, pftid)
proc GetRedirectionCapabilities*(self: ptr IKnownFolder, pCapabilities: ptr KF_REDIRECTION_CAPABILITIES): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRedirectionCapabilities(self, pCapabilities)
proc GetFolderDefinition*(self: ptr IKnownFolder, pKFD: ptr KNOWNFOLDER_DEFINITION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderDefinition(self, pKFD)
proc FolderIdFromCsidl*(self: ptr IKnownFolderManager, nCsidl: int32, pfid: ptr KNOWNFOLDERID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FolderIdFromCsidl(self, nCsidl, pfid)
proc FolderIdToCsidl*(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID, pnCsidl: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FolderIdToCsidl(self, rfid, pnCsidl)
proc GetFolderIds*(self: ptr IKnownFolderManager, ppKFId: ptr ptr KNOWNFOLDERID, pCount: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderIds(self, ppKFId, pCount)
proc GetFolder*(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID, ppkf: ptr ptr IKnownFolder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolder(self, rfid, ppkf)
proc GetFolderByName*(self: ptr IKnownFolderManager, pszCanonicalName: LPCWSTR, ppkf: ptr ptr IKnownFolder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderByName(self, pszCanonicalName, ppkf)
proc RegisterFolder*(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID, pKFD: ptr KNOWNFOLDER_DEFINITION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterFolder(self, rfid, pKFD)
proc UnregisterFolder*(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterFolder(self, rfid)
proc FindFolderFromPath*(self: ptr IKnownFolderManager, pszPath: LPCWSTR, mode: FFFP_MODE, ppkf: ptr ptr IKnownFolder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindFolderFromPath(self, pszPath, mode, ppkf)
proc FindFolderFromIDList*(self: ptr IKnownFolderManager, pidl: PCIDLIST_ABSOLUTE, ppkf: ptr ptr IKnownFolder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindFolderFromIDList(self, pidl, ppkf)
proc Redirect*(self: ptr IKnownFolderManager, rfid: REFKNOWNFOLDERID, hwnd: HWND, flags: KF_REDIRECT_FLAGS, pszTargetPath: LPCWSTR, cFolders: UINT, pExclusion: ptr KNOWNFOLDERID, ppszError: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Redirect(self, rfid, hwnd, flags, pszTargetPath, cFolders, pExclusion, ppszError)
proc CreateShare*(self: ptr ISharingConfigurationManager, dsid: DEF_SHARE_ID, role: SHARE_ROLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateShare(self, dsid, role)
proc DeleteShare*(self: ptr ISharingConfigurationManager, dsid: DEF_SHARE_ID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteShare(self, dsid)
proc ShareExists*(self: ptr ISharingConfigurationManager, dsid: DEF_SHARE_ID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShareExists(self, dsid)
proc GetSharePermissions*(self: ptr ISharingConfigurationManager, dsid: DEF_SHARE_ID, pRole: ptr SHARE_ROLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSharePermissions(self, dsid, pRole)
proc SharePrinters*(self: ptr ISharingConfigurationManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SharePrinters(self)
proc StopSharingPrinters*(self: ptr ISharingConfigurationManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StopSharingPrinters(self)
proc ArePrintersShared*(self: ptr ISharingConfigurationManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ArePrintersShared(self)
proc AreSnapshotsAvailable*(self: ptr IPreviousVersionsInfo, pszPath: LPCWSTR, fOkToBeSlow: WINBOOL, pfAvailable: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AreSnapshotsAvailable(self, pszPath, fOkToBeSlow, pfAvailable)
proc GetItemIDList*(self: ptr IRelatedItem, ppidl: ptr PIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemIDList(self, ppidl)
proc GetItem*(self: ptr IRelatedItem, ppsi: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItem(self, ppsi)
proc GetDestinationStream*(self: ptr IDestinationStreamFactory, ppstm: ptr ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDestinationStream(self, ppstm)
proc IncludeItems*(self: ptr INewMenuClient, pflags: ptr NMCII_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IncludeItems(self, pflags)
proc SelectAndEditItem*(self: ptr INewMenuClient, pidlItem: PCIDLIST_ABSOLUTE, flags: NMCSAEI_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectAndEditItem(self, pidlItem, flags)
proc Initialize*(self: ptr IInitializeWithBindCtx, pbc: ptr IBindCtx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pbc)
proc IncludeItem*(self: ptr IShellItemFilter, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IncludeItem(self, psi)
proc GetEnumFlagsForItem*(self: ptr IShellItemFilter, psi: ptr IShellItem, pgrfFlags: ptr SHCONTF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnumFlagsForItem(self, psi, pgrfFlags)
proc Initialize*(self: ptr INameSpaceTreeControl, hwndParent: HWND, prc: ptr RECT, nsctsFlags: NSTCSTYLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, hwndParent, prc, nsctsFlags)
proc TreeAdvise*(self: ptr INameSpaceTreeControl, punk: ptr IUnknown, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TreeAdvise(self, punk, pdwCookie)
proc TreeUnadvise*(self: ptr INameSpaceTreeControl, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TreeUnadvise(self, dwCookie)
proc AppendRoot*(self: ptr INameSpaceTreeControl, psiRoot: ptr IShellItem, grfEnumFlags: SHCONTF, grfRootStyle: NSTCROOTSTYLE, pif: ptr IShellItemFilter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AppendRoot(self, psiRoot, grfEnumFlags, grfRootStyle, pif)
proc InsertRoot*(self: ptr INameSpaceTreeControl, iIndex: int32, psiRoot: ptr IShellItem, grfEnumFlags: SHCONTF, grfRootStyle: NSTCROOTSTYLE, pif: ptr IShellItemFilter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InsertRoot(self, iIndex, psiRoot, grfEnumFlags, grfRootStyle, pif)
proc RemoveRoot*(self: ptr INameSpaceTreeControl, psiRoot: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveRoot(self, psiRoot)
proc RemoveAllRoots*(self: ptr INameSpaceTreeControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveAllRoots(self)
proc GetRootItems*(self: ptr INameSpaceTreeControl, ppsiaRootItems: ptr ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRootItems(self, ppsiaRootItems)
proc SetItemState*(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, nstcisMask: NSTCITEMSTATE, nstcisFlags: NSTCITEMSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetItemState(self, psi, nstcisMask, nstcisFlags)
proc GetItemState*(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, nstcisMask: NSTCITEMSTATE, pnstcisFlags: ptr NSTCITEMSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemState(self, psi, nstcisMask, pnstcisFlags)
proc GetSelectedItems*(self: ptr INameSpaceTreeControl, psiaItems: ptr ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelectedItems(self, psiaItems)
proc GetItemCustomState*(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, piStateNumber: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemCustomState(self, psi, piStateNumber)
proc SetItemCustomState*(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, iStateNumber: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetItemCustomState(self, psi, iStateNumber)
proc EnsureItemVisible*(self: ptr INameSpaceTreeControl, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnsureItemVisible(self, psi)
proc SetTheme*(self: ptr INameSpaceTreeControl, pszTheme: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTheme(self, pszTheme)
proc GetNextItem*(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, nstcgi: NSTCGNI, ppsiNext: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNextItem(self, psi, nstcgi, ppsiNext)
proc HitTest*(self: ptr INameSpaceTreeControl, ppt: ptr POINT, ppsiOut: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HitTest(self, ppt, ppsiOut)
proc GetItemRect*(self: ptr INameSpaceTreeControl, psi: ptr IShellItem, prect: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemRect(self, psi, prect)
proc CollapseAll*(self: ptr INameSpaceTreeControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CollapseAll(self)
proc SetControlStyle*(self: ptr INameSpaceTreeControl2, nstcsMask: NSTCSTYLE, nstcsStyle: NSTCSTYLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetControlStyle(self, nstcsMask, nstcsStyle)
proc GetControlStyle*(self: ptr INameSpaceTreeControl2, nstcsMask: NSTCSTYLE, pnstcsStyle: ptr NSTCSTYLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetControlStyle(self, nstcsMask, pnstcsStyle)
proc SetControlStyle2*(self: ptr INameSpaceTreeControl2, nstcsMask: NSTCSTYLE2, nstcsStyle: NSTCSTYLE2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetControlStyle2(self, nstcsMask, nstcsStyle)
proc GetControlStyle2*(self: ptr INameSpaceTreeControl2, nstcsMask: NSTCSTYLE2, pnstcsStyle: ptr NSTCSTYLE2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetControlStyle2(self, nstcsMask, pnstcsStyle)
proc OnItemClick*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, nstceHitTest: NSTCEHITTEST, nstceClickType: NSTCECLICKTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnItemClick(self, psi, nstceHitTest, nstceClickType)
proc OnPropertyItemCommit*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnPropertyItemCommit(self, psi)
proc OnItemStateChanging*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, nstcisMask: NSTCITEMSTATE, nstcisState: NSTCITEMSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnItemStateChanging(self, psi, nstcisMask, nstcisState)
proc OnItemStateChanged*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, nstcisMask: NSTCITEMSTATE, nstcisState: NSTCITEMSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnItemStateChanged(self, psi, nstcisMask, nstcisState)
proc OnSelectionChanged*(self: ptr INameSpaceTreeControlEvents, psiaSelection: ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnSelectionChanged(self, psiaSelection)
proc OnKeyboardInput*(self: ptr INameSpaceTreeControlEvents, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnKeyboardInput(self, uMsg, wParam, lParam)
proc OnBeforeExpand*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnBeforeExpand(self, psi)
proc OnAfterExpand*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnAfterExpand(self, psi)
proc OnBeginLabelEdit*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnBeginLabelEdit(self, psi)
proc OnEndLabelEdit*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnEndLabelEdit(self, psi)
proc OnGetToolTip*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, pszTip: LPWSTR, cchTip: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnGetToolTip(self, psi, pszTip, cchTip)
proc OnBeforeItemDelete*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnBeforeItemDelete(self, psi)
proc OnItemAdded*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, fIsRoot: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnItemAdded(self, psi, fIsRoot)
proc OnItemDeleted*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, fIsRoot: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnItemDeleted(self, psi, fIsRoot)
proc OnBeforeContextMenu*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnBeforeContextMenu(self, psi, riid, ppv)
proc OnAfterContextMenu*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, pcmIn: ptr IContextMenu, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnAfterContextMenu(self, psi, pcmIn, riid, ppv)
proc OnBeforeStateImageChange*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnBeforeStateImageChange(self, psi)
proc OnGetDefaultIconIndex*(self: ptr INameSpaceTreeControlEvents, psi: ptr IShellItem, piDefaultIcon: ptr int32, piOpenIcon: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnGetDefaultIconIndex(self, psi, piDefaultIcon, piOpenIcon)
proc OnDragEnter*(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, fOutsideSource: WINBOOL, grfKeyState: DWORD, pdwEffect: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDragEnter(self, psiOver, psiaData, fOutsideSource, grfKeyState, pdwEffect)
proc OnDragOver*(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, grfKeyState: DWORD, pdwEffect: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDragOver(self, psiOver, psiaData, grfKeyState, pdwEffect)
proc OnDragPosition*(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, iNewPosition: int32, iOldPosition: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDragPosition(self, psiOver, psiaData, iNewPosition, iOldPosition)
proc OnDrop*(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, iPosition: int32, grfKeyState: DWORD, pdwEffect: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDrop(self, psiOver, psiaData, iPosition, grfKeyState, pdwEffect)
proc OnDropPosition*(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem, psiaData: ptr IShellItemArray, iNewPosition: int32, iOldPosition: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDropPosition(self, psiOver, psiaData, iNewPosition, iOldPosition)
proc OnDragLeave*(self: ptr INameSpaceTreeControlDropHandler, psiOver: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDragLeave(self, psiOver)
proc OnGetDefaultAccessibilityAction*(self: ptr INameSpaceTreeAccessible, psi: ptr IShellItem, pbstrDefaultAction: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnGetDefaultAccessibilityAction(self, psi, pbstrDefaultAction)
proc OnDoDefaultAccessibilityAction*(self: ptr INameSpaceTreeAccessible, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDoDefaultAccessibilityAction(self, psi)
proc OnGetAccessibilityRole*(self: ptr INameSpaceTreeAccessible, psi: ptr IShellItem, pvarRole: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnGetAccessibilityRole(self, psi, pvarRole)
proc PrePaint*(self: ptr INameSpaceTreeControlCustomDraw, hdc: HDC, prc: ptr RECT, plres: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PrePaint(self, hdc, prc, plres)
proc PostPaint*(self: ptr INameSpaceTreeControlCustomDraw, hdc: HDC, prc: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostPaint(self, hdc, prc)
proc ItemPrePaint*(self: ptr INameSpaceTreeControlCustomDraw, hdc: HDC, prc: ptr RECT, pnstccdItem: ptr NSTCCUSTOMDRAW, pclrText: ptr COLORREF, pclrTextBk: ptr COLORREF, plres: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ItemPrePaint(self, hdc, prc, pnstccdItem, pclrText, pclrTextBk, plres)
proc ItemPostPaint*(self: ptr INameSpaceTreeControlCustomDraw, hdc: HDC, prc: ptr RECT, pnstccdItem: ptr NSTCCUSTOMDRAW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ItemPostPaint(self, hdc, prc, pnstccdItem)
proc GetFolderCapabilities*(self: ptr INameSpaceTreeControlFolderCapabilities, nfcMask: NSTCFOLDERCAPABILITIES, pnfcValue: ptr NSTCFOLDERCAPABILITIES): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderCapabilities(self, nfcMask, pnfcValue)
proc SetWindow*(self: ptr IPreviewHandler, hwnd: HWND, prc: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWindow(self, hwnd, prc)
proc SetRect*(self: ptr IPreviewHandler, prc: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRect(self, prc)
proc DoPreview*(self: ptr IPreviewHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoPreview(self)
proc Unload*(self: ptr IPreviewHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unload(self)
proc SetFocus*(self: ptr IPreviewHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFocus(self)
proc QueryFocus*(self: ptr IPreviewHandler, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryFocus(self, phwnd)
proc TranslateAccelerator*(self: ptr IPreviewHandler, pmsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAccelerator(self, pmsg)
proc GetWindowContext*(self: ptr IPreviewHandlerFrame, pinfo: ptr PREVIEWHANDLERFRAMEINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWindowContext(self, pinfo)
proc TranslateAccelerator*(self: ptr IPreviewHandlerFrame, pmsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAccelerator(self, pmsg)
proc ShowDeskBand*(self: ptr ITrayDeskBand, clsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowDeskBand(self, clsid)
proc HideDeskBand*(self: ptr ITrayDeskBand, clsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HideDeskBand(self, clsid)
proc IsDeskBandShown*(self: ptr ITrayDeskBand, clsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDeskBandShown(self, clsid)
proc DeskBandRegistrationChanged*(self: ptr ITrayDeskBand): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeskBandRegistrationChanged(self)
proc CreateBand*(self: ptr IBandHost, rclsidBand: REFCLSID, fAvailable: WINBOOL, fVisible: WINBOOL, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBand(self, rclsidBand, fAvailable, fVisible, riid, ppv)
proc SetBandAvailability*(self: ptr IBandHost, rclsidBand: REFCLSID, fAvailable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBandAvailability(self, rclsidBand, fAvailable)
proc DestroyBand*(self: ptr IBandHost, rclsidBand: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DestroyBand(self, rclsidBand)
proc GetPaneState*(self: ptr IExplorerPaneVisibility, ep: REFEXPLORERPANE, peps: ptr EXPLORERPANESTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPaneState(self, ep, peps)
proc CallBack*(self: ptr IContextMenuCB, psf: ptr IShellFolder, hwndOwner: HWND, pdtobj: ptr IDataObject, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CallBack(self, psf, hwndOwner, pdtobj, uMsg, wParam, lParam)
proc SetFlags*(self: ptr IDefaultExtractIconInit, uFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFlags(self, uFlags)
proc SetKey*(self: ptr IDefaultExtractIconInit, hkey: HKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetKey(self, hkey)
proc SetNormalIcon*(self: ptr IDefaultExtractIconInit, pszFile: LPCWSTR, iIcon: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetNormalIcon(self, pszFile, iIcon)
proc SetOpenIcon*(self: ptr IDefaultExtractIconInit, pszFile: LPCWSTR, iIcon: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOpenIcon(self, pszFile, iIcon)
proc SetShortcutIcon*(self: ptr IDefaultExtractIconInit, pszFile: LPCWSTR, iIcon: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetShortcutIcon(self, pszFile, iIcon)
proc SetDefaultIcon*(self: ptr IDefaultExtractIconInit, pszFile: LPCWSTR, iIcon: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDefaultIcon(self, pszFile, iIcon)
proc GetTitle*(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, ppszName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTitle(self, psiItemArray, ppszName)
proc GetIcon*(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, ppszIcon: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIcon(self, psiItemArray, ppszIcon)
proc GetToolTip*(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, ppszInfotip: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetToolTip(self, psiItemArray, ppszInfotip)
proc GetCanonicalName*(self: ptr IExplorerCommand, pguidCommandName: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCanonicalName(self, pguidCommandName)
proc GetState*(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, fOkToBeSlow: WINBOOL, pCmdState: ptr EXPCMDSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetState(self, psiItemArray, fOkToBeSlow, pCmdState)
proc Invoke*(self: ptr IExplorerCommand, psiItemArray: ptr IShellItemArray, pbc: ptr IBindCtx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self, psiItemArray, pbc)
proc GetFlags*(self: ptr IExplorerCommand, pFlags: ptr EXPCMDFLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFlags(self, pFlags)
proc EnumSubCommands*(self: ptr IExplorerCommand, ppEnum: ptr ptr IEnumExplorerCommand): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumSubCommands(self, ppEnum)
proc GetState*(self: ptr IExplorerCommandState, psiItemArray: ptr IShellItemArray, fOkToBeSlow: WINBOOL, pCmdState: ptr EXPCMDSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetState(self, psiItemArray, fOkToBeSlow, pCmdState)
proc Initialize*(self: ptr IInitializeCommand, pszCommandName: LPCWSTR, ppb: ptr IPropertyBag): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pszCommandName, ppb)
proc Next*(self: ptr IEnumExplorerCommand, celt: ULONG, pUICommand: ptr ptr IExplorerCommand, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, pUICommand, pceltFetched)
proc Skip*(self: ptr IEnumExplorerCommand, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumExplorerCommand): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumExplorerCommand, ppenum: ptr ptr IEnumExplorerCommand): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc GetCommands*(self: ptr IExplorerCommandProvider, punkSite: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCommands(self, punkSite, riid, ppv)
proc GetCommand*(self: ptr IExplorerCommandProvider, rguidCommandId: REFGUID, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCommand(self, rguidCommandId, riid, ppv)
proc Initialize*(self: ptr IInitializeNetworkFolder, pidl: PCIDLIST_ABSOLUTE, pidlTarget: PCIDLIST_ABSOLUTE, uDisplayType: UINT, pszResName: LPCWSTR, pszProvider: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pidl, pidlTarget, uDisplayType, pszResName, pszProvider)
proc Open*(self: ptr IOpenControlPanel, pszName: LPCWSTR, pszPage: LPCWSTR, punkSite: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Open(self, pszName, pszPage, punkSite)
proc GetPath*(self: ptr IOpenControlPanel, pszName: LPCWSTR, pszPath: LPWSTR, cchPath: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPath(self, pszName, pszPath, cchPath)
proc GetCurrentView*(self: ptr IOpenControlPanel, pView: ptr CPVIEW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentView(self, pView)
proc ComputerInfoChanged*(self: ptr IComputerInfoChangeNotify): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ComputerInfoChanged(self)
proc SetFindData*(self: ptr IFileSystemBindData, pfd: ptr WIN32_FIND_DATAW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFindData(self, pfd)
proc GetFindData*(self: ptr IFileSystemBindData, pfd: ptr WIN32_FIND_DATAW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFindData(self, pfd)
proc SetFileID*(self: ptr IFileSystemBindData2, liFileID: LARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFileID(self, liFileID)
proc GetFileID*(self: ptr IFileSystemBindData2, pliFileID: ptr LARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFileID(self, pliFileID)
proc SetJunctionCLSID*(self: ptr IFileSystemBindData2, clsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetJunctionCLSID(self, clsid)
proc GetJunctionCLSID*(self: ptr IFileSystemBindData2, pclsid: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetJunctionCLSID(self, pclsid)
proc SetAppID*(self: ptr ICustomDestinationList, pszAppID: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppID(self, pszAppID)
proc BeginList*(self: ptr ICustomDestinationList, pcMinSlots: ptr UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginList(self, pcMinSlots, riid, ppv)
proc AppendCategory*(self: ptr ICustomDestinationList, pszCategory: LPCWSTR, poa: ptr IObjectArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AppendCategory(self, pszCategory, poa)
proc AppendKnownCategory*(self: ptr ICustomDestinationList, category: KNOWNDESTCATEGORY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AppendKnownCategory(self, category)
proc AddUserTasks*(self: ptr ICustomDestinationList, poa: ptr IObjectArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddUserTasks(self, poa)
proc CommitList*(self: ptr ICustomDestinationList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CommitList(self)
proc GetRemovedDestinations*(self: ptr ICustomDestinationList, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRemovedDestinations(self, riid, ppv)
proc DeleteList*(self: ptr ICustomDestinationList, pszAppID: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteList(self, pszAppID)
proc AbortList*(self: ptr ICustomDestinationList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AbortList(self)
proc SetAppID*(self: ptr IApplicationDestinations, pszAppID: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppID(self, pszAppID)
proc RemoveDestination*(self: ptr IApplicationDestinations, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveDestination(self, punk)
proc RemoveAllDestinations*(self: ptr IApplicationDestinations): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveAllDestinations(self)
proc SetAppID*(self: ptr IApplicationDocumentLists, pszAppID: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppID(self, pszAppID)
proc GetList*(self: ptr IApplicationDocumentLists, listtype: APPDOCLISTTYPE, cItemsDesired: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetList(self, listtype, cItemsDesired, riid, ppv)
proc SetAppID*(self: ptr IObjectWithAppUserModelID, pszAppID: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppID(self, pszAppID)
proc GetAppID*(self: ptr IObjectWithAppUserModelID, ppszAppID: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAppID(self, ppszAppID)
proc SetProgID*(self: ptr IObjectWithProgID, pszProgID: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProgID(self, pszProgID)
proc GetProgID*(self: ptr IObjectWithProgID, ppszProgID: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProgID(self, ppszProgID)
proc Update*(self: ptr IUpdateIDList, pbc: ptr IBindCtx, pidlIn: PCUITEMID_CHILD, ppidlOut: ptr PITEMID_CHILD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Update(self, pbc, pidlIn, ppidlOut)
proc RunGadget*(self: ptr IDesktopGadget, gadgetPath: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RunGadget(self, gadgetPath)
proc SetWallpaper*(self: ptr IDesktopWallpaper, monitorID: LPCWSTR, wallpaper: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWallpaper(self, monitorID, wallpaper)
proc GetWallpaper*(self: ptr IDesktopWallpaper, monitorID: LPCWSTR, wallpaper: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWallpaper(self, monitorID, wallpaper)
proc GetMonitorDevicePathAt*(self: ptr IDesktopWallpaper, monitorIndex: UINT, monitorID: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMonitorDevicePathAt(self, monitorIndex, monitorID)
proc GetMonitorDevicePathCount*(self: ptr IDesktopWallpaper, count: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMonitorDevicePathCount(self, count)
proc GetMonitorRECT*(self: ptr IDesktopWallpaper, monitorID: LPCWSTR, displayRect: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMonitorRECT(self, monitorID, displayRect)
proc mSetBackgroundColor*(self: ptr IDesktopWallpaper, color: COLORREF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBackgroundColor(self, color)
proc GetBackgroundColor*(self: ptr IDesktopWallpaper, color: ptr COLORREF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBackgroundColor(self, color)
proc SetPosition*(self: ptr IDesktopWallpaper, position: DESKTOP_WALLPAPER_POSITION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPosition(self, position)
proc GetPosition*(self: ptr IDesktopWallpaper, position: ptr DESKTOP_WALLPAPER_POSITION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPosition(self, position)
proc SetSlideshow*(self: ptr IDesktopWallpaper, items: ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSlideshow(self, items)
proc GetSlideshow*(self: ptr IDesktopWallpaper, items: ptr ptr IShellItemArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSlideshow(self, items)
proc SetSlideshowOptions*(self: ptr IDesktopWallpaper, options: DESKTOP_SLIDESHOW_OPTIONS, slideshowTick: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSlideshowOptions(self, options, slideshowTick)
proc GetSlideshowOptions*(self: ptr IDesktopWallpaper, options: ptr DESKTOP_SLIDESHOW_OPTIONS, slideshowTick: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSlideshowOptions(self, options, slideshowTick)
proc AdvanceSlideshow*(self: ptr IDesktopWallpaper, monitorID: LPCWSTR, direction: DESKTOP_SLIDESHOW_DIRECTION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AdvanceSlideshow(self, monitorID, direction)
proc GetStatus*(self: ptr IDesktopWallpaper, state: ptr DESKTOP_SLIDESHOW_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStatus(self, state)
proc Enable*(self: ptr IDesktopWallpaper, enable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Enable(self, enable)
proc IsMember*(self: ptr IHomeGroup, member: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsMember(self, member)
proc ShowSharingWizard*(self: ptr IHomeGroup, owner: HWND, sharingchoices: ptr HOMEGROUPSHARINGCHOICES): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowSharingWizard(self, owner, sharingchoices)
proc Initialize*(self: ptr IInitializeWithPropertyStore, pps: ptr IPropertyStore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pps)
proc GetResults*(self: ptr IOpenSearchSource, hwnd: HWND, pszQuery: LPCWSTR, dwStartIndex: DWORD, dwCount: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetResults(self, hwnd, pszQuery, dwStartIndex, dwCount, riid, ppv)
proc LoadLibraryFromItem*(self: ptr IShellLibrary, psiLibrary: ptr IShellItem, grfMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadLibraryFromItem(self, psiLibrary, grfMode)
proc LoadLibraryFromKnownFolder*(self: ptr IShellLibrary, kfidLibrary: REFKNOWNFOLDERID, grfMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadLibraryFromKnownFolder(self, kfidLibrary, grfMode)
proc AddFolder*(self: ptr IShellLibrary, psiLocation: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddFolder(self, psiLocation)
proc RemoveFolder*(self: ptr IShellLibrary, psiLocation: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveFolder(self, psiLocation)
proc GetFolders*(self: ptr IShellLibrary, lff: LIBRARYFOLDERFILTER, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolders(self, lff, riid, ppv)
proc ResolveFolder*(self: ptr IShellLibrary, psiFolderToResolve: ptr IShellItem, dwTimeout: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResolveFolder(self, psiFolderToResolve, dwTimeout, riid, ppv)
proc GetDefaultSaveFolder*(self: ptr IShellLibrary, dsft: DEFAULTSAVEFOLDERTYPE, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultSaveFolder(self, dsft, riid, ppv)
proc SetDefaultSaveFolder*(self: ptr IShellLibrary, dsft: DEFAULTSAVEFOLDERTYPE, psi: ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDefaultSaveFolder(self, dsft, psi)
proc GetOptions*(self: ptr IShellLibrary, plofOptions: ptr LIBRARYOPTIONFLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOptions(self, plofOptions)
proc SetOptions*(self: ptr IShellLibrary, lofMask: LIBRARYOPTIONFLAGS, lofOptions: LIBRARYOPTIONFLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOptions(self, lofMask, lofOptions)
proc GetFolderType*(self: ptr IShellLibrary, pftid: ptr FOLDERTYPEID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolderType(self, pftid)
proc SetFolderType*(self: ptr IShellLibrary, ftid: REFFOLDERTYPEID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolderType(self, ftid)
proc GetIcon*(self: ptr IShellLibrary, ppszIcon: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIcon(self, ppszIcon)
proc SetIcon*(self: ptr IShellLibrary, pszIcon: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIcon(self, pszIcon)
proc Commit*(self: ptr IShellLibrary): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self)
proc Save*(self: ptr IShellLibrary, psiFolderToSaveIn: ptr IShellItem, pszLibraryName: LPCWSTR, lsf: LIBRARYSAVEFLAGS, ppsiSavedTo: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, psiFolderToSaveIn, pszLibraryName, lsf, ppsiSavedTo)
proc SaveInKnownFolder*(self: ptr IShellLibrary, kfidToSaveIn: REFKNOWNFOLDERID, pszLibraryName: LPCWSTR, lsf: LIBRARYSAVEFLAGS, ppsiSavedTo: ptr ptr IShellItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveInKnownFolder(self, kfidToSaveIn, pszLibraryName, lsf, ppsiSavedTo)
proc OnPlaybackManagerEvent*(self: ptr IPlaybackManagerEvents, dwSessionId: DWORD, mediaEvent: PBM_EVENT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnPlaybackManagerEvent(self, dwSessionId, mediaEvent)
proc Advise*(self: ptr IPlaybackManager, `type`: PBM_SESSION_TYPE, pEvents: ptr IPlaybackManagerEvents, pdwSessionId: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, `type`, pEvents, pdwSessionId)
proc Unadvise*(self: ptr IPlaybackManager, dwSessionId: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwSessionId)
proc ChangeSessionState*(self: ptr IPlaybackManager, dwSessionId: DWORD, state: PBM_PLAY_STATE, mute: PBM_MUTE_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ChangeSessionState(self, dwSessionId, state, mute)
proc Initialize*(self: ptr IDefaultFolderMenuInitialize, hwnd: HWND, pcmcb: ptr IContextMenuCB, pidlFolder: PCIDLIST_ABSOLUTE, psf: ptr IShellFolder, cidl: UINT, apidl: PCUITEMID_CHILD_ARRAY, punkAssociation: ptr IUnknown, cKeys: UINT, aKeys: ptr HKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, hwnd, pcmcb, pidlFolder, psf, cidl, apidl, punkAssociation, cKeys, aKeys)
proc SetMenuRestrictions*(self: ptr IDefaultFolderMenuInitialize, dfmrValues: DEFAULT_FOLDER_MENU_RESTRICTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMenuRestrictions(self, dfmrValues)
proc GetMenuRestrictions*(self: ptr IDefaultFolderMenuInitialize, dfmrMask: DEFAULT_FOLDER_MENU_RESTRICTIONS, pdfmrValues: ptr DEFAULT_FOLDER_MENU_RESTRICTIONS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMenuRestrictions(self, dfmrMask, pdfmrValues)
proc SetHandlerClsid*(self: ptr IDefaultFolderMenuInitialize, rclsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHandlerClsid(self, rclsid)
proc ActivateApplication*(self: ptr IApplicationActivationManager, appUserModelId: LPCWSTR, arguments: LPCWSTR, options: ACTIVATEOPTIONS, processId: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ActivateApplication(self, appUserModelId, arguments, options, processId)
proc ActivateForFile*(self: ptr IApplicationActivationManager, appUserModelId: LPCWSTR, itemArray: ptr IShellItemArray, verb: LPCWSTR, processId: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ActivateForFile(self, appUserModelId, itemArray, verb, processId)
proc ActivateForProtocol*(self: ptr IApplicationActivationManager, appUserModelId: LPCWSTR, itemArray: ptr IShellItemArray, processId: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ActivateForProtocol(self, appUserModelId, itemArray, processId)
proc SupportsSelection*(self: ptr IAssocHandlerInvoker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SupportsSelection(self)
proc Invoke*(self: ptr IAssocHandlerInvoker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self)
proc GetName*(self: ptr IAssocHandler, ppsz: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetName(self, ppsz)
proc GetUIName*(self: ptr IAssocHandler, ppsz: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUIName(self, ppsz)
proc GetIconLocation*(self: ptr IAssocHandler, ppszPath: ptr LPWSTR, pIndex: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconLocation(self, ppszPath, pIndex)
proc IsRecommended*(self: ptr IAssocHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsRecommended(self)
proc MakeDefault*(self: ptr IAssocHandler, pszDescription: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MakeDefault(self, pszDescription)
proc Invoke*(self: ptr IAssocHandler, pdo: ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self, pdo)
proc CreateInvoker*(self: ptr IAssocHandler, pdo: ptr IDataObject, ppInvoker: ptr ptr IAssocHandlerInvoker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInvoker(self, pdo, ppInvoker)
proc Next*(self: ptr IEnumAssocHandlers, celt: ULONG, rgelt: ptr ptr IAssocHandler, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc GetDataObject*(self: ptr IDataObjectProvider, dataObject: ptr ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDataObject(self, dataObject)
proc SetDataObject*(self: ptr IDataObjectProvider, dataObject: ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDataObject(self, dataObject)
proc GetForWindow*(self: ptr IDataTransferManagerInterop, appWindow: HWND, riid: REFIID, dataTransferManager: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetForWindow(self, appWindow, riid, dataTransferManager)
proc ShowShareUIForWindow*(self: ptr IDataTransferManagerInterop, appWindow: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowShareUIForWindow(self, appWindow)
proc Showing*(self: ptr IFrameworkInputPaneHandler, prcInputPaneScreenLocation: ptr RECT, fEnsureFocusedElementInView: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Showing(self, prcInputPaneScreenLocation, fEnsureFocusedElementInView)
proc Hiding*(self: ptr IFrameworkInputPaneHandler, fEnsureFocusedElementInView: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Hiding(self, fEnsureFocusedElementInView)
proc Advise*(self: ptr IFrameworkInputPane, pWindow: ptr IUnknown, pHandler: ptr IFrameworkInputPaneHandler, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, pWindow, pHandler, pdwCookie)
proc AdviseWithHWND*(self: ptr IFrameworkInputPane, hwnd: HWND, pHandler: ptr IFrameworkInputPaneHandler, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AdviseWithHWND(self, hwnd, pHandler, pdwCookie)
proc Unadvise*(self: ptr IFrameworkInputPane, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwCookie)
proc Location*(self: ptr IFrameworkInputPane, prcInputPaneScreenLocation: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Location(self, prcInputPaneScreenLocation)
proc GetSearchWindow*(self: ptr ISearchableApplication, hwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSearchWindow(self, hwnd)
proc Undocked*(self: ptr IAccessibilityDockingServiceCallback, undockReason: UNDOCK_REASON): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Undocked(self, undockReason)
proc GetAvailableSize*(self: ptr IAccessibilityDockingService, hMonitor: HMONITOR, pcxFixed: ptr UINT, pcyMax: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAvailableSize(self, hMonitor, pcxFixed, pcyMax)
proc DockWindow*(self: ptr IAccessibilityDockingService, hwnd: HWND, hMonitor: HMONITOR, cyRequested: UINT, pCallback: ptr IAccessibilityDockingServiceCallback): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DockWindow(self, hwnd, hMonitor, cyRequested, pCallback)
proc UndockWindow*(self: ptr IAccessibilityDockingService, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UndockWindow(self, hwnd)
proc AppVisibilityOnMonitorChanged*(self: ptr IAppVisibilityEvents, hMonitor: HMONITOR, previousMode: MONITOR_APP_VISIBILITY, currentMode: MONITOR_APP_VISIBILITY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AppVisibilityOnMonitorChanged(self, hMonitor, previousMode, currentMode)
proc LauncherVisibilityChange*(self: ptr IAppVisibilityEvents, currentVisibleState: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LauncherVisibilityChange(self, currentVisibleState)
proc GetAppVisibilityOnMonitor*(self: ptr IAppVisibility, hMonitor: HMONITOR, pMode: ptr MONITOR_APP_VISIBILITY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAppVisibilityOnMonitor(self, hMonitor, pMode)
proc IsLauncherVisible*(self: ptr IAppVisibility, pfVisible: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsLauncherVisible(self, pfVisible)
proc Advise*(self: ptr IAppVisibility, pCallback: ptr IAppVisibilityEvents, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, pCallback, pdwCookie)
proc Unadvise*(self: ptr IAppVisibility, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwCookie)
proc OnStateChanged*(self: ptr IPackageExecutionStateChangeNotification, pszPackageFullName: LPCWSTR, pesNewState: PACKAGE_EXECUTION_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnStateChanged(self, pszPackageFullName, pesNewState)
proc EnableDebugging*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, debuggerCommandLine: LPCWSTR, environment: PZZWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableDebugging(self, packageFullName, debuggerCommandLine, environment)
proc DisableDebugging*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DisableDebugging(self, packageFullName)
proc Suspend*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Suspend(self, packageFullName)
proc Resume*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resume(self, packageFullName)
proc TerminateAllProcesses*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TerminateAllProcesses(self, packageFullName)
proc SetTargetSessionId*(self: ptr IPackageDebugSettings, sessionId: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTargetSessionId(self, sessionId)
proc EnumerateBackgroundTasks*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, taskCount: ptr ULONG, taskIds: ptr LPCGUID, taskNames: ptr ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumerateBackgroundTasks(self, packageFullName, taskCount, taskIds, taskNames)
proc ActivateBackgroundTask*(self: ptr IPackageDebugSettings, taskId: LPCGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ActivateBackgroundTask(self, taskId)
proc StartServicing*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartServicing(self, packageFullName)
proc StopServicing*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StopServicing(self, packageFullName)
proc StartSessionRedirection*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, sessionId: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartSessionRedirection(self, packageFullName, sessionId)
proc StopSessionRedirection*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StopSessionRedirection(self, packageFullName)
proc GetPackageExecutionState*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, packageExecutionState: ptr PACKAGE_EXECUTION_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPackageExecutionState(self, packageFullName, packageExecutionState)
proc RegisterForPackageStateChanges*(self: ptr IPackageDebugSettings, packageFullName: LPCWSTR, pPackageExecutionStateChangeNotification: ptr IPackageExecutionStateChangeNotification, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterForPackageStateChanges(self, packageFullName, pPackageExecutionStateChangeNotification, pdwCookie)
proc UnregisterForPackageStateChanges*(self: ptr IPackageDebugSettings, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterForPackageStateChanges(self, dwCookie)
proc GetValue*(self: ptr IExecuteCommandApplicationHostEnvironment, pahe: ptr AHE_TYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetValue(self, pahe)
proc GetUIMode*(self: ptr IExecuteCommandHost, pUIMode: ptr EC_HOST_UI_MODE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUIMode(self, pUIMode)
proc SetNativeDisplaySize*(self: ptr IApplicationDesignModeSettings, sizeNativeDisplay: SIZE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetNativeDisplaySize(self, sizeNativeDisplay)
proc SetScaleFactor*(self: ptr IApplicationDesignModeSettings, scaleFactor: DEVICE_SCALE_FACTOR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetScaleFactor(self, scaleFactor)
proc SetApplicationViewState*(self: ptr IApplicationDesignModeSettings, viewState: APPLICATION_VIEW_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetApplicationViewState(self, viewState)
proc ComputeApplicationSize*(self: ptr IApplicationDesignModeSettings, psizeApplication: ptr SIZE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ComputeApplicationSize(self, psizeApplication)
proc IsApplicationViewStateSupported*(self: ptr IApplicationDesignModeSettings, viewState: APPLICATION_VIEW_STATE, sizeNativeDisplay: SIZE, scaleFactor: DEVICE_SCALE_FACTOR, pfSupported: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsApplicationViewStateSupported(self, viewState, sizeNativeDisplay, scaleFactor, pfSupported)
proc TriggerEdgeGesture*(self: ptr IApplicationDesignModeSettings, edgeGestureKind: EDGE_GESTURE_KIND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TriggerEdgeGesture(self, edgeGestureKind)
proc Initialize*(self: ptr IInitializeWithWindow, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, hwnd)
proc GetApplicationDisplayName*(self: ptr IHandlerInfo, value: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetApplicationDisplayName(self, value)
proc GetApplicationPublisher*(self: ptr IHandlerInfo, value: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetApplicationPublisher(self, value)
proc GetApplicationIconReference*(self: ptr IHandlerInfo, value: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetApplicationIconReference(self, value)
proc BeforeCoCreateInstance*(self: ptr IHandlerActivationHost, clsidHandler: REFCLSID, itemsBeingActivated: ptr IShellItemArray, handlerInfo: ptr IHandlerInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeforeCoCreateInstance(self, clsidHandler, itemsBeingActivated, handlerInfo)
proc BeforeCreateProcess*(self: ptr IHandlerActivationHost, applicationPath: LPCWSTR, commandLine: LPCWSTR, handlerInfo: ptr IHandlerInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeforeCreateProcess(self, applicationPath, commandLine, handlerInfo)
proc GetIconLocation*(self: ptr IExtractIconA, uFlags: UINT, pszIconFile: PSTR, cchMax: UINT, piIndex: ptr int32, pwFlags: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconLocation(self, uFlags, pszIconFile, cchMax, piIndex, pwFlags)
proc Extract*(self: ptr IExtractIconA, pszFile: PCSTR, nIconIndex: UINT, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIconSize: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Extract(self, pszFile, nIconIndex, phiconLarge, phiconSmall, nIconSize)
proc GetIconLocation*(self: ptr IExtractIconW, uFlags: UINT, pszIconFile: PWSTR, cchMax: UINT, piIndex: ptr int32, pwFlags: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconLocation(self, uFlags, pszIconFile, cchMax, piIndex, pwFlags)
proc Extract*(self: ptr IExtractIconW, pszFile: PCWSTR, nIconIndex: UINT, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIconSize: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Extract(self, pszFile, nIconIndex, phiconLarge, phiconSmall, nIconSize)
proc IsMemberOf*(self: ptr IShellIconOverlayIdentifier, pwszPath: PCWSTR, dwAttrib: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsMemberOf(self, pwszPath, dwAttrib)
proc GetOverlayInfo*(self: ptr IShellIconOverlayIdentifier, pwszIconFile: PWSTR, cchMax: int32, pIndex: ptr int32, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOverlayInfo(self, pwszIconFile, cchMax, pIndex, pdwFlags)
proc GetPriority*(self: ptr IShellIconOverlayIdentifier, pIPriority: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPriority(self, pIPriority)
proc GetFileOverlayInfo*(self: ptr IShellIconOverlayManager, pwszPath: PCWSTR, dwAttrib: DWORD, pIndex: ptr int32, dwflags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFileOverlayInfo(self, pwszPath, dwAttrib, pIndex, dwflags)
proc GetReservedOverlayInfo*(self: ptr IShellIconOverlayManager, pwszPath: PCWSTR, dwAttrib: DWORD, pIndex: ptr int32, dwflags: DWORD, iReservedID: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetReservedOverlayInfo(self, pwszPath, dwAttrib, pIndex, dwflags, iReservedID)
proc RefreshOverlayImages*(self: ptr IShellIconOverlayManager, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RefreshOverlayImages(self, dwFlags)
proc LoadNonloadedOverlayIdentifiers*(self: ptr IShellIconOverlayManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadNonloadedOverlayIdentifiers(self)
proc OverlayIndexFromImageIndex*(self: ptr IShellIconOverlayManager, iImage: int32, piIndex: ptr int32, fAdd: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OverlayIndexFromImageIndex(self, iImage, piIndex, fAdd)
proc GetOverlayIndex*(self: ptr IShellIconOverlay, pidl: PCUITEMID_CHILD, pIndex: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOverlayIndex(self, pidl, pIndex)
proc GetOverlayIconIndex*(self: ptr IShellIconOverlay, pidl: PCUITEMID_CHILD, pIconIndex: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOverlayIconIndex(self, pidl, pIconIndex)
proc Execute*(self: ptr IShellExecuteHookA, pei: LPSHELLEXECUTEINFOA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Execute(self, pei)
proc Execute*(self: ptr IShellExecuteHookW, pei: LPSHELLEXECUTEINFOW): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Execute(self, pei)
proc Translate*(self: ptr IURLSearchHook, pwszSearchURL: PWSTR, cchBufferSize: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Translate(self, pwszSearchURL, cchBufferSize)
proc GetSearchUrl*(self: ptr ISearchContext, pbstrSearchUrl: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSearchUrl(self, pbstrSearchUrl)
proc GetSearchText*(self: ptr ISearchContext, pbstrSearchText: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSearchText(self, pbstrSearchText)
proc GetSearchStyle*(self: ptr ISearchContext, pdwSearchStyle: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSearchStyle(self, pdwSearchStyle)
proc TranslateWithSearchContext*(self: ptr IURLSearchHook2, pwszSearchURL: PWSTR, cchBufferSize: DWORD, pSearchContext: ptr ISearchContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateWithSearchContext(self, pwszSearchURL, cchBufferSize, pSearchContext)
proc SetReferent*(self: ptr INewShortcutHookA, pcszReferent: PCSTR, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetReferent(self, pcszReferent, hwnd)
proc GetReferent*(self: ptr INewShortcutHookA, pszReferent: PSTR, cchReferent: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetReferent(self, pszReferent, cchReferent)
proc SetFolder*(self: ptr INewShortcutHookA, pcszFolder: PCSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolder(self, pcszFolder)
proc GetFolder*(self: ptr INewShortcutHookA, pszFolder: PSTR, cchFolder: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolder(self, pszFolder, cchFolder)
proc GetName*(self: ptr INewShortcutHookA, pszName: PSTR, cchName: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetName(self, pszName, cchName)
proc GetExtension*(self: ptr INewShortcutHookA, pszExtension: PSTR, cchExtension: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExtension(self, pszExtension, cchExtension)
proc SetReferent*(self: ptr INewShortcutHookW, pcszReferent: PCWSTR, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetReferent(self, pcszReferent, hwnd)
proc GetReferent*(self: ptr INewShortcutHookW, pszReferent: PWSTR, cchReferent: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetReferent(self, pszReferent, cchReferent)
proc SetFolder*(self: ptr INewShortcutHookW, pcszFolder: PCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFolder(self, pcszFolder)
proc GetFolder*(self: ptr INewShortcutHookW, pszFolder: PWSTR, cchFolder: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFolder(self, pszFolder, cchFolder)
proc GetName*(self: ptr INewShortcutHookW, pszName: PWSTR, cchName: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetName(self, pszName, cchName)
proc GetExtension*(self: ptr INewShortcutHookW, pszExtension: PWSTR, cchExtension: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExtension(self, pszExtension, cchExtension)
proc CopyCallback*(self: ptr ICopyHookA, hwnd: HWND, wFunc: UINT, wFlags: UINT, pszSrcFile: PCSTR, dwSrcAttribs: DWORD, pszDestFile: PCSTR, dwDestAttribs: DWORD): UINT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyCallback(self, hwnd, wFunc, wFlags, pszSrcFile, dwSrcAttribs, pszDestFile, dwDestAttribs)
proc CopyCallback*(self: ptr ICopyHookW, hwnd: HWND, wFunc: UINT, wFlags: UINT, pszSrcFile: PCWSTR, dwSrcAttribs: DWORD, pszDestFile: PCWSTR, dwDestAttribs: DWORD): UINT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyCallback(self, hwnd, wFunc, wFlags, pszSrcFile, dwSrcAttribs, pszDestFile, dwDestAttribs)
proc SetPinnedWindow*(self: ptr IFileViewerSite, hwnd: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPinnedWindow(self, hwnd)
proc GetPinnedWindow*(self: ptr IFileViewerSite, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPinnedWindow(self, phwnd)
proc ShowInitialize*(self: ptr IFileViewerA, lpfsi: LPFILEVIEWERSITE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowInitialize(self, lpfsi)
proc Show*(self: ptr IFileViewerA, pvsi: LPFVSHOWINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Show(self, pvsi)
proc PrintTo*(self: ptr IFileViewerA, pszDriver: PSTR, fSuppressUI: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PrintTo(self, pszDriver, fSuppressUI)
proc ShowInitialize*(self: ptr IFileViewerW, lpfsi: LPFILEVIEWERSITE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowInitialize(self, lpfsi)
proc Show*(self: ptr IFileViewerW, pvsi: LPFVSHOWINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Show(self, pvsi)
proc PrintTo*(self: ptr IFileViewerW, pszDriver: PWSTR, fSuppressUI: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PrintTo(self, pszDriver, fSuppressUI)
proc GetDetailsOf*(self: ptr IShellDetails, pidl: PCUITEMID_CHILD, iColumn: UINT, pDetails: ptr SHELLDETAILS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDetailsOf(self, pidl, iColumn, pDetails)
proc ColumnClick*(self: ptr IShellDetails, iColumn: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ColumnClick(self, iColumn)
proc Append*(self: ptr IObjMgr, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Append(self, punk)
proc Remove*(self: ptr IObjMgr, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Remove(self, punk)
proc GetDirectory*(self: ptr ICurrentWorkingDirectory, pwzPath: PWSTR, cchSize: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDirectory(self, pwzPath, cchSize)
proc SetDirectory*(self: ptr ICurrentWorkingDirectory, pwzPath: PCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDirectory(self, pwzPath)
proc Expand*(self: ptr IACList, pszExpand: PCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Expand(self, pszExpand)
proc SetOptions*(self: ptr IACList2, dwFlag: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetOptions(self, dwFlag)
proc GetOptions*(self: ptr IACList2, pdwFlag: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOptions(self, pdwFlag)
proc StartProgressDialog*(self: ptr IProgressDialog, hwndParent: HWND, punkEnableModless: ptr IUnknown, dwFlags: DWORD, pvResevered: LPCVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartProgressDialog(self, hwndParent, punkEnableModless, dwFlags, pvResevered)
proc StopProgressDialog*(self: ptr IProgressDialog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StopProgressDialog(self)
proc SetTitle*(self: ptr IProgressDialog, pwzTitle: PCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTitle(self, pwzTitle)
proc SetAnimation*(self: ptr IProgressDialog, hInstAnimation: HINSTANCE, idAnimation: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAnimation(self, hInstAnimation, idAnimation)
proc HasUserCancelled*(self: ptr IProgressDialog): WINBOOL {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HasUserCancelled(self)
proc SetProgress*(self: ptr IProgressDialog, dwCompleted: DWORD, dwTotal: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProgress(self, dwCompleted, dwTotal)
proc SetProgress64*(self: ptr IProgressDialog, ullCompleted: ULONGLONG, ullTotal: ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProgress64(self, ullCompleted, ullTotal)
proc SetLine*(self: ptr IProgressDialog, dwLineNum: DWORD, pwzString: PCWSTR, fCompactPath: WINBOOL, pvResevered: LPCVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLine(self, dwLineNum, pwzString, fCompactPath, pvResevered)
proc SetCancelMsg*(self: ptr IProgressDialog, pwzCancelMsg: PCWSTR, pvResevered: LPCVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCancelMsg(self, pwzCancelMsg, pvResevered)
proc Timer*(self: ptr IProgressDialog, dwTimerAction: DWORD, pvResevered: LPCVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Timer(self, dwTimerAction, pvResevered)
proc GetBorderDW*(self: ptr IDockingWindowSite, punkObj: ptr IUnknown, prcBorder: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBorderDW(self, punkObj, prcBorder)
proc RequestBorderSpaceDW*(self: ptr IDockingWindowSite, punkObj: ptr IUnknown, pbw: LPCBORDERWIDTHS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestBorderSpaceDW(self, punkObj, pbw)
proc SetBorderSpaceDW*(self: ptr IDockingWindowSite, punkObj: ptr IUnknown, pbw: LPCBORDERWIDTHS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBorderSpaceDW(self, punkObj, pbw)
proc AddToolbar*(self: ptr IDockingWindowFrame, punkSrc: ptr IUnknown, pwszItem: PCWSTR, dwAddFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddToolbar(self, punkSrc, pwszItem, dwAddFlags)
proc RemoveToolbar*(self: ptr IDockingWindowFrame, punkSrc: ptr IUnknown, dwRemoveFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveToolbar(self, punkSrc, dwRemoveFlags)
proc FindToolbar*(self: ptr IDockingWindowFrame, pwszItem: PCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindToolbar(self, pwszItem, riid, ppv)
proc CaptureThumbnail*(self: ptr IThumbnailCapture, pMaxSize: ptr SIZE, pHTMLDoc2: ptr IUnknown, phbmThumbnail: ptr HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CaptureThumbnail(self, pMaxSize, pHTMLDoc2, phbmThumbnail)
proc Reset*(self: ptr IEnumShellImageStore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Next*(self: ptr IEnumShellImageStore, celt: ULONG, prgElt: ptr PENUMSHELLIMAGESTOREDATA, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, prgElt, pceltFetched)
proc Skip*(self: ptr IEnumShellImageStore, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Clone*(self: ptr IEnumShellImageStore, ppEnum: ptr ptr IEnumShellImageStore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc Open*(self: ptr IShellImageStore, dwMode: DWORD, pdwLock: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Open(self, dwMode, pdwLock)
proc Create*(self: ptr IShellImageStore, dwMode: DWORD, pdwLock: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Create(self, dwMode, pdwLock)
proc ReleaseLock*(self: ptr IShellImageStore, pdwLock: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseLock(self, pdwLock)
proc Close*(self: ptr IShellImageStore, pdwLock: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Close(self, pdwLock)
proc Commit*(self: ptr IShellImageStore, pdwLock: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self, pdwLock)
proc IsLocked*(self: ptr IShellImageStore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsLocked(self)
proc GetMode*(self: ptr IShellImageStore, pdwMode: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMode(self, pdwMode)
proc GetCapabilities*(self: ptr IShellImageStore, pdwCapMask: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCapabilities(self, pdwCapMask)
proc AddEntry*(self: ptr IShellImageStore, pszName: PCWSTR, pftTimeStamp: ptr FILETIME, dwMode: DWORD, hImage: HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddEntry(self, pszName, pftTimeStamp, dwMode, hImage)
proc GetEntry*(self: ptr IShellImageStore, pszName: PCWSTR, dwMode: DWORD, phImage: ptr HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEntry(self, pszName, dwMode, phImage)
proc DeleteEntry*(self: ptr IShellImageStore, pszName: PCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteEntry(self, pszName)
proc IsEntryInStore*(self: ptr IShellImageStore, pszName: PCWSTR, pftTimeStamp: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsEntryInStore(self, pszName, pftTimeStamp)
proc Enum*(self: ptr IShellImageStore, ppEnum: ptr LPENUMSHELLIMAGESTORE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Enum(self, ppEnum)
proc InitializeSFB*(self: ptr IShellFolderBand, psf: ptr IShellFolder, pidl: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeSFB(self, psf, pidl)
proc SetBandInfoSFB*(self: ptr IShellFolderBand, pbi: PBANDINFOSFB): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBandInfoSFB(self, pbi)
proc GetBandInfoSFB*(self: ptr IShellFolderBand, pbi: PBANDINFOSFB): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBandInfoSFB(self, pbi)
proc SetDeskBarSite*(self: ptr IDeskBarClient, punkSite: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDeskBarSite(self, punkSite)
proc SetModeDBC*(self: ptr IDeskBarClient, dwMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetModeDBC(self, dwMode)
proc UIActivateDBC*(self: ptr IDeskBarClient, dwState: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UIActivateDBC(self, dwState)
proc GetSize*(self: ptr IDeskBarClient, dwWhich: DWORD, prc: LPRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSize(self, dwWhich, prc)
proc ApplyChanges*(self: ptr IActiveDesktop, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplyChanges(self, dwFlags)
proc GetWallpaper*(self: ptr IActiveDesktop, pwszWallpaper: PWSTR, cchWallpaper: UINT, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWallpaper(self, pwszWallpaper, cchWallpaper, dwFlags)
proc SetWallpaper*(self: ptr IActiveDesktop, pwszWallpaper: PCWSTR, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWallpaper(self, pwszWallpaper, dwReserved)
proc GetWallpaperOptions*(self: ptr IActiveDesktop, pwpo: LPWALLPAPEROPT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWallpaperOptions(self, pwpo, dwReserved)
proc SetWallpaperOptions*(self: ptr IActiveDesktop, pwpo: LPCWALLPAPEROPT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWallpaperOptions(self, pwpo, dwReserved)
proc GetPattern*(self: ptr IActiveDesktop, pwszPattern: PWSTR, cchPattern: UINT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPattern(self, pwszPattern, cchPattern, dwReserved)
proc SetPattern*(self: ptr IActiveDesktop, pwszPattern: PCWSTR, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPattern(self, pwszPattern, dwReserved)
proc GetDesktopItemOptions*(self: ptr IActiveDesktop, pco: LPCOMPONENTSOPT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDesktopItemOptions(self, pco, dwReserved)
proc SetDesktopItemOptions*(self: ptr IActiveDesktop, pco: LPCCOMPONENTSOPT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDesktopItemOptions(self, pco, dwReserved)
proc AddDesktopItem*(self: ptr IActiveDesktop, pcomp: LPCCOMPONENT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddDesktopItem(self, pcomp, dwReserved)
proc AddDesktopItemWithUI*(self: ptr IActiveDesktop, hwnd: HWND, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddDesktopItemWithUI(self, hwnd, pcomp, dwReserved)
proc ModifyDesktopItem*(self: ptr IActiveDesktop, pcomp: LPCCOMPONENT, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ModifyDesktopItem(self, pcomp, dwFlags)
proc RemoveDesktopItem*(self: ptr IActiveDesktop, pcomp: LPCCOMPONENT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveDesktopItem(self, pcomp, dwReserved)
proc GetDesktopItemCount*(self: ptr IActiveDesktop, pcItems: ptr int32, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDesktopItemCount(self, pcItems, dwReserved)
proc GetDesktopItem*(self: ptr IActiveDesktop, nComponent: int32, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDesktopItem(self, nComponent, pcomp, dwReserved)
proc GetDesktopItemByID*(self: ptr IActiveDesktop, dwID: ULONG_PTR, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDesktopItemByID(self, dwID, pcomp, dwReserved)
proc GenerateDesktopItemHtml*(self: ptr IActiveDesktop, pwszFileName: PCWSTR, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GenerateDesktopItemHtml(self, pwszFileName, pcomp, dwReserved)
proc AddUrl*(self: ptr IActiveDesktop, hwnd: HWND, pszSource: PCWSTR, pcomp: LPCOMPONENT, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddUrl(self, hwnd, pszSource, pcomp, dwFlags)
proc GetDesktopItemBySource*(self: ptr IActiveDesktop, pwszSource: PCWSTR, pcomp: LPCOMPONENT, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDesktopItemBySource(self, pwszSource, pcomp, dwReserved)
proc SetSafeMode*(self: ptr IActiveDesktopP, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSafeMode(self, dwFlags)
proc EnsureUpdateHTML*(self: ptr IActiveDesktopP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnsureUpdateHTML(self)
proc SetScheme*(self: ptr IActiveDesktopP, pwszSchemeName: PCWSTR, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetScheme(self, pwszSchemeName, dwFlags)
proc GetScheme*(self: ptr IActiveDesktopP, pwszSchemeName: PWSTR, pdwcchBuffer: ptr DWORD, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetScheme(self, pwszSchemeName, pdwcchBuffer, dwFlags)
proc ReReadWallpaper*(self: ptr IADesktopP2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReReadWallpaper(self)
proc GetADObjectFlags*(self: ptr IADesktopP2, pdwFlags: ptr DWORD, dwMask: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetADObjectFlags(self, pdwFlags, dwMask)
proc UpdateAllDesktopSubscriptions*(self: ptr IADesktopP2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateAllDesktopSubscriptions(self)
proc MakeDynamicChanges*(self: ptr IADesktopP2, pOleObj: ptr IOleObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MakeDynamicChanges(self, pOleObj)
proc Initialize*(self: ptr IColumnProvider, psci: LPCSHCOLUMNINIT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, psci)
proc GetColumnInfo*(self: ptr IColumnProvider, dwIndex: DWORD, psci: ptr SHCOLUMNINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumnInfo(self, dwIndex, psci)
proc GetItemData*(self: ptr IColumnProvider, pscid: LPCSHCOLUMNID, pscd: LPCSHCOLUMNDATA, pvarData: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemData(self, pscid, pscd, pvarData)
proc OnChange*(self: ptr IShellChangeNotify, lEvent: LONG, pidl1: PCIDLIST_ABSOLUTE, pidl2: PCIDLIST_ABSOLUTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnChange(self, lEvent, pidl1, pidl2)
proc GetInfoTip*(self: ptr IQueryInfo, dwFlags: DWORD, ppwszTip: ptr PWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInfoTip(self, dwFlags, ppwszTip)
proc GetInfoFlags*(self: ptr IQueryInfo, pdwFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInfoFlags(self, pdwFlags)
proc GetWindowLV*(self: ptr IDefViewFrame, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWindowLV(self, phwnd)
proc ReleaseWindowLV*(self: ptr IDefViewFrame): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseWindowLV(self)
proc GetShellFolder*(self: ptr IDefViewFrame, ppsf: ptr ptr IShellFolder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetShellFolder(self, ppsf)
proc OnSetTitle*(self: ptr IDocViewSite, pvTitle: ptr VARIANTARG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnSetTitle(self, pvTitle)
proc Initialize*(self: ptr IInitializeObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self)
proc SetIconSize*(self: ptr IBanneredBar, iIcon: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIconSize(self, iIcon)
proc GetIconSize*(self: ptr IBanneredBar, piIcon: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIconSize(self, piIcon)
proc SetBitmap*(self: ptr IBanneredBar, hBitmap: HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBitmap(self, hBitmap)
proc GetBitmap*(self: ptr IBanneredBar, phBitmap: ptr HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBitmap(self, phBitmap)
proc MessageSFVCB*(self: ptr IShellFolderViewCB, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MessageSFVCB(self, uMsg, wParam, lParam)
proc Rearrange*(self: ptr IShellFolderView, lParamSort: LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Rearrange(self, lParamSort)
proc GetArrangeParam*(self: ptr IShellFolderView, plParamSort: ptr LPARAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetArrangeParam(self, plParamSort)
proc ArrangeGrid*(self: ptr IShellFolderView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ArrangeGrid(self)
proc AutoArrange*(self: ptr IShellFolderView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AutoArrange(self)
proc GetAutoArrange*(self: ptr IShellFolderView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAutoArrange(self)
proc AddObject*(self: ptr IShellFolderView, pidl: PUITEMID_CHILD, puItem: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddObject(self, pidl, puItem)
proc GetObject*(self: ptr IShellFolderView, ppidl: ptr PITEMID_CHILD, uItem: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObject(self, ppidl, uItem)
proc RemoveObject*(self: ptr IShellFolderView, pidl: PUITEMID_CHILD, puItem: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveObject(self, pidl, puItem)
proc GetObjectCount*(self: ptr IShellFolderView, puCount: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectCount(self, puCount)
proc SetObjectCount*(self: ptr IShellFolderView, uCount: UINT, dwFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetObjectCount(self, uCount, dwFlags)
proc UpdateObject*(self: ptr IShellFolderView, pidlOld: PUITEMID_CHILD, pidlNew: PUITEMID_CHILD, puItem: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateObject(self, pidlOld, pidlNew, puItem)
proc RefreshObject*(self: ptr IShellFolderView, pidl: PUITEMID_CHILD, puItem: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RefreshObject(self, pidl, puItem)
proc SetRedraw*(self: ptr IShellFolderView, bRedraw: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRedraw(self, bRedraw)
proc GetSelectedCount*(self: ptr IShellFolderView, puSelected: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelectedCount(self, puSelected)
proc GetSelectedObjects*(self: ptr IShellFolderView, pppidl: ptr ptr PCUITEMID_CHILD, puItems: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelectedObjects(self, pppidl, puItems)
proc IsDropOnSource*(self: ptr IShellFolderView, pDropTarget: ptr IDropTarget): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDropOnSource(self, pDropTarget)
proc GetDragPoint*(self: ptr IShellFolderView, ppt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDragPoint(self, ppt)
proc GetDropPoint*(self: ptr IShellFolderView, ppt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDropPoint(self, ppt)
proc MoveIcons*(self: ptr IShellFolderView, pDataObject: ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveIcons(self, pDataObject)
proc SetItemPos*(self: ptr IShellFolderView, pidl: PCUITEMID_CHILD, ppt: ptr POINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetItemPos(self, pidl, ppt)
proc IsBkDropTarget*(self: ptr IShellFolderView, pDropTarget: ptr IDropTarget): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsBkDropTarget(self, pDropTarget)
proc SetClipboard*(self: ptr IShellFolderView, bMove: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetClipboard(self, bMove)
proc SetPoints*(self: ptr IShellFolderView, pDataObject: ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPoints(self, pDataObject)
proc GetItemSpacing*(self: ptr IShellFolderView, pSpacing: ptr ITEMSPACING): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemSpacing(self, pSpacing)
proc SetCallback*(self: ptr IShellFolderView, pNewCB: ptr IShellFolderViewCB, ppOldCB: ptr ptr IShellFolderViewCB): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCallback(self, pNewCB, ppOldCB)
proc Select*(self: ptr IShellFolderView, dwFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Select(self, dwFlags)
proc QuerySupport*(self: ptr IShellFolderView, pdwSupport: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QuerySupport(self, pdwSupport)
proc SetAutomationObject*(self: ptr IShellFolderView, pdisp: ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAutomationObject(self, pdisp)
proc ReadPropertyNPB*(self: ptr INamedPropertyBag, pszBagname: PCWSTR, pszPropName: PCWSTR, pVar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReadPropertyNPB(self, pszBagname, pszPropName, pVar)
proc WritePropertyNPB*(self: ptr INamedPropertyBag, pszBagname: PCWSTR, pszPropName: PCWSTR, pVar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WritePropertyNPB(self, pszBagname, pszPropName, pVar)
proc RemovePropertyNPB*(self: ptr INamedPropertyBag, pszBagname: PCWSTR, pszPropName: PCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemovePropertyNPB(self, pszBagname, pszPropName)
converter winimConverterIQueryAssociationsToIUnknown*(x: ptr IQueryAssociations): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderViewOCToIDispatch*(x: ptr IFolderViewOC): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIFolderViewOCToIUnknown*(x: ptr IFolderViewOC): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterDShellFolderViewEventsToIDispatch*(x: ptr DShellFolderViewEvents): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterDShellFolderViewEventsToIUnknown*(x: ptr DShellFolderViewEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterDFConstraintToIDispatch*(x: ptr DFConstraint): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterDFConstraintToIUnknown*(x: ptr DFConstraint): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolderToIDispatch*(x: ptr Folder): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolderToIUnknown*(x: ptr Folder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolder2ToFolder*(x: ptr Folder2): ptr Folder = cast[ptr Folder](x)
converter winimConverterFolder2ToIDispatch*(x: ptr Folder2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolder2ToIUnknown*(x: ptr Folder2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolder3ToFolder2*(x: ptr Folder3): ptr Folder2 = cast[ptr Folder2](x)
converter winimConverterFolder3ToFolder*(x: ptr Folder3): ptr Folder = cast[ptr Folder](x)
converter winimConverterFolder3ToIDispatch*(x: ptr Folder3): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolder3ToIUnknown*(x: ptr Folder3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolderItemToIDispatch*(x: ptr FolderItem): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolderItemToIUnknown*(x: ptr FolderItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolderItem2ToFolderItem*(x: ptr FolderItem2): ptr FolderItem = cast[ptr FolderItem](x)
converter winimConverterFolderItem2ToIDispatch*(x: ptr FolderItem2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolderItem2ToIUnknown*(x: ptr FolderItem2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolderItemsToIDispatch*(x: ptr FolderItems): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolderItemsToIUnknown*(x: ptr FolderItems): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolderItems2ToFolderItems*(x: ptr FolderItems2): ptr FolderItems = cast[ptr FolderItems](x)
converter winimConverterFolderItems2ToIDispatch*(x: ptr FolderItems2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolderItems2ToIUnknown*(x: ptr FolderItems2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolderItems3ToFolderItems2*(x: ptr FolderItems3): ptr FolderItems2 = cast[ptr FolderItems2](x)
converter winimConverterFolderItems3ToFolderItems*(x: ptr FolderItems3): ptr FolderItems = cast[ptr FolderItems](x)
converter winimConverterFolderItems3ToIDispatch*(x: ptr FolderItems3): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolderItems3ToIUnknown*(x: ptr FolderItems3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolderItemVerbToIDispatch*(x: ptr FolderItemVerb): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolderItemVerbToIUnknown*(x: ptr FolderItemVerb): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterFolderItemVerbsToIDispatch*(x: ptr FolderItemVerbs): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterFolderItemVerbsToIUnknown*(x: ptr FolderItemVerbs): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellLinkDualToIDispatch*(x: ptr IShellLinkDual): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellLinkDualToIUnknown*(x: ptr IShellLinkDual): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellLinkDual2ToIShellLinkDual*(x: ptr IShellLinkDual2): ptr IShellLinkDual = cast[ptr IShellLinkDual](x)
converter winimConverterIShellLinkDual2ToIDispatch*(x: ptr IShellLinkDual2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellLinkDual2ToIUnknown*(x: ptr IShellLinkDual2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFolderViewDualToIDispatch*(x: ptr IShellFolderViewDual): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellFolderViewDualToIUnknown*(x: ptr IShellFolderViewDual): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFolderViewDual2ToIShellFolderViewDual*(x: ptr IShellFolderViewDual2): ptr IShellFolderViewDual = cast[ptr IShellFolderViewDual](x)
converter winimConverterIShellFolderViewDual2ToIDispatch*(x: ptr IShellFolderViewDual2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellFolderViewDual2ToIUnknown*(x: ptr IShellFolderViewDual2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFolderViewDual3ToIShellFolderViewDual2*(x: ptr IShellFolderViewDual3): ptr IShellFolderViewDual2 = cast[ptr IShellFolderViewDual2](x)
converter winimConverterIShellFolderViewDual3ToIShellFolderViewDual*(x: ptr IShellFolderViewDual3): ptr IShellFolderViewDual = cast[ptr IShellFolderViewDual](x)
converter winimConverterIShellFolderViewDual3ToIDispatch*(x: ptr IShellFolderViewDual3): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellFolderViewDual3ToIUnknown*(x: ptr IShellFolderViewDual3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellDispatchToIDispatch*(x: ptr IShellDispatch): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellDispatchToIUnknown*(x: ptr IShellDispatch): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellDispatch2ToIShellDispatch*(x: ptr IShellDispatch2): ptr IShellDispatch = cast[ptr IShellDispatch](x)
converter winimConverterIShellDispatch2ToIDispatch*(x: ptr IShellDispatch2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellDispatch2ToIUnknown*(x: ptr IShellDispatch2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellDispatch3ToIShellDispatch2*(x: ptr IShellDispatch3): ptr IShellDispatch2 = cast[ptr IShellDispatch2](x)
converter winimConverterIShellDispatch3ToIShellDispatch*(x: ptr IShellDispatch3): ptr IShellDispatch = cast[ptr IShellDispatch](x)
converter winimConverterIShellDispatch3ToIDispatch*(x: ptr IShellDispatch3): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellDispatch3ToIUnknown*(x: ptr IShellDispatch3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellDispatch4ToIShellDispatch3*(x: ptr IShellDispatch4): ptr IShellDispatch3 = cast[ptr IShellDispatch3](x)
converter winimConverterIShellDispatch4ToIShellDispatch2*(x: ptr IShellDispatch4): ptr IShellDispatch2 = cast[ptr IShellDispatch2](x)
converter winimConverterIShellDispatch4ToIShellDispatch*(x: ptr IShellDispatch4): ptr IShellDispatch = cast[ptr IShellDispatch](x)
converter winimConverterIShellDispatch4ToIDispatch*(x: ptr IShellDispatch4): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellDispatch4ToIUnknown*(x: ptr IShellDispatch4): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellDispatch5ToIShellDispatch4*(x: ptr IShellDispatch5): ptr IShellDispatch4 = cast[ptr IShellDispatch4](x)
converter winimConverterIShellDispatch5ToIShellDispatch3*(x: ptr IShellDispatch5): ptr IShellDispatch3 = cast[ptr IShellDispatch3](x)
converter winimConverterIShellDispatch5ToIShellDispatch2*(x: ptr IShellDispatch5): ptr IShellDispatch2 = cast[ptr IShellDispatch2](x)
converter winimConverterIShellDispatch5ToIShellDispatch*(x: ptr IShellDispatch5): ptr IShellDispatch = cast[ptr IShellDispatch](x)
converter winimConverterIShellDispatch5ToIDispatch*(x: ptr IShellDispatch5): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellDispatch5ToIUnknown*(x: ptr IShellDispatch5): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellDispatch6ToIShellDispatch5*(x: ptr IShellDispatch6): ptr IShellDispatch5 = cast[ptr IShellDispatch5](x)
converter winimConverterIShellDispatch6ToIShellDispatch4*(x: ptr IShellDispatch6): ptr IShellDispatch4 = cast[ptr IShellDispatch4](x)
converter winimConverterIShellDispatch6ToIShellDispatch3*(x: ptr IShellDispatch6): ptr IShellDispatch3 = cast[ptr IShellDispatch3](x)
converter winimConverterIShellDispatch6ToIShellDispatch2*(x: ptr IShellDispatch6): ptr IShellDispatch2 = cast[ptr IShellDispatch2](x)
converter winimConverterIShellDispatch6ToIShellDispatch*(x: ptr IShellDispatch6): ptr IShellDispatch = cast[ptr IShellDispatch](x)
converter winimConverterIShellDispatch6ToIDispatch*(x: ptr IShellDispatch6): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellDispatch6ToIUnknown*(x: ptr IShellDispatch6): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileSearchBandToIDispatch*(x: ptr IFileSearchBand): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIFileSearchBandToIUnknown*(x: ptr IFileSearchBand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWebWizardHostToIDispatch*(x: ptr IWebWizardHost): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIWebWizardHostToIUnknown*(x: ptr IWebWizardHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINewWDEventsToIWebWizardHost*(x: ptr INewWDEvents): ptr IWebWizardHost = cast[ptr IWebWizardHost](x)
converter winimConverterINewWDEventsToIDispatch*(x: ptr INewWDEvents): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterINewWDEventsToIUnknown*(x: ptr INewWDEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAutoCompleteToIUnknown*(x: ptr IAutoComplete): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAutoComplete2ToIAutoComplete*(x: ptr IAutoComplete2): ptr IAutoComplete = cast[ptr IAutoComplete](x)
converter winimConverterIAutoComplete2ToIUnknown*(x: ptr IAutoComplete2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumACStringToIEnumString*(x: ptr IEnumACString): ptr IEnumString = cast[ptr IEnumString](x)
converter winimConverterIEnumACStringToIUnknown*(x: ptr IEnumACString): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDataObjectAsyncCapabilityToIUnknown*(x: ptr IDataObjectAsyncCapability): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectArrayToIUnknown*(x: ptr IObjectArray): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectCollectionToIObjectArray*(x: ptr IObjectCollection): ptr IObjectArray = cast[ptr IObjectArray](x)
converter winimConverterIObjectCollectionToIUnknown*(x: ptr IObjectCollection): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIContextMenuToIUnknown*(x: ptr IContextMenu): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIContextMenu2ToIContextMenu*(x: ptr IContextMenu2): ptr IContextMenu = cast[ptr IContextMenu](x)
converter winimConverterIContextMenu2ToIUnknown*(x: ptr IContextMenu2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIContextMenu3ToIContextMenu2*(x: ptr IContextMenu3): ptr IContextMenu2 = cast[ptr IContextMenu2](x)
converter winimConverterIContextMenu3ToIContextMenu*(x: ptr IContextMenu3): ptr IContextMenu = cast[ptr IContextMenu](x)
converter winimConverterIContextMenu3ToIUnknown*(x: ptr IContextMenu3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExecuteCommandToIUnknown*(x: ptr IExecuteCommand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistFolderToIPersist*(x: ptr IPersistFolder): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistFolderToIUnknown*(x: ptr IPersistFolder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRunnableTaskToIUnknown*(x: ptr IRunnableTask): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellTaskSchedulerToIUnknown*(x: ptr IShellTaskScheduler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIQueryCodePageToIUnknown*(x: ptr IQueryCodePage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistFolder2ToIPersistFolder*(x: ptr IPersistFolder2): ptr IPersistFolder = cast[ptr IPersistFolder](x)
converter winimConverterIPersistFolder2ToIPersist*(x: ptr IPersistFolder2): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistFolder2ToIUnknown*(x: ptr IPersistFolder2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistFolder3ToIPersistFolder2*(x: ptr IPersistFolder3): ptr IPersistFolder2 = cast[ptr IPersistFolder2](x)
converter winimConverterIPersistFolder3ToIPersistFolder*(x: ptr IPersistFolder3): ptr IPersistFolder = cast[ptr IPersistFolder](x)
converter winimConverterIPersistFolder3ToIPersist*(x: ptr IPersistFolder3): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistFolder3ToIUnknown*(x: ptr IPersistFolder3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistIDListToIPersist*(x: ptr IPersistIDList): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistIDListToIUnknown*(x: ptr IPersistIDList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumIDListToIUnknown*(x: ptr IEnumIDList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumFullIDListToIUnknown*(x: ptr IEnumFullIDList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectWithFolderEnumModeToIUnknown*(x: ptr IObjectWithFolderEnumMode): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIParseAndCreateItemToIUnknown*(x: ptr IParseAndCreateItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFolderToIUnknown*(x: ptr IShellFolder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumExtraSearchToIUnknown*(x: ptr IEnumExtraSearch): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFolder2ToIShellFolder*(x: ptr IShellFolder2): ptr IShellFolder = cast[ptr IShellFolder](x)
converter winimConverterIShellFolder2ToIUnknown*(x: ptr IShellFolder2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderViewOptionsToIUnknown*(x: ptr IFolderViewOptions): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellViewToIOleWindow*(x: ptr IShellView): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIShellViewToIUnknown*(x: ptr IShellView): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellView2ToIShellView*(x: ptr IShellView2): ptr IShellView = cast[ptr IShellView](x)
converter winimConverterIShellView2ToIOleWindow*(x: ptr IShellView2): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIShellView2ToIUnknown*(x: ptr IShellView2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellView3ToIShellView2*(x: ptr IShellView3): ptr IShellView2 = cast[ptr IShellView2](x)
converter winimConverterIShellView3ToIShellView*(x: ptr IShellView3): ptr IShellView = cast[ptr IShellView](x)
converter winimConverterIShellView3ToIOleWindow*(x: ptr IShellView3): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIShellView3ToIUnknown*(x: ptr IShellView3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderViewToIUnknown*(x: ptr IFolderView): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchBoxInfoToIUnknown*(x: ptr ISearchBoxInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderView2ToIFolderView*(x: ptr IFolderView2): ptr IFolderView = cast[ptr IFolderView](x)
converter winimConverterIFolderView2ToIUnknown*(x: ptr IFolderView2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderViewSettingsToIUnknown*(x: ptr IFolderViewSettings): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPreviewHandlerVisualsToIUnknown*(x: ptr IPreviewHandlerVisuals): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIVisualPropertiesToIUnknown*(x: ptr IVisualProperties): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICommDlgBrowserToIUnknown*(x: ptr ICommDlgBrowser): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICommDlgBrowser2ToICommDlgBrowser*(x: ptr ICommDlgBrowser2): ptr ICommDlgBrowser = cast[ptr ICommDlgBrowser](x)
converter winimConverterICommDlgBrowser2ToIUnknown*(x: ptr ICommDlgBrowser2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICommDlgBrowser3ToICommDlgBrowser2*(x: ptr ICommDlgBrowser3): ptr ICommDlgBrowser2 = cast[ptr ICommDlgBrowser2](x)
converter winimConverterICommDlgBrowser3ToICommDlgBrowser*(x: ptr ICommDlgBrowser3): ptr ICommDlgBrowser = cast[ptr ICommDlgBrowser](x)
converter winimConverterICommDlgBrowser3ToIUnknown*(x: ptr ICommDlgBrowser3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIColumnManagerToIUnknown*(x: ptr IColumnManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderFilterSiteToIUnknown*(x: ptr IFolderFilterSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderFilterToIUnknown*(x: ptr IFolderFilter): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInputObjectSiteToIUnknown*(x: ptr IInputObjectSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInputObjectToIUnknown*(x: ptr IInputObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInputObject2ToIInputObject*(x: ptr IInputObject2): ptr IInputObject = cast[ptr IInputObject](x)
converter winimConverterIInputObject2ToIUnknown*(x: ptr IInputObject2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellIconToIUnknown*(x: ptr IShellIcon): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellBrowserToIOleWindow*(x: ptr IShellBrowser): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIShellBrowserToIUnknown*(x: ptr IShellBrowser): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProfferServiceToIUnknown*(x: ptr IProfferService): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellItemToIUnknown*(x: ptr IShellItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellItem2ToIShellItem*(x: ptr IShellItem2): ptr IShellItem = cast[ptr IShellItem](x)
converter winimConverterIShellItem2ToIUnknown*(x: ptr IShellItem2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellItemImageFactoryToIUnknown*(x: ptr IShellItemImageFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUserAccountChangeCallbackToIUnknown*(x: ptr IUserAccountChangeCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumShellItemsToIUnknown*(x: ptr IEnumShellItems): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITransferAdviseSinkToIUnknown*(x: ptr ITransferAdviseSink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITransferSourceToIUnknown*(x: ptr ITransferSource): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumResourcesToIUnknown*(x: ptr IEnumResources): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellItemResourcesToIUnknown*(x: ptr IShellItemResources): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITransferDestinationToIUnknown*(x: ptr ITransferDestination): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIStreamAsyncToIStream*(x: ptr IStreamAsync): ptr IStream = cast[ptr IStream](x)
converter winimConverterIStreamAsyncToISequentialStream*(x: ptr IStreamAsync): ptr ISequentialStream = cast[ptr ISequentialStream](x)
converter winimConverterIStreamAsyncToIUnknown*(x: ptr IStreamAsync): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIStreamUnbufferedInfoToIUnknown*(x: ptr IStreamUnbufferedInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileOperationProgressSinkToIUnknown*(x: ptr IFileOperationProgressSink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellItemArrayToIUnknown*(x: ptr IShellItemArray): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeWithItemToIUnknown*(x: ptr IInitializeWithItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectWithSelectionToIUnknown*(x: ptr IObjectWithSelection): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectWithBackReferencesToIUnknown*(x: ptr IObjectWithBackReferences): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyUIToIUnknown*(x: ptr IPropertyUI): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICategoryProviderToIUnknown*(x: ptr ICategoryProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICategorizerToIUnknown*(x: ptr ICategorizer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDropTargetHelperToIUnknown*(x: ptr IDropTargetHelper): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDragSourceHelperToIUnknown*(x: ptr IDragSourceHelper): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDragSourceHelper2ToIDragSourceHelper*(x: ptr IDragSourceHelper2): ptr IDragSourceHelper = cast[ptr IDragSourceHelper](x)
converter winimConverterIDragSourceHelper2ToIUnknown*(x: ptr IDragSourceHelper2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellLinkAToIUnknown*(x: ptr IShellLinkA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellLinkWToIUnknown*(x: ptr IShellLinkW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellLinkDataListToIUnknown*(x: ptr IShellLinkDataList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIResolveShellLinkToIUnknown*(x: ptr IResolveShellLink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActionProgressDialogToIUnknown*(x: ptr IActionProgressDialog): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHWEventHandlerToIUnknown*(x: ptr IHWEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHWEventHandler2ToIHWEventHandler*(x: ptr IHWEventHandler2): ptr IHWEventHandler = cast[ptr IHWEventHandler](x)
converter winimConverterIHWEventHandler2ToIUnknown*(x: ptr IHWEventHandler2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIQueryCancelAutoPlayToIUnknown*(x: ptr IQueryCancelAutoPlay): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDynamicHWHandlerToIUnknown*(x: ptr IDynamicHWHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActionProgressToIUnknown*(x: ptr IActionProgress): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellExtInitToIUnknown*(x: ptr IShellExtInit): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellPropSheetExtToIUnknown*(x: ptr IShellPropSheetExt): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRemoteComputerToIUnknown*(x: ptr IRemoteComputer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIQueryContinueToIUnknown*(x: ptr IQueryContinue): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectWithCancelEventToIUnknown*(x: ptr IObjectWithCancelEvent): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUserNotificationToIUnknown*(x: ptr IUserNotification): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUserNotificationCallbackToIUnknown*(x: ptr IUserNotificationCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUserNotification2ToIUnknown*(x: ptr IUserNotification2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIItemNameLimitsToIUnknown*(x: ptr IItemNameLimits): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchFolderItemFactoryToIUnknown*(x: ptr ISearchFolderItemFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExtractImageToIUnknown*(x: ptr IExtractImage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExtractImage2ToIExtractImage*(x: ptr IExtractImage2): ptr IExtractImage = cast[ptr IExtractImage](x)
converter winimConverterIExtractImage2ToIUnknown*(x: ptr IExtractImage2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIThumbnailHandlerFactoryToIUnknown*(x: ptr IThumbnailHandlerFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIParentAndItemToIUnknown*(x: ptr IParentAndItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDockingWindowToIOleWindow*(x: ptr IDockingWindow): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIDockingWindowToIUnknown*(x: ptr IDockingWindow): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDeskBandToIDockingWindow*(x: ptr IDeskBand): ptr IDockingWindow = cast[ptr IDockingWindow](x)
converter winimConverterIDeskBandToIOleWindow*(x: ptr IDeskBand): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIDeskBandToIUnknown*(x: ptr IDeskBand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDeskBandInfoToIUnknown*(x: ptr IDeskBandInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDeskBand2ToIDeskBand*(x: ptr IDeskBand2): ptr IDeskBand = cast[ptr IDeskBand](x)
converter winimConverterIDeskBand2ToIDockingWindow*(x: ptr IDeskBand2): ptr IDockingWindow = cast[ptr IDockingWindow](x)
converter winimConverterIDeskBand2ToIOleWindow*(x: ptr IDeskBand2): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIDeskBand2ToIUnknown*(x: ptr IDeskBand2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITaskbarListToIUnknown*(x: ptr ITaskbarList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITaskbarList2ToITaskbarList*(x: ptr ITaskbarList2): ptr ITaskbarList = cast[ptr ITaskbarList](x)
converter winimConverterITaskbarList2ToIUnknown*(x: ptr ITaskbarList2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITaskbarList3ToITaskbarList2*(x: ptr ITaskbarList3): ptr ITaskbarList2 = cast[ptr ITaskbarList2](x)
converter winimConverterITaskbarList3ToITaskbarList*(x: ptr ITaskbarList3): ptr ITaskbarList = cast[ptr ITaskbarList](x)
converter winimConverterITaskbarList3ToIUnknown*(x: ptr ITaskbarList3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITaskbarList4ToITaskbarList3*(x: ptr ITaskbarList4): ptr ITaskbarList3 = cast[ptr ITaskbarList3](x)
converter winimConverterITaskbarList4ToITaskbarList2*(x: ptr ITaskbarList4): ptr ITaskbarList2 = cast[ptr ITaskbarList2](x)
converter winimConverterITaskbarList4ToITaskbarList*(x: ptr ITaskbarList4): ptr ITaskbarList = cast[ptr ITaskbarList](x)
converter winimConverterITaskbarList4ToIUnknown*(x: ptr ITaskbarList4): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIStartMenuPinnedListToIUnknown*(x: ptr IStartMenuPinnedList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICDBurnToIUnknown*(x: ptr ICDBurn): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWizardSiteToIUnknown*(x: ptr IWizardSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWizardExtensionToIUnknown*(x: ptr IWizardExtension): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWebWizardExtensionToIWizardExtension*(x: ptr IWebWizardExtension): ptr IWizardExtension = cast[ptr IWizardExtension](x)
converter winimConverterIWebWizardExtensionToIUnknown*(x: ptr IWebWizardExtension): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPublishingWizardToIWizardExtension*(x: ptr IPublishingWizard): ptr IWizardExtension = cast[ptr IWizardExtension](x)
converter winimConverterIPublishingWizardToIUnknown*(x: ptr IPublishingWizard): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderViewHostToIUnknown*(x: ptr IFolderViewHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExplorerBrowserEventsToIUnknown*(x: ptr IExplorerBrowserEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExplorerBrowserToIUnknown*(x: ptr IExplorerBrowser): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccessibleObjectToIUnknown*(x: ptr IAccessibleObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIResultsFolderToIUnknown*(x: ptr IResultsFolder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumObjectsToIUnknown*(x: ptr IEnumObjects): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOperationsProgressDialogToIUnknown*(x: ptr IOperationsProgressDialog): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIIOCancelInformationToIUnknown*(x: ptr IIOCancelInformation): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileOperationToIUnknown*(x: ptr IFileOperation): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectProviderToIUnknown*(x: ptr IObjectProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINamespaceWalkCBToIUnknown*(x: ptr INamespaceWalkCB): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINamespaceWalkCB2ToINamespaceWalkCB*(x: ptr INamespaceWalkCB2): ptr INamespaceWalkCB = cast[ptr INamespaceWalkCB](x)
converter winimConverterINamespaceWalkCB2ToIUnknown*(x: ptr INamespaceWalkCB2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINamespaceWalkToIUnknown*(x: ptr INamespaceWalk): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAutoCompleteDropDownToIUnknown*(x: ptr IAutoCompleteDropDown): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBandSiteToIUnknown*(x: ptr IBandSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIModalWindowToIUnknown*(x: ptr IModalWindow): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICDBurnExtToIUnknown*(x: ptr ICDBurnExt): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIContextMenuSiteToIUnknown*(x: ptr IContextMenuSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumReadyCallbackToIUnknown*(x: ptr IEnumReadyCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumerableViewToIUnknown*(x: ptr IEnumerableView): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInsertItemToIUnknown*(x: ptr IInsertItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMenuBandToIUnknown*(x: ptr IMenuBand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFolderBandPrivToIUnknown*(x: ptr IFolderBandPriv): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRegTreeItemToIUnknown*(x: ptr IRegTreeItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIImageRecompressToIUnknown*(x: ptr IImageRecompress): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDeskBarToIOleWindow*(x: ptr IDeskBar): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIDeskBarToIUnknown*(x: ptr IDeskBar): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMenuPopupToIDeskBar*(x: ptr IMenuPopup): ptr IDeskBar = cast[ptr IDeskBar](x)
converter winimConverterIMenuPopupToIOleWindow*(x: ptr IMenuPopup): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIMenuPopupToIUnknown*(x: ptr IMenuPopup): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileIsInUseToIUnknown*(x: ptr IFileIsInUse): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileDialogEventsToIUnknown*(x: ptr IFileDialogEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileDialogToIModalWindow*(x: ptr IFileDialog): ptr IModalWindow = cast[ptr IModalWindow](x)
converter winimConverterIFileDialogToIUnknown*(x: ptr IFileDialog): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileSaveDialogToIFileDialog*(x: ptr IFileSaveDialog): ptr IFileDialog = cast[ptr IFileDialog](x)
converter winimConverterIFileSaveDialogToIModalWindow*(x: ptr IFileSaveDialog): ptr IModalWindow = cast[ptr IModalWindow](x)
converter winimConverterIFileSaveDialogToIUnknown*(x: ptr IFileSaveDialog): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileOpenDialogToIFileDialog*(x: ptr IFileOpenDialog): ptr IFileDialog = cast[ptr IFileDialog](x)
converter winimConverterIFileOpenDialogToIModalWindow*(x: ptr IFileOpenDialog): ptr IModalWindow = cast[ptr IModalWindow](x)
converter winimConverterIFileOpenDialogToIUnknown*(x: ptr IFileOpenDialog): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileDialogCustomizeToIUnknown*(x: ptr IFileDialogCustomize): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileDialogControlEventsToIUnknown*(x: ptr IFileDialogControlEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileDialog2ToIFileDialog*(x: ptr IFileDialog2): ptr IFileDialog = cast[ptr IFileDialog](x)
converter winimConverterIFileDialog2ToIModalWindow*(x: ptr IFileDialog2): ptr IModalWindow = cast[ptr IModalWindow](x)
converter winimConverterIFileDialog2ToIUnknown*(x: ptr IFileDialog2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIApplicationAssociationRegistrationToIUnknown*(x: ptr IApplicationAssociationRegistration): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIApplicationAssociationRegistrationUIToIUnknown*(x: ptr IApplicationAssociationRegistrationUI): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDelegateFolderToIUnknown*(x: ptr IDelegateFolder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBrowserFrameOptionsToIUnknown*(x: ptr IBrowserFrameOptions): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINewWindowManagerToIUnknown*(x: ptr INewWindowManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAttachmentExecuteToIUnknown*(x: ptr IAttachmentExecute): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellMenuCallbackToIUnknown*(x: ptr IShellMenuCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellMenuToIUnknown*(x: ptr IShellMenu): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellRunDllToIUnknown*(x: ptr IShellRunDll): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIKnownFolderToIUnknown*(x: ptr IKnownFolder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIKnownFolderManagerToIUnknown*(x: ptr IKnownFolderManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISharingConfigurationManagerToIUnknown*(x: ptr ISharingConfigurationManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPreviousVersionsInfoToIUnknown*(x: ptr IPreviousVersionsInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRelatedItemToIUnknown*(x: ptr IRelatedItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIIdentityNameToIRelatedItem*(x: ptr IIdentityName): ptr IRelatedItem = cast[ptr IRelatedItem](x)
converter winimConverterIIdentityNameToIUnknown*(x: ptr IIdentityName): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDelegateItemToIRelatedItem*(x: ptr IDelegateItem): ptr IRelatedItem = cast[ptr IRelatedItem](x)
converter winimConverterIDelegateItemToIUnknown*(x: ptr IDelegateItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICurrentItemToIRelatedItem*(x: ptr ICurrentItem): ptr IRelatedItem = cast[ptr IRelatedItem](x)
converter winimConverterICurrentItemToIUnknown*(x: ptr ICurrentItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITransferMediumItemToIRelatedItem*(x: ptr ITransferMediumItem): ptr IRelatedItem = cast[ptr IRelatedItem](x)
converter winimConverterITransferMediumItemToIUnknown*(x: ptr ITransferMediumItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUseToBrowseItemToIRelatedItem*(x: ptr IUseToBrowseItem): ptr IRelatedItem = cast[ptr IRelatedItem](x)
converter winimConverterIUseToBrowseItemToIUnknown*(x: ptr IUseToBrowseItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDisplayItemToIRelatedItem*(x: ptr IDisplayItem): ptr IRelatedItem = cast[ptr IRelatedItem](x)
converter winimConverterIDisplayItemToIUnknown*(x: ptr IDisplayItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIViewStateIdentityItemToIRelatedItem*(x: ptr IViewStateIdentityItem): ptr IRelatedItem = cast[ptr IRelatedItem](x)
converter winimConverterIViewStateIdentityItemToIUnknown*(x: ptr IViewStateIdentityItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPreviewItemToIRelatedItem*(x: ptr IPreviewItem): ptr IRelatedItem = cast[ptr IRelatedItem](x)
converter winimConverterIPreviewItemToIUnknown*(x: ptr IPreviewItem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDestinationStreamFactoryToIUnknown*(x: ptr IDestinationStreamFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINewMenuClientToIUnknown*(x: ptr INewMenuClient): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeWithBindCtxToIUnknown*(x: ptr IInitializeWithBindCtx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellItemFilterToIUnknown*(x: ptr IShellItemFilter): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINameSpaceTreeControlToIUnknown*(x: ptr INameSpaceTreeControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINameSpaceTreeControl2ToINameSpaceTreeControl*(x: ptr INameSpaceTreeControl2): ptr INameSpaceTreeControl = cast[ptr INameSpaceTreeControl](x)
converter winimConverterINameSpaceTreeControl2ToIUnknown*(x: ptr INameSpaceTreeControl2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINameSpaceTreeControlEventsToIUnknown*(x: ptr INameSpaceTreeControlEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINameSpaceTreeControlDropHandlerToIUnknown*(x: ptr INameSpaceTreeControlDropHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINameSpaceTreeAccessibleToIUnknown*(x: ptr INameSpaceTreeAccessible): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINameSpaceTreeControlCustomDrawToIUnknown*(x: ptr INameSpaceTreeControlCustomDraw): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINameSpaceTreeControlFolderCapabilitiesToIUnknown*(x: ptr INameSpaceTreeControlFolderCapabilities): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPreviewHandlerToIUnknown*(x: ptr IPreviewHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPreviewHandlerFrameToIUnknown*(x: ptr IPreviewHandlerFrame): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITrayDeskBandToIUnknown*(x: ptr ITrayDeskBand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBandHostToIUnknown*(x: ptr IBandHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExplorerPaneVisibilityToIUnknown*(x: ptr IExplorerPaneVisibility): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIContextMenuCBToIUnknown*(x: ptr IContextMenuCB): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDefaultExtractIconInitToIUnknown*(x: ptr IDefaultExtractIconInit): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExplorerCommandToIUnknown*(x: ptr IExplorerCommand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExplorerCommandStateToIUnknown*(x: ptr IExplorerCommandState): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeCommandToIUnknown*(x: ptr IInitializeCommand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumExplorerCommandToIUnknown*(x: ptr IEnumExplorerCommand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExplorerCommandProviderToIUnknown*(x: ptr IExplorerCommandProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeNetworkFolderToIUnknown*(x: ptr IInitializeNetworkFolder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOpenControlPanelToIUnknown*(x: ptr IOpenControlPanel): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIComputerInfoChangeNotifyToIUnknown*(x: ptr IComputerInfoChangeNotify): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileSystemBindDataToIUnknown*(x: ptr IFileSystemBindData): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileSystemBindData2ToIFileSystemBindData*(x: ptr IFileSystemBindData2): ptr IFileSystemBindData = cast[ptr IFileSystemBindData](x)
converter winimConverterIFileSystemBindData2ToIUnknown*(x: ptr IFileSystemBindData2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICustomDestinationListToIUnknown*(x: ptr ICustomDestinationList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIApplicationDestinationsToIUnknown*(x: ptr IApplicationDestinations): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIApplicationDocumentListsToIUnknown*(x: ptr IApplicationDocumentLists): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectWithAppUserModelIDToIUnknown*(x: ptr IObjectWithAppUserModelID): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectWithProgIDToIUnknown*(x: ptr IObjectWithProgID): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUpdateIDListToIUnknown*(x: ptr IUpdateIDList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDesktopGadgetToIUnknown*(x: ptr IDesktopGadget): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDesktopWallpaperToIUnknown*(x: ptr IDesktopWallpaper): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHomeGroupToIUnknown*(x: ptr IHomeGroup): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeWithPropertyStoreToIUnknown*(x: ptr IInitializeWithPropertyStore): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOpenSearchSourceToIUnknown*(x: ptr IOpenSearchSource): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellLibraryToIUnknown*(x: ptr IShellLibrary): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPlaybackManagerEventsToIUnknown*(x: ptr IPlaybackManagerEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPlaybackManagerToIUnknown*(x: ptr IPlaybackManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDefaultFolderMenuInitializeToIUnknown*(x: ptr IDefaultFolderMenuInitialize): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIApplicationActivationManagerToIUnknown*(x: ptr IApplicationActivationManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAssocHandlerInvokerToIUnknown*(x: ptr IAssocHandlerInvoker): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAssocHandlerToIUnknown*(x: ptr IAssocHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumAssocHandlersToIUnknown*(x: ptr IEnumAssocHandlers): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDataObjectProviderToIUnknown*(x: ptr IDataObjectProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDataTransferManagerInteropToIUnknown*(x: ptr IDataTransferManagerInterop): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFrameworkInputPaneHandlerToIUnknown*(x: ptr IFrameworkInputPaneHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFrameworkInputPaneToIUnknown*(x: ptr IFrameworkInputPane): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchableApplicationToIUnknown*(x: ptr ISearchableApplication): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccessibilityDockingServiceCallbackToIUnknown*(x: ptr IAccessibilityDockingServiceCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccessibilityDockingServiceToIUnknown*(x: ptr IAccessibilityDockingService): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAppVisibilityEventsToIUnknown*(x: ptr IAppVisibilityEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAppVisibilityToIUnknown*(x: ptr IAppVisibility): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPackageExecutionStateChangeNotificationToIUnknown*(x: ptr IPackageExecutionStateChangeNotification): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPackageDebugSettingsToIUnknown*(x: ptr IPackageDebugSettings): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExecuteCommandApplicationHostEnvironmentToIUnknown*(x: ptr IExecuteCommandApplicationHostEnvironment): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExecuteCommandHostToIUnknown*(x: ptr IExecuteCommandHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIApplicationDesignModeSettingsToIUnknown*(x: ptr IApplicationDesignModeSettings): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeWithWindowToIUnknown*(x: ptr IInitializeWithWindow): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHandlerInfoToIUnknown*(x: ptr IHandlerInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHandlerActivationHostToIUnknown*(x: ptr IHandlerActivationHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExtractIconAToIUnknown*(x: ptr IExtractIconA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExtractIconWToIUnknown*(x: ptr IExtractIconW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellIconOverlayIdentifierToIUnknown*(x: ptr IShellIconOverlayIdentifier): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellIconOverlayManagerToIUnknown*(x: ptr IShellIconOverlayManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellIconOverlayToIUnknown*(x: ptr IShellIconOverlay): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellExecuteHookAToIUnknown*(x: ptr IShellExecuteHookA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellExecuteHookWToIUnknown*(x: ptr IShellExecuteHookW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIURLSearchHookToIUnknown*(x: ptr IURLSearchHook): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchContextToIUnknown*(x: ptr ISearchContext): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIURLSearchHook2ToIURLSearchHook*(x: ptr IURLSearchHook2): ptr IURLSearchHook = cast[ptr IURLSearchHook](x)
converter winimConverterIURLSearchHook2ToIUnknown*(x: ptr IURLSearchHook2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINewShortcutHookAToIUnknown*(x: ptr INewShortcutHookA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINewShortcutHookWToIUnknown*(x: ptr INewShortcutHookW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICopyHookAToIUnknown*(x: ptr ICopyHookA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICopyHookWToIUnknown*(x: ptr ICopyHookW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileViewerSiteToIUnknown*(x: ptr IFileViewerSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileViewerAToIUnknown*(x: ptr IFileViewerA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFileViewerWToIUnknown*(x: ptr IFileViewerW): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellDetailsToIUnknown*(x: ptr IShellDetails): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjMgrToIUnknown*(x: ptr IObjMgr): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICurrentWorkingDirectoryToIUnknown*(x: ptr ICurrentWorkingDirectory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIACListToIUnknown*(x: ptr IACList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIACList2ToIACList*(x: ptr IACList2): ptr IACList = cast[ptr IACList](x)
converter winimConverterIACList2ToIUnknown*(x: ptr IACList2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProgressDialogToIUnknown*(x: ptr IProgressDialog): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDockingWindowSiteToIOleWindow*(x: ptr IDockingWindowSite): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIDockingWindowSiteToIUnknown*(x: ptr IDockingWindowSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDockingWindowFrameToIOleWindow*(x: ptr IDockingWindowFrame): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIDockingWindowFrameToIUnknown*(x: ptr IDockingWindowFrame): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIThumbnailCaptureToIUnknown*(x: ptr IThumbnailCapture): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumShellImageStoreToIUnknown*(x: ptr IEnumShellImageStore): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellImageStoreToIUnknown*(x: ptr IShellImageStore): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFolderBandToIUnknown*(x: ptr IShellFolderBand): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDeskBarClientToIOleWindow*(x: ptr IDeskBarClient): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIDeskBarClientToIUnknown*(x: ptr IDeskBarClient): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveDesktopToIUnknown*(x: ptr IActiveDesktop): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActiveDesktopPToIUnknown*(x: ptr IActiveDesktopP): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIADesktopP2ToIUnknown*(x: ptr IADesktopP2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIColumnProviderToIUnknown*(x: ptr IColumnProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellChangeNotifyToIUnknown*(x: ptr IShellChangeNotify): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIQueryInfoToIUnknown*(x: ptr IQueryInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDefViewFrameToIUnknown*(x: ptr IDefViewFrame): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDocViewSiteToIUnknown*(x: ptr IDocViewSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeObjectToIUnknown*(x: ptr IInitializeObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBanneredBarToIUnknown*(x: ptr IBanneredBar): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFolderViewCBToIUnknown*(x: ptr IShellFolderViewCB): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFolderViewToIUnknown*(x: ptr IShellFolderView): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINamedPropertyBagToIUnknown*(x: ptr INamedPropertyBag): ptr IUnknown = cast[ptr IUnknown](x)
when winimUnicode:
  type
    DRAGINFO* = DRAGINFOW
    LPDRAGINFO* = LPDRAGINFOW
    SHFILEOPSTRUCT* = SHFILEOPSTRUCTW
    LPSHFILEOPSTRUCT* = LPSHFILEOPSTRUCTW
    SHNAMEMAPPING* = SHNAMEMAPPINGW
    LPSHNAMEMAPPING* = LPSHNAMEMAPPINGW
    SHELLEXECUTEINFO* = SHELLEXECUTEINFOW
    LPSHELLEXECUTEINFO* = LPSHELLEXECUTEINFOW
    NOTIFYICONDATA* = NOTIFYICONDATAW
    PNOTIFYICONDATA* = PNOTIFYICONDATAW
    SHFILEINFO* = SHFILEINFOW
    OPEN_PRINTER_PROPS_INFO* = OPEN_PRINTER_PROPS_INFOW
    POPEN_PRINTER_PROPS_INFO* = POPEN_PRINTER_PROPS_INFOW
    IExtractIcon* = IExtractIconW
    LPEXTRACTICON* = LPEXTRACTICONW
    IShellExecuteHook* = IShellExecuteHookW
    INewShortcutHook* = INewShortcutHookW
    ICopyHook* = ICopyHookW
    LPCOPYHOOK* = LPCOPYHOOKW
    IFileViewer* = IFileViewerW
    LPFILEVIEWER* = LPFILEVIEWERW
    BROWSEINFO* = BROWSEINFOW
    PBROWSEINFO* = PBROWSEINFOW
    LPBROWSEINFO* = LPBROWSEINFOW
    FILEDESCRIPTOR* = FILEDESCRIPTORW
    LPFILEDESCRIPTOR* = LPFILEDESCRIPTORW
    FILEGROUPDESCRIPTOR* = FILEGROUPDESCRIPTORW
    LPFILEGROUPDESCRIPTOR* = LPFILEGROUPDESCRIPTORW
  const
    SZ_CONTENTTYPE_HTML* = SZ_CONTENTTYPE_HTMLW
    SZ_CONTENTTYPE_CDF* = SZ_CONTENTTYPE_CDFW
    IID_IFileViewer* = IID_IFileViewerW
    IID_IShellLink* = IID_IShellLinkW
    IID_IExtractIcon* = IID_IExtractIconW
    IID_IShellCopyHook* = IID_IShellCopyHookW
    IID_IShellExecuteHook* = IID_IShellExecuteHookW
    IID_INewShortcutHook* = IID_INewShortcutHookW
    IID_IUniformResourceLocator* = IID_IUniformResourceLocatorW
    GCS_VERB* = GCS_VERBW
    GCS_HELPTEXT* = GCS_HELPTEXTW
    GCS_VALIDATE* = GCS_VALIDATEW
    CMDSTR_NEWFOLDER* = CMDSTR_NEWFOLDERW
    CMDSTR_VIEWLIST* = CMDSTR_VIEWLISTW
    CMDSTR_VIEWDETAILS* = CMDSTR_VIEWDETAILSW
    BFFM_SETSTATUSTEXT* = BFFM_SETSTATUSTEXTW
    BFFM_SETSELECTION* = BFFM_SETSELECTIONW
    BFFM_VALIDATEFAILED* = BFFM_VALIDATEFAILEDW
    CFSTR_FILEDESCRIPTOR* = CFSTR_FILEDESCRIPTORW
    CFSTR_FILENAME* = CFSTR_FILENAMEW
    CFSTR_FILENAMEMAP* = CFSTR_FILENAMEMAPW
    CFSTR_INETURL* = CFSTR_INETURLW
    SHCNF_PATH* = SHCNF_PATHW
    SHCNF_PRINTER* = SHCNF_PRINTERW
    SHARD_PATH* = SHARD_PATHW
  proc StrFormatByteSize64*(qdw: LONGLONG, szBuf: LPWSTR, uiBufSize: UINT): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrFormatByteSizeW".}
  proc StrCat*(psz1: LPWSTR, psz2: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCatW".}
  proc StrCmp*(psz1: LPCWSTR, psz2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpW".}
  proc StrCmpI*(psz1: LPCWSTR, psz2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpIW".}
  proc StrCpy*(psz1: LPWSTR, psz2: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCpyW".}
  proc StrCpyN*(psz1: LPWSTR, psz2: LPCWSTR, cchMax: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCpyNW".}
  proc DragQueryFile*(hDrop: HDROP, iFile: UINT, lpszFile: LPWSTR, cch: UINT): UINT {.winapi, stdcall, dynlib: "shell32", importc: "DragQueryFileW".}
  proc ShellExecute*(hwnd: HWND, lpOperation: LPCWSTR, lpFile: LPCWSTR, lpParameters: LPCWSTR, lpDirectory: LPCWSTR, nShowCmd: INT): HINSTANCE {.winapi, stdcall, dynlib: "shell32", importc: "ShellExecuteW".}
  proc FindExecutable*(lpFile: LPCWSTR, lpDirectory: LPCWSTR, lpResult: LPWSTR): HINSTANCE {.winapi, stdcall, dynlib: "shell32", importc: "FindExecutableW".}
  proc ShellAbout*(hWnd: HWND, szApp: LPCWSTR, szOtherStuff: LPCWSTR, hIcon: HICON): INT {.winapi, stdcall, dynlib: "shell32", importc: "ShellAboutW".}
  proc ExtractAssociatedIcon*(hInst: HINSTANCE, pszIconPath: LPWSTR, piIcon: ptr WORD): HICON {.winapi, stdcall, dynlib: "shell32", importc: "ExtractAssociatedIconW".}
  proc ExtractAssociatedIconEx*(hInst: HINSTANCE, pszIconPath: LPWSTR, piIconIndex: ptr WORD, piIconId: ptr WORD): HICON {.winapi, stdcall, dynlib: "shell32", importc: "ExtractAssociatedIconExW".}
  proc ExtractIcon*(hInst: HINSTANCE, pszExeFileName: LPCWSTR, nIconIndex: UINT): HICON {.winapi, stdcall, dynlib: "shell32", importc: "ExtractIconW".}
  proc DoEnvironmentSubst*(pszSrc: LPWSTR, cchSrc: UINT): DWORD {.winapi, stdcall, dynlib: "shell32", importc: "DoEnvironmentSubstW".}
  proc ExtractIconEx*(lpszFile: LPCWSTR, nIconIndex: int32, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIcons: UINT): UINT {.winapi, stdcall, dynlib: "shell32", importc: "ExtractIconExW".}
  proc SHFileOperation*(lpFileOp: LPSHFILEOPSTRUCTW): int32 {.winapi, stdcall, dynlib: "shell32", importc: "SHFileOperationW".}
  proc ShellExecuteEx*(pExecInfo: ptr SHELLEXECUTEINFOW): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "ShellExecuteExW".}
  proc SHQueryRecycleBin*(pszRootPath: LPCWSTR, pSHQueryRBInfo: LPSHQUERYRBINFO): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHQueryRecycleBinW".}
  proc SHEmptyRecycleBin*(hwnd: HWND, pszRootPath: LPCWSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHEmptyRecycleBinW".}
  proc Shell_NotifyIcon*(dwMessage: DWORD, lpData: PNOTIFYICONDATAW): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "Shell_NotifyIconW".}
  proc SHGetFileInfo*(pszPath: LPCWSTR, dwFileAttributes: DWORD, psfi: ptr SHFILEINFOW, cbFileInfo: UINT, uFlags: UINT): DWORD_PTR {.winapi, stdcall, dynlib: "shell32", importc: "SHGetFileInfoW".}
  proc SHGetDiskFreeSpace*(pszDirectoryName: LPCWSTR, pulFreeBytesAvailableToCaller: ptr ULARGE_INTEGER, pulTotalNumberOfBytes: ptr ULARGE_INTEGER, pulTotalNumberOfFreeBytes: ptr ULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetDiskFreeSpaceExW".}
  proc SHGetDiskFreeSpaceEx*(pszDirectoryName: LPCWSTR, pulFreeBytesAvailableToCaller: ptr ULARGE_INTEGER, pulTotalNumberOfBytes: ptr ULARGE_INTEGER, pulTotalNumberOfFreeBytes: ptr ULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetDiskFreeSpaceExW".}
  proc SHGetNewLinkInfo*(pszLinkTo: LPCWSTR, pszDir: LPCWSTR, pszName: LPWSTR, pfMustCopy: ptr WINBOOL, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetNewLinkInfoW".}
  proc SHInvokePrinterCommand*(hwnd: HWND, uAction: UINT, lpBuf1: LPCWSTR, lpBuf2: LPCWSTR, fModal: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHInvokePrinterCommandW".}
  proc ShellMessageBox*(hAppInst: HINSTANCE, hWnd: HWND, lpcText: LPCWSTR, lpcTitle: LPCWSTR, fuStyle: UINT): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "ShellMessageBoxW".}
  proc IsLFNDrive*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "IsLFNDriveW".}
  proc SHEnumerateUnreadMailAccounts*(hKeyUser: HKEY, dwIndex: DWORD, pszMailAddress: LPWSTR, cchMailAddress: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHEnumerateUnreadMailAccountsW".}
  proc SHGetUnreadMailCount*(hKeyUser: HKEY, pszMailAddress: LPCWSTR, pdwCount: ptr DWORD, pFileTime: ptr FILETIME, pszShellExecuteCommand: LPWSTR, cchShellExecuteCommand: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHGetUnreadMailCountW".}
  proc SHSetUnreadMailCount*(pszMailAddress: LPCWSTR, dwCount: DWORD, pszShellExecuteCommand: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHSetUnreadMailCountW".}
  proc StrRetToStr*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, ppsz: ptr LPWSTR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRetToStrW".}
  proc StrRetToBuf*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, pszBuf: LPWSTR, cchBuf: UINT): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRetToBufW".}
  proc SHStrDup*(psz: LPCWSTR, ppwsz: ptr ptr WCHAR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "SHStrDupW".}
  proc IsCharSpace*(wch: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "IsCharSpaceW".}
  proc StrCmpC*(pszStr1: LPCWSTR, pszStr2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpCW".}
  proc StrCmpIC*(pszStr1: LPCWSTR, pszStr2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpICW".}
  proc StrChr*(lpStart: LPCWSTR, wMatch: WCHAR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrChrW".}
  proc StrRChr*(lpStart: LPCWSTR, lpEnd: LPCWSTR, wMatch: WCHAR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRChrW".}
  proc StrChrI*(lpStart: LPCWSTR, wMatch: WCHAR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrChrIW".}
  proc StrRChrI*(lpStart: LPCWSTR, lpEnd: LPCWSTR, wMatch: WCHAR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRChrIW".}
  proc StrCmpN*(lpStr1: LPCWSTR, lpStr2: LPCWSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpNW".}
  proc StrCmpNI*(lpStr1: LPCWSTR, lpStr2: LPCWSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpNIW".}
  proc StrStr*(lpFirst: LPCWSTR, lpSrch: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrStrW".}
  proc StrStrI*(lpFirst: LPCWSTR, lpSrch: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrStrIW".}
  proc StrDup*(lpSrch: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrDupW".}
  proc StrRStrI*(lpSource: LPCWSTR, lpLast: LPCWSTR, lpSrch: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRStrIW".}
  proc StrCSpn*(lpStr: LPCWSTR, lpSet: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCSpnW".}
  proc StrCSpnI*(lpStr: LPCWSTR, lpSet: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCSpnIW".}
  proc StrSpn*(psz: LPCWSTR, pszSet: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrSpnW".}
  proc StrToInt*(lpSrc: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrToIntW".}
  proc StrPBrk*(psz: LPCWSTR, pszSet: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrPBrkW".}
  proc StrToIntEx*(pszString: LPCWSTR, dwFlags: DWORD, piRet: ptr int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "StrToIntExW".}
  proc StrToInt64Ex*(pszString: LPCWSTR, dwFlags: DWORD, pllRet: ptr LONGLONG): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "StrToInt64ExW".}
  proc StrFromTimeInterval*(pszOut: LPWSTR, cchMax: UINT, dwTimeMS: DWORD, digits: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrFromTimeIntervalW".}
  proc StrFormatByteSize*(qdw: LONGLONG, szBuf: LPWSTR, uiBufSize: UINT): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrFormatByteSizeW".}
  proc StrFormatKBSize*(qdw: LONGLONG, szBuf: LPWSTR, uiBufSize: UINT): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrFormatKBSizeW".}
  proc StrNCat*(psz1: LPWSTR, psz2: LPCWSTR, cchMax: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrNCatW".}
  proc StrTrim*(psz: LPWSTR, pszTrimChars: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "StrTrimW".}
  proc StrCatBuff*(pszDest: LPWSTR, pszSrc: LPCWSTR, cchDestBuffSize: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCatBuffW".}
  proc ChrCmpI*(w1: WCHAR, w2: WCHAR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "ChrCmpIW".}
  proc wvnsprintf*(lpOut: LPWSTR, cchLimitIn: int32, lpFmt: LPCWSTR, arglist: va_list): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "wvnsprintfW".}
  proc wnsprintf*(lpOut: LPWSTR, cchLimitIn: int32, lpFmt: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "wnsprintfW".}
  proc StrIsIntlEqual*(fCaseSens: WINBOOL, lpString1: LPCWSTR, lpString2: LPCWSTR, nChar: int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "StrIsIntlEqualW".}
  proc StrToLong*(lpSrc: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrToIntW".}
  proc StrNCmp*(lpStr1: LPCWSTR, lpStr2: LPCWSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpNW".}
  proc StrNCmpI*(lpStr1: LPCWSTR, lpStr2: LPCWSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpNIW".}
  proc StrNCpy*(psz1: LPWSTR, psz2: LPCWSTR, cchMax: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCpyNW".}
  proc StrCatN*(psz1: LPWSTR, psz2: LPCWSTR, cchMax: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrNCatW".}
  proc PathAddBackslash*(pszPath: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathAddBackslashW".}
  proc PathAddExtension*(pszPath: LPWSTR, pszExt: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathAddExtensionW".}
  proc PathBuildRoot*(pszRoot: LPWSTR, iDrive: int32): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathBuildRootW".}
  proc PathCombine*(pszDest: LPWSTR, pszDir: LPCWSTR, pszFile: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCombineW".}
  proc PathFileExists*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFileExistsW".}
  proc PathFindExtension*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindExtensionW".}
  proc PathFindFileName*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindFileNameW".}
  proc PathFindNextComponent*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindNextComponentW".}
  proc PathGetArgs*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathGetArgsW".}
  proc PathFindSuffixArray*(pszPath: LPCWSTR, apszSuffix: ptr LPCWSTR, iArraySize: int32): LPCWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindSuffixArrayW".}
  proc PathIsLFNFileSpec*(lpName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsLFNFileSpecW".}
  proc PathGetDriveNumber*(pszPath: LPCWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "PathGetDriveNumberW".}
  proc PathIsDirectory*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsDirectoryW".}
  proc PathIsDirectoryEmpty*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsDirectoryEmptyW".}
  proc PathIsFileSpec*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsFileSpecW".}
  proc PathIsPrefix*(pszPrefix: LPCWSTR, pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsPrefixW".}
  proc PathIsRelative*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsRelativeW".}
  proc PathIsRoot*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsRootW".}
  proc PathIsSameRoot*(pszPath1: LPCWSTR, pszPath2: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsSameRootW".}
  proc PathIsUNC*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsUNCW".}
  proc PathIsNetworkPath*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsNetworkPathW".}
  proc PathIsUNCServer*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsUNCServerW".}
  proc PathIsUNCServerShare*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsUNCServerShareW".}
  proc PathIsURL*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsURLW".}
  proc PathRemoveBackslash*(pszPath: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveBackslashW".}
  proc PathSkipRoot*(pszPath: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathSkipRootW".}
  proc PathStripPath*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathStripPathW".}
  proc PathStripToRoot*(pszPath: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathStripToRootW".}
  proc PathMakeSystemFolder*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathMakeSystemFolderW".}
  proc PathUnmakeSystemFolder*(pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathUnmakeSystemFolderW".}
  proc PathIsSystemFolder*(pszPath: LPCWSTR, dwAttrb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsSystemFolderW".}
  proc PathUndecorate*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathUndecorateW".}
  proc PathUnExpandEnvStrings*(pszPath: LPCWSTR, pszBuf: LPWSTR, cchBuf: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathUnExpandEnvStringsW".}
  proc PathAppend*(pszPath: LPWSTR, pMore: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathAppendW".}
  proc PathCanonicalize*(pszBuf: LPWSTR, pszPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCanonicalizeW".}
  proc PathCompactPath*(hDC: HDC, pszPath: LPWSTR, dx: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCompactPathW".}
  proc PathCompactPathEx*(pszOut: LPWSTR, pszSrc: LPCWSTR, cchMax: UINT, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCompactPathExW".}
  proc PathCommonPrefix*(pszFile1: LPCWSTR, pszFile2: LPCWSTR, achPath: LPWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCommonPrefixW".}
  proc PathFindOnPath*(pszPath: LPWSTR, ppszOtherDirs: ptr LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindOnPathW".}
  proc PathGetCharType*(ch: WCHAR): UINT {.winapi, stdcall, dynlib: "shlwapi", importc: "PathGetCharTypeW".}
  proc PathIsContentType*(pszPath: LPCWSTR, pszContentType: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsContentTypeW".}
  proc PathMakePretty*(pszPath: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathMakePrettyW".}
  proc PathMatchSpec*(pszFile: LPCWSTR, pszSpec: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathMatchSpecW".}
  proc PathParseIconLocation*(pszIconFile: LPWSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "PathParseIconLocationW".}
  proc PathQuoteSpaces*(lpsz: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathQuoteSpacesW".}
  proc PathRelativePathTo*(pszPath: LPWSTR, pszFrom: LPCWSTR, dwAttrFrom: DWORD, pszTo: LPCWSTR, dwAttrTo: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRelativePathToW".}
  proc PathRemoveArgs*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveArgsW".}
  proc PathRemoveBlanks*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveBlanksW".}
  proc PathRemoveExtension*(pszPath: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveExtensionW".}
  proc PathRemoveFileSpec*(pszPath: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveFileSpecW".}
  proc PathRenameExtension*(pszPath: LPWSTR, pszExt: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRenameExtensionW".}
  proc PathSearchAndQualify*(pszPath: LPCWSTR, pszBuf: LPWSTR, cchBuf: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathSearchAndQualifyW".}
  proc PathSetDlgItemPath*(hDlg: HWND, id: int32, pszPath: LPCWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathSetDlgItemPathW".}
  proc PathUnquoteSpaces*(lpsz: LPWSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathUnquoteSpacesW".}
  proc UrlCompare*(psz1: LPCWSTR, psz2: LPCWSTR, fIgnoreSlash: WINBOOL): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlCompareW".}
  proc UrlCombine*(pszBase: LPCWSTR, pszRelative: LPCWSTR, pszCombined: LPWSTR, pcchCombined: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlCombineW".}
  proc UrlCanonicalize*(pszUrl: LPCWSTR, pszCanonicalized: LPWSTR, pcchCanonicalized: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlCanonicalizeW".}
  proc UrlIsOpaque*(pszURL: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlIsOpaqueW".}
  proc UrlGetLocation*(psz1: LPCWSTR): LPCWSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlGetLocationW".}
  proc UrlUnescape*(pszUrl: LPWSTR, pszUnescaped: LPWSTR, pcchUnescaped: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlUnescapeW".}
  proc UrlEscape*(pszUrl: LPCWSTR, pszEscaped: LPWSTR, pcchEscaped: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlEscapeW".}
  proc UrlCreateFromPath*(pszPath: LPCWSTR, pszUrl: LPWSTR, pcchUrl: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlCreateFromPathW".}
  proc PathCreateFromUrl*(pszUrl: LPCWSTR, pszPath: LPWSTR, pcchPath: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCreateFromUrlW".}
  proc UrlHash*(pszUrl: LPCWSTR, pbHash: LPBYTE, cbHash: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlHashW".}
  proc UrlGetPart*(pszIn: LPCWSTR, pszOut: LPWSTR, pcchOut: LPDWORD, dwPart: DWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlGetPartW".}
  proc UrlApplyScheme*(pszIn: LPCWSTR, pszOut: LPWSTR, pcchOut: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlApplySchemeW".}
  proc UrlIs*(pszUrl: LPCWSTR, UrlIs: TURLIS): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlIsW".}
  proc SHDeleteEmptyKey*(hkey: HKEY, pszSubKey: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHDeleteEmptyKeyW".}
  proc SHDeleteKey*(hkey: HKEY, pszSubKey: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHDeleteKeyW".}
  proc SHDeleteValue*(hkey: HKEY, pszSubKey: LPCWSTR, pszValue: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHDeleteValueW".}
  proc SHGetValue*(hkey: HKEY, pszSubKey: LPCWSTR, pszValue: LPCWSTR, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHGetValueW".}
  proc SHSetValue*(hkey: HKEY, pszSubKey: LPCWSTR, pszValue: LPCWSTR, dwType: DWORD, pvData: LPCVOID, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHSetValueW".}
  proc SHRegGetValue*(hkey: HKEY, pszSubKey: LPCWSTR, pszValue: LPCWSTR, dwFlags: SRRF, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetValueW".}
  proc SHQueryValueEx*(hkey: HKEY, pszValue: LPCWSTR, pdwReserved: ptr DWORD, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHQueryValueExW".}
  proc SHEnumKeyEx*(hkey: HKEY, dwIndex: DWORD, pszName: LPWSTR, pcchName: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHEnumKeyExW".}
  proc SHEnumValue*(hkey: HKEY, dwIndex: DWORD, pszValueName: LPWSTR, pcchValueName: LPDWORD, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHEnumValueW".}
  proc SHQueryInfoKey*(hkey: HKEY, pcSubKeys: LPDWORD, pcchMaxSubKeyLen: LPDWORD, pcValues: LPDWORD, pcchMaxValueNameLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHQueryInfoKeyW".}
  proc SHCopyKey*(hkeySrc: HKEY, wszSrcSubKey: LPCWSTR, hkeyDest: HKEY, fReserved: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHCopyKeyW".}
  proc SHRegGetPath*(hKey: HKEY, pcszSubKey: LPCWSTR, pcszValue: LPCWSTR, pszPath: LPWSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetPathW".}
  proc SHRegSetPath*(hKey: HKEY, pcszSubKey: LPCWSTR, pcszValue: LPCWSTR, pcszPath: LPCWSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegSetPathW".}
  proc SHRegCreateUSKey*(pwzPath: LPCWSTR, samDesired: REGSAM, hRelativeUSKey: HUSKEY, phNewUSKey: PHUSKEY, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegCreateUSKeyW".}
  proc SHRegOpenUSKey*(pwzPath: LPCWSTR, samDesired: REGSAM, hRelativeUSKey: HUSKEY, phNewUSKey: PHUSKEY, fIgnoreHKCU: WINBOOL): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegOpenUSKeyW".}
  proc SHRegQueryUSValue*(hUSKey: HUSKEY, pwzValue: LPCWSTR, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, fIgnoreHKCU: WINBOOL, pvDefaultData: pointer, dwDefaultDataSize: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegQueryUSValueW".}
  proc SHRegWriteUSValue*(hUSKey: HUSKEY, pwzValue: LPCWSTR, dwType: DWORD, pvData: pointer, cbData: DWORD, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegWriteUSValueW".}
  proc SHRegDeleteUSValue*(hUSKey: HUSKEY, pwzValue: LPCWSTR, delRegFlags: SHREGDEL_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegDeleteUSValueW".}
  proc SHRegDeleteEmptyUSKey*(hUSKey: HUSKEY, pwzSubKey: LPCWSTR, delRegFlags: SHREGDEL_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegDeleteEmptyUSKeyW".}
  proc SHRegEnumUSKey*(hUSKey: HUSKEY, dwIndex: DWORD, pwzName: LPWSTR, pcchName: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegEnumUSKeyW".}
  proc SHRegEnumUSValue*(hUSkey: HUSKEY, dwIndex: DWORD, pszValueName: LPWSTR, pcchValueName: LPDWORD, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegEnumUSValueW".}
  proc SHRegQueryInfoUSKey*(hUSKey: HUSKEY, pcSubKeys: LPDWORD, pcchMaxSubKeyLen: LPDWORD, pcValues: LPDWORD, pcchMaxValueNameLen: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegQueryInfoUSKeyW".}
  proc SHRegGetUSValue*(pwzSubKey: LPCWSTR, pwzValue: LPCWSTR, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, fIgnoreHKCU: WINBOOL, pvDefaultData: pointer, dwDefaultDataSize: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetUSValueW".}
  proc SHRegSetUSValue*(pwzSubKey: LPCWSTR, pwzValue: LPCWSTR, dwType: DWORD, pvData: pointer, cbData: DWORD, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegSetUSValueW".}
  proc SHRegGetInt*(hk: HKEY, pwzKey: LPCWSTR, iDefault: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetIntW".}
  proc SHRegGetBoolUSValue*(pszSubKey: LPCWSTR, pszValue: LPCWSTR, fIgnoreHKCU: WINBOOL, fDefault: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetBoolUSValueW".}
  proc AssocQueryString*(flags: ASSOCF, str: ASSOCSTR, pszAssoc: LPCWSTR, pszExtra: LPCWSTR, pszOut: LPWSTR, pcchOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "AssocQueryStringW".}
  proc AssocQueryStringByKey*(flags: ASSOCF, str: ASSOCSTR, hkAssoc: HKEY, pszExtra: LPCWSTR, pszOut: LPWSTR, pcchOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "AssocQueryStringByKeyW".}
  proc AssocQueryKey*(flags: ASSOCF, key: ASSOCKEY, pszAssoc: LPCWSTR, pszExtra: LPCWSTR, phkeyOut: ptr HKEY): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "AssocQueryKeyW".}
  proc SHOpenRegStream2*(hkey: HKEY, pszSubkey: LPCWSTR, pszValue: LPCWSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shlwapi", importc: "SHOpenRegStream2W".}
  proc SHCreateStreamOnFile*(pszFile: LPCWSTR, grfMode: DWORD, ppstm: ptr ptr IStream): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "SHCreateStreamOnFileW".}
  proc SHOpenRegStream*(hkey: HKEY, pszSubkey: LPCWSTR, pszValue: LPCWSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shlwapi", importc: "SHOpenRegStream2W".}
  proc GetAcceptLanguages*(psz: LPWSTR, pcch: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "GetAcceptLanguagesW".}
  proc SHGetIconOverlayIndex*(pszIconPath: LPCWSTR, iIconIndex: int32): int32 {.winapi, stdcall, dynlib: "shell32", importc: "SHGetIconOverlayIndexW".}
  proc ILCreateFromPath*(pszPath: PCWSTR): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc: "ILCreateFromPathW".}
  proc SHGetPathFromIDList*(pidl: PCIDLIST_ABSOLUTE, pszPath: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetPathFromIDListW".}
  proc SHCreateDirectoryEx*(hwnd: HWND, pszPath: LPCWSTR, psa: ptr SECURITY_ATTRIBUTES): int32 {.winapi, stdcall, dynlib: "shell32", importc: "SHCreateDirectoryExW".}
  proc SHGetSpecialFolderPath*(hwnd: HWND, pszPath: LPWSTR, csidl: int32, fCreate: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetSpecialFolderPathW".}
  proc SHGetFolderPath*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszPath: LPWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHGetFolderPathW".}
  proc SHSetFolderPath*(csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszPath: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHSetFolderPathW".}
  proc SHGetFolderPathAndSubDir*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszSubDir: LPCWSTR, pszPath: LPWSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHGetFolderPathAndSubDirW".}
  proc SHBrowseForFolder*(lpbi: LPBROWSEINFOW): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc: "SHBrowseForFolderW".}
  proc SHUpdateImage*(pszHashItem: LPCWSTR, iIndex: int32, uFlags: UINT, iImageIndex: int32): void {.winapi, stdcall, dynlib: "shell32", importc: "SHUpdateImageW".}
  proc SHGetDataFromIDList*(psf: ptr IShellFolder, pidl: PCUITEMID_CHILD, nFormat: int32, pv: pointer, cb: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHGetDataFromIDListW".}
  proc PathIsSlow*(pszFile: LPCWSTR, dwAttr: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "PathIsSlowW".}
  proc SHStartNetConnectionDialog*(hwnd: HWND, pszRemoteName: LPCWSTR, dwType: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHStartNetConnectionDialogW".}
  proc SHDefExtractIcon*(pszIconFile: LPCWSTR, iIndex: int32, uFlags: UINT, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIconSize: UINT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHDefExtractIconW".}
  proc Shell_GetCachedImageIndex*(pszIconPath: LPCWSTR, iIconIndex: int32, uIconFlags: UINT): int32 {.winapi, stdcall, dynlib: "shell32", importc: "Shell_GetCachedImageIndexW".}
  proc SHOpenPropSheet*(pszCaption: LPCWSTR, ahkeys: ptr HKEY, ckeys: UINT, pclsidDefault: ptr CLSID, pdtobj: ptr IDataObject, psb: ptr IShellBrowser, pStartPage: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHOpenPropSheetW".}
  proc SHPathPrepareForWrite*(hwnd: HWND, punkEnableModless: ptr IUnknown, pszPath: LPCWSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHPathPrepareForWriteW".}
  proc SHCreateFileExtractIcon*(pszFile: LPCWSTR, dwFileAttributes: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHCreateFileExtractIconW".}
when winimAnsi:
  type
    DRAGINFO* = DRAGINFOA
    LPDRAGINFO* = LPDRAGINFOA
    SHFILEOPSTRUCT* = SHFILEOPSTRUCTA
    LPSHFILEOPSTRUCT* = LPSHFILEOPSTRUCTA
    SHNAMEMAPPING* = SHNAMEMAPPINGA
    LPSHNAMEMAPPING* = LPSHNAMEMAPPINGA
    SHELLEXECUTEINFO* = SHELLEXECUTEINFOA
    LPSHELLEXECUTEINFO* = LPSHELLEXECUTEINFOA
    NOTIFYICONDATA* = NOTIFYICONDATAA
    PNOTIFYICONDATA* = PNOTIFYICONDATAA
    SHFILEINFO* = SHFILEINFOA
    OPEN_PRINTER_PROPS_INFO* = OPEN_PRINTER_PROPS_INFOA
    POPEN_PRINTER_PROPS_INFO* = POPEN_PRINTER_PROPS_INFOA
    IExtractIcon* = IExtractIconA
    LPEXTRACTICON* = LPEXTRACTICONA
    IShellExecuteHook* = IShellExecuteHookA
    INewShortcutHook* = INewShortcutHookA
    ICopyHook* = ICopyHookA
    LPCOPYHOOK* = LPCOPYHOOKA
    IFileViewer* = IFileViewerA
    LPFILEVIEWER* = LPFILEVIEWERA
    BROWSEINFO* = BROWSEINFOA
    PBROWSEINFO* = PBROWSEINFOA
    LPBROWSEINFO* = LPBROWSEINFOA
    FILEDESCRIPTOR* = FILEDESCRIPTORA
    LPFILEDESCRIPTOR* = LPFILEDESCRIPTORA
    FILEGROUPDESCRIPTOR* = FILEGROUPDESCRIPTORA
    LPFILEGROUPDESCRIPTOR* = LPFILEGROUPDESCRIPTORA
  const
    SZ_CONTENTTYPE_HTML* = SZ_CONTENTTYPE_HTMLA
    SZ_CONTENTTYPE_CDF* = SZ_CONTENTTYPE_CDFA
    IID_IFileViewer* = IID_IFileViewerA
    IID_IShellLink* = IID_IShellLinkA
    IID_IExtractIcon* = IID_IExtractIconA
    IID_IShellCopyHook* = IID_IShellCopyHookA
    IID_IShellExecuteHook* = IID_IShellExecuteHookA
    IID_INewShortcutHook* = IID_INewShortcutHookA
    IID_IUniformResourceLocator* = IID_IUniformResourceLocatorA
    GCS_VERB* = GCS_VERBA
    GCS_HELPTEXT* = GCS_HELPTEXTA
    GCS_VALIDATE* = GCS_VALIDATEA
    CMDSTR_NEWFOLDER* = CMDSTR_NEWFOLDERA
    CMDSTR_VIEWLIST* = CMDSTR_VIEWLISTA
    CMDSTR_VIEWDETAILS* = CMDSTR_VIEWDETAILSA
    BFFM_SETSTATUSTEXT* = BFFM_SETSTATUSTEXTA
    BFFM_SETSELECTION* = BFFM_SETSELECTIONA
    BFFM_VALIDATEFAILED* = BFFM_VALIDATEFAILEDA
    CFSTR_FILEDESCRIPTOR* = CFSTR_FILEDESCRIPTORA
    CFSTR_FILENAME* = CFSTR_FILENAMEA
    CFSTR_FILENAMEMAP* = CFSTR_FILENAMEMAPA
    CFSTR_INETURL* = CFSTR_INETURLA
    SHCNF_PATH* = SHCNF_PATHA
    SHCNF_PRINTER* = SHCNF_PRINTERA
    SHARD_PATH* = SHARD_PATHA
  proc StrFormatByteSize64*(qdw: LONGLONG, szBuf: LPSTR, uiBufSize: UINT): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrFormatByteSize64A".}
  proc DragQueryFile*(hDrop: HDROP, iFile: UINT, lpszFile: LPSTR, cch: UINT): UINT {.winapi, stdcall, dynlib: "shell32", importc: "DragQueryFileA".}
  proc ShellExecute*(hwnd: HWND, lpOperation: LPCSTR, lpFile: LPCSTR, lpParameters: LPCSTR, lpDirectory: LPCSTR, nShowCmd: INT): HINSTANCE {.winapi, stdcall, dynlib: "shell32", importc: "ShellExecuteA".}
  proc FindExecutable*(lpFile: LPCSTR, lpDirectory: LPCSTR, lpResult: LPSTR): HINSTANCE {.winapi, stdcall, dynlib: "shell32", importc: "FindExecutableA".}
  proc ShellAbout*(hWnd: HWND, szApp: LPCSTR, szOtherStuff: LPCSTR, hIcon: HICON): INT {.winapi, stdcall, dynlib: "shell32", importc: "ShellAboutA".}
  proc ExtractAssociatedIcon*(hInst: HINSTANCE, pszIconPath: LPSTR, piIcon: ptr WORD): HICON {.winapi, stdcall, dynlib: "shell32", importc: "ExtractAssociatedIconA".}
  proc ExtractAssociatedIconEx*(hInst: HINSTANCE, pszIconPath: LPSTR, piIconIndex: ptr WORD, piIconId: ptr WORD): HICON {.winapi, stdcall, dynlib: "shell32", importc: "ExtractAssociatedIconExA".}
  proc ExtractIcon*(hInst: HINSTANCE, pszExeFileName: LPCSTR, nIconIndex: UINT): HICON {.winapi, stdcall, dynlib: "shell32", importc: "ExtractIconA".}
  proc DoEnvironmentSubst*(pszSrc: LPSTR, cchSrc: UINT): DWORD {.winapi, stdcall, dynlib: "shell32", importc: "DoEnvironmentSubstA".}
  proc ExtractIconEx*(lpszFile: LPCSTR, nIconIndex: int32, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIcons: UINT): UINT {.winapi, stdcall, dynlib: "shell32", importc: "ExtractIconExA".}
  proc SHFileOperation*(lpFileOp: LPSHFILEOPSTRUCTA): int32 {.winapi, stdcall, dynlib: "shell32", importc: "SHFileOperationA".}
  proc ShellExecuteEx*(pExecInfo: ptr SHELLEXECUTEINFOA): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "ShellExecuteExA".}
  proc SHQueryRecycleBin*(pszRootPath: LPCSTR, pSHQueryRBInfo: LPSHQUERYRBINFO): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHQueryRecycleBinA".}
  proc SHEmptyRecycleBin*(hwnd: HWND, pszRootPath: LPCSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHEmptyRecycleBinA".}
  proc Shell_NotifyIcon*(dwMessage: DWORD, lpData: PNOTIFYICONDATAA): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "Shell_NotifyIconA".}
  proc SHGetFileInfo*(pszPath: LPCSTR, dwFileAttributes: DWORD, psfi: ptr SHFILEINFOA, cbFileInfo: UINT, uFlags: UINT): DWORD_PTR {.winapi, stdcall, dynlib: "shell32", importc: "SHGetFileInfoA".}
  proc SHGetDiskFreeSpace*(pszDirectoryName: LPCSTR, pulFreeBytesAvailableToCaller: ptr ULARGE_INTEGER, pulTotalNumberOfBytes: ptr ULARGE_INTEGER, pulTotalNumberOfFreeBytes: ptr ULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetDiskFreeSpaceExA".}
  proc SHGetDiskFreeSpaceEx*(pszDirectoryName: LPCSTR, pulFreeBytesAvailableToCaller: ptr ULARGE_INTEGER, pulTotalNumberOfBytes: ptr ULARGE_INTEGER, pulTotalNumberOfFreeBytes: ptr ULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetDiskFreeSpaceExA".}
  proc SHGetNewLinkInfo*(pszLinkTo: LPCSTR, pszDir: LPCSTR, pszName: LPSTR, pfMustCopy: ptr WINBOOL, uFlags: UINT): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetNewLinkInfoA".}
  proc SHInvokePrinterCommand*(hwnd: HWND, uAction: UINT, lpBuf1: LPCSTR, lpBuf2: LPCSTR, fModal: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHInvokePrinterCommandA".}
  proc ShellMessageBox*(hAppInst: HINSTANCE, hWnd: HWND, lpcText: LPCSTR, lpcTitle: LPCSTR, fuStyle: UINT): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "ShellMessageBoxA".}
  proc IsLFNDrive*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "IsLFNDriveA".}
  proc StrRetToStr*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, ppsz: ptr LPSTR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRetToStrA".}
  proc StrRetToBuf*(pstr: ptr STRRET, pidl: LPCITEMIDLIST, pszBuf: LPSTR, cchBuf: UINT): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRetToBufA".}
  proc SHStrDup*(psz: LPCSTR, ppwsz: ptr ptr WCHAR): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "SHStrDupA".}
  proc IsCharSpace*(wch: CHAR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "IsCharSpaceA".}
  proc StrCmpC*(pszStr1: LPCSTR, pszStr2: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpCA".}
  proc StrCmpIC*(pszStr1: LPCSTR, pszStr2: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpICA".}
  proc StrChr*(lpStart: LPCSTR, wMatch: WORD): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrChrA".}
  proc StrRChr*(lpStart: LPCSTR, lpEnd: LPCSTR, wMatch: WORD): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRChrA".}
  proc StrChrI*(lpStart: LPCSTR, wMatch: WORD): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrChrIA".}
  proc StrRChrI*(lpStart: LPCSTR, lpEnd: LPCSTR, wMatch: WORD): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRChrIA".}
  proc StrCmpN*(lpStr1: LPCSTR, lpStr2: LPCSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpNA".}
  proc StrCmpNI*(lpStr1: LPCSTR, lpStr2: LPCSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpNIA".}
  proc StrStr*(lpFirst: LPCSTR, lpSrch: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrStrA".}
  proc StrStrI*(lpFirst: LPCSTR, lpSrch: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrStrIA".}
  proc StrDup*(lpSrch: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrDupA".}
  proc StrRStrI*(lpSource: LPCSTR, lpLast: LPCSTR, lpSrch: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrRStrIA".}
  proc StrCSpn*(lpStr: LPCSTR, lpSet: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCSpnA".}
  proc StrCSpnI*(lpStr: LPCSTR, lpSet: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCSpnIA".}
  proc StrSpn*(psz: LPCSTR, pszSet: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrSpnA".}
  proc StrToInt*(lpSrc: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrToIntA".}
  proc StrPBrk*(psz: LPCSTR, pszSet: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrPBrkA".}
  proc StrToIntEx*(pszString: LPCSTR, dwFlags: DWORD, piRet: ptr int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "StrToIntExA".}
  proc StrToInt64Ex*(pszString: LPCSTR, dwFlags: DWORD, pllRet: ptr LONGLONG): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "StrToInt64ExA".}
  proc StrFromTimeInterval*(pszOut: LPSTR, cchMax: UINT, dwTimeMS: DWORD, digits: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrFromTimeIntervalA".}
  proc StrFormatByteSize*(dw: DWORD, szBuf: LPSTR, uiBufSize: UINT): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrFormatByteSizeA".}
  proc StrFormatKBSize*(qdw: LONGLONG, szBuf: LPSTR, uiBufSize: UINT): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrFormatKBSizeA".}
  proc StrNCat*(psz1: LPSTR, psz2: LPCSTR, cchMax: int32): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrNCatA".}
  proc StrTrim*(psz: LPSTR, pszTrimChars: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "StrTrimA".}
  proc StrCatBuff*(pszDest: LPSTR, pszSrc: LPCSTR, cchDestBuffSize: int32): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCatBuffA".}
  proc ChrCmpI*(w1: WORD, w2: WORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "ChrCmpIA".}
  proc wvnsprintf*(lpOut: LPSTR, cchLimitIn: int32, lpFmt: LPCSTR, arglist: va_list): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "wvnsprintfA".}
  proc wnsprintf*(lpOut: LPSTR, cchLimitIn: int32, lpFmt: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "wnsprintfA".}
  proc StrIsIntlEqual*(fCaseSens: WINBOOL, lpString1: LPCSTR, lpString2: LPCSTR, nChar: int32): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "StrIsIntlEqualA".}
  proc StrToLong*(lpSrc: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrToIntA".}
  proc StrNCmp*(lpStr1: LPCSTR, lpStr2: LPCSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpNA".}
  proc StrNCmpI*(lpStr1: LPCSTR, lpStr2: LPCSTR, nChar: int32): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "StrCmpNIA".}
  proc StrCatN*(psz1: LPSTR, psz2: LPCSTR, cchMax: int32): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "StrNCatA".}
  proc PathAddBackslash*(pszPath: LPSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathAddBackslashA".}
  proc PathAddExtension*(pszPath: LPSTR, pszExt: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathAddExtensionA".}
  proc PathBuildRoot*(pszRoot: LPSTR, iDrive: int32): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathBuildRootA".}
  proc PathCombine*(pszDest: LPSTR, pszDir: LPCSTR, pszFile: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCombineA".}
  proc PathFileExists*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFileExistsA".}
  proc PathFindExtension*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindExtensionA".}
  proc PathFindFileName*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindFileNameA".}
  proc PathFindNextComponent*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindNextComponentA".}
  proc PathGetArgs*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathGetArgsA".}
  proc PathFindSuffixArray*(pszPath: LPCSTR, apszSuffix: ptr LPCSTR, iArraySize: int32): LPCSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindSuffixArrayA".}
  proc PathIsLFNFileSpec*(lpName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsLFNFileSpecA".}
  proc PathGetDriveNumber*(pszPath: LPCSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "PathGetDriveNumberA".}
  proc PathIsDirectory*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsDirectoryA".}
  proc PathIsDirectoryEmpty*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsDirectoryEmptyA".}
  proc PathIsFileSpec*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsFileSpecA".}
  proc PathIsPrefix*(pszPrefix: LPCSTR, pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsPrefixA".}
  proc PathIsRelative*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsRelativeA".}
  proc PathIsRoot*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsRootA".}
  proc PathIsSameRoot*(pszPath1: LPCSTR, pszPath2: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsSameRootA".}
  proc PathIsUNC*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsUNCA".}
  proc PathIsNetworkPath*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsNetworkPathA".}
  proc PathIsUNCServer*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsUNCServerA".}
  proc PathIsUNCServerShare*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsUNCServerShareA".}
  proc PathIsURL*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsURLA".}
  proc PathRemoveBackslash*(pszPath: LPSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveBackslashA".}
  proc PathSkipRoot*(pszPath: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "PathSkipRootA".}
  proc PathStripPath*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathStripPathA".}
  proc PathStripToRoot*(pszPath: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathStripToRootA".}
  proc PathMakeSystemFolder*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathMakeSystemFolderA".}
  proc PathUnmakeSystemFolder*(pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathUnmakeSystemFolderA".}
  proc PathIsSystemFolder*(pszPath: LPCSTR, dwAttrb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsSystemFolderA".}
  proc PathUndecorate*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathUndecorateA".}
  proc PathUnExpandEnvStrings*(pszPath: LPCSTR, pszBuf: LPSTR, cchBuf: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathUnExpandEnvStringsA".}
  proc PathAppend*(pszPath: LPSTR, pMore: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathAppendA".}
  proc PathCanonicalize*(pszBuf: LPSTR, pszPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCanonicalizeA".}
  proc PathCompactPath*(hDC: HDC, pszPath: LPSTR, dx: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCompactPathA".}
  proc PathCompactPathEx*(pszOut: LPSTR, pszSrc: LPCSTR, cchMax: UINT, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCompactPathExA".}
  proc PathCommonPrefix*(pszFile1: LPCSTR, pszFile2: LPCSTR, achPath: LPSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCommonPrefixA".}
  proc PathFindOnPath*(pszPath: LPSTR, ppszOtherDirs: ptr LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathFindOnPathA".}
  proc PathGetCharType*(ch: UCHAR): UINT {.winapi, stdcall, dynlib: "shlwapi", importc: "PathGetCharTypeA".}
  proc PathIsContentType*(pszPath: LPCSTR, pszContentType: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathIsContentTypeA".}
  proc PathMakePretty*(pszPath: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathMakePrettyA".}
  proc PathMatchSpec*(pszFile: LPCSTR, pszSpec: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathMatchSpecA".}
  proc PathParseIconLocation*(pszIconFile: LPSTR): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "PathParseIconLocationA".}
  proc PathQuoteSpaces*(lpsz: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathQuoteSpacesA".}
  proc PathRelativePathTo*(pszPath: LPSTR, pszFrom: LPCSTR, dwAttrFrom: DWORD, pszTo: LPCSTR, dwAttrTo: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRelativePathToA".}
  proc PathRemoveArgs*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveArgsA".}
  proc PathRemoveBlanks*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveBlanksA".}
  proc PathRemoveExtension*(pszPath: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveExtensionA".}
  proc PathRemoveFileSpec*(pszPath: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRemoveFileSpecA".}
  proc PathRenameExtension*(pszPath: LPSTR, pszExt: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathRenameExtensionA".}
  proc PathSearchAndQualify*(pszPath: LPCSTR, pszBuf: LPSTR, cchBuf: UINT): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "PathSearchAndQualifyA".}
  proc PathSetDlgItemPath*(hDlg: HWND, id: int32, pszPath: LPCSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathSetDlgItemPathA".}
  proc PathUnquoteSpaces*(lpsz: LPSTR): void {.winapi, stdcall, dynlib: "shlwapi", importc: "PathUnquoteSpacesA".}
  proc UrlCompare*(psz1: LPCSTR, psz2: LPCSTR, fIgnoreSlash: WINBOOL): int32 {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlCompareA".}
  proc UrlCombine*(pszBase: LPCSTR, pszRelative: LPCSTR, pszCombined: LPSTR, pcchCombined: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlCombineA".}
  proc UrlCanonicalize*(pszUrl: LPCSTR, pszCanonicalized: LPSTR, pcchCanonicalized: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlCanonicalizeA".}
  proc UrlIsOpaque*(pszURL: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlIsOpaqueA".}
  proc UrlGetLocation*(psz1: LPCSTR): LPCSTR {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlGetLocationA".}
  proc UrlUnescape*(pszUrl: LPSTR, pszUnescaped: LPSTR, pcchUnescaped: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlUnescapeA".}
  proc UrlEscape*(pszUrl: LPCSTR, pszEscaped: LPSTR, pcchEscaped: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlEscapeA".}
  proc UrlCreateFromPath*(pszPath: LPCSTR, pszUrl: LPSTR, pcchUrl: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlCreateFromPathA".}
  proc PathCreateFromUrl*(pszUrl: LPCSTR, pszPath: LPSTR, pcchPath: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "PathCreateFromUrlA".}
  proc UrlHash*(pszUrl: LPCSTR, pbHash: LPBYTE, cbHash: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlHashA".}
  proc UrlGetPart*(pszIn: LPCSTR, pszOut: LPSTR, pcchOut: LPDWORD, dwPart: DWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlGetPartA".}
  proc UrlApplyScheme*(pszIn: LPCSTR, pszOut: LPSTR, pcchOut: LPDWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlApplySchemeA".}
  proc UrlIs*(pszUrl: LPCSTR, UrlIs: TURLIS): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "UrlIsA".}
  proc SHDeleteEmptyKey*(hkey: HKEY, pszSubKey: LPCSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHDeleteEmptyKeyA".}
  proc SHDeleteKey*(hkey: HKEY, pszSubKey: LPCSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHDeleteKeyA".}
  proc SHDeleteValue*(hkey: HKEY, pszSubKey: LPCSTR, pszValue: LPCSTR): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHDeleteValueA".}
  proc SHGetValue*(hkey: HKEY, pszSubKey: LPCSTR, pszValue: LPCSTR, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHGetValueA".}
  proc SHSetValue*(hkey: HKEY, pszSubKey: LPCSTR, pszValue: LPCSTR, dwType: DWORD, pvData: LPCVOID, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHSetValueA".}
  proc SHRegGetValue*(hkey: HKEY, pszSubKey: LPCSTR, pszValue: LPCSTR, dwFlags: SRRF, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetValueA".}
  proc SHQueryValueEx*(hkey: HKEY, pszValue: LPCSTR, pdwReserved: ptr DWORD, pdwType: ptr DWORD, pvData: pointer, pcbData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHQueryValueExA".}
  proc SHEnumKeyEx*(hkey: HKEY, dwIndex: DWORD, pszName: LPSTR, pcchName: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHEnumKeyExA".}
  proc SHEnumValue*(hkey: HKEY, dwIndex: DWORD, pszValueName: LPSTR, pcchValueName: LPDWORD, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHEnumValueA".}
  proc SHQueryInfoKey*(hkey: HKEY, pcSubKeys: LPDWORD, pcchMaxSubKeyLen: LPDWORD, pcValues: LPDWORD, pcchMaxValueNameLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHQueryInfoKeyA".}
  proc SHCopyKey*(hkeySrc: HKEY, szSrcSubKey: LPCSTR, hkeyDest: HKEY, fReserved: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHCopyKeyA".}
  proc SHRegGetPath*(hKey: HKEY, pcszSubKey: LPCSTR, pcszValue: LPCSTR, pszPath: LPSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetPathA".}
  proc SHRegSetPath*(hKey: HKEY, pcszSubKey: LPCSTR, pcszValue: LPCSTR, pcszPath: LPCSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegSetPathA".}
  proc SHRegCreateUSKey*(pszPath: LPCSTR, samDesired: REGSAM, hRelativeUSKey: HUSKEY, phNewUSKey: PHUSKEY, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegCreateUSKeyA".}
  proc SHRegOpenUSKey*(pszPath: LPCSTR, samDesired: REGSAM, hRelativeUSKey: HUSKEY, phNewUSKey: PHUSKEY, fIgnoreHKCU: WINBOOL): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegOpenUSKeyA".}
  proc SHRegQueryUSValue*(hUSKey: HUSKEY, pszValue: LPCSTR, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, fIgnoreHKCU: WINBOOL, pvDefaultData: pointer, dwDefaultDataSize: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegQueryUSValueA".}
  proc SHRegWriteUSValue*(hUSKey: HUSKEY, pszValue: LPCSTR, dwType: DWORD, pvData: pointer, cbData: DWORD, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegWriteUSValueA".}
  proc SHRegDeleteUSValue*(hUSKey: HUSKEY, pszValue: LPCSTR, delRegFlags: SHREGDEL_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegDeleteUSValueA".}
  proc SHRegDeleteEmptyUSKey*(hUSKey: HUSKEY, pszSubKey: LPCSTR, delRegFlags: SHREGDEL_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegDeleteEmptyUSKeyA".}
  proc SHRegEnumUSKey*(hUSKey: HUSKEY, dwIndex: DWORD, pszName: LPSTR, pcchName: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegEnumUSKeyA".}
  proc SHRegEnumUSValue*(hUSkey: HUSKEY, dwIndex: DWORD, pszValueName: LPSTR, pcchValueName: LPDWORD, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegEnumUSValueA".}
  proc SHRegQueryInfoUSKey*(hUSKey: HUSKEY, pcSubKeys: LPDWORD, pcchMaxSubKeyLen: LPDWORD, pcValues: LPDWORD, pcchMaxValueNameLen: LPDWORD, enumRegFlags: SHREGENUM_FLAGS): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegQueryInfoUSKeyA".}
  proc SHRegGetUSValue*(pszSubKey: LPCSTR, pszValue: LPCSTR, pdwType: LPDWORD, pvData: pointer, pcbData: LPDWORD, fIgnoreHKCU: WINBOOL, pvDefaultData: pointer, dwDefaultDataSize: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetUSValueA".}
  proc SHRegSetUSValue*(pszSubKey: LPCSTR, pszValue: LPCSTR, dwType: DWORD, pvData: pointer, cbData: DWORD, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegSetUSValueA".}
  proc SHRegGetBoolUSValue*(pszSubKey: LPCSTR, pszValue: LPCSTR, fIgnoreHKCU: WINBOOL, fDefault: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shlwapi", importc: "SHRegGetBoolUSValueA".}
  proc AssocQueryString*(flags: ASSOCF, str: ASSOCSTR, pszAssoc: LPCSTR, pszExtra: LPCSTR, pszOut: LPSTR, pcchOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "AssocQueryStringA".}
  proc AssocQueryStringByKey*(flags: ASSOCF, str: ASSOCSTR, hkAssoc: HKEY, pszExtra: LPCSTR, pszOut: LPSTR, pcchOut: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "AssocQueryStringByKeyA".}
  proc AssocQueryKey*(flags: ASSOCF, key: ASSOCKEY, pszAssoc: LPCSTR, pszExtra: LPCSTR, phkeyOut: ptr HKEY): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "AssocQueryKeyA".}
  proc SHOpenRegStream2*(hkey: HKEY, pszSubkey: LPCSTR, pszValue: LPCSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shlwapi", importc: "SHOpenRegStream2A".}
  proc SHCreateStreamOnFile*(pszFile: LPCSTR, grfMode: DWORD, ppstm: ptr ptr IStream): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "SHCreateStreamOnFileA".}
  proc SHOpenRegStream*(hkey: HKEY, pszSubkey: LPCSTR, pszValue: LPCSTR, grfMode: DWORD): ptr IStream {.winapi, stdcall, dynlib: "shlwapi", importc: "SHOpenRegStream2A".}
  proc GetAcceptLanguages*(psz: LPSTR, pcch: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "shlwapi", importc: "GetAcceptLanguagesA".}
  proc SHGetIconOverlayIndex*(pszIconPath: LPCSTR, iIconIndex: int32): int32 {.winapi, stdcall, dynlib: "shell32", importc: "SHGetIconOverlayIndexA".}
  proc ILCreateFromPath*(pszPath: PCSTR): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc: "ILCreateFromPathA".}
  proc SHGetPathFromIDList*(pidl: PCIDLIST_ABSOLUTE, pszPath: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetPathFromIDListA".}
  proc SHCreateDirectoryEx*(hwnd: HWND, pszPath: LPCSTR, psa: ptr SECURITY_ATTRIBUTES): int32 {.winapi, stdcall, dynlib: "shell32", importc: "SHCreateDirectoryExA".}
  proc SHGetSpecialFolderPath*(hwnd: HWND, pszPath: LPSTR, csidl: int32, fCreate: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "SHGetSpecialFolderPathA".}
  proc SHGetFolderPath*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszPath: LPSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHGetFolderPathA".}
  proc SHSetFolderPath*(csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszPath: LPCSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHSetFolderPathA".}
  proc SHGetFolderPathAndSubDir*(hwnd: HWND, csidl: int32, hToken: HANDLE, dwFlags: DWORD, pszSubDir: LPCSTR, pszPath: LPSTR): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHGetFolderPathAndSubDirA".}
  proc SHBrowseForFolder*(lpbi: LPBROWSEINFOA): PIDLIST_ABSOLUTE {.winapi, stdcall, dynlib: "shell32", importc: "SHBrowseForFolderA".}
  proc SHUpdateImage*(pszHashItem: LPCSTR, iIndex: int32, uFlags: UINT, iImageIndex: int32): void {.winapi, stdcall, dynlib: "shell32", importc: "SHUpdateImageA".}
  proc SHGetDataFromIDList*(psf: ptr IShellFolder, pidl: PCUITEMID_CHILD, nFormat: int32, pv: pointer, cb: int32): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHGetDataFromIDListA".}
  proc PathIsSlow*(pszFile: LPCSTR, dwAttr: DWORD): WINBOOL {.winapi, stdcall, dynlib: "shell32", importc: "PathIsSlowA".}
  proc SHDefExtractIcon*(pszIconFile: LPCSTR, iIndex: int32, uFlags: UINT, phiconLarge: ptr HICON, phiconSmall: ptr HICON, nIconSize: UINT): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHDefExtractIconA".}
  proc Shell_GetCachedImageIndex*(pszIconPath: LPCSTR, iIconIndex: int32, uIconFlags: UINT): int32 {.winapi, stdcall, dynlib: "shell32", importc: "Shell_GetCachedImageIndexA".}
  proc SHPathPrepareForWrite*(hwnd: HWND, punkEnableModless: ptr IUnknown, pszPath: LPCSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "shell32", importc: "SHPathPrepareForWriteA".}
