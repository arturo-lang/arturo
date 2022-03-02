#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winsock
import wincrypt
import lm
#include <ras.h>
#include <naptypes.h>
#include <rasdlg.h>
#include <raseapif.h>
#include <raserror.h>
#include <rassapi.h>
#include <rasshost.h>
#include <mprapi.h>
type
  IsolationState* = int32
  ExtendedIsolationState* = int32
  NapTracingLevel* = int32
  FailureCategory* = int32
  FixupState* = int32
  NapNotifyType* = int32
  RemoteConfigurationType* = int32
  RASCONNSTATE* = int32
  RASPROJECTION* = int32
  RASAPIVERSION* = int32
  RAS_AUTH_ATTRIBUTE_TYPE* = int32
  PPP_EAP_ACTION* = int32
  ROUTER_INTERFACE_TYPE* = int32
  ROUTER_CONNECTION_STATE* = int32
  RAS_PORT_CONDITION* = int32
  RAS_HARDWARE_CONDITION* = int32
  RAS_QUARANTINE_STATE* = int32
  MPRAPI_OBJECT_TYPE* = int32
  RAS_PARAMS_FORMAT* = int32
  HRASCONN* = HANDLE
  RAS_SERVER_HANDLE* = HANDLE
  MPR_SERVER_HANDLE* = HANDLE
  MIB_SERVER_HANDLE* = HANDLE
  HPORT* = HANDLE
  ProbationTime* = FILETIME
  MessageId* = UINT32
  NapComponentId* = UINT32
  SystemHealthEntityId* = NapComponentId
  EnforcementEntityId* = NapComponentId
  CountedString* {.pure.} = object
    length*: UINT16
    string*: ptr WCHAR
  StringCorrelationId* = CountedString
  SystemHealthEntityCount* = UINT16
  EnforcementEntityCount* = UINT16
  Percentage* = UINT8
  SoHAttribute* {.pure.} = object
    `type`*: UINT16
    size*: UINT16
    value*: ptr BYTE
  SoH* {.pure.} = object
    count*: UINT16
    attributes*: ptr SoHAttribute
  SoHRequest* = SoH
  SoHResponse* = SoH
  NetworkSoH* {.pure.} = object
    size*: UINT16
    data*: ptr BYTE
  NetworkSoHRequest* = NetworkSoH
  NetworkSoHResponse* = NetworkSoH
  LPHRASCONN* = ptr HRASCONN
const
  RAS_MaxEntryName* = 256
  RAS_MaxDeviceType* = 16
  RAS_MaxDeviceName* = 128
type
  RASCONNW* {.pure, packed.} = object
    dwSize*: DWORD
    hrasconn*: HRASCONN
    szEntryName*: array[RAS_MaxEntryName + 1 , WCHAR]
    szDeviceType*: array[RAS_MaxDeviceType + 1 , WCHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , WCHAR]
    szPhonebook*: array[MAX_PATH , WCHAR]
    padding*: array[2, byte]
    dwSubEntry*: DWORD
    guidEntry*: GUID
    dwFlags*: DWORD
    luid*: LUID
  LPRASCONNW* = ptr RASCONNW
  RASCONNA* {.pure, packed.} = object
    dwSize*: DWORD
    hrasconn*: HRASCONN
    szEntryName*: array[RAS_MaxEntryName + 1 , CHAR]
    szDeviceType*: array[RAS_MaxDeviceType + 1 , CHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , CHAR]
    szPhonebook*: array[MAX_PATH , CHAR]
    padding*: array[1, byte]
    dwSubEntry*: DWORD
    guidEntry*: GUID
    dwFlags*: DWORD
    luid*: LUID
  LPRASCONNA* = ptr RASCONNA
when winimUnicode:
  type
    RASCONN* = RASCONNW
when winimAnsi:
  type
    RASCONN* = RASCONNA
type
  LPRASCONN* = ptr RASCONN
  LPRASCONNSTATE* = ptr RASCONNSTATE
const
  RAS_MaxPhoneNumber* = 128
type
  RASCONNSTATUSW* {.pure.} = object
    dwSize*: DWORD
    rasconnstate*: RASCONNSTATE
    dwError*: DWORD
    szDeviceType*: array[RAS_MaxDeviceType + 1 , WCHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , WCHAR]
    szPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , WCHAR]
  LPRASCONNSTATUSW* = ptr RASCONNSTATUSW
  RASCONNSTATUSA* {.pure.} = object
    dwSize*: DWORD
    rasconnstate*: RASCONNSTATE
    dwError*: DWORD
    szDeviceType*: array[RAS_MaxDeviceType + 1 , CHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , CHAR]
    szPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , CHAR]
  LPRASCONNSTATUSA* = ptr RASCONNSTATUSA
when winimUnicode:
  type
    RASCONNSTATUS* = RASCONNSTATUSW
when winimAnsi:
  type
    RASCONNSTATUS* = RASCONNSTATUSA
type
  LPRASCONNSTATUS* = ptr RASCONNSTATUS
const
  RAS_MaxCallbackNumber* = RAS_MaxPhoneNumber
type
  RASDIALPARAMSW* {.pure, packed.} = object
    dwSize*: DWORD
    szEntryName*: array[RAS_MaxEntryName + 1 , WCHAR]
    szPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , WCHAR]
    szCallbackNumber*: array[RAS_MaxCallbackNumber + 1 , WCHAR]
    szUserName*: array[UNLEN + 1 , WCHAR]
    szPassword*: array[PWLEN + 1 , WCHAR]
    szDomain*: array[DNLEN + 1 , WCHAR]
    padding*: array[2, byte]
    dwSubEntry*: DWORD
    dwCallbackId*: ULONG_PTR
    dwIfIndex*: DWORD
  LPRASDIALPARAMSW* = ptr RASDIALPARAMSW
  RASDIALPARAMSA* {.pure, packed.} = object
    dwSize*: DWORD
    szEntryName*: array[RAS_MaxEntryName + 1 , CHAR]
    szPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , CHAR]
    szCallbackNumber*: array[RAS_MaxCallbackNumber + 1 , CHAR]
    szUserName*: array[UNLEN + 1 , CHAR]
    szPassword*: array[PWLEN + 1 , CHAR]
    szDomain*: array[DNLEN + 1 , CHAR]
    padding*: array[3, byte]
    dwSubEntry*: DWORD
    dwCallbackId*: ULONG_PTR
    dwIfIndex*: DWORD
  LPRASDIALPARAMSA* = ptr RASDIALPARAMSA
when winimUnicode:
  type
    RASDIALPARAMS* = RASDIALPARAMSW
when winimAnsi:
  type
    RASDIALPARAMS* = RASDIALPARAMSA
type
  LPRASDIALPARAMS* = ptr RASDIALPARAMS
  RASEAPINFO* {.pure, packed.} = object
    dwSizeofEapInfo*: DWORD
    pbEapInfo*: ptr BYTE
  RASDIALEXTENSIONS* {.pure, packed.} = object
    dwSize*: DWORD
    dwfOptions*: DWORD
    hwndParent*: HWND
    reserved*: ULONG_PTR
    reserved1*: ULONG_PTR
    RasEapInfo*: RASEAPINFO
  LPRASDIALEXTENSIONS* = ptr RASDIALEXTENSIONS
  RASENTRYNAMEW* {.pure.} = object
    dwSize*: DWORD
    szEntryName*: array[RAS_MaxEntryName + 1 , WCHAR]
    dwFlags*: DWORD
    szPhonebookPath*: array[MAX_PATH + 1, WCHAR]
  LPRASENTRYNAMEW* = ptr RASENTRYNAMEW
  RASENTRYNAMEA* {.pure.} = object
    dwSize*: DWORD
    szEntryName*: array[RAS_MaxEntryName + 1 , CHAR]
    dwFlags*: DWORD
    szPhonebookPath*: array[MAX_PATH + 1, CHAR]
  LPRASENTRYNAMEA* = ptr RASENTRYNAMEA
when winimUnicode:
  type
    RASENTRYNAME* = RASENTRYNAMEW
when winimAnsi:
  type
    RASENTRYNAME* = RASENTRYNAMEA
type
  LPRASENTRYNAME* = ptr RASENTRYNAME
  LPRASPROJECTION* = ptr RASPROJECTION
  RASAMBW* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    szNetBiosError*: array[NETBIOS_NAME_LEN + 1 , WCHAR]
    bLana*: BYTE
  LPRASAMBW* = ptr RASAMBW
  RASAMBA* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    szNetBiosError*: array[NETBIOS_NAME_LEN + 1 , CHAR]
    bLana*: BYTE
  LPRASAMBA* = ptr RASAMBA
when winimUnicode:
  type
    RASAMB* = RASAMBW
when winimAnsi:
  type
    RASAMB* = RASAMBA
type
  LPRASAMB* = ptr RASAMB
  RASPPPNBFW* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    dwNetBiosError*: DWORD
    szNetBiosError*: array[NETBIOS_NAME_LEN + 1 , WCHAR]
    szWorkstationName*: array[NETBIOS_NAME_LEN + 1 , WCHAR]
    bLana*: BYTE
  LPRASPPPNBFW* = ptr RASPPPNBFW
  RASPPPNBFA* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    dwNetBiosError*: DWORD
    szNetBiosError*: array[NETBIOS_NAME_LEN + 1 , CHAR]
    szWorkstationName*: array[NETBIOS_NAME_LEN + 1 , CHAR]
    bLana*: BYTE
  LPRASPPPNBFA* = ptr RASPPPNBFA
when winimUnicode:
  type
    RASPPPNBF* = RASPPPNBFW
when winimAnsi:
  type
    RASPPPNBF* = RASPPPNBFA
type
  LPRASPPPNBF* = ptr RASPPPNBF
const
  RAS_MaxIpxAddress* = 21
type
  RASPPPIPXW* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    szIpxAddress*: array[RAS_MaxIpxAddress + 1 , WCHAR]
  LPRASPPPIPXW* = ptr RASPPPIPXW
  RASPPPIPXA* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    szIpxAddress*: array[RAS_MaxIpxAddress + 1 , CHAR]
  LPRASPPPIPXA* = ptr RASPPPIPXA
when winimUnicode:
  type
    RASPPPIPX* = RASPPPIPXW
when winimAnsi:
  type
    RASPPPIPX* = RASPPPIPXA
type
  LPRASPPPIPX* = ptr RASPPPIPX
const
  RAS_MaxIpAddress* = 15
type
  RASPPPIPW* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    szIpAddress*: array[RAS_MaxIpAddress + 1 , WCHAR]
    szServerIpAddress*: array[RAS_MaxIpAddress + 1 , WCHAR]
    dwOptions*: DWORD
    dwServerOptions*: DWORD
  LPRASPPPIPW* = ptr RASPPPIPW
  RASPPPIPA* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    szIpAddress*: array[RAS_MaxIpAddress + 1 , CHAR]
    szServerIpAddress*: array[RAS_MaxIpAddress + 1 , CHAR]
    dwOptions*: DWORD
    dwServerOptions*: DWORD
  LPRASPPPIPA* = ptr RASPPPIPA
when winimUnicode:
  type
    RASPPPIP* = RASPPPIPW
when winimAnsi:
  type
    RASPPPIP* = RASPPPIPA
type
  LPRASPPPIP* = ptr RASPPPIP
const
  RAS_MaxReplyMessage* = 1024
type
  RASPPPLCPW* {.pure.} = object
    dwSize*: DWORD
    fBundled*: WINBOOL
    dwError*: DWORD
    dwAuthenticationProtocol*: DWORD
    dwAuthenticationData*: DWORD
    dwEapTypeId*: DWORD
    dwServerAuthenticationProtocol*: DWORD
    dwServerAuthenticationData*: DWORD
    dwServerEapTypeId*: DWORD
    fMultilink*: WINBOOL
    dwTerminateReason*: DWORD
    dwServerTerminateReason*: DWORD
    szReplyMessage*: array[RAS_MaxReplyMessage, WCHAR]
    dwOptions*: DWORD
    dwServerOptions*: DWORD
  LPRASPPPLCPW* = ptr RASPPPLCPW
  RASPPPLCPA* {.pure.} = object
    dwSize*: DWORD
    fBundled*: WINBOOL
    dwError*: DWORD
    dwAuthenticationProtocol*: DWORD
    dwAuthenticationData*: DWORD
    dwEapTypeId*: DWORD
    dwServerAuthenticationProtocol*: DWORD
    dwServerAuthenticationData*: DWORD
    dwServerEapTypeId*: DWORD
    fMultilink*: WINBOOL
    dwTerminateReason*: DWORD
    dwServerTerminateReason*: DWORD
    szReplyMessage*: array[RAS_MaxReplyMessage, CHAR]
    dwOptions*: DWORD
    dwServerOptions*: DWORD
  LPRASPPPLCPA* = ptr RASPPPLCPA
when winimUnicode:
  type
    RASPPPLCP* = RASPPPLCPW
when winimAnsi:
  type
    RASPPPLCP* = RASPPPLCPA
type
  LPRASPPPLCP* = ptr RASPPPLCP
  RASSLIPW* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    szIpAddress*: array[RAS_MaxIpAddress + 1 , WCHAR]
  LPRASSLIPW* = ptr RASSLIPW
  RASSLIPA* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    szIpAddress*: array[RAS_MaxIpAddress + 1 , CHAR]
  LPRASSLIPA* = ptr RASSLIPA
when winimUnicode:
  type
    RASSLIP* = RASSLIPW
when winimAnsi:
  type
    RASSLIP* = RASSLIPA
type
  LPRASSLIP* = ptr RASSLIP
  RASPPPCCP* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    dwCompressionAlgorithm*: DWORD
    dwOptions*: DWORD
    dwServerCompressionAlgorithm*: DWORD
    dwServerOptions*: DWORD
  LPRASPPPCCP* = ptr RASPPPCCP
  RASDEVINFOW* {.pure.} = object
    dwSize*: DWORD
    szDeviceType*: array[RAS_MaxDeviceType + 1 , WCHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , WCHAR]
  LPRASDEVINFOW* = ptr RASDEVINFOW
  RASDEVINFOA* {.pure.} = object
    dwSize*: DWORD
    szDeviceType*: array[RAS_MaxDeviceType + 1 , CHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , CHAR]
  LPRASDEVINFOA* = ptr RASDEVINFOA
when winimUnicode:
  type
    RASDEVINFO* = RASDEVINFOW
when winimAnsi:
  type
    RASDEVINFO* = RASDEVINFOA
type
  LPRASDEVINFO* = ptr RASDEVINFO
  RASCTRYINFO* {.pure.} = object
    dwSize*: DWORD
    dwCountryID*: DWORD
    dwNextCountryID*: DWORD
    dwCountryCode*: DWORD
    dwCountryNameOffset*: DWORD
  RASCTRYINFOW* = RASCTRYINFO
  RASCTRYINFOA* = RASCTRYINFO
  LPRASCTRYINFOW* = ptr RASCTRYINFOW
  LPRASCTRYINFOA* = ptr RASCTRYINFOW
  LPRASCTRYINFO* = ptr RASCTRYINFO
const
  RAS_MaxAreaCode* = 10
type
  RASIPADDR* {.pure.} = object
    a*: BYTE
    b*: BYTE
    c*: BYTE
    d*: BYTE
const
  RAS_MaxPadType* = 32
  RAS_MaxX25Address* = 200
  RAS_MaxFacilities* = 200
  RAS_MaxUserData* = 200
  RAS_MaxDnsSuffix* = 256
type
  RASENTRYW* {.pure.} = object
    dwSize*: DWORD
    dwfOptions*: DWORD
    dwCountryID*: DWORD
    dwCountryCode*: DWORD
    szAreaCode*: array[RAS_MaxAreaCode + 1 , WCHAR]
    szLocalPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , WCHAR]
    dwAlternateOffset*: DWORD
    ipaddr*: RASIPADDR
    ipaddrDns*: RASIPADDR
    ipaddrDnsAlt*: RASIPADDR
    ipaddrWins*: RASIPADDR
    ipaddrWinsAlt*: RASIPADDR
    dwFrameSize*: DWORD
    dwfNetProtocols*: DWORD
    dwFramingProtocol*: DWORD
    szScript*: array[MAX_PATH , WCHAR]
    szAutodialDll*: array[MAX_PATH , WCHAR]
    szAutodialFunc*: array[MAX_PATH , WCHAR]
    szDeviceType*: array[RAS_MaxDeviceType + 1 , WCHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , WCHAR]
    szX25PadType*: array[RAS_MaxPadType + 1 , WCHAR]
    szX25Address*: array[RAS_MaxX25Address + 1 , WCHAR]
    szX25Facilities*: array[RAS_MaxFacilities + 1 , WCHAR]
    szX25UserData*: array[RAS_MaxUserData + 1 , WCHAR]
    dwChannels*: DWORD
    dwReserved1*: DWORD
    dwReserved2*: DWORD
    dwSubEntries*: DWORD
    dwDialMode*: DWORD
    dwDialExtraPercent*: DWORD
    dwDialExtraSampleSeconds*: DWORD
    dwHangUpExtraPercent*: DWORD
    dwHangUpExtraSampleSeconds*: DWORD
    dwIdleDisconnectSeconds*: DWORD
    dwType*: DWORD
    dwEncryptionType*: DWORD
    dwCustomAuthKey*: DWORD
    guidId*: GUID
    szCustomDialDll*: array[MAX_PATH, WCHAR]
    dwVpnStrategy*: DWORD
    dwfOptions2*: DWORD
    dwfOptions3*: DWORD
    szDnsSuffix*: array[RAS_MaxDnsSuffix, WCHAR]
    dwTcpWindowSize*: DWORD
    szPrerequisitePbk*: array[MAX_PATH, WCHAR]
    szPrerequisiteEntry*: array[RAS_MaxEntryName + 1, WCHAR]
    dwRedialCount*: DWORD
    dwRedialPause*: DWORD
  LPRASENTRYW* = ptr RASENTRYW
  RASENTRYA* {.pure.} = object
    dwSize*: DWORD
    dwfOptions*: DWORD
    dwCountryID*: DWORD
    dwCountryCode*: DWORD
    szAreaCode*: array[RAS_MaxAreaCode + 1 , CHAR]
    szLocalPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , CHAR]
    dwAlternateOffset*: DWORD
    ipaddr*: RASIPADDR
    ipaddrDns*: RASIPADDR
    ipaddrDnsAlt*: RASIPADDR
    ipaddrWins*: RASIPADDR
    ipaddrWinsAlt*: RASIPADDR
    dwFrameSize*: DWORD
    dwfNetProtocols*: DWORD
    dwFramingProtocol*: DWORD
    szScript*: array[MAX_PATH , CHAR]
    szAutodialDll*: array[MAX_PATH , CHAR]
    szAutodialFunc*: array[MAX_PATH , CHAR]
    szDeviceType*: array[RAS_MaxDeviceType + 1 , CHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , CHAR]
    szX25PadType*: array[RAS_MaxPadType + 1 , CHAR]
    szX25Address*: array[RAS_MaxX25Address + 1 , CHAR]
    szX25Facilities*: array[RAS_MaxFacilities + 1 , CHAR]
    szX25UserData*: array[RAS_MaxUserData + 1 , CHAR]
    dwChannels*: DWORD
    dwReserved1*: DWORD
    dwReserved2*: DWORD
    dwSubEntries*: DWORD
    dwDialMode*: DWORD
    dwDialExtraPercent*: DWORD
    dwDialExtraSampleSeconds*: DWORD
    dwHangUpExtraPercent*: DWORD
    dwHangUpExtraSampleSeconds*: DWORD
    dwIdleDisconnectSeconds*: DWORD
    dwType*: DWORD
    dwEncryptionType*: DWORD
    dwCustomAuthKey*: DWORD
    guidId*: GUID
    szCustomDialDll*: array[MAX_PATH, CHAR]
    dwVpnStrategy*: DWORD
    dwfOptions2*: DWORD
    dwfOptions3*: DWORD
    szDnsSuffix*: array[RAS_MaxDnsSuffix, CHAR]
    dwTcpWindowSize*: DWORD
    szPrerequisitePbk*: array[MAX_PATH, CHAR]
    szPrerequisiteEntry*: array[RAS_MaxEntryName + 1, CHAR]
    dwRedialCount*: DWORD
    dwRedialPause*: DWORD
  LPRASENTRYA* = ptr RASENTRYA
when winimUnicode:
  type
    RASENTRY* = RASENTRYW
when winimAnsi:
  type
    RASENTRY* = RASENTRYA
