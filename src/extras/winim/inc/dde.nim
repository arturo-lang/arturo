#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <cderr.h>
#include <dde.h>
#include <ddeml.h>
type
  HCONVLIST* = HANDLE
  HCONV* = HANDLE
  HSZ* = HANDLE
  HDDEDATA* = HANDLE
  HSZPAIR* {.pure.} = object
    hszSvc*: HSZ
    hszTopic*: HSZ
  PHSZPAIR* = ptr HSZPAIR
  CONVCONTEXT* {.pure.} = object
    cb*: UINT
    wFlags*: UINT
    wCountryID*: UINT
    iCodePage*: int32
    dwLangID*: DWORD
    dwSecurity*: DWORD
    qos*: SECURITY_QUALITY_OF_SERVICE
  PCONVCONTEXT* = ptr CONVCONTEXT
  CONVINFO* {.pure.} = object
    cb*: DWORD
    hUser*: DWORD_PTR
    hConvPartner*: HCONV
    hszSvcPartner*: HSZ
    hszServiceReq*: HSZ
    hszTopic*: HSZ
    hszItem*: HSZ
    wFmt*: UINT
    wType*: UINT
    wStatus*: UINT
    wConvst*: UINT
    wLastError*: UINT
    hConvList*: HCONVLIST
    ConvCtxt*: CONVCONTEXT
    hwnd*: HWND
    hwndPartner*: HWND
  PCONVINFO* = ptr CONVINFO
  DDEML_MSG_HOOK_DATA* {.pure.} = object
    uiLo*: UINT_PTR
    uiHi*: UINT_PTR
    cbData*: DWORD
    Data*: array[8, DWORD]
  PDDEML_MSG_HOOK_DATA* = ptr DDEML_MSG_HOOK_DATA
  MONMSGSTRUCT* {.pure.} = object
    cb*: UINT
    hwndTo*: HWND
    dwTime*: DWORD
    hTask*: HANDLE
    wMsg*: UINT
    wParam*: WPARAM
    lParam*: LPARAM
    dmhd*: DDEML_MSG_HOOK_DATA
  PMONMSGSTRUCT* = ptr MONMSGSTRUCT
  MONCBSTRUCT* {.pure.} = object
    cb*: UINT
    dwTime*: DWORD
    hTask*: HANDLE
    dwRet*: DWORD
    wType*: UINT
    wFmt*: UINT
    hConv*: HCONV
    hsz1*: HSZ
    hsz2*: HSZ
    hData*: HDDEDATA
    dwData1*: ULONG_PTR
    dwData2*: ULONG_PTR
    cc*: CONVCONTEXT
    cbData*: DWORD
    Data*: array[8, DWORD]
  PMONCBSTRUCT* = ptr MONCBSTRUCT
  MONHSZSTRUCTA* {.pure.} = object
    cb*: UINT
    fsAction*: WINBOOL
    dwTime*: DWORD
    hsz*: HSZ
    hTask*: HANDLE
    str*: array[1, CHAR]
  PMONHSZSTRUCTA* = ptr MONHSZSTRUCTA
  MONHSZSTRUCTW* {.pure.} = object
    cb*: UINT
    fsAction*: WINBOOL
    dwTime*: DWORD
    hsz*: HSZ
    hTask*: HANDLE
    str*: array[1, WCHAR]
  PMONHSZSTRUCTW* = ptr MONHSZSTRUCTW
  MONERRSTRUCT* {.pure.} = object
    cb*: UINT
    wLastError*: UINT
    dwTime*: DWORD
    hTask*: HANDLE
  PMONERRSTRUCT* = ptr MONERRSTRUCT
  MONLINKSTRUCT* {.pure.} = object
    cb*: UINT
    dwTime*: DWORD
    hTask*: HANDLE
    fEstablished*: WINBOOL
    fNoData*: WINBOOL
    hszSvc*: HSZ
    hszTopic*: HSZ
    hszItem*: HSZ
    wFmt*: UINT
    fServer*: WINBOOL
    hConvServer*: HCONV
    hConvClient*: HCONV
  PMONLINKSTRUCT* = ptr MONLINKSTRUCT
  MONCONVSTRUCT* {.pure.} = object
    cb*: UINT
    fConnect*: WINBOOL
    dwTime*: DWORD
    hTask*: HANDLE
    hszSvc*: HSZ
    hszTopic*: HSZ
    hConvClient*: HCONV
    hConvServer*: HCONV
  PMONCONVSTRUCT* = ptr MONCONVSTRUCT
