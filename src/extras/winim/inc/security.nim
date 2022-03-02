#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import wincrypt
#include <security.h>
#include <sspi.h>
#include <ntsecapi.h>
#include <secext.h>
type
  SECURITY_LOGON_TYPE* = int32
  PSECURITY_LOGON_TYPE* = ptr int32
  SE_ADT_PARAMETER_TYPE* = int32
  PSE_ADT_PARAMETER_TYPE* = ptr int32
  POLICY_AUDIT_EVENT_TYPE* = int32
  PPOLICY_AUDIT_EVENT_TYPE* = ptr int32
  POLICY_LSA_SERVER_ROLE* = int32
  PPOLICY_LSA_SERVER_ROLE* = ptr int32
  POLICY_INFORMATION_CLASS* = int32
  PPOLICY_INFORMATION_CLASS* = ptr int32
  POLICY_DOMAIN_INFORMATION_CLASS* = int32
  PPOLICY_DOMAIN_INFORMATION_CLASS* = ptr int32
  POLICY_NOTIFICATION_INFORMATION_CLASS* = int32
  PPOLICY_NOTIFICATION_INFORMATION_CLASS* = ptr int32
  TRUSTED_INFORMATION_CLASS* = int32
  PTRUSTED_INFORMATION_CLASS* = ptr int32
  LSA_FOREST_TRUST_RECORD_TYPE* = int32
  LSA_FOREST_TRUST_COLLISION_RECORD_TYPE* = int32
  NEGOTIATE_MESSAGES* = int32
  MSV1_0_LOGON_SUBMIT_TYPE* = int32
  PMSV1_0_LOGON_SUBMIT_TYPE* = ptr int32
  MSV1_0_PROFILE_BUFFER_TYPE* = int32
  PMSV1_0_PROFILE_BUFFER_TYPE* = ptr int32
  MSV1_0_AVID* = int32
  MSV1_0_PROTOCOL_MESSAGE_TYPE* = int32
  PMSV1_0_PROTOCOL_MESSAGE_TYPE* = ptr int32
  KERB_LOGON_SUBMIT_TYPE* = int32
  PKERB_LOGON_SUBMIT_TYPE* = ptr int32
  KERB_PROFILE_BUFFER_TYPE* = int32
  PKERB_PROFILE_BUFFER_TYPE* = ptr int32
  KERB_PROTOCOL_MESSAGE_TYPE* = int32
  PKERB_PROTOCOL_MESSAGE_TYPE* = ptr int32
  SecDelegationType* = int32
  PSecDelegationType* = ptr int32
  SASL_AUTHZID_STATE* = int32
  EXTENDED_NAME_FORMAT* = int32
  PEXTENDED_NAME_FORMAT* = ptr int32
  LSA_OPERATIONAL_MODE* = ULONG
  PLSA_OPERATIONAL_MODE* = ptr ULONG
  POLICY_AUDIT_EVENT_OPTIONS* = ULONG
  PPOLICY_AUDIT_EVENT_OPTIONS* = ptr ULONG
  LSA_HANDLE* = PVOID
  PLSA_HANDLE* = ptr PVOID
  LSA_ENUMERATION_HANDLE* = ULONG
  PLSA_ENUMERATION_HANDLE* = ptr ULONG
  SEC_WCHAR* = WCHAR
  SEC_CHAR* = CHAR
  SE_ADT_OBJECT_TYPE* {.pure.} = object
    ObjectType*: GUID
    Flags*: USHORT
    Level*: USHORT
    AccessMask*: ACCESS_MASK
  PSE_ADT_OBJECT_TYPE* = ptr SE_ADT_OBJECT_TYPE
  SE_ADT_PARAMETER_ARRAY_ENTRY* {.pure.} = object
    Type*: SE_ADT_PARAMETER_TYPE
    Length*: ULONG
    Data*: array[2, ULONG_PTR]
    Address*: PVOID
  PSE_ADT_PARAMETER_ARRAY_ENTRY* = ptr SE_ADT_PARAMETER_ARRAY_ENTRY
const
  SE_MAX_AUDIT_PARAMETERS* = 32
type
  SE_ADT_PARAMETER_ARRAY* {.pure.} = object
    CategoryId*: ULONG
    AuditId*: ULONG
    ParameterCount*: ULONG
    Length*: ULONG
    Type*: USHORT
    Flags*: ULONG
    Parameters*: array[SE_MAX_AUDIT_PARAMETERS , SE_ADT_PARAMETER_ARRAY_ENTRY]
  PSE_ADT_PARAMETER_ARRAY* = ptr SE_ADT_PARAMETER_ARRAY
  LSA_UNICODE_STRING* = UNICODE_STRING
  PLSA_UNICODE_STRING* = ptr UNICODE_STRING
  LSA_STRING* = STRING
  PLSA_STRING* = ptr STRING
  LSA_OBJECT_ATTRIBUTES* = OBJECT_ATTRIBUTES
  PLSA_OBJECT_ATTRIBUTES* = ptr OBJECT_ATTRIBUTES
  LSA_TRUST_INFORMATION* {.pure.} = object
    Name*: LSA_UNICODE_STRING
    Sid*: PSID
  PLSA_TRUST_INFORMATION* = ptr LSA_TRUST_INFORMATION
  LSA_REFERENCED_DOMAIN_LIST* {.pure.} = object
    Entries*: ULONG
    Domains*: PLSA_TRUST_INFORMATION
  PLSA_REFERENCED_DOMAIN_LIST* = ptr LSA_REFERENCED_DOMAIN_LIST
  LSA_TRANSLATED_SID* {.pure.} = object
    Use*: SID_NAME_USE
    RelativeId*: ULONG
    DomainIndex*: LONG
  PLSA_TRANSLATED_SID* = ptr LSA_TRANSLATED_SID
  LSA_TRANSLATED_SID2* {.pure.} = object
    Use*: SID_NAME_USE
    Sid*: PSID
    DomainIndex*: LONG
    Flags*: ULONG
  PLSA_TRANSLATED_SID2* = ptr LSA_TRANSLATED_SID2
  LSA_TRANSLATED_NAME* {.pure.} = object
    Use*: SID_NAME_USE
    Name*: LSA_UNICODE_STRING
    DomainIndex*: LONG
  PLSA_TRANSLATED_NAME* = ptr LSA_TRANSLATED_NAME
  POLICY_AUDIT_LOG_INFO* {.pure.} = object
    AuditLogPercentFull*: ULONG
    MaximumLogSize*: ULONG
    AuditRetentionPeriod*: LARGE_INTEGER
    AuditLogFullShutdownInProgress*: BOOLEAN
    TimeToShutdown*: LARGE_INTEGER
    NextAuditRecordId*: ULONG
  PPOLICY_AUDIT_LOG_INFO* = ptr POLICY_AUDIT_LOG_INFO
  POLICY_AUDIT_EVENTS_INFO* {.pure.} = object
    AuditingMode*: BOOLEAN
    EventAuditingOptions*: PPOLICY_AUDIT_EVENT_OPTIONS
    MaximumAuditEventCount*: ULONG
  PPOLICY_AUDIT_EVENTS_INFO* = ptr POLICY_AUDIT_EVENTS_INFO
  POLICY_ACCOUNT_DOMAIN_INFO* {.pure.} = object
    DomainName*: LSA_UNICODE_STRING
    DomainSid*: PSID
  PPOLICY_ACCOUNT_DOMAIN_INFO* = ptr POLICY_ACCOUNT_DOMAIN_INFO
  POLICY_PRIMARY_DOMAIN_INFO* {.pure.} = object
    Name*: LSA_UNICODE_STRING
    Sid*: PSID
  PPOLICY_PRIMARY_DOMAIN_INFO* = ptr POLICY_PRIMARY_DOMAIN_INFO
  POLICY_DNS_DOMAIN_INFO* {.pure.} = object
    Name*: LSA_UNICODE_STRING
    DnsDomainName*: LSA_UNICODE_STRING
    DnsForestName*: LSA_UNICODE_STRING
    DomainGuid*: GUID
    Sid*: PSID
  PPOLICY_DNS_DOMAIN_INFO* = ptr POLICY_DNS_DOMAIN_INFO
  POLICY_PD_ACCOUNT_INFO* {.pure.} = object
    Name*: LSA_UNICODE_STRING
  PPOLICY_PD_ACCOUNT_INFO* = ptr POLICY_PD_ACCOUNT_INFO
  POLICY_LSA_SERVER_ROLE_INFO* {.pure.} = object
    LsaServerRole*: POLICY_LSA_SERVER_ROLE
  PPOLICY_LSA_SERVER_ROLE_INFO* = ptr POLICY_LSA_SERVER_ROLE_INFO
  POLICY_REPLICA_SOURCE_INFO* {.pure.} = object
    ReplicaSource*: LSA_UNICODE_STRING
    ReplicaAccountName*: LSA_UNICODE_STRING
  PPOLICY_REPLICA_SOURCE_INFO* = ptr POLICY_REPLICA_SOURCE_INFO
  POLICY_DEFAULT_QUOTA_INFO* {.pure.} = object
    QuotaLimits*: QUOTA_LIMITS
  PPOLICY_DEFAULT_QUOTA_INFO* = ptr POLICY_DEFAULT_QUOTA_INFO
  POLICY_MODIFICATION_INFO* {.pure.} = object
    ModifiedId*: LARGE_INTEGER
    DatabaseCreationTime*: LARGE_INTEGER
  PPOLICY_MODIFICATION_INFO* = ptr POLICY_MODIFICATION_INFO
  POLICY_AUDIT_FULL_SET_INFO* {.pure.} = object
    ShutDownOnFull*: BOOLEAN
  PPOLICY_AUDIT_FULL_SET_INFO* = ptr POLICY_AUDIT_FULL_SET_INFO
  POLICY_AUDIT_FULL_QUERY_INFO* {.pure.} = object
    ShutDownOnFull*: BOOLEAN
    LogIsFull*: BOOLEAN
  PPOLICY_AUDIT_FULL_QUERY_INFO* = ptr POLICY_AUDIT_FULL_QUERY_INFO
  POLICY_DOMAIN_EFS_INFO* {.pure.} = object
    InfoLength*: ULONG
    EfsBlob*: PUCHAR
  PPOLICY_DOMAIN_EFS_INFO* = ptr POLICY_DOMAIN_EFS_INFO
  POLICY_DOMAIN_KERBEROS_TICKET_INFO* {.pure.} = object
    AuthenticationOptions*: ULONG
    MaxServiceTicketAge*: LARGE_INTEGER
    MaxTicketAge*: LARGE_INTEGER
    MaxRenewAge*: LARGE_INTEGER
    MaxClockSkew*: LARGE_INTEGER
    Reserved*: LARGE_INTEGER
  PPOLICY_DOMAIN_KERBEROS_TICKET_INFO* = ptr POLICY_DOMAIN_KERBEROS_TICKET_INFO
  TRUSTED_DOMAIN_NAME_INFO* {.pure.} = object
    Name*: LSA_UNICODE_STRING
  PTRUSTED_DOMAIN_NAME_INFO* = ptr TRUSTED_DOMAIN_NAME_INFO
  TRUSTED_CONTROLLERS_INFO* {.pure.} = object
    Entries*: ULONG
    Names*: PLSA_UNICODE_STRING
  PTRUSTED_CONTROLLERS_INFO* = ptr TRUSTED_CONTROLLERS_INFO
  TRUSTED_POSIX_OFFSET_INFO* {.pure.} = object
    Offset*: ULONG
  PTRUSTED_POSIX_OFFSET_INFO* = ptr TRUSTED_POSIX_OFFSET_INFO
  TRUSTED_PASSWORD_INFO* {.pure.} = object
    Password*: LSA_UNICODE_STRING
    OldPassword*: LSA_UNICODE_STRING
  PTRUSTED_PASSWORD_INFO* = ptr TRUSTED_PASSWORD_INFO
  TRUSTED_DOMAIN_INFORMATION_BASIC* = LSA_TRUST_INFORMATION
  PTRUSTED_DOMAIN_INFORMATION_BASIC* = PLSA_TRUST_INFORMATION
  TRUSTED_DOMAIN_INFORMATION_EX* {.pure.} = object
    Name*: LSA_UNICODE_STRING
    FlatName*: LSA_UNICODE_STRING
    Sid*: PSID
    TrustDirection*: ULONG
    TrustType*: ULONG
    TrustAttributes*: ULONG
  PTRUSTED_DOMAIN_INFORMATION_EX* = ptr TRUSTED_DOMAIN_INFORMATION_EX
  TRUSTED_DOMAIN_INFORMATION_EX2* {.pure.} = object
    Name*: LSA_UNICODE_STRING
    FlatName*: LSA_UNICODE_STRING
    Sid*: PSID
    TrustDirection*: ULONG
    TrustType*: ULONG
    TrustAttributes*: ULONG
    ForestTrustLength*: ULONG
    ForestTrustInfo*: PUCHAR
  PTRUSTED_DOMAIN_INFORMATION_EX2* = ptr TRUSTED_DOMAIN_INFORMATION_EX2
  LSA_AUTH_INFORMATION* {.pure.} = object
    LastUpdateTime*: LARGE_INTEGER
    AuthType*: ULONG
    AuthInfoLength*: ULONG
    AuthInfo*: PUCHAR
  PLSA_AUTH_INFORMATION* = ptr LSA_AUTH_INFORMATION
  TRUSTED_DOMAIN_AUTH_INFORMATION* {.pure.} = object
    IncomingAuthInfos*: ULONG
    IncomingAuthenticationInformation*: PLSA_AUTH_INFORMATION
    IncomingPreviousAuthenticationInformation*: PLSA_AUTH_INFORMATION
    OutgoingAuthInfos*: ULONG
    OutgoingAuthenticationInformation*: PLSA_AUTH_INFORMATION
    OutgoingPreviousAuthenticationInformation*: PLSA_AUTH_INFORMATION
  PTRUSTED_DOMAIN_AUTH_INFORMATION* = ptr TRUSTED_DOMAIN_AUTH_INFORMATION
  TRUSTED_DOMAIN_FULL_INFORMATION* {.pure.} = object
    Information*: TRUSTED_DOMAIN_INFORMATION_EX
    PosixOffset*: TRUSTED_POSIX_OFFSET_INFO
    AuthInformation*: TRUSTED_DOMAIN_AUTH_INFORMATION
  PTRUSTED_DOMAIN_FULL_INFORMATION* = ptr TRUSTED_DOMAIN_FULL_INFORMATION
  TRUSTED_DOMAIN_FULL_INFORMATION2* {.pure.} = object
    Information*: TRUSTED_DOMAIN_INFORMATION_EX2
    PosixOffset*: TRUSTED_POSIX_OFFSET_INFO
    AuthInformation*: TRUSTED_DOMAIN_AUTH_INFORMATION
  PTRUSTED_DOMAIN_FULL_INFORMATION2* = ptr TRUSTED_DOMAIN_FULL_INFORMATION2
  LSA_FOREST_TRUST_DOMAIN_INFO* {.pure.} = object
    Sid*: PSID
    DnsName*: LSA_UNICODE_STRING
    NetbiosName*: LSA_UNICODE_STRING
  PLSA_FOREST_TRUST_DOMAIN_INFO* = ptr LSA_FOREST_TRUST_DOMAIN_INFO
  LSA_FOREST_TRUST_BINARY_DATA* {.pure.} = object
    Length*: ULONG
    Buffer*: PUCHAR
  PLSA_FOREST_TRUST_BINARY_DATA* = ptr LSA_FOREST_TRUST_BINARY_DATA
  LSA_FOREST_TRUST_RECORD_ForestTrustData* {.pure, union.} = object
    TopLevelName*: LSA_UNICODE_STRING
    DomainInfo*: LSA_FOREST_TRUST_DOMAIN_INFO
    Data*: LSA_FOREST_TRUST_BINARY_DATA
  LSA_FOREST_TRUST_RECORD* {.pure.} = object
    Flags*: ULONG
    ForestTrustType*: LSA_FOREST_TRUST_RECORD_TYPE
    Time*: LARGE_INTEGER
    ForestTrustData*: LSA_FOREST_TRUST_RECORD_ForestTrustData
  PLSA_FOREST_TRUST_RECORD* = ptr LSA_FOREST_TRUST_RECORD
  LSA_FOREST_TRUST_INFORMATION* {.pure.} = object
    RecordCount*: ULONG
    Entries*: ptr PLSA_FOREST_TRUST_RECORD
  PLSA_FOREST_TRUST_INFORMATION* = ptr LSA_FOREST_TRUST_INFORMATION
  LSA_FOREST_TRUST_COLLISION_RECORD* {.pure.} = object
    Index*: ULONG
    Type*: LSA_FOREST_TRUST_COLLISION_RECORD_TYPE
    Flags*: ULONG
    Name*: LSA_UNICODE_STRING
  PLSA_FOREST_TRUST_COLLISION_RECORD* = ptr LSA_FOREST_TRUST_COLLISION_RECORD
  LSA_FOREST_TRUST_COLLISION_INFORMATION* {.pure.} = object
    RecordCount*: ULONG
    Entries*: ptr PLSA_FOREST_TRUST_COLLISION_RECORD
  PLSA_FOREST_TRUST_COLLISION_INFORMATION* = ptr LSA_FOREST_TRUST_COLLISION_INFORMATION
  LSA_ENUMERATION_INFORMATION* {.pure.} = object
    Sid*: PSID
  PLSA_ENUMERATION_INFORMATION* = ptr LSA_ENUMERATION_INFORMATION
  LSA_LAST_INTER_LOGON_INFO* {.pure.} = object
    LastSuccessfulLogon*: LARGE_INTEGER
    LastFailedLogon*: LARGE_INTEGER
    FailedAttemptCountSinceLastSuccessfulLogon*: ULONG
  PLSA_LAST_INTER_LOGON_INFO* = ptr LSA_LAST_INTER_LOGON_INFO
  SECURITY_LOGON_SESSION_DATA* {.pure.} = object
    Size*: ULONG
    LogonId*: LUID
    UserName*: LSA_UNICODE_STRING
    LogonDomain*: LSA_UNICODE_STRING
    AuthenticationPackage*: LSA_UNICODE_STRING
    LogonType*: ULONG
    Session*: ULONG
    Sid*: PSID
    LogonTime*: LARGE_INTEGER
    LogonServer*: LSA_UNICODE_STRING
    DnsDomainName*: LSA_UNICODE_STRING
    Upn*: LSA_UNICODE_STRING
    UserFlags*: ULONG
    LastLogonInfo*: LSA_LAST_INTER_LOGON_INFO
    LogonScript*: LSA_UNICODE_STRING
    ProfilePath*: LSA_UNICODE_STRING
    HomeDirectory*: LSA_UNICODE_STRING
    HomeDirectoryDrive*: LSA_UNICODE_STRING
    LogoffTime*: LARGE_INTEGER
    KickOffTime*: LARGE_INTEGER
    PasswordLastSet*: LARGE_INTEGER
    PasswordCanChange*: LARGE_INTEGER
    PasswordMustChange*: LARGE_INTEGER
  PSECURITY_LOGON_SESSION_DATA* = ptr SECURITY_LOGON_SESSION_DATA
