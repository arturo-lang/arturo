#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import security
#include <wincred.h>
type
  CRED_MARSHAL_TYPE* = int32
  PCRED_MARSHAL_TYPE* = ptr int32
  CRED_PROTECTION_TYPE* = int32
  PCRED_PROTECTION_TYPE* = ptr int32
  CREDENTIAL_ATTRIBUTEA* {.pure.} = object
    Keyword*: LPSTR
    Flags*: DWORD
    ValueSize*: DWORD
    Value*: LPBYTE
  PCREDENTIAL_ATTRIBUTEA* = ptr CREDENTIAL_ATTRIBUTEA
  CREDENTIAL_ATTRIBUTEW* {.pure.} = object
    Keyword*: LPWSTR
    Flags*: DWORD
    ValueSize*: DWORD
    Value*: LPBYTE
  PCREDENTIAL_ATTRIBUTEW* = ptr CREDENTIAL_ATTRIBUTEW
  CREDENTIALA* {.pure.} = object
    Flags*: DWORD
    Type*: DWORD
    TargetName*: LPSTR
    Comment*: LPSTR
    LastWritten*: FILETIME
    CredentialBlobSize*: DWORD
    CredentialBlob*: LPBYTE
    Persist*: DWORD
    AttributeCount*: DWORD
    Attributes*: PCREDENTIAL_ATTRIBUTEA
    TargetAlias*: LPSTR
    UserName*: LPSTR
  PCREDENTIALA* = ptr CREDENTIALA
  CREDENTIALW* {.pure.} = object
    Flags*: DWORD
    Type*: DWORD
    TargetName*: LPWSTR
    Comment*: LPWSTR
    LastWritten*: FILETIME
    CredentialBlobSize*: DWORD
    CredentialBlob*: LPBYTE
    Persist*: DWORD
    AttributeCount*: DWORD
    Attributes*: PCREDENTIAL_ATTRIBUTEW
    TargetAlias*: LPWSTR
    UserName*: LPWSTR
  PCREDENTIALW* = ptr CREDENTIALW
  CREDENTIAL_TARGET_INFORMATIONA* {.pure.} = object
    TargetName*: LPSTR
    NetbiosServerName*: LPSTR
    DnsServerName*: LPSTR
    NetbiosDomainName*: LPSTR
    DnsDomainName*: LPSTR
    DnsTreeName*: LPSTR
    PackageName*: LPSTR
    Flags*: ULONG
    CredTypeCount*: DWORD
    CredTypes*: LPDWORD
  PCREDENTIAL_TARGET_INFORMATIONA* = ptr CREDENTIAL_TARGET_INFORMATIONA
  CREDENTIAL_TARGET_INFORMATIONW* {.pure.} = object
    TargetName*: LPWSTR
    NetbiosServerName*: LPWSTR
    DnsServerName*: LPWSTR
    NetbiosDomainName*: LPWSTR
    DnsDomainName*: LPWSTR
    DnsTreeName*: LPWSTR
    PackageName*: LPWSTR
    Flags*: ULONG
    CredTypeCount*: DWORD
    CredTypes*: LPDWORD
  PCREDENTIAL_TARGET_INFORMATIONW* = ptr CREDENTIAL_TARGET_INFORMATIONW
const
  CERT_HASH_LENGTH* = 20
type
  CERT_CREDENTIAL_INFO* {.pure.} = object
    cbSize*: ULONG
    rgbHashOfCert*: array[CERT_HASH_LENGTH, UCHAR]
  PCERT_CREDENTIAL_INFO* = ptr CERT_CREDENTIAL_INFO
  USERNAME_TARGET_CREDENTIAL_INFO* {.pure.} = object
    UserName*: LPWSTR
  PUSERNAME_TARGET_CREDENTIAL_INFO* = ptr USERNAME_TARGET_CREDENTIAL_INFO
  CREDUI_INFOA* {.pure.} = object
    cbSize*: DWORD
    hwndParent*: HWND
    pszMessageText*: PCSTR
    pszCaptionText*: PCSTR
    hbmBanner*: HBITMAP
  PCREDUI_INFOA* = ptr CREDUI_INFOA
  CREDUI_INFOW* {.pure.} = object
    cbSize*: DWORD
    hwndParent*: HWND
    pszMessageText*: PCWSTR
    pszCaptionText*: PCWSTR
    hbmBanner*: HBITMAP
  PCREDUI_INFOW* = ptr CREDUI_INFOW
