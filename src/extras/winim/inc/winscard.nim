#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import rpc
import winioctl
#include <winscard.h>
#include <winsmcrd.h>
#include <scarderr.h>
type
  LPCBYTE* = ptr BYTE
  SCARDCONTEXT* = ULONG_PTR
  SCARDHANDLE* = ULONG_PTR
  SCARD_IO_REQUEST* {.pure.} = object
    dwProtocol*: DWORD
    cbPciLength*: DWORD
  PSCARD_IO_REQUEST* = ptr SCARD_IO_REQUEST
  LPSCARD_IO_REQUEST* = ptr SCARD_IO_REQUEST
  LPCSCARD_IO_REQUEST* = ptr SCARD_IO_REQUEST
  SCARD_T0_COMMAND* {.pure.} = object
    bCla*: BYTE
    bIns*: BYTE
    bP1*: BYTE
    bP2*: BYTE
    bP3*: BYTE
  LPSCARD_T0_COMMAND* = ptr SCARD_T0_COMMAND
  SCARD_T0_REQUEST_UNION1* {.pure, union.} = object
    CmdBytes*: SCARD_T0_COMMAND
    rgbHeader*: array[5, BYTE]
  SCARD_T0_REQUEST* {.pure.} = object
    ioRequest*: SCARD_IO_REQUEST
    bSw1*: BYTE
    bSw2*: BYTE
    union1*: SCARD_T0_REQUEST_UNION1
  PSCARD_T0_REQUEST* = ptr SCARD_T0_REQUEST
  LPSCARD_T0_REQUEST* = ptr SCARD_T0_REQUEST
  SCARD_T1_REQUEST* {.pure.} = object
    ioRequest*: SCARD_IO_REQUEST
  PSCARD_T1_REQUEST* = ptr SCARD_T1_REQUEST
  LPSCARD_T1_REQUEST* = ptr SCARD_T1_REQUEST
  PSCARDCONTEXT* = ptr SCARDCONTEXT
  LPSCARDCONTEXT* = ptr SCARDCONTEXT
  PSCARDHANDLE* = ptr SCARDHANDLE
  LPSCARDHANDLE* = ptr SCARDHANDLE
  SCARD_READERSTATEA* {.pure.} = object
    szReader*: LPCSTR
    pvUserData*: LPVOID
    dwCurrentState*: DWORD
    dwEventState*: DWORD
    cbAtr*: DWORD
    rgbAtr*: array[36, BYTE]
  PSCARD_READERSTATEA* = ptr SCARD_READERSTATEA
  LPSCARD_READERSTATEA* = ptr SCARD_READERSTATEA
  SCARD_READERSTATEW* {.pure.} = object
    szReader*: LPCWSTR
    pvUserData*: LPVOID
    dwCurrentState*: DWORD
    dwEventState*: DWORD
    cbAtr*: DWORD
    rgbAtr*: array[36, BYTE]
  PSCARD_READERSTATEW* = ptr SCARD_READERSTATEW
  LPSCARD_READERSTATEW* = ptr SCARD_READERSTATEW
  SCARD_ATRMASK* {.pure.} = object
    cbAtr*: DWORD
    rgbAtr*: array[36, BYTE]
    rgbMask*: array[36, BYTE]
  PSCARD_ATRMASK* = ptr SCARD_ATRMASK
  LPSCARD_ATRMASK* = ptr SCARD_ATRMASK
  LPOCNCHKPROC* = proc (P1: SCARDCONTEXT, P2: SCARDHANDLE, P3: PVOID): WINBOOL {.stdcall.}
  LPOCNCONNPROCA* = proc (P1: SCARDCONTEXT, P2: LPSTR, P3: LPSTR, P4: PVOID): SCARDHANDLE {.stdcall.}
  LPOCNDSCPROC* = proc (P1: SCARDCONTEXT, P2: SCARDHANDLE, P3: PVOID): void {.stdcall.}
  OPENCARD_SEARCH_CRITERIAA* {.pure.} = object
    dwStructSize*: DWORD
    lpstrGroupNames*: LPSTR
    nMaxGroupNames*: DWORD
    rgguidInterfaces*: LPCGUID
    cguidInterfaces*: DWORD
    lpstrCardNames*: LPSTR
    nMaxCardNames*: DWORD
    lpfnCheck*: LPOCNCHKPROC
    lpfnConnect*: LPOCNCONNPROCA
    lpfnDisconnect*: LPOCNDSCPROC
    pvUserData*: LPVOID
    dwShareMode*: DWORD
    dwPreferredProtocols*: DWORD
  POPENCARD_SEARCH_CRITERIAA* = ptr OPENCARD_SEARCH_CRITERIAA
  LPOPENCARD_SEARCH_CRITERIAA* = ptr OPENCARD_SEARCH_CRITERIAA
  LPOCNCONNPROCW* = proc (P1: SCARDCONTEXT, P2: LPWSTR, P3: LPWSTR, P4: PVOID): SCARDHANDLE {.stdcall.}
  OPENCARD_SEARCH_CRITERIAW* {.pure.} = object
    dwStructSize*: DWORD
    lpstrGroupNames*: LPWSTR
    nMaxGroupNames*: DWORD
    rgguidInterfaces*: LPCGUID
    cguidInterfaces*: DWORD
    lpstrCardNames*: LPWSTR
    nMaxCardNames*: DWORD
    lpfnCheck*: LPOCNCHKPROC
    lpfnConnect*: LPOCNCONNPROCW
    lpfnDisconnect*: LPOCNDSCPROC
    pvUserData*: LPVOID
    dwShareMode*: DWORD
    dwPreferredProtocols*: DWORD
  POPENCARD_SEARCH_CRITERIAW* = ptr OPENCARD_SEARCH_CRITERIAW
  LPOPENCARD_SEARCH_CRITERIAW* = ptr OPENCARD_SEARCH_CRITERIAW
  OPENCARDNAME_EXA* {.pure.} = object
    dwStructSize*: DWORD
    hSCardContext*: SCARDCONTEXT
    hwndOwner*: HWND
    dwFlags*: DWORD
    lpstrTitle*: LPCSTR
    lpstrSearchDesc*: LPCSTR
    hIcon*: HICON
    pOpenCardSearchCriteria*: POPENCARD_SEARCH_CRITERIAA
    lpfnConnect*: LPOCNCONNPROCA
    pvUserData*: LPVOID
    dwShareMode*: DWORD
    dwPreferredProtocols*: DWORD
    lpstrRdr*: LPSTR
    nMaxRdr*: DWORD
    lpstrCard*: LPSTR
    nMaxCard*: DWORD
    dwActiveProtocol*: DWORD
    hCardHandle*: SCARDHANDLE
  POPENCARDNAME_EXA* = ptr OPENCARDNAME_EXA
  LPOPENCARDNAME_EXA* = ptr OPENCARDNAME_EXA
  OPENCARDNAME_EXW* {.pure.} = object
    dwStructSize*: DWORD
    hSCardContext*: SCARDCONTEXT
    hwndOwner*: HWND
    dwFlags*: DWORD
    lpstrTitle*: LPCWSTR
    lpstrSearchDesc*: LPCWSTR
    hIcon*: HICON
    pOpenCardSearchCriteria*: POPENCARD_SEARCH_CRITERIAW
    lpfnConnect*: LPOCNCONNPROCW
    pvUserData*: LPVOID
    dwShareMode*: DWORD
    dwPreferredProtocols*: DWORD
    lpstrRdr*: LPWSTR
    nMaxRdr*: DWORD
    lpstrCard*: LPWSTR
    nMaxCard*: DWORD
    dwActiveProtocol*: DWORD
    hCardHandle*: SCARDHANDLE
  POPENCARDNAME_EXW* = ptr OPENCARDNAME_EXW
  LPOPENCARDNAME_EXW* = ptr OPENCARDNAME_EXW
  OPENCARDNAMEA_EX* = OPENCARDNAME_EXA
  OPENCARDNAMEW_EX* = OPENCARDNAME_EXW
  POPENCARDNAMEA_EX* = POPENCARDNAME_EXA
  POPENCARDNAMEW_EX* = POPENCARDNAME_EXW
  LPOPENCARDNAMEA_EX* = LPOPENCARDNAME_EXA
  LPOPENCARDNAMEW_EX* = LPOPENCARDNAME_EXW
  OPENCARDNAMEA* {.pure.} = object
    dwStructSize*: DWORD
    hwndOwner*: HWND
    hSCardContext*: SCARDCONTEXT
    lpstrGroupNames*: LPSTR
    nMaxGroupNames*: DWORD
    lpstrCardNames*: LPSTR
    nMaxCardNames*: DWORD
    rgguidInterfaces*: LPCGUID
    cguidInterfaces*: DWORD
    lpstrRdr*: LPSTR
    nMaxRdr*: DWORD
    lpstrCard*: LPSTR
    nMaxCard*: DWORD
    lpstrTitle*: LPCSTR
    dwFlags*: DWORD
    pvUserData*: LPVOID
    dwShareMode*: DWORD
    dwPreferredProtocols*: DWORD
    dwActiveProtocol*: DWORD
    lpfnConnect*: LPOCNCONNPROCA
    lpfnCheck*: LPOCNCHKPROC
    lpfnDisconnect*: LPOCNDSCPROC
    hCardHandle*: SCARDHANDLE
  POPENCARDNAMEA* = ptr OPENCARDNAMEA
  LPOPENCARDNAMEA* = ptr OPENCARDNAMEA
  OPENCARDNAMEW* {.pure.} = object
    dwStructSize*: DWORD
    hwndOwner*: HWND
    hSCardContext*: SCARDCONTEXT
    lpstrGroupNames*: LPWSTR
    nMaxGroupNames*: DWORD
    lpstrCardNames*: LPWSTR
    nMaxCardNames*: DWORD
    rgguidInterfaces*: LPCGUID
    cguidInterfaces*: DWORD
    lpstrRdr*: LPWSTR
    nMaxRdr*: DWORD
    lpstrCard*: LPWSTR
    nMaxCard*: DWORD
    lpstrTitle*: LPCWSTR
    dwFlags*: DWORD
    pvUserData*: LPVOID
    dwShareMode*: DWORD
    dwPreferredProtocols*: DWORD
    dwActiveProtocol*: DWORD
    lpfnConnect*: LPOCNCONNPROCW
    lpfnCheck*: LPOCNCHKPROC
    lpfnDisconnect*: LPOCNDSCPROC
    hCardHandle*: SCARDHANDLE
  POPENCARDNAMEW* = ptr OPENCARDNAMEW
  LPOPENCARDNAMEW* = ptr OPENCARDNAMEW