const
  NEGOTIATE_MAX_PREFIX* = 32
type
  NEGOTIATE_PACKAGE_PREFIX* {.pure.} = object
    PackageId*: ULONG_PTR
    PackageDataA*: PVOID
    PackageDataW*: PVOID
    PrefixLen*: ULONG_PTR
    Prefix*: array[NEGOTIATE_MAX_PREFIX , UCHAR]
  PNEGOTIATE_PACKAGE_PREFIX* = ptr NEGOTIATE_PACKAGE_PREFIX
  NEGOTIATE_PACKAGE_PREFIXES* {.pure.} = object
    MessageType*: ULONG
    PrefixCount*: ULONG
    Offset*: ULONG
    Pad*: ULONG
  PNEGOTIATE_PACKAGE_PREFIXES* = ptr NEGOTIATE_PACKAGE_PREFIXES
  NEGOTIATE_CALLER_NAME_REQUEST* {.pure.} = object
    MessageType*: ULONG
    LogonId*: LUID
  PNEGOTIATE_CALLER_NAME_REQUEST* = ptr NEGOTIATE_CALLER_NAME_REQUEST
  NEGOTIATE_CALLER_NAME_RESPONSE* {.pure.} = object
    MessageType*: ULONG
    CallerName*: PWSTR
  PNEGOTIATE_CALLER_NAME_RESPONSE* = ptr NEGOTIATE_CALLER_NAME_RESPONSE
  DOMAIN_PASSWORD_INFORMATION* {.pure.} = object
    MinPasswordLength*: USHORT
    PasswordHistoryLength*: USHORT
    PasswordProperties*: ULONG
    MaxPasswordAge*: LARGE_INTEGER
    MinPasswordAge*: LARGE_INTEGER
  PDOMAIN_PASSWORD_INFORMATION* = ptr DOMAIN_PASSWORD_INFORMATION
  TMSV1_0_INTERACTIVE_LOGON* {.pure.} = object
    MessageType*: MSV1_0_LOGON_SUBMIT_TYPE
    LogonDomainName*: UNICODE_STRING
    UserName*: UNICODE_STRING
    Password*: UNICODE_STRING
  PMSV1_0_INTERACTIVE_LOGON* = ptr TMSV1_0_INTERACTIVE_LOGON
  TMSV1_0_INTERACTIVE_PROFILE* {.pure.} = object
    MessageType*: MSV1_0_PROFILE_BUFFER_TYPE
    LogonCount*: USHORT
    BadPasswordCount*: USHORT
    LogonTime*: LARGE_INTEGER
    LogoffTime*: LARGE_INTEGER
    KickOffTime*: LARGE_INTEGER
    PasswordLastSet*: LARGE_INTEGER
    PasswordCanChange*: LARGE_INTEGER
    PasswordMustChange*: LARGE_INTEGER
    LogonScript*: UNICODE_STRING
    HomeDirectory*: UNICODE_STRING
    FullName*: UNICODE_STRING
    ProfilePath*: UNICODE_STRING
    HomeDirectoryDrive*: UNICODE_STRING
    LogonServer*: UNICODE_STRING
    UserFlags*: ULONG
  PMSV1_0_INTERACTIVE_PROFILE* = ptr TMSV1_0_INTERACTIVE_PROFILE
const
  MSV1_0_CHALLENGE_LENGTH* = 8
type
  TMSV1_0_LM20_LOGON* {.pure.} = object
    MessageType*: MSV1_0_LOGON_SUBMIT_TYPE
    LogonDomainName*: UNICODE_STRING
    UserName*: UNICODE_STRING
    Workstation*: UNICODE_STRING
    ChallengeToClient*: array[MSV1_0_CHALLENGE_LENGTH, UCHAR]
    CaseSensitiveChallengeResponse*: STRING
    CaseInsensitiveChallengeResponse*: STRING
    ParameterControl*: ULONG
  PMSV1_0_LM20_LOGON* = ptr TMSV1_0_LM20_LOGON
  TMSV1_0_SUBAUTH_LOGON* {.pure.} = object
    MessageType*: MSV1_0_LOGON_SUBMIT_TYPE
    LogonDomainName*: UNICODE_STRING
    UserName*: UNICODE_STRING
    Workstation*: UNICODE_STRING
    ChallengeToClient*: array[MSV1_0_CHALLENGE_LENGTH, UCHAR]
    AuthenticationInfo1*: STRING
    AuthenticationInfo2*: STRING
    ParameterControl*: ULONG
    SubAuthPackageId*: ULONG
  PMSV1_0_SUBAUTH_LOGON* = ptr TMSV1_0_SUBAUTH_LOGON
const
  MSV1_0_USER_SESSION_KEY_LENGTH* = 16
  MSV1_0_LANMAN_SESSION_KEY_LENGTH* = 8
type
  TMSV1_0_LM20_LOGON_PROFILE* {.pure.} = object
    MessageType*: MSV1_0_PROFILE_BUFFER_TYPE
    KickOffTime*: LARGE_INTEGER
    LogoffTime*: LARGE_INTEGER
    UserFlags*: ULONG
    UserSessionKey*: array[MSV1_0_USER_SESSION_KEY_LENGTH, UCHAR]
    LogonDomainName*: UNICODE_STRING
    LanmanSessionKey*: array[MSV1_0_LANMAN_SESSION_KEY_LENGTH, UCHAR]
    LogonServer*: UNICODE_STRING
    UserParameters*: UNICODE_STRING
  PMSV1_0_LM20_LOGON_PROFILE* = ptr TMSV1_0_LM20_LOGON_PROFILE
const
  MSV1_0_OWF_PASSWORD_LENGTH* = 16
type
  MSV1_0_SUPPLEMENTAL_CREDENTIAL* {.pure.} = object
    Version*: ULONG
    Flags*: ULONG
    LmPassword*: array[MSV1_0_OWF_PASSWORD_LENGTH, UCHAR]
    NtPassword*: array[MSV1_0_OWF_PASSWORD_LENGTH, UCHAR]
  PMSV1_0_SUPPLEMENTAL_CREDENTIAL* = ptr MSV1_0_SUPPLEMENTAL_CREDENTIAL
const
  MSV1_0_NTLM3_RESPONSE_LENGTH* = 16
