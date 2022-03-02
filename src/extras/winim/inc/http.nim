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
import wincrypt
#include <http.h>
type
  HTTP_VERB* = int32
  PHTTP_VERB* = ptr int32
  HTTP_HEADER_ID* = int32
  PHTTP_HEADER_ID* = ptr int32
  HTTP_DATA_CHUNK_TYPE* = int32
  PHTTP_DATA_CHUNK_TYPE* = ptr int32
  HTTP_REQUEST_INFO_TYPE* = int32
  PHTTP_REQUEST_INFO_TYPE* = ptr int32
  HTTP_RESPONSE_INFO_TYPE* = int32
  PHTTP_RESPONSE_INFO_TYPE* = ptr int32
  HTTP_CACHE_POLICY_TYPE* = int32
  PHTTP_CACHE_POLICY_TYPE* = ptr int32
  HTTP_SERVICE_CONFIG_ID* = int32
  PHTTP_SERVICE_CONFIG_ID* = ptr int32
  HTTP_SERVICE_CONFIG_QUERY_TYPE* = int32
  PHTTP_SERVICE_CONFIG_QUERY_TYPE* = ptr int32
  HTTP_503_RESPONSE_VERBOSITY* = int32
  PHTTP_503_RESPONSE_VERBOSITY* = ptr int32
  HTTP_ENABLED_STATE* = int32
  PHTTP_ENABLED_STATE* = ptr int32
  HTTP_LOGGING_ROLLOVER_TYPE* = int32
  PHTTP_LOGGING_ROLLOVER_TYPE* = ptr int32
  HTTP_LOGGING_TYPE* = int32
  PHTTP_LOGGING_TYPE* = ptr int32
  HTTP_QOS_SETTING_TYPE* = int32
  PHTTP_QOS_SETTING_TYPE* = ptr int32
  HTTP_SERVER_PROPERTY* = int32
  PHTTP_SERVER_PROPERTY* = ptr int32
  HTTP_AUTHENTICATION_HARDENING_LEVELS* = int32
  HTTP_SERVICE_BINDING_TYPE* = int32
  HTTP_LOG_DATA_TYPE* = int32
  PHTTP_LOG_DATA_TYPE* = ptr int32
  HTTP_REQUEST_AUTH_TYPE* = int32
  PHTTP_REQUEST_AUTH_TYPE* = ptr int32
  HTTP_AUTH_STATUS* = int32
  PHTTP_AUTH_STATUS* = ptr int32
  HTTP_SERVICE_CONFIG_TIMEOUT_KEY* = int32
  PHTTP_SERVICE_CONFIG_TIMEOUT_KEY* = ptr int32
  HTTP_SERVICE_CONFIG_CACHE_KEY* = int32
  HTTP_OPAQUE_ID* = ULONGLONG
  PHTTP_OPAQUE_ID* = ptr ULONGLONG
  HTTP_URL_CONTEXT* = ULONGLONG
  HTTP_SERVICE_CONFIG_TIMEOUT_PARAM* = USHORT
  PHTTP_SERVICE_CONFIG_TIMEOUT_PARAM* = ptr USHORT
  HTTP_SERVICE_CONFIG_CACHE_PARAM* = ULONG
  HTTP_REQUEST_ID* = HTTP_OPAQUE_ID
  PHTTP_REQUEST_ID* = ptr HTTP_OPAQUE_ID
  HTTP_CONNECTION_ID* = HTTP_OPAQUE_ID
  PHTTP_CONNECTION_ID* = ptr HTTP_OPAQUE_ID
  HTTP_RAW_CONNECTION_ID* = HTTP_OPAQUE_ID
  PHTTP_RAW_CONNECTION_ID* = ptr HTTP_OPAQUE_ID
  HTTP_URL_GROUP_ID* = HTTP_OPAQUE_ID
  PHTTP_URL_GROUP_ID* = ptr HTTP_OPAQUE_ID
  HTTP_SERVER_SESSION_ID* = HTTP_OPAQUE_ID
  PHTTP_SERVER_SESSION_ID* = ptr HTTP_OPAQUE_ID
  HTTP_BYTE_RANGE* {.pure.} = object
    StartingOffset*: ULARGE_INTEGER
    Length*: ULARGE_INTEGER
  PHTTP_BYTE_RANGE* = ptr HTTP_BYTE_RANGE
  HTTP_VERSION* {.pure.} = object
    MajorVersion*: USHORT
    MinorVersion*: USHORT
  PHTTP_VERSION* = ptr HTTP_VERSION
  HTTP_KNOWN_HEADER* {.pure.} = object
    RawValueLength*: USHORT
    pRawValue*: PCSTR
  PHTTP_KNOWN_HEADER* = ptr HTTP_KNOWN_HEADER
  HTTP_UNKNOWN_HEADER* {.pure.} = object
    NameLength*: USHORT
    RawValueLength*: USHORT
    pName*: PCSTR
    pRawValue*: PCSTR
  PHTTP_UNKNOWN_HEADER* = ptr HTTP_UNKNOWN_HEADER
  HTTP_DATA_CHUNK_UNION1_FromMemory* {.pure.} = object
    pBuffer*: PVOID
    BufferLength*: ULONG
  HTTP_DATA_CHUNK_UNION1_FromFileHandle* {.pure.} = object
    ByteRange*: HTTP_BYTE_RANGE
    FileHandle*: HANDLE
  HTTP_DATA_CHUNK_UNION1_FromFragmentCache* {.pure.} = object
    FragmentNameLength*: USHORT
    pFragmentName*: PCWSTR
  HTTP_DATA_CHUNK_UNION1* {.pure, union.} = object
    FromMemory*: HTTP_DATA_CHUNK_UNION1_FromMemory
    FromFileHandle*: HTTP_DATA_CHUNK_UNION1_FromFileHandle
    FromFragmentCache*: HTTP_DATA_CHUNK_UNION1_FromFragmentCache
  HTTP_DATA_CHUNK* {.pure.} = object
    DataChunkType*: HTTP_DATA_CHUNK_TYPE
    union1*: HTTP_DATA_CHUNK_UNION1
  PHTTP_DATA_CHUNK* = ptr HTTP_DATA_CHUNK
const
  httpHeaderRequestMaximum* = 41
type
  HTTP_REQUEST_HEADERS* {.pure.} = object
    UnknownHeaderCount*: USHORT
    pUnknownHeaders*: PHTTP_UNKNOWN_HEADER
    TrailerCount*: USHORT
    pTrailers*: PHTTP_UNKNOWN_HEADER
    KnownHeaders*: array[httpHeaderRequestMaximum, HTTP_KNOWN_HEADER]
  PHTTP_REQUEST_HEADERS* = ptr HTTP_REQUEST_HEADERS
