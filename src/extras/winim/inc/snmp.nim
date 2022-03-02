#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <snmp.h>
type
  AsnInteger32* = LONG
  AsnUnsigned32* = ULONG
  AsnCounter64* = ULARGE_INTEGER
  AsnCounter32* = AsnUnsigned32
  AsnGauge32* = AsnUnsigned32
  AsnTimeticks* = AsnUnsigned32
  AsnOctetString* {.pure.} = object
    stream*: ptr BYTE
    length*: UINT
    dynamic*: WINBOOL
  AsnBits* = AsnOctetString
  AsnSequence* = AsnOctetString
  AsnImplicitSequence* = AsnOctetString
  AsnIPAddress* = AsnOctetString
  AsnNetworkAddress* = AsnOctetString
  AsnDisplayString* = AsnOctetString
  AsnOpaque* = AsnOctetString
  AsnObjectIdentifier* {.pure, packed.} = object
    idLength*: UINT
    ids*: ptr UINT
  AsnObjectName* = AsnObjectIdentifier
  AsnAny_asnValue* {.pure, union.} = object
    number*: AsnInteger32
    unsigned32*: AsnUnsigned32
    counter64*: AsnCounter64
    string*: AsnOctetString
    bits*: AsnBits
    `object`*: AsnObjectIdentifier
    sequence*: AsnSequence
    address*: AsnIPAddress
    counter*: AsnCounter32
    gauge*: AsnGauge32
    ticks*: AsnTimeticks
    arbitrary*: AsnOpaque
  AsnAny* {.pure, packed.} = object
    asnType*: BYTE
    padding*: array[3, byte]
    asnValue*: AsnAny_asnValue
  AsnObjectSyntax* = AsnAny
  SnmpVarBind* {.pure.} = object
    name*: AsnObjectName
    value*: AsnObjectSyntax
  SnmpVarBindList* {.pure, packed.} = object
    list*: ptr SnmpVarBind
    len*: UINT
  RFC1157VarBindList* = SnmpVarBindList
  RFC1157VarBind* = SnmpVarBind
  AsnInteger* = AsnInteger32
  AsnCounter* = AsnCounter32
  AsnGauge* = AsnGauge32
