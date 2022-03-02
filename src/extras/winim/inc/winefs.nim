#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import wincrypt
#include <winefs.h>
type
  EFS_CERTIFICATE_BLOB* {.pure.} = object
    dwCertEncodingType*: DWORD
    cbData*: DWORD
    pbData*: PBYTE
  PEFS_CERTIFICATE_BLOB* = ptr EFS_CERTIFICATE_BLOB
  EFS_HASH_BLOB* {.pure.} = object
    cbData*: DWORD
    pbData*: PBYTE
  PEFS_HASH_BLOB* = ptr EFS_HASH_BLOB
  EFS_RPC_BLOB* {.pure.} = object
    cbData*: DWORD
    pbData*: PBYTE
  PEFS_RPC_BLOB* = ptr EFS_RPC_BLOB
  EFS_KEY_INFO* {.pure.} = object
    dwVersion*: DWORD
    Entropy*: ULONG
    Algorithm*: ALG_ID
    KeyLength*: ULONG
  PEFS_KEY_INFO* = ptr EFS_KEY_INFO
  ENCRYPTION_CERTIFICATE* {.pure.} = object
    cbTotalLength*: DWORD
    pUserSid*: ptr SID
    pCertBlob*: PEFS_CERTIFICATE_BLOB
  PENCRYPTION_CERTIFICATE* = ptr ENCRYPTION_CERTIFICATE
  ENCRYPTION_CERTIFICATE_HASH* {.pure.} = object
    cbTotalLength*: DWORD
    pUserSid*: ptr SID
    pHash*: PEFS_HASH_BLOB
    lpDisplayInformation*: LPWSTR
  PENCRYPTION_CERTIFICATE_HASH* = ptr ENCRYPTION_CERTIFICATE_HASH
  ENCRYPTION_CERTIFICATE_HASH_LIST* {.pure.} = object
    nCert_Hash*: DWORD
    pUsers*: ptr PENCRYPTION_CERTIFICATE_HASH
  PENCRYPTION_CERTIFICATE_HASH_LIST* = ptr ENCRYPTION_CERTIFICATE_HASH_LIST
  ENCRYPTION_CERTIFICATE_LIST* {.pure.} = object
    nUsers*: DWORD
    pUsers*: ptr PENCRYPTION_CERTIFICATE
  PENCRYPTION_CERTIFICATE_LIST* = ptr ENCRYPTION_CERTIFICATE_LIST
const
  MAX_SID_SIZE* = 256
proc QueryUsersOnEncryptedFile*(lpFileName: LPCWSTR, pUsers: ptr PENCRYPTION_CERTIFICATE_HASH_LIST): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryRecoveryAgentsOnEncryptedFile*(lpFileName: LPCWSTR, pRecoveryAgents: ptr PENCRYPTION_CERTIFICATE_HASH_LIST): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RemoveUsersFromEncryptedFile*(lpFileName: LPCWSTR, pHashes: PENCRYPTION_CERTIFICATE_HASH_LIST): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddUsersToEncryptedFile*(lpFileName: LPCWSTR, pUsers: PENCRYPTION_CERTIFICATE_LIST): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetUserFileEncryptionKey*(pEncryptionCertificate: PENCRYPTION_CERTIFICATE): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc FreeEncryptionCertificateHashList*(pHashes: PENCRYPTION_CERTIFICATE_HASH_LIST): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EncryptionDisable*(DirPath: LPCWSTR, Disable: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DuplicateEncryptionInfoFile*(SrcFileName: LPCWSTR, DstFileName: LPCWSTR, dwCreationDistribution: DWORD, dwAttributes: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