const
  SCARD_ATR_LENGTH* = 33
  SCARD_PROTOCOL_UNDEFINED* = 0x00000000
  SCARD_PROTOCOL_T0* = 0x00000001
  SCARD_PROTOCOL_T1* = 0x00000002
  SCARD_PROTOCOL_RAW* = 0x00010000
  SCARD_PROTOCOL_Tx* = SCARD_PROTOCOL_T0 or SCARD_PROTOCOL_T1
  SCARD_PROTOCOL_DEFAULT* = 0x80000000'i32
  SCARD_PROTOCOL_OPTIMAL* = 0x00000000
  SCARD_POWER_DOWN* = 0
  SCARD_COLD_RESET* = 1
  SCARD_WARM_RESET* = 2
template SCARD_CTL_CODE*(code: untyped): untyped = CTL_CODE(FILE_DEVICE_SMARTCARD, code, METHOD_BUFFERED, FILE_ANY_ACCESS)
const
  IOCTL_SMARTCARD_POWER* = SCARD_CTL_CODE(1)
  IOCTL_SMARTCARD_GET_ATTRIBUTE* = SCARD_CTL_CODE(2)
  IOCTL_SMARTCARD_SET_ATTRIBUTE* = SCARD_CTL_CODE(3)
  IOCTL_SMARTCARD_CONFISCATE* = SCARD_CTL_CODE(4)
  IOCTL_SMARTCARD_TRANSMIT* = SCARD_CTL_CODE(5)
  IOCTL_SMARTCARD_EJECT* = SCARD_CTL_CODE(6)
  IOCTL_SMARTCARD_SWALLOW* = SCARD_CTL_CODE(7)
  IOCTL_SMARTCARD_IS_PRESENT* = SCARD_CTL_CODE(10)
  IOCTL_SMARTCARD_IS_ABSENT* = SCARD_CTL_CODE(11)
  IOCTL_SMARTCARD_SET_PROTOCOL* = SCARD_CTL_CODE(12)
  IOCTL_SMARTCARD_GET_STATE* = SCARD_CTL_CODE(14)
  IOCTL_SMARTCARD_GET_LAST_ERROR* = SCARD_CTL_CODE(15)
  IOCTL_SMARTCARD_GET_PERF_CNTR* = SCARD_CTL_CODE(16)
  MAXIMUM_ATTR_STRING_LENGTH* = 32
  MAXIMUM_SMARTCARD_READERS* = 10
  SCARD_CLASS_VENDOR_INFO* = 1
  SCARD_CLASS_COMMUNICATIONS* = 2
  SCARD_CLASS_PROTOCOL* = 3
  SCARD_CLASS_POWER_MGMT* = 4
  SCARD_CLASS_SECURITY* = 5
  SCARD_CLASS_MECHANICAL* = 6
  SCARD_CLASS_VENDOR_DEFINED* = 7
  SCARD_CLASS_IFD_PROTOCOL* = 8
  SCARD_CLASS_ICC_STATE* = 9
  SCARD_CLASS_PERF* = 0x7ffe
  SCARD_CLASS_SYSTEM* = 0x7fff
