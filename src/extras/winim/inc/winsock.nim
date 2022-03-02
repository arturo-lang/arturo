#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winerror
import winbase
#include <winsock2.h>
#include <psdk_inc/_ws1_undef.h>
#include <_timeval.h>
#include <inaddr.h>
#include <psdk_inc/_socket_types.h>
#include <psdk_inc/_fd_types.h>
#include <psdk_inc/_ip_types.h>
#include <psdk_inc/_wsadata.h>
#include <ws2def.h>
#include <qos.h>
#include <ws2tcpip.h>
#include <ws2ipdef.h>
#include <in6addr.h>
#include <psdk_inc/_ip_mreq1.h>
#include <mstcpip.h>
#include <mswsock.h>
#include <psdk_inc/_xmitfile.h>
type
  SCOPE_LEVEL* = int32
  GROUP* = int32
  WSACOMPLETIONTYPE* = int32
  PWSACOMPLETIONTYPE* = ptr int32
  LPWSACOMPLETIONTYPE* = ptr int32
  ADDRESS_FAMILY* = uint16
  WSAECOMPARATOR* = int32
  PWSAECOMPARATOR* = ptr int32
  LPWSAECOMPARATOR* = ptr int32
  WSAESETSERVICEOP* = int32
  PWSAESETSERVICEOP* = ptr int32
  LPWSAESETSERVICEOP* = ptr int32
  MULTICAST_MODE_TYPE* = int32
  socklen_t* = int32
  SOCKET_SECURITY_PROTOCOL* = int32
  SOCKET_USAGE_TYPE* = int32
  NLA_BLOB_DATA_TYPE* = int32
  PNLA_BLOB_DATA_TYPE* = ptr int32
  NLA_CONNECTIVITY_TYPE* = int32
  PNLA_CONNECTIVITY_TYPE* = ptr int32
  NLA_INTERNET* = int32
  PNLA_INTERNET* = ptr int32
  SOCKET* = int
  SERVICETYPE* = ULONG
  LPLOOKUPSERVICE_COMPLETION_ROUTINE* = PVOID
  WSAEVENT* = HANDLE
  IN_ADDR* {.pure.} = object
    S_addr*: int32
  PIN_ADDR* = ptr IN_ADDR
  LPIN_ADDR* = ptr IN_ADDR
const
  FD_SETSIZE* = 64
type
  fd_set* {.pure.} = object
    fd_count*: int32
    fd_array*: array[FD_SETSIZE, SOCKET]
  PFD_SET* = ptr fd_set
  LPFD_SET* = ptr fd_set
  hostent* {.pure.} = object
    h_name*: ptr char
    h_aliases*: ptr ptr char
    h_addrtype*: int16
    h_length*: int16
    h_addr_list*: ptr ptr char
  HOSTENT* = hostent
  PHOSTENT* = ptr hostent
  LPHOSTENT* = ptr hostent
when winimCpu64:
  type
    servent* {.pure.} = object
      s_name*: ptr char
      s_aliases*: ptr ptr char
      s_proto*: ptr char
      s_port*: int16
when winimCpu32:
  type
    servent* {.pure.} = object
      s_name*: ptr char
      s_aliases*: ptr ptr char
      s_port*: int16
      s_proto*: ptr char
type
  SERVENT* = servent
  PSERVENT* = ptr servent
  LPSERVENT* = ptr servent
  protoent* {.pure.} = object
    p_name*: ptr char
    p_aliases*: ptr ptr char
    p_proto*: int16
  PROTOENT* = protoent
  PPROTOENT* = ptr protoent
  LPPROTOENT* = ptr protoent
  sockaddr* {.pure.} = object
    sa_family*: uint16
    sa_data*: array[14, char]
  SOCKADDR* = sockaddr
  PSOCKADDR* = ptr sockaddr
  LPSOCKADDR* = ptr sockaddr
  sockaddr_in* {.pure.} = object
    sin_family*: int16
    sin_port*: uint16
    sin_addr*: IN_ADDR
    sin_zero*: array[8, char]
  SOCKADDR_IN* = sockaddr_in
  PSOCKADDR_IN* = ptr sockaddr_in
  LPSOCKADDR_IN* = ptr sockaddr_in
  linger* {.pure.} = object
    l_onoff*: uint16
    l_linger*: uint16
  LINGER* = linger
  PLINGER* = ptr linger
  LPLINGER* = ptr linger
  timeval* {.pure.} = object
    tv_sec*: int32
    tv_usec*: int32
  TIMEVAL* = timeval
  PTIMEVAL* = ptr timeval
  LPTIMEVAL* = ptr timeval
const
  WSADESCRIPTION_LEN* = 256
  WSASYS_STATUS_LEN* = 128
when winimCpu64:
  type
    WSADATA* {.pure.} = object
      wVersion*: WORD
      wHighVersion*: WORD
      iMaxSockets*: uint16
      iMaxUdpDg*: uint16
      lpVendorInfo*: ptr char
      szDescription*: array[WSADESCRIPTION_LEN+1, char]
      szSystemStatus*: array[WSASYS_STATUS_LEN+1, char]
when winimCpu32:
  type
    WSADATA* {.pure.} = object
      wVersion*: WORD
      wHighVersion*: WORD
      szDescription*: array[WSADESCRIPTION_LEN+1, char]
      szSystemStatus*: array[WSASYS_STATUS_LEN+1, char]
      iMaxSockets*: uint16
      iMaxUdpDg*: uint16
      lpVendorInfo*: ptr char
type
  LPWSADATA* = ptr WSADATA
  SCOPE_ID_UNION1_STRUCT1* {.pure.} = object
    Zone* {.bitsize:28.}: ULONG
    Level* {.bitsize:4.}: ULONG
  SCOPE_ID_UNION1* {.pure, union.} = object
    struct1*: SCOPE_ID_UNION1_STRUCT1
    Value*: ULONG
  SCOPE_ID* {.pure.} = object
    union1*: SCOPE_ID_UNION1
  PSCOPE_ID* = ptr SCOPE_ID
  LPWSAEVENT* = LPHANDLE
  WSAOVERLAPPED* = OVERLAPPED
  LPWSAOVERLAPPED* = ptr OVERLAPPED
  WSABUF* {.pure.} = object
    len*: int32
    buf*: ptr char
  LPWSABUF* = ptr WSABUF
  FLOWSPEC* {.pure.} = object
    TokenRate*: ULONG
    TokenBucketSize*: ULONG
    PeakBandwidth*: ULONG
    Latency*: ULONG
    DelayVariation*: ULONG
    ServiceType*: SERVICETYPE
    MaxSduSize*: ULONG
    MinimumPolicedSize*: ULONG
  PFLOWSPEC* = ptr FLOWSPEC
  LPFLOWSPEC* = ptr FLOWSPEC
  QOS_OBJECT_HDR* {.pure.} = object
    ObjectType*: ULONG
    ObjectLength*: ULONG
  LPQOS_OBJECT_HDR* = ptr QOS_OBJECT_HDR
  QOS_SD_MODE* {.pure.} = object
    ObjectHdr*: QOS_OBJECT_HDR
    ShapeDiscardMode*: ULONG
  LPQOS_SD_MODE* = ptr QOS_SD_MODE
  QOS_SHAPING_RATE* {.pure.} = object
    ObjectHdr*: QOS_OBJECT_HDR
    ShapingRate*: ULONG
  LPQOS_SHAPING_RATE* = ptr QOS_SHAPING_RATE
  QOS* {.pure.} = object
    SendingFlowspec*: FLOWSPEC
    ReceivingFlowspec*: FLOWSPEC
    ProviderSpecific*: WSABUF
  LPQOS* = ptr QOS
const
  FD_MAX_EVENTS* = 10
type
  WSANETWORKEVENTS* {.pure.} = object
    lNetworkEvents*: int32
    iErrorCode*: array[FD_MAX_EVENTS, int32]
  LPWSANETWORKEVENTS* = ptr WSANETWORKEVENTS
const
  MAX_PROTOCOL_CHAIN* = 7
type
  WSAPROTOCOLCHAIN* {.pure.} = object
    ChainLen*: int32
    ChainEntries*: array[MAX_PROTOCOL_CHAIN, DWORD]
  LPWSAPROTOCOLCHAIN* = ptr WSAPROTOCOLCHAIN
const
  WSAPROTOCOL_LEN* = 255
type
  WSAPROTOCOL_INFOA* {.pure.} = object
    dwServiceFlags1*: DWORD
    dwServiceFlags2*: DWORD
    dwServiceFlags3*: DWORD
    dwServiceFlags4*: DWORD
    dwProviderFlags*: DWORD
    ProviderId*: GUID
    dwCatalogEntryId*: DWORD
    ProtocolChain*: WSAPROTOCOLCHAIN
    iVersion*: int32
    iAddressFamily*: int32
    iMaxSockAddr*: int32
    iMinSockAddr*: int32
    iSocketType*: int32
    iProtocol*: int32
    iProtocolMaxOffset*: int32
    iNetworkByteOrder*: int32
    iSecurityScheme*: int32
    dwMessageSize*: DWORD
    dwProviderReserved*: DWORD
    szProtocol*: array[WSAPROTOCOL_LEN+1, CHAR]
  LPWSAPROTOCOL_INFOA* = ptr WSAPROTOCOL_INFOA
  WSAPROTOCOL_INFOW* {.pure.} = object
    dwServiceFlags1*: DWORD
    dwServiceFlags2*: DWORD
    dwServiceFlags3*: DWORD
    dwServiceFlags4*: DWORD
    dwProviderFlags*: DWORD
    ProviderId*: GUID
    dwCatalogEntryId*: DWORD
    ProtocolChain*: WSAPROTOCOLCHAIN
    iVersion*: int32
    iAddressFamily*: int32
    iMaxSockAddr*: int32
    iMinSockAddr*: int32
    iSocketType*: int32
    iProtocol*: int32
    iProtocolMaxOffset*: int32
    iNetworkByteOrder*: int32
    iSecurityScheme*: int32
    dwMessageSize*: DWORD
    dwProviderReserved*: DWORD
    szProtocol*: array[WSAPROTOCOL_LEN+1, WCHAR]
  LPWSAPROTOCOL_INFOW* = ptr WSAPROTOCOL_INFOW
  WSACOMPLETION_Parameters_WindowMessage* {.pure.} = object
    hWnd*: HWND
    uMsg*: UINT
    context*: WPARAM
  WSACOMPLETION_Parameters_Event* {.pure.} = object
    lpOverlapped*: LPWSAOVERLAPPED
  LPWSAOVERLAPPED_COMPLETION_ROUTINE* = proc (dwError: DWORD, cbTransferred: DWORD, lpOverlapped: LPWSAOVERLAPPED, dwFlags: DWORD): void {.stdcall.}
  WSACOMPLETION_Parameters_Apc* {.pure.} = object
    lpOverlapped*: LPWSAOVERLAPPED
    lpfnCompletionProc*: LPWSAOVERLAPPED_COMPLETION_ROUTINE
  WSACOMPLETION_Parameters_Port* {.pure.} = object
    lpOverlapped*: LPWSAOVERLAPPED
    hPort*: HANDLE
    Key*: ULONG_PTR
  WSACOMPLETION_Parameters* {.pure, union.} = object
    WindowMessage*: WSACOMPLETION_Parameters_WindowMessage
    Event*: WSACOMPLETION_Parameters_Event
    Apc*: WSACOMPLETION_Parameters_Apc
    Port*: WSACOMPLETION_Parameters_Port
  WSACOMPLETION* {.pure.} = object
    Type*: WSACOMPLETIONTYPE
    Parameters*: WSACOMPLETION_Parameters
  PWSACOMPLETION* = ptr WSACOMPLETION
  LPWSACOMPLETION* = ptr WSACOMPLETION
const
  SS_PAD1SIZE* = 0x00000006
  SS_PAD2SIZE* = 0x00000070
