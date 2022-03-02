#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import wincrypt
#include <winber.h>
#include <winldap.h>
#include <schnlsp.h>
#include <schannel.h>
type
  ber_tag_t* = int32
  ber_int_t* = int32
  ber_uint_t* = int32
  ber_len_t* = int32
  ber_slen_t* = int32
  LDAP_RETCODE* = int32
  SecPkgContext_IssuerListInfo* {.pure.} = object
    cbIssuerList*: DWORD
    pIssuerList*: PBYTE
  PSecPkgContext_IssuerListInfo* = ptr SecPkgContext_IssuerListInfo
  SecPkgContext_RemoteCredentialInfo* {.pure.} = object
    cbCertificateChain*: DWORD
    pbCertificateChain*: PBYTE
    cCertificates*: DWORD
    fFlags*: DWORD
    dwBits*: DWORD
  PSecPkgContext_RemoteCredentialInfo* = ptr SecPkgContext_RemoteCredentialInfo
  SecPkgContext_RemoteCredenitalInfo* = SecPkgContext_RemoteCredentialInfo
  PSecPkgContext_RemoteCredenitalInfo* = ptr SecPkgContext_RemoteCredentialInfo
  SecPkgContext_LocalCredentialInfo* {.pure.} = object
    cbCertificateChain*: DWORD
    pbCertificateChain*: PBYTE
    cCertificates*: DWORD
    fFlags*: DWORD
    dwBits*: DWORD
  PSecPkgContext_LocalCredentialInfo* = ptr SecPkgContext_LocalCredentialInfo
  SecPkgContext_LocalCredenitalInfo* = SecPkgContext_LocalCredentialInfo
  PSecPkgContext_LocalCredenitalInfo* = ptr SecPkgContext_LocalCredentialInfo
  SecPkgCred_SupportedAlgs* {.pure.} = object
    cSupportedAlgs*: DWORD
    palgSupportedAlgs*: ptr ALG_ID
  PSecPkgCred_SupportedAlgs* = ptr SecPkgCred_SupportedAlgs
  SecPkgCred_CipherStrengths* {.pure.} = object
    dwMinimumCipherStrength*: DWORD
    dwMaximumCipherStrength*: DWORD
  PSecPkgCred_CipherStrengths* = ptr SecPkgCred_CipherStrengths
  SecPkgCred_SupportedProtocols* {.pure.} = object
    grbitProtocol*: DWORD
  PSecPkgCred_SupportedProtocols* = ptr SecPkgCred_SupportedProtocols
  SecPkgContext_IssuerListInfoEx* {.pure.} = object
    aIssuers*: PCERT_NAME_BLOB
    cIssuers*: DWORD
  PSecPkgContext_IssuerListInfoEx* = ptr SecPkgContext_IssuerListInfoEx
  SecPkgContext_ConnectionInfo* {.pure.} = object
    dwProtocol*: DWORD
    aiCipher*: ALG_ID
    dwCipherStrength*: DWORD
    aiHash*: ALG_ID
    dwHashStrength*: DWORD
    aiExch*: ALG_ID
    dwExchStrength*: DWORD
  PSecPkgContext_ConnectionInfo* = ptr SecPkgContext_ConnectionInfo
  SecPkgContext_EapKeyBlock* {.pure.} = object
    rgbKeys*: array[128, BYTE]
    rgbIVs*: array[64, BYTE]
  PSecPkgContext_EapKeyBlock* = ptr SecPkgContext_EapKeyBlock
  SecPkgContext_MappedCredAttr* {.pure.} = object
    dwAttribute*: DWORD
    pvBuffer*: PVOID
  PSecPkgContext_MappedCredAttr* = ptr SecPkgContext_MappedCredAttr
  SecPkgContext_SessionInfo* {.pure.} = object
    dwFlags*: DWORD
    cbSessionId*: DWORD
    rgbSessionId*: array[32, BYTE]
  PSecPkgContext_SessionInfo* = ptr SecPkgContext_SessionInfo
  SecPkgContext_SessionAppData* {.pure.} = object
    dwFlags*: DWORD
    cbAppData*: DWORD
    pbAppData*: PBYTE
  PSecPkgContext_SessionAppData* = ptr SecPkgContext_SessionAppData
  HMAPPER* {.pure.} = object
  SCHANNEL_CRED* {.pure.} = object
    dwVersion*: DWORD
    cCreds*: DWORD
    paCred*: ptr PCCERT_CONTEXT
    hRootStore*: HCERTSTORE
    cMappers*: DWORD
    aphMappers*: ptr ptr HMAPPER
    cSupportedAlgs*: DWORD
    palgSupportedAlgs*: ptr ALG_ID
    grbitEnabledProtocols*: DWORD
    dwMinimumCipherStrength*: DWORD
    dwMaximumCipherStrength*: DWORD
    dwSessionLifespan*: DWORD
    dwFlags*: DWORD
    dwCredFormat*: DWORD
  PSCHANNEL_CRED* = ptr SCHANNEL_CRED
  SCHANNEL_CERT_HASH* {.pure.} = object
    dwLength*: DWORD
    dwFlags*: DWORD
    hProv*: HCRYPTPROV
    ShaHash*: array[20, BYTE]
  PSCHANNEL_CERT_HASH* = ptr SCHANNEL_CERT_HASH
  SSL_CREDENTIAL_CERTIFICATE* {.pure.} = object
    cbPrivateKey*: DWORD
    pPrivateKey*: PBYTE
    cbCertificate*: DWORD
    pCertificate*: PBYTE
    pszPassword*: PSTR
  PSSL_CREDENTIAL_CERTIFICATE* = ptr SSL_CREDENTIAL_CERTIFICATE
  SCH_CRED* {.pure.} = object
    dwVersion*: DWORD
    cCreds*: DWORD
    paSecret*: ptr PVOID
    paPublic*: ptr PVOID
    cMappers*: DWORD
    aphMappers*: ptr ptr HMAPPER
  PSCH_CRED* = ptr SCH_CRED
  SCH_CRED_SECRET_CAPI* {.pure.} = object
    dwType*: DWORD
    hProv*: HCRYPTPROV
  PSCH_CRED_SECRET_CAPI* = ptr SCH_CRED_SECRET_CAPI
  SCH_CRED_SECRET_PRIVKEY* {.pure.} = object
    dwType*: DWORD
    pPrivateKey*: PBYTE
    cbPrivateKey*: DWORD
    pszPassword*: PSTR
  PSCH_CRED_SECRET_PRIVKEY* = ptr SCH_CRED_SECRET_PRIVKEY
  SCH_CRED_PUBLIC_CERTCHAIN* {.pure.} = object
    dwType*: DWORD
    cbCertChain*: DWORD
    pCertChain*: PBYTE
  PSCH_CRED_PUBLIC_CERTCHAIN* = ptr SCH_CRED_PUBLIC_CERTCHAIN
  SCH_CRED_PUBLIC_CAPI* {.pure.} = object
    dwType*: DWORD
    hProv*: HCRYPTPROV
  PSCH_CRED_PUBLIC_CAPI* = ptr SCH_CRED_PUBLIC_CAPI
  PctPublicKey* {.pure.} = object
    Type*: DWORD
    cbKey*: DWORD
    pKey*: array[1, UCHAR]
  X509Certificate* {.pure.} = object
    Version*: DWORD
    SerialNumber*: array[4, DWORD]
    SignatureAlgorithm*: ALG_ID
    ValidFrom*: FILETIME
    ValidUntil*: FILETIME
    pszIssuer*: PSTR
    pszSubject*: PSTR
    pPublicKey*: ptr PctPublicKey
  PX509Certificate* = ptr X509Certificate
  SecPkgContext_EapPrfInfo* {.pure.} = object
    dwVersion*: DWORD
    cbPrfData*: DWORD
  PSecPkgContext_EapPrfInfo* = ptr SecPkgContext_EapPrfInfo
  SecPkgContext_SupportedSignatures* {.pure.} = object
    cSignatureAndHashAlgorithms*: WORD
    pSignatureAndHashAlgorithms*: ptr WORD
  PSecPkgContext_SupportedSignatures* = ptr SecPkgContext_SupportedSignatures
  LDAP_ld_sb* {.pure.} = object
    sb_sd*: UINT_PTR
    Reserved1*: array[(10*sizeof(ULONG))+1, UCHAR]
    sb_naddr*: ULONG_PTR
    Reserved2*: array[(6*sizeof(ULONG)), UCHAR]
  LDAP* {.pure.} = object
    ld_sb*: LDAP_ld_sb
    ld_host*: PCHAR
    ld_version*: ULONG
    ld_lberoptions*: UCHAR
    ld_deref*: ULONG
    ld_timelimit*: ULONG
    ld_sizelimit*: ULONG
    ld_errno*: ULONG
    ld_matched*: PCHAR
    ld_error*: PCHAR
    ld_msgid*: ULONG
    Reserved3*: array[(6*sizeof(ULONG))+1, UCHAR]
    ld_cldaptries*: ULONG
    ld_cldaptimeout*: ULONG
    ld_refhoplimit*: ULONG
    ld_options*: ULONG
  PLDAP* = ptr LDAP
  LDAP_TIMEVAL* {.pure.} = object
    tv_sec*: LONG
    tv_usec*: LONG
  PLDAP_TIMEVAL* = ptr LDAP_TIMEVAL
  LDAP_BERVAL* {.pure.} = object
    bv_len*: ULONG
    bv_val*: PCHAR
  PLDAP_BERVAL* = ptr LDAP_BERVAL
  BERVAL* = LDAP_BERVAL
  PBERVAL* = ptr LDAP_BERVAL
  BerValue* = LDAP_BERVAL
  LDAPMessage* {.pure.} = object
    lm_msgid*: ULONG
    lm_msgtype*: ULONG
    lm_ber*: PVOID
    lm_chain*: ptr LDAPMessage
    lm_next*: ptr LDAPMessage
    lm_time*: ULONG
    Connection*: PLDAP
    Request*: PVOID
    lm_returncode*: ULONG
    lm_referral*: USHORT
    lm_chased*: BOOLEAN
    lm_eom*: BOOLEAN
    ConnectionReferenced*: BOOLEAN
  PLDAPMessage* = ptr LDAPMessage
  LDAPControlA* {.pure.} = object
    ldctl_oid*: PCHAR
    ldctl_value*: BERVAL
    ldctl_iscritical*: BOOLEAN
  PLDAPControlA* = ptr LDAPControlA
  LDAPControlW* {.pure.} = object
    ldctl_oid*: PWCHAR
    ldctl_value*: BERVAL
    ldctl_iscritical*: BOOLEAN
  PLDAPControlW* = ptr LDAPControlW
  LDAPModW_mod_vals* {.pure, union.} = object
    modv_strvals*: ptr PWCHAR
    modv_bvals*: ptr ptr BERVAL
  LDAPModW* {.pure.} = object
    mod_op*: ULONG
    mod_type*: PWCHAR
    mod_vals*: LDAPModW_mod_vals
  PLDAPModW* = ptr LDAPModW
  LDAPModA_mod_vals* {.pure, union.} = object
    modv_strvals*: ptr PCHAR
    modv_bvals*: ptr ptr BERVAL
  LDAPModA* {.pure.} = object
    mod_op*: ULONG
    mod_type*: PCHAR
    mod_vals*: LDAPModA_mod_vals
  PLDAPModA* = ptr LDAPModA
  LDAP_VERSION_INFO* {.pure.} = object
    lv_size*: ULONG
    lv_major*: ULONG
    lv_minor*: ULONG
  PLDAP_VERSION_INFO* = ptr LDAP_VERSION_INFO
  LDAPSortKeyW* {.pure.} = object
    sk_attrtype*: PWCHAR
    sk_matchruleoid*: PWCHAR
    sk_reverseorder*: BOOLEAN
  PLDAPSortKeyW* = ptr LDAPSortKeyW
  LDAPSortKeyA* {.pure.} = object
    sk_attrtype*: PCHAR
    sk_matchruleoid*: PCHAR
    sk_reverseorder*: BOOLEAN
  PLDAPSortKeyA* = ptr LDAPSortKeyA
  LDAPVLVInfo* {.pure.} = object
    ldvlv_version*: int32
    ldvlv_before_count*: ULONG
    ldvlv_after_count*: ULONG
    ldvlv_offset*: ULONG
    ldvlv_count*: ULONG
    ldvlv_attrvalue*: PBERVAL
    ldvlv_context*: PBERVAL
    ldvlv_extradata*: pointer
  PLDAPVLVInfo* = ptr LDAPVLVInfo
  QUERYFORCONNECTION* = proc (PrimaryConnection: PLDAP, ReferralFromConnection: PLDAP, NewDN: PWCHAR, HostName: PCHAR, PortNumber: ULONG, SecAuthIdentity: PVOID, CurrentUserToken: PVOID, ConnectionToUse: ptr PLDAP): ULONG {.stdcall.}
  NOTIFYOFNEWCONNECTION* = proc (PrimaryConnection: PLDAP, ReferralFromConnection: PLDAP, NewDN: PWCHAR, HostName: PCHAR, NewConnection: PLDAP, PortNumber: ULONG, SecAuthIdentity: PVOID, CurrentUser: PVOID, ErrorCodeFromBind: ULONG): BOOLEAN {.stdcall.}
  DEREFERENCECONNECTION* = proc (PrimaryConnection: PLDAP, ConnectionToDereference: PLDAP): ULONG {.stdcall.}
  LDAP_REFERRAL_CALLBACK* {.pure.} = object
    SizeOfCallbacks*: ULONG
    QueryForConnection*: ptr QUERYFORCONNECTION
    NotifyRoutine*: ptr NOTIFYOFNEWCONNECTION
    DereferenceRoutine*: ptr DEREFERENCECONNECTION
  PLDAP_REFERRAL_CALLBACK* = ptr LDAP_REFERRAL_CALLBACK
  DBGPRINT* = proc (Format: PCH): ULONG {.varargs, cdecl.}
  LDAPSearch* {.pure.} = object
  PLDAPSearch* = ptr LDAPSearch