const
  asnUNIVERSAL* = 0x00
  asnAPPLICATION* = 0x40
  asnCONTEXT* = 0x80
  asnPRIVATE* = 0xC0
  asnPRIMITIVE* = 0x00
  asnCONSTRUCTOR* = 0x20
  SNMP_PDU_GET* = asnCONTEXT or asnCONSTRUCTOR or 0x0
  SNMP_PDU_GETNEXT* = asnCONTEXT or asnCONSTRUCTOR or 0x1
  SNMP_PDU_RESPONSE* = asnCONTEXT or asnCONSTRUCTOR or 0x2
  SNMP_PDU_SET* = asnCONTEXT or asnCONSTRUCTOR or 0x3
  SNMP_PDU_V1TRAP* = asnCONTEXT or asnCONSTRUCTOR or 0x4
  SNMP_PDU_GETBULK* = asnCONTEXT or asnCONSTRUCTOR or 0x5
  SNMP_PDU_INFORM* = asnCONTEXT or asnCONSTRUCTOR or 0x6
  SNMP_PDU_TRAP* = asnCONTEXT or asnCONSTRUCTOR or 0x7
  asnINTEGER* = asnUNIVERSAL or asnPRIMITIVE or 0x02
  asnBITS* = asnUNIVERSAL or asnPRIMITIVE or 0x03
  asnOCTETSTRING* = asnUNIVERSAL or asnPRIMITIVE or 0x04
  asnNULL* = asnUNIVERSAL or asnPRIMITIVE or 0x05
  asnOBJECTIDENTIFIER* = asnUNIVERSAL or asnPRIMITIVE or 0x06
  asnINTEGER32* = asnINTEGER
  asnSEQUENCE* = asnUNIVERSAL or asnCONSTRUCTOR or 0x10
  asnSEQUENCEOF* = asnSEQUENCE
  asnIPADDRESS* = asnAPPLICATION or asnPRIMITIVE or 0x00
  asnCOUNTER32* = asnAPPLICATION or asnPRIMITIVE or 0x01
  asnGAUGE32* = asnAPPLICATION or asnPRIMITIVE or 0x02
  asnTIMETICKS* = asnAPPLICATION or asnPRIMITIVE or 0x03
  asnOPAQUE* = asnAPPLICATION or asnPRIMITIVE or 0x04
  asnCOUNTER64* = asnAPPLICATION or asnPRIMITIVE or 0x06
  asnUINTEGER32* = asnAPPLICATION or asnPRIMITIVE or 0x07
  asnRFC2578_UNSIGNED32* = asnGAUGE32
  SNMP_EXCEPTION_NOSUCHOBJECT* = asnCONTEXT or asnPRIMITIVE or 0x00
  SNMP_EXCEPTION_NOSUCHINSTANCE* = asnCONTEXT or asnPRIMITIVE or 0x01
  SNMP_EXCEPTION_ENDOFMIBVIEW* = asnCONTEXT or asnPRIMITIVE or 0x02
  SNMP_EXTENSION_GET* = SNMP_PDU_GET
  SNMP_EXTENSION_GET_NEXT* = SNMP_PDU_GETNEXT
  SNMP_EXTENSION_GET_BULK* = SNMP_PDU_GETBULK
  SNMP_EXTENSION_SET_TEST* = asnPRIVATE or asnCONSTRUCTOR or 0x0
  SNMP_EXTENSION_SET_COMMIT* = SNMP_PDU_SET
  SNMP_EXTENSION_SET_UNDO* = asnPRIVATE or asnCONSTRUCTOR or 0x1
  SNMP_EXTENSION_SET_CLEANUP* = asnPRIVATE or asnCONSTRUCTOR or 0x2
  SNMP_ERRORSTATUS_NOERROR* = 0
  SNMP_ERRORSTATUS_TOOBIG* = 1
  SNMP_ERRORSTATUS_NOSUCHNAME* = 2
  SNMP_ERRORSTATUS_BADVALUE* = 3
  SNMP_ERRORSTATUS_READONLY* = 4
  SNMP_ERRORSTATUS_GENERR* = 5
  SNMP_ERRORSTATUS_NOACCESS* = 6
  SNMP_ERRORSTATUS_WRONGTYPE* = 7
  SNMP_ERRORSTATUS_WRONGLENGTH* = 8
  SNMP_ERRORSTATUS_WRONGENCODING* = 9
  SNMP_ERRORSTATUS_WRONGVALUE* = 10
  SNMP_ERRORSTATUS_NOCREATION* = 11
  SNMP_ERRORSTATUS_INCONSISTENTVALUE* = 12
  SNMP_ERRORSTATUS_RESOURCEUNAVAILABLE* = 13
  SNMP_ERRORSTATUS_COMMITFAILED* = 14
  SNMP_ERRORSTATUS_UNDOFAILED* = 15
  SNMP_ERRORSTATUS_AUTHORIZATIONERROR* = 16
  SNMP_ERRORSTATUS_NOTWRITABLE* = 17
  SNMP_ERRORSTATUS_INCONSISTENTNAME* = 18
  SNMP_GENERICTRAP_COLDSTART* = 0
  SNMP_GENERICTRAP_WARMSTART* = 1
  SNMP_GENERICTRAP_LINKDOWN* = 2
  SNMP_GENERICTRAP_LINKUP* = 3
  SNMP_GENERICTRAP_AUTHFAILURE* = 4
  SNMP_GENERICTRAP_EGPNEIGHLOSS* = 5
  SNMP_GENERICTRAP_ENTERSPECIFIC* = 6
  SNMP_ACCESS_NONE* = 0
  SNMP_ACCESS_NOTIFY* = 1
  SNMP_ACCESS_READ_ONLY* = 2
  SNMP_ACCESS_READ_WRITE* = 3
  SNMP_ACCESS_READ_CREATE* = 4
  SNMPAPI_NOERROR* = TRUE
  SNMPAPI_ERROR* = FALSE
  SNMP_LOG_SILENT* = 0x0
  SNMP_LOG_FATAL* = 0x1
  SNMP_LOG_ERROR* = 0x2
  SNMP_LOG_WARNING* = 0x3
  SNMP_LOG_TRACE* = 0x4
  SNMP_LOG_VERBOSE* = 0x5
  SNMP_OUTPUT_TO_CONSOLE* = 0x1
  SNMP_OUTPUT_TO_LOGFILE* = 0x2
  SNMP_OUTPUT_TO_EVENTLOG* = 0x4
  SNMP_OUTPUT_TO_DEBUGGER* = 0x8
  DEFAULT_SNMP_PORT_UDP* = 161
  DEFAULT_SNMP_PORT_IPX* = 36879
  DEFAULT_SNMPTRAP_PORT_UDP* = 162
  DEFAULT_SNMPTRAP_PORT_IPX* = 36880
  SNMP_MAX_OID_LEN* = 128
  SNMP_MEM_ALLOC_ERROR* = 1
  SNMP_BERAPI_INVALID_LENGTH* = 10
  SNMP_BERAPI_INVALID_TAG* = 11
  SNMP_BERAPI_OVERFLOW* = 12
  SNMP_BERAPI_SHORT_BUFFER* = 13
  SNMP_BERAPI_INVALID_OBJELEM* = 14
  SNMP_PDUAPI_UNRECOGNIZED_PDU* = 20
  SNMP_PDUAPI_INVALID_ES* = 21
  SNMP_PDUAPI_INVALID_GT* = 22
  SNMP_AUTHAPI_INVALID_VERSION* = 30
  SNMP_AUTHAPI_INVALID_MSG_TYPE* = 31
  SNMP_AUTHAPI_TRIV_AUTH_FAILED* = 32
  asnRFC1155_IPADDRESS* = asnIPADDRESS
  asnRFC1155_COUNTER* = asnCOUNTER32
  asnRFC1155_GAUGE* = asnGAUGE32
  asnRFC1155_TIMETICKS* = asnTIMETICKS
  asnRFC1155_OPAQUE* = asnOPAQUE
  asnRFC1213_DISPSTRING* = asnOCTETSTRING
  asnRFC1157_GETREQUEST* = SNMP_PDU_GET
  asnRFC1157_GETNEXTREQUEST* = SNMP_PDU_GETNEXT
  asnRFC1157_GETRESPONSE* = SNMP_PDU_RESPONSE
  asnRFC1157_SETREQUEST* = SNMP_PDU_SET
  asnRFC1157_TRAP* = SNMP_PDU_V1TRAP
  asnCONTEXTSPECIFIC* = asnCONTEXT
  asnPRIMATIVE* = asnPRIMITIVE
  asnUNSIGNED32* = asnUINTEGER32