type
  sockaddr_storage* {.pure.} = object
    ss_family*: int16
    ss_pad1*: array[SS_PAD1SIZE, char]
    ss_align*: int64
    ss_pad2*: array[SS_PAD2SIZE, char]
  SOCKADDR_STORAGE* = sockaddr_storage
  PSOCKADDR_STORAGE* = ptr sockaddr_storage
  LPSOCKADDR_STORAGE* = ptr sockaddr_storage
  BLOB* {.pure.} = object
    cbSize*: ULONG
    pBlobData*: ptr BYTE
  LPBLOB* = ptr BLOB
  SOCKET_ADDRESS* {.pure.} = object
    lpSockaddr*: LPSOCKADDR
    iSockaddrLength*: INT
  PSOCKET_ADDRESS* = ptr SOCKET_ADDRESS
  LPSOCKET_ADDRESS* = ptr SOCKET_ADDRESS
  CSADDR_INFO* {.pure.} = object
    LocalAddr*: SOCKET_ADDRESS
    RemoteAddr*: SOCKET_ADDRESS
    iSocketType*: INT
    iProtocol*: INT
  PCSADDR_INFO* = ptr CSADDR_INFO
  LPCSADDR_INFO* = ptr CSADDR_INFO
  SOCKET_ADDRESS_LIST* {.pure.} = object
    iAddressCount*: INT
    Address*: array[1, SOCKET_ADDRESS]
  PSOCKET_ADDRESS_LIST* = ptr SOCKET_ADDRESS_LIST
  LPSOCKET_ADDRESS_LIST* = ptr SOCKET_ADDRESS_LIST
  AFPROTOCOLS* {.pure.} = object
    iAddressFamily*: INT
    iProtocol*: INT
  PAFPROTOCOLS* = ptr AFPROTOCOLS
  LPAFPROTOCOLS* = ptr AFPROTOCOLS
  WSAVERSION* {.pure.} = object
    dwVersion*: DWORD
    ecHow*: WSAECOMPARATOR
  PWSAVERSION* = ptr WSAVERSION
  LPWSAVERSION* = ptr WSAVERSION
  WSAQUERYSETA* {.pure.} = object
    dwSize*: DWORD
    lpszServiceInstanceName*: LPSTR
    lpServiceClassId*: LPGUID
    lpVersion*: LPWSAVERSION
    lpszComment*: LPSTR
    dwNameSpace*: DWORD
    lpNSProviderId*: LPGUID
    lpszContext*: LPSTR
    dwNumberOfProtocols*: DWORD
    lpafpProtocols*: LPAFPROTOCOLS
    lpszQueryString*: LPSTR
    dwNumberOfCsAddrs*: DWORD
    lpcsaBuffer*: LPCSADDR_INFO
    dwOutputFlags*: DWORD
    lpBlob*: LPBLOB
  PWSAQUERYSETA* = ptr WSAQUERYSETA
  LPWSAQUERYSETA* = ptr WSAQUERYSETA
  WSAQUERYSETW* {.pure.} = object
    dwSize*: DWORD
    lpszServiceInstanceName*: LPWSTR
    lpServiceClassId*: LPGUID
    lpVersion*: LPWSAVERSION
    lpszComment*: LPWSTR
    dwNameSpace*: DWORD
    lpNSProviderId*: LPGUID
    lpszContext*: LPWSTR
    dwNumberOfProtocols*: DWORD
    lpafpProtocols*: LPAFPROTOCOLS
    lpszQueryString*: LPWSTR
    dwNumberOfCsAddrs*: DWORD
    lpcsaBuffer*: LPCSADDR_INFO
    dwOutputFlags*: DWORD
    lpBlob*: LPBLOB
  PWSAQUERYSETW* = ptr WSAQUERYSETW
  LPWSAQUERYSETW* = ptr WSAQUERYSETW
  WSANSCLASSINFOA* {.pure.} = object
    lpszName*: LPSTR
    dwNameSpace*: DWORD
    dwValueType*: DWORD
    dwValueSize*: DWORD
    lpValue*: LPVOID
  PWSANSCLASSINFOA* = ptr WSANSCLASSINFOA
  LPWSANSCLASSINFOA* = ptr WSANSCLASSINFOA
  WSANSCLASSINFOW* {.pure.} = object
    lpszName*: LPWSTR
    dwNameSpace*: DWORD
    dwValueType*: DWORD
    dwValueSize*: DWORD
    lpValue*: LPVOID
  PWSANSCLASSINFOW* = ptr WSANSCLASSINFOW
  LPWSANSCLASSINFOW* = ptr WSANSCLASSINFOW
  WSASERVICECLASSINFOA* {.pure.} = object
    lpServiceClassId*: LPGUID
    lpszServiceClassName*: LPSTR
    dwCount*: DWORD
    lpClassInfos*: LPWSANSCLASSINFOA
  PWSASERVICECLASSINFOA* = ptr WSASERVICECLASSINFOA
  LPWSASERVICECLASSINFOA* = ptr WSASERVICECLASSINFOA
  WSASERVICECLASSINFOW* {.pure.} = object
    lpServiceClassId*: LPGUID
    lpszServiceClassName*: LPWSTR
    dwCount*: DWORD
    lpClassInfos*: LPWSANSCLASSINFOW
  PWSASERVICECLASSINFOW* = ptr WSASERVICECLASSINFOW
  LPWSASERVICECLASSINFOW* = ptr WSASERVICECLASSINFOW
  WSANAMESPACE_INFOA* {.pure.} = object
    NSProviderId*: GUID
    dwNameSpace*: DWORD
    fActive*: WINBOOL
    dwVersion*: DWORD
    lpszIdentifier*: LPSTR
  PWSANAMESPACE_INFOA* = ptr WSANAMESPACE_INFOA
  LPWSANAMESPACE_INFOA* = ptr WSANAMESPACE_INFOA
  WSANAMESPACE_INFOW* {.pure.} = object
    NSProviderId*: GUID
    dwNameSpace*: DWORD
    fActive*: WINBOOL
    dwVersion*: DWORD
    lpszIdentifier*: LPWSTR
  PWSANAMESPACE_INFOW* = ptr WSANAMESPACE_INFOW
  LPWSANAMESPACE_INFOW* = ptr WSANAMESPACE_INFOW
  WSAMSG* {.pure.} = object
    name*: LPSOCKADDR
    namelen*: INT
    lpBuffers*: LPWSABUF
    dwBufferCount*: DWORD
    Control*: WSABUF
    dwFlags*: DWORD
  PWSAMSG* = ptr WSAMSG
  LPWSAMSG* = ptr WSAMSG
  WSANAMESPACE_INFOEXA* {.pure.} = object
    NSProviderId*: GUID
    dwNameSpace*: DWORD
    fActive*: WINBOOL
    dwVersion*: DWORD
    lpszIdentifier*: LPSTR
    ProviderSpecific*: BLOB
  PWSANAMESPACE_INFOEXA* = ptr WSANAMESPACE_INFOEXA
  LPWSANAMESPACE_INFOEXA* = ptr WSANAMESPACE_INFOEXA
  WSANAMESPACE_INFOEXW* {.pure.} = object
    NSProviderId*: GUID
    dwNameSpace*: DWORD
    fActive*: WINBOOL
    dwVersion*: DWORD
    lpszIdentifier*: LPWSTR
    ProviderSpecific*: BLOB
  PWSANAMESPACE_INFOEXW* = ptr WSANAMESPACE_INFOEXW
  LPWSANAMESPACE_INFOEXW* = ptr WSANAMESPACE_INFOEXW
  WSAQUERYSET2A* {.pure.} = object
    dwSize*: DWORD
    lpszServiceInstanceName*: LPSTR
    lpVersion*: LPWSAVERSION
    lpszComment*: LPSTR
    dwNameSpace*: DWORD
    lpNSProviderId*: LPGUID
    lpszContext*: LPSTR
    dwNumberOfProtocols*: DWORD
    lpafpProtocols*: LPAFPROTOCOLS
    lpszQueryString*: LPSTR
    dwNumberOfCsAddrs*: DWORD
    lpcsaBuffer*: LPCSADDR_INFO
    dwOutputFlags*: DWORD
    lpBlob*: LPBLOB
  PWSAQUERYSET2A* = ptr WSAQUERYSET2A
  LPWSAQUERYSET2A* = ptr WSAQUERYSET2A
  WSAQUERYSET2W* {.pure.} = object
    dwSize*: DWORD
    lpszServiceInstanceName*: LPWSTR
    lpVersion*: LPWSAVERSION
    lpszComment*: LPWSTR
    dwNameSpace*: DWORD
    lpNSProviderId*: LPGUID
    lpszContext*: LPTSTR
    dwNumberOfProtocols*: DWORD
    lpafpProtocols*: LPAFPROTOCOLS
    lpszQueryString*: LPWSTR
    dwNumberOfCsAddrs*: DWORD
    lpcsaBuffer*: LPCSADDR_INFO
    dwOutputFlags*: DWORD
    lpBlob*: LPBLOB
  PWSAQUERYSET2W* = ptr WSAQUERYSET2W
  LPWSAQUERYSET2W* = ptr WSAQUERYSET2W
  WSAPOLLFD* {.pure.} = object
    fd*: SOCKET
    events*: int16
    revents*: int16
  PWSAPOLLFD* = ptr WSAPOLLFD
  LPWSAPOLLFD* = ptr WSAPOLLFD
  IN6_ADDR* {.pure.} = object
    Byte*: array[16, uint8]
  PIN6_ADDR* = ptr IN6_ADDR
  LPIN6_ADDR* = ptr IN6_ADDR
  sockaddr_in6_UNION1* {.pure, union.} = object
    sin6_scope_id*: int32
    sin6_scope_struct*: SCOPE_ID
  sockaddr_in6* {.pure.} = object
    sin6_family*: int16
    sin6_port*: uint16
    sin6_flowinfo*: int32
    sin6_addr*: IN6_ADDR
    union1*: sockaddr_in6_UNION1
  SOCKADDR_IN6* = sockaddr_in6
  PSOCKADDR_IN6* = ptr sockaddr_in6
  LPSOCKADDR_IN6* = ptr sockaddr_in6
  sockaddr_in6_old* {.pure.} = object
    sin6_family*: int16
    sin6_port*: uint16
    sin6_flowinfo*: int32
    sin6_addr*: IN6_ADDR
  sockaddr_gen* {.pure, union.} = object
    Address*: sockaddr
    AddressIn*: sockaddr_in
    AddressIn6*: sockaddr_in6_old
  TINTERFACE_INFO* {.pure.} = object
    iiFlags*: int32
    iiAddress*: sockaddr_gen
    iiBroadcastAddress*: sockaddr_gen
    iiNetmask*: sockaddr_gen
  LPTINTERFACE_INFO* = ptr TINTERFACE_INFO
  SOCKADDR_IN6_PAIR* {.pure.} = object
    SourceAddress*: PSOCKADDR_IN6
    DestinationAddress*: PSOCKADDR_IN6
  PSOCKADDR_IN6_PAIR* = ptr SOCKADDR_IN6_PAIR
  SOCKADDR_INET* {.pure, union.} = object
    Ipv4*: SOCKADDR_IN
    Ipv6*: SOCKADDR_IN6
    si_family*: ADDRESS_FAMILY
  PSOCKADDR_INET* = ptr SOCKADDR_INET
  GROUP_FILTER* {.pure.} = object
    gf_interface*: ULONG
    gf_group*: SOCKADDR_STORAGE
    gf_fmode*: MULTICAST_MODE_TYPE
    gf_numsrc*: ULONG
    gf_slist*: array[1, SOCKADDR_STORAGE]
  PGROUP_FILTER* = ptr GROUP_FILTER
  GROUP_REQ* {.pure.} = object
    gr_interface*: ULONG
    gr_group*: SOCKADDR_STORAGE
  PGROUP_REQ* = ptr GROUP_REQ
  GROUP_SOURCE_REQ* {.pure.} = object
    gsr_interface*: ULONG
    gsr_group*: SOCKADDR_STORAGE
    gsr_source*: SOCKADDR_STORAGE
  PGROUP_SOURCE_REQ* = ptr GROUP_SOURCE_REQ
  INTERFACE_INFO_EX* {.pure.} = object
    iiFlags*: int32
    iiAddress*: SOCKET_ADDRESS
    iiBroadcastAddress*: SOCKET_ADDRESS
    iiNetmask*: SOCKET_ADDRESS
  LPINTERFACE_INFO_EX* = ptr INTERFACE_INFO_EX
  ADDRINFOA* {.pure.} = object
    ai_flags*: int32
    ai_family*: int32
    ai_socktype*: int32
    ai_protocol*: int32
    ai_addrlen*: int
    ai_canonname*: ptr char
    ai_addr*: ptr sockaddr
    ai_next*: ptr ADDRINFOA
  PADDRINFOA* = ptr ADDRINFOA
  ADDRINFOW* {.pure.} = object
    ai_flags*: int32
    ai_family*: int32
    ai_socktype*: int32
    ai_protocol*: int32
    ai_addrlen*: int
    ai_canonname*: PWSTR
    ai_addr*: ptr sockaddr
    ai_next*: ptr ADDRINFOW
  PADDRINFOW* = ptr ADDRINFOW
  ADDRINFO* = ADDRINFOA
  LPADDRINFO* = ptr ADDRINFOA
  LPFN_GETADDRINFO* = proc (nodename: ptr char, servname: ptr char, hints: ptr ADDRINFOA, res: ptr ptr ADDRINFOA): int32 {.stdcall.}
  LPFN_GETADDRINFOA* = LPFN_GETADDRINFO
  LPFN_FREEADDRINFO* = proc (ai: ptr ADDRINFOA): void {.stdcall.}
  LPFN_FREEADDRINFOA* = LPFN_FREEADDRINFO
  LPFN_GETNAMEINFO* = proc (sa: ptr sockaddr, salen: socklen_t, host: ptr char, hostlen: DWORD, serv: ptr char, servlen: DWORD, flags: int32): int32 {.stdcall.}
  LPFN_GETNAMEINFOA* = LPFN_GETNAMEINFO
  ADDRINFOEXA* {.pure.} = object
    ai_flags*: int32
    ai_family*: int32
    ai_socktype*: int32
    ai_protocol*: int32
    ai_addrlen*: int
    ai_canonname*: LPCSTR
    ai_addr*: ptr sockaddr
    ai_blob*: pointer
    ai_bloblen*: int
    ai_provider*: LPGUID
    ai_next*: ptr ADDRINFOEXA
  PADDRINFOEXA* = ptr ADDRINFOEXA
  ADDRINFOEXW* {.pure.} = object
    ai_flags*: int32
    ai_family*: int32
    ai_socktype*: int32
    ai_protocol*: int32
    ai_addrlen*: int
    ai_canonname*: LPCWSTR
    ai_addr*: ptr sockaddr
    ai_blob*: pointer
    ai_bloblen*: int
    ai_provider*: LPGUID
    ai_next*: ptr ADDRINFOEXW
  PADDRINFOEXW* = ptr ADDRINFOEXW
  TRANSMIT_FILE_BUFFERS* {.pure.} = object
    Head*: LPVOID
    HeadLength*: DWORD
    Tail*: LPVOID
    TailLength*: DWORD
  PTRANSMIT_FILE_BUFFERS* = ptr TRANSMIT_FILE_BUFFERS
  LPTRANSMIT_FILE_BUFFERS* = ptr TRANSMIT_FILE_BUFFERS
  TRANSMIT_PACKETS_ELEMENT_UNION1_STRUCT1* {.pure.} = object
    nFileOffset*: LARGE_INTEGER
    hFile*: HANDLE
  TRANSMIT_PACKETS_ELEMENT_UNION1* {.pure, union.} = object
    struct1*: TRANSMIT_PACKETS_ELEMENT_UNION1_STRUCT1
    pBuffer*: PVOID
  TRANSMIT_PACKETS_ELEMENT* {.pure.} = object
    dwElFlags*: ULONG
    cLength*: ULONG
    union1*: TRANSMIT_PACKETS_ELEMENT_UNION1
  PTRANSMIT_PACKETS_ELEMENT* = ptr TRANSMIT_PACKETS_ELEMENT
  LPTRANSMIT_PACKETS_ELEMENT* = ptr TRANSMIT_PACKETS_ELEMENT
  NLA_BLOB_header* {.pure.} = object
    `type`*: NLA_BLOB_DATA_TYPE
    dwSize*: DWORD
    nextOffset*: DWORD
  NLA_BLOB_data_interfaceData* {.pure.} = object
    dwType*: DWORD
    dwSpeed*: DWORD
    adapterName*: array[1, CHAR]
  NLA_BLOB_data_locationData* {.pure.} = object
    information*: array[1, CHAR]
  NLA_BLOB_data_connectivity* {.pure.} = object
    `type`*: NLA_CONNECTIVITY_TYPE
    internet*: NLA_INTERNET
  NLA_BLOB_data_ICS_remote* {.pure.} = object
    speed*: DWORD
    `type`*: DWORD
    state*: DWORD
    machineName*: array[256, WCHAR]
    sharedAdapterName*: array[256, WCHAR]
  NLA_BLOB_data_ICS* {.pure.} = object
    remote*: NLA_BLOB_data_ICS_remote
  NLA_BLOB_data* {.pure, union.} = object
    rawData*: array[1, CHAR]
    interfaceData*: NLA_BLOB_data_interfaceData
    locationData*: NLA_BLOB_data_locationData
    connectivity*: NLA_BLOB_data_connectivity
    ICS*: NLA_BLOB_data_ICS
  NLA_BLOB* {.pure.} = object
    header*: NLA_BLOB_header
    data*: NLA_BLOB_data
  PNLA_BLOB* = ptr NLA_BLOB
  LPNLA_BLOB* = ptr NLA_BLOB
  WSACMSGHDR* {.pure.} = object
    cmsg_len*: SIZE_T
    cmsg_level*: INT
    cmsg_type*: INT
  PWSACMSGHDR* = ptr WSACMSGHDR
  LPWSACMSGHDR* = ptr WSACMSGHDR
  WSAPOLLDATA* {.pure.} = object
    result*: int32
    fds*: ULONG
    timeout*: INT
    fdArray*: UncheckedArray[WSAPOLLFD]
  LPWSAPOLLDATA* = ptr WSAPOLLDATA
  TWSASENDMSG* {.pure.} = object
    lpMsg*: LPWSAMSG
    dwFlags*: DWORD
    lpNumberOfBytesSent*: LPDWORD
    lpOverlapped*: LPWSAOVERLAPPED
    lpCompletionRoutine*: LPWSAOVERLAPPED_COMPLETION_ROUTINE
  LPWSASENDMSG* = ptr TWSASENDMSG
  addrinfo* = ADDRINFOA
  addrinfoW* = ADDRINFOW
  addrinfoExA* = ADDRINFOEXA
  addrinfoExW* = ADDRINFOEXW
when winimUnicode:
  type
    addrinfoEx* = addrinfoExW
when winimAnsi:
  type
    addrinfoEx* = addrinfoExA
type
  ADDRINFOEX* = addrinfoEx