type
  MSV1_0_NTLM3_RESPONSE* {.pure.} = object
    Response*: array[MSV1_0_NTLM3_RESPONSE_LENGTH, UCHAR]
    RespType*: UCHAR
    HiRespType*: UCHAR
    Flags*: USHORT
    MsgWord*: ULONG
    TimeStamp*: ULONGLONG
    ChallengeFromClient*: array[MSV1_0_CHALLENGE_LENGTH, UCHAR]
    AvPairsOff*: ULONG
    Buffer*: array[1, UCHAR]
  PMSV1_0_NTLM3_RESPONSE* = ptr MSV1_0_NTLM3_RESPONSE
  MSV1_0_AV_PAIR* {.pure.} = object
    AvId*: USHORT
    AvLen*: USHORT
  PMSV1_0_AV_PAIR* = ptr MSV1_0_AV_PAIR
  MSV1_0_CHANGEPASSWORD_REQUEST* {.pure.} = object
    MessageType*: MSV1_0_PROTOCOL_MESSAGE_TYPE
    DomainName*: UNICODE_STRING
    AccountName*: UNICODE_STRING
    OldPassword*: UNICODE_STRING
    NewPassword*: UNICODE_STRING
    Impersonating*: BOOLEAN
  PMSV1_0_CHANGEPASSWORD_REQUEST* = ptr MSV1_0_CHANGEPASSWORD_REQUEST
  MSV1_0_CHANGEPASSWORD_RESPONSE* {.pure.} = object
    MessageType*: MSV1_0_PROTOCOL_MESSAGE_TYPE
    PasswordInfoValid*: BOOLEAN
    DomainPasswordInfo*: DOMAIN_PASSWORD_INFORMATION
  PMSV1_0_CHANGEPASSWORD_RESPONSE* = ptr MSV1_0_CHANGEPASSWORD_RESPONSE
  MSV1_0_PASSTHROUGH_REQUEST* {.pure.} = object
    MessageType*: MSV1_0_PROTOCOL_MESSAGE_TYPE
    DomainName*: UNICODE_STRING
    PackageName*: UNICODE_STRING
    DataLength*: ULONG
    LogonData*: PUCHAR
    Pad*: ULONG
  PMSV1_0_PASSTHROUGH_REQUEST* = ptr MSV1_0_PASSTHROUGH_REQUEST
  MSV1_0_PASSTHROUGH_RESPONSE* {.pure.} = object
    MessageType*: MSV1_0_PROTOCOL_MESSAGE_TYPE
    Pad*: ULONG
    DataLength*: ULONG
    ValidationData*: PUCHAR
  PMSV1_0_PASSTHROUGH_RESPONSE* = ptr MSV1_0_PASSTHROUGH_RESPONSE
  MSV1_0_SUBAUTH_REQUEST* {.pure.} = object
    MessageType*: MSV1_0_PROTOCOL_MESSAGE_TYPE
    SubAuthPackageId*: ULONG
    SubAuthInfoLength*: ULONG
    SubAuthSubmitBuffer*: PUCHAR
  PMSV1_0_SUBAUTH_REQUEST* = ptr MSV1_0_SUBAUTH_REQUEST
  MSV1_0_SUBAUTH_RESPONSE* {.pure.} = object
    MessageType*: MSV1_0_PROTOCOL_MESSAGE_TYPE
    SubAuthInfoLength*: ULONG
    SubAuthReturnBuffer*: PUCHAR
  PMSV1_0_SUBAUTH_RESPONSE* = ptr MSV1_0_SUBAUTH_RESPONSE
  KERB_INTERACTIVE_LOGON* {.pure.} = object
    MessageType*: KERB_LOGON_SUBMIT_TYPE
    LogonDomainName*: UNICODE_STRING
    UserName*: UNICODE_STRING
    Password*: UNICODE_STRING
  PKERB_INTERACTIVE_LOGON* = ptr KERB_INTERACTIVE_LOGON
  KERB_INTERACTIVE_UNLOCK_LOGON* {.pure.} = object
    Logon*: KERB_INTERACTIVE_LOGON
    LogonId*: LUID
  PKERB_INTERACTIVE_UNLOCK_LOGON* = ptr KERB_INTERACTIVE_UNLOCK_LOGON
  KERB_SMART_CARD_LOGON* {.pure.} = object
    MessageType*: KERB_LOGON_SUBMIT_TYPE
    Pin*: UNICODE_STRING
    CspDataLength*: ULONG
    CspData*: PUCHAR
  PKERB_SMART_CARD_LOGON* = ptr KERB_SMART_CARD_LOGON
  KERB_SMART_CARD_UNLOCK_LOGON* {.pure.} = object
    Logon*: KERB_SMART_CARD_LOGON
    LogonId*: LUID
  PKERB_SMART_CARD_UNLOCK_LOGON* = ptr KERB_SMART_CARD_UNLOCK_LOGON
  KERB_TICKET_LOGON* {.pure.} = object
    MessageType*: KERB_LOGON_SUBMIT_TYPE
    Flags*: ULONG
    ServiceTicketLength*: ULONG
    TicketGrantingTicketLength*: ULONG
    ServiceTicket*: PUCHAR
    TicketGrantingTicket*: PUCHAR
  PKERB_TICKET_LOGON* = ptr KERB_TICKET_LOGON
  KERB_TICKET_UNLOCK_LOGON* {.pure.} = object
    Logon*: KERB_TICKET_LOGON
    LogonId*: LUID
  PKERB_TICKET_UNLOCK_LOGON* = ptr KERB_TICKET_UNLOCK_LOGON
  KERB_S4U_LOGON* {.pure.} = object
    MessageType*: KERB_LOGON_SUBMIT_TYPE
    Flags*: ULONG
    ClientUpn*: UNICODE_STRING
    ClientRealm*: UNICODE_STRING
  PKERB_S4U_LOGON* = ptr KERB_S4U_LOGON
  KERB_INTERACTIVE_PROFILE* {.pure.} = object
    MessageType*: KERB_PROFILE_BUFFER_TYPE
    LogonCount*: USHORT
    BadPasswordCount*: USHORT
    LogonTime*: LARGE_INTEGER
    LogoffTime*: LARGE_INTEGER
    KickOffTime*: LARGE_INTEGER
    PasswordLastSet*: LARGE_INTEGER
    PasswordCanChange*: LARGE_INTEGER
    PasswordMustChange*: LARGE_INTEGER
    LogonScript*: UNICODE_STRING
    HomeDirectory*: UNICODE_STRING
    FullName*: UNICODE_STRING
    ProfilePath*: UNICODE_STRING
    HomeDirectoryDrive*: UNICODE_STRING
    LogonServer*: UNICODE_STRING
    UserFlags*: ULONG
  PKERB_INTERACTIVE_PROFILE* = ptr KERB_INTERACTIVE_PROFILE
  KERB_SMART_CARD_PROFILE* {.pure.} = object
    Profile*: KERB_INTERACTIVE_PROFILE
    CertificateSize*: ULONG
    CertificateData*: PUCHAR
  PKERB_SMART_CARD_PROFILE* = ptr KERB_SMART_CARD_PROFILE
  KERB_CRYPTO_KEY* {.pure.} = object
    KeyType*: LONG
    Length*: ULONG
    Value*: PUCHAR
  PKERB_CRYPTO_KEY* = ptr KERB_CRYPTO_KEY
  KERB_TICKET_PROFILE* {.pure.} = object
    Profile*: KERB_INTERACTIVE_PROFILE
    SessionKey*: KERB_CRYPTO_KEY
  PKERB_TICKET_PROFILE* = ptr KERB_TICKET_PROFILE
  KERB_QUERY_TKT_CACHE_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    LogonId*: LUID
  PKERB_QUERY_TKT_CACHE_REQUEST* = ptr KERB_QUERY_TKT_CACHE_REQUEST
  KERB_TICKET_CACHE_INFO* {.pure.} = object
    ServerName*: UNICODE_STRING
    RealmName*: UNICODE_STRING
    StartTime*: LARGE_INTEGER
    EndTime*: LARGE_INTEGER
    RenewTime*: LARGE_INTEGER
    EncryptionType*: LONG
    TicketFlags*: ULONG
  PKERB_TICKET_CACHE_INFO* = ptr KERB_TICKET_CACHE_INFO
  KERB_TICKET_CACHE_INFO_EX* {.pure.} = object
    ClientName*: UNICODE_STRING
    ClientRealm*: UNICODE_STRING
    ServerName*: UNICODE_STRING
    ServerRealm*: UNICODE_STRING
    StartTime*: LARGE_INTEGER
    EndTime*: LARGE_INTEGER
    RenewTime*: LARGE_INTEGER
    EncryptionType*: LONG
    TicketFlags*: ULONG
  PKERB_TICKET_CACHE_INFO_EX* = ptr KERB_TICKET_CACHE_INFO_EX
  KERB_TICKET_CACHE_INFO_EX2* {.pure.} = object
    ClientName*: UNICODE_STRING
    ClientRealm*: UNICODE_STRING
    ServerName*: UNICODE_STRING
    ServerRealm*: UNICODE_STRING
    StartTime*: LARGE_INTEGER
    EndTime*: LARGE_INTEGER
    RenewTime*: LARGE_INTEGER
    EncryptionType*: LONG
    TicketFlags*: ULONG
    SessionKeyType*: ULONG
  PKERB_TICKET_CACHE_INFO_EX2* = ptr KERB_TICKET_CACHE_INFO_EX2
  KERB_QUERY_TKT_CACHE_RESPONSE* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    CountOfTickets*: ULONG
    Tickets*: array[ANYSIZE_ARRAY, KERB_TICKET_CACHE_INFO]
  PKERB_QUERY_TKT_CACHE_RESPONSE* = ptr KERB_QUERY_TKT_CACHE_RESPONSE
  KERB_QUERY_TKT_CACHE_EX_RESPONSE* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    CountOfTickets*: ULONG
    Tickets*: array[ANYSIZE_ARRAY, KERB_TICKET_CACHE_INFO_EX]
  PKERB_QUERY_TKT_CACHE_EX_RESPONSE* = ptr KERB_QUERY_TKT_CACHE_EX_RESPONSE
  KERB_QUERY_TKT_CACHE_EX2_RESPONSE* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    CountOfTickets*: ULONG
    Tickets*: array[ANYSIZE_ARRAY, KERB_TICKET_CACHE_INFO_EX2]
  PKERB_QUERY_TKT_CACHE_EX2_RESPONSE* = ptr KERB_QUERY_TKT_CACHE_EX2_RESPONSE
  SecHandle* {.pure.} = object
    dwLower*: ULONG_PTR
    dwUpper*: ULONG_PTR
  PSecHandle* = ptr SecHandle
  KERB_AUTH_DATA* {.pure.} = object
    Type*: ULONG
    Length*: ULONG
    Data*: PUCHAR
  PKERB_AUTH_DATA* = ptr KERB_AUTH_DATA
  KERB_NET_ADDRESS* {.pure.} = object
    Family*: ULONG
    Length*: ULONG
    Address*: PCHAR
  PKERB_NET_ADDRESS* = ptr KERB_NET_ADDRESS
  KERB_NET_ADDRESSES* {.pure.} = object
    Number*: ULONG
    Addresses*: array[ANYSIZE_ARRAY, KERB_NET_ADDRESS]
  PKERB_NET_ADDRESSES* = ptr KERB_NET_ADDRESSES
  KERB_EXTERNAL_NAME* {.pure.} = object
    NameType*: SHORT
    NameCount*: USHORT
    Names*: array[ANYSIZE_ARRAY, UNICODE_STRING]
  PKERB_EXTERNAL_NAME* = ptr KERB_EXTERNAL_NAME
  KERB_EXTERNAL_TICKET* {.pure.} = object
    ServiceName*: PKERB_EXTERNAL_NAME
    TargetName*: PKERB_EXTERNAL_NAME
    ClientName*: PKERB_EXTERNAL_NAME
    DomainName*: UNICODE_STRING
    TargetDomainName*: UNICODE_STRING
    AltTargetDomainName*: UNICODE_STRING
    SessionKey*: KERB_CRYPTO_KEY
    TicketFlags*: ULONG
    Flags*: ULONG
    KeyExpirationTime*: LARGE_INTEGER
    StartTime*: LARGE_INTEGER
    EndTime*: LARGE_INTEGER
    RenewUntil*: LARGE_INTEGER
    TimeSkew*: LARGE_INTEGER
    EncodedTicketSize*: ULONG
    EncodedTicket*: PUCHAR
  PKERB_EXTERNAL_TICKET* = ptr KERB_EXTERNAL_TICKET
  KERB_RETRIEVE_TKT_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    LogonId*: LUID
    TargetName*: UNICODE_STRING
    TicketFlags*: ULONG
    CacheOptions*: ULONG
    EncryptionType*: LONG
    CredentialsHandle*: SecHandle
  PKERB_RETRIEVE_TKT_REQUEST* = ptr KERB_RETRIEVE_TKT_REQUEST
  KERB_RETRIEVE_TKT_RESPONSE* {.pure.} = object
    Ticket*: KERB_EXTERNAL_TICKET
  PKERB_RETRIEVE_TKT_RESPONSE* = ptr KERB_RETRIEVE_TKT_RESPONSE
  KERB_PURGE_TKT_CACHE_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    LogonId*: LUID
    ServerName*: UNICODE_STRING
    RealmName*: UNICODE_STRING
  PKERB_PURGE_TKT_CACHE_REQUEST* = ptr KERB_PURGE_TKT_CACHE_REQUEST
  KERB_PURGE_TKT_CACHE_EX_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    LogonId*: LUID
    Flags*: ULONG
    TicketTemplate*: KERB_TICKET_CACHE_INFO_EX
  PKERB_PURGE_TKT_CACHE_EX_REQUEST* = ptr KERB_PURGE_TKT_CACHE_EX_REQUEST
  KERB_CHANGEPASSWORD_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    DomainName*: UNICODE_STRING
    AccountName*: UNICODE_STRING
    OldPassword*: UNICODE_STRING
    NewPassword*: UNICODE_STRING
    Impersonating*: BOOLEAN
  PKERB_CHANGEPASSWORD_REQUEST* = ptr KERB_CHANGEPASSWORD_REQUEST
  KERB_SETPASSWORD_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    LogonId*: LUID
    CredentialsHandle*: SecHandle
    Flags*: ULONG
    DomainName*: UNICODE_STRING
    AccountName*: UNICODE_STRING
    Password*: UNICODE_STRING
  PKERB_SETPASSWORD_REQUEST* = ptr KERB_SETPASSWORD_REQUEST
  KERB_SETPASSWORD_EX_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    LogonId*: LUID
    CredentialsHandle*: SecHandle
    Flags*: ULONG
    AccountRealm*: UNICODE_STRING
    AccountName*: UNICODE_STRING
    Password*: UNICODE_STRING
    ClientRealm*: UNICODE_STRING
    ClientName*: UNICODE_STRING
    Impersonating*: BOOLEAN
    KdcAddress*: UNICODE_STRING
    KdcAddressType*: ULONG
  PKERB_SETPASSWORD_EX_REQUEST* = ptr KERB_SETPASSWORD_EX_REQUEST
  KERB_DECRYPT_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    LogonId*: LUID
    Flags*: ULONG
    CryptoType*: LONG
    KeyUsage*: LONG
    Key*: KERB_CRYPTO_KEY
    EncryptedDataSize*: ULONG
    InitialVectorSize*: ULONG
    InitialVector*: PUCHAR
    EncryptedData*: PUCHAR
  PKERB_DECRYPT_REQUEST* = ptr KERB_DECRYPT_REQUEST
  KERB_DECRYPT_RESPONSE* {.pure.} = object
    DecryptedData*: array[ANYSIZE_ARRAY, UCHAR]
  PKERB_DECRYPT_RESPONSE* = ptr KERB_DECRYPT_RESPONSE
  KERB_ADD_BINDING_CACHE_ENTRY_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    RealmName*: UNICODE_STRING
    KdcAddress*: UNICODE_STRING
    AddressType*: ULONG
  PKERB_ADD_BINDING_CACHE_ENTRY_REQUEST* = ptr KERB_ADD_BINDING_CACHE_ENTRY_REQUEST
  KERB_REFRESH_SCCRED_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    CredentialBlob*: UNICODE_STRING
    LogonId*: LUID
    Flags*: ULONG
  PKERB_REFRESH_SCCRED_REQUEST* = ptr KERB_REFRESH_SCCRED_REQUEST
  KERB_ADD_CREDENTIALS_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    UserName*: UNICODE_STRING
    DomainName*: UNICODE_STRING
    Password*: UNICODE_STRING
    LogonId*: LUID
    Flags*: ULONG
  PKERB_ADD_CREDENTIALS_REQUEST* = ptr KERB_ADD_CREDENTIALS_REQUEST
  KERB_TRANSFER_CRED_REQUEST* {.pure.} = object
    MessageType*: KERB_PROTOCOL_MESSAGE_TYPE
    OriginLogonId*: LUID
    DestinationLogonId*: LUID
    Flags*: ULONG
  PKERB_TRANSFER_CRED_REQUEST* = ptr KERB_TRANSFER_CRED_REQUEST
  AUDIT_POLICY_INFORMATION* {.pure.} = object
    AuditSubCategoryGuid*: GUID
    AuditingInformation*: ULONG
    AuditCategoryGuid*: GUID
  PAUDIT_POLICY_INFORMATION* = ptr AUDIT_POLICY_INFORMATION
  PCAUDIT_POLICY_INFORMATION* = ptr AUDIT_POLICY_INFORMATION
  POLICY_AUDIT_SID_ARRAY* {.pure.} = object
    UsersCount*: ULONG
    UserSidArray*: ptr PSID
  PPOLICY_AUDIT_SID_ARRAY* = ptr POLICY_AUDIT_SID_ARRAY
  KERB_CERTIFICATE_LOGON* {.pure.} = object
    MessageType*: KERB_LOGON_SUBMIT_TYPE
    DomainName*: UNICODE_STRING
    UserName*: UNICODE_STRING
    Pin*: UNICODE_STRING
    Flags*: ULONG
    CspDataLength*: ULONG
    CspData*: PUCHAR
  PKERB_CERTIFICATE_LOGON* = ptr KERB_CERTIFICATE_LOGON
  KERB_CERTIFICATE_UNLOCK_LOGON* {.pure.} = object
    Logon*: KERB_CERTIFICATE_LOGON
    LogonId*: LUID
  PKERB_CERTIFICATE_UNLOCK_LOGON* = ptr KERB_CERTIFICATE_UNLOCK_LOGON
  KERB_SMARTCARD_CSP_INFO_UNION1* {.pure, union.} = object
    ContextInformation*: PVOID
    SpaceHolderForWow64*: ULONG64
  KERB_SMARTCARD_CSP_INFO* {.pure.} = object
    dwCspInfoLen*: DWORD
    MessageType*: DWORD
    union1*: KERB_SMARTCARD_CSP_INFO_UNION1
    flags*: DWORD
    KeySpec*: DWORD
    nCardNameOffset*: ULONG
    nReaderNameOffset*: ULONG
    nContainerNameOffset*: ULONG
    nCSPNameOffset*: ULONG
    bBuffer*: TCHAR
  PKERB_SMARTCARD_CSP_INFO* = ptr KERB_SMARTCARD_CSP_INFO
  CredHandle* = SecHandle
  PCredHandle* = PSecHandle
  CtxtHandle* = SecHandle
  PCtxtHandle* = PSecHandle
  SECURITY_INTEGER* = LARGE_INTEGER
  TimeStamp* = SECURITY_INTEGER
  PTimeStamp* = ptr SECURITY_INTEGER
  SECURITY_STRING* = UNICODE_STRING
  PSECURITY_STRING* = ptr UNICODE_STRING
  SecPkgInfoW* {.pure.} = object
    fCapabilities*: int32
    wVersion*: uint16
    wRPCID*: uint16
    cbMaxToken*: int32
    Name*: ptr SEC_WCHAR
    Comment*: ptr SEC_WCHAR
  PSecPkgInfoW* = ptr SecPkgInfoW
  SecPkgInfoA* {.pure.} = object
    fCapabilities*: int32
    wVersion*: uint16
    wRPCID*: uint16
    cbMaxToken*: int32
    Name*: ptr SEC_CHAR
    Comment*: ptr SEC_CHAR
  PSecPkgInfoA* = ptr SecPkgInfoA
  SecBuffer* {.pure.} = object
    cbBuffer*: int32
    BufferType*: int32
    pvBuffer*: pointer
  PSecBuffer* = ptr SecBuffer
  SecBufferDesc* {.pure.} = object
    ulVersion*: int32
    cBuffers*: int32
    pBuffers*: PSecBuffer
  PSecBufferDesc* = ptr SecBufferDesc
  SEC_NEGOTIATION_INFO* {.pure.} = object
    Size*: int32
    NameLength*: int32
    Name*: ptr SEC_WCHAR
    Reserved*: pointer
  PSEC_NEGOTIATION_INFO* = ptr SEC_NEGOTIATION_INFO
  SEC_CHANNEL_BINDINGS* {.pure.} = object
    dwInitiatorAddrType*: int32
    cbInitiatorLength*: int32
    dwInitiatorOffset*: int32
    dwAcceptorAddrType*: int32
    cbAcceptorLength*: int32
    dwAcceptorOffset*: int32
    cbApplicationDataLength*: int32
    dwApplicationDataOffset*: int32
  PSEC_CHANNEL_BINDINGS* = ptr SEC_CHANNEL_BINDINGS
  SecPkgCredentials_NamesW* {.pure.} = object
    sUserName*: ptr SEC_WCHAR
  PSecPkgCredentials_NamesW* = ptr SecPkgCredentials_NamesW
  SecPkgCredentials_NamesA* {.pure.} = object
    sUserName*: ptr SEC_CHAR
  PSecPkgCredentials_NamesA* = ptr SecPkgCredentials_NamesA
  SecPkgCredentials_SSIProviderW* {.pure.} = object
    sProviderName*: ptr SEC_WCHAR
    ProviderInfoLength*: int32
    ProviderInfo*: ptr char
  PSecPkgCredentials_SSIProviderW* = ptr SecPkgCredentials_SSIProviderW
  SecPkgCredentials_SSIProviderA* {.pure.} = object
    sProviderName*: ptr SEC_CHAR
    ProviderInfoLength*: int32
    ProviderInfo*: ptr char
  PSecPkgCredentials_SSIProviderA* = ptr SecPkgCredentials_SSIProviderA
  SecPkgContext_Sizes* {.pure.} = object
    cbMaxToken*: int32
    cbMaxSignature*: int32
    cbBlockSize*: int32
    cbSecurityTrailer*: int32
  PSecPkgContext_Sizes* = ptr SecPkgContext_Sizes
  SecPkgContext_StreamSizes* {.pure.} = object
    cbHeader*: int32
    cbTrailer*: int32
    cbMaximumMessage*: int32
    cBuffers*: int32
    cbBlockSize*: int32
  PSecPkgContext_StreamSizes* = ptr SecPkgContext_StreamSizes
  SecPkgContext_NamesW* {.pure.} = object
    sUserName*: ptr SEC_WCHAR
  PSecPkgContext_NamesW* = ptr SecPkgContext_NamesW
  SecPkgContext_NamesA* {.pure.} = object
    sUserName*: ptr SEC_CHAR
  PSecPkgContext_NamesA* = ptr SecPkgContext_NamesA
  SecPkgContext_Lifespan* {.pure.} = object
    tsStart*: TimeStamp
    tsExpiry*: TimeStamp
  PSecPkgContext_Lifespan* = ptr SecPkgContext_Lifespan
  SecPkgContext_DceInfo* {.pure.} = object
    AuthzSvc*: int32
    pPac*: pointer
  PSecPkgContext_DceInfo* = ptr SecPkgContext_DceInfo
  SecPkgContext_KeyInfoA* {.pure.} = object
    sSignatureAlgorithmName*: ptr SEC_CHAR
    sEncryptAlgorithmName*: ptr SEC_CHAR
    KeySize*: int32
    SignatureAlgorithm*: int32
    EncryptAlgorithm*: int32
  PSecPkgContext_KeyInfoA* = ptr SecPkgContext_KeyInfoA
  SecPkgContext_KeyInfoW* {.pure.} = object
    sSignatureAlgorithmName*: ptr SEC_WCHAR
    sEncryptAlgorithmName*: ptr SEC_WCHAR
    KeySize*: int32
    SignatureAlgorithm*: int32
    EncryptAlgorithm*: int32
  PSecPkgContext_KeyInfoW* = ptr SecPkgContext_KeyInfoW
  SecPkgContext_AuthorityA* {.pure.} = object
    sAuthorityName*: ptr SEC_CHAR
  PSecPkgContext_AuthorityA* = ptr SecPkgContext_AuthorityA
  SecPkgContext_AuthorityW* {.pure.} = object
    sAuthorityName*: ptr SEC_WCHAR
  PSecPkgContext_AuthorityW* = ptr SecPkgContext_AuthorityW
  SecPkgContext_ProtoInfoA* {.pure.} = object
    sProtocolName*: ptr SEC_CHAR
    majorVersion*: int32
    minorVersion*: int32
  PSecPkgContext_ProtoInfoA* = ptr SecPkgContext_ProtoInfoA
  SecPkgContext_ProtoInfoW* {.pure.} = object
    sProtocolName*: ptr SEC_WCHAR
    majorVersion*: int32
    minorVersion*: int32
  PSecPkgContext_ProtoInfoW* = ptr SecPkgContext_ProtoInfoW
  SecPkgContext_PasswordExpiry* {.pure.} = object
    tsPasswordExpires*: TimeStamp
  PSecPkgContext_PasswordExpiry* = ptr SecPkgContext_PasswordExpiry
  SecPkgContext_LogoffTime* {.pure.} = object
    tsLogoffTime*: TimeStamp
  PSecPkgContext_LogoffTime* = ptr SecPkgContext_LogoffTime
  SecPkgContext_SessionKey* {.pure.} = object
    SessionKeyLength*: int32
    SessionKey*: ptr uint8
  PSecPkgContext_SessionKey* = ptr SecPkgContext_SessionKey
  SecPkgContext_PackageInfoW* {.pure.} = object
    PackageInfo*: PSecPkgInfoW
  PSecPkgContext_PackageInfoW* = ptr SecPkgContext_PackageInfoW
  SecPkgContext_PackageInfoA* {.pure.} = object
    PackageInfo*: PSecPkgInfoA
  PSecPkgContext_PackageInfoA* = ptr SecPkgContext_PackageInfoA
  SecPkgContext_UserFlags* {.pure.} = object
    UserFlags*: int32
  PSecPkgContext_UserFlags* = ptr SecPkgContext_UserFlags
  SecPkgContext_Flags* {.pure.} = object
    Flags*: int32
  PSecPkgContext_Flags* = ptr SecPkgContext_Flags
  SecPkgContext_NegotiationInfoA* {.pure.} = object
    PackageInfo*: PSecPkgInfoA
    NegotiationState*: int32
  PSecPkgContext_NegotiationInfoA* = ptr SecPkgContext_NegotiationInfoA
  SecPkgContext_NegotiationInfoW* {.pure.} = object
    PackageInfo*: PSecPkgInfoW
    NegotiationState*: int32
  PSecPkgContext_NegotiationInfoW* = ptr SecPkgContext_NegotiationInfoW
  SecPkgContext_NativeNamesW* {.pure.} = object
    sClientName*: ptr SEC_WCHAR
    sServerName*: ptr SEC_WCHAR
  PSecPkgContext_NativeNamesW* = ptr SecPkgContext_NativeNamesW
  SecPkgContext_NativeNamesA* {.pure.} = object
    sClientName*: ptr SEC_CHAR
    sServerName*: ptr SEC_CHAR
  PSecPkgContext_NativeNamesA* = ptr SecPkgContext_NativeNamesA
  SecPkgContext_CredentialNameW* {.pure.} = object
    CredentialType*: int32
    sCredentialName*: ptr SEC_WCHAR
  PSecPkgContext_CredentialNameW* = ptr SecPkgContext_CredentialNameW
  SecPkgContext_CredentialNameA* {.pure.} = object
    CredentialType*: int32
    sCredentialName*: ptr SEC_CHAR
  PSecPkgContext_CredentialNameA* = ptr SecPkgContext_CredentialNameA
  SecPkgContext_AccessToken* {.pure.} = object
    AccessToken*: pointer
  PSecPkgContext_AccessToken* = ptr SecPkgContext_AccessToken
  SecPkgContext_TargetInformation* {.pure.} = object
    MarshalledTargetInfoLength*: int32
    MarshalledTargetInfo*: ptr uint8
  PSecPkgContext_TargetInformation* = ptr SecPkgContext_TargetInformation
  SecPkgContext_AuthzID* {.pure.} = object
    AuthzIDLength*: int32
    AuthzID*: ptr char
  PSecPkgContext_AuthzID* = ptr SecPkgContext_AuthzID
  SecPkgContext_Target* {.pure.} = object
    TargetLength*: int32
    Target*: ptr char
  PSecPkgContext_Target* = ptr SecPkgContext_Target
  ENUMERATE_SECURITY_PACKAGES_FN_W* = proc (P1: ptr int32, P2: ptr PSecPkgInfoW): SECURITY_STATUS {.stdcall.}
  QUERY_CREDENTIALS_ATTRIBUTES_FN_W* = proc (P1: PCredHandle, P2: int32, P3: pointer): SECURITY_STATUS {.stdcall.}
  SEC_GET_KEY_FN* = proc (Arg: pointer, Principal: pointer, KeyVer: int32, Key: ptr pointer, Status: ptr SECURITY_STATUS): void {.stdcall.}
  ACQUIRE_CREDENTIALS_HANDLE_FN_W* = proc (P1: ptr SEC_WCHAR, P2: ptr SEC_WCHAR, P3: int32, P4: pointer, P5: pointer, P6: SEC_GET_KEY_FN, P7: pointer, P8: PCredHandle, P9: PTimeStamp): SECURITY_STATUS {.stdcall.}
  FREE_CREDENTIALS_HANDLE_FN* = proc (P1: PCredHandle): SECURITY_STATUS {.stdcall.}
  INITIALIZE_SECURITY_CONTEXT_FN_W* = proc (P1: PCredHandle, P2: PCtxtHandle, P3: ptr SEC_WCHAR, P4: int32, P5: int32, P6: int32, P7: PSecBufferDesc, P8: int32, P9: PCtxtHandle, P10: PSecBufferDesc, P11: ptr int32, P12: PTimeStamp): SECURITY_STATUS {.stdcall.}
  ACCEPT_SECURITY_CONTEXT_FN* = proc (P1: PCredHandle, P2: PCtxtHandle, P3: PSecBufferDesc, P4: int32, P5: int32, P6: PCtxtHandle, P7: PSecBufferDesc, P8: ptr int32, P9: PTimeStamp): SECURITY_STATUS {.stdcall.}
  COMPLETE_AUTH_TOKEN_FN* = proc (P1: PCtxtHandle, P2: PSecBufferDesc): SECURITY_STATUS {.stdcall.}
  DELETE_SECURITY_CONTEXT_FN* = proc (P1: PCtxtHandle): SECURITY_STATUS {.stdcall.}
  APPLY_CONTROL_TOKEN_FN* = proc (P1: PCtxtHandle, P2: PSecBufferDesc): SECURITY_STATUS {.stdcall.}
  QUERY_CONTEXT_ATTRIBUTES_FN_W* = proc (P1: PCtxtHandle, P2: int32, P3: pointer): SECURITY_STATUS {.stdcall.}
  IMPERSONATE_SECURITY_CONTEXT_FN* = proc (P1: PCtxtHandle): SECURITY_STATUS {.stdcall.}
  REVERT_SECURITY_CONTEXT_FN* = proc (P1: PCtxtHandle): SECURITY_STATUS {.stdcall.}
  MAKE_SIGNATURE_FN* = proc (P1: PCtxtHandle, P2: int32, P3: PSecBufferDesc, P4: int32): SECURITY_STATUS {.stdcall.}
  VERIFY_SIGNATURE_FN* = proc (P1: PCtxtHandle, P2: PSecBufferDesc, P3: int32, P4: ptr int32): SECURITY_STATUS {.stdcall.}
  FREE_CONTEXT_BUFFER_FN* = proc (P1: pointer): SECURITY_STATUS {.stdcall.}
  QUERY_SECURITY_PACKAGE_INFO_FN_W* = proc (P1: ptr SEC_WCHAR, P2: ptr PSecPkgInfoW): SECURITY_STATUS {.stdcall.}
  EXPORT_SECURITY_CONTEXT_FN* = proc (P1: PCtxtHandle, P2: ULONG, P3: PSecBuffer, P4: ptr pointer): SECURITY_STATUS {.stdcall.}
  IMPORT_SECURITY_CONTEXT_FN_W* = proc (P1: ptr SEC_WCHAR, P2: PSecBuffer, P3: pointer, P4: PCtxtHandle): SECURITY_STATUS {.stdcall.}
  ADD_CREDENTIALS_FN_W* = proc (P1: PCredHandle, P2: ptr SEC_WCHAR, P3: ptr SEC_WCHAR, P4: int32, P5: pointer, P6: SEC_GET_KEY_FN, P7: pointer, P8: PTimeStamp): SECURITY_STATUS {.stdcall.}
  QUERY_SECURITY_CONTEXT_TOKEN_FN* = proc (P1: PCtxtHandle, P2: ptr HANDLE): SECURITY_STATUS {.stdcall.}
  ENCRYPT_MESSAGE_FN* = proc (P1: PCtxtHandle, P2: int32, P3: PSecBufferDesc, P4: int32): SECURITY_STATUS {.stdcall.}
  DECRYPT_MESSAGE_FN* = proc (P1: PCtxtHandle, P2: PSecBufferDesc, P3: int32, P4: ptr int32): SECURITY_STATUS {.stdcall.}
  SET_CONTEXT_ATTRIBUTES_FN_W* = proc (P1: PCtxtHandle, P2: int32, P3: pointer, P4: int32): SECURITY_STATUS {.stdcall.}
  SET_CREDENTIALS_ATTRIBUTES_FN_W* = proc (P1: PCredHandle, P2: int32, P3: pointer, P4: int32): SECURITY_STATUS {.stdcall.}
  SecurityFunctionTableW* {.pure.} = object
    dwVersion*: int32
    EnumerateSecurityPackagesW*: ENUMERATE_SECURITY_PACKAGES_FN_W
    QueryCredentialsAttributesW*: QUERY_CREDENTIALS_ATTRIBUTES_FN_W
    AcquireCredentialsHandleW*: ACQUIRE_CREDENTIALS_HANDLE_FN_W
    FreeCredentialsHandle*: FREE_CREDENTIALS_HANDLE_FN
    Reserved2*: pointer
    InitializeSecurityContextW*: INITIALIZE_SECURITY_CONTEXT_FN_W
    AcceptSecurityContext*: ACCEPT_SECURITY_CONTEXT_FN
    CompleteAuthToken*: COMPLETE_AUTH_TOKEN_FN
    DeleteSecurityContext*: DELETE_SECURITY_CONTEXT_FN
    ApplyControlToken*: APPLY_CONTROL_TOKEN_FN
    QueryContextAttributesW*: QUERY_CONTEXT_ATTRIBUTES_FN_W
    ImpersonateSecurityContext*: IMPERSONATE_SECURITY_CONTEXT_FN
    RevertSecurityContext*: REVERT_SECURITY_CONTEXT_FN
    MakeSignature*: MAKE_SIGNATURE_FN
    VerifySignature*: VERIFY_SIGNATURE_FN
    FreeContextBuffer*: FREE_CONTEXT_BUFFER_FN
    QuerySecurityPackageInfoW*: QUERY_SECURITY_PACKAGE_INFO_FN_W
    Reserved3*: pointer
    Reserved4*: pointer
    ExportSecurityContext*: EXPORT_SECURITY_CONTEXT_FN
    ImportSecurityContextW*: IMPORT_SECURITY_CONTEXT_FN_W
    AddCredentialsW*: ADD_CREDENTIALS_FN_W
    Reserved8*: pointer
    QuerySecurityContextToken*: QUERY_SECURITY_CONTEXT_TOKEN_FN
    EncryptMessage*: ENCRYPT_MESSAGE_FN
    DecryptMessage*: DECRYPT_MESSAGE_FN
    SetContextAttributesW*: SET_CONTEXT_ATTRIBUTES_FN_W
    SetCredentialsAttributesW*: SET_CREDENTIALS_ATTRIBUTES_FN_W
  PSecurityFunctionTableW* = ptr SecurityFunctionTableW
  ENUMERATE_SECURITY_PACKAGES_FN_A* = proc (P1: ptr int32, P2: ptr PSecPkgInfoA): SECURITY_STATUS {.stdcall.}
  QUERY_CREDENTIALS_ATTRIBUTES_FN_A* = proc (P1: PCredHandle, P2: int32, P3: pointer): SECURITY_STATUS {.stdcall.}
  ACQUIRE_CREDENTIALS_HANDLE_FN_A* = proc (P1: ptr SEC_CHAR, P2: ptr SEC_CHAR, P3: int32, P4: pointer, P5: pointer, P6: SEC_GET_KEY_FN, P7: pointer, P8: PCredHandle, P9: PTimeStamp): SECURITY_STATUS {.stdcall.}
  INITIALIZE_SECURITY_CONTEXT_FN_A* = proc (P1: PCredHandle, P2: PCtxtHandle, P3: ptr SEC_CHAR, P4: int32, P5: int32, P6: int32, P7: PSecBufferDesc, P8: int32, P9: PCtxtHandle, P10: PSecBufferDesc, P11: ptr int32, P12: PTimeStamp): SECURITY_STATUS {.stdcall.}
  QUERY_CONTEXT_ATTRIBUTES_FN_A* = proc (P1: PCtxtHandle, P2: int32, P3: pointer): SECURITY_STATUS {.stdcall.}
  QUERY_SECURITY_PACKAGE_INFO_FN_A* = proc (P1: ptr SEC_CHAR, P2: ptr PSecPkgInfoA): SECURITY_STATUS {.stdcall.}
  IMPORT_SECURITY_CONTEXT_FN_A* = proc (P1: ptr SEC_CHAR, P2: PSecBuffer, P3: pointer, P4: PCtxtHandle): SECURITY_STATUS {.stdcall.}
  ADD_CREDENTIALS_FN_A* = proc (P1: PCredHandle, P2: ptr SEC_CHAR, P3: ptr SEC_CHAR, P4: int32, P5: pointer, P6: SEC_GET_KEY_FN, P7: pointer, P8: PTimeStamp): SECURITY_STATUS {.stdcall.}
  SET_CONTEXT_ATTRIBUTES_FN_A* = proc (P1: PCtxtHandle, P2: int32, P3: pointer, P4: int32): SECURITY_STATUS {.stdcall.}
  SET_CREDENTIALS_ATTRIBUTES_FN_A* = proc (P1: PCredHandle, P2: int32, P3: pointer, P4: int32): SECURITY_STATUS {.stdcall.}
  SecurityFunctionTableA* {.pure.} = object
    dwVersion*: int32
    EnumerateSecurityPackagesA*: ENUMERATE_SECURITY_PACKAGES_FN_A
    QueryCredentialsAttributesA*: QUERY_CREDENTIALS_ATTRIBUTES_FN_A
    AcquireCredentialsHandleA*: ACQUIRE_CREDENTIALS_HANDLE_FN_A
    FreeCredentialHandle*: FREE_CREDENTIALS_HANDLE_FN
    Reserved2*: pointer
    InitializeSecurityContextA*: INITIALIZE_SECURITY_CONTEXT_FN_A
    AcceptSecurityContext*: ACCEPT_SECURITY_CONTEXT_FN
    CompleteAuthToken*: COMPLETE_AUTH_TOKEN_FN
    DeleteSecurityContext*: DELETE_SECURITY_CONTEXT_FN
    ApplyControlToken*: APPLY_CONTROL_TOKEN_FN
    QueryContextAttributesA*: QUERY_CONTEXT_ATTRIBUTES_FN_A
    ImpersonateSecurityContext*: IMPERSONATE_SECURITY_CONTEXT_FN
    RevertSecurityContext*: REVERT_SECURITY_CONTEXT_FN
    MakeSignature*: MAKE_SIGNATURE_FN
    VerifySignature*: VERIFY_SIGNATURE_FN
    FreeContextBuffer*: FREE_CONTEXT_BUFFER_FN
    QuerySecurityPackageInfoA*: QUERY_SECURITY_PACKAGE_INFO_FN_A
    Reserved3*: pointer
    Reserved4*: pointer
    ExportSecurityContext*: EXPORT_SECURITY_CONTEXT_FN
    ImportSecurityContextA*: IMPORT_SECURITY_CONTEXT_FN_A
    AddCredentialsA*: ADD_CREDENTIALS_FN_A
    Reserved8*: pointer
    QuerySecurityContextToken*: QUERY_SECURITY_CONTEXT_TOKEN_FN
    EncryptMessage*: ENCRYPT_MESSAGE_FN
    DecryptMessage*: DECRYPT_MESSAGE_FN
    SetContextAttributesA*: SET_CONTEXT_ATTRIBUTES_FN_A
    SetCredentialsAttributesA*: SET_CREDENTIALS_ATTRIBUTES_FN_A
  PSecurityFunctionTableA* = ptr SecurityFunctionTableA
  SEC_WINNT_AUTH_IDENTITY_W* {.pure.} = object
    User*: ptr uint16
    UserLength*: int32
    Domain*: ptr uint16
    DomainLength*: int32
    Password*: ptr uint16
    PasswordLength*: int32
    Flags*: int32
  PSEC_WINNT_AUTH_IDENTITY_W* = ptr SEC_WINNT_AUTH_IDENTITY_W
  SEC_WINNT_AUTH_IDENTITY_A* {.pure.} = object
    User*: ptr uint8
    UserLength*: int32
    Domain*: ptr uint8
    DomainLength*: int32
    Password*: ptr uint8
    PasswordLength*: int32
    Flags*: int32
  PSEC_WINNT_AUTH_IDENTITY_A* = ptr SEC_WINNT_AUTH_IDENTITY_A
  SEC_WINNT_AUTH_IDENTITY_EXW* {.pure.} = object
    Version*: int32
    Length*: int32
    User*: ptr uint16
    UserLength*: int32
    Domain*: ptr uint16
    DomainLength*: int32
    Password*: ptr uint16
    PasswordLength*: int32
    Flags*: int32
    PackageList*: ptr uint16
    PackageListLength*: int32
  PSEC_WINNT_AUTH_IDENTITY_EXW* = ptr SEC_WINNT_AUTH_IDENTITY_EXW
  SEC_WINNT_AUTH_IDENTITY_EXA* {.pure.} = object
    Version*: int32
    Length*: int32
    User*: ptr uint8
    UserLength*: int32
    Domain*: ptr uint8
    DomainLength*: int32
    Password*: ptr uint8
    PasswordLength*: int32
    Flags*: int32
    PackageList*: ptr uint8
    PackageListLength*: int32
  PSEC_WINNT_AUTH_IDENTITY_EXA* = ptr SEC_WINNT_AUTH_IDENTITY_EXA
  SECURITY_PACKAGE_OPTIONS* {.pure.} = object
    Size*: int32
    Type*: int32
    Flags*: int32
    SignatureSize*: int32
    Signature*: pointer
  PSECURITY_PACKAGE_OPTIONS* = ptr SECURITY_PACKAGE_OPTIONS
  CREDUIWIN_MARSHALED_CONTEXT* {.pure.} = object
    StructureType*: GUID
    cbHeaderLength*: USHORT
    LogonId*: LUID
    MarshaledDataType*: GUID
    MarshaledDataOffset*: ULONG
    MarshaledDataLength*: USHORT
  PCREDUIWIN_MARSHALED_CONTEXT* = ptr CREDUIWIN_MARSHALED_CONTEXT
  PSECURITY_INTEGER* = ptr LARGE_INTEGER