const
  LBER_ERROR* = 0xffffffff'i32
  LBER_DEFAULT* = 0xffffffff'i32
  UNISP_NAME_A* = "Microsoft Unified Security Protocol Provider"
  UNISP_NAME_W* = "Microsoft Unified Security Protocol Provider"
  SSL2SP_NAME_A* = "Microsoft SSL 2.0"
  SSL2SP_NAME_W* = "Microsoft SSL 2.0"
  SSL3SP_NAME_A* = "Microsoft SSL 3.0"
  SSL3SP_NAME_W* = "Microsoft SSL 3.0"
  TLS1SP_NAME_A* = "Microsoft TLS 1.0"
  TLS1SP_NAME_W* = "Microsoft TLS 1.0"
  PCT1SP_NAME_A* = "Microsoft PCT 1.0"
  PCT1SP_NAME_W* = "Microsoft PCT 1.0"
  SCHANNEL_NAME_A* = "Schannel"
  SCHANNEL_NAME_W* = "Schannel"
  UNISP_RPC_ID* = 14
  SECPKG_ATTR_ISSUER_LIST* = 0x50
  SECPKG_ATTR_REMOTE_CRED* = 0x51
  SECPKG_ATTR_LOCAL_CRED* = 0x52
  SECPKG_ATTR_REMOTE_CERT_CONTEXT* = 0x53
  SECPKG_ATTR_LOCAL_CERT_CONTEXT* = 0x54
  SECPKG_ATTR_ROOT_STORE* = 0x55
  SECPKG_ATTR_SUPPORTED_ALGS* = 0x56
  SECPKG_ATTR_CIPHER_STRENGTHS* = 0x57
  SECPKG_ATTR_SUPPORTED_PROTOCOLS* = 0x58
  SECPKG_ATTR_ISSUER_LIST_EX* = 0x59
  SECPKG_ATTR_CONNECTION_INFO* = 0x5a
  SECPKG_ATTR_EAP_KEY_BLOCK* = 0x5b
  SECPKG_ATTR_MAPPED_CRED_ATTR* = 0x5c
  SECPKG_ATTR_SESSION_INFO* = 0x5d
  SECPKG_ATTR_APP_DATA* = 0x5e
  RCRED_STATUS_NOCRED* = 0x00000000
  RCRED_CRED_EXISTS* = 0x00000001
  RCRED_STATUS_UNKNOWN_ISSUER* = 0x00000002
  LCRED_STATUS_NOCRED* = 0x00000000
  LCRED_CRED_EXISTS* = 0x00000001
  LCRED_STATUS_UNKNOWN_ISSUER* = 0x00000002
  SSL_SESSION_RECONNECT* = 1
  SCH_CRED_V1* = 0x00000001
  SCH_CRED_V2* = 0x00000002
  SCH_CRED_VERSION* = 0x00000002
  SCH_CRED_V3* = 0x00000003
  SCHANNEL_CRED_VERSION* = 0x00000004
  SCH_CRED_FORMAT_CERT_HASH* = 0x00000001
  SCH_CRED_MAX_SUPPORTED_ALGS* = 256
  SCH_CRED_MAX_SUPPORTED_CERTS* = 100
  SCH_MACHINE_CERT_HASH* = 0x00000001
  SCH_CRED_NO_SYSTEM_MAPPER* = 0x00000002
  SCH_CRED_NO_SERVERNAME_CHECK* = 0x00000004
  SCH_CRED_MANUAL_CRED_VALIDATION* = 0x00000008
  SCH_CRED_NO_DEFAULT_CREDS* = 0x00000010
  SCH_CRED_AUTO_CRED_VALIDATION* = 0x00000020
  SCH_CRED_USE_DEFAULT_CREDS* = 0x00000040
  SCH_CRED_DISABLE_RECONNECTS* = 0x00000080
  SCH_CRED_REVOCATION_CHECK_END_CERT* = 0x00000100
  SCH_CRED_REVOCATION_CHECK_CHAIN* = 0x00000200
  SCH_CRED_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT* = 0x00000400
  SCH_CRED_IGNORE_NO_REVOCATION_CHECK* = 0x00000800
  SCH_CRED_IGNORE_REVOCATION_OFFLINE* = 0x00001000
  SCH_CRED_REVOCATION_CHECK_CACHE_ONLY* = 0x00004000
  SCH_CRED_CACHE_ONLY_URL_RETRIEVAL* = 0x00008000
  SCHANNEL_RENEGOTIATE* = 0
  SCHANNEL_SHUTDOWN* = 1
  SCHANNEL_ALERT* = 2
  SCHANNEL_SESSION* = 3
  TLS1_ALERT_WARNING* = 1
  TLS1_ALERT_FATAL* = 2
  TLS1_ALERT_CLOSE_NOTIFY* = 0
  TLS1_ALERT_UNEXPECTED_MESSAGE* = 10
  TLS1_ALERT_BAD_RECORD_MAC* = 20
  TLS1_ALERT_DECRYPTION_FAILED* = 21
  TLS1_ALERT_RECORD_OVERFLOW* = 22
  TLS1_ALERT_DECOMPRESSION_FAIL* = 30
  TLS1_ALERT_HANDSHAKE_FAILURE* = 40
  TLS1_ALERT_BAD_CERTIFICATE* = 42
  TLS1_ALERT_UNSUPPORTED_CERT* = 43
  TLS1_ALERT_CERTIFICATE_REVOKED* = 44
  TLS1_ALERT_CERTIFICATE_EXPIRED* = 45
  TLS1_ALERT_CERTIFICATE_UNKNOWN* = 46
  TLS1_ALERT_ILLEGAL_PARAMETER* = 47
  TLS1_ALERT_UNKNOWN_CA* = 48
  TLS1_ALERT_ACCESS_DENIED* = 49
  TLS1_ALERT_DECODE_ERROR* = 50
  TLS1_ALERT_DECRYPT_ERROR* = 51
  TLS1_ALERT_EXPORT_RESTRICTION* = 60
  TLS1_ALERT_PROTOCOL_VERSION* = 70
  TLS1_ALERT_INSUFFIENT_SECURITY* = 71
  TLS1_ALERT_INTERNAL_ERROR* = 80
  TLS1_ALERT_USER_CANCELED* = 90
  TLS1_ALERT_NO_RENEGOTIATATION* = 100
  SSL_SESSION_ENABLE_RECONNECTS* = 1
  SSL_SESSION_DISABLE_RECONNECTS* = 2
  CERT_SCHANNEL_IIS_PRIVATE_KEY_PROP_ID* = CERT_FIRST_USER_PROP_ID+0
  CERT_SCHANNEL_IIS_PASSWORD_PROP_ID* = CERT_FIRST_USER_PROP_ID+1
  CERT_SCHANNEL_SGC_CERTIFICATE_PROP_ID* = CERT_FIRST_USER_PROP_ID+2
  SP_PROT_PCT1_SERVER* = 0x00000001
  SP_PROT_PCT1_CLIENT* = 0x00000002
  SP_PROT_PCT1* = SP_PROT_PCT1_SERVER or SP_PROT_PCT1_CLIENT
  SP_PROT_SSL2_SERVER* = 0x00000004
  SP_PROT_SSL2_CLIENT* = 0x00000008
  SP_PROT_SSL2* = SP_PROT_SSL2_SERVER or SP_PROT_SSL2_CLIENT
  SP_PROT_SSL3_SERVER* = 0x00000010
  SP_PROT_SSL3_CLIENT* = 0x00000020
  SP_PROT_SSL3* = SP_PROT_SSL3_SERVER or SP_PROT_SSL3_CLIENT
  SP_PROT_TLS1_SERVER* = 0x00000040
  SP_PROT_TLS1_CLIENT* = 0x00000080
  SP_PROT_TLS1* = SP_PROT_TLS1_SERVER or SP_PROT_TLS1_CLIENT
  SP_PROT_SSL3TLS1_CLIENTS* = SP_PROT_TLS1_CLIENT or SP_PROT_SSL3_CLIENT
  SP_PROT_SSL3TLS1_SERVERS* = SP_PROT_TLS1_SERVER or SP_PROT_SSL3_SERVER
  SP_PROT_SSL3TLS1* = SP_PROT_SSL3 or SP_PROT_TLS1
  SP_PROT_UNI_SERVER* = 0x40000000
  SP_PROT_UNI_CLIENT* = 0x80000000'i32
  SP_PROT_UNI* = SP_PROT_UNI_SERVER or SP_PROT_UNI_CLIENT
  SP_PROT_ALL* = 0xffffffff'i32
  SP_PROT_NONE* = 0
  SP_PROT_CLIENTS* = SP_PROT_PCT1_CLIENT or SP_PROT_SSL2_CLIENT or SP_PROT_SSL3_CLIENT or SP_PROT_UNI_CLIENT or SP_PROT_TLS1_CLIENT
  SP_PROT_SERVERS* = SP_PROT_PCT1_SERVER or SP_PROT_SSL2_SERVER or SP_PROT_SSL3_SERVER or SP_PROT_UNI_SERVER or SP_PROT_TLS1_SERVER
  SCHANNEL_SECRET_TYPE_CAPI* = 0x00000001
  SCHANNEL_SECRET_PRIVKEY* = 0x00000002
  SCH_CRED_X509_CERTCHAIN* = 0x00000001
  SCH_CRED_X509_CAPI* = 0x00000002
  SCH_CRED_CERT_CONTEXT* = 0x00000003
  SSL_CRACK_CERTIFICATE_NAME* = "SslCrackCertificate"
  SSL_FREE_CERTIFICATE_NAME* = "SslFreeCertificate"
  LDAP_PORT* = 389
  LDAP_SSL_PORT* = 636
  LDAP_GC_PORT* = 3268
  LDAP_SSL_GC_PORT* = 3269
  LDAP_VERSION1* = 1
  LDAP_VERSION2* = 2
  LDAP_VERSION3* = 3
  LDAP_VERSION* = LDAP_VERSION2
  LDAP_BIND_CMD* = 0x60
  LDAP_UNBIND_CMD* = 0x42
  LDAP_SEARCH_CMD* = 0x63
  LDAP_MODIFY_CMD* = 0x66
  LDAP_ADD_CMD* = 0x68
  LDAP_DELETE_CMD* = 0x4a
  LDAP_MODRDN_CMD* = 0x6c
  LDAP_COMPARE_CMD* = 0x6e
  LDAP_ABANDON_CMD* = 0x50
  LDAP_SESSION_CMD* = 0x71
  LDAP_EXTENDED_CMD* = 0x77
  LDAP_RES_BIND* = 0x61
  LDAP_RES_SEARCH_ENTRY* = 0x64
  LDAP_RES_SEARCH_RESULT* = 0x65
  LDAP_RES_MODIFY* = 0x67
  LDAP_RES_ADD* = 0x69
  LDAP_RES_DELETE* = 0x6b
  LDAP_RES_MODRDN* = 0x6d
  LDAP_RES_COMPARE* = 0x6f
  LDAP_RES_SESSION* = 0x72
  LDAP_RES_REFERRAL* = 0x73
  LDAP_RES_EXTENDED* = 0x78
  LDAP_RES_ANY* = -1
  LDAP_INVALID_CMD* = 0xff
  LDAP_INVALID_RES* = 0xff
  LDAP_SUCCESS* = 0x00
  LDAP_OPERATIONS_ERROR* = 0x01
  LDAP_PROTOCOL_ERROR* = 0x02
  LDAP_TIMELIMIT_EXCEEDED* = 0x03
  LDAP_SIZELIMIT_EXCEEDED* = 0x04
  LDAP_COMPARE_FALSE* = 0x05
  LDAP_COMPARE_TRUE* = 0x06
  LDAP_AUTH_METHOD_NOT_SUPPORTED* = 0x07
  LDAP_STRONG_AUTH_REQUIRED* = 0x08
  LDAP_REFERRAL_V2* = 0x09
  LDAP_PARTIAL_RESULTS* = 0x09
  LDAP_REFERRAL* = 0x0a
  LDAP_ADMIN_LIMIT_EXCEEDED* = 0x0b
  LDAP_UNAVAILABLE_CRIT_EXTENSION* = 0x0c
  LDAP_CONFIDENTIALITY_REQUIRED* = 0x0d
  LDAP_SASL_BIND_IN_PROGRESS* = 0x0e
  LDAP_NO_SUCH_ATTRIBUTE* = 0x10
  LDAP_UNDEFINED_TYPE* = 0x11
  LDAP_INAPPROPRIATE_MATCHING* = 0x12
  LDAP_CONSTRAINT_VIOLATION* = 0x13
  LDAP_ATTRIBUTE_OR_VALUE_EXISTS* = 0x14
  LDAP_INVALID_SYNTAX* = 0x15
  LDAP_NO_SUCH_OBJECT* = 0x20
  LDAP_ALIAS_PROBLEM* = 0x21
  LDAP_INVALID_DN_SYNTAX* = 0x22
  LDAP_IS_LEAF* = 0x23
  LDAP_ALIAS_DEREF_PROBLEM* = 0x24
  LDAP_INAPPROPRIATE_AUTH* = 0x30
  LDAP_INVALID_CREDENTIALS* = 0x31
  LDAP_INSUFFICIENT_RIGHTS* = 0x32
  LDAP_BUSY* = 0x33
  LDAP_UNAVAILABLE* = 0x34
  LDAP_UNWILLING_TO_PERFORM* = 0x35
  LDAP_LOOP_DETECT* = 0x36
  LDAP_SORT_CONTROL_MISSING* = 0x3C
  LDAP_OFFSET_RANGE_ERROR* = 0x3D
  LDAP_NAMING_VIOLATION* = 0x40
  LDAP_OBJECT_CLASS_VIOLATION* = 0x41
  LDAP_NOT_ALLOWED_ON_NONLEAF* = 0x42
  LDAP_NOT_ALLOWED_ON_RDN* = 0x43
  LDAP_ALREADY_EXISTS* = 0x44
  LDAP_NO_OBJECT_CLASS_MODS* = 0x45
  LDAP_RESULTS_TOO_LARGE* = 0x46
  LDAP_AFFECTS_MULTIPLE_DSAS* = 0x47
  LDAP_VIRTUAL_LIST_VIEW_ERROR* = 0x4c
  LDAP_OTHER* = 0x50
  LDAP_SERVER_DOWN* = 0x51
  LDAP_LOCAL_ERROR* = 0x52
  LDAP_ENCODING_ERROR* = 0x53
  LDAP_DECODING_ERROR* = 0x54
  LDAP_TIMEOUT* = 0x55
  LDAP_AUTH_UNKNOWN* = 0x56
  LDAP_FILTER_ERROR* = 0x57
  LDAP_USER_CANCELLED* = 0x58
  LDAP_PARAM_ERROR* = 0x59
  LDAP_NO_MEMORY* = 0x5a
  LDAP_CONNECT_ERROR* = 0x5b
  LDAP_NOT_SUPPORTED* = 0x5c
  LDAP_NO_RESULTS_RETURNED* = 0x5e
  LDAP_CONTROL_NOT_FOUND* = 0x5d
  LDAP_MORE_RESULTS_TO_RETURN* = 0x5f
  LDAP_CLIENT_LOOP* = 0x60
  LDAP_REFERRAL_LIMIT_EXCEEDED* = 0x61
  LDAP_AUTH_SIMPLE* = 0x80
  LDAP_AUTH_SASL* = 0x83
  LDAP_AUTH_OTHERKIND* = 0x86
  LDAP_AUTH_SICILY* = LDAP_AUTH_OTHERKIND or 0x0200
  LDAP_AUTH_MSN* = LDAP_AUTH_OTHERKIND or 0x0800
  LDAP_AUTH_NTLM* = LDAP_AUTH_OTHERKIND or 0x1000
  LDAP_AUTH_DPA* = LDAP_AUTH_OTHERKIND or 0x2000
  LDAP_AUTH_NEGOTIATE* = LDAP_AUTH_OTHERKIND or 0x0400
  LDAP_AUTH_SSPI* = LDAP_AUTH_NEGOTIATE
  LDAP_AUTH_DIGEST* = LDAP_AUTH_OTHERKIND or 0x4000
  LDAP_AUTH_EXTERNAL* = LDAP_AUTH_OTHERKIND or 0x0020
  LDAP_FILTER_AND* = 0xa0
  LDAP_FILTER_OR* = 0xa1
  LDAP_FILTER_NOT* = 0xa2
  LDAP_FILTER_EQUALITY* = 0xa3
  LDAP_FILTER_SUBSTRINGS* = 0xa4
  LDAP_FILTER_GE* = 0xa5
  LDAP_FILTER_LE* = 0xa6
  LDAP_FILTER_PRESENT* = 0x87
  LDAP_FILTER_APPROX* = 0xa8
  LDAP_FILTER_EXTENSIBLE* = 0xa9
  LDAP_SUBSTRING_INITIAL* = 0x80
  LDAP_SUBSTRING_ANY* = 0x81
  LDAP_SUBSTRING_FINAL* = 0x82
  LDAP_DEREF_NEVER* = 0
  LDAP_DEREF_SEARCHING* = 1
  LDAP_DEREF_FINDING* = 2
  LDAP_DEREF_ALWAYS* = 3
  LDAP_NO_LIMIT* = 0
  LDAP_OPT_DNS* = 0x00000001
  LDAP_OPT_CHASE_REFERRALS* = 0x00000002
  LDAP_OPT_RETURN_REFS* = 0x00000004
  LDAP_CONTROL_REFERRALS_W* = "1.2.840.113556.1.4.616"
  LDAP_CONTROL_REFERRALS* = "1.2.840.113556.1.4.616"
  LDAP_MOD_ADD* = 0x00
  LDAP_MOD_DELETE* = 0x01
  LDAP_MOD_REPLACE* = 0x02
  LDAP_MOD_BVALUES* = 0x80
  LDAP_OPT_API_INFO* = 0x00
  LDAP_OPT_DESC* = 0x01
  LDAP_OPT_DEREF* = 0x02
  LDAP_OPT_SIZELIMIT* = 0x03
  LDAP_OPT_TIMELIMIT* = 0x04
  LDAP_OPT_THREAD_FN_PTRS* = 0x05
  LDAP_OPT_REBIND_FN* = 0x06
  LDAP_OPT_REBIND_ARG* = 0x07
  LDAP_OPT_REFERRALS* = 0x08
  LDAP_OPT_RESTART* = 0x09
  LDAP_OPT_SSL* = 0x0a
  LDAP_OPT_IO_FN_PTRS* = 0x0b
  LDAP_OPT_CACHE_FN_PTRS* = 0x0d
  LDAP_OPT_CACHE_STRATEGY* = 0x0e
  LDAP_OPT_CACHE_ENABLE* = 0x0f
  LDAP_OPT_REFERRAL_HOP_LIMIT* = 0x10
  LDAP_OPT_PROTOCOL_VERSION* = 0x11
  LDAP_OPT_VERSION* = 0x11
  LDAP_OPT_API_FEATURE_INFO* = 0x15
  LDAP_OPT_HOST_NAME* = 0x30
  LDAP_OPT_ERROR_NUMBER* = 0x31
  LDAP_OPT_ERROR_STRING* = 0x32
  LDAP_OPT_SERVER_ERROR* = 0x33
  LDAP_OPT_SERVER_EXT_ERROR* = 0x34
  LDAP_OPT_HOST_REACHABLE* = 0x3E
  LDAP_OPT_PING_KEEP_ALIVE* = 0x36
  LDAP_OPT_PING_WAIT_TIME* = 0x37
  LDAP_OPT_PING_LIMIT* = 0x38
  LDAP_OPT_DNSDOMAIN_NAME* = 0x3B
  LDAP_OPT_GETDSNAME_FLAGS* = 0x3D
  LDAP_OPT_PROMPT_CREDENTIALS* = 0x3F
  LDAP_OPT_AUTO_RECONNECT* = 0x91
  LDAP_OPT_SSPI_FLAGS* = 0x92
  LDAP_OPT_SSL_INFO* = 0x93
  LDAP_OPT_TLS* = LDAP_OPT_SSL
  LDAP_OPT_TLS_INFO* = LDAP_OPT_SSL_INFO
  LDAP_OPT_SIGN* = 0x95
  LDAP_OPT_ENCRYPT* = 0x96
  LDAP_OPT_SASL_METHOD* = 0x97
  LDAP_OPT_AREC_EXCLUSIVE* = 0x98
  LDAP_OPT_SECURITY_CONTEXT* = 0x99
  LDAP_OPT_ROOTDSE_CACHE* = 0x9a
  LDAP_OPT_TCP_KEEPALIVE* = 0x40
  LDAP_OPT_FAST_CONCURRENT_BIND* = 0x41
  LDAP_OPT_SEND_TIMEOUT* = 0x42
  LDAP_CHASE_SUBORDINATE_REFERRALS* = 0x00000020
  LDAP_CHASE_EXTERNAL_REFERRALS* = 0x00000040
  LDAP_SCOPE_BASE* = 0x00
  LDAP_SCOPE_ONELEVEL* = 0x01
  LDAP_SCOPE_SUBTREE* = 0x02
  LDAP_MSG_ONE* = 0
  LDAP_MSG_ALL* = 1
  LDAP_MSG_RECEIVED* = 2
  LBER_USE_DER* = 0x01
  LBER_USE_INDEFINITE_LEN* = 0x02
  LBER_TRANSLATE_STRINGS* = 0x04
  LAPI_MAJOR_VER1* = 1
  LAPI_MINOR_VER1* = 1
  LDAP_API_INFO_VERSION* = 1
  LDAP_API_VERSION* = 2004
  LDAP_VERSION_MIN* = 2
  LDAP_VERSION_MAX* = 3
  LDAP_VENDOR_NAME* = "Microsoft Corporation."
  LDAP_VENDOR_NAME_W* = "Microsoft Corporation."
  LDAP_VENDOR_VERSION* = 510
  LDAP_FEATURE_INFO_VERSION* = 1
  LDAP_SERVER_SORT_OID* = "1.2.840.113556.1.4.473"
  LDAP_SERVER_SORT_OID_W* = "1.2.840.113556.1.4.473"
  LDAP_SERVER_RESP_SORT_OID* = "1.2.840.113556.1.4.474"
  LDAP_SERVER_RESP_SORT_OID_W* = "1.2.840.113556.1.4.474"
  LDAP_PAGED_RESULT_OID_STRING* = "1.2.840.113556.1.4.319"
  LDAP_PAGED_RESULT_OID_STRING_W* = "1.2.840.113556.1.4.319"
  LDAP_CONTROL_VLVREQUEST* = "2.16.840.1.113730.3.4.9"
  LDAP_CONTROL_VLVREQUEST_W* = "2.16.840.1.113730.3.4.9"
  LDAP_CONTROL_VLVRESPONSE* = "2.16.840.1.113730.3.4.10"
  LDAP_CONTROL_VLVRESPONSE_W* = "2.16.840.1.113730.3.4.10"
  LDAP_API_FEATURE_VIRTUAL_LIST_VIEW* = 1001
  LDAP_VLVINFO_VERSION* = 1
  LDAP_START_TLS_OID* = "1.3.6.1.4.1.1466.20037"
  LDAP_START_TLS_OID_W* = "1.3.6.1.4.1.1466.20037"
  LDAP_TTL_EXTENDED_OP_OID* = "1.3.6.1.4.1.1466.101.119.1"
  LDAP_TTL_EXTENDED_OP_OID_W* = "1.3.6.1.4.1.1466.101.119.1"
  LDAP_OPT_REFERRAL_CALLBACK* = 0x70
  LDAP_OPT_CLIENT_CERTIFICATE* = 0x80
  LDAP_OPT_SERVER_CERTIFICATE* = 0x81
  LDAP_OPT_REF_DEREF_CONN_PER_MSG* = 0x94
  LDAP_OPT_ON* = 0x00000001
  LDAP_OPT_OFF* = 0x00000000