const
  INCL_WINSOCK_API_TYPEDEFS* = 0
  WINSOCK_VERSION* = MAKEWORD(2,2)
  SOCKET_ERROR* = -1
  scopeLevelInterface* = 1
  scopeLevelLink* = 2
  scopeLevelSubnet* = 3
  scopeLevelAdmin* = 4
  scopeLevelSite* = 5
  scopeLevelOrganization* = 8
  scopeLevelGlobal* = 14
  scopeLevelCount* = 16
  IOCPARM_MASK* = 0x7f
  IOC_VOID* = 0x20000000
  IOC_OUT* = 0x40000000
  IOC_IN* = 0x80000000'i32
  IOC_INOUT* = IOC_IN or IOC_OUT
  IPPROTO_IP* = 0
  IPPROTO_HOPOPTS* = 0
  IPPROTO_ICMP* = 1
  IPPROTO_IGMP* = 2
  IPPROTO_GGP* = 3
  IPPROTO_IPV4* = 4
  IPPROTO_TCP* = 6
  IPPROTO_PUP* = 12
  IPPROTO_UDP* = 17
  IPPROTO_IDP* = 22
  IPPROTO_IPV6* = 41
  IPPROTO_ROUTING* = 43
  IPPROTO_FRAGMENT* = 44
  IPPROTO_ESP* = 50
  IPPROTO_AH* = 51
  IPPROTO_ICMPV6* = 58
  IPPROTO_NONE* = 59
  IPPROTO_DSTOPTS* = 60
  IPPROTO_ND* = 77
  IPPROTO_ICLFXBM* = 78
  IPPROTO_RAW* = 255
  IPPROTO_MAX* = 256
  IPPORT_ECHO* = 7
  IPPORT_DISCARD* = 9
  IPPORT_SYSTAT* = 11
  IPPORT_DAYTIME* = 13
  IPPORT_NETSTAT* = 15
  IPPORT_FTP* = 21
  IPPORT_TELNET* = 23
  IPPORT_SMTP* = 25
  IPPORT_TIMESERVER* = 37
  IPPORT_NAMESERVER* = 42
  IPPORT_WHOIS* = 43
  IPPORT_MTP* = 57
  IPPORT_TFTP* = 69
  IPPORT_RJE* = 77
  IPPORT_FINGER* = 79
  IPPORT_TTYLINK* = 87
  IPPORT_SUPDUP* = 95
  IPPORT_EXECSERVER* = 512
  IPPORT_LOGINSERVER* = 513
  IPPORT_CMDSERVER* = 514
  IPPORT_EFSSERVER* = 520
  IPPORT_BIFFUDP* = 512
  IPPORT_WHOSERVER* = 513
  IPPORT_ROUTESERVER* = 520
  IPPORT_RESERVED* = 1024
  IMPLINK_IP* = 155
  IMPLINK_LOWEXPER* = 156
  IMPLINK_HIGHEXPER* = 158
  IN_CLASSA_NET* = 0xff000000'i32
  IN_CLASSA_NSHIFT* = 24
  IN_CLASSA_HOST* = 0x00ffffff
  IN_CLASSA_MAX* = 128
  IN_CLASSB_NET* = 0xffff0000'i32
  IN_CLASSB_NSHIFT* = 16
  IN_CLASSB_HOST* = 0x0000ffff
  IN_CLASSB_MAX* = 65536
  IN_CLASSC_NET* = 0xffffff00'i32
  IN_CLASSC_NSHIFT* = 8
  IN_CLASSC_HOST* = 0x000000ff
  IN_CLASSD_NET* = 0xf0000000'i32
  IN_CLASSD_NSHIFT* = 28
  IN_CLASSD_HOST* = 0x0fffffff
  INADDR_ANY* = int32 0x00000000
  INADDR_LOOPBACK* = 0x7f000001
  INADDR_BROADCAST* = int32 0xffffffff'i32
  INADDR_NONE* = 0xffffffff'i32
  ADDR_ANY* = INADDR_ANY
  FROM_PROTOCOL_INFO* = -1
  SOCK_STREAM* = 1
  SOCK_DGRAM* = 2
  SOCK_RAW* = 3
  SOCK_RDM* = 4
  SOCK_SEQPACKET* = 5
  SO_DEBUG* = 0x0001
  SO_ACCEPTCONN* = 0x0002
  SO_REUSEADDR* = 0x0004
  SO_KEEPALIVE* = 0x0008
  SO_DONTROUTE* = 0x0010
  SO_BROADCAST* = 0x0020
  SO_USELOOPBACK* = 0x0040
  SO_LINGER* = 0x0080
  SO_OOBINLINE* = 0x0100
  SO_SNDBUF* = 0x1001
  SO_RCVBUF* = 0x1002
  SO_SNDLOWAT* = 0x1003
  SO_RCVLOWAT* = 0x1004
  SO_SNDTIMEO* = 0x1005
  SO_RCVTIMEO* = 0x1006
  SO_ERROR* = 0x1007
  SO_TYPE* = 0x1008
  SO_GROUP_ID* = 0x2001
  SO_GROUP_PRIORITY* = 0x2002
  SO_MAX_MSG_SIZE* = 0x2003
  SO_PROTOCOL_INFOA* = 0x2004
  SO_PROTOCOL_INFOW* = 0x2005
  PVD_CONFIG* = 0x3001
  SO_CONDITIONAL_ACCEPT* = 0x3002
  TCP_NODELAY* = 0x0001
  AF_UNSPEC* = 0
  AF_UNIX* = 1
  AF_INET* = 2
  AF_IMPLINK* = 3
  AF_PUP* = 4
  AF_CHAOS* = 5
  AF_NS* = 6
  AF_IPX* = AF_NS
  AF_ISO* = 7
  AF_OSI* = AF_ISO
  AF_ECMA* = 8
  AF_DATAKIT* = 9
  AF_CCITT* = 10
  AF_SNA* = 11
  AF_DECnet* = 12
  AF_DLI* = 13
  AF_LAT* = 14
  AF_HYLINK* = 15
  AF_APPLETALK* = 16
  AF_NETBIOS* = 17
  AF_VOICEVIEW* = 18
  AF_FIREFOX* = 19
  AF_UNKNOWN1* = 20
  AF_BAN* = 21
  AF_ATM* = 22
  AF_INET6* = 23
  AF_CLUSTER* = 24
  AF_12844* = 25
  AF_IRDA* = 26
  AF_NETDES* = 28
  AF_TCNPROCESS* = 29
  AF_TCNMESSAGE* = 30
  AF_ICLFXBM* = 31
  AF_BTH* = 32
  AF_MAX* = 33
  SS_MAXSIZE* = 128
  SS_ALIGNSIZE* = 8
  PF_UNSPEC* = AF_UNSPEC
  PF_UNIX* = AF_UNIX
  PF_INET* = AF_INET
  PF_IMPLINK* = AF_IMPLINK
  PF_PUP* = AF_PUP
  PF_CHAOS* = AF_CHAOS
  PF_NS* = AF_NS
  PF_IPX* = AF_IPX
  PF_ISO* = AF_ISO
  PF_OSI* = AF_OSI
  PF_ECMA* = AF_ECMA
  PF_DATAKIT* = AF_DATAKIT
  PF_CCITT* = AF_CCITT
  PF_SNA* = AF_SNA
  PF_DECnet* = AF_DECnet
  PF_DLI* = AF_DLI
  PF_LAT* = AF_LAT
  PF_HYLINK* = AF_HYLINK
  PF_APPLETALK* = AF_APPLETALK
  PF_VOICEVIEW* = AF_VOICEVIEW
  PF_FIREFOX* = AF_FIREFOX
  PF_UNKNOWN1* = AF_UNKNOWN1
  PF_BAN* = AF_BAN
  PF_ATM* = AF_ATM
  PF_INET6* = AF_INET6
  PF_BTH* = AF_BTH
  PF_MAX* = AF_MAX
  SOL_SOCKET* = 0xffff
  SOMAXCONN* = 0x7fffffff
  MSG_OOB* = 0x1
  MSG_PEEK* = 0x2
  MSG_DONTROUTE* = 0x4
  MSG_WAITALL* = 0x8
  MSG_PARTIAL* = 0x8000
  MSG_INTERRUPT* = 0x10
  MSG_MAXIOVLEN* = 16
  MAXGETHOSTSTRUCT* = 1024
  FD_READ_BIT* = 0
  FD_READ* = 1 shl FD_READ_BIT
  FD_WRITE_BIT* = 1
  FD_WRITE* = 1 shl FD_WRITE_BIT
  FD_OOB_BIT* = 2
  FD_OOB* = 1 shl FD_OOB_BIT
  FD_ACCEPT_BIT* = 3
  FD_ACCEPT* = 1 shl FD_ACCEPT_BIT
  FD_CONNECT_BIT* = 4
  FD_CONNECT* = 1 shl FD_CONNECT_BIT
  FD_CLOSE_BIT* = 5
  FD_CLOSE* = 1 shl FD_CLOSE_BIT
  FD_QOS_BIT* = 6
  FD_QOS* = 1 shl FD_QOS_BIT
  FD_GROUP_QOS_BIT* = 7
  FD_GROUP_QOS* = 1 shl FD_GROUP_QOS_BIT
  FD_ROUTING_INTERFACE_CHANGE_BIT* = 8
  FD_ROUTING_INTERFACE_CHANGE* = 1 shl FD_ROUTING_INTERFACE_CHANGE_BIT
  FD_ADDRESS_LIST_CHANGE_BIT* = 9
  FD_ADDRESS_LIST_CHANGE* = 1 shl FD_ADDRESS_LIST_CHANGE_BIT
  FD_ALL_EVENTS* = (1 shl FD_MAX_EVENTS)-1
  WSA_IO_PENDING* = ERROR_IO_PENDING
  WSA_IO_INCOMPLETE* = ERROR_IO_INCOMPLETE
  WSA_INVALID_HANDLE* = ERROR_INVALID_HANDLE
  WSA_INVALID_PARAMETER* = ERROR_INVALID_PARAMETER
  WSA_NOT_ENOUGH_MEMORY* = ERROR_NOT_ENOUGH_MEMORY
  WSA_OPERATION_ABORTED* = ERROR_OPERATION_ABORTED
  WSA_MAXIMUM_WAIT_EVENTS* = MAXIMUM_WAIT_OBJECTS
  WSA_WAIT_FAILED* = WAIT_FAILED
  WSA_WAIT_EVENT_0* = WAIT_OBJECT_0
  WSA_WAIT_IO_COMPLETION* = WAIT_IO_COMPLETION
  WSA_WAIT_TIMEOUT* = WAIT_TIMEOUT
  WSA_INFINITE* = INFINITE
  SERVICETYPE_NOTRAFFIC* = 0x00000000
  SERVICETYPE_BESTEFFORT* = 0x00000001
  SERVICETYPE_CONTROLLEDLOAD* = 0x00000002
  SERVICETYPE_GUARANTEED* = 0x00000003
  SERVICETYPE_NETWORK_UNAVAILABLE* = 0x00000004
  SERVICETYPE_GENERAL_INFORMATION* = 0x00000005
  SERVICETYPE_NOCHANGE* = 0x00000006
  SERVICETYPE_NONCONFORMING* = 0x00000009
  SERVICETYPE_NETWORK_CONTROL* = 0x0000000A
  SERVICETYPE_QUALITATIVE* = 0x0000000D
  SERVICE_BESTEFFORT* = 0x80010000'i32
  SERVICE_CONTROLLEDLOAD* = 0x80020000'i32
  SERVICE_GUARANTEED* = 0x80040000'i32
  SERVICE_QUALITATIVE* = 0x80200000'i32
  SERVICE_NO_TRAFFIC_CONTROL* = 0x81000000'i32
  SERVICE_NO_QOS_SIGNALING* = 0x40000000
  QOS_NOT_SPECIFIED* = 0xFFFFFFFF'i32
  POSITIVE_INFINITY_RATE* = 0xFFFFFFFE'i32
  QOS_GENERAL_ID_BASE* = 2000
  QOS_OBJECT_END_OF_LIST* = 0x00000001+QOS_GENERAL_ID_BASE
  QOS_OBJECT_SD_MODE* = 0x00000002+QOS_GENERAL_ID_BASE
  QOS_OBJECT_SHAPING_RATE* = 0x00000003+QOS_GENERAL_ID_BASE
  QOS_OBJECT_DESTADDR* = 0x00000004+QOS_GENERAL_ID_BASE
  TC_NONCONF_BORROW* = 0
  TC_NONCONF_SHAPE* = 1
  TC_NONCONF_DISCARD* = 2
  TC_NONCONF_BORROW_PLUS* = 3
  CF_ACCEPT* = 0x0000
  CF_REJECT* = 0x0001
  CF_DEFER* = 0x0002
  SD_RECEIVE* = 0x00
  SD_SEND* = 0x01
  SD_BOTH* = 0x02
  SG_UNCONSTRAINED_GROUP* = 0x01
  SG_CONSTRAINED_GROUP* = 0x02
  BASE_PROTOCOL* = 1
  LAYERED_PROTOCOL* = 0
  PFL_MULTIPLE_PROTO_ENTRIES* = 0x00000001
  PFL_RECOMMENDED_PROTO_ENTRY* = 0x00000002
  PFL_HIDDEN* = 0x00000004
  PFL_MATCHES_PROTOCOL_ZERO* = 0x00000008
  XP1_CONNECTIONLESS* = 0x00000001
  XP1_GUARANTEED_DELIVERY* = 0x00000002
  XP1_GUARANTEED_ORDER* = 0x00000004
  XP1_MESSAGE_ORIENTED* = 0x00000008
  XP1_PSEUDO_STREAM* = 0x00000010
  XP1_GRACEFUL_CLOSE* = 0x00000020
  XP1_EXPEDITED_DATA* = 0x00000040
  XP1_CONNECT_DATA* = 0x00000080
  XP1_DISCONNECT_DATA* = 0x00000100
  XP1_SUPPORT_BROADCAST* = 0x00000200
  XP1_SUPPORT_MULTIPOINT* = 0x00000400
  XP1_MULTIPOINT_CONTROL_PLANE* = 0x00000800
  XP1_MULTIPOINT_DATA_PLANE* = 0x00001000
  XP1_QOS_SUPPORTED* = 0x00002000
  XP1_INTERRUPT* = 0x00004000
  XP1_UNI_SEND* = 0x00008000
  XP1_UNI_RECV* = 0x00010000
  XP1_IFS_HANDLES* = 0x00020000
  XP1_PARTIAL_MESSAGE* = 0x00040000
  BIGENDIAN* = 0x0000
  LITTLEENDIAN* = 0x0001
  SECURITY_PROTOCOL_NONE* = 0x0000
  JL_SENDER_ONLY* = 0x01
  JL_RECEIVER_ONLY* = 0x02
  JL_BOTH* = 0x04
  WSA_FLAG_OVERLAPPED* = 0x01
  WSA_FLAG_MULTIPOINT_C_ROOT* = 0x02
  WSA_FLAG_MULTIPOINT_C_LEAF* = 0x04
  WSA_FLAG_MULTIPOINT_D_ROOT* = 0x08
  WSA_FLAG_MULTIPOINT_D_LEAF* = 0x10
  IOC_UNIX* = 0x00000000
  IOC_WS2* = 0x08000000
  IOC_PROTOCOL* = 0x10000000
  IOC_VENDOR* = 0x18000000
  NSP_NOTIFY_IMMEDIATELY* = 0
  NSP_NOTIFY_HWND* = 1
  NSP_NOTIFY_EVENT* = 2
  NSP_NOTIFY_PORT* = 3
  NSP_NOTIFY_APC* = 4
  TH_NETDEV* = 0x00000001
  TH_TAPI* = 0x00000002
  SERVICE_MULTIPLE* = 0x00000001
  NS_ALL* = 0
  NS_SAP* = 1
  NS_NDS* = 2
  NS_PEER_BROWSE* = 3
  NS_SLP* = 5
  NS_DHCP* = 6
  NS_TCPIP_LOCAL* = 10
  NS_TCPIP_HOSTS* = 11
  NS_DNS* = 12
  NS_NETBT* = 13
  NS_WINS* = 14
  NS_NLA* = 15
  NS_BTH* = 16
  NS_NBP* = 20
  NS_MS* = 30
  NS_STDA* = 31
  NS_NTDS* = 32
  NS_EMAIL* = 37
  NS_PNRPNAME* = 38
  NS_PNRPCLOUD* = 39
  NS_X500* = 40
  NS_NIS* = 41
  NS_NISPLUS* = 42
  NS_WRQ* = 50
  NS_NETDES* = 60
  RES_UNUSED_1* = 0x00000001
  RES_FLUSH_CACHE* = 0x00000002
  RES_SERVICE* = 0x00000004
  SERVICE_TYPE_VALUE_IPXPORTA* = "IpxSocket"
  SERVICE_TYPE_VALUE_IPXPORTW* = "IpxSocket"
  SERVICE_TYPE_VALUE_SAPIDA* = "SapId"
  SERVICE_TYPE_VALUE_SAPIDW* = "SapId"
  SERVICE_TYPE_VALUE_TCPPORTA* = "TcpPort"
  SERVICE_TYPE_VALUE_TCPPORTW* = "TcpPort"
  SERVICE_TYPE_VALUE_UDPPORTA* = "UdpPort"
  SERVICE_TYPE_VALUE_UDPPORTW* = "UdpPort"
  SERVICE_TYPE_VALUE_OBJECTIDA* = "ObjectId"
  SERVICE_TYPE_VALUE_OBJECTIDW* = "ObjectId"
  COMP_EQUAL* = 0
  COMP_NOTLESS* = 1
  LUP_DEEP* = 0x0001
  LUP_CONTAINERS* = 0x0002
  LUP_NOCONTAINERS* = 0x0004
  LUP_NEAREST* = 0x0008
  LUP_RETURN_NAME* = 0x0010
  LUP_RETURN_TYPE* = 0x0020
  LUP_RETURN_VERSION* = 0x0040
  LUP_RETURN_COMMENT* = 0x0080
  LUP_RETURN_ADDR* = 0x0100
  LUP_RETURN_BLOB* = 0x0200
  LUP_RETURN_ALIASES* = 0x0400
  LUP_RETURN_QUERY_STRING* = 0x0800
  LUP_RETURN_ALL* = 0x0FF0
  LUP_RES_SERVICE* = 0x8000
  LUP_FLUSHCACHE* = 0x1000
  LUP_FLUSHPREVIOUS* = 0x2000
  LUP_NON_AUTHORITATIVE* = 0x4000
  LUP_SECURE* = 0x8000
  LUP_RETURN_PREFERRED_NAMES* = 0x10000
  LUP_ADDRCONFIG* = 0x100000
  LUP_DUAL_ADDR* = 0x200000
  LUP_FILESERVER* = 0x400000
  LUP_RES_RESERVICE* = 0x8000
  RESULT_IS_ALIAS* = 0x0001
  RESULT_IS_ADDED* = 0x0010
  RESULT_IS_CHANGED* = 0x0020
  RESULT_IS_DELETED* = 0x0040
  RNRSERVICE_REGISTER* = 0
  RNRSERVICE_DEREGISTER* = 1
  RNRSERVICE_DELETE* = 2
  POLLRDNORM* = 0x0100
  POLLRDBAND* = 0x0200
  POLLIN* = POLLRDNORM or POLLRDBAND
  POLLPRI* = 0x0400
  POLLWRNORM* = 0x0010
  POLLOUT* = POLLWRNORM
  POLLWRBAND* = 0x0020
  POLLERR* = 0x0001
  POLLHUP* = 0x0002
  POLLNVAL* = 0x0004
  MCAST_INCLUDE* = 0
  MCAST_EXCLUDE* = 1
  IPV6_HOPOPTS* = 1
  IPV6_HDRINCL* = 2
  IPV6_UNICAST_HOPS* = 4
  IPV6_MULTICAST_IF* = 9
  IPV6_MULTICAST_HOPS* = 10
  IPV6_MULTICAST_LOOP* = 11
  IPV6_ADD_MEMBERSHIP* = 12
  IPV6_JOIN_GROUP* = IPV6_ADD_MEMBERSHIP
  IPV6_DROP_MEMBERSHIP* = 13
  IPV6_LEAVE_GROUP* = IPV6_DROP_MEMBERSHIP
  IPV6_DONTFRAG* = 14
  IPV6_PKTINFO* = 19
  IPV6_HOPLIMIT* = 21
  IPV6_PROTECTION_LEVEL* = 23
  IPV6_RECVIF* = 24
  IPV6_RECVDSTADDR* = 25
  IPV6_CHECKSUM* = 26
  IPV6_V6ONLY* = 27
  IPV6_IFLIST* = 28
  IPV6_ADD_IFLIST* = 29
  IPV6_DEL_IFLIST* = 30
  IPV6_UNICAST_IF* = 31
  IPV6_RTHDR* = 32
  IPV6_RECVRTHDR* = 38
  IPV6_TCLASS* = 39
  IPV6_RECVTCLASS* = 40
  IP_OPTIONS* = 1
  IP_HDRINCL* = 2
  IP_TOS* = 3
  IP_TTL* = 4
  IP_MULTICAST_IF* = 9
  IP_MULTICAST_TTL* = 10
  IP_MULTICAST_LOOP* = 11
  IP_ADD_MEMBERSHIP* = 12
  IP_DROP_MEMBERSHIP* = 13
  IP_DONTFRAGMENT* = 14
  IP_ADD_SOURCE_MEMBERSHIP* = 15
  IP_DROP_SOURCE_MEMBERSHIP* = 16
  IP_BLOCK_SOURCE* = 17
  IP_UNBLOCK_SOURCE* = 18
  IP_PKTINFO* = 19
  IP_RECEIVE_BROADCAST* = 22
  PROTECTION_LEVEL_UNRESTRICTED* = 10
  PROTECTION_LEVEL_DEFAULT* = 20
  PROTECTION_LEVEL_RESTRICTED* = 30
  UDP_NOCHECKSUM* = 1
  UDP_CHECKSUM_COVERAGE* = 20
  TCP_EXPEDITED_1122* = 0x0002
  IFF_UP* = 0x00000001
  IFF_BROADCAST* = 0x00000002
  IFF_LOOPBACK* = 0x00000004
  IFF_POINTTOPOINT* = 0x00000008
  IFF_MULTICAST* = 0x00000010
  EAI_AGAIN* = WSATRY_AGAIN
  EAI_BADFLAGS* = WSAEINVAL
  EAI_FAIL* = WSANO_RECOVERY
  EAI_FAMILY* = WSAEAFNOSUPPORT
  EAI_MEMORY* = WSA_NOT_ENOUGH_MEMORY
  EAI_NONAME* = WSAHOST_NOT_FOUND
  EAI_SERVICE* = WSATYPE_NOT_FOUND
  EAI_SOCKTYPE* = WSAESOCKTNOSUPPORT
  EAI_NODATA* = 11004
  AI_PASSIVE* = 0x00000001
  AI_CANONNAME* = 0x00000002
  AI_NUMERICHOST* = 0x00000004
  AI_NUMERICSERV* = 0x00000008
  AI_ALL* = 0x00000100
  AI_ADDRCONFIG* = 0x00000400
  AI_V4MAPPED* = 0x00000800
  AI_NON_AUTHORITATIVE* = 0x00004000
  AI_SECURE* = 0x00008000
  AI_RETURN_PREFERRED_NAMES* = 0x00010000
  AI_FQDN* = 0x00020000
  AI_FILESERVER* = 0x00040000
  AI_DISABLE_IDN_ENCODING* = 0x00080000
  GAI_STRERROR_BUFFER_SIZE* = 1024
  NI_MAXHOST* = 1025
  NI_MAXSERV* = 32
  INET_ADDRSTRLEN* = 22
  INET6_ADDRSTRLEN* = 65
  NI_NOFQDN* = 0x01
  NI_NUMERICHOST* = 0x02
  NI_NAMEREQD* = 0x04
  NI_NUMERICSERV* = 0x08
  NI_DGRAM* = 0x10
  RCVALL_OFF* = 0
  RCVALL_ON* = 1
  RCVALL_SOCKETLEVELONLY* = 2
  RCVALL_IPLEVEL* = 3
  SOCKET_SECURITY_PROTOCOL_DEFAULT* = 0
  SOCKET_SECURITY_PROTOCOL_IPSEC* = 1
  SOCKET_SECURITY_PROTOCOL_IPSEC2* = 2
  SOCKET_SECURITY_PROTOCOL_INVALID* = 3
  SOCKET_SETTINGS_GUARANTEE_ENCRYPTION* = 0x1
  SOCKET_SETTINGS_ALLOW_INSECURE* = 0x2
  SYSTEM_CRITICAL_SOCKET* = 1
  SOCKET_INFO_CONNECTION_SECURED* = 0x00000001
  SOCKET_INFO_CONNECTION_ENCRYPTED* = 0x00000002
  SOCKET_INFO_CONNECTION_IMPERSONATED* = 0x00000004
  SOCKET_SETTINGS_IPSEC_SKIP_FILTER_INSTANTIATION* = 0x00000001
  SO_CONNDATA* = 0x7000
  SO_CONNOPT* = 0x7001
  SO_DISCDATA* = 0x7002
  SO_DISCOPT* = 0x7003
  SO_CONNDATALEN* = 0x7004
  SO_CONNOPTLEN* = 0x7005
  SO_DISCDATALEN* = 0x7006
  SO_DISCOPTLEN* = 0x7007
  SO_OPENTYPE* = 0x7008
  SO_SYNCHRONOUS_ALERT* = 0x10
  SO_SYNCHRONOUS_NONALERT* = 0x20
  SO_MAXDG* = 0x7009
  SO_MAXPATHDG* = 0x700A
  SO_UPDATE_ACCEPT_CONTEXT* = 0x700B
  SO_CONNECT_TIME* = 0x700C
  SO_UPDATE_CONNECT_CONTEXT* = 0x7010
  TCP_BSDURGENT* = 0x7000
  TF_DISCONNECT* = 0x01
  TF_REUSE_SOCKET* = 0x02
  TF_WRITE_BEHIND* = 0x04
  TF_USE_DEFAULT_WORKER* = 0x00
  TF_USE_SYSTEM_THREAD* = 0x10
  TF_USE_KERNEL_APC* = 0x20
  TP_DISCONNECT* = TF_DISCONNECT
  TP_REUSE_SOCKET* = TF_REUSE_SOCKET
  TP_USE_DEFAULT_WORKER* = TF_USE_DEFAULT_WORKER
  TP_USE_SYSTEM_THREAD* = TF_USE_SYSTEM_THREAD
  TP_USE_KERNEL_APC* = TF_USE_KERNEL_APC
  DE_REUSE_SOCKET* = TF_REUSE_SOCKET
  NLA_ALLUSERS_NETWORK* = 0x00000001
  NLA_FRIENDLY_NAME* = 0x00000002
  NLA_RAW_DATA* = 0
  NLA_INTERFACE* = 1
  NLA_802_1X_LOCATION* = 2
  NLA_CONNECTIVITY* = 3
  NLA_ICS* = 4
  NLA_NETWORK_AD_HOC* = 0
  NLA_NETWORK_MANAGED* = 1
  NLA_NETWORK_UNMANAGED* = 2
  NLA_NETWORK_UNKNOWN* = 3
  NLA_INTERNET_UNKNOWN* = 0
  NLA_INTERNET_NO* = 1
  NLA_INTERNET_YES* = 2
  MSG_TRUNC* = 0x0100
  MSG_CTRUNC* = 0x0200
  MSG_BCAST* = 0x0400
  MSG_MCAST* = 0x0800
  FIOASYNC* = 0x8004667D'i32
  FIONBIO* = 0x8004667E'i32
  FIONREAD* = 0x4004667F
  SIOCATMARK* = 0x40047307
  SIOCGHIWAT* = 0x40047301
  SIOCGLOWAT* = 0x40047303
  SIOCSHIWAT* = 0x80047300'i32
  SIOCSLOWAT* = 0x80047302'i32
  SO_DONTLINGER* = -129
  SO_EXCLUSIVEADDRUSE* = -5
  SIO_GET_INTERFACE_LIST* = 0x4004747F
  SIO_GET_INTERFACE_LIST_EX* = 0x4004747E
  SIO_GET_MULTICAST_FILTER* = 0x8004747C'i32
  SIO_SET_MULTICAST_FILTER* = 0x8004747D'i32
  SIO_ASSOCIATE_HANDLE* = 0x88000001'i32
  SIO_ENABLE_CIRCULAR_QUEUEING* = 0x28000002
  SIO_FIND_ROUTE* = 0x48000003
  SIO_FLUSH* = 0x28000004
  SIO_GET_BROADCAST_ADDRESS* = 0x48000005
  SIO_GET_EXTENSION_FUNCTION_POINTER* = 0xC8000006'i32
  SIO_GET_QOS* = 0xC8000007'i32
  SIO_GET_GROUP_QOS* = 0xC8000008'i32
  SIO_MULTIPOINT_LOOPBACK* = 0x88000009'i32
  SIO_MULTICAST_SCOPE* = 0x8800000A'i32
  SIO_SET_QOS* = 0x8800000B'i32
  SIO_SET_GROUP_QOS* = 0x8800000C'i32
  SIO_TRANSLATE_HANDLE* = 0xC800000D'i32
  SIO_ROUTING_INTERFACE_QUERY* = 0xC8000014'i32
  SIO_ROUTING_INTERFACE_CHANGE* = 0x88000015'i32
  SIO_ADDRESS_LIST_QUERY* = 0x48000016
  SIO_ADDRESS_LIST_CHANGE* = 0x28000017
  SIO_QUERY_TARGET_PNP_HANDLE* = 0x48000018
  SIO_ADDRESS_LIST_SORT* = 0xC8000019'i32
  SIO_NSP_NOTIFY_CHANGE* = 0x88000019'i32
  SIO_RCVALL* = 0x98000001'i32
  SIO_RCVALL_MCAST* = 0x98000002'i32
  SIO_RCVALL_IGMPMCAST* = 0x98000003'i32
  SIO_KEEPALIVE_VALS* = 0x98000004'i32
  SIO_ABSORB_RTRALERT* = 0x98000005'i32
  SIO_UCAST_IF* = 0x98000006'i32
  SIO_LIMIT_BROADCASTS* = 0x98000007'i32
  SIO_INDEX_BIND* = 0x98000008'i32
  SIO_INDEX_MCASTIF* = 0x98000009'i32
  SIO_INDEX_ADD_MCAST* = 0x9800000A'i32
  SIO_INDEX_DEL_MCAST* = 0x9800000B'i32
  SIO_UDP_CONNRESET* = 0x9800000c'i32
  SIO_SOCKET_CLOSE_NOTIFY* = 0x9800000d'i32
  SIO_BSP_HANDLE* = 0x4800001b'i32
  SIO_BSP_HANDLE_SELECT* = 0x4800001c'i32
  SIO_BSP_HANDLE_POLL* = 0x4800001d'i32
  SIO_EXT_SELECT* = 0xc800001e'i32
  SIO_EXT_POLL* = 0xc800001f'i32
  SIO_EXT_SENDMSG* = 0xc8000020'i32
  SIO_BASE_HANDLE* = 0x48000022'i32
  INVALID_SOCKET* = SOCKET(-1)
  WSA_INVALID_EVENT* = WSAEVENT 0
  IN6ADDR_ANY_INIT* = IN6_ADDR(Byte: [0'u8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
  IN6ADDR_LOOPBACK_INIT* = IN6_ADDR(Byte: [0'u8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1])
  WSAID_TRANSMITFILE* = DEFINE_GUID(0xb5367df0'i32, 0xcbac, 0x11cf, [0x95'u8, 0xca, 0x00, 0x80, 0x5f, 0x48, 0xa1, 0x92])
  WSAID_ACCEPTEX* = DEFINE_GUID(0xb5367df1'i32, 0xcbac, 0x11cf, [0x95'u8, 0xca, 0x00, 0x80, 0x5f, 0x48, 0xa1, 0x92])
  WSAID_GETACCEPTEXSOCKADDRS* = DEFINE_GUID(0xb5367df2'i32, 0xcbac, 0x11cf, [0x95'u8, 0xca, 0x00, 0x80, 0x5f, 0x48, 0xa1, 0x92])
  WSAID_TRANSMITPACKETS* = DEFINE_GUID(0xd9689da0'i32, 0x1f90, 0x11d3, [0x99'u8, 0x71, 0x00, 0xc0, 0x4f, 0x68, 0xc8, 0x76])
  WSAID_CONNECTEX* = DEFINE_GUID(0x25a207b9'i32, 0xddf3, 0x4660, [0x8e'u8, 0xe9, 0x76, 0xe5, 0x8c, 0x74, 0x06, 0x3e])
  WSAID_DISCONNECTEX* = DEFINE_GUID(0x7fda2e11'i32, 0x8630, 0x436f, [0xa0'u8, 0x31, 0xf5, 0x36, 0xa6, 0xee, 0xc1, 0x57])
  NLA_NAMESPACE_GUID* = DEFINE_GUID(0x6642243a'i32, 0x3ba8, 0x4aa6, [0xba'u8, 0xa5, 0x2e, 0xb, 0xd7, 0x1f, 0xdd, 0x83])
  NLA_SERVICE_CLASS_GUID* = DEFINE_GUID(0x37e515'i32, 0xb5c9, 0x4a43, [0xba'u8, 0xda, 0x8b, 0x48, 0xa8, 0x7a, 0xd2, 0x39])
  WSAID_WSARECVMSG* = DEFINE_GUID(0xf689d7c8'i32, 0x6f1f, 0x436b, [0x8a'u8, 0x53, 0xe5, 0x4f, 0xe3, 0x51, 0xc3, 0x22])
  WSAID_WSAPOLL* = DEFINE_GUID(0x18C76F85'i32, 0xDC66, 0x4964, [0x97'u8, 0x2E, 0x23, 0xC2, 0x72, 0x38, 0x31, 0x2B])
  WSAID_WSASENDMSG* = DEFINE_GUID(0xa441e712'i32, 0x754f, 0x43ca, [0x84'u8, 0xa7, 0x0d, 0xee, 0x44, 0xcf, 0x60, 0x6d])