type
  LPRASENTRY* = ptr RASENTRY
  RASADPARAMS* {.pure, packed.} = object
    dwSize*: DWORD
    hwndOwner*: HWND
    dwFlags*: DWORD
    xDlg*: LONG
    yDlg*: LONG
  LPRASADPARAMS* = ptr RASADPARAMS
  RASSUBENTRYW* {.pure.} = object
    dwSize*: DWORD
    dwfFlags*: DWORD
    szDeviceType*: array[RAS_MaxDeviceType + 1 , WCHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , WCHAR]
    szLocalPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , WCHAR]
    dwAlternateOffset*: DWORD
  LPRASSUBENTRYW* = ptr RASSUBENTRYW
  RASSUBENTRYA* {.pure.} = object
    dwSize*: DWORD
    dwfFlags*: DWORD
    szDeviceType*: array[RAS_MaxDeviceType + 1 , CHAR]
    szDeviceName*: array[RAS_MaxDeviceName + 1 , CHAR]
    szLocalPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , CHAR]
    dwAlternateOffset*: DWORD
  LPRASSUBENTRYA* = ptr RASSUBENTRYA
when winimUnicode:
  type
    RASSUBENTRY* = RASSUBENTRYW
when winimAnsi:
  type
    RASSUBENTRY* = RASSUBENTRYA
type
  LPRASSUBENTRY* = ptr RASSUBENTRY
  RASCREDENTIALSW* {.pure.} = object
    dwSize*: DWORD
    dwMask*: DWORD
    szUserName*: array[UNLEN + 1 , WCHAR]
    szPassword*: array[PWLEN + 1 , WCHAR]
    szDomain*: array[DNLEN + 1 , WCHAR]
  LPRASCREDENTIALSW* = ptr RASCREDENTIALSW
  RASCREDENTIALSA* {.pure.} = object
    dwSize*: DWORD
    dwMask*: DWORD
    szUserName*: array[UNLEN + 1 , CHAR]
    szPassword*: array[PWLEN + 1 , CHAR]
    szDomain*: array[DNLEN + 1 , CHAR]
  LPRASCREDENTIALSA* = ptr RASCREDENTIALSA
when winimUnicode:
  type
    RASCREDENTIALS* = RASCREDENTIALSW
when winimAnsi:
  type
    RASCREDENTIALS* = RASCREDENTIALSA
type
  LPRASCREDENTIALS* = ptr RASCREDENTIALS
  RASAUTODIALENTRYW* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    dwDialingLocation*: DWORD
    szEntry*: array[RAS_MaxEntryName + 1, WCHAR]
  LPRASAUTODIALENTRYW* = ptr RASAUTODIALENTRYW
  RASAUTODIALENTRYA* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    dwDialingLocation*: DWORD
    szEntry*: array[RAS_MaxEntryName + 1, CHAR]
  LPRASAUTODIALENTRYA* = ptr RASAUTODIALENTRYA
when winimUnicode:
  type
    RASAUTODIALENTRY* = RASAUTODIALENTRYW
when winimAnsi:
  type
    RASAUTODIALENTRY* = RASAUTODIALENTRYA
type
  LPRASAUTODIALENTRY* = ptr RASAUTODIALENTRY
  RASEAPUSERIDENTITYW* {.pure.} = object
    szUserName*: array[UNLEN + 1 , WCHAR]
    dwSizeofEapInfo*: DWORD
    pbEapInfo*: array[1 , BYTE]
  LPRASEAPUSERIDENTITYW* = ptr RASEAPUSERIDENTITYW
  RASEAPUSERIDENTITYA* {.pure.} = object
    szUserName*: array[UNLEN + 1 , CHAR]
    dwSizeofEapInfo*: DWORD
    pbEapInfo*: array[1 , BYTE]
  LPRASEAPUSERIDENTITYA* = ptr RASEAPUSERIDENTITYA
  RAS_STATS* {.pure.} = object
    dwSize*: DWORD
    dwBytesXmited*: DWORD
    dwBytesRcved*: DWORD
    dwFramesXmited*: DWORD
    dwFramesRcved*: DWORD
    dwCrcErr*: DWORD
    dwTimeoutErr*: DWORD
    dwAlignmentErr*: DWORD
    dwHardwareOverrunErr*: DWORD
    dwFramingErr*: DWORD
    dwBufferOverrunErr*: DWORD
    dwCompressionRatioIn*: DWORD
    dwCompressionRatioOut*: DWORD
    dwBps*: DWORD
    dwConnectDuration*: DWORD
  PRAS_STATS* = ptr RAS_STATS
  RASNAPSTATE* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    isolationState*: IsolationState
    probationTime*: ProbationTime
  LPRASNAPSTATE* = ptr RASNAPSTATE
  RASPPPIPV6* {.pure.} = object
    dwSize*: DWORD
    dwError*: DWORD
    bLocalInterfaceIdentifier*: array[8, BYTE]
    bPeerInterfaceIdentifier*: array[8, BYTE]
    bLocalCompressionProtocol*: array[2, BYTE]
    bPeerCompressionProtocol*: array[2, BYTE]
  LPRASPPPIPV6* = ptr RASPPPIPV6
  RASIPV4ADDR* = IN_ADDR
  RASIPV6ADDR* = IN6_ADDR
  RASTUNNELENDPOINT_UNION1* {.pure, union.} = object
    ipv4*: RASIPV4ADDR
    ipv6*: RASIPV6ADDR
  RASTUNNELENDPOINT* {.pure.} = object
    dwType*: DWORD
    union1*: RASTUNNELENDPOINT_UNION1
  PRASTUNNELENDPOINT* = ptr RASTUNNELENDPOINT
  RASUPDATECONN* {.pure.} = object
    version*: RASAPIVERSION
    dwSize*: DWORD
    dwFlags*: DWORD
    dwIfIndex*: DWORD
    localEndPoint*: RASTUNNELENDPOINT
    remoteEndPoint*: RASTUNNELENDPOINT
  LPRASUPDATECONN* = ptr RASUPDATECONN
  RASNOUSERW* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    dwTimeoutMs*: DWORD
    szUserName*: array[UNLEN + 1, WCHAR]
    szPassword*: array[PWLEN + 1, WCHAR]
    szDomain*: array[DNLEN + 1, WCHAR]
  LPRASNOUSERW* = ptr RASNOUSERW
  RASNOUSERA* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    dwTimeoutMs*: DWORD
    szUserName*: array[UNLEN + 1, CHAR]
    szPassword*: array[PWLEN + 1, CHAR]
    szDomain*: array[DNLEN + 1, CHAR]
  LPRASNOUSERA* = ptr RASNOUSERA
when winimUnicode:
  type
    RASNOUSER* = RASNOUSERW
when winimAnsi:
  type
    RASNOUSER* = RASNOUSERA
type
  LPRASNOUSER* = ptr RASNOUSER
  RASPBDLGFUNCW* = proc (P1: ULONG_PTR, P2: DWORD, P3: LPWSTR, P4: LPVOID): VOID {.stdcall.}
  RASPBDLGW* {.pure, packed.} = object
    dwSize*: DWORD
    hwndOwner*: HWND
    dwFlags*: DWORD
    xDlg*: LONG
    yDlg*: LONG
    dwCallbackId*: ULONG_PTR
    pCallback*: RASPBDLGFUNCW
    dwError*: DWORD
    reserved*: ULONG_PTR
    reserved2*: ULONG_PTR
  LPRASPBDLGW* = ptr RASPBDLGW
  RASPBDLGFUNCA* = proc (P1: ULONG_PTR, P2: DWORD, P3: LPSTR, P4: LPVOID): VOID {.stdcall.}
  RASPBDLGA* {.pure, packed.} = object
    dwSize*: DWORD
    hwndOwner*: HWND
    dwFlags*: DWORD
    xDlg*: LONG
    yDlg*: LONG
    dwCallbackId*: ULONG_PTR
    pCallback*: RASPBDLGFUNCA
    dwError*: DWORD
    reserved*: ULONG_PTR
    reserved2*: ULONG_PTR
  LPRASPBDLGA* = ptr RASPBDLGA
when winimUnicode:
  type
    RASPBDLG* = RASPBDLGW
when winimAnsi:
  type
    RASPBDLG* = RASPBDLGA
type
  LPRASPBDLG* = ptr RASPBDLG
  TRASENTRYDLGW* {.pure, packed.} = object
    dwSize*: DWORD
    hwndOwner*: HWND
    dwFlags*: DWORD
    xDlg*: LONG
    yDlg*: LONG
    szEntry*: array[RAS_MaxEntryName + 1, WCHAR]
    padding*: array[2, byte]
    dwError*: DWORD
    reserved*: ULONG_PTR
    reserved2*: ULONG_PTR
  LPRASENTRYDLGW* = ptr TRASENTRYDLGW
  TRASENTRYDLGA* {.pure, packed.} = object
    dwSize*: DWORD
    hwndOwner*: HWND
    dwFlags*: DWORD
    xDlg*: LONG
    yDlg*: LONG
    szEntry*: array[RAS_MaxEntryName + 1, CHAR]
    padding*: array[3, byte]
    dwError*: DWORD
    reserved*: ULONG_PTR
    reserved2*: ULONG_PTR
  LPRASENTRYDLGA* = ptr TRASENTRYDLGA
when winimUnicode:
  type
    TRASENTRYDLG* = TRASENTRYDLGW
when winimAnsi:
  type
    TRASENTRYDLG* = TRASENTRYDLGA
type
  LPRASENTRYDLG* = ptr TRASENTRYDLG
  TRASDIALDLG* {.pure, packed.} = object
    dwSize*: DWORD
    hwndOwner*: HWND
    dwFlags*: DWORD
    xDlg*: LONG
    yDlg*: LONG
    dwSubEntry*: DWORD
    dwError*: DWORD
    reserved*: ULONG_PTR
    reserved2*: ULONG_PTR
  LPRASDIALDLG* = ptr TRASDIALDLG
  RAS_AUTH_ATTRIBUTE* {.pure.} = object
    raaType*: RAS_AUTH_ATTRIBUTE_TYPE
    dwLength*: DWORD
    Value*: PVOID
  PRAS_AUTH_ATTRIBUTE* = ptr RAS_AUTH_ATTRIBUTE
  PPP_EAP_PACKET* {.pure.} = object
    Code*: BYTE
    Id*: BYTE
    Length*: array[2, BYTE]
    Data*: array[1, BYTE]
  PPPP_EAP_PACKET* = ptr PPP_EAP_PACKET
  PPP_EAP_INPUT* {.pure.} = object
    dwSizeInBytes*: DWORD
    fFlags*: DWORD
    fAuthenticator*: WINBOOL
    pwszIdentity*: ptr WCHAR
    pwszPassword*: ptr WCHAR
    bInitialId*: BYTE
    pUserAttributes*: ptr RAS_AUTH_ATTRIBUTE
    fAuthenticationComplete*: WINBOOL
    dwAuthResultCode*: DWORD
    hTokenImpersonateUser*: HANDLE
    fSuccessPacketReceived*: WINBOOL
    fDataReceivedFromInteractiveUI*: WINBOOL
    pDataFromInteractiveUI*: PBYTE
    dwSizeOfDataFromInteractiveUI*: DWORD
    pConnectionData*: PBYTE
    dwSizeOfConnectionData*: DWORD
    pUserData*: PBYTE
    dwSizeOfUserData*: DWORD
    hReserved*: HANDLE
  PPPP_EAP_INPUT* = ptr PPP_EAP_INPUT
  PPP_EAP_OUTPUT* {.pure.} = object
    dwSizeInBytes*: DWORD
    Action*: PPP_EAP_ACTION
    dwAuthResultCode*: DWORD
    pUserAttributes*: ptr RAS_AUTH_ATTRIBUTE
    fInvokeInteractiveUI*: WINBOOL
    pUIContextData*: PBYTE
    dwSizeOfUIContextData*: DWORD
    fSaveConnectionData*: WINBOOL
    pConnectionData*: PBYTE
    dwSizeOfConnectionData*: DWORD
    fSaveUserData*: WINBOOL
    pUserData*: PBYTE
    dwSizeOfUserData*: DWORD
  PPPP_EAP_OUTPUT* = ptr PPP_EAP_OUTPUT
  PPP_EAP_INFO* {.pure.} = object
    dwSizeInBytes*: DWORD
    dwEapTypeId*: DWORD
    RasEapInitialize*: proc(fInitialize: WINBOOL): DWORD {.stdcall.}
    RasEapBegin*: proc(ppWorkBuffer: ptr pointer, pPppEapInput: ptr PPP_EAP_INPUT): DWORD {.stdcall.}
    RasEapEnd*: proc(pWorkBuffer: pointer): DWORD {.stdcall.}
    RasEapMakeMessage*: proc(pWorkBuf: pointer, pReceivePacket: ptr PPP_EAP_PACKET, pSendPacket: ptr PPP_EAP_PACKET, cbSendPacket: DWORD, pEapOutput: ptr PPP_EAP_OUTPUT, pEapInput: ptr PPP_EAP_INPUT): DWORD {.stdcall.}
  PPPP_EAP_INFO* = ptr PPP_EAP_INFO
const
  MAX_PHONE_NUMBER_LEN* = 128
type
  RAS_USER_0* {.pure.} = object
    bfPrivilege*: BYTE
    wszPhoneNumber*: array[MAX_PHONE_NUMBER_LEN + 1, WCHAR]
  PRAS_USER_0* = ptr RAS_USER_0
const
  MAX_PORT_NAME* = 16
  MAX_MEDIA_NAME* = 16
  MAX_DEVICE_NAME* = 128
  MAX_DEVICETYPE_NAME* = 16
type
  RAS_PORT_0* {.pure.} = object
    hPort*: HANDLE
    hConnection*: HANDLE
    dwPortCondition*: RAS_PORT_CONDITION
    dwTotalNumberOfCalls*: DWORD
    dwConnectDuration*: DWORD
    wszPortName*: array[MAX_PORT_NAME + 1 , WCHAR]
    wszMediaName*: array[MAX_MEDIA_NAME + 1 , WCHAR]
    wszDeviceName*: array[MAX_DEVICE_NAME + 1 , WCHAR]
    wszDeviceType*: array[MAX_DEVICETYPE_NAME + 1 , WCHAR]
  PRAS_PORT_0* = ptr RAS_PORT_0
  RAS_PORT_1* {.pure.} = object
    hPort*: HANDLE
    hConnection*: HANDLE
    dwHardwareCondition*: RAS_HARDWARE_CONDITION
    dwLineSpeed*: DWORD
    dwBytesXmited*: DWORD
    dwBytesRcved*: DWORD
    dwFramesXmited*: DWORD
    dwFramesRcved*: DWORD
    dwCrcErr*: DWORD
    dwTimeoutErr*: DWORD
    dwAlignmentErr*: DWORD
    dwHardwareOverrunErr*: DWORD
    dwFramingErr*: DWORD
    dwBufferOverrunErr*: DWORD
    dwCompressionRatioIn*: DWORD
    dwCompressionRatioOut*: DWORD
  PRAS_PORT_1* = ptr RAS_PORT_1
  RAS_PORT_STATISTICS* {.pure.} = object
    dwBytesXmited*: DWORD
    dwBytesRcved*: DWORD
    dwFramesXmited*: DWORD
    dwFramesRcved*: DWORD
    dwCrcErr*: DWORD
    dwTimeoutErr*: DWORD
    dwAlignmentErr*: DWORD
    dwHardwareOverrunErr*: DWORD
    dwFramingErr*: DWORD
    dwBufferOverrunErr*: DWORD
    dwBytesXmitedUncompressed*: DWORD
    dwBytesRcvedUncompressed*: DWORD
    dwBytesXmitedCompressed*: DWORD
    dwBytesRcvedCompressed*: DWORD
    dwPortBytesXmited*: DWORD
    dwPortBytesRcved*: DWORD
    dwPortFramesXmited*: DWORD
    dwPortFramesRcved*: DWORD
    dwPortCrcErr*: DWORD
    dwPortTimeoutErr*: DWORD
    dwPortAlignmentErr*: DWORD
    dwPortHardwareOverrunErr*: DWORD
    dwPortFramingErr*: DWORD
    dwPortBufferOverrunErr*: DWORD
    dwPortBytesXmitedUncompressed*: DWORD
    dwPortBytesRcvedUncompressed*: DWORD
    dwPortBytesXmitedCompressed*: DWORD
    dwPortBytesRcvedCompressed*: DWORD
  PRAS_PORT_STATISTICS* = ptr RAS_PORT_STATISTICS
  RAS_SERVER_0* {.pure.} = object
    TotalPorts*: WORD
    PortsInUse*: WORD
    RasVersion*: DWORD
  PRAS_SERVER_0* = ptr RAS_SERVER_0
const
  MAX_INTERFACE_NAME_LEN* = 256
type
  MPR_INTERFACE_0* {.pure.} = object
    wszInterfaceName*: array[MAX_INTERFACE_NAME_LEN+1, WCHAR]
    hInterface*: HANDLE
    fEnabled*: WINBOOL
    dwIfType*: ROUTER_INTERFACE_TYPE
    dwConnectionState*: ROUTER_CONNECTION_STATE
    fUnReachabilityReasons*: DWORD
    dwLastError*: DWORD
  PMPR_INTERFACE_0* = ptr MPR_INTERFACE_0
  MPR_IPINIP_INTERFACE_0* {.pure.} = object
    wszFriendlyName*: array[MAX_INTERFACE_NAME_LEN+1, WCHAR]
    Guid*: GUID
  PMPR_IPINIP_INTERFACE_0* = ptr MPR_IPINIP_INTERFACE_0
  MPR_INTERFACE_1* {.pure.} = object
    wszInterfaceName*: array[MAX_INTERFACE_NAME_LEN+1, WCHAR]
    hInterface*: HANDLE
    fEnabled*: WINBOOL
    dwIfType*: ROUTER_INTERFACE_TYPE
    dwConnectionState*: ROUTER_CONNECTION_STATE
    fUnReachabilityReasons*: DWORD
    dwLastError*: DWORD
    lpwsDialoutHoursRestriction*: LPWSTR
  PMPR_INTERFACE_1* = ptr MPR_INTERFACE_1
const
  MPR_MaxDeviceType* = RAS_MaxDeviceType
  MPR_MaxDeviceName* = RAS_MaxDeviceName
  MPR_MaxPadType* = RAS_MaxPadType
  MPR_MaxX25Address* = RAS_MaxX25Address
  MPR_MaxFacilities* = RAS_MaxFacilities
  MPR_MaxUserData* = RAS_MaxUserData
type
  MPR_INTERFACE_2* {.pure.} = object
    wszInterfaceName*: array[MAX_INTERFACE_NAME_LEN+1, WCHAR]
    hInterface*: HANDLE
    fEnabled*: WINBOOL
    dwIfType*: ROUTER_INTERFACE_TYPE
    dwConnectionState*: ROUTER_CONNECTION_STATE
    fUnReachabilityReasons*: DWORD
    dwLastError*: DWORD
    dwfOptions*: DWORD
    szLocalPhoneNumber*: array[RAS_MaxPhoneNumber + 1 , WCHAR]
    szAlternates*: PWCHAR
    ipaddr*: DWORD
    ipaddrDns*: DWORD
    ipaddrDnsAlt*: DWORD
    ipaddrWins*: DWORD
    ipaddrWinsAlt*: DWORD
    dwfNetProtocols*: DWORD
    szDeviceType*: array[MPR_MaxDeviceType + 1 , WCHAR]
    szDeviceName*: array[MPR_MaxDeviceName + 1 , WCHAR]
    szX25PadType*: array[MPR_MaxPadType + 1 , WCHAR]
    szX25Address*: array[MPR_MaxX25Address + 1 , WCHAR]
    szX25Facilities*: array[MPR_MaxFacilities + 1 , WCHAR]
    szX25UserData*: array[MPR_MaxUserData + 1 , WCHAR]
    dwChannels*: DWORD
    dwSubEntries*: DWORD
    dwDialMode*: DWORD
    dwDialExtraPercent*: DWORD
    dwDialExtraSampleSeconds*: DWORD
    dwHangUpExtraPercent*: DWORD
    dwHangUpExtraSampleSeconds*: DWORD
    dwIdleDisconnectSeconds*: DWORD
    dwType*: DWORD
    dwEncryptionType*: DWORD
    dwCustomAuthKey*: DWORD
    dwCustomAuthDataSize*: DWORD
    lpbCustomAuthData*: LPBYTE
    guidId*: GUID
    dwVpnStrategy*: DWORD
  PMPR_INTERFACE_2* = ptr MPR_INTERFACE_2
  MPR_INTERFACE_3* {.pure.} = object
    wszInterfaceName*: array[MAX_INTERFACE_NAME_LEN+1, WCHAR]
    hInterface*: HANDLE
    fEnabled*: WINBOOL
    dwIfType*: ROUTER_INTERFACE_TYPE
    dwConnectionState*: ROUTER_CONNECTION_STATE
    fUnReachabilityReasons*: DWORD
    dwLastError*: DWORD
    dwfOptions*: DWORD
    szLocalPhoneNumber*: array[RAS_MaxPhoneNumber + 1, WCHAR]
    szAlternates*: PWCHAR
    ipaddr*: DWORD
    ipaddrDns*: DWORD
    ipaddrDnsAlt*: DWORD
    ipaddrWins*: DWORD
    ipaddrWinsAlt*: DWORD
    dwfNetProtocols*: DWORD
    szDeviceType*: array[MPR_MaxDeviceType + 1, WCHAR]
    szDeviceName*: array[MPR_MaxDeviceName + 1, WCHAR]
    szX25PadType*: array[MPR_MaxPadType + 1, WCHAR]
    szX25Address*: array[MPR_MaxX25Address + 1, WCHAR]
    szX25Facilities*: array[MPR_MaxFacilities + 1, WCHAR]
    szX25UserData*: array[MPR_MaxUserData + 1, WCHAR]
    dwChannels*: DWORD
    dwSubEntries*: DWORD
    dwDialMode*: DWORD
    dwDialExtraPercent*: DWORD
    dwDialExtraSampleSeconds*: DWORD
    dwHangUpExtraPercent*: DWORD
    dwHangUpExtraSampleSeconds*: DWORD
    dwIdleDisconnectSeconds*: DWORD
    dwType*: DWORD
    dwEncryptionType*: DWORD
    dwCustomAuthKey*: DWORD
    dwCustomAuthDataSize*: DWORD
    lpbCustomAuthData*: LPBYTE
    guidId*: GUID
    dwVpnStrategy*: DWORD
    AddressCount*: ULONG
    ipv6addrDns*: IN6_ADDR
    ipv6addrDnsAlt*: IN6_ADDR
    ipv6addr*: ptr IN6_ADDR
  PMPR_INTERFACE_3* = ptr MPR_INTERFACE_3
  MPR_DEVICE_0* {.pure.} = object
    szDeviceType*: array[MPR_MaxDeviceType + 1 , WCHAR]
    szDeviceName*: array[MPR_MaxDeviceName + 1 , WCHAR]
  PMPR_DEVICE_0* = ptr MPR_DEVICE_0
