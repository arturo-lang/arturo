#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winsock
#include <windns.h>
type
  DNS_CONFIG_TYPE* = int32
  DNS_SECTION* = int32
  DNS_CHARSET* = int32
  DNS_FREE_TYPE* = int32
  DNS_NAME_FORMAT* = int32
  DNS_STATUS* = LONG
  PDNS_STATUS* = ptr LONG
  IP4_ADDRESS* = DWORD
  PIP4_ADDRESS* = ptr DWORD
  IP4_ARRAY* {.pure.} = object
    AddrCount*: DWORD
    AddrArray*: array[1, IP4_ADDRESS]
  PIP4_ARRAY* = ptr IP4_ARRAY
  IP6_ADDRESS* {.pure, union.} = object
    IP6Qword*: array[2, QWORD]
    IP6Dword*: array[4, DWORD]
    IP6Word*: array[8, WORD]
    IP6Byte*: array[16, BYTE]
    In6*: IN6_ADDR
  PIP6_ADDRESS* = ptr IP6_ADDRESS
  DNS_HEADER* {.pure.} = object
    Xid*: WORD
    RecursionDesired* {.bitsize:1.}: BYTE
    Truncation* {.bitsize:1.}: BYTE
    Authoritative* {.bitsize:1.}: BYTE
    Opcode* {.bitsize:4.}: BYTE
    IsResponse* {.bitsize:1.}: BYTE
    ResponseCode* {.bitsize:4.}: BYTE
    Reserved* {.bitsize:3.}: BYTE
    RecursionAvailable* {.bitsize:1.}: BYTE
    QuestionCount*: WORD
    AnswerCount*: WORD
    NameServerCount*: WORD
    AdditionalCount*: WORD
  PDNS_HEADER* = ptr DNS_HEADER
  DNS_WIRE_QUESTION* {.pure.} = object
    QuestionType*: WORD
    QuestionClass*: WORD
  PDNS_WIRE_QUESTION* = ptr DNS_WIRE_QUESTION
  DNS_WIRE_RECORD* {.pure, packed.} = object
    RecordType*: WORD
    RecordClass*: WORD
    TimeToLive*: DWORD
    DataLength*: WORD
  PDNS_WIRE_RECORD* = ptr DNS_WIRE_RECORD
  DNS_A_DATA* {.pure.} = object
    IpAddress*: IP4_ADDRESS
  PDNS_A_DATA* = ptr DNS_A_DATA
  DNS_PTR_DATAW* {.pure.} = object
    pNameHost*: PWSTR
  PDNS_PTR_DATAW* = ptr DNS_PTR_DATAW
  DNS_PTR_DATAA* {.pure.} = object
    pNameHost*: PSTR
  PDNS_PTR_DATAA* = ptr DNS_PTR_DATAA
  DNS_SOA_DATAW* {.pure.} = object
    pNamePrimaryServer*: PWSTR
    pNameAdministrator*: PWSTR
    dwSerialNo*: DWORD
    dwRefresh*: DWORD
    dwRetry*: DWORD
    dwExpire*: DWORD
    dwDefaultTtl*: DWORD
  PDNS_SOA_DATAW* = ptr DNS_SOA_DATAW
  DNS_SOA_DATAA* {.pure.} = object
    pNamePrimaryServer*: PSTR
    pNameAdministrator*: PSTR
    dwSerialNo*: DWORD
    dwRefresh*: DWORD
    dwRetry*: DWORD
    dwExpire*: DWORD
    dwDefaultTtl*: DWORD
  PDNS_SOA_DATAA* = ptr DNS_SOA_DATAA
  DNS_MINFO_DATAW* {.pure.} = object
    pNameMailbox*: PWSTR
    pNameErrorsMailbox*: PWSTR
  PDNS_MINFO_DATAW* = ptr DNS_MINFO_DATAW
  DNS_MINFO_DATAA* {.pure.} = object
    pNameMailbox*: PSTR
    pNameErrorsMailbox*: PSTR
  PDNS_MINFO_DATAA* = ptr DNS_MINFO_DATAA
  DNS_MX_DATAW* {.pure.} = object
    pNameExchange*: PWSTR
    wPreference*: WORD
    Pad*: WORD
  PDNS_MX_DATAW* = ptr DNS_MX_DATAW
  DNS_MX_DATAA* {.pure.} = object
    pNameExchange*: PSTR
    wPreference*: WORD
    Pad*: WORD
  PDNS_MX_DATAA* = ptr DNS_MX_DATAA
  DNS_TXT_DATAW* {.pure.} = object
    dwStringCount*: DWORD
    pStringArray*: array[1, PWSTR]
  PDNS_TXT_DATAW* = ptr DNS_TXT_DATAW
  DNS_TXT_DATAA* {.pure.} = object
    dwStringCount*: DWORD
    pStringArray*: array[1, PSTR]
  PDNS_TXT_DATAA* = ptr DNS_TXT_DATAA
  DNS_NULL_DATA* {.pure.} = object
    dwByteCount*: DWORD
    Data*: array[1, BYTE]
  PDNS_NULL_DATA* = ptr DNS_NULL_DATA
  DNS_WKS_DATA* {.pure.} = object
    IpAddress*: IP4_ADDRESS
    chProtocol*: UCHAR
    BitMask*: array[1, BYTE]
  PDNS_WKS_DATA* = ptr DNS_WKS_DATA
  DNS_AAAA_DATA* {.pure.} = object
    Ip6Address*: IP6_ADDRESS
  PDNS_AAAA_DATA* = ptr DNS_AAAA_DATA
  DNS_SIG_DATAW* {.pure.} = object
    pNameSigner*: PWSTR
    wTypeCovered*: WORD
    chAlgorithm*: BYTE
    chLabelCount*: BYTE
    dwOriginalTtl*: DWORD
    dwExpiration*: DWORD
    dwTimeSigned*: DWORD
    wKeyTag*: WORD
    Pad*: WORD
    Signature*: array[1, BYTE]
  PDNS_SIG_DATAW* = ptr DNS_SIG_DATAW
  DNS_SIG_DATAA* {.pure.} = object
    pNameSigner*: PSTR
    wTypeCovered*: WORD
    chAlgorithm*: BYTE
    chLabelCount*: BYTE
    dwOriginalTtl*: DWORD
    dwExpiration*: DWORD
    dwTimeSigned*: DWORD
    wKeyTag*: WORD
    Pad*: WORD
    Signature*: array[1, BYTE]
  PDNS_SIG_DATAA* = ptr DNS_SIG_DATAA
  DNS_KEY_DATA* {.pure.} = object
    wFlags*: WORD
    chProtocol*: BYTE
    chAlgorithm*: BYTE
    Key*: array[1, BYTE]
  PDNS_KEY_DATA* = ptr DNS_KEY_DATA
  DNS_LOC_DATA* {.pure.} = object
    wVersion*: WORD
    wSize*: WORD
    wHorPrec*: WORD
    wVerPrec*: WORD
    dwLatitude*: DWORD
    dwLongitude*: DWORD
    dwAltitude*: DWORD
  PDNS_LOC_DATA* = ptr DNS_LOC_DATA
  DNS_NXT_DATAW* {.pure.} = object
    pNameNext*: PWSTR
    wNumTypes*: WORD
    wTypes*: array[1, WORD]
  PDNS_NXT_DATAW* = ptr DNS_NXT_DATAW
  DNS_NXT_DATAA* {.pure.} = object
    pNameNext*: PSTR
    wNumTypes*: WORD
    wTypes*: array[1, WORD]
  PDNS_NXT_DATAA* = ptr DNS_NXT_DATAA
  DNS_SRV_DATAW* {.pure.} = object
    pNameTarget*: PWSTR
    wPriority*: WORD
    wWeight*: WORD
    wPort*: WORD
    Pad*: WORD
  PDNS_SRV_DATAW* = ptr DNS_SRV_DATAW
  DNS_SRV_DATAA* {.pure.} = object
    pNameTarget*: PSTR
    wPriority*: WORD
    wWeight*: WORD
    wPort*: WORD
    Pad*: WORD
  PDNS_SRV_DATAA* = ptr DNS_SRV_DATAA