type
  LPCONDITIONPROC* = proc (lpCallerId: LPWSABUF, lpCallerData: LPWSABUF, lpSQOS: LPQOS, lpGQOS: LPQOS, lpCalleeId: LPWSABUF, lpCalleeData: LPWSABUF, g: ptr GROUP, dwCallbackData: DWORD_PTR): int32 {.stdcall.}
  LPFN_ACCEPT* = proc (s: SOCKET, `addr`: ptr sockaddr, addrlen: ptr int32): SOCKET {.stdcall.}
  LPFN_BIND* = proc (s: SOCKET, name: ptr sockaddr, namelen: int32): int32 {.stdcall.}
  LPFN_CLOSESOCKET* = proc (s: SOCKET): int32 {.stdcall.}
  LPFN_CONNECT* = proc (s: SOCKET, name: ptr sockaddr, namelen: int32): int32 {.stdcall.}
  LPFN_IOCTLSOCKET* = proc (s: SOCKET, cmd: int32, argp: ptr int32): int32 {.stdcall.}
  LPFN_GETPEERNAME* = proc (s: SOCKET, name: ptr sockaddr, namelen: ptr int32): int32 {.stdcall.}
  LPFN_GETSOCKNAME* = proc (s: SOCKET, name: ptr sockaddr, namelen: ptr int32): int32 {.stdcall.}
  LPFN_GETSOCKOPT* = proc (s: SOCKET, level: int32, optname: int32, optval: ptr char, optlen: ptr int32): int32 {.stdcall.}
  LPFN_HTONL* = proc (hostlong: int32): int32 {.stdcall.}
  LPFN_HTONS* = proc (hostshort: uint16): uint16 {.stdcall.}
  LPFN_INET_ADDR* = proc (cp: ptr char): int32 {.stdcall.}
  LPFN_INET_NTOA* = proc (`in`: IN_ADDR): ptr char {.stdcall.}
  LPFN_LISTEN* = proc (s: SOCKET, backlog: int32): int32 {.stdcall.}
  LPFN_NTOHL* = proc (netlong: int32): int32 {.stdcall.}
  LPFN_NTOHS* = proc (netshort: uint16): uint16 {.stdcall.}
  LPFN_RECV* = proc (s: SOCKET, buf: ptr char, len: int32, flags: int32): int32 {.stdcall.}
  LPFN_RECVFROM* = proc (s: SOCKET, buf: ptr char, len: int32, flags: int32, `from`: ptr sockaddr, fromlen: ptr int32): int32 {.stdcall.}
  LPFN_SELECT* = proc (nfds: int32, readfds: ptr fd_set, writefds: ptr fd_set, exceptfds: ptr fd_set, timeout: PTIMEVAL): int32 {.stdcall.}
  LPFN_SEND* = proc (s: SOCKET, buf: ptr char, len: int32, flags: int32): int32 {.stdcall.}
  LPFN_SENDTO* = proc (s: SOCKET, buf: ptr char, len: int32, flags: int32, to: ptr sockaddr, tolen: int32): int32 {.stdcall.}
  LPFN_SETSOCKOPT* = proc (s: SOCKET, level: int32, optname: int32, optval: ptr char, optlen: int32): int32 {.stdcall.}
  LPFN_SHUTDOWN* = proc (s: SOCKET, how: int32): int32 {.stdcall.}
  LPFN_SOCKET* = proc (af: int32, `type`: int32, protocol: int32): SOCKET {.stdcall.}
  LPFN_GETHOSTBYADDR* = proc (`addr`: ptr char, len: int32, `type`: int32): ptr hostent {.stdcall.}
  LPFN_GETHOSTBYNAME* = proc (name: ptr char): ptr hostent {.stdcall.}
  LPFN_GETHOSTNAME* = proc (name: ptr char, namelen: int32): int32 {.stdcall.}
  LPFN_GETSERVBYPORT* = proc (port: int32, proto: ptr char): ptr servent {.stdcall.}
  LPFN_GETSERVBYNAME* = proc (name: ptr char, proto: ptr char): ptr servent {.stdcall.}
  LPFN_GETPROTOBYNUMBER* = proc (number: int32): ptr protoent {.stdcall.}
  LPFN_GETPROTOBYNAME* = proc (name: ptr char): ptr protoent {.stdcall.}
  LPFN_WSASTARTUP* = proc (wVersionRequested: WORD, lpWSAData: LPWSADATA): int32 {.stdcall.}
  LPFN_WSACLEANUP* = proc (): int32 {.stdcall.}
  LPFN_WSASETLASTERROR* = proc (iError: int32): void {.stdcall.}
  LPFN_WSAGETLASTERROR* = proc (): int32 {.stdcall.}
  LPFN_WSAISBLOCKING* = proc (): WINBOOL {.stdcall.}
  LPFN_WSAUNHOOKBLOCKINGHOOK* = proc (): int32 {.stdcall.}
  LPFN_WSASETBLOCKINGHOOK* = proc (lpBlockFunc: FARPROC): FARPROC {.stdcall.}
  LPFN_WSACANCELBLOCKINGCALL* = proc (): int32 {.stdcall.}
  LPFN_WSAASYNCGETSERVBYNAME* = proc (hWnd: HWND, wMsg: int32, name: ptr char, proto: ptr char, buf: ptr char, buflen: int32): HANDLE {.stdcall.}
  LPFN_WSAASYNCGETSERVBYPORT* = proc (hWnd: HWND, wMsg: int32, port: int32, proto: ptr char, buf: ptr char, buflen: int32): HANDLE {.stdcall.}
  LPFN_WSAASYNCGETPROTOBYNAME* = proc (hWnd: HWND, wMsg: int32, name: ptr char, buf: ptr char, buflen: int32): HANDLE {.stdcall.}
  LPFN_WSAASYNCGETPROTOBYNUMBER* = proc (hWnd: HWND, wMsg: int32, number: int32, buf: ptr char, buflen: int32): HANDLE {.stdcall.}
  LPFN_WSAASYNCGETHOSTBYNAME* = proc (hWnd: HWND, wMsg: int32, name: ptr char, buf: ptr char, buflen: int32): HANDLE {.stdcall.}
  LPFN_WSAASYNCGETHOSTBYADDR* = proc (hWnd: HWND, wMsg: int32, `addr`: ptr char, len: int32, `type`: int32, buf: ptr char, buflen: int32): HANDLE {.stdcall.}
  LPFN_WSACANCELASYNCREQUEST* = proc (hAsyncTaskHandle: HANDLE): int32 {.stdcall.}
  LPFN_WSAASYNCSELECT* = proc (s: SOCKET, hWnd: HWND, wMsg: int32, lEvent: int32): int32 {.stdcall.}
  LPFN_WSAACCEPT* = proc (s: SOCKET, `addr`: ptr sockaddr, addrlen: LPINT, lpfnCondition: LPCONDITIONPROC, dwCallbackData: DWORD_PTR): SOCKET {.stdcall.}
  LPFN_WSACLOSEEVENT* = proc (hEvent: WSAEVENT): WINBOOL {.stdcall.}
  LPFN_WSACONNECT* = proc (s: SOCKET, name: ptr sockaddr, namelen: int32, lpCallerData: LPWSABUF, lpCalleeData: LPWSABUF, lpSQOS: LPQOS, lpGQOS: LPQOS): int32 {.stdcall.}
  LPFN_WSACREATEEVENT* = proc (): WSAEVENT {.stdcall.}
  LPFN_WSADUPLICATESOCKETA* = proc (s: SOCKET, dwProcessId: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOA): int32 {.stdcall.}
  LPFN_WSADUPLICATESOCKETW* = proc (s: SOCKET, dwProcessId: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOW): int32 {.stdcall.}
  LPFN_WSAENUMNETWORKEVENTS* = proc (s: SOCKET, hEventObject: WSAEVENT, lpNetworkEvents: LPWSANETWORKEVENTS): int32 {.stdcall.}
  LPFN_WSAENUMPROTOCOLSA* = proc (lpiProtocols: LPINT, lpProtocolBuffer: LPWSAPROTOCOL_INFOA, lpdwBufferLength: LPDWORD): int32 {.stdcall.}
  LPFN_WSAENUMPROTOCOLSW* = proc (lpiProtocols: LPINT, lpProtocolBuffer: LPWSAPROTOCOL_INFOW, lpdwBufferLength: LPDWORD): int32 {.stdcall.}
  LPFN_WSAEVENTSELECT* = proc (s: SOCKET, hEventObject: WSAEVENT, lNetworkEvents: int32): int32 {.stdcall.}
  LPFN_WSAGETOVERLAPPEDRESULT* = proc (s: SOCKET, lpOverlapped: LPWSAOVERLAPPED, lpcbTransfer: LPDWORD, fWait: WINBOOL, lpdwFlags: LPDWORD): WINBOOL {.stdcall.}
  LPFN_WSAGETQOSBYNAME* = proc (s: SOCKET, lpQOSName: LPWSABUF, lpQOS: LPQOS): WINBOOL {.stdcall.}
  LPFN_WSAHTONL* = proc (s: SOCKET, hostlong: int32, lpnetlong: ptr int32): int32 {.stdcall.}
  LPFN_WSAHTONS* = proc (s: SOCKET, hostshort: uint16, lpnetshort: ptr uint16): int32 {.stdcall.}
  LPFN_WSAIOCTL* = proc (s: SOCKET, dwIoControlCode: DWORD, lpvInBuffer: LPVOID, cbInBuffer: DWORD, lpvOutBuffer: LPVOID, cbOutBuffer: DWORD, lpcbBytesReturned: LPDWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.stdcall.}
  LPFN_WSAJOINLEAF* = proc (s: SOCKET, name: ptr sockaddr, namelen: int32, lpCallerData: LPWSABUF, lpCalleeData: LPWSABUF, lpSQOS: LPQOS, lpGQOS: LPQOS, dwFlags: DWORD): SOCKET {.stdcall.}
  LPFN_WSANTOHL* = proc (s: SOCKET, netlong: int32, lphostlong: ptr int32): int32 {.stdcall.}
  LPFN_WSANTOHS* = proc (s: SOCKET, netshort: uint16, lphostshort: ptr uint16): int32 {.stdcall.}
  LPFN_WSARECV* = proc (s: SOCKET, lpBuffers: LPWSABUF, dwBufferCount: DWORD, lpNumberOfBytesRecvd: LPDWORD, lpFlags: LPDWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.stdcall.}
  LPFN_WSARECVDISCONNECT* = proc (s: SOCKET, lpInboundDisconnectData: LPWSABUF): int32 {.stdcall.}
  LPFN_WSARECVFROM* = proc (s: SOCKET, lpBuffers: LPWSABUF, dwBufferCount: DWORD, lpNumberOfBytesRecvd: LPDWORD, lpFlags: LPDWORD, lpFrom: ptr sockaddr, lpFromlen: LPINT, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.stdcall.}
  LPFN_WSARESETEVENT* = proc (hEvent: WSAEVENT): WINBOOL {.stdcall.}
  LPFN_WSASEND* = proc (s: SOCKET, lpBuffers: LPWSABUF, dwBufferCount: DWORD, lpNumberOfBytesSent: LPDWORD, dwFlags: DWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.stdcall.}
  LPFN_WSASENDDISCONNECT* = proc (s: SOCKET, lpOutboundDisconnectData: LPWSABUF): int32 {.stdcall.}
  LPFN_WSASENDTO* = proc (s: SOCKET, lpBuffers: LPWSABUF, dwBufferCount: DWORD, lpNumberOfBytesSent: LPDWORD, dwFlags: DWORD, lpTo: ptr sockaddr, iTolen: int32, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.stdcall.}
  LPFN_WSASETEVENT* = proc (hEvent: WSAEVENT): WINBOOL {.stdcall.}
  LPFN_WSASOCKETA* = proc (af: int32, `type`: int32, protocol: int32, lpProtocolInfo: LPWSAPROTOCOL_INFOA, g: GROUP, dwFlags: DWORD): SOCKET {.stdcall.}
  LPFN_WSASOCKETW* = proc (af: int32, `type`: int32, protocol: int32, lpProtocolInfo: LPWSAPROTOCOL_INFOW, g: GROUP, dwFlags: DWORD): SOCKET {.stdcall.}
  LPFN_WSAWAITFORMULTIPLEEVENTS* = proc (cEvents: DWORD, lphEvents: ptr WSAEVENT, fWaitAll: WINBOOL, dwTimeout: DWORD, fAlertable: WINBOOL): DWORD {.stdcall.}
  LPFN_WSAADDRESSTOSTRINGA* = proc (lpsaAddress: LPSOCKADDR, dwAddressLength: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOA, lpszAddressString: LPSTR, lpdwAddressStringLength: LPDWORD): INT {.stdcall.}
  LPFN_WSAADDRESSTOSTRINGW* = proc (lpsaAddress: LPSOCKADDR, dwAddressLength: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOW, lpszAddressString: LPWSTR, lpdwAddressStringLength: LPDWORD): INT {.stdcall.}
  LPFN_WSASTRINGTOADDRESSA* = proc (AddressString: LPSTR, AddressFamily: INT, lpProtocolInfo: LPWSAPROTOCOL_INFOA, lpAddress: LPSOCKADDR, lpAddressLength: LPINT): INT {.stdcall.}
  LPFN_WSASTRINGTOADDRESSW* = proc (AddressString: LPWSTR, AddressFamily: INT, lpProtocolInfo: LPWSAPROTOCOL_INFOW, lpAddress: LPSOCKADDR, lpAddressLength: LPINT): INT {.stdcall.}
  LPFN_WSALOOKUPSERVICEBEGINA* = proc (lpqsRestrictions: LPWSAQUERYSETA, dwControlFlags: DWORD, lphLookup: LPHANDLE): INT {.stdcall.}
  LPFN_WSALOOKUPSERVICEBEGINW* = proc (lpqsRestrictions: LPWSAQUERYSETW, dwControlFlags: DWORD, lphLookup: LPHANDLE): INT {.stdcall.}
  LPFN_WSALOOKUPSERVICENEXTA* = proc (hLookup: HANDLE, dwControlFlags: DWORD, lpdwBufferLength: LPDWORD, lpqsResults: LPWSAQUERYSETA): INT {.stdcall.}
  LPFN_WSALOOKUPSERVICENEXTW* = proc (hLookup: HANDLE, dwControlFlags: DWORD, lpdwBufferLength: LPDWORD, lpqsResults: LPWSAQUERYSETW): INT {.stdcall.}
  LPFN_WSANSPIOCTL* = proc (hLookup: HANDLE, dwControlCode: DWORD, lpvInBuffer: LPVOID, cbInBuffer: DWORD, lpvOutBuffer: LPVOID, cbOutBuffer: DWORD, lpcbBytesReturned: LPDWORD, lpCompletion: LPWSACOMPLETION): INT {.stdcall.}
  LPFN_WSALOOKUPSERVICEEND* = proc (hLookup: HANDLE): INT {.stdcall.}
  LPFN_WSAINSTALLSERVICECLASSA* = proc (lpServiceClassInfo: LPWSASERVICECLASSINFOA): INT {.stdcall.}
  LPFN_WSAINSTALLSERVICECLASSW* = proc (lpServiceClassInfo: LPWSASERVICECLASSINFOW): INT {.stdcall.}
  LPFN_WSAREMOVESERVICECLASS* = proc (lpServiceClassId: LPGUID): INT {.stdcall.}
  LPFN_WSAGETSERVICECLASSINFOA* = proc (lpProviderId: LPGUID, lpServiceClassId: LPGUID, lpdwBufSize: LPDWORD, lpServiceClassInfo: LPWSASERVICECLASSINFOA): INT {.stdcall.}
  LPFN_WSAGETSERVICECLASSINFOW* = proc (lpProviderId: LPGUID, lpServiceClassId: LPGUID, lpdwBufSize: LPDWORD, lpServiceClassInfo: LPWSASERVICECLASSINFOW): INT {.stdcall.}
  LPFN_WSAENUMNAMESPACEPROVIDERSA* = proc (lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOA): INT {.stdcall.}
  LPFN_WSAENUMNAMESPACEPROVIDERSW* = proc (lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOW): INT {.stdcall.}
  LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDA* = proc (lpServiceClassId: LPGUID, lpszServiceClassName: LPSTR, lpdwBufferLength: LPDWORD): INT {.stdcall.}
  LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDW* = proc (lpServiceClassId: LPGUID, lpszServiceClassName: LPWSTR, lpdwBufferLength: LPDWORD): INT {.stdcall.}
  LPFN_WSASETSERVICEA* = proc (lpqsRegInfo: LPWSAQUERYSETA, essoperation: WSAESETSERVICEOP, dwControlFlags: DWORD): INT {.stdcall.}
  LPFN_WSASETSERVICEW* = proc (lpqsRegInfo: LPWSAQUERYSETW, essoperation: WSAESETSERVICEOP, dwControlFlags: DWORD): INT {.stdcall.}
  LPFN_WSAPROVIDERCONFIGCHANGE* = proc (lpNotificationHandle: LPHANDLE, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): INT {.stdcall.}
  LPFN_GETADDRINFOW* = proc (pNodeName: PCWSTR, pServiceName: PCWSTR, pHints: ptr ADDRINFOW, ppResult: ptr PADDRINFOW): int32 {.stdcall.}
  LPFN_FREEADDRINFOW* = proc (pAddrInfo: PADDRINFOW): void {.stdcall.}
  LPFN_GETNAMEINFOW* = proc (pSockaddr: ptr SOCKADDR, SockaddrLength: socklen_t, pNodeBuffer: PWCHAR, NodeBufferSize: DWORD, pServiceBuffer: PWCHAR, ServiceBufferSize: DWORD, Flags: INT): INT {.stdcall.}
  LPFN_GETADDRINFOEXA* = proc (pName: PCSTR, pServiceName: PCSTR, dwNameSpace: DWORD, lpNspId: LPGUID, pHints: ptr ADDRINFOEXA, ppResult: ptr PADDRINFOEXA, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.stdcall.}
  LPFN_GETADDRINFOEXW* = proc (pName: PCWSTR, pServiceName: PCWSTR, dwNameSpace: DWORD, lpNspId: LPGUID, pHints: ptr ADDRINFOEXW, ppResult: ptr PADDRINFOEXW, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.stdcall.}
  LPFN_SETADDRINFOEXA* = proc (pName: PCSTR, pServiceName: PCSTR, pAddresses: ptr SOCKET_ADDRESS, dwAddressCount: DWORD, lpBlob: LPBLOB, dwFlags: DWORD, dwNameSpace: DWORD, lpNspId: LPGUID, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.stdcall.}
  LPFN_SETADDRINFOEXW* = proc (pName: PCWSTR, pServiceName: PCWSTR, pAddresses: ptr SOCKET_ADDRESS, dwAddressCount: DWORD, lpBlob: LPBLOB, dwFlags: DWORD, dwNameSpace: DWORD, lpNspId: LPGUID, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.stdcall.}
  LPFN_FREEADDRINFOEXA* = proc (pAddrInfo: PADDRINFOEXA): void {.stdcall.}
  LPFN_FREEADDRINFOEXW* = proc (pAddrInfo: PADDRINFOEXW): void {.stdcall.}
  LPFN_TRANSMITFILE* = proc (hSocket: SOCKET, hFile: HANDLE, nNumberOfBytesToWrite: DWORD, nNumberOfBytesPerSend: DWORD, lpOverlapped: LPOVERLAPPED, lpTransmitBuffers: LPTRANSMIT_FILE_BUFFERS, dwReserved: DWORD): WINBOOL {.stdcall.}
  LPFN_ACCEPTEX* = proc (sListenSocket: SOCKET, sAcceptSocket: SOCKET, lpOutputBuffer: PVOID, dwReceiveDataLength: DWORD, dwLocalAddressLength: DWORD, dwRemoteAddressLength: DWORD, lpdwBytesReceived: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.stdcall.}
  LPFN_GETACCEPTEXSOCKADDRS* = proc (lpOutputBuffer: PVOID, dwReceiveDataLength: DWORD, dwLocalAddressLength: DWORD, dwRemoteAddressLength: DWORD, LocalSockaddr: ptr ptr sockaddr, LocalSockaddrLength: LPINT, RemoteSockaddr: ptr ptr sockaddr, RemoteSockaddrLength: LPINT): VOID {.stdcall.}
  LPFN_TRANSMITPACKETS* = proc (hSocket: SOCKET, lpPacketArray: LPTRANSMIT_PACKETS_ELEMENT, nElementCount: DWORD, nSendSize: DWORD, lpOverlapped: LPOVERLAPPED, dwFlags: DWORD): WINBOOL {.stdcall.}
  LPFN_CONNECTEX* = proc (s: SOCKET, name: ptr sockaddr, namelen: int32, lpSendBuffer: PVOID, dwSendDataLength: DWORD, lpdwBytesSent: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.stdcall.}
  LPFN_DISCONNECTEX* = proc (s: SOCKET, lpOverlapped: LPOVERLAPPED, dwFlags: DWORD, dwReserved: DWORD): WINBOOL {.stdcall.}
  LPFN_WSARECVMSG* = proc (s: SOCKET, lpMsg: LPWSAMSG, lpdwNumberOfBytesRecvd: LPDWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): INT {.stdcall.}
  LPFN_WSAPOLL* = proc (fdarray: LPWSAPOLLFD, nfds: ULONG, timeout: INT): INT {.stdcall.}
  LPFN_WSASENDMSG* = proc (s: SOCKET, lpMsg: LPWSAMSG, dwFlags: DWORD, lpNumberOfBytesSent: LPDWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): INT {.stdcall.}
  netent* {.pure.} = object
    n_name*: ptr char
    n_aliases*: ptr ptr char
    n_addrtype*: int16
    n_net*: int32
  sockproto* {.pure.} = object
    sp_family*: uint16
    sp_protocol*: uint16
  IPV6_MREQ* {.pure.} = object
    ipv6mr_multiaddr*: IN6_ADDR
    ipv6mr_interface*: int32
  ip_mreq* {.pure.} = object
    imr_multiaddr*: IN_ADDR
    imr_interface*: IN_ADDR
  ip_mreq_source* {.pure.} = object
    imr_multiaddr*: IN_ADDR
    imr_sourceaddr*: IN_ADDR
    imr_interface*: IN_ADDR
  ip_msfilter* {.pure.} = object
    imsf_multiaddr*: IN_ADDR
    imsf_interface*: IN_ADDR
    imsf_fmode*: int32
    imsf_numsrc*: int32
    imsf_slist*: array[1, IN_ADDR]
  IN_PKTINFO* {.pure.} = object
    ipi_addr*: IN_ADDR
    ipi_ifindex*: UINT
  IN6_PKTINFO* {.pure.} = object
    ipi6_addr*: IN6_ADDR
    ipi6_ifindex*: UINT
  tcp_keepalive* {.pure.} = object
    onoff*: int32
    keepalivetime*: int32
    keepaliveinterval*: int32
  SOCKET_PEER_TARGET_NAME* {.pure.} = object
    SecurityProtocol*: SOCKET_SECURITY_PROTOCOL
    PeerAddress*: SOCKADDR_STORAGE
    PeerTargetNameStringLen*: ULONG
    AllStrings*: UncheckedArray[uint16]
  SOCKET_SECURITY_QUERY_INFO* {.pure.} = object
    SecurityProtocol*: SOCKET_SECURITY_PROTOCOL
    Flags*: ULONG
    PeerApplicationAccessTokenHandle*: UINT64
    PeerMachineAccessTokenHandle*: UINT64
  SOCKET_SECURITY_QUERY_TEMPLATE* {.pure.} = object
    SecurityProtocol*: SOCKET_SECURITY_PROTOCOL
    PeerAddress*: SOCKADDR_STORAGE
    PeerTokenAccessMask*: ULONG
  SOCKET_SECURITY_SETTINGS* {.pure.} = object
    SecurityProtocol*: SOCKET_SECURITY_PROTOCOL
    SecurityFlags*: ULONG
  SOCKET_SECURITY_SETTINGS_IPSEC* {.pure.} = object
    SecurityProtocol*: SOCKET_SECURITY_PROTOCOL
    SecurityFlags*: ULONG
    IpsecFlags*: ULONG
    AuthipMMPolicyKey*: GUID
    AuthipQMPolicyKey*: GUID
    Reserved*: GUID
    Reserved2*: UINT64
    UserNameStringLen*: ULONG
    DomainNameStringLen*: ULONG
    PasswordStringLen*: ULONG
    AllStrings*: UncheckedArray[uint16]
