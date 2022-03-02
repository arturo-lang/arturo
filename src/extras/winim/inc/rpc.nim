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
import wincrypt
import security
import objbase
#include <rpcndr.h>
#include <rpcnsip.h>
#include <rpc.h>
#include <rpcdce.h>
#include <rpcdcep.h>
#include <rpcnsi.h>
#include <rpcnterr.h>
#include <rpcasync.h>
#include <rpcproxy.h>
#include <rpcssl.h>
type
  cs_byte* = uint8
  boolean* = uint8
  wchar_t* = uint16
  NDR_CCONTEXT* = pointer
  error_status_t* = int32
  RPC_BUFPTR* = ptr uint8
  RPC_LENGTH* = int32
  PFORMAT_STRING* = ptr uint8
  USER_MARSHAL_CB_TYPE* = int32
  IDL_CS_CONVERT* = int32
  PMIDL_XMIT_TYPE* = pointer
  PARAM_OFFSETTABLE* = ptr uint16
  PPARAM_OFFSETTABLE* = ptr uint16
  XLAT_SIDE* = int32
  STUB_PHASE* = int32
  PROXY_PHASE* = int32
  RPC_SS_THREAD_HANDLE* = pointer
  RPC_CSTR* = ptr uint8
  RPC_WSTR* = ptr uint16
  RPC_HTTP_REDIRECTOR_STAGE* = int32
  RPC_ADDRESS_CHANGE_TYPE* = int32
  I_RPC_MUTEX* = pointer
  RPC_NS_HANDLE* = pointer
  RPC_NOTIFICATION_TYPES* = int32
  RPC_ASYNC_EVENT* = int32
  ExtendedErrorParamTypes* = int32
  RpcCallType* = int32
  RpcLocalAddressFormat* = int32
  RPC_NOTIFICATIONS* = int32
  RpcCallClientLocality* = int32
  PCInterfaceName* = ptr char
  RPC_STATUS* = int32
  MIDL_uhyper* = int64
when winimCpu64:
  type
    size_t* = int64
    ssize_t* = int64
when winimCpu32:
  type
    size_t* = int32
    ssize_t* = int32
type
  I_RPC_HANDLE* = HANDLE
  RPC_IF_HANDLE* = HANDLE
  RPC_BINDING_HANDLE* = I_RPC_HANDLE
  RPC_BINDING_VECTOR* {.pure.} = object
    Count*: int32
    BindingH*: array[1, RPC_BINDING_HANDLE]
  RPC_IMPORT_CONTEXT_P* {.pure.} = object
    LookupContext*: RPC_NS_HANDLE
    ProposedHandle*: RPC_BINDING_HANDLE
    Bindings*: ptr RPC_BINDING_VECTOR
  PRPC_IMPORT_CONTEXT_P* = ptr RPC_IMPORT_CONTEXT_P
  NDR_SCONTEXT* {.pure.} = ref object
    pad*: array[2, pointer]
    userContext*: pointer
  SCONTEXT_QUEUE* {.pure.} = object
    NumberOfObjects*: int32
    ArrayOfObjects*: ptr NDR_SCONTEXT
  PSCONTEXT_QUEUE* = ptr SCONTEXT_QUEUE
  ARRAY_INFO* {.pure.} = object
    Dimension*: int32
    BufferConformanceMark*: ptr int32
    BufferVarianceMark*: ptr int32
    MaxCountArray*: ptr int32
    OffsetArray*: ptr int32
    ActualCountArray*: ptr int32
  PARRAY_INFO* = ptr ARRAY_INFO
  NDR_ASYNC_MESSAGE* {.pure.} = object
  PNDR_ASYNC_MESSAGE* = ptr NDR_ASYNC_MESSAGE
  NDR_CORRELATION_INFO* {.pure.} = object
  PNDR_CORRELATION_INFO* = ptr NDR_CORRELATION_INFO
  RPC_VERSION* {.pure.} = object
    MajorVersion*: uint16
    MinorVersion*: uint16
  RPC_SYNTAX_IDENTIFIER* {.pure.} = object
    SyntaxGUID*: GUID
    SyntaxVersion*: RPC_VERSION
  PRPC_SYNTAX_IDENTIFIER* = ptr RPC_SYNTAX_IDENTIFIER
  RPC_MGR_EPV* {.pure.} = object
  RPC_MESSAGE* {.pure.} = object
    Handle*: RPC_BINDING_HANDLE
    DataRepresentation*: int32
    Buffer*: pointer
    BufferLength*: int32
    ProcNum*: int32
    TransferSyntax*: PRPC_SYNTAX_IDENTIFIER
    RpcInterfaceInformation*: pointer
    ReservedForRuntime*: pointer
    ManagerEpv*: ptr RPC_MGR_EPV
    ImportContext*: pointer
    RpcFlags*: int32
  PRPC_MESSAGE* = ptr RPC_MESSAGE
  RPC_DISPATCH_FUNCTION* = proc (Message: PRPC_MESSAGE): void {.stdcall.}
  RPC_DISPATCH_TABLE* {.pure.} = object
    DispatchTableCount*: int32
    DispatchTable*: ptr RPC_DISPATCH_FUNCTION
    Reserved*: LONG_PTR
  MIDL_SYNTAX_INFO* {.pure.} = object
    TransferSyntax*: RPC_SYNTAX_IDENTIFIER
    DispatchTable*: ptr RPC_DISPATCH_TABLE
    ProcString*: PFORMAT_STRING
    FmtStringOffset*: ptr uint16
    TypeString*: PFORMAT_STRING
    aUserMarshalQuadruple*: pointer
    pReserved1*: ULONG_PTR
    pReserved2*: ULONG_PTR
  PMIDL_SYNTAX_INFO* = ptr MIDL_SYNTAX_INFO
  NDR_ALLOC_ALL_NODES_CONTEXT* {.pure.} = object
  NDR_POINTER_QUEUE_STATE* {.pure.} = object
  handle_t* = RPC_BINDING_HANDLE
  GENERIC_BINDING_ROUTINE* = proc (P1: pointer): pointer {.stdcall.}
  GENERIC_UNBIND_ROUTINE* = proc (P1: pointer, P2: ptr uint8): void {.stdcall.}
  GENERIC_BINDING_INFO* {.pure.} = object
    pObj*: pointer
    Size*: int32
    pfnBind*: GENERIC_BINDING_ROUTINE
    pfnUnbind*: GENERIC_UNBIND_ROUTINE
  PGENERIC_BINDING_INFO* = ptr GENERIC_BINDING_INFO
  MIDL_STUB_DESC_IMPLICIT_HANDLE_INFO* {.pure, union.} = object
    pAutoHandle*: ptr handle_t
    pPrimitiveHandle*: ptr handle_t
    pGenericBindingInfo*: PGENERIC_BINDING_INFO
  NDR_RUNDOWN* = proc (context: pointer): void {.stdcall.}
  GENERIC_BINDING_ROUTINE_PAIR* {.pure.} = object
    pfnBind*: GENERIC_BINDING_ROUTINE
    pfnUnbind*: GENERIC_UNBIND_ROUTINE
  EXPR_EVAL* = proc (P1: ptr MIDL_STUB_MESSAGE): void {.stdcall.}
  XMIT_HELPER_ROUTINE* = proc (P1: PMIDL_STUB_MESSAGE): void {.stdcall.}
  XMIT_ROUTINE_QUINTUPLE* {.pure.} = object
    pfnTranslateToXmit*: XMIT_HELPER_ROUTINE
    pfnTranslateFromXmit*: XMIT_HELPER_ROUTINE
    pfnFreeXmit*: XMIT_HELPER_ROUTINE
    pfnFreeInst*: XMIT_HELPER_ROUTINE
  MALLOC_FREE_STRUCT* {.pure.} = object
    pfnAllocate*: proc(P1: int): pointer {.stdcall.}
    pfnFree*: proc(P1: pointer): void {.stdcall.}
  COMM_FAULT_OFFSETS* {.pure.} = object
    CommOffset*: int16
    FaultOffset*: int16
  USER_MARSHAL_SIZING_ROUTINE* = proc (P1: ptr ULONG, P2: ULONG, P3: pointer): ULONG {.stdcall.}
  USER_MARSHAL_MARSHALLING_ROUTINE* = proc (P1: ptr ULONG, P2: ptr uint8, P3: pointer): ptr uint8 {.stdcall.}
  USER_MARSHAL_UNMARSHALLING_ROUTINE* = proc (P1: ptr ULONG, P2: ptr uint8, P3: pointer): ptr uint8 {.stdcall.}
  USER_MARSHAL_FREEING_ROUTINE* = proc (P1: ptr ULONG, P2: pointer): void {.stdcall.}
  USER_MARSHAL_ROUTINE_QUADRUPLE* {.pure.} = object
    pfnBufferSize*: USER_MARSHAL_SIZING_ROUTINE
    pfnMarshall*: USER_MARSHAL_MARSHALLING_ROUTINE
    pfnUnmarshall*: USER_MARSHAL_UNMARSHALLING_ROUTINE
    pfnFree*: USER_MARSHAL_FREEING_ROUTINE
  NDR_NOTIFY_ROUTINE* = proc (): void {.stdcall.}
  CS_TYPE_NET_SIZE_ROUTINE* = proc (hBinding: RPC_BINDING_HANDLE, ulNetworkCodeSet: int32, ulLocalBufferSize: int32, conversionType: ptr IDL_CS_CONVERT, pulNetworkBufferSize: ptr int32, pStatus: ptr error_status_t): void {.stdcall.}
  CS_TYPE_TO_NETCS_ROUTINE* = proc (hBinding: RPC_BINDING_HANDLE, ulNetworkCodeSet: int32, pLocalData: pointer, ulLocalDataLength: int32, pNetworkData: ptr uint8, pulNetworkDataLength: ptr int32, pStatus: ptr error_status_t): void {.stdcall.}
  CS_TYPE_LOCAL_SIZE_ROUTINE* = proc (hBinding: RPC_BINDING_HANDLE, ulNetworkCodeSet: int32, ulNetworkBufferSize: int32, conversionType: ptr IDL_CS_CONVERT, pulLocalBufferSize: ptr int32, pStatus: ptr error_status_t): void {.stdcall.}
  CS_TYPE_FROM_NETCS_ROUTINE* = proc (hBinding: RPC_BINDING_HANDLE, ulNetworkCodeSet: int32, pNetworkData: ptr uint8, ulNetworkDataLength: int32, ulLocalBufferSize: int32, pLocalData: pointer, pulLocalDataLength: ptr int32, pStatus: ptr error_status_t): void {.stdcall.}
  NDR_CS_SIZE_CONVERT_ROUTINES* {.pure.} = object
    pfnNetSize*: CS_TYPE_NET_SIZE_ROUTINE
    pfnToNetCs*: CS_TYPE_TO_NETCS_ROUTINE
    pfnLocalSize*: CS_TYPE_LOCAL_SIZE_ROUTINE
    pfnFromNetCs*: CS_TYPE_FROM_NETCS_ROUTINE
  CS_TAG_GETTING_ROUTINE* = proc (hBinding: RPC_BINDING_HANDLE, fServerSide: int32, pulSendingTag: ptr int32, pulDesiredReceivingTag: ptr int32, pulReceivingTag: ptr int32, pStatus: ptr error_status_t): void {.stdcall.}
  NDR_CS_ROUTINES* {.pure.} = object
    pSizeConvertRoutines*: ptr NDR_CS_SIZE_CONVERT_ROUTINES
    pTagGettingRoutines*: ptr CS_TAG_GETTING_ROUTINE
  MIDL_STUB_DESC* {.pure.} = object
    RpcInterfaceInformation*: pointer
    pfnAllocate*: proc(P1: int): pointer {.stdcall.}
    pfnFree*: proc(P1: pointer): void {.stdcall.}
    IMPLICIT_HANDLE_INFO*: MIDL_STUB_DESC_IMPLICIT_HANDLE_INFO
    apfnNdrRundownRoutines*: ptr NDR_RUNDOWN
    aGenericBindingRoutinePairs*: ptr GENERIC_BINDING_ROUTINE_PAIR
    apfnExprEval*: ptr EXPR_EVAL
    aXmitQuintuple*: ptr XMIT_ROUTINE_QUINTUPLE
    pFormatTypes*: ptr uint8
    fCheckBounds*: int32
    Version*: int32
    pMallocFreeStruct*: ptr MALLOC_FREE_STRUCT
    MIDLVersion*: int32
    CommFaultOffsets*: ptr COMM_FAULT_OFFSETS
    aUserMarshalQuadruple*: ptr USER_MARSHAL_ROUTINE_QUADRUPLE
    NotifyRoutineTable*: ptr NDR_NOTIFY_ROUTINE
    mFlags*: ULONG_PTR
    CsRoutineTables*: ptr NDR_CS_ROUTINES
    Reserved4*: pointer
    Reserved5*: ULONG_PTR
  FULL_PTR_XLAT_TABLES_RefIdToPointer* {.pure.} = object
    XlatTable*: ptr pointer
    StateTable*: ptr uint8
    NumberOfEntries*: int32
  FULL_PTR_TO_REFID_ELEMENT* {.pure.} = object
    Next*: ptr FULL_PTR_TO_REFID_ELEMENT
    Pointer*: pointer
    RefId*: int32
    State*: uint8
  PFULL_PTR_TO_REFID_ELEMENT* = ptr FULL_PTR_TO_REFID_ELEMENT
  FULL_PTR_XLAT_TABLES_PointerToRefId* {.pure.} = object
    XlatTable*: ptr PFULL_PTR_TO_REFID_ELEMENT
    NumberOfBuckets*: int32
    HashMask*: int32
  FULL_PTR_XLAT_TABLES* {.pure.} = object
    RefIdToPointer*: FULL_PTR_XLAT_TABLES_RefIdToPointer
    PointerToRefId*: FULL_PTR_XLAT_TABLES_PointerToRefId
    NextRefId*: int32
    XlatSide*: XLAT_SIDE
  CS_STUB_INFO* {.pure.} = object
    WireCodeset*: int32
    DesiredReceivingCodeset*: int32
    CSArrayInfo*: pointer
  NDR_PROC_CONTEXT* {.pure.} = object
  MIDL_STUB_MESSAGE* {.pure.} = object
    RpcMsg*: PRPC_MESSAGE
    Buffer*: ptr uint8
    BufferStart*: ptr uint8
    BufferEnd*: ptr uint8
    BufferMark*: ptr uint8
    BufferLength*: int32
    MemorySize*: int32
    Memory*: ptr uint8
    IsClient*: uint8
    Pad*: uint8
    uFlags2*: uint16
    ReuseBuffer*: int32
    pAllocAllNodesContext*: ptr NDR_ALLOC_ALL_NODES_CONTEXT
    pPointerQueueState*: ptr NDR_POINTER_QUEUE_STATE
    IgnoreEmbeddedPointers*: int32
    PointerBufferMark*: ptr uint8
    fBufferValid*: uint8
    uFlags*: uint8
    UniquePtrCount*: uint16
    MaxCount*: ULONG_PTR
    Offset*: int32
    ActualCount*: int32
    pfnAllocate*: proc(P1: int): pointer {.stdcall.}
    pfnFree*: proc(P1: pointer): void {.stdcall.}
    StackTop*: ptr uint8
    pPresentedType*: ptr uint8
    pTransmitType*: ptr uint8
    SavedHandle*: handle_t
    StubDesc*: ptr MIDL_STUB_DESC
    FullPtrXlatTables*: ptr FULL_PTR_XLAT_TABLES
    FullPtrRefId*: int32
    PointerLength*: int32
    fInDontFree* {.bitsize:1.}: int32
    fDontCallFreeInst* {.bitsize:1.}: int32
    fInOnlyParam* {.bitsize:1.}: int32
    fHasReturn* {.bitsize:1.}: int32
    fHasExtensions* {.bitsize:1.}: int32
    fHasNewCorrDesc* {.bitsize:1.}: int32
    fIsOicfServer* {.bitsize:1.}: int32
    fHasMemoryValidateCallback* {.bitsize:1.}: int32
    fUnused* {.bitsize:8.}: int32
    fUnused2* {.bitsize:16.}: int32
    dwDestContext*: int32
    pvDestContext*: pointer
    SavedContextHandles*: ptr NDR_SCONTEXT
    ParamNumber*: int32
    pRpcChannelBuffer*: ptr IRpcChannelBuffer
    pArrayInfo*: PARRAY_INFO
    SizePtrCountArray*: ptr int32
    SizePtrOffsetArray*: ptr int32
    SizePtrLengthArray*: ptr int32
    pArgQueue*: pointer
    dwStubPhase*: int32
    LowStackMark*: pointer
    pAsyncMsg*: PNDR_ASYNC_MESSAGE
    pCorrInfo*: PNDR_CORRELATION_INFO
    pCorrMemory*: ptr uint8
    pMemoryList*: pointer
    pCSInfo*: ptr CS_STUB_INFO
    ConformanceMark*: ptr uint8
    VarianceMark*: ptr uint8
    BackingStoreLowMark*: pointer
    pContext*: ptr NDR_PROC_CONTEXT
    pUserMarshalList*: pointer
    Reserved51_2*: INT_PTR
    Reserved51_3*: INT_PTR
    Reserved51_4*: INT_PTR
    Reserved51_5*: INT_PTR
  PMIDL_STUB_MESSAGE* = ptr MIDL_STUB_MESSAGE
  PGENERIC_BINDING_ROUTINE_PAIR* = ptr GENERIC_BINDING_ROUTINE_PAIR
  PXMIT_ROUTINE_QUINTUPLE* = ptr XMIT_ROUTINE_QUINTUPLE
  PMIDL_STUB_DESC* = ptr MIDL_STUB_DESC
  SERVER_ROUTINE* = proc (): int32 {.stdcall.}
  STUB_THUNK* = proc (P1: PMIDL_STUB_MESSAGE): void {.stdcall.}
  MIDL_SERVER_INFO* {.pure.} = object
    pStubDesc*: PMIDL_STUB_DESC
    DispatchTable*: ptr SERVER_ROUTINE
    ProcString*: PFORMAT_STRING
    FmtStringOffset*: ptr uint16
    ThunkTable*: ptr STUB_THUNK
    pTransferSyntax*: PRPC_SYNTAX_IDENTIFIER
    nCount*: ULONG_PTR
    pSyntaxInfo*: PMIDL_SYNTAX_INFO
  PMIDL_SERVER_INFO* = ptr MIDL_SERVER_INFO
  MIDL_STUBLESS_PROXY_INFO* {.pure.} = object
    pStubDesc*: PMIDL_STUB_DESC
    ProcFormatString*: PFORMAT_STRING
    FormatStringOffset*: ptr uint16
    pTransferSyntax*: PRPC_SYNTAX_IDENTIFIER
    nCount*: ULONG_PTR
    pSyntaxInfo*: PMIDL_SYNTAX_INFO
  PMIDL_STUBLESS_PROXY_INFO* = ptr MIDL_STUBLESS_PROXY_INFO
  PFULL_PTR_XLAT_TABLES* = ptr FULL_PTR_XLAT_TABLES
  rpc_binding_handle_t* = RPC_BINDING_HANDLE
  UUID* = GUID
  uuid_t* = UUID
  rpc_binding_vector_t* = RPC_BINDING_VECTOR
  UUID_VECTOR* {.pure.} = object
    Count*: int32
    Uuid*: array[1, ptr UUID]
  uuid_vector_t* = UUID_VECTOR
  RPC_POLICY* {.pure.} = object
    Length*: int32
    EndpointFlags*: int32
    NICFlags*: int32
  PRPC_POLICY* = ptr RPC_POLICY
  RPC_SECURITY_QOS* {.pure.} = object
    Version*: int32
    Capabilities*: int32
    IdentityTracking*: int32
    ImpersonationType*: int32
  PRPC_SECURITY_QOS* = ptr RPC_SECURITY_QOS
  RPC_HTTP_TRANSPORT_CREDENTIALS_W* {.pure.} = object
    TransportCredentials*: ptr SEC_WINNT_AUTH_IDENTITY_W
    Flags*: int32
    AuthenticationTarget*: int32
    NumberOfAuthnSchemes*: int32
    AuthnSchemes*: ptr int32
    ServerCertificateSubject*: ptr uint16
  PRPC_HTTP_TRANSPORT_CREDENTIALS_W* = ptr RPC_HTTP_TRANSPORT_CREDENTIALS_W
  RPC_HTTP_TRANSPORT_CREDENTIALS_A* {.pure.} = object
    TransportCredentials*: ptr SEC_WINNT_AUTH_IDENTITY_A
    Flags*: int32
    AuthenticationTarget*: int32
    NumberOfAuthnSchemes*: int32
    AuthnSchemes*: ptr int32
    ServerCertificateSubject*: ptr uint8
  PRPC_HTTP_TRANSPORT_CREDENTIALS_A* = ptr RPC_HTTP_TRANSPORT_CREDENTIALS_A
  RPC_SECURITY_QOS_V2_W_u* {.pure, union.} = object
    HttpCredentials*: ptr RPC_HTTP_TRANSPORT_CREDENTIALS_W
  RPC_SECURITY_QOS_V2_W* {.pure.} = object
    Version*: int32
    Capabilities*: int32
    IdentityTracking*: int32
    ImpersonationType*: int32
    AdditionalSecurityInfoType*: int32
    u*: RPC_SECURITY_QOS_V2_W_u
  PRPC_SECURITY_QOS_V2_W* = ptr RPC_SECURITY_QOS_V2_W
  RPC_SECURITY_QOS_V2_A_u* {.pure, union.} = object
    HttpCredentials*: ptr RPC_HTTP_TRANSPORT_CREDENTIALS_A
  RPC_SECURITY_QOS_V2_A* {.pure.} = object
    Version*: int32
    Capabilities*: int32
    IdentityTracking*: int32
    ImpersonationType*: int32
    AdditionalSecurityInfoType*: int32
    u*: RPC_SECURITY_QOS_V2_A_u
  PRPC_SECURITY_QOS_V2_A* = ptr RPC_SECURITY_QOS_V2_A
  RPC_SECURITY_QOS_V3_W_u* {.pure, union.} = object
    HttpCredentials*: ptr RPC_HTTP_TRANSPORT_CREDENTIALS_W
  RPC_SECURITY_QOS_V3_W* {.pure.} = object
    Version*: int32
    Capabilities*: int32
    IdentityTracking*: int32
    ImpersonationType*: int32
    AdditionalSecurityInfoType*: int32
    u*: RPC_SECURITY_QOS_V3_W_u
    Sid*: pointer
  PRPC_SECURITY_QOS_V3_W* = ptr RPC_SECURITY_QOS_V3_W
  RPC_SECURITY_QOS_V3_A_u* {.pure, union.} = object
    HttpCredentials*: ptr RPC_HTTP_TRANSPORT_CREDENTIALS_A
  RPC_SECURITY_QOS_V3_A* {.pure.} = object
    Version*: int32
    Capabilities*: int32
    IdentityTracking*: int32
    ImpersonationType*: int32
    AdditionalSecurityInfoType*: int32
    u*: RPC_SECURITY_QOS_V3_A_u
    Sid*: pointer
  PRPC_SECURITY_QOS_V3_A* = ptr RPC_SECURITY_QOS_V3_A
  RPC_CLIENT_INFORMATION1* {.pure.} = object
    UserName*: ptr uint8
    ComputerName*: ptr uint8
    Privilege*: uint16
    AuthFlags*: int32
  PRPC_CLIENT_INFORMATION1* = ptr RPC_CLIENT_INFORMATION1
  RPC_EP_INQ_HANDLE* = ptr I_RPC_HANDLE
  RPC_BINDING_HANDLE_OPTIONS_V1* {.pure.} = object
    Version*: int32
    Flags*: int32
    ComTimeout*: int32
    CallTimeout*: int32
  RPC_BINDING_HANDLE_OPTIONS* = RPC_BINDING_HANDLE_OPTIONS_V1
  RPC_BINDING_HANDLE_SECURITY_V1* {.pure.} = object
    Version*: int32
    ServerPrincName*: ptr uint16
    AuthnLevel*: int32
    AuthnSvc*: int32
    AuthIdentity*: ptr SEC_WINNT_AUTH_IDENTITY
    SecurityQos*: ptr RPC_SECURITY_QOS
  RPC_BINDING_HANDLE_SECURITY* = RPC_BINDING_HANDLE_SECURITY_V1
  RPC_BINDING_HANDLE_TEMPLATE_V1_u1* {.pure, union.} = object
    Reserved*: ptr uint16
  RPC_BINDING_HANDLE_TEMPLATE_V1* {.pure.} = object
    Version*: int32
    Flags*: int32
    ProtocolSequence*: int32
    NetworkAddress*: ptr uint16
    StringEndpoint*: ptr uint16
    u1*: RPC_BINDING_HANDLE_TEMPLATE_V1_u1
    ObjectUuid*: UUID
  RPC_BINDING_HANDLE_TEMPLATE* = RPC_BINDING_HANDLE_TEMPLATE_V1
  PRPC_DISPATCH_TABLE* = ptr RPC_DISPATCH_TABLE
  RPC_PROTSEQ_ENDPOINT* {.pure.} = object
    RpcProtocolSequence*: ptr uint8
    Endpoint*: ptr uint8
  PRPC_PROTSEQ_ENDPOINT* = ptr RPC_PROTSEQ_ENDPOINT
  RPC_SERVER_INTERFACE* {.pure.} = object
    Length*: int32
    InterfaceId*: RPC_SYNTAX_IDENTIFIER
    TransferSyntax*: RPC_SYNTAX_IDENTIFIER
    DispatchTable*: PRPC_DISPATCH_TABLE
    RpcProtseqEndpointCount*: int32
    RpcProtseqEndpoint*: PRPC_PROTSEQ_ENDPOINT
    DefaultManagerEpv*: ptr RPC_MGR_EPV
    InterpreterInfo*: pointer
    Flags*: int32
  PRPC_SERVER_INTERFACE* = ptr RPC_SERVER_INTERFACE
  RPC_CLIENT_INTERFACE* {.pure.} = object
    Length*: int32
    InterfaceId*: RPC_SYNTAX_IDENTIFIER
    TransferSyntax*: RPC_SYNTAX_IDENTIFIER
    DispatchTable*: PRPC_DISPATCH_TABLE
    RpcProtseqEndpointCount*: int32
    RpcProtseqEndpoint*: PRPC_PROTSEQ_ENDPOINT
    Reserved*: ULONG_PTR
    InterpreterInfo*: pointer
    Flags*: int32
  PRPC_CLIENT_INTERFACE* = ptr RPC_CLIENT_INTERFACE
  PFN_RPCNOTIFICATION_ROUTINE* = proc (pAsync: ptr RPC_ASYNC_STATE, Context: pointer, Event: RPC_ASYNC_EVENT): void {.stdcall.}
  RPC_ASYNC_STATE_u_APC* {.pure.} = object
    NotificationRoutine*: PFN_RPCNOTIFICATION_ROUTINE
    hThread*: HANDLE
  RPC_ASYNC_STATE_u_IOC* {.pure.} = object
    hIOPort*: HANDLE
    dwNumberOfBytesTransferred*: DWORD
    dwCompletionKey*: DWORD_PTR
    lpOverlapped*: LPOVERLAPPED
  RPC_ASYNC_STATE_u_HWND* {.pure.} = object
    hWnd*: HWND
    Msg*: UINT
  RPC_ASYNC_STATE_u* {.pure, union.} = object
    APC*: RPC_ASYNC_STATE_u_APC
    IOC*: RPC_ASYNC_STATE_u_IOC
    HWND*: RPC_ASYNC_STATE_u_HWND
    hEvent*: HANDLE
    NotificationRoutine*: PFN_RPCNOTIFICATION_ROUTINE
  RPC_ASYNC_STATE* {.pure.} = object
    Size*: int32
    Signature*: int32
    Lock*: int32
    Flags*: int32
    StubInfo*: pointer
    UserInfo*: pointer
    RuntimeInfo*: pointer
    Event*: RPC_ASYNC_EVENT
    NotificationType*: RPC_NOTIFICATION_TYPES
    u*: RPC_ASYNC_STATE_u
    Reserved*: array[4, LONG_PTR]
  PRPC_ASYNC_STATE* = ptr RPC_ASYNC_STATE
  RPC_CALL_ATTRIBUTES_V1_W* {.pure.} = object
    Version*: int32
    Flags*: int32
    ServerPrincipalNameBufferLength*: int32
    ServerPrincipalName*: ptr uint16
    ClientPrincipalNameBufferLength*: int32
    ClientPrincipalName*: ptr uint16
    AuthenticationLevel*: int32
    AuthenticationService*: int32
    NullSession*: WINBOOL
