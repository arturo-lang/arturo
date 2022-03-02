#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winerror
#include <winnetwk.h>
#include <wnnc.h>
type
  NETRESOURCEA* {.pure.} = object
    dwScope*: DWORD
    dwType*: DWORD
    dwDisplayType*: DWORD
    dwUsage*: DWORD
    lpLocalName*: LPSTR
    lpRemoteName*: LPSTR
    lpComment*: LPSTR
    lpProvider*: LPSTR
  LPNETRESOURCEA* = ptr NETRESOURCEA
  NETRESOURCEW* {.pure.} = object
    dwScope*: DWORD
    dwType*: DWORD
    dwDisplayType*: DWORD
    dwUsage*: DWORD
    lpLocalName*: LPWSTR
    lpRemoteName*: LPWSTR
    lpComment*: LPWSTR
    lpProvider*: LPWSTR
  LPNETRESOURCEW* = ptr NETRESOURCEW
  CONNECTDLGSTRUCTA* {.pure.} = object
    cbStructure*: DWORD
    hwndOwner*: HWND
    lpConnRes*: LPNETRESOURCEA
    dwFlags*: DWORD
    dwDevNum*: DWORD
  LPCONNECTDLGSTRUCTA* = ptr CONNECTDLGSTRUCTA
  CONNECTDLGSTRUCTW* {.pure.} = object
    cbStructure*: DWORD
    hwndOwner*: HWND
    lpConnRes*: LPNETRESOURCEW
    dwFlags*: DWORD
    dwDevNum*: DWORD
  LPCONNECTDLGSTRUCTW* = ptr CONNECTDLGSTRUCTW
  DISCDLGSTRUCTA* {.pure.} = object
    cbStructure*: DWORD
    hwndOwner*: HWND
    lpLocalName*: LPSTR
    lpRemoteName*: LPSTR
    dwFlags*: DWORD
  LPDISCDLGSTRUCTA* = ptr DISCDLGSTRUCTA
  DISCDLGSTRUCTW* {.pure.} = object
    cbStructure*: DWORD
    hwndOwner*: HWND
    lpLocalName*: LPWSTR
    lpRemoteName*: LPWSTR
    dwFlags*: DWORD
  LPDISCDLGSTRUCTW* = ptr DISCDLGSTRUCTW
  UNIVERSAL_NAME_INFOA* {.pure.} = object
    lpUniversalName*: LPSTR
  LPUNIVERSAL_NAME_INFOA* = ptr UNIVERSAL_NAME_INFOA
  UNIVERSAL_NAME_INFOW* {.pure.} = object
    lpUniversalName*: LPWSTR
  LPUNIVERSAL_NAME_INFOW* = ptr UNIVERSAL_NAME_INFOW
  REMOTE_NAME_INFOA* {.pure.} = object
    lpUniversalName*: LPSTR
    lpConnectionName*: LPSTR
    lpRemainingPath*: LPSTR
  LPREMOTE_NAME_INFOA* = ptr REMOTE_NAME_INFOA
  REMOTE_NAME_INFOW* {.pure.} = object
    lpUniversalName*: LPWSTR
    lpConnectionName*: LPWSTR
    lpRemainingPath*: LPWSTR
  LPREMOTE_NAME_INFOW* = ptr REMOTE_NAME_INFOW
  NETINFOSTRUCT* {.pure.} = object
    cbStructure*: DWORD
    dwProviderVersion*: DWORD
    dwStatus*: DWORD
    dwCharacteristics*: DWORD
    dwHandle*: ULONG_PTR
    wNetType*: WORD
    dwPrinters*: DWORD
    dwDrives*: DWORD
  LPNETINFOSTRUCT* = ptr NETINFOSTRUCT
  NETCONNECTINFOSTRUCT* {.pure.} = object
    cbStructure*: DWORD
    dwFlags*: DWORD
    dwSpeed*: DWORD
    dwDelay*: DWORD
    dwOptDataSize*: DWORD
  LPNETCONNECTINFOSTRUCT* = ptr NETCONNECTINFOSTRUCT
