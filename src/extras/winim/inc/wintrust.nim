#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import wincrypt
#include <wintrust.h>
#include <mscat.h>
#include <mssip.h>
type
  HCATADMIN* = HANDLE
  HCATINFO* = HANDLE
  WINTRUST_FILE_INFO* {.pure.} = object
    cbStruct*: DWORD
    pcwszFilePath*: LPCWSTR
    hFile*: HANDLE
    pgKnownSubject*: ptr GUID
  WINTRUST_CATALOG_INFO* {.pure.} = object
    cbStruct*: DWORD
    dwCatalogVersion*: DWORD
    pcwszCatalogFilePath*: LPCWSTR
    pcwszMemberTag*: LPCWSTR
    pcwszMemberFilePath*: LPCWSTR
    hMemberFile*: HANDLE
    pbCalculatedFileHash*: ptr BYTE
    cbCalculatedFileHash*: DWORD
    pcCatalogContext*: PCCTL_CONTEXT
  WINTRUST_BLOB_INFO* {.pure.} = object
    cbStruct*: DWORD
    gSubject*: GUID
    pcwszDisplayName*: LPCWSTR
    cbMemObject*: DWORD
    pbMemObject*: ptr BYTE
    cbMemSignedMsg*: DWORD
    pbMemSignedMsg*: ptr BYTE
  WINTRUST_SGNR_INFO* {.pure.} = object
    cbStruct*: DWORD
    pcwszDisplayName*: LPCWSTR
    psSignerInfo*: ptr CMSG_SIGNER_INFO
    chStores*: DWORD
    pahStores*: ptr HCERTSTORE
  WINTRUST_CERT_INFO* {.pure.} = object
    cbStruct*: DWORD
    pcwszDisplayName*: LPCWSTR
    psCertContext*: ptr CERT_CONTEXT
    chStores*: DWORD
    pahStores*: ptr HCERTSTORE
    dwFlags*: DWORD
    psftVerifyAsOf*: ptr FILETIME
  WINTRUST_DATA_UNION1* {.pure, union.} = object
    pFile*: ptr WINTRUST_FILE_INFO
    pCatalog*: ptr WINTRUST_CATALOG_INFO
    pBlob*: ptr WINTRUST_BLOB_INFO
    pSgnr*: ptr WINTRUST_SGNR_INFO
    pCert*: ptr WINTRUST_CERT_INFO
  WINTRUST_DATA* {.pure.} = object
    cbStruct*: DWORD
    pPolicyCallbackData*: LPVOID
    pSIPClientData*: LPVOID
    dwUIChoice*: DWORD
    fdwRevocationChecks*: DWORD
    dwUnionChoice*: DWORD
    union1*: WINTRUST_DATA_UNION1
    dwStateAction*: DWORD
    hWVTStateData*: HANDLE
    pwszURLReference*: ptr WCHAR
    dwProvFlags*: DWORD
    dwUIContext*: DWORD
  PWINTRUST_DATA* = ptr WINTRUST_DATA
  PWINTRUST_FILE_INFO* = ptr WINTRUST_FILE_INFO
  PWINTRUST_CATALOG_INFO* = ptr WINTRUST_CATALOG_INFO
  PWINTRUST_BLOB_INFO* = ptr WINTRUST_BLOB_INFO
  PWINTRUST_SGNR_INFO* = ptr WINTRUST_SGNR_INFO
  PWINTRUST_CERT_INFO* = ptr WINTRUST_CERT_INFO
  PFN_CPD_MEM_ALLOC* = proc (cbSize: DWORD): pointer {.stdcall.}
  PFN_CPD_MEM_FREE* = proc (pvMem2Free: pointer): void {.stdcall.}
  PFN_CPD_ADD_STORE* = proc (pProvData: ptr CRYPT_PROVIDER_DATA, hStore2Add: HCERTSTORE): WINBOOL {.stdcall.}
  CRYPT_PROVIDER_CERT* {.pure.} = object
    cbStruct*: DWORD
    pCert*: PCCERT_CONTEXT
    fCommercial*: WINBOOL
    fTrustedRoot*: WINBOOL
    fSelfSigned*: WINBOOL
    fTestCert*: WINBOOL
    dwRevokedReason*: DWORD
    dwConfidence*: DWORD
    dwError*: DWORD
    pTrustListContext*: ptr CTL_CONTEXT
    fTrustListSignerCert*: WINBOOL
    pCtlContext*: PCCTL_CONTEXT
    dwCtlError*: DWORD
    fIsCyclic*: WINBOOL
    pChainElement*: PCERT_CHAIN_ELEMENT
  CRYPT_PROVIDER_SGNR* {.pure.} = object
    cbStruct*: DWORD
    sftVerifyAsOf*: FILETIME
    csCertChain*: DWORD
    pasCertChain*: ptr CRYPT_PROVIDER_CERT
    dwSignerType*: DWORD
    psSigner*: ptr CMSG_SIGNER_INFO
    dwError*: DWORD
    csCounterSigners*: DWORD
    pasCounterSigners*: ptr CRYPT_PROVIDER_SGNR
    pChainContext*: PCCERT_CHAIN_CONTEXT
  PFN_CPD_ADD_SGNR* = proc (pProvData: ptr CRYPT_PROVIDER_DATA, fCounterSigner: WINBOOL, idxSigner: DWORD, pSgnr2Add: ptr CRYPT_PROVIDER_SGNR): WINBOOL {.stdcall.}
  PFN_CPD_ADD_CERT* = proc (pProvData: ptr CRYPT_PROVIDER_DATA, idxSigner: DWORD, fCounterSigner: WINBOOL, idxCounterSigner: DWORD, pCert2Add: PCCERT_CONTEXT): WINBOOL {.stdcall.}
  CRYPT_PROVIDER_PRIVDATA* {.pure.} = object
    cbStruct*: DWORD
    gProviderID*: GUID
    cbProvData*: DWORD
    pvProvData*: pointer
  PFN_CPD_ADD_PRIVDATA* = proc (pProvData: ptr CRYPT_PROVIDER_DATA, pPrivData2Add: ptr CRYPT_PROVIDER_PRIVDATA): WINBOOL {.stdcall.}
  PFN_PROVIDER_INIT_CALL* = proc (pProvData: ptr CRYPT_PROVIDER_DATA): HRESULT {.stdcall.}
  PFN_PROVIDER_OBJTRUST_CALL* = proc (pProvData: ptr CRYPT_PROVIDER_DATA): HRESULT {.stdcall.}
  PFN_PROVIDER_SIGTRUST_CALL* = proc (pProvData: ptr CRYPT_PROVIDER_DATA): HRESULT {.stdcall.}
  PFN_PROVIDER_CERTTRUST_CALL* = proc (pProvData: ptr CRYPT_PROVIDER_DATA): HRESULT {.stdcall.}
  PFN_PROVIDER_FINALPOLICY_CALL* = proc (pProvData: ptr CRYPT_PROVIDER_DATA): HRESULT {.stdcall.}
  PFN_PROVIDER_CERTCHKPOLICY_CALL* = proc (pProvData: ptr CRYPT_PROVIDER_DATA, idxSigner: DWORD, fCounterSignerChain: WINBOOL, idxCounterSigner: DWORD): WINBOOL {.stdcall.}
  PFN_PROVIDER_TESTFINALPOLICY_CALL* = proc (pProvData: ptr CRYPT_PROVIDER_DATA): HRESULT {.stdcall.}
  CRYPT_PROVUI_DATA* {.pure.} = object
    cbStruct*: DWORD
    dwFinalError*: DWORD
    pYesButtonText*: ptr WCHAR
    pNoButtonText*: ptr WCHAR
    pMoreInfoButtonText*: ptr WCHAR
    pAdvancedLinkText*: ptr WCHAR
    pCopyActionText*: ptr WCHAR
    pCopyActionTextNoTS*: ptr WCHAR
    pCopyActionTextNotSigned*: ptr WCHAR
  PFN_PROVUI_CALL* = proc (hWndSecurityDialog: HWND, pProvData: ptr CRYPT_PROVIDER_DATA): WINBOOL {.stdcall.}
  CRYPT_PROVUI_FUNCS* {.pure.} = object
    cbStruct*: DWORD
    psUIData*: ptr CRYPT_PROVUI_DATA
    pfnOnMoreInfoClick*: PFN_PROVUI_CALL
    pfnOnMoreInfoClickDefault*: PFN_PROVUI_CALL
    pfnOnAdvancedClick*: PFN_PROVUI_CALL
    pfnOnAdvancedClickDefault*: PFN_PROVUI_CALL
  PFN_PROVIDER_CLEANUP_CALL* = proc (pProvData: ptr CRYPT_PROVIDER_DATA): HRESULT {.stdcall.}
  CRYPT_PROVIDER_FUNCTIONS* {.pure.} = object
    cbStruct*: DWORD
    pfnAlloc*: PFN_CPD_MEM_ALLOC
    pfnFree*: PFN_CPD_MEM_FREE
    pfnAddStore2Chain*: PFN_CPD_ADD_STORE
    pfnAddSgnr2Chain*: PFN_CPD_ADD_SGNR
    pfnAddCert2Chain*: PFN_CPD_ADD_CERT
    pfnAddPrivData2Chain*: PFN_CPD_ADD_PRIVDATA
    pfnInitialize*: PFN_PROVIDER_INIT_CALL
    pfnObjectTrust*: PFN_PROVIDER_OBJTRUST_CALL
    pfnSignatureTrust*: PFN_PROVIDER_SIGTRUST_CALL
    pfnCertificateTrust*: PFN_PROVIDER_CERTTRUST_CALL
    pfnFinalPolicy*: PFN_PROVIDER_FINALPOLICY_CALL
    pfnCertCheckPolicy*: PFN_PROVIDER_CERTCHKPOLICY_CALL
    pfnTestFinalPolicy*: PFN_PROVIDER_TESTFINALPOLICY_CALL
    psUIpfns*: ptr CRYPT_PROVUI_FUNCS
    pfnCleanupPolicy*: PFN_PROVIDER_CLEANUP_CALL
  SIP_INDIRECT_DATA* {.pure.} = object
    Data*: CRYPT_ATTRIBUTE_TYPE_VALUE
    DigestAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    Digest*: CRYPT_HASH_BLOB
  MS_ADDINFO_FLAT* {.pure.} = object
    cbStruct*: DWORD
    pIndirectData*: ptr SIP_INDIRECT_DATA
  CRYPTCATSTORE* {.pure.} = object
  CRYPTCATMEMBER* {.pure.} = object
    cbStruct*: DWORD
    pwszReferenceTag*: LPWSTR
    pwszFileName*: LPWSTR
    gSubjectType*: GUID
    fdwMemberFlags*: DWORD
    pIndirectData*: ptr SIP_INDIRECT_DATA
    dwCertVersion*: DWORD
    dwReserved*: DWORD
    hReserved*: HANDLE
    sEncodedIndirectData*: CRYPT_ATTR_BLOB
    sEncodedMemberInfo*: CRYPT_ATTR_BLOB
  MS_ADDINFO_CATALOGMEMBER* {.pure.} = object
    cbStruct*: DWORD
    pStore*: ptr CRYPTCATSTORE
    pMember*: ptr CRYPTCATMEMBER
  MS_ADDINFO_BLOB* {.pure.} = object
    cbStruct*: DWORD
    cbMemObject*: DWORD
    pbMemObject*: ptr BYTE
    cbMemSignedMsg*: DWORD
    pbMemSignedMsg*: ptr BYTE
  SIP_SUBJECTINFO_UNION1* {.pure, union.} = object
    psFlat*: ptr MS_ADDINFO_FLAT
    psCatMember*: ptr MS_ADDINFO_CATALOGMEMBER
    psBlob*: ptr MS_ADDINFO_BLOB
  SIP_SUBJECTINFO* {.pure.} = object
    cbSize*: DWORD
    pgSubjectType*: ptr GUID
    hFile*: HANDLE
    pwsFileName*: LPCWSTR
    pwsDisplayName*: LPCWSTR
    dwReserved1*: DWORD
    dwIntVersion*: DWORD
    hProv*: HCRYPTPROV
    DigestAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    dwFlags*: DWORD
    dwEncodingType*: DWORD
    dwReserved2*: DWORD
    fdwCAPISettings*: DWORD
    fdwSecuritySettings*: DWORD
    dwIndex*: DWORD
    dwUnionChoice*: DWORD
    union1*: SIP_SUBJECTINFO_UNION1
    pClientData*: LPVOID
  pCryptSIPGetSignedDataMsg* = proc (pSubjectInfo: ptr SIP_SUBJECTINFO, pdwEncodingType: ptr DWORD, dwIndex: DWORD, pcbSignedDataMsg: ptr DWORD, pbSignedDataMsg: ptr BYTE): WINBOOL {.stdcall.}
  pCryptSIPPutSignedDataMsg* = proc (pSubjectInfo: ptr SIP_SUBJECTINFO, dwEncodingType: DWORD, pdwIndex: ptr DWORD, cbSignedDataMsg: DWORD, pbSignedDataMsg: ptr BYTE): WINBOOL {.stdcall.}
  pCryptSIPCreateIndirectData* = proc (pSubjectInfo: ptr SIP_SUBJECTINFO, pcbIndirectData: ptr DWORD, pIndirectData: ptr SIP_INDIRECT_DATA): WINBOOL {.stdcall.}
  pCryptSIPVerifyIndirectData* = proc (pSubjectInfo: ptr SIP_SUBJECTINFO, pIndirectData: ptr SIP_INDIRECT_DATA): WINBOOL {.stdcall.}
  pCryptSIPRemoveSignedDataMsg* = proc (pSubjectInfo: ptr SIP_SUBJECTINFO, dwIndex: DWORD): WINBOOL {.stdcall.}
  SIP_DISPATCH_INFO* {.pure.} = object
    cbSize*: DWORD
    hSIP*: HANDLE
    pfGet*: pCryptSIPGetSignedDataMsg
    pfPut*: pCryptSIPPutSignedDataMsg
    pfCreate*: pCryptSIPCreateIndirectData
    pfVerify*: pCryptSIPVerifyIndirectData
    pfRemove*: pCryptSIPRemoveSignedDataMsg
  PROVDATA_SIP* {.pure.} = object
    cbStruct*: DWORD
    gSubject*: GUID
    pSip*: ptr SIP_DISPATCH_INFO
    pCATSip*: ptr SIP_DISPATCH_INFO
    psSipSubjectInfo*: ptr SIP_SUBJECTINFO
    psSipCATSubjectInfo*: ptr SIP_SUBJECTINFO
    psIndirectData*: ptr SIP_INDIRECT_DATA
  CRYPT_PROVIDER_DATA_UNION1* {.pure, union.} = object
    pPDSip*: ptr PROVDATA_SIP
  CRYPT_PROVIDER_DATA* {.pure.} = object
    cbStruct*: DWORD
    pWintrustData*: ptr WINTRUST_DATA
    fOpenedFile*: WINBOOL
    hWndParent*: HWND
    pgActionID*: ptr GUID
    hProv*: HCRYPTPROV
    dwError*: DWORD
    dwRegSecuritySettings*: DWORD
    dwRegPolicySettings*: DWORD
    psPfns*: ptr CRYPT_PROVIDER_FUNCTIONS
    cdwTrustStepErrors*: DWORD
    padwTrustStepErrors*: ptr DWORD
    chStores*: DWORD
    pahStores*: ptr HCERTSTORE
    dwEncoding*: DWORD
    hMsg*: HCRYPTMSG
    csSigners*: DWORD
    pasSigners*: ptr CRYPT_PROVIDER_SGNR
    csProvPrivData*: DWORD
    pasProvPrivData*: ptr CRYPT_PROVIDER_PRIVDATA
    dwSubjectChoice*: DWORD
    union1*: CRYPT_PROVIDER_DATA_UNION1
    pszUsageOID*: ptr char
    fRecallWithState*: WINBOOL
    sftSystemTime*: FILETIME
    pszCTLSignerUsageOID*: ptr char
    dwProvFlags*: DWORD
    dwFinalError*: DWORD
    pRequestUsage*: PCERT_USAGE_MATCH
    dwTrustPubSettings*: DWORD
    dwUIStateFlags*: DWORD
  PCRYPT_PROVIDER_DATA* = ptr CRYPT_PROVIDER_DATA
  PCRYPT_PROVIDER_FUNCTIONS* = ptr CRYPT_PROVIDER_FUNCTIONS
  PCRYPT_PROVUI_FUNCS* = ptr CRYPT_PROVUI_FUNCS
  PCRYPT_PROVUI_DATA* = ptr CRYPT_PROVUI_DATA
  PCRYPT_PROVIDER_SGNR* = ptr CRYPT_PROVIDER_SGNR
  PCRYPT_PROVIDER_CERT* = ptr CRYPT_PROVIDER_CERT
  PCRYPT_PROVIDER_PRIVDATA* = ptr CRYPT_PROVIDER_PRIVDATA
  PPROVDATA_SIP* = ptr PROVDATA_SIP
  CRYPT_TRUST_REG_ENTRY* {.pure.} = object
    cbStruct*: DWORD
    pwszDLLName*: ptr WCHAR
    pwszFunctionName*: ptr WCHAR
  PCRYPT_TRUST_REG_ENTRY* = ptr CRYPT_TRUST_REG_ENTRY
  CRYPT_REGISTER_ACTIONID* {.pure.} = object
    cbStruct*: DWORD
    sInitProvider*: CRYPT_TRUST_REG_ENTRY
    sObjectProvider*: CRYPT_TRUST_REG_ENTRY
    sSignatureProvider*: CRYPT_TRUST_REG_ENTRY
    sCertificateProvider*: CRYPT_TRUST_REG_ENTRY
    sCertificatePolicyProvider*: CRYPT_TRUST_REG_ENTRY
    sFinalPolicyProvider*: CRYPT_TRUST_REG_ENTRY
    sTestPolicyProvider*: CRYPT_TRUST_REG_ENTRY
    sCleanupProvider*: CRYPT_TRUST_REG_ENTRY
  PCRYPT_REGISTER_ACTIONID* = ptr CRYPT_REGISTER_ACTIONID
  CRYPT_PROVIDER_REGDEFUSAGE* {.pure.} = object
    cbStruct*: DWORD
    pgActionID*: ptr GUID
    pwszDllName*: ptr WCHAR
    pwszLoadCallbackDataFunctionName*: ptr char
    pwszFreeCallbackDataFunctionName*: ptr char
  PCRYPT_PROVIDER_REGDEFUSAGE* = ptr CRYPT_PROVIDER_REGDEFUSAGE
  CRYPT_PROVIDER_DEFUSAGE* {.pure.} = object
    cbStruct*: DWORD
    gActionID*: GUID
    pDefPolicyCallbackData*: LPVOID
    pDefSIPClientData*: LPVOID
  PCRYPT_PROVIDER_DEFUSAGE* = ptr CRYPT_PROVIDER_DEFUSAGE