const
  DNS_ATMA_MAX_ADDR_LENGTH* = 20
type
  DNS_ATMA_DATA* {.pure.} = object
    AddressType*: BYTE
    Address*: array[DNS_ATMA_MAX_ADDR_LENGTH , BYTE]
  PDNS_ATMA_DATA* = ptr DNS_ATMA_DATA
  DNS_TKEY_DATAW* {.pure.} = object
    pNameAlgorithm*: PWSTR
    pAlgorithmPacket*: PBYTE
    pKey*: PBYTE
    pOtherData*: PBYTE
    dwCreateTime*: DWORD
    dwExpireTime*: DWORD
    wMode*: WORD
    wError*: WORD
    wKeyLength*: WORD
    wOtherLength*: WORD
    cAlgNameLength*: UCHAR
    bPacketPointers*: WINBOOL
  PDNS_TKEY_DATAW* = ptr DNS_TKEY_DATAW
  DNS_TKEY_DATAA* {.pure.} = object
    pNameAlgorithm*: PSTR
    pAlgorithmPacket*: PBYTE
    pKey*: PBYTE
    pOtherData*: PBYTE
    dwCreateTime*: DWORD
    dwExpireTime*: DWORD
    wMode*: WORD
    wError*: WORD
    wKeyLength*: WORD
    wOtherLength*: WORD
    cAlgNameLength*: UCHAR
    bPacketPointers*: WINBOOL
  PDNS_TKEY_DATAA* = ptr DNS_TKEY_DATAA
  DNS_TSIG_DATAW* {.pure.} = object
    pNameAlgorithm*: PWSTR
    pAlgorithmPacket*: PBYTE
    pSignature*: PBYTE
    pOtherData*: PBYTE
    i64CreateTime*: LONGLONG
    wFudgeTime*: WORD
    wOriginalXid*: WORD
    wError*: WORD
    wSigLength*: WORD
    wOtherLength*: WORD
    cAlgNameLength*: UCHAR
    bPacketPointers*: WINBOOL
  PDNS_TSIG_DATAW* = ptr DNS_TSIG_DATAW
  DNS_TSIG_DATAA* {.pure.} = object
    pNameAlgorithm*: PSTR
    pAlgorithmPacket*: PBYTE
    pSignature*: PBYTE
    pOtherData*: PBYTE
    i64CreateTime*: LONGLONG
    wFudgeTime*: WORD
    wOriginalXid*: WORD
    wError*: WORD
    wSigLength*: WORD
    wOtherLength*: WORD
    cAlgNameLength*: UCHAR
    bPacketPointers*: WINBOOL
  PDNS_TSIG_DATAA* = ptr DNS_TSIG_DATAA
  DNS_WINS_DATA* {.pure.} = object
    dwMappingFlag*: DWORD
    dwLookupTimeout*: DWORD
    dwCacheTimeout*: DWORD
    cWinsServerCount*: DWORD
    WinsServers*: array[1, IP4_ADDRESS]
  PDNS_WINS_DATA* = ptr DNS_WINS_DATA
  DNS_WINSR_DATAW* {.pure.} = object
    dwMappingFlag*: DWORD
    dwLookupTimeout*: DWORD
    dwCacheTimeout*: DWORD
    pNameResultDomain*: PWSTR
  PDNS_WINSR_DATAW* = ptr DNS_WINSR_DATAW
  DNS_WINSR_DATAA* {.pure.} = object
    dwMappingFlag*: DWORD
    dwLookupTimeout*: DWORD
    dwCacheTimeout*: DWORD
    pNameResultDomain*: PSTR
  PDNS_WINSR_DATAA* = ptr DNS_WINSR_DATAA
  DNS_RECORD_FLAGS* {.pure.} = object
    Section* {.bitsize:2.}: DWORD
    Delete* {.bitsize:1.}: DWORD
    CharSet* {.bitsize:2.}: DWORD
    Unused* {.bitsize:3.}: DWORD
    Reserved* {.bitsize:24.}: DWORD
  DNS_RECORDW_Flags* {.pure, union.} = object
    DW*: DWORD
    S*: DNS_RECORD_FLAGS
  DNS_RECORDW_Data* {.pure, union.} = object
    A*: DNS_A_DATA
    SOA*: DNS_SOA_DATAW
    soa*: DNS_SOA_DATAW
    PTR*: DNS_PTR_DATAW
    `ptr`*: DNS_PTR_DATAW
    NS*: DNS_PTR_DATAW
    ns*: DNS_PTR_DATAW
    CNAME*: DNS_PTR_DATAW
    cname*: DNS_PTR_DATAW
    MB*: DNS_PTR_DATAW
    mb*: DNS_PTR_DATAW
    MD*: DNS_PTR_DATAW
    md*: DNS_PTR_DATAW
    MF*: DNS_PTR_DATAW
    mf*: DNS_PTR_DATAW
    MG*: DNS_PTR_DATAW
    mg*: DNS_PTR_DATAW
    MR*: DNS_PTR_DATAW
    mr*: DNS_PTR_DATAW
    MINFO*: DNS_MINFO_DATAW
    minfo*: DNS_MINFO_DATAW
    RP*: DNS_MINFO_DATAW
    rp*: DNS_MINFO_DATAW
    MX*: DNS_MX_DATAW
    mx*: DNS_MX_DATAW
    AFSDB*: DNS_MX_DATAW
    afsdb*: DNS_MX_DATAW
    RT*: DNS_MX_DATAW
    rt*: DNS_MX_DATAW
    HINFO*: DNS_TXT_DATAW
    hinfo*: DNS_TXT_DATAW
    ISDN*: DNS_TXT_DATAW
    isdn*: DNS_TXT_DATAW
    TXT*: DNS_TXT_DATAW
    txt*: DNS_TXT_DATAW
    X25*: DNS_TXT_DATAW
    Null*: DNS_NULL_DATA
    WKS*: DNS_WKS_DATA
    wks*: DNS_WKS_DATA
    AAAA*: DNS_AAAA_DATA
    KEY*: DNS_KEY_DATA
    key*: DNS_KEY_DATA
    SIG*: DNS_SIG_DATAW
    sig*: DNS_SIG_DATAW
    ATMA*: DNS_ATMA_DATA
    atma*: DNS_ATMA_DATA
    NXT*: DNS_NXT_DATAW
    nxt*: DNS_NXT_DATAW
    SRV*: DNS_SRV_DATAW
    srv*: DNS_SRV_DATAW
    TKEY*: DNS_TKEY_DATAW
    tkey*: DNS_TKEY_DATAW
    TSIG*: DNS_TSIG_DATAW
    tsig*: DNS_TSIG_DATAW
    WINS*: DNS_WINS_DATA
    wins*: DNS_WINS_DATA
    WINSR*: DNS_WINSR_DATAW
    winsr*: DNS_WINSR_DATAW
    NBSTAT*: DNS_WINSR_DATAW
    nbstat*: DNS_WINSR_DATAW
  DNS_RECORDW* {.pure.} = object
    pNext*: ptr DnsRecordW
    pName*: PWSTR
    wType*: WORD
    wDataLength*: WORD
    Flags*: DNS_RECORDW_Flags
    dwTtl*: DWORD
    dwReserved*: DWORD
    Data*: DNS_RECORDW_Data
  PDNS_RECORDW* = ptr DNS_RECORDW
  DNS_RECORDA_Flags* {.pure, union.} = object
    DW*: DWORD
    S*: DNS_RECORD_FLAGS
  DNS_RECORDA_Data* {.pure, union.} = object
    A*: DNS_A_DATA
    SOA*: DNS_SOA_DATAA
    soa*: DNS_SOA_DATAA
    PTR*: DNS_PTR_DATAA
    `ptr`*: DNS_PTR_DATAA
    NS*: DNS_PTR_DATAA
    ns*: DNS_PTR_DATAA
    CNAME*: DNS_PTR_DATAA
    cname*: DNS_PTR_DATAA
    MB*: DNS_PTR_DATAA
    mb*: DNS_PTR_DATAA
    MD*: DNS_PTR_DATAA
    md*: DNS_PTR_DATAA
    MF*: DNS_PTR_DATAA
    mf*: DNS_PTR_DATAA
    MG*: DNS_PTR_DATAA
    mg*: DNS_PTR_DATAA
    MR*: DNS_PTR_DATAA
    mr*: DNS_PTR_DATAA
    MINFO*: DNS_MINFO_DATAA
    minfo*: DNS_MINFO_DATAA
    RP*: DNS_MINFO_DATAA
    rp*: DNS_MINFO_DATAA
    MX*: DNS_MX_DATAA
    mx*: DNS_MX_DATAA
    AFSDB*: DNS_MX_DATAA
    afsdb*: DNS_MX_DATAA
    RT*: DNS_MX_DATAA
    rt*: DNS_MX_DATAA
    HINFO*: DNS_TXT_DATAA
    hinfo*: DNS_TXT_DATAA
    ISDN*: DNS_TXT_DATAA
    isdn*: DNS_TXT_DATAA
    TXT*: DNS_TXT_DATAA
    txt*: DNS_TXT_DATAA
    X25*: DNS_TXT_DATAA
    Null*: DNS_NULL_DATA
    WKS*: DNS_WKS_DATA
    wks*: DNS_WKS_DATA
    AAAA*: DNS_AAAA_DATA
    KEY*: DNS_KEY_DATA
    key*: DNS_KEY_DATA
    SIG*: DNS_SIG_DATAA
    sig*: DNS_SIG_DATAA
    ATMA*: DNS_ATMA_DATA
    atma*: DNS_ATMA_DATA
    NXT*: DNS_NXT_DATAA
    nxt*: DNS_NXT_DATAA
    SRV*: DNS_SRV_DATAA
    srv*: DNS_SRV_DATAA
    TKEY*: DNS_TKEY_DATAA
    tkey*: DNS_TKEY_DATAA
    TSIG*: DNS_TSIG_DATAA
    tsig*: DNS_TSIG_DATAA
    WINS*: DNS_WINS_DATA
    wins*: DNS_WINS_DATA
    WINSR*: DNS_WINSR_DATAA
    winsr*: DNS_WINSR_DATAA
    NBSTAT*: DNS_WINSR_DATAA
    nbstat*: DNS_WINSR_DATAA
  DNS_RECORDA* {.pure.} = object
    pNext*: ptr DnsRecordA
    pName*: PSTR
    wType*: WORD
    wDataLength*: WORD
    Flags*: DNS_RECORDA_Flags
    dwTtl*: DWORD
    dwReserved*: DWORD
    Data*: DNS_RECORDA_Data
  PDNS_RECORDA* = ptr DNS_RECORDA