const
  MPR_MaxPhoneNumber* = RAS_MaxPhoneNumber
type
  MPR_DEVICE_1* {.pure.} = object
    szDeviceType*: array[MPR_MaxDeviceType + 1 , WCHAR]
    szDeviceName*: array[MPR_MaxDeviceName + 1 , WCHAR]
    szLocalPhoneNumber*: array[MPR_MaxPhoneNumber + 1 , WCHAR]
    szAlternates*: PWCHAR
  PMPR_DEVICE_1* = ptr MPR_DEVICE_1
  MPR_CREDENTIALSEX_0* {.pure.} = object
    dwSize*: DWORD
    lpbCredentialsInfo*: LPBYTE
  PMPR_CREDENTIALSEX_0* = ptr MPR_CREDENTIALSEX_0
  MPR_CREDENTIALSEX_1* {.pure.} = object
    dwSize*: DWORD
    lpbCredentialsInfo*: LPBYTE
  PMPR_CREDENTIALSEX_1* = ptr MPR_CREDENTIALSEX_1
const
  MAX_TRANSPORT_NAME_LEN* = 40
type
  MPR_TRANSPORT_0* {.pure.} = object
    dwTransportId*: DWORD
    hTransport*: HANDLE
    wszTransportName*: array[MAX_TRANSPORT_NAME_LEN+1, WCHAR]
  PMPR_TRANSPORT_0* = ptr MPR_TRANSPORT_0
  MPR_IFTRANSPORT_0* {.pure.} = object
    dwTransportId*: DWORD
    hIfTransport*: HANDLE
    wszIfTransportName*: array[MAX_TRANSPORT_NAME_LEN+1, WCHAR]
  PMPR_IFTRANSPORT_0* = ptr MPR_IFTRANSPORT_0
  MPR_SERVER_0* {.pure.} = object
    fLanOnlyMode*: WINBOOL
    dwUpTime*: DWORD
    dwTotalPorts*: DWORD
    dwPortsInUse*: DWORD
  PMPR_SERVER_0* = ptr MPR_SERVER_0
  MPR_SERVER_1* {.pure.} = object
    dwNumPptpPorts*: DWORD
    dwPptpPortFlags*: DWORD
    dwNumL2tpPorts*: DWORD
    dwL2tpPortFlags*: DWORD
  PMPR_SERVER_1* = ptr MPR_SERVER_1
  RAS_CONNECTION_0* {.pure.} = object
    hConnection*: HANDLE
    hInterface*: HANDLE
    dwConnectDuration*: DWORD
    dwInterfaceType*: ROUTER_INTERFACE_TYPE
    dwConnectionFlags*: DWORD
    wszInterfaceName*: array[MAX_INTERFACE_NAME_LEN + 1 , WCHAR]
    wszUserName*: array[UNLEN + 1 , WCHAR]
    wszLogonDomain*: array[DNLEN + 1 , WCHAR]
    wszRemoteComputer*: array[NETBIOS_NAME_LEN + 1 , WCHAR]
  PRAS_CONNECTION_0* = ptr RAS_CONNECTION_0
  PPP_NBFCP_INFO* {.pure.} = object
    dwError*: DWORD
    wszWksta*: array[NETBIOS_NAME_LEN + 1 , WCHAR]
const
  IPADDRESSLEN* = 15
type
  PPP_IPCP_INFO* {.pure.} = object
    dwError*: DWORD
    wszAddress*: array[IPADDRESSLEN + 1 , WCHAR]
    wszRemoteAddress*: array[IPADDRESSLEN + 1 , WCHAR]
const
  IPXADDRESSLEN* = 22
type
  PPP_IPXCP_INFO* {.pure.} = object
    dwError*: DWORD
    wszAddress*: array[IPXADDRESSLEN + 1 , WCHAR]
const
  ATADDRESSLEN* = 32
type
  PPP_ATCP_INFO* {.pure.} = object
    dwError*: DWORD
    wszAddress*: array[ATADDRESSLEN + 1 , WCHAR]
  PPP_INFO* {.pure.} = object
    nbf*: PPP_NBFCP_INFO
    ip*: PPP_IPCP_INFO
    ipx*: PPP_IPXCP_INFO
    at*: PPP_ATCP_INFO
  RAS_CONNECTION_1* {.pure.} = object
    hConnection*: HANDLE
    hInterface*: HANDLE
    PppInfo*: PPP_INFO
    dwBytesXmited*: DWORD
    dwBytesRcved*: DWORD
    dwFramesXmited*: DWORD
    dwFramesRcved*: DWORD
    dwCrcErr*: DWORD
    dwTimeoutErr*: DWORD
    dwAlignmentErr*: DWORD
    dwHardwareOverrunErr*: DWORD
    dwFramingErr*: DWORD
    dwBufferOverrunErr*: DWORD
    dwCompressionRatioIn*: DWORD
    dwCompressionRatioOut*: DWORD
  PRAS_CONNECTION_1* = ptr RAS_CONNECTION_1
  PPP_IPCP_INFO2* {.pure.} = object
    dwError*: DWORD
    wszAddress*: array[IPADDRESSLEN + 1 , WCHAR]
    wszRemoteAddress*: array[IPADDRESSLEN + 1 , WCHAR]
    dwOptions*: DWORD
    dwRemoteOptions*: DWORD
  PPP_CCP_INFO* {.pure.} = object
    dwError*: DWORD
    dwCompressionAlgorithm*: DWORD
    dwOptions*: DWORD
    dwRemoteCompressionAlgorithm*: DWORD
    dwRemoteOptions*: DWORD
  PPP_LCP_INFO* {.pure.} = object
    dwError*: DWORD
    dwAuthenticationProtocol*: DWORD
    dwAuthenticationData*: DWORD
    dwRemoteAuthenticationProtocol*: DWORD
    dwRemoteAuthenticationData*: DWORD
    dwTerminateReason*: DWORD
    dwRemoteTerminateReason*: DWORD
    dwOptions*: DWORD
    dwRemoteOptions*: DWORD
    dwEapTypeId*: DWORD
    dwRemoteEapTypeId*: DWORD
  PPP_INFO_2* {.pure.} = object
    nbf*: PPP_NBFCP_INFO
    ip*: PPP_IPCP_INFO2
    ipx*: PPP_IPXCP_INFO
    at*: PPP_ATCP_INFO
    ccp*: PPP_CCP_INFO
    lcp*: PPP_LCP_INFO
  RAS_CONNECTION_2* {.pure.} = object
    hConnection*: HANDLE
    wszUserName*: array[UNLEN + 1 , WCHAR]
    dwInterfaceType*: ROUTER_INTERFACE_TYPE
    guid*: GUID
    PppInfo2*: PPP_INFO_2
  PRAS_CONNECTION_2* = ptr RAS_CONNECTION_2
  RAS_USER_1* {.pure.} = object
    bfPrivilege*: BYTE
    wszPhoneNumber*: array[MAX_PHONE_NUMBER_LEN + 1, WCHAR]
    bfPrivilege2*: BYTE
  PRAS_USER_1* = ptr RAS_USER_1
  MPR_FILTER_0* {.pure.} = object
    fEnabled*: WINBOOL
  PMPR_FILTER_0* = ptr MPR_FILTER_0
  MPR_SERVER_2* {.pure.} = object
    dwNumPptpPorts*: DWORD
    dwPptpPortFlags*: DWORD
    dwNumL2tpPorts*: DWORD
    dwL2tpPortFlags*: DWORD
    dwNumSstpPorts*: DWORD
    dwSstpPortFlags*: DWORD
  PMPR_SERVER_2* = ptr MPR_SERVER_2
  PPP_IPV6_CP_INFO* {.pure.} = object
    dwVersion*: DWORD
    dwSize*: DWORD
    dwError*: DWORD
    bInterfaceIdentifier*: array[8, BYTE]
    bRemoteInterfaceIdentifier*: array[8, BYTE]
    dwOptions*: DWORD
    dwRemoteOptions*: DWORD
    bPrefix*: array[8, BYTE]
    dwPrefixLength*: DWORD
  PPPP_IPV6_CP_INFO* = ptr PPP_IPV6_CP_INFO
  PPP_INFO_3* {.pure.} = object
    nbf*: PPP_NBFCP_INFO
    ip*: PPP_IPCP_INFO2
    ipv6*: PPP_IPV6_CP_INFO
    ccp*: PPP_CCP_INFO
    lcp*: PPP_LCP_INFO
  RAS_CONNECTION_3* {.pure.} = object
    dwVersion*: DWORD
    dwSize*: DWORD
    hConnection*: HANDLE
    wszUserName*: array[UNLEN + 1, WCHAR]
    dwInterfaceType*: ROUTER_INTERFACE_TYPE
    guid*: GUID
    PppInfo3*: PPP_INFO_3
    rasQuarState*: RAS_QUARANTINE_STATE
    timer*: FILETIME
  PRAS_CONNECTION_3* = ptr RAS_CONNECTION_3
  MPRAPI_OBJECT_HEADER* {.pure.} = object
    revision*: UCHAR
    `type`*: UCHAR
    size*: USHORT
  PMPRAPI_OBJECT_HEADER* = ptr MPRAPI_OBJECT_HEADER
  AUTH_VALIDATION_EX* {.pure.} = object
    Header*: MPRAPI_OBJECT_HEADER
    hRasConnection*: HANDLE
    wszUserName*: array[UNLEN + 1 , WCHAR]
    wszLogonDomain*: array[DNLEN + 1 , WCHAR]
    AuthInfoSize*: DWORD
    AuthInfo*: array[1, BYTE]
  PAUTH_VALIDATION_EX* = ptr AUTH_VALIDATION_EX
  PPP_PROJECTION_INFO* {.pure.} = object
    dwIPv4NegotiationError*: DWORD
    wszAddress*: array[IPADDRESSLEN + 1, WCHAR]
    wszRemoteAddress*: array[IPADDRESSLEN + 1, WCHAR]
    dwIPv4Options*: DWORD
    dwIPv4RemoteOptions*: DWORD
    IPv4SubInterfaceIndex*: ULONG64
    dwIPv6NegotiationError*: DWORD
    bInterfaceIdentifier*: array[8, BYTE]
    bRemoteInterfaceIdentifier*: array[8, BYTE]
    bPrefix*: array[8, BYTE]
    dwPrefixLength*: DWORD
    IPv6SubInterfaceIndex*: ULONG64
    dwLcpError*: DWORD
    dwAuthenticationProtocol*: DWORD
    dwAuthenticationData*: DWORD
    dwRemoteAuthenticationProtocol*: DWORD
    dwRemoteAuthenticationData*: DWORD
    dwLcpTerminateReason*: DWORD
    dwLcpRemoteTerminateReason*: DWORD
    dwLcpOptions*: DWORD
    dwLcpRemoteOptions*: DWORD
    dwEapTypeId*: DWORD
    dwRemoteEapTypeId*: DWORD
    dwCcpError*: DWORD
    dwCompressionAlgorithm*: DWORD
    dwCcpOptions*: DWORD
    dwRemoteCompressionAlgorithm*: DWORD
    dwCcpRemoteOptions*: DWORD
  PPPP_PROJECTION_INFO* = ptr PPP_PROJECTION_INFO
  IKEV2_PROJECTION_INFO* {.pure.} = object
    dwIPv4NegotiationError*: DWORD
    wszAddress*: array[IPADDRESSLEN + 1, WCHAR]
    wszRemoteAddress*: array[IPADDRESSLEN + 1, WCHAR]
    IPv4SubInterfaceIndex*: ULONG64
    dwIPv6NegotiationError*: DWORD
    bInterfaceIdentifier*: array[8, BYTE]
    bRemoteInterfaceIdentifier*: array[8, BYTE]
    bPrefix*: array[8, BYTE]
    dwPrefixLength*: DWORD
    IPv6SubInterfaceIndex*: ULONG64
    dwOptions*: DWORD
    dwAuthenticationProtocol*: DWORD
    dwEapTypeId*: DWORD
    dwCompressionAlgorithm*: DWORD
    dwEncryptionMethod*: DWORD
  PIKEV2_PROJECTION_INFO* = ptr IKEV2_PROJECTION_INFO
  PROJECTION_INFO_UNION1* {.pure, union.} = object
    Ikev2ProjectionInfo*: IKEV2_PROJECTION_INFO
    PppProjectionInfo*: PPP_PROJECTION_INFO
  PROJECTION_INFO* {.pure.} = object
    projectionInfoType*: UCHAR
    union1*: PROJECTION_INFO_UNION1
  PPROJECTION_INFO* = ptr PROJECTION_INFO
const
  MAXIPADRESSLEN* = 64
type
  RAS_CONNECTION_EX* {.pure.} = object
    Header*: MPRAPI_OBJECT_HEADER
    dwConnectDuration*: DWORD
    dwInterfaceType*: ROUTER_INTERFACE_TYPE
    dwConnectionFlags*: DWORD
    wszInterfaceName*: array[MAX_INTERFACE_NAME_LEN + 1, WCHAR]
    wszUserName*: array[UNLEN + 1, WCHAR]
    wszLogonDomain*: array[DNLEN + 1, WCHAR]
    wszRemoteComputer*: array[NETBIOS_NAME_LEN + 1, WCHAR]
    guid*: GUID
    rasQuarState*: RAS_QUARANTINE_STATE
    probationTime*: FILETIME
    dwBytesXmited*: DWORD
    dwBytesRcved*: DWORD
    dwFramesXmited*: DWORD
    dwFramesRcved*: DWORD
    dwCrcErr*: DWORD
    dwTimeoutErr*: DWORD
    dwAlignmentErr*: DWORD
    dwHardwareOverrunErr*: DWORD
    dwFramingErr*: DWORD
    dwBufferOverrunErr*: DWORD
    dwCompressionRatioIn*: DWORD
    dwCompressionRatioOut*: DWORD
    dwNumSwitchOvers*: DWORD
    wszRemoteEndpointAddress*: array[MAXIPADRESSLEN+1, WCHAR]
    wszLocalEndpointAddress*: array[MAXIPADRESSLEN+1, WCHAR]
    ProjectionInfo*: PROJECTION_INFO
    hConnection*: HANDLE
    hInterface*: HANDLE
  PRAS_CONNECTION_EX* = ptr RAS_CONNECTION_EX
  RAS_UPDATE_CONNECTION* {.pure.} = object
    Header*: MPRAPI_OBJECT_HEADER
    dwIfIndex*: DWORD
    wszLocalEndpointAddress*: array[MAXIPADRESSLEN+1, WCHAR]
    wszRemoteEndpointAddress*: array[MAXIPADRESSLEN+1, WCHAR]
  PRAS_UPDATE_CONNECTION* = ptr RAS_UPDATE_CONNECTION
  IKEV2_TUNNEL_CONFIG_PARAMS* {.pure.} = object
    dwIdleTimeout*: DWORD
    dwNetworkBlackoutTime*: DWORD
    dwSaLifeTime*: DWORD
    dwSaDataSizeForRenegotiation*: DWORD
    dwConfigOptions*: DWORD
    dwTotalCertificates*: DWORD
    certificateNames*: ptr CERT_NAME_BLOB
  PIKEV2_TUNNEL_CONFIG_PARAMS* = ptr IKEV2_TUNNEL_CONFIG_PARAMS
  IKEV2_CONFIG_PARAMS* {.pure.} = object
    dwNumPorts*: DWORD
    dwPortFlags*: DWORD
    dwTunnelConfigParamFlags*: DWORD
    TunnelConfigParams*: IKEV2_TUNNEL_CONFIG_PARAMS
  PIKEV2_CONFIG_PARAMS* = ptr IKEV2_CONFIG_PARAMS
  PPTP_CONFIG_PARAMS* {.pure.} = object
    dwNumPorts*: DWORD
    dwPortFlags*: DWORD
  PPPTP_CONFIG_PARAMS* = ptr PPTP_CONFIG_PARAMS
  L2TP_CONFIG_PARAMS* {.pure.} = object
    dwNumPorts*: DWORD
    dwPortFlags*: DWORD
  PL2TP_CONFIG_PARAMS* = ptr L2TP_CONFIG_PARAMS
  SSTP_CERT_INFO* {.pure.} = object
    isDefault*: BOOL
    certBlob*: CRYPT_HASH_BLOB
  PSSTP_CERT_INFO* = ptr SSTP_CERT_INFO
  SSTP_CONFIG_PARAMS* {.pure.} = object
    dwNumPorts*: DWORD
    dwPortFlags*: DWORD
    isUseHttps*: BOOL
    certAlgorithm*: DWORD
    sstpCertDetails*: SSTP_CERT_INFO
  PSSTP_CONFIG_PARAMS* = ptr SSTP_CONFIG_PARAMS
  MPRAPI_TUNNEL_CONFIG_PARAMS* {.pure.} = object
    IkeConfigParams*: IKEV2_CONFIG_PARAMS
    PptpConfigParams*: PPTP_CONFIG_PARAMS
    L2tpConfigParams*: L2TP_CONFIG_PARAMS
    SstpConfigParams*: SSTP_CONFIG_PARAMS
  PMPRAPI_TUNNEL_CONFIG_PARAMS* = ptr MPRAPI_TUNNEL_CONFIG_PARAMS
  MPR_SERVER_SET_CONFIG_EX* {.pure.} = object
    Header*: MPRAPI_OBJECT_HEADER
    setConfigForProtocols*: DWORD
    ConfigParams*: MPRAPI_TUNNEL_CONFIG_PARAMS
  PMPR_SERVER_SET_CONFIG_EX* = ptr MPR_SERVER_SET_CONFIG_EX
  MPR_SERVER_EX* {.pure.} = object
    Header*: MPRAPI_OBJECT_HEADER
    fLanOnlyMode*: DWORD
    dwUpTime*: DWORD
    dwTotalPorts*: DWORD
    dwPortsInUse*: DWORD
    Reserved*: DWORD
    ConfigParams*: MPRAPI_TUNNEL_CONFIG_PARAMS
  PMPR_SERVER_EX* = ptr MPR_SERVER_EX
  PMPRADMINGETIPADDRESSFORUSER* = proc (P1: ptr WCHAR, P2: ptr WCHAR, P3: ptr DWORD, P4: ptr WINBOOL): DWORD {.stdcall.}
  PMPRADMINRELEASEIPADRESS* = proc (P1: ptr WCHAR, P2: ptr WCHAR, P3: ptr DWORD): VOID {.stdcall.}
  PMPRADMINGETIPV6ADDRESSFORUSER* = proc (P1: ptr WCHAR, P2: ptr WCHAR, P3: ptr IN6_ADDR, P4: ptr WINBOOL): DWORD {.stdcall.}
  PMPRADMINRELEASEIPV6ADDRESSFORUSER* = proc (P1: ptr WCHAR, P2: ptr WCHAR, P3: ptr IN6_ADDR): VOID {.stdcall.}
  PMPRADMINACCEPTNEWLINK* = proc (P1: ptr RAS_PORT_0, P2: ptr RAS_PORT_1): WINBOOL {.stdcall.}
  PMPRADMINLINKHANGUPNOTIFICATION* = proc (P1: ptr RAS_PORT_0, P2: ptr RAS_PORT_1): VOID {.stdcall.}
  PMPRADMINTERMINATEDLL* = proc (): DWORD {.stdcall.}
  PMPRADMINACCEPTNEWCONNECTIONEX* = proc (P1: ptr RAS_CONNECTION_EX): BOOL {.stdcall.}
  PMPRADMINACCEPTREAUTHENTICATIONEX* = proc (P1: ptr RAS_CONNECTION_EX): BOOL {.stdcall.}
  PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX* = proc (P1: ptr RAS_CONNECTION_EX): VOID {.stdcall.}
  MPRAPI_ADMIN_DLL_CALLBACKS* {.pure.} = object
    revision*: UCHAR
    lpfnMprAdminGetIpAddressForUser*: PMPRADMINGETIPADDRESSFORUSER
    lpfnMprAdminReleaseIpAddress*: PMPRADMINRELEASEIPADRESS
    lpfnMprAdminGetIpv6AddressForUser*: PMPRADMINGETIPV6ADDRESSFORUSER
    lpfnMprAdminReleaseIpV6AddressForUser*: PMPRADMINRELEASEIPV6ADDRESSFORUSER
    lpfnRasAdminAcceptNewLink*: PMPRADMINACCEPTNEWLINK
    lpfnRasAdminLinkHangupNotification*: PMPRADMINLINKHANGUPNOTIFICATION
    lpfnRasAdminTerminateDll*: PMPRADMINTERMINATEDLL
    lpfnRasAdminAcceptNewConnectionEx*: PMPRADMINACCEPTNEWCONNECTIONEX
    lpfnRasAdminAcceptReauthenticationEx*: PMPRADMINACCEPTREAUTHENTICATIONEX
    lpfnRasAdminConnectionHangupNotificationEx*: PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX
  PMPRAPI_ADMIN_DLL_CALLBACKS* = ptr MPRAPI_ADMIN_DLL_CALLBACKS
  SECURITY_MESSAGE* {.pure.} = object
    dwMsgId*: DWORD
    hPort*: HPORT
    dwError*: DWORD
    UserName*: array[UNLEN+1, CHAR]
    Domain*: array[DNLEN+1, CHAR]
  PSECURITY_MESSAGE* = ptr SECURITY_MESSAGE
  RAS_SECURITY_INFO* {.pure.} = object
    LastError*: DWORD
    BytesReceived*: DWORD
    DeviceName*: array[MAX_DEVICE_NAME+1, CHAR]
  PRAS_SECURITY_INFO* = ptr RAS_SECURITY_INFO