const
  SPC_UUID_LENGTH* = 16
type
  SPC_UUID* = array[SPC_UUID_LENGTH, BYTE]
  SPC_SERIALIZED_OBJECT* {.pure.} = object
    ClassId*: SPC_UUID
    SerializedData*: CRYPT_DATA_BLOB
  PSPC_SERIALIZED_OBJECT* = ptr SPC_SERIALIZED_OBJECT
  SPC_SIGINFO* {.pure.} = object
    dwSipVersion*: DWORD
    gSIPGuid*: GUID
    dwReserved1*: DWORD
    dwReserved2*: DWORD
    dwReserved3*: DWORD
    dwReserved4*: DWORD
    dwReserved5*: DWORD
  PSPC_SIGINFO* = ptr SPC_SIGINFO
  SPC_LINK_UNION1* {.pure, union.} = object
    pwszUrl*: LPWSTR
    Moniker*: SPC_SERIALIZED_OBJECT
    pwszFile*: LPWSTR
  SPC_LINK* {.pure.} = object
    dwLinkChoice*: DWORD
    union1*: SPC_LINK_UNION1
  PSPC_LINK* = ptr SPC_LINK
  SPC_PE_IMAGE_DATA* {.pure.} = object
    Flags*: CRYPT_BIT_BLOB
    pFile*: PSPC_LINK
  PSPC_PE_IMAGE_DATA* = ptr SPC_PE_IMAGE_DATA
  SPC_INDIRECT_DATA_CONTENT* {.pure.} = object
    Data*: CRYPT_ATTRIBUTE_TYPE_VALUE
    DigestAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    Digest*: CRYPT_HASH_BLOB
  PSPC_INDIRECT_DATA_CONTENT* = ptr SPC_INDIRECT_DATA_CONTENT
  SPC_FINANCIAL_CRITERIA* {.pure.} = object
    fFinancialInfoAvailable*: WINBOOL
    fMeetsCriteria*: WINBOOL
  PSPC_FINANCIAL_CRITERIA* = ptr SPC_FINANCIAL_CRITERIA
  SPC_IMAGE* {.pure.} = object
    pImageLink*: ptr SPC_LINK
    Bitmap*: CRYPT_DATA_BLOB
    Metafile*: CRYPT_DATA_BLOB
    EnhancedMetafile*: CRYPT_DATA_BLOB
    GifFile*: CRYPT_DATA_BLOB
  PSPC_IMAGE* = ptr SPC_IMAGE
  SPC_SP_AGENCY_INFO* {.pure.} = object
    pPolicyInformation*: ptr SPC_LINK
    pwszPolicyDisplayText*: LPWSTR
    pLogoImage*: PSPC_IMAGE
    pLogoLink*: ptr SPC_LINK
  PSPC_SP_AGENCY_INFO* = ptr SPC_SP_AGENCY_INFO
  SPC_STATEMENT_TYPE* {.pure.} = object
    cKeyPurposeId*: DWORD
    rgpszKeyPurposeId*: ptr LPSTR
  PSPC_STATEMENT_TYPE* = ptr SPC_STATEMENT_TYPE
  SPC_SP_OPUS_INFO* {.pure.} = object
    pwszProgramName*: LPCWSTR
    pMoreInfo*: ptr SPC_LINK
    pPublisherInfo*: ptr SPC_LINK
  PSPC_SP_OPUS_INFO* = ptr SPC_SP_OPUS_INFO
  CAT_NAMEVALUE* {.pure.} = object
    pwszTag*: LPWSTR
    fdwFlags*: DWORD
    Value*: CRYPT_DATA_BLOB
  PCAT_NAMEVALUE* = ptr CAT_NAMEVALUE
  CAT_MEMBERINFO* {.pure.} = object
    pwszSubjGuid*: LPWSTR
    dwCertVersion*: DWORD
  PCAT_MEMBERINFO* = ptr CAT_MEMBERINFO
  WIN_CERTIFICATE* {.pure.} = object
    dwLength*: DWORD
    wRevision*: WORD
    wCertificateType*: WORD
    bCertificate*: array[ANYSIZE_ARRAY, BYTE]
  LPWIN_CERTIFICATE* = ptr WIN_CERTIFICATE
  WIN_TRUST_SUBJECT* = LPVOID
  WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT* {.pure.} = object
    hClientToken*: HANDLE
    SubjectType*: ptr GUID
    Subject*: WIN_TRUST_SUBJECT
  LPWIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT* = ptr WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT
  WIN_TRUST_ACTDATA_SUBJECT_ONLY* {.pure.} = object
    SubjectType*: ptr GUID
    Subject*: WIN_TRUST_SUBJECT
  LPWIN_TRUST_ACTDATA_SUBJECT_ONLY* = ptr WIN_TRUST_ACTDATA_SUBJECT_ONLY
  WIN_TRUST_SUBJECT_FILE* {.pure.} = object
    hFile*: HANDLE
    lpPath*: LPCWSTR
  LPWIN_TRUST_SUBJECT_FILE* = ptr WIN_TRUST_SUBJECT_FILE
  WIN_TRUST_SUBJECT_FILE_AND_DISPLAY* {.pure.} = object
    hFile*: HANDLE
    lpPath*: LPCWSTR
    lpDisplayName*: LPCWSTR
  LPWIN_TRUST_SUBJECT_FILE_AND_DISPLAY* = ptr WIN_TRUST_SUBJECT_FILE_AND_DISPLAY
  WIN_SPUB_TRUSTED_PUBLISHER_DATA* {.pure.} = object
    hClientToken*: HANDLE
    lpCertificate*: LPWIN_CERTIFICATE
  LPWIN_SPUB_TRUSTED_PUBLISHER_DATA* = ptr WIN_SPUB_TRUSTED_PUBLISHER_DATA
  CRYPT_DIGEST_DATA* = CRYPT_HASH_BLOB
  LPSIP_SUBJECTINFO* = ptr SIP_SUBJECTINFO
  PMS_ADDINFO_FLAT* = ptr MS_ADDINFO_FLAT
  PMS_ADDINFO_CATALOGMEMBER* = ptr MS_ADDINFO_CATALOGMEMBER
  PMS_ADDINFO_BLOB* = ptr MS_ADDINFO_BLOB
  PSIP_INDIRECT_DATA* = ptr SIP_INDIRECT_DATA
  LPSIP_DISPATCH_INFO* = ptr SIP_DISPATCH_INFO
  SIP_ADD_NEWPROVIDER* {.pure.} = object
    cbStruct*: DWORD
    pgSubject*: ptr GUID
    pwszDLLFileName*: ptr WCHAR
    pwszMagicNumber*: ptr WCHAR
    pwszIsFunctionName*: ptr WCHAR
    pwszGetFuncName*: ptr WCHAR
    pwszPutFuncName*: ptr WCHAR
    pwszCreateFuncName*: ptr WCHAR
    pwszVerifyFuncName*: ptr WCHAR
    pwszRemoveFuncName*: ptr WCHAR
    pwszIsFunctionNameFmt2*: ptr WCHAR
  PSIP_ADD_NEWPROVIDER* = ptr SIP_ADD_NEWPROVIDER