type
  SnmpExtensionInit* = proc (dwUptimeReference: DWORD, phSubagentTrapEvent: ptr HANDLE, pFirstSupportedRegion: ptr AsnObjectIdentifier): WINBOOL {.stdcall.}
  SnmpExtensionInitEx* = proc (pNextSupportedRegion: ptr AsnObjectIdentifier): WINBOOL {.stdcall.}
  SnmpExtensionMonitor* = proc (pAgentMgmtData: LPVOID): WINBOOL {.stdcall.}
  SnmpExtensionQuery* = proc (bPduType: BYTE, pVarBindList: ptr SnmpVarBindList, pErrorStatus: ptr AsnInteger32, pErrorIndex: ptr AsnInteger32): WINBOOL {.stdcall.}
  SnmpExtensionQueryEx* = proc (nRequestType: UINT, nTransactionId: UINT, pVarBindList: ptr SnmpVarBindList, pContextInfo: ptr AsnOctetString, pErrorStatus: ptr AsnInteger32, pErrorIndex: ptr AsnInteger32): WINBOOL {.stdcall.}
  SnmpExtensionTrap* = proc (pEnterpriseOid: ptr AsnObjectIdentifier, pGenericTrapId: ptr AsnInteger32, pSpecificTrapId: ptr AsnInteger32, pTimeStamp: ptr AsnTimeticks, pVarBindList: ptr SnmpVarBindList): WINBOOL {.stdcall.}
  SnmpExtensionClose* = proc (): VOID {.stdcall.}
  PFNSNMPEXTENSIONINIT* = proc (dwUpTimeReference: DWORD, phSubagentTrapEvent: ptr HANDLE, pFirstSupportedRegion: ptr AsnObjectIdentifier): WINBOOL {.stdcall.}
  PFNSNMPEXTENSIONINITEX* = proc (pNextSupportedRegion: ptr AsnObjectIdentifier): WINBOOL {.stdcall.}
  PFNSNMPEXTENSIONMONITOR* = proc (pAgentMgmtData: LPVOID): WINBOOL {.stdcall.}
  PFNSNMPEXTENSIONQUERY* = proc (bPduType: BYTE, pVarBindList: ptr SnmpVarBindList, pErrorStatus: ptr AsnInteger32, pErrorIndex: ptr AsnInteger32): WINBOOL {.stdcall.}
  PFNSNMPEXTENSIONQUERYEX* = proc (nRequestType: UINT, nTransactionId: UINT, pVarBindList: ptr SnmpVarBindList, pContextInfo: ptr AsnOctetString, pErrorStatus: ptr AsnInteger32, pErrorIndex: ptr AsnInteger32): WINBOOL {.stdcall.}
  PFNSNMPEXTENSIONTRAP* = proc (pEnterpriseOid: ptr AsnObjectIdentifier, pGenericTrapId: ptr AsnInteger32, pSpecificTrapId: ptr AsnInteger32, pTimeStamp: ptr AsnTimeticks, pVarBindList: ptr SnmpVarBindList): WINBOOL {.stdcall.}
  PFNSNMPEXTENSIONCLOSE* = proc (): VOID {.stdcall.}