type
  BerElement* {.pure.} = object
    opaque*: PCHAR
const
  NULLBER* = cast[ptr BerElement](0)
type
  SSL_EMPTY_CACHE_FN_A* = proc (pszTargetName: LPSTR, dwFlags: DWORD): WINBOOL {.stdcall.}
  SSL_EMPTY_CACHE_FN_W* = proc (pszTargetName: LPWSTR, dwFlags: DWORD): WINBOOL {.stdcall.}
  SSL_CRACK_CERTIFICATE_FN* = proc (pbCertificate: PUCHAR, cbCertificate: DWORD, VerifySignature: WINBOOL, ppCertificate: ptr PX509Certificate): WINBOOL {.stdcall.}
  SSL_FREE_CERTIFICATE_FN* = proc (pCertificate: PX509Certificate): VOID {.stdcall.}
  QUERYCLIENTCERT* = proc (Connection: PLDAP, trusted_CAs: PSecPkgContext_IssuerListInfoEx, ppCertificate: ptr PCCERT_CONTEXT): BOOLEAN {.stdcall.}
  VERIFYSERVERCERT* = proc (Connection: PLDAP, pServerCert: PCCERT_CONTEXT): BOOLEAN {.stdcall.}
  SCHANNEL_ALERT_TOKEN* {.pure.} = object
    dwTokenType*: DWORD
    dwAlertType*: DWORD
    dwAlertNumber*: DWORD
  SCHANNEL_SESSION_TOKEN* {.pure.} = object
    dwTokenType*: DWORD
    dwFlags*: DWORD
  LDAPAPIInfoA* {.pure.} = object
    ldapai_info_version*: int32
    ldapai_api_version*: int32
    ldapai_protocol_version*: int32
    ldapai_extensions*: ptr ptr char
    ldapai_vendor_name*: ptr char
    ldapai_vendor_version*: int32
  LDAPAPIInfoW* {.pure.} = object
    ldapai_info_version*: int32
    ldapai_api_version*: int32
    ldapai_protocol_version*: int32
    ldapai_extensions*: ptr PWCHAR
    ldapai_vendor_name*: PWCHAR
    ldapai_vendor_version*: int32
  LDAPAPIFeatureInfoA* {.pure.} = object
    ldapaif_info_version*: int32
    ldapaif_name*: ptr char
    ldapaif_version*: int32
  LDAPAPIFeatureInfoW* {.pure.} = object
    ldapaif_info_version*: int32
    ldapaif_name*: PWCHAR
    ldapaif_version*: int32