const
  CRED_MAX_STRING_LENGTH* = 256
  CRED_MAX_USERNAME_LENGTH* = 256+1+256
  CRED_MAX_GENERIC_TARGET_NAME_LENGTH* = 32767
  CRED_MAX_DOMAIN_TARGET_NAME_LENGTH* = 256+1+80
  CRED_MAX_VALUE_SIZE* = 256
  CRED_MAX_ATTRIBUTES* = 64
  CRED_SESSION_WILDCARD_NAME_W* = "*Session"
  CRED_SESSION_WILDCARD_NAME_A* = "*Session"
  CRED_FLAGS_PASSWORD_FOR_CERT* = 0x0001
  CRED_FLAGS_PROMPT_NOW* = 0x0002
  CRED_FLAGS_USERNAME_TARGET* = 0x0004
  CRED_FLAGS_OWF_CRED_BLOB* = 0x0008
  CRED_FLAGS_VALID_FLAGS* = 0x000F
  CRED_TYPE_GENERIC* = 1
  CRED_TYPE_DOMAIN_PASSWORD* = 2
  CRED_TYPE_DOMAIN_CERTIFICATE* = 3
  CRED_TYPE_DOMAIN_VISIBLE_PASSWORD* = 4
  CRED_TYPE_MAXIMUM* = 5
  CRED_TYPE_MAXIMUM_EX* = CRED_TYPE_MAXIMUM+1000
  CRED_MAX_CREDENTIAL_BLOB_SIZE* = 512
  CRED_PERSIST_NONE* = 0
  CRED_PERSIST_SESSION* = 1
  CRED_PERSIST_LOCAL_MACHINE* = 2
  CRED_PERSIST_ENTERPRISE* = 3
  CRED_TI_SERVER_FORMAT_UNKNOWN* = 0x0001
  CRED_TI_DOMAIN_FORMAT_UNKNOWN* = 0x0002
  CRED_TI_ONLY_PASSWORD_REQUIRED* = 0x0004
  CRED_TI_USERNAME_TARGET* = 0x0008
  CRED_TI_CREATE_EXPLICIT_CRED* = 0x0010
  CRED_TI_WORKGROUP_MEMBER* = 0x0020
  CRED_TI_VALID_FLAGS* = 0x003F
  certCredential* = 1
  usernameTargetCredential* = 2
  CREDUI_MAX_MESSAGE_LENGTH* = 32767
  CREDUI_MAX_CAPTION_LENGTH* = 128
  CREDUI_MAX_GENERIC_TARGET_LENGTH* = CRED_MAX_GENERIC_TARGET_NAME_LENGTH
  CREDUI_MAX_DOMAIN_TARGET_LENGTH* = CRED_MAX_DOMAIN_TARGET_NAME_LENGTH
  CREDUI_MAX_USERNAME_LENGTH* = CRED_MAX_USERNAME_LENGTH
  CREDUI_MAX_PASSWORD_LENGTH* = CRED_MAX_CREDENTIAL_BLOB_SIZE/2
  CREDUI_FLAGS_INCORRECT_PASSWORD* = 0x00001
  CREDUI_FLAGS_DO_NOT_PERSIST* = 0x00002
  CREDUI_FLAGS_REQUEST_ADMINISTRATOR* = 0x00004
  CREDUI_FLAGS_EXCLUDE_CERTIFICATES* = 0x00008
  CREDUI_FLAGS_REQUIRE_CERTIFICATE* = 0x00010
  CREDUI_FLAGS_SHOW_SAVE_CHECK_BOX* = 0x00040
  CREDUI_FLAGS_ALWAYS_SHOW_UI* = 0x00080
  CREDUI_FLAGS_REQUIRE_SMARTCARD* = 0x00100
  CREDUI_FLAGS_PASSWORD_ONLY_OK* = 0x00200
  CREDUI_FLAGS_VALIDATE_USERNAME* = 0x00400
  CREDUI_FLAGS_COMPLETE_USERNAME* = 0x00800
  CREDUI_FLAGS_PERSIST* = 0x01000
  CREDUI_FLAGS_SERVER_CREDENTIAL* = 0x04000
  CREDUI_FLAGS_EXPECT_CONFIRMATION* = 0x20000
  CREDUI_FLAGS_GENERIC_CREDENTIALS* = 0x40000
  CREDUI_FLAGS_USERNAME_TARGET_CREDENTIALS* = 0x80000
  CREDUI_FLAGS_KEEP_USERNAME* = 0x100000
  CREDUI_FLAGS_PROMPT_VALID* = CREDUI_FLAGS_INCORRECT_PASSWORD or CREDUI_FLAGS_DO_NOT_PERSIST or CREDUI_FLAGS_REQUEST_ADMINISTRATOR or CREDUI_FLAGS_EXCLUDE_CERTIFICATES or CREDUI_FLAGS_REQUIRE_CERTIFICATE or CREDUI_FLAGS_SHOW_SAVE_CHECK_BOX or CREDUI_FLAGS_ALWAYS_SHOW_UI or CREDUI_FLAGS_REQUIRE_SMARTCARD or CREDUI_FLAGS_PASSWORD_ONLY_OK or CREDUI_FLAGS_VALIDATE_USERNAME or CREDUI_FLAGS_COMPLETE_USERNAME or CREDUI_FLAGS_PERSIST or CREDUI_FLAGS_SERVER_CREDENTIAL or CREDUI_FLAGS_EXPECT_CONFIRMATION or CREDUI_FLAGS_GENERIC_CREDENTIALS or CREDUI_FLAGS_USERNAME_TARGET_CREDENTIALS or CREDUI_FLAGS_KEEP_USERNAME
  CRED_PRESERVE_CREDENTIAL_BLOB* = 0x1
  CRED_CACHE_TARGET_INFORMATION* = 0x1
  CRED_ALLOW_NAME_RESOLUTION* = 0x1
  CREDUIWIN_GENERIC* = 0x1
  CREDUIWIN_CHECKBOX* = 0x2
  CREDUIWIN_AUTHPACKAGE_ONLY* = 0x10
  CREDUIWIN_IN_CRED_ONLY* = 0x20
  CREDUIWIN_ENUMERATE_ADMINS* = 0x100
  CREDUIWIN_ENUMERATE_CURRENT_USER* = 0x200
  CREDUIWIN_SECURE_PROMPT* = 0x1000
  CREDUIWIN_PACK_32_WOW* = 0x10000000
  credUnprotected* = 0
  credUserProtection* = 1
  credTrustedProtection* = 2