proc SnmpUtilOidCpy*(pOidDst: ptr AsnObjectIdentifier, pOidSrc: ptr AsnObjectIdentifier): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOidAppend*(pOidDst: ptr AsnObjectIdentifier, pOidSrc: ptr AsnObjectIdentifier): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOidNCmp*(pOid1: ptr AsnObjectIdentifier, pOid2: ptr AsnObjectIdentifier, nSubIds: UINT): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOidCmp*(pOid1: ptr AsnObjectIdentifier, pOid2: ptr AsnObjectIdentifier): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOidFree*(pOid: ptr AsnObjectIdentifier): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOctetsCmp*(pOctets1: ptr AsnOctetString, pOctets2: ptr AsnOctetString): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOctetsNCmp*(pOctets1: ptr AsnOctetString, pOctets2: ptr AsnOctetString, nChars: UINT): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOctetsCpy*(pOctetsDst: ptr AsnOctetString, pOctetsSrc: ptr AsnOctetString): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOctetsFree*(pOctets: ptr AsnOctetString): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilAsnAnyCpy*(pAnyDst: ptr AsnAny, pAnySrc: ptr AsnAny): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilAsnAnyFree*(pAny: ptr AsnAny): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilVarBindCpy*(pVbDst: ptr SnmpVarBind, pVbSrc: ptr SnmpVarBind): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilVarBindFree*(pVb: ptr SnmpVarBind): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilVarBindListCpy*(pVblDst: ptr SnmpVarBindList, pVblSrc: ptr SnmpVarBindList): INT {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilVarBindListFree*(pVbl: ptr SnmpVarBindList): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilMemFree*(pMem: LPVOID): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilMemAlloc*(nBytes: UINT): LPVOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilMemReAlloc*(pMem: LPVOID, nBytes: UINT): LPVOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilOidToA*(Oid: ptr AsnObjectIdentifier): LPSTR {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilIdsToA*(Ids: ptr UINT, IdLength: UINT): LPSTR {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilPrintOid*(Oid: ptr AsnObjectIdentifier): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilPrintAsnAny*(pAny: ptr AsnAny): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpSvcGetUptime*(): DWORD {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpSvcSetLogLevel*(nLogLevel: INT): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpSvcSetLogType*(nLogType: INT): VOID {.winapi, stdcall, dynlib: "snmpapi", importc.}
proc SnmpUtilDbgPrint*(nLogLevel: INT, szFormat: LPSTR): VOID {.winapi, cdecl, varargs, dynlib: "snmpapi", importc.}
proc SNMP_oidcpy*(pOidDst: ptr AsnObjectIdentifier, pOidSrc: ptr AsnObjectIdentifier): INT {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilOidCpy".}
proc SNMP_oidappend*(pOidDst: ptr AsnObjectIdentifier, pOidSrc: ptr AsnObjectIdentifier): INT {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilOidAppend".}
proc SNMP_oidncmp*(pOid1: ptr AsnObjectIdentifier, pOid2: ptr AsnObjectIdentifier, nSubIds: UINT): INT {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilOidNCmp".}
proc SNMP_oidcmp*(pOid1: ptr AsnObjectIdentifier, pOid2: ptr AsnObjectIdentifier): INT {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilOidCmp".}
proc SNMP_oidfree*(pOid: ptr AsnObjectIdentifier): VOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilOidFree".}
proc SNMP_CopyVarBindList*(pVblDst: ptr SnmpVarBindList, pVblSrc: ptr SnmpVarBindList): INT {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilVarBindListCpy".}
proc SNMP_FreeVarBindList*(pVbl: ptr SnmpVarBindList): VOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilVarBindListFree".}
proc SNMP_CopyVarBind*(pVbDst: ptr SnmpVarBind, pVbSrc: ptr SnmpVarBind): INT {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilVarBindCpy".}
proc SNMP_FreeVarBind*(pVb: ptr SnmpVarBind): VOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilVarBindFree".}
proc SNMP_printany*(pAny: ptr AsnAny): VOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilPrintAsnAny".}
proc SNMP_free*(pMem: LPVOID): VOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilMemFree".}
proc SNMP_malloc*(nBytes: UINT): LPVOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilMemAlloc".}
proc SNMP_realloc*(pMem: LPVOID, nBytes: UINT): LPVOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilMemReAlloc".}
proc SNMP_DBG_free*(pMem: LPVOID): VOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilMemFree".}
proc SNMP_DBG_malloc*(nBytes: UINT): LPVOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilMemAlloc".}
proc SNMP_DBG_realloc*(pMem: LPVOID, nBytes: UINT): LPVOID {.winapi, stdcall, dynlib: "snmpapi", importc: "SnmpUtilMemReAlloc".}