when winimUnicode:
  type
    RPC_CALL_ATTRIBUTES_V1* = RPC_CALL_ATTRIBUTES_V1_W
type
  RPC_CALL_ATTRIBUTES_V1_A* {.pure.} = object
    Version*: int32
    Flags*: int32
    ServerPrincipalNameBufferLength*: int32
    ServerPrincipalName*: ptr uint8
    ClientPrincipalNameBufferLength*: int32
    ClientPrincipalName*: ptr uint8
    AuthenticationLevel*: int32
    AuthenticationService*: int32
    NullSession*: WINBOOL
when winimAnsi:
  type
    RPC_CALL_ATTRIBUTES_V1* = RPC_CALL_ATTRIBUTES_V1_A
type
  RPC_CALL_ATTRIBUTES* = RPC_CALL_ATTRIBUTES_V1
  RPC_ASYNC_NOTIFICATION_INFO_APC* {.pure.} = object
    NotificationRoutine*: PFN_RPCNOTIFICATION_ROUTINE
    hThread*: HANDLE
  RPC_ASYNC_NOTIFICATION_INFO_IOC* {.pure.} = object
    hIOPort*: HANDLE
    dwNumberOfBytesTransferred*: DWORD
    dwCompletionKey*: DWORD_PTR
    lpOverlapped*: LPOVERLAPPED
  RPC_ASYNC_NOTIFICATION_INFO_HWND* {.pure.} = object
    hWnd*: HWND
    Msg*: UINT
  RPC_ASYNC_NOTIFICATION_INFO* {.pure, union.} = object
    APC*: RPC_ASYNC_NOTIFICATION_INFO_APC
    IOC*: RPC_ASYNC_NOTIFICATION_INFO_IOC
    HWND*: RPC_ASYNC_NOTIFICATION_INFO_HWND
    hEvent*: HANDLE
    NotificationRoutine*: PFN_RPCNOTIFICATION_ROUTINE
  PRPC_ASYNC_NOTIFICATION_INFO* = ptr RPC_ASYNC_NOTIFICATION_INFO
  RPC_CALL_LOCAL_ADDRESS_V1_A* {.pure.} = object
    Version*: int32
    Buffer*: pointer
    BufferSize*: int32
    AddressFormat*: RpcLocalAddressFormat
  RPC_CALL_LOCAL_ADDRESS_A* = RPC_CALL_LOCAL_ADDRESS_V1_A
  RPC_CALL_LOCAL_ADDRESS_V1_W* {.pure.} = object
    Version*: int32
    Buffer*: pointer
    BufferSize*: int32
    AddressFormat*: RpcLocalAddressFormat
  RPC_CALL_LOCAL_ADDRESS_W* = RPC_CALL_LOCAL_ADDRESS_V1_W
  RPC_CALL_ATTRIBUTES_V2_A* {.pure.} = object
    Version*: int32
    Flags*: int32
    ServerPrincipalNameBufferLength*: int32
    ServerPrincipalName*: ptr uint16
    ClientPrincipalNameBufferLength*: int32
    ClientPrincipalName*: ptr uint16
    AuthenticationLevel*: int32
    AuthenticationService*: int32
    NullSession*: WINBOOL
    KernelMode*: WINBOOL
    ProtocolSequence*: int32
    IsClientLocal*: RpcCallClientLocality
    ClientPID*: HANDLE
    CallStatus*: int32
    CallType*: RpcCallType
    CallLocalAddress*: ptr RPC_CALL_LOCAL_ADDRESS_A
    OpNum*: uint16
    InterfaceUuid*: UUID
  RPC_CALL_ATTRIBUTES_A* = RPC_CALL_ATTRIBUTES_V2_A
  RPC_CALL_ATTRIBUTES_V2_W* {.pure.} = object
    Version*: int32
    Flags*: int32
    ServerPrincipalNameBufferLength*: int32
    ServerPrincipalName*: ptr uint16
    ClientPrincipalNameBufferLength*: int32
    ClientPrincipalName*: ptr uint16
    AuthenticationLevel*: int32
    AuthenticationService*: int32
    NullSession*: WINBOOL
    KernelMode*: WINBOOL
    ProtocolSequence*: int32
    IsClientLocal*: RpcCallClientLocality
    ClientPID*: HANDLE
    CallStatus*: int32
    CallType*: RpcCallType
    CallLocalAddress*: ptr RPC_CALL_LOCAL_ADDRESS_W
    OpNum*: uint16
    InterfaceUuid*: UUID
  RPC_CALL_ATTRIBUTES_W* = RPC_CALL_ATTRIBUTES_V2_W
  PRPC_STUB_FUNCTION* = proc (This: ptr IRpcStubBuffer, pRpcChannelBuffer: ptr IRpcChannelBuffer, pRpcMessage: PRPC_MESSAGE, pdwStubPhase: ptr DWORD): void {.stdcall.}
  CInterfaceStubHeader* {.pure.} = object
    piid*: ptr IID
    pServerInfo*: ptr MIDL_SERVER_INFO
    DispatchTableCount*: int32
    pDispatchTable*: ptr PRPC_STUB_FUNCTION
  CInterfaceStubVtbl* {.pure.} = object
    header*: CInterfaceStubHeader
    Vtbl*: IRpcStubBufferVtbl
  PCInterfaceStubVtblList* = ptr CInterfaceStubVtbl
  CInterfaceProxyHeader* {.pure.} = object
    pStublessProxyInfo*: pointer
    piid*: ptr IID
  CInterfaceProxyVtbl* {.pure.} = object
    header*: CInterfaceProxyHeader
    Vtbl*: UncheckedArray[pointer]
  PCInterfaceProxyVtblList* = ptr CInterfaceProxyVtbl
  IIDLookupRtn* = proc (pIID: ptr IID, pIndex: ptr int32): int32 {.stdcall.}
  PIIDLookup* = IIDLookupRtn
  ProxyFileInfo* {.pure.} = object
    pProxyVtblList*: ptr PCInterfaceProxyVtblList
    pStubVtblList*: ptr PCInterfaceStubVtblList
    pNamesArray*: ptr PCInterfaceName
    pDelegatedIIDs*: ptr ptr IID
    pIIDLookupRtn*: PIIDLookup
    TableSize*: uint16
    TableVersion*: uint16
    pAsyncIIDLookup*: ptr ptr IID
    Filler2*: LONG_PTR
    Filler3*: LONG_PTR
    Filler4*: LONG_PTR
  ExtendedProxyFileInfo* = ProxyFileInfo