const
  freshSoHRequest* = 0x1
  shaFixup* = 0x1
  percentageNotSupported* = 101
  maxSoHAttributeCount* = 100
  maxSoHAttributeSize* = 4000
  minNetworkSoHSize* = 12
  maxNetworkSoHSize* = 4000
  maxDwordCountPerSoHAttribute* = maxSoHAttributeSize/sizeof(DWORD)
  maxIpv4CountPerSoHAttribute* = maxSoHAttributeSize/4
  maxIpv6CountPerSoHAttribute* = maxSoHAttributeSize/16
  maxStringLength* = 1024
  maxStringLengthInBytes* = (maxStringLength+1)*sizeof(WCHAR)
  maxSystemHealthEntityCount* = 20
  maxEnforcerCount* = 20
  maxPrivateDataSize* = 200
  maxConnectionCountPerEnforcer* = 20
  maxCachedSoHCount* = (maxSystemHealthEntityCount*maxEnforcerCount)*maxConnectionCountPerEnforcer
  failureCategoryCount* = 5
  componentTypeEnforcementClientSoH* = 0x1
  componentTypeEnforcementClientRp* = 0x2
  isolationStateNotRestricted* = 1
  isolationStateInProbation* = 2
  isolationStateRestrictedAccess* = 3
  extendedIsolationStateNoData* = 0x0
  extendedIsolationStateTransition* = 0x1
  extendedIsolationStateInfected* = 0x2
  extendedIsolationStateUnknown* = 0x3
  tracingLevelUndefined* = 0
  tracingLevelBasic* = 1
  tracingLevelAdvanced* = 2
  tracingLevelDebug* = 3
  failureCategoryNone* = 0
  failureCategoryOther* = 1
  failureCategoryClientComponent* = 2
  failureCategoryClientCommunication* = 3
  failureCategoryServerComponent* = 4
  failureCategoryServerCommunication* = 5
  fixupStateSuccess* = 0
  fixupStateInProgress* = 1
  fixupStateCouldNotUpdate* = 2
  napNotifyTypeUnknown* = 0
  napNotifyTypeServiceState* = 1
  napNotifyTypeQuarState* = 2
  remoteConfigTypeMachine* = 1
  remoteConfigTypeConfigBlob* = 2
  RASCF_AllUsers* = 0x00000001
  RASCF_GlobalCreds* = 0x00000002
  RASCS_PAUSED* = 0x1000
  RASCS_DONE* = 0x2000
  RASCS_OpenPort* = 0
  RASCS_PortOpened* = 1
  RASCS_ConnectDevice* = 2
  RASCS_DeviceConnected* = 3
  RASCS_AllDevicesConnected* = 4
  RASCS_Authenticate* = 5
  RASCS_AuthNotify* = 6
  RASCS_AuthRetry* = 7
  RASCS_AuthCallback* = 8
  RASCS_AuthChangePassword* = 9
  RASCS_AuthProject* = 10
  RASCS_AuthLinkSpeed* = 11
  RASCS_AuthAck* = 12
  RASCS_ReAuthenticate* = 13
  RASCS_Authenticated* = 14
  RASCS_PrepareForCallback* = 15
  RASCS_WaitForModemReset* = 16
  RASCS_WaitForCallback* = 17
  RASCS_Projected* = 18
  RASCS_StartAuthentication* = 19
  RASCS_CallbackComplete* = 20
  RASCS_LogonNetwork* = 21
  RASCS_SubEntryConnected* = 22
  RASCS_SubEntryDisconnected* = 23
  RASCS_Interactive* = RASCS_PAUSED
  RASCS_RetryAuthentication* = RASCS_PAUSED+1
  RASCS_CallbackSetByCaller* = RASCS_PAUSED+2
  RASCS_PasswordExpired* = RASCS_PAUSED+3
  RASCS_InvokeEapUI* = RASCS_PAUSED+4
  RASCS_Connected* = RASCS_DONE
  RASCS_Disconnected* = RASCS_DONE+1
  RDEOPT_UsePrefixSuffix* = 0x00000001
  RDEOPT_PausedStates* = 0x00000002
  RDEOPT_IgnoreModemSpeaker* = 0x00000004
  RDEOPT_SetModemSpeaker* = 0x00000008
  RDEOPT_IgnoreSoftwareCompression* = 0x00000010
  RDEOPT_SetSoftwareCompression* = 0x00000020
  RDEOPT_DisableConnectedUI* = 0x00000040
  RDEOPT_DisableReconnectUI* = 0x00000080
  RDEOPT_DisableReconnect* = 0x00000100
  RDEOPT_NoUser* = 0x00000200
  RDEOPT_PauseOnScript* = 0x00000400
  RDEOPT_Router* = 0x00000800
  RDEOPT_CustomDial* = 0x00001000
  RDEOPT_UseCustomScripting* = 0x00002000
  REN_User* = 0x00000000
  REN_AllUsers* = 0x00000001
  RASP_Amb* = 0x10000
  RASP_PppNbf* = 0x803F
  RASP_PppIpx* = 0x802B
  RASP_PppIp* = 0x8021
  RASP_PppCcp* = 0x80FD
  RASP_PppLcp* = 0xC021
  RASP_Slip* = 0x20000
  RASIPO_VJ* = 0x00000001
  RASLCPAP_PAP* = 0xC023
  RASLCPAP_SPAP* = 0xC027
  RASLCPAP_CHAP* = 0xC223
  RASLCPAP_EAP* = 0xC227
  RASLCPAD_CHAP_MD5* = 0x05
  RASLCPAD_CHAP_MS* = 0x80
  RASLCPAD_CHAP_MSV2* = 0x81
  RASLCPO_PFC* = 0x00000001
  RASLCPO_ACFC* = 0x00000002
  RASLCPO_SSHF* = 0x00000004
  RASLCPO_DES_56* = 0x00000008
  RASLCPO_3_DES* = 0x00000010
  RASCCPCA_MPPC* = 0x00000006
  RASCCPCA_STAC* = 0x00000005
  RASCCPO_Compression* = 0x00000001
  RASCCPO_HistoryLess* = 0x00000002
  RASCCPO_Encryption56bit* = 0x00000010
  RASCCPO_Encryption40bit* = 0x00000020
  RASCCPO_Encryption128bit* = 0x00000040
  RASDIALEVENT* = "RasDialEvent"
  WM_RASDIALEVENT* = 0xCCCD
  ET_None* = 0
  ET_Require* = 1
  ET_RequireMax* = 2
  ET_Optional* = 3
  VS_Default* = 0
  VS_PptpOnly* = 1
  VS_PptpFirst* = 2
  VS_L2tpOnly* = 3
  VS_L2tpFirst* = 4
  RASEO_UseCountryAndAreaCodes* = 0x00000001
  RASEO_SpecificIpAddr* = 0x00000002
  RASEO_SpecificNameServers* = 0x00000004
  RASEO_IpHeaderCompression* = 0x00000008
  RASEO_RemoteDefaultGateway* = 0x00000010
  RASEO_DisableLcpExtensions* = 0x00000020
  RASEO_TerminalBeforeDial* = 0x00000040
  RASEO_TerminalAfterDial* = 0x00000080
  RASEO_ModemLights* = 0x00000100
  RASEO_SwCompression* = 0x00000200
  RASEO_RequireEncryptedPw* = 0x00000400
  RASEO_RequireMsEncryptedPw* = 0x00000800
  RASEO_RequireDataEncryption* = 0x00001000
  RASEO_NetworkLogon* = 0x00002000
  RASEO_UseLogonCredentials* = 0x00004000
  RASEO_PromoteAlternates* = 0x00008000
  RASEO_SecureLocalFiles* = 0x00010000
  RASEO_RequireEAP* = 0x00020000
  RASEO_RequirePAP* = 0x00040000
  RASEO_RequireSPAP* = 0x00080000
  RASEO_Custom* = 0x00100000
  RASEO_PreviewPhoneNumber* = 0x00200000
  RASEO_SharedPhoneNumbers* = 0x00800000
  RASEO_PreviewUserPw* = 0x01000000
  RASEO_PreviewDomain* = 0x02000000
  RASEO_ShowDialingProgress* = 0x04000000
  RASEO_RequireCHAP* = 0x08000000
  RASEO_RequireMsCHAP* = 0x10000000
  RASEO_RequireMsCHAP2* = 0x20000000
  RASEO_RequireW95MSCHAP* = 0x40000000
  RASEO_CustomScript* = 0x80000000'i32
  RASEO2_SecureFileAndPrint* = 0x00000001
  RASEO2_SecureClientForMSNet* = 0x00000002
  RASEO2_DontNegotiateMultilink* = 0x00000004
  RASEO2_DontUseRasCredentials* = 0x00000008
  RASEO2_UsePreSharedKey* = 0x00000010
  RASEO2_Internet* = 0x00000020
  RASEO2_DisableNbtOverIP* = 0x00000040
  RASEO2_UseGlobalDeviceSettings* = 0x00000080
  RASEO2_ReconnectIfDropped* = 0x00000100
  RASEO2_SharePhoneNumbers* = 0x00000200
  RASNP_NetBEUI* = 0x00000001
  RASNP_Ipx* = 0x00000002
  RASNP_Ip* = 0x00000004
  RASFP_Ppp* = 0x00000001
  RASFP_Slip* = 0x00000002
  RASFP_Ras* = 0x00000004
  RASDT_Modem* = "modem"
  RASDT_Isdn* = "isdn"
  RASDT_X25* = "x25"
  RASDT_Vpn* = "vpn"
  RASDT_Pad* = "pad"
  RASDT_Generic* = "GENERIC"
  RASDT_Serial* = "SERIA"
  RASDT_FrameRelay* = "FRAMERELAY"
  RASDT_Atm* = "ATM"
  RASDT_Sonet* = "SONET"
  RASDT_SW56* = "SW56"
  RASDT_Irda* = "IRDA"
  RASDT_Parallel* = "PARALLE"
  RASDT_PPPoE* = "PPPoE"
  RASET_Phone* = 1
  RASET_Vpn* = 2
  RASET_Direct* = 3
  RASET_Internet* = 4
  RASET_Broadband* = 5
  RASCN_Connection* = 0x00000001
  RASCN_Disconnection* = 0x00000002
  RASCN_BandwidthAdded* = 0x00000004
  RASCN_BandwidthRemoved* = 0x00000008
  RASEDM_DialAll* = 1
  RASEDM_DialAsNeeded* = 2
  RASIDS_Disabled* = 0xffffffff'i32
  RASIDS_UseGlobalValue* = 0
  RASADFLG_PositionDlg* = 0x00000001
  RASCM_UserName* = 0x00000001
  RASCM_Password* = 0x00000002
  RASCM_Domain* = 0x00000004
  RASCM_DefaultCreds* = 0x00000008
  RASCM_PreSharedKey* = 0x00000010
  RASCM_ServerPreSharedKey* = 0x00000020
  RASCM_DDMPreSharedKey* = 0x00000040
  RASADP_DisableConnectionQuery* = 0
  RASADP_LoginSessionDisable* = 1
  RASADP_SavedAddressesLimit* = 2
  RASADP_FailedConnectionTimeout* = 3
  RASADP_ConnectionQueryTimeout* = 4
  RASEAPF_NonInteractive* = 0x00000002
  RASEAPF_Logon* = 0x00000004
  RASEAPF_Preview* = 0x00000008
  RCD_SingleUser* = 0
  RCD_AllUsers* = 0x00000001
  RCD_Eap* = 0x00000002
  RCD_Logon* = 0x00000004
  RASAPIVERSION_500* = 1
  RASAPIVERSION_501* = 2
  RASAPIVERSION_600* = 3
  RASAPIVERSION_601* = 4
  RASPBDEVENT_AddEntry* = 1
  RASPBDEVENT_EditEntry* = 2
  RASPBDEVENT_RemoveEntry* = 3
  RASPBDEVENT_DialEntry* = 4
  RASPBDEVENT_EditGlobals* = 5
  RASPBDEVENT_NoUser* = 6
  RASPBDEVENT_NoUserEdit* = 7
  RASNOUSER_SmartCard* = 0x00000001
  RASPBDFLAG_PositionDlg* = 0x00000001
  RASPBDFLAG_ForceCloseOnDial* = 0x00000002
  RASPBDFLAG_NoUser* = 0x00000010
  RASPBDFLAG_UpdateDefaults* = 0x80000000'i32
  RASEDFLAG_PositionDlg* = 0x00000001
  RASEDFLAG_NewEntry* = 0x00000002
  RASEDFLAG_CloneEntry* = 0x00000004
  RASEDFLAG_NoRename* = 0x00000008
  RASEDFLAG_ShellOwned* = 0x40000000
  RASEDFLAG_NewPhoneEntry* = 0x00000010
  RASEDFLAG_NewTunnelEntry* = 0x00000020
  RASEDFLAG_NewDirectEntry* = 0x00000040
  RASEDFLAG_NewBroadbandEntry* = 0x00000080
  RASEDFLAG_InternetEntry* = 0x00000100
  RASEDFLAG_NAT* = 0x00000200
  RASEDFLAG_IncomingConnection* = 0x00000400
  RASDDFLAG_PositionDlg* = 0x00000001
  RASDDFLAG_NoPrompt* = 0x00000002
  RASDDFLAG_LinkFailure* = 0x80000000'i32
  RAS_EAP_REGISTRY_LOCATION* = "System\\CurrentControlSet\\Services\\Rasman\\PPP\\EAP"
  RAS_EAP_VALUENAME_PATH* = "Path"
  RAS_EAP_VALUENAME_CONFIGUI* = "ConfigUIPath"
  RAS_EAP_VALUENAME_INTERACTIVEUI* = "InteractiveUIPath"
  RAS_EAP_VALUENAME_IDENTITY* = "IdentityPath"
  RAS_EAP_VALUENAME_FRIENDLY_NAME* = "FriendlyName"
  RAS_EAP_VALUENAME_DEFAULT_DATA* = "ConfigData"
  RAS_EAP_VALUENAME_REQUIRE_CONFIGUI* = "RequireConfigUI"
  RAS_EAP_VALUENAME_ENCRYPTION* = "MPPEEncryptionSupported"
  RAS_EAP_VALUENAME_INVOKE_NAMEDLG* = "InvokeUsernameDialog"
  RAS_EAP_VALUENAME_INVOKE_PWDDLG* = "InvokePasswordDialog"
  RAS_EAP_VALUENAME_CONFIG_CLSID* = "ConfigCLSID"
  RAS_EAP_VALUENAME_STANDALONE_SUPPORTED* = "StandaloneSupported"
  RAS_EAP_VALUENAME_ROLES_SUPPORTED* = "RolesSupported"
  RAS_EAP_VALUENAME_PER_POLICY_CONFIG* = "PerPolicyConfig"
  RAS_EAP_VALUENAME_ISTUNNEL_METHOD* = "IsTunnelMethod"
  RAS_EAP_VALUENAME_FILTER_INNERMETHODS* = "FilterInnerMethods"
  RAS_EAP_ROLE_AUTHENTICATOR* = 0x00000001
  RAS_EAP_ROLE_AUTHENTICATEE* = 0x00000002
  RAS_EAP_ROLE_EXCLUDE_IN_EAP* = 0x00000004
  RAS_EAP_ROLE_EXCLUDE_IN_PEAP* = 0x00000008
  RAS_EAP_ROLE_EXCLUDE_IN_VPN* = 0x00000010
  raatMinimum* = 0
  raatUserName* = 1
  raatUserPassword* = 2
  raatMD5CHAPPassword* = 3
  raatNASIPAddress* = 4
  raatNASPort* = 5
  raatServiceType* = 6
  raatFramedProtocol* = 7
  raatFramedIPAddress* = 8
  raatFramedIPNetmask* = 9
  raatFramedRouting* = 10
  raatFilterId* = 11
  raatFramedMTU* = 12
  raatFramedCompression* = 13
  raatLoginIPHost* = 14
  raatLoginService* = 15
  raatLoginTCPPort* = 16
  raatUnassigned17* = 17
  raatReplyMessage* = 18
  raatCallbackNumber* = 19
  raatCallbackId* = 20
  raatUnassigned21* = 21
  raatFramedRoute* = 22
  raatFramedIPXNetwork* = 23
  raatState* = 24
  raatClass* = 25
  raatVendorSpecific* = 26
  raatSessionTimeout* = 27
  raatIdleTimeout* = 28
  raatTerminationAction* = 29
  raatCalledStationId* = 30
  raatCallingStationId* = 31
  raatNASIdentifier* = 32
  raatProxyState* = 33
  raatLoginLATService* = 34
  raatLoginLATNode* = 35
  raatLoginLATGroup* = 36
  raatFramedAppleTalkLink* = 37
  raatFramedAppleTalkNetwork* = 38
  raatFramedAppleTalkZone* = 39
  raatAcctStatusType* = 40
  raatAcctDelayTime* = 41
  raatAcctInputOctets* = 42
  raatAcctOutputOctets* = 43
  raatAcctSessionId* = 44
  raatAcctAuthentic* = 45
  raatAcctSessionTime* = 46
  raatAcctInputPackets* = 47
  raatAcctOutputPackets* = 48
  raatAcctTerminateCause* = 49
  raatAcctMultiSessionId* = 50
  raatAcctLinkCount* = 51
  raatAcctEventTimeStamp* = 55
  raatMD5CHAPChallenge* = 60
  raatNASPortType* = 61
  raatPortLimit* = 62
  raatLoginLATPort* = 63
  raatTunnelType* = 64
  raatTunnelMediumType* = 65
  raatTunnelClientEndpoint* = 66
  raatTunnelServerEndpoint* = 67
  raatARAPPassword* = 70
  raatARAPFeatures* = 71
  raatARAPZoneAccess* = 72
  raatARAPSecurity* = 73
  raatARAPSecurityData* = 74
  raatPasswordRetry* = 75
  raatPrompt* = 76
  raatConnectInfo* = 77
  raatConfigurationToken* = 78
  raatEAPMessage* = 79
  raatSignature* = 80
  raatARAPChallengeResponse* = 84
  raatAcctInterimInterval* = 85
  raatNASIPv6Address* = 95
  raatFramedInterfaceId* = 96
  raatFramedIPv6Prefix* = 97
  raatLoginIPv6Host* = 98
  raatFramedIPv6Route* = 99
  raatFramedIPv6Pool* = 100
  raatARAPGuestLogon* = 8096
  raatCertificateOID* = 8097
  raatEAPConfiguration* = 8098
  raatPEAPEmbeddedEAPTypeId* = 8099
  raatInnerEAPTypeId* = 8099
  raatPEAPFastRoamedSession* = 8100
  raatFastRoamedSession* = 8100
  raatEAPTLV* = 8102
  raatCredentialsChanged* = 8103
  raatPeerId* = 9000
  raatServerId* = 9001
  raatMethodId* = 9002
  raatEMSK* = 9003
  raatSessionId* = 9004
  raatReserved* = 0xffffffff'i32
  raatARAPChallenge* = 33
  raatARAPOldPassword* = 19
  raatARAPNewPassword* = 20
  raatARAPPasswordChangeReason* = 21
  EAPCODE_Request* = 1
  EAPCODE_Response* = 2
  EAPCODE_Success* = 3
  EAPCODE_Failure* = 4
  MAXEAPCODE* = 4
  RAS_EAP_FLAG_ROUTER* = 0x00000001
  RAS_EAP_FLAG_NON_INTERACTIVE* = 0x00000002
  RAS_EAP_FLAG_LOGON* = 0x00000004
  RAS_EAP_FLAG_PREVIEW* = 0x00000008
  RAS_EAP_FLAG_FIRST_LINK* = 0x00000010
  RAS_EAP_FLAG_MACHINE_AUTH* = 0x00000020
  RAS_EAP_FLAG_GUEST_ACCESS* = 0x00000040
  RAS_EAP_FLAG_8021X_AUTH* = 0x00000080
  RAS_EAP_FLAG_HOSTED_IN_PEAP* = 0x00000100
  RAS_EAP_FLAG_RESUME_FROM_HIBERNATE* = 0x00000200
  RAS_EAP_FLAG_PEAP_UPFRONT* = 0x00000400
  RAS_EAP_FLAG_ALTERNATIVE_USER_DB* = 0x00000800
  RAS_EAP_FLAG_PEAP_FORCE_FULL_AUTH* = 0x00001000
  RAS_EAP_FLAG_PRE_LOGON* = 0x00020000
  RAS_EAP_FLAG_CONFG_READONLY* = 0x00080000
  RAS_EAP_FLAG_RESERVED* = 0x00100000
  RAS_EAP_FLAG_SAVE_CREDMAN* = 0x00200000
  EAPACTION_NoAction* = 0
  EAPACTION_Authenticate* = 1
  EAPACTION_Done* = 2
  EAPACTION_SendAndDone* = 3
  EAPACTION_Send* = 4
  EAPACTION_SendWithTimeout* = 5
  EAPACTION_SendWithTimeoutInteractive* = 6
  EAPACTION_IndicateTLV* = 7
  EAPACTION_IndicateIdentity* = 8
  RASBASE* = 600
  SUCCESS* = 0
  PENDING* = RASBASE+0
  ERROR_INVALID_PORT_HANDLE* = RASBASE+1
  ERROR_PORT_ALREADY_OPEN* = RASBASE+2
  ERROR_BUFFER_TOO_SMALL* = RASBASE+3
  ERROR_WRONG_INFO_SPECIFIED* = RASBASE+4
  ERROR_PORT_NOT_CONNECTED* = RASBASE+6
  ERROR_DEVICE_DOES_NOT_EXIST* = RASBASE+8
  ERROR_DEVICETYPE_DOES_NOT_EXIST* = RASBASE+9
  ERROR_BUFFER_INVALID* = RASBASE+10
  ERROR_ROUTE_NOT_ALLOCATED* = RASBASE+12
  ERROR_PORT_NOT_FOUND* = RASBASE+15
  ERROR_ASYNC_REQUEST_PENDING* = RASBASE+16
  ERROR_ALREADY_DISCONNECTING* = RASBASE+17
  ERROR_PORT_NOT_OPEN* = RASBASE+18
  ERROR_PORT_DISCONNECTED* = RASBASE+19
  ERROR_CANNOT_OPEN_PHONEBOOK* = RASBASE+21
  ERROR_CANNOT_LOAD_PHONEBOOK* = RASBASE+22
  ERROR_CANNOT_FIND_PHONEBOOK_ENTRY* = RASBASE+23
  ERROR_CANNOT_WRITE_PHONEBOOK* = RASBASE+24
  ERROR_CORRUPT_PHONEBOOK* = RASBASE+25
  ERROR_KEY_NOT_FOUND* = RASBASE+27
  ERROR_DISCONNECTION* = RASBASE+28
  ERROR_REMOTE_DISCONNECTION* = RASBASE+29
  ERROR_HARDWARE_FAILURE* = RASBASE+30
  ERROR_USER_DISCONNECTION* = RASBASE+31
  ERROR_INVALID_SIZE* = RASBASE+32
  ERROR_PORT_NOT_AVAILABLE* = RASBASE+33
  ERROR_UNKNOWN* = RASBASE+35
  ERROR_WRONG_DEVICE_ATTACHED* = RASBASE+36
  ERROR_REQUEST_TIMEOUT* = RASBASE+38
  ERROR_AUTH_INTERNAL* = RASBASE+45
  ERROR_RESTRICTED_LOGON_HOURS* = RASBASE+46
  ERROR_ACCT_DISABLED* = RASBASE+47
  ERROR_PASSWD_EXPIRED* = RASBASE+48
  ERROR_NO_DIALIN_PERMISSION* = RASBASE+49
  ERROR_FROM_DEVICE* = RASBASE+51
  ERROR_UNRECOGNIZED_RESPONSE* = RASBASE+52
  ERROR_MACRO_NOT_FOUND* = RASBASE+53
  ERROR_MACRO_NOT_DEFINED* = RASBASE+54
  ERROR_MESSAGE_MACRO_NOT_FOUND* = RASBASE+55
  ERROR_DEFAULTOFF_MACRO_NOT_FOUND* = RASBASE+56
  ERROR_FILE_COULD_NOT_BE_OPENED* = RASBASE+57
  ERROR_DEVICENAME_TOO_LONG* = RASBASE+58
  ERROR_DEVICENAME_NOT_FOUND* = RASBASE+59
  ERROR_NO_RESPONSES* = RASBASE+60
  ERROR_NO_COMMAND_FOUND* = RASBASE+61
  ERROR_WRONG_KEY_SPECIFIED* = RASBASE+62
  ERROR_UNKNOWN_DEVICE_TYPE* = RASBASE+63
  ERROR_ALLOCATING_MEMORY* = RASBASE+64
  ERROR_PORT_NOT_CONFIGURED* = RASBASE+65
  ERROR_DEVICE_NOT_READY* = RASBASE+66
  ERROR_READING_INI_FILE* = RASBASE+67
  ERROR_NO_CONNECTION* = RASBASE+68
  ERROR_BAD_USAGE_IN_INI_FILE* = RASBASE+69
  ERROR_READING_SECTIONNAME* = RASBASE+70
  ERROR_READING_DEVICETYPE* = RASBASE+71
  ERROR_READING_DEVICENAME* = RASBASE+72
  ERROR_READING_USAGE* = RASBASE+73
  ERROR_LINE_BUSY* = RASBASE+76
  ERROR_VOICE_ANSWER* = RASBASE+77
  ERROR_NO_ANSWER* = RASBASE+78
  ERROR_NO_CARRIER* = RASBASE+79
  ERROR_NO_DIALTONE* = RASBASE+80
  ERROR_AUTHENTICATION_FAILURE* = RASBASE+91
  ERROR_PORT_OR_DEVICE* = RASBASE+92
  ERROR_NOT_BINARY_MACRO* = RASBASE+93
  ERROR_DCB_NOT_FOUND* = RASBASE+94
  ERROR_STATE_MACHINES_NOT_STARTED* = RASBASE+95
  ERROR_STATE_MACHINES_ALREADY_STARTED* = RASBASE+96
  ERROR_PARTIAL_RESPONSE_LOOPING* = RASBASE+97
  ERROR_UNKNOWN_RESPONSE_KEY* = RASBASE+98
  ERROR_RECV_BUF_FULL* = RASBASE+99
  ERROR_CMD_TOO_LONG* = RASBASE+100
  ERROR_UNSUPPORTED_BPS* = RASBASE+101
  ERROR_UNEXPECTED_RESPONSE* = RASBASE+102
  ERROR_INTERACTIVE_MODE* = RASBASE+103
  ERROR_BAD_CALLBACK_NUMBER* = RASBASE+104
  ERROR_INVALID_AUTH_STATE* = RASBASE+105
  ERROR_X25_DIAGNOSTIC* = RASBASE+107
  ERROR_ACCT_EXPIRED* = RASBASE+108
  ERROR_CHANGING_PASSWORD* = RASBASE+109
  ERROR_OVERRUN* = RASBASE+110
  ERROR_RASMAN_CANNOT_INITIALIZE* = RASBASE+111
  ERROR_NO_ACTIVE_ISDN_LINES* = RASBASE+113
  ERROR_IP_CONFIGURATION* = RASBASE+116
  ERROR_NO_IP_ADDRESSES* = RASBASE+117
  ERROR_PPP_TIMEOUT* = RASBASE+118
  ERROR_PPP_NO_PROTOCOLS_CONFIGURED* = RASBASE+120
  ERROR_PPP_NO_RESPONSE* = RASBASE+121
  ERROR_PPP_INVALID_PACKET* = RASBASE+122
  ERROR_PHONE_NUMBER_TOO_LONG* = RASBASE+123
  ERROR_IPXCP_DIALOUT_ALREADY_ACTIVE* = RASBASE+126
  ERROR_NO_IP_RAS_ADAPTER* = RASBASE+128
  ERROR_SLIP_REQUIRES_IP* = RASBASE+129
  ERROR_PROTOCOL_NOT_CONFIGURED* = RASBASE+131
  ERROR_PPP_NOT_CONVERGING* = RASBASE+132
  ERROR_PPP_CP_REJECTED* = RASBASE+133
  ERROR_PPP_LCP_TERMINATED* = RASBASE+134
  ERROR_PPP_REQUIRED_ADDRESS_REJECTED* = RASBASE+135
  ERROR_PPP_NCP_TERMINATED* = RASBASE+136
  ERROR_PPP_LOOPBACK_DETECTED* = RASBASE+137
  ERROR_PPP_NO_ADDRESS_ASSIGNED* = RASBASE+138
  ERROR_CANNOT_USE_LOGON_CREDENTIALS* = RASBASE+139
  ERROR_TAPI_CONFIGURATION* = RASBASE+140
  ERROR_NO_LOCAL_ENCRYPTION* = RASBASE+141
  ERROR_NO_REMOTE_ENCRYPTION* = RASBASE+142
  ERROR_BAD_PHONE_NUMBER* = RASBASE+149
  ERROR_SCRIPT_SYNTAX* = RASBASE+152
  ERROR_HANGUP_FAILED* = RASBASE+153
  ERROR_BUNDLE_NOT_FOUND* = RASBASE+154
  ERROR_CANNOT_DO_CUSTOMDIAL* = RASBASE+155
  ERROR_DIAL_ALREADY_IN_PROGRESS* = RASBASE+156
  ERROR_RASAUTO_CANNOT_INITIALIZE* = RASBASE+157
  ERROR_NO_SMART_CARD_READER* = RASBASE+164
  ERROR_SHARING_ADDRESS_EXISTS* = RASBASE+165
  ERROR_NO_CERTIFICATE* = RASBASE+166
  ERROR_SHARING_MULTIPLE_ADDRESSES* = RASBASE+167
  ERROR_FAILED_TO_ENCRYPT* = RASBASE+168
  ERROR_BAD_ADDRESS_SPECIFIED* = RASBASE+169
  ERROR_CONNECTION_REJECT* = RASBASE+170
  ERROR_CONGESTION* = RASBASE+171
  ERROR_INCOMPATIBLE* = RASBASE+172
  ERROR_NUMBERCHANGED* = RASBASE+173
  ERROR_TEMPFAILURE* = RASBASE+174
  ERROR_BLOCKED* = RASBASE+175
  ERROR_DONOTDISTURB* = RASBASE+176
  ERROR_OUTOFORDER* = RASBASE+177
  ERROR_UNABLE_TO_AUTHENTICATE_SERVER* = RASBASE+178
  ERROR_INVALID_FUNCTION_FOR_ENTRY* = RASBASE+180
  ERROR_SHARING_RRAS_CONFLICT* = RASBASE+182
  ERROR_SHARING_NO_PRIVATE_LAN* = RASBASE+183
  ERROR_NO_DIFF_USER_AT_LOGON* = RASBASE+184
  ERROR_NO_REG_CERT_AT_LOGON* = RASBASE+185
  ERROR_OAKLEY_NO_CERT* = RASBASE+186
  ERROR_OAKLEY_AUTH_FAIL* = RASBASE+187
  ERROR_OAKLEY_ATTRIB_FAIL* = RASBASE+188
  ERROR_OAKLEY_GENERAL_PROCESSING* = RASBASE+189
  ERROR_OAKLEY_NO_PEER_CERT* = RASBASE+190
  ERROR_OAKLEY_NO_POLICY* = RASBASE+191
  ERROR_OAKLEY_TIMED_OUT* = RASBASE+192
  ERROR_OAKLEY_ERROR* = RASBASE+193
  ERROR_UNKNOWN_FRAMED_PROTOCOL* = RASBASE+194
  ERROR_WRONG_TUNNEL_TYPE* = RASBASE+195
  ERROR_UNKNOWN_SERVICE_TYPE* = RASBASE+196
  ERROR_CONNECTING_DEVICE_NOT_FOUND* = RASBASE+197
  ERROR_NO_EAPTLS_CERTIFICATE* = RASBASE+198
  ERROR_SHARING_HOST_ADDRESS_CONFLICT* = RASBASE+199
  ERROR_AUTOMATIC_VPN_FAILED* = RASBASE+200
  ERROR_VALIDATING_SERVER_CERT* = RASBASE+201
  ERROR_READING_SCARD* = RASBASE+202
  ERROR_INVALID_PEAP_COOKIE_CONFIG* = RASBASE+203
  ERROR_INVALID_PEAP_COOKIE_USER* = RASBASE+204
  ERROR_INVALID_MSCHAPV2_CONFIG* = RASBASE+205
  ERROR_VPN_GRE_BLOCKED* = RASBASE+206
  ERROR_VPN_DISCONNECT* = RASBASE+207
  ERROR_VPN_REFUSED* = RASBASE+208
  ERROR_VPN_TIMEOUT* = RASBASE+209
  ERROR_VPN_BAD_CERT* = RASBASE+210
  ERROR_VPN_BAD_PSK* = RASBASE+211
  ERROR_SERVER_POLICY* = RASBASE+212
  ERROR_BROADBAND_ACTIVE* = RASBASE+213
  ERROR_BROADBAND_NO_NIC* = RASBASE+214
  ERROR_BROADBAND_TIMEOUT* = RASBASE+215
  ERROR_FEATURE_DEPRECATED* = RASBASE+216
  ERROR_CANNOT_DELETE* = RASBASE+217
  ERROR_PEAP_CRYPTOBINDING_INVALID* = RASBASE+223
  ERROR_PEAP_CRYPTOBINDING_NOTRECEIVED* = RASBASE+224
  ERROR_EAPTLS_CACHE_CREDENTIALS_INVALID* = RASBASE+226
  ERROR_IPSEC_SERVICE_STOPPED* = RASBASE+227
  ERROR_CANNOT_SET_PORT_INFO* = RASBASE+5
  ERROR_EVENT_INVALID* = RASBASE+7
  ERROR_ROUTE_NOT_AVAILABLE* = RASBASE+11
  ERROR_INVALID_COMPRESSION_SPECIFIED* = RASBASE+13
  ERROR_OUT_OF_BUFFERS* = RASBASE+14
  ERROR_NO_ENDPOINTS* = RASBASE+20
  ERROR_CANNOT_LOAD_STRING* = RASBASE+26
  ERROR_CANNOT_PROJECT_CLIENT* = RASBASE+34
  ERROR_BAD_STRING* = RASBASE+37
  ERROR_CANNOT_GET_LANA* = RASBASE+39
  ERROR_NETBIOS_ERROR* = RASBASE+40
  ERROR_SERVER_OUT_OF_RESOURCES* = RASBASE+41
  ERROR_NAME_EXISTS_ON_NET* = RASBASE+42
  ERROR_SERVER_GENERAL_NET_FAILURE* = RASBASE+43
  WARNING_MSG_ALIAS_NOT_ADDED* = RASBASE+44
  ERROR_SERVER_NOT_RESPONDING* = RASBASE+50
  ERROR_READING_MAXCONNECTBPS* = RASBASE+74
  ERROR_READING_MAXCARRIERBPS* = RASBASE+75
  ERROR_IN_COMMAND* = RASBASE+81
  ERROR_WRITING_SECTIONNAME* = RASBASE+82
  ERROR_WRITING_DEVICETYPE* = RASBASE+83
  ERROR_WRITING_DEVICENAME* = RASBASE+84
  ERROR_WRITING_MAXCONNECTBPS* = RASBASE+85
  ERROR_WRITING_MAXCARRIERBPS* = RASBASE+86
  ERROR_WRITING_USAGE* = RASBASE+87
  ERROR_WRITING_DEFAULTOFF* = RASBASE+88
  ERROR_READING_DEFAULTOFF* = RASBASE+89
  ERROR_EMPTY_INI_FILE* = RASBASE+90
  ERROR_WRITING_INITBPS* = RASBASE+106
  ERROR_BIPLEX_PORT_NOT_AVAILABLE* = RASBASE+112
  ERROR_NO_ISDN_CHANNELS_AVAILABLE* = RASBASE+114
  ERROR_TOO_MANY_LINE_ERRORS* = RASBASE+115
  ERROR_PPP_REMOTE_TERMINATED* = RASBASE+119
  ERROR_IPXCP_NO_DIALOUT_CONFIGURED* = RASBASE+124
  ERROR_IPXCP_NO_DIALIN_CONFIGURED* = RASBASE+125
  ERROR_ACCESSING_TCPCFGDLL* = RASBASE+127
  ERROR_PROJECTION_NOT_COMPLETE* = RASBASE+130
  ERROR_REMOTE_REQUIRES_ENCRYPTION* = RASBASE+143
  ERROR_IPXCP_NET_NUMBER_CONFLICT* = RASBASE+144
  ERROR_INVALID_SMM* = RASBASE+145
  ERROR_SMM_UNINITIALIZED* = RASBASE+146
  ERROR_NO_MAC_FOR_PORT* = RASBASE+147
  ERROR_SMM_TIMEOUT* = RASBASE+148
  ERROR_WRONG_MODULE* = RASBASE+150
  ERROR_INVALID_CALLBACK_NUMBER* = RASBASE+151
  ERROR_CONNECTION_ALREADY_SHARED* = RASBASE+158
  ERROR_SHARING_CHANGE_FAILED* = RASBASE+159
  ERROR_SHARING_ROUTER_INSTALL* = RASBASE+160
  ERROR_SHARE_CONNECTION_FAILED* = RASBASE+161
  ERROR_SHARING_PRIVATE_INSTALL* = RASBASE+162
  ERROR_CANNOT_SHARE_CONNECTION* = RASBASE+163
  ERROR_SMART_CARD_REQUIRED* = RASBASE+179
  ERROR_CERT_FOR_ENCRYPTION_NOT_FOUND* = RASBASE+181
  ERROR_RASQEC_RESOURCE_CREATION_FAILED* = RASBASE+218
  ERROR_RASQEC_NAPAGENT_NOT_ENABLED* = RASBASE+219
  ERROR_RASQEC_NAPAGENT_NOT_CONNECTED* = RASBASE+220
  ERROR_RASQEC_CONN_DOESNOTEXIST* = RASBASE+221
  ERROR_RASQEC_TIMEOUT* = RASBASE+222
  ERROR_INVALID_VPNSTRATEGY* = RASBASE+225
  ERROR_IDLE_TIMEOUT* = RASBASE+228
  ERROR_LINK_FAILURE* = RASBASE+229
  ERROR_USER_LOGOFF* = RASBASE+230
  ERROR_FAST_USER_SWITCH* = RASBASE+231
  ERROR_HIBERNATION* = RASBASE+232
  ERROR_SYSTEM_SUSPENDED* = RASBASE+233
  ERROR_RASMAN_SERVICE_STOPPED* = RASBASE+234
  ERROR_INVALID_SERVER_CERT* = RASBASE+235
  ERROR_NOT_NAP_CAPABLE* = RASBASE+236
  ERROR_INVALID_TUNNELID* = RASBASE+237
  ERROR_UPDATECONNECTION_REQUEST_IN_PROCESS* = RASBASE+238
  ERROR_PROTOCOL_ENGINE_DISABLED* = RASBASE+239
  ERROR_INTERNAL_ADDRESS_FAILURE* = RASBASE+240
  ERROR_FAILED_CP_REQUIRED* = RASBASE+241
  ERROR_TS_UNACCEPTABLE* = RASBASE+242
  ERROR_MOBIKE_DISABLED* = RASBASE+243
  ERROR_CANNOT_INITIATE_MOBIKE_UPDATE* = RASBASE+244
  ERROR_PEAP_SERVER_REJECTED_CLIENT_TLV* = RASBASE+245
  ERROR_INVALID_PREFERENCES* = RASBASE+246
  ERROR_EAPTLS_SCARD_CACHE_CREDENTIALS_INVALID* = RASBASE+247
  ERROR_SSTP_COOKIE_SET_FAILURE* = RASBASE+248
  ERROR_INVALID_PEAP_COOKIE_ATTRIBUTES* = RASBASE+249
  ERROR_EAP_METHOD_NOT_INSTALLED* = RASBASE+250
  ERROR_EAP_METHOD_DOES_NOT_SUPPORT_SSO* = RASBASE+251
  ERROR_EAP_METHOD_OPERATION_NOT_SUPPORTED* = RASBASE+252
  ERROR_EAP_USER_CERT_INVALID* = RASBASE+253
  ERROR_EAP_USER_CERT_EXPIRED* = RASBASE+254
  ERROR_EAP_USER_CERT_REVOKED* = RASBASE+255
  ERROR_EAP_USER_CERT_OTHER_ERROR* = RASBASE+256
  ERROR_EAP_SERVER_CERT_INVALID* = RASBASE+257
  ERROR_EAP_SERVER_CERT_EXPIRED* = RASBASE+258
  ERROR_EAP_SERVER_CERT_REVOKED* = RASBASE+259
  ERROR_EAP_SERVER_CERT_OTHER_ERROR* = RASBASE+260
  ERROR_EAP_USER_ROOT_CERT_NOT_FOUND* = RASBASE+261
  ERROR_EAP_USER_ROOT_CERT_INVALID* = RASBASE+262
  ERROR_EAP_USER_ROOT_CERT_EXPIRED* = RASBASE+263
  ERROR_EAP_SERVER_ROOT_CERT_NOT_FOUND* = RASBASE+264
  ERROR_EAP_SERVER_ROOT_CERT_INVALID* = RASBASE+265
  ERROR_EAP_SERVER_ROOT_CERT_NAME_REQUIRED* = RASBASE+266
  ERROR_PEAP_IDENTITY_MISMATCH* = RASBASE+267
  ERROR_DNSNAME_NOT_RESOLVABLE* = RASBASE+268
  ERROR_EAPTLS_PASSWD_INVALID* = RASBASE+269
  ERROR_IKEV2_PSK_INTERFACE_ALREADY_EXISTS* = RASBASE+270
  RASBASEEND* = RASBASE+270
  RASSAPI_MAX_PHONENUMBER_SIZE* = 128
  RASSAPI_MAX_MEDIA_NAME* = 16
  RASSAPI_MAX_PORT_NAME* = 16
  RASSAPI_MAX_DEVICE_NAME* = 128
  RASSAPI_MAX_DEVICETYPE_NAME* = 16
  RASSAPI_MAX_PARAM_KEY_SIZE* = 32
  RASPRIV_NoCallback* = 0x01
  RASPRIV_AdminSetCallback* = 0x02
  RASPRIV_CallerSetCallback* = 0x04
  RASPRIV_DialinPrivilege* = 0x08
  RASPRIV_CallbackType* = RASPRIV_AdminSetCallback or RASPRIV_CallerSetCallback or RASPRIV_NoCallback
  RAS_MODEM_OPERATIONAL* = 1
  RAS_MODEM_NOT_RESPONDING* = 2
  RAS_MODEM_HARDWARE_FAILURE* = 3
  RAS_MODEM_INCORRECT_RESPONSE* = 4
  RAS_MODEM_UNKNOWN* = 5
  paramNumber* = 0
  paramString* = 1
  MEDIA_UNKNOWN* = 0
  MEDIA_SERIAL* = 1
  MEDIA_RAS10_SERIAL* = 2
  MEDIA_X25* = 3
  MEDIA_ISDN* = 4
  USER_AUTHENTICATED* = 0x0001
  MESSENGER_PRESENT* = 0x0002
  PPP_CLIENT* = 0x0004
  GATEWAY_ACTIVE* = 0x0008
  REMOTE_LISTEN* = 0x0010
  PORT_MULTILINKED* = 0x0020
  RAS_IPADDRESSLEN* = 15
  RAS_IPXADDRESSLEN* = 22
  RAS_ATADDRESSLEN* = 32
  RASDOWNLEVEL* = 10
  RASADMIN_35* = 35
  RASADMIN_CURRENT* = 40
  RRAS_SERVICE_NAME* = "RemoteAccess"
  PID_IPX* = 0x0000002B
  PID_IP* = 0x00000021
  PID_NBF* = 0x0000003F
  PID_ATALK* = 0x00000029
  ROUTER_IF_TYPE_CLIENT* = 0
  ROUTER_IF_TYPE_HOME_ROUTER* = 1
  ROUTER_IF_TYPE_FULL_ROUTER* = 2
  ROUTER_IF_TYPE_DEDICATED* = 3
  ROUTER_IF_TYPE_INTERNAL* = 4
  ROUTER_IF_TYPE_LOOPBACK* = 5
  ROUTER_IF_TYPE_TUNNEL1* = 6
  ROUTER_IF_TYPE_DIALOUT* = 7
  ROUTER_IF_STATE_UNREACHABLE* = 0
  ROUTER_IF_STATE_DISCONNECTED* = 1
  ROUTER_IF_STATE_CONNECTING* = 2
  ROUTER_IF_STATE_CONNECTED* = 3
  MPR_INTERFACE_OUT_OF_RESOURCES* = 0x00000001
  MPR_INTERFACE_ADMIN_DISABLED* = 0x00000002
  MPR_INTERFACE_CONNECTION_FAILURE* = 0x00000004
  MPR_INTERFACE_SERVICE_PAUSED* = 0x00000008
  MPR_INTERFACE_DIALOUT_HOURS_RESTRICTION* = 0x00000010
  MPR_INTERFACE_NO_MEDIA_SENSE* = 0x00000020
  MPR_INTERFACE_NO_DEVICE* = 0x00000040
  MPR_MaxIpAddress* = RAS_MaxIpAddress
  MPR_MaxIpxAddress* = RAS_MaxIpxAddress
  MPR_MaxEntryName* = RAS_MaxEntryName
  MPR_MaxCallbackNumber* = RAS_MaxCallbackNumber
  MPR_MaxAreaCode* = RAS_MaxAreaCode
  MPRIO_SpecificIpAddr* = RASEO_SpecificIpAddr
  MPRIO_SpecificNameServers* = RASEO_SpecificNameServers
  MPRIO_IpHeaderCompression* = RASEO_IpHeaderCompression
  MPRIO_RemoteDefaultGateway* = RASEO_RemoteDefaultGateway
  MPRIO_DisableLcpExtensions* = RASEO_DisableLcpExtensions
  MPRIO_SwCompression* = RASEO_SwCompression
  MPRIO_RequireEncryptedPw* = RASEO_RequireEncryptedPw
  MPRIO_RequireMsEncryptedPw* = RASEO_RequireMsEncryptedPw
  MPRIO_RequireDataEncryption* = RASEO_RequireDataEncryption
  MPRIO_NetworkLogon* = RASEO_NetworkLogon
  MPRIO_PromoteAlternates* = RASEO_PromoteAlternates
  MPRIO_SecureLocalFiles* = RASEO_SecureLocalFiles
  MPRIO_RequireEAP* = RASEO_RequireEAP
  MPRIO_RequirePAP* = RASEO_RequirePAP
  MPRIO_RequireSPAP* = RASEO_RequireSPAP
  MPRIO_SharedPhoneNumbers* = RASEO_SharedPhoneNumbers
  MPRIO_RequireCHAP* = RASEO_RequireCHAP
  MPRIO_RequireMsCHAP* = RASEO_RequireMsCHAP
  MPRIO_RequireMsCHAP2* = RASEO_RequireMsCHAP2
  MPRIO_IpSecPreSharedKey* = 0x80000000'i32
  MPRNP_Ipx* = RASNP_Ipx
  MPRNP_Ip* = RASNP_Ip
  MPRDT_Modem* = RASDT_Modem
  MPRDT_Isdn* = RASDT_Isdn
  MPRDT_X25* = RASDT_X25
  MPRDT_Vpn* = RASDT_Vpn
  MPRDT_Pad* = RASDT_Pad
  MPRDT_Generic* = RASDT_Generic
  MPRDT_Serial* = RASDT_Serial
  MPRDT_FrameRelay* = RASDT_FrameRelay
  MPRDT_Atm* = RASDT_Atm
  MPRDT_Sonet* = RASDT_Sonet
  MPRDT_SW56* = RASDT_SW56
  MPRDT_Irda* = RASDT_Irda
  MPRDT_Parallel* = RASDT_Parallel
  MPRET_Phone* = RASET_Phone
  MPRET_Vpn* = RASET_Vpn
  MPRET_Direct* = RASET_Direct
  MPRDM_DialFirst* = 0
  MPRDM_DialAll* = RASEDM_DialAll
  MPRDM_DialAsNeeded* = RASEDM_DialAsNeeded
  MPRIDS_Disabled* = RASIDS_Disabled
  MPRIDS_UseGlobalValue* = RASIDS_UseGlobalValue
  MPR_ET_None* = ET_None
  MPR_ET_Require* = ET_Require
  MPR_ET_RequireMax* = ET_RequireMax
  MPR_ET_Optional* = ET_Optional
  MPR_VS_Default* = VS_Default
  MPR_VS_PptpOnly* = VS_PptpOnly
  MPR_VS_PptpFirst* = VS_PptpFirst
  MPR_VS_L2tpOnly* = VS_L2tpOnly
  MPR_VS_L2tpFirst* = VS_L2tpFirst
  MPR_ENABLE_RAS_ON_DEVICE* = 0x00000001
  MPR_ENABLE_ROUTING_ON_DEVICE* = 0x00000002
  RAS_PORT_NON_OPERATIONAL* = 0
  RAS_PORT_DISCONNECTED* = 1
  RAS_PORT_CALLING_BACK* = 2
  RAS_PORT_LISTENING* = 3
  RAS_PORT_AUTHENTICATING* = 4
  RAS_PORT_AUTHENTICATED* = 5
  RAS_PORT_INITIALIZING* = 6
  RAS_HARDWARE_OPERATIONAL* = 0
  RAS_HARDWARE_FAILURE* = 1
  PPP_IPCP_VJ* = 0x00000001
  PPP_CCP_COMPRESSION* = 0x00000001
  PPP_CCP_ENCRYPTION40BITOLD* = 0x00000010
  PPP_CCP_ENCRYPTION40BIT* = 0x00000020
  PPP_CCP_ENCRYPTION128BIT* = 0x00000040
  PPP_CCP_ENCRYPTION56BIT* = 0x00000080
  PPP_CCP_HISTORYLESS* = 0x01000000
  PPP_LCP_PAP* = 0xC023
  PPP_LCP_SPAP* = 0xC027
  PPP_LCP_CHAP* = 0xC223
  PPP_LCP_EAP* = 0xC227
  PPP_LCP_CHAP_MD5* = 0x05
  PPP_LCP_CHAP_MS* = 0x80
  PPP_LCP_CHAP_MSV2* = 0x81
  PPP_LCP_MULTILINK_FRAMING* = 0x00000001
  PPP_LCP_PFC* = 0x00000002
  PPP_LCP_ACFC* = 0x00000004
  PPP_LCP_SSHF* = 0x00000008
  PPP_LCP_DES_56* = 0x00000010
  PPP_LCP_3_DES* = 0x00000020
  RAS_FLAGS_PPP_CONNECTION* = 0x00000001
  RAS_FLAGS_MESSENGER_PRESENT* = 0x00000002
  RAS_FLAGS_QUARANTINE_PRESENT* = 0x00000008
  RASPRIV2_DialinPolicy* = 0x1
  RAS_QUAR_STATE_NORMAL* = 0
  RAS_QUAR_STATE_QUARANTINE* = 1
  RAS_QUAR_STATE_PROBATION* = 2
  RAS_QUAR_STATE_NOT_CAPABLE* = 3
  MPRAPI_RAS_CONNECTION_OBJECT_REVISION_1* = 0x01
  MPRAPI_MPR_SERVER_OBJECT_REVISION_1* = 0x01
  MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_1* = 0x01
  MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT* = 0x1
  MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT* = 0x2
  MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT* = 0x3
  MPRAPI_OBJECT_TYPE_AUTH_VALIDATION_OBJECT* = 0x4
  MPRAPI_OBJECT_TYPE_UPDATE_CONNECTION_OBJECT* = 0x5
  RAS_FLAGS_ARAP_CONNECTION* = 0x00000010
  RAS_FLAGS_IKEV2_CONNECTION* = 0x00000010
  RAS_FLAGS_DORMANT* = 0x00000020
  MPRAPI_IKEV2_SET_TUNNEL_CONFIG_PARAMS* = 0x01
  SECURITYMSG_SUCCESS* = 1
  SECURITYMSG_FAILURE* = 2
  SECURITYMSG_ERROR* = 3
  PPP_EAP_PACKET_HDR_LEN* = 4