when winimUnicode:
  type
    PDNS_RECORD* = ptr DNS_RECORDW
when winimAnsi:
  type
    PDNS_RECORD* = ptr DNS_RECORDA
type
  DNS_RRSET* {.pure.} = object
    pFirstRR*: PDNS_RECORD
    pLastRR*: PDNS_RECORD
  PDNS_RRSET* = ptr DNS_RRSET
  DNS_MESSAGE_BUFFER* {.pure, packed.} = object
    MessageHead*: DNS_HEADER
    MessageBody*: array[1, CHAR]
  PDNS_MESSAGE_BUFFER* = ptr DNS_MESSAGE_BUFFER
const
  SIZEOF_IP4_ADDRESS* = 4
  IP4_ADDRESS_STRING_LENGTH* = 15
  IP4_ADDRESS_STRING_BUFFER_LENGTH* = 16
  IP6_ADDRESS_STRING_LENGTH* = 47
  IP6_ADDRESS_STRING_BUFFER_LENGTH* = 48
  DNS_PORT_HOST_ORDER* = 0x0035
  DNS_PORT_NET_ORDER* = 0x3500
  DNS_RFC_MAX_UDP_PACKET_LENGTH* = 512
  DNS_MAX_NAME_LENGTH* = 255
  DNS_MAX_LABEL_LENGTH* = 63
  DNS_MAX_NAME_BUFFER_LENGTH* = 256
  DNS_MAX_LABEL_BUFFER_LENGTH* = 64
  DNS_IP4_REVERSE_DOMAIN_STRING_A* = "in-addr.arpa."
  DNS_IP4_REVERSE_DOMAIN_STRING_W* = "in-addr.arpa."
  DNS_MAX_IP4_REVERSE_NAME_LENGTH* = IP4_ADDRESS_STRING_LENGTH+1+(len(DNS_IP4_REVERSE_DOMAIN_STRING_A)+1)
  DNS_MAX_IP4_REVERSE_NAME_BUFFER_LENGTH* = DNS_MAX_IP4_REVERSE_NAME_LENGTH+1
  DNS_IP6_REVERSE_DOMAIN_STRING_A* = "ip6.arpa."
  DNS_IP6_REVERSE_DOMAIN_STRING_W* = "ip6.arpa."
  DNS_MAX_IP6_REVERSE_NAME_LENGTH* = 64+(len(DNS_IP6_REVERSE_DOMAIN_STRING_A)+1)
  DNS_MAX_IP6_REVERSE_NAME_BUFFER_LENGTH* = DNS_MAX_IP6_REVERSE_NAME_LENGTH+1
  DNS_MAX_REVERSE_NAME_LENGTH* = DNS_MAX_IP6_REVERSE_NAME_LENGTH
  DNS_MAX_REVERSE_NAME_BUFFER_LENGTH* = DNS_MAX_IP6_REVERSE_NAME_BUFFER_LENGTH
  DNS_MAX_TEXT_STRING_LENGTH* = 255
  DNS_COMPRESSED_QUESTION_NAME* = 0xC00C
  DNS_OPCODE_QUERY* = 0
  DNS_OPCODE_IQUERY* = 1
  DNS_OPCODE_SERVER_STATUS* = 2
  DNS_OPCODE_UNKNOWN* = 3
  DNS_OPCODE_NOTIFY* = 4
  DNS_OPCODE_UPDATE* = 5
  DNS_RCODE_NOERROR* = 0
  DNS_RCODE_FORMERR* = 1
  DNS_RCODE_SERVFAIL* = 2
  DNS_RCODE_NXDOMAIN* = 3
  DNS_RCODE_NOTIMPL* = 4
  DNS_RCODE_REFUSED* = 5
  DNS_RCODE_YXDOMAIN* = 6
  DNS_RCODE_YXRRSET* = 7
  DNS_RCODE_NXRRSET* = 8
  DNS_RCODE_NOTAUTH* = 9
  DNS_RCODE_NOTZONE* = 10
  DNS_RCODE_MAX* = 15
  DNS_RCODE_BADVERS* = 16
  DNS_RCODE_BADSIG* = 16
  DNS_RCODE_BADKEY* = 17
  DNS_RCODE_BADTIME* = 18
  DNS_RCODE_FORMAT_ERROR* = DNS_RCODE_FORMERR
  DNS_RCODE_SERVER_FAILURE* = DNS_RCODE_SERVFAIL
  DNS_RCODE_NAME_ERROR* = DNS_RCODE_NXDOMAIN
  DNS_RCODE_NOT_IMPLEMENTED* = DNS_RCODE_NOTIMPL
  DNS_CLASS_INTERNET* = 0x0001
  DNS_CLASS_CSNET* = 0x0002
  DNS_CLASS_CHAOS* = 0x0003
  DNS_CLASS_HESIOD* = 0x0004
  DNS_CLASS_NONE* = 0x00fe
  DNS_CLASS_ALL* = 0x00ff
  DNS_CLASS_ANY* = 0x00ff
  DNS_RCLASS_INTERNET* = 0x0100
  DNS_RCLASS_CSNET* = 0x0200
  DNS_RCLASS_CHAOS* = 0x0300
  DNS_RCLASS_HESIOD* = 0x0400
  DNS_RCLASS_NONE* = 0xfe00
  DNS_RCLASS_ALL* = 0xff00
  DNS_RCLASS_ANY* = 0xff00
  DNS_TYPE_ZERO* = 0x0000
  DNS_TYPE_A* = 0x0001
  DNS_TYPE_NS* = 0x0002
  DNS_TYPE_MD* = 0x0003
  DNS_TYPE_MF* = 0x0004
  DNS_TYPE_CNAME* = 0x0005
  DNS_TYPE_SOA* = 0x0006
  DNS_TYPE_MB* = 0x0007
  DNS_TYPE_MG* = 0x0008
  DNS_TYPE_MR* = 0x0009
  DNS_TYPE_NULL* = 0x000a
  DNS_TYPE_WKS* = 0x000b
  DNS_TYPE_PTR* = 0x000c
  DNS_TYPE_HINFO* = 0x000d
  DNS_TYPE_MINFO* = 0x000e
  DNS_TYPE_MX* = 0x000f
  DNS_TYPE_TEXT* = 0x0010
  DNS_TYPE_RP* = 0x0011
  DNS_TYPE_AFSDB* = 0x0012
  DNS_TYPE_X25* = 0x0013
  DNS_TYPE_ISDN* = 0x0014
  DNS_TYPE_RT* = 0x0015
  DNS_TYPE_NSAP* = 0x0016
  DNS_TYPE_NSAPPTR* = 0x0017
  DNS_TYPE_SIG* = 0x0018
  DNS_TYPE_KEY* = 0x0019
  DNS_TYPE_PX* = 0x001a
  DNS_TYPE_GPOS* = 0x001b
  DNS_TYPE_AAAA* = 0x001c
  DNS_TYPE_LOC* = 0x001d
  DNS_TYPE_NXT* = 0x001e
  DNS_TYPE_EID* = 0x001f
  DNS_TYPE_NIMLOC* = 0x0020
  DNS_TYPE_SRV* = 0x0021
  DNS_TYPE_ATMA* = 0x0022
  DNS_TYPE_NAPTR* = 0x0023
  DNS_TYPE_KX* = 0x0024
  DNS_TYPE_CERT* = 0x0025
  DNS_TYPE_A6* = 0x0026
  DNS_TYPE_DNAME* = 0x0027
  DNS_TYPE_SINK* = 0x0028
  DNS_TYPE_OPT* = 0x0029
  DNS_TYPE_UINFO* = 0x0064
  DNS_TYPE_UID* = 0x0065
  DNS_TYPE_GID* = 0x0066
  DNS_TYPE_UNSPEC* = 0x0067
  DNS_TYPE_ADDRS* = 0x00f8
  DNS_TYPE_TKEY* = 0x00f9
  DNS_TYPE_TSIG* = 0x00fa
  DNS_TYPE_IXFR* = 0x00fb
  DNS_TYPE_AXFR* = 0x00fc
  DNS_TYPE_MAILB* = 0x00fd
  DNS_TYPE_MAILA* = 0x00fe
  DNS_TYPE_ALL* = 0x00ff
  DNS_TYPE_ANY* = 0x00ff
  DNS_TYPE_WINS* = 0xff01
  DNS_TYPE_WINSR* = 0xff02
  DNS_TYPE_NBSTAT* = DNS_TYPE_WINSR
  DNS_RTYPE_A* = 0x0100
  DNS_RTYPE_NS* = 0x0200
  DNS_RTYPE_MD* = 0x0300
  DNS_RTYPE_MF* = 0x0400
  DNS_RTYPE_CNAME* = 0x0500
  DNS_RTYPE_SOA* = 0x0600
  DNS_RTYPE_MB* = 0x0700
  DNS_RTYPE_MG* = 0x0800
  DNS_RTYPE_MR* = 0x0900
  DNS_RTYPE_NULL* = 0x0a00
  DNS_RTYPE_WKS* = 0x0b00
  DNS_RTYPE_PTR* = 0x0c00
  DNS_RTYPE_HINFO* = 0x0d00
  DNS_RTYPE_MINFO* = 0x0e00
  DNS_RTYPE_MX* = 0x0f00
  DNS_RTYPE_TEXT* = 0x1000
  DNS_RTYPE_RP* = 0x1100
  DNS_RTYPE_AFSDB* = 0x1200
  DNS_RTYPE_X25* = 0x1300
  DNS_RTYPE_ISDN* = 0x1400
  DNS_RTYPE_RT* = 0x1500
  DNS_RTYPE_NSAP* = 0x1600
  DNS_RTYPE_NSAPPTR* = 0x1700
  DNS_RTYPE_SIG* = 0x1800
  DNS_RTYPE_KEY* = 0x1900
  DNS_RTYPE_PX* = 0x1a00
  DNS_RTYPE_GPOS* = 0x1b00
  DNS_RTYPE_AAAA* = 0x1c00
  DNS_RTYPE_LOC* = 0x1d00
  DNS_RTYPE_NXT* = 0x1e00
  DNS_RTYPE_EID* = 0x1f00
  DNS_RTYPE_NIMLOC* = 0x2000
  DNS_RTYPE_SRV* = 0x2100
  DNS_RTYPE_ATMA* = 0x2200
  DNS_RTYPE_NAPTR* = 0x2300
  DNS_RTYPE_KX* = 0x2400
  DNS_RTYPE_CERT* = 0x2500
  DNS_RTYPE_A6* = 0x2600
  DNS_RTYPE_DNAME* = 0x2700
  DNS_RTYPE_SINK* = 0x2800
  DNS_RTYPE_OPT* = 0x2900
  DNS_RTYPE_UINFO* = 0x6400
  DNS_RTYPE_UID* = 0x6500
  DNS_RTYPE_GID* = 0x6600
  DNS_RTYPE_UNSPEC* = 0x6700
  DNS_RTYPE_TKEY* = 0xf900
  DNS_RTYPE_TSIG* = 0xfa00
  DNS_RTYPE_IXFR* = 0xfb00
  DNS_RTYPE_AXFR* = 0xfc00
  DNS_RTYPE_MAILB* = 0xfd00
  DNS_RTYPE_MAILA* = 0xfe00
  DNS_RTYPE_ALL* = 0xff00
  DNS_RTYPE_ANY* = 0xff00
  DNS_RTYPE_WINS* = 0x01ff
  DNS_RTYPE_WINSR* = 0x02ff
  DNS_ATMA_FORMAT_E164* = 1
  DNS_ATMA_FORMAT_AESA* = 2
  DNS_ATMA_AESA_ADDR_LENGTH* = 20
  DNS_ATMA_MAX_RECORD_LENGTH* = DNS_ATMA_MAX_ADDR_LENGTH+1
  DNSSEC_ALGORITHM_RSAMD5* = 1
  DNSSEC_ALGORITHM_NULL* = 253
  DNSSEC_ALGORITHM_PRIVATE* = 254
  DNSSEC_PROTOCOL_NONE* = 0
  DNSSEC_PROTOCOL_TLS* = 1
  DNSSEC_PROTOCOL_EMAIL* = 2
  DNSSEC_PROTOCOL_DNSSEC* = 3
  DNSSEC_PROTOCOL_IPSEC* = 4
  DNSSEC_KEY_FLAG_NOAUTH* = 0x0001
  DNSSEC_KEY_FLAG_NOCONF* = 0x0002
  DNSSEC_KEY_FLAG_FLAG2* = 0x0004
  DNSSEC_KEY_FLAG_EXTEND* = 0x0008
  DNSSEC_KEY_FLAG_FLAG4* = 0x0010
  DNSSEC_KEY_FLAG_FLAG5* = 0x0020
  DNSSEC_KEY_FLAG_USER* = 0x0000
  DNSSEC_KEY_FLAG_ZONE* = 0x0040
  DNSSEC_KEY_FLAG_HOST* = 0x0080
  DNSSEC_KEY_FLAG_NTPE3* = 0x00c0
  DNSSEC_KEY_FLAG_FLAG8* = 0x0100
  DNSSEC_KEY_FLAG_FLAG9* = 0x0200
  DNSSEC_KEY_FLAG_FLAG10* = 0x0400
  DNSSEC_KEY_FLAG_FLAG11* = 0x0800
  DNSSEC_KEY_FLAG_SIG0* = 0x0000
  DNSSEC_KEY_FLAG_SIG1* = 0x1000
  DNSSEC_KEY_FLAG_SIG2* = 0x2000
  DNSSEC_KEY_FLAG_SIG3* = 0x3000
  DNSSEC_KEY_FLAG_SIG4* = 0x4000
  DNSSEC_KEY_FLAG_SIG5* = 0x5000
  DNSSEC_KEY_FLAG_SIG6* = 0x6000
  DNSSEC_KEY_FLAG_SIG7* = 0x7000
  DNSSEC_KEY_FLAG_SIG8* = 0x8000
  DNSSEC_KEY_FLAG_SIG9* = 0x9000
  DNSSEC_KEY_FLAG_SIG10* = 0xa000
  DNSSEC_KEY_FLAG_SIG11* = 0xb000
  DNSSEC_KEY_FLAG_SIG12* = 0xc000
  DNSSEC_KEY_FLAG_SIG13* = 0xd000
  DNSSEC_KEY_FLAG_SIG14* = 0xe000
  DNSSEC_KEY_FLAG_SIG15* = 0xf000
  DNS_TKEY_MODE_SERVER_ASSIGN* = 1
  DNS_TKEY_MODE_DIFFIE_HELLMAN* = 2
  DNS_TKEY_MODE_GSS* = 3
  DNS_TKEY_MODE_RESOLVER_ASSIGN* = 4
  DNS_WINS_FLAG_SCOPE* = 0x80000000'i32
  DNS_WINS_FLAG_LOCAL* = 0x00010000
  DnsConfigPrimaryDomainName_W* = 0
  DnsConfigPrimaryDomainName_A* = 1
  DnsConfigPrimaryDomainName_UTF8* = 2
  DnsConfigAdapterDomainName_W* = 3
  DnsConfigAdapterDomainName_A* = 4
  DnsConfigAdapterDomainName_UTF8* = 5
  dnsConfigDnsServerList* = 6
  dnsConfigSearchList* = 7
  dnsConfigAdapterInfo* = 8
  dnsConfigPrimaryHostNameRegistrationEnabled* = 9
  dnsConfigAdapterHostNameRegistrationEnabled* = 10
  dnsConfigAddressRegistrationMaxCount* = 11
  DnsConfigHostName_W* = 12
  DnsConfigHostName_A* = 13
  DnsConfigHostName_UTF8* = 14
  DnsConfigFullHostName_W* = 15
  DnsConfigFullHostName_A* = 16
  DnsConfigFullHostName_UTF8* = 17
  DNS_CONFIG_FLAG_ALLOC* = 0x00000001
  dnsSectionQuestion* = 0
  dnsSectionAnswer* = 1
  dnsSectionAuthority* = 2
  dnsSectionAddtional* = 3
  dnsSectionZone* = dnsSectionQuestion
  dnsSectionPrereq* = dnsSectionAnswer
  dnsSectionUpdate* = dnsSectionAuthority
  DNSREC_SECTION* = 0x00000003
  DNSREC_QUESTION* = 0x00000000
  DNSREC_ANSWER* = 0x00000001
  DNSREC_AUTHORITY* = 0x00000002
  DNSREC_ADDITIONAL* = 0x00000003
  DNSREC_ZONE* = 0x00000000
  DNSREC_PREREQ* = 0x00000001
  DNSREC_UPDATE* = 0x00000002
  DNSREC_DELETE* = 0x00000004
  DNSREC_NOEXIST* = 0x00000004
  DNS_RECORD_FIXED_SIZE* = 32
  SIZEOF_DNS_RECORD_HEADER* = DNS_RECORD_FIXED_SIZE
  dnsCharSetUnknown* = 0
  dnsCharSetUnicode* = 1
  dnsCharSetUtf8* = 2
  dnsCharSetAnsi* = 3
  dnsFreeFlat* = 0
  dnsFreeRecordList* = 1
  dnsFreeParsedMessageFields* = 2
  dnsFreeRecordListDeep* = dnsFreeRecordList
  DNS_QUERY_STANDARD* = 0x00000000
  DNS_QUERY_ACCEPT_TRUNCATED_RESPONSE* = 0x00000001
  DNS_QUERY_USE_TCP_ONLY* = 0x00000002
  DNS_QUERY_NO_RECURSION* = 0x00000004
  DNS_QUERY_BYPASS_CACHE* = 0x00000008
  DNS_QUERY_NO_WIRE_QUERY* = 0x00000010
  DNS_QUERY_NO_LOCAL_NAME* = 0x00000020
  DNS_QUERY_NO_HOSTS_FILE* = 0x00000040
  DNS_QUERY_NO_NETBT* = 0x00000080
  DNS_QUERY_WIRE_ONLY* = 0x00000100
  DNS_QUERY_RETURN_MESSAGE* = 0x00000200
  DNS_QUERY_MULTICAST_ONLY* = 0x00000400
  DNS_QUERY_NO_MULTICAST* = 0x00000800
  DNS_QUERY_TREAT_AS_FQDN* = 0x00001000
  DNS_QUERY_APPEND_MULTILABEL* = 0x00800000
  DNS_QUERY_DONT_RESET_TTL_VALUES* = 0x00100000
  DNS_QUERY_RESERVED* = 0xff000000'i32
  DNS_QUERY_CACHE_ONLY* = DNS_QUERY_NO_WIRE_QUERY
  DNS_UPDATE_SECURITY_USE_DEFAULT* = 0x00000000
  DNS_UPDATE_SECURITY_OFF* = 0x00000010
  DNS_UPDATE_SECURITY_ON* = 0x00000020
  DNS_UPDATE_SECURITY_ONLY* = 0x00000100
  DNS_UPDATE_CACHE_SECURITY_CONTEXT* = 0x00000200
  DNS_UPDATE_TEST_USE_LOCAL_SYS_ACCT* = 0x00000400
  DNS_UPDATE_FORCE_SECURITY_NEGO* = 0x00000800
  DNS_UPDATE_TRY_ALL_MASTER_SERVERS* = 0x00001000
  DNS_UPDATE_SKIP_NO_UPDATE_ADAPTERS* = 0x00002000
  DNS_UPDATE_REMOTE_SERVER* = 0x00004000
  DNS_UPDATE_RESERVED* = 0xffff0000'i32
  dnsNameDomain* = 0
  dnsNameDomainLabel* = 1
  dnsNameHostnameFull* = 2
  dnsNameHostnameLabel* = 3
  dnsNameWildcard* = 4
  dnsNameSrvRecord* = 5
  DNS_OFFSET_TO_QUESTION_NAME* = 12