const
  RPCNDR_H_VERSION* = 475
  NDR_CHAR_REP_MASK* = 0X0000000F
  NDR_INT_REP_MASK* = 0X000000F0
  NDR_FLOAT_REP_MASK* = 0X0000FF00
  NDR_LITTLE_ENDIAN* = 0X00000010
  NDR_BIG_ENDIAN* = 0X00000000
  NDR_IEEE_FLOAT* = 0X00000000
  NDR_VAX_FLOAT* = 0X00000100
  NDR_IBM_FLOAT* = 0X00000300
  NDR_ASCII_CHAR* = 0X00000000
  NDR_EBCDIC_CHAR* = 0X00000001
  NDR_LOCAL_DATA_REPRESENTATION* = 0X00000010
  NDR_LOCAL_ENDIAN* = NDR_LITTLE_ENDIAN
  cbNDRContext* = 20
  USER_MARSHAL_CB_SIGNATURE* = 0x55535243
  USER_MARSHAL_CB_BUFFER_SIZE* = 0
  USER_MARSHAL_CB_MARSHALL* = 1
  USER_MARSHAL_CB_UNMARSHALL* = 2
  USER_MARSHAL_CB_FREE* = 3
  USER_CALL_IS_ASYNC* = 0x0100
  USER_CALL_NEW_CORRELATION_DESC* = 0x0200
  IDL_CS_NO_CONVERT* = 0
  IDL_CS_IN_PLACE_CONVERT* = 1
  IDL_CS_NEW_BUFFER_CONVERT* = 2
  XLAT_SERVER* = 1
  XLAT_CLIENT* = 2
  USER_MARSHAL_FC_BYTE* = 1
  USER_MARSHAL_FC_CHAR* = 2
  USER_MARSHAL_FC_SMALL* = 3
  USER_MARSHAL_FC_USMALL* = 4
  USER_MARSHAL_FC_WCHAR* = 5
  USER_MARSHAL_FC_SHORT* = 6
  USER_MARSHAL_FC_USHORT* = 7
  USER_MARSHAL_FC_LONG* = 8
  USER_MARSHAL_FC_ULONG* = 9
  USER_MARSHAL_FC_FLOAT* = 10
  USER_MARSHAL_FC_HYPER* = 11
  USER_MARSHAL_FC_DOUBLE* = 12
  STUB_UNMARSHAL* = 0
  STUB_CALL_SERVER* = 1
  STUB_MARSHAL* = 2
  STUB_CALL_SERVER_NO_HRESULT* = 3
  PROXY_CALCSIZE* = 0
  PROXY_GETBUFFER* = 1
  PROXY_MARSHAL* = 2
  PROXY_SENDRECEIVE* = 3
  PROXY_UNMARSHAL* = 4
  RPC_C_BINDING_INFINITE_TIMEOUT* = 10
  RPC_C_BINDING_MIN_TIMEOUT* = 0
  RPC_C_BINDING_DEFAULT_TIMEOUT* = 5
  RPC_C_BINDING_MAX_TIMEOUT* = 9
  RPC_C_CANCEL_INFINITE_TIMEOUT* = -1
  RPC_C_LISTEN_MAX_CALLS_DEFAULT* = 1234
  RPC_C_PROTSEQ_MAX_REQS_DEFAULT* = 10
  RPC_C_BIND_TO_ALL_NICS* = 1
  RPC_C_USE_INTERNET_PORT* = 0x1
  RPC_C_USE_INTRANET_PORT* = 0x2
  RPC_C_DONT_FAIL* = 0x4
  RPC_C_MQ_TEMPORARY* = 0x0000
  RPC_C_MQ_PERMANENT* = 0x0001
  RPC_C_MQ_CLEAR_ON_OPEN* = 0x0002
  RPC_C_MQ_USE_EXISTING_SECURITY* = 0x0004
  RPC_C_MQ_AUTHN_LEVEL_NONE* = 0x0000
  RPC_C_MQ_AUTHN_LEVEL_PKT_INTEGRITY* = 0x0008
  RPC_C_MQ_AUTHN_LEVEL_PKT_PRIVACY* = 0x0010
  RPC_C_OPT_MQ_DELIVERY* = 1
  RPC_C_OPT_MQ_PRIORITY* = 2
  RPC_C_OPT_MQ_JOURNAL* = 3
  RPC_C_OPT_MQ_ACKNOWLEDGE* = 4
  RPC_C_OPT_MQ_AUTHN_SERVICE* = 5
  RPC_C_OPT_MQ_AUTHN_LEVEL* = 6
  RPC_C_OPT_MQ_TIME_TO_REACH_QUEUE* = 7
  RPC_C_OPT_MQ_TIME_TO_BE_RECEIVED* = 8
  RPC_C_OPT_BINDING_NONCAUSAL* = 9
  RPC_C_OPT_SECURITY_CALLBACK* = 10
  RPC_C_OPT_UNIQUE_BINDING* = 11
  RPC_C_OPT_CALL_TIMEOUT* = 12
  RPC_C_OPT_DONT_LINGER* = 13
  RPC_C_OPT_MAX_OPTIONS* = 14
  RPC_C_MQ_EXPRESS* = 0
  RPC_C_MQ_RECOVERABLE* = 1
  RPC_C_MQ_JOURNAL_NONE* = 0
  RPC_C_MQ_JOURNAL_DEADLETTER* = 1
  RPC_C_MQ_JOURNAL_ALWAYS* = 2
  RPC_C_FULL_CERT_CHAIN* = 0x0001
  RPC_C_STATS_CALLS_IN* = 0
  RPC_C_STATS_CALLS_OUT* = 1
  RPC_C_STATS_PKTS_IN* = 2
  RPC_C_STATS_PKTS_OUT* = 3
  RPC_C_AUTHN_LEVEL_DEFAULT* = 0
  RPC_C_AUTHN_LEVEL_NONE* = 1
  RPC_C_AUTHN_LEVEL_CONNECT* = 2
  RPC_C_AUTHN_LEVEL_CALL* = 3
  RPC_C_AUTHN_LEVEL_PKT* = 4
  RPC_C_AUTHN_LEVEL_PKT_INTEGRITY* = 5
  RPC_C_AUTHN_LEVEL_PKT_PRIVACY* = 6
  RPC_C_IMP_LEVEL_DEFAULT* = 0
  RPC_C_IMP_LEVEL_ANONYMOUS* = 1
  RPC_C_IMP_LEVEL_IDENTIFY* = 2
  RPC_C_IMP_LEVEL_IMPERSONATE* = 3
  RPC_C_IMP_LEVEL_DELEGATE* = 4
  RPC_C_QOS_IDENTITY_STATIC* = 0
  RPC_C_QOS_IDENTITY_DYNAMIC* = 1
  RPC_C_QOS_CAPABILITIES_DEFAULT* = 0x0
  RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH* = 0x1
  RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC* = 0x2
  RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY* = 0x4
  RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE* = 0x8
  RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT* = 0x10
  RPC_C_PROTECT_LEVEL_DEFAULT* = RPC_C_AUTHN_LEVEL_DEFAULT
  RPC_C_PROTECT_LEVEL_NONE* = RPC_C_AUTHN_LEVEL_NONE
  RPC_C_PROTECT_LEVEL_CONNECT* = RPC_C_AUTHN_LEVEL_CONNECT
  RPC_C_PROTECT_LEVEL_CALL* = RPC_C_AUTHN_LEVEL_CALL
  RPC_C_PROTECT_LEVEL_PKT* = RPC_C_AUTHN_LEVEL_PKT
  RPC_C_PROTECT_LEVEL_PKT_INTEGRITY* = RPC_C_AUTHN_LEVEL_PKT_INTEGRITY
  RPC_C_PROTECT_LEVEL_PKT_PRIVACY* = RPC_C_AUTHN_LEVEL_PKT_PRIVACY
  RPC_C_AUTHN_NONE* = 0
  RPC_C_AUTHN_DCE_PRIVATE* = 1
  RPC_C_AUTHN_DCE_PUBLIC* = 2
  RPC_C_AUTHN_DEC_PUBLIC* = 4
  RPC_C_AUTHN_GSS_NEGOTIATE* = 9
  RPC_C_AUTHN_WINNT* = 10
  RPC_C_AUTHN_GSS_SCHANNEL* = 14
  RPC_C_AUTHN_GSS_KERBEROS* = 16
  RPC_C_AUTHN_DPA* = 17
  RPC_C_AUTHN_MSN* = 18
  RPC_C_AUTHN_DIGEST* = 21
  RPC_C_AUTHN_MQ* = 100
  RPC_C_AUTHN_DEFAULT* = 0xFFFFFFFF'i32
  RPC_C_SECURITY_QOS_VERSION* = 1
  RPC_C_SECURITY_QOS_VERSION_1* = 1
  RPC_C_SECURITY_QOS_VERSION_2* = 2
  RPC_C_AUTHN_INFO_TYPE_HTTP* = 1
  RPC_C_HTTP_AUTHN_TARGET_SERVER* = 1
  RPC_C_HTTP_AUTHN_TARGET_PROXY* = 2
  RPC_C_HTTP_AUTHN_SCHEME_BASIC* = 0x00000001
  RPC_C_HTTP_AUTHN_SCHEME_NTLM* = 0x00000002
  RPC_C_HTTP_AUTHN_SCHEME_PASSPORT* = 0x00000004
  RPC_C_HTTP_AUTHN_SCHEME_DIGEST* = 0x00000008
  RPC_C_HTTP_AUTHN_SCHEME_NEGOTIATE* = 0x00000010
  RPC_C_HTTP_AUTHN_SCHEME_CERT* = 0x00010000
  RPC_C_HTTP_FLAG_USE_SSL* = 1
  RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME* = 2
  RPC_C_HTTP_FLAG_IGNORE_CERT_CN_INVALID* = 8
  RPC_C_SECURITY_QOS_VERSION_3* = 3
  RPCHTTP_RS_REDIRECT* = 1
  RPCHTTP_RS_ACCESS_1* = 2
  RPCHTTP_RS_SESSION* = 3
  RPCHTTP_RS_ACCESS_2* = 4
  RPCHTTP_RS_INTERFACE* = 5
  RPC_C_AUTHZ_NONE* = 0
  RPC_C_AUTHZ_NAME* = 1
  RPC_C_AUTHZ_DCE* = 2
  RPC_C_AUTHZ_DEFAULT* = 0xffffffff'i32
  DCE_C_ERROR_STRING_LEN* = 256
  RPC_C_EP_ALL_ELTS* = 0
  RPC_C_EP_MATCH_BY_IF* = 1
  RPC_C_EP_MATCH_BY_OBJ* = 2
  RPC_C_EP_MATCH_BY_BOTH* = 3
  RPC_C_VERS_ALL* = 1
  RPC_C_VERS_COMPATIBLE* = 2
  RPC_C_VERS_EXACT* = 3
  RPC_C_VERS_MAJOR_ONLY* = 4
  RPC_C_VERS_UPTO* = 5
  RPC_C_MGMT_INQ_IF_IDS* = 0
  RPC_C_MGMT_INQ_PRINC_NAME* = 1
  RPC_C_MGMT_INQ_STATS* = 2
  RPC_C_MGMT_IS_SERVER_LISTEN* = 3
  RPC_C_MGMT_STOP_SERVER_LISTEN* = 4
  RPC_C_PARM_MAX_PACKET_LENGTH* = 1
  RPC_C_PARM_BUFFER_LENGTH* = 2
  RPC_IF_AUTOLISTEN* = 0x0001
  RPC_IF_OLE* = 0x0002
  RPC_IF_ALLOW_UNKNOWN_AUTHORITY* = 0x0004
  RPC_IF_ALLOW_SECURE_ONLY* = 0x0008
  RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH* = 0x0010
  RPC_IF_ALLOW_LOCAL_ONLY* = 0x0020
  RPC_IF_SEC_NO_CACHE* = 0x0040
  RPC_CALL_STATUS_IN_PROGRESS* = 0x01
  RPC_CALL_STATUS_CANCELLED* = 0x02
  RPC_CALL_STATUS_DISCONNECTED* = 0x03
  PROTOCOL_NOT_LOADED* = 1
  PROTOCOL_LOADED* = 2
  PROTOCOL_ADDRESS_CHANGE* = 3
  RPC_CONTEXT_HANDLE_DEFAULT_FLAGS* = 0x00000000
  RPC_CONTEXT_HANDLE_FLAGS* = 0x30000000
  RPC_CONTEXT_HANDLE_SERIALIZE* = 0x10000000
  RPC_CONTEXT_HANDLE_DONT_SERIALIZE* = 0x20000000
  RPC_NCA_FLAGS_DEFAULT* = 0x00000000
  RPC_NCA_FLAGS_IDEMPOTENT* = 0x00000001
  RPC_NCA_FLAGS_BROADCAST* = 0x00000002
  RPC_NCA_FLAGS_MAYBE* = 0x00000004
  RPC_BUFFER_COMPLETE* = 0x00001000
  RPC_BUFFER_PARTIAL* = 0x00002000
  RPC_BUFFER_EXTRA* = 0x00004000
  RPC_BUFFER_ASYNC* = 0x00008000
  RPC_BUFFER_NONOTIFY* = 0x00010000
  RPCFLG_MESSAGE* = 0x01000000
  RPCFLG_AUTO_COMPLETE* = 0x08000000
  RPCFLG_LOCAL_CALL* = 0x10000000
  RPCFLG_INPUT_SYNCHRONOUS* = 0x20000000
  RPCFLG_ASYNCHRONOUS* = 0x40000000
  RPCFLG_NON_NDR* = 0x80000000'i32
  RPCFLG_HAS_MULTI_SYNTAXES* = 0x02000000
  RPCFLG_HAS_CALLBACK* = 0x04000000
  RPC_FLAGS_VALID_BIT* = 0x00008000
  NT351_INTERFACE_SIZE* = 0x40
  RPC_INTERFACE_HAS_PIPES* = 0x0001
  TRANSPORT_TYPE_CN* = 0x01
  TRANSPORT_TYPE_DG* = 0x02
  TRANSPORT_TYPE_LPC* = 0x04
  TRANSPORT_TYPE_WMSG* = 0x08
  RPC_P_ADDR_FORMAT_TCP_IPV4* = 1
  RPC_P_ADDR_FORMAT_TCP_IPV6* = 2
  RPC_PROXY_CONNECTION_TYPE_IN_PROXY* = 0
  RPC_PROXY_CONNECTION_TYPE_OUT_PROXY* = 1
  RPC_C_NS_SYNTAX_DEFAULT* = 0
  RPC_C_NS_SYNTAX_DCE* = 3
  RPC_C_PROFILE_DEFAULT_ELT* = 0
  RPC_C_PROFILE_ALL_ELT* = 1
  RPC_C_PROFILE_ALL_ELTS* = RPC_C_PROFILE_ALL_ELT
  RPC_C_PROFILE_MATCH_BY_IF* = 2
  RPC_C_PROFILE_MATCH_BY_MBR* = 3
  RPC_C_PROFILE_MATCH_BY_BOTH* = 4
  RPC_C_NS_DEFAULT_EXP_AGE* = -1
  RPC_S_OK* = ERROR_SUCCESS
  RPC_S_INVALID_ARG* = ERROR_INVALID_PARAMETER
  RPC_S_OUT_OF_MEMORY* = ERROR_OUTOFMEMORY
  RPC_S_OUT_OF_THREADS* = ERROR_MAX_THRDS_REACHED
  RPC_S_INVALID_LEVEL* = ERROR_INVALID_PARAMETER
  RPC_S_BUFFER_TOO_SMALL* = ERROR_INSUFFICIENT_BUFFER
  RPC_S_INVALID_SECURITY_DESC* = ERROR_INVALID_SECURITY_DESCR
  RPC_S_ACCESS_DENIED* = ERROR_ACCESS_DENIED
  RPC_S_SERVER_OUT_OF_MEMORY* = ERROR_NOT_ENOUGH_SERVER_MEMORY
  RPC_S_ASYNC_CALL_PENDING* = ERROR_IO_PENDING
  RPC_S_UNKNOWN_PRINCIPAL* = ERROR_NONE_MAPPED
  RPC_S_TIMEOUT* = ERROR_TIMEOUT
  RPC_X_NO_MEMORY* = RPC_S_OUT_OF_MEMORY
  RPC_X_INVALID_BOUND* = RPC_S_INVALID_BOUND
  RPC_X_INVALID_TAG* = RPC_S_INVALID_TAG
  RPC_X_ENUM_VALUE_TOO_LARGE* = RPC_X_ENUM_VALUE_OUT_OF_RANGE
  RPC_X_SS_CONTEXT_MISMATCH* = ERROR_INVALID_HANDLE
  RPC_X_INVALID_BUFFER* = ERROR_INVALID_USER_BUFFER
  RPC_X_PIPE_APP_MEMORY* = ERROR_OUTOFMEMORY
  RPC_X_INVALID_PIPE_OPERATION* = RPC_X_WRONG_PIPE_ORDER
  rpcNotificationTypeNone* = 0
  rpcNotificationTypeEvent* = 1
  rpcNotificationTypeApc* = 2
  rpcNotificationTypeIoc* = 3
  rpcNotificationTypeHwnd* = 4
  rpcNotificationTypeCallback* = 5
  rpcCallComplete* = 0
  rpcSendComplete* = 1
  rpcReceiveComplete* = 2
  RPC_C_NOTIFY_ON_SEND_COMPLETE* = 0x1
  RPC_C_INFINITE_TIMEOUT* = INFINITE
  eeptAnsiString* = 1
  eeptUnicodeString* = 2
  eeptLongVal* = 3
  eeptShortVal* = 4
  eeptPointerVal* = 5
  eeptNone* = 6
  eeptBinary* = 7
  maxNumberOfEEInfoParams* = 4
  RPC_EEINFO_VERSION* = 1
  eEInfoPreviousRecordsMissing* = 1
  eEInfoNextRecordsMissing* = 2
  eEInfoUseFileTime* = 4
  eEInfoGCCOM* = 11
  eEInfoGCFRS* = 12
  RPC_CALL_ATTRIBUTES_VERSION* = 1
  RPC_QUERY_SERVER_PRINCIPAL_NAME* = 2
  RPC_QUERY_CLIENT_PRINCIPAL_NAME* = 4
  rctInvalid* = 0
  rctNormal* = 1
  rctTraining* = 2
  rctGuaranteed* = 3
  rlafInvalid* = 0
  rlafIPv4* = 1
  rlafIPv6* = 2
  rpcNotificationCallNone* = 0
  rpcNotificationClientDisconnect* = 1
  rpcNotificationCallCancel* = 2
  rcclInvalid* = 0
  rcclLocal* = 1
  rcclRemote* = 2
  rcclClientUnknownLocality* = 3
  RPCPROXY_H_VERSION* = 475
  RPC_C_NO_CREDENTIALS* = RPC_AUTH_IDENTITY_HANDLE(-1)
  RPC_CONTEXT_HANDLE_DEFAULT_GUARD* = HANDLE(-4083)