proc ber_init*(pBerVal: ptr BERVAL): ptr BerElement {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_free*(pBerElement: ptr BerElement, fbuf: INT): VOID {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_bvfree*(pBerVal: ptr BERVAL): VOID {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_bvecfree*(pBerVal: ptr PBERVAL): VOID {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_bvdup*(pBerVal: ptr BERVAL): ptr BERVAL {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_alloc_t*(options: INT): ptr BerElement {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_skip_tag*(pBerElement: ptr BerElement, pLen: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_peek_tag*(pBerElement: ptr BerElement, pLen: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_first_element*(pBerElement: ptr BerElement, pLen: ptr ULONG, ppOpaque: ptr ptr CHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_next_element*(pBerElement: ptr BerElement, pLen: ptr ULONG, opaque: ptr CHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_flatten*(pBerElement: ptr BerElement, pBerVal: ptr PBERVAL): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_printf*(pBerElement: ptr BerElement, fmt: PSTR): INT {.winapi, cdecl, varargs, dynlib: "wldap32", importc.}
proc ber_scanf*(pBerElement: ptr BerElement, fmt: PSTR): ULONG {.winapi, cdecl, varargs, dynlib: "wldap32", importc.}
proc SslEmptyCacheA*(pszTargetName: LPSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "schannel", importc.}
proc SslEmptyCacheW*(pszTargetName: LPWSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "schannel", importc.}
proc SslGenerateRandomBits*(pRandomData: PUCHAR, cRandomData: LONG): VOID {.winapi, stdcall, dynlib: "schannel", importc.}
proc SslCrackCertificate*(pbCertificate: PUCHAR, cbCertificate: DWORD, dwFlags: DWORD, ppCertificate: ptr PX509Certificate): WINBOOL {.winapi, stdcall, dynlib: "schannel", importc.}
proc SslFreeCertificate*(pCertificate: PX509Certificate): VOID {.winapi, stdcall, dynlib: "schannel", importc.}
proc SslGetMaximumKeySize*(Reserved: DWORD): DWORD {.winapi, stdcall, dynlib: "schannel", importc.}
proc ldap_openW*(HostName: PWCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_openA*(HostName: PCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_initW*(HostName: PWCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_initA*(HostName: PCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_sslinitW*(HostName: PWCHAR, PortNumber: ULONG, secure: int32): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_sslinitA*(HostName: PCHAR, PortNumber: ULONG, secure: int32): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_connect*(ld: ptr LDAP, timeout: ptr LDAP_TIMEVAL): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc cldap_openW*(HostName: PWCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
proc cldap_openA*(HostName: PCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_unbind*(ld: ptr LDAP): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_unbind_s*(ld: ptr LDAP): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_optionW*(ld: ptr LDAP, option: int32, outvalue: pointer): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_set_optionW*(ld: ptr LDAP, option: int32, invalue: pointer): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_simple_bindW*(ld: ptr LDAP, dn: PWCHAR, passwd: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_simple_bindA*(ld: ptr LDAP, dn: PCHAR, passwd: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_simple_bind_sW*(ld: ptr LDAP, dn: PWCHAR, passwd: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_simple_bind_sA*(ld: ptr LDAP, dn: PCHAR, passwd: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_bindW*(ld: ptr LDAP, dn: PWCHAR, cred: PWCHAR, `method`: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_bindA*(ld: ptr LDAP, dn: PCHAR, cred: PCHAR, `method`: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_bind_sW*(ld: ptr LDAP, dn: PWCHAR, cred: PWCHAR, `method`: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_bind_sA*(ld: ptr LDAP, dn: PCHAR, cred: PCHAR, `method`: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_sasl_bindA*(ExternalHandle: ptr LDAP, DistName: PCHAR, AuthMechanism: PCHAR, cred: ptr BERVAL, ServerCtrls: ptr PLDAPControlA, ClientCtrls: ptr PLDAPControlA, MessageNumber: ptr int32): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_sasl_bindW*(ExternalHandle: ptr LDAP, DistName: PWCHAR, AuthMechanism: PWCHAR, cred: ptr BERVAL, ServerCtrls: ptr PLDAPControlW, ClientCtrls: ptr PLDAPControlW, MessageNumber: ptr int32): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_sasl_bind_sA*(ExternalHandle: ptr LDAP, DistName: PCHAR, AuthMechanism: PCHAR, cred: ptr BERVAL, ServerCtrls: ptr PLDAPControlA, ClientCtrls: ptr PLDAPControlA, ServerData: ptr PBERVAL): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_sasl_bind_sW*(ExternalHandle: ptr LDAP, DistName: PWCHAR, AuthMechanism: PWCHAR, cred: ptr BERVAL, ServerCtrls: ptr PLDAPControlW, ClientCtrls: ptr PLDAPControlW, ServerData: ptr PBERVAL): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_searchW*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_searchA*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_sW*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_sA*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_stW*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG, timeout: ptr LDAP_TIMEVAL, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_stA*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG, timeout: ptr LDAP_TIMEVAL, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_extW*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, TimeLimit: ULONG, SizeLimit: ULONG, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_extA*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, TimeLimit: ULONG, SizeLimit: ULONG, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_ext_sW*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, timeout: ptr LDAP_TIMEVAL, SizeLimit: ULONG, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_ext_sA*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, timeout: ptr LDAP_TIMEVAL, SizeLimit: ULONG, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_check_filterW*(ld: ptr LDAP, SearchFilter: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_check_filterA*(ld: ptr LDAP, SearchFilter: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modifyW*(ld: ptr LDAP, dn: PWCHAR, mods: ptr ptr LDAPModW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modifyA*(ld: ptr LDAP, dn: PCHAR, mods: ptr ptr LDAPModA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modify_sW*(ld: ptr LDAP, dn: PWCHAR, mods: ptr ptr LDAPModW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modify_sA*(ld: ptr LDAP, dn: PCHAR, mods: ptr ptr LDAPModA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modify_extW*(ld: ptr LDAP, dn: PWCHAR, mods: ptr ptr LDAPModW, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modify_extA*(ld: ptr LDAP, dn: PCHAR, mods: ptr ptr LDAPModA, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modify_ext_sW*(ld: ptr LDAP, dn: PWCHAR, mods: ptr ptr LDAPModW, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modify_ext_sA*(ld: ptr LDAP, dn: PCHAR, mods: ptr ptr LDAPModA, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modrdn2W*(ExternalHandle: ptr LDAP, DistinguishedName: PWCHAR, NewDistinguishedName: PWCHAR, DeleteOldRdn: INT): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modrdn2A*(ExternalHandle: ptr LDAP, DistinguishedName: PCHAR, NewDistinguishedName: PCHAR, DeleteOldRdn: INT): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modrdnW*(ExternalHandle: ptr LDAP, DistinguishedName: PWCHAR, NewDistinguishedName: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modrdnA*(ExternalHandle: ptr LDAP, DistinguishedName: PCHAR, NewDistinguishedName: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modrdn2_sW*(ExternalHandle: ptr LDAP, DistinguishedName: PWCHAR, NewDistinguishedName: PWCHAR, DeleteOldRdn: INT): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modrdn2_sA*(ExternalHandle: ptr LDAP, DistinguishedName: PCHAR, NewDistinguishedName: PCHAR, DeleteOldRdn: INT): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modrdn_sW*(ExternalHandle: ptr LDAP, DistinguishedName: PWCHAR, NewDistinguishedName: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_modrdn_sA*(ExternalHandle: ptr LDAP, DistinguishedName: PCHAR, NewDistinguishedName: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_rename_extW*(ld: ptr LDAP, dn: PWCHAR, NewRDN: PWCHAR, NewParent: PWCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_rename_extA*(ld: ptr LDAP, dn: PCHAR, NewRDN: PCHAR, NewParent: PCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_rename_ext_sW*(ld: ptr LDAP, dn: PWCHAR, NewRDN: PWCHAR, NewParent: PWCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_rename_ext_sA*(ld: ptr LDAP, dn: PCHAR, NewRDN: PCHAR, NewParent: PCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_addW*(ld: ptr LDAP, dn: PWCHAR, attrs: ptr ptr LDAPModW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_addA*(ld: ptr LDAP, dn: PCHAR, attrs: ptr ptr LDAPModA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_add_sW*(ld: ptr LDAP, dn: PWCHAR, attrs: ptr ptr LDAPModW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_add_sA*(ld: ptr LDAP, dn: PCHAR, attrs: ptr ptr LDAPModA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_add_extW*(ld: ptr LDAP, dn: PWCHAR, attrs: ptr ptr LDAPModW, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_add_extA*(ld: ptr LDAP, dn: PCHAR, attrs: ptr ptr LDAPModA, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_add_ext_sW*(ld: ptr LDAP, dn: PWCHAR, attrs: ptr ptr LDAPModW, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_add_ext_sA*(ld: ptr LDAP, dn: PCHAR, attrs: ptr ptr LDAPModA, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_compareW*(ld: ptr LDAP, dn: PWCHAR, attr: PWCHAR, value: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_compareA*(ld: ptr LDAP, dn: PCHAR, attr: PCHAR, value: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_compare_sW*(ld: ptr LDAP, dn: PWCHAR, attr: PWCHAR, value: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_compare_sA*(ld: ptr LDAP, dn: PCHAR, attr: PCHAR, value: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_compare_extW*(ld: ptr LDAP, dn: PWCHAR, Attr: PWCHAR, Value: PWCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_compare_extA*(ld: ptr LDAP, dn: PCHAR, Attr: PCHAR, Value: PCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_compare_ext_sW*(ld: ptr LDAP, dn: PWCHAR, Attr: PWCHAR, Value: PWCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_compare_ext_sA*(ld: ptr LDAP, dn: PCHAR, Attr: PCHAR, Value: PCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_deleteW*(ld: ptr LDAP, dn: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_deleteA*(ld: ptr LDAP, dn: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_delete_sW*(ld: ptr LDAP, dn: PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_delete_sA*(ld: ptr LDAP, dn: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_delete_extW*(ld: ptr LDAP, dn: PWCHAR, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_delete_extA*(ld: ptr LDAP, dn: PCHAR, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_delete_ext_sW*(ld: ptr LDAP, dn: PWCHAR, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_delete_ext_sA*(ld: ptr LDAP, dn: PCHAR, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_abandon*(ld: ptr LDAP, msgid: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_result*(ld: ptr LDAP, msgid: ULONG, all: ULONG, timeout: ptr LDAP_TIMEVAL, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_msgfree*(res: ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_result2error*(ld: ptr LDAP, res: ptr LDAPMessage, freeit: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_resultW*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, ReturnCode: ptr ULONG, MatchedDNs: ptr PWCHAR, ErrorMessage: ptr PWCHAR, Referrals: ptr ptr PWCHAR, ServerControls: ptr ptr PLDAPControlW, Freeit: BOOLEAN): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_resultA*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, ReturnCode: ptr ULONG, MatchedDNs: ptr PCHAR, ErrorMessage: ptr PCHAR, Referrals: ptr ptr PCHAR, ServerControls: ptr ptr PLDAPControlA, Freeit: BOOLEAN): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_extended_resultA*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, ResultOID: ptr PCHAR, ResultData: ptr ptr BERVAL, Freeit: BOOLEAN): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_extended_resultW*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, ResultOID: ptr PWCHAR, ResultData: ptr ptr BERVAL, Freeit: BOOLEAN): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_controls_freeA*(Controls: ptr ptr LDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_control_freeA*(Controls: ptr LDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_controls_freeW*(Control: ptr ptr LDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_control_freeW*(Control: ptr LDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_free_controlsW*(Controls: ptr ptr LDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_free_controlsA*(Controls: ptr ptr LDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_err2stringW*(err: ULONG): PWCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_err2stringA*(err: ULONG): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_perror*(ld: ptr LDAP, msg: PCHAR): void {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_first_entry*(ld: ptr LDAP, res: ptr LDAPMessage): ptr LDAPMessage {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_next_entry*(ld: ptr LDAP, entry: ptr LDAPMessage): ptr LDAPMessage {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_count_entries*(ld: ptr LDAP, res: ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_first_attributeW*(ld: ptr LDAP, entry: ptr LDAPMessage, `ptr`: ptr ptr BerElement): PWCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_first_attributeA*(ld: ptr LDAP, entry: ptr LDAPMessage, `ptr`: ptr ptr BerElement): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_next_attributeW*(ld: ptr LDAP, entry: ptr LDAPMessage, `ptr`: ptr BerElement): PWCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_next_attributeA*(ld: ptr LDAP, entry: ptr LDAPMessage, `ptr`: ptr BerElement): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_valuesW*(ld: ptr LDAP, entry: ptr LDAPMessage, attr: PWCHAR): ptr PWCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_valuesA*(ld: ptr LDAP, entry: ptr LDAPMessage, attr: PCHAR): ptr PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_values_lenW*(ExternalHandle: ptr LDAP, Message: ptr LDAPMessage, attr: PWCHAR): ptr ptr BERVAL {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_values_lenA*(ExternalHandle: ptr LDAP, Message: ptr LDAPMessage, attr: PCHAR): ptr ptr BERVAL {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_count_valuesW*(vals: ptr PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_count_valuesA*(vals: ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_count_values_len*(vals: ptr ptr BERVAL): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_value_freeW*(vals: ptr PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_value_freeA*(vals: ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_value_free_len*(vals: ptr ptr BERVAL): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_dnW*(ld: ptr LDAP, entry: ptr LDAPMessage): PWCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_dnA*(ld: ptr LDAP, entry: ptr LDAPMessage): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_explode_dnW*(dn: PWCHAR, notypes: ULONG): ptr PWCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_explode_dnA*(dn: PCHAR, notypes: ULONG): ptr PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_dn2ufnW*(dn: PWCHAR): PWCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_dn2ufnA*(dn: PCHAR): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_memfreeW*(Block: PWCHAR): VOID {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_memfreeA*(Block: PCHAR): VOID {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ber_bvfree*(bv: ptr BERVAL): VOID {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_ufn2dnW*(ufn: PWCHAR, pDn: ptr PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_ufn2dnA*(ufn: PCHAR, pDn: ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_startup*(version: PLDAP_VERSION_INFO, Instance: ptr HANDLE): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_cleanup*(hInstance: HANDLE): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_escape_filter_elementW*(sourceFilterElement: PCHAR, sourceLength: ULONG, destFilterElement: PWCHAR, destLength: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_escape_filter_elementA*(sourceFilterElement: PCHAR, sourceLength: ULONG, destFilterElement: PCHAR, destLength: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_set_dbg_flags*(NewFlags: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_set_dbg_routine*(DebugPrintRoutine: DBGPRINT): VOID {.winapi, cdecl, dynlib: "wldap32", importc.}
proc LdapUTF8ToUnicode*(lpSrcStr: LPCSTR, cchSrc: int32, lpDestStr: LPWSTR, cchDest: int32): int32 {.winapi, cdecl, dynlib: "wldap32", importc.}
proc LdapUnicodeToUTF8*(lpSrcStr: LPCWSTR, cchSrc: int32, lpDestStr: LPSTR, cchDest: int32): int32 {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_create_sort_controlA*(ExternalHandle: PLDAP, SortKeys: ptr PLDAPSortKeyA, IsCritical: UCHAR, Control: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_create_sort_controlW*(ExternalHandle: PLDAP, SortKeys: ptr PLDAPSortKeyW, IsCritical: UCHAR, Control: ptr PLDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_sort_controlA*(ExternalHandle: PLDAP, Control: ptr PLDAPControlA, Result: ptr ULONG, Attribute: ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_sort_controlW*(ExternalHandle: PLDAP, Control: ptr PLDAPControlW, Result: ptr ULONG, Attribute: ptr PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_encode_sort_controlW*(ExternalHandle: PLDAP, SortKeys: ptr PLDAPSortKeyW, Control: PLDAPControlW, Criticality: BOOLEAN): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_encode_sort_controlA*(ExternalHandle: PLDAP, SortKeys: ptr PLDAPSortKeyA, Control: PLDAPControlA, Criticality: BOOLEAN): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_create_page_controlW*(ExternalHandle: PLDAP, PageSize: ULONG, Cookie: ptr BERVAL, IsCritical: UCHAR, Control: ptr PLDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_create_page_controlA*(ExternalHandle: PLDAP, PageSize: ULONG, Cookie: ptr BERVAL, IsCritical: UCHAR, Control: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_page_controlW*(ExternalHandle: PLDAP, ServerControls: ptr PLDAPControlW, TotalCount: ptr ULONG, Cookie: ptr ptr BERVAL): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_page_controlA*(ExternalHandle: PLDAP, ServerControls: ptr PLDAPControlA, TotalCount: ptr ULONG, Cookie: ptr ptr BERVAL): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_init_pageW*(ExternalHandle: PLDAP, DistinguishedName: PWCHAR, ScopeOfSearch: ULONG, SearchFilter: PWCHAR, AttributeList: ptr PWCHAR, AttributesOnly: ULONG, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, PageTimeLimit: ULONG, TotalSizeLimit: ULONG, SortKeys: ptr PLDAPSortKeyW): PLDAPSearch {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_init_pageA*(ExternalHandle: PLDAP, DistinguishedName: PCHAR, ScopeOfSearch: ULONG, SearchFilter: PCHAR, AttributeList: ptr PCHAR, AttributesOnly: ULONG, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, PageTimeLimit: ULONG, TotalSizeLimit: ULONG, SortKeys: ptr PLDAPSortKeyA): PLDAPSearch {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_next_page*(ExternalHandle: PLDAP, SearchHandle: PLDAPSearch, PageSize: ULONG, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_next_page_s*(ExternalHandle: PLDAP, SearchHandle: PLDAPSearch, timeout: ptr LDAP_TIMEVAL, PageSize: ULONG, TotalCount: ptr ULONG, Results: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_get_paged_count*(ExternalHandle: PLDAP, SearchBlock: PLDAPSearch, TotalCount: ptr ULONG, Results: PLDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_search_abandon_page*(ExternalHandle: PLDAP, SearchBlock: PLDAPSearch): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_create_vlv_controlW*(ExternalHandle: PLDAP, VlvInfo: PLDAPVLVInfo, IsCritical: UCHAR, Control: ptr PLDAPControlW): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_create_vlv_controlA*(ExternalHandle: PLDAP, VlvInfo: PLDAPVLVInfo, IsCritical: UCHAR, Control: ptr PLDAPControlA): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_vlv_controlW*(ExternalHandle: PLDAP, Control: ptr PLDAPControlW, TargetPos: PULONG, ListCount: PULONG, Context: ptr PBERVAL, ErrCode: PINT): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_vlv_controlA*(ExternalHandle: PLDAP, Control: ptr PLDAPControlA, TargetPos: PULONG, ListCount: PULONG, Context: ptr PBERVAL, ErrCode: PINT): INT {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_start_tls_sW*(ExternalHandle: PLDAP, ServerReturnValue: PULONG, result: ptr ptr LDAPMessage, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_start_tls_sA*(ExternalHandle: PLDAP, ServerReturnValue: PULONG, result: ptr ptr LDAPMessage, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_stop_tls_s*(ExternalHandle: PLDAP): BOOLEAN {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_first_reference*(ld: ptr LDAP, res: ptr LDAPMessage): ptr LDAPMessage {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_next_reference*(ld: ptr LDAP, entry: ptr LDAPMessage): ptr LDAPMessage {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_count_references*(ld: ptr LDAP, res: ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_referenceW*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, Referrals: ptr ptr PWCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_parse_referenceA*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, Referrals: ptr ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_extended_operationW*(ld: ptr LDAP, Oid: PWCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_extended_operationA*(ld: ptr LDAP, Oid: PCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_extended_operation_sA*(ExternalHandle: ptr LDAP, Oid: PCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, ReturnedOid: ptr PCHAR, ReturnedData: ptr ptr BERVAL): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_extended_operation_sW*(ExternalHandle: ptr LDAP, Oid: PWCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, ReturnedOid: ptr PWCHAR, ReturnedData: ptr ptr BERVAL): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_close_extended_op*(ld: ptr LDAP, MessageNumber: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc LdapGetLastError*(): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc LdapMapErrorToWin32*(LdapError: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
proc ldap_conn_from_msg*(PrimaryConn: ptr LDAP, res: ptr LDAPMessage): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
when winimUnicode:
  type
    LDAPControl* = LDAPControlW
    PLDAPControl* = PLDAPControlW
    LDAPMod* = LDAPModW
    PLDAPMod* = PLDAPModW
    LDAPAPIInfo* = LDAPAPIInfoW
    LDAPAPIFeatureInfo* = LDAPAPIFeatureInfoW
    LDAPSortKey* = LDAPSortKeyW
    PLDAPSortKey* = PLDAPSortKeyW
    SSL_EMPTY_CACHE_FN* = SSL_EMPTY_CACHE_FN_W
  const
    LDAP_UNICODE* = 1
    UNISP_NAME* = UNISP_NAME_W
    PCT1SP_NAME* = PCT1SP_NAME_W
    SSL2SP_NAME* = SSL2SP_NAME_W
    SSL3SP_NAME* = SSL3SP_NAME_W
    TLS1SP_NAME* = TLS1SP_NAME_W
    SCHANNEL_NAME* = SCHANNEL_NAME_W
  proc ldap_open*(HostName: PWCHAR, PortNumber: ULONG): ptr LDAP {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_openW".}
  proc ldap_init*(HostName: PWCHAR, PortNumber: ULONG): ptr LDAP {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_initW".}
  proc ldap_sslinit*(HostName: PWCHAR, PortNumber: ULONG, secure: int32): ptr LDAP {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_sslinitW".}
  proc cldap_open*(HostName: PWCHAR, PortNumber: ULONG): ptr LDAP {.winapi, stdcall, dynlib: "wldap32", importc: "cldap_openW".}
  proc ldap_get_option*(ld: ptr LDAP, option: int32, outvalue: pointer): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_get_optionW".}
  proc ldap_set_option*(ld: ptr LDAP, option: int32, invalue: pointer): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_set_optionW".}
  proc ldap_simple_bind*(ld: ptr LDAP, dn: PWCHAR, passwd: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_simple_bindW".}
  proc ldap_simple_bind_s*(ld: ptr LDAP, dn: PWCHAR, passwd: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_simple_bind_sW".}
  proc ldap_bind*(ld: ptr LDAP, dn: PWCHAR, cred: PWCHAR, `method`: ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_bindW".}
  proc ldap_bind_s*(ld: ptr LDAP, dn: PWCHAR, cred: PWCHAR, `method`: ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_bind_sW".}
  proc ldap_sasl_bind*(ExternalHandle: ptr LDAP, DistName: PWCHAR, AuthMechanism: PWCHAR, cred: ptr BERVAL, ServerCtrls: ptr PLDAPControlW, ClientCtrls: ptr PLDAPControlW, MessageNumber: ptr int32): INT {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_sasl_bindW".}
  proc ldap_sasl_bind_s*(ExternalHandle: ptr LDAP, DistName: PWCHAR, AuthMechanism: PWCHAR, cred: ptr BERVAL, ServerCtrls: ptr PLDAPControlW, ClientCtrls: ptr PLDAPControlW, ServerData: ptr PBERVAL): INT {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_sasl_bind_sW".}
  proc ldap_search*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_searchW".}
  proc ldap_search_s*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG, res: ptr ptr LDAPMessage): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_search_sW".}
  proc ldap_search_st*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG, timeout: ptr LDAP_TIMEVAL, res: ptr ptr LDAPMessage): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_search_stW".}
  proc ldap_search_ext*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, TimeLimit: ULONG, SizeLimit: ULONG, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_search_extW".}
  proc ldap_search_ext_s*(ld: ptr LDAP, base: PWCHAR, scope: ULONG, filter: PWCHAR, attrs: ptr PWCHAR, attrsonly: ULONG, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, timeout: ptr LDAP_TIMEVAL, SizeLimit: ULONG, res: ptr ptr LDAPMessage): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_search_ext_sW".}
  proc ldap_check_filter*(ld: ptr LDAP, SearchFilter: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_check_filterW".}
  proc ldap_modify*(ld: ptr LDAP, dn: PWCHAR, mods: ptr ptr LDAPModW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_modifyW".}
  proc ldap_modify_s*(ld: ptr LDAP, dn: PWCHAR, mods: ptr ptr LDAPModW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_modify_sW".}
  proc ldap_modify_ext*(ld: ptr LDAP, dn: PWCHAR, mods: ptr ptr LDAPModW, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_modify_extW".}
  proc ldap_modify_ext_s*(ld: ptr LDAP, dn: PWCHAR, mods: ptr ptr LDAPModW, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_modify_ext_sW".}
  proc ldap_modrdn2*(ExternalHandle: ptr LDAP, DistinguishedName: PWCHAR, NewDistinguishedName: PWCHAR, DeleteOldRdn: INT): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_modrdn2W".}
  proc ldap_modrdn*(ExternalHandle: ptr LDAP, DistinguishedName: PWCHAR, NewDistinguishedName: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_modrdnW".}
  proc ldap_modrdn2_s*(ExternalHandle: ptr LDAP, DistinguishedName: PWCHAR, NewDistinguishedName: PWCHAR, DeleteOldRdn: INT): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_modrdn2_sW".}
  proc ldap_modrdn_s*(ExternalHandle: ptr LDAP, DistinguishedName: PWCHAR, NewDistinguishedName: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_modrdn_sW".}
  proc ldap_rename*(ld: ptr LDAP, dn: PWCHAR, NewRDN: PWCHAR, NewParent: PWCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_rename_extW".}
  proc ldap_rename_s*(ld: ptr LDAP, dn: PWCHAR, NewRDN: PWCHAR, NewParent: PWCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_rename_ext_sW".}
  proc ldap_rename_ext*(ld: ptr LDAP, dn: PWCHAR, NewRDN: PWCHAR, NewParent: PWCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_rename_extW".}
  proc ldap_rename_ext_s*(ld: ptr LDAP, dn: PWCHAR, NewRDN: PWCHAR, NewParent: PWCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_rename_ext_sW".}
  proc ldap_add*(ld: ptr LDAP, dn: PWCHAR, attrs: ptr ptr LDAPModW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_addW".}
  proc ldap_add_s*(ld: ptr LDAP, dn: PWCHAR, attrs: ptr ptr LDAPModW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_add_sW".}
  proc ldap_add_ext*(ld: ptr LDAP, dn: PWCHAR, attrs: ptr ptr LDAPModW, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_add_extW".}
  proc ldap_add_ext_s*(ld: ptr LDAP, dn: PWCHAR, attrs: ptr ptr LDAPModW, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_add_ext_sW".}
  proc ldap_compare*(ld: ptr LDAP, dn: PWCHAR, attr: PWCHAR, value: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_compareW".}
  proc ldap_compare_s*(ld: ptr LDAP, dn: PWCHAR, attr: PWCHAR, value: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_compare_sW".}
  proc ldap_compare_ext*(ld: ptr LDAP, dn: PWCHAR, Attr: PWCHAR, Value: PWCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_compare_extW".}
  proc ldap_compare_ext_s*(ld: ptr LDAP, dn: PWCHAR, Attr: PWCHAR, Value: PWCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_compare_ext_sW".}
  proc ldap_delete*(ld: ptr LDAP, dn: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_deleteW".}
  proc ldap_delete_ext*(ld: ptr LDAP, dn: PWCHAR, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_delete_extW".}
  proc ldap_delete_s*(ld: ptr LDAP, dn: PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_delete_sW".}
  proc ldap_delete_ext_s*(ld: ptr LDAP, dn: PWCHAR, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_delete_ext_sW".}
  proc ldap_parse_result*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, ReturnCode: ptr ULONG, MatchedDNs: ptr PWCHAR, ErrorMessage: ptr PWCHAR, Referrals: ptr ptr PWCHAR, ServerControls: ptr ptr PLDAPControlW, Freeit: BOOLEAN): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_parse_resultW".}
  proc ldap_controls_free*(Control: ptr ptr LDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_controls_freeW".}
  proc ldap_control_free*(Control: ptr LDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_control_freeW".}
  proc ldap_free_controls*(Controls: ptr ptr LDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_free_controlsW".}
  proc ldap_parse_extended_result*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, ResultOID: ptr PWCHAR, ResultData: ptr ptr BERVAL, Freeit: BOOLEAN): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_parse_extended_resultW".}
  proc ldap_err2string*(err: ULONG): PWCHAR {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_err2stringW".}
  proc ldap_first_attribute*(ld: ptr LDAP, entry: ptr LDAPMessage, `ptr`: ptr ptr BerElement): PWCHAR {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_first_attributeW".}
  proc ldap_next_attribute*(ld: ptr LDAP, entry: ptr LDAPMessage, `ptr`: ptr BerElement): PWCHAR {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_next_attributeW".}
  proc ldap_get_values*(ld: ptr LDAP, entry: ptr LDAPMessage, attr: PWCHAR): ptr PWCHAR {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_get_valuesW".}
  proc ldap_get_values_len*(ExternalHandle: ptr LDAP, Message: ptr LDAPMessage, attr: PWCHAR): ptr ptr BERVAL {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_get_values_lenW".}
  proc ldap_count_values*(vals: ptr PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_count_valuesW".}
  proc ldap_value_free*(vals: ptr PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_value_freeW".}
  proc ldap_get_dn*(ld: ptr LDAP, entry: ptr LDAPMessage): PWCHAR {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_get_dnW".}
  proc ldap_explode_dn*(dn: PWCHAR, notypes: ULONG): ptr PWCHAR {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_explode_dnW".}
  proc ldap_dn2ufn*(dn: PWCHAR): PWCHAR {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_dn2ufnW".}
  proc ldap_memfree*(Block: PWCHAR): VOID {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_memfreeW".}
  proc ldap_ufn2dn*(ufn: PWCHAR, pDn: ptr PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_ufn2dnW".}
  proc ldap_escape_filter_element*(sourceFilterElement: PCHAR, sourceLength: ULONG, destFilterElement: PWCHAR, destLength: ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_escape_filter_elementW".}
  proc ldap_create_sort_control*(ExternalHandle: PLDAP, SortKeys: ptr PLDAPSortKeyW, IsCritical: UCHAR, Control: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_create_sort_controlW".}
  proc ldap_parse_sort_control*(ExternalHandle: PLDAP, Control: ptr PLDAPControlW, Result: ptr ULONG, Attribute: ptr PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_parse_sort_controlW".}
  proc ldap_encode_sort_control*(ExternalHandle: PLDAP, SortKeys: ptr PLDAPSortKeyW, Control: PLDAPControlW, Criticality: BOOLEAN): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_encode_sort_controlW".}
  proc ldap_create_page_control*(ExternalHandle: PLDAP, PageSize: ULONG, Cookie: ptr BERVAL, IsCritical: UCHAR, Control: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_create_page_controlW".}
  proc ldap_parse_page_control*(ExternalHandle: PLDAP, ServerControls: ptr PLDAPControlW, TotalCount: ptr ULONG, Cookie: ptr ptr BERVAL): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_parse_page_controlW".}
  proc ldap_search_init_page*(ExternalHandle: PLDAP, DistinguishedName: PWCHAR, ScopeOfSearch: ULONG, SearchFilter: PWCHAR, AttributeList: ptr PWCHAR, AttributesOnly: ULONG, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, PageTimeLimit: ULONG, TotalSizeLimit: ULONG, SortKeys: ptr PLDAPSortKeyW): PLDAPSearch {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_search_init_pageW".}
  proc ldap_create_vlv_control*(ExternalHandle: PLDAP, VlvInfo: PLDAPVLVInfo, IsCritical: UCHAR, Control: ptr PLDAPControlW): INT {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_create_vlv_controlW".}
  proc ldap_parse_vlv_control*(ExternalHandle: PLDAP, Control: ptr PLDAPControlW, TargetPos: PULONG, ListCount: PULONG, Context: ptr PBERVAL, ErrCode: PINT): INT {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_parse_vlv_controlW".}
  proc ldap_start_tls_s*(ExternalHandle: PLDAP, ServerReturnValue: PULONG, result: ptr ptr LDAPMessage, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_start_tls_sW".}
  proc ldap_parse_reference*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, Referrals: ptr ptr PWCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_parse_referenceW".}
  proc ldap_extended_operation*(ld: ptr LDAP, Oid: PWCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_extended_operationW".}
  proc ldap_extended_operation_s*(ExternalHandle: ptr LDAP, Oid: PWCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlW, ClientControls: ptr PLDAPControlW, ReturnedOid: ptr PWCHAR, ReturnedData: ptr ptr BERVAL): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_extended_operation_sW".}
  proc SslEmptyCache*(pszTargetName: LPWSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "schannel", importc: "SslEmptyCacheW".}
when winimAnsi:
  type
    LDAPControl* = LDAPControlA
    PLDAPControl* = PLDAPControlA
    LDAPMod* = LDAPModA
    PLDAPMod* = PLDAPModA
    LDAPAPIInfo* = LDAPAPIInfoA
    LDAPAPIFeatureInfo* = LDAPAPIFeatureInfoA
    LDAPSortKey* = LDAPSortKeyA
    PLDAPSortKey* = PLDAPSortKeyA
    SSL_EMPTY_CACHE_FN* = SSL_EMPTY_CACHE_FN_A
  const
    LDAP_UNICODE* = 0
    UNISP_NAME* = UNISP_NAME_A
    PCT1SP_NAME* = PCT1SP_NAME_A
    SSL2SP_NAME* = SSL2SP_NAME_A
    SSL3SP_NAME* = SSL3SP_NAME_A
    TLS1SP_NAME* = TLS1SP_NAME_A
    SCHANNEL_NAME* = SCHANNEL_NAME_A
  proc ldap_open*(HostName: PCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_init*(HostName: PCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_sslinit*(HostName: PCHAR, PortNumber: ULONG, secure: int32): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc cldap_open*(HostName: PCHAR, PortNumber: ULONG): ptr LDAP {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_get_option*(ld: ptr LDAP, option: int32, outvalue: pointer): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_set_option*(ld: ptr LDAP, option: int32, invalue: pointer): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_simple_bind*(ld: ptr LDAP, dn: PCHAR, passwd: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_simple_bind_s*(ld: ptr LDAP, dn: PCHAR, passwd: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_bind*(ld: ptr LDAP, dn: PCHAR, cred: PCHAR, `method`: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_bind_s*(ld: ptr LDAP, dn: PCHAR, cred: PCHAR, `method`: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_sasl_bind*(ExternalHandle: ptr LDAP, DistName: PCHAR, AuthMechanism: PCHAR, cred: ptr BERVAL, ServerCtrls: ptr PLDAPControlA, ClientCtrls: ptr PLDAPControlA, MessageNumber: ptr int32): INT {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_sasl_bindA".}
  proc ldap_sasl_bind_s*(ExternalHandle: ptr LDAP, DistName: PCHAR, AuthMechanism: PCHAR, cred: ptr BERVAL, ServerCtrls: ptr PLDAPControlA, ClientCtrls: ptr PLDAPControlA, ServerData: ptr PBERVAL): INT {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_sasl_bind_sA".}
  proc ldap_search*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_search_s*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_search_st*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG, timeout: ptr LDAP_TIMEVAL, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_search_ext*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, TimeLimit: ULONG, SizeLimit: ULONG, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_search_ext_s*(ld: ptr LDAP, base: PCHAR, scope: ULONG, filter: PCHAR, attrs: ptr PCHAR, attrsonly: ULONG, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, timeout: ptr LDAP_TIMEVAL, SizeLimit: ULONG, res: ptr ptr LDAPMessage): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_check_filter*(ld: ptr LDAP, SearchFilter: PCHAR): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_check_filterA".}
  proc ldap_modify*(ld: ptr LDAP, dn: PCHAR, mods: ptr ptr LDAPModA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_modify_s*(ld: ptr LDAP, dn: PCHAR, mods: ptr ptr LDAPModA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_modify_ext*(ld: ptr LDAP, dn: PCHAR, mods: ptr ptr LDAPModA, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_modify_ext_s*(ld: ptr LDAP, dn: PCHAR, mods: ptr ptr LDAPModA, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_modrdn2*(ExternalHandle: ptr LDAP, DistinguishedName: PCHAR, NewDistinguishedName: PCHAR, DeleteOldRdn: INT): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_modrdn*(ExternalHandle: ptr LDAP, DistinguishedName: PCHAR, NewDistinguishedName: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_modrdn2_s*(ExternalHandle: ptr LDAP, DistinguishedName: PCHAR, NewDistinguishedName: PCHAR, DeleteOldRdn: INT): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_modrdn_s*(ExternalHandle: ptr LDAP, DistinguishedName: PCHAR, NewDistinguishedName: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_rename*(ld: ptr LDAP, dn: PCHAR, NewRDN: PCHAR, NewParent: PCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_rename_extA".}
  proc ldap_rename_s*(ld: ptr LDAP, dn: PCHAR, NewRDN: PCHAR, NewParent: PCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_rename_ext_sA".}
  proc ldap_rename_ext*(ld: ptr LDAP, dn: PCHAR, NewRDN: PCHAR, NewParent: PCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_rename_ext_s*(ld: ptr LDAP, dn: PCHAR, NewRDN: PCHAR, NewParent: PCHAR, DeleteOldRdn: INT, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_add*(ld: ptr LDAP, dn: PCHAR, attrs: ptr ptr LDAPMod): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_add_s*(ld: ptr LDAP, dn: PCHAR, attrs: ptr ptr LDAPMod): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_add_ext*(ld: ptr LDAP, dn: PCHAR, attrs: ptr ptr LDAPModA, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_add_ext_s*(ld: ptr LDAP, dn: PCHAR, attrs: ptr ptr LDAPModA, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_compare*(ld: ptr LDAP, dn: PCHAR, attr: PCHAR, value: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_compare_s*(ld: ptr LDAP, dn: PCHAR, attr: PCHAR, value: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_compare_ext*(ld: ptr LDAP, dn: PCHAR, Attr: PCHAR, Value: PCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_compare_ext_s*(ld: ptr LDAP, dn: PCHAR, Attr: PCHAR, Value: PCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_delete*(ld: ptr LDAP, dn: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_delete_s*(ld: ptr LDAP, dn: PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_delete_ext*(ld: ptr LDAP, dn: PCHAR, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_delete_ext_s*(ld: ptr LDAP, dn: PCHAR, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_parse_extended_result*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, ResultOID: ptr PCHAR, ResultData: ptr ptr BERVAL, Freeit: BOOLEAN): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_parse_extended_resultA".}
  proc ldap_parse_result*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, ReturnCode: ptr ULONG, MatchedDNs: ptr PCHAR, ErrorMessage: ptr PCHAR, Referrals: ptr ptr PCHAR, ServerControls: ptr ptr PLDAPControlA, Freeit: BOOLEAN): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_controls_free*(Controls: ptr ptr LDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_control_free*(Control: ptr LDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_free_controls*(Controls: ptr ptr LDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_err2string*(err: ULONG): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_first_attribute*(ld: ptr LDAP, entry: ptr LDAPMessage, `ptr`: ptr ptr BerElement): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_next_attribute*(ld: ptr LDAP, entry: ptr LDAPMessage, `ptr`: ptr BerElement): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_get_values*(ld: ptr LDAP, entry: ptr LDAPMessage, attr: PCHAR): ptr PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_get_values_len*(ExternalHandle: ptr LDAP, Message: ptr LDAPMessage, attr: PCHAR): ptr ptr BERVAL {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_count_values*(vals: ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_value_free*(vals: ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_get_dn*(ld: ptr LDAP, entry: ptr LDAPMessage): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_explode_dn*(dn: PCHAR, notypes: ULONG): ptr PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_dn2ufn*(dn: PCHAR): PCHAR {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_memfree*(Block: PCHAR): VOID {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_ufn2dn*(ufn: PCHAR, pDn: ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_escape_filter_element*(sourceFilterElement: PCHAR, sourceLength: ULONG, destFilterElement: PCHAR, destLength: ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_create_sort_control*(ExternalHandle: PLDAP, SortKeys: ptr PLDAPSortKeyA, IsCritical: UCHAR, Control: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_parse_sort_control*(ExternalHandle: PLDAP, Control: ptr PLDAPControlA, Result: ptr ULONG, Attribute: ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_create_page_control*(ExternalHandle: PLDAP, PageSize: ULONG, Cookie: ptr BERVAL, IsCritical: UCHAR, Control: ptr PLDAPControlA): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_parse_page_control*(ExternalHandle: PLDAP, ServerControls: ptr PLDAPControlA, TotalCount: ptr ULONG, Cookie: ptr ptr BERVAL): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_search_init_page*(ExternalHandle: PLDAP, DistinguishedName: PCHAR, ScopeOfSearch: ULONG, SearchFilter: PCHAR, AttributeList: ptr PCHAR, AttributesOnly: ULONG, ServerControls: ptr PLDAPControl, ClientControls: ptr PLDAPControl, PageTimeLimit: ULONG, TotalSizeLimit: ULONG, SortKeys: ptr PLDAPSortKey): PLDAPSearch {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_create_vlv_control*(ExternalHandle: PLDAP, VlvInfo: PLDAPVLVInfo, IsCritical: UCHAR, Control: ptr PLDAPControlA): INT {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_create_vlv_controlA".}
  proc ldap_parse_vlv_control*(ExternalHandle: PLDAP, Control: ptr PLDAPControlA, TargetPos: PULONG, ListCount: PULONG, Context: ptr PBERVAL, ErrCode: PINT): INT {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_parse_vlv_controlA".}
  proc ldap_start_tls_s*(ExternalHandle: PLDAP, ServerReturnValue: PULONG, result: ptr ptr LDAPMessage, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_start_tls_sA".}
  proc ldap_parse_reference*(Connection: ptr LDAP, ResultMessage: ptr LDAPMessage, Referrals: ptr ptr PCHAR): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_extended_operation*(ld: ptr LDAP, Oid: PCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, MessageNumber: ptr ULONG): ULONG {.winapi, cdecl, dynlib: "wldap32", importc.}
  proc ldap_extended_operation_s*(ExternalHandle: ptr LDAP, Oid: PCHAR, Data: ptr BERVAL, ServerControls: ptr PLDAPControlA, ClientControls: ptr PLDAPControlA, ReturnedOid: ptr PCHAR, ReturnedData: ptr ptr BERVAL): ULONG {.winapi, stdcall, dynlib: "wldap32", importc: "ldap_extended_operation_sA".}
  proc SslEmptyCache*(pszTargetName: LPSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "schannel", importc: "SslEmptyCacheA".}