const
  WTD_UI_ALL* = 1
  WTD_UI_NONE* = 2
  WTD_UI_NOBAD* = 3
  WTD_UI_NOGOOD* = 4
  WTD_REVOKE_NONE* = 0x00000000
  WTD_REVOKE_WHOLECHAIN* = 0x00000001
  WTD_CHOICE_FILE* = 1
  WTD_CHOICE_CATALOG* = 2
  WTD_CHOICE_BLOB* = 3
  WTD_CHOICE_SIGNER* = 4
  WTD_CHOICE_CERT* = 5
  WTD_STATEACTION_IGNORE* = 0x00000000
  WTD_STATEACTION_VERIFY* = 0x00000001
  WTD_STATEACTION_CLOSE* = 0x00000002
  WTD_STATEACTION_AUTO_CACHE* = 0x00000003
  WTD_STATEACTION_AUTO_CACHE_FLUSH* = 0x00000004
  WTD_PROV_FLAGS_MASK* = 0x0000FFFF
  WTD_USE_IE4_TRUST_FLAG* = 0x00000001
  WTD_NO_IE4_CHAIN_FLAG* = 0x00000002
  WTD_NO_POLICY_USAGE_FLAG* = 0x00000004
  WTD_REVOCATION_CHECK_NONE* = 0x00000010
  WTD_REVOCATION_CHECK_END_CERT* = 0x00000020
  WTD_REVOCATION_CHECK_CHAIN* = 0x00000040
  WTD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT* = 0x00000080
  WTD_SAFER_FLAG* = 0x00000100
  WTD_HASH_ONLY_FLAG* = 0x00000200
  WTD_USE_DEFAULT_OSVER_CHECK* = 0x00000400
  WTD_LIFETIME_SIGNING_FLAG* = 0x00000800
  WTD_CACHE_ONLY_URL_RETRIEVAL* = 0x00001000
  WTD_UICONTEXT_EXECUTE* = 0
  WTD_UICONTEXT_INSTALL* = 1
  WTCI_DONT_OPEN_STORES* = 0x00000001
  WTCI_OPEN_ONLY_ROOT* = 0x00000002
  WTPF_TRUSTTEST* = 0x00000020
  WTPF_TESTCANBEVALID* = 0x00000080
  WTPF_IGNOREEXPIRATION* = 0x00000100
  WTPF_IGNOREREVOKATION* = 0x00000200
  WTPF_OFFLINEOK_IND* = 0x00000400
  WTPF_OFFLINEOK_COM* = 0x00000800
  WTPF_OFFLINEOKNBU_IND* = 0x00001000
  WTPF_OFFLINEOKNBU_COM* = 0x00002000
  WTPF_VERIFY_V1_OFF* = 0x00010000
  WTPF_IGNOREREVOCATIONONTS* = 0x00020000
  WTPF_ALLOWONLYPERTRUST* = 0x00040000
  TRUSTERROR_STEP_WVTPARAMS* = 0
  TRUSTERROR_STEP_FILEIO* = 2
  TRUSTERROR_STEP_SIP* = 3
  TRUSTERROR_STEP_SIPSUBJINFO* = 5
  TRUSTERROR_STEP_CATALOGFILE* = 6
  TRUSTERROR_STEP_CERTSTORE* = 7
  TRUSTERROR_STEP_MESSAGE* = 8
  TRUSTERROR_STEP_MSG_SIGNERCOUNT* = 9
  TRUSTERROR_STEP_MSG_INNERCNTTYPE* = 10
  TRUSTERROR_STEP_MSG_INNERCNT* = 11
  TRUSTERROR_STEP_MSG_STORE* = 12
  TRUSTERROR_STEP_MSG_SIGNERINFO* = 13
  TRUSTERROR_STEP_MSG_SIGNERCERT* = 14
  TRUSTERROR_STEP_MSG_CERTCHAIN* = 15
  TRUSTERROR_STEP_MSG_COUNTERSIGINFO* = 16
  TRUSTERROR_STEP_MSG_COUNTERSIGCERT* = 17
  TRUSTERROR_STEP_VERIFY_MSGHASH* = 18
  TRUSTERROR_STEP_VERIFY_MSGINDIRECTDATA* = 19
  TRUSTERROR_STEP_FINAL_WVTINIT* = 30
  TRUSTERROR_STEP_FINAL_INITPROV* = 31
  TRUSTERROR_STEP_FINAL_OBJPROV* = 32
  TRUSTERROR_STEP_FINAL_SIGPROV* = 33
  TRUSTERROR_STEP_FINAL_CERTPROV* = 34
  TRUSTERROR_STEP_FINAL_CERTCHKPROV* = 35
  TRUSTERROR_STEP_FINAL_POLICYPROV* = 36
  TRUSTERROR_STEP_FINAL_UIPROV* = 37
  TRUSTERROR_MAX_STEPS* = 38
  CPD_CHOICE_SIP* = 1
  CPD_USE_NT5_CHAIN_FLAG* = 0x80000000'i32
  CPD_REVOCATION_CHECK_NONE* = 0x00010000
  CPD_REVOCATION_CHECK_END_CERT* = 0x00020000
  CPD_REVOCATION_CHECK_CHAIN* = 0x00040000
  CPD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT* = 0x00080000
  CPD_UISTATE_MODE_PROMPT* = 0x00000000
  CPD_UISTATE_MODE_BLOCK* = 0x00000001
  CPD_UISTATE_MODE_ALLOW* = 0x00000002
  CPD_UISTATE_MODE_MASK* = 0x00000003
  SGNR_TYPE_TIMESTAMP* = 0x00000010
  CERT_CONFIDENCE_SIG* = 0x10000000
  CERT_CONFIDENCE_TIME* = 0x01000000
  CERT_CONFIDENCE_TIMENEST* = 0x00100000
  CERT_CONFIDENCE_AUTHIDEXT* = 0x00010000
  CERT_CONFIDENCE_HYGIENE* = 0x00001000
  CERT_CONFIDENCE_HIGHEST* = 0x11111000
  WT_CURRENT_VERSION* = 0x00000200
  WT_PROVIDER_DLL_NAME* = "WINTRUST.DL"
  WT_PROVIDER_CERTTRUST_FUNCTION* = "WintrustCertificateTrust"
  WT_ADD_ACTION_ID_RET_RESULT_FLAG* = 0x1
  DWACTION_ALLOCANDFILL* = 1
  DWACTION_FREE* = 2
  szOID_TRUSTED_CODESIGNING_CA_LIST* = "1.3.6.1.4.1.311.2.2.1"
  szOID_TRUSTED_CLIENT_AUTH_CA_LIST* = "1.3.6.1.4.1.311.2.2.2"
  szOID_TRUSTED_SERVER_AUTH_CA_LIST* = "1.3.6.1.4.1.311.2.2.3"
  SPC_COMMON_NAME_OBJID* = szOID_COMMON_NAME
  SPC_TIME_STAMP_REQUEST_OBJID* = "1.3.6.1.4.1.311.3.2.1"
  SPC_INDIRECT_DATA_OBJID* = "1.3.6.1.4.1.311.2.1.4"
  SPC_SP_AGENCY_INFO_OBJID* = "1.3.6.1.4.1.311.2.1.10"
  SPC_STATEMENT_TYPE_OBJID* = "1.3.6.1.4.1.311.2.1.11"
  SPC_SP_OPUS_INFO_OBJID* = "1.3.6.1.4.1.311.2.1.12"
  SPC_CERT_EXTENSIONS_OBJID* = "1.3.6.1.4.1.311.2.1.14"
  SPC_PE_IMAGE_DATA_OBJID* = "1.3.6.1.4.1.311.2.1.15"
  SPC_RAW_FILE_DATA_OBJID* = "1.3.6.1.4.1.311.2.1.18"
  SPC_STRUCTURED_STORAGE_DATA_OBJID* = "1.3.6.1.4.1.311.2.1.19"
  SPC_JAVA_CLASS_DATA_OBJID* = "1.3.6.1.4.1.311.2.1.20"
  SPC_INDIVIDUAL_SP_KEY_PURPOSE_OBJID* = "1.3.6.1.4.1.311.2.1.21"
  SPC_COMMERCIAL_SP_KEY_PURPOSE_OBJID* = "1.3.6.1.4.1.311.2.1.22"
  SPC_CAB_DATA_OBJID* = "1.3.6.1.4.1.311.2.1.25"
  SPC_GLUE_RDN_OBJID* = "1.3.6.1.4.1.311.2.1.25"
  SPC_MINIMAL_CRITERIA_OBJID* = "1.3.6.1.4.1.311.2.1.26"
  SPC_FINANCIAL_CRITERIA_OBJID* = "1.3.6.1.4.1.311.2.1.27"
  SPC_LINK_OBJID* = "1.3.6.1.4.1.311.2.1.28"
  SPC_SIGINFO_OBJID* = "1.3.6.1.4.1.311.2.1.30"
  CAT_NAMEVALUE_OBJID* = "1.3.6.1.4.1.311.12.2.1"
  CAT_MEMBERINFO_OBJID* = "1.3.6.1.4.1.311.12.2.2"
  SPC_SP_AGENCY_INFO_STRUCT* = cast[LPCSTR](2000)
  SPC_MINIMAL_CRITERIA_STRUCT* = cast[LPCSTR](2001)
  SPC_FINANCIAL_CRITERIA_STRUCT* = cast[LPCSTR](2002)
  SPC_INDIRECT_DATA_CONTENT_STRUCT* = cast[LPCSTR](2003)
  SPC_PE_IMAGE_DATA_STRUCT* = cast[LPCSTR](2004)
  SPC_LINK_STRUCT* = cast[LPCSTR](2005)
  SPC_STATEMENT_TYPE_STRUCT* = cast[LPCSTR](2006)
  SPC_SP_OPUS_INFO_STRUCT* = cast[LPCSTR](2007)
  SPC_CAB_DATA_STRUCT* = cast[LPCSTR](2008)
  SPC_JAVA_CLASS_DATA_STRUCT* = cast[LPCSTR](2009)
  SPC_SIGINFO_STRUCT* = cast[LPCSTR](2130)
  CAT_NAMEVALUE_STRUCT* = cast[LPCSTR](2221)
  CAT_MEMBERINFO_STRUCT* = cast[LPCSTR](2222)
  SPC_URL_LINK_CHOICE* = 1
  SPC_MONIKER_LINK_CHOICE* = 2
  SPC_FILE_LINK_CHOICE* = 3
  WIN_CERT_REVISION_1_0* = 0x0100
  WIN_CERT_REVISION_2_0* = 0x0200
  WIN_CERT_TYPE_X509* = 0x0001
  WIN_CERT_TYPE_PKCS_SIGNED_DATA* = 0x0002
  WIN_CERT_TYPE_RESERVED_1* = 0x0003
  WIN_CERT_TYPE_TS_STACK_SIGNED* = 0x0004
  WIN_TRUST_SUBJTYPE_RAW_FILE* = DEFINE_GUID("959dc450-8d9e-11cf-8736-00aa00a485eb")
  WIN_TRUST_SUBJTYPE_PE_IMAGE* = DEFINE_GUID("43c9a1e0-8da0-11cf-8736-00aa00a485eb")
  WIN_TRUST_SUBJTYPE_JAVA_CLASS* = DEFINE_GUID("08ad3990-8da1-11cf-8736-00aa00a485eb")
  WIN_TRUST_SUBJTYPE_CABINET* = DEFINE_GUID("d17c5374-a392-11cf-9df5-00aa00c184e0")
  WIN_TRUST_SUBJTYPE_RAW_FILEEX* = DEFINE_GUID("6f458110-c2f1-11cf-8a69-00aa006c3706")
  WIN_TRUST_SUBJTYPE_PE_IMAGEEX* = DEFINE_GUID("6f458111-c2f1-11cf-8a69-00aa006c3706")
  WIN_TRUST_SUBJTYPE_JAVA_CLASSEX* = DEFINE_GUID("6f458113-c2f1-11cf-8a69-00aa006c3706")
  WIN_TRUST_SUBJTYPE_CABINETEX* = DEFINE_GUID("6f458114-c2f1-11cf-8a69-00aa006c3706")
  WIN_TRUST_SUBJTYPE_OLE_STORAGE* = DEFINE_GUID("c257e740-8da0-11cf-8736-00aa00a485eb")
  WIN_SPUB_ACTION_TRUSTED_PUBLISHER* = DEFINE_GUID("66426730-8da1-11cf-8736-00aa00a485eb")
  WIN_SPUB_ACTION_NT_ACTIVATE_IMAGE* = DEFINE_GUID("8bc96b00-8da1-11cf-8736-00aa00a485eb")
  WIN_SPUB_ACTION_PUBLISHED_SOFTWARE* = DEFINE_GUID("64b9d180-8da2-11cf-8736-00aa00a485eb")
  MSSIP_FLAGS_PROHIBIT_RESIZE_ON_CREATE* = 0x00010000
  MSSIP_FLAGS_USE_CATALOG* = 0x00020000
  SPC_INC_PE_RESOURCES_FLAG* = 0x80
  SPC_INC_PE_DEBUG_INFO_FLAG* = 0x40
  SPC_INC_PE_IMPORT_ADDR_TABLE_FLAG* = 0x20
  SIP_MAX_MAGIC_NUMBER* = 4
  CRYPTCAT_OPEN_CREATENEW* = 0x00000001
  CRYPTCAT_OPEN_ALWAYS* = 0x00000002
  CRYPTCAT_OPEN_EXISTING* = 0x00000004
  CRYPTCAT_OPEN_EXCLUDE_PAGE_HASHES* = 0x00010000
  CRYPTCAT_OPEN_INCLUDE_PAGE_HASHES* = 0x00020000
  CRYPTCAT_OPEN_VERIFYSIGHASH* = 0x10000000
  CRYPTCAT_OPEN_NO_CONTENT_HCRYPTMSG* = 0x20000000
  CRYPTCAT_OPEN_SORTED* = 0x40000000
  CRYPTCAT_OPEN_FLAGS_MASK* = 0xffff0000'i32
  CRYPTCAT_E_AREA_HEADER* = 0x00000000
  CRYPTCAT_E_AREA_MEMBER* = 0x00010000
  CRYPTCAT_E_AREA_ATTRIBUTE* = 0x00020000
  CRYPTCAT_E_CDF_UNSUPPORTED* = 0x00000001
  CRYPTCAT_E_CDF_DUPLICATE* = 0x00000002
  CRYPTCAT_E_CDF_TAGNOTFOUND* = 0x00000004
  CRYPTCAT_E_CDF_MEMBER_FILE_PATH* = 0x00010001
  CRYPTCAT_E_CDF_MEMBER_INDIRECTDATA* = 0x00010002
  CRYPTCAT_E_CDF_MEMBER_FILENOTFOUND* = 0x00010004
  CRYPTCAT_E_CDF_BAD_GUID_CONV* = 0x00020001
  CRYPTCAT_E_CDF_ATTR_TOOFEWVALUES* = 0x00020002
  CRYPTCAT_E_CDF_ATTR_TYPECOMBO* = 0x00020004