type
  NDR_NOTIFY2_ROUTINE* = proc (flag: boolean): void {.stdcall.}
  RPC_CLIENT_ALLOC* = proc (Size: int): pointer {.stdcall.}
  RPC_CLIENT_FREE* = proc (Ptr: pointer): void {.stdcall.}
  RPC_OBJECT_INQ_FN* = proc (ObjectUuid: ptr UUID, TypeUuid: ptr UUID, Status: ptr RPC_STATUS): void {.stdcall.}
  RPC_IF_CALLBACK_FN* = proc (InterfaceUuid: RPC_IF_HANDLE, Context: pointer): RPC_STATUS {.stdcall.}
  RPC_SECURITY_CALLBACK_FN* = proc (Context: pointer): void {.stdcall.}
  RPC_NEW_HTTP_PROXY_CHANNEL* = proc (RedirectorStage: RPC_HTTP_REDIRECTOR_STAGE, ServerName: ptr uint16, ServerPort: ptr uint16, RemoteUser: ptr uint16, AuthType: ptr uint16, ResourceUuid: pointer, Metadata: pointer, SessionId: pointer, Interface: pointer, Reserved: pointer, Flags: int32, NewServerName: ptr ptr uint16, NewServerPort: ptr ptr uint16): RPC_STATUS {.stdcall.}
  RPC_HTTP_PROXY_FREE_STRING* = proc (String: ptr uint16): void {.stdcall.}
  RPC_AUTH_KEY_RETRIEVAL_FN* = proc (Arg: pointer, ServerPrincName: ptr uint16, KeyVer: int32, Key: ptr pointer, Status: ptr RPC_STATUS): void {.stdcall.}
  RPC_MGMT_AUTHORIZATION_FN* = proc (ClientBinding: RPC_BINDING_HANDLE, RequestedMgmtOperation: int32, Status: ptr RPC_STATUS): int32 {.stdcall.}
  RPC_FORWARD_FUNCTION* = proc (InterfaceId: ptr UUID, InterfaceVersion: ptr RPC_VERSION, ObjectId: ptr UUID, Rpcpro: ptr uint8, ppDestEndpoint: ptr pointer): RPC_STATUS {.stdcall.}
  RPC_ADDRESS_CHANGE_FN* = proc (arg: pointer): void {.stdcall.}
  PRPC_RUNDOWN* = proc (AssociationContext: pointer): void {.stdcall.}
  RPCLT_PDU_FILTER_FUNC* = proc (Buffer: pointer, BufferLength: int32, fDatagram: int32): void {.stdcall.}
  RPC_SETFILTER_FUNC* = proc (pfnFilter: RPCLT_PDU_FILTER_FUNC): void {.stdcall.}
  RPC_BLOCKING_FN* = proc (hWnd: pointer, Context: pointer, hSyncEvent: pointer): RPC_STATUS {.stdcall.}
  I_RpcProxyIsValidMachineFn* = proc (pszMachine: ptr char, pszDotMachine: ptr char, dwPortNumber: int32): RPC_STATUS {.stdcall.}
  I_RpcProxyGetClientAddressFn* = proc (Context: pointer, Buffer: ptr char, BufferLength: ptr int32): RPC_STATUS {.stdcall.}
  I_RpcProxyGetConnectionTimeoutFn* = proc (ConnectionTimeout: ptr int32): RPC_STATUS {.stdcall.}
  RPC_C_OPT_METADATA_DESCRIPTOR* {.pure.} = object
    BufferSize*: int32
    Buffer*: ptr char
  RDR_CALLOUT_STATE* {.pure.} = object
    LastError*: RPC_STATUS
    LastEEInfo*: pointer
    LastCalledStage*: RPC_HTTP_REDIRECTOR_STAGE
    ServerName*: ptr uint16
    ServerPort*: ptr uint16
    RemoteUser*: ptr uint16
    AuthType*: ptr uint16
    ResourceTypePresent*: uint8
    MetadataPresent*: uint8
    SessionIdPresent*: uint8
    InterfacePresent*: uint8
    ResourceType*: UUID
    Metadata*: RPC_C_OPT_METADATA_DESCRIPTOR
    SessionId*: UUID
    Interface*: RPC_SYNTAX_IDENTIFIER
    CertContext*: pointer
  I_RpcPerformCalloutFn* = proc (Context: pointer, CallOutState: ptr RDR_CALLOUT_STATE, Stage: RPC_HTTP_REDIRECTOR_STAGE): RPC_STATUS {.stdcall.}
  I_RpcFreeCalloutStateFn* = proc (CallOutState: ptr RDR_CALLOUT_STATE): void {.stdcall.}
  RPCNOTIFICATION_ROUTINE* = proc (pAsync: ptr RPC_ASYNC_STATE, Context: pointer, Event: RPC_ASYNC_EVENT): void {.stdcall.}
  USER_MARSHAL_CB* {.pure.} = object
    Flags*: int32
    pStubMsg*: PMIDL_STUB_MESSAGE
    pReserve*: PFORMAT_STRING
    Signature*: int32
    CBType*: USER_MARSHAL_CB_TYPE
    pFormat*: PFORMAT_STRING
    pTypeFormat*: PFORMAT_STRING
  MIDL_FORMAT_STRING* {.pure.} = object
    Pad*: int16
    Format*: UncheckedArray[uint8]
  CLIENT_CALL_RETURN* {.pure, union.} = object
    Pointer*: pointer
    Simple*: LONG_PTR
  NDR_USER_MARSHAL_INFO_LEVEL1* {.pure.} = object
    Buffer*: pointer
    BufferSize*: int32
    pfnAllocate*: proc(P1: int): pointer {.stdcall.}
    pfnFree*: proc(P1: pointer): void {.stdcall.}
    pRpcChannelBuffer*: ptr IRpcChannelBuffer
    Reserved*: array[5, ULONG_PTR]
  NDR_USER_MARSHAL_INFO_UNION1* {.pure, union.} = object
    Level1*: NDR_USER_MARSHAL_INFO_LEVEL1
  NDR_USER_MARSHAL_INFO* {.pure.} = object
    InformationLevel*: int32
    union1*: NDR_USER_MARSHAL_INFO_UNION1
  RPC_IF_ID* {.pure.} = object
    Uuid*: UUID
    VersMajor*: uint16
    VersMinor*: uint16
  RPC_PROTSEQ_VECTORA* {.pure.} = object
    Count*: int32
    Protseq*: array[1, ptr uint8]
  RPC_PROTSEQ_VECTORW* {.pure.} = object
    Count*: int32
    Protseq*: array[1, ptr uint16]
  RPC_STATS_VECTOR* {.pure.} = object
    Count*: int32
    Stats*: array[1, int32]
  RPC_IF_ID_VECTOR* {.pure.} = object
    Count*: int32
    IfId*: array[1, ptr RPC_IF_ID]
  RPC_TRANSFER_SYNTAX* {.pure.} = object
    Uuid*: UUID
    VersMajor*: uint16
    VersMinor*: uint16
  I_RpcProxyCallbackInterface* {.pure.} = object
    IsValidMachineFn*: I_RpcProxyIsValidMachineFn
    GetClientAddressFn*: I_RpcProxyGetClientAddressFn
    GetConnectionTimeoutFn*: I_RpcProxyGetConnectionTimeoutFn
    PerformCalloutFn*: I_RpcPerformCalloutFn
    FreeCalloutStateFn*: I_RpcFreeCalloutStateFn
  BinaryParam* {.pure.} = object
    Buffer*: pointer
    Size*: int16
  RPC_EE_INFO_PARAM_u* {.pure, union.} = object
    AnsiString*: LPSTR
    UnicodeString*: LPWSTR
    LVal*: int32
    SVal*: int16
    PVal*: ULONGLONG
    BVal*: BinaryParam
  RPC_EE_INFO_PARAM* {.pure.} = object
    ParameterType*: ExtendedErrorParamTypes
    padding*: array[4, byte]
    u*: RPC_EE_INFO_PARAM_u
  RPC_EXTENDED_ERROR_INFO_u* {.pure, union.} = object
    SystemTime*: SYSTEMTIME
    FileTime*: FILETIME
  RPC_EXTENDED_ERROR_INFO* {.pure.} = object
    Version*: ULONG
    ComputerName*: LPWSTR
    ProcessID*: ULONG
    u*: RPC_EXTENDED_ERROR_INFO_u
    GeneratingComponent*: ULONG
    Status*: ULONG
    DetectionLocation*: USHORT
    Flags*: USHORT
    NumberOfParameters*: int32
    padding*: array[4, byte]
    Parameters*: array[maxNumberOfEEInfoParams, RPC_EE_INFO_PARAM]
  RPC_ERROR_ENUM_HANDLE* {.pure.} = object
    Signature*: ULONG
    CurrentPos*: pointer
    Head*: pointer
  CStdStubBuffer* {.pure.} = object
    lpVtbl*: ptr IRpcStubBufferVtbl
    RefCount*: int32
    pvServerObject*: ptr IUnknown
    pCallFactoryVtbl*: ptr ICallFactoryVtbl
    pAsyncIID*: ptr IID
    pPSFactory*: ptr IPSFactoryBuffer
    pRMBVtbl*: ptr IReleaseMarshalBuffersVtbl
  CStdPSFactoryBuffer* {.pure.} = object
    lpVtbl*: ptr IPSFactoryBufferVtbl
    RefCount*: int32
    pProxyFileList*: ptr ptr ProxyFileInfo
    Filler1*: int32
