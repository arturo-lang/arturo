#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
#include <wincrypt.h>
#include <bcrypt.h>
#include <ncrypt.h>
#include <dpapi.h>
type
  ALG_ID* = int32
  HASHALGORITHM_ENUM* = int32
  DSAFIPSVERSION_ENUM* = int32
  HCRYPTOIDFUNCSET* = pointer
  HCRYPTOIDFUNCADDR* = pointer
  HCRYPTMSG* = pointer
  HCERTSTORE* = pointer
  HCERTSTOREPROV* = pointer
  HCRYPTDEFAULTCONTEXT* = pointer
  HCERT_SERVER_OCSP_RESPONSE* = pointer
  PRKEVENT* = pointer
  HCRYPTHASH* = ULONG_PTR
  HCRYPTKEY* = ULONG_PTR
  HCRYPTPROV* = ULONG_PTR
  HCRYPTPROV_OR_NCRYPT_KEY_HANDLE* = ULONG_PTR
  HCRYPTPROV_LEGACY* = ULONG_PTR
  BCRYPT_HANDLE* = PVOID
  BCRYPT_ALG_HANDLE* = PVOID
  BCRYPT_KEY_HANDLE* = PVOID
  BCRYPT_HASH_HANDLE* = PVOID
  BCRYPT_SECRET_HANDLE* = PVOID
  SECURITY_STATUS* = LONG
  NCRYPT_HANDLE* = ULONG_PTR
  NCRYPT_PROV_HANDLE* = ULONG_PTR
  NCRYPT_KEY_HANDLE* = ULONG_PTR
  NCRYPT_HASH_HANDLE* = ULONG_PTR
  NCRYPT_SECRET_HANDLE* = ULONG_PTR
  HCRYPTASYNC* = HANDLE
  PHCRYPTASYNC* = ptr HANDLE
  HCERTCHAINENGINE* = HANDLE
  CMS_KEY_INFO* {.pure.} = object
    dwVersion*: DWORD
    Algid*: ALG_ID
    pbOID*: ptr BYTE
    cbOID*: DWORD
  PCMS_KEY_INFO* = ptr CMS_KEY_INFO
  HMAC_INFO* {.pure.} = object
    HashAlgid*: ALG_ID
    pbInnerString*: ptr BYTE
    cbInnerString*: DWORD
    pbOuterString*: ptr BYTE
    cbOuterString*: DWORD
  PHMAC_INFO* = ptr HMAC_INFO
  SCHANNEL_ALG* {.pure.} = object
    dwUse*: DWORD
    Algid*: ALG_ID
    cBits*: DWORD
    dwFlags*: DWORD
    dwReserved*: DWORD
  PSCHANNEL_ALG* = ptr SCHANNEL_ALG
  BLOBHEADER* {.pure.} = object
    bType*: BYTE
    bVersion*: BYTE
    reserved*: WORD
    aiKeyAlg*: ALG_ID
  PUBLICKEYSTRUC* = BLOBHEADER
  DHPUBKEY* {.pure.} = object
    magic*: DWORD
    bitlen*: DWORD
  DSSPUBKEY* = DHPUBKEY
  KEAPUBKEY* = DHPUBKEY
  TEKPUBKEY* = DHPUBKEY
  DSSSEED* {.pure.} = object
    counter*: DWORD
    seed*: array[20, BYTE]
  DHPUBKEY_VER3* {.pure.} = object
    magic*: DWORD
    bitlenP*: DWORD
    bitlenQ*: DWORD
    bitlenJ*: DWORD
    DSSSeed*: DSSSEED
  DSSPUBKEY_VER3* = DHPUBKEY_VER3
  DHPRIVKEY_VER3* {.pure.} = object
    magic*: DWORD
    bitlenP*: DWORD
    bitlenQ*: DWORD
    bitlenJ*: DWORD
    bitlenX*: DWORD
    DSSSeed*: DSSSEED
  DSSPRIVKEY_VER3* = DHPRIVKEY_VER3
  KEY_TYPE_SUBTYPE* {.pure.} = object
    dwKeySpec*: DWORD
    Type*: GUID
    Subtype*: GUID
  PKEY_TYPE_SUBTYPE* = ptr KEY_TYPE_SUBTYPE
  CRYPT_RC4_KEY_STATE* {.pure.} = object
    Key*: array[16, uint8]
    SBox*: array[256, uint8]
    i*: uint8
    j*: uint8
  PCRYPT_RC4_KEY_STATE* = ptr CRYPT_RC4_KEY_STATE
  CRYPT_DES_KEY_STATE* {.pure.} = object
    Key*: array[8, uint8]
    IV*: array[8, uint8]
    Feedback*: array[8, uint8]
  PCRYPT_DES_KEY_STATE* = ptr CRYPT_DES_KEY_STATE
  CRYPT_3DES_KEY_STATE* {.pure.} = object
    Key*: array[24, uint8]
    IV*: array[8, uint8]
    Feedback*: array[8, uint8]
  PCRYPT_3DES_KEY_STATE* = ptr CRYPT_3DES_KEY_STATE
  CRYPT_AES_128_KEY_STATE* {.pure.} = object
    Key*: array[16, uint8]
    IV*: array[16, uint8]
    EncryptionState*: array[11, array[16, uint8]]
    DecryptionState*: array[11, array[16, uint8]]
    Feedback*: array[16, uint8]
  PCRYPT_AES_128_KEY_STATE* = ptr CRYPT_AES_128_KEY_STATE
  CRYPT_AES_256_KEY_STATE* {.pure.} = object
    Key*: array[32, uint8]
    IV*: array[16, uint8]
    EncryptionState*: array[15, array[16, uint8]]
    DecryptionState*: array[15, array[16, uint8]]
    Feedback*: array[16, uint8]
  PCRYPT_AES_256_KEY_STATE* = ptr CRYPT_AES_256_KEY_STATE
  CRYPT_INTEGER_BLOB* {.pure.} = object
    cbData*: DWORD
    pbData*: ptr BYTE
  PCRYPT_INTEGER_BLOB* = ptr CRYPT_INTEGER_BLOB
  CRYPT_UINT_BLOB* = CRYPT_INTEGER_BLOB
  PCRYPT_UINT_BLOB* = ptr CRYPT_INTEGER_BLOB
  CRYPT_OBJID_BLOB* = CRYPT_INTEGER_BLOB
  PCRYPT_OBJID_BLOB* = ptr CRYPT_INTEGER_BLOB
  CERT_NAME_BLOB* = CRYPT_INTEGER_BLOB
  PCERT_NAME_BLOB* = ptr CRYPT_INTEGER_BLOB
  CERT_RDN_VALUE_BLOB* = CRYPT_INTEGER_BLOB
  PCERT_RDN_VALUE_BLOB* = ptr CRYPT_INTEGER_BLOB
  CERT_BLOB* = CRYPT_INTEGER_BLOB
  PCERT_BLOB* = ptr CRYPT_INTEGER_BLOB
  CRL_BLOB* = CRYPT_INTEGER_BLOB
  PCRL_BLOB* = ptr CRYPT_INTEGER_BLOB
  DATA_BLOB* = CRYPT_INTEGER_BLOB
  PDATA_BLOB* = ptr CRYPT_INTEGER_BLOB
  CRYPT_DATA_BLOB* = CRYPT_INTEGER_BLOB
  PCRYPT_DATA_BLOB* = ptr CRYPT_INTEGER_BLOB
  CRYPT_HASH_BLOB* = CRYPT_INTEGER_BLOB
  PCRYPT_HASH_BLOB* = ptr CRYPT_INTEGER_BLOB
  CRYPT_DIGEST_BLOB* = CRYPT_INTEGER_BLOB
  PCRYPT_DIGEST_BLOB* = ptr CRYPT_INTEGER_BLOB
  CRYPT_DER_BLOB* = CRYPT_INTEGER_BLOB
  PCRYPT_DER_BLOB* = ptr CRYPT_INTEGER_BLOB
  CRYPT_ATTR_BLOB* = CRYPT_INTEGER_BLOB
  PCRYPT_ATTR_BLOB* = ptr CRYPT_INTEGER_BLOB
  CMS_DH_KEY_INFO* {.pure.} = object
    dwVersion*: DWORD
    Algid*: ALG_ID
    pszContentEncObjId*: LPSTR
    PubInfo*: CRYPT_DATA_BLOB
    pReserved*: pointer
  PCMS_DH_KEY_INFO* = ptr CMS_DH_KEY_INFO
  BCRYPT_KEY_LENGTHS_STRUCT* {.pure.} = object
    dwMinLength*: ULONG
    dwMaxLength*: ULONG
    dwIncrement*: ULONG
  BCRYPT_AUTH_TAG_LENGTHS_STRUCT* = BCRYPT_KEY_LENGTHS_STRUCT
  BCRYPT_AUTHENTICATED_CIPHER_MODE_INFO* {.pure.} = object
    cbSize*: ULONG
    dwInfoVersion*: ULONG
    pbNonce*: PUCHAR
    cbNonce*: ULONG
    pbAuthData*: PUCHAR
    cbAuthData*: ULONG
    pbTag*: PUCHAR
    cbTag*: ULONG
    pbMacContext*: PUCHAR
    cbMacContext*: ULONG
    cbAAD*: ULONG
    cbData*: ULONGLONG
    dwFlags*: ULONG
  PBCRYPT_AUTHENTICATED_CIPHER_MODE_INFO* = ptr BCRYPT_AUTHENTICATED_CIPHER_MODE_INFO
  BCryptBuffer* {.pure.} = object
    cbBuffer*: ULONG
    BufferType*: ULONG
    pvBuffer*: PVOID
  PBCryptBuffer* = ptr BCryptBuffer
  BCryptBufferDesc* {.pure.} = object
    ulVersion*: ULONG
    cBuffers*: ULONG
    pBuffers*: PBCryptBuffer
  PBCryptBufferDesc* = ptr BCryptBufferDesc
  BCRYPT_ECCKEY_BLOB* {.pure.} = object
    dwMagic*: ULONG
    cbKey*: ULONG
  PBCRYPT_ECCKEY_BLOB* = ptr BCRYPT_ECCKEY_BLOB
  BCRYPT_DH_KEY_BLOB* {.pure.} = object
    dwMagic*: ULONG
    cbKey*: ULONG
  PBCRYPT_DH_KEY_BLOB* = ptr BCRYPT_DH_KEY_BLOB
  BCRYPT_DSA_KEY_BLOB* {.pure.} = object
    dwMagic*: ULONG
    cbKey*: ULONG
    Count*: array[4, UCHAR]
    Seed*: array[20, UCHAR]
    q*: array[20, UCHAR]
  PBCRYPT_DSA_KEY_BLOB* = ptr BCRYPT_DSA_KEY_BLOB
  BCRYPT_DSA_KEY_BLOB_V2* {.pure.} = object
    dwMagic*: ULONG
    cbKey*: ULONG
    hashAlgorithm*: HASHALGORITHM_ENUM
    standardVersion*: DSAFIPSVERSION_ENUM
    cbSeedLength*: ULONG
    cbGroupSize*: ULONG
    Count*: array[4, UCHAR]
  PBCRYPT_DSA_KEY_BLOB_V2* = ptr BCRYPT_DSA_KEY_BLOB_V2
  BCRYPT_KEY_DATA_BLOB_HEADER* {.pure.} = object
    dwMagic*: ULONG
    dwVersion*: ULONG
    cbKeyData*: ULONG
  PBCRYPT_KEY_DATA_BLOB_HEADER* = ptr BCRYPT_KEY_DATA_BLOB_HEADER
  BCRYPT_INTERFACE_VERSION* {.pure.} = object
    MajorVersion*: USHORT
    MinorVersion*: USHORT
  PBCRYPT_INTERFACE_VERSION* = ptr BCRYPT_INTERFACE_VERSION
  CRYPT_INTERFACE_REG* {.pure.} = object
    dwInterface*: ULONG
    dwFlags*: ULONG
    cFunctions*: ULONG
    rgpszFunctions*: ptr PWSTR
  PCRYPT_INTERFACE_REG* = ptr CRYPT_INTERFACE_REG
  CRYPT_IMAGE_REG* {.pure.} = object
    pszImage*: PWSTR
    cInterfaces*: ULONG
    rgpInterfaces*: ptr PCRYPT_INTERFACE_REG
  PCRYPT_IMAGE_REG* = ptr CRYPT_IMAGE_REG
  CRYPT_PROVIDER_REG* {.pure.} = object
    cAliases*: ULONG
    rgpszAliases*: ptr PWSTR
    pUM*: PCRYPT_IMAGE_REG
    pKM*: PCRYPT_IMAGE_REG
  PCRYPT_PROVIDER_REG* = ptr CRYPT_PROVIDER_REG
  CRYPT_PROVIDERS* {.pure.} = object
    cProviders*: ULONG
    rgpszProviders*: ptr PWSTR
  PCRYPT_PROVIDERS* = ptr CRYPT_PROVIDERS
  CRYPT_CONTEXT_CONFIG* {.pure.} = object
    dwFlags*: ULONG
    dwReserved*: ULONG
  PCRYPT_CONTEXT_CONFIG* = ptr CRYPT_CONTEXT_CONFIG
  CRYPT_CONTEXT_FUNCTION_CONFIG* {.pure.} = object
    dwFlags*: ULONG
    dwReserved*: ULONG
  PCRYPT_CONTEXT_FUNCTION_CONFIG* = ptr CRYPT_CONTEXT_FUNCTION_CONFIG
  CRYPT_CONTEXTS* {.pure.} = object
    cContexts*: ULONG
    rgpszContexts*: ptr PWSTR
  PCRYPT_CONTEXTS* = ptr CRYPT_CONTEXTS
  CRYPT_CONTEXT_FUNCTIONS* {.pure.} = object
    cFunctions*: ULONG
    rgpszFunctions*: ptr PWSTR
  PCRYPT_CONTEXT_FUNCTIONS* = ptr CRYPT_CONTEXT_FUNCTIONS
  CRYPT_CONTEXT_FUNCTION_PROVIDERS* {.pure.} = object
    cProviders*: ULONG
    rgpszProviders*: ptr PWSTR
  PCRYPT_CONTEXT_FUNCTION_PROVIDERS* = ptr CRYPT_CONTEXT_FUNCTION_PROVIDERS
  CRYPT_PROPERTY_REF* {.pure.} = object
    pszProperty*: PWSTR
    cbValue*: ULONG
    pbValue*: PUCHAR
  PCRYPT_PROPERTY_REF* = ptr CRYPT_PROPERTY_REF
  CRYPT_IMAGE_REF* {.pure.} = object
    pszImage*: PWSTR
    dwFlags*: ULONG
  PCRYPT_IMAGE_REF* = ptr CRYPT_IMAGE_REF
  CRYPT_PROVIDER_REF* {.pure.} = object
    dwInterface*: ULONG
    pszFunction*: PWSTR
    pszProvider*: PWSTR
    cProperties*: ULONG
    rgpProperties*: ptr PCRYPT_PROPERTY_REF
    pUM*: PCRYPT_IMAGE_REF
    pKM*: PCRYPT_IMAGE_REF
  PCRYPT_PROVIDER_REF* = ptr CRYPT_PROVIDER_REF
  CRYPT_PROVIDER_REFS* {.pure.} = object
    cProviders*: ULONG
    rgpProviders*: ptr PCRYPT_PROVIDER_REF
  PCRYPT_PROVIDER_REFS* = ptr CRYPT_PROVIDER_REFS
  NCryptBuffer* = BCryptBuffer
  PNCryptBuffer* = ptr BCryptBuffer
  NCryptBufferDesc* = BCryptBufferDesc
  PNCryptBufferDesc* = ptr BCryptBufferDesc
  NCRYPT_CIPHER_PADDING_INFO* {.pure.} = object
    cbSize*: ULONG
    dwFlags*: DWORD
    pbIV*: PUCHAR
    cbIV*: ULONG
    pbOtherInfo*: PUCHAR
    cbOtherInfo*: ULONG
  PNCRYPT_CIPHER_PADDING_INFO* = ptr NCRYPT_CIPHER_PADDING_INFO
  NCRYPT_KEY_BLOB_HEADER* {.pure.} = object
    cbSize*: ULONG
    dwMagic*: ULONG
    cbAlgName*: ULONG
    cbKeyData*: ULONG
  PNCRYPT_KEY_BLOB_HEADER* = ptr NCRYPT_KEY_BLOB_HEADER
  CRYPT_BIT_BLOB* {.pure.} = object
    cbData*: DWORD
    pbData*: ptr BYTE
    cUnusedBits*: DWORD
  PCRYPT_BIT_BLOB* = ptr CRYPT_BIT_BLOB
  CRYPT_ALGORITHM_IDENTIFIER* {.pure.} = object
    pszObjId*: LPSTR
    Parameters*: CRYPT_OBJID_BLOB
  PCRYPT_ALGORITHM_IDENTIFIER* = ptr CRYPT_ALGORITHM_IDENTIFIER
  CRYPT_OBJID_TABLE* {.pure.} = object
    dwAlgId*: DWORD
    pszObjId*: LPCSTR
  PCRYPT_OBJID_TABLE* = ptr CRYPT_OBJID_TABLE
  CRYPT_HASH_INFO* {.pure.} = object
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    Hash*: CRYPT_HASH_BLOB
  PCRYPT_HASH_INFO* = ptr CRYPT_HASH_INFO
  CERT_EXTENSION* {.pure.} = object
    pszObjId*: LPSTR
    fCritical*: WINBOOL
    Value*: CRYPT_OBJID_BLOB
  PCERT_EXTENSION* = ptr CERT_EXTENSION
  PCCERT_EXTENSION* = ptr CERT_EXTENSION
  CRYPT_ATTRIBUTE_TYPE_VALUE* {.pure.} = object
    pszObjId*: LPSTR
    Value*: CRYPT_OBJID_BLOB
  PCRYPT_ATTRIBUTE_TYPE_VALUE* = ptr CRYPT_ATTRIBUTE_TYPE_VALUE
  CRYPT_ATTRIBUTE* {.pure.} = object
    pszObjId*: LPSTR
    cValue*: DWORD
    rgValue*: PCRYPT_ATTR_BLOB
  PCRYPT_ATTRIBUTE* = ptr CRYPT_ATTRIBUTE
  CRYPT_ATTRIBUTES* {.pure.} = object
    cAttr*: DWORD
    rgAttr*: PCRYPT_ATTRIBUTE
  PCRYPT_ATTRIBUTES* = ptr CRYPT_ATTRIBUTES
  CERT_RDN_ATTR* {.pure.} = object
    pszObjId*: LPSTR
    dwValueType*: DWORD
    Value*: CERT_RDN_VALUE_BLOB
  PCERT_RDN_ATTR* = ptr CERT_RDN_ATTR
  CERT_RDN* {.pure.} = object
    cRDNAttr*: DWORD
    rgRDNAttr*: PCERT_RDN_ATTR
  PCERT_RDN* = ptr CERT_RDN
  CERT_NAME_INFO* {.pure.} = object
    cRDN*: DWORD
    rgRDN*: PCERT_RDN
  PCERT_NAME_INFO* = ptr CERT_NAME_INFO
  CERT_NAME_VALUE* {.pure.} = object
    dwValueType*: DWORD
    Value*: CERT_RDN_VALUE_BLOB
  PCERT_NAME_VALUE* = ptr CERT_NAME_VALUE
  CERT_PUBLIC_KEY_INFO* {.pure.} = object
    Algorithm*: CRYPT_ALGORITHM_IDENTIFIER
    PublicKey*: CRYPT_BIT_BLOB
  PCERT_PUBLIC_KEY_INFO* = ptr CERT_PUBLIC_KEY_INFO
  CRYPT_ECC_PRIVATE_KEY_INFO* {.pure.} = object
    dwVersion*: DWORD
    PrivateKey*: CRYPT_DER_BLOB
    szCurveOid*: LPSTR
    PublicKey*: CRYPT_BIT_BLOB
  PCRYPT_ECC_PRIVATE_KEY_INFO* = ptr CRYPT_ECC_PRIVATE_KEY_INFO
  CRYPT_PRIVATE_KEY_INFO* {.pure.} = object
    Version*: DWORD
    Algorithm*: CRYPT_ALGORITHM_IDENTIFIER
    PrivateKey*: CRYPT_DER_BLOB
    pAttributes*: PCRYPT_ATTRIBUTES
  PCRYPT_PRIVATE_KEY_INFO* = ptr CRYPT_PRIVATE_KEY_INFO
  CRYPT_ENCRYPTED_PRIVATE_KEY_INFO* {.pure.} = object
    EncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    EncryptedPrivateKey*: CRYPT_DATA_BLOB
  PCRYPT_ENCRYPTED_PRIVATE_KEY_INFO* = ptr CRYPT_ENCRYPTED_PRIVATE_KEY_INFO
  PCRYPT_RESOLVE_HCRYPTPROV_FUNC* = proc (pPrivateKeyInfo: ptr CRYPT_PRIVATE_KEY_INFO, phCryptProv: ptr HCRYPTPROV, pVoidResolveFunc: LPVOID): WINBOOL {.stdcall.}
  PCRYPT_DECRYPT_PRIVATE_KEY_FUNC* = proc (Algorithm: CRYPT_ALGORITHM_IDENTIFIER, EncryptedPrivateKey: CRYPT_DATA_BLOB, pbClearTextKey: ptr BYTE, pcbClearTextKey: ptr DWORD, pVoidDecryptFunc: LPVOID): WINBOOL {.stdcall.}
  CRYPT_PKCS8_IMPORT_PARAMS* {.pure.} = object
    PrivateKey*: CRYPT_DIGEST_BLOB
    pResolvehCryptProvFunc*: PCRYPT_RESOLVE_HCRYPTPROV_FUNC
    pVoidResolveFunc*: LPVOID
    pDecryptPrivateKeyFunc*: PCRYPT_DECRYPT_PRIVATE_KEY_FUNC
    pVoidDecryptFunc*: LPVOID
  PCRYPT_PKCS8_IMPORT_PARAMS* = ptr CRYPT_PKCS8_IMPORT_PARAMS
  CRYPT_PRIVATE_KEY_BLOB_AND_PARAMS* = CRYPT_PKCS8_IMPORT_PARAMS
  PCRYPT_PRIVATE_KEY_BLOB_AND_PARAMS* = ptr CRYPT_PKCS8_IMPORT_PARAMS
  PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC* = proc (pAlgorithm: ptr CRYPT_ALGORITHM_IDENTIFIER, pClearTextPrivateKey: ptr CRYPT_DATA_BLOB, pbEncryptedKey: ptr BYTE, pcbEncryptedKey: ptr DWORD, pVoidEncryptFunc: LPVOID): WINBOOL {.stdcall.}
  CRYPT_PKCS8_EXPORT_PARAMS* {.pure.} = object
    hCryptProv*: HCRYPTPROV
    dwKeySpec*: DWORD
    pszPrivateKeyObjId*: LPSTR
    pEncryptPrivateKeyFunc*: PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC
    pVoidEncryptFunc*: LPVOID
  PCRYPT_PKCS8_EXPORT_PARAMS* = ptr CRYPT_PKCS8_EXPORT_PARAMS
  CERT_INFO* {.pure.} = object
    dwVersion*: DWORD
    SerialNumber*: CRYPT_INTEGER_BLOB
    SignatureAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    Issuer*: CERT_NAME_BLOB
    NotBefore*: FILETIME
    NotAfter*: FILETIME
    Subject*: CERT_NAME_BLOB
    SubjectPublicKeyInfo*: CERT_PUBLIC_KEY_INFO
    IssuerUniqueId*: CRYPT_BIT_BLOB
    SubjectUniqueId*: CRYPT_BIT_BLOB
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCERT_INFO* = ptr CERT_INFO
  CRL_ENTRY* {.pure.} = object
    SerialNumber*: CRYPT_INTEGER_BLOB
    RevocationDate*: FILETIME
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCRL_ENTRY* = ptr CRL_ENTRY
  CRL_INFO* {.pure.} = object
    dwVersion*: DWORD
    SignatureAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    Issuer*: CERT_NAME_BLOB
    ThisUpdate*: FILETIME
    NextUpdate*: FILETIME
    cCRLEntry*: DWORD
    rgCRLEntry*: PCRL_ENTRY
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCRL_INFO* = ptr CRL_INFO
  CERT_OR_CRL_BLOB* {.pure.} = object
    dwChoice*: DWORD
    cbEncoded*: DWORD
    pbEncoded*: ptr BYTE
  PCERT_OR_CRL_BLOB* = ptr CERT_OR_CRL_BLOB
  CERT_OR_CRL_BUNDLE* {.pure.} = object
    cItem*: DWORD
    rgItem*: PCERT_OR_CRL_BLOB
  PCERT_OR_CRL_BUNDLE* = ptr CERT_OR_CRL_BUNDLE
  CERT_REQUEST_INFO* {.pure.} = object
    dwVersion*: DWORD
    Subject*: CERT_NAME_BLOB
    SubjectPublicKeyInfo*: CERT_PUBLIC_KEY_INFO
    cAttribute*: DWORD
    rgAttribute*: PCRYPT_ATTRIBUTE
  PCERT_REQUEST_INFO* = ptr CERT_REQUEST_INFO
  CERT_KEYGEN_REQUEST_INFO* {.pure.} = object
    dwVersion*: DWORD
    SubjectPublicKeyInfo*: CERT_PUBLIC_KEY_INFO
    pwszChallengeString*: LPWSTR
  PCERT_KEYGEN_REQUEST_INFO* = ptr CERT_KEYGEN_REQUEST_INFO
  CERT_SIGNED_CONTENT_INFO* {.pure.} = object
    ToBeSigned*: CRYPT_DER_BLOB
    SignatureAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    Signature*: CRYPT_BIT_BLOB
  PCERT_SIGNED_CONTENT_INFO* = ptr CERT_SIGNED_CONTENT_INFO
  CTL_USAGE* {.pure.} = object
    cUsageIdentifier*: DWORD
    rgpszUsageIdentifier*: ptr LPSTR
  PCTL_USAGE* = ptr CTL_USAGE
  CERT_ENHKEY_USAGE* = CTL_USAGE
  PCERT_ENHKEY_USAGE* = ptr CTL_USAGE
  PCCTL_USAGE* = ptr CTL_USAGE
  PCCERT_ENHKEY_USAGE* = ptr CERT_ENHKEY_USAGE
  CTL_ENTRY* {.pure.} = object
    SubjectIdentifier*: CRYPT_DATA_BLOB
    cAttribute*: DWORD
    rgAttribute*: PCRYPT_ATTRIBUTE
  PCTL_ENTRY* = ptr CTL_ENTRY
  CTL_INFO* {.pure.} = object
    dwVersion*: DWORD
    SubjectUsage*: CTL_USAGE
    ListIdentifier*: CRYPT_DATA_BLOB
    SequenceNumber*: CRYPT_INTEGER_BLOB
    ThisUpdate*: FILETIME
    NextUpdate*: FILETIME
    SubjectAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    cCTLEntry*: DWORD
    rgCTLEntry*: PCTL_ENTRY
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCTL_INFO* = ptr CTL_INFO
  CRYPT_TIME_STAMP_REQUEST_INFO* {.pure.} = object
    pszTimeStampAlgorithm*: LPSTR
    pszContentType*: LPSTR
    Content*: CRYPT_OBJID_BLOB
    cAttribute*: DWORD
    rgAttribute*: PCRYPT_ATTRIBUTE
  PCRYPT_TIME_STAMP_REQUEST_INFO* = ptr CRYPT_TIME_STAMP_REQUEST_INFO
  CRYPT_ENROLLMENT_NAME_VALUE_PAIR* {.pure.} = object
    pwszName*: LPWSTR
    pwszValue*: LPWSTR
  PCRYPT_ENROLLMENT_NAME_VALUE_PAIR* = ptr CRYPT_ENROLLMENT_NAME_VALUE_PAIR
  CRYPT_CSP_PROVIDER* {.pure.} = object
    dwKeySpec*: DWORD
    pwszProviderName*: LPWSTR
    Signature*: CRYPT_BIT_BLOB
  PCRYPT_CSP_PROVIDER* = ptr CRYPT_CSP_PROVIDER
  PFN_CRYPT_ALLOC* = proc (cbSize: int): LPVOID {.stdcall.}
  PFN_CRYPT_FREE* = proc (pv: LPVOID): VOID {.stdcall.}
  CRYPT_ENCODE_PARA* {.pure.} = object
    cbSize*: DWORD
    pfnAlloc*: PFN_CRYPT_ALLOC
    pfnFree*: PFN_CRYPT_FREE
  PCRYPT_ENCODE_PARA* = ptr CRYPT_ENCODE_PARA
  CRYPT_DECODE_PARA* {.pure.} = object
    cbSize*: DWORD
    pfnAlloc*: PFN_CRYPT_ALLOC
    pfnFree*: PFN_CRYPT_FREE
  PCRYPT_DECODE_PARA* = ptr CRYPT_DECODE_PARA
  CERT_EXTENSIONS* {.pure.} = object
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCERT_EXTENSIONS* = ptr CERT_EXTENSIONS
  CERT_AUTHORITY_KEY_ID_INFO* {.pure.} = object
    KeyId*: CRYPT_DATA_BLOB
    CertIssuer*: CERT_NAME_BLOB
    CertSerialNumber*: CRYPT_INTEGER_BLOB
  PCERT_AUTHORITY_KEY_ID_INFO* = ptr CERT_AUTHORITY_KEY_ID_INFO
  CERT_PRIVATE_KEY_VALIDITY* {.pure.} = object
    NotBefore*: FILETIME
    NotAfter*: FILETIME
  PCERT_PRIVATE_KEY_VALIDITY* = ptr CERT_PRIVATE_KEY_VALIDITY
  CERT_KEY_ATTRIBUTES_INFO* {.pure.} = object
    KeyId*: CRYPT_DATA_BLOB
    IntendedKeyUsage*: CRYPT_BIT_BLOB
    pPrivateKeyUsagePeriod*: PCERT_PRIVATE_KEY_VALIDITY
  PCERT_KEY_ATTRIBUTES_INFO* = ptr CERT_KEY_ATTRIBUTES_INFO
  CERT_POLICY_ID* {.pure.} = object
    cCertPolicyElementId*: DWORD
    rgpszCertPolicyElementId*: ptr LPSTR
  PCERT_POLICY_ID* = ptr CERT_POLICY_ID
  CERT_KEY_USAGE_RESTRICTION_INFO* {.pure.} = object
    cCertPolicyId*: DWORD
    rgCertPolicyId*: PCERT_POLICY_ID
    RestrictedKeyUsage*: CRYPT_BIT_BLOB
  PCERT_KEY_USAGE_RESTRICTION_INFO* = ptr CERT_KEY_USAGE_RESTRICTION_INFO
  CERT_OTHER_NAME* {.pure.} = object
    pszObjId*: LPSTR
    Value*: CRYPT_OBJID_BLOB
  PCERT_OTHER_NAME* = ptr CERT_OTHER_NAME
  CERT_ALT_NAME_ENTRY_UNION1* {.pure, union.} = object
    pOtherName*: PCERT_OTHER_NAME
    pwszRfc822Name*: LPWSTR
    pwszDNSName*: LPWSTR
    DirectoryName*: CERT_NAME_BLOB
    pwszURL*: LPWSTR
    IPAddress*: CRYPT_DATA_BLOB
    pszRegisteredID*: LPSTR
  CERT_ALT_NAME_ENTRY* {.pure.} = object
    dwAltNameChoice*: DWORD
    union1*: CERT_ALT_NAME_ENTRY_UNION1
  PCERT_ALT_NAME_ENTRY* = ptr CERT_ALT_NAME_ENTRY
  CERT_ALT_NAME_INFO* {.pure.} = object
    cAltEntry*: DWORD
    rgAltEntry*: PCERT_ALT_NAME_ENTRY
  PCERT_ALT_NAME_INFO* = ptr CERT_ALT_NAME_INFO
  CERT_BASIC_CONSTRAINTS_INFO* {.pure.} = object
    SubjectType*: CRYPT_BIT_BLOB
    fPathLenConstraint*: WINBOOL
    dwPathLenConstraint*: DWORD
    cSubtreesConstraint*: DWORD
    rgSubtreesConstraint*: ptr CERT_NAME_BLOB
  PCERT_BASIC_CONSTRAINTS_INFO* = ptr CERT_BASIC_CONSTRAINTS_INFO
  CERT_BASIC_CONSTRAINTS2_INFO* {.pure.} = object
    fCA*: WINBOOL
    fPathLenConstraint*: WINBOOL
    dwPathLenConstraint*: DWORD
  PCERT_BASIC_CONSTRAINTS2_INFO* = ptr CERT_BASIC_CONSTRAINTS2_INFO
  CERT_POLICY_QUALIFIER_INFO* {.pure.} = object
    pszPolicyQualifierId*: LPSTR
    Qualifier*: CRYPT_OBJID_BLOB
  PCERT_POLICY_QUALIFIER_INFO* = ptr CERT_POLICY_QUALIFIER_INFO
  CERT_POLICY_INFO* {.pure.} = object
    pszPolicyIdentifier*: LPSTR
    cPolicyQualifier*: DWORD
    rgPolicyQualifier*: ptr CERT_POLICY_QUALIFIER_INFO
  PCERT_POLICY_INFO* = ptr CERT_POLICY_INFO
  CERT_POLICIES_INFO* {.pure.} = object
    cPolicyInfo*: DWORD
    rgPolicyInfo*: ptr CERT_POLICY_INFO
  PCERT_POLICIES_INFO* = ptr CERT_POLICIES_INFO
  CERT_POLICY_QUALIFIER_NOTICE_REFERENCE* {.pure.} = object
    pszOrganization*: LPSTR
    cNoticeNumbers*: DWORD
    rgNoticeNumbers*: ptr int32
  PCERT_POLICY_QUALIFIER_NOTICE_REFERENCE* = ptr CERT_POLICY_QUALIFIER_NOTICE_REFERENCE
  CERT_POLICY_QUALIFIER_USER_NOTICE* {.pure.} = object
    pNoticeReference*: ptr CERT_POLICY_QUALIFIER_NOTICE_REFERENCE
    pszDisplayText*: LPWSTR
  PCERT_POLICY_QUALIFIER_USER_NOTICE* = ptr CERT_POLICY_QUALIFIER_USER_NOTICE
  CPS_URLS* {.pure.} = object
    pszURL*: LPWSTR
    pAlgorithm*: ptr CRYPT_ALGORITHM_IDENTIFIER
    pDigest*: ptr CRYPT_DATA_BLOB
  PCPS_URLS* = ptr CPS_URLS
  CERT_POLICY95_QUALIFIER1* {.pure.} = object
    pszPracticesReference*: LPWSTR
    pszNoticeIdentifier*: LPSTR
    pszNSINoticeIdentifier*: LPSTR
    cCPSURLs*: DWORD
    rgCPSURLs*: ptr CPS_URLS
  PCERT_POLICY95_QUALIFIER1* = ptr CERT_POLICY95_QUALIFIER1
  CERT_POLICY_MAPPING* {.pure.} = object
    pszIssuerDomainPolicy*: LPSTR
    pszSubjectDomainPolicy*: LPSTR
  PCERT_POLICY_MAPPING* = ptr CERT_POLICY_MAPPING
  CERT_POLICY_MAPPINGS_INFO* {.pure.} = object
    cPolicyMapping*: DWORD
    rgPolicyMapping*: PCERT_POLICY_MAPPING
  PCERT_POLICY_MAPPINGS_INFO* = ptr CERT_POLICY_MAPPINGS_INFO
  CERT_POLICY_CONSTRAINTS_INFO* {.pure.} = object
    fRequireExplicitPolicy*: WINBOOL
    dwRequireExplicitPolicySkipCerts*: DWORD
    fInhibitPolicyMapping*: WINBOOL
    dwInhibitPolicyMappingSkipCerts*: DWORD
  PCERT_POLICY_CONSTRAINTS_INFO* = ptr CERT_POLICY_CONSTRAINTS_INFO
  CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY* {.pure.} = object
    pszObjId*: LPSTR
    cValue*: DWORD
    rgValue*: PCRYPT_DER_BLOB
  PCRYPT_CONTENT_INFO_SEQUENCE_OF_ANY* = ptr CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY
  CRYPT_CONTENT_INFO* {.pure.} = object
    pszObjId*: LPSTR
    Content*: CRYPT_DER_BLOB
  PCRYPT_CONTENT_INFO* = ptr CRYPT_CONTENT_INFO
  CRYPT_SEQUENCE_OF_ANY* {.pure.} = object
    cValue*: DWORD
    rgValue*: PCRYPT_DER_BLOB
  PCRYPT_SEQUENCE_OF_ANY* = ptr CRYPT_SEQUENCE_OF_ANY
  CERT_AUTHORITY_KEY_ID2_INFO* {.pure.} = object
    KeyId*: CRYPT_DATA_BLOB
    AuthorityCertIssuer*: CERT_ALT_NAME_INFO
    AuthorityCertSerialNumber*: CRYPT_INTEGER_BLOB
  PCERT_AUTHORITY_KEY_ID2_INFO* = ptr CERT_AUTHORITY_KEY_ID2_INFO
  CERT_ACCESS_DESCRIPTION* {.pure.} = object
    pszAccessMethod*: LPSTR
    AccessLocation*: CERT_ALT_NAME_ENTRY
  PCERT_ACCESS_DESCRIPTION* = ptr CERT_ACCESS_DESCRIPTION
  CERT_AUTHORITY_INFO_ACCESS* {.pure.} = object
    cAccDescr*: DWORD
    rgAccDescr*: PCERT_ACCESS_DESCRIPTION
  PCERT_AUTHORITY_INFO_ACCESS* = ptr CERT_AUTHORITY_INFO_ACCESS
  CERT_SUBJECT_INFO_ACCESS* = CERT_AUTHORITY_INFO_ACCESS
  PCERT_SUBJECT_INFO_ACCESS* = ptr CERT_AUTHORITY_INFO_ACCESS
  CRL_DIST_POINT_NAME_UNION1* {.pure, union.} = object
    FullName*: CERT_ALT_NAME_INFO
  CRL_DIST_POINT_NAME* {.pure.} = object
    dwDistPointNameChoice*: DWORD
    union1*: CRL_DIST_POINT_NAME_UNION1
  PCRL_DIST_POINT_NAME* = ptr CRL_DIST_POINT_NAME
  CRL_DIST_POINT* {.pure.} = object
    DistPointName*: CRL_DIST_POINT_NAME
    ReasonFlags*: CRYPT_BIT_BLOB
    CRLIssuer*: CERT_ALT_NAME_INFO
  PCRL_DIST_POINT* = ptr CRL_DIST_POINT
  CRL_DIST_POINTS_INFO* {.pure.} = object
    cDistPoint*: DWORD
    rgDistPoint*: PCRL_DIST_POINT
  PCRL_DIST_POINTS_INFO* = ptr CRL_DIST_POINTS_INFO
  CROSS_CERT_DIST_POINTS_INFO* {.pure.} = object
    dwSyncDeltaTime*: DWORD
    cDistPoint*: DWORD
    rgDistPoint*: PCERT_ALT_NAME_INFO
  PCROSS_CERT_DIST_POINTS_INFO* = ptr CROSS_CERT_DIST_POINTS_INFO
  CERT_PAIR* {.pure.} = object
    Forward*: CERT_BLOB
    Reverse*: CERT_BLOB
  PCERT_PAIR* = ptr CERT_PAIR
  CRL_ISSUING_DIST_POINT* {.pure.} = object
    DistPointName*: CRL_DIST_POINT_NAME
    fOnlyContainsUserCerts*: WINBOOL
    fOnlyContainsCACerts*: WINBOOL
    OnlySomeReasonFlags*: CRYPT_BIT_BLOB
    fIndirectCRL*: WINBOOL
  PCRL_ISSUING_DIST_POINT* = ptr CRL_ISSUING_DIST_POINT
  CERT_GENERAL_SUBTREE* {.pure.} = object
    Base*: CERT_ALT_NAME_ENTRY
    dwMinimum*: DWORD
    fMaximum*: WINBOOL
    dwMaximum*: DWORD
  PCERT_GENERAL_SUBTREE* = ptr CERT_GENERAL_SUBTREE
  CERT_NAME_CONSTRAINTS_INFO* {.pure.} = object
    cPermittedSubtree*: DWORD
    rgPermittedSubtree*: PCERT_GENERAL_SUBTREE
    cExcludedSubtree*: DWORD
    rgExcludedSubtree*: PCERT_GENERAL_SUBTREE
  PCERT_NAME_CONSTRAINTS_INFO* = ptr CERT_NAME_CONSTRAINTS_INFO
  CERT_DSS_PARAMETERS* {.pure.} = object
    p*: CRYPT_UINT_BLOB
    q*: CRYPT_UINT_BLOB
    g*: CRYPT_UINT_BLOB
  PCERT_DSS_PARAMETERS* = ptr CERT_DSS_PARAMETERS
  CERT_DH_PARAMETERS* {.pure.} = object
    p*: CRYPT_UINT_BLOB
    g*: CRYPT_UINT_BLOB
  PCERT_DH_PARAMETERS* = ptr CERT_DH_PARAMETERS
  CERT_ECC_SIGNATURE* {.pure.} = object
    r*: CRYPT_UINT_BLOB
    s*: CRYPT_UINT_BLOB
  PCERT_ECC_SIGNATURE* = ptr CERT_ECC_SIGNATURE
  CERT_X942_DH_VALIDATION_PARAMS* {.pure.} = object
    seed*: CRYPT_BIT_BLOB
    pgenCounter*: DWORD
  PCERT_X942_DH_VALIDATION_PARAMS* = ptr CERT_X942_DH_VALIDATION_PARAMS
  CERT_X942_DH_PARAMETERS* {.pure.} = object
    p*: CRYPT_UINT_BLOB
    g*: CRYPT_UINT_BLOB
    q*: CRYPT_UINT_BLOB
    j*: CRYPT_UINT_BLOB
    pValidationParams*: PCERT_X942_DH_VALIDATION_PARAMS
  PCERT_X942_DH_PARAMETERS* = ptr CERT_X942_DH_PARAMETERS
const
  CRYPT_X942_COUNTER_BYTE_LENGTH* = 4
  CRYPT_X942_KEY_LENGTH_BYTE_LENGTH* = 4
type
  CRYPT_X942_OTHER_INFO* {.pure.} = object
    pszContentEncryptionObjId*: LPSTR
    rgbCounter*: array[CRYPT_X942_COUNTER_BYTE_LENGTH, BYTE]
    rgbKeyLength*: array[CRYPT_X942_KEY_LENGTH_BYTE_LENGTH, BYTE]
    PubInfo*: CRYPT_DATA_BLOB
  PCRYPT_X942_OTHER_INFO* = ptr CRYPT_X942_OTHER_INFO
const
  CRYPT_ECC_CMS_SHARED_INFO_SUPPPUBINFO_BYTE_LENGTH* = 4
type
  CRYPT_ECC_CMS_SHARED_INFO* {.pure.} = object
    Algorithm*: CRYPT_ALGORITHM_IDENTIFIER
    EntityUInfo*: CRYPT_DATA_BLOB
    rgbSuppPubInfo*: array[CRYPT_ECC_CMS_SHARED_INFO_SUPPPUBINFO_BYTE_LENGTH, BYTE]
  PCRYPT_ECC_CMS_SHARED_INFO* = ptr CRYPT_ECC_CMS_SHARED_INFO
  CRYPT_RC2_CBC_PARAMETERS* {.pure.} = object
    dwVersion*: DWORD
    fIV*: WINBOOL
    rgbIV*: array[8, BYTE]
  PCRYPT_RC2_CBC_PARAMETERS* = ptr CRYPT_RC2_CBC_PARAMETERS
  CRYPT_SMIME_CAPABILITY* {.pure.} = object
    pszObjId*: LPSTR
    Parameters*: CRYPT_OBJID_BLOB
  PCRYPT_SMIME_CAPABILITY* = ptr CRYPT_SMIME_CAPABILITY
  CRYPT_SMIME_CAPABILITIES* {.pure.} = object
    cCapability*: DWORD
    rgCapability*: PCRYPT_SMIME_CAPABILITY
  PCRYPT_SMIME_CAPABILITIES* = ptr CRYPT_SMIME_CAPABILITIES
  CERT_QC_STATEMENT* {.pure.} = object
    pszStatementId*: LPSTR
    StatementInfo*: CRYPT_OBJID_BLOB
  PCERT_QC_STATEMENT* = ptr CERT_QC_STATEMENT
  CERT_QC_STATEMENTS_EXT_INFO* {.pure.} = object
    cStatement*: DWORD
    rgStatement*: PCERT_QC_STATEMENT
  PCERT_QC_STATEMENTS_EXT_INFO* = ptr CERT_QC_STATEMENTS_EXT_INFO
  CRYPT_MASK_GEN_ALGORITHM* {.pure.} = object
    pszObjId*: LPSTR
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
  PCRYPT_MASK_GEN_ALGORITHM* = ptr CRYPT_MASK_GEN_ALGORITHM
  CRYPT_RSA_SSA_PSS_PARAMETERS* {.pure.} = object
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    MaskGenAlgorithm*: CRYPT_MASK_GEN_ALGORITHM
    dwSaltLength*: DWORD
    dwTrailerField*: DWORD
  PCRYPT_RSA_SSA_PSS_PARAMETERS* = ptr CRYPT_RSA_SSA_PSS_PARAMETERS
  CRYPT_PSOURCE_ALGORITHM* {.pure.} = object
    pszObjId*: LPSTR
    EncodingParameters*: CRYPT_DATA_BLOB
  PCRYPT_PSOURCE_ALGORITHM* = ptr CRYPT_PSOURCE_ALGORITHM
  CRYPT_RSAES_OAEP_PARAMETERS* {.pure.} = object
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    MaskGenAlgorithm*: CRYPT_MASK_GEN_ALGORITHM
    PSourceAlgorithm*: CRYPT_PSOURCE_ALGORITHM
  PCRYPT_RSAES_OAEP_PARAMETERS* = ptr CRYPT_RSAES_OAEP_PARAMETERS
  CMC_TAGGED_ATTRIBUTE* {.pure.} = object
    dwBodyPartID*: DWORD
    Attribute*: CRYPT_ATTRIBUTE
  PCMC_TAGGED_ATTRIBUTE* = ptr CMC_TAGGED_ATTRIBUTE
  CMC_TAGGED_CERT_REQUEST* {.pure.} = object
    dwBodyPartID*: DWORD
    SignedCertRequest*: CRYPT_DER_BLOB
  PCMC_TAGGED_CERT_REQUEST* = ptr CMC_TAGGED_CERT_REQUEST
  CMC_TAGGED_REQUEST_UNION1* {.pure, union.} = object
    pTaggedCertRequest*: PCMC_TAGGED_CERT_REQUEST
  CMC_TAGGED_REQUEST* {.pure.} = object
    dwTaggedRequestChoice*: DWORD
    union1*: CMC_TAGGED_REQUEST_UNION1
  PCMC_TAGGED_REQUEST* = ptr CMC_TAGGED_REQUEST
  CMC_TAGGED_CONTENT_INFO* {.pure.} = object
    dwBodyPartID*: DWORD
    EncodedContentInfo*: CRYPT_DER_BLOB
  PCMC_TAGGED_CONTENT_INFO* = ptr CMC_TAGGED_CONTENT_INFO
  CMC_TAGGED_OTHER_MSG* {.pure.} = object
    dwBodyPartID*: DWORD
    pszObjId*: LPSTR
    Value*: CRYPT_OBJID_BLOB
  PCMC_TAGGED_OTHER_MSG* = ptr CMC_TAGGED_OTHER_MSG
  CMC_DATA_INFO* {.pure.} = object
    cTaggedAttribute*: DWORD
    rgTaggedAttribute*: PCMC_TAGGED_ATTRIBUTE
    cTaggedRequest*: DWORD
    rgTaggedRequest*: PCMC_TAGGED_REQUEST
    cTaggedContentInfo*: DWORD
    rgTaggedContentInfo*: PCMC_TAGGED_CONTENT_INFO
    cTaggedOtherMsg*: DWORD
    rgTaggedOtherMsg*: PCMC_TAGGED_OTHER_MSG
  PCMC_DATA_INFO* = ptr CMC_DATA_INFO
  CMC_RESPONSE_INFO* {.pure.} = object
    cTaggedAttribute*: DWORD
    rgTaggedAttribute*: PCMC_TAGGED_ATTRIBUTE
    cTaggedContentInfo*: DWORD
    rgTaggedContentInfo*: PCMC_TAGGED_CONTENT_INFO
    cTaggedOtherMsg*: DWORD
    rgTaggedOtherMsg*: PCMC_TAGGED_OTHER_MSG
  PCMC_RESPONSE_INFO* = ptr CMC_RESPONSE_INFO
  CMC_PEND_INFO* {.pure.} = object
    PendToken*: CRYPT_DATA_BLOB
    PendTime*: FILETIME
  PCMC_PEND_INFO* = ptr CMC_PEND_INFO
  CMC_STATUS_INFO_UNION1* {.pure, union.} = object
    dwFailInfo*: DWORD
    pPendInfo*: PCMC_PEND_INFO
  CMC_STATUS_INFO* {.pure.} = object
    dwStatus*: DWORD
    cBodyList*: DWORD
    rgdwBodyList*: ptr DWORD
    pwszStatusString*: LPWSTR
    dwOtherInfoChoice*: DWORD
    union1*: CMC_STATUS_INFO_UNION1
  PCMC_STATUS_INFO* = ptr CMC_STATUS_INFO
  CMC_ADD_EXTENSIONS_INFO* {.pure.} = object
    dwCmcDataReference*: DWORD
    cCertReference*: DWORD
    rgdwCertReference*: ptr DWORD
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCMC_ADD_EXTENSIONS_INFO* = ptr CMC_ADD_EXTENSIONS_INFO
  CMC_ADD_ATTRIBUTES_INFO* {.pure.} = object
    dwCmcDataReference*: DWORD
    cCertReference*: DWORD
    rgdwCertReference*: ptr DWORD
    cAttribute*: DWORD
    rgAttribute*: PCRYPT_ATTRIBUTE
  PCMC_ADD_ATTRIBUTES_INFO* = ptr CMC_ADD_ATTRIBUTES_INFO
  CERT_TEMPLATE_EXT* {.pure.} = object
    pszObjId*: LPSTR
    dwMajorVersion*: DWORD
    fMinorVersion*: WINBOOL
    dwMinorVersion*: DWORD
  PCERT_TEMPLATE_EXT* = ptr CERT_TEMPLATE_EXT
  CERT_HASHED_URL* {.pure.} = object
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    Hash*: CRYPT_HASH_BLOB
    pwszUrl*: LPWSTR
  PCERT_HASHED_URL* = ptr CERT_HASHED_URL
  CERT_LOGOTYPE_DETAILS* {.pure.} = object
    pwszMimeType*: LPWSTR
    cHashedUrl*: DWORD
    rgHashedUrl*: PCERT_HASHED_URL
  PCERT_LOGOTYPE_DETAILS* = ptr CERT_LOGOTYPE_DETAILS
  CERT_LOGOTYPE_REFERENCE* {.pure.} = object
    cHashedUrl*: DWORD
    rgHashedUrl*: PCERT_HASHED_URL
  PCERT_LOGOTYPE_REFERENCE* = ptr CERT_LOGOTYPE_REFERENCE
  CERT_LOGOTYPE_IMAGE_INFO_UNION1* {.pure, union.} = object
    dwNumBits*: DWORD
    dwTableSize*: DWORD
  CERT_LOGOTYPE_IMAGE_INFO* {.pure.} = object
    dwLogotypeImageInfoChoice*: DWORD
    dwFileSize*: DWORD
    dwXSize*: DWORD
    dwYSize*: DWORD
    dwLogotypeImageResolutionChoice*: DWORD
    union1*: CERT_LOGOTYPE_IMAGE_INFO_UNION1
    pwszLanguage*: LPWSTR
  PCERT_LOGOTYPE_IMAGE_INFO* = ptr CERT_LOGOTYPE_IMAGE_INFO
  CERT_LOGOTYPE_IMAGE* {.pure.} = object
    LogotypeDetails*: CERT_LOGOTYPE_DETAILS
    pLogotypeImageInfo*: PCERT_LOGOTYPE_IMAGE_INFO
  PCERT_LOGOTYPE_IMAGE* = ptr CERT_LOGOTYPE_IMAGE
  CERT_LOGOTYPE_AUDIO_INFO* {.pure.} = object
    dwFileSize*: DWORD
    dwPlayTime*: DWORD
    dwChannels*: DWORD
    dwSampleRate*: DWORD
    pwszLanguage*: LPWSTR
  PCERT_LOGOTYPE_AUDIO_INFO* = ptr CERT_LOGOTYPE_AUDIO_INFO
  CERT_LOGOTYPE_AUDIO* {.pure.} = object
    LogotypeDetails*: CERT_LOGOTYPE_DETAILS
    pLogotypeAudioInfo*: PCERT_LOGOTYPE_AUDIO_INFO
  PCERT_LOGOTYPE_AUDIO* = ptr CERT_LOGOTYPE_AUDIO
  CERT_LOGOTYPE_DATA* {.pure.} = object
    cLogotypeImage*: DWORD
    rgLogotypeImage*: PCERT_LOGOTYPE_IMAGE
    cLogotypeAudio*: DWORD
    rgLogotypeAudio*: PCERT_LOGOTYPE_AUDIO
  PCERT_LOGOTYPE_DATA* = ptr CERT_LOGOTYPE_DATA
  CERT_LOGOTYPE_INFO_UNION1* {.pure, union.} = object
    pLogotypeDirectInfo*: PCERT_LOGOTYPE_DATA
    pLogotypeIndirectInfo*: PCERT_LOGOTYPE_REFERENCE
  CERT_LOGOTYPE_INFO* {.pure.} = object
    dwLogotypeInfoChoice*: DWORD
    union1*: CERT_LOGOTYPE_INFO_UNION1
  PCERT_LOGOTYPE_INFO* = ptr CERT_LOGOTYPE_INFO
  CERT_OTHER_LOGOTYPE_INFO* {.pure.} = object
    pszObjId*: LPSTR
    LogotypeInfo*: CERT_LOGOTYPE_INFO
  PCERT_OTHER_LOGOTYPE_INFO* = ptr CERT_OTHER_LOGOTYPE_INFO
  CERT_LOGOTYPE_EXT_INFO* {.pure.} = object
    cCommunityLogo*: DWORD
    rgCommunityLogo*: PCERT_LOGOTYPE_INFO
    pIssuerLogo*: PCERT_LOGOTYPE_INFO
    pSubjectLogo*: PCERT_LOGOTYPE_INFO
    cOtherLogo*: DWORD
    rgOtherLogo*: PCERT_OTHER_LOGOTYPE_INFO
  PCERT_LOGOTYPE_EXT_INFO* = ptr CERT_LOGOTYPE_EXT_INFO
  CERT_BIOMETRIC_DATA_UNION1* {.pure, union.} = object
    dwPredefined*: DWORD
    pszObjId*: LPSTR
  CERT_BIOMETRIC_DATA* {.pure.} = object
    dwTypeOfBiometricDataChoice*: DWORD
    union1*: CERT_BIOMETRIC_DATA_UNION1
    HashedUrl*: CERT_HASHED_URL
  PCERT_BIOMETRIC_DATA* = ptr CERT_BIOMETRIC_DATA
  CERT_BIOMETRIC_EXT_INFO* {.pure.} = object
    cBiometricData*: DWORD
    rgBiometricData*: PCERT_BIOMETRIC_DATA
  PCERT_BIOMETRIC_EXT_INFO* = ptr CERT_BIOMETRIC_EXT_INFO
  OCSP_SIGNATURE_INFO* {.pure.} = object
    SignatureAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    Signature*: CRYPT_BIT_BLOB
    cCertEncoded*: DWORD
    rgCertEncoded*: PCERT_BLOB
  POCSP_SIGNATURE_INFO* = ptr OCSP_SIGNATURE_INFO
  OCSP_SIGNED_REQUEST_INFO* {.pure.} = object
    ToBeSigned*: CRYPT_DER_BLOB
    pOptionalSignatureInfo*: POCSP_SIGNATURE_INFO
  POCSP_SIGNED_REQUEST_INFO* = ptr OCSP_SIGNED_REQUEST_INFO
  OCSP_CERT_ID* {.pure.} = object
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    IssuerNameHash*: CRYPT_HASH_BLOB
    IssuerKeyHash*: CRYPT_HASH_BLOB
    SerialNumber*: CRYPT_INTEGER_BLOB
  POCSP_CERT_ID* = ptr OCSP_CERT_ID
  OCSP_REQUEST_ENTRY* {.pure.} = object
    CertId*: OCSP_CERT_ID
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  POCSP_REQUEST_ENTRY* = ptr OCSP_REQUEST_ENTRY
  OCSP_REQUEST_INFO* {.pure.} = object
    dwVersion*: DWORD
    pRequestorName*: PCERT_ALT_NAME_ENTRY
    cRequestEntry*: DWORD
    rgRequestEntry*: POCSP_REQUEST_ENTRY
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  POCSP_REQUEST_INFO* = ptr OCSP_REQUEST_INFO
  OCSP_RESPONSE_INFO* {.pure.} = object
    dwStatus*: DWORD
    pszObjId*: LPSTR
    Value*: CRYPT_OBJID_BLOB
  POCSP_RESPONSE_INFO* = ptr OCSP_RESPONSE_INFO
  OCSP_BASIC_SIGNED_RESPONSE_INFO* {.pure.} = object
    ToBeSigned*: CRYPT_DER_BLOB
    SignatureInfo*: OCSP_SIGNATURE_INFO
  POCSP_BASIC_SIGNED_RESPONSE_INFO* = ptr OCSP_BASIC_SIGNED_RESPONSE_INFO
  OCSP_BASIC_REVOKED_INFO* {.pure.} = object
    RevocationDate*: FILETIME
    dwCrlReasonCode*: DWORD
  POCSP_BASIC_REVOKED_INFO* = ptr OCSP_BASIC_REVOKED_INFO
  OCSP_BASIC_RESPONSE_ENTRY_UNION1* {.pure, union.} = object
    pRevokedInfo*: POCSP_BASIC_REVOKED_INFO
  OCSP_BASIC_RESPONSE_ENTRY* {.pure.} = object
    CertId*: OCSP_CERT_ID
    dwCertStatus*: DWORD
    union1*: OCSP_BASIC_RESPONSE_ENTRY_UNION1
    ThisUpdate*: FILETIME
    NextUpdate*: FILETIME
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  POCSP_BASIC_RESPONSE_ENTRY* = ptr OCSP_BASIC_RESPONSE_ENTRY
  OCSP_BASIC_RESPONSE_INFO_UNION1* {.pure, union.} = object
    ByNameResponderId*: CERT_NAME_BLOB
    ByKeyResponderId*: CRYPT_HASH_BLOB
  OCSP_BASIC_RESPONSE_INFO* {.pure.} = object
    dwVersion*: DWORD
    dwResponderIdChoice*: DWORD
    union1*: OCSP_BASIC_RESPONSE_INFO_UNION1
    ProducedAt*: FILETIME
    cResponseEntry*: DWORD
    rgResponseEntry*: POCSP_BASIC_RESPONSE_ENTRY
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  POCSP_BASIC_RESPONSE_INFO* = ptr OCSP_BASIC_RESPONSE_INFO
  CRYPT_OID_FUNC_ENTRY* {.pure.} = object
    pszOID*: LPCSTR
    pvFuncAddr*: pointer
  PCRYPT_OID_FUNC_ENTRY* = ptr CRYPT_OID_FUNC_ENTRY
  CRYPT_OID_INFO_UNION1* {.pure, union.} = object
    dwValue*: DWORD
    Algid*: ALG_ID
    dwLength*: DWORD
when winimCpu64:
  type
    CRYPT_OID_INFO* {.pure.} = object
      cbSize*: DWORD
      pszOID*: LPCSTR
      pwszName*: LPCWSTR
      dwGroupId*: DWORD
      union1*: CRYPT_OID_INFO_UNION1
      ExtraInfo*: CRYPT_DATA_BLOB
      pwszCNGAlgid*: LPCWSTR
      pwszCNGExtraAlgid*: LPCWSTR
when winimCpu32:
  type
    CRYPT_OID_INFO* {.pure, packed.} = object
      cbSize*: DWORD
      pszOID*: LPCSTR
      pwszName*: LPCWSTR
      dwGroupId*: DWORD
      union1*: CRYPT_OID_INFO_UNION1
      ExtraInfo*: CRYPT_DATA_BLOB
      pwszCNGAlgid*: LPCWSTR
      pwszCNGExtraAlgid*: LPCWSTR
type
  PCRYPT_OID_INFO* = ptr CRYPT_OID_INFO
  CCRYPT_OID_INFO* = CRYPT_OID_INFO
  PCCRYPT_OID_INFO* = ptr CRYPT_OID_INFO
  CERT_STRONG_SIGN_SERIALIZED_INFO* {.pure.} = object
    dwFlags*: DWORD
    pwszCNGSignHashAlgids*: LPWSTR
    pwszCNGPubKeyMinBitLengths*: LPWSTR
  PCERT_STRONG_SIGN_SERIALIZED_INFO* = ptr CERT_STRONG_SIGN_SERIALIZED_INFO
  CERT_STRONG_SIGN_PARA_UNION1* {.pure, union.} = object
    pvInfo*: pointer
    pSerializedInfo*: PCERT_STRONG_SIGN_SERIALIZED_INFO
    pszOID*: LPSTR
  CERT_STRONG_SIGN_PARA* {.pure.} = object
    cbSize*: DWORD
    dwInfoChoice*: DWORD
    union1*: CERT_STRONG_SIGN_PARA_UNION1
  PCERT_STRONG_SIGN_PARA* = ptr CERT_STRONG_SIGN_PARA
  PCCERT_STRONG_SIGN_PARA* = ptr CERT_STRONG_SIGN_PARA
  CERT_ISSUER_SERIAL_NUMBER* {.pure.} = object
    Issuer*: CERT_NAME_BLOB
    SerialNumber*: CRYPT_INTEGER_BLOB
  PCERT_ISSUER_SERIAL_NUMBER* = ptr CERT_ISSUER_SERIAL_NUMBER
  CERT_ID_UNION1* {.pure, union.} = object
    IssuerSerialNumber*: CERT_ISSUER_SERIAL_NUMBER
    KeyId*: CRYPT_HASH_BLOB
    HashId*: CRYPT_HASH_BLOB
  CERT_ID* {.pure.} = object
    dwIdChoice*: DWORD
    union1*: CERT_ID_UNION1
  PCERT_ID* = ptr CERT_ID
  CMSG_SIGNER_ENCODE_INFO_UNION1* {.pure, union.} = object
    hCryptProv*: HCRYPTPROV
    hNCryptKey*: NCRYPT_KEY_HANDLE
  CMSG_SIGNER_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    pCertInfo*: PCERT_INFO
    union1*: CMSG_SIGNER_ENCODE_INFO_UNION1
    dwKeySpec*: DWORD
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo*: pointer
    cAuthAttr*: DWORD
    rgAuthAttr*: PCRYPT_ATTRIBUTE
    cUnauthAttr*: DWORD
    rgUnauthAttr*: PCRYPT_ATTRIBUTE
    SignerId*: CERT_ID
    HashEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvHashEncryptionAuxInfo*: pointer
  PCMSG_SIGNER_ENCODE_INFO* = ptr CMSG_SIGNER_ENCODE_INFO
  CMSG_SIGNED_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    cSigners*: DWORD
    rgSigners*: PCMSG_SIGNER_ENCODE_INFO
    cCertEncoded*: DWORD
    rgCertEncoded*: PCERT_BLOB
    cCrlEncoded*: DWORD
    rgCrlEncoded*: PCRL_BLOB
    cAttrCertEncoded*: DWORD
    rgAttrCertEncoded*: PCERT_BLOB
  PCMSG_SIGNED_ENCODE_INFO* = ptr CMSG_SIGNED_ENCODE_INFO
  CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvKeyEncryptionAuxInfo*: pointer
    hCryptProv*: HCRYPTPROV_LEGACY
    RecipientPublicKey*: CRYPT_BIT_BLOB
    RecipientId*: CERT_ID
  PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO* = ptr CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO
  CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO_UNION1* {.pure, union.} = object
    pEphemeralAlgorithm*: PCRYPT_ALGORITHM_IDENTIFIER
    pSenderId*: PCERT_ID
  CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    RecipientPublicKey*: CRYPT_BIT_BLOB
    RecipientId*: CERT_ID
    Date*: FILETIME
    pOtherAttr*: PCRYPT_ATTRIBUTE_TYPE_VALUE
  PCMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO* = ptr CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO
  CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvKeyEncryptionAuxInfo*: pointer
    KeyWrapAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvKeyWrapAuxInfo*: pointer
    hCryptProv*: HCRYPTPROV_LEGACY
    dwKeySpec*: DWORD
    dwKeyChoice*: DWORD
    union1*: CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO_UNION1
    UserKeyingMaterial*: CRYPT_DATA_BLOB
    cRecipientEncryptedKeys*: DWORD
    rgpRecipientEncryptedKeys*: ptr PCMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO
  PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO* = ptr CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO
  CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO_UNION1* {.pure, union.} = object
    hKeyEncryptionKey*: HCRYPTKEY
    pvKeyEncryptionKey*: pointer
  CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvKeyEncryptionAuxInfo*: pointer
    hCryptProv*: HCRYPTPROV
    dwKeyChoice*: DWORD
    union1*: CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO_UNION1
    KeyId*: CRYPT_DATA_BLOB
    Date*: FILETIME
    pOtherAttr*: PCRYPT_ATTRIBUTE_TYPE_VALUE
  PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO* = ptr CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO
  CMSG_RECIPIENT_ENCODE_INFO_UNION1* {.pure, union.} = object
    pKeyTrans*: PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO
    pKeyAgree*: PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO
    pMailList*: PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO
  CMSG_RECIPIENT_ENCODE_INFO* {.pure.} = object
    dwRecipientChoice*: DWORD
    union1*: CMSG_RECIPIENT_ENCODE_INFO_UNION1
  PCMSG_RECIPIENT_ENCODE_INFO* = ptr CMSG_RECIPIENT_ENCODE_INFO
  CMSG_ENVELOPED_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    hCryptProv*: HCRYPTPROV_LEGACY
    ContentEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvEncryptionAuxInfo*: pointer
    cRecipients*: DWORD
    rgpRecipients*: ptr PCERT_INFO
    rgCmsRecipients*: PCMSG_RECIPIENT_ENCODE_INFO
    cCertEncoded*: DWORD
    rgCertEncoded*: PCERT_BLOB
    cCrlEncoded*: DWORD
    rgCrlEncoded*: PCRL_BLOB
    cAttrCertEncoded*: DWORD
    rgAttrCertEncoded*: PCERT_BLOB
    cUnprotectedAttr*: DWORD
    rgUnprotectedAttr*: PCRYPT_ATTRIBUTE
  PCMSG_ENVELOPED_ENCODE_INFO* = ptr CMSG_ENVELOPED_ENCODE_INFO
  CMSG_RC2_AUX_INFO* {.pure.} = object
    cbSize*: DWORD
    dwBitLen*: DWORD
  PCMSG_RC2_AUX_INFO* = ptr CMSG_RC2_AUX_INFO
  CMSG_SP3_COMPATIBLE_AUX_INFO* {.pure.} = object
    cbSize*: DWORD
    dwFlags*: DWORD
  PCMSG_SP3_COMPATIBLE_AUX_INFO* = ptr CMSG_SP3_COMPATIBLE_AUX_INFO
  CMSG_RC4_AUX_INFO* {.pure.} = object
    cbSize*: DWORD
    dwBitLen*: DWORD
  PCMSG_RC4_AUX_INFO* = ptr CMSG_RC4_AUX_INFO
  CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    SignedInfo*: CMSG_SIGNED_ENCODE_INFO
    EnvelopedInfo*: CMSG_ENVELOPED_ENCODE_INFO
  PCMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO* = ptr CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO
  CMSG_HASHED_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    hCryptProv*: HCRYPTPROV_LEGACY
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo*: pointer
  PCMSG_HASHED_ENCODE_INFO* = ptr CMSG_HASHED_ENCODE_INFO
  CMSG_ENCRYPTED_ENCODE_INFO* {.pure.} = object
    cbSize*: DWORD
    ContentEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvEncryptionAuxInfo*: pointer
  PCMSG_ENCRYPTED_ENCODE_INFO* = ptr CMSG_ENCRYPTED_ENCODE_INFO
  PFN_CMSG_STREAM_OUTPUT* = proc (pvArg: pointer, pbData: ptr BYTE, cbData: DWORD, fFinal: WINBOOL): WINBOOL {.stdcall.}
  CMSG_STREAM_INFO* {.pure.} = object
    cbContent*: DWORD
    pfnStreamOutput*: PFN_CMSG_STREAM_OUTPUT
    pvArg*: pointer
  PCMSG_STREAM_INFO* = ptr CMSG_STREAM_INFO
  CMSG_SIGNER_INFO* {.pure.} = object
    dwVersion*: DWORD
    Issuer*: CERT_NAME_BLOB
    SerialNumber*: CRYPT_INTEGER_BLOB
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    HashEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    EncryptedHash*: CRYPT_DATA_BLOB
    AuthAttrs*: CRYPT_ATTRIBUTES
    UnauthAttrs*: CRYPT_ATTRIBUTES
  PCMSG_SIGNER_INFO* = ptr CMSG_SIGNER_INFO
  CMSG_CMS_SIGNER_INFO* {.pure.} = object
    dwVersion*: DWORD
    SignerId*: CERT_ID
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    HashEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    EncryptedHash*: CRYPT_DATA_BLOB
    AuthAttrs*: CRYPT_ATTRIBUTES
    UnauthAttrs*: CRYPT_ATTRIBUTES
  PCMSG_CMS_SIGNER_INFO* = ptr CMSG_CMS_SIGNER_INFO
  CMSG_ATTR* = CRYPT_ATTRIBUTES
  PCMSG_ATTR* = ptr CRYPT_ATTRIBUTES
  CMSG_KEY_TRANS_RECIPIENT_INFO* {.pure.} = object
    dwVersion*: DWORD
    RecipientId*: CERT_ID
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    EncryptedKey*: CRYPT_DATA_BLOB
  PCMSG_KEY_TRANS_RECIPIENT_INFO* = ptr CMSG_KEY_TRANS_RECIPIENT_INFO
  CMSG_RECIPIENT_ENCRYPTED_KEY_INFO* {.pure.} = object
    RecipientId*: CERT_ID
    EncryptedKey*: CRYPT_DATA_BLOB
    Date*: FILETIME
    pOtherAttr*: PCRYPT_ATTRIBUTE_TYPE_VALUE
  PCMSG_RECIPIENT_ENCRYPTED_KEY_INFO* = ptr CMSG_RECIPIENT_ENCRYPTED_KEY_INFO
  CMSG_KEY_AGREE_RECIPIENT_INFO_UNION1* {.pure, union.} = object
    OriginatorCertId*: CERT_ID
    OriginatorPublicKeyInfo*: CERT_PUBLIC_KEY_INFO
  CMSG_KEY_AGREE_RECIPIENT_INFO* {.pure.} = object
    dwVersion*: DWORD
    dwOriginatorChoice*: DWORD
    union1*: CMSG_KEY_AGREE_RECIPIENT_INFO_UNION1
    UserKeyingMaterial*: CRYPT_DATA_BLOB
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    cRecipientEncryptedKeys*: DWORD
    rgpRecipientEncryptedKeys*: ptr PCMSG_RECIPIENT_ENCRYPTED_KEY_INFO
  PCMSG_KEY_AGREE_RECIPIENT_INFO* = ptr CMSG_KEY_AGREE_RECIPIENT_INFO
  CMSG_MAIL_LIST_RECIPIENT_INFO* {.pure.} = object
    dwVersion*: DWORD
    KeyId*: CRYPT_DATA_BLOB
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    EncryptedKey*: CRYPT_DATA_BLOB
    Date*: FILETIME
    pOtherAttr*: PCRYPT_ATTRIBUTE_TYPE_VALUE
  PCMSG_MAIL_LIST_RECIPIENT_INFO* = ptr CMSG_MAIL_LIST_RECIPIENT_INFO
  CMSG_CMS_RECIPIENT_INFO_UNION1* {.pure, union.} = object
    pKeyTrans*: PCMSG_KEY_TRANS_RECIPIENT_INFO
    pKeyAgree*: PCMSG_KEY_AGREE_RECIPIENT_INFO
    pMailList*: PCMSG_MAIL_LIST_RECIPIENT_INFO
  CMSG_CMS_RECIPIENT_INFO* {.pure.} = object
    dwRecipientChoice*: DWORD
    union1*: CMSG_CMS_RECIPIENT_INFO_UNION1
  PCMSG_CMS_RECIPIENT_INFO* = ptr CMSG_CMS_RECIPIENT_INFO
  CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA* {.pure.} = object
    cbSize*: DWORD
    hCryptProv*: HCRYPTPROV_LEGACY
    dwSignerIndex*: DWORD
    dwSignerType*: DWORD
    pvSigner*: pointer
  PCMSG_CTRL_VERIFY_SIGNATURE_EX_PARA* = ptr CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA
  CMSG_CTRL_DECRYPT_PARA_UNION1* {.pure, union.} = object
    hCryptProv*: HCRYPTPROV
    hNCryptKey*: NCRYPT_KEY_HANDLE
  CMSG_CTRL_DECRYPT_PARA* {.pure.} = object
    cbSize*: DWORD
    union1*: CMSG_CTRL_DECRYPT_PARA_UNION1
    dwKeySpec*: DWORD
    dwRecipientIndex*: DWORD
  PCMSG_CTRL_DECRYPT_PARA* = ptr CMSG_CTRL_DECRYPT_PARA
  CMSG_CTRL_KEY_TRANS_DECRYPT_PARA_UNION1* {.pure, union.} = object
    hCryptProv*: HCRYPTPROV
    hNCryptKey*: NCRYPT_KEY_HANDLE
  CMSG_CTRL_KEY_TRANS_DECRYPT_PARA* {.pure.} = object
    cbSize*: DWORD
    union1*: CMSG_CTRL_KEY_TRANS_DECRYPT_PARA_UNION1
    dwKeySpec*: DWORD
    pKeyTrans*: PCMSG_KEY_TRANS_RECIPIENT_INFO
    dwRecipientIndex*: DWORD
  PCMSG_CTRL_KEY_TRANS_DECRYPT_PARA* = ptr CMSG_CTRL_KEY_TRANS_DECRYPT_PARA
  CMSG_CTRL_KEY_AGREE_DECRYPT_PARA_UNION1* {.pure, union.} = object
    hCryptProv*: HCRYPTPROV
    hNCryptKey*: NCRYPT_KEY_HANDLE
  CMSG_CTRL_KEY_AGREE_DECRYPT_PARA* {.pure.} = object
    cbSize*: DWORD
    union1*: CMSG_CTRL_KEY_AGREE_DECRYPT_PARA_UNION1
    dwKeySpec*: DWORD
    pKeyAgree*: PCMSG_KEY_AGREE_RECIPIENT_INFO
    dwRecipientIndex*: DWORD
    dwRecipientEncryptedKeyIndex*: DWORD
    OriginatorPublicKey*: CRYPT_BIT_BLOB
  PCMSG_CTRL_KEY_AGREE_DECRYPT_PARA* = ptr CMSG_CTRL_KEY_AGREE_DECRYPT_PARA
  CMSG_CTRL_MAIL_LIST_DECRYPT_PARA_UNION1* {.pure, union.} = object
    hKeyEncryptionKey*: HCRYPTKEY
    pvKeyEncryptionKey*: pointer
  CMSG_CTRL_MAIL_LIST_DECRYPT_PARA* {.pure.} = object
    cbSize*: DWORD
    hCryptProv*: HCRYPTPROV
    pMailList*: PCMSG_MAIL_LIST_RECIPIENT_INFO
    dwRecipientIndex*: DWORD
    dwKeyChoice*: DWORD
    union1*: CMSG_CTRL_MAIL_LIST_DECRYPT_PARA_UNION1
  PCMSG_CTRL_MAIL_LIST_DECRYPT_PARA* = ptr CMSG_CTRL_MAIL_LIST_DECRYPT_PARA
  CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA* {.pure.} = object
    cbSize*: DWORD
    dwSignerIndex*: DWORD
    blob*: CRYPT_DATA_BLOB
  PCMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA* = ptr CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA
  CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA* {.pure.} = object
    cbSize*: DWORD
    dwSignerIndex*: DWORD
    dwUnauthAttrIndex*: DWORD
  PCMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA* = ptr CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA
  PFN_CMSG_ALLOC* = proc (cb: int): pointer {.stdcall.}
  PFN_CMSG_FREE* = proc (pv: pointer): void {.stdcall.}
  CMSG_CONTENT_ENCRYPT_INFO_UNION1* {.pure, union.} = object
    hContentEncryptKey*: HCRYPTKEY
    hCNGContentEncryptKey*: BCRYPT_KEY_HANDLE
  CMSG_CONTENT_ENCRYPT_INFO* {.pure.} = object
    cbSize*: DWORD
    hCryptProv*: HCRYPTPROV_LEGACY
    ContentEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvEncryptionAuxInfo*: pointer
    cRecipients*: DWORD
    rgCmsRecipients*: PCMSG_RECIPIENT_ENCODE_INFO
    pfnAlloc*: PFN_CMSG_ALLOC
    pfnFree*: PFN_CMSG_FREE
    dwEncryptFlags*: DWORD
    union1*: CMSG_CONTENT_ENCRYPT_INFO_UNION1
    dwFlags*: DWORD
    fCNG*: WINBOOL
    pbCNGContentEncryptKeyObject*: ptr BYTE
    pbContentEncryptKey*: ptr BYTE
    cbContentEncryptKey*: DWORD
  PCMSG_CONTENT_ENCRYPT_INFO* = ptr CMSG_CONTENT_ENCRYPT_INFO
  CMSG_KEY_TRANS_ENCRYPT_INFO* {.pure.} = object
    cbSize*: DWORD
    dwRecipientIndex*: DWORD
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    EncryptedKey*: CRYPT_DATA_BLOB
    dwFlags*: DWORD
  PCMSG_KEY_TRANS_ENCRYPT_INFO* = ptr CMSG_KEY_TRANS_ENCRYPT_INFO
  CMSG_KEY_AGREE_KEY_ENCRYPT_INFO* {.pure.} = object
    cbSize*: DWORD
    EncryptedKey*: CRYPT_DATA_BLOB
  PCMSG_KEY_AGREE_KEY_ENCRYPT_INFO* = ptr CMSG_KEY_AGREE_KEY_ENCRYPT_INFO
  CMSG_KEY_AGREE_ENCRYPT_INFO_UNION1* {.pure, union.} = object
    OriginatorCertId*: CERT_ID
    OriginatorPublicKeyInfo*: CERT_PUBLIC_KEY_INFO
  CMSG_KEY_AGREE_ENCRYPT_INFO* {.pure.} = object
    cbSize*: DWORD
    dwRecipientIndex*: DWORD
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    UserKeyingMaterial*: CRYPT_DATA_BLOB
    dwOriginatorChoice*: DWORD
    union1*: CMSG_KEY_AGREE_ENCRYPT_INFO_UNION1
    cKeyAgreeKeyEncryptInfo*: DWORD
    rgpKeyAgreeKeyEncryptInfo*: ptr PCMSG_KEY_AGREE_KEY_ENCRYPT_INFO
    dwFlags*: DWORD
  PCMSG_KEY_AGREE_ENCRYPT_INFO* = ptr CMSG_KEY_AGREE_ENCRYPT_INFO
  CMSG_MAIL_LIST_ENCRYPT_INFO* {.pure.} = object
    cbSize*: DWORD
    dwRecipientIndex*: DWORD
    KeyEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    EncryptedKey*: CRYPT_DATA_BLOB
    dwFlags*: DWORD
  PCMSG_MAIL_LIST_ENCRYPT_INFO* = ptr CMSG_MAIL_LIST_ENCRYPT_INFO
  CMSG_CNG_CONTENT_DECRYPT_INFO* {.pure.} = object
    cbSize*: DWORD
    ContentEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pfnAlloc*: PFN_CMSG_ALLOC
    pfnFree*: PFN_CMSG_FREE
    hNCryptKey*: NCRYPT_KEY_HANDLE
    pbContentEncryptKey*: ptr BYTE
    cbContentEncryptKey*: DWORD
    hCNGContentEncryptKey*: BCRYPT_KEY_HANDLE
    pbCNGContentEncryptKeyObject*: ptr BYTE
  PCMSG_CNG_CONTENT_DECRYPT_INFO* = ptr CMSG_CNG_CONTENT_DECRYPT_INFO
  CERT_CONTEXT* {.pure.} = object
    dwCertEncodingType*: DWORD
    pbCertEncoded*: ptr BYTE
    cbCertEncoded*: DWORD
    pCertInfo*: PCERT_INFO
    hCertStore*: HCERTSTORE
  PCERT_CONTEXT* = ptr CERT_CONTEXT
  PCCERT_CONTEXT* = ptr CERT_CONTEXT
  CRL_CONTEXT* {.pure.} = object
    dwCertEncodingType*: DWORD
    pbCrlEncoded*: ptr BYTE
    cbCrlEncoded*: DWORD
    pCrlInfo*: PCRL_INFO
    hCertStore*: HCERTSTORE
  PCRL_CONTEXT* = ptr CRL_CONTEXT
  PCCRL_CONTEXT* = ptr CRL_CONTEXT
  CTL_CONTEXT* {.pure.} = object
    dwMsgAndCertEncodingType*: DWORD
    pbCtlEncoded*: ptr BYTE
    cbCtlEncoded*: DWORD
    pCtlInfo*: PCTL_INFO
    hCertStore*: HCERTSTORE
    hCryptMsg*: HCRYPTMSG
    pbCtlContent*: ptr BYTE
    cbCtlContent*: DWORD
  PCTL_CONTEXT* = ptr CTL_CONTEXT
  PCCTL_CONTEXT* = ptr CTL_CONTEXT
  CRYPT_KEY_PROV_PARAM* {.pure.} = object
    dwParam*: DWORD
    pbData*: ptr BYTE
    cbData*: DWORD
    dwFlags*: DWORD
  PCRYPT_KEY_PROV_PARAM* = ptr CRYPT_KEY_PROV_PARAM
  CRYPT_KEY_PROV_INFO* {.pure.} = object
    pwszContainerName*: LPWSTR
    pwszProvName*: LPWSTR
    dwProvType*: DWORD
    dwFlags*: DWORD
    cProvParam*: DWORD
    rgProvParam*: PCRYPT_KEY_PROV_PARAM
    dwKeySpec*: DWORD
  PCRYPT_KEY_PROV_INFO* = ptr CRYPT_KEY_PROV_INFO
  CERT_KEY_CONTEXT_UNION1* {.pure, union.} = object
    hCryptProv*: HCRYPTPROV
    hNCryptKey*: NCRYPT_KEY_HANDLE
  CERT_KEY_CONTEXT* {.pure.} = object
    cbSize*: DWORD
    union1*: CERT_KEY_CONTEXT_UNION1
    dwKeySpec*: DWORD
  PCERT_KEY_CONTEXT* = ptr CERT_KEY_CONTEXT
  ROOT_INFO_LUID* {.pure.} = object
    LowPart*: DWORD
    HighPart*: LONG
  PROOT_INFO_LUID* = ptr ROOT_INFO_LUID
  CRYPT_SMART_CARD_ROOT_INFO* {.pure.} = object
    rgbCardID*: array[16, BYTE]
    luid*: ROOT_INFO_LUID
  PCRYPT_SMART_CARD_ROOT_INFO* = ptr CRYPT_SMART_CARD_ROOT_INFO
  CERT_SYSTEM_STORE_RELOCATE_PARA_UNION1* {.pure, union.} = object
    hKeyBase*: HKEY
    pvBase*: pointer
  CERT_SYSTEM_STORE_RELOCATE_PARA_UNION2* {.pure, union.} = object
    pvSystemStore*: pointer
    pszSystemStore*: LPCSTR
    pwszSystemStore*: LPCWSTR
  CERT_SYSTEM_STORE_RELOCATE_PARA* {.pure.} = object
    union1*: CERT_SYSTEM_STORE_RELOCATE_PARA_UNION1
    union2*: CERT_SYSTEM_STORE_RELOCATE_PARA_UNION2
  PCERT_SYSTEM_STORE_RELOCATE_PARA* = ptr CERT_SYSTEM_STORE_RELOCATE_PARA
  CERT_REGISTRY_STORE_CLIENT_GPT_PARA* {.pure.} = object
    hKeyBase*: HKEY
    pwszRegPath*: LPWSTR
  PCERT_REGISTRY_STORE_CLIENT_GPT_PARA* = ptr CERT_REGISTRY_STORE_CLIENT_GPT_PARA
  CERT_REGISTRY_STORE_ROAMING_PARA* {.pure.} = object
    hKey*: HKEY
    pwszStoreDirectory*: LPWSTR
  PCERT_REGISTRY_STORE_ROAMING_PARA* = ptr CERT_REGISTRY_STORE_ROAMING_PARA
  CERT_LDAP_STORE_OPENED_PARA* {.pure.} = object
    pvLdapSessionHandle*: pointer
    pwszLdapUrl*: LPCWSTR
  PCERT_LDAP_STORE_OPENED_PARA* = ptr CERT_LDAP_STORE_OPENED_PARA
  CERT_STORE_PROV_INFO* {.pure.} = object
    cbSize*: DWORD
    cStoreProvFunc*: DWORD
    rgpvStoreProvFunc*: ptr pointer
    hStoreProv*: HCERTSTOREPROV
    dwStoreProvFlags*: DWORD
    hStoreProvFuncAddr2*: HCRYPTOIDFUNCADDR
  PCERT_STORE_PROV_INFO* = ptr CERT_STORE_PROV_INFO
  CERT_STORE_PROV_FIND_INFO* {.pure.} = object
    cbSize*: DWORD
    dwMsgAndCertEncodingType*: DWORD
    dwFindFlags*: DWORD
    dwFindType*: DWORD
    pvFindPara*: pointer
  PCERT_STORE_PROV_FIND_INFO* = ptr CERT_STORE_PROV_FIND_INFO
  CCERT_STORE_PROV_FIND_INFO* = CERT_STORE_PROV_FIND_INFO
  PCCERT_STORE_PROV_FIND_INFO* = ptr CERT_STORE_PROV_FIND_INFO
  CRL_FIND_ISSUED_FOR_PARA* {.pure.} = object
    pSubjectCert*: PCCERT_CONTEXT
    pIssuerCert*: PCCERT_CONTEXT
  PCRL_FIND_ISSUED_FOR_PARA* = ptr CRL_FIND_ISSUED_FOR_PARA
  CTL_ANY_SUBJECT_INFO* {.pure.} = object
    SubjectAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    SubjectIdentifier*: CRYPT_DATA_BLOB
  PCTL_ANY_SUBJECT_INFO* = ptr CTL_ANY_SUBJECT_INFO
  CTL_FIND_USAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    SubjectUsage*: CTL_USAGE
    ListIdentifier*: CRYPT_DATA_BLOB
    pSigner*: PCERT_INFO
  PCTL_FIND_USAGE_PARA* = ptr CTL_FIND_USAGE_PARA
  CTL_FIND_SUBJECT_PARA* {.pure.} = object
    cbSize*: DWORD
    pUsagePara*: PCTL_FIND_USAGE_PARA
    dwSubjectType*: DWORD
    pvSubject*: pointer
  PCTL_FIND_SUBJECT_PARA* = ptr CTL_FIND_SUBJECT_PARA
  PFN_CERT_CREATE_CONTEXT_SORT_FUNC* = proc (cbTotalEncoded: DWORD, cbRemainEncoded: DWORD, cEntry: DWORD, pvSort: pointer): WINBOOL {.stdcall.}
  CERT_CREATE_CONTEXT_PARA* {.pure.} = object
    cbSize*: DWORD
    pfnFree*: PFN_CRYPT_FREE
    pvFree*: pointer
    pfnSort*: PFN_CERT_CREATE_CONTEXT_SORT_FUNC
    pvSort*: pointer
  PCERT_CREATE_CONTEXT_PARA* = ptr CERT_CREATE_CONTEXT_PARA
  CERT_SYSTEM_STORE_INFO* {.pure.} = object
    cbSize*: DWORD
  PCERT_SYSTEM_STORE_INFO* = ptr CERT_SYSTEM_STORE_INFO
  CERT_PHYSICAL_STORE_INFO* {.pure.} = object
    cbSize*: DWORD
    pszOpenStoreProvider*: LPSTR
    dwOpenEncodingType*: DWORD
    dwOpenFlags*: DWORD
    OpenParameters*: CRYPT_DATA_BLOB
    dwFlags*: DWORD
    dwPriority*: DWORD
  PCERT_PHYSICAL_STORE_INFO* = ptr CERT_PHYSICAL_STORE_INFO
  CTL_VERIFY_USAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    ListIdentifier*: CRYPT_DATA_BLOB
    cCtlStore*: DWORD
    rghCtlStore*: ptr HCERTSTORE
    cSignerStore*: DWORD
    rghSignerStore*: ptr HCERTSTORE
  PCTL_VERIFY_USAGE_PARA* = ptr CTL_VERIFY_USAGE_PARA
  CTL_VERIFY_USAGE_STATUS* {.pure.} = object
    cbSize*: DWORD
    dwError*: DWORD
    dwFlags*: DWORD
    ppCtl*: ptr PCCTL_CONTEXT
    dwCtlEntryIndex*: DWORD
    ppSigner*: ptr PCCERT_CONTEXT
    dwSignerIndex*: DWORD
  PCTL_VERIFY_USAGE_STATUS* = ptr CTL_VERIFY_USAGE_STATUS
  CERT_REVOCATION_CRL_INFO* {.pure.} = object
    cbSize*: DWORD
    pBaseCrlContext*: PCCRL_CONTEXT
    pDeltaCrlContext*: PCCRL_CONTEXT
    pCrlEntry*: PCRL_ENTRY
    fDeltaCrlEntry*: WINBOOL
  PCERT_REVOCATION_CRL_INFO* = ptr CERT_REVOCATION_CRL_INFO
  CERT_REVOCATION_CHAIN_PARA* {.pure.} = object
    cbSize*: DWORD
    hChainEngine*: HCERTCHAINENGINE
    hAdditionalStore*: HCERTSTORE
    dwChainFlags*: DWORD
    dwUrlRetrievalTimeout*: DWORD
    pftCurrentTime*: LPFILETIME
    pftCacheResync*: LPFILETIME
    cbMaxUrlRetrievalByteCount*: DWORD
  PCERT_REVOCATION_CHAIN_PARA* = ptr CERT_REVOCATION_CHAIN_PARA
  CERT_REVOCATION_PARA* {.pure.} = object
    cbSize*: DWORD
    pIssuerCert*: PCCERT_CONTEXT
    cCertStore*: DWORD
    rgCertStore*: ptr HCERTSTORE
    hCrlStore*: HCERTSTORE
    pftTimeToUse*: LPFILETIME
    dwUrlRetrievalTimeout*: DWORD
    fCheckFreshnessTime*: WINBOOL
    dwFreshnessTime*: DWORD
    pftCurrentTime*: LPFILETIME
    pCrlInfo*: PCERT_REVOCATION_CRL_INFO
    pftCacheResync*: LPFILETIME
    pChainPara*: PCERT_REVOCATION_CHAIN_PARA
  PCERT_REVOCATION_PARA* = ptr CERT_REVOCATION_PARA
  CERT_REVOCATION_STATUS* {.pure.} = object
    cbSize*: DWORD
    dwIndex*: DWORD
    dwError*: DWORD
    dwReason*: DWORD
    fHasFreshnessTime*: WINBOOL
    dwFreshnessTime*: DWORD
  PCERT_REVOCATION_STATUS* = ptr CERT_REVOCATION_STATUS
  CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO* {.pure.} = object
    CertSignHashCNGAlgPropData*: CRYPT_DATA_BLOB
    CertIssuerPubKeyBitLengthPropData*: CRYPT_DATA_BLOB
  PCRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO* = ptr CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO
  CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA* {.pure.} = object
    cOID*: DWORD
    rgpszOID*: ptr LPSTR
  PCRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA* = ptr CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA
  CRYPT_SIGN_MESSAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    dwMsgEncodingType*: DWORD
    pSigningCert*: PCCERT_CONTEXT
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo*: pointer
    cMsgCert*: DWORD
    rgpMsgCert*: ptr PCCERT_CONTEXT
    cMsgCrl*: DWORD
    rgpMsgCrl*: ptr PCCRL_CONTEXT
    cAuthAttr*: DWORD
    rgAuthAttr*: PCRYPT_ATTRIBUTE
    cUnauthAttr*: DWORD
    rgUnauthAttr*: PCRYPT_ATTRIBUTE
    dwFlags*: DWORD
    dwInnerContentType*: DWORD
    HashEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvHashEncryptionAuxInfo*: pointer
  PCRYPT_SIGN_MESSAGE_PARA* = ptr CRYPT_SIGN_MESSAGE_PARA
  PFN_CRYPT_GET_SIGNER_CERTIFICATE* = proc (pvGetArg: pointer, dwCertEncodingType: DWORD, pSignerId: PCERT_INFO, hMsgCertStore: HCERTSTORE): PCCERT_CONTEXT {.stdcall.}
  CRYPT_VERIFY_MESSAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    dwMsgAndCertEncodingType*: DWORD
    hCryptProv*: HCRYPTPROV_LEGACY
    pfnGetSignerCertificate*: PFN_CRYPT_GET_SIGNER_CERTIFICATE
    pvGetArg*: pointer
    pStrongSignPara*: PCCERT_STRONG_SIGN_PARA
  PCRYPT_VERIFY_MESSAGE_PARA* = ptr CRYPT_VERIFY_MESSAGE_PARA
  CRYPT_ENCRYPT_MESSAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    dwMsgEncodingType*: DWORD
    hCryptProv*: HCRYPTPROV_LEGACY
    ContentEncryptionAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvEncryptionAuxInfo*: pointer
    dwFlags*: DWORD
    dwInnerContentType*: DWORD
  PCRYPT_ENCRYPT_MESSAGE_PARA* = ptr CRYPT_ENCRYPT_MESSAGE_PARA
  CRYPT_DECRYPT_MESSAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    dwMsgAndCertEncodingType*: DWORD
    cCertStore*: DWORD
    rghCertStore*: ptr HCERTSTORE
    dwFlags*: DWORD
  PCRYPT_DECRYPT_MESSAGE_PARA* = ptr CRYPT_DECRYPT_MESSAGE_PARA
  CRYPT_HASH_MESSAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    dwMsgEncodingType*: DWORD
    hCryptProv*: HCRYPTPROV_LEGACY
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo*: pointer
  PCRYPT_HASH_MESSAGE_PARA* = ptr CRYPT_HASH_MESSAGE_PARA
  CRYPT_KEY_SIGN_MESSAGE_PARA_UNION1* {.pure, union.} = object
    hCryptProv*: HCRYPTPROV
    hNCryptKey*: NCRYPT_KEY_HANDLE
  CRYPT_KEY_SIGN_MESSAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    dwMsgAndCertEncodingType*: DWORD
    union1*: CRYPT_KEY_SIGN_MESSAGE_PARA_UNION1
    dwKeySpec*: DWORD
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo*: pointer
    PubKeyAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
  PCRYPT_KEY_SIGN_MESSAGE_PARA* = ptr CRYPT_KEY_SIGN_MESSAGE_PARA
  CRYPT_KEY_VERIFY_MESSAGE_PARA* {.pure.} = object
    cbSize*: DWORD
    dwMsgEncodingType*: DWORD
    hCryptProv*: HCRYPTPROV_LEGACY
  PCRYPT_KEY_VERIFY_MESSAGE_PARA* = ptr CRYPT_KEY_VERIFY_MESSAGE_PARA
  CERT_CHAIN* {.pure.} = object
    cCerts*: DWORD
    certs*: PCERT_BLOB
    keyLocatorInfo*: CRYPT_KEY_PROV_INFO
  PCERT_CHAIN* = ptr CERT_CHAIN
  CRYPT_BLOB_ARRAY* {.pure.} = object
    cBlob*: DWORD
    rgBlob*: PCRYPT_DATA_BLOB
  PCRYPT_BLOB_ARRAY* = ptr CRYPT_BLOB_ARRAY
  CRYPT_CREDENTIALS* {.pure.} = object
    cbSize*: DWORD
    pszCredentialsOid*: LPCSTR
    pvCredentials*: LPVOID
  PCRYPT_CREDENTIALS* = ptr CRYPT_CREDENTIALS
  CRYPT_PASSWORD_CREDENTIALSA* {.pure.} = object
    cbSize*: DWORD
    pszUsername*: LPSTR
    pszPassword*: LPSTR
  PCRYPT_PASSWORD_CREDENTIALSA* = ptr CRYPT_PASSWORD_CREDENTIALSA
  CRYPT_PASSWORD_CREDENTIALSW* {.pure.} = object
    cbSize*: DWORD
    pszUsername*: LPWSTR
    pszPassword*: LPWSTR
  PCRYPT_PASSWORD_CREDENTIALSW* = ptr CRYPT_PASSWORD_CREDENTIALSW
  CRYPTNET_URL_CACHE_PRE_FETCH_INFO* {.pure.} = object
    cbSize*: DWORD
    dwObjectType*: DWORD
    dwError*: DWORD
    dwReserved*: DWORD
    ThisUpdateTime*: FILETIME
    NextUpdateTime*: FILETIME
    PublishTime*: FILETIME
  PCRYPTNET_URL_CACHE_PRE_FETCH_INFO* = ptr CRYPTNET_URL_CACHE_PRE_FETCH_INFO
  CRYPTNET_URL_CACHE_FLUSH_INFO* {.pure.} = object
    cbSize*: DWORD
    dwExemptSeconds*: DWORD
    ExpireTime*: FILETIME
  PCRYPTNET_URL_CACHE_FLUSH_INFO* = ptr CRYPTNET_URL_CACHE_FLUSH_INFO
  CRYPTNET_URL_CACHE_RESPONSE_INFO* {.pure.} = object
    cbSize*: DWORD
    wResponseType*: WORD
    wResponseFlags*: WORD
    LastModifiedTime*: FILETIME
    dwMaxAge*: DWORD
    pwszETag*: LPCWSTR
    dwProxyId*: DWORD
  PCRYPTNET_URL_CACHE_RESPONSE_INFO* = ptr CRYPTNET_URL_CACHE_RESPONSE_INFO
  CRYPT_RETRIEVE_AUX_INFO* {.pure.} = object
    cbSize*: DWORD
    pLastSyncTime*: ptr FILETIME
    dwMaxUrlRetrievalByteCount*: DWORD
    pPreFetchInfo*: PCRYPTNET_URL_CACHE_PRE_FETCH_INFO
    pFlushInfo*: PCRYPTNET_URL_CACHE_FLUSH_INFO
    ppResponseInfo*: ptr PCRYPTNET_URL_CACHE_RESPONSE_INFO
    pwszCacheFileNamePrefix*: LPWSTR
    pftCacheResync*: LPFILETIME
    fProxyCacheRetrieval*: WINBOOL
    dwHttpStatusCode*: DWORD
  PCRYPT_RETRIEVE_AUX_INFO* = ptr CRYPT_RETRIEVE_AUX_INFO
  PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC* = proc (pvCompletion: LPVOID, dwCompletionCode: DWORD, pszUrl: LPCSTR, pszObjectOid: LPSTR, pvObject: LPVOID): VOID {.stdcall.}
  CRYPT_ASYNC_RETRIEVAL_COMPLETION* {.pure.} = object
    pfnCompletion*: PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC
    pvCompletion*: LPVOID
  PCRYPT_ASYNC_RETRIEVAL_COMPLETION* = ptr CRYPT_ASYNC_RETRIEVAL_COMPLETION
  CRYPT_URL_ARRAY* {.pure.} = object
    cUrl*: DWORD
    rgwszUrl*: ptr LPWSTR
  PCRYPT_URL_ARRAY* = ptr CRYPT_URL_ARRAY
  CRYPT_URL_INFO* {.pure.} = object
    cbSize*: DWORD
    dwSyncDeltaTime*: DWORD
    cGroup*: DWORD
    rgcGroupEntry*: ptr DWORD
  PCRYPT_URL_INFO* = ptr CRYPT_URL_INFO
  CERT_CRL_CONTEXT_PAIR* {.pure.} = object
    pCertContext*: PCCERT_CONTEXT
    pCrlContext*: PCCRL_CONTEXT
  PCERT_CRL_CONTEXT_PAIR* = ptr CERT_CRL_CONTEXT_PAIR
  PCCERT_CRL_CONTEXT_PAIR* = ptr CERT_CRL_CONTEXT_PAIR
  CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO* {.pure.} = object
    cbSize*: DWORD
    iDeltaCrlIndicator*: int32
    pftCacheResync*: LPFILETIME
    pLastSyncTime*: LPFILETIME
    pMaxAgeTime*: LPFILETIME
    pChainPara*: PCERT_REVOCATION_CHAIN_PARA
    pDeltaCrlIndicator*: PCRYPT_INTEGER_BLOB
  PCRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO* = ptr CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO
  CERT_CHAIN_ENGINE_CONFIG* {.pure.} = object
    cbSize*: DWORD
    hRestrictedRoot*: HCERTSTORE
    hRestrictedTrust*: HCERTSTORE
    hRestrictedOther*: HCERTSTORE
    cAdditionalStore*: DWORD
    rghAdditionalStore*: ptr HCERTSTORE
    dwFlags*: DWORD
    dwUrlRetrievalTimeout*: DWORD
    MaximumCachedCertificates*: DWORD
    CycleDetectionModulus*: DWORD
    hExclusiveRoot*: HCERTSTORE
    hExclusiveTrustedPeople*: HCERTSTORE
    dwExclusiveFlags*: DWORD
  PCERT_CHAIN_ENGINE_CONFIG* = ptr CERT_CHAIN_ENGINE_CONFIG
  CERT_TRUST_STATUS* {.pure.} = object
    dwErrorStatus*: DWORD
    dwInfoStatus*: DWORD
  PCERT_TRUST_STATUS* = ptr CERT_TRUST_STATUS
  CERT_REVOCATION_INFO* {.pure.} = object
    cbSize*: DWORD
    dwRevocationResult*: DWORD
    pszRevocationOid*: LPCSTR
    pvOidSpecificInfo*: LPVOID
    fHasFreshnessTime*: WINBOOL
    dwFreshnessTime*: DWORD
    pCrlInfo*: PCERT_REVOCATION_CRL_INFO
  PCERT_REVOCATION_INFO* = ptr CERT_REVOCATION_INFO
  CERT_TRUST_LIST_INFO* {.pure.} = object
    cbSize*: DWORD
    pCtlEntry*: PCTL_ENTRY
    pCtlContext*: PCCTL_CONTEXT
  PCERT_TRUST_LIST_INFO* = ptr CERT_TRUST_LIST_INFO
  CERT_CHAIN_ELEMENT* {.pure.} = object
    cbSize*: DWORD
    pCertContext*: PCCERT_CONTEXT
    TrustStatus*: CERT_TRUST_STATUS
    pRevocationInfo*: PCERT_REVOCATION_INFO
    pIssuanceUsage*: PCERT_ENHKEY_USAGE
    pApplicationUsage*: PCERT_ENHKEY_USAGE
    pwszExtendedErrorInfo*: LPCWSTR
  PCERT_CHAIN_ELEMENT* = ptr CERT_CHAIN_ELEMENT
  PCCERT_CHAIN_ELEMENT* = ptr CERT_CHAIN_ELEMENT
  CERT_SIMPLE_CHAIN* {.pure.} = object
    cbSize*: DWORD
    TrustStatus*: CERT_TRUST_STATUS
    cElement*: DWORD
    rgpElement*: ptr PCERT_CHAIN_ELEMENT
    pTrustListInfo*: PCERT_TRUST_LIST_INFO
    fHasRevocationFreshnessTime*: WINBOOL
    dwRevocationFreshnessTime*: DWORD
  PCERT_SIMPLE_CHAIN* = ptr CERT_SIMPLE_CHAIN
  PCCERT_SIMPLE_CHAIN* = ptr CERT_SIMPLE_CHAIN
  PCCERT_CHAIN_CONTEXT* = ptr CERT_CHAIN_CONTEXT
  CERT_CHAIN_CONTEXT* {.pure.} = object
    cbSize*: DWORD
    TrustStatus*: CERT_TRUST_STATUS
    cChain*: DWORD
    rgpChain*: ptr PCERT_SIMPLE_CHAIN
    cLowerQualityChainContext*: DWORD
    rgpLowerQualityChainContext*: ptr PCCERT_CHAIN_CONTEXT
    fHasRevocationFreshnessTime*: WINBOOL
    dwRevocationFreshnessTime*: DWORD
    dwCreateFlags*: DWORD
    ChainId*: GUID
  PCERT_CHAIN_CONTEXT* = ptr CERT_CHAIN_CONTEXT
  CERT_USAGE_MATCH* {.pure.} = object
    dwType*: DWORD
    Usage*: CERT_ENHKEY_USAGE
  PCERT_USAGE_MATCH* = ptr CERT_USAGE_MATCH
  CTL_USAGE_MATCH* {.pure.} = object
    dwType*: DWORD
    Usage*: CTL_USAGE
  PCTL_USAGE_MATCH* = ptr CTL_USAGE_MATCH
  CERT_CHAIN_PARA* {.pure.} = object
    cbSize*: DWORD
    RequestedUsage*: CERT_USAGE_MATCH
    RequestedIssuancePolicy*: CERT_USAGE_MATCH
    dwUrlRetrievalTimeout*: DWORD
    fCheckRevocationFreshnessTime*: WINBOOL
    dwRevocationFreshnessTime*: DWORD
    pftCacheResync*: LPFILETIME
    pStrongSignPara*: PCCERT_STRONG_SIGN_PARA
    dwStrongSignFlags*: DWORD
  PCERT_CHAIN_PARA* = ptr CERT_CHAIN_PARA
  CRL_REVOCATION_INFO* {.pure.} = object
    pCrlEntry*: PCRL_ENTRY
    pCrlContext*: PCCRL_CONTEXT
    pCrlIssuerChain*: PCCERT_CHAIN_CONTEXT
  PCRL_REVOCATION_INFO* = ptr CRL_REVOCATION_INFO
  PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK* = proc (pCert: PCCERT_CONTEXT, pvFindArg: pointer): WINBOOL {.stdcall.}
  CERT_CHAIN_FIND_ISSUER_PARA* {.pure.} = object
    cbSize*: DWORD
    pszUsageIdentifier*: LPCSTR
    dwKeySpec*: DWORD
    dwAcquirePrivateKeyFlags*: DWORD
    cIssuer*: DWORD
    rgIssuer*: ptr CERT_NAME_BLOB
    pfnFindCallback*: PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK
    pvFindArg*: pointer
    pdwIssuerChainIndex*: ptr DWORD
    pdwIssuerElementIndex*: ptr DWORD
  PCERT_CHAIN_FIND_ISSUER_PARA* = ptr CERT_CHAIN_FIND_ISSUER_PARA
  CERT_CHAIN_FIND_BY_ISSUER_PARA* = CERT_CHAIN_FIND_ISSUER_PARA
  PCERT_CHAIN_FIND_BY_ISSUER_PARA* = ptr CERT_CHAIN_FIND_ISSUER_PARA
  CERT_CHAIN_POLICY_PARA* {.pure.} = object
    cbSize*: DWORD
    dwFlags*: DWORD
    pvExtraPolicyPara*: pointer
  PCERT_CHAIN_POLICY_PARA* = ptr CERT_CHAIN_POLICY_PARA
  CERT_CHAIN_POLICY_STATUS* {.pure.} = object
    cbSize*: DWORD
    dwError*: DWORD
    lChainIndex*: LONG
    lElementIndex*: LONG
    pvExtraPolicyStatus*: pointer
  PCERT_CHAIN_POLICY_STATUS* = ptr CERT_CHAIN_POLICY_STATUS
  AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA* {.pure.} = object
    cbSize*: DWORD
    dwRegPolicySettings*: DWORD
    pSignerInfo*: PCMSG_SIGNER_INFO
  PAUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA* = ptr AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA
  AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS* {.pure.} = object
    cbSize*: DWORD
    fCommercial*: WINBOOL
  PAUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS* = ptr AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS
  AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA* {.pure.} = object
    cbSize*: DWORD
    dwRegPolicySettings*: DWORD
    fCommercial*: WINBOOL
  PAUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA* = ptr AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA
  HTTPSPolicyCallbackData_UNION1* {.pure, union.} = object
    cbStruct*: DWORD
    cbSize*: DWORD
  HTTPSPolicyCallbackData* {.pure.} = object
    union1*: HTTPSPolicyCallbackData_UNION1
    dwAuthType*: DWORD
    fdwChecks*: DWORD
    pwszServerName*: ptr WCHAR
  PHTTPSPolicyCallbackData* = ptr HTTPSPolicyCallbackData
  SSL_EXTRA_CERT_CHAIN_POLICY_PARA* = HTTPSPolicyCallbackData
  PSSL_EXTRA_CERT_CHAIN_POLICY_PARA* = ptr HTTPSPolicyCallbackData
  EV_EXTRA_CERT_CHAIN_POLICY_PARA* {.pure.} = object
    cbSize*: DWORD
    dwRootProgramQualifierFlags*: DWORD
  PEV_EXTRA_CERT_CHAIN_POLICY_PARA* = ptr EV_EXTRA_CERT_CHAIN_POLICY_PARA
  EV_EXTRA_CERT_CHAIN_POLICY_STATUS* {.pure.} = object
    cbSize*: DWORD
    dwQualifiers*: DWORD
    dwIssuanceUsageIndex*: DWORD
  PEV_EXTRA_CERT_CHAIN_POLICY_STATUS* = ptr EV_EXTRA_CERT_CHAIN_POLICY_STATUS
  CERT_SERVER_OCSP_RESPONSE_CONTEXT* {.pure.} = object
    cbSize*: DWORD
    pbEncodedOcspResponse*: ptr BYTE
    cbEncodedOcspResponse*: DWORD
  PCERT_SERVER_OCSP_RESPONSE_CONTEXT* = ptr CERT_SERVER_OCSP_RESPONSE_CONTEXT
  PCCERT_SERVER_OCSP_RESPONSE_CONTEXT* = ptr CERT_SERVER_OCSP_RESPONSE_CONTEXT
  CERT_SELECT_CHAIN_PARA* {.pure.} = object
    hChainEngine*: HCERTCHAINENGINE
    pTime*: PFILETIME
    hAdditionalStore*: HCERTSTORE
    pChainPara*: PCERT_CHAIN_PARA
    dwFlags*: DWORD
  PCERT_SELECT_CHAIN_PARA* = ptr CERT_SELECT_CHAIN_PARA
  PCCERT_SELECT_CHAIN_PARA* = ptr CERT_SELECT_CHAIN_PARA
  CERT_SELECT_CRITERIA* {.pure.} = object
    dwType*: DWORD
    cPara*: DWORD
    ppPara*: ptr pointer
  PCERT_SELECT_CRITERIA* = ptr CERT_SELECT_CRITERIA
  PCCERT_SELECT_CRITERIA* = ptr CERT_SELECT_CRITERIA
  CRYPT_TIMESTAMP_REQUEST* {.pure.} = object
    dwVersion*: DWORD
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    HashedMessage*: CRYPT_DER_BLOB
    pszTSAPolicyId*: LPSTR
    Nonce*: CRYPT_INTEGER_BLOB
    fCertReq*: WINBOOL
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCRYPT_TIMESTAMP_REQUEST* = ptr CRYPT_TIMESTAMP_REQUEST
  CRYPT_TIMESTAMP_RESPONSE* {.pure.} = object
    dwStatus*: DWORD
    cFreeText*: DWORD
    rgFreeText*: ptr LPWSTR
    FailureInfo*: CRYPT_BIT_BLOB
    ContentInfo*: CRYPT_DER_BLOB
  PCRYPT_TIMESTAMP_RESPONSE* = ptr CRYPT_TIMESTAMP_RESPONSE
  CRYPT_TIMESTAMP_ACCURACY* {.pure.} = object
    dwSeconds*: DWORD
    dwMillis*: DWORD
    dwMicros*: DWORD
  PCRYPT_TIMESTAMP_ACCURACY* = ptr CRYPT_TIMESTAMP_ACCURACY
  CRYPT_TIMESTAMP_INFO* {.pure.} = object
    dwVersion*: DWORD
    pszTSAPolicyId*: LPSTR
    HashAlgorithm*: CRYPT_ALGORITHM_IDENTIFIER
    HashedMessage*: CRYPT_DER_BLOB
    SerialNumber*: CRYPT_INTEGER_BLOB
    ftTime*: FILETIME
    pvAccuracy*: PCRYPT_TIMESTAMP_ACCURACY
    fOrdering*: WINBOOL
    Nonce*: CRYPT_DER_BLOB
    Tsa*: CRYPT_DER_BLOB
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCRYPT_TIMESTAMP_INFO* = ptr CRYPT_TIMESTAMP_INFO
  CRYPT_TIMESTAMP_CONTEXT* {.pure.} = object
    cbEncoded*: DWORD
    pbEncoded*: ptr BYTE
    pTimeStamp*: PCRYPT_TIMESTAMP_INFO
  PCRYPT_TIMESTAMP_CONTEXT* = ptr CRYPT_TIMESTAMP_CONTEXT
  CRYPT_TIMESTAMP_PARA* {.pure.} = object
    pszTSAPolicyId*: LPCSTR
    fRequestCerts*: WINBOOL
    Nonce*: CRYPT_INTEGER_BLOB
    cExtension*: DWORD
    rgExtension*: PCERT_EXTENSION
  PCRYPT_TIMESTAMP_PARA* = ptr CRYPT_TIMESTAMP_PARA
  PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET* = proc (pPluginContext: LPVOID, pIdentifier: PCRYPT_DATA_BLOB, dwNameType: DWORD, pNameBlob: PCERT_NAME_BLOB, ppbContent: ptr PBYTE, pcbContent: ptr DWORD, ppwszPassword: ptr PCWSTR, ppIdentifier: ptr PCRYPT_DATA_BLOB): WINBOOL {.stdcall.}
  PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE* = proc (dwReason: DWORD, pPluginContext: LPVOID): void {.stdcall.}
  PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD* = proc (pPluginContext: LPVOID, pwszPassword: PCWSTR): void {.stdcall.}
  PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE* = proc (pPluginContext: LPVOID, pbData: PBYTE): void {.stdcall.}
  PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER* = proc (pPluginContext: LPVOID, pIdentifier: PCRYPT_DATA_BLOB): void {.stdcall.}
  CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE* {.pure.} = object
    cbSize*: DWORD
    pfnGet*: PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET
    pfnRelease*: PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE
    pfnFreePassword*: PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD
    pfnFree*: PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE
    pfnFreeIdentifier*: PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER
  PCRYPT_OBJECT_LOCATOR_PROVIDER_TABLE* = ptr CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE
  CRYPTPROTECT_PROMPTSTRUCT* {.pure.} = object
    cbSize*: DWORD
    dwPromptFlags*: DWORD
    hwndApp*: HWND
    szPrompt*: LPCWSTR
  PCRYPTPROTECT_PROMPTSTRUCT* = ptr CRYPTPROTECT_PROMPTSTRUCT
const
  ALG_CLASS_ANY* = 0
  ALG_CLASS_SIGNATURE* = 1 shl 13
  ALG_CLASS_MSG_ENCRYPT* = 2 shl 13
  ALG_CLASS_DATA_ENCRYPT* = 3 shl 13
  ALG_CLASS_HASH* = 4 shl 13
  ALG_CLASS_KEY_EXCHANGE* = 5 shl 13
  ALG_CLASS_ALL* = 7 shl 13
  ALG_TYPE_ANY* = 0
  ALG_TYPE_DSS* = 1 shl 9
  ALG_TYPE_RSA* = 2 shl 9
  ALG_TYPE_BLOCK* = 3 shl 9
  ALG_TYPE_STREAM* = 4 shl 9
  ALG_TYPE_DH* = 5 shl 9
  ALG_TYPE_SECURECHANNEL* = 6 shl 9
  ALG_SID_ANY* = 0
  ALG_SID_RSA_ANY* = 0
  ALG_SID_RSA_PKCS* = 1
  ALG_SID_RSA_MSATWORK* = 2
  ALG_SID_RSA_ENTRUST* = 3
  ALG_SID_RSA_PGP* = 4
  ALG_SID_DSS_ANY* = 0
  ALG_SID_DSS_PKCS* = 1
  ALG_SID_DSS_DMS* = 2
  ALG_SID_ECDSA* = 3
  ALG_SID_DES* = 1
  ALG_SID_3DES* = 3
  ALG_SID_DESX* = 4
  ALG_SID_IDEA* = 5
  ALG_SID_CAST* = 6
  ALG_SID_SAFERSK64* = 7
  ALG_SID_SAFERSK128* = 8
  ALG_SID_3DES_112* = 9
  ALG_SID_SKIPJACK* = 10
  ALG_SID_TEK* = 11
  ALG_SID_CYLINK_MEK* = 12
  ALG_SID_RC5* = 13
  ALG_SID_AES_128* = 14
  ALG_SID_AES_192* = 15
  ALG_SID_AES_256* = 16
  ALG_SID_AES* = 17
  CRYPT_MODE_CBCI* = 6
  CRYPT_MODE_CFBP* = 7
  CRYPT_MODE_OFBP* = 8
  CRYPT_MODE_CBCOFM* = 9
  CRYPT_MODE_CBCOFMI* = 10
  ALG_SID_RC2* = 2
  ALG_SID_RC4* = 1
  ALG_SID_SEAL* = 2
  ALG_SID_DH_SANDF* = 1
  ALG_SID_DH_EPHEM* = 2
  ALG_SID_AGREED_KEY_ANY* = 3
  ALG_SID_KEA* = 4
  ALG_SID_ECDH* = 5
  ALG_SID_MD2* = 1
  ALG_SID_MD4* = 2
  ALG_SID_MD5* = 3
  ALG_SID_SHA* = 4
  ALG_SID_SHA1* = 4
  ALG_SID_MAC* = 5
  ALG_SID_RIPEMD* = 6
  ALG_SID_RIPEMD160* = 7
  ALG_SID_SSL3SHAMD5* = 8
  ALG_SID_HMAC* = 9
  ALG_SID_TLS1PRF* = 10
  ALG_SID_HASH_REPLACE_OWF* = 11
  ALG_SID_SHA_256* = 12
  ALG_SID_SHA_384* = 13
  ALG_SID_SHA_512* = 14
  ALG_SID_SSL3_MASTER* = 1
  ALG_SID_SCHANNEL_MASTER_HASH* = 2
  ALG_SID_SCHANNEL_MAC_KEY* = 3
  ALG_SID_PCT1_MASTER* = 4
  ALG_SID_SSL2_MASTER* = 5
  ALG_SID_TLS1_MASTER* = 6
  ALG_SID_SCHANNEL_ENC_KEY* = 7
  ALG_SID_ECMQV* = 1
  ALG_SID_EXAMPLE* = 80
  CALG_MD2* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD2
  CALG_MD4* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD4
  CALG_MD5* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD5
  CALG_SHA* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA
  CALG_SHA1* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA1
  CALG_MAC* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MAC
  CALG_RSA_SIGN* = ALG_CLASS_SIGNATURE or ALG_TYPE_RSA or ALG_SID_RSA_ANY
  CALG_DSS_SIGN* = ALG_CLASS_SIGNATURE or ALG_TYPE_DSS or ALG_SID_DSS_ANY
  CALG_NO_SIGN* = ALG_CLASS_SIGNATURE or ALG_TYPE_ANY or ALG_SID_ANY
  CALG_RSA_KEYX* = ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_RSA or ALG_SID_RSA_ANY
  CALG_DES* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_DES
  CALG_3DES_112* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_3DES_112
  CALG_3DES* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_3DES
  CALG_DESX* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_DESX
  CALG_RC2* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_RC2
  CALG_RC4* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_STREAM or ALG_SID_RC4
  CALG_SEAL* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_STREAM or ALG_SID_SEAL
  CALG_DH_SF* = ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_DH_SANDF
  CALG_DH_EPHEM* = ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_DH_EPHEM
  CALG_AGREEDKEY_ANY* = ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_AGREED_KEY_ANY
  CALG_KEA_KEYX* = ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_KEA
  CALG_HUGHES_MD5* = ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_ANY or ALG_SID_MD5
  CALG_SKIPJACK* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_SKIPJACK
  CALG_TEK* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_TEK
  CALG_CYLINK_MEK* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_CYLINK_MEK
  CALG_SSL3_SHAMD5* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SSL3SHAMD5
  CALG_SSL3_MASTER* = ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SSL3_MASTER
  CALG_SCHANNEL_MASTER_HASH* = ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SCHANNEL_MASTER_HASH
  CALG_SCHANNEL_MAC_KEY* = ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SCHANNEL_MAC_KEY
  CALG_SCHANNEL_ENC_KEY* = ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SCHANNEL_ENC_KEY
  CALG_PCT1_MASTER* = ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_PCT1_MASTER
  CALG_SSL2_MASTER* = ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SSL2_MASTER
  CALG_TLS1_MASTER* = ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_TLS1_MASTER
  CALG_RC5* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_RC5
  CALG_HMAC* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_HMAC
  CALG_TLS1PRF* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_TLS1PRF
  CALG_HASH_REPLACE_OWF* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_HASH_REPLACE_OWF
  CALG_AES_128* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_AES_128
  CALG_AES_192* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_AES_192
  CALG_AES_256* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_AES_256
  CALG_AES* = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_AES
  CALG_SHA_256* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA_256
  CALG_SHA_384* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA_384
  CALG_SHA_512* = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA_512
  CALG_ECDH* = ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_ECDH
  CALG_ECMQV* = ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_ANY or ALG_SID_ECMQV
  CALG_ECDSA* = ALG_CLASS_SIGNATURE or ALG_TYPE_DSS or ALG_SID_ECDSA
  CRYPT_VERIFYCONTEXT* = 0xf0000000'i32
  CRYPT_NEWKEYSET* = 0x8
  CRYPT_DELETEKEYSET* = 0x10
  CRYPT_MACHINE_KEYSET* = 0x20
  CRYPT_SILENT* = 0x40
  CRYPT_DEFAULT_CONTAINER_OPTIONAL* = 0x80
  CRYPT_EXPORTABLE* = 0x1
  CRYPT_USER_PROTECTED* = 0x2
  CRYPT_CREATE_SALT* = 0x4
  CRYPT_UPDATE_KEY* = 0x8
  CRYPT_NO_SALT* = 0x10
  CRYPT_PREGEN* = 0x40
  CRYPT_RECIPIENT* = 0x10
  CRYPT_INITIATOR* = 0x40
  CRYPT_ONLINE* = 0x80
  CRYPT_SF* = 0x100
  CRYPT_CREATE_IV* = 0x200
  CRYPT_KEK* = 0x400
  CRYPT_DATA_KEY* = 0x800
  CRYPT_VOLATILE* = 0x1000
  CRYPT_SGCKEY* = 0x2000
  CRYPT_ARCHIVABLE* = 0x4000
  CRYPT_FORCE_KEY_PROTECTION_HIGH* = 0x8000
  CRYPT_USER_PROTECTED_STRONG* = 0x100000
  RSA1024BIT_KEY* = 0x4000000
  CRYPT_SERVER* = 0x400
  KEY_LENGTH_MASK* = 0xffff0000'i32
  CRYPT_Y_ONLY* = 0x1
  CRYPT_SSL2_FALLBACK* = 0x2
  crypt_destroykey* = 0x4
  CRYPT_DECRYPT_RSA_NO_PADDING_CHECK* = 0x20
  CRYPT_OAEP* = 0x40
  CRYPT_BLOB_VER3* = 0x80
  CRYPT_IPSEC_HMAC_KEY* = 0x100
  CRYPT_SECRETDIGEST* = 0x1
  CRYPT_OWF_REPL_LM_HASH* = 0x1
  CRYPT_LITTLE_ENDIAN* = 0x1
  CRYPT_NOHASHOID* = 0x1
  CRYPT_TYPE2_FORMAT* = 0x2
  CRYPT_X931_FORMAT* = 0x4
  CRYPT_MACHINE_DEFAULT* = 0x1
  CRYPT_USER_DEFAULT* = 0x2
  CRYPT_DELETE_DEFAULT* = 0x4
  SIMPLEBLOB* = 0x1
  PUBLICKEYBLOB* = 0x6
  PRIVATEKEYBLOB* = 0x7
  PLAINTEXTKEYBLOB* = 0x8
  OPAQUEKEYBLOB* = 0x9
  PUBLICKEYBLOBEX* = 0xa
  SYMMETRICWRAPKEYBLOB* = 0xb
  KEYSTATEBLOB* = 0xc
  AT_KEYEXCHANGE* = 1
  AT_SIGNATURE* = 2
  CRYPT_USERDATA* = 1
  KP_IV* = 1
  KP_SALT* = 2
  KP_PADDING* = 3
  KP_MODE* = 4
  KP_MODE_BITS* = 5
  KP_PERMISSIONS* = 6
  KP_ALGID* = 7
  KP_BLOCKLEN* = 8
  KP_KEYLEN* = 9
  KP_SALT_EX* = 10
  KP_P* = 11
  KP_G* = 12
  KP_Q* = 13
  KP_X* = 14
  KP_Y* = 15
  KP_RA* = 16
  KP_RB* = 17
  KP_INFO* = 18
  KP_EFFECTIVE_KEYLEN* = 19
  KP_SCHANNEL_ALG* = 20
  KP_CLIENT_RANDOM* = 21
  KP_SERVER_RANDOM* = 22
  KP_RP* = 23
  KP_PRECOMP_MD5* = 24
  KP_PRECOMP_SHA* = 25
  KP_CERTIFICATE* = 26
  KP_CLEAR_KEY* = 27
  KP_PUB_EX_LEN* = 28
  KP_PUB_EX_VAL* = 29
  KP_KEYVAL* = 30
  KP_ADMIN_PIN* = 31
  KP_KEYEXCHANGE_PIN* = 32
  KP_SIGNATURE_PIN* = 33
  KP_PREHASH* = 34
  KP_ROUNDS* = 35
  KP_OAEP_PARAMS* = 36
  KP_CMS_KEY_INFO* = 37
  KP_CMS_DH_KEY_INFO* = 38
  KP_PUB_PARAMS* = 39
  KP_VERIFY_PARAMS* = 40
  KP_HIGHEST_VERSION* = 41
  KP_GET_USE_COUNT* = 42
  KP_PIN_ID* = 43
  KP_PIN_INFO* = 44
  PKCS5_PADDING* = 1
  RANDOM_PADDING* = 2
  ZERO_PADDING* = 3
  CRYPT_MODE_CBC* = 1
  CRYPT_MODE_ECB* = 2
  CRYPT_MODE_OFB* = 3
  CRYPT_MODE_CFB* = 4
  CRYPT_MODE_CTS* = 5
  crypt_encrypt* = 0x1
  crypt_decrypt* = 0x2
  CRYPT_EXPORT* = 0x4
  CRYPT_READ* = 0x8
  CRYPT_WRITE* = 0x10
  CRYPT_MAC* = 0x20
  crypt_export_key* = 0x40
  crypt_import_key* = 0x80
  CRYPT_ARCHIVE* = 0x100
  HP_ALGID* = 0x1
  HP_HASHVAL* = 0x2
  HP_HASHSIZE* = 0x4
  HP_HMAC_INFO* = 0x5
  HP_TLS1PRF_LABEL* = 0x6
  HP_TLS1PRF_SEED* = 0x7
  CRYPT_FAILED* = FALSE
  CRYPT_SUCCEED* = TRUE
  PP_ENUMALGS* = 1
  PP_ENUMCONTAINERS* = 2
  PP_IMPTYPE* = 3
  PP_NAME* = 4
  PP_VERSION* = 5
  PP_CONTAINER* = 6
  PP_CHANGE_PASSWORD* = 7
  PP_KEYSET_SEC_DESCR* = 8
  PP_CERTCHAIN* = 9
  PP_KEY_TYPE_SUBTYPE* = 10
  PP_PROVTYPE* = 16
  PP_KEYSTORAGE* = 17
  PP_APPLI_CERT* = 18
  PP_SYM_KEYSIZE* = 19
  PP_SESSION_KEYSIZE* = 20
  PP_UI_PROMPT* = 21
  PP_ENUMALGS_EX* = 22
  PP_ENUMMANDROOTS* = 25
  PP_ENUMELECTROOTS* = 26
  PP_KEYSET_TYPE* = 27
  PP_ADMIN_PIN* = 31
  PP_KEYEXCHANGE_PIN* = 32
  PP_SIGNATURE_PIN* = 33
  PP_SIG_KEYSIZE_INC* = 34
  PP_KEYX_KEYSIZE_INC* = 35
  PP_UNIQUE_CONTAINER* = 36
  PP_SGC_INFO* = 37
  PP_USE_HARDWARE_RNG* = 38
  PP_KEYSPEC* = 39
  PP_ENUMEX_SIGNING_PROT* = 40
  PP_CRYPT_COUNT_KEY_USE* = 41
  PP_USER_CERTSTORE* = 42
  PP_SMARTCARD_READER* = 43
  PP_SMARTCARD_GUID* = 45
  PP_ROOT_CERTSTORE* = 46
  PP_SMARTCARD_READER_ICON* = 47
  CRYPT_FIRST* = 1
  CRYPT_NEXT* = 2
  CRYPT_SGC_ENUM* = 4
  CRYPT_IMPL_HARDWARE* = 1
  CRYPT_IMPL_SOFTWARE* = 2
  CRYPT_IMPL_MIXED* = 3
  CRYPT_IMPL_UNKNOWN* = 4
  CRYPT_IMPL_REMOVABLE* = 8
  CRYPT_SEC_DESCR* = 0x1
  CRYPT_PSTORE* = 0x2
  CRYPT_UI_PROMPT* = 0x4
  CRYPT_FLAG_PCT1* = 0x1
  CRYPT_FLAG_SSL2* = 0x2
  CRYPT_FLAG_SSL3* = 0x4
  CRYPT_FLAG_TLS1* = 0x8
  CRYPT_FLAG_IPSEC* = 0x10
  CRYPT_FLAG_SIGNING* = 0x20
  CRYPT_SGC* = 0x1
  CRYPT_FASTSGC* = 0x2
  PP_CLIENT_HWND* = 1
  PP_CONTEXT_INFO* = 11
  PP_KEYEXCHANGE_KEYSIZE* = 12
  PP_SIGNATURE_KEYSIZE* = 13
  PP_KEYEXCHANGE_ALG* = 14
  PP_SIGNATURE_ALG* = 15
  PP_DELETEKEY* = 24
  PP_PIN_PROMPT_STRING* = 44
  PP_SECURE_KEYEXCHANGE_PIN* = 47
  PP_SECURE_SIGNATURE_PIN* = 48
  PROV_RSA_FULL* = 1
  PROV_RSA_SIG* = 2
  PROV_DSS* = 3
  PROV_FORTEZZA* = 4
  PROV_MS_EXCHANGE* = 5
  PROV_SSL* = 6
  PROV_STT_MER* = 7
  PROV_STT_ACQ* = 8
  PROV_STT_BRND* = 9
  PROV_STT_ROOT* = 10
  PROV_STT_ISS* = 11
  PROV_RSA_SCHANNEL* = 12
  PROV_DSS_DH* = 13
  PROV_EC_ECDSA_SIG* = 14
  PROV_EC_ECNRA_SIG* = 15
  PROV_EC_ECDSA_FULL* = 16
  PROV_EC_ECNRA_FULL* = 17
  PROV_DH_SCHANNEL* = 18
  PROV_SPYRUS_LYNKS* = 20
  PROV_RNG* = 21
  PROV_INTEL_SEC* = 22
  PROV_REPLACE_OWF* = 23
  PROV_RSA_AES* = 24
  MS_DEF_PROV_A* = "Microsoft Base Cryptographic Provider v1.0"
  MS_DEF_PROV_W* = "Microsoft Base Cryptographic Provider v1.0"
  MS_ENHANCED_PROV_A* = "Microsoft Enhanced Cryptographic Provider v1.0"
  MS_ENHANCED_PROV_W* = "Microsoft Enhanced Cryptographic Provider v1.0"
  MS_STRONG_PROV_A* = "Microsoft Strong Cryptographic Provider"
  MS_STRONG_PROV_W* = "Microsoft Strong Cryptographic Provider"
  MS_DEF_RSA_SIG_PROV_A* = "Microsoft RSA Signature Cryptographic Provider"
  MS_DEF_RSA_SIG_PROV_W* = "Microsoft RSA Signature Cryptographic Provider"
  MS_DEF_RSA_SCHANNEL_PROV_A* = "Microsoft RSA SChannel Cryptographic Provider"
  MS_DEF_RSA_SCHANNEL_PROV_W* = "Microsoft RSA SChannel Cryptographic Provider"
  MS_DEF_DSS_PROV_A* = "Microsoft Base DSS Cryptographic Provider"
  MS_DEF_DSS_PROV_W* = "Microsoft Base DSS Cryptographic Provider"
  MS_DEF_DSS_DH_PROV_A* = "Microsoft Base DSS and Diffie-Hellman Cryptographic Provider"
  MS_DEF_DSS_DH_PROV_W* = "Microsoft Base DSS and Diffie-Hellman Cryptographic Provider"
  MS_ENH_DSS_DH_PROV_A* = "Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider"
  MS_ENH_DSS_DH_PROV_W* = "Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider"
  MS_DEF_DH_SCHANNEL_PROV_A* = "Microsoft DH SChannel Cryptographic Provider"
  MS_DEF_DH_SCHANNEL_PROV_W* = "Microsoft DH SChannel Cryptographic Provider"
  MS_SCARD_PROV_A* = "Microsoft Base Smart Card Crypto Provider"
  MS_SCARD_PROV_W* = "Microsoft Base Smart Card Crypto Provider"
  MS_ENH_RSA_AES_PROV_A* = "Microsoft Enhanced RSA and AES Cryptographic Provider"
  MS_ENH_RSA_AES_PROV_W* = "Microsoft Enhanced RSA and AES Cryptographic Provider"
  MAXUIDLEN* = 64
  EXPO_OFFLOAD_REG_VALUE* = "ExpoOffload"
  EXPO_OFFLOAD_FUNC_NAME* = "OffloadModExpo"
  szKEY_CRYPTOAPI_PRIVATE_KEY_OPTIONS* = "Software\\Policies\\Microsoft\\Cryptography"
  szKEY_CACHE_ENABLED* = "CachePrivateKeys"
  szKEY_CACHE_SECONDS* = "PrivateKeyLifetimeSeconds"
  szPRIV_KEY_CACHE_MAX_ITEMS* = "PrivKeyCacheMaxItems"
  cPRIV_KEY_CACHE_MAX_ITEMS_DEFAULT* = 20
  szPRIV_KEY_CACHE_PURGE_INTERVAL_SECONDS* = "PrivKeyCachePurgeIntervalSeconds"
  cPRIV_KEY_CACHE_PURGE_INTERVAL_SECONDS_DEFAULT* = 86400
  CUR_BLOB_VERSION* = 2
  SCHANNEL_MAC_KEY* = 0x0
  SCHANNEL_ENC_KEY* = 0x1
  INTERNATIONAL_USAGE* = 0x1
  BCRYPT_OBJECT_ALIGNMENT* = 16
  BCRYPT_KDF_HASH* = "HASH"
  BCRYPT_KDF_HMAC* = "HMAC"
  BCRYPT_KDF_TLS_PRF* = "TLS_PRF"
  BCRYPT_KDF_SP80056A_CONCAT* = "SP800_56A_CONCAT"
  KDF_HASH_ALGORITHM* = 0x0
  KDF_SECRET_PREPEND* = 0x1
  KDF_SECRET_APPEND* = 0x2
  KDF_HMAC_KEY* = 0x3
  KDF_TLS_PRF_LABEL* = 0x4
  KDF_TLS_PRF_SEED* = 0x5
  KDF_SECRET_HANDLE* = 0x6
  KDF_TLS_PRF_PROTOCOL* = 0x7
  KDF_ALGORITHMID* = 0x8
  KDF_PARTYUINFO* = 0x9
  KDF_PARTYVINFO* = 0xa
  KDF_SUPPPUBINFO* = 0xb
  KDF_SUPPPRIVINFO* = 0xc
  KDF_LABEL* = 0xd
  KDF_CONTEXT* = 0xe
  KDF_SALT* = 0xf
  KDF_ITERATION_COUNT* = 0x10
  KDF_GENERIC_PARAMETER* = 0x11
  KDF_KEYBITLENGTH* = 0x12
  KDF_USE_SECRET_AS_HMAC_KEY_FLAG* = 1
  BCRYPT_AUTHENTICATED_CIPHER_MODE_INFO_VERSION* = 1
  BCRYPT_AUTH_MODE_CHAIN_CALLS_FLAG* = 0x00000001
  BCRYPT_AUTH_MODE_IN_PROGRESS_FLAG* = 0x00000002
  BCRYPT_OPAQUE_KEY_BLOB* = "OpaqueKeyBlob"
  BCRYPT_KEY_DATA_BLOB* = "KeyDataBlob"
  BCRYPT_AES_WRAP_KEY_BLOB* = "Rfc3565KeyWrapBlob"
  BCRYPT_ALGORITHM_NAME* = "AlgorithmName"
  BCRYPT_AUTH_TAG_LENGTH* = "AuthTagLength"
  BCRYPT_BLOCK_LENGTH* = "BlockLength"
  BCRYPT_BLOCK_SIZE_LIST* = "BlockSizeList"
  BCRYPT_CHAINING_MODE* = "ChainingMode"
  BCRYPT_CHAIN_MODE_CBC* = "ChainingModeCBC"
  BCRYPT_CHAIN_MODE_CCM* = "ChainingModeCCM"
  BCRYPT_CHAIN_MODE_CFB* = "ChainingModeCFB"
  BCRYPT_CHAIN_MODE_ECB* = "ChainingModeECB"
  BCRYPT_CHAIN_MODE_GCM* = "ChainingModeGCM"
  BCRYPT_CHAIN_MODE_NA* = "ChainingModeN/A"
  BCRYPT_EFFECTIVE_KEY_LENGTH* = "EffectiveKeyLength"
  BCRYPT_HASH_BLOCK_LENGTH* = "HashBlockLength"
  BCRYPT_HASH_LENGTH* = "HashDigestLength"
  BCRYPT_HASH_OID_LIST* = "HashOIDList"
  BCRYPT_INITIALIZATION_VECTOR* = "IV"
  BCRYPT_IS_KEYED_HASH* = "IsKeyedHash"
  BCRYPT_IS_REUSABLE_HASH* = "IsReusableHash"
  BCRYPT_KEY_LENGTH* = "KeyLength"
  BCRYPT_KEY_LENGTHS* = "KeyLengths"
  BCRYPT_KEY_OBJECT_LENGTH* = "KeyObjectLength"
  BCRYPT_KEY_STRENGTH* = "KeyStrength"
  BCRYPT_MESSAGE_BLOCK_LENGTH* = "MessageBlockLength"
  BCRYPT_OBJECT_LENGTH* = "ObjectLength"
  BCRYPT_PADDING_SCHEMES* = "PaddingSchemes"
  BCRYPT_PCP_PLATFORM_TYPE_PROPERTY* = "PCP_PLATFORM_TYPE"
  BCRYPT_PCP_PROVIDER_VERSION_PROPERTY* = "PCP_PROVIDER_VERSION"
  BCRYPT_PRIMITIVE_TYPE* = "PrimitiveType"
  BCRYPT_PROVIDER_HANDLE* = "ProviderHandle"
  BCRYPT_SIGNATURE_LENGTH* = "SignatureLength"
  BCRYPT_SUPPORTED_PAD_ROUTER* = 0x00000001
  BCRYPT_SUPPORTED_PAD_PKCS1_ENC* = 0x00000002
  BCRYPT_SUPPORTED_PAD_PKCS1_SIG* = 0x00000004
  BCRYPT_SUPPORTED_PAD_OAEP* = 0x00000008
  BCRYPT_SUPPORTED_PAD_PSS* = 0x00000010
  BCRYPT_PROV_DISPATCH* = 0x00000001
  BCRYPT_BLOCK_PADDING* = 0x00000001
  BCRYPT_PAD_NONE* = 0x00000001
  BCRYPT_PAD_PKCS1* = 0x00000002
  BCRYPT_PAD_OAEP* = 0x00000004
  BCRYPT_PAD_PSS* = 0x00000008
  BCRYPTBUFFER_VERSION* = 0
  BCRYPT_PUBLIC_KEY_BLOB* = "PUBLICBLOB"
  BCRYPT_PRIVATE_KEY_BLOB* = "PRIVATEBLOB"
  BCRYPT_RSAPUBLIC_BLOB* = "RSAPUBLICBLOB"
  BCRYPT_RSAPRIVATE_BLOB* = "RSAPRIVATEBLOB"
  LEGACY_RSAPUBLIC_BLOB* = "CAPIPUBLICBLOB"
  LEGACY_RSAPRIVATE_BLOB* = "CAPIPRIVATEBLOB"
  BCRYPT_RSAPUBLIC_MAGIC* = 0x31415352
  BCRYPT_RSAPRIVATE_MAGIC* = 0x32415352
  BCRYPT_RSAFULLPRIVATE_BLOB* = "RSAFULLPRIVATEBLOB"
  BCRYPT_RSAFULLPRIVATE_MAGIC* = 0x33415352
  BCRYPT_GLOBAL_PARAMETERS* = "SecretAgreementParam"
  BCRYPT_PRIVATE_KEY* = "PrivKeyVal"
  BCRYPT_ECCPUBLIC_BLOB* = "ECCPUBLICBLOB"
  BCRYPT_ECCPRIVATE_BLOB* = "ECCPRIVATEBLOB"
  BCRYPT_ECDH_PUBLIC_P256_MAGIC* = 0x314b4345
  BCRYPT_ECDH_PRIVATE_P256_MAGIC* = 0x324b4345
  BCRYPT_ECDH_PUBLIC_P384_MAGIC* = 0x334b4345
  BCRYPT_ECDH_PRIVATE_P384_MAGIC* = 0x344b4345
  BCRYPT_ECDH_PUBLIC_P521_MAGIC* = 0x354b4345
  BCRYPT_ECDH_PRIVATE_P521_MAGIC* = 0x364b4345
  BCRYPT_ECDSA_PUBLIC_P256_MAGIC* = 0x31534345
  BCRYPT_ECDSA_PRIVATE_P256_MAGIC* = 0x32534345
  BCRYPT_ECDSA_PUBLIC_P384_MAGIC* = 0x33534345
  BCRYPT_ECDSA_PRIVATE_P384_MAGIC* = 0x34534345
  BCRYPT_ECDSA_PUBLIC_P521_MAGIC* = 0x35534345
  BCRYPT_ECDSA_PRIVATE_P521_MAGIC* = 0x36534345
  BCRYPT_DH_PUBLIC_BLOB* = "DHPUBLICBLOB"
  BCRYPT_DH_PRIVATE_BLOB* = "DHPRIVATEBLOB"
  LEGACY_DH_PUBLIC_BLOB* = "CAPIDHPUBLICBLOB"
  LEGACY_DH_PRIVATE_BLOB* = "CAPIDHPRIVATEBLOB"
  BCRYPT_DH_PUBLIC_MAGIC* = 0x42504844
  BCRYPT_DH_PRIVATE_MAGIC* = 0x56504844
  BCRYPT_DH_PARAMETERS* = "DHParameters"
  BCRYPT_DH_PARAMETERS_MAGIC* = 0x4d504844
  BCRYPT_DSA_PUBLIC_BLOB* = "DSAPUBLICBLOB"
  BCRYPT_DSA_PRIVATE_BLOB* = "DSAPRIVATEBLOB"
  LEGACY_DSA_PUBLIC_BLOB* = "CAPIDSAPUBLICBLOB"
  LEGACY_DSA_PRIVATE_BLOB* = "CAPIDSAPRIVATEBLOB"
  LEGACY_DSA_V2_PUBLIC_BLOB* = "V2CAPIDSAPUBLICBLOB"
  LEGACY_DSA_V2_PRIVATE_BLOB* = "V2CAPIDSAPRIVATEBLOB"
  BCRYPT_DSA_PUBLIC_MAGIC* = 0x42505344
  BCRYPT_DSA_PRIVATE_MAGIC* = 0x56505344
  BCRYPT_DSA_PUBLIC_MAGIC_V2* = 0x32425044
  BCRYPT_DSA_PRIVATE_MAGIC_V2* = 0x32565044
  BCRYPT_KEY_DATA_BLOB_MAGIC* = 0x4d42444b
  BCRYPT_KEY_DATA_BLOB_VERSION1* = 0x1
  BCRYPT_DSA_PARAMETERS* = "DSAParameters"
  BCRYPT_DSA_PARAMETERS_MAGIC* = 0x4d505344
  BCRYPT_DSA_PARAMETERS_MAGIC_V2* = 0x324d5044
  MS_PRIMITIVE_PROVIDER* = "Microsoft Primitive Provider"
  MS_PLATFORM_CRYPTO_PROVIDER* = "Microsoft Platform Crypto Provider"
  BCRYPT_RSA_ALGORITHM* = "RSA"
  BCRYPT_RSA_SIGN_ALGORITHM* = "RSA_SIGN"
  BCRYPT_DH_ALGORITHM* = "DH"
  BCRYPT_DSA_ALGORITHM* = "DSA"
  BCRYPT_RC2_ALGORITHM* = "RC2"
  BCRYPT_RC4_ALGORITHM* = "RC4"
  BCRYPT_AES_ALGORITHM* = "AES"
  BCRYPT_DES_ALGORITHM* = "DES"
  BCRYPT_DESX_ALGORITHM* = "DESX"
  BCRYPT_3DES_ALGORITHM* = "3DES"
  BCRYPT_3DES_112_ALGORITHM* = "3DES_112"
  BCRYPT_MD2_ALGORITHM* = "MD2"
  BCRYPT_MD4_ALGORITHM* = "MD4"
  BCRYPT_MD5_ALGORITHM* = "MD5"
  BCRYPT_SHA1_ALGORITHM* = "SHA1"
  BCRYPT_SHA256_ALGORITHM* = "SHA256"
  BCRYPT_SHA384_ALGORITHM* = "SHA384"
  BCRYPT_SHA512_ALGORITHM* = "SHA512"
  BCRYPT_AES_GMAC_ALGORITHM* = "AES-GMAC"
  BCRYPT_AES_CMAC_ALGORITHM* = "AES-CMAC"
  BCRYPT_ECDSA_P256_ALGORITHM* = "ECDSA_P256"
  BCRYPT_ECDSA_P384_ALGORITHM* = "ECDSA_P384"
  BCRYPT_ECDSA_P521_ALGORITHM* = "ECDSA_P521"
  BCRYPT_ECDH_P256_ALGORITHM* = "ECDH_P256"
  BCRYPT_ECDH_P384_ALGORITHM* = "ECDH_P384"
  BCRYPT_ECDH_P521_ALGORITHM* = "ECDH_P521"
  BCRYPT_RNG_ALGORITHM* = "RNG"
  BCRYPT_RNG_FIPS186_DSA_ALGORITHM* = "FIPS186DSARNG"
  BCRYPT_RNG_DUAL_EC_ALGORITHM* = "DUALECRNG"
  BCRYPT_SP800108_CTR_HMAC_ALGORITHM* = "SP800_108_CTR_HMAC"
  BCRYPT_SP80056A_CONCAT_ALGORITHM* = "SP800_56A_CONCAT"
  BCRYPT_PBKDF2_ALGORITHM* = "PBKDF2"
  BCRYPT_CAPI_KDF_ALGORITHM* = "CAPI_KDF"
  BCRYPT_CIPHER_INTERFACE* = 0x00000001
  BCRYPT_HASH_INTERFACE* = 0x00000002
  BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE* = 0x00000003
  BCRYPT_SECRET_AGREEMENT_INTERFACE* = 0x00000004
  BCRYPT_SIGNATURE_INTERFACE* = 0x00000005
  BCRYPT_RNG_INTERFACE* = 0x00000006
  BCRYPT_KEY_DERIVATION_INTERFACE* = 0x00000007
  BCRYPT_ALG_HANDLE_HMAC_FLAG* = 0x00000008
  BCRYPT_CAPI_AES_FLAG* = 0x00000010
  BCRYPT_HASH_REUSABLE_FLAG* = 0x00000020
  BCRYPT_BUFFERS_LOCKED_FLAG* = 0x00000040
  BCRYPT_CIPHER_OPERATION* = 0x00000001
  BCRYPT_HASH_OPERATION* = 0x00000002
  BCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION* = 0x00000004
  BCRYPT_SECRET_AGREEMENT_OPERATION* = 0x00000008
  BCRYPT_SIGNATURE_OPERATION* = 0x00000010
  BCRYPT_RNG_OPERATION* = 0x00000020
  BCRYPT_KEY_DERIVATION_OPERATION* = 0x00000040
  BCRYPT_PUBLIC_KEY_FLAG* = 0x00000001
  BCRYPT_PRIVATE_KEY_FLAG* = 0x00000002
  BCRYPT_NO_KEY_VALIDATION* = 0x00000008
  BCRYPT_RNG_USE_ENTROPY_IN_BUFFER* = 0x00000001
  BCRYPT_USE_SYSTEM_PREFERRED_RNG* = 0x00000002
  CRYPT_MIN_DEPENDENCIES* = 0x00000001
  CRYPT_PROCESS_ISOLATE* = 0x00010000
  CRYPT_UM* = 0x00000001
  CRYPT_KM* = 0x00000002
  CRYPT_MM* = 0x00000003
  CRYPT_ANY* = 0x00000004
  CRYPT_OVERWRITE* = 0x00000001
  CRYPT_LOCAL* = 0x00000001
  CRYPT_DOMAIN* = 0x00000002
  CRYPT_EXCLUSIVE* = 0x00000001
  CRYPT_OVERRIDE* = 0x00010000
  CRYPT_ALL_FUNCTIONS* = 0x00000001
  CRYPT_ALL_PROVIDERS* = 0x00000002
  CRYPT_PRIORITY_TOP* = 0x00000000
  CRYPT_PRIORITY_BOTTOM* = 0xffffffff'i32
  CRYPT_DEFAULT_CONTEXT* = "Default"
  DSA_HASH_ALGORITHM_SHA1* = 0
  DSA_HASH_ALGORITHM_SHA256* = 1
  DSA_HASH_ALGORITHM_SHA512* = 2
  DSA_FIPS186_2* = 0
  DSA_FIPS186_3* = 1
  NCRYPT_MAX_KEY_NAME_LENGTH* = 512
  NCRYPT_MAX_ALG_ID_LENGTH* = 512
  MS_KEY_STORAGE_PROVIDER* = "Microsoft Software Key Storage Provider"
  MS_SMART_CARD_KEY_STORAGE_PROVIDER* = "Microsoft Smart Card Key Storage Provider"
  MS_PLATFORM_KEY_STORAGE_PROVIDER* = "Microsoft Platform Crypto Provider"
  NCRYPT_RSA_ALGORITHM* = BCRYPT_RSA_ALGORITHM
  NCRYPT_RSA_SIGN_ALGORITHM* = BCRYPT_RSA_SIGN_ALGORITHM
  NCRYPT_DH_ALGORITHM* = BCRYPT_DH_ALGORITHM
  NCRYPT_DSA_ALGORITHM* = BCRYPT_DSA_ALGORITHM
  NCRYPT_MD2_ALGORITHM* = BCRYPT_MD2_ALGORITHM
  NCRYPT_MD4_ALGORITHM* = BCRYPT_MD4_ALGORITHM
  NCRYPT_MD5_ALGORITHM* = BCRYPT_MD5_ALGORITHM
  NCRYPT_SHA1_ALGORITHM* = BCRYPT_SHA1_ALGORITHM
  NCRYPT_SHA256_ALGORITHM* = BCRYPT_SHA256_ALGORITHM
  NCRYPT_SHA384_ALGORITHM* = BCRYPT_SHA384_ALGORITHM
  NCRYPT_SHA512_ALGORITHM* = BCRYPT_SHA512_ALGORITHM
  NCRYPT_ECDSA_P256_ALGORITHM* = BCRYPT_ECDSA_P256_ALGORITHM
  NCRYPT_ECDSA_P384_ALGORITHM* = BCRYPT_ECDSA_P384_ALGORITHM
  NCRYPT_ECDSA_P521_ALGORITHM* = BCRYPT_ECDSA_P521_ALGORITHM
  NCRYPT_ECDH_P256_ALGORITHM* = BCRYPT_ECDH_P256_ALGORITHM
  NCRYPT_ECDH_P384_ALGORITHM* = BCRYPT_ECDH_P384_ALGORITHM
  NCRYPT_ECDH_P521_ALGORITHM* = BCRYPT_ECDH_P521_ALGORITHM
  NCRYPT_AES_ALGORITHM* = BCRYPT_AES_ALGORITHM
  NCRYPT_RC2_ALGORITHM* = BCRYPT_RC2_ALGORITHM
  NCRYPT_3DES_ALGORITHM* = BCRYPT_3DES_ALGORITHM
  NCRYPT_DES_ALGORITHM* = BCRYPT_DES_ALGORITHM
  NCRYPT_DESX_ALGORITHM* = BCRYPT_DESX_ALGORITHM
  NCRYPT_3DES_112_ALGORITHM* = BCRYPT_3DES_112_ALGORITHM
  NCRYPT_SP800108_CTR_HMAC_ALGORITHM* = BCRYPT_SP800108_CTR_HMAC_ALGORITHM
  NCRYPT_SP80056A_CONCAT_ALGORITHM* = BCRYPT_SP80056A_CONCAT_ALGORITHM
  NCRYPT_PBKDF2_ALGORITHM* = BCRYPT_PBKDF2_ALGORITHM
  NCRYPT_CAPI_KDF_ALGORITHM* = BCRYPT_CAPI_KDF_ALGORITHM
  NCRYPT_KEY_STORAGE_ALGORITHM* = "KEY_STORAGE"
  NCRYPT_CIPHER_INTERFACE* = BCRYPT_CIPHER_INTERFACE
  NCRYPT_HASH_INTERFACE* = BCRYPT_HASH_INTERFACE
  NCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE* = BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE
  NCRYPT_SECRET_AGREEMENT_INTERFACE* = BCRYPT_SECRET_AGREEMENT_INTERFACE
  NCRYPT_SIGNATURE_INTERFACE* = BCRYPT_SIGNATURE_INTERFACE
  NCRYPT_KEY_DERIVATION_INTERFACE* = BCRYPT_KEY_DERIVATION_INTERFACE
  NCRYPT_KEY_STORAGE_INTERFACE* = 0x00010001
  NCRYPT_SCHANNEL_INTERFACE* = 0x00010002
  NCRYPT_SCHANNEL_SIGNATURE_INTERFACE* = 0x00010003
  NCRYPT_KEY_PROTECTION_INTERFACE* = 0x00010004
  NCRYPT_RSA_ALGORITHM_GROUP* = NCRYPT_RSA_ALGORITHM
  NCRYPT_DH_ALGORITHM_GROUP* = NCRYPT_DH_ALGORITHM
  NCRYPT_DSA_ALGORITHM_GROUP* = NCRYPT_DSA_ALGORITHM
  NCRYPT_ECDSA_ALGORITHM_GROUP* = "ECDSA"
  NCRYPT_ECDH_ALGORITHM_GROUP* = "ECDH"
  NCRYPT_AES_ALGORITHM_GROUP* = NCRYPT_AES_ALGORITHM
  NCRYPT_RC2_ALGORITHM_GROUP* = NCRYPT_RC2_ALGORITHM
  NCRYPT_DES_ALGORITHM_GROUP* = "DES"
  NCRYPT_KEY_DERIVATION_GROUP* = "KEY_DERIVATION"
  NCRYPTBUFFER_VERSION* = 0
  NCRYPTBUFFER_EMPTY* = 0
  NCRYPTBUFFER_DATA* = 1
  NCRYPTBUFFER_PROTECTION_DESCRIPTOR_STRING* = 3
  NCRYPTBUFFER_PROTECTION_FLAGS* = 4
  NCRYPTBUFFER_SSL_CLIENT_RANDOM* = 20
  NCRYPTBUFFER_SSL_SERVER_RANDOM* = 21
  NCRYPTBUFFER_SSL_HIGHEST_VERSION* = 22
  NCRYPTBUFFER_SSL_CLEAR_KEY* = 23
  NCRYPTBUFFER_SSL_KEY_ARG_DATA* = 24
  NCRYPTBUFFER_PKCS_OID* = 40
  NCRYPTBUFFER_PKCS_ALG_OID* = 41
  NCRYPTBUFFER_PKCS_ALG_PARAM* = 42
  NCRYPTBUFFER_PKCS_ALG_ID* = 43
  NCRYPTBUFFER_PKCS_ATTRS* = 44
  NCRYPTBUFFER_PKCS_KEY_NAME* = 45
  NCRYPTBUFFER_PKCS_SECRET* = 46
  NCRYPTBUFFER_CERT_BLOB* = 47
  NCRYPT_NO_PADDING_FLAG* = 0x1
  NCRYPT_PAD_PKCS1_FLAG* = 0x2
  NCRYPT_PAD_OAEP_FLAG* = 0x4
  NCRYPT_PAD_PSS_FLAG* = 0x8
  NCRYPT_PAD_CIPHER_FLAG* = 0x10
  NCRYPT_CIPHER_NO_PADDING_FLAG* = 0x0
  NCRYPT_CIPHER_BLOCK_PADDING_FLAG* = 0x1
  NCRYPT_CIPHER_OTHER_PADDING_FLAG* = 0x2
  NCRYPT_NO_KEY_VALIDATION* = BCRYPT_NO_KEY_VALIDATION
  NCRYPT_MACHINE_KEY_FLAG* = 0x20
  NCRYPT_SILENT_FLAG* = 0x40
  NCRYPT_OVERWRITE_KEY_FLAG* = 0x80
  NCRYPT_WRITE_KEY_TO_LEGACY_STORE_FLAG* = 0x200
  NCRYPT_DO_NOT_FINALIZE_FLAG* = 0x400
  NCRYPT_PERSIST_ONLY_FLAG* = 0x40000000
  NCRYPT_PERSIST_FLAG* = 0x80000000'i32
  NCRYPT_REGISTER_NOTIFY_FLAG* = 0x1
  NCRYPT_UNREGISTER_NOTIFY_FLAG* = 0x2
  NCRYPT_CIPHER_OPERATION* = BCRYPT_CIPHER_OPERATION
  NCRYPT_HASH_OPERATION* = BCRYPT_HASH_OPERATION
  NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION* = BCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION
  NCRYPT_SECRET_AGREEMENT_OPERATION* = BCRYPT_SECRET_AGREEMENT_OPERATION
  NCRYPT_SIGNATURE_OPERATION* = BCRYPT_SIGNATURE_OPERATION
  NCRYPT_RNG_OPERATION* = BCRYPT_RNG_OPERATION
  NCRYPT_KEY_DERIVATION_OPERATION* = BCRYPT_KEY_DERIVATION_OPERATION
  NCRYPT_NAME_PROPERTY* = "Name"
  NCRYPT_UNIQUE_NAME_PROPERTY* = "Unique Name"
  NCRYPT_ALGORITHM_PROPERTY* = "Algorithm Name"
  NCRYPT_LENGTH_PROPERTY* = "Length"
  NCRYPT_LENGTHS_PROPERTY* = "Lengths"
  NCRYPT_BLOCK_LENGTH_PROPERTY* = "Block Length"
  NCRYPT_CHAINING_MODE_PROPERTY* = "Chaining Mode"
  NCRYPT_AUTH_TAG_LENGTH* = "AuthTagLength"
  NCRYPT_UI_POLICY_PROPERTY* = "UI Policy"
  NCRYPT_EXPORT_POLICY_PROPERTY* = "Export Policy"
  NCRYPT_WINDOW_HANDLE_PROPERTY* = "HWND Handle"
  NCRYPT_USE_CONTEXT_PROPERTY* = "Use Context"
  NCRYPT_IMPL_TYPE_PROPERTY* = "Impl Type"
  NCRYPT_KEY_USAGE_PROPERTY* = "Key Usage"
  NCRYPT_KEY_TYPE_PROPERTY* = "Key Type"
  NCRYPT_VERSION_PROPERTY* = "Version"
  NCRYPT_SECURITY_DESCR_SUPPORT_PROPERTY* = "Security Descr Support"
  NCRYPT_SECURITY_DESCR_PROPERTY* = "Security Descr"
  NCRYPT_USE_COUNT_ENABLED_PROPERTY* = "Enabled Use Count"
  NCRYPT_USE_COUNT_PROPERTY* = "Use Count"
  NCRYPT_LAST_MODIFIED_PROPERTY* = "Modified"
  NCRYPT_MAX_NAME_LENGTH_PROPERTY* = "Max Name Length"
  NCRYPT_ALGORITHM_GROUP_PROPERTY* = "Algorithm Group"
  NCRYPT_DH_PARAMETERS_PROPERTY* = BCRYPT_DH_PARAMETERS
  NCRYPT_PROVIDER_HANDLE_PROPERTY* = "Provider Handle"
  NCRYPT_PIN_PROPERTY* = "SmartCardPin"
  NCRYPT_READER_PROPERTY* = "SmartCardReader"
  NCRYPT_SMARTCARD_GUID_PROPERTY* = "SmartCardGuid"
  NCRYPT_CERTIFICATE_PROPERTY* = "SmartCardKeyCertificate"
  NCRYPT_PIN_PROMPT_PROPERTY* = "SmartCardPinPrompt"
  NCRYPT_USER_CERTSTORE_PROPERTY* = "SmartCardUserCertStore"
  NCRYPT_ROOT_CERTSTORE_PROPERTY* = "SmartcardRootCertStore"
  NCRYPT_SECURE_PIN_PROPERTY* = "SmartCardSecurePin"
  NCRYPT_ASSOCIATED_ECDH_KEY* = "SmartCardAssociatedECDHKey"
  NCRYPT_SCARD_PIN_ID* = "SmartCardPinId"
  NCRYPT_SCARD_PIN_INFO* = "SmartCardPinInfo"
  NCRYPT_READER_ICON_PROPERTY* = "SmartCardReaderIcon"
  NCRYPT_KDF_SECRET_VALUE* = "KDFKeySecret"
  NCRYPT_PCP_PLATFORM_TYPE_PROPERTY* = "PCP_PLATFORM_TYPE"
  NCRYPT_PCP_PROVIDER_VERSION_PROPERTY* = "PCP_PROVIDER_VERSION"
  NCRYPT_PCP_EKPUB_PROPERTY* = "PCP_EKPUB"
  NCRYPT_PCP_EKCERT_PROPERTY* = "PCP_EKCERT"
  NCRYPT_PCP_EKNVCERT_PROPERTY* = "PCP_EKNVCERT"
  NCRYPT_PCP_SRKPUB_PROPERTY* = "PCP_SRKPUB"
  NCRYPT_PCP_PCRTABLE_PROPERTY* = "PCP_PCRTABLE"
  NCRYPT_PCP_CHANGEPASSWORD_PROPERTY* = "PCP_CHANGEPASSWORD"
  NCRYPT_PCP_PASSWORD_REQUIRED_PROPERTY* = "PCP_PASSWORD_REQUIRED"
  NCRYPT_PCP_USAGEAUTH_PROPERTY* = "PCP_USAGEAUTH"
  NCRYPT_PCP_MIGRATIONPASSWORD_PROPERTY* = "PCP_MIGRATIONPASSWORD"
  NCRYPT_PCP_EXPORT_ALLOWED_PROPERTY* = "PCP_EXPORT_ALLOWED"
  NCRYPT_PCP_STORAGEPARENT_PROPERTY* = "PCP_STORAGEPARENT"
  NCRYPT_PCP_PROVIDERHANDLE_PROPERTY* = "PCP_PROVIDERMHANDLE"
  NCRYPT_PCP_PLATFORMHANDLE_PROPERTY* = "PCP_PLATFORMHANDLE"
  NCRYPT_PCP_PLATFORM_BINDING_PCRMASK_PROPERTY* = "PCP_PLATFORM_BINDING_PCRMASK"
  NCRYPT_PCP_PLATFORM_BINDING_PCRDIGESTLIST_PROPERTY* = "PCP_PLATFORM_BINDING_PCRDIGESTLIST"
  NCRYPT_PCP_PLATFORM_BINDING_PCRDIGEST_PROPERTY* = "PCP_PLATFORM_BINDING_PCRDIGEST"
  NCRYPT_PCP_KEY_USAGE_POLICY_PROPERTY* = "PCP_KEY_USAGE_POLICY"
  NCRYPT_PCP_TPM12_IDBINDING_PROPERTY* = "PCP_TPM12_IDBINDING"
  NCRYPT_PCP_TPM12_IDACTIVATION_PROPERTY* = "PCP_TPM12_IDACTIVATION"
  NCRYPT_PCP_KEYATTESTATION_PROPERTY* = "PCP_TPM12_KEYATTESTATION"
  NCRYPT_PCP_ALTERNATE_KEY_STORAGE_LOCATION_PROPERTY* = "PCP_ALTERNATE_KEY_STORAGE_LOCATION"
  NCRYPT_TPM12_PROVIDER* = 0x00010000
  NCRYPT_PCP_SIGNATURE_KEY* = 0x1
  NCRYPT_PCP_ENCRYPTION_KEY* = 0x2
  NCRYPT_PCP_GENERIC_KEY* = NCRYPT_PCP_SIGNATURE_KEY or NCRYPT_PCP_ENCRYPTION_KEY
  NCRYPT_PCP_STORAGE_KEY* = 0x00000004
  NCRYPT_PCP_IDENTITY_KEY* = 0x00000008
  NCRYPT_INITIALIZATION_VECTOR* = BCRYPT_INITIALIZATION_VECTOR
  NCRYPT_MAX_PROPERTY_NAME* = 64
  NCRYPT_MAX_PROPERTY_DATA* = 0x100000
  NCRYPT_ALLOW_EXPORT_FLAG* = 0x1
  NCRYPT_ALLOW_PLAINTEXT_EXPORT_FLAG* = 0x2
  NCRYPT_ALLOW_ARCHIVING_FLAG* = 0x00000004
  NCRYPT_ALLOW_PLAINTEXT_ARCHIVING_FLAG* = 0x00000008
  NCRYPT_IMPL_HARDWARE_FLAG* = 0x1
  NCRYPT_IMPL_SOFTWARE_FLAG* = 0x2
  NCRYPT_IMPL_REMOVABLE_FLAG* = 0x00000008
  NCRYPT_IMPL_HARDWARE_RNG_FLAG* = 0x00000010
  NCRYPT_ALLOW_DECRYPT_FLAG* = 0x1
  NCRYPT_ALLOW_SIGNING_FLAG* = 0x2
  NCRYPT_ALLOW_KEY_AGREEMENT_FLAG* = 0x00000004
  NCRYPT_ALLOW_ALL_USAGES* = 0x00ffffff
  NCRYPT_UI_PROTECT_KEY_FLAG* = 0x1
  NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG* = 0x2
  NCRYPT_CIPHER_KEY_BLOB_MAGIC* = 0x52485043
  NCRYPT_PROTECTED_KEY_BLOB_MAGIC* = 0x4b545250
  NCRYPT_CIPHER_KEY_BLOB* = "CipherKeyBlob"
  NCRYPT_PROTECTED_KEY_BLOB* = "ProtectedKeyBlob"
  NCRYPT_PKCS7_ENVELOPE_BLOB* = "PKCS7_ENVELOPE"
  NCRYPT_PKCS8_PRIVATE_KEY_BLOB* = "PKCS8_PRIVATEKEY"
  NCRYPT_OPAQUETRANSPORT_BLOB* = "OpaqueTransport"
  NCRYPT_EXPORT_LEGACY_FLAG* = 0x00000800
  szOID_RSA* = "1.2.840.113549"
  szOID_PKCS* = "1.2.840.113549.1"
  szOID_RSA_HASH* = "1.2.840.113549.2"
  szOID_RSA_ENCRYPT* = "1.2.840.113549.3"
  szOID_PKCS_1* = "1.2.840.113549.1.1"
  szOID_PKCS_2* = "1.2.840.113549.1.2"
  szOID_PKCS_3* = "1.2.840.113549.1.3"
  szOID_PKCS_4* = "1.2.840.113549.1.4"
  szOID_PKCS_5* = "1.2.840.113549.1.5"
  szOID_PKCS_6* = "1.2.840.113549.1.6"
  szOID_PKCS_7* = "1.2.840.113549.1.7"
  szOID_PKCS_8* = "1.2.840.113549.1.8"
  szOID_PKCS_9* = "1.2.840.113549.1.9"
  szOID_PKCS_10* = "1.2.840.113549.1.10"
  szOID_PKCS_12* = "1.2.840.113549.1.12"
  szOID_RSA_RSA* = "1.2.840.113549.1.1.1"
  szOID_RSA_MD2RSA* = "1.2.840.113549.1.1.2"
  szOID_RSA_MD4RSA* = "1.2.840.113549.1.1.3"
  szOID_RSA_MD5RSA* = "1.2.840.113549.1.1.4"
  szOID_RSA_SHA1RSA* = "1.2.840.113549.1.1.5"
  szOID_RSA_SETOAEP_RSA* = "1.2.840.113549.1.1.6"
  szOID_RSAES_OAEP* = "1.2.840.113549.1.1.7"
  szOID_RSA_MGF1* = "1.2.840.113549.1.1.8"
  szOID_RSA_PSPECIFIED* = "1.2.840.113549.1.1.9"
  szOID_RSA_SSA_PSS* = "1.2.840.113549.1.1.10"
  szOID_RSA_SHA256RSA* = "1.2.840.113549.1.1.11"
  szOID_RSA_SHA384RSA* = "1.2.840.113549.1.1.12"
  szOID_RSA_SHA512RSA* = "1.2.840.113549.1.1.13"
  szOID_RSA_DH* = "1.2.840.113549.1.3.1"
  szOID_RSA_data* = "1.2.840.113549.1.7.1"
  szOID_RSA_signedData* = "1.2.840.113549.1.7.2"
  szOID_RSA_envelopedData* = "1.2.840.113549.1.7.3"
  szOID_RSA_signEnvData* = "1.2.840.113549.1.7.4"
  szOID_RSA_digestedData* = "1.2.840.113549.1.7.5"
  szOID_RSA_hashedData* = "1.2.840.113549.1.7.5"
  szOID_RSA_encryptedData* = "1.2.840.113549.1.7.6"
  szOID_RSA_emailAddr* = "1.2.840.113549.1.9.1"
  szOID_RSA_unstructName* = "1.2.840.113549.1.9.2"
  szOID_RSA_contentType* = "1.2.840.113549.1.9.3"
  szOID_RSA_messageDigest* = "1.2.840.113549.1.9.4"
  szOID_RSA_signingTime* = "1.2.840.113549.1.9.5"
  szOID_RSA_counterSign* = "1.2.840.113549.1.9.6"
  szOID_RSA_challengePwd* = "1.2.840.113549.1.9.7"
  szOID_RSA_unstructAddr* = "1.2.840.113549.1.9.8"
  szOID_RSA_extCertAttrs* = "1.2.840.113549.1.9.9"
  szOID_RSA_certExtensions* = "1.2.840.113549.1.9.14"
  szOID_RSA_SMIMECapabilities* = "1.2.840.113549.1.9.15"
  szOID_RSA_preferSignedData* = "1.2.840.113549.1.9.15.1"
  szOID_TIMESTAMP_TOKEN* = "1.2.840.113549.1.9.16.1.4"
  szOID_RFC3161_counterSign* = "1.3.6.1.4.1.311.3.3.1"
  szOID_RSA_SMIMEalg* = "1.2.840.113549.1.9.16.3"
  szOID_RSA_SMIMEalgESDH* = "1.2.840.113549.1.9.16.3.5"
  szOID_RSA_SMIMEalgCMS3DESwrap* = "1.2.840.113549.1.9.16.3.6"
  szOID_RSA_SMIMEalgCMSRC2wrap* = "1.2.840.113549.1.9.16.3.7"
  szOID_RSA_MD2* = "1.2.840.113549.2.2"
  szOID_RSA_MD4* = "1.2.840.113549.2.4"
  szOID_RSA_MD5* = "1.2.840.113549.2.5"
  szOID_RSA_RC2CBC* = "1.2.840.113549.3.2"
  szOID_RSA_RC4* = "1.2.840.113549.3.4"
  szOID_RSA_DES_EDE3_CBC* = "1.2.840.113549.3.7"
  szOID_RSA_RC5_CBCPad* = "1.2.840.113549.3.9"
  szOID_ANSI_X942* = "1.2.840.10046"
  szOID_ANSI_X942_DH* = "1.2.840.10046.2.1"
  szOID_X957* = "1.2.840.10040"
  szOID_X957_DSA* = "1.2.840.10040.4.1"
  szOID_X957_SHA1DSA* = "1.2.840.10040.4.3"
  szOID_ECC_PUBLIC_KEY* = "1.2.840.10045.2.1"
  szOID_ECC_CURVE_P256* = "1.2.840.10045.3.1.7"
  szOID_ECC_CURVE_P384* = "1.3.132.0.34"
  szOID_ECC_CURVE_P521* = "1.3.132.0.35"
  szOID_ECDSA_SHA1* = "1.2.840.10045.4.1"
  szOID_ECDSA_SPECIFIED* = "1.2.840.10045.4.3"
  szOID_ECDSA_SHA256* = "1.2.840.10045.4.3.2"
  szOID_ECDSA_SHA384* = "1.2.840.10045.4.3.3"
  szOID_ECDSA_SHA512* = "1.2.840.10045.4.3.4"
  szOID_NIST_AES128_CBC* = "2.16.840.1.101.3.4.1.2"
  szOID_NIST_AES192_CBC* = "2.16.840.1.101.3.4.1.22"
  szOID_NIST_AES256_CBC* = "2.16.840.1.101.3.4.1.42"
  szOID_NIST_AES128_WRAP* = "2.16.840.1.101.3.4.1.5"
  szOID_NIST_AES192_WRAP* = "2.16.840.1.101.3.4.1.25"
  szOID_NIST_AES256_WRAP* = "2.16.840.1.101.3.4.1.45"
  szOID_DH_SINGLE_PASS_STDDH_SHA1_KDF* = "1.3.133.16.840.63.0.2"
  szOID_DH_SINGLE_PASS_STDDH_SHA256_KDF* = "1.3.132.1.11.1"
  szOID_DH_SINGLE_PASS_STDDH_SHA384_KDF* = "1.3.132.1.11.2"
  szOID_DS* = "2.5"
  szOID_DSALG* = "2.5.8"
  szOID_DSALG_CRPT* = "2.5.8.1"
  szOID_DSALG_HASH* = "2.5.8.2"
  szOID_DSALG_SIGN* = "2.5.8.3"
  szOID_DSALG_RSA* = "2.5.8.1.1"
  szOID_OIW* = "1.3.14"
  szOID_OIWSEC* = "1.3.14.3.2"
  szOID_OIWSEC_md4RSA* = "1.3.14.3.2.2"
  szOID_OIWSEC_md5RSA* = "1.3.14.3.2.3"
  szOID_OIWSEC_md4RSA2* = "1.3.14.3.2.4"
  szOID_OIWSEC_desECB* = "1.3.14.3.2.6"
  szOID_OIWSEC_desCBC* = "1.3.14.3.2.7"
  szOID_OIWSEC_desOFB* = "1.3.14.3.2.8"
  szOID_OIWSEC_desCFB* = "1.3.14.3.2.9"
  szOID_OIWSEC_desMAC* = "1.3.14.3.2.10"
  szOID_OIWSEC_rsaSign* = "1.3.14.3.2.11"
  szOID_OIWSEC_dsa* = "1.3.14.3.2.12"
  szOID_OIWSEC_shaDSA* = "1.3.14.3.2.13"
  szOID_OIWSEC_mdc2RSA* = "1.3.14.3.2.14"
  szOID_OIWSEC_shaRSA* = "1.3.14.3.2.15"
  szOID_OIWSEC_dhCommMod* = "1.3.14.3.2.16"
  szOID_OIWSEC_desEDE* = "1.3.14.3.2.17"
  szOID_OIWSEC_sha* = "1.3.14.3.2.18"
  szOID_OIWSEC_mdc2* = "1.3.14.3.2.19"
  szOID_OIWSEC_dsaComm* = "1.3.14.3.2.20"
  szOID_OIWSEC_dsaCommSHA* = "1.3.14.3.2.21"
  szOID_OIWSEC_rsaXchg* = "1.3.14.3.2.22"
  szOID_OIWSEC_keyHashSeal* = "1.3.14.3.2.23"
  szOID_OIWSEC_md2RSASign* = "1.3.14.3.2.24"
  szOID_OIWSEC_md5RSASign* = "1.3.14.3.2.25"
  szOID_OIWSEC_sha1* = "1.3.14.3.2.26"
  szOID_OIWSEC_dsaSHA1* = "1.3.14.3.2.27"
  szOID_OIWSEC_dsaCommSHA1* = "1.3.14.3.2.28"
  szOID_OIWSEC_sha1RSASign* = "1.3.14.3.2.29"
  szOID_OIWDIR* = "1.3.14.7.2"
  szOID_OIWDIR_CRPT* = "1.3.14.7.2.1"
  szOID_OIWDIR_HASH* = "1.3.14.7.2.2"
  szOID_OIWDIR_SIGN* = "1.3.14.7.2.3"
  szOID_OIWDIR_md2* = "1.3.14.7.2.2.1"
  szOID_OIWDIR_md2RSA* = "1.3.14.7.2.3.1"
  szOID_INFOSEC* = "2.16.840.1.101.2.1"
  szOID_INFOSEC_sdnsSignature* = "2.16.840.1.101.2.1.1.1"
  szOID_INFOSEC_mosaicSignature* = "2.16.840.1.101.2.1.1.2"
  szOID_INFOSEC_sdnsConfidentiality* = "2.16.840.1.101.2.1.1.3"
  szOID_INFOSEC_mosaicConfidentiality* = "2.16.840.1.101.2.1.1.4"
  szOID_INFOSEC_sdnsIntegrity* = "2.16.840.1.101.2.1.1.5"
  szOID_INFOSEC_mosaicIntegrity* = "2.16.840.1.101.2.1.1.6"
  szOID_INFOSEC_sdnsTokenProtection* = "2.16.840.1.101.2.1.1.7"
  szOID_INFOSEC_mosaicTokenProtection* = "2.16.840.1.101.2.1.1.8"
  szOID_INFOSEC_sdnsKeyManagement* = "2.16.840.1.101.2.1.1.9"
  szOID_INFOSEC_mosaicKeyManagement* = "2.16.840.1.101.2.1.1.10"
  szOID_INFOSEC_sdnsKMandSig* = "2.16.840.1.101.2.1.1.11"
  szOID_INFOSEC_mosaicKMandSig* = "2.16.840.1.101.2.1.1.12"
  szOID_INFOSEC_SuiteASignature* = "2.16.840.1.101.2.1.1.13"
  szOID_INFOSEC_SuiteAConfidentiality* = "2.16.840.1.101.2.1.1.14"
  szOID_INFOSEC_SuiteAIntegrity* = "2.16.840.1.101.2.1.1.15"
  szOID_INFOSEC_SuiteATokenProtection* = "2.16.840.1.101.2.1.1.16"
  szOID_INFOSEC_SuiteAKeyManagement* = "2.16.840.1.101.2.1.1.17"
  szOID_INFOSEC_SuiteAKMandSig* = "2.16.840.1.101.2.1.1.18"
  szOID_INFOSEC_mosaicUpdatedSig* = "2.16.840.1.101.2.1.1.19"
  szOID_INFOSEC_mosaicKMandUpdSig* = "2.16.840.1.101.2.1.1.20"
  szOID_INFOSEC_mosaicUpdatedInteg* = "2.16.840.1.101.2.1.1.21"
  szOID_NIST_sha256* = "2.16.840.1.101.3.4.2.1"
  szOID_NIST_sha384* = "2.16.840.1.101.3.4.2.2"
  szOID_NIST_sha512* = "2.16.840.1.101.3.4.2.3"
  szOID_COMMON_NAME* = "2.5.4.3"
  szOID_SUR_NAME* = "2.5.4.4"
  szOID_DEVICE_SERIAL_NUMBER* = "2.5.4.5"
  szOID_COUNTRY_NAME* = "2.5.4.6"
  szOID_LOCALITY_NAME* = "2.5.4.7"
  szOID_STATE_OR_PROVINCE_NAME* = "2.5.4.8"
  szOID_STREET_ADDRESS* = "2.5.4.9"
  szOID_ORGANIZATION_NAME* = "2.5.4.10"
  szOID_ORGANIZATIONAL_UNIT_NAME* = "2.5.4.11"
  szOID_TITLE* = "2.5.4.12"
  szOID_DESCRIPTION* = "2.5.4.13"
  szOID_SEARCH_GUIDE* = "2.5.4.14"
  szOID_BUSINESS_CATEGORY* = "2.5.4.15"
  szOID_POSTAL_ADDRESS* = "2.5.4.16"
  szOID_POSTAL_CODE* = "2.5.4.17"
  szOID_POST_OFFICE_BOX* = "2.5.4.18"
  szOID_PHYSICAL_DELIVERY_OFFICE_NAME* = "2.5.4.19"
  szOID_TELEPHONE_NUMBER* = "2.5.4.20"
  szOID_TELEX_NUMBER* = "2.5.4.21"
  szOID_TELETEXT_TERMINAL_IDENTIFIER* = "2.5.4.22"
  szOID_FACSIMILE_TELEPHONE_NUMBER* = "2.5.4.23"
  szOID_X21_ADDRESS* = "2.5.4.24"
  szOID_INTERNATIONAL_ISDN_NUMBER* = "2.5.4.25"
  szOID_REGISTERED_ADDRESS* = "2.5.4.26"
  szOID_DESTINATION_INDICATOR* = "2.5.4.27"
  szOID_PREFERRED_DELIVERY_METHOD* = "2.5.4.28"
  szOID_PRESENTATION_ADDRESS* = "2.5.4.29"
  szOID_SUPPORTED_APPLICATION_CONTEXT* = "2.5.4.30"
  szOID_MEMBER* = "2.5.4.31"
  szOID_OWNER* = "2.5.4.32"
  szOID_ROLE_OCCUPANT* = "2.5.4.33"
  szOID_SEE_ALSO* = "2.5.4.34"
  szOID_USER_PASSWORD* = "2.5.4.35"
  szOID_USER_CERTIFICATE* = "2.5.4.36"
  szOID_CA_CERTIFICATE* = "2.5.4.37"
  szOID_AUTHORITY_REVOCATION_LIST* = "2.5.4.38"
  szOID_CERTIFICATE_REVOCATION_LIST* = "2.5.4.39"
  szOID_CROSS_CERTIFICATE_PAIR* = "2.5.4.40"
  szOID_GIVEN_NAME* = "2.5.4.42"
  szOID_INITIALS* = "2.5.4.43"
  szOID_DN_QUALIFIER* = "2.5.4.46"
  szOID_DOMAIN_COMPONENT* = "0.9.2342.19200300.100.1.25"
  szOID_PKCS_12_FRIENDLY_NAME_ATTR* = "1.2.840.113549.1.9.20"
  szOID_PKCS_12_LOCAL_KEY_ID* = "1.2.840.113549.1.9.21"
  szOID_PKCS_12_KEY_PROVIDER_NAME_ATTR* = "1.3.6.1.4.1.311.17.1"
  szOID_LOCAL_MACHINE_KEYSET* = "1.3.6.1.4.1.311.17.2"
  szOID_PKCS_12_EXTENDED_ATTRIBUTES* = "1.3.6.1.4.1.311.17.3"
  szOID_PKCS_12_PROTECTED_PASSWORD_SECRET_BAG_TYPE_ID* = "1.3.6.1.4.1.311.17.4"
  szOID_KEYID_RDN* = "1.3.6.1.4.1.311.10.7.1"
  szOID_EV_RDN_LOCALE* = "1.3.6.1.4.1.311.60.2.1.1"
  szOID_EV_RDN_STATE_OR_PROVINCE* = "1.3.6.1.4.1.311.60.2.1.2"
  szOID_EV_RDN_COUNTRY* = "1.3.6.1.4.1.311.60.2.1.3"
  CERT_RDN_ANY_TYPE* = 0
  CERT_RDN_ENCODED_BLOB* = 1
  CERT_RDN_OCTET_STRING* = 2
  CERT_RDN_NUMERIC_STRING* = 3
  CERT_RDN_PRINTABLE_STRING* = 4
  CERT_RDN_TELETEX_STRING* = 5
  CERT_RDN_T61_STRING* = 5
  CERT_RDN_VIDEOTEX_STRING* = 6
  CERT_RDN_IA5_STRING* = 7
  CERT_RDN_GRAPHIC_STRING* = 8
  CERT_RDN_VISIBLE_STRING* = 9
  CERT_RDN_ISO646_STRING* = 9
  CERT_RDN_GENERAL_STRING* = 10
  CERT_RDN_UNIVERSAL_STRING* = 11
  CERT_RDN_INT4_STRING* = 11
  CERT_RDN_BMP_STRING* = 12
  CERT_RDN_UNICODE_STRING* = 12
  CERT_RDN_UTF8_STRING* = 13
  CERT_RDN_TYPE_MASK* = 0x000000ff
  CERT_RDN_FLAGS_MASK* = 0xff000000'i32
  CERT_RDN_ENABLE_T61_UNICODE_FLAG* = 0x80000000'i32
  CERT_RDN_ENABLE_UTF8_UNICODE_FLAG* = 0x20000000
  CERT_RDN_FORCE_UTF8_UNICODE_FLAG* = 0x10000000
  CERT_RDN_DISABLE_CHECK_TYPE_FLAG* = 0x40000000
  CERT_RDN_DISABLE_IE4_UTF8_FLAG* = 0x1000000
  CERT_RDN_ENABLE_PUNYCODE_FLAG* = 0x2000000
  CERT_RSA_PUBLIC_KEY_OBJID* = szOID_RSA_RSA
  CERT_DEFAULT_OID_PUBLIC_KEY_SIGN* = szOID_RSA_RSA
  CERT_DEFAULT_OID_PUBLIC_KEY_XCHG* = szOID_RSA_RSA
  CRYPT_ECC_PRIVATE_KEY_INFO_v1* = 1
  CERT_V1* = 0
  CERT_V2* = 1
  CERT_V3* = 2
  CERT_INFO_VERSION_FLAG* = 1
  CERT_INFO_SERIAL_NUMBER_FLAG* = 2
  CERT_INFO_SIGNATURE_ALGORITHM_FLAG* = 3
  CERT_INFO_ISSUER_FLAG* = 4
  CERT_INFO_NOT_BEFORE_FLAG* = 5
  CERT_INFO_NOT_AFTER_FLAG* = 6
  CERT_INFO_SUBJECT_FLAG* = 7
  CERT_INFO_SUBJECT_PUBLIC_KEY_INFO_FLAG* = 8
  CERT_INFO_ISSUER_UNIQUE_ID_FLAG* = 9
  CERT_INFO_SUBJECT_UNIQUE_ID_FLAG* = 10
  CERT_INFO_EXTENSION_FLAG* = 11
  CRL_V1* = 0
  CRL_V2* = 1
  CERT_BUNDLE_CERTIFICATE* = 0
  CERT_BUNDLE_CRL* = 1
  CERT_REQUEST_V1* = 0
  CERT_KEYGEN_REQUEST_V1* = 0
  CTL_V1* = 0
  CERT_ENCODING_TYPE_MASK* = 0x0000ffff
  CMSG_ENCODING_TYPE_MASK* = 0xffff0000'i32
  CRYPT_ASN_ENCODING* = 0x1
  CRYPT_NDR_ENCODING* = 0x2
  X509_ASN_ENCODING* = 0x1
  X509_NDR_ENCODING* = 0x2
  PKCS_7_ASN_ENCODING* = 0x10000
  PKCS_7_NDR_ENCODING* = 0x20000
  CRYPT_FORMAT_STR_MULTI_LINE* = 0x1
  CRYPT_FORMAT_STR_NO_HEX* = 0x10
  CRYPT_FORMAT_SIMPLE* = 0x1
  CRYPT_FORMAT_X509* = 0x2
  CRYPT_FORMAT_OID* = 0x4
  CRYPT_FORMAT_RDN_SEMICOLON* = 0x100
  CRYPT_FORMAT_RDN_CRLF* = 0x200
  CRYPT_FORMAT_RDN_UNQUOTE* = 0x400
  CRYPT_FORMAT_RDN_REVERSE* = 0x800
  CRYPT_FORMAT_COMMA* = 0x1000
  CRYPT_FORMAT_SEMICOLON* = CRYPT_FORMAT_RDN_SEMICOLON
  CRYPT_FORMAT_CRLF* = CRYPT_FORMAT_RDN_CRLF
  CRYPT_ENCODE_NO_SIGNATURE_BYTE_REVERSAL_FLAG* = 0x8
  CRYPT_ENCODE_ALLOC_FLAG* = 0x8000
  CRYPT_UNICODE_NAME_ENCODE_ENABLE_T61_UNICODE_FLAG* = CERT_RDN_ENABLE_T61_UNICODE_FLAG
  CRYPT_UNICODE_NAME_ENCODE_ENABLE_UTF8_UNICODE_FLAG* = CERT_RDN_ENABLE_UTF8_UNICODE_FLAG
  CRYPT_UNICODE_NAME_ENCODE_FORCE_UTF8_UNICODE_FLAG* = CERT_RDN_FORCE_UTF8_UNICODE_FLAG
  CRYPT_UNICODE_NAME_ENCODE_DISABLE_CHECK_TYPE_FLAG* = CERT_RDN_DISABLE_CHECK_TYPE_FLAG
  CRYPT_SORTED_CTL_ENCODE_HASHED_SUBJECT_IDENTIFIER_FLAG* = 0x10000
  CRYPT_ENCODE_ENABLE_PUNYCODE_FLAG* = 0x20000
  CRYPT_ENCODE_ENABLE_UTF8PERCENT_FLAG* = 0x40000
  CRYPT_ENCODE_ENABLE_IA5CONVERSION_FLAG* = CRYPT_ENCODE_ENABLE_PUNYCODE_FLAG or CRYPT_ENCODE_ENABLE_UTF8PERCENT_FLAG
  CRYPT_DECODE_NOCOPY_FLAG* = 0x1
  CRYPT_DECODE_TO_BE_SIGNED_FLAG* = 0x2
  CRYPT_DECODE_SHARE_OID_STRING_FLAG* = 0x4
  CRYPT_DECODE_NO_SIGNATURE_BYTE_REVERSAL_FLAG* = 0x8
  CRYPT_DECODE_ALLOC_FLAG* = 0x8000
  CRYPT_UNICODE_NAME_DECODE_DISABLE_IE4_UTF8_FLAG* = CERT_RDN_DISABLE_IE4_UTF8_FLAG
  CRYPT_DECODE_ENABLE_PUNYCODE_FLAG* = 0x2000000
  CRYPT_DECODE_ENABLE_UTF8PERCENT_FLAG* = 0x4000000
  CRYPT_DECODE_ENABLE_IA5CONVERSION_FLAG* = CRYPT_DECODE_ENABLE_PUNYCODE_FLAG or CRYPT_DECODE_ENABLE_UTF8PERCENT_FLAG
  CRYPT_ENCODE_DECODE_NONE* = 0
  X509_CERT* = cast[LPCSTR](1)
  X509_CERT_TO_BE_SIGNED* = cast[LPCSTR](2)
  X509_CERT_CRL_TO_BE_SIGNED* = cast[LPCSTR](3)
  X509_CERT_REQUEST_TO_BE_SIGNED* = cast[LPCSTR](4)
  X509_EXTENSIONS* = cast[LPCSTR](5)
  X509_NAME_VALUE* = cast[LPCSTR](6)
  X509_NAME* = cast[LPCSTR](7)
  X509_PUBLIC_KEY_INFO* = cast[LPCSTR](8)
  X509_AUTHORITY_KEY_ID* = cast[LPCSTR](9)
  X509_KEY_ATTRIBUTES* = cast[LPCSTR](10)
  X509_KEY_USAGE_RESTRICTION* = cast[LPCSTR](11)
  X509_ALTERNATE_NAME* = cast[LPCSTR](12)
  X509_BASIC_CONSTRAINTS* = cast[LPCSTR](13)
  X509_KEY_USAGE* = cast[LPCSTR](14)
  X509_BASIC_CONSTRAINTS2* = cast[LPCSTR](15)
  X509_CERT_POLICIES* = cast[LPCSTR](16)
  PKCS_UTC_TIME* = cast[LPCSTR](17)
  PKCS_TIME_REQUEST* = cast[LPCSTR](18)
  RSA_CSP_PUBLICKEYBLOB* = cast[LPCSTR](19)
  X509_UNICODE_NAME* = cast[LPCSTR](20)
  X509_KEYGEN_REQUEST_TO_BE_SIGNED* = cast[LPCSTR](21)
  PKCS_ATTRIBUTE* = cast[LPCSTR](22)
  PKCS_CONTENT_INFO_SEQUENCE_OF_ANY* = cast[LPCSTR](23)
  X509_UNICODE_NAME_VALUE* = cast[LPCSTR](24)
  X509_ANY_STRING* = X509_NAME_VALUE
  X509_UNICODE_ANY_STRING* = X509_UNICODE_NAME_VALUE
  X509_OCTET_STRING* = cast[LPCSTR](25)
  X509_BITS* = cast[LPCSTR](26)
  X509_INTEGER* = cast[LPCSTR](27)
  X509_MULTI_BYTE_INTEGER* = cast[LPCSTR](28)
  X509_ENUMERATED* = cast[LPCSTR](29)
  X509_CHOICE_OF_TIME* = cast[LPCSTR](30)
  X509_AUTHORITY_KEY_ID2* = cast[LPCSTR](31)
  X509_AUTHORITY_INFO_ACCESS* = cast[LPCSTR](32)
  X509_SUBJECT_INFO_ACCESS* = X509_AUTHORITY_INFO_ACCESS
  X509_CRL_REASON_CODE* = X509_ENUMERATED
  PKCS_CONTENT_INFO* = cast[LPCSTR](33)
  X509_SEQUENCE_OF_ANY* = cast[LPCSTR](34)
  X509_CRL_DIST_POINTS* = cast[LPCSTR](35)
  X509_ENHANCED_KEY_USAGE* = cast[LPCSTR](36)
  PKCS_CTL* = cast[LPCSTR](37)
  X509_MULTI_BYTE_UINT* = cast[LPCSTR](38)
  X509_DSS_PUBLICKEY* = X509_MULTI_BYTE_UINT
  X509_DSS_PARAMETERS* = cast[LPCSTR](39)
  X509_DSS_SIGNATURE* = cast[LPCSTR](40)
  PKCS_RC2_CBC_PARAMETERS* = cast[LPCSTR](41)
  PKCS_SMIME_CAPABILITIES* = cast[LPCSTR](42)
  X509_QC_STATEMENTS_EXT* = cast[LPCSTR](42)
  PKCS_RSA_PRIVATE_KEY* = cast[LPCSTR](43)
  PKCS_PRIVATE_KEY_INFO* = cast[LPCSTR](44)
  PKCS_ENCRYPTED_PRIVATE_KEY_INFO* = cast[LPCSTR](45)
  X509_PKIX_POLICY_QUALIFIER_USERNOTICE* = cast[LPCSTR](46)
  X509_DH_PUBLICKEY* = X509_MULTI_BYTE_UINT
  X509_DH_PARAMETERS* = cast[LPCSTR](47)
  X509_ECC_SIGNATURE* = cast[LPCSTR](47)
  PKCS_ATTRIBUTES* = cast[LPCSTR](48)
  PKCS_SORTED_CTL* = cast[LPCSTR](49)
  X942_DH_PARAMETERS* = cast[LPCSTR](50)
  X509_BITS_WITHOUT_TRAILING_ZEROES* = cast[LPCSTR](51)
  X942_OTHER_INFO* = cast[LPCSTR](52)
  X509_CERT_PAIR* = cast[LPCSTR](53)
  X509_ISSUING_DIST_POINT* = cast[LPCSTR](54)
  X509_NAME_CONSTRAINTS* = cast[LPCSTR](55)
  X509_POLICY_MAPPINGS* = cast[LPCSTR](56)
  X509_POLICY_CONSTRAINTS* = cast[LPCSTR](57)
  X509_CROSS_CERT_DIST_POINTS* = cast[LPCSTR](58)
  CMC_DATA* = cast[LPCSTR](59)
  CMC_RESPONSE* = cast[LPCSTR](60)
  CMC_STATUS* = cast[LPCSTR](61)
  CMC_ADD_EXTENSIONS* = cast[LPCSTR](62)
  CMC_ADD_ATTRIBUTES* = cast[LPCSTR](63)
  X509_CERTIFICATE_TEMPLATE* = cast[LPCSTR](64)
  OCSP_SIGNED_REQUEST* = cast[LPCSTR](65)
  OCSP_REQUEST* = cast[LPCSTR](66)
  OCSP_RESPONSE* = cast[LPCSTR](67)
  OCSP_BASIC_SIGNED_RESPONSE* = cast[LPCSTR](68)
  OCSP_BASIC_RESPONSE* = cast[LPCSTR](69)
  X509_LOGOTYPE_EXT* = cast[LPCSTR](70)
  X509_BIOMETRIC_EXT* = cast[LPCSTR](71)
  CNG_RSA_PUBLIC_KEY_BLOB* = cast[LPCSTR](72)
  X509_OBJECT_IDENTIFIER* = cast[LPCSTR](73)
  X509_ALGORITHM_IDENTIFIER* = cast[LPCSTR](74)
  PKCS_RSA_SSA_PSS_PARAMETERS* = cast[LPCSTR](75)
  PKCS_RSAES_OAEP_PARAMETERS* = cast[LPCSTR](76)
  ECC_CMS_SHARED_INFO* = cast[LPCSTR](77)
  TIMESTAMP_REQUEST* = cast[LPCSTR](78)
  TIMESTAMP_RESPONSE* = cast[LPCSTR](79)
  TIMESTAMP_INFO* = cast[LPCSTR](80)
  X509_CERT_BUNDLE* = cast[LPCSTR](81)
  X509_ECC_PRIVATE_KEY* = cast[LPCSTR](82)
  CNG_RSA_PRIVATE_KEY_BLOB* = cast[LPCSTR](83)
  PKCS7_SIGNER_INFO* = cast[LPCSTR](500)
  CMS_SIGNER_INFO* = cast[LPCSTR](501)
  szOID_AUTHORITY_KEY_IDENTIFIER* = "2.5.29.1"
  szOID_KEY_ATTRIBUTES* = "2.5.29.2"
  szOID_CERT_POLICIES_95* = "2.5.29.3"
  szOID_KEY_USAGE_RESTRICTION* = "2.5.29.4"
  szOID_SUBJECT_ALT_NAME* = "2.5.29.7"
  szOID_ISSUER_ALT_NAME* = "2.5.29.8"
  szOID_BASIC_CONSTRAINTS* = "2.5.29.10"
  szOID_KEY_USAGE* = "2.5.29.15"
  szOID_PRIVATEKEY_USAGE_PERIOD* = "2.5.29.16"
  szOID_BASIC_CONSTRAINTS2* = "2.5.29.19"
  szOID_CERT_POLICIES* = "2.5.29.32"
  szOID_ANY_CERT_POLICY* = "2.5.29.32.0"
  szOID_INHIBIT_ANY_POLICY* = "2.5.29.54"
  szOID_AUTHORITY_KEY_IDENTIFIER2* = "2.5.29.35"
  szOID_SUBJECT_KEY_IDENTIFIER* = "2.5.29.14"
  szOID_SUBJECT_ALT_NAME2* = "2.5.29.17"
  szOID_ISSUER_ALT_NAME2* = "2.5.29.18"
  szOID_CRL_REASON_CODE* = "2.5.29.21"
  szOID_REASON_CODE_HOLD* = "2.5.29.23"
  szOID_CRL_DIST_POINTS* = "2.5.29.31"
  szOID_ENHANCED_KEY_USAGE* = "2.5.29.37"
  szOID_ANY_ENHANCED_KEY_USAGE* = "2.5.29.37.0"
  szOID_CRL_NUMBER* = "2.5.29.20"
  szOID_DELTA_CRL_INDICATOR* = "2.5.29.27"
  szOID_ISSUING_DIST_POINT* = "2.5.29.28"
  szOID_FRESHEST_CRL* = "2.5.29.46"
  szOID_NAME_CONSTRAINTS* = "2.5.29.30"
  szOID_POLICY_MAPPINGS* = "2.5.29.33"
  szOID_LEGACY_POLICY_MAPPINGS* = "2.5.29.5"
  szOID_POLICY_CONSTRAINTS* = "2.5.29.36"
  szOID_RENEWAL_CERTIFICATE* = "1.3.6.1.4.1.311.13.1"
  szOID_ENROLLMENT_NAME_VALUE_PAIR* = "1.3.6.1.4.1.311.13.2.1"
  szOID_ENROLLMENT_CSP_PROVIDER* = "1.3.6.1.4.1.311.13.2.2"
  szOID_OS_VERSION* = "1.3.6.1.4.1.311.13.2.3"
  szOID_ENROLLMENT_AGENT* = "1.3.6.1.4.1.311.20.2.1"
  szOID_PKIX* = "1.3.6.1.5.5.7"
  szOID_PKIX_PE* = "1.3.6.1.5.5.7.1"
  szOID_AUTHORITY_INFO_ACCESS* = "1.3.6.1.5.5.7.1.1"
  szOID_SUBJECT_INFO_ACCESS* = "1.3.6.1.5.5.7.1.11"
  szOID_BIOMETRIC_EXT* = "1.3.6.1.5.5.7.1.2"
  szOID_QC_STATEMENTS_EXT* = "1.3.6.1.5.5.7.1.3"
  szOID_LOGOTYPE_EXT* = "1.3.6.1.5.5.7.1.12"
  szOID_CERT_EXTENSIONS* = "1.3.6.1.4.1.311.2.1.14"
  szOID_NEXT_UPDATE_LOCATION* = "1.3.6.1.4.1.311.10.2"
  szOID_REMOVE_CERTIFICATE* = "1.3.6.1.4.1.311.10.8.1"
  szOID_CROSS_CERT_DIST_POINTS* = "1.3.6.1.4.1.311.10.9.1"
  szOID_CTL* = "1.3.6.1.4.1.311.10.1"
  szOID_SORTED_CTL* = "1.3.6.1.4.1.311.10.1.1"
  szOID_SERIALIZED* = "1.3.6.1.4.1.311.10.3.3.1"
  szOID_NT_PRINCIPAL_NAME* = "1.3.6.1.4.1.311.20.2.3"
  szOID_INTERNATIONALIZED_EMAIL_ADDRESS* = "1.3.6.1.4.1.311.20.2.4"
  szOID_PRODUCT_UPDATE* = "1.3.6.1.4.1.311.31.1"
  szOID_ANY_APPLICATION_POLICY* = "1.3.6.1.4.1.311.10.12.1"
  szOID_AUTO_ENROLL_CTL_USAGE* = "1.3.6.1.4.1.311.20.1"
  szOID_ENROLL_CERTTYPE_EXTENSION* = "1.3.6.1.4.1.311.20.2"
  szOID_CERT_MANIFOLD* = "1.3.6.1.4.1.311.20.3"
  szOID_CERTSRV_CA_VERSION* = "1.3.6.1.4.1.311.21.1"
  szOID_CERTSRV_PREVIOUS_CERT_HASH* = "1.3.6.1.4.1.311.21.2"
  szOID_CRL_VIRTUAL_BASE* = "1.3.6.1.4.1.311.21.3"
  szOID_CRL_NEXT_PUBLISH* = "1.3.6.1.4.1.311.21.4"
  szOID_KP_CA_EXCHANGE* = "1.3.6.1.4.1.311.21.5"
  szOID_KP_KEY_RECOVERY_AGENT* = "1.3.6.1.4.1.311.21.6"
  szOID_CERTIFICATE_TEMPLATE* = "1.3.6.1.4.1.311.21.7"
  szOID_ENTERPRISE_OID_ROOT* = "1.3.6.1.4.1.311.21.8"
  szOID_RDN_DUMMY_SIGNER* = "1.3.6.1.4.1.311.21.9"
  szOID_APPLICATION_CERT_POLICIES* = "1.3.6.1.4.1.311.21.10"
  szOID_APPLICATION_POLICY_MAPPINGS* = "1.3.6.1.4.1.311.21.11"
  szOID_APPLICATION_POLICY_CONSTRAINTS* = "1.3.6.1.4.1.311.21.12"
  szOID_ARCHIVED_KEY_ATTR* = "1.3.6.1.4.1.311.21.13"
  szOID_CRL_SELF_CDP* = "1.3.6.1.4.1.311.21.14"
  szOID_REQUIRE_CERT_CHAIN_POLICY* = "1.3.6.1.4.1.311.21.15"
  szOID_ARCHIVED_KEY_CERT_HASH* = "1.3.6.1.4.1.311.21.16"
  szOID_ISSUED_CERT_HASH* = "1.3.6.1.4.1.311.21.17"
  szOID_DS_EMAIL_REPLICATION* = "1.3.6.1.4.1.311.21.19"
  szOID_REQUEST_CLIENT_INFO* = "1.3.6.1.4.1.311.21.20"
  szOID_ENCRYPTED_KEY_HASH* = "1.3.6.1.4.1.311.21.21"
  szOID_CERTSRV_CROSSCA_VERSION* = "1.3.6.1.4.1.311.21.22"
  szOID_NTDS_REPLICATION* = "1.3.6.1.4.1.311.25.1"
  szOID_SUBJECT_DIR_ATTRS* = "2.5.29.9"
  szOID_PKIX_KP* = "1.3.6.1.5.5.7.3"
  szOID_PKIX_KP_SERVER_AUTH* = "1.3.6.1.5.5.7.3.1"
  szOID_PKIX_KP_CLIENT_AUTH* = "1.3.6.1.5.5.7.3.2"
  szOID_PKIX_KP_CODE_SIGNING* = "1.3.6.1.5.5.7.3.3"
  szOID_PKIX_KP_EMAIL_PROTECTION* = "1.3.6.1.5.5.7.3.4"
  szOID_PKIX_KP_IPSEC_END_SYSTEM* = "1.3.6.1.5.5.7.3.5"
  szOID_PKIX_KP_IPSEC_TUNNEL* = "1.3.6.1.5.5.7.3.6"
  szOID_PKIX_KP_IPSEC_USER* = "1.3.6.1.5.5.7.3.7"
  szOID_PKIX_KP_TIMESTAMP_SIGNING* = "1.3.6.1.5.5.7.3.8"
  szOID_PKIX_KP_OCSP_SIGNING* = "1.3.6.1.5.5.7.3.9"
  szOID_PKIX_OCSP_NONCE* = "1.3.6.1.5.5.7.48.1.2"
  szOID_PKIX_OCSP_NOCHECK* = "1.3.6.1.5.5.7.48.1.5"
  szOID_IPSEC_KP_IKE_INTERMEDIATE* = "1.3.6.1.5.5.8.2.2"
  szOID_PKINIT_KP_KDC* = "1.3.6.1.5.2.3.5"
  szOID_KP_CTL_USAGE_SIGNING* = "1.3.6.1.4.1.311.10.3.1"
  szOID_KP_TIME_STAMP_SIGNING* = "1.3.6.1.4.1.311.10.3.2"
  szOID_SERVER_GATED_CRYPTO* = "1.3.6.1.4.1.311.10.3.3"
  szOID_SGC_NETSCAPE* = "2.16.840.1.113730.4.1"
  szOID_KP_EFS* = "1.3.6.1.4.1.311.10.3.4"
  szOID_EFS_RECOVERY* = "1.3.6.1.4.1.311.10.3.4.1"
  szOID_WHQL_CRYPTO* = "1.3.6.1.4.1.311.10.3.5"
  szOID_NT5_CRYPTO* = "1.3.6.1.4.1.311.10.3.6"
  szOID_OEM_WHQL_CRYPTO* = "1.3.6.1.4.1.311.10.3.7"
  szOID_EMBEDDED_NT_CRYPTO* = "1.3.6.1.4.1.311.10.3.8"
  szOID_ROOT_LIST_SIGNER* = "1.3.6.1.4.1.311.10.3.9"
  szOID_KP_QUALIFIED_SUBORDINATION* = "1.3.6.1.4.1.311.10.3.10"
  szOID_KP_KEY_RECOVERY* = "1.3.6.1.4.1.311.10.3.11"
  szOID_KP_DOCUMENT_SIGNING* = "1.3.6.1.4.1.311.10.3.12"
  szOID_KP_LIFETIME_SIGNING* = "1.3.6.1.4.1.311.10.3.13"
  szOID_KP_MOBILE_DEVICE_SOFTWARE* = "1.3.6.1.4.1.311.10.3.14"
  szOID_KP_SMART_DISPLAY* = "1.3.6.1.4.1.311.10.3.15"
  szOID_KP_CSP_SIGNATURE* = "1.3.6.1.4.1.311.10.3.16"
  szOID_DRM* = "1.3.6.1.4.1.311.10.5.1"
  szOID_DRM_INDIVIDUALIZATION* = "1.3.6.1.4.1.311.10.5.2"
  szOID_LICENSES* = "1.3.6.1.4.1.311.10.6.1"
  szOID_LICENSE_SERVER* = "1.3.6.1.4.1.311.10.6.2"
  szOID_KP_SMARTCARD_LOGON* = "1.3.6.1.4.1.311.20.2.2"
  szOID_KP_KERNEL_MODE_CODE_SIGNING* = "1.3.6.1.4.1.311.61.1.1"
  szOID_KP_KERNEL_MODE_TRUSTED_BOOT_SIGNING* = "1.3.6.1.4.1.311.61.4.1"
  szOID_REVOKED_LIST_SIGNER* = "1.3.6.1.4.1.311.10.3.19"
  szOID_DISALLOWED_LIST* = "1.3.6.1.4.1.311.10.3.30"
  szOID_KP_KERNEL_MODE_HAL_EXTENSION_SIGNING* = "1.3.6.1.4.1.311.61.5.1"
  szOID_YESNO_TRUST_ATTR* = "1.3.6.1.4.1.311.10.4.1"
  szOID_PKIX_POLICY_QUALIFIER_CPS* = "1.3.6.1.5.5.7.2.1"
  szOID_PKIX_POLICY_QUALIFIER_USERNOTICE* = "1.3.6.1.5.5.7.2.2"
  szOID_ROOT_PROGRAM_FLAGS* = "1.3.6.1.4.1.311.60.1.1"
  CERT_ROOT_PROGRAM_FLAG_ORG* = 0x80
  CERT_ROOT_PROGRAM_FLAG_LSC* = 0x40
  CERT_ROOT_PROGRAM_FLAG_SUBJECT_LOGO* = 0x20
  CERT_ROOT_PROGRAM_FLAG_OU* = 0x10
  CERT_ROOT_PROGRAM_FLAG_ADDRESS* = 0x08
  szOID_CERT_POLICIES_95_QUALIFIER1* = "2.16.840.1.113733.1.7.1.1"
  CERT_UNICODE_RDN_ERR_INDEX_MASK* = 0x3ff
  CERT_UNICODE_RDN_ERR_INDEX_SHIFT* = 22
  CERT_UNICODE_ATTR_ERR_INDEX_MASK* = 0x3f
  CERT_UNICODE_ATTR_ERR_INDEX_SHIFT* = 16
  CERT_UNICODE_VALUE_ERR_INDEX_MASK* = 0xffff
  CERT_UNICODE_VALUE_ERR_INDEX_SHIFT* = 0
  CERT_ENCIPHER_ONLY_KEY_USAGE* = 0x01
  CERT_OFFLINE_CRL_SIGN_KEY_USAGE* = 0x02
  CERT_KEY_CERT_SIGN_KEY_USAGE* = 0x04
  CERT_KEY_AGREEMENT_KEY_USAGE* = 0x08
  CERT_DATA_ENCIPHERMENT_KEY_USAGE* = 0x10
  CERT_KEY_ENCIPHERMENT_KEY_USAGE* = 0x20
  CERT_NON_REPUDIATION_KEY_USAGE* = 0x40
  CERT_DIGITAL_SIGNATURE_KEY_USAGE* = 0x80
  CERT_DECIPHER_ONLY_KEY_USAGE* = 0x80
  CERT_ALT_NAME_OTHER_NAME* = 1
  CERT_ALT_NAME_RFC822_NAME* = 2
  CERT_ALT_NAME_DNS_NAME* = 3
  CERT_ALT_NAME_X400_ADDRESS* = 4
  CERT_ALT_NAME_DIRECTORY_NAME* = 5
  CERT_ALT_NAME_EDI_PARTY_NAME* = 6
  CERT_ALT_NAME_URL* = 7
  CERT_ALT_NAME_IP_ADDRESS* = 8
  CERT_ALT_NAME_REGISTERED_ID* = 9
  CERT_ALT_NAME_ENTRY_ERR_INDEX_MASK* = 0xff
  CERT_ALT_NAME_ENTRY_ERR_INDEX_SHIFT* = 16
  CERT_ALT_NAME_VALUE_ERR_INDEX_MASK* = 0x0000ffff
  CERT_ALT_NAME_VALUE_ERR_INDEX_SHIFT* = 0
  CERT_CA_SUBJECT_FLAG* = 0x80
  CERT_END_ENTITY_SUBJECT_FLAG* = 0x40
  szOID_PKIX_ACC_DESCR* = "1.3.6.1.5.5.7.48"
  szOID_PKIX_OCSP* = "1.3.6.1.5.5.7.48.1"
  szOID_PKIX_CA_ISSUERS* = "1.3.6.1.5.5.7.48.2"
  szOID_PKIX_TIME_STAMPING* = "1.3.6.1.5.5.7.48.3"
  szOID_PKIX_CA_REPOSITORY* = "1.3.6.1.5.5.7.48.5"
  CRL_REASON_UNSPECIFIED* = 0
  CRL_REASON_KEY_COMPROMISE* = 1
  CRL_REASON_CA_COMPROMISE* = 2
  CRL_REASON_AFFILIATION_CHANGED* = 3
  CRL_REASON_SUPERSEDED* = 4
  CRL_REASON_CESSATION_OF_OPERATION* = 5
  CRL_REASON_CERTIFICATE_HOLD* = 6
  CRL_REASON_REMOVE_FROM_CRL* = 8
  CRL_DIST_POINT_NO_NAME* = 0
  CRL_DIST_POINT_FULL_NAME* = 1
  CRL_DIST_POINT_ISSUER_RDN_NAME* = 2
  CRL_REASON_UNUSED_FLAG* = 0x80
  CRL_REASON_KEY_COMPROMISE_FLAG* = 0x40
  CRL_REASON_CA_COMPROMISE_FLAG* = 0x20
  CRL_REASON_AFFILIATION_CHANGED_FLAG* = 0x10
  CRL_REASON_SUPERSEDED_FLAG* = 0x08
  CRL_REASON_CESSATION_OF_OPERATION_FLAG* = 0x04
  CRL_REASON_CERTIFICATE_HOLD_FLAG* = 0x02
  CRL_DIST_POINT_ERR_INDEX_MASK* = 0x7f
  CRL_DIST_POINT_ERR_INDEX_SHIFT* = 24
  CRL_DIST_POINT_ERR_CRL_ISSUER_BIT* = 0x80000000'i32
  CROSS_CERT_DIST_POINT_ERR_INDEX_MASK* = 0xff
  CROSS_CERT_DIST_POINT_ERR_INDEX_SHIFT* = 24
  CERT_EXCLUDED_SUBTREE_BIT* = 0x80000000'i32
  SORTED_CTL_EXT_FLAGS_OFFSET* = 0
  SORTED_CTL_EXT_COUNT_OFFSET* = 4
  SORTED_CTL_EXT_MAX_COLLISION_OFFSET* = 8
  SORTED_CTL_EXT_HASH_BUCKET_OFFSET* = 12
  SORTED_CTL_EXT_HASHED_SUBJECT_IDENTIFIER_FLAG* = 0x1
  CERT_DSS_R_LEN* = 20
  CERT_DSS_S_LEN* = 20
  CERT_DSS_SIGNATURE_LEN* = CERT_DSS_R_LEN+CERT_DSS_S_LEN
  CERT_MAX_ASN_ENCODED_DSS_SIGNATURE_LEN* = 48
  CRYPT_X942_PUB_INFO_BYTE_LENGTH* = 512/8
  CRYPT_RC2_40BIT_VERSION* = 160
  CRYPT_RC2_56BIT_VERSION* = 52
  CRYPT_RC2_64BIT_VERSION* = 120
  CRYPT_RC2_128BIT_VERSION* = 58
  szOID_QC_EU_COMPLIANCE* = "0.4.0.1862.1.1"
  szOID_QC_SSCD* = "0.4.0.1862.1.4"
  PKCS_RSA_SSA_PSS_TRAILER_FIELD_BC* = 1
  szOID_VERISIGN_PRIVATE_6_9* = "2.16.840.1.113733.1.6.9"
  szOID_VERISIGN_ONSITE_JURISDICTION_HASH* = "2.16.840.1.113733.1.6.11"
  szOID_VERISIGN_BITSTRING_6_13* = "2.16.840.1.113733.1.6.13"
  szOID_VERISIGN_ISS_STRONG_CRYPTO* = "2.16.840.1.113733.1.8.1"
  szOID_NETSCAPE* = "2.16.840.1.113730"
  szOID_NETSCAPE_CERT_EXTENSION* = "2.16.840.1.113730.1"
  szOID_NETSCAPE_CERT_TYPE* = "2.16.840.1.113730.1.1"
  szOID_NETSCAPE_BASE_URL* = "2.16.840.1.113730.1.2"
  szOID_NETSCAPE_REVOCATION_URL* = "2.16.840.1.113730.1.3"
  szOID_NETSCAPE_CA_REVOCATION_URL* = "2.16.840.1.113730.1.4"
  szOID_NETSCAPE_CERT_RENEWAL_URL* = "2.16.840.1.113730.1.7"
  szOID_NETSCAPE_CA_POLICY_URL* = "2.16.840.1.113730.1.8"
  szOID_NETSCAPE_SSL_SERVER_NAME* = "2.16.840.1.113730.1.12"
  szOID_NETSCAPE_COMMENT* = "2.16.840.1.113730.1.13"
  szOID_NETSCAPE_DATA_TYPE* = "2.16.840.1.113730.2"
  szOID_NETSCAPE_CERT_SEQUENCE* = "2.16.840.1.113730.2.5"
  NETSCAPE_SIGN_CA_CERT_TYPE* = 0x01
  NETSCAPE_SMIME_CA_CERT_TYPE* = 0x02
  NETSCAPE_SSL_CA_CERT_TYPE* = 0x04
  NETSCAPE_SIGN_CERT_TYPE* = 0x10
  NETSCAPE_SMIME_CERT_TYPE* = 0x20
  NETSCAPE_SSL_SERVER_AUTH_CERT_TYPE* = 0x40
  NETSCAPE_SSL_CLIENT_AUTH_CERT_TYPE* = 0x80
  szOID_CT_PKI_DATA* = "1.3.6.1.5.5.7.12.2"
  szOID_CT_PKI_RESPONSE* = "1.3.6.1.5.5.7.12.3"
  szOID_PKIX_NO_SIGNATURE* = "1.3.6.1.5.5.7.6.2"
  szOID_CMC* = "1.3.6.1.5.5.7.7"
  szOID_CMC_STATUS_INFO* = "1.3.6.1.5.5.7.7.1"
  szOID_CMC_IDENTIFICATION* = "1.3.6.1.5.5.7.7.2"
  szOID_CMC_IDENTITY_PROOF* = "1.3.6.1.5.5.7.7.3"
  szOID_CMC_DATA_RETURN* = "1.3.6.1.5.5.7.7.4"
  szOID_CMC_TRANSACTION_ID* = "1.3.6.1.5.5.7.7.5"
  szOID_CMC_SENDER_NONCE* = "1.3.6.1.5.5.7.7.6"
  szOID_CMC_RECIPIENT_NONCE* = "1.3.6.1.5.5.7.7.7"
  szOID_CMC_ADD_EXTENSIONS* = "1.3.6.1.5.5.7.7.8"
  szOID_CMC_ENCRYPTED_POP* = "1.3.6.1.5.5.7.7.9"
  szOID_CMC_DECRYPTED_POP* = "1.3.6.1.5.5.7.7.10"
  szOID_CMC_LRA_POP_WITNESS* = "1.3.6.1.5.5.7.7.11"
  szOID_CMC_GET_CERT* = "1.3.6.1.5.5.7.7.15"
  szOID_CMC_GET_CRL* = "1.3.6.1.5.5.7.7.16"
  szOID_CMC_REVOKE_REQUEST* = "1.3.6.1.5.5.7.7.17"
  szOID_CMC_REG_INFO* = "1.3.6.1.5.5.7.7.18"
  szOID_CMC_RESPONSE_INFO* = "1.3.6.1.5.5.7.7.19"
  szOID_CMC_QUERY_PENDING* = "1.3.6.1.5.5.7.7.21"
  szOID_CMC_ID_POP_LINK_RANDOM* = "1.3.6.1.5.5.7.7.22"
  szOID_CMC_ID_POP_LINK_WITNESS* = "1.3.6.1.5.5.7.7.23"
  szOID_CMC_ID_CONFIRM_CERT_ACCEPTANCE* = "1.3.6.1.5.5.7.7.24"
  szOID_CMC_ADD_ATTRIBUTES* = "1.3.6.1.4.1.311.10.10.1"
  CMC_TAGGED_CERT_REQUEST_CHOICE* = 1
  CMC_OTHER_INFO_NO_CHOICE* = 0
  CMC_OTHER_INFO_FAIL_CHOICE* = 1
  CMC_OTHER_INFO_PEND_CHOICE* = 2
  CMC_STATUS_SUCCESS* = 0
  CMC_STATUS_FAILED* = 2
  CMC_STATUS_PENDING* = 3
  CMC_STATUS_NO_SUPPORT* = 4
  CMC_STATUS_CONFIRM_REQUIRED* = 5
  CMC_FAIL_BAD_ALG* = 0
  CMC_FAIL_BAD_MESSAGE_CHECK* = 1
  CMC_FAIL_BAD_REQUEST* = 2
  CMC_FAIL_BAD_TIME* = 3
  CMC_FAIL_BAD_CERT_ID* = 4
  CMC_FAIL_UNSUPORTED_EXT* = 5
  CMC_FAIL_MUST_ARCHIVE_KEYS* = 6
  CMC_FAIL_BAD_IDENTITY* = 7
  CMC_FAIL_POP_REQUIRED* = 8
  CMC_FAIL_POP_FAILED* = 9
  CMC_FAIL_NO_KEY_REUSE* = 10
  CMC_FAIL_INTERNAL_CA_ERROR* = 11
  CMC_FAIL_TRY_LATER* = 12
  CERT_LOGOTYPE_GRAY_SCALE_IMAGE_INFO_CHOICE* = 1
  CERT_LOGOTYPE_COLOR_IMAGE_INFO_CHOICE* = 2
  CERT_LOGOTYPE_NO_IMAGE_RESOLUTION_CHOICE* = 0
  CERT_LOGOTYPE_BITS_IMAGE_RESOLUTION_CHOICE* = 1
  CERT_LOGOTYPE_TABLE_SIZE_IMAGE_RESOLUTION_CHOICE* = 2
  CERT_LOGOTYPE_DIRECT_INFO_CHOICE* = 1
  CERT_LOGOTYPE_INDIRECT_INFO_CHOICE* = 2
  szOID_LOYALTY_OTHER_LOGOTYPE* = "1.3.6.1.5.5.7.20.1"
  szOID_BACKGROUND_OTHER_LOGOTYPE* = "1.3.6.1.5.5.7.20.2"
  CERT_BIOMETRIC_PREDEFINED_DATA_CHOICE* = 1
  CERT_BIOMETRIC_OID_DATA_CHOICE* = 2
  CERT_BIOMETRIC_PICTURE_TYPE* = 0
  CERT_BIOMETRIC_SIGNATURE_TYPE* = 1
  OCSP_REQUEST_V1* = 0
  OCSP_SUCCESSFUL_RESPONSE* = 0
  OCSP_MALFORMED_REQUEST_RESPONSE* = 1
  OCSP_INTERNAL_ERROR_RESPONSE* = 2
  OCSP_TRY_LATER_RESPONSE* = 3
  OCSP_SIG_REQUIRED_RESPONSE* = 5
  OCSP_UNAUTHORIZED_RESPONSE* = 6
  szOID_PKIX_OCSP_BASIC_SIGNED_RESPONSE* = "1.3.6.1.5.5.7.48.1.1"
  OCSP_BASIC_GOOD_CERT_STATUS* = 0
  OCSP_BASIC_REVOKED_CERT_STATUS* = 1
  OCSP_BASIC_UNKNOWN_CERT_STATUS* = 2
  OCSP_BASIC_RESPONSE_V1* = 0
  OCSP_BASIC_BY_NAME_RESPONDER_ID* = 1
  OCSP_BASIC_BY_KEY_RESPONDER_ID* = 2
  CRYPT_OID_ENCODE_OBJECT_FUNC* = "CryptDllEncodeObject"
  CRYPT_OID_DECODE_OBJECT_FUNC* = "CryptDllDecodeObject"
  CRYPT_OID_ENCODE_OBJECT_EX_FUNC* = "CryptDllEncodeObjectEx"
  CRYPT_OID_DECODE_OBJECT_EX_FUNC* = "CryptDllDecodeObjectEx"
  CRYPT_OID_CREATE_COM_OBJECT_FUNC* = "CryptDllCreateCOMObject"
  CRYPT_OID_VERIFY_REVOCATION_FUNC* = "CertDllVerifyRevocation"
  CRYPT_OID_VERIFY_CTL_USAGE_FUNC* = "CertDllVerifyCTLUsage"
  CRYPT_OID_FORMAT_OBJECT_FUNC* = "CryptDllFormatObject"
  CRYPT_OID_FIND_OID_INFO_FUNC* = "CryptDllFindOIDInfo"
  CRYPT_OID_FIND_LOCALIZED_NAME_FUNC* = "CryptDllFindLocalizedName"
  CRYPT_OID_REGPATH* = "Software\\Microsoft\\Cryptography\\OID"
  CRYPT_OID_REG_ENCODING_TYPE_PREFIX* = "EncodingType "
  CRYPT_OID_REG_DLL_VALUE_NAME* = "Dll"
  CRYPT_OID_REG_FUNC_NAME_VALUE_NAME* = "FuncName"
  CRYPT_OID_REG_FUNC_NAME_VALUE_NAME_A* = "FuncName"
  CRYPT_OID_REG_FLAGS_VALUE_NAME* = "CryptFlags"
  CRYPT_DEFAULT_OID* = "DEFAULT"
  CRYPT_INSTALL_OID_FUNC_BEFORE_FLAG* = 1
  CRYPT_GET_INSTALLED_OID_FUNC_FLAG* = 0x1
  CRYPT_REGISTER_FIRST_INDEX* = 0
  CRYPT_REGISTER_LAST_INDEX* = 0xffffffff'i32
  CRYPT_MATCH_ANY_ENCODING_TYPE* = 0xffffffff'i32
  CALG_OID_INFO_CNG_ONLY* = 0xffffffff'i32
  CALG_OID_INFO_PARAMETERS* = 0xfffffffe'i32
  CRYPT_OID_INFO_HASH_PARAMETERS_ALGORITHM* = "CryptOIDInfoHashParameters"
  CRYPT_OID_INFO_ECC_PARAMETERS_ALGORITHM* = "CryptOIDInfoECCParameters"
  CRYPT_OID_INFO_MGF1_PARAMETERS_ALGORITHM* = "CryptOIDInfoMgf1Parameters"
  CRYPT_OID_INFO_NO_SIGN_ALGORITHM* = "CryptOIDInfoNoSign"
  CRYPT_OID_INFO_OAEP_PARAMETERS_ALGORITHM* = "CryptOIDInfoOAEPParameters"
  CRYPT_OID_INFO_ECC_WRAP_PARAMETERS_ALGORITHM* = "CryptOIDInfoECCWrapParameters"
  CRYPT_OID_INFO_NO_PARAMETERS_ALGORITHM* = "CryptOIDInfoNoParameters"
  CRYPT_HASH_ALG_OID_GROUP_ID* = 1
  CRYPT_ENCRYPT_ALG_OID_GROUP_ID* = 2
  CRYPT_PUBKEY_ALG_OID_GROUP_ID* = 3
  CRYPT_SIGN_ALG_OID_GROUP_ID* = 4
  CRYPT_RDN_ATTR_OID_GROUP_ID* = 5
  CRYPT_EXT_OR_ATTR_OID_GROUP_ID* = 6
  CRYPT_ENHKEY_USAGE_OID_GROUP_ID* = 7
  CRYPT_POLICY_OID_GROUP_ID* = 8
  CRYPT_TEMPLATE_OID_GROUP_ID* = 9
  CRYPT_KDF_OID_GROUP_ID* = 10
  CRYPT_LAST_OID_GROUP_ID* = 10
  CRYPT_FIRST_ALG_OID_GROUP_ID* = CRYPT_HASH_ALG_OID_GROUP_ID
  CRYPT_LAST_ALG_OID_GROUP_ID* = CRYPT_SIGN_ALG_OID_GROUP_ID
  CRYPT_OID_INHIBIT_SIGNATURE_FORMAT_FLAG* = 0x1
  CRYPT_OID_USE_PUBKEY_PARA_FOR_PKCS7_FLAG* = 0x2
  CRYPT_OID_NO_NULL_ALGORITHM_PARA_FLAG* = 0x4
  CRYPT_OID_PUBKEY_ENCRYPT_ONLY_FLAG* = 0x40000000
  CRYPT_OID_PUBKEY_SIGN_ONLY_FLAG* = 0x80000000'i32
  CRYPT_OID_INFO_OID_KEY* = 1
  CRYPT_OID_INFO_NAME_KEY* = 2
  CRYPT_OID_INFO_ALGID_KEY* = 3
  CRYPT_OID_INFO_SIGN_KEY* = 4
  CRYPT_OID_INFO_CNG_ALGID_KEY* = 5
  CRYPT_OID_INFO_CNG_SIGN_KEY* = 6
  CRYPT_OID_INFO_OID_KEY_FLAGS_MASK* = 0xffff0000'i32
  CRYPT_OID_INFO_PUBKEY_SIGN_KEY_FLAG* = 0x80000000'i32
  CRYPT_OID_INFO_PUBKEY_ENCRYPT_KEY_FLAG* = 0x40000000
  CRYPT_OID_DISABLE_SEARCH_DS_FLAG* = 0x80000000'i32
  CRYPT_OID_PREFER_CNG_ALGID_FLAG* = 0x40000000
  CRYPT_OID_INFO_OID_GROUP_BIT_LEN_MASK* = 0x0fff0000
  CRYPT_OID_INFO_OID_GROUP_BIT_LEN_SHIFT* = 16
  CRYPT_INSTALL_OID_INFO_BEFORE_FLAG* = 1
  CRYPT_LOCALIZED_NAME_ENCODING_TYPE* = 0
  CRYPT_LOCALIZED_NAME_OID* = "LocalizedNames"
  CERT_STRONG_SIGN_ECDSA_ALGORITHM* = "ECDSA"
  CERT_STRONG_SIGN_SERIALIZED_INFO_CHOICE* = 1
  CERT_STRONG_SIGN_OID_INFO_CHOICE* = 2
  CERT_STRONG_SIGN_ENABLE_CRL_CHECK* = 0x1
  CERT_STRONG_SIGN_ENABLE_OCSP_CHECK* = 0x2
  szOID_CERT_STRONG_SIGN_OS_PREFIX* = "1.3.6.1.4.1.311.72.1."
  szOID_CERT_STRONG_SIGN_OS_1* = "1.3.6.1.4.1.311.72.1.1"
  szOID_CERT_STRONG_SIGN_OS_CURRENT* = szOID_CERT_STRONG_SIGN_OS_1
  szOID_CERT_STRONG_KEY_OS_PREFIX* = "1.3.6.1.4.1.311.72.2."
  szOID_CERT_STRONG_KEY_OS_1* = "1.3.6.1.4.1.311.72.2.1"
  szOID_CERT_STRONG_KEY_OS_CURRENT* = szOID_CERT_STRONG_KEY_OS_1
  szOID_PKCS_7_DATA* = "1.2.840.113549.1.7.1"
  szOID_PKCS_7_SIGNED* = "1.2.840.113549.1.7.2"
  szOID_PKCS_7_ENVELOPED* = "1.2.840.113549.1.7.3"
  szOID_PKCS_7_SIGNEDANDENVELOPED* = "1.2.840.113549.1.7.4"
  szOID_PKCS_7_DIGESTED* = "1.2.840.113549.1.7.5"
  szOID_PKCS_7_ENCRYPTED* = "1.2.840.113549.1.7.6"
  szOID_PKCS_9_CONTENT_TYPE* = "1.2.840.113549.1.9.3"
  szOID_PKCS_9_MESSAGE_DIGEST* = "1.2.840.113549.1.9.4"
  CMSG_DATA* = 1
  CMSG_SIGNED* = 2
  CMSG_ENVELOPED* = 3
  CMSG_SIGNED_AND_ENVELOPED* = 4
  CMSG_HASHED* = 5
  CMSG_ENCRYPTED* = 6
  CMSG_ALL_FLAGS* = not 0
  CMSG_DATA_FLAG* = 1 shl CMSG_DATA
  CMSG_SIGNED_FLAG* = 1 shl CMSG_SIGNED
  CMSG_ENVELOPED_FLAG* = 1 shl CMSG_ENVELOPED
  CMSG_SIGNED_AND_ENVELOPED_FLAG* = 1 shl CMSG_SIGNED_AND_ENVELOPED
  CMSG_HASHED_FLAG* = 1 shl CMSG_HASHED
  CMSG_ENCRYPTED_FLAG* = 1 shl CMSG_ENCRYPTED
  CERT_ID_ISSUER_SERIAL_NUMBER* = 1
  CERT_ID_KEY_IDENTIFIER* = 2
  CERT_ID_SHA1_HASH* = 3
  CMSG_KEY_AGREE_EPHEMERAL_KEY_CHOICE* = 1
  CMSG_KEY_AGREE_STATIC_KEY_CHOICE* = 2
  CMSG_MAIL_LIST_HANDLE_KEY_CHOICE* = 1
  CMSG_KEY_TRANS_RECIPIENT* = 1
  CMSG_KEY_AGREE_RECIPIENT* = 2
  CMSG_MAIL_LIST_RECIPIENT* = 3
  CMSG_RC4_NO_SALT_FLAG* = 0x40000000
  CMSG_SP3_COMPATIBLE_ENCRYPT_FLAG* = 0x80000000'i32
  CMSG_INDEFINITE_LENGTH* = 0xffffffff'i32
  CMSG_BARE_CONTENT_FLAG* = 0x1
  CMSG_LENGTH_ONLY_FLAG* = 0x2
  CMSG_DETACHED_FLAG* = 0x4
  CMSG_AUTHENTICATED_ATTRIBUTES_FLAG* = 0x8
  CMSG_CONTENTS_OCTETS_FLAG* = 0x10
  CMSG_MAX_LENGTH_FLAG* = 0x20
  CMSG_CMS_ENCAPSULATED_CONTENT_FLAG* = 0x40
  CMSG_CRYPT_RELEASE_CONTEXT_FLAG* = 0x8000
  CMSG_TYPE_PARAM* = 1
  CMSG_CONTENT_PARAM* = 2
  CMSG_BARE_CONTENT_PARAM* = 3
  CMSG_INNER_CONTENT_TYPE_PARAM* = 4
  CMSG_SIGNER_COUNT_PARAM* = 5
  CMSG_SIGNER_INFO_PARAM* = 6
  CMSG_SIGNER_CERT_INFO_PARAM* = 7
  CMSG_SIGNER_HASH_ALGORITHM_PARAM* = 8
  CMSG_SIGNER_AUTH_ATTR_PARAM* = 9
  CMSG_SIGNER_UNAUTH_ATTR_PARAM* = 10
  CMSG_CERT_COUNT_PARAM* = 11
  CMSG_CERT_PARAM* = 12
  CMSG_CRL_COUNT_PARAM* = 13
  CMSG_CRL_PARAM* = 14
  CMSG_ENVELOPE_ALGORITHM_PARAM* = 15
  CMSG_RECIPIENT_COUNT_PARAM* = 17
  CMSG_RECIPIENT_INDEX_PARAM* = 18
  CMSG_RECIPIENT_INFO_PARAM* = 19
  CMSG_HASH_ALGORITHM_PARAM* = 20
  CMSG_HASH_DATA_PARAM* = 21
  CMSG_COMPUTED_HASH_PARAM* = 22
  CMSG_ENCRYPT_PARAM* = 26
  CMSG_ENCRYPTED_DIGEST* = 27
  CMSG_ENCODED_SIGNER* = 28
  CMSG_ENCODED_MESSAGE* = 29
  CMSG_VERSION_PARAM* = 30
  CMSG_ATTR_CERT_COUNT_PARAM* = 31
  CMSG_ATTR_CERT_PARAM* = 32
  CMSG_CMS_RECIPIENT_COUNT_PARAM* = 33
  CMSG_CMS_RECIPIENT_INDEX_PARAM* = 34
  CMSG_CMS_RECIPIENT_ENCRYPTED_KEY_INDEX_PARAM* = 35
  CMSG_CMS_RECIPIENT_INFO_PARAM* = 36
  CMSG_UNPROTECTED_ATTR_PARAM* = 37
  CMSG_SIGNER_CERT_ID_PARAM* = 38
  CMSG_CMS_SIGNER_INFO_PARAM* = 39
  CMSG_SIGNED_DATA_V1* = 1
  CMSG_SIGNED_DATA_V3* = 3
  CMSG_SIGNED_DATA_PKCS_1_5_VERSION* = CMSG_SIGNED_DATA_V1
  CMSG_SIGNED_DATA_CMS_VERSION* = CMSG_SIGNED_DATA_V3
  CMSG_SIGNER_INFO_V1* = 1
  CMSG_SIGNER_INFO_V3* = 3
  CMSG_SIGNER_INFO_PKCS_1_5_VERSION* = CMSG_SIGNER_INFO_V1
  CMSG_SIGNER_INFO_CMS_VERSION* = CMSG_SIGNER_INFO_V3
  CMSG_HASHED_DATA_V0* = 0
  CMSG_HASHED_DATA_V2* = 2
  CMSG_HASHED_DATA_PKCS_1_5_VERSION* = CMSG_HASHED_DATA_V0
  CMSG_HASHED_DATA_CMS_VERSION* = CMSG_HASHED_DATA_V2
  CMSG_ENVELOPED_DATA_V0* = 0
  CMSG_ENVELOPED_DATA_V2* = 2
  CMSG_ENVELOPED_DATA_PKCS_1_5_VERSION* = CMSG_ENVELOPED_DATA_V0
  CMSG_ENVELOPED_DATA_CMS_VERSION* = CMSG_ENVELOPED_DATA_V2
  CMSG_KEY_AGREE_ORIGINATOR_CERT* = 1
  CMSG_KEY_AGREE_ORIGINATOR_PUBLIC_KEY* = 2
  CMSG_ENVELOPED_RECIPIENT_V0* = 0
  CMSG_ENVELOPED_RECIPIENT_V2* = 2
  CMSG_ENVELOPED_RECIPIENT_V3* = 3
  CMSG_ENVELOPED_RECIPIENT_V4* = 4
  CMSG_KEY_TRANS_PKCS_1_5_VERSION* = CMSG_ENVELOPED_RECIPIENT_V0
  CMSG_KEY_TRANS_CMS_VERSION* = CMSG_ENVELOPED_RECIPIENT_V2
  CMSG_KEY_AGREE_VERSION* = CMSG_ENVELOPED_RECIPIENT_V3
  CMSG_MAIL_LIST_VERSION* = CMSG_ENVELOPED_RECIPIENT_V4
  CMSG_CTRL_VERIFY_SIGNATURE* = 1
  CMSG_CTRL_DECRYPT* = 2
  CMSG_CTRL_VERIFY_HASH* = 5
  CMSG_CTRL_ADD_SIGNER* = 6
  CMSG_CTRL_DEL_SIGNER* = 7
  CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR* = 8
  CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR* = 9
  CMSG_CTRL_ADD_CERT* = 10
  CMSG_CTRL_DEL_CERT* = 11
  CMSG_CTRL_ADD_CRL* = 12
  CMSG_CTRL_DEL_CRL* = 13
  CMSG_CTRL_ADD_ATTR_CERT* = 14
  CMSG_CTRL_DEL_ATTR_CERT* = 15
  CMSG_CTRL_KEY_TRANS_DECRYPT* = 16
  CMSG_CTRL_KEY_AGREE_DECRYPT* = 17
  CMSG_CTRL_MAIL_LIST_DECRYPT* = 18
  CMSG_CTRL_VERIFY_SIGNATURE_EX* = 19
  CMSG_CTRL_ADD_CMS_SIGNER_INFO* = 20
  CMSG_CTRL_ENABLE_STRONG_SIGNATURE* = 21
  CMSG_VERIFY_SIGNER_PUBKEY* = 1
  CMSG_VERIFY_SIGNER_CERT* = 2
  CMSG_VERIFY_SIGNER_CHAIN* = 3
  CMSG_VERIFY_SIGNER_NULL* = 4
  CMSG_VERIFY_COUNTER_SIGN_ENABLE_STRONG_FLAG* = 0x1
  CMSG_OID_GEN_ENCRYPT_KEY_FUNC* = "CryptMsgDllGenEncryptKey"
  CMSG_OID_EXPORT_ENCRYPT_KEY_FUNC* = "CryptMsgDllExportEncryptKey"
  CMSG_OID_IMPORT_ENCRYPT_KEY_FUNC* = "CryptMsgDllImportEncryptKey"
  CMSG_DEFAULT_INSTALLABLE_FUNC_OID* = cast[LPCSTR](1)
  CMSG_CONTENT_ENCRYPT_PAD_ENCODED_LEN_FLAG* = 0x1
  CMSG_CONTENT_ENCRYPT_FREE_PARA_FLAG* = 0x1
  CMSG_CONTENT_ENCRYPT_FREE_OBJID_FLAG* = 0x2
  CMSG_CONTENT_ENCRYPT_RELEASE_CONTEXT_FLAG* = 0x8000
  CMSG_OID_GEN_CONTENT_ENCRYPT_KEY_FUNC* = "CryptMsgDllGenContentEncryptKey"
  CMSG_OID_CAPI1_GEN_CONTENT_ENCRYPT_KEY_FUNC* = CMSG_OID_GEN_CONTENT_ENCRYPT_KEY_FUNC
  CMSG_OID_CNG_GEN_CONTENT_ENCRYPT_KEY_FUNC* = "CryptMsgDllCNGGenContentEncryptKey"
  CMSG_KEY_TRANS_ENCRYPT_FREE_PARA_FLAG* = 0x1
  CMSG_KEY_TRANS_ENCRYPT_FREE_OBJID_FLAG* = 0x2
  CMSG_OID_EXPORT_KEY_TRANS_FUNC* = "CryptMsgDllExportKeyTrans"
  CMSG_OID_CAPI1_EXPORT_KEY_TRANS_FUNC* = CMSG_OID_EXPORT_KEY_TRANS_FUNC
  CMSG_OID_CNG_EXPORT_KEY_TRANS_FUNC* = "CryptMsgDllCNGExportKeyTrans"
  CMSG_KEY_AGREE_ENCRYPT_FREE_PARA_FLAG* = 0x1
  CMSG_KEY_AGREE_ENCRYPT_FREE_MATERIAL_FLAG* = 0x2
  CMSG_KEY_AGREE_ENCRYPT_FREE_PUBKEY_ALG_FLAG* = 0x4
  CMSG_KEY_AGREE_ENCRYPT_FREE_PUBKEY_PARA_FLAG* = 0x8
  CMSG_KEY_AGREE_ENCRYPT_FREE_PUBKEY_BITS_FLAG* = 0x10
  CMSG_KEY_AGREE_ENCRYPT_FREE_OBJID_FLAG* = 0x20
  CMSG_OID_EXPORT_KEY_AGREE_FUNC* = "CryptMsgDllExportKeyAgree"
  CMSG_OID_CAPI1_EXPORT_KEY_AGREE_FUNC* = CMSG_OID_EXPORT_KEY_AGREE_FUNC
  CMSG_OID_CNG_EXPORT_KEY_AGREE_FUNC* = "CryptMsgDllCNGExportKeyAgree"
  CMSG_MAIL_LIST_ENCRYPT_FREE_PARA_FLAG* = 0x1
  CMSG_MAIL_LIST_ENCRYPT_FREE_OBJID_FLAG* = 0x2
  CMSG_OID_EXPORT_MAIL_LIST_FUNC* = "CryptMsgDllExportMailList"
  CMSG_OID_CAPI1_EXPORT_MAIL_LIST_FUNC* = CMSG_OID_EXPORT_MAIL_LIST_FUNC
  CMSG_OID_IMPORT_KEY_TRANS_FUNC* = "CryptMsgDllImportKeyTrans"
  CMSG_OID_CAPI1_IMPORT_KEY_TRANS_FUNC* = CMSG_OID_IMPORT_KEY_TRANS_FUNC
  CMSG_OID_IMPORT_KEY_AGREE_FUNC* = "CryptMsgDllImportKeyAgree"
  CMSG_OID_CAPI1_IMPORT_KEY_AGREE_FUNC* = CMSG_OID_IMPORT_KEY_AGREE_FUNC
  CMSG_OID_IMPORT_MAIL_LIST_FUNC* = "CryptMsgDllImportMailList"
  CMSG_OID_CAPI1_IMPORT_MAIL_LIST_FUNC* = CMSG_OID_IMPORT_MAIL_LIST_FUNC
  CMSG_OID_CNG_IMPORT_KEY_TRANS_FUNC* = "CryptMsgDllCNGImportKeyTrans"
  CMSG_OID_CNG_IMPORT_KEY_AGREE_FUNC* = "CryptMsgDllCNGImportKeyAgree"
  CMSG_OID_CNG_IMPORT_CONTENT_ENCRYPT_KEY_FUNC* = "CryptMsgDllCNGImportContentEncryptKey"
  CERT_KEY_PROV_HANDLE_PROP_ID* = 1
  CERT_KEY_PROV_INFO_PROP_ID* = 2
  CERT_SHA1_HASH_PROP_ID* = 3
  CERT_MD5_HASH_PROP_ID* = 4
  CERT_HASH_PROP_ID* = CERT_SHA1_HASH_PROP_ID
  CERT_KEY_CONTEXT_PROP_ID* = 5
  CERT_KEY_SPEC_PROP_ID* = 6
  CERT_IE30_RESERVED_PROP_ID* = 7
  CERT_PUBKEY_HASH_RESERVED_PROP_ID* = 8
  CERT_ENHKEY_USAGE_PROP_ID* = 9
  CERT_CTL_USAGE_PROP_ID* = CERT_ENHKEY_USAGE_PROP_ID
  CERT_NEXT_UPDATE_LOCATION_PROP_ID* = 10
  CERT_FRIENDLY_NAME_PROP_ID* = 11
  CERT_PVK_FILE_PROP_ID* = 12
  CERT_DESCRIPTION_PROP_ID* = 13
  CERT_ACCESS_STATE_PROP_ID* = 14
  CERT_SIGNATURE_HASH_PROP_ID* = 15
  CERT_SMART_CARD_DATA_PROP_ID* = 16
  CERT_EFS_PROP_ID* = 17
  CERT_FORTEZZA_DATA_PROP_ID* = 18
  CERT_ARCHIVED_PROP_ID* = 19
  CERT_KEY_IDENTIFIER_PROP_ID* = 20
  CERT_AUTO_ENROLL_PROP_ID* = 21
  CERT_PUBKEY_ALG_PARA_PROP_ID* = 22
  CERT_CROSS_CERT_DIST_POINTS_PROP_ID* = 23
  CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID* = 24
  CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID* = 25
  CERT_ENROLLMENT_PROP_ID* = 26
  CERT_DATE_STAMP_PROP_ID* = 27
  CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID* = 28
  CERT_SUBJECT_NAME_MD5_HASH_PROP_ID* = 29
  CERT_EXTENDED_ERROR_INFO_PROP_ID* = 30
  CERT_RENEWAL_PROP_ID* = 64
  CERT_ARCHIVED_KEY_HASH_PROP_ID* = 65
  CERT_AUTO_ENROLL_RETRY_PROP_ID* = 66
  CERT_AIA_URL_RETRIEVED_PROP_ID* = 67
  CERT_AUTHORITY_INFO_ACCESS_PROP_ID* = 68
  CERT_BACKED_UP_PROP_ID* = 69
  CERT_OCSP_RESPONSE_PROP_ID* = 70
  CERT_REQUEST_ORIGINATOR_PROP_ID* = 71
  CERT_SOURCE_LOCATION_PROP_ID* = 72
  CERT_SOURCE_URL_PROP_ID* = 73
  CERT_NEW_KEY_PROP_ID* = 74
  CERT_OCSP_CACHE_PREFIX_PROP_ID* = 75
  CERT_SMART_CARD_ROOT_INFO_PROP_ID* = 76
  CERT_NO_AUTO_EXPIRE_CHECK_PROP_ID* = 77
  CERT_NCRYPT_KEY_HANDLE_PROP_ID* = 78
  CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID* = 79
  CERT_SUBJECT_INFO_ACCESS_PROP_ID* = 80
  CERT_CA_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID* = 81
  CERT_CA_DISABLE_CRL_PROP_ID* = 82
  CERT_ROOT_PROGRAM_CERT_POLICIES_PROP_ID* = 83
  CERT_ROOT_PROGRAM_NAME_CONSTRAINTS_PROP_ID* = 84
  CERT_SUBJECT_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID* = 85
  CERT_SUBJECT_DISABLE_CRL_PROP_ID* = 86
  CERT_CEP_PROP_ID* = 87
  CERT_SIGN_HASH_CNG_ALG_PROP_ID* = 89
  CERT_SCARD_PIN_ID_PROP_ID* = 90
  CERT_SCARD_PIN_INFO_PROP_ID* = 91
  CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID* = 92
  CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID* = 93
  CERT_ISSUER_PUB_KEY_BIT_LENGTH_PROP_ID* = 94
  CERT_ISSUER_CHAIN_SIGN_HASH_CNG_ALG_PROP_ID* = 95
  CERT_ISSUER_CHAIN_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID* = 96
  CERT_NO_EXPIRE_NOTIFICATION_PROP_ID* = 97
  CERT_AUTH_ROOT_SHA256_HASH_PROP_ID* = 98
  CERT_NCRYPT_KEY_HANDLE_TRANSFER_PROP_ID* = 99
  CERT_HCRYPTPROV_TRANSFER_PROP_ID* = 100
  CERT_SMART_CARD_READER_PROP_ID* = 101
  CERT_SEND_AS_TRUSTED_ISSUER_PROP_ID* = 102
  CERT_KEY_REPAIR_ATTEMPTED_PROP_ID* = 103
  CERT_DISALLOWED_FILETIME_PROP_ID* = 104
  CERT_ROOT_PROGRAM_CHAIN_POLICIES_PROP_ID* = 105
  CERT_SMART_CARD_READER_NON_REMOVABLE_PROP_ID* = 106
  CERT_FIRST_RESERVED_PROP_ID* = 107
  CERT_LAST_RESERVED_PROP_ID* = 0x00007fff
  CERT_FIRST_USER_PROP_ID* = 0x8000
  CERT_LAST_USER_PROP_ID* = 0x0000ffff
  szOID_CERT_PROP_ID_PREFIX* = "1.3.6.1.4.1.311.10.11."
  szOID_CERT_KEY_IDENTIFIER_PROP_ID* = "1.3.6.1.4.1.311.10.11.20"
  szOID_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID* = "1.3.6.1.4.1.311.10.11.28"
  szOID_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID* = "1.3.6.1.4.1.311.10.11.29"
  szOID_CERT_MD5_HASH_PROP_ID* = "1.3.6.1.4.1.311.10.11.4"
  szOID_CERT_SIGNATURE_HASH_PROP_ID* = "1.3.6.1.4.1.311.10.11.15"
  szOID_DISALLOWED_HASH* = szOID_CERT_SIGNATURE_HASH_PROP_ID
  szOID_CERT_DISALLOWED_FILETIME_PROP_ID* = "1.3.6.1.4.1.311.10.11.104"
  CERT_ACCESS_STATE_WRITE_PERSIST_FLAG* = 0x1
  CERT_ACCESS_STATE_SYSTEM_STORE_FLAG* = 0x2
  CERT_ACCESS_STATE_LM_SYSTEM_STORE_FLAG* = 0x4
  CERT_ACCESS_STATE_GP_SYSTEM_STORE_FLAG* = 0x8
  CERT_ACCESS_STATE_SHARED_USER_FLAG* = 0x10
  szOID_ROOT_PROGRAM_AUTO_UPDATE_CA_REVOCATION* = "1.3.6.1.4.1.311.60.3.1"
  szOID_ROOT_PROGRAM_AUTO_UPDATE_END_REVOCATION* = "1.3.6.1.4.1.311.60.3.2"
  szOID_ROOT_PROGRAM_NO_OCSP_FAILOVER_TO_CRL* = "1.3.6.1.4.1.311.60.3.3"
  CERT_SET_KEY_PROV_HANDLE_PROP_ID* = 0x1
  CERT_SET_KEY_CONTEXT_PROP_ID* = 0x1
  CERT_NCRYPT_KEY_SPEC* = 0xffffffff'i32
  CERT_STORE_PROV_MSG* = cast[LPCSTR](1)
  CERT_STORE_PROV_MEMORY* = cast[LPCSTR](2)
  CERT_STORE_PROV_FILE* = cast[LPCSTR](3)
  CERT_STORE_PROV_REG* = cast[LPCSTR](4)
  CERT_STORE_PROV_PKCS7* = cast[LPCSTR](5)
  CERT_STORE_PROV_SERIALIZED* = cast[LPCSTR](6)
  CERT_STORE_PROV_FILENAME_A* = cast[LPCSTR](7)
  CERT_STORE_PROV_FILENAME_W* = cast[LPCSTR](8)
  CERT_STORE_PROV_FILENAME* = CERT_STORE_PROV_FILENAME_W
  CERT_STORE_PROV_SYSTEM_A* = cast[LPCSTR](9)
  CERT_STORE_PROV_SYSTEM_W* = cast[LPCSTR](10)
  CERT_STORE_PROV_SYSTEM* = CERT_STORE_PROV_SYSTEM_W
  CERT_STORE_PROV_COLLECTION* = cast[LPCSTR](11)
  CERT_STORE_PROV_SYSTEM_REGISTRY_A* = cast[LPCSTR](12)
  CERT_STORE_PROV_SYSTEM_REGISTRY_W* = cast[LPCSTR](13)
  CERT_STORE_PROV_SYSTEM_REGISTRY* = CERT_STORE_PROV_SYSTEM_REGISTRY_W
  CERT_STORE_PROV_PHYSICAL_W* = cast[LPCSTR](14)
  CERT_STORE_PROV_PHYSICAL* = CERT_STORE_PROV_PHYSICAL_W
  CERT_STORE_PROV_SMART_CARD_W* = cast[LPCSTR](15)
  CERT_STORE_PROV_SMART_CARD* = CERT_STORE_PROV_SMART_CARD_W
  CERT_STORE_PROV_LDAP_W* = cast[LPCSTR](16)
  CERT_STORE_PROV_LDAP* = CERT_STORE_PROV_LDAP_W
  CERT_STORE_PROV_PKCS12* = cast[LPCSTR](17)
  sz_CERT_STORE_PROV_MEMORY* = "Memory"
  sz_CERT_STORE_PROV_FILENAME_W* = "File"
  sz_CERT_STORE_PROV_FILENAME* = sz_CERT_STORE_PROV_FILENAME_W
  sz_CERT_STORE_PROV_SYSTEM_W* = "System"
  sz_CERT_STORE_PROV_SYSTEM* = sz_CERT_STORE_PROV_SYSTEM_W
  sz_CERT_STORE_PROV_PKCS7* = "PKCS7"
  sz_CERT_STORE_PROV_PKCS12* = "PKCS12"
  sz_CERT_STORE_PROV_SERIALIZED* = "Serialized"
  sz_CERT_STORE_PROV_COLLECTION* = "Collection"
  sz_CERT_STORE_PROV_SYSTEM_REGISTRY_W* = "SystemRegistry"
  sz_CERT_STORE_PROV_SYSTEM_REGISTRY* = sz_CERT_STORE_PROV_SYSTEM_REGISTRY_W
  sz_CERT_STORE_PROV_PHYSICAL_W* = "Physical"
  sz_CERT_STORE_PROV_PHYSICAL* = sz_CERT_STORE_PROV_PHYSICAL_W
  sz_CERT_STORE_PROV_SMART_CARD_W* = "SmartCard"
  sz_CERT_STORE_PROV_SMART_CARD* = sz_CERT_STORE_PROV_SMART_CARD_W
  sz_CERT_STORE_PROV_LDAP_W* = "Ldap"
  sz_CERT_STORE_PROV_LDAP* = sz_CERT_STORE_PROV_LDAP_W
  CERT_STORE_SIGNATURE_FLAG* = 0x1
  CERT_STORE_TIME_VALIDITY_FLAG* = 0x2
  CERT_STORE_REVOCATION_FLAG* = 0x4
  CERT_STORE_NO_CRL_FLAG* = 0x10000
  CERT_STORE_NO_ISSUER_FLAG* = 0x20000
  CERT_STORE_BASE_CRL_FLAG* = 0x100
  CERT_STORE_DELTA_CRL_FLAG* = 0x200
  CERT_STORE_NO_CRYPT_RELEASE_FLAG* = 0x1
  CERT_STORE_SET_LOCALIZED_NAME_FLAG* = 0x2
  CERT_STORE_DEFER_CLOSE_UNTIL_LAST_FREE_FLAG* = 0x4
  CERT_STORE_DELETE_FLAG* = 0x10
  CERT_STORE_UNSAFE_PHYSICAL_FLAG* = 0x20
  CERT_STORE_SHARE_STORE_FLAG* = 0x40
  CERT_STORE_SHARE_CONTEXT_FLAG* = 0x80
  CERT_STORE_MANIFOLD_FLAG* = 0x100
  CERT_STORE_ENUM_ARCHIVED_FLAG* = 0x200
  CERT_STORE_UPDATE_KEYID_FLAG* = 0x400
  CERT_STORE_BACKUP_RESTORE_FLAG* = 0x800
  CERT_STORE_READONLY_FLAG* = 0x8000
  CERT_STORE_OPEN_EXISTING_FLAG* = 0x4000
  CERT_STORE_CREATE_NEW_FLAG* = 0x2000
  CERT_STORE_MAXIMUM_ALLOWED_FLAG* = 0x1000
  CERT_SYSTEM_STORE_MASK* = 0xffff0000'i32
  CERT_SYSTEM_STORE_RELOCATE_FLAG* = 0x80000000'i32
  CERT_SYSTEM_STORE_DEFER_READ_FLAG* = 0x20000000
  CERT_SYSTEM_STORE_UNPROTECTED_FLAG* = 0x40000000
  CERT_SYSTEM_STORE_LOCATION_MASK* = 0x00ff0000
  CERT_SYSTEM_STORE_LOCATION_SHIFT* = 16
  CERT_SYSTEM_STORE_CURRENT_USER_ID* = 1
  CERT_SYSTEM_STORE_LOCAL_MACHINE_ID* = 2
  CERT_SYSTEM_STORE_CURRENT_SERVICE_ID* = 4
  CERT_SYSTEM_STORE_SERVICES_ID* = 5
  CERT_SYSTEM_STORE_USERS_ID* = 6
  CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY_ID* = 7
  CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY_ID* = 8
  CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE_ID* = 9
  CERT_SYSTEM_STORE_CURRENT_USER* = CERT_SYSTEM_STORE_CURRENT_USER_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
  CERT_SYSTEM_STORE_LOCAL_MACHINE* = CERT_SYSTEM_STORE_LOCAL_MACHINE_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
  CERT_SYSTEM_STORE_CURRENT_SERVICE* = CERT_SYSTEM_STORE_CURRENT_SERVICE_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
  CERT_SYSTEM_STORE_SERVICES* = CERT_SYSTEM_STORE_SERVICES_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
  CERT_SYSTEM_STORE_USERS* = CERT_SYSTEM_STORE_USERS_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
  CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY* = CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
  CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY* = CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
  CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE* = CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
  CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH* = "Software\\Policies\\Microsoft\\SystemCertificates"
  CERT_EFSBLOB_VALUE_NAME* = "EFSBlob"
  CERT_PROT_ROOT_FLAGS_VALUE_NAME* = "Flags"
  CERT_PROT_ROOT_DISABLE_CURRENT_USER_FLAG* = 0x1
  CERT_PROT_ROOT_INHIBIT_ADD_AT_INIT_FLAG* = 0x2
  CERT_PROT_ROOT_INHIBIT_PURGE_LM_FLAG* = 0x4
  CERT_PROT_ROOT_DISABLE_LM_AUTH_FLAG* = 0x8
  CERT_PROT_ROOT_ONLY_LM_GPT_FLAG* = 0x8
  CERT_PROT_ROOT_DISABLE_NT_AUTH_REQUIRED_FLAG* = 0x10
  CERT_PROT_ROOT_DISABLE_NOT_DEFINED_NAME_CONSTRAINT_FLAG* = 0x20
  CERT_PROT_ROOT_DISABLE_PEER_TRUST* = 0x10000
  CERT_PROT_ROOT_PEER_USAGES_VALUE_NAME* = "PeerUsages"
  CERT_PROT_ROOT_PEER_USAGES_VALUE_NAME_A* = "PeerUsages"
  CERT_LOCAL_MACHINE_SYSTEM_STORE_REGPATH* = "Software\\Microsoft\\SystemCertificates"
  CERT_TRUST_PUB_AUTHENTICODE_FLAGS_VALUE_NAME* = "AuthenticodeFlags"
  CERT_TRUST_PUB_ALLOW_TRUST_MASK* = 0x3
  CERT_TRUST_PUB_ALLOW_END_USER_TRUST* = 0x0
  CERT_TRUST_PUB_ALLOW_MACHINE_ADMIN_TRUST* = 0x1
  CERT_TRUST_PUB_ALLOW_ENTERPRISE_ADMIN_TRUST* = 0x2
  CERT_TRUST_PUB_CHECK_PUBLISHER_REV_FLAG* = 0x100
  CERT_TRUST_PUB_CHECK_TIMESTAMP_REV_FLAG* = 0x200
  CERT_OCM_SUBCOMPONENTS_LOCAL_MACHINE_REGPATH* = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\OC Manager\\Subcomponents"
  CERT_OCM_SUBCOMPONENTS_ROOT_AUTO_UPDATE_VALUE_NAME* = "RootAutoUpdate"
  CERT_DISABLE_ROOT_AUTO_UPDATE_VALUE_NAME* = "DisableRootAutoUpdate"
  CERT_AUTO_UPDATE_ROOT_DIR_URL_VALUE_NAME* = "RootDirUrl"
  CERT_AUTO_UPDATE_LOCAL_MACHINE_REGPATH* = CERT_LOCAL_MACHINE_SYSTEM_STORE_REGPATH & "\\AuthRoot\\AutoUpdate"
  CERT_AUTH_ROOT_AUTO_UPDATE_LOCAL_MACHINE_REGPATH* = CERT_AUTO_UPDATE_LOCAL_MACHINE_REGPATH
  CERT_AUTH_ROOT_AUTO_UPDATE_ROOT_DIR_URL_VALUE_NAME* = CERT_AUTO_UPDATE_ROOT_DIR_URL_VALUE_NAME
  CERT_AUTH_ROOT_AUTO_UPDATE_SYNC_DELTA_TIME_VALUE_NAME* = "SyncDeltaTime"
  CERT_AUTH_ROOT_AUTO_UPDATE_FLAGS_VALUE_NAME* = "Flags"
  CERT_AUTH_ROOT_AUTO_UPDATE_DISABLE_UNTRUSTED_ROOT_LOGGING_FLAG* = 0x1
  CERT_AUTH_ROOT_AUTO_UPDATE_DISABLE_PARTIAL_CHAIN_LOGGING_FLAG* = 0x2
  CERT_AUTO_UPDATE_DISABLE_RANDOM_QUERY_STRING_FLAG* = 0x4
  CERT_AUTH_ROOT_AUTO_UPDATE_LAST_SYNC_TIME_VALUE_NAME* = "LastSyncTime"
  CERT_AUTH_ROOT_AUTO_UPDATE_ENCODED_CTL_VALUE_NAME* = "EncodedCtl"
  CERT_AUTH_ROOT_CTL_FILENAME* = "authroot.stl"
  CERT_AUTH_ROOT_CTL_FILENAME_A* = "authroot.stl"
  CERT_AUTH_ROOT_CAB_FILENAME* = "authrootstl.cab"
  CERT_AUTH_ROOT_SEQ_FILENAME* = "authrootseq.txt"
  CERT_AUTH_ROOT_CERT_EXT* = ".crt"
  CERT_DISALLOWED_CERT_AUTO_UPDATE_SYNC_DELTA_TIME_VALUE_NAME* = "DisallowedCertSyncDeltaTime"
  CERT_DISALLOWED_CERT_AUTO_UPDATE_LAST_SYNC_TIME_VALUE_NAME* = "DisallowedCertLastSyncTime"
  CERT_DISALLOWED_CERT_AUTO_UPDATE_ENCODED_CTL_VALUE_NAME* = "DisallowedCertEncodedCtl"
  CERT_DISALLOWED_CERT_CTL_FILENAME* = "disallowedcert.stl"
  CERT_DISALLOWED_CERT_CTL_FILENAME_A* = "disallowedcert.stl"
  CERT_DISALLOWED_CERT_CAB_FILENAME* = "disallowedcertstl.cab"
  CERT_DISALLOWED_CERT_AUTO_UPDATE_LIST_IDENTIFIER* = "DisallowedCert_AutoUpdate_1"
  CERT_REGISTRY_STORE_REMOTE_FLAG* = 0x10000
  CERT_REGISTRY_STORE_SERIALIZED_FLAG* = 0x20000
  CERT_REGISTRY_STORE_CLIENT_GPT_FLAG* = 0x80000000'i32
  CERT_REGISTRY_STORE_LM_GPT_FLAG* = 0x1000000
  CERT_REGISTRY_STORE_ROAMING_FLAG* = 0x40000
  CERT_REGISTRY_STORE_MY_IE_DIRTY_FLAG* = 0x80000
  CERT_REGISTRY_STORE_EXTERNAL_FLAG* = 0x100000
  CERT_IE_DIRTY_FLAGS_REGPATH* = "Software\\Microsoft\\Cryptography\\IEDirtyFlags"
  CERT_FILE_STORE_COMMIT_ENABLE_FLAG* = 0x10000
  CERT_LDAP_STORE_SIGN_FLAG* = 0x10000
  CERT_LDAP_STORE_AREC_EXCLUSIVE_FLAG* = 0x20000
  CERT_LDAP_STORE_OPENED_FLAG* = 0x40000
  CERT_LDAP_STORE_UNBIND_FLAG* = 0x80000
  CRYPT_OID_OPEN_STORE_PROV_FUNC* = "CertDllOpenStoreProv"
  CERT_STORE_PROV_EXTERNAL_FLAG* = 0x1
  CERT_STORE_PROV_DELETED_FLAG* = 0x2
  CERT_STORE_PROV_NO_PERSIST_FLAG* = 0x4
  CERT_STORE_PROV_SYSTEM_STORE_FLAG* = 0x8
  CERT_STORE_PROV_LM_SYSTEM_STORE_FLAG* = 0x10
  CERT_STORE_PROV_GP_SYSTEM_STORE_FLAG* = 0x20
  CERT_STORE_PROV_SHARED_USER_FLAG* = 0x40
  CERT_STORE_PROV_CLOSE_FUNC* = 0
  CERT_STORE_PROV_READ_CERT_FUNC* = 1
  CERT_STORE_PROV_WRITE_CERT_FUNC* = 2
  CERT_STORE_PROV_DELETE_CERT_FUNC* = 3
  CERT_STORE_PROV_SET_CERT_PROPERTY_FUNC* = 4
  CERT_STORE_PROV_READ_CRL_FUNC* = 5
  CERT_STORE_PROV_WRITE_CRL_FUNC* = 6
  CERT_STORE_PROV_DELETE_CRL_FUNC* = 7
  CERT_STORE_PROV_SET_CRL_PROPERTY_FUNC* = 8
  CERT_STORE_PROV_READ_CTL_FUNC* = 9
  CERT_STORE_PROV_WRITE_CTL_FUNC* = 10
  CERT_STORE_PROV_DELETE_CTL_FUNC* = 11
  CERT_STORE_PROV_SET_CTL_PROPERTY_FUNC* = 12
  CERT_STORE_PROV_CONTROL_FUNC* = 13
  CERT_STORE_PROV_FIND_CERT_FUNC* = 14
  CERT_STORE_PROV_FREE_FIND_CERT_FUNC* = 15
  CERT_STORE_PROV_GET_CERT_PROPERTY_FUNC* = 16
  CERT_STORE_PROV_FIND_CRL_FUNC* = 17
  CERT_STORE_PROV_FREE_FIND_CRL_FUNC* = 18
  CERT_STORE_PROV_GET_CRL_PROPERTY_FUNC* = 19
  CERT_STORE_PROV_FIND_CTL_FUNC* = 20
  CERT_STORE_PROV_FREE_FIND_CTL_FUNC* = 21
  CERT_STORE_PROV_GET_CTL_PROPERTY_FUNC* = 22
  CERT_STORE_PROV_WRITE_ADD_FLAG* = 0x1
  CERT_STORE_SAVE_AS_STORE* = 1
  CERT_STORE_SAVE_AS_PKCS7* = 2
  CERT_STORE_SAVE_AS_PKCS12* = 3
  CERT_STORE_SAVE_TO_FILE* = 1
  CERT_STORE_SAVE_TO_MEMORY* = 2
  CERT_STORE_SAVE_TO_FILENAME_A* = 3
  CERT_STORE_SAVE_TO_FILENAME_W* = 4
  CERT_STORE_SAVE_TO_FILENAME* = CERT_STORE_SAVE_TO_FILENAME_W
  CERT_CLOSE_STORE_FORCE_FLAG* = 0x1
  CERT_CLOSE_STORE_CHECK_FLAG* = 0x2
  CERT_COMPARE_MASK* = 0xffff
  CERT_COMPARE_SHIFT* = 16
  CERT_COMPARE_ANY* = 0
  CERT_COMPARE_SHA1_HASH* = 1
  CERT_COMPARE_NAME* = 2
  CERT_COMPARE_ATTR* = 3
  CERT_COMPARE_MD5_HASH* = 4
  CERT_COMPARE_PROPERTY* = 5
  CERT_COMPARE_PUBLIC_KEY* = 6
  CERT_COMPARE_HASH* = CERT_COMPARE_SHA1_HASH
  CERT_COMPARE_NAME_STR_A* = 7
  CERT_COMPARE_NAME_STR_W* = 8
  CERT_COMPARE_KEY_SPEC* = 9
  CERT_COMPARE_ENHKEY_USAGE* = 10
  CERT_COMPARE_CTL_USAGE* = CERT_COMPARE_ENHKEY_USAGE
  CERT_COMPARE_SUBJECT_CERT* = 11
  CERT_COMPARE_ISSUER_OF* = 12
  CERT_COMPARE_EXISTING* = 13
  CERT_COMPARE_SIGNATURE_HASH* = 14
  CERT_COMPARE_KEY_IDENTIFIER* = 15
  CERT_COMPARE_CERT_ID* = 16
  CERT_COMPARE_CROSS_CERT_DIST_POINTS* = 17
  CERT_COMPARE_PUBKEY_MD5_HASH* = 18
  CERT_COMPARE_SUBJECT_INFO_ACCESS* = 19
  CERT_COMPARE_HASH_STR* = 20
  CERT_COMPARE_HAS_PRIVATE_KEY* = 21
  CERT_FIND_ANY* = CERT_COMPARE_ANY shl CERT_COMPARE_SHIFT
  CERT_FIND_SHA1_HASH* = CERT_COMPARE_SHA1_HASH shl CERT_COMPARE_SHIFT
  CERT_FIND_MD5_HASH* = CERT_COMPARE_MD5_HASH shl CERT_COMPARE_SHIFT
  CERT_FIND_SIGNATURE_HASH* = CERT_COMPARE_SIGNATURE_HASH shl CERT_COMPARE_SHIFT
  CERT_FIND_KEY_IDENTIFIER* = CERT_COMPARE_KEY_IDENTIFIER shl CERT_COMPARE_SHIFT
  CERT_FIND_HASH* = CERT_FIND_SHA1_HASH
  CERT_FIND_PROPERTY* = CERT_COMPARE_PROPERTY shl CERT_COMPARE_SHIFT
  CERT_FIND_PUBLIC_KEY* = CERT_COMPARE_PUBLIC_KEY shl CERT_COMPARE_SHIFT
  CERT_FIND_SUBJECT_NAME* = CERT_COMPARE_NAME shl CERT_COMPARE_SHIFT or CERT_INFO_SUBJECT_FLAG
  CERT_FIND_SUBJECT_ATTR* = CERT_COMPARE_ATTR shl CERT_COMPARE_SHIFT or CERT_INFO_SUBJECT_FLAG
  CERT_FIND_ISSUER_NAME* = CERT_COMPARE_NAME shl CERT_COMPARE_SHIFT or CERT_INFO_ISSUER_FLAG
  CERT_FIND_ISSUER_ATTR* = CERT_COMPARE_ATTR shl CERT_COMPARE_SHIFT or CERT_INFO_ISSUER_FLAG
  CERT_FIND_SUBJECT_STR_A* = CERT_COMPARE_NAME_STR_A shl CERT_COMPARE_SHIFT or CERT_INFO_SUBJECT_FLAG
  CERT_FIND_SUBJECT_STR_W* = CERT_COMPARE_NAME_STR_W shl CERT_COMPARE_SHIFT or CERT_INFO_SUBJECT_FLAG
  CERT_FIND_SUBJECT_STR* = CERT_FIND_SUBJECT_STR_W
  CERT_FIND_ISSUER_STR_A* = CERT_COMPARE_NAME_STR_A shl CERT_COMPARE_SHIFT or CERT_INFO_ISSUER_FLAG
  CERT_FIND_ISSUER_STR_W* = CERT_COMPARE_NAME_STR_W shl CERT_COMPARE_SHIFT or CERT_INFO_ISSUER_FLAG
  CERT_FIND_ISSUER_STR* = CERT_FIND_ISSUER_STR_W
  CERT_FIND_KEY_SPEC* = CERT_COMPARE_KEY_SPEC shl CERT_COMPARE_SHIFT
  CERT_FIND_ENHKEY_USAGE* = CERT_COMPARE_ENHKEY_USAGE shl CERT_COMPARE_SHIFT
  CERT_FIND_CTL_USAGE* = CERT_FIND_ENHKEY_USAGE
  CERT_FIND_SUBJECT_CERT* = CERT_COMPARE_SUBJECT_CERT shl CERT_COMPARE_SHIFT
  CERT_FIND_ISSUER_OF* = CERT_COMPARE_ISSUER_OF shl CERT_COMPARE_SHIFT
  CERT_FIND_EXISTING* = CERT_COMPARE_EXISTING shl CERT_COMPARE_SHIFT
  CERT_FIND_CERT_ID* = CERT_COMPARE_CERT_ID shl CERT_COMPARE_SHIFT
  CERT_FIND_CROSS_CERT_DIST_POINTS* = CERT_COMPARE_CROSS_CERT_DIST_POINTS shl CERT_COMPARE_SHIFT
  CERT_FIND_PUBKEY_MD5_HASH* = CERT_COMPARE_PUBKEY_MD5_HASH shl CERT_COMPARE_SHIFT
  CERT_FIND_SUBJECT_INFO_ACCESS* = CERT_COMPARE_SUBJECT_INFO_ACCESS shl CERT_COMPARE_SHIFT
  CERT_FIND_HASH_STR* = CERT_COMPARE_HASH_STR shl CERT_COMPARE_SHIFT
  CERT_FIND_HAS_PRIVATE_KEY* = CERT_COMPARE_HAS_PRIVATE_KEY shl CERT_COMPARE_SHIFT
  CERT_FIND_OPTIONAL_ENHKEY_USAGE_FLAG* = 0x1
  CERT_FIND_EXT_ONLY_ENHKEY_USAGE_FLAG* = 0x2
  CERT_FIND_PROP_ONLY_ENHKEY_USAGE_FLAG* = 0x4
  CERT_FIND_NO_ENHKEY_USAGE_FLAG* = 0x8
  CERT_FIND_OR_ENHKEY_USAGE_FLAG* = 0x10
  CERT_FIND_VALID_ENHKEY_USAGE_FLAG* = 0x20
  CERT_FIND_OPTIONAL_CTL_USAGE_FLAG* = CERT_FIND_OPTIONAL_ENHKEY_USAGE_FLAG
  CERT_FIND_EXT_ONLY_CTL_USAGE_FLAG* = CERT_FIND_EXT_ONLY_ENHKEY_USAGE_FLAG
  CERT_FIND_PROP_ONLY_CTL_USAGE_FLAG* = CERT_FIND_PROP_ONLY_ENHKEY_USAGE_FLAG
  CERT_FIND_NO_CTL_USAGE_FLAG* = CERT_FIND_NO_ENHKEY_USAGE_FLAG
  CERT_FIND_OR_CTL_USAGE_FLAG* = CERT_FIND_OR_ENHKEY_USAGE_FLAG
  CERT_FIND_VALID_CTL_USAGE_FLAG* = CERT_FIND_VALID_ENHKEY_USAGE_FLAG
  CERT_SET_PROPERTY_INHIBIT_PERSIST_FLAG* = 0x40000000
  CERT_SET_PROPERTY_IGNORE_PERSIST_ERROR_FLAG* = 0x80000000'i32
  CTL_ENTRY_FROM_PROP_CHAIN_FLAG* = 0x1
  CRL_FIND_ANY* = 0
  CRL_FIND_ISSUED_BY* = 1
  CRL_FIND_EXISTING* = 2
  CRL_FIND_ISSUED_FOR* = 3
  CRL_FIND_ISSUED_BY_AKI_FLAG* = 0x1
  CRL_FIND_ISSUED_BY_SIGNATURE_FLAG* = 0x2
  CRL_FIND_ISSUED_BY_DELTA_FLAG* = 0x4
  CRL_FIND_ISSUED_BY_BASE_FLAG* = 0x8
  CRL_FIND_ISSUED_FOR_SET_STRONG_PROPERTIES_FLAG* = 0x10
  CERT_STORE_ADD_NEW* = 1
  CERT_STORE_ADD_USE_EXISTING* = 2
  CERT_STORE_ADD_REPLACE_EXISTING* = 3
  CERT_STORE_ADD_ALWAYS* = 4
  CERT_STORE_ADD_REPLACE_EXISTING_INHERIT_PROPERTIES* = 5
  CERT_STORE_ADD_NEWER* = 6
  CERT_STORE_ADD_NEWER_INHERIT_PROPERTIES* = 7
  CERT_STORE_CERTIFICATE_CONTEXT* = 1
  CERT_STORE_CRL_CONTEXT* = 2
  CERT_STORE_CTL_CONTEXT* = 3
  CERT_STORE_ALL_CONTEXT_FLAG* = not 0
  CERT_STORE_CERTIFICATE_CONTEXT_FLAG* = 1 shl CERT_STORE_CERTIFICATE_CONTEXT
  CERT_STORE_CRL_CONTEXT_FLAG* = 1 shl CERT_STORE_CRL_CONTEXT
  CERT_STORE_CTL_CONTEXT_FLAG* = 1 shl CERT_STORE_CTL_CONTEXT
  CTL_ANY_SUBJECT_TYPE* = 1
  CTL_CERT_SUBJECT_TYPE* = 2
  CTL_FIND_ANY* = 0
  CTL_FIND_SHA1_HASH* = 1
  CTL_FIND_MD5_HASH* = 2
  CTL_FIND_USAGE* = 3
  CTL_FIND_SUBJECT* = 4
  CTL_FIND_EXISTING* = 5
  CTL_FIND_SAME_USAGE_FLAG* = 0x1
  CTL_FIND_NO_LIST_ID_CBDATA* = 0xffffffff'i32
  CERT_STORE_CTRL_RESYNC* = 1
  CERT_STORE_CTRL_NOTIFY_CHANGE* = 2
  CERT_STORE_CTRL_COMMIT* = 3
  CERT_STORE_CTRL_AUTO_RESYNC* = 4
  CERT_STORE_CTRL_CANCEL_NOTIFY* = 5
  CERT_STORE_CTRL_INHIBIT_DUPLICATE_HANDLE_FLAG* = 0x1
  CERT_STORE_CTRL_COMMIT_FORCE_FLAG* = 0x1
  CERT_STORE_CTRL_COMMIT_CLEAR_FLAG* = 0x2
  CERT_STORE_LOCALIZED_NAME_PROP_ID* = 0x1000
  CERT_CREATE_CONTEXT_NOCOPY_FLAG* = 0x1
  CERT_CREATE_CONTEXT_SORTED_FLAG* = 0x2
  CERT_CREATE_CONTEXT_NO_HCRYPTMSG_FLAG* = 0x4
  CERT_CREATE_CONTEXT_NO_ENTRY_FLAG* = 0x8
  CERT_PHYSICAL_STORE_ADD_ENABLE_FLAG* = 0x1
  CERT_PHYSICAL_STORE_OPEN_DISABLE_FLAG* = 0x2
  CERT_PHYSICAL_STORE_REMOTE_OPEN_DISABLE_FLAG* = 0x4
  CERT_PHYSICAL_STORE_INSERT_COMPUTER_NAME_ENABLE_FLAG* = 0x8
  CERT_PHYSICAL_STORE_PREDEFINED_ENUM_FLAG* = 0x1
  CERT_PHYSICAL_STORE_DEFAULT_NAME* = ".Default"
  CERT_PHYSICAL_STORE_GROUP_POLICY_NAME* = ".GroupPolicy"
  CERT_PHYSICAL_STORE_LOCAL_MACHINE_NAME* = ".LocalMachine"
  CERT_PHYSICAL_STORE_DS_USER_CERTIFICATE_NAME* = ".UserCertificate"
  CERT_PHYSICAL_STORE_LOCAL_MACHINE_GROUP_POLICY_NAME* = ".LocalMachineGroupPolicy"
  CERT_PHYSICAL_STORE_ENTERPRISE_NAME* = ".Enterprise"
  CERT_PHYSICAL_STORE_AUTH_ROOT_NAME* = ".AuthRoot"
  CERT_PHYSICAL_STORE_SMART_CARD_NAME* = ".SmartCard"
  CRYPT_OID_OPEN_SYSTEM_STORE_PROV_FUNC* = "CertDllOpenSystemStoreProv"
  CRYPT_OID_REGISTER_SYSTEM_STORE_FUNC* = "CertDllRegisterSystemStore"
  CRYPT_OID_UNREGISTER_SYSTEM_STORE_FUNC* = "CertDllUnregisterSystemStore"
  CRYPT_OID_ENUM_SYSTEM_STORE_FUNC* = "CertDllEnumSystemStore"
  CRYPT_OID_REGISTER_PHYSICAL_STORE_FUNC* = "CertDllRegisterPhysicalStore"
  CRYPT_OID_UNREGISTER_PHYSICAL_STORE_FUNC* = "CertDllUnregisterPhysicalStore"
  CRYPT_OID_ENUM_PHYSICAL_STORE_FUNC* = "CertDllEnumPhysicalStore"
  CRYPT_OID_SYSTEM_STORE_LOCATION_VALUE_NAME* = "SystemStoreLocation"
  CMSG_TRUSTED_SIGNER_FLAG* = 0x1
  CMSG_SIGNER_ONLY_FLAG* = 0x2
  CMSG_USE_SIGNER_INDEX_FLAG* = 0x4
  CMSG_CMS_ENCAPSULATED_CTL_FLAG* = 0x8000
  CMSG_ENCODE_SORTED_CTL_FLAG* = 0x1
  CMSG_ENCODE_HASHED_SUBJECT_IDENTIFIER_FLAG* = 0x2
  CERT_VERIFY_INHIBIT_CTL_UPDATE_FLAG* = 0x1
  CERT_VERIFY_TRUSTED_SIGNERS_FLAG* = 0x2
  CERT_VERIFY_NO_TIME_CHECK_FLAG* = 0x4
  CERT_VERIFY_ALLOW_MORE_USAGE_FLAG* = 0x8
  CERT_VERIFY_UPDATED_CTL_FLAG* = 0x1
  CERT_CONTEXT_REVOCATION_TYPE* = 1
  CERT_VERIFY_REV_CHAIN_FLAG* = 0x1
  CERT_VERIFY_CACHE_ONLY_BASED_REVOCATION* = 0x2
  CERT_VERIFY_REV_ACCUMULATIVE_TIMEOUT_FLAG* = 0x4
  CERT_VERIFY_REV_SERVER_OCSP_FLAG* = 0x8
  CERT_VERIFY_REV_NO_OCSP_FAILOVER_TO_CRL_FLAG* = 0x10
  CERT_UNICODE_IS_RDN_ATTRS_FLAG* = 0x1
  CERT_CASE_INSENSITIVE_IS_RDN_ATTRS_FLAG* = 0x2
  CRYPT_VERIFY_CERT_SIGN_SUBJECT_BLOB* = 1
  CRYPT_VERIFY_CERT_SIGN_SUBJECT_CERT* = 2
  CRYPT_VERIFY_CERT_SIGN_SUBJECT_CRL* = 3
  CRYPT_VERIFY_CERT_SIGN_SUBJECT_OCSP_BASIC_SIGNED_RESPONSE* = 4
  CRYPT_VERIFY_CERT_SIGN_ISSUER_PUBKEY* = 1
  CRYPT_VERIFY_CERT_SIGN_ISSUER_CERT* = 2
  CRYPT_VERIFY_CERT_SIGN_ISSUER_CHAIN* = 3
  CRYPT_VERIFY_CERT_SIGN_ISSUER_NULL* = 4
  CRYPT_VERIFY_CERT_SIGN_DISABLE_MD2_MD4_FLAG* = 0x1
  CRYPT_VERIFY_CERT_SIGN_SET_STRONG_PROPERTIES_FLAG* = 0x2
  CRYPT_VERIFY_CERT_SIGN_RETURN_STRONG_PROPERTIES_FLAG* = 0x4
  CRYPT_OID_EXTRACT_ENCODED_SIGNATURE_PARAMETERS_FUNC* = "CryptDllExtractEncodedSignatureParameters"
  CRYPT_OID_SIGN_AND_ENCODE_HASH_FUNC* = "CryptDllSignAndEncodeHash"
  CRYPT_OID_VERIFY_ENCODED_SIGNATURE_FUNC* = "CryptDllVerifyEncodedSignature"
  CRYPT_DEFAULT_CONTEXT_AUTO_RELEASE_FLAG* = 0x1
  CRYPT_DEFAULT_CONTEXT_PROCESS_FLAG* = 0x2
  CRYPT_DEFAULT_CONTEXT_CERT_SIGN_OID* = 1
  CRYPT_DEFAULT_CONTEXT_MULTI_CERT_SIGN_OID* = 2
  CRYPT_OID_EXPORT_PUBLIC_KEY_INFO_FUNC* = "CryptDllExportPublicKeyInfoEx"
  CRYPT_OID_EXPORT_PUBLIC_KEY_INFO_EX2_FUNC* = "CryptDllExportPublicKeyInfoEx2"
  CRYPT_OID_EXPORT_PUBLIC_KEY_INFO_FROM_BCRYPT_HANDLE_FUNC* = "CryptDllExportPublicKeyInfoFromBCryptKeyHandle"
  CRYPT_OID_IMPORT_PUBLIC_KEY_INFO_FUNC* = "CryptDllImportPublicKeyInfoEx"
  CRYPT_OID_IMPORT_PRIVATE_KEY_INFO_FUNC* = "CryptDllImportPrivateKeyInfoEx"
  CRYPT_OID_EXPORT_PRIVATE_KEY_INFO_FUNC* = "CryptDllExportPrivateKeyInfoEx"
  CRYPT_ACQUIRE_CACHE_FLAG* = 0x1
  CRYPT_ACQUIRE_USE_PROV_INFO_FLAG* = 0x2
  CRYPT_ACQUIRE_COMPARE_KEY_FLAG* = 0x4
  CRYPT_ACQUIRE_NO_HEALING* = 0x8
  CRYPT_ACQUIRE_SILENT_FLAG* = 0x40
  CRYPT_ACQUIRE_WINDOW_HANDLE_FLAG* = 0x80
  CRYPT_ACQUIRE_NCRYPT_KEY_FLAGS_MASK* = 0x70000
  CRYPT_ACQUIRE_ALLOW_NCRYPT_KEY_FLAG* = 0x10000
  CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG* = 0x20000
  CRYPT_ACQUIRE_ONLY_NCRYPT_KEY_FLAG* = 0x40000
  CRYPT_FIND_USER_KEYSET_FLAG* = 0x1
  CRYPT_FIND_MACHINE_KEYSET_FLAG* = 0x2
  CRYPT_FIND_SILENT_KEYSET_FLAG* = 0x40
  CRYPT_OID_IMPORT_PUBLIC_KEY_INFO_EX2_FUNC* = "CryptDllImportPublicKeyInfoEx2"
  CERT_SIMPLE_NAME_STR* = 1
  CERT_OID_NAME_STR* = 2
  CERT_X500_NAME_STR* = 3
  CERT_XML_NAME_STR* = 4
  CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG* = 0x10000
  CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG* = 0x20000
  CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG* = 0x40000
  CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG* = 0x80000
  CERT_NAME_STR_FORWARD_FLAG* = 0x1000000
  CERT_NAME_STR_REVERSE_FLAG* = 0x2000000
  CERT_NAME_STR_COMMA_FLAG* = 0x4000000
  CERT_NAME_STR_CRLF_FLAG* = 0x8000000
  CERT_NAME_STR_NO_QUOTING_FLAG* = 0x10000000
  CERT_NAME_STR_NO_PLUS_FLAG* = 0x20000000
  CERT_NAME_STR_SEMICOLON_FLAG* = 0x40000000
  CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG* = 0x100000
  CERT_NAME_STR_ENABLE_PUNYCODE_FLAG* = 0x200000
  CERT_NAME_EMAIL_TYPE* = 1
  CERT_NAME_RDN_TYPE* = 2
  CERT_NAME_ATTR_TYPE* = 3
  CERT_NAME_SIMPLE_DISPLAY_TYPE* = 4
  CERT_NAME_FRIENDLY_DISPLAY_TYPE* = 5
  CERT_NAME_DNS_TYPE* = 6
  CERT_NAME_URL_TYPE* = 7
  CERT_NAME_UPN_TYPE* = 8
  CERT_NAME_ISSUER_FLAG* = 0x1
  CERT_NAME_DISABLE_IE4_UTF8_FLAG* = 0x10000
  CERT_NAME_SEARCH_ALL_NAMES_FLAG* = 0x2
  CRYPT_MESSAGE_BARE_CONTENT_OUT_FLAG* = 0x1
  CRYPT_MESSAGE_ENCAPSULATED_CONTENT_OUT_FLAG* = 0x2
  CRYPT_MESSAGE_KEYID_SIGNER_FLAG* = 0x4
  CRYPT_MESSAGE_SILENT_KEYSET_FLAG* = 0x40
  CRYPT_MESSAGE_KEYID_RECIPIENT_FLAG* = 0x4
  CERT_QUERY_OBJECT_FILE* = 0x1
  CERT_QUERY_OBJECT_BLOB* = 0x2
  CERT_QUERY_CONTENT_CERT* = 1
  CERT_QUERY_CONTENT_CTL* = 2
  CERT_QUERY_CONTENT_CRL* = 3
  CERT_QUERY_CONTENT_SERIALIZED_STORE* = 4
  CERT_QUERY_CONTENT_SERIALIZED_CERT* = 5
  CERT_QUERY_CONTENT_SERIALIZED_CTL* = 6
  CERT_QUERY_CONTENT_SERIALIZED_CRL* = 7
  CERT_QUERY_CONTENT_PKCS7_SIGNED* = 8
  CERT_QUERY_CONTENT_PKCS7_UNSIGNED* = 9
  CERT_QUERY_CONTENT_PKCS7_SIGNED_EMBED* = 10
  CERT_QUERY_CONTENT_PKCS10* = 11
  CERT_QUERY_CONTENT_PFX* = 12
  CERT_QUERY_CONTENT_CERT_PAIR* = 13
  CERT_QUERY_CONTENT_PFX_AND_LOAD* = 14
  CERT_QUERY_CONTENT_FLAG_CERT* = 1 shl CERT_QUERY_CONTENT_CERT
  CERT_QUERY_CONTENT_FLAG_CTL* = 1 shl CERT_QUERY_CONTENT_CTL
  CERT_QUERY_CONTENT_FLAG_CRL* = 1 shl CERT_QUERY_CONTENT_CRL
  CERT_QUERY_CONTENT_FLAG_SERIALIZED_STORE* = 1 shl CERT_QUERY_CONTENT_SERIALIZED_STORE
  CERT_QUERY_CONTENT_FLAG_SERIALIZED_CERT* = 1 shl CERT_QUERY_CONTENT_SERIALIZED_CERT
  CERT_QUERY_CONTENT_FLAG_SERIALIZED_CTL* = 1 shl CERT_QUERY_CONTENT_SERIALIZED_CTL
  CERT_QUERY_CONTENT_FLAG_SERIALIZED_CRL* = 1 shl CERT_QUERY_CONTENT_SERIALIZED_CRL
  CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED* = 1 shl CERT_QUERY_CONTENT_PKCS7_SIGNED
  CERT_QUERY_CONTENT_FLAG_PKCS7_UNSIGNED* = 1 shl CERT_QUERY_CONTENT_PKCS7_UNSIGNED
  CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED_EMBED* = 1 shl CERT_QUERY_CONTENT_PKCS7_SIGNED_EMBED
  CERT_QUERY_CONTENT_FLAG_PKCS10* = 1 shl CERT_QUERY_CONTENT_PKCS10
  CERT_QUERY_CONTENT_FLAG_PFX* = 1 shl CERT_QUERY_CONTENT_PFX
  CERT_QUERY_CONTENT_FLAG_CERT_PAIR* = 1 shl CERT_QUERY_CONTENT_CERT_PAIR
  CERT_QUERY_CONTENT_FLAG_PFX_AND_LOAD* = 1 shl CERT_QUERY_CONTENT_PFX_AND_LOAD
  CERT_QUERY_CONTENT_FLAG_ALL* = CERT_QUERY_CONTENT_FLAG_CERT or CERT_QUERY_CONTENT_FLAG_CTL or CERT_QUERY_CONTENT_FLAG_CRL or CERT_QUERY_CONTENT_FLAG_SERIALIZED_STORE or CERT_QUERY_CONTENT_FLAG_SERIALIZED_CERT or CERT_QUERY_CONTENT_FLAG_SERIALIZED_CTL or CERT_QUERY_CONTENT_FLAG_SERIALIZED_CRL or CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED or CERT_QUERY_CONTENT_FLAG_PKCS7_UNSIGNED or CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED_EMBED or CERT_QUERY_CONTENT_FLAG_PKCS10 or CERT_QUERY_CONTENT_FLAG_PFX or CERT_QUERY_CONTENT_FLAG_CERT_PAIR
  CERT_QUERY_CONTENT_FLAG_ALL_ISSUER_CERT* = CERT_QUERY_CONTENT_FLAG_CERT or CERT_QUERY_CONTENT_FLAG_SERIALIZED_STORE or CERT_QUERY_CONTENT_FLAG_SERIALIZED_CERT or CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED or CERT_QUERY_CONTENT_FLAG_PKCS7_UNSIGNED
  CERT_QUERY_FORMAT_BINARY* = 1
  CERT_QUERY_FORMAT_BASE64_ENCODED* = 2
  CERT_QUERY_FORMAT_ASN_ASCII_HEX_ENCODED* = 3
  CERT_QUERY_FORMAT_FLAG_BINARY* = 1 shl CERT_QUERY_FORMAT_BINARY
  CERT_QUERY_FORMAT_FLAG_BASE64_ENCODED* = 1 shl CERT_QUERY_FORMAT_BASE64_ENCODED
  CERT_QUERY_FORMAT_FLAG_ASN_ASCII_HEX_ENCODED* = 1 shl CERT_QUERY_FORMAT_ASN_ASCII_HEX_ENCODED
  CERT_QUERY_FORMAT_FLAG_ALL* = CERT_QUERY_FORMAT_FLAG_BINARY or CERT_QUERY_FORMAT_FLAG_BASE64_ENCODED or CERT_QUERY_FORMAT_FLAG_ASN_ASCII_HEX_ENCODED
  CREDENTIAL_OID_PASSWORD_CREDENTIALS_A* = cast[LPCSTR](1)
  CREDENTIAL_OID_PASSWORD_CREDENTIALS_W* = cast[LPCSTR](2)
  SCHEME_OID_RETRIEVE_ENCODED_OBJECT_FUNC* = "SchemeDllRetrieveEncodedObject"
  SCHEME_OID_RETRIEVE_ENCODED_OBJECTW_FUNC* = "SchemeDllRetrieveEncodedObjectW"
  CONTEXT_OID_CREATE_OBJECT_CONTEXT_FUNC* = "ContextDllCreateObjectContext"
  CONTEXT_OID_CERTIFICATE* = cast[LPCSTR](1)
  CONTEXT_OID_CRL* = cast[LPCSTR](2)
  CONTEXT_OID_CTL* = cast[LPCSTR](3)
  CONTEXT_OID_PKCS7* = cast[LPCSTR](4)
  CONTEXT_OID_CAPI2_ANY* = cast[LPCSTR](5)
  CONTEXT_OID_OCSP_RESP* = cast[LPCSTR](6)
  CRYPT_RETRIEVE_MULTIPLE_OBJECTS* = 0x1
  CRYPT_CACHE_ONLY_RETRIEVAL* = 0x2
  CRYPT_WIRE_ONLY_RETRIEVAL* = 0x4
  CRYPT_DONT_CACHE_RESULT* = 0x8
  CRYPT_ASYNC_RETRIEVAL* = 0x10
  CRYPT_VERIFY_CONTEXT_SIGNATURE* = 0x20
  CRYPT_VERIFY_DATA_HASH* = 0x40
  CRYPT_KEEP_TIME_VALID* = 0x80
  CRYPT_DONT_VERIFY_SIGNATURE* = 0x100
  CRYPT_DONT_CHECK_TIME_VALIDITY* = 0x200
  CRYPT_CHECK_FRESHNESS_TIME_VALIDITY* = 0x400
  CRYPT_ACCUMULATIVE_TIMEOUT* = 0x800
  CRYPT_STICKY_CACHE_RETRIEVAL* = 0x1000
  CRYPT_LDAP_SCOPE_BASE_ONLY_RETRIEVAL* = 0x2000
  CRYPT_OFFLINE_CHECK_RETRIEVAL* = 0x4000
  CRYPT_LDAP_INSERT_ENTRY_ATTRIBUTE* = 0x8000
  CRYPT_LDAP_SIGN_RETRIEVAL* = 0x10000
  CRYPT_NO_AUTH_RETRIEVAL* = 0x20000
  CRYPT_LDAP_AREC_EXCLUSIVE_RETRIEVAL* = 0x40000
  CRYPT_AIA_RETRIEVAL* = 0x80000
  CRYPT_HTTP_POST_RETRIEVAL* = 0x100000
  CRYPT_PROXY_CACHE_RETRIEVAL* = 0x200000
  CRYPT_NOT_MODIFIED_RETRIEVAL* = 0x400000
  CRYPT_ENABLE_SSL_REVOCATION_RETRIEVAL* = 0x800000
  CRYPT_OCSP_ONLY_RETRIEVAL* = 0x1000000
  CRYPT_NO_OCSP_FAILOVER_TO_CRL_RETRIEVAL* = 0x2000000
  CRYPT_RANDOM_QUERY_STRING_RETRIEVAL* = 0x4000000
  CRYPTNET_URL_CACHE_PRE_FETCH_NONE* = 0
  CRYPTNET_URL_CACHE_PRE_FETCH_BLOB* = 1
  CRYPTNET_URL_CACHE_PRE_FETCH_CRL* = 2
  CRYPTNET_URL_CACHE_PRE_FETCH_OCSP* = 3
  CRYPTNET_URL_CACHE_PRE_FETCH_AUTOROOT_CAB* = 5
  CRYPTNET_URL_CACHE_PRE_FETCH_DISALLOWED_CERT_CAB* = 6
  CRYPTNET_URL_CACHE_DEFAULT_FLUSH* = 0
  CRYPTNET_URL_CACHE_DISABLE_FLUSH* = 0xffffffff'i32
  CRYPTNET_URL_CACHE_RESPONSE_NONE* = 0
  CRYPTNET_URL_CACHE_RESPONSE_HTTP* = 1
  CRYPTNET_URL_CACHE_RESPONSE_VALIDATED* = 0x8000
  CRYPT_PARAM_ASYNC_RETRIEVAL_COMPLETION* = cast[LPCSTR](1)
  CRYPT_PARAM_CANCEL_ASYNC_RETRIEVAL* = cast[LPCSTR](2)
  CRYPT_GET_URL_FROM_PROPERTY* = 0x1
  CRYPT_GET_URL_FROM_EXTENSION* = 0x2
  CRYPT_GET_URL_FROM_UNAUTH_ATTRIBUTE* = 0x4
  CRYPT_GET_URL_FROM_AUTH_ATTRIBUTE* = 0x8
  URL_OID_GET_OBJECT_URL_FUNC* = "UrlDllGetObjectUrl"
  URL_OID_CERTIFICATE_ISSUER* = cast[LPCSTR](1)
  URL_OID_CERTIFICATE_CRL_DIST_POINT* = cast[LPCSTR](2)
  URL_OID_CTL_ISSUER* = cast[LPCSTR](3)
  URL_OID_CTL_NEXT_UPDATE* = cast[LPCSTR](4)
  URL_OID_CRL_ISSUER* = cast[LPCSTR](5)
  URL_OID_CERTIFICATE_FRESHEST_CRL* = cast[LPCSTR](6)
  URL_OID_CRL_FRESHEST_CRL* = cast[LPCSTR](7)
  URL_OID_CROSS_CERT_DIST_POINT* = cast[LPCSTR](8)
  URL_OID_CERTIFICATE_OCSP* = cast[LPCSTR](9)
  URL_OID_CERTIFICATE_OCSP_AND_CRL_DIST_POINT* = cast[LPCSTR](10)
  URL_OID_CERTIFICATE_CRL_DIST_POINT_AND_OCSP* = cast[LPCSTR](11)
  URL_OID_CROSS_CERT_SUBJECT_INFO_ACCESS* = cast[LPCSTR](12)
  URL_OID_CERTIFICATE_ONLY_OCSP* = cast[LPCSTR](13)
  TIME_VALID_OID_GET_OBJECT_FUNC* = "TimeValidDllGetObject"
  CERT_CHAIN_CONFIG_REGPATH* = "Software\\Microsoft\\Cryptography\\OID\\EncodingType 0\\CertDllCreateCertificateChainEngine\\Config"
  TIME_VALID_OID_GET_CTL* = cast[LPCSTR](1)
  TIME_VALID_OID_GET_CRL* = cast[LPCSTR](2)
  TIME_VALID_OID_GET_CRL_FROM_CERT* = cast[LPCSTR](3)
  TIME_VALID_OID_GET_FRESHEST_CRL_FROM_CERT* = cast[LPCSTR](4)
  TIME_VALID_OID_GET_FRESHEST_CRL_FROM_CRL* = cast[LPCSTR](5)
  TIME_VALID_OID_FLUSH_OBJECT_FUNC* = "TimeValidDllFlushObject"
  TIME_VALID_OID_FLUSH_CTL* = cast[LPCSTR](1)
  TIME_VALID_OID_FLUSH_CRL* = cast[LPCSTR](2)
  TIME_VALID_OID_FLUSH_CRL_FROM_CERT* = cast[LPCSTR](3)
  TIME_VALID_OID_FLUSH_FRESHEST_CRL_FROM_CERT* = cast[LPCSTR](4)
  TIME_VALID_OID_FLUSH_FRESHEST_CRL_FROM_CRL* = cast[LPCSTR](5)
  CERT_CREATE_SELFSIGN_NO_SIGN* = 1
  CERT_CREATE_SELFSIGN_NO_KEY_INFO* = 2
  CRYPT_KEYID_DELETE_FLAG* = 0x10
  CRYPT_KEYID_MACHINE_FLAG* = 0x20
  CRYPT_KEYID_SET_NEW_FLAG* = 0x2000
  CRYPT_KEYID_ALLOC_FLAG* = 0x8000
  CERT_CHAIN_MAX_URL_RETRIEVAL_BYTE_COUNT_VALUE_NAME* = "MaxUrlRetrievalByteCount"
  CERT_CHAIN_MAX_URL_RETRIEVAL_BYTE_COUNT_DEFAULT* = 100*1024*1024
  CERT_CHAIN_CACHE_RESYNC_FILETIME_VALUE_NAME* = "ChainCacheResyncFiletime"
  CERT_CHAIN_DISABLE_MANDATORY_BASIC_CONSTRAINTS_VALUE_NAME* = "DisableMandatoryBasicConstraints"
  CERT_CHAIN_DISABLE_CA_NAME_CONSTRAINTS_VALUE_NAME* = "DisableCANameConstraints"
  CERT_CHAIN_DISABLE_UNSUPPORTED_CRITICAL_EXTENSIONS_VALUE_NAME* = "DisableUnsupportedCriticalExtensions"
  CERT_CHAIN_MAX_AIA_URL_COUNT_IN_CERT_VALUE_NAME* = "MaxAIAUrlCountInCert"
  CERT_CHAIN_MAX_AIA_URL_COUNT_IN_CERT_DEFAULT* = 5
  CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_COUNT_PER_CHAIN_VALUE_NAME* = "MaxAIAUrlRetrievalCountPerChain"
  CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_COUNT_PER_CHAIN_DEFAULT* = 3
  CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_BYTE_COUNT_VALUE_NAME* = "MaxAIAUrlRetrievalByteCount"
  CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_BYTE_COUNT_DEFAULT* = 100000
  CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_CERT_COUNT_VALUE_NAME* = "MaxAIAUrlRetrievalCertCount"
  CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_CERT_COUNT_DEFAULT* = 10
  CERT_CHAIN_OCSP_VALIDITY_SECONDS_VALUE_NAME* = "OcspValiditySeconds"
  CERT_CHAIN_OCSP_VALIDITY_SECONDS_DEFAULT* = 12*60*60
  CERT_CHAIN_ENABLE_WEAK_SIGNATURE_FLAGS_VALUE_NAME* = "EnableWeakSignatureFlags"
  CERT_CHAIN_ENABLE_MD2_MD4_FLAG* = 0x1
  CERT_CHAIN_ENABLE_WEAK_RSA_ROOT_FLAG* = 0x2
  CERT_CHAIN_ENABLE_WEAK_LOGGING_FLAG* = 0x4
  CERT_CHAIN_ENABLE_ONLY_WEAK_LOGGING_FLAG* = 0x8
  CERT_CHAIN_MIN_RSA_PUB_KEY_BIT_LENGTH_VALUE_NAME* = "MinRsaPubKeyBitLength"
  CERT_CHAIN_MIN_RSA_PUB_KEY_BIT_LENGTH_DEFAULT* = 1023
  CERT_CHAIN_MIN_RSA_PUB_KEY_BIT_LENGTH_DISABLE* = 0xffffffff'i32
  CERT_CHAIN_WEAK_RSA_PUB_KEY_TIME_VALUE_NAME* = "WeakRsaPubKeyTime"
  CERT_CHAIN_WEAK_RSA_PUB_KEY_TIME_DEFAULT* = 0x01ca8a755c6e0000
  CERT_CHAIN_WEAK_SIGNATURE_LOG_DIR_VALUE_NAME* = "WeakSignatureLogDir"
  CERT_SRV_OCSP_RESP_MIN_VALIDITY_SECONDS_VALUE_NAME* = "SrvOcspRespMinValiditySeconds"
  CERT_SRV_OCSP_RESP_MIN_VALIDITY_SECONDS_DEFAULT* = 10*60
  CERT_SRV_OCSP_RESP_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_VALUE_NAME* = "SrvOcspRespUrlRetrievalTimeoutMilliseconds"
  CERT_SRV_OCSP_RESP_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_DEFAULT* = 15*1000
  CERT_SRV_OCSP_RESP_MAX_BEFORE_NEXT_UPDATE_SECONDS_VALUE_NAME* = "SrvOcspRespMaxBeforeNextUpdateSeconds"
  CERT_SRV_OCSP_RESP_MAX_BEFORE_NEXT_UPDATE_SECONDS_DEFAULT* = 4*60*60
  CERT_SRV_OCSP_RESP_MIN_BEFORE_NEXT_UPDATE_SECONDS_VALUE_NAME* = "SrvOcspRespMinBeforeNextUpdateSeconds"
  CERT_SRV_OCSP_RESP_MIN_BEFORE_NEXT_UPDATE_SECONDS_DEFAULT* = 2*60
  CERT_SRV_OCSP_RESP_MIN_AFTER_NEXT_UPDATE_SECONDS_VALUE_NAME* = "SrvOcspRespMinAfterNextUpdateSeconds"
  CERT_SRV_OCSP_RESP_MIN_AFTER_NEXT_UPDATE_SECONDS_DEFAULT* = 1*60
  CRYPTNET_MAX_CACHED_OCSP_PER_CRL_COUNT_VALUE_NAME* = "CryptnetMaxCachedOcspPerCrlCount"
  CRYPTNET_MAX_CACHED_OCSP_PER_CRL_COUNT_DEFAULT* = 500
  CRYPTNET_OCSP_AFTER_CRL_DISABLE* = 0xffffffff'i32
  CRYPTNET_URL_CACHE_DEFAULT_FLUSH_EXEMPT_SECONDS_VALUE_NAME* = "CryptnetDefaultFlushExemptSeconds"
  CRYPTNET_URL_CACHE_DEFAULT_FLUSH_EXEMPT_SECONDS_DEFAULT* = 28*24*60*60
  CRYPTNET_PRE_FETCH_MIN_MAX_AGE_SECONDS_VALUE_NAME* = "CryptnetPreFetchMinMaxAgeSeconds"
  CRYPTNET_PRE_FETCH_MIN_MAX_AGE_SECONDS_DEFAULT* = 1*60*60
  CRYPTNET_PRE_FETCH_MAX_MAX_AGE_SECONDS_VALUE_NAME* = "CryptnetPreFetchMaxMaxAgeSeconds"
  CRYPTNET_PRE_FETCH_MAX_MAX_AGE_SECONDS_DEFAULT* = 14*24*60*60
  CRYPTNET_PRE_FETCH_MIN_OCSP_VALIDITY_PERIOD_SECONDS_VALUE_NAME* = "CryptnetPreFetchMinOcspValidityPeriodSeconds"
  CRYPTNET_PRE_FETCH_MIN_OCSP_VALIDITY_PERIOD_SECONDS_DEFAULT* = 14*24*60*60
  CRYPTNET_PRE_FETCH_AFTER_PUBLISH_PRE_FETCH_DIVISOR_VALUE_NAME* = "CryptnetPreFetchAfterPublishPreFetchDivisor"
  CRYPTNET_PRE_FETCH_AFTER_PUBLISH_PRE_FETCH_DIVISOR_DEFAULT* = 10
  CRYPTNET_PRE_FETCH_BEFORE_NEXT_UPDATE_PRE_FETCH_DIVISOR_VALUE_NAME* = "CryptnetPreFetchBeforeNextUpdatePreFetchDivisor"
  CRYPTNET_PRE_FETCH_BEFORE_NEXT_UPDATE_PRE_FETCH_DIVISOR_DEFAULT* = 20
  CRYPTNET_PRE_FETCH_MIN_BEFORE_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_VALUE_NAME* = "CryptnetPreFetchMinBeforeNextUpdatePreFetchSeconds"
  CRYPTNET_PRE_FETCH_MIN_BEFORE_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_DEFAULT* = 1*60*60
  CRYPTNET_PRE_FETCH_VALIDITY_PERIOD_AFTER_NEXT_UPDATE_PRE_FETCH_DIVISOR_VALUE_NAME* = "CryptnetPreFetchValidityPeriodAfterNextUpdatePreFetchDivisor"
  CRYPTNET_PRE_FETCH_VALIDITY_PERIOD_AFTER_NEXT_UPDATE_PRE_FETCH_DIVISOR_DEFAULT* = 10
  CRYPTNET_PRE_FETCH_MAX_AFTER_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_VALUE_NAME* = "CryptnetPreFetchMaxAfterNextUpdatePreFetchPeriodSeconds"
  CRYPTNET_PRE_FETCH_MAX_AFTER_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_DEFAULT* = 4*60*60
  CRYPTNET_PRE_FETCH_MIN_AFTER_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_VALUE_NAME* = "CryptnetPreFetchMinAfterNextUpdatePreFetchPeriodSeconds"
  CRYPTNET_PRE_FETCH_MIN_AFTER_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_DEFAULT* = 30*60
  CRYPTNET_PRE_FETCH_AFTER_CURRENT_TIME_PRE_FETCH_PERIOD_SECONDS_VALUE_NAME* = "CryptnetPreFetchAfterCurrentTimePreFetchPeriodSeconds"
  CRYPTNET_PRE_FETCH_AFTER_CURRENT_TIME_PRE_FETCH_PERIOD_SECONDS_DEFAULT* = 30*60
  CRYPTNET_PRE_FETCH_TRIGGER_PERIOD_SECONDS_VALUE_NAME* = "CryptnetPreFetchTriggerPeriodSeconds"
  CRYPTNET_PRE_FETCH_TRIGGER_PERIOD_SECONDS_DEFAULT* = 10*60
  CRYPTNET_PRE_FETCH_TRIGGER_DISABLE* = 0xffffffff'i32
  CRYPTNET_PRE_FETCH_SCAN_AFTER_TRIGGER_DELAY_SECONDS_VALUE_NAME* = "CryptnetPreFetchScanAfterTriggerDelaySeconds"
  CRYPTNET_PRE_FETCH_SCAN_AFTER_TRIGGER_DELAY_SECONDS_DEFAULT* = 30
  CRYPTNET_PRE_FETCH_RETRIEVAL_TIMEOUT_SECONDS_VALUE_NAME* = "CryptnetPreFetchRetrievalTimeoutSeconds"
  CRYPTNET_PRE_FETCH_RETRIEVAL_TIMEOUT_SECONDS_DEFAULT* = 5*60
  CERT_CHAIN_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_VALUE_NAME* = "ChainUrlRetrievalTimeoutMilliseconds"
  CERT_CHAIN_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_DEFAULT* = 15*1000
  CERT_CHAIN_REV_ACCUMULATIVE_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_VALUE_NAME* = "ChainRevAccumulativeUrlRetrievalTimeoutMilliseconds"
  CERT_CHAIN_REV_ACCUMULATIVE_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_DEFAULT* = 20*1000
  CERT_RETR_BEHAVIOR_INET_AUTH_VALUE_NAME* = "EnableInetUnknownAuth"
  CERT_RETR_BEHAVIOR_INET_STATUS_VALUE_NAME* = "EnableInetLocal"
  CERT_RETR_BEHAVIOR_FILE_VALUE_NAME* = "AllowFileUrlScheme"
  CERT_RETR_BEHAVIOR_LDAP_VALUE_NAME* = "DisableLDAPSignAndEncrypt"
  CRYPTNET_CACHED_OCSP_SWITCH_TO_CRL_COUNT_VALUE_NAME* = "CryptnetCachedOcspSwitchToCrlCount"
  CRYPTNET_CACHED_OCSP_SWITCH_TO_CRL_COUNT_DEFAULT* = 50
  CRYPTNET_CRL_BEFORE_OCSP_ENABLE* = 0xffffffff'i32
  CERT_CHAIN_DISABLE_AIA_URL_RETRIEVAL_VALUE_NAME* = "DisableAIAUrlRetrieval"
  CERT_CHAIN_OPTIONS_VALUE_NAME* = "Options"
  CERT_CHAIN_OPTION_DISABLE_AIA_URL_RETRIEVAL* = 0x2
  CERT_CHAIN_OPTION_ENABLE_SIA_URL_RETRIEVAL* = 0x4
  CERT_CHAIN_CROSS_CERT_DOWNLOAD_INTERVAL_HOURS_VALUE_NAME* = "CrossCertDownloadIntervalHours"
  CERT_CHAIN_CROSS_CERT_DOWNLOAD_INTERVAL_HOURS_DEFAULT* = 24*7
  CERT_CHAIN_CRL_VALIDITY_EXT_PERIOD_HOURS_VALUE_NAME* = "CRLValidityExtensionPeriod"
  CERT_CHAIN_CRL_VALIDITY_EXT_PERIOD_HOURS_DEFAULT* = 12
  HCCE_LOCAL_MACHINE* = HCERTCHAINENGINE 0x1
  CERT_CHAIN_CACHE_END_CERT* = 0x1
  CERT_CHAIN_THREAD_STORE_SYNC* = 0x2
  CERT_CHAIN_CACHE_ONLY_URL_RETRIEVAL* = 0x4
  CERT_CHAIN_USE_LOCAL_MACHINE_STORE* = 0x8
  CERT_CHAIN_ENABLE_CACHE_AUTO_UPDATE* = 0x10
  CERT_CHAIN_ENABLE_SHARE_STORE* = 0x20
  CERT_CHAIN_EXCLUSIVE_ENABLE_CA_FLAG* = 0x1
  CERT_TRUST_NO_ERROR* = 0x0
  CERT_TRUST_IS_NOT_TIME_VALID* = 0x1
  CERT_TRUST_IS_NOT_TIME_NESTED* = 0x2
  CERT_TRUST_IS_REVOKED* = 0x4
  CERT_TRUST_IS_NOT_SIGNATURE_VALID* = 0x8
  CERT_TRUST_IS_NOT_VALID_FOR_USAGE* = 0x10
  CERT_TRUST_IS_UNTRUSTED_ROOT* = 0x20
  CERT_TRUST_REVOCATION_STATUS_UNKNOWN* = 0x40
  CERT_TRUST_IS_CYCLIC* = 0x80
  CERT_TRUST_INVALID_EXTENSION* = 0x100
  CERT_TRUST_INVALID_POLICY_CONSTRAINTS* = 0x200
  CERT_TRUST_INVALID_BASIC_CONSTRAINTS* = 0x400
  CERT_TRUST_INVALID_NAME_CONSTRAINTS* = 0x800
  CERT_TRUST_HAS_NOT_SUPPORTED_NAME_CONSTRAINT* = 0x1000
  CERT_TRUST_HAS_NOT_DEFINED_NAME_CONSTRAINT* = 0x2000
  CERT_TRUST_HAS_NOT_PERMITTED_NAME_CONSTRAINT* = 0x4000
  CERT_TRUST_HAS_EXCLUDED_NAME_CONSTRAINT* = 0x8000
  CERT_TRUST_IS_PARTIAL_CHAIN* = 0x10000
  CERT_TRUST_CTL_IS_NOT_TIME_VALID* = 0x20000
  CERT_TRUST_CTL_IS_NOT_SIGNATURE_VALID* = 0x40000
  CERT_TRUST_CTL_IS_NOT_VALID_FOR_USAGE* = 0x80000
  CERT_TRUST_IS_OFFLINE_REVOCATION* = 0x1000000
  CERT_TRUST_NO_ISSUANCE_CHAIN_POLICY* = 0x2000000
  CERT_TRUST_IS_EXPLICIT_DISTRUST* = 0x4000000
  CERT_TRUST_HAS_NOT_SUPPORTED_CRITICAL_EXT* = 0x8000000
  CERT_TRUST_HAS_WEAK_SIGNATURE* = 0x100000
  CERT_TRUST_HAS_EXACT_MATCH_ISSUER* = 0x1
  CERT_TRUST_HAS_KEY_MATCH_ISSUER* = 0x2
  CERT_TRUST_HAS_NAME_MATCH_ISSUER* = 0x4
  CERT_TRUST_IS_SELF_SIGNED* = 0x8
  CERT_TRUST_AUTO_UPDATE_CA_REVOCATION* = 0x10
  CERT_TRUST_AUTO_UPDATE_END_REVOCATION* = 0x20
  CERT_TRUST_NO_OCSP_FAILOVER_TO_CRL* = 0x40
  CERT_TRUST_HAS_PREFERRED_ISSUER* = 0x100
  CERT_TRUST_HAS_ISSUANCE_CHAIN_POLICY* = 0x200
  CERT_TRUST_HAS_VALID_NAME_CONSTRAINTS* = 0x400
  CERT_TRUST_IS_PEER_TRUSTED* = 0x800
  CERT_TRUST_HAS_CRL_VALIDITY_EXTENDED* = 0x1000
  CERT_TRUST_IS_FROM_EXCLUSIVE_TRUST_STORE* = 0x2000
  CERT_TRUST_IS_CA_TRUSTED* = 0x4000
  CERT_TRUST_IS_COMPLEX_CHAIN* = 0x10000
  USAGE_MATCH_TYPE_AND* = 0x0
  USAGE_MATCH_TYPE_OR* = 0x1
  CERT_CHAIN_STRONG_SIGN_DISABLE_END_CHECK_FLAG* = 0x1
  CERT_CHAIN_DISABLE_PASS1_QUALITY_FILTERING* = 0x40
  CERT_CHAIN_RETURN_LOWER_QUALITY_CONTEXTS* = 0x80
  CERT_CHAIN_DISABLE_AUTH_ROOT_AUTO_UPDATE* = 0x100
  CERT_CHAIN_TIMESTAMP_TIME* = 0x200
  CERT_CHAIN_ENABLE_PEER_TRUST* = 0x400
  CERT_CHAIN_DISABLE_MY_PEER_TRUST* = 0x800
  CERT_CHAIN_DISABLE_MD2_MD4* = 0x1000
  CERT_CHAIN_REVOCATION_CHECK_END_CERT* = 0x10000000
  CERT_CHAIN_REVOCATION_CHECK_CHAIN* = 0x20000000
  CERT_CHAIN_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT* = 0x40000000
  CERT_CHAIN_REVOCATION_CHECK_CACHE_ONLY* = 0x80000000'i32
  CERT_CHAIN_REVOCATION_ACCUMULATIVE_TIMEOUT* = 0x8000000
  CERT_CHAIN_REVOCATION_CHECK_OCSP_CERT* = 0x4000000
  REVOCATION_OID_CRL_REVOCATION* = cast[LPCSTR](1)
  CERT_CHAIN_FIND_BY_ISSUER* = 1
  CERT_CHAIN_FIND_BY_ISSUER_COMPARE_KEY_FLAG* = 0x1
  CERT_CHAIN_FIND_BY_ISSUER_COMPLEX_CHAIN_FLAG* = 0x2
  CERT_CHAIN_FIND_BY_ISSUER_CACHE_ONLY_URL_FLAG* = 0x4
  CERT_CHAIN_FIND_BY_ISSUER_LOCAL_MACHINE_FLAG* = 0x8
  CERT_CHAIN_FIND_BY_ISSUER_NO_KEY_FLAG* = 0x4000
  CERT_CHAIN_FIND_BY_ISSUER_CACHE_ONLY_FLAG* = 0x8000
  CERT_CHAIN_POLICY_IGNORE_NOT_TIME_VALID_FLAG* = 0x1
  CERT_CHAIN_POLICY_IGNORE_CTL_NOT_TIME_VALID_FLAG* = 0x2
  CERT_CHAIN_POLICY_IGNORE_NOT_TIME_NESTED_FLAG* = 0x4
  CERT_CHAIN_POLICY_IGNORE_INVALID_BASIC_CONSTRAINTS_FLAG* = 0x8
  CERT_CHAIN_POLICY_IGNORE_ALL_NOT_TIME_VALID_FLAGS* = CERT_CHAIN_POLICY_IGNORE_NOT_TIME_VALID_FLAG or CERT_CHAIN_POLICY_IGNORE_CTL_NOT_TIME_VALID_FLAG or CERT_CHAIN_POLICY_IGNORE_NOT_TIME_NESTED_FLAG
  CERT_CHAIN_POLICY_ALLOW_UNKNOWN_CA_FLAG* = 0x10
  CERT_CHAIN_POLICY_IGNORE_WRONG_USAGE_FLAG* = 0x20
  CERT_CHAIN_POLICY_IGNORE_INVALID_NAME_FLAG* = 0x40
  CERT_CHAIN_POLICY_IGNORE_INVALID_POLICY_FLAG* = 0x80
  CERT_CHAIN_POLICY_IGNORE_END_REV_UNKNOWN_FLAG* = 0x100
  CERT_CHAIN_POLICY_IGNORE_CTL_SIGNER_REV_UNKNOWN_FLAG* = 0x200
  CERT_CHAIN_POLICY_IGNORE_CA_REV_UNKNOWN_FLAG* = 0x400
  CERT_CHAIN_POLICY_IGNORE_ROOT_REV_UNKNOWN_FLAG* = 0x800
  CERT_CHAIN_POLICY_IGNORE_ALL_REV_UNKNOWN_FLAGS* = CERT_CHAIN_POLICY_IGNORE_END_REV_UNKNOWN_FLAG or CERT_CHAIN_POLICY_IGNORE_CTL_SIGNER_REV_UNKNOWN_FLAG or CERT_CHAIN_POLICY_IGNORE_CA_REV_UNKNOWN_FLAG or CERT_CHAIN_POLICY_IGNORE_ROOT_REV_UNKNOWN_FLAG
  CERT_CHAIN_POLICY_IGNORE_PEER_TRUST_FLAG* = 0x1000
  CERT_CHAIN_POLICY_IGNORE_NOT_SUPPORTED_CRITICAL_EXT_FLAG* = 0x2000
  CERT_CHAIN_POLICY_TRUST_TESTROOT_FLAG* = 0x4000
  CERT_CHAIN_POLICY_ALLOW_TESTROOT_FLAG* = 0x8000
  CRYPT_OID_VERIFY_CERTIFICATE_CHAIN_POLICY_FUNC* = "CertDllVerifyCertificateChainPolicy"
  CERT_CHAIN_POLICY_BASE* = cast[LPCSTR](1)
  CERT_CHAIN_POLICY_AUTHENTICODE* = cast[LPCSTR](2)
  CERT_CHAIN_POLICY_AUTHENTICODE_TS* = cast[LPCSTR](3)
  CERT_CHAIN_POLICY_SSL* = cast[LPCSTR](4)
  CERT_CHAIN_POLICY_BASIC_CONSTRAINTS* = cast[LPCSTR](5)
  CERT_CHAIN_POLICY_NT_AUTH* = cast[LPCSTR](6)
  CERT_CHAIN_POLICY_MICROSOFT_ROOT* = cast[LPCSTR](7)
  CERT_CHAIN_POLICY_EV* = cast[LPCSTR](8)
  AUTHTYPE_CLIENT* = 1
  AUTHTYPE_SERVER* = 2
  BASIC_CONSTRAINTS_CERT_CHAIN_POLICY_CA_FLAG* = 0x80000000'i32
  BASIC_CONSTRAINTS_CERT_CHAIN_POLICY_END_ENTITY_FLAG* = 0x40000000
  MICROSOFT_ROOT_CERT_CHAIN_POLICY_ENABLE_TEST_ROOT_FLAG* = 0x10000
  MICROSOFT_ROOT_CERT_CHAIN_POLICY_CHECK_APPLICATION_ROOT_FLAG* = 0x20000
  CRYPT_STRING_BASE64HEADER* = 0x0
  CRYPT_STRING_BASE64* = 0x1
  CRYPT_STRING_BINARY* = 0x2
  CRYPT_STRING_BASE64REQUESTHEADER* = 0x00000003
  CRYPT_STRING_HEX* = 0x4
  CRYPT_STRING_HEXASCII* = 0x00000005
  CRYPT_STRING_BASE64_ANY* = 0x00000006
  CRYPT_STRING_ANY* = 0x00000007
  CRYPT_STRING_HEX_ANY* = 0x8
  CRYPT_STRING_BASE64X509CRLHEADER* = 0x00000009
  CRYPT_STRING_HEXADDR* = 0x0000000a
  CRYPT_STRING_HEXASCIIADDR* = 0x0000000b
  CRYPT_STRING_HEXRAW* = 0x0000000c
  CRYPT_STRING_HASHDATA* = 0x10000000
  CRYPT_STRING_STRICT* = 0x20000000
  CRYPT_STRING_NOCRLF* = 0x40000000
  CRYPT_STRING_NOCR* = 0x80000000'i32
  szOID_PKCS_12_PbeIds* = "1.2.840.113549.1.12.1"
  szOID_PKCS_12_pbeWithSHA1And128BitRC4* = "1.2.840.113549.1.12.1.1"
  szOID_PKCS_12_pbeWithSHA1And40BitRC4* = "1.2.840.113549.1.12.1.2"
  szOID_PKCS_12_pbeWithSHA1And3KeyTripleDES* = "1.2.840.113549.1.12.1.3"
  szOID_PKCS_12_pbeWithSHA1And2KeyTripleDES* = "1.2.840.113549.1.12.1.4"
  szOID_PKCS_12_pbeWithSHA1And128BitRC2* = "1.2.840.113549.1.12.1.5"
  szOID_PKCS_12_pbeWithSHA1And40BitRC2* = "1.2.840.113549.1.12.1.6"
  PKCS12_IMPORT_SILENT* = 0x40
  CRYPT_USER_KEYSET* = 0x1000
  PKCS12_PREFER_CNG_KSP* = 0x100
  PKCS12_ALWAYS_CNG_KSP* = 0x200
  PKCS12_ALLOW_OVERWRITE_KEY* = 0x4000
  PKCS12_NO_PERSIST_KEY* = 0x8000
  PKCS12_IMPORT_RESERVED_MASK* = 0xffff0000'i32
  PKCS12_INCLUDE_EXTENDED_PROPERTIES* = 0x10
  PKCS12_OBJECT_LOCATOR_ALL_IMPORT_FLAGS* = PKCS12_ALWAYS_CNG_KSP or PKCS12_NO_PERSIST_KEY or PKCS12_IMPORT_SILENT or PKCS12_INCLUDE_EXTENDED_PROPERTIES
  REPORT_NO_PRIVATE_KEY* = 0x1
  REPORT_NOT_ABLE_TO_EXPORT_PRIVATE_KEY* = 0x2
  EXPORT_PRIVATE_KEYS* = 0x4
  PKCS12_PROTECT_TO_DOMAIN_SIDS* = 0x20
  PKCS12_EXPORT_SILENT* = 0x40
  PKCS12_EXPORT_RESERVED_MASK* = 0xffff0000'i32
  CERT_SERVER_OCSP_RESPONSE_ASYNC_FLAG* = 0x1
  CERT_RETRIEVE_ISSUER_LOGO* = cast[LPCSTR](1)
  CERT_RETRIEVE_SUBJECT_LOGO* = cast[LPCSTR](2)
  CERT_RETRIEVE_COMMUNITY_LOGO* = cast[LPCSTR](3)
  CERT_RETRIEVE_BIOMETRIC_PREDEFINED_BASE_TYPE* = cast[LPCSTR](1000)
  CERT_SELECT_MAX_PARA* = 500
  CERT_SELECT_BY_ENHKEY_USAGE* = 1
  CERT_SELECT_BY_KEY_USAGE* = 2
  CERT_SELECT_BY_POLICY_OID* = 3
  CERT_SELECT_BY_PROV_NAME* = 4
  CERT_SELECT_BY_EXTENSION* = 5
  CERT_SELECT_BY_SUBJECT_HOST_NAME* = 6
  CERT_SELECT_BY_ISSUER_ATTR* = 7
  CERT_SELECT_BY_SUBJECT_ATTR* = 8
  CERT_SELECT_BY_ISSUER_NAME* = 9
  CERT_SELECT_BY_PUBLIC_KEY* = 10
  CERT_SELECT_BY_TLS_SIGNATURES* = 11
  CERT_SELECT_LAST* = CERT_SELECT_BY_TLS_SIGNATURES
  CERT_SELECT_MAX* = CERT_SELECT_LAST*3
  CERT_SELECT_ALLOW_EXPIRED* = 0x1
  CERT_SELECT_TRUSTED_ROOT* = 0x2
  CERT_SELECT_DISALLOW_SELFSIGNED* = 0x4
  CERT_SELECT_HAS_PRIVATE_KEY* = 0x8
  CERT_SELECT_HAS_KEY_FOR_SIGNATURE* = 0x10
  CERT_SELECT_HAS_KEY_FOR_KEY_EXCHANGE* = 0x20
  CERT_SELECT_HARDWARE_ONLY* = 0x40
  CERT_SELECT_ALLOW_DUPLICATES* = 0x80
  TIMESTAMP_VERSION* = 1
  TIMESTAMP_STATUS_GRANTED* = 0
  TIMESTAMP_STATUS_GRANTED_WITH_MODS* = 1
  TIMESTAMP_STATUS_REJECTED* = 2
  TIMESTAMP_STATUS_WAITING* = 3
  TIMESTAMP_STATUS_REVOCATION_WARNING* = 4
  TIMESTAMP_STATUS_REVOKED* = 5
  TIMESTAMP_FAILURE_BAD_ALG* = 0
  TIMESTAMP_FAILURE_BAD_REQUEST* = 2
  TIMESTAMP_FAILURE_BAD_FORMAT* = 5
  TIMESTAMP_FAILURE_TIME_NOT_AVAILABLE* = 14
  TIMESTAMP_FAILURE_POLICY_NOT_SUPPORTED* = 15
  TIMESTAMP_FAILURE_EXTENSION_NOT_SUPPORTED* = 16
  TIMESTAMP_FAILURE_INFO_NOT_AVAILABLE* = 17
  TIMESTAMP_FAILURE_SYSTEM_FAILURE* = 25
  TIMESTAMP_DONT_HASH_DATA* = 0x1
  TIMESTAMP_VERIFY_CONTEXT_SIGNATURE* = 0x20
  TIMESTAMP_NO_AUTH_RETRIEVAL* = 0x20000
  CRYPT_OBJECT_LOCATOR_SPN_NAME_TYPE* = 1
  CRYPT_OBJECT_LOCATOR_LAST_RESERVED_NAME_TYPE* = 32
  CRYPT_OBJECT_LOCATOR_FIRST_RESERVED_USER_NAME_TYPE* = 33
  CRYPT_OBJECT_LOCATOR_LAST_RESERVED_USER_NAME_TYPE* = 0x0000ffff
  SSL_OBJECT_LOCATOR_PFX_FUNC* = "SslObjectLocatorInitializePfx"
  SSL_OBJECT_LOCATOR_ISSUER_LIST_FUNC* = "SslObjectLocatorInitializeIssuerList"
  SSL_OBJECT_LOCATOR_CERT_VALIDATION_CONFIG_FUNC* = "SslObjectLocatorInitializeCertValidationConfig"
  CRYPT_OBJECT_LOCATOR_RELEASE_SYSTEM_SHUTDOWN* = 1
  CRYPT_OBJECT_LOCATOR_RELEASE_SERVICE_STOP* = 2
  CRYPT_OBJECT_LOCATOR_RELEASE_PROCESS_EXIT* = 3
  CRYPT_OBJECT_LOCATOR_RELEASE_DLL_UNLOAD* = 4
  CRYPTPROTECT_DEFAULT_PROVIDER* = DEFINE_GUID("df9d8cd0-1501-11d1-8c7a-00c04fc297eb")
  szFORCE_KEY_PROTECTION* = "ForceKeyProtection"
  dwFORCE_KEY_PROTECTION_DISABLED* = 0x0
  dwFORCE_KEY_PROTECTION_USER_SELECT* = 0x1
  dwFORCE_KEY_PROTECTION_HIGH* = 0x2
  CRYPTPROTECT_PROMPT_ON_UNPROTECT* = 0x1
  CRYPTPROTECT_PROMPT_ON_PROTECT* = 0x2
  CRYPTPROTECT_PROMPT_RESERVED* = 0x04
  CRYPTPROTECT_PROMPT_STRONG* = 0x08
  CRYPTPROTECT_PROMPT_REQUIRE_STRONG* = 0x10
  CRYPTPROTECT_UI_FORBIDDEN* = 0x1
  CRYPTPROTECT_LOCAL_MACHINE* = 0x4
  CRYPTPROTECT_CRED_SYNC* = 0x8
  CRYPTPROTECT_AUDIT* = 0x10
  CRYPTPROTECT_NO_RECOVERY* = 0x20
  CRYPTPROTECT_VERIFY_PROTECTION* = 0x40
  CRYPTPROTECT_CRED_REGENERATE* = 0x80
  CRYPTPROTECT_FIRST_RESERVED_FLAGVAL* = 0x0fffffff
  CRYPTPROTECT_LAST_RESERVED_FLAGVAL* = 0xffffffff'i32
  CRYPTPROTECTMEMORY_BLOCK_SIZE* = 16
  CRYPTPROTECTMEMORY_SAME_PROCESS* = 0x0
  CRYPTPROTECTMEMORY_CROSS_PROCESS* = 0x1
  CRYPTPROTECTMEMORY_SAME_LOGON* = 0x2
  MS_ENH_RSA_AES_PROV_XP_A* = "Microsoft Enhanced RSA and AES Cryptographic Provider (Prototype)"
  MS_ENH_RSA_AES_PROV_XP_W* = "Microsoft Enhanced RSA and AES Cryptographic Provider (Prototype)"
  BCRYPT_CIPHER_INTERFACE_VERSION_1* = [1'u16, 0]
  BCRYPT_HASH_INTERFACE_VERSION_1* = [1'u16, 0]
  BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE_VERSION_1* = [1'u16, 0]
  BCRYPT_SECRET_AGREEMENT_INTERFACE_VERSION_1* = [1'u16, 0]
  BCRYPT_SIGNATURE_INTERFACE_VERSION_1* = [1'u16, 0]
  BCRYPT_RNG_INTERFACE_VERSION_1* = [1'u16, 0]
  NCRYPT_KEY_STORAGE_INTERFACE_VERSION* = [1'u16, 0]
  NCRYPT_KEY_STORAGE_INTERFACE_VERSION_2* = [2'u16, 0]
  CTL_FIND_NO_SIGNER_PTR* = cast[PCERT_INFO](-1)
  HCCE_CURRENT_USER* = HCERTCHAINENGINE(0)
  CERT_EFSBLOB_REGPATH* = CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH & "\\EFS"
  CERT_PROT_ROOT_FLAGS_REGPATH* = CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH & "\\Root\\ProtectedRoots"
  CERT_PROT_ROOT_PEER_USAGES_DEFAULT_A* = szOID_PKIX_KP_CLIENT_AUTH & "\0" & szOID_PKIX_KP_EMAIL_PROTECTION & "\0" & szOID_KP_EFS & "\0"
  CERT_TRUST_PUB_SAFER_GROUP_POLICY_REGPATH* = CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH & "\\TrustedPublisher\\Safer"
  CERT_TRUST_PUB_SAFER_LOCAL_MACHINE_REGPATH* = CERT_LOCAL_MACHINE_SYSTEM_STORE_REGPATH & "\\TrustedPublisher\\Safer"
  CERT_DISABLE_ROOT_AUTO_UPDATE_REGPATH* = CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH & "\\AuthRoot"
  CERT_GROUP_POLICY_CHAIN_CONFIG_REGPATH* = CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH & "\\ChainEngine\\Config"
  CERT_RETRIEVE_BIOMETRIC_PICTURE_TYPE* = cast[LPCSTR](1000)
  CERT_RETRIEVE_BIOMETRIC_SIGNATURE_TYPE* = cast[LPCSTR](1001)
type
  PFN_NCRYPT_ALLOC* = proc (cbSize: SIZE_T): LPVOID {.stdcall.}
  PFN_NCRYPT_FREE* = proc (pv: LPVOID): VOID {.stdcall.}
  PFN_CRYPT_ENUM_OID_FUNC* = proc (dwEncodingType: DWORD, pszFuncName: LPCSTR, pszOID: LPCSTR, cValue: DWORD, rgdwValueType: ptr DWORD, rgpwszValueName: ptr LPCWSTR, rgpbValueData: ptr ptr BYTE, rgcbValueData: ptr DWORD, pvArg: pointer): WINBOOL {.stdcall.}
  PFN_CRYPT_ENUM_OID_INFO* = proc (pInfo: PCCRYPT_OID_INFO, pvArg: pointer): WINBOOL {.stdcall.}
  PFN_CMSG_GEN_ENCRYPT_KEY* = proc (phCryptProv: ptr HCRYPTPROV, paiEncrypt: PCRYPT_ALGORITHM_IDENTIFIER, pvEncryptAuxInfo: PVOID, pPublicKeyInfo: PCERT_PUBLIC_KEY_INFO, pfnAlloc: PFN_CMSG_ALLOC, phEncryptKey: ptr HCRYPTKEY, ppbEncryptParameters: ptr PBYTE, pcbEncryptParameters: PDWORD): WINBOOL {.stdcall.}
  PFN_CMSG_EXPORT_ENCRYPT_KEY* = proc (hCryptProv: HCRYPTPROV, hEncryptKey: HCRYPTKEY, pPublicKeyInfo: PCERT_PUBLIC_KEY_INFO, pbData: PBYTE, pcbData: PDWORD): WINBOOL {.stdcall.}
  PFN_CMSG_IMPORT_ENCRYPT_KEY* = proc (hCryptProv: HCRYPTPROV, dwKeySpec: DWORD, paiEncrypt: PCRYPT_ALGORITHM_IDENTIFIER, paiPubKey: PCRYPT_ALGORITHM_IDENTIFIER, pbEncodedKey: PBYTE, cbEncodedKey: DWORD, phEncryptKey: ptr HCRYPTKEY): WINBOOL {.stdcall.}
  PFN_CMSG_GEN_CONTENT_ENCRYPT_KEY* = proc (pContentEncryptInfo: PCMSG_CONTENT_ENCRYPT_INFO, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.stdcall.}
  PFN_CMSG_EXPORT_KEY_TRANS* = proc (pContentEncryptInfo: PCMSG_CONTENT_ENCRYPT_INFO, pKeyTransEncodeInfo: PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO, pKeyTransEncryptInfo: PCMSG_KEY_TRANS_ENCRYPT_INFO, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.stdcall.}
  PFN_CMSG_EXPORT_KEY_AGREE* = proc (pContentEncryptInfo: PCMSG_CONTENT_ENCRYPT_INFO, pKeyAgreeEncodeInfo: PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO, pKeyAgreeEncryptInfo: PCMSG_KEY_AGREE_ENCRYPT_INFO, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.stdcall.}
  PFN_CMSG_EXPORT_MAIL_LIST* = proc (pContentEncryptInfo: PCMSG_CONTENT_ENCRYPT_INFO, pMailListEncodeInfo: PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO, pMailListEncryptInfo: PCMSG_MAIL_LIST_ENCRYPT_INFO, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.stdcall.}
  PFN_CMSG_IMPORT_KEY_TRANS* = proc (pContentEncryptionAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, pKeyTransDecryptPara: PCMSG_CTRL_KEY_TRANS_DECRYPT_PARA, dwFlags: DWORD, pvReserved: pointer, phContentEncryptKey: ptr HCRYPTKEY): WINBOOL {.stdcall.}
  PFN_CMSG_IMPORT_KEY_AGREE* = proc (pContentEncryptionAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, pKeyAgreeDecryptPara: PCMSG_CTRL_KEY_AGREE_DECRYPT_PARA, dwFlags: DWORD, pvReserved: pointer, phContentEncryptKey: ptr HCRYPTKEY): WINBOOL {.stdcall.}
  PFN_CMSG_IMPORT_MAIL_LIST* = proc (pContentEncryptionAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, pMailListDecryptPara: PCMSG_CTRL_MAIL_LIST_DECRYPT_PARA, dwFlags: DWORD, pvReserved: pointer, phContentEncryptKey: ptr HCRYPTKEY): WINBOOL {.stdcall.}
  PFN_CMSG_CNG_IMPORT_KEY_TRANS* = proc (pCNGContentDecryptInfo: PCMSG_CNG_CONTENT_DECRYPT_INFO, pKeyTransDecryptPara: PCMSG_CTRL_KEY_TRANS_DECRYPT_PARA, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.stdcall.}
  PFN_CMSG_CNG_IMPORT_KEY_AGREE* = proc (pCNGContentDecryptInfo: PCMSG_CNG_CONTENT_DECRYPT_INFO, pKeyAgreeDecryptPara: PCMSG_CTRL_KEY_AGREE_DECRYPT_PARA, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.stdcall.}
  PFN_CMSG_CNG_IMPORT_CONTENT_ENCRYPT_KEY* = proc (pCNGContentDecryptInfo: PCMSG_CNG_CONTENT_DECRYPT_INFO, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.stdcall.}
  PFN_CERT_DLL_OPEN_STORE_PROV_FUNC* = proc (lpszStoreProvider: LPCSTR, dwEncodingType: DWORD, hCryptProv: HCRYPTPROV_LEGACY, dwFlags: DWORD, pvPara: pointer, hCertStore: HCERTSTORE, pStoreProvInfo: PCERT_STORE_PROV_INFO): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_CLOSE* = proc (hStoreProv: HCERTSTOREPROV, dwFlags: DWORD): void {.stdcall.}
  PFN_CERT_STORE_PROV_READ_CERT* = proc (hStoreProv: HCERTSTOREPROV, pStoreCertContext: PCCERT_CONTEXT, dwFlags: DWORD, ppProvCertContext: ptr PCCERT_CONTEXT): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_WRITE_CERT* = proc (hStoreProv: HCERTSTOREPROV, pCertContext: PCCERT_CONTEXT, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_DELETE_CERT* = proc (hStoreProv: HCERTSTOREPROV, pCertContext: PCCERT_CONTEXT, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_SET_CERT_PROPERTY* = proc (hStoreProv: HCERTSTOREPROV, pCertContext: PCCERT_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_READ_CRL* = proc (hStoreProv: HCERTSTOREPROV, pStoreCrlContext: PCCRL_CONTEXT, dwFlags: DWORD, ppProvCrlContext: ptr PCCRL_CONTEXT): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_WRITE_CRL* = proc (hStoreProv: HCERTSTOREPROV, pCrlContext: PCCRL_CONTEXT, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_DELETE_CRL* = proc (hStoreProv: HCERTSTOREPROV, pCrlContext: PCCRL_CONTEXT, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_SET_CRL_PROPERTY* = proc (hStoreProv: HCERTSTOREPROV, pCrlContext: PCCRL_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_READ_CTL* = proc (hStoreProv: HCERTSTOREPROV, pStoreCtlContext: PCCTL_CONTEXT, dwFlags: DWORD, ppProvCtlContext: ptr PCCTL_CONTEXT): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_WRITE_CTL* = proc (hStoreProv: HCERTSTOREPROV, pCtlContext: PCCTL_CONTEXT, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_DELETE_CTL* = proc (hStoreProv: HCERTSTOREPROV, pCtlContext: PCCTL_CONTEXT, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_SET_CTL_PROPERTY* = proc (hStoreProv: HCERTSTOREPROV, pCtlContext: PCCTL_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_CONTROL* = proc (hStoreProv: HCERTSTOREPROV, dwFlags: DWORD, dwCtrlType: DWORD, pvCtrlPara: pointer): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_FIND_CERT* = proc (hStoreProv: HCERTSTOREPROV, pFindInfo: PCCERT_STORE_PROV_FIND_INFO, pPrevCertContext: PCCERT_CONTEXT, dwFlags: DWORD, ppvStoreProvFindInfo: ptr pointer, ppProvCertContext: ptr PCCERT_CONTEXT): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_FREE_FIND_CERT* = proc (hStoreProv: HCERTSTOREPROV, pCertContext: PCCERT_CONTEXT, pvStoreProvFindInfo: pointer, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_GET_CERT_PROPERTY* = proc (hStoreProv: HCERTSTOREPROV, pCertContext: PCCERT_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_FIND_CRL* = proc (hStoreProv: HCERTSTOREPROV, pFindInfo: PCCERT_STORE_PROV_FIND_INFO, pPrevCrlContext: PCCRL_CONTEXT, dwFlags: DWORD, ppvStoreProvFindInfo: ptr pointer, ppProvCrlContext: ptr PCCRL_CONTEXT): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_FREE_FIND_CRL* = proc (hStoreProv: HCERTSTOREPROV, pCrlContext: PCCRL_CONTEXT, pvStoreProvFindInfo: pointer, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_GET_CRL_PROPERTY* = proc (hStoreProv: HCERTSTOREPROV, pCrlContext: PCCRL_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_FIND_CTL* = proc (hStoreProv: HCERTSTOREPROV, pFindInfo: PCCERT_STORE_PROV_FIND_INFO, pPrevCtlContext: PCCTL_CONTEXT, dwFlags: DWORD, ppvStoreProvFindInfo: ptr pointer, ppProvCtlContext: ptr PCCTL_CONTEXT): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_FREE_FIND_CTL* = proc (hStoreProv: HCERTSTOREPROV, pCtlContext: PCCTL_CONTEXT, pvStoreProvFindInfo: pointer, dwFlags: DWORD): WINBOOL {.stdcall.}
  PFN_CERT_STORE_PROV_GET_CTL_PROPERTY* = proc (hStoreProv: HCERTSTOREPROV, pCtlContext: PCCTL_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.stdcall.}
  PFN_CERT_ENUM_SYSTEM_STORE_LOCATION* = proc (pwszStoreLocation: LPCWSTR, dwFlags: DWORD, pvReserved: pointer, pvArg: pointer): WINBOOL {.stdcall.}
  PFN_CERT_ENUM_SYSTEM_STORE* = proc (pvSystemStore: pointer, dwFlags: DWORD, pStoreInfo: PCERT_SYSTEM_STORE_INFO, pvReserved: pointer, pvArg: pointer): WINBOOL {.stdcall.}
  PFN_CERT_ENUM_PHYSICAL_STORE* = proc (pvSystemStore: pointer, dwFlags: DWORD, pwszStoreName: LPCWSTR, pStoreInfo: PCERT_PHYSICAL_STORE_INFO, pvReserved: pointer, pvArg: pointer): WINBOOL {.stdcall.}
  PFN_CRYPT_EXTRACT_ENCODED_SIGNATURE_PARAMETERS_FUNC* = proc (dwCertEncodingType: DWORD, pSignatureAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, ppvDecodedSignPara: ptr pointer, ppwszCNGHashAlgid: ptr LPWSTR): WINBOOL {.stdcall.}
  PFN_CRYPT_SIGN_AND_ENCODE_HASH_FUNC* = proc (hKey: NCRYPT_KEY_HANDLE, dwCertEncodingType: DWORD, pSignatureAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, pvDecodedSignPara: pointer, pwszCNGPubKeyAlgid: LPCWSTR, pwszCNGHashAlgid: LPCWSTR, pbComputedHash: ptr BYTE, cbComputedHash: DWORD, pbSignature: ptr BYTE, pcbSignature: ptr DWORD): WINBOOL {.stdcall.}
  PFN_CRYPT_VERIFY_ENCODED_SIGNATURE_FUNC* = proc (dwCertEncodingType: DWORD, pPubKeyInfo: PCERT_PUBLIC_KEY_INFO, pSignatureAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, pvDecodedSignPara: pointer, pwszCNGPubKeyAlgid: LPCWSTR, pwszCNGHashAlgid: LPCWSTR, pbComputedHash: ptr BYTE, cbComputedHash: DWORD, pbSignature: ptr BYTE, cbSignature: DWORD): WINBOOL {.stdcall.}
  PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_EX2_FUNC* = proc (hNCryptKey: NCRYPT_KEY_HANDLE, dwCertEncodingType: DWORD, pszPublicKeyObjId: LPSTR, dwFlags: DWORD, pvAuxInfo: pointer, pInfo: PCERT_PUBLIC_KEY_INFO, pcbInfo: ptr DWORD): WINBOOL {.stdcall.}
  PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_FROM_BCRYPT_HANDLE_FUNC* = proc (hBCryptKey: BCRYPT_KEY_HANDLE, dwCertEncodingType: DWORD, pszPublicKeyObjId: LPSTR, dwFlags: DWORD, pvAuxInfo: pointer, pInfo: PCERT_PUBLIC_KEY_INFO, pcbInfo: ptr DWORD): WINBOOL {.stdcall.}
  PFN_IMPORT_PRIV_KEY_FUNC* = proc (hCryptProv: HCRYPTPROV, pPrivateKeyInfo: ptr CRYPT_PRIVATE_KEY_INFO, dwFlags: DWORD, pvAuxInfo: pointer): WINBOOL {.stdcall.}
  PFN_EXPORT_PRIV_KEY_FUNC* = proc (hCryptProv: HCRYPTPROV, dwKeySpec: DWORD, pszPrivateKeyObjId: LPSTR, dwFlags: DWORD, pvAuxInfo: pointer, pPrivateKeyInfo: ptr CRYPT_PRIVATE_KEY_INFO, pcbPrivateKeyInfo: ptr DWORD): WINBOOL {.stdcall.}
  PFN_IMPORT_PUBLIC_KEY_INFO_EX2_FUNC* = proc (dwCertEncodingType: DWORD, pInfo: PCERT_PUBLIC_KEY_INFO, dwFlags: DWORD, pvAuxInfo: pointer, phKey: ptr BCRYPT_KEY_HANDLE): WINBOOL {.stdcall.}
  PFN_CRYPT_ASYNC_PARAM_FREE_FUNC* = proc (pszParamOid: LPSTR, pvParam: LPVOID): VOID {.stdcall.}
  PFN_FREE_ENCODED_OBJECT_FUNC* = proc (pszObjectOid: LPCSTR, pObject: PCRYPT_BLOB_ARRAY, pvFreeContext: LPVOID): VOID {.stdcall.}
  PFN_CRYPT_CANCEL_RETRIEVAL* = proc (dwFlags: DWORD, pvArg: pointer): WINBOOL {.stdcall.}
  PFN_CANCEL_ASYNC_RETRIEVAL_FUNC* = proc (hAsyncRetrieve: HCRYPTASYNC): WINBOOL {.stdcall.}
  PFN_CRYPT_ENUM_KEYID_PROP* = proc (pKeyIdentifier: ptr CRYPT_HASH_BLOB, dwFlags: DWORD, pvReserved: pointer, pvArg: pointer, cProp: DWORD, rgdwPropId: ptr DWORD, rgpvData: ptr pointer, rgcbData: ptr DWORD): WINBOOL {.stdcall.}
  PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH* = proc (pContext: LPVOID, rgIdentifierOrNameList: ptr PCERT_NAME_BLOB, dwIdentifierOrNameListCount: DWORD): WINBOOL {.stdcall.}
  PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_INITIALIZE* = proc (pfnFlush: PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH, pContext: LPVOID, pdwExpectedObjectCount: ptr DWORD, ppFuncTable: ptr PCRYPT_OBJECT_LOCATOR_PROVIDER_TABLE, ppPluginContext: ptr pointer): WINBOOL {.stdcall.}
  PROV_ENUMALGS* {.pure.} = object
    aiAlgid*: ALG_ID
    dwBitLen*: DWORD
    dwNameLen*: DWORD
    szName*: array[20, CHAR]
  PROV_ENUMALGS_EX* {.pure.} = object
    aiAlgid*: ALG_ID
    dwDefaultLen*: DWORD
    dwMinLen*: DWORD
    dwMaxLen*: DWORD
    dwProtocols*: DWORD
    dwNameLen*: DWORD
    szName*: array[20, CHAR]
    dwLongNameLen*: DWORD
    szLongName*: array[40, CHAR]
  RSAPUBKEY* {.pure.} = object
    magic*: DWORD
    bitlen*: DWORD
    pubexp*: DWORD
  CERT_FORTEZZA_DATA_PROP* {.pure.} = object
    SerialNumber*: array[8, uint8]
    CertIndex*: int32
    CertLabel*: array[36, uint8]
  BCRYPT_OID* {.pure.} = object
    cbOID*: ULONG
    pbOID*: PUCHAR
  BCRYPT_OID_LIST* {.pure.} = object
    dwOIDCount*: ULONG
    pOIDs*: ptr BCRYPT_OID
  BCRYPT_PKCS1_PADDING_INFO* {.pure.} = object
    pszAlgId*: LPCWSTR
  BCRYPT_PSS_PADDING_INFO* {.pure.} = object
    pszAlgId*: LPCWSTR
    cbSalt*: ULONG
  BCRYPT_OAEP_PADDING_INFO* {.pure.} = object
    pszAlgId*: LPCWSTR
    pbLabel*: PUCHAR
    cbLabel*: ULONG
  BCRYPT_KEY_BLOB* {.pure.} = object
    Magic*: ULONG
  BCRYPT_RSAKEY_BLOB* {.pure.} = object
    Magic*: ULONG
    BitLength*: ULONG
    cbPublicExp*: ULONG
    cbModulus*: ULONG
    cbPrime1*: ULONG
    cbPrime2*: ULONG
  BCRYPT_DH_PARAMETER_HEADER* {.pure.} = object
    cbLength*: ULONG
    dwMagic*: ULONG
    cbKeyLength*: ULONG
  BCRYPT_DSA_PARAMETER_HEADER* {.pure.} = object
    cbLength*: ULONG
    dwMagic*: ULONG
    cbKeyLength*: ULONG
    Count*: array[4, UCHAR]
    Seed*: array[20, UCHAR]
    q*: array[20, UCHAR]
  BCRYPT_DSA_PARAMETER_HEADER_V2* {.pure.} = object
    cbLength*: ULONG
    dwMagic*: ULONG
    cbKeyLength*: ULONG
    hashAlgorithm*: HASHALGORITHM_ENUM
    standardVersion*: DSAFIPSVERSION_ENUM
    cbSeedLength*: ULONG
    cbGroupSize*: ULONG
    Count*: array[4, UCHAR]
  BCRYPT_ALGORITHM_IDENTIFIER* {.pure.} = object
    pszName*: LPWSTR
    dwClass*: ULONG
    dwFlags*: ULONG
  BCRYPT_PROVIDER_NAME* {.pure.} = object
    pszProviderName*: LPWSTR
  NCRYPT_ALLOC_PARA* {.pure.} = object
    cbSize*: DWORD
    pfnAlloc*: PFN_NCRYPT_ALLOC
    pfnFree*: PFN_NCRYPT_FREE
  NCryptAlgorithmName* {.pure.} = object
    pszName*: LPWSTR
    dwClass*: DWORD
    dwAlgOperations*: DWORD
    dwFlags*: DWORD
  NCryptKeyName* {.pure.} = object
    pszName*: LPWSTR
    pszAlgid*: LPWSTR
    dwLegacyKeySpec*: DWORD
    dwFlags*: DWORD
  NCryptProviderName* {.pure.} = object
    pszName*: LPWSTR
    pszComment*: LPWSTR
  NCRYPT_UI_POLICY* {.pure.} = object
    dwVersion*: DWORD
    dwFlags*: DWORD
    pszCreationTitle*: LPCWSTR
    pszFriendlyName*: LPCWSTR
    pszDescription*: LPCWSTR
  NCRYPT_SUPPORTED_LENGTHS* {.pure.} = object
    dwMinLength*: DWORD
    dwMaxLength*: DWORD
    dwIncrement*: DWORD
    dwDefaultLength*: DWORD
  CRYPT_PKCS12_PBE_PARAMS* {.pure.} = object
    iIterations*: int32
    cbSalt*: ULONG
proc CryptAcquireContextA*(phProv: ptr HCRYPTPROV, szContainer: LPCSTR, szProvider: LPCSTR, dwProvType: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptAcquireContextW*(phProv: ptr HCRYPTPROV, szContainer: LPCWSTR, szProvider: LPCWSTR, dwProvType: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptReleaseContext*(hProv: HCRYPTPROV, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptGenKey*(hProv: HCRYPTPROV, Algid: ALG_ID, dwFlags: DWORD, phKey: ptr HCRYPTKEY): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptDeriveKey*(hProv: HCRYPTPROV, Algid: ALG_ID, hBaseData: HCRYPTHASH, dwFlags: DWORD, phKey: ptr HCRYPTKEY): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptDestroyKey*(hKey: HCRYPTKEY): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSetKeyParam*(hKey: HCRYPTKEY, dwParam: DWORD, pbData: ptr BYTE, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptGetKeyParam*(hKey: HCRYPTKEY, dwParam: DWORD, pbData: ptr BYTE, pdwDataLen: ptr DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSetHashParam*(hHash: HCRYPTHASH, dwParam: DWORD, pbData: ptr BYTE, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptGetHashParam*(hHash: HCRYPTHASH, dwParam: DWORD, pbData: ptr BYTE, pdwDataLen: ptr DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSetProvParam*(hProv: HCRYPTPROV, dwParam: DWORD, pbData: ptr BYTE, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptGetProvParam*(hProv: HCRYPTPROV, dwParam: DWORD, pbData: ptr BYTE, pdwDataLen: ptr DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptGenRandom*(hProv: HCRYPTPROV, dwLen: DWORD, pbBuffer: ptr BYTE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptGetUserKey*(hProv: HCRYPTPROV, dwKeySpec: DWORD, phUserKey: ptr HCRYPTKEY): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptExportKey*(hKey: HCRYPTKEY, hExpKey: HCRYPTKEY, dwBlobType: DWORD, dwFlags: DWORD, pbData: ptr BYTE, pdwDataLen: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptImportKey*(hProv: HCRYPTPROV, pbData: ptr BYTE, dwDataLen: DWORD, hPubKey: HCRYPTKEY, dwFlags: DWORD, phKey: ptr HCRYPTKEY): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptEncrypt*(hKey: HCRYPTKEY, hHash: HCRYPTHASH, Final: WINBOOL, dwFlags: DWORD, pbData: ptr BYTE, pdwDataLen: ptr DWORD, dwBufLen: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptDecrypt*(hKey: HCRYPTKEY, hHash: HCRYPTHASH, Final: WINBOOL, dwFlags: DWORD, pbData: ptr BYTE, pdwDataLen: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptCreateHash*(hProv: HCRYPTPROV, Algid: ALG_ID, hKey: HCRYPTKEY, dwFlags: DWORD, phHash: ptr HCRYPTHASH): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptHashData*(hHash: HCRYPTHASH, pbData: ptr BYTE, dwDataLen: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptHashSessionKey*(hHash: HCRYPTHASH, hKey: HCRYPTKEY, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptDestroyHash*(hHash: HCRYPTHASH): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSignHashA*(hHash: HCRYPTHASH, dwKeySpec: DWORD, szDescription: LPCSTR, dwFlags: DWORD, pbSignature: ptr BYTE, pdwSigLen: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSignHashW*(hHash: HCRYPTHASH, dwKeySpec: DWORD, szDescription: LPCWSTR, dwFlags: DWORD, pbSignature: ptr BYTE, pdwSigLen: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptVerifySignatureA*(hHash: HCRYPTHASH, pbSignature: ptr BYTE, dwSigLen: DWORD, hPubKey: HCRYPTKEY, szDescription: LPCSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptVerifySignatureW*(hHash: HCRYPTHASH, pbSignature: ptr BYTE, dwSigLen: DWORD, hPubKey: HCRYPTKEY, szDescription: LPCWSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSetProviderA*(pszProvName: LPCSTR, dwProvType: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSetProviderW*(pszProvName: LPCWSTR, dwProvType: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSetProviderExA*(pszProvName: LPCSTR, dwProvType: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptSetProviderExW*(pszProvName: LPCWSTR, dwProvType: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptGetDefaultProviderA*(dwProvType: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pszProvName: LPSTR, pcbProvName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptGetDefaultProviderW*(dwProvType: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pszProvName: LPWSTR, pcbProvName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptEnumProviderTypesA*(dwIndex: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pdwProvType: ptr DWORD, szTypeName: LPSTR, pcbTypeName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptEnumProviderTypesW*(dwIndex: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pdwProvType: ptr DWORD, szTypeName: LPWSTR, pcbTypeName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptEnumProvidersA*(dwIndex: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pdwProvType: ptr DWORD, szProvName: LPSTR, pcbProvName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptEnumProvidersW*(dwIndex: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pdwProvType: ptr DWORD, szProvName: LPWSTR, pcbProvName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptContextAddRef*(hProv: HCRYPTPROV, pdwReserved: ptr DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptDuplicateKey*(hKey: HCRYPTKEY, pdwReserved: ptr DWORD, dwFlags: DWORD, phKey: ptr HCRYPTKEY): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CryptDuplicateHash*(hHash: HCRYPTHASH, pdwReserved: ptr DWORD, dwFlags: DWORD, phHash: ptr HCRYPTHASH): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BCryptOpenAlgorithmProvider*(phAlgorithm: ptr BCRYPT_ALG_HANDLE, pszAlgId: LPCWSTR, pszImplementation: LPCWSTR, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptEnumAlgorithms*(dwAlgOperations: ULONG, pAlgCount: ptr ULONG, ppAlgList: ptr ptr BCRYPT_ALGORITHM_IDENTIFIER, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptEnumProviders*(pszAlgId: LPCWSTR, pImplCount: ptr ULONG, ppImplList: ptr ptr BCRYPT_PROVIDER_NAME, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptGetProperty*(hObject: BCRYPT_HANDLE, pszProperty: LPCWSTR, pbOutput: PUCHAR, cbOutput: ULONG, pcbResult: ptr ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptSetProperty*(hObject: BCRYPT_HANDLE, pszProperty: LPCWSTR, pbInput: PUCHAR, cbInput: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptCloseAlgorithmProvider*(hAlgorithm: BCRYPT_ALG_HANDLE, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptFreeBuffer*(pvBuffer: PVOID): VOID {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptGenerateSymmetricKey*(hAlgorithm: BCRYPT_ALG_HANDLE, phKey: ptr BCRYPT_KEY_HANDLE, pbKeyObject: PUCHAR, cbKeyObject: ULONG, pbSecret: PUCHAR, cbSecret: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptGenerateKeyPair*(hAlgorithm: BCRYPT_ALG_HANDLE, phKey: ptr BCRYPT_KEY_HANDLE, dwLength: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptEncrypt*(hKey: BCRYPT_KEY_HANDLE, pbInput: PUCHAR, cbInput: ULONG, pPaddingInfo: pointer, pbIV: PUCHAR, cbIV: ULONG, pbOutput: PUCHAR, cbOutput: ULONG, pcbResult: ptr ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDecrypt*(hKey: BCRYPT_KEY_HANDLE, pbInput: PUCHAR, cbInput: ULONG, pPaddingInfo: pointer, pbIV: PUCHAR, cbIV: ULONG, pbOutput: PUCHAR, cbOutput: ULONG, pcbResult: ptr ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptExportKey*(hKey: BCRYPT_KEY_HANDLE, hExportKey: BCRYPT_KEY_HANDLE, pszBlobType: LPCWSTR, pbOutput: PUCHAR, cbOutput: ULONG, pcbResult: ptr ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptImportKey*(hAlgorithm: BCRYPT_ALG_HANDLE, hImportKey: BCRYPT_KEY_HANDLE, pszBlobType: LPCWSTR, phKey: ptr BCRYPT_KEY_HANDLE, pbKeyObject: PUCHAR, cbKeyObject: ULONG, pbInput: PUCHAR, cbInput: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptImportKeyPair*(hAlgorithm: BCRYPT_ALG_HANDLE, hImportKey: BCRYPT_KEY_HANDLE, pszBlobType: LPCWSTR, phKey: ptr BCRYPT_KEY_HANDLE, pbInput: PUCHAR, cbInput: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDuplicateKey*(hKey: BCRYPT_KEY_HANDLE, phNewKey: ptr BCRYPT_KEY_HANDLE, pbKeyObject: PUCHAR, cbKeyObject: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptFinalizeKeyPair*(hKey: BCRYPT_KEY_HANDLE, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDestroyKey*(hKey: BCRYPT_KEY_HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDestroySecret*(hSecret: BCRYPT_SECRET_HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptSignHash*(hKey: BCRYPT_KEY_HANDLE, pPaddingInfo: pointer, pbInput: PUCHAR, cbInput: ULONG, pbOutput: PUCHAR, cbOutput: ULONG, pcbResult: ptr ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptVerifySignature*(hKey: BCRYPT_KEY_HANDLE, pPaddingInfo: pointer, pbHash: PUCHAR, cbHash: ULONG, pbSignature: PUCHAR, cbSignature: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptSecretAgreement*(hPrivKey: BCRYPT_KEY_HANDLE, hPubKey: BCRYPT_KEY_HANDLE, phAgreedSecret: ptr BCRYPT_SECRET_HANDLE, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDeriveKey*(hSharedSecret: BCRYPT_SECRET_HANDLE, pwszKDF: LPCWSTR, pParameterList: ptr BCryptBufferDesc, pbDerivedKey: PUCHAR, cbDerivedKey: ULONG, pcbResult: ptr ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptKeyDerivation*(hKey: BCRYPT_KEY_HANDLE, pParameterList: ptr BCryptBufferDesc, pbDerivedKey: PUCHAR, cbDerivedKey: ULONG, pcbResult: ptr ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptCreateHash*(hAlgorithm: BCRYPT_ALG_HANDLE, phHash: ptr BCRYPT_HASH_HANDLE, pbHashObject: PUCHAR, cbHashObject: ULONG, pbSecret: PUCHAR, cbSecret: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptHashData*(hHash: BCRYPT_HASH_HANDLE, pbInput: PUCHAR, cbInput: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptFinishHash*(hHash: BCRYPT_HASH_HANDLE, pbOutput: PUCHAR, cbOutput: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDuplicateHash*(hHash: BCRYPT_HASH_HANDLE, phNewHash: ptr BCRYPT_HASH_HANDLE, pbHashObject: PUCHAR, cbHashObject: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDestroyHash*(hHash: BCRYPT_HASH_HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptGenRandom*(hAlgorithm: BCRYPT_ALG_HANDLE, pbBuffer: PUCHAR, cbBuffer: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDeriveKeyCapi*(hHash: BCRYPT_HASH_HANDLE, hTargetAlg: BCRYPT_ALG_HANDLE, pbDerivedKey: PUCHAR, cbDerivedKey: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDeriveKeyPBKDF2*(hPrf: BCRYPT_ALG_HANDLE, pbPassword: PUCHAR, cbPassword: ULONG, pbSalt: PUCHAR, cbSalt: ULONG, cIterations: ULONGLONG, pbDerivedKey: PUCHAR, cbDerivedKey: ULONG, dwFlags: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptResolveProviders*(pszContext: LPCWSTR, dwInterface: ULONG, pszFunction: LPCWSTR, pszProvider: LPCWSTR, dwMode: ULONG, dwFlags: ULONG, pcbBuffer: ptr ULONG, ppBuffer: ptr PCRYPT_PROVIDER_REFS): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptGetFipsAlgorithmMode*(pfEnabled: ptr BOOLEAN): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptRegisterConfigChangeNotify*(pEvent: PRKEVENT): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptUnregisterConfigChangeNotify*(pEvent: PRKEVENT): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptUnregisterConfigChangeNotify*(hEvent: HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptQueryProviderRegistration*(pszProvider: LPCWSTR, dwMode: ULONG, dwInterface: ULONG, pcbBuffer: ptr ULONG, ppBuffer: ptr PCRYPT_PROVIDER_REG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptEnumRegisteredProviders*(pcbBuffer: ptr ULONG, ppBuffer: ptr PCRYPT_PROVIDERS): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptCreateContext*(dwTable: ULONG, pszContext: LPCWSTR, pConfig: PCRYPT_CONTEXT_CONFIG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptDeleteContext*(dwTable: ULONG, pszContext: LPCWSTR): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptEnumContexts*(dwTable: ULONG, pcbBuffer: ptr ULONG, ppBuffer: ptr PCRYPT_CONTEXTS): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptConfigureContext*(dwTable: ULONG, pszContext: LPCWSTR, pConfig: PCRYPT_CONTEXT_CONFIG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptQueryContextConfiguration*(dwTable: ULONG, pszContext: LPCWSTR, pcbBuffer: ptr ULONG, ppBuffer: ptr PCRYPT_CONTEXT_CONFIG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptAddContextFunction*(dwTable: ULONG, pszContext: LPCWSTR, dwInterface: ULONG, pszFunction: LPCWSTR, dwPosition: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptRemoveContextFunction*(dwTable: ULONG, pszContext: LPCWSTR, dwInterface: ULONG, pszFunction: LPCWSTR): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptEnumContextFunctions*(dwTable: ULONG, pszContext: LPCWSTR, dwInterface: ULONG, pcbBuffer: ptr ULONG, ppBuffer: ptr PCRYPT_CONTEXT_FUNCTIONS): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptConfigureContextFunction*(dwTable: ULONG, pszContext: LPCWSTR, dwInterface: ULONG, pszFunction: LPCWSTR, pConfig: PCRYPT_CONTEXT_FUNCTION_CONFIG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptQueryContextFunctionConfiguration*(dwTable: ULONG, pszContext: LPCWSTR, dwInterface: ULONG, pszFunction: LPCWSTR, pcbBuffer: ptr ULONG, ppBuffer: ptr PCRYPT_CONTEXT_FUNCTION_CONFIG): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptEnumContextFunctionProviders*(dwTable: ULONG, pszContext: LPCWSTR, dwInterface: ULONG, pszFunction: LPCWSTR, pcbBuffer: ptr ULONG, ppBuffer: ptr PCRYPT_CONTEXT_FUNCTION_PROVIDERS): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptSetContextFunctionProperty*(dwTable: ULONG, pszContext: LPCWSTR, dwInterface: ULONG, pszFunction: LPCWSTR, pszProperty: LPCWSTR, cbValue: ULONG, pbValue: PUCHAR): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptQueryContextFunctionProperty*(dwTable: ULONG, pszContext: LPCWSTR, dwInterface: ULONG, pszFunction: LPCWSTR, pszProperty: LPCWSTR, pcbValue: ptr ULONG, ppbValue: ptr PUCHAR): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc BCryptRegisterConfigChangeNotify*(phEvent: ptr HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "bcrypt", importc.}
proc NCryptOpenStorageProvider*(phProvider: ptr NCRYPT_PROV_HANDLE, pszProviderName: LPCWSTR, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptEnumAlgorithms*(hProvider: NCRYPT_PROV_HANDLE, dwAlgOperations: DWORD, pdwAlgCount: ptr DWORD, ppAlgList: ptr ptr NCryptAlgorithmName, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptIsAlgSupported*(hProvider: NCRYPT_PROV_HANDLE, pszAlgId: LPCWSTR, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptEnumKeys*(hProvider: NCRYPT_PROV_HANDLE, pszScope: LPCWSTR, ppKeyName: ptr ptr NCryptKeyName, ppEnumState: ptr PVOID, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptEnumStorageProviders*(pdwProviderCount: ptr DWORD, ppProviderList: ptr ptr NCryptProviderName, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptFreeBuffer*(pvInput: PVOID): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptOpenKey*(hProvider: NCRYPT_PROV_HANDLE, phKey: ptr NCRYPT_KEY_HANDLE, pszKeyName: LPCWSTR, dwLegacyKeySpec: DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptCreatePersistedKey*(hProvider: NCRYPT_PROV_HANDLE, phKey: ptr NCRYPT_KEY_HANDLE, pszAlgId: LPCWSTR, pszKeyName: LPCWSTR, dwLegacyKeySpec: DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptGetProperty*(hObject: NCRYPT_HANDLE, pszProperty: LPCWSTR, pbOutput: PBYTE, cbOutput: DWORD, pcbResult: ptr DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptSetProperty*(hObject: NCRYPT_HANDLE, pszProperty: LPCWSTR, pbInput: PBYTE, cbInput: DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptFinalizeKey*(hKey: NCRYPT_KEY_HANDLE, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptEncrypt*(hKey: NCRYPT_KEY_HANDLE, pbInput: PBYTE, cbInput: DWORD, pPaddingInfo: pointer, pbOutput: PBYTE, cbOutput: DWORD, pcbResult: ptr DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptDecrypt*(hKey: NCRYPT_KEY_HANDLE, pbInput: PBYTE, cbInput: DWORD, pPaddingInfo: pointer, pbOutput: PBYTE, cbOutput: DWORD, pcbResult: ptr DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptImportKey*(hProvider: NCRYPT_PROV_HANDLE, hImportKey: NCRYPT_KEY_HANDLE, pszBlobType: LPCWSTR, pParameterList: ptr NCryptBufferDesc, phKey: ptr NCRYPT_KEY_HANDLE, pbData: PBYTE, cbData: DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptExportKey*(hKey: NCRYPT_KEY_HANDLE, hExportKey: NCRYPT_KEY_HANDLE, pszBlobType: LPCWSTR, pParameterList: ptr NCryptBufferDesc, pbOutput: PBYTE, cbOutput: DWORD, pcbResult: ptr DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptSignHash*(hKey: NCRYPT_KEY_HANDLE, pPaddingInfo: pointer, pbHashValue: PBYTE, cbHashValue: DWORD, pbSignature: PBYTE, cbSignature: DWORD, pcbResult: ptr DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptVerifySignature*(hKey: NCRYPT_KEY_HANDLE, pPaddingInfo: pointer, pbHashValue: PBYTE, cbHashValue: DWORD, pbSignature: PBYTE, cbSignature: DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptDeleteKey*(hKey: NCRYPT_KEY_HANDLE, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptFreeObject*(hObject: NCRYPT_HANDLE): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptIsKeyHandle*(hKey: NCRYPT_KEY_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptTranslateHandle*(phProvider: ptr NCRYPT_PROV_HANDLE, phKey: ptr NCRYPT_KEY_HANDLE, hLegacyProv: HCRYPTPROV, hLegacyKey: HCRYPTKEY, dwLegacyKeySpec: DWORD, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptNotifyChangeKey*(hProvider: NCRYPT_PROV_HANDLE, phEvent: ptr HANDLE, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptSecretAgreement*(hPrivKey: NCRYPT_KEY_HANDLE, hPubKey: NCRYPT_KEY_HANDLE, phAgreedSecret: ptr NCRYPT_SECRET_HANDLE, dwFlags: DWORD): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptDeriveKey*(hSharedSecret: NCRYPT_SECRET_HANDLE, pwszKDF: LPCWSTR, pParameterList: ptr NCryptBufferDesc, pbDerivedKey: PBYTE, cbDerivedKey: DWORD, pcbResult: ptr DWORD, dwFlags: ULONG): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc NCryptKeyDerivation*(hKey: NCRYPT_KEY_HANDLE, pParameterList: ptr NCryptBufferDesc, pbDerivedKey: PUCHAR, cbDerivedKey: DWORD, pcbResult: ptr DWORD, dwFlags: ULONG): SECURITY_STATUS {.winapi, stdcall, dynlib: "ncrypt", importc.}
proc CryptFormatObject*(dwCertEncodingType: DWORD, dwFormatType: DWORD, dwFormatStrType: DWORD, pFormatStruct: pointer, lpszStructType: LPCSTR, pbEncoded: ptr BYTE, cbEncoded: DWORD, pbFormat: pointer, pcbFormat: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptEncodeObjectEx*(dwCertEncodingType: DWORD, lpszStructType: LPCSTR, pvStructInfo: pointer, dwFlags: DWORD, pEncodePara: PCRYPT_ENCODE_PARA, pvEncoded: pointer, pcbEncoded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptEncodeObject*(dwCertEncodingType: DWORD, lpszStructType: LPCSTR, pvStructInfo: pointer, pbEncoded: ptr BYTE, pcbEncoded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptDecodeObjectEx*(dwCertEncodingType: DWORD, lpszStructType: LPCSTR, pbEncoded: ptr BYTE, cbEncoded: DWORD, dwFlags: DWORD, pDecodePara: PCRYPT_DECODE_PARA, pvStructInfo: pointer, pcbStructInfo: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptDecodeObject*(dwCertEncodingType: DWORD, lpszStructType: LPCSTR, pbEncoded: ptr BYTE, cbEncoded: DWORD, dwFlags: DWORD, pvStructInfo: pointer, pcbStructInfo: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptInstallOIDFunctionAddress*(hModule: HMODULE, dwEncodingType: DWORD, pszFuncName: LPCSTR, cFuncEntry: DWORD, rgFuncEntry: ptr CRYPT_OID_FUNC_ENTRY, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptInitOIDFunctionSet*(pszFuncName: LPCSTR, dwFlags: DWORD): HCRYPTOIDFUNCSET {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptGetOIDFunctionAddress*(hFuncSet: HCRYPTOIDFUNCSET, dwEncodingType: DWORD, pszOID: LPCSTR, dwFlags: DWORD, ppvFuncAddr: ptr pointer, phFuncAddr: ptr HCRYPTOIDFUNCADDR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptGetDefaultOIDDllList*(hFuncSet: HCRYPTOIDFUNCSET, dwEncodingType: DWORD, pwszDllList: ptr WCHAR, pcchDllList: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptGetDefaultOIDFunctionAddress*(hFuncSet: HCRYPTOIDFUNCSET, dwEncodingType: DWORD, pwszDll: LPCWSTR, dwFlags: DWORD, ppvFuncAddr: ptr pointer, phFuncAddr: ptr HCRYPTOIDFUNCADDR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptFreeOIDFunctionAddress*(hFuncAddr: HCRYPTOIDFUNCADDR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptRegisterOIDFunction*(dwEncodingType: DWORD, pszFuncName: LPCSTR, pszOID: LPCSTR, pwszDll: LPCWSTR, pszOverrideFuncName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptUnregisterOIDFunction*(dwEncodingType: DWORD, pszFuncName: LPCSTR, pszOID: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptRegisterDefaultOIDFunction*(dwEncodingType: DWORD, pszFuncName: LPCSTR, dwIndex: DWORD, pwszDll: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptUnregisterDefaultOIDFunction*(dwEncodingType: DWORD, pszFuncName: LPCSTR, pwszDll: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSetOIDFunctionValue*(dwEncodingType: DWORD, pszFuncName: LPCSTR, pszOID: LPCSTR, pwszValueName: LPCWSTR, dwValueType: DWORD, pbValueData: ptr BYTE, cbValueData: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptGetOIDFunctionValue*(dwEncodingType: DWORD, pszFuncName: LPCSTR, pszOID: LPCSTR, pwszValueName: LPCWSTR, pdwValueType: ptr DWORD, pbValueData: ptr BYTE, pcbValueData: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptEnumOIDFunction*(dwEncodingType: DWORD, pszFuncName: LPCSTR, pszOID: LPCSTR, dwFlags: DWORD, pvArg: pointer, pfnEnumOIDFunc: PFN_CRYPT_ENUM_OID_FUNC): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptFindOIDInfo*(dwKeyType: DWORD, pvKey: pointer, dwGroupId: DWORD): PCCRYPT_OID_INFO {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptRegisterOIDInfo*(pInfo: PCCRYPT_OID_INFO, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptUnregisterOIDInfo*(pInfo: PCCRYPT_OID_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptEnumOIDInfo*(dwGroupId: DWORD, dwFlags: DWORD, pvArg: pointer, pfnEnumOIDInfo: PFN_CRYPT_ENUM_OID_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptFindLocalizedName*(pwszCryptName: LPCWSTR): LPCWSTR {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgOpenToEncode*(dwMsgEncodingType: DWORD, dwFlags: DWORD, dwMsgType: DWORD, pvMsgEncodeInfo: pointer, pszInnerContentObjID: LPSTR, pStreamInfo: PCMSG_STREAM_INFO): HCRYPTMSG {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgCalculateEncodedLength*(dwMsgEncodingType: DWORD, dwFlags: DWORD, dwMsgType: DWORD, pvMsgEncodeInfo: pointer, pszInnerContentObjID: LPSTR, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgOpenToDecode*(dwMsgEncodingType: DWORD, dwFlags: DWORD, dwMsgType: DWORD, hCryptProv: HCRYPTPROV_LEGACY, pRecipientInfo: PCERT_INFO, pStreamInfo: PCMSG_STREAM_INFO): HCRYPTMSG {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgDuplicate*(hCryptMsg: HCRYPTMSG): HCRYPTMSG {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgClose*(hCryptMsg: HCRYPTMSG): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgUpdate*(hCryptMsg: HCRYPTMSG, pbData: ptr BYTE, cbData: DWORD, fFinal: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgGetParam*(hCryptMsg: HCRYPTMSG, dwParamType: DWORD, dwIndex: DWORD, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgControl*(hCryptMsg: HCRYPTMSG, dwFlags: DWORD, dwCtrlType: DWORD, pvCtrlPara: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgVerifyCountersignatureEncoded*(hCryptProv: HCRYPTPROV_LEGACY, dwEncodingType: DWORD, pbSignerInfo: PBYTE, cbSignerInfo: DWORD, pbSignerInfoCountersignature: PBYTE, cbSignerInfoCountersignature: DWORD, pciCountersigner: PCERT_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgVerifyCountersignatureEncodedEx*(hCryptProv: HCRYPTPROV_LEGACY, dwEncodingType: DWORD, pbSignerInfo: PBYTE, cbSignerInfo: DWORD, pbSignerInfoCountersignature: PBYTE, cbSignerInfoCountersignature: DWORD, dwSignerType: DWORD, pvSigner: pointer, dwFlags: DWORD, pvExtra: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgCountersign*(hCryptMsg: HCRYPTMSG, dwIndex: DWORD, cCountersigners: DWORD, rgCountersigners: PCMSG_SIGNER_ENCODE_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgCountersignEncoded*(dwEncodingType: DWORD, pbSignerInfo: PBYTE, cbSignerInfo: DWORD, cCountersigners: DWORD, rgCountersigners: PCMSG_SIGNER_ENCODE_INFO, pbCountersignature: PBYTE, pcbCountersignature: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertOpenStore*(lpszStoreProvider: LPCSTR, dwEncodingType: DWORD, hCryptProv: HCRYPTPROV_LEGACY, dwFlags: DWORD, pvPara: pointer): HCERTSTORE {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertDuplicateStore*(hCertStore: HCERTSTORE): HCERTSTORE {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSaveStore*(hCertStore: HCERTSTORE, dwEncodingType: DWORD, dwSaveAs: DWORD, dwSaveTo: DWORD, pvSaveToPara: pointer, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCloseStore*(hCertStore: HCERTSTORE, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetSubjectCertificateFromStore*(hCertStore: HCERTSTORE, dwCertEncodingType: DWORD, pCertId: PCERT_INFO): PCCERT_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumCertificatesInStore*(hCertStore: HCERTSTORE, pPrevCertContext: PCCERT_CONTEXT): PCCERT_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindCertificateInStore*(hCertStore: HCERTSTORE, dwCertEncodingType: DWORD, dwFindFlags: DWORD, dwFindType: DWORD, pvFindPara: pointer, pPrevCertContext: PCCERT_CONTEXT): PCCERT_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetIssuerCertificateFromStore*(hCertStore: HCERTSTORE, pSubjectContext: PCCERT_CONTEXT, pPrevIssuerContext: PCCERT_CONTEXT, pdwFlags: ptr DWORD): PCCERT_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertVerifySubjectCertificateContext*(pSubject: PCCERT_CONTEXT, pIssuer: PCCERT_CONTEXT, pdwFlags: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertDuplicateCertificateContext*(pCertContext: PCCERT_CONTEXT): PCCERT_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCreateCertificateContext*(dwCertEncodingType: DWORD, pbCertEncoded: ptr BYTE, cbCertEncoded: DWORD): PCCERT_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFreeCertificateContext*(pCertContext: PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSetCertificateContextProperty*(pCertContext: PCCERT_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumCRLsInStore*(hCertStore: HCERTSTORE, pPrevCrlContext: PCCRL_CONTEXT): PCCRL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertDeleteCRLFromStore*(pCrlContext: PCCRL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertDuplicateCRLContext*(pCrlContext: PCCRL_CONTEXT): PCCRL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindCRLInStore*(hCertStore: HCERTSTORE, dwCertEncodingType: DWORD, dwFindFlags: DWORD, dwFindType: DWORD, pvFindPara: pointer, pPrevCrlContext: PCCRL_CONTEXT): PCCRL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFreeCRLContext*(pCrlContext: PCCRL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetCertificateContextProperty*(pCertContext: PCCERT_CONTEXT, dwPropId: DWORD, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumCertificateContextProperties*(pCertContext: PCCERT_CONTEXT, dwPropId: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCreateCTLEntryFromCertificateContextProperties*(pCertContext: PCCERT_CONTEXT, cOptAttr: DWORD, rgOptAttr: PCRYPT_ATTRIBUTE, dwFlags: DWORD, pvReserved: pointer, pCtlEntry: PCTL_ENTRY, pcbCtlEntry: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSetCertificateContextPropertiesFromCTLEntry*(pCertContext: PCCERT_CONTEXT, pCtlEntry: PCTL_ENTRY, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetCRLFromStore*(hCertStore: HCERTSTORE, pIssuerContext: PCCERT_CONTEXT, pPrevCrlContext: PCCRL_CONTEXT, pdwFlags: ptr DWORD): PCCRL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCreateCRLContext*(dwCertEncodingType: DWORD, pbCrlEncoded: ptr BYTE, cbCrlEncoded: DWORD): PCCRL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSetCRLContextProperty*(pCrlContext: PCCRL_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetCRLContextProperty*(pCrlContext: PCCRL_CONTEXT, dwPropId: DWORD, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumCRLContextProperties*(pCrlContext: PCCRL_CONTEXT, dwPropId: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindCertificateInCRL*(pCert: PCCERT_CONTEXT, pCrlContext: PCCRL_CONTEXT, dwFlags: DWORD, pvReserved: pointer, ppCrlEntry: ptr PCRL_ENTRY): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertIsValidCRLForCertificate*(pCert: PCCERT_CONTEXT, pCrl: PCCRL_CONTEXT, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddEncodedCertificateToStore*(hCertStore: HCERTSTORE, dwCertEncodingType: DWORD, pbCertEncoded: ptr BYTE, cbCertEncoded: DWORD, dwAddDisposition: DWORD, ppCertContext: ptr PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddCertificateContextToStore*(hCertStore: HCERTSTORE, pCertContext: PCCERT_CONTEXT, dwAddDisposition: DWORD, ppStoreContext: ptr PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddSerializedElementToStore*(hCertStore: HCERTSTORE, pbElement: ptr BYTE, cbElement: DWORD, dwAddDisposition: DWORD, dwFlags: DWORD, dwContextTypeFlags: DWORD, pdwContextType: ptr DWORD, ppvContext: ptr pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertDeleteCertificateFromStore*(pCertContext: PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddEncodedCRLToStore*(hCertStore: HCERTSTORE, dwCertEncodingType: DWORD, pbCrlEncoded: ptr BYTE, cbCrlEncoded: DWORD, dwAddDisposition: DWORD, ppCrlContext: ptr PCCRL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddCRLContextToStore*(hCertStore: HCERTSTORE, pCrlContext: PCCRL_CONTEXT, dwAddDisposition: DWORD, ppStoreContext: ptr PCCRL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSerializeCertificateStoreElement*(pCertContext: PCCERT_CONTEXT, dwFlags: DWORD, pbElement: ptr BYTE, pcbElement: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSerializeCRLStoreElement*(pCrlContext: PCCRL_CONTEXT, dwFlags: DWORD, pbElement: ptr BYTE, pcbElement: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertDuplicateCTLContext*(pCtlContext: PCCTL_CONTEXT): PCCTL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCreateCTLContext*(dwMsgAndCertEncodingType: DWORD, pbCtlEncoded: ptr BYTE, cbCtlEncoded: DWORD): PCCTL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFreeCTLContext*(pCtlContext: PCCTL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSetCTLContextProperty*(pCtlContext: PCCTL_CONTEXT, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetCTLContextProperty*(pCtlContext: PCCTL_CONTEXT, dwPropId: DWORD, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumCTLContextProperties*(pCtlContext: PCCTL_CONTEXT, dwPropId: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumCTLsInStore*(hCertStore: HCERTSTORE, pPrevCtlContext: PCCTL_CONTEXT): PCCTL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindSubjectInCTL*(dwEncodingType: DWORD, dwSubjectType: DWORD, pvSubject: pointer, pCtlContext: PCCTL_CONTEXT, dwFlags: DWORD): PCTL_ENTRY {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindCTLInStore*(hCertStore: HCERTSTORE, dwMsgAndCertEncodingType: DWORD, dwFindFlags: DWORD, dwFindType: DWORD, pvFindPara: pointer, pPrevCtlContext: PCCTL_CONTEXT): PCCTL_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddEncodedCTLToStore*(hCertStore: HCERTSTORE, dwMsgAndCertEncodingType: DWORD, pbCtlEncoded: ptr BYTE, cbCtlEncoded: DWORD, dwAddDisposition: DWORD, ppCtlContext: ptr PCCTL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddCTLContextToStore*(hCertStore: HCERTSTORE, pCtlContext: PCCTL_CONTEXT, dwAddDisposition: DWORD, ppStoreContext: ptr PCCTL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSerializeCTLStoreElement*(pCtlContext: PCCTL_CONTEXT, dwFlags: DWORD, pbElement: ptr BYTE, pcbElement: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertDeleteCTLFromStore*(pCtlContext: PCCTL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddCertificateLinkToStore*(hCertStore: HCERTSTORE, pCertContext: PCCERT_CONTEXT, dwAddDisposition: DWORD, ppStoreContext: ptr PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddCRLLinkToStore*(hCertStore: HCERTSTORE, pCrlContext: PCCRL_CONTEXT, dwAddDisposition: DWORD, ppStoreContext: ptr PCCRL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddCTLLinkToStore*(hCertStore: HCERTSTORE, pCtlContext: PCCTL_CONTEXT, dwAddDisposition: DWORD, ppStoreContext: ptr PCCTL_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddStoreToCollection*(hCollectionStore: HCERTSTORE, hSiblingStore: HCERTSTORE, dwUpdateFlags: DWORD, dwPriority: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertRemoveStoreFromCollection*(hCollectionStore: HCERTSTORE, hSiblingStore: HCERTSTORE): void {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertControlStore*(hCertStore: HCERTSTORE, dwFlags: DWORD, dwCtrlType: DWORD, pvCtrlPara: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSetStoreProperty*(hCertStore: HCERTSTORE, dwPropId: DWORD, dwFlags: DWORD, pvData: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetStoreProperty*(hCertStore: HCERTSTORE, dwPropId: DWORD, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertRegisterSystemStore*(pvSystemStore: pointer, dwFlags: DWORD, pStoreInfo: PCERT_SYSTEM_STORE_INFO, pvReserved: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertRegisterPhysicalStore*(pvSystemStore: pointer, dwFlags: DWORD, pwszStoreName: LPCWSTR, pStoreInfo: PCERT_PHYSICAL_STORE_INFO, pvReserved: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertUnregisterSystemStore*(pvSystemStore: pointer, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertUnregisterPhysicalStore*(pvSystemStore: pointer, dwFlags: DWORD, pwszStoreName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumSystemStoreLocation*(dwFlags: DWORD, pvArg: pointer, pfnEnum: PFN_CERT_ENUM_SYSTEM_STORE_LOCATION): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumSystemStore*(dwFlags: DWORD, pvSystemStoreLocationPara: pointer, pvArg: pointer, pfnEnum: PFN_CERT_ENUM_SYSTEM_STORE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumPhysicalStore*(pvSystemStore: pointer, dwFlags: DWORD, pvArg: pointer, pfnEnum: PFN_CERT_ENUM_PHYSICAL_STORE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetEnhancedKeyUsage*(pCertContext: PCCERT_CONTEXT, dwFlags: DWORD, pUsage: PCERT_ENHKEY_USAGE, pcbUsage: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSetEnhancedKeyUsage*(pCertContext: PCCERT_CONTEXT, pUsage: PCERT_ENHKEY_USAGE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddEnhancedKeyUsageIdentifier*(pCertContext: PCCERT_CONTEXT, pszUsageIdentifier: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertRemoveEnhancedKeyUsageIdentifier*(pCertContext: PCCERT_CONTEXT, pszUsageIdentifier: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetValidUsages*(cCerts: DWORD, rghCerts: ptr PCCERT_CONTEXT, cNumOIDs: ptr int32, rghOIDs: ptr LPSTR, pcbOIDs: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgGetAndVerifySigner*(hCryptMsg: HCRYPTMSG, cSignerStore: DWORD, rghSignerStore: ptr HCERTSTORE, dwFlags: DWORD, ppSigner: ptr PCCERT_CONTEXT, pdwSignerIndex: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgSignCTL*(dwMsgEncodingType: DWORD, pbCtlContent: ptr BYTE, cbCtlContent: DWORD, pSignInfo: PCMSG_SIGNED_ENCODE_INFO, dwFlags: DWORD, pbEncoded: ptr BYTE, pcbEncoded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMsgEncodeAndSignCTL*(dwMsgEncodingType: DWORD, pCtlInfo: PCTL_INFO, pSignInfo: PCMSG_SIGNED_ENCODE_INFO, dwFlags: DWORD, pbEncoded: ptr BYTE, pcbEncoded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindSubjectInSortedCTL*(pSubjectIdentifier: PCRYPT_DATA_BLOB, pCtlContext: PCCTL_CONTEXT, dwFlags: DWORD, pvReserved: pointer, pEncodedAttributes: PCRYPT_DER_BLOB): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertEnumSubjectInSortedCTL*(pCtlContext: PCCTL_CONTEXT, ppvNextSubject: ptr pointer, pSubjectIdentifier: PCRYPT_DER_BLOB, pEncodedAttributes: PCRYPT_DER_BLOB): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertVerifyCTLUsage*(dwEncodingType: DWORD, dwSubjectType: DWORD, pvSubject: pointer, pSubjectUsage: PCTL_USAGE, dwFlags: DWORD, pVerifyUsagePara: PCTL_VERIFY_USAGE_PARA, pVerifyUsageStatus: PCTL_VERIFY_USAGE_STATUS): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertVerifyRevocation*(dwEncodingType: DWORD, dwRevType: DWORD, cContext: DWORD, rgpvContext: ptr PVOID, dwFlags: DWORD, pRevPara: PCERT_REVOCATION_PARA, pRevStatus: PCERT_REVOCATION_STATUS): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCompareIntegerBlob*(pInt1: PCRYPT_INTEGER_BLOB, pInt2: PCRYPT_INTEGER_BLOB): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCompareCertificate*(dwCertEncodingType: DWORD, pCertId1: PCERT_INFO, pCertId2: PCERT_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCompareCertificateName*(dwCertEncodingType: DWORD, pCertName1: PCERT_NAME_BLOB, pCertName2: PCERT_NAME_BLOB): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertIsRDNAttrsInCertificateName*(dwCertEncodingType: DWORD, dwFlags: DWORD, pCertName: PCERT_NAME_BLOB, pRDN: PCERT_RDN): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertComparePublicKeyInfo*(dwCertEncodingType: DWORD, pPublicKey1: PCERT_PUBLIC_KEY_INFO, pPublicKey2: PCERT_PUBLIC_KEY_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetPublicKeyLength*(dwCertEncodingType: DWORD, pPublicKey: PCERT_PUBLIC_KEY_INFO): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptVerifyCertificateSignature*(hCryptProv: HCRYPTPROV_LEGACY, dwCertEncodingType: DWORD, pbEncoded: ptr BYTE, cbEncoded: DWORD, pPublicKey: PCERT_PUBLIC_KEY_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptVerifyCertificateSignatureEx*(hCryptProv: HCRYPTPROV_LEGACY, dwCertEncodingType: DWORD, dwSubjectType: DWORD, pvSubject: pointer, dwIssuerType: DWORD, pvIssuer: pointer, dwFlags: DWORD, pvExtra: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertIsStrongHashToSign*(pStrongSignPara: PCCERT_STRONG_SIGN_PARA, pwszCNGHashAlgid: LPCWSTR, pSigningCert: PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptHashToBeSigned*(hCryptProv: HCRYPTPROV_LEGACY, dwCertEncodingType: DWORD, pbEncoded: ptr BYTE, cbEncoded: DWORD, pbComputedHash: ptr BYTE, pcbComputedHash: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptHashCertificate*(hCryptProv: HCRYPTPROV_LEGACY, Algid: ALG_ID, dwFlags: DWORD, pbEncoded: ptr BYTE, cbEncoded: DWORD, pbComputedHash: ptr BYTE, pcbComputedHash: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptHashCertificate2*(pwszCNGHashAlgid: LPCWSTR, dwFlags: DWORD, pvReserved: pointer, pbEncoded: ptr BYTE, cbEncoded: DWORD, pbComputedHash: ptr BYTE, pcbComputedHash: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSignCertificate*(hCryptProvOrNCryptKey: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, dwKeySpec: DWORD, dwCertEncodingType: DWORD, pbEncodedToBeSigned: ptr BYTE, cbEncodedToBeSigned: DWORD, pSignatureAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, pvHashAuxInfo: pointer, pbSignature: ptr BYTE, pcbSignature: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSignAndEncodeCertificate*(hCryptProvOrNCryptKey: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, dwKeySpec: DWORD, dwCertEncodingType: DWORD, lpszStructType: LPCSTR, pvStructInfo: pointer, pSignatureAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, pvHashAuxInfo: pointer, pbEncoded: ptr BYTE, pcbEncoded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertVerifyTimeValidity*(pTimeToVerify: LPFILETIME, pCertInfo: PCERT_INFO): LONG {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertVerifyCRLTimeValidity*(pTimeToVerify: LPFILETIME, pCrlInfo: PCRL_INFO): LONG {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertVerifyValidityNesting*(pSubjectInfo: PCERT_INFO, pIssuerInfo: PCERT_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertVerifyCRLRevocation*(dwCertEncodingType: DWORD, pCertId: PCERT_INFO, cCrlInfo: DWORD, rgpCrlInfo: ptr PCRL_INFO): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAlgIdToOID*(dwAlgId: DWORD): LPCSTR {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertOIDToAlgId*(pszObjId: LPCSTR): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindExtension*(pszObjId: LPCSTR, cExtensions: DWORD, rgExtensions: ptr CERT_EXTENSION): PCERT_EXTENSION {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindAttribute*(pszObjId: LPCSTR, cAttr: DWORD, rgAttr: ptr CRYPT_ATTRIBUTE): PCRYPT_ATTRIBUTE {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindRDNAttr*(pszObjId: LPCSTR, pName: PCERT_NAME_INFO): PCERT_RDN_ATTR {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetIntendedKeyUsage*(dwCertEncodingType: DWORD, pCertInfo: PCERT_INFO, pbKeyUsage: ptr BYTE, cbKeyUsage: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptInstallDefaultContext*(hCryptProv: HCRYPTPROV, dwDefaultType: DWORD, pvDefaultPara: pointer, dwFlags: DWORD, pvReserved: pointer, phDefaultContext: ptr HCRYPTDEFAULTCONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptUninstallDefaultContext*(hDefaultContext: HCRYPTDEFAULTCONTEXT, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptExportPublicKeyInfo*(hCryptProvOrNCryptKey: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, dwKeySpec: DWORD, dwCertEncodingType: DWORD, pInfo: PCERT_PUBLIC_KEY_INFO, pcbInfo: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptExportPublicKeyInfoEx*(hCryptProvOrNCryptKey: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, dwKeySpec: DWORD, dwCertEncodingType: DWORD, pszPublicKeyObjId: LPSTR, dwFlags: DWORD, pvAuxInfo: pointer, pInfo: PCERT_PUBLIC_KEY_INFO, pcbInfo: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptExportPublicKeyInfoFromBCryptKeyHandle*(hBCryptKey: BCRYPT_KEY_HANDLE, dwCertEncodingType: DWORD, pszPublicKeyObjId: LPSTR, dwFlags: DWORD, pvAuxInfo: pointer, pInfo: PCERT_PUBLIC_KEY_INFO, pcbInfo: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptImportPublicKeyInfo*(hCryptProv: HCRYPTPROV, dwCertEncodingType: DWORD, pInfo: PCERT_PUBLIC_KEY_INFO, phKey: ptr HCRYPTKEY): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptImportPublicKeyInfoEx*(hCryptProv: HCRYPTPROV, dwCertEncodingType: DWORD, pInfo: PCERT_PUBLIC_KEY_INFO, aiKeyAlg: ALG_ID, dwFlags: DWORD, pvAuxInfo: pointer, phKey: ptr HCRYPTKEY): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptImportPublicKeyInfoEx2*(dwCertEncodingType: DWORD, pInfo: PCERT_PUBLIC_KEY_INFO, dwFlags: DWORD, pvAuxInfo: pointer, phKey: ptr BCRYPT_KEY_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptAcquireCertificatePrivateKey*(pCert: PCCERT_CONTEXT, dwFlags: DWORD, pvParameters: pointer, phCryptProvOrNCryptKey: ptr HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, pdwKeySpec: ptr DWORD, pfCallerFreeProvOrNCryptKey: ptr WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptFindCertificateKeyProvInfo*(pCert: PCCERT_CONTEXT, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptImportPKCS8*(sPrivateKeyAndParams: CRYPT_PKCS8_IMPORT_PARAMS, dwFlags: DWORD, phCryptProv: ptr HCRYPTPROV, pvAuxInfo: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptExportPKCS8*(hCryptProv: HCRYPTPROV, dwKeySpec: DWORD, pszPrivateKeyObjId: LPSTR, dwFlags: DWORD, pvAuxInfo: pointer, pbPrivateKeyBlob: ptr BYTE, pcbPrivateKeyBlob: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptHashPublicKeyInfo*(hCryptProv: HCRYPTPROV_LEGACY, Algid: ALG_ID, dwFlags: DWORD, dwCertEncodingType: DWORD, pInfo: PCERT_PUBLIC_KEY_INFO, pbComputedHash: ptr BYTE, pcbComputedHash: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertRDNValueToStrA*(dwValueType: DWORD, pValue: PCERT_RDN_VALUE_BLOB, psz: LPSTR, csz: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertRDNValueToStrW*(dwValueType: DWORD, pValue: PCERT_RDN_VALUE_BLOB, psz: LPWSTR, csz: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertNameToStrA*(dwCertEncodingType: DWORD, pName: PCERT_NAME_BLOB, dwStrType: DWORD, psz: LPSTR, csz: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertNameToStrW*(dwCertEncodingType: DWORD, pName: PCERT_NAME_BLOB, dwStrType: DWORD, psz: LPWSTR, csz: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertStrToNameA*(dwCertEncodingType: DWORD, pszX500: LPCSTR, dwStrType: DWORD, pvReserved: pointer, pbEncoded: ptr BYTE, pcbEncoded: ptr DWORD, ppszError: ptr LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertStrToNameW*(dwCertEncodingType: DWORD, pszX500: LPCWSTR, dwStrType: DWORD, pvReserved: pointer, pbEncoded: ptr BYTE, pcbEncoded: ptr DWORD, ppszError: ptr LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetNameStringA*(pCertContext: PCCERT_CONTEXT, dwType: DWORD, dwFlags: DWORD, pvTypePara: pointer, pszNameString: LPSTR, cchNameString: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetNameStringW*(pCertContext: PCCERT_CONTEXT, dwType: DWORD, dwFlags: DWORD, pvTypePara: pointer, pszNameString: LPWSTR, cchNameString: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSignMessage*(pSignPara: PCRYPT_SIGN_MESSAGE_PARA, fDetachedSignature: WINBOOL, cToBeSigned: DWORD, rgpbToBeSigned: ptr ptr BYTE, rgcbToBeSigned: ptr DWORD, pbSignedBlob: ptr BYTE, pcbSignedBlob: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptVerifyMessageSignature*(pVerifyPara: PCRYPT_VERIFY_MESSAGE_PARA, dwSignerIndex: DWORD, pbSignedBlob: ptr BYTE, cbSignedBlob: DWORD, pbDecoded: ptr BYTE, pcbDecoded: ptr DWORD, ppSignerCert: ptr PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptGetMessageSignerCount*(dwMsgEncodingType: DWORD, pbSignedBlob: ptr BYTE, cbSignedBlob: DWORD): LONG {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptGetMessageCertificates*(dwMsgAndCertEncodingType: DWORD, hCryptProv: HCRYPTPROV_LEGACY, dwFlags: DWORD, pbSignedBlob: ptr BYTE, cbSignedBlob: DWORD): HCERTSTORE {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptVerifyDetachedMessageSignature*(pVerifyPara: PCRYPT_VERIFY_MESSAGE_PARA, dwSignerIndex: DWORD, pbDetachedSignBlob: ptr BYTE, cbDetachedSignBlob: DWORD, cToBeSigned: DWORD, rgpbToBeSigned: ptr ptr BYTE, rgcbToBeSigned: ptr DWORD, ppSignerCert: ptr PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptEncryptMessage*(pEncryptPara: PCRYPT_ENCRYPT_MESSAGE_PARA, cRecipientCert: DWORD, rgpRecipientCert: ptr PCCERT_CONTEXT, pbToBeEncrypted: ptr BYTE, cbToBeEncrypted: DWORD, pbEncryptedBlob: ptr BYTE, pcbEncryptedBlob: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptDecryptMessage*(pDecryptPara: PCRYPT_DECRYPT_MESSAGE_PARA, pbEncryptedBlob: ptr BYTE, cbEncryptedBlob: DWORD, pbDecrypted: ptr BYTE, pcbDecrypted: ptr DWORD, ppXchgCert: ptr PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSignAndEncryptMessage*(pSignPara: PCRYPT_SIGN_MESSAGE_PARA, pEncryptPara: PCRYPT_ENCRYPT_MESSAGE_PARA, cRecipientCert: DWORD, rgpRecipientCert: ptr PCCERT_CONTEXT, pbToBeSignedAndEncrypted: ptr BYTE, cbToBeSignedAndEncrypted: DWORD, pbSignedAndEncryptedBlob: ptr BYTE, pcbSignedAndEncryptedBlob: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptDecryptAndVerifyMessageSignature*(pDecryptPara: PCRYPT_DECRYPT_MESSAGE_PARA, pVerifyPara: PCRYPT_VERIFY_MESSAGE_PARA, dwSignerIndex: DWORD, pbEncryptedBlob: ptr BYTE, cbEncryptedBlob: DWORD, pbDecrypted: ptr BYTE, pcbDecrypted: ptr DWORD, ppXchgCert: ptr PCCERT_CONTEXT, ppSignerCert: ptr PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptDecodeMessage*(dwMsgTypeFlags: DWORD, pDecryptPara: PCRYPT_DECRYPT_MESSAGE_PARA, pVerifyPara: PCRYPT_VERIFY_MESSAGE_PARA, dwSignerIndex: DWORD, pbEncodedBlob: ptr BYTE, cbEncodedBlob: DWORD, dwPrevInnerContentType: DWORD, pdwMsgType: ptr DWORD, pdwInnerContentType: ptr DWORD, pbDecoded: ptr BYTE, pcbDecoded: ptr DWORD, ppXchgCert: ptr PCCERT_CONTEXT, ppSignerCert: ptr PCCERT_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptHashMessage*(pHashPara: PCRYPT_HASH_MESSAGE_PARA, fDetachedHash: WINBOOL, cToBeHashed: DWORD, rgpbToBeHashed: ptr ptr BYTE, rgcbToBeHashed: ptr DWORD, pbHashedBlob: ptr BYTE, pcbHashedBlob: ptr DWORD, pbComputedHash: ptr BYTE, pcbComputedHash: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptVerifyMessageHash*(pHashPara: PCRYPT_HASH_MESSAGE_PARA, pbHashedBlob: ptr BYTE, cbHashedBlob: DWORD, pbToBeHashed: ptr BYTE, pcbToBeHashed: ptr DWORD, pbComputedHash: ptr BYTE, pcbComputedHash: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptVerifyDetachedMessageHash*(pHashPara: PCRYPT_HASH_MESSAGE_PARA, pbDetachedHashBlob: ptr BYTE, cbDetachedHashBlob: DWORD, cToBeHashed: DWORD, rgpbToBeHashed: ptr ptr BYTE, rgcbToBeHashed: ptr DWORD, pbComputedHash: ptr BYTE, pcbComputedHash: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSignMessageWithKey*(pSignPara: PCRYPT_KEY_SIGN_MESSAGE_PARA, pbToBeSigned: ptr BYTE, cbToBeSigned: DWORD, pbSignedBlob: ptr BYTE, pcbSignedBlob: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptVerifyMessageSignatureWithKey*(pVerifyPara: PCRYPT_KEY_VERIFY_MESSAGE_PARA, pPublicKeyInfo: PCERT_PUBLIC_KEY_INFO, pbSignedBlob: ptr BYTE, cbSignedBlob: DWORD, pbDecoded: ptr BYTE, pcbDecoded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertOpenSystemStoreA*(hProv: HCRYPTPROV_LEGACY, szSubsystemProtocol: LPCSTR): HCERTSTORE {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertOpenSystemStoreW*(hProv: HCRYPTPROV_LEGACY, szSubsystemProtocol: LPCWSTR): HCERTSTORE {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddEncodedCertificateToSystemStoreA*(szCertStoreName: LPCSTR, pbCertEncoded: ptr BYTE, cbCertEncoded: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddEncodedCertificateToSystemStoreW*(szCertStoreName: LPCWSTR, pbCertEncoded: ptr BYTE, cbCertEncoded: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc FindCertsByIssuer*(pCertChains: PCERT_CHAIN, pcbCertChains: ptr DWORD, pcCertChains: ptr DWORD, pbEncodedIssuerName: ptr BYTE, cbEncodedIssuerName: DWORD, pwszPurpose: LPCWSTR, dwKeySpec: DWORD): HRESULT {.winapi, stdcall, dynlib: "wintrust", importc.}
proc CryptQueryObject*(dwObjectType: DWORD, pvObject: pointer, dwExpectedContentTypeFlags: DWORD, dwExpectedFormatTypeFlags: DWORD, dwFlags: DWORD, pdwMsgAndCertEncodingType: ptr DWORD, pdwContentType: ptr DWORD, pdwFormatType: ptr DWORD, phCertStore: ptr HCERTSTORE, phMsg: ptr HCRYPTMSG, ppvContext: ptr pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMemAlloc*(cbSize: ULONG): LPVOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMemRealloc*(pv: LPVOID, cbSize: ULONG): LPVOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptMemFree*(pv: LPVOID): VOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptCreateAsyncHandle*(dwFlags: DWORD, phAsync: PHCRYPTASYNC): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSetAsyncParam*(hAsync: HCRYPTASYNC, pszParamOid: LPSTR, pvParam: LPVOID, pfnFree: PFN_CRYPT_ASYNC_PARAM_FREE_FUNC): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptGetAsyncParam*(hAsync: HCRYPTASYNC, pszParamOid: LPSTR, ppvParam: ptr LPVOID, ppfnFree: ptr PFN_CRYPT_ASYNC_PARAM_FREE_FUNC): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptCloseAsyncHandle*(hAsync: HCRYPTASYNC): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptRetrieveObjectByUrlA*(pszUrl: LPCSTR, pszObjectOid: LPCSTR, dwRetrievalFlags: DWORD, dwTimeout: DWORD, ppvObject: ptr LPVOID, hAsyncRetrieve: HCRYPTASYNC, pCredentials: PCRYPT_CREDENTIALS, pvVerify: LPVOID, pAuxInfo: PCRYPT_RETRIEVE_AUX_INFO): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc.}
proc CryptRetrieveObjectByUrlW*(pszUrl: LPCWSTR, pszObjectOid: LPCSTR, dwRetrievalFlags: DWORD, dwTimeout: DWORD, ppvObject: ptr LPVOID, hAsyncRetrieve: HCRYPTASYNC, pCredentials: PCRYPT_CREDENTIALS, pvVerify: LPVOID, pAuxInfo: PCRYPT_RETRIEVE_AUX_INFO): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc.}
proc CryptInstallCancelRetrieval*(pfnCancel: PFN_CRYPT_CANCEL_RETRIEVAL, pvArg: pointer, dwFlags: DWORD, pvReserved: pointer): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc.}
proc CryptUninstallCancelRetrieval*(dwFlags: DWORD, pvReserved: pointer): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc.}
proc CryptCancelAsyncRetrieval*(hAsyncRetrieval: HCRYPTASYNC): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc.}
proc CryptGetObjectUrl*(pszUrlOid: LPCSTR, pvPara: LPVOID, dwFlags: DWORD, pUrlArray: PCRYPT_URL_ARRAY, pcbUrlArray: ptr DWORD, pUrlInfo: PCRYPT_URL_INFO, pcbUrlInfo: ptr DWORD, pvReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc.}
proc CryptGetTimeValidObject*(pszTimeValidOid: LPCSTR, pvPara: LPVOID, pIssuer: PCCERT_CONTEXT, pftValidFor: LPFILETIME, dwFlags: DWORD, dwTimeout: DWORD, ppvObject: ptr LPVOID, pCredentials: PCRYPT_CREDENTIALS, pExtraInfo: PCRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc.}
proc CryptFlushTimeValidObject*(pszFlushTimeValidOid: LPCSTR, pvPara: LPVOID, pIssuer: PCCERT_CONTEXT, dwFlags: DWORD, pvReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc.}
proc CertCreateSelfSignCertificate*(hCryptProvOrNCryptKey: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, pSubjectIssuerBlob: PCERT_NAME_BLOB, dwFlags: DWORD, pKeyProvInfo: PCRYPT_KEY_PROV_INFO, pSignatureAlgorithm: PCRYPT_ALGORITHM_IDENTIFIER, pStartTime: PSYSTEMTIME, pEndTime: PSYSTEMTIME, pExtensions: PCERT_EXTENSIONS): PCCERT_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptGetKeyIdentifierProperty*(pKeyIdentifier: ptr CRYPT_HASH_BLOB, dwPropId: DWORD, dwFlags: DWORD, pwszComputerName: LPCWSTR, pvReserved: pointer, pvData: pointer, pcbData: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptSetKeyIdentifierProperty*(pKeyIdentifier: ptr CRYPT_HASH_BLOB, dwPropId: DWORD, dwFlags: DWORD, pwszComputerName: LPCWSTR, pvReserved: pointer, pvData: pointer): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptEnumKeyIdentifierProperties*(pKeyIdentifier: ptr CRYPT_HASH_BLOB, dwPropId: DWORD, dwFlags: DWORD, pwszComputerName: LPCWSTR, pvReserved: pointer, pvArg: pointer, pfnEnum: PFN_CRYPT_ENUM_KEYID_PROP): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptCreateKeyIdentifierFromCSP*(dwCertEncodingType: DWORD, pszPubKeyOID: LPCSTR, pPubKeyStruc: ptr PUBLICKEYSTRUC, cbPubKeyStruc: DWORD, dwFlags: DWORD, pvReserved: pointer, pbHash: ptr BYTE, pcbHash: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCreateCertificateChainEngine*(pConfig: PCERT_CHAIN_ENGINE_CONFIG, phChainEngine: ptr HCERTCHAINENGINE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFreeCertificateChainEngine*(hChainEngine: HCERTCHAINENGINE): VOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertResyncCertificateChainEngine*(hChainEngine: HCERTCHAINENGINE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetCertificateChain*(hChainEngine: HCERTCHAINENGINE, pCertContext: PCCERT_CONTEXT, pTime: LPFILETIME, hAdditionalStore: HCERTSTORE, pChainPara: PCERT_CHAIN_PARA, dwFlags: DWORD, pvReserved: LPVOID, ppChainContext: ptr PCCERT_CHAIN_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFreeCertificateChain*(pChainContext: PCCERT_CHAIN_CONTEXT): VOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertDuplicateCertificateChain*(pChainContext: PCCERT_CHAIN_CONTEXT): PCCERT_CHAIN_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFindChainInStore*(hCertStore: HCERTSTORE, dwCertEncodingType: DWORD, dwFindFlags: DWORD, dwFindType: DWORD, pvFindPara: pointer, pPrevChainContext: PCCERT_CHAIN_CONTEXT): PCCERT_CHAIN_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertVerifyCertificateChainPolicy*(pszPolicyOID: LPCSTR, pChainContext: PCCERT_CHAIN_CONTEXT, pPolicyPara: PCERT_CHAIN_POLICY_PARA, pPolicyStatus: PCERT_CHAIN_POLICY_STATUS): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptStringToBinaryA*(pszString: LPCSTR, cchString: DWORD, dwFlags: DWORD, pbBinary: ptr BYTE, pcbBinary: ptr DWORD, pdwSkip: ptr DWORD, pdwFlags: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptStringToBinaryW*(pszString: LPCWSTR, cchString: DWORD, dwFlags: DWORD, pbBinary: ptr BYTE, pcbBinary: ptr DWORD, pdwSkip: ptr DWORD, pdwFlags: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptBinaryToStringA*(pbBinary: ptr BYTE, cbBinary: DWORD, dwFlags: DWORD, pszString: LPSTR, pcchString: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptBinaryToStringW*(pbBinary: ptr BYTE, cbBinary: DWORD, dwFlags: DWORD, pszString: LPWSTR, pcchString: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc PFXImportCertStore*(pPFX: ptr CRYPT_DATA_BLOB, szPassword: LPCWSTR, dwFlags: DWORD): HCERTSTORE {.winapi, stdcall, dynlib: "crypt32", importc.}
proc PFXIsPFXBlob*(pPFX: ptr CRYPT_DATA_BLOB): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc PFXVerifyPassword*(pPFX: ptr CRYPT_DATA_BLOB, szPassword: LPCWSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc PFXExportCertStoreEx*(hStore: HCERTSTORE, pPFX: ptr CRYPT_DATA_BLOB, szPassword: LPCWSTR, pvPara: pointer, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc PFXExportCertStore*(hStore: HCERTSTORE, pPFX: ptr CRYPT_DATA_BLOB, szPassword: LPCWSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertOpenServerOcspResponse*(pChainContext: PCCERT_CHAIN_CONTEXT, dwFlags: DWORD, pvReserved: LPVOID): HCERT_SERVER_OCSP_RESPONSE {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddRefServerOcspResponse*(hServerOcspResponse: HCERT_SERVER_OCSP_RESPONSE): VOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertCloseServerOcspResponse*(hServerOcspResponse: HCERT_SERVER_OCSP_RESPONSE, dwFlags: DWORD): VOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertGetServerOcspResponseContext*(hServerOcspResponse: HCERT_SERVER_OCSP_RESPONSE, dwFlags: DWORD, pvReserved: LPVOID): PCCERT_SERVER_OCSP_RESPONSE_CONTEXT {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertAddRefServerOcspResponseContext*(pServerOcspResponseContext: PCCERT_SERVER_OCSP_RESPONSE_CONTEXT): VOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFreeServerOcspResponseContext*(pServerOcspResponseContext: PCCERT_SERVER_OCSP_RESPONSE_CONTEXT): VOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertRetrieveLogoOrBiometricInfo*(pCertContext: PCCERT_CONTEXT, lpszLogoOrBiometricType: LPCSTR, dwRetrievalFlags: DWORD, dwTimeout: DWORD, dwFlags: DWORD, pvReserved: pointer, ppbData: ptr ptr BYTE, pcbData: ptr DWORD, ppwszMimeType: ptr LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertSelectCertificateChains*(pSelectionContext: LPCGUID, dwFlags: DWORD, pChainParameters: PCCERT_SELECT_CHAIN_PARA, cCriteria: DWORD, rgpCriteria: PCCERT_SELECT_CRITERIA, hStore: HCERTSTORE, pcSelection: PDWORD, pprgpSelection: ptr ptr PCCERT_CHAIN_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CertFreeCertificateChainList*(prgpSelection: ptr PCCERT_CHAIN_CONTEXT): VOID {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptRetrieveTimeStamp*(wszUrl: LPCWSTR, dwRetrievalFlags: DWORD, dwTimeout: DWORD, pszHashId: LPCSTR, pPara: ptr CRYPT_TIMESTAMP_PARA, pbData: ptr BYTE, cbData: DWORD, ppTsContext: ptr PCRYPT_TIMESTAMP_CONTEXT, ppTsSigner: ptr PCCERT_CONTEXT, phStore: ptr HCERTSTORE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptVerifyTimeStampSignature*(pbTSContentInfo: ptr BYTE, cbTSContentInfo: DWORD, pbData: ptr BYTE, cbData: DWORD, hAdditionalStore: HCERTSTORE, ppTsContext: ptr PCRYPT_TIMESTAMP_CONTEXT, ppTsSigner: ptr PCCERT_CONTEXT, phStore: ptr HCERTSTORE): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptProtectData*(pDataIn: ptr DATA_BLOB, szDataDescr: LPCWSTR, pOptionalEntropy: ptr DATA_BLOB, pvReserved: PVOID, pPromptStruct: ptr CRYPTPROTECT_PROMPTSTRUCT, dwFlags: DWORD, pDataOut: ptr DATA_BLOB): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptUnprotectData*(pDataIn: ptr DATA_BLOB, ppszDataDescr: ptr LPWSTR, pOptionalEntropy: ptr DATA_BLOB, pvReserved: PVOID, pPromptStruct: ptr CRYPTPROTECT_PROMPTSTRUCT, dwFlags: DWORD, pDataOut: ptr DATA_BLOB): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptProtectMemory*(pDataIn: LPVOID, cbDataIn: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptUnprotectMemory*(pDataIn: LPVOID, cbDataIn: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc CryptUpdateProtectedState*(pOldSid: PSID, pwszOldPassword: LPCWSTR, dwFlags: DWORD, pdwSuccessCount: ptr DWORD, pdwFailureCount: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc.}
proc `pOtherName=`*(self: var CERT_ALT_NAME_ENTRY, x: PCERT_OTHER_NAME) {.inline.} = self.union1.pOtherName = x
proc pOtherName*(self: CERT_ALT_NAME_ENTRY): PCERT_OTHER_NAME {.inline.} = self.union1.pOtherName
proc pOtherName*(self: var CERT_ALT_NAME_ENTRY): var PCERT_OTHER_NAME {.inline.} = self.union1.pOtherName
proc `pwszRfc822Name=`*(self: var CERT_ALT_NAME_ENTRY, x: LPWSTR) {.inline.} = self.union1.pwszRfc822Name = x
proc pwszRfc822Name*(self: CERT_ALT_NAME_ENTRY): LPWSTR {.inline.} = self.union1.pwszRfc822Name
proc pwszRfc822Name*(self: var CERT_ALT_NAME_ENTRY): var LPWSTR {.inline.} = self.union1.pwszRfc822Name
proc `pwszDNSName=`*(self: var CERT_ALT_NAME_ENTRY, x: LPWSTR) {.inline.} = self.union1.pwszDNSName = x
proc pwszDNSName*(self: CERT_ALT_NAME_ENTRY): LPWSTR {.inline.} = self.union1.pwszDNSName
proc pwszDNSName*(self: var CERT_ALT_NAME_ENTRY): var LPWSTR {.inline.} = self.union1.pwszDNSName
proc `DirectoryName=`*(self: var CERT_ALT_NAME_ENTRY, x: CERT_NAME_BLOB) {.inline.} = self.union1.DirectoryName = x
proc DirectoryName*(self: CERT_ALT_NAME_ENTRY): CERT_NAME_BLOB {.inline.} = self.union1.DirectoryName
proc DirectoryName*(self: var CERT_ALT_NAME_ENTRY): var CERT_NAME_BLOB {.inline.} = self.union1.DirectoryName
proc `pwszURL=`*(self: var CERT_ALT_NAME_ENTRY, x: LPWSTR) {.inline.} = self.union1.pwszURL = x
proc pwszURL*(self: CERT_ALT_NAME_ENTRY): LPWSTR {.inline.} = self.union1.pwszURL
proc pwszURL*(self: var CERT_ALT_NAME_ENTRY): var LPWSTR {.inline.} = self.union1.pwszURL
proc `IPAddress=`*(self: var CERT_ALT_NAME_ENTRY, x: CRYPT_DATA_BLOB) {.inline.} = self.union1.IPAddress = x
proc IPAddress*(self: CERT_ALT_NAME_ENTRY): CRYPT_DATA_BLOB {.inline.} = self.union1.IPAddress
proc IPAddress*(self: var CERT_ALT_NAME_ENTRY): var CRYPT_DATA_BLOB {.inline.} = self.union1.IPAddress
proc `pszRegisteredID=`*(self: var CERT_ALT_NAME_ENTRY, x: LPSTR) {.inline.} = self.union1.pszRegisteredID = x
proc pszRegisteredID*(self: CERT_ALT_NAME_ENTRY): LPSTR {.inline.} = self.union1.pszRegisteredID
proc pszRegisteredID*(self: var CERT_ALT_NAME_ENTRY): var LPSTR {.inline.} = self.union1.pszRegisteredID
proc `FullName=`*(self: var CRL_DIST_POINT_NAME, x: CERT_ALT_NAME_INFO) {.inline.} = self.union1.FullName = x
proc FullName*(self: CRL_DIST_POINT_NAME): CERT_ALT_NAME_INFO {.inline.} = self.union1.FullName
proc FullName*(self: var CRL_DIST_POINT_NAME): var CERT_ALT_NAME_INFO {.inline.} = self.union1.FullName
proc `pTaggedCertRequest=`*(self: var CMC_TAGGED_REQUEST, x: PCMC_TAGGED_CERT_REQUEST) {.inline.} = self.union1.pTaggedCertRequest = x
proc pTaggedCertRequest*(self: CMC_TAGGED_REQUEST): PCMC_TAGGED_CERT_REQUEST {.inline.} = self.union1.pTaggedCertRequest
proc pTaggedCertRequest*(self: var CMC_TAGGED_REQUEST): var PCMC_TAGGED_CERT_REQUEST {.inline.} = self.union1.pTaggedCertRequest
proc `dwFailInfo=`*(self: var CMC_STATUS_INFO, x: DWORD) {.inline.} = self.union1.dwFailInfo = x
proc dwFailInfo*(self: CMC_STATUS_INFO): DWORD {.inline.} = self.union1.dwFailInfo
proc dwFailInfo*(self: var CMC_STATUS_INFO): var DWORD {.inline.} = self.union1.dwFailInfo
proc `pPendInfo=`*(self: var CMC_STATUS_INFO, x: PCMC_PEND_INFO) {.inline.} = self.union1.pPendInfo = x
proc pPendInfo*(self: CMC_STATUS_INFO): PCMC_PEND_INFO {.inline.} = self.union1.pPendInfo
proc pPendInfo*(self: var CMC_STATUS_INFO): var PCMC_PEND_INFO {.inline.} = self.union1.pPendInfo
proc `dwNumBits=`*(self: var CERT_LOGOTYPE_IMAGE_INFO, x: DWORD) {.inline.} = self.union1.dwNumBits = x
proc dwNumBits*(self: CERT_LOGOTYPE_IMAGE_INFO): DWORD {.inline.} = self.union1.dwNumBits
proc dwNumBits*(self: var CERT_LOGOTYPE_IMAGE_INFO): var DWORD {.inline.} = self.union1.dwNumBits
proc `dwTableSize=`*(self: var CERT_LOGOTYPE_IMAGE_INFO, x: DWORD) {.inline.} = self.union1.dwTableSize = x
proc dwTableSize*(self: CERT_LOGOTYPE_IMAGE_INFO): DWORD {.inline.} = self.union1.dwTableSize
proc dwTableSize*(self: var CERT_LOGOTYPE_IMAGE_INFO): var DWORD {.inline.} = self.union1.dwTableSize
proc `pLogotypeDirectInfo=`*(self: var CERT_LOGOTYPE_INFO, x: PCERT_LOGOTYPE_DATA) {.inline.} = self.union1.pLogotypeDirectInfo = x
proc pLogotypeDirectInfo*(self: CERT_LOGOTYPE_INFO): PCERT_LOGOTYPE_DATA {.inline.} = self.union1.pLogotypeDirectInfo
proc pLogotypeDirectInfo*(self: var CERT_LOGOTYPE_INFO): var PCERT_LOGOTYPE_DATA {.inline.} = self.union1.pLogotypeDirectInfo
proc `pLogotypeIndirectInfo=`*(self: var CERT_LOGOTYPE_INFO, x: PCERT_LOGOTYPE_REFERENCE) {.inline.} = self.union1.pLogotypeIndirectInfo = x
proc pLogotypeIndirectInfo*(self: CERT_LOGOTYPE_INFO): PCERT_LOGOTYPE_REFERENCE {.inline.} = self.union1.pLogotypeIndirectInfo
proc pLogotypeIndirectInfo*(self: var CERT_LOGOTYPE_INFO): var PCERT_LOGOTYPE_REFERENCE {.inline.} = self.union1.pLogotypeIndirectInfo
proc `dwPredefined=`*(self: var CERT_BIOMETRIC_DATA, x: DWORD) {.inline.} = self.union1.dwPredefined = x
proc dwPredefined*(self: CERT_BIOMETRIC_DATA): DWORD {.inline.} = self.union1.dwPredefined
proc dwPredefined*(self: var CERT_BIOMETRIC_DATA): var DWORD {.inline.} = self.union1.dwPredefined
proc `pszObjId=`*(self: var CERT_BIOMETRIC_DATA, x: LPSTR) {.inline.} = self.union1.pszObjId = x
proc pszObjId*(self: CERT_BIOMETRIC_DATA): LPSTR {.inline.} = self.union1.pszObjId
proc pszObjId*(self: var CERT_BIOMETRIC_DATA): var LPSTR {.inline.} = self.union1.pszObjId
proc `pRevokedInfo=`*(self: var OCSP_BASIC_RESPONSE_ENTRY, x: POCSP_BASIC_REVOKED_INFO) {.inline.} = self.union1.pRevokedInfo = x
proc pRevokedInfo*(self: OCSP_BASIC_RESPONSE_ENTRY): POCSP_BASIC_REVOKED_INFO {.inline.} = self.union1.pRevokedInfo
proc pRevokedInfo*(self: var OCSP_BASIC_RESPONSE_ENTRY): var POCSP_BASIC_REVOKED_INFO {.inline.} = self.union1.pRevokedInfo
proc `ByNameResponderId=`*(self: var OCSP_BASIC_RESPONSE_INFO, x: CERT_NAME_BLOB) {.inline.} = self.union1.ByNameResponderId = x
proc ByNameResponderId*(self: OCSP_BASIC_RESPONSE_INFO): CERT_NAME_BLOB {.inline.} = self.union1.ByNameResponderId
proc ByNameResponderId*(self: var OCSP_BASIC_RESPONSE_INFO): var CERT_NAME_BLOB {.inline.} = self.union1.ByNameResponderId
proc `ByKeyResponderId=`*(self: var OCSP_BASIC_RESPONSE_INFO, x: CRYPT_HASH_BLOB) {.inline.} = self.union1.ByKeyResponderId = x
proc ByKeyResponderId*(self: OCSP_BASIC_RESPONSE_INFO): CRYPT_HASH_BLOB {.inline.} = self.union1.ByKeyResponderId
proc ByKeyResponderId*(self: var OCSP_BASIC_RESPONSE_INFO): var CRYPT_HASH_BLOB {.inline.} = self.union1.ByKeyResponderId
proc `dwValue=`*(self: var CRYPT_OID_INFO, x: DWORD) {.inline.} = self.union1.dwValue = x
proc dwValue*(self: CRYPT_OID_INFO): DWORD {.inline.} = self.union1.dwValue
proc dwValue*(self: var CRYPT_OID_INFO): var DWORD {.inline.} = self.union1.dwValue
proc `Algid=`*(self: var CRYPT_OID_INFO, x: ALG_ID) {.inline.} = self.union1.Algid = x
proc algid*(self: CRYPT_OID_INFO): ALG_ID {.inline.} = self.union1.Algid
proc algid*(self: var CRYPT_OID_INFO): var ALG_ID {.inline.} = self.union1.Algid
proc `dwLength=`*(self: var CRYPT_OID_INFO, x: DWORD) {.inline.} = self.union1.dwLength = x
proc dwLength*(self: CRYPT_OID_INFO): DWORD {.inline.} = self.union1.dwLength
proc dwLength*(self: var CRYPT_OID_INFO): var DWORD {.inline.} = self.union1.dwLength
proc `pvInfo=`*(self: var CERT_STRONG_SIGN_PARA, x: pointer) {.inline.} = self.union1.pvInfo = x
proc pvInfo*(self: CERT_STRONG_SIGN_PARA): pointer {.inline.} = self.union1.pvInfo
proc pvInfo*(self: var CERT_STRONG_SIGN_PARA): var pointer {.inline.} = self.union1.pvInfo
proc `pSerializedInfo=`*(self: var CERT_STRONG_SIGN_PARA, x: PCERT_STRONG_SIGN_SERIALIZED_INFO) {.inline.} = self.union1.pSerializedInfo = x
proc pSerializedInfo*(self: CERT_STRONG_SIGN_PARA): PCERT_STRONG_SIGN_SERIALIZED_INFO {.inline.} = self.union1.pSerializedInfo
proc pSerializedInfo*(self: var CERT_STRONG_SIGN_PARA): var PCERT_STRONG_SIGN_SERIALIZED_INFO {.inline.} = self.union1.pSerializedInfo
proc `pszOID=`*(self: var CERT_STRONG_SIGN_PARA, x: LPSTR) {.inline.} = self.union1.pszOID = x
proc pszOID*(self: CERT_STRONG_SIGN_PARA): LPSTR {.inline.} = self.union1.pszOID
proc pszOID*(self: var CERT_STRONG_SIGN_PARA): var LPSTR {.inline.} = self.union1.pszOID
proc `IssuerSerialNumber=`*(self: var CERT_ID, x: CERT_ISSUER_SERIAL_NUMBER) {.inline.} = self.union1.IssuerSerialNumber = x
proc IssuerSerialNumber*(self: CERT_ID): CERT_ISSUER_SERIAL_NUMBER {.inline.} = self.union1.IssuerSerialNumber
proc IssuerSerialNumber*(self: var CERT_ID): var CERT_ISSUER_SERIAL_NUMBER {.inline.} = self.union1.IssuerSerialNumber
proc `KeyId=`*(self: var CERT_ID, x: CRYPT_HASH_BLOB) {.inline.} = self.union1.KeyId = x
proc KeyId*(self: CERT_ID): CRYPT_HASH_BLOB {.inline.} = self.union1.KeyId
proc KeyId*(self: var CERT_ID): var CRYPT_HASH_BLOB {.inline.} = self.union1.KeyId
proc `HashId=`*(self: var CERT_ID, x: CRYPT_HASH_BLOB) {.inline.} = self.union1.HashId = x
proc HashId*(self: CERT_ID): CRYPT_HASH_BLOB {.inline.} = self.union1.HashId
proc HashId*(self: var CERT_ID): var CRYPT_HASH_BLOB {.inline.} = self.union1.HashId
proc `hCryptProv=`*(self: var CMSG_SIGNER_ENCODE_INFO, x: HCRYPTPROV) {.inline.} = self.union1.hCryptProv = x
proc hCryptProv*(self: CMSG_SIGNER_ENCODE_INFO): HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc hCryptProv*(self: var CMSG_SIGNER_ENCODE_INFO): var HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc `hNCryptKey=`*(self: var CMSG_SIGNER_ENCODE_INFO, x: NCRYPT_KEY_HANDLE) {.inline.} = self.union1.hNCryptKey = x
proc hNCryptKey*(self: CMSG_SIGNER_ENCODE_INFO): NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc hNCryptKey*(self: var CMSG_SIGNER_ENCODE_INFO): var NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc `pEphemeralAlgorithm=`*(self: var CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO, x: PCRYPT_ALGORITHM_IDENTIFIER) {.inline.} = self.union1.pEphemeralAlgorithm = x
proc pEphemeralAlgorithm*(self: CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO): PCRYPT_ALGORITHM_IDENTIFIER {.inline.} = self.union1.pEphemeralAlgorithm
proc pEphemeralAlgorithm*(self: var CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO): var PCRYPT_ALGORITHM_IDENTIFIER {.inline.} = self.union1.pEphemeralAlgorithm
proc `pSenderId=`*(self: var CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO, x: PCERT_ID) {.inline.} = self.union1.pSenderId = x
proc pSenderId*(self: CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO): PCERT_ID {.inline.} = self.union1.pSenderId
proc pSenderId*(self: var CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO): var PCERT_ID {.inline.} = self.union1.pSenderId
proc `hKeyEncryptionKey=`*(self: var CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO, x: HCRYPTKEY) {.inline.} = self.union1.hKeyEncryptionKey = x
proc hKeyEncryptionKey*(self: CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO): HCRYPTKEY {.inline.} = self.union1.hKeyEncryptionKey
proc hKeyEncryptionKey*(self: var CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO): var HCRYPTKEY {.inline.} = self.union1.hKeyEncryptionKey
proc `pvKeyEncryptionKey=`*(self: var CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO, x: pointer) {.inline.} = self.union1.pvKeyEncryptionKey = x
proc pvKeyEncryptionKey*(self: CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO): pointer {.inline.} = self.union1.pvKeyEncryptionKey
proc pvKeyEncryptionKey*(self: var CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO): var pointer {.inline.} = self.union1.pvKeyEncryptionKey
proc `pKeyTrans=`*(self: var CMSG_RECIPIENT_ENCODE_INFO, x: PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO) {.inline.} = self.union1.pKeyTrans = x
proc pKeyTrans*(self: CMSG_RECIPIENT_ENCODE_INFO): PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO {.inline.} = self.union1.pKeyTrans
proc pKeyTrans*(self: var CMSG_RECIPIENT_ENCODE_INFO): var PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO {.inline.} = self.union1.pKeyTrans
proc `pKeyAgree=`*(self: var CMSG_RECIPIENT_ENCODE_INFO, x: PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO) {.inline.} = self.union1.pKeyAgree = x
proc pKeyAgree*(self: CMSG_RECIPIENT_ENCODE_INFO): PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO {.inline.} = self.union1.pKeyAgree
proc pKeyAgree*(self: var CMSG_RECIPIENT_ENCODE_INFO): var PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO {.inline.} = self.union1.pKeyAgree
proc `pMailList=`*(self: var CMSG_RECIPIENT_ENCODE_INFO, x: PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO) {.inline.} = self.union1.pMailList = x
proc pMailList*(self: CMSG_RECIPIENT_ENCODE_INFO): PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO {.inline.} = self.union1.pMailList
proc pMailList*(self: var CMSG_RECIPIENT_ENCODE_INFO): var PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO {.inline.} = self.union1.pMailList
proc `OriginatorCertId=`*(self: var CMSG_KEY_AGREE_RECIPIENT_INFO, x: CERT_ID) {.inline.} = self.union1.OriginatorCertId = x
proc OriginatorCertId*(self: CMSG_KEY_AGREE_RECIPIENT_INFO): CERT_ID {.inline.} = self.union1.OriginatorCertId
proc OriginatorCertId*(self: var CMSG_KEY_AGREE_RECIPIENT_INFO): var CERT_ID {.inline.} = self.union1.OriginatorCertId
proc `OriginatorPublicKeyInfo=`*(self: var CMSG_KEY_AGREE_RECIPIENT_INFO, x: CERT_PUBLIC_KEY_INFO) {.inline.} = self.union1.OriginatorPublicKeyInfo = x
proc OriginatorPublicKeyInfo*(self: CMSG_KEY_AGREE_RECIPIENT_INFO): CERT_PUBLIC_KEY_INFO {.inline.} = self.union1.OriginatorPublicKeyInfo
proc OriginatorPublicKeyInfo*(self: var CMSG_KEY_AGREE_RECIPIENT_INFO): var CERT_PUBLIC_KEY_INFO {.inline.} = self.union1.OriginatorPublicKeyInfo
proc `pKeyTrans=`*(self: var CMSG_CMS_RECIPIENT_INFO, x: PCMSG_KEY_TRANS_RECIPIENT_INFO) {.inline.} = self.union1.pKeyTrans = x
proc pKeyTrans*(self: CMSG_CMS_RECIPIENT_INFO): PCMSG_KEY_TRANS_RECIPIENT_INFO {.inline.} = self.union1.pKeyTrans
proc pKeyTrans*(self: var CMSG_CMS_RECIPIENT_INFO): var PCMSG_KEY_TRANS_RECIPIENT_INFO {.inline.} = self.union1.pKeyTrans
proc `pKeyAgree=`*(self: var CMSG_CMS_RECIPIENT_INFO, x: PCMSG_KEY_AGREE_RECIPIENT_INFO) {.inline.} = self.union1.pKeyAgree = x
proc pKeyAgree*(self: CMSG_CMS_RECIPIENT_INFO): PCMSG_KEY_AGREE_RECIPIENT_INFO {.inline.} = self.union1.pKeyAgree
proc pKeyAgree*(self: var CMSG_CMS_RECIPIENT_INFO): var PCMSG_KEY_AGREE_RECIPIENT_INFO {.inline.} = self.union1.pKeyAgree
proc `pMailList=`*(self: var CMSG_CMS_RECIPIENT_INFO, x: PCMSG_MAIL_LIST_RECIPIENT_INFO) {.inline.} = self.union1.pMailList = x
proc pMailList*(self: CMSG_CMS_RECIPIENT_INFO): PCMSG_MAIL_LIST_RECIPIENT_INFO {.inline.} = self.union1.pMailList
proc pMailList*(self: var CMSG_CMS_RECIPIENT_INFO): var PCMSG_MAIL_LIST_RECIPIENT_INFO {.inline.} = self.union1.pMailList
proc `hCryptProv=`*(self: var CMSG_CTRL_DECRYPT_PARA, x: HCRYPTPROV) {.inline.} = self.union1.hCryptProv = x
proc hCryptProv*(self: CMSG_CTRL_DECRYPT_PARA): HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc hCryptProv*(self: var CMSG_CTRL_DECRYPT_PARA): var HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc `hNCryptKey=`*(self: var CMSG_CTRL_DECRYPT_PARA, x: NCRYPT_KEY_HANDLE) {.inline.} = self.union1.hNCryptKey = x
proc hNCryptKey*(self: CMSG_CTRL_DECRYPT_PARA): NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc hNCryptKey*(self: var CMSG_CTRL_DECRYPT_PARA): var NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc `hCryptProv=`*(self: var CMSG_CTRL_KEY_TRANS_DECRYPT_PARA, x: HCRYPTPROV) {.inline.} = self.union1.hCryptProv = x
proc hCryptProv*(self: CMSG_CTRL_KEY_TRANS_DECRYPT_PARA): HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc hCryptProv*(self: var CMSG_CTRL_KEY_TRANS_DECRYPT_PARA): var HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc `hNCryptKey=`*(self: var CMSG_CTRL_KEY_TRANS_DECRYPT_PARA, x: NCRYPT_KEY_HANDLE) {.inline.} = self.union1.hNCryptKey = x
proc hNCryptKey*(self: CMSG_CTRL_KEY_TRANS_DECRYPT_PARA): NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc hNCryptKey*(self: var CMSG_CTRL_KEY_TRANS_DECRYPT_PARA): var NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc `hCryptProv=`*(self: var CMSG_CTRL_KEY_AGREE_DECRYPT_PARA, x: HCRYPTPROV) {.inline.} = self.union1.hCryptProv = x
proc hCryptProv*(self: CMSG_CTRL_KEY_AGREE_DECRYPT_PARA): HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc hCryptProv*(self: var CMSG_CTRL_KEY_AGREE_DECRYPT_PARA): var HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc `hNCryptKey=`*(self: var CMSG_CTRL_KEY_AGREE_DECRYPT_PARA, x: NCRYPT_KEY_HANDLE) {.inline.} = self.union1.hNCryptKey = x
proc hNCryptKey*(self: CMSG_CTRL_KEY_AGREE_DECRYPT_PARA): NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc hNCryptKey*(self: var CMSG_CTRL_KEY_AGREE_DECRYPT_PARA): var NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc `hKeyEncryptionKey=`*(self: var CMSG_CTRL_MAIL_LIST_DECRYPT_PARA, x: HCRYPTKEY) {.inline.} = self.union1.hKeyEncryptionKey = x
proc hKeyEncryptionKey*(self: CMSG_CTRL_MAIL_LIST_DECRYPT_PARA): HCRYPTKEY {.inline.} = self.union1.hKeyEncryptionKey
proc hKeyEncryptionKey*(self: var CMSG_CTRL_MAIL_LIST_DECRYPT_PARA): var HCRYPTKEY {.inline.} = self.union1.hKeyEncryptionKey
proc `pvKeyEncryptionKey=`*(self: var CMSG_CTRL_MAIL_LIST_DECRYPT_PARA, x: pointer) {.inline.} = self.union1.pvKeyEncryptionKey = x
proc pvKeyEncryptionKey*(self: CMSG_CTRL_MAIL_LIST_DECRYPT_PARA): pointer {.inline.} = self.union1.pvKeyEncryptionKey
proc pvKeyEncryptionKey*(self: var CMSG_CTRL_MAIL_LIST_DECRYPT_PARA): var pointer {.inline.} = self.union1.pvKeyEncryptionKey
proc `hContentEncryptKey=`*(self: var CMSG_CONTENT_ENCRYPT_INFO, x: HCRYPTKEY) {.inline.} = self.union1.hContentEncryptKey = x
proc hContentEncryptKey*(self: CMSG_CONTENT_ENCRYPT_INFO): HCRYPTKEY {.inline.} = self.union1.hContentEncryptKey
proc hContentEncryptKey*(self: var CMSG_CONTENT_ENCRYPT_INFO): var HCRYPTKEY {.inline.} = self.union1.hContentEncryptKey
proc `hCNGContentEncryptKey=`*(self: var CMSG_CONTENT_ENCRYPT_INFO, x: BCRYPT_KEY_HANDLE) {.inline.} = self.union1.hCNGContentEncryptKey = x
proc hCNGContentEncryptKey*(self: CMSG_CONTENT_ENCRYPT_INFO): BCRYPT_KEY_HANDLE {.inline.} = self.union1.hCNGContentEncryptKey
proc hCNGContentEncryptKey*(self: var CMSG_CONTENT_ENCRYPT_INFO): var BCRYPT_KEY_HANDLE {.inline.} = self.union1.hCNGContentEncryptKey
proc `OriginatorCertId=`*(self: var CMSG_KEY_AGREE_ENCRYPT_INFO, x: CERT_ID) {.inline.} = self.union1.OriginatorCertId = x
proc OriginatorCertId*(self: CMSG_KEY_AGREE_ENCRYPT_INFO): CERT_ID {.inline.} = self.union1.OriginatorCertId
proc OriginatorCertId*(self: var CMSG_KEY_AGREE_ENCRYPT_INFO): var CERT_ID {.inline.} = self.union1.OriginatorCertId
proc `OriginatorPublicKeyInfo=`*(self: var CMSG_KEY_AGREE_ENCRYPT_INFO, x: CERT_PUBLIC_KEY_INFO) {.inline.} = self.union1.OriginatorPublicKeyInfo = x
proc OriginatorPublicKeyInfo*(self: CMSG_KEY_AGREE_ENCRYPT_INFO): CERT_PUBLIC_KEY_INFO {.inline.} = self.union1.OriginatorPublicKeyInfo
proc OriginatorPublicKeyInfo*(self: var CMSG_KEY_AGREE_ENCRYPT_INFO): var CERT_PUBLIC_KEY_INFO {.inline.} = self.union1.OriginatorPublicKeyInfo
proc `hCryptProv=`*(self: var CERT_KEY_CONTEXT, x: HCRYPTPROV) {.inline.} = self.union1.hCryptProv = x
proc hCryptProv*(self: CERT_KEY_CONTEXT): HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc hCryptProv*(self: var CERT_KEY_CONTEXT): var HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc `hNCryptKey=`*(self: var CERT_KEY_CONTEXT, x: NCRYPT_KEY_HANDLE) {.inline.} = self.union1.hNCryptKey = x
proc hNCryptKey*(self: CERT_KEY_CONTEXT): NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc hNCryptKey*(self: var CERT_KEY_CONTEXT): var NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc `hKeyBase=`*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA, x: HKEY) {.inline.} = self.union1.hKeyBase = x
proc hKeyBase*(self: CERT_SYSTEM_STORE_RELOCATE_PARA): HKEY {.inline.} = self.union1.hKeyBase
proc hKeyBase*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA): var HKEY {.inline.} = self.union1.hKeyBase
proc `pvBase=`*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA, x: pointer) {.inline.} = self.union1.pvBase = x
proc pvBase*(self: CERT_SYSTEM_STORE_RELOCATE_PARA): pointer {.inline.} = self.union1.pvBase
proc pvBase*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA): var pointer {.inline.} = self.union1.pvBase
proc `pvSystemStore=`*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA, x: pointer) {.inline.} = self.union2.pvSystemStore = x
proc pvSystemStore*(self: CERT_SYSTEM_STORE_RELOCATE_PARA): pointer {.inline.} = self.union2.pvSystemStore
proc pvSystemStore*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA): var pointer {.inline.} = self.union2.pvSystemStore
proc `pszSystemStore=`*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA, x: LPCSTR) {.inline.} = self.union2.pszSystemStore = x
proc pszSystemStore*(self: CERT_SYSTEM_STORE_RELOCATE_PARA): LPCSTR {.inline.} = self.union2.pszSystemStore
proc pszSystemStore*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA): var LPCSTR {.inline.} = self.union2.pszSystemStore
proc `pwszSystemStore=`*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA, x: LPCWSTR) {.inline.} = self.union2.pwszSystemStore = x
proc pwszSystemStore*(self: CERT_SYSTEM_STORE_RELOCATE_PARA): LPCWSTR {.inline.} = self.union2.pwszSystemStore
proc pwszSystemStore*(self: var CERT_SYSTEM_STORE_RELOCATE_PARA): var LPCWSTR {.inline.} = self.union2.pwszSystemStore
proc `hCryptProv=`*(self: var CRYPT_KEY_SIGN_MESSAGE_PARA, x: HCRYPTPROV) {.inline.} = self.union1.hCryptProv = x
proc hCryptProv*(self: CRYPT_KEY_SIGN_MESSAGE_PARA): HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc hCryptProv*(self: var CRYPT_KEY_SIGN_MESSAGE_PARA): var HCRYPTPROV {.inline.} = self.union1.hCryptProv
proc `hNCryptKey=`*(self: var CRYPT_KEY_SIGN_MESSAGE_PARA, x: NCRYPT_KEY_HANDLE) {.inline.} = self.union1.hNCryptKey = x
proc hNCryptKey*(self: CRYPT_KEY_SIGN_MESSAGE_PARA): NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc hNCryptKey*(self: var CRYPT_KEY_SIGN_MESSAGE_PARA): var NCRYPT_KEY_HANDLE {.inline.} = self.union1.hNCryptKey
proc `cbStruct=`*(self: var HTTPSPolicyCallbackData, x: DWORD) {.inline.} = self.union1.cbStruct = x
proc cbStruct*(self: HTTPSPolicyCallbackData): DWORD {.inline.} = self.union1.cbStruct
proc cbStruct*(self: var HTTPSPolicyCallbackData): var DWORD {.inline.} = self.union1.cbStruct
proc `cbSize=`*(self: var HTTPSPolicyCallbackData, x: DWORD) {.inline.} = self.union1.cbSize = x
proc cbSize*(self: HTTPSPolicyCallbackData): DWORD {.inline.} = self.union1.cbSize
proc cbSize*(self: var HTTPSPolicyCallbackData): var DWORD {.inline.} = self.union1.cbSize
when winimUnicode:
  type
    CRYPT_PASSWORD_CREDENTIALS* = CRYPT_PASSWORD_CREDENTIALSW
    PCRYPT_PASSWORD_CREDENTIALS* = PCRYPT_PASSWORD_CREDENTIALSW
  const
    MS_DEF_PROV* = MS_DEF_PROV_W
    MS_ENHANCED_PROV* = MS_ENHANCED_PROV_W
    MS_STRONG_PROV* = MS_STRONG_PROV_W
    MS_DEF_RSA_SIG_PROV* = MS_DEF_RSA_SIG_PROV_W
    MS_DEF_RSA_SCHANNEL_PROV* = MS_DEF_RSA_SCHANNEL_PROV_W
    MS_DEF_DSS_PROV* = MS_DEF_DSS_PROV_W
    MS_DEF_DSS_DH_PROV* = MS_DEF_DSS_DH_PROV_W
    MS_ENH_DSS_DH_PROV* = MS_ENH_DSS_DH_PROV_W
    MS_DEF_DH_SCHANNEL_PROV* = MS_DEF_DH_SCHANNEL_PROV_W
    MS_SCARD_PROV* = MS_SCARD_PROV_W
    MS_ENH_RSA_AES_PROV_XP* = MS_ENH_RSA_AES_PROV_XP_W
    MS_ENH_RSA_AES_PROV* = MS_ENH_RSA_AES_PROV_W
    CREDENTIAL_OID_PASSWORD_CREDENTIALS* = CREDENTIAL_OID_PASSWORD_CREDENTIALS_W
  proc CryptAcquireContext*(phProv: ptr HCRYPTPROV, szContainer: LPCWSTR, szProvider: LPCWSTR, dwProvType: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptAcquireContextW".}
  proc CryptSignHash*(hHash: HCRYPTHASH, dwKeySpec: DWORD, szDescription: LPCWSTR, dwFlags: DWORD, pbSignature: ptr BYTE, pdwSigLen: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptSignHashW".}
  proc CryptVerifySignature*(hHash: HCRYPTHASH, pbSignature: ptr BYTE, dwSigLen: DWORD, hPubKey: HCRYPTKEY, szDescription: LPCWSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptVerifySignatureW".}
  proc CryptSetProvider*(pszProvName: LPCWSTR, dwProvType: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptSetProviderW".}
  proc CryptSetProviderEx*(pszProvName: LPCWSTR, dwProvType: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptSetProviderExW".}
  proc CryptGetDefaultProvider*(dwProvType: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pszProvName: LPWSTR, pcbProvName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptGetDefaultProviderW".}
  proc CryptEnumProviderTypes*(dwIndex: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pdwProvType: ptr DWORD, szTypeName: LPWSTR, pcbTypeName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptEnumProviderTypesW".}
  proc CryptEnumProviders*(dwIndex: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pdwProvType: ptr DWORD, szProvName: LPWSTR, pcbProvName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptEnumProvidersW".}
  proc CertRDNValueToStr*(dwValueType: DWORD, pValue: PCERT_RDN_VALUE_BLOB, psz: LPWSTR, csz: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc: "CertRDNValueToStrW".}
  proc CertNameToStr*(dwCertEncodingType: DWORD, pName: PCERT_NAME_BLOB, dwStrType: DWORD, psz: LPWSTR, csz: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc: "CertNameToStrW".}
  proc CertStrToName*(dwCertEncodingType: DWORD, pszX500: LPCWSTR, dwStrType: DWORD, pvReserved: pointer, pbEncoded: ptr BYTE, pcbEncoded: ptr DWORD, ppszError: ptr LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc: "CertStrToNameW".}
  proc CertGetNameString*(pCertContext: PCCERT_CONTEXT, dwType: DWORD, dwFlags: DWORD, pvTypePara: pointer, pszNameString: LPWSTR, cchNameString: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc: "CertGetNameStringW".}
  proc CertOpenSystemStore*(hProv: HCRYPTPROV_LEGACY, szSubsystemProtocol: LPCWSTR): HCERTSTORE {.winapi, stdcall, dynlib: "crypt32", importc: "CertOpenSystemStoreW".}
  proc CertAddEncodedCertificateToSystemStore*(szCertStoreName: LPCWSTR, pbCertEncoded: ptr BYTE, cbCertEncoded: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc: "CertAddEncodedCertificateToSystemStoreW".}
  proc CryptRetrieveObjectByUrl*(pszUrl: LPCWSTR, pszObjectOid: LPCSTR, dwRetrievalFlags: DWORD, dwTimeout: DWORD, ppvObject: ptr LPVOID, hAsyncRetrieve: HCRYPTASYNC, pCredentials: PCRYPT_CREDENTIALS, pvVerify: LPVOID, pAuxInfo: PCRYPT_RETRIEVE_AUX_INFO): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc: "CryptRetrieveObjectByUrlW".}
  proc CryptStringToBinary*(pszString: LPCWSTR, cchString: DWORD, dwFlags: DWORD, pbBinary: ptr BYTE, pcbBinary: ptr DWORD, pdwSkip: ptr DWORD, pdwFlags: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc: "CryptStringToBinaryW".}
  proc CryptBinaryToString*(pbBinary: ptr BYTE, cbBinary: DWORD, dwFlags: DWORD, pszString: LPWSTR, pcchString: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc: "CryptBinaryToStringW".}
when winimAnsi:
  type
    CRYPT_PASSWORD_CREDENTIALS* = CRYPT_PASSWORD_CREDENTIALSA
    PCRYPT_PASSWORD_CREDENTIALS* = PCRYPT_PASSWORD_CREDENTIALSA
  const
    MS_DEF_PROV* = MS_DEF_PROV_A
    MS_ENHANCED_PROV* = MS_ENHANCED_PROV_A
    MS_STRONG_PROV* = MS_STRONG_PROV_A
    MS_DEF_RSA_SIG_PROV* = MS_DEF_RSA_SIG_PROV_A
    MS_DEF_RSA_SCHANNEL_PROV* = MS_DEF_RSA_SCHANNEL_PROV_A
    MS_DEF_DSS_PROV* = MS_DEF_DSS_PROV_A
    MS_DEF_DSS_DH_PROV* = MS_DEF_DSS_DH_PROV_A
    MS_ENH_DSS_DH_PROV* = MS_ENH_DSS_DH_PROV_A
    MS_DEF_DH_SCHANNEL_PROV* = MS_DEF_DH_SCHANNEL_PROV_A
    MS_SCARD_PROV* = MS_SCARD_PROV_A
    MS_ENH_RSA_AES_PROV_XP* = MS_ENH_RSA_AES_PROV_XP_A
    MS_ENH_RSA_AES_PROV* = MS_ENH_RSA_AES_PROV_A
    CREDENTIAL_OID_PASSWORD_CREDENTIALS* = CREDENTIAL_OID_PASSWORD_CREDENTIALS_A
  proc CryptAcquireContext*(phProv: ptr HCRYPTPROV, szContainer: LPCSTR, szProvider: LPCSTR, dwProvType: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptAcquireContextA".}
  proc CryptSignHash*(hHash: HCRYPTHASH, dwKeySpec: DWORD, szDescription: LPCSTR, dwFlags: DWORD, pbSignature: ptr BYTE, pdwSigLen: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptSignHashA".}
  proc CryptVerifySignature*(hHash: HCRYPTHASH, pbSignature: ptr BYTE, dwSigLen: DWORD, hPubKey: HCRYPTKEY, szDescription: LPCSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptVerifySignatureA".}
  proc CryptSetProvider*(pszProvName: LPCSTR, dwProvType: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptSetProviderA".}
  proc CryptSetProviderEx*(pszProvName: LPCSTR, dwProvType: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptSetProviderExA".}
  proc CryptGetDefaultProvider*(dwProvType: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pszProvName: LPSTR, pcbProvName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptGetDefaultProviderA".}
  proc CryptEnumProviderTypes*(dwIndex: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pdwProvType: ptr DWORD, szTypeName: LPSTR, pcbTypeName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptEnumProviderTypesA".}
  proc CryptEnumProviders*(dwIndex: DWORD, pdwReserved: ptr DWORD, dwFlags: DWORD, pdwProvType: ptr DWORD, szProvName: LPSTR, pcbProvName: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CryptEnumProvidersA".}
  proc CertRDNValueToStr*(dwValueType: DWORD, pValue: PCERT_RDN_VALUE_BLOB, psz: LPSTR, csz: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc: "CertRDNValueToStrA".}
  proc CertNameToStr*(dwCertEncodingType: DWORD, pName: PCERT_NAME_BLOB, dwStrType: DWORD, psz: LPSTR, csz: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc: "CertNameToStrA".}
  proc CertStrToName*(dwCertEncodingType: DWORD, pszX500: LPCSTR, dwStrType: DWORD, pvReserved: pointer, pbEncoded: ptr BYTE, pcbEncoded: ptr DWORD, ppszError: ptr LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc: "CertStrToNameA".}
  proc CertGetNameString*(pCertContext: PCCERT_CONTEXT, dwType: DWORD, dwFlags: DWORD, pvTypePara: pointer, pszNameString: LPSTR, cchNameString: DWORD): DWORD {.winapi, stdcall, dynlib: "crypt32", importc: "CertGetNameStringA".}
  proc CertOpenSystemStore*(hProv: HCRYPTPROV_LEGACY, szSubsystemProtocol: LPCSTR): HCERTSTORE {.winapi, stdcall, dynlib: "crypt32", importc: "CertOpenSystemStoreA".}
  proc CertAddEncodedCertificateToSystemStore*(szCertStoreName: LPCSTR, pbCertEncoded: ptr BYTE, cbCertEncoded: DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc: "CertAddEncodedCertificateToSystemStoreA".}
  proc CryptRetrieveObjectByUrl*(pszUrl: LPCSTR, pszObjectOid: LPCSTR, dwRetrievalFlags: DWORD, dwTimeout: DWORD, ppvObject: ptr LPVOID, hAsyncRetrieve: HCRYPTASYNC, pCredentials: PCRYPT_CREDENTIALS, pvVerify: LPVOID, pAuxInfo: PCRYPT_RETRIEVE_AUX_INFO): WINBOOL {.winapi, stdcall, dynlib: "cryptnet", importc: "CryptRetrieveObjectByUrlA".}
  proc CryptStringToBinary*(pszString: LPCSTR, cchString: DWORD, dwFlags: DWORD, pbBinary: ptr BYTE, pcbBinary: ptr DWORD, pdwSkip: ptr DWORD, pdwFlags: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc: "CryptStringToBinaryA".}
  proc CryptBinaryToString*(pbBinary: ptr BYTE, cbBinary: DWORD, dwFlags: DWORD, pszString: LPSTR, pcchString: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "crypt32", importc: "CryptBinaryToStringA".}
