#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import winuser
import objbase
import commctrl
#include <aclapi.h>
#include <accctrl.h>
#include <aclui.h>
#include <authz.h>
#include <adtgen.h>
type
  SE_OBJECT_TYPE* = int32
  TRUSTEE_TYPE* = int32
  TRUSTEE_FORM* = int32
  MULTIPLE_TRUSTEE_OPERATION* = int32
  ACCESS_MODE* = int32
  PROG_INVOKE_SETTING* = int32
  PPROG_INVOKE_SETTING* = ptr int32
  AUDIT_PARAM_TYPE* = int32
  AUTHZ_SECURITY_ATTRIBUTE_OPERATION* = int32
  PAUTHZ_SECURITY_ATTRIBUTE_OPERATION* = ptr int32
  AUTHZ_SID_OPERATION* = int32
  PAUTHZ_SID_OPERATION* = ptr int32
  AUTHZ_CONTEXT_INFORMATION_CLASS* = int32
  AUTHZ_AUDIT_EVENT_INFORMATION_CLASS* = int32
  SI_PAGE_TYPE* = int32
  SI_PAGE_ACTIVATED* = int32
  ACCESS_RIGHTS* = ULONG
  PACCESS_RIGHTS* = ptr ULONG
  INHERIT_FLAGS* = ULONG
  PINHERIT_FLAGS* = ptr ULONG
  AUDIT_HANDLE* = PVOID
  PAUDIT_HANDLE* = ptr PVOID
  AUTHZ_ACCESS_CHECK_RESULTS_HANDLE* = HANDLE
  AUTHZ_CLIENT_CONTEXT_HANDLE* = HANDLE
  AUTHZ_RESOURCE_MANAGER_HANDLE* = HANDLE
  AUTHZ_AUDIT_EVENT_HANDLE* = HANDLE
  AUTHZ_AUDIT_EVENT_TYPE_HANDLE* = HANDLE
  AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE* = HANDLE
  AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE* = HANDLE
  OBJECTS_AND_SID* {.pure.} = object
    ObjectsPresent*: DWORD
    ObjectTypeGuid*: GUID
    InheritedObjectTypeGuid*: GUID
    pSid*: ptr SID
  POBJECTS_AND_SID* = ptr OBJECTS_AND_SID
  OBJECTS_AND_NAME_A* {.pure.} = object
    ObjectsPresent*: DWORD
    ObjectType*: SE_OBJECT_TYPE
    ObjectTypeName*: LPSTR
    InheritedObjectTypeName*: LPSTR
    ptstrName*: LPSTR
  POBJECTS_AND_NAME_A* = ptr OBJECTS_AND_NAME_A
  OBJECTS_AND_NAME_W* {.pure.} = object
    ObjectsPresent*: DWORD
    ObjectType*: SE_OBJECT_TYPE
    ObjectTypeName*: LPWSTR
    InheritedObjectTypeName*: LPWSTR
    ptstrName*: LPWSTR
  POBJECTS_AND_NAME_W* = ptr OBJECTS_AND_NAME_W
  TRUSTEE_A* {.pure.} = object
    pMultipleTrustee*: ptr TRUSTEE_A
    MultipleTrusteeOperation*: MULTIPLE_TRUSTEE_OPERATION
    TrusteeForm*: TRUSTEE_FORM
    TrusteeType*: TRUSTEE_TYPE
    ptstrName*: LPSTR
  PTRUSTEE_A* = ptr TRUSTEE_A
  TRUSTEE_W* {.pure.} = object
    pMultipleTrustee*: ptr TRUSTEE_W
    MultipleTrusteeOperation*: MULTIPLE_TRUSTEE_OPERATION
    TrusteeForm*: TRUSTEE_FORM
    TrusteeType*: TRUSTEE_TYPE
    ptstrName*: LPWSTR
  PTRUSTEE_W* = ptr TRUSTEE_W
  EXPLICIT_ACCESS_A* {.pure.} = object
    grfAccessPermissions*: DWORD
    grfAccessMode*: ACCESS_MODE
    grfInheritance*: DWORD
    Trustee*: TRUSTEE_A
  PEXPLICIT_ACCESS_A* = ptr EXPLICIT_ACCESS_A
  EXPLICIT_ACCESS_W* {.pure.} = object
    grfAccessPermissions*: DWORD
    grfAccessMode*: ACCESS_MODE
    grfInheritance*: DWORD
    Trustee*: TRUSTEE_W
  PEXPLICIT_ACCESS_W* = ptr EXPLICIT_ACCESS_W
  ACTRL_ACCESS_ENTRYA* {.pure.} = object
    Trustee*: TRUSTEE_A
    fAccessFlags*: ULONG
    Access*: ACCESS_RIGHTS
    ProvSpecificAccess*: ACCESS_RIGHTS
    Inheritance*: INHERIT_FLAGS
    lpInheritProperty*: LPSTR
  PACTRL_ACCESS_ENTRYA* = ptr ACTRL_ACCESS_ENTRYA
  ACTRL_ACCESS_ENTRYW* {.pure.} = object
    Trustee*: TRUSTEE_W
    fAccessFlags*: ULONG
    Access*: ACCESS_RIGHTS
    ProvSpecificAccess*: ACCESS_RIGHTS
    Inheritance*: INHERIT_FLAGS
    lpInheritProperty*: LPWSTR
  PACTRL_ACCESS_ENTRYW* = ptr ACTRL_ACCESS_ENTRYW
  ACTRL_ACCESS_ENTRY_LISTA* {.pure.} = object
    cEntries*: ULONG
    pAccessList*: ptr ACTRL_ACCESS_ENTRYA
  PACTRL_ACCESS_ENTRY_LISTA* = ptr ACTRL_ACCESS_ENTRY_LISTA
  ACTRL_ACCESS_ENTRY_LISTW* {.pure.} = object
    cEntries*: ULONG
    pAccessList*: ptr ACTRL_ACCESS_ENTRYW
  PACTRL_ACCESS_ENTRY_LISTW* = ptr ACTRL_ACCESS_ENTRY_LISTW
  ACTRL_PROPERTY_ENTRYA* {.pure.} = object
    lpProperty*: LPSTR
    pAccessEntryList*: PACTRL_ACCESS_ENTRY_LISTA
    fListFlags*: ULONG
  PACTRL_PROPERTY_ENTRYA* = ptr ACTRL_PROPERTY_ENTRYA
  ACTRL_PROPERTY_ENTRYW* {.pure.} = object
    lpProperty*: LPWSTR
    pAccessEntryList*: PACTRL_ACCESS_ENTRY_LISTW
    fListFlags*: ULONG
  PACTRL_PROPERTY_ENTRYW* = ptr ACTRL_PROPERTY_ENTRYW
  ACTRL_ACCESSA* {.pure.} = object
    cEntries*: ULONG
    pPropertyAccessList*: PACTRL_PROPERTY_ENTRYA
  PACTRL_ACCESSA* = ptr ACTRL_ACCESSA
  ACTRL_AUDITA* = ACTRL_ACCESSA
  PACTRL_AUDITA* = ptr ACTRL_ACCESSA
  ACTRL_ACCESSW* {.pure.} = object
    cEntries*: ULONG
    pPropertyAccessList*: PACTRL_PROPERTY_ENTRYW
  PACTRL_ACCESSW* = ptr ACTRL_ACCESSW
  ACTRL_AUDITW* = ACTRL_ACCESSW
  PACTRL_AUDITW* = ptr ACTRL_ACCESSW
  TRUSTEE_ACCESSA* {.pure.} = object
    lpProperty*: LPSTR
    Access*: ACCESS_RIGHTS
    fAccessFlags*: ULONG
    fReturnedAccess*: ULONG
  PTRUSTEE_ACCESSA* = ptr TRUSTEE_ACCESSA
  TRUSTEE_ACCESSW* {.pure.} = object
    lpProperty*: LPWSTR
    Access*: ACCESS_RIGHTS
    fAccessFlags*: ULONG
    fReturnedAccess*: ULONG
  PTRUSTEE_ACCESSW* = ptr TRUSTEE_ACCESSW
  ACTRL_OVERLAPPED_UNION1* {.pure, union.} = object
    Provider*: PVOID
    Reserved1*: ULONG
  ACTRL_OVERLAPPED* {.pure.} = object
    union1*: ACTRL_OVERLAPPED_UNION1
    Reserved2*: ULONG
    hEvent*: HANDLE
  PACTRL_OVERLAPPED* = ptr ACTRL_OVERLAPPED
  ACTRL_ACCESS_INFOA* {.pure.} = object
    fAccessPermission*: ULONG
    lpAccessPermissionName*: LPSTR
  PACTRL_ACCESS_INFOA* = ptr ACTRL_ACCESS_INFOA
  ACTRL_ACCESS_INFOW* {.pure.} = object
    fAccessPermission*: ULONG
    lpAccessPermissionName*: LPWSTR
  PACTRL_ACCESS_INFOW* = ptr ACTRL_ACCESS_INFOW
  ACTRL_CONTROL_INFOA* {.pure.} = object
    lpControlId*: LPSTR
    lpControlName*: LPSTR
  PACTRL_CONTROL_INFOA* = ptr ACTRL_CONTROL_INFOA
  ACTRL_CONTROL_INFOW* {.pure.} = object
    lpControlId*: LPWSTR
    lpControlName*: LPWSTR
  PACTRL_CONTROL_INFOW* = ptr ACTRL_CONTROL_INFOW
  FN_OBJECT_MGR_FUNCTS* {.pure.} = object
    Placeholder*: ULONG
  PFN_OBJECT_MGR_FUNCTS* = ptr FN_OBJECT_MGR_FUNCTS
  INHERITED_FROMA* {.pure.} = object
    GenerationGap*: LONG
    AncestorName*: LPSTR
  PINHERITED_FROMA* = ptr INHERITED_FROMA
  INHERITED_FROMW* {.pure.} = object
    GenerationGap*: LONG
    AncestorName*: LPWSTR
  PINHERITED_FROMW* = ptr INHERITED_FROMW
  AUDIT_OBJECT_TYPE* {.pure.} = object
    ObjectType*: GUID
    Flags*: USHORT
    Level*: USHORT
    AccessMask*: ACCESS_MASK
  PAUDIT_OBJECT_TYPE* = ptr AUDIT_OBJECT_TYPE
  AUDIT_OBJECT_TYPES* {.pure.} = object
    Count*: USHORT
    Flags*: USHORT
    pObjectTypes*: ptr AUDIT_OBJECT_TYPE
  PAUDIT_OBJECT_TYPES* = ptr AUDIT_OBJECT_TYPES
const
  AUTHZ_SS_MAXSIZE* = 128