proc I_RpcNsGetBuffer*(Message: PRPC_MESSAGE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc I_RpcNsSendReceive*(Message: PRPC_MESSAGE, Handle: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc I_RpcNsRaiseException*(Message: PRPC_MESSAGE, Status: RPC_STATUS): void {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc I_RpcReBindBuffer*(Message: PRPC_MESSAGE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc NDRCContextBinding*(CContext: NDR_CCONTEXT): RPC_BINDING_HANDLE {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NDRCContextMarshall*(CContext: NDR_CCONTEXT, pBuff: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NDRCContextUnmarshall*(pCContext: ptr NDR_CCONTEXT, hBinding: RPC_BINDING_HANDLE, pBuff: pointer, DataRepresentation: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NDRSContextMarshall*(CContext: NDR_SCONTEXT, pBuff: pointer, userRunDownIn: NDR_RUNDOWN): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NDRSContextUnmarshall*(pBuff: pointer, DataRepresentation: int32): NDR_SCONTEXT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NDRSContextMarshallEx*(BindingHandle: RPC_BINDING_HANDLE, CContext: NDR_SCONTEXT, pBuff: pointer, userRunDownIn: NDR_RUNDOWN): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NDRSContextMarshall2*(BindingHandle: RPC_BINDING_HANDLE, CContext: NDR_SCONTEXT, pBuff: pointer, userRunDownIn: NDR_RUNDOWN, CtxGuard: pointer, Flags: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NDRSContextUnmarshallEx*(BindingHandle: RPC_BINDING_HANDLE, pBuff: pointer, DataRepresentation: int32): NDR_SCONTEXT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NDRSContextUnmarshall2*(BindingHandle: RPC_BINDING_HANDLE, pBuff: pointer, DataRepresentation: int32, CtxGuard: pointer, Flags: int32): NDR_SCONTEXT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsDestroyClientContext*(ContextHandle: ptr pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrSimpleTypeMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, FormatChar: uint8): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPointerMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStructMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexStructMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonConformantStringMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStringMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrByteCountPointerMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrClientContextMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ContextHandle: NDR_CCONTEXT, fCheck: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerContextMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ContextHandle: NDR_SCONTEXT, RundownRoutine: NDR_RUNDOWN): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerContextNewMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ContextHandle: NDR_SCONTEXT, RundownRoutine: NDR_RUNDOWN, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrSimpleTypeUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, FormatChar: uint8): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrRangeUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrCorrelationInitialize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: pointer, CacheSize: int32, flags: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrCorrelationPass*(pStubMsg: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrCorrelationFree*(pStubMsg: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPointerUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStructUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexStructUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonConformantStringUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStringUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrByteCountPointerUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr ptr uint8, pFormat: PFORMAT_STRING, fMustAlloc: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrClientContextUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pContextHandle: ptr NDR_CCONTEXT, BindHandle: RPC_BINDING_HANDLE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerContextUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE): NDR_SCONTEXT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrContextHandleInitialize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): NDR_SCONTEXT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerContextNewUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): NDR_SCONTEXT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPointerBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStructBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexStructBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStringBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonConformantStringBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrByteCountPointerBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrContextHandleSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPointerMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStructMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexStructMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStringMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonConformantStringMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerMemorySize*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPointerFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantStructFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexStructFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrByteCountPointerFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerFree*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: ptr uint8, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConvert2*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING, NumberParams: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrConvert*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalSimpleTypeConvert*(pFlags: ptr int32, pBuffer: ptr uint8, FormatChar: uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrClientInitializeNew*(pRpcMsg: PRPC_MESSAGE, pStubMsg: PMIDL_STUB_MESSAGE, pStubDescriptor: PMIDL_STUB_DESC, ProcNum: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerInitializeNew*(pRpcMsg: PRPC_MESSAGE, pStubMsg: PMIDL_STUB_MESSAGE, pStubDescriptor: PMIDL_STUB_DESC): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerInitializePartial*(pRpcMsg: PRPC_MESSAGE, pStubMsg: PMIDL_STUB_MESSAGE, pStubDescriptor: PMIDL_STUB_DESC, RequestedBufferSize: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrClientInitialize*(pRpcMsg: PRPC_MESSAGE, pStubMsg: PMIDL_STUB_MESSAGE, pStubDescriptor: PMIDL_STUB_DESC, ProcNum: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerInitialize*(pRpcMsg: PRPC_MESSAGE, pStubMsg: PMIDL_STUB_MESSAGE, pStubDescriptor: PMIDL_STUB_DESC): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerInitializeUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pStubDescriptor: PMIDL_STUB_DESC, pRpcMsg: PRPC_MESSAGE): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerInitializeMarshall*(pRpcMsg: PRPC_MESSAGE, pStubMsg: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrGetBuffer*(pStubMsg: PMIDL_STUB_MESSAGE, BufferLength: int32, Handle: RPC_BINDING_HANDLE): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNsGetBuffer*(pStubMsg: PMIDL_STUB_MESSAGE, BufferLength: int32, Handle: RPC_BINDING_HANDLE): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrSendReceive*(pStubMsg: PMIDL_STUB_MESSAGE, pBufferEnd: ptr uint8): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrNsSendReceive*(pStubMsg: PMIDL_STUB_MESSAGE, pBufferEnd: ptr uint8, pAutoHandle: ptr RPC_BINDING_HANDLE): ptr uint8 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFreeBuffer*(pStubMsg: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrGetDcomProtocolVersion*(pStubMsg: PMIDL_STUB_MESSAGE, pVersion: ptr RPC_VERSION): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrAsyncServerCall*(pRpcMsg: PRPC_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrDcomAsyncStubCall*(pThis: ptr IRpcStubBuffer, pChannel: ptr IRpcChannelBuffer, pRpcMsg: PRPC_MESSAGE, pdwStubPhase: ptr int32): LONG32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrStubCall2*(pThis: ptr IRpcStubBuffer, pChannel: ptr IRpcChannelBuffer, pRpcMsg: PRPC_MESSAGE, pdwStubPhase: ptr int32): LONG32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrServerCall2*(pRpcMsg: PRPC_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrMapCommAndFaultStatus*(pStubMsg: PMIDL_STUB_MESSAGE, pCommStatus: ptr int32, pFaultStatus: ptr int32, Status: RPC_STATUS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsAllocate*(Size: int): pointer {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsDisableAllocate*(): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsEnableAllocate*(): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsFree*(NodeToFree: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsGetThreadHandle*(): RPC_SS_THREAD_HANDLE {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsSetClientAllocFree*(ClientAlloc: RPC_CLIENT_ALLOC, ClientFree: RPC_CLIENT_FREE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsSetThreadHandle*(Id: RPC_SS_THREAD_HANDLE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsSwapClientAllocFree*(ClientAlloc: RPC_CLIENT_ALLOC, ClientFree: RPC_CLIENT_FREE, OldClientAlloc: RPC_CLIENT_ALLOC, OldClientFree: RPC_CLIENT_FREE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmAllocate*(Size: int, pStatus: ptr RPC_STATUS): pointer {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmClientFree*(pNodeToFree: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmDestroyClientContext*(ContextHandle: ptr pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmDisableAllocate*(): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmEnableAllocate*(): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmFree*(NodeToFree: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmGetThreadHandle*(pStatus: ptr RPC_STATUS): RPC_SS_THREAD_HANDLE {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmSetClientAllocFree*(ClientAlloc: RPC_CLIENT_ALLOC, ClientFree: RPC_CLIENT_FREE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmSetThreadHandle*(Id: RPC_SS_THREAD_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSmSwapClientAllocFree*(ClientAlloc: RPC_CLIENT_ALLOC, ClientFree: RPC_CLIENT_FREE, OldClientAlloc: RPC_CLIENT_ALLOC, OldClientFree: RPC_CLIENT_FREE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrRpcSsEnableAllocate*(pMessage: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrRpcSsDisableAllocate*(pMessage: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrRpcSmSetClientToOsf*(pMessage: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrRpcSmClientAllocate*(Size: int): pointer {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrRpcSmClientFree*(NodeToFree: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrRpcSsDefaultAllocate*(Size: int): pointer {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrRpcSsDefaultFree*(NodeToFree: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFullPointerXlatInit*(NumberOfPointers: int32, XlatSide: XLAT_SIDE): PFULL_PTR_XLAT_TABLES {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFullPointerXlatFree*(pXlatTables: PFULL_PTR_XLAT_TABLES): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFullPointerQueryPointer*(pXlatTables: PFULL_PTR_XLAT_TABLES, pPointer: pointer, QueryType: uint8, pRefId: ptr int32): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFullPointerQueryRefId*(pXlatTables: PFULL_PTR_XLAT_TABLES, RefId: int32, QueryType: uint8, ppPointer: ptr pointer): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFullPointerInsertRefId*(pXlatTables: PFULL_PTR_XLAT_TABLES, RefId: int32, pPointer: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrFullPointerFree*(pXlatTables: PFULL_PTR_XLAT_TABLES, Pointer: pointer): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrAllocate*(pStubMsg: PMIDL_STUB_MESSAGE, Len: int): pointer {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrClearOutParameters*(pStubMsg: PMIDL_STUB_MESSAGE, pFormat: PFORMAT_STRING, ArgAddr: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrOleAllocate*(Size: int): pointer {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrOleFree*(NodeToFree: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrGetUserMarshalInfo*(pFlags: ptr int32, InformationLevel: int32, pMarshalInfo: ptr NDR_USER_MARSHAL_INFO): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrCreateServerInterfaceFromStub*(pStub: ptr IRpcStubBuffer, pServerIf: ptr RPC_SERVER_INTERFACE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPartialIgnoreClientMarshall*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPartialIgnoreServerUnmarshall*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPartialIgnoreClientBufferSize*(pStubMsg: PMIDL_STUB_MESSAGE, pMemory: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrPartialIgnoreServerInitialize*(pStubMsg: PMIDL_STUB_MESSAGE, ppMemory: ptr pointer, pFormat: PFORMAT_STRING): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcUserFree*(AsyncHandle: handle_t, pBuffer: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingCopy*(SourceBinding: RPC_BINDING_HANDLE, DestinationBinding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingFree*(Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingSetOption*(hBinding: RPC_BINDING_HANDLE, option: int32, optionValue: ULONG_PTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqOption*(hBinding: RPC_BINDING_HANDLE, option: int32, pOptionValue: ptr ULONG_PTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingFromStringBindingA*(StringBinding: RPC_CSTR, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingFromStringBindingW*(StringBinding: RPC_WSTR, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsGetContextBinding*(ContextHandle: pointer, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqObject*(Binding: RPC_BINDING_HANDLE, ObjectUuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingReset*(Binding: RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingSetObject*(Binding: RPC_BINDING_HANDLE, ObjectUuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtInqDefaultProtectLevel*(AuthnSvc: int32, AuthnLevel: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingToStringBindingA*(Binding: RPC_BINDING_HANDLE, StringBinding: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingToStringBindingW*(Binding: RPC_BINDING_HANDLE, StringBinding: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingVectorFree*(BindingVector: ptr ptr RPC_BINDING_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcStringBindingComposeA*(ObjUuid: RPC_CSTR, Protseq: RPC_CSTR, NetworkAddr: RPC_CSTR, Endpoint: RPC_CSTR, Options: RPC_CSTR, StringBinding: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcStringBindingComposeW*(ObjUuid: RPC_WSTR, Protseq: RPC_WSTR, NetworkAddr: RPC_WSTR, Endpoint: RPC_WSTR, Options: RPC_WSTR, StringBinding: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcStringBindingParseA*(StringBinding: RPC_CSTR, ObjUuid: ptr RPC_CSTR, Protseq: ptr RPC_CSTR, NetworkAddr: ptr RPC_CSTR, Endpoint: ptr RPC_CSTR, NetworkOptions: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcStringBindingParseW*(StringBinding: RPC_WSTR, ObjUuid: ptr RPC_WSTR, Protseq: ptr RPC_WSTR, NetworkAddr: ptr RPC_WSTR, Endpoint: ptr RPC_WSTR, NetworkOptions: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcStringFreeA*(String: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcStringFreeW*(String: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcIfInqId*(RpcIfHandle: RPC_IF_HANDLE, RpcIfId: ptr RPC_IF_ID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcNetworkIsProtseqValidA*(Protseq: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcNetworkIsProtseqValidW*(Protseq: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtInqComTimeout*(Binding: RPC_BINDING_HANDLE, Timeout: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtSetComTimeout*(Binding: RPC_BINDING_HANDLE, Timeout: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtSetCancelTimeout*(Timeout: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcNetworkInqProtseqsA*(ProtseqVector: ptr ptr RPC_PROTSEQ_VECTORA): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcNetworkInqProtseqsW*(ProtseqVector: ptr ptr RPC_PROTSEQ_VECTORW): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcObjectInqType*(ObjUuid: ptr UUID, TypeUuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcObjectSetInqFn*(InquiryFn: RPC_OBJECT_INQ_FN): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcObjectSetType*(ObjUuid: ptr UUID, TypeUuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcProtseqVectorFreeA*(ProtseqVector: ptr ptr RPC_PROTSEQ_VECTORA): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcProtseqVectorFreeW*(ProtseqVector: ptr ptr RPC_PROTSEQ_VECTORW): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerInqBindings*(BindingVector: ptr ptr RPC_BINDING_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerInqIf*(IfSpec: RPC_IF_HANDLE, MgrTypeUuid: ptr UUID, MgrEpv: ptr ptr RPC_MGR_EPV): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerListen*(MinimumCallThreads: int32, MaxCalls: int32, DontWait: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerRegisterIf*(IfSpec: RPC_IF_HANDLE, MgrTypeUuid: ptr UUID, MgrEpv: ptr RPC_MGR_EPV): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerRegisterIfEx*(IfSpec: RPC_IF_HANDLE, MgrTypeUuid: ptr UUID, MgrEpv: ptr RPC_MGR_EPV, Flags: int32, MaxCalls: int32, IfCallback: RPC_IF_CALLBACK_FN): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerRegisterIf2*(IfSpec: RPC_IF_HANDLE, MgrTypeUuid: ptr UUID, MgrEpv: ptr RPC_MGR_EPV, Flags: int32, MaxCalls: int32, MaxRpcSize: int32, IfCallbackFn: RPC_IF_CALLBACK_FN): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUnregisterIf*(IfSpec: RPC_IF_HANDLE, MgrTypeUuid: ptr UUID, WaitForCallsToComplete: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUnregisterIfEx*(IfSpec: RPC_IF_HANDLE, MgrTypeUuid: ptr UUID, RundownContextHandles: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseAllProtseqs*(MaxCalls: int32, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseAllProtseqsEx*(MaxCalls: int32, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseAllProtseqsIf*(MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseAllProtseqsIfEx*(MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqA*(Protseq: RPC_CSTR, MaxCalls: int32, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqExA*(Protseq: RPC_CSTR, MaxCalls: int32, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqW*(Protseq: RPC_WSTR, MaxCalls: int32, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqExW*(Protseq: RPC_WSTR, MaxCalls: int32, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqEpA*(Protseq: RPC_CSTR, MaxCalls: int32, Endpoint: RPC_CSTR, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqEpExA*(Protseq: RPC_CSTR, MaxCalls: int32, Endpoint: RPC_CSTR, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqEpW*(Protseq: RPC_WSTR, MaxCalls: int32, Endpoint: RPC_WSTR, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqEpExW*(Protseq: RPC_WSTR, MaxCalls: int32, Endpoint: RPC_WSTR, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqIfA*(Protseq: RPC_CSTR, MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqIfExA*(Protseq: RPC_CSTR, MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqIfW*(Protseq: RPC_WSTR, MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUseProtseqIfExW*(Protseq: RPC_WSTR, MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerYield*(): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtStatsVectorFree*(StatsVector: ptr ptr RPC_STATS_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtInqStats*(Binding: RPC_BINDING_HANDLE, Statistics: ptr ptr RPC_STATS_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtIsServerListening*(Binding: RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtStopServerListening*(Binding: RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtWaitServerListen*(): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtSetServerStackSize*(ThreadStackSize: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsDontSerializeContext*(): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtEnableIdleCleanup*(): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtInqIfIds*(Binding: RPC_BINDING_HANDLE, IfIdVector: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcIfIdVectorFree*(IfIdVector: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtInqServerPrincNameA*(Binding: RPC_BINDING_HANDLE, AuthnSvc: int32, ServerPrincName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtInqServerPrincNameW*(Binding: RPC_BINDING_HANDLE, AuthnSvc: int32, ServerPrincName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerInqDefaultPrincNameA*(AuthnSvc: int32, PrincName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerInqDefaultPrincNameW*(AuthnSvc: int32, PrincName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcEpResolveBinding*(Binding: RPC_BINDING_HANDLE, IfSpec: RPC_IF_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcNsBindingInqEntryNameA*(Binding: RPC_BINDING_HANDLE, EntryNameSyntax: int32, EntryName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcNsBindingInqEntryNameW*(Binding: RPC_BINDING_HANDLE, EntryNameSyntax: int32, EntryName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcImpersonateClient*(BindingHandle: RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcRevertToSelfEx*(BindingHandle: RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcRevertToSelf*(): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqAuthClientA*(ClientBinding: RPC_BINDING_HANDLE, Privs: ptr RPC_AUTHZ_HANDLE, ServerPrincName: ptr RPC_CSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthzSvc: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqAuthClientW*(ClientBinding: RPC_BINDING_HANDLE, Privs: ptr RPC_AUTHZ_HANDLE, ServerPrincName: ptr RPC_WSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthzSvc: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqAuthClientExA*(ClientBinding: RPC_BINDING_HANDLE, Privs: ptr RPC_AUTHZ_HANDLE, ServerPrincName: ptr RPC_CSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthzSvc: ptr int32, Flags: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqAuthClientExW*(ClientBinding: RPC_BINDING_HANDLE, Privs: ptr RPC_AUTHZ_HANDLE, ServerPrincName: ptr RPC_WSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthzSvc: ptr int32, Flags: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqAuthInfoA*(Binding: RPC_BINDING_HANDLE, ServerPrincName: ptr RPC_CSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthIdentity: ptr RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqAuthInfoW*(Binding: RPC_BINDING_HANDLE, ServerPrincName: ptr RPC_WSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthIdentity: ptr RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingSetAuthInfoA*(Binding: RPC_BINDING_HANDLE, ServerPrincName: RPC_CSTR, AuthnLevel: int32, AuthnSvc: int32, AuthIdentity: RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingSetAuthInfoExA*(Binding: RPC_BINDING_HANDLE, ServerPrincName: RPC_CSTR, AuthnLevel: int32, AuthnSvc: int32, AuthIdentity: RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: int32, SecurityQos: ptr RPC_SECURITY_QOS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingSetAuthInfoW*(Binding: RPC_BINDING_HANDLE, ServerPrincName: RPC_WSTR, AuthnLevel: int32, AuthnSvc: int32, AuthIdentity: RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingSetAuthInfoExW*(Binding: RPC_BINDING_HANDLE, ServerPrincName: RPC_WSTR, AuthnLevel: int32, AuthnSvc: int32, AuthIdentity: RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: int32, SecurityQOS: ptr RPC_SECURITY_QOS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqAuthInfoExA*(Binding: RPC_BINDING_HANDLE, ServerPrincName: ptr RPC_CSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthIdentity: ptr RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: ptr int32, RpcQosVersion: int32, SecurityQOS: ptr RPC_SECURITY_QOS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingInqAuthInfoExW*(Binding: RPC_BINDING_HANDLE, ServerPrincName: ptr RPC_WSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthIdentity: ptr RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: ptr int32, RpcQosVersion: int32, SecurityQOS: ptr RPC_SECURITY_QOS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerRegisterAuthInfoA*(ServerPrincName: RPC_CSTR, AuthnSvc: int32, GetKeyFn: RPC_AUTH_KEY_RETRIEVAL_FN, Arg: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerRegisterAuthInfoW*(ServerPrincName: RPC_WSTR, AuthnSvc: int32, GetKeyFn: RPC_AUTH_KEY_RETRIEVAL_FN, Arg: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingServerFromClient*(ClientBinding: RPC_BINDING_HANDLE, ServerBinding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcTestCancel*(): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerTestCancel*(BindingHandle: RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcCancelThread*(Thread: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcCancelThreadEx*(Thread: pointer, Timeout: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidCreate*(Uuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidCreateSequential*(Uuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidToStringA*(Uuid: ptr UUID, StringUuid: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidFromStringA*(StringUuid: RPC_CSTR, Uuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidToStringW*(Uuid: ptr UUID, StringUuid: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidFromStringW*(StringUuid: RPC_WSTR, Uuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidCreateNil*(NilUuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidEqual*(Uuid1: ptr UUID, Uuid2: ptr UUID, Status: ptr RPC_STATUS): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidHash*(Uuid: ptr UUID, Status: ptr RPC_STATUS): uint16 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc UuidIsNil*(Uuid: ptr UUID, Status: ptr RPC_STATUS): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcEpRegisterNoReplaceA*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR, Annotation: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcEpRegisterNoReplaceW*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR, Annotation: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcEpRegisterA*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR, Annotation: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcEpRegisterW*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR, Annotation: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcEpUnregister*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc DceErrorInqTextA*(RpcStatus: RPC_STATUS, ErrorText: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc DceErrorInqTextW*(RpcStatus: RPC_STATUS, ErrorText: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtEpEltInqBegin*(EpBinding: RPC_BINDING_HANDLE, InquiryType: int32, IfId: ptr RPC_IF_ID, VersOption: int32, ObjectUuid: ptr UUID, InquiryContext: ptr RPC_EP_INQ_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtEpEltInqDone*(InquiryContext: ptr RPC_EP_INQ_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtEpEltInqNextA*(InquiryContext: RPC_EP_INQ_HANDLE, IfId: ptr RPC_IF_ID, Binding: ptr RPC_BINDING_HANDLE, ObjectUuid: ptr UUID, Annotation: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtEpEltInqNextW*(InquiryContext: RPC_EP_INQ_HANDLE, IfId: ptr RPC_IF_ID, Binding: ptr RPC_BINDING_HANDLE, ObjectUuid: ptr UUID, Annotation: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtEpUnregister*(EpBinding: RPC_BINDING_HANDLE, IfId: ptr RPC_IF_ID, Binding: RPC_BINDING_HANDLE, ObjectUuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcMgmtSetAuthorizationFn*(AuthorizationFn: RPC_MGMT_AUTHORIZATION_FN): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingCreateA*(Template: ptr RPC_BINDING_HANDLE_TEMPLATE, Security: ptr RPC_BINDING_HANDLE_SECURITY, Options: ptr RPC_BINDING_HANDLE_OPTIONS, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingCreateW*(Template: ptr RPC_BINDING_HANDLE_TEMPLATE, Security: ptr RPC_BINDING_HANDLE_SECURITY, Options: ptr RPC_BINDING_HANDLE_OPTIONS, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerInqBindingHandle*(Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcNegotiateTransferSyntax*(Message: ptr RPC_MESSAGE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcGetBuffer*(Message: ptr RPC_MESSAGE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcGetBufferWithObject*(Message: ptr RPC_MESSAGE, ObjectUuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcSendReceive*(Message: ptr RPC_MESSAGE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcFreeBuffer*(Message: ptr RPC_MESSAGE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcSend*(Message: PRPC_MESSAGE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcReceive*(Message: PRPC_MESSAGE, Size: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcFreePipeBuffer*(Message: ptr RPC_MESSAGE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcReallocPipeBuffer*(Message: PRPC_MESSAGE, NewSize: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcRequestMutex*(Mutex: ptr I_RPC_MUTEX): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcClearMutex*(Mutex: I_RPC_MUTEX): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcDeleteMutex*(Mutex: I_RPC_MUTEX): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcAllocate*(Size: int32): pointer {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcFree*(Object: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcPauseExecution*(Milliseconds: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcGetExtendedError*(): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcGetCurrentCallHandle*(): RPC_BINDING_HANDLE {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcNsInterfaceExported*(EntryNameSyntax: int32, EntryName: ptr uint16, RpcInterfaceInformation: ptr RPC_SERVER_INTERFACE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcNsInterfaceUnexported*(EntryNameSyntax: int32, EntryName: ptr uint16, RpcInterfaceInformation: ptr RPC_SERVER_INTERFACE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingToStaticStringBindingW*(Binding: RPC_BINDING_HANDLE, StringBinding: ptr ptr uint16): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingInqSecurityContext*(Binding: RPC_BINDING_HANDLE, SecurityContextHandle: ptr pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingInqWireIdForSnego*(Binding: RPC_BINDING_HANDLE, WireId: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingInqMarshalledTargetInfo*(Binding: RPC_BINDING_HANDLE, MarshalledTargetInfoLength: ptr int32, MarshalledTargetInfo: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingInqLocalClientPID*(Binding: RPC_BINDING_HANDLE, Pid: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingHandleToAsyncHandle*(Binding: RPC_BINDING_HANDLE, AsyncHandle: ptr pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcNsBindingSetEntryNameW*(Binding: RPC_BINDING_HANDLE, EntryNameSyntax: int32, EntryName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcNsBindingSetEntryNameA*(Binding: RPC_BINDING_HANDLE, EntryNameSyntax: int32, EntryName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerUseProtseqEp2A*(NetworkAddress: RPC_CSTR, Protseq: RPC_CSTR, MaxCalls: int32, Endpoint: RPC_CSTR, SecurityDescriptor: pointer, Policy: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerUseProtseqEp2W*(NetworkAddress: RPC_WSTR, Protseq: RPC_WSTR, MaxCalls: int32, Endpoint: RPC_WSTR, SecurityDescriptor: pointer, Policy: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerUseProtseq2W*(NetworkAddress: RPC_WSTR, Protseq: RPC_WSTR, MaxCalls: int32, SecurityDescriptor: pointer, Policy: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerUseProtseq2A*(NetworkAddress: RPC_CSTR, Protseq: RPC_CSTR, MaxCalls: int32, SecurityDescriptor: pointer, Policy: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingInqDynamicEndpointW*(Binding: RPC_BINDING_HANDLE, DynamicEndpoint: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingInqDynamicEndpointA*(Binding: RPC_BINDING_HANDLE, DynamicEndpoint: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerCheckClientRestriction*(Context: RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingInqTransportType*(Binding: RPC_BINDING_HANDLE, Type: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcIfInqTransferSyntaxes*(RpcIfHandle: RPC_IF_HANDLE, TransferSyntaxes: ptr RPC_TRANSFER_SYNTAX, TransferSyntaxSize: int32, TransferSyntaxCount: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_UuidCreate*(Uuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingCopy*(SourceBinding: RPC_BINDING_HANDLE, DestinationBinding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcBindingIsClientLocal*(BindingHandle: RPC_BINDING_HANDLE, ClientLocalFlag: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcSsDontSerializeContext*(): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerRegisterForwardFunction*(pForwardFunction: RPC_FORWARD_FUNCTION): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerInqAddressChangeFn*(): RPC_ADDRESS_CHANGE_FN {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerSetAddressChangeFn*(pAddressChangeFn: RPC_ADDRESS_CHANGE_FN): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerInqLocalConnAddress*(Binding: RPC_BINDING_HANDLE, Buffer: pointer, BufferSize: ptr int32, AddressFormat: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcSessionStrictContextHandle*(): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcTurnOnEEInfoPropagation*(): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcServerInqTransportType*(Type: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcMapWin32Status*(Status: RPC_STATUS): LONG32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcRecordCalloutFailure*(RpcStatus: RPC_STATUS, CallOutState: ptr RDR_CALLOUT_STATE, DllName: ptr uint16): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcNsBindingExportA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, BindingVec: ptr RPC_BINDING_VECTOR, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingUnexportA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingExportW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, BindingVec: ptr RPC_BINDING_VECTOR, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingUnexportW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingExportPnPA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjectVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingUnexportPnPA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjectVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingExportPnPW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjectVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingUnexportPnPW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjectVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingLookupBeginA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjUuid: ptr UUID, BindingMaxCount: int32, LookupContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingLookupBeginW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjUuid: ptr UUID, BindingMaxCount: int32, LookupContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingLookupNext*(LookupContext: RPC_NS_HANDLE, BindingVec: ptr ptr RPC_BINDING_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingLookupDone*(LookupContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupDeleteA*(GroupNameSyntax: int32, GroupName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrAddA*(GroupNameSyntax: int32, GroupName: RPC_CSTR, MemberNameSyntax: int32, MemberName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrRemoveA*(GroupNameSyntax: int32, GroupName: RPC_CSTR, MemberNameSyntax: int32, MemberName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqBeginA*(GroupNameSyntax: int32, GroupName: RPC_CSTR, MemberNameSyntax: int32, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqNextA*(InquiryContext: RPC_NS_HANDLE, MemberName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupDeleteW*(GroupNameSyntax: int32, GroupName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrAddW*(GroupNameSyntax: int32, GroupName: RPC_WSTR, MemberNameSyntax: int32, MemberName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrRemoveW*(GroupNameSyntax: int32, GroupName: RPC_WSTR, MemberNameSyntax: int32, MemberName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqBeginW*(GroupNameSyntax: int32, GroupName: RPC_WSTR, MemberNameSyntax: int32, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqNextW*(InquiryContext: RPC_NS_HANDLE, MemberName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqDone*(InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileDeleteA*(ProfileNameSyntax: int32, ProfileName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltAddA*(ProfileNameSyntax: int32, ProfileName: RPC_CSTR, IfId: ptr RPC_IF_ID, MemberNameSyntax: int32, MemberName: RPC_CSTR, Priority: int32, Annotation: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltRemoveA*(ProfileNameSyntax: int32, ProfileName: RPC_CSTR, IfId: ptr RPC_IF_ID, MemberNameSyntax: int32, MemberName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqBeginA*(ProfileNameSyntax: int32, ProfileName: RPC_CSTR, InquiryType: int32, IfId: ptr RPC_IF_ID, VersOption: int32, MemberNameSyntax: int32, MemberName: RPC_CSTR, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqNextA*(InquiryContext: RPC_NS_HANDLE, IfId: ptr RPC_IF_ID, MemberName: ptr RPC_CSTR, Priority: ptr int32, Annotation: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileDeleteW*(ProfileNameSyntax: int32, ProfileName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltAddW*(ProfileNameSyntax: int32, ProfileName: RPC_WSTR, IfId: ptr RPC_IF_ID, MemberNameSyntax: int32, MemberName: RPC_WSTR, Priority: int32, Annotation: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltRemoveW*(ProfileNameSyntax: int32, ProfileName: RPC_WSTR, IfId: ptr RPC_IF_ID, MemberNameSyntax: int32, MemberName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqBeginW*(ProfileNameSyntax: int32, ProfileName: RPC_WSTR, InquiryType: int32, IfId: ptr RPC_IF_ID, VersOption: int32, MemberNameSyntax: int32, MemberName: RPC_WSTR, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqNextW*(InquiryContext: RPC_NS_HANDLE, IfId: ptr RPC_IF_ID, MemberName: ptr RPC_WSTR, Priority: ptr int32, Annotation: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqDone*(InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsEntryObjectInqBeginA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsEntryObjectInqBeginW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsEntryObjectInqNext*(InquiryContext: RPC_NS_HANDLE, ObjUuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsEntryObjectInqDone*(InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsEntryExpandNameA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, ExpandedName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtBindingUnexportA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfId: ptr RPC_IF_ID, VersOption: int32, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryCreateA*(EntryNameSyntax: int32, EntryName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryDeleteA*(EntryNameSyntax: int32, EntryName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryInqIfIdsA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfIdVec: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtHandleSetExpAge*(NsHandle: RPC_NS_HANDLE, ExpirationAge: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtInqExpAge*(ExpirationAge: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtSetExpAge*(ExpirationAge: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsEntryExpandNameW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, ExpandedName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtBindingUnexportW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfId: ptr RPC_IF_ID, VersOption: int32, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryCreateW*(EntryNameSyntax: int32, EntryName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryDeleteW*(EntryNameSyntax: int32, EntryName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryInqIfIdsW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfIdVec: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingImportBeginA*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjUuid: ptr UUID, ImportContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingImportBeginW*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjUuid: ptr UUID, ImportContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingImportNext*(ImportContext: RPC_NS_HANDLE, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingImportDone*(ImportContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcNsBindingSelect*(BindingVec: ptr RPC_BINDING_VECTOR, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc.}
proc RpcAsyncInitializeHandle*(pAsync: PRPC_ASYNC_STATE, Size: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcAsyncRegisterInfo*(pAsync: PRPC_ASYNC_STATE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcAsyncGetCallStatus*(pAsync: PRPC_ASYNC_STATE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcAsyncCompleteCall*(pAsync: PRPC_ASYNC_STATE, Reply: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcAsyncAbortCall*(pAsync: PRPC_ASYNC_STATE, ExceptionCode: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcAsyncCancelCall*(pAsync: PRPC_ASYNC_STATE, fAbort: WINBOOL): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorStartEnumeration*(EnumHandle: ptr RPC_ERROR_ENUM_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorGetNextRecord*(EnumHandle: ptr RPC_ERROR_ENUM_HANDLE, CopyStrings: WINBOOL, ErrorInfo: ptr RPC_EXTENDED_ERROR_INFO): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorEndEnumeration*(EnumHandle: ptr RPC_ERROR_ENUM_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorResetEnumeration*(EnumHandle: ptr RPC_ERROR_ENUM_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorGetNumberOfRecords*(EnumHandle: ptr RPC_ERROR_ENUM_HANDLE, Records: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorSaveErrorInfo*(EnumHandle: ptr RPC_ERROR_ENUM_HANDLE, ErrorBlob: ptr PVOID, BlobSize: ptr int): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorLoadErrorInfo*(ErrorBlob: PVOID, BlobSize: int, EnumHandle: ptr RPC_ERROR_ENUM_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorAddRecord*(ErrorInfo: ptr RPC_EXTENDED_ERROR_INFO): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcErrorClearInformation*(): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcGetAuthorizationContextForClient*(ClientBinding: RPC_BINDING_HANDLE, ImpersonateOnReturn: WINBOOL, Reserved1: PVOID, pExpirationTime: PLARGE_INTEGER, Reserved2: LUID, Reserved3: DWORD, Reserved4: PVOID, pAuthzClientContext: ptr PVOID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcFreeAuthorizationContext*(pAuthzClientContext: ptr PVOID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsContextLockExclusive*(ServerBindingHandle: RPC_BINDING_HANDLE, UserContext: PVOID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcSsContextLockShared*(ServerBindingHandle: RPC_BINDING_HANDLE, UserContext: PVOID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerInqCallAttributesW*(ClientBinding: RPC_BINDING_HANDLE, RpcCallAttributes: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerInqCallAttributesA*(ClientBinding: RPC_BINDING_HANDLE, RpcCallAttributes: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcAsyncSetHandle*(Message: PRPC_MESSAGE, pAsync: PRPC_ASYNC_STATE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcAsyncAbortCall*(pAsync: PRPC_ASYNC_STATE, ExceptionCode: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc I_RpcExceptionFilter*(ExceptionCode: int32): int32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingBind*(pAsync: PRPC_ASYNC_STATE, Binding: RPC_BINDING_HANDLE, IfSpec: RPC_IF_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcBindingUnbind*(Binding: RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerSubscribeForNotification*(Binding: RPC_BINDING_HANDLE, Notification: DWORD, NotificationType: RPC_NOTIFICATION_TYPES, NotificationInfo: ptr RPC_ASYNC_NOTIFICATION_INFO): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcServerUnsubscribeForNotification*(Binding: RPC_BINDING_HANDLE, Notification: RPC_NOTIFICATIONS, NotificationsQueued: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrProxyInitialize*(This: pointer, pRpcMsg: PRPC_MESSAGE, pStubMsg: PMIDL_STUB_MESSAGE, pStubDescriptor: PMIDL_STUB_DESC, ProcNum: int32): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrProxyGetBuffer*(This: pointer, pStubMsg: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrProxySendReceive*(This: pointer, pStubMsg: ptr MIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrProxyFreeBuffer*(This: pointer, pStubMsg: ptr MIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrProxyErrorHandler*(dwExceptionCode: DWORD): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrStubInitialize*(pRpcMsg: PRPC_MESSAGE, pStubMsg: PMIDL_STUB_MESSAGE, pStubDescriptor: PMIDL_STUB_DESC, pRpcChannelBuffer: ptr IRpcChannelBuffer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrStubGetBuffer*(This: ptr IRpcStubBuffer, pRpcChannelBuffer: ptr IRpcChannelBuffer, pStubMsg: PMIDL_STUB_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc CStdStubBuffer_QueryInterface*(This: ptr IRpcStubBuffer, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc CStdStubBuffer_AddRef*(This: ptr IRpcStubBuffer): ULONG {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrCStdStubBuffer_Release*(This: ptr IRpcStubBuffer, pPSF: ptr IPSFactoryBuffer): ULONG {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc CStdStubBuffer_Connect*(This: ptr IRpcStubBuffer, pUnkServer: ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc CStdStubBuffer_Disconnect*(This: ptr IRpcStubBuffer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc CStdStubBuffer_Invoke*(This: ptr IRpcStubBuffer, pRpcMsg: ptr RPCOLEMESSAGE, pRpcChannelBuffer: ptr IRpcChannelBuffer): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc CStdStubBuffer_CountRefs*(This: ptr IRpcStubBuffer): ULONG {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc CStdStubBuffer_DebugServerQueryInterface*(This: ptr IRpcStubBuffer, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc CStdStubBuffer_DebugServerRelease*(This: ptr IRpcStubBuffer, pv: pointer): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrDllGetClassObject*(rclsid: REFCLSID, riid: REFIID, ppv: ptr pointer, pProxyFileList: ptr ptr ProxyFileInfo, pclsid: ptr CLSID, pPSFactoryBuffer: ptr CStdPSFactoryBuffer): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrDllCanUnloadNow*(pPSFactoryBuffer: ptr CStdPSFactoryBuffer): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrDllRegisterProxy*(hDll: HMODULE, pProxyFileList: ptr ptr ProxyFileInfo, pclsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrDllUnregisterProxy*(hDll: HMODULE, pProxyFileList: ptr ptr ProxyFileInfo, pclsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc NdrCStdStubBuffer2_Release*(This: ptr IRpcStubBuffer, pPSF: ptr IPSFactoryBuffer): ULONG {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcCertGeneratePrincipalNameW*(Context: PCCERT_CONTEXT, Flags: DWORD, pBuffer: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc RpcCertGeneratePrincipalNameA*(Context: PCCERT_CONTEXT, Flags: DWORD, pBuffer: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc.}
proc `Level1=`*(self: var NDR_USER_MARSHAL_INFO, x: NDR_USER_MARSHAL_INFO_LEVEL1) {.inline.} = self.union1.Level1 = x
proc Level1*(self: NDR_USER_MARSHAL_INFO): NDR_USER_MARSHAL_INFO_LEVEL1 {.inline.} = self.union1.Level1
proc Level1*(self: var NDR_USER_MARSHAL_INFO): var NDR_USER_MARSHAL_INFO_LEVEL1 {.inline.} = self.union1.Level1
when winimUnicode:
  type
    RPC_PROTSEQ_VECTOR* = RPC_PROTSEQ_VECTORW
    RPC_SECURITY_QOS_V2* = RPC_SECURITY_QOS_V2_W
    PRPC_SECURITY_QOS_V2* = PRPC_SECURITY_QOS_V2_W
    RPC_HTTP_TRANSPORT_CREDENTIALS* = RPC_HTTP_TRANSPORT_CREDENTIALS_W
    PRPC_HTTP_TRANSPORT_CREDENTIALS* = PRPC_HTTP_TRANSPORT_CREDENTIALS_W
    RPC_SECURITY_QOS_V3* = RPC_SECURITY_QOS_V3_W
    PRPC_SECURITY_QOS_V3* = PRPC_SECURITY_QOS_V3_W
    RPC_CALL_LOCAL_ADDRESS_V1* = RPC_CALL_LOCAL_ADDRESS_V1_W
    RPC_CALL_LOCAL_ADDRESS* = RPC_CALL_LOCAL_ADDRESS_W
    RPC_CALL_ATTRIBUTES_V2* = RPC_CALL_ATTRIBUTES_V2_W
  proc RpcBindingFromStringBinding*(StringBinding: RPC_WSTR, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingFromStringBindingW".}
  proc RpcBindingToStringBinding*(Binding: RPC_BINDING_HANDLE, StringBinding: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingToStringBindingW".}
  proc RpcStringBindingCompose*(ObjUuid: RPC_WSTR, Protseq: RPC_WSTR, NetworkAddr: RPC_WSTR, Endpoint: RPC_WSTR, Options: RPC_WSTR, StringBinding: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcStringBindingComposeW".}
  proc RpcStringBindingParse*(StringBinding: RPC_WSTR, ObjUuid: ptr RPC_WSTR, Protseq: ptr RPC_WSTR, NetworkAddr: ptr RPC_WSTR, Endpoint: ptr RPC_WSTR, NetworkOptions: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcStringBindingParseW".}
  proc RpcStringFree*(String: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcStringFreeW".}
  proc RpcNetworkIsProtseqValid*(Protseq: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcNetworkIsProtseqValidW".}
  proc RpcNetworkInqProtseqs*(ProtseqVector: ptr ptr RPC_PROTSEQ_VECTORW): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcNetworkInqProtseqsW".}
  proc RpcProtseqVectorFree*(ProtseqVector: ptr ptr RPC_PROTSEQ_VECTORW): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcProtseqVectorFreeW".}
  proc RpcServerUseProtseq*(Protseq: RPC_WSTR, MaxCalls: int32, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqW".}
  proc RpcServerUseProtseqEx*(Protseq: RPC_WSTR, MaxCalls: int32, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqExW".}
  proc RpcServerUseProtseqEp*(Protseq: RPC_WSTR, MaxCalls: int32, Endpoint: RPC_WSTR, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqEpW".}
  proc RpcServerUseProtseqEpEx*(Protseq: RPC_WSTR, MaxCalls: int32, Endpoint: RPC_WSTR, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqEpExW".}
  proc RpcServerUseProtseqIf*(Protseq: RPC_WSTR, MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqIfW".}
  proc RpcServerUseProtseqIfEx*(Protseq: RPC_WSTR, MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqIfExW".}
  proc RpcMgmtInqServerPrincName*(Binding: RPC_BINDING_HANDLE, AuthnSvc: int32, ServerPrincName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcMgmtInqServerPrincNameW".}
  proc RpcServerInqDefaultPrincName*(AuthnSvc: int32, PrincName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerInqDefaultPrincNameW".}
  proc RpcNsBindingInqEntryName*(Binding: RPC_BINDING_HANDLE, EntryNameSyntax: int32, EntryName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcNsBindingInqEntryNameW".}
  proc RpcBindingInqAuthClient*(ClientBinding: RPC_BINDING_HANDLE, Privs: ptr RPC_AUTHZ_HANDLE, ServerPrincName: ptr RPC_WSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthzSvc: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingInqAuthClientW".}
  proc RpcBindingInqAuthClientEx*(ClientBinding: RPC_BINDING_HANDLE, Privs: ptr RPC_AUTHZ_HANDLE, ServerPrincName: ptr RPC_WSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthzSvc: ptr int32, Flags: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingInqAuthClientExW".}
  proc RpcBindingInqAuthInfo*(Binding: RPC_BINDING_HANDLE, ServerPrincName: ptr RPC_WSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthIdentity: ptr RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingInqAuthInfoW".}
  proc RpcBindingSetAuthInfo*(Binding: RPC_BINDING_HANDLE, ServerPrincName: RPC_WSTR, AuthnLevel: int32, AuthnSvc: int32, AuthIdentity: RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingSetAuthInfoW".}
  proc RpcServerRegisterAuthInfo*(ServerPrincName: RPC_WSTR, AuthnSvc: int32, GetKeyFn: RPC_AUTH_KEY_RETRIEVAL_FN, Arg: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerRegisterAuthInfoW".}
  proc RpcBindingInqAuthInfoEx*(Binding: RPC_BINDING_HANDLE, ServerPrincName: ptr RPC_WSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthIdentity: ptr RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: ptr int32, RpcQosVersion: int32, SecurityQOS: ptr RPC_SECURITY_QOS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingInqAuthInfoExW".}
  proc RpcBindingSetAuthInfoEx*(Binding: RPC_BINDING_HANDLE, ServerPrincName: RPC_WSTR, AuthnLevel: int32, AuthnSvc: int32, AuthIdentity: RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: int32, SecurityQOS: ptr RPC_SECURITY_QOS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingSetAuthInfoExW".}
  proc UuidFromString*(StringUuid: RPC_WSTR, Uuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "UuidFromStringW".}
  proc UuidToString*(Uuid: ptr UUID, StringUuid: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "UuidToStringW".}
  proc RpcEpRegisterNoReplace*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR, Annotation: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcEpRegisterNoReplaceW".}
  proc RpcEpRegister*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR, Annotation: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcEpRegisterW".}
  proc DceErrorInqText*(RpcStatus: RPC_STATUS, ErrorText: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "DceErrorInqTextW".}
  proc RpcMgmtEpEltInqNext*(InquiryContext: RPC_EP_INQ_HANDLE, IfId: ptr RPC_IF_ID, Binding: ptr RPC_BINDING_HANDLE, ObjectUuid: ptr UUID, Annotation: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcMgmtEpEltInqNextW".}
  proc RpcBindingCreate*(Template: ptr RPC_BINDING_HANDLE_TEMPLATE, Security: ptr RPC_BINDING_HANDLE_SECURITY, Options: ptr RPC_BINDING_HANDLE_OPTIONS, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingCreateW".}
  proc I_RpcNsBindingSetEntryName*(Binding: RPC_BINDING_HANDLE, EntryNameSyntax: int32, EntryName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "I_RpcNsBindingSetEntryNameW".}
  proc I_RpcServerUseProtseqEp2*(NetworkAddress: RPC_WSTR, Protseq: RPC_WSTR, MaxCalls: int32, Endpoint: RPC_WSTR, SecurityDescriptor: pointer, Policy: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "I_RpcServerUseProtseqEp2W".}
  proc I_RpcServerUseProtseq2*(NetworkAddress: RPC_WSTR, Protseq: RPC_WSTR, MaxCalls: int32, SecurityDescriptor: pointer, Policy: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "I_RpcServerUseProtseq2W".}
  proc I_RpcBindingInqDynamicEndpoint*(Binding: RPC_BINDING_HANDLE, DynamicEndpoint: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "I_RpcBindingInqDynamicEndpointW".}
  proc RpcNsBindingLookupBegin*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjUuid: ptr UUID, BindingMaxCount: int32, LookupContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingLookupBeginW".}
  proc RpcNsBindingImportBegin*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjUuid: ptr UUID, ImportContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingImportBeginW".}
  proc RpcNsBindingExport*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, BindingVec: ptr RPC_BINDING_VECTOR, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingExportW".}
  proc RpcNsBindingUnexport*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingUnexportW".}
  proc RpcNsGroupDelete*(GroupNameSyntax: int32, GroupName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupDeleteW".}
  proc RpcNsGroupMbrAdd*(GroupNameSyntax: int32, GroupName: RPC_WSTR, MemberNameSyntax: int32, MemberName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupMbrAddW".}
  proc RpcNsGroupMbrRemove*(GroupNameSyntax: int32, GroupName: RPC_WSTR, MemberNameSyntax: int32, MemberName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupMbrRemoveW".}
  proc RpcNsGroupMbrInqBegin*(GroupNameSyntax: int32, GroupName: RPC_WSTR, MemberNameSyntax: int32, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupMbrInqBeginW".}
  proc RpcNsGroupMbrInqNext*(InquiryContext: RPC_NS_HANDLE, MemberName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupMbrInqNextW".}
  proc RpcNsEntryExpandName*(EntryNameSyntax: int32, EntryName: RPC_WSTR, ExpandedName: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsEntryExpandNameW".}
  proc RpcNsEntryObjectInqBegin*(EntryNameSyntax: int32, EntryName: RPC_WSTR, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsEntryObjectInqBeginW".}
  proc RpcNsMgmtBindingUnexport*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfId: ptr RPC_IF_ID, VersOption: int32, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsMgmtBindingUnexportW".}
  proc RpcNsMgmtEntryCreate*(EntryNameSyntax: int32, EntryName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsMgmtEntryCreateW".}
  proc RpcNsMgmtEntryDelete*(EntryNameSyntax: int32, EntryName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsMgmtEntryDeleteW".}
  proc RpcNsMgmtEntryInqIfIds*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfIdVec: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsMgmtEntryInqIfIdsW".}
  proc RpcNsProfileDelete*(ProfileNameSyntax: int32, ProfileName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileDeleteW".}
  proc RpcNsProfileEltAdd*(ProfileNameSyntax: int32, ProfileName: RPC_WSTR, IfId: ptr RPC_IF_ID, MemberNameSyntax: int32, MemberName: RPC_WSTR, Priority: int32, Annotation: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileEltAddW".}
  proc RpcNsProfileEltRemove*(ProfileNameSyntax: int32, ProfileName: RPC_WSTR, IfId: ptr RPC_IF_ID, MemberNameSyntax: int32, MemberName: RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileEltRemoveW".}
  proc RpcNsProfileEltInqBegin*(ProfileNameSyntax: int32, ProfileName: RPC_WSTR, InquiryType: int32, IfId: ptr RPC_IF_ID, VersOption: int32, MemberNameSyntax: int32, MemberName: RPC_WSTR, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileEltInqBeginW".}
  proc RpcNsProfileEltInqNext*(InquiryContext: RPC_NS_HANDLE, IfId: ptr RPC_IF_ID, MemberName: ptr RPC_WSTR, Priority: ptr int32, Annotation: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileEltInqNextW".}
  proc RpcNsBindingExportPnP*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjectVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingExportPnPW".}
  proc RpcNsBindingUnexportPnP*(EntryNameSyntax: int32, EntryName: RPC_WSTR, IfSpec: RPC_IF_HANDLE, ObjectVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingUnexportPnPW".}
  proc RpcServerInqCallAttributes*(ClientBinding: RPC_BINDING_HANDLE, RpcCallAttributes: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerInqCallAttributesW".}
  proc RpcCertGeneratePrincipalName*(Context: PCCERT_CONTEXT, Flags: DWORD, pBuffer: ptr RPC_WSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcCertGeneratePrincipalNameW".}
when winimAnsi:
  type
    RPC_PROTSEQ_VECTOR* = RPC_PROTSEQ_VECTORA
    RPC_SECURITY_QOS_V2* = RPC_SECURITY_QOS_V2_A
    PRPC_SECURITY_QOS_V2* = PRPC_SECURITY_QOS_V2_A
    RPC_HTTP_TRANSPORT_CREDENTIALS* = RPC_HTTP_TRANSPORT_CREDENTIALS_A
    PRPC_HTTP_TRANSPORT_CREDENTIALS* = PRPC_HTTP_TRANSPORT_CREDENTIALS_A
    RPC_SECURITY_QOS_V3* = RPC_SECURITY_QOS_V3_A
    PRPC_SECURITY_QOS_V3* = PRPC_SECURITY_QOS_V3_A
    RPC_CALL_LOCAL_ADDRESS_V1* = RPC_CALL_LOCAL_ADDRESS_V1_A
    RPC_CALL_LOCAL_ADDRESS* = RPC_CALL_LOCAL_ADDRESS_A
    RPC_CALL_ATTRIBUTES_V2* = RPC_CALL_ATTRIBUTES_V2_A
  proc RpcBindingFromStringBinding*(StringBinding: RPC_CSTR, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingFromStringBindingA".}
  proc RpcBindingToStringBinding*(Binding: RPC_BINDING_HANDLE, StringBinding: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingToStringBindingA".}
  proc RpcStringBindingCompose*(ObjUuid: RPC_CSTR, Protseq: RPC_CSTR, NetworkAddr: RPC_CSTR, Endpoint: RPC_CSTR, Options: RPC_CSTR, StringBinding: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcStringBindingComposeA".}
  proc RpcStringBindingParse*(StringBinding: RPC_CSTR, ObjUuid: ptr RPC_CSTR, Protseq: ptr RPC_CSTR, NetworkAddr: ptr RPC_CSTR, Endpoint: ptr RPC_CSTR, NetworkOptions: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcStringBindingParseA".}
  proc RpcStringFree*(String: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcStringFreeA".}
  proc RpcNetworkIsProtseqValid*(Protseq: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcNetworkIsProtseqValidA".}
  proc RpcNetworkInqProtseqs*(ProtseqVector: ptr ptr RPC_PROTSEQ_VECTORA): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcNetworkInqProtseqsA".}
  proc RpcProtseqVectorFree*(ProtseqVector: ptr ptr RPC_PROTSEQ_VECTORA): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcProtseqVectorFreeA".}
  proc RpcServerUseProtseq*(Protseq: RPC_CSTR, MaxCalls: int32, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqA".}
  proc RpcServerUseProtseqEx*(Protseq: RPC_CSTR, MaxCalls: int32, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqExA".}
  proc RpcServerUseProtseqEp*(Protseq: RPC_CSTR, MaxCalls: int32, Endpoint: RPC_CSTR, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqEpA".}
  proc RpcServerUseProtseqEpEx*(Protseq: RPC_CSTR, MaxCalls: int32, Endpoint: RPC_CSTR, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqEpExA".}
  proc RpcServerUseProtseqIf*(Protseq: RPC_CSTR, MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqIfA".}
  proc RpcServerUseProtseqIfEx*(Protseq: RPC_CSTR, MaxCalls: int32, IfSpec: RPC_IF_HANDLE, SecurityDescriptor: pointer, Policy: PRPC_POLICY): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerUseProtseqIfExA".}
  proc RpcMgmtInqServerPrincName*(Binding: RPC_BINDING_HANDLE, AuthnSvc: int32, ServerPrincName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcMgmtInqServerPrincNameA".}
  proc RpcServerInqDefaultPrincName*(AuthnSvc: int32, PrincName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerInqDefaultPrincNameA".}
  proc RpcNsBindingInqEntryName*(Binding: RPC_BINDING_HANDLE, EntryNameSyntax: int32, EntryName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcNsBindingInqEntryNameA".}
  proc RpcBindingInqAuthClient*(ClientBinding: RPC_BINDING_HANDLE, Privs: ptr RPC_AUTHZ_HANDLE, ServerPrincName: ptr RPC_CSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthzSvc: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingInqAuthClientA".}
  proc RpcBindingInqAuthClientEx*(ClientBinding: RPC_BINDING_HANDLE, Privs: ptr RPC_AUTHZ_HANDLE, ServerPrincName: ptr RPC_CSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthzSvc: ptr int32, Flags: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingInqAuthClientExA".}
  proc RpcBindingInqAuthInfo*(Binding: RPC_BINDING_HANDLE, ServerPrincName: ptr RPC_CSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthIdentity: ptr RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: ptr int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingInqAuthInfoA".}
  proc RpcBindingSetAuthInfo*(Binding: RPC_BINDING_HANDLE, ServerPrincName: RPC_CSTR, AuthnLevel: int32, AuthnSvc: int32, AuthIdentity: RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: int32): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingSetAuthInfoA".}
  proc RpcServerRegisterAuthInfo*(ServerPrincName: RPC_CSTR, AuthnSvc: int32, GetKeyFn: RPC_AUTH_KEY_RETRIEVAL_FN, Arg: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerRegisterAuthInfoA".}
  proc RpcBindingInqAuthInfoEx*(Binding: RPC_BINDING_HANDLE, ServerPrincName: ptr RPC_CSTR, AuthnLevel: ptr int32, AuthnSvc: ptr int32, AuthIdentity: ptr RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: ptr int32, RpcQosVersion: int32, SecurityQOS: ptr RPC_SECURITY_QOS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingInqAuthInfoExA".}
  proc RpcBindingSetAuthInfoEx*(Binding: RPC_BINDING_HANDLE, ServerPrincName: RPC_CSTR, AuthnLevel: int32, AuthnSvc: int32, AuthIdentity: RPC_AUTH_IDENTITY_HANDLE, AuthzSvc: int32, SecurityQos: ptr RPC_SECURITY_QOS): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingSetAuthInfoExA".}
  proc UuidFromString*(StringUuid: RPC_CSTR, Uuid: ptr UUID): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "UuidFromStringA".}
  proc UuidToString*(Uuid: ptr UUID, StringUuid: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "UuidToStringA".}
  proc RpcEpRegisterNoReplace*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR, Annotation: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcEpRegisterNoReplaceA".}
  proc RpcEpRegister*(IfSpec: RPC_IF_HANDLE, BindingVector: ptr RPC_BINDING_VECTOR, UuidVector: ptr UUID_VECTOR, Annotation: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcEpRegisterA".}
  proc DceErrorInqText*(RpcStatus: RPC_STATUS, ErrorText: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "DceErrorInqTextA".}
  proc RpcMgmtEpEltInqNext*(InquiryContext: RPC_EP_INQ_HANDLE, IfId: ptr RPC_IF_ID, Binding: ptr RPC_BINDING_HANDLE, ObjectUuid: ptr UUID, Annotation: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcMgmtEpEltInqNextA".}
  proc RpcBindingCreate*(Template: ptr RPC_BINDING_HANDLE_TEMPLATE, Security: ptr RPC_BINDING_HANDLE_SECURITY, Options: ptr RPC_BINDING_HANDLE_OPTIONS, Binding: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcBindingCreateA".}
  proc I_RpcNsBindingSetEntryName*(Binding: RPC_BINDING_HANDLE, EntryNameSyntax: int32, EntryName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "I_RpcNsBindingSetEntryNameA".}
  proc I_RpcServerUseProtseqEp2*(NetworkAddress: RPC_CSTR, Protseq: RPC_CSTR, MaxCalls: int32, Endpoint: RPC_CSTR, SecurityDescriptor: pointer, Policy: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "I_RpcServerUseProtseqEp2A".}
  proc I_RpcServerUseProtseq2*(NetworkAddress: RPC_CSTR, Protseq: RPC_CSTR, MaxCalls: int32, SecurityDescriptor: pointer, Policy: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "I_RpcServerUseProtseq2A".}
  proc I_RpcBindingInqDynamicEndpoint*(Binding: RPC_BINDING_HANDLE, DynamicEndpoint: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "I_RpcBindingInqDynamicEndpointA".}
  proc RpcNsBindingLookupBegin*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjUuid: ptr UUID, BindingMaxCount: int32, LookupContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingLookupBeginA".}
  proc RpcNsBindingImportBegin*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjUuid: ptr UUID, ImportContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingImportBeginA".}
  proc RpcNsBindingExport*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, BindingVec: ptr RPC_BINDING_VECTOR, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingExportA".}
  proc RpcNsBindingUnexport*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingUnexportA".}
  proc RpcNsGroupDelete*(GroupNameSyntax: int32, GroupName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupDeleteA".}
  proc RpcNsGroupMbrAdd*(GroupNameSyntax: int32, GroupName: RPC_CSTR, MemberNameSyntax: int32, MemberName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupMbrAddA".}
  proc RpcNsGroupMbrRemove*(GroupNameSyntax: int32, GroupName: RPC_CSTR, MemberNameSyntax: int32, MemberName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupMbrRemoveA".}
  proc RpcNsGroupMbrInqBegin*(GroupNameSyntax: int32, GroupName: RPC_CSTR, MemberNameSyntax: int32, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupMbrInqBeginA".}
  proc RpcNsGroupMbrInqNext*(InquiryContext: RPC_NS_HANDLE, MemberName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsGroupMbrInqNextA".}
  proc RpcNsEntryExpandName*(EntryNameSyntax: int32, EntryName: RPC_CSTR, ExpandedName: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsEntryExpandNameA".}
  proc RpcNsEntryObjectInqBegin*(EntryNameSyntax: int32, EntryName: RPC_CSTR, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsEntryObjectInqBeginA".}
  proc RpcNsMgmtBindingUnexport*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfId: ptr RPC_IF_ID, VersOption: int32, ObjectUuidVec: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsMgmtBindingUnexportA".}
  proc RpcNsMgmtEntryCreate*(EntryNameSyntax: int32, EntryName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsMgmtEntryCreateA".}
  proc RpcNsMgmtEntryDelete*(EntryNameSyntax: int32, EntryName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsMgmtEntryDeleteA".}
  proc RpcNsMgmtEntryInqIfIds*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfIdVec: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsMgmtEntryInqIfIdsA".}
  proc RpcNsProfileDelete*(ProfileNameSyntax: int32, ProfileName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileDeleteA".}
  proc RpcNsProfileEltAdd*(ProfileNameSyntax: int32, ProfileName: RPC_CSTR, IfId: ptr RPC_IF_ID, MemberNameSyntax: int32, MemberName: RPC_CSTR, Priority: int32, Annotation: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileEltAddA".}
  proc RpcNsProfileEltRemove*(ProfileNameSyntax: int32, ProfileName: RPC_CSTR, IfId: ptr RPC_IF_ID, MemberNameSyntax: int32, MemberName: RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileEltRemoveA".}
  proc RpcNsProfileEltInqBegin*(ProfileNameSyntax: int32, ProfileName: RPC_CSTR, InquiryType: int32, IfId: ptr RPC_IF_ID, VersOption: int32, MemberNameSyntax: int32, MemberName: RPC_CSTR, InquiryContext: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileEltInqBeginA".}
  proc RpcNsProfileEltInqNext*(InquiryContext: RPC_NS_HANDLE, IfId: ptr RPC_IF_ID, MemberName: ptr RPC_CSTR, Priority: ptr int32, Annotation: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsProfileEltInqNextA".}
  proc RpcNsBindingExportPnP*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjectVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingExportPnPA".}
  proc RpcNsBindingUnexportPnP*(EntryNameSyntax: int32, EntryName: RPC_CSTR, IfSpec: RPC_IF_HANDLE, ObjectVector: ptr UUID_VECTOR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcns4", importc: "RpcNsBindingUnexportPnPA".}
  proc RpcServerInqCallAttributes*(ClientBinding: RPC_BINDING_HANDLE, RpcCallAttributes: pointer): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcServerInqCallAttributesA".}
  proc RpcCertGeneratePrincipalName*(Context: PCCERT_CONTEXT, Flags: DWORD, pBuffer: ptr RPC_CSTR): RPC_STATUS {.winapi, stdcall, dynlib: "rpcrt4", importc: "RpcCertGeneratePrincipalNameA".}
when winimCpu64:
  proc Ndr64AsyncServerCall64*(pRpcMsg: PRPC_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
  proc Ndr64AsyncServerCallAll*(pRpcMsg: PRPC_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
  proc Ndr64DcomAsyncStubCall*(pThis: ptr IRpcStubBuffer, pChannel: ptr IRpcChannelBuffer, pRpcMsg: PRPC_MESSAGE, pdwStubPhase: ptr int32): LONG32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
  proc NdrStubCall3*(pThis: ptr IRpcStubBuffer, pChannel: ptr IRpcChannelBuffer, pRpcMsg: PRPC_MESSAGE, pdwStubPhase: ptr int32): LONG32 {.winapi, stdcall, dynlib: "rpcrt4", importc.}
  proc NdrServerCallAll*(pRpcMsg: PRPC_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
  proc NdrServerCallNdr64*(pRpcMsg: PRPC_MESSAGE): void {.winapi, stdcall, dynlib: "rpcrt4", importc.}