proc WSAFDIsSet*(P1: SOCKET, P2: ptr fd_set): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "__WSAFDIsSet".}
proc accept*(s: SOCKET, `addr`: ptr sockaddr, addrlen: ptr int32): SOCKET {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc `bind`*(s: SOCKET, name: ptr sockaddr, namelen: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc closesocket*(s: SOCKET): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc connect*(s: SOCKET, name: ptr sockaddr, namelen: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc ioctlsocket*(s: SOCKET, cmd: int32, argp: ptr int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc getpeername*(s: SOCKET, name: ptr sockaddr, namelen: ptr int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc getsockname*(s: SOCKET, name: ptr sockaddr, namelen: ptr int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc getsockopt*(s: SOCKET, level: int32, optname: int32, optval: ptr char, optlen: ptr int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc htonl*(hostlong: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc htons*(hostshort: uint16): uint16 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc inet_addr*(cp: ptr char): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc inet_ntoa*(`in`: IN_ADDR): ptr char {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc listen*(s: SOCKET, backlog: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc ntohl*(netlong: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc ntohs*(netshort: uint16): uint16 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc recv*(s: SOCKET, buf: ptr char, len: int32, flags: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc recvfrom*(s: SOCKET, buf: ptr char, len: int32, flags: int32, `from`: ptr sockaddr, fromlen: ptr int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc select*(nfds: int32, readfds: ptr fd_set, writefds: ptr fd_set, exceptfds: ptr fd_set, timeout: PTIMEVAL): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc send*(s: SOCKET, buf: ptr char, len: int32, flags: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc sendto*(s: SOCKET, buf: ptr char, len: int32, flags: int32, to: ptr sockaddr, tolen: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc setsockopt*(s: SOCKET, level: int32, optname: int32, optval: ptr char, optlen: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc shutdown*(s: SOCKET, how: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc socket*(af: int32, `type`: int32, protocol: int32): SOCKET {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc gethostbyaddr*(`addr`: ptr char, len: int32, `type`: int32): ptr hostent {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc gethostbyname*(name: ptr char): ptr hostent {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc gethostname*(name: ptr char, namelen: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc getservbyport*(port: int32, proto: ptr char): ptr servent {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc getservbyname*(name: ptr char, proto: ptr char): ptr servent {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc getprotobynumber*(number: int32): ptr protoent {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc getprotobyname*(name: ptr char): ptr protoent {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAStartup*(wVersionRequested: WORD, lpWSAData: LPWSADATA): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSACleanup*(): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASetLastError*(iError: int32): void {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAGetLastError*(): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAIsBlocking*(): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAUnhookBlockingHook*(): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASetBlockingHook*(lpBlockFunc: FARPROC): FARPROC {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSACancelBlockingCall*(): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAsyncGetServByName*(hWnd: HWND, wMsg: int32, name: ptr char, proto: ptr char, buf: ptr char, buflen: int32): HANDLE {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAsyncGetServByPort*(hWnd: HWND, wMsg: int32, port: int32, proto: ptr char, buf: ptr char, buflen: int32): HANDLE {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAsyncGetProtoByName*(hWnd: HWND, wMsg: int32, name: ptr char, buf: ptr char, buflen: int32): HANDLE {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAsyncGetProtoByNumber*(hWnd: HWND, wMsg: int32, number: int32, buf: ptr char, buflen: int32): HANDLE {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAsyncGetHostByName*(hWnd: HWND, wMsg: int32, name: ptr char, buf: ptr char, buflen: int32): HANDLE {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAsyncGetHostByAddr*(hWnd: HWND, wMsg: int32, `addr`: ptr char, len: int32, `type`: int32, buf: ptr char, buflen: int32): HANDLE {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSACancelAsyncRequest*(hAsyncTaskHandle: HANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAsyncSelect*(s: SOCKET, hWnd: HWND, wMsg: int32, lEvent: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAccept*(s: SOCKET, `addr`: ptr sockaddr, addrlen: LPINT, lpfnCondition: LPCONDITIONPROC, dwCallbackData: DWORD_PTR): SOCKET {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSACloseEvent*(hEvent: WSAEVENT): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAConnect*(s: SOCKET, name: ptr sockaddr, namelen: int32, lpCallerData: LPWSABUF, lpCalleeData: LPWSABUF, lpSQOS: LPQOS, lpGQOS: LPQOS): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSACreateEvent*(): WSAEVENT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSADuplicateSocketA*(s: SOCKET, dwProcessId: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOA): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSADuplicateSocketW*(s: SOCKET, dwProcessId: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOW): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAEnumNetworkEvents*(s: SOCKET, hEventObject: WSAEVENT, lpNetworkEvents: LPWSANETWORKEVENTS): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAEnumProtocolsA*(lpiProtocols: LPINT, lpProtocolBuffer: LPWSAPROTOCOL_INFOA, lpdwBufferLength: LPDWORD): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAEnumProtocolsW*(lpiProtocols: LPINT, lpProtocolBuffer: LPWSAPROTOCOL_INFOW, lpdwBufferLength: LPDWORD): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAEventSelect*(s: SOCKET, hEventObject: WSAEVENT, lNetworkEvents: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAGetOverlappedResult*(s: SOCKET, lpOverlapped: LPWSAOVERLAPPED, lpcbTransfer: LPDWORD, fWait: WINBOOL, lpdwFlags: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAGetQOSByName*(s: SOCKET, lpQOSName: LPWSABUF, lpQOS: LPQOS): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAHtonl*(s: SOCKET, hostlong: int32, lpnetlong: ptr int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAHtons*(s: SOCKET, hostshort: uint16, lpnetshort: ptr uint16): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAIoctl*(s: SOCKET, dwIoControlCode: DWORD, lpvInBuffer: LPVOID, cbInBuffer: DWORD, lpvOutBuffer: LPVOID, cbOutBuffer: DWORD, lpcbBytesReturned: LPDWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAJoinLeaf*(s: SOCKET, name: ptr sockaddr, namelen: int32, lpCallerData: LPWSABUF, lpCalleeData: LPWSABUF, lpSQOS: LPQOS, lpGQOS: LPQOS, dwFlags: DWORD): SOCKET {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSANtohl*(s: SOCKET, netlong: int32, lphostlong: ptr int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSANtohs*(s: SOCKET, netshort: uint16, lphostshort: ptr uint16): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSARecv*(s: SOCKET, lpBuffers: LPWSABUF, dwBufferCount: DWORD, lpNumberOfBytesRecvd: LPDWORD, lpFlags: LPDWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSARecvDisconnect*(s: SOCKET, lpInboundDisconnectData: LPWSABUF): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSARecvFrom*(s: SOCKET, lpBuffers: LPWSABUF, dwBufferCount: DWORD, lpNumberOfBytesRecvd: LPDWORD, lpFlags: LPDWORD, lpFrom: ptr sockaddr, lpFromlen: LPINT, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAResetEvent*(hEvent: WSAEVENT): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASend*(s: SOCKET, lpBuffers: LPWSABUF, dwBufferCount: DWORD, lpNumberOfBytesSent: LPDWORD, dwFlags: DWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASendDisconnect*(s: SOCKET, lpOutboundDisconnectData: LPWSABUF): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASendTo*(s: SOCKET, lpBuffers: LPWSABUF, dwBufferCount: DWORD, lpNumberOfBytesSent: LPDWORD, dwFlags: DWORD, lpTo: ptr sockaddr, iTolen: int32, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASetEvent*(hEvent: WSAEVENT): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASocketA*(af: int32, `type`: int32, protocol: int32, lpProtocolInfo: LPWSAPROTOCOL_INFOA, g: GROUP, dwFlags: DWORD): SOCKET {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASocketW*(af: int32, `type`: int32, protocol: int32, lpProtocolInfo: LPWSAPROTOCOL_INFOW, g: GROUP, dwFlags: DWORD): SOCKET {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAWaitForMultipleEvents*(cEvents: DWORD, lphEvents: ptr WSAEVENT, fWaitAll: WINBOOL, dwTimeout: DWORD, fAlertable: WINBOOL): DWORD {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAddressToStringA*(lpsaAddress: LPSOCKADDR, dwAddressLength: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOA, lpszAddressString: LPSTR, lpdwAddressStringLength: LPDWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAAddressToStringW*(lpsaAddress: LPSOCKADDR, dwAddressLength: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOW, lpszAddressString: LPWSTR, lpdwAddressStringLength: LPDWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAStringToAddressA*(AddressString: LPSTR, AddressFamily: INT, lpProtocolInfo: LPWSAPROTOCOL_INFOA, lpAddress: LPSOCKADDR, lpAddressLength: LPINT): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAStringToAddressW*(AddressString: LPWSTR, AddressFamily: INT, lpProtocolInfo: LPWSAPROTOCOL_INFOW, lpAddress: LPSOCKADDR, lpAddressLength: LPINT): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSALookupServiceBeginA*(lpqsRestrictions: LPWSAQUERYSETA, dwControlFlags: DWORD, lphLookup: LPHANDLE): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSALookupServiceBeginW*(lpqsRestrictions: LPWSAQUERYSETW, dwControlFlags: DWORD, lphLookup: LPHANDLE): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSALookupServiceNextA*(hLookup: HANDLE, dwControlFlags: DWORD, lpdwBufferLength: LPDWORD, lpqsResults: LPWSAQUERYSETA): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSALookupServiceNextW*(hLookup: HANDLE, dwControlFlags: DWORD, lpdwBufferLength: LPDWORD, lpqsResults: LPWSAQUERYSETW): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSANSPIoctl*(hLookup: HANDLE, dwControlCode: DWORD, lpvInBuffer: LPVOID, cbInBuffer: DWORD, lpvOutBuffer: LPVOID, cbOutBuffer: DWORD, lpcbBytesReturned: LPDWORD, lpCompletion: LPWSACOMPLETION): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSALookupServiceEnd*(hLookup: HANDLE): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAInstallServiceClassA*(lpServiceClassInfo: LPWSASERVICECLASSINFOA): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAInstallServiceClassW*(lpServiceClassInfo: LPWSASERVICECLASSINFOW): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSARemoveServiceClass*(lpServiceClassId: LPGUID): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAGetServiceClassInfoA*(lpProviderId: LPGUID, lpServiceClassId: LPGUID, lpdwBufSize: LPDWORD, lpServiceClassInfo: LPWSASERVICECLASSINFOA): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAGetServiceClassInfoW*(lpProviderId: LPGUID, lpServiceClassId: LPGUID, lpdwBufSize: LPDWORD, lpServiceClassInfo: LPWSASERVICECLASSINFOW): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAEnumNameSpaceProvidersA*(lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOA): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAEnumNameSpaceProvidersW*(lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOW): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAGetServiceClassNameByClassIdA*(lpServiceClassId: LPGUID, lpszServiceClassName: LPSTR, lpdwBufferLength: LPDWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAGetServiceClassNameByClassIdW*(lpServiceClassId: LPGUID, lpszServiceClassName: LPWSTR, lpdwBufferLength: LPDWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASetServiceA*(lpqsRegInfo: LPWSAQUERYSETA, essoperation: WSAESETSERVICEOP, dwControlFlags: DWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASetServiceW*(lpqsRegInfo: LPWSAQUERYSETW, essoperation: WSAESETSERVICEOP, dwControlFlags: DWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAProviderConfigChange*(lpNotificationHandle: LPHANDLE, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAConnectByList*(s: SOCKET, SocketAddressList: PSOCKET_ADDRESS_LIST, LocalAddressLength: LPDWORD, LocalAddress: LPSOCKADDR, RemoteAddressLength: LPDWORD, RemoteAddress: LPSOCKADDR, timeout: PTIMEVAL, Reserved: LPWSAOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAConnectByNameA*(s: SOCKET, nodename: LPSTR, servicename: LPSTR, LocalAddressLength: LPDWORD, LocalAddress: LPSOCKADDR, RemoteAddressLength: LPDWORD, RemoteAddress: LPSOCKADDR, timeout: PTIMEVAL, Reserved: LPWSAOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAConnectByNameW*(s: SOCKET, nodename: LPWSTR, servicename: LPWSTR, LocalAddressLength: LPDWORD, LocalAddress: LPSOCKADDR, RemoteAddressLength: LPDWORD, RemoteAddress: LPSOCKADDR, timeout: PTIMEVAL, Reserved: LPWSAOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAEnumNameSpaceProvidersExA*(lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOEXA): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAEnumNameSpaceProvidersExW*(lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOEXW): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAPoll*(fdarray: ptr WSAPOLLFD, nfds: ULONG, timeout: INT): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSASendMsg*(s: SOCKET, lpMsg: LPWSAMSG, dwFlags: DWORD, lpNumberOfBytesSent: LPDWORD, lpOverlapped: LPWSAOVERLAPPED, lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc getaddrinfo*(nodename: ptr char, servname: ptr char, hints: ptr ADDRINFOA, res: ptr ptr ADDRINFOA): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc GetAddrInfoW*(pNodeName: PCWSTR, pServiceName: PCWSTR, pHints: ptr ADDRINFOW, ppResult: ptr PADDRINFOW): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc GetAddrInfoA*(nodename: ptr char, servname: ptr char, hints: ptr ADDRINFOA, res: ptr ptr ADDRINFOA): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "getaddrinfo".}
proc freeaddrinfo*(pAddrInfo: LPADDRINFO): void {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc FreeAddrInfoW*(pAddrInfo: PADDRINFOW): void {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc FreeAddrInfoA*(pAddrInfo: LPADDRINFO): void {.winapi, stdcall, dynlib: "ws2_32", importc: "freeaddrinfo".}
proc getnameinfo*(sa: ptr sockaddr, salen: socklen_t, host: ptr char, hostlen: DWORD, serv: ptr char, servlen: DWORD, flags: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc GetNameInfoW*(pSockaddr: ptr SOCKADDR, SockaddrLength: socklen_t, pNodeBuffer: PWCHAR, NodeBufferSize: DWORD, pServiceBuffer: PWCHAR, ServiceBufferSize: DWORD, Flags: INT): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc GetNameInfoA*(sa: ptr sockaddr, salen: socklen_t, host: ptr char, hostlen: DWORD, serv: ptr char, servlen: DWORD, flags: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "getnameinfo".}
proc RtlIpv6AddressToStringA*(Addr: ptr IN6_ADDR, S: LPSTR): LPSTR {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv6AddressToStringW*(Addr: ptr IN6_ADDR, S: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv6AddressToStringExA*(Address: ptr IN6_ADDR, ScopeId: ULONG, Port: USHORT, AddressString: LPSTR, AddressStringLength: PULONG): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv6AddressToStringExW*(Address: ptr IN6_ADDR, ScopeId: ULONG, Port: USHORT, AddressString: LPWSTR, AddressStringLength: PULONG): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv4AddressToStringA*(Addr: ptr IN_ADDR, S: LPSTR): LPSTR {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv4AddressToStringW*(Addr: ptr IN_ADDR, S: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv4AddressToStringExA*(Address: ptr IN_ADDR, Port: USHORT, AddressString: LPSTR, AddressStringLength: PULONG): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv4AddressToStringExW*(Address: ptr IN_ADDR, Port: USHORT, AddressString: LPWSTR, AddressStringLength: PULONG): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv4StringToAddressA*(S: PCSTR, Strict: BOOLEAN, Terminator: ptr LPSTR, Addr: ptr IN_ADDR): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv4StringToAddressW*(S: PCWSTR, Strict: BOOLEAN, Terminator: ptr LPWSTR, Addr: ptr IN_ADDR): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv4StringToAddressExA*(AddressString: PCSTR, Strict: BOOLEAN, Address: ptr IN_ADDR, Port: PUSHORT): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv4StringToAddressExW*(AddressString: PCWSTR, Strict: BOOLEAN, Address: ptr IN_ADDR, Port: PUSHORT): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv6StringToAddressExA*(AddressString: PCSTR, Address: ptr IN6_ADDR, ScopeId: PULONG, Port: PUSHORT): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIpv6StringToAddressExW*(AddressString: PCWSTR, Address: ptr IN6_ADDR, ScopeId: PULONG, Port: PUSHORT): LONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc GetAddrInfoExA*(pName: PCSTR, pServiceName: PCSTR, dwNameSpace: DWORD, lpNspId: LPGUID, pHints: ptr ADDRINFOEXA, ppResult: ptr PADDRINFOEXA, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc GetAddrInfoExW*(pName: PCWSTR, pServiceName: PCWSTR, dwNameSpace: DWORD, lpNspId: LPGUID, pHints: ptr ADDRINFOEXW, ppResult: ptr PADDRINFOEXW, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc SetAddrInfoExA*(pName: PCSTR, pServiceName: PCSTR, pAddresses: ptr SOCKET_ADDRESS, dwAddressCount: DWORD, lpBlob: LPBLOB, dwFlags: DWORD, dwNameSpace: DWORD, lpNspId: LPGUID, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc SetAddrInfoExW*(pName: PCWSTR, pServiceName: PCWSTR, pAddresses: ptr SOCKET_ADDRESS, dwAddressCount: DWORD, lpBlob: LPBLOB, dwFlags: DWORD, dwNameSpace: DWORD, lpNspId: LPGUID, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc FreeAddrInfoExW*(pAddrInfo: PADDRINFOEXW): void {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSAImpersonateSocketPeer*(Socket: SOCKET, PeerAddress: ptr sockaddr, peerAddressLen: ULONG): int32 {.winapi, stdcall, dynlib: "fwpuclnt", importc.}
proc WSAQuerySocketSecurity*(Socket: SOCKET, SecurityQueryTemplate: ptr SOCKET_SECURITY_QUERY_TEMPLATE, SecurityQueryTemplateLen: ULONG, SecurityQueryInfo: ptr SOCKET_SECURITY_QUERY_INFO, SecurityQueryInfoLen: ptr ULONG, Overlapped: LPWSAOVERLAPPED, CompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "fwpuclnt", importc.}
proc WSARevertImpersonation*(): int32 {.winapi, stdcall, dynlib: "fwpuclnt", importc.}
proc WSASetSocketPeerTargetName*(Socket: SOCKET, PeerTargetName: ptr SOCKET_PEER_TARGET_NAME, PeerTargetNameLen: ULONG, Overlapped: LPWSAOVERLAPPED, CompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "fwpuclnt", importc.}
proc WSASetSocketSecurity*(Socket: SOCKET, SecuritySettings: ptr SOCKET_SECURITY_SETTINGS, SecuritySettingsLen: ULONG, Overlapped: LPWSAOVERLAPPED, CompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): int32 {.winapi, stdcall, dynlib: "fwpuclnt", importc.}
proc InetNtopW*(Family: INT, pAddr: PVOID, pStringBuf: LPWSTR, StringBufSIze: int): LPCWSTR {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc inet_ntop*(Family: INT, pAddr: PVOID, pStringBuf: LPSTR, StringBufSize: int): LPCSTR {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc InetPtonW*(Family: INT, pStringBuf: LPCWSTR, pAddr: PVOID): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc inet_pton*(Family: INT, pStringBuf: LPCSTR, pAddr: PVOID): INT {.winapi, stdcall, dynlib: "ws2_32", importc.}
proc WSARecvEx*(s: SOCKET, buf: ptr char, len: int32, flags: ptr int32): int32 {.winapi, stdcall, dynlib: "mswsock", importc.}
proc TransmitFile*(hSocket: SOCKET, hFile: HANDLE, nNumberOfBytesToWrite: DWORD, nNumberOfBytesPerSend: DWORD, lpOverlapped: LPOVERLAPPED, lpTransmitBuffers: LPTRANSMIT_FILE_BUFFERS, dwReserved: DWORD): WINBOOL {.winapi, stdcall, dynlib: "mswsock", importc.}
proc AcceptEx*(sListenSocket: SOCKET, sAcceptSocket: SOCKET, lpOutputBuffer: PVOID, dwReceiveDataLength: DWORD, dwLocalAddressLength: DWORD, dwRemoteAddressLength: DWORD, lpdwBytesReceived: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "mswsock", importc.}
proc GetAcceptExSockaddrs*(lpOutputBuffer: PVOID, dwReceiveDataLength: DWORD, dwLocalAddressLength: DWORD, dwRemoteAddressLength: DWORD, LocalSockaddr: ptr ptr sockaddr, LocalSockaddrLength: LPINT, RemoteSockaddr: ptr ptr sockaddr, RemoteSockaddrLength: LPINT): VOID {.winapi, stdcall, dynlib: "mswsock", importc.}
proc InetNtopA*(Family: INT, pAddr: PVOID, pStringBuf: LPSTR, StringBufSize: int): LPCSTR {.winapi, stdcall, dynlib: "ws2_32", importc: "inet_ntop".}
proc InetPtonA*(Family: INT, pStringBuf: LPCSTR, pAddr: PVOID): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "inet_pton".}
template `<`*(x: TIMEVAL, y: TIMEVAL): bool = (x.tv_sec < y.tv_sec or (x.tv_sec == y.tv_sec and x.tv_usec < y.tv_usec))
template `<=`*(x: TIMEVAL, y: TIMEVAL): bool = (x.tv_sec < y.tv_sec or (x.tv_sec == y.tv_sec and x.tv_usec <= y.tv_usec))
template timerisset*(tvp: TIMEVAL): bool = tvp.tv_sec != 0 or tvp.tv_usec != 0
template timerclear*(tvp: var TIMEVAL) = tvp.tv_sec = 0; tvp.tv_usec = 0
template IN_CLASSA*(i: untyped): bool = (i and 0x80000000) == 0
template IN_CLASSB*(i: untyped): bool = (i and 0xc0000000) == 0x80000000
template IN_CLASSC*(i: untyped): bool = (i and 0xe0000000) == 0xc0000000
template IN_CLASSD*(i: untyped): bool = (i and 0xf0000000) == 0xe0000000
template IN_MULTICAST*(i: untyped): bool = IN_CLASSD(i)
template WSAMAKEASYNCREPLY*(buflen: untyped, error: untyped): untyped = MAKELONG(buflen, error)
template WSAMAKESELECTREPLY*(event: untyped, error: untyped): untyped = MAKELONG(event, error)
template WSAGETASYNCBUFLEN*(lParam: untyped): untyped = LOWORD(lParam)
template WSAGETASYNCERROR*(lParam: untyped): untyped = HIWORD(lParam)
template WSAGETSELECTEVENT*(lParam: untyped): untyped = LOWORD(lParam)
template WSAGETSELECTERROR*(lParam: untyped): untyped = HIWORD(lParam)
proc FD_CLR*(fd: SOCKET, s: ptr fd_set): void {.importc: "FD_CLR", header: "<winsock2.h>".}
proc FD_SET*(fd: SOCKET, s: ptr fd_set): void {.importc: "FD_SET", header: "<winsock2.h>".}
proc FD_ZERO*(s: ptr fd_set): void {.importc: "FD_ZERO", header: "<winsock2.h>".}
proc FD_ISSET*(fd: SOCKET, s: ptr fd_set): bool {.winapi, inline.} = bool WSAFDIsSet(fd, s)
proc IN6_ADDR_EQUAL*(a: ptr IN6_ADDR, b: ptr IN6_ADDR): bool {.winapi, inline.} = equalMem(a, b, sizeof(IN6_ADDR))
proc FreeAddrInfoExA*(pAddrInfo: PADDRINFOEXA): void {.winapi, stdcall, dynlib: "ws2_32", importc: "FreeAddrInfoEx".}
proc `Zone=`*(self: var SCOPE_ID, x: ULONG) {.inline.} = self.union1.struct1.Zone = x
proc Zone*(self: SCOPE_ID): ULONG {.inline.} = self.union1.struct1.Zone
proc `Level=`*(self: var SCOPE_ID, x: ULONG) {.inline.} = self.union1.struct1.Level = x
proc Level*(self: SCOPE_ID): ULONG {.inline.} = self.union1.struct1.Level
proc `Value=`*(self: var SCOPE_ID, x: ULONG) {.inline.} = self.union1.Value = x
proc Value*(self: SCOPE_ID): ULONG {.inline.} = self.union1.Value
proc Value*(self: var SCOPE_ID): var ULONG {.inline.} = self.union1.Value
proc `sin6_scope_id=`*(self: var sockaddr_in6, x: int32) {.inline.} = self.union1.sin6_scope_id = x
proc sin6_scope_id*(self: sockaddr_in6): int32 {.inline.} = self.union1.sin6_scope_id
proc sin6_scope_id*(self: var sockaddr_in6): var int32 {.inline.} = self.union1.sin6_scope_id
proc `sin6_scope_struct=`*(self: var sockaddr_in6, x: SCOPE_ID) {.inline.} = self.union1.sin6_scope_struct = x
proc sin6_scope_struct*(self: sockaddr_in6): SCOPE_ID {.inline.} = self.union1.sin6_scope_struct
proc sin6_scope_struct*(self: var sockaddr_in6): var SCOPE_ID {.inline.} = self.union1.sin6_scope_struct
proc `nFileOffset=`*(self: var TRANSMIT_PACKETS_ELEMENT, x: LARGE_INTEGER) {.inline.} = self.union1.struct1.nFileOffset = x
proc nFileOffset*(self: TRANSMIT_PACKETS_ELEMENT): LARGE_INTEGER {.inline.} = self.union1.struct1.nFileOffset
proc nFileOffset*(self: var TRANSMIT_PACKETS_ELEMENT): var LARGE_INTEGER {.inline.} = self.union1.struct1.nFileOffset
proc `hFile=`*(self: var TRANSMIT_PACKETS_ELEMENT, x: HANDLE) {.inline.} = self.union1.struct1.hFile = x
proc hFile*(self: TRANSMIT_PACKETS_ELEMENT): HANDLE {.inline.} = self.union1.struct1.hFile
proc hFile*(self: var TRANSMIT_PACKETS_ELEMENT): var HANDLE {.inline.} = self.union1.struct1.hFile
proc `pBuffer=`*(self: var TRANSMIT_PACKETS_ELEMENT, x: PVOID) {.inline.} = self.union1.pBuffer = x
proc pBuffer*(self: TRANSMIT_PACKETS_ELEMENT): PVOID {.inline.} = self.union1.pBuffer
proc pBuffer*(self: var TRANSMIT_PACKETS_ELEMENT): var PVOID {.inline.} = self.union1.pBuffer
when winimUnicode:
  type
    WSAPROTOCOL_INFO* = WSAPROTOCOL_INFOW
    LPWSAPROTOCOL_INFO* = LPWSAPROTOCOL_INFOW
    WSAQUERYSET* = WSAQUERYSETW
    PWSAQUERYSET* = PWSAQUERYSETW
    LPWSAQUERYSET* = LPWSAQUERYSETW
    WSANSCLASSINFO* = WSANSCLASSINFOW
    PWSANSCLASSINFO* = PWSANSCLASSINFOW
    LPWSANSCLASSINFO* = LPWSANSCLASSINFOW
    WSASERVICECLASSINFO* = WSASERVICECLASSINFOW
    PWSASERVICECLASSINFO* = PWSASERVICECLASSINFOW
    LPWSASERVICECLASSINFO* = LPWSASERVICECLASSINFOW
    WSANAMESPACE_INFO* = WSANAMESPACE_INFOW
    PWSANAMESPACE_INFO* = PWSANAMESPACE_INFOW
    LPWSANAMESPACE_INFO* = LPWSANAMESPACE_INFOW
    LPFN_WSADUPLICATESOCKET* = LPFN_WSADUPLICATESOCKETW
    LPFN_WSAENUMPROTOCOLS* = LPFN_WSAENUMPROTOCOLSW
    LPFN_WSASOCKET* = LPFN_WSASOCKETW
    LPFN_WSAADDRESSTOSTRING* = LPFN_WSAADDRESSTOSTRINGW
    LPFN_WSASTRINGTOADDRESS* = LPFN_WSASTRINGTOADDRESSW
    LPFN_WSALOOKUPSERVICEBEGIN* = LPFN_WSALOOKUPSERVICEBEGINW
    LPFN_WSALOOKUPSERVICENEXT* = LPFN_WSALOOKUPSERVICENEXTW
    LPFN_WSAINSTALLSERVICECLASS* = LPFN_WSAINSTALLSERVICECLASSW
    LPFN_WSAGETSERVICECLASSINFO* = LPFN_WSAGETSERVICECLASSINFOW
    LPFN_WSAENUMNAMESPACEPROVIDERS* = LPFN_WSAENUMNAMESPACEPROVIDERSW
    LPFN_WSAGETSERVICECLASSNAMEBYCLASSID* = LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDW
    LPFN_WSASETSERVICE* = LPFN_WSASETSERVICEW
    WSANAMESPACE_INFOEX* = WSANAMESPACE_INFOEXW
    PWSANAMESPACE_INFOEX* = PWSANAMESPACE_INFOEXW
    LPWSANAMESPACE_INFOEX* = LPWSANAMESPACE_INFOEXW
    ADDRINFOT* = ADDRINFOW
    LPFN_GETADDRINFOT* = LPFN_GETADDRINFOW
    LPFN_FREEADDRINFOT* = LPFN_FREEADDRINFOW
    LPFN_GETNAMEINFOT* = LPFN_GETNAMEINFOW
    PADDRINFOEX* = PADDRINFOEXW
    LPFN_GETADDRINFOEX* = LPFN_GETADDRINFOEXW
    LPFN_SETADDRINFOEX* = LPFN_SETADDRINFOEXW
    LPFN_FREEADDRINFOEX* = LPFN_FREEADDRINFOEXW
  const
    SO_PROTOCOL_INFO* = SO_PROTOCOL_INFOW
    SERVICE_TYPE_VALUE_SAPID* = SERVICE_TYPE_VALUE_SAPIDW
    SERVICE_TYPE_VALUE_TCPPORT* = SERVICE_TYPE_VALUE_TCPPORTW
    SERVICE_TYPE_VALUE_UDPPORT* = SERVICE_TYPE_VALUE_UDPPORTW
    SERVICE_TYPE_VALUE_OBJECTID* = SERVICE_TYPE_VALUE_OBJECTIDW
  proc WSADuplicateSocket*(s: SOCKET, dwProcessId: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOW): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "WSADuplicateSocketW".}
  proc WSAEnumProtocols*(lpiProtocols: LPINT, lpProtocolBuffer: LPWSAPROTOCOL_INFOW, lpdwBufferLength: LPDWORD): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAEnumProtocolsW".}
  proc WSAAddressToString*(lpsaAddress: LPSOCKADDR, dwAddressLength: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOW, lpszAddressString: LPWSTR, lpdwAddressStringLength: LPDWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAAddressToStringW".}
  proc WSASocket*(af: int32, `type`: int32, protocol: int32, lpProtocolInfo: LPWSAPROTOCOL_INFOW, g: GROUP, dwFlags: DWORD): SOCKET {.winapi, stdcall, dynlib: "ws2_32", importc: "WSASocketW".}
  proc WSAStringToAddress*(AddressString: LPWSTR, AddressFamily: INT, lpProtocolInfo: LPWSAPROTOCOL_INFOW, lpAddress: LPSOCKADDR, lpAddressLength: LPINT): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAStringToAddressW".}
  proc WSALookupServiceBegin*(lpqsRestrictions: LPWSAQUERYSETW, dwControlFlags: DWORD, lphLookup: LPHANDLE): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSALookupServiceBeginW".}
  proc WSALookupServiceNext*(hLookup: HANDLE, dwControlFlags: DWORD, lpdwBufferLength: LPDWORD, lpqsResults: LPWSAQUERYSETW): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSALookupServiceNextW".}
  proc WSAInstallServiceClass*(lpServiceClassInfo: LPWSASERVICECLASSINFOW): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAInstallServiceClassW".}
  proc WSAGetServiceClassInfo*(lpProviderId: LPGUID, lpServiceClassId: LPGUID, lpdwBufSize: LPDWORD, lpServiceClassInfo: LPWSASERVICECLASSINFOW): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAGetServiceClassInfoW".}
  proc WSAEnumNameSpaceProviders*(lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOW): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAEnumNameSpaceProvidersW".}
  proc WSAGetServiceClassNameByClassId*(lpServiceClassId: LPGUID, lpszServiceClassName: LPWSTR, lpdwBufferLength: LPDWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAGetServiceClassNameByClassIdW".}
  proc WSASetService*(lpqsRegInfo: LPWSAQUERYSETW, essoperation: WSAESETSERVICEOP, dwControlFlags: DWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSASetServiceW".}
  proc WSAConnectByName*(s: SOCKET, nodename: LPWSTR, servicename: LPWSTR, LocalAddressLength: LPDWORD, LocalAddress: LPSOCKADDR, RemoteAddressLength: LPDWORD, RemoteAddress: LPSOCKADDR, timeout: PTIMEVAL, Reserved: LPWSAOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAConnectByNameW".}
  proc WSAEnumNameSpaceProvidersEx*(lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOEXW): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAEnumNameSpaceProvidersExW".}
  proc GetAddrInfo*(pNodeName: PCWSTR, pServiceName: PCWSTR, pHints: ptr ADDRINFOW, ppResult: ptr PADDRINFOW): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "GetAddrInfoW".}
  proc FreeAddrInfo*(pAddrInfo: PADDRINFOW): void {.winapi, stdcall, dynlib: "ws2_32", importc: "FreeAddrInfoW".}
  proc GetNameInfo*(pSockaddr: ptr SOCKADDR, SockaddrLength: socklen_t, pNodeBuffer: PWCHAR, NodeBufferSize: DWORD, pServiceBuffer: PWCHAR, ServiceBufferSize: DWORD, Flags: INT): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "GetNameInfoW".}
  proc RtlIpv6AddressToString*(Addr: ptr IN6_ADDR, S: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv6AddressToStringW".}
  proc RtlIpv6AddressToStringEx*(Address: ptr IN6_ADDR, ScopeId: ULONG, Port: USHORT, AddressString: LPWSTR, AddressStringLength: PULONG): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv6AddressToStringExW".}
  proc RtlIpv4AddressToString*(Addr: ptr IN_ADDR, S: LPWSTR): LPWSTR {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv4AddressToStringW".}
  proc RtlIpv4AddressToStringEx*(Address: ptr IN_ADDR, Port: USHORT, AddressString: LPWSTR, AddressStringLength: PULONG): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv4AddressToStringExW".}
  proc RtlIpv4StringToAddress*(S: PCWSTR, Strict: BOOLEAN, Terminator: ptr LPWSTR, Addr: ptr IN_ADDR): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv4StringToAddressW".}
  proc RtlIpv4StringToAddressEx*(AddressString: PCWSTR, Strict: BOOLEAN, Address: ptr IN_ADDR, Port: PUSHORT): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv4StringToAddressExW".}
  proc RtlIpv6StringToAddressEx*(AddressString: PCWSTR, Address: ptr IN6_ADDR, ScopeId: PULONG, Port: PUSHORT): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv6StringToAddressExW".}
  proc GetAddrInfoEx*(pName: PCWSTR, pServiceName: PCWSTR, dwNameSpace: DWORD, lpNspId: LPGUID, pHints: ptr ADDRINFOEXW, ppResult: ptr PADDRINFOEXW, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "GetAddrInfoExW".}
  proc SetAddrInfoEx*(pName: PCWSTR, pServiceName: PCWSTR, pAddresses: ptr SOCKET_ADDRESS, dwAddressCount: DWORD, lpBlob: LPBLOB, dwFlags: DWORD, dwNameSpace: DWORD, lpNspId: LPGUID, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "SetAddrInfoExW".}
  proc FreeAddrInfoEx*(pAddrInfo: PADDRINFOEXW): void {.winapi, stdcall, dynlib: "ws2_32", importc: "FreeAddrInfoExW".}
  proc InetNtop*(Family: INT, pAddr: PVOID, pStringBuf: LPWSTR, StringBufSIze: int): LPCWSTR {.winapi, stdcall, dynlib: "ws2_32", importc: "InetNtopW".}
  proc InetPton*(Family: INT, pStringBuf: LPCWSTR, pAddr: PVOID): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "InetPtonW".}
when winimAnsi:
  type
    WSAPROTOCOL_INFO* = WSAPROTOCOL_INFOA
    LPWSAPROTOCOL_INFO* = LPWSAPROTOCOL_INFOA
    WSAQUERYSET* = WSAQUERYSETA
    PWSAQUERYSET* = PWSAQUERYSETA
    LPWSAQUERYSET* = LPWSAQUERYSETA
    WSANSCLASSINFO* = WSANSCLASSINFOA
    PWSANSCLASSINFO* = PWSANSCLASSINFOA
    LPWSANSCLASSINFO* = LPWSANSCLASSINFOA
    WSASERVICECLASSINFO* = WSASERVICECLASSINFOA
    PWSASERVICECLASSINFO* = PWSASERVICECLASSINFOA
    LPWSASERVICECLASSINFO* = LPWSASERVICECLASSINFOA
    WSANAMESPACE_INFO* = WSANAMESPACE_INFOA
    PWSANAMESPACE_INFO* = PWSANAMESPACE_INFOA
    LPWSANAMESPACE_INFO* = LPWSANAMESPACE_INFOA
    LPFN_WSADUPLICATESOCKET* = LPFN_WSADUPLICATESOCKETA
    LPFN_WSAENUMPROTOCOLS* = LPFN_WSAENUMPROTOCOLSA
    LPFN_WSASOCKET* = LPFN_WSASOCKETA
    LPFN_WSAADDRESSTOSTRING* = LPFN_WSAADDRESSTOSTRINGA
    LPFN_WSASTRINGTOADDRESS* = LPFN_WSASTRINGTOADDRESSA
    LPFN_WSALOOKUPSERVICEBEGIN* = LPFN_WSALOOKUPSERVICEBEGINA
    LPFN_WSALOOKUPSERVICENEXT* = LPFN_WSALOOKUPSERVICENEXTA
    LPFN_WSAINSTALLSERVICECLASS* = LPFN_WSAINSTALLSERVICECLASSA
    LPFN_WSAGETSERVICECLASSINFO* = LPFN_WSAGETSERVICECLASSINFOA
    LPFN_WSAENUMNAMESPACEPROVIDERS* = LPFN_WSAENUMNAMESPACEPROVIDERSA
    LPFN_WSAGETSERVICECLASSNAMEBYCLASSID* = LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDA
    LPFN_WSASETSERVICE* = LPFN_WSASETSERVICEA
    WSANAMESPACE_INFOEX* = WSANAMESPACE_INFOEXA
    PWSANAMESPACE_INFOEX* = PWSANAMESPACE_INFOEXA
    LPWSANAMESPACE_INFOEX* = LPWSANAMESPACE_INFOEXA
    ADDRINFOT* = ADDRINFOA
    LPFN_GETADDRINFOT* = LPFN_GETADDRINFOA
    LPFN_FREEADDRINFOT* = LPFN_FREEADDRINFOA
    LPFN_GETNAMEINFOT* = LPFN_GETNAMEINFOA
    PADDRINFOEX* = PADDRINFOEXA
    LPFN_GETADDRINFOEX* = LPFN_GETADDRINFOEXA
    LPFN_SETADDRINFOEX* = LPFN_SETADDRINFOEXA
    LPFN_FREEADDRINFOEX* = LPFN_FREEADDRINFOEXA
  const
    SO_PROTOCOL_INFO* = SO_PROTOCOL_INFOA
    SERVICE_TYPE_VALUE_SAPID* = SERVICE_TYPE_VALUE_SAPIDA
    SERVICE_TYPE_VALUE_TCPPORT* = SERVICE_TYPE_VALUE_TCPPORTA
    SERVICE_TYPE_VALUE_UDPPORT* = SERVICE_TYPE_VALUE_UDPPORTA
    SERVICE_TYPE_VALUE_OBJECTID* = SERVICE_TYPE_VALUE_OBJECTIDA
  proc WSADuplicateSocket*(s: SOCKET, dwProcessId: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOA): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "WSADuplicateSocketA".}
  proc WSAEnumProtocols*(lpiProtocols: LPINT, lpProtocolBuffer: LPWSAPROTOCOL_INFOA, lpdwBufferLength: LPDWORD): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAEnumProtocolsA".}
  proc WSAAddressToString*(lpsaAddress: LPSOCKADDR, dwAddressLength: DWORD, lpProtocolInfo: LPWSAPROTOCOL_INFOA, lpszAddressString: LPSTR, lpdwAddressStringLength: LPDWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAAddressToStringA".}
  proc WSASocket*(af: int32, `type`: int32, protocol: int32, lpProtocolInfo: LPWSAPROTOCOL_INFOA, g: GROUP, dwFlags: DWORD): SOCKET {.winapi, stdcall, dynlib: "ws2_32", importc: "WSASocketA".}
  proc WSAStringToAddress*(AddressString: LPSTR, AddressFamily: INT, lpProtocolInfo: LPWSAPROTOCOL_INFOA, lpAddress: LPSOCKADDR, lpAddressLength: LPINT): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAStringToAddressA".}
  proc WSALookupServiceBegin*(lpqsRestrictions: LPWSAQUERYSETA, dwControlFlags: DWORD, lphLookup: LPHANDLE): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSALookupServiceBeginA".}
  proc WSALookupServiceNext*(hLookup: HANDLE, dwControlFlags: DWORD, lpdwBufferLength: LPDWORD, lpqsResults: LPWSAQUERYSETA): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSALookupServiceNextA".}
  proc WSAInstallServiceClass*(lpServiceClassInfo: LPWSASERVICECLASSINFOA): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAInstallServiceClassA".}
  proc WSAGetServiceClassInfo*(lpProviderId: LPGUID, lpServiceClassId: LPGUID, lpdwBufSize: LPDWORD, lpServiceClassInfo: LPWSASERVICECLASSINFOA): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAGetServiceClassInfoA".}
  proc WSAEnumNameSpaceProviders*(lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOA): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAEnumNameSpaceProvidersA".}
  proc WSAGetServiceClassNameByClassId*(lpServiceClassId: LPGUID, lpszServiceClassName: LPSTR, lpdwBufferLength: LPDWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAGetServiceClassNameByClassIdA".}
  proc WSASetService*(lpqsRegInfo: LPWSAQUERYSETA, essoperation: WSAESETSERVICEOP, dwControlFlags: DWORD): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSASetServiceA".}
  proc WSAConnectByName*(s: SOCKET, nodename: LPSTR, servicename: LPSTR, LocalAddressLength: LPDWORD, LocalAddress: LPSOCKADDR, RemoteAddressLength: LPDWORD, RemoteAddress: LPSOCKADDR, timeout: PTIMEVAL, Reserved: LPWSAOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAConnectByNameA".}
  proc WSAEnumNameSpaceProvidersEx*(lpdwBufferLength: LPDWORD, lpnspBuffer: LPWSANAMESPACE_INFOEXA): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "WSAEnumNameSpaceProvidersExA".}
  proc GetAddrInfo*(nodename: ptr char, servname: ptr char, hints: ptr ADDRINFOA, res: ptr ptr ADDRINFOA): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "getaddrinfo".}
  proc FreeAddrInfo*(pAddrInfo: LPADDRINFO): void {.winapi, stdcall, dynlib: "ws2_32", importc: "freeaddrinfo".}
  proc GetNameInfo*(sa: ptr sockaddr, salen: socklen_t, host: ptr char, hostlen: DWORD, serv: ptr char, servlen: DWORD, flags: int32): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "getnameinfo".}
  proc RtlIpv6AddressToString*(Addr: ptr IN6_ADDR, S: LPSTR): LPSTR {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv6AddressToStringA".}
  proc RtlIpv6AddressToStringEx*(Address: ptr IN6_ADDR, ScopeId: ULONG, Port: USHORT, AddressString: LPSTR, AddressStringLength: PULONG): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv6AddressToStringExA".}
  proc RtlIpv4AddressToString*(Addr: ptr IN_ADDR, S: LPSTR): LPSTR {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv4AddressToStringA".}
  proc RtlIpv4AddressToStringEx*(Address: ptr IN_ADDR, Port: USHORT, AddressString: LPSTR, AddressStringLength: PULONG): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv4AddressToStringExA".}
  proc RtlIpv4StringToAddress*(S: PCSTR, Strict: BOOLEAN, Terminator: ptr LPSTR, Addr: ptr IN_ADDR): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv4StringToAddressA".}
  proc RtlIpv4StringToAddressEx*(AddressString: PCSTR, Strict: BOOLEAN, Address: ptr IN_ADDR, Port: PUSHORT): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv4StringToAddressExA".}
  proc RtlIpv6StringToAddressEx*(AddressString: PCSTR, Address: ptr IN6_ADDR, ScopeId: PULONG, Port: PUSHORT): LONG {.winapi, stdcall, dynlib: "ntdll", importc: "RtlIpv6StringToAddressExA".}
  proc GetAddrInfoEx*(pName: PCSTR, pServiceName: PCSTR, dwNameSpace: DWORD, lpNspId: LPGUID, pHints: ptr ADDRINFOEXA, ppResult: ptr PADDRINFOEXA, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "GetAddrInfoExA".}
  proc SetAddrInfoEx*(pName: PCSTR, pServiceName: PCSTR, pAddresses: ptr SOCKET_ADDRESS, dwAddressCount: DWORD, lpBlob: LPBLOB, dwFlags: DWORD, dwNameSpace: DWORD, lpNspId: LPGUID, timeout: PTIMEVAL, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPLOOKUPSERVICE_COMPLETION_ROUTINE, lpNameHandle: LPHANDLE): int32 {.winapi, stdcall, dynlib: "ws2_32", importc: "SetAddrInfoExA".}
  proc InetNtop*(Family: INT, pAddr: PVOID, pStringBuf: LPSTR, StringBufSize: int): LPCSTR {.winapi, stdcall, dynlib: "ws2_32", importc: "inet_ntop".}
  proc InetPton*(Family: INT, pStringBuf: LPCSTR, pAddr: PVOID): INT {.winapi, stdcall, dynlib: "ws2_32", importc: "inet_pton".}
  proc FreeAddrInfoEx*(pAddrInfo: PADDRINFOEXA): void {.winapi, stdcall, dynlib: "ws2_32", importc.}