const
  WNNC_NET_MSNET* = 0x00010000
  WNNC_NET_SMB* = 0x00020000
  WNNC_NET_LANMAN* = WNNC_NET_SMB
  WNNC_NET_NETWARE* = 0x00030000
  WNNC_NET_VINES* = 0x00040000
  WNNC_NET_10NET* = 0x00050000
  WNNC_NET_LOCUS* = 0x00060000
  WNNC_NET_SUN_PC_NFS* = 0x00070000
  WNNC_NET_LANSTEP* = 0x00080000
  WNNC_NET_9TILES* = 0x00090000
  WNNC_NET_LANTASTIC* = 0x000a0000
  WNNC_NET_AS400* = 0x000b0000
  WNNC_NET_FTP_NFS* = 0x000c0000
  WNNC_NET_PATHWORKS* = 0x000d0000
  WNNC_NET_LIFENET* = 0x000e0000
  WNNC_NET_POWERLAN* = 0x000f0000
  WNNC_NET_BWNFS* = 0x00100000
  WNNC_NET_COGENT* = 0x00110000
  WNNC_NET_FARALLON* = 0x00120000
  WNNC_NET_APPLETALK* = 0x00130000
  WNNC_NET_INTERGRAPH* = 0x00140000
  WNNC_NET_SYMFONET* = 0x00150000
  WNNC_NET_CLEARCASE* = 0x00160000
  WNNC_NET_FRONTIER* = 0x00170000
  WNNC_NET_BMC* = 0x00180000
  WNNC_NET_DCE* = 0x00190000
  WNNC_NET_AVID* = 0x001a0000
  WNNC_NET_DOCUSPACE* = 0x001b0000
  WNNC_NET_MANGOSOFT* = 0x001c0000
  WNNC_NET_SERNET* = 0x001d0000
  WNNC_NET_RIVERFRONT1* = 0x001e0000
  WNNC_NET_RIVERFRONT2* = 0x001f0000
  WNNC_NET_DECORB* = 0x00200000
  WNNC_NET_PROTSTOR* = 0x00210000
  WNNC_NET_FJ_REDIR* = 0x00220000
  WNNC_NET_DISTINCT* = 0x00230000
  WNNC_NET_TWINS* = 0x00240000
  WNNC_NET_RDR2SAMPLE* = 0x00250000
  WNNC_NET_CSC* = 0x00260000
  WNNC_NET_3IN1* = 0x00270000
  WNNC_NET_EXTENDNET* = 0x00290000
  WNNC_NET_STAC* = 0x002a0000
  WNNC_NET_FOXBAT* = 0x002b0000
  WNNC_NET_YAHOO* = 0x002c0000
  WNNC_NET_EXIFS* = 0x002d0000
  WNNC_NET_DAV* = 0x002e0000
  WNNC_NET_KNOWARE* = 0x002f0000
  WNNC_NET_OBJECT_DIRE* = 0x00300000
  WNNC_NET_MASFAX* = 0x00310000
  WNNC_NET_HOB_NFS* = 0x00320000
  WNNC_NET_SHIVA* = 0x00330000
  WNNC_NET_IBMAL* = 0x00340000
  WNNC_NET_LOCK* = 0x00350000
  WNNC_NET_TERMSRV* = 0x00360000
  WNNC_NET_SRT* = 0x00370000
  WNNC_NET_QUINCY* = 0x00380000
  WNNC_NET_OPENAFS* = 0x00390000
  WNNC_NET_AVID1* = 0x003a0000
  WNNC_NET_DFS* = 0x003b0000
  WNNC_NET_KWNP* = 0x003c0000
  WNNC_NET_ZENWORKS* = 0x003d0000
  WNNC_NET_DRIVEONWEB* = 0x003e0000
  WNNC_NET_VMWARE* = 0x003f0000
  WNNC_NET_RSFX* = 0x00400000
  WNNC_NET_MFILES* = 0x00410000
  WNNC_NET_MS_NFS* = 0x00420000
  WNNC_NET_GOOGLE* = 0x00430000
  WNNC_NET_NDFS* = 0x00440000
  WNNC_CRED_MANAGER* = 0xffff0000'i32
  RESOURCE_CONNECTED* = 0x00000001
  RESOURCE_GLOBALNET* = 0x00000002
  RESOURCE_REMEMBERED* = 0x00000003
  RESOURCE_RECENT* = 0x00000004
  RESOURCE_CONTEXT* = 0x00000005
  RESOURCETYPE_ANY* = 0x00000000
  RESOURCETYPE_DISK* = 0x00000001
  RESOURCETYPE_PRINT* = 0x00000002
  RESOURCETYPE_RESERVED* = 0x00000008
  RESOURCETYPE_UNKNOWN* = 0xFFFFFFFF'i32
  RESOURCEUSAGE_CONNECTABLE* = 0x00000001
  RESOURCEUSAGE_CONTAINER* = 0x00000002
  RESOURCEUSAGE_NOLOCALDEVICE* = 0x00000004
  RESOURCEUSAGE_SIBLING* = 0x00000008
  RESOURCEUSAGE_ATTACHED* = 0x00000010
  RESOURCEUSAGE_ALL* = RESOURCEUSAGE_CONNECTABLE or RESOURCEUSAGE_CONTAINER or RESOURCEUSAGE_ATTACHED
  RESOURCEUSAGE_RESERVED* = 0x80000000'i32
  RESOURCEDISPLAYTYPE_GENERIC* = 0x00000000
  RESOURCEDISPLAYTYPE_DOMAIN* = 0x00000001
  RESOURCEDISPLAYTYPE_SERVER* = 0x00000002
  RESOURCEDISPLAYTYPE_SHARE* = 0x00000003
  RESOURCEDISPLAYTYPE_FILE* = 0x00000004
  RESOURCEDISPLAYTYPE_GROUP* = 0x00000005
  RESOURCEDISPLAYTYPE_NETWORK* = 0x00000006
  RESOURCEDISPLAYTYPE_ROOT* = 0x00000007
  RESOURCEDISPLAYTYPE_SHAREADMIN* = 0x00000008
  RESOURCEDISPLAYTYPE_DIRECTORY* = 0x00000009
  RESOURCEDISPLAYTYPE_TREE* = 0x0000000a
  RESOURCEDISPLAYTYPE_NDSCONTAINER* = 0x0000000b
  NETPROPERTY_PERSISTENT* = 1
  CONNECT_UPDATE_PROFILE* = 0x00000001
  CONNECT_UPDATE_RECENT* = 0x00000002
  CONNECT_TEMPORARY* = 0x00000004
  CONNECT_INTERACTIVE* = 0x00000008
  CONNECT_PROMPT* = 0x00000010
  CONNECT_NEED_DRIVE* = 0x00000020
  CONNECT_REFCOUNT* = 0x00000040
  CONNECT_REDIRECT* = 0x00000080
  CONNECT_LOCALDRIVE* = 0x00000100
  CONNECT_CURRENT_MEDIA* = 0x00000200
  CONNECT_DEFERRED* = 0x00000400
  CONNECT_RESERVED* = 0xFF000000'i32
  CONNECT_COMMANDLINE* = 0x00000800
  CONNECT_CMD_SAVECRED* = 0x00001000
  CONNECT_CRED_RESET* = 0x00002000
  CONNDLG_RO_PATH* = 0x00000001
  CONNDLG_CONN_POINT* = 0x00000002
  CONNDLG_USE_MRU* = 0x00000004
  CONNDLG_HIDE_BOX* = 0x00000008
  CONNDLG_PERSIST* = 0x00000010
  CONNDLG_NOT_PERSIST* = 0x00000020
  DISC_UPDATE_PROFILE* = 0x00000001
  DISC_NO_FORCE* = 0x00000040
  UNIVERSAL_NAME_INFO_LEVEL* = 0x00000001
  REMOTE_NAME_INFO_LEVEL* = 0x00000002
  WNFMT_MULTILINE* = 0x01
  WNFMT_ABBREVIATED* = 0x02
  WNFMT_INENUM* = 0x10
  WNFMT_CONNECTION* = 0x20
  NETINFO_DLL16* = 0x00000001
  NETINFO_DISKRED* = 0x00000004
  NETINFO_PRINTERRED* = 0x00000008
  RP_LOGON* = 0x01
  RP_INIFILE* = 0x02
  PP_DISPLAYERRORS* = 0x01
  WN_SUCCESS* = NO_ERROR
  WN_NO_ERROR* = NO_ERROR
  WN_NOT_SUPPORTED* = ERROR_NOT_SUPPORTED
  WN_CANCEL* = ERROR_CANCELLED
  WN_RETRY* = ERROR_RETRY
  WN_NET_ERROR* = ERROR_UNEXP_NET_ERR
  WN_MORE_DATA* = ERROR_MORE_DATA
  WN_BAD_POINTER* = ERROR_INVALID_ADDRESS
  WN_BAD_VALUE* = ERROR_INVALID_PARAMETER
  WN_BAD_USER* = ERROR_BAD_USERNAME
  WN_BAD_PASSWORD* = ERROR_INVALID_PASSWORD
  WN_ACCESS_DENIED* = ERROR_ACCESS_DENIED
  WN_FUNCTION_BUSY* = ERROR_BUSY
  WN_WINDOWS_ERROR* = ERROR_UNEXP_NET_ERR
  WN_OUT_OF_MEMORY* = ERROR_NOT_ENOUGH_MEMORY
  WN_NO_NETWORK* = ERROR_NO_NETWORK
  WN_EXTENDED_ERROR* = ERROR_EXTENDED_ERROR
  WN_BAD_LEVEL* = ERROR_INVALID_LEVEL
  WN_BAD_HANDLE* = ERROR_INVALID_HANDLE
  WN_NOT_INITIALIZING* = ERROR_ALREADY_INITIALIZED
  WN_NO_MORE_DEVICES* = ERROR_NO_MORE_DEVICES
  WN_NOT_CONNECTED* = ERROR_NOT_CONNECTED
  WN_OPEN_FILES* = ERROR_OPEN_FILES
  WN_DEVICE_IN_USE* = ERROR_DEVICE_IN_USE
  WN_BAD_NETNAME* = ERROR_BAD_NET_NAME
  WN_BAD_LOCALNAME* = ERROR_BAD_DEVICE
  WN_ALREADY_CONNECTED* = ERROR_ALREADY_ASSIGNED
  WN_DEVICE_ERROR* = ERROR_GEN_FAILURE
  WN_CONNECTION_CLOSED* = ERROR_CONNECTION_UNAVAIL
  WN_NO_NET_OR_BAD_PATH* = ERROR_NO_NET_OR_BAD_PATH
  WN_BAD_PROVIDER* = ERROR_BAD_PROVIDER
  WN_CANNOT_OPEN_PROFILE* = ERROR_CANNOT_OPEN_PROFILE
  WN_BAD_PROFILE* = ERROR_BAD_PROFILE
  WN_BAD_DEV_TYPE* = ERROR_BAD_DEV_TYPE
  WN_DEVICE_ALREADY_REMEMBERED* = ERROR_DEVICE_ALREADY_REMEMBERED
  WN_CONNECTED_OTHER_PASSWORD* = ERROR_CONNECTED_OTHER_PASSWORD
  WN_CONNECTED_OTHER_PASSWORD_DEFAULT* = ERROR_CONNECTED_OTHER_PASSWORD_DEFAULT
  WN_NO_MORE_ENTRIES* = ERROR_NO_MORE_ITEMS
  WN_NOT_CONTAINER* = ERROR_NOT_CONTAINER
  WN_NOT_AUTHENTICATED* = ERROR_NOT_AUTHENTICATED
  WN_NOT_LOGGED_ON* = ERROR_NOT_LOGGED_ON
  WN_NOT_VALIDATED* = ERROR_NO_LOGON_SERVERS
  WNCON_FORNETCARD* = 0x00000001
  WNCON_NOTROUTED* = 0x00000002
  WNCON_SLOWLINK* = 0x00000004
  WNCON_DYNAMIC* = 0x00000008