template SCARD_ATTR_VALUE*(class: untyped, tag: untyped): untyped = (class shl 16) or tag
const
  SCARD_ATTR_VENDOR_NAME* = SCARD_ATTR_VALUE(SCARD_CLASS_VENDOR_INFO,0x0100)
  SCARD_ATTR_VENDOR_IFD_TYPE* = SCARD_ATTR_VALUE(SCARD_CLASS_VENDOR_INFO,0x0101)
  SCARD_ATTR_VENDOR_IFD_VERSION* = SCARD_ATTR_VALUE(SCARD_CLASS_VENDOR_INFO,0x0102)
  SCARD_ATTR_VENDOR_IFD_SERIAL_NO* = SCARD_ATTR_VALUE(SCARD_CLASS_VENDOR_INFO,0x0103)
  SCARD_ATTR_CHANNEL_ID* = SCARD_ATTR_VALUE(SCARD_CLASS_COMMUNICATIONS,0x0110)
  SCARD_ATTR_PROTOCOL_TYPES* = SCARD_ATTR_VALUE(SCARD_CLASS_PROTOCOL,0x0120)
  SCARD_ATTR_DEFAULT_CLK* = SCARD_ATTR_VALUE(SCARD_CLASS_PROTOCOL,0x0121)
  SCARD_ATTR_MAX_CLK* = SCARD_ATTR_VALUE(SCARD_CLASS_PROTOCOL,0x0122)
  SCARD_ATTR_DEFAULT_DATA_RATE* = SCARD_ATTR_VALUE(SCARD_CLASS_PROTOCOL,0x0123)
  SCARD_ATTR_MAX_DATA_RATE* = SCARD_ATTR_VALUE(SCARD_CLASS_PROTOCOL,0x0124)
  SCARD_ATTR_MAX_IFSD* = SCARD_ATTR_VALUE(SCARD_CLASS_PROTOCOL,0x0125)
  SCARD_ATTR_POWER_MGMT_SUPPORT* = SCARD_ATTR_VALUE(SCARD_CLASS_POWER_MGMT,0x0131)
  SCARD_ATTR_USER_TO_CARD_AUTH_DEVICE* = SCARD_ATTR_VALUE(SCARD_CLASS_SECURITY,0x0140)
  SCARD_ATTR_USER_AUTH_INPUT_DEVICE* = SCARD_ATTR_VALUE(SCARD_CLASS_SECURITY,0x0142)
  SCARD_ATTR_CHARACTERISTICS* = SCARD_ATTR_VALUE(SCARD_CLASS_MECHANICAL,0x0150)
  SCARD_ATTR_CURRENT_PROTOCOL_TYPE* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0201)
  SCARD_ATTR_CURRENT_CLK* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0202)
  SCARD_ATTR_CURRENT_F* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0203)
  SCARD_ATTR_CURRENT_D* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0204)
  SCARD_ATTR_CURRENT_N* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0205)
  SCARD_ATTR_CURRENT_W* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0206)
  SCARD_ATTR_CURRENT_IFSC* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0207)
  SCARD_ATTR_CURRENT_IFSD* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0208)
  SCARD_ATTR_CURRENT_BWT* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x0209)
  SCARD_ATTR_CURRENT_CWT* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x020a)
  SCARD_ATTR_CURRENT_EBC_ENCODING* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x020b)
  SCARD_ATTR_EXTENDED_BWT* = SCARD_ATTR_VALUE(SCARD_CLASS_IFD_PROTOCOL,0x020c)
  SCARD_ATTR_ICC_PRESENCE* = SCARD_ATTR_VALUE(SCARD_CLASS_ICC_STATE,0x0300)
  SCARD_ATTR_ICC_INTERFACE_STATUS* = SCARD_ATTR_VALUE(SCARD_CLASS_ICC_STATE,0x0301)
  SCARD_ATTR_CURRENT_IO_STATE* = SCARD_ATTR_VALUE(SCARD_CLASS_ICC_STATE,0x0302)
  SCARD_ATTR_ATR_STRING* = SCARD_ATTR_VALUE(SCARD_CLASS_ICC_STATE,0x0303)
  SCARD_ATTR_ICC_TYPE_PER_ATR* = SCARD_ATTR_VALUE(SCARD_CLASS_ICC_STATE,0x0304)
  SCARD_ATTR_ESC_RESET* = SCARD_ATTR_VALUE(SCARD_CLASS_VENDOR_DEFINED,0xA000)
  SCARD_ATTR_ESC_CANCEL* = SCARD_ATTR_VALUE(SCARD_CLASS_VENDOR_DEFINED,0xA003)
  SCARD_ATTR_ESC_AUTHREQUEST* = SCARD_ATTR_VALUE(SCARD_CLASS_VENDOR_DEFINED,0xA005)
  SCARD_ATTR_MAXINPUT* = SCARD_ATTR_VALUE(SCARD_CLASS_VENDOR_DEFINED,0xA007)
  SCARD_ATTR_DEVICE_UNIT* = SCARD_ATTR_VALUE(SCARD_CLASS_SYSTEM,0x0001)
  SCARD_ATTR_DEVICE_IN_USE* = SCARD_ATTR_VALUE(SCARD_CLASS_SYSTEM,0x0002)
  SCARD_ATTR_DEVICE_FRIENDLY_NAME_A* = SCARD_ATTR_VALUE(SCARD_CLASS_SYSTEM,0x0003)
  SCARD_ATTR_DEVICE_SYSTEM_NAME_A* = SCARD_ATTR_VALUE(SCARD_CLASS_SYSTEM,0x0004)
  SCARD_ATTR_DEVICE_FRIENDLY_NAME_W* = SCARD_ATTR_VALUE(SCARD_CLASS_SYSTEM,0x0005)
  SCARD_ATTR_DEVICE_SYSTEM_NAME_W* = SCARD_ATTR_VALUE(SCARD_CLASS_SYSTEM,0x0006)
  SCARD_ATTR_SUPRESS_T1_IFS_REQUEST* = SCARD_ATTR_VALUE(SCARD_CLASS_SYSTEM,0x0007)
  SCARD_PERF_NUM_TRANSMISSIONS* = SCARD_ATTR_VALUE(SCARD_CLASS_PERF,0x0001)
  SCARD_PERF_BYTES_TRANSMITTED* = SCARD_ATTR_VALUE(SCARD_CLASS_PERF,0x0002)
  SCARD_PERF_TRANSMISSION_TIME* = SCARD_ATTR_VALUE(SCARD_CLASS_PERF,0x0003)
  SCARD_T0_HEADER_LENGTH* = 7
  SCARD_T0_CMD_LENGTH* = 5
  SCARD_T1_PROLOGUE_LENGTH* = 3
  SCARD_T1_EPILOGUE_LENGTH* = 2
  SCARD_T1_MAX_IFS* = 254
  SCARD_UNKNOWN* = 0
  SCARD_ABSENT* = 1
  SCARD_PRESENT* = 2
  SCARD_SWALLOWED* = 3
  SCARD_POWERED* = 4
  SCARD_NEGOTIABLE* = 5
  SCARD_SPECIFIC* = 6
  SCARD_READER_SWALLOWS* = 0x00000001
  SCARD_READER_EJECTS* = 0x00000002
  SCARD_READER_CONFISCATES* = 0x00000004
  SCARD_READER_TYPE_SERIAL* = 0x01
  SCARD_READER_TYPE_PARALELL* = 0x02
  SCARD_READER_TYPE_KEYBOARD* = 0x04
  SCARD_READER_TYPE_SCSI* = 0x08
  SCARD_READER_TYPE_IDE* = 0x10
  SCARD_READER_TYPE_USB* = 0x20
  SCARD_READER_TYPE_PCMCIA* = 0x40
  SCARD_READER_TYPE_VENDOR* = 0xF0
  FACILITY_SYSTEM* = 0x0
  SCARD_SCOPE_USER* = 0
  SCARD_SCOPE_TERMINAL* = 1
  SCARD_SCOPE_SYSTEM* = 2
  SCARD_ALL_READERS* = "SCard$AllReaders\0"
  SCARD_DEFAULT_READERS* = "SCard$DefaultReaders\0"
  SCARD_LOCAL_READERS* = "SCard$LocalReaders\0"
  SCARD_SYSTEM_READERS* = "SCard$SystemReaders\0"
  SCARD_PROVIDER_PRIMARY* = 1
  SCARD_PROVIDER_CSP* = 2
  SCARD_STATE_UNAWARE* = 0x00000000
  SCARD_STATE_IGNORE* = 0x00000001
  SCARD_STATE_CHANGED* = 0x00000002
  SCARD_STATE_UNKNOWN* = 0x00000004
  SCARD_STATE_UNAVAILABLE* = 0x00000008
  SCARD_STATE_EMPTY* = 0x00000010
  SCARD_STATE_PRESENT* = 0x00000020
  SCARD_STATE_ATRMATCH* = 0x00000040
  SCARD_STATE_EXCLUSIVE* = 0x00000080
  SCARD_STATE_INUSE* = 0x00000100
  SCARD_STATE_MUTE* = 0x00000200
  SCARD_STATE_UNPOWERED* = 0x00000400
  SCARD_SHARE_EXCLUSIVE* = 1
  SCARD_SHARE_SHARED* = 2
  SCARD_SHARE_DIRECT* = 3
  SCARD_LEAVE_CARD* = 0
  SCARD_RESET_CARD* = 1
  SCARD_UNPOWER_CARD* = 2
  SCARD_EJECT_CARD* = 3
  SC_DLG_MINIMAL_UI* = 0x01
  SC_DLG_NO_UI* = 0x02
  SC_DLG_FORCE_UI* = 0x04
  SCERR_NOCARDNAME* = 0x4000
  SCERR_NOGUIDS* = 0x8000
  SCARD_AUTOALLOCATE* = DWORD(-1)