when winimUnicode:
  const
    CRED_SESSION_WILDCARD_NAME* = CRED_SESSION_WILDCARD_NAME_W
when winimAnsi:
  const
    CRED_SESSION_WILDCARD_NAME* = CRED_SESSION_WILDCARD_NAME_A
const
  CRED_SESSION_WILDCARD_NAME_LENGTH* = CRED_SESSION_WILDCARD_NAME.len
proc CredWriteW*(Credential: PCREDENTIALW, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredWriteA*(Credential: PCREDENTIALA, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredReadW*(TargetName: LPCWSTR, Type: DWORD, Flags: DWORD, Credential: ptr PCREDENTIALW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredReadA*(TargetName: LPCSTR, Type: DWORD, Flags: DWORD, Credential: ptr PCREDENTIALA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredEnumerateW*(Filter: LPCWSTR, Flags: DWORD, Count: ptr DWORD, Credential: ptr ptr PCREDENTIALW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredEnumerateA*(Filter: LPCSTR, Flags: DWORD, Count: ptr DWORD, Credential: ptr ptr PCREDENTIALA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredWriteDomainCredentialsW*(TargetInfo: PCREDENTIAL_TARGET_INFORMATIONW, Credential: PCREDENTIALW, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredWriteDomainCredentialsA*(TargetInfo: PCREDENTIAL_TARGET_INFORMATIONA, Credential: PCREDENTIALA, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredReadDomainCredentialsW*(TargetInfo: PCREDENTIAL_TARGET_INFORMATIONW, Flags: DWORD, Count: ptr DWORD, Credential: ptr ptr PCREDENTIALW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredReadDomainCredentialsA*(TargetInfo: PCREDENTIAL_TARGET_INFORMATIONA, Flags: DWORD, Count: ptr DWORD, Credential: ptr ptr PCREDENTIALA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredDeleteW*(TargetName: LPCWSTR, Type: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredDeleteA*(TargetName: LPCSTR, Type: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredRenameW*(OldTargetName: LPCWSTR, NewTargetName: LPCWSTR, Type: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredRenameA*(OldTargetName: LPCSTR, NewTargetName: LPCSTR, Type: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredGetTargetInfoW*(TargetName: LPCWSTR, Flags: DWORD, TargetInfo: ptr PCREDENTIAL_TARGET_INFORMATIONW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredGetTargetInfoA*(TargetName: LPCSTR, Flags: DWORD, TargetInfo: ptr PCREDENTIAL_TARGET_INFORMATIONA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredMarshalCredentialW*(CredType: CRED_MARSHAL_TYPE, Credential: PVOID, MarshaledCredential: ptr LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredMarshalCredentialA*(CredType: CRED_MARSHAL_TYPE, Credential: PVOID, MarshaledCredential: ptr LPSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredUnmarshalCredentialW*(MarshaledCredential: LPCWSTR, CredType: PCRED_MARSHAL_TYPE, Credential: ptr PVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredUnmarshalCredentialA*(MarshaledCredential: LPCSTR, CredType: PCRED_MARSHAL_TYPE, Credential: ptr PVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredIsMarshaledCredentialW*(MarshaledCredential: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredIsMarshaledCredentialA*(MarshaledCredential: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredGetSessionTypes*(MaximumPersistCount: DWORD, MaximumPersist: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredFree*(Buffer: PVOID): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredUIPromptForCredentialsW*(pUiInfo: PCREDUI_INFOW, pszTargetName: PCWSTR, pContext: PCtxtHandle, dwAuthError: DWORD, pszUserName: PWSTR, ulUserNameBufferSize: ULONG, pszPassword: PWSTR, ulPasswordBufferSize: ULONG, save: ptr WINBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUIPromptForCredentialsA*(pUiInfo: PCREDUI_INFOA, pszTargetName: PCSTR, pContext: PCtxtHandle, dwAuthError: DWORD, pszUserName: PSTR, ulUserNameBufferSize: ULONG, pszPassword: PSTR, ulPasswordBufferSize: ULONG, save: ptr WINBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUIParseUserNameW*(UserName: ptr WCHAR, user: ptr WCHAR, userBufferSize: ULONG, domain: ptr WCHAR, domainBufferSize: ULONG): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUIParseUserNameA*(userName: ptr CHAR, user: ptr CHAR, userBufferSize: ULONG, domain: ptr CHAR, domainBufferSize: ULONG): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUICmdLinePromptForCredentialsW*(pszTargetName: PCWSTR, pContext: PCtxtHandle, dwAuthError: DWORD, UserName: PWSTR, ulUserBufferSize: ULONG, pszPassword: PWSTR, ulPasswordBufferSize: ULONG, pfSave: PBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUICmdLinePromptForCredentialsA*(pszTargetName: PCSTR, pContext: PCtxtHandle, dwAuthError: DWORD, UserName: PSTR, ulUserBufferSize: ULONG, pszPassword: PSTR, ulPasswordBufferSize: ULONG, pfSave: PBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUIConfirmCredentialsW*(pszTargetName: PCWSTR, bConfirm: WINBOOL): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUIConfirmCredentialsA*(pszTargetName: PCSTR, bConfirm: WINBOOL): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUIStoreSSOCredW*(pszRealm: PCWSTR, pszUsername: PCWSTR, pszPassword: PCWSTR, bPersist: WINBOOL): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUIReadSSOCredW*(pszRealm: PCWSTR, ppszUsername: ptr PWSTR): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredFindBestCredentialA*(TargetName: LPCSTR, Type: DWORD, Flags: DWORD, Credential: ptr PCREDENTIALA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredFindBestCredentialW*(TargetName: LPCWSTR, Type: DWORD, Flags: DWORD, Credential: ptr PCREDENTIALW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredIsProtectedA*(pszProtectedCredentials: LPSTR, pProtectionType: ptr CRED_PROTECTION_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredIsProtectedW*(pszProtectedCredentials: LPWSTR, pProtectionType: ptr CRED_PROTECTION_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredPackAuthenticationBufferA*(dwFlags: DWORD, pszUserName: LPSTR, pszPassword: LPSTR, pPackedCredentials: PBYTE, pcbPackedCredentials: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "credui", importc.}
proc CredPackAuthenticationBufferW*(dwFlags: DWORD, pszUserName: LPWSTR, pszPassword: LPWSTR, pPackedCredentials: PBYTE, pcbPackedCredentials: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "credui", importc.}
proc CredProtectW*(fAsSelf: WINBOOL, pszCredentials: LPWSTR, cchCredentials: DWORD, pszProtectedCredentials: LPWSTR, pcchMaxChars: ptr DWORD, ProtectionType: ptr CRED_PROTECTION_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredProtectA*(fAsSelf: WINBOOL, pszCredentials: LPSTR, cchCredentials: DWORD, pszProtectedCredentials: LPSTR, pcchMaxChars: ptr DWORD, ProtectionType: ptr CRED_PROTECTION_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredUIPromptForWindowsCredentialsA*(pUiInfo: PCREDUI_INFOA, dwAuthError: DWORD, pulAuthPackage: ptr ULONG, pvInAuthBuffer: LPCVOID, ulInAuthBufferSize: ULONG, ppvOutAuthBuffer: ptr LPVOID, pulOutAuthBufferSize: ptr ULONG, pfSave: ptr WINBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUIPromptForWindowsCredentialsW*(pUiInfo: PCREDUI_INFOW, dwAuthError: DWORD, pulAuthPackage: ptr ULONG, pvInAuthBuffer: LPCVOID, ulInAuthBufferSize: ULONG, ppvOutAuthBuffer: ptr LPVOID, pulOutAuthBufferSize: ptr ULONG, pfSave: ptr WINBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUnPackAuthenticationBufferA*(dwFlags: DWORD, pAuthBuffer: PVOID, cbAuthBuffer: DWORD, pszUserName: LPSTR, pcchMaxUserName: ptr DWORD, pszDomainName: LPSTR, pcchMaxDomainame: ptr DWORD, pszPassword: LPSTR, pcchMaxPassword: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUnPackAuthenticationBufferW*(dwFlags: DWORD, pAuthBuffer: PVOID, cbAuthBuffer: DWORD, pszUserName: LPWSTR, pcchMaxUserName: ptr DWORD, pszDomainName: LPWSTR, pcchMaxDomainame: ptr DWORD, pszPassword: LPWSTR, pcchMaxPassword: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "credui", importc.}
proc CredUnprotectA*(fAsSelf: WINBOOL, pszProtectedCredentials: LPSTR, cchCredentials: DWORD, pszCredentials: LPSTR, pcchMaxChars: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CredUnprotectW*(fAsSelf: WINBOOL, pszProtectedCredentials: LPWSTR, cchCredentials: DWORD, pszCredentials: LPWSTR, pcchMaxChars: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
when winimUnicode:
  type
    CREDENTIAL_ATTRIBUTE* = CREDENTIAL_ATTRIBUTEW
    PCREDENTIAL_ATTRIBUTE* = PCREDENTIAL_ATTRIBUTEW
    CREDENTIAL* = CREDENTIALW
    PCREDENTIAL* = PCREDENTIALW
    CREDENTIAL_TARGET_INFORMATION* = CREDENTIAL_TARGET_INFORMATIONW
    PCREDENTIAL_TARGET_INFORMATION* = PCREDENTIAL_TARGET_INFORMATIONW
    CREDUI_INFO* = CREDUI_INFOW
    PCREDUI_INFO* = PCREDUI_INFOW
  proc CredWrite*(Credential: PCREDENTIALW, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredWriteW".}
  proc CredRead*(TargetName: LPCWSTR, Type: DWORD, Flags: DWORD, Credential: ptr PCREDENTIALW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredReadW".}
  proc CredEnumerate*(Filter: LPCWSTR, Flags: DWORD, Count: ptr DWORD, Credential: ptr ptr PCREDENTIALW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredEnumerateW".}
  proc CredWriteDomainCredentials*(TargetInfo: PCREDENTIAL_TARGET_INFORMATIONW, Credential: PCREDENTIALW, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredWriteDomainCredentialsW".}
  proc CredReadDomainCredentials*(TargetInfo: PCREDENTIAL_TARGET_INFORMATIONW, Flags: DWORD, Count: ptr DWORD, Credential: ptr ptr PCREDENTIALW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredReadDomainCredentialsW".}
  proc CredDelete*(TargetName: LPCWSTR, Type: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredDeleteW".}
  proc CredRename*(OldTargetName: LPCWSTR, NewTargetName: LPCWSTR, Type: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredRenameW".}
  proc CredGetTargetInfo*(TargetName: LPCWSTR, Flags: DWORD, TargetInfo: ptr PCREDENTIAL_TARGET_INFORMATIONW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredGetTargetInfoW".}
  proc CredMarshalCredential*(CredType: CRED_MARSHAL_TYPE, Credential: PVOID, MarshaledCredential: ptr LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredMarshalCredentialW".}
  proc CredUnmarshalCredential*(MarshaledCredential: LPCWSTR, CredType: PCRED_MARSHAL_TYPE, Credential: ptr PVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredUnmarshalCredentialW".}
  proc CredIsMarshaledCredential*(MarshaledCredential: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredIsMarshaledCredentialW".}
  proc CredUIPromptForCredentials*(pUiInfo: PCREDUI_INFOW, pszTargetName: PCWSTR, pContext: PCtxtHandle, dwAuthError: DWORD, pszUserName: PWSTR, ulUserNameBufferSize: ULONG, pszPassword: PWSTR, ulPasswordBufferSize: ULONG, save: ptr WINBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUIPromptForCredentialsW".}
  proc CredUIParseUserName*(UserName: ptr WCHAR, user: ptr WCHAR, userBufferSize: ULONG, domain: ptr WCHAR, domainBufferSize: ULONG): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUIParseUserNameW".}
  proc CredUICmdLinePromptForCredentials*(pszTargetName: PCWSTR, pContext: PCtxtHandle, dwAuthError: DWORD, UserName: PWSTR, ulUserBufferSize: ULONG, pszPassword: PWSTR, ulPasswordBufferSize: ULONG, pfSave: PBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUICmdLinePromptForCredentialsW".}
  proc CredUIConfirmCredentials*(pszTargetName: PCWSTR, bConfirm: WINBOOL): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUIConfirmCredentialsW".}
  proc CredFindBestCredential*(TargetName: LPCWSTR, Type: DWORD, Flags: DWORD, Credential: ptr PCREDENTIALW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredFindBestCredentialW".}
  proc CredIsProtected*(pszProtectedCredentials: LPWSTR, pProtectionType: ptr CRED_PROTECTION_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredIsProtectedW".}
  proc CredPackAuthenticationBuffer*(dwFlags: DWORD, pszUserName: LPWSTR, pszPassword: LPWSTR, pPackedCredentials: PBYTE, pcbPackedCredentials: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "credui", importc: "CredPackAuthenticationBufferW".}
  proc CredProtect*(fAsSelf: WINBOOL, pszCredentials: LPWSTR, cchCredentials: DWORD, pszProtectedCredentials: LPWSTR, pcchMaxChars: ptr DWORD, ProtectionType: ptr CRED_PROTECTION_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredProtectW".}
  proc CredUIPromptForWindowsCredentials*(pUiInfo: PCREDUI_INFOW, dwAuthError: DWORD, pulAuthPackage: ptr ULONG, pvInAuthBuffer: LPCVOID, ulInAuthBufferSize: ULONG, ppvOutAuthBuffer: ptr LPVOID, pulOutAuthBufferSize: ptr ULONG, pfSave: ptr WINBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUIPromptForWindowsCredentialsW".}
  proc CredUnPackAuthenticationBuffer*(dwFlags: DWORD, pAuthBuffer: PVOID, cbAuthBuffer: DWORD, pszUserName: LPWSTR, pcchMaxUserName: ptr DWORD, pszDomainName: LPWSTR, pcchMaxDomainame: ptr DWORD, pszPassword: LPWSTR, pcchMaxPassword: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "credui", importc: "CredUnPackAuthenticationBufferW".}
  proc CredUnprotect*(fAsSelf: WINBOOL, pszProtectedCredentials: LPWSTR, cchCredentials: DWORD, pszCredentials: LPWSTR, pcchMaxChars: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredUnprotectW".}
when winimAnsi:
  type
    CREDENTIAL_ATTRIBUTE* = CREDENTIAL_ATTRIBUTEA
    PCREDENTIAL_ATTRIBUTE* = PCREDENTIAL_ATTRIBUTEA
    CREDENTIAL* = CREDENTIALA
    PCREDENTIAL* = PCREDENTIALA
    CREDENTIAL_TARGET_INFORMATION* = CREDENTIAL_TARGET_INFORMATIONA
    PCREDENTIAL_TARGET_INFORMATION* = PCREDENTIAL_TARGET_INFORMATIONA
    CREDUI_INFO* = CREDUI_INFOA
    PCREDUI_INFO* = PCREDUI_INFOA
  proc CredWrite*(Credential: PCREDENTIALA, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredWriteA".}
  proc CredRead*(TargetName: LPCSTR, Type: DWORD, Flags: DWORD, Credential: ptr PCREDENTIALA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredReadA".}
  proc CredEnumerate*(Filter: LPCSTR, Flags: DWORD, Count: ptr DWORD, Credential: ptr ptr PCREDENTIALA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredEnumerateA".}
  proc CredWriteDomainCredentials*(TargetInfo: PCREDENTIAL_TARGET_INFORMATIONA, Credential: PCREDENTIALA, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredWriteDomainCredentialsA".}
  proc CredReadDomainCredentials*(TargetInfo: PCREDENTIAL_TARGET_INFORMATIONA, Flags: DWORD, Count: ptr DWORD, Credential: ptr ptr PCREDENTIALA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredReadDomainCredentialsA".}
  proc CredDelete*(TargetName: LPCSTR, Type: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredDeleteA".}
  proc CredRename*(OldTargetName: LPCSTR, NewTargetName: LPCSTR, Type: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredRenameA".}
  proc CredGetTargetInfo*(TargetName: LPCSTR, Flags: DWORD, TargetInfo: ptr PCREDENTIAL_TARGET_INFORMATIONA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredGetTargetInfoA".}
  proc CredMarshalCredential*(CredType: CRED_MARSHAL_TYPE, Credential: PVOID, MarshaledCredential: ptr LPSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredMarshalCredentialA".}
  proc CredUnmarshalCredential*(MarshaledCredential: LPCSTR, CredType: PCRED_MARSHAL_TYPE, Credential: ptr PVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredUnmarshalCredentialA".}
  proc CredIsMarshaledCredential*(MarshaledCredential: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredIsMarshaledCredentialA".}
  proc CredUIPromptForCredentials*(pUiInfo: PCREDUI_INFOA, pszTargetName: PCSTR, pContext: PCtxtHandle, dwAuthError: DWORD, pszUserName: PSTR, ulUserNameBufferSize: ULONG, pszPassword: PSTR, ulPasswordBufferSize: ULONG, save: ptr WINBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUIPromptForCredentialsA".}
  proc CredUIParseUserName*(userName: ptr CHAR, user: ptr CHAR, userBufferSize: ULONG, domain: ptr CHAR, domainBufferSize: ULONG): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUIParseUserNameA".}
  proc CredUICmdLinePromptForCredentials*(pszTargetName: PCSTR, pContext: PCtxtHandle, dwAuthError: DWORD, UserName: PSTR, ulUserBufferSize: ULONG, pszPassword: PSTR, ulPasswordBufferSize: ULONG, pfSave: PBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUICmdLinePromptForCredentialsA".}
  proc CredUIConfirmCredentials*(pszTargetName: PCSTR, bConfirm: WINBOOL): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUIConfirmCredentialsA".}
  proc CredFindBestCredential*(TargetName: LPCSTR, Type: DWORD, Flags: DWORD, Credential: ptr PCREDENTIALA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredFindBestCredentialA".}
  proc CredIsProtected*(pszProtectedCredentials: LPSTR, pProtectionType: ptr CRED_PROTECTION_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredIsProtectedA".}
  proc CredPackAuthenticationBuffer*(dwFlags: DWORD, pszUserName: LPSTR, pszPassword: LPSTR, pPackedCredentials: PBYTE, pcbPackedCredentials: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "credui", importc: "CredPackAuthenticationBufferA".}
  proc CredProtect*(fAsSelf: WINBOOL, pszCredentials: LPSTR, cchCredentials: DWORD, pszProtectedCredentials: LPSTR, pcchMaxChars: ptr DWORD, ProtectionType: ptr CRED_PROTECTION_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredProtectA".}
  proc CredUIPromptForWindowsCredentials*(pUiInfo: PCREDUI_INFOA, dwAuthError: DWORD, pulAuthPackage: ptr ULONG, pvInAuthBuffer: LPCVOID, ulInAuthBufferSize: ULONG, ppvOutAuthBuffer: ptr LPVOID, pulOutAuthBufferSize: ptr ULONG, pfSave: ptr WINBOOL, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "credui", importc: "CredUIPromptForWindowsCredentialsA".}
  proc CredUnPackAuthenticationBuffer*(dwFlags: DWORD, pAuthBuffer: PVOID, cbAuthBuffer: DWORD, pszUserName: LPSTR, pcchMaxUserName: ptr DWORD, pszDomainName: LPSTR, pcchMaxDomainame: ptr DWORD, pszPassword: LPSTR, pcchMaxPassword: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "credui", importc: "CredUnPackAuthenticationBufferA".}
  proc CredUnprotect*(fAsSelf: WINBOOL, pszProtectedCredentials: LPSTR, cchCredentials: DWORD, pszCredentials: LPSTR, pcchMaxChars: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CredUnprotectA".}