type
  RASDIALFUNC* = proc (P1: UINT, P2: RASCONNSTATE, P3: DWORD): VOID {.stdcall.}
  RASDIALFUNC1* = proc (P1: HRASCONN, P2: UINT, P3: RASCONNSTATE, P4: DWORD, P5: DWORD): VOID {.stdcall.}
  RASDIALFUNC2* = proc (P1: ULONG_PTR, P2: DWORD, P3: HRASCONN, P4: UINT, P5: RASCONNSTATE, P6: DWORD, P7: DWORD): DWORD {.stdcall.}
  ORASADFUNC* = proc (P1: HWND, P2: LPSTR, P3: DWORD, P4: LPDWORD): WINBOOL {.stdcall.}
  RASADFUNCA* = proc (P1: LPSTR, P2: LPSTR, P3: LPRASADPARAMS, P4: LPDWORD): WINBOOL {.stdcall.}
  RASADFUNCW* = proc (P1: LPWSTR, P2: LPWSTR, P3: LPRASADPARAMS, P4: LPDWORD): WINBOOL {.stdcall.}
  PFNRASGETBUFFER* = proc (ppBuffer: ptr PBYTE, pdwSize: PDWORD): DWORD {.stdcall.}
  PFNRASFREEBUFFER* = proc (pBufer: PBYTE): DWORD {.stdcall.}
  PFNRASSENDBUFFER* = proc (hPort: HANDLE, pBuffer: PBYTE, dwSize: DWORD): DWORD {.stdcall.}
  PFNRASRECEIVEBUFFER* = proc (hPort: HANDLE, pBuffer: PBYTE, pdwSize: PDWORD, dwTimeOut: DWORD, hEvent: HANDLE): DWORD {.stdcall.}
  PFNRASRETRIEVEBUFFER* = proc (hPort: HANDLE, pBuffer: PBYTE, pdwSize: PDWORD): DWORD {.stdcall.}
  RasCustomScriptExecuteFn* = proc (hPort: HANDLE, lpszPhonebook: LPCWSTR, lpszEntryName: LPCWSTR, pfnRasGetBuffer: PFNRASGETBUFFER, pfnRasFreeBuffer: PFNRASFREEBUFFER, pfnRasSendBuffer: PFNRASSENDBUFFER, pfnRasReceiveBuffer: PFNRASRECEIVEBUFFER, pfnRasRetrieveBuffer: PFNRASRETRIEVEBUFFER, hWnd: HWND, pRasDialParams: ptr RASDIALPARAMS, pvReserved: PVOID): DWORD {.stdcall.}
  RASCOMMSETTINGS* {.pure.} = object
    dwSize*: DWORD
    bParity*: BYTE
    bStop*: BYTE
    bByteSize*: BYTE
    bAlign*: BYTE
  PFNRASSETCOMMSETTINGS* = proc (hPort: HANDLE, pRasCommSettings: ptr RASCOMMSETTINGS, pvReserved: PVOID): DWORD {.stdcall.}
  RasCustomHangUpFn* = proc (hRasConn: HRASCONN): DWORD {.stdcall.}
  RasCustomDialFn* = proc (hInstDll: HINSTANCE, lpRasDialExtensions: LPRASDIALEXTENSIONS, lpszPhonebook: LPCWSTR, lpRasDialParams: LPRASDIALPARAMS, dwNotifierType: DWORD, lpvNotifier: LPVOID, lphRasConn: LPHRASCONN, dwFlags: DWORD): DWORD {.stdcall.}
  RasCustomDeleteEntryNotifyFn* = proc (lpszPhonebook: LPCWSTR, lpszEntry: LPCWSTR, dwFlags: DWORD): DWORD {.stdcall.}
  RasCustomDialDlgFn* = proc (hInstDll: HINSTANCE, dwFlags: DWORD, lpszPhonebook: LPWSTR, lpszEntry: LPWSTR, lpszPhoneNumber: LPWSTR, lpInfo: LPRASDIALDLG, pvInfo: PVOID): WINBOOL {.stdcall.}
  RasCustomEntryDlgFn* = proc (hInstDll: HINSTANCE, lpszPhonebook: LPWSTR, lpszEntry: LPWSTR, lpInfo: LPRASENTRYDLG, dwFlags: DWORD): WINBOOL {.stdcall.}
  RASSECURITYPROC* = proc (): DWORD {.stdcall.}
  IsolationInfo* {.pure.} = object
    isolationState*: IsolationState
    probEndTime*: ProbationTime
    failureUrl*: CountedString
  IsolationInfoEx* {.pure.} = object
    isolationState*: IsolationState
    extendedIsolationState*: ExtendedIsolationState
    probEndTime*: ProbationTime
    failureUrl*: CountedString
  FailureCategoryMapping* {.pure.} = object
    mappingCompliance*: array[5, WINBOOL]
  CorrelationId* {.pure.} = object
    connId*: GUID
    timeStamp*: FILETIME
  ResultCodes* {.pure.} = object
    count*: UINT16
    results*: ptr HRESULT
  Ipv4Address* {.pure.} = object
    `addr`*: array[4, BYTE]
  Ipv6Address* {.pure.} = object
    `addr`*: array[16, BYTE]
  FixupInfo* {.pure.} = object
    state*: FixupState
    percentage*: Percentage
    resultCodes*: ResultCodes
    fixupMsgId*: MessageId
  SystemHealthAgentState* {.pure.} = object
    id*: SystemHealthEntityId
    shaResultCodes*: ResultCodes
    failureCategory*: FailureCategory
    fixupInfo*: FixupInfo
  PrivateData* {.pure.} = object
    size*: UINT16
    data*: ptr BYTE
  NapComponentRegistrationInfo* {.pure.} = object
    id*: NapComponentId
    friendlyName*: CountedString
    description*: CountedString
    version*: CountedString
    vendorName*: CountedString
    infoClsid*: CLSID
    configClsid*: CLSID
    registrationDate*: FILETIME
    componentType*: UINT32
  RASCUSTOMSCRIPTEXTENSIONS* {.pure, packed.} = object
    dwSize*: DWORD
    pfnRasSetCommSettings*: PFNRASSETCOMMSETTINGS
  LEGACY_IDENTITY_UI_PARAMS* {.pure.} = object
    eapType*: DWORD
    dwFlags*: DWORD
    dwSizeofConnectionData*: DWORD
    pConnectionData*: ptr BYTE
    dwSizeofUserData*: DWORD
    pUserData*: ptr BYTE
    dwSizeofUserDataOut*: DWORD
    pUserDataOut*: ptr BYTE
    pwszIdentity*: LPWSTR
    dwError*: DWORD
  LEGACY_INTERACTIVE_UI_PARAMS* {.pure.} = object
    eapType*: DWORD
    dwSizeofContextData*: DWORD
    pContextData*: ptr BYTE
    dwSizeofInteractiveUIData*: DWORD
    pInteractiveUIData*: ptr BYTE
    dwError*: DWORD
  RAS_PARAMS_VALUE_String* {.pure.} = object
    Length*: DWORD
    Data*: PCHAR
  RAS_PARAMS_VALUE* {.pure, union.} = object
    Number*: DWORD
    String*: RAS_PARAMS_VALUE_String
  RAS_PARAMETERS* {.pure.} = object
    P_Key*: array[RASSAPI_MAX_PARAM_KEY_SIZE, CHAR]
    P_Type*: RAS_PARAMS_FORMAT
    P_Attributes*: BYTE
    P_Value*: RAS_PARAMS_VALUE
  RAS_PPP_NBFCP_RESULT* {.pure.} = object
    dwError*: DWORD
    dwNetBiosError*: DWORD
    szName*: array[NETBIOS_NAME_LEN + 1, CHAR]
    wszWksta*: array[NETBIOS_NAME_LEN + 1, WCHAR]
  RAS_PPP_IPCP_RESULT* {.pure.} = object
    dwError*: DWORD
    wszAddress*: array[RAS_IPADDRESSLEN + 1, WCHAR]
  RAS_PPP_IPXCP_RESULT* {.pure.} = object
    dwError*: DWORD
    wszAddress*: array[RAS_IPXADDRESSLEN + 1, WCHAR]
  RAS_PPP_ATCP_RESULT* {.pure.} = object
    dwError*: DWORD
    wszAddress*: array[RAS_ATADDRESSLEN + 1, WCHAR]
  RAS_PPP_PROJECTION_RESULT* {.pure.} = object
    nbf*: RAS_PPP_NBFCP_RESULT
    ip*: RAS_PPP_IPCP_RESULT
    ipx*: RAS_PPP_IPXCP_RESULT
    at*: RAS_PPP_ATCP_RESULT