type
  AUDIT_IP_ADDRESS* {.pure.} = object
    pIpAddress*: array[AUTHZ_SS_MAXSIZE, BYTE]
  PAUDIT_IP_ADDRESS* = ptr AUDIT_IP_ADDRESS
  AUDIT_PARAM_UNION1* {.pure, union.} = object
    Data0*: ULONG_PTR
    Str*: PWSTR
    u*: ULONG_PTR
    psid*: ptr SID
    pguid*: ptr GUID
    LogonId_LowPart*: ULONG
    pObjectTypes*: ptr AUDIT_OBJECT_TYPES
    pIpAddress*: ptr AUDIT_IP_ADDRESS
  AUDIT_PARAM_UNION2* {.pure, union.} = object
    Data1*: ULONG_PTR
    LogonId_HighPart*: LONG
  AUDIT_PARAM* {.pure.} = object
    Type*: AUDIT_PARAM_TYPE
    Length*: ULONG
    Flags*: DWORD
    union1*: AUDIT_PARAM_UNION1
    union2*: AUDIT_PARAM_UNION2
  PAUDIT_PARAM* = ptr AUDIT_PARAM
  AUDIT_PARAMS* {.pure.} = object
    Length*: ULONG
    Flags*: DWORD
    Count*: USHORT
    Parameters*: ptr AUDIT_PARAM
  PAUDIT_PARAMS* = ptr AUDIT_PARAMS
  AUTHZ_AUDIT_EVENT_TYPE_LEGACY* {.pure.} = object
    CategoryId*: USHORT
    AuditId*: USHORT
    ParameterCount*: USHORT
  PAUTHZ_AUDIT_EVENT_TYPE_LEGACY* = ptr AUTHZ_AUDIT_EVENT_TYPE_LEGACY
  AUTHZ_AUDIT_EVENT_TYPE_UNION* {.pure, union.} = object
    Legacy*: AUTHZ_AUDIT_EVENT_TYPE_LEGACY
  PAUTHZ_AUDIT_EVENT_TYPE_UNION* = ptr AUTHZ_AUDIT_EVENT_TYPE_UNION
  AUTHZ_AUDIT_EVENT_TYPE_OLD* {.pure.} = object
    Version*: ULONG
    dwFlags*: DWORD
    RefCount*: LONG
    hAudit*: ULONG_PTR
    LinkId*: LUID
    u*: AUTHZ_AUDIT_EVENT_TYPE_UNION
  PAUTHZ_AUDIT_EVENT_TYPE_OLD* = ptr AUTHZ_AUDIT_EVENT_TYPE_OLD
  PAUTHZ_ACCESS_CHECK_RESULTS_HANDLE* = ptr AUTHZ_ACCESS_CHECK_RESULTS_HANDLE
  PAUTHZ_CLIENT_CONTEXT_HANDLE* = ptr AUTHZ_CLIENT_CONTEXT_HANDLE
  PAUTHZ_RESOURCE_MANAGER_HANDLE* = ptr AUTHZ_RESOURCE_MANAGER_HANDLE
  PAUTHZ_AUDIT_EVENT_HANDLE* = ptr AUTHZ_AUDIT_EVENT_HANDLE
  PAUTHZ_AUDIT_EVENT_TYPE_HANDLE* = ptr AUTHZ_AUDIT_EVENT_TYPE_HANDLE
  PAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE* = ptr AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE
  PAUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE* = ptr AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE
  AUTHZ_ACCESS_REQUEST* {.pure.} = object
    DesiredAccess*: ACCESS_MASK
    PrincipalSelfSid*: PSID
    ObjectTypeList*: POBJECT_TYPE_LIST
    ObjectTypeListLength*: DWORD
    OptionalArguments*: PVOID
  PAUTHZ_ACCESS_REQUEST* = ptr AUTHZ_ACCESS_REQUEST
  AUTHZ_ACCESS_REPLY* {.pure.} = object
    ResultListLength*: DWORD
    GrantedAccessMask*: PACCESS_MASK
    SaclEvaluationResults*: PDWORD
    Error*: PDWORD
  PAUTHZ_ACCESS_REPLY* = ptr AUTHZ_ACCESS_REPLY
  AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE* {.pure.} = object
    Version*: ULONG64
    pName*: PWSTR
  PAUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE* = ptr AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE
  AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE* {.pure.} = object
    pValue*: PVOID
    ValueLength*: ULONG
  PAUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE* = ptr AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
  AUTHZ_SECURITY_ATTRIBUTE_V1_Values* {.pure, union.} = object
    pInt64*: PLONG64
    pUint64*: PULONG64
    ppString*: ptr PWSTR
    pFqbn*: PAUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE
    pOctetString*: PAUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
  AUTHZ_SECURITY_ATTRIBUTE_V1* {.pure.} = object
    pName*: PWSTR
    ValueType*: USHORT
    Reserved*: USHORT
    Flags*: ULONG
    ValueCount*: ULONG
    Values*: AUTHZ_SECURITY_ATTRIBUTE_V1_Values
  PAUTHZ_SECURITY_ATTRIBUTE_V1* = ptr AUTHZ_SECURITY_ATTRIBUTE_V1
  AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_Attribute* {.pure, union.} = object
    pAttributeV1*: PAUTHZ_SECURITY_ATTRIBUTE_V1
  AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* {.pure.} = object
    Version*: USHORT
    Reserved*: USHORT
    AttributeCount*: ULONG
    Attribute*: AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_Attribute
  PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION* = ptr AUTHZ_SECURITY_ATTRIBUTES_INFORMATION
  AUTHZ_RPC_INIT_INFO_CLIENT* {.pure.} = object
    version*: USHORT
    ObjectUuid*: PWSTR
    ProtSeq*: PWSTR
    NetworkAddr*: PWSTR
    Endpoint*: PWSTR
    Options*: PWSTR
    ServerSpn*: PWSTR
  PAUTHZ_RPC_INIT_INFO_CLIENT* = ptr AUTHZ_RPC_INIT_INFO_CLIENT
  PFN_AUTHZ_DYNAMIC_ACCESS_CHECK* = proc (hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, pAce: PACE_HEADER, pArgs: PVOID, pbAceApplicable: PBOOL): WINBOOL {.stdcall.}
  PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS* = proc (hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, Args: PVOID, pSidAttrArray: ptr PSID_AND_ATTRIBUTES, pSidCount: PDWORD, pRestrictedSidAttrArray: ptr PSID_AND_ATTRIBUTES, pRestrictedSidCount: PDWORD): WINBOOL {.stdcall.}
  PFN_AUTHZ_FREE_DYNAMIC_GROUPS* = proc (pSidAttrArray: PSID_AND_ATTRIBUTES): VOID {.stdcall.}
  PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY* = proc (hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, capid: PSID, pArgs: PVOID, pCentralAccessPolicyApplicable: PBOOL, ppCentralAccessPolicy: ptr PVOID): WINBOOL {.stdcall.}
  PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY* = proc (pCentralAccessPolicy: PVOID): VOID {.stdcall.}
  AUTHZ_INIT_INFO* {.pure.} = object
    version*: USHORT
    szResourceManagerName*: PCWSTR
    pfnDynamicAccessCheck*: PFN_AUTHZ_DYNAMIC_ACCESS_CHECK
    pfnComputeDynamicGroups*: PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS
    pfnFreeDynamicGroups*: PFN_AUTHZ_FREE_DYNAMIC_GROUPS
    pfnGetCentralAccessPolicy*: PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY
    pfnFreeCentralAccessPolicy*: PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY
  PAUTHZ_INIT_INFO* = ptr AUTHZ_INIT_INFO
  AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET* {.pure.} = object
    szObjectTypeName*: PWSTR
    dwOffset*: DWORD
  PAUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET* = ptr AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET
  AUTHZ_SOURCE_SCHEMA_REGISTRATION_UNION1* {.pure, union.} = object
    pReserved*: PVOID
    pProviderGuid*: ptr GUID
  AUTHZ_SOURCE_SCHEMA_REGISTRATION* {.pure.} = object
    dwFlags*: DWORD
    szEventSourceName*: PWSTR
    szEventMessageFile*: PWSTR
    szEventSourceXmlSchemaFile*: PWSTR
    szEventAccessStringsFile*: PWSTR
    szExecutableImagePath*: PWSTR
    union1*: AUTHZ_SOURCE_SCHEMA_REGISTRATION_UNION1
    dwObjectTypeNameCount*: DWORD
    ObjectTypeNames*: array[ANYSIZE_ARRAY, AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET]
  PAUTHZ_SOURCE_SCHEMA_REGISTRATION* = ptr AUTHZ_SOURCE_SCHEMA_REGISTRATION
  SI_OBJECT_INFO* {.pure.} = object
    dwFlags*: DWORD
    hInstance*: HINSTANCE
    pszServerName*: LPWSTR
    pszObjectName*: LPWSTR
    pszPageTitle*: LPWSTR
    guidObjectType*: GUID
  PSI_OBJECT_INFO* = ptr SI_OBJECT_INFO
  SI_ACCESS* {.pure.} = object
    pguid*: ptr GUID
    mask*: ACCESS_MASK
    pszName*: LPCWSTR
    dwFlags*: DWORD
  PSI_ACCESS* = ptr SI_ACCESS
  SI_INHERIT_TYPE* {.pure.} = object
    pguid*: ptr GUID
    dwFlags*: ULONG
    pszName*: LPCWSTR
  PSI_INHERIT_TYPE* = ptr SI_INHERIT_TYPE
  ISecurityInformation* {.pure.} = object
    lpVtbl*: ptr ISecurityInformationVtbl
  ISecurityInformationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetObjectInformation*: proc(self: ptr ISecurityInformation, pObjectInfo: PSI_OBJECT_INFO): HRESULT {.stdcall.}
    GetSecurity*: proc(self: ptr ISecurityInformation, RequestedInformation: SECURITY_INFORMATION, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR, fDefault: WINBOOL): HRESULT {.stdcall.}
    SetSecurity*: proc(self: ptr ISecurityInformation, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): HRESULT {.stdcall.}
    GetAccessRights*: proc(self: ptr ISecurityInformation, pguidObjectType: ptr GUID, dwFlags: DWORD, ppAccess: ptr PSI_ACCESS, pcAccesses: ptr ULONG, piDefaultAccess: ptr ULONG): HRESULT {.stdcall.}
    MapGeneric*: proc(self: ptr ISecurityInformation, pguidObjectType: ptr GUID, pAceFlags: ptr UCHAR, pMask: ptr ACCESS_MASK): HRESULT {.stdcall.}
    GetInheritTypes*: proc(self: ptr ISecurityInformation, ppInheritTypes: ptr PSI_INHERIT_TYPE, pcInheritTypes: ptr ULONG): HRESULT {.stdcall.}
    PropertySheetPageCallback*: proc(self: ptr ISecurityInformation, hwnd: HWND, uMsg: UINT, uPage: SI_PAGE_TYPE): HRESULT {.stdcall.}
  LPSECURITYINFO* = ptr ISecurityInformation
  ISecurityInformation2* {.pure.} = object
    lpVtbl*: ptr ISecurityInformation2Vtbl
  ISecurityInformation2Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IsDaclCanonical*: proc(self: ptr ISecurityInformation2, pDacl: PACL): WINBOOL {.stdcall.}
    LookupSids*: proc(self: ptr ISecurityInformation2, cSids: ULONG, rgpSids: ptr PSID, ppdo: ptr LPDATAOBJECT): HRESULT {.stdcall.}
  LPSECURITYINFO2* = ptr ISecurityInformation2
  SID_INFO* {.pure.} = object
    pSid*: PSID
    pwzCommonName*: PWSTR
    pwzClass*: PWSTR
    pwzUPN*: PWSTR
  PSID_INFO* = ptr SID_INFO
  SID_INFO_LIST* {.pure.} = object
    cItems*: ULONG
    aSidInfo*: array[ANYSIZE_ARRAY, SID_INFO]
  PSID_INFO_LIST* = ptr SID_INFO_LIST
  IEffectivePermission* {.pure.} = object
    lpVtbl*: ptr IEffectivePermissionVtbl
  IEffectivePermissionVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetEffectivePermission*: proc(self: ptr IEffectivePermission, pguidObjectType: ptr GUID, pUserSid: PSID, pszServerName: LPCWSTR, pSD: PSECURITY_DESCRIPTOR, ppObjectTypeList: ptr POBJECT_TYPE_LIST, pcObjectTypeListLength: ptr ULONG, ppGrantedAccessList: ptr PACCESS_MASK, pcGrantedAccessListLength: ptr ULONG): HRESULT {.stdcall.}
  LPEFFECTIVEPERMISSION* = ptr IEffectivePermission
when winimUnicode:
  type
    PINHERITED_FROM* = PINHERITED_FROMW
when winimAnsi:
  type
    PINHERITED_FROM* = PINHERITED_FROMA