proc SCardEstablishContext*(dwScope: DWORD, pvReserved1: LPCVOID, pvReserved2: LPCVOID, phContext: LPSCARDCONTEXT): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardReleaseContext*(hContext: SCARDCONTEXT): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardIsValidContext*(hContext: SCARDCONTEXT): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardListReaderGroupsA*(hContext: SCARDCONTEXT, mszGroups: LPSTR, pcchGroups: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardListReaderGroupsW*(hContext: SCARDCONTEXT, mszGroups: LPWSTR, pcchGroups: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardListReadersA*(hContext: SCARDCONTEXT, mszGroups: LPCSTR, mszReaders: LPSTR, pcchReaders: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardListReadersW*(hContext: SCARDCONTEXT, mszGroups: LPCWSTR, mszReaders: LPWSTR, pcchReaders: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardListCardsA*(hContext: SCARDCONTEXT, pbAtr: LPCBYTE, rgquidInterfaces: LPCGUID, cguidInterfaceCount: DWORD, mszCards: LPSTR, pcchCards: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardListCardsW*(hContext: SCARDCONTEXT, pbAtr: LPCBYTE, rgquidInterfaces: LPCGUID, cguidInterfaceCount: DWORD, mszCards: LPWSTR, pcchCards: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardListInterfacesA*(hContext: SCARDCONTEXT, szCard: LPCSTR, pguidInterfaces: LPGUID, pcguidInterfaces: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardListInterfacesW*(hContext: SCARDCONTEXT, szCard: LPCWSTR, pguidInterfaces: LPGUID, pcguidInterfaces: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardGetProviderIdA*(hContext: SCARDCONTEXT, szCard: LPCSTR, pguidProviderId: LPGUID): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardGetProviderIdW*(hContext: SCARDCONTEXT, szCard: LPCWSTR, pguidProviderId: LPGUID): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardGetCardTypeProviderNameA*(hContext: SCARDCONTEXT, szCardName: LPCSTR, dwProviderId: DWORD, szProvider: LPSTR, pcchProvider: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardGetCardTypeProviderNameW*(hContext: SCARDCONTEXT, szCardName: LPCWSTR, dwProviderId: DWORD, szProvider: LPWSTR, pcchProvider: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardIntroduceReaderGroupA*(hContext: SCARDCONTEXT, szGroupName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardIntroduceReaderGroupW*(hContext: SCARDCONTEXT, szGroupName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardForgetReaderGroupA*(hContext: SCARDCONTEXT, szGroupName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardForgetReaderGroupW*(hContext: SCARDCONTEXT, szGroupName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardIntroduceReaderA*(hContext: SCARDCONTEXT, szReaderName: LPCSTR, szDeviceName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardIntroduceReaderW*(hContext: SCARDCONTEXT, szReaderName: LPCWSTR, szDeviceName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardForgetReaderA*(hContext: SCARDCONTEXT, szReaderName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardForgetReaderW*(hContext: SCARDCONTEXT, szReaderName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardAddReaderToGroupA*(hContext: SCARDCONTEXT, szReaderName: LPCSTR, szGroupName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardAddReaderToGroupW*(hContext: SCARDCONTEXT, szReaderName: LPCWSTR, szGroupName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardRemoveReaderFromGroupA*(hContext: SCARDCONTEXT, szReaderName: LPCSTR, szGroupName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardRemoveReaderFromGroupW*(hContext: SCARDCONTEXT, szReaderName: LPCWSTR, szGroupName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardIntroduceCardTypeA*(hContext: SCARDCONTEXT, szCardName: LPCSTR, pguidPrimaryProvider: LPCGUID, rgguidInterfaces: LPCGUID, dwInterfaceCount: DWORD, pbAtr: LPCBYTE, pbAtrMask: LPCBYTE, cbAtrLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardIntroduceCardTypeW*(hContext: SCARDCONTEXT, szCardName: LPCWSTR, pguidPrimaryProvider: LPCGUID, rgguidInterfaces: LPCGUID, dwInterfaceCount: DWORD, pbAtr: LPCBYTE, pbAtrMask: LPCBYTE, cbAtrLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardSetCardTypeProviderNameA*(hContext: SCARDCONTEXT, szCardName: LPCSTR, dwProviderId: DWORD, szProvider: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardSetCardTypeProviderNameW*(hContext: SCARDCONTEXT, szCardName: LPCWSTR, dwProviderId: DWORD, szProvider: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardForgetCardTypeA*(hContext: SCARDCONTEXT, szCardName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardForgetCardTypeW*(hContext: SCARDCONTEXT, szCardName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardFreeMemory*(hContext: SCARDCONTEXT, pvMem: LPCVOID): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardAccessStartedEvent*(): HANDLE {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardReleaseStartedEvent*(): void {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardLocateCardsA*(hContext: SCARDCONTEXT, mszCards: LPCSTR, rgReaderStates: LPSCARD_READERSTATEA, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardLocateCardsW*(hContext: SCARDCONTEXT, mszCards: LPCWSTR, rgReaderStates: LPSCARD_READERSTATEW, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardLocateCardsByATRA*(hContext: SCARDCONTEXT, rgAtrMasks: LPSCARD_ATRMASK, cAtrs: DWORD, rgReaderStates: LPSCARD_READERSTATEA, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardLocateCardsByATRW*(hContext: SCARDCONTEXT, rgAtrMasks: LPSCARD_ATRMASK, cAtrs: DWORD, rgReaderStates: LPSCARD_READERSTATEW, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardGetStatusChangeA*(hContext: SCARDCONTEXT, dwTimeout: DWORD, rgReaderStates: LPSCARD_READERSTATEA, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardGetStatusChangeW*(hContext: SCARDCONTEXT, dwTimeout: DWORD, rgReaderStates: LPSCARD_READERSTATEW, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardCancel*(hContext: SCARDCONTEXT): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardConnectA*(hContext: SCARDCONTEXT, szReader: LPCSTR, dwShareMode: DWORD, dwPreferredProtocols: DWORD, phCard: LPSCARDHANDLE, pdwActiveProtocol: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardConnectW*(hContext: SCARDCONTEXT, szReader: LPCWSTR, dwShareMode: DWORD, dwPreferredProtocols: DWORD, phCard: LPSCARDHANDLE, pdwActiveProtocol: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardReconnect*(hCard: SCARDHANDLE, dwShareMode: DWORD, dwPreferredProtocols: DWORD, dwInitialization: DWORD, pdwActiveProtocol: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardDisconnect*(hCard: SCARDHANDLE, dwDisposition: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardBeginTransaction*(hCard: SCARDHANDLE): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardEndTransaction*(hCard: SCARDHANDLE, dwDisposition: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardState*(hCard: SCARDHANDLE, pdwState: LPDWORD, pdwProtocol: LPDWORD, pbAtr: LPBYTE, pcbAtrLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardStatusA*(hCard: SCARDHANDLE, szReaderName: LPSTR, pcchReaderLen: LPDWORD, pdwState: LPDWORD, pdwProtocol: LPDWORD, pbAtr: LPBYTE, pcbAtrLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardStatusW*(hCard: SCARDHANDLE, szReaderName: LPWSTR, pcchReaderLen: LPDWORD, pdwState: LPDWORD, pdwProtocol: LPDWORD, pbAtr: LPBYTE, pcbAtrLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardTransmit*(hCard: SCARDHANDLE, pioSendPci: LPCSCARD_IO_REQUEST, pbSendBuffer: LPCBYTE, cbSendLength: DWORD, pioRecvPci: LPSCARD_IO_REQUEST, pbRecvBuffer: LPBYTE, pcbRecvLength: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardControl*(hCard: SCARDHANDLE, dwControlCode: DWORD, lpInBuffer: LPCVOID, nInBufferSize: DWORD, lpOutBuffer: LPVOID, nOutBufferSize: DWORD, lpBytesReturned: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardGetAttrib*(hCard: SCARDHANDLE, dwAttrId: DWORD, pbAttr: LPBYTE, pcbAttrLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardGetReaderCapabilities*(hCard: SCARDHANDLE, dwAttrId: DWORD, pbAttr: LPBYTE, pcbAttrLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardGetAttrib".}
proc SCardSetAttrib*(hCard: SCARDHANDLE, dwAttrId: DWORD, pbAttr: LPCBYTE, cbAttrLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardSetReaderCapabilities*(hCard: SCARDHANDLE, dwAttrId: DWORD, pbAttr: LPCBYTE, cbAttrLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardSetAttrib".}
proc SCardUIDlgSelectCardA*(P1: LPOPENCARDNAMEA_EX): LONG {.winapi, stdcall, dynlib: "scarddlg", importc.}
proc SCardUIDlgSelectCardW*(P1: LPOPENCARDNAMEW_EX): LONG {.winapi, stdcall, dynlib: "scarddlg", importc.}
proc GetOpenCardNameA*(P1: LPOPENCARDNAMEA): LONG {.winapi, stdcall, dynlib: "scarddlg", importc.}
proc GetOpenCardNameW*(P1: LPOPENCARDNAMEW): LONG {.winapi, stdcall, dynlib: "scarddlg", importc.}
proc SCardDlgExtendedError*(): LONG {.winapi, stdcall, dynlib: "scarddlg", importc.}
proc SCardGetTransmitCount*(hCard: SCARDHANDLE, pcTransmitCount: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardReadCacheA*(hContext: SCARDCONTEXT, CardIdentifier: ptr UUID, FreshnessCounter: DWORD, LookupName: LPSTR, Data: PBYTE, DataLen: ptr DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardReadCacheW*(hContext: SCARDCONTEXT, CardIdentifier: ptr UUID, FreshnessCounter: DWORD, LookupName: LPWSTR, Data: PBYTE, DataLen: ptr DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardWriteCacheA*(hContext: SCARDCONTEXT, CardIdentifier: ptr UUID, FreshnessCounter: DWORD, LookupName: LPSTR, Data: PBYTE, DataLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc SCardWriteCacheW*(hContext: SCARDCONTEXT, CardIdentifier: ptr UUID, FreshnessCounter: DWORD, LookupName: LPWSTR, Data: PBYTE, DataLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc.}
proc `CmdBytes=`*(self: var SCARD_T0_REQUEST, x: SCARD_T0_COMMAND) {.inline.} = self.union1.CmdBytes = x
proc CmdBytes*(self: SCARD_T0_REQUEST): SCARD_T0_COMMAND {.inline.} = self.union1.CmdBytes
proc CmdBytes*(self: var SCARD_T0_REQUEST): var SCARD_T0_COMMAND {.inline.} = self.union1.CmdBytes
proc `rgbHeader=`*(self: var SCARD_T0_REQUEST, x: array[5, BYTE]) {.inline.} = self.union1.rgbHeader = x
proc rgbHeader*(self: SCARD_T0_REQUEST): array[5, BYTE] {.inline.} = self.union1.rgbHeader
proc rgbHeader*(self: var SCARD_T0_REQUEST): var array[5, BYTE] {.inline.} = self.union1.rgbHeader
when winimUnicode:
  type
    SCARD_READERSTATE* = SCARD_READERSTATEW
    PSCARD_READERSTATE* = PSCARD_READERSTATEW
    LPSCARD_READERSTATE* = LPSCARD_READERSTATEW
    LPOCNCONNPROC* = LPOCNCONNPROCW
    OPENCARD_SEARCH_CRITERIA* = OPENCARD_SEARCH_CRITERIAW
    POPENCARD_SEARCH_CRITERIA* = POPENCARD_SEARCH_CRITERIAW
    LPOPENCARD_SEARCH_CRITERIA* = LPOPENCARD_SEARCH_CRITERIAW
    OPENCARDNAME_EX* = OPENCARDNAME_EXW
    POPENCARDNAME_EX* = POPENCARDNAME_EXW
    LPOPENCARDNAME_EX* = LPOPENCARDNAME_EXW
    OPENCARDNAME* = OPENCARDNAMEW
    POPENCARDNAME* = POPENCARDNAMEW
    LPOPENCARDNAME* = LPOPENCARDNAMEW
  const
    SCARD_ATTR_DEVICE_FRIENDLY_NAME* = SCARD_ATTR_DEVICE_FRIENDLY_NAME_W
    SCARD_ATTR_DEVICE_SYSTEM_NAME* = SCARD_ATTR_DEVICE_SYSTEM_NAME_W
  proc SCardListReaderGroups*(hContext: SCARDCONTEXT, mszGroups: LPWSTR, pcchGroups: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListReaderGroupsW".}
  proc SCardListReaders*(hContext: SCARDCONTEXT, mszGroups: LPCWSTR, mszReaders: LPWSTR, pcchReaders: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListReadersW".}
  proc SCardListCards*(hContext: SCARDCONTEXT, pbAtr: LPCBYTE, rgquidInterfaces: LPCGUID, cguidInterfaceCount: DWORD, mszCards: LPWSTR, pcchCards: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListCardsW".}
  proc SCardListInterfaces*(hContext: SCARDCONTEXT, szCard: LPCWSTR, pguidInterfaces: LPGUID, pcguidInterfaces: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListInterfacesW".}
  proc SCardGetProviderId*(hContext: SCARDCONTEXT, szCard: LPCWSTR, pguidProviderId: LPGUID): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardGetProviderIdW".}
  proc SCardGetCardTypeProviderName*(hContext: SCARDCONTEXT, szCardName: LPCWSTR, dwProviderId: DWORD, szProvider: LPWSTR, pcchProvider: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardGetCardTypeProviderNameW".}
  proc SCardIntroduceReaderGroup*(hContext: SCARDCONTEXT, szGroupName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardIntroduceReaderGroupW".}
  proc SCardForgetReaderGroup*(hContext: SCARDCONTEXT, szGroupName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardForgetReaderGroupW".}
  proc SCardIntroduceReader*(hContext: SCARDCONTEXT, szReaderName: LPCWSTR, szDeviceName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardIntroduceReaderW".}
  proc SCardForgetReader*(hContext: SCARDCONTEXT, szReaderName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardForgetReaderW".}
  proc SCardAddReaderToGroup*(hContext: SCARDCONTEXT, szReaderName: LPCWSTR, szGroupName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardAddReaderToGroupW".}
  proc SCardRemoveReaderFromGroup*(hContext: SCARDCONTEXT, szReaderName: LPCWSTR, szGroupName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardRemoveReaderFromGroupW".}
  proc SCardIntroduceCardType*(hContext: SCARDCONTEXT, szCardName: LPCWSTR, pguidPrimaryProvider: LPCGUID, rgguidInterfaces: LPCGUID, dwInterfaceCount: DWORD, pbAtr: LPCBYTE, pbAtrMask: LPCBYTE, cbAtrLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardIntroduceCardTypeW".}
  proc SCardSetCardTypeProviderName*(hContext: SCARDCONTEXT, szCardName: LPCWSTR, dwProviderId: DWORD, szProvider: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardSetCardTypeProviderNameW".}
  proc SCardForgetCardType*(hContext: SCARDCONTEXT, szCardName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardForgetCardTypeW".}
  proc SCardListCardTypes*(hContext: SCARDCONTEXT, pbAtr: LPCBYTE, rgquidInterfaces: LPCGUID, cguidInterfaceCount: DWORD, mszCards: LPWSTR, pcchCards: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListCardsW".}
  proc SCardLocateCards*(hContext: SCARDCONTEXT, mszCards: LPCWSTR, rgReaderStates: LPSCARD_READERSTATEW, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardLocateCardsW".}
  proc SCardLocateCardsByATR*(hContext: SCARDCONTEXT, rgAtrMasks: LPSCARD_ATRMASK, cAtrs: DWORD, rgReaderStates: LPSCARD_READERSTATEW, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardLocateCardsByATRW".}
  proc SCardGetStatusChange*(hContext: SCARDCONTEXT, dwTimeout: DWORD, rgReaderStates: LPSCARD_READERSTATEW, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardGetStatusChangeW".}
  proc SCardConnect*(hContext: SCARDCONTEXT, szReader: LPCWSTR, dwShareMode: DWORD, dwPreferredProtocols: DWORD, phCard: LPSCARDHANDLE, pdwActiveProtocol: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardConnectW".}
  proc SCardStatus*(hCard: SCARDHANDLE, szReaderName: LPWSTR, pcchReaderLen: LPDWORD, pdwState: LPDWORD, pdwProtocol: LPDWORD, pbAtr: LPBYTE, pcbAtrLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardStatusW".}
  proc SCardUIDlgSelectCard*(P1: LPOPENCARDNAMEW_EX): LONG {.winapi, stdcall, dynlib: "scarddlg", importc: "SCardUIDlgSelectCardW".}
  proc GetOpenCardName*(P1: LPOPENCARDNAMEW): LONG {.winapi, stdcall, dynlib: "scarddlg", importc: "GetOpenCardNameW".}
  proc SCardReadCache*(hContext: SCARDCONTEXT, CardIdentifier: ptr UUID, FreshnessCounter: DWORD, LookupName: LPWSTR, Data: PBYTE, DataLen: ptr DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardReadCacheW".}
  proc SCardWriteCache*(hContext: SCARDCONTEXT, CardIdentifier: ptr UUID, FreshnessCounter: DWORD, LookupName: LPWSTR, Data: PBYTE, DataLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardWriteCacheW".}
when winimAnsi:
  type
    SCARD_READERSTATE* = SCARD_READERSTATEA
    PSCARD_READERSTATE* = PSCARD_READERSTATEA
    LPSCARD_READERSTATE* = LPSCARD_READERSTATEA
    LPOCNCONNPROC* = LPOCNCONNPROCA
    OPENCARD_SEARCH_CRITERIA* = OPENCARD_SEARCH_CRITERIAA
    POPENCARD_SEARCH_CRITERIA* = POPENCARD_SEARCH_CRITERIAA
    LPOPENCARD_SEARCH_CRITERIA* = LPOPENCARD_SEARCH_CRITERIAA
    OPENCARDNAME_EX* = OPENCARDNAME_EXA
    POPENCARDNAME_EX* = POPENCARDNAME_EXA
    LPOPENCARDNAME_EX* = LPOPENCARDNAME_EXA
    OPENCARDNAME* = OPENCARDNAMEA
    POPENCARDNAME* = POPENCARDNAMEA
    LPOPENCARDNAME* = LPOPENCARDNAMEA
  const
    SCARD_ATTR_DEVICE_FRIENDLY_NAME* = SCARD_ATTR_DEVICE_FRIENDLY_NAME_A
    SCARD_ATTR_DEVICE_SYSTEM_NAME* = SCARD_ATTR_DEVICE_SYSTEM_NAME_A
  proc SCardListReaderGroups*(hContext: SCARDCONTEXT, mszGroups: LPSTR, pcchGroups: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListReaderGroupsA".}
  proc SCardListReaders*(hContext: SCARDCONTEXT, mszGroups: LPCSTR, mszReaders: LPSTR, pcchReaders: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListReadersA".}
  proc SCardListCards*(hContext: SCARDCONTEXT, pbAtr: LPCBYTE, rgquidInterfaces: LPCGUID, cguidInterfaceCount: DWORD, mszCards: LPSTR, pcchCards: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListCardsA".}
  proc SCardListInterfaces*(hContext: SCARDCONTEXT, szCard: LPCSTR, pguidInterfaces: LPGUID, pcguidInterfaces: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListInterfacesA".}
  proc SCardGetProviderId*(hContext: SCARDCONTEXT, szCard: LPCSTR, pguidProviderId: LPGUID): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardGetProviderIdA".}
  proc SCardGetCardTypeProviderName*(hContext: SCARDCONTEXT, szCardName: LPCSTR, dwProviderId: DWORD, szProvider: LPSTR, pcchProvider: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardGetCardTypeProviderNameA".}
  proc SCardIntroduceReaderGroup*(hContext: SCARDCONTEXT, szGroupName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardIntroduceReaderGroupA".}
  proc SCardForgetReaderGroup*(hContext: SCARDCONTEXT, szGroupName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardForgetReaderGroupA".}
  proc SCardIntroduceReader*(hContext: SCARDCONTEXT, szReaderName: LPCSTR, szDeviceName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardIntroduceReaderA".}
  proc SCardForgetReader*(hContext: SCARDCONTEXT, szReaderName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardForgetReaderA".}
  proc SCardAddReaderToGroup*(hContext: SCARDCONTEXT, szReaderName: LPCSTR, szGroupName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardAddReaderToGroupA".}
  proc SCardRemoveReaderFromGroup*(hContext: SCARDCONTEXT, szReaderName: LPCSTR, szGroupName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardRemoveReaderFromGroupA".}
  proc SCardIntroduceCardType*(hContext: SCARDCONTEXT, szCardName: LPCSTR, pguidPrimaryProvider: LPCGUID, rgguidInterfaces: LPCGUID, dwInterfaceCount: DWORD, pbAtr: LPCBYTE, pbAtrMask: LPCBYTE, cbAtrLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardIntroduceCardTypeA".}
  proc SCardSetCardTypeProviderName*(hContext: SCARDCONTEXT, szCardName: LPCSTR, dwProviderId: DWORD, szProvider: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardSetCardTypeProviderNameA".}
  proc SCardForgetCardType*(hContext: SCARDCONTEXT, szCardName: LPCSTR): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardForgetCardTypeA".}
  proc SCardListCardTypes*(hContext: SCARDCONTEXT, pbAtr: LPCBYTE, rgquidInterfaces: LPCGUID, cguidInterfaceCount: DWORD, mszCards: LPSTR, pcchCards: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardListCardsA".}
  proc SCardLocateCards*(hContext: SCARDCONTEXT, mszCards: LPCSTR, rgReaderStates: LPSCARD_READERSTATEA, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardLocateCardsA".}
  proc SCardLocateCardsByATR*(hContext: SCARDCONTEXT, rgAtrMasks: LPSCARD_ATRMASK, cAtrs: DWORD, rgReaderStates: LPSCARD_READERSTATEA, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardLocateCardsByATRA".}
  proc SCardGetStatusChange*(hContext: SCARDCONTEXT, dwTimeout: DWORD, rgReaderStates: LPSCARD_READERSTATEA, cReaders: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardGetStatusChangeA".}
  proc SCardConnect*(hContext: SCARDCONTEXT, szReader: LPCSTR, dwShareMode: DWORD, dwPreferredProtocols: DWORD, phCard: LPSCARDHANDLE, pdwActiveProtocol: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardConnectA".}
  proc SCardStatus*(hCard: SCARDHANDLE, szReaderName: LPSTR, pcchReaderLen: LPDWORD, pdwState: LPDWORD, pdwProtocol: LPDWORD, pbAtr: LPBYTE, pcbAtrLen: LPDWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardStatusA".}
  proc SCardUIDlgSelectCard*(P1: LPOPENCARDNAMEA_EX): LONG {.winapi, stdcall, dynlib: "scarddlg", importc: "SCardUIDlgSelectCardA".}
  proc GetOpenCardName*(P1: LPOPENCARDNAMEA): LONG {.winapi, stdcall, dynlib: "scarddlg", importc: "GetOpenCardNameA".}
  proc SCardReadCache*(hContext: SCARDCONTEXT, CardIdentifier: ptr UUID, FreshnessCounter: DWORD, LookupName: LPSTR, Data: PBYTE, DataLen: ptr DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardReadCacheA".}
  proc SCardWriteCache*(hContext: SCARDCONTEXT, CardIdentifier: ptr UUID, FreshnessCounter: DWORD, LookupName: LPSTR, Data: PBYTE, DataLen: DWORD): LONG {.winapi, stdcall, dynlib: "winscard", importc: "SCardWriteCacheA".}