type
  PFN_ALLOCANDFILLDEFUSAGE* = proc (pszUsageOID: ptr char, psDefUsage: ptr CRYPT_PROVIDER_DEFUSAGE): WINBOOL {.stdcall.}
  PFN_FREEDEFUSAGE* = proc (pszUsageOID: ptr char, psDefUsage: ptr CRYPT_PROVIDER_DEFUSAGE): WINBOOL {.stdcall.}
  pfnIsFileSupported* = proc (hFile: HANDLE, pgSubject: ptr GUID): WINBOOL {.stdcall.}
  pfnIsFileSupportedName* = proc (pwszFileName: ptr WCHAR, pgSubject: ptr GUID): WINBOOL {.stdcall.}
  PFN_CDF_PARSE_ERROR_CALLBACK* = proc (P1: DWORD, P2: DWORD, P3: ptr WCHAR): void {.stdcall.}
  CRYPTCATATTRIBUTE* {.pure.} = object
    cbStruct*: DWORD
    pwszReferenceTag*: LPWSTR
    dwAttrTypeAndAction*: DWORD
    cbValue*: DWORD
    pbValue*: ptr BYTE
    dwReserved*: DWORD
  CATALOG_INFO* {.pure.} = object
    cbStruct*: DWORD
    wszCatalogFile*: array[MAX_PATH, WCHAR]
  CRYPTCATCDF* {.pure.} = object
    cbStruct*: DWORD
    hFile*: HANDLE
    dwCurFilePos*: DWORD
    dwLastMemberOffset*: DWORD
    fEOF*: WINBOOL
    pwszResultDir*: LPWSTR
    hCATStore*: HANDLE