type
  PFNGETPROFILEPATHA* = proc (pszUsername: LPCSTR, pszBuffer: LPSTR, cbBuffer: UINT): UINT {.stdcall.}
  PFNGETPROFILEPATHW* = proc (pszUsername: LPCWSTR, pszBuffer: LPWSTR, cbBuffer: UINT): UINT {.stdcall.}
  PFNRECONCILEPROFILEA* = proc (pszCentralFile: LPCSTR, pszLocalFile: LPCSTR, dwFlags: DWORD): UINT {.stdcall.}
  PFNRECONCILEPROFILEW* = proc (pszCentralFile: LPCWSTR, pszLocalFile: LPCWSTR, dwFlags: DWORD): UINT {.stdcall.}
  PFNPROCESSPOLICIESA* = proc (hwnd: HWND, pszPath: LPCSTR, pszUsername: LPCSTR, pszComputerName: LPCSTR, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFNPROCESSPOLICIESW* = proc (hwnd: HWND, pszPath: LPCWSTR, pszUsername: LPCWSTR, pszComputerName: LPCWSTR, dwFlags: DWORD): WINBOOL {.stdcall.}
proc WNetAddConnectionA*(lpRemoteName: LPCSTR, lpPassword: LPCSTR, lpLocalName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetAddConnectionW*(lpRemoteName: LPCWSTR, lpPassword: LPCWSTR, lpLocalName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetAddConnection2A*(lpNetResource: LPNETRESOURCEA, lpPassword: LPCSTR, lpUserName: LPCSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetAddConnection2W*(lpNetResource: LPNETRESOURCEW, lpPassword: LPCWSTR, lpUserName: LPCWSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetAddConnection3A*(hwndOwner: HWND, lpNetResource: LPNETRESOURCEA, lpPassword: LPCSTR, lpUserName: LPCSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetAddConnection3W*(hwndOwner: HWND, lpNetResource: LPNETRESOURCEW, lpPassword: LPCWSTR, lpUserName: LPCWSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetCancelConnectionA*(lpName: LPCSTR, fForce: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetCancelConnectionW*(lpName: LPCWSTR, fForce: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetCancelConnection2A*(lpName: LPCSTR, dwFlags: DWORD, fForce: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetCancelConnection2W*(lpName: LPCWSTR, dwFlags: DWORD, fForce: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetConnectionA*(lpLocalName: LPCSTR, lpRemoteName: LPSTR, lpnLength: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetConnectionW*(lpLocalName: LPCWSTR, lpRemoteName: LPWSTR, lpnLength: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetUseConnectionA*(hwndOwner: HWND, lpNetResource: LPNETRESOURCEA, lpPassword: LPCSTR, lpUserID: LPCSTR, dwFlags: DWORD, lpAccessName: LPSTR, lpBufferSize: LPDWORD, lpResult: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetUseConnectionW*(hwndOwner: HWND, lpNetResource: LPNETRESOURCEW, lpPassword: LPCWSTR, lpUserID: LPCWSTR, dwFlags: DWORD, lpAccessName: LPWSTR, lpBufferSize: LPDWORD, lpResult: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetConnectionDialog*(hwnd: HWND, dwType: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetDisconnectDialog*(hwnd: HWND, dwType: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetRestoreSingleConnectionW*(hwndParent: HWND, lpDevice: LPCWSTR, fUseUI: BOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetConnectionDialog1A*(lpConnDlgStruct: LPCONNECTDLGSTRUCTA): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetConnectionDialog1W*(lpConnDlgStruct: LPCONNECTDLGSTRUCTW): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetDisconnectDialog1A*(lpConnDlgStruct: LPDISCDLGSTRUCTA): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetDisconnectDialog1W*(lpConnDlgStruct: LPDISCDLGSTRUCTW): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetOpenEnumA*(dwScope: DWORD, dwType: DWORD, dwUsage: DWORD, lpNetResource: LPNETRESOURCEA, lphEnum: LPHANDLE): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetOpenEnumW*(dwScope: DWORD, dwType: DWORD, dwUsage: DWORD, lpNetResource: LPNETRESOURCEW, lphEnum: LPHANDLE): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetEnumResourceA*(hEnum: HANDLE, lpcCount: LPDWORD, lpBuffer: LPVOID, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetEnumResourceW*(hEnum: HANDLE, lpcCount: LPDWORD, lpBuffer: LPVOID, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetCloseEnum*(hEnum: HANDLE): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetResourceParentA*(lpNetResource: LPNETRESOURCEA, lpBuffer: LPVOID, lpcbBuffer: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetResourceParentW*(lpNetResource: LPNETRESOURCEW, lpBuffer: LPVOID, lpcbBuffer: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetResourceInformationA*(lpNetResource: LPNETRESOURCEA, lpBuffer: LPVOID, lpcbBuffer: LPDWORD, lplpSystem: ptr LPSTR): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetResourceInformationW*(lpNetResource: LPNETRESOURCEW, lpBuffer: LPVOID, lpcbBuffer: LPDWORD, lplpSystem: ptr LPWSTR): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetUniversalNameA*(lpLocalPath: LPCSTR, dwInfoLevel: DWORD, lpBuffer: LPVOID, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetUniversalNameW*(lpLocalPath: LPCWSTR, dwInfoLevel: DWORD, lpBuffer: LPVOID, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetUserA*(lpName: LPCSTR, lpUserName: LPSTR, lpnLength: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetUserW*(lpName: LPCWSTR, lpUserName: LPWSTR, lpnLength: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetProviderNameA*(dwNetType: DWORD, lpProviderName: LPSTR, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetProviderNameW*(dwNetType: DWORD, lpProviderName: LPWSTR, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetNetworkInformationA*(lpProvider: LPCSTR, lpNetInfoStruct: LPNETINFOSTRUCT): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetNetworkInformationW*(lpProvider: LPCWSTR, lpNetInfoStruct: LPNETINFOSTRUCT): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetLastErrorA*(lpError: LPDWORD, lpErrorBuf: LPSTR, nErrorBufSize: DWORD, lpNameBuf: LPSTR, nNameBufSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc WNetGetLastErrorW*(lpError: LPDWORD, lpErrorBuf: LPWSTR, nErrorBufSize: DWORD, lpNameBuf: LPWSTR, nNameBufSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc MultinetGetConnectionPerformanceA*(lpNetResource: LPNETRESOURCEA, lpNetConnectInfoStruct: LPNETCONNECTINFOSTRUCT): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
proc MultinetGetConnectionPerformanceW*(lpNetResource: LPNETRESOURCEW, lpNetConnectInfoStruct: LPNETCONNECTINFOSTRUCT): DWORD {.winapi, stdcall, dynlib: "mpr", importc.}
when winimUnicode:
  type
    NETRESOURCE* = NETRESOURCEW
    LPNETRESOURCE* = LPNETRESOURCEW
    CONNECTDLGSTRUCT* = CONNECTDLGSTRUCTW
    LPCONNECTDLGSTRUCT* = LPCONNECTDLGSTRUCTW
    DISCDLGSTRUCT* = DISCDLGSTRUCTW
    LPDISCDLGSTRUCT* = LPDISCDLGSTRUCTW
    UNIVERSAL_NAME_INFO* = UNIVERSAL_NAME_INFOW
    LPUNIVERSAL_NAME_INFO* = LPUNIVERSAL_NAME_INFOW
    REMOTE_NAME_INFO* = REMOTE_NAME_INFOW
    LPREMOTE_NAME_INFO* = LPREMOTE_NAME_INFOW
    PFNGETPROFILEPATH* = PFNGETPROFILEPATHW
    PFNRECONCILEPROFILE* = PFNRECONCILEPROFILEW
    PFNPROCESSPOLICIES* = PFNPROCESSPOLICIESW
  proc WNetAddConnection*(lpRemoteName: LPCWSTR, lpPassword: LPCWSTR, lpLocalName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetAddConnectionW".}
  proc WNetAddConnection2*(lpNetResource: LPNETRESOURCEW, lpPassword: LPCWSTR, lpUserName: LPCWSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetAddConnection2W".}
  proc WNetAddConnection3*(hwndOwner: HWND, lpNetResource: LPNETRESOURCEW, lpPassword: LPCWSTR, lpUserName: LPCWSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetAddConnection3W".}
  proc WNetCancelConnection*(lpName: LPCWSTR, fForce: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetCancelConnectionW".}
  proc WNetCancelConnection2*(lpName: LPCWSTR, dwFlags: DWORD, fForce: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetCancelConnection2W".}
  proc WNetGetConnection*(lpLocalName: LPCWSTR, lpRemoteName: LPWSTR, lpnLength: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetConnectionW".}
  proc WNetUseConnection*(hwndOwner: HWND, lpNetResource: LPNETRESOURCEW, lpPassword: LPCWSTR, lpUserID: LPCWSTR, dwFlags: DWORD, lpAccessName: LPWSTR, lpBufferSize: LPDWORD, lpResult: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetUseConnectionW".}
  proc WNetConnectionDialog1*(lpConnDlgStruct: LPCONNECTDLGSTRUCTW): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetConnectionDialog1W".}
  proc WNetDisconnectDialog1*(lpConnDlgStruct: LPDISCDLGSTRUCTW): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetDisconnectDialog1W".}
  proc WNetOpenEnum*(dwScope: DWORD, dwType: DWORD, dwUsage: DWORD, lpNetResource: LPNETRESOURCEW, lphEnum: LPHANDLE): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetOpenEnumW".}
  proc WNetEnumResource*(hEnum: HANDLE, lpcCount: LPDWORD, lpBuffer: LPVOID, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetEnumResourceW".}
  proc WNetGetResourceParent*(lpNetResource: LPNETRESOURCEW, lpBuffer: LPVOID, lpcbBuffer: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetResourceParentW".}
  proc WNetGetResourceInformation*(lpNetResource: LPNETRESOURCEW, lpBuffer: LPVOID, lpcbBuffer: LPDWORD, lplpSystem: ptr LPWSTR): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetResourceInformationW".}
  proc WNetGetUniversalName*(lpLocalPath: LPCWSTR, dwInfoLevel: DWORD, lpBuffer: LPVOID, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetUniversalNameW".}
  proc WNetGetUser*(lpName: LPCWSTR, lpUserName: LPWSTR, lpnLength: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetUserW".}
  proc WNetGetProviderName*(dwNetType: DWORD, lpProviderName: LPWSTR, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetProviderNameW".}
  proc WNetGetNetworkInformation*(lpProvider: LPCWSTR, lpNetInfoStruct: LPNETINFOSTRUCT): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetNetworkInformationW".}
  proc WNetGetLastError*(lpError: LPDWORD, lpErrorBuf: LPWSTR, nErrorBufSize: DWORD, lpNameBuf: LPWSTR, nNameBufSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetLastErrorW".}
  proc MultinetGetConnectionPerformance*(lpNetResource: LPNETRESOURCEW, lpNetConnectInfoStruct: LPNETCONNECTINFOSTRUCT): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "MultinetGetConnectionPerformanceW".}
when winimAnsi:
  type
    NETRESOURCE* = NETRESOURCEA
    LPNETRESOURCE* = LPNETRESOURCEA
    CONNECTDLGSTRUCT* = CONNECTDLGSTRUCTA
    LPCONNECTDLGSTRUCT* = LPCONNECTDLGSTRUCTA
    DISCDLGSTRUCT* = DISCDLGSTRUCTA
    LPDISCDLGSTRUCT* = LPDISCDLGSTRUCTA
    UNIVERSAL_NAME_INFO* = UNIVERSAL_NAME_INFOA
    LPUNIVERSAL_NAME_INFO* = LPUNIVERSAL_NAME_INFOA
    REMOTE_NAME_INFO* = REMOTE_NAME_INFOA
    LPREMOTE_NAME_INFO* = LPREMOTE_NAME_INFOA
    PFNGETPROFILEPATH* = PFNGETPROFILEPATHA
    PFNRECONCILEPROFILE* = PFNRECONCILEPROFILEA
    PFNPROCESSPOLICIES* = PFNPROCESSPOLICIESA
  proc WNetAddConnection*(lpRemoteName: LPCSTR, lpPassword: LPCSTR, lpLocalName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetAddConnectionA".}
  proc WNetAddConnection2*(lpNetResource: LPNETRESOURCEA, lpPassword: LPCSTR, lpUserName: LPCSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetAddConnection2A".}
  proc WNetAddConnection3*(hwndOwner: HWND, lpNetResource: LPNETRESOURCEA, lpPassword: LPCSTR, lpUserName: LPCSTR, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetAddConnection3A".}
  proc WNetCancelConnection*(lpName: LPCSTR, fForce: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetCancelConnectionA".}
  proc WNetCancelConnection2*(lpName: LPCSTR, dwFlags: DWORD, fForce: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetCancelConnection2A".}
  proc WNetGetConnection*(lpLocalName: LPCSTR, lpRemoteName: LPSTR, lpnLength: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetConnectionA".}
  proc WNetUseConnection*(hwndOwner: HWND, lpNetResource: LPNETRESOURCEA, lpPassword: LPCSTR, lpUserID: LPCSTR, dwFlags: DWORD, lpAccessName: LPSTR, lpBufferSize: LPDWORD, lpResult: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetUseConnectionA".}
  proc WNetConnectionDialog1*(lpConnDlgStruct: LPCONNECTDLGSTRUCTA): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetConnectionDialog1A".}
  proc WNetDisconnectDialog1*(lpConnDlgStruct: LPDISCDLGSTRUCTA): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetDisconnectDialog1A".}
  proc WNetOpenEnum*(dwScope: DWORD, dwType: DWORD, dwUsage: DWORD, lpNetResource: LPNETRESOURCEA, lphEnum: LPHANDLE): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetOpenEnumA".}
  proc WNetEnumResource*(hEnum: HANDLE, lpcCount: LPDWORD, lpBuffer: LPVOID, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetEnumResourceA".}
  proc WNetGetResourceParent*(lpNetResource: LPNETRESOURCEA, lpBuffer: LPVOID, lpcbBuffer: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetResourceParentA".}
  proc WNetGetResourceInformation*(lpNetResource: LPNETRESOURCEA, lpBuffer: LPVOID, lpcbBuffer: LPDWORD, lplpSystem: ptr LPSTR): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetResourceInformationA".}
  proc WNetGetUniversalName*(lpLocalPath: LPCSTR, dwInfoLevel: DWORD, lpBuffer: LPVOID, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetUniversalNameA".}
  proc WNetGetUser*(lpName: LPCSTR, lpUserName: LPSTR, lpnLength: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetUserA".}
  proc WNetGetProviderName*(dwNetType: DWORD, lpProviderName: LPSTR, lpBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetProviderNameA".}
  proc WNetGetNetworkInformation*(lpProvider: LPCSTR, lpNetInfoStruct: LPNETINFOSTRUCT): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetNetworkInformationA".}
  proc WNetGetLastError*(lpError: LPDWORD, lpErrorBuf: LPSTR, nErrorBufSize: DWORD, lpNameBuf: LPSTR, nNameBufSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "WNetGetLastErrorA".}
  proc MultinetGetConnectionPerformance*(lpNetResource: LPNETRESOURCEA, lpNetConnectInfoStruct: LPNETCONNECTINFOSTRUCT): DWORD {.winapi, stdcall, dynlib: "mpr", importc: "MultinetGetConnectionPerformanceA".}