const
  CDERR_DIALOGFAILURE* = 0xFFFF
  CDERR_GENERALCODES* = 0x0000
  CDERR_STRUCTSIZE* = 0x0001
  CDERR_INITIALIZATION* = 0x0002
  CDERR_NOTEMPLATE* = 0x0003
  CDERR_NOHINSTANCE* = 0x0004
  CDERR_LOADSTRFAILURE* = 0x0005
  CDERR_FINDRESFAILURE* = 0x0006
  CDERR_LOADRESFAILURE* = 0x0007
  CDERR_LOCKRESFAILURE* = 0x0008
  CDERR_MEMALLOCFAILURE* = 0x0009
  CDERR_MEMLOCKFAILURE* = 0x000A
  CDERR_NOHOOK* = 0x000B
  CDERR_REGISTERMSGFAIL* = 0x000C
  PDERR_PRINTERCODES* = 0x1000
  PDERR_SETUPFAILURE* = 0x1001
  PDERR_PARSEFAILURE* = 0x1002
  PDERR_RETDEFFAILURE* = 0x1003
  PDERR_LOADDRVFAILURE* = 0x1004
  PDERR_GETDEVMODEFAIL* = 0x1005
  PDERR_INITFAILURE* = 0x1006
  PDERR_NODEVICES* = 0x1007
  PDERR_NODEFAULTPRN* = 0x1008
  PDERR_DNDMMISMATCH* = 0x1009
  PDERR_CREATEICFAILURE* = 0x100A
  PDERR_PRINTERNOTFOUND* = 0x100B
  PDERR_DEFAULTDIFFERENT* = 0x100C
  CFERR_CHOOSEFONTCODES* = 0x2000
  CFERR_NOFONTS* = 0x2001
  CFERR_MAXLESSTHANMIN* = 0x2002
  FNERR_FILENAMECODES* = 0x3000
  FNERR_SUBCLASSFAILURE* = 0x3001
  FNERR_INVALIDFILENAME* = 0x3002
  FNERR_BUFFERTOOSMALL* = 0x3003
  FRERR_FINDREPLACECODES* = 0x4000
  FRERR_BUFFERLENGTHZERO* = 0x4001
  CCERR_CHOOSECOLORCODES* = 0x5000
  WM_DDE_FIRST* = 0x03E0
  WM_DDE_INITIATE* = WM_DDE_FIRST
  WM_DDE_TERMINATE* = WM_DDE_FIRST+1
  WM_DDE_ADVISE* = WM_DDE_FIRST+2
  WM_DDE_UNADVISE* = WM_DDE_FIRST+3
  WM_DDE_ACK* = WM_DDE_FIRST+4
  WM_DDE_DATA* = WM_DDE_FIRST+5
  WM_DDE_REQUEST* = WM_DDE_FIRST+6
  WM_DDE_POKE* = WM_DDE_FIRST+7
  WM_DDE_EXECUTE* = WM_DDE_FIRST+8
  WM_DDE_LAST* = WM_DDE_FIRST+8
  XST_NULL* = 0
  XST_INCOMPLETE* = 1
  XST_CONNECTED* = 2
  XST_INIT1* = 3
  XST_INIT2* = 4
  XST_REQSENT* = 5
  XST_DATARCVD* = 6
  XST_POKESENT* = 7
  XST_POKEACKRCVD* = 8
  XST_EXECSENT* = 9
  XST_EXECACKRCVD* = 10
  XST_ADVSENT* = 11
  XST_UNADVSENT* = 12
  XST_ADVACKRCVD* = 13
  XST_UNADVACKRCVD* = 14
  XST_ADVDATASENT* = 15
  XST_ADVDATAACKRCVD* = 16
  CADV_LATEACK* = 0xFFFF
  ST_CONNECTED* = 0x0001
  ST_ADVISE* = 0x0002
  ST_ISLOCAL* = 0x0004
  ST_BLOCKED* = 0x0008
  ST_CLIENT* = 0x0010
  ST_TERMINATED* = 0x0020
  ST_INLIST* = 0x0040
  ST_BLOCKNEXT* = 0x0080
  ST_ISSELF* = 0x0100
  DDE_FACK* = 0x8000
  DDE_FBUSY* = 0x4000
  DDE_FDEFERUPD* = 0x4000
  DDE_FACKREQ* = 0x8000
  DDE_FRELEASE* = 0x2000
  DDE_FREQUESTED* = 0x1000
  DDE_FAPPSTATUS* = 0x00ff
  DDE_FNOTPROCESSED* = 0x0000
  DDE_FACKRESERVED* = not (DDE_FACK or DDE_FBUSY or DDE_FAPPSTATUS)
  DDE_FADVRESERVED* = not (DDE_FACKREQ or DDE_FDEFERUPD)
  DDE_FDATRESERVED* = not (DDE_FACKREQ or DDE_FRELEASE or DDE_FREQUESTED)
  DDE_FPOKRESERVED* = not (DDE_FRELEASE)
  MSGF_DDEMGR* = 0x8001
  CP_WINANSI* = 1004
  CP_WINUNICODE* = 1200
  XTYPF_NOBLOCK* = 0x0002
  XTYPF_NODATA* = 0x0004
  XTYPF_ACKREQ* = 0x0008
  XCLASS_MASK* = 0xFC00
  XCLASS_BOOL* = 0x1000
  XCLASS_DATA* = 0x2000
  XCLASS_FLAGS* = 0x4000
  XCLASS_NOTIFICATION* = 0x8000
  XTYP_ERROR* = 0x0000 or XCLASS_NOTIFICATION or XTYPF_NOBLOCK
  XTYP_ADVDATA* = 0x0010 or XCLASS_FLAGS
  XTYP_ADVREQ* = 0x0020 or XCLASS_DATA or XTYPF_NOBLOCK
  XTYP_ADVSTART* = 0x0030 or XCLASS_BOOL
  XTYP_ADVSTOP* = 0x0040 or XCLASS_NOTIFICATION
  XTYP_EXECUTE* = 0x0050 or XCLASS_FLAGS
  XTYP_CONNECT* = 0x0060 or XCLASS_BOOL or XTYPF_NOBLOCK
  XTYP_CONNECT_CONFIRM* = 0x0070 or XCLASS_NOTIFICATION or XTYPF_NOBLOCK
  XTYP_XACT_COMPLETE* = 0x0080 or XCLASS_NOTIFICATION
  XTYP_POKE* = 0x0090 or XCLASS_FLAGS
  XTYP_REGISTER* = 0x00A0 or XCLASS_NOTIFICATION or XTYPF_NOBLOCK
  XTYP_REQUEST* = 0x00B0 or XCLASS_DATA
  XTYP_DISCONNECT* = 0x00C0 or XCLASS_NOTIFICATION or XTYPF_NOBLOCK
  XTYP_UNREGISTER* = 0x00D0 or XCLASS_NOTIFICATION or XTYPF_NOBLOCK
  XTYP_WILDCONNECT* = 0x00E0 or XCLASS_DATA or XTYPF_NOBLOCK
  XTYP_MASK* = 0x00F0
  XTYP_SHIFT* = 4
  TIMEOUT_ASYNC* = 0xFFFFFFFF'i32
  QID_SYNC* = 0xFFFFFFFF'i32
  SZDDESYS_TOPIC* = "System"
  SZDDESYS_ITEM_TOPICS* = "Topics"
  SZDDESYS_ITEM_SYSITEMS* = "SysItems"
  SZDDESYS_ITEM_RTNMSG* = "ReturnMessage"
  SZDDESYS_ITEM_STATUS* = "Status"
  SZDDESYS_ITEM_FORMATS* = "Formats"
  SZDDESYS_ITEM_HELP* = "Help"
  SZDDE_ITEM_ITEMLIST* = "TopicItemList"
  CBR_BLOCK* = HDDEDATA(-1)
  CBF_FAIL_SELFCONNECTIONS* = 0x00001000
  CBF_FAIL_CONNECTIONS* = 0x00002000
  CBF_FAIL_ADVISES* = 0x00004000
  CBF_FAIL_EXECUTES* = 0x00008000
  CBF_FAIL_POKES* = 0x00010000
  CBF_FAIL_REQUESTS* = 0x00020000
  CBF_FAIL_ALLSVRXACTIONS* = 0x0003f000
  CBF_SKIP_CONNECT_CONFIRMS* = 0x00040000
  CBF_SKIP_REGISTRATIONS* = 0x00080000
  CBF_SKIP_UNREGISTRATIONS* = 0x00100000
  CBF_SKIP_DISCONNECTS* = 0x00200000
  CBF_SKIP_ALLNOTIFICATIONS* = 0x003c0000
  APPCMD_CLIENTONLY* = 0x00000010
  APPCMD_FILTERINITS* = 0x00000020
  APPCMD_MASK* = 0x00000FF0
  APPCLASS_STANDARD* = 0x00000000
  APPCLASS_MASK* = 0x0000000F
  EC_ENABLEALL* = 0
  EC_ENABLEONE* = ST_BLOCKNEXT
  EC_DISABLE* = ST_BLOCKED
  EC_QUERYWAITING* = 2
  DNS_REGISTER* = 0x0001
  DNS_UNREGISTER* = 0x0002
  DNS_FILTERON* = 0x0004
  DNS_FILTEROFF* = 0x0008
  HDATA_APPOWNED* = 0x0001
  DMLERR_NO_ERROR* = 0
  DMLERR_FIRST* = 0x4000
  DMLERR_ADVACKTIMEOUT* = 0x4000
  DMLERR_BUSY* = 0x4001
  DMLERR_DATAACKTIMEOUT* = 0x4002
  DMLERR_DLL_NOT_INITIALIZED* = 0x4003
  DMLERR_DLL_USAGE* = 0x4004
  DMLERR_EXECACKTIMEOUT* = 0x4005
  DMLERR_INVALIDPARAMETER* = 0x4006
  DMLERR_LOW_MEMORY* = 0x4007
  DMLERR_MEMORY_ERROR* = 0x4008
  DMLERR_NOTPROCESSED* = 0x4009
  DMLERR_NO_CONV_ESTABLISHED* = 0x400a
  DMLERR_POKEACKTIMEOUT* = 0x400b
  DMLERR_POSTMSG_FAILED* = 0x400c
  DMLERR_REENTRANCY* = 0x400d
  DMLERR_SERVER_DIED* = 0x400e
  DMLERR_SYS_ERROR* = 0x400f
  DMLERR_UNADVACKTIMEOUT* = 0x4010
  DMLERR_UNFOUND_QUEUE_ID* = 0x4011
  DMLERR_LAST* = 0x4011
  MH_CREATE* = 1
  MH_KEEP* = 2
  MH_DELETE* = 3
  MH_CLEANUP* = 4
  MAX_MONITORS* = 4
  APPCLASS_MONITOR* = 0x00000001
  XTYP_MONITOR* = 0x00F0 or XCLASS_NOTIFICATION or XTYPF_NOBLOCK
  MF_HSZ_INFO* = 0x01000000
  MF_SENDMSGS* = 0x02000000
  MF_POSTMSGS* = 0x04000000
  MF_CALLBACKS* = 0x08000000
  MF_ERRORS* = 0x10000000
  MF_LINKS* = 0x20000000
  MF_CONV* = 0x40000000
  MF_MASK* = 0xFF000000'i32