const
  NTLMSP_NAME_A* = "NTLM"
  NTLMSP_NAME* = "NTLM"
  MICROSOFT_KERBEROS_NAME_A* = "Kerberos"
  MICROSOFT_KERBEROS_NAME_W* = "Kerberos"
  NEGOSSP_NAME_W* = "Negotiate"
  NEGOSSP_NAME_A* = "Negotiate"
  LSA_MODE_PASSWORD_PROTECTED* = 0x00000001
  LSA_MODE_INDIVIDUAL_ACCOUNTS* = 0x00000002
  LSA_MODE_MANDATORY_ACCESS* = 0x00000004
  LSA_MODE_LOG_FULL* = 0x00000008
  interactive* = 2
  network* = 3
  batch* = 4
  service* = 5
  proxy* = 6
  unlock* = 7
  networkCleartext* = 8
  newCredentials* = 9
  remoteInteractive* = 10
  cachedInteractive* = 11
  cachedRemoteInteractive* = 12
  cachedUnlock* = 13
  seAdtParmTypeNone* = 0
  seAdtParmTypeString* = 1
  seAdtParmTypeFileSpec* = 2
  seAdtParmTypeUlong* = 3
  seAdtParmTypeSid* = 4
  seAdtParmTypeLogonId* = 5
  seAdtParmTypeNoLogonId* = 6
  seAdtParmTypeAccessMask* = 7
  seAdtParmTypePrivs* = 8
  seAdtParmTypeObjectTypes* = 9
  seAdtParmTypeHexUlong* = 10
  seAdtParmTypePtr* = 11
  seAdtParmTypeTime* = 12
  seAdtParmTypeGuid* = 13
  seAdtParmTypeLuid* = 14
  seAdtParmTypeHexInt64* = 15
  seAdtParmTypeStringList* = 16
  seAdtParmTypeSidList* = 17
  seAdtParmTypeDuration* = 18
  seAdtParmTypeUserAccountControl* = 19
  seAdtParmTypeNoUac* = 20
  seAdtParmTypeMessage* = 21
  seAdtParmTypeDateTime* = 22
  seAdtParmTypeSockAddr* = 23
  SE_ADT_OBJECT_ONLY* = 0x1
  SE_MAX_GENERIC_AUDIT_PARAMETERS* = 28
  SE_ADT_PARAMETERS_SELF_RELATIVE* = 0x00000001
  auditCategorySystem* = 0
  auditCategoryLogon* = 1
  auditCategoryObjectAccess* = 2
  auditCategoryPrivilegeUse* = 3
  auditCategoryDetailedTracking* = 4
  auditCategoryPolicyChange* = 5
  auditCategoryAccountManagement* = 6
  auditCategoryDirectoryServiceAccess* = 7
  auditCategoryAccountLogon* = 8
  POLICY_AUDIT_EVENT_UNCHANGED* = 0x00000000
  POLICY_AUDIT_EVENT_SUCCESS* = 0x00000001
  POLICY_AUDIT_EVENT_FAILURE* = 0x00000002
  POLICY_AUDIT_EVENT_NONE* = 0x00000004
  POLICY_AUDIT_EVENT_MASK* = POLICY_AUDIT_EVENT_SUCCESS or POLICY_AUDIT_EVENT_FAILURE or POLICY_AUDIT_EVENT_UNCHANGED or POLICY_AUDIT_EVENT_NONE
  POLICY_VIEW_LOCAL_INFORMATION* = 0x00000001
  POLICY_VIEW_AUDIT_INFORMATION* = 0x00000002
  POLICY_GET_PRIVATE_INFORMATION* = 0x00000004
  POLICY_TRUST_ADMIN* = 0x00000008
  POLICY_CREATE_ACCOUNT* = 0x00000010
  POLICY_CREATE_SECRET* = 0x00000020
  POLICY_CREATE_PRIVILEGE* = 0x00000040
  POLICY_SET_DEFAULT_QUOTA_LIMITS* = 0x00000080
  POLICY_SET_AUDIT_REQUIREMENTS* = 0x00000100
  POLICY_AUDIT_LOG_ADMIN* = 0x00000200
  POLICY_SERVER_ADMIN* = 0x00000400
  POLICY_LOOKUP_NAMES* = 0x00000800
  POLICY_NOTIFICATION* = 0x00001000
  POLICY_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or POLICY_VIEW_LOCAL_INFORMATION or POLICY_VIEW_AUDIT_INFORMATION or POLICY_GET_PRIVATE_INFORMATION or POLICY_TRUST_ADMIN or POLICY_CREATE_ACCOUNT or POLICY_CREATE_SECRET or POLICY_CREATE_PRIVILEGE or POLICY_SET_DEFAULT_QUOTA_LIMITS or POLICY_SET_AUDIT_REQUIREMENTS or POLICY_AUDIT_LOG_ADMIN or POLICY_SERVER_ADMIN or POLICY_LOOKUP_NAMES
  POLICY_READ* = STANDARD_RIGHTS_READ or POLICY_VIEW_AUDIT_INFORMATION or POLICY_GET_PRIVATE_INFORMATION
  POLICY_WRITE* = STANDARD_RIGHTS_WRITE or POLICY_TRUST_ADMIN or POLICY_CREATE_ACCOUNT or POLICY_CREATE_SECRET or POLICY_CREATE_PRIVILEGE or POLICY_SET_DEFAULT_QUOTA_LIMITS or POLICY_SET_AUDIT_REQUIREMENTS or POLICY_AUDIT_LOG_ADMIN or POLICY_SERVER_ADMIN
  POLICY_EXECUTE* = STANDARD_RIGHTS_EXECUTE or POLICY_VIEW_LOCAL_INFORMATION or POLICY_LOOKUP_NAMES
  policyServerRoleBackup* = 2
  policyServerRolePrimary* = 3
  policyAuditLogInformation* = 1
  policyAuditEventsInformation* = 2
  policyPrimaryDomainInformation* = 3
  policyPdAccountInformation* = 4
  policyAccountDomainInformation* = 5
  policyLsaServerRoleInformation* = 6
  policyReplicaSourceInformation* = 7
  policyDefaultQuotaInformation* = 8
  policyModificationInformation* = 9
  policyAuditFullSetInformation* = 10
  policyAuditFullQueryInformation* = 11
  policyDnsDomainInformation* = 12
  policyDnsDomainInformationInt* = 13
  policyDomainEfsInformation* = 2
  policyDomainKerberosTicketInformation* = 3
  POLICY_KERBEROS_VALIDATE_CLIENT* = 0x00000080
  policyNotifyAuditEventsInformation* = 1
  policyNotifyAccountDomainInformation* = 2
  policyNotifyServerRoleInformation* = 3
  policyNotifyDnsDomainInformation* = 4
  policyNotifyDomainEfsInformation* = 5
  policyNotifyDomainKerberosTicketInformation* = 6
  policyNotifyMachineAccountPasswordInformation* = 7
  trustedDomainNameInformation* = 1
  trustedControllersInformation* = 2
  trustedPosixOffsetInformation* = 3
  trustedPasswordInformation* = 4
  trustedDomainInformationBasic* = 5
  trustedDomainInformationEx* = 6
  trustedDomainAuthInformation* = 7
  trustedDomainFullInformation* = 8
  trustedDomainAuthInformationInternal* = 9
  trustedDomainFullInformationInternal* = 10
  trustedDomainInformationEx2Internal* = 11
  trustedDomainFullInformation2Internal* = 12
  TRUST_DIRECTION_DISABLED* = 0x00000000
  TRUST_DIRECTION_INBOUND* = 0x00000001
  TRUST_DIRECTION_OUTBOUND* = 0x00000002
  TRUST_DIRECTION_BIDIRECTIONAL* = TRUST_DIRECTION_INBOUND or TRUST_DIRECTION_OUTBOUND
  TRUST_TYPE_DOWNLEVEL* = 0x00000001
  TRUST_TYPE_UPLEVEL* = 0x00000002
  TRUST_TYPE_MIT* = 0x00000003
  TRUST_ATTRIBUTE_NON_TRANSITIVE* = 0x00000001
  TRUST_ATTRIBUTE_UPLEVEL_ONLY* = 0x00000002
  TRUST_ATTRIBUTE_QUARANTINED_DOMAIN* = 0x00000004
  TRUST_ATTRIBUTE_FOREST_TRANSITIVE* = 0x00000008
  TRUST_ATTRIBUTE_CROSS_ORGANIZATION* = 0x00000010
  TRUST_ATTRIBUTE_WITHIN_FOREST* = 0x00000020
  TRUST_ATTRIBUTE_TREAT_AS_EXTERNAL* = 0x00000040
  TRUST_ATTRIBUTE_TRUST_USES_RC4_ENCRYPTION* = 0x00000080
  TRUST_ATTRIBUTES_VALID* = 0xFF03FFFF'i32
  TRUST_ATTRIBUTES_USER* = 0xFF000000'i32
  TRUST_AUTH_TYPE_NONE* = 0
  TRUST_AUTH_TYPE_NT4OWF* = 1
  TRUST_AUTH_TYPE_CLEAR* = 2
  TRUST_AUTH_TYPE_VERSION* = 3
  forestTrustTopLevelName* = 0
  forestTrustTopLevelNameEx* = 1
  forestTrustDomainInfo* = 2
  forestTrustRecordTypeLast* = forestTrustDomainInfo
  LSA_FTRECORD_DISABLED_REASONS* = 0x0000FFFF
  LSA_TLN_DISABLED_NEW* = 0x00000001
  LSA_TLN_DISABLED_ADMIN* = 0x00000002
  LSA_TLN_DISABLED_CONFLICT* = 0x00000004
  LSA_SID_DISABLED_ADMIN* = 0x00000001
  LSA_SID_DISABLED_CONFLICT* = 0x00000002
  LSA_NB_DISABLED_ADMIN* = 0x00000004
  LSA_NB_DISABLED_CONFLICT* = 0x00000008
  MAX_FOREST_TRUST_BINARY_DATA_SIZE* = 128*1024
  MAX_RECORDS_IN_FOREST_TRUST_INFO* = 4000
  collisionTdo* = 0
  collisionXref* = 1
  collisionOther* = 2
  SE_INTERACTIVE_LOGON_NAME* = "SeInteractiveLogonRight"
  SE_NETWORK_LOGON_NAME* = "SeNetworkLogonRight"
  SE_BATCH_LOGON_NAME* = "SeBatchLogonRight"
  SE_SERVICE_LOGON_NAME* = "SeServiceLogonRight"
  SE_DENY_INTERACTIVE_LOGON_NAME* = "SeDenyInteractiveLogonRight"
  SE_DENY_NETWORK_LOGON_NAME* = "SeDenyNetworkLogonRight"
  SE_DENY_BATCH_LOGON_NAME* = "SeDenyBatchLogonRight"
  SE_DENY_SERVICE_LOGON_NAME* = "SeDenyServiceLogonRight"
  SE_REMOTE_INTERACTIVE_LOGON_NAME* = "SeRemoteInteractiveLogonRight"
  SE_DENY_REMOTE_INTERACTIVE_LOGON_NAME* = "SeDenyRemoteInteractiveLogonRight"
  negEnumPackagePrefixes* = 0
  negGetCallerName* = 1
  negCallPackageMax* = 2
  DOMAIN_PASSWORD_COMPLEX* = 0x00000001
  DOMAIN_PASSWORD_NO_ANON_CHANGE* = 0x00000002
  DOMAIN_PASSWORD_NO_CLEAR_CHANGE* = 0x00000004
  DOMAIN_LOCKOUT_ADMINS* = 0x00000008
  DOMAIN_PASSWORD_STORE_CLEARTEXT* = 0x00000010
  DOMAIN_REFUSE_PASSWORD_CHANGE* = 0x00000020
  SAM_PASSWORD_CHANGE_NOTIFY_ROUTINE* = "PasswordChangeNotify"
  SAM_INIT_NOTIFICATION_ROUTINE* = "InitializeChangeNotify"
  SAM_PASSWORD_FILTER_ROUTINE* = "PasswordFilter"
  MSV1_0_PACKAGE_NAME* = "MICROSOFT_AUTHENTICATION_PACKAGE_V1_0"
  MSV1_0_PACKAGE_NAMEW* = "MICROSOFT_AUTHENTICATION_PACKAGE_V1_0"
  MSV1_0_SUBAUTHENTICATION_KEY* = "SYSTEM\\CurrentControlSet\\Control\\Lsa\\MSV1_0"
  MSV1_0_SUBAUTHENTICATION_VALUE* = "Auth"
  MsV1_0InteractiveLogon* = 2
  MsV1_0Lm20Logon* = 3
  MsV1_0NetworkLogon* = 4
  MsV1_0SubAuthLogon* = 5
  MsV1_0WorkstationUnlockLogon* = 7
  MsV1_0InteractiveProfile* = 2
  MsV1_0Lm20LogonProfile* = 3
  MsV1_0SmartCardProfile* = 4
  MSV1_0_CLEARTEXT_PASSWORD_ALLOWED* = 0x02
  MSV1_0_UPDATE_LOGON_STATISTICS* = 0x04
  MSV1_0_RETURN_USER_PARAMETERS* = 0x08
  MSV1_0_DONT_TRY_GUEST_ACCOUNT* = 0x10
  MSV1_0_ALLOW_SERVER_TRUST_ACCOUNT* = 0x20
  MSV1_0_RETURN_PASSWORD_EXPIRY* = 0x40
  MSV1_0_USE_CLIENT_CHALLENGE* = 0x80
  MSV1_0_TRY_GUEST_ACCOUNT_ONLY* = 0x100
  MSV1_0_RETURN_PROFILE_PATH* = 0x200
  MSV1_0_TRY_SPECIFIED_DOMAIN_ONLY* = 0x400
  MSV1_0_ALLOW_WORKSTATION_TRUST_ACCOUNT* = 0x800
  MSV1_0_DISABLE_PERSONAL_FALLBACK* = 0x00001000
  MSV1_0_ALLOW_FORCE_GUEST* = 0x00002000
  MSV1_0_CLEARTEXT_PASSWORD_SUPPLIED* = 0x00004000
  MSV1_0_USE_DOMAIN_FOR_ROUTING_ONLY* = 0x00008000
  MSV1_0_SUBAUTHENTICATION_DLL_EX* = 0x00100000
  MSV1_0_ALLOW_MSVCHAPV2* = 0x00010000
  MSV1_0_SUBAUTHENTICATION_DLL* = 0xFF000000'i32
  MSV1_0_SUBAUTHENTICATION_DLL_SHIFT* = 24
  MSV1_0_MNS_LOGON* = 0x01000000
  MSV1_0_SUBAUTHENTICATION_DLL_RAS* = 2
  MSV1_0_SUBAUTHENTICATION_DLL_IIS* = 132
  LOGON_GUEST* = 0x01
  LOGON_NOENCRYPTION* = 0x02
  LOGON_CACHED_ACCOUNT* = 0x04
  LOGON_USED_LM_PASSWORD* = 0x08
  LOGON_EXTRA_SIDS* = 0x20
  LOGON_SUBAUTH_SESSION_KEY* = 0x40
  LOGON_SERVER_TRUST_ACCOUNT* = 0x80
  LOGON_NTLMV2_ENABLED* = 0x100
  LOGON_RESOURCE_GROUPS* = 0x200
  LOGON_PROFILE_PATH_RETURNED* = 0x400
  MSV1_0_SUBAUTHENTICATION_FLAGS* = 0xFF000000'i32
  LOGON_GRACE_LOGON* = 0x01000000
  MSV1_0_CRED_LM_PRESENT* = 0x1
  MSV1_0_CRED_NT_PRESENT* = 0x2
  MSV1_0_CRED_VERSION* = 0
  MSV1_0_NTLM3_OWF_LENGTH* = 16
  MSV1_0_MAX_NTLM3_LIFE* = 129600
  MSV1_0_MAX_AVL_SIZE* = 64000
  MSV1_0_AV_FLAG_FORCE_GUEST* = 0x00000001
  msvAvEOL* = 0
  msvAvNbComputerName* = 1
  msvAvNbDomainName* = 2
  msvAvDnsComputerName* = 3
  msvAvDnsDomainName* = 4
  msvAvDnsTreeName* = 5
  msvAvFlags* = 6
  MsV1_0Lm20ChallengeRequest* = 0
  MsV1_0Lm20GetChallengeResponse* = 1
  MsV1_0EnumerateUsers* = 2
  MsV1_0GetUserInfo* = 3
  MsV1_0ReLogonUsers* = 4
  MsV1_0ChangePassword* = 5
  MsV1_0ChangeCachedPassword* = 6
  MsV1_0GenericPassthrough* = 7
  MsV1_0CacheLogon* = 8
  MsV1_0SubAuth* = 9
  MsV1_0DeriveCredential* = 10
  MsV1_0CacheLookup* = 11
  MsV1_0SetProcessOption* = 12
  RTL_ENCRYPT_MEMORY_SIZE* = 8
  RTL_ENCRYPT_OPTION_CROSS_PROCESS* = 0x01
  RTL_ENCRYPT_OPTION_SAME_LOGON* = 0x02
  KERBEROS_VERSION* = 5
  KERBEROS_REVISION* = 6
  KERB_ETYPE_NULL* = 0
  KERB_ETYPE_DES_CBC_CRC* = 1
  KERB_ETYPE_DES_CBC_MD4* = 2
  KERB_ETYPE_DES_CBC_MD5* = 3
  KERB_ETYPE_RC4_MD4* = -128
  KERB_ETYPE_RC4_PLAIN2* = -129
  KERB_ETYPE_RC4_LM* = -130
  KERB_ETYPE_RC4_SHA* = -131
  KERB_ETYPE_DES_PLAIN* = -132
  KERB_ETYPE_RC4_HMAC_OLD* = -133
  KERB_ETYPE_RC4_PLAIN_OLD* = -134
  KERB_ETYPE_RC4_HMAC_OLD_EXP* = -135
  KERB_ETYPE_RC4_PLAIN_OLD_EXP* = -136
  KERB_ETYPE_RC4_PLAIN* = -140
  KERB_ETYPE_RC4_PLAIN_EXP* = -141
  KERB_ETYPE_DSA_SHA1_CMS* = 9
  KERB_ETYPE_RSA_MD5_CMS* = 10
  KERB_ETYPE_RSA_SHA1_CMS* = 11
  KERB_ETYPE_RC2_CBC_ENV* = 12
  KERB_ETYPE_RSA_ENV* = 13
  KERB_ETYPE_RSA_ES_OEAP_ENV* = 14
  KERB_ETYPE_DES_EDE3_CBC_ENV* = 15
  KERB_ETYPE_DSA_SIGN* = 8
  KERB_ETYPE_RSA_PRIV* = 9
  KERB_ETYPE_RSA_PUB* = 10
  KERB_ETYPE_RSA_PUB_MD5* = 11
  KERB_ETYPE_RSA_PUB_SHA1* = 12
  KERB_ETYPE_PKCS7_PUB* = 13
  KERB_ETYPE_DES3_CBC_MD5* = 5
  KERB_ETYPE_DES3_CBC_SHA1* = 7
  KERB_ETYPE_DES3_CBC_SHA1_KD* = 16
  KERB_ETYPE_DES_CBC_MD5_NT* = 20
  KERB_ETYPE_RC4_HMAC_NT* = 23
  KERB_ETYPE_RC4_HMAC_NT_EXP* = 24
  KERB_CHECKSUM_NONE* = 0
  KERB_CHECKSUM_CRC32* = 1
  KERB_CHECKSUM_MD4* = 2
  KERB_CHECKSUM_KRB_DES_MAC* = 4
  KERB_CHECKSUM_KRB_DES_MAC_K* = 5
  KERB_CHECKSUM_MD5* = 7
  KERB_CHECKSUM_MD5_DES* = 8
  KERB_CHECKSUM_LM* = -130
  KERB_CHECKSUM_SHA1* = -131
  KERB_CHECKSUM_REAL_CRC32* = -132
  KERB_CHECKSUM_DES_MAC* = -133
  KERB_CHECKSUM_DES_MAC_MD5* = -134
  KERB_CHECKSUM_MD25* = -135
  KERB_CHECKSUM_RC4_MD5* = -136
  KERB_CHECKSUM_MD5_HMAC* = -137
  KERB_CHECKSUM_HMAC_MD5* = -138
  AUTH_REQ_ALLOW_FORWARDABLE* = 0x00000001
  AUTH_REQ_ALLOW_PROXIABLE* = 0x00000002
  AUTH_REQ_ALLOW_POSTDATE* = 0x00000004
  AUTH_REQ_ALLOW_RENEWABLE* = 0x00000008
  AUTH_REQ_ALLOW_NOADDRESS* = 0x00000010
  AUTH_REQ_ALLOW_ENC_TKT_IN_SKEY* = 0x00000020
  AUTH_REQ_ALLOW_VALIDATE* = 0x00000040
  AUTH_REQ_VALIDATE_CLIENT* = 0x00000080
  AUTH_REQ_OK_AS_DELEGATE* = 0x00000100
  AUTH_REQ_PREAUTH_REQUIRED* = 0x00000200
  AUTH_REQ_TRANSITIVE_TRUST* = 0x00000400
  AUTH_REQ_ALLOW_S4U_DELEGATE* = 0x00000800
  AUTH_REQ_PER_USER_FLAGS* = AUTH_REQ_ALLOW_FORWARDABLE or AUTH_REQ_ALLOW_PROXIABLE or AUTH_REQ_ALLOW_POSTDATE or AUTH_REQ_ALLOW_RENEWABLE or AUTH_REQ_ALLOW_VALIDATE
  KERB_TICKET_FLAGS_reserved* = 0x80000000'i32
  KERB_TICKET_FLAGS_forwardable* = 0x40000000
  KERB_TICKET_FLAGS_forwarded* = 0x20000000
  KERB_TICKET_FLAGS_proxiable* = 0x10000000
  KERB_TICKET_FLAGS_proxy* = 0x08000000
  KERB_TICKET_FLAGS_may_postdate* = 0x04000000
  KERB_TICKET_FLAGS_postdated* = 0x02000000
  KERB_TICKET_FLAGS_invalid* = 0x01000000
  KERB_TICKET_FLAGS_renewable* = 0x00800000
  KERB_TICKET_FLAGS_initial* = 0x00400000
  KERB_TICKET_FLAGS_pre_authent* = 0x00200000
  KERB_TICKET_FLAGS_hw_authent* = 0x00100000
  KERB_TICKET_FLAGS_ok_as_delegate* = 0x00040000
  KERB_TICKET_FLAGS_name_canonicalize* = 0x00010000
  KERB_TICKET_FLAGS_reserved1* = 0x00000001
  KRB_NT_UNKNOWN* = 0
  KRB_NT_PRINCIPAL* = 1
  KRB_NT_PRINCIPAL_AND_ID* = -131
  KRB_NT_SRV_INST* = 2
  KRB_NT_SRV_INST_AND_ID* = -132
  KRB_NT_SRV_HST* = 3
  KRB_NT_SRV_XHST* = 4
  KRB_NT_UID* = 5
  KRB_NT_ENTERPRISE_PRINCIPAL* = 10
  KRB_NT_ENT_PRINCIPAL_AND_ID* = -130
  KRB_NT_MS_PRINCIPAL* = -128
  KRB_NT_MS_PRINCIPAL_AND_ID* = -129
  KERB_WRAP_NO_ENCRYPT* = 0x80000001'i32
  kerbInteractiveLogon* = 2
  kerbSmartCardLogon* = 6
  kerbWorkstationUnlockLogon* = 7
  kerbSmartCardUnlockLogon* = 8
  kerbProxyLogon* = 9
  kerbTicketLogon* = 10
  kerbTicketUnlockLogon* = 11
  kerbS4ULogon* = 12
  kerbCertificateLogon* = 13
  kerbCertificateS4ULogon* = 14
  kerbCertificateUnlockLogon* = 15
  KERB_LOGON_FLAG_ALLOW_EXPIRED_TICKET* = 0x1
  kerbInteractiveProfile* = 2
  kerbSmartCardProfile* = 4
  kerbTicketProfile* = 6
  kerbDebugRequestMessage* = 0
  kerbQueryTicketCacheMessage* = 1
  kerbChangeMachinePasswordMessage* = 2
  kerbVerifyPacMessage* = 3
  kerbRetrieveTicketMessage* = 4
  kerbUpdateAddressesMessage* = 5
  kerbPurgeTicketCacheMessage* = 6
  kerbChangePasswordMessage* = 7
  kerbRetrieveEncodedTicketMessage* = 8
  kerbDecryptDataMessage* = 9
  kerbAddBindingCacheEntryMessage* = 10
  kerbSetPasswordMessage* = 11
  kerbSetPasswordExMessage* = 12
  kerbVerifyCredentialsMessage* = 13
  kerbQueryTicketCacheExMessage* = 14
  kerbPurgeTicketCacheExMessage* = 15
  kerbRefreshSmartcardCredentialsMessage* = 16
  kerbAddExtraCredentialsMessage* = 17
  kerbQuerySupplementalCredentialsMessage* = 18
  kerbTransferCredentialsMessage* = 19
  kerbQueryTicketCacheEx2Message* = 20
  KERB_USE_DEFAULT_TICKET_FLAGS* = 0x0
  KERB_RETRIEVE_TICKET_DEFAULT* = 0x0
  KERB_RETRIEVE_TICKET_DONT_USE_CACHE* = 0x1
  KERB_RETRIEVE_TICKET_USE_CACHE_ONLY* = 0x2
  KERB_RETRIEVE_TICKET_USE_CREDHANDLE* = 0x4
  KERB_RETRIEVE_TICKET_AS_KERB_CRED* = 0x8
  KERB_RETRIEVE_TICKET_WITH_SEC_CRED* = 0x10
  KERB_RETRIEVE_TICKET_CACHE_TICKET* = 0x20
  KERB_ETYPE_DEFAULT* = 0x0
  KERB_PURGE_ALL_TICKETS* = 1
  DS_UNKNOWN_ADDRESS_TYPE* = 0
  KERB_SETPASS_USE_LOGONID* = 1
  KERB_SETPASS_USE_CREDHANDLE* = 2
  KERB_DECRYPT_FLAG_DEFAULT_KEY* = 0x00000001
  KERB_REFRESH_SCCRED_RELEASE* = 0x0
  KERB_REFRESH_SCCRED_GETTGT* = 0x1
  KERB_REQUEST_ADD_CREDENTIAL* = 1
  KERB_REQUEST_REPLACE_CREDENTIAL* = 2
  KERB_REQUEST_REMOVE_CREDENTIAL* = 4
  PER_USER_POLICY_UNCHANGED* = 0x00
  PER_USER_AUDIT_SUCCESS_INCLUDE* = 0x01
  PER_USER_AUDIT_SUCCESS_EXCLUDE* = 0x02
  PER_USER_AUDIT_FAILURE_INCLUDE* = 0x04
  PER_USER_AUDIT_FAILURE_EXCLUDE* = 0x08
  PER_USER_AUDIT_NONE* = 0x10
  SECPKG_FLAG_INTEGRITY* = 0x00000001
  SECPKG_FLAG_PRIVACY* = 0x00000002
  SECPKG_FLAG_TOKEN_ONLY* = 0x00000004
  SECPKG_FLAG_DATAGRAM* = 0x00000008
  SECPKG_FLAG_CONNECTION* = 0x00000010
  SECPKG_FLAG_MULTI_REQUIRED* = 0x00000020
  SECPKG_FLAG_CLIENT_ONLY* = 0x00000040
  SECPKG_FLAG_EXTENDED_ERROR* = 0x00000080
  SECPKG_FLAG_IMPERSONATION* = 0x00000100
  SECPKG_FLAG_ACCEPT_WIN32_NAME* = 0x00000200
  SECPKG_FLAG_STREAM* = 0x00000400
  SECPKG_FLAG_NEGOTIABLE* = 0x00000800
  SECPKG_FLAG_GSS_COMPATIBLE* = 0x00001000
  SECPKG_FLAG_LOGON* = 0x00002000
  SECPKG_FLAG_ASCII_BUFFERS* = 0x00004000
  SECPKG_FLAG_FRAGMENT* = 0x00008000
  SECPKG_FLAG_MUTUAL_AUTH* = 0x00010000
  SECPKG_FLAG_DELEGATION* = 0x00020000
  SECPKG_FLAG_READONLY_WITH_CHECKSUM* = 0x00040000
  SECPKG_ID_NONE* = 0xFFFF
  SECBUFFER_VERSION* = 0
  SECBUFFER_EMPTY* = 0
  SECBUFFER_DATA* = 1
  SECBUFFER_TOKEN* = 2
  SECBUFFER_PKG_PARAMS* = 3
  SECBUFFER_MISSING* = 4
  SECBUFFER_EXTRA* = 5
  SECBUFFER_STREAM_TRAILER* = 6
  SECBUFFER_STREAM_HEADER* = 7
  SECBUFFER_NEGOTIATION_INFO* = 8
  SECBUFFER_PADDING* = 9
  SECBUFFER_STREAM* = 10
  SECBUFFER_MECHLIST* = 11
  SECBUFFER_MECHLIST_SIGNATURE* = 12
  SECBUFFER_TARGET* = 13
  SECBUFFER_CHANNEL_BINDINGS* = 14
  SECBUFFER_ATTRMASK* = 0xF0000000'i32
  SECBUFFER_READONLY* = 0x80000000'i32
  SECBUFFER_READONLY_WITH_CHECKSUM* = 0x10000000
  SECBUFFER_RESERVED* = 0x60000000
  SECURITY_NATIVE_DREP* = 0x00000010
  SECURITY_NETWORK_DREP* = 0x00000000
  SECPKG_CRED_INBOUND* = 0x00000001
  SECPKG_CRED_OUTBOUND* = 0x00000002
  SECPKG_CRED_BOTH* = 0x00000003
  SECPKG_CRED_DEFAULT* = 0x00000004
  SECPKG_CRED_RESERVED* = 0xF0000000'i32
  ISC_REQ_DELEGATE* = 0x00000001
  ISC_REQ_MUTUAL_AUTH* = 0x00000002
  ISC_REQ_REPLAY_DETECT* = 0x00000004
  ISC_REQ_SEQUENCE_DETECT* = 0x00000008
  ISC_REQ_CONFIDENTIALITY* = 0x00000010
  ISC_REQ_USE_SESSION_KEY* = 0x00000020
  ISC_REQ_PROMPT_FOR_CREDS* = 0x00000040
  ISC_REQ_USE_SUPPLIED_CREDS* = 0x00000080
  ISC_REQ_ALLOCATE_MEMORY* = 0x00000100
  ISC_REQ_USE_DCE_STYLE* = 0x00000200
  ISC_REQ_DATAGRAM* = 0x00000400
  ISC_REQ_CONNECTION* = 0x00000800
  ISC_REQ_CALL_LEVEL* = 0x00001000
  ISC_REQ_FRAGMENT_SUPPLIED* = 0x00002000
  ISC_REQ_EXTENDED_ERROR* = 0x00004000
  ISC_REQ_STREAM* = 0x00008000
  ISC_REQ_INTEGRITY* = 0x00010000
  ISC_REQ_IDENTIFY* = 0x00020000
  ISC_REQ_NULL_SESSION* = 0x00040000
  ISC_REQ_MANUAL_CRED_VALIDATION* = 0x00080000
  ISC_REQ_RESERVED1* = 0x00100000
  ISC_REQ_FRAGMENT_TO_FIT* = 0x00200000
  ISC_RET_DELEGATE* = 0x00000001
  ISC_RET_MUTUAL_AUTH* = 0x00000002
  ISC_RET_REPLAY_DETECT* = 0x00000004
  ISC_RET_SEQUENCE_DETECT* = 0x00000008
  ISC_RET_CONFIDENTIALITY* = 0x00000010
  ISC_RET_USE_SESSION_KEY* = 0x00000020
  ISC_RET_USED_COLLECTED_CREDS* = 0x00000040
  ISC_RET_USED_SUPPLIED_CREDS* = 0x00000080
  ISC_RET_ALLOCATED_MEMORY* = 0x00000100
  ISC_RET_USED_DCE_STYLE* = 0x00000200
  ISC_RET_DATAGRAM* = 0x00000400
  ISC_RET_CONNECTION* = 0x00000800
  ISC_RET_INTERMEDIATE_RETURN* = 0x00001000
  ISC_RET_CALL_LEVEL* = 0x00002000
  ISC_RET_EXTENDED_ERROR* = 0x00004000
  ISC_RET_STREAM* = 0x00008000
  ISC_RET_INTEGRITY* = 0x00010000
  ISC_RET_IDENTIFY* = 0x00020000
  ISC_RET_NULL_SESSION* = 0x00040000
  ISC_RET_MANUAL_CRED_VALIDATION* = 0x00080000
  ISC_RET_RESERVED1* = 0x00100000
  ISC_RET_FRAGMENT_ONLY* = 0x00200000
  ASC_REQ_DELEGATE* = 0x00000001
  ASC_REQ_MUTUAL_AUTH* = 0x00000002
  ASC_REQ_REPLAY_DETECT* = 0x00000004
  ASC_REQ_SEQUENCE_DETECT* = 0x00000008
  ASC_REQ_CONFIDENTIALITY* = 0x00000010
  ASC_REQ_USE_SESSION_KEY* = 0x00000020
  ASC_REQ_ALLOCATE_MEMORY* = 0x00000100
  ASC_REQ_USE_DCE_STYLE* = 0x00000200
  ASC_REQ_DATAGRAM* = 0x00000400
  ASC_REQ_CONNECTION* = 0x00000800
  ASC_REQ_CALL_LEVEL* = 0x00001000
  ASC_REQ_EXTENDED_ERROR* = 0x00008000
  ASC_REQ_STREAM* = 0x00010000
  ASC_REQ_INTEGRITY* = 0x00020000
  ASC_REQ_LICENSING* = 0x00040000
  ASC_REQ_IDENTIFY* = 0x00080000
  ASC_REQ_ALLOW_NULL_SESSION* = 0x00100000
  ASC_REQ_ALLOW_NON_USER_LOGONS* = 0x00200000
  ASC_REQ_ALLOW_CONTEXT_REPLAY* = 0x00400000
  ASC_REQ_FRAGMENT_TO_FIT* = 0x00800000
  ASC_REQ_FRAGMENT_SUPPLIED* = 0x00002000
  ASC_REQ_NO_TOKEN* = 0x01000000
  ASC_RET_DELEGATE* = 0x00000001
  ASC_RET_MUTUAL_AUTH* = 0x00000002
  ASC_RET_REPLAY_DETECT* = 0x00000004
  ASC_RET_SEQUENCE_DETECT* = 0x00000008
  ASC_RET_CONFIDENTIALITY* = 0x00000010
  ASC_RET_USE_SESSION_KEY* = 0x00000020
  ASC_RET_ALLOCATED_MEMORY* = 0x00000100
  ASC_RET_USED_DCE_STYLE* = 0x00000200
  ASC_RET_DATAGRAM* = 0x00000400
  ASC_RET_CONNECTION* = 0x00000800
  ASC_RET_CALL_LEVEL* = 0x00002000
  ASC_RET_THIRD_LEG_FAILED* = 0x00004000
  ASC_RET_EXTENDED_ERROR* = 0x00008000
  ASC_RET_STREAM* = 0x00010000
  ASC_RET_INTEGRITY* = 0x00020000
  ASC_RET_LICENSING* = 0x00040000
  ASC_RET_IDENTIFY* = 0x00080000
  ASC_RET_NULL_SESSION* = 0x00100000
  ASC_RET_ALLOW_NON_USER_LOGONS* = 0x00200000
  ASC_RET_ALLOW_CONTEXT_REPLAY* = 0x00400000
  ASC_RET_FRAGMENT_ONLY* = 0x00800000
  ASC_RET_NO_TOKEN* = 0x01000000
  SECPKG_CRED_ATTR_NAMES* = 1
  SECPKG_CRED_ATTR_SSI_PROVIDER* = 2
  SECPKG_ATTR_SIZES* = 0
  SECPKG_ATTR_NAMES* = 1
  SECPKG_ATTR_LIFESPAN* = 2
  SECPKG_ATTR_DCE_INFO* = 3
  SECPKG_ATTR_STREAM_SIZES* = 4
  SECPKG_ATTR_KEY_INFO* = 5
  SECPKG_ATTR_AUTHORITY* = 6
  SECPKG_ATTR_PROTO_INFO* = 7
  SECPKG_ATTR_PASSWORD_EXPIRY* = 8
  SECPKG_ATTR_SESSION_KEY* = 9
  SECPKG_ATTR_PACKAGE_INFO* = 10
  SECPKG_ATTR_USER_FLAGS* = 11
  SECPKG_ATTR_NEGOTIATION_INFO* = 12
  SECPKG_ATTR_NATIVE_NAMES* = 13
  SECPKG_ATTR_FLAGS* = 14
  SECPKG_ATTR_USE_VALIDATED* = 15
  SECPKG_ATTR_CREDENTIAL_NAME* = 16
  SECPKG_ATTR_TARGET_INFORMATION* = 17
  SECPKG_ATTR_ACCESS_TOKEN* = 18
  SECPKG_ATTR_TARGET* = 19
  SECPKG_ATTR_AUTHENTICATION_ID* = 20
  SECPKG_ATTR_LOGOFF_TIME* = 21
  SECPKG_NEGOTIATION_COMPLETE* = 0
  SECPKG_NEGOTIATION_OPTIMISTIC* = 1
  SECPKG_NEGOTIATION_IN_PROGRESS* = 2
  SECPKG_NEGOTIATION_DIRECT* = 3
  SECPKG_NEGOTIATION_TRY_MULTICRED* = 4
  SECPKG_CONTEXT_EXPORT_RESET_NEW* = 0x00000001
  SECPKG_CONTEXT_EXPORT_DELETE_OLD* = 0x00000002
  SECPKG_CONTEXT_EXPORT_TO_KERNEL* = 0x00000004
  SECQOP_WRAP_NO_ENCRYPT* = 0x80000001'i32
  SECQOP_WRAP_OOB_DATA* = 0x40000000
  secFull* = 0
  secService* = 1
  secTree* = 2
  secDirectory* = 3
  secObject* = 4
  SECURITY_ENTRYPOINT_ANSIW* = "InitSecurityInterfaceW"
  SECURITY_ENTRYPOINT_ANSIA* = "InitSecurityInterfaceA"
  SECURITY_ENTRYPOINTW* = "InitSecurityInterfaceW"
  SECURITY_ENTRYPOINTA* = "InitSecurityInterfaceA"
  SECURITY_ENTRYPOINT16* = "INITSECURITYINTERFACEA"
  SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION* = 1
  SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_2* = 2
  SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_3* = 3
  SASL_OPTION_SEND_SIZE* = 1
  SASL_OPTION_RECV_SIZE* = 2
  SASL_OPTION_AUTHZ_STRING* = 3
  SASL_OPTION_AUTHZ_PROCESSING* = 4
  Sasl_AuthZIDForbidden* = 0
  Sasl_AuthZIDProcessed* = 1
  SEC_WINNT_AUTH_IDENTITY_ANSI* = 0x1
  SEC_WINNT_AUTH_IDENTITY_UNICODE* = 0x2
  SEC_WINNT_AUTH_IDENTITY_VERSION* = 0x200
  SEC_WINNT_AUTH_IDENTITY_MARSHALLED* = 0x4
  SEC_WINNT_AUTH_IDENTITY_ONLY* = 0x8
  SECPKG_OPTIONS_TYPE_UNKNOWN* = 0
  SECPKG_OPTIONS_TYPE_LSA* = 1
  SECPKG_OPTIONS_TYPE_SSPI* = 2
  SECPKG_OPTIONS_PERMANENT* = 0x00000001
  nameUnknown* = 0
  nameFullyQualifiedDN* = 1
  nameSamCompatible* = 2
  nameDisplay* = 3
  nameUniqueId* = 6
  nameCanonical* = 7
  nameUserPrincipal* = 8
  nameCanonicalEx* = 9
  nameServicePrincipal* = 10
  nameDnsDomain* = 12
  nameGivenName* = 13
  nameSurname* = 14
  MSV1_0_NTLM3_INPUT_LENGTH* = 0x00000020
  MSV1_0_NTLM3_MIN_NT_RESPONSE_LENGTH* = 0x0000002C
  MICROSOFT_KERBEROS_NAME* = "Kerberos"
  MSV1_0_PACKAGE_NAMEW_LENGTH* = (len(MSV1_0_PACKAGE_NAMEW)+1)-sizeof(WCHAR)