const
  httpHeaderResponseMaximum* = 30
type
  HTTP_RESPONSE_HEADERS* {.pure.} = object
    UnknownHeaderCount*: USHORT
    pUnknownHeaders*: PHTTP_UNKNOWN_HEADER
    TrailerCount*: USHORT
    pTrailers*: PHTTP_UNKNOWN_HEADER
    KnownHeaders*: array[httpHeaderResponseMaximum, HTTP_KNOWN_HEADER]
  PHTTP_RESPONSE_HEADERS* = ptr HTTP_RESPONSE_HEADERS
  HTTP_TRANSPORT_ADDRESS* {.pure.} = object
    pRemoteAddress*: PSOCKADDR
    pLocalAddress*: PSOCKADDR
  PHTTP_TRANSPORT_ADDRESS* = ptr HTTP_TRANSPORT_ADDRESS
  HTTP_COOKED_URL* {.pure.} = object
    FullUrlLength*: USHORT
    HostLength*: USHORT
    AbsPathLength*: USHORT
    QueryStringLength*: USHORT
    pFullUrl*: PCWSTR
    pHost*: PCWSTR
    pAbsPath*: PCWSTR
    pQueryString*: PCWSTR
  PHTTP_COOKED_URL* = ptr HTTP_COOKED_URL
  HTTP_SSL_CLIENT_CERT_INFO* {.pure.} = object
    CertFlags*: ULONG
    CertEncodedSize*: ULONG
    pCertEncoded*: PUCHAR
    Token*: HANDLE
    CertDeniedByMapper*: BOOLEAN
  PHTTP_SSL_CLIENT_CERT_INFO* = ptr HTTP_SSL_CLIENT_CERT_INFO
  HTTP_SSL_INFO* {.pure.} = object
    ServerCertKeySize*: USHORT
    ConnectionKeySize*: USHORT
    ServerCertIssuerSize*: ULONG
    ServerCertSubjectSize*: ULONG
    pServerCertIssuer*: PCSTR
    pServerCertSubject*: PCSTR
    pClientCertInfo*: PHTTP_SSL_CLIENT_CERT_INFO
    SslClientCertNegotiated*: ULONG
  PHTTP_SSL_INFO* = ptr HTTP_SSL_INFO
  HTTP_REQUEST_V1* {.pure.} = object
    Flags*: ULONG
    ConnectionId*: HTTP_CONNECTION_ID
    RequestId*: HTTP_REQUEST_ID
    UrlContext*: HTTP_URL_CONTEXT
    Version*: HTTP_VERSION
    Verb*: HTTP_VERB
    UnknownVerbLength*: USHORT
    RawUrlLength*: USHORT
    pUnknownVerb*: PCSTR
    pRawUrl*: PCSTR
    CookedUrl*: HTTP_COOKED_URL
    Address*: HTTP_TRANSPORT_ADDRESS
    Headers*: HTTP_REQUEST_HEADERS
    BytesReceived*: ULONGLONG
    EntityChunkCount*: USHORT
    pEntityChunks*: PHTTP_DATA_CHUNK
    RawConnectionId*: HTTP_RAW_CONNECTION_ID
    pSslInfo*: PHTTP_SSL_INFO
  PHTTP_REQUEST_V1* = ptr HTTP_REQUEST_V1
  HTTP_REQUEST_INFO* {.pure.} = object
    InfoType*: HTTP_REQUEST_INFO_TYPE
    InfoLength*: ULONG
    pInfo*: PVOID
  PHTTP_REQUEST_INFO* = ptr HTTP_REQUEST_INFO
  HTTP_REQUEST_V2_STRUCT1* {.pure.} = object
    Flags*: ULONG
    ConnectionId*: HTTP_CONNECTION_ID
    RequestId*: HTTP_REQUEST_ID
    UrlContext*: HTTP_URL_CONTEXT
    Version*: HTTP_VERSION
    Verb*: HTTP_VERB
    UnknownVerbLength*: USHORT
    RawUrlLength*: USHORT
    pUnknownVerb*: PCSTR
    pRawUrl*: PCSTR
    CookedUrl*: HTTP_COOKED_URL
    Address*: HTTP_TRANSPORT_ADDRESS
    Headers*: HTTP_REQUEST_HEADERS
    BytesReceived*: ULONGLONG
    EntityChunkCount*: USHORT
    pEntityChunks*: PHTTP_DATA_CHUNK
    RawConnectionId*: HTTP_RAW_CONNECTION_ID
    pSslInfo*: PHTTP_SSL_INFO
  HTTP_REQUEST_V2* {.pure.} = object
    struct1*: HTTP_REQUEST_V2_STRUCT1
    RequestInfoCount*: USHORT
    pRequestInfo*: PHTTP_REQUEST_INFO
  PHTTP_REQUEST_V2* = ptr HTTP_REQUEST_V2
  HTTP_REQUEST* = HTTP_REQUEST_V2
  PHTTP_REQUEST* = ptr HTTP_REQUEST_V2
  HTTP_RESPONSE_V1* {.pure.} = object
    Flags*: ULONG
    Version*: HTTP_VERSION
    StatusCode*: USHORT
    ReasonLength*: USHORT
    pReason*: PCSTR
    Headers*: HTTP_RESPONSE_HEADERS
    EntityChunkCount*: USHORT
    pEntityChunks*: PHTTP_DATA_CHUNK
  PHTTP_RESPONSE_V1* = ptr HTTP_RESPONSE_V1
  HTTP_RESPONSE_INFO* {.pure.} = object
    Type*: HTTP_RESPONSE_INFO_TYPE
    Length*: ULONG
    pInfo*: PVOID
  PHTTP_RESPONSE_INFO* = ptr HTTP_RESPONSE_INFO
  HTTP_RESPONSE_V2_STRUCT1* {.pure.} = object
    Flags*: ULONG
    Version*: HTTP_VERSION
    StatusCode*: USHORT
    ReasonLength*: USHORT
    pReason*: PCSTR
    Headers*: HTTP_RESPONSE_HEADERS
    EntityChunkCount*: USHORT
    pEntityChunks*: PHTTP_DATA_CHUNK
  HTTP_RESPONSE_V2* {.pure.} = object
    struct1*: HTTP_RESPONSE_V2_STRUCT1
    ResponseInfoCount*: USHORT
    pResponseInfo*: PHTTP_RESPONSE_INFO
  PHTTP_RESPONSE_V2* = ptr HTTP_RESPONSE_V2
  HTTP_RESPONSE* = HTTP_RESPONSE_V2
  PHTTP_RESPONSE* = ptr HTTP_RESPONSE_V2
  HTTP_CACHE_POLICY* {.pure.} = object
    Policy*: HTTP_CACHE_POLICY_TYPE
    SecondsToLive*: ULONG
  PHTTP_CACHE_POLICY* = ptr HTTP_CACHE_POLICY
  HTTP_SERVICE_CONFIG_SSL_KEY* {.pure.} = object
    pIpPort*: PSOCKADDR
  PHTTP_SERVICE_CONFIG_SSL_KEY* = ptr HTTP_SERVICE_CONFIG_SSL_KEY
  HTTP_SERVICE_CONFIG_SSL_PARAM* {.pure.} = object
    SslHashLength*: ULONG
    pSslHash*: PVOID
    AppId*: GUID
    pSslCertStoreName*: PWSTR
    DefaultCertCheckMode*: DWORD
    DefaultRevocationFreshnessTime*: DWORD
    DefaultRevocationUrlRetrievalTimeout*: DWORD
    pDefaultSslCtlIdentifier*: PWSTR
    pDefaultSslCtlStoreName*: PWSTR
    DefaultFlags*: DWORD
  PHTTP_SERVICE_CONFIG_SSL_PARAM* = ptr HTTP_SERVICE_CONFIG_SSL_PARAM
  HTTP_SERVICE_CONFIG_SSL_SET* {.pure.} = object
    KeyDesc*: HTTP_SERVICE_CONFIG_SSL_KEY
    ParamDesc*: HTTP_SERVICE_CONFIG_SSL_PARAM
  PHTTP_SERVICE_CONFIG_SSL_SET* = ptr HTTP_SERVICE_CONFIG_SSL_SET
  HTTP_SERVICE_CONFIG_SSL_QUERY* {.pure.} = object
    QueryDesc*: HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc*: HTTP_SERVICE_CONFIG_SSL_KEY
    dwToken*: DWORD
  PHTTP_SERVICE_CONFIG_SSL_QUERY* = ptr HTTP_SERVICE_CONFIG_SSL_QUERY
  HTTP_SERVICE_CONFIG_IP_LISTEN_PARAM* {.pure.} = object
    AddrLength*: USHORT
    pAddress*: PSOCKADDR
  PHTTP_SERVICE_CONFIG_IP_LISTEN_PARAM* = ptr HTTP_SERVICE_CONFIG_IP_LISTEN_PARAM
  HTTP_SERVICE_CONFIG_IP_LISTEN_QUERY* {.pure.} = object
    AddrCount*: ULONG
    AddrList*: array[ANYSIZE_ARRAY, SOCKADDR_STORAGE]
  PHTTP_SERVICE_CONFIG_IP_LISTEN_QUERY* = ptr HTTP_SERVICE_CONFIG_IP_LISTEN_QUERY
  HTTP_SERVICE_CONFIG_URLACL_KEY* {.pure.} = object
    pUrlPrefix*: PWSTR
  PHTTP_SERVICE_CONFIG_URLACL_KEY* = ptr HTTP_SERVICE_CONFIG_URLACL_KEY
  HTTP_SERVICE_CONFIG_URLACL_PARAM* {.pure.} = object
    pStringSecurityDescriptor*: PWSTR
  PHTTP_SERVICE_CONFIG_URLACL_PARAM* = ptr HTTP_SERVICE_CONFIG_URLACL_PARAM
  HTTP_SERVICE_CONFIG_URLACL_SET* {.pure.} = object
    KeyDesc*: HTTP_SERVICE_CONFIG_URLACL_KEY
    ParamDesc*: HTTP_SERVICE_CONFIG_URLACL_PARAM
  PHTTP_SERVICE_CONFIG_URLACL_SET* = ptr HTTP_SERVICE_CONFIG_URLACL_SET
  HTTP_SERVICE_CONFIG_URLACL_QUERY* {.pure.} = object
    QueryDesc*: HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc*: HTTP_SERVICE_CONFIG_URLACL_KEY
    dwToken*: DWORD
  PHTTP_SERVICE_CONFIG_URLACL_QUERY* = ptr HTTP_SERVICE_CONFIG_URLACL_QUERY
  HTTPAPI_VERSION* {.pure.} = object
    HttpApiMajorVersion*: USHORT
    HttpApiMinorVersion*: USHORT
  PHTTPAPI_VERSION* = ptr HTTPAPI_VERSION
  HTTP_LOG_DATA* {.pure.} = object
    Type*: HTTP_LOG_DATA_TYPE
  PHTTP_LOG_DATA* = ptr HTTP_LOG_DATA
  HTTP_PROPERTY_FLAGS* {.pure.} = object
    Present* {.bitsize:1.}: ULONG
  PHTTP_PROPERTY_FLAGS* = ptr HTTP_PROPERTY_FLAGS
  HTTP_CONNECTION_LIMIT_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    MaxConnections*: ULONG
  PHTTP_CONNECTION_LIMIT_INFO* = ptr HTTP_CONNECTION_LIMIT_INFO
  HTTP_STATE_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    State*: HTTP_ENABLED_STATE
  PHTTP_STATE_INFO* = ptr HTTP_STATE_INFO
  HTTP_QOS_SETTING_INFO* {.pure.} = object
    QosType*: HTTP_QOS_SETTING_TYPE
    QosSetting*: PVOID
  PHTTP_QOS_SETTING_INFO* = ptr HTTP_QOS_SETTING_INFO
  HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS* {.pure.} = object
    DomainNameLength*: USHORT
    DomainName*: PWSTR
    RealmLength*: USHORT
    Realm*: PWSTR
  PHTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS* = ptr HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS
  HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS* {.pure.} = object
    RealmLength*: USHORT
    Realm*: PWSTR
  PHTTP_SERVER_AUTHENTICATION_BASIC_PARAMS* = ptr HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS
  HTTP_SERVER_AUTHENTICATION_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    AuthSchemes*: ULONG
    ReceiveMutualAuth*: BOOLEAN
    ReceiveContextHandle*: BOOLEAN
    DisableNTLMCredentialCaching*: BOOLEAN
    ExFlags*: UCHAR
    DigestParams*: HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS
    BasicParams*: HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS
  PHTTP_SERVER_AUTHENTICATION_INFO* = ptr HTTP_SERVER_AUTHENTICATION_INFO
  HTTP_LOGGING_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    LoggingFlags*: ULONG
    SoftwareName*: PCWSTR
    SoftwareNameLength*: USHORT
    DirectoryNameLength*: USHORT
    DirectoryName*: PCWSTR
    Format*: HTTP_LOGGING_TYPE
    Fields*: ULONG
    pExtFields*: PVOID
    NumOfExtFields*: USHORT
    MaxRecordSize*: USHORT
    RolloverType*: HTTP_LOGGING_ROLLOVER_TYPE
    RolloverSize*: ULONG
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
  PHTTP_LOGGING_INFO* = ptr HTTP_LOGGING_INFO
  HTTP_TIMEOUT_LIMIT_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    EntityBody*: USHORT
    DrainEntityBody*: USHORT
    RequestQueue*: USHORT
    IdleConnection*: USHORT
    HeaderWait*: USHORT
    MinSendRate*: ULONG
  PHTTP_TIMEOUT_LIMIT_INFO* = ptr HTTP_TIMEOUT_LIMIT_INFO
  HTTP_SERVICE_BINDING_BASE* {.pure.} = object
    Type*: HTTP_SERVICE_BINDING_TYPE
  PHTTP_SERVICE_BINDING_BASE* = ptr HTTP_SERVICE_BINDING_BASE
  HTTP_CHANNEL_BIND_INFO* {.pure.} = object
    Hardening*: HTTP_AUTHENTICATION_HARDENING_LEVELS
    Flags*: ULONG
    ServiceNames*: ptr PHTTP_SERVICE_BINDING_BASE
    NumberOfServiceNames*: ULONG
  PHTTP_CHANNEL_BIND_INFO* = ptr HTTP_CHANNEL_BIND_INFO
  HTTP_REQUEST_CHANNEL_BIND_STATUS* {.pure.} = object
    ServiceName*: PHTTP_SERVICE_BINDING_BASE
    ChannelToken*: PUCHAR
    ChannelTokenSize*: ULONG
    Flags*: ULONG
  PHTTP_REQUEST_CHANNEL_BIND_STATUS* = ptr HTTP_REQUEST_CHANNEL_BIND_STATUS
  HTTP_SERVICE_BINDING_A* {.pure.} = object
    Base*: HTTP_SERVICE_BINDING_BASE
    Buffer*: PCHAR
    BufferSize*: ULONG
  PHTTP_SERVICE_BINDING_A* = ptr HTTP_SERVICE_BINDING_A
  HTTP_SERVICE_BINDING_W* {.pure.} = object
    Base*: HTTP_SERVICE_BINDING_BASE
    Buffer*: PWCHAR
    BufferSize*: ULONG
  PHTTP_SERVICE_BINDING_W* = ptr HTTP_SERVICE_BINDING_W
  HTTP_LOG_FIELDS_DATA* {.pure.} = object
    Base*: HTTP_LOG_DATA
    UserNameLength*: USHORT
    UriStemLength*: USHORT
    ClientIpLength*: USHORT
    ServerNameLength*: USHORT
    ServerIpLength*: USHORT
    MethodLength*: USHORT
    UriQueryLength*: USHORT
    HostLength*: USHORT
    UserAgentLength*: USHORT
    CookieLength*: USHORT
    ReferrerLength*: USHORT
    UserName*: PWCHAR
    UriStem*: PWCHAR
    ClientIp*: PCHAR
    ServerName*: PCHAR
    ServiceName*: PCHAR
    ServerIp*: PCHAR
    Method*: PCHAR
    UriQuery*: PCHAR
    Host*: PCHAR
    UserAgent*: PCHAR
    Cookie*: PCHAR
    Referrer*: PCHAR
    ServerPort*: USHORT
    ProtocolStatus*: USHORT
    Win32Status*: ULONG
    MethodNum*: HTTP_VERB
    SubStatus*: USHORT
  PHTTP_LOG_FIELDS_DATA* = ptr HTTP_LOG_FIELDS_DATA
  HTTP_REQUEST_AUTH_INFO* {.pure.} = object
    AuthStatus*: HTTP_AUTH_STATUS
    SecStatus*: SECURITY_STATUS
    Flags*: ULONG
    AuthType*: HTTP_REQUEST_AUTH_TYPE
    AccessToken*: HANDLE
    ContextAttributes*: ULONG
    PackedContextLength*: ULONG
    PackedContextType*: ULONG
    PackedContext*: PVOID
    MutualAuthDataLength*: ULONG
    pMutualAuthData*: PCHAR
  PHTTP_REQUEST_AUTH_INFO* = ptr HTTP_REQUEST_AUTH_INFO
  HTTP_MULTIPLE_KNOWN_HEADERS* {.pure.} = object
    HeaderId*: HTTP_HEADER_ID
    Flags*: ULONG
    KnownHeaderCount*: USHORT
    KnownHeaders*: PHTTP_KNOWN_HEADER
  PHTTP_MULTIPLE_KNOWN_HEADERS* = ptr HTTP_MULTIPLE_KNOWN_HEADERS
  HTTP_SERVICE_CONFIG_TIMEOUT_SET* {.pure.} = object
    KeyDesc*: HTTP_SERVICE_CONFIG_TIMEOUT_KEY
    ParamDesc*: HTTP_SERVICE_CONFIG_TIMEOUT_PARAM
  PHTTP_SERVICE_CONFIG_TIMEOUT_SET* = ptr HTTP_SERVICE_CONFIG_TIMEOUT_SET
  HTTP_BANDWIDTH_LIMIT_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    MaxBandwidth*: ULONG
  PHTTP_BANDWIDTH_LIMIT_INFO* = ptr HTTP_BANDWIDTH_LIMIT_INFO
  HTTP_BINDING_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    RequestQueueHandle*: HANDLE
  PHTTP_BINDING_INFO* = ptr HTTP_BINDING_INFO
  HTTP_LISTEN_ENDPOINT_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    EnableSharing*: BOOLEAN
  PHTTP_LISTEN_ENDPOINT_INFO* = ptr HTTP_LISTEN_ENDPOINT_INFO
  HTTP_FLOWRATE_INFO* {.pure.} = object
    Flags*: HTTP_PROPERTY_FLAGS
    MaxBandwidth*: ULONG
    MaxPeakBandwidth*: ULONG
    BurstSize*: ULONG
  PHTTP_FLOWRATE_INFO* = ptr HTTP_FLOWRATE_INFO
  HTTP_SERVICE_CONFIG_CACHE_SET* {.pure.} = object
    KeyDesc*: HTTP_SERVICE_CONFIG_CACHE_KEY
    ParamDesc*: HTTP_SERVICE_CONFIG_CACHE_PARAM
  PHTTP_SERVICE_CONFIG_CACHE_SET* = ptr HTTP_SERVICE_CONFIG_CACHE_SET