proc RasDialA*(P1: LPRASDIALEXTENSIONS, P2: LPCSTR, P3: LPRASDIALPARAMSA, P4: DWORD, P5: LPVOID, P6: LPHRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasDialW*(P1: LPRASDIALEXTENSIONS, P2: LPCWSTR, P3: LPRASDIALPARAMSW, P4: DWORD, P5: LPVOID, P6: LPHRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEnumConnectionsA*(P1: LPRASCONNA, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEnumConnectionsW*(P1: LPRASCONNW, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEnumEntriesA*(P1: LPCSTR, P2: LPCSTR, P3: LPRASENTRYNAMEA, P4: LPDWORD, P5: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEnumEntriesW*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASENTRYNAMEW, P4: LPDWORD, P5: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetConnectStatusA*(P1: HRASCONN, P2: LPRASCONNSTATUSA): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetConnectStatusW*(P1: HRASCONN, P2: LPRASCONNSTATUSW): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetErrorStringA*(P1: UINT, P2: LPSTR, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetErrorStringW*(P1: UINT, P2: LPWSTR, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasHangUpA*(P1: HRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasHangUpW*(P1: HRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetProjectionInfoA*(P1: HRASCONN, P2: RASPROJECTION, P3: LPVOID, P4: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetProjectionInfoW*(P1: HRASCONN, P2: RASPROJECTION, P3: LPVOID, P4: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasCreatePhonebookEntryA*(P1: HWND, P2: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasCreatePhonebookEntryW*(P1: HWND, P2: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEditPhonebookEntryA*(P1: HWND, P2: LPCSTR, P3: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEditPhonebookEntryW*(P1: HWND, P2: LPCWSTR, P3: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetEntryDialParamsA*(P1: LPCSTR, P2: LPRASDIALPARAMSA, P3: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetEntryDialParamsW*(P1: LPCWSTR, P2: LPRASDIALPARAMSW, P3: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetEntryDialParamsA*(P1: LPCSTR, P2: LPRASDIALPARAMSA, P3: LPBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetEntryDialParamsW*(P1: LPCWSTR, P2: LPRASDIALPARAMSW, P3: LPBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEnumDevicesA*(P1: LPRASDEVINFOA, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEnumDevicesW*(P1: LPRASDEVINFOW, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetCountryInfoA*(P1: LPRASCTRYINFOA, P2: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetCountryInfoW*(P1: LPRASCTRYINFOW, P2: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetEntryPropertiesA*(P1: LPCSTR, P2: LPCSTR, P3: LPRASENTRYA, P4: LPDWORD, P5: LPBYTE, P6: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetEntryPropertiesW*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASENTRYW, P4: LPDWORD, P5: LPBYTE, P6: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetEntryPropertiesA*(P1: LPCSTR, P2: LPCSTR, P3: LPRASENTRYA, P4: DWORD, P5: LPBYTE, P6: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetEntryPropertiesW*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASENTRYW, P4: DWORD, P5: LPBYTE, P6: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasRenameEntryA*(P1: LPCSTR, P2: LPCSTR, P3: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasRenameEntryW*(P1: LPCWSTR, P2: LPCWSTR, P3: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasDeleteEntryA*(P1: LPCSTR, P2: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasDeleteEntryW*(P1: LPCWSTR, P2: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasValidateEntryNameA*(P1: LPCSTR, P2: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasValidateEntryNameW*(P1: LPCWSTR, P2: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasConnectionNotificationA*(P1: HRASCONN, P2: HANDLE, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasConnectionNotificationW*(P1: HRASCONN, P2: HANDLE, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetSubEntryHandleA*(P1: HRASCONN, P2: DWORD, P3: LPHRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetSubEntryHandleW*(P1: HRASCONN, P2: DWORD, P3: LPHRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetCredentialsA*(P1: LPCSTR, P2: LPCSTR, P3: LPRASCREDENTIALSA): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetCredentialsW*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASCREDENTIALSW): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetCredentialsA*(P1: LPCSTR, P2: LPCSTR, P3: LPRASCREDENTIALSA, P4: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetCredentialsW*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASCREDENTIALSW, P4: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetSubEntryPropertiesA*(P1: LPCSTR, P2: LPCSTR, P3: DWORD, P4: LPRASSUBENTRYA, P5: LPDWORD, P6: LPBYTE, P7: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetSubEntryPropertiesW*(P1: LPCWSTR, P2: LPCWSTR, P3: DWORD, P4: LPRASSUBENTRYW, P5: LPDWORD, P6: LPBYTE, P7: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetSubEntryPropertiesA*(P1: LPCSTR, P2: LPCSTR, P3: DWORD, P4: LPRASSUBENTRYA, P5: DWORD, P6: LPBYTE, P7: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetSubEntryPropertiesW*(P1: LPCWSTR, P2: LPCWSTR, P3: DWORD, P4: LPRASSUBENTRYW, P5: DWORD, P6: LPBYTE, P7: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetAutodialAddressA*(P1: LPCSTR, P2: LPDWORD, P3: LPRASAUTODIALENTRYA, P4: LPDWORD, P5: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetAutodialAddressW*(P1: LPCWSTR, P2: LPDWORD, P3: LPRASAUTODIALENTRYW, P4: LPDWORD, P5: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetAutodialAddressA*(P1: LPCSTR, P2: DWORD, P3: LPRASAUTODIALENTRYA, P4: DWORD, P5: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetAutodialAddressW*(P1: LPCWSTR, P2: DWORD, P3: LPRASAUTODIALENTRYW, P4: DWORD, P5: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEnumAutodialAddressesA*(P1: ptr LPSTR, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasEnumAutodialAddressesW*(P1: ptr LPWSTR, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetAutodialEnableA*(P1: DWORD, P2: LPBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetAutodialEnableW*(P1: DWORD, P2: LPBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetAutodialEnableA*(P1: DWORD, P2: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetAutodialEnableW*(P1: DWORD, P2: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetAutodialParamA*(P1: DWORD, P2: LPVOID, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetAutodialParamW*(P1: DWORD, P2: LPVOID, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetAutodialParamA*(P1: DWORD, P2: LPVOID, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetAutodialParamW*(P1: DWORD, P2: LPVOID, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasInvokeEapUI*(P1: HRASCONN, P2: DWORD, P3: LPRASDIALEXTENSIONS, P4: HWND): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetLinkStatistics*(hRasConn: HRASCONN, dwSubEntry: DWORD, lpStatistics: ptr RAS_STATS): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetConnectionStatistics*(hRasConn: HRASCONN, lpStatistics: ptr RAS_STATS): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasClearLinkStatistics*(hRasConn: HRASCONN, dwSubEntry: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasClearConnectionStatistics*(hRasConn: HRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetEapUserDataA*(hToken: HANDLE, pszPhonebook: LPCSTR, pszEntry: LPCSTR, pbEapData: ptr BYTE, pdwSizeofEapData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetEapUserDataW*(hToken: HANDLE, pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, pbEapData: ptr BYTE, pdwSizeofEapData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetEapUserDataA*(hToken: HANDLE, pszPhonebook: LPCSTR, pszEntry: LPCSTR, pbEapData: ptr BYTE, dwSizeofEapData: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetEapUserDataW*(hToken: HANDLE, pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, pbEapData: ptr BYTE, dwSizeofEapData: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetCustomAuthDataA*(pszPhonebook: LPCSTR, pszEntry: LPCSTR, pbCustomAuthData: ptr BYTE, pdwSizeofCustomAuthData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetCustomAuthDataW*(pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, pbCustomAuthData: ptr BYTE, pdwSizeofCustomAuthData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetCustomAuthDataA*(pszPhonebook: LPCSTR, pszEntry: LPCSTR, pbCustomAuthData: ptr BYTE, dwSizeofCustomAuthData: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasSetCustomAuthDataW*(pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, pbCustomAuthData: ptr BYTE, dwSizeofCustomAuthData: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetEapUserIdentityW*(pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, dwFlags: DWORD, hwnd: HWND, ppRasEapUserIdentity: ptr LPRASEAPUSERIDENTITYW): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasGetEapUserIdentityA*(pszPhonebook: LPCSTR, pszEntry: LPCSTR, dwFlags: DWORD, hwnd: HWND, ppRasEapUserIdentity: ptr LPRASEAPUSERIDENTITYA): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasFreeEapUserIdentityW*(pRasEapUserIdentity: LPRASEAPUSERIDENTITYW): VOID {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasFreeEapUserIdentityA*(pRasEapUserIdentity: LPRASEAPUSERIDENTITYA): VOID {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasDeleteSubEntryA*(pszPhonebook: LPCSTR, pszEntry: LPCSTR, dwSubentryId: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasDeleteSubEntryW*(pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, dwSubEntryId: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc.}
proc RasPhonebookDlgA*(lpszPhonebook: LPSTR, lpszEntry: LPSTR, lpInfo: LPRASPBDLGA): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc.}
proc RasPhonebookDlgW*(lpszPhonebook: LPWSTR, lpszEntry: LPWSTR, lpInfo: LPRASPBDLGW): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc.}
proc RasEntryDlgA*(lpszPhonebook: LPSTR, lpszEntry: LPSTR, lpInfo: LPRASENTRYDLGA): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc.}
proc RasEntryDlgW*(lpszPhonebook: LPWSTR, lpszEntry: LPWSTR, lpInfo: LPRASENTRYDLGW): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc.}
proc RasDialDlgA*(lpszPhonebook: LPSTR, lpszEntry: LPSTR, lpszPhoneNumber: LPSTR, lpInfo: LPRASDIALDLG): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc.}
proc RasDialDlgW*(lpszPhonebook: LPWSTR, lpszEntry: LPWSTR, lpszPhoneNumber: LPWSTR, lpInfo: LPRASDIALDLG): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc.}
proc MprAdminConnectionEnum*(hRasServer: RAS_SERVER_HANDLE, dwLevel: DWORD, lplpbBuffer: ptr LPBYTE, dwPrefMaxLen: DWORD, lpdwEntriesRead: LPDWORD, lpdwTotalEntries: LPDWORD, lpdwResumeHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminPortEnum*(hRasServer: RAS_SERVER_HANDLE, dwLevel: DWORD, hConnection: HANDLE, lplpbBuffer: ptr LPBYTE, dwPrefMaxLen: DWORD, lpdwEntriesRead: LPDWORD, lpdwTotalEntries: LPDWORD, lpdwResumeHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminConnectionGetInfo*(hRasServer: RAS_SERVER_HANDLE, dwLevel: DWORD, hConnection: HANDLE, lplpbBuffer: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminPortGetInfo*(hRasServer: RAS_SERVER_HANDLE, dwLevel: DWORD, hPort: HANDLE, lplpbBuffer: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminConnectionClearStats*(hRasServer: RAS_SERVER_HANDLE, hConnection: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminPortClearStats*(hRasServer: RAS_SERVER_HANDLE, hPort: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminPortReset*(hRasServer: RAS_SERVER_HANDLE, hPort: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminPortDisconnect*(hRasServer: RAS_SERVER_HANDLE, hPort: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminConnectionRemoveQuarantine*(hRasServer: HANDLE, hRasConnection: HANDLE, fIsIpAddress: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminUserGetInfo*(lpszServer: ptr WCHAR, lpszUser: ptr WCHAR, dwLevel: DWORD, lpbBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminUserSetInfo*(lpszServer: ptr WCHAR, lpszUser: ptr WCHAR, dwLevel: DWORD, lpbBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminSendUserMessage*(hMprServer: MPR_SERVER_HANDLE, hConnection: HANDLE, lpwszMessage: LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminGetPDCServer*(lpszDomain: ptr WCHAR, lpszServer: ptr WCHAR, lpszPDCServer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminIsServiceRunning*(lpwsServerName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminServerConnect*(lpwsServerName: LPWSTR, phMprServer: ptr MPR_SERVER_HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminServerDisconnect*(hMprServer: MPR_SERVER_HANDLE): VOID {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminServerGetCredentials*(hMprServer: MPR_SERVER_HANDLE, dwLevel: DWORD, lplpbBuffer: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminServerSetCredentials*(hMprServer: MPR_SERVER_HANDLE, dwLevel: DWORD, lpbBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminBufferFree*(pBuffer: LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminGetErrorString*(dwError: DWORD, lpwsErrorString: ptr LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminServerGetInfo*(hMprServer: MPR_SERVER_HANDLE, dwLevel: DWORD, lplpbBuffer: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminServerSetInfo*(hMprServer: MPR_SERVER_HANDLE, dwLevel: DWORD, lpbBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminEstablishDomainRasServer*(pszDomain: PWCHAR, pszMachine: PWCHAR, bEnable: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminIsDomainRasServer*(pszDomain: PWCHAR, pszMachine: PWCHAR, pbIsRasServer: PBOOL): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminTransportCreate*(hMprServer: MPR_SERVER_HANDLE, dwTransportId: DWORD, lpwsTransportName: LPWSTR, pGlobalInfo: LPBYTE, dwGlobalInfoSize: DWORD, pClientInterfaceInfo: LPBYTE, dwClientInterfaceInfoSize: DWORD, lpwsDLLPath: LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminTransportSetInfo*(hMprServer: MPR_SERVER_HANDLE, dwTransportId: DWORD, pGlobalInfo: LPBYTE, dwGlobalInfoSize: DWORD, pClientInterfaceInfo: LPBYTE, dwClientInterfaceInfoSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminTransportGetInfo*(hMprServer: MPR_SERVER_HANDLE, dwTransportId: DWORD, ppGlobalInfo: ptr LPBYTE, lpdwGlobalInfoSize: LPDWORD, ppClientInterfaceInfo: ptr LPBYTE, lpdwClientInterfaceInfoSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminDeviceEnum*(hMprServer: MPR_SERVER_HANDLE, dwLevel: DWORD, lplpbBuffer: ptr LPBYTE, lpdwTotalEntries: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceGetHandle*(hMprServer: MPR_SERVER_HANDLE, lpwsInterfaceName: LPWSTR, phInterface: ptr HANDLE, fIncludeClientInterfaces: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceCreate*(hMprServer: MPR_SERVER_HANDLE, dwLevel: DWORD, lpbBuffer: LPBYTE, phInterface: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceGetInfo*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwLevel: DWORD, lplpbBuffer: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceSetInfo*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwLevel: DWORD, lpbBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceDelete*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceDeviceGetInfo*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwIndex: DWORD, dwLevel: DWORD, lplpBuffer: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceDeviceSetInfo*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwIndex: DWORD, dwLevel: DWORD, lplpBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceTransportRemove*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwTransportId: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceTransportAdd*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwTransportId: DWORD, pInterfaceInfo: LPBYTE, dwInterfaceInfoSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceTransportGetInfo*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwTransportId: DWORD, ppInterfaceInfo: ptr LPBYTE, lpdwpInterfaceInfoSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceTransportSetInfo*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwTransportId: DWORD, pInterfaceInfo: LPBYTE, dwInterfaceInfoSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceEnum*(hMprServer: MPR_SERVER_HANDLE, dwLevel: DWORD, lplpbBuffer: ptr LPBYTE, dwPrefMaxLen: DWORD, lpdwEntriesRead: LPDWORD, lpdwTotalEntries: LPDWORD, lpdwResumeHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceSetCredentials*(lpwsServer: LPWSTR, lpwsInterfaceName: LPWSTR, lpwsUserName: LPWSTR, lpwsDomainName: LPWSTR, lpwsPassword: LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceGetCredentials*(lpwsServer: LPWSTR, lpwsInterfaceName: LPWSTR, lpwsUserName: LPWSTR, lpwsPassword: LPWSTR, lpwsDomainName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceSetCredentialsEx*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwLevel: DWORD, lpbBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceGetCredentialsEx*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwLevel: DWORD, lplpbBuffer: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceConnect*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, hEvent: HANDLE, fSynchronous: WINBOOL): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceDisconnect*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceUpdateRoutes*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwProtocolId: DWORD, hEvent: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceQueryUpdateResult*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE, dwProtocolId: DWORD, lpdwUpdateResult: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminInterfaceUpdatePhonebookInfo*(hMprServer: MPR_SERVER_HANDLE, hInterface: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminRegisterConnectionNotification*(hMprServer: MPR_SERVER_HANDLE, hEventNotification: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminDeregisterConnectionNotification*(hMprServer: MPR_SERVER_HANDLE, hEventNotification: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBServerConnect*(lpwsServerName: LPWSTR, phMibServer: ptr MIB_SERVER_HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBServerDisconnect*(hMibServer: MIB_SERVER_HANDLE): VOID {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBEntryCreate*(hMibServer: MIB_SERVER_HANDLE, dwPid: DWORD, dwRoutingPid: DWORD, lpEntry: LPVOID, dwEntrySize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBEntryDelete*(hMibServer: MIB_SERVER_HANDLE, dwProtocolId: DWORD, dwRoutingPid: DWORD, lpEntry: LPVOID, dwEntrySize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBEntrySet*(hMibServer: MIB_SERVER_HANDLE, dwProtocolId: DWORD, dwRoutingPid: DWORD, lpEntry: LPVOID, dwEntrySize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBEntryGet*(hMibServer: MIB_SERVER_HANDLE, dwProtocolId: DWORD, dwRoutingPid: DWORD, lpInEntry: LPVOID, dwInEntrySize: DWORD, lplpOutEntry: ptr LPVOID, lpOutEntrySize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBEntryGetFirst*(hMibServer: MIB_SERVER_HANDLE, dwProtocolId: DWORD, dwRoutingPid: DWORD, lpInEntry: LPVOID, dwInEntrySize: DWORD, lplpOutEntry: ptr LPVOID, lpOutEntrySize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBEntryGetNext*(hMibServer: MIB_SERVER_HANDLE, dwProtocolId: DWORD, dwRoutingPid: DWORD, lpInEntry: LPVOID, dwInEntrySize: DWORD, lplpOutEntry: ptr LPVOID, lpOutEntrySize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprAdminMIBBufferFree*(pBuffer: LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigServerInstall*(dwLevel: DWORD, pBuffer: PVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigServerConnect*(lpwsServerName: LPWSTR, phMprConfig: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigServerDisconnect*(hMprConfig: HANDLE): VOID {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigServerRefresh*(hMprConfig: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigBufferFree*(pBuffer: LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigServerGetInfo*(hMprConfig: HANDLE, dwLevel: DWORD, lplpbBuffer: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigServerSetInfo*(hMprServer: MPR_SERVER_HANDLE, dwLevel: DWORD, lpbBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigServerBackup*(hMprConfig: HANDLE, lpwsPath: LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigServerRestore*(hMprConfig: HANDLE, lpwsPath: LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigTransportCreate*(hMprConfig: HANDLE, dwTransportId: DWORD, lpwsTransportName: LPWSTR, pGlobalInfo: LPBYTE, dwGlobalInfoSize: DWORD, pClientInterfaceInfo: LPBYTE, dwClientInterfaceInfoSize: DWORD, lpwsDLLPath: LPWSTR, phRouterTransport: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigTransportDelete*(hMprConfig: HANDLE, hRouterTransport: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigTransportGetHandle*(hMprConfig: HANDLE, dwTransportId: DWORD, phRouterTransport: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigTransportSetInfo*(hMprConfig: HANDLE, hRouterTransport: HANDLE, pGlobalInfo: LPBYTE, dwGlobalInfoSize: DWORD, pClientInterfaceInfo: LPBYTE, dwClientInterfaceInfoSize: DWORD, lpwsDLLPath: LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigTransportGetInfo*(hMprConfig: HANDLE, hRouterTransport: HANDLE, ppGlobalInfo: ptr LPBYTE, lpdwGlobalInfoSize: LPDWORD, ppClientInterfaceInfo: ptr LPBYTE, lpdwClientInterfaceInfoSize: LPDWORD, lplpwsDLLPath: ptr LPWSTR): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigTransportEnum*(hMprConfig: HANDLE, dwLevel: DWORD, lplpBuffer: ptr LPBYTE, dwPrefMaxLen: DWORD, lpdwEntriesRead: LPDWORD, lpdwTotalEntries: LPDWORD, lpdwResumeHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceCreate*(hMprConfig: HANDLE, dwLevel: DWORD, lpbBuffer: LPBYTE, phRouterInterface: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceDelete*(hMprConfig: HANDLE, hRouterInterface: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceGetHandle*(hMprConfig: HANDLE, lpwsInterfaceName: LPWSTR, phRouterInterface: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceGetInfo*(hMprConfig: HANDLE, hRouterInterface: HANDLE, dwLevel: DWORD, lplpBuffer: ptr LPBYTE, lpdwBufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceSetInfo*(hMprConfig: HANDLE, hRouterInterface: HANDLE, dwLevel: DWORD, lpbBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceEnum*(hMprConfig: HANDLE, dwLevel: DWORD, lplpBuffer: ptr LPBYTE, dwPrefMaxLen: DWORD, lpdwEntriesRead: LPDWORD, lpdwTotalEntries: LPDWORD, lpdwResumeHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceTransportAdd*(hMprConfig: HANDLE, hRouterInterface: HANDLE, dwTransportId: DWORD, lpwsTransportName: LPWSTR, pInterfaceInfo: LPBYTE, dwInterfaceInfoSize: DWORD, phRouterIfTransport: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceTransportRemove*(hMprConfig: HANDLE, hRouterInterface: HANDLE, hRouterIfTransport: HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceTransportGetHandle*(hMprConfig: HANDLE, hRouterInterface: HANDLE, dwTransportId: DWORD, phRouterIfTransport: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceTransportGetInfo*(hMprConfig: HANDLE, hRouterInterface: HANDLE, hRouterIfTransport: HANDLE, ppInterfaceInfo: ptr LPBYTE, lpdwInterfaceInfoSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceTransportSetInfo*(hMprConfig: HANDLE, hRouterInterface: HANDLE, hRouterIfTransport: HANDLE, pInterfaceInfo: LPBYTE, dwInterfaceInfoSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigInterfaceTransportEnum*(hMprConfig: HANDLE, hRouterInterface: HANDLE, dwLevel: DWORD, lplpBuffer: ptr LPBYTE, dwPrefMaxLen: DWORD, lpdwEntriesRead: LPDWORD, lpdwTotalEntries: LPDWORD, lpdwResumeHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigGetFriendlyName*(hMprConfig: HANDLE, pszGuidName: PWCHAR, pszBuffer: PWCHAR, dwBufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigGetGuidName*(hMprConfig: HANDLE, pszFriendlyName: PWCHAR, pszBuffer: PWCHAR, dwBufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoCreate*(dwVersion: DWORD, lplpNewHeader: ptr LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoDelete*(lpHeader: LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoRemoveAll*(lpHeader: LPVOID, lplpNewHeader: ptr LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoDuplicate*(lpHeader: LPVOID, lplpNewHeader: ptr LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoBlockAdd*(lpHeader: LPVOID, dwInfoType: DWORD, dwItemSize: DWORD, dwItemCount: DWORD, lpItemData: LPBYTE, lplpNewHeader: ptr LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoBlockRemove*(lpHeader: LPVOID, dwInfoType: DWORD, lplpNewHeader: ptr LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoBlockSet*(lpHeader: LPVOID, dwInfoType: DWORD, dwItemSize: DWORD, dwItemCount: DWORD, lpItemData: LPBYTE, lplpNewHeader: ptr LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoBlockFind*(lpHeader: LPVOID, dwInfoType: DWORD, lpdwItemSize: LPDWORD, lpdwItemCount: LPDWORD, lplpItemData: ptr LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprInfoBlockQuerySize*(lpHeader: LPVOID): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigFilterGetInfo*(hMprConfig: HANDLE, dwLevel: DWORD, dwTransportId: DWORD, lpBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc MprConfigFilterSetInfo*(hMprConfig: HANDLE, dwLevel: DWORD, dwTransportId: DWORD, lpBuffer: LPBYTE): DWORD {.winapi, stdcall, dynlib: "mprapi", importc.}
proc RasSecurityDialogSend*(hPort: HPORT, pBuffer: PBYTE, BufferLength: WORD): DWORD {.winapi, stdcall, dynlib: "rasman", importc.}
proc RasSecurityDialogReceive*(hPort: HPORT, pBuffer: PBYTE, pBufferLength: PWORD, Timeout: DWORD, hEvent: HANDLE): DWORD {.winapi, stdcall, dynlib: "rasman", importc.}
proc RasSecurityDialogGetInfo*(hPort: HPORT, pBuffer: ptr RAS_SECURITY_INFO): DWORD {.winapi, stdcall, dynlib: "rasman", importc.}
proc `ipv4=`*(self: var RASTUNNELENDPOINT, x: RASIPV4ADDR) {.inline.} = self.union1.ipv4 = x
proc ipv4*(self: RASTUNNELENDPOINT): RASIPV4ADDR {.inline.} = self.union1.ipv4
proc ipv4*(self: var RASTUNNELENDPOINT): var RASIPV4ADDR {.inline.} = self.union1.ipv4
proc `ipv6=`*(self: var RASTUNNELENDPOINT, x: RASIPV6ADDR) {.inline.} = self.union1.ipv6 = x
proc ipv6*(self: RASTUNNELENDPOINT): RASIPV6ADDR {.inline.} = self.union1.ipv6
proc ipv6*(self: var RASTUNNELENDPOINT): var RASIPV6ADDR {.inline.} = self.union1.ipv6
proc `Ikev2ProjectionInfo=`*(self: var PROJECTION_INFO, x: IKEV2_PROJECTION_INFO) {.inline.} = self.union1.Ikev2ProjectionInfo = x
proc ikev2ProjectionInfo*(self: PROJECTION_INFO): IKEV2_PROJECTION_INFO {.inline.} = self.union1.Ikev2ProjectionInfo
proc ikev2ProjectionInfo*(self: var PROJECTION_INFO): var IKEV2_PROJECTION_INFO {.inline.} = self.union1.Ikev2ProjectionInfo
proc `PppProjectionInfo=`*(self: var PROJECTION_INFO, x: PPP_PROJECTION_INFO) {.inline.} = self.union1.PppProjectionInfo = x
proc pppProjectionInfo*(self: PROJECTION_INFO): PPP_PROJECTION_INFO {.inline.} = self.union1.PppProjectionInfo
proc pppProjectionInfo*(self: var PROJECTION_INFO): var PPP_PROJECTION_INFO {.inline.} = self.union1.PppProjectionInfo
when winimUnicode:
  type
    RASADFUNC* = RASADFUNCW
    RASEAPUSERIDENTITY* = RASEAPUSERIDENTITYW
    RASPBDLGFUNC* = RASPBDLGFUNCW
  proc RasDial*(P1: LPRASDIALEXTENSIONS, P2: LPCWSTR, P3: LPRASDIALPARAMSW, P4: DWORD, P5: LPVOID, P6: LPHRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasDialW".}
  proc RasEnumConnections*(P1: LPRASCONNW, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEnumConnectionsW".}
  proc RasEnumEntries*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASENTRYNAMEW, P4: LPDWORD, P5: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEnumEntriesW".}
  proc RasGetConnectStatus*(P1: HRASCONN, P2: LPRASCONNSTATUSW): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetConnectStatusW".}
  proc RasGetErrorString*(P1: UINT, P2: LPWSTR, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetErrorStringW".}
  proc RasHangUp*(P1: HRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasHangUpW".}
  proc RasGetProjectionInfo*(P1: HRASCONN, P2: RASPROJECTION, P3: LPVOID, P4: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetProjectionInfoW".}
  proc RasCreatePhonebookEntry*(P1: HWND, P2: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasCreatePhonebookEntryW".}
  proc RasEditPhonebookEntry*(P1: HWND, P2: LPCWSTR, P3: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEditPhonebookEntryW".}
  proc RasSetEntryDialParams*(P1: LPCWSTR, P2: LPRASDIALPARAMSW, P3: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetEntryDialParamsW".}
  proc RasGetEntryDialParams*(P1: LPCWSTR, P2: LPRASDIALPARAMSW, P3: LPBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetEntryDialParamsW".}
  proc RasEnumDevices*(P1: LPRASDEVINFOW, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEnumDevicesW".}
  proc RasGetCountryInfo*(P1: LPRASCTRYINFOW, P2: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetCountryInfoW".}
  proc RasGetEntryProperties*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASENTRYW, P4: LPDWORD, P5: LPBYTE, P6: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetEntryPropertiesW".}
  proc RasSetEntryProperties*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASENTRYW, P4: DWORD, P5: LPBYTE, P6: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetEntryPropertiesW".}
  proc RasRenameEntry*(P1: LPCWSTR, P2: LPCWSTR, P3: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasRenameEntryW".}
  proc RasDeleteEntry*(P1: LPCWSTR, P2: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasDeleteEntryW".}
  proc RasValidateEntryName*(P1: LPCWSTR, P2: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasValidateEntryNameW".}
  proc RasGetSubEntryHandle*(P1: HRASCONN, P2: DWORD, P3: LPHRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetSubEntryHandleW".}
  proc RasConnectionNotification*(P1: HRASCONN, P2: HANDLE, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasConnectionNotificationW".}
  proc RasGetSubEntryProperties*(P1: LPCWSTR, P2: LPCWSTR, P3: DWORD, P4: LPRASSUBENTRYW, P5: LPDWORD, P6: LPBYTE, P7: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetSubEntryPropertiesW".}
  proc RasSetSubEntryProperties*(P1: LPCWSTR, P2: LPCWSTR, P3: DWORD, P4: LPRASSUBENTRYW, P5: DWORD, P6: LPBYTE, P7: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetSubEntryPropertiesW".}
  proc RasGetCredentials*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASCREDENTIALSW): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetCredentialsW".}
  proc RasSetCredentials*(P1: LPCWSTR, P2: LPCWSTR, P3: LPRASCREDENTIALSW, P4: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetCredentialsW".}
  proc RasGetAutodialAddress*(P1: LPCWSTR, P2: LPDWORD, P3: LPRASAUTODIALENTRYW, P4: LPDWORD, P5: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetAutodialAddressW".}
  proc RasSetAutodialAddress*(P1: LPCWSTR, P2: DWORD, P3: LPRASAUTODIALENTRYW, P4: DWORD, P5: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetAutodialAddressW".}
  proc RasEnumAutodialAddresses*(P1: ptr LPWSTR, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEnumAutodialAddressesW".}
  proc RasGetAutodialEnable*(P1: DWORD, P2: LPBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetAutodialEnableW".}
  proc RasSetAutodialEnable*(P1: DWORD, P2: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetAutodialEnableW".}
  proc RasGetAutodialParam*(P1: DWORD, P2: LPVOID, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetAutodialParamW".}
  proc RasSetAutodialParam*(P1: DWORD, P2: LPVOID, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetAutodialParamW".}
  proc RasGetEapUserData*(hToken: HANDLE, pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, pbEapData: ptr BYTE, pdwSizeofEapData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetEapUserDataW".}
  proc RasSetEapUserData*(hToken: HANDLE, pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, pbEapData: ptr BYTE, dwSizeofEapData: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetEapUserDataW".}
  proc RasGetCustomAuthData*(pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, pbCustomAuthData: ptr BYTE, pdwSizeofCustomAuthData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetCustomAuthDataW".}
  proc RasSetCustomAuthData*(pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, pbCustomAuthData: ptr BYTE, dwSizeofCustomAuthData: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetCustomAuthDataW".}
  proc RasGetEapUserIdentity*(pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, dwFlags: DWORD, hwnd: HWND, ppRasEapUserIdentity: ptr LPRASEAPUSERIDENTITYW): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetEapUserIdentityW".}
  proc RasFreeEapUserIdentity*(pRasEapUserIdentity: LPRASEAPUSERIDENTITYW): VOID {.winapi, stdcall, dynlib: "rasapi32", importc: "RasFreeEapUserIdentityW".}
  proc RasDeleteSubEntry*(pszPhonebook: LPCWSTR, pszEntry: LPCWSTR, dwSubEntryId: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasDeleteSubEntryW".}
  proc RasPhonebookDlg*(lpszPhonebook: LPWSTR, lpszEntry: LPWSTR, lpInfo: LPRASPBDLGW): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc: "RasPhonebookDlgW".}
  proc RasEntryDlg*(lpszPhonebook: LPWSTR, lpszEntry: LPWSTR, lpInfo: LPRASENTRYDLGW): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc: "RasEntryDlgW".}
  proc RasDialDlg*(lpszPhonebook: LPWSTR, lpszEntry: LPWSTR, lpszPhoneNumber: LPWSTR, lpInfo: LPRASDIALDLG): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc: "RasDialDlgW".}
when winimAnsi:
  type
    RASADFUNC* = RASADFUNCA
    RASEAPUSERIDENTITY* = RASEAPUSERIDENTITYA
    RASPBDLGFUNC* = RASPBDLGFUNCA
  proc RasDial*(P1: LPRASDIALEXTENSIONS, P2: LPCSTR, P3: LPRASDIALPARAMSA, P4: DWORD, P5: LPVOID, P6: LPHRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasDialA".}
  proc RasEnumConnections*(P1: LPRASCONNA, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEnumConnectionsA".}
  proc RasEnumEntries*(P1: LPCSTR, P2: LPCSTR, P3: LPRASENTRYNAMEA, P4: LPDWORD, P5: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEnumEntriesA".}
  proc RasGetConnectStatus*(P1: HRASCONN, P2: LPRASCONNSTATUSA): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetConnectStatusA".}
  proc RasGetErrorString*(P1: UINT, P2: LPSTR, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetErrorStringA".}
  proc RasHangUp*(P1: HRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasHangUpA".}
  proc RasGetProjectionInfo*(P1: HRASCONN, P2: RASPROJECTION, P3: LPVOID, P4: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetProjectionInfoA".}
  proc RasCreatePhonebookEntry*(P1: HWND, P2: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasCreatePhonebookEntryA".}
  proc RasEditPhonebookEntry*(P1: HWND, P2: LPCSTR, P3: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEditPhonebookEntryA".}
  proc RasSetEntryDialParams*(P1: LPCSTR, P2: LPRASDIALPARAMSA, P3: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetEntryDialParamsA".}
  proc RasGetEntryDialParams*(P1: LPCSTR, P2: LPRASDIALPARAMSA, P3: LPBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetEntryDialParamsA".}
  proc RasEnumDevices*(P1: LPRASDEVINFOA, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEnumDevicesA".}
  proc RasGetCountryInfo*(P1: LPRASCTRYINFOA, P2: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetCountryInfoA".}
  proc RasGetEntryProperties*(P1: LPCSTR, P2: LPCSTR, P3: LPRASENTRYA, P4: LPDWORD, P5: LPBYTE, P6: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetEntryPropertiesA".}
  proc RasSetEntryProperties*(P1: LPCSTR, P2: LPCSTR, P3: LPRASENTRYA, P4: DWORD, P5: LPBYTE, P6: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetEntryPropertiesA".}
  proc RasRenameEntry*(P1: LPCSTR, P2: LPCSTR, P3: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasRenameEntryA".}
  proc RasDeleteEntry*(P1: LPCSTR, P2: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasDeleteEntryA".}
  proc RasValidateEntryName*(P1: LPCSTR, P2: LPCSTR): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasValidateEntryNameA".}
  proc RasGetSubEntryHandle*(P1: HRASCONN, P2: DWORD, P3: LPHRASCONN): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetSubEntryHandleA".}
  proc RasConnectionNotification*(P1: HRASCONN, P2: HANDLE, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasConnectionNotificationA".}
  proc RasGetSubEntryProperties*(P1: LPCSTR, P2: LPCSTR, P3: DWORD, P4: LPRASSUBENTRYA, P5: LPDWORD, P6: LPBYTE, P7: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetSubEntryPropertiesA".}
  proc RasSetSubEntryProperties*(P1: LPCSTR, P2: LPCSTR, P3: DWORD, P4: LPRASSUBENTRYA, P5: DWORD, P6: LPBYTE, P7: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetSubEntryPropertiesA".}
  proc RasGetCredentials*(P1: LPCSTR, P2: LPCSTR, P3: LPRASCREDENTIALSA): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetCredentialsA".}
  proc RasSetCredentials*(P1: LPCSTR, P2: LPCSTR, P3: LPRASCREDENTIALSA, P4: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetCredentialsA".}
  proc RasGetAutodialAddress*(P1: LPCSTR, P2: LPDWORD, P3: LPRASAUTODIALENTRYA, P4: LPDWORD, P5: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetAutodialAddressA".}
  proc RasSetAutodialAddress*(P1: LPCSTR, P2: DWORD, P3: LPRASAUTODIALENTRYA, P4: DWORD, P5: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetAutodialAddressA".}
  proc RasEnumAutodialAddresses*(P1: ptr LPSTR, P2: LPDWORD, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasEnumAutodialAddressesA".}
  proc RasGetAutodialEnable*(P1: DWORD, P2: LPBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetAutodialEnableA".}
  proc RasSetAutodialEnable*(P1: DWORD, P2: WINBOOL): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetAutodialEnableA".}
  proc RasGetAutodialParam*(P1: DWORD, P2: LPVOID, P3: LPDWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetAutodialParamA".}
  proc RasSetAutodialParam*(P1: DWORD, P2: LPVOID, P3: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetAutodialParamA".}
  proc RasGetEapUserData*(hToken: HANDLE, pszPhonebook: LPCSTR, pszEntry: LPCSTR, pbEapData: ptr BYTE, pdwSizeofEapData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetEapUserDataA".}
  proc RasSetEapUserData*(hToken: HANDLE, pszPhonebook: LPCSTR, pszEntry: LPCSTR, pbEapData: ptr BYTE, dwSizeofEapData: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetEapUserDataA".}
  proc RasGetCustomAuthData*(pszPhonebook: LPCSTR, pszEntry: LPCSTR, pbCustomAuthData: ptr BYTE, pdwSizeofCustomAuthData: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetCustomAuthDataA".}
  proc RasSetCustomAuthData*(pszPhonebook: LPCSTR, pszEntry: LPCSTR, pbCustomAuthData: ptr BYTE, dwSizeofCustomAuthData: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasSetCustomAuthDataA".}
  proc RasGetEapUserIdentity*(pszPhonebook: LPCSTR, pszEntry: LPCSTR, dwFlags: DWORD, hwnd: HWND, ppRasEapUserIdentity: ptr LPRASEAPUSERIDENTITYA): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasGetEapUserIdentityA".}
  proc RasFreeEapUserIdentity*(pRasEapUserIdentity: LPRASEAPUSERIDENTITYA): VOID {.winapi, stdcall, dynlib: "rasapi32", importc: "RasFreeEapUserIdentityA".}
  proc RasDeleteSubEntry*(pszPhonebook: LPCSTR, pszEntry: LPCSTR, dwSubentryId: DWORD): DWORD {.winapi, stdcall, dynlib: "rasapi32", importc: "RasDeleteSubEntryA".}
  proc RasPhonebookDlg*(lpszPhonebook: LPSTR, lpszEntry: LPSTR, lpInfo: LPRASPBDLGA): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc: "RasPhonebookDlgA".}
  proc RasEntryDlg*(lpszPhonebook: LPSTR, lpszEntry: LPSTR, lpInfo: LPRASENTRYDLGA): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc: "RasEntryDlgA".}
  proc RasDialDlg*(lpszPhonebook: LPSTR, lpszEntry: LPSTR, lpszPhoneNumber: LPSTR, lpInfo: LPRASDIALDLG): WINBOOL {.winapi, stdcall, dynlib: "rasdlg", importc: "RasDialDlgA".}