proc WinVerifyTrust*(hwnd: HWND, pgActionID: ptr GUID, pWVTData: LPVOID): LONG {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WinVerifyTrustEx*(hwnd: HWND, pgActionID: ptr GUID, pWinTrustData: ptr WINTRUST_DATA): HRESULT {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WintrustGetRegPolicyFlags*(pdwPolicyFlags: ptr DWORD): void {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WintrustSetRegPolicyFlags*(dwPolicyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WintrustAddActionID*(pgActionID: ptr GUID, fdwFlags: DWORD, psProvInfo: ptr CRYPT_REGISTER_ACTIONID): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WintrustRemoveActionID*(pgActionID: ptr GUID): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WintrustLoadFunctionPointers*(pgActionID: ptr GUID, pPfns: ptr CRYPT_PROVIDER_FUNCTIONS): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WintrustAddDefaultForUsage*(pszUsageOID: ptr char, psDefUsage: ptr CRYPT_PROVIDER_REGDEFUSAGE): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WintrustGetDefaultForUsage*(dwAction: DWORD, pszUsageOID: ptr char, psUsage: ptr CRYPT_PROVIDER_DEFUSAGE): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WTHelperGetProvSignerFromChain*(pProvData: ptr CRYPT_PROVIDER_DATA, idxSigner: DWORD, fCounterSigner: WINBOOL, idxCounterSigner: DWORD): ptr CRYPT_PROVIDER_SGNR {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WTHelperGetProvCertFromChain*(pSgnr: ptr CRYPT_PROVIDER_SGNR, idxCert: DWORD): ptr CRYPT_PROVIDER_CERT {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WTHelperProvDataFromStateData*(hStateData: HANDLE): ptr CRYPT_PROVIDER_DATA {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WTHelperGetProvPrivateDataFromChain*(pProvData: ptr CRYPT_PROVIDER_DATA, pgProviderID: ptr GUID): ptr CRYPT_PROVIDER_PRIVDATA {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WTHelperCertIsSelfSigned*(dwEncoding: DWORD, pCert: ptr CERT_INFO): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WTHelperCertCheckValidSignature*(pProvData: ptr CRYPT_PROVIDER_DATA): HRESULT {.winapi, stdcall, dynlib: "wintrust", importc.}
proc WintrustSetDefaultIncludePEPageHashes*(fIncludePEPageHashes: WINBOOL): void {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptSIPGetSignedDataMsg*(pSubjectInfo: ptr SIP_SUBJECTINFO, pdwEncodingType: ptr DWORD, dwIndex: DWORD, pcbSignedDataMsg: ptr DWORD, pbSignedDataMsg: ptr BYTE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPPutSignedDataMsg*(pSubjectInfo: ptr SIP_SUBJECTINFO, dwEncodingType: DWORD, pdwIndex: ptr DWORD, cbSignedDataMsg: DWORD, pbSignedDataMsg: ptr BYTE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPCreateIndirectData*(pSubjectInfo: ptr SIP_SUBJECTINFO, pcbIndirectData: ptr DWORD, pIndirectData: ptr SIP_INDIRECT_DATA): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPVerifyIndirectData*(pSubjectInfo: ptr SIP_SUBJECTINFO, pIndirectData: ptr SIP_INDIRECT_DATA): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPRemoveSignedDataMsg*(pSubjectInfo: ptr SIP_SUBJECTINFO, dwIndex: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPLoad*(pgSubject: ptr GUID, dwFlags: DWORD, pSipDispatch: ptr SIP_DISPATCH_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPRetrieveSubjectGuid*(FileName: LPCWSTR, hFileIn: HANDLE, pgSubject: ptr GUID): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPRetrieveSubjectGuidForCatalogFile*(FileName: LPCWSTR, hFileIn: HANDLE, pgSubject: ptr GUID): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPAddProvider*(psNewProv: ptr SIP_ADD_NEWPROVIDER): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSIPRemoveProvider*(pgProv: ptr GUID): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptCATAdminAcquireContext*(P1: ptr HCATADMIN, P2: ptr GUID, P3: DWORD): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATAdminAddCatalog*(P1: HCATADMIN, P2: PWSTR, P3: PWSTR, P4: DWORD): HCATINFO {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATAdminCalcHashFromFileHandle*(P1: HANDLE, P2: ptr DWORD, P3: ptr BYTE, P4: DWORD): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATAdminEnumCatalogFromHash*(P1: HCATADMIN, P2: ptr BYTE, P3: DWORD, P4: DWORD, P5: ptr HCATINFO): HCATINFO {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATAdminReleaseCatalogContext*(P1: HCATADMIN, P2: HCATINFO, P3: DWORD): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATAdminReleaseContext*(P1: HCATADMIN, P2: DWORD): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATAdminRemoveCatalog*(P1: HCATADMIN, P2: LPCWSTR, P3: DWORD): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATAdminResolveCatalogPath*(P1: HCATADMIN, P2: ptr WCHAR, P3: ptr CATALOG_INFO, P4: DWORD): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATCatalogInfoFromContext*(P1: HCATINFO, P2: ptr CATALOG_INFO, P3: DWORD): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATCDFClose*(P1: ptr CRYPTCATCDF): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATCDFEnumMembersByCDFTagEx*(P1: ptr CRYPTCATCDF, P2: LPWSTR, P3: PFN_CDF_PARSE_ERROR_CALLBACK, P4: ptr ptr CRYPTCATMEMBER, P5: WINBOOL, P6: LPVOID): LPWSTR {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATClose*(P1: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptCATOpen*(P1: LPWSTR, P2: DWORD, P3: HCRYPTPROV, P4: DWORD, P5: DWORD): HANDLE {.winapi, stdcall, dynlib: "wintrust", importc.}
proc `pFile=`*(self: var WINTRUST_DATA, x: ptr WINTRUST_FILE_INFO) {.inline.} = self.union1.pFile = x
proc pFile*(self: WINTRUST_DATA): ptr WINTRUST_FILE_INFO {.inline.} = self.union1.pFile
proc pFile*(self: var WINTRUST_DATA): var ptr WINTRUST_FILE_INFO {.inline.} = self.union1.pFile
proc `pCatalog=`*(self: var WINTRUST_DATA, x: ptr WINTRUST_CATALOG_INFO) {.inline.} = self.union1.pCatalog = x
proc pCatalog*(self: WINTRUST_DATA): ptr WINTRUST_CATALOG_INFO {.inline.} = self.union1.pCatalog
proc pCatalog*(self: var WINTRUST_DATA): var ptr WINTRUST_CATALOG_INFO {.inline.} = self.union1.pCatalog
proc `pBlob=`*(self: var WINTRUST_DATA, x: ptr WINTRUST_BLOB_INFO) {.inline.} = self.union1.pBlob = x
proc pBlob*(self: WINTRUST_DATA): ptr WINTRUST_BLOB_INFO {.inline.} = self.union1.pBlob
proc pBlob*(self: var WINTRUST_DATA): var ptr WINTRUST_BLOB_INFO {.inline.} = self.union1.pBlob
proc `pSgnr=`*(self: var WINTRUST_DATA, x: ptr WINTRUST_SGNR_INFO) {.inline.} = self.union1.pSgnr = x
proc pSgnr*(self: WINTRUST_DATA): ptr WINTRUST_SGNR_INFO {.inline.} = self.union1.pSgnr
proc pSgnr*(self: var WINTRUST_DATA): var ptr WINTRUST_SGNR_INFO {.inline.} = self.union1.pSgnr
proc `pCert=`*(self: var WINTRUST_DATA, x: ptr WINTRUST_CERT_INFO) {.inline.} = self.union1.pCert = x
proc pCert*(self: WINTRUST_DATA): ptr WINTRUST_CERT_INFO {.inline.} = self.union1.pCert
proc pCert*(self: var WINTRUST_DATA): var ptr WINTRUST_CERT_INFO {.inline.} = self.union1.pCert
proc `pPDSip=`*(self: var CRYPT_PROVIDER_DATA, x: ptr PROVDATA_SIP) {.inline.} = self.union1.pPDSip = x
proc pPDSip*(self: CRYPT_PROVIDER_DATA): ptr PROVDATA_SIP {.inline.} = self.union1.pPDSip
proc pPDSip*(self: var CRYPT_PROVIDER_DATA): var ptr PROVDATA_SIP {.inline.} = self.union1.pPDSip
proc `pwszUrl=`*(self: var SPC_LINK, x: LPWSTR) {.inline.} = self.union1.pwszUrl = x
proc pwszUrl*(self: SPC_LINK): LPWSTR {.inline.} = self.union1.pwszUrl
proc pwszUrl*(self: var SPC_LINK): var LPWSTR {.inline.} = self.union1.pwszUrl
proc `Moniker=`*(self: var SPC_LINK, x: SPC_SERIALIZED_OBJECT) {.inline.} = self.union1.Moniker = x
proc Moniker*(self: SPC_LINK): SPC_SERIALIZED_OBJECT {.inline.} = self.union1.Moniker
proc Moniker*(self: var SPC_LINK): var SPC_SERIALIZED_OBJECT {.inline.} = self.union1.Moniker
proc `pwszFile=`*(self: var SPC_LINK, x: LPWSTR) {.inline.} = self.union1.pwszFile = x
proc pwszFile*(self: SPC_LINK): LPWSTR {.inline.} = self.union1.pwszFile
proc pwszFile*(self: var SPC_LINK): var LPWSTR {.inline.} = self.union1.pwszFile
proc `psFlat=`*(self: var SIP_SUBJECTINFO, x: ptr MS_ADDINFO_FLAT) {.inline.} = self.union1.psFlat = x
proc psFlat*(self: SIP_SUBJECTINFO): ptr MS_ADDINFO_FLAT {.inline.} = self.union1.psFlat
proc psFlat*(self: var SIP_SUBJECTINFO): var ptr MS_ADDINFO_FLAT {.inline.} = self.union1.psFlat
proc `psCatMember=`*(self: var SIP_SUBJECTINFO, x: ptr MS_ADDINFO_CATALOGMEMBER) {.inline.} = self.union1.psCatMember = x
proc psCatMember*(self: SIP_SUBJECTINFO): ptr MS_ADDINFO_CATALOGMEMBER {.inline.} = self.union1.psCatMember
proc psCatMember*(self: var SIP_SUBJECTINFO): var ptr MS_ADDINFO_CATALOGMEMBER {.inline.} = self.union1.psCatMember
proc `psBlob=`*(self: var SIP_SUBJECTINFO, x: ptr MS_ADDINFO_BLOB) {.inline.} = self.union1.psBlob = x
proc psBlob*(self: SIP_SUBJECTINFO): ptr MS_ADDINFO_BLOB {.inline.} = self.union1.psBlob
proc psBlob*(self: var SIP_SUBJECTINFO): var ptr MS_ADDINFO_BLOB {.inline.} = self.union1.psBlob