type
  ISecurityObjectTypeInfo* {.pure.} = object
    lpVtbl*: ptr ISecurityObjectTypeInfoVtbl
  ISecurityObjectTypeInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetInheritSource*: proc(self: ptr ISecurityObjectTypeInfo, si: SECURITY_INFORMATION, pACL: PACL, ppInheritArray: ptr PINHERITED_FROM): HRESULT {.stdcall.}
  LPSecurityObjectTypeInfo* = ptr ISecurityObjectTypeInfo
  ISecurityInformation3* {.pure.} = object
    lpVtbl*: ptr ISecurityInformation3Vtbl
  ISecurityInformation3Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetFullResourceName*: proc(self: ptr ISecurityInformation3, ppszResourceName: ptr LPWSTR): HRESULT {.stdcall.}
    OpenElevatedEditor*: proc(self: ptr ISecurityInformation3, hWnd: HWND, uPage: SI_PAGE_TYPE): HRESULT {.stdcall.}
  LPSECURITYINFO3* = ptr ISecurityInformation3
  SECURITY_OBJECT* {.pure.} = object
    pwszName*: PWSTR
    pData*: PVOID
    cbData*: DWORD
    pData2*: PVOID
    cbData2*: DWORD
    Id*: DWORD
    fWellKnown*: BOOLEAN
  PSECURITY_OBJECT* = ptr SECURITY_OBJECT
  EFFPERM_RESULT_LIST* {.pure.} = object
    fEvaluated*: BOOLEAN
    cObjectTypeListLength*: ULONG
    pObjectTypeList*: ptr OBJECT_TYPE_LIST
    pGrantedAccessList*: ptr ACCESS_MASK
  PEFFPERM_RESULT_LIST* = ptr EFFPERM_RESULT_LIST
  ISecurityInformation4* {.pure.} = object
    lpVtbl*: ptr ISecurityInformation4Vtbl
  ISecurityInformation4Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSecondarySecurity*: proc(self: ptr ISecurityInformation4, pSecurityObjects: ptr PSECURITY_OBJECT, pSecurityObjectCount: PULONG): HRESULT {.stdcall.}
  LPSECURITYINFO4* = ptr ISecurityInformation4
  IEffectivePermission2* {.pure.} = object
    lpVtbl*: ptr IEffectivePermission2Vtbl
  IEffectivePermission2Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ComputeEffectivePermissionWithSecondarySecurity*: proc(self: ptr IEffectivePermission2, pSid: PSID, pDeviceSid: PSID, pszServerName: PCWSTR, pSecurityObjects: PSECURITY_OBJECT, dwSecurityObjectCount: DWORD, pUserGroups: PTOKEN_GROUPS, pAuthzUserGroupsOperations: PAUTHZ_SID_OPERATION, pDeviceGroups: PTOKEN_GROUPS, pAuthzDeviceGroupsOperations: PAUTHZ_SID_OPERATION, pAuthzUserClaims: PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION, pAuthzUserClaimsOperations: PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, pAuthzDeviceClaims: PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION, pAuthzDeviceClaimsOperations: PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, pEffpermResultLists: PEFFPERM_RESULT_LIST): HRESULT {.stdcall.}
  LPEFFECTIVEPERMISSION2* = ptr IEffectivePermission2