type
  FNCALLBACK* = proc (wType: UINT, wFmt: UINT, hConv: HCONV, hsz1: HSZ, hsz2: HSZ, hData: HDDEDATA, dwData1: ULONG_PTR, dwData2: ULONG_PTR): HDDEDATA {.stdcall.}
  PFNCALLBACK* = proc (wType: UINT, wFmt: UINT, hConv: HCONV, hsz1: HSZ, hsz2: HSZ, hData: HDDEDATA, dwData1: ULONG_PTR, dwData2: ULONG_PTR): HDDEDATA {.stdcall.}
  DDEACK* {.pure.} = object
    bAppReturnCode* {.bitsize:8.}: uint16
    reserved* {.bitsize:6.}: uint16
    fBusy* {.bitsize:1.}: uint16
    fAck* {.bitsize:1.}: uint16
  DDEADVISE* {.pure.} = object
    reserved* {.bitsize:14.}: uint16
    fDeferUpd* {.bitsize:1.}: uint16
    fAckReq* {.bitsize:1.}: uint16
    cfFormat*: int16
  DDEDATA* {.pure.} = object
    unused* {.bitsize:12.}: uint16
    fResponse* {.bitsize:1.}: uint16
    fRelease* {.bitsize:1.}: uint16
    reserved* {.bitsize:1.}: uint16
    fAckReq* {.bitsize:1.}: uint16
    cfFormat*: int16
    Value*: array[1, BYTE]
  DDEPOKE* {.pure.} = object
    unused* {.bitsize:13.}: uint16
    fRelease* {.bitsize:1.}: uint16
    fReserved* {.bitsize:2.}: uint16
    cfFormat*: int16
    Value*: array[1, BYTE]
  DDELN* {.pure.} = object
    unused* {.bitsize:13.}: uint16
    fRelease* {.bitsize:1.}: uint16
    fDeferUpd* {.bitsize:1.}: uint16
    fAckReq* {.bitsize:1.}: uint16
    cfFormat*: int16
  DDEUP* {.pure.} = object
    unused* {.bitsize:12.}: uint16
    fAck* {.bitsize:1.}: uint16
    fRelease* {.bitsize:1.}: uint16
    fReserved* {.bitsize:1.}: uint16
    fAckReq* {.bitsize:1.}: uint16
    cfFormat*: int16
    rgb*: array[1, BYTE]
