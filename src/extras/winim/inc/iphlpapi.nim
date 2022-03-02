#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import winsock
import windns
import objbase
import ras
#include <iphlpapi.h>
#include <iprtrmib.h>
#include <ipmib.h>
#include <nldef.h>
#include <ipifcons.h>
#include <udpmib.h>
#include <tcpmib.h>
#include <ipexport.h>
#include <iptypes.h>
#include <ifdef.h>
#include <tcpestats.h>
#include <netioapi.h>
#include <ntddndis.h>
#include <devpkey.h>
#include <portabledeviceconnectapi.h>
#include <ndkinfo.h>
type
  NL_DAD_STATE* = int32
  NL_ROUTE_PROTOCOL* = int32
  PNL_ROUTE_PROTOCOL* = ptr int32
  NL_PREFIX_ORIGIN* = int32
  NL_SUFFIX_ORIGIN* = int32
  NL_ADDRESS_TYPE* = int32
  PNL_ADDRESS_TYPE* = ptr int32
  NL_ROUTE_ORIGIN* = int32
  PNL_ROUTE_ORIGIN* = ptr int32
  NL_NEIGHBOR_STATE* = int32
  PNL_NEIGHBOR_STATE* = ptr int32
  NL_LINK_LOCAL_ADDRESS_BEHAVIOR* = int32
  NL_ROUTER_DISCOVERY_BEHAVIOR* = int32
  NL_BANDWIDTH_FLAG* = int32
  PNL_BANDWIDTH_FLAG* = ptr int32
  NL_INTERFACE_NETWORK_CATEGORY_STATE* = int32
  PNL_INTERFACE_NETWORK_CATEGORY_STATE* = ptr int32
  NL_NETWORK_CATEGORY* = int32
  PNL_NETWORK_CATEGORY* = ptr int32
  MIB_TCP_STATE* = int32
  TCP_CONNECTION_OFFLOAD_STATE* = int32
  ICMP6_TYPE* = int32
  PICMP6_TYPE* = ptr int32
  ICMP4_TYPE* = int32
  PICMP4_TYPE* = ptr int32
  TCP_TABLE_CLASS* = int32
  PTCP_TABLE_CLASS* = ptr int32
  UDP_TABLE_CLASS* = int32
  PUDP_TABLE_CLASS* = ptr int32
  TCPIP_OWNER_MODULE_INFO_CLASS* = int32
  PTCPIP_OWNER_MODULE_INFO_CLASS* = ptr int32
  IF_OPER_STATUS* = int32
  NET_IF_OPER_STATUS* = int32
  PNET_IF_OPER_STATUS* = ptr int32
  NET_IF_ADMIN_STATUS* = int32
  PNET_IF_ADMIN_STATUS* = ptr int32
  NET_IF_MEDIA_CONNECT_STATE* = int32
  PNET_IF_MEDIA_CONNECT_STATE* = ptr int32
  NET_IF_ACCESS_TYPE* = int32
  PNET_IF_ACCESS_TYPE* = ptr int32
  NET_IF_CONNECTION_TYPE* = int32
  PNET_IF_CONNECTION_TYPE* = ptr int32
  NET_IF_DIRECTION_TYPE* = int32
  PNET_IF_DIRECTION_TYPE* = ptr int32
  NET_IF_MEDIA_DUPLEX_STATE* = int32
  PNET_IF_MEDIA_DUPLEX_STATE* = ptr int32
  TUNNEL_TYPE* = int32
  PTUNNEL_TYPE* = ptr int32
  TCP_BOOLEAN_OPTIONAL* = int32
  TCP_ESTATS_TYPE* = int32
  NET_ADDRESS_FORMAT* = int32
  MIB_NOTIFICATION_TYPE* = int32
  PMIB_NOTIFICATION_TYPE* = ptr int32
  NDIS_REQUEST_TYPE* = int32
  PNDIS_REQUEST_TYPE* = ptr int32
  NDIS_INTERRUPT_MODERATION* = int32
  PNDIS_INTERRUPT_MODERATION* = ptr int32
  NDIS_802_11_STATUS_TYPE* = int32
  PNDIS_802_11_STATUS_TYPE* = ptr int32
  NDIS_802_11_NETWORK_TYPE* = int32
  PNDIS_802_11_NETWORK_TYPE* = ptr int32
  NDIS_802_11_POWER_MODE* = int32
  PNDIS_802_11_POWER_MODE* = ptr int32
  NDIS_802_11_NETWORK_INFRASTRUCTURE* = int32
  PNDIS_802_11_NETWORK_INFRASTRUCTURE* = ptr int32
  NDIS_802_11_AUTHENTICATION_MODE* = int32
  PNDIS_802_11_AUTHENTICATION_MODE* = ptr int32
  NDIS_802_11_PRIVACY_FILTER* = int32
  PNDIS_802_11_PRIVACY_FILTER* = ptr int32
  NDIS_802_11_WEP_STATUS* = int32
  PNDIS_802_11_WEP_STATUS* = ptr int32
  NDIS_802_11_ENCRYPTION_STATUS* = int32
  PNDIS_802_11_ENCRYPTION_STATUS* = ptr int32
  NDIS_802_11_RELOAD_DEFAULTS* = int32
  PNDIS_802_11_RELOAD_DEFAULTS* = ptr int32
  NDIS_802_11_MEDIA_STREAM_MODE* = int32
  PNDIS_802_11_MEDIA_STREAM_MODE* = ptr int32
  NDIS_802_11_RADIO_STATUS* = int32
  PNDIS_802_11_RADIO_STATUS* = ptr int32
  OFFLOAD_OPERATION_E* = int32
  OFFLOAD_CONF_ALGO* = int32
  OFFLOAD_INTEGRITY_ALGO* = int32
  UDP_ENCAP_TYPE* = int32
  PUDP_ENCAP_TYPE* = ptr int32
  NDIS_MEDIUM* = int32
  PNDIS_MEDIUM* = ptr int32
  NDIS_PHYSICAL_MEDIUM* = int32
  PNDIS_PHYSICAL_MEDIUM* = ptr int32
  NDIS_HARDWARE_STATUS* = int32
  PNDIS_HARDWARE_STATUS* = ptr int32
  NDIS_DEVICE_POWER_STATE* = int32
  PNDIS_DEVICE_POWER_STATE* = ptr int32
  NDIS_FDDI_ATTACHMENT_TYPE* = int32
  PNDIS_FDDI_ATTACHMENT_TYPE* = ptr int32
  NDIS_FDDI_RING_MGT_STATE* = int32
  PNDIS_FDDI_RING_MGT_STATE* = ptr int32
  NDIS_FDDI_LCONNECTION_STATE* = int32
  PNDIS_FDDI_LCONNECTION_STATE* = ptr int32
  NDIS_WAN_MEDIUM_SUBTYPE* = int32
  PNDIS_WAN_MEDIUM_SUBTYPE* = ptr int32
  NDIS_WAN_HEADER_FORMAT* = int32
  PNDIS_WAN_HEADER_FORMAT* = ptr int32
  NDIS_WAN_QUALITY* = int32
  PNDIS_WAN_QUALITY* = ptr int32
  NDIS_802_5_RING_STATE* = int32
  PNDIS_802_5_RING_STATE* = ptr int32
  NDIS_MEDIA_STATE* = int32
  PNDIS_MEDIA_STATE* = ptr int32
  NDIS_STATUS* = int32
  PNDIS_STATUS* = ptr int32
  NDIS_SUPPORTED_PAUSE_FUNCTIONS* = int32
  PNDIS_SUPPORTED_PAUSE_FUNCTIONS* = ptr int32
  NDIS_PORT_TYPE* = int32
  PNDIS_PORT_TYPE* = ptr int32
  NDIS_PORT_AUTHORIZATION_STATE* = int32
  PNDIS_PORT_AUTHORIZATION_STATE* = ptr int32
  NDIS_PORT_CONTROL_STATE* = int32
  PNDIS_PORT_CONTROL_STATE* = ptr int32
  NDIS_NETWORK_CHANGE_TYPE* = int32
  PNDIS_NETWORK_CHANGE_TYPE* = ptr int32
  NDIS_PM_WOL_PACKET* = int32
  PNDIS_PM_WOL_PACKET* = ptr int32
  NDIS_PM_PROTOCOL_OFFLOAD_TYPE* = int32
  PNDIS_PM_PROTOCOL_OFFLOAD_TYPE* = ptr int32
  NDIS_PM_WAKE_REASON_TYPE* = int32
  PNDIS_PM_WAKE_REASON_TYPE* = ptr int32
  NDIS_PM_ADMIN_CONFIG_STATE* = int32
  PNDIS_PM_ADMIN_CONFIG_STATE* = ptr int32
  NDIS_PM_CAPABILITY_STATE* = int32
  PNDIS_PM_CAPABILITY_STATE* = ptr int32
  NDIS_RECEIVE_FILTER_TYPE* = int32
  PNDIS_RECEIVE_FILTER_TYPE* = ptr int32
  NDIS_FRAME_HEADER* = int32
  PNDIS_FRAME_HEADER* = ptr int32
  NDIS_MAC_HEADER_FIELD* = int32
  PNDIS_MAC_HEADER_FIELD* = ptr int32
  NDIS_MAC_PACKET_TYPE* = int32
  PNDIS_MAC_PACKET_TYPE* = ptr int32
  NDIS_ARP_HEADER_FIELD* = int32
  PNDIS_ARP_HEADER_FIELD* = ptr int32
  NDIS_IPV4_HEADER_FIELD* = int32
  PNDIS_IPV4_HEADER_FIELD* = ptr int32
  NDIS_IPV6_HEADER_FIELD* = int32
  PNDIS_IPV6_HEADER_FIELD* = ptr int32
  NDIS_UDP_HEADER_FIELD* = int32
  PNDIS_UDP_HEADER_FIELD* = ptr int32
  NDIS_RECEIVE_FILTER_TEST* = int32
  PNDIS_RECEIVE_FILTER_TEST* = ptr int32
  NDIS_RECEIVE_QUEUE_TYPE* = int32
  PNDIS_RECEIVE_QUEUE_TYPE* = ptr int32
  NDIS_RECEIVE_QUEUE_OPERATIONAL_STATE* = int32
  PNDIS_RECEIVE_QUEUE_OPERATIONAL_STATE* = ptr int32
  NDIS_PROCESSOR_VENDOR* = int32
  PNDIS_PROCESSOR_VENDOR* = ptr int32
  NDIS_RSS_PROFILE* = int32
  PNDIS_RSS_PROFILE* = ptr int32
  NDIS_HYPERVISOR_PARTITION_TYPE* = int32
  PNDIS_HYPERVISOR_PARTITION_TYPE* = ptr int32
  NDIS_NIC_SWITCH_TYPE* = int32
  PNDIS_NIC_SWITCH_TYPE* = ptr int32
  NDIS_NIC_SWITCH_VPORT_STATE* = int32
  PNDIS_NIC_SWITCH_VPORT_STATE* = ptr int32
  NDIS_NIC_SWITCH_VPORT_INTERRUPT_MODERATION* = int32
  PNDIS_NIC_SWITCH_VPORT_INTERRUPT_MODERATION* = ptr int32
  NDIS_SWITCH_PORT_PROPERTY_TYPE* = int32
  PNDIS_SWITCH_PORT_PROPERTY_TYPE* = ptr int32
  NDIS_SWITCH_PORT_VLAN_MODE* = int32
  PNDIS_SWITCH_PORT_VLAN_MODE* = ptr int32
  NDIS_SWITCH_PORT_PVLAN_MODE* = int32
  PNDIS_SWITCH_PORT_PVLAN_MODE* = ptr int32
  NDIS_SWITCH_PORT_FEATURE_STATUS_TYPE* = int32
  PNDIS_SWITCH_PORT_FEATURE_STATUS_TYPE* = ptr int32
  NDIS_SWITCH_PROPERTY_TYPE* = int32
  PNDIS_SWITCH_PROPERTY_TYPE* = ptr int32
  NDIS_SWITCH_FEATURE_STATUS_TYPE* = int32
  PNDIS_SWITCH_FEATURE_STATUS_TYPE* = ptr int32
  NDIS_SWITCH_PORT_TYPE* = int32
  NDIS_SWITCH_PORT_STATE* = int32
  NDIS_SWITCH_NIC_TYPE* = int32
  NDIS_SWITCH_NIC_STATE* = int32
  MIB_IF_TABLE_LEVEL* = int32
  PMIB_IF_TABLE_LEVEL* = ptr int32
  IFTYPE* = ULONG
  SN_CHAR* = WCHAR
  IPAddr* = ULONG
  IPMask* = ULONG
  IP_STATUS* = ULONG
  NET_IFINDEX* = ULONG
  PNET_IFINDEX* = ptr ULONG
  NDIS_OID* = ULONG
  PNDIS_OID* = ptr ULONG
  NDIS_802_11_TX_POWER_LEVEL* = ULONG
  NDIS_802_11_RSSI* = LONG
  NDIS_802_11_KEY_INDEX* = ULONG
  NDIS_802_11_KEY_RSC* = ULONGLONG
  NDIS_802_11_FRAGMENTATION_THRESHOLD* = ULONG
  NDIS_802_11_RTS_THRESHOLD* = ULONG
  NDIS_802_11_ANTENNA* = ULONG
  SPI_TYPE* = ULONG
  NDIS_VLAN_ID* = ULONG
  Priority_802_3* = ULONG
  NDIS_PORT_NUMBER* = ULONG
  PNDIS_PORT_NUMBER* = ptr ULONG
  NDIS_RECEIVE_QUEUE_ID* = ULONG
  PNDIS_RECEIVE_QUEUE_ID* = ptr ULONG
  NDIS_RECEIVE_QUEUE_GROUP_ID* = ULONG
  PNDIS_RECEIVE_QUEUE_GROUP_ID* = ptr ULONG
  NDIS_RECEIVE_FILTER_ID* = ULONG
  PNDIS_RECEIVE_FILTER_ID* = ptr ULONG
  NDIS_NIC_SWITCH_VPORT_ID* = ULONG
  PNDIS_NIC_SWITCH_VPORT_ID* = ptr ULONG
  NDIS_NIC_SWITCH_ID* = ULONG
  PNDIS_NIC_SWITCH_ID* = ptr ULONG
  NDIS_SRIOV_FUNCTION_ID* = USHORT
  PNDIS_SRIOV_FUNCTION_ID* = ptr USHORT
  NDIS_VF_RID* = ULONG
  PNDIS_VF_RID* = ptr ULONG
  NDIS_SWITCH_OBJECT_VERSION* = USHORT
  PNDIS_SWITCH_OBJECT_VERSION* = ptr USHORT
  NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION* = USHORT
  PNDIS_SWITCH_OBJECT_SERIALIZATION_VERSION* = ptr USHORT
  NDIS_SWITCH_NIC_INDEX* = USHORT
  PNDIS_SWITCH_NIC_INDEX* = ptr USHORT
  NL_INTERFACE_OFFLOAD_ROD* {.pure.} = object
    NlChecksumSupported* {.bitsize:1.}: BOOLEAN
    NlOptionsSupported* {.bitsize:1.}: BOOLEAN
    TlDatagramChecksumSupported* {.bitsize:1.}: BOOLEAN
    TlStreamChecksumSupported* {.bitsize:1.}: BOOLEAN
    TlStreamOptionsSupported* {.bitsize:1.}: BOOLEAN
    FastPathCompatible* {.bitsize:1.}: BOOLEAN
    TlLargeSendOffloadSupported* {.bitsize:1.}: BOOLEAN
    TlGiantSendOffloadSupported* {.bitsize:1.}: BOOLEAN
  PNL_INTERFACE_OFFLOAD_ROD* = ptr NL_INTERFACE_OFFLOAD_ROD
  NL_PATH_BANDWIDTH_ROD* {.pure.} = object
    Bandwidth*: ULONG64
    Instability*: ULONG64
    BandwidthPeaked*: BOOLEAN
  PNL_PATH_BANDWIDTH_ROD* = ptr NL_PATH_BANDWIDTH_ROD
  NL_BANDWIDTH_INFORMATION* {.pure.} = object
    Bandwidth*: ULONG64
    Instability*: ULONG64
    BandwidthPeaked*: BOOLEAN
  PNL_BANDWIDTH_INFORMATION* = ptr NL_BANDWIDTH_INFORMATION
  MIB_UDP6ROW* {.pure.} = object
    dwLocalAddr*: IN6_ADDR
    dwLocalScopeId*: DWORD
    dwLocalPort*: DWORD
  PMIB_UDP6ROW* = ptr MIB_UDP6ROW
const
  ANY_SIZE* = 1
type
  MIB_UDP6TABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_UDP6ROW]
  PMIB_UDP6TABLE* = ptr MIB_UDP6TABLE
  MIB_TCP6ROW* {.pure.} = object
    State*: MIB_TCP_STATE
    LocalAddr*: IN6_ADDR
    dwLocalScopeId*: DWORD
    dwLocalPort*: DWORD
    RemoteAddr*: IN6_ADDR
    dwRemoteScopeId*: DWORD
    dwRemotePort*: DWORD
  PMIB_TCP6ROW* = ptr MIB_TCP6ROW
  MIB_TCP6TABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_TCP6ROW]
  PMIB_TCP6TABLE* = ptr MIB_TCP6TABLE
  MIB_TCP6ROW2* {.pure.} = object
    LocalAddr*: IN6_ADDR
    dwLocalScopeId*: DWORD
    dwLocalPort*: DWORD
    RemoteAddr*: IN6_ADDR
    dwRemoteScopeId*: DWORD
    dwRemotePort*: DWORD
    State*: MIB_TCP_STATE
    dwOwningPid*: DWORD
    dwOffloadState*: TCP_CONNECTION_OFFLOAD_STATE
  PMIB_TCP6ROW2* = ptr MIB_TCP6ROW2
  MIB_TCP6TABLE2* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_TCP6ROW2]
  PMIB_TCP6TABLE2* = ptr MIB_TCP6TABLE2
  MIB_TCPROW2* {.pure.} = object
    dwState*: DWORD
    dwLocalAddr*: DWORD
    dwLocalPort*: DWORD
    dwRemoteAddr*: DWORD
    dwRemotePort*: DWORD
    dwOffloadState*: TCP_CONNECTION_OFFLOAD_STATE
  PMIB_TCPROW2* = ptr MIB_TCPROW2
  MIB_TCPTABLE2* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_TCPROW2]
  PMIB_TCPTABLE2* = ptr MIB_TCPTABLE2
  MIB_OPAQUE_QUERY* {.pure.} = object
    dwVarId*: DWORD
    rgdwVarIndex*: array[ANY_SIZE, DWORD]
  PMIB_OPAQUE_QUERY* = ptr MIB_OPAQUE_QUERY
  MIB_IFNUMBER* {.pure.} = object
    dwValue*: DWORD
  PMIB_IFNUMBER* = ptr MIB_IFNUMBER
const
  MAXLEN_PHYSADDR* = 8
  MAXLEN_IFDESCR* = 256
type
  MIB_IFROW* {.pure.} = object
    wszName*: array[MAX_INTERFACE_NAME_LEN, WCHAR]
    dwIndex*: DWORD
    dwType*: DWORD
    dwMtu*: DWORD
    dwSpeed*: DWORD
    dwPhysAddrLen*: DWORD
    bPhysAddr*: array[MAXLEN_PHYSADDR, BYTE]
    dwAdminStatus*: DWORD
    dwOperStatus*: DWORD
    dwLastChange*: DWORD
    dwInOctets*: DWORD
    dwInUcastPkts*: DWORD
    dwInNUcastPkts*: DWORD
    dwInDiscards*: DWORD
    dwInErrors*: DWORD
    dwInUnknownProtos*: DWORD
    dwOutOctets*: DWORD
    dwOutUcastPkts*: DWORD
    dwOutNUcastPkts*: DWORD
    dwOutDiscards*: DWORD
    dwOutErrors*: DWORD
    dwOutQLen*: DWORD
    dwDescrLen*: DWORD
    bDescr*: array[MAXLEN_IFDESCR, BYTE]
  PMIB_IFROW* = ptr MIB_IFROW
  MIB_IFTABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IFROW]
  PMIB_IFTABLE* = ptr MIB_IFTABLE
  MIBICMPSTATS* {.pure.} = object
    dwMsgs*: DWORD
    dwErrors*: DWORD
    dwDestUnreachs*: DWORD
    dwTimeExcds*: DWORD
    dwParmProbs*: DWORD
    dwSrcQuenchs*: DWORD
    dwRedirects*: DWORD
    dwEchos*: DWORD
    dwEchoReps*: DWORD
    dwTimestamps*: DWORD
    dwTimestampReps*: DWORD
    dwAddrMasks*: DWORD
    dwAddrMaskReps*: DWORD
  PMIBICMPSTATS* = ptr MIBICMPSTATS
  MIBICMPINFO* {.pure.} = object
    icmpInStats*: MIBICMPSTATS
    icmpOutStats*: MIBICMPSTATS
  MIB_ICMP* {.pure.} = object
    stats*: MIBICMPINFO
  PMIB_ICMP* = ptr MIB_ICMP
  MIBICMPSTATS_EX* {.pure.} = object
    dwMsgs*: DWORD
    dwErrors*: DWORD
    rgdwTypeCount*: array[256, DWORD]
  PMIBICMPSTATS_EX* = ptr MIBICMPSTATS_EX
  MIB_ICMP_EX* {.pure.} = object
    icmpInStats*: MIBICMPSTATS_EX
    icmpOutStats*: MIBICMPSTATS_EX
  PMIB_ICMP_EX* = ptr MIB_ICMP_EX
  MIB_UDPSTATS* {.pure.} = object
    dwInDatagrams*: DWORD
    dwNoPorts*: DWORD
    dwInErrors*: DWORD
    dwOutDatagrams*: DWORD
    dwNumAddrs*: DWORD
  PMIB_UDPSTATS* = ptr MIB_UDPSTATS
  MIB_UDPROW* {.pure.} = object
    dwLocalAddr*: DWORD
    dwLocalPort*: DWORD
  PMIB_UDPROW* = ptr MIB_UDPROW
  MIB_UDPROW_BASIC* = MIB_UDPROW
  PMIB_UDPROW_BASIC* = ptr MIB_UDPROW
  MIB_UDPROW_OWNER_PID* {.pure.} = object
    dwLocalAddr*: DWORD
    dwLocalPort*: DWORD
    dwOwningPid*: DWORD
  PMIB_UDPROW_OWNER_PID* = ptr MIB_UDPROW_OWNER_PID
  MIB_UDPROW_OWNER_MODULE_UNION1_STRUCT1* {.pure.} = object
    SpecificPortBind* {.bitsize:1.}: DWORD
  MIB_UDPROW_OWNER_MODULE_UNION1* {.pure, union.} = object
    struct1*: MIB_UDPROW_OWNER_MODULE_UNION1_STRUCT1
    dwFlags*: DWORD
const
  TCPIP_OWNING_MODULE_SIZE* = 16
type
  MIB_UDPROW_OWNER_MODULE* {.pure.} = object
    dwLocalAddr*: DWORD
    dwLocalPort*: DWORD
    dwOwningPid*: DWORD
    liCreateTimestamp*: LARGE_INTEGER
    union1*: MIB_UDPROW_OWNER_MODULE_UNION1
    OwningModuleInfo*: array[TCPIP_OWNING_MODULE_SIZE, ULONGLONG]
  PMIB_UDPROW_OWNER_MODULE* = ptr MIB_UDPROW_OWNER_MODULE
  MIB_UDP6ROW_OWNER_PID* {.pure.} = object
    ucLocalAddr*: array[16, UCHAR]
    dwLocalScopeId*: DWORD
    dwLocalPort*: DWORD
    dwOwningPid*: DWORD
  PMIB_UDP6ROW_OWNER_PID* = ptr MIB_UDP6ROW_OWNER_PID
  MIB_UDP6ROW_OWNER_MODULE_UNION1_STRUCT1* {.pure.} = object
    SpecificPortBind* {.bitsize:1.}: DWORD
  MIB_UDP6ROW_OWNER_MODULE_UNION1* {.pure, union.} = object
    struct1*: MIB_UDP6ROW_OWNER_MODULE_UNION1_STRUCT1
    dwFlags*: DWORD
  MIB_UDP6ROW_OWNER_MODULE* {.pure.} = object
    ucLocalAddr*: array[16, UCHAR]
    dwLocalScopeId*: DWORD
    dwLocalPort*: DWORD
    dwOwningPid*: DWORD
    liCreateTimestamp*: LARGE_INTEGER
    union1*: MIB_UDP6ROW_OWNER_MODULE_UNION1
    OwningModuleInfo*: array[TCPIP_OWNING_MODULE_SIZE, ULONGLONG]
  PMIB_UDP6ROW_OWNER_MODULE* = ptr MIB_UDP6ROW_OWNER_MODULE
  MIB_UDPTABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_UDPROW]
  PMIB_UDPTABLE* = ptr MIB_UDPTABLE
  MIB_UDPTABLE_BASIC* = MIB_UDPTABLE
  PMIB_UDPTABLE_BASIC* = ptr MIB_UDPTABLE
  MIB_UDPTABLE_OWNER_PID* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_UDPROW_OWNER_PID]
  PMIB_UDPTABLE_OWNER_PID* = ptr MIB_UDPTABLE_OWNER_PID
  MIB_UDPTABLE_OWNER_MODULE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_UDPROW_OWNER_MODULE]
  PMIB_UDPTABLE_OWNER_MODULE* = ptr MIB_UDPTABLE_OWNER_MODULE
  MIB_UDP6TABLE_OWNER_PID* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_UDP6ROW_OWNER_PID]
  PMIB_UDP6TABLE_OWNER_PID* = ptr MIB_UDP6TABLE_OWNER_PID
  MIB_UDP6TABLE_OWNER_MODULE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_UDP6ROW_OWNER_MODULE]
  PMIB_UDP6TABLE_OWNER_MODULE* = ptr MIB_UDP6TABLE_OWNER_MODULE
  MIB_TCPSTATS* {.pure.} = object
    dwRtoAlgorithm*: DWORD
    dwRtoMin*: DWORD
    dwRtoMax*: DWORD
    dwMaxConn*: DWORD
    dwActiveOpens*: DWORD
    dwPassiveOpens*: DWORD
    dwAttemptFails*: DWORD
    dwEstabResets*: DWORD
    dwCurrEstab*: DWORD
    dwInSegs*: DWORD
    dwOutSegs*: DWORD
    dwRetransSegs*: DWORD
    dwInErrs*: DWORD
    dwOutRsts*: DWORD
    dwNumConns*: DWORD
  PMIB_TCPSTATS* = ptr MIB_TCPSTATS
  MIB_TCPROW* {.pure.} = object
    dwState*: DWORD
    dwLocalAddr*: DWORD
    dwLocalPort*: DWORD
    dwRemoteAddr*: DWORD
    dwRemotePort*: DWORD
  PMIB_TCPROW* = ptr MIB_TCPROW
  MIB_TCPROW_BASIC* = MIB_TCPROW
  PMIB_TCPROW_BASIC* = ptr MIB_TCPROW
  MIB_TCPROW_OWNER_PID* {.pure.} = object
    dwState*: DWORD
    dwLocalAddr*: DWORD
    dwLocalPort*: DWORD
    dwRemoteAddr*: DWORD
    dwRemotePort*: DWORD
    dwOwningPid*: DWORD
  PMIB_TCPROW_OWNER_PID* = ptr MIB_TCPROW_OWNER_PID
  MIB_TCPROW_OWNER_MODULE* {.pure.} = object
    dwState*: DWORD
    dwLocalAddr*: DWORD
    dwLocalPort*: DWORD
    dwRemoteAddr*: DWORD
    dwRemotePort*: DWORD
    dwOwningPid*: DWORD
    liCreateTimestamp*: LARGE_INTEGER
    OwningModuleInfo*: array[TCPIP_OWNING_MODULE_SIZE, ULONGLONG]
  PMIB_TCPROW_OWNER_MODULE* = ptr MIB_TCPROW_OWNER_MODULE
  MIB_TCP6ROW_OWNER_PID* {.pure.} = object
    ucLocalAddr*: array[16, UCHAR]
    dwLocalScopeId*: DWORD
    dwLocalPort*: DWORD
    ucRemoteAddr*: array[16, UCHAR]
    dwRemoteScopeId*: DWORD
    dwRemotePort*: DWORD
    dwState*: DWORD
    dwOwningPid*: DWORD
  PMIB_TCP6ROW_OWNER_PID* = ptr MIB_TCP6ROW_OWNER_PID
  MIB_TCP6ROW_OWNER_MODULE* {.pure.} = object
    ucLocalAddr*: array[16, UCHAR]
    dwLocalScopeId*: DWORD
    dwLocalPort*: DWORD
    ucRemoteAddr*: array[16, UCHAR]
    dwRemoteScopeId*: DWORD
    dwRemotePort*: DWORD
    dwState*: DWORD
    dwOwningPid*: DWORD
    liCreateTimestamp*: LARGE_INTEGER
    OwningModuleInfo*: array[TCPIP_OWNING_MODULE_SIZE, ULONGLONG]
  PMIB_TCP6ROW_OWNER_MODULE* = ptr MIB_TCP6ROW_OWNER_MODULE
  MIB_TCPTABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_TCPROW]
  PMIB_TCPTABLE* = ptr MIB_TCPTABLE
  MIB_TCPTABLE_BASIC* = MIB_TCPTABLE
  PMIB_TCPTABLE_BASIC* = ptr MIB_TCPTABLE
  MIB_TCPTABLE_OWNER_PID* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_TCPROW_OWNER_PID]
  PMIB_TCPTABLE_OWNER_PID* = ptr MIB_TCPTABLE_OWNER_PID
  MIB_TCPTABLE_OWNER_MODULE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_TCPROW_OWNER_MODULE]
  PMIB_TCPTABLE_OWNER_MODULE* = ptr MIB_TCPTABLE_OWNER_MODULE
  MIB_TCP6TABLE_OWNER_PID* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_TCP6ROW_OWNER_PID]
  PMIB_TCP6TABLE_OWNER_PID* = ptr MIB_TCP6TABLE_OWNER_PID
  MIB_TCP6TABLE_OWNER_MODULE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_TCP6ROW_OWNER_MODULE]
  PMIB_TCP6TABLE_OWNER_MODULE* = ptr MIB_TCP6TABLE_OWNER_MODULE
  MIB_IPSTATS* {.pure.} = object
    dwForwarding*: DWORD
    dwDefaultTTL*: DWORD
    dwInReceives*: DWORD
    dwInHdrErrors*: DWORD
    dwInAddrErrors*: DWORD
    dwForwDatagrams*: DWORD
    dwInUnknownProtos*: DWORD
    dwInDiscards*: DWORD
    dwInDelivers*: DWORD
    dwOutRequests*: DWORD
    dwRoutingDiscards*: DWORD
    dwOutDiscards*: DWORD
    dwOutNoRoutes*: DWORD
    dwReasmTimeout*: DWORD
    dwReasmReqds*: DWORD
    dwReasmOks*: DWORD
    dwReasmFails*: DWORD
    dwFragOks*: DWORD
    dwFragFails*: DWORD
    dwFragCreates*: DWORD
    dwNumIf*: DWORD
    dwNumAddr*: DWORD
    dwNumRoutes*: DWORD
  PMIB_IPSTATS* = ptr MIB_IPSTATS
  MIB_IPADDRROW* {.pure.} = object
    dwAddr*: DWORD
    dwIndex*: DWORD
    dwMask*: DWORD
    dwBCastAddr*: DWORD
    dwReasmSize*: DWORD
    unused1*: uint16
    wType*: uint16
  PMIB_IPADDRROW* = ptr MIB_IPADDRROW
  MIB_IPADDRTABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPADDRROW]
  PMIB_IPADDRTABLE* = ptr MIB_IPADDRTABLE
  MIB_IPFORWARDNUMBER* {.pure.} = object
    dwValue*: DWORD
  PMIB_IPFORWARDNUMBER* = ptr MIB_IPFORWARDNUMBER
  MIB_IPFORWARDROW* {.pure.} = object
    dwForwardDest*: DWORD
    dwForwardMask*: DWORD
    dwForwardPolicy*: DWORD
    dwForwardNextHop*: DWORD
    dwForwardIfIndex*: DWORD
    dwForwardType*: DWORD
    dwForwardProto*: DWORD
    dwForwardAge*: DWORD
    dwForwardNextHopAS*: DWORD
    dwForwardMetric1*: DWORD
    dwForwardMetric2*: DWORD
    dwForwardMetric3*: DWORD
    dwForwardMetric4*: DWORD
    dwForwardMetric5*: DWORD
  PMIB_IPFORWARDROW* = ptr MIB_IPFORWARDROW
  MIB_IPFORWARDTABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPFORWARDROW]
  PMIB_IPFORWARDTABLE* = ptr MIB_IPFORWARDTABLE
  MIB_IPNETROW* {.pure.} = object
    dwIndex*: DWORD
    dwPhysAddrLen*: DWORD
    bPhysAddr*: array[MAXLEN_PHYSADDR, BYTE]
    dwAddr*: DWORD
    dwType*: DWORD
  PMIB_IPNETROW* = ptr MIB_IPNETROW
  MIB_IPNETTABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPNETROW]
  PMIB_IPNETTABLE* = ptr MIB_IPNETTABLE
  MIB_IPMCAST_OIF* {.pure.} = object
    dwOutIfIndex*: DWORD
    dwNextHopAddr*: DWORD
    dwReserved*: DWORD
    dwReserved1*: DWORD
  PMIB_IPMCAST_OIF* = ptr MIB_IPMCAST_OIF
  MIB_IPMCAST_MFE* {.pure.} = object
    dwGroup*: DWORD
    dwSource*: DWORD
    dwSrcMask*: DWORD
    dwUpStrmNgbr*: DWORD
    dwInIfIndex*: DWORD
    dwInIfProtocol*: DWORD
    dwRouteProtocol*: DWORD
    dwRouteNetwork*: DWORD
    dwRouteMask*: DWORD
    ulUpTime*: ULONG
    ulExpiryTime*: ULONG
    ulTimeOut*: ULONG
    ulNumOutIf*: ULONG
    fFlags*: DWORD
    dwReserved*: DWORD
    rgmioOutInfo*: array[ANY_SIZE, MIB_IPMCAST_OIF]
  PMIB_IPMCAST_MFE* = ptr MIB_IPMCAST_MFE
  MIB_MFE_TABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPMCAST_MFE]
  PMIB_MFE_TABLE* = ptr MIB_MFE_TABLE
  MIB_IPMCAST_OIF_STATS* {.pure.} = object
    dwOutIfIndex*: DWORD
    dwNextHopAddr*: DWORD
    dwDialContext*: DWORD
    ulTtlTooLow*: ULONG
    ulFragNeeded*: ULONG
    ulOutPackets*: ULONG
    ulOutDiscards*: ULONG
  PMIB_IPMCAST_OIF_STATS* = ptr MIB_IPMCAST_OIF_STATS
  MIB_IPMCAST_MFE_STATS* {.pure.} = object
    dwGroup*: DWORD
    dwSource*: DWORD
    dwSrcMask*: DWORD
    dwUpStrmNgbr*: DWORD
    dwInIfIndex*: DWORD
    dwInIfProtocol*: DWORD
    dwRouteProtocol*: DWORD
    dwRouteNetwork*: DWORD
    dwRouteMask*: DWORD
    ulUpTime*: ULONG
    ulExpiryTime*: ULONG
    ulNumOutIf*: ULONG
    ulInPkts*: ULONG
    ulInOctets*: ULONG
    ulPktsDifferentIf*: ULONG
    ulQueueOverflow*: ULONG
    rgmiosOutStats*: array[ANY_SIZE, MIB_IPMCAST_OIF_STATS]
  PMIB_IPMCAST_MFE_STATS* = ptr MIB_IPMCAST_MFE_STATS
  MIB_MFE_STATS_TABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPMCAST_MFE_STATS]
  PMIB_MFE_STATS_TABLE* = ptr MIB_MFE_STATS_TABLE
  MIB_IPMCAST_MFE_STATS_EX* {.pure.} = object
    dwGroup*: DWORD
    dwSource*: DWORD
    dwSrcMask*: DWORD
    dwUpStrmNgbr*: DWORD
    dwInIfIndex*: DWORD
    dwInIfProtocol*: DWORD
    dwRouteProtocol*: DWORD
    dwRouteNetwork*: DWORD
    dwRouteMask*: DWORD
    ulUpTime*: ULONG
    ulExpiryTime*: ULONG
    ulNumOutIf*: ULONG
    ulInPkts*: ULONG
    ulInOctets*: ULONG
    ulPktsDifferentIf*: ULONG
    ulQueueOverflow*: ULONG
    ulUninitMfe*: ULONG
    ulNegativeMfe*: ULONG
    ulInDiscards*: ULONG
    ulInHdrErrors*: ULONG
    ulTotalOutPackets*: ULONG
    rgmiosOutStats*: array[ANY_SIZE, MIB_IPMCAST_OIF_STATS]
  PMIB_IPMCAST_MFE_STATS_EX* = ptr MIB_IPMCAST_MFE_STATS_EX
  MIB_MFE_STATS_TABLE_EX* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPMCAST_MFE_STATS_EX]
  PMIB_MFE_STATS_TABLE_EX* = ptr MIB_MFE_STATS_TABLE_EX
  MIB_IPMCAST_GLOBAL* {.pure.} = object
    dwEnable*: DWORD
  PMIB_IPMCAST_GLOBAL* = ptr MIB_IPMCAST_GLOBAL
  MIB_IPMCAST_IF_ENTRY* {.pure.} = object
    dwIfIndex*: DWORD
    dwTtl*: DWORD
    dwProtocol*: DWORD
    dwRateLimit*: DWORD
    ulInMcastOctets*: ULONG
    ulOutMcastOctets*: ULONG
  PMIB_IPMCAST_IF_ENTRY* = ptr MIB_IPMCAST_IF_ENTRY
  MIB_IPMCAST_IF_TABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPMCAST_IF_ENTRY]
  PMIB_IPMCAST_IF_TABLE* = ptr MIB_IPMCAST_IF_TABLE
  MIB_IPMCAST_BOUNDARY* {.pure.} = object
    dwIfIndex*: DWORD
    dwGroupAddress*: DWORD
    dwGroupMask*: DWORD
    dwStatus*: DWORD
  PMIB_IPMCAST_BOUNDARY* = ptr MIB_IPMCAST_BOUNDARY
  MIB_IPMCAST_BOUNDARY_TABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPMCAST_BOUNDARY]
  PMIB_IPMCAST_BOUNDARY_TABLE* = ptr MIB_IPMCAST_BOUNDARY_TABLE
  MIB_BOUNDARYROW* {.pure.} = object
    dwGroupAddress*: DWORD
    dwGroupMask*: DWORD
  PMIB_BOUNDARYROW* = ptr MIB_BOUNDARYROW
  MIB_MCAST_LIMIT_ROW* {.pure.} = object
    dwTtl*: DWORD
    dwRateLimit*: DWORD
  PMIB_MCAST_LIMIT_ROW* = ptr MIB_MCAST_LIMIT_ROW
const
  MAX_SCOPE_NAME_LEN* = 255
type
  SCOPE_NAME_BUFFER* = array[MAX_SCOPE_NAME_LEN+1, SN_CHAR]
  SCOPE_NAME* = ptr SN_CHAR
  MIB_IPMCAST_SCOPE* {.pure.} = object
    dwGroupAddress*: DWORD
    dwGroupMask*: DWORD
    snNameBuffer*: SCOPE_NAME_BUFFER
    dwStatus*: DWORD
  PMIB_IPMCAST_SCOPE* = ptr MIB_IPMCAST_SCOPE
  MIB_IPDESTROW* {.pure.} = object
    ForwardRow*: MIB_IPFORWARDROW
    dwForwardPreference*: DWORD
    dwForwardViewSet*: DWORD
  PMIB_IPDESTROW* = ptr MIB_IPDESTROW
  MIB_IPDESTTABLE* {.pure.} = object
    dwNumEntries*: DWORD
    table*: array[ANY_SIZE, MIB_IPDESTROW]
  PMIB_IPDESTTABLE* = ptr MIB_IPDESTTABLE
  MIB_BEST_IF* {.pure.} = object
    dwDestAddr*: DWORD
    dwIfIndex*: DWORD
  PMIB_BEST_IF* = ptr MIB_BEST_IF
  MIB_PROXYARP* {.pure.} = object
    dwAddress*: DWORD
    dwMask*: DWORD
    dwIfIndex*: DWORD
  PMIB_PROXYARP* = ptr MIB_PROXYARP
  MIB_IFSTATUS* {.pure.} = object
    dwIfIndex*: DWORD
    dwAdminStatus*: DWORD
    dwOperationalStatus*: DWORD
    bMHbeatActive*: WINBOOL
    bMHbeatAlive*: WINBOOL
  PMIB_IFSTATUS* = ptr MIB_IFSTATUS
  MIB_ROUTESTATE* {.pure.} = object
    bRoutesSetToStack*: WINBOOL
  PMIB_ROUTESTATE* = ptr MIB_ROUTESTATE
  MIB_OPAQUE_INFO_UNION1* {.pure, union.} = object
    ullAlign*: ULONGLONG
    rgbyData*: array[1, BYTE]
  MIB_OPAQUE_INFO* {.pure.} = object
    dwId*: DWORD
    union1*: MIB_OPAQUE_INFO_UNION1
  PMIB_OPAQUE_INFO* = ptr MIB_OPAQUE_INFO
  TCPIP_OWNER_MODULE_BASIC_INFO* {.pure.} = object
    pModuleName*: PWCHAR
    pModulePath*: PWCHAR
  PTCPIP_OWNER_MODULE_BASIC_INFO* = ptr TCPIP_OWNER_MODULE_BASIC_INFO
  IP_OPTION_INFORMATION* {.pure.} = object
    Ttl*: UCHAR
    Tos*: UCHAR
    Flags*: UCHAR
    OptionsSize*: UCHAR
    OptionsData*: PUCHAR
  PIP_OPTION_INFORMATION* = ptr IP_OPTION_INFORMATION
  ICMP_ECHO_REPLY* {.pure.} = object
    Address*: IPAddr
    Status*: ULONG
    RoundTripTime*: ULONG
    DataSize*: USHORT
    Reserved*: USHORT
    Data*: PVOID
    Options*: IP_OPTION_INFORMATION
  PICMP_ECHO_REPLY* = ptr ICMP_ECHO_REPLY
  ARP_SEND_REPLY* {.pure.} = object
    DestAddress*: IPAddr
    SrcAddress*: IPAddr
  PARP_SEND_REPLY* = ptr ARP_SEND_REPLY
  TCP_RESERVE_PORT_RANGE* {.pure.} = object
    UpperRange*: USHORT
    LowerRange*: USHORT
  PTCP_RESERVE_PORT_RANGE* = ptr TCP_RESERVE_PORT_RANGE
const
  MAX_ADAPTER_NAME* = 128
type
  IP_ADAPTER_INDEX_MAP* {.pure.} = object
    Index*: ULONG
    Name*: array[MAX_ADAPTER_NAME, WCHAR]
  PIP_ADAPTER_INDEX_MAP* = ptr IP_ADAPTER_INDEX_MAP
  IP_INTERFACE_INFO* {.pure.} = object
    NumAdapters*: LONG
    Adapter*: array[1, IP_ADAPTER_INDEX_MAP]
  PIP_INTERFACE_INFO* = ptr IP_INTERFACE_INFO
  IP_UNIDIRECTIONAL_ADAPTER_ADDRESS* {.pure.} = object
    NumAdapters*: ULONG
    Address*: array[1, IPAddr]
  PIP_UNIDIRECTIONAL_ADAPTER_ADDRESS* = ptr IP_UNIDIRECTIONAL_ADAPTER_ADDRESS
  IP_ADAPTER_ORDER_MAP* {.pure.} = object
    NumAdapters*: ULONG
    AdapterOrder*: array[1, ULONG]
  PIP_ADAPTER_ORDER_MAP* = ptr IP_ADAPTER_ORDER_MAP
  IP_MCAST_COUNTER_INFO* {.pure.} = object
    InMcastOctets*: ULONG64
    OutMcastOctets*: ULONG64
    InMcastPkts*: ULONG64
    OutMcastPkts*: ULONG64
  PIP_MCAST_COUNTER_INFO* = ptr IP_MCAST_COUNTER_INFO
  IPV6_ADDRESS_EX* {.pure.} = object
    sin6_port*: USHORT
    sin6_flowinfo*: ULONG
    sin6_addr*: array[8, USHORT]
    sin6_scope_id*: ULONG
  PIPV6_ADDRESS_EX* = ptr IPV6_ADDRESS_EX
  NET_IF_COMPARTMENT_ID* = UINT32
  PNET_IF_COMPARTMENT_ID* = ptr UINT32
  NET_IFTYPE* = UINT16
  PNET_IFTYPE* = ptr UINT16
  IF_INDEX* = NET_IFINDEX
  PIF_INDEX* = ptr NET_IFINDEX
  NET_IF_NETWORK_GUID* = GUID
  NET_LUID_Info* {.pure.} = object
    Reserved* {.bitsize:24.}: ULONG64
    NetLuidIndex* {.bitsize:24.}: ULONG64
    IfType* {.bitsize:16.}: ULONG64
  NET_LUID* {.pure, union.} = object
    Value*: ULONG64
    Info*: NET_LUID_Info
  PNET_LUID* = ptr NET_LUID
  IF_LUID* = NET_LUID
  PIF_LUID* = ptr NET_LUID
const
  IF_MAX_STRING_SIZE* = 256
type
  IF_COUNTED_STRING_LH* {.pure.} = object
    Length*: USHORT
    String*: array[IF_MAX_STRING_SIZE + 1, WCHAR]
  PIF_COUNTED_STRING_LH* = ptr IF_COUNTED_STRING_LH
  IF_COUNTED_STRING* = IF_COUNTED_STRING_LH
  PIF_COUNTED_STRING* = ptr IF_COUNTED_STRING
const
  IF_MAX_PHYS_ADDRESS_LENGTH* = 32
type
  IF_PHYSICAL_ADDRESS_LH* {.pure.} = object
    Length*: USHORT
    Address*: array[IF_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
  PIF_PHYSICAL_ADDRESS_LH* = ptr IF_PHYSICAL_ADDRESS_LH
  IF_PHYSICAL_ADDRESS* = IF_PHYSICAL_ADDRESS_LH
  PIF_PHYSICAL_ADDRESS* = ptr IF_PHYSICAL_ADDRESS
  IP_ADDRESS_STRING* {.pure.} = object
    String*: array[4*4, char]
  PIP_ADDRESS_STRING* = ptr IP_ADDRESS_STRING
  IP_MASK_STRING* = IP_ADDRESS_STRING
  PIP_MASK_STRING* = ptr IP_ADDRESS_STRING
  IP_ADDR_STRING* {.pure.} = object
    Next*: ptr IP_ADDR_STRING
    IpAddress*: IP_ADDRESS_STRING
    IpMask*: IP_MASK_STRING
    Context*: DWORD
  PIP_ADDR_STRING* = ptr IP_ADDR_STRING
const
  MAX_ADAPTER_NAME_LENGTH* = 256
  MAX_ADAPTER_DESCRIPTION_LENGTH* = 128
  MAX_ADAPTER_ADDRESS_LENGTH* = 8
type
  IP_ADAPTER_INFO* {.pure.} = object
    Next*: ptr IP_ADAPTER_INFO
    ComboIndex*: DWORD
    AdapterName*: array[MAX_ADAPTER_NAME_LENGTH + 4, char]
    Description*: array[MAX_ADAPTER_DESCRIPTION_LENGTH + 4, char]
    AddressLength*: UINT
    Address*: array[MAX_ADAPTER_ADDRESS_LENGTH, BYTE]
    Index*: DWORD
    Type*: UINT
    DhcpEnabled*: UINT
    CurrentIpAddress*: PIP_ADDR_STRING
    IpAddressList*: IP_ADDR_STRING
    GatewayList*: IP_ADDR_STRING
    DhcpServer*: IP_ADDR_STRING
    HaveWins*: WINBOOL
    PrimaryWinsServer*: IP_ADDR_STRING
    SecondaryWinsServer*: IP_ADDR_STRING
    LeaseObtained*: int
    LeaseExpires*: int
  PIP_ADAPTER_INFO* = ptr IP_ADAPTER_INFO
  IP_PREFIX_ORIGIN* = NL_PREFIX_ORIGIN
  IP_SUFFIX_ORIGIN* = NL_SUFFIX_ORIGIN
  IP_DAD_STATE* = NL_DAD_STATE
  IP_ADAPTER_UNICAST_ADDRESS_XP_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    Flags*: DWORD
  IP_ADAPTER_UNICAST_ADDRESS_XP_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_UNICAST_ADDRESS_XP_UNION1_STRUCT1
  IP_ADAPTER_UNICAST_ADDRESS_XP* {.pure.} = object
    union1*: IP_ADAPTER_UNICAST_ADDRESS_XP_UNION1
    Next*: ptr IP_ADAPTER_UNICAST_ADDRESS_XP
    Address*: SOCKET_ADDRESS
    PrefixOrigin*: IP_PREFIX_ORIGIN
    SuffixOrigin*: IP_SUFFIX_ORIGIN
    DadState*: IP_DAD_STATE
    ValidLifetime*: ULONG
    PreferredLifetime*: ULONG
    LeaseLifetime*: ULONG
  PIP_ADAPTER_UNICAST_ADDRESS_XP* = ptr IP_ADAPTER_UNICAST_ADDRESS_XP
  IP_ADAPTER_UNICAST_ADDRESS_LH_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    Flags*: DWORD
  IP_ADAPTER_UNICAST_ADDRESS_LH_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_UNICAST_ADDRESS_LH_UNION1_STRUCT1
  IP_ADAPTER_UNICAST_ADDRESS_LH* {.pure.} = object
    union1*: IP_ADAPTER_UNICAST_ADDRESS_LH_UNION1
    Next*: ptr IP_ADAPTER_UNICAST_ADDRESS_LH
    Address*: SOCKET_ADDRESS
    PrefixOrigin*: IP_PREFIX_ORIGIN
    SuffixOrigin*: IP_SUFFIX_ORIGIN
    DadState*: IP_DAD_STATE
    ValidLifetime*: ULONG
    PreferredLifetime*: ULONG
    LeaseLifetime*: ULONG
    OnLinkPrefixLength*: UINT8
  PIP_ADAPTER_UNICAST_ADDRESS_LH* = ptr IP_ADAPTER_UNICAST_ADDRESS_LH
  IP_ADAPTER_UNICAST_ADDRESS* = IP_ADAPTER_UNICAST_ADDRESS_XP
  PIP_ADAPTER_UNICAST_ADDRESS* = ptr IP_ADAPTER_UNICAST_ADDRESS_XP
  IP_ADAPTER_ANYCAST_ADDRESS_XP_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    Flags*: DWORD
  IP_ADAPTER_ANYCAST_ADDRESS_XP_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_ANYCAST_ADDRESS_XP_UNION1_STRUCT1
  IP_ADAPTER_ANYCAST_ADDRESS_XP* {.pure.} = object
    union1*: IP_ADAPTER_ANYCAST_ADDRESS_XP_UNION1
    Next*: ptr IP_ADAPTER_ANYCAST_ADDRESS_XP
    Address*: SOCKET_ADDRESS
  PIP_ADAPTER_ANYCAST_ADDRESS_XP* = ptr IP_ADAPTER_ANYCAST_ADDRESS_XP
  IP_ADAPTER_ANYCAST_ADDRESS* = IP_ADAPTER_ANYCAST_ADDRESS_XP
  PIP_ADAPTER_ANYCAST_ADDRESS* = ptr IP_ADAPTER_ANYCAST_ADDRESS_XP
  IP_ADAPTER_MULTICAST_ADDRESS_XP_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    Flags*: DWORD
  IP_ADAPTER_MULTICAST_ADDRESS_XP_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_MULTICAST_ADDRESS_XP_UNION1_STRUCT1
  IP_ADAPTER_MULTICAST_ADDRESS_XP* {.pure.} = object
    union1*: IP_ADAPTER_MULTICAST_ADDRESS_XP_UNION1
    Next*: ptr IP_ADAPTER_MULTICAST_ADDRESS_XP
    Address*: SOCKET_ADDRESS
  PIP_ADAPTER_MULTICAST_ADDRESS_XP* = ptr IP_ADAPTER_MULTICAST_ADDRESS_XP
  IP_ADAPTER_MULTICAST_ADDRESS* = IP_ADAPTER_MULTICAST_ADDRESS_XP
  PIP_ADAPTER_MULTICAST_ADDRESS* = ptr IP_ADAPTER_MULTICAST_ADDRESS_XP
  IP_ADAPTER_DNS_SERVER_ADDRESS_XP_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    Reserved*: DWORD
  IP_ADAPTER_DNS_SERVER_ADDRESS_XP_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_DNS_SERVER_ADDRESS_XP_UNION1_STRUCT1
  IP_ADAPTER_DNS_SERVER_ADDRESS_XP* {.pure.} = object
    union1*: IP_ADAPTER_DNS_SERVER_ADDRESS_XP_UNION1
    Next*: ptr IP_ADAPTER_DNS_SERVER_ADDRESS_XP
    Address*: SOCKET_ADDRESS
  PIP_ADAPTER_DNS_SERVER_ADDRESS_XP* = ptr IP_ADAPTER_DNS_SERVER_ADDRESS_XP
  IP_ADAPTER_DNS_SERVER_ADDRESS* = IP_ADAPTER_DNS_SERVER_ADDRESS_XP
  PIP_ADAPTER_DNS_SERVER_ADDRESS* = ptr IP_ADAPTER_DNS_SERVER_ADDRESS_XP
  IP_ADAPTER_PREFIX_XP_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    Flags*: DWORD
  IP_ADAPTER_PREFIX_XP_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_PREFIX_XP_UNION1_STRUCT1
  IP_ADAPTER_PREFIX_XP* {.pure.} = object
    union1*: IP_ADAPTER_PREFIX_XP_UNION1
    Next*: ptr IP_ADAPTER_PREFIX_XP
    Address*: SOCKET_ADDRESS
    PrefixLength*: ULONG
  PIP_ADAPTER_PREFIX_XP* = ptr IP_ADAPTER_PREFIX_XP
  IP_ADAPTER_PREFIX* = IP_ADAPTER_PREFIX_XP
  PIP_ADAPTER_PREFIX* = ptr IP_ADAPTER_PREFIX_XP
  IP_ADAPTER_WINS_SERVER_ADDRESS_LH_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    Reserved*: DWORD
  IP_ADAPTER_WINS_SERVER_ADDRESS_LH_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_WINS_SERVER_ADDRESS_LH_UNION1_STRUCT1
  IP_ADAPTER_WINS_SERVER_ADDRESS_LH* {.pure.} = object
    union1*: IP_ADAPTER_WINS_SERVER_ADDRESS_LH_UNION1
    Next*: ptr IP_ADAPTER_WINS_SERVER_ADDRESS_LH
    Address*: SOCKET_ADDRESS
  PIP_ADAPTER_WINS_SERVER_ADDRESS_LH* = ptr IP_ADAPTER_WINS_SERVER_ADDRESS_LH
  IP_ADAPTER_WINS_SERVER_ADDRESS* = IP_ADAPTER_WINS_SERVER_ADDRESS_LH
  PIP_ADAPTER_WINS_SERVER_ADDRESS* = ptr IP_ADAPTER_WINS_SERVER_ADDRESS_LH
  IP_ADAPTER_GATEWAY_ADDRESS_LH_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    Reserved*: DWORD
  IP_ADAPTER_GATEWAY_ADDRESS_LH_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_GATEWAY_ADDRESS_LH_UNION1_STRUCT1
  IP_ADAPTER_GATEWAY_ADDRESS_LH* {.pure.} = object
    union1*: IP_ADAPTER_GATEWAY_ADDRESS_LH_UNION1
    Next*: ptr IP_ADAPTER_GATEWAY_ADDRESS_LH
    Address*: SOCKET_ADDRESS
  PIP_ADAPTER_GATEWAY_ADDRESS_LH* = ptr IP_ADAPTER_GATEWAY_ADDRESS_LH
  IP_ADAPTER_GATEWAY_ADDRESS* = IP_ADAPTER_GATEWAY_ADDRESS_LH
  PIP_ADAPTER_GATEWAY_ADDRESS* = ptr IP_ADAPTER_GATEWAY_ADDRESS_LH
const
  MAX_DNS_SUFFIX_STRING_LENGTH* = 256
type
  IP_ADAPTER_DNS_SUFFIX* {.pure.} = object
    Next*: ptr IP_ADAPTER_DNS_SUFFIX
    String*: array[MAX_DNS_SUFFIX_STRING_LENGTH, WCHAR]
  PIP_ADAPTER_DNS_SUFFIX* = ptr IP_ADAPTER_DNS_SUFFIX
  IP_ADAPTER_ADDRESSES_LH_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    IfIndex*: IF_INDEX
  IP_ADAPTER_ADDRESSES_LH_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_ADDRESSES_LH_UNION1_STRUCT1
  IP_ADAPTER_ADDRESSES_LH_UNION2_STRUCT1* {.pure.} = object
    DdnsEnabled* {.bitsize:1.}: ULONG
    RegisterAdapterSuffix* {.bitsize:1.}: ULONG
    Dhcpv4Enabled* {.bitsize:1.}: ULONG
    ReceiveOnly* {.bitsize:1.}: ULONG
    NoMulticast* {.bitsize:1.}: ULONG
    Ipv6OtherStatefulConfig* {.bitsize:1.}: ULONG
    NetbiosOverTcpipEnabled* {.bitsize:1.}: ULONG
    Ipv4Enabled* {.bitsize:1.}: ULONG
    Ipv6Enabled* {.bitsize:1.}: ULONG
    Ipv6ManagedAddressConfigurationSupported* {.bitsize:1.}: ULONG
  IP_ADAPTER_ADDRESSES_LH_UNION2* {.pure, union.} = object
    Flags*: ULONG
    struct1*: IP_ADAPTER_ADDRESSES_LH_UNION2_STRUCT1
const
  MAX_DHCPV6_DUID_LENGTH* = 130
type
  IP_ADAPTER_ADDRESSES_LH* {.pure.} = object
    union1*: IP_ADAPTER_ADDRESSES_LH_UNION1
    Next*: ptr IP_ADAPTER_ADDRESSES_LH
    AdapterName*: PCHAR
    FirstUnicastAddress*: PIP_ADAPTER_UNICAST_ADDRESS_LH
    FirstAnycastAddress*: PIP_ADAPTER_ANYCAST_ADDRESS_XP
    FirstMulticastAddress*: PIP_ADAPTER_MULTICAST_ADDRESS_XP
    FirstDnsServerAddress*: PIP_ADAPTER_DNS_SERVER_ADDRESS_XP
    DnsSuffix*: PWCHAR
    Description*: PWCHAR
    FriendlyName*: PWCHAR
    PhysicalAddress*: array[MAX_ADAPTER_ADDRESS_LENGTH, BYTE]
    PhysicalAddressLength*: ULONG
    union2*: IP_ADAPTER_ADDRESSES_LH_UNION2
    Mtu*: ULONG
    IfType*: IFTYPE
    OperStatus*: IF_OPER_STATUS
    Ipv6IfIndex*: IF_INDEX
    ZoneIndices*: array[16, ULONG]
    FirstPrefix*: PIP_ADAPTER_PREFIX_XP
    TransmitLinkSpeed*: ULONG64
    ReceiveLinkSpeed*: ULONG64
    FirstWinsServerAddress*: PIP_ADAPTER_WINS_SERVER_ADDRESS_LH
    FirstGatewayAddress*: PIP_ADAPTER_GATEWAY_ADDRESS_LH
    Ipv4Metric*: ULONG
    Ipv6Metric*: ULONG
    Luid*: IF_LUID
    Dhcpv4Server*: SOCKET_ADDRESS
    CompartmentId*: NET_IF_COMPARTMENT_ID
    NetworkGuid*: NET_IF_NETWORK_GUID
    ConnectionType*: NET_IF_CONNECTION_TYPE
    TunnelType*: TUNNEL_TYPE
    Dhcpv6Server*: SOCKET_ADDRESS
    Dhcpv6ClientDuid*: array[MAX_DHCPV6_DUID_LENGTH, BYTE]
    Dhcpv6ClientDuidLength*: ULONG
    Dhcpv6Iaid*: ULONG
    FirstDnsSuffix*: PIP_ADAPTER_DNS_SUFFIX
  PIP_ADAPTER_ADDRESSES_LH* = ptr IP_ADAPTER_ADDRESSES_LH
  IP_ADAPTER_ADDRESSES_XP_UNION1_STRUCT1* {.pure.} = object
    Length*: ULONG
    IfIndex*: DWORD
  IP_ADAPTER_ADDRESSES_XP_UNION1* {.pure, union.} = object
    Alignment*: ULONGLONG
    struct1*: IP_ADAPTER_ADDRESSES_XP_UNION1_STRUCT1
  IP_ADAPTER_ADDRESSES_XP* {.pure.} = object
    union1*: IP_ADAPTER_ADDRESSES_XP_UNION1
    Next*: ptr IP_ADAPTER_ADDRESSES_XP
    AdapterName*: PCHAR
    FirstUnicastAddress*: PIP_ADAPTER_UNICAST_ADDRESS_XP
    FirstAnycastAddress*: PIP_ADAPTER_ANYCAST_ADDRESS_XP
    FirstMulticastAddress*: PIP_ADAPTER_MULTICAST_ADDRESS_XP
    FirstDnsServerAddress*: PIP_ADAPTER_DNS_SERVER_ADDRESS_XP
    DnsSuffix*: PWCHAR
    Description*: PWCHAR
    FriendlyName*: PWCHAR
    PhysicalAddress*: array[MAX_ADAPTER_ADDRESS_LENGTH, BYTE]
    PhysicalAddressLength*: DWORD
    Flags*: DWORD
    Mtu*: DWORD
    IfType*: DWORD
    OperStatus*: IF_OPER_STATUS
    Ipv6IfIndex*: DWORD
    ZoneIndices*: array[16, DWORD]
    FirstPrefix*: PIP_ADAPTER_PREFIX_XP
  PIP_ADAPTER_ADDRESSES_XP* = ptr IP_ADAPTER_ADDRESSES_XP
  IP_ADAPTER_ADDRESSES* = IP_ADAPTER_ADDRESSES_XP
  PIP_ADAPTER_ADDRESSES* = ptr IP_ADAPTER_ADDRESSES_XP
  IP_PER_ADAPTER_INFO* {.pure.} = object
    AutoconfigEnabled*: UINT
    AutoconfigActive*: UINT
    CurrentDnsServer*: PIP_ADDR_STRING
    DnsServerList*: IP_ADDR_STRING
  PIP_PER_ADAPTER_INFO* = ptr IP_PER_ADAPTER_INFO
const
  MAX_HOSTNAME_LEN* = 128
  MAX_DOMAIN_NAME_LEN* = 128
  MAX_SCOPE_ID_LEN* = 256
type
  FIXED_INFO* {.pure.} = object
    HostName*: array[MAX_HOSTNAME_LEN + 4, char]
    DomainName*: array[MAX_DOMAIN_NAME_LEN + 4, char]
    CurrentDnsServer*: PIP_ADDR_STRING
    DnsServerList*: IP_ADDR_STRING
    NodeType*: UINT
    ScopeId*: array[MAX_SCOPE_ID_LEN + 4, char]
    EnableRouting*: UINT
    EnableProxy*: UINT
    EnableDns*: UINT
  PFIXED_INFO* = ptr FIXED_INFO
  IP_INTERFACE_NAME_INFO* {.pure.} = object
    Index*: ULONG
    MediaType*: ULONG
    ConnectionType*: UCHAR
    AccessType*: UCHAR
    DeviceGuid*: GUID
    InterfaceGuid*: GUID
  PIP_INTERFACE_NAME_INFO* = ptr IP_INTERFACE_NAME_INFO
  TCP_ESTATS_BANDWIDTH_ROD_v0* {.pure.} = object
    OutboundBandwidth*: ULONG64
    InboundBandwidth*: ULONG64
    OutboundInstability*: ULONG64
    InboundInstability*: ULONG64
    OutboundBandwidthPeaked*: BOOLEAN
    InboundBandwidthPeaked*: BOOLEAN
  PTCP_ESTATS_BANDWIDTH_ROD_v0* = ptr TCP_ESTATS_BANDWIDTH_ROD_v0
  TCP_ESTATS_BANDWIDTH_RW_v0* {.pure.} = object
    EnableCollectionOutbound*: TCP_BOOLEAN_OPTIONAL
    EnableCollectionInbound*: TCP_BOOLEAN_OPTIONAL
  PTCP_ESTATS_BANDWIDTH_RW_v0* = ptr TCP_ESTATS_BANDWIDTH_RW_v0
  TCP_ESTATS_DATA_ROD_v0* {.pure.} = object
    DataBytesOut*: ULONG64
    DataSegsOut*: ULONG64
    DataBytesIn*: ULONG64
    DataSegsIn*: ULONG64
    SegsOut*: ULONG64
    SegsIn*: ULONG64
    SoftErrors*: ULONG
    SoftErrorReason*: ULONG
    SndUna*: ULONG
    SndNxt*: ULONG
    SndMax*: ULONG
    ThruBytesAcked*: ULONG64
    RcvNxt*: ULONG
    ThruBytesReceived*: ULONG64
  PTCP_ESTATS_DATA_ROD_v0* = ptr TCP_ESTATS_DATA_ROD_v0
  TCP_ESTATS_DATA_RW_v0* {.pure.} = object
    EnableCollection*: BOOLEAN
  PTCP_ESTATS_DATA_RW_v0* = ptr TCP_ESTATS_DATA_RW_v0
  TCP_ESTATS_FINE_RTT_ROD_v0* {.pure.} = object
    RttVar*: ULONG
    MaxRtt*: ULONG
    MinRtt*: ULONG
    SumRtt*: ULONG
  PTCP_ESTATS_FINE_RTT_ROD_v0* = ptr TCP_ESTATS_FINE_RTT_ROD_v0
  TCP_ESTATS_FINE_RTT_RW_v0* {.pure.} = object
    EnableCollection*: BOOLEAN
  PTCP_ESTATS_FINE_RTT_RW_v0* = ptr TCP_ESTATS_FINE_RTT_RW_v0
  TCP_ESTATS_OBS_REC_ROD_v0* {.pure.} = object
    CurRwinRcvd*: ULONG
    MaxRwinRcvd*: ULONG
    MinRwinRcvd*: ULONG
    WinScaleRcvd*: UCHAR
  PTCP_ESTATS_OBS_REC_ROD_v0* = ptr TCP_ESTATS_OBS_REC_ROD_v0
  TCP_ESTATS_OBS_REC_RW_v0* {.pure.} = object
    EnableCollection*: BOOLEAN
  PTCP_ESTATS_OBS_REC_RW_v0* = ptr TCP_ESTATS_OBS_REC_RW_v0
  TCP_ESTATS_PATH_ROD_v0* {.pure.} = object
    FastRetran*: ULONG
    Timeouts*: ULONG
    SubsequentTimeouts*: ULONG
    CurTimeoutCount*: ULONG
    AbruptTimeouts*: ULONG
    PktsRetrans*: ULONG
    BytesRetrans*: ULONG
    DupAcksIn*: ULONG
    SacksRcvd*: ULONG
    SackBlocksRcvd*: ULONG
    CongSignals*: ULONG
    PreCongSumCwnd*: ULONG
    PreCongSumRtt*: ULONG
    PostCongSumRtt*: ULONG
    PostCongCountRtt*: ULONG
    EcnSignals*: ULONG
    EceRcvd*: ULONG
    SendStall*: ULONG
    QuenchRcvd*: ULONG
    RetranThresh*: ULONG
    SndDupAckEpisodes*: ULONG
    SumBytesReordered*: ULONG
    NonRecovDa*: ULONG
    NonRecovDaEpisodes*: ULONG
    AckAfterFr*: ULONG
    DsackDups*: ULONG
    SampleRtt*: ULONG
    SmoothedRtt*: ULONG
    RttVar*: ULONG
    MaxRtt*: ULONG
    MinRtt*: ULONG
    SumRtt*: ULONG
    CountRtt*: ULONG
    CurRto*: ULONG
    MaxRto*: ULONG
    MinRto*: ULONG
    CurMss*: ULONG
    MaxMss*: ULONG
    MinMss*: ULONG
    SpuriousRtoDetections*: ULONG
  PTCP_ESTATS_PATH_ROD_v0* = ptr TCP_ESTATS_PATH_ROD_v0
  TCP_ESTATS_PATH_RW_v0* {.pure.} = object
    EnableCollection*: BOOLEAN
  PTCP_ESTATS_PATH_RW_v0* = ptr TCP_ESTATS_PATH_RW_v0
  TCP_ESTATS_REC_ROD_v0* {.pure.} = object
    CurRwinSent*: ULONG
    MaxRwinSent*: ULONG
    MinRwinSent*: ULONG
    LimRwin*: ULONG
    DupAckEpisodes*: ULONG
    DupAcksOut*: ULONG
    CeRcvd*: ULONG
    EcnSent*: ULONG
    EcnNoncesRcvd*: ULONG
    CurReasmQueue*: ULONG
    MaxReasmQueue*: ULONG
    CurAppRQueue*: SIZE_T
    MaxAppRQueue*: SIZE_T
    WinScaleSent*: UCHAR
  PTCP_ESTATS_REC_ROD_v0* = ptr TCP_ESTATS_REC_ROD_v0
  TCP_ESTATS_REC_RW_v0* {.pure.} = object
    EnableCollection*: BOOLEAN
  PTCP_ESTATS_REC_RW_v0* = ptr TCP_ESTATS_REC_RW_v0
  TCP_ESTATS_SEND_BUFF_ROD_v0* {.pure.} = object
    CurRetxQueue*: SIZE_T
    MaxRetxQueue*: SIZE_T
    CurAppWQueue*: SIZE_T
    MaxAppWQueue*: SIZE_T
  PTCP_ESTATS_SEND_BUFF_ROD_v0* = ptr TCP_ESTATS_SEND_BUFF_ROD_v0
  TCP_ESTATS_SEND_BUFF_RW_v0* {.pure.} = object
    EnableCollection*: BOOLEAN
  PTCP_ESTATS_SEND_BUFF_RW_v0* = ptr TCP_ESTATS_SEND_BUFF_RW_v0
  TCP_ESTATS_SND_CONG_ROD_v0* {.pure.} = object
    SndLimTransRwin*: ULONG
    SndLimTimeRwin*: ULONG
    SndLimBytesRwin*: SIZE_T
    SndLimTransCwnd*: ULONG
    SndLimTimeCwnd*: ULONG
    SndLimBytesCwnd*: SIZE_T
    SndLimTransSnd*: ULONG
    SndLimTimeSnd*: ULONG
    SndLimBytesSnd*: SIZE_T
    SlowStart*: ULONG
    CongAvoid*: ULONG
    OtherReductions*: ULONG
    CurCwnd*: ULONG
    MaxSsCwnd*: ULONG
    MaxCaCwnd*: ULONG
    CurSsthresh*: ULONG
    MaxSsthresh*: ULONG
    MinSsthresh*: ULONG
  PTCP_ESTATS_SND_CONG_ROD_v0* = ptr TCP_ESTATS_SND_CONG_ROD_v0
  TCP_ESTATS_SND_CONG_ROS_v0* {.pure.} = object
    LimCwnd*: ULONG
  PTCP_ESTATS_SND_CONG_ROS_v0* = ptr TCP_ESTATS_SND_CONG_ROS_v0
  TCP_ESTATS_SND_CONG_RW_v0* {.pure.} = object
    EnableCollection*: BOOLEAN
  PTCP_ESTATS_SND_CONG_RW_v0* = ptr TCP_ESTATS_SND_CONG_RW_v0
  TCP_ESTATS_SYN_OPTS_ROS_v0* {.pure.} = object
    ActiveOpen*: BOOLEAN
    MssRcvd*: ULONG
    MssSent*: ULONG
  PTCP_ESTATS_SYN_OPTS_ROS_v0* = ptr TCP_ESTATS_SYN_OPTS_ROS_v0
  NET_ADDRESS_INFO_UNION1_NamedAddress* {.pure.} = object
    Address*: array[DNS_MAX_NAME_BUFFER_LENGTH, WCHAR]
    Port*: array[6, WCHAR]
  NET_ADDRESS_INFO_UNION1* {.pure, union.} = object
    NamedAddress*: NET_ADDRESS_INFO_UNION1_NamedAddress
    Ipv4Address*: SOCKADDR_IN
    Ipv6Address*: SOCKADDR_IN6
    IpAddress*: SOCKADDR
  NET_ADDRESS_INFO* {.pure.} = object
    Format*: NET_ADDRESS_FORMAT
    union1*: NET_ADDRESS_INFO_UNION1
  PNET_ADDRESS_INFO* = ptr NET_ADDRESS_INFO
  IConnectionRequestCallback* {.pure.} = object
    lpVtbl*: ptr IConnectionRequestCallbackVtbl
  IConnectionRequestCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnComplete*: proc(self: ptr IConnectionRequestCallback, hrStatus: HRESULT): HRESULT {.stdcall.}
  ILocationReport* = IConnectionRequestCallback
  NDIS_STATISTICS_VALUE* {.pure.} = object
    Oid*: NDIS_OID
    DataLength*: ULONG
    Data*: array[1, UCHAR]
  PNDIS_STATISTICS_VALUE* = ptr NDIS_STATISTICS_VALUE
  NDIS_STATISTICS_VALUE_EX* {.pure.} = object
    Oid*: NDIS_OID
    DataLength*: ULONG
    Length*: ULONG
    Data*: array[1, UCHAR]
  PNDIS_STATISTICS_VALUE_EX* = ptr NDIS_STATISTICS_VALUE_EX
  NDIS_VAR_DATA_DESC* {.pure.} = object
    Length*: USHORT
    MaximumLength*: USHORT
    Offset*: ULONG_PTR
  PNDIS_VAR_DATA_DESC* = ptr NDIS_VAR_DATA_DESC
  NDIS_OBJECT_HEADER* {.pure.} = object
    Type*: UCHAR
    Revision*: UCHAR
    Size*: USHORT
  PNDIS_OBJECT_HEADER* = ptr NDIS_OBJECT_HEADER
  NDIS_STATISTICS_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    SupportedStatistics*: ULONG
    ifInDiscards*: ULONG64
    ifInErrors*: ULONG64
    ifHCInOctets*: ULONG64
    ifHCInUcastPkts*: ULONG64
    ifHCInMulticastPkts*: ULONG64
    ifHCInBroadcastPkts*: ULONG64
    ifHCOutOctets*: ULONG64
    ifHCOutUcastPkts*: ULONG64
    ifHCOutMulticastPkts*: ULONG64
    ifHCOutBroadcastPkts*: ULONG64
    ifOutErrors*: ULONG64
    ifOutDiscards*: ULONG64
    ifHCInUcastOctets*: ULONG64
    ifHCInMulticastOctets*: ULONG64
    ifHCInBroadcastOctets*: ULONG64
    ifHCOutUcastOctets*: ULONG64
    ifHCOutMulticastOctets*: ULONG64
    ifHCOutBroadcastOctets*: ULONG64
  PNDIS_STATISTICS_INFO* = ptr NDIS_STATISTICS_INFO
  NDIS_RSC_STATISTICS_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    CoalescedPkts*: ULONG64
    CoalescedOctets*: ULONG64
    CoalesceEvents*: ULONG64
    Aborts*: ULONG64
  PNDIS_RSC_STATISTICS_INFO* = ptr NDIS_RSC_STATISTICS_INFO
  NDIS_INTERRUPT_MODERATION_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    InterruptModeration*: NDIS_INTERRUPT_MODERATION
  PNDIS_INTERRUPT_MODERATION_PARAMETERS* = ptr NDIS_INTERRUPT_MODERATION_PARAMETERS
  NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    TimeoutArrayLength*: ULONG
    TimeoutArray*: array[1, ULONG]
  PNDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES* = ptr NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES
  NDIS_PCI_DEVICE_CUSTOM_PROPERTIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    DeviceType*: UINT32
    CurrentSpeedAndMode*: UINT32
    CurrentPayloadSize*: UINT32
    MaxPayloadSize*: UINT32
    MaxReadRequestSize*: UINT32
    CurrentLinkSpeed*: UINT32
    CurrentLinkWidth*: UINT32
    MaxLinkSpeed*: UINT32
    MaxLinkWidth*: UINT32
    PciExpressVersion*: UINT32
    InterruptType*: UINT32
    MaxInterruptMessages*: UINT32
  PNDIS_PCI_DEVICE_CUSTOM_PROPERTIES* = ptr NDIS_PCI_DEVICE_CUSTOM_PROPERTIES
  NDIS_802_11_MAC_ADDRESS* = array[6, UCHAR]
  NDIS_802_11_STATUS_INDICATION* {.pure.} = object
    StatusType*: NDIS_802_11_STATUS_TYPE
  PNDIS_802_11_STATUS_INDICATION* = ptr NDIS_802_11_STATUS_INDICATION
  NDIS_802_11_AUTHENTICATION_REQUEST* {.pure.} = object
    Length*: ULONG
    Bssid*: NDIS_802_11_MAC_ADDRESS
    Flags*: ULONG
  PNDIS_802_11_AUTHENTICATION_REQUEST* = ptr NDIS_802_11_AUTHENTICATION_REQUEST
  PMKID_CANDIDATE* {.pure.} = object
    BSSID*: NDIS_802_11_MAC_ADDRESS
    Flags*: ULONG
  PPMKID_CANDIDATE* = ptr PMKID_CANDIDATE
  NDIS_802_11_PMKID_CANDIDATE_LIST* {.pure.} = object
    Version*: ULONG
    NumCandidates*: ULONG
    CandidateList*: array[1, PMKID_CANDIDATE]
  PNDIS_802_11_PMKID_CANDIDATE_LIST* = ptr NDIS_802_11_PMKID_CANDIDATE_LIST
  NDIS_802_11_NETWORK_TYPE_LIST* {.pure.} = object
    NumberOfItems*: ULONG
    NetworkType*: array[1, NDIS_802_11_NETWORK_TYPE]
  PNDIS_802_11_NETWORK_TYPE_LIST* = ptr NDIS_802_11_NETWORK_TYPE_LIST
  NDIS_802_11_CONFIGURATION_FH* {.pure.} = object
    Length*: ULONG
    HopPattern*: ULONG
    HopSet*: ULONG
    DwellTime*: ULONG
  PNDIS_802_11_CONFIGURATION_FH* = ptr NDIS_802_11_CONFIGURATION_FH
  NDIS_802_11_CONFIGURATION* {.pure.} = object
    Length*: ULONG
    BeaconPeriod*: ULONG
    ATIMWindow*: ULONG
    DSConfig*: ULONG
    FHConfig*: NDIS_802_11_CONFIGURATION_FH
  PNDIS_802_11_CONFIGURATION* = ptr NDIS_802_11_CONFIGURATION
  NDIS_802_11_STATISTICS* {.pure.} = object
    Length*: ULONG
    TransmittedFragmentCount*: LARGE_INTEGER
    MulticastTransmittedFrameCount*: LARGE_INTEGER
    FailedCount*: LARGE_INTEGER
    RetryCount*: LARGE_INTEGER
    MultipleRetryCount*: LARGE_INTEGER
    RTSSuccessCount*: LARGE_INTEGER
    RTSFailureCount*: LARGE_INTEGER
    ACKFailureCount*: LARGE_INTEGER
    FrameDuplicateCount*: LARGE_INTEGER
    ReceivedFragmentCount*: LARGE_INTEGER
    MulticastReceivedFrameCount*: LARGE_INTEGER
    FCSErrorCount*: LARGE_INTEGER
    TKIPLocalMICFailures*: LARGE_INTEGER
    TKIPICVErrorCount*: LARGE_INTEGER
    TKIPCounterMeasuresInvoked*: LARGE_INTEGER
    TKIPReplays*: LARGE_INTEGER
    CCMPFormatErrors*: LARGE_INTEGER
    CCMPReplays*: LARGE_INTEGER
    CCMPDecryptErrors*: LARGE_INTEGER
    FourWayHandshakeFailures*: LARGE_INTEGER
    WEPUndecryptableCount*: LARGE_INTEGER
    WEPICVErrorCount*: LARGE_INTEGER
    DecryptSuccessCount*: LARGE_INTEGER
    DecryptFailureCount*: LARGE_INTEGER
  PNDIS_802_11_STATISTICS* = ptr NDIS_802_11_STATISTICS
  NDIS_802_11_KEY* {.pure.} = object
    Length*: ULONG
    KeyIndex*: ULONG
    KeyLength*: ULONG
    BSSID*: NDIS_802_11_MAC_ADDRESS
    KeyRSC*: NDIS_802_11_KEY_RSC
    KeyMaterial*: array[1, UCHAR]
  PNDIS_802_11_KEY* = ptr NDIS_802_11_KEY
  NDIS_802_11_REMOVE_KEY* {.pure.} = object
    Length*: ULONG
    KeyIndex*: ULONG
    BSSID*: NDIS_802_11_MAC_ADDRESS
  PNDIS_802_11_REMOVE_KEY* = ptr NDIS_802_11_REMOVE_KEY
  NDIS_802_11_WEP* {.pure.} = object
    Length*: ULONG
    KeyIndex*: ULONG
    KeyLength*: ULONG
    KeyMaterial*: array[1, UCHAR]
  PNDIS_802_11_WEP* = ptr NDIS_802_11_WEP
const
  NDIS_802_11_LENGTH_RATES* = 8
type
  NDIS_802_11_RATES* = array[NDIS_802_11_LENGTH_RATES, UCHAR]
const
  NDIS_802_11_LENGTH_RATES_EX* = 16
type
  NDIS_802_11_RATES_EX* = array[NDIS_802_11_LENGTH_RATES_EX, UCHAR]
const
  NDIS_802_11_LENGTH_SSID* = 32
type
  NDIS_802_11_SSID* {.pure.} = object
    SsidLength*: ULONG
    Ssid*: array[NDIS_802_11_LENGTH_SSID, UCHAR]
  PNDIS_802_11_SSID* = ptr NDIS_802_11_SSID
  NDIS_WLAN_BSSID* {.pure.} = object
    Length*: ULONG
    MacAddress*: NDIS_802_11_MAC_ADDRESS
    Reserved*: array[2, UCHAR]
    Ssid*: NDIS_802_11_SSID
    Privacy*: ULONG
    Rssi*: NDIS_802_11_RSSI
    NetworkTypeInUse*: NDIS_802_11_NETWORK_TYPE
    Configuration*: NDIS_802_11_CONFIGURATION
    InfrastructureMode*: NDIS_802_11_NETWORK_INFRASTRUCTURE
    SupportedRates*: NDIS_802_11_RATES
  PNDIS_WLAN_BSSID* = ptr NDIS_WLAN_BSSID
  NDIS_802_11_BSSID_LIST* {.pure.} = object
    NumberOfItems*: ULONG
    Bssid*: array[1, NDIS_WLAN_BSSID]
  PNDIS_802_11_BSSID_LIST* = ptr NDIS_802_11_BSSID_LIST
  NDIS_WLAN_BSSID_EX* {.pure.} = object
    Length*: ULONG
    MacAddress*: NDIS_802_11_MAC_ADDRESS
    Reserved*: array[2, UCHAR]
    Ssid*: NDIS_802_11_SSID
    Privacy*: ULONG
    Rssi*: NDIS_802_11_RSSI
    NetworkTypeInUse*: NDIS_802_11_NETWORK_TYPE
    Configuration*: NDIS_802_11_CONFIGURATION
    InfrastructureMode*: NDIS_802_11_NETWORK_INFRASTRUCTURE
    SupportedRates*: NDIS_802_11_RATES_EX
    IELength*: ULONG
    IEs*: array[1, UCHAR]
  PNDIS_WLAN_BSSID_EX* = ptr NDIS_WLAN_BSSID_EX
  NDIS_802_11_BSSID_LIST_EX* {.pure.} = object
    NumberOfItems*: ULONG
    Bssid*: array[1, NDIS_WLAN_BSSID_EX]
  PNDIS_802_11_BSSID_LIST_EX* = ptr NDIS_802_11_BSSID_LIST_EX
  NDIS_802_11_FIXED_IEs* {.pure.} = object
    Timestamp*: array[8, UCHAR]
    BeaconInterval*: USHORT
    Capabilities*: USHORT
  PNDIS_802_11_FIXED_IEs* = ptr NDIS_802_11_FIXED_IEs
  NDIS_802_11_VARIABLE_IEs* {.pure.} = object
    ElementID*: UCHAR
    Length*: UCHAR
    data*: array[1, UCHAR]
  PNDIS_802_11_VARIABLE_IEs* = ptr NDIS_802_11_VARIABLE_IEs
  NDIS_802_11_AI_REQFI* {.pure.} = object
    Capabilities*: USHORT
    ListenInterval*: USHORT
    CurrentAPAddress*: NDIS_802_11_MAC_ADDRESS
  PNDIS_802_11_AI_REQFI* = ptr NDIS_802_11_AI_REQFI
  NDIS_802_11_AI_RESFI* {.pure.} = object
    Capabilities*: USHORT
    StatusCode*: USHORT
    AssociationId*: USHORT
  PNDIS_802_11_AI_RESFI* = ptr NDIS_802_11_AI_RESFI
  NDIS_802_11_ASSOCIATION_INFORMATION* {.pure.} = object
    Length*: ULONG
    AvailableRequestFixedIEs*: USHORT
    RequestFixedIEs*: NDIS_802_11_AI_REQFI
    RequestIELength*: ULONG
    OffsetRequestIEs*: ULONG
    AvailableResponseFixedIEs*: USHORT
    ResponseFixedIEs*: NDIS_802_11_AI_RESFI
    ResponseIELength*: ULONG
    OffsetResponseIEs*: ULONG
  PNDIS_802_11_ASSOCIATION_INFORMATION* = ptr NDIS_802_11_ASSOCIATION_INFORMATION
  NDIS_802_11_AUTHENTICATION_EVENT* {.pure.} = object
    Status*: NDIS_802_11_STATUS_INDICATION
    Request*: array[1, NDIS_802_11_AUTHENTICATION_REQUEST]
  PNDIS_802_11_AUTHENTICATION_EVENT* = ptr NDIS_802_11_AUTHENTICATION_EVENT
  NDIS_802_11_TEST_UNION1* {.pure, union.} = object
    AuthenticationEvent*: NDIS_802_11_AUTHENTICATION_EVENT
    RssiTrigger*: NDIS_802_11_RSSI
  NDIS_802_11_TEST* {.pure.} = object
    Length*: ULONG
    Type*: ULONG
    union1*: NDIS_802_11_TEST_UNION1
  PNDIS_802_11_TEST* = ptr NDIS_802_11_TEST
  NDIS_802_11_PMKID_VALUE* = array[16, UCHAR]
  BSSID_INFO* {.pure.} = object
    BSSID*: NDIS_802_11_MAC_ADDRESS
    PMKID*: NDIS_802_11_PMKID_VALUE
  PBSSID_INFO* = ptr BSSID_INFO
  NDIS_802_11_PMKID* {.pure.} = object
    Length*: ULONG
    BSSIDInfoCount*: ULONG
    BSSIDInfo*: array[1, BSSID_INFO]
  PNDIS_802_11_PMKID* = ptr NDIS_802_11_PMKID
  NDIS_802_11_AUTHENTICATION_ENCRYPTION* {.pure.} = object
    AuthModeSupported*: NDIS_802_11_AUTHENTICATION_MODE
    EncryptStatusSupported*: NDIS_802_11_ENCRYPTION_STATUS
  PNDIS_802_11_AUTHENTICATION_ENCRYPTION* = ptr NDIS_802_11_AUTHENTICATION_ENCRYPTION
  NDIS_802_11_CAPABILITY* {.pure.} = object
    Length*: ULONG
    Version*: ULONG
    NoOfPMKIDs*: ULONG
    NoOfAuthEncryptPairsSupported*: ULONG
    AuthenticationEncryptionSupported*: array[1, NDIS_802_11_AUTHENTICATION_ENCRYPTION]
  PNDIS_802_11_CAPABILITY* = ptr NDIS_802_11_CAPABILITY
  NDIS_802_11_NON_BCAST_SSID_LIST* {.pure.} = object
    NumberOfItems*: ULONG
    Non_Bcast_Ssid*: array[1, NDIS_802_11_SSID]
  PNDIS_802_11_NON_BCAST_SSID_LIST* = ptr NDIS_802_11_NON_BCAST_SSID_LIST
  NDIS_CO_DEVICE_PROFILE* {.pure.} = object
    DeviceDescription*: NDIS_VAR_DATA_DESC
    DevSpecificInfo*: NDIS_VAR_DATA_DESC
    ulTAPISupplementaryPassThru*: ULONG
    ulAddressModes*: ULONG
    ulNumAddresses*: ULONG
    ulBearerModes*: ULONG
    ulMaxTxRate*: ULONG
    ulMinTxRate*: ULONG
    ulMaxRxRate*: ULONG
    ulMinRxRate*: ULONG
    ulMediaModes*: ULONG
    ulGenerateToneModes*: ULONG
    ulGenerateToneMaxNumFreq*: ULONG
    ulGenerateDigitModes*: ULONG
    ulMonitorToneMaxNumFreq*: ULONG
    ulMonitorToneMaxNumEntries*: ULONG
    ulMonitorDigitModes*: ULONG
    ulGatherDigitsMinTimeout*: ULONG
    ulGatherDigitsMaxTimeout*: ULONG
    ulDevCapFlags*: ULONG
    ulMaxNumActiveCalls*: ULONG
    ulAnswerMode*: ULONG
    ulUUIAcceptSize*: ULONG
    ulUUIAnswerSize*: ULONG
    ulUUIMakeCallSize*: ULONG
    ulUUIDropSize*: ULONG
    ulUUISendUserUserInfoSize*: ULONG
    ulUUICallInfoSize*: ULONG
  PNDIS_CO_DEVICE_PROFILE* = ptr NDIS_CO_DEVICE_PROFILE
  OFFLOAD_ALGO_INFO* {.pure.} = object
    algoIdentifier*: ULONG
    algoKeylen*: ULONG
    algoRounds*: ULONG
  POFFLOAD_ALGO_INFO* = ptr OFFLOAD_ALGO_INFO
  OFFLOAD_SECURITY_ASSOCIATION* {.pure.} = object
    Operation*: OFFLOAD_OPERATION_E
    SPI*: SPI_TYPE
    IntegrityAlgo*: OFFLOAD_ALGO_INFO
    ConfAlgo*: OFFLOAD_ALGO_INFO
    Reserved*: OFFLOAD_ALGO_INFO
  POFFLOAD_SECURITY_ASSOCIATION* = ptr OFFLOAD_SECURITY_ASSOCIATION
const
  OFFLOAD_MAX_SAS* = 3
type
  OFFLOAD_IPSEC_ADD_SA* {.pure.} = object
    SrcAddr*: IPAddr
    SrcMask*: IPMask
    DestAddr*: IPAddr
    DestMask*: IPMask
    Protocol*: ULONG
    SrcPort*: USHORT
    DestPort*: USHORT
    SrcTunnelAddr*: IPAddr
    DestTunnelAddr*: IPAddr
    Flags*: USHORT
    NumSAs*: SHORT
    SecAssoc*: array[OFFLOAD_MAX_SAS, OFFLOAD_SECURITY_ASSOCIATION]
    OffloadHandle*: HANDLE
    KeyLen*: ULONG
    KeyMat*: array[1, UCHAR]
  POFFLOAD_IPSEC_ADD_SA* = ptr OFFLOAD_IPSEC_ADD_SA
  OFFLOAD_IPSEC_DELETE_SA* {.pure.} = object
    OffloadHandle*: HANDLE
  POFFLOAD_IPSEC_DELETE_SA* = ptr OFFLOAD_IPSEC_DELETE_SA
  OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY* {.pure.} = object
    UdpEncapType*: UDP_ENCAP_TYPE
    DstEncapPort*: USHORT
  POFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY* = ptr OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY
  OFFLOAD_IPSEC_ADD_UDPESP_SA* {.pure.} = object
    SrcAddr*: IPAddr
    SrcMask*: IPMask
    DstAddr*: IPAddr
    DstMask*: IPMask
    Protocol*: ULONG
    SrcPort*: USHORT
    DstPort*: USHORT
    SrcTunnelAddr*: IPAddr
    DstTunnelAddr*: IPAddr
    Flags*: USHORT
    NumSAs*: SHORT
    SecAssoc*: array[OFFLOAD_MAX_SAS, OFFLOAD_SECURITY_ASSOCIATION]
    OffloadHandle*: HANDLE
    EncapTypeEntry*: OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY
    EncapTypeEntryOffldHandle*: HANDLE
    KeyLen*: ULONG
    KeyMat*: array[1, UCHAR]
  POFFLOAD_IPSEC_ADD_UDPESP_SA* = ptr OFFLOAD_IPSEC_ADD_UDPESP_SA
  OFFLOAD_IPSEC_DELETE_UDPESP_SA* {.pure.} = object
    OffloadHandle*: HANDLE
    EncapTypeEntryOffldHandle*: HANDLE
  POFFLOAD_IPSEC_DELETE_UDPESP_SA* = ptr OFFLOAD_IPSEC_DELETE_UDPESP_SA
  TRANSPORT_HEADER_OFFSET* {.pure.} = object
    ProtocolType*: USHORT
    HeaderOffset*: USHORT
  PTRANSPORT_HEADER_OFFSET* = ptr TRANSPORT_HEADER_OFFSET
  NETWORK_ADDRESS* {.pure.} = object
    AddressLength*: USHORT
    AddressType*: USHORT
    Address*: array[1, UCHAR]
  PNETWORK_ADDRESS* = ptr NETWORK_ADDRESS
  NETWORK_ADDRESS_LIST* {.pure.} = object
    AddressCount*: LONG
    AddressType*: USHORT
    Address*: array[1, NETWORK_ADDRESS]
  PNETWORK_ADDRESS_LIST* = ptr NETWORK_ADDRESS_LIST
  NETWORK_ADDRESS_IP* {.pure.} = object
    sin_port*: USHORT
    in_addr*: ULONG
    sin_zero*: array[8, UCHAR]
  PNETWORK_ADDRESS_IP* = ptr NETWORK_ADDRESS_IP
  NETWORK_ADDRESS_IPX* {.pure.} = object
    NetworkAddress*: ULONG
    NodeAddress*: array[6, UCHAR]
    Socket*: USHORT
  PNETWORK_ADDRESS_IPX* = ptr NETWORK_ADDRESS_IPX
  GEN_GET_TIME_CAPS* {.pure.} = object
    Flags*: ULONG
    ClockPrecision*: ULONG
  PGEN_GET_TIME_CAPS* = ptr GEN_GET_TIME_CAPS
  GEN_GET_NETCARD_TIME* {.pure.} = object
    ReadTime*: ULONGLONG
  PGEN_GET_NETCARD_TIME* = ptr GEN_GET_NETCARD_TIME
  NDIS_PM_PACKET_PATTERN* {.pure.} = object
    Priority*: ULONG
    Reserved*: ULONG
    MaskSize*: ULONG
    PatternOffset*: ULONG
    PatternSize*: ULONG
    PatternFlags*: ULONG
  PNDIS_PM_PACKET_PATTERN* = ptr NDIS_PM_PACKET_PATTERN
  NDIS_PM_WAKE_UP_CAPABILITIES* {.pure.} = object
    MinMagicPacketWakeUp*: NDIS_DEVICE_POWER_STATE
    MinPatternWakeUp*: NDIS_DEVICE_POWER_STATE
    MinLinkChangeWakeUp*: NDIS_DEVICE_POWER_STATE
  PNDIS_PM_WAKE_UP_CAPABILITIES* = ptr NDIS_PM_WAKE_UP_CAPABILITIES
  NDIS_PNP_CAPABILITIES* {.pure.} = object
    Flags*: ULONG
    WakeUpCapabilities*: NDIS_PM_WAKE_UP_CAPABILITIES
  PNDIS_PNP_CAPABILITIES* = ptr NDIS_PNP_CAPABILITIES
  NDIS_WAN_PROTOCOL_CAPS* {.pure.} = object
    Flags*: ULONG
    Reserved*: ULONG
  PNDIS_WAN_PROTOCOL_CAPS* = ptr NDIS_WAN_PROTOCOL_CAPS
  NDIS_CO_LINK_SPEED* {.pure.} = object
    Outbound*: ULONG
    Inbound*: ULONG
  PNDIS_CO_LINK_SPEED* = ptr NDIS_CO_LINK_SPEED
  NDIS_LINK_SPEED* {.pure.} = object
    XmitLinkSpeed*: ULONG64
    RcvLinkSpeed*: ULONG64
  PNDIS_LINK_SPEED* = ptr NDIS_LINK_SPEED
  NDIS_GUID_UNION1* {.pure, union.} = object
    Oid*: NDIS_OID
    Status*: NDIS_STATUS
  NDIS_GUID* {.pure.} = object
    Guid*: GUID
    union1*: NDIS_GUID_UNION1
    Size*: ULONG
    Flags*: ULONG
  PNDIS_GUID* = ptr NDIS_GUID
  NDIS_IRDA_PACKET_INFO* {.pure.} = object
    ExtraBOFs*: ULONG
    MinTurnAroundTime*: ULONG
  PNDIS_IRDA_PACKET_INFO* = ptr NDIS_IRDA_PACKET_INFO
  NDIS_IF_COUNTED_STRING* = IF_COUNTED_STRING
  PNDIS_IF_COUNTED_STRING* = ptr IF_COUNTED_STRING
  NDIS_IF_PHYSICAL_ADDRESS* = IF_PHYSICAL_ADDRESS
  PNDIS_IF_PHYSICAL_ADDRESS* = ptr IF_PHYSICAL_ADDRESS
  NDIS_MEDIA_CONNECT_STATE* = NET_IF_MEDIA_CONNECT_STATE
  PNDIS_MEDIA_CONNECT_STATE* = ptr NET_IF_MEDIA_CONNECT_STATE
  NDIS_MEDIA_DUPLEX_STATE* = NET_IF_MEDIA_DUPLEX_STATE
  PNDIS_MEDIA_DUPLEX_STATE* = ptr NET_IF_MEDIA_DUPLEX_STATE
  NDIS_LINK_STATE* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    MediaConnectState*: NDIS_MEDIA_CONNECT_STATE
    MediaDuplexState*: NDIS_MEDIA_DUPLEX_STATE
    XmitLinkSpeed*: ULONG64
    RcvLinkSpeed*: ULONG64
    PauseFunctions*: NDIS_SUPPORTED_PAUSE_FUNCTIONS
    AutoNegotiationFlags*: ULONG
  PNDIS_LINK_STATE* = ptr NDIS_LINK_STATE
  NDIS_LINK_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    MediaDuplexState*: NDIS_MEDIA_DUPLEX_STATE
    XmitLinkSpeed*: ULONG64
    RcvLinkSpeed*: ULONG64
    PauseFunctions*: NDIS_SUPPORTED_PAUSE_FUNCTIONS
    AutoNegotiationFlags*: ULONG
  PNDIS_LINK_PARAMETERS* = ptr NDIS_LINK_PARAMETERS
  NDIS_OPER_STATE* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    OperationalStatus*: NET_IF_OPER_STATUS
    OperationalStatusFlags*: ULONG
  PNDIS_OPER_STATE* = ptr NDIS_OPER_STATE
  NDIS_IP_OPER_STATUS* {.pure.} = object
    AddressFamily*: ULONG
    OperationalStatus*: NET_IF_OPER_STATUS
    OperationalStatusFlags*: ULONG
  PNDIS_IP_OPER_STATUS* = ptr NDIS_IP_OPER_STATUS
const
  MAXIMUM_IP_OPER_STATUS_ADDRESS_FAMILIES_SUPPORTED* = 32
type
  NDIS_IP_OPER_STATUS_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    NumberofAddressFamiliesReturned*: ULONG
    IpOperationalStatus*: array[MAXIMUM_IP_OPER_STATUS_ADDRESS_FAMILIES_SUPPORTED, NDIS_IP_OPER_STATUS]
  PNDIS_IP_OPER_STATUS_INFO* = ptr NDIS_IP_OPER_STATUS_INFO
  NDIS_IP_OPER_STATE* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    IpOperationalStatus*: NDIS_IP_OPER_STATUS
  PNDIS_IP_OPER_STATE* = ptr NDIS_IP_OPER_STATE
  NDIS_OFFLOAD_PARAMETERS_STRUCT1* {.pure.} = object
    RscIPv4*: UCHAR
    RscIPv6*: UCHAR
  NDIS_OFFLOAD_PARAMETERS_STRUCT2* {.pure.} = object
    EncapsulatedPacketTaskOffload*: UCHAR
    EncapsulationTypes*: UCHAR
  NDIS_OFFLOAD_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    IPv4Checksum*: UCHAR
    TCPIPv4Checksum*: UCHAR
    UDPIPv4Checksum*: UCHAR
    TCPIPv6Checksum*: UCHAR
    UDPIPv6Checksum*: UCHAR
    LsoV1*: UCHAR
    IPsecV1*: UCHAR
    LsoV2IPv4*: UCHAR
    LsoV2IPv6*: UCHAR
    TcpConnectionIPv4*: UCHAR
    TcpConnectionIPv6*: UCHAR
    Flags*: ULONG
    IPsecV2*: UCHAR
    IPsecV2IPv4*: UCHAR
    struct1*: NDIS_OFFLOAD_PARAMETERS_STRUCT1
    struct2*: NDIS_OFFLOAD_PARAMETERS_STRUCT2
  PNDIS_OFFLOAD_PARAMETERS* = ptr NDIS_OFFLOAD_PARAMETERS
  NDIS_TCP_LARGE_SEND_OFFLOAD_V1_IPv4* {.pure.} = object
    Encapsulation*: ULONG
    MaxOffLoadSize*: ULONG
    MinSegmentCount*: ULONG
    TcpOptions* {.bitsize:2.}: ULONG
    IpOptions* {.bitsize:2.}: ULONG
  NDIS_TCP_LARGE_SEND_OFFLOAD_V1* {.pure.} = object
    IPv4*: NDIS_TCP_LARGE_SEND_OFFLOAD_V1_IPv4
  PNDIS_TCP_LARGE_SEND_OFFLOAD_V1* = ptr NDIS_TCP_LARGE_SEND_OFFLOAD_V1
  NDIS_TCP_IP_CHECKSUM_OFFLOAD_IPv4Transmit* {.pure.} = object
    Encapsulation*: ULONG
    IpOptionsSupported* {.bitsize:2.}: ULONG
    TcpOptionsSupported* {.bitsize:2.}: ULONG
    TcpChecksum* {.bitsize:2.}: ULONG
    UdpChecksum* {.bitsize:2.}: ULONG
    IpChecksum* {.bitsize:2.}: ULONG
  NDIS_TCP_IP_CHECKSUM_OFFLOAD_IPv4Receive* {.pure.} = object
    Encapsulation*: ULONG
    IpOptionsSupported* {.bitsize:2.}: ULONG
    TcpOptionsSupported* {.bitsize:2.}: ULONG
    TcpChecksum* {.bitsize:2.}: ULONG
    UdpChecksum* {.bitsize:2.}: ULONG
    IpChecksum* {.bitsize:2.}: ULONG
  NDIS_TCP_IP_CHECKSUM_OFFLOAD_IPv6Transmit* {.pure.} = object
    Encapsulation*: ULONG
    IpExtensionHeadersSupported* {.bitsize:2.}: ULONG
    TcpOptionsSupported* {.bitsize:2.}: ULONG
    TcpChecksum* {.bitsize:2.}: ULONG
    UdpChecksum* {.bitsize:2.}: ULONG
  NDIS_TCP_IP_CHECKSUM_OFFLOAD_IPv6Receive* {.pure.} = object
    Encapsulation*: ULONG
    IpExtensionHeadersSupported* {.bitsize:2.}: ULONG
    TcpOptionsSupported* {.bitsize:2.}: ULONG
    TcpChecksum* {.bitsize:2.}: ULONG
    UdpChecksum* {.bitsize:2.}: ULONG
  NDIS_TCP_IP_CHECKSUM_OFFLOAD* {.pure.} = object
    IPv4Transmit*: NDIS_TCP_IP_CHECKSUM_OFFLOAD_IPv4Transmit
    IPv4Receive*: NDIS_TCP_IP_CHECKSUM_OFFLOAD_IPv4Receive
    IPv6Transmit*: NDIS_TCP_IP_CHECKSUM_OFFLOAD_IPv6Transmit
    IPv6Receive*: NDIS_TCP_IP_CHECKSUM_OFFLOAD_IPv6Receive
  PNDIS_TCP_IP_CHECKSUM_OFFLOAD* = ptr NDIS_TCP_IP_CHECKSUM_OFFLOAD
  NDIS_IPSEC_OFFLOAD_V1_Supported* {.pure.} = object
    Encapsulation*: ULONG
    AhEspCombined*: ULONG
    TransportTunnelCombined*: ULONG
    IPv4Options*: ULONG
    Flags*: ULONG
  NDIS_IPSEC_OFFLOAD_V1_IPv4AH* {.pure.} = object
    Md5* {.bitsize:2.}: ULONG
    Sha_1* {.bitsize:2.}: ULONG
    Transport* {.bitsize:2.}: ULONG
    Tunnel* {.bitsize:2.}: ULONG
    Send* {.bitsize:2.}: ULONG
    Receive* {.bitsize:2.}: ULONG
  NDIS_IPSEC_OFFLOAD_V1_IPv4ESP* {.pure.} = object
    Des* {.bitsize:2.}: ULONG
    Reserved* {.bitsize:2.}: ULONG
    TripleDes* {.bitsize:2.}: ULONG
    NullEsp* {.bitsize:2.}: ULONG
    Transport* {.bitsize:2.}: ULONG
    Tunnel* {.bitsize:2.}: ULONG
    Send* {.bitsize:2.}: ULONG
    Receive* {.bitsize:2.}: ULONG
  NDIS_IPSEC_OFFLOAD_V1* {.pure.} = object
    Supported*: NDIS_IPSEC_OFFLOAD_V1_Supported
    IPv4AH*: NDIS_IPSEC_OFFLOAD_V1_IPv4AH
    IPv4ESP*: NDIS_IPSEC_OFFLOAD_V1_IPv4ESP
  PNDIS_IPSEC_OFFLOAD_V1* = ptr NDIS_IPSEC_OFFLOAD_V1
  NDIS_TCP_LARGE_SEND_OFFLOAD_V2_IPv4* {.pure.} = object
    Encapsulation*: ULONG
    MaxOffLoadSize*: ULONG
    MinSegmentCount*: ULONG
  NDIS_TCP_LARGE_SEND_OFFLOAD_V2_IPv6* {.pure.} = object
    Encapsulation*: ULONG
    MaxOffLoadSize*: ULONG
    MinSegmentCount*: ULONG
    IpExtensionHeadersSupported* {.bitsize:2.}: ULONG
    TcpOptionsSupported* {.bitsize:2.}: ULONG
  NDIS_TCP_LARGE_SEND_OFFLOAD_V2* {.pure.} = object
    IPv4*: NDIS_TCP_LARGE_SEND_OFFLOAD_V2_IPv4
    IPv6*: NDIS_TCP_LARGE_SEND_OFFLOAD_V2_IPv6
  PNDIS_TCP_LARGE_SEND_OFFLOAD_V2* = ptr NDIS_TCP_LARGE_SEND_OFFLOAD_V2
  NDIS_IPSEC_OFFLOAD_V2* {.pure.} = object
    Encapsulation*: ULONG
    IPv6Supported*: BOOLEAN
    IPv4Options*: BOOLEAN
    IPv6NonIPsecExtensionHeaders*: BOOLEAN
    Ah*: BOOLEAN
    Esp*: BOOLEAN
    AhEspCombined*: BOOLEAN
    Transport*: BOOLEAN
    Tunnel*: BOOLEAN
    TransportTunnelCombined*: BOOLEAN
    LsoSupported*: BOOLEAN
    ExtendedSequenceNumbers*: BOOLEAN
    UdpEsp*: ULONG
    AuthenticationAlgorithms*: ULONG
    EncryptionAlgorithms*: ULONG
    SaOffloadCapacity*: ULONG
  PNDIS_IPSEC_OFFLOAD_V2* = ptr NDIS_IPSEC_OFFLOAD_V2
  NDIS_TCP_RECV_SEG_COALESCE_OFFLOAD_IPv4* {.pure.} = object
    Enabled*: BOOLEAN
  NDIS_TCP_RECV_SEG_COALESCE_OFFLOAD_IPv6* {.pure.} = object
    Enabled*: BOOLEAN
  NDIS_TCP_RECV_SEG_COALESCE_OFFLOAD* {.pure.} = object
    IPv4*: NDIS_TCP_RECV_SEG_COALESCE_OFFLOAD_IPv4
    IPv6*: NDIS_TCP_RECV_SEG_COALESCE_OFFLOAD_IPv6
  PNDIS_TCP_RECV_SEG_COALESCE_OFFLOAD* = ptr NDIS_TCP_RECV_SEG_COALESCE_OFFLOAD
  NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD* {.pure.} = object
    TransmitChecksumOffloadSupported* {.bitsize:4.}: ULONG
    ReceiveChecksumOffloadSupported* {.bitsize:4.}: ULONG
    LsoV2Supported* {.bitsize:4.}: ULONG
    RssSupported* {.bitsize:4.}: ULONG
    VmqSupported* {.bitsize:4.}: ULONG
    MaxHeaderSizeSupported*: ULONG
  PNDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD* = ptr NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD
  NDIS_OFFLOAD* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Checksum*: NDIS_TCP_IP_CHECKSUM_OFFLOAD
    LsoV1*: NDIS_TCP_LARGE_SEND_OFFLOAD_V1
    IPsecV1*: NDIS_IPSEC_OFFLOAD_V1
    LsoV2*: NDIS_TCP_LARGE_SEND_OFFLOAD_V2
    Flags*: ULONG
    IPsecV2*: NDIS_IPSEC_OFFLOAD_V2
    Rsc*: NDIS_TCP_RECV_SEG_COALESCE_OFFLOAD
    EncapsulatedPacketTaskOffloadGre*: NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD
  PNDIS_OFFLOAD* = ptr NDIS_OFFLOAD
  NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1_IPv4* {.pure.} = object
    Encapsulation*: ULONG
    MaxOffLoadSize*: ULONG
    MinSegmentCount*: ULONG
    TcpOptions*: ULONG
    IpOptions*: ULONG
  NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1* {.pure.} = object
    IPv4*: NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1_IPv4
  PNDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1* = ptr NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1
  NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD_IPv4Transmit* {.pure.} = object
    Encapsulation*: ULONG
    IpOptionsSupported*: ULONG
    TcpOptionsSupported*: ULONG
    TcpChecksum*: ULONG
    UdpChecksum*: ULONG
    IpChecksum*: ULONG
  NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD_IPv4Receive* {.pure.} = object
    Encapsulation*: ULONG
    IpOptionsSupported*: ULONG
    TcpOptionsSupported*: ULONG
    TcpChecksum*: ULONG
    UdpChecksum*: ULONG
    IpChecksum*: ULONG
  NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD_IPv6Transmit* {.pure.} = object
    Encapsulation*: ULONG
    IpExtensionHeadersSupported*: ULONG
    TcpOptionsSupported*: ULONG
    TcpChecksum*: ULONG
    UdpChecksum*: ULONG
  NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD_IPv6Receive* {.pure.} = object
    Encapsulation*: ULONG
    IpExtensionHeadersSupported*: ULONG
    TcpOptionsSupported*: ULONG
    TcpChecksum*: ULONG
    UdpChecksum*: ULONG
  NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD* {.pure.} = object
    IPv4Transmit*: NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD_IPv4Transmit
    IPv4Receive*: NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD_IPv4Receive
    IPv6Transmit*: NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD_IPv6Transmit
    IPv6Receive*: NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD_IPv6Receive
  PNDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD* = ptr NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD
  NDIS_WMI_IPSEC_OFFLOAD_V1_Supported* {.pure.} = object
    Encapsulation*: ULONG
    AhEspCombined*: ULONG
    TransportTunnelCombined*: ULONG
    IPv4Options*: ULONG
    Flags*: ULONG
  NDIS_WMI_IPSEC_OFFLOAD_V1_IPv4AH* {.pure.} = object
    Md5*: ULONG
    Sha_1*: ULONG
    Transport*: ULONG
    Tunnel*: ULONG
    Send*: ULONG
    Receive*: ULONG
  NDIS_WMI_IPSEC_OFFLOAD_V1_IPv4ESP* {.pure.} = object
    Des*: ULONG
    Reserved*: ULONG
    TripleDes*: ULONG
    NullEsp*: ULONG
    Transport*: ULONG
    Tunnel*: ULONG
    Send*: ULONG
    Receive*: ULONG
  NDIS_WMI_IPSEC_OFFLOAD_V1* {.pure.} = object
    Supported*: NDIS_WMI_IPSEC_OFFLOAD_V1_Supported
    IPv4AH*: NDIS_WMI_IPSEC_OFFLOAD_V1_IPv4AH
    IPv4ESP*: NDIS_WMI_IPSEC_OFFLOAD_V1_IPv4ESP
  PNDIS_WMI_IPSEC_OFFLOAD_V1* = ptr NDIS_WMI_IPSEC_OFFLOAD_V1
  NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2_IPv4* {.pure.} = object
    Encapsulation*: ULONG
    MaxOffLoadSize*: ULONG
    MinSegmentCount*: ULONG
  NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2_IPv6* {.pure.} = object
    Encapsulation*: ULONG
    MaxOffLoadSize*: ULONG
    MinSegmentCount*: ULONG
    IpExtensionHeadersSupported*: ULONG
    TcpOptionsSupported*: ULONG
  NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2* {.pure.} = object
    IPv4*: NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2_IPv4
    IPv6*: NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2_IPv6
  PNDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2* = ptr NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2
  NDIS_WMI_OFFLOAD* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Checksum*: NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD
    LsoV1*: NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1
    IPsecV1*: NDIS_WMI_IPSEC_OFFLOAD_V1
    LsoV2*: NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2
    Flags*: ULONG
    IPsecV2*: NDIS_IPSEC_OFFLOAD_V2
    Rsc*: NDIS_TCP_RECV_SEG_COALESCE_OFFLOAD
    EncapsulatedPacketTaskOffloadGre*: NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD
  PNDIS_WMI_OFFLOAD* = ptr NDIS_WMI_OFFLOAD
  NDIS_TCP_CONNECTION_OFFLOAD* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Encapsulation*: ULONG
    SupportIPv4* {.bitsize:2.}: ULONG
    SupportIPv6* {.bitsize:2.}: ULONG
    SupportIPv6ExtensionHeaders* {.bitsize:2.}: ULONG
    SupportSack* {.bitsize:2.}: ULONG
    CongestionAlgorithm* {.bitsize:4.}: ULONG
    TcpConnectionOffloadCapacity*: ULONG
    Flags*: ULONG
  PNDIS_TCP_CONNECTION_OFFLOAD* = ptr NDIS_TCP_CONNECTION_OFFLOAD
  NDIS_WMI_TCP_CONNECTION_OFFLOAD* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Encapsulation*: ULONG
    SupportIPv4*: ULONG
    SupportIPv6*: ULONG
    SupportIPv6ExtensionHeaders*: ULONG
    SupportSack*: ULONG
    TcpConnectionOffloadCapacity*: ULONG
    Flags*: ULONG
  PNDIS_WMI_TCP_CONNECTION_OFFLOAD* = ptr NDIS_WMI_TCP_CONNECTION_OFFLOAD
  NDIS_PORT_CONTROLL_STATE* = NDIS_PORT_CONTROL_STATE
  PNDIS_PORT_CONTROLL_STATE* = PNDIS_PORT_CONTROL_STATE
  NDIS_PORT_AUTHENTICATION_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    SendControlState*: NDIS_PORT_CONTROL_STATE
    RcvControlState*: NDIS_PORT_CONTROL_STATE
    SendAuthorizationState*: NDIS_PORT_AUTHORIZATION_STATE
    RcvAuthorizationState*: NDIS_PORT_AUTHORIZATION_STATE
  PNDIS_PORT_AUTHENTICATION_PARAMETERS* = ptr NDIS_PORT_AUTHENTICATION_PARAMETERS
  NDIS_WMI_METHOD_HEADER* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    PortNumber*: NDIS_PORT_NUMBER
    NetLuid*: NET_LUID
    RequestId*: ULONG64
    Timeout*: ULONG
    Padding*: array[4, UCHAR]
  PNDIS_WMI_METHOD_HEADER* = ptr NDIS_WMI_METHOD_HEADER
  NDIS_WMI_SET_HEADER* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    PortNumber*: NDIS_PORT_NUMBER
    NetLuid*: NET_LUID
    RequestId*: ULONG64
    Timeout*: ULONG
    Padding*: array[4, UCHAR]
  PNDIS_WMI_SET_HEADER* = ptr NDIS_WMI_SET_HEADER
  NDIS_WMI_EVENT_HEADER* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    IfIndex*: NET_IFINDEX
    NetLuid*: NET_LUID
    RequestId*: ULONG64
    PortNumber*: NDIS_PORT_NUMBER
    DeviceNameLength*: ULONG
    DeviceNameOffset*: ULONG
    Padding*: array[4, UCHAR]
  PNDIS_WMI_EVENT_HEADER* = ptr NDIS_WMI_EVENT_HEADER
  NDIS_WMI_ENUM_ADAPTER* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    IfIndex*: NET_IFINDEX
    NetLuid*: NET_LUID
    DeviceNameLength*: USHORT
    DeviceName*: array[1, CHAR]
  PNDIS_WMI_ENUM_ADAPTER* = ptr NDIS_WMI_ENUM_ADAPTER
  NDIS_HD_SPLIT_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    HDSplitCombineFlags*: ULONG
  PNDIS_HD_SPLIT_PARAMETERS* = ptr NDIS_HD_SPLIT_PARAMETERS
  NDIS_HD_SPLIT_CURRENT_CONFIG* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    HardwareCapabilities*: ULONG
    CurrentCapabilities*: ULONG
    HDSplitFlags*: ULONG
    HDSplitCombineFlags*: ULONG
    BackfillSize*: ULONG
    MaxHeaderSize*: ULONG
  PNDIS_HD_SPLIT_CURRENT_CONFIG* = ptr NDIS_HD_SPLIT_CURRENT_CONFIG
  NDIS_WMI_OUTPUT_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SupportedRevision*: UCHAR
    DataOffset*: ULONG
  PNDIS_WMI_OUTPUT_INFO* = ptr NDIS_WMI_OUTPUT_INFO
const
  NDIS_PM_MAX_STRING_SIZE* = 64
type
  NDIS_PM_COUNTED_STRING* {.pure.} = object
    Length*: USHORT
    String*: array[NDIS_PM_MAX_STRING_SIZE + 1, WCHAR]
  PNDIS_PM_COUNTED_STRING* = ptr NDIS_PM_COUNTED_STRING
  NDIS_PM_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SupportedWoLPacketPatterns*: ULONG
    NumTotalWoLPatterns*: ULONG
    MaxWoLPatternSize*: ULONG
    MaxWoLPatternOffset*: ULONG
    MaxWoLPacketSaveBuffer*: ULONG
    SupportedProtocolOffloads*: ULONG
    NumArpOffloadIPv4Addresses*: ULONG
    NumNSOffloadIPv6Addresses*: ULONG
    MinMagicPacketWakeUp*: NDIS_DEVICE_POWER_STATE
    MinPatternWakeUp*: NDIS_DEVICE_POWER_STATE
    MinLinkChangeWakeUp*: NDIS_DEVICE_POWER_STATE
    SupportedWakeUpEvents*: ULONG
    MediaSpecificWakeUpEvents*: ULONG
  PNDIS_PM_CAPABILITIES* = ptr NDIS_PM_CAPABILITIES
  NDIS_PM_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    EnabledWoLPacketPatterns*: ULONG
    EnabledProtocolOffloads*: ULONG
    WakeUpFlags*: ULONG
    MediaSpecificWakeUpEvents*: ULONG
  PNDIS_PM_PARAMETERS* = ptr NDIS_PM_PARAMETERS
  NDIS_PM_WOL_PATTERN_WoLPattern_IPv4TcpSynParameters* {.pure.} = object
    Flags*: ULONG
    IPv4SourceAddress*: array[4, UCHAR]
    IPv4DestAddress*: array[4, UCHAR]
    TCPSourcePortNumber*: USHORT
    TCPDestPortNumber*: USHORT
  NDIS_PM_WOL_PATTERN_WoLPattern_IPv6TcpSynParameters* {.pure.} = object
    Flags*: ULONG
    IPv6SourceAddress*: array[16, UCHAR]
    IPv6DestAddress*: array[16, UCHAR]
    TCPSourcePortNumber*: USHORT
    TCPDestPortNumber*: USHORT
  NDIS_PM_WOL_PATTERN_WoLPattern_EapolRequestIdMessageParameters* {.pure.} = object
    Flags*: ULONG
  NDIS_PM_WOL_PATTERN_WoLPattern_WoLBitMapPattern* {.pure.} = object
    Flags*: ULONG
    MaskOffset*: ULONG
    MaskSize*: ULONG
    PatternOffset*: ULONG
    PatternSize*: ULONG
  NDIS_PM_WOL_PATTERN_WoLPattern* {.pure, union.} = object
    IPv4TcpSynParameters*: NDIS_PM_WOL_PATTERN_WoLPattern_IPv4TcpSynParameters
    IPv6TcpSynParameters*: NDIS_PM_WOL_PATTERN_WoLPattern_IPv6TcpSynParameters
    EapolRequestIdMessageParameters*: NDIS_PM_WOL_PATTERN_WoLPattern_EapolRequestIdMessageParameters
    WoLBitMapPattern*: NDIS_PM_WOL_PATTERN_WoLPattern_WoLBitMapPattern
  NDIS_PM_WOL_PATTERN* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    Priority*: ULONG
    WoLPacketType*: NDIS_PM_WOL_PACKET
    FriendlyName*: NDIS_PM_COUNTED_STRING
    PatternId*: ULONG
    NextWoLPatternOffset*: ULONG
    WoLPattern*: NDIS_PM_WOL_PATTERN_WoLPattern
  PNDIS_PM_WOL_PATTERN* = ptr NDIS_PM_WOL_PATTERN
  NDIS_PM_PROTOCOL_OFFLOAD_ProtocolOffloadParameters_IPv4ARPParameters* {.pure.} = object
    Flags*: ULONG
    RemoteIPv4Address*: array[4, UCHAR]
    HostIPv4Address*: array[4, UCHAR]
    MacAddress*: array[6, UCHAR]
  NDIS_PM_PROTOCOL_OFFLOAD_ProtocolOffloadParameters_IPv6NSParameters* {.pure.} = object
    Flags*: ULONG
    RemoteIPv6Address*: array[16, UCHAR]
    SolicitedNodeIPv6Address*: array[16, UCHAR]
    MacAddress*: array[6, UCHAR]
    TargetIPv6Addresses*: array[2, array[16, UCHAR]]
const
  DOT11_RSN_KCK_LENGTH* = 16
  DOT11_RSN_KEK_LENGTH* = 16
type
  NDIS_PM_PROTOCOL_OFFLOAD_ProtocolOffloadParameters_Dot11RSNRekeyParameters* {.pure.} = object
    Flags*: ULONG
    KCK*: array[DOT11_RSN_KCK_LENGTH, UCHAR]
    KEK*: array[DOT11_RSN_KEK_LENGTH, UCHAR]
    KeyReplayCounter*: ULONGLONG
  NDIS_PM_PROTOCOL_OFFLOAD_ProtocolOffloadParameters* {.pure, union.} = object
    IPv4ARPParameters*: NDIS_PM_PROTOCOL_OFFLOAD_ProtocolOffloadParameters_IPv4ARPParameters
    IPv6NSParameters*: NDIS_PM_PROTOCOL_OFFLOAD_ProtocolOffloadParameters_IPv6NSParameters
    Dot11RSNRekeyParameters*: NDIS_PM_PROTOCOL_OFFLOAD_ProtocolOffloadParameters_Dot11RSNRekeyParameters
  NDIS_PM_PROTOCOL_OFFLOAD* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    Priority*: ULONG
    ProtocolOffloadType*: NDIS_PM_PROTOCOL_OFFLOAD_TYPE
    FriendlyName*: NDIS_PM_COUNTED_STRING
    ProtocolOffloadId*: ULONG
    NextProtocolOffloadOffset*: ULONG
    ProtocolOffloadParameters*: NDIS_PM_PROTOCOL_OFFLOAD_ProtocolOffloadParameters
  PNDIS_PM_PROTOCOL_OFFLOAD* = ptr NDIS_PM_PROTOCOL_OFFLOAD
  NDIS_PM_WAKE_REASON* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    WakeReason*: NDIS_PM_WAKE_REASON_TYPE
    InfoBufferOffset*: ULONG
    InfoBufferSize*: ULONG
  PNDIS_PM_WAKE_REASON* = ptr NDIS_PM_WAKE_REASON
  NDIS_PM_WAKE_PACKET* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PatternId*: ULONG
    PatternFriendlyName*: NDIS_PM_COUNTED_STRING
    OriginalPacketSize*: ULONG
    SavedPacketSize*: ULONG
    SavedPacketOffset*: ULONG
  PNDIS_PM_WAKE_PACKET* = ptr NDIS_PM_WAKE_PACKET
  NDIS_WMI_PM_ADMIN_CONFIG* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    WakeOnPattern*: NDIS_PM_ADMIN_CONFIG_STATE
    WakeOnMagicPacket*: NDIS_PM_ADMIN_CONFIG_STATE
    DeviceSleepOnDisconnect*: NDIS_PM_ADMIN_CONFIG_STATE
    PMARPOffload*: NDIS_PM_ADMIN_CONFIG_STATE
    PMNSOffload*: NDIS_PM_ADMIN_CONFIG_STATE
    PMWiFiRekeyOffload*: NDIS_PM_ADMIN_CONFIG_STATE
  PNDIS_WMI_PM_ADMIN_CONFIG* = ptr NDIS_WMI_PM_ADMIN_CONFIG
  NDIS_WMI_PM_ACTIVE_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    WakeOnPattern*: NDIS_PM_CAPABILITY_STATE
    WakeOnMagicPacket*: NDIS_PM_CAPABILITY_STATE
    DeviceSleepOnDisconnect*: NDIS_PM_CAPABILITY_STATE
    PMARPOffload*: NDIS_PM_CAPABILITY_STATE
    PMNSOffload*: NDIS_PM_CAPABILITY_STATE
    PMWiFiRekeyOffload*: NDIS_PM_CAPABILITY_STATE
  PNDIS_WMI_PM_ACTIVE_CAPABILITIES* = ptr NDIS_WMI_PM_ACTIVE_CAPABILITIES
  NDIS_RECEIVE_FILTER_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    EnabledFilterTypes*: ULONG
    EnabledQueueTypes*: ULONG
    NumQueues*: ULONG
    SupportedQueueProperties*: ULONG
    SupportedFilterTests*: ULONG
    SupportedHeaders*: ULONG
    SupportedMacHeaderFields*: ULONG
    MaxMacHeaderFilters*: ULONG
    MaxQueueGroups*: ULONG
    MaxQueuesPerQueueGroup*: ULONG
    MinLookaheadSplitSize*: ULONG
    MaxLookaheadSplitSize*: ULONG
    SupportedARPHeaderFields*: ULONG
    SupportedIPv4HeaderFields*: ULONG
    SupportedIPv6HeaderFields*: ULONG
    SupportedUdpHeaderFields*: ULONG
    MaxFieldTestsPerPacketCoalescingFilter*: ULONG
    MaxPacketCoalescingFilters*: ULONG
    NdisReserved*: ULONG
  PNDIS_RECEIVE_FILTER_CAPABILITIES* = ptr NDIS_RECEIVE_FILTER_CAPABILITIES
  NDIS_NIC_SWITCH_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    NdisReserved1*: ULONG
    NumTotalMacAddresses*: ULONG
    NumMacAddressesPerPort*: ULONG
    NumVlansPerPort*: ULONG
    NdisReserved2*: ULONG
    NdisReserved3*: ULONG
    NicSwitchCapabilities*: ULONG
    MaxNumSwitches*: ULONG
    MaxNumVPorts*: ULONG
    NdisReserved4*: ULONG
    MaxNumVFs*: ULONG
    MaxNumQueuePairs*: ULONG
    NdisReserved5*: ULONG
    NdisReserved6*: ULONG
    NdisReserved7*: ULONG
    MaxNumQueuePairsPerNonDefaultVPort*: ULONG
    NdisReserved8*: ULONG
    NdisReserved9*: ULONG
    NdisReserved10*: ULONG
    NdisReserved11*: ULONG
    NdisReserved12*: ULONG
    MaxNumMacAddresses*: ULONG
    NdisReserved13*: ULONG
    NdisReserved14*: ULONG
    NdisReserved15*: ULONG
    NdisReserved16*: ULONG
    NdisReserved17*: ULONG
  PNDIS_NIC_SWITCH_CAPABILITIES* = ptr NDIS_NIC_SWITCH_CAPABILITIES
  NDIS_RECEIVE_FILTER_GLOBAL_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    EnabledFilterTypes*: ULONG
    EnabledQueueTypes*: ULONG
  PNDIS_RECEIVE_FILTER_GLOBAL_PARAMETERS* = ptr NDIS_RECEIVE_FILTER_GLOBAL_PARAMETERS
  NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_HeaderField* {.pure, union.} = object
    MacHeaderField*: NDIS_MAC_HEADER_FIELD
    ArpHeaderField*: NDIS_ARP_HEADER_FIELD
    IPv4HeaderField*: NDIS_IPV4_HEADER_FIELD
    IPv6HeaderField*: NDIS_IPV6_HEADER_FIELD
    UdpHeaderField*: NDIS_UDP_HEADER_FIELD
  NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_FieldValue* {.pure, union.} = object
    FieldByteValue*: UCHAR
    FieldShortValue*: USHORT
    FieldLongValue*: ULONG
    FieldLong64Value*: ULONG64
    FieldByteArrayValue*: array[16, UCHAR]
  NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_ResultValue* {.pure, union.} = object
    ResultByteValue*: UCHAR
    ResultShortValue*: USHORT
    ResultLongValue*: ULONG
    ResultLong64Value*: ULONG64
    ResultByteArrayValue*: array[16, UCHAR]
  NDIS_RECEIVE_FILTER_FIELD_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FrameHeader*: NDIS_FRAME_HEADER
    ReceiveFilterTest*: NDIS_RECEIVE_FILTER_TEST
    HeaderField*: NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_HeaderField
    FieldValue*: NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_FieldValue
    ResultValue*: NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_ResultValue
  PNDIS_RECEIVE_FILTER_FIELD_PARAMETERS* = ptr NDIS_RECEIVE_FILTER_FIELD_PARAMETERS
  NDIS_RECEIVE_FILTER_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FilterType*: NDIS_RECEIVE_FILTER_TYPE
    QueueId*: NDIS_RECEIVE_QUEUE_ID
    FilterId*: NDIS_RECEIVE_FILTER_ID
    FieldParametersArrayOffset*: ULONG
    FieldParametersArrayNumElements*: ULONG
    FieldParametersArrayElementSize*: ULONG
    RequestedFilterIdBitCount*: ULONG
    MaxCoalescingDelay*: ULONG
    VPortId*: NDIS_NIC_SWITCH_VPORT_ID
  PNDIS_RECEIVE_FILTER_PARAMETERS* = ptr NDIS_RECEIVE_FILTER_PARAMETERS
  NDIS_RECEIVE_FILTER_CLEAR_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    QueueId*: NDIS_RECEIVE_QUEUE_ID
    FilterId*: NDIS_RECEIVE_FILTER_ID
  PNDIS_RECEIVE_FILTER_CLEAR_PARAMETERS* = ptr NDIS_RECEIVE_FILTER_CLEAR_PARAMETERS
  NDIS_QUEUE_NAME* = NDIS_IF_COUNTED_STRING
  PNDIS_QUEUE_NAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_VM_NAME* = NDIS_IF_COUNTED_STRING
  PNDIS_VM_NAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_VM_FRIENDLYNAME* = NDIS_IF_COUNTED_STRING
  PNDIS_VM_FRIENDLYNAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_PORT_PROPERTY_PROFILE_NAME* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_PORT_PROPERTY_PROFILE_NAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_PORT_PROPERTY_PROFILE_CDN_LABEL* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_PORT_PROPERTY_PROFILE_CDN_LABEL* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_NAME* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_NAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_FRIENDLYNAME* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_FRIENDLYNAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_PORT_NAME* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_PORT_NAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_PORT_FRIENDLYNAME* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_PORT_FRIENDLYNAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_NIC_NAME* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_NIC_NAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_NIC_FRIENDLYNAME* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_NIC_FRIENDLYNAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_SWITCH_EXTENSION_FRIENDLYNAME* = NDIS_IF_COUNTED_STRING
  PNDIS_SWITCH_EXTENSION_FRIENDLYNAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_VENDOR_NAME* = NDIS_IF_COUNTED_STRING
  PNDIS_VENDOR_NAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_RECEIVE_QUEUE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    QueueType*: NDIS_RECEIVE_QUEUE_TYPE
    QueueId*: NDIS_RECEIVE_QUEUE_ID
    QueueGroupId*: NDIS_RECEIVE_QUEUE_GROUP_ID
    ProcessorAffinity*: GROUP_AFFINITY
    NumSuggestedReceiveBuffers*: ULONG
    MSIXTableEntry*: ULONG
    LookaheadSize*: ULONG
    VmName*: NDIS_VM_NAME
    QueueName*: NDIS_QUEUE_NAME
    PortId*: ULONG
    InterruptCoalescingDomainId*: ULONG
  PNDIS_RECEIVE_QUEUE_PARAMETERS* = ptr NDIS_RECEIVE_QUEUE_PARAMETERS
  NDIS_RECEIVE_QUEUE_FREE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    QueueId*: NDIS_RECEIVE_QUEUE_ID
  PNDIS_RECEIVE_QUEUE_FREE_PARAMETERS* = ptr NDIS_RECEIVE_QUEUE_FREE_PARAMETERS
  NDIS_RECEIVE_QUEUE_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    QueueType*: NDIS_RECEIVE_QUEUE_TYPE
    QueueId*: NDIS_RECEIVE_QUEUE_ID
    QueueGroupId*: NDIS_RECEIVE_QUEUE_GROUP_ID
    QueueState*: NDIS_RECEIVE_QUEUE_OPERATIONAL_STATE
    ProcessorAffinity*: GROUP_AFFINITY
    NumSuggestedReceiveBuffers*: ULONG
    MSIXTableEntry*: ULONG
    LookaheadSize*: ULONG
    VmName*: NDIS_VM_NAME
    QueueName*: NDIS_QUEUE_NAME
    NumFilters*: ULONG
    InterruptCoalescingDomainId*: ULONG
  PNDIS_RECEIVE_QUEUE_INFO* = ptr NDIS_RECEIVE_QUEUE_INFO
  NDIS_RECEIVE_QUEUE_INFO_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    FirstElementOffset*: ULONG
    NumElements*: ULONG
    ElementSize*: ULONG
  PNDIS_RECEIVE_QUEUE_INFO_ARRAY* = ptr NDIS_RECEIVE_QUEUE_INFO_ARRAY
  NDIS_RECEIVE_FILTER_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FilterType*: NDIS_RECEIVE_FILTER_TYPE
    FilterId*: NDIS_RECEIVE_FILTER_ID
  PNDIS_RECEIVE_FILTER_INFO* = ptr NDIS_RECEIVE_FILTER_INFO
  NDIS_RECEIVE_FILTER_INFO_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    QueueId*: NDIS_RECEIVE_QUEUE_ID
    FirstElementOffset*: ULONG
    NumElements*: ULONG
    ElementSize*: ULONG
    Flags*: ULONG
    VPortId*: NDIS_NIC_SWITCH_VPORT_ID
  PNDIS_RECEIVE_FILTER_INFO_ARRAY* = ptr NDIS_RECEIVE_FILTER_INFO_ARRAY
  NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    QueueId*: NDIS_RECEIVE_QUEUE_ID
    CompletionStatus*: NDIS_STATUS
  PNDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_PARAMETERS* = ptr NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_PARAMETERS
  NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FirstElementOffset*: ULONG
    NumElements*: ULONG
    ElementSize*: ULONG
  PNDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_ARRAY* = ptr NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_ARRAY
  NDIS_RECEIVE_SCALE_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    CapabilitiesFlags*: ULONG
    NumberOfInterruptMessages*: ULONG
    NumberOfReceiveQueues*: ULONG
    NumberOfIndirectionTableEntries*: USHORT
  PNDIS_RECEIVE_SCALE_CAPABILITIES* = ptr NDIS_RECEIVE_SCALE_CAPABILITIES
  NDIS_RECEIVE_SCALE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: USHORT
    BaseCpuNumber*: USHORT
    HashInformation*: ULONG
    IndirectionTableSize*: USHORT
    IndirectionTableOffset*: ULONG
    HashSecretKeySize*: USHORT
    HashSecretKeyOffset*: ULONG
    ProcessorMasksOffset*: ULONG
    NumberOfProcessorMasks*: ULONG
    ProcessorMasksEntrySize*: ULONG
  PNDIS_RECEIVE_SCALE_PARAMETERS* = ptr NDIS_RECEIVE_SCALE_PARAMETERS
  NDIS_RECEIVE_HASH_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    HashInformation*: ULONG
    HashSecretKeySize*: USHORT
    HashSecretKeyOffset*: ULONG
  PNDIS_RECEIVE_HASH_PARAMETERS* = ptr NDIS_RECEIVE_HASH_PARAMETERS
  NDIS_RSS_PROCESSOR* {.pure.} = object
    ProcNum*: PROCESSOR_NUMBER
    PreferenceIndex*: USHORT
    Reserved*: USHORT
  PNDIS_RSS_PROCESSOR* = ptr NDIS_RSS_PROCESSOR
  NDIS_RSS_PROCESSOR_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    RssBaseProcessor*: PROCESSOR_NUMBER
    MaxNumRssProcessors*: ULONG
    PreferredNumaNode*: USHORT
    RssProcessorArrayOffset*: ULONG
    RssProcessorCount*: ULONG
    RssProcessorEntrySize*: ULONG
    RssMaxProcessor*: PROCESSOR_NUMBER
    RssProfile*: NDIS_RSS_PROFILE
  PNDIS_RSS_PROCESSOR_INFO* = ptr NDIS_RSS_PROCESSOR_INFO
  NDIS_PROCESSOR_INFO_EX* {.pure.} = object
    ProcNum*: PROCESSOR_NUMBER
    SocketId*: ULONG
    CoreId*: ULONG
    HyperThreadId*: ULONG
    NodeId*: USHORT
    NodeDistance*: USHORT
  PNDIS_PROCESSOR_INFO_EX* = ptr NDIS_PROCESSOR_INFO_EX
  NDIS_SYSTEM_PROCESSOR_INFO_EX* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    ProcessorVendor*: NDIS_PROCESSOR_VENDOR
    NumSockets*: ULONG
    NumCores*: ULONG
    NumCoresPerSocket*: ULONG
    MaxHyperThreadingProcsPerCore*: ULONG
    ProcessorInfoOffset*: ULONG
    NumberOfProcessors*: ULONG
    ProcessorInfoEntrySize*: ULONG
  PNDIS_SYSTEM_PROCESSOR_INFO_EX* = ptr NDIS_SYSTEM_PROCESSOR_INFO_EX
  NDIS_HYPERVISOR_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PartitionType*: NDIS_HYPERVISOR_PARTITION_TYPE
  PNDIS_HYPERVISOR_INFO* = ptr NDIS_HYPERVISOR_INFO
  NDIS_WMI_GROUP_AFFINITY* {.pure.} = object
    Mask*: ULONG64
    Group*: USHORT
    Reserved*: array[3, USHORT]
  PNDIS_WMI_GROUP_AFFINITY* = ptr NDIS_WMI_GROUP_AFFINITY
  NDIS_WMI_RECEIVE_QUEUE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    QueueType*: NDIS_RECEIVE_QUEUE_TYPE
    QueueId*: NDIS_RECEIVE_QUEUE_ID
    QueueGroupId*: NDIS_RECEIVE_QUEUE_GROUP_ID
    ProcessorAffinity*: NDIS_WMI_GROUP_AFFINITY
    NumSuggestedReceiveBuffers*: ULONG
    MSIXTableEntry*: ULONG
    LookaheadSize*: ULONG
    VmName*: NDIS_VM_NAME
    QueueName*: NDIS_QUEUE_NAME
  PNDIS_WMI_RECEIVE_QUEUE_PARAMETERS* = ptr NDIS_WMI_RECEIVE_QUEUE_PARAMETERS
  NDIS_WMI_RECEIVE_QUEUE_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    QueueType*: NDIS_RECEIVE_QUEUE_TYPE
    QueueId*: NDIS_RECEIVE_QUEUE_ID
    QueueGroupId*: NDIS_RECEIVE_QUEUE_GROUP_ID
    QueueState*: NDIS_RECEIVE_QUEUE_OPERATIONAL_STATE
    ProcessorAffinity*: NDIS_WMI_GROUP_AFFINITY
    NumSuggestedReceiveBuffers*: ULONG
    MSIXTableEntry*: ULONG
    LookaheadSize*: ULONG
    VmName*: NDIS_VM_NAME
    QueueName*: NDIS_QUEUE_NAME
  PNDIS_WMI_RECEIVE_QUEUE_INFO* = ptr NDIS_WMI_RECEIVE_QUEUE_INFO
  NDIS_NDK_PERFORMANCE_COUNTERS* {.pure.} = object
    Connect*: ULONG64
    Accept*: ULONG64
    ConnectFailure*: ULONG64
    ConnectionError*: ULONG64
    ActiveConnection*: ULONG64
    Reserved01*: ULONG64
    Reserved02*: ULONG64
    Reserved03*: ULONG64
    Reserved04*: ULONG64
    Reserved05*: ULONG64
    Reserved06*: ULONG64
    Reserved07*: ULONG64
    Reserved08*: ULONG64
    Reserved09*: ULONG64
    Reserved10*: ULONG64
    Reserved11*: ULONG64
    Reserved12*: ULONG64
    Reserved13*: ULONG64
    Reserved14*: ULONG64
    Reserved15*: ULONG64
    Reserved16*: ULONG64
    Reserved17*: ULONG64
    Reserved18*: ULONG64
    Reserved19*: ULONG64
    Reserved20*: ULONG64
    CQError*: ULONG64
    RDMAInOctets*: ULONG64
    RDMAOutOctets*: ULONG64
    RDMAInFrames*: ULONG64
    RDMAOutFrames*: ULONG64
  PNDIS_NDK_PERFORMANCE_COUNTERS* = ptr NDIS_NDK_PERFORMANCE_COUNTERS
  NDK_VERSION* {.pure.} = object
    Major*: USHORT
    Minor*: USHORT
  NDK_ADAPTER_INFO* {.pure.} = object
    Version*: NDK_VERSION
    VendorId*: UINT32
    DeviceId*: UINT32
    MaxRegistrationSize*: SIZE_T
    MaxWindowSize*: SIZE_T
    FRMRPageCount*: ULONG
    MaxInitiatorRequestSge*: ULONG
    MaxReceiveRequestSge*: ULONG
    MaxReadRequestSge*: ULONG
    MaxTransferLength*: ULONG
    MaxInlineDataSize*: ULONG
    MaxInboundReadLimit*: ULONG
    MaxOutboundReadLimit*: ULONG
    MaxReceiveQueueDepth*: ULONG
    MaxInitiatorQueueDepth*: ULONG
    MaxSrqDepth*: ULONG
    MaxCqDepth*: ULONG
    LargeRequestThreshold*: ULONG
    MaxCallerData*: ULONG
    MaxCalleeData*: ULONG
    AdapterFlags*: ULONG
  NDIS_NDK_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    MaxQpCount*: ULONG
    MaxCqCount*: ULONG
    MaxMrCount*: ULONG
    MaxPdCount*: ULONG
    MaxInboundReadLimit*: ULONG
    MaxOutboundReadLimit*: ULONG
    MaxMwCount*: ULONG
    MaxSrqCount*: ULONG
    MissingCounterMask*: ULONG64
    NdkInfo*: ptr NDK_ADAPTER_INFO
  PNDIS_NDK_CAPABILITIES* = ptr NDIS_NDK_CAPABILITIES
  NDK_WMI_ADAPTER_INFO* {.pure.} = object
    Version*: NDK_VERSION
    VendorId*: UINT32
    DeviceId*: UINT32
    MaxRegistrationSize*: ULONGLONG
    MaxWindowSize*: ULONGLONG
    FRMRPageCount*: ULONG
    MaxInitiatorRequestSge*: ULONG
    MaxReceiveRequestSge*: ULONG
    MaxReadRequestSge*: ULONG
    MaxTransferLength*: ULONG
    MaxInlineDataSize*: ULONG
    MaxInboundReadLimit*: ULONG
    MaxOutboundReadLimit*: ULONG
    MaxReceiveQueueDepth*: ULONG
    MaxInitiatorQueueDepth*: ULONG
    MaxSrqDepth*: ULONG
    MaxCqDepth*: ULONG
    LargeRequestThreshold*: ULONG
    MaxCallerData*: ULONG
    MaxCalleeData*: ULONG
    AdapterFlags*: ULONG
  PNDK_WMI_ADAPTER_INFO* = ptr NDK_WMI_ADAPTER_INFO
  NDIS_WMI_NDK_CAPABILITIES* {.pure.} = object
    MaxQpCount*: ULONG
    MaxCqCount*: ULONG
    MaxMrCount*: ULONG
    MaxPdCount*: ULONG
    MaxInboundReadLimit*: ULONG
    MaxOutboundReadLimit*: ULONG
    MaxMwCount*: ULONG
    MaxSrqCount*: ULONG
    MissingCounterMask*: ULONG64
    NdkInfo*: NDK_WMI_ADAPTER_INFO
  PNDIS_WMI_NDK_CAPABILITIES* = ptr NDIS_WMI_NDK_CAPABILITIES
  NDIS_QOS_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    MaxNumTrafficClasses*: ULONG
    MaxNumEtsCapableTrafficClasses*: ULONG
    MaxNumPfcEnabledTrafficClasses*: ULONG
  PNDIS_QOS_CAPABILITIES* = ptr NDIS_QOS_CAPABILITIES
  NDIS_QOS_CLASSIFICATION_ELEMENT* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    ConditionSelector*: USHORT
    ConditionField*: USHORT
    ActionSelector*: USHORT
    ActionField*: USHORT
  PNDIS_QOS_CLASSIFICATION_ELEMENT* = ptr NDIS_QOS_CLASSIFICATION_ELEMENT
const
  NDIS_QOS_MAXIMUM_PRIORITIES* = 8
  NDIS_QOS_MAXIMUM_TRAFFIC_CLASSES* = 8
type
  NDIS_QOS_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    NumTrafficClasses*: ULONG
    PriorityAssignmentTable*: array[NDIS_QOS_MAXIMUM_PRIORITIES, UCHAR]
    TcBandwidthAssignmentTable*: array[NDIS_QOS_MAXIMUM_TRAFFIC_CLASSES, UCHAR]
    TsaAssignmentTable*: array[NDIS_QOS_MAXIMUM_TRAFFIC_CLASSES, UCHAR]
    PfcEnable*: ULONG
    NumClassificationElements*: ULONG
    ClassificationElementSize*: ULONG
    FirstClassificationElementOffset*: ULONG
  PNDIS_QOS_PARAMETERS* = ptr NDIS_QOS_PARAMETERS
  NDIS_NIC_SWITCH_FRIENDLYNAME* = NDIS_IF_COUNTED_STRING
  PNDIS_NIC_SWITCH_FRIENDLYNAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_VPORT_NAME* = NDIS_IF_COUNTED_STRING
  PNDIS_VPORT_NAME* = ptr NDIS_IF_COUNTED_STRING
  NDIS_NIC_SWITCH_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchType*: NDIS_NIC_SWITCH_TYPE
    SwitchId*: NDIS_NIC_SWITCH_ID
    SwitchFriendlyName*: NDIS_NIC_SWITCH_FRIENDLYNAME
    NumVFs*: ULONG
    NdisReserved1*: ULONG
    NdisReserved2*: ULONG
    NdisReserved3*: ULONG
  PNDIS_NIC_SWITCH_PARAMETERS* = ptr NDIS_NIC_SWITCH_PARAMETERS
  NDIS_NIC_SWITCH_DELETE_SWITCH_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchId*: NDIS_NIC_SWITCH_ID
  PNDIS_NIC_SWITCH_DELETE_SWITCH_PARAMETERS* = ptr NDIS_NIC_SWITCH_DELETE_SWITCH_PARAMETERS
  NDIS_NIC_SWITCH_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchType*: NDIS_NIC_SWITCH_TYPE
    SwitchId*: NDIS_NIC_SWITCH_ID
    SwitchFriendlyName*: NDIS_NIC_SWITCH_FRIENDLYNAME
    NumVFs*: ULONG
    NumAllocatedVFs*: ULONG
    NumVPorts*: ULONG
    NumActiveVPorts*: ULONG
    NumQueuePairsForDefaultVPort*: ULONG
    NumQueuePairsForNonDefaultVPorts*: ULONG
    NumActiveDefaultVPortMacAddresses*: ULONG
    NumActiveNonDefaultVPortMacAddresses*: ULONG
    NumActiveDefaultVPortVlanIds*: ULONG
    NumActiveNonDefaultVPortVlanIds*: ULONG
  PNDIS_NIC_SWITCH_INFO* = ptr NDIS_NIC_SWITCH_INFO
  NDIS_NIC_SWITCH_INFO_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    FirstElementOffset*: ULONG
    NumElements*: ULONG
    ElementSize*: ULONG
  PNDIS_NIC_SWITCH_INFO_ARRAY* = ptr NDIS_NIC_SWITCH_INFO_ARRAY
  NDIS_NIC_SWITCH_VPORT_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchId*: NDIS_NIC_SWITCH_ID
    VPortId*: NDIS_NIC_SWITCH_VPORT_ID
    VPortName*: NDIS_VPORT_NAME
    AttachedFunctionId*: NDIS_SRIOV_FUNCTION_ID
    NumQueuePairs*: ULONG
    InterruptModeration*: NDIS_NIC_SWITCH_VPORT_INTERRUPT_MODERATION
    VPortState*: NDIS_NIC_SWITCH_VPORT_STATE
    ProcessorAffinity*: GROUP_AFFINITY
    LookaheadSize*: ULONG
  PNDIS_NIC_SWITCH_VPORT_PARAMETERS* = ptr NDIS_NIC_SWITCH_VPORT_PARAMETERS
  NDIS_NIC_SWITCH_DELETE_VPORT_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    VPortId*: NDIS_NIC_SWITCH_VPORT_ID
  PNDIS_NIC_SWITCH_DELETE_VPORT_PARAMETERS* = ptr NDIS_NIC_SWITCH_DELETE_VPORT_PARAMETERS
  NDIS_NIC_SWITCH_VPORT_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VPortId*: NDIS_NIC_SWITCH_VPORT_ID
    Flags*: ULONG
    SwitchId*: NDIS_NIC_SWITCH_ID
    VPortName*: NDIS_VPORT_NAME
    AttachedFunctionId*: NDIS_SRIOV_FUNCTION_ID
    NumQueuePairs*: ULONG
    InterruptModeration*: NDIS_NIC_SWITCH_VPORT_INTERRUPT_MODERATION
    VPortState*: NDIS_NIC_SWITCH_VPORT_STATE
    ProcessorAffinity*: GROUP_AFFINITY
    LookaheadSize*: ULONG
    NumFilters*: ULONG
  PNDIS_NIC_SWITCH_VPORT_INFO* = ptr NDIS_NIC_SWITCH_VPORT_INFO
  NDIS_NIC_SWITCH_VPORT_INFO_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchId*: NDIS_NIC_SWITCH_ID
    AttachedFunctionId*: NDIS_SRIOV_FUNCTION_ID
    FirstElementOffset*: ULONG
    NumElements*: ULONG
    ElementSize*: ULONG
  PNDIS_NIC_SWITCH_VPORT_INFO_ARRAY* = ptr NDIS_NIC_SWITCH_VPORT_INFO_ARRAY
const
  NDIS_MAX_PHYS_ADDRESS_LENGTH* = IF_MAX_PHYS_ADDRESS_LENGTH
type
  NDIS_NIC_SWITCH_VF_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchId*: NDIS_NIC_SWITCH_ID
    VMName*: NDIS_VM_NAME
    VMFriendlyName*: NDIS_VM_FRIENDLYNAME
    NicName*: NDIS_SWITCH_NIC_NAME
    MacAddressLength*: USHORT
    PermanentMacAddress*: array[NDIS_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    CurrentMacAddress*: array[NDIS_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    VFId*: NDIS_SRIOV_FUNCTION_ID
    RequestorId*: NDIS_VF_RID
  PNDIS_NIC_SWITCH_VF_PARAMETERS* = ptr NDIS_NIC_SWITCH_VF_PARAMETERS
  NDIS_NIC_SWITCH_FREE_VF_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    VFId*: NDIS_SRIOV_FUNCTION_ID
  PNDIS_NIC_SWITCH_FREE_VF_PARAMETERS* = ptr NDIS_NIC_SWITCH_FREE_VF_PARAMETERS
  NDIS_NIC_SWITCH_VF_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchId*: NDIS_NIC_SWITCH_ID
    VMName*: NDIS_VM_NAME
    VMFriendlyName*: NDIS_VM_FRIENDLYNAME
    NicName*: NDIS_SWITCH_NIC_NAME
    MacAddressLength*: USHORT
    PermanentMacAddress*: array[NDIS_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    CurrentMacAddress*: array[NDIS_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    VFId*: NDIS_SRIOV_FUNCTION_ID
    RequestorId*: NDIS_VF_RID
  PNDIS_NIC_SWITCH_VF_INFO* = ptr NDIS_NIC_SWITCH_VF_INFO
  NDIS_NIC_SWITCH_VF_INFO_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchId*: NDIS_NIC_SWITCH_ID
    FirstElementOffset*: ULONG
    NumElements*: ULONG
    ElementSize*: ULONG
  PNDIS_NIC_SWITCH_VF_INFO_ARRAY* = ptr NDIS_NIC_SWITCH_VF_INFO_ARRAY
  NDIS_SRIOV_CAPABILITIES* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SriovCapabilities*: ULONG
  PNDIS_SRIOV_CAPABILITIES* = ptr NDIS_SRIOV_CAPABILITIES
  NDIS_SRIOV_READ_VF_CONFIG_SPACE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VFId*: NDIS_SRIOV_FUNCTION_ID
    Offset*: ULONG
    Length*: ULONG
    BufferOffset*: ULONG
  PNDIS_SRIOV_READ_VF_CONFIG_SPACE_PARAMETERS* = ptr NDIS_SRIOV_READ_VF_CONFIG_SPACE_PARAMETERS
  NDIS_SRIOV_WRITE_VF_CONFIG_SPACE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VFId*: NDIS_SRIOV_FUNCTION_ID
    Offset*: ULONG
    Length*: ULONG
    BufferOffset*: ULONG
  PNDIS_SRIOV_WRITE_VF_CONFIG_SPACE_PARAMETERS* = ptr NDIS_SRIOV_WRITE_VF_CONFIG_SPACE_PARAMETERS
  NDIS_SRIOV_READ_VF_CONFIG_BLOCK_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VFId*: NDIS_SRIOV_FUNCTION_ID
    BlockId*: ULONG
    Length*: ULONG
    BufferOffset*: ULONG
  PNDIS_SRIOV_READ_VF_CONFIG_BLOCK_PARAMETERS* = ptr NDIS_SRIOV_READ_VF_CONFIG_BLOCK_PARAMETERS
  NDIS_SRIOV_WRITE_VF_CONFIG_BLOCK_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VFId*: NDIS_SRIOV_FUNCTION_ID
    BlockId*: ULONG
    Length*: ULONG
    BufferOffset*: ULONG
  PNDIS_SRIOV_WRITE_VF_CONFIG_BLOCK_PARAMETERS* = ptr NDIS_SRIOV_WRITE_VF_CONFIG_BLOCK_PARAMETERS
  NDIS_SRIOV_RESET_VF_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VFId*: NDIS_SRIOV_FUNCTION_ID
  PNDIS_SRIOV_RESET_VF_PARAMETERS* = ptr NDIS_SRIOV_RESET_VF_PARAMETERS
  NDIS_SRIOV_SET_VF_POWER_STATE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VFId*: NDIS_SRIOV_FUNCTION_ID
    PowerState*: NDIS_DEVICE_POWER_STATE
    WakeEnable*: BOOLEAN
  PNDIS_SRIOV_SET_VF_POWER_STATE_PARAMETERS* = ptr NDIS_SRIOV_SET_VF_POWER_STATE_PARAMETERS
  NDIS_SRIOV_CONFIG_STATE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    BlockId*: ULONG
    Length*: ULONG
  PNDIS_SRIOV_CONFIG_STATE_PARAMETERS* = ptr NDIS_SRIOV_CONFIG_STATE_PARAMETERS
  NDIS_SRIOV_VF_VENDOR_DEVICE_ID_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VFId*: NDIS_SRIOV_FUNCTION_ID
    VendorId*: USHORT
    DeviceId*: USHORT
  PNDIS_SRIOV_VF_VENDOR_DEVICE_ID_INFO* = ptr NDIS_SRIOV_VF_VENDOR_DEVICE_ID_INFO
  NDIS_SRIOV_PROBED_BARS_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    BaseRegisterValuesOffset*: ULONG
  PNDIS_SRIOV_PROBED_BARS_INFO* = ptr NDIS_SRIOV_PROBED_BARS_INFO
  NDIS_RECEIVE_FILTER_MOVE_FILTER_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    FilterId*: NDIS_RECEIVE_FILTER_ID
    SourceQueueId*: NDIS_RECEIVE_QUEUE_ID
    SourceVPortId*: NDIS_NIC_SWITCH_VPORT_ID
    DestQueueId*: NDIS_RECEIVE_QUEUE_ID
    DestVPortId*: NDIS_NIC_SWITCH_VPORT_ID
  PNDIS_RECEIVE_FILTER_MOVE_FILTER_PARAMETERS* = ptr NDIS_RECEIVE_FILTER_MOVE_FILTER_PARAMETERS
  NDIS_SRIOV_BAR_RESOURCES_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    VFId*: NDIS_SRIOV_FUNCTION_ID
    BarIndex*: USHORT
    BarResourcesOffset*: ULONG
  PNDIS_SRIOV_BAR_RESOURCES_INFO* = ptr NDIS_SRIOV_BAR_RESOURCES_INFO
  NDIS_SRIOV_PF_LUID_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Luid*: LUID
  PNDIS_SRIOV_PF_LUID_INFO* = ptr NDIS_SRIOV_PF_LUID_INFO
  NDIS_SRIOV_VF_SERIAL_NUMBER_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    SerialNumber*: ULONG
  PNDIS_SRIOV_VF_SERIAL_NUMBER_INFO* = ptr NDIS_SRIOV_VF_SERIAL_NUMBER_INFO
  NDIS_SRIOV_VF_INVALIDATE_CONFIG_BLOCK_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    BlockMask*: ULONG64
  PNDIS_SRIOV_VF_INVALIDATE_CONFIG_BLOCK_INFO* = ptr NDIS_SRIOV_VF_INVALIDATE_CONFIG_BLOCK_INFO
  NDIS_SWITCH_OBJECT_INSTANCE_ID* = GUID
  PNDIS_SWITCH_OBJECT_INSTANCE_ID* = ptr GUID
  NDIS_SWITCH_OBJECT_ID* = GUID
  PNDIS_SWITCH_OBJECT_ID* = ptr GUID
  NDIS_SWITCH_PORT_ID* = UINT32
  PNDIS_SWITCH_PORT_ID* = ptr UINT32
  NDIS_SWITCH_PORT_PROPERTY_SECURITY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    AllowMacSpoofing*: BOOLEAN
    AllowIeeePriorityTag*: BOOLEAN
    VirtualSubnetId*: UINT32
    AllowTeaming*: BOOLEAN
  PNDIS_SWITCH_PORT_PROPERTY_SECURITY* = ptr NDIS_SWITCH_PORT_PROPERTY_SECURITY
  NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_VlanProperties* {.pure.} = object
    AccessVlanId*: UINT16
    NativeVlanId*: UINT16
    PruneVlanIdArray*: array[64, UINT64]
    TrunkVlanIdArray*: array[64, UINT64]
  NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_PvlanProperties_UNION1* {.pure, union.} = object
    SecondaryVlanId*: UINT16
    SecondaryVlanIdArray*: array[64, UINT64]
  NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_PvlanProperties* {.pure.} = object
    PvlanMode*: NDIS_SWITCH_PORT_PVLAN_MODE
    PrimaryVlanId*: UINT16
    union1*: NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_PvlanProperties_UNION1
  NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1* {.pure, union.} = object
    VlanProperties*: NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_VlanProperties
    PvlanProperties*: NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_PvlanProperties
  NDIS_SWITCH_PORT_PROPERTY_VLAN* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    OperationMode*: NDIS_SWITCH_PORT_VLAN_MODE
    union1*: NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1
  PNDIS_SWITCH_PORT_PROPERTY_VLAN* = ptr NDIS_SWITCH_PORT_PROPERTY_VLAN
  NDIS_SWITCH_PORT_PROPERTY_PROFILE_PciLocation* {.pure.} = object
    PciSegmentNumber* {.bitsize:16.}: UINT32
    PciBusNumber* {.bitsize:8.}: UINT32
    PciDeviceNumber* {.bitsize:5.}: UINT32
    PciFunctionNumber* {.bitsize:3.}: UINT32
  NDIS_SWITCH_PORT_PROPERTY_PROFILE* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    ProfileName*: NDIS_SWITCH_PORT_PROPERTY_PROFILE_NAME
    ProfileId*: GUID
    VendorName*: NDIS_VENDOR_NAME
    VendorId*: GUID
    ProfileData*: UINT32
    NetCfgInstanceId*: GUID
    PciLocation*: NDIS_SWITCH_PORT_PROPERTY_PROFILE_PciLocation
    CdnLabelId*: UINT32
    CdnLabel*: NDIS_SWITCH_PORT_PROPERTY_PROFILE_CDN_LABEL
  PNDIS_SWITCH_PORT_PROPERTY_PROFILE* = ptr NDIS_SWITCH_PORT_PROPERTY_PROFILE
  NDIS_SWITCH_PORT_PROPERTY_CUSTOM* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PropertyBufferLength*: ULONG
    PropertyBufferOffset*: ULONG
  PNDIS_SWITCH_PORT_PROPERTY_CUSTOM* = ptr NDIS_SWITCH_PORT_PROPERTY_CUSTOM
  NDIS_SWITCH_PORT_PROPERTY_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PortId*: NDIS_SWITCH_PORT_ID
    PropertyType*: NDIS_SWITCH_PORT_PROPERTY_TYPE
    PropertyId*: NDIS_SWITCH_OBJECT_ID
    PropertyVersion*: NDIS_SWITCH_OBJECT_VERSION
    SerializationVersion*: NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION
    PropertyInstanceId*: NDIS_SWITCH_OBJECT_INSTANCE_ID
    PropertyBufferLength*: ULONG
    PropertyBufferOffset*: ULONG
    Reserved*: ULONG
  PNDIS_SWITCH_PORT_PROPERTY_PARAMETERS* = ptr NDIS_SWITCH_PORT_PROPERTY_PARAMETERS
  NDIS_SWITCH_PORT_PROPERTY_DELETE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PortId*: NDIS_SWITCH_PORT_ID
    PropertyType*: NDIS_SWITCH_PORT_PROPERTY_TYPE
    PropertyId*: NDIS_SWITCH_OBJECT_ID
    PropertyInstanceId*: NDIS_SWITCH_OBJECT_INSTANCE_ID
  PNDIS_SWITCH_PORT_PROPERTY_DELETE_PARAMETERS* = ptr NDIS_SWITCH_PORT_PROPERTY_DELETE_PARAMETERS
  NDIS_SWITCH_PORT_PROPERTY_ENUM_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PortId*: NDIS_SWITCH_PORT_ID
    PropertyType*: NDIS_SWITCH_PORT_PROPERTY_TYPE
    PropertyId*: NDIS_SWITCH_OBJECT_ID
    SerializationVersion*: NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION
    FirstPropertyOffset*: ULONG
    NumProperties*: ULONG
    Reserved*: USHORT
  PNDIS_SWITCH_PORT_PROPERTY_ENUM_PARAMETERS* = ptr NDIS_SWITCH_PORT_PROPERTY_ENUM_PARAMETERS
  NDIS_SWITCH_PORT_PROPERTY_ENUM_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PropertyVersion*: NDIS_SWITCH_OBJECT_VERSION
    PropertyInstanceId*: NDIS_SWITCH_OBJECT_INSTANCE_ID
    QwordAlignedPropertyBufferLength*: ULONG
    PropertyBufferLength*: ULONG
    PropertyBufferOffset*: ULONG
  PNDIS_SWITCH_PORT_PROPERTY_ENUM_INFO* = ptr NDIS_SWITCH_PORT_PROPERTY_ENUM_INFO
  NDIS_SWITCH_PORT_FEATURE_STATUS_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PortId*: NDIS_SWITCH_PORT_ID
    FeatureStatusType*: NDIS_SWITCH_PORT_FEATURE_STATUS_TYPE
    FeatureStatusId*: NDIS_SWITCH_OBJECT_ID
    FeatureStatusVersion*: NDIS_SWITCH_OBJECT_VERSION
    SerializationVersion*: NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION
    FeatureStatusInstanceId*: NDIS_SWITCH_OBJECT_INSTANCE_ID
    FeatureStatusBufferLength*: ULONG
    FeatureStatusBufferOffset*: ULONG
    Reserved*: ULONG
  PNDIS_SWITCH_PORT_FEATURE_STATUS_PARAMETERS* = ptr NDIS_SWITCH_PORT_FEATURE_STATUS_PARAMETERS
  NDIS_SWITCH_PORT_FEATURE_STATUS_CUSTOM* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FeatureStatusBufferLength*: ULONG
    FeatureStatusBufferOffset*: ULONG
  PNDIS_SWITCH_PORT_FEATURE_STATUS_CUSTOM* = ptr NDIS_SWITCH_PORT_FEATURE_STATUS_CUSTOM
  NDIS_SWITCH_PROPERTY_CUSTOM* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PropertyBufferLength*: ULONG
    PropertyBufferOffset*: ULONG
  PNDIS_SWITCH_PROPERTY_CUSTOM* = ptr NDIS_SWITCH_PROPERTY_CUSTOM
  NDIS_SWITCH_PROPERTY_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PropertyType*: NDIS_SWITCH_PROPERTY_TYPE
    PropertyId*: NDIS_SWITCH_OBJECT_ID
    PropertyVersion*: NDIS_SWITCH_OBJECT_VERSION
    SerializationVersion*: NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION
    PropertyInstanceId*: NDIS_SWITCH_OBJECT_INSTANCE_ID
    PropertyBufferLength*: ULONG
    PropertyBufferOffset*: ULONG
  PNDIS_SWITCH_PROPERTY_PARAMETERS* = ptr NDIS_SWITCH_PROPERTY_PARAMETERS
  NDIS_SWITCH_PROPERTY_DELETE_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PropertyType*: NDIS_SWITCH_PROPERTY_TYPE
    PropertyId*: NDIS_SWITCH_OBJECT_ID
    PropertyInstanceId*: NDIS_SWITCH_OBJECT_INSTANCE_ID
  PNDIS_SWITCH_PROPERTY_DELETE_PARAMETERS* = ptr NDIS_SWITCH_PROPERTY_DELETE_PARAMETERS
  NDIS_SWITCH_PROPERTY_ENUM_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PropertyInstanceId*: NDIS_SWITCH_OBJECT_INSTANCE_ID
    PropertyVersion*: NDIS_SWITCH_OBJECT_VERSION
    QwordAlignedPropertyBufferLength*: ULONG
    PropertyBufferLength*: ULONG
    PropertyBufferOffset*: ULONG
  PNDIS_SWITCH_PROPERTY_ENUM_INFO* = ptr NDIS_SWITCH_PROPERTY_ENUM_INFO
  NDIS_SWITCH_PROPERTY_ENUM_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PropertyType*: NDIS_SWITCH_PROPERTY_TYPE
    PropertyId*: NDIS_SWITCH_OBJECT_ID
    SerializationVersion*: NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION
    FirstPropertyOffset*: ULONG
    NumProperties*: ULONG
  PNDIS_SWITCH_PROPERTY_ENUM_PARAMETERS* = ptr NDIS_SWITCH_PROPERTY_ENUM_PARAMETERS
  NDIS_SWITCH_FEATURE_STATUS_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FeatureStatusType*: NDIS_SWITCH_FEATURE_STATUS_TYPE
    FeatureStatusId*: NDIS_SWITCH_OBJECT_ID
    FeatureStatusInstanceId*: NDIS_SWITCH_OBJECT_INSTANCE_ID
    FeatureStatusVersion*: NDIS_SWITCH_OBJECT_VERSION
    SerializationVersion*: NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION
    FeatureStatusBufferOffset*: ULONG
    FeatureStatusBufferLength*: ULONG
  PNDIS_SWITCH_FEATURE_STATUS_PARAMETERS* = ptr NDIS_SWITCH_FEATURE_STATUS_PARAMETERS
  NDIS_SWITCH_FEATURE_STATUS_CUSTOM* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FeatureStatusCustomBufferLength*: ULONG
    FeatureStatusCustomBufferOffset*: ULONG
  PNDIS_SWITCH_FEATURE_STATUS_CUSTOM* = ptr NDIS_SWITCH_FEATURE_STATUS_CUSTOM
  NDIS_SWITCH_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SwitchName*: NDIS_SWITCH_NAME
    SwitchFriendlyName*: NDIS_SWITCH_FRIENDLYNAME
    NumSwitchPorts*: UINT32
    IsActive*: BOOLEAN
  PNDIS_SWITCH_PARAMETERS* = ptr NDIS_SWITCH_PARAMETERS
  NDIS_SWITCH_PORT_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PortId*: NDIS_SWITCH_PORT_ID
    PortName*: NDIS_SWITCH_PORT_NAME
    PortFriendlyName*: NDIS_SWITCH_PORT_FRIENDLYNAME
    PortType*: NDIS_SWITCH_PORT_TYPE
    IsValidationPort*: BOOLEAN
    PortState*: NDIS_SWITCH_PORT_STATE
  PNDIS_SWITCH_PORT_PARAMETERS* = ptr NDIS_SWITCH_PORT_PARAMETERS
  NDIS_SWITCH_PORT_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FirstElementOffset*: USHORT
    NumElements*: ULONG
    ElementSize*: ULONG
  PNDIS_SWITCH_PORT_ARRAY* = ptr NDIS_SWITCH_PORT_ARRAY
  NDIS_SWITCH_NIC_PARAMETERS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    NicName*: NDIS_SWITCH_NIC_NAME
    NicFriendlyName*: NDIS_SWITCH_NIC_FRIENDLYNAME
    PortId*: NDIS_SWITCH_PORT_ID
    NicIndex*: NDIS_SWITCH_NIC_INDEX
    NicType*: NDIS_SWITCH_NIC_TYPE
    NicState*: NDIS_SWITCH_NIC_STATE
    VmName*: NDIS_VM_NAME
    VmFriendlyName*: NDIS_VM_FRIENDLYNAME
    NetCfgInstanceId*: GUID
    MTU*: ULONG
    NumaNodeId*: USHORT
    PermanentMacAddress*: array[NDIS_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    VMMacAddress*: array[NDIS_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    CurrentMacAddress*: array[NDIS_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    VFAssigned*: BOOLEAN
  PNDIS_SWITCH_NIC_PARAMETERS* = ptr NDIS_SWITCH_NIC_PARAMETERS
  NDIS_SWITCH_NIC_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    FirstElementOffset*: USHORT
    NumElements*: ULONG
    ElementSize*: ULONG
  PNDIS_SWITCH_NIC_ARRAY* = ptr NDIS_SWITCH_NIC_ARRAY
  NDIS_OID_REQUEST* {.pure.} = object
  PNDIS_OID_REQUEST* = ptr NDIS_OID_REQUEST
  NDIS_SWITCH_NIC_OID_REQUEST* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    SourcePortId*: NDIS_SWITCH_PORT_ID
    SourceNicIndex*: NDIS_SWITCH_NIC_INDEX
    DestinationPortId*: NDIS_SWITCH_PORT_ID
    DestinationNicIndex*: NDIS_SWITCH_NIC_INDEX
    OidRequest*: PNDIS_OID_REQUEST
  PNDIS_SWITCH_NIC_OID_REQUEST* = ptr NDIS_SWITCH_NIC_OID_REQUEST
  NDIS_SWITCH_NIC_SAVE_STATE* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    PortId*: NDIS_SWITCH_PORT_ID
    NicIndex*: NDIS_SWITCH_NIC_INDEX
    ExtensionId*: GUID
    ExtensionFriendlyName*: NDIS_SWITCH_EXTENSION_FRIENDLYNAME
    FeatureClassId*: GUID
    SaveDataSize*: USHORT
    SaveDataOffset*: USHORT
  PNDIS_SWITCH_NIC_SAVE_STATE* = ptr NDIS_SWITCH_NIC_SAVE_STATE
  NDIS_PORT_STATE* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    MediaConnectState*: NDIS_MEDIA_CONNECT_STATE
    XmitLinkSpeed*: ULONG64
    RcvLinkSpeed*: ULONG64
    Direction*: NET_IF_DIRECTION_TYPE
    SendControlState*: NDIS_PORT_CONTROL_STATE
    RcvControlState*: NDIS_PORT_CONTROL_STATE
    SendAuthorizationState*: NDIS_PORT_AUTHORIZATION_STATE
    RcvAuthorizationState*: NDIS_PORT_AUTHORIZATION_STATE
    Flags*: ULONG
  PNDIS_PORT_STATE* = ptr NDIS_PORT_STATE
  NDIS_PORT_CHARACTERISTICS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    PortNumber*: NDIS_PORT_NUMBER
    Flags*: ULONG
    Type*: NDIS_PORT_TYPE
    MediaConnectState*: NDIS_MEDIA_CONNECT_STATE
    XmitLinkSpeed*: ULONG64
    RcvLinkSpeed*: ULONG64
    Direction*: NET_IF_DIRECTION_TYPE
    SendControlState*: NDIS_PORT_CONTROL_STATE
    RcvControlState*: NDIS_PORT_CONTROL_STATE
    SendAuthorizationState*: NDIS_PORT_AUTHORIZATION_STATE
    RcvAuthorizationState*: NDIS_PORT_AUTHORIZATION_STATE
  PNDIS_PORT_CHARACTERISTICS* = ptr NDIS_PORT_CHARACTERISTICS
  NDIS_PORT* {.pure.} = object
    Next*: PNDIS_PORT
    NdisReserved*: PVOID
    MiniportReserved*: PVOID
    ProtocolReserved*: PVOID
    PortCharacteristics*: NDIS_PORT_CHARACTERISTICS
  PNDIS_PORT* = ptr NDIS_PORT
  NDIS_PORT_ARRAY* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    NumberOfPorts*: ULONG
    OffsetFirstPort*: ULONG
    ElementSize*: ULONG
    Ports*: array[1, NDIS_PORT_CHARACTERISTICS]
  PNDIS_PORT_ARRAY* = ptr NDIS_PORT_ARRAY
  MIB_IF_ROW2_InterfaceAndOperStatusFlags* {.pure.} = object
    HardwareInterface* {.bitsize:1.}: BOOLEAN
    FilterInterface* {.bitsize:1.}: BOOLEAN
    ConnectorPresent* {.bitsize:1.}: BOOLEAN
    NotAuthenticated* {.bitsize:1.}: BOOLEAN
    NotMediaConnected* {.bitsize:1.}: BOOLEAN
    Paused* {.bitsize:1.}: BOOLEAN
    LowPower* {.bitsize:1.}: BOOLEAN
    EndPointInterface* {.bitsize:1.}: BOOLEAN
  MIB_IF_ROW2* {.pure.} = object
    InterfaceLuid*: NET_LUID
    InterfaceIndex*: NET_IFINDEX
    InterfaceGuid*: GUID
    Alias*: array[IF_MAX_STRING_SIZE + 1, WCHAR]
    Description*: array[IF_MAX_STRING_SIZE + 1, WCHAR]
    PhysicalAddressLength*: ULONG
    PhysicalAddress*: array[IF_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    PermanentPhysicalAddress*: array[IF_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    Mtu*: ULONG
    Type*: IFTYPE
    TunnelType*: TUNNEL_TYPE
    MediaType*: NDIS_MEDIUM
    PhysicalMediumType*: NDIS_PHYSICAL_MEDIUM
    AccessType*: NET_IF_ACCESS_TYPE
    DirectionType*: NET_IF_DIRECTION_TYPE
    InterfaceAndOperStatusFlags*: MIB_IF_ROW2_InterfaceAndOperStatusFlags
    OperStatus*: IF_OPER_STATUS
    AdminStatus*: NET_IF_ADMIN_STATUS
    MediaConnectState*: NET_IF_MEDIA_CONNECT_STATE
    NetworkGuid*: NET_IF_NETWORK_GUID
    ConnectionType*: NET_IF_CONNECTION_TYPE
    TransmitLinkSpeed*: ULONG64
    ReceiveLinkSpeed*: ULONG64
    InOctets*: ULONG64
    InUcastPkts*: ULONG64
    InNUcastPkts*: ULONG64
    InDiscards*: ULONG64
    InErrors*: ULONG64
    InUnknownProtos*: ULONG64
    InUcastOctets*: ULONG64
    InMulticastOctets*: ULONG64
    InBroadcastOctets*: ULONG64
    OutOctets*: ULONG64
    OutUcastPkts*: ULONG64
    OutNUcastPkts*: ULONG64
    OutDiscards*: ULONG64
    OutErrors*: ULONG64
    OutUcastOctets*: ULONG64
    OutMulticastOctets*: ULONG64
    OutBroadcastOctets*: ULONG64
    OutQLen*: ULONG64
  PMIB_IF_ROW2* = ptr MIB_IF_ROW2
  MIB_IF_TABLE2* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_IF_ROW2]
  PMIB_IF_TABLE2* = ptr MIB_IF_TABLE2
  MIB_IPINTERFACE_ROW* {.pure.} = object
    Family*: ADDRESS_FAMILY
    InterfaceLuid*: NET_LUID
    InterfaceIndex*: NET_IFINDEX
    MaxReassemblySize*: ULONG
    InterfaceIdentifier*: ULONG64
    MinRouterAdvertisementInterval*: ULONG
    MaxRouterAdvertisementInterval*: ULONG
    AdvertisingEnabled*: BOOLEAN
    ForwardingEnabled*: BOOLEAN
    WeakHostSend*: BOOLEAN
    WeakHostReceive*: BOOLEAN
    UseAutomaticMetric*: BOOLEAN
    UseNeighborUnreachabilityDetection*: BOOLEAN
    ManagedAddressConfigurationSupported*: BOOLEAN
    OtherStatefulConfigurationSupported*: BOOLEAN
    AdvertiseDefaultRoute*: BOOLEAN
    RouterDiscoveryBehavior*: NL_ROUTER_DISCOVERY_BEHAVIOR
    DadTransmits*: ULONG
    BaseReachableTime*: ULONG
    RetransmitTime*: ULONG
    PathMtuDiscoveryTimeout*: ULONG
    LinkLocalAddressBehavior*: NL_LINK_LOCAL_ADDRESS_BEHAVIOR
    LinkLocalAddressTimeout*: ULONG
    ZoneIndices*: array[scopeLevelCount, ULONG]
    SitePrefixLength*: ULONG
    Metric*: ULONG
    NlMtu*: ULONG
    Connected*: BOOLEAN
    SupportsWakeUpPatterns*: BOOLEAN
    SupportsNeighborDiscovery*: BOOLEAN
    SupportsRouterDiscovery*: BOOLEAN
    ReachableTime*: ULONG
    TransmitOffload*: NL_INTERFACE_OFFLOAD_ROD
    ReceiveOffload*: NL_INTERFACE_OFFLOAD_ROD
    DisableDefaultRoutes*: BOOLEAN
  PMIB_IPINTERFACE_ROW* = ptr MIB_IPINTERFACE_ROW
  MIB_IPINTERFACE_TABLE* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_IPINTERFACE_ROW]
  PMIB_IPINTERFACE_TABLE* = ptr MIB_IPINTERFACE_TABLE
  MIB_IFSTACK_ROW* {.pure.} = object
    HigherLayerInterfaceIndex*: NET_IFINDEX
    LowerLayerInterfaceIndex*: NET_IFINDEX
  PMIB_IFSTACK_ROW* = ptr MIB_IFSTACK_ROW
  MIB_INVERTEDIFSTACK_ROW* {.pure.} = object
    LowerLayerInterfaceIndex*: NET_IFINDEX
    HigherLayerInterfaceIndex*: NET_IFINDEX
  PMIB_INVERTEDIFSTACK_ROW* = ptr MIB_INVERTEDIFSTACK_ROW
  MIB_IFSTACK_TABLE* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_IFSTACK_ROW]
  PMIB_IFSTACK_TABLE* = ptr MIB_IFSTACK_TABLE
  MIB_INVERTEDIFSTACK_TABLE* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_INVERTEDIFSTACK_ROW]
  PMIB_INVERTEDIFSTACK_TABLE* = ptr MIB_INVERTEDIFSTACK_TABLE
  MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES* {.pure.} = object
    InboundBandwidthInformation*: NL_BANDWIDTH_INFORMATION
    OutboundBandwidthInformation*: NL_BANDWIDTH_INFORMATION
  PMIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES* = ptr MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES
  MIB_UNICASTIPADDRESS_ROW* {.pure.} = object
    Address*: SOCKADDR_INET
    InterfaceLuid*: NET_LUID
    InterfaceIndex*: NET_IFINDEX
    PrefixOrigin*: NL_PREFIX_ORIGIN
    SuffixOrigin*: NL_SUFFIX_ORIGIN
    ValidLifetime*: ULONG
    PreferredLifetime*: ULONG
    OnLinkPrefixLength*: UINT8
    SkipAsSource*: BOOLEAN
    DadState*: NL_DAD_STATE
    ScopeId*: SCOPE_ID
    CreationTimeStamp*: LARGE_INTEGER
  PMIB_UNICASTIPADDRESS_ROW* = ptr MIB_UNICASTIPADDRESS_ROW
  MIB_UNICASTIPADDRESS_TABLE* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_UNICASTIPADDRESS_ROW]
  PMIB_UNICASTIPADDRESS_TABLE* = ptr MIB_UNICASTIPADDRESS_TABLE
  MIB_ANYCASTIPADDRESS_ROW* {.pure.} = object
    Address*: SOCKADDR_INET
    InterfaceLuid*: NET_LUID
    InterfaceIndex*: NET_IFINDEX
    ScopeId*: SCOPE_ID
  PMIB_ANYCASTIPADDRESS_ROW* = ptr MIB_ANYCASTIPADDRESS_ROW
  MIB_ANYCASTIPADDRESS_TABLE* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_ANYCASTIPADDRESS_ROW]
  PMIB_ANYCASTIPADDRESS_TABLE* = ptr MIB_ANYCASTIPADDRESS_TABLE
  MIB_MULTICASTIPADDRESS_ROW* {.pure.} = object
    Address*: SOCKADDR_INET
    InterfaceIndex*: NET_IFINDEX
    InterfaceLuid*: NET_LUID
    ScopeId*: SCOPE_ID
  PMIB_MULTICASTIPADDRESS_ROW* = ptr MIB_MULTICASTIPADDRESS_ROW
  MIB_MULTICASTIPADDRESS_TABLE* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_MULTICASTIPADDRESS_ROW]
  PMIB_MULTICASTIPADDRESS_TABLE* = ptr MIB_MULTICASTIPADDRESS_TABLE
  IP_ADDRESS_PREFIX* {.pure.} = object
    Prefix*: SOCKADDR_INET
    PrefixLength*: UINT8
  PIP_ADDRESS_PREFIX* = ptr IP_ADDRESS_PREFIX
  MIB_IPFORWARD_ROW2* {.pure.} = object
    InterfaceLuid*: NET_LUID
    InterfaceIndex*: NET_IFINDEX
    DestinationPrefix*: IP_ADDRESS_PREFIX
    NextHop*: SOCKADDR_INET
    SitePrefixLength*: UCHAR
    ValidLifetime*: ULONG
    PreferredLifetime*: ULONG
    Metric*: ULONG
    Protocol*: NL_ROUTE_PROTOCOL
    Loopback*: BOOLEAN
    AutoconfigureAddress*: BOOLEAN
    Publish*: BOOLEAN
    Immortal*: BOOLEAN
    Age*: ULONG
    Origin*: NL_ROUTE_ORIGIN
  PMIB_IPFORWARD_ROW2* = ptr MIB_IPFORWARD_ROW2
  MIB_IPFORWARD_TABLE2* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_IPFORWARD_ROW2]
  PMIB_IPFORWARD_TABLE2* = ptr MIB_IPFORWARD_TABLE2
  MIB_IPPATH_ROW_UNION1* {.pure, union.} = object
    LastReachable*: ULONG
    LastUnreachable*: ULONG
  MIB_IPPATH_ROW* {.pure.} = object
    Source*: SOCKADDR_INET
    Destination*: SOCKADDR_INET
    InterfaceLuid*: NET_LUID
    InterfaceIndex*: NET_IFINDEX
    CurrentNextHop*: SOCKADDR_INET
    PathMtu*: ULONG
    RttMean*: ULONG
    RttDeviation*: ULONG
    union1*: MIB_IPPATH_ROW_UNION1
    IsReachable*: BOOLEAN
    LinkTransmitSpeed*: ULONG64
    LinkReceiveSpeed*: ULONG64
  PMIB_IPPATH_ROW* = ptr MIB_IPPATH_ROW
  MIB_IPPATH_TABLE* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_IPPATH_ROW]
  PMIB_IPPATH_TABLE* = ptr MIB_IPPATH_TABLE
  MIB_IPNET_ROW2_UNION1_STRUCT1* {.pure.} = object
    IsRouter* {.bitsize:1.}: BOOLEAN
    IsUnreachable* {.bitsize:1.}: BOOLEAN
  MIB_IPNET_ROW2_UNION1* {.pure, union.} = object
    struct1*: MIB_IPNET_ROW2_UNION1_STRUCT1
    Flags*: UCHAR
  MIB_IPNET_ROW2_ReachabilityTime* {.pure, union.} = object
    LastReachable*: ULONG
    LastUnreachable*: ULONG
  MIB_IPNET_ROW2* {.pure.} = object
    Address*: SOCKADDR_INET
    InterfaceIndex*: NET_IFINDEX
    InterfaceLuid*: NET_LUID
    PhysicalAddress*: array[IF_MAX_PHYS_ADDRESS_LENGTH, UCHAR]
    PhysicalAddressLength*: ULONG
    State*: NL_NEIGHBOR_STATE
    union1*: MIB_IPNET_ROW2_UNION1
    ReachabilityTime*: MIB_IPNET_ROW2_ReachabilityTime
  PMIB_IPNET_ROW2* = ptr MIB_IPNET_ROW2
  MIB_IPNET_TABLE2* {.pure.} = object
    NumEntries*: ULONG
    Table*: array[ANY_SIZE, MIB_IPNET_ROW2]
  PMIB_IPNET_TABLE2* = ptr MIB_IPNET_TABLE2
  IPv6Addr* = IN6_ADDR
  NETIO_STATUS* = NTSTATUS
const
  nldsInvalid* = 0
  nldsTentative* = 1
  nldsDuplicate* = 2
  nldsDeprecated* = 3
  nldsPreferred* = 4
  ipDadStateInvalid* = 0
  ipDadStateTentative* = 1
  ipDadStateDuplicate* = 2
  ipDadStateDeprecated* = 3
  ipDadStatePreferred* = 4
  routeProtocolOther* = 1
  routeProtocolLocal* = 2
  routeProtocolNetMgmt* = 3
  routeProtocolIcmp* = 4
  routeProtocolEgp* = 5
  routeProtocolGgp* = 6
  routeProtocolHello* = 7
  routeProtocolRip* = 8
  routeProtocolIsIs* = 9
  routeProtocolEsIs* = 10
  routeProtocolCisco* = 11
  routeProtocolBbn* = 12
  routeProtocolOspf* = 13
  routeProtocolBgp* = 14
  OTHER* = 15
  LOCAL* = 16
  NETMGMT* = 17
  ICMP* = 18
  EGP* = 19
  GGP* = 20
  HELLO* = 21
  RIP* = 22
  IS_IS* = 23
  ES_IS* = 24
  CISCO* = 25
  BBN* = 26
  OSPF* = 27
  BGP* = 28
  NT_AUTOSTATIC* = 29
  NT_STATIC* = 30
  NT_STATIC_NON_DOD* = 31
  ipPrefixOriginOther* = 0
  ipPrefixOriginManual* = 1
  ipPrefixOriginWellKnown* = 2
  ipPrefixOriginDhcp* = 3
  ipPrefixOriginRouterAdvertisement* = 4
  ipPrefixOriginUnchanged* = 16
  nlsoOther* = 0
  nlsoManual* = 1
  nlsoWellKnown* = 2
  nlsoDhcp* = 3
  nlsoLinkLayerAddress* = 4
  nlsoRandom* = 5
  ipSuffixOriginOther* = 0
  ipSuffixOriginManual* = 1
  ipSuffixOriginWellKnown* = 2
  ipSuffixOriginDhcp* = 3
  ipSuffixOriginLinkLayerAddress* = 4
  ipSuffixOriginRandom* = 5
  ipSuffixOriginUnchanged* = 16
  nlatUnspecified* = 0
  nlatUnicast* = 1
  nlatAnycast* = 2
  nlatMulticast* = 3
  nlatBroadcast* = 4
  nlatInvalid* = 5
  nlroManual* = 0
  nlroWellKnown* = 1
  nlroDHCP* = 2
  nlroRouterAdvertisement* = 3
  nlro6to4* = 4
  nlnsUnreachable* = 0
  nlnsIncomplete* = 1
  nlnsProbe* = 2
  nlnsDelay* = 3
  nlnsStale* = 4
  nlnsReachable* = 5
  nlnsPermanent* = 6
  nlnsMaximum* = 7
  linkLocalAlwaysOff* = 0
  linkLocalDelayed* = 1
  linkLocalAlwaysOn* = 2
  linkLocalUnchanged* = -1
  routerDiscoveryDisabled* = 0
  routerDiscoveryEnabled* = 1
  routerDiscoveryDhcp* = 2
  routerDiscoveryUnchanged* = -1
  nlbwDisabled* = 0
  nlbwEnabled* = 1
  nlbwUnchanged* = -1
  nlincCategoryUnknown* = 0
  nlincPublic* = 1
  nlincPrivate* = 2
  nlincDomainAuthenticated* = 3
  nlincCategoryStateMax* = 4
  networkCategoryPublic* = 0
  networkCategoryPrivate* = 1
  networkCategoryDomainAuthenticated* = 2
  networkCategoryUnchanged* = -1
  networkCategoryUnknown* = -1
  nlpoOther* = ipPrefixOriginOther
  nlpoManual* = ipPrefixOriginManual
  nlpoWellKnown* = ipPrefixOriginWellKnown
  nlpoDhcp* = ipPrefixOriginDhcp
  nlpoRouterAdvertisement* = ipPrefixOriginRouterAdvertisement
  NET_IF_CURRENT_SESSION* = ULONG(-1)
  MIN_IF_TYPE* = 1
  IF_TYPE_OTHER* = 1
  IF_TYPE_REGULAR_1822* = 2
  IF_TYPE_HDH_1822* = 3
  IF_TYPE_DDN_X25* = 4
  IF_TYPE_RFC877_X25* = 5
  IF_TYPE_ETHERNET_CSMACD* = 6
  IF_TYPE_IS088023_CSMACD* = 7
  IF_TYPE_ISO88024_TOKENBUS* = 8
  IF_TYPE_ISO88025_TOKENRING* = 9
  IF_TYPE_ISO88026_MAN* = 10
  IF_TYPE_STARLAN* = 11
  IF_TYPE_PROTEON_10MBIT* = 12
  IF_TYPE_PROTEON_80MBIT* = 13
  IF_TYPE_HYPERCHANNEL* = 14
  IF_TYPE_FDDI* = 15
  IF_TYPE_LAP_B* = 16
  IF_TYPE_SDLC* = 17
  IF_TYPE_DS1* = 18
  IF_TYPE_E1* = 19
  IF_TYPE_BASIC_ISDN* = 20
  IF_TYPE_PRIMARY_ISDN* = 21
  IF_TYPE_PROP_POINT2POINT_SERIAL* = 22
  IF_TYPE_PPP* = 23
  IF_TYPE_SOFTWARE_LOOPBACK* = 24
  IF_TYPE_EON* = 25
  IF_TYPE_ETHERNET_3MBIT* = 26
  IF_TYPE_NSIP* = 27
  IF_TYPE_SLIP* = 28
  IF_TYPE_ULTRA* = 29
  IF_TYPE_DS3* = 30
  IF_TYPE_SIP* = 31
  IF_TYPE_FRAMERELAY* = 32
  IF_TYPE_RS232* = 33
  IF_TYPE_PARA* = 34
  IF_TYPE_ARCNET* = 35
  IF_TYPE_ARCNET_PLUS* = 36
  IF_TYPE_ATM* = 37
  IF_TYPE_MIO_X25* = 38
  IF_TYPE_SONET* = 39
  IF_TYPE_X25_PLE* = 40
  IF_TYPE_ISO88022_LLC* = 41
  IF_TYPE_LOCALTALK* = 42
  IF_TYPE_SMDS_DXI* = 43
  IF_TYPE_FRAMERELAY_SERVICE* = 44
  IF_TYPE_V35* = 45
  IF_TYPE_HSSI* = 46
  IF_TYPE_HIPPI* = 47
  IF_TYPE_MODEM* = 48
  IF_TYPE_AAL5* = 49
  IF_TYPE_SONET_PATH* = 50
  IF_TYPE_SONET_VT* = 51
  IF_TYPE_SMDS_ICIP* = 52
  IF_TYPE_PROP_VIRTUAL* = 53
  IF_TYPE_PROP_MULTIPLEXOR* = 54
  IF_TYPE_IEEE80212* = 55
  IF_TYPE_FIBRECHANNEL* = 56
  IF_TYPE_HIPPIINTERFACE* = 57
  IF_TYPE_FRAMERELAY_INTERCONNECT* = 58
  IF_TYPE_AFLANE_8023* = 59
  IF_TYPE_AFLANE_8025* = 60
  IF_TYPE_CCTEMUL* = 61
  IF_TYPE_FASTETHER* = 62
  IF_TYPE_ISDN* = 63
  IF_TYPE_V11* = 64
  IF_TYPE_V36* = 65
  IF_TYPE_G703_64K* = 66
  IF_TYPE_G703_2MB* = 67
  IF_TYPE_QLLC* = 68
  IF_TYPE_FASTETHER_FX* = 69
  IF_TYPE_CHANNEL* = 70
  IF_TYPE_IEEE80211* = 71
  IF_TYPE_IBM370PARCHAN* = 72
  IF_TYPE_ESCON* = 73
  IF_TYPE_DLSW* = 74
  IF_TYPE_ISDN_S* = 75
  IF_TYPE_ISDN_U* = 76
  IF_TYPE_LAP_D* = 77
  IF_TYPE_IPSWITCH* = 78
  IF_TYPE_RSRB* = 79
  IF_TYPE_ATM_LOGICAL* = 80
  IF_TYPE_DS0* = 81
  IF_TYPE_DS0_BUNDLE* = 82
  IF_TYPE_BSC* = 83
  IF_TYPE_ASYNC* = 84
  IF_TYPE_CNR* = 85
  IF_TYPE_ISO88025R_DTR* = 86
  IF_TYPE_EPLRS* = 87
  IF_TYPE_ARAP* = 88
  IF_TYPE_PROP_CNLS* = 89
  IF_TYPE_HOSTPAD* = 90
  IF_TYPE_TERMPAD* = 91
  IF_TYPE_FRAMERELAY_MPI* = 92
  IF_TYPE_X213* = 93
  IF_TYPE_ADSL* = 94
  IF_TYPE_RADSL* = 95
  IF_TYPE_SDSL* = 96
  IF_TYPE_VDSL* = 97
  IF_TYPE_ISO88025_CRFPRINT* = 98
  IF_TYPE_MYRINET* = 99
  IF_TYPE_VOICE_EM* = 100
  IF_TYPE_VOICE_FXO* = 101
  IF_TYPE_VOICE_FXS* = 102
  IF_TYPE_VOICE_ENCAP* = 103
  IF_TYPE_VOICE_OVERIP* = 104
  IF_TYPE_ATM_DXI* = 105
  IF_TYPE_ATM_FUNI* = 106
  IF_TYPE_ATM_IMA* = 107
  IF_TYPE_PPPMULTILINKBUNDLE* = 108
  IF_TYPE_IPOVER_CDLC* = 109
  IF_TYPE_IPOVER_CLAW* = 110
  IF_TYPE_STACKTOSTACK* = 111
  IF_TYPE_VIRTUALIPADDRESS* = 112
  IF_TYPE_MPC* = 113
  IF_TYPE_IPOVER_ATM* = 114
  IF_TYPE_ISO88025_FIBER* = 115
  IF_TYPE_TDLC* = 116
  IF_TYPE_GIGABITETHERNET* = 117
  IF_TYPE_HDLC* = 118
  IF_TYPE_LAP_F* = 119
  IF_TYPE_V37* = 120
  IF_TYPE_X25_MLP* = 121
  IF_TYPE_X25_HUNTGROUP* = 122
  IF_TYPE_TRANSPHDLC* = 123
  IF_TYPE_INTERLEAVE* = 124
  IF_TYPE_FAST* = 125
  IF_TYPE_IP* = 126
  IF_TYPE_DOCSCABLE_MACLAYER* = 127
  IF_TYPE_DOCSCABLE_DOWNSTREAM* = 128
  IF_TYPE_DOCSCABLE_UPSTREAM* = 129
  IF_TYPE_A12MPPSWITCH* = 130
  IF_TYPE_TUNNEL* = 131
  IF_TYPE_COFFEE* = 132
  IF_TYPE_CES* = 133
  IF_TYPE_ATM_SUBINTERFACE* = 134
  IF_TYPE_L2_VLAN* = 135
  IF_TYPE_L3_IPVLAN* = 136
  IF_TYPE_L3_IPXVLAN* = 137
  IF_TYPE_DIGITALPOWERLINE* = 138
  IF_TYPE_MEDIAMAILOVERIP* = 139
  IF_TYPE_DTM* = 140
  IF_TYPE_DCN* = 141
  IF_TYPE_IPFORWARD* = 142
  IF_TYPE_MSDSL* = 143
  IF_TYPE_IEEE1394* = 144
  IF_TYPE_RECEIVE_ONLY* = 145
  MAX_IF_TYPE* = 145
  IF_ACCESS_LOOPBACK* = 1
  IF_ACCESS_BROADCAST* = 2
  IF_ACCESS_POINTTOPOINT* = 3
  IF_ACCESS_POINTTOMULTIPOINT* = 4
  IF_CHECK_NONE* = 0x00
  IF_CHECK_MCAST* = 0x01
  IF_CHECK_SEND* = 0x02
  IF_CONNECTION_DEDICATED* = 1
  IF_CONNECTION_PASSIVE* = 2
  IF_CONNECTION_DEMAND* = 3
  IF_ADMIN_STATUS_UP* = 1
  IF_ADMIN_STATUS_DOWN* = 2
  IF_ADMIN_STATUS_TESTING* = 3
  IF_OPER_STATUS_NON_OPERATIONAL* = 0
  IF_OPER_STATUS_UNREACHABLE* = 1
  IF_OPER_STATUS_DISCONNECTED* = 2
  IF_OPER_STATUS_CONNECTING* = 3
  IF_OPER_STATUS_CONNECTED* = 4
  IF_OPER_STATUS_OPERATIONAL* = 5
  MIB_IF_TYPE_OTHER* = 1
  MIB_IF_TYPE_ETHERNET* = 6
  MIB_IF_TYPE_TOKENRING* = 9
  MIB_IF_TYPE_FDDI* = 15
  MIB_IF_TYPE_PPP* = 23
  MIB_IF_TYPE_LOOPBACK* = 24
  MIB_IF_TYPE_SLIP* = 28
  MIB_IF_ADMIN_STATUS_UP* = 1
  MIB_IF_ADMIN_STATUS_DOWN* = 2
  MIB_IF_ADMIN_STATUS_TESTING* = 3
  MIB_IF_OPER_STATUS_NON_OPERATIONAL* = 0
  MIB_IF_OPER_STATUS_UNREACHABLE* = 1
  MIB_IF_OPER_STATUS_DISCONNECTED* = 2
  MIB_IF_OPER_STATUS_CONNECTING* = 3
  MIB_IF_OPER_STATUS_CONNECTED* = 4
  MIB_IF_OPER_STATUS_OPERATIONAL* = 5
  tcpConnectionOffloadStateInHost* = 0
  tcpConnectionOffloadStateOffloading* = 1
  tcpConnectionOffloadStateOffloaded* = 2
  tcpConnectionOffloadStateUploading* = 3
  tcpConnectionOffloadStateMax* = 4
  IPRTRMGR_PID* = 10000
  IF_NUMBER* = 0
  IF_TABLE* = IF_NUMBER+1
  IF_ROW* = IF_TABLE+1
  IP_STATS* = IF_ROW+1
  IP_ADDRTABLE* = IP_STATS+1
  IP_ADDRROW* = IP_ADDRTABLE+1
  IP_FORWARDNUMBER* = IP_ADDRROW+1
  IP_FORWARDTABLE* = IP_FORWARDNUMBER+1
  IP_FORWARDROW* = IP_FORWARDTABLE+1
  IP_NETTABLE* = IP_FORWARDROW+1
  IP_NETROW* = IP_NETTABLE+1
  ICMP_STATS* = IP_NETROW+1
  TCP_STATS* = ICMP_STATS+1
  TCP_TABLE* = TCP_STATS+1
  TCP_ROW* = TCP_TABLE+1
  UDP_STATS* = TCP_ROW+1
  UDP_TABLE* = UDP_STATS+1
  UDP_ROW* = UDP_TABLE+1
  MCAST_MFE* = UDP_ROW+1
  MCAST_MFE_STATS* = MCAST_MFE+1
  BEST_IF* = MCAST_MFE_STATS+1
  BEST_ROUTE* = BEST_IF+1
  PROXY_ARP* = BEST_ROUTE+1
  MCAST_IF_ENTRY* = PROXY_ARP+1
  MCAST_GLOBAL* = MCAST_IF_ENTRY+1
  IF_STATUS* = MCAST_GLOBAL+1
  MCAST_BOUNDARY* = IF_STATUS+1
  MCAST_SCOPE* = MCAST_BOUNDARY+1
  DEST_MATCHING* = MCAST_SCOPE+1
  DEST_LONGER* = DEST_MATCHING+1
  DEST_SHORTER* = DEST_LONGER+1
  ROUTE_MATCHING* = DEST_SHORTER+1
  ROUTE_LONGER* = ROUTE_MATCHING+1
  ROUTE_SHORTER* = ROUTE_LONGER+1
  ROUTE_STATE* = ROUTE_SHORTER+1
  MCAST_MFE_STATS_EX* = ROUTE_STATE+1
  IP6_STATS* = MCAST_MFE_STATS_EX+1
  UDP6_STATS* = IP6_STATS+1
  TCP6_STATS* = UDP6_STATS+1
  NUMBER_OF_EXPORTED_VARIABLES* = TCP6_STATS+1
  ICMP6_DST_UNREACH* = 1
  ICMP6_PACKET_TOO_BIG* = 2
  ICMP6_TIME_EXCEEDED* = 3
  ICMP6_PARAM_PROB* = 4
  ICMP6_ECHO_REQUEST* = 128
  ICMP6_ECHO_REPLY* = 129
  ICMP6_MEMBERSHIP_QUERY* = 130
  ICMP6_MEMBERSHIP_REPORT* = 131
  ICMP6_MEMBERSHIP_REDUCTION* = 132
  ND_ROUTER_SOLICIT* = 133
  ND_ROUTER_ADVERT* = 134
  ND_NEIGHBOR_SOLICIT* = 135
  ND_NEIGHBOR_ADVERT* = 136
  ND_REDIRECT* = 137
  ICMP4_ECHO_REPLY* = 0
  ICMP4_DST_UNREACH* = 3
  ICMP4_SOURCE_QUENCH* = 4
  ICMP4_REDIRECT* = 5
  ICMP4_ECHO_REQUEST* = 8
  ICMP4_ROUTER_ADVERT* = 9
  ICMP4_ROUTER_SOLICIT* = 10
  ICMP4_TIME_EXCEEDED* = 11
  ICMP4_PARAM_PROB* = 12
  ICMP4_TIMESTAMP_REQUEST* = 13
  ICMP4_TIMESTAMP_REPLY* = 14
  ICMP4_MASK_REQUEST* = 17
  ICMP4_MASK_REPLY* = 18
  MIB_TCP_RTO_OTHER* = 1
  MIB_TCP_RTO_CONSTANT* = 2
  MIB_TCP_RTO_RSRE* = 3
  MIB_TCP_RTO_VANJ* = 4
  MIB_TCP_MAXCONN_DYNAMIC* = DWORD(-1)
  TCP_TABLE_BASIC_LISTENER* = 0
  TCP_TABLE_BASIC_CONNECTIONS* = 1
  TCP_TABLE_BASIC_ALL* = 2
  TCP_TABLE_OWNER_PID_LISTENER* = 3
  TCP_TABLE_OWNER_PID_CONNECTIONS* = 4
  TCP_TABLE_OWNER_PID_ALL* = 5
  TCP_TABLE_OWNER_MODULE_LISTENER* = 6
  TCP_TABLE_OWNER_MODULE_CONNECTIONS* = 7
  TCP_TABLE_OWNER_MODULE_ALL* = 8
  MIB_TCP_STATE_CLOSED* = 1
  MIB_TCP_STATE_LISTEN* = 2
  MIB_TCP_STATE_SYN_SENT* = 3
  MIB_TCP_STATE_SYN_RCVD* = 4
  MIB_TCP_STATE_ESTAB* = 5
  MIB_TCP_STATE_FIN_WAIT1* = 6
  MIB_TCP_STATE_FIN_WAIT2* = 7
  MIB_TCP_STATE_CLOSE_WAIT* = 8
  MIB_TCP_STATE_CLOSING* = 9
  MIB_TCP_STATE_LAST_ACK* = 10
  MIB_TCP_STATE_TIME_WAIT* = 11
  MIB_TCP_STATE_DELETE_TCB* = 12
  MIB_SECURITY_TCP_SYN_ATTACK* = 0x00000001
  MIB_USE_CURRENT_TTL* = DWORD(-1)
  MIB_USE_CURRENT_FORWARDING* = DWORD(-1)
  MIB_IP_FORWARDING* = 1
  MIB_IP_NOT_FORWARDING* = 2
  MIB_IPADDR_PRIMARY* = 0x0001
  MIB_IPADDR_DYNAMIC* = 0x0004
  MIB_IPADDR_DISCONNECTED* = 0x0008
  MIB_IPADDR_DELETED* = 0x0040
  MIB_IPADDR_TRANSIENT* = 0x0080
  MIB_IPROUTE_TYPE_OTHER* = 1
  MIB_IPROUTE_TYPE_INVALID* = 2
  MIB_IPROUTE_TYPE_DIRECT* = 3
  MIB_IPROUTE_TYPE_INDIRECT* = 4
  MIB_IPROUTE_METRIC_UNUSED* = DWORD(-1)
  MIB_IPPROTO_OTHER* = 1
  MIB_IPPROTO_LOCAL* = 2
  MIB_IPPROTO_NETMGMT* = 3
  MIB_IPPROTO_ICMP* = 4
  MIB_IPPROTO_EGP* = 5
  MIB_IPPROTO_GGP* = 6
  MIB_IPPROTO_HELLO* = 7
  MIB_IPPROTO_RIP* = 8
  MIB_IPPROTO_IS_IS* = 9
  MIB_IPPROTO_ES_IS* = 10
  MIB_IPPROTO_CISCO* = 11
  MIB_IPPROTO_BBN* = 12
  MIB_IPPROTO_OSPF* = 13
  MIB_IPPROTO_BGP* = 14
  MIB_IPPROTO_NT_AUTOSTATIC* = 10002
  MIB_IPPROTO_NT_STATIC* = 10006
  MIB_IPPROTO_NT_STATIC_NON_DOD* = 10007
  MIB_IPNET_TYPE_OTHER* = 1
  MIB_IPNET_TYPE_INVALID* = 2
  MIB_IPNET_TYPE_DYNAMIC* = 3
  MIB_IPNET_TYPE_STATIC* = 4
  UDP_TABLE_BASIC* = 0
  UDP_TABLE_OWNER_PID* = 1
  UDP_TABLE_OWNER_MODULE* = 2
  TCPIP_OWNER_MODULE_INFO_BASIC* = 0
  MAX_MIB_OFFSET* = 8
  IP_EXPORT_INCLUDED* = 1
  IP_STATUS_BASE* = 11000
  IP_SUCCESS* = 0
  IP_BUF_TOO_SMALL* = IP_STATUS_BASE+1
  IP_DEST_NET_UNREACHABLE* = IP_STATUS_BASE+2
  IP_DEST_HOST_UNREACHABLE* = IP_STATUS_BASE+3
  IP_DEST_PROT_UNREACHABLE* = IP_STATUS_BASE+4
  IP_DEST_PORT_UNREACHABLE* = IP_STATUS_BASE+5
  IP_NO_RESOURCES* = IP_STATUS_BASE+6
  IP_BAD_OPTION* = IP_STATUS_BASE+7
  IP_HW_ERROR* = IP_STATUS_BASE+8
  IP_PACKET_TOO_BIG* = IP_STATUS_BASE+9
  IP_REQ_TIMED_OUT* = IP_STATUS_BASE+10
  IP_BAD_REQ* = IP_STATUS_BASE+11
  IP_BAD_ROUTE* = IP_STATUS_BASE+12
  IP_TTL_EXPIRED_TRANSIT* = IP_STATUS_BASE+13
  IP_TTL_EXPIRED_REASSEM* = IP_STATUS_BASE+14
  IP_PARAM_PROBLEM* = IP_STATUS_BASE+15
  IP_SOURCE_QUENCH* = IP_STATUS_BASE+16
  IP_OPTION_TOO_BIG* = IP_STATUS_BASE+17
  IP_BAD_DESTINATION* = IP_STATUS_BASE+18
  IP_DEST_NO_ROUTE* = IP_STATUS_BASE+2
  IP_DEST_ADDR_UNREACHABLE* = IP_STATUS_BASE+3
  IP_DEST_PROHIBITED* = IP_STATUS_BASE+4
  IP_HOP_LIMIT_EXCEEDED* = IP_STATUS_BASE+13
  IP_REASSEMBLY_TIME_EXCEEDED* = IP_STATUS_BASE+14
  IP_PARAMETER_PROBLEM* = IP_STATUS_BASE+15
  IP_DEST_UNREACHABLE* = IP_STATUS_BASE+40
  IP_TIME_EXCEEDED* = IP_STATUS_BASE+41
  IP_BAD_HEADER* = IP_STATUS_BASE+42
  IP_UNRECOGNIZED_NEXT_HEADER* = IP_STATUS_BASE+43
  IP_ICMP_ERROR* = IP_STATUS_BASE+44
  IP_DEST_SCOPE_MISMATCH* = IP_STATUS_BASE+45
  IP_ADDR_DELETED* = IP_STATUS_BASE+19
  IP_SPEC_MTU_CHANGE* = IP_STATUS_BASE+20
  IP_MTU_CHANGE* = IP_STATUS_BASE+21
  IP_UNLOAD* = IP_STATUS_BASE+22
  IP_ADDR_ADDED* = IP_STATUS_BASE+23
  IP_MEDIA_CONNECT* = IP_STATUS_BASE+24
  IP_MEDIA_DISCONNECT* = IP_STATUS_BASE+25
  IP_BIND_ADAPTER* = IP_STATUS_BASE+26
  IP_UNBIND_ADAPTER* = IP_STATUS_BASE+27
  IP_DEVICE_DOES_NOT_EXIST* = IP_STATUS_BASE+28
  IP_DUPLICATE_ADDRESS* = IP_STATUS_BASE+29
  IP_INTERFACE_METRIC_CHANGE* = IP_STATUS_BASE+30
  IP_RECONFIG_SECFLTR* = IP_STATUS_BASE+31
  IP_NEGOTIATING_IPSEC* = IP_STATUS_BASE+32
  IP_INTERFACE_WOL_CAPABILITY_CHANGE* = IP_STATUS_BASE+33
  IP_DUPLICATE_IPADD* = IP_STATUS_BASE+34
  IP_NO_FURTHER_SENDS* = IP_STATUS_BASE+35
  IP_GENERAL_FAILURE* = IP_STATUS_BASE+50
  MAX_IP_STATUS* = IP_GENERAL_FAILURE
  IP_PENDING* = IP_STATUS_BASE+255
  IP_FLAG_DF* = 0x2
  IP_OPT_EOL* = 0
  IP_OPT_NOP* = 1
  IP_OPT_SECURITY* = 0x82
  IP_OPT_LSRR* = 0x83
  IP_OPT_SSRR* = 0x89
  IP_OPT_RR* = 0x7
  IP_OPT_TS* = 0x44
  IP_OPT_SID* = 0x88
  IP_OPT_ROUTER_ALERT* = 0x94
  MAX_OPT_SIZE* = 40
  IOCTL_IP_RTCHANGE_NOTIFY_REQUEST* = 101
  IOCTL_IP_ADDCHANGE_NOTIFY_REQUEST* = 102
  IOCTL_ARP_SEND_REQUEST* = 103
  IOCTL_IP_INTERFACE_INFO* = 104
  IOCTL_IP_GET_BEST_INTERFACE* = 105
  IOCTL_IP_UNIDIRECTIONAL_ADAPTER_ADDRESS* = 106
  ifOperStatusUp* = 1
  ifOperStatusDown* = 2
  ifOperStatusTesting* = 3
  ifOperStatusUnknown* = 4
  ifOperStatusDormant* = 5
  ifOperStatusNotPresent* = 6
  ifOperStatusLowerLayerDown* = 7
  NET_IF_OPER_STATUS_UP* = 1
  NET_IF_OPER_STATUS_DOWN* = 2
  NET_IF_OPER_STATUS_TESTING* = 3
  NET_IF_OPER_STATUS_UNKNOWN* = 4
  NET_IF_OPER_STATUS_DORMANT* = 5
  NET_IF_OPER_STATUS_NOT_PRESENT* = 6
  NET_IF_OPER_STATUS_LOWER_LAYER_DOWN* = 7
  NET_IF_ADMIN_STATUS_UP* = 1
  NET_IF_ADMIN_STATUS_DOWN* = 2
  NET_IF_ADMIN_STATUS_TESTING* = 3
  mediaConnectStateUnknown* = 0
  mediaConnectStateConnected* = 1
  mediaConnectStateDisconnected* = 2
  NET_IF_ACCESS_LOOPBACK* = 1
  NET_IF_ACCESS_BROADCAST* = 2
  NET_IF_ACCESS_POINT_TO_POINT* = 3
  NET_IF_ACCESS_POINT_TO_MULTI_POINT* = 4
  NET_IF_ACCESS_MAXIMUM* = 5
  NET_IF_CONNECTION_DEDICATED* = 1
  NET_IF_CONNECTION_PASSIVE* = 2
  NET_IF_CONNECTION_DEMAND* = 3
  NET_IF_CONNECTION_MAXIMUM* = 4
  NET_IF_DIRECTION_SENDRECEIVE* = 0
  NET_IF_DIRECTION_SENDONLY* = 1
  NET_IF_DIRECTION_RECEIVEONLY* = 2
  NET_IF_DIRECTION_MAXIMUM* = 3
  mediaDuplexStateUnknown* = 0
  mediaDuplexStateHalf* = 1
  mediaDuplexStateFull* = 2
  TUNNEL_TYPE_NONE* = 0
  TUNNEL_TYPE_OTHER* = 1
  TUNNEL_TYPE_DIRECT* = 2
  TUNNEL_TYPE_6TO4* = 11
  TUNNEL_TYPE_ISATAP* = 13
  TUNNEL_TYPE_TEREDO* = 14
  TUNNEL_TYPE_IPHTTPS* = 15
  DEFAULT_MINIMUM_ENTITIES* = 32
  BROADCAST_NODETYPE* = 1
  PEER_TO_PEER_NODETYPE* = 2
  MIXED_NODETYPE* = 4
  HYBRID_NODETYPE* = 8
  IP_ADAPTER_ADDRESS_DNS_ELIGIBLE* = 0x01
  IP_ADAPTER_ADDRESS_TRANSIENT* = 0x02
  IP_ADAPTER_ADDRESS_PRIMARY* = 0x04
  IP_ADAPTER_DDNS_ENABLED* = 0x01
  IP_ADAPTER_REGISTER_ADAPTER_SUFFIX* = 0x02
  IP_ADAPTER_DHCP_ENABLED* = 0x04
  IP_ADAPTER_RECEIVE_ONLY* = 0x08
  IP_ADAPTER_NO_MULTICAST* = 0x10
  IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG* = 0x20
  IP_ADAPTER_NETBIOS_OVER_TCPIP_ENABLED* = 0x40
  IP_ADAPTER_IPV4_ENABLED* = 0x80
  IP_ADAPTER_IPV6_ENABLED* = 0x100
  IP_ADAPTER_IPV6_MANAGE_ADDRESS_CONFIG* = 0x200
  GAA_FLAG_SKIP_UNICAST* = 0x0001
  GAA_FLAG_SKIP_ANYCAST* = 0x0002
  GAA_FLAG_SKIP_MULTICAST* = 0x0004
  GAA_FLAG_SKIP_DNS_SERVER* = 0x0008
  GAA_FLAG_INCLUDE_PREFIX* = 0x0010
  GAA_FLAG_SKIP_FRIENDLY_NAME* = 0x0020
  GAA_FLAG_INCLUDE_WINS_INFO* = 0x0040
  GAA_FLAG_INCLUDE_GATEWAYS* = 0x0080
  GAA_FLAG_INCLUDE_ALL_INTERFACES* = 0x0100
  GAA_FLAG_INCLUDE_ALL_COMPARTMENTS* = 0x0200
  GAA_FLAG_INCLUDE_TUNNEL_BINDINGORDER* = 0x0400
  tcpBoolOptDisabled* = 0
  tcpBoolOptEnabled* = 1
  tcpBoolOptUnchanged* = -1
  tcpConnectionEstatsSynOpts* = 0
  tcpConnectionEstatsData* = 1
  tcpConnectionEstatsSndCong* = 2
  tcpConnectionEstatsPath* = 3
  tcpConnectionEstatsSendBuff* = 4
  tcpConnectionEstatsRec* = 5
  tcpConnectionEstatsObsRec* = 6
  tcpConnectionEstatsBandwidth* = 7
  tcpConnectionEstatsFineRtt* = 8
  tcpConnectionEstatsMaximum* = 9
  NET_STRING_IPV4_ADDRESS* = 0x00000001
  NET_STRING_IPV4_SERVICE* = 0x00000002
  NET_STRING_IPV4_NETWORK* = 0x00000004
  NET_STRING_IPV6_ADDRESS* = 0x00000008
  NET_STRING_IPV6_ADDRESS_NO_SCOPE* = 0x00000010
  NET_STRING_IPV6_SERVICE* = 0x00000020
  NET_STRING_IPV6_SERVICE_NO_SCOPE* = 0x00000040
  NET_STRING_IPV6_NETWORK* = 0x00000080
  NET_STRING_NAMED_ADDRESS* = 0x00000100
  NET_STRING_NAMED_SERVICE* = 0x00000200
  NET_STRING_IP_ADDRESS* = NET_STRING_IPV4_ADDRESS or NET_STRING_IPV6_ADDRESS
  NET_STRING_IP_ADDRESS_NO_SCOPE* = NET_STRING_IPV4_ADDRESS or NET_STRING_IPV6_ADDRESS_NO_SCOPE
  NET_STRING_IP_SERVICE* = NET_STRING_IPV4_SERVICE or NET_STRING_IPV6_SERVICE
  NET_STRING_IP_SERVICE_NO_SCOPE* = NET_STRING_IPV4_SERVICE or NET_STRING_IPV6_SERVICE_NO_SCOPE
  NET_STRING_IP_NETWORK* = NET_STRING_IPV4_NETWORK or NET_STRING_IPV6_NETWORK
  NET_STRING_ANY_ADDRESS* = NET_STRING_NAMED_ADDRESS or NET_STRING_IP_ADDRESS
  NET_STRING_ANY_ADDRESS_NO_SCOPE* = NET_STRING_NAMED_ADDRESS or NET_STRING_IP_ADDRESS_NO_SCOPE
  NET_STRING_ANY_SERVICE* = NET_STRING_NAMED_SERVICE or NET_STRING_IP_SERVICE
  NET_STRING_ANY_SERVICE_NO_SCOPE* = NET_STRING_NAMED_SERVICE or NET_STRING_IP_SERVICE_NO_SCOPE
  NET_ADDRESS_FORMAT_UNSPECIFIED* = 0
  NET_ADDRESS_DNS_NAME* = 1
  NET_ADDRESS_IPV4* = 2
  NET_ADDRESS_IPV6* = 3
  NDIS_IF_MAX_STRING_SIZE* = IF_MAX_STRING_SIZE
  IF_NAMESIZE* = NDIS_IF_MAX_STRING_SIZE
  mibParameterNotification* = 0
  mibAddInstance* = 1
  mibDeleteInstance* = 2
  mibInitialNotification* = 3
  DD_NDIS_DEVICE_NAME* = "\\Device\\UNKNOWN"
  NDIS_OBJECT_TYPE_DEFAULT* = 0x80
  NDIS_OBJECT_TYPE_MINIPORT_INIT_PARAMETERS* = 0x81
  NDIS_OBJECT_TYPE_SG_DMA_DESCRIPTION* = 0x83
  NDIS_OBJECT_TYPE_MINIPORT_INTERRUPT* = 0x84
  NDIS_OBJECT_TYPE_DEVICE_OBJECT_ATTRIBUTES* = 0x85
  NDIS_OBJECT_TYPE_BIND_PARAMETERS* = 0x86
  NDIS_OBJECT_TYPE_OPEN_PARAMETERS* = 0x87
  NDIS_OBJECT_TYPE_RSS_CAPABILITIES* = 0x88
  NDIS_OBJECT_TYPE_RSS_PARAMETERS* = 0x89
  NDIS_OBJECT_TYPE_MINIPORT_DRIVER_CHARACTERISTICS* = 0x8a
  NDIS_OBJECT_TYPE_FILTER_DRIVER_CHARACTERISTICS* = 0x8b
  NDIS_OBJECT_TYPE_FILTER_PARTIAL_CHARACTERISTICS* = 0x8c
  NDIS_OBJECT_TYPE_FILTER_ATTRIBUTES* = 0x8d
  NDIS_OBJECT_TYPE_CLIENT_CHIMNEY_OFFLOAD_GENERIC_CHARACTERISTICS* = 0x8e
  NDIS_OBJECT_TYPE_PROVIDER_CHIMNEY_OFFLOAD_GENERIC_CHARACTERISTICS* = 0x8f
  NDIS_OBJECT_TYPE_CO_PROTOCOL_CHARACTERISTICS* = 0x90
  NDIS_OBJECT_TYPE_CO_MINIPORT_CHARACTERISTICS* = 0x91
  NDIS_OBJECT_TYPE_MINIPORT_PNP_CHARACTERISTICS* = 0x92
  NDIS_OBJECT_TYPE_CLIENT_CHIMNEY_OFFLOAD_CHARACTERISTICS* = 0x93
  NDIS_OBJECT_TYPE_PROVIDER_CHIMNEY_OFFLOAD_CHARACTERISTICS* = 0x94
  NDIS_OBJECT_TYPE_PROTOCOL_DRIVER_CHARACTERISTICS* = 0x95
  NDIS_OBJECT_TYPE_REQUEST_EX* = 0x96
  NDIS_OBJECT_TYPE_OID_REQUEST* = 0x96
  NDIS_OBJECT_TYPE_TIMER_CHARACTERISTICS* = 0x97
  NDIS_OBJECT_TYPE_STATUS_INDICATION* = 0x98
  NDIS_OBJECT_TYPE_FILTER_ATTACH_PARAMETERS* = 0x99
  NDIS_OBJECT_TYPE_FILTER_PAUSE_PARAMETERS* = 0x9a
  NDIS_OBJECT_TYPE_FILTER_RESTART_PARAMETERS* = 0x9b
  NDIS_OBJECT_TYPE_PORT_CHARACTERISTICS* = 0x9c
  NDIS_OBJECT_TYPE_PORT_STATE* = 0x9d
  NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_REGISTRATION_ATTRIBUTES* = 0x9e
  NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_GENERAL_ATTRIBUTES* = 0x9f
  NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_OFFLOAD_ATTRIBUTES* = 0xa0
  NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_NATIVE_802_11_ATTRIBUTES* = 0xa1
  NDIS_OBJECT_TYPE_RESTART_GENERAL_ATTRIBUTES* = 0xa2
  NDIS_OBJECT_TYPE_PROTOCOL_RESTART_PARAMETERS* = 0xa3
  NDIS_OBJECT_TYPE_MINIPORT_ADD_DEVICE_REGISTRATION_ATTRIBUTES* = 0xa4
  NDIS_OBJECT_TYPE_CO_CALL_MANAGER_OPTIONAL_HANDLERS* = 0xa5
  NDIS_OBJECT_TYPE_CO_CLIENT_OPTIONAL_HANDLERS* = 0xa6
  NDIS_OBJECT_TYPE_OFFLOAD* = 0xa7
  NDIS_OBJECT_TYPE_OFFLOAD_ENCAPSULATION* = 0xa8
  NDIS_OBJECT_TYPE_CONFIGURATION_OBJECT* = 0xa9
  NDIS_OBJECT_TYPE_DRIVER_WRAPPER_OBJECT* = 0xaa
  NDIS_OBJECT_TYPE_HD_SPLIT_ATTRIBUTES* = 0xab
  NDIS_OBJECT_TYPE_NSI_NETWORK_RW_STRUCT* = 0xac
  NDIS_OBJECT_TYPE_NSI_COMPARTMENT_RW_STRUCT* = 0xad
  NDIS_OBJECT_TYPE_NSI_INTERFACE_PERSIST_RW_STRUCT* = 0xae
  NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_HARDWARE_ASSIST_ATTRIBUTES* = 0xaf
  NDIS_OBJECT_TYPE_SHARED_MEMORY_PROVIDER_CHARACTERISTICS* = 0xb0
  NDIS_OBJECT_TYPE_RSS_PROCESSOR_INFO* = 0xb1
  NDIS_OBJECT_TYPE_NDK_PROVIDER_CHARACTERISTICS* = 0xb2
  NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_NDK_ATTRIBUTES* = 0xb3
  NDIS_OBJECT_TYPE_MINIPORT_SS_CHARACTERISTICS* = 0xb4
  NDIS_OBJECT_TYPE_QOS_CAPABILITIES* = 0xb5
  NDIS_OBJECT_TYPE_QOS_PARAMETERS* = 0xb6
  NDIS_OBJECT_TYPE_QOS_CLASSIFICATION_ELEMENT* = 0xb7
  NDIS_OBJECT_TYPE_SWITCH_OPTIONAL_HANDLERS* = 0xb8
  NDIS_OBJECT_TYPE_IOCTL_OID_INFO* = 0xb9
  NDIS_OBJECT_TYPE_LBFO_DIAGNOSTIC_OID* = 0xba
  ndisRequestQueryInformation* = 0
  ndisRequestSetInformation* = 1
  ndisRequestQueryStatistics* = 2
  ndisRequestOpen* = 3
  ndisRequestClose* = 4
  ndisRequestSend* = 5
  ndisRequestTransferData* = 6
  ndisRequestReset* = 7
  ndisRequestGeneric1* = 8
  ndisRequestGeneric2* = 9
  ndisRequestGeneric3* = 10
  ndisRequestGeneric4* = 11
  ndisRequestMethod* = 12
  NDIS_OBJECT_REVISION_1* = 1
  NDIS_STATISTICS_FLAGS_VALID_DIRECTED_FRAMES_RCV* = 0x00000001
  NDIS_STATISTICS_FLAGS_VALID_MULTICAST_FRAMES_RCV* = 0x00000002
  NDIS_STATISTICS_FLAGS_VALID_BROADCAST_FRAMES_RCV* = 0x00000004
  NDIS_STATISTICS_FLAGS_VALID_BYTES_RCV* = 0x00000008
  NDIS_STATISTICS_FLAGS_VALID_RCV_DISCARDS* = 0x00000010
  NDIS_STATISTICS_FLAGS_VALID_RCV_ERROR* = 0x00000020
  NDIS_STATISTICS_FLAGS_VALID_DIRECTED_FRAMES_XMIT* = 0x00000040
  NDIS_STATISTICS_FLAGS_VALID_MULTICAST_FRAMES_XMIT* = 0x00000080
  NDIS_STATISTICS_FLAGS_VALID_BROADCAST_FRAMES_XMIT* = 0x00000100
  NDIS_STATISTICS_FLAGS_VALID_BYTES_XMIT* = 0x00000200
  NDIS_STATISTICS_FLAGS_VALID_XMIT_ERROR* = 0x00000400
  NDIS_STATISTICS_FLAGS_VALID_XMIT_DISCARDS* = 0x00008000
  NDIS_STATISTICS_FLAGS_VALID_DIRECTED_BYTES_RCV* = 0x00010000
  NDIS_STATISTICS_FLAGS_VALID_MULTICAST_BYTES_RCV* = 0x00020000
  NDIS_STATISTICS_FLAGS_VALID_BROADCAST_BYTES_RCV* = 0x00040000
  NDIS_STATISTICS_FLAGS_VALID_DIRECTED_BYTES_XMIT* = 0x00080000
  NDIS_STATISTICS_FLAGS_VALID_MULTICAST_BYTES_XMIT* = 0x00100000
  NDIS_STATISTICS_FLAGS_VALID_BROADCAST_BYTES_XMIT* = 0x00200000
  NDIS_INTERRUPT_MODERATION_CHANGE_NEEDS_RESET* = 0x00000001
  NDIS_INTERRUPT_MODERATION_CHANGE_NEEDS_REINITIALIZE* = 0x00000002
  NDIS_STATISTICS_INFO_REVISION_1* = 1
  NDIS_INTERRUPT_MODERATION_PARAMETERS_REVISION_1* = 1
  NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES_REVISION_1* = 1
  NDIS_OBJECT_TYPE_PCI_DEVICE_CUSTOM_PROPERTIES_REVISION_1* = 1
  NDIS_OBJECT_TYPE_PCI_DEVICE_CUSTOM_PROPERTIES_REVISION_2* = 2
  NDIS_RSC_STATISTICS_REVISION_1* = 1
  ndisInterruptModerationUnknown* = 0
  ndisInterruptModerationNotSupported* = 1
  ndisInterruptModerationEnabled* = 2
  ndisInterruptModerationDisabled* = 3
  OID_GEN_SUPPORTED_LIST* = 0x00010101
  OID_GEN_HARDWARE_STATUS* = 0x00010102
  OID_GEN_MEDIA_SUPPORTED* = 0x00010103
  OID_GEN_MEDIA_IN_USE* = 0x00010104
  OID_GEN_MAXIMUM_LOOKAHEAD* = 0x00010105
  OID_GEN_MAXIMUM_FRAME_SIZE* = 0x00010106
  OID_GEN_LINK_SPEED* = 0x00010107
  OID_GEN_TRANSMIT_BUFFER_SPACE* = 0x00010108
  OID_GEN_RECEIVE_BUFFER_SPACE* = 0x00010109
  OID_GEN_TRANSMIT_BLOCK_SIZE* = 0x0001010a
  OID_GEN_RECEIVE_BLOCK_SIZE* = 0x0001010b
  OID_GEN_VENDOR_ID* = 0x0001010c
  OID_GEN_VENDOR_DESCRIPTION* = 0x0001010d
  OID_GEN_CURRENT_PACKET_FILTER* = 0x0001010e
  OID_GEN_CURRENT_LOOKAHEAD* = 0x0001010f
  OID_GEN_DRIVER_VERSION* = 0x00010110
  OID_GEN_MAXIMUM_TOTAL_SIZE* = 0x00010111
  OID_GEN_PROTOCOL_OPTIONS* = 0x00010112
  OID_GEN_MAC_OPTIONS* = 0x00010113
  OID_GEN_MEDIA_CONNECT_STATUS* = 0x00010114
  OID_GEN_MAXIMUM_SEND_PACKETS* = 0x00010115
  OID_GEN_VENDOR_DRIVER_VERSION* = 0x00010116
  OID_GEN_SUPPORTED_GUIDS* = 0x00010117
  OID_GEN_NETWORK_LAYER_ADDRESSES* = 0x00010118
  OID_GEN_TRANSPORT_HEADER_OFFSET* = 0x00010119
  OID_GEN_MEDIA_CAPABILITIES* = 0x00010201
  OID_GEN_PHYSICAL_MEDIUM* = 0x00010202
  OID_GEN_RECEIVE_SCALE_CAPABILITIES* = 0x00010203
  OID_GEN_RECEIVE_SCALE_PARAMETERS* = 0x00010204
  OID_GEN_MAC_ADDRESS* = 0x00010205
  OID_GEN_MAX_LINK_SPEED* = 0x00010206
  OID_GEN_LINK_STATE* = 0x00010207
  OID_GEN_LINK_PARAMETERS* = 0x00010208
  OID_GEN_INTERRUPT_MODERATION* = 0x00010209
  OID_GEN_NDIS_RESERVED_3* = 0x0001020a
  OID_GEN_NDIS_RESERVED_4* = 0x0001020b
  OID_GEN_NDIS_RESERVED_5* = 0x0001020c
  OID_GEN_ENUMERATE_PORTS* = 0x0001020d
  OID_GEN_PORT_STATE* = 0x0001020e
  OID_GEN_PORT_AUTHENTICATION_PARAMETERS* = 0x0001020f
  OID_GEN_TIMEOUT_DPC_REQUEST_CAPABILITIES* = 0x00010210
  OID_GEN_PCI_DEVICE_CUSTOM_PROPERTIES* = 0x00010211
  OID_GEN_NDIS_RESERVED_6* = 0x00010212
  OID_GEN_PHYSICAL_MEDIUM_EX* = 0x00010213
  OID_GEN_MACHINE_NAME* = 0x0001021a
  OID_GEN_RNDIS_CONFIG_PARAMETER* = 0x0001021b
  OID_GEN_VLAN_ID* = 0x0001021c
  OID_GEN_RECEIVE_HASH* = 0x0001021f
  OID_GEN_MINIPORT_RESTART_ATTRIBUTES* = 0x0001021d
  OID_GEN_HD_SPLIT_PARAMETERS* = 0x0001021e
  OID_GEN_HD_SPLIT_CURRENT_CONFIG* = 0x00010220
  OID_GEN_PROMISCUOUS_MODE* = 0x00010280
  OID_GEN_LAST_CHANGE* = 0x00010281
  OID_GEN_DISCONTINUITY_TIME* = 0x00010282
  OID_GEN_OPERATIONAL_STATUS* = 0x00010283
  OID_GEN_XMIT_LINK_SPEED* = 0x00010284
  OID_GEN_RCV_LINK_SPEED* = 0x00010285
  OID_GEN_UNKNOWN_PROTOS* = 0x00010286
  OID_GEN_INTERFACE_INFO* = 0x00010287
  OID_GEN_ADMIN_STATUS* = 0x00010288
  OID_GEN_ALIAS* = 0x00010289
  OID_GEN_MEDIA_CONNECT_STATUS_EX* = 0x0001028a
  OID_GEN_LINK_SPEED_EX* = 0x0001028b
  OID_GEN_MEDIA_DUPLEX_STATE* = 0x0001028c
  OID_GEN_IP_OPER_STATUS* = 0x0001028d
  OID_WWAN_DRIVER_CAPS* = 0x0e010100
  OID_WWAN_DEVICE_CAPS* = 0x0e010101
  OID_WWAN_READY_INFO* = 0x0e010102
  OID_WWAN_RADIO_STATE* = 0x0e010103
  OID_WWAN_PIN* = 0x0e010104
  OID_WWAN_PIN_LIST* = 0x0e010105
  OID_WWAN_HOME_PROVIDER* = 0x0e010106
  OID_WWAN_PREFERRED_PROVIDERS* = 0x0e010107
  OID_WWAN_VISIBLE_PROVIDERS* = 0x0e010108
  OID_WWAN_REGISTER_STATE* = 0x0e010109
  OID_WWAN_PACKET_SERVICE* = 0x0e01010a
  OID_WWAN_SIGNAL_STATE* = 0x0e01010b
  OID_WWAN_CONNECT* = 0x0e01010c
  OID_WWAN_PROVISIONED_CONTEXTS* = 0x0e01010d
  OID_WWAN_SERVICE_ACTIVATION* = 0x0e01010e
  OID_WWAN_SMS_CONFIGURATION* = 0x0e01010f
  OID_WWAN_SMS_READ* = 0x0e010110
  OID_WWAN_SMS_SEND* = 0x0e010111
  OID_WWAN_SMS_DELETE* = 0x0e010112
  OID_WWAN_SMS_STATUS* = 0x0e010113
  OID_WWAN_VENDOR_SPECIFIC* = 0x0e010114
  OID_WWAN_AUTH_CHALLENGE* = 0x0e010115
  OID_WWAN_ENUMERATE_DEVICE_SERVICES* = 0x0e010116
  OID_WWAN_SUBSCRIBE_DEVICE_SERVICE_EVENTS* = 0x0e010117
  OID_WWAN_DEVICE_SERVICE_COMMAND* = 0x0e010118
  OID_WWAN_USSD* = 0x0e010119
  OID_WWAN_PIN_EX* = 0x0e010121
  OID_WWAN_ENUMERATE_DEVICE_SERVICE_COMMANDS* = 0x0e010122
  OID_WWAN_DEVICE_SERVICE_SESSION* = 0x0e010123
  OID_WWAN_DEVICE_SERVICE_SESSION_WRITE* = 0x0e010124
  OID_WWAN_PREFERRED_MULTICARRIER_PROVIDERS* = 0x0e010125
  OID_GEN_XMIT_OK* = 0x00020101
  OID_GEN_RCV_OK* = 0x00020102
  OID_GEN_XMIT_ERROR* = 0x00020103
  OID_GEN_RCV_ERROR* = 0x00020104
  OID_GEN_RCV_NO_BUFFER* = 0x00020105
  OID_GEN_STATISTICS* = 0x00020106
  OID_GEN_DIRECTED_BYTES_XMIT* = 0x00020201
  OID_GEN_DIRECTED_FRAMES_XMIT* = 0x00020202
  OID_GEN_MULTICAST_BYTES_XMIT* = 0x00020203
  OID_GEN_MULTICAST_FRAMES_XMIT* = 0x00020204
  OID_GEN_BROADCAST_BYTES_XMIT* = 0x00020205
  OID_GEN_BROADCAST_FRAMES_XMIT* = 0x00020206
  OID_GEN_DIRECTED_BYTES_RCV* = 0x00020207
  OID_GEN_DIRECTED_FRAMES_RCV* = 0x00020208
  OID_GEN_MULTICAST_BYTES_RCV* = 0x00020209
  OID_GEN_MULTICAST_FRAMES_RCV* = 0x0002020a
  OID_GEN_BROADCAST_BYTES_RCV* = 0x0002020b
  OID_GEN_BROADCAST_FRAMES_RCV* = 0x0002020c
  OID_GEN_RCV_CRC_ERROR* = 0x0002020d
  OID_GEN_TRANSMIT_QUEUE_LENGTH* = 0x0002020e
  OID_GEN_GET_TIME_CAPS* = 0x0002020f
  OID_GEN_GET_NETCARD_TIME* = 0x00020210
  OID_GEN_NETCARD_LOAD* = 0x00020211
  OID_GEN_DEVICE_PROFILE* = 0x00020212
  OID_GEN_INIT_TIME_MS* = 0x00020213
  OID_GEN_RESET_COUNTS* = 0x00020214
  OID_GEN_MEDIA_SENSE_COUNTS* = 0x00020215
  OID_GEN_FRIENDLY_NAME* = 0x00020216
  OID_GEN_NDIS_RESERVED_1* = 0x00020217
  OID_GEN_NDIS_RESERVED_2* = 0x00020218
  OID_GEN_BYTES_RCV* = 0x00020219
  OID_GEN_BYTES_XMIT* = 0x0002021a
  OID_GEN_RCV_DISCARDS* = 0x0002021b
  OID_GEN_XMIT_DISCARDS* = 0x0002021c
  OID_TCP_RSC_STATISTICS* = 0x0002021d
  OID_GEN_NDIS_RESERVED_7* = 0x0002021e
  OID_GEN_CO_SUPPORTED_LIST* = OID_GEN_SUPPORTED_LIST
  OID_GEN_CO_HARDWARE_STATUS* = OID_GEN_HARDWARE_STATUS
  OID_GEN_CO_MEDIA_SUPPORTED* = OID_GEN_MEDIA_SUPPORTED
  OID_GEN_CO_MEDIA_IN_USE* = OID_GEN_MEDIA_IN_USE
  OID_GEN_CO_LINK_SPEED* = OID_GEN_LINK_SPEED
  OID_GEN_CO_VENDOR_ID* = OID_GEN_VENDOR_ID
  OID_GEN_CO_VENDOR_DESCRIPTION* = OID_GEN_VENDOR_DESCRIPTION
  OID_GEN_CO_DRIVER_VERSION* = OID_GEN_DRIVER_VERSION
  OID_GEN_CO_PROTOCOL_OPTIONS* = OID_GEN_PROTOCOL_OPTIONS
  OID_GEN_CO_MAC_OPTIONS* = OID_GEN_MAC_OPTIONS
  OID_GEN_CO_MEDIA_CONNECT_STATUS* = OID_GEN_MEDIA_CONNECT_STATUS
  OID_GEN_CO_VENDOR_DRIVER_VERSION* = OID_GEN_VENDOR_DRIVER_VERSION
  OID_GEN_CO_SUPPORTED_GUIDS* = OID_GEN_SUPPORTED_GUIDS
  OID_GEN_CO_GET_TIME_CAPS* = OID_GEN_GET_TIME_CAPS
  OID_GEN_CO_GET_NETCARD_TIME* = OID_GEN_GET_NETCARD_TIME
  OID_GEN_CO_MINIMUM_LINK_SPEED* = 0x00020120
  OID_GEN_CO_XMIT_PDUS_OK* = OID_GEN_XMIT_OK
  OID_GEN_CO_RCV_PDUS_OK* = OID_GEN_RCV_OK
  OID_GEN_CO_XMIT_PDUS_ERROR* = OID_GEN_XMIT_ERROR
  OID_GEN_CO_RCV_PDUS_ERROR* = OID_GEN_RCV_ERROR
  OID_GEN_CO_RCV_PDUS_NO_BUFFER* = OID_GEN_RCV_NO_BUFFER
  OID_GEN_CO_RCV_CRC_ERROR* = OID_GEN_RCV_CRC_ERROR
  OID_GEN_CO_TRANSMIT_QUEUE_LENGTH* = OID_GEN_TRANSMIT_QUEUE_LENGTH
  OID_GEN_CO_BYTES_XMIT* = OID_GEN_DIRECTED_BYTES_XMIT
  OID_GEN_CO_BYTES_RCV* = OID_GEN_DIRECTED_BYTES_RCV
  OID_GEN_CO_NETCARD_LOAD* = OID_GEN_NETCARD_LOAD
  OID_GEN_CO_DEVICE_PROFILE* = OID_GEN_DEVICE_PROFILE
  OID_GEN_CO_BYTES_XMIT_OUTSTANDING* = 0x00020221
  OID_802_3_PERMANENT_ADDRESS* = 0x01010101
  OID_802_3_CURRENT_ADDRESS* = 0x01010102
  OID_802_3_MULTICAST_LIST* = 0x01010103
  OID_802_3_MAXIMUM_LIST_SIZE* = 0x01010104
  OID_802_3_MAC_OPTIONS* = 0x01010105
  NDIS_802_3_MAC_OPTION_PRIORITY* = 0x00000001
  OID_802_3_RCV_ERROR_ALIGNMENT* = 0x01020101
  OID_802_3_XMIT_ONE_COLLISION* = 0x01020102
  OID_802_3_XMIT_MORE_COLLISIONS* = 0x01020103
  OID_802_3_XMIT_DEFERRED* = 0x01020201
  OID_802_3_XMIT_MAX_COLLISIONS* = 0x01020202
  OID_802_3_RCV_OVERRUN* = 0x01020203
  OID_802_3_XMIT_UNDERRUN* = 0x01020204
  OID_802_3_XMIT_HEARTBEAT_FAILURE* = 0x01020205
  OID_802_3_XMIT_TIMES_CRS_LOST* = 0x01020206
  OID_802_3_XMIT_LATE_COLLISIONS* = 0x01020207
  OID_802_3_ADD_MULTICAST_ADDRESS* = 0x01010208
  OID_802_3_DELETE_MULTICAST_ADDRESS* = 0x01010209
  OID_802_5_PERMANENT_ADDRESS* = 0x02010101
  OID_802_5_CURRENT_ADDRESS* = 0x02010102
  OID_802_5_CURRENT_FUNCTIONAL* = 0x02010103
  OID_802_5_CURRENT_GROUP* = 0x02010104
  OID_802_5_LAST_OPEN_STATUS* = 0x02010105
  OID_802_5_CURRENT_RING_STATUS* = 0x02010106
  OID_802_5_CURRENT_RING_STATE* = 0x02010107
  OID_802_5_LINE_ERRORS* = 0x02020101
  OID_802_5_LOST_FRAMES* = 0x02020102
  OID_802_5_BURST_ERRORS* = 0x02020201
  OID_802_5_AC_ERRORS* = 0x02020202
  OID_802_5_ABORT_DELIMETERS* = 0x02020203
  OID_802_5_FRAME_COPIED_ERRORS* = 0x02020204
  OID_802_5_FREQUENCY_ERRORS* = 0x02020205
  OID_802_5_TOKEN_ERRORS* = 0x02020206
  OID_802_5_INTERNAL_ERRORS* = 0x02020207
  OID_FDDI_LONG_PERMANENT_ADDR* = 0x03010101
  OID_FDDI_LONG_CURRENT_ADDR* = 0x03010102
  OID_FDDI_LONG_MULTICAST_LIST* = 0x03010103
  OID_FDDI_LONG_MAX_LIST_SIZE* = 0x03010104
  OID_FDDI_SHORT_PERMANENT_ADDR* = 0x03010105
  OID_FDDI_SHORT_CURRENT_ADDR* = 0x03010106
  OID_FDDI_SHORT_MULTICAST_LIST* = 0x03010107
  OID_FDDI_SHORT_MAX_LIST_SIZE* = 0x03010108
  OID_FDDI_ATTACHMENT_TYPE* = 0x03020101
  OID_FDDI_UPSTREAM_NODE_LONG* = 0x03020102
  OID_FDDI_DOWNSTREAM_NODE_LONG* = 0x03020103
  OID_FDDI_FRAME_ERRORS* = 0x03020104
  OID_FDDI_FRAMES_LOST* = 0x03020105
  OID_FDDI_RING_MGT_STATE* = 0x03020106
  OID_FDDI_LCT_FAILURES* = 0x03020107
  OID_FDDI_LEM_REJECTS* = 0x03020108
  OID_FDDI_LCONNECTION_STATE* = 0x03020109
  OID_FDDI_SMT_STATION_ID* = 0x03030201
  OID_FDDI_SMT_OP_VERSION_ID* = 0x03030202
  OID_FDDI_SMT_HI_VERSION_ID* = 0x03030203
  OID_FDDI_SMT_LO_VERSION_ID* = 0x03030204
  OID_FDDI_SMT_MANUFACTURER_DATA* = 0x03030205
  OID_FDDI_SMT_USER_DATA* = 0x03030206
  OID_FDDI_SMT_MIB_VERSION_ID* = 0x03030207
  OID_FDDI_SMT_MAC_CT* = 0x03030208
  OID_FDDI_SMT_NON_MASTER_CT* = 0x03030209
  OID_FDDI_SMT_MASTER_CT* = 0x0303020a
  OID_FDDI_SMT_AVAILABLE_PATHS* = 0x0303020b
  OID_FDDI_SMT_CONFIG_CAPABILITIES* = 0x0303020c
  OID_FDDI_SMT_CONFIG_POLICY* = 0x0303020d
  OID_FDDI_SMT_CONNECTION_POLICY* = 0x0303020e
  OID_FDDI_SMT_T_NOTIFY* = 0x0303020f
  OID_FDDI_SMT_STAT_RPT_POLICY* = 0x03030210
  OID_FDDI_SMT_TRACE_MAX_EXPIRATION* = 0x03030211
  OID_FDDI_SMT_PORT_INDEXES* = 0x03030212
  OID_FDDI_SMT_MAC_INDEXES* = 0x03030213
  OID_FDDI_SMT_BYPASS_PRESENT* = 0x03030214
  OID_FDDI_SMT_ECM_STATE* = 0x03030215
  OID_FDDI_SMT_CF_STATE* = 0x03030216
  OID_FDDI_SMT_HOLD_STATE* = 0x03030217
  OID_FDDI_SMT_REMOTE_DISCONNECT_FLAG* = 0x03030218
  OID_FDDI_SMT_STATION_STATUS* = 0x03030219
  OID_FDDI_SMT_PEER_WRAP_FLAG* = 0x0303021a
  OID_FDDI_SMT_MSG_TIME_STAMP* = 0x0303021b
  OID_FDDI_SMT_TRANSITION_TIME_STAMP* = 0x0303021c
  OID_FDDI_SMT_SET_COUNT* = 0x0303021d
  OID_FDDI_SMT_LAST_SET_STATION_ID* = 0x0303021e
  OID_FDDI_MAC_FRAME_STATUS_FUNCTIONS* = 0x0303021f
  OID_FDDI_MAC_BRIDGE_FUNCTIONS* = 0x03030220
  OID_FDDI_MAC_T_MAX_CAPABILITY* = 0x03030221
  OID_FDDI_MAC_TVX_CAPABILITY* = 0x03030222
  OID_FDDI_MAC_AVAILABLE_PATHS* = 0x03030223
  OID_FDDI_MAC_CURRENT_PATH* = 0x03030224
  OID_FDDI_MAC_UPSTREAM_NBR* = 0x03030225
  OID_FDDI_MAC_DOWNSTREAM_NBR* = 0x03030226
  OID_FDDI_MAC_OLD_UPSTREAM_NBR* = 0x03030227
  OID_FDDI_MAC_OLD_DOWNSTREAM_NBR* = 0x03030228
  OID_FDDI_MAC_DUP_ADDRESS_TEST* = 0x03030229
  OID_FDDI_MAC_REQUESTED_PATHS* = 0x0303022a
  OID_FDDI_MAC_DOWNSTREAM_PORT_TYPE* = 0x0303022b
  OID_FDDI_MAC_INDEX* = 0x0303022c
  OID_FDDI_MAC_SMT_ADDRESS* = 0x0303022d
  OID_FDDI_MAC_LONG_GRP_ADDRESS* = 0x0303022e
  OID_FDDI_MAC_SHORT_GRP_ADDRESS* = 0x0303022f
  OID_FDDI_MAC_T_REQ* = 0x03030230
  OID_FDDI_MAC_T_NEG* = 0x03030231
  OID_FDDI_MAC_T_MAX* = 0x03030232
  OID_FDDI_MAC_TVX_VALUE* = 0x03030233
  OID_FDDI_MAC_T_PRI0* = 0x03030234
  OID_FDDI_MAC_T_PRI1* = 0x03030235
  OID_FDDI_MAC_T_PRI2* = 0x03030236
  OID_FDDI_MAC_T_PRI3* = 0x03030237
  OID_FDDI_MAC_T_PRI4* = 0x03030238
  OID_FDDI_MAC_T_PRI5* = 0x03030239
  OID_FDDI_MAC_T_PRI6* = 0x0303023a
  OID_FDDI_MAC_FRAME_CT* = 0x0303023b
  OID_FDDI_MAC_COPIED_CT* = 0x0303023c
  OID_FDDI_MAC_TRANSMIT_CT* = 0x0303023d
  OID_FDDI_MAC_TOKEN_CT* = 0x0303023e
  OID_FDDI_MAC_ERROR_CT* = 0x0303023f
  OID_FDDI_MAC_LOST_CT* = 0x03030240
  OID_FDDI_MAC_TVX_EXPIRED_CT* = 0x03030241
  OID_FDDI_MAC_NOT_COPIED_CT* = 0x03030242
  OID_FDDI_MAC_LATE_CT* = 0x03030243
  OID_FDDI_MAC_RING_OP_CT* = 0x03030244
  OID_FDDI_MAC_FRAME_ERROR_THRESHOLD* = 0x03030245
  OID_FDDI_MAC_FRAME_ERROR_RATIO* = 0x03030246
  OID_FDDI_MAC_NOT_COPIED_THRESHOLD* = 0x03030247
  OID_FDDI_MAC_NOT_COPIED_RATIO* = 0x03030248
  OID_FDDI_MAC_RMT_STATE* = 0x03030249
  OID_FDDI_MAC_DA_FLAG* = 0x0303024a
  OID_FDDI_MAC_UNDA_FLAG* = 0x0303024b
  OID_FDDI_MAC_FRAME_ERROR_FLAG* = 0x0303024c
  OID_FDDI_MAC_NOT_COPIED_FLAG* = 0x0303024d
  OID_FDDI_MAC_MA_UNITDATA_AVAILABLE* = 0x0303024e
  OID_FDDI_MAC_HARDWARE_PRESENT* = 0x0303024f
  OID_FDDI_MAC_MA_UNITDATA_ENABLE* = 0x03030250
  OID_FDDI_PATH_INDEX* = 0x03030251
  OID_FDDI_PATH_RING_LATENCY* = 0x03030252
  OID_FDDI_PATH_TRACE_STATUS* = 0x03030253
  OID_FDDI_PATH_SBA_PAYLOAD* = 0x03030254
  OID_FDDI_PATH_SBA_OVERHEAD* = 0x03030255
  OID_FDDI_PATH_CONFIGURATION* = 0x03030256
  OID_FDDI_PATH_T_R_MODE* = 0x03030257
  OID_FDDI_PATH_SBA_AVAILABLE* = 0x03030258
  OID_FDDI_PATH_TVX_LOWER_BOUND* = 0x03030259
  OID_FDDI_PATH_T_MAX_LOWER_BOUND* = 0x0303025a
  OID_FDDI_PATH_MAX_T_REQ* = 0x0303025b
  OID_FDDI_PORT_MY_TYPE* = 0x0303025c
  OID_FDDI_PORT_NEIGHBOR_TYPE* = 0x0303025d
  OID_FDDI_PORT_CONNECTION_POLICIES* = 0x0303025e
  OID_FDDI_PORT_MAC_INDICATED* = 0x0303025f
  OID_FDDI_PORT_CURRENT_PATH* = 0x03030260
  OID_FDDI_PORT_REQUESTED_PATHS* = 0x03030261
  OID_FDDI_PORT_MAC_PLACEMENT* = 0x03030262
  OID_FDDI_PORT_AVAILABLE_PATHS* = 0x03030263
  OID_FDDI_PORT_MAC_LOOP_TIME* = 0x03030264
  OID_FDDI_PORT_PMD_CLASS* = 0x03030265
  OID_FDDI_PORT_CONNECTION_CAPABILITIES* = 0x03030266
  OID_FDDI_PORT_INDEX* = 0x03030267
  OID_FDDI_PORT_MAINT_LS* = 0x03030268
  OID_FDDI_PORT_BS_FLAG* = 0x03030269
  OID_FDDI_PORT_PC_LS* = 0x0303026a
  OID_FDDI_PORT_EB_ERROR_CT* = 0x0303026b
  OID_FDDI_PORT_LCT_FAIL_CT* = 0x0303026c
  OID_FDDI_PORT_LER_ESTIMATE* = 0x0303026d
  OID_FDDI_PORT_LEM_REJECT_CT* = 0x0303026e
  OID_FDDI_PORT_LEM_CT* = 0x0303026f
  OID_FDDI_PORT_LER_CUTOFF* = 0x03030270
  OID_FDDI_PORT_LER_ALARM* = 0x03030271
  OID_FDDI_PORT_CONNNECT_STATE* = 0x03030272
  OID_FDDI_PORT_PCM_STATE* = 0x03030273
  OID_FDDI_PORT_PC_WITHHOLD* = 0x03030274
  OID_FDDI_PORT_LER_FLAG* = 0x03030275
  OID_FDDI_PORT_HARDWARE_PRESENT* = 0x03030276
  OID_FDDI_SMT_STATION_ACTION* = 0x03030277
  OID_FDDI_PORT_ACTION* = 0x03030278
  OID_FDDI_IF_DESCR* = 0x03030279
  OID_FDDI_IF_TYPE* = 0x0303027a
  OID_FDDI_IF_MTU* = 0x0303027b
  OID_FDDI_IF_SPEED* = 0x0303027c
  OID_FDDI_IF_PHYS_ADDRESS* = 0x0303027d
  OID_FDDI_IF_ADMIN_STATUS* = 0x0303027e
  OID_FDDI_IF_OPER_STATUS* = 0x0303027f
  OID_FDDI_IF_LAST_CHANGE* = 0x03030280
  OID_FDDI_IF_IN_OCTETS* = 0x03030281
  OID_FDDI_IF_IN_UCAST_PKTS* = 0x03030282
  OID_FDDI_IF_IN_NUCAST_PKTS* = 0x03030283
  OID_FDDI_IF_IN_DISCARDS* = 0x03030284
  OID_FDDI_IF_IN_ERRORS* = 0x03030285
  OID_FDDI_IF_IN_UNKNOWN_PROTOS* = 0x03030286
  OID_FDDI_IF_OUT_OCTETS* = 0x03030287
  OID_FDDI_IF_OUT_UCAST_PKTS* = 0x03030288
  OID_FDDI_IF_OUT_NUCAST_PKTS* = 0x03030289
  OID_FDDI_IF_OUT_DISCARDS* = 0x0303028a
  OID_FDDI_IF_OUT_ERRORS* = 0x0303028b
  OID_FDDI_IF_OUT_QLEN* = 0x0303028c
  OID_FDDI_IF_SPECIFIC* = 0x0303028d
  OID_WAN_PERMANENT_ADDRESS* = 0x04010101
  OID_WAN_CURRENT_ADDRESS* = 0x04010102
  OID_WAN_QUALITY_OF_SERVICE* = 0x04010103
  OID_WAN_PROTOCOL_TYPE* = 0x04010104
  OID_WAN_MEDIUM_SUBTYPE* = 0x04010105
  OID_WAN_HEADER_FORMAT* = 0x04010106
  OID_WAN_GET_INFO* = 0x04010107
  OID_WAN_SET_LINK_INFO* = 0x04010108
  OID_WAN_GET_LINK_INFO* = 0x04010109
  OID_WAN_LINE_COUNT* = 0x0401010a
  OID_WAN_PROTOCOL_CAPS* = 0x0401010b
  OID_WAN_GET_BRIDGE_INFO* = 0x0401020a
  OID_WAN_SET_BRIDGE_INFO* = 0x0401020b
  OID_WAN_GET_COMP_INFO* = 0x0401020c
  OID_WAN_SET_COMP_INFO* = 0x0401020d
  OID_WAN_GET_STATS_INFO* = 0x0401020e
  OID_WAN_CO_GET_INFO* = 0x04010180
  OID_WAN_CO_SET_LINK_INFO* = 0x04010181
  OID_WAN_CO_GET_LINK_INFO* = 0x04010182
  OID_WAN_CO_GET_COMP_INFO* = 0x04010280
  OID_WAN_CO_SET_COMP_INFO* = 0x04010281
  OID_WAN_CO_GET_STATS_INFO* = 0x04010282
  OID_LTALK_CURRENT_NODE_ID* = 0x05010102
  OID_LTALK_IN_BROADCASTS* = 0x05020101
  OID_LTALK_IN_LENGTH_ERRORS* = 0x05020102
  OID_LTALK_OUT_NO_HANDLERS* = 0x05020201
  OID_LTALK_COLLISIONS* = 0x05020202
  OID_LTALK_DEFERS* = 0x05020203
  OID_LTALK_NO_DATA_ERRORS* = 0x05020204
  OID_LTALK_RANDOM_CTS_ERRORS* = 0x05020205
  OID_LTALK_FCS_ERRORS* = 0x05020206
  OID_ARCNET_PERMANENT_ADDRESS* = 0x06010101
  OID_ARCNET_CURRENT_ADDRESS* = 0x06010102
  OID_ARCNET_RECONFIGURATIONS* = 0x06020201
  OID_TAPI_ACCEPT* = 0x07030101
  OID_TAPI_ANSWER* = 0x07030102
  OID_TAPI_CLOSE* = 0x07030103
  OID_TAPI_CLOSE_CALL* = 0x07030104
  OID_TAPI_CONDITIONAL_MEDIA_DETECTION* = 0x07030105
  OID_TAPI_CONFIG_DIALOG* = 0x07030106
  OID_TAPI_DEV_SPECIFIC* = 0x07030107
  OID_TAPI_DIAL* = 0x07030108
  OID_TAPI_DROP* = 0x07030109
  OID_TAPI_GET_ADDRESS_CAPS* = 0x0703010a
  OID_TAPI_GET_ADDRESS_ID* = 0x0703010b
  OID_TAPI_GET_ADDRESS_STATUS* = 0x0703010c
  OID_TAPI_GET_CALL_ADDRESS_ID* = 0x0703010d
  OID_TAPI_GET_CALL_INFO* = 0x0703010e
  OID_TAPI_GET_CALL_STATUS* = 0x0703010f
  OID_TAPI_GET_DEV_CAPS* = 0x07030110
  OID_TAPI_GET_DEV_CONFIG* = 0x07030111
  OID_TAPI_GET_EXTENSION_ID* = 0x07030112
  OID_TAPI_GET_ID* = 0x07030113
  OID_TAPI_GET_LINE_DEV_STATUS* = 0x07030114
  OID_TAPI_MAKE_CALL* = 0x07030115
  OID_TAPI_NEGOTIATE_EXT_VERSION* = 0x07030116
  OID_TAPI_OPEN* = 0x07030117
  OID_TAPI_PROVIDER_INITIALIZE* = 0x07030118
  OID_TAPI_PROVIDER_SHUTDOWN* = 0x07030119
  OID_TAPI_SECURE_CALL* = 0x0703011a
  OID_TAPI_SELECT_EXT_VERSION* = 0x0703011b
  OID_TAPI_SEND_USER_USER_INFO* = 0x0703011c
  OID_TAPI_SET_APP_SPECIFIC* = 0x0703011d
  OID_TAPI_SET_CALL_PARAMS* = 0x0703011e
  OID_TAPI_SET_DEFAULT_MEDIA_DETECTION* = 0x0703011f
  OID_TAPI_SET_DEV_CONFIG* = 0x07030120
  OID_TAPI_SET_MEDIA_MODE* = 0x07030121
  OID_TAPI_SET_STATUS_MESSAGES* = 0x07030122
  OID_TAPI_GATHER_DIGITS* = 0x07030123
  OID_TAPI_MONITOR_DIGITS* = 0x07030124
  OID_ATM_SUPPORTED_VC_RATES* = 0x08010101
  OID_ATM_SUPPORTED_SERVICE_CATEGORY* = 0x08010102
  OID_ATM_SUPPORTED_AAL_TYPES* = 0x08010103
  OID_ATM_HW_CURRENT_ADDRESS* = 0x08010104
  OID_ATM_MAX_ACTIVE_VCS* = 0x08010105
  OID_ATM_MAX_ACTIVE_VCI_BITS* = 0x08010106
  OID_ATM_MAX_ACTIVE_VPI_BITS* = 0x08010107
  OID_ATM_MAX_AAL0_PACKET_SIZE* = 0x08010108
  OID_ATM_MAX_AAL1_PACKET_SIZE* = 0x08010109
  OID_ATM_MAX_AAL34_PACKET_SIZE* = 0x0801010a
  OID_ATM_MAX_AAL5_PACKET_SIZE* = 0x0801010b
  OID_ATM_SIGNALING_VPIVCI* = 0x08010201
  OID_ATM_ASSIGNED_VPI* = 0x08010202
  OID_ATM_ACQUIRE_ACCESS_NET_RESOURCES* = 0x08010203
  OID_ATM_RELEASE_ACCESS_NET_RESOURCES* = 0x08010204
  OID_ATM_ILMI_VPIVCI* = 0x08010205
  OID_ATM_DIGITAL_BROADCAST_VPIVCI* = 0x08010206
  OID_ATM_GET_NEAREST_FLOW* = 0x08010207
  OID_ATM_ALIGNMENT_REQUIRED* = 0x08010208
  OID_ATM_LECS_ADDRESS* = 0x08010209
  OID_ATM_SERVICE_ADDRESS* = 0x0801020a
  OID_ATM_CALL_PROCEEDING* = 0x0801020b
  OID_ATM_CALL_ALERTING* = 0x0801020c
  OID_ATM_PARTY_ALERTING* = 0x0801020d
  OID_ATM_CALL_NOTIFY* = 0x0801020e
  OID_ATM_MY_IP_NM_ADDRESS* = 0x0801020f
  OID_ATM_RCV_CELLS_OK* = 0x08020101
  OID_ATM_XMIT_CELLS_OK* = 0x08020102
  OID_ATM_RCV_CELLS_DROPPED* = 0x08020103
  OID_ATM_RCV_INVALID_VPI_VCI* = 0x08020201
  OID_ATM_CELLS_HEC_ERROR* = 0x08020202
  OID_ATM_RCV_REASSEMBLY_ERROR* = 0x08020203
  OID_802_11_BSSID* = 0x0d010101
  OID_802_11_SSID* = 0x0d010102
  OID_802_11_NETWORK_TYPES_SUPPORTED* = 0x0d010203
  OID_802_11_NETWORK_TYPE_IN_USE* = 0x0d010204
  OID_802_11_TX_POWER_LEVEL* = 0x0d010205
  OID_802_11_RSSI* = 0x0d010206
  OID_802_11_RSSI_TRIGGER* = 0x0d010207
  OID_802_11_INFRASTRUCTURE_MODE* = 0x0d010108
  OID_802_11_FRAGMENTATION_THRESHOLD* = 0x0d010209
  OID_802_11_RTS_THRESHOLD* = 0x0d01020a
  OID_802_11_NUMBER_OF_ANTENNAS* = 0x0d01020b
  OID_802_11_RX_ANTENNA_SELECTED* = 0x0d01020c
  OID_802_11_TX_ANTENNA_SELECTED* = 0x0d01020d
  OID_802_11_SUPPORTED_RATES* = 0x0d01020e
  OID_802_11_DESIRED_RATES* = 0x0d010210
  OID_802_11_CONFIGURATION* = 0x0d010211
  OID_802_11_STATISTICS* = 0x0d020212
  OID_802_11_ADD_WEP* = 0x0d010113
  OID_802_11_REMOVE_WEP* = 0x0d010114
  OID_802_11_DISASSOCIATE* = 0x0d010115
  OID_802_11_POWER_MODE* = 0x0d010216
  OID_802_11_BSSID_LIST* = 0x0d010217
  OID_802_11_AUTHENTICATION_MODE* = 0x0d010118
  OID_802_11_PRIVACY_FILTER* = 0x0d010119
  OID_802_11_BSSID_LIST_SCAN* = 0x0d01011a
  OID_802_11_WEP_STATUS* = 0x0d01011b
  OID_802_11_ENCRYPTION_STATUS* = OID_802_11_WEP_STATUS
  OID_802_11_RELOAD_DEFAULTS* = 0x0d01011c
  OID_802_11_ADD_KEY* = 0x0d01011d
  OID_802_11_REMOVE_KEY* = 0x0d01011e
  OID_802_11_ASSOCIATION_INFORMATION* = 0x0d01011f
  OID_802_11_TEST* = 0x0d010120
  OID_802_11_MEDIA_STREAM_MODE* = 0x0d010121
  OID_802_11_CAPABILITY* = 0x0d010122
  OID_802_11_PMKID* = 0x0d010123
  OID_802_11_NON_BCAST_SSID_LIST* = 0x0d010124
  OID_802_11_RADIO_STATUS* = 0x0d010125
  NDIS_ETH_TYPE_IPV4* = 0x0800
  NDIS_ETH_TYPE_ARP* = 0x0806
  NDIS_ETH_TYPE_IPV6* = 0x86dd
  NDIS_ETH_TYPE_802_1X* = 0x888e
  NDIS_ETH_TYPE_802_1Q* = 0x8100
  NDIS_ETH_TYPE_SLOW_PROTOCOL* = 0x8809
  NDIS_802_11_AUTH_REQUEST_REAUTH* = 0x01
  NDIS_802_11_AUTH_REQUEST_KEYUPDATE* = 0x02
  NDIS_802_11_AUTH_REQUEST_PAIRWISE_ERROR* = 0x06
  NDIS_802_11_AUTH_REQUEST_GROUP_ERROR* = 0x0e
  NDIS_802_11_AUTH_REQUEST_AUTH_FIELDS* = 0x0f
  NDIS_802_11_PMKID_CANDIDATE_PREAUTH_ENABLED* = 0x01
  NDIS_802_11_AI_REQFI_CAPABILITIES* = 1
  NDIS_802_11_AI_REQFI_LISTENINTERVAL* = 2
  NDIS_802_11_AI_REQFI_CURRENTAPADDRESS* = 4
  NDIS_802_11_AI_RESFI_CAPABILITIES* = 1
  NDIS_802_11_AI_RESFI_STATUSCODE* = 2
  NDIS_802_11_AI_RESFI_ASSOCIATIONID* = 4
  Ndis802_11StatusType_Authentication* = 0
  Ndis802_11StatusType_MediaStreamMode* = 1
  Ndis802_11StatusType_PMKID_CandidateList* = 2
  Ndis802_11StatusTypeMax* = 3
  Ndis802_11FH* = 0
  Ndis802_11DS* = 1
  Ndis802_11OFDM5* = 2
  Ndis802_11OFDM24* = 3
  Ndis802_11Automode* = 4
  Ndis802_11NetworkTypeMax* = 5
  Ndis802_11PowerModeCAM* = 0
  Ndis802_11PowerModeMAX_PSP* = 1
  Ndis802_11PowerModeFast_PSP* = 2
  Ndis802_11PowerModeMax* = 3
  Ndis802_11IBSS* = 0
  Ndis802_11Infrastructure* = 1
  Ndis802_11AutoUnknown* = 2
  Ndis802_11InfrastructureMax* = 3
  Ndis802_11AuthModeOpen* = 0
  Ndis802_11AuthModeShared* = 1
  Ndis802_11AuthModeAutoSwitch* = 2
  Ndis802_11AuthModeWPA* = 3
  Ndis802_11AuthModeWPAPSK* = 4
  Ndis802_11AuthModeWPANone* = 5
  Ndis802_11AuthModeWPA2* = 6
  Ndis802_11AuthModeWPA2PSK* = 7
  Ndis802_11AuthModeMax* = 8
  Ndis802_11PrivFilterAcceptAll* = 0
  Ndis802_11PrivFilter8021xWEP* = 1
  Ndis802_11WEPEnabled* = 0
  Ndis802_11Encryption1Enabled* = Ndis802_11WEPEnabled
  Ndis802_11WEPDisabled* = Ndis802_11WEPEnabled+1
  Ndis802_11EncryptionDisabled* = Ndis802_11WEPDisabled
  Ndis802_11WEPKeyAbsent* = Ndis802_11WEPDisabled+1
  Ndis802_11Encryption1KeyAbsent* = Ndis802_11WEPKeyAbsent
  Ndis802_11WEPNotSupported* = Ndis802_11WEPKeyAbsent+1
  Ndis802_11EncryptionNotSupported* = Ndis802_11WEPNotSupported
  Ndis802_11Encryption2Enabled* = Ndis802_11WEPNotSupported+1
  Ndis802_11Encryption2KeyAbsent* = Ndis802_11WEPNotSupported+2
  Ndis802_11Encryption3Enabled* = Ndis802_11WEPNotSupported+3
  Ndis802_11Encryption3KeyAbsent* = Ndis802_11WEPNotSupported+4
  Ndis802_11ReloadWEPKeys* = 0
  Ndis802_11MediaStreamOff* = 0
  Ndis802_11MediaStreamOn* = 1
  Ndis802_11RadioStatusOn* = 0
  Ndis802_11RadioStatusHardwareOff* = 1
  Ndis802_11RadioStatusSoftwareOff* = 2
  Ndis802_11RadioStatusHardwareSoftwareOff* = 3
  Ndis802_11RadioStatusMax* = 4
  OID_IRDA_RECEIVING* = 0x0a010100
  OID_IRDA_TURNAROUND_TIME* = 0x0a010101
  OID_IRDA_SUPPORTED_SPEEDS* = 0x0a010102
  OID_IRDA_LINK_SPEED* = 0x0a010103
  OID_IRDA_MEDIA_BUSY* = 0x0a010104
  OID_IRDA_EXTRA_RCV_BOFS* = 0x0a010200
  OID_IRDA_RATE_SNIFF* = 0x0a010201
  OID_IRDA_UNICAST_LIST* = 0x0a010202
  OID_IRDA_MAX_UNICAST_LIST_SIZE* = 0x0a010203
  OID_IRDA_MAX_RECEIVE_WINDOW_SIZE* = 0x0a010204
  OID_IRDA_MAX_SEND_WINDOW_SIZE* = 0x0a010205
  OID_IRDA_RESERVED1* = 0x0a01020a
  OID_IRDA_RESERVED2* = 0x0a01020f
  OID_1394_LOCAL_NODE_INFO* = 0x0c010101
  OID_1394_VC_INFO* = 0x0c010102
  OID_CO_ADD_PVC* = 0xfe000001'i32
  OID_CO_DELETE_PVC* = 0xfe000002'i32
  OID_CO_GET_CALL_INFORMATION* = 0xfe000003'i32
  OID_CO_ADD_ADDRESS* = 0xfe000004'i32
  OID_CO_DELETE_ADDRESS* = 0xfe000005'i32
  OID_CO_GET_ADDRESSES* = 0xfe000006'i32
  OID_CO_ADDRESS_CHANGE* = 0xfe000007'i32
  OID_CO_SIGNALING_ENABLED* = 0xfe000008'i32
  OID_CO_SIGNALING_DISABLED* = 0xfe000009'i32
  OID_CO_AF_CLOSE* = 0xfe00000a'i32
  OID_CO_TAPI_CM_CAPS* = 0xfe001001'i32
  OID_CO_TAPI_LINE_CAPS* = 0xfe001002'i32
  OID_CO_TAPI_ADDRESS_CAPS* = 0xfe001003'i32
  OID_CO_TAPI_TRANSLATE_TAPI_CALLPARAMS* = 0xfe001004'i32
  OID_CO_TAPI_TRANSLATE_NDIS_CALLPARAMS* = 0xfe001005'i32
  OID_CO_TAPI_TRANSLATE_TAPI_SAP* = 0xfe001006'i32
  OID_CO_TAPI_GET_CALL_DIAGNOSTICS* = 0xfe001007'i32
  OID_CO_TAPI_REPORT_DIGITS* = 0xfe001008'i32
  OID_CO_TAPI_DONT_REPORT_DIGITS* = 0xfe001009'i32
  OID_PNP_CAPABILITIES* = 0xfd010100'i32
  OID_PNP_SET_POWER* = 0xfd010101'i32
  OID_PNP_QUERY_POWER* = 0xfd010102'i32
  OID_PNP_ADD_WAKE_UP_PATTERN* = 0xfd010103'i32
  OID_PNP_REMOVE_WAKE_UP_PATTERN* = 0xfd010104'i32
  OID_PNP_WAKE_UP_PATTERN_LIST* = 0xfd010105'i32
  OID_PNP_ENABLE_WAKE_UP* = 0xfd010106'i32
  OID_PNP_WAKE_UP_OK* = 0xfd020200'i32
  OID_PNP_WAKE_UP_ERROR* = 0xfd020201'i32
  OID_PM_CURRENT_CAPABILITIES* = 0xfd010107'i32
  OID_PM_HARDWARE_CAPABILITIES* = 0xfd010108'i32
  OID_PM_PARAMETERS* = 0xfd010109'i32
  OID_PM_ADD_WOL_PATTERN* = 0xfd01010a'i32
  OID_PM_REMOVE_WOL_PATTERN* = 0xfd01010b'i32
  OID_PM_WOL_PATTERN_LIST* = 0xfd01010c'i32
  OID_PM_ADD_PROTOCOL_OFFLOAD* = 0xfd01010d'i32
  OID_PM_GET_PROTOCOL_OFFLOAD* = 0xfd01010e'i32
  OID_PM_REMOVE_PROTOCOL_OFFLOAD* = 0xfd01010f'i32
  OID_PM_PROTOCOL_OFFLOAD_LIST* = 0xfd010110'i32
  OID_PM_RESERVED_1* = 0xfd010111'i32
  OID_RECEIVE_FILTER_HARDWARE_CAPABILITIES* = 0x00010221
  OID_RECEIVE_FILTER_GLOBAL_PARAMETERS* = 0x00010222
  OID_RECEIVE_FILTER_ALLOCATE_QUEUE* = 0x00010223
  OID_RECEIVE_FILTER_FREE_QUEUE* = 0x00010224
  OID_RECEIVE_FILTER_ENUM_QUEUES* = 0x00010225
  OID_RECEIVE_FILTER_QUEUE_PARAMETERS* = 0x00010226
  OID_RECEIVE_FILTER_SET_FILTER* = 0x00010227
  OID_RECEIVE_FILTER_CLEAR_FILTER* = 0x00010228
  OID_RECEIVE_FILTER_ENUM_FILTERS* = 0x00010229
  OID_RECEIVE_FILTER_PARAMETERS* = 0x0001022a
  OID_RECEIVE_FILTER_QUEUE_ALLOCATION_COMPLETE* = 0x0001022b
  OID_RECEIVE_FILTER_CURRENT_CAPABILITIES* = 0x0001022d
  OID_NIC_SWITCH_HARDWARE_CAPABILITIES* = 0x0001022e
  OID_NIC_SWITCH_CURRENT_CAPABILITIES* = 0x0001022f
  OID_RECEIVE_FILTER_MOVE_FILTER* = 0x00010230
  OID_VLAN_RESERVED1* = 0x00010231
  OID_VLAN_RESERVED2* = 0x00010232
  OID_VLAN_RESERVED3* = 0x00010233
  OID_VLAN_RESERVED4* = 0x00010234
  OID_PACKET_COALESCING_FILTER_MATCH_COUNT* = 0x00010235
  OID_NIC_SWITCH_CREATE_SWITCH* = 0x00010237
  OID_NIC_SWITCH_PARAMETERS* = 0x00010238
  OID_NIC_SWITCH_DELETE_SWITCH* = 0x00010239
  OID_NIC_SWITCH_ENUM_SWITCHES* = 0x00010240
  OID_NIC_SWITCH_CREATE_VPORT* = 0x00010241
  OID_NIC_SWITCH_VPORT_PARAMETERS* = 0x00010242
  OID_NIC_SWITCH_ENUM_VPORTS* = 0x00010243
  OID_NIC_SWITCH_DELETE_VPORT* = 0x00010244
  OID_NIC_SWITCH_ALLOCATE_VF* = 0x00010245
  OID_NIC_SWITCH_FREE_VF* = 0x00010246
  OID_NIC_SWITCH_VF_PARAMETERS* = 0x00010247
  OID_NIC_SWITCH_ENUM_VFS* = 0x00010248
  OID_SRIOV_HARDWARE_CAPABILITIES* = 0x00010249
  OID_SRIOV_CURRENT_CAPABILITIES* = 0x00010250
  OID_SRIOV_READ_VF_CONFIG_SPACE* = 0x00010251
  OID_SRIOV_WRITE_VF_CONFIG_SPACE* = 0x00010252
  OID_SRIOV_READ_VF_CONFIG_BLOCK* = 0x00010253
  OID_SRIOV_WRITE_VF_CONFIG_BLOCK* = 0x00010254
  OID_SRIOV_RESET_VF* = 0x00010255
  OID_SRIOV_SET_VF_POWER_STATE* = 0x00010256
  OID_SRIOV_VF_VENDOR_DEVICE_ID* = 0x00010257
  OID_SRIOV_PROBED_BARS* = 0x00010258
  OID_SRIOV_BAR_RESOURCES* = 0x00010259
  OID_SRIOV_PF_LUID* = 0x00010260
  OID_SRIOV_CONFIG_STATE* = 0x00010261
  OID_SRIOV_VF_SERIAL_NUMBER* = 0x00010262
  OID_SRIOV_VF_INVALIDATE_CONFIG_BLOCK* = 0x00010269
  OID_SWITCH_PROPERTY_ADD* = 0x00010263
  OID_SWITCH_PROPERTY_UPDATE* = 0x00010264
  OID_SWITCH_PROPERTY_DELETE* = 0x00010265
  OID_SWITCH_PROPERTY_ENUM* = 0x00010266
  OID_SWITCH_FEATURE_STATUS_QUERY* = 0x00010267
  OID_SWITCH_NIC_REQUEST* = 0x00010270
  OID_SWITCH_PORT_PROPERTY_ADD* = 0x00010271
  OID_SWITCH_PORT_PROPERTY_UPDATE* = 0x00010272
  OID_SWITCH_PORT_PROPERTY_DELETE* = 0x00010273
  OID_SWITCH_PORT_PROPERTY_ENUM* = 0x00010274
  OID_SWITCH_PARAMETERS* = 0x00010275
  OID_SWITCH_PORT_ARRAY* = 0x00010276
  OID_SWITCH_NIC_ARRAY* = 0x00010277
  OID_SWITCH_PORT_CREATE* = 0x00010278
  OID_SWITCH_PORT_DELETE* = 0x00010279
  OID_SWITCH_NIC_CREATE* = 0x0001027a
  OID_SWITCH_NIC_CONNECT* = 0x0001027b
  OID_SWITCH_NIC_DISCONNECT* = 0x0001027c
  OID_SWITCH_NIC_DELETE* = 0x0001027d
  OID_SWITCH_PORT_FEATURE_STATUS_QUERY* = 0x0001027e
  OID_SWITCH_PORT_TEARDOWN* = 0x0001027f
  OID_SWITCH_NIC_SAVE* = 0x00010290
  OID_SWITCH_NIC_SAVE_COMPLETE* = 0x00010291
  OID_SWITCH_NIC_RESTORE* = 0x00010292
  OID_SWITCH_NIC_RESTORE_COMPLETE* = 0x00010293
  OID_SWITCH_NIC_UPDATED* = 0x00010294
  OID_SWITCH_PORT_UPDATED* = 0x00010295
  NDIS_PNP_WAKE_UP_MAGIC_PACKET* = 0x00000001
  NDIS_PNP_WAKE_UP_PATTERN_MATCH* = 0x00000002
  NDIS_PNP_WAKE_UP_LINK_CHANGE* = 0x00000004
  OID_TCP_TASK_OFFLOAD* = 0xfc010201'i32
  OID_TCP_TASK_IPSEC_ADD_SA* = 0xfc010202'i32
  OID_TCP_TASK_IPSEC_DELETE_SA* = 0xfc010203'i32
  OID_TCP_SAN_SUPPORT* = 0xfc010204'i32
  OID_TCP_TASK_IPSEC_ADD_UDPESP_SA* = 0xfc010205'i32
  OID_TCP_TASK_IPSEC_DELETE_UDPESP_SA* = 0xfc010206'i32
  OID_TCP4_OFFLOAD_STATS* = 0xfc010207'i32
  OID_TCP6_OFFLOAD_STATS* = 0xfc010208'i32
  OID_IP4_OFFLOAD_STATS* = 0xfc010209'i32
  OID_IP6_OFFLOAD_STATS* = 0xfc01020a'i32
  OID_TCP_OFFLOAD_CURRENT_CONFIG* = 0xfc01020b'i32
  OID_TCP_OFFLOAD_PARAMETERS* = 0xfc01020c'i32
  OID_TCP_OFFLOAD_HARDWARE_CAPABILITIES* = 0xfc01020d'i32
  OID_TCP_CONNECTION_OFFLOAD_CURRENT_CONFIG* = 0xfc01020e'i32
  OID_TCP_CONNECTION_OFFLOAD_HARDWARE_CAPABILITIES* = 0xfc01020f'i32
  OID_OFFLOAD_ENCAPSULATION* = 0x0101010a
  OID_TCP_TASK_IPSEC_OFFLOAD_V2_ADD_SA* = 0xfc030202'i32
  OID_TCP_TASK_IPSEC_OFFLOAD_V2_DELETE_SA* = 0xfc030203'i32
  OID_TCP_TASK_IPSEC_OFFLOAD_V2_UPDATE_SA* = 0xfc030204'i32
  OID_TCP_TASK_IPSEC_OFFLOAD_V2_ADD_SA_EX* = 0xfc030205'i32
  OID_FFP_SUPPORT* = 0xfc010210'i32
  OID_FFP_FLUSH* = 0xfc010211'i32
  OID_FFP_CONTROL* = 0xfc010212'i32
  OID_FFP_PARAMS* = 0xfc010213'i32
  OID_FFP_DATA* = 0xfc010214'i32
  OID_FFP_DRIVER_STATS* = 0xfc020210'i32
  OID_FFP_ADAPTER_STATS* = 0xfc020211'i32
  OID_TCP_CONNECTION_OFFLOAD_PARAMETERS* = 0xfc030201'i32
  OID_TUNNEL_INTERFACE_SET_OID* = 0x0f010106
  OID_TUNNEL_INTERFACE_RELEASE_OID* = 0x0f010107
  OID_QOS_RESERVED1* = 0xfb010100'i32
  OID_QOS_RESERVED2* = 0xfb010101'i32
  OID_QOS_RESERVED3* = 0xfb010102'i32
  OID_QOS_RESERVED4* = 0xfb010103'i32
  OID_QOS_RESERVED5* = 0xfb010104'i32
  OID_QOS_RESERVED6* = 0xfb010105'i32
  OID_QOS_RESERVED7* = 0xfb010106'i32
  OID_QOS_RESERVED8* = 0xfb010107'i32
  OID_QOS_RESERVED9* = 0xfb010108'i32
  OID_QOS_RESERVED10* = 0xfb010109'i32
  OID_QOS_RESERVED11* = 0xfb01010a'i32
  OID_QOS_RESERVED12* = 0xfb01010b'i32
  OID_QOS_RESERVED13* = 0xfb01010c'i32
  OID_QOS_RESERVED14* = 0xfb01010d'i32
  OID_QOS_RESERVED15* = 0xfb01010e'i32
  OID_QOS_RESERVED16* = 0xfb01010f'i32
  OID_QOS_RESERVED17* = 0xfb010110'i32
  OID_QOS_RESERVED18* = 0xfb010111'i32
  OID_QOS_RESERVED19* = 0xfb010112'i32
  OID_QOS_RESERVED20* = 0xfb010113'i32
  OFFLOAD_INBOUND_SA* = 0x0001
  OFFLOAD_OUTBOUND_SA* = 0x0002
  ENCRYPT* = 2
  OFFLOAD_IPSEC_CONF_NONE* = 0
  OFFLOAD_IPSEC_CONF_DES* = 1
  OFFLOAD_IPSEC_CONF_RESERVED* = 2
  OFFLOAD_IPSEC_CONF_3_DES* = 3
  OFFLOAD_IPSEC_CONF_MAX* = 4
  OFFLOAD_IPSEC_INTEGRITY_NONE* = 0
  OFFLOAD_IPSEC_INTEGRITY_MD5* = 1
  OFFLOAD_IPSEC_INTEGRITY_SHA* = 2
  OFFLOAD_IPSEC_INTEGRITY_MAX* = 3
  OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_IKE* = 0
  OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_OTHER* = 1
  NdisMedium802_3* = 0
  NdisMedium802_5* = 1
  ndisMediumFddi* = 2
  ndisMediumWan* = 3
  ndisMediumLocalTalk* = 4
  ndisMediumDix* = 5
  ndisMediumArcnetRaw* = 6
  NdisMediumArcnet878_2* = 7
  ndisMediumAtm* = 8
  ndisMediumWirelessWan* = 9
  ndisMediumIrda* = 10
  ndisMediumBpc* = 11
  ndisMediumCoWan* = 12
  ndisMedium1394* = 13
  ndisMediumInfiniBand* = 14
  ndisMediumTunnel* = 15
  NdisMediumNative802_11* = 16
  ndisMediumLoopback* = 17
  ndisMediumWiMAX* = 18
  ndisMediumIP* = 19
  ndisMediumMax* = 20
  ndisPhysicalMediumUnspecified* = 0
  ndisPhysicalMediumWirelessLan* = 1
  ndisPhysicalMediumCableModem* = 2
  ndisPhysicalMediumPhoneLine* = 3
  ndisPhysicalMediumPowerLine* = 4
  ndisPhysicalMediumDSL* = 5
  ndisPhysicalMediumFibreChannel* = 6
  ndisPhysicalMedium1394* = 7
  ndisPhysicalMediumWirelessWan* = 8
  NdisPhysicalMediumNative802_11* = 9
  ndisPhysicalMediumBluetooth* = 10
  ndisPhysicalMediumInfiniband* = 11
  ndisPhysicalMediumWiMax* = 12
  ndisPhysicalMediumUWB* = 13
  NdisPhysicalMedium802_3* = 14
  NdisPhysicalMedium802_5* = 15
  ndisPhysicalMediumIrda* = 16
  ndisPhysicalMediumWiredWAN* = 17
  ndisPhysicalMediumWiredCoWan* = 18
  ndisPhysicalMediumOther* = 19
  ndisPhysicalMediumMax* = 20
  NDIS_PROTOCOL_ID_DEFAULT* = 0x00
  NDIS_PROTOCOL_ID_TCP_IP* = 0x02
  NDIS_PROTOCOL_ID_IPX* = 0x06
  NDIS_PROTOCOL_ID_NBF* = 0x07
  NDIS_PROTOCOL_ID_MAX* = 0x0f
  NDIS_PROTOCOL_ID_MASK* = 0x0f
  READABLE_LOCAL_CLOCK* = 0x00000001
  CLOCK_NETWORK_DERIVED* = 0x00000002
  CLOCK_PRECISION* = 0x00000004
  RECEIVE_TIME_INDICATION_CAPABLE* = 0x00000008
  TIMED_SEND_CAPABLE* = 0x00000010
  TIME_STAMP_CAPABLE* = 0x00000020
  NDIS_DEVICE_WAKE_UP_ENABLE* = 0x00000001
  NDIS_DEVICE_WAKE_ON_PATTERN_MATCH_ENABLE* = 0x00000002
  NDIS_DEVICE_WAKE_ON_MAGIC_PACKET_ENABLE* = 0x00000004
  WAN_PROTOCOL_KEEPS_STATS* = 0x00000001
  ndisHardwareStatusReady* = 0
  ndisHardwareStatusInitializing* = 1
  ndisHardwareStatusReset* = 2
  ndisHardwareStatusClosing* = 3
  ndisHardwareStatusNotReady* = 4
  ndisDeviceStateUnspecified* = 0
  ndisDeviceStateD0* = 1
  ndisDeviceStateD1* = 2
  ndisDeviceStateD2* = 3
  ndisDeviceStateD3* = 4
  ndisDeviceStateMaximum* = 5
  ndisFddiTypeIsolated* = 1
  ndisFddiTypeLocalA* = 2
  ndisFddiTypeLocalB* = 3
  ndisFddiTypeLocalAB* = 4
  ndisFddiTypeLocalS* = 5
  ndisFddiTypeWrapA* = 6
  ndisFddiTypeWrapB* = 7
  ndisFddiTypeWrapAB* = 8
  ndisFddiTypeWrapS* = 9
  ndisFddiTypeCWrapA* = 10
  ndisFddiTypeCWrapB* = 11
  ndisFddiTypeCWrapS* = 12
  ndisFddiTypeThrough* = 13
  ndisFddiRingIsolated* = 1
  ndisFddiRingNonOperational* = 2
  ndisFddiRingOperational* = 3
  ndisFddiRingDetect* = 4
  ndisFddiRingNonOperationalDup* = 5
  ndisFddiRingOperationalDup* = 6
  ndisFddiRingDirected* = 7
  ndisFddiRingTrace* = 8
  ndisFddiStateOff* = 1
  ndisFddiStateBreak* = 2
  ndisFddiStateTrace* = 3
  ndisFddiStateConnect* = 4
  ndisFddiStateNext* = 5
  ndisFddiStateSignal* = 6
  ndisFddiStateJoin* = 7
  ndisFddiStateVerify* = 8
  ndisFddiStateActive* = 9
  ndisFddiStateMaintenance* = 10
  ndisWanMediumHub* = 0
  NdisWanMediumX_25* = 1
  ndisWanMediumIsdn* = 2
  ndisWanMediumSerial* = 3
  ndisWanMediumFrameRelay* = 4
  ndisWanMediumAtm* = 5
  ndisWanMediumSonet* = 6
  ndisWanMediumSW56K* = 7
  ndisWanMediumPPTP* = 8
  ndisWanMediumL2TP* = 9
  ndisWanMediumIrda* = 10
  ndisWanMediumParallel* = 11
  ndisWanMediumPppoe* = 12
  ndisWanMediumSSTP* = 13
  ndisWanMediumAgileVPN* = 14
  ndisWanHeaderNative* = 0
  ndisWanHeaderEthernet* = 1
  ndisWanRaw* = 0
  ndisWanErrorControl* = 1
  ndisWanReliable* = 2
  ndisRingStateOpened* = 1
  ndisRingStateClosed* = 2
  ndisRingStateOpening* = 3
  ndisRingStateClosing* = 4
  ndisRingStateOpenFailure* = 5
  ndisRingStateRingFailure* = 6
  ndisMediaStateConnected* = 0
  ndisMediaStateDisconnected* = 1
  fNDIS_GUID_TO_OID* = 0x00000001
  fNDIS_GUID_TO_STATUS* = 0x00000002
  fNDIS_GUID_ANSI_STRING* = 0x00000004
  fNDIS_GUID_UNICODE_STRING* = 0x00000008
  fNDIS_GUID_ARRAY* = 0x00000010
  fNDIS_GUID_ALLOW_READ* = 0x00000020
  fNDIS_GUID_ALLOW_WRITE* = 0x00000040
  fNDIS_GUID_METHOD* = 0x00000080
  fNDIS_GUID_NDIS_RESERVED* = 0x00000100
  fNDIS_GUID_SUPPORT_COMMON_HEADER* = 0x00000200
  NDIS_PACKET_TYPE_DIRECTED* = 0x00000001
  NDIS_PACKET_TYPE_MULTICAST* = 0x00000002
  NDIS_PACKET_TYPE_ALL_MULTICAST* = 0x00000004
  NDIS_PACKET_TYPE_BROADCAST* = 0x00000008
  NDIS_PACKET_TYPE_SOURCE_ROUTING* = 0x00000010
  NDIS_PACKET_TYPE_PROMISCUOUS* = 0x00000020
  NDIS_PACKET_TYPE_SMT* = 0x00000040
  NDIS_PACKET_TYPE_ALL_LOCAL* = 0x00000080
  NDIS_PACKET_TYPE_GROUP* = 0x00001000
  NDIS_PACKET_TYPE_ALL_FUNCTIONAL* = 0x00002000
  NDIS_PACKET_TYPE_FUNCTIONAL* = 0x00004000
  NDIS_PACKET_TYPE_MAC_FRAME* = 0x00008000
  NDIS_PACKET_TYPE_NO_LOCAL* = 0x00010000
  NDIS_RING_SIGNAL_LOSS* = 0x00008000
  NDIS_RING_HARD_ERROR* = 0x00004000
  NDIS_RING_SOFT_ERROR* = 0x00002000
  NDIS_RING_TRANSMIT_BEACON* = 0x00001000
  NDIS_RING_LOBE_WIRE_FAULT* = 0x00000800
  NDIS_RING_AUTO_REMOVAL_ERROR* = 0x00000400
  NDIS_RING_REMOVE_RECEIVED* = 0x00000200
  NDIS_RING_COUNTER_OVERFLOW* = 0x00000100
  NDIS_RING_SINGLE_STATION* = 0x00000080
  NDIS_RING_RING_RECOVERY* = 0x00000040
  NDIS_PROT_OPTION_ESTIMATED_LENGTH* = 0x00000001
  NDIS_PROT_OPTION_NO_LOOPBACK* = 0x00000002
  NDIS_PROT_OPTION_NO_RSVD_ON_RCVPKT* = 0x00000004
  NDIS_PROT_OPTION_SEND_RESTRICTED* = 0x00000008
  NDIS_MAC_OPTION_COPY_LOOKAHEAD_DATA* = 0x00000001
  NDIS_MAC_OPTION_RECEIVE_SERIALIZED* = 0x00000002
  NDIS_MAC_OPTION_TRANSFERS_NOT_PEND* = 0x00000004
  NDIS_MAC_OPTION_NO_LOOPBACK* = 0x00000008
  NDIS_MAC_OPTION_FULL_DUPLEX* = 0x00000010
  NDIS_MAC_OPTION_EOTX_INDICATION* = 0x00000020
  NDIS_MAC_OPTION_8021P_PRIORITY* = 0x00000040
  NDIS_MAC_OPTION_SUPPORTS_MAC_ADDRESS_OVERWRITE* = 0x00000080
  NDIS_MAC_OPTION_RECEIVE_AT_DPC* = 0x00000100
  NDIS_MAC_OPTION_8021Q_VLAN* = 0x00000200
  NDIS_MAC_OPTION_RESERVED* = 0x80000000'i32
  NDIS_MEDIA_CAP_TRANSMIT* = 0x00000001
  NDIS_MEDIA_CAP_RECEIVE* = 0x00000002
  NDIS_CO_MAC_OPTION_DYNAMIC_LINK_SPEED* = 0x00000001
  NDIS_LINK_STATE_XMIT_LINK_SPEED_AUTO_NEGOTIATED* = 0x00000001
  NDIS_LINK_STATE_RCV_LINK_SPEED_AUTO_NEGOTIATED* = 0x00000002
  NDIS_LINK_STATE_DUPLEX_AUTO_NEGOTIATED* = 0x00000004
  NDIS_LINK_STATE_PAUSE_FUNCTIONS_AUTO_NEGOTIATED* = 0x00000008
  NDIS_LINK_STATE_REVISION_1* = 1
  NDIS_LINK_PARAMETERS_REVISION_1* = 1
  NDIS_OPER_STATE_REVISION_1* = 1
  NDIS_IP_OPER_STATUS_INFO_REVISION_1* = 1
  NDIS_IP_OPER_STATE_REVISION_1* = 1
  ndisPauseFunctionsUnsupported* = 0
  ndisPauseFunctionsSendOnly* = 1
  ndisPauseFunctionsReceiveOnly* = 2
  ndisPauseFunctionsSendAndReceive* = 3
  ndisPauseFunctionsUnknown* = 4
  NDIS_OFFLOAD_PARAMETERS_NO_CHANGE* = 0
  NDIS_OFFLOAD_PARAMETERS_TX_RX_DISABLED* = 1
  NDIS_OFFLOAD_PARAMETERS_TX_ENABLED_RX_DISABLED* = 2
  NDIS_OFFLOAD_PARAMETERS_RX_ENABLED_TX_DISABLED* = 3
  NDIS_OFFLOAD_PARAMETERS_TX_RX_ENABLED* = 4
  NDIS_OFFLOAD_PARAMETERS_LSOV1_DISABLED* = 1
  NDIS_OFFLOAD_PARAMETERS_LSOV1_ENABLED* = 2
  NDIS_OFFLOAD_PARAMETERS_IPSECV1_DISABLED* = 1
  NDIS_OFFLOAD_PARAMETERS_IPSECV1_AH_ENABLED* = 2
  NDIS_OFFLOAD_PARAMETERS_IPSECV1_ESP_ENABLED* = 3
  NDIS_OFFLOAD_PARAMETERS_IPSECV1_AH_AND_ESP_ENABLED* = 4
  NDIS_OFFLOAD_PARAMETERS_LSOV2_DISABLED* = 1
  NDIS_OFFLOAD_PARAMETERS_LSOV2_ENABLED* = 2
  NDIS_OFFLOAD_PARAMETERS_IPSECV2_DISABLED* = 1
  NDIS_OFFLOAD_PARAMETERS_IPSECV2_AH_ENABLED* = 2
  NDIS_OFFLOAD_PARAMETERS_IPSECV2_ESP_ENABLED* = 3
  NDIS_OFFLOAD_PARAMETERS_IPSECV2_AH_AND_ESP_ENABLED* = 4
  NDIS_OFFLOAD_PARAMETERS_RSC_DISABLED* = 1
  NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED* = 2
  NDIS_ENCAPSULATION_TYPE_GRE_MAC* = 0x00000001
  NDIS_ENCAPSULATION_TYPE_MAX* = NDIS_ENCAPSULATION_TYPE_GRE_MAC
  NDIS_OFFLOAD_PARAMETERS_CONNECTION_OFFLOAD_DISABLED* = 1
  NDIS_OFFLOAD_PARAMETERS_CONNECTION_OFFLOAD_ENABLED* = 2
  NDIS_OFFLOAD_PARAMETERS_REVISION_1* = 1
  NDIS_OFFLOAD_PARAMETERS_REVISION_2* = 2
  NDIS_OFFLOAD_PARAMETERS_REVISION_3* = 3
  NDIS_OFFLOAD_PARAMETERS_SKIP_REGISTRY_UPDATE* = 0x00000001
proc Flags*(self: IP_ADAPTER_UNICAST_ADDRESS_XP): DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: var IP_ADAPTER_UNICAST_ADDRESS_XP): var DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: IP_ADAPTER_UNICAST_ADDRESS_LH): DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: var IP_ADAPTER_UNICAST_ADDRESS_LH): var DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: IP_ADAPTER_ANYCAST_ADDRESS_XP): DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: var IP_ADAPTER_ANYCAST_ADDRESS_XP): var DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: IP_ADAPTER_MULTICAST_ADDRESS_XP): DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: var IP_ADAPTER_MULTICAST_ADDRESS_XP): var DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: IP_ADAPTER_PREFIX_XP): DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: var IP_ADAPTER_PREFIX_XP): var DWORD {.inline.} = self.union1.struct1.Flags
proc Flags*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.Flags
proc Flags*(self: var IP_ADAPTER_ADDRESSES_LH): var ULONG {.inline.} = self.union2.Flags
proc Flags*(self: MIB_IPNET_ROW2): UCHAR {.inline.} = self.union1.Flags
proc Flags*(self: var MIB_IPNET_ROW2): var UCHAR {.inline.} = self.union1.Flags
proc EncapsulationTypes*(self: NDIS_OFFLOAD_PARAMETERS): UCHAR {.inline.} = self.struct2.EncapsulationTypes
proc EncapsulationTypes*(self: var NDIS_OFFLOAD_PARAMETERS): var UCHAR {.inline.} = self.struct2.EncapsulationTypes
const
  NDIS_OFFLOAD_NOT_SUPPORTED* = 0
  NDIS_OFFLOAD_SUPPORTED* = 1
  NDIS_OFFLOAD_SET_NO_CHANGE* = 0
  NDIS_OFFLOAD_SET_ON* = 1
  NDIS_OFFLOAD_SET_OFF* = 2
  NDIS_ENCAPSULATION_NOT_SUPPORTED* = 0x00000000
  NDIS_ENCAPSULATION_NULL* = 0x00000001
  NDIS_ENCAPSULATION_IEEE_802_3* = 0x00000002
  NDIS_ENCAPSULATION_IEEE_802_3_P_AND_Q* = 0x00000004
  NDIS_ENCAPSULATION_IEEE_802_3_P_AND_Q_IN_OOB* = 0x00000008
  NDIS_ENCAPSULATION_IEEE_LLC_SNAP_ROUTED* = 0x00000010
  IPSEC_OFFLOAD_V2_AUTHENTICATION_MD5* = 0x00000001
  IPSEC_OFFLOAD_V2_AUTHENTICATION_SHA_1* = 0x00000002
  IPSEC_OFFLOAD_V2_AUTHENTICATION_SHA_256* = 0x00000004
  IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_128* = 0x00000008
  IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_192* = 0x00000010
  IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_256* = 0x00000020
  IPSEC_OFFLOAD_V2_ENCRYPTION_NONE* = 0x00000001
  IPSEC_OFFLOAD_V2_ENCRYPTION_DES_CBC* = 0x00000002
  IPSEC_OFFLOAD_V2_ENCRYPTION_3_DES_CBC* = 0x00000004
  IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_128* = 0x00000008
  IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_192* = 0x00000010
  IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_256* = 0x00000020
  IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_128* = 0x00000040
  IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_192* = 0x00000080
  IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_256* = 0x00000100
  NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_NOT_SUPPORTED* = 0x00000000
  NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_INNER_IPV4* = 0x00000001
  NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_OUTER_IPV4* = 0x00000002
  NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_INNER_IPV6* = 0x00000004
  NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_OUTER_IPV6* = 0x00000008
  NDIS_OFFLOAD_FLAGS_GROUP_CHECKSUM_CAPABILITIES* = 0x1
  IPSEC_OFFLOAD_V2_AND_TCP_CHECKSUM_COEXISTENCE* = 0x2
  IPSEC_OFFLOAD_V2_AND_UDP_CHECKSUM_COEXISTENCE* = 0x4
  NDIS_MAXIMUM_PORTS* = 0x1000000
  NDIS_DEFAULT_PORT_NUMBER* = NDIS_PORT_NUMBER 0
  NDIS_WMI_DEFAULT_METHOD_ID* = 1
  NDIS_WMI_OBJECT_TYPE_SET* = 0x01
  NDIS_WMI_OBJECT_TYPE_METHOD* = 0x02
  NDIS_WMI_OBJECT_TYPE_EVENT* = 0x03
  NDIS_WMI_OBJECT_TYPE_ENUM_ADAPTER* = 0x04
  NDIS_WMI_OBJECT_TYPE_OUTPUT_INFO* = 0x05
  NDIS_DEVICE_TYPE_ENDPOINT* = 0x00000001
  NDIS_OFFLOAD_REVISION_1* = 1
  NDIS_TCP_CONNECTION_OFFLOAD_REVISION_1* = 1
  NDIS_PORT_AUTHENTICATION_PARAMETERS_REVISION_1* = 1
  NDIS_WMI_METHOD_HEADER_REVISION_1* = 1
  NDIS_WMI_SET_HEADER_REVISION_1* = 1
  NDIS_WMI_EVENT_HEADER_REVISION_1* = 1
  NDIS_WMI_ENUM_ADAPTER_REVISION_1* = 1
  NDIS_TCP_CONNECTION_OFFLOAD_REVISION_2* = 2
  NDIS_OFFLOAD_REVISION_2* = 2
  NDIS_OFFLOAD_REVISION_3* = 3
  NDIS_TCP_RECV_SEG_COALESC_OFFLOAD_REVISION_1* = 1
  ndisPortTypeUndefined* = 0
  ndisPortTypeBridge* = 1
  ndisPortTypeRasConnection* = 2
  ndisPortType8021xSupplicant* = 3
  ndisPortTypeNdisImPlatform* = 4
  ndisPortTypeMax* = 5
  ndisPortAuthorizationUnknown* = 0
  ndisPortAuthorized* = 1
  ndisPortUnauthorized* = 2
  ndisPortReauthorizing* = 3
  ndisPortControlStateUnknown* = 0
  ndisPortControlStateControlled* = 1
  ndisPortControlStateUncontrolled* = 2
  ndisPossibleNetworkChange* = 1
  ndisDefinitelyNetworkChange* = 2
  ndisNetworkChangeFromMediaConnect* = 3
  ndisNetworkChangeMax* = 4
  NDIS_HD_SPLIT_COMBINE_ALL_HEADERS* = 0x00000001
  NDIS_HD_SPLIT_CAPS_SUPPORTS_HEADER_DATA_SPLIT* = 0x00000001
  NDIS_HD_SPLIT_CAPS_SUPPORTS_IPV4_OPTIONS* = 0x00000002
  NDIS_HD_SPLIT_CAPS_SUPPORTS_IPV6_EXTENSION_HEADERS* = 0x00000004
  NDIS_HD_SPLIT_CAPS_SUPPORTS_TCP_OPTIONS* = 0x00000008
  NDIS_HD_SPLIT_ENABLE_HEADER_DATA_SPLIT* = 0x00000001
  NDIS_HD_SPLIT_PARAMETERS_REVISION_1* = 1
  NDIS_HD_SPLIT_CURRENT_CONFIG_REVISION_1* = 1
  NDIS_WMI_OUTPUT_INFO_REVISION_1* = 1
  NDIS_PM_WOL_BITMAP_PATTERN_SUPPORTED* = 0x00000001
  NDIS_PM_WOL_MAGIC_PACKET_SUPPORTED* = 0x00000002
  NDIS_PM_WOL_IPV4_TCP_SYN_SUPPORTED* = 0x00000004
  NDIS_PM_WOL_IPV6_TCP_SYN_SUPPORTED* = 0x00000008
  NDIS_PM_WOL_IPV4_DEST_ADDR_WILDCARD_SUPPORTED* = 0x00000200
  NDIS_PM_WOL_IPV6_DEST_ADDR_WILDCARD_SUPPORTED* = 0x00000800
  NDIS_PM_WOL_EAPOL_REQUEST_ID_MESSAGE_SUPPORTED* = 0x00010000
  NDIS_PM_PROTOCOL_OFFLOAD_ARP_SUPPORTED* = 0x00000001
  NDIS_PM_PROTOCOL_OFFLOAD_NS_SUPPORTED* = 0x00000002
  NDIS_PM_PROTOCOL_OFFLOAD_80211_RSN_REKEY_SUPPORTED* = 0x00000080
  NDIS_PM_WAKE_ON_MEDIA_CONNECT_SUPPORTED* = 0x00000001
  NDIS_PM_WAKE_ON_MEDIA_DISCONNECT_SUPPORTED* = 0x00000002
  NDIS_WLAN_WAKE_ON_NLO_DISCOVERY_SUPPORTED* = 0x00000001
  NDIS_WLAN_WAKE_ON_AP_ASSOCIATION_LOST_SUPPORTED* = 0x00000002
  NDIS_WLAN_WAKE_ON_GTK_HANDSHAKE_ERROR_SUPPORTED* = 0x00000004
  NDIS_WLAN_WAKE_ON_4WAY_HANDSHAKE_REQUEST_SUPPORTED* = 0x00000008
  NDIS_WWAN_WAKE_ON_REGISTER_STATE_SUPPORTED* = 0x00000001
  NDIS_WWAN_WAKE_ON_SMS_RECEIVE_SUPPORTED* = 0x00000002
  NDIS_WWAN_WAKE_ON_USSD_RECEIVE_SUPPORTED* = 0x00000004
  NDIS_PM_WAKE_PACKET_INDICATION_SUPPORTED* = 0x00000001
  NDIS_PM_SELECTIVE_SUSPEND_SUPPORTED* = 0x00000002
  NDIS_PM_WOL_BITMAP_PATTERN_ENABLED* = 0x00000001
  NDIS_PM_WOL_MAGIC_PACKET_ENABLED* = 0x00000002
  NDIS_PM_WOL_IPV4_TCP_SYN_ENABLED* = 0x00000004
  NDIS_PM_WOL_IPV6_TCP_SYN_ENABLED* = 0x00000008
  NDIS_PM_WOL_IPV4_DEST_ADDR_WILDCARD_ENABLED* = 0x00000200
  NDIS_PM_WOL_IPV6_DEST_ADDR_WILDCARD_ENABLED* = 0x00000800
  NDIS_PM_WOL_EAPOL_REQUEST_ID_MESSAGE_ENABLED* = 0x00010000
  NDIS_PM_PROTOCOL_OFFLOAD_ARP_ENABLED* = 0x00000001
  NDIS_PM_PROTOCOL_OFFLOAD_NS_ENABLED* = 0x00000002
  NDIS_PM_PROTOCOL_OFFLOAD_80211_RSN_REKEY_ENABLED* = 0x00000080
  NDIS_PM_WAKE_ON_LINK_CHANGE_ENABLED* = 0x1
  NDIS_PM_WAKE_ON_MEDIA_DISCONNECT_ENABLED* = 0x2
  NDIS_PM_SELECTIVE_SUSPEND_ENABLED* = 0x10
  NDIS_WLAN_WAKE_ON_NLO_DISCOVERY_ENABLED* = 0x1
  NDIS_WLAN_WAKE_ON_AP_ASSOCIATION_LOST_ENABLED* = 0x2
  NDIS_WLAN_WAKE_ON_GTK_HANDSHAKE_ERROR_ENABLED* = 0x4
  NDIS_WLAN_WAKE_ON_4WAY_HANDSHAKE_REQUEST_ENABLED* = 0x8
  NDIS_WWAN_WAKE_ON_REGISTER_STATE_ENABLED* = 0x1
  NDIS_WWAN_WAKE_ON_SMS_RECEIVE_ENABLED* = 0x2
  NDIS_WWAN_WAKE_ON_USSD_RECEIVE_ENABLED* = 0x4
  NDIS_PM_WOL_PRIORITY_LOWEST* = 0xffffffff'i32
  NDIS_PM_WOL_PRIORITY_NORMAL* = 0x10000000
  NDIS_PM_WOL_PRIORITY_HIGHEST* = 0x00000001
  NDIS_PM_PROTOCOL_OFFLOAD_PRIORITY_LOWEST* = 0xffffffff'i32
  NDIS_PM_PROTOCOL_OFFLOAD_PRIORITY_NORMAL* = 0x10000000
  NDIS_PM_PROTOCOL_OFFLOAD_PRIORITY_HIGHEST* = 0x00000001
  EAPOL_REQUEST_ID_WOL_FLAG_MUST_ENCRYPT* = 0x00000001
  NDIS_PM_MAX_PATTERN_ID* = 0x0000ffff
  NDIS_PM_PRIVATE_PATTERN_ID* = 0x00000001
  NDIS_RECEIVE_FILTER_MAC_HEADER_SUPPORTED* = 0x00000001
  NDIS_RECEIVE_FILTER_IPV4_HEADER_SUPPORTED* = 0x00000002
  NDIS_RECEIVE_FILTER_IPV6_HEADER_SUPPORTED* = 0x00000004
  NDIS_RECEIVE_FILTER_ARP_HEADER_SUPPORTED* = 0x00000008
  NDIS_RECEIVE_FILTER_UDP_HEADER_SUPPORTED* = 0x00000010
  NDIS_RECEIVE_FILTER_MAC_HEADER_DEST_ADDR_SUPPORTED* = 0x00000001
  NDIS_RECEIVE_FILTER_MAC_HEADER_SOURCE_ADDR_SUPPORTED* = 0x00000002
  NDIS_RECEIVE_FILTER_MAC_HEADER_PROTOCOL_SUPPORTED* = 0x00000004
  NDIS_RECEIVE_FILTER_MAC_HEADER_VLAN_ID_SUPPORTED* = 0x00000008
  NDIS_RECEIVE_FILTER_MAC_HEADER_PRIORITY_SUPPORTED* = 0x00000010
  NDIS_RECEIVE_FILTER_MAC_HEADER_PACKET_TYPE_SUPPORTED* = 0x00000020
  NDIS_RECEIVE_FILTER_ARP_HEADER_OPERATION_SUPPORTED* = 0x1
  NDIS_RECEIVE_FILTER_ARP_HEADER_SPA_SUPPORTED* = 0x2
  NDIS_RECEIVE_FILTER_ARP_HEADER_TPA_SUPPORTED* = 0x4
  NDIS_RECEIVE_FILTER_IPV4_HEADER_PROTOCOL_SUPPORTED* = 0x1
  NDIS_RECEIVE_FILTER_IPV6_HEADER_PROTOCOL_SUPPORTED* = 0x1
  NDIS_RECEIVE_FILTER_UDP_HEADER_DEST_PORT_SUPPORTED* = 0x1
  NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_EQUAL_SUPPORTED* = 0x00000001
  NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_MASK_EQUAL_SUPPORTED* = 0x00000002
  NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_NOT_EQUAL_SUPPORTED* = 0x00000004
  NDIS_RECEIVE_FILTER_MSI_X_SUPPORTED* = 0x00000001
  NDIS_RECEIVE_FILTER_VM_QUEUE_SUPPORTED* = 0x00000002
  NDIS_RECEIVE_FILTER_LOOKAHEAD_SPLIT_SUPPORTED* = 0x00000004
  NDIS_RECEIVE_FILTER_DYNAMIC_PROCESSOR_AFFINITY_CHANGE_SUPPORTED* = 0x00000008
  NDIS_RECEIVE_FILTER_INTERRUPT_VECTOR_COALESCING_SUPPORTED* = 0x00000010
  NDIS_RECEIVE_FILTER_ANY_VLAN_SUPPORTED* = 0x00000020
  NDIS_RECEIVE_FILTER_IMPLAT_MIN_OF_QUEUES_MODE* = 0x00000040
  NDIS_RECEIVE_FILTER_IMPLAT_SUM_OF_QUEUES_MODE* = 0x00000080
  NDIS_RECEIVE_FILTER_PACKET_COALESCING_SUPPORTED_ON_DEFAULT_QUEUE* = 0x00000100
  NDIS_RECEIVE_FILTER_VMQ_FILTERS_ENABLED* = 0x00000001
  NDIS_RECEIVE_FILTER_PACKET_COALESCING_FILTERS_ENABLED* = 0x00000002
  NDIS_RECEIVE_FILTER_VM_QUEUES_ENABLED* = 0x00000001
  NDIS_NIC_SWITCH_CAPS_VLAN_SUPPORTED* = 0x00000001
  NDIS_NIC_SWITCH_CAPS_PER_VPORT_INTERRUPT_MODERATION_SUPPORTED* = 0x00000002
  NDIS_NIC_SWITCH_CAPS_ASYMMETRIC_QUEUE_PAIRS_FOR_NONDEFAULT_VPORT_SUPPORTED* = 0x00000004
  NDIS_NIC_SWITCH_CAPS_VF_RSS_SUPPORTED* = 0x00000008
  NDIS_NIC_SWITCH_CAPS_SINGLE_VPORT_POOL* = 0x00000010
  NDIS_DEFAULT_RECEIVE_QUEUE_ID* = 0
  NDIS_DEFAULT_RECEIVE_QUEUE_GROUP_ID* = 0
  NDIS_DEFAULT_RECEIVE_FILTER_ID* = 0
  NDIS_RECEIVE_FILTER_FIELD_MAC_HEADER_VLAN_UNTAGGED_OR_ZERO* = 0x00000001
  NDIS_RECEIVE_FILTER_PACKET_ENCAPSULATION_GRE* = 0x00000002
  NDIS_RECEIVE_QUEUE_PARAMETERS_PER_QUEUE_RECEIVE_INDICATION* = 0x00000001
  NDIS_RECEIVE_QUEUE_PARAMETERS_LOOKAHEAD_SPLIT_REQUIRED* = 0x00000002
  NDIS_RECEIVE_QUEUE_PARAMETERS_FLAGS_CHANGED* = 0x00010000
  NDIS_RECEIVE_QUEUE_PARAMETERS_PROCESSOR_AFFINITY_CHANGED* = 0x00020000
  NDIS_RECEIVE_QUEUE_PARAMETERS_SUGGESTED_RECV_BUFFER_NUMBERS_CHANGED* = 0x00040000
  NDIS_RECEIVE_QUEUE_PARAMETERS_NAME_CHANGED* = 0x00080000
  NDIS_RECEIVE_QUEUE_PARAMETERS_INTERRUPT_COALESCING_DOMAIN_ID_CHANGED* = 0x00100000
  NDIS_RECEIVE_QUEUE_PARAMETERS_CHANGE_MASK* = 0xffff0000'i32
  NDIS_RECEIVE_FILTER_INFO_ARRAY_VPORT_ID_SPECIFIED* = 0x00000001
  NDIS_PM_CAPABILITIES_REVISION_1* = 1
  NDIS_PM_PARAMETERS_REVISION_1* = 1
  NDIS_PM_WOL_PATTERN_REVISION_1* = 1
  NDIS_PM_PROTOCOL_OFFLOAD_REVISION_1* = 1
  NDIS_WMI_PM_ADMIN_CONFIG_REVISION_1* = 1
  NDIS_WMI_PM_ACTIVE_CAPABILITIES_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_CAPABILITIES_REVISION_1* = 1
  NDIS_NIC_SWITCH_CAPABILITIES_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_GLOBAL_PARAMETERS_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_PARAMETERS_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_CLEAR_PARAMETERS_REVISION_1* = 1
  NDIS_RECEIVE_QUEUE_PARAMETERS_REVISION_1* = 1
  NDIS_RECEIVE_QUEUE_FREE_PARAMETERS_REVISION_1* = 1
  NDIS_RECEIVE_QUEUE_INFO_REVISION_1* = 1
  NDIS_RECEIVE_QUEUE_INFO_ARRAY_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_INFO_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_INFO_ARRAY_REVISION_1* = 1
  NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_PARAMETERS_REVISION_1* = 1
  NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_ARRAY_REVISION_1* = 1
  NDIS_PM_CAPABILITIES_REVISION_2* = 2
  NDIS_PM_PARAMETERS_REVISION_2* = 2
  NDIS_PM_WOL_PATTERN_REVISION_2* = 2
  NDIS_PM_WAKE_REASON_REVISION_1* = 1
  NDIS_PM_WAKE_PACKET_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_CAPABILITIES_REVISION_2* = 2
  NDIS_NIC_SWITCH_CAPABILITIES_REVISION_2* = 2
  NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_REVISION_2* = 2
  NDIS_RECEIVE_FILTER_PARAMETERS_REVISION_2* = 2
  NDIS_RECEIVE_QUEUE_PARAMETERS_REVISION_2* = 2
  NDIS_RECEIVE_FILTER_INFO_ARRAY_REVISION_2* = 2
  NDIS_RECEIVE_QUEUE_INFO_REVISION_2* = 2
  ndisPMWoLPacketUnspecified* = 0
  ndisPMWoLPacketBitmapPattern* = 1
  ndisPMWoLPacketMagicPacket* = 2
  ndisPMWoLPacketIPv4TcpSyn* = 3
  ndisPMWoLPacketIPv6TcpSyn* = 4
  ndisPMWoLPacketEapolRequestIdMessage* = 5
  ndisPMWoLPacketMaximum* = 6
  ndisPMProtocolOffloadIdUnspecified* = 0
  ndisPMProtocolOffloadIdIPv4ARP* = 1
  ndisPMProtocolOffloadIdIPv6NS* = 2
  ndisPMProtocolOffload80211RSNRekey* = 3
  ndisPMProtocolOffloadIdMaximum* = 4
  ndisWakeReasonUnspecified* = 0x0000
  ndisWakeReasonPacket* = 0x0001
  ndisWakeReasonMediaDisconnect* = 0x0002
  ndisWakeReasonMediaConnect* = 0x0003
  ndisWakeReasonWlanNLODiscovery* = 0x1000
  ndisWakeReasonWlanAPAssociationLost* = 0x1001
  ndisWakeReasonWlanGTKHandshakeError* = 0x1002
  ndisWakeReasonWlan4WayHandshakeRequest* = 0x1003
  ndisWakeReasonWwanRegisterState* = 0x2000
  ndisWakeReasonWwanSMSReceive* = 0x2001
  ndisWakeReasonWwanUSSDReceive* = 0x2002
  ndisPMAdminConfigUnspecified* = 0
  ndisPMAdminConfigDisabled* = 1
  ndisPMAdminConfigEnabled* = 2
  ndisPMAdminConfigUnsupported* = 0
  ndisPMAdminConfigInactive* = 1
  ndisPMAdminConfigActive* = 2
  ndisReceiveFilterTypeUndefined* = 0
  ndisReceiveFilterTypeVMQueue* = 1
  ndisReceiveFilterTypePacketCoalescing* = 2
  ndisReceiveFilterTypeMaximum* = 3
  ndisFrameHeaderUndefined* = 0
  ndisFrameHeaderMac* = 1
  ndisFrameHeaderArp* = 2
  ndisFrameHeaderIPv4* = 3
  ndisFrameHeaderIPv6* = 4
  ndisFrameHeaderUdp* = 5
  ndisFrameHeaderMaximum* = 6
  ndisMacHeaderFieldUndefined* = 0
  ndisMacHeaderFieldDestinationAddress* = 1
  ndisMacHeaderFieldSourceAddress* = 2
  ndisMacHeaderFieldProtocol* = 3
  ndisMacHeaderFieldVlanId* = 4
  ndisMacHeaderFieldPriority* = 5
  ndisMacHeaderFieldPacketType* = 6
  ndisMacHeaderFieldMaximum* = 7
  ndisMacPacketTypeUndefined* = 0
  ndisMacPacketTypeUnicast* = 1
  ndisMacPacketTypeMulticast* = 2
  ndisMacPacketTypeBroadcast* = 3
  ndisMacPacketTypeMaximum* = 4
  ndisARPHeaderFieldUndefined* = 0
  ndisARPHeaderFieldOperation* = 1
  ndisARPHeaderFieldSPA* = 2
  ndisARPHeaderFieldTPA* = 3
  ndisARPHeaderFieldMaximum* = 4
  ndisIPv4HeaderFieldUndefined* = 0
  ndisIPv4HeaderFieldProtocol* = 1
  ndisIPv4HeaderFieldMaximum* = 2
  ndisIPv6HeaderFieldUndefined* = 0
  ndisIPv6HeaderFieldProtocol* = 1
  ndisIPv6HeaderFieldMaximum* = 2
  ndisUdpHeaderFieldUndefined* = 0
  ndisUdpHeaderFieldDestinationPort* = 1
  ndisUdpHeaderFieldMaximum* = 2
  ndisReceiveFilterTestUndefined* = 0
  ndisReceiveFilterTestEqual* = 1
  ndisReceiveFilterTestMaskEqual* = 2
  ndisReceiveFilterTestNotEqual* = 3
  ndisReceiveFilterTestMaximum* = 4
  ndisReceiveQueueTypeUnspecified* = 0
  ndisReceiveQueueTypeVMQueue* = 1
  ndisReceiveQueueTypeMaximum* = 2
  ndisReceiveQueueOperationalStateUndefined* = 0
  ndisReceiveQueueOperationalStateRunning* = 1
  ndisReceiveQueueOperationalStatePaused* = 2
  ndisReceiveQueueOperationalStateDmaStopped* = 3
  ndisReceiveQueueOperationalStateMaximum* = 4
  NDIS_RSS_CAPS_MESSAGE_SIGNALED_INTERRUPTS* = 0x01000000
  NDIS_RSS_CAPS_CLASSIFICATION_AT_ISR* = 0x02000000
  NDIS_RSS_CAPS_CLASSIFICATION_AT_DPC* = 0x04000000
  NDIS_RSS_CAPS_USING_MSI_X* = 0x08000000
  NDIS_RSS_CAPS_RSS_AVAILABLE_ON_PORTS* = 0x10000000
  NDIS_RSS_CAPS_SUPPORTS_MSI_X* = 0x20000000
  NDIS_RSS_CAPS_HASH_TYPE_TCP_IPV4* = 0x00000100
  NDIS_RSS_CAPS_HASH_TYPE_TCP_IPV6* = 0x00000200
  NDIS_RSS_CAPS_HASH_TYPE_TCP_IPV6_EX* = 0x00000400
  ndisHashFunctionToeplitz* = 0x00000001
  ndisHashFunctionReserved1* = 0x00000002
  ndisHashFunctionReserved2* = 0x00000004
  ndisHashFunctionReserved3* = 0x00000008
  NDIS_HASH_FUNCTION_MASK* = 0x000000ff
  NDIS_HASH_TYPE_MASK* = 0x00ffff00
  NDIS_HASH_IPV4* = 0x00000100
  NDIS_HASH_TCP_IPV4* = 0x00000200
  NDIS_HASH_IPV6* = 0x00000400
  NDIS_HASH_IPV6_EX* = 0x00000800
  NDIS_HASH_TCP_IPV6* = 0x00001000
  NDIS_HASH_TCP_IPV6_EX* = 0x00002000
  NDIS_RSS_PARAM_FLAG_BASE_CPU_UNCHANGED* = 0x0001
  NDIS_RSS_PARAM_FLAG_HASH_INFO_UNCHANGED* = 0x0002
  NDIS_RSS_PARAM_FLAG_ITABLE_UNCHANGED* = 0x0004
  NDIS_RSS_PARAM_FLAG_HASH_KEY_UNCHANGED* = 0x0008
  NDIS_RSS_PARAM_FLAG_DISABLE_RSS* = 0x0010
  NDIS_RSS_INDIRECTION_TABLE_SIZE_REVISION_1* = 128
  NDIS_RSS_HASH_SECRET_KEY_SIZE_REVISION_1* = 40
  NDIS_RSS_INDIRECTION_TABLE_MAX_SIZE_REVISION_1* = 128
  NDIS_RSS_HASH_SECRET_KEY_MAX_SIZE_REVISION_1* = 40
  NDIS_RSS_HASH_SECRET_KEY_MAX_SIZE_REVISION_2* = 40
  NDIS_RECEIVE_HASH_FLAG_ENABLE_HASH* = 0x00000001
  NDIS_RECEIVE_HASH_FLAG_HASH_INFO_UNCHANGED* = 0x00000002
  NDIS_RECEIVE_HASH_FLAG_HASH_KEY_UNCHANGED* = 0x00000004
  NDIS_PORT_CHAR_USE_DEFAULT_AUTH_SETTINGS* = 0x00000001
  NDIS_RECEIVE_SCALE_CAPABILITIES_REVISION_1* = 1
  NDIS_RECEIVE_HASH_PARAMETERS_REVISION_1* = 1
  NDIS_PORT_STATE_REVISION_1* = 1
  NDIS_PORT_CHARACTERISTICS_REVISION_1* = 1
  NDIS_PORT_ARRAY_REVISION_1* = 1
  NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_1* = 1
  NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_2* = 2
  NDIS_RECEIVE_SCALE_CAPABILITIES_REVISION_2* = 2
  ndisProcessorVendorUnknown* = 0
  ndisProcessorVendorGenuinIntel* = 1
  ndisProcessorVendorGenuineIntel* = ndisProcessorVendorGenuinIntel
  ndisProcessorVendorAuthenticAMD* = ndisProcessorVendorGenuinIntel+1
  NDIS_HYPERVISOR_INFO_FLAG_HYPERVISOR_PRESENT* = 0x00000001
  NDIS_RSS_PROCESSOR_INFO_REVISION_1* = 1
  NDIS_SYSTEM_PROCESSOR_INFO_EX_REVISION_1* = 1
  NDIS_HYPERVISOR_INFO_REVISION_1* = 1
  NDIS_WMI_RECEIVE_QUEUE_INFO_REVISION_1* = 1
  NDIS_WMI_RECEIVE_QUEUE_PARAMETERS_REVISION_1* = 1
  NDIS_RSS_PROCESSOR_INFO_REVISION_2* = 2
  ndisRssProfileClosest* = 1
  ndisRssProfileClosestStatic* = 2
  ndisRssProfileNuma* = 3
  ndisRssProfileNumaStatic* = 4
  ndisRssProfileConservative* = 5
  ndisRssProfileMaximum* = 6
  ndisHypervisorPartitionTypeUnknown* = 0
  ndisHypervisorPartitionTypeMsHvParent* = 1
  ndisHypervisorPartitionMsHvChild* = 2
  ndisHypervisorPartitionTypeMax* = 3
  OID_NDK_SET_STATE* = 0xfc040201'i32
  OID_NDK_STATISTICS* = 0xfc040202'i32
  OID_NDK_CONNECTIONS* = 0xfc040203'i32
  OID_NDK_LOCAL_ENDPOINTS* = 0xfc040204'i32
  OID_QOS_HARDWARE_CAPABILITIES* = 0xfc050001'i32
  OID_QOS_CURRENT_CAPABILITIES* = 0xfc050002'i32
  OID_QOS_PARAMETERS* = 0xfc050003'i32
  OID_QOS_OPERATIONAL_PARAMETERS* = 0xfc050004'i32
  OID_QOS_REMOTE_PARAMETERS* = 0xfc050005'i32
  NDIS_QOS_CAPABILITIES_STRICT_TSA_SUPPORTED* = 0x00000001
  NDIS_QOS_CAPABILITIES_MACSEC_BYPASS_SUPPORTED* = 0x00000002
  NDIS_QOS_CAPABILITIES_CEE_DCBX_SUPPORTED* = 0x00000004
  NDIS_QOS_CAPABILITIES_IEEE_DCBX_SUPPORTED* = 0x00000008
  NDIS_QOS_CLASSIFICATION_SET_BY_MINIPORT_MASK* = 0xff000000'i32
  NDIS_QOS_CLASSIFICATION_ENFORCED_BY_MINIPORT* = 0x01000000
  NDIS_QOS_CONDITION_RESERVED* = 0x0
  NDIS_QOS_CONDITION_DEFAULT* = 0x1
  NDIS_QOS_CONDITION_TCP_PORT* = 0x2
  NDIS_QOS_CONDITION_UDP_PORT* = 0x3
  NDIS_QOS_CONDITION_TCP_OR_UDP_PORT* = 0x4
  NDIS_QOS_CONDITION_ETHERTYPE* = 0x5
  NDIS_QOS_CONDITION_NETDIRECT_PORT* = 0x6
  NDIS_QOS_CONDITION_MAXIMUM* = 0x7
  NDIS_QOS_ACTION_PRIORITY* = 0x0
  NDIS_QOS_ACTION_MAXIMUM* = 0x1
  NDIS_QOS_PARAMETERS_ETS_CHANGED* = 0x00000001
  NDIS_QOS_PARAMETERS_ETS_CONFIGURED* = 0x00000002
  NDIS_QOS_PARAMETERS_PFC_CHANGED* = 0x00000100
  NDIS_QOS_PARAMETERS_PFC_CONFIGURED* = 0x00000200
  NDIS_QOS_PARAMETERS_CLASSIFICATION_CHANGED* = 0x00010000
  NDIS_QOS_PARAMETERS_CLASSIFICATION_CONFIGURED* = 0x00020000
  NDIS_QOS_PARAMETERS_WILLING* = 0x80000000'i32
  NDIS_QOS_TSA_STRICT* = 0x0
  NDIS_QOS_TSA_CBS* = 0x1
  NDIS_QOS_TSA_ETS* = 0x2
  NDIS_QOS_TSA_MAXIMUM* = 0x3
  NDIS_INVALID_RID* = ULONG(-1)
  NDIS_DEFAULT_VPORT_ID* = 0
  NDIS_DEFAULT_SWITCH_ID* = 0
  NDIS_INVALID_SWITCH_ID* = ULONG(-1)
  NDIS_NIC_SWITCH_PARAMETERS_CHANGE_MASK* = 0xffff0000'i32
  NDIS_NIC_SWITCH_PARAMETERS_SWITCH_NAME_CHANGED* = 0x00010000
  NDIS_SRIOV_CAPS_SRIOV_SUPPORTED* = 0x00000001
  NDIS_SRIOV_CAPS_PF_MINIPORT* = 0x00000002
  NDIS_SRIOV_CAPS_VF_MINIPORT* = 0x00000004
  NDIS_NIC_SWITCH_VF_INFO_ARRAY_ENUM_ON_SPECIFIC_SWITCH* = 0x00000001
  NDIS_NIC_SWITCH_VPORT_PARAMS_LOOKAHEAD_SPLIT_ENABLED* = 0x00000001
  NDIS_NIC_SWITCH_VPORT_PARAMS_CHANGE_MASK* = 0xffff0000'i32
  NDIS_NIC_SWITCH_VPORT_PARAMS_FLAGS_CHANGED* = 0x00010000
  NDIS_NIC_SWITCH_VPORT_PARAMS_NAME_CHANGED* = 0x00020000
  NDIS_NIC_SWITCH_VPORT_PARAMS_INT_MOD_CHANGED* = 0x00040000
  NDIS_NIC_SWITCH_VPORT_PARAMS_STATE_CHANGED* = 0x00080000
  NDIS_NIC_SWITCH_VPORT_PARAMS_PROCESSOR_AFFINITY_CHANGED* = 0x00100000
  NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_ENUM_ON_SPECIFIC_FUNCTION* = 0x00000001
  NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_ENUM_ON_SPECIFIC_SWITCH* = 0x00000002
  NDIS_NIC_SWITCH_VPORT_INFO_LOOKAHEAD_SPLIT_ENABLED* = 0x00000001
  GUID_NDIS_NDK_CAPABILITIES* = DEFINE_GUID("7969ba4d-dd80-4bc7-b3e6-68043997e519")
  GUID_NDIS_NDK_STATE* = DEFINE_GUID("530c69c9-2f51-49de-a1af-088d54ffa474")
  NDIS_NDK_CAPABILITIES_REVISION_1* = 1
  NDIS_NDK_STATISTICS_INFO_REVISION_1* = 1
  NDIS_NDK_CONNECTIONS_REVISION_1* = 1
  NDIS_NDK_LOCAL_ENDPOINTS_REVISION_1* = 1
  NDIS_QOS_CAPABILITIES_REVISION_1* = 1
  NDIS_QOS_CLASSIFICATION_ELEMENT_REVISION_1* = 1
  NDIS_QOS_PARAMETERS_REVISION_1* = 1
  NDIS_NIC_SWITCH_PARAMETERS_REVISION_1* = 1
  NDIS_NIC_SWITCH_DELETE_SWITCH_PARAMETERS_REVISION_1* = 1
  NDIS_NIC_SWITCH_INFO_REVISION_1* = 1
  NDIS_NIC_SWITCH_INFO_ARRAY_REVISION_1* = 1
  NDIS_NIC_SWITCH_VPORT_PARAMETERS_REVISION_1* = 1
  NDIS_NIC_SWITCH_DELETE_VPORT_PARAMETERS_REVISION_1* = 1
  NDIS_NIC_SWITCH_VPORT_INFO_REVISION_1* = 1
  NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_REVISION_1* = 1
  NDIS_NIC_SWITCH_VF_PARAMETERS_REVISION_1* = 1
  NDIS_NIC_SWITCH_FREE_VF_PARAMETERS_REVISION_1* = 1
  NDIS_NIC_SWITCH_VF_INFO_REVISION_1* = 1
  NDIS_NIC_SWITCH_VF_INFO_ARRAY_REVISION_1* = 1
  NDIS_SRIOV_CAPABILITIES_REVISION_1* = 1
  NDIS_SRIOV_READ_VF_CONFIG_SPACE_PARAMETERS_REVISION_1* = 1
  NDIS_SRIOV_WRITE_VF_CONFIG_SPACE_PARAMETERS_REVISION_1* = 1
  NDIS_SRIOV_READ_VF_CONFIG_BLOCK_PARAMETERS_REVISION_1* = 1
  NDIS_SRIOV_WRITE_VF_CONFIG_BLOCK_PARAMETERS_REVISION_1* = 1
  NDIS_SRIOV_RESET_VF_PARAMETERS_REVISION_1* = 1
  NDIS_SRIOV_SET_VF_POWER_STATE_PARAMETERS_REVISION_1* = 1
  NDIS_SRIOV_CONFIG_STATE_PARAMETERS_REVISION_1* = 1
  NDIS_SRIOV_VF_VENDOR_DEVICE_ID_INFO_REVISION_1* = 1
  NDIS_SRIOV_PROBED_BARS_INFO_REVISION_1* = 1
  NDIS_RECEIVE_FILTER_MOVE_FILTER_PARAMETERS_REVISION_1* = 1
  NDIS_SRIOV_BAR_RESOURCES_INFO_REVISION_1* = 1
  NDIS_SRIOV_PF_LUID_INFO_REVISION_1* = 1
  NDIS_SRIOV_VF_SERIAL_NUMBER_INFO_REVISION_1* = 1
  NDIS_SRIOV_VF_INVALIDATE_CONFIG_BLOCK_INFO_REVISION_1* = 1
  NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION_1* = 1
  NDIS_SWITCH_PORT_PROPERTY_SECURITY_REVISION_1* = 1
  NDIS_SWITCH_PORT_PROPERTY_VLAN_REVISION_1* = 1
  NDIS_SWITCH_PORT_PROPERTY_PROFILE_REVISION_1* = 1
  NDIS_SWITCH_PORT_PROPERTY_CUSTOM_REVISION_1* = 1
  NDIS_SWITCH_PORT_PROPERTY_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_PORT_PROPERTY_DELETE_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_PORT_PROPERTY_ENUM_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_PORT_PROPERTY_ENUM_INFO_REVISION_1* = 1
  NDIS_SWITCH_PROPERTY_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_PROPERTY_CUSTOM_REVISION_1* = 1
  NDIS_SWITCH_PORT_FEATURE_STATUS_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_PORT_FEATURE_STATUS_CUSTOM_REVISION_1* = 1
  NDIS_SWITCH_PROPERTY_DELETE_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_PROPERTY_ENUM_INFO_REVISION_1* = 1
  NDIS_SWITCH_PROPERTY_ENUM_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_FEATURE_STATUS_CUSTOM_REVISION_1* = 1
  NDIS_SWITCH_PORT_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_PORT_ARRAY_REVISION_1* = 1
  NDIS_SWITCH_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_NIC_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_NIC_ARRAY_REVISION_1* = 1
  NDIS_SWITCH_NIC_OID_REQUEST_REVISION_1* = 1
  NDIS_SWITCH_FEATURE_STATUS_PARAMETERS_REVISION_1* = 1
  NDIS_SWITCH_NIC_SAVE_STATE_REVISION_1* = 1
type
  NDIS_NDK_STATISTICS_INFO* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    CounterSet*: NDIS_NDK_PERFORMANCE_COUNTERS
proc Length*(self: IP_ADAPTER_UNICAST_ADDRESS_XP): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_UNICAST_ADDRESS_XP): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_UNICAST_ADDRESS_LH): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_UNICAST_ADDRESS_LH): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_ANYCAST_ADDRESS_XP): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_ANYCAST_ADDRESS_XP): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_MULTICAST_ADDRESS_XP): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_MULTICAST_ADDRESS_XP): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_DNS_SERVER_ADDRESS_XP): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_DNS_SERVER_ADDRESS_XP): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_PREFIX_XP): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_PREFIX_XP): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_WINS_SERVER_ADDRESS_LH): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_WINS_SERVER_ADDRESS_LH): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_GATEWAY_ADDRESS_LH): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_GATEWAY_ADDRESS_LH): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_ADDRESSES_LH): var ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: IP_ADAPTER_ADDRESSES_XP): ULONG {.inline.} = self.union1.struct1.Length
proc Length*(self: var IP_ADAPTER_ADDRESSES_XP): var ULONG {.inline.} = self.union1.struct1.Length
proc VlanProperties*(self: NDIS_SWITCH_PORT_PROPERTY_VLAN): NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_VlanProperties {.inline.} = self.union1.VlanProperties
proc VlanProperties*(self: var NDIS_SWITCH_PORT_PROPERTY_VLAN): var NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_VlanProperties {.inline.} = self.union1.VlanProperties
proc Reserved*(self: IP_ADAPTER_DNS_SERVER_ADDRESS_XP): DWORD {.inline.} = self.union1.struct1.Reserved
proc Reserved*(self: var IP_ADAPTER_DNS_SERVER_ADDRESS_XP): var DWORD {.inline.} = self.union1.struct1.Reserved
proc Reserved*(self: IP_ADAPTER_WINS_SERVER_ADDRESS_LH): DWORD {.inline.} = self.union1.struct1.Reserved
proc Reserved*(self: var IP_ADAPTER_WINS_SERVER_ADDRESS_LH): var DWORD {.inline.} = self.union1.struct1.Reserved
proc Reserved*(self: IP_ADAPTER_GATEWAY_ADDRESS_LH): DWORD {.inline.} = self.union1.struct1.Reserved
proc Reserved*(self: var IP_ADAPTER_GATEWAY_ADDRESS_LH): var DWORD {.inline.} = self.union1.struct1.Reserved
const
  NDK_ADAPTER_FLAG_IN_ORDER_DMA_SUPPORTED* = 0x1
  NDK_ADAPTER_FLAG_RDMA_READ_SINK_NOT_REQUIRED* = 0x2
  NDK_ADAPTER_FLAG_CQ_INTERRUPT_MODERATION_SUPPORTED* = 0x4
  NDK_ADAPTER_FLAG_MULTI_ENGINE_SUPPORTED* = 0x8
  NDK_ADAPTER_FLAG_CQ_RESIZE_SUPPORTED* = 0x100
  NDK_ADAPTER_FLAG_LOOPBACK_CONNECTIONS_SUPPORTED* = 0x10000
  ndisNicSwitchTypeUnspecified* = 0
  ndisNicSwitchTypeExternal* = 1
  ndisNicSwitchTypeMax* = 2
  ndisNicSwitchVPortStateUndefined* = 0
  ndisNicSwitchVPortStateActivated* = 1
  ndisNicSwitchVPortStateDeactivated* = 2
  ndisNicSwitchVPortStateMaximum* = 3
  ndisNicSwitchVPortInterruptModerationUndefined* = 0
  ndisNicSwitchVPortInterruptModerationAdaptive* = 1
  ndisNicSwitchVPortInterruptModerationOff* = 2
  ndisNicSwitchVPortInterruptModerationLow* = 100
  ndisNicSwitchVPortInterruptModerationMedium* = 200
  ndisNicSwitchVPortInterruptModerationHigh* = 300
  ndisSwitchPortPropertyTypeUndefined* = 0
  ndisSwitchPortPropertyTypeCustom* = 1
  ndisSwitchPortPropertyTypeSecurity* = 2
  ndisSwitchPortPropertyTypeVlan* = 3
  ndisSwitchPortPropertyTypeProfile* = 4
  ndisSwitchPortPropertyTypeMaximum* = 5
  ndisSwitchPortVlanModeUnknown* = 0
  ndisSwitchPortVlanModeAccess* = 1
  ndisSwitchPortVlanModeTrunk* = 2
  ndisSwitchPortVlanModePrivate* = 3
  ndisSwitchPortVlanModeMax* = 4
  ndisSwitchPortPvlanModeUndefined* = 0
  ndisSwitchPortPvlanModeIsolated* = 1
  ndisSwitchPortPvlanModeCommunity* = 2
  ndisSwitchPortPvlanModePromiscuous* = 3
  ndisSwitchPortFeatureStatusTypeUndefined* = 0
  ndisSwitchPortFeatureStatusTypeCustom* = 1
  ndisSwitchPortFeatureStatusTypeMaximum* = 2
  ndisSwitchPropertyTypeUndefined* = 0
  ndisSwitchPropertyTypeCustom* = 1
  ndisSwitchPropertyTypeMaximum* = 2
  ndisSwitchFeatureStatusTypeUndefined* = 0
  ndisSwitchFeatureStatusTypeCustom* = 1
  ndisSwitchFeatureStatusTypeMaximum* = 2
  ndisSwitchPortTypeGeneric* = 0
  ndisSwitchPortTypeExternal* = 1
  ndisSwitchPortTypeSynthetic* = 2
  ndisSwitchPortTypeEmulated* = 3
  ndisSwitchPortTypeInternal* = 4
  ndisSwitchPortStateUnknown* = 0
  ndisSwitchPortStateCreated* = 1
  ndisSwitchPortStateTeardown* = 2
  ndisSwitchPortStateDeleted* = 3
  ndisSwitchNicTypeExternal* = 0
  ndisSwitchNicTypeSynthetic* = 1
  ndisSwitchNicTypeEmulated* = 2
  ndisSwitchNicTypeInternal* = 3
  ndisSwitchNicStateUnknown* = 0
  ndisSwitchNicStateCreated* = 1
  ndisSwitchNicStateConnected* = 2
  ndisSwitchNicStateDisconnected* = 3
  ndisSwitchNicStateDeleted* = 4
  MIB_INVALID_TEREDO_PORT_NUMBER* = 0
  mibIfTableNormal* = 0
  mibIfTableRaw* = 1
  IOCTL_NDIS_QUERY_GLOBAL_STATS* = 0x00170002
  IOCTL_NDIS_QUERY_ALL_STATS* = 0x00170006
  IOCTL_NDIS_DO_PNP_OPERATION* = 0x00170008
  IOCTL_NDIS_QUERY_SELECTED_STATS* = 0x0017000E
  IOCTL_NDIS_ENUMERATE_INTERFACES* = 0x00170010
  IOCTL_NDIS_ADD_TDI_DEVICE* = 0x00170014
  IOCTL_NDIS_GET_LOG_DATA* = 0x0017001E
  IOCTL_NDIS_GET_VERSION* = 0x00170020
  NETWORK_ADDRESS_LENGTH_IP* = 16
  NETWORK_ADDRESS_LENGTH_IPX* = 12
  NL_MAX_METRIC_COMPONENT* = ULONG(1.uint32 shl 31 - 1)
  NDIS_PF_FUNCTION_ID* = not USHORT(0)
  NDIS_INVALID_VF_FUNCTION_ID* = not USHORT(0)
type
  PIPINTERFACE_CHANGE_CALLBACK* = proc (CallerContext: PVOID, Row: PMIB_IPINTERFACE_ROW, NotificationType: MIB_NOTIFICATION_TYPE): VOID {.stdcall.}
  PUNICAST_IPADDRESS_CHANGE_CALLBACK* = proc (CallerContext: PVOID, Row: PMIB_UNICASTIPADDRESS_ROW, NotificationType: MIB_NOTIFICATION_TYPE): VOID {.stdcall.}
  PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK* = proc (CallerContext: PVOID, AddressTable: PMIB_UNICASTIPADDRESS_TABLE): VOID {.stdcall.}
  PTEREDO_PORT_CHANGE_CALLBACK* = proc (CallerContext: PVOID, Port: USHORT, NotificationType: MIB_NOTIFICATION_TYPE): VOID {.stdcall.}
  PIPFORWARD_CHANGE_CALLBACK* = proc (CallerContext: PVOID, Row: PMIB_IPFORWARD_ROW2, NotificationType: MIB_NOTIFICATION_TYPE): VOID {.stdcall.}
  NDIS_NDK_CONNECTION_ENTRY* {.pure.} = object
    Local*: SOCKADDR_INET
    Remote*: SOCKADDR_INET
    UserModeOwner*: BOOLEAN
    OwnerPid*: ULONG
  NDIS_NDK_CONNECTIONS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    Count*: ULONG
    NDConnectionsMappedtoTCPConnections*: BOOLEAN
    Connections*: array[1, NDIS_NDK_CONNECTION_ENTRY]
  NDIS_NDK_LOCAL_ENDPOINT_ENTRY* {.pure.} = object
    Local*: SOCKADDR_INET
    UserModeOwner*: BOOLEAN
    Listener*: BOOLEAN
    OwnerPid*: ULONG
  NDIS_NDK_LOCAL_ENDPOINTS* {.pure.} = object
    Header*: NDIS_OBJECT_HEADER
    Flags*: ULONG
    Count*: ULONG
    NDLocalEndpointsMappedtoTCPLocalEndpoints*: BOOLEAN
    LocalEndpoints*: array[1, NDIS_NDK_LOCAL_ENDPOINT_ENTRY]
proc GetNumberOfInterfaces*(pdwNumIf: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIfEntry*(pIfRow: PMIB_IFROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIfTable*(pIfTable: PMIB_IFTABLE, pdwSize: PULONG, bOrder: WINBOOL): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpAddrTable*(pIpAddrTable: PMIB_IPADDRTABLE, pdwSize: PULONG, bOrder: WINBOOL): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpNetTable*(IpNetTable: PMIB_IPNETTABLE, SizePointer: PULONG, Order: WINBOOL): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpForwardTable*(pIpForwardTable: PMIB_IPFORWARDTABLE, pdwSize: PULONG, bOrder: WINBOOL): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetTcpTable*(TcpTable: PMIB_TCPTABLE, SizePointer: PULONG, Order: WINBOOL): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetExtendedTcpTable*(pTcpTable: PVOID, pdwSize: PDWORD, bOrder: WINBOOL, ulAf: ULONG, TableClass: TCP_TABLE_CLASS, Reserved: ULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetOwnerModuleFromTcpEntry*(pTcpEntry: PMIB_TCPROW_OWNER_MODULE, Class: TCPIP_OWNER_MODULE_INFO_CLASS, pBuffer: PVOID, pdwSize: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetUdpTable*(UdpTable: PMIB_UDPTABLE, SizePointer: PULONG, Order: WINBOOL): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetExtendedUdpTable*(pUdpTable: PVOID, pdwSize: PDWORD, bOrder: WINBOOL, ulAf: ULONG, TableClass: UDP_TABLE_CLASS, Reserved: ULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetOwnerModuleFromUdpEntry*(pUdpEntry: PMIB_UDPROW_OWNER_MODULE, Class: TCPIP_OWNER_MODULE_INFO_CLASS, pBuffer: PVOID, pdwSize: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetTcpTable2*(TcpTable: PMIB_TCPTABLE2, SizePointer: PULONG, Order: WINBOOL): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetTcp6Table*(TcpTable: PMIB_TCP6TABLE, SizePointer: PULONG, Order: WINBOOL): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetTcp6Table2*(TcpTable: PMIB_TCP6TABLE2, SizePointer: PULONG, Order: WINBOOL): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetPerTcpConnectionEStats*(Row: PMIB_TCPROW, EstatsType: TCP_ESTATS_TYPE, Rw: PUCHAR, RwVersion: ULONG, RwSize: ULONG, Ros: PUCHAR, RosVersion: ULONG, RosSize: ULONG, Rod: PUCHAR, RodVersion: ULONG, RodSize: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetPerTcpConnectionEStats*(Row: PMIB_TCPROW, EstatsType: TCP_ESTATS_TYPE, Rw: PUCHAR, RwVersion: ULONG, RwSize: ULONG, Offset: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetPerTcp6ConnectionEStats*(Row: PMIB_TCP6ROW, EstatsType: TCP_ESTATS_TYPE, Rw: PUCHAR, RwVersion: ULONG, RwSize: ULONG, Ros: PUCHAR, RosVersion: ULONG, RosSize: ULONG, Rod: PUCHAR, RodVersion: ULONG, RodSize: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetPerTcp6ConnectionEStats*(Row: PMIB_TCP6ROW, EstatsType: TCP_ESTATS_TYPE, Rw: PUCHAR, RwVersion: ULONG, RwSize: ULONG, Offset: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetUdp6Table*(Udp6Table: PMIB_UDP6TABLE, SizePointer: PULONG, Order: WINBOOL): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetOwnerModuleFromTcp6Entry*(pTcpEntry: PMIB_TCP6ROW_OWNER_MODULE, Class: TCPIP_OWNER_MODULE_INFO_CLASS, pBuffer: PVOID, pdwSize: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetOwnerModuleFromUdp6Entry*(pUdpEntry: PMIB_UDP6ROW_OWNER_MODULE, Class: TCPIP_OWNER_MODULE_INFO_CLASS, pBuffer: PVOID, pdwSize: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetOwnerModuleFromPidAndInfo*(ulPid: ULONG, pInfo: ptr ULONGLONG, Class: TCPIP_OWNER_MODULE_INFO_CLASS, pBuffer: PVOID, pdwSize: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpStatistics*(Statistics: PMIB_IPSTATS): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIcmpStatistics*(Statistics: PMIB_ICMP): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetTcpStatistics*(Statistics: PMIB_TCPSTATS): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetUdpStatistics*(Stats: PMIB_UDPSTATS): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpStatisticsEx*(Statistics: PMIB_IPSTATS, Family: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIpStatisticsEx*(Statistics: PMIB_IPSTATS, Family: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIcmpStatisticsEx*(Statistics: PMIB_ICMP_EX, Family: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetTcpStatisticsEx*(Statistics: PMIB_TCPSTATS, Family: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetUdpStatisticsEx*(Statistics: PMIB_UDPSTATS, Family: ULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIfEntry*(pIfRow: PMIB_IFROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreateIpForwardEntry*(pRoute: PMIB_IPFORWARDROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIpForwardEntry*(pRoute: PMIB_IPFORWARDROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeleteIpForwardEntry*(pRoute: PMIB_IPFORWARDROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIpStatistics*(pIpStats: PMIB_IPSTATS): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIpTTL*(nTTL: UINT): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreateIpNetEntry*(pArpEntry: PMIB_IPNETROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIpNetEntry*(pArpEntry: PMIB_IPNETROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeleteIpNetEntry*(pArpEntry: PMIB_IPNETROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc FlushIpNetTable*(dwIfIndex: DWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreateProxyArpEntry*(dwAddress: DWORD, dwMask: DWORD, dwIfIndex: DWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeleteProxyArpEntry*(dwAddress: DWORD, dwMask: DWORD, dwIfIndex: DWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetTcpEntry*(pTcpRow: PMIB_TCPROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetInterfaceInfo*(pIfTable: PIP_INTERFACE_INFO, dwOutBufLen: PULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetUniDirectionalAdapterInfo*(pIPIfInfo: PIP_UNIDIRECTIONAL_ADAPTER_ADDRESS, dwOutBufLen: PULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc NhpAllocateAndGetInterfaceInfoFromStack*(ppTable: ptr ptr IP_INTERFACE_NAME_INFO, pdwCount: PDWORD, bOrder: WINBOOL, hHeap: HANDLE, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetBestInterface*(dwDestAddr: IPAddr, pdwBestIfIndex: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetBestInterfaceEx*(pDestAddr: ptr sockaddr, pdwBestIfIndex: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetBestRoute*(dwDestAddr: DWORD, dwSourceAddr: DWORD, pBestRoute: PMIB_IPFORWARDROW): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc NotifyAddrChange*(Handle: PHANDLE, overlapped: LPOVERLAPPED): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc NotifyRouteChange*(Handle: PHANDLE, overlapped: LPOVERLAPPED): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CancelIPChangeNotify*(notifyOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetAdapterIndex*(AdapterName: LPWSTR, IfIndex: PULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc AddIPAddress*(Address: IPAddr, IpMask: IPMask, IfIndex: DWORD, NTEContext: PULONG, NTEInstance: PULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeleteIPAddress*(NTEContext: ULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetNetworkParams*(pFixedInfo: PFIXED_INFO, pOutBufLen: PULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetAdaptersInfo*(AdapterInfo: PIP_ADAPTER_INFO, SizePointer: PULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetAdapterOrderMap*(): PIP_ADAPTER_ORDER_MAP {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetAdaptersAddresses*(Family: ULONG, Flags: ULONG, Reserved: PVOID, AdapterAddresses: PIP_ADAPTER_ADDRESSES, SizePointer: PULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetPerAdapterInfo*(IfIndex: ULONG, pPerAdapterInfo: PIP_PER_ADAPTER_INFO, pOutBufLen: PULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc IpReleaseAddress*(AdapterInfo: PIP_ADAPTER_INDEX_MAP): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc IpRenewAddress*(AdapterInfo: PIP_ADAPTER_INDEX_MAP): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SendARP*(DestIP: IPAddr, SrcIP: IPAddr, pMacAddr: PVOID, PhyAddrLen: PULONG): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetRTTAndHopCount*(DestIpAddress: IPAddr, HopCount: PULONG, MaxHops: ULONG, RTT: PULONG): WINBOOL {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetFriendlyIfIndex*(IfIndex: DWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc EnableRouter*(pHandle: ptr HANDLE, pOverlapped: ptr OVERLAPPED): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc UnenableRouter*(pOverlapped: ptr OVERLAPPED, lpdwEnableCount: LPDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DisableMediaSense*(pHandle: ptr HANDLE, pOverLapped: ptr OVERLAPPED): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc RestoreMediaSense*(pOverlapped: ptr OVERLAPPED, lpdwEnableCount: LPDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ParseNetworkString*(NetworkString: ptr WCHAR, Types: DWORD, AddressInfo: PNET_ADDRESS_INFO, PortNumber: ptr USHORT, PrefixLength: ptr BYTE): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpErrorString*(ErrorCode: IP_STATUS, Buffer: PWSTR, Size: PDWORD): DWORD {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ResolveNeighbor*(NetworkAddress: ptr SOCKADDR, PhysicalAddress: PVOID, PhysicalAddressLength: PULONG): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreatePersistentTcpPortReservation*(StartPort: USHORT, NumberOfPorts: USHORT, Token: PULONG64): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreatePersistentUdpPortReservation*(StartPort: USHORT, NumberOfPorts: USHORT, Token: PULONG64): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeletePersistentTcpPortReservation*(StartPort: USHORT, NumberOfPorts: USHORT): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeletePersistentUdpPortReservation*(StartPort: USHORT, NumberOfPorts: USHORT): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc LookupPersistentTcpPortReservation*(StartPort: USHORT, NumberOfPorts: USHORT, Token: PULONG64): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc LookupPersistentUdpPortReservation*(StartPort: USHORT, NumberOfPorts: USHORT, Token: PULONG64): ULONG {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIfEntry2*(Row: PMIB_IF_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIfTable2*(Table: ptr PMIB_IF_TABLE2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIfTable2Ex*(Level: MIB_IF_TABLE_LEVEL, Table: ptr PMIB_IF_TABLE2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIfStackTable*(Table: ptr PMIB_IFSTACK_TABLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetInvertedIfStackTable*(Table: ptr PMIB_INVERTEDIFSTACK_TABLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpInterfaceEntry*(Row: PMIB_IPINTERFACE_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpInterfaceTable*(Family: ADDRESS_FAMILY, Table: ptr PMIB_IPINTERFACE_TABLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc InitializeIpInterfaceEntry*(Row: PMIB_IPINTERFACE_ROW): VOID {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc NotifyIpInterfaceChange*(Family: ADDRESS_FAMILY, Callback: PIPINTERFACE_CHANGE_CALLBACK, CallerContext: PVOID, InitialNotification: BOOLEAN, NotificationHandle: ptr HANDLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIpInterfaceEntry*(Row: PMIB_IPINTERFACE_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpNetworkConnectionBandwidthEstimates*(InterfaceIndex: NET_IFINDEX, AddressFamily: ADDRESS_FAMILY, BandwidthEstimates: PMIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreateUnicastIpAddressEntry*(Row: ptr MIB_UNICASTIPADDRESS_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeleteUnicastIpAddressEntry*(Row: ptr MIB_UNICASTIPADDRESS_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetUnicastIpAddressEntry*(Row: PMIB_UNICASTIPADDRESS_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetUnicastIpAddressTable*(Family: ADDRESS_FAMILY, Table: ptr PMIB_UNICASTIPADDRESS_TABLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc InitializeUnicastIpAddressEntry*(Row: PMIB_UNICASTIPADDRESS_ROW): VOID {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc NotifyUnicastIpAddressChange*(Family: ADDRESS_FAMILY, Callback: PUNICAST_IPADDRESS_CHANGE_CALLBACK, CallerContext: PVOID, InitialNotification: BOOLEAN, NotificationHandle: ptr HANDLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreateAnycastIpAddressEntry*(Row: ptr MIB_ANYCASTIPADDRESS_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeleteAnycastIpAddressEntry*(Row: ptr MIB_ANYCASTIPADDRESS_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetAnycastIpAddressEntry*(Row: PMIB_ANYCASTIPADDRESS_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetAnycastIpAddressTable*(Family: ADDRESS_FAMILY, Table: ptr PMIB_ANYCASTIPADDRESS_TABLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc NotifyStableUnicastIpAddressTable*(Family: ADDRESS_FAMILY, Table: ptr PMIB_UNICASTIPADDRESS_TABLE, CallerCallback: PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK, CallerContext: PVOID, NotificationHandle: ptr HANDLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetUnicastIpAddressEntry*(Row: ptr MIB_UNICASTIPADDRESS_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetMulticastIpAddressEntry*(Row: PMIB_MULTICASTIPADDRESS_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetMulticastIpAddressTable*(Family: ADDRESS_FAMILY, Table: ptr PMIB_MULTICASTIPADDRESS_TABLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreateIpForwardEntry2*(Row: ptr MIB_IPFORWARD_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeleteIpForwardEntry2*(Row: ptr MIB_IPFORWARD_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetBestRoute2*(InterfaceLuid: ptr NET_LUID, InterfaceIndex: NET_IFINDEX, SourceAddress: ptr SOCKADDR_INET, DestinationAddress: ptr SOCKADDR_INET, AddressSortOptions: ULONG, BestRoute: PMIB_IPFORWARD_ROW2, BestSourceAddress: ptr SOCKADDR_INET): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpForwardEntry2*(Row: PMIB_IPFORWARD_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpForwardTable2*(Family: ADDRESS_FAMILY, Table: ptr PMIB_IPFORWARD_TABLE2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc InitializeIpForwardEntry*(Row: PMIB_IPFORWARD_ROW2): VOID {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc NotifyRouteChange2*(AddressFamily: ADDRESS_FAMILY, Callback: PIPFORWARD_CHANGE_CALLBACK, CallerContext: PVOID, InitialNotification: BOOLEAN, NotificationHandle: ptr HANDLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIpForwardEntry2*(Route: ptr MIB_IPFORWARD_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc FlushIpPathTable*(Family: ADDRESS_FAMILY): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpPathEntry*(Row: PMIB_IPPATH_ROW): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpPathTable*(Family: ADDRESS_FAMILY, Table: ptr PMIB_IPPATH_TABLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreateIpNetEntry2*(Row: ptr MIB_IPNET_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc DeleteIpNetEntry2*(Row: ptr MIB_IPNET_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc FlushIpNetTable2*(Family: ADDRESS_FAMILY, InterfaceIndex: NET_IFINDEX): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpNetEntry2*(Row: PMIB_IPNET_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetIpNetTable2*(Family: ADDRESS_FAMILY, Table: ptr PMIB_IPNET_TABLE2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ResolveIpNetEntry2*(Row: PMIB_IPNET_ROW2, SourceAddress: ptr SOCKADDR_INET): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetIpNetEntry2*(Row: PMIB_IPNET_ROW2): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc NotifyTeredoPortChange*(Callback: PTEREDO_PORT_CHANGE_CALLBACK, CallerContext: PVOID, InitialNotification: BOOLEAN, NotificationHandle: ptr HANDLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetTeredoPort*(Port: ptr USHORT): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CancelMibChangeNotify2*(NotificationHandle: HANDLE): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc FreeMibTable*(Memory: PVOID): VOID {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc CreateSortedAddressPairs*(SourceAddressList: PSOCKADDR_IN6, SourceAddressCount: ULONG, DestinationAddressList: PSOCKADDR_IN6, DestinationAddressCount: ULONG, AddressSortOptions: ULONG, SortedAddressPairList: ptr PSOCKADDR_IN6_PAIR, SortedAddressPairCount: ptr ULONG): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceNameToLuidA*(InterfaceName: ptr CHAR, InterfaceLuid: ptr NET_LUID): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceNameToLuidW*(InterfaceName: ptr WCHAR, InterfaceLuid: ptr NET_LUID): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceLuidToNameA*(InterfaceLuid: ptr NET_LUID, InterfaceName: PSTR, Length: SIZE_T): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceLuidToNameW*(InterfaceLuid: ptr NET_LUID, InterfaceName: PWSTR, Length: SIZE_T): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceLuidToIndex*(InterfaceLuid: ptr NET_LUID, InterfaceIndex: PNET_IFINDEX): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceIndexToLuid*(InterfaceIndex: NET_IFINDEX, InterfaceLuid: PNET_LUID): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceLuidToAlias*(InterfaceLuid: ptr NET_LUID, InterfaceAlias: PWSTR, Length: SIZE_T): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceAliasToLuid*(InterfaceAlias: ptr WCHAR, InterfaceLuid: PNET_LUID): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceLuidToGuid*(InterfaceLuid: ptr NET_LUID, InterfaceGuid: ptr GUID): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertInterfaceGuidToLuid*(InterfaceGuid: ptr GUID, InterfaceLuid: PNET_LUID): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc if_nametoindex*(InterfaceName: PCSTR): NET_IFINDEX {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc if_indextoname*(InterfaceIndex: NET_IFINDEX, InterfaceName: PCHAR): PCHAR {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetCurrentThreadCompartmentId*(): NET_IF_COMPARTMENT_ID {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetCurrentThreadCompartmentId*(CompartmentId: NET_IF_COMPARTMENT_ID): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetSessionCompartmentId*(SessionId: ULONG): NET_IF_COMPARTMENT_ID {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetSessionCompartmentId*(SessionId: ULONG, CompartmentId: NET_IF_COMPARTMENT_ID): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc GetNetworkInformation*(NetworkGuid: ptr NET_IF_NETWORK_GUID, CompartmentId: PNET_IF_COMPARTMENT_ID, SiteId: PULONG, NetworkName: PWCHAR, Length: ULONG): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc SetNetworkInformation*(NetworkGuid: ptr NET_IF_NETWORK_GUID, CompartmentId: NET_IF_COMPARTMENT_ID, NetworkName: ptr WCHAR): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertLengthToIpv4Mask*(MaskLength: ULONG, Mask: PULONG): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc ConvertIpv4MaskToLength*(Mask: ULONG, MaskLength: PUINT8): NETIO_STATUS {.winapi, stdcall, dynlib: "iphlpapi", importc.}
proc `SpecificPortBind=`*(self: var MIB_UDPROW_OWNER_MODULE, x: DWORD) {.inline.} = self.union1.struct1.SpecificPortBind = x
proc SpecificPortBind*(self: MIB_UDPROW_OWNER_MODULE): DWORD {.inline.} = self.union1.struct1.SpecificPortBind
proc `dwFlags=`*(self: var MIB_UDPROW_OWNER_MODULE, x: DWORD) {.inline.} = self.union1.dwFlags = x
proc dwFlags*(self: MIB_UDPROW_OWNER_MODULE): DWORD {.inline.} = self.union1.dwFlags
proc dwFlags*(self: var MIB_UDPROW_OWNER_MODULE): var DWORD {.inline.} = self.union1.dwFlags
proc `SpecificPortBind=`*(self: var MIB_UDP6ROW_OWNER_MODULE, x: DWORD) {.inline.} = self.union1.struct1.SpecificPortBind = x
proc SpecificPortBind*(self: MIB_UDP6ROW_OWNER_MODULE): DWORD {.inline.} = self.union1.struct1.SpecificPortBind
proc `dwFlags=`*(self: var MIB_UDP6ROW_OWNER_MODULE, x: DWORD) {.inline.} = self.union1.dwFlags = x
proc dwFlags*(self: MIB_UDP6ROW_OWNER_MODULE): DWORD {.inline.} = self.union1.dwFlags
proc dwFlags*(self: var MIB_UDP6ROW_OWNER_MODULE): var DWORD {.inline.} = self.union1.dwFlags
proc `ullAlign=`*(self: var MIB_OPAQUE_INFO, x: ULONGLONG) {.inline.} = self.union1.ullAlign = x
proc ullAlign*(self: MIB_OPAQUE_INFO): ULONGLONG {.inline.} = self.union1.ullAlign
proc ullAlign*(self: var MIB_OPAQUE_INFO): var ULONGLONG {.inline.} = self.union1.ullAlign
proc `rgbyData=`*(self: var MIB_OPAQUE_INFO, x: array[1, BYTE]) {.inline.} = self.union1.rgbyData = x
proc rgbyData*(self: MIB_OPAQUE_INFO): array[1, BYTE] {.inline.} = self.union1.rgbyData
proc rgbyData*(self: var MIB_OPAQUE_INFO): var array[1, BYTE] {.inline.} = self.union1.rgbyData
proc `Alignment=`*(self: var IP_ADAPTER_UNICAST_ADDRESS_XP, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_UNICAST_ADDRESS_XP): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_UNICAST_ADDRESS_XP): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_UNICAST_ADDRESS_XP, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `Flags=`*(self: var IP_ADAPTER_UNICAST_ADDRESS_XP, x: DWORD) {.inline.} = self.union1.struct1.Flags = x
proc `Alignment=`*(self: var IP_ADAPTER_UNICAST_ADDRESS_LH, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_UNICAST_ADDRESS_LH): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_UNICAST_ADDRESS_LH): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_UNICAST_ADDRESS_LH, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `Flags=`*(self: var IP_ADAPTER_UNICAST_ADDRESS_LH, x: DWORD) {.inline.} = self.union1.struct1.Flags = x
proc `Alignment=`*(self: var IP_ADAPTER_ANYCAST_ADDRESS_XP, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_ANYCAST_ADDRESS_XP): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_ANYCAST_ADDRESS_XP): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_ANYCAST_ADDRESS_XP, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `Flags=`*(self: var IP_ADAPTER_ANYCAST_ADDRESS_XP, x: DWORD) {.inline.} = self.union1.struct1.Flags = x
proc `Alignment=`*(self: var IP_ADAPTER_MULTICAST_ADDRESS_XP, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_MULTICAST_ADDRESS_XP): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_MULTICAST_ADDRESS_XP): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_MULTICAST_ADDRESS_XP, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `Flags=`*(self: var IP_ADAPTER_MULTICAST_ADDRESS_XP, x: DWORD) {.inline.} = self.union1.struct1.Flags = x
proc `Alignment=`*(self: var IP_ADAPTER_DNS_SERVER_ADDRESS_XP, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_DNS_SERVER_ADDRESS_XP): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_DNS_SERVER_ADDRESS_XP): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_DNS_SERVER_ADDRESS_XP, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `Reserved=`*(self: var IP_ADAPTER_DNS_SERVER_ADDRESS_XP, x: DWORD) {.inline.} = self.union1.struct1.Reserved = x
proc `Alignment=`*(self: var IP_ADAPTER_PREFIX_XP, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_PREFIX_XP): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_PREFIX_XP): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_PREFIX_XP, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `Flags=`*(self: var IP_ADAPTER_PREFIX_XP, x: DWORD) {.inline.} = self.union1.struct1.Flags = x
proc `Alignment=`*(self: var IP_ADAPTER_WINS_SERVER_ADDRESS_LH, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_WINS_SERVER_ADDRESS_LH): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_WINS_SERVER_ADDRESS_LH): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_WINS_SERVER_ADDRESS_LH, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `Reserved=`*(self: var IP_ADAPTER_WINS_SERVER_ADDRESS_LH, x: DWORD) {.inline.} = self.union1.struct1.Reserved = x
proc `Alignment=`*(self: var IP_ADAPTER_GATEWAY_ADDRESS_LH, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_GATEWAY_ADDRESS_LH): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_GATEWAY_ADDRESS_LH): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_GATEWAY_ADDRESS_LH, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `Reserved=`*(self: var IP_ADAPTER_GATEWAY_ADDRESS_LH, x: DWORD) {.inline.} = self.union1.struct1.Reserved = x
proc `Alignment=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_ADDRESSES_LH): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_ADDRESSES_LH): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `IfIndex=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: IF_INDEX) {.inline.} = self.union1.struct1.IfIndex = x
proc ifIndex*(self: IP_ADAPTER_ADDRESSES_LH): IF_INDEX {.inline.} = self.union1.struct1.IfIndex
proc ifIndex*(self: var IP_ADAPTER_ADDRESSES_LH): var IF_INDEX {.inline.} = self.union1.struct1.IfIndex
proc `Flags=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.Flags = x
proc `DdnsEnabled=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.DdnsEnabled = x
proc DdnsEnabled*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.DdnsEnabled
proc `RegisterAdapterSuffix=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.RegisterAdapterSuffix = x
proc RegisterAdapterSuffix*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.RegisterAdapterSuffix
proc `Dhcpv4Enabled=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.Dhcpv4Enabled = x
proc Dhcpv4Enabled*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.Dhcpv4Enabled
proc `ReceiveOnly=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.ReceiveOnly = x
proc ReceiveOnly*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.ReceiveOnly
proc `NoMulticast=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.NoMulticast = x
proc NoMulticast*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.NoMulticast
proc `Ipv6OtherStatefulConfig=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.Ipv6OtherStatefulConfig = x
proc Ipv6OtherStatefulConfig*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.Ipv6OtherStatefulConfig
proc `NetbiosOverTcpipEnabled=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.NetbiosOverTcpipEnabled = x
proc NetbiosOverTcpipEnabled*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.NetbiosOverTcpipEnabled
proc `Ipv4Enabled=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.Ipv4Enabled = x
proc Ipv4Enabled*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.Ipv4Enabled
proc `Ipv6Enabled=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.Ipv6Enabled = x
proc Ipv6Enabled*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.Ipv6Enabled
proc `Ipv6ManagedAddressConfigurationSupported=`*(self: var IP_ADAPTER_ADDRESSES_LH, x: ULONG) {.inline.} = self.union2.struct1.Ipv6ManagedAddressConfigurationSupported = x
proc Ipv6ManagedAddressConfigurationSupported*(self: IP_ADAPTER_ADDRESSES_LH): ULONG {.inline.} = self.union2.struct1.Ipv6ManagedAddressConfigurationSupported
proc `Alignment=`*(self: var IP_ADAPTER_ADDRESSES_XP, x: ULONGLONG) {.inline.} = self.union1.Alignment = x
proc Alignment*(self: IP_ADAPTER_ADDRESSES_XP): ULONGLONG {.inline.} = self.union1.Alignment
proc Alignment*(self: var IP_ADAPTER_ADDRESSES_XP): var ULONGLONG {.inline.} = self.union1.Alignment
proc `Length=`*(self: var IP_ADAPTER_ADDRESSES_XP, x: ULONG) {.inline.} = self.union1.struct1.Length = x
proc `IfIndex=`*(self: var IP_ADAPTER_ADDRESSES_XP, x: DWORD) {.inline.} = self.union1.struct1.IfIndex = x
proc ifIndex*(self: IP_ADAPTER_ADDRESSES_XP): DWORD {.inline.} = self.union1.struct1.IfIndex
proc ifIndex*(self: var IP_ADAPTER_ADDRESSES_XP): var DWORD {.inline.} = self.union1.struct1.IfIndex
proc `NamedAddress=`*(self: var NET_ADDRESS_INFO, x: NET_ADDRESS_INFO_UNION1_NamedAddress) {.inline.} = self.union1.NamedAddress = x
proc NamedAddress*(self: NET_ADDRESS_INFO): NET_ADDRESS_INFO_UNION1_NamedAddress {.inline.} = self.union1.NamedAddress
proc NamedAddress*(self: var NET_ADDRESS_INFO): var NET_ADDRESS_INFO_UNION1_NamedAddress {.inline.} = self.union1.NamedAddress
proc `Ipv4Address=`*(self: var NET_ADDRESS_INFO, x: SOCKADDR_IN) {.inline.} = self.union1.Ipv4Address = x
proc ipv4Address*(self: NET_ADDRESS_INFO): SOCKADDR_IN {.inline.} = self.union1.Ipv4Address
proc ipv4Address*(self: var NET_ADDRESS_INFO): var SOCKADDR_IN {.inline.} = self.union1.Ipv4Address
proc `Ipv6Address=`*(self: var NET_ADDRESS_INFO, x: SOCKADDR_IN6) {.inline.} = self.union1.Ipv6Address = x
proc ipv6Address*(self: NET_ADDRESS_INFO): SOCKADDR_IN6 {.inline.} = self.union1.Ipv6Address
proc ipv6Address*(self: var NET_ADDRESS_INFO): var SOCKADDR_IN6 {.inline.} = self.union1.Ipv6Address
proc `IpAddress=`*(self: var NET_ADDRESS_INFO, x: SOCKADDR) {.inline.} = self.union1.IpAddress = x
proc ipAddress*(self: NET_ADDRESS_INFO): SOCKADDR {.inline.} = self.union1.IpAddress
proc ipAddress*(self: var NET_ADDRESS_INFO): var SOCKADDR {.inline.} = self.union1.IpAddress
proc `AuthenticationEvent=`*(self: var NDIS_802_11_TEST, x: NDIS_802_11_AUTHENTICATION_EVENT) {.inline.} = self.union1.AuthenticationEvent = x
proc AuthenticationEvent*(self: NDIS_802_11_TEST): NDIS_802_11_AUTHENTICATION_EVENT {.inline.} = self.union1.AuthenticationEvent
proc AuthenticationEvent*(self: var NDIS_802_11_TEST): var NDIS_802_11_AUTHENTICATION_EVENT {.inline.} = self.union1.AuthenticationEvent
proc `RssiTrigger=`*(self: var NDIS_802_11_TEST, x: NDIS_802_11_RSSI) {.inline.} = self.union1.RssiTrigger = x
proc RssiTrigger*(self: NDIS_802_11_TEST): NDIS_802_11_RSSI {.inline.} = self.union1.RssiTrigger
proc RssiTrigger*(self: var NDIS_802_11_TEST): var NDIS_802_11_RSSI {.inline.} = self.union1.RssiTrigger
proc `Oid=`*(self: var NDIS_GUID, x: NDIS_OID) {.inline.} = self.union1.Oid = x
proc Oid*(self: NDIS_GUID): NDIS_OID {.inline.} = self.union1.Oid
proc Oid*(self: var NDIS_GUID): var NDIS_OID {.inline.} = self.union1.Oid
proc `Status=`*(self: var NDIS_GUID, x: NDIS_STATUS) {.inline.} = self.union1.Status = x
proc Status*(self: NDIS_GUID): NDIS_STATUS {.inline.} = self.union1.Status
proc Status*(self: var NDIS_GUID): var NDIS_STATUS {.inline.} = self.union1.Status
proc `RscIPv4=`*(self: var NDIS_OFFLOAD_PARAMETERS, x: UCHAR) {.inline.} = self.struct1.RscIPv4 = x
proc RscIPv4*(self: NDIS_OFFLOAD_PARAMETERS): UCHAR {.inline.} = self.struct1.RscIPv4
proc RscIPv4*(self: var NDIS_OFFLOAD_PARAMETERS): var UCHAR {.inline.} = self.struct1.RscIPv4
proc `RscIPv6=`*(self: var NDIS_OFFLOAD_PARAMETERS, x: UCHAR) {.inline.} = self.struct1.RscIPv6 = x
proc RscIPv6*(self: NDIS_OFFLOAD_PARAMETERS): UCHAR {.inline.} = self.struct1.RscIPv6
proc RscIPv6*(self: var NDIS_OFFLOAD_PARAMETERS): var UCHAR {.inline.} = self.struct1.RscIPv6
proc `EncapsulatedPacketTaskOffload=`*(self: var NDIS_OFFLOAD_PARAMETERS, x: UCHAR) {.inline.} = self.struct2.EncapsulatedPacketTaskOffload = x
proc EncapsulatedPacketTaskOffload*(self: NDIS_OFFLOAD_PARAMETERS): UCHAR {.inline.} = self.struct2.EncapsulatedPacketTaskOffload
proc EncapsulatedPacketTaskOffload*(self: var NDIS_OFFLOAD_PARAMETERS): var UCHAR {.inline.} = self.struct2.EncapsulatedPacketTaskOffload
proc `EncapsulationTypes=`*(self: var NDIS_OFFLOAD_PARAMETERS, x: UCHAR) {.inline.} = self.struct2.EncapsulationTypes = x
proc `VlanProperties=`*(self: var NDIS_SWITCH_PORT_PROPERTY_VLAN, x: NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_VlanProperties) {.inline.} = self.union1.VlanProperties = x
proc `SecondaryVlanId=`*(self: var NDIS_SWITCH_PORT_PROPERTY_VLAN, x: UINT16) {.inline.} = self.union1.PvlanProperties.union1.SecondaryVlanId = x
proc SecondaryVlanId*(self: NDIS_SWITCH_PORT_PROPERTY_VLAN): UINT16 {.inline.} = self.union1.PvlanProperties.union1.SecondaryVlanId
proc SecondaryVlanId*(self: var NDIS_SWITCH_PORT_PROPERTY_VLAN): var UINT16 {.inline.} = self.union1.PvlanProperties.union1.SecondaryVlanId
proc `SecondaryVlanIdArray=`*(self: var NDIS_SWITCH_PORT_PROPERTY_VLAN, x: array[64, UINT64]) {.inline.} = self.union1.PvlanProperties.union1.SecondaryVlanIdArray = x
proc SecondaryVlanIdArray*(self: NDIS_SWITCH_PORT_PROPERTY_VLAN): array[64, UINT64] {.inline.} = self.union1.PvlanProperties.union1.SecondaryVlanIdArray
proc SecondaryVlanIdArray*(self: var NDIS_SWITCH_PORT_PROPERTY_VLAN): var array[64, UINT64] {.inline.} = self.union1.PvlanProperties.union1.SecondaryVlanIdArray
proc `PvlanProperties=`*(self: var NDIS_SWITCH_PORT_PROPERTY_VLAN, x: NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_PvlanProperties) {.inline.} = self.union1.PvlanProperties = x
proc PvlanProperties*(self: NDIS_SWITCH_PORT_PROPERTY_VLAN): NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_PvlanProperties {.inline.} = self.union1.PvlanProperties
proc PvlanProperties*(self: var NDIS_SWITCH_PORT_PROPERTY_VLAN): var NDIS_SWITCH_PORT_PROPERTY_VLAN_UNION1_PvlanProperties {.inline.} = self.union1.PvlanProperties
proc `LastReachable=`*(self: var MIB_IPPATH_ROW, x: ULONG) {.inline.} = self.union1.LastReachable = x
proc LastReachable*(self: MIB_IPPATH_ROW): ULONG {.inline.} = self.union1.LastReachable
proc LastReachable*(self: var MIB_IPPATH_ROW): var ULONG {.inline.} = self.union1.LastReachable
proc `LastUnreachable=`*(self: var MIB_IPPATH_ROW, x: ULONG) {.inline.} = self.union1.LastUnreachable = x
proc LastUnreachable*(self: MIB_IPPATH_ROW): ULONG {.inline.} = self.union1.LastUnreachable
proc LastUnreachable*(self: var MIB_IPPATH_ROW): var ULONG {.inline.} = self.union1.LastUnreachable
proc `IsRouter=`*(self: var MIB_IPNET_ROW2, x: BOOLEAN) {.inline.} = self.union1.struct1.IsRouter = x
proc IsRouter*(self: MIB_IPNET_ROW2): BOOLEAN {.inline.} = self.union1.struct1.IsRouter
proc `IsUnreachable=`*(self: var MIB_IPNET_ROW2, x: BOOLEAN) {.inline.} = self.union1.struct1.IsUnreachable = x
proc IsUnreachable*(self: MIB_IPNET_ROW2): BOOLEAN {.inline.} = self.union1.struct1.IsUnreachable
proc `Flags=`*(self: var MIB_IPNET_ROW2, x: UCHAR) {.inline.} = self.union1.Flags = x
proc OnComplete*(self: ptr IConnectionRequestCallback, hrStatus: HRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnComplete(self, hrStatus)
converter winimConverterIConnectionRequestCallbackToIUnknown*(x: ptr IConnectionRequestCallback): ptr IUnknown = cast[ptr IUnknown](x)
when winimCpu64:
  type
    IP_OPTION_INFORMATION32* {.pure.} = object
      Ttl*: UCHAR
      Tos*: UCHAR
      Flags*: UCHAR
      OptionsSize*: UCHAR
      OptionsData*: ptr UCHAR
    PIP_OPTION_INFORMATION32* = ptr IP_OPTION_INFORMATION32
    ICMP_ECHO_REPLY32* {.pure.} = object
      Address*: IPAddr
      Status*: ULONG
      RoundTripTime*: ULONG
      DataSize*: USHORT
      Reserved*: USHORT
      Data*: pointer
      Options*: IP_OPTION_INFORMATION32
    PICMP_ECHO_REPLY32* = ptr ICMP_ECHO_REPLY32