const
  SE_UNKNOWN_OBJECT_TYPE* = 0
  SE_FILE_OBJECT* = 1
  SE_SERVICE* = 2
  SE_PRINTER* = 3
  SE_REGISTRY_KEY* = 4
  SE_LMSHARE* = 5
  SE_KERNEL_OBJECT* = 6
  SE_WINDOW_OBJECT* = 7
  SE_DS_OBJECT* = 8
  SE_DS_OBJECT_ALL* = 9
  SE_PROVIDER_DEFINED_OBJECT* = 10
  SE_WMIGUID_OBJECT* = 11
  SE_REGISTRY_WOW64_32KEY* = 12
  TRUSTEE_IS_UNKNOWN* = 0
  TRUSTEE_IS_USER* = 1
  TRUSTEE_IS_GROUP* = 2
  TRUSTEE_IS_DOMAIN* = 3
  TRUSTEE_IS_ALIAS* = 4
  TRUSTEE_IS_WELL_KNOWN_GROUP* = 5
  TRUSTEE_IS_DELETED* = 6
  TRUSTEE_IS_INVALID* = 7
  TRUSTEE_IS_COMPUTER* = 8
  TRUSTEE_IS_SID* = 0
  TRUSTEE_IS_NAME* = 1
  TRUSTEE_BAD_FORM* = 2
  TRUSTEE_IS_OBJECTS_AND_SID* = 3
  TRUSTEE_IS_OBJECTS_AND_NAME* = 4
  NO_MULTIPLE_TRUSTEE* = 0
  TRUSTEE_IS_IMPERSONATE* = 1
  NOT_USED_ACCESS* = 0
  GRANT_ACCESS* = 1
  SET_ACCESS* = 2
  DENY_ACCESS* = 3
  REVOKE_ACCESS* = 4
  SET_AUDIT_SUCCESS* = 5
  SET_AUDIT_FAILURE* = 6
  NO_INHERITANCE* = 0x0
  SUB_OBJECTS_ONLY_INHERIT* = 0x1
  SUB_CONTAINERS_ONLY_INHERIT* = 0x2
  SUB_CONTAINERS_AND_OBJECTS_INHERIT* = 0x3
  INHERIT_NO_PROPAGATE* = 0x4
  INHERIT_ONLY* = 0x8
  INHERITED_ACCESS_ENTRY* = 0x10
  INHERITED_PARENT* = 0x10000000
  INHERITED_GRANDPARENT* = 0x20000000
  ACCCTRL_DEFAULT_PROVIDERA* = "Windows NT Access Provider"
  ACCCTRL_DEFAULT_PROVIDERW* = "Windows NT Access Provider"
  TRUSTEE_ACCESS_ALLOWED* = 0x1
  TRUSTEE_ACCESS_READ* = 0x2
  TRUSTEE_ACCESS_WRITE* = 0x4
  TRUSTEE_ACCESS_EXPLICIT* = 0x1
  TRUSTEE_ACCESS_READ_WRITE* = TRUSTEE_ACCESS_READ or TRUSTEE_ACCESS_WRITE
  TRUSTEE_ACCESS_ALL* = 0xffffffff'i32
  ACTRL_RESERVED* = 0x00000000
  ACTRL_PERM_1* = 0x00000001
  ACTRL_PERM_2* = 0x00000002
  ACTRL_PERM_3* = 0x00000004
  ACTRL_PERM_4* = 0x00000008
  ACTRL_PERM_5* = 0x00000010
  ACTRL_PERM_6* = 0x00000020
  ACTRL_PERM_7* = 0x00000040
  ACTRL_PERM_8* = 0x00000080
  ACTRL_PERM_9* = 0x00000100
  ACTRL_PERM_10* = 0x00000200
  ACTRL_PERM_11* = 0x00000400
  ACTRL_PERM_12* = 0x00000800
  ACTRL_PERM_13* = 0x00001000
  ACTRL_PERM_14* = 0x00002000
  ACTRL_PERM_15* = 0x00004000
  ACTRL_PERM_16* = 0x00008000
  ACTRL_PERM_17* = 0x00010000
  ACTRL_PERM_18* = 0x00020000
  ACTRL_PERM_19* = 0x00040000
  ACTRL_PERM_20* = 0x00080000
  ACTRL_ACCESS_ALLOWED* = 0x00000001
  ACTRL_ACCESS_DENIED* = 0x00000002
  ACTRL_AUDIT_SUCCESS* = 0x00000004
  ACTRL_AUDIT_FAILURE* = 0x00000008
  ACTRL_ACCESS_PROTECTED* = 0x00000001
  ACTRL_SYSTEM_ACCESS* = 0x04000000
  ACTRL_DELETE* = 0x08000000
  ACTRL_READ_CONTROL* = 0x10000000
  ACTRL_CHANGE_ACCESS* = 0x20000000
  ACTRL_CHANGE_OWNER* = 0x40000000
  ACTRL_SYNCHRONIZE* = 0x80000000'i32
  ACTRL_STD_RIGHTS_ALL* = 0xf8000000'i32
  ACTRL_STD_RIGHT_REQUIRED* = ACTRL_STD_RIGHTS_ALL and not ACTRL_SYNCHRONIZE
  ACTRL_DS_OPEN* = ACTRL_RESERVED
  ACTRL_DS_CREATE_CHILD* = ACTRL_PERM_1
  ACTRL_DS_DELETE_CHILD* = ACTRL_PERM_2
  ACTRL_DS_LIST* = ACTRL_PERM_3
  ACTRL_DS_SELF* = ACTRL_PERM_4
  ACTRL_DS_READ_PROP* = ACTRL_PERM_5
  ACTRL_DS_WRITE_PROP* = ACTRL_PERM_6
  ACTRL_DS_DELETE_TREE* = ACTRL_PERM_7
  ACTRL_DS_LIST_OBJECT* = ACTRL_PERM_8
  ACTRL_DS_CONTROL_ACCESS* = ACTRL_PERM_9
  ACTRL_FILE_READ* = ACTRL_PERM_1
  ACTRL_FILE_WRITE* = ACTRL_PERM_2
  ACTRL_FILE_APPEND* = ACTRL_PERM_3
  ACTRL_FILE_READ_PROP* = ACTRL_PERM_4
  ACTRL_FILE_WRITE_PROP* = ACTRL_PERM_5
  ACTRL_FILE_EXECUTE* = ACTRL_PERM_6
  ACTRL_FILE_READ_ATTRIB* = ACTRL_PERM_8
  ACTRL_FILE_WRITE_ATTRIB* = ACTRL_PERM_9
  ACTRL_FILE_CREATE_PIPE* = ACTRL_PERM_10
  ACTRL_DIR_LIST* = ACTRL_PERM_1
  ACTRL_DIR_CREATE_OBJECT* = ACTRL_PERM_2
  ACTRL_DIR_CREATE_CHILD* = ACTRL_PERM_3
  ACTRL_DIR_DELETE_CHILD* = ACTRL_PERM_7
  ACTRL_DIR_TRAVERSE* = ACTRL_PERM_6
  ACTRL_KERNEL_TERMINATE* = ACTRL_PERM_1
  ACTRL_KERNEL_THREAD* = ACTRL_PERM_2
  ACTRL_KERNEL_VM* = ACTRL_PERM_3
  ACTRL_KERNEL_VM_READ* = ACTRL_PERM_4
  ACTRL_KERNEL_VM_WRITE* = ACTRL_PERM_5
  ACTRL_KERNEL_DUP_HANDLE* = ACTRL_PERM_6
  ACTRL_KERNEL_PROCESS* = ACTRL_PERM_7
  ACTRL_KERNEL_SET_INFO* = ACTRL_PERM_8
  ACTRL_KERNEL_GET_INFO* = ACTRL_PERM_9
  ACTRL_KERNEL_CONTROL* = ACTRL_PERM_10
  ACTRL_KERNEL_ALERT* = ACTRL_PERM_11
  ACTRL_KERNEL_GET_CONTEXT* = ACTRL_PERM_12
  ACTRL_KERNEL_SET_CONTEXT* = ACTRL_PERM_13
  ACTRL_KERNEL_TOKEN* = ACTRL_PERM_14
  ACTRL_KERNEL_IMPERSONATE* = ACTRL_PERM_15
  ACTRL_KERNEL_DIMPERSONATE* = ACTRL_PERM_16
  ACTRL_PRINT_SADMIN* = ACTRL_PERM_1
  ACTRL_PRINT_SLIST* = ACTRL_PERM_2
  ACTRL_PRINT_PADMIN* = ACTRL_PERM_3
  ACTRL_PRINT_PUSE* = ACTRL_PERM_4
  ACTRL_PRINT_JADMIN* = ACTRL_PERM_5
  ACTRL_SVC_GET_INFO* = ACTRL_PERM_1
  ACTRL_SVC_SET_INFO* = ACTRL_PERM_2
  ACTRL_SVC_STATUS* = ACTRL_PERM_3
  ACTRL_SVC_LIST* = ACTRL_PERM_4
  ACTRL_SVC_START* = ACTRL_PERM_5
  ACTRL_SVC_STOP* = ACTRL_PERM_6
  ACTRL_SVC_PAUSE* = ACTRL_PERM_7
  ACTRL_SVC_INTERROGATE* = ACTRL_PERM_8
  ACTRL_SVC_UCONTROL* = ACTRL_PERM_9
  ACTRL_REG_QUERY* = ACTRL_PERM_1
  ACTRL_REG_SET* = ACTRL_PERM_2
  ACTRL_REG_CREATE_CHILD* = ACTRL_PERM_3
  ACTRL_REG_LIST* = ACTRL_PERM_4
  ACTRL_REG_NOTIFY* = ACTRL_PERM_5
  ACTRL_REG_LINK* = ACTRL_PERM_6
  ACTRL_WIN_CLIPBRD* = ACTRL_PERM_1
  ACTRL_WIN_GLOBAL_ATOMS* = ACTRL_PERM_2
  ACTRL_WIN_CREATE* = ACTRL_PERM_3
  ACTRL_WIN_LIST_DESK* = ACTRL_PERM_4
  ACTRL_WIN_LIST* = ACTRL_PERM_5
  ACTRL_WIN_READ_ATTRIBS* = ACTRL_PERM_6
  ACTRL_WIN_WRITE_ATTRIBS* = ACTRL_PERM_7
  ACTRL_WIN_SCREEN* = ACTRL_PERM_8
  ACTRL_WIN_EXIT* = ACTRL_PERM_9
  ACTRL_ACCESS_NO_OPTIONS* = 0x0
  ACTRL_ACCESS_SUPPORTS_OBJECT_ENTRIES* = 0x1
  TREE_SEC_INFO_SET* = 0x00000001
  TREE_SEC_INFO_RESET* = 0x00000002
  TREE_SEC_INFO_RESET_KEEP_EXPLICIT* = 0x00000003
  progressInvokeNever* = 1
  progressInvokeEveryObject* = 2
  progressInvokeOnError* = 3
  progressCancelOperation* = 4
  progressRetryOperation* = 5
  progressInvokePrePostError* = 6
  AUDIT_TYPE_LEGACY* = 1
  AUDIT_TYPE_WMI* = 2
  APT_None* = 1
  APT_String* = 2
  APT_Ulong* = 3
  APT_Pointer* = 4
  APT_Sid* = 5
  APT_LogonId* = 6
  APT_ObjectTypeList* = 7
  APT_Luid* = 8
  APT_Guid* = 9
  APT_Time* = 10
  APT_Int64* = 11
  APT_IpAddress* = 12
  APT_LogonIdWithSid* = 13
  AP_ParamTypeBits* = 8
  AP_ParamTypeMask* = 0xff
  AP_FormatHex* = 0x1 shl AP_ParamTypeBits
  AP_AccessMask* = 0x2 shl AP_ParamTypeBits
  AP_Filespec* = 0x1 shl AP_ParamTypeBits
  AP_SidAsLogonId* = 0x1 shl AP_ParamTypeBits
  AP_PrimaryLogonId* = 0x1 shl AP_ParamTypeBits
  AP_ClientLogonId* = 0x2 shl AP_ParamTypeBits
  APF_AuditFailure* = 0x0
  APF_AuditSuccess* = 0x1
  APF_ValidFlags* = APF_AuditSuccess
  AUTHZ_ALLOW_MULTIPLE_SOURCE_INSTANCES* = 0x1
  AUTHZ_MIGRATED_LEGACY_PUBLISHER* = 0x2
  AUTHZ_AUDIT_INSTANCE_INFORMATION* = 0x2
  AUTHZP_WPD_EVENT* = 0x10
  AUTHZ_SKIP_TOKEN_GROUPS* = 0x2
  AUTHZ_REQUIRE_S4U_LOGON* = 0x4
  AUTHZ_COMPUTE_PRIVILEGES* = 0x8
  AUTHZ_GENERATE_SUCCESS_AUDIT* = 0x1
  AUTHZ_GENERATE_FAILURE_AUDIT* = 0x2
  AUTHZ_SECURITY_ATTRIBUTE_TYPE_INVALID* = 0x00
  AUTHZ_SECURITY_ATTRIBUTE_TYPE_INT64* = 0x01
  AUTHZ_SECURITY_ATTRIBUTE_TYPE_UINT64* = 0x02
  AUTHZ_SECURITY_ATTRIBUTE_TYPE_STRING* = 0x03
  AUTHZ_SECURITY_ATTRIBUTE_TYPE_FQBN* = 0x04
  AUTHZ_SECURITY_ATTRIBUTE_TYPE_SID* = 0x05
  AUTHZ_SECURITY_ATTRIBUTE_TYPE_BOOLEAN* = 0x06
  AUTHZ_SECURITY_ATTRIBUTE_TYPE_OCTET_STRING* = 0x10
  AUTHZ_SECURITY_ATTRIBUTE_OPERATION_NONE* = 0
  AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE_ALL* = 1
  AUTHZ_SECURITY_ATTRIBUTE_OPERATION_ADD* = 2
  AUTHZ_SECURITY_ATTRIBUTE_OPERATION_DELETE* = 3
  AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE* = 4
  AUTHZ_SID_OPERATION_NONE* = 0
  AUTHZ_SID_OPERATION_REPLACE_ALL* = 1
  AUTHZ_SID_OPERATION_ADD* = 2
  AUTHZ_SID_OPERATION_DELETE* = 3
  AUTHZ_SID_OPERATION_REPLACE* = 4
  AUTHZ_SECURITY_ATTRIBUTE_NON_INHERITABLE* = 0x1
  AUTHZ_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE* = 0x2
  AUTHZ_SECURITY_ATTRIBUTE_VALID_FLAGS* = AUTHZ_SECURITY_ATTRIBUTE_NON_INHERITABLE or AUTHZ_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE
  AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1* = 1
  AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_VERSION* = AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1
  AUTHZ_ACCESS_CHECK_NO_DEEP_COPY_SD* = 0x1
  AUTHZ_RM_FLAG_NO_AUDIT* = 0x1
  AUTHZ_RM_FLAG_INITIALIZE_UNDER_IMPERSONATION* = 0x2
  AUTHZ_RM_FLAG_NO_CENTRAL_ACCESS_POLICIES* = 0x4
  AUTHZ_VALID_RM_INIT_FLAGS* = AUTHZ_RM_FLAG_NO_AUDIT or AUTHZ_RM_FLAG_INITIALIZE_UNDER_IMPERSONATION or AUTHZ_RM_FLAG_NO_CENTRAL_ACCESS_POLICIES
  AUTHZ_RPC_INIT_INFO_CLIENT_VERSION_V1* = 1
  AUTHZ_INIT_INFO_VERSION_V1* = 1
  authzContextInfoUserSid* = 1
  authzContextInfoGroupsSids* = 2
  authzContextInfoRestrictedSids* = 3
  authzContextInfoPrivileges* = 4
  authzContextInfoExpirationTime* = 5
  authzContextInfoServerContext* = 6
  authzContextInfoIdentifier* = 7
  authzContextInfoSource* = 8
  authzContextInfoAll* = 9
  authzContextInfoAuthenticationId* = 10
  authzContextInfoSecurityAttributes* = 11
  authzContextInfoDeviceSids* = 12
  authzContextInfoUserClaims* = 13
  authzContextInfoDeviceClaims* = 14
  authzContextInfoAppContainerSid* = 15
  authzContextInfoCapabilitySids* = 16
  AUTHZ_NO_SUCCESS_AUDIT* = 0x1
  AUTHZ_NO_FAILURE_AUDIT* = 0x2
  AUTHZ_NO_ALLOC_STRINGS* = 0x4
  AUTHZ_WPD_CATEGORY_FLAG* = 0x10
  AUTHZ_VALID_OBJECT_ACCESS_AUDIT_FLAGS* = AUTHZ_NO_SUCCESS_AUDIT or AUTHZ_NO_FAILURE_AUDIT or AUTHZ_NO_ALLOC_STRINGS or AUTHZ_WPD_CATEGORY_FLAG
  authzAuditEventInfoFlags* = 1
  authzAuditEventInfoOperationType* = 2
  authzAuditEventInfoObjectType* = 3
  authzAuditEventInfoObjectName* = 4
  authzAuditEventInfoAdditionalInfo* = 5
  AUTHZ_FLAG_ALLOW_MULTIPLE_SOURCE_INSTANCES* = 0x1
  SI_EDIT_PERMS* = 0x00000000
  SI_EDIT_OWNER* = 0x00000001
  SI_EDIT_AUDITS* = 0x00000002
  SI_CONTAINER* = 0x00000004
  SI_READONLY* = 0x00000008
  SI_ADVANCED* = 0x00000010
  SI_RESET* = 0x00000020
  SI_OWNER_READONLY* = 0x00000040
  SI_EDIT_PROPERTIES* = 0x00000080
  SI_OWNER_RECURSE* = 0x00000100
  SI_NO_ACL_PROTECT* = 0x00000200
  SI_NO_TREE_APPLY* = 0x00000400
  SI_PAGE_TITLE* = 0x00000800
  SI_SERVER_IS_DC* = 0x00001000
  SI_RESET_DACL_TREE* = 0x00004000
  SI_RESET_SACL_TREE* = 0x00008000
  SI_OBJECT_GUID* = 0x00010000
  SI_EDIT_EFFECTIVE* = 0x00020000
  SI_RESET_DACL* = 0x00040000
  SI_RESET_SACL* = 0x00080000
  SI_RESET_OWNER* = 0x00100000
  SI_NO_ADDITIONAL_PERMISSION* = 0x00200000
  SI_VIEW_ONLY* = 0x00400000
  SI_PERMS_ELEVATION_REQUIRED* = 0x01000000
  SI_AUDITS_ELEVATION_REQUIRED* = 0x02000000
  SI_OWNER_ELEVATION_REQUIRED* = 0x04000000
  SI_SCOPE_ELEVATION_REQUIRED* = 0x08000000
  SI_MAY_WRITE* = 0x10000000
  SI_ENABLE_EDIT_ATTRIBUTE_CONDITION* = 0x20000000
  SI_ENABLE_CENTRAL_POLICY* = 0x40000000
  SI_DISABLE_DENY_ACE* = 0x80000000'i32
  SI_EDIT_ALL* = SI_EDIT_PERMS or SI_EDIT_OWNER or SI_EDIT_AUDITS
  SI_ACCESS_SPECIFIC* = 0x00010000
  SI_ACCESS_GENERAL* = 0x00020000
  SI_ACCESS_CONTAINER* = 0x00040000
  SI_ACCESS_PROPERTY* = 0x00080000
  SI_PAGE_PERM* = 0
  SI_PAGE_ADVPERM* = 1
  SI_PAGE_AUDIT* = 2
  SI_PAGE_OWNER* = 3
  SI_PAGE_EFFECTIVE* = 4
  SI_PAGE_TAKEOWNERSHIP* = 5
  SI_PAGE_SHARE* = 6
  SI_SHOW_DEFAULT* = 0
  SI_SHOW_PERM_ACTIVATED* = 1
  SI_SHOW_AUDIT_ACTIVATED* = 2
  SI_SHOW_OWNER_ACTIVATED* = 3
  SI_SHOW_EFFECTIVE_ACTIVATED* = 4
  SI_SHOW_SHARE_ACTIVATED* = 5
  SI_SHOW_CENTRAL_POLICY_ACTIVATED* = 6
  DOBJ_RES_CONT* = 0x00000001
  DOBJ_RES_ROOT* = 0x00000002
  DOBJ_VOL_NTACLS* = 0x00000004
  DOBJ_COND_NTACLS* = 0x00000008
  DOBJ_RIBBON_LAUNCH* = 0x00000010
  PSPCB_SI_INITDIALOG* = WM_USER+1
  IID_ISecurityInformation* = DEFINE_GUID("965fc360-16ff-11d0-91cb-00aa00bbb723")
  IID_ISecurityInformation2* = DEFINE_GUID("c3ccfdb4-6f88-11d2-a3ce-00c04fb1782a")
  CFSTR_ACLUI_SID_INFO_LIST* = "CFSTR_ACLUI_SID_INFO_LIST"
  IID_IEffectivePermission* = DEFINE_GUID("3853dc76-9f35-407c-88a1-d19344365fbc")
  IID_ISecurityObjectTypeInfo* = DEFINE_GUID("fc3066eb-79ef-444b-9111-d18a75ebf2fa")
  IID_ISecurityInformation3* = DEFINE_GUID("e2cdc9cc-31bd-4f8f-8c8b-b641af516a1a")
  SECURITY_OBJECT_ID_OBJECT_SD* = 1
  SECURITY_OBJECT_ID_SHARE* = 2
  SECURITY_OBJECT_ID_CENTRAL_POLICY* = 3
  SECURITY_OBJECT_ID_CENTRAL_ACCESS_RULE* = 4
  IID_ISecurityInformation4* = DEFINE_GUID("ea961070-cd14-4621-ace4-f63c03e583e4")
  IID_IEffectivePermission2* = DEFINE_GUID("941fabca-dd47-4fca-90bb-b0e10255f20d")