proc DdeSetQualityOfService*(hwndClient: HWND, pqosNew: ptr SECURITY_QUALITY_OF_SERVICE, pqosPrev: PSECURITY_QUALITY_OF_SERVICE): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ImpersonateDdeClientWindow*(hWndClient: HWND, hWndServer: HWND): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc PackDDElParam*(msg: UINT, uiLo: UINT_PTR, uiHi: UINT_PTR): LPARAM {.winapi, stdcall, dynlib: "user32", importc.}
proc UnpackDDElParam*(msg: UINT, lParam: LPARAM, puiLo: PUINT_PTR, puiHi: PUINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc FreeDDElParam*(msg: UINT, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc ReuseDDElParam*(lParam: LPARAM, msgIn: UINT, msgOut: UINT, uiLo: UINT_PTR, uiHi: UINT_PTR): LPARAM {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeInitializeA*(pidInst: LPDWORD, pfnCallback: PFNCALLBACK, afCmd: DWORD, ulRes: DWORD): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeInitializeW*(pidInst: LPDWORD, pfnCallback: PFNCALLBACK, afCmd: DWORD, ulRes: DWORD): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeUninitialize*(idInst: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeConnectList*(idInst: DWORD, hszService: HSZ, hszTopic: HSZ, hConvList: HCONVLIST, pCC: PCONVCONTEXT): HCONVLIST {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeQueryNextServer*(hConvList: HCONVLIST, hConvPrev: HCONV): HCONV {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeDisconnectList*(hConvList: HCONVLIST): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeConnect*(idInst: DWORD, hszService: HSZ, hszTopic: HSZ, pCC: PCONVCONTEXT): HCONV {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeDisconnect*(hConv: HCONV): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeReconnect*(hConv: HCONV): HCONV {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeQueryConvInfo*(hConv: HCONV, idTransaction: DWORD, pConvInfo: PCONVINFO): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeSetUserHandle*(hConv: HCONV, id: DWORD, hUser: DWORD_PTR): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeAbandonTransaction*(idInst: DWORD, hConv: HCONV, idTransaction: DWORD): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdePostAdvise*(idInst: DWORD, hszTopic: HSZ, hszItem: HSZ): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeEnableCallback*(idInst: DWORD, hConv: HCONV, wCmd: UINT): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeImpersonateClient*(hConv: HCONV): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeNameService*(idInst: DWORD, hsz1: HSZ, hsz2: HSZ, afCmd: UINT): HDDEDATA {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeClientTransaction*(pData: LPBYTE, cbData: DWORD, hConv: HCONV, hszItem: HSZ, wFmt: UINT, wType: UINT, dwTimeout: DWORD, pdwResult: LPDWORD): HDDEDATA {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeCreateDataHandle*(idInst: DWORD, pSrc: LPBYTE, cb: DWORD, cbOff: DWORD, hszItem: HSZ, wFmt: UINT, afCmd: UINT): HDDEDATA {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeAddData*(hData: HDDEDATA, pSrc: LPBYTE, cb: DWORD, cbOff: DWORD): HDDEDATA {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeGetData*(hData: HDDEDATA, pDst: LPBYTE, cbMax: DWORD, cbOff: DWORD): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeAccessData*(hData: HDDEDATA, pcbDataSize: LPDWORD): LPBYTE {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeUnaccessData*(hData: HDDEDATA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeFreeDataHandle*(hData: HDDEDATA): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeGetLastError*(idInst: DWORD): UINT {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeCreateStringHandleA*(idInst: DWORD, psz: LPCSTR, iCodePage: int32): HSZ {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeCreateStringHandleW*(idInst: DWORD, psz: LPCWSTR, iCodePage: int32): HSZ {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeQueryStringA*(idInst: DWORD, hsz: HSZ, psz: LPSTR, cchMax: DWORD, iCodePage: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeQueryStringW*(idInst: DWORD, hsz: HSZ, psz: LPWSTR, cchMax: DWORD, iCodePage: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeFreeStringHandle*(idInst: DWORD, hsz: HSZ): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeKeepStringHandle*(idInst: DWORD, hsz: HSZ): WINBOOL {.winapi, stdcall, dynlib: "user32", importc.}
proc DdeCmpStringHandles*(hsz1: HSZ, hsz2: HSZ): int32 {.winapi, stdcall, dynlib: "user32", importc.}
when winimUnicode:
  type
    MONHSZSTRUCT* = MONHSZSTRUCTW
    PMONHSZSTRUCT* = PMONHSZSTRUCTW
  const
    CP_WINNEUTRAL* = CP_WINUNICODE
  proc DdeInitialize*(pidInst: LPDWORD, pfnCallback: PFNCALLBACK, afCmd: DWORD, ulRes: DWORD): UINT {.winapi, stdcall, dynlib: "user32", importc: "DdeInitializeW".}
  proc DdeCreateStringHandle*(idInst: DWORD, psz: LPCWSTR, iCodePage: int32): HSZ {.winapi, stdcall, dynlib: "user32", importc: "DdeCreateStringHandleW".}
  proc DdeQueryString*(idInst: DWORD, hsz: HSZ, psz: LPWSTR, cchMax: DWORD, iCodePage: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc: "DdeQueryStringW".}
when winimAnsi:
  type
    MONHSZSTRUCT* = MONHSZSTRUCTA
    PMONHSZSTRUCT* = PMONHSZSTRUCTA
  const
    CP_WINNEUTRAL* = CP_WINANSI
  proc DdeInitialize*(pidInst: LPDWORD, pfnCallback: PFNCALLBACK, afCmd: DWORD, ulRes: DWORD): UINT {.winapi, stdcall, dynlib: "user32", importc: "DdeInitializeA".}
  proc DdeCreateStringHandle*(idInst: DWORD, psz: LPCSTR, iCodePage: int32): HSZ {.winapi, stdcall, dynlib: "user32", importc: "DdeCreateStringHandleA".}
  proc DdeQueryString*(idInst: DWORD, hsz: HSZ, psz: LPSTR, cchMax: DWORD, iCodePage: int32): DWORD {.winapi, stdcall, dynlib: "user32", importc: "DdeQueryStringA".}