type
  PSAM_PASSWORD_NOTIFICATION_ROUTINE* = proc (UserName: PUNICODE_STRING, RelativeId: ULONG, NewPassword: PUNICODE_STRING): NTSTATUS {.stdcall.}
  PSAM_INIT_NOTIFICATION_ROUTINE* = proc (): BOOLEAN {.stdcall.}
  PSAM_PASSWORD_FILTER_ROUTINE* = proc (AccountName: PUNICODE_STRING, FullName: PUNICODE_STRING, Password: PUNICODE_STRING, SetOperation: BOOLEAN): BOOLEAN {.stdcall.}
proc LsaRegisterLogonProcess*(LogonProcessName: PLSA_STRING, LsaHandle: PHANDLE, SecurityMode: PLSA_OPERATIONAL_MODE): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaLogonUser*(LsaHandle: HANDLE, OriginName: PLSA_STRING, LogonType: SECURITY_LOGON_TYPE, AuthenticationPackage: ULONG, AuthenticationInformation: PVOID, AuthenticationInformationLength: ULONG, LocalGroups: PTOKEN_GROUPS, SourceContext: PTOKEN_SOURCE, ProfileBuffer: ptr PVOID, ProfileBufferLength: PULONG, LogonId: PLUID, Token: PHANDLE, Quotas: PQUOTA_LIMITS, SubStatus: PNTSTATUS): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaLookupAuthenticationPackage*(LsaHandle: HANDLE, PackageName: PLSA_STRING, AuthenticationPackage: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaFreeReturnBuffer*(Buffer: PVOID): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaCallAuthenticationPackage*(LsaHandle: HANDLE, AuthenticationPackage: ULONG, ProtocolSubmitBuffer: PVOID, SubmitBufferLength: ULONG, ProtocolReturnBuffer: ptr PVOID, ReturnBufferLength: PULONG, ProtocolStatus: PNTSTATUS): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaDeregisterLogonProcess*(LsaHandle: HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaConnectUntrusted*(LsaHandle: PHANDLE): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaFreeMemory*(Buffer: PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaClose*(ObjectHandle: LSA_HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaEnumerateLogonSessions*(LogonSessionCount: PULONG, LogonSessionList: ptr PLUID): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaGetLogonSessionData*(LogonId: PLUID, ppLogonSessionData: ptr PSECURITY_LOGON_SESSION_DATA): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaOpenPolicy*(SystemName: PLSA_UNICODE_STRING, ObjectAttributes: PLSA_OBJECT_ATTRIBUTES, DesiredAccess: ACCESS_MASK, PolicyHandle: PLSA_HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaQueryInformationPolicy*(PolicyHandle: LSA_HANDLE, InformationClass: POLICY_INFORMATION_CLASS, Buffer: ptr PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaSetInformationPolicy*(PolicyHandle: LSA_HANDLE, InformationClass: POLICY_INFORMATION_CLASS, Buffer: PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaQueryDomainInformationPolicy*(PolicyHandle: LSA_HANDLE, InformationClass: POLICY_DOMAIN_INFORMATION_CLASS, Buffer: ptr PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaSetDomainInformationPolicy*(PolicyHandle: LSA_HANDLE, InformationClass: POLICY_DOMAIN_INFORMATION_CLASS, Buffer: PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaRegisterPolicyChangeNotification*(InformationClass: POLICY_NOTIFICATION_INFORMATION_CLASS, NotificationEventHandle: HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaUnregisterPolicyChangeNotification*(InformationClass: POLICY_NOTIFICATION_INFORMATION_CLASS, NotificationEventHandle: HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc LsaEnumerateTrustedDomains*(PolicyHandle: LSA_HANDLE, EnumerationContext: PLSA_ENUMERATION_HANDLE, Buffer: ptr PVOID, PreferedMaximumLength: ULONG, CountReturned: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaLookupNames*(PolicyHandle: LSA_HANDLE, Count: ULONG, Names: PLSA_UNICODE_STRING, ReferencedDomains: ptr PLSA_REFERENCED_DOMAIN_LIST, Sids: ptr PLSA_TRANSLATED_SID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaLookupNames2*(PolicyHandle: LSA_HANDLE, Flags: ULONG, Count: ULONG, Names: PLSA_UNICODE_STRING, ReferencedDomains: ptr PLSA_REFERENCED_DOMAIN_LIST, Sids: ptr PLSA_TRANSLATED_SID2): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaLookupSids*(PolicyHandle: LSA_HANDLE, Count: ULONG, Sids: ptr PSID, ReferencedDomains: ptr PLSA_REFERENCED_DOMAIN_LIST, Names: ptr PLSA_TRANSLATED_NAME): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaEnumerateAccountsWithUserRight*(PolicyHandle: LSA_HANDLE, UserRight: PLSA_UNICODE_STRING, Buffer: ptr PVOID, CountReturned: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaEnumerateAccountRights*(PolicyHandle: LSA_HANDLE, AccountSid: PSID, UserRights: ptr PLSA_UNICODE_STRING, CountOfRights: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaAddAccountRights*(PolicyHandle: LSA_HANDLE, AccountSid: PSID, UserRights: PLSA_UNICODE_STRING, CountOfRights: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaRemoveAccountRights*(PolicyHandle: LSA_HANDLE, AccountSid: PSID, AllRights: BOOLEAN, UserRights: PLSA_UNICODE_STRING, CountOfRights: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaOpenTrustedDomainByName*(PolicyHandle: LSA_HANDLE, TrustedDomainName: PLSA_UNICODE_STRING, DesiredAccess: ACCESS_MASK, TrustedDomainHandle: PLSA_HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaQueryTrustedDomainInfo*(PolicyHandle: LSA_HANDLE, TrustedDomainSid: PSID, InformationClass: TRUSTED_INFORMATION_CLASS, Buffer: ptr PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaSetTrustedDomainInformation*(PolicyHandle: LSA_HANDLE, TrustedDomainSid: PSID, InformationClass: TRUSTED_INFORMATION_CLASS, Buffer: PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaDeleteTrustedDomain*(PolicyHandle: LSA_HANDLE, TrustedDomainSid: PSID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaQueryTrustedDomainInfoByName*(PolicyHandle: LSA_HANDLE, TrustedDomainName: PLSA_UNICODE_STRING, InformationClass: TRUSTED_INFORMATION_CLASS, Buffer: ptr PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaSetTrustedDomainInfoByName*(PolicyHandle: LSA_HANDLE, TrustedDomainName: PLSA_UNICODE_STRING, InformationClass: TRUSTED_INFORMATION_CLASS, Buffer: PVOID): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaEnumerateTrustedDomainsEx*(PolicyHandle: LSA_HANDLE, EnumerationContext: PLSA_ENUMERATION_HANDLE, Buffer: ptr PVOID, PreferedMaximumLength: ULONG, CountReturned: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaCreateTrustedDomainEx*(PolicyHandle: LSA_HANDLE, TrustedDomainInformation: PTRUSTED_DOMAIN_INFORMATION_EX, AuthenticationInformation: PTRUSTED_DOMAIN_AUTH_INFORMATION, DesiredAccess: ACCESS_MASK, TrustedDomainHandle: PLSA_HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaQueryForestTrustInformation*(PolicyHandle: LSA_HANDLE, TrustedDomainName: PLSA_UNICODE_STRING, ForestTrustInfo: ptr PLSA_FOREST_TRUST_INFORMATION): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaSetForestTrustInformation*(PolicyHandle: LSA_HANDLE, TrustedDomainName: PLSA_UNICODE_STRING, ForestTrustInfo: PLSA_FOREST_TRUST_INFORMATION, CheckOnly: BOOLEAN, CollisionInfo: ptr PLSA_FOREST_TRUST_COLLISION_INFORMATION): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaStorePrivateData*(PolicyHandle: LSA_HANDLE, KeyName: PLSA_UNICODE_STRING, PrivateData: PLSA_UNICODE_STRING): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaRetrievePrivateData*(PolicyHandle: LSA_HANDLE, KeyName: PLSA_UNICODE_STRING, PrivateData: ptr PLSA_UNICODE_STRING): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LsaNtStatusToWinError*(Status: NTSTATUS): ULONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SystemFunction036*(RandomBuffer: PVOID, RandomBufferLength: ULONG): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SystemFunction040*(Memory: PVOID, MemorySize: ULONG, OptionFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SystemFunction041*(Memory: PVOID, MemorySize: ULONG, OptionFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditComputeEffectivePolicyBySid*(pSid: PSID, pSubCategoryGuids: ptr GUID, PolicyCount: ULONG, ppAuditPolicy: ptr PAUDIT_POLICY_INFORMATION): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditFree*(Buffer: PVOID): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditSetSystemPolicy*(pAuditPolicy: PCAUDIT_POLICY_INFORMATION, PolicyCount: ULONG): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditQuerySystemPolicy*(pSubCategoryGuids: ptr GUID, PolicyCount: ULONG, ppAuditPolicy: ptr PAUDIT_POLICY_INFORMATION): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditSetPerUserPolicy*(pSid: PSID, pAuditPolicy: PCAUDIT_POLICY_INFORMATION, PolicyCount: ULONG): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditQueryPerUserPolicy*(pSid: PSID, pSubCategoryGuids: ptr GUID, PolicyCount: ULONG, ppAuditPolicy: ptr PAUDIT_POLICY_INFORMATION): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditComputeEffectivePolicyByToken*(hTokenHandle: HANDLE, pSubCategoryGuids: ptr GUID, PolicyCount: ULONG, ppAuditPolicy: ptr PAUDIT_POLICY_INFORMATION): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditEnumerateCategories*(ppAuditCategoriesArray: ptr ptr GUID, pCountReturned: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditEnumeratePerUserPolicy*(ppAuditSidArray: ptr PPOLICY_AUDIT_SID_ARRAY): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditEnumerateSubCategories*(pAuditCategoryGuid: ptr GUID, bRetrieveAllSubCategories: BOOLEAN, ppAuditSubCategoriesArray: ptr ptr GUID, pCountReturned: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditLookupCategoryGuidFromCategoryId*(AuditCategoryId: POLICY_AUDIT_EVENT_TYPE, pAuditCategoryGuid: ptr GUID): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditQuerySecurity*(SecurityInformation: SECURITY_INFORMATION, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditLookupSubCategoryNameA*(pAuditSubCategoryGuid: ptr GUID, ppszSubCategoryName: ptr LPSTR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditLookupSubCategoryNameW*(pAuditSubCategoryGuid: ptr GUID, ppszSubCategoryName: ptr LPWSTR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditLookupCategoryNameA*(pAuditCategoryGuid: ptr GUID, ppszCategoryName: ptr LPSTR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditLookupCategoryNameW*(pAuditCategoryGuid: ptr GUID, ppszCategoryName: ptr LPWSTR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditLookupCategoryIdFromCategoryGuid*(pAuditCategoryGuid: ptr GUID, pAuditCategoryId: PPOLICY_AUDIT_EVENT_TYPE): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuditSetSecurity*(SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AcquireCredentialsHandleW*(pszPrincipal: ptr SEC_WCHAR, pszPackage: ptr SEC_WCHAR, fCredentialUse: int32, pvLogonId: pointer, pAuthData: pointer, pGetKeyFn: SEC_GET_KEY_FN, pvGetKeyArgument: pointer, phCredential: PCredHandle, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc AcquireCredentialsHandleA*(pszPrincipal: ptr SEC_CHAR, pszPackage: ptr SEC_CHAR, fCredentialUse: int32, pvLogonId: pointer, pAuthData: pointer, pGetKeyFn: SEC_GET_KEY_FN, pvGetKeyArgument: pointer, phCredential: PCredHandle, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc FreeCredentialsHandle*(phCredential: PCredHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc AddCredentialsW*(hCredentials: PCredHandle, pszPrincipal: ptr SEC_WCHAR, pszPackage: ptr SEC_WCHAR, fCredentialUse: int32, pAuthData: pointer, pGetKeyFn: SEC_GET_KEY_FN, pvGetKeyArgument: pointer, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc AddCredentialsA*(hCredentials: PCredHandle, pszPrincipal: ptr SEC_CHAR, pszPackage: ptr SEC_CHAR, fCredentialUse: int32, pAuthData: pointer, pGetKeyFn: SEC_GET_KEY_FN, pvGetKeyArgument: pointer, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc InitializeSecurityContextW*(phCredential: PCredHandle, phContext: PCtxtHandle, pszTargetName: ptr SEC_WCHAR, fContextReq: int32, Reserved1: int32, TargetDataRep: int32, pInput: PSecBufferDesc, Reserved2: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc InitializeSecurityContextA*(phCredential: PCredHandle, phContext: PCtxtHandle, pszTargetName: ptr SEC_CHAR, fContextReq: int32, Reserved1: int32, TargetDataRep: int32, pInput: PSecBufferDesc, Reserved2: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc AcceptSecurityContext*(phCredential: PCredHandle, phContext: PCtxtHandle, pInput: PSecBufferDesc, fContextReq: int32, TargetDataRep: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc CompleteAuthToken*(phContext: PCtxtHandle, pToken: PSecBufferDesc): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc ImpersonateSecurityContext*(phContext: PCtxtHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc RevertSecurityContext*(phContext: PCtxtHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc QuerySecurityContextToken*(phContext: PCtxtHandle, Token: ptr HANDLE): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc DeleteSecurityContext*(phContext: PCtxtHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc ApplyControlToken*(phContext: PCtxtHandle, pInput: PSecBufferDesc): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc QueryContextAttributesW*(phContext: PCtxtHandle, ulAttribute: int32, pBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc QueryContextAttributesA*(phContext: PCtxtHandle, ulAttribute: int32, pBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SetContextAttributesW*(phContext: PCtxtHandle, ulAttribute: int32, pBuffer: pointer, cbBuffer: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SetContextAttributesA*(phContext: PCtxtHandle, ulAttribute: int32, pBuffer: pointer, cbBuffer: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc QueryCredentialsAttributesW*(phCredential: PCredHandle, ulAttribute: int32, pBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc QueryCredentialsAttributesA*(phCredential: PCredHandle, ulAttribute: int32, pBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SetCredentialsAttributesW*(phCredential: PCredHandle, ulAttribute: int32, pBuffer: pointer, cbBuffer: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SetCredentialsAttributesA*(phCredential: PCredHandle, ulAttribute: int32, pBuffer: pointer, cbBuffer: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc FreeContextBuffer*(pvContextBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc MakeSignature*(phContext: PCtxtHandle, fQOP: int32, pMessage: PSecBufferDesc, MessageSeqNo: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc VerifySignature*(phContext: PCtxtHandle, pMessage: PSecBufferDesc, MessageSeqNo: int32, pfQOP: ptr int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc EncryptMessage*(phContext: PCtxtHandle, fQOP: int32, pMessage: PSecBufferDesc, MessageSeqNo: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc DecryptMessage*(phContext: PCtxtHandle, pMessage: PSecBufferDesc, MessageSeqNo: int32, pfQOP: ptr int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc EnumerateSecurityPackagesW*(pcPackages: ptr int32, ppPackageInfo: ptr PSecPkgInfoW): SECURITY_STATUS {.winapi, stdcall, dynlib: "sspicli", importc.}
proc EnumerateSecurityPackagesA*(pcPackages: ptr int32, ppPackageInfo: ptr PSecPkgInfoA): SECURITY_STATUS {.winapi, stdcall, dynlib: "sspicli", importc.}
proc QuerySecurityPackageInfoW*(pszPackageName: ptr SEC_WCHAR, ppPackageInfo: ptr PSecPkgInfoW): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc QuerySecurityPackageInfoA*(pszPackageName: ptr SEC_CHAR, ppPackageInfo: ptr PSecPkgInfoA): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc ExportSecurityContext*(phContext: PCtxtHandle, fFlags: ULONG, pPackedContext: PSecBuffer, pToken: ptr pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc ImportSecurityContextW*(pszPackage: ptr SEC_WCHAR, pPackedContext: PSecBuffer, Token: pointer, phContext: PCtxtHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc ImportSecurityContextA*(pszPackage: ptr SEC_CHAR, pPackedContext: PSecBuffer, Token: pointer, phContext: PCtxtHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc FreeCredentialHandle*(phCredential: PCredHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "FreeCredentialsHandle".}
proc InitSecurityInterfaceA*(): PSecurityFunctionTableA {.winapi, stdcall, dynlib: "secur32", importc.}
proc InitSecurityInterfaceW*(): PSecurityFunctionTableW {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslEnumerateProfilesA*(ProfileList: ptr LPSTR, ProfileCount: ptr ULONG): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslEnumerateProfilesW*(ProfileList: ptr LPWSTR, ProfileCount: ptr ULONG): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslGetProfilePackageA*(ProfileName: LPSTR, PackageInfo: ptr PSecPkgInfoA): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslGetProfilePackageW*(ProfileName: LPWSTR, PackageInfo: ptr PSecPkgInfoW): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslIdentifyPackageA*(pInput: PSecBufferDesc, PackageInfo: ptr PSecPkgInfoA): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslIdentifyPackageW*(pInput: PSecBufferDesc, PackageInfo: ptr PSecPkgInfoW): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslInitializeSecurityContextW*(phCredential: PCredHandle, phContext: PCtxtHandle, pszTargetName: LPWSTR, fContextReq: int32, Reserved1: int32, TargetDataRep: int32, pInput: PSecBufferDesc, Reserved2: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslInitializeSecurityContextA*(phCredential: PCredHandle, phContext: PCtxtHandle, pszTargetName: LPSTR, fContextReq: int32, Reserved1: int32, TargetDataRep: int32, pInput: PSecBufferDesc, Reserved2: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslAcceptSecurityContext*(phCredential: PCredHandle, phContext: PCtxtHandle, pInput: PSecBufferDesc, fContextReq: int32, TargetDataRep: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslSetContextOption*(ContextHandle: PCtxtHandle, Option: ULONG, Value: PVOID, Size: ULONG): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc SaslGetContextOption*(ContextHandle: PCtxtHandle, Option: ULONG, Value: PVOID, Size: ULONG, Needed: PULONG): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc AddSecurityPackageA*(pszPackageName: LPSTR, pOptions: PSECURITY_PACKAGE_OPTIONS): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc AddSecurityPackageW*(pszPackageName: LPWSTR, pOptions: PSECURITY_PACKAGE_OPTIONS): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc DeleteSecurityPackageA*(pszPackageName: ptr SEC_CHAR): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc DeleteSecurityPackageW*(pszPackageName: ptr SEC_WCHAR): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc.}
proc GetUserNameExA*(NameFormat: EXTENDED_NAME_FORMAT, lpNameBuffer: LPSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc.}
proc GetUserNameExW*(NameFormat: EXTENDED_NAME_FORMAT, lpNameBuffer: LPWSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc.}
proc GetComputerObjectNameA*(NameFormat: EXTENDED_NAME_FORMAT, lpNameBuffer: LPSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc.}
proc GetComputerObjectNameW*(NameFormat: EXTENDED_NAME_FORMAT, lpNameBuffer: LPWSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc.}
proc TranslateNameA*(lpAccountName: LPCSTR, AccountNameFormat: EXTENDED_NAME_FORMAT, DesiredNameFormat: EXTENDED_NAME_FORMAT, lpTranslatedName: LPSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc.}
proc TranslateNameW*(lpAccountName: LPCWSTR, AccountNameFormat: EXTENDED_NAME_FORMAT, DesiredNameFormat: EXTENDED_NAME_FORMAT, lpTranslatedName: LPWSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc.}
proc RtlGenRandom*(RandomBuffer: PVOID, RandomBufferLength: ULONG): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc: "SystemFunction036".}
proc RtlEncryptMemory*(Memory: PVOID, MemorySize: ULONG, OptionFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc: "SystemFunction040".}
proc RtlDecryptMemory*(Memory: PVOID, MemorySize: ULONG, OptionFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "advapi32", importc: "SystemFunction041".}
proc `ContextInformation=`*(self: var KERB_SMARTCARD_CSP_INFO, x: PVOID) {.inline.} = self.union1.ContextInformation = x
proc ContextInformation*(self: KERB_SMARTCARD_CSP_INFO): PVOID {.inline.} = self.union1.ContextInformation
proc ContextInformation*(self: var KERB_SMARTCARD_CSP_INFO): var PVOID {.inline.} = self.union1.ContextInformation
proc `SpaceHolderForWow64=`*(self: var KERB_SMARTCARD_CSP_INFO, x: ULONG64) {.inline.} = self.union1.SpaceHolderForWow64 = x
proc SpaceHolderForWow64*(self: KERB_SMARTCARD_CSP_INFO): ULONG64 {.inline.} = self.union1.SpaceHolderForWow64
proc SpaceHolderForWow64*(self: var KERB_SMARTCARD_CSP_INFO): var ULONG64 {.inline.} = self.union1.SpaceHolderForWow64
when winimUnicode:
  type
    SECURITY_PSTR* = ptr SEC_WCHAR
    SECURITY_PCSTR* = ptr SEC_WCHAR
    SecPkgInfo* = SecPkgInfoW
    PSecPkgInfo* = PSecPkgInfoW
    SecPkgCredentials_Names* = SecPkgCredentials_NamesW
    PSecPkgCredentials_Names* = PSecPkgCredentials_NamesW
    SecPkgCredentials_SSIProvider* = SecPkgCredentials_SSIProviderW
    PSecPkgCredentials_SSIProvider* = PSecPkgCredentials_SSIProviderW
    SecPkgContext_Names* = SecPkgContext_NamesW
    PSecPkgContext_Names* = PSecPkgContext_NamesW
    SecPkgContext_KeyInfo* = SecPkgContext_KeyInfoW
    PSecPkgContext_KeyInfo* = PSecPkgContext_KeyInfoW
    SecPkgContext_Authority* = SecPkgContext_AuthorityW
    PSecPkgContext_Authority* = PSecPkgContext_AuthorityW
    SecPkgContext_ProtoInfo* = SecPkgContext_ProtoInfoW
    PSecPkgContext_ProtoInfo* = PSecPkgContext_ProtoInfoW
    SecPkgContext_PackageInfo* = SecPkgContext_PackageInfoW
    PSecPkgContext_PackageInfo* = PSecPkgContext_PackageInfoW
    SecPkgContext_NegotiationInfo* = SecPkgContext_NegotiationInfoW
    PSecPkgContext_NegotiationInfo* = PSecPkgContext_NegotiationInfoW
    SecPkgContext_NativeNames* = SecPkgContext_NativeNamesW
    PSecPkgContext_NativeNames* = PSecPkgContext_NativeNamesW
    SecPkgContext_CredentialName* = SecPkgContext_CredentialNameW
    PSecPkgContext_CredentialName* = PSecPkgContext_CredentialNameW
    ACQUIRE_CREDENTIALS_HANDLE_FN* = ACQUIRE_CREDENTIALS_HANDLE_FN_W
    ADD_CREDENTIALS_FN* = ADD_CREDENTIALS_FN_W
    INITIALIZE_SECURITY_CONTEXT_FN* = INITIALIZE_SECURITY_CONTEXT_FN_W
    QUERY_CONTEXT_ATTRIBUTES_FN* = QUERY_CONTEXT_ATTRIBUTES_FN_W
    SET_CONTEXT_ATTRIBUTES_FN* = SET_CONTEXT_ATTRIBUTES_FN_W
    QUERY_CREDENTIALS_ATTRIBUTES_FN* = QUERY_CREDENTIALS_ATTRIBUTES_FN_W
    SET_CREDENTIALS_ATTRIBUTES_FN* = SET_CREDENTIALS_ATTRIBUTES_FN_W
    ENUMERATE_SECURITY_PACKAGES_FN* = ENUMERATE_SECURITY_PACKAGES_FN_W
    QUERY_SECURITY_PACKAGE_INFO_FN* = QUERY_SECURITY_PACKAGE_INFO_FN_W
    IMPORT_SECURITY_CONTEXT_FN* = IMPORT_SECURITY_CONTEXT_FN_W
    SecurityFunctionTable* = SecurityFunctionTableW
    PSecurityFunctionTable* = PSecurityFunctionTableW
    SEC_WINNT_AUTH_IDENTITY* = SEC_WINNT_AUTH_IDENTITY_W
    PSEC_WINNT_AUTH_IDENTITY* = PSEC_WINNT_AUTH_IDENTITY_W
    SEC_WINNT_AUTH_IDENTITY_EX* = SEC_WINNT_AUTH_IDENTITY_EXW
    PSEC_WINNT_AUTH_IDENTITY_EX* = PSEC_WINNT_AUTH_IDENTITY_EXW
  const
    NEGOSSP_NAME* = NEGOSSP_NAME_W
    SECURITY_ENTRYPOINT* = SECURITY_ENTRYPOINTW
    SECURITY_ENTRYPOINT_ANSI* = SECURITY_ENTRYPOINT_ANSIW
  proc AuditLookupSubCategoryName*(pAuditSubCategoryGuid: ptr GUID, ppszSubCategoryName: ptr LPWSTR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc: "AuditLookupSubCategoryNameW".}
  proc AuditLookupCategoryName*(pAuditCategoryGuid: ptr GUID, ppszCategoryName: ptr LPWSTR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc: "AuditLookupCategoryNameW".}
  proc AcquireCredentialsHandle*(pszPrincipal: ptr SEC_WCHAR, pszPackage: ptr SEC_WCHAR, fCredentialUse: int32, pvLogonId: pointer, pAuthData: pointer, pGetKeyFn: SEC_GET_KEY_FN, pvGetKeyArgument: pointer, phCredential: PCredHandle, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "AcquireCredentialsHandleW".}
  proc AddCredentials*(hCredentials: PCredHandle, pszPrincipal: ptr SEC_WCHAR, pszPackage: ptr SEC_WCHAR, fCredentialUse: int32, pAuthData: pointer, pGetKeyFn: SEC_GET_KEY_FN, pvGetKeyArgument: pointer, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "AddCredentialsW".}
  proc InitializeSecurityContext*(phCredential: PCredHandle, phContext: PCtxtHandle, pszTargetName: ptr SEC_WCHAR, fContextReq: int32, Reserved1: int32, TargetDataRep: int32, pInput: PSecBufferDesc, Reserved2: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "InitializeSecurityContextW".}
  proc QueryContextAttributes*(phContext: PCtxtHandle, ulAttribute: int32, pBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "QueryContextAttributesW".}
  proc SetContextAttributes*(phContext: PCtxtHandle, ulAttribute: int32, pBuffer: pointer, cbBuffer: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SetContextAttributesW".}
  proc QueryCredentialsAttributes*(phCredential: PCredHandle, ulAttribute: int32, pBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "QueryCredentialsAttributesW".}
  proc SetCredentialsAttributes*(phCredential: PCredHandle, ulAttribute: int32, pBuffer: pointer, cbBuffer: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SetCredentialsAttributesW".}
  proc EnumerateSecurityPackages*(pcPackages: ptr int32, ppPackageInfo: ptr PSecPkgInfoW): SECURITY_STATUS {.winapi, stdcall, dynlib: "sspicli", importc: "EnumerateSecurityPackagesW".}
  proc QuerySecurityPackageInfo*(pszPackageName: ptr SEC_WCHAR, ppPackageInfo: ptr PSecPkgInfoW): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "QuerySecurityPackageInfoW".}
  proc ImportSecurityContext*(pszPackage: ptr SEC_WCHAR, pPackedContext: PSecBuffer, Token: pointer, phContext: PCtxtHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "ImportSecurityContextW".}
  proc InitSecurityInterface*(): PSecurityFunctionTableW {.winapi, stdcall, dynlib: "secur32", importc: "InitSecurityInterfaceW".}
  proc SaslEnumerateProfiles*(ProfileList: ptr LPWSTR, ProfileCount: ptr ULONG): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SaslEnumerateProfilesW".}
  proc SaslGetProfilePackage*(ProfileName: LPWSTR, PackageInfo: ptr PSecPkgInfoW): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SaslGetProfilePackageW".}
  proc SaslIdentifyPackage*(pInput: PSecBufferDesc, PackageInfo: ptr PSecPkgInfoW): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SaslIdentifyPackageW".}
  proc SaslInitializeSecurityContext*(phCredential: PCredHandle, phContext: PCtxtHandle, pszTargetName: LPWSTR, fContextReq: int32, Reserved1: int32, TargetDataRep: int32, pInput: PSecBufferDesc, Reserved2: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SaslInitializeSecurityContextW".}
  proc AddSecurityPackage*(pszPackageName: LPWSTR, pOptions: PSECURITY_PACKAGE_OPTIONS): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "AddSecurityPackageW".}
  proc DeleteSecurityPackage*(pszPackageName: ptr SEC_WCHAR): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "DeleteSecurityPackageW".}
  proc GetUserNameEx*(NameFormat: EXTENDED_NAME_FORMAT, lpNameBuffer: LPWSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc: "GetUserNameExW".}
  proc GetComputerObjectName*(NameFormat: EXTENDED_NAME_FORMAT, lpNameBuffer: LPWSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc: "GetComputerObjectNameW".}
  proc TranslateName*(lpAccountName: LPCWSTR, AccountNameFormat: EXTENDED_NAME_FORMAT, DesiredNameFormat: EXTENDED_NAME_FORMAT, lpTranslatedName: LPWSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc: "TranslateNameW".}
when winimAnsi:
  type
    SECURITY_PSTR* = ptr SEC_CHAR
    SECURITY_PCSTR* = ptr SEC_CHAR
    SecPkgInfo* = SecPkgInfoA
    PSecPkgInfo* = PSecPkgInfoA
    SecPkgCredentials_Names* = SecPkgCredentials_NamesA
    PSecPkgCredentials_Names* = PSecPkgCredentials_NamesA
    SecPkgCredentials_SSIProvider* = SecPkgCredentials_SSIProviderA
    PSecPkgCredentials_SSIProvider* = PSecPkgCredentials_SSIProviderA
    SecPkgContext_Names* = SecPkgContext_NamesA
    PSecPkgContext_Names* = PSecPkgContext_NamesA
    SecPkgContext_KeyInfo* = SecPkgContext_KeyInfoA
    PSecPkgContext_KeyInfo* = PSecPkgContext_KeyInfoA
    SecPkgContext_Authority* = SecPkgContext_AuthorityA
    PSecPkgContext_Authority* = PSecPkgContext_AuthorityA
    SecPkgContext_ProtoInfo* = SecPkgContext_ProtoInfoA
    PSecPkgContext_ProtoInfo* = PSecPkgContext_ProtoInfoA
    SecPkgContext_PackageInfo* = SecPkgContext_PackageInfoA
    PSecPkgContext_PackageInfo* = PSecPkgContext_PackageInfoA
    SecPkgContext_NegotiationInfo* = SecPkgContext_NegotiationInfoA
    PSecPkgContext_NegotiationInfo* = PSecPkgContext_NegotiationInfoA
    SecPkgContext_NativeNames* = SecPkgContext_NativeNamesA
    PSecPkgContext_NativeNames* = PSecPkgContext_NativeNamesA
    SecPkgContext_CredentialName* = SecPkgContext_CredentialNameA
    PSecPkgContext_CredentialName* = PSecPkgContext_CredentialNameA
    ACQUIRE_CREDENTIALS_HANDLE_FN* = ACQUIRE_CREDENTIALS_HANDLE_FN_A
    ADD_CREDENTIALS_FN* = ADD_CREDENTIALS_FN_A
    INITIALIZE_SECURITY_CONTEXT_FN* = INITIALIZE_SECURITY_CONTEXT_FN_A
    QUERY_CONTEXT_ATTRIBUTES_FN* = QUERY_CONTEXT_ATTRIBUTES_FN_A
    SET_CONTEXT_ATTRIBUTES_FN* = SET_CONTEXT_ATTRIBUTES_FN_A
    QUERY_CREDENTIALS_ATTRIBUTES_FN* = QUERY_CREDENTIALS_ATTRIBUTES_FN_A
    SET_CREDENTIALS_ATTRIBUTES_FN* = SET_CREDENTIALS_ATTRIBUTES_FN_A
    ENUMERATE_SECURITY_PACKAGES_FN* = ENUMERATE_SECURITY_PACKAGES_FN_A
    QUERY_SECURITY_PACKAGE_INFO_FN* = QUERY_SECURITY_PACKAGE_INFO_FN_A
    IMPORT_SECURITY_CONTEXT_FN* = IMPORT_SECURITY_CONTEXT_FN_A
    SecurityFunctionTable* = SecurityFunctionTableA
    PSecurityFunctionTable* = PSecurityFunctionTableA
    SEC_WINNT_AUTH_IDENTITY* = SEC_WINNT_AUTH_IDENTITY_A
    PSEC_WINNT_AUTH_IDENTITY* = PSEC_WINNT_AUTH_IDENTITY_A
    SEC_WINNT_AUTH_IDENTITY_EX* = SEC_WINNT_AUTH_IDENTITY_EXA
    PSEC_WINNT_AUTH_IDENTITY_EX* = PSEC_WINNT_AUTH_IDENTITY_EXA
  const
    NEGOSSP_NAME* = NEGOSSP_NAME_A
    SECURITY_ENTRYPOINT* = SECURITY_ENTRYPOINTA
    SECURITY_ENTRYPOINT_ANSI* = SECURITY_ENTRYPOINT_ANSIA
  proc AuditLookupSubCategoryName*(pAuditSubCategoryGuid: ptr GUID, ppszSubCategoryName: ptr LPSTR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc: "AuditLookupSubCategoryNameA".}
  proc AuditLookupCategoryName*(pAuditCategoryGuid: ptr GUID, ppszCategoryName: ptr LPSTR): BOOLEAN {.winapi, stdcall, dynlib: "advapi32", importc: "AuditLookupCategoryNameA".}
  proc AcquireCredentialsHandle*(pszPrincipal: ptr SEC_CHAR, pszPackage: ptr SEC_CHAR, fCredentialUse: int32, pvLogonId: pointer, pAuthData: pointer, pGetKeyFn: SEC_GET_KEY_FN, pvGetKeyArgument: pointer, phCredential: PCredHandle, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "AcquireCredentialsHandleA".}
  proc AddCredentials*(hCredentials: PCredHandle, pszPrincipal: ptr SEC_CHAR, pszPackage: ptr SEC_CHAR, fCredentialUse: int32, pAuthData: pointer, pGetKeyFn: SEC_GET_KEY_FN, pvGetKeyArgument: pointer, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "AddCredentialsA".}
  proc InitializeSecurityContext*(phCredential: PCredHandle, phContext: PCtxtHandle, pszTargetName: ptr SEC_CHAR, fContextReq: int32, Reserved1: int32, TargetDataRep: int32, pInput: PSecBufferDesc, Reserved2: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "InitializeSecurityContextA".}
  proc QueryContextAttributes*(phContext: PCtxtHandle, ulAttribute: int32, pBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "QueryContextAttributesA".}
  proc SetContextAttributes*(phContext: PCtxtHandle, ulAttribute: int32, pBuffer: pointer, cbBuffer: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SetContextAttributesA".}
  proc QueryCredentialsAttributes*(phCredential: PCredHandle, ulAttribute: int32, pBuffer: pointer): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "QueryCredentialsAttributesA".}
  proc SetCredentialsAttributes*(phCredential: PCredHandle, ulAttribute: int32, pBuffer: pointer, cbBuffer: int32): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SetCredentialsAttributesA".}
  proc EnumerateSecurityPackages*(pcPackages: ptr int32, ppPackageInfo: ptr PSecPkgInfoA): SECURITY_STATUS {.winapi, stdcall, dynlib: "sspicli", importc: "EnumerateSecurityPackagesA".}
  proc QuerySecurityPackageInfo*(pszPackageName: ptr SEC_CHAR, ppPackageInfo: ptr PSecPkgInfoA): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "QuerySecurityPackageInfoA".}
  proc ImportSecurityContext*(pszPackage: ptr SEC_CHAR, pPackedContext: PSecBuffer, Token: pointer, phContext: PCtxtHandle): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "ImportSecurityContextA".}
  proc InitSecurityInterface*(): PSecurityFunctionTableA {.winapi, stdcall, dynlib: "secur32", importc: "InitSecurityInterfaceA".}
  proc SaslEnumerateProfiles*(ProfileList: ptr LPSTR, ProfileCount: ptr ULONG): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SaslEnumerateProfilesA".}
  proc SaslGetProfilePackage*(ProfileName: LPSTR, PackageInfo: ptr PSecPkgInfoA): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SaslGetProfilePackageA".}
  proc SaslIdentifyPackage*(pInput: PSecBufferDesc, PackageInfo: ptr PSecPkgInfoA): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SaslIdentifyPackageA".}
  proc SaslInitializeSecurityContext*(phCredential: PCredHandle, phContext: PCtxtHandle, pszTargetName: LPSTR, fContextReq: int32, Reserved1: int32, TargetDataRep: int32, pInput: PSecBufferDesc, Reserved2: int32, phNewContext: PCtxtHandle, pOutput: PSecBufferDesc, pfContextAttr: ptr int32, ptsExpiry: PTimeStamp): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "SaslInitializeSecurityContextA".}
  proc AddSecurityPackage*(pszPackageName: LPSTR, pOptions: PSECURITY_PACKAGE_OPTIONS): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "AddSecurityPackageA".}
  proc DeleteSecurityPackage*(pszPackageName: ptr SEC_CHAR): SECURITY_STATUS {.winapi, stdcall, dynlib: "secur32", importc: "DeleteSecurityPackageA".}
  proc GetUserNameEx*(NameFormat: EXTENDED_NAME_FORMAT, lpNameBuffer: LPSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc: "GetUserNameExA".}
  proc GetComputerObjectName*(NameFormat: EXTENDED_NAME_FORMAT, lpNameBuffer: LPSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc: "GetComputerObjectNameA".}
  proc TranslateName*(lpAccountName: LPCSTR, AccountNameFormat: EXTENDED_NAME_FORMAT, DesiredNameFormat: EXTENDED_NAME_FORMAT, lpTranslatedName: LPSTR, nSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "secur32", importc: "TranslateNameA".}