type
  FN_PROGRESS* = proc (pObjectName: LPWSTR, Status: DWORD, pInvokeSetting: PPROG_INVOKE_SETTING, Args: PVOID, SecuritySet: WINBOOL): VOID {.stdcall.}
proc SetEntriesInAclA*(cCountOfExplicitEntries: ULONG, pListOfExplicitEntries: PEXPLICIT_ACCESS_A, OldAcl: PACL, NewAcl: ptr PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetEntriesInAclW*(cCountOfExplicitEntries: ULONG, pListOfExplicitEntries: PEXPLICIT_ACCESS_W, OldAcl: PACL, NewAcl: ptr PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetExplicitEntriesFromAclA*(pacl: PACL, pcCountOfExplicitEntries: PULONG, pListOfExplicitEntries: ptr PEXPLICIT_ACCESS_A): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetExplicitEntriesFromAclW*(pacl: PACL, pcCountOfExplicitEntries: PULONG, pListOfExplicitEntries: ptr PEXPLICIT_ACCESS_W): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetEffectiveRightsFromAclA*(pacl: PACL, pTrustee: PTRUSTEE_A, pAccessRights: PACCESS_MASK): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetEffectiveRightsFromAclW*(pacl: PACL, pTrustee: PTRUSTEE_W, pAccessRights: PACCESS_MASK): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetAuditedPermissionsFromAclA*(pacl: PACL, pTrustee: PTRUSTEE_A, pSuccessfulAuditedRights: PACCESS_MASK, pFailedAuditRights: PACCESS_MASK): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetAuditedPermissionsFromAclW*(pacl: PACL, pTrustee: PTRUSTEE_W, pSuccessfulAuditedRights: PACCESS_MASK, pFailedAuditRights: PACCESS_MASK): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetNamedSecurityInfoA*(pObjectName: LPCSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, ppsidOwner: ptr PSID, ppsidGroup: ptr PSID, ppDacl: ptr PACL, ppSacl: ptr PACL, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetNamedSecurityInfoW*(pObjectName: LPCWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, ppsidOwner: ptr PSID, ppsidGroup: ptr PSID, ppDacl: ptr PACL, ppSacl: ptr PACL, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSecurityInfo*(handle: HANDLE, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, ppsidOwner: ptr PSID, ppsidGroup: ptr PSID, ppDacl: ptr PACL, ppSacl: ptr PACL, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetNamedSecurityInfoA*(pObjectName: LPSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, psidOwner: PSID, psidGroup: PSID, pDacl: PACL, pSacl: PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetNamedSecurityInfoW*(pObjectName: LPWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, psidOwner: PSID, psidGroup: PSID, pDacl: PACL, pSacl: PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetSecurityInfo*(handle: HANDLE, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, psidOwner: PSID, psidGroup: PSID, pDacl: PACL, pSacl: PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetInheritanceSourceA*(pObjectName: LPSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, Container: WINBOOL, pObjectClassGuids: ptr ptr GUID, GuidCount: DWORD, pAcl: PACL, pfnArray: PFN_OBJECT_MGR_FUNCTS, pGenericMapping: PGENERIC_MAPPING, pInheritArray: PINHERITED_FROMA): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetInheritanceSourceW*(pObjectName: LPWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, Container: WINBOOL, pObjectClassGuids: ptr ptr GUID, GuidCount: DWORD, pAcl: PACL, pfnArray: PFN_OBJECT_MGR_FUNCTS, pGenericMapping: PGENERIC_MAPPING, pInheritArray: PINHERITED_FROMW): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc FreeInheritedFromArray*(pInheritArray: PINHERITED_FROMW, AceCnt: USHORT, pfnArray: PFN_OBJECT_MGR_FUNCTS): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc TreeResetNamedSecurityInfoA*(pObjectName: LPSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, pOwner: PSID, pGroup: PSID, pDacl: PACL, pSacl: PACL, KeepExplicit: WINBOOL, fnProgress: FN_PROGRESS, ProgressInvokeSetting: PROG_INVOKE_SETTING, Args: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc TreeResetNamedSecurityInfoW*(pObjectName: LPWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, pOwner: PSID, pGroup: PSID, pDacl: PACL, pSacl: PACL, KeepExplicit: WINBOOL, fnProgress: FN_PROGRESS, ProgressInvokeSetting: PROG_INVOKE_SETTING, Args: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildSecurityDescriptorA*(pOwner: PTRUSTEE_A, pGroup: PTRUSTEE_A, cCountOfAccessEntries: ULONG, pListOfAccessEntries: PEXPLICIT_ACCESS_A, cCountOfAuditEntries: ULONG, pListOfAuditEntries: PEXPLICIT_ACCESS_A, pOldSD: PSECURITY_DESCRIPTOR, pSizeNewSD: PULONG, pNewSD: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildSecurityDescriptorW*(pOwner: PTRUSTEE_W, pGroup: PTRUSTEE_W, cCountOfAccessEntries: ULONG, pListOfAccessEntries: PEXPLICIT_ACCESS_W, cCountOfAuditEntries: ULONG, pListOfAuditEntries: PEXPLICIT_ACCESS_W, pOldSD: PSECURITY_DESCRIPTOR, pSizeNewSD: PULONG, pNewSD: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupSecurityDescriptorPartsA*(ppOwner: ptr PTRUSTEE_A, ppGroup: ptr PTRUSTEE_A, pcCountOfAccessEntries: PULONG, ppListOfAccessEntries: ptr PEXPLICIT_ACCESS_A, pcCountOfAuditEntries: PULONG, ppListOfAuditEntries: ptr PEXPLICIT_ACCESS_A, pSD: PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupSecurityDescriptorPartsW*(ppOwner: ptr PTRUSTEE_W, ppGroup: ptr PTRUSTEE_W, pcCountOfAccessEntries: PULONG, ppListOfAccessEntries: ptr PEXPLICIT_ACCESS_W, pcCountOfAuditEntries: PULONG, ppListOfAuditEntries: ptr PEXPLICIT_ACCESS_W, pSD: PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildExplicitAccessWithNameA*(pExplicitAccess: PEXPLICIT_ACCESS_A, pTrusteeName: LPSTR, AccessPermissions: DWORD, AccessMode: ACCESS_MODE, Inheritance: DWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildExplicitAccessWithNameW*(pExplicitAccess: PEXPLICIT_ACCESS_W, pTrusteeName: LPWSTR, AccessPermissions: DWORD, AccessMode: ACCESS_MODE, Inheritance: DWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildImpersonateExplicitAccessWithNameA*(pExplicitAccess: PEXPLICIT_ACCESS_A, pTrusteeName: LPSTR, pTrustee: PTRUSTEE_A, AccessPermissions: DWORD, AccessMode: ACCESS_MODE, Inheritance: DWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildImpersonateExplicitAccessWithNameW*(pExplicitAccess: PEXPLICIT_ACCESS_W, pTrusteeName: LPWSTR, pTrustee: PTRUSTEE_W, AccessPermissions: DWORD, AccessMode: ACCESS_MODE, Inheritance: DWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildTrusteeWithNameA*(pTrustee: PTRUSTEE_A, pName: LPSTR): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildTrusteeWithNameW*(pTrustee: PTRUSTEE_W, pName: LPWSTR): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildImpersonateTrusteeA*(pTrustee: PTRUSTEE_A, pImpersonateTrustee: PTRUSTEE_A): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildImpersonateTrusteeW*(pTrustee: PTRUSTEE_W, pImpersonateTrustee: PTRUSTEE_W): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildTrusteeWithSidA*(pTrustee: PTRUSTEE_A, pSid: PSID): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildTrusteeWithSidW*(pTrustee: PTRUSTEE_W, pSid: PSID): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildTrusteeWithObjectsAndSidA*(pTrustee: PTRUSTEE_A, pObjSid: POBJECTS_AND_SID, pObjectGuid: ptr GUID, pInheritedObjectGuid: ptr GUID, pSid: PSID): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildTrusteeWithObjectsAndSidW*(pTrustee: PTRUSTEE_W, pObjSid: POBJECTS_AND_SID, pObjectGuid: ptr GUID, pInheritedObjectGuid: ptr GUID, pSid: PSID): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildTrusteeWithObjectsAndNameA*(pTrustee: PTRUSTEE_A, pObjName: POBJECTS_AND_NAME_A, ObjectType: SE_OBJECT_TYPE, ObjectTypeName: LPSTR, InheritedObjectTypeName: LPSTR, Name: LPSTR): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildTrusteeWithObjectsAndNameW*(pTrustee: PTRUSTEE_W, pObjName: POBJECTS_AND_NAME_W, ObjectType: SE_OBJECT_TYPE, ObjectTypeName: LPWSTR, InheritedObjectTypeName: LPWSTR, Name: LPWSTR): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetTrusteeNameA*(pTrustee: PTRUSTEE_A): LPSTR {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetTrusteeNameW*(pTrustee: PTRUSTEE_W): LPWSTR {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetTrusteeTypeA*(pTrustee: PTRUSTEE_A): TRUSTEE_TYPE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetTrusteeTypeW*(pTrustee: PTRUSTEE_W): TRUSTEE_TYPE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetTrusteeFormA*(pTrustee: PTRUSTEE_A): TRUSTEE_FORM {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetTrusteeFormW*(pTrustee: PTRUSTEE_W): TRUSTEE_FORM {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetMultipleTrusteeOperationA*(pTrustee: PTRUSTEE_A): MULTIPLE_TRUSTEE_OPERATION {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetMultipleTrusteeOperationW*(pTrustee: PTRUSTEE_W): MULTIPLE_TRUSTEE_OPERATION {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetMultipleTrusteeA*(pTrustee: PTRUSTEE_A): PTRUSTEE_A {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetMultipleTrusteeW*(pTrustee: PTRUSTEE_W): PTRUSTEE_W {.winapi, stdcall, dynlib: "advapi32", importc.}
proc TreeSetNamedSecurityInfoA*(pObjectName: LPSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, pOwner: PSID, pGroup: PSID, pDacl: PACL, pSacl: PACL, dwAction: DWORD, fnProgress: FN_PROGRESS, ProgressInvokeSetting: PROG_INVOKE_SETTING, Args: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc TreeSetNamedSecurityInfoW*(pObjectName: LPWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, pOwner: PSID, pGroup: PSID, pDacl: PACL, pSacl: PACL, dwAction: DWORD, fnProgress: FN_PROGRESS, ProgressInvokeSetting: PROG_INVOKE_SETTING, Args: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AuthzAccessCheck*(Flags: DWORD, hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, pRequest: PAUTHZ_ACCESS_REQUEST, hAuditEvent: AUTHZ_AUDIT_EVENT_HANDLE, pSecurityDescriptor: PSECURITY_DESCRIPTOR, OptionalSecurityDescriptorArray: ptr PSECURITY_DESCRIPTOR, OptionalSecurityDescriptorCount: DWORD, pReply: PAUTHZ_ACCESS_REPLY, phAccessCheckResults: PAUTHZ_ACCESS_CHECK_RESULTS_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzCachedAccessCheck*(Flags: DWORD, hAccessCheckResults: AUTHZ_ACCESS_CHECK_RESULTS_HANDLE, pRequest: PAUTHZ_ACCESS_REQUEST, hAuditEvent: AUTHZ_AUDIT_EVENT_HANDLE, pReply: PAUTHZ_ACCESS_REPLY): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzOpenObjectAudit*(Flags: DWORD, hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, pRequest: PAUTHZ_ACCESS_REQUEST, hAuditEvent: AUTHZ_AUDIT_EVENT_HANDLE, pSecurityDescriptor: PSECURITY_DESCRIPTOR, OptionalSecurityDescriptorArray: ptr PSECURITY_DESCRIPTOR, OptionalSecurityDescriptorCount: DWORD, pReply: PAUTHZ_ACCESS_REPLY): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzFreeHandle*(hAccessCheckResults: AUTHZ_ACCESS_CHECK_RESULTS_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInitializeResourceManager*(Flags: DWORD, pfnDynamicAccessCheck: PFN_AUTHZ_DYNAMIC_ACCESS_CHECK, pfnComputeDynamicGroups: PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS, pfnFreeDynamicGroups: PFN_AUTHZ_FREE_DYNAMIC_GROUPS, szResourceManagerName: PCWSTR, phAuthzResourceManager: PAUTHZ_RESOURCE_MANAGER_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInitializeResourceManagerEx*(Flags: DWORD, pAuthzInitInfo: PAUTHZ_INIT_INFO, phAuthzResourceManager: PAUTHZ_RESOURCE_MANAGER_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInitializeRemoteResourceManager*(pRpcInitInfo: PAUTHZ_RPC_INIT_INFO_CLIENT, phAuthzResourceManager: PAUTHZ_RESOURCE_MANAGER_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzFreeResourceManager*(hAuthzResourceManager: AUTHZ_RESOURCE_MANAGER_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInitializeContextFromToken*(Flags: DWORD, TokenHandle: HANDLE, hAuthzResourceManager: AUTHZ_RESOURCE_MANAGER_HANDLE, pExpirationTime: PLARGE_INTEGER, Identifier: LUID, DynamicGroupArgs: PVOID, phAuthzClientContext: PAUTHZ_CLIENT_CONTEXT_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInitializeContextFromSid*(Flags: DWORD, UserSid: PSID, hAuthzResourceManager: AUTHZ_RESOURCE_MANAGER_HANDLE, pExpirationTime: PLARGE_INTEGER, Identifier: LUID, DynamicGroupArgs: PVOID, phAuthzClientContext: PAUTHZ_CLIENT_CONTEXT_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInitializeContextFromAuthzContext*(Flags: DWORD, hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, pExpirationTime: PLARGE_INTEGER, Identifier: LUID, DynamicGroupArgs: PVOID, phNewAuthzClientContext: PAUTHZ_CLIENT_CONTEXT_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInitializeCompoundContext*(UserContext: AUTHZ_CLIENT_CONTEXT_HANDLE, DeviceContext: AUTHZ_CLIENT_CONTEXT_HANDLE, phCompoundContext: PAUTHZ_CLIENT_CONTEXT_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzAddSidsToContext*(hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, Sids: PSID_AND_ATTRIBUTES, SidCount: DWORD, RestrictedSids: PSID_AND_ATTRIBUTES, RestrictedSidCount: DWORD, phNewAuthzClientContext: PAUTHZ_CLIENT_CONTEXT_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzModifySecurityAttributes*(hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, pOperations: PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, pAttributes: PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzModifyClaims*(hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, ClaimClass: AUTHZ_CONTEXT_INFORMATION_CLASS, pClaimOperations: PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, pClaims: PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzModifySids*(hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, SidClass: AUTHZ_CONTEXT_INFORMATION_CLASS, pSidOperations: PAUTHZ_SID_OPERATION, pSids: PTOKEN_GROUPS): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzSetAppContainerInformation*(hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, pAppContainerSid: PSID, CapabilityCount: DWORD, pCapabilitySids: PSID_AND_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzGetInformationFromContext*(hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, InfoClass: AUTHZ_CONTEXT_INFORMATION_CLASS, BufferSize: DWORD, pSizeRequired: PDWORD, Buffer: PVOID): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzFreeContext*(hAuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInitializeObjectAccessAuditEvent*(Flags: DWORD, hAuditEventType: AUTHZ_AUDIT_EVENT_TYPE_HANDLE, szOperationType: PWSTR, szObjectType: PWSTR, szObjectName: PWSTR, szAdditionalInfo: PWSTR, phAuditEvent: PAUTHZ_AUDIT_EVENT_HANDLE, dwAdditionalParameterCount: DWORD): WINBOOL {.winapi, cdecl, varargs, dynlib: "authz", importc.}
proc AuthzInitializeObjectAccessAuditEvent2*(Flags: DWORD, hAuditEventType: AUTHZ_AUDIT_EVENT_TYPE_HANDLE, szOperationType: PWSTR, szObjectType: PWSTR, szObjectName: PWSTR, szAdditionalInfo: PWSTR, szAdditionalInfo2: PWSTR, phAuditEvent: PAUTHZ_AUDIT_EVENT_HANDLE, dwAdditionalParameterCount: DWORD): WINBOOL {.winapi, cdecl, varargs, dynlib: "authz", importc.}
proc AuthzFreeAuditEvent*(hAuditEvent: AUTHZ_AUDIT_EVENT_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzEvaluateSacl*(AuthzClientContext: AUTHZ_CLIENT_CONTEXT_HANDLE, pRequest: PAUTHZ_ACCESS_REQUEST, Sacl: PACL, GrantedAccess: ACCESS_MASK, AccessGranted: WINBOOL, pbGenerateAudit: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzInstallSecurityEventSource*(dwFlags: DWORD, pRegistration: PAUTHZ_SOURCE_SCHEMA_REGISTRATION): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzUninstallSecurityEventSource*(dwFlags: DWORD, szEventSourceName: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzEnumerateSecurityEventSources*(dwFlags: DWORD, Buffer: PAUTHZ_SOURCE_SCHEMA_REGISTRATION, pdwCount: PDWORD, pdwLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzRegisterSecurityEventSource*(dwFlags: DWORD, szEventSourceName: PCWSTR, phEventProvider: PAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzUnregisterSecurityEventSource*(dwFlags: DWORD, phEventProvider: PAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzReportSecurityEvent*(dwFlags: DWORD, hEventProvider: AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE, dwAuditId: DWORD, pUserSid: PSID, dwCount: DWORD): WINBOOL {.winapi, cdecl, varargs, dynlib: "authz", importc.}
proc AuthzReportSecurityEventFromParams*(dwFlags: DWORD, hEventProvider: AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE, dwAuditId: DWORD, pUserSid: PSID, pParams: PAUDIT_PARAMS): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzRegisterCapChangeNotification*(phCapChangeSubscription: PAUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE, pfnCapChangeCallback: LPTHREAD_START_ROUTINE, pCallbackContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzUnregisterCapChangeNotification*(hCapChangeSubscription: AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc AuthzFreeCentralAccessPolicyCache*(): WINBOOL {.winapi, stdcall, dynlib: "authz", importc.}
proc CreateSecurityPage*(psi: LPSECURITYINFO): HPROPSHEETPAGE {.winapi, stdcall, dynlib: "aclui", importc.}
proc EditSecurity*(hwndOwner: HWND, psi: LPSECURITYINFO): WINBOOL {.winapi, stdcall, dynlib: "aclui", importc.}
proc EditSecurityAdvanced*(hwndOwner: HWND, psi: LPSECURITYINFO, uSIPage: SI_PAGE_TYPE): HRESULT {.winapi, stdcall, dynlib: "aclui", importc.}
proc `Provider=`*(self: var ACTRL_OVERLAPPED, x: PVOID) {.inline.} = self.union1.Provider = x
proc Provider*(self: ACTRL_OVERLAPPED): PVOID {.inline.} = self.union1.Provider
proc Provider*(self: var ACTRL_OVERLAPPED): var PVOID {.inline.} = self.union1.Provider
proc `Reserved1=`*(self: var ACTRL_OVERLAPPED, x: ULONG) {.inline.} = self.union1.Reserved1 = x
proc Reserved1*(self: ACTRL_OVERLAPPED): ULONG {.inline.} = self.union1.Reserved1
proc Reserved1*(self: var ACTRL_OVERLAPPED): var ULONG {.inline.} = self.union1.Reserved1
proc `Data0=`*(self: var AUDIT_PARAM, x: ULONG_PTR) {.inline.} = self.union1.Data0 = x
proc Data0*(self: AUDIT_PARAM): ULONG_PTR {.inline.} = self.union1.Data0
proc Data0*(self: var AUDIT_PARAM): var ULONG_PTR {.inline.} = self.union1.Data0
proc `Str=`*(self: var AUDIT_PARAM, x: PWSTR) {.inline.} = self.union1.Str = x
proc Str*(self: AUDIT_PARAM): PWSTR {.inline.} = self.union1.Str
proc Str*(self: var AUDIT_PARAM): var PWSTR {.inline.} = self.union1.Str
proc `u=`*(self: var AUDIT_PARAM, x: ULONG_PTR) {.inline.} = self.union1.u = x
proc u*(self: AUDIT_PARAM): ULONG_PTR {.inline.} = self.union1.u
proc u*(self: var AUDIT_PARAM): var ULONG_PTR {.inline.} = self.union1.u
proc `psid=`*(self: var AUDIT_PARAM, x: ptr SID) {.inline.} = self.union1.psid = x
proc psid*(self: AUDIT_PARAM): ptr SID {.inline.} = self.union1.psid
proc psid*(self: var AUDIT_PARAM): var ptr SID {.inline.} = self.union1.psid
proc `pguid=`*(self: var AUDIT_PARAM, x: ptr GUID) {.inline.} = self.union1.pguid = x
proc pguid*(self: AUDIT_PARAM): ptr GUID {.inline.} = self.union1.pguid
proc pguid*(self: var AUDIT_PARAM): var ptr GUID {.inline.} = self.union1.pguid
proc `LogonId_LowPart=`*(self: var AUDIT_PARAM, x: ULONG) {.inline.} = self.union1.LogonId_LowPart = x
proc LogonId_LowPart*(self: AUDIT_PARAM): ULONG {.inline.} = self.union1.LogonId_LowPart
proc LogonId_LowPart*(self: var AUDIT_PARAM): var ULONG {.inline.} = self.union1.LogonId_LowPart
proc `pObjectTypes=`*(self: var AUDIT_PARAM, x: ptr AUDIT_OBJECT_TYPES) {.inline.} = self.union1.pObjectTypes = x
proc pObjectTypes*(self: AUDIT_PARAM): ptr AUDIT_OBJECT_TYPES {.inline.} = self.union1.pObjectTypes
proc pObjectTypes*(self: var AUDIT_PARAM): var ptr AUDIT_OBJECT_TYPES {.inline.} = self.union1.pObjectTypes
proc `pIpAddress=`*(self: var AUDIT_PARAM, x: ptr AUDIT_IP_ADDRESS) {.inline.} = self.union1.pIpAddress = x
proc pIpAddress*(self: AUDIT_PARAM): ptr AUDIT_IP_ADDRESS {.inline.} = self.union1.pIpAddress
proc pIpAddress*(self: var AUDIT_PARAM): var ptr AUDIT_IP_ADDRESS {.inline.} = self.union1.pIpAddress
proc `Data1=`*(self: var AUDIT_PARAM, x: ULONG_PTR) {.inline.} = self.union2.Data1 = x
proc Data1*(self: AUDIT_PARAM): ULONG_PTR {.inline.} = self.union2.Data1
proc Data1*(self: var AUDIT_PARAM): var ULONG_PTR {.inline.} = self.union2.Data1
proc `LogonId_HighPart=`*(self: var AUDIT_PARAM, x: LONG) {.inline.} = self.union2.LogonId_HighPart = x
proc LogonId_HighPart*(self: AUDIT_PARAM): LONG {.inline.} = self.union2.LogonId_HighPart
proc LogonId_HighPart*(self: var AUDIT_PARAM): var LONG {.inline.} = self.union2.LogonId_HighPart
proc `pReserved=`*(self: var AUTHZ_SOURCE_SCHEMA_REGISTRATION, x: PVOID) {.inline.} = self.union1.pReserved = x
proc pReserved*(self: AUTHZ_SOURCE_SCHEMA_REGISTRATION): PVOID {.inline.} = self.union1.pReserved
proc pReserved*(self: var AUTHZ_SOURCE_SCHEMA_REGISTRATION): var PVOID {.inline.} = self.union1.pReserved
proc `pProviderGuid=`*(self: var AUTHZ_SOURCE_SCHEMA_REGISTRATION, x: ptr GUID) {.inline.} = self.union1.pProviderGuid = x
proc pProviderGuid*(self: AUTHZ_SOURCE_SCHEMA_REGISTRATION): ptr GUID {.inline.} = self.union1.pProviderGuid
proc pProviderGuid*(self: var AUTHZ_SOURCE_SCHEMA_REGISTRATION): var ptr GUID {.inline.} = self.union1.pProviderGuid
proc GetObjectInformation*(self: ptr ISecurityInformation, pObjectInfo: PSI_OBJECT_INFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectInformation(self, pObjectInfo)
proc GetSecurity*(self: ptr ISecurityInformation, RequestedInformation: SECURITY_INFORMATION, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR, fDefault: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSecurity(self, RequestedInformation, ppSecurityDescriptor, fDefault)
proc SetSecurity*(self: ptr ISecurityInformation, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSecurity(self, SecurityInformation, pSecurityDescriptor)
proc GetAccessRights*(self: ptr ISecurityInformation, pguidObjectType: ptr GUID, dwFlags: DWORD, ppAccess: ptr PSI_ACCESS, pcAccesses: ptr ULONG, piDefaultAccess: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAccessRights(self, pguidObjectType, dwFlags, ppAccess, pcAccesses, piDefaultAccess)
proc MapGeneric*(self: ptr ISecurityInformation, pguidObjectType: ptr GUID, pAceFlags: ptr UCHAR, pMask: ptr ACCESS_MASK): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MapGeneric(self, pguidObjectType, pAceFlags, pMask)
proc GetInheritTypes*(self: ptr ISecurityInformation, ppInheritTypes: ptr PSI_INHERIT_TYPE, pcInheritTypes: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInheritTypes(self, ppInheritTypes, pcInheritTypes)
proc PropertySheetPageCallback*(self: ptr ISecurityInformation, hwnd: HWND, uMsg: UINT, uPage: SI_PAGE_TYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PropertySheetPageCallback(self, hwnd, uMsg, uPage)
proc IsDaclCanonical*(self: ptr ISecurityInformation2, pDacl: PACL): WINBOOL {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDaclCanonical(self, pDacl)
proc LookupSids*(self: ptr ISecurityInformation2, cSids: ULONG, rgpSids: ptr PSID, ppdo: ptr LPDATAOBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LookupSids(self, cSids, rgpSids, ppdo)
proc GetEffectivePermission*(self: ptr IEffectivePermission, pguidObjectType: ptr GUID, pUserSid: PSID, pszServerName: LPCWSTR, pSD: PSECURITY_DESCRIPTOR, ppObjectTypeList: ptr POBJECT_TYPE_LIST, pcObjectTypeListLength: ptr ULONG, ppGrantedAccessList: ptr PACCESS_MASK, pcGrantedAccessListLength: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEffectivePermission(self, pguidObjectType, pUserSid, pszServerName, pSD, ppObjectTypeList, pcObjectTypeListLength, ppGrantedAccessList, pcGrantedAccessListLength)
proc GetInheritSource*(self: ptr ISecurityObjectTypeInfo, si: SECURITY_INFORMATION, pACL: PACL, ppInheritArray: ptr PINHERITED_FROM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInheritSource(self, si, pACL, ppInheritArray)
proc GetFullResourceName*(self: ptr ISecurityInformation3, ppszResourceName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFullResourceName(self, ppszResourceName)
proc OpenElevatedEditor*(self: ptr ISecurityInformation3, hWnd: HWND, uPage: SI_PAGE_TYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenElevatedEditor(self, hWnd, uPage)
proc GetSecondarySecurity*(self: ptr ISecurityInformation4, pSecurityObjects: ptr PSECURITY_OBJECT, pSecurityObjectCount: PULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSecondarySecurity(self, pSecurityObjects, pSecurityObjectCount)
proc ComputeEffectivePermissionWithSecondarySecurity*(self: ptr IEffectivePermission2, pSid: PSID, pDeviceSid: PSID, pszServerName: PCWSTR, pSecurityObjects: PSECURITY_OBJECT, dwSecurityObjectCount: DWORD, pUserGroups: PTOKEN_GROUPS, pAuthzUserGroupsOperations: PAUTHZ_SID_OPERATION, pDeviceGroups: PTOKEN_GROUPS, pAuthzDeviceGroupsOperations: PAUTHZ_SID_OPERATION, pAuthzUserClaims: PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION, pAuthzUserClaimsOperations: PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, pAuthzDeviceClaims: PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION, pAuthzDeviceClaimsOperations: PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, pEffpermResultLists: PEFFPERM_RESULT_LIST): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ComputeEffectivePermissionWithSecondarySecurity(self, pSid, pDeviceSid, pszServerName, pSecurityObjects, dwSecurityObjectCount, pUserGroups, pAuthzUserGroupsOperations, pDeviceGroups, pAuthzDeviceGroupsOperations, pAuthzUserClaims, pAuthzUserClaimsOperations, pAuthzDeviceClaims, pAuthzDeviceClaimsOperations, pEffpermResultLists)
converter winimConverterISecurityInformationToIUnknown*(x: ptr ISecurityInformation): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISecurityInformation2ToIUnknown*(x: ptr ISecurityInformation2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEffectivePermissionToIUnknown*(x: ptr IEffectivePermission): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISecurityObjectTypeInfoToIUnknown*(x: ptr ISecurityObjectTypeInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISecurityInformation3ToIUnknown*(x: ptr ISecurityInformation3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISecurityInformation4ToIUnknown*(x: ptr ISecurityInformation4): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEffectivePermission2ToIUnknown*(x: ptr IEffectivePermission2): ptr IUnknown = cast[ptr IUnknown](x)
when winimUnicode:
  type
    OBJECTS_AND_NAME* = OBJECTS_AND_NAME_W
    POBJECTS_AND_NAME* = POBJECTS_AND_NAME_W
    TRUSTEE* = TRUSTEE_W
    PTRUSTEE* = PTRUSTEE_W
    EXPLICIT_ACCESS* = EXPLICIT_ACCESS_W
    PEXPLICIT_ACCESS* = PEXPLICIT_ACCESS_W
    ACTRL_ACCESS_ENTRY* = ACTRL_ACCESS_ENTRYW
    PACTRL_ACCESS_ENTRY* = PACTRL_ACCESS_ENTRYW
    ACTRL_ACCESS_ENTRY_LIST* = ACTRL_ACCESS_ENTRY_LISTW
    PACTRL_ACCESS_ENTRY_LIST* = PACTRL_ACCESS_ENTRY_LISTW
    ACTRL_PROPERTY_ENTRY* = ACTRL_PROPERTY_ENTRYW
    PACTRL_PROPERTY_ENTRY* = PACTRL_PROPERTY_ENTRYW
    ACTRL_ACCESS* = ACTRL_ACCESSW
    PACTRL_ACCESS* = PACTRL_ACCESSW
    ACTRL_AUDIT* = ACTRL_AUDITW
    PACTRL_AUDIT* = PACTRL_AUDITW
    TRUSTEE_ACCESS* = TRUSTEE_ACCESSW
    PTRUSTEE_ACCESS* = PTRUSTEE_ACCESSW
    ACTRL_ACCESS_INFO* = ACTRL_ACCESS_INFOW
    PACTRL_ACCESS_INFO* = PACTRL_ACCESS_INFOW
    ACTRL_CONTROL_INFO* = ACTRL_CONTROL_INFOW
    PACTRL_CONTROL_INFO* = PACTRL_CONTROL_INFOW
    INHERITED_FROM* = INHERITED_FROMW
  const
    ACCCTRL_DEFAULT_PROVIDER* = ACCCTRL_DEFAULT_PROVIDERW
  proc SetEntriesInAcl*(cCountOfExplicitEntries: ULONG, pListOfExplicitEntries: PEXPLICIT_ACCESS_W, OldAcl: PACL, NewAcl: ptr PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "SetEntriesInAclW".}
  proc GetExplicitEntriesFromAcl*(pacl: PACL, pcCountOfExplicitEntries: PULONG, pListOfExplicitEntries: ptr PEXPLICIT_ACCESS_W): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetExplicitEntriesFromAclW".}
  proc GetEffectiveRightsFromAcl*(pacl: PACL, pTrustee: PTRUSTEE_W, pAccessRights: PACCESS_MASK): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetEffectiveRightsFromAclW".}
  proc GetAuditedPermissionsFromAcl*(pacl: PACL, pTrustee: PTRUSTEE_W, pSuccessfulAuditedRights: PACCESS_MASK, pFailedAuditRights: PACCESS_MASK): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetAuditedPermissionsFromAclW".}
  proc GetNamedSecurityInfo*(pObjectName: LPCWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, ppsidOwner: ptr PSID, ppsidGroup: ptr PSID, ppDacl: ptr PACL, ppSacl: ptr PACL, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetNamedSecurityInfoW".}
  proc SetNamedSecurityInfo*(pObjectName: LPWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, psidOwner: PSID, psidGroup: PSID, pDacl: PACL, pSacl: PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "SetNamedSecurityInfoW".}
  proc GetInheritanceSource*(pObjectName: LPWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, Container: WINBOOL, pObjectClassGuids: ptr ptr GUID, GuidCount: DWORD, pAcl: PACL, pfnArray: PFN_OBJECT_MGR_FUNCTS, pGenericMapping: PGENERIC_MAPPING, pInheritArray: PINHERITED_FROMW): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetInheritanceSourceW".}
  proc TreeResetNamedSecurityInfo*(pObjectName: LPWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, pOwner: PSID, pGroup: PSID, pDacl: PACL, pSacl: PACL, KeepExplicit: WINBOOL, fnProgress: FN_PROGRESS, ProgressInvokeSetting: PROG_INVOKE_SETTING, Args: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "TreeResetNamedSecurityInfoW".}
  proc BuildSecurityDescriptor*(pOwner: PTRUSTEE_W, pGroup: PTRUSTEE_W, cCountOfAccessEntries: ULONG, pListOfAccessEntries: PEXPLICIT_ACCESS_W, cCountOfAuditEntries: ULONG, pListOfAuditEntries: PEXPLICIT_ACCESS_W, pOldSD: PSECURITY_DESCRIPTOR, pSizeNewSD: PULONG, pNewSD: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "BuildSecurityDescriptorW".}
  proc LookupSecurityDescriptorParts*(ppOwner: ptr PTRUSTEE_W, ppGroup: ptr PTRUSTEE_W, pcCountOfAccessEntries: PULONG, ppListOfAccessEntries: ptr PEXPLICIT_ACCESS_W, pcCountOfAuditEntries: PULONG, ppListOfAuditEntries: ptr PEXPLICIT_ACCESS_W, pSD: PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "LookupSecurityDescriptorPartsW".}
  proc BuildExplicitAccessWithName*(pExplicitAccess: PEXPLICIT_ACCESS_W, pTrusteeName: LPWSTR, AccessPermissions: DWORD, AccessMode: ACCESS_MODE, Inheritance: DWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildExplicitAccessWithNameW".}
  proc BuildImpersonateExplicitAccessWithName*(pExplicitAccess: PEXPLICIT_ACCESS_W, pTrusteeName: LPWSTR, pTrustee: PTRUSTEE_W, AccessPermissions: DWORD, AccessMode: ACCESS_MODE, Inheritance: DWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildImpersonateExplicitAccessWithNameW".}
  proc BuildTrusteeWithName*(pTrustee: PTRUSTEE_W, pName: LPWSTR): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildTrusteeWithNameW".}
  proc BuildImpersonateTrustee*(pTrustee: PTRUSTEE_W, pImpersonateTrustee: PTRUSTEE_W): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildImpersonateTrusteeW".}
  proc BuildTrusteeWithSid*(pTrustee: PTRUSTEE_W, pSid: PSID): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildTrusteeWithSidW".}
  proc BuildTrusteeWithObjectsAndSid*(pTrustee: PTRUSTEE_W, pObjSid: POBJECTS_AND_SID, pObjectGuid: ptr GUID, pInheritedObjectGuid: ptr GUID, pSid: PSID): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildTrusteeWithObjectsAndSidW".}
  proc BuildTrusteeWithObjectsAndName*(pTrustee: PTRUSTEE_W, pObjName: POBJECTS_AND_NAME_W, ObjectType: SE_OBJECT_TYPE, ObjectTypeName: LPWSTR, InheritedObjectTypeName: LPWSTR, Name: LPWSTR): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildTrusteeWithObjectsAndNameW".}
  proc GetTrusteeName*(pTrustee: PTRUSTEE_W): LPWSTR {.winapi, stdcall, dynlib: "advapi32", importc: "GetTrusteeNameW".}
  proc GetTrusteeType*(pTrustee: PTRUSTEE_W): TRUSTEE_TYPE {.winapi, stdcall, dynlib: "advapi32", importc: "GetTrusteeTypeW".}
  proc GetTrusteeForm*(pTrustee: PTRUSTEE_W): TRUSTEE_FORM {.winapi, stdcall, dynlib: "advapi32", importc: "GetTrusteeFormW".}
  proc GetMultipleTrusteeOperation*(pTrustee: PTRUSTEE_W): MULTIPLE_TRUSTEE_OPERATION {.winapi, stdcall, dynlib: "advapi32", importc: "GetMultipleTrusteeOperationW".}
  proc GetMultipleTrustee*(pTrustee: PTRUSTEE_W): PTRUSTEE_W {.winapi, stdcall, dynlib: "advapi32", importc: "GetMultipleTrusteeW".}
  proc TreeSetNamedSecurityInfo*(pObjectName: LPWSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, pOwner: PSID, pGroup: PSID, pDacl: PACL, pSacl: PACL, dwAction: DWORD, fnProgress: FN_PROGRESS, ProgressInvokeSetting: PROG_INVOKE_SETTING, Args: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "TreeSetNamedSecurityInfoW".}
when winimAnsi:
  type
    OBJECTS_AND_NAME* = OBJECTS_AND_NAME_A
    POBJECTS_AND_NAME* = POBJECTS_AND_NAME_A
    TRUSTEE* = TRUSTEE_A
    PTRUSTEE* = PTRUSTEE_A
    EXPLICIT_ACCESS* = EXPLICIT_ACCESS_A
    PEXPLICIT_ACCESS* = PEXPLICIT_ACCESS_A
    ACTRL_ACCESS_ENTRY* = ACTRL_ACCESS_ENTRYA
    PACTRL_ACCESS_ENTRY* = PACTRL_ACCESS_ENTRYA
    ACTRL_ACCESS_ENTRY_LIST* = ACTRL_ACCESS_ENTRY_LISTA
    PACTRL_ACCESS_ENTRY_LIST* = PACTRL_ACCESS_ENTRY_LISTA
    ACTRL_PROPERTY_ENTRY* = ACTRL_PROPERTY_ENTRYA
    PACTRL_PROPERTY_ENTRY* = PACTRL_PROPERTY_ENTRYA
    ACTRL_ACCESS* = ACTRL_ACCESSA
    PACTRL_ACCESS* = PACTRL_ACCESSA
    ACTRL_AUDIT* = ACTRL_AUDITA
    PACTRL_AUDIT* = PACTRL_AUDITA
    TRUSTEE_ACCESS* = TRUSTEE_ACCESSA
    PTRUSTEE_ACCESS* = PTRUSTEE_ACCESSA
    ACTRL_ACCESS_INFO* = ACTRL_ACCESS_INFOA
    PACTRL_ACCESS_INFO* = PACTRL_ACCESS_INFOA
    ACTRL_CONTROL_INFO* = ACTRL_CONTROL_INFOA
    PACTRL_CONTROL_INFO* = PACTRL_CONTROL_INFOA
    INHERITED_FROM* = INHERITED_FROMA
  const
    ACCCTRL_DEFAULT_PROVIDER* = ACCCTRL_DEFAULT_PROVIDERA
  proc SetEntriesInAcl*(cCountOfExplicitEntries: ULONG, pListOfExplicitEntries: PEXPLICIT_ACCESS_A, OldAcl: PACL, NewAcl: ptr PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "SetEntriesInAclA".}
  proc GetExplicitEntriesFromAcl*(pacl: PACL, pcCountOfExplicitEntries: PULONG, pListOfExplicitEntries: ptr PEXPLICIT_ACCESS_A): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetExplicitEntriesFromAclA".}
  proc GetEffectiveRightsFromAcl*(pacl: PACL, pTrustee: PTRUSTEE_A, pAccessRights: PACCESS_MASK): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetEffectiveRightsFromAclA".}
  proc GetAuditedPermissionsFromAcl*(pacl: PACL, pTrustee: PTRUSTEE_A, pSuccessfulAuditedRights: PACCESS_MASK, pFailedAuditRights: PACCESS_MASK): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetAuditedPermissionsFromAclA".}
  proc GetNamedSecurityInfo*(pObjectName: LPCSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, ppsidOwner: ptr PSID, ppsidGroup: ptr PSID, ppDacl: ptr PACL, ppSacl: ptr PACL, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetNamedSecurityInfoA".}
  proc SetNamedSecurityInfo*(pObjectName: LPSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, psidOwner: PSID, psidGroup: PSID, pDacl: PACL, pSacl: PACL): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "SetNamedSecurityInfoA".}
  proc GetInheritanceSource*(pObjectName: LPSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, Container: WINBOOL, pObjectClassGuids: ptr ptr GUID, GuidCount: DWORD, pAcl: PACL, pfnArray: PFN_OBJECT_MGR_FUNCTS, pGenericMapping: PGENERIC_MAPPING, pInheritArray: PINHERITED_FROMA): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "GetInheritanceSourceA".}
  proc TreeResetNamedSecurityInfo*(pObjectName: LPSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, pOwner: PSID, pGroup: PSID, pDacl: PACL, pSacl: PACL, KeepExplicit: WINBOOL, fnProgress: FN_PROGRESS, ProgressInvokeSetting: PROG_INVOKE_SETTING, Args: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "TreeResetNamedSecurityInfoA".}
  proc BuildSecurityDescriptor*(pOwner: PTRUSTEE_A, pGroup: PTRUSTEE_A, cCountOfAccessEntries: ULONG, pListOfAccessEntries: PEXPLICIT_ACCESS_A, cCountOfAuditEntries: ULONG, pListOfAuditEntries: PEXPLICIT_ACCESS_A, pOldSD: PSECURITY_DESCRIPTOR, pSizeNewSD: PULONG, pNewSD: ptr PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "BuildSecurityDescriptorA".}
  proc LookupSecurityDescriptorParts*(ppOwner: ptr PTRUSTEE_A, ppGroup: ptr PTRUSTEE_A, pcCountOfAccessEntries: PULONG, ppListOfAccessEntries: ptr PEXPLICIT_ACCESS_A, pcCountOfAuditEntries: PULONG, ppListOfAuditEntries: ptr PEXPLICIT_ACCESS_A, pSD: PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "LookupSecurityDescriptorPartsA".}
  proc BuildExplicitAccessWithName*(pExplicitAccess: PEXPLICIT_ACCESS_A, pTrusteeName: LPSTR, AccessPermissions: DWORD, AccessMode: ACCESS_MODE, Inheritance: DWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildExplicitAccessWithNameA".}
  proc BuildImpersonateExplicitAccessWithName*(pExplicitAccess: PEXPLICIT_ACCESS_A, pTrusteeName: LPSTR, pTrustee: PTRUSTEE_A, AccessPermissions: DWORD, AccessMode: ACCESS_MODE, Inheritance: DWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildImpersonateExplicitAccessWithNameA".}
  proc BuildTrusteeWithName*(pTrustee: PTRUSTEE_A, pName: LPSTR): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildTrusteeWithNameA".}
  proc BuildImpersonateTrustee*(pTrustee: PTRUSTEE_A, pImpersonateTrustee: PTRUSTEE_A): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildImpersonateTrusteeA".}
  proc BuildTrusteeWithSid*(pTrustee: PTRUSTEE_A, pSid: PSID): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildTrusteeWithSidA".}
  proc BuildTrusteeWithObjectsAndSid*(pTrustee: PTRUSTEE_A, pObjSid: POBJECTS_AND_SID, pObjectGuid: ptr GUID, pInheritedObjectGuid: ptr GUID, pSid: PSID): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildTrusteeWithObjectsAndSidA".}
  proc BuildTrusteeWithObjectsAndName*(pTrustee: PTRUSTEE_A, pObjName: POBJECTS_AND_NAME_A, ObjectType: SE_OBJECT_TYPE, ObjectTypeName: LPSTR, InheritedObjectTypeName: LPSTR, Name: LPSTR): VOID {.winapi, stdcall, dynlib: "advapi32", importc: "BuildTrusteeWithObjectsAndNameA".}
  proc GetTrusteeName*(pTrustee: PTRUSTEE_A): LPSTR {.winapi, stdcall, dynlib: "advapi32", importc: "GetTrusteeNameA".}
  proc GetTrusteeType*(pTrustee: PTRUSTEE_A): TRUSTEE_TYPE {.winapi, stdcall, dynlib: "advapi32", importc: "GetTrusteeTypeA".}
  proc GetTrusteeForm*(pTrustee: PTRUSTEE_A): TRUSTEE_FORM {.winapi, stdcall, dynlib: "advapi32", importc: "GetTrusteeFormA".}
  proc GetMultipleTrusteeOperation*(pTrustee: PTRUSTEE_A): MULTIPLE_TRUSTEE_OPERATION {.winapi, stdcall, dynlib: "advapi32", importc: "GetMultipleTrusteeOperationA".}
  proc GetMultipleTrustee*(pTrustee: PTRUSTEE_A): PTRUSTEE_A {.winapi, stdcall, dynlib: "advapi32", importc: "GetMultipleTrusteeA".}
  proc TreeSetNamedSecurityInfo*(pObjectName: LPSTR, ObjectType: SE_OBJECT_TYPE, SecurityInfo: SECURITY_INFORMATION, pOwner: PSID, pGroup: PSID, pDacl: PACL, pSacl: PACL, dwAction: DWORD, fnProgress: FN_PROGRESS, ProgressInvokeSetting: PROG_INVOKE_SETTING, Args: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "TreeSetNamedSecurityInfoA".}