const
  HTTP_INITIALIZE_SERVER* = 0x00000001
  HTTP_INITIALIZE_CONFIG* = 0x00000002
  HTTP_RECEIVE_REQUEST_FLAG_COPY_BODY* = 0x00000001
  HTTP_RECEIVE_REQUEST_ENTITY_BODY_FLAG_FILL_BUFFER* = 0x00000001
  HTTP_SEND_RESPONSE_FLAG_DISCONNECT* = 0x00000001
  HTTP_SEND_RESPONSE_FLAG_MORE_DATA* = 0x00000002
  HTTP_SEND_RESPONSE_FLAG_BUFFER_DATA* = 0x00000004
  HTTP_FLUSH_RESPONSE_FLAG_RECURSIVE* = 0x00000001
  HTTP_NULL_ID* = 0
  HTTP_VERSION_UNKNOWN* = [0'u8,0]
  HTTP_VERSION_0_9* = [0'u8,9]
  HTTP_VERSION_1_0* = [1'u8,0]
  HTTP_VERSION_1_1* = [1'u8,1]
  httpVerbUnparsed* = 0
  httpVerbUnknown* = 1
  httpVerbInvalid* = 2
  httpVerbOPTIONS* = 3
  httpVerbGET* = 4
  httpVerbHEAD* = 5
  httpVerbPOST* = 6
  httpVerbPUT* = 7
  httpVerbDELETE* = 8
  httpVerbTRACE* = 9
  httpVerbCONNECT* = 10
  httpVerbTRACK* = 11
  httpVerbMOVE* = 12
  httpVerbCOPY* = 13
  httpVerbPROPFIND* = 14
  httpVerbPROPPATCH* = 15
  httpVerbMKCOL* = 16
  httpVerbLOCK* = 17
  httpVerbUNLOCK* = 18
  httpVerbSEARCH* = 19
  httpVerbMaximum* = 20
  httpHeaderCacheControl* = 0
  httpHeaderConnection* = 1
  httpHeaderDate* = 2
  httpHeaderKeepAlive* = 3
  httpHeaderPragma* = 4
  httpHeaderTrailer* = 5
  httpHeaderTransferEncoding* = 6
  httpHeaderUpgrade* = 7
  httpHeaderVia* = 8
  httpHeaderWarning* = 9
  httpHeaderAllow* = 10
  httpHeaderContentLength* = 11
  httpHeaderContentType* = 12
  httpHeaderContentEncoding* = 13
  httpHeaderContentLanguage* = 14
  httpHeaderContentLocation* = 15
  httpHeaderContentMd5* = 16
  httpHeaderContentRange* = 17
  httpHeaderExpires* = 18
  httpHeaderLastModified* = 19
  httpHeaderAccept* = 20
  httpHeaderAcceptCharset* = 21
  httpHeaderAcceptEncoding* = 22
  httpHeaderAcceptLanguage* = 23
  httpHeaderAuthorization* = 24
  httpHeaderCookie* = 25
  httpHeaderExpect* = 26
  httpHeaderFrom* = 27
  httpHeaderHost* = 28
  httpHeaderIfMatch* = 29
  httpHeaderIfModifiedSince* = 30
  httpHeaderIfNoneMatch* = 31
  httpHeaderIfRange* = 32
  httpHeaderIfUnmodifiedSince* = 33
  httpHeaderMaxForwards* = 34
  httpHeaderProxyAuthorization* = 35
  httpHeaderReferer* = 36
  httpHeaderRange* = 37
  httpHeaderTe* = 38
  httpHeaderTranslate* = 39
  httpHeaderUserAgent* = 40
  httpHeaderAcceptRanges* = 20
  httpHeaderAge* = 21
  httpHeaderEtag* = 22
  httpHeaderLocation* = 23
  httpHeaderProxyAuthenticate* = 24
  httpHeaderRetryAfter* = 25
  httpHeaderServer* = 26
  httpHeaderSetCookie* = 27
  httpHeaderVary* = 28
  httpHeaderWwwAuthenticate* = 29
  httpHeaderMaximum* = 41
  httpDataChunkFromMemory* = 0
  httpDataChunkFromFileHandle* = 1
  httpDataChunkFromFragmentCache* = 2
  httpDataChunkFromFragmentCacheEx* = 3
  httpDataChunkMaximum* = 4
  httpRequestInfoTypeAuth* = 0
  HTTP_REQUEST_FLAG_MORE_ENTITY_BODY_EXISTS* = 0x00000001
  httpResponseInfoTypeMultipleKnownHeaders* = 0
  httpResponseInfoTypeAuthenticationProperty* = 1
  httpResponseInfoTypeQosProperty* = 2
  httpResponseInfoTypeChannelBind* = 3
  httpCachePolicyNocache* = 0
  httpCachePolicyUserInvalidates* = 1
  httpCachePolicyTimeToLive* = 2
  httpCachePolicyMaximum* = 3
  httpServiceConfigIPListenList* = 0
  httpServiceConfigSSLCertInfo* = 1
  httpServiceConfigUrlAclInfo* = 2
  httpServiceConfigMax* = 3
  httpServiceConfigQueryExact* = 0
  httpServiceConfigQueryNext* = 1
  httpServiceConfigQueryMax* = 2
  HTTP_SERVICE_CONFIG_SSL_FLAG_USE_DS_MAPPER* = 0x00000001
  HTTP_SERVICE_CONFIG_SSL_FLAG_NEGOTIATE_CLIENT_CERT* = 0x00000002
  HTTP_SERVICE_CONFIG_SSL_FLAG_NO_RAW_FILTER* = 0x00000004
  http503ResponseVerbosityBasic* = 0
  http503ResponseVerbosityLimited* = 1
  http503ResponseVerbosityFull* = 2
  httpEnabledStateActive* = 0
  httpEnabledStateInactive* = 1
  httpLoggingRolloverSize* = 0
  httpLoggingRolloverDaily* = 1
  httpLoggingRolloverWeekly* = 2
  httpLoggingRolloverMonthly* = 3
  httpLoggingRolloverHourly* = 4
  httpLoggingTypeW3C* = 0
  httpLoggingTypeIIS* = 1
  httpLoggingTypeNCSA* = 2
  httpLoggingTypeRaw* = 3
  httpQosSettingTypeBandwidth* = 0
  httpQosSettingTypeConnectionLimit* = 1
  httpQosSettingTypeFlowRate* = 2
  httpServerAuthenticationProperty* = 0
  httpServerLoggingProperty* = 1
  httpServerQosProperty* = 2
  httpServerTimeoutsProperty* = 3
  httpServerQueueLengthProperty* = 4
  httpServerStateProperty* = 5
  httpServer503VerbosityProperty* = 6
  httpServerBindingProperty* = 7
  httpServerExtendedAuthenticationProperty* = 8
  httpServerListenEndpointProperty* = 9
  httpServerChannelBindProperty* = 10
  httpAuthenticationHardeningLegacy* = 0
  httpAuthenticationHardeningMedium* = 1
  httpAuthenticationHardeningStrict* = 2
  httpServiceBindingTypeNone* = 0
  httpServiceBindingTypeW* = 1
  httpServiceBindingTypeA* = 2
  httpLogDataTypeFields* = 0
  httpRequestAuthTypeNone* = 0
  httpRequestAuthTypeBasic* = 1
  httpRequestAuthTypeDigest* = 2
  httpRequestAuthTypeNTLM* = 3
  httpRequestAuthTypeNegotiate* = 4
  httpRequestAuthTypeKerberos* = 5
  httpAuthStatusSuccess* = 0
  httpAuthStatusNotAuthenticated* = 1
  httpAuthStatusFailure* = 2
  idleConnectionTimeout* = 0
  headerWaitTimeout* = 1
  maxCacheResponseSize* = 0
  cacheRangeChunkSize* = 1
  HTTP_BYTE_RANGE_TO_EOF* = not ULONGLONG(0)
proc HttpInitialize*(Version: HTTPAPI_VERSION, Flags: ULONG, pReserved: PVOID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpTerminate*(Flags: ULONG, pReserved: PVOID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpCreateHttpHandle*(pReqQueueHandle: PHANDLE, Options: ULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpReceiveClientCertificate*(ReqQueueHandle: HANDLE, ConnectionId: HTTP_CONNECTION_ID, Flags: ULONG, pSslClientCertInfo: PHTTP_SSL_CLIENT_CERT_INFO, SslClientCertInfoSize: ULONG, pBytesReceived: PULONG, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpAddUrl*(ReqQueueHandle: HANDLE, pUrlPrefix: PCWSTR, pReserved: PVOID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpRemoveUrl*(ReqQueueHandle: HANDLE, pUrlPrefix: PCWSTR): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpReceiveHttpRequest*(ReqQueueHandle: HANDLE, RequestId: HTTP_REQUEST_ID, Flags: ULONG, pRequestBuffer: PHTTP_REQUEST, RequestBufferLength: ULONG, pBytesReceived: PULONG, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpReceiveRequestEntityBody*(ReqQueueHandle: HANDLE, RequestId: HTTP_REQUEST_ID, Flags: ULONG, pBuffer: PVOID, BufferLength: ULONG, pBytesReceived: PULONG, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpSendHttpResponse*(ReqQueueHandle: HANDLE, RequestId: HTTP_REQUEST_ID, Flags: ULONG, pHttpResponse: PHTTP_RESPONSE, pReserved1: PVOID, pBytesSent: PULONG, pReserved2: PVOID, Reserved3: ULONG, pOverlapped: LPOVERLAPPED, pReserved4: PVOID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpSendResponseEntityBody*(ReqQueueHandle: HANDLE, RequestId: HTTP_REQUEST_ID, Flags: ULONG, EntityChunkCount: USHORT, pEntityChunks: PHTTP_DATA_CHUNK, pBytesSent: PULONG, pReserved1: PVOID, Reserved2: ULONG, pOverlapped: LPOVERLAPPED, pReserved3: PVOID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpWaitForDisconnect*(ReqQueueHandle: HANDLE, ConnectionId: HTTP_CONNECTION_ID, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpFlushResponseCache*(ReqQueueHandle: HANDLE, pUrlPrefix: PCWSTR, Flags: ULONG, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpAddFragmentToCache*(ReqQueueHandle: HANDLE, pUrlPrefix: PCWSTR, pDataChunk: PHTTP_DATA_CHUNK, pCachePolicy: PHTTP_CACHE_POLICY, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpReadFragmentFromCache*(ReqQueueHandle: HANDLE, pUrlPrefix: PCWSTR, pByteRange: PHTTP_BYTE_RANGE, pBuffer: PVOID, BufferLength: ULONG, pBytesRead: PULONG, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpSetServiceConfiguration*(ServiceHandle: HANDLE, ConfigId: HTTP_SERVICE_CONFIG_ID, pConfigInformation: PVOID, ConfigInformationLength: ULONG, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpDeleteServiceConfiguration*(ServiceHandle: HANDLE, ConfigId: HTTP_SERVICE_CONFIG_ID, pConfigInformation: PVOID, ConfigInformationLength: ULONG, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpQueryServiceConfiguration*(ServiceHandle: HANDLE, ConfigId: HTTP_SERVICE_CONFIG_ID, pInputConfigInformation: PVOID, InputConfigInformationLength: ULONG, pOutputConfigInformation: PVOID, OutputConfigInformationLength: ULONG, pReturnLength: PULONG, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpSetRequestQueueProperty*(Handle: HANDLE, Property: HTTP_SERVER_PROPERTY, pPropertyInformation: PVOID, PropertyInformationLength: ULONG, Reserved: ULONG, pReserved: PVOID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpQueryRequestQueueProperty*(Handle: HANDLE, Property: HTTP_SERVER_PROPERTY, pPropertyInformation: PVOID, PropertyInformationLength: ULONG, Reserved: ULONG, pReturnLength: PULONG, pReserved: PVOID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpCreateRequestQueue*(Version: HTTPAPI_VERSION, pName: PCWSTR, pSecurityAttributes: PSECURITY_ATTRIBUTES, Flags: ULONG, pReqQueueHandle: PHANDLE): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpAddUrlToUrlGroup*(UrlGroupId: HTTP_URL_GROUP_ID, pFullyQualifiedUrl: PCWSTR, UrlContext: HTTP_URL_CONTEXT, Reserved: ULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpCancelHttpRequest*(ReqQueueHandle: HANDLE, RequestId: HTTP_REQUEST_ID, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpCloseRequestQueue*(ReqQueueHandle: HANDLE): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpCloseServerSession*(ServerSessionId: HTTP_SERVER_SESSION_ID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpCloseUrlGroup*(UrlGroupId: HTTP_URL_GROUP_ID): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpCreateServerSession*(Version: HTTPAPI_VERSION, pServerSessionId: PHTTP_SERVER_SESSION_ID, Reserved: ULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpCreateUrlGroup*(ServerSessionId: HTTP_SERVER_SESSION_ID, pUrlGroupId: PHTTP_URL_GROUP_ID, Reserved: ULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpQueryServerSessionProperty*(ServerSessionId: HTTP_SERVER_SESSION_ID, Property: HTTP_SERVER_PROPERTY, pPropertyInformation: PVOID, PropertyInformationLength: ULONG, pReturnLength: PULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpQueryUrlGroupProperty*(UrlGroupId: HTTP_URL_GROUP_ID, Property: HTTP_SERVER_PROPERTY, pPropertyInformation: PVOID, PropertyInformationLength: ULONG, pReturnLength: PULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpRemoveUrlFromUrlGroup*(UrlGroupId: HTTP_URL_GROUP_ID, pFullyQualifiedUrl: PCWSTR, Flags: ULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpSetServerSessionProperty*(ServerSessionId: HTTP_SERVER_SESSION_ID, Property: HTTP_SERVER_PROPERTY, pPropertyInformation: PVOID, PropertyInformationLength: ULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpSetUrlGroupProperty*(UrlGroupId: HTTP_URL_GROUP_ID, Property: HTTP_SERVER_PROPERTY, pPropertyInformation: PVOID, PropertyInformationLength: ULONG): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpShutdownRequestQueue*(ReqQueueHandle: HANDLE): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc HttpWaitForDemandStart*(ReqQueueHandle: HANDLE, pOverlapped: LPOVERLAPPED): ULONG {.winapi, stdcall, dynlib: "httpapi", importc.}
proc `FromMemory=`*(self: var HTTP_DATA_CHUNK, x: HTTP_DATA_CHUNK_UNION1_FromMemory) {.inline.} = self.union1.FromMemory = x
proc FromMemory*(self: HTTP_DATA_CHUNK): HTTP_DATA_CHUNK_UNION1_FromMemory {.inline.} = self.union1.FromMemory
proc FromMemory*(self: var HTTP_DATA_CHUNK): var HTTP_DATA_CHUNK_UNION1_FromMemory {.inline.} = self.union1.FromMemory
proc `FromFileHandle=`*(self: var HTTP_DATA_CHUNK, x: HTTP_DATA_CHUNK_UNION1_FromFileHandle) {.inline.} = self.union1.FromFileHandle = x
proc FromFileHandle*(self: HTTP_DATA_CHUNK): HTTP_DATA_CHUNK_UNION1_FromFileHandle {.inline.} = self.union1.FromFileHandle
proc FromFileHandle*(self: var HTTP_DATA_CHUNK): var HTTP_DATA_CHUNK_UNION1_FromFileHandle {.inline.} = self.union1.FromFileHandle
proc `FromFragmentCache=`*(self: var HTTP_DATA_CHUNK, x: HTTP_DATA_CHUNK_UNION1_FromFragmentCache) {.inline.} = self.union1.FromFragmentCache = x
proc FromFragmentCache*(self: HTTP_DATA_CHUNK): HTTP_DATA_CHUNK_UNION1_FromFragmentCache {.inline.} = self.union1.FromFragmentCache
proc FromFragmentCache*(self: var HTTP_DATA_CHUNK): var HTTP_DATA_CHUNK_UNION1_FromFragmentCache {.inline.} = self.union1.FromFragmentCache
proc `Flags=`*(self: var HTTP_REQUEST_V2, x: ULONG) {.inline.} = self.struct1.Flags = x
proc Flags*(self: HTTP_REQUEST_V2): ULONG {.inline.} = self.struct1.Flags
proc Flags*(self: var HTTP_REQUEST_V2): var ULONG {.inline.} = self.struct1.Flags
proc `ConnectionId=`*(self: var HTTP_REQUEST_V2, x: HTTP_CONNECTION_ID) {.inline.} = self.struct1.ConnectionId = x
proc ConnectionId*(self: HTTP_REQUEST_V2): HTTP_CONNECTION_ID {.inline.} = self.struct1.ConnectionId
proc ConnectionId*(self: var HTTP_REQUEST_V2): var HTTP_CONNECTION_ID {.inline.} = self.struct1.ConnectionId
proc `RequestId=`*(self: var HTTP_REQUEST_V2, x: HTTP_REQUEST_ID) {.inline.} = self.struct1.RequestId = x
proc RequestId*(self: HTTP_REQUEST_V2): HTTP_REQUEST_ID {.inline.} = self.struct1.RequestId
proc RequestId*(self: var HTTP_REQUEST_V2): var HTTP_REQUEST_ID {.inline.} = self.struct1.RequestId
proc `UrlContext=`*(self: var HTTP_REQUEST_V2, x: HTTP_URL_CONTEXT) {.inline.} = self.struct1.UrlContext = x
proc UrlContext*(self: HTTP_REQUEST_V2): HTTP_URL_CONTEXT {.inline.} = self.struct1.UrlContext
proc UrlContext*(self: var HTTP_REQUEST_V2): var HTTP_URL_CONTEXT {.inline.} = self.struct1.UrlContext
proc `Version=`*(self: var HTTP_REQUEST_V2, x: HTTP_VERSION) {.inline.} = self.struct1.Version = x
proc Version*(self: HTTP_REQUEST_V2): HTTP_VERSION {.inline.} = self.struct1.Version
proc Version*(self: var HTTP_REQUEST_V2): var HTTP_VERSION {.inline.} = self.struct1.Version
proc `Verb=`*(self: var HTTP_REQUEST_V2, x: HTTP_VERB) {.inline.} = self.struct1.Verb = x
proc Verb*(self: HTTP_REQUEST_V2): HTTP_VERB {.inline.} = self.struct1.Verb
proc Verb*(self: var HTTP_REQUEST_V2): var HTTP_VERB {.inline.} = self.struct1.Verb
proc `UnknownVerbLength=`*(self: var HTTP_REQUEST_V2, x: USHORT) {.inline.} = self.struct1.UnknownVerbLength = x
proc UnknownVerbLength*(self: HTTP_REQUEST_V2): USHORT {.inline.} = self.struct1.UnknownVerbLength
proc UnknownVerbLength*(self: var HTTP_REQUEST_V2): var USHORT {.inline.} = self.struct1.UnknownVerbLength
proc `RawUrlLength=`*(self: var HTTP_REQUEST_V2, x: USHORT) {.inline.} = self.struct1.RawUrlLength = x
proc RawUrlLength*(self: HTTP_REQUEST_V2): USHORT {.inline.} = self.struct1.RawUrlLength
proc RawUrlLength*(self: var HTTP_REQUEST_V2): var USHORT {.inline.} = self.struct1.RawUrlLength
proc `pUnknownVerb=`*(self: var HTTP_REQUEST_V2, x: PCSTR) {.inline.} = self.struct1.pUnknownVerb = x
proc pUnknownVerb*(self: HTTP_REQUEST_V2): PCSTR {.inline.} = self.struct1.pUnknownVerb
proc pUnknownVerb*(self: var HTTP_REQUEST_V2): var PCSTR {.inline.} = self.struct1.pUnknownVerb
proc `pRawUrl=`*(self: var HTTP_REQUEST_V2, x: PCSTR) {.inline.} = self.struct1.pRawUrl = x
proc pRawUrl*(self: HTTP_REQUEST_V2): PCSTR {.inline.} = self.struct1.pRawUrl
proc pRawUrl*(self: var HTTP_REQUEST_V2): var PCSTR {.inline.} = self.struct1.pRawUrl
proc `CookedUrl=`*(self: var HTTP_REQUEST_V2, x: HTTP_COOKED_URL) {.inline.} = self.struct1.CookedUrl = x
proc CookedUrl*(self: HTTP_REQUEST_V2): HTTP_COOKED_URL {.inline.} = self.struct1.CookedUrl
proc CookedUrl*(self: var HTTP_REQUEST_V2): var HTTP_COOKED_URL {.inline.} = self.struct1.CookedUrl
proc `Address=`*(self: var HTTP_REQUEST_V2, x: HTTP_TRANSPORT_ADDRESS) {.inline.} = self.struct1.Address = x
proc Address*(self: HTTP_REQUEST_V2): HTTP_TRANSPORT_ADDRESS {.inline.} = self.struct1.Address
proc Address*(self: var HTTP_REQUEST_V2): var HTTP_TRANSPORT_ADDRESS {.inline.} = self.struct1.Address
proc `Headers=`*(self: var HTTP_REQUEST_V2, x: HTTP_REQUEST_HEADERS) {.inline.} = self.struct1.Headers = x
proc Headers*(self: HTTP_REQUEST_V2): HTTP_REQUEST_HEADERS {.inline.} = self.struct1.Headers
proc Headers*(self: var HTTP_REQUEST_V2): var HTTP_REQUEST_HEADERS {.inline.} = self.struct1.Headers
proc `BytesReceived=`*(self: var HTTP_REQUEST_V2, x: ULONGLONG) {.inline.} = self.struct1.BytesReceived = x
proc BytesReceived*(self: HTTP_REQUEST_V2): ULONGLONG {.inline.} = self.struct1.BytesReceived
proc BytesReceived*(self: var HTTP_REQUEST_V2): var ULONGLONG {.inline.} = self.struct1.BytesReceived
proc `EntityChunkCount=`*(self: var HTTP_REQUEST_V2, x: USHORT) {.inline.} = self.struct1.EntityChunkCount = x
proc EntityChunkCount*(self: HTTP_REQUEST_V2): USHORT {.inline.} = self.struct1.EntityChunkCount
proc EntityChunkCount*(self: var HTTP_REQUEST_V2): var USHORT {.inline.} = self.struct1.EntityChunkCount
proc `pEntityChunks=`*(self: var HTTP_REQUEST_V2, x: PHTTP_DATA_CHUNK) {.inline.} = self.struct1.pEntityChunks = x
proc pEntityChunks*(self: HTTP_REQUEST_V2): PHTTP_DATA_CHUNK {.inline.} = self.struct1.pEntityChunks
proc pEntityChunks*(self: var HTTP_REQUEST_V2): var PHTTP_DATA_CHUNK {.inline.} = self.struct1.pEntityChunks
proc `RawConnectionId=`*(self: var HTTP_REQUEST_V2, x: HTTP_RAW_CONNECTION_ID) {.inline.} = self.struct1.RawConnectionId = x
proc RawConnectionId*(self: HTTP_REQUEST_V2): HTTP_RAW_CONNECTION_ID {.inline.} = self.struct1.RawConnectionId
proc RawConnectionId*(self: var HTTP_REQUEST_V2): var HTTP_RAW_CONNECTION_ID {.inline.} = self.struct1.RawConnectionId
proc `pSslInfo=`*(self: var HTTP_REQUEST_V2, x: PHTTP_SSL_INFO) {.inline.} = self.struct1.pSslInfo = x
proc pSslInfo*(self: HTTP_REQUEST_V2): PHTTP_SSL_INFO {.inline.} = self.struct1.pSslInfo
proc pSslInfo*(self: var HTTP_REQUEST_V2): var PHTTP_SSL_INFO {.inline.} = self.struct1.pSslInfo
proc `Flags=`*(self: var HTTP_RESPONSE_V2, x: ULONG) {.inline.} = self.struct1.Flags = x
proc Flags*(self: HTTP_RESPONSE_V2): ULONG {.inline.} = self.struct1.Flags
proc Flags*(self: var HTTP_RESPONSE_V2): var ULONG {.inline.} = self.struct1.Flags
proc `Version=`*(self: var HTTP_RESPONSE_V2, x: HTTP_VERSION) {.inline.} = self.struct1.Version = x
proc Version*(self: HTTP_RESPONSE_V2): HTTP_VERSION {.inline.} = self.struct1.Version
proc Version*(self: var HTTP_RESPONSE_V2): var HTTP_VERSION {.inline.} = self.struct1.Version
proc `StatusCode=`*(self: var HTTP_RESPONSE_V2, x: USHORT) {.inline.} = self.struct1.StatusCode = x
proc StatusCode*(self: HTTP_RESPONSE_V2): USHORT {.inline.} = self.struct1.StatusCode
proc StatusCode*(self: var HTTP_RESPONSE_V2): var USHORT {.inline.} = self.struct1.StatusCode
proc `ReasonLength=`*(self: var HTTP_RESPONSE_V2, x: USHORT) {.inline.} = self.struct1.ReasonLength = x
proc ReasonLength*(self: HTTP_RESPONSE_V2): USHORT {.inline.} = self.struct1.ReasonLength
proc ReasonLength*(self: var HTTP_RESPONSE_V2): var USHORT {.inline.} = self.struct1.ReasonLength
proc `pReason=`*(self: var HTTP_RESPONSE_V2, x: PCSTR) {.inline.} = self.struct1.pReason = x
proc pReason*(self: HTTP_RESPONSE_V2): PCSTR {.inline.} = self.struct1.pReason
proc pReason*(self: var HTTP_RESPONSE_V2): var PCSTR {.inline.} = self.struct1.pReason
proc `Headers=`*(self: var HTTP_RESPONSE_V2, x: HTTP_RESPONSE_HEADERS) {.inline.} = self.struct1.Headers = x
proc Headers*(self: HTTP_RESPONSE_V2): HTTP_RESPONSE_HEADERS {.inline.} = self.struct1.Headers
proc Headers*(self: var HTTP_RESPONSE_V2): var HTTP_RESPONSE_HEADERS {.inline.} = self.struct1.Headers
proc `EntityChunkCount=`*(self: var HTTP_RESPONSE_V2, x: USHORT) {.inline.} = self.struct1.EntityChunkCount = x
proc EntityChunkCount*(self: HTTP_RESPONSE_V2): USHORT {.inline.} = self.struct1.EntityChunkCount
proc EntityChunkCount*(self: var HTTP_RESPONSE_V2): var USHORT {.inline.} = self.struct1.EntityChunkCount
proc `pEntityChunks=`*(self: var HTTP_RESPONSE_V2, x: PHTTP_DATA_CHUNK) {.inline.} = self.struct1.pEntityChunks = x
proc pEntityChunks*(self: HTTP_RESPONSE_V2): PHTTP_DATA_CHUNK {.inline.} = self.struct1.pEntityChunks
proc pEntityChunks*(self: var HTTP_RESPONSE_V2): var PHTTP_DATA_CHUNK {.inline.} = self.struct1.pEntityChunks