proc DnsQueryConfig*(Config: DNS_CONFIG_TYPE, Flag: DWORD, pwsAdapterName: PWSTR, pReserved: PVOID, pBuffer: PVOID, pBufferLength: PDWORD): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsRecordCopyEx*(pRecord: PDNS_RECORD, CharSetIn: DNS_CHARSET, CharSetOut: DNS_CHARSET): PDNS_RECORD {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsRecordSetCopyEx*(pRecordSet: PDNS_RECORD, CharSetIn: DNS_CHARSET, CharSetOut: DNS_CHARSET): PDNS_RECORD {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsRecordCompare*(pRecord1: PDNS_RECORD, pRecord2: PDNS_RECORD): WINBOOL {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsRecordSetCompare*(pRR1: PDNS_RECORD, pRR2: PDNS_RECORD, ppDiff1: ptr PDNS_RECORD, ppDiff2: ptr PDNS_RECORD): WINBOOL {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsRecordSetDetach*(pRecordList: PDNS_RECORD): PDNS_RECORD {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsFree*(pData: PVOID, FreeType: DNS_FREE_TYPE): VOID {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsRecordListFree*(pRecordList: PDNS_RECORD, FreeType: DNS_FREE_TYPE): VOID {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsQuery_A*(pszName: PCSTR, wType: WORD, Options: DWORD, aipServers: PIP4_ARRAY, ppQueryResults: ptr PDNS_RECORD, pReserved: ptr PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsQuery_UTF8*(pszName: PCSTR, wType: WORD, Options: DWORD, aipServers: PIP4_ARRAY, ppQueryResults: ptr PDNS_RECORDA, pReserved: ptr PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsQuery_W*(pszName: PCWSTR, wType: WORD, Options: DWORD, aipServers: PIP4_ARRAY, ppQueryResults: ptr PDNS_RECORD, pReserved: ptr PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsAcquireContextHandle_W*(CredentialFlags: DWORD, pCredentials: PVOID, pContextHandle: PHANDLE): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsAcquireContextHandle_A*(CredentialFlags: DWORD, pCredentials: PVOID, pContextHandle: PHANDLE): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsReleaseContextHandle*(hContext: HANDLE): VOID {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsModifyRecordsInSet_W*(pAddRecords: PDNS_RECORD, pDeleteRecords: PDNS_RECORD, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsModifyRecordsInSet_A*(pAddRecords: PDNS_RECORD, pDeleteRecords: PDNS_RECORD, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsModifyRecordsInSet_UTF8*(pAddRecords: PDNS_RECORDA, pDeleteRecords: PDNS_RECORDA, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsReplaceRecordSetW*(pNewSet: PDNS_RECORD, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsReplaceRecordSetA*(pNewSet: PDNS_RECORD, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsReplaceRecordSetUTF8*(pNewSet: PDNS_RECORDA, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsValidateName_UTF8*(pszName: LPCSTR, Format: DNS_NAME_FORMAT): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsValidateName_W*(pwszName: LPCWSTR, Format: DNS_NAME_FORMAT): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsValidateName_A*(pszName: LPCSTR, Format: DNS_NAME_FORMAT): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsNameCompare_A*(pName1: LPSTR, pName2: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsNameCompare_W*(pName1: LPWSTR, pName2: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsWriteQuestionToBuffer_W*(pDnsBuffer: PDNS_MESSAGE_BUFFER, pdwBufferSize: PDWORD, pszName: LPWSTR, wType: WORD, Xid: WORD, fRecursionDesired: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsWriteQuestionToBuffer_UTF8*(pDnsBuffer: PDNS_MESSAGE_BUFFER, pdwBufferSize: LPDWORD, pszName: LPSTR, wType: WORD, Xid: WORD, fRecursionDesired: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsExtractRecordsFromMessage_W*(pDnsBuffer: PDNS_MESSAGE_BUFFER, wMessageLength: WORD, ppRecord: ptr PDNS_RECORD): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
proc DnsExtractRecordsFromMessage_UTF8*(pDnsBuffer: PDNS_MESSAGE_BUFFER, wMessageLength: WORD, ppRecord: ptr PDNS_RECORDA): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc.}
when winimUnicode:
  type
    DNS_RECORD* = DNS_RECORDW
    DNS_PTR_DATA* = DNS_PTR_DATAW
    PDNS_PTR_DATA* = PDNS_PTR_DATAW
    DNS_SOA_DATA* = DNS_SOA_DATAW
    PDNS_SOA_DATA* = PDNS_SOA_DATAW
    DNS_MINFO_DATA* = DNS_MINFO_DATAW
    PDNS_MINFO_DATA* = PDNS_MINFO_DATAW
    DNS_MX_DATA* = DNS_MX_DATAW
    PDNS_MX_DATA* = PDNS_MX_DATAW
    DNS_TXT_DATA* = DNS_TXT_DATAW
    PDNS_TXT_DATA* = PDNS_TXT_DATAW
    DNS_SIG_DATA* = DNS_SIG_DATAW
    PDNS_SIG_DATA* = PDNS_SIG_DATAW
    DNS_NXT_DATA* = DNS_NXT_DATAW
    PDNS_NXT_DATA* = PDNS_NXT_DATAW
    DNS_SRV_DATA* = DNS_SRV_DATAW
    PDNS_SRV_DATA* = PDNS_SRV_DATAW
    DNS_TKEY_DATA* = DNS_TKEY_DATAW
    PDNS_TKEY_DATA* = PDNS_TKEY_DATAW
    DNS_TSIG_DATA* = DNS_TSIG_DATAW
    PDNS_TSIG_DATA* = PDNS_TSIG_DATAW
    DNS_WINSR_DATA* = DNS_WINSR_DATAW
    PDNS_WINSR_DATA* = PDNS_WINSR_DATAW
  const
    DNS_IP4_REVERSE_DOMAIN_STRING* = DNS_IP4_REVERSE_DOMAIN_STRING_W
    DNS_IP6_REVERSE_DOMAIN_STRING* = DNS_IP6_REVERSE_DOMAIN_STRING_W
  proc DnsQuery*(pszName: PCWSTR, wType: WORD, Options: DWORD, aipServers: PIP4_ARRAY, ppQueryResults: ptr PDNS_RECORD, pReserved: ptr PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc: "DnsQuery_W".}
  proc DnsAcquireContextHandle*(CredentialFlags: DWORD, pCredentials: PVOID, pContextHandle: PHANDLE): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc: "DnsAcquireContextHandle_W".}
  proc DnsModifyRecordsInSet*(pAddRecords: PDNS_RECORD, pDeleteRecords: PDNS_RECORD, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc: "DnsModifyRecordsInSet_W".}
  proc DnsReplaceRecordSet*(pNewSet: PDNS_RECORD, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc: "DnsReplaceRecordSetW".}
when winimAnsi:
  type
    DNS_RECORD* = DNS_RECORDA
    DNS_PTR_DATA* = DNS_PTR_DATAA
    PDNS_PTR_DATA* = PDNS_PTR_DATAA
    DNS_SOA_DATA* = DNS_SOA_DATAA
    PDNS_SOA_DATA* = PDNS_SOA_DATAA
    DNS_MINFO_DATA* = DNS_MINFO_DATAA
    PDNS_MINFO_DATA* = PDNS_MINFO_DATAA
    DNS_MX_DATA* = DNS_MX_DATAA
    PDNS_MX_DATA* = PDNS_MX_DATAA
    DNS_TXT_DATA* = DNS_TXT_DATAA
    PDNS_TXT_DATA* = PDNS_TXT_DATAA
    DNS_SIG_DATA* = DNS_SIG_DATAA
    PDNS_SIG_DATA* = PDNS_SIG_DATAA
    DNS_NXT_DATA* = DNS_NXT_DATAA
    PDNS_NXT_DATA* = PDNS_NXT_DATAA
    DNS_SRV_DATA* = DNS_SRV_DATAA
    PDNS_SRV_DATA* = PDNS_SRV_DATAA
    DNS_TKEY_DATA* = DNS_TKEY_DATAA
    PDNS_TKEY_DATA* = PDNS_TKEY_DATAA
    DNS_TSIG_DATA* = DNS_TSIG_DATAA
    PDNS_TSIG_DATA* = PDNS_TSIG_DATAA
    DNS_WINSR_DATA* = DNS_WINSR_DATAA
    PDNS_WINSR_DATA* = PDNS_WINSR_DATAA
  const
    DNS_IP4_REVERSE_DOMAIN_STRING* = DNS_IP4_REVERSE_DOMAIN_STRING_A
    DNS_IP6_REVERSE_DOMAIN_STRING* = DNS_IP6_REVERSE_DOMAIN_STRING_A
  proc DnsQuery*(pszName: PCSTR, wType: WORD, Options: DWORD, aipServers: PIP4_ARRAY, ppQueryResults: ptr PDNS_RECORD, pReserved: ptr PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc: "DnsQuery_A".}
  proc DnsAcquireContextHandle*(CredentialFlags: DWORD, pCredentials: PVOID, pContextHandle: PHANDLE): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc: "DnsAcquireContextHandle_A".}
  proc DnsModifyRecordsInSet*(pAddRecords: PDNS_RECORD, pDeleteRecords: PDNS_RECORD, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc: "DnsModifyRecordsInSet_A".}
  proc DnsReplaceRecordSet*(pNewSet: PDNS_RECORD, Options: DWORD, hContext: HANDLE, pServerList: PIP4_ARRAY, pReserved: PVOID): DNS_STATUS {.winapi, stdcall, dynlib: "dnsapi", importc: "DnsReplaceRecordSetA".}
