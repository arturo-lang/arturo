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
import wingdi
import winuser
import winsock
#include <objbase.h>
#include <combaseapi.h>
#include <wtypesbase.h>
#include <ole2.h>
#include <oleauto.h>
#include <oaidl.h>
#include <objidl.h>
#include <unknwn.h>
#include <wtypes.h>
#include <oleidl.h>
#include <unknwnbase.h>
#include <objidlbase.h>
#include <urlmon.h>
#include <servprov.h>
#include <msxml.h>
#include <propidl.h>
#include <ocidl.h>
#include <comcat.h>
#include <shtypes.h>
#include <exdisp.h>
#include <docobj.h>
#include <exdispid.h>
#include <propsys.h>
#include <structuredquerycondition.h>
#include <propkeydef.h>
type
  REGCLS* = int32
  COINITBASE* = int32
  DVASPECT* = int32
  STGC* = int32
  STGMOVE* = int32
  STATFLAG* = int32
  VARTYPE* = uint16
  VARENUM* = int32
  TYSPEC* = int32
  EXTCONN* = int32
  STGTY* = int32
  STREAM_SEEK* = int32
  LOCKTYPE* = int32
  EOLE_AUTHENTICATION_CAPABILITIES* = int32
  RPCOPT_PROPERTIES* = int32
  RPCOPT_SERVER_LOCALITY_VALUES* = int32
  GLOBALOPT_PROPERTIES* = int32
  GLOBALOPT_EH_VALUES* = int32
  GLOBALOPT_RPCTP_VALUES* = int32
  GLOBALOPT_RO_FLAGS* = int32
  GLOBALOPT_UNMARSHALING_POLICY_VALUES* = int32
  DCOM_CALL_STATE* = int32
  APTTYPEQUALIFIER* = int32
  APTTYPE* = int32
  THDTYPE* = int32
  CO_MARSHALING_CONTEXT_ATTRIBUTES* = int32
  BIND_FLAGS* = int32
  MKSYS* = int32
  MKRREDUCE* = int32
  ADVF* = int32
  TYMED* = int32
  DATADIR* = int32
  CALLTYPE* = int32
  SERVERCALL* = int32
  PENDINGTYPE* = int32
  PENDINGMSG* = int32
  ApplicationType* = int32
  ShutdownType* = int32
  SF_TYPE* = int32
  TYPEKIND* = int32
  CALLCONV* = int32
  FUNCKIND* = int32
  INVOKEKIND* = int32
  VARKIND* = int32
  TYPEFLAGS* = int32
  FUNCFLAGS* = int32
  VARFLAGS* = int32
  DESCKIND* = int32
  SYSKIND* = int32
  LIBFLAGS* = int32
  CHANGEKIND* = int32
  REGKIND* = int32
  OLEGETMONIKER* = int32
  OLEWHICHMK* = int32
  USERCLASSTYPE* = int32
  OLEMISC* = int32
  OLECLOSE* = int32
  OLERENDER* = int32
  OLEUPDATE* = int32
  OLELINKBIND* = int32
  BINDSPEED* = int32
  OLECONTF* = int32
  OLEVERBATTRIB* = int32
  MEMCTX* = int32
  CLSCTX* = int32
  MSHLFLAGS* = int32
  MSHCTX* = int32
  STDMSHLFLAGS* = int32
  COWAIT_FLAGS* = int32
  CWMO_FLAGS* = int32
  COINIT* = int32
  COMSD* = int32
  DOMNodeType* = int32
  XMLELEM_TYPE* = int32
  MONIKERPROPERTY* = int32
  BINDVERB* = int32
  BINDINFOF* = int32
  BINDF* = int32
  URL_ENCODING* = int32
  BINDINFO_OPTIONS* = int32
  BSCF* = int32
  BINDSTATUS* = int32
  BINDF2* = int32
  AUTHENTICATEF* = int32
  CIP_STATUS* = int32
  Uri_PROPERTY* = int32
  Uri_HOST_TYPE* = int32
  BINDSTRING* = int32
  PI_FLAGS* = int32
  OIBDG_FLAGS* = int32
  PARSEACTION* = int32
  PSUACTION* = int32
  QUERYOPTION* = int32
  INTERNETFEATURELIST* = int32
  PUAF* = int32
  PUAFOUT* = int32
  SZM_FLAGS* = int32
  URLZONE* = int32
  URLTEMPLATE* = int32
  ZAFLAGS* = int32
  URLZONEREG* = int32
  BINDHANDLETYPES* = int32
  PIDMSI_STATUS_VALUE* = int32
  UASFLAGS* = int32
  READYSTATE* = int32
  GUIDKIND* = int32
  CTRLINFO* = int32
  XFORMCOORDS* = int32
  PROPPAGESTATUS* = int32
  PICTUREATTRIBUTES* = int32
  ACTIVATEFLAGS* = int32
  OLEDCFLAGS* = int32
  VIEWSTATUS* = int32
  HITRESULT* = int32
  DVASPECT2* = int32
  DVEXTENTMODE* = int32
  DVASPECTINFOFLAG* = int32
  POINTERINACTIVE* = int32
  PROPBAG2_TYPE* = int32
  QACONTAINERFLAGS* = int32
  STRRET_TYPE* = int32
  PERCEIVED* = int32
  SHCOLSTATE* = int32
  DEVICE_SCALE_FACTOR* = int32
  DOCMISC* = int32
  PRINTFLAG* = int32
  OLECMDF* = int32
  OLECMDTEXTF* = int32
  OLECMDEXECOPT* = int32
  OLECMDID* = int32
  MEDIAPLAYBACK_STATE* = int32
  IGNOREMIME* = int32
  WPCSETTING* = int32
  OLECMDID_REFRESHFLAG* = int32
  OLECMDID_PAGEACTIONFLAG* = int32
  OLECMDID_BROWSERSTATEFLAG* = int32
  OLECMDID_OPTICAL_ZOOMFLAG* = int32
  PAGEACTION_UI* = int32
  OLECMDID_WINDOWSTATE_FLAG* = int32
  OLECMDID_VIEWPORT_MODE_FLAG* = int32
  BrowserNavConstants* = int32
  RefreshConstants* = int32
  CommandStateChangeConstants* = int32
  SecureLockIconConstants* = int32
  ShellWindowTypeConstants* = int32
  ShellWindowFindWindowOptions* = int32
  CONDITION_TYPE* = int32
  CONDITION_OPERATION* = int32
  GETPROPERTYSTOREFLAGS* = int32
  PKA_FLAGS* = int32
  PSC_STATE* = int32
  PROPENUMTYPE* = int32
  PROPDESC_TYPE_FLAGS* = int32
  PROPDESC_VIEW_FLAGS* = int32
  PROPDESC_DISPLAYTYPE* = int32
  PROPDESC_GROUPING_RANGE* = int32
  PROPDESC_FORMAT_FLAGS* = int32
  PROPDESC_SORTDESCRIPTION* = int32
  PROPDESC_RELATIVEDESCRIPTION_TYPE* = int32
  PROPDESC_AGGREGATION_TYPE* = int32
  PROPDESC_CONDITION_TYPE* = int32
  PROPDESC_SEARCHINFO_FLAGS* = int32
  PROPDESC_COLUMNINDEX_TYPE* = int32
  PROPDESC_ENUMFILTER* = int32
  PERSIST_SPROPSTORE_FLAGS* = int32
  hyper* = int64
  CLIPFORMAT* = WORD
  PROPID* = ULONG
  RPCOLEDATAREP* = ULONG
  CPFLAGS* = DWORD
  APARTMENTID* = DWORD
  DISPID* = LONG
  HREFTYPE* = DWORD
  SCODE* = LONG
  CO_MTA_USAGE_COOKIE* = HANDLE
  STGFMT* = DWORD
  PROPVAR_PAD1* = WORD
  PROPVAR_PAD2* = WORD
  PROPVAR_PAD3* = WORD
  OLE_XPOS_HIMETRIC* = LONG
  OLE_YPOS_HIMETRIC* = LONG
  OLE_XSIZE_HIMETRIC* = LONG
  OLE_YSIZE_HIMETRIC* = LONG
  HHANDLE* = UINT_PTR
  OLE_COLOR* = DWORD
  PERCEIVEDFLAG* = DWORD
  KF_REDIRECT_FLAGS* = DWORD
  SHCOLSTATEF* = DWORD
  RPC_AUTH_IDENTITY_HANDLE* = HANDLE
  RPC_AUTHZ_HANDLE* = HANDLE
  HCONTEXT* = HANDLE
  HMETAFILEPICT* = HANDLE
  userCLIPFORMAT_u* {.pure, union.} = object
    dwValue*: DWORD
    pwszName*: ptr uint16
  userCLIPFORMAT* {.pure.} = object
    fContext*: LONG
    u*: userCLIPFORMAT_u
  wireCLIPFORMAT* = ptr userCLIPFORMAT
  FLAGGED_BYTE_BLOB* {.pure.} = object
    fFlags*: ULONG
    clSize*: ULONG
    abData*: array[1, uint8]
  userHGLOBAL_u* {.pure, union.} = object
    hInproc*: LONG
    hRemote*: ptr FLAGGED_BYTE_BLOB
    hInproc64*: INT64
  userHGLOBAL* {.pure.} = object
    fContext*: LONG
    padding*: array[4, byte]
    u*: userHGLOBAL_u
  wireHGLOBAL* = ptr userHGLOBAL
  RemotableHandle_u* {.pure, union.} = object
    hInproc*: LONG
    hRemote*: LONG
  RemotableHandle* {.pure.} = object
    fContext*: LONG
    u*: RemotableHandle_u
  wireHWND* = ptr RemotableHandle
  wireHMENU* = ptr RemotableHandle
  wireHACCEL* = ptr RemotableHandle
  wireHBRUSH* = ptr RemotableHandle
  wireHFONT* = ptr RemotableHandle
  wireHDC* = ptr RemotableHandle
  wireHICON* = ptr RemotableHandle
  wireHRGN* = ptr RemotableHandle
  wireHMONITOR* = ptr RemotableHandle
  userBITMAP* {.pure.} = object
    bmType*: LONG
    bmWidth*: LONG
    bmHeight*: LONG
    bmWidthBytes*: LONG
    bmPlanes*: WORD
    bmBitsPixel*: WORD
    cbSize*: ULONG
    pBuffer*: array[1, uint8]
  userHBITMAP_u* {.pure, union.} = object
    hInproc*: LONG
    hRemote*: ptr userBITMAP
    hInproc64*: INT64
  userHBITMAP* {.pure.} = object
    fContext*: LONG
    padding*: array[4, byte]
    u*: userHBITMAP_u
  wireHBITMAP* = ptr userHBITMAP
  userHPALETTE_u* {.pure, union.} = object
    hInproc*: LONG
    hRemote*: ptr LOGPALETTE
    hInproc64*: INT64
  userHPALETTE* {.pure.} = object
    fContext*: LONG
    padding*: array[4, byte]
    u*: userHPALETTE_u
  wireHPALETTE* = ptr userHPALETTE
  BYTE_BLOB* {.pure.} = object
    clSize*: ULONG
    abData*: array[1, uint8]
  userHENHMETAFILE_u* {.pure, union.} = object
    hInproc*: LONG
    hRemote*: ptr BYTE_BLOB
    hInproc64*: INT64
  userHENHMETAFILE* {.pure.} = object
    fContext*: LONG
    padding*: array[4, byte]
    u*: userHENHMETAFILE_u
  wireHENHMETAFILE* = ptr userHENHMETAFILE
  userHMETAFILE_u* {.pure, union.} = object
    hInproc*: LONG
    hRemote*: ptr BYTE_BLOB
    hInproc64*: INT64
  userHMETAFILE* {.pure.} = object
    fContext*: LONG
    padding*: array[4, byte]
    u*: userHMETAFILE_u
  wireHMETAFILE* = ptr userHMETAFILE
  remoteMETAFILEPICT* {.pure.} = object
    mm*: LONG
    xExt*: LONG
    yExt*: LONG
    hMF*: ptr userHMETAFILE
  userHMETAFILEPICT_u* {.pure, union.} = object
    hInproc*: LONG
    hRemote*: ptr remoteMETAFILEPICT
    hInproc64*: INT64
  userHMETAFILEPICT* {.pure.} = object
    fContext*: LONG
    padding*: array[4, byte]
    u*: userHMETAFILEPICT_u
  wireHMETAFILEPICT* = ptr userHMETAFILEPICT
  DATE* = float64
  CY_STRUCT1* {.pure.} = object
    Lo*: int32
    Hi*: int32
  CY* {.pure, union.} = object
    struct1*: CY_STRUCT1
    int64*: LONGLONG
  LPCY* = ptr CY
  DECIMAL_UNION1_STRUCT1* {.pure.} = object
    scale*: BYTE
    sign*: BYTE
  DECIMAL_UNION1* {.pure, union.} = object
    struct1*: DECIMAL_UNION1_STRUCT1
    signscale*: USHORT
  DECIMAL_UNION2_STRUCT1* {.pure.} = object
    Lo32*: ULONG
    Mid32*: ULONG
  DECIMAL_UNION2* {.pure, union.} = object
    struct1*: DECIMAL_UNION2_STRUCT1
    Lo64*: ULONGLONG
  DECIMAL* {.pure.} = object
    wReserved*: USHORT
    union1*: DECIMAL_UNION1
    Hi32*: ULONG
    union2*: DECIMAL_UNION2
  LPDECIMAL* = ptr DECIMAL
  FLAGGED_WORD_BLOB* {.pure.} = object
    fFlags*: ULONG
    clSize*: ULONG
    asData*: array[1, uint16]
  wireBSTR* = ptr FLAGGED_WORD_BLOB
  LPBSTR* = ptr BSTR
  VARIANT_BOOL* = int16
  BSTRBLOB* {.pure.} = object
    cbSize*: ULONG
    pData*: ptr BYTE
  LPBSTRBLOB* = ptr BSTRBLOB
  IUnknown* {.pure.} = object
    lpVtbl*: ptr IUnknownVtbl
  IUnknownVtbl* {.pure, inheritable.} = object
    QueryInterface*: proc(self: ptr IUnknown, riid: REFIID, ppvObject: ptr pointer): HRESULT {.stdcall.}
    AddRef*: proc(self: ptr IUnknown): ULONG {.stdcall.}
    Release*: proc(self: ptr IUnknown): ULONG {.stdcall.}
  LPUNKNOWN* = ptr IUnknown
  IClassFactory* {.pure.} = object
    lpVtbl*: ptr IClassFactoryVtbl
  IClassFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateInstance*: proc(self: ptr IClassFactory, pUnkOuter: ptr IUnknown, riid: REFIID, ppvObject: ptr pointer): HRESULT {.stdcall.}
    LockServer*: proc(self: ptr IClassFactory, fLock: WINBOOL): HRESULT {.stdcall.}
  LPCLASSFACTORY* = ptr IClassFactory
  ISequentialStream* {.pure.} = object
    lpVtbl*: ptr ISequentialStreamVtbl
  ISequentialStreamVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Read*: proc(self: ptr ISequentialStream, pv: pointer, cb: ULONG, pcbRead: ptr ULONG): HRESULT {.stdcall.}
    Write*: proc(self: ptr ISequentialStream, pv: pointer, cb: ULONG, pcbWritten: ptr ULONG): HRESULT {.stdcall.}
  LPOLESTR* = ptr OLECHAR
  STATSTG* {.pure.} = object
    pwcsName*: LPOLESTR
    `type`*: DWORD
    cbSize*: ULARGE_INTEGER
    mtime*: FILETIME
    ctime*: FILETIME
    atime*: FILETIME
    grfMode*: DWORD
    grfLocksSupported*: DWORD
    clsid*: CLSID
    grfStateBits*: DWORD
    reserved*: DWORD
  IStream* {.pure.} = object
    lpVtbl*: ptr IStreamVtbl
  IStreamVtbl* {.pure, inheritable.} = object of ISequentialStreamVtbl
    Seek*: proc(self: ptr IStream, dlibMove: LARGE_INTEGER, dwOrigin: DWORD, plibNewPosition: ptr ULARGE_INTEGER): HRESULT {.stdcall.}
    SetSize*: proc(self: ptr IStream, libNewSize: ULARGE_INTEGER): HRESULT {.stdcall.}
    CopyTo*: proc(self: ptr IStream, pstm: ptr IStream, cb: ULARGE_INTEGER, pcbRead: ptr ULARGE_INTEGER, pcbWritten: ptr ULARGE_INTEGER): HRESULT {.stdcall.}
    Commit*: proc(self: ptr IStream, grfCommitFlags: DWORD): HRESULT {.stdcall.}
    Revert*: proc(self: ptr IStream): HRESULT {.stdcall.}
    LockRegion*: proc(self: ptr IStream, libOffset: ULARGE_INTEGER, cb: ULARGE_INTEGER, dwLockType: DWORD): HRESULT {.stdcall.}
    UnlockRegion*: proc(self: ptr IStream, libOffset: ULARGE_INTEGER, cb: ULARGE_INTEGER, dwLockType: DWORD): HRESULT {.stdcall.}
    Stat*: proc(self: ptr IStream, pstatstg: ptr STATSTG, grfStatFlag: DWORD): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IStream, ppstm: ptr ptr IStream): HRESULT {.stdcall.}
  IMarshal* {.pure.} = object
    lpVtbl*: ptr IMarshalVtbl
  IMarshalVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetUnmarshalClass*: proc(self: ptr IMarshal, riid: REFIID, pv: pointer, dwDestContext: DWORD, pvDestContext: pointer, mshlflags: DWORD, pCid: ptr CLSID): HRESULT {.stdcall.}
    GetMarshalSizeMax*: proc(self: ptr IMarshal, riid: REFIID, pv: pointer, dwDestContext: DWORD, pvDestContext: pointer, mshlflags: DWORD, pSize: ptr DWORD): HRESULT {.stdcall.}
    MarshalInterface*: proc(self: ptr IMarshal, pStm: ptr IStream, riid: REFIID, pv: pointer, dwDestContext: DWORD, pvDestContext: pointer, mshlflags: DWORD): HRESULT {.stdcall.}
    UnmarshalInterface*: proc(self: ptr IMarshal, pStm: ptr IStream, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    ReleaseMarshalData*: proc(self: ptr IMarshal, pStm: ptr IStream): HRESULT {.stdcall.}
    DisconnectObject*: proc(self: ptr IMarshal, dwReserved: DWORD): HRESULT {.stdcall.}
  LPMARSHAL* = ptr IMarshal
  IMarshal2* {.pure.} = object
    lpVtbl*: ptr IMarshal2Vtbl
  IMarshal2Vtbl* {.pure, inheritable.} = object of IMarshalVtbl
  LPMARSHAL2* = ptr IMarshal2
  IMalloc* {.pure.} = object
    lpVtbl*: ptr IMallocVtbl
  IMallocVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Alloc*: proc(self: ptr IMalloc, cb: SIZE_T): pointer {.stdcall.}
    Realloc*: proc(self: ptr IMalloc, pv: pointer, cb: SIZE_T): pointer {.stdcall.}
    Free*: proc(self: ptr IMalloc, pv: pointer): void {.stdcall.}
    GetSize*: proc(self: ptr IMalloc, pv: pointer): SIZE_T {.stdcall.}
    DidAlloc*: proc(self: ptr IMalloc, pv: pointer): int32 {.stdcall.}
    HeapMinimize*: proc(self: ptr IMalloc): void {.stdcall.}
  LPMALLOC* = ptr IMalloc
  IStdMarshalInfo* {.pure.} = object
    lpVtbl*: ptr IStdMarshalInfoVtbl
  IStdMarshalInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetClassForHandler*: proc(self: ptr IStdMarshalInfo, dwDestContext: DWORD, pvDestContext: pointer, pClsid: ptr CLSID): HRESULT {.stdcall.}
  LPSTDMARSHALINFO* = ptr IStdMarshalInfo
  IExternalConnection* {.pure.} = object
    lpVtbl*: ptr IExternalConnectionVtbl
  IExternalConnectionVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddConnection*: proc(self: ptr IExternalConnection, extconn: DWORD, reserved: DWORD): DWORD {.stdcall.}
    ReleaseConnection*: proc(self: ptr IExternalConnection, extconn: DWORD, reserved: DWORD, fLastReleaseCloses: WINBOOL): DWORD {.stdcall.}
  LPEXTERNALCONNECTION* = ptr IExternalConnection
  MULTI_QI* {.pure.} = object
    pIID*: ptr IID
    pItf*: ptr IUnknown
    hr*: HRESULT
  IMultiQI* {.pure.} = object
    lpVtbl*: ptr IMultiQIVtbl
  IMultiQIVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryMultipleInterfaces*: proc(self: ptr IMultiQI, cMQIs: ULONG, pMQIs: ptr MULTI_QI): HRESULT {.stdcall.}
  LPMULTIQI* = ptr IMultiQI
  IEnumUnknown* {.pure.} = object
    lpVtbl*: ptr IEnumUnknownVtbl
  IEnumUnknownVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumUnknown, celt: ULONG, rgelt: ptr ptr IUnknown, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumUnknown, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumUnknown): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumUnknown, ppenum: ptr ptr IEnumUnknown): HRESULT {.stdcall.}
  LPENUMUNKNOWN* = ptr IEnumUnknown
  IEnumString* {.pure.} = object
    lpVtbl*: ptr IEnumStringVtbl
  IEnumStringVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumString, celt: ULONG, rgelt: ptr LPOLESTR, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumString, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumString): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumString, ppenum: ptr ptr IEnumString): HRESULT {.stdcall.}
  LPENUMSTRING* = ptr IEnumString
  LPSTREAM* = ptr IStream
  RPCOLEMESSAGE* {.pure.} = object
    reserved1*: pointer
    dataRepresentation*: RPCOLEDATAREP
    Buffer*: pointer
    cbBuffer*: ULONG
    iMethod*: ULONG
    reserved2*: array[5, pointer]
    rpcFlags*: ULONG
  PRPCOLEMESSAGE* = ptr RPCOLEMESSAGE
  SOLE_AUTHENTICATION_SERVICE* {.pure.} = object
    dwAuthnSvc*: DWORD
    dwAuthzSvc*: DWORD
    pPrincipalName*: ptr OLECHAR
    hr*: HRESULT
  PSOLE_AUTHENTICATION_SERVICE* = ptr SOLE_AUTHENTICATION_SERVICE
  SOLE_AUTHENTICATION_INFO* {.pure.} = object
    dwAuthnSvc*: DWORD
    dwAuthzSvc*: DWORD
    pAuthInfo*: pointer
  PSOLE_AUTHENTICATION_INFO* = ptr SOLE_AUTHENTICATION_INFO
  SOLE_AUTHENTICATION_LIST* {.pure.} = object
    cAuthInfo*: DWORD
    aAuthInfo*: ptr SOLE_AUTHENTICATION_INFO
  PSOLE_AUTHENTICATION_LIST* = ptr SOLE_AUTHENTICATION_LIST
  ISurrogate* {.pure.} = object
    lpVtbl*: ptr ISurrogateVtbl
  ISurrogateVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    LoadDllServer*: proc(self: ptr ISurrogate, Clsid: REFCLSID): HRESULT {.stdcall.}
    FreeSurrogate*: proc(self: ptr ISurrogate): HRESULT {.stdcall.}
  LPSURROGATE* = ptr ISurrogate
  IGlobalInterfaceTable* {.pure.} = object
    lpVtbl*: ptr IGlobalInterfaceTableVtbl
  IGlobalInterfaceTableVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RegisterInterfaceInGlobal*: proc(self: ptr IGlobalInterfaceTable, pUnk: ptr IUnknown, riid: REFIID, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    RevokeInterfaceFromGlobal*: proc(self: ptr IGlobalInterfaceTable, dwCookie: DWORD): HRESULT {.stdcall.}
    GetInterfaceFromGlobal*: proc(self: ptr IGlobalInterfaceTable, dwCookie: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  LPGLOBALINTERFACETABLE* = ptr IGlobalInterfaceTable
  ICancelMethodCalls* {.pure.} = object
    lpVtbl*: ptr ICancelMethodCallsVtbl
  ICancelMethodCallsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Cancel*: proc(self: ptr ICancelMethodCalls, ulSeconds: ULONG): HRESULT {.stdcall.}
    TestCancel*: proc(self: ptr ICancelMethodCalls): HRESULT {.stdcall.}
  LPCANCELMETHODCALLS* = ptr ICancelMethodCalls
  IAddrTrackingControl* {.pure.} = object
    lpVtbl*: ptr IAddrTrackingControlVtbl
  IAddrTrackingControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EnableCOMDynamicAddrTracking*: proc(self: ptr IAddrTrackingControl): HRESULT {.stdcall.}
    DisableCOMDynamicAddrTracking*: proc(self: ptr IAddrTrackingControl): HRESULT {.stdcall.}
  LPADDRTRACKINGCONTROL* = ptr IAddrTrackingControl
  IAddrExclusionControl* {.pure.} = object
    lpVtbl*: ptr IAddrExclusionControlVtbl
  IAddrExclusionControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentAddrExclusionList*: proc(self: ptr IAddrExclusionControl, riid: REFIID, ppEnumerator: ptr pointer): HRESULT {.stdcall.}
    UpdateAddrExclusionList*: proc(self: ptr IAddrExclusionControl, pEnumerator: ptr IUnknown): HRESULT {.stdcall.}
  LPADDREXCLUSIONCONTROL* = ptr IAddrExclusionControl
  ContextProperty* {.pure.} = object
    policyId*: GUID
    flags*: CPFLAGS
    pUnk*: ptr IUnknown
  IEnumContextProps* {.pure.} = object
    lpVtbl*: ptr IEnumContextPropsVtbl
  IEnumContextPropsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumContextProps, celt: ULONG, pContextProperties: ptr ContextProperty, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumContextProps, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumContextProps): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumContextProps, ppEnumContextProps: ptr ptr IEnumContextProps): HRESULT {.stdcall.}
    Count*: proc(self: ptr IEnumContextProps, pcelt: ptr ULONG): HRESULT {.stdcall.}
  LPENUMCONTEXTPROPS* = ptr IEnumContextProps
  IMallocSpy* {.pure.} = object
    lpVtbl*: ptr IMallocSpyVtbl
  IMallocSpyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    PreAlloc*: proc(self: ptr IMallocSpy, cbRequest: SIZE_T): SIZE_T {.stdcall.}
    PostAlloc*: proc(self: ptr IMallocSpy, pActual: pointer): pointer {.stdcall.}
    PreFree*: proc(self: ptr IMallocSpy, pRequest: pointer, fSpyed: WINBOOL): pointer {.stdcall.}
    PostFree*: proc(self: ptr IMallocSpy, fSpyed: WINBOOL): void {.stdcall.}
    PreRealloc*: proc(self: ptr IMallocSpy, pRequest: pointer, cbRequest: SIZE_T, ppNewRequest: ptr pointer, fSpyed: WINBOOL): SIZE_T {.stdcall.}
    PostRealloc*: proc(self: ptr IMallocSpy, pActual: pointer, fSpyed: WINBOOL): pointer {.stdcall.}
    PreGetSize*: proc(self: ptr IMallocSpy, pRequest: pointer, fSpyed: WINBOOL): pointer {.stdcall.}
    PostGetSize*: proc(self: ptr IMallocSpy, cbActual: SIZE_T, fSpyed: WINBOOL): SIZE_T {.stdcall.}
    PreDidAlloc*: proc(self: ptr IMallocSpy, pRequest: pointer, fSpyed: WINBOOL): pointer {.stdcall.}
    PostDidAlloc*: proc(self: ptr IMallocSpy, pRequest: pointer, fSpyed: WINBOOL, fActual: int32): int32 {.stdcall.}
    PreHeapMinimize*: proc(self: ptr IMallocSpy): void {.stdcall.}
    PostHeapMinimize*: proc(self: ptr IMallocSpy): void {.stdcall.}
  LPMALLOCSPY* = ptr IMallocSpy
  BIND_OPTS* {.pure.} = object
    cbStruct*: DWORD
    grfFlags*: DWORD
    grfMode*: DWORD
    dwTickCountDeadline*: DWORD
  IPersist* {.pure.} = object
    lpVtbl*: ptr IPersistVtbl
  IPersistVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetClassID*: proc(self: ptr IPersist, pClassID: ptr CLSID): HRESULT {.stdcall.}
  IPersistStream* {.pure.} = object
    lpVtbl*: ptr IPersistStreamVtbl
  IPersistStreamVtbl* {.pure, inheritable.} = object of IPersistVtbl
    IsDirty*: proc(self: ptr IPersistStream): HRESULT {.stdcall.}
    Load*: proc(self: ptr IPersistStream, pStm: ptr IStream): HRESULT {.stdcall.}
    Save*: proc(self: ptr IPersistStream, pStm: ptr IStream, fClearDirty: WINBOOL): HRESULT {.stdcall.}
    GetSizeMax*: proc(self: ptr IPersistStream, pcbSize: ptr ULARGE_INTEGER): HRESULT {.stdcall.}
  IEnumMoniker* {.pure.} = object
    lpVtbl*: ptr IEnumMonikerVtbl
  IEnumMonikerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumMoniker, celt: ULONG, rgelt: ptr ptr IMoniker, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumMoniker, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumMoniker): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumMoniker, ppenum: ptr ptr IEnumMoniker): HRESULT {.stdcall.}
  IMoniker* {.pure.} = object
    lpVtbl*: ptr IMonikerVtbl
  IMonikerVtbl* {.pure, inheritable.} = object of IPersistStreamVtbl
    BindToObject*: proc(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, riidResult: REFIID, ppvResult: ptr pointer): HRESULT {.stdcall.}
    BindToStorage*: proc(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, riid: REFIID, ppvObj: ptr pointer): HRESULT {.stdcall.}
    Reduce*: proc(self: ptr IMoniker, pbc: ptr IBindCtx, dwReduceHowFar: DWORD, ppmkToLeft: ptr ptr IMoniker, ppmkReduced: ptr ptr IMoniker): HRESULT {.stdcall.}
    ComposeWith*: proc(self: ptr IMoniker, pmkRight: ptr IMoniker, fOnlyIfNotGeneric: WINBOOL, ppmkComposite: ptr ptr IMoniker): HRESULT {.stdcall.}
    Enum*: proc(self: ptr IMoniker, fForward: WINBOOL, ppenumMoniker: ptr ptr IEnumMoniker): HRESULT {.stdcall.}
    IsEqual*: proc(self: ptr IMoniker, pmkOtherMoniker: ptr IMoniker): HRESULT {.stdcall.}
    Hash*: proc(self: ptr IMoniker, pdwHash: ptr DWORD): HRESULT {.stdcall.}
    IsRunning*: proc(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, pmkNewlyRunning: ptr IMoniker): HRESULT {.stdcall.}
    GetTimeOfLastChange*: proc(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, pFileTime: ptr FILETIME): HRESULT {.stdcall.}
    Inverse*: proc(self: ptr IMoniker, ppmk: ptr ptr IMoniker): HRESULT {.stdcall.}
    CommonPrefixWith*: proc(self: ptr IMoniker, pmkOther: ptr IMoniker, ppmkPrefix: ptr ptr IMoniker): HRESULT {.stdcall.}
    RelativePathTo*: proc(self: ptr IMoniker, pmkOther: ptr IMoniker, ppmkRelPath: ptr ptr IMoniker): HRESULT {.stdcall.}
    GetDisplayName*: proc(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, ppszDisplayName: ptr LPOLESTR): HRESULT {.stdcall.}
    ParseDisplayName*: proc(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, pszDisplayName: LPOLESTR, pchEaten: ptr ULONG, ppmkOut: ptr ptr IMoniker): HRESULT {.stdcall.}
    IsSystemMoniker*: proc(self: ptr IMoniker, pdwMksys: ptr DWORD): HRESULT {.stdcall.}
  IRunningObjectTable* {.pure.} = object
    lpVtbl*: ptr IRunningObjectTableVtbl
  IRunningObjectTableVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Register*: proc(self: ptr IRunningObjectTable, grfFlags: DWORD, punkObject: ptr IUnknown, pmkObjectName: ptr IMoniker, pdwRegister: ptr DWORD): HRESULT {.stdcall.}
    Revoke*: proc(self: ptr IRunningObjectTable, dwRegister: DWORD): HRESULT {.stdcall.}
    IsRunning*: proc(self: ptr IRunningObjectTable, pmkObjectName: ptr IMoniker): HRESULT {.stdcall.}
    GetObject*: proc(self: ptr IRunningObjectTable, pmkObjectName: ptr IMoniker, ppunkObject: ptr ptr IUnknown): HRESULT {.stdcall.}
    NoteChangeTime*: proc(self: ptr IRunningObjectTable, dwRegister: DWORD, pfiletime: ptr FILETIME): HRESULT {.stdcall.}
    GetTimeOfLastChange*: proc(self: ptr IRunningObjectTable, pmkObjectName: ptr IMoniker, pfiletime: ptr FILETIME): HRESULT {.stdcall.}
    EnumRunning*: proc(self: ptr IRunningObjectTable, ppenumMoniker: ptr ptr IEnumMoniker): HRESULT {.stdcall.}
  IBindCtx* {.pure.} = object
    lpVtbl*: ptr IBindCtxVtbl
  IBindCtxVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RegisterObjectBound*: proc(self: ptr IBindCtx, punk: ptr IUnknown): HRESULT {.stdcall.}
    RevokeObjectBound*: proc(self: ptr IBindCtx, punk: ptr IUnknown): HRESULT {.stdcall.}
    ReleaseBoundObjects*: proc(self: ptr IBindCtx): HRESULT {.stdcall.}
    SetBindOptions*: proc(self: ptr IBindCtx, pbindopts: ptr BIND_OPTS): HRESULT {.stdcall.}
    GetBindOptions*: proc(self: ptr IBindCtx, pbindopts: ptr BIND_OPTS): HRESULT {.stdcall.}
    GetRunningObjectTable*: proc(self: ptr IBindCtx, pprot: ptr ptr IRunningObjectTable): HRESULT {.stdcall.}
    RegisterObjectParam*: proc(self: ptr IBindCtx, pszKey: LPOLESTR, punk: ptr IUnknown): HRESULT {.stdcall.}
    GetObjectParam*: proc(self: ptr IBindCtx, pszKey: LPOLESTR, ppunk: ptr ptr IUnknown): HRESULT {.stdcall.}
    EnumObjectParam*: proc(self: ptr IBindCtx, ppenum: ptr ptr IEnumString): HRESULT {.stdcall.}
    RevokeObjectParam*: proc(self: ptr IBindCtx, pszKey: LPOLESTR): HRESULT {.stdcall.}
  LPBC* = ptr IBindCtx
  LPBINDCTX* = ptr IBindCtx
  LPBIND_OPTS* = ptr BIND_OPTS
  COAUTHIDENTITY* {.pure.} = object
    User*: ptr USHORT
    UserLength*: ULONG
    Domain*: ptr USHORT
    DomainLength*: ULONG
    Password*: ptr USHORT
    PasswordLength*: ULONG
    Flags*: ULONG
  COAUTHINFO* {.pure.} = object
    dwAuthnSvc*: DWORD
    dwAuthzSvc*: DWORD
    pwszServerPrincName*: LPWSTR
    dwAuthnLevel*: DWORD
    dwImpersonationLevel*: DWORD
    pAuthIdentityData*: ptr COAUTHIDENTITY
    dwCapabilities*: DWORD
  COSERVERINFO* {.pure.} = object
    dwReserved1*: DWORD
    pwszName*: LPWSTR
    pAuthInfo*: ptr COAUTHINFO
    dwReserved2*: DWORD
  BIND_OPTS2* {.pure.} = object
    cbStruct*: DWORD
    grfFlags*: DWORD
    grfMode*: DWORD
    dwTickCountDeadline*: DWORD
    dwTrackFlags*: DWORD
    dwClassContext*: DWORD
    locale*: LCID
    pServerInfo*: ptr COSERVERINFO
  LPBIND_OPTS2* = ptr BIND_OPTS2
  BIND_OPTS3* {.pure.} = object
    cbStruct*: DWORD
    grfFlags*: DWORD
    grfMode*: DWORD
    dwTickCountDeadline*: DWORD
    dwTrackFlags*: DWORD
    dwClassContext*: DWORD
    locale*: LCID
    pServerInfo*: ptr COSERVERINFO
    hwnd*: HWND
  LPBIND_OPTS3* = ptr BIND_OPTS3
  LPENUMMONIKER* = ptr IEnumMoniker
  IRunnableObject* {.pure.} = object
    lpVtbl*: ptr IRunnableObjectVtbl
  IRunnableObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetRunningClass*: proc(self: ptr IRunnableObject, lpClsid: LPCLSID): HRESULT {.stdcall.}
    Run*: proc(self: ptr IRunnableObject, pbc: LPBINDCTX): HRESULT {.stdcall.}
    IsRunning*: proc(self: ptr IRunnableObject): WINBOOL {.stdcall.}
    LockRunning*: proc(self: ptr IRunnableObject, fLock: WINBOOL, fLastUnlockCloses: WINBOOL): HRESULT {.stdcall.}
    SetContainedObject*: proc(self: ptr IRunnableObject, fContained: WINBOOL): HRESULT {.stdcall.}
  LPRUNNABLEOBJECT* = ptr IRunnableObject
  LPRUNNINGOBJECTTABLE* = ptr IRunningObjectTable
  LPPERSIST* = ptr IPersist
  LPPERSISTSTREAM* = ptr IPersistStream
  LPMONIKER* = ptr IMoniker
  IEnumSTATSTG* {.pure.} = object
    lpVtbl*: ptr IEnumSTATSTGVtbl
  IEnumSTATSTGVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumSTATSTG, celt: ULONG, rgelt: ptr STATSTG, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumSTATSTG, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumSTATSTG): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumSTATSTG, ppenum: ptr ptr IEnumSTATSTG): HRESULT {.stdcall.}
  LPENUMSTATSTG* = ptr IEnumSTATSTG
  SNB* = ptr LPOLESTR
  IStorage* {.pure.} = object
    lpVtbl*: ptr IStorageVtbl
  IStorageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateStream*: proc(self: ptr IStorage, pwcsName: ptr OLECHAR, grfMode: DWORD, reserved1: DWORD, reserved2: DWORD, ppstm: ptr ptr IStream): HRESULT {.stdcall.}
    OpenStream*: proc(self: ptr IStorage, pwcsName: ptr OLECHAR, reserved1: pointer, grfMode: DWORD, reserved2: DWORD, ppstm: ptr ptr IStream): HRESULT {.stdcall.}
    CreateStorage*: proc(self: ptr IStorage, pwcsName: ptr OLECHAR, grfMode: DWORD, reserved1: DWORD, reserved2: DWORD, ppstg: ptr ptr IStorage): HRESULT {.stdcall.}
    OpenStorage*: proc(self: ptr IStorage, pwcsName: ptr OLECHAR, pstgPriority: ptr IStorage, grfMode: DWORD, snbExclude: SNB, reserved: DWORD, ppstg: ptr ptr IStorage): HRESULT {.stdcall.}
    CopyTo*: proc(self: ptr IStorage, ciidExclude: DWORD, rgiidExclude: ptr IID, snbExclude: SNB, pstgDest: ptr IStorage): HRESULT {.stdcall.}
    MoveElementTo*: proc(self: ptr IStorage, pwcsName: ptr OLECHAR, pstgDest: ptr IStorage, pwcsNewName: ptr OLECHAR, grfFlags: DWORD): HRESULT {.stdcall.}
    Commit*: proc(self: ptr IStorage, grfCommitFlags: DWORD): HRESULT {.stdcall.}
    Revert*: proc(self: ptr IStorage): HRESULT {.stdcall.}
    EnumElements*: proc(self: ptr IStorage, reserved1: DWORD, reserved2: pointer, reserved3: DWORD, ppenum: ptr ptr IEnumSTATSTG): HRESULT {.stdcall.}
    DestroyElement*: proc(self: ptr IStorage, pwcsName: ptr OLECHAR): HRESULT {.stdcall.}
    RenameElement*: proc(self: ptr IStorage, pwcsOldName: ptr OLECHAR, pwcsNewName: ptr OLECHAR): HRESULT {.stdcall.}
    SetElementTimes*: proc(self: ptr IStorage, pwcsName: ptr OLECHAR, pctime: ptr FILETIME, patime: ptr FILETIME, pmtime: ptr FILETIME): HRESULT {.stdcall.}
    SetClass*: proc(self: ptr IStorage, clsid: REFCLSID): HRESULT {.stdcall.}
    SetStateBits*: proc(self: ptr IStorage, grfStateBits: DWORD, grfMask: DWORD): HRESULT {.stdcall.}
    Stat*: proc(self: ptr IStorage, pstatstg: ptr STATSTG, grfStatFlag: DWORD): HRESULT {.stdcall.}
  LPSTORAGE* = ptr IStorage
  RemSNB* {.pure.} = object
    ulCntStr*: ULONG
    ulCntChar*: ULONG
    rgString*: array[1, OLECHAR]
  wireSNB* = ptr RemSNB
  LPCOLESTR* = ptr OLECHAR
  IPersistFile* {.pure.} = object
    lpVtbl*: ptr IPersistFileVtbl
  IPersistFileVtbl* {.pure, inheritable.} = object of IPersistVtbl
    IsDirty*: proc(self: ptr IPersistFile): HRESULT {.stdcall.}
    Load*: proc(self: ptr IPersistFile, pszFileName: LPCOLESTR, dwMode: DWORD): HRESULT {.stdcall.}
    Save*: proc(self: ptr IPersistFile, pszFileName: LPCOLESTR, fRemember: WINBOOL): HRESULT {.stdcall.}
    SaveCompleted*: proc(self: ptr IPersistFile, pszFileName: LPCOLESTR): HRESULT {.stdcall.}
    GetCurFile*: proc(self: ptr IPersistFile, ppszFileName: ptr LPOLESTR): HRESULT {.stdcall.}
  LPPERSISTFILE* = ptr IPersistFile
  IPersistStorage* {.pure.} = object
    lpVtbl*: ptr IPersistStorageVtbl
  IPersistStorageVtbl* {.pure, inheritable.} = object of IPersistVtbl
    IsDirty*: proc(self: ptr IPersistStorage): HRESULT {.stdcall.}
    InitNew*: proc(self: ptr IPersistStorage, pStg: ptr IStorage): HRESULT {.stdcall.}
    Load*: proc(self: ptr IPersistStorage, pStg: ptr IStorage): HRESULT {.stdcall.}
    Save*: proc(self: ptr IPersistStorage, pStgSave: ptr IStorage, fSameAsLoad: WINBOOL): HRESULT {.stdcall.}
    SaveCompleted*: proc(self: ptr IPersistStorage, pStgNew: ptr IStorage): HRESULT {.stdcall.}
    HandsOffStorage*: proc(self: ptr IPersistStorage): HRESULT {.stdcall.}
  LPPERSISTSTORAGE* = ptr IPersistStorage
  ILockBytes* {.pure.} = object
    lpVtbl*: ptr ILockBytesVtbl
  ILockBytesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ReadAt*: proc(self: ptr ILockBytes, ulOffset: ULARGE_INTEGER, pv: pointer, cb: ULONG, pcbRead: ptr ULONG): HRESULT {.stdcall.}
    WriteAt*: proc(self: ptr ILockBytes, ulOffset: ULARGE_INTEGER, pv: pointer, cb: ULONG, pcbWritten: ptr ULONG): HRESULT {.stdcall.}
    Flush*: proc(self: ptr ILockBytes): HRESULT {.stdcall.}
    SetSize*: proc(self: ptr ILockBytes, cb: ULARGE_INTEGER): HRESULT {.stdcall.}
    LockRegion*: proc(self: ptr ILockBytes, libOffset: ULARGE_INTEGER, cb: ULARGE_INTEGER, dwLockType: DWORD): HRESULT {.stdcall.}
    UnlockRegion*: proc(self: ptr ILockBytes, libOffset: ULARGE_INTEGER, cb: ULARGE_INTEGER, dwLockType: DWORD): HRESULT {.stdcall.}
    Stat*: proc(self: ptr ILockBytes, pstatstg: ptr STATSTG, grfStatFlag: DWORD): HRESULT {.stdcall.}
  LPLOCKBYTES* = ptr ILockBytes
  DVTARGETDEVICE* {.pure.} = object
    tdSize*: DWORD
    tdDriverNameOffset*: WORD
    tdDeviceNameOffset*: WORD
    tdPortNameOffset*: WORD
    tdExtDevmodeOffset*: WORD
    tdData*: array[1, BYTE]
  FORMATETC* {.pure.} = object
    cfFormat*: CLIPFORMAT
    ptd*: ptr DVTARGETDEVICE
    dwAspect*: DWORD
    lindex*: LONG
    tymed*: DWORD
  IEnumFORMATETC* {.pure.} = object
    lpVtbl*: ptr IEnumFORMATETCVtbl
  IEnumFORMATETCVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumFORMATETC, celt: ULONG, rgelt: ptr FORMATETC, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumFORMATETC, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumFORMATETC): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumFORMATETC, ppenum: ptr ptr IEnumFORMATETC): HRESULT {.stdcall.}
  LPENUMFORMATETC* = ptr IEnumFORMATETC
  LPCLIPFORMAT* = ptr CLIPFORMAT
  LPFORMATETC* = ptr FORMATETC
  uSTGMEDIUM_u* {.pure, union.} = object
    hBitmap*: HBITMAP
    hMetaFilePict*: HMETAFILEPICT
    hEnhMetaFile*: HENHMETAFILE
    hGlobal*: HGLOBAL
    lpszFileName*: LPOLESTR
    pstm*: ptr IStream
    pstg*: ptr IStorage
  uSTGMEDIUM* {.pure.} = object
    tymed*: DWORD
    u*: uSTGMEDIUM_u
    pUnkForRelease*: ptr IUnknown
  STGMEDIUM* = uSTGMEDIUM
  IAdviseSink* {.pure.} = object
    lpVtbl*: ptr IAdviseSinkVtbl
  IAdviseSinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnDataChange*: proc(self: ptr IAdviseSink, pFormatetc: ptr FORMATETC, pStgmed: ptr STGMEDIUM): void {.stdcall.}
    OnViewChange*: proc(self: ptr IAdviseSink, dwAspect: DWORD, lindex: LONG): void {.stdcall.}
    OnRename*: proc(self: ptr IAdviseSink, pmk: ptr IMoniker): void {.stdcall.}
    OnSave*: proc(self: ptr IAdviseSink): void {.stdcall.}
    OnClose*: proc(self: ptr IAdviseSink): void {.stdcall.}
  STATDATA* {.pure.} = object
    formatetc*: FORMATETC
    advf*: DWORD
    pAdvSink*: ptr IAdviseSink
    dwConnection*: DWORD
  IEnumSTATDATA* {.pure.} = object
    lpVtbl*: ptr IEnumSTATDATAVtbl
  IEnumSTATDATAVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumSTATDATA, celt: ULONG, rgelt: ptr STATDATA, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumSTATDATA, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumSTATDATA): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumSTATDATA, ppenum: ptr ptr IEnumSTATDATA): HRESULT {.stdcall.}
  LPENUMSTATDATA* = ptr IEnumSTATDATA
  LPSTATDATA* = ptr STATDATA
  IRootStorage* {.pure.} = object
    lpVtbl*: ptr IRootStorageVtbl
  IRootStorageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SwitchToFile*: proc(self: ptr IRootStorage, pszFile: LPOLESTR): HRESULT {.stdcall.}
  LPROOTSTORAGE* = ptr IRootStorage
  LPADVISESINK* = ptr IAdviseSink
  GDI_OBJECT_u* {.pure, union.} = object
    hBitmap*: wireHBITMAP
    hPalette*: wireHPALETTE
    hGeneric*: wireHGLOBAL
  GDI_OBJECT* {.pure.} = object
    ObjectType*: DWORD
    u*: GDI_OBJECT_u
  userSTGMEDIUM_STRUCT1_u* {.pure, union.} = object
    hMetaFilePict*: wireHMETAFILEPICT
    hHEnhMetaFile*: wireHENHMETAFILE
    hGdiHandle*: ptr GDI_OBJECT
    hGlobal*: wireHGLOBAL
    lpszFileName*: LPOLESTR
    pstm*: ptr BYTE_BLOB
    pstg*: ptr BYTE_BLOB
  userSTGMEDIUM_STRUCT1* {.pure.} = object
    tymed*: DWORD
    u*: userSTGMEDIUM_STRUCT1_u
  userSTGMEDIUM* {.pure.} = object
    struct1*: userSTGMEDIUM_STRUCT1
    pUnkForRelease*: ptr IUnknown
  wireSTGMEDIUM* = ptr userSTGMEDIUM
  wireASYNC_STGMEDIUM* = ptr userSTGMEDIUM
  ASYNC_STGMEDIUM* = STGMEDIUM
  LPSTGMEDIUM* = ptr STGMEDIUM
  userFLAG_STGMEDIUM* {.pure.} = object
    ContextFlags*: LONG
    fPassOwnership*: LONG
    Stgmed*: userSTGMEDIUM
  wireFLAG_STGMEDIUM* = ptr userFLAG_STGMEDIUM
  IAdviseSink2* {.pure.} = object
    lpVtbl*: ptr IAdviseSink2Vtbl
  IAdviseSink2Vtbl* {.pure, inheritable.} = object of IAdviseSinkVtbl
    OnLinkSrcChange*: proc(self: ptr IAdviseSink2, pmk: ptr IMoniker): void {.stdcall.}
  LPADVISESINK2* = ptr IAdviseSink2
  IDataObject* {.pure.} = object
    lpVtbl*: ptr IDataObjectVtbl
  IDataObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetData*: proc(self: ptr IDataObject, pformatetcIn: ptr FORMATETC, pmedium: ptr STGMEDIUM): HRESULT {.stdcall.}
    GetDataHere*: proc(self: ptr IDataObject, pformatetc: ptr FORMATETC, pmedium: ptr STGMEDIUM): HRESULT {.stdcall.}
    QueryGetData*: proc(self: ptr IDataObject, pformatetc: ptr FORMATETC): HRESULT {.stdcall.}
    GetCanonicalFormatEtc*: proc(self: ptr IDataObject, pformatectIn: ptr FORMATETC, pformatetcOut: ptr FORMATETC): HRESULT {.stdcall.}
    SetData*: proc(self: ptr IDataObject, pformatetc: ptr FORMATETC, pmedium: ptr STGMEDIUM, fRelease: WINBOOL): HRESULT {.stdcall.}
    EnumFormatEtc*: proc(self: ptr IDataObject, dwDirection: DWORD, ppenumFormatEtc: ptr ptr IEnumFORMATETC): HRESULT {.stdcall.}
    DAdvise*: proc(self: ptr IDataObject, pformatetc: ptr FORMATETC, advf: DWORD, pAdvSink: ptr IAdviseSink, pdwConnection: ptr DWORD): HRESULT {.stdcall.}
    DUnadvise*: proc(self: ptr IDataObject, dwConnection: DWORD): HRESULT {.stdcall.}
    EnumDAdvise*: proc(self: ptr IDataObject, ppenumAdvise: ptr ptr IEnumSTATDATA): HRESULT {.stdcall.}
  LPDATAOBJECT* = ptr IDataObject
  IDataAdviseHolder* {.pure.} = object
    lpVtbl*: ptr IDataAdviseHolderVtbl
  IDataAdviseHolderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Advise*: proc(self: ptr IDataAdviseHolder, pDataObject: ptr IDataObject, pFetc: ptr FORMATETC, advf: DWORD, pAdvise: ptr IAdviseSink, pdwConnection: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IDataAdviseHolder, dwConnection: DWORD): HRESULT {.stdcall.}
    EnumAdvise*: proc(self: ptr IDataAdviseHolder, ppenumAdvise: ptr ptr IEnumSTATDATA): HRESULT {.stdcall.}
    SendOnDataChange*: proc(self: ptr IDataAdviseHolder, pDataObject: ptr IDataObject, dwReserved: DWORD, advf: DWORD): HRESULT {.stdcall.}
  LPDATAADVISEHOLDER* = ptr IDataAdviseHolder
  INTERFACEINFO* {.pure.} = object
    pUnk*: ptr IUnknown
    iid*: IID
    wMethod*: WORD
  LPINTERFACEINFO* = ptr INTERFACEINFO
  IMessageFilter* {.pure.} = object
    lpVtbl*: ptr IMessageFilterVtbl
  IMessageFilterVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandleInComingCall*: proc(self: ptr IMessageFilter, dwCallType: DWORD, htaskCaller: HTASK, dwTickCount: DWORD, lpInterfaceInfo: LPINTERFACEINFO): DWORD {.stdcall.}
    RetryRejectedCall*: proc(self: ptr IMessageFilter, htaskCallee: HTASK, dwTickCount: DWORD, dwRejectType: DWORD): DWORD {.stdcall.}
    MessagePending*: proc(self: ptr IMessageFilter, htaskCallee: HTASK, dwTickCount: DWORD, dwPendingType: DWORD): DWORD {.stdcall.}
  LPMESSAGEFILTER* = ptr IMessageFilter
  IInitializeSpy* {.pure.} = object
    lpVtbl*: ptr IInitializeSpyVtbl
  IInitializeSpyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    PreInitialize*: proc(self: ptr IInitializeSpy, dwCoInit: DWORD, dwCurThreadAptRefs: DWORD): HRESULT {.stdcall.}
    PostInitialize*: proc(self: ptr IInitializeSpy, hrCoInit: HRESULT, dwCoInit: DWORD, dwNewThreadAptRefs: DWORD): HRESULT {.stdcall.}
    PreUninitialize*: proc(self: ptr IInitializeSpy, dwCurThreadAptRefs: DWORD): HRESULT {.stdcall.}
    PostUninitialize*: proc(self: ptr IInitializeSpy, dwNewThreadAptRefs: DWORD): HRESULT {.stdcall.}
  LPINITIALIZESPY* = ptr IInitializeSpy
  CURRENCY* = CY
  SAFEARRAYBOUND* {.pure.} = object
    cElements*: ULONG
    lLbound*: LONG
  LPSAFEARRAYBOUND* = ptr SAFEARRAYBOUND
  SAFEARR_BSTR* {.pure.} = object
    Size*: ULONG
    aBstr*: ptr wireBSTR
  SAFEARR_UNKNOWN* {.pure.} = object
    Size*: ULONG
    apUnknown*: ptr ptr IUnknown
  MEMBERID* = DISPID
  ARRAYDESC* {.pure.} = object
    tdescElem*: TYPEDESC
    cDims*: USHORT
    rgbounds*: array[1, SAFEARRAYBOUND]
  TYPEDESC_UNION1* {.pure, union.} = object
    lptdesc*: ptr TYPEDESC
    lpadesc*: ptr ARRAYDESC
    hreftype*: HREFTYPE
  TYPEDESC* {.pure.} = object
    union1*: TYPEDESC_UNION1
    vt*: VARTYPE
  IDLDESC* {.pure.} = object
    dwReserved*: ULONG_PTR
    wIDLFlags*: USHORT
  TYPEATTR* {.pure.} = object
    guid*: GUID
    lcid*: LCID
    dwReserved*: DWORD
    memidConstructor*: MEMBERID
    memidDestructor*: MEMBERID
    lpstrSchema*: LPOLESTR
    cbSizeInstance*: ULONG
    typekind*: TYPEKIND
    cFuncs*: WORD
    cVars*: WORD
    cImplTypes*: WORD
    cbSizeVft*: WORD
    cbAlignment*: WORD
    wTypeFlags*: WORD
    wMajorVerNum*: WORD
    wMinorVerNum*: WORD
    tdescAlias*: TYPEDESC
    idldescType*: IDLDESC
  SAFEARRAY* {.pure.} = object
    cDims*: USHORT
    fFeatures*: USHORT
    cbElements*: ULONG
    cLocks*: ULONG
    pvData*: PVOID
    rgsabound*: array[1, SAFEARRAYBOUND]
  IRecordInfo* {.pure.} = object
    lpVtbl*: ptr IRecordInfoVtbl
  IRecordInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RecordInit*: proc(self: ptr IRecordInfo, pvNew: PVOID): HRESULT {.stdcall.}
    RecordClear*: proc(self: ptr IRecordInfo, pvExisting: PVOID): HRESULT {.stdcall.}
    RecordCopy*: proc(self: ptr IRecordInfo, pvExisting: PVOID, pvNew: PVOID): HRESULT {.stdcall.}
    GetGuid*: proc(self: ptr IRecordInfo, pguid: ptr GUID): HRESULT {.stdcall.}
    GetName*: proc(self: ptr IRecordInfo, pbstrName: ptr BSTR): HRESULT {.stdcall.}
    GetSize*: proc(self: ptr IRecordInfo, pcbSize: ptr ULONG): HRESULT {.stdcall.}
    GetTypeInfo*: proc(self: ptr IRecordInfo, ppTypeInfo: ptr ptr ITypeInfo): HRESULT {.stdcall.}
    GetField*: proc(self: ptr IRecordInfo, pvData: PVOID, szFieldName: LPCOLESTR, pvarField: ptr VARIANT): HRESULT {.stdcall.}
    GetFieldNoCopy*: proc(self: ptr IRecordInfo, pvData: PVOID, szFieldName: LPCOLESTR, pvarField: ptr VARIANT, ppvDataCArray: ptr PVOID): HRESULT {.stdcall.}
    PutField*: proc(self: ptr IRecordInfo, wFlags: ULONG, pvData: PVOID, szFieldName: LPCOLESTR, pvarField: ptr VARIANT): HRESULT {.stdcall.}
    PutFieldNoCopy*: proc(self: ptr IRecordInfo, wFlags: ULONG, pvData: PVOID, szFieldName: LPCOLESTR, pvarField: ptr VARIANT): HRESULT {.stdcall.}
    GetFieldNames*: proc(self: ptr IRecordInfo, pcNames: ptr ULONG, rgBstrNames: ptr BSTR): HRESULT {.stdcall.}
    IsMatchingType*: proc(self: ptr IRecordInfo, pRecordInfo: ptr IRecordInfo): WINBOOL {.stdcall.}
    RecordCreate*: proc(self: ptr IRecordInfo): PVOID {.stdcall.}
    RecordCreateCopy*: proc(self: ptr IRecordInfo, pvSource: PVOID, ppvDest: ptr PVOID): HRESULT {.stdcall.}
    RecordDestroy*: proc(self: ptr IRecordInfo, pvRecord: PVOID): HRESULT {.stdcall.}
  VARIANT_UNION1_STRUCT1_UNION1_STRUCT1* {.pure.} = object
    pvRecord*: PVOID
    pRecInfo*: ptr IRecordInfo
  VARIANT_UNION1_STRUCT1_UNION1* {.pure, union.} = object
    llVal*: LONGLONG
    lVal*: LONG
    bVal*: BYTE
    iVal*: SHORT
    fltVal*: FLOAT
    dblVal*: DOUBLE
    boolVal*: VARIANT_BOOL
    scode*: SCODE
    cyVal*: CY
    date*: DATE
    bstrVal*: BSTR
    punkVal*: ptr IUnknown
    pdispVal*: ptr IDispatch
    parray*: ptr SAFEARRAY
    pbVal*: ptr BYTE
    piVal*: ptr SHORT
    plVal*: ptr LONG
    pllVal*: ptr LONGLONG
    pfltVal*: ptr FLOAT
    pdblVal*: ptr DOUBLE
    pboolVal*: ptr VARIANT_BOOL
    pscode*: ptr SCODE
    pcyVal*: ptr CY
    pdate*: ptr DATE
    pbstrVal*: ptr BSTR
    ppunkVal*: ptr ptr IUnknown
    ppdispVal*: ptr ptr IDispatch
    pparray*: ptr ptr SAFEARRAY
    pvarVal*: ptr VARIANT
    byref*: PVOID
    cVal*: CHAR
    uiVal*: USHORT
    ulVal*: ULONG
    ullVal*: ULONGLONG
    intVal*: INT
    uintVal*: UINT
    pdecVal*: ptr DECIMAL
    pcVal*: ptr CHAR
    puiVal*: ptr USHORT
    pulVal*: ptr ULONG
    pullVal*: ptr ULONGLONG
    pintVal*: ptr INT
    puintVal*: ptr UINT
    struct1*: VARIANT_UNION1_STRUCT1_UNION1_STRUCT1
  VARIANT_UNION1_STRUCT1* {.pure.} = object
    vt*: VARTYPE
    wReserved1*: WORD
    wReserved2*: WORD
    wReserved3*: WORD
    union1*: VARIANT_UNION1_STRUCT1_UNION1
  VARIANT_UNION1* {.pure, union.} = object
    struct1*: VARIANT_UNION1_STRUCT1
    decVal*: DECIMAL
  VARIANT* {.pure.} = object
    union1*: VARIANT_UNION1
  VARIANTARG* = VARIANT
  PARAMDESCEX* {.pure.} = object
    cBytes*: ULONG
    varDefaultValue*: VARIANTARG
  LPPARAMDESCEX* = ptr PARAMDESCEX
  PARAMDESC* {.pure.} = object
    pparamdescex*: LPPARAMDESCEX
    wParamFlags*: USHORT
  ELEMDESC_UNION1* {.pure, union.} = object
    idldesc*: IDLDESC
    paramdesc*: PARAMDESC
  ELEMDESC* {.pure.} = object
    tdesc*: TYPEDESC
    union1*: ELEMDESC_UNION1
  FUNCDESC* {.pure.} = object
    memid*: MEMBERID
    lprgscode*: ptr SCODE
    lprgelemdescParam*: ptr ELEMDESC
    funckind*: FUNCKIND
    invkind*: INVOKEKIND
    callconv*: CALLCONV
    cParams*: SHORT
    cParamsOpt*: SHORT
    oVft*: SHORT
    cScodes*: SHORT
    elemdescFunc*: ELEMDESC
    wFuncFlags*: WORD
  VARDESC_UNION1* {.pure, union.} = object
    oInst*: ULONG
    lpvarValue*: ptr VARIANT
  VARDESC* {.pure.} = object
    memid*: MEMBERID
    lpstrSchema*: LPOLESTR
    union1*: VARDESC_UNION1
    elemdescVar*: ELEMDESC
    wVarFlags*: WORD
    varkind*: VARKIND
  BINDPTR* {.pure, union.} = object
    lpfuncdesc*: ptr FUNCDESC
    lpvardesc*: ptr VARDESC
    lptcomp*: ptr ITypeComp
  ITypeComp* {.pure.} = object
    lpVtbl*: ptr ITypeCompVtbl
  ITypeCompVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Bind*: proc(self: ptr ITypeComp, szName: LPOLESTR, lHashVal: ULONG, wFlags: WORD, ppTInfo: ptr ptr ITypeInfo, pDescKind: ptr DESCKIND, pBindPtr: ptr BINDPTR): HRESULT {.stdcall.}
    BindType*: proc(self: ptr ITypeComp, szName: LPOLESTR, lHashVal: ULONG, ppTInfo: ptr ptr ITypeInfo, ppTComp: ptr ptr ITypeComp): HRESULT {.stdcall.}
  DISPPARAMS* {.pure.} = object
    rgvarg*: ptr VARIANTARG
    rgdispidNamedArgs*: ptr DISPID
    cArgs*: UINT
    cNamedArgs*: UINT
  EXCEPINFO* {.pure.} = object
    wCode*: WORD
    wReserved*: WORD
    bstrSource*: BSTR
    bstrDescription*: BSTR
    bstrHelpFile*: BSTR
    dwHelpContext*: DWORD
    pvReserved*: PVOID
    pfnDeferredFillIn*: proc(P1: ptr EXCEPINFO): HRESULT {.stdcall.}
    scode*: SCODE
  TLIBATTR* {.pure.} = object
    guid*: GUID
    lcid*: LCID
    syskind*: SYSKIND
    wMajorVerNum*: WORD
    wMinorVerNum*: WORD
    wLibFlags*: WORD
  ITypeLib* {.pure.} = object
    lpVtbl*: ptr ITypeLibVtbl
  ITypeLibVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetTypeInfoCount*: proc(self: ptr ITypeLib): UINT {.stdcall.}
    GetTypeInfo*: proc(self: ptr ITypeLib, index: UINT, ppTInfo: ptr ptr ITypeInfo): HRESULT {.stdcall.}
    GetTypeInfoType*: proc(self: ptr ITypeLib, index: UINT, pTKind: ptr TYPEKIND): HRESULT {.stdcall.}
    GetTypeInfoOfGuid*: proc(self: ptr ITypeLib, guid: REFGUID, ppTinfo: ptr ptr ITypeInfo): HRESULT {.stdcall.}
    GetLibAttr*: proc(self: ptr ITypeLib, ppTLibAttr: ptr ptr TLIBATTR): HRESULT {.stdcall.}
    GetTypeComp*: proc(self: ptr ITypeLib, ppTComp: ptr ptr ITypeComp): HRESULT {.stdcall.}
    GetDocumentation*: proc(self: ptr ITypeLib, index: INT, pBstrName: ptr BSTR, pBstrDocString: ptr BSTR, pdwHelpContext: ptr DWORD, pBstrHelpFile: ptr BSTR): HRESULT {.stdcall.}
    IsName*: proc(self: ptr ITypeLib, szNameBuf: LPOLESTR, lHashVal: ULONG, pfName: ptr WINBOOL): HRESULT {.stdcall.}
    FindName*: proc(self: ptr ITypeLib, szNameBuf: LPOLESTR, lHashVal: ULONG, ppTInfo: ptr ptr ITypeInfo, rgMemId: ptr MEMBERID, pcFound: ptr USHORT): HRESULT {.stdcall.}
    ReleaseTLibAttr*: proc(self: ptr ITypeLib, pTLibAttr: ptr TLIBATTR): void {.stdcall.}
  ITypeInfo* {.pure.} = object
    lpVtbl*: ptr ITypeInfoVtbl
  ITypeInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetTypeAttr*: proc(self: ptr ITypeInfo, ppTypeAttr: ptr ptr TYPEATTR): HRESULT {.stdcall.}
    GetTypeComp*: proc(self: ptr ITypeInfo, ppTComp: ptr ptr ITypeComp): HRESULT {.stdcall.}
    GetFuncDesc*: proc(self: ptr ITypeInfo, index: UINT, ppFuncDesc: ptr ptr FUNCDESC): HRESULT {.stdcall.}
    GetVarDesc*: proc(self: ptr ITypeInfo, index: UINT, ppVarDesc: ptr ptr VARDESC): HRESULT {.stdcall.}
    GetNames*: proc(self: ptr ITypeInfo, memid: MEMBERID, rgBstrNames: ptr BSTR, cMaxNames: UINT, pcNames: ptr UINT): HRESULT {.stdcall.}
    GetRefTypeOfImplType*: proc(self: ptr ITypeInfo, index: UINT, pRefType: ptr HREFTYPE): HRESULT {.stdcall.}
    GetImplTypeFlags*: proc(self: ptr ITypeInfo, index: UINT, pImplTypeFlags: ptr INT): HRESULT {.stdcall.}
    GetIDsOfNames*: proc(self: ptr ITypeInfo, rgszNames: ptr LPOLESTR, cNames: UINT, pMemId: ptr MEMBERID): HRESULT {.stdcall.}
    Invoke*: proc(self: ptr ITypeInfo, pvInstance: PVOID, memid: MEMBERID, wFlags: WORD, pDispParams: ptr DISPPARAMS, pVarResult: ptr VARIANT, pExcepInfo: ptr EXCEPINFO, puArgErr: ptr UINT): HRESULT {.stdcall.}
    GetDocumentation*: proc(self: ptr ITypeInfo, memid: MEMBERID, pBstrName: ptr BSTR, pBstrDocString: ptr BSTR, pdwHelpContext: ptr DWORD, pBstrHelpFile: ptr BSTR): HRESULT {.stdcall.}
    GetDllEntry*: proc(self: ptr ITypeInfo, memid: MEMBERID, invKind: INVOKEKIND, pBstrDllName: ptr BSTR, pBstrName: ptr BSTR, pwOrdinal: ptr WORD): HRESULT {.stdcall.}
    GetRefTypeInfo*: proc(self: ptr ITypeInfo, hRefType: HREFTYPE, ppTInfo: ptr ptr ITypeInfo): HRESULT {.stdcall.}
    AddressOfMember*: proc(self: ptr ITypeInfo, memid: MEMBERID, invKind: INVOKEKIND, ppv: ptr PVOID): HRESULT {.stdcall.}
    CreateInstance*: proc(self: ptr ITypeInfo, pUnkOuter: ptr IUnknown, riid: REFIID, ppvObj: ptr PVOID): HRESULT {.stdcall.}
    GetMops*: proc(self: ptr ITypeInfo, memid: MEMBERID, pBstrMops: ptr BSTR): HRESULT {.stdcall.}
    GetContainingTypeLib*: proc(self: ptr ITypeInfo, ppTLib: ptr ptr ITypeLib, pIndex: ptr UINT): HRESULT {.stdcall.}
    ReleaseTypeAttr*: proc(self: ptr ITypeInfo, pTypeAttr: ptr TYPEATTR): void {.stdcall.}
    ReleaseFuncDesc*: proc(self: ptr ITypeInfo, pFuncDesc: ptr FUNCDESC): void {.stdcall.}
    ReleaseVarDesc*: proc(self: ptr ITypeInfo, pVarDesc: ptr VARDESC): void {.stdcall.}
  IDispatch* {.pure.} = object
    lpVtbl*: ptr IDispatchVtbl
  IDispatchVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetTypeInfoCount*: proc(self: ptr IDispatch, pctinfo: ptr UINT): HRESULT {.stdcall.}
    GetTypeInfo*: proc(self: ptr IDispatch, iTInfo: UINT, lcid: LCID, ppTInfo: ptr ptr ITypeInfo): HRESULT {.stdcall.}
    GetIDsOfNames*: proc(self: ptr IDispatch, riid: REFIID, rgszNames: ptr LPOLESTR, cNames: UINT, lcid: LCID, rgDispId: ptr DISPID): HRESULT {.stdcall.}
    Invoke*: proc(self: ptr IDispatch, dispIdMember: DISPID, riid: REFIID, lcid: LCID, wFlags: WORD, pDispParams: ptr DISPPARAMS, pVarResult: ptr VARIANT, pExcepInfo: ptr EXCEPINFO, puArgErr: ptr UINT): HRESULT {.stdcall.}
  SAFEARR_DISPATCH* {.pure.} = object
    Size*: ULONG
    apDispatch*: ptr ptr IDispatch
  wireBRECORD* {.pure.} = ref object
    fFlags*: ULONG
    clSize*: ULONG
    pRecInfo*: ptr IRecordInfo
    pRecord*: ptr uint8
  wireVARIANT_UNION1* {.pure, union.} = object
    llVal*: LONGLONG
    lVal*: LONG
    bVal*: BYTE
    iVal*: SHORT
    fltVal*: FLOAT
    dblVal*: DOUBLE
    boolVal*: VARIANT_BOOL
    scode*: SCODE
    cyVal*: CY
    date*: DATE
    bstrVal*: wireBSTR
    punkVal*: ptr IUnknown
    pdispVal*: ptr IDispatch
    parray*: wirePSAFEARRAY
    brecVal*: wireBRECORD
    pbVal*: ptr BYTE
    piVal*: ptr SHORT
    plVal*: ptr LONG
    pllVal*: ptr LONGLONG
    pfltVal*: ptr FLOAT
    pdblVal*: ptr DOUBLE
    pboolVal*: ptr VARIANT_BOOL
    pscode*: ptr SCODE
    pcyVal*: ptr CY
    pdate*: ptr DATE
    pbstrVal*: ptr wireBSTR
    ppunkVal*: ptr ptr IUnknown
    ppdispVal*: ptr ptr IDispatch
    pparray*: ptr wirePSAFEARRAY
    pvarVal*: ptr wireVARIANT
    cVal*: CHAR
    uiVal*: USHORT
    ulVal*: ULONG
    ullVal*: ULONGLONG
    intVal*: INT
    uintVal*: UINT
    decVal*: DECIMAL
    pdecVal*: ptr DECIMAL
    pcVal*: ptr CHAR
    puiVal*: ptr USHORT
    pulVal*: ptr ULONG
    pullVal*: ptr ULONGLONG
    pintVal*: ptr INT
    puintVal*: ptr UINT
  wireVARIANT* {.pure.} = ref object
    clSize*: DWORD
    rpcReserved*: DWORD
    vt*: USHORT
    wReserved1*: USHORT
    wReserved2*: USHORT
    wReserved3*: USHORT
    union1*: wireVARIANT_UNION1
  SAFEARR_VARIANT* {.pure.} = object
    Size*: ULONG
    aVariant*: ptr wireVARIANT
  SAFEARR_BRECORD* {.pure.} = object
    Size*: ULONG
    aRecord*: ptr wireBRECORD
  SAFEARR_HAVEIID* {.pure.} = object
    Size*: ULONG
    apUnknown*: ptr ptr IUnknown
    iid*: IID
  BYTE_SIZEDARR* {.pure.} = object
    clSize*: ULONG
    pData*: ptr uint8
  WORD_SIZEDARR* {.pure.} = object
    clSize*: ULONG
    pData*: ptr uint16
  DWORD_SIZEDARR* {.pure.} = object
    clSize*: ULONG
    pData*: ptr ULONG
  HYPER_SIZEDARR* {.pure.} = object
    clSize*: ULONG
    pData*: ptr hyper
  SAFEARRAYUNION_u* {.pure, union.} = object
    BstrStr*: SAFEARR_BSTR
    UnknownStr*: SAFEARR_UNKNOWN
    DispatchStr*: SAFEARR_DISPATCH
    VariantStr*: SAFEARR_VARIANT
    RecordStr*: SAFEARR_BRECORD
    HaveIidStr*: SAFEARR_HAVEIID
    ByteStr*: BYTE_SIZEDARR
    WordStr*: WORD_SIZEDARR
    LongStr*: DWORD_SIZEDARR
    HyperStr*: HYPER_SIZEDARR
  SAFEARRAYUNION* {.pure.} = object
    sfType*: ULONG
    u*: SAFEARRAYUNION_u
  wireSAFEARRAY* {.pure.} = ref object
    cDims*: USHORT
    fFeatures*: USHORT
    cbElements*: ULONG
    cLocks*: ULONG
    uArrayStructs*: SAFEARRAYUNION
    rgsabound*: array[1, SAFEARRAYBOUND]
  wirePSAFEARRAY* = ptr wireSAFEARRAY
  LPSAFEARRAY* = ptr SAFEARRAY
  LPVARIANT* = ptr VARIANT
  LPVARIANTARG* = ptr VARIANT
  REFVARIANT* = ptr VARIANT
  LPPARAMDESC* = ptr PARAMDESC
  LPIDLDESC* = ptr IDLDESC
  LPELEMDESC* = ptr ELEMDESC
  LPTYPEATTR* = ptr TYPEATTR
  LPEXCEPINFO* = ptr EXCEPINFO
  LPFUNCDESC* = ptr FUNCDESC
  LPVARDESC* = ptr VARDESC
  CUSTDATAITEM* {.pure.} = object
    guid*: GUID
    varValue*: VARIANTARG
  LPCUSTDATAITEM* = ptr CUSTDATAITEM
  CUSTDATA* {.pure.} = object
    cCustData*: DWORD
    prgCustData*: LPCUSTDATAITEM
  LPCUSTDATA* = ptr CUSTDATA
  ICreateTypeInfo* {.pure.} = object
    lpVtbl*: ptr ICreateTypeInfoVtbl
  ICreateTypeInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetGuid*: proc(self: ptr ICreateTypeInfo, guid: REFGUID): HRESULT {.stdcall.}
    SetTypeFlags*: proc(self: ptr ICreateTypeInfo, uTypeFlags: UINT): HRESULT {.stdcall.}
    SetDocString*: proc(self: ptr ICreateTypeInfo, pStrDoc: LPOLESTR): HRESULT {.stdcall.}
    SetHelpContext*: proc(self: ptr ICreateTypeInfo, dwHelpContext: DWORD): HRESULT {.stdcall.}
    SetVersion*: proc(self: ptr ICreateTypeInfo, wMajorVerNum: WORD, wMinorVerNum: WORD): HRESULT {.stdcall.}
    AddRefTypeInfo*: proc(self: ptr ICreateTypeInfo, pTInfo: ptr ITypeInfo, phRefType: ptr HREFTYPE): HRESULT {.stdcall.}
    AddFuncDesc*: proc(self: ptr ICreateTypeInfo, index: UINT, pFuncDesc: ptr FUNCDESC): HRESULT {.stdcall.}
    AddImplType*: proc(self: ptr ICreateTypeInfo, index: UINT, hRefType: HREFTYPE): HRESULT {.stdcall.}
    SetImplTypeFlags*: proc(self: ptr ICreateTypeInfo, index: UINT, implTypeFlags: INT): HRESULT {.stdcall.}
    SetAlignment*: proc(self: ptr ICreateTypeInfo, cbAlignment: WORD): HRESULT {.stdcall.}
    SetSchema*: proc(self: ptr ICreateTypeInfo, pStrSchema: LPOLESTR): HRESULT {.stdcall.}
    AddVarDesc*: proc(self: ptr ICreateTypeInfo, index: UINT, pVarDesc: ptr VARDESC): HRESULT {.stdcall.}
    SetFuncAndParamNames*: proc(self: ptr ICreateTypeInfo, index: UINT, rgszNames: ptr LPOLESTR, cNames: UINT): HRESULT {.stdcall.}
    SetVarName*: proc(self: ptr ICreateTypeInfo, index: UINT, szName: LPOLESTR): HRESULT {.stdcall.}
    SetTypeDescAlias*: proc(self: ptr ICreateTypeInfo, pTDescAlias: ptr TYPEDESC): HRESULT {.stdcall.}
    DefineFuncAsDllEntry*: proc(self: ptr ICreateTypeInfo, index: UINT, szDllName: LPOLESTR, szProcName: LPOLESTR): HRESULT {.stdcall.}
    SetFuncDocString*: proc(self: ptr ICreateTypeInfo, index: UINT, szDocString: LPOLESTR): HRESULT {.stdcall.}
    SetVarDocString*: proc(self: ptr ICreateTypeInfo, index: UINT, szDocString: LPOLESTR): HRESULT {.stdcall.}
    SetFuncHelpContext*: proc(self: ptr ICreateTypeInfo, index: UINT, dwHelpContext: DWORD): HRESULT {.stdcall.}
    SetVarHelpContext*: proc(self: ptr ICreateTypeInfo, index: UINT, dwHelpContext: DWORD): HRESULT {.stdcall.}
    SetMops*: proc(self: ptr ICreateTypeInfo, index: UINT, bstrMops: BSTR): HRESULT {.stdcall.}
    SetTypeIdldesc*: proc(self: ptr ICreateTypeInfo, pIdlDesc: ptr IDLDESC): HRESULT {.stdcall.}
    LayOut*: proc(self: ptr ICreateTypeInfo): HRESULT {.stdcall.}
  LPCREATETYPEINFO* = ptr ICreateTypeInfo
  ICreateTypeInfo2* {.pure.} = object
    lpVtbl*: ptr ICreateTypeInfo2Vtbl
  ICreateTypeInfo2Vtbl* {.pure, inheritable.} = object of ICreateTypeInfoVtbl
    DeleteFuncDesc*: proc(self: ptr ICreateTypeInfo2, index: UINT): HRESULT {.stdcall.}
    DeleteFuncDescByMemId*: proc(self: ptr ICreateTypeInfo2, memid: MEMBERID, invKind: INVOKEKIND): HRESULT {.stdcall.}
    DeleteVarDesc*: proc(self: ptr ICreateTypeInfo2, index: UINT): HRESULT {.stdcall.}
    DeleteVarDescByMemId*: proc(self: ptr ICreateTypeInfo2, memid: MEMBERID): HRESULT {.stdcall.}
    DeleteImplType*: proc(self: ptr ICreateTypeInfo2, index: UINT): HRESULT {.stdcall.}
    SetCustData*: proc(self: ptr ICreateTypeInfo2, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    SetFuncCustData*: proc(self: ptr ICreateTypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    SetParamCustData*: proc(self: ptr ICreateTypeInfo2, indexFunc: UINT, indexParam: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    SetVarCustData*: proc(self: ptr ICreateTypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    SetImplTypeCustData*: proc(self: ptr ICreateTypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    SetHelpStringContext*: proc(self: ptr ICreateTypeInfo2, dwHelpStringContext: ULONG): HRESULT {.stdcall.}
    SetFuncHelpStringContext*: proc(self: ptr ICreateTypeInfo2, index: UINT, dwHelpStringContext: ULONG): HRESULT {.stdcall.}
    SetVarHelpStringContext*: proc(self: ptr ICreateTypeInfo2, index: UINT, dwHelpStringContext: ULONG): HRESULT {.stdcall.}
    Invalidate*: proc(self: ptr ICreateTypeInfo2): HRESULT {.stdcall.}
    SetName*: proc(self: ptr ICreateTypeInfo2, szName: LPOLESTR): HRESULT {.stdcall.}
  LPCREATETYPEINFO2* = ptr ICreateTypeInfo2
  ICreateTypeLib* {.pure.} = object
    lpVtbl*: ptr ICreateTypeLibVtbl
  ICreateTypeLibVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateTypeInfo*: proc(self: ptr ICreateTypeLib, szName: LPOLESTR, tkind: TYPEKIND, ppCTInfo: ptr ptr ICreateTypeInfo): HRESULT {.stdcall.}
    SetName*: proc(self: ptr ICreateTypeLib, szName: LPOLESTR): HRESULT {.stdcall.}
    SetVersion*: proc(self: ptr ICreateTypeLib, wMajorVerNum: WORD, wMinorVerNum: WORD): HRESULT {.stdcall.}
    SetGuid*: proc(self: ptr ICreateTypeLib, guid: REFGUID): HRESULT {.stdcall.}
    SetDocString*: proc(self: ptr ICreateTypeLib, szDoc: LPOLESTR): HRESULT {.stdcall.}
    SetHelpFileName*: proc(self: ptr ICreateTypeLib, szHelpFileName: LPOLESTR): HRESULT {.stdcall.}
    SetHelpContext*: proc(self: ptr ICreateTypeLib, dwHelpContext: DWORD): HRESULT {.stdcall.}
    SetLcid*: proc(self: ptr ICreateTypeLib, lcid: LCID): HRESULT {.stdcall.}
    SetLibFlags*: proc(self: ptr ICreateTypeLib, uLibFlags: UINT): HRESULT {.stdcall.}
    SaveAllChanges*: proc(self: ptr ICreateTypeLib): HRESULT {.stdcall.}
  LPCREATETYPELIB* = ptr ICreateTypeLib
  ICreateTypeLib2* {.pure.} = object
    lpVtbl*: ptr ICreateTypeLib2Vtbl
  ICreateTypeLib2Vtbl* {.pure, inheritable.} = object of ICreateTypeLibVtbl
    DeleteTypeInfo*: proc(self: ptr ICreateTypeLib2, szName: LPOLESTR): HRESULT {.stdcall.}
    SetCustData*: proc(self: ptr ICreateTypeLib2, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    SetHelpStringContext*: proc(self: ptr ICreateTypeLib2, dwHelpStringContext: ULONG): HRESULT {.stdcall.}
    SetHelpStringDll*: proc(self: ptr ICreateTypeLib2, szFileName: LPOLESTR): HRESULT {.stdcall.}
  LPCREATETYPELIB2* = ptr ICreateTypeLib2
  LPDISPATCH* = ptr IDispatch
  IEnumVARIANT* {.pure.} = object
    lpVtbl*: ptr IEnumVARIANTVtbl
  IEnumVARIANTVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumVARIANT, celt: ULONG, rgVar: ptr VARIANT, pCeltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumVARIANT, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumVARIANT): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumVARIANT, ppEnum: ptr ptr IEnumVARIANT): HRESULT {.stdcall.}
  LPENUMVARIANT* = ptr IEnumVARIANT
  LPTYPECOMP* = ptr ITypeComp
  LPTYPEINFO* = ptr ITypeInfo
  ITypeInfo2* {.pure.} = object
    lpVtbl*: ptr ITypeInfo2Vtbl
  ITypeInfo2Vtbl* {.pure, inheritable.} = object of ITypeInfoVtbl
    GetTypeKind*: proc(self: ptr ITypeInfo2, pTypeKind: ptr TYPEKIND): HRESULT {.stdcall.}
    GetTypeFlags*: proc(self: ptr ITypeInfo2, pTypeFlags: ptr ULONG): HRESULT {.stdcall.}
    GetFuncIndexOfMemId*: proc(self: ptr ITypeInfo2, memid: MEMBERID, invKind: INVOKEKIND, pFuncIndex: ptr UINT): HRESULT {.stdcall.}
    GetVarIndexOfMemId*: proc(self: ptr ITypeInfo2, memid: MEMBERID, pVarIndex: ptr UINT): HRESULT {.stdcall.}
    GetCustData*: proc(self: ptr ITypeInfo2, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    GetFuncCustData*: proc(self: ptr ITypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    GetParamCustData*: proc(self: ptr ITypeInfo2, indexFunc: UINT, indexParam: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    GetVarCustData*: proc(self: ptr ITypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    GetImplTypeCustData*: proc(self: ptr ITypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    GetDocumentation2*: proc(self: ptr ITypeInfo2, memid: MEMBERID, lcid: LCID, pbstrHelpString: ptr BSTR, pdwHelpStringContext: ptr DWORD, pbstrHelpStringDll: ptr BSTR): HRESULT {.stdcall.}
    GetAllCustData*: proc(self: ptr ITypeInfo2, pCustData: ptr CUSTDATA): HRESULT {.stdcall.}
    GetAllFuncCustData*: proc(self: ptr ITypeInfo2, index: UINT, pCustData: ptr CUSTDATA): HRESULT {.stdcall.}
    GetAllParamCustData*: proc(self: ptr ITypeInfo2, indexFunc: UINT, indexParam: UINT, pCustData: ptr CUSTDATA): HRESULT {.stdcall.}
    GetAllVarCustData*: proc(self: ptr ITypeInfo2, index: UINT, pCustData: ptr CUSTDATA): HRESULT {.stdcall.}
    GetAllImplTypeCustData*: proc(self: ptr ITypeInfo2, index: UINT, pCustData: ptr CUSTDATA): HRESULT {.stdcall.}
  LPTYPEINFO2* = ptr ITypeInfo2
  LPTYPELIB* = ptr ITypeLib
  LPTLIBATTR* = ptr TLIBATTR
  ITypeLib2* {.pure.} = object
    lpVtbl*: ptr ITypeLib2Vtbl
  ITypeLib2Vtbl* {.pure, inheritable.} = object of ITypeLibVtbl
    GetCustData*: proc(self: ptr ITypeLib2, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.stdcall.}
    GetLibStatistics*: proc(self: ptr ITypeLib2, pcUniqueNames: ptr ULONG, pcchUniqueNames: ptr ULONG): HRESULT {.stdcall.}
    GetDocumentation2*: proc(self: ptr ITypeLib2, index: INT, lcid: LCID, pbstrHelpString: ptr BSTR, pdwHelpStringContext: ptr DWORD, pbstrHelpStringDll: ptr BSTR): HRESULT {.stdcall.}
    GetAllCustData*: proc(self: ptr ITypeLib2, pCustData: ptr CUSTDATA): HRESULT {.stdcall.}
  LPTYPELIB2* = ptr ITypeLib2
  ITypeChangeEvents* {.pure.} = object
    lpVtbl*: ptr ITypeChangeEventsVtbl
  ITypeChangeEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RequestTypeChange*: proc(self: ptr ITypeChangeEvents, changeKind: CHANGEKIND, pTInfoBefore: ptr ITypeInfo, pStrName: LPOLESTR, pfCancel: ptr INT): HRESULT {.stdcall.}
    AfterTypeChange*: proc(self: ptr ITypeChangeEvents, changeKind: CHANGEKIND, pTInfoAfter: ptr ITypeInfo, pStrName: LPOLESTR): HRESULT {.stdcall.}
  LPTYPECHANGEEVENTS* = ptr ITypeChangeEvents
  IErrorInfo* {.pure.} = object
    lpVtbl*: ptr IErrorInfoVtbl
  IErrorInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetGUID*: proc(self: ptr IErrorInfo, pGUID: ptr GUID): HRESULT {.stdcall.}
    GetSource*: proc(self: ptr IErrorInfo, pBstrSource: ptr BSTR): HRESULT {.stdcall.}
    GetDescription*: proc(self: ptr IErrorInfo, pBstrDescription: ptr BSTR): HRESULT {.stdcall.}
    GetHelpFile*: proc(self: ptr IErrorInfo, pBstrHelpFile: ptr BSTR): HRESULT {.stdcall.}
    GetHelpContext*: proc(self: ptr IErrorInfo, pdwHelpContext: ptr DWORD): HRESULT {.stdcall.}
  LPERRORINFO* = ptr IErrorInfo
  ICreateErrorInfo* {.pure.} = object
    lpVtbl*: ptr ICreateErrorInfoVtbl
  ICreateErrorInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetGUID*: proc(self: ptr ICreateErrorInfo, rguid: REFGUID): HRESULT {.stdcall.}
    SetSource*: proc(self: ptr ICreateErrorInfo, szSource: LPOLESTR): HRESULT {.stdcall.}
    SetDescription*: proc(self: ptr ICreateErrorInfo, szDescription: LPOLESTR): HRESULT {.stdcall.}
    SetHelpFile*: proc(self: ptr ICreateErrorInfo, szHelpFile: LPOLESTR): HRESULT {.stdcall.}
    SetHelpContext*: proc(self: ptr ICreateErrorInfo, dwHelpContext: DWORD): HRESULT {.stdcall.}
  LPCREATEERRORINFO* = ptr ICreateErrorInfo
  ISupportErrorInfo* {.pure.} = object
    lpVtbl*: ptr ISupportErrorInfoVtbl
  ISupportErrorInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InterfaceSupportsErrorInfo*: proc(self: ptr ISupportErrorInfo, riid: REFIID): HRESULT {.stdcall.}
  LPSUPPORTERRORINFO* = ptr ISupportErrorInfo
  LPRECORDINFO* = ptr IRecordInfo
  IErrorLog* {.pure.} = object
    lpVtbl*: ptr IErrorLogVtbl
  IErrorLogVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddError*: proc(self: ptr IErrorLog, pszPropName: LPCOLESTR, pExcepInfo: ptr EXCEPINFO): HRESULT {.stdcall.}
  LPERRORLOG* = ptr IErrorLog
  IPropertyBag* {.pure.} = object
    lpVtbl*: ptr IPropertyBagVtbl
  IPropertyBagVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Read*: proc(self: ptr IPropertyBag, pszPropName: LPCOLESTR, pVar: ptr VARIANT, pErrorLog: ptr IErrorLog): HRESULT {.stdcall.}
    Write*: proc(self: ptr IPropertyBag, pszPropName: LPCOLESTR, pVar: ptr VARIANT): HRESULT {.stdcall.}
  LPPROPERTYBAG* = ptr IPropertyBag
  PARAMDATA* {.pure.} = object
    szName*: ptr OLECHAR
    vt*: VARTYPE
  LPPARAMDATA* = ptr PARAMDATA
  METHODDATA* {.pure.} = object
    szName*: ptr OLECHAR
    ppdata*: ptr PARAMDATA
    dispid*: DISPID
    iMeth*: UINT
    cc*: CALLCONV
    cArgs*: UINT
    wFlags*: WORD
    vtReturn*: VARTYPE
  LPMETHODDATA* = ptr METHODDATA
  INTERFACEDATA* {.pure.} = object
    pmethdata*: ptr METHODDATA
    cMembers*: UINT
  LPINTERFACEDATA* = ptr INTERFACEDATA
  IOleAdviseHolder* {.pure.} = object
    lpVtbl*: ptr IOleAdviseHolderVtbl
  IOleAdviseHolderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Advise*: proc(self: ptr IOleAdviseHolder, pAdvise: ptr IAdviseSink, pdwConnection: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IOleAdviseHolder, dwConnection: DWORD): HRESULT {.stdcall.}
    EnumAdvise*: proc(self: ptr IOleAdviseHolder, ppenumAdvise: ptr ptr IEnumSTATDATA): HRESULT {.stdcall.}
    SendOnRename*: proc(self: ptr IOleAdviseHolder, pmk: ptr IMoniker): HRESULT {.stdcall.}
    SendOnSave*: proc(self: ptr IOleAdviseHolder): HRESULT {.stdcall.}
    SendOnClose*: proc(self: ptr IOleAdviseHolder): HRESULT {.stdcall.}
  LPOLEADVISEHOLDER* = ptr IOleAdviseHolder
  IOleCache* {.pure.} = object
    lpVtbl*: ptr IOleCacheVtbl
  IOleCacheVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Cache*: proc(self: ptr IOleCache, pformatetc: ptr FORMATETC, advf: DWORD, pdwConnection: ptr DWORD): HRESULT {.stdcall.}
    Uncache*: proc(self: ptr IOleCache, dwConnection: DWORD): HRESULT {.stdcall.}
    EnumCache*: proc(self: ptr IOleCache, ppenumSTATDATA: ptr ptr IEnumSTATDATA): HRESULT {.stdcall.}
    InitCache*: proc(self: ptr IOleCache, pDataObject: ptr IDataObject): HRESULT {.stdcall.}
    SetData*: proc(self: ptr IOleCache, pformatetc: ptr FORMATETC, pmedium: ptr STGMEDIUM, fRelease: WINBOOL): HRESULT {.stdcall.}
  LPOLECACHE* = ptr IOleCache
  IOleCache2* {.pure.} = object
    lpVtbl*: ptr IOleCache2Vtbl
  IOleCache2Vtbl* {.pure, inheritable.} = object of IOleCacheVtbl
    UpdateCache*: proc(self: ptr IOleCache2, pDataObject: LPDATAOBJECT, grfUpdf: DWORD, pReserved: LPVOID): HRESULT {.stdcall.}
    DiscardCache*: proc(self: ptr IOleCache2, dwDiscardOptions: DWORD): HRESULT {.stdcall.}
  LPOLECACHE2* = ptr IOleCache2
  IOleCacheControl* {.pure.} = object
    lpVtbl*: ptr IOleCacheControlVtbl
  IOleCacheControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnRun*: proc(self: ptr IOleCacheControl, pDataObject: LPDATAOBJECT): HRESULT {.stdcall.}
    OnStop*: proc(self: ptr IOleCacheControl): HRESULT {.stdcall.}
  LPOLECACHECONTROL* = ptr IOleCacheControl
  IParseDisplayName* {.pure.} = object
    lpVtbl*: ptr IParseDisplayNameVtbl
  IParseDisplayNameVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParseDisplayName*: proc(self: ptr IParseDisplayName, pbc: ptr IBindCtx, pszDisplayName: LPOLESTR, pchEaten: ptr ULONG, ppmkOut: ptr ptr IMoniker): HRESULT {.stdcall.}
  LPPARSEDISPLAYNAME* = ptr IParseDisplayName
  IOleContainer* {.pure.} = object
    lpVtbl*: ptr IOleContainerVtbl
  IOleContainerVtbl* {.pure, inheritable.} = object of IParseDisplayNameVtbl
    EnumObjects*: proc(self: ptr IOleContainer, grfFlags: DWORD, ppenum: ptr ptr IEnumUnknown): HRESULT {.stdcall.}
    LockContainer*: proc(self: ptr IOleContainer, fLock: WINBOOL): HRESULT {.stdcall.}
  LPOLECONTAINER* = ptr IOleContainer
  IOleClientSite* {.pure.} = object
    lpVtbl*: ptr IOleClientSiteVtbl
  IOleClientSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SaveObject*: proc(self: ptr IOleClientSite): HRESULT {.stdcall.}
    GetMoniker*: proc(self: ptr IOleClientSite, dwAssign: DWORD, dwWhichMoniker: DWORD, ppmk: ptr ptr IMoniker): HRESULT {.stdcall.}
    GetContainer*: proc(self: ptr IOleClientSite, ppContainer: ptr ptr IOleContainer): HRESULT {.stdcall.}
    ShowObject*: proc(self: ptr IOleClientSite): HRESULT {.stdcall.}
    OnShowWindow*: proc(self: ptr IOleClientSite, fShow: WINBOOL): HRESULT {.stdcall.}
    RequestNewObjectLayout*: proc(self: ptr IOleClientSite): HRESULT {.stdcall.}
  LPOLECLIENTSITE* = ptr IOleClientSite
  OLEVERB* {.pure.} = object
    lVerb*: LONG
    lpszVerbName*: LPOLESTR
    fuFlags*: DWORD
    grfAttribs*: DWORD
  LPOLEVERB* = ptr OLEVERB
  IEnumOLEVERB* {.pure.} = object
    lpVtbl*: ptr IEnumOLEVERBVtbl
  IEnumOLEVERBVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumOLEVERB, celt: ULONG, rgelt: LPOLEVERB, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumOLEVERB, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumOLEVERB): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumOLEVERB, ppenum: ptr ptr IEnumOLEVERB): HRESULT {.stdcall.}
  IOleObject* {.pure.} = object
    lpVtbl*: ptr IOleObjectVtbl
  IOleObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetClientSite*: proc(self: ptr IOleObject, pClientSite: ptr IOleClientSite): HRESULT {.stdcall.}
    GetClientSite*: proc(self: ptr IOleObject, ppClientSite: ptr ptr IOleClientSite): HRESULT {.stdcall.}
    SetHostNames*: proc(self: ptr IOleObject, szContainerApp: LPCOLESTR, szContainerObj: LPCOLESTR): HRESULT {.stdcall.}
    Close*: proc(self: ptr IOleObject, dwSaveOption: DWORD): HRESULT {.stdcall.}
    SetMoniker*: proc(self: ptr IOleObject, dwWhichMoniker: DWORD, pmk: ptr IMoniker): HRESULT {.stdcall.}
    GetMoniker*: proc(self: ptr IOleObject, dwAssign: DWORD, dwWhichMoniker: DWORD, ppmk: ptr ptr IMoniker): HRESULT {.stdcall.}
    InitFromData*: proc(self: ptr IOleObject, pDataObject: ptr IDataObject, fCreation: WINBOOL, dwReserved: DWORD): HRESULT {.stdcall.}
    GetClipboardData*: proc(self: ptr IOleObject, dwReserved: DWORD, ppDataObject: ptr ptr IDataObject): HRESULT {.stdcall.}
    DoVerb*: proc(self: ptr IOleObject, iVerb: LONG, lpmsg: LPMSG, pActiveSite: ptr IOleClientSite, lindex: LONG, hwndParent: HWND, lprcPosRect: LPCRECT): HRESULT {.stdcall.}
    EnumVerbs*: proc(self: ptr IOleObject, ppEnumOleVerb: ptr ptr IEnumOLEVERB): HRESULT {.stdcall.}
    Update*: proc(self: ptr IOleObject): HRESULT {.stdcall.}
    IsUpToDate*: proc(self: ptr IOleObject): HRESULT {.stdcall.}
    GetUserClassID*: proc(self: ptr IOleObject, pClsid: ptr CLSID): HRESULT {.stdcall.}
    GetUserType*: proc(self: ptr IOleObject, dwFormOfType: DWORD, pszUserType: ptr LPOLESTR): HRESULT {.stdcall.}
    SetExtent*: proc(self: ptr IOleObject, dwDrawAspect: DWORD, psizel: ptr SIZEL): HRESULT {.stdcall.}
    GetExtent*: proc(self: ptr IOleObject, dwDrawAspect: DWORD, psizel: ptr SIZEL): HRESULT {.stdcall.}
    Advise*: proc(self: ptr IOleObject, pAdvSink: ptr IAdviseSink, pdwConnection: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IOleObject, dwConnection: DWORD): HRESULT {.stdcall.}
    EnumAdvise*: proc(self: ptr IOleObject, ppenumAdvise: ptr ptr IEnumSTATDATA): HRESULT {.stdcall.}
    GetMiscStatus*: proc(self: ptr IOleObject, dwAspect: DWORD, pdwStatus: ptr DWORD): HRESULT {.stdcall.}
    SetColorScheme*: proc(self: ptr IOleObject, pLogpal: ptr LOGPALETTE): HRESULT {.stdcall.}
  LPOLEOBJECT* = ptr IOleObject
  LPOLERENDER* = ptr OLERENDER
  OBJECTDESCRIPTOR* {.pure.} = object
    cbSize*: ULONG
    clsid*: CLSID
    dwDrawAspect*: DWORD
    sizel*: SIZEL
    pointl*: POINTL
    dwStatus*: DWORD
    dwFullUserTypeName*: DWORD
    dwSrcOfCopy*: DWORD
  POBJECTDESCRIPTOR* = ptr OBJECTDESCRIPTOR
  LPOBJECTDESCRIPTOR* = ptr OBJECTDESCRIPTOR
  LINKSRCDESCRIPTOR* = OBJECTDESCRIPTOR
  PLINKSRCDESCRIPTOR* = ptr OBJECTDESCRIPTOR
  LPLINKSRCDESCRIPTOR* = ptr OBJECTDESCRIPTOR
  IOleWindow* {.pure.} = object
    lpVtbl*: ptr IOleWindowVtbl
  IOleWindowVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetWindow*: proc(self: ptr IOleWindow, phwnd: ptr HWND): HRESULT {.stdcall.}
    ContextSensitiveHelp*: proc(self: ptr IOleWindow, fEnterMode: WINBOOL): HRESULT {.stdcall.}
  LPOLEWINDOW* = ptr IOleWindow
  IOleLink* {.pure.} = object
    lpVtbl*: ptr IOleLinkVtbl
  IOleLinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetUpdateOptions*: proc(self: ptr IOleLink, dwUpdateOpt: DWORD): HRESULT {.stdcall.}
    GetUpdateOptions*: proc(self: ptr IOleLink, pdwUpdateOpt: ptr DWORD): HRESULT {.stdcall.}
    SetSourceMoniker*: proc(self: ptr IOleLink, pmk: ptr IMoniker, rclsid: REFCLSID): HRESULT {.stdcall.}
    GetSourceMoniker*: proc(self: ptr IOleLink, ppmk: ptr ptr IMoniker): HRESULT {.stdcall.}
    SetSourceDisplayName*: proc(self: ptr IOleLink, pszStatusText: LPCOLESTR): HRESULT {.stdcall.}
    GetSourceDisplayName*: proc(self: ptr IOleLink, ppszDisplayName: ptr LPOLESTR): HRESULT {.stdcall.}
    BindToSource*: proc(self: ptr IOleLink, bindflags: DWORD, pbc: ptr IBindCtx): HRESULT {.stdcall.}
    BindIfRunning*: proc(self: ptr IOleLink): HRESULT {.stdcall.}
    GetBoundSource*: proc(self: ptr IOleLink, ppunk: ptr ptr IUnknown): HRESULT {.stdcall.}
    UnbindSource*: proc(self: ptr IOleLink): HRESULT {.stdcall.}
    Update*: proc(self: ptr IOleLink, pbc: ptr IBindCtx): HRESULT {.stdcall.}
  LPOLELINK* = ptr IOleLink
  LPOLEUPDATE* = ptr OLEUPDATE
  POLEUPDATE* = ptr OLEUPDATE
  IOleItemContainer* {.pure.} = object
    lpVtbl*: ptr IOleItemContainerVtbl
  IOleItemContainerVtbl* {.pure, inheritable.} = object of IOleContainerVtbl
    GetObject*: proc(self: ptr IOleItemContainer, pszItem: LPOLESTR, dwSpeedNeeded: DWORD, pbc: ptr IBindCtx, riid: REFIID, ppvObject: ptr pointer): HRESULT {.stdcall.}
    GetObjectStorage*: proc(self: ptr IOleItemContainer, pszItem: LPOLESTR, pbc: ptr IBindCtx, riid: REFIID, ppvStorage: ptr pointer): HRESULT {.stdcall.}
    IsRunning*: proc(self: ptr IOleItemContainer, pszItem: LPOLESTR): HRESULT {.stdcall.}
  LPOLEITEMCONTAINER* = ptr IOleItemContainer
  LPCBORDERWIDTHS* = LPCRECT
  IOleInPlaceActiveObject* {.pure.} = object
    lpVtbl*: ptr IOleInPlaceActiveObjectVtbl
  IOleInPlaceActiveObjectVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    TranslateAccelerator*: proc(self: ptr IOleInPlaceActiveObject, lpmsg: LPMSG): HRESULT {.stdcall.}
    OnFrameWindowActivate*: proc(self: ptr IOleInPlaceActiveObject, fActivate: WINBOOL): HRESULT {.stdcall.}
    OnDocWindowActivate*: proc(self: ptr IOleInPlaceActiveObject, fActivate: WINBOOL): HRESULT {.stdcall.}
    ResizeBorder*: proc(self: ptr IOleInPlaceActiveObject, prcBorder: LPCRECT, pUIWindow: ptr IOleInPlaceUIWindow, fFrameWindow: WINBOOL): HRESULT {.stdcall.}
    EnableModeless*: proc(self: ptr IOleInPlaceActiveObject, fEnable: WINBOOL): HRESULT {.stdcall.}
  IOleInPlaceUIWindow* {.pure.} = object
    lpVtbl*: ptr IOleInPlaceUIWindowVtbl
  IOleInPlaceUIWindowVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    GetBorder*: proc(self: ptr IOleInPlaceUIWindow, lprectBorder: LPRECT): HRESULT {.stdcall.}
    RequestBorderSpace*: proc(self: ptr IOleInPlaceUIWindow, pborderwidths: LPCBORDERWIDTHS): HRESULT {.stdcall.}
    SetBorderSpace*: proc(self: ptr IOleInPlaceUIWindow, pborderwidths: LPCBORDERWIDTHS): HRESULT {.stdcall.}
    SetActiveObject*: proc(self: ptr IOleInPlaceUIWindow, pActiveObject: ptr IOleInPlaceActiveObject, pszObjName: LPCOLESTR): HRESULT {.stdcall.}
  LPOLEINPLACEUIWINDOW* = ptr IOleInPlaceUIWindow
  BORDERWIDTHS* = RECT
  LPBORDERWIDTHS* = LPRECT
  LPOLEINPLACEACTIVEOBJECT* = ptr IOleInPlaceActiveObject
  OLEMENUGROUPWIDTHS* {.pure.} = object
    width*: array[6, LONG]
  LPOLEMENUGROUPWIDTHS* = ptr OLEMENUGROUPWIDTHS
  HOLEMENU* = HGLOBAL
  IOleInPlaceFrame* {.pure.} = object
    lpVtbl*: ptr IOleInPlaceFrameVtbl
  IOleInPlaceFrameVtbl* {.pure, inheritable.} = object of IOleInPlaceUIWindowVtbl
    InsertMenus*: proc(self: ptr IOleInPlaceFrame, hmenuShared: HMENU, lpMenuWidths: LPOLEMENUGROUPWIDTHS): HRESULT {.stdcall.}
    SetMenu*: proc(self: ptr IOleInPlaceFrame, hmenuShared: HMENU, holemenu: HOLEMENU, hwndActiveObject: HWND): HRESULT {.stdcall.}
    RemoveMenus*: proc(self: ptr IOleInPlaceFrame, hmenuShared: HMENU): HRESULT {.stdcall.}
    SetStatusText*: proc(self: ptr IOleInPlaceFrame, pszStatusText: LPCOLESTR): HRESULT {.stdcall.}
    EnableModeless*: proc(self: ptr IOleInPlaceFrame, fEnable: WINBOOL): HRESULT {.stdcall.}
    TranslateAccelerator*: proc(self: ptr IOleInPlaceFrame, lpmsg: LPMSG, wID: WORD): HRESULT {.stdcall.}
  LPOLEINPLACEFRAME* = ptr IOleInPlaceFrame
  IOleInPlaceObject* {.pure.} = object
    lpVtbl*: ptr IOleInPlaceObjectVtbl
  IOleInPlaceObjectVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    InPlaceDeactivate*: proc(self: ptr IOleInPlaceObject): HRESULT {.stdcall.}
    UIDeactivate*: proc(self: ptr IOleInPlaceObject): HRESULT {.stdcall.}
    SetObjectRects*: proc(self: ptr IOleInPlaceObject, lprcPosRect: LPCRECT, lprcClipRect: LPCRECT): HRESULT {.stdcall.}
    ReactivateAndUndo*: proc(self: ptr IOleInPlaceObject): HRESULT {.stdcall.}
  LPOLEINPLACEOBJECT* = ptr IOleInPlaceObject
  OLEINPLACEFRAMEINFO* {.pure.} = object
    cb*: UINT
    fMDIApp*: WINBOOL
    hwndFrame*: HWND
    haccel*: HACCEL
    cAccelEntries*: UINT
  LPOLEINPLACEFRAMEINFO* = ptr OLEINPLACEFRAMEINFO
  IOleInPlaceSite* {.pure.} = object
    lpVtbl*: ptr IOleInPlaceSiteVtbl
  IOleInPlaceSiteVtbl* {.pure, inheritable.} = object of IOleWindowVtbl
    CanInPlaceActivate*: proc(self: ptr IOleInPlaceSite): HRESULT {.stdcall.}
    OnInPlaceActivate*: proc(self: ptr IOleInPlaceSite): HRESULT {.stdcall.}
    OnUIActivate*: proc(self: ptr IOleInPlaceSite): HRESULT {.stdcall.}
    GetWindowContext*: proc(self: ptr IOleInPlaceSite, ppFrame: ptr ptr IOleInPlaceFrame, ppDoc: ptr ptr IOleInPlaceUIWindow, lprcPosRect: LPRECT, lprcClipRect: LPRECT, lpFrameInfo: LPOLEINPLACEFRAMEINFO): HRESULT {.stdcall.}
    Scroll*: proc(self: ptr IOleInPlaceSite, scrollExtant: SIZE): HRESULT {.stdcall.}
    OnUIDeactivate*: proc(self: ptr IOleInPlaceSite, fUndoable: WINBOOL): HRESULT {.stdcall.}
    OnInPlaceDeactivate*: proc(self: ptr IOleInPlaceSite): HRESULT {.stdcall.}
    DiscardUndoState*: proc(self: ptr IOleInPlaceSite): HRESULT {.stdcall.}
    DeactivateAndUndo*: proc(self: ptr IOleInPlaceSite): HRESULT {.stdcall.}
    OnPosRectChange*: proc(self: ptr IOleInPlaceSite, lprcPosRect: LPCRECT): HRESULT {.stdcall.}
  LPOLEINPLACESITE* = ptr IOleInPlaceSite
  IViewObject* {.pure.} = object
    lpVtbl*: ptr IViewObjectVtbl
  IViewObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Draw*: proc(self: ptr IViewObject, dwDrawAspect: DWORD, lindex: LONG, pvAspect: pointer, ptd: ptr DVTARGETDEVICE, hdcTargetDev: HDC, hdcDraw: HDC, lprcBounds: LPCRECTL, lprcWBounds: LPCRECTL, pfnContinue: proc (dwContinue: ULONG_PTR): WINBOOL {.stdcall.}, dwContinue: ULONG_PTR): HRESULT {.stdcall.}
    GetColorSet*: proc(self: ptr IViewObject, dwDrawAspect: DWORD, lindex: LONG, pvAspect: pointer, ptd: ptr DVTARGETDEVICE, hicTargetDev: HDC, ppColorSet: ptr ptr LOGPALETTE): HRESULT {.stdcall.}
    Freeze*: proc(self: ptr IViewObject, dwDrawAspect: DWORD, lindex: LONG, pvAspect: pointer, pdwFreeze: ptr DWORD): HRESULT {.stdcall.}
    Unfreeze*: proc(self: ptr IViewObject, dwFreeze: DWORD): HRESULT {.stdcall.}
    SetAdvise*: proc(self: ptr IViewObject, aspects: DWORD, advf: DWORD, pAdvSink: ptr IAdviseSink): HRESULT {.stdcall.}
    GetAdvise*: proc(self: ptr IViewObject, pAspects: ptr DWORD, pAdvf: ptr DWORD, ppAdvSink: ptr ptr IAdviseSink): HRESULT {.stdcall.}
  LPVIEWOBJECT* = ptr IViewObject
  IViewObject2* {.pure.} = object
    lpVtbl*: ptr IViewObject2Vtbl
  IViewObject2Vtbl* {.pure, inheritable.} = object of IViewObjectVtbl
    GetExtent*: proc(self: ptr IViewObject2, dwDrawAspect: DWORD, lindex: LONG, ptd: ptr DVTARGETDEVICE, lpsizel: LPSIZEL): HRESULT {.stdcall.}
  LPVIEWOBJECT2* = ptr IViewObject2
  IDropSource* {.pure.} = object
    lpVtbl*: ptr IDropSourceVtbl
  IDropSourceVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryContinueDrag*: proc(self: ptr IDropSource, fEscapePressed: WINBOOL, grfKeyState: DWORD): HRESULT {.stdcall.}
    GiveFeedback*: proc(self: ptr IDropSource, dwEffect: DWORD): HRESULT {.stdcall.}
  LPDROPSOURCE* = ptr IDropSource
  IDropTarget* {.pure.} = object
    lpVtbl*: ptr IDropTargetVtbl
  IDropTargetVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    DragEnter*: proc(self: ptr IDropTarget, pDataObj: ptr IDataObject, grfKeyState: DWORD, pt: POINTL, pdwEffect: ptr DWORD): HRESULT {.stdcall.}
    DragOver*: proc(self: ptr IDropTarget, grfKeyState: DWORD, pt: POINTL, pdwEffect: ptr DWORD): HRESULT {.stdcall.}
    DragLeave*: proc(self: ptr IDropTarget): HRESULT {.stdcall.}
    Drop*: proc(self: ptr IDropTarget, pDataObj: ptr IDataObject, grfKeyState: DWORD, pt: POINTL, pdwEffect: ptr DWORD): HRESULT {.stdcall.}
  LPDROPTARGET* = ptr IDropTarget
  LPENUMOLEVERB* = ptr IEnumOLEVERB
  OLESTREAMVTBL* {.pure.} = object
    Get*: proc(P1: LPOLESTREAM, P2: pointer, P3: DWORD): DWORD {.stdcall.}
    Put*: proc(P1: LPOLESTREAM, P2: pointer, P3: DWORD): DWORD {.stdcall.}
  LPOLESTREAMVTBL* = ptr OLESTREAMVTBL
  OLESTREAM* {.pure.} = object
    lpstbl*: LPOLESTREAMVTBL
  LPOLESTREAM* = ptr OLESTREAM
  PSCODE* = ptr SCODE
  UP_BYTE_BLOB* = ptr BYTE_BLOB
  WORD_BLOB* {.pure.} = object
    clSize*: ULONG
    asData*: array[1, uint16]
  UP_WORD_BLOB* = ptr WORD_BLOB
  DWORD_BLOB* {.pure.} = object
    clSize*: ULONG
    alData*: array[1, ULONG]
  UP_DWORD_BLOB* = ptr DWORD_BLOB
  UP_FLAGGED_BYTE_BLOB* = ptr FLAGGED_BYTE_BLOB
  UP_FLAGGED_WORD_BLOB* = ptr FLAGGED_WORD_BLOB
  ServerInformation* {.pure.} = object
    dwServerPid*: DWORD
    dwServerTid*: DWORD
    ui64ServerAddress*: UINT64
  PServerInformation* = ptr ServerInformation
  IServiceProvider* {.pure.} = object
    lpVtbl*: ptr IServiceProviderVtbl
  IServiceProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryService*: proc(self: ptr IServiceProvider, guidService: REFGUID, riid: REFIID, ppvObject: ptr pointer): HRESULT {.stdcall.}
  LPSERVICEPROVIDER* = ptr IServiceProvider
  IPersistMoniker* {.pure.} = object
    lpVtbl*: ptr IPersistMonikerVtbl
  IPersistMonikerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetClassID*: proc(self: ptr IPersistMoniker, pClassID: ptr CLSID): HRESULT {.stdcall.}
    IsDirty*: proc(self: ptr IPersistMoniker): HRESULT {.stdcall.}
    Load*: proc(self: ptr IPersistMoniker, fFullyAvailable: WINBOOL, pimkName: ptr IMoniker, pibc: LPBC, grfMode: DWORD): HRESULT {.stdcall.}
    Save*: proc(self: ptr IPersistMoniker, pimkName: ptr IMoniker, pbc: LPBC, fRemember: WINBOOL): HRESULT {.stdcall.}
    SaveCompleted*: proc(self: ptr IPersistMoniker, pimkName: ptr IMoniker, pibc: LPBC): HRESULT {.stdcall.}
    GetCurMoniker*: proc(self: ptr IPersistMoniker, ppimkName: ptr ptr IMoniker): HRESULT {.stdcall.}
  LPPERSISTMONIKER* = ptr IPersistMoniker
  IMonikerProp* {.pure.} = object
    lpVtbl*: ptr IMonikerPropVtbl
  IMonikerPropVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    PutProperty*: proc(self: ptr IMonikerProp, mkp: MONIKERPROPERTY, val: LPCWSTR): HRESULT {.stdcall.}
  LPMONIKERPROP* = ptr IMonikerProp
  IBinding* {.pure.} = object
    lpVtbl*: ptr IBindingVtbl
  IBindingVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Abort*: proc(self: ptr IBinding): HRESULT {.stdcall.}
    Suspend*: proc(self: ptr IBinding): HRESULT {.stdcall.}
    Resume*: proc(self: ptr IBinding): HRESULT {.stdcall.}
    SetPriority*: proc(self: ptr IBinding, nPriority: LONG): HRESULT {.stdcall.}
    GetPriority*: proc(self: ptr IBinding, pnPriority: ptr LONG): HRESULT {.stdcall.}
    GetBindResult*: proc(self: ptr IBinding, pclsidProtocol: ptr CLSID, pdwResult: ptr DWORD, pszResult: ptr LPOLESTR, pdwReserved: ptr DWORD): HRESULT {.stdcall.}
  IBindProtocol* {.pure.} = object
    lpVtbl*: ptr IBindProtocolVtbl
  IBindProtocolVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateBinding*: proc(self: ptr IBindProtocol, szUrl: LPCWSTR, pbc: ptr IBindCtx, ppb: ptr ptr IBinding): HRESULT {.stdcall.}
  LPBINDPROTOCOL* = ptr IBindProtocol
  LPBINDING* = ptr IBinding
  BINDINFO* {.pure.} = object
    cbSize*: ULONG
    szExtraInfo*: LPWSTR
    stgmedData*: STGMEDIUM
    grfBindInfoF*: DWORD
    dwBindVerb*: DWORD
    szCustomVerb*: LPWSTR
    cbstgmedData*: DWORD
    dwOptions*: DWORD
    dwOptionsFlags*: DWORD
    dwCodePage*: DWORD
    securityAttributes*: SECURITY_ATTRIBUTES
    iid*: IID
    pUnk*: ptr IUnknown
    dwReserved*: DWORD
  IBindStatusCallback* {.pure.} = object
    lpVtbl*: ptr IBindStatusCallbackVtbl
  IBindStatusCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnStartBinding*: proc(self: ptr IBindStatusCallback, dwReserved: DWORD, pib: ptr IBinding): HRESULT {.stdcall.}
    GetPriority*: proc(self: ptr IBindStatusCallback, pnPriority: ptr LONG): HRESULT {.stdcall.}
    OnLowResource*: proc(self: ptr IBindStatusCallback, reserved: DWORD): HRESULT {.stdcall.}
    OnProgress*: proc(self: ptr IBindStatusCallback, ulProgress: ULONG, ulProgressMax: ULONG, ulStatusCode: ULONG, szStatusText: LPCWSTR): HRESULT {.stdcall.}
    OnStopBinding*: proc(self: ptr IBindStatusCallback, hresult: HRESULT, szError: LPCWSTR): HRESULT {.stdcall.}
    GetBindInfo*: proc(self: ptr IBindStatusCallback, grfBINDF: ptr DWORD, pbindinfo: ptr BINDINFO): HRESULT {.stdcall.}
    OnDataAvailable*: proc(self: ptr IBindStatusCallback, grfBSCF: DWORD, dwSize: DWORD, pformatetc: ptr FORMATETC, pstgmed: ptr STGMEDIUM): HRESULT {.stdcall.}
    OnObjectAvailable*: proc(self: ptr IBindStatusCallback, riid: REFIID, punk: ptr IUnknown): HRESULT {.stdcall.}
  LPBINDSTATUSCALLBACK* = ptr IBindStatusCallback
  REMSECURITY_ATTRIBUTES* {.pure.} = object
    nLength*: DWORD
    lpSecurityDescriptor*: DWORD
    bInheritHandle*: WINBOOL
  PREMSECURITY_ATTRIBUTES* = ptr REMSECURITY_ATTRIBUTES
  LPREMSECURITY_ATTRIBUTES* = ptr REMSECURITY_ATTRIBUTES
  RemFORMATETC* {.pure.} = object
    cfFormat*: DWORD
    ptd*: DWORD
    dwAspect*: DWORD
    lindex*: LONG
    tymed*: DWORD
  LPREMFORMATETC* = ptr RemFORMATETC
  IBindStatusCallbackEx* {.pure.} = object
    lpVtbl*: ptr IBindStatusCallbackExVtbl
  IBindStatusCallbackExVtbl* {.pure, inheritable.} = object of IBindStatusCallbackVtbl
    GetBindInfoEx*: proc(self: ptr IBindStatusCallbackEx, grfBINDF: ptr DWORD, pbindinfo: ptr BINDINFO, grfBINDF2: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.stdcall.}
  LPBINDSTATUSCALLBACKEX* = ptr IBindStatusCallbackEx
  IAuthenticate* {.pure.} = object
    lpVtbl*: ptr IAuthenticateVtbl
  IAuthenticateVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Authenticate*: proc(self: ptr IAuthenticate, phwnd: ptr HWND, pszUsername: ptr LPWSTR, pszPassword: ptr LPWSTR): HRESULT {.stdcall.}
  LPAUTHENTICATION* = ptr IAuthenticate
  AUTHENTICATEINFO* {.pure.} = object
    dwFlags*: DWORD
    dwReserved*: DWORD
  IAuthenticateEx* {.pure.} = object
    lpVtbl*: ptr IAuthenticateExVtbl
  IAuthenticateExVtbl* {.pure, inheritable.} = object of IAuthenticateVtbl
    AuthenticateEx*: proc(self: ptr IAuthenticateEx, phwnd: ptr HWND, pszUsername: ptr LPWSTR, pszPassword: ptr LPWSTR, pauthinfo: ptr AUTHENTICATEINFO): HRESULT {.stdcall.}
  LPAUTHENTICATIONEX* = ptr IAuthenticateEx
  IHttpNegotiate* {.pure.} = object
    lpVtbl*: ptr IHttpNegotiateVtbl
  IHttpNegotiateVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    BeginningTransaction*: proc(self: ptr IHttpNegotiate, szURL: LPCWSTR, szHeaders: LPCWSTR, dwReserved: DWORD, pszAdditionalHeaders: ptr LPWSTR): HRESULT {.stdcall.}
    OnResponse*: proc(self: ptr IHttpNegotiate, dwResponseCode: DWORD, szResponseHeaders: LPCWSTR, szRequestHeaders: LPCWSTR, pszAdditionalRequestHeaders: ptr LPWSTR): HRESULT {.stdcall.}
  LPHTTPNEGOTIATE* = ptr IHttpNegotiate
  IHttpNegotiate2* {.pure.} = object
    lpVtbl*: ptr IHttpNegotiate2Vtbl
  IHttpNegotiate2Vtbl* {.pure, inheritable.} = object of IHttpNegotiateVtbl
    GetRootSecurityId*: proc(self: ptr IHttpNegotiate2, pbSecurityId: ptr BYTE, pcbSecurityId: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.stdcall.}
  LPHTTPNEGOTIATE2* = ptr IHttpNegotiate2
  IHttpNegotiate3* {.pure.} = object
    lpVtbl*: ptr IHttpNegotiate3Vtbl
  IHttpNegotiate3Vtbl* {.pure, inheritable.} = object of IHttpNegotiate2Vtbl
    GetSerializedClientCertContext*: proc(self: ptr IHttpNegotiate3, ppbCert: ptr ptr BYTE, pcbCert: ptr DWORD): HRESULT {.stdcall.}
  LPHTTPNEGOTIATE3* = ptr IHttpNegotiate3
  IWinInetFileStream* {.pure.} = object
    lpVtbl*: ptr IWinInetFileStreamVtbl
  IWinInetFileStreamVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetHandleForUnlock*: proc(self: ptr IWinInetFileStream, hWinInetLockHandle: DWORD_PTR, dwReserved: DWORD_PTR): HRESULT {.stdcall.}
    SetDeleteFile*: proc(self: ptr IWinInetFileStream, dwReserved: DWORD_PTR): HRESULT {.stdcall.}
  LPWININETFILESTREAM* = ptr IWinInetFileStream
  IWindowForBindingUI* {.pure.} = object
    lpVtbl*: ptr IWindowForBindingUIVtbl
  IWindowForBindingUIVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetWindow*: proc(self: ptr IWindowForBindingUI, rguidReason: REFGUID, phwnd: ptr HWND): HRESULT {.stdcall.}
  LPWINDOWFORBINDINGUI* = ptr IWindowForBindingUI
  ICodeInstall* {.pure.} = object
    lpVtbl*: ptr ICodeInstallVtbl
  ICodeInstallVtbl* {.pure, inheritable.} = object of IWindowForBindingUIVtbl
    OnCodeInstallProblem*: proc(self: ptr ICodeInstall, ulStatusCode: ULONG, szDestination: LPCWSTR, szSource: LPCWSTR, dwReserved: DWORD): HRESULT {.stdcall.}
  LPCODEINSTALL* = ptr ICodeInstall
  IWinInetInfo* {.pure.} = object
    lpVtbl*: ptr IWinInetInfoVtbl
  IWinInetInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryOption*: proc(self: ptr IWinInetInfo, dwOption: DWORD, pBuffer: LPVOID, pcbBuf: ptr DWORD): HRESULT {.stdcall.}
  LPWININETINFO* = ptr IWinInetInfo
  IHttpSecurity* {.pure.} = object
    lpVtbl*: ptr IHttpSecurityVtbl
  IHttpSecurityVtbl* {.pure, inheritable.} = object of IWindowForBindingUIVtbl
    OnSecurityProblem*: proc(self: ptr IHttpSecurity, dwProblem: DWORD): HRESULT {.stdcall.}
  LPHTTPSECURITY* = ptr IHttpSecurity
  IWinInetHttpInfo* {.pure.} = object
    lpVtbl*: ptr IWinInetHttpInfoVtbl
  IWinInetHttpInfoVtbl* {.pure, inheritable.} = object of IWinInetInfoVtbl
    QueryInfo*: proc(self: ptr IWinInetHttpInfo, dwOption: DWORD, pBuffer: LPVOID, pcbBuf: ptr DWORD, pdwFlags: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.stdcall.}
  LPWININETHTTPINFO* = ptr IWinInetHttpInfo
  IWinInetCacheHints* {.pure.} = object
    lpVtbl*: ptr IWinInetCacheHintsVtbl
  IWinInetCacheHintsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetCacheExtension*: proc(self: ptr IWinInetCacheHints, pwzExt: LPCWSTR, pszCacheFile: LPVOID, pcbCacheFile: ptr DWORD, pdwWinInetError: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.stdcall.}
  LPWININETCACHEHINTS* = ptr IWinInetCacheHints
  IWinInetCacheHints2* {.pure.} = object
    lpVtbl*: ptr IWinInetCacheHints2Vtbl
  IWinInetCacheHints2Vtbl* {.pure, inheritable.} = object of IWinInetCacheHintsVtbl
    SetCacheExtension2*: proc(self: ptr IWinInetCacheHints2, pwzExt: LPCWSTR, pwzCacheFile: ptr WCHAR, pcchCacheFile: ptr DWORD, pdwWinInetError: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.stdcall.}
  LPWININETCACHEHINTS2* = ptr IWinInetCacheHints2
  IBindHost* {.pure.} = object
    lpVtbl*: ptr IBindHostVtbl
  IBindHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateMoniker*: proc(self: ptr IBindHost, szName: LPOLESTR, pBC: ptr IBindCtx, ppmk: ptr ptr IMoniker, dwReserved: DWORD): HRESULT {.stdcall.}
    MonikerBindToStorage*: proc(self: ptr IBindHost, pMk: ptr IMoniker, pBC: ptr IBindCtx, pBSC: ptr IBindStatusCallback, riid: REFIID, ppvObj: ptr pointer): HRESULT {.stdcall.}
    MonikerBindToObject*: proc(self: ptr IBindHost, pMk: ptr IMoniker, pBC: ptr IBindCtx, pBSC: ptr IBindStatusCallback, riid: REFIID, ppvObj: ptr pointer): HRESULT {.stdcall.}
  LPBINDHOST* = ptr IBindHost
  IInternet* {.pure.} = object
    lpVtbl*: ptr IInternetVtbl
  IInternetVtbl* {.pure, inheritable.} = object of IUnknownVtbl
  LPIINTERNET* = ptr IInternet
  IInternetBindInfo* {.pure.} = object
    lpVtbl*: ptr IInternetBindInfoVtbl
  IInternetBindInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetBindInfo*: proc(self: ptr IInternetBindInfo, grfBINDF: ptr DWORD, pbindinfo: ptr BINDINFO): HRESULT {.stdcall.}
    GetBindString*: proc(self: ptr IInternetBindInfo, ulStringType: ULONG, ppwzStr: ptr LPOLESTR, cEl: ULONG, pcElFetched: ptr ULONG): HRESULT {.stdcall.}
  LPIINTERNETBINDINFO* = ptr IInternetBindInfo
  IInternetBindInfoEx* {.pure.} = object
    lpVtbl*: ptr IInternetBindInfoExVtbl
  IInternetBindInfoExVtbl* {.pure, inheritable.} = object of IInternetBindInfoVtbl
    GetBindInfoEx*: proc(self: ptr IInternetBindInfoEx, grfBINDF: ptr DWORD, pbindinfo: ptr BINDINFO, grfBINDF2: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.stdcall.}
  LPIINTERNETBINDINFOEX* = ptr IInternetBindInfoEx
  PROTOCOLDATA* {.pure.} = object
    grfFlags*: DWORD
    dwState*: DWORD
    pData*: LPVOID
    cbData*: ULONG
  IInternetProtocolSink* {.pure.} = object
    lpVtbl*: ptr IInternetProtocolSinkVtbl
  IInternetProtocolSinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Switch*: proc(self: ptr IInternetProtocolSink, pProtocolData: ptr PROTOCOLDATA): HRESULT {.stdcall.}
    ReportProgress*: proc(self: ptr IInternetProtocolSink, ulStatusCode: ULONG, szStatusText: LPCWSTR): HRESULT {.stdcall.}
    ReportData*: proc(self: ptr IInternetProtocolSink, grfBSCF: DWORD, ulProgress: ULONG, ulProgressMax: ULONG): HRESULT {.stdcall.}
    ReportResult*: proc(self: ptr IInternetProtocolSink, hrResult: HRESULT, dwError: DWORD, szResult: LPCWSTR): HRESULT {.stdcall.}
  IInternetProtocolRoot* {.pure.} = object
    lpVtbl*: ptr IInternetProtocolRootVtbl
  IInternetProtocolRootVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Start*: proc(self: ptr IInternetProtocolRoot, szUrl: LPCWSTR, pOIProtSink: ptr IInternetProtocolSink, pOIBindInfo: ptr IInternetBindInfo, grfPI: DWORD, dwReserved: HANDLE_PTR): HRESULT {.stdcall.}
    Continue*: proc(self: ptr IInternetProtocolRoot, pProtocolData: ptr PROTOCOLDATA): HRESULT {.stdcall.}
    Abort*: proc(self: ptr IInternetProtocolRoot, hrReason: HRESULT, dwOptions: DWORD): HRESULT {.stdcall.}
    Terminate*: proc(self: ptr IInternetProtocolRoot, dwOptions: DWORD): HRESULT {.stdcall.}
    Suspend*: proc(self: ptr IInternetProtocolRoot): HRESULT {.stdcall.}
    Resume*: proc(self: ptr IInternetProtocolRoot): HRESULT {.stdcall.}
  LPIINTERNETPROTOCOLROOT* = ptr IInternetProtocolRoot
  IInternetProtocol* {.pure.} = object
    lpVtbl*: ptr IInternetProtocolVtbl
  IInternetProtocolVtbl* {.pure, inheritable.} = object of IInternetProtocolRootVtbl
    Read*: proc(self: ptr IInternetProtocol, pv: pointer, cb: ULONG, pcbRead: ptr ULONG): HRESULT {.stdcall.}
    Seek*: proc(self: ptr IInternetProtocol, dlibMove: LARGE_INTEGER, dwOrigin: DWORD, plibNewPosition: ptr ULARGE_INTEGER): HRESULT {.stdcall.}
    LockRequest*: proc(self: ptr IInternetProtocol, dwOptions: DWORD): HRESULT {.stdcall.}
    UnlockRequest*: proc(self: ptr IInternetProtocol): HRESULT {.stdcall.}
  LPIINTERNETPROTOCOL* = ptr IInternetProtocol
  LPIINTERNETPROTOCOLSINK* = ptr IInternetProtocolSink
  IInternetProtocolSinkStackable* {.pure.} = object
    lpVtbl*: ptr IInternetProtocolSinkStackableVtbl
  IInternetProtocolSinkStackableVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SwitchSink*: proc(self: ptr IInternetProtocolSinkStackable, pOIProtSink: ptr IInternetProtocolSink): HRESULT {.stdcall.}
    CommitSwitch*: proc(self: ptr IInternetProtocolSinkStackable): HRESULT {.stdcall.}
    RollbackSwitch*: proc(self: ptr IInternetProtocolSinkStackable): HRESULT {.stdcall.}
  LPIINTERNETPROTOCOLSINKStackable* = ptr IInternetProtocolSinkStackable
  IInternetSession* {.pure.} = object
    lpVtbl*: ptr IInternetSessionVtbl
  IInternetSessionVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RegisterNameSpace*: proc(self: ptr IInternetSession, pCF: ptr IClassFactory, rclsid: REFCLSID, pwzProtocol: LPCWSTR, cPatterns: ULONG, ppwzPatterns: ptr LPCWSTR, dwReserved: DWORD): HRESULT {.stdcall.}
    UnregisterNameSpace*: proc(self: ptr IInternetSession, pCF: ptr IClassFactory, pszProtocol: LPCWSTR): HRESULT {.stdcall.}
    RegisterMimeFilter*: proc(self: ptr IInternetSession, pCF: ptr IClassFactory, rclsid: REFCLSID, pwzType: LPCWSTR): HRESULT {.stdcall.}
    UnregisterMimeFilter*: proc(self: ptr IInternetSession, pCF: ptr IClassFactory, pwzType: LPCWSTR): HRESULT {.stdcall.}
    CreateBinding*: proc(self: ptr IInternetSession, pBC: LPBC, szUrl: LPCWSTR, pUnkOuter: ptr IUnknown, ppUnk: ptr ptr IUnknown, ppOInetProt: ptr ptr IInternetProtocol, dwOption: DWORD): HRESULT {.stdcall.}
    SetSessionOption*: proc(self: ptr IInternetSession, dwOption: DWORD, pBuffer: LPVOID, dwBufferLength: DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
    GetSessionOption*: proc(self: ptr IInternetSession, dwOption: DWORD, pBuffer: LPVOID, pdwBufferLength: ptr DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
  LPIINTERNETSESSION* = ptr IInternetSession
  IInternetThreadSwitch* {.pure.} = object
    lpVtbl*: ptr IInternetThreadSwitchVtbl
  IInternetThreadSwitchVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Prepare*: proc(self: ptr IInternetThreadSwitch): HRESULT {.stdcall.}
    Continue*: proc(self: ptr IInternetThreadSwitch): HRESULT {.stdcall.}
  LPIINTERNETTHREADSWITCH* = ptr IInternetThreadSwitch
  IInternetPriority* {.pure.} = object
    lpVtbl*: ptr IInternetPriorityVtbl
  IInternetPriorityVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetPriority*: proc(self: ptr IInternetPriority, nPriority: LONG): HRESULT {.stdcall.}
    GetPriority*: proc(self: ptr IInternetPriority, pnPriority: ptr LONG): HRESULT {.stdcall.}
  LPIINTERNETPRIORITY* = ptr IInternetPriority
  IInternetProtocolInfo* {.pure.} = object
    lpVtbl*: ptr IInternetProtocolInfoVtbl
  IInternetProtocolInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParseUrl*: proc(self: ptr IInternetProtocolInfo, pwzUrl: LPCWSTR, ParseAction: PARSEACTION, dwParseFlags: DWORD, pwzResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
    CombineUrl*: proc(self: ptr IInternetProtocolInfo, pwzBaseUrl: LPCWSTR, pwzRelativeUrl: LPCWSTR, dwCombineFlags: DWORD, pwzResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
    CompareUrl*: proc(self: ptr IInternetProtocolInfo, pwzUrl1: LPCWSTR, pwzUrl2: LPCWSTR, dwCompareFlags: DWORD): HRESULT {.stdcall.}
    QueryInfo*: proc(self: ptr IInternetProtocolInfo, pwzUrl: LPCWSTR, OueryOption: QUERYOPTION, dwQueryFlags: DWORD, pBuffer: LPVOID, cbBuffer: DWORD, pcbBuf: ptr DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
  LPIINTERNETPROTOCOLINFO* = ptr IInternetProtocolInfo
  IOInet* = IInternet
  IOInetBindInfo* = IInternetBindInfo
  IOInetBindInfoEx* = IInternetBindInfoEx
  IOInetProtocolRoot* = IInternetProtocolRoot
  IOInetProtocol* = IInternetProtocol
  IUri* {.pure.} = object
    lpVtbl*: ptr IUriVtbl
  IUriVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPropertyBSTR*: proc(self: ptr IUri, uriProp: Uri_PROPERTY, pbstrProperty: ptr BSTR, dwFlags: DWORD): HRESULT {.stdcall.}
    GetPropertyLength*: proc(self: ptr IUri, uriProp: Uri_PROPERTY, pcchProperty: ptr DWORD, dwFlags: DWORD): HRESULT {.stdcall.}
    GetPropertyDWORD*: proc(self: ptr IUri, uriProp: Uri_PROPERTY, pdwProperty: ptr DWORD, dwFlags: DWORD): HRESULT {.stdcall.}
    HasProperty*: proc(self: ptr IUri, uriProp: Uri_PROPERTY, pfHasProperty: ptr WINBOOL): HRESULT {.stdcall.}
    GetAbsoluteUri*: proc(self: ptr IUri, pbstrAbsoluteUri: ptr BSTR): HRESULT {.stdcall.}
    GetAuthority*: proc(self: ptr IUri, pbstrAuthority: ptr BSTR): HRESULT {.stdcall.}
    GetDisplayUri*: proc(self: ptr IUri, pbstrDisplayString: ptr BSTR): HRESULT {.stdcall.}
    GetDomain*: proc(self: ptr IUri, pbstrDomain: ptr BSTR): HRESULT {.stdcall.}
    GetExtension*: proc(self: ptr IUri, pbstrExtension: ptr BSTR): HRESULT {.stdcall.}
    GetFragment*: proc(self: ptr IUri, pbstrFragment: ptr BSTR): HRESULT {.stdcall.}
    GetHost*: proc(self: ptr IUri, pbstrHost: ptr BSTR): HRESULT {.stdcall.}
    GetPassword*: proc(self: ptr IUri, pbstrPassword: ptr BSTR): HRESULT {.stdcall.}
    GetPath*: proc(self: ptr IUri, pbstrPath: ptr BSTR): HRESULT {.stdcall.}
    GetPathAndQuery*: proc(self: ptr IUri, pbstrPathAndQuery: ptr BSTR): HRESULT {.stdcall.}
    GetQuery*: proc(self: ptr IUri, pbstrQuery: ptr BSTR): HRESULT {.stdcall.}
    GetRawUri*: proc(self: ptr IUri, pbstrRawUri: ptr BSTR): HRESULT {.stdcall.}
    GetSchemeName*: proc(self: ptr IUri, pbstrSchemeName: ptr BSTR): HRESULT {.stdcall.}
    GetUserInfo*: proc(self: ptr IUri, pbstrUserInfo: ptr BSTR): HRESULT {.stdcall.}
    GetUserName*: proc(self: ptr IUri, pbstrUserName: ptr BSTR): HRESULT {.stdcall.}
    GetHostType*: proc(self: ptr IUri, pdwHostType: ptr DWORD): HRESULT {.stdcall.}
    GetPort*: proc(self: ptr IUri, pdwPort: ptr DWORD): HRESULT {.stdcall.}
    GetScheme*: proc(self: ptr IUri, pdwScheme: ptr DWORD): HRESULT {.stdcall.}
    GetZone*: proc(self: ptr IUri, pdwZone: ptr DWORD): HRESULT {.stdcall.}
    GetProperties*: proc(self: ptr IUri, pdwFlags: LPDWORD): HRESULT {.stdcall.}
    IsEqual*: proc(self: ptr IUri, pUri: ptr IUri, pfEqual: ptr WINBOOL): HRESULT {.stdcall.}
  IInternetProtocolEx* {.pure.} = object
    lpVtbl*: ptr IInternetProtocolExVtbl
  IInternetProtocolExVtbl* {.pure, inheritable.} = object of IInternetProtocolVtbl
    StartEx*: proc(self: ptr IInternetProtocolEx, pUri: ptr IUri, pOIProtSink: ptr IInternetProtocolSink, pOIBindInfo: ptr IInternetBindInfo, grfPI: DWORD, dwReserved: HANDLE_PTR): HRESULT {.stdcall.}
  IOInetProtocolEx* = IInternetProtocolEx
  IOInetProtocolSink* = IInternetProtocolSink
  IOInetProtocolInfo* = IInternetProtocolInfo
  IOInetSession* = IInternetSession
  IOInetPriority* = IInternetPriority
  IOInetThreadSwitch* = IInternetThreadSwitch
  IOInetProtocolSinkStackable* = IInternetProtocolSinkStackable
  LPOINET* = LPIINTERNET
  LPOINETPROTOCOLINFO* = LPIINTERNETPROTOCOLINFO
  LPOINETBINDINFO* = LPIINTERNETBINDINFO
  LPOINETPROTOCOLROOT* = LPIINTERNETPROTOCOLROOT
  LPOINETPROTOCOL* = LPIINTERNETPROTOCOL
  LPOINETPROTOCOLSINK* = LPIINTERNETPROTOCOLSINK
  LPOINETSESSION* = LPIINTERNETSESSION
  LPOINETTHREADSWITCH* = LPIINTERNETTHREADSWITCH
  LPOINETPRIORITY* = LPIINTERNETPRIORITY
  LPOINETPROTOCOLSINKSTACKABLE* = LPIINTERNETPROTOCOLSINKSTACKABLE
  ZONEATTRIBUTES* {.pure.} = object
    cbSize*: ULONG
    szDisplayName*: array[260, WCHAR]
    szDescription*: array[200, WCHAR]
    szIconPath*: array[260, WCHAR]
    dwTemplateMinLevel*: DWORD
    dwTemplateRecommended*: DWORD
    dwTemplateCurrentLevel*: DWORD
    dwFlags*: DWORD
  IInternetZoneManager* {.pure.} = object
    lpVtbl*: ptr IInternetZoneManagerVtbl
  IInternetZoneManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetZoneAttributes*: proc(self: ptr IInternetZoneManager, dwZone: DWORD, pZoneAttributes: ptr ZONEATTRIBUTES): HRESULT {.stdcall.}
    SetZoneAttributes*: proc(self: ptr IInternetZoneManager, dwZone: DWORD, pZoneAttributes: ptr ZONEATTRIBUTES): HRESULT {.stdcall.}
    GetZoneCustomPolicy*: proc(self: ptr IInternetZoneManager, dwZone: DWORD, guidKey: REFGUID, ppPolicy: ptr ptr BYTE, pcbPolicy: ptr DWORD, urlZoneReg: URLZONEREG): HRESULT {.stdcall.}
    SetZoneCustomPolicy*: proc(self: ptr IInternetZoneManager, dwZone: DWORD, guidKey: REFGUID, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG): HRESULT {.stdcall.}
    GetZoneActionPolicy*: proc(self: ptr IInternetZoneManager, dwZone: DWORD, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG): HRESULT {.stdcall.}
    SetZoneActionPolicy*: proc(self: ptr IInternetZoneManager, dwZone: DWORD, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG): HRESULT {.stdcall.}
    PromptAction*: proc(self: ptr IInternetZoneManager, dwAction: DWORD, hwndParent: HWND, pwszUrl: LPCWSTR, pwszText: LPCWSTR, dwPromptFlags: DWORD): HRESULT {.stdcall.}
    LogAction*: proc(self: ptr IInternetZoneManager, dwAction: DWORD, pwszUrl: LPCWSTR, pwszText: LPCWSTR, dwLogFlags: DWORD): HRESULT {.stdcall.}
    CreateZoneEnumerator*: proc(self: ptr IInternetZoneManager, pdwEnum: ptr DWORD, pdwCount: ptr DWORD, dwFlags: DWORD): HRESULT {.stdcall.}
    GetZoneAt*: proc(self: ptr IInternetZoneManager, dwEnum: DWORD, dwIndex: DWORD, pdwZone: ptr DWORD): HRESULT {.stdcall.}
    DestroyZoneEnumerator*: proc(self: ptr IInternetZoneManager, dwEnum: DWORD): HRESULT {.stdcall.}
    CopyTemplatePoliciesToZone*: proc(self: ptr IInternetZoneManager, dwTemplate: DWORD, dwZone: DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
  LPURLZONEMANAGER* = ptr IInternetZoneManager
  LPZONEATTRIBUTES* = ptr ZONEATTRIBUTES
  ICatalogFileInfo* {.pure.} = object
    lpVtbl*: ptr ICatalogFileInfoVtbl
  ICatalogFileInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCatalogFile*: proc(self: ptr ICatalogFileInfo, ppszCatalogFile: ptr LPSTR): HRESULT {.stdcall.}
    GetJavaTrust*: proc(self: ptr ICatalogFileInfo, ppJavaTrust: ptr pointer): HRESULT {.stdcall.}
  LPCATALOGFILEINFO* = ptr ICatalogFileInfo
  IDataFilter* {.pure.} = object
    lpVtbl*: ptr IDataFilterVtbl
  IDataFilterVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    DoEncode*: proc(self: ptr IDataFilter, dwFlags: DWORD, lInBufferSize: LONG, pbInBuffer: ptr BYTE, lOutBufferSize: LONG, pbOutBuffer: ptr BYTE, lInBytesAvailable: LONG, plInBytesRead: ptr LONG, plOutBytesWritten: ptr LONG, dwReserved: DWORD): HRESULT {.stdcall.}
    DoDecode*: proc(self: ptr IDataFilter, dwFlags: DWORD, lInBufferSize: LONG, pbInBuffer: ptr BYTE, lOutBufferSize: LONG, pbOutBuffer: ptr BYTE, lInBytesAvailable: LONG, plInBytesRead: ptr LONG, plOutBytesWritten: ptr LONG, dwReserved: DWORD): HRESULT {.stdcall.}
    SetEncodingLevel*: proc(self: ptr IDataFilter, dwEncLevel: DWORD): HRESULT {.stdcall.}
  LPDATAFILTER* = ptr IDataFilter
  DATAINFO* {.pure.} = object
    ulTotalSize*: ULONG
    ulavrPacketSize*: ULONG
    ulConnectSpeed*: ULONG
    ulProcessorSpeed*: ULONG
  IEncodingFilterFactory* {.pure.} = object
    lpVtbl*: ptr IEncodingFilterFactoryVtbl
  IEncodingFilterFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FindBestFilter*: proc(self: ptr IEncodingFilterFactory, pwzCodeIn: LPCWSTR, pwzCodeOut: LPCWSTR, info: DATAINFO, ppDF: ptr ptr IDataFilter): HRESULT {.stdcall.}
    GetDefaultFilter*: proc(self: ptr IEncodingFilterFactory, pwzCodeIn: LPCWSTR, pwzCodeOut: LPCWSTR, ppDF: ptr ptr IDataFilter): HRESULT {.stdcall.}
  LPENCODINGFILTERFACTORY* = ptr IEncodingFilterFactory
  IWrappedProtocol* {.pure.} = object
    lpVtbl*: ptr IWrappedProtocolVtbl
  IWrappedProtocolVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetWrapperCode*: proc(self: ptr IWrappedProtocol, pnCode: ptr LONG, dwReserved: DWORD_PTR): HRESULT {.stdcall.}
  LPIWRAPPEDPROTOCOL* = ptr IWrappedProtocol
  IGetBindHandle* {.pure.} = object
    lpVtbl*: ptr IGetBindHandleVtbl
  IGetBindHandleVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetBindHandle*: proc(self: ptr IGetBindHandle, enumRequestedHandle: BINDHANDLETYPES, pRetHandle: ptr HANDLE): HRESULT {.stdcall.}
  LPGETBINDHANDLE* = ptr IGetBindHandle
  IBindCallbackRedirect* {.pure.} = object
    lpVtbl*: ptr IBindCallbackRedirectVtbl
  IBindCallbackRedirectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Redirect*: proc(self: ptr IBindCallbackRedirect, lpcUrl: LPCWSTR, vbCancel: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  LPBINDCALLBACKREDIRECT* = ptr IBindCallbackRedirect
  CLIPDATA* {.pure.} = object
    cbSize*: ULONG
    ulClipFmt*: LONG
    pClipData*: ptr BYTE
  VERSIONEDSTREAM* {.pure.} = object
    guidVersion*: GUID
    pStream*: ptr IStream
  LPVERSIONEDSTREAM* = ptr VERSIONEDSTREAM
  CAC* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr CHAR
  CAUB* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr UCHAR
  CAI* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr SHORT
  CAUI* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr USHORT
  CAL* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr LONG
  CAUL* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr ULONG
  CAH* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr LARGE_INTEGER
  CAUH* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr ULARGE_INTEGER
  CAFLT* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr FLOAT
  CADBL* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr DOUBLE
  CABOOL* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr VARIANT_BOOL
  CASCODE* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr SCODE
  CACY* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr CY
  CADATE* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr DATE
  CAFILETIME* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr FILETIME
  CACLSID* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr CLSID
  CACLIPDATA* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr CLIPDATA
  CABSTR* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr BSTR
  CABSTRBLOB* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr BSTRBLOB
  CALPSTR* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr LPSTR
  CALPWSTR* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr LPWSTR
  CAPROPVARIANT* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr PROPVARIANT
  PROPVARIANT_UNION1_STRUCT1_UNION1* {.pure, union.} = object
    cVal*: CHAR
    bVal*: UCHAR
    iVal*: SHORT
    uiVal*: USHORT
    lVal*: LONG
    ulVal*: ULONG
    intVal*: INT
    uintVal*: UINT
    hVal*: LARGE_INTEGER
    uhVal*: ULARGE_INTEGER
    fltVal*: FLOAT
    dblVal*: DOUBLE
    boolVal*: VARIANT_BOOL
    scode*: SCODE
    cyVal*: CY
    date*: DATE
    filetime*: FILETIME
    puuid*: ptr CLSID
    pclipdata*: ptr CLIPDATA
    bstrVal*: BSTR
    bstrblobVal*: BSTRBLOB
    blob*: BLOB
    pszVal*: LPSTR
    pwszVal*: LPWSTR
    punkVal*: ptr IUnknown
    pdispVal*: ptr IDispatch
    pStream*: ptr IStream
    pStorage*: ptr IStorage
    pVersionedStream*: LPVERSIONEDSTREAM
    parray*: LPSAFEARRAY
    cac*: CAC
    caub*: CAUB
    cai*: CAI
    caui*: CAUI
    cal*: CAL
    caul*: CAUL
    cah*: CAH
    cauh*: CAUH
    caflt*: CAFLT
    cadbl*: CADBL
    cabool*: CABOOL
    cascode*: CASCODE
    cacy*: CACY
    cadate*: CADATE
    cafiletime*: CAFILETIME
    cauuid*: CACLSID
    caclipdata*: CACLIPDATA
    cabstr*: CABSTR
    cabstrblob*: CABSTRBLOB
    calpstr*: CALPSTR
    calpwstr*: CALPWSTR
    capropvar*: CAPROPVARIANT
    pcVal*: ptr CHAR
    pbVal*: ptr UCHAR
    piVal*: ptr SHORT
    puiVal*: ptr USHORT
    plVal*: ptr LONG
    pulVal*: ptr ULONG
    pintVal*: ptr INT
    puintVal*: ptr UINT
    pfltVal*: ptr FLOAT
    pdblVal*: ptr DOUBLE
    pboolVal*: ptr VARIANT_BOOL
    pdecVal*: ptr DECIMAL
    pscode*: ptr SCODE
    pcyVal*: ptr CY
    pdate*: ptr DATE
    pbstrVal*: ptr BSTR
    ppunkVal*: ptr ptr IUnknown
    ppdispVal*: ptr ptr IDispatch
    pparray*: ptr LPSAFEARRAY
    pvarVal*: ptr PROPVARIANT
  PROPVARIANT_UNION1_STRUCT1* {.pure.} = object
    vt*: VARTYPE
    wReserved1*: PROPVAR_PAD1
    wReserved2*: PROPVAR_PAD2
    wReserved3*: PROPVAR_PAD3
    union1*: PROPVARIANT_UNION1_STRUCT1_UNION1
  PROPVARIANT_UNION1* {.pure, union.} = object
    struct1*: PROPVARIANT_UNION1_STRUCT1
    decVal*: DECIMAL
  PROPVARIANT* {.pure.} = object
    union1*: PROPVARIANT_UNION1
  LPPROPVARIANT* = ptr PROPVARIANT
  REFPROPVARIANT* = ptr PROPVARIANT
  PROPSPEC_UNION1* {.pure, union.} = object
    propid*: PROPID
    lpwstr*: LPOLESTR
  PROPSPEC* {.pure.} = object
    ulKind*: ULONG
    union1*: PROPSPEC_UNION1
  STATPROPSTG* {.pure.} = object
    lpwstrName*: LPOLESTR
    propid*: PROPID
    vt*: VARTYPE
  IEnumSTATPROPSTG* {.pure.} = object
    lpVtbl*: ptr IEnumSTATPROPSTGVtbl
  IEnumSTATPROPSTGVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumSTATPROPSTG, celt: ULONG, rgelt: ptr STATPROPSTG, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumSTATPROPSTG, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumSTATPROPSTG): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumSTATPROPSTG, ppenum: ptr ptr IEnumSTATPROPSTG): HRESULT {.stdcall.}
  STATPROPSETSTG* {.pure.} = object
    fmtid*: FMTID
    clsid*: CLSID
    grfFlags*: DWORD
    mtime*: FILETIME
    ctime*: FILETIME
    atime*: FILETIME
    dwOSVersion*: DWORD
  IPropertyStorage* {.pure.} = object
    lpVtbl*: ptr IPropertyStorageVtbl
  IPropertyStorageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ReadMultiple*: proc(self: ptr IPropertyStorage, cpspec: ULONG, rgpspec: ptr PROPSPEC, rgpropvar: ptr PROPVARIANT): HRESULT {.stdcall.}
    WriteMultiple*: proc(self: ptr IPropertyStorage, cpspec: ULONG, rgpspec: ptr PROPSPEC, rgpropvar: ptr PROPVARIANT, propidNameFirst: PROPID): HRESULT {.stdcall.}
    DeleteMultiple*: proc(self: ptr IPropertyStorage, cpspec: ULONG, rgpspec: ptr PROPSPEC): HRESULT {.stdcall.}
    ReadPropertyNames*: proc(self: ptr IPropertyStorage, cpropid: ULONG, rgpropid: ptr PROPID, rglpwstrName: ptr LPOLESTR): HRESULT {.stdcall.}
    WritePropertyNames*: proc(self: ptr IPropertyStorage, cpropid: ULONG, rgpropid: ptr PROPID, rglpwstrName: ptr LPOLESTR): HRESULT {.stdcall.}
    DeletePropertyNames*: proc(self: ptr IPropertyStorage, cpropid: ULONG, rgpropid: ptr PROPID): HRESULT {.stdcall.}
    Commit*: proc(self: ptr IPropertyStorage, grfCommitFlags: DWORD): HRESULT {.stdcall.}
    Revert*: proc(self: ptr IPropertyStorage): HRESULT {.stdcall.}
    Enum*: proc(self: ptr IPropertyStorage, ppenum: ptr ptr IEnumSTATPROPSTG): HRESULT {.stdcall.}
    SetTimes*: proc(self: ptr IPropertyStorage, pctime: ptr FILETIME, patime: ptr FILETIME, pmtime: ptr FILETIME): HRESULT {.stdcall.}
    SetClass*: proc(self: ptr IPropertyStorage, clsid: REFCLSID): HRESULT {.stdcall.}
    Stat*: proc(self: ptr IPropertyStorage, pstatpsstg: ptr STATPROPSETSTG): HRESULT {.stdcall.}
  IEnumSTATPROPSETSTG* {.pure.} = object
    lpVtbl*: ptr IEnumSTATPROPSETSTGVtbl
  IEnumSTATPROPSETSTGVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumSTATPROPSETSTG, celt: ULONG, rgelt: ptr STATPROPSETSTG, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumSTATPROPSETSTG, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumSTATPROPSETSTG): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumSTATPROPSETSTG, ppenum: ptr ptr IEnumSTATPROPSETSTG): HRESULT {.stdcall.}
  IPropertySetStorage* {.pure.} = object
    lpVtbl*: ptr IPropertySetStorageVtbl
  IPropertySetStorageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Create*: proc(self: ptr IPropertySetStorage, rfmtid: REFFMTID, pclsid: ptr CLSID, grfFlags: DWORD, grfMode: DWORD, ppprstg: ptr ptr IPropertyStorage): HRESULT {.stdcall.}
    Open*: proc(self: ptr IPropertySetStorage, rfmtid: REFFMTID, grfMode: DWORD, ppprstg: ptr ptr IPropertyStorage): HRESULT {.stdcall.}
    Delete*: proc(self: ptr IPropertySetStorage, rfmtid: REFFMTID): HRESULT {.stdcall.}
    Enum*: proc(self: ptr IPropertySetStorage, ppenum: ptr ptr IEnumSTATPROPSETSTG): HRESULT {.stdcall.}
  LPPROPERTYSETSTORAGE* = ptr IPropertySetStorage
  LPENUMSTATPROPSTG* = ptr IEnumSTATPROPSTG
  LPENUMSTATPROPSETSTG* = ptr IEnumSTATPROPSETSTG
  LPPROPERTYSTORAGE* = ptr IPropertyStorage
  CONNECTDATA* {.pure.} = object
    pUnk*: ptr IUnknown
    dwCookie*: DWORD
  LPCONNECTDATA* = ptr CONNECTDATA
  IEnumConnections* {.pure.} = object
    lpVtbl*: ptr IEnumConnectionsVtbl
  IEnumConnectionsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumConnections, cConnections: ULONG, rgcd: LPCONNECTDATA, pcFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumConnections, cConnections: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumConnections): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumConnections, ppEnum: ptr ptr IEnumConnections): HRESULT {.stdcall.}
  PENUMCONNECTIONS* = ptr IEnumConnections
  LPENUMCONNECTIONS* = ptr IEnumConnections
  PCONNECTDATA* = ptr CONNECTDATA
  LPCONNECTIONPOINT* = ptr IConnectionPoint
  IEnumConnectionPoints* {.pure.} = object
    lpVtbl*: ptr IEnumConnectionPointsVtbl
  IEnumConnectionPointsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumConnectionPoints, cConnections: ULONG, ppCP: ptr LPCONNECTIONPOINT, pcFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumConnectionPoints, cConnections: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumConnectionPoints): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumConnectionPoints, ppEnum: ptr ptr IEnumConnectionPoints): HRESULT {.stdcall.}
  IConnectionPointContainer* {.pure.} = object
    lpVtbl*: ptr IConnectionPointContainerVtbl
  IConnectionPointContainerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EnumConnectionPoints*: proc(self: ptr IConnectionPointContainer, ppEnum: ptr ptr IEnumConnectionPoints): HRESULT {.stdcall.}
    FindConnectionPoint*: proc(self: ptr IConnectionPointContainer, riid: REFIID, ppCP: ptr ptr IConnectionPoint): HRESULT {.stdcall.}
  IConnectionPoint* {.pure.} = object
    lpVtbl*: ptr IConnectionPointVtbl
  IConnectionPointVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetConnectionInterface*: proc(self: ptr IConnectionPoint, pIID: ptr IID): HRESULT {.stdcall.}
    GetConnectionPointContainer*: proc(self: ptr IConnectionPoint, ppCPC: ptr ptr IConnectionPointContainer): HRESULT {.stdcall.}
    Advise*: proc(self: ptr IConnectionPoint, pUnkSink: ptr IUnknown, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    Unadvise*: proc(self: ptr IConnectionPoint, dwCookie: DWORD): HRESULT {.stdcall.}
    EnumConnections*: proc(self: ptr IConnectionPoint, ppEnum: ptr ptr IEnumConnections): HRESULT {.stdcall.}
  PCONNECTIONPOINT* = ptr IConnectionPoint
  PENUMCONNECTIONPOINTS* = ptr IEnumConnectionPoints
  LPENUMCONNECTIONPOINTS* = ptr IEnumConnectionPoints
  PCONNECTIONPOINTCONTAINER* = ptr IConnectionPointContainer
  LPCONNECTIONPOINTCONTAINER* = ptr IConnectionPointContainer
  LICINFO* {.pure.} = object
    cbLicInfo*: LONG
    fRuntimeKeyAvail*: WINBOOL
    fLicVerified*: WINBOOL
  IClassFactory2* {.pure.} = object
    lpVtbl*: ptr IClassFactory2Vtbl
  IClassFactory2Vtbl* {.pure, inheritable.} = object of IClassFactoryVtbl
    GetLicInfo*: proc(self: ptr IClassFactory2, pLicInfo: ptr LICINFO): HRESULT {.stdcall.}
    RequestLicKey*: proc(self: ptr IClassFactory2, dwReserved: DWORD, pBstrKey: ptr BSTR): HRESULT {.stdcall.}
    CreateInstanceLic*: proc(self: ptr IClassFactory2, pUnkOuter: ptr IUnknown, pUnkReserved: ptr IUnknown, riid: REFIID, bstrKey: BSTR, ppvObj: ptr PVOID): HRESULT {.stdcall.}
  LPCLASSFACTORY2* = ptr IClassFactory2
  LPLICINFO* = ptr LICINFO
  IProvideClassInfo* {.pure.} = object
    lpVtbl*: ptr IProvideClassInfoVtbl
  IProvideClassInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetClassInfo*: proc(self: ptr IProvideClassInfo, ppTI: ptr ptr ITypeInfo): HRESULT {.stdcall.}
  LPPROVIDECLASSINFO* = ptr IProvideClassInfo
  IProvideClassInfo2* {.pure.} = object
    lpVtbl*: ptr IProvideClassInfo2Vtbl
  IProvideClassInfo2Vtbl* {.pure, inheritable.} = object of IProvideClassInfoVtbl
    GetGUID*: proc(self: ptr IProvideClassInfo2, dwGuidKind: DWORD, pGUID: ptr GUID): HRESULT {.stdcall.}
  LPPROVIDECLASSINFO2* = ptr IProvideClassInfo2
  IProvideMultipleClassInfo* {.pure.} = object
    lpVtbl*: ptr IProvideMultipleClassInfoVtbl
  IProvideMultipleClassInfoVtbl* {.pure, inheritable.} = object of IProvideClassInfo2Vtbl
    GetMultiTypeInfoCount*: proc(self: ptr IProvideMultipleClassInfo, pcti: ptr ULONG): HRESULT {.stdcall.}
    GetInfoOfIndex*: proc(self: ptr IProvideMultipleClassInfo, iti: ULONG, dwFlags: DWORD, pptiCoClass: ptr ptr ITypeInfo, pdwTIFlags: ptr DWORD, pcdispidReserved: ptr ULONG, piidPrimary: ptr IID, piidSource: ptr IID): HRESULT {.stdcall.}
  LPPROVIDEMULTIPLECLASSINFO* = ptr IProvideMultipleClassInfo
  CONTROLINFO* {.pure.} = object
    cb*: ULONG
    hAccel*: HACCEL
    cAccel*: USHORT
    dwFlags*: DWORD
  IOleControl* {.pure.} = object
    lpVtbl*: ptr IOleControlVtbl
  IOleControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetControlInfo*: proc(self: ptr IOleControl, pCI: ptr CONTROLINFO): HRESULT {.stdcall.}
    OnMnemonic*: proc(self: ptr IOleControl, pMsg: ptr MSG): HRESULT {.stdcall.}
    OnAmbientPropertyChange*: proc(self: ptr IOleControl, dispID: DISPID): HRESULT {.stdcall.}
    FreezeEvents*: proc(self: ptr IOleControl, bFreeze: WINBOOL): HRESULT {.stdcall.}
  LPOLECONTROL* = ptr IOleControl
  LPCONTROLINFO* = ptr CONTROLINFO
  POINTF* {.pure.} = object
    x*: FLOAT
    y*: FLOAT
  IOleControlSite* {.pure.} = object
    lpVtbl*: ptr IOleControlSiteVtbl
  IOleControlSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnControlInfoChanged*: proc(self: ptr IOleControlSite): HRESULT {.stdcall.}
    LockInPlaceActive*: proc(self: ptr IOleControlSite, fLock: WINBOOL): HRESULT {.stdcall.}
    GetExtendedControl*: proc(self: ptr IOleControlSite, ppDisp: ptr ptr IDispatch): HRESULT {.stdcall.}
    TransformCoords*: proc(self: ptr IOleControlSite, pPtlHimetric: ptr POINTL, pPtfContainer: ptr POINTF, dwFlags: DWORD): HRESULT {.stdcall.}
    TranslateAccelerator*: proc(self: ptr IOleControlSite, pMsg: ptr MSG, grfModifiers: DWORD): HRESULT {.stdcall.}
    OnFocus*: proc(self: ptr IOleControlSite, fGotFocus: WINBOOL): HRESULT {.stdcall.}
    ShowPropertyFrame*: proc(self: ptr IOleControlSite): HRESULT {.stdcall.}
  LPOLECONTROLSITE* = ptr IOleControlSite
  LPPOINTF* = ptr POINTF
  IPropertyPageSite* {.pure.} = object
    lpVtbl*: ptr IPropertyPageSiteVtbl
  IPropertyPageSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnStatusChange*: proc(self: ptr IPropertyPageSite, dwFlags: DWORD): HRESULT {.stdcall.}
    GetLocaleID*: proc(self: ptr IPropertyPageSite, pLocaleID: ptr LCID): HRESULT {.stdcall.}
    GetPageContainer*: proc(self: ptr IPropertyPageSite, ppUnk: ptr ptr IUnknown): HRESULT {.stdcall.}
    TranslateAccelerator*: proc(self: ptr IPropertyPageSite, pMsg: ptr MSG): HRESULT {.stdcall.}
  PROPPAGEINFO* {.pure.} = object
    cb*: ULONG
    pszTitle*: LPOLESTR
    size*: SIZE
    pszDocString*: LPOLESTR
    pszHelpFile*: LPOLESTR
    dwHelpContext*: DWORD
  IPropertyPage* {.pure.} = object
    lpVtbl*: ptr IPropertyPageVtbl
  IPropertyPageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetPageSite*: proc(self: ptr IPropertyPage, pPageSite: ptr IPropertyPageSite): HRESULT {.stdcall.}
    Activate*: proc(self: ptr IPropertyPage, hWndParent: HWND, pRect: LPCRECT, bModal: WINBOOL): HRESULT {.stdcall.}
    Deactivate*: proc(self: ptr IPropertyPage): HRESULT {.stdcall.}
    GetPageInfo*: proc(self: ptr IPropertyPage, pPageInfo: ptr PROPPAGEINFO): HRESULT {.stdcall.}
    SetObjects*: proc(self: ptr IPropertyPage, cObjects: ULONG, ppUnk: ptr ptr IUnknown): HRESULT {.stdcall.}
    Show*: proc(self: ptr IPropertyPage, nCmdShow: UINT): HRESULT {.stdcall.}
    Move*: proc(self: ptr IPropertyPage, pRect: LPCRECT): HRESULT {.stdcall.}
    IsPageDirty*: proc(self: ptr IPropertyPage): HRESULT {.stdcall.}
    Apply*: proc(self: ptr IPropertyPage): HRESULT {.stdcall.}
    Help*: proc(self: ptr IPropertyPage, pszHelpDir: LPCOLESTR): HRESULT {.stdcall.}
    TranslateAccelerator*: proc(self: ptr IPropertyPage, pMsg: ptr MSG): HRESULT {.stdcall.}
  LPPROPERTYPAGE* = ptr IPropertyPage
  LPPROPPAGEINFO* = ptr PROPPAGEINFO
  IPropertyPage2* {.pure.} = object
    lpVtbl*: ptr IPropertyPage2Vtbl
  IPropertyPage2Vtbl* {.pure, inheritable.} = object of IPropertyPageVtbl
    EditProperty*: proc(self: ptr IPropertyPage2, dispID: DISPID): HRESULT {.stdcall.}
  LPPROPERTYPAGE2* = ptr IPropertyPage2
  LPPROPERTYPAGESITE* = ptr IPropertyPageSite
  IPropertyNotifySink* {.pure.} = object
    lpVtbl*: ptr IPropertyNotifySinkVtbl
  IPropertyNotifySinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnChanged*: proc(self: ptr IPropertyNotifySink, dispID: DISPID): HRESULT {.stdcall.}
    OnRequestEdit*: proc(self: ptr IPropertyNotifySink, dispID: DISPID): HRESULT {.stdcall.}
  LPPROPERTYNOTIFYSINK* = ptr IPropertyNotifySink
  CAUUID* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr GUID
  ISpecifyPropertyPages* {.pure.} = object
    lpVtbl*: ptr ISpecifyPropertyPagesVtbl
  ISpecifyPropertyPagesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPages*: proc(self: ptr ISpecifyPropertyPages, pPages: ptr CAUUID): HRESULT {.stdcall.}
  LPSPECIFYPROPERTYPAGES* = ptr ISpecifyPropertyPages
  LPCAUUID* = ptr CAUUID
  IPersistMemory* {.pure.} = object
    lpVtbl*: ptr IPersistMemoryVtbl
  IPersistMemoryVtbl* {.pure, inheritable.} = object of IPersistVtbl
    IsDirty*: proc(self: ptr IPersistMemory): HRESULT {.stdcall.}
    Load*: proc(self: ptr IPersistMemory, pMem: LPVOID, cbSize: ULONG): HRESULT {.stdcall.}
    Save*: proc(self: ptr IPersistMemory, pMem: LPVOID, fClearDirty: WINBOOL, cbSize: ULONG): HRESULT {.stdcall.}
    GetSizeMax*: proc(self: ptr IPersistMemory, pCbSize: ptr ULONG): HRESULT {.stdcall.}
    InitNew*: proc(self: ptr IPersistMemory): HRESULT {.stdcall.}
  LPPERSISTMEMORY* = ptr IPersistMemory
  IPersistStreamInit* {.pure.} = object
    lpVtbl*: ptr IPersistStreamInitVtbl
  IPersistStreamInitVtbl* {.pure, inheritable.} = object of IPersistVtbl
    IsDirty*: proc(self: ptr IPersistStreamInit): HRESULT {.stdcall.}
    Load*: proc(self: ptr IPersistStreamInit, pStm: LPSTREAM): HRESULT {.stdcall.}
    Save*: proc(self: ptr IPersistStreamInit, pStm: LPSTREAM, fClearDirty: WINBOOL): HRESULT {.stdcall.}
    GetSizeMax*: proc(self: ptr IPersistStreamInit, pCbSize: ptr ULARGE_INTEGER): HRESULT {.stdcall.}
    InitNew*: proc(self: ptr IPersistStreamInit): HRESULT {.stdcall.}
  LPPERSISTSTREAMINIT* = ptr IPersistStreamInit
  IPersistPropertyBag* {.pure.} = object
    lpVtbl*: ptr IPersistPropertyBagVtbl
  IPersistPropertyBagVtbl* {.pure, inheritable.} = object of IPersistVtbl
    InitNew*: proc(self: ptr IPersistPropertyBag): HRESULT {.stdcall.}
    Load*: proc(self: ptr IPersistPropertyBag, pPropBag: ptr IPropertyBag, pErrorLog: ptr IErrorLog): HRESULT {.stdcall.}
    Save*: proc(self: ptr IPersistPropertyBag, pPropBag: ptr IPropertyBag, fClearDirty: WINBOOL, fSaveAllProperties: WINBOOL): HRESULT {.stdcall.}
  LPPERSISTPROPERTYBAG* = ptr IPersistPropertyBag
  ISimpleFrameSite* {.pure.} = object
    lpVtbl*: ptr ISimpleFrameSiteVtbl
  ISimpleFrameSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    PreMessageFilter*: proc(self: ptr ISimpleFrameSite, hWnd: HWND, msg: UINT, wp: WPARAM, lp: LPARAM, plResult: ptr LRESULT, pdwCookie: ptr DWORD): HRESULT {.stdcall.}
    PostMessageFilter*: proc(self: ptr ISimpleFrameSite, hWnd: HWND, msg: UINT, wp: WPARAM, lp: LPARAM, plResult: ptr LRESULT, dwCookie: DWORD): HRESULT {.stdcall.}
  LPSIMPLEFRAMESITE* = ptr ISimpleFrameSite
  TEXTMETRICOLE* = TEXTMETRICW
  IFont* {.pure.} = object
    lpVtbl*: ptr IFontVtbl
  IFontVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_Name*: proc(self: ptr IFont, pName: ptr BSTR): HRESULT {.stdcall.}
    put_Name*: proc(self: ptr IFont, name: BSTR): HRESULT {.stdcall.}
    get_Size*: proc(self: ptr IFont, pSize: ptr CY): HRESULT {.stdcall.}
    put_Size*: proc(self: ptr IFont, size: CY): HRESULT {.stdcall.}
    get_Bold*: proc(self: ptr IFont, pBold: ptr WINBOOL): HRESULT {.stdcall.}
    put_Bold*: proc(self: ptr IFont, bold: WINBOOL): HRESULT {.stdcall.}
    get_Italic*: proc(self: ptr IFont, pItalic: ptr WINBOOL): HRESULT {.stdcall.}
    put_Italic*: proc(self: ptr IFont, italic: WINBOOL): HRESULT {.stdcall.}
    get_Underline*: proc(self: ptr IFont, pUnderline: ptr WINBOOL): HRESULT {.stdcall.}
    put_Underline*: proc(self: ptr IFont, underline: WINBOOL): HRESULT {.stdcall.}
    get_Strikethrough*: proc(self: ptr IFont, pStrikethrough: ptr WINBOOL): HRESULT {.stdcall.}
    put_Strikethrough*: proc(self: ptr IFont, strikethrough: WINBOOL): HRESULT {.stdcall.}
    get_Weight*: proc(self: ptr IFont, pWeight: ptr SHORT): HRESULT {.stdcall.}
    put_Weight*: proc(self: ptr IFont, weight: SHORT): HRESULT {.stdcall.}
    get_Charset*: proc(self: ptr IFont, pCharset: ptr SHORT): HRESULT {.stdcall.}
    put_Charset*: proc(self: ptr IFont, charset: SHORT): HRESULT {.stdcall.}
    get_hFont*: proc(self: ptr IFont, phFont: ptr HFONT): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IFont, ppFont: ptr ptr IFont): HRESULT {.stdcall.}
    IsEqual*: proc(self: ptr IFont, pFontOther: ptr IFont): HRESULT {.stdcall.}
    SetRatio*: proc(self: ptr IFont, cyLogical: LONG, cyHimetric: LONG): HRESULT {.stdcall.}
    QueryTextMetrics*: proc(self: ptr IFont, pTM: ptr TEXTMETRICOLE): HRESULT {.stdcall.}
    AddRefHfont*: proc(self: ptr IFont, hFont: HFONT): HRESULT {.stdcall.}
    ReleaseHfont*: proc(self: ptr IFont, hFont: HFONT): HRESULT {.stdcall.}
    SetHdc*: proc(self: ptr IFont, hDC: HDC): HRESULT {.stdcall.}
  LPFONT* = ptr IFont
  LPTEXTMETRICOLE* = ptr TEXTMETRICOLE
  OLE_HANDLE* = UINT
  IPicture* {.pure.} = object
    lpVtbl*: ptr IPictureVtbl
  IPictureVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_Handle*: proc(self: ptr IPicture, pHandle: ptr OLE_HANDLE): HRESULT {.stdcall.}
    get_hPal*: proc(self: ptr IPicture, phPal: ptr OLE_HANDLE): HRESULT {.stdcall.}
    get_Type*: proc(self: ptr IPicture, pType: ptr SHORT): HRESULT {.stdcall.}
    get_Width*: proc(self: ptr IPicture, pWidth: ptr OLE_XSIZE_HIMETRIC): HRESULT {.stdcall.}
    get_Height*: proc(self: ptr IPicture, pHeight: ptr OLE_YSIZE_HIMETRIC): HRESULT {.stdcall.}
    Render*: proc(self: ptr IPicture, hDC: HDC, x: LONG, y: LONG, cx: LONG, cy: LONG, xSrc: OLE_XPOS_HIMETRIC, ySrc: OLE_YPOS_HIMETRIC, cxSrc: OLE_XSIZE_HIMETRIC, cySrc: OLE_YSIZE_HIMETRIC, pRcWBounds: LPCRECT): HRESULT {.stdcall.}
    set_hPal*: proc(self: ptr IPicture, hPal: OLE_HANDLE): HRESULT {.stdcall.}
    get_CurDC*: proc(self: ptr IPicture, phDC: ptr HDC): HRESULT {.stdcall.}
    SelectPicture*: proc(self: ptr IPicture, hDCIn: HDC, phDCOut: ptr HDC, phBmpOut: ptr OLE_HANDLE): HRESULT {.stdcall.}
    get_KeepOriginalFormat*: proc(self: ptr IPicture, pKeep: ptr WINBOOL): HRESULT {.stdcall.}
    put_KeepOriginalFormat*: proc(self: ptr IPicture, keep: WINBOOL): HRESULT {.stdcall.}
    PictureChanged*: proc(self: ptr IPicture): HRESULT {.stdcall.}
    SaveAsFile*: proc(self: ptr IPicture, pStream: LPSTREAM, fSaveMemCopy: WINBOOL, pCbSize: ptr LONG): HRESULT {.stdcall.}
    get_Attributes*: proc(self: ptr IPicture, pDwAttr: ptr DWORD): HRESULT {.stdcall.}
  LPPICTURE* = ptr IPicture
  IPicture2* {.pure.} = object
    lpVtbl*: ptr IPicture2Vtbl
  IPicture2Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_Handle*: proc(self: ptr IPicture2, pHandle: ptr HHANDLE): HRESULT {.stdcall.}
    get_hPal*: proc(self: ptr IPicture2, phPal: ptr HHANDLE): HRESULT {.stdcall.}
    get_Type*: proc(self: ptr IPicture2, pType: ptr SHORT): HRESULT {.stdcall.}
    get_Width*: proc(self: ptr IPicture2, pWidth: ptr OLE_XSIZE_HIMETRIC): HRESULT {.stdcall.}
    get_Height*: proc(self: ptr IPicture2, pHeight: ptr OLE_YSIZE_HIMETRIC): HRESULT {.stdcall.}
    Render*: proc(self: ptr IPicture2, hDC: HDC, x: LONG, y: LONG, cx: LONG, cy: LONG, xSrc: OLE_XPOS_HIMETRIC, ySrc: OLE_YPOS_HIMETRIC, cxSrc: OLE_XSIZE_HIMETRIC, cySrc: OLE_YSIZE_HIMETRIC, pRcWBounds: LPCRECT): HRESULT {.stdcall.}
    set_hPal*: proc(self: ptr IPicture2, hPal: HHANDLE): HRESULT {.stdcall.}
    get_CurDC*: proc(self: ptr IPicture2, phDC: ptr HDC): HRESULT {.stdcall.}
    SelectPicture*: proc(self: ptr IPicture2, hDCIn: HDC, phDCOut: ptr HDC, phBmpOut: ptr HHANDLE): HRESULT {.stdcall.}
    get_KeepOriginalFormat*: proc(self: ptr IPicture2, pKeep: ptr WINBOOL): HRESULT {.stdcall.}
    put_KeepOriginalFormat*: proc(self: ptr IPicture2, keep: WINBOOL): HRESULT {.stdcall.}
    PictureChanged*: proc(self: ptr IPicture2): HRESULT {.stdcall.}
    SaveAsFile*: proc(self: ptr IPicture2, pStream: LPSTREAM, fSaveMemCopy: WINBOOL, pCbSize: ptr LONG): HRESULT {.stdcall.}
    get_Attributes*: proc(self: ptr IPicture2, pDwAttr: ptr DWORD): HRESULT {.stdcall.}
  LPPICTURE2* = ptr IPicture2
  IFontEventsDisp* {.pure.} = object
    lpVtbl*: ptr IFontEventsDispVtbl
  IFontEventsDispVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  LPFONTEVENTS* = ptr IFontEventsDisp
  IFontDisp* {.pure.} = object
    lpVtbl*: ptr IFontDispVtbl
  IFontDispVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  LPFONTDISP* = ptr IFontDisp
  IPictureDisp* {.pure.} = object
    lpVtbl*: ptr IPictureDispVtbl
  IPictureDispVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  LPPICTUREDISP* = ptr IPictureDisp
  IOleInPlaceObjectWindowless* {.pure.} = object
    lpVtbl*: ptr IOleInPlaceObjectWindowlessVtbl
  IOleInPlaceObjectWindowlessVtbl* {.pure, inheritable.} = object of IOleInPlaceObjectVtbl
    OnWindowMessage*: proc(self: ptr IOleInPlaceObjectWindowless, msg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.stdcall.}
    GetDropTarget*: proc(self: ptr IOleInPlaceObjectWindowless, ppDropTarget: ptr ptr IDropTarget): HRESULT {.stdcall.}
  LPOLEINPLACEOBJECTWINDOWLESS* = ptr IOleInPlaceObjectWindowless
  IOleInPlaceSiteEx* {.pure.} = object
    lpVtbl*: ptr IOleInPlaceSiteExVtbl
  IOleInPlaceSiteExVtbl* {.pure, inheritable.} = object of IOleInPlaceSiteVtbl
    OnInPlaceActivateEx*: proc(self: ptr IOleInPlaceSiteEx, pfNoRedraw: ptr WINBOOL, dwFlags: DWORD): HRESULT {.stdcall.}
    OnInPlaceDeactivateEx*: proc(self: ptr IOleInPlaceSiteEx, fNoRedraw: WINBOOL): HRESULT {.stdcall.}
    RequestUIActivate*: proc(self: ptr IOleInPlaceSiteEx): HRESULT {.stdcall.}
  LPOLEINPLACESITEEX* = ptr IOleInPlaceSiteEx
  IOleInPlaceSiteWindowless* {.pure.} = object
    lpVtbl*: ptr IOleInPlaceSiteWindowlessVtbl
  IOleInPlaceSiteWindowlessVtbl* {.pure, inheritable.} = object of IOleInPlaceSiteExVtbl
    CanWindowlessActivate*: proc(self: ptr IOleInPlaceSiteWindowless): HRESULT {.stdcall.}
    GetCapture*: proc(self: ptr IOleInPlaceSiteWindowless): HRESULT {.stdcall.}
    SetCapture*: proc(self: ptr IOleInPlaceSiteWindowless, fCapture: WINBOOL): HRESULT {.stdcall.}
    GetFocus*: proc(self: ptr IOleInPlaceSiteWindowless): HRESULT {.stdcall.}
    SetFocus*: proc(self: ptr IOleInPlaceSiteWindowless, fFocus: WINBOOL): HRESULT {.stdcall.}
    GetDC*: proc(self: ptr IOleInPlaceSiteWindowless, pRect: LPCRECT, grfFlags: DWORD, phDC: ptr HDC): HRESULT {.stdcall.}
    ReleaseDC*: proc(self: ptr IOleInPlaceSiteWindowless, hDC: HDC): HRESULT {.stdcall.}
    InvalidateRect*: proc(self: ptr IOleInPlaceSiteWindowless, pRect: LPCRECT, fErase: WINBOOL): HRESULT {.stdcall.}
    InvalidateRgn*: proc(self: ptr IOleInPlaceSiteWindowless, hRGN: HRGN, fErase: WINBOOL): HRESULT {.stdcall.}
    ScrollRect*: proc(self: ptr IOleInPlaceSiteWindowless, dx: INT, dy: INT, pRectScroll: LPCRECT, pRectClip: LPCRECT): HRESULT {.stdcall.}
    AdjustRect*: proc(self: ptr IOleInPlaceSiteWindowless, prc: LPRECT): HRESULT {.stdcall.}
    OnDefWindowMessage*: proc(self: ptr IOleInPlaceSiteWindowless, msg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.stdcall.}
  LPOLEINPLACESITEWINDOWLESS* = ptr IOleInPlaceSiteWindowless
  DVEXTENTINFO* {.pure.} = object
    cb*: ULONG
    dwExtentMode*: DWORD
    sizelProposed*: SIZEL
  IViewObjectEx* {.pure.} = object
    lpVtbl*: ptr IViewObjectExVtbl
  IViewObjectExVtbl* {.pure, inheritable.} = object of IViewObject2Vtbl
    GetRect*: proc(self: ptr IViewObjectEx, dwAspect: DWORD, pRect: LPRECTL): HRESULT {.stdcall.}
    GetViewStatus*: proc(self: ptr IViewObjectEx, pdwStatus: ptr DWORD): HRESULT {.stdcall.}
    QueryHitPoint*: proc(self: ptr IViewObjectEx, dwAspect: DWORD, pRectBounds: LPCRECT, ptlLoc: POINT, lCloseHint: LONG, pHitResult: ptr DWORD): HRESULT {.stdcall.}
    QueryHitRect*: proc(self: ptr IViewObjectEx, dwAspect: DWORD, pRectBounds: LPCRECT, pRectLoc: LPCRECT, lCloseHint: LONG, pHitResult: ptr DWORD): HRESULT {.stdcall.}
    GetNaturalExtent*: proc(self: ptr IViewObjectEx, dwAspect: DWORD, lindex: LONG, ptd: ptr DVTARGETDEVICE, hicTargetDev: HDC, pExtentInfo: ptr DVEXTENTINFO, pSizel: LPSIZEL): HRESULT {.stdcall.}
  LPVIEWOBJECTEX* = ptr IViewObjectEx
  IOleUndoUnit* {.pure.} = object
    lpVtbl*: ptr IOleUndoUnitVtbl
  IOleUndoUnitVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Do*: proc(self: ptr IOleUndoUnit, pUndoManager: ptr IOleUndoManager): HRESULT {.stdcall.}
    GetDescription*: proc(self: ptr IOleUndoUnit, pBstr: ptr BSTR): HRESULT {.stdcall.}
    GetUnitType*: proc(self: ptr IOleUndoUnit, pClsid: ptr CLSID, plID: ptr LONG): HRESULT {.stdcall.}
    OnNextAdd*: proc(self: ptr IOleUndoUnit): HRESULT {.stdcall.}
  IEnumOleUndoUnits* {.pure.} = object
    lpVtbl*: ptr IEnumOleUndoUnitsVtbl
  IEnumOleUndoUnitsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumOleUndoUnits, cElt: ULONG, rgElt: ptr ptr IOleUndoUnit, pcEltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumOleUndoUnits, cElt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumOleUndoUnits): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumOleUndoUnits, ppEnum: ptr ptr IEnumOleUndoUnits): HRESULT {.stdcall.}
  IOleUndoManager* {.pure.} = object
    lpVtbl*: ptr IOleUndoManagerVtbl
  IOleUndoManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Open*: proc(self: ptr IOleUndoManager, pPUU: ptr IOleParentUndoUnit): HRESULT {.stdcall.}
    Close*: proc(self: ptr IOleUndoManager, pPUU: ptr IOleParentUndoUnit, fCommit: WINBOOL): HRESULT {.stdcall.}
    Add*: proc(self: ptr IOleUndoManager, pUU: ptr IOleUndoUnit): HRESULT {.stdcall.}
    GetOpenParentState*: proc(self: ptr IOleUndoManager, pdwState: ptr DWORD): HRESULT {.stdcall.}
    DiscardFrom*: proc(self: ptr IOleUndoManager, pUU: ptr IOleUndoUnit): HRESULT {.stdcall.}
    UndoTo*: proc(self: ptr IOleUndoManager, pUU: ptr IOleUndoUnit): HRESULT {.stdcall.}
    RedoTo*: proc(self: ptr IOleUndoManager, pUU: ptr IOleUndoUnit): HRESULT {.stdcall.}
    EnumUndoable*: proc(self: ptr IOleUndoManager, ppEnum: ptr ptr IEnumOleUndoUnits): HRESULT {.stdcall.}
    EnumRedoable*: proc(self: ptr IOleUndoManager, ppEnum: ptr ptr IEnumOleUndoUnits): HRESULT {.stdcall.}
    GetLastUndoDescription*: proc(self: ptr IOleUndoManager, pBstr: ptr BSTR): HRESULT {.stdcall.}
    GetLastRedoDescription*: proc(self: ptr IOleUndoManager, pBstr: ptr BSTR): HRESULT {.stdcall.}
    Enable*: proc(self: ptr IOleUndoManager, fEnable: WINBOOL): HRESULT {.stdcall.}
  IOleParentUndoUnit* {.pure.} = object
    lpVtbl*: ptr IOleParentUndoUnitVtbl
  IOleParentUndoUnitVtbl* {.pure, inheritable.} = object of IOleUndoUnitVtbl
    Open*: proc(self: ptr IOleParentUndoUnit, pPUU: ptr IOleParentUndoUnit): HRESULT {.stdcall.}
    Close*: proc(self: ptr IOleParentUndoUnit, pPUU: ptr IOleParentUndoUnit, fCommit: WINBOOL): HRESULT {.stdcall.}
    Add*: proc(self: ptr IOleParentUndoUnit, pUU: ptr IOleUndoUnit): HRESULT {.stdcall.}
    FindUnit*: proc(self: ptr IOleParentUndoUnit, pUU: ptr IOleUndoUnit): HRESULT {.stdcall.}
    GetParentState*: proc(self: ptr IOleParentUndoUnit, pdwState: ptr DWORD): HRESULT {.stdcall.}
  LPOLEUNDOUNIT* = ptr IOleUndoUnit
  LPOLEPARENTUNDOUNIT* = ptr IOleParentUndoUnit
  LPENUMOLEUNDOUNITS* = ptr IEnumOleUndoUnits
  LPOLEUNDOMANAGER* = ptr IOleUndoManager
  IPointerInactive* {.pure.} = object
    lpVtbl*: ptr IPointerInactiveVtbl
  IPointerInactiveVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetActivationPolicy*: proc(self: ptr IPointerInactive, pdwPolicy: ptr DWORD): HRESULT {.stdcall.}
    OnInactiveMouseMove*: proc(self: ptr IPointerInactive, pRectBounds: LPCRECT, x: LONG, y: LONG, grfKeyState: DWORD): HRESULT {.stdcall.}
    OnInactiveSetCursor*: proc(self: ptr IPointerInactive, pRectBounds: LPCRECT, x: LONG, y: LONG, dwMouseMsg: DWORD, fSetAlways: WINBOOL): HRESULT {.stdcall.}
  LPPOINTERINACTIVE* = ptr IPointerInactive
  IObjectWithSite* {.pure.} = object
    lpVtbl*: ptr IObjectWithSiteVtbl
  IObjectWithSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetSite*: proc(self: ptr IObjectWithSite, pUnkSite: ptr IUnknown): HRESULT {.stdcall.}
    GetSite*: proc(self: ptr IObjectWithSite, riid: REFIID, ppvSite: ptr pointer): HRESULT {.stdcall.}
  LPOBJECTWITHSITE* = ptr IObjectWithSite
  CALPOLESTR* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr LPOLESTR
  CADWORD* {.pure.} = object
    cElems*: ULONG
    pElems*: ptr DWORD
  IPerPropertyBrowsing* {.pure.} = object
    lpVtbl*: ptr IPerPropertyBrowsingVtbl
  IPerPropertyBrowsingVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDisplayString*: proc(self: ptr IPerPropertyBrowsing, dispID: DISPID, pBstr: ptr BSTR): HRESULT {.stdcall.}
    MapPropertyToPage*: proc(self: ptr IPerPropertyBrowsing, dispID: DISPID, pClsid: ptr CLSID): HRESULT {.stdcall.}
    GetPredefinedStrings*: proc(self: ptr IPerPropertyBrowsing, dispID: DISPID, pCaStringsOut: ptr CALPOLESTR, pCaCookiesOut: ptr CADWORD): HRESULT {.stdcall.}
    GetPredefinedValue*: proc(self: ptr IPerPropertyBrowsing, dispID: DISPID, dwCookie: DWORD, pVarOut: ptr VARIANT): HRESULT {.stdcall.}
  LPPERPROPERTYBROWSING* = ptr IPerPropertyBrowsing
  LPCALPOLESTR* = ptr CALPOLESTR
  LPCADWORD* = ptr CADWORD
  PROPBAG2* {.pure.} = object
    dwType*: DWORD
    vt*: VARTYPE
    cfType*: CLIPFORMAT
    dwHint*: DWORD
    pstrName*: LPOLESTR
    clsid*: CLSID
  IPropertyBag2* {.pure.} = object
    lpVtbl*: ptr IPropertyBag2Vtbl
  IPropertyBag2Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Read*: proc(self: ptr IPropertyBag2, cProperties: ULONG, pPropBag: ptr PROPBAG2, pErrLog: ptr IErrorLog, pvarValue: ptr VARIANT, phrError: ptr HRESULT): HRESULT {.stdcall.}
    Write*: proc(self: ptr IPropertyBag2, cProperties: ULONG, pPropBag: ptr PROPBAG2, pvarValue: ptr VARIANT): HRESULT {.stdcall.}
    CountProperties*: proc(self: ptr IPropertyBag2, pcProperties: ptr ULONG): HRESULT {.stdcall.}
    GetPropertyInfo*: proc(self: ptr IPropertyBag2, iProperty: ULONG, cProperties: ULONG, pPropBag: ptr PROPBAG2, pcProperties: ptr ULONG): HRESULT {.stdcall.}
    LoadObject*: proc(self: ptr IPropertyBag2, pstrName: LPCOLESTR, dwHint: DWORD, pUnkObject: ptr IUnknown, pErrLog: ptr IErrorLog): HRESULT {.stdcall.}
  LPPROPERTYBAG2* = ptr IPropertyBag2
  IPersistPropertyBag2* {.pure.} = object
    lpVtbl*: ptr IPersistPropertyBag2Vtbl
  IPersistPropertyBag2Vtbl* {.pure, inheritable.} = object of IPersistVtbl
    InitNew*: proc(self: ptr IPersistPropertyBag2): HRESULT {.stdcall.}
    Load*: proc(self: ptr IPersistPropertyBag2, pPropBag: ptr IPropertyBag2, pErrLog: ptr IErrorLog): HRESULT {.stdcall.}
    Save*: proc(self: ptr IPersistPropertyBag2, pPropBag: ptr IPropertyBag2, fClearDirty: WINBOOL, fSaveAllProperties: WINBOOL): HRESULT {.stdcall.}
    IsDirty*: proc(self: ptr IPersistPropertyBag2): HRESULT {.stdcall.}
  LPPERSISTPROPERTYBAG2* = ptr IPersistPropertyBag2
  IAdviseSinkEx* {.pure.} = object
    lpVtbl*: ptr IAdviseSinkExVtbl
  IAdviseSinkExVtbl* {.pure, inheritable.} = object of IAdviseSinkVtbl
    OnViewStatusChange*: proc(self: ptr IAdviseSinkEx, dwViewStatus: DWORD): void {.stdcall.}
  LPADVISESINKEX* = ptr IAdviseSinkEx
  QACONTAINER* {.pure.} = object
    cbSize*: ULONG
    pClientSite*: ptr IOleClientSite
    pAdviseSink*: ptr IAdviseSinkEx
    pPropertyNotifySink*: ptr IPropertyNotifySink
    pUnkEventSink*: ptr IUnknown
    dwAmbientFlags*: DWORD
    colorFore*: OLE_COLOR
    colorBack*: OLE_COLOR
    pFont*: ptr IFont
    pUndoMgr*: ptr IOleUndoManager
    dwAppearance*: DWORD
    lcid*: LONG
    hpal*: HPALETTE
    pBindHost*: ptr IBindHost
    pOleControlSite*: ptr IOleControlSite
    pServiceProvider*: ptr IServiceProvider
  QACONTROL* {.pure.} = object
    cbSize*: ULONG
    dwMiscStatus*: DWORD
    dwViewStatus*: DWORD
    dwEventCookie*: DWORD
    dwPropNotifyCookie*: DWORD
    dwPointerActivationPolicy*: DWORD
  IQuickActivate* {.pure.} = object
    lpVtbl*: ptr IQuickActivateVtbl
  IQuickActivateVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QuickActivate*: proc(self: ptr IQuickActivate, pQaContainer: ptr QACONTAINER, pQaControl: ptr QACONTROL): HRESULT {.stdcall.}
    SetContentExtent*: proc(self: ptr IQuickActivate, pSizel: LPSIZEL): HRESULT {.stdcall.}
    GetContentExtent*: proc(self: ptr IQuickActivate, pSizel: LPSIZEL): HRESULT {.stdcall.}
  LPQUICKACTIVATE* = ptr IQuickActivate
  CATID* = GUID
  REFCATID* = REFGUID
  IEnumGUID* {.pure.} = object
    lpVtbl*: ptr IEnumGUIDVtbl
  IEnumGUIDVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumGUID, celt: ULONG, rgelt: ptr GUID, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumGUID, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumGUID): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumGUID, ppenum: ptr ptr IEnumGUID): HRESULT {.stdcall.}
  IEnumCLSID* = IEnumGUID
  LPENUMGUID* = ptr IEnumGUID
  LPENUMCLSID* = LPENUMGUID
  IEnumCATID* = IEnumGUID
  CATEGORYINFO* {.pure.} = object
    catid*: CATID
    lcid*: LCID
    szDescription*: array[128, OLECHAR]
  IEnumCATEGORYINFO* {.pure.} = object
    lpVtbl*: ptr IEnumCATEGORYINFOVtbl
  IEnumCATEGORYINFOVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumCATEGORYINFO, celt: ULONG, rgelt: ptr CATEGORYINFO, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumCATEGORYINFO, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumCATEGORYINFO): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumCATEGORYINFO, ppenum: ptr ptr IEnumCATEGORYINFO): HRESULT {.stdcall.}
  LPENUMCATEGORYINFO* = ptr IEnumCATEGORYINFO
  LPCATEGORYINFO* = ptr CATEGORYINFO
  ICatRegister* {.pure.} = object
    lpVtbl*: ptr ICatRegisterVtbl
  ICatRegisterVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RegisterCategories*: proc(self: ptr ICatRegister, cCategories: ULONG, rgCategoryInfo: ptr CATEGORYINFO): HRESULT {.stdcall.}
    UnRegisterCategories*: proc(self: ptr ICatRegister, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.stdcall.}
    RegisterClassImplCategories*: proc(self: ptr ICatRegister, rclsid: REFCLSID, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.stdcall.}
    UnRegisterClassImplCategories*: proc(self: ptr ICatRegister, rclsid: REFCLSID, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.stdcall.}
    RegisterClassReqCategories*: proc(self: ptr ICatRegister, rclsid: REFCLSID, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.stdcall.}
    UnRegisterClassReqCategories*: proc(self: ptr ICatRegister, rclsid: REFCLSID, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.stdcall.}
  LPCATREGISTER* = ptr ICatRegister
  ICatInformation* {.pure.} = object
    lpVtbl*: ptr ICatInformationVtbl
  ICatInformationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    EnumCategories*: proc(self: ptr ICatInformation, lcid: LCID, ppenumCategoryInfo: ptr ptr IEnumCATEGORYINFO): HRESULT {.stdcall.}
    GetCategoryDesc*: proc(self: ptr ICatInformation, rcatid: REFCATID, lcid: LCID, pszDesc: ptr LPWSTR): HRESULT {.stdcall.}
    EnumClassesOfCategories*: proc(self: ptr ICatInformation, cImplemented: ULONG, rgcatidImpl: ptr CATID, cRequired: ULONG, rgcatidReq: ptr CATID, ppenumClsid: ptr ptr IEnumGUID): HRESULT {.stdcall.}
    IsClassOfCategories*: proc(self: ptr ICatInformation, rclsid: REFCLSID, cImplemented: ULONG, rgcatidImpl: ptr CATID, cRequired: ULONG, rgcatidReq: ptr CATID): HRESULT {.stdcall.}
    EnumImplCategoriesOfClass*: proc(self: ptr ICatInformation, rclsid: REFCLSID, ppenumCatid: ptr ptr IEnumGUID): HRESULT {.stdcall.}
    EnumReqCategoriesOfClass*: proc(self: ptr ICatInformation, rclsid: REFCLSID, ppenumCatid: ptr ptr IEnumGUID): HRESULT {.stdcall.}
  LPCATINFORMATION* = ptr ICatInformation
  SHITEMID* {.pure, packed.} = object
    cb*: USHORT
    abID*: array[1, BYTE]
  LPSHITEMID* = ptr SHITEMID
  LPCSHITEMID* = ptr SHITEMID
  ITEMIDLIST* {.pure, packed.} = object
    mkid*: SHITEMID
  ITEMIDLIST_RELATIVE* = ITEMIDLIST
  ITEMID_CHILD* = ITEMIDLIST
  ITEMIDLIST_ABSOLUTE* = ITEMIDLIST
  wirePIDL* = ptr BYTE_BLOB
  LPITEMIDLIST* = ptr ITEMIDLIST
  LPCITEMIDLIST* = ptr ITEMIDLIST
  PIDLIST_ABSOLUTE* = ptr ITEMIDLIST_ABSOLUTE
  PCIDLIST_ABSOLUTE* = ptr ITEMIDLIST_ABSOLUTE
  PCUIDLIST_ABSOLUTE* = ptr ITEMIDLIST_ABSOLUTE
  PIDLIST_RELATIVE* = ptr ITEMIDLIST_RELATIVE
  PCIDLIST_RELATIVE* = ptr ITEMIDLIST_RELATIVE
  PUIDLIST_RELATIVE* = ptr ITEMIDLIST_RELATIVE
  PCUIDLIST_RELATIVE* = ptr ITEMIDLIST_RELATIVE
  PITEMID_CHILD* = ptr ITEMID_CHILD
  PCITEMID_CHILD* = ptr ITEMID_CHILD
  PUITEMID_CHILD* = ptr ITEMID_CHILD
  PCUITEMID_CHILD* = ptr ITEMID_CHILD
  PCUITEMID_CHILD_ARRAY* = ptr PCUITEMID_CHILD
  PCUIDLIST_RELATIVE_ARRAY* = ptr PCUIDLIST_RELATIVE
  PCIDLIST_ABSOLUTE_ARRAY* = ptr PCIDLIST_ABSOLUTE
  PCUIDLIST_ABSOLUTE_ARRAY* = ptr PCUIDLIST_ABSOLUTE
  STRRET_UNION1* {.pure, union.} = object
    pOleStr*: LPWSTR
    uOffset*: UINT
    cStr*: array[260, char]
  STRRET* {.pure.} = object
    uType*: UINT
    union1*: STRRET_UNION1
  LPSTRRET* = ptr STRRET
  SHELLDETAILS* {.pure.} = object
    fmt*: int32
    cxChar*: int32
    str*: STRRET
  LPSHELLDETAILS* = ptr SHELLDETAILS
  KNOWNFOLDERID* = GUID
  REFKNOWNFOLDERID* = ptr KNOWNFOLDERID
  FOLDERTYPEID* = GUID
  REFFOLDERTYPEID* = ptr FOLDERTYPEID
  TASKOWNERID* = GUID
  REFTASKOWNERID* = ptr TASKOWNERID
  ELEMENTID* = GUID
  REFELEMENTID* = ptr ELEMENTID
  PROPERTYKEY* {.pure.} = object
    fmtid*: GUID
    pid*: DWORD
  SHCOLUMNID* = PROPERTYKEY
  LPCSHCOLUMNID* = ptr SHCOLUMNID
  IOleDocumentView* {.pure.} = object
    lpVtbl*: ptr IOleDocumentViewVtbl
  IOleDocumentViewVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetInPlaceSite*: proc(self: ptr IOleDocumentView, pIPSite: ptr IOleInPlaceSite): HRESULT {.stdcall.}
    GetInPlaceSite*: proc(self: ptr IOleDocumentView, ppIPSite: ptr ptr IOleInPlaceSite): HRESULT {.stdcall.}
    GetDocument*: proc(self: ptr IOleDocumentView, ppunk: ptr ptr IUnknown): HRESULT {.stdcall.}
    SetRect*: proc(self: ptr IOleDocumentView, prcView: LPRECT): HRESULT {.stdcall.}
    GetRect*: proc(self: ptr IOleDocumentView, prcView: LPRECT): HRESULT {.stdcall.}
    SetRectComplex*: proc(self: ptr IOleDocumentView, prcView: LPRECT, prcHScroll: LPRECT, prcVScroll: LPRECT, prcSizeBox: LPRECT): HRESULT {.stdcall.}
    Show*: proc(self: ptr IOleDocumentView, fShow: WINBOOL): HRESULT {.stdcall.}
    UIActivate*: proc(self: ptr IOleDocumentView, fUIActivate: WINBOOL): HRESULT {.stdcall.}
    Open*: proc(self: ptr IOleDocumentView): HRESULT {.stdcall.}
    CloseView*: proc(self: ptr IOleDocumentView, dwReserved: DWORD): HRESULT {.stdcall.}
    SaveViewState*: proc(self: ptr IOleDocumentView, pstm: LPSTREAM): HRESULT {.stdcall.}
    ApplyViewState*: proc(self: ptr IOleDocumentView, pstm: LPSTREAM): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IOleDocumentView, pIPSiteNew: ptr IOleInPlaceSite, ppViewNew: ptr ptr IOleDocumentView): HRESULT {.stdcall.}
  IEnumOleDocumentViews* {.pure.} = object
    lpVtbl*: ptr IEnumOleDocumentViewsVtbl
  IEnumOleDocumentViewsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IEnumOleDocumentViews, cViews: ULONG, rgpView: ptr ptr IOleDocumentView, pcFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IEnumOleDocumentViews, cViews: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IEnumOleDocumentViews): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IEnumOleDocumentViews, ppEnum: ptr ptr IEnumOleDocumentViews): HRESULT {.stdcall.}
  IOleDocument* {.pure.} = object
    lpVtbl*: ptr IOleDocumentVtbl
  IOleDocumentVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateView*: proc(self: ptr IOleDocument, pIPSite: ptr IOleInPlaceSite, pstm: ptr IStream, dwReserved: DWORD, ppView: ptr ptr IOleDocumentView): HRESULT {.stdcall.}
    GetDocMiscStatus*: proc(self: ptr IOleDocument, pdwStatus: ptr DWORD): HRESULT {.stdcall.}
    EnumViews*: proc(self: ptr IOleDocument, ppEnum: ptr ptr IEnumOleDocumentViews, ppView: ptr ptr IOleDocumentView): HRESULT {.stdcall.}
  LPOLEDOCUMENT* = ptr IOleDocument
  IOleDocumentSite* {.pure.} = object
    lpVtbl*: ptr IOleDocumentSiteVtbl
  IOleDocumentSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ActivateMe*: proc(self: ptr IOleDocumentSite, pViewToActivate: ptr IOleDocumentView): HRESULT {.stdcall.}
  LPOLEDOCUMENTSITE* = ptr IOleDocumentSite
  LPOLEDOCUMENTVIEW* = ptr IOleDocumentView
  LPENUMOLEDOCUMENTVIEWS* = ptr IEnumOleDocumentViews
  IContinueCallback* {.pure.} = object
    lpVtbl*: ptr IContinueCallbackVtbl
  IContinueCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FContinue*: proc(self: ptr IContinueCallback): HRESULT {.stdcall.}
    FContinuePrinting*: proc(self: ptr IContinueCallback, nCntPrinted: LONG, nCurPage: LONG, pwszPrintStatus: ptr uint16): HRESULT {.stdcall.}
  LPCONTINUECALLBACK* = ptr IContinueCallback
  PAGERANGE* {.pure.} = object
    nFromPage*: LONG
    nToPage*: LONG
  PAGESET* {.pure.} = object
    cbStruct*: ULONG
    fOddPages*: WINBOOL
    fEvenPages*: WINBOOL
    cPageRange*: ULONG
    rgPages*: array[1, PAGERANGE]
  IPrint* {.pure.} = object
    lpVtbl*: ptr IPrintVtbl
  IPrintVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetInitialPageNum*: proc(self: ptr IPrint, nFirstPage: LONG): HRESULT {.stdcall.}
    GetPageInfo*: proc(self: ptr IPrint, pnFirstPage: ptr LONG, pcPages: ptr LONG): HRESULT {.stdcall.}
    Print*: proc(self: ptr IPrint, grfFlags: DWORD, pptd: ptr ptr DVTARGETDEVICE, ppPageSet: ptr ptr PAGESET, pstgmOptions: ptr STGMEDIUM, pcallback: ptr IContinueCallback, nFirstPage: LONG, pcPagesPrinted: ptr LONG, pnLastPage: ptr LONG): HRESULT {.stdcall.}
  LPPRINT* = ptr IPrint
  OLECMD* {.pure.} = object
    cmdID*: ULONG
    cmdf*: DWORD
  OLECMDTEXT* {.pure.} = object
    cmdtextf*: DWORD
    cwActual*: ULONG
    cwBuf*: ULONG
    rgwz*: array[1, uint16]
  IOleCommandTarget* {.pure.} = object
    lpVtbl*: ptr IOleCommandTargetVtbl
  IOleCommandTargetVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryStatus*: proc(self: ptr IOleCommandTarget, pguidCmdGroup: ptr GUID, cCmds: ULONG, prgCmds: ptr OLECMD, pCmdText: ptr OLECMDTEXT): HRESULT {.stdcall.}
    Exec*: proc(self: ptr IOleCommandTarget, pguidCmdGroup: ptr GUID, nCmdID: DWORD, nCmdexecopt: DWORD, pvaIn: ptr VARIANT, pvaOut: ptr VARIANT): HRESULT {.stdcall.}
  LPOLECOMMANDTARGET* = ptr IOleCommandTarget
  IMsoDocument* = IOleDocument
  IMsoDocumentSite* = IOleDocumentSite
  IMsoView* = IOleDocumentView
  IEnumMsoView* = IEnumOleDocumentViews
  IMsoCommandTarget* = IOleCommandTarget
  LPMSODOCUMENT* = LPOLEDOCUMENT
  LPMSODOCUMENTSITE* = LPOLEDOCUMENTSITE
  LPMSOVIEW* = LPOLEDOCUMENTVIEW
  LPENUMMSOVIEW* = LPENUMOLEDOCUMENTVIEWS
  LPMSOCOMMANDTARGET* = LPOLECOMMANDTARGET
  MSOCMD* = OLECMD
  MSOCMDTEXT* = OLECMDTEXT
  REFPROPERTYKEY* = ptr PROPERTYKEY
  IPropertyStore* {.pure.} = object
    lpVtbl*: ptr IPropertyStoreVtbl
  IPropertyStoreVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCount*: proc(self: ptr IPropertyStore, cProps: ptr DWORD): HRESULT {.stdcall.}
    GetAt*: proc(self: ptr IPropertyStore, iProp: DWORD, pkey: ptr PROPERTYKEY): HRESULT {.stdcall.}
    GetValue*: proc(self: ptr IPropertyStore, key: REFPROPERTYKEY, pv: ptr PROPVARIANT): HRESULT {.stdcall.}
    SetValue*: proc(self: ptr IPropertyStore, key: REFPROPERTYKEY, propvar: REFPROPVARIANT): HRESULT {.stdcall.}
    Commit*: proc(self: ptr IPropertyStore): HRESULT {.stdcall.}
  LPPROPERTYSTORE* = ptr IPropertyStore
  SERIALIZEDPROPSTORAGE* {.pure.} = object
  PUSERIALIZEDPROPSTORAGE* = ptr SERIALIZEDPROPSTORAGE
  PCUSERIALIZEDPROPSTORAGE* = ptr SERIALIZEDPROPSTORAGE
  LPBINDPTR* = ptr BINDPTR
  CODEBASEHOLD* {.pure.} = object
    cbSize*: ULONG
    szDistUnit*: LPWSTR
    szCodeBase*: LPWSTR
    dwVersionMS*: DWORD
    dwVersionLS*: DWORD
    dwStyle*: DWORD
  LPCODEBASEHOLD* = ptr CODEBASEHOLD
  SOFTDISTINFO* {.pure.} = object
    cbSize*: ULONG
    dwFlags*: DWORD
    dwAdState*: DWORD
    szTitle*: LPWSTR
    szAbstract*: LPWSTR
    szHREF*: LPWSTR
    dwInstalledVersionMS*: DWORD
    dwInstalledVersionLS*: DWORD
    dwUpdateVersionMS*: DWORD
    dwUpdateVersionLS*: DWORD
    dwAdvertisedVersionMS*: DWORD
    dwAdvertisedVersionLS*: DWORD
    dwReserved*: DWORD
  LPSOFTDISTINFO* = ptr SOFTDISTINFO
  HIT_LOGGING_INFO* {.pure.} = object
    dwStructSize*: DWORD
    lpszLoggedUrlName*: LPSTR
    StartTime*: SYSTEMTIME
    EndTime*: SYSTEMTIME
    lpszExtendedInfo*: LPSTR
  LPHIT_LOGGING_INFO* = ptr HIT_LOGGING_INFO
  PROTOCOL_ARGUMENT* {.pure.} = object
    szMethod*: LPCWSTR
    szTargetUrl*: LPCWSTR
  LPPROTOCOL_ARGUMENT* = ptr PROTOCOL_ARGUMENT
const
  CLSCTX_INPROC_SERVER* = 0x1
  CLSCTX_INPROC_HANDLER* = 0x2
  CLSCTX_INPROC* = CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER
  CLSCTX_LOCAL_SERVER* = 0x4
  CLSCTX_REMOTE_SERVER* = 0x10
  CLSCTX_ALL* = CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER or CLSCTX_LOCAL_SERVER or CLSCTX_REMOTE_SERVER
  CLSCTX_SERVER* = CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER or CLSCTX_REMOTE_SERVER
  REGCLS_SINGLEUSE* = 0
  REGCLS_MULTIPLEUSE* = 1
  REGCLS_MULTI_SEPARATE* = 2
  REGCLS_SUSPENDED* = 4
  REGCLS_SURROGATE* = 8
  COINITBASE_MULTITHREADED* = 0x0
  WIN32* = 100
  STDOLE_MAJORVERNUM* = 0x1
  STDOLE_MINORVERNUM* = 0x0
  STDOLE_LCID* = 0x0000
  STDOLE2_MAJORVERNUM* = 0x2
  STDOLE2_MINORVERNUM* = 0x0
  STDOLE2_LCID* = 0x0000
  ROTFLAGS_REGISTRATIONKEEPSALIVE* = 0x1
  ROTFLAGS_ALLOWANYCLIENT* = 0x2
  ROT_COMPARE_MAX* = 2048
  DVASPECT_CONTENT* = 1
  DVASPECT_THUMBNAIL* = 2
  DVASPECT_ICON* = 4
  DVASPECT_DOCPRINT* = 8
  STGC_DEFAULT* = 0
  STGC_OVERWRITE* = 1
  STGC_ONLYIFCURRENT* = 2
  STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE* = 4
  STGC_CONSOLIDATE* = 8
  STGMOVE_MOVE* = 0
  STGMOVE_COPY* = 1
  STGMOVE_SHALLOWCOPY* = 2
  STATFLAG_DEFAULT* = 0
  STATFLAG_NONAME* = 1
  STATFLAG_NOOPEN* = 2
  WDT_INPROC_CALL* = 0x48746457
  WDT_REMOTE_CALL* = 0x52746457
  WDT_INPROC64_CALL* = 0x50746457
  DECIMAL_NEG* = BYTE 0x80
  VARIANT_TRUE* = VARIANT_BOOL(-1)
  VARIANT_FALSE* = VARIANT_BOOL 0
  VT_EMPTY* = 0
  VT_NULL* = 1
  VT_I2* = 2
  VT_I4* = 3
  VT_R4* = 4
  VT_R8* = 5
  VT_CY* = 6
  VT_DATE* = 7
  VT_BSTR* = 8
  VT_DISPATCH* = 9
  VT_ERROR* = 10
  VT_BOOL* = 11
  VT_VARIANT* = 12
  VT_UNKNOWN* = 13
  VT_DECIMAL* = 14
  VT_I1* = 16
  VT_UI1* = 17
  VT_UI2* = 18
  VT_UI4* = 19
  VT_I8* = 20
  VT_UI8* = 21
  VT_INT* = 22
  VT_UINT* = 23
  VT_VOID* = 24
  VT_HRESULT* = 25
  VT_PTR* = 26
  VT_SAFEARRAY* = 27
  VT_CARRAY* = 28
  VT_USERDEFINED* = 29
  VT_LPSTR* = 30
  VT_LPWSTR* = 31
  VT_RECORD* = 36
  VT_INT_PTR* = 37
  VT_UINT_PTR* = 38
  VT_FILETIME* = 64
  VT_BLOB* = 65
  VT_STREAM* = 66
  VT_STORAGE* = 67
  VT_STREAMED_OBJECT* = 68
  VT_STORED_OBJECT* = 69
  VT_BLOB_OBJECT* = 70
  VT_CF* = 71
  VT_CLSID* = 72
  VT_VERSIONED_STREAM* = 73
  VT_BSTR_BLOB* = 0xfff
  VT_VECTOR* = 0x1000
  VT_ARRAY* = 0x2000
  VT_BYREF* = 0x4000
  VT_RESERVED* = 0x8000
  VT_ILLEGAL* = 0xffff
  VT_ILLEGALMASKED* = 0xfff
  VT_TYPEMASK* = 0xfff
  TYSPEC_CLSID* = 0
  TYSPEC_FILEEXT* = 1
  TYSPEC_MIMETYPE* = 2
  TYSPEC_FILENAME* = 3
  TYSPEC_PROGID* = 4
  TYSPEC_PACKAGENAME* = 5
  TYSPEC_OBJECTID* = 6
  IID_IUnknown* = DEFINE_GUID("00000000-0000-0000-c000-000000000046")
  IID_AsyncIUnknown* = DEFINE_GUID("000e0000-0000-0000-c000-000000000046")
  IID_IClassFactory* = DEFINE_GUID("00000001-0000-0000-c000-000000000046")
  IID_IMarshal* = DEFINE_GUID("00000003-0000-0000-c000-000000000046")
  IID_INoMarshal* = DEFINE_GUID("ecc8691b-c1db-4dc0-855e-65f6c551af49")
  IID_IAgileObject* = DEFINE_GUID("94ea2b94-e9cc-49e0-c0ff-ee64ca8f5b90")
  IID_IMarshal2* = DEFINE_GUID("000001cf-0000-0000-c000-000000000046")
  IID_IMalloc* = DEFINE_GUID("00000002-0000-0000-c000-000000000046")
  IID_IStdMarshalInfo* = DEFINE_GUID("00000018-0000-0000-c000-000000000046")
  EXTCONN_STRONG* = 0x1
  EXTCONN_WEAK* = 0x2
  EXTCONN_CALLABLE* = 0x4
  IID_IExternalConnection* = DEFINE_GUID("00000019-0000-0000-c000-000000000046")
  IID_IMultiQI* = DEFINE_GUID("00000020-0000-0000-c000-000000000046")
  IID_AsyncIMultiQI* = DEFINE_GUID("000e0020-0000-0000-c000-000000000046")
  IID_IInternalUnknown* = DEFINE_GUID("00000021-0000-0000-c000-000000000046")
  IID_IEnumUnknown* = DEFINE_GUID("00000100-0000-0000-c000-000000000046")
  IID_IEnumString* = DEFINE_GUID("00000101-0000-0000-c000-000000000046")
  IID_ISequentialStream* = DEFINE_GUID("0c733a30-2a1c-11ce-ade5-00aa0044773d")
  STGTY_STORAGE* = 1
  STGTY_STREAM* = 2
  STGTY_LOCKBYTES* = 3
  STGTY_PROPERTY* = 4
  STREAM_SEEK_SET* = 0
  STREAM_SEEK_CUR* = 1
  STREAM_SEEK_END* = 2
  LOCK_WRITE* = 1
  LOCK_EXCLUSIVE* = 2
  LOCK_ONLYONCE* = 4
  IID_IStream* = DEFINE_GUID("0000000c-0000-0000-c000-000000000046")
  IID_IRpcChannelBuffer* = DEFINE_GUID("d5f56b60-593b-101a-b569-08002b2dbf7a")
  IID_IRpcChannelBuffer2* = DEFINE_GUID("594f31d0-7f19-11d0-b194-00a0c90dc8bf")
  IID_IAsyncRpcChannelBuffer* = DEFINE_GUID("a5029fb6-3c34-11d1-9c99-00c04fb998aa")
  IID_IRpcChannelBuffer3* = DEFINE_GUID("25b15600-0115-11d0-bf0d-00aa00b8dfd2")
  IID_IRpcSyntaxNegotiate* = DEFINE_GUID("58a08519-24c8-4935-b482-3fd823333a4f")
  IID_IRpcProxyBuffer* = DEFINE_GUID("d5f56a34-593b-101a-b569-08002b2dbf7a")
  IID_IRpcStubBuffer* = DEFINE_GUID("d5f56afc-593b-101a-b569-08002b2dbf7a")
  IID_IPSFactoryBuffer* = DEFINE_GUID("d5f569d0-593b-101a-b569-08002b2dbf7a")
  IID_IChannelHook* = DEFINE_GUID("1008c4a0-7613-11cf-9af1-0020af6e72f4")
  EOAC_NONE* = 0x0
  EOAC_MUTUAL_AUTH* = 0x1
  EOAC_STATIC_CLOAKING* = 0x20
  EOAC_DYNAMIC_CLOAKING* = 0x40
  EOAC_ANY_AUTHORITY* = 0x80
  EOAC_MAKE_FULLSIC* = 0x100
  EOAC_DEFAULT* = 0x800
  EOAC_SECURE_REFS* = 0x2
  EOAC_ACCESS_CONTROL* = 0x4
  EOAC_APPID* = 0x8
  EOAC_DYNAMIC* = 0x10
  EOAC_REQUIRE_FULLSIC* = 0x200
  EOAC_AUTO_IMPERSONATE* = 0x400
  EOAC_NO_CUSTOM_MARSHAL* = 0x2000
  EOAC_DISABLE_AAA* = 0x1000
  IID_IClientSecurity* = DEFINE_GUID("0000013d-0000-0000-c000-000000000046")
  IID_IServerSecurity* = DEFINE_GUID("0000013e-0000-0000-c000-000000000046")
  COMBND_RPCTIMEOUT* = 0x1
  COMBND_SERVER_LOCALITY* = 0x2
  COMBND_RESERVED1* = 0x4
  SERVER_LOCALITY_PROCESS_LOCAL* = 0
  SERVER_LOCALITY_MACHINE_LOCAL* = 1
  SERVER_LOCALITY_REMOTE* = 2
  IID_IRpcOptions* = DEFINE_GUID("00000144-0000-0000-c000-000000000046")
  COMGLB_EXCEPTION_HANDLING* = 1
  COMGLB_APPID* = 2
  COMGLB_RPC_THREADPOOL_SETTING* = 3
  COMGLB_RO_SETTINGS* = 4
  COMGLB_UNMARSHALING_POLICY* = 5
  COMGLB_EXCEPTION_HANDLE* = 0
  COMGLB_EXCEPTION_DONOT_HANDLE_FATAL* = 1
  COMGLB_EXCEPTION_DONOT_HANDLE* = COMGLB_EXCEPTION_DONOT_HANDLE_FATAL
  COMGLB_EXCEPTION_DONOT_HANDLE_ANY* = 2
  COMGLB_RPC_THREADPOOL_SETTING_DEFAULT_POOL* = 0
  COMGLB_RPC_THREADPOOL_SETTING_PRIVATE_POOL* = 1
  COMGLB_STA_MODALLOOP_REMOVE_TOUCH_MESSAGES* = 0x1
  COMGLB_STA_MODALLOOP_SHARED_QUEUE_REMOVE_INPUT_MESSAGES* = 0x2
  COMGLB_STA_MODALLOOP_SHARED_QUEUE_DONOT_REMOVE_INPUT_MESSAGES* = 0x4
  COMGLB_FAST_RUNDOWN* = 0x8
  COMGLB_RESERVED1* = 0x10
  COMGLB_RESERVED2* = 0x20
  COMGLB_RESERVED3* = 0x40
  COMGLB_STA_MODALLOOP_SHARED_QUEUE_REORDER_POINTER_MESSAGES* = 0x80
  COMGLB_UNMARSHALING_POLICY_NORMAL* = 0
  COMGLB_UNMARSHALING_POLICY_STRONG* = 1
  COMGLB_UNMARSHALING_POLICY_HYBRID* = 2
  IID_IGlobalOptions* = DEFINE_GUID("0000015b-0000-0000-c000-000000000046")
  IID_ISurrogate* = DEFINE_GUID("00000022-0000-0000-c000-000000000046")
  IID_IGlobalInterfaceTable* = DEFINE_GUID("00000146-0000-0000-c000-000000000046")
  IID_ISynchronize* = DEFINE_GUID("00000030-0000-0000-c000-000000000046")
  IID_ISynchronizeHandle* = DEFINE_GUID("00000031-0000-0000-c000-000000000046")
  IID_ISynchronizeEvent* = DEFINE_GUID("00000032-0000-0000-c000-000000000046")
  IID_ISynchronizeContainer* = DEFINE_GUID("00000033-0000-0000-c000-000000000046")
  IID_ISynchronizeMutex* = DEFINE_GUID("00000025-0000-0000-c000-000000000046")
  IID_ICancelMethodCalls* = DEFINE_GUID("00000029-0000-0000-c000-000000000046")
  DCOM_NONE* = 0x0
  DCOM_CALL_COMPLETE* = 0x1
  DCOM_CALL_CANCELED* = 0x2
  IID_IAsyncManager* = DEFINE_GUID("0000002a-0000-0000-c000-000000000046")
  IID_ICallFactory* = DEFINE_GUID("1c733a30-2a1c-11ce-ade5-00aa0044773d")
  IID_IRpcHelper* = DEFINE_GUID("00000149-0000-0000-c000-000000000046")
  IID_IReleaseMarshalBuffers* = DEFINE_GUID("eb0cb9e8-7996-11d2-872e-0000f8080859")
  IID_IWaitMultiple* = DEFINE_GUID("0000002b-0000-0000-c000-000000000046")
  IID_IAddrTrackingControl* = DEFINE_GUID("00000147-0000-0000-c000-000000000046")
  IID_IAddrExclusionControl* = DEFINE_GUID("00000148-0000-0000-c000-000000000046")
  IID_IPipeByte* = DEFINE_GUID("db2f3aca-2f86-11d1-8e04-00c04fb9989a")
  IID_IPipeLong* = DEFINE_GUID("db2f3acc-2f86-11d1-8e04-00c04fb9989a")
  IID_IPipeDouble* = DEFINE_GUID("db2f3ace-2f86-11d1-8e04-00c04fb9989a")
  IID_IEnumContextProps* = DEFINE_GUID("000001c1-0000-0000-c000-000000000046")
  IID_IContext* = DEFINE_GUID("000001c0-0000-0000-c000-000000000046")
  APTTYPEQUALIFIER_NONE* = 0
  APTTYPEQUALIFIER_IMPLICIT_MTA* = 1
  APTTYPEQUALIFIER_NA_ON_MTA* = 2
  APTTYPEQUALIFIER_NA_ON_STA* = 3
  APTTYPEQUALIFIER_NA_ON_IMPLICIT_MTA* = 4
  APTTYPEQUALIFIER_NA_ON_MAINSTA* = 5
  APTTYPEQUALIFIER_APPLICATION_STA* = 6
  APTTYPE_CURRENT* = -1
  APTTYPE_STA* = 0
  APTTYPE_MTA* = 1
  APTTYPE_NA* = 2
  APTTYPE_MAINSTA* = 3
  THDTYPE_BLOCKMESSAGES* = 0
  THDTYPE_PROCESSMESSAGES* = 1
  IID_IComThreadingInfo* = DEFINE_GUID("000001ce-0000-0000-c000-000000000046")
  IID_IProcessInitControl* = DEFINE_GUID("72380d55-8d2b-43a3-8513-2b6ef31434e9")
  IID_IFastRundown* = DEFINE_GUID("00000040-0000-0000-c000-000000000046")
  CO_MARSHALING_SOURCE_IS_APP_CONTAINER* = 0
  IID_IMarshalingStream* = DEFINE_GUID("d8f2f5e6-6102-4863-9f26-389a4676efde")
  IID_IMallocSpy* = DEFINE_GUID("0000001d-0000-0000-c000-000000000046")
  BIND_MAYBOTHERUSER* = 1
  BIND_JUSTTESTEXISTENCE* = 2
  IID_IBindCtx* = DEFINE_GUID("0000000e-0000-0000-c000-000000000046")
  IID_IEnumMoniker* = DEFINE_GUID("00000102-0000-0000-c000-000000000046")
  IID_IRunnableObject* = DEFINE_GUID("00000126-0000-0000-c000-000000000046")
  IID_IRunningObjectTable* = DEFINE_GUID("00000010-0000-0000-c000-000000000046")
  IID_IPersist* = DEFINE_GUID("0000010c-0000-0000-c000-000000000046")
  IID_IPersistStream* = DEFINE_GUID("00000109-0000-0000-c000-000000000046")
  MKSYS_NONE* = 0
  MKSYS_GENERICCOMPOSITE* = 1
  MKSYS_FILEMONIKER* = 2
  MKSYS_ANTIMONIKER* = 3
  MKSYS_ITEMMONIKER* = 4
  MKSYS_POINTERMONIKER* = 5
  MKSYS_CLASSMONIKER* = 7
  MKSYS_OBJREFMONIKER* = 8
  MKSYS_SESSIONMONIKER* = 9
  MKSYS_LUAMONIKER* = 10
  MKRREDUCE_ONE* = 3 shl 16
  MKRREDUCE_TOUSER* = 2 shl 16
  MKRREDUCE_THROUGHUSER* = 1 shl 16
  MKRREDUCE_ALL* = 0
  IID_IMoniker* = DEFINE_GUID("0000000f-0000-0000-c000-000000000046")
  IID_IROTData* = DEFINE_GUID("f29f6bc0-5021-11ce-aa15-00006901293f")
  IID_IEnumSTATSTG* = DEFINE_GUID("0000000d-0000-0000-c000-000000000046")
  IID_IStorage* = DEFINE_GUID("0000000b-0000-0000-c000-000000000046")
  IID_IPersistFile* = DEFINE_GUID("0000010b-0000-0000-c000-000000000046")
  IID_IPersistStorage* = DEFINE_GUID("0000010a-0000-0000-c000-000000000046")
  IID_ILockBytes* = DEFINE_GUID("0000000a-0000-0000-c000-000000000046")
  IID_IEnumFORMATETC* = DEFINE_GUID("00000103-0000-0000-c000-000000000046")
  ADVF_NODATA* = 1
  ADVF_PRIMEFIRST* = 2
  ADVF_ONLYONCE* = 4
  ADVF_DATAONSTOP* = 64
  ADVFCACHE_NOHANDLER* = 8
  ADVFCACHE_FORCEBUILTIN* = 16
  ADVFCACHE_ONSAVE* = 32
  IID_IEnumSTATDATA* = DEFINE_GUID("00000105-0000-0000-c000-000000000046")
  IID_IRootStorage* = DEFINE_GUID("00000012-0000-0000-c000-000000000046")
  TYMED_HGLOBAL* = 1
  TYMED_FILE* = 2
  TYMED_ISTREAM* = 4
  TYMED_ISTORAGE* = 8
  TYMED_GDI* = 16
  TYMED_MFPICT* = 32
  TYMED_ENHMF* = 64
  TYMED_NULL* = 0
  IID_IAdviseSink* = DEFINE_GUID("0000010f-0000-0000-c000-000000000046")
  IID_AsyncIAdviseSink* = DEFINE_GUID("00000150-0000-0000-c000-000000000046")
  IID_IAdviseSink2* = DEFINE_GUID("00000125-0000-0000-c000-000000000046")
  IID_AsyncIAdviseSink2* = DEFINE_GUID("00000151-0000-0000-c000-000000000046")
  DATADIR_GET* = 1
  DATADIR_SET* = 2
  IID_IDataObject* = DEFINE_GUID("0000010e-0000-0000-c000-000000000046")
  IID_IDataAdviseHolder* = DEFINE_GUID("00000110-0000-0000-c000-000000000046")
  CALLTYPE_TOPLEVEL* = 1
  CALLTYPE_NESTED* = 2
  CALLTYPE_ASYNC* = 3
  CALLTYPE_TOPLEVEL_CALLPENDING* = 4
  CALLTYPE_ASYNC_CALLPENDING* = 5
  SERVERCALL_ISHANDLED* = 0
  SERVERCALL_REJECTED* = 1
  SERVERCALL_RETRYLATER* = 2
  PENDINGTYPE_TOPLEVEL* = 1
  PENDINGTYPE_NESTED* = 2
  PENDINGMSG_CANCELCALL* = 0
  PENDINGMSG_WAITNOPROCESS* = 1
  PENDINGMSG_WAITDEFPROCESS* = 2
  IID_IMessageFilter* = DEFINE_GUID("00000016-0000-0000-c000-000000000046")
  IID_IClassActivator* = DEFINE_GUID("00000140-0000-0000-c000-000000000046")
  IID_IFillLockBytes* = DEFINE_GUID("99caf010-415e-11cf-8814-00aa00b569f5")
  IID_IProgressNotify* = DEFINE_GUID("a9d758a0-4617-11cf-95fc-00aa00680db4")
  IID_ILayoutStorage* = DEFINE_GUID("0e6d4d90-6738-11cf-9608-00aa00680db4")
  IID_IBlockingLock* = DEFINE_GUID("30f3d47a-6447-11d1-8e3c-00c04fb9386d")
  IID_ITimeAndNoticeControl* = DEFINE_GUID("bc0bf6ae-8878-11d1-83e9-00c04fc2c6d4")
  IID_IOplockStorage* = DEFINE_GUID("8d19c834-8879-11d1-83e9-00c04fc2c6d4")
  IID_IDirectWriterLock* = DEFINE_GUID("0e6d4d92-6738-11cf-9608-00aa00680db4")
  IID_IUrlMon* = DEFINE_GUID("00000026-0000-0000-c000-000000000046")
  IID_IForegroundTransfer* = DEFINE_GUID("00000145-0000-0000-c000-000000000046")
  IID_IThumbnailExtractor* = DEFINE_GUID("969dc708-5c76-11d1-8d86-0000f804b057")
  IID_IDummyHICONIncluder* = DEFINE_GUID("947990de-cc28-11d2-a0f7-00805f858fb1")
  serverApplication* = 0
  libraryApplication* = 1
  idleShutdown* = 0
  forcedShutdown* = 1
  IID_IProcessLock* = DEFINE_GUID("000001d5-0000-0000-c000-000000000046")
  IID_ISurrogateService* = DEFINE_GUID("000001d4-0000-0000-c000-000000000046")
  IID_IInitializeSpy* = DEFINE_GUID("00000034-0000-0000-c000-000000000046")
  IID_IApartmentShutdown* = DEFINE_GUID("a2f05a09-27a2-42b5-bc0e-ac163ef49d9b")
  SF_ERROR* = VT_ERROR
  SF_I1* = VT_I1
  SF_I2* = VT_I2
  SF_I4* = VT_I4
  SF_I8* = VT_I8
  SF_BSTR* = VT_BSTR
  SF_UNKNOWN* = VT_UNKNOWN
  SF_DISPATCH* = VT_DISPATCH
  SF_VARIANT* = VT_VARIANT
  SF_RECORD* = VT_RECORD
  SF_HAVEIID* = VT_UNKNOWN or VT_RESERVED
  FADF_AUTO* = 0x1
  FADF_STATIC* = 0x2
  FADF_EMBEDDED* = 0x4
  FADF_FIXEDSIZE* = 0x10
  FADF_RECORD* = 0x20
  FADF_HAVEIID* = 0x40
  FADF_HAVEVARTYPE* = 0x80
  FADF_BSTR* = 0x100
  FADF_UNKNOWN* = 0x200
  FADF_DISPATCH* = 0x400
  FADF_VARIANT* = 0x800
  FADF_RESERVED* = 0xf008
  FORCENAMELESSUNION* = 1
  TKIND_ENUM* = 0
  TKIND_RECORD* = 1
  TKIND_MODULE* = 2
  TKIND_INTERFACE* = 3
  TKIND_DISPATCH* = 4
  TKIND_COCLASS* = 5
  TKIND_ALIAS* = 6
  TKIND_UNION* = 7
  TKIND_MAX* = 8
  PARAMFLAG_NONE* = 0x0
  PARAMFLAG_FIN* = 0x1
  PARAMFLAG_FOUT* = 0x2
  PARAMFLAG_FLCID* = 0x4
  PARAMFLAG_FRETVAL* = 0x8
  PARAMFLAG_FOPT* = 0x10
  PARAMFLAG_FHASDEFAULT* = 0x20
  PARAMFLAG_FHASCUSTDATA* = 0x40
  IDLFLAG_NONE* = PARAMFLAG_NONE
  IDLFLAG_FIN* = PARAMFLAG_FIN
  IDLFLAG_FOUT* = PARAMFLAG_FOUT
  IDLFLAG_FLCID* = PARAMFLAG_FLCID
  IDLFLAG_FRETVAL* = PARAMFLAG_FRETVAL
  CC_FASTCALL* = 0
  CC_CDECL* = 1
  CC_MSCPASCAL* = 2
  CC_PASCAL* = CC_MSCPASCAL
  CC_MACPASCAL* = 3
  CC_STDCALL* = 4
  CC_FPFASTCALL* = 5
  CC_SYSCALL* = 6
  CC_MPWCDECL* = 7
  CC_MPWPASCAL* = 8
  CC_MAX* = 9
  FUNC_VIRTUAL* = 0
  FUNC_PUREVIRTUAL* = 1
  FUNC_NONVIRTUAL* = 2
  FUNC_STATIC* = 3
  FUNC_DISPATCH* = 4
  INVOKE_FUNC* = 1
  INVOKE_PROPERTYGET* = 2
  INVOKE_PROPERTYPUT* = 4
  INVOKE_PROPERTYPUTREF* = 8
  VAR_PERINSTANCE* = 0
  VAR_STATIC* = 1
  VAR_CONST* = 2
  VAR_DISPATCH* = 3
  IMPLTYPEFLAG_FDEFAULT* = 0x1
  IMPLTYPEFLAG_FSOURCE* = 0x2
  IMPLTYPEFLAG_FRESTRICTED* = 0x4
  IMPLTYPEFLAG_FDEFAULTVTABLE* = 0x8
  TYPEFLAG_FAPPOBJECT* = 0x1
  TYPEFLAG_FCANCREATE* = 0x2
  TYPEFLAG_FLICENSED* = 0x4
  TYPEFLAG_FPREDECLID* = 0x8
  TYPEFLAG_FHIDDEN* = 0x10
  TYPEFLAG_FCONTROL* = 0x20
  TYPEFLAG_FDUAL* = 0x40
  TYPEFLAG_FNONEXTENSIBLE* = 0x80
  TYPEFLAG_FOLEAUTOMATION* = 0x100
  TYPEFLAG_FRESTRICTED* = 0x200
  TYPEFLAG_FAGGREGATABLE* = 0x400
  TYPEFLAG_FREPLACEABLE* = 0x800
  TYPEFLAG_FDISPATCHABLE* = 0x1000
  TYPEFLAG_FREVERSEBIND* = 0x2000
  TYPEFLAG_FPROXY* = 0x4000
  FUNCFLAG_FRESTRICTED* = 0x1
  FUNCFLAG_FSOURCE* = 0x2
  FUNCFLAG_FBINDABLE* = 0x4
  FUNCFLAG_FREQUESTEDIT* = 0x8
  FUNCFLAG_FDISPLAYBIND* = 0x10
  FUNCFLAG_FDEFAULTBIND* = 0x20
  FUNCFLAG_FHIDDEN* = 0x40
  FUNCFLAG_FUSESGETLASTERROR* = 0x80
  FUNCFLAG_FDEFAULTCOLLELEM* = 0x100
  FUNCFLAG_FUIDEFAULT* = 0x200
  FUNCFLAG_FNONBROWSABLE* = 0x400
  FUNCFLAG_FREPLACEABLE* = 0x800
  FUNCFLAG_FIMMEDIATEBIND* = 0x1000
  VARFLAG_FREADONLY* = 0x1
  VARFLAG_FSOURCE* = 0x2
  VARFLAG_FBINDABLE* = 0x4
  VARFLAG_FREQUESTEDIT* = 0x8
  VARFLAG_FDISPLAYBIND* = 0x10
  VARFLAG_FDEFAULTBIND* = 0x20
  VARFLAG_FHIDDEN* = 0x40
  VARFLAG_FRESTRICTED* = 0x80
  VARFLAG_FDEFAULTCOLLELEM* = 0x100
  VARFLAG_FUIDEFAULT* = 0x200
  VARFLAG_FNONBROWSABLE* = 0x400
  VARFLAG_FREPLACEABLE* = 0x800
  VARFLAG_FIMMEDIATEBIND* = 0x1000
  IID_ICreateTypeInfo* = DEFINE_GUID("00020405-0000-0000-c000-000000000046")
  IID_ICreateTypeInfo2* = DEFINE_GUID("0002040e-0000-0000-c000-000000000046")
  IID_ICreateTypeLib* = DEFINE_GUID("00020406-0000-0000-c000-000000000046")
  IID_ICreateTypeLib2* = DEFINE_GUID("0002040f-0000-0000-c000-000000000046")
  DISPID_UNKNOWN* = -1
  DISPID_VALUE* = 0
  DISPID_PROPERTYPUT* = -3
  DISPID_NEWENUM* = -4
  DISPID_EVALUATE* = -5
  DISPID_CONSTRUCTOR* = -6
  DISPID_DESTRUCTOR* = -7
  DISPID_COLLECT* = -8
  IID_IDispatch* = DEFINE_GUID("00020400-0000-0000-c000-000000000046")
  IID_IEnumVARIANT* = DEFINE_GUID("00020404-0000-0000-c000-000000000046")
  DESCKIND_NONE* = 0
  DESCKIND_FUNCDESC* = 1
  DESCKIND_VARDESC* = 2
  DESCKIND_TYPECOMP* = 3
  DESCKIND_IMPLICITAPPOBJ* = 4
  DESCKIND_MAX* = 5
  IID_ITypeComp* = DEFINE_GUID("00020403-0000-0000-c000-000000000046")
  IID_ITypeInfo* = DEFINE_GUID("00020401-0000-0000-c000-000000000046")
  IID_ITypeInfo2* = DEFINE_GUID("00020412-0000-0000-c000-000000000046")
  SYS_WIN16* = 0
  SYS_WIN32* = 1
  SYS_MAC* = 2
  SYS_WIN64* = 3
  LIBFLAG_FRESTRICTED* = 0x1
  LIBFLAG_FCONTROL* = 0x2
  LIBFLAG_FHIDDEN* = 0x4
  LIBFLAG_FHASDISKIMAGE* = 0x8
  IID_ITypeLib* = DEFINE_GUID("00020402-0000-0000-c000-000000000046")
  IID_ITypeLib2* = DEFINE_GUID("00020411-0000-0000-c000-000000000046")
  CHANGEKIND_ADDMEMBER* = 0
  CHANGEKIND_DELETEMEMBER* = 1
  CHANGEKIND_SETNAMES* = 2
  CHANGEKIND_SETDOCUMENTATION* = 3
  CHANGEKIND_GENERAL* = 4
  CHANGEKIND_INVALIDATE* = 5
  CHANGEKIND_CHANGEFAILED* = 6
  CHANGEKIND_MAX* = 7
  IID_ITypeChangeEvents* = DEFINE_GUID("00020410-0000-0000-c000-000000000046")
  IID_IErrorInfo* = DEFINE_GUID("1cf2b120-547d-101b-8e65-08002b2bd119")
  IID_ICreateErrorInfo* = DEFINE_GUID("22f03340-547d-101b-8e65-08002b2bd119")
  IID_ISupportErrorInfo* = DEFINE_GUID("df0b3d60-548f-101b-8e65-08002b2bd119")
  IID_ITypeFactory* = DEFINE_GUID("0000002e-0000-0000-c000-000000000046")
  IID_ITypeMarshal* = DEFINE_GUID("0000002d-0000-0000-c000-000000000046")
  IID_IRecordInfo* = DEFINE_GUID("0000002f-0000-0000-c000-000000000046")
  IID_IErrorLog* = DEFINE_GUID("3127ca40-446e-11ce-8135-00aa004bb851")
  IID_IPropertyBag* = DEFINE_GUID("55272a00-42cb-11ce-8135-00aa004bb851")
  VARIANT_NOVALUEPROP* = 0x01
  VARIANT_ALPHABOOL* = 0x02
  VARIANT_NOUSEROVERRIDE* = 0x04
  VARIANT_CALENDAR_HIJRI* = 0x08
  VARIANT_LOCALBOOL* = 0x10
  VARIANT_CALENDAR_THAI* = 0x20
  VARIANT_CALENDAR_GREGORIAN* = 0x40
  VARIANT_USE_NLS* = 0x80
  VAR_TIMEVALUEONLY* = DWORD 0x00000001
  VAR_DATEVALUEONLY* = DWORD 0x00000002
  VAR_VALIDDATE* = DWORD 0x00000004
  VAR_CALENDAR_HIJRI* = DWORD 0x00000008
  VAR_LOCALBOOL* = DWORD 0x00000010
  VAR_FORMAT_NOSUBSTITUTE* = DWORD 0x00000020
  VAR_FOURDIGITYEARS* = DWORD 0x00000040
  LOCALE_USE_NLS* = 0x10000000
  VAR_CALENDAR_THAI* = DWORD 0x00000080
  VAR_CALENDAR_GREGORIAN* = DWORD 0x00000100
  VTDATEGRE_MAX* = 2958465
  VTDATEGRE_MIN* = -657434
  NUMPRS_LEADING_WHITE* = 0x0001
  NUMPRS_TRAILING_WHITE* = 0x0002
  NUMPRS_LEADING_PLUS* = 0x0004
  NUMPRS_TRAILING_PLUS* = 0x0008
  NUMPRS_LEADING_MINUS* = 0x0010
  NUMPRS_TRAILING_MINUS* = 0x0020
  NUMPRS_HEX_OCT* = 0x0040
  NUMPRS_PARENS* = 0x0080
  NUMPRS_DECIMAL* = 0x0100
  NUMPRS_THOUSANDS* = 0x0200
  NUMPRS_CURRENCY* = 0x0400
  NUMPRS_EXPONENT* = 0x0800
  NUMPRS_USE_ALL* = 0x1000
  NUMPRS_STD* = 0x1FFF
  NUMPRS_NEG* = 0x10000
  NUMPRS_INEXACT* = 0x20000
  VTBIT_I1* = 1 shl VT_I1
  VTBIT_UI1* = 1 shl VT_UI1
  VTBIT_I2* = 1 shl VT_I2
  VTBIT_UI2* = 1 shl VT_UI2
  VTBIT_I4* = 1 shl VT_I4
  VTBIT_UI4* = 1 shl VT_UI4
  VTBIT_I8* = 1 shl VT_I8
  VTBIT_UI8* = 1 shl VT_UI8
  VTBIT_R4* = 1 shl VT_R4
  VTBIT_R8* = 1 shl VT_R8
  VTBIT_CY* = 1 shl VT_CY
  VTBIT_DECIMAL* = 1 shl VT_DECIMAL
  VARCMP_LT* = 0
  VARCMP_EQ* = 1
  VARCMP_GT* = 2
  VARCMP_NULL* = 3
  VT_HARDTYPE* = VT_RESERVED
  MEMBERID_NIL* = DISPID_UNKNOWN
  ID_DEFAULTINST* = -2
  DISPATCH_METHOD* = 0x1
  DISPATCH_PROPERTYGET* = 0x2
  DISPATCH_PROPERTYPUT* = 0x4
  DISPATCH_PROPERTYPUTREF* = 0x8
  REGKIND_DEFAULT* = 0
  REGKIND_REGISTER* = 1
  REGKIND_NONE* = 2
  LOAD_TLB_AS_32BIT* = 0x20
  LOAD_TLB_AS_64BIT* = 0x40
  MASK_TO_RESET_TLB_BITS* = not (LOAD_TLB_AS_32BIT or LOAD_TLB_AS_64BIT)
  ACTIVEOBJECT_STRONG* = 0x0
  ACTIVEOBJECT_WEAK* = 0x1
  E_DRAW* = VIEW_E_DRAW
  DATA_E_FORMATETC* = DV_E_FORMATETC
  OLEIVERB_PRIMARY* = 0
  OLEIVERB_SHOW* = -1
  OLEIVERB_OPEN* = -2
  OLEIVERB_HIDE* = -3
  OLEIVERB_UIACTIVATE* = -4
  OLEIVERB_INPLACEACTIVATE* = -5
  OLEIVERB_DISCARDUNDOSTATE* = -6
  EMBDHLP_INPROC_HANDLER* = 0x0000
  EMBDHLP_INPROC_SERVER* = 0x0001
  EMBDHLP_CREATENOW* = 0x00000000
  EMBDHLP_DELAYCREATE* = 0x00010000
  OLECREATE_LEAVERUNNING* = 0x1
  IID_IOleAdviseHolder* = DEFINE_GUID("00000111-0000-0000-c000-000000000046")
  IID_IOleCache* = DEFINE_GUID("0000011e-0000-0000-c000-000000000046")
  UPDFCACHE_NODATACACHE* = 0x1
  UPDFCACHE_ONSAVECACHE* = 0x2
  UPDFCACHE_ONSTOPCACHE* = 0x4
  UPDFCACHE_NORMALCACHE* = 0x8
  UPDFCACHE_IFBLANK* = 0x10
  UPDFCACHE_ONLYIFBLANK* = 0x80000000'i32
  UPDFCACHE_IFBLANKORONSAVECACHE* = UPDFCACHE_IFBLANK or UPDFCACHE_ONSAVECACHE
  DISCARDCACHE_SAVEIFDIRTY* = 0
  DISCARDCACHE_NOSAVE* = 1
  IID_IOleCache2* = DEFINE_GUID("00000128-0000-0000-c000-000000000046")
  IID_IOleCacheControl* = DEFINE_GUID("00000129-0000-0000-c000-000000000046")
  IID_IParseDisplayName* = DEFINE_GUID("0000011a-0000-0000-c000-000000000046")
  IID_IOleContainer* = DEFINE_GUID("0000011b-0000-0000-c000-000000000046")
  IID_IOleClientSite* = DEFINE_GUID("00000118-0000-0000-c000-000000000046")
  OLEGETMONIKER_ONLYIFTHERE* = 1
  OLEGETMONIKER_FORCEASSIGN* = 2
  OLEGETMONIKER_UNASSIGN* = 3
  OLEGETMONIKER_TEMPFORUSER* = 4
  OLEWHICHMK_CONTAINER* = 1
  OLEWHICHMK_OBJREL* = 2
  OLEWHICHMK_OBJFULL* = 3
  USERCLASSTYPE_FULL* = 1
  USERCLASSTYPE_SHORT* = 2
  USERCLASSTYPE_APPNAME* = 3
  OLEMISC_RECOMPOSEONRESIZE* = 0x1
  OLEMISC_ONLYICONIC* = 0x2
  OLEMISC_INSERTNOTREPLACE* = 0x4
  OLEMISC_STATIC* = 0x8
  OLEMISC_CANTLINKINSIDE* = 0x10
  OLEMISC_CANLINKBYOLE1* = 0x20
  OLEMISC_ISLINKOBJECT* = 0x40
  OLEMISC_INSIDEOUT* = 0x80
  OLEMISC_ACTIVATEWHENVISIBLE* = 0x100
  OLEMISC_RENDERINGISDEVICEINDEPENDENT* = 0x200
  OLEMISC_INVISIBLEATRUNTIME* = 0x400
  OLEMISC_ALWAYSRUN* = 0x800
  OLEMISC_ACTSLIKEBUTTON* = 0x1000
  OLEMISC_ACTSLIKELABEL* = 0x2000
  OLEMISC_NOUIACTIVATE* = 0x4000
  OLEMISC_ALIGNABLE* = 0x8000
  OLEMISC_SIMPLEFRAME* = 0x10000
  OLEMISC_SETCLIENTSITEFIRST* = 0x20000
  OLEMISC_IMEMODE* = 0x40000
  OLEMISC_IGNOREACTIVATEWHENVISIBLE* = 0x80000
  OLEMISC_WANTSTOMENUMERGE* = 0x100000
  OLEMISC_SUPPORTSMULTILEVELUNDO* = 0x200000
  OLECLOSE_SAVEIFDIRTY* = 0
  OLECLOSE_NOSAVE* = 1
  OLECLOSE_PROMPTSAVE* = 2
  IID_IOleObject* = DEFINE_GUID("00000112-0000-0000-c000-000000000046")
  OLERENDER_NONE* = 0
  OLERENDER_DRAW* = 1
  OLERENDER_FORMAT* = 2
  OLERENDER_ASIS* = 3
  IID_IOleWindow* = DEFINE_GUID("00000114-0000-0000-c000-000000000046")
  OLEUPDATE_ALWAYS* = 1
  OLEUPDATE_ONCALL* = 3
  OLELINKBIND_EVENIFCLASSDIFF* = 1
  IID_IOleLink* = DEFINE_GUID("0000011d-0000-0000-c000-000000000046")
  BINDSPEED_INDEFINITE* = 1
  BINDSPEED_MODERATE* = 2
  BINDSPEED_IMMEDIATE* = 3
  OLECONTF_EMBEDDINGS* = 1
  OLECONTF_LINKS* = 2
  OLECONTF_OTHERS* = 4
  OLECONTF_ONLYUSER* = 8
  OLECONTF_ONLYIFRUNNING* = 16
  IID_IOleItemContainer* = DEFINE_GUID("0000011c-0000-0000-c000-000000000046")
  IID_IOleInPlaceUIWindow* = DEFINE_GUID("00000115-0000-0000-c000-000000000046")
  IID_IOleInPlaceActiveObject* = DEFINE_GUID("00000117-0000-0000-c000-000000000046")
  IID_IOleInPlaceFrame* = DEFINE_GUID("00000116-0000-0000-c000-000000000046")
  IID_IOleInPlaceObject* = DEFINE_GUID("00000113-0000-0000-c000-000000000046")
  IID_IOleInPlaceSite* = DEFINE_GUID("00000119-0000-0000-c000-000000000046")
  IID_IContinue* = DEFINE_GUID("0000012a-0000-0000-c000-000000000046")
  IID_IViewObject* = DEFINE_GUID("0000010d-0000-0000-c000-000000000046")
  IID_IViewObject2* = DEFINE_GUID("00000127-0000-0000-c000-000000000046")
  IID_IDropSource* = DEFINE_GUID("00000121-0000-0000-c000-000000000046")
  MK_ALT* = 0x20
  DROPEFFECT_NONE* = 0
  DROPEFFECT_COPY* = 1
  DROPEFFECT_MOVE* = 2
  DROPEFFECT_LINK* = 4
  DROPEFFECT_SCROLL* = 0x80000000'i32
  DD_DEFSCROLLINSET* = 11
  DD_DEFSCROLLDELAY* = 50
  DD_DEFSCROLLINTERVAL* = 50
  DD_DEFDRAGDELAY* = 200
  DD_DEFDRAGMINDIST* = 2
  IID_IDropTarget* = DEFINE_GUID("00000122-0000-0000-c000-000000000046")
  IID_IDropSourceNotify* = DEFINE_GUID("0000012b-0000-0000-c000-000000000046")
  OLEVERBATTRIB_NEVERDIRTIES* = 1
  OLEVERBATTRIB_ONCONTAINERMENU* = 2
  IID_IEnumOLEVERB* = DEFINE_GUID("00000104-0000-0000-c000-000000000046")
  MEMCTX_TASK* = 1
  MEMCTX_SHARED* = 2
  MEMCTX_MACSYSTEM* = 3
  MEMCTX_UNKNOWN* = -1
  MEMCTX_SAME* = -2
  ROTREGFLAGS_ALLOWANYCLIENT* = 0x1
  APPIDREGFLAGS_ACTIVATE_IUSERVER_INDESKTOP* = 0x1
  APPIDREGFLAGS_SECURE_SERVER_PROCESS_SD_AND_BIND* = 0x2
  APPIDREGFLAGS_ISSUE_ACTIVATION_RPC_AT_IDENTIFY* = 0x4
  APPIDREGFLAGS_IUSERVER_UNMODIFIED_LOGON_TOKEN* = 0x8
  APPIDREGFLAGS_IUSERVER_SELF_SID_IN_LAUNCH_PERMISSION* = 0x10
  APPIDREGFLAGS_IUSERVER_ACTIVATE_IN_CLIENT_SESSION_ONLY* = 0x20
  APPIDREGFLAGS_RESERVED1* = 0x40
  DCOMSCM_ACTIVATION_USE_ALL_AUTHNSERVICES* = 0x1
  DCOMSCM_ACTIVATION_DISALLOW_UNSECURE_CALL* = 0x2
  DCOMSCM_RESOLVE_USE_ALL_AUTHNSERVICES* = 0x4
  DCOMSCM_RESOLVE_DISALLOW_UNSECURE_CALL* = 0x8
  DCOMSCM_PING_USE_MID_AUTHNSERVICE* = 0x10
  DCOMSCM_PING_DISALLOW_UNSECURE_CALL* = 0x20
  CLSCTX_INPROC_SERVER16* = 0x8
  CLSCTX_INPROC_HANDLER16* = 0x20
  CLSCTX_RESERVED1* = 0x40
  CLSCTX_RESERVED2* = 0x80
  CLSCTX_RESERVED3* = 0x100
  CLSCTX_RESERVED4* = 0x200
  CLSCTX_NO_CODE_DOWNLOAD* = 0x400
  CLSCTX_RESERVED5* = 0x800
  CLSCTX_NO_CUSTOM_MARSHAL* = 0x1000
  CLSCTX_ENABLE_CODE_DOWNLOAD* = 0x2000
  CLSCTX_NO_FAILURE_LOG* = 0x4000
  CLSCTX_DISABLE_AAA* = 0x8000
  CLSCTX_ENABLE_AAA* = 0x10000
  CLSCTX_FROM_DEFAULT_CONTEXT* = 0x20000
  CLSCTX_ACTIVATE_32_BIT_SERVER* = 0x40000
  CLSCTX_ACTIVATE_64_BIT_SERVER* = 0x80000
  CLSCTX_ENABLE_CLOAKING* = 0x100000
  CLSCTX_APPCONTAINER* = 0x400000
  CLSCTX_ACTIVATE_AAA_AS_IU* = 0x800000
  CLSCTX_PS_DLL* = int32 0x80000000'i32
  CLSCTX_VALID_MASK* = CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER or CLSCTX_LOCAL_SERVER or CLSCTX_INPROC_SERVER16 or CLSCTX_REMOTE_SERVER or CLSCTX_NO_CODE_DOWNLOAD or CLSCTX_NO_CUSTOM_MARSHAL or CLSCTX_ENABLE_CODE_DOWNLOAD or CLSCTX_NO_FAILURE_LOG or CLSCTX_DISABLE_AAA or CLSCTX_ENABLE_AAA or CLSCTX_FROM_DEFAULT_CONTEXT or CLSCTX_ACTIVATE_32_BIT_SERVER or CLSCTX_ACTIVATE_64_BIT_SERVER or CLSCTX_ENABLE_CLOAKING or CLSCTX_APPCONTAINER or CLSCTX_ACTIVATE_AAA_AS_IU or CLSCTX_PS_DLL
  MSHLFLAGS_NORMAL* = 0
  MSHLFLAGS_TABLESTRONG* = 1
  MSHLFLAGS_TABLEWEAK* = 2
  MSHLFLAGS_NOPING* = 4
  MSHLFLAGS_RESERVED1* = 8
  MSHLFLAGS_RESERVED2* = 16
  MSHLFLAGS_RESERVED3* = 32
  MSHLFLAGS_RESERVED4* = 64
  MSHCTX_LOCAL* = 0
  MSHCTX_NOSHAREDMEM* = 1
  MSHCTX_DIFFERENTMACHINE* = 2
  MSHCTX_INPROC* = 3
  MSHCTX_CROSSCTX* = 4
  SMEXF_SERVER* = 0x01
  SMEXF_HANDLER* = 0x02
  COM_RIGHTS_EXECUTE* = 1
  COM_RIGHTS_EXECUTE_LOCAL* = 2
  COM_RIGHTS_EXECUTE_REMOTE* = 4
  COM_RIGHTS_ACTIVATE_LOCAL* = 8
  COM_RIGHTS_ACTIVATE_REMOTE* = 16
  COWAIT_DEFAULT* = 0
  COWAIT_WAITALL* = 1
  COWAIT_ALERTABLE* = 2
  COWAIT_INPUTAVAILABLE* = 4
  COWAIT_DISPATCH_CALLS* = 8
  COWAIT_DISPATCH_WINDOW_MESSAGES* = 0x10
  CWMO_DEFAULT* = 0
  CWMO_DISPATCH_CALLS* = 1
  CWMO_DISPATCH_WINDOW_MESSAGES* = 2
  CWMO_MAX_HANDLES* = 56
  COINIT_APARTMENTTHREADED* = 0x2
  COINIT_MULTITHREADED* = COINITBASE_MULTITHREADED
  COINIT_DISABLE_OLE1DDE* = 0x4
  COINIT_SPEED_OVER_MEMORY* = 0x8
  MARSHALINTERFACE_MIN* = 500
  CWCSTORAGENAME* = 32
  STGM_DIRECT* = 0x00000000
  STGM_TRANSACTED* = 0x00010000
  STGM_SIMPLE* = 0x08000000
  STGM_READ* = 0x00000000
  STGM_WRITE* = 0x00000001
  STGM_READWRITE* = 0x00000002
  STGM_SHARE_DENY_NONE* = 0x00000040
  STGM_SHARE_DENY_READ* = 0x00000030
  STGM_SHARE_DENY_WRITE* = 0x00000020
  STGM_SHARE_EXCLUSIVE* = 0x00000010
  STGM_PRIORITY* = 0x00040000
  STGM_DELETEONRELEASE* = 0x04000000
  STGM_NOSCRATCH* = 0x00100000
  STGM_CREATE* = 0x00001000
  STGM_CONVERT* = 0x00020000
  STGM_FAILIFTHERE* = 0x00000000
  STGM_NOSNAPSHOT* = 0x00200000
  STGM_DIRECT_SWMR* = 0x00400000
  ASYNC_MODE_COMPATIBILITY* = 0x00000001
  ASYNC_MODE_DEFAULT* = 0x00000000
  STGTY_REPEAT* = 0x00000100
  STG_TOEND* = 0xffffffff'i32
  STG_LAYOUT_SEQUENTIAL* = 0x00000000
  STG_LAYOUT_INTERLEAVED* = 0x00000001
  STGFMT_STORAGE* = 0
  STGFMT_NATIVE* = 1
  STGFMT_FILE* = 3
  STGFMT_ANY* = 4
  STGFMT_DOCFILE* = 5
  STGFMT_DOCUMENT* = 0
  SD_LAUNCHPERMISSIONS* = 0
  SD_ACCESSPERMISSIONS* = 1
  SD_LAUNCHRESTRICTIONS* = 2
  SD_ACCESSRESTRICTIONS* = 3
  STGOPTIONS_VERSION* = 2
  IID_IServiceProvider* = DEFINE_GUID("6d5140c1-7436-11ce-8034-00aa006009fa")
  NODE_INVALID* = 0
  NODE_ELEMENT* = 1
  NODE_ATTRIBUTE* = 2
  NODE_TEXT* = 3
  NODE_CDATA_SECTION* = 4
  NODE_ENTITY_REFERENCE* = 5
  NODE_ENTITY* = 6
  NODE_PROCESSING_INSTRUCTION* = 7
  NODE_COMMENT* = 8
  NODE_DOCUMENT* = 9
  NODE_DOCUMENT_TYPE* = 10
  NODE_DOCUMENT_FRAGMENT* = 11
  NODE_NOTATION* = 12
  XMLELEMTYPE_ELEMENT* = 0
  XMLELEMTYPE_TEXT* = 1
  XMLELEMTYPE_COMMENT* = 2
  XMLELEMTYPE_DOCUMENT* = 3
  XMLELEMTYPE_DTD* = 4
  XMLELEMTYPE_PI* = 5
  XMLELEMTYPE_OTHER* = 6
  BINDF_GETNEWESTVERSION* = 0x10
  BINDF_DONTUSECACHE* = BINDF_GETNEWESTVERSION
  BINDF_NOWRITECACHE* = 0x20
  BINDF_DONTPUTINCACHE* = BINDF_NOWRITECACHE
  BINDF_PULLDATA* = 0x80
  BINDF_NOCOPYDATA* = BINDF_PULLDATA
  PI_CLSIDLOOKUP* = 0x20
  PI_DOCFILECLSIDLOOKUP* = PI_CLSIDLOOKUP
  MKSYS_URLMONIKER* = 6
  URL_MK_LEGACY* = 0
  URL_MK_UNIFORM* = 1
  URL_MK_NO_CANONICALIZE* = 2
  FIEF_FLAG_FORCE_JITUI* = 0x1
  FIEF_FLAG_PEEK* = 0x2
  FIEF_FLAG_SKIP_INSTALLED_VERSION_CHECK* = 0x4
  FMFD_DEFAULT* = 0x0
  FMFD_URLASFILENAME* = 0x1
  FMFD_ENABLEMIMESNIFFING* = 0x2
  FMFD_IGNOREMIMETEXTPLAIN* = 0x4
  FMFD_SERVERMIME* = 0x8
  FMFD_RESPECTTEXTPLAIN* = 0x10
  FMFD_RETURNUPDATEDIMGMIMES* = 0x20
  UAS_EXACTLEGACY* = 0x1000
  URLMON_OPTION_USERAGENT* = 0x10000001
  URLMON_OPTION_USERAGENT_REFRESH* = 0x10000002
  URLMON_OPTION_URL_ENCODING* = 0x10000004
  URLMON_OPTION_USE_BINDSTRINGCREDS* = 0x10000008
  URLMON_OPTION_USE_BROWSERAPPSDOCUMENTS* = 0x10000010
  CF_NULL* = 0
  CFSTR_MIME_NULL* = NULL
  CFSTR_MIME_TEXT* = "text/plain"
  CFSTR_MIME_RICHTEXT* = "text/richtext"
  CFSTR_MIME_MANIFEST* = "text/cache-manifest"
  CFSTR_MIME_WEBVTT* = "text/vtt"
  CFSTR_MIME_X_BITMAP* = "image/x-xbitmap"
  CFSTR_MIME_POSTSCRIPT* = "application/postscript"
  CFSTR_MIME_AIFF* = "audio/aiff"
  CFSTR_MIME_BASICAUDIO* = "audio/basic"
  CFSTR_MIME_WAV* = "audio/wav"
  CFSTR_MIME_X_WAV* = "audio/x-wav"
  CFSTR_MIME_GIF* = "image/gif"
  CFSTR_MIME_PJPEG* = "image/pjpeg"
  CFSTR_MIME_JPEG* = "image/jpeg"
  CFSTR_MIME_TIFF* = "image/tiff"
  CFSTR_MIME_JPEG_XR* = "image/vnd.ms-photo"
  CFSTR_MIME_PNG* = "image/png"
  CFSTR_MIME_X_PNG* = "image/x-png"
  CFSTR_MIME_X_ICON* = "image/x-icon"
  CFSTR_MIME_SVG_XML* = "image/svg+xml"
  CFSTR_MIME_BMP* = "image/bmp"
  CFSTR_MIME_X_EMF* = "image/x-emf"
  CFSTR_MIME_X_WMF* = "image/x-wmf"
  CFSTR_MIME_AVI* = "video/avi"
  CFSTR_MIME_MPEG* = "video/mpeg"
  CFSTR_MIME_FRACTALS* = "application/fractals"
  CFSTR_MIME_RAWDATA* = "application/octet-stream"
  CFSTR_MIME_RAWDATASTRM* = "application/octet-stream"
  CFSTR_MIME_PDF* = "application/pdf"
  CFSTR_MIME_HTA* = "application/hta"
  CFSTR_MIME_APP_XML* = "application/xml"
  CFSTR_MIME_XHTML* = "application/xhtml+xml"
  CFSTR_MIME_X_AIFF* = "audio/x-aiff"
  CFSTR_MIME_X_REALAUDIO* = "audio/x-pn-realaudio"
  CFSTR_MIME_XBM* = "image/xbm"
  CFSTR_MIME_QUICKTIME* = "video/quicktime"
  CFSTR_MIME_X_MSVIDEO* = "video/x-msvideo"
  CFSTR_MIME_X_SGI_MOVIE* = "video/x-sgi-movie"
  CFSTR_MIME_HTML* = "text/html"
  CFSTR_MIME_XML* = "text/xml"
  CFSTR_MIME_TTML* = "application/ttml+xml"
  CFSTR_MIME_TTAF* = "application/ttaf+xml"
  MK_S_ASYNCHRONOUS* = HRESULT 0x401E8
  S_ASYNCHRONOUS* = MK_S_ASYNCHRONOUS
  INET_E_INVALID_URL* = HRESULT 0x800C0002'i32
  INET_E_NO_SESSION* = HRESULT 0x800C0003'i32
  INET_E_CANNOT_CONNECT* = HRESULT 0x800C0004'i32
  INET_E_RESOURCE_NOT_FOUND* = HRESULT 0x800C0005'i32
  INET_E_OBJECT_NOT_FOUND* = HRESULT 0x800C0006'i32
  INET_E_DATA_NOT_AVAILABLE* = HRESULT 0x800C0007'i32
  INET_E_DOWNLOAD_FAILURE* = HRESULT 0x800C0008'i32
  INET_E_AUTHENTICATION_REQUIRED* = HRESULT 0x800C0009'i32
  INET_E_NO_VALID_MEDIA* = HRESULT 0x800C000A'i32
  INET_E_CONNECTION_TIMEOUT* = HRESULT 0x800C000B'i32
  INET_E_INVALID_REQUEST* = HRESULT 0x800C000C'i32
  INET_E_UNKNOWN_PROTOCOL* = HRESULT 0x800C000D'i32
  INET_E_SECURITY_PROBLEM* = HRESULT 0x800C000E'i32
  INET_E_CANNOT_LOAD_DATA* = HRESULT 0x800C000F'i32
  INET_E_CANNOT_INSTANTIATE_OBJECT* = HRESULT 0x800C0010'i32
  INET_E_INVALID_CERTIFICATE* = HRESULT 0x800C0019'i32
  INET_E_REDIRECT_FAILED* = HRESULT 0x800C0014'i32
  INET_E_REDIRECT_TO_DIR* = HRESULT 0x800C0015'i32
  INET_E_CANNOT_LOCK_REQUEST* = HRESULT 0x800C0016'i32
  INET_E_USE_EXTEND_BINDING* = HRESULT 0x800C0017'i32
  INET_E_TERMINATED_BIND* = HRESULT 0x800C0018'i32
  INET_E_RESERVED_1* = HRESULT 0x800C001A'i32
  INET_E_BLOCKED_REDIRECT_XSECURITYID* = HRESULT 0x800C001B'i32
  INET_E_DOMINJECTIONVALIDATION* = HRESULT 0x800C001C'i32
  INET_E_ERROR_FIRST* = HRESULT 0x800C0002'i32
  INET_E_CODE_DOWNLOAD_DECLINED* = HRESULT 0x800C0100'i32
  INET_E_RESULT_DISPATCHED* = HRESULT 0x800C0200'i32
  INET_E_CANNOT_REPLACE_SFP_FILE* = HRESULT 0x800C0300'i32
  INET_E_CODE_INSTALL_SUPPRESSED* = HRESULT 0x800C0400'i32
  INET_E_CODE_INSTALL_BLOCKED_BY_HASH_POLICY* = HRESULT 0x800C0500'i32
  INET_E_DOWNLOAD_BLOCKED_BY_INPRIVATE* = HRESULT 0x800C0501'i32
  INET_E_CODE_INSTALL_BLOCKED_IMMERSIVE* = HRESULT 0x800C0502'i32
  INET_E_FORBIDFRAMING* = HRESULT 0x800C0503'i32
  INET_E_CODE_INSTALL_BLOCKED_ARM* = HRESULT 0x800C0504'i32
  INET_E_BLOCKED_PLUGGABLE_PROTOCOL* = HRESULT 0x800C0505'i32
  INET_E_ERROR_LAST* = INET_E_BLOCKED_PLUGGABLE_PROTOCOL
  IID_IPersistMoniker* = DEFINE_GUID("79eac9c9-baf9-11ce-8c82-00aa004ba90b")
  MIMETYPEPROP* = 0x0
  USE_SRC_URL* = 0x1
  CLASSIDPROP* = 0x2
  TRUSTEDDOWNLOADPROP* = 0x3
  POPUPLEVELPROP* = 0x4
  IID_IMonikerProp* = DEFINE_GUID("a5ca5f7f-1847-4d87-9c5b-918509f7511d")
  IID_IBindProtocol* = DEFINE_GUID("79eac9cd-baf9-11ce-8c82-00aa004ba90b")
  IID_IBinding* = DEFINE_GUID("79eac9c0-baf9-11ce-8c82-00aa004ba90b")
  BINDVERB_GET* = 0x0
  BINDVERB_POST* = 0x1
  BINDVERB_PUT* = 0x2
  BINDVERB_CUSTOM* = 0x3
  BINDVERB_RESERVED1* = 0x4
  BINDINFOF_URLENCODESTGMEDDATA* = 0x1
  BINDINFOF_URLENCODEDEXTRAINFO* = 0x2
  BINDF_ASYNCHRONOUS* = 0x1
  BINDF_ASYNCSTORAGE* = 0x2
  BINDF_NOPROGRESSIVERENDERING* = 0x4
  BINDF_OFFLINEOPERATION* = 0x8
  BINDF_NEEDFILE* = 0x40
  BINDF_IGNORESECURITYPROBLEM* = 0x100
  BINDF_RESYNCHRONIZE* = 0x200
  BINDF_HYPERLINK* = 0x400
  BINDF_NO_UI* = 0x800
  BINDF_SILENTOPERATION* = 0x1000
  BINDF_PRAGMA_NO_CACHE* = 0x2000
  BINDF_GETCLASSOBJECT* = 0x4000
  BINDF_RESERVED_1* = 0x8000
  BINDF_FREE_THREADED* = 0x10000
  BINDF_DIRECT_READ* = 0x20000
  BINDF_FORMS_SUBMIT* = 0x40000
  BINDF_GETFROMCACHE_IF_NET_FAIL* = 0x80000
  BINDF_FROMURLMON* = 0x100000
  BINDF_FWD_BACK* = 0x200000
  BINDF_PREFERDEFAULTHANDLER* = 0x400000
  BINDF_ENFORCERESTRICTED* = 0x800000
  BINDF_RESERVED_2* = 0x80000000'i32
  BINDF_RESERVED_3* = 0x1000000
  BINDF_RESERVED_4* = 0x2000000
  BINDF_RESERVED_5* = 0x4000000
  BINDF_RESERVED_6* = 0x8000000
  BINDF_RESERVED_7* = 0x40000000
  BINDF_RESERVED_8* = 0x20000000
  URL_ENCODING_NONE* = 0x0
  URL_ENCODING_ENABLE_UTF8* = 0x10000000
  URL_ENCODING_DISABLE_UTF8* = 0x20000000
  BINDINFO_OPTIONS_WININETFLAG* = 0x10000
  BINDINFO_OPTIONS_ENABLE_UTF8* = 0x20000
  BINDINFO_OPTIONS_DISABLE_UTF8* = 0x40000
  BINDINFO_OPTIONS_USE_IE_ENCODING* = 0x80000
  BINDINFO_OPTIONS_BINDTOOBJECT* = 0x100000
  BINDINFO_OPTIONS_SECURITYOPTOUT* = 0x200000
  BINDINFO_OPTIONS_IGNOREMIMETEXTPLAIN* = 0x400000
  BINDINFO_OPTIONS_USEBINDSTRINGCREDS* = 0x800000
  BINDINFO_OPTIONS_IGNOREHTTPHTTPSREDIRECTS* = 0x1000000
  BINDINFO_OPTIONS_IGNORE_SSLERRORS_ONCE* = 0x2000000
  BINDINFO_WPC_DOWNLOADBLOCKED* = 0x8000000
  BINDINFO_WPC_LOGGING_ENABLED* = 0x10000000
  BINDINFO_OPTIONS_ALLOWCONNECTDATA* = 0x20000000
  BINDINFO_OPTIONS_DISABLEAUTOREDIRECTS* = 0x40000000
  BINDINFO_OPTIONS_SHDOCVW_NAVIGATE* = int32 0x80000000'i32
  BSCF_FIRSTDATANOTIFICATION* = 0x1
  BSCF_INTERMEDIATEDATANOTIFICATION* = 0x2
  BSCF_LASTDATANOTIFICATION* = 0x4
  BSCF_DATAFULLYAVAILABLE* = 0x8
  BSCF_AVAILABLEDATASIZEUNKNOWN* = 0x10
  BSCF_SKIPDRAINDATAFORFILEURLS* = 0x20
  BSCF_64BITLENGTHDOWNLOAD* = 0x40
  BINDSTATUS_FINDINGRESOURCE* = 1
  BINDSTATUS_CONNECTING* = 2
  BINDSTATUS_REDIRECTING* = 3
  BINDSTATUS_BEGINDOWNLOADDATA* = 4
  BINDSTATUS_DOWNLOADINGDATA* = 5
  BINDSTATUS_ENDDOWNLOADDATA* = 6
  BINDSTATUS_BEGINDOWNLOADCOMPONENTS* = 7
  BINDSTATUS_INSTALLINGCOMPONENTS* = 8
  BINDSTATUS_ENDDOWNLOADCOMPONENTS* = 9
  BINDSTATUS_USINGCACHEDCOPY* = 10
  BINDSTATUS_SENDINGREQUEST* = 11
  BINDSTATUS_CLASSIDAVAILABLE* = 12
  BINDSTATUS_MIMETYPEAVAILABLE* = 13
  BINDSTATUS_CACHEFILENAMEAVAILABLE* = 14
  BINDSTATUS_BEGINSYNCOPERATION* = 15
  BINDSTATUS_ENDSYNCOPERATION* = 16
  BINDSTATUS_BEGINUPLOADDATA* = 17
  BINDSTATUS_UPLOADINGDATA* = 18
  BINDSTATUS_ENDUPLOADDATA* = 19
  BINDSTATUS_PROTOCOLCLASSID* = 20
  BINDSTATUS_ENCODING* = 21
  BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE* = 22
  BINDSTATUS_CLASSINSTALLLOCATION* = 23
  BINDSTATUS_DECODING* = 24
  BINDSTATUS_LOADINGMIMEHANDLER* = 25
  BINDSTATUS_CONTENTDISPOSITIONATTACH* = 26
  BINDSTATUS_FILTERREPORTMIMETYPE* = 27
  BINDSTATUS_CLSIDCANINSTANTIATE* = 28
  BINDSTATUS_IUNKNOWNAVAILABLE* = 29
  BINDSTATUS_DIRECTBIND* = 30
  BINDSTATUS_RAWMIMETYPE* = 31
  BINDSTATUS_PROXYDETECTING* = 32
  BINDSTATUS_ACCEPTRANGES* = 33
  BINDSTATUS_COOKIE_SENT* = 34
  BINDSTATUS_COMPACT_POLICY_RECEIVED* = 35
  BINDSTATUS_COOKIE_SUPPRESSED* = 36
  BINDSTATUS_COOKIE_STATE_UNKNOWN* = 37
  BINDSTATUS_COOKIE_STATE_ACCEPT* = 38
  BINDSTATUS_COOKIE_STATE_REJECT* = 39
  BINDSTATUS_COOKIE_STATE_PROMPT* = 40
  BINDSTATUS_COOKIE_STATE_LEASH* = 41
  BINDSTATUS_COOKIE_STATE_DOWNGRADE* = 42
  BINDSTATUS_POLICY_HREF* = 43
  BINDSTATUS_P3P_HEADER* = 44
  BINDSTATUS_SESSION_COOKIE_RECEIVED* = 45
  BINDSTATUS_PERSISTENT_COOKIE_RECEIVED* = 46
  BINDSTATUS_SESSION_COOKIES_ALLOWED* = 47
  BINDSTATUS_CACHECONTROL* = 48
  BINDSTATUS_CONTENTDISPOSITIONFILENAME* = 49
  BINDSTATUS_MIMETEXTPLAINMISMATCH* = 50
  BINDSTATUS_PUBLISHERAVAILABLE* = 51
  BINDSTATUS_DISPLAYNAMEAVAILABLE* = 52
  BINDSTATUS_SSLUX_NAVBLOCKED* = 53
  BINDSTATUS_SERVER_MIMETYPEAVAILABLE* = 54
  BINDSTATUS_SNIFFED_CLASSIDAVAILABLE* = 55
  BINDSTATUS_64BIT_PROGRESS* = 56
  BINDSTATUS_LAST* = BINDSTATUS_64BIT_PROGRESS
  BINDSTATUS_RESERVED_0* = 57
  BINDSTATUS_RESERVED_1* = 58
  BINDSTATUS_RESERVED_2* = 59
  BINDSTATUS_RESERVED_3* = 60
  BINDSTATUS_RESERVED_4* = 61
  BINDSTATUS_RESERVED_5* = 62
  BINDSTATUS_RESERVED_6* = 63
  BINDSTATUS_RESERVED_7* = 64
  BINDSTATUS_RESERVED_8* = 65
  BINDSTATUS_RESERVED_9* = 66
  BINDSTATUS_LAST_PRIVATE* = BINDSTATUS_RESERVED_9
  IID_IBindStatusCallback* = DEFINE_GUID("79eac9c1-baf9-11ce-8c82-00aa004ba90b")
  BINDF2_DISABLEBASICOVERHTTP* = 0x1
  BINDF2_DISABLEAUTOCOOKIEHANDLING* = 0x2
  BINDF2_READ_DATA_GREATER_THAN_4GB* = 0x4
  BINDF2_DISABLE_HTTP_REDIRECT_XSECURITYID* = 0x8
  BINDF2_SETDOWNLOADMODE* = 0x20
  BINDF2_DISABLE_HTTP_REDIRECT_CACHING* = 0x40
  BINDF2_KEEP_CALLBACK_MODULE_LOADED* = 0x80
  BINDF2_ALLOW_PROXY_CRED_PROMPT* = 0x100
  BINDF2_RESERVED_F* = 0x20000
  BINDF2_RESERVED_E* = 0x40000
  BINDF2_RESERVED_D* = 0x80000
  BINDF2_RESERVED_C* = 0x100000
  BINDF2_RESERVED_B* = 0x200000
  BINDF2_RESERVED_A* = 0x400000
  BINDF2_RESERVED_9* = 0x800000
  BINDF2_RESERVED_8* = 0x1000000
  BINDF2_RESERVED_7* = 0x2000000
  BINDF2_RESERVED_6* = 0x4000000
  BINDF2_RESERVED_5* = 0x8000000
  BINDF2_RESERVED_4* = 0x10000000
  BINDF2_RESERVED_3* = 0x20000000
  BINDF2_RESERVED_2* = 0x40000000
  BINDF2_RESERVED_1* = 0x80000000'i32
  IID_IBindStatusCallbackEx* = DEFINE_GUID("aaa74ef9-8ee7-4659-88d9-f8c504da73cc")
  IID_IAuthenticate* = DEFINE_GUID("79eac9d0-baf9-11ce-8c82-00aa004ba90b")
  AUTHENTICATEF_PROXY* = 0x1
  AUTHENTICATEF_BASIC* = 0x2
  AUTHENTICATEF_HTTP* = 0x4
  IID_IAuthenticateEx* = DEFINE_GUID("2ad1edaf-d83d-48b5-9adf-03dbe19f53bd")
  IID_IHttpNegotiate* = DEFINE_GUID("79eac9d2-baf9-11ce-8c82-00aa004ba90b")
  IID_IHttpNegotiate2* = DEFINE_GUID("4f9f9fcb-e0f4-48eb-b7ab-fa2ea9365cb4")
  IID_IHttpNegotiate3* = DEFINE_GUID("57b6c80a-34c2-4602-bc26-66a02fc57153")
  IID_IWinInetFileStream* = DEFINE_GUID("f134c4b7-b1f8-4e75-b886-74b90943becb")
  IID_IWindowForBindingUI* = DEFINE_GUID("79eac9d5-bafa-11ce-8c82-00aa004ba90b")
  CIP_DISK_FULL* = 0
  CIP_ACCESS_DENIED* = 1
  CIP_NEWER_VERSION_EXISTS* = 2
  CIP_OLDER_VERSION_EXISTS* = 3
  CIP_NAME_CONFLICT* = 4
  CIP_TRUST_VERIFICATION_COMPONENT_MISSING* = 5
  CIP_EXE_SELF_REGISTERATION_TIMEOUT* = 6
  CIP_UNSAFE_TO_ABORT* = 7
  CIP_NEED_REBOOT* = 8
  CIP_NEED_REBOOT_UI_PERMISSION* = 9
  IID_ICodeInstall* = DEFINE_GUID("79eac9d1-baf9-11ce-8c82-00aa004ba90b")
  Uri_PROPERTY_ABSOLUTE_URI* = 0
  Uri_PROPERTY_STRING_START* = Uri_PROPERTY_ABSOLUTE_URI
  Uri_PROPERTY_AUTHORITY* = 1
  Uri_PROPERTY_DISPLAY_URI* = 2
  Uri_PROPERTY_DOMAIN* = 3
  Uri_PROPERTY_EXTENSION* = 4
  Uri_PROPERTY_FRAGMENT* = 5
  Uri_PROPERTY_HOST* = 6
  Uri_PROPERTY_PASSWORD* = 7
  Uri_PROPERTY_PATH* = 8
  Uri_PROPERTY_PATH_AND_QUERY* = 9
  Uri_PROPERTY_QUERY* = 10
  Uri_PROPERTY_RAW_URI* = 11
  Uri_PROPERTY_SCHEME_NAME* = 12
  Uri_PROPERTY_USER_INFO* = 13
  Uri_PROPERTY_USER_NAME* = 14
  Uri_PROPERTY_STRING_LAST* = Uri_PROPERTY_USER_NAME
  Uri_PROPERTY_HOST_TYPE* = 15
  Uri_PROPERTY_DWORD_START* = Uri_PROPERTY_HOST_TYPE
  Uri_PROPERTY_PORT* = 16
  Uri_PROPERTY_SCHEME* = 17
  Uri_PROPERTY_ZONE* = 18
  Uri_PROPERTY_DWORD_LAST* = Uri_PROPERTY_ZONE
  Uri_HOST_UNKNOWN* = 0
  Uri_HOST_DNS* = 1
  Uri_HOST_IPV4* = 2
  Uri_HOST_IPV6* = 3
  Uri_HOST_IDN* = 4
  IID_IUri* = DEFINE_GUID("a39ee748-6a27-4817-a6f2-13914bef5890")
  Uri_HAS_ABSOLUTE_URI* = 1 shl Uri_PROPERTY_ABSOLUTE_URI
  Uri_HAS_AUTHORITY* = 1 shl Uri_PROPERTY_AUTHORITY
  Uri_HAS_DISPLAY_URI* = 1 shl Uri_PROPERTY_DISPLAY_URI
  Uri_HAS_DOMAIN* = 1 shl Uri_PROPERTY_DOMAIN
  Uri_HAS_EXTENSION* = 1 shl Uri_PROPERTY_EXTENSION
  Uri_HAS_FRAGMENT* = 1 shl Uri_PROPERTY_FRAGMENT
  Uri_HAS_HOST* = 1 shl Uri_PROPERTY_HOST
  Uri_HAS_PASSWORD* = 1 shl Uri_PROPERTY_PASSWORD
  Uri_HAS_PATH* = 1 shl Uri_PROPERTY_PATH
  Uri_HAS_QUERY* = 1 shl Uri_PROPERTY_QUERY
  Uri_HAS_RAW_URI* = 1 shl Uri_PROPERTY_RAW_URI
  Uri_HAS_SCHEME_NAME* = 1 shl Uri_PROPERTY_SCHEME_NAME
  Uri_HAS_USER_NAME* = 1 shl Uri_PROPERTY_USER_NAME
  Uri_HAS_PATH_AND_QUERY* = 1 shl Uri_PROPERTY_PATH_AND_QUERY
  Uri_HAS_USER_INFO* = 1 shl Uri_PROPERTY_USER_INFO
  Uri_HAS_HOST_TYPE* = 1 shl Uri_PROPERTY_HOST_TYPE
  Uri_HAS_PORT* = 1 shl Uri_PROPERTY_PORT
  Uri_HAS_SCHEME* = 1 shl Uri_PROPERTY_SCHEME
  Uri_HAS_ZONE* = 1 shl Uri_PROPERTY_ZONE
  Uri_CREATE_ALLOW_RELATIVE* = 0x1
  Uri_CREATE_ALLOW_IMPLICIT_WILDCARD_SCHEME* = 0x2
  Uri_CREATE_ALLOW_IMPLICIT_FILE_SCHEME* = 0x4
  Uri_CREATE_NOFRAG* = 0x8
  Uri_CREATE_NO_CANONICALIZE* = 0x10
  Uri_CREATE_CANONICALIZE* = 0x100
  Uri_CREATE_FILE_USE_DOS_PATH* = 0x20
  Uri_CREATE_DECODE_EXTRA_INFO* = 0x40
  Uri_CREATE_NO_DECODE_EXTRA_INFO* = 0x80
  Uri_CREATE_CRACK_UNKNOWN_SCHEMES* = 0x200
  Uri_CREATE_NO_CRACK_UNKNOWN_SCHEMES* = 0x400
  Uri_CREATE_PRE_PROCESS_HTML_URI* = 0x800
  Uri_CREATE_NO_PRE_PROCESS_HTML_URI* = 0x1000
  Uri_CREATE_IE_SETTINGS* = 0x2000
  Uri_CREATE_NO_IE_SETTINGS* = 0x4000
  Uri_CREATE_NO_ENCODE_FORBIDDEN_CHARACTERS* = 0x8000
  Uri_CREATE_NORMALIZE_INTL_CHARACTERS* = 0x10000
  Uri_CREATE_CANONICALIZE_ABSOLUTE* = 0x20000
  Uri_DISPLAY_NO_FRAGMENT* = 0x1
  Uri_PUNYCODE_IDN_HOST* = 0x2
  Uri_DISPLAY_IDN_HOST* = 0x4
  Uri_DISPLAY_NO_PUNYCODE* = 0x8
  Uri_ENCODING_USER_INFO_AND_PATH_IS_PERCENT_ENCODED_UTF8* = 0x1
  Uri_ENCODING_USER_INFO_AND_PATH_IS_CP* = 0x2
  Uri_ENCODING_HOST_IS_IDN* = 0x4
  Uri_ENCODING_HOST_IS_PERCENT_ENCODED_UTF8* = 0x8
  Uri_ENCODING_HOST_IS_PERCENT_ENCODED_CP* = 0x10
  Uri_ENCODING_QUERY_AND_FRAGMENT_IS_PERCENT_ENCODED_UTF8* = 0x20
  Uri_ENCODING_QUERY_AND_FRAGMENT_IS_CP* = 0x40
  Uri_ENCODING_RFC* = Uri_ENCODING_USER_INFO_AND_PATH_IS_PERCENT_ENCODED_UTF8 or Uri_ENCODING_HOST_IS_PERCENT_ENCODED_UTF8 or Uri_ENCODING_QUERY_AND_FRAGMENT_IS_PERCENT_ENCODED_UTF8
  UriBuilder_USE_ORIGINAL_FLAGS* = 0x1
  IID_IUriContainer* = DEFINE_GUID("a158a630-ed6f-45fb-b987-f68676f57752")
  IID_IUriBuilder* = DEFINE_GUID("4221b2e1-8955-46c0-bd5b-de9897565de7")
  IID_IUriBuilderFactory* = DEFINE_GUID("e982ce48-0b96-440c-bc37-0c869b27a29e")
  IID_IWinInetInfo* = DEFINE_GUID("79eac9d6-bafa-11ce-8c82-00aa004ba90b")
  WININETINFO_OPTION_LOCK_HANDLE* = 65534
  IID_IHttpSecurity* = DEFINE_GUID("79eac9d7-bafa-11ce-8c82-00aa004ba90b")
  IID_IWinInetHttpInfo* = DEFINE_GUID("79eac9d8-bafa-11ce-8c82-00aa004ba90b")
  IID_IWinInetHttpTimeouts* = DEFINE_GUID("f286fa56-c1fd-4270-8e67-b3eb790a81e8")
  IID_IWinInetCacheHints* = DEFINE_GUID("dd1ec3b3-8391-4fdb-a9e6-347c3caaa7dd")
  IID_IWinInetCacheHints2* = DEFINE_GUID("7857aeac-d31f-49bf-884e-dd46df36780a")
  IID_IBindHost* = DEFINE_GUID("fc4801a1-2ba9-11cf-a229-00aa003d7352")
  SID_IBindHost* = IID_IBindHost
  SID_SBindHost* = IID_IBindHost
  URLOSTRM_USECACHEDCOPY_ONLY* = 0x1
  URLOSTRM_USECACHEDCOPY* = 0x2
  URLOSTRM_GETNEWESTVERSION* = 0x3
  IID_IInternet* = DEFINE_GUID("79eac9e0-baf9-11ce-8c82-00aa004ba90b")
  BINDSTRING_HEADERS* = 1
  BINDSTRING_ACCEPT_MIMES* = 2
  BINDSTRING_EXTRA_URL* = 3
  BINDSTRING_LANGUAGE* = 4
  BINDSTRING_USERNAME* = 5
  BINDSTRING_PASSWORD* = 6
  BINDSTRING_UA_PIXELS* = 7
  BINDSTRING_UA_COLOR* = 8
  BINDSTRING_OS* = 9
  BINDSTRING_USER_AGENT* = 10
  BINDSTRING_ACCEPT_ENCODINGS* = 11
  BINDSTRING_POST_COOKIE* = 12
  BINDSTRING_POST_DATA_MIME* = 13
  BINDSTRING_URL* = 14
  BINDSTRING_IID* = 15
  BINDSTRING_FLAG_BIND_TO_OBJECT* = 16
  BINDSTRING_PTR_BIND_CONTEXT* = 17
  BINDSTRING_XDR_ORIGIN* = 18
  BINDSTRING_DOWNLOADPATH* = 19
  BINDSTRING_ROOTDOC_URL* = 20
  BINDSTRING_INITIAL_FILENAME* = 21
  BINDSTRING_PROXY_USERNAME* = 22
  BINDSTRING_PROXY_PASSWORD* = 23
  IID_IInternetBindInfo* = DEFINE_GUID("79eac9e1-baf9-11ce-8c82-00aa004ba90b")
  IID_IInternetBindInfoEx* = DEFINE_GUID("a3e015b7-a82c-4dcd-a150-569aeeed36ab")
  PI_PARSE_URL* = 0x1
  PI_FILTER_MODE* = 0x2
  PI_FORCE_ASYNC* = 0x4
  PI_USE_WORKERTHREAD* = 0x8
  PI_MIMEVERIFICATION* = 0x10
  PI_DATAPROGRESS* = 0x40
  PI_SYNCHRONOUS* = 0x80
  PI_APARTMENTTHREADED* = 0x100
  PI_CLASSINSTALL* = 0x200
  PI_PASSONBINDCTX* = 0x2000
  PI_NOMIMEHANDLER* = 0x8000
  PI_LOADAPPDIRECT* = 0x4000
  PD_FORCE_SWITCH* = 0x10000
  PI_PREFERDEFAULTHANDLER* = 0x20000
  IID_IInternetProtocolRoot* = DEFINE_GUID("79eac9e3-baf9-11ce-8c82-00aa004ba90b")
  IID_IInternetProtocol* = DEFINE_GUID("79eac9e4-baf9-11ce-8c82-00aa004ba90b")
  IID_IInternetProtocolEx* = DEFINE_GUID("c7a98e66-1010-492c-a1c8-c809e1f75905")
  IID_IInternetProtocolSink* = DEFINE_GUID("79eac9e5-baf9-11ce-8c82-00aa004ba90b")
  IID_IInternetProtocolSinkStackable* = DEFINE_GUID("79eac9f0-baf9-11ce-8c82-00aa004ba90b")
  OIBDG_APARTMENTTHREADED* = 0x100
  OIBDG_DATAONLY* = 0x1000
  IID_IInternetSession* = DEFINE_GUID("79eac9e7-baf9-11ce-8c82-00aa004ba90b")
  IID_IInternetThreadSwitch* = DEFINE_GUID("79eac9e8-baf9-11ce-8c82-00aa004ba90b")
  IID_IInternetPriority* = DEFINE_GUID("79eac9eb-baf9-11ce-8c82-00aa004ba90b")
  PARSE_CANONICALIZE* = 1
  PARSE_FRIENDLY* = 2
  PARSE_SECURITY_URL* = 3
  PARSE_ROOTDOCUMENT* = 4
  PARSE_DOCUMENT* = 5
  PARSE_ANCHOR* = 6
  PARSE_ENCODE_IS_UNESCAPE* = 7
  PARSE_DECODE_IS_ESCAPE* = 8
  PARSE_PATH_FROM_URL* = 9
  PARSE_URL_FROM_PATH* = 10
  PARSE_MIME* = 11
  PARSE_SERVER* = 12
  PARSE_SCHEMA* = 13
  PARSE_SITE* = 14
  PARSE_DOMAIN* = 15
  PARSE_LOCATION* = 16
  PARSE_SECURITY_DOMAIN* = 17
  PARSE_ESCAPE* = 18
  PARSE_UNESCAPE* = 19
  PSU_DEFAULT* = 1
  PSU_SECURITY_URL_ONLY* = 2
  QUERY_EXPIRATION_DATE* = 1
  QUERY_TIME_OF_LAST_CHANGE* = 2
  QUERY_CONTENT_ENCODING* = 3
  QUERY_CONTENT_TYPE* = 4
  QUERY_REFRESH* = 5
  QUERY_RECOMBINE* = 6
  QUERY_CAN_NAVIGATE* = 7
  QUERY_USES_NETWORK* = 8
  QUERY_IS_CACHED* = 9
  QUERY_IS_INSTALLEDENTRY* = 10
  QUERY_IS_CACHED_OR_MAPPED* = 11
  QUERY_USES_CACHE* = 12
  QUERY_IS_SECURE* = 13
  QUERY_IS_SAFE* = 14
  QUERY_USES_HISTORYFOLDER* = 15
  QUERY_IS_CACHED_AND_USABLE_OFFLINE* = 16
  IID_IInternetProtocolInfo* = DEFINE_GUID("79eac9ec-baf9-11ce-8c82-00aa004ba90b")
  PARSE_ENCODE* = PARSE_ENCODE_IS_UNESCAPE
  PARSE_DECODE* = PARSE_DECODE_IS_ESCAPE
  IID_IOInet* = IID_IInternet
  IID_IOInetBindInfo* = IID_IInternetBindInfo
  IID_IOInetBindInfoEx* = IID_IInternetBindInfoEx
  IID_IOInetProtocolRoot* = IID_IInternetProtocolRoot
  IID_IOInetProtocol* = IID_IInternetProtocol
  IID_IOInetProtocolEx* = IID_IInternetProtocolEx
  IID_IOInetProtocolSink* = IID_IInternetProtocolSink
  IID_IOInetProtocolInfo* = IID_IInternetProtocolInfo
  IID_IOInetSession* = IID_IInternetSession
  IID_IOInetPriority* = IID_IInternetPriority
  IID_IOInetThreadSwitch* = IID_IInternetThreadSwitch
  IID_IOInetProtocolSinkStackable* = IID_IInternetProtocolSinkStackable
  FEATURE_OBJECT_CACHING* = 0
  FEATURE_ZONE_ELEVATION* = 1
  FEATURE_MIME_HANDLING* = 2
  FEATURE_MIME_SNIFFING* = 3
  FEATURE_WINDOW_RESTRICTIONS* = 4
  FEATURE_WEBOC_POPUPMANAGEMENT* = 5
  FEATURE_BEHAVIORS* = 6
  FEATURE_DISABLE_MK_PROTOCOL* = 7
  FEATURE_LOCALMACHINE_LOCKDOWN* = 8
  FEATURE_SECURITYBAND* = 9
  FEATURE_RESTRICT_ACTIVEXINSTALL* = 10
  FEATURE_VALIDATE_NAVIGATE_URL* = 11
  FEATURE_RESTRICT_FILEDOWNLOAD* = 12
  FEATURE_ADDON_MANAGEMENT* = 13
  FEATURE_PROTOCOL_LOCKDOWN* = 14
  FEATURE_HTTP_USERNAME_PASSWORD_DISABLE* = 15
  FEATURE_SAFE_BINDTOOBJECT* = 16
  FEATURE_UNC_SAVEDFILECHECK* = 17
  FEATURE_GET_URL_DOM_FILEPATH_UNENCODED* = 18
  FEATURE_TABBED_BROWSING* = 19
  FEATURE_SSLUX* = 20
  FEATURE_DISABLE_NAVIGATION_SOUNDS* = 21
  FEATURE_DISABLE_LEGACY_COMPRESSION* = 22
  FEATURE_FORCE_ADDR_AND_STATUS* = 23
  FEATURE_XMLHTTP* = 24
  FEATURE_DISABLE_TELNET_PROTOCOL* = 25
  FEATURE_FEEDS* = 26
  FEATURE_BLOCK_INPUT_PROMPTS* = 27
  FEATURE_ENTRY_COUNT* = 28
  SET_FEATURE_ON_THREAD* = 0x1
  SET_FEATURE_ON_PROCESS* = 0x2
  SET_FEATURE_IN_REGISTRY* = 0x4
  SET_FEATURE_ON_THREAD_LOCALMACHINE* = 0x8
  SET_FEATURE_ON_THREAD_INTRANET* = 0x10
  SET_FEATURE_ON_THREAD_TRUSTED* = 0x20
  SET_FEATURE_ON_THREAD_INTERNET* = 0x40
  SET_FEATURE_ON_THREAD_RESTRICTED* = 0x80
  GET_FEATURE_FROM_THREAD* = 0x1
  GET_FEATURE_FROM_PROCESS* = 0x2
  GET_FEATURE_FROM_REGISTRY* = 0x4
  GET_FEATURE_FROM_THREAD_LOCALMACHINE* = 0x8
  GET_FEATURE_FROM_THREAD_INTRANET* = 0x10
  GET_FEATURE_FROM_THREAD_TRUSTED* = 0x20
  GET_FEATURE_FROM_THREAD_INTERNET* = 0x40
  GET_FEATURE_FROM_THREAD_RESTRICTED* = 0x80
  INET_E_USE_DEFAULT_PROTOCOLHANDLER* = HRESULT 0x800C0011'i32
  INET_E_USE_DEFAULT_SETTING* = HRESULT 0x800C0012'i32
  INET_E_DEFAULT_ACTION* = INET_E_USE_DEFAULT_PROTOCOLHANDLER
  INET_E_QUERYOPTION_UNKNOWN* = HRESULT 0x800C0013'i32
  INET_E_REDIRECTING* = HRESULT 0x800C0014'i32
  PROTOCOLFLAG_NO_PICS_CHECK* = 0x1
  IID_IInternetSecurityManager* = DEFINE_GUID("79eac9ee-baf9-11ce-8c82-00aa004ba90b")
  SID_SInternetSecurityManager* = IID_IInternetSecurityManager
  IID_IInternetSecurityManagerEx* = DEFINE_GUID("f164edf1-cc7c-4f0d-9a94-34222625c393")
  SID_SInternetSecurityManagerEx* = IID_IInternetSecurityManagerEx
  IID_IInternetSecurityManagerEx2* = DEFINE_GUID("f1e50292-a795-4117-8e09-2b560a72ac60")
  SID_SInternetSecurityManagerEx2* = IID_IInternetSecurityManagerEx2
  IID_IInternetHostSecurityManager* = DEFINE_GUID("3af280b6-cb3f-11d0-891e-00c04fb6bfc4")
  SID_SInternetHostSecurityManager* = IID_IInternetHostSecurityManager
  IID_IInternetSecurityMgrSite* = DEFINE_GUID("79eac9ed-baf9-11ce-8c82-00aa004ba90b")
  MUTZ_NOSAVEDFILECHECK* = 0x1
  MUTZ_ISFILE* = 0x2
  MUTZ_ACCEPT_WILDCARD_SCHEME* = 0x80
  MUTZ_ENFORCERESTRICTED* = 0x100
  MUTZ_RESERVED* = 0x200
  MUTZ_REQUIRESAVEDFILECHECK* = 0x400
  MUTZ_DONT_UNESCAPE* = 0x800
  MUTZ_DONT_USE_CACHE* = 0x1000
  MUTZ_FORCE_INTRANET_FLAGS* = 0x2000
  MUTZ_IGNORE_ZONE_MAPPINGS* = 0x4000
  MAX_SIZE_SECURITY_ID* = 512
  PUAF_DEFAULT* = 0x0
  PUAF_NOUI* = 0x1
  PUAF_ISFILE* = 0x2
  PUAF_WARN_IF_DENIED* = 0x4
  PUAF_FORCEUI_FOREGROUND* = 0x8
  PUAF_CHECK_TIFS* = 0x10
  PUAF_DONTCHECKBOXINDIALOG* = 0x20
  PUAF_TRUSTED* = 0x40
  PUAF_ACCEPT_WILDCARD_SCHEME* = 0x80
  PUAF_ENFORCERESTRICTED* = 0x100
  PUAF_NOSAVEDFILECHECK* = 0x200
  PUAF_REQUIRESAVEDFILECHECK* = 0x400
  PUAF_DONT_USE_CACHE* = 0x1000
  PUAF_RESERVED1* = 0x2000
  PUAF_RESERVED2* = 0x4000
  PUAF_LMZ_UNLOCKED* = 0x10000
  PUAF_LMZ_LOCKED* = 0x20000
  PUAF_DEFAULTZONEPOL* = 0x40000
  PUAF_NPL_USE_LOCKED_IF_RESTRICTED* = 0x80000
  PUAF_NOUIIFLOCKED* = 0x100000
  PUAF_DRAGPROTOCOLCHECK* = 0x200000
  PUAFOUT_DEFAULT* = 0x0
  PUAFOUT_ISLOCKZONEPOLICY* = 0x1
  SZM_CREATE* = 0x0
  SZM_DELETE* = 0x1
  IID_IZoneIdentifier* = DEFINE_GUID("cd45f185-1b21-48e2-967b-ead743a8914e")
  URLACTION_MIN* = 0x1000
  URLACTION_DOWNLOAD_MIN* = 0x1000
  URLACTION_DOWNLOAD_SIGNED_ACTIVEX* = 0x1001
  URLACTION_DOWNLOAD_UNSIGNED_ACTIVEX* = 0x1004
  URLACTION_DOWNLOAD_CURR_MAX* = 0x1004
  URLACTION_DOWNLOAD_MAX* = 0x11FF
  URLACTION_ACTIVEX_MIN* = 0x1200
  URLACTION_ACTIVEX_RUN* = 0x1200
  URLPOLICY_ACTIVEX_CHECK_LIST* = 0x10000
  URLACTION_ACTIVEX_OVERRIDE_OBJECT_SAFETY* = 0x1201
  URLACTION_ACTIVEX_OVERRIDE_DATA_SAFETY* = 0x1202
  URLACTION_ACTIVEX_OVERRIDE_SCRIPT_SAFETY* = 0x1203
  URLACTION_SCRIPT_OVERRIDE_SAFETY* = 0x1401
  URLACTION_ACTIVEX_CONFIRM_NOOBJECTSAFETY* = 0x1204
  URLACTION_ACTIVEX_TREATASUNTRUSTED* = 0x1205
  URLACTION_ACTIVEX_NO_WEBOC_SCRIPT* = 0x1206
  URLACTION_ACTIVEX_OVERRIDE_REPURPOSEDETECTION* = 0x1207
  URLACTION_ACTIVEX_OVERRIDE_OPTIN* = 0x1208
  URLACTION_ACTIVEX_SCRIPTLET_RUN* = 0x1209
  URLACTION_ACTIVEX_DYNSRC_VIDEO_AND_ANIMATION* = 0x120A
  URLACTION_ACTIVEX_OVERRIDE_DOMAINLIST* = 0x120B
  URLACTION_ACTIVEX_CURR_MAX* = 0x120B
  URLACTION_ACTIVEX_MAX* = 0x13ff
  URLACTION_SCRIPT_MIN* = 0x1400
  URLACTION_SCRIPT_RUN* = 0x1400
  URLACTION_SCRIPT_JAVA_USE* = 0x1402
  URLACTION_SCRIPT_SAFE_ACTIVEX* = 0x1405
  URLACTION_CROSS_DOMAIN_DATA* = 0x1406
  URLACTION_SCRIPT_PASTE* = 0x1407
  URLACTION_ALLOW_XDOMAIN_SUBFRAME_RESIZE* = 0x1408
  URLACTION_SCRIPT_XSSFILTER* = 0x1409
  URLACTION_SCRIPT_NAVIGATE* = 0x140A
  URLACTION_PLUGGABLE_PROTOCOL_XHR* = 0x140B
  URLACTION_SCRIPT_CURR_MAX* = 0x140B
  URLACTION_SCRIPT_MAX* = 0x15ff
  URLACTION_HTML_MIN* = 0x1600
  URLACTION_HTML_SUBMIT_FORMS* = 0x1601
  URLACTION_HTML_SUBMIT_FORMS_FROM* = 0x1602
  URLACTION_HTML_SUBMIT_FORMS_TO* = 0x1603
  URLACTION_HTML_FONT_DOWNLOAD* = 0x1604
  URLACTION_HTML_JAVA_RUN* = 0x1605
  URLACTION_HTML_USERDATA_SAVE* = 0x1606
  URLACTION_HTML_SUBFRAME_NAVIGATE* = 0x1607
  URLACTION_HTML_META_REFRESH* = 0x1608
  URLACTION_HTML_MIXED_CONTENT* = 0x1609
  URLACTION_HTML_INCLUDE_FILE_PATH* = 0x160A
  URLACTION_HTML_ALLOW_INJECTED_DYNAMIC_HTML* = 0x160B
  URLACTION_HTML_REQUIRE_UTF8_DOCUMENT_CODEPAGE* = 0x160C
  URLACTION_HTML_ALLOW_CROSS_DOMAIN_CANVAS* = 0x160D
  URLACTION_HTML_ALLOW_WINDOW_CLOSE* = 0x160E
  URLACTION_HTML_ALLOW_CROSS_DOMAIN_WEBWORKER* = 0x160F
  URLACTION_HTML_ALLOW_CROSS_DOMAIN_TEXTTRACK* = 0x1610
  URLACTION_HTML_ALLOW_INDEXEDDB* = 0x1611
  URLACTION_HTML_MAX* = 0x17ff
  URLACTION_SHELL_MIN* = 0x1800
  URLACTION_SHELL_INSTALL_DTITEMS* = 0x1800
  URLACTION_SHELL_MOVE_OR_COPY* = 0x1802
  URLACTION_SHELL_FILE_DOWNLOAD* = 0x1803
  URLACTION_SHELL_VERB* = 0x1804
  URLACTION_SHELL_WEBVIEW_VERB* = 0x1805
  URLACTION_SHELL_SHELLEXECUTE* = 0x1806
  URLACTION_SHELL_EXECUTE_HIGHRISK* = 0x1806
  URLACTION_SHELL_EXECUTE_MODRISK* = 0x1807
  URLACTION_SHELL_EXECUTE_LOWRISK* = 0x1808
  URLACTION_SHELL_POPUPMGR* = 0x1809
  URLACTION_SHELL_RTF_OBJECTS_LOAD* = 0x180A
  URLACTION_SHELL_ENHANCED_DRAGDROP_SECURITY* = 0x180B
  URLACTION_SHELL_EXTENSIONSECURITY* = 0x180C
  URLACTION_SHELL_SECURE_DRAGSOURCE* = 0x180D
  URLACTION_SHELL_REMOTEQUERY* = 0x180E
  URLACTION_SHELL_PREVIEW* = 0x180F
  URLACTION_SHELL_SHARE* = 0x1810
  URLACTION_SHELL_ALLOW_CROSS_SITE_SHARE* = 0x1811
  URLACTION_SHELL_CURR_MAX* = 0x1811
  URLACTION_SHELL_MAX* = 0x19ff
  URLACTION_NETWORK_MIN* = 0x1A00
  URLACTION_CREDENTIALS_USE* = 0x1A00
  URLPOLICY_CREDENTIALS_SILENT_LOGON_OK* = 0x0
  URLPOLICY_CREDENTIALS_MUST_PROMPT_USER* = 0x10000
  URLPOLICY_CREDENTIALS_CONDITIONAL_PROMPT* = 0x20000
  URLPOLICY_CREDENTIALS_ANONYMOUS_ONLY* = 0x30000
  URLACTION_AUTHENTICATE_CLIENT* = 0x1A01
  URLPOLICY_AUTHENTICATE_CLEARTEXT_OK* = 0x0
  URLPOLICY_AUTHENTICATE_CHALLENGE_RESPONSE* = 0x10000
  URLPOLICY_AUTHENTICATE_MUTUAL_ONLY* = 0x30000
  URLACTION_COOKIES* = 0x1A02
  URLACTION_COOKIES_SESSION* = 0x1A03
  URLACTION_CLIENT_CERT_PROMPT* = 0x1A04
  URLACTION_COOKIES_THIRD_PARTY* = 0x1A05
  URLACTION_COOKIES_SESSION_THIRD_PARTY* = 0x1A06
  URLACTION_COOKIES_ENABLED* = 0x1A10
  URLACTION_NETWORK_CURR_MAX* = 0x1A10
  URLACTION_NETWORK_MAX* = 0x1Bff
  URLACTION_JAVA_MIN* = 0x1C00
  URLACTION_JAVA_PERMISSIONS* = 0x1C00
  URLPOLICY_JAVA_PROHIBIT* = 0x0
  URLPOLICY_JAVA_HIGH* = 0x10000
  URLPOLICY_JAVA_MEDIUM* = 0x20000
  URLPOLICY_JAVA_LOW* = 0x30000
  URLPOLICY_JAVA_CUSTOM* = 0x800000
  URLACTION_JAVA_CURR_MAX* = 0x1C00
  URLACTION_JAVA_MAX* = 0x1Cff
  URLACTION_INFODELIVERY_MIN* = 0x1D00
  URLACTION_INFODELIVERY_NO_ADDING_CHANNELS* = 0x1D00
  URLACTION_INFODELIVERY_NO_EDITING_CHANNELS* = 0x1D01
  URLACTION_INFODELIVERY_NO_REMOVING_CHANNELS* = 0x1D02
  URLACTION_INFODELIVERY_NO_ADDING_SUBSCRIPTIONS* = 0x1D03
  URLACTION_INFODELIVERY_NO_EDITING_SUBSCRIPTIONS* = 0x1D04
  URLACTION_INFODELIVERY_NO_REMOVING_SUBSCRIPTIONS* = 0x1D05
  URLACTION_INFODELIVERY_NO_CHANNEL_LOGGING* = 0x1D06
  URLACTION_INFODELIVERY_CURR_MAX* = 0x1D06
  URLACTION_INFODELIVERY_MAX* = 0x1Dff
  URLACTION_CHANNEL_SOFTDIST_MIN* = 0x1E00
  URLACTION_CHANNEL_SOFTDIST_PERMISSIONS* = 0x1E05
  URLPOLICY_CHANNEL_SOFTDIST_PROHIBIT* = 0x10000
  URLPOLICY_CHANNEL_SOFTDIST_PRECACHE* = 0x20000
  URLPOLICY_CHANNEL_SOFTDIST_AUTOINSTALL* = 0x30000
  URLACTION_CHANNEL_SOFTDIST_MAX* = 0x1Eff
  URLACTION_DOTNET_USERCONTROLS* = 0x2005
  URLACTION_BEHAVIOR_MIN* = 0x2000
  URLACTION_BEHAVIOR_RUN* = 0x2000
  URLPOLICY_BEHAVIOR_CHECK_LIST* = 0x10000
  URLACTION_FEATURE_MIN* = 0x2100
  URLACTION_FEATURE_MIME_SNIFFING* = 0x2100
  URLACTION_FEATURE_ZONE_ELEVATION* = 0x2101
  URLACTION_FEATURE_WINDOW_RESTRICTIONS* = 0x2102
  URLACTION_FEATURE_SCRIPT_STATUS_BAR* = 0x2103
  URLACTION_FEATURE_FORCE_ADDR_AND_STATUS* = 0x2104
  URLACTION_FEATURE_BLOCK_INPUT_PROMPTS* = 0x2105
  URLACTION_FEATURE_DATA_BINDING* = 0x2106
  URLACTION_FEATURE_CROSSDOMAIN_FOCUS_CHANGE* = 0x2107
  URLACTION_AUTOMATIC_DOWNLOAD_UI_MIN* = 0x2200
  URLACTION_AUTOMATIC_DOWNLOAD_UI* = 0x2200
  URLACTION_AUTOMATIC_ACTIVEX_UI* = 0x2201
  URLACTION_ALLOW_RESTRICTEDPROTOCOLS* = 0x2300
  URLACTION_ALLOW_APEVALUATION* = 0x2301
  URLACTION_ALLOW_XHR_EVALUATION* = 0x2302
  URLACTION_WINDOWS_BROWSER_APPLICATIONS* = 0x2400
  URLACTION_XPS_DOCUMENTS* = 0x2401
  URLACTION_LOOSE_XAML* = 0x2402
  URLACTION_LOWRIGHTS* = 0x2500
  URLACTION_WINFX_SETUP* = 0x2600
  URLACTION_INPRIVATE_BLOCKING* = 0x2700
  URLACTION_ALLOW_AUDIO_VIDEO* = 0x2701
  URLACTION_ALLOW_ACTIVEX_FILTERING* = 0x2702
  URLACTION_ALLOW_STRUCTURED_STORAGE_SNIFFING* = 0x2703
  URLACTION_ALLOW_AUDIO_VIDEO_PLUGINS* = 0x2704
  URLACTION_ALLOW_ZONE_ELEVATION_VIA_OPT_OUT* = 0x2705
  URLACTION_ALLOW_ZONE_ELEVATION_OPT_OUT_ADDITION* = 0x2706
  URLACTION_ALLOW_CROSSDOMAIN_DROP_WITHIN_WINDOW* = 0x2708
  URLACTION_ALLOW_CROSSDOMAIN_DROP_ACROSS_WINDOWS* = 0x2709
  URLACTION_ALLOW_CROSSDOMAIN_APPCACHE_MANIFEST* = 0x270A
  URLACTION_ALLOW_RENDER_LEGACY_DXTFILTERS* = 0x270B
  URLPOLICY_ALLOW* = 0x0
  URLPOLICY_QUERY* = 0x1
  URLPOLICY_DISALLOW* = 0x3
  URLPOLICY_NOTIFY_ON_ALLOW* = 0x10
  URLPOLICY_NOTIFY_ON_DISALLOW* = 0x20
  URLPOLICY_LOG_ON_ALLOW* = 0x40
  URLPOLICY_LOG_ON_DISALLOW* = 0x80
  URLPOLICY_MASK_PERMISSIONS* = 0x0f
  URLPOLICY_DONTCHECKDLGBOX* = 0x100
  URLZONE_INVALID* = -1
  URLZONE_PREDEFINED_MIN* = 0
  URLZONE_LOCAL_MACHINE* = 0
  URLZONE_INTRANET* = 1
  URLZONE_TRUSTED* = 2
  URLZONE_INTERNET* = 3
  URLZONE_UNTRUSTED* = 4
  URLZONE_PREDEFINED_MAX* = 999
  URLZONE_USER_MIN* = 1000
  URLZONE_USER_MAX* = 10000
  URLZONE_ESC_FLAG* = 0x100
  URLTEMPLATE_CUSTOM* = 0x0
  URLTEMPLATE_PREDEFINED_MIN* = 0x10000
  URLTEMPLATE_LOW* = 0x10000
  URLTEMPLATE_MEDLOW* = 0x10500
  URLTEMPLATE_MEDIUM* = 0x11000
  URLTEMPLATE_MEDHIGH* = 0x11500
  URLTEMPLATE_HIGH* = 0x12000
  URLTEMPLATE_PREDEFINED_MAX* = 0x20000
  MAX_ZONE_PATH* = 260
  MAX_ZONE_DESCRIPTION* = 200
  ZAFLAGS_CUSTOM_EDIT* = 0x1
  ZAFLAGS_ADD_SITES* = 0x2
  ZAFLAGS_REQUIRE_VERIFICATION* = 0x4
  ZAFLAGS_INCLUDE_PROXY_OVERRIDE* = 0x8
  ZAFLAGS_INCLUDE_INTRANET_SITES* = 0x10
  ZAFLAGS_NO_UI* = 0x20
  ZAFLAGS_SUPPORTS_VERIFICATION* = 0x40
  ZAFLAGS_UNC_AS_INTRANET* = 0x80
  ZAFLAGS_DETECT_INTRANET* = 0x100
  ZAFLAGS_USE_LOCKED_ZONES* = 0x10000
  ZAFLAGS_VERIFY_TEMPLATE_SETTINGS* = 0x20000
  ZAFLAGS_NO_CACHE* = 0x40000
  URLZONEREG_DEFAULT* = 0
  URLZONEREG_HKLM* = 1
  URLZONEREG_HKCU* = 2
  IID_IInternetZoneManager* = DEFINE_GUID("79eac9ef-baf9-11ce-8c82-00aa004ba90b")
  IID_IInternetZoneManagerEx* = DEFINE_GUID("a4c23339-8e06-431e-9bf4-7e711c085648")
  SECURITY_IE_STATE_GREEN* = 0x0
  SECURITY_IE_STATE_RED* = 0x1
  IID_IInternetZoneManagerEx2* = DEFINE_GUID("edc17559-dd5d-4846-8eef-8becba5a4abf")
  SOFTDIST_FLAG_USAGE_EMAIL* = 0x1
  SOFTDIST_FLAG_USAGE_PRECACHE* = 0x2
  SOFTDIST_FLAG_USAGE_AUTOINSTALL* = 0x4
  SOFTDIST_FLAG_DELETE_SUBSCRIPTION* = 0x8
  SOFTDIST_ADSTATE_NONE* = 0x0
  SOFTDIST_ADSTATE_AVAILABLE* = 0x1
  SOFTDIST_ADSTATE_DOWNLOADED* = 0x2
  SOFTDIST_ADSTATE_INSTALLED* = 0x3
  IID_ISoftDistExt* = DEFINE_GUID("b15b8dc1-c7e1-11d0-8680-00aa00bdcb71")
  IID_ICatalogFileInfo* = DEFINE_GUID("711c7600-6b48-11d1-b403-00aa00b92af1")
  IID_IDataFilter* = DEFINE_GUID("69d14c80-c18e-11d0-a9ce-006097942311")
  IID_IEncodingFilterFactory* = DEFINE_GUID("70bdde00-c18e-11d0-a9ce-006097942311")
  CONFIRMSAFETYACTION_LOADOBJECT* = 0x1
  IID_IWrappedProtocol* = DEFINE_GUID("53c84785-8425-4dc5-971b-e58d9c19f9b6")
  BINDHANDLETYPES_APPCACHE* = 0x0
  BINDHANDLETYPES_DEPENDENCY* = 0x1
  BINDHANDLETYPES_COUNT* = 0x2
  IID_IGetBindHandle* = DEFINE_GUID("af0ff408-129d-4b20-91f0-02bd23d88352")
  IID_IBindCallbackRedirect* = DEFINE_GUID("11c81bc2-121e-4ed5-b9c4-b430bd54f2c0")
  PROPSETFLAG_DEFAULT* = 0
  PROPSETFLAG_NONSIMPLE* = 1
  PROPSETFLAG_ANSI* = 2
  PROPSETFLAG_UNBUFFERED* = 4
  PROPSETFLAG_CASE_SENSITIVE* = 8
  PROPSET_BEHAVIOR_CASE_SENSITIVE* = 1
  PID_DICTIONARY* = 0x0
  PID_CODEPAGE* = 0x1
  PID_FIRST_USABLE* = 0x2
  PID_FIRST_NAME_DEFAULT* = 0xfff
  PID_LOCALE* = 0x80000000'i32
  PID_MODIFY_TIME* = 0x80000001'i32
  PID_SECURITY* = 0x80000002'i32
  PID_BEHAVIOR* = 0x80000003'i32
  PID_ILLEGAL* = 0xffffffff'i32
  PID_MIN_READONLY* = 0x80000000'i32
  PID_MAX_READONLY* = 0xbfffffff'i32
  PIDDI_THUMBNAIL* = 0x2
  PIDSI_TITLE* = 0x2
  PIDSI_SUBJECT* = 0x3
  PIDSI_AUTHOR* = 0x4
  PIDSI_KEYWORDS* = 0x5
  PIDSI_COMMENTS* = 0x6
  PIDSI_TEMPLATE* = 0x7
  PIDSI_LASTAUTHOR* = 0x8
  PIDSI_REVNUMBER* = 0x9
  PIDSI_EDITTIME* = 0xa
  PIDSI_LASTPRINTED* = 0xb
  PIDSI_CREATE_DTM* = 0xc
  PIDSI_LASTSAVE_DTM* = 0xd
  PIDSI_PAGECOUNT* = 0xe
  PIDSI_WORDCOUNT* = 0xf
  PIDSI_CHARCOUNT* = 0x10
  PIDSI_THUMBNAIL* = 0x11
  PIDSI_APPNAME* = 0x12
  PIDSI_DOC_SECURITY* = 0x13
  PIDDSI_CATEGORY* = 0x00000002
  PIDDSI_PRESFORMAT* = 0x00000003
  PIDDSI_BYTECOUNT* = 0x00000004
  PIDDSI_LINECOUNT* = 0x00000005
  PIDDSI_PARCOUNT* = 0x00000006
  PIDDSI_SLIDECOUNT* = 0x00000007
  PIDDSI_NOTECOUNT* = 0x00000008
  PIDDSI_HIDDENCOUNT* = 0x00000009
  PIDDSI_MMCLIPCOUNT* = 0x0000000A
  PIDDSI_SCALE* = 0x0000000B
  PIDDSI_HEADINGPAIR* = 0x0000000C
  PIDDSI_DOCPARTS* = 0x0000000D
  PIDDSI_MANAGER* = 0x0000000E
  PIDDSI_COMPANY* = 0x0000000F
  PIDDSI_LINKSDIRTY* = 0x00000010
  PIDMSI_EDITOR* = 0x2
  PIDMSI_SUPPLIER* = 0x3
  PIDMSI_SOURCE* = 0x4
  PIDMSI_SEQUENCE_NO* = 0x5
  PIDMSI_PROJECT* = 0x6
  PIDMSI_STATUS* = 0x7
  PIDMSI_OWNER* = 0x8
  PIDMSI_RATING* = 0x9
  PIDMSI_PRODUCTION* = 0xa
  PIDMSI_COPYRIGHT* = 0xb
  PIDMSI_STATUS_NORMAL* = 0
  PIDMSI_STATUS_NEW* = 1
  PIDMSI_STATUS_PRELIM* = 2
  PIDMSI_STATUS_DRAFT* = 3
  PIDMSI_STATUS_INPROGRESS* = 4
  PIDMSI_STATUS_EDIT* = 5
  PIDMSI_STATUS_REVIEW* = 6
  PIDMSI_STATUS_PROOF* = 7
  PIDMSI_STATUS_FINAL* = 8
  PIDMSI_STATUS_OTHER* = 0x7fff
  PRSPEC_INVALID* = 0xffffffff'i32
  PRSPEC_LPWSTR* = 0
  PRSPEC_PROPID* = 1
  PROPSETHDR_OSVERSION_UNKNOWN* = 0xffffffff'i32
  IID_IPropertyStorage* = DEFINE_GUID("00000138-0000-0000-c000-000000000046")
  IID_IPropertySetStorage* = DEFINE_GUID("0000013a-0000-0000-c000-000000000046")
  IID_IEnumSTATPROPSTG* = DEFINE_GUID("00000139-0000-0000-c000-000000000046")
  IID_IEnumSTATPROPSETSTG* = DEFINE_GUID("0000013b-0000-0000-c000-000000000046")
  CCH_MAX_PROPSTG_NAME* = 31
  UAS_NORMAL* = 0x0
  UAS_BLOCKED* = 0x1
  UAS_NOPARENTENABLE* = 0x2
  UAS_MASK* = 0x3
  READYSTATE_UNINITIALIZED* = 0
  READYSTATE_LOADING* = 1
  READYSTATE_LOADED* = 2
  READYSTATE_INTERACTIVE* = 3
  READYSTATE_COMPLETE* = 4
  IID_IEnumConnections* = DEFINE_GUID("b196b287-bab4-101a-b69c-00aa00341d07")
  IID_IConnectionPoint* = DEFINE_GUID("b196b286-bab4-101a-b69c-00aa00341d07")
  IID_IEnumConnectionPoints* = DEFINE_GUID("b196b285-bab4-101a-b69c-00aa00341d07")
  IID_IConnectionPointContainer* = DEFINE_GUID("b196b284-bab4-101a-b69c-00aa00341d07")
  IID_IClassFactory2* = DEFINE_GUID("b196b28f-bab4-101a-b69c-00aa00341d07")
  IID_IProvideClassInfo* = DEFINE_GUID("b196b283-bab4-101a-b69c-00aa00341d07")
  GUIDKIND_DEFAULT_SOURCE_DISP_IID* = 1
  IID_IProvideClassInfo2* = DEFINE_GUID("a6bc3ac0-dbaa-11ce-9de3-00aa004bb851")
  MULTICLASSINFO_GETTYPEINFO* = 0x1
  MULTICLASSINFO_GETNUMRESERVEDDISPIDS* = 0x2
  MULTICLASSINFO_GETIIDPRIMARY* = 0x4
  MULTICLASSINFO_GETIIDSOURCE* = 0x8
  TIFLAGS_EXTENDDISPATCHONLY* = 0x1
  IID_IProvideMultipleClassInfo* = DEFINE_GUID("a7aba9c1-8983-11cf-8f20-00805f2cd064")
  CTRLINFO_EATS_RETURN* = 1
  CTRLINFO_EATS_ESCAPE* = 2
  IID_IOleControl* = DEFINE_GUID("b196b288-bab4-101a-b69c-00aa00341d07")
  XFORMCOORDS_POSITION* = 0x1
  XFORMCOORDS_SIZE* = 0x2
  XFORMCOORDS_HIMETRICTOCONTAINER* = 0x4
  XFORMCOORDS_CONTAINERTOHIMETRIC* = 0x8
  XFORMCOORDS_EVENTCOMPAT* = 0x10
  IID_IOleControlSite* = DEFINE_GUID("b196b289-bab4-101a-b69c-00aa00341d07")
  IID_IPropertyPage* = DEFINE_GUID("b196b28d-bab4-101a-b69c-00aa00341d07")
  IID_IPropertyPage2* = DEFINE_GUID("01e44665-24ac-101b-84ed-08002b2ec713")
  PROPPAGESTATUS_DIRTY* = 0x1
  PROPPAGESTATUS_VALIDATE* = 0x2
  PROPPAGESTATUS_CLEAN* = 0x4
  IID_IPropertyPageSite* = DEFINE_GUID("b196b28c-bab4-101a-b69c-00aa00341d07")
  IID_IPropertyNotifySink* = DEFINE_GUID("9bfbbc02-eff1-101a-84ed-00aa00341d07")
  IID_ISpecifyPropertyPages* = DEFINE_GUID("b196b28b-bab4-101a-b69c-00aa00341d07")
  IID_IPersistMemory* = DEFINE_GUID("bd1ae5e0-a6ae-11ce-bd37-504200c10000")
  IID_IPersistStreamInit* = DEFINE_GUID("7fd52380-4e07-101b-ae2d-08002b2ec713")
  IID_IPersistPropertyBag* = DEFINE_GUID("37d84f60-42cb-11ce-8135-00aa004bb851")
  IID_ISimpleFrameSite* = DEFINE_GUID("742b0e01-14e6-101b-914e-00aa00300cab")
  IID_IFont* = DEFINE_GUID("bef6e002-a874-101a-8bba-00aa00300cab")
  PICTURE_SCALABLE* = 0x1
  PICTURE_TRANSPARENT* = 0x2
  IID_IPicture* = DEFINE_GUID("7bf80980-bf32-101a-8bbb-00aa00300cab")
  IID_IPicture2* = DEFINE_GUID("f5185dd8-2012-4b0b-aad9-f052c6bd482b")
  IID_IFontEventsDisp* = DEFINE_GUID("4ef6100a-af88-11d0-9846-00c04fc29993")
  IID_IFontDisp* = DEFINE_GUID("bef6e003-a874-101a-8bba-00aa00300cab")
  IID_IPictureDisp* = DEFINE_GUID("7bf80981-bf32-101a-8bbb-00aa00300cab")
  IID_IOleInPlaceObjectWindowless* = DEFINE_GUID("1c2056cc-5ef4-101b-8bc8-00aa003e3b29")
  ACTIVATE_WINDOWLESS* = 1
  IID_IOleInPlaceSiteEx* = DEFINE_GUID("9c2cad80-3424-11cf-b670-00aa004cd6d8")
  OLEDC_NODRAW* = 0x1
  OLEDC_PAINTBKGND* = 0x2
  OLEDC_OFFSCREEN* = 0x4
  IID_IOleInPlaceSiteWindowless* = DEFINE_GUID("922eada0-3424-11cf-b670-00aa004cd6d8")
  VIEWSTATUS_OPAQUE* = 1
  VIEWSTATUS_SOLIDBKGND* = 2
  VIEWSTATUS_DVASPECTOPAQUE* = 4
  VIEWSTATUS_DVASPECTTRANSPARENT* = 8
  VIEWSTATUS_SURFACE* = 16
  VIEWSTATUS_3DSURFACE* = 32
  HITRESULT_OUTSIDE* = 0
  HITRESULT_TRANSPARENT* = 1
  HITRESULT_CLOSE* = 2
  HITRESULT_HIT* = 3
  DVASPECT_OPAQUE* = 16
  DVASPECT_TRANSPARENT* = 32
  DVEXTENT_CONTENT* = 0
  DVEXTENT_INTEGRAL* = 1
  DVASPECTINFOFLAG_CANOPTIMIZE* = 1
  IID_IViewObjectEx* = DEFINE_GUID("3af24292-0c96-11ce-a0cf-00aa00600ab8")
  IID_IOleUndoUnit* = DEFINE_GUID("894ad3b0-ef97-11ce-9bc9-00aa00608e01")
  IID_IOleParentUndoUnit* = DEFINE_GUID("a1faf330-ef97-11ce-9bc9-00aa00608e01")
  IID_IEnumOleUndoUnits* = DEFINE_GUID("b3e7c340-ef97-11ce-9bc9-00aa00608e01")
  IID_IOleUndoManager* = DEFINE_GUID("d001f200-ef97-11ce-9bc9-00aa00608e01")
  SID_SOleUndoManager* = IID_IOleUndoManager
  POINTERINACTIVE_ACTIVATEONENTRY* = 1
  POINTERINACTIVE_DEACTIVATEONLEAVE* = 2
  POINTERINACTIVE_ACTIVATEONDRAG* = 4
  IID_IPointerInactive* = DEFINE_GUID("55980ba0-35aa-11cf-b671-00aa004cd6d8")
  IID_IObjectWithSite* = DEFINE_GUID("fc4801a3-2ba9-11cf-a229-00aa003d7352")
  IID_IPerPropertyBrowsing* = DEFINE_GUID("376bd3aa-3845-101b-84ed-08002b2ec713")
  PROPBAG2_TYPE_UNDEFINED* = 0
  PROPBAG2_TYPE_DATA* = 1
  PROPBAG2_TYPE_URL* = 2
  PROPBAG2_TYPE_OBJECT* = 3
  PROPBAG2_TYPE_STREAM* = 4
  PROPBAG2_TYPE_STORAGE* = 5
  PROPBAG2_TYPE_MONIKER* = 6
  IID_IPropertyBag2* = DEFINE_GUID("22f55882-280b-11d0-a8a9-00a0c90c2004")
  IID_IPersistPropertyBag2* = DEFINE_GUID("22f55881-280b-11d0-a8a9-00a0c90c2004")
  IID_IAdviseSinkEx* = DEFINE_GUID("3af24290-0c96-11ce-a0cf-00aa00600ab8")
  QACONTAINER_SHOWHATCHING* = 0x1
  QACONTAINER_SHOWGRABHANDLES* = 0x2
  QACONTAINER_USERMODE* = 0x4
  QACONTAINER_DISPLAYASDEFAULT* = 0x8
  QACONTAINER_UIDEAD* = 0x10
  QACONTAINER_AUTOCLIP* = 0x20
  QACONTAINER_MESSAGEREFLECT* = 0x40
  QACONTAINER_SUPPORTSMNEMONICS* = 0x80
  IID_IQuickActivate* = DEFINE_GUID("cf51ed10-62fe-11cf-bf86-00a0c9034836")
  IID_IEnumGUID* = DEFINE_GUID("0002e000-0000-0000-c000-000000000046")
  IID_IEnumCLSID* = IID_IEnumGUID
  CATID_NULL* = GUID_NULL
  IID_IEnumCATID* = IID_IEnumGUID
  IID_IEnumCATEGORYINFO* = DEFINE_GUID("0002e011-0000-0000-c000-000000000046")
  IID_ICatRegister* = DEFINE_GUID("0002e012-0000-0000-c000-000000000046")
  IID_ICatInformation* = DEFINE_GUID("0002e013-0000-0000-c000-000000000046")
  STRRET_WSTR* = 0x0
  STRRET_OFFSET* = 0x1
  STRRET_CSTR* = 0x2
  PERCEIVED_TYPE_FIRST* = -3
  PERCEIVED_TYPE_CUSTOM* = -3
  PERCEIVED_TYPE_UNSPECIFIED* = -2
  PERCEIVED_TYPE_FOLDER* = -1
  PERCEIVED_TYPE_UNKNOWN* = 0
  PERCEIVED_TYPE_TEXT* = 1
  PERCEIVED_TYPE_IMAGE* = 2
  PERCEIVED_TYPE_AUDIO* = 3
  PERCEIVED_TYPE_VIDEO* = 4
  PERCEIVED_TYPE_COMPRESSED* = 5
  PERCEIVED_TYPE_DOCUMENT* = 6
  PERCEIVED_TYPE_SYSTEM* = 7
  PERCEIVED_TYPE_APPLICATION* = 8
  PERCEIVED_TYPE_GAMEMEDIA* = 9
  PERCEIVED_TYPE_CONTACTS* = 10
  PERCEIVED_TYPE_LAST* = 10
  PERCEIVEDFLAG_UNDEFINED* = 0x0000
  PERCEIVEDFLAG_SOFTCODED* = 0x0001
  PERCEIVEDFLAG_HARDCODED* = 0x0002
  PERCEIVEDFLAG_NATIVESUPPORT* = 0x0004
  PERCEIVEDFLAG_GDIPLUS* = 0x0010
  PERCEIVEDFLAG_WMSDK* = 0x0020
  PERCEIVEDFLAG_ZIPFOLDER* = 0x0040
  SHCOLSTATE_DEFAULT* = 0x0
  SHCOLSTATE_TYPE_STR* = 0x1
  SHCOLSTATE_TYPE_INT* = 0x2
  SHCOLSTATE_TYPE_DATE* = 0x3
  SHCOLSTATE_TYPEMASK* = 0xf
  SHCOLSTATE_ONBYDEFAULT* = 0x10
  SHCOLSTATE_SLOW* = 0x20
  SHCOLSTATE_EXTENDED* = 0x40
  SHCOLSTATE_SECONDARYUI* = 0x80
  SHCOLSTATE_HIDDEN* = 0x100
  SHCOLSTATE_PREFER_VARCMP* = 0x200
  SHCOLSTATE_PREFER_FMTCMP* = 0x400
  SHCOLSTATE_NOSORTBYFOLDERNESS* = 0x800
  SHCOLSTATE_VIEWONLY* = 0x10000
  SHCOLSTATE_BATCHREAD* = 0x20000
  SHCOLSTATE_NO_GROUPBY* = 0x40000
  SHCOLSTATE_FIXED_WIDTH* = 0x1000
  SHCOLSTATE_NODPISCALE* = 0x2000
  SHCOLSTATE_FIXED_RATIO* = 0x4000
  SHCOLSTATE_DISPLAYMASK* = 0xf000
  SCALE_100_PERCENT* = 100
  SCALE_140_PERCENT* = 140
  SCALE_180_PERCENT* = 180
  DOCMISC_CANCREATEMULTIPLEVIEWS* = 1
  DOCMISC_SUPPORTCOMPLEXRECTANGLES* = 2
  DOCMISC_CANTOPENEDIT* = 4
  DOCMISC_NOFILESUPPORT* = 8
  IID_IOleDocument* = DEFINE_GUID("b722bcc5-4e68-101b-a2bc-00aa00404770")
  IID_IOleDocumentSite* = DEFINE_GUID("b722bcc7-4e68-101b-a2bc-00aa00404770")
  IID_IOleDocumentView* = DEFINE_GUID("b722bcc6-4e68-101b-a2bc-00aa00404770")
  IID_IEnumOleDocumentViews* = DEFINE_GUID("b722bcc8-4e68-101b-a2bc-00aa00404770")
  IID_IContinueCallback* = DEFINE_GUID("b722bcca-4e68-101b-a2bc-00aa00404770")
  PRINTFLAG_MAYBOTHERUSER* = 1
  PRINTFLAG_PROMPTUSER* = 2
  PRINTFLAG_USERMAYCHANGEPRINTER* = 4
  PRINTFLAG_RECOMPOSETODEVICE* = 8
  PRINTFLAG_DONTACTUALLYPRINT* = 16
  PRINTFLAG_FORCEPROPERTIES* = 32
  PRINTFLAG_PRINTTOFILE* = 64
  IID_IPrint* = DEFINE_GUID("b722bcc9-4e68-101b-a2bc-00aa00404770")
  OLECMDF_SUPPORTED* = 0x1
  OLECMDF_ENABLED* = 0x2
  OLECMDF_LATCHED* = 0x4
  OLECMDF_NINCHED* = 0x8
  OLECMDF_INVISIBLE* = 0x10
  OLECMDF_DEFHIDEONCTXTMENU* = 0x20
  OLECMDTEXTF_NONE* = 0
  OLECMDTEXTF_NAME* = 1
  OLECMDTEXTF_STATUS* = 2
  OLECMDEXECOPT_DODEFAULT* = 0
  OLECMDEXECOPT_PROMPTUSER* = 1
  OLECMDEXECOPT_DONTPROMPTUSER* = 2
  OLECMDEXECOPT_SHOWHELP* = 3
  OLECMDID_OPEN* = 1
  OLECMDID_NEW* = 2
  OLECMDID_SAVE* = 3
  OLECMDID_SAVEAS* = 4
  OLECMDID_SAVECOPYAS* = 5
  OLECMDID_PRINT* = 6
  OLECMDID_PRINTPREVIEW* = 7
  OLECMDID_PAGESETUP* = 8
  OLECMDID_SPELL* = 9
  OLECMDID_PROPERTIES* = 10
  OLECMDID_CUT* = 11
  OLECMDID_COPY* = 12
  OLECMDID_PASTE* = 13
  OLECMDID_PASTESPECIAL* = 14
  OLECMDID_UNDO* = 15
  OLECMDID_REDO* = 16
  OLECMDID_SELECTALL* = 17
  OLECMDID_CLEARSELECTION* = 18
  OLECMDID_ZOOM* = 19
  OLECMDID_GETZOOMRANGE* = 20
  OLECMDID_UPDATECOMMANDS* = 21
  OLECMDID_REFRESH* = 22
  OLECMDID_STOP* = 23
  OLECMDID_HIDETOOLBARS* = 24
  OLECMDID_SETPROGRESSMAX* = 25
  OLECMDID_SETPROGRESSPOS* = 26
  OLECMDID_SETPROGRESSTEXT* = 27
  OLECMDID_SETTITLE* = 28
  OLECMDID_SETDOWNLOADSTATE* = 29
  OLECMDID_STOPDOWNLOAD* = 30
  OLECMDID_ONTOOLBARACTIVATED* = 31
  OLECMDID_FIND* = 32
  OLECMDID_DELETE* = 33
  OLECMDID_HTTPEQUIV* = 34
  OLECMDID_HTTPEQUIV_DONE* = 35
  OLECMDID_ENABLE_INTERACTION* = 36
  OLECMDID_ONUNLOAD* = 37
  OLECMDID_PROPERTYBAG2* = 38
  OLECMDID_PREREFRESH* = 39
  OLECMDID_SHOWSCRIPTERROR* = 40
  OLECMDID_SHOWMESSAGE* = 41
  OLECMDID_SHOWFIND* = 42
  OLECMDID_SHOWPAGESETUP* = 43
  OLECMDID_SHOWPRINT* = 44
  OLECMDID_CLOSE* = 45
  OLECMDID_ALLOWUILESSSAVEAS* = 46
  OLECMDID_DONTDOWNLOADCSS* = 47
  OLECMDID_UPDATEPAGESTATUS* = 48
  OLECMDID_PRINT2* = 49
  OLECMDID_PRINTPREVIEW2* = 50
  OLECMDID_SETPRINTTEMPLATE* = 51
  OLECMDID_GETPRINTTEMPLATE* = 52
  OLECMDID_PAGEACTIONBLOCKED* = 55
  OLECMDID_PAGEACTIONUIQUERY* = 56
  OLECMDID_FOCUSVIEWCONTROLS* = 57
  OLECMDID_FOCUSVIEWCONTROLSQUERY* = 58
  OLECMDID_SHOWPAGEACTIONMENU* = 59
  OLECMDID_ADDTRAVELENTRY* = 60
  OLECMDID_UPDATETRAVELENTRY* = 61
  OLECMDID_UPDATEBACKFORWARDSTATE* = 62
  OLECMDID_OPTICAL_ZOOM* = 63
  OLECMDID_OPTICAL_GETZOOMRANGE* = 64
  OLECMDID_WINDOWSTATECHANGED* = 65
  OLECMDID_ACTIVEXINSTALLSCOPE* = 66
  OLECMDID_UPDATETRAVELENTRY_DATARECOVERY* = 67
  OLECMDID_SHOWTASKDLG* = 68
  OLECMDID_POPSTATEEVENT* = 69
  OLECMDID_VIEWPORT_MODE* = 70
  OLECMDID_LAYOUT_VIEWPORT_WIDTH* = 71
  OLECMDID_VISUAL_VIEWPORT_EXCLUDE_BOTTOM* = 72
  OLECMDID_USER_OPTICAL_ZOOM* = 73
  OLECMDID_PAGEAVAILABLE* = 74
  OLECMDID_GETUSERSCALABLE* = 75
  OLECMDID_UPDATE_CARET* = 76
  OLECMDID_ENABLE_VISIBILITY* = 77
  OLECMDID_MEDIA_PLAYBACK* = 78
  MEDIAPLAYBACK_RESUME* = 0
  MEDIAPLAYBACK_PAUSE* = 1
  OLECMDERR_E_FIRST* = OLE_E_LAST+1
  OLECMDERR_E_NOTSUPPORTED* = OLECMDERR_E_FIRST
  OLECMDERR_E_DISABLED* = OLECMDERR_E_FIRST+1
  OLECMDERR_E_NOHELP* = OLECMDERR_E_FIRST+2
  OLECMDERR_E_CANCELED* = OLECMDERR_E_FIRST+3
  OLECMDERR_E_UNKNOWNGROUP* = OLECMDERR_E_FIRST+4
  MSOCMDERR_E_FIRST* = OLECMDERR_E_FIRST
  MSOCMDERR_E_NOTSUPPORTED* = OLECMDERR_E_NOTSUPPORTED
  MSOCMDERR_E_DISABLED* = OLECMDERR_E_DISABLED
  MSOCMDERR_E_NOHELP* = OLECMDERR_E_NOHELP
  MSOCMDERR_E_CANCELED* = OLECMDERR_E_CANCELED
  MSOCMDERR_E_UNKNOWNGROUP* = OLECMDERR_E_UNKNOWNGROUP
  OLECMD_TASKDLGID_ONBEFOREUNLOAD* = 1
  OLECMDARGINDEX_SHOWPAGEACTIONMENU_HWND* = 0
  OLECMDARGINDEX_SHOWPAGEACTIONMENU_X* = 1
  OLECMDARGINDEX_SHOWPAGEACTIONMENU_Y* = 2
  OLECMDARGINDEX_ACTIVEXINSTALL_PUBLISHER* = 0
  OLECMDARGINDEX_ACTIVEXINSTALL_DISPLAYNAME* = 1
  OLECMDARGINDEX_ACTIVEXINSTALL_CLSID* = 2
  OLECMDARGINDEX_ACTIVEXINSTALL_INSTALLSCOPE* = 3
  OLECMDARGINDEX_ACTIVEXINSTALL_SOURCEURL* = 4
  INSTALL_SCOPE_INVALID* = 0
  INSTALL_SCOPE_MACHINE* = 1
  INSTALL_SCOPE_USER* = 2
  IGNOREMIME_PROMPT* = 0x1
  IGNOREMIME_TEXT* = 0x2
  WPCSETTING_LOGGING_ENABLED* = 0x1
  WPCSETTING_FILEDOWNLOAD_BLOCKED* = 0x2
  IID_IOleCommandTarget* = DEFINE_GUID("b722bccb-4e68-101b-a2bc-00aa00404770")
  OLECMDIDF_REFRESH_NORMAL* = 0
  OLECMDIDF_REFRESH_IFEXPIRED* = 1
  OLECMDIDF_REFRESH_CONTINUE* = 2
  OLECMDIDF_REFRESH_COMPLETELY* = 3
  OLECMDIDF_REFRESH_NO_CACHE* = 4
  OLECMDIDF_REFRESH_RELOAD* = 5
  OLECMDIDF_REFRESH_LEVELMASK* = 0x00FF
  OLECMDIDF_REFRESH_CLEARUSERINPUT* = 0x1000
  OLECMDIDF_REFRESH_PROMPTIFOFFLINE* = 0x2000
  OLECMDIDF_REFRESH_THROUGHSCRIPT* = 0x4000
  OLECMDIDF_REFRESH_SKIPBEFOREUNLOADEVENT* = 0x8000
  OLECMDIDF_REFRESH_PAGEACTION_ACTIVEXINSTALL* = 0x00010000
  OLECMDIDF_REFRESH_PAGEACTION_FILEDOWNLOAD* = 0x00020000
  OLECMDIDF_REFRESH_PAGEACTION_LOCALMACHINE* = 0x00040000
  OLECMDIDF_REFRESH_PAGEACTION_POPUPWINDOW* = 0x00080000
  OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNLOCALMACHINE* = 0x00100000
  OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNTRUSTED* = 0x00200000
  OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTRANET* = 0x00400000
  OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTERNET* = 0x00800000
  OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNRESTRICTED* = 0x01000000
  OLECMDIDF_REFRESH_PAGEACTION_MIXEDCONTENT* = 0x02000000
  OLECMDIDF_REFRESH_PAGEACTION_INVALID_CERT* = 0x04000000
  OLECMDIDF_PAGEACTION_FILEDOWNLOAD* = 0x00000001
  OLECMDIDF_PAGEACTION_ACTIVEXINSTALL* = 0x00000002
  OLECMDIDF_PAGEACTION_ACTIVEXTRUSTFAIL* = 0x00000004
  OLECMDIDF_PAGEACTION_ACTIVEXUSERDISABLE* = 0x00000008
  OLECMDIDF_PAGEACTION_ACTIVEXDISALLOW* = 0x00000010
  OLECMDIDF_PAGEACTION_ACTIVEXUNSAFE* = 0x00000020
  OLECMDIDF_PAGEACTION_POPUPWINDOW* = 0x00000040
  OLECMDIDF_PAGEACTION_LOCALMACHINE* = 0x00000080
  OLECMDIDF_PAGEACTION_MIMETEXTPLAIN* = 0x00000100
  OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE* = 0x00000200
  OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXINSTALL* = 0x00000200
  OLECMDIDF_PAGEACTION_PROTLOCKDOWNLOCALMACHINE* = 0x00000400
  OLECMDIDF_PAGEACTION_PROTLOCKDOWNTRUSTED* = 0x00000800
  OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTRANET* = 0x00001000
  OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTERNET* = 0x00002000
  OLECMDIDF_PAGEACTION_PROTLOCKDOWNRESTRICTED* = 0x00004000
  OLECMDIDF_PAGEACTION_PROTLOCKDOWNDENY* = 0x00008000
  OLECMDIDF_PAGEACTION_POPUPALLOWED* = 0x00010000
  OLECMDIDF_PAGEACTION_SCRIPTPROMPT* = 0x00020000
  OLECMDIDF_PAGEACTION_ACTIVEXUSERAPPROVAL* = 0x00040000
  OLECMDIDF_PAGEACTION_MIXEDCONTENT* = 0x00080000
  OLECMDIDF_PAGEACTION_INVALID_CERT* = 0x00100000
  OLECMDIDF_PAGEACTION_INTRANETZONEREQUEST* = 0x00200000
  OLECMDIDF_PAGEACTION_XSSFILTERED* = 0x00400000
  OLECMDIDF_PAGEACTION_SPOOFABLEIDNHOST* = 0x00800000
  OLECMDIDF_PAGEACTION_ACTIVEX_EPM_INCOMPATIBLE* = 0x01000000
  OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXUSERAPPROVAL* = 0x02000000
  OLECMDIDF_PAGEACTION_WPCBLOCKED* = 0x04000000
  OLECMDIDF_PAGEACTION_WPCBLOCKED_ACTIVEX* = 0x08000000
  OLECMDIDF_PAGEACTION_EXTENSION_COMPAT_BLOCKED* = 0x10000000
  OLECMDIDF_PAGEACTION_NORESETACTIVEX* = 0x20000000
  OLECMDIDF_PAGEACTION_GENERIC_STATE* = 0x40000000
  OLECMDIDF_PAGEACTION_RESET* = int32 0x80000000'i32
  OLECMDIDF_BROWSERSTATE_EXTENSIONSOFF* = 0x00000001
  OLECMDIDF_BROWSERSTATE_IESECURITY* = 0x00000002
  OLECMDIDF_BROWSERSTATE_PROTECTEDMODE_OFF* = 0x00000004
  OLECMDIDF_BROWSERSTATE_RESET* = 0x00000008
  OLECMDIDF_BROWSERSTATE_REQUIRESACTIVEX* = 0x00000010
  OLECMDIDF_OPTICAL_ZOOM_NOPERSIST* = 0x00000001
  OLECMDIDF_OPTICAL_ZOOM_NOLAYOUT* = 0x00000010
  PAGEACTION_UI_DEFAULT* = 0
  PAGEACTION_UI_MODAL* = 1
  PAGEACTION_UI_MODELESS* = 2
  PAGEACTION_UI_SILENT* = 3
  OLECMDIDF_WINDOWSTATE_USERVISIBLE* = 0x00000001
  OLECMDIDF_WINDOWSTATE_ENABLED* = 0x00000002
  OLECMDIDF_WINDOWSTATE_USERVISIBLE_VALID* = 0x00010000
  OLECMDIDF_WINDOWSTATE_ENABLED_VALID* = 0x00020000
  OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH* = 0x00000001
  OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM* = 0x00000002
  OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH_VALID* = 0x00010000
  OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM_VALID* = 0x00020000
  IID_IMsoDocument* = IID_IOleDocument
  IID_IMsoDocumentSite* = IID_IOleDocumentSite
  IID_IMsoView* = IID_IOleDocumentView
  IID_IEnumMsoView* = IID_IEnumOleDocumentViews
  IID_IMsoCommandTarget* = IID_IOleCommandTarget
  MSOCMDF_SUPPORTED* = OLECMDF_SUPPORTED
  MSOCMDF_ENABLED* = OLECMDF_ENABLED
  MSOCMDF_LATCHED* = OLECMDF_LATCHED
  MSOCMDF_NINCHED* = OLECMDF_NINCHED
  MSOCMDTEXTF_NONE* = OLECMDTEXTF_NONE
  MSOCMDTEXTF_NAME* = OLECMDTEXTF_NAME
  MSOCMDTEXTF_STATUS* = OLECMDTEXTF_STATUS
  MSOCMDEXECOPT_DODEFAULT* = OLECMDEXECOPT_DODEFAULT
  MSOCMDEXECOPT_PROMPTUSER* = OLECMDEXECOPT_PROMPTUSER
  MSOCMDEXECOPT_DONTPROMPTUSER* = OLECMDEXECOPT_DONTPROMPTUSER
  MSOCMDEXECOPT_SHOWHELP* = OLECMDEXECOPT_SHOWHELP
  MSOCMDID_OPEN* = OLECMDID_OPEN
  MSOCMDID_NEW* = OLECMDID_NEW
  MSOCMDID_SAVE* = OLECMDID_SAVE
  MSOCMDID_SAVEAS* = OLECMDID_SAVEAS
  MSOCMDID_SAVECOPYAS* = OLECMDID_SAVECOPYAS
  MSOCMDID_PRINT* = OLECMDID_PRINT
  MSOCMDID_PRINTPREVIEW* = OLECMDID_PRINTPREVIEW
  MSOCMDID_PAGESETUP* = OLECMDID_PAGESETUP
  MSOCMDID_SPELL* = OLECMDID_SPELL
  MSOCMDID_PROPERTIES* = OLECMDID_PROPERTIES
  MSOCMDID_CUT* = OLECMDID_CUT
  MSOCMDID_COPY* = OLECMDID_COPY
  MSOCMDID_PASTE* = OLECMDID_PASTE
  MSOCMDID_PASTESPECIAL* = OLECMDID_PASTESPECIAL
  MSOCMDID_UNDO* = OLECMDID_UNDO
  MSOCMDID_REDO* = OLECMDID_REDO
  MSOCMDID_SELECTALL* = OLECMDID_SELECTALL
  MSOCMDID_CLEARSELECTION* = OLECMDID_CLEARSELECTION
  MSOCMDID_ZOOM* = OLECMDID_ZOOM
  MSOCMDID_GETZOOMRANGE* = OLECMDID_GETZOOMRANGE
  IID_IZoomEvents* = DEFINE_GUID("41b68150-904c-4e17-a0ba-a438182e359d")
  IID_IProtectFocus* = DEFINE_GUID("d81f90a3-8156-44f7-ad28-5abb87003274")
  SID_SProtectFocus* = IID_IProtectFocus
  IID_IProtectedModeMenuServices* = DEFINE_GUID("73c105ee-9dff-4a07-b83c-7eff290c266e")
  LIBID_SHDocVw* = DEFINE_GUID("eab22ac0-30c1-11cf-a7eb-0000c05bae0b")
  navOpenInNewWindow* = 0x1
  navNoHistory* = 0x2
  navNoReadFromCache* = 0x4
  navNoWriteToCache* = 0x8
  navAllowAutosearch* = 0x10
  navBrowserBar* = 0x20
  navHyperlink* = 0x40
  navEnforceRestricted* = 0x80
  REFRESH_NORMAL* = 0
  REFRESH_IFEXPIRED* = 1
  REFRESH_COMPLETELY* = 3
  IID_IWebBrowser* = DEFINE_GUID("eab22ac1-30c1-11cf-a7eb-0000c05bae0b")
  DIID_DWebBrowserEvents* = DEFINE_GUID("eab22ac2-30c1-11cf-a7eb-0000c05bae0b")
  IID_DWebBrowserEvents* = DEFINE_GUID("eab22ac2-30c1-11cf-a7eb-0000c05bae0b")
  CSC_UPDATECOMMANDS* = -1
  CSC_NAVIGATEFORWARD* = 1
  CSC_NAVIGATEBACK* = 2
  IID_IWebBrowserApp* = DEFINE_GUID("0002df05-0000-0000-c000-000000000046")
  IID_IWebBrowser2* = DEFINE_GUID("d30c1661-cdaf-11d0-8a3e-00c04fc9e26e")
  secureLockIconUnsecure* = 0
  secureLockIconMixed* = 1
  secureLockIconSecureUnknownBits* = 2
  secureLockIconSecure40Bit* = 3
  secureLockIconSecure56Bit* = 4
  secureLockIconSecureFortezza* = 5
  secureLockIconSecure128Bit* = 6
  DIID_DWebBrowserEvents2* = DEFINE_GUID("34a715a0-6587-11d0-924a-0020afc7ac4d")
  IID_DWebBrowserEvents2* = DEFINE_GUID("34a715a0-6587-11d0-924a-0020afc7ac4d")
  CLSID_WebBrowser_V1* = DEFINE_GUID("eab22ac3-30c1-11cf-a7eb-0000c05bae0b")
  CLSID_WebBrowser* = DEFINE_GUID("8856f961-340a-11d0-a96b-00c04fd705a2")
  CLSID_InternetExplorer* = DEFINE_GUID("0002df01-0000-0000-c000-000000000046")
  CLSID_ShellBrowserWindow* = DEFINE_GUID("c08afd90-f2a1-11d1-8455-00a0c91f3880")
  SWC_EXPLORER* = 0
  SWC_BROWSER* = 1
  SWC_3RDPARTY* = 2
  SWC_CALLBACK* = 4
  SWC_DESKTOP* = 8
  SWFO_NEEDDISPATCH* = 1
  SWFO_INCLUDEPENDING* = 2
  SWFO_COOKIEPASSED* = 4
  DIID_DShellWindowsEvents* = DEFINE_GUID("fe4106e0-399a-11d0-a48c-00a0c90a8f39")
  IID_DShellWindowsEvents* = DEFINE_GUID("fe4106e0-399a-11d0-a48c-00a0c90a8f39")
  IID_IShellWindows* = DEFINE_GUID("85cb6900-4d95-11cf-960c-0080c7f4ee85")
  CLSID_ShellWindows* = DEFINE_GUID("9ba05972-f6a8-11cf-a442-00a0c90a8f39")
  IID_IShellUIHelper* = DEFINE_GUID("729fe2f8-1ea8-11d1-8f85-00c04fc2fbe1")
  IID_IShellUIHelper2* = DEFINE_GUID("a7fe6eda-1932-4281-b881-87b31b8bc52c")
  CLSID_ShellUIHelper* = DEFINE_GUID("64ab4bb7-111e-11d1-8f79-00c04fc2fbe1")
  DIID_DShellNameSpaceEvents* = DEFINE_GUID("55136806-b2de-11d1-b9f2-00a0c98bc547")
  IID_DShellNameSpaceEvents* = DEFINE_GUID("55136806-b2de-11d1-b9f2-00a0c98bc547")
  IID_IShellFavoritesNameSpace* = DEFINE_GUID("55136804-b2de-11d1-b9f2-00a0c98bc547")
  IID_IShellNameSpace* = DEFINE_GUID("e572d3c9-37be-4ae2-825d-d521763e3108")
  CLSID_ShellShellNameSpace* = DEFINE_GUID("2f2f1f96-2bc1-4b1c-be28-ea3774f4676a")
  CLSID_ShellNameSpace* = DEFINE_GUID("55136805-b2de-11d1-b9f2-00a0c98bc547")
  IID_IScriptErrorList* = DEFINE_GUID("f3470f24-15fd-11d2-bb2e-00805ff7efca")
  CLSID_CScriptErrorList* = DEFINE_GUID("efd01300-160f-11d2-bb2e-00805ff7efca")
  IID_ISearch* = DEFINE_GUID("ba9239a4-3dd5-11d2-bf8b-00c04fb93661")
  IID_ISearches* = DEFINE_GUID("47c922a2-3dd5-11d2-bf8b-00c04fb93661")
  IID_ISearchAssistantOC* = DEFINE_GUID("72423e8f-8011-11d2-be79-00a0c9a83da1")
  IID_ISearchAssistantOC2* = DEFINE_GUID("72423e8f-8011-11d2-be79-00a0c9a83da2")
  IID_ISearchAssistantOC3* = DEFINE_GUID("72423e8f-8011-11d2-be79-00a0c9a83da3")
  DIID_SearchAssistantEvents* = DEFINE_GUID("1611fdda-445b-11d2-85de-00c04fa35c89")
  IID_SearchAssistantEvents* = DEFINE_GUID("1611fdda-445b-11d2-85de-00c04fa35c89")
  CLSID_ShellSearchAssistantOC* = DEFINE_GUID("2e71fd0f-aab1-42c0-9146-6d2c4edcf07d")
  CLSID_SearchAssistantOC* = DEFINE_GUID("b45ff030-4447-11d2-85de-00c04fa35c89")
  DISPID_BEFORENAVIGATE* = 100
  DISPID_NAVIGATECOMPLETE* = 101
  DISPID_STATUSTEXTCHANGE* = 102
  DISPID_QUIT* = 103
  DISPID_DOWNLOADCOMPLETE* = 104
  DISPID_COMMANDSTATECHANGE* = 105
  DISPID_DOWNLOADBEGIN* = 106
  DISPID_NEWWINDOW* = 107
  DISPID_PROGRESSCHANGE* = 108
  DISPID_WINDOWMOVE* = 109
  DISPID_WINDOWRESIZE* = 110
  DISPID_WINDOWACTIVATE* = 111
  DISPID_PROPERTYCHANGE* = 112
  DISPID_TITLECHANGE* = 113
  DISPID_TITLEICONCHANGE* = 114
  DISPID_FRAMEBEFORENAVIGATE* = 200
  DISPID_FRAMENAVIGATECOMPLETE* = 201
  DISPID_FRAMENEWWINDOW* = 204
  DISPID_BEFORENAVIGATE2* = 250
  DISPID_NEWWINDOW2* = 251
  DISPID_NAVIGATECOMPLETE2* = 252
  DISPID_ONQUIT* = 253
  DISPID_ONVISIBLE* = 254
  DISPID_ONTOOLBAR* = 255
  DISPID_ONMENUBAR* = 256
  DISPID_ONSTATUSBAR* = 257
  DISPID_ONFULLSCREEN* = 258
  DISPID_DOCUMENTCOMPLETE* = 259
  DISPID_ONTHEATERMODE* = 260
  DISPID_ONADDRESSBAR* = 261
  DISPID_WINDOWSETRESIZABLE* = 262
  DISPID_WINDOWCLOSING* = 263
  DISPID_WINDOWSETLEFT* = 264
  DISPID_WINDOWSETTOP* = 265
  DISPID_WINDOWSETWIDTH* = 266
  DISPID_WINDOWSETHEIGHT* = 267
  DISPID_CLIENTTOHOSTWINDOW* = 268
  DISPID_SETSECURELOCKICON* = 269
  DISPID_FILEDOWNLOAD* = 270
  DISPID_NAVIGATEERROR* = 271
  DISPID_PRIVACYIMPACTEDSTATECHANGE* = 272
  DISPID_NEWWINDOW3* = 273
  DISPID_VIEWUPDATE* = 281
  DISPID_SETPHISHINGFILTERSTATUS* = 282
  DISPID_WINDOWSTATECHANGED* = 283
  DISPID_NEWPROCESS* = 284
  DISPID_THIRDPARTYURLBLOCKED* = 285
  DISPID_REDIRECTXDOMAINBLOCKED* = 286
  DISPID_PRINTTEMPLATEINSTANTIATION* = 225
  DISPID_PRINTTEMPLATETEARDOWN* = 226
  DISPID_UPDATEPAGESTATUS* = 227
  DISPID_WINDOWREGISTERED* = 200
  DISPID_WINDOWREVOKED* = 201
  DISPID_RESETFIRSTBOOTMODE* = 1
  DISPID_RESETSAFEMODE* = 2
  DISPID_REFRESHOFFLINEDESKTOP* = 3
  DISPID_ADDFAVORITE* = 4
  DISPID_ADDCHANNEL* = 5
  DISPID_ADDDESKTOPCOMPONENT* = 6
  DISPID_ISSUBSCRIBED* = 7
  DISPID_NAVIGATEANDFIND* = 8
  DISPID_IMPORTEXPORTFAVORITES* = 9
  DISPID_AUTOCOMPLETESAVEFORM* = 10
  DISPID_AUTOSCAN* = 11
  DISPID_AUTOCOMPLETEATTACH* = 12
  DISPID_SHOWBROWSERUI* = 13
  DISPID_ADDSEARCHPROVIDER* = 14
  DISPID_RUNONCESHOWN* = 15
  DISPID_SKIPRUNONCE* = 16
  DISPID_CUSTOMIZESETTINGS* = 17
  DISPID_SQMENABLED* = 18
  DISPID_PHISHINGENABLED* = 19
  DISPID_BRANDIMAGEURI* = 20
  DISPID_SKIPTABSWELCOME* = 21
  DISPID_DIAGNOSECONNECTION* = 22
  DISPID_CUSTOMIZECLEARTYPE* = 23
  DISPID_ISSEARCHPROVIDERINSTALLED* = 24
  DISPID_ISSEARCHMIGRATED* = 25
  DISPID_DEFAULTSEARCHPROVIDER* = 26
  DISPID_RUNONCEREQUIREDSETTINGSCOMPLETE* = 27
  DISPID_RUNONCEHASSHOWN* = 28
  DISPID_SEARCHGUIDEURL* = 29
  DISPID_ADDSERVICE* = 30
  DISPID_ISSERVICEINSTALLED* = 31
  DISPID_ADDTOFAVORITESBAR* = 32
  DISPID_BUILDNEWTABPAGE* = 33
  DISPID_SETRECENTLYCLOSEDVISIBLE* = 34
  DISPID_SETACTIVITIESVISIBLE* = 35
  DISPID_CONTENTDISCOVERYRESET* = 36
  DISPID_INPRIVATEFILTERINGENABLED* = 37
  DISPID_SUGGESTEDSITESENABLED* = 38
  DISPID_ENABLESUGGESTEDSITES* = 39
  DISPID_NAVIGATETOSUGGESTEDSITES* = 40
  DISPID_SHOWTABSHELP* = 41
  DISPID_SHOWINPRIVATEHELP* = 42
  DISPID_SHELLUIHELPERLAST* = 43
  DISPID_ADVANCEERROR* = 10
  DISPID_RETREATERROR* = 11
  DISPID_CANADVANCEERROR* = 12
  DISPID_CANRETREATERROR* = 13
  DISPID_GETERRORLINE* = 14
  DISPID_GETERRORCHAR* = 15
  DISPID_GETERRORCODE* = 16
  DISPID_GETERRORMSG* = 17
  DISPID_GETERRORURL* = 18
  DISPID_GETDETAILSSTATE* = 19
  DISPID_SETDETAILSSTATE* = 20
  DISPID_GETPERERRSTATE* = 21
  DISPID_SETPERERRSTATE* = 22
  DISPID_GETALWAYSSHOWLOCKSTATE* = 23
  DISPID_FAVSELECTIONCHANGE* = 1
  DISPID_SELECTIONCHANGE* = 2
  DISPID_DOUBLECLICK* = 3
  DISPID_INITIALIZED* = 4
  DISPID_MOVESELECTIONUP* = 1
  DISPID_MOVESELECTIONDOWN* = 2
  DISPID_RESETSORT* = 3
  DISPID_NEWFOLDER* = 4
  DISPID_SYNCHRONIZE* = 5
  DISPID_IMPORT* = 6
  DISPID_EXPORT* = 7
  DISPID_INVOKECONTEXTMENU* = 8
  DISPID_MOVESELECTIONTO* = 9
  DISPID_SUBSCRIPTIONSENABLED* = 10
  DISPID_CREATESUBSCRIPTION* = 11
  DISPID_DELETESUBSCRIPTION* = 12
  DISPID_SETROOT* = 13
  DISPID_ENUMOPTIONS* = 14
  DISPID_SELECTEDITEM* = 15
  DISPID_ROOT* = 16
  DISPID_DEPTH* = 17
  DISPID_MODE* = 18
  DISPID_FLAGS* = 19
  DISPID_TVFLAGS* = 20
  DISPID_NSCOLUMNS* = 21
  DISPID_COUNTVIEWTYPES* = 22
  DISPID_SETVIEWTYPE* = 23
  DISPID_SELECTEDITEMS* = 24
  DISPID_EXPAND* = 25
  DISPID_UNSELECTALL* = 26
  CT_AND_CONDITION* = 0
  CT_OR_CONDITION* = 1
  CT_NOT_CONDITION* = 2
  CT_LEAF_CONDITION* = 3
  COP_IMPLICIT* = 0
  COP_EQUAL* = 1
  COP_NOTEQUAL* = 2
  COP_LESSTHAN* = 3
  COP_GREATERTHAN* = 4
  COP_LESSTHANOREQUAL* = 5
  COP_GREATERTHANOREQUAL* = 6
  COP_VALUE_STARTSWITH* = 7
  COP_VALUE_ENDSWITH* = 8
  COP_VALUE_CONTAINS* = 9
  COP_VALUE_NOTCONTAINS* = 10
  COP_DOSWILDCARDS* = 11
  COP_WORD_EQUAL* = 12
  COP_WORD_STARTSWITH* = 13
  COP_APPLICATION_SPECIFIC* = 14
  IID_IRichChunk* = DEFINE_GUID("4fdef69c-dbc9-454e-9910-b34f3c64b510")
  IID_ICondition* = DEFINE_GUID("0fc988d4-c935-4b97-a973-46282ea175c8")
  IID_ICondition2* = DEFINE_GUID("0db8851d-2e5b-47eb-9208-d28c325a01d7")
  IID_IInitializeWithFile* = DEFINE_GUID("b7d14566-0509-4cce-a71f-0a554233bd9b")
  IID_IInitializeWithStream* = DEFINE_GUID("b824b49d-22ac-4161-ac8a-9916e8fa3f7f")
  IID_IPropertyStore* = DEFINE_GUID("886d8eeb-8cf2-4446-8d02-cdba1dbdcf99")
  IID_INamedPropertyStore* = DEFINE_GUID("71604b0f-97b0-4764-8577-2f13e98a1422")
  GPS_DEFAULT* = 0x0
  GPS_HANDLERPROPERTIESONLY* = 0x1
  GPS_READWRITE* = 0x2
  GPS_TEMPORARY* = 0x4
  GPS_FASTPROPERTIESONLY* = 0x8
  GPS_OPENSLOWITEM* = 0x10
  GPS_DELAYCREATION* = 0x20
  GPS_BESTEFFORT* = 0x40
  GPS_NO_OPLOCK* = 0x80
  GPS_PREFERQUERYPROPERTIES* = 0x100
  GPS_MASK_VALID* = 0x1ff
  IID_IObjectWithPropertyKey* = DEFINE_GUID("fc0ca0a7-c316-4fd2-9031-3e628e6d4f23")
  PKA_SET* = 0
  PKA_APPEND* = 1
  PKA_DELETE* = 2
  IID_IPropertyChange* = DEFINE_GUID("f917bc8a-1bba-4478-a245-1bde03eb9431")
  IID_IPropertyChangeArray* = DEFINE_GUID("380f5cad-1b5e-42f2-805d-637fd392d31e")
  IID_IPropertyStoreCapabilities* = DEFINE_GUID("c8e2d566-186e-4d49-bf41-6909ead56acc")
  PSC_NORMAL* = 0
  PSC_NOTINSOURCE* = 1
  PSC_DIRTY* = 2
  PSC_READONLY* = 3
  IID_IPropertyStoreCache* = DEFINE_GUID("3017056d-9a91-4e90-937d-746c72abbf4f")
  PET_DISCRETEVALUE* = 0
  PET_RANGEDVALUE* = 1
  PET_DEFAULTVALUE* = 2
  PET_ENDRANGE* = 3
  IID_IPropertyEnumType* = DEFINE_GUID("11e1fbf9-2d56-4a6b-8db3-7cd193a471f2")
  IID_IPropertyEnumType2* = DEFINE_GUID("9b6e051c-5ddd-4321-9070-fe2acb55e794")
  IID_IPropertyEnumTypeList* = DEFINE_GUID("a99400f4-3d84-4557-94ba-1242fb2cc9a6")
  PDTF_DEFAULT* = 0x0
  PDTF_MULTIPLEVALUES* = 0x1
  PDTF_ISINNATE* = 0x2
  PDTF_ISGROUP* = 0x4
  PDTF_CANGROUPBY* = 0x8
  PDTF_CANSTACKBY* = 0x10
  PDTF_ISTREEPROPERTY* = 0x20
  PDTF_INCLUDEINFULLTEXTQUERY* = 0x40
  PDTF_ISVIEWABLE* = 0x80
  PDTF_ISQUERYABLE* = 0x100
  PDTF_CANBEPURGED* = 0x200
  PDTF_SEARCHRAWVALUE* = 0x400
  PDTF_ISSYSTEMPROPERTY* = 0x80000000'i32
  PDTF_MASK_ALL* = 0x800007ff'i32
  PDVF_DEFAULT* = 0x0
  PDVF_CENTERALIGN* = 0x1
  PDVF_RIGHTALIGN* = 0x2
  PDVF_BEGINNEWGROUP* = 0x4
  PDVF_FILLAREA* = 0x8
  PDVF_SORTDESCENDING* = 0x10
  PDVF_SHOWONLYIFPRESENT* = 0x20
  PDVF_SHOWBYDEFAULT* = 0x40
  PDVF_SHOWINPRIMARYLIST* = 0x80
  PDVF_SHOWINSECONDARYLIST* = 0x100
  PDVF_HIDELABEL* = 0x200
  PDVF_HIDDEN* = 0x800
  PDVF_CANWRAP* = 0x1000
  PDVF_MASK_ALL* = 0x1bff
  PDDT_STRING* = 0
  PDDT_NUMBER* = 1
  PDDT_BOOLEAN* = 2
  PDDT_DATETIME* = 3
  PDDT_ENUMERATED* = 4
  PDGR_DISCRETE* = 0
  PDGR_ALPHANUMERIC* = 1
  PDGR_SIZE* = 2
  PDGR_DYNAMIC* = 3
  PDGR_DATE* = 4
  PDGR_PERCENT* = 5
  PDGR_ENUMERATED* = 6
  PDFF_DEFAULT* = 0x0
  PDFF_PREFIXNAME* = 0x1
  PDFF_FILENAME* = 0x2
  PDFF_ALWAYSKB* = 0x4
  PDFF_RESERVED_RIGHTTOLEFT* = 0x8
  PDFF_SHORTTIME* = 0x10
  PDFF_LONGTIME* = 0x20
  PDFF_HIDETIME* = 0x40
  PDFF_SHORTDATE* = 0x80
  PDFF_LONGDATE* = 0x100
  PDFF_HIDEDATE* = 0x200
  PDFF_RELATIVEDATE* = 0x400
  PDFF_USEEDITINVITATION* = 0x800
  PDFF_READONLY* = 0x1000
  PDFF_NOAUTOREADINGORDER* = 0x2000
  PDSD_GENERAL* = 0
  PDSD_A_Z* = 1
  PDSD_LOWEST_HIGHEST* = 2
  PDSD_SMALLEST_BIGGEST* = 3
  PDSD_OLDEST_NEWEST* = 4
  PDRDT_GENERAL* = 0
  PDRDT_DATE* = 1
  PDRDT_SIZE* = 2
  PDRDT_COUNT* = 3
  PDRDT_REVISION* = 4
  PDRDT_LENGTH* = 5
  PDRDT_DURATION* = 6
  PDRDT_SPEED* = 7
  PDRDT_RATE* = 8
  PDRDT_RATING* = 9
  PDRDT_PRIORITY* = 10
  PDAT_DEFAULT* = 0
  PDAT_FIRST* = 1
  PDAT_SUM* = 2
  PDAT_AVERAGE* = 3
  PDAT_DATERANGE* = 4
  PDAT_UNION* = 5
  PDAT_MAX* = 6
  PDAT_MIN* = 7
  PDCOT_NONE* = 0
  PDCOT_STRING* = 1
  PDCOT_SIZE* = 2
  PDCOT_DATETIME* = 3
  PDCOT_BOOLEAN* = 4
  PDCOT_NUMBER* = 5
  IID_IPropertyDescription* = DEFINE_GUID("6f79d558-3e96-4549-a1d1-7d75d2288814")
  IID_IPropertyDescription2* = DEFINE_GUID("57d2eded-5062-400e-b107-5dae79fe57a6")
  IID_IPropertyDescriptionAliasInfo* = DEFINE_GUID("f67104fc-2af9-46fd-b32d-243c1404f3d1")
  PDSIF_DEFAULT* = 0x0
  PDSIF_ININVERTEDINDEX* = 0x1
  PDSIF_ISCOLUMN* = 0x2
  PDSIF_ISCOLUMNSPARSE* = 0x4
  PDSIF_ALWAYSINCLUDE* = 0x8
  PDSIF_USEFORTYPEAHEAD* = 0x10
  PDCIT_NONE* = 0
  PDCIT_ONDISK* = 1
  PDCIT_INMEMORY* = 2
  PDCIT_ONDEMAND* = 3
  PDCIT_ONDISKALL* = 4
  PDCIT_ONDISKVECTOR* = 5
  IID_IPropertyDescriptionSearchInfo* = DEFINE_GUID("078f91bd-29a2-440f-924e-46a291524520")
  IID_IPropertyDescriptionRelatedPropertyInfo* = DEFINE_GUID("507393f4-2a3d-4a60-b59e-d9c75716c2dd")
  PDEF_ALL* = 0
  PDEF_SYSTEM* = 1
  PDEF_NONSYSTEM* = 2
  PDEF_VIEWABLE* = 3
  PDEF_QUERYABLE* = 4
  PDEF_INFULLTEXTQUERY* = 5
  PDEF_COLUMN* = 6
  IID_IPropertySystem* = DEFINE_GUID("ca724e8a-c3e6-442b-88a4-6fb0db8035a3")
  IID_IPropertyDescriptionList* = DEFINE_GUID("1f9fc1d0-c39b-4b26-817f-011967d3440e")
  IID_IPropertyStoreFactory* = DEFINE_GUID("bc110b6d-57e8-4148-a9c6-91015ab2f3a5")
  IID_IDelayedPropertyStoreFactory* = DEFINE_GUID("40d4577f-e237-4bdb-bd69-58f089431b6a")
  FPSPS_DEFAULT* = 0x0
  FPSPS_READONLY* = 0x1
  FPSPS_TREAT_NEW_VALUES_AS_DIRTY* = 0x2
  IID_IPersistSerializedPropStorage* = DEFINE_GUID("e318ad57-0aa0-450f-aca5-6fab7103d917")
  IID_IPersistSerializedPropStorage2* = DEFINE_GUID("77effa68-4f98-4366-ba72-573b3d880571")
  IID_IPropertySystemChangeNotify* = DEFINE_GUID("fa955fd9-38be-4879-a6ce-824cf52d609f")
  IID_ICreateObject* = DEFINE_GUID("75121952-e0d0-43e5-9380-1d80483acf72")
  PKEY_PIDSTR_MAX* = 10
  GUIDSTRING_MAX* = 39
  PKEYSTR_MAX* = GUIDSTRING_MAX+1+PKEY_PIDSTR_MAX
  LIBID_PropSysObjects* = DEFINE_GUID("2cda3294-6c4f-4020-b161-27c530c81fa6")
  CLSID_InMemoryPropertyStore* = DEFINE_GUID("9a02e012-6303-4e1e-b9a1-630f802592c5")
  CLSID_PropertySystem* = DEFINE_GUID("b8967f85-58ae-4f46-9fb2-5d7904798f4b")
  COLE_DEFAULT_PRINCIPAL* = cast[ptr OLECHAR](-1)
  COLE_DEFAULT_AUTHINFO* = cast[pointer](-1)
  UPDFCACHE_ALL* = DWORD(not UPDFCACHE_ONLYIFBLANK)
  UPDFCACHE_ALLBUTNODATACACHE* = UPDFCACHE_ALL and (DWORD)(not UPDFCACHE_NODATACACHE)
  INVALID_P_ROOT_SECURITY_ID* = cast[ptr BYTE](-1)
  SZ_URLCONTEXT* = "URL Context"
  SZ_ASYNC_CALLEE* = "AsyncCallee"
  CLSID_DOMDocument* = DEFINE_GUID("2933bf90-7b36-11d2-b20e-00c04f983e60")
  CLSID_DOMFreeThreadedDocument* = DEFINE_GUID("2933bf91-7b36-11d2-b20e-00c04f983e60")
  CLSID_XMLHTTPRequest* = DEFINE_GUID("ed8c108e-4349-11d2-91a4-00c04f7969e8")
  DIID_XMLDOMDocumentEvents* = DEFINE_GUID("3efaa427-272f-11d2-836f-0000f87a7782")
  IID_IXMLDOMAttribute* = DEFINE_GUID("2933bf85-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMCharacterData* = DEFINE_GUID("2933bf84-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMCDATASection* = DEFINE_GUID("2933bf8a-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMComment* = DEFINE_GUID("2933bf88-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMDocument* = DEFINE_GUID("2933bf81-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMDocumentFragment* = DEFINE_GUID("3efaa413-272f-11d2-836f-0000f87a7782")
  IID_IXMLDOMDocumentType* = DEFINE_GUID("2933bf8b-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMElement* = DEFINE_GUID("2933bf86-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMEntity* = DEFINE_GUID("2933bf8d-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMEntityReference* = DEFINE_GUID("2933bf8e-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMImplementation* = DEFINE_GUID("2933bf8e-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMNamedNodeMap* = DEFINE_GUID("2933bf83-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMNode* = DEFINE_GUID("2933bf80-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMNodeList* = DEFINE_GUID("2933bf82-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMNotation* = DEFINE_GUID("2933bf8c-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMParseError* = DEFINE_GUID("3efaa426-272f-11d2-836f-0000f87a7782")
  IID_IXMLDOMProcessingInstruction* = DEFINE_GUID("2933bf89-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLDOMText* = DEFINE_GUID("2933bf87-7b36-11d2-b20e-00c04f983e60")
  IID_IXMLHttpRequest* = DEFINE_GUID("ed8c108d-4349-11d2-91a4-00c04f7969e8")
  IID_IXTLRuntime* = DEFINE_GUID("3efaa425-272f-11d2-836f-0000f87a7782")
  PAGESET_TOLASTPAGE* = not WORD(0)
type
  LPFNGETCLASSOBJECT* = proc (P1: REFCLSID, P2: REFIID, P3: ptr LPVOID): HRESULT {.stdcall.}
  LPFNCANUNLOADNOW* = proc (): HRESULT {.stdcall.}
  RemHGLOBAL* {.pure.} = object
    fNullHGlobal*: LONG
    cbData*: ULONG
    data*: array[1, uint8]
  RemHMETAFILEPICT* {.pure.} = object
    mm*: LONG
    xExt*: LONG
    yExt*: LONG
    cbData*: ULONG
    data*: array[1, uint8]
  RemHENHMETAFILE* {.pure.} = object
    cbData*: ULONG
    data*: array[1, uint8]
  RemHBITMAP* {.pure.} = object
    cbData*: ULONG
    data*: array[1, uint8]
  RemHPALETTE* {.pure.} = object
    cbData*: ULONG
    data*: array[1, uint8]
  RemHBRUSH* {.pure.} = object
    cbData*: ULONG
    data*: array[1, uint8]
  GDI_NONREMOTE_u* {.pure, union.} = object
    hInproc*: LONG
    hRemote*: ptr DWORD_BLOB
  GDI_NONREMOTE* {.pure.} = object
    fContext*: LONG
    u*: GDI_NONREMOTE_u
  CSPLATFORM* {.pure.} = object
    dwPlatformId*: DWORD
    dwVersionHi*: DWORD
    dwVersionLo*: DWORD
    dwProcessorArch*: DWORD
  QUERYCONTEXT* {.pure.} = object
    dwContext*: DWORD
    Platform*: CSPLATFORM
    Locale*: LCID
    dwVersionHi*: DWORD
    dwVersionLo*: DWORD
  uCLSSPEC_tagged_union_ByName* {.pure.} = object
    pPackageName*: LPOLESTR
    PolicyId*: GUID
  uCLSSPEC_tagged_union_ByObjectId* {.pure.} = object
    ObjectId*: GUID
    PolicyId*: GUID
  uCLSSPEC_tagged_union* {.pure, union.} = object
    clsid*: CLSID
    pFileExt*: LPOLESTR
    pMimeType*: LPOLESTR
    pProgId*: LPOLESTR
    pFileName*: LPOLESTR
    ByName*: uCLSSPEC_tagged_union_ByName
    ByObjectId*: uCLSSPEC_tagged_union_ByObjectId
  uCLSSPEC* {.pure.} = object
    tyspec*: DWORD
    tagged_union*: uCLSSPEC_tagged_union
  SChannelHookCallInfo* {.pure.} = object
    iid*: IID
    cbSize*: DWORD
    uCausality*: GUID
    dwServerPid*: DWORD
    iMethod*: DWORD
    pObject*: pointer
  RemSTGMEDIUM* {.pure.} = object
    tymed*: DWORD
    dwHandleType*: DWORD
    pData*: ULONG
    pUnkForRelease*: ULONG
    cbData*: ULONG
    data*: array[1, uint8]
  FLAG_STGMEDIUM* {.pure.} = object
    ContextFlags*: LONG
    fPassOwnership*: LONG
    Stgmed*: STGMEDIUM
  StorageLayout* {.pure.} = object
    LayoutType*: DWORD
    pwcsElementName*: ptr OLECHAR
    cOffset*: LARGE_INTEGER
    cBytes*: LARGE_INTEGER
  CLEANLOCALSTORAGE* {.pure.} = object
    pInterface*: ptr IUnknown
    pStorage*: PVOID
    flags*: DWORD
  NUMPARSE* {.pure.} = object
    cDig*: INT
    dwInFlags*: ULONG
    dwOutFlags*: ULONG
    cchUsed*: INT
    nBaseShift*: INT
    nPwr10*: INT
  UDATE* {.pure.} = object
    st*: SYSTEMTIME
    wDayOfYear*: USHORT
  STGOPTIONS* {.pure.} = object
    usVersion*: USHORT
    reserved*: USHORT
    ulSectorSize*: ULONG
    pwcsTemplateFile*: ptr WCHAR
  XML_ERROR* {.pure.} = object
    nLine*: int32
    pchBuf*: BSTR
    cchBuf*: int32
    ich*: int32
    pszFound*: BSTR
    pszExpected*: BSTR
    reserved1*: DWORD
    reserved2*: DWORD
  RemBINDINFO* {.pure.} = object
    cbSize*: ULONG
    szExtraInfo*: LPWSTR
    grfBindInfoF*: DWORD
    dwBindVerb*: DWORD
    szCustomVerb*: LPWSTR
    cbstgmedData*: DWORD
    dwOptions*: DWORD
    dwOptionsFlags*: DWORD
    dwCodePage*: DWORD
    securityAttributes*: REMSECURITY_ATTRIBUTES
    iid*: IID
    pUnk*: ptr IUnknown
    dwReserved*: DWORD
  StartParam* {.pure.} = object
    iid*: IID
    pIBindCtx*: ptr IBindCtx
    pItf*: ptr IUnknown
  PROTOCOLFILTERDATA* {.pure.} = object
    cbSize*: DWORD
    pProtocolSink*: ptr IInternetProtocolSink
    pProtocol*: ptr IInternetProtocol
    pUnk*: ptr IUnknown
    dwFilterFlags*: DWORD
  CONFIRMSAFETY* {.pure.} = object
    clsid*: CLSID
    pUnk*: ptr IUnknown
    dwFlags*: DWORD
  SERIALIZEDPROPERTYVALUE* {.pure.} = object
    dwType*: DWORD
    rgb*: array[1, BYTE]
  DVASPECTINFO* {.pure.} = object
    cb*: ULONG
    dwFlags*: DWORD
  COMDLG_FILTERSPEC* {.pure.} = object
    pszName*: LPCWSTR
    pszSpec*: LPCWSTR
  AsyncIUnknown* {.pure.} = object
    lpVtbl*: ptr AsyncIUnknownVtbl
  AsyncIUnknownVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Begin_QueryInterface*: proc(self: ptr AsyncIUnknown, riid: REFIID): HRESULT {.stdcall.}
    Finish_QueryInterface*: proc(self: ptr AsyncIUnknown, ppvObject: ptr pointer): HRESULT {.stdcall.}
    Begin_AddRef*: proc(self: ptr AsyncIUnknown): HRESULT {.stdcall.}
    Finish_AddRef*: proc(self: ptr AsyncIUnknown): ULONG {.stdcall.}
    Begin_Release*: proc(self: ptr AsyncIUnknown): HRESULT {.stdcall.}
    Finish_Release*: proc(self: ptr AsyncIUnknown): ULONG {.stdcall.}
  INoMarshal* {.pure.} = object
    lpVtbl*: ptr INoMarshalVtbl
  INoMarshalVtbl* {.pure, inheritable.} = object of IUnknownVtbl
  IAgileObject* {.pure.} = object
    lpVtbl*: ptr IAgileObjectVtbl
  IAgileObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
  AsyncIMultiQI* {.pure.} = object
    lpVtbl*: ptr AsyncIMultiQIVtbl
  AsyncIMultiQIVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Begin_QueryMultipleInterfaces*: proc(self: ptr AsyncIMultiQI, cMQIs: ULONG, pMQIs: ptr MULTI_QI): void {.stdcall.}
    Finish_QueryMultipleInterfaces*: proc(self: ptr AsyncIMultiQI, pMQIs: ptr MULTI_QI): HRESULT {.stdcall.}
  IInternalUnknown* {.pure.} = object
    lpVtbl*: ptr IInternalUnknownVtbl
  IInternalUnknownVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryInternalInterface*: proc(self: ptr IInternalUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IRpcChannelBuffer* {.pure.} = object
    lpVtbl*: ptr IRpcChannelBufferVtbl
  IRpcChannelBufferVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetBuffer*: proc(self: ptr IRpcChannelBuffer, pMessage: ptr RPCOLEMESSAGE, riid: REFIID): HRESULT {.stdcall.}
    SendReceive*: proc(self: ptr IRpcChannelBuffer, pMessage: ptr RPCOLEMESSAGE, pStatus: ptr ULONG): HRESULT {.stdcall.}
    FreeBuffer*: proc(self: ptr IRpcChannelBuffer, pMessage: ptr RPCOLEMESSAGE): HRESULT {.stdcall.}
    GetDestCtx*: proc(self: ptr IRpcChannelBuffer, pdwDestContext: ptr DWORD, ppvDestContext: ptr pointer): HRESULT {.stdcall.}
    IsConnected*: proc(self: ptr IRpcChannelBuffer): HRESULT {.stdcall.}
  IRpcChannelBuffer2* {.pure.} = object
    lpVtbl*: ptr IRpcChannelBuffer2Vtbl
  IRpcChannelBuffer2Vtbl* {.pure, inheritable.} = object of IRpcChannelBufferVtbl
    GetProtocolVersion*: proc(self: ptr IRpcChannelBuffer2, pdwVersion: ptr DWORD): HRESULT {.stdcall.}
  ISynchronize* {.pure.} = object
    lpVtbl*: ptr ISynchronizeVtbl
  ISynchronizeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Wait*: proc(self: ptr ISynchronize, dwFlags: DWORD, dwMilliseconds: DWORD): HRESULT {.stdcall.}
    Signal*: proc(self: ptr ISynchronize): HRESULT {.stdcall.}
    Reset*: proc(self: ptr ISynchronize): HRESULT {.stdcall.}
  IAsyncRpcChannelBuffer* {.pure.} = object
    lpVtbl*: ptr IAsyncRpcChannelBufferVtbl
  IAsyncRpcChannelBufferVtbl* {.pure, inheritable.} = object of IRpcChannelBuffer2Vtbl
    Send*: proc(self: ptr IAsyncRpcChannelBuffer, pMsg: ptr RPCOLEMESSAGE, pSync: ptr ISynchronize, pulStatus: ptr ULONG): HRESULT {.stdcall.}
    Receive*: proc(self: ptr IAsyncRpcChannelBuffer, pMsg: ptr RPCOLEMESSAGE, pulStatus: ptr ULONG): HRESULT {.stdcall.}
    GetDestCtxEx*: proc(self: ptr IAsyncRpcChannelBuffer, pMsg: ptr RPCOLEMESSAGE, pdwDestContext: ptr DWORD, ppvDestContext: ptr pointer): HRESULT {.stdcall.}
  IAsyncManager* {.pure.} = object
    lpVtbl*: ptr IAsyncManagerVtbl
  IAsyncManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CompleteCall*: proc(self: ptr IAsyncManager, Result: HRESULT): HRESULT {.stdcall.}
    GetCallContext*: proc(self: ptr IAsyncManager, riid: REFIID, pInterface: ptr pointer): HRESULT {.stdcall.}
    GetState*: proc(self: ptr IAsyncManager, pulStateFlags: ptr ULONG): HRESULT {.stdcall.}
  IRpcChannelBuffer3* {.pure.} = object
    lpVtbl*: ptr IRpcChannelBuffer3Vtbl
  IRpcChannelBuffer3Vtbl* {.pure, inheritable.} = object of IRpcChannelBuffer2Vtbl
    Send*: proc(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, pulStatus: ptr ULONG): HRESULT {.stdcall.}
    Receive*: proc(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, ulSize: ULONG, pulStatus: ptr ULONG): HRESULT {.stdcall.}
    Cancel*: proc(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE): HRESULT {.stdcall.}
    GetCallContext*: proc(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, riid: REFIID, pInterface: ptr pointer): HRESULT {.stdcall.}
    GetDestCtxEx*: proc(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, pdwDestContext: ptr DWORD, ppvDestContext: ptr pointer): HRESULT {.stdcall.}
    GetState*: proc(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, pState: ptr DWORD): HRESULT {.stdcall.}
    RegisterAsync*: proc(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, pAsyncMgr: ptr IAsyncManager): HRESULT {.stdcall.}
  IRpcSyntaxNegotiate* {.pure.} = object
    lpVtbl*: ptr IRpcSyntaxNegotiateVtbl
  IRpcSyntaxNegotiateVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    NegotiateSyntax*: proc(self: ptr IRpcSyntaxNegotiate, pMsg: ptr RPCOLEMESSAGE): HRESULT {.stdcall.}
  IRpcProxyBuffer* {.pure.} = object
    lpVtbl*: ptr IRpcProxyBufferVtbl
  IRpcProxyBufferVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Connect*: proc(self: ptr IRpcProxyBuffer, pRpcChannelBuffer: ptr IRpcChannelBuffer): HRESULT {.stdcall.}
    Disconnect*: proc(self: ptr IRpcProxyBuffer): void {.stdcall.}
  IRpcStubBuffer* {.pure.} = object
    lpVtbl*: ptr IRpcStubBufferVtbl
  IRpcStubBufferVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Connect*: proc(self: ptr IRpcStubBuffer, pUnkServer: ptr IUnknown): HRESULT {.stdcall.}
    Disconnect*: proc(self: ptr IRpcStubBuffer): void {.stdcall.}
    Invoke*: proc(self: ptr IRpcStubBuffer, prpcmsg: ptr RPCOLEMESSAGE, pRpcChannelBuffer: ptr IRpcChannelBuffer): HRESULT {.stdcall.}
    IsIIDSupported*: proc(self: ptr IRpcStubBuffer, riid: REFIID): ptr IRpcStubBuffer {.stdcall.}
    CountRefs*: proc(self: ptr IRpcStubBuffer): ULONG {.stdcall.}
    DebugServerQueryInterface*: proc(self: ptr IRpcStubBuffer, ppv: ptr pointer): HRESULT {.stdcall.}
    DebugServerRelease*: proc(self: ptr IRpcStubBuffer, pv: pointer): void {.stdcall.}
  IPSFactoryBuffer* {.pure.} = object
    lpVtbl*: ptr IPSFactoryBufferVtbl
  IPSFactoryBufferVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateProxy*: proc(self: ptr IPSFactoryBuffer, pUnkOuter: ptr IUnknown, riid: REFIID, ppProxy: ptr ptr IRpcProxyBuffer, ppv: ptr pointer): HRESULT {.stdcall.}
    CreateStub*: proc(self: ptr IPSFactoryBuffer, riid: REFIID, pUnkServer: ptr IUnknown, ppStub: ptr ptr IRpcStubBuffer): HRESULT {.stdcall.}
  IChannelHook* {.pure.} = object
    lpVtbl*: ptr IChannelHookVtbl
  IChannelHookVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ClientGetSize*: proc(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, pDataSize: ptr ULONG): void {.stdcall.}
    ClientFillBuffer*: proc(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, pDataSize: ptr ULONG, pDataBuffer: pointer): void {.stdcall.}
    ClientNotify*: proc(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, cbDataSize: ULONG, pDataBuffer: pointer, lDataRep: DWORD, hrFault: HRESULT): void {.stdcall.}
    ServerNotify*: proc(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, cbDataSize: ULONG, pDataBuffer: pointer, lDataRep: DWORD): void {.stdcall.}
    ServerGetSize*: proc(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, hrFault: HRESULT, pDataSize: ptr ULONG): void {.stdcall.}
    ServerFillBuffer*: proc(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, pDataSize: ptr ULONG, pDataBuffer: pointer, hrFault: HRESULT): void {.stdcall.}
  IClientSecurity* {.pure.} = object
    lpVtbl*: ptr IClientSecurityVtbl
  IClientSecurityVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryBlanket*: proc(self: ptr IClientSecurity, pProxy: ptr IUnknown, pAuthnSvc: ptr DWORD, pAuthzSvc: ptr DWORD, pServerPrincName: ptr ptr OLECHAR, pAuthnLevel: ptr DWORD, pImpLevel: ptr DWORD, pAuthInfo: ptr pointer, pCapabilites: ptr DWORD): HRESULT {.stdcall.}
    SetBlanket*: proc(self: ptr IClientSecurity, pProxy: ptr IUnknown, dwAuthnSvc: DWORD, dwAuthzSvc: DWORD, pServerPrincName: ptr OLECHAR, dwAuthnLevel: DWORD, dwImpLevel: DWORD, pAuthInfo: pointer, dwCapabilities: DWORD): HRESULT {.stdcall.}
    CopyProxy*: proc(self: ptr IClientSecurity, pProxy: ptr IUnknown, ppCopy: ptr ptr IUnknown): HRESULT {.stdcall.}
  IServerSecurity* {.pure.} = object
    lpVtbl*: ptr IServerSecurityVtbl
  IServerSecurityVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryBlanket*: proc(self: ptr IServerSecurity, pAuthnSvc: ptr DWORD, pAuthzSvc: ptr DWORD, pServerPrincName: ptr ptr OLECHAR, pAuthnLevel: ptr DWORD, pImpLevel: ptr DWORD, pPrivs: ptr pointer, pCapabilities: ptr DWORD): HRESULT {.stdcall.}
    ImpersonateClient*: proc(self: ptr IServerSecurity): HRESULT {.stdcall.}
    RevertToSelf*: proc(self: ptr IServerSecurity): HRESULT {.stdcall.}
    IsImpersonating*: proc(self: ptr IServerSecurity): WINBOOL {.stdcall.}
  IRpcOptions* {.pure.} = object
    lpVtbl*: ptr IRpcOptionsVtbl
  IRpcOptionsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Set*: proc(self: ptr IRpcOptions, pPrx: ptr IUnknown, dwProperty: RPCOPT_PROPERTIES, dwValue: ULONG_PTR): HRESULT {.stdcall.}
    Query*: proc(self: ptr IRpcOptions, pPrx: ptr IUnknown, dwProperty: RPCOPT_PROPERTIES, pdwValue: ptr ULONG_PTR): HRESULT {.stdcall.}
  IGlobalOptions* {.pure.} = object
    lpVtbl*: ptr IGlobalOptionsVtbl
  IGlobalOptionsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Set*: proc(self: ptr IGlobalOptions, dwProperty: GLOBALOPT_PROPERTIES, dwValue: ULONG_PTR): HRESULT {.stdcall.}
    Query*: proc(self: ptr IGlobalOptions, dwProperty: GLOBALOPT_PROPERTIES, pdwValue: ptr ULONG_PTR): HRESULT {.stdcall.}
  ISynchronizeHandle* {.pure.} = object
    lpVtbl*: ptr ISynchronizeHandleVtbl
  ISynchronizeHandleVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetHandle*: proc(self: ptr ISynchronizeHandle, ph: ptr HANDLE): HRESULT {.stdcall.}
  ISynchronizeEvent* {.pure.} = object
    lpVtbl*: ptr ISynchronizeEventVtbl
  ISynchronizeEventVtbl* {.pure, inheritable.} = object of ISynchronizeHandleVtbl
    SetEventHandle*: proc(self: ptr ISynchronizeEvent, ph: ptr HANDLE): HRESULT {.stdcall.}
  ISynchronizeContainer* {.pure.} = object
    lpVtbl*: ptr ISynchronizeContainerVtbl
  ISynchronizeContainerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddSynchronize*: proc(self: ptr ISynchronizeContainer, pSync: ptr ISynchronize): HRESULT {.stdcall.}
    WaitMultiple*: proc(self: ptr ISynchronizeContainer, dwFlags: DWORD, dwTimeOut: DWORD, ppSync: ptr ptr ISynchronize): HRESULT {.stdcall.}
  ISynchronizeMutex* {.pure.} = object
    lpVtbl*: ptr ISynchronizeMutexVtbl
  ISynchronizeMutexVtbl* {.pure, inheritable.} = object of ISynchronizeVtbl
    ReleaseMutex*: proc(self: ptr ISynchronizeMutex): HRESULT {.stdcall.}
  ICallFactory* {.pure.} = object
    lpVtbl*: ptr ICallFactoryVtbl
  ICallFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateCall*: proc(self: ptr ICallFactory, riid: REFIID, pCtrlUnk: ptr IUnknown, riid2: REFIID, ppv: ptr ptr IUnknown): HRESULT {.stdcall.}
  IRpcHelper* {.pure.} = object
    lpVtbl*: ptr IRpcHelperVtbl
  IRpcHelperVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetDCOMProtocolVersion*: proc(self: ptr IRpcHelper, pComVersion: ptr DWORD): HRESULT {.stdcall.}
    GetIIDFromOBJREF*: proc(self: ptr IRpcHelper, pObjRef: pointer, piid: ptr ptr IID): HRESULT {.stdcall.}
  IReleaseMarshalBuffers* {.pure.} = object
    lpVtbl*: ptr IReleaseMarshalBuffersVtbl
  IReleaseMarshalBuffersVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ReleaseMarshalBuffer*: proc(self: ptr IReleaseMarshalBuffers, pMsg: ptr RPCOLEMESSAGE, dwFlags: DWORD, pChnl: ptr IUnknown): HRESULT {.stdcall.}
  IWaitMultiple* {.pure.} = object
    lpVtbl*: ptr IWaitMultipleVtbl
  IWaitMultipleVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    WaitMultiple*: proc(self: ptr IWaitMultiple, timeout: DWORD, pSync: ptr ptr ISynchronize): HRESULT {.stdcall.}
    AddSynchronize*: proc(self: ptr IWaitMultiple, pSync: ptr ISynchronize): HRESULT {.stdcall.}
  IPipeByte* {.pure.} = object
    lpVtbl*: ptr IPipeByteVtbl
  IPipeByteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Pull*: proc(self: ptr IPipeByte, buf: ptr BYTE, cRequest: ULONG, pcReturned: ptr ULONG): HRESULT {.stdcall.}
    Push*: proc(self: ptr IPipeByte, buf: ptr BYTE, cSent: ULONG): HRESULT {.stdcall.}
  IPipeLong* {.pure.} = object
    lpVtbl*: ptr IPipeLongVtbl
  IPipeLongVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Pull*: proc(self: ptr IPipeLong, buf: ptr LONG, cRequest: ULONG, pcReturned: ptr ULONG): HRESULT {.stdcall.}
    Push*: proc(self: ptr IPipeLong, buf: ptr LONG, cSent: ULONG): HRESULT {.stdcall.}
  IPipeDouble* {.pure.} = object
    lpVtbl*: ptr IPipeDoubleVtbl
  IPipeDoubleVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Pull*: proc(self: ptr IPipeDouble, buf: ptr DOUBLE, cRequest: ULONG, pcReturned: ptr ULONG): HRESULT {.stdcall.}
    Push*: proc(self: ptr IPipeDouble, buf: ptr DOUBLE, cSent: ULONG): HRESULT {.stdcall.}
  IContext* {.pure.} = object
    lpVtbl*: ptr IContextVtbl
  IContextVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetProperty*: proc(self: ptr IContext, rpolicyId: REFGUID, flags: CPFLAGS, pUnk: ptr IUnknown): HRESULT {.stdcall.}
    RemoveProperty*: proc(self: ptr IContext, rPolicyId: REFGUID): HRESULT {.stdcall.}
    GetProperty*: proc(self: ptr IContext, rGuid: REFGUID, pFlags: ptr CPFLAGS, ppUnk: ptr ptr IUnknown): HRESULT {.stdcall.}
    EnumContextProps*: proc(self: ptr IContext, ppEnumContextProps: ptr ptr IEnumContextProps): HRESULT {.stdcall.}
  IComThreadingInfo* {.pure.} = object
    lpVtbl*: ptr IComThreadingInfoVtbl
  IComThreadingInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentApartmentType*: proc(self: ptr IComThreadingInfo, pAptType: ptr APTTYPE): HRESULT {.stdcall.}
    GetCurrentThreadType*: proc(self: ptr IComThreadingInfo, pThreadType: ptr THDTYPE): HRESULT {.stdcall.}
    GetCurrentLogicalThreadId*: proc(self: ptr IComThreadingInfo, pguidLogicalThreadId: ptr GUID): HRESULT {.stdcall.}
    SetCurrentLogicalThreadId*: proc(self: ptr IComThreadingInfo, rguid: REFGUID): HRESULT {.stdcall.}
  IProcessInitControl* {.pure.} = object
    lpVtbl*: ptr IProcessInitControlVtbl
  IProcessInitControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ResetInitializerTimeout*: proc(self: ptr IProcessInitControl, dwSecondsRemaining: DWORD): HRESULT {.stdcall.}
  IFastRundown* {.pure.} = object
    lpVtbl*: ptr IFastRundownVtbl
  IFastRundownVtbl* {.pure, inheritable.} = object of IUnknownVtbl
  IMarshalingStream* {.pure.} = object
    lpVtbl*: ptr IMarshalingStreamVtbl
  IMarshalingStreamVtbl* {.pure, inheritable.} = object of IStreamVtbl
    GetMarshalingContextAttribute*: proc(self: ptr IMarshalingStream, attribute: CO_MARSHALING_CONTEXT_ATTRIBUTES, pAttributeValue: ptr ULONG_PTR): HRESULT {.stdcall.}
  IROTData* {.pure.} = object
    lpVtbl*: ptr IROTDataVtbl
  IROTDataVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetComparisonData*: proc(self: ptr IROTData, pbData: ptr uint8, cbMax: ULONG, pcbData: ptr ULONG): HRESULT {.stdcall.}
  AsyncIAdviseSink* {.pure.} = object
    lpVtbl*: ptr AsyncIAdviseSinkVtbl
  AsyncIAdviseSinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Begin_OnDataChange*: proc(self: ptr AsyncIAdviseSink, pFormatetc: ptr FORMATETC, pStgmed: ptr STGMEDIUM): void {.stdcall.}
    Finish_OnDataChange*: proc(self: ptr AsyncIAdviseSink): void {.stdcall.}
    Begin_OnViewChange*: proc(self: ptr AsyncIAdviseSink, dwAspect: DWORD, lindex: LONG): void {.stdcall.}
    Finish_OnViewChange*: proc(self: ptr AsyncIAdviseSink): void {.stdcall.}
    Begin_OnRename*: proc(self: ptr AsyncIAdviseSink, pmk: ptr IMoniker): void {.stdcall.}
    Finish_OnRename*: proc(self: ptr AsyncIAdviseSink): void {.stdcall.}
    Begin_OnSave*: proc(self: ptr AsyncIAdviseSink): void {.stdcall.}
    Finish_OnSave*: proc(self: ptr AsyncIAdviseSink): void {.stdcall.}
    Begin_OnClose*: proc(self: ptr AsyncIAdviseSink): void {.stdcall.}
    Finish_OnClose*: proc(self: ptr AsyncIAdviseSink): void {.stdcall.}
  AsyncIAdviseSink2* {.pure.} = object
    lpVtbl*: ptr AsyncIAdviseSink2Vtbl
  AsyncIAdviseSink2Vtbl* {.pure, inheritable.} = object of IAdviseSinkVtbl
    Begin_OnLinkSrcChange*: proc(self: ptr AsyncIAdviseSink2, pmk: ptr IMoniker): void {.stdcall.}
    Finish_OnLinkSrcChange*: proc(self: ptr AsyncIAdviseSink2): void {.stdcall.}
  IClassActivator* {.pure.} = object
    lpVtbl*: ptr IClassActivatorVtbl
  IClassActivatorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetClassObject*: proc(self: ptr IClassActivator, rclsid: REFCLSID, dwClassContext: DWORD, locale: LCID, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IFillLockBytes* {.pure.} = object
    lpVtbl*: ptr IFillLockBytesVtbl
  IFillLockBytesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FillAppend*: proc(self: ptr IFillLockBytes, pv: pointer, cb: ULONG, pcbWritten: ptr ULONG): HRESULT {.stdcall.}
    FillAt*: proc(self: ptr IFillLockBytes, ulOffset: ULARGE_INTEGER, pv: pointer, cb: ULONG, pcbWritten: ptr ULONG): HRESULT {.stdcall.}
    SetFillSize*: proc(self: ptr IFillLockBytes, ulSize: ULARGE_INTEGER): HRESULT {.stdcall.}
    Terminate*: proc(self: ptr IFillLockBytes, bCanceled: WINBOOL): HRESULT {.stdcall.}
  IProgressNotify* {.pure.} = object
    lpVtbl*: ptr IProgressNotifyVtbl
  IProgressNotifyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnProgress*: proc(self: ptr IProgressNotify, dwProgressCurrent: DWORD, dwProgressMaximum: DWORD, fAccurate: WINBOOL, fOwner: WINBOOL): HRESULT {.stdcall.}
  ILayoutStorage* {.pure.} = object
    lpVtbl*: ptr ILayoutStorageVtbl
  ILayoutStorageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    LayoutScript*: proc(self: ptr ILayoutStorage, pStorageLayout: ptr StorageLayout, nEntries: DWORD, glfInterleavedFlag: DWORD): HRESULT {.stdcall.}
    BeginMonitor*: proc(self: ptr ILayoutStorage): HRESULT {.stdcall.}
    EndMonitor*: proc(self: ptr ILayoutStorage): HRESULT {.stdcall.}
    ReLayoutDocfile*: proc(self: ptr ILayoutStorage, pwcsNewDfName: ptr OLECHAR): HRESULT {.stdcall.}
    ReLayoutDocfileOnILockBytes*: proc(self: ptr ILayoutStorage, pILockBytes: ptr ILockBytes): HRESULT {.stdcall.}
  IBlockingLock* {.pure.} = object
    lpVtbl*: ptr IBlockingLockVtbl
  IBlockingLockVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Lock*: proc(self: ptr IBlockingLock, dwTimeout: DWORD): HRESULT {.stdcall.}
    Unlock*: proc(self: ptr IBlockingLock): HRESULT {.stdcall.}
  ITimeAndNoticeControl* {.pure.} = object
    lpVtbl*: ptr ITimeAndNoticeControlVtbl
  ITimeAndNoticeControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SuppressChanges*: proc(self: ptr ITimeAndNoticeControl, res1: DWORD, res2: DWORD): HRESULT {.stdcall.}
  IOplockStorage* {.pure.} = object
    lpVtbl*: ptr IOplockStorageVtbl
  IOplockStorageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateStorageEx*: proc(self: ptr IOplockStorage, pwcsName: LPCWSTR, grfMode: DWORD, stgfmt: DWORD, grfAttrs: DWORD, riid: REFIID, ppstgOpen: ptr pointer): HRESULT {.stdcall.}
    OpenStorageEx*: proc(self: ptr IOplockStorage, pwcsName: LPCWSTR, grfMode: DWORD, stgfmt: DWORD, grfAttrs: DWORD, riid: REFIID, ppstgOpen: ptr pointer): HRESULT {.stdcall.}
  IDirectWriterLock* {.pure.} = object
    lpVtbl*: ptr IDirectWriterLockVtbl
  IDirectWriterLockVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    WaitForWriteAccess*: proc(self: ptr IDirectWriterLock, dwTimeout: DWORD): HRESULT {.stdcall.}
    ReleaseWriteAccess*: proc(self: ptr IDirectWriterLock): HRESULT {.stdcall.}
    HaveWriteAccess*: proc(self: ptr IDirectWriterLock): HRESULT {.stdcall.}
  IUrlMon* {.pure.} = object
    lpVtbl*: ptr IUrlMonVtbl
  IUrlMonVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AsyncGetClassBits*: proc(self: ptr IUrlMon, rclsid: REFCLSID, pszTYPE: LPCWSTR, pszExt: LPCWSTR, dwFileVersionMS: DWORD, dwFileVersionLS: DWORD, pszCodeBase: LPCWSTR, pbc: ptr IBindCtx, dwClassContext: DWORD, riid: REFIID, flags: DWORD): HRESULT {.stdcall.}
  IForegroundTransfer* {.pure.} = object
    lpVtbl*: ptr IForegroundTransferVtbl
  IForegroundTransferVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AllowForegroundTransfer*: proc(self: ptr IForegroundTransfer, lpvReserved: pointer): HRESULT {.stdcall.}
  IThumbnailExtractor* {.pure.} = object
    lpVtbl*: ptr IThumbnailExtractorVtbl
  IThumbnailExtractorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ExtractThumbnail*: proc(self: ptr IThumbnailExtractor, pStg: ptr IStorage, ulLength: ULONG, ulHeight: ULONG, pulOutputLength: ptr ULONG, pulOutputHeight: ptr ULONG, phOutputBitmap: ptr HBITMAP): HRESULT {.stdcall.}
    OnFileUpdated*: proc(self: ptr IThumbnailExtractor, pStg: ptr IStorage): HRESULT {.stdcall.}
  IDummyHICONIncluder* {.pure.} = object
    lpVtbl*: ptr IDummyHICONIncluderVtbl
  IDummyHICONIncluderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Dummy*: proc(self: ptr IDummyHICONIncluder, h1: HICON, h2: HDC): HRESULT {.stdcall.}
  IProcessLock* {.pure.} = object
    lpVtbl*: ptr IProcessLockVtbl
  IProcessLockVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddRefOnProcess*: proc(self: ptr IProcessLock): ULONG {.stdcall.}
    ReleaseRefOnProcess*: proc(self: ptr IProcessLock): ULONG {.stdcall.}
  ISurrogateService* {.pure.} = object
    lpVtbl*: ptr ISurrogateServiceVtbl
  ISurrogateServiceVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Init*: proc(self: ptr ISurrogateService, rguidProcessID: REFGUID, pProcessLock: ptr IProcessLock, pfApplicationAware: ptr WINBOOL): HRESULT {.stdcall.}
    ApplicationLaunch*: proc(self: ptr ISurrogateService, rguidApplID: REFGUID, appType: ApplicationType): HRESULT {.stdcall.}
    ApplicationFree*: proc(self: ptr ISurrogateService, rguidApplID: REFGUID): HRESULT {.stdcall.}
    CatalogRefresh*: proc(self: ptr ISurrogateService, ulReserved: ULONG): HRESULT {.stdcall.}
    ProcessShutdown*: proc(self: ptr ISurrogateService, shutdownType: ShutdownType): HRESULT {.stdcall.}
  IApartmentShutdown* {.pure.} = object
    lpVtbl*: ptr IApartmentShutdownVtbl
  IApartmentShutdownVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnUninitialize*: proc(self: ptr IApartmentShutdown, ui64ApartmentIdentifier: UINT64): void {.stdcall.}
  ITypeFactory* {.pure.} = object
    lpVtbl*: ptr ITypeFactoryVtbl
  ITypeFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateFromTypeInfo*: proc(self: ptr ITypeFactory, pTypeInfo: ptr ITypeInfo, riid: REFIID, ppv: ptr ptr IUnknown): HRESULT {.stdcall.}
  ITypeMarshal* {.pure.} = object
    lpVtbl*: ptr ITypeMarshalVtbl
  ITypeMarshalVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Size*: proc(self: ptr ITypeMarshal, pvType: PVOID, dwDestContext: DWORD, pvDestContext: PVOID, pSize: ptr ULONG): HRESULT {.stdcall.}
    Marshal*: proc(self: ptr ITypeMarshal, pvType: PVOID, dwDestContext: DWORD, pvDestContext: PVOID, cbBufferLength: ULONG, pBuffer: ptr BYTE, pcbWritten: ptr ULONG): HRESULT {.stdcall.}
    Unmarshal*: proc(self: ptr ITypeMarshal, pvType: PVOID, dwFlags: DWORD, cbBufferLength: ULONG, pBuffer: ptr BYTE, pcbRead: ptr ULONG): HRESULT {.stdcall.}
    Free*: proc(self: ptr ITypeMarshal, pvType: PVOID): HRESULT {.stdcall.}
  IContinue* {.pure.} = object
    lpVtbl*: ptr IContinueVtbl
  IContinueVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FContinue*: proc(self: ptr IContinue): HRESULT {.stdcall.}
  IDropSourceNotify* {.pure.} = object
    lpVtbl*: ptr IDropSourceNotifyVtbl
  IDropSourceNotifyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    DragEnterTarget*: proc(self: ptr IDropSourceNotify, hwndTarget: HWND): HRESULT {.stdcall.}
    DragLeaveTarget*: proc(self: ptr IDropSourceNotify): HRESULT {.stdcall.}
  IXMLDOMImplementation* {.pure.} = object
    lpVtbl*: ptr IXMLDOMImplementationVtbl
  IXMLDOMImplementationVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    hasFeature*: proc(self: ptr IXMLDOMImplementation, feature: BSTR, version: BSTR, hasFeature: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  IXMLDOMNodeList* {.pure.} = object
    lpVtbl*: ptr IXMLDOMNodeListVtbl
  IXMLDOMNodeListVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_item*: proc(self: ptr IXMLDOMNodeList, index: LONG, listItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_length*: proc(self: ptr IXMLDOMNodeList, listLength: ptr LONG): HRESULT {.stdcall.}
    nextNode*: proc(self: ptr IXMLDOMNodeList, nextItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    reset*: proc(self: ptr IXMLDOMNodeList): HRESULT {.stdcall.}
    get_newEnum*: proc(self: ptr IXMLDOMNodeList, ppUnk: ptr ptr IUnknown): HRESULT {.stdcall.}
  IXMLDOMNode* {.pure.} = object
    lpVtbl*: ptr IXMLDOMNodeVtbl
  IXMLDOMNodeVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_nodeName*: proc(self: ptr IXMLDOMNode, name: ptr BSTR): HRESULT {.stdcall.}
    get_nodeValue*: proc(self: ptr IXMLDOMNode, value: ptr VARIANT): HRESULT {.stdcall.}
    put_nodeValue*: proc(self: ptr IXMLDOMNode, value: VARIANT): HRESULT {.stdcall.}
    get_nodeType*: proc(self: ptr IXMLDOMNode, `type`: ptr DOMNodeType): HRESULT {.stdcall.}
    get_parentNode*: proc(self: ptr IXMLDOMNode, parent: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_childNodes*: proc(self: ptr IXMLDOMNode, childList: ptr ptr IXMLDOMNodeList): HRESULT {.stdcall.}
    get_firstChild*: proc(self: ptr IXMLDOMNode, firstChild: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_lastChild*: proc(self: ptr IXMLDOMNode, lastChild: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_previousSibling*: proc(self: ptr IXMLDOMNode, previousSibling: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_nextSibling*: proc(self: ptr IXMLDOMNode, nextSibling: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_attributes*: proc(self: ptr IXMLDOMNode, attributeMap: ptr ptr IXMLDOMNamedNodeMap): HRESULT {.stdcall.}
    insertBefore*: proc(self: ptr IXMLDOMNode, newChild: ptr IXMLDOMNode, refChild: VARIANT, outNewChild: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    replaceChild*: proc(self: ptr IXMLDOMNode, newChild: ptr IXMLDOMNode, oldChild: ptr IXMLDOMNode, outOldChild: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    removeChild*: proc(self: ptr IXMLDOMNode, childNode: ptr IXMLDOMNode, oldChild: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    appendChild*: proc(self: ptr IXMLDOMNode, newChild: ptr IXMLDOMNode, outNewChild: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    hasChildNodes*: proc(self: ptr IXMLDOMNode, hasChild: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_ownerDocument*: proc(self: ptr IXMLDOMNode, DOMDocument: ptr ptr IXMLDOMDocument): HRESULT {.stdcall.}
    cloneNode*: proc(self: ptr IXMLDOMNode, deep: VARIANT_BOOL, cloneRoot: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_nodeTypeString*: proc(self: ptr IXMLDOMNode, nodeType: ptr BSTR): HRESULT {.stdcall.}
    get_text*: proc(self: ptr IXMLDOMNode, text: ptr BSTR): HRESULT {.stdcall.}
    put_text*: proc(self: ptr IXMLDOMNode, text: BSTR): HRESULT {.stdcall.}
    get_specified*: proc(self: ptr IXMLDOMNode, isSpecified: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_definition*: proc(self: ptr IXMLDOMNode, definitionNode: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_nodeTypedValue*: proc(self: ptr IXMLDOMNode, typedValue: ptr VARIANT): HRESULT {.stdcall.}
    put_nodeTypedValue*: proc(self: ptr IXMLDOMNode, typedValue: VARIANT): HRESULT {.stdcall.}
    get_dataType*: proc(self: ptr IXMLDOMNode, dataTypeName: ptr VARIANT): HRESULT {.stdcall.}
    put_dataType*: proc(self: ptr IXMLDOMNode, dataTypeName: BSTR): HRESULT {.stdcall.}
    get_xml*: proc(self: ptr IXMLDOMNode, xmlString: ptr BSTR): HRESULT {.stdcall.}
    transformNode*: proc(self: ptr IXMLDOMNode, stylesheet: ptr IXMLDOMNode, xmlString: ptr BSTR): HRESULT {.stdcall.}
    selectNodes*: proc(self: ptr IXMLDOMNode, queryString: BSTR, resultList: ptr ptr IXMLDOMNodeList): HRESULT {.stdcall.}
    selectSingleNode*: proc(self: ptr IXMLDOMNode, queryString: BSTR, resultNode: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_parsed*: proc(self: ptr IXMLDOMNode, isParsed: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_namespaceURI*: proc(self: ptr IXMLDOMNode, namespaceURI: ptr BSTR): HRESULT {.stdcall.}
    get_prefix*: proc(self: ptr IXMLDOMNode, prefixString: ptr BSTR): HRESULT {.stdcall.}
    get_baseName*: proc(self: ptr IXMLDOMNode, nameString: ptr BSTR): HRESULT {.stdcall.}
    transformNodeToObject*: proc(self: ptr IXMLDOMNode, stylesheet: ptr IXMLDOMNode, outputObject: VARIANT): HRESULT {.stdcall.}
  IXMLDOMDocumentType* {.pure.} = object
    lpVtbl*: ptr IXMLDOMDocumentTypeVtbl
  IXMLDOMDocumentTypeVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    get_name*: proc(self: ptr IXMLDOMDocumentType, rootName: ptr BSTR): HRESULT {.stdcall.}
    get_entities*: proc(self: ptr IXMLDOMDocumentType, entityMap: ptr ptr IXMLDOMNamedNodeMap): HRESULT {.stdcall.}
    get_notations*: proc(self: ptr IXMLDOMDocumentType, notationMap: ptr ptr IXMLDOMNamedNodeMap): HRESULT {.stdcall.}
  IXMLDOMAttribute* {.pure.} = object
    lpVtbl*: ptr IXMLDOMAttributeVtbl
  IXMLDOMAttributeVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    get_name*: proc(self: ptr IXMLDOMAttribute, attributeName: ptr BSTR): HRESULT {.stdcall.}
    get_value*: proc(self: ptr IXMLDOMAttribute, attributeValue: ptr VARIANT): HRESULT {.stdcall.}
    put_value*: proc(self: ptr IXMLDOMAttribute, attributeValue: VARIANT): HRESULT {.stdcall.}
  IXMLDOMElement* {.pure.} = object
    lpVtbl*: ptr IXMLDOMElementVtbl
  IXMLDOMElementVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    get_tagName*: proc(self: ptr IXMLDOMElement, tagName: ptr BSTR): HRESULT {.stdcall.}
    getAttribute*: proc(self: ptr IXMLDOMElement, name: BSTR, value: ptr VARIANT): HRESULT {.stdcall.}
    setAttribute*: proc(self: ptr IXMLDOMElement, name: BSTR, value: VARIANT): HRESULT {.stdcall.}
    removeAttribute*: proc(self: ptr IXMLDOMElement, name: BSTR): HRESULT {.stdcall.}
    getAttributeNode*: proc(self: ptr IXMLDOMElement, name: BSTR, attributeNode: ptr ptr IXMLDOMAttribute): HRESULT {.stdcall.}
    setAttributeNode*: proc(self: ptr IXMLDOMElement, DOMAttribute: ptr IXMLDOMAttribute, attributeNode: ptr ptr IXMLDOMAttribute): HRESULT {.stdcall.}
    removeAttributeNode*: proc(self: ptr IXMLDOMElement, DOMAttribute: ptr IXMLDOMAttribute, attributeNode: ptr ptr IXMLDOMAttribute): HRESULT {.stdcall.}
    getElementsByTagName*: proc(self: ptr IXMLDOMElement, tagName: BSTR, resultList: ptr ptr IXMLDOMNodeList): HRESULT {.stdcall.}
    normalize*: proc(self: ptr IXMLDOMElement): HRESULT {.stdcall.}
  IXMLDOMDocumentFragment* {.pure.} = object
    lpVtbl*: ptr IXMLDOMDocumentFragmentVtbl
  IXMLDOMDocumentFragmentVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
  IXMLDOMCharacterData* {.pure.} = object
    lpVtbl*: ptr IXMLDOMCharacterDataVtbl
  IXMLDOMCharacterDataVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    get_data*: proc(self: ptr IXMLDOMCharacterData, data: ptr BSTR): HRESULT {.stdcall.}
    put_data*: proc(self: ptr IXMLDOMCharacterData, data: BSTR): HRESULT {.stdcall.}
    get_length*: proc(self: ptr IXMLDOMCharacterData, dataLength: ptr LONG): HRESULT {.stdcall.}
    substringData*: proc(self: ptr IXMLDOMCharacterData, offset: LONG, count: LONG, data: ptr BSTR): HRESULT {.stdcall.}
    appendData*: proc(self: ptr IXMLDOMCharacterData, data: BSTR): HRESULT {.stdcall.}
    insertData*: proc(self: ptr IXMLDOMCharacterData, offset: LONG, data: BSTR): HRESULT {.stdcall.}
    deleteData*: proc(self: ptr IXMLDOMCharacterData, offset: LONG, count: LONG): HRESULT {.stdcall.}
    replaceData*: proc(self: ptr IXMLDOMCharacterData, offset: LONG, count: LONG, data: BSTR): HRESULT {.stdcall.}
  IXMLDOMText* {.pure.} = object
    lpVtbl*: ptr IXMLDOMTextVtbl
  IXMLDOMTextVtbl* {.pure, inheritable.} = object of IXMLDOMCharacterDataVtbl
    splitText*: proc(self: ptr IXMLDOMText, offset: LONG, rightHandTextNode: ptr ptr IXMLDOMText): HRESULT {.stdcall.}
  IXMLDOMComment* {.pure.} = object
    lpVtbl*: ptr IXMLDOMCommentVtbl
  IXMLDOMCommentVtbl* {.pure, inheritable.} = object of IXMLDOMCharacterDataVtbl
  IXMLDOMCDATASection* {.pure.} = object
    lpVtbl*: ptr IXMLDOMCDATASectionVtbl
  IXMLDOMCDATASectionVtbl* {.pure, inheritable.} = object of IXMLDOMTextVtbl
  IXMLDOMProcessingInstruction* {.pure.} = object
    lpVtbl*: ptr IXMLDOMProcessingInstructionVtbl
  IXMLDOMProcessingInstructionVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    get_target*: proc(self: ptr IXMLDOMProcessingInstruction, name: ptr BSTR): HRESULT {.stdcall.}
    get_data*: proc(self: ptr IXMLDOMProcessingInstruction, value: ptr BSTR): HRESULT {.stdcall.}
    put_data*: proc(self: ptr IXMLDOMProcessingInstruction, value: BSTR): HRESULT {.stdcall.}
  IXMLDOMEntityReference* {.pure.} = object
    lpVtbl*: ptr IXMLDOMEntityReferenceVtbl
  IXMLDOMEntityReferenceVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
  IXMLDOMParseError* {.pure.} = object
    lpVtbl*: ptr IXMLDOMParseErrorVtbl
  IXMLDOMParseErrorVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_errorCode*: proc(self: ptr IXMLDOMParseError, errorCode: ptr LONG): HRESULT {.stdcall.}
    get_url*: proc(self: ptr IXMLDOMParseError, urlString: ptr BSTR): HRESULT {.stdcall.}
    get_reason*: proc(self: ptr IXMLDOMParseError, reasonString: ptr BSTR): HRESULT {.stdcall.}
    get_srcText*: proc(self: ptr IXMLDOMParseError, sourceString: ptr BSTR): HRESULT {.stdcall.}
    get_line*: proc(self: ptr IXMLDOMParseError, lineNumber: ptr LONG): HRESULT {.stdcall.}
    get_linepos*: proc(self: ptr IXMLDOMParseError, linePosition: ptr LONG): HRESULT {.stdcall.}
    get_filepos*: proc(self: ptr IXMLDOMParseError, filePosition: ptr LONG): HRESULT {.stdcall.}
  IXMLDOMDocument* {.pure.} = object
    lpVtbl*: ptr IXMLDOMDocumentVtbl
  IXMLDOMDocumentVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    get_doctype*: proc(self: ptr IXMLDOMDocument, documentType: ptr ptr IXMLDOMDocumentType): HRESULT {.stdcall.}
    get_implementation*: proc(self: ptr IXMLDOMDocument, impl: ptr ptr IXMLDOMImplementation): HRESULT {.stdcall.}
    get_documentElement*: proc(self: ptr IXMLDOMDocument, DOMElement: ptr ptr IXMLDOMElement): HRESULT {.stdcall.}
    putref_documentElement*: proc(self: ptr IXMLDOMDocument, DOMElement: ptr IXMLDOMElement): HRESULT {.stdcall.}
    createElement*: proc(self: ptr IXMLDOMDocument, tagName: BSTR, element: ptr ptr IXMLDOMElement): HRESULT {.stdcall.}
    createDocumentFragment*: proc(self: ptr IXMLDOMDocument, docFrag: ptr ptr IXMLDOMDocumentFragment): HRESULT {.stdcall.}
    createTextNode*: proc(self: ptr IXMLDOMDocument, data: BSTR, text: ptr ptr IXMLDOMText): HRESULT {.stdcall.}
    createComment*: proc(self: ptr IXMLDOMDocument, data: BSTR, comment: ptr ptr IXMLDOMComment): HRESULT {.stdcall.}
    createCDATASection*: proc(self: ptr IXMLDOMDocument, data: BSTR, cdata: ptr ptr IXMLDOMCDATASection): HRESULT {.stdcall.}
    createProcessingInstruction*: proc(self: ptr IXMLDOMDocument, target: BSTR, data: BSTR, pi: ptr ptr IXMLDOMProcessingInstruction): HRESULT {.stdcall.}
    createAttribute*: proc(self: ptr IXMLDOMDocument, name: BSTR, attribute: ptr ptr IXMLDOMAttribute): HRESULT {.stdcall.}
    createEntityReference*: proc(self: ptr IXMLDOMDocument, name: BSTR, entityRef: ptr ptr IXMLDOMEntityReference): HRESULT {.stdcall.}
    getElementsByTagName*: proc(self: ptr IXMLDOMDocument, tagName: BSTR, resultList: ptr ptr IXMLDOMNodeList): HRESULT {.stdcall.}
    createNode*: proc(self: ptr IXMLDOMDocument, Type: VARIANT, name: BSTR, namespaceURI: BSTR, node: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    nodeFromID*: proc(self: ptr IXMLDOMDocument, idString: BSTR, node: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    load*: proc(self: ptr IXMLDOMDocument, xmlSource: VARIANT, isSuccessful: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_readyState*: proc(self: ptr IXMLDOMDocument, value: ptr LONG): HRESULT {.stdcall.}
    get_parseError*: proc(self: ptr IXMLDOMDocument, errorObj: ptr ptr IXMLDOMParseError): HRESULT {.stdcall.}
    get_url*: proc(self: ptr IXMLDOMDocument, urlString: ptr BSTR): HRESULT {.stdcall.}
    get_async*: proc(self: ptr IXMLDOMDocument, isAsync: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_async*: proc(self: ptr IXMLDOMDocument, isAsync: VARIANT_BOOL): HRESULT {.stdcall.}
    abort*: proc(self: ptr IXMLDOMDocument): HRESULT {.stdcall.}
    loadXML*: proc(self: ptr IXMLDOMDocument, bstrXML: BSTR, isSuccessful: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    save*: proc(self: ptr IXMLDOMDocument, destination: VARIANT): HRESULT {.stdcall.}
    get_validateOnParse*: proc(self: ptr IXMLDOMDocument, isValidating: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_validateOnParse*: proc(self: ptr IXMLDOMDocument, isValidating: VARIANT_BOOL): HRESULT {.stdcall.}
    get_resolveExternals*: proc(self: ptr IXMLDOMDocument, isResolving: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_resolveExternals*: proc(self: ptr IXMLDOMDocument, isResolving: VARIANT_BOOL): HRESULT {.stdcall.}
    get_preserveWhiteSpace*: proc(self: ptr IXMLDOMDocument, isPreserving: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_preserveWhiteSpace*: proc(self: ptr IXMLDOMDocument, isPreserving: VARIANT_BOOL): HRESULT {.stdcall.}
    put_onreadystatechange*: proc(self: ptr IXMLDOMDocument, readystatechangeSink: VARIANT): HRESULT {.stdcall.}
    put_ondataavailable*: proc(self: ptr IXMLDOMDocument, ondataavailableSink: VARIANT): HRESULT {.stdcall.}
    put_ontransformnode*: proc(self: ptr IXMLDOMDocument, ontransformnodeSink: VARIANT): HRESULT {.stdcall.}
  IXMLDOMNamedNodeMap* {.pure.} = object
    lpVtbl*: ptr IXMLDOMNamedNodeMapVtbl
  IXMLDOMNamedNodeMapVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    getNamedItem*: proc(self: ptr IXMLDOMNamedNodeMap, name: BSTR, namedItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    setNamedItem*: proc(self: ptr IXMLDOMNamedNodeMap, newItem: ptr IXMLDOMNode, nameItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    removeNamedItem*: proc(self: ptr IXMLDOMNamedNodeMap, name: BSTR, namedItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_item*: proc(self: ptr IXMLDOMNamedNodeMap, index: LONG, listItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    get_length*: proc(self: ptr IXMLDOMNamedNodeMap, listLength: ptr LONG): HRESULT {.stdcall.}
    getQualifiedItem*: proc(self: ptr IXMLDOMNamedNodeMap, baseName: BSTR, namespaceURI: BSTR, qualifiedItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    removeQualifiedItem*: proc(self: ptr IXMLDOMNamedNodeMap, baseName: BSTR, namespaceURI: BSTR, qualifiedItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    nextNode*: proc(self: ptr IXMLDOMNamedNodeMap, nextItem: ptr ptr IXMLDOMNode): HRESULT {.stdcall.}
    reset*: proc(self: ptr IXMLDOMNamedNodeMap): HRESULT {.stdcall.}
    get_newEnum*: proc(self: ptr IXMLDOMNamedNodeMap, ppUnk: ptr ptr IUnknown): HRESULT {.stdcall.}
  IXMLDOMNotation* {.pure.} = object
    lpVtbl*: ptr IXMLDOMNotationVtbl
  IXMLDOMNotationVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    get_publicId*: proc(self: ptr IXMLDOMNotation, publicID: ptr VARIANT): HRESULT {.stdcall.}
    get_systemId*: proc(self: ptr IXMLDOMNotation, systemID: ptr VARIANT): HRESULT {.stdcall.}
  IXMLDOMEntity* {.pure.} = object
    lpVtbl*: ptr IXMLDOMEntityVtbl
  IXMLDOMEntityVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    get_publicId*: proc(self: ptr IXMLDOMEntity, publicID: ptr VARIANT): HRESULT {.stdcall.}
    get_systemId*: proc(self: ptr IXMLDOMEntity, systemID: ptr VARIANT): HRESULT {.stdcall.}
    get_notationName*: proc(self: ptr IXMLDOMEntity, name: ptr BSTR): HRESULT {.stdcall.}
  IXTLRuntime* {.pure.} = object
    lpVtbl*: ptr IXTLRuntimeVtbl
  IXTLRuntimeVtbl* {.pure, inheritable.} = object of IXMLDOMNodeVtbl
    uniqueID*: proc(self: ptr IXTLRuntime, pNode: ptr IXMLDOMNode, pID: ptr LONG): HRESULT {.stdcall.}
    depth*: proc(self: ptr IXTLRuntime, pNode: ptr IXMLDOMNode, pDepth: ptr LONG): HRESULT {.stdcall.}
    childNumber*: proc(self: ptr IXTLRuntime, pNode: ptr IXMLDOMNode, pNumber: ptr LONG): HRESULT {.stdcall.}
    ancestorChildNumber*: proc(self: ptr IXTLRuntime, bstrNodeName: BSTR, pNode: ptr IXMLDOMNode, pNumber: ptr LONG): HRESULT {.stdcall.}
    absoluteChildNumber*: proc(self: ptr IXTLRuntime, pNode: ptr IXMLDOMNode, pNumber: ptr LONG): HRESULT {.stdcall.}
    formatIndex*: proc(self: ptr IXTLRuntime, lIndex: LONG, bstrFormat: BSTR, pbstrFormattedString: ptr BSTR): HRESULT {.stdcall.}
    formatNumber*: proc(self: ptr IXTLRuntime, dblNumber: float64, bstrFormat: BSTR, pbstrFormattedString: ptr BSTR): HRESULT {.stdcall.}
    formatDate*: proc(self: ptr IXTLRuntime, varDate: VARIANT, bstrFormat: BSTR, varDestLocale: VARIANT, pbstrFormattedString: ptr BSTR): HRESULT {.stdcall.}
    formatTime*: proc(self: ptr IXTLRuntime, varTime: VARIANT, bstrFormat: BSTR, varDestLocale: VARIANT, pbstrFormattedString: ptr BSTR): HRESULT {.stdcall.}
  XMLDOMDocumentEvents* {.pure.} = object
    lpVtbl*: ptr XMLDOMDocumentEventsVtbl
  XMLDOMDocumentEventsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  IXMLHttpRequest* {.pure.} = object
    lpVtbl*: ptr IXMLHttpRequestVtbl
  IXMLHttpRequestVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    open*: proc(self: ptr IXMLHttpRequest, bstrMethod: BSTR, bstrUrl: BSTR, varAsync: VARIANT, bstrUser: VARIANT, bstrPassword: VARIANT): HRESULT {.stdcall.}
    setRequestHeader*: proc(self: ptr IXMLHttpRequest, bstrHeader: BSTR, bstrValue: BSTR): HRESULT {.stdcall.}
    getResponseHeader*: proc(self: ptr IXMLHttpRequest, bstrHeader: BSTR, pbstrValue: ptr BSTR): HRESULT {.stdcall.}
    getAllResponseHeaders*: proc(self: ptr IXMLHttpRequest, pbstrHeaders: ptr BSTR): HRESULT {.stdcall.}
    send*: proc(self: ptr IXMLHttpRequest, varBody: VARIANT): HRESULT {.stdcall.}
    abort*: proc(self: ptr IXMLHttpRequest): HRESULT {.stdcall.}
    get_status*: proc(self: ptr IXMLHttpRequest, plStatus: ptr LONG): HRESULT {.stdcall.}
    get_statusText*: proc(self: ptr IXMLHttpRequest, pbstrStatus: ptr BSTR): HRESULT {.stdcall.}
    get_responseXML*: proc(self: ptr IXMLHttpRequest, ppBody: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_responseText*: proc(self: ptr IXMLHttpRequest, pbstrBody: ptr BSTR): HRESULT {.stdcall.}
    get_responseBody*: proc(self: ptr IXMLHttpRequest, pvarBody: ptr VARIANT): HRESULT {.stdcall.}
    get_responseStream*: proc(self: ptr IXMLHttpRequest, pvarBody: ptr VARIANT): HRESULT {.stdcall.}
    get_readyState*: proc(self: ptr IXMLHttpRequest, plState: ptr LONG): HRESULT {.stdcall.}
    put_onreadystatechange*: proc(self: ptr IXMLHttpRequest, pReadyStateSink: ptr IDispatch): HRESULT {.stdcall.}
  IXMLDSOControl* {.pure.} = object
    lpVtbl*: ptr IXMLDSOControlVtbl
  IXMLDSOControlVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_XMLDocument*: proc(self: ptr IXMLDSOControl, ppDoc: ptr ptr IXMLDOMDocument): HRESULT {.stdcall.}
    put_XMLDocument*: proc(self: ptr IXMLDSOControl, ppDoc: ptr IXMLDOMDocument): HRESULT {.stdcall.}
    get_JavaDSOCompatible*: proc(self: ptr IXMLDSOControl, fJavaDSOCompatible: ptr WINBOOL): HRESULT {.stdcall.}
    put_JavaDSOCompatible*: proc(self: ptr IXMLDSOControl, fJavaDSOCompatible: WINBOOL): HRESULT {.stdcall.}
    get_readyState*: proc(self: ptr IXMLDSOControl, state: ptr LONG): HRESULT {.stdcall.}
  IXMLElementCollection* {.pure.} = object
    lpVtbl*: ptr IXMLElementCollectionVtbl
  IXMLElementCollectionVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    put_length*: proc(self: ptr IXMLElementCollection, v: LONG): HRESULT {.stdcall.}
    get_length*: proc(self: ptr IXMLElementCollection, p: ptr LONG): HRESULT {.stdcall.}
    get_newEnum*: proc(self: ptr IXMLElementCollection, ppUnk: ptr ptr IUnknown): HRESULT {.stdcall.}
    item*: proc(self: ptr IXMLElementCollection, var1: VARIANT, var2: VARIANT, ppDisp: ptr ptr IDispatch): HRESULT {.stdcall.}
  IXMLElement* {.pure.} = object
    lpVtbl*: ptr IXMLElementVtbl
  IXMLElementVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_tagName*: proc(self: ptr IXMLElement, p: ptr BSTR): HRESULT {.stdcall.}
    put_tagName*: proc(self: ptr IXMLElement, p: BSTR): HRESULT {.stdcall.}
    get_parent*: proc(self: ptr IXMLElement, ppParent: ptr ptr IXMLElement): HRESULT {.stdcall.}
    setAttribute*: proc(self: ptr IXMLElement, strPropertyName: BSTR, PropertyValue: VARIANT): HRESULT {.stdcall.}
    getAttribute*: proc(self: ptr IXMLElement, strPropertyName: BSTR, PropertyValue: ptr VARIANT): HRESULT {.stdcall.}
    removeAttribute*: proc(self: ptr IXMLElement, strPropertyName: BSTR): HRESULT {.stdcall.}
    get_children*: proc(self: ptr IXMLElement, pp: ptr ptr IXMLElementCollection): HRESULT {.stdcall.}
    get_type*: proc(self: ptr IXMLElement, plType: ptr LONG): HRESULT {.stdcall.}
    get_text*: proc(self: ptr IXMLElement, p: ptr BSTR): HRESULT {.stdcall.}
    put_text*: proc(self: ptr IXMLElement, p: BSTR): HRESULT {.stdcall.}
    addChild*: proc(self: ptr IXMLElement, pChildElem: ptr IXMLElement, lIndex: LONG, lReserved: LONG): HRESULT {.stdcall.}
    removeChild*: proc(self: ptr IXMLElement, pChildElem: ptr IXMLElement): HRESULT {.stdcall.}
  IXMLDocument* {.pure.} = object
    lpVtbl*: ptr IXMLDocumentVtbl
  IXMLDocumentVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_root*: proc(self: ptr IXMLDocument, p: ptr ptr IXMLElement): HRESULT {.stdcall.}
    get_fileSize*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    get_fileModifiedDate*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    get_fileUpdatedDate*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    get_URL*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    put_URL*: proc(self: ptr IXMLDocument, p: BSTR): HRESULT {.stdcall.}
    get_mimeType*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    get_readyState*: proc(self: ptr IXMLDocument, pl: ptr LONG): HRESULT {.stdcall.}
    get_charset*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    put_charset*: proc(self: ptr IXMLDocument, p: BSTR): HRESULT {.stdcall.}
    get_version*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    get_doctype*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    get_dtdURL*: proc(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.stdcall.}
    createElement*: proc(self: ptr IXMLDocument, vType: VARIANT, var1: VARIANT, ppElem: ptr ptr IXMLElement): HRESULT {.stdcall.}
  IXMLElement2* {.pure.} = object
    lpVtbl*: ptr IXMLElement2Vtbl
  IXMLElement2Vtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_tagName*: proc(self: ptr IXMLElement2, p: ptr BSTR): HRESULT {.stdcall.}
    put_tagName*: proc(self: ptr IXMLElement2, p: BSTR): HRESULT {.stdcall.}
    get_parent*: proc(self: ptr IXMLElement2, ppParent: ptr ptr IXMLElement2): HRESULT {.stdcall.}
    setAttribute*: proc(self: ptr IXMLElement2, strPropertyName: BSTR, PropertyValue: VARIANT): HRESULT {.stdcall.}
    getAttribute*: proc(self: ptr IXMLElement2, strPropertyName: BSTR, PropertyValue: ptr VARIANT): HRESULT {.stdcall.}
    removeAttribute*: proc(self: ptr IXMLElement2, strPropertyName: BSTR): HRESULT {.stdcall.}
    get_children*: proc(self: ptr IXMLElement2, pp: ptr ptr IXMLElementCollection): HRESULT {.stdcall.}
    get_type*: proc(self: ptr IXMLElement2, plType: ptr LONG): HRESULT {.stdcall.}
    get_text*: proc(self: ptr IXMLElement2, p: ptr BSTR): HRESULT {.stdcall.}
    put_text*: proc(self: ptr IXMLElement2, p: BSTR): HRESULT {.stdcall.}
    addChild*: proc(self: ptr IXMLElement2, pChildElem: ptr IXMLElement2, lIndex: LONG, lReserved: LONG): HRESULT {.stdcall.}
    removeChild*: proc(self: ptr IXMLElement2, pChildElem: ptr IXMLElement2): HRESULT {.stdcall.}
    get_attributes*: proc(self: ptr IXMLElement2, pp: ptr ptr IXMLElementCollection): HRESULT {.stdcall.}
  IXMLDocument2* {.pure.} = object
    lpVtbl*: ptr IXMLDocument2Vtbl
  IXMLDocument2Vtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_root*: proc(self: ptr IXMLDocument2, p: ptr ptr IXMLElement2): HRESULT {.stdcall.}
    get_fileSize*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    get_fileModifiedDate*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    get_fileUpdatedDate*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    get_URL*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    put_URL*: proc(self: ptr IXMLDocument2, p: BSTR): HRESULT {.stdcall.}
    get_mimeType*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    get_readyState*: proc(self: ptr IXMLDocument2, pl: ptr LONG): HRESULT {.stdcall.}
    get_charset*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    put_charset*: proc(self: ptr IXMLDocument2, p: BSTR): HRESULT {.stdcall.}
    get_version*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    get_doctype*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    get_dtdURL*: proc(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.stdcall.}
    createElement*: proc(self: ptr IXMLDocument2, vType: VARIANT, var1: VARIANT, ppElem: ptr ptr IXMLElement2): HRESULT {.stdcall.}
    get_async*: proc(self: ptr IXMLDocument2, pf: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_async*: proc(self: ptr IXMLDocument2, f: VARIANT_BOOL): HRESULT {.stdcall.}
  IXMLAttribute* {.pure.} = object
    lpVtbl*: ptr IXMLAttributeVtbl
  IXMLAttributeVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_name*: proc(self: ptr IXMLAttribute, n: ptr BSTR): HRESULT {.stdcall.}
    get_value*: proc(self: ptr IXMLAttribute, v: ptr BSTR): HRESULT {.stdcall.}
  IXMLError* {.pure.} = object
    lpVtbl*: ptr IXMLErrorVtbl
  IXMLErrorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetErrorInfo*: proc(self: ptr IXMLError, pErrorReturn: ptr XML_ERROR): HRESULT {.stdcall.}
  IUriContainer* {.pure.} = object
    lpVtbl*: ptr IUriContainerVtbl
  IUriContainerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetIUri*: proc(self: ptr IUriContainer, ppIUri: ptr ptr IUri): HRESULT {.stdcall.}
  IUriBuilder* {.pure.} = object
    lpVtbl*: ptr IUriBuilderVtbl
  IUriBuilderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateUriSimple*: proc(self: ptr IUriBuilder, dwAllowEncodingPropertyMask: DWORD, dwReserved: DWORD_PTR, ppIUri: ptr ptr IUri): HRESULT {.stdcall.}
    CreateUri*: proc(self: ptr IUriBuilder, dwCreateFlags: DWORD, dwAllowEncodingPropertyMask: DWORD, dwReserved: DWORD_PTR, ppIUri: ptr ptr IUri): HRESULT {.stdcall.}
    CreateUriWithFlags*: proc(self: ptr IUriBuilder, dwCreateFlags: DWORD, dwUriBuilderFlags: DWORD, dwAllowEncodingPropertyMask: DWORD, dwReserved: DWORD_PTR, ppIUri: ptr ptr IUri): HRESULT {.stdcall.}
    GetIUri*: proc(self: ptr IUriBuilder, ppIUri: ptr ptr IUri): HRESULT {.stdcall.}
    SetIUri*: proc(self: ptr IUriBuilder, pIUri: ptr IUri): HRESULT {.stdcall.}
    GetFragment*: proc(self: ptr IUriBuilder, pcchFragment: ptr DWORD, ppwzFragment: ptr LPCWSTR): HRESULT {.stdcall.}
    GetHost*: proc(self: ptr IUriBuilder, pcchHost: ptr DWORD, ppwzHost: ptr LPCWSTR): HRESULT {.stdcall.}
    GetPassword*: proc(self: ptr IUriBuilder, pcchPassword: ptr DWORD, ppwzPassword: ptr LPCWSTR): HRESULT {.stdcall.}
    GetPath*: proc(self: ptr IUriBuilder, pcchPath: ptr DWORD, ppwzPath: ptr LPCWSTR): HRESULT {.stdcall.}
    GetPort*: proc(self: ptr IUriBuilder, pfHasPort: ptr WINBOOL, pdwPort: ptr DWORD): HRESULT {.stdcall.}
    GetQuery*: proc(self: ptr IUriBuilder, pcchQuery: ptr DWORD, ppwzQuery: ptr LPCWSTR): HRESULT {.stdcall.}
    GetSchemeName*: proc(self: ptr IUriBuilder, pcchSchemeName: ptr DWORD, ppwzSchemeName: ptr LPCWSTR): HRESULT {.stdcall.}
    GetUserName*: proc(self: ptr IUriBuilder, pcchUserName: ptr DWORD, ppwzUserName: ptr LPCWSTR): HRESULT {.stdcall.}
    SetFragment*: proc(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.stdcall.}
    SetHost*: proc(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.stdcall.}
    SetPassword*: proc(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.stdcall.}
    SetPath*: proc(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.stdcall.}
    SetPort*: proc(self: ptr IUriBuilder, fHasPort: WINBOOL, dwNewValue: DWORD): HRESULT {.stdcall.}
    SetQuery*: proc(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.stdcall.}
    SetSchemeName*: proc(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.stdcall.}
    SetUserName*: proc(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.stdcall.}
    RemoveProperties*: proc(self: ptr IUriBuilder, dwPropertyMask: DWORD): HRESULT {.stdcall.}
    HasBeenModified*: proc(self: ptr IUriBuilder, pfModified: ptr WINBOOL): HRESULT {.stdcall.}
  IUriBuilderFactory* {.pure.} = object
    lpVtbl*: ptr IUriBuilderFactoryVtbl
  IUriBuilderFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateIUriBuilder*: proc(self: ptr IUriBuilderFactory, dwFlags: DWORD, dwReserved: DWORD_PTR, ppIUriBuilder: ptr ptr IUriBuilder): HRESULT {.stdcall.}
    CreateInitializedIUriBuilder*: proc(self: ptr IUriBuilderFactory, dwFlags: DWORD, dwReserved: DWORD_PTR, ppIUriBuilder: ptr ptr IUriBuilder): HRESULT {.stdcall.}
  IWinInetHttpTimeouts* {.pure.} = object
    lpVtbl*: ptr IWinInetHttpTimeoutsVtbl
  IWinInetHttpTimeoutsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetRequestTimeouts*: proc(self: ptr IWinInetHttpTimeouts, pdwConnectTimeout: ptr DWORD, pdwSendTimeout: ptr DWORD, pdwReceiveTimeout: ptr DWORD): HRESULT {.stdcall.}
  IInternetSecurityMgrSite* {.pure.} = object
    lpVtbl*: ptr IInternetSecurityMgrSiteVtbl
  IInternetSecurityMgrSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetWindow*: proc(self: ptr IInternetSecurityMgrSite, phwnd: ptr HWND): HRESULT {.stdcall.}
    EnableModeless*: proc(self: ptr IInternetSecurityMgrSite, fEnable: WINBOOL): HRESULT {.stdcall.}
  IInternetSecurityManager* {.pure.} = object
    lpVtbl*: ptr IInternetSecurityManagerVtbl
  IInternetSecurityManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetSecuritySite*: proc(self: ptr IInternetSecurityManager, pSite: ptr IInternetSecurityMgrSite): HRESULT {.stdcall.}
    GetSecuritySite*: proc(self: ptr IInternetSecurityManager, ppSite: ptr ptr IInternetSecurityMgrSite): HRESULT {.stdcall.}
    MapUrlToZone*: proc(self: ptr IInternetSecurityManager, pwszUrl: LPCWSTR, pdwZone: ptr DWORD, dwFlags: DWORD): HRESULT {.stdcall.}
    GetSecurityId*: proc(self: ptr IInternetSecurityManager, pwszUrl: LPCWSTR, pbSecurityId: ptr BYTE, pcbSecurityId: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.stdcall.}
    ProcessUrlAction*: proc(self: ptr IInternetSecurityManager, pwszUrl: LPCWSTR, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, pContext: ptr BYTE, cbContext: DWORD, dwFlags: DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
    QueryCustomPolicy*: proc(self: ptr IInternetSecurityManager, pwszUrl: LPCWSTR, guidKey: REFGUID, ppPolicy: ptr ptr BYTE, pcbPolicy: ptr DWORD, pContext: ptr BYTE, cbContext: DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
    SetZoneMapping*: proc(self: ptr IInternetSecurityManager, dwZone: DWORD, lpszPattern: LPCWSTR, dwFlags: DWORD): HRESULT {.stdcall.}
    GetZoneMappings*: proc(self: ptr IInternetSecurityManager, dwZone: DWORD, ppenumString: ptr ptr IEnumString, dwFlags: DWORD): HRESULT {.stdcall.}
  IInternetSecurityManagerEx* {.pure.} = object
    lpVtbl*: ptr IInternetSecurityManagerExVtbl
  IInternetSecurityManagerExVtbl* {.pure, inheritable.} = object of IInternetSecurityManagerVtbl
    ProcessUrlActionEx*: proc(self: ptr IInternetSecurityManagerEx, pwszUrl: LPCWSTR, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, pContext: ptr BYTE, cbContext: DWORD, dwFlags: DWORD, dwReserved: DWORD, pdwOutFlags: ptr DWORD): HRESULT {.stdcall.}
  IInternetSecurityManagerEx2* {.pure.} = object
    lpVtbl*: ptr IInternetSecurityManagerEx2Vtbl
  IInternetSecurityManagerEx2Vtbl* {.pure, inheritable.} = object of IInternetSecurityManagerExVtbl
    MapUrlToZoneEx2*: proc(self: ptr IInternetSecurityManagerEx2, pUri: ptr IUri, pdwZone: ptr DWORD, dwFlags: DWORD, ppwszMappedUrl: ptr LPWSTR, pdwOutFlags: ptr DWORD): HRESULT {.stdcall.}
    ProcessUrlActionEx2*: proc(self: ptr IInternetSecurityManagerEx2, pUri: ptr IUri, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, pContext: ptr BYTE, cbContext: DWORD, dwFlags: DWORD, dwReserved: DWORD_PTR, pdwOutFlags: ptr DWORD): HRESULT {.stdcall.}
    GetSecurityIdEx2*: proc(self: ptr IInternetSecurityManagerEx2, pUri: ptr IUri, pbSecurityId: ptr BYTE, pcbSecurityId: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.stdcall.}
    QueryCustomPolicyEx2*: proc(self: ptr IInternetSecurityManagerEx2, pUri: ptr IUri, guidKey: REFGUID, ppPolicy: ptr ptr BYTE, pcbPolicy: ptr DWORD, pContext: ptr BYTE, cbContext: DWORD, dwReserved: DWORD_PTR): HRESULT {.stdcall.}
  IZoneIdentifier* {.pure.} = object
    lpVtbl*: ptr IZoneIdentifierVtbl
  IZoneIdentifierVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetId*: proc(self: ptr IZoneIdentifier, pdwZone: ptr DWORD): HRESULT {.stdcall.}
    SetId*: proc(self: ptr IZoneIdentifier, dwZone: DWORD): HRESULT {.stdcall.}
    Remove*: proc(self: ptr IZoneIdentifier): HRESULT {.stdcall.}
  IInternetHostSecurityManager* {.pure.} = object
    lpVtbl*: ptr IInternetHostSecurityManagerVtbl
  IInternetHostSecurityManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSecurityId*: proc(self: ptr IInternetHostSecurityManager, pbSecurityId: ptr BYTE, pcbSecurityId: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.stdcall.}
    ProcessUrlAction*: proc(self: ptr IInternetHostSecurityManager, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, pContext: ptr BYTE, cbContext: DWORD, dwFlags: DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
    QueryCustomPolicy*: proc(self: ptr IInternetHostSecurityManager, guidKey: REFGUID, ppPolicy: ptr ptr BYTE, pcbPolicy: ptr DWORD, pContext: ptr BYTE, cbContext: DWORD, dwReserved: DWORD): HRESULT {.stdcall.}
  IInternetZoneManagerEx* {.pure.} = object
    lpVtbl*: ptr IInternetZoneManagerExVtbl
  IInternetZoneManagerExVtbl* {.pure, inheritable.} = object of IInternetZoneManagerVtbl
    GetZoneActionPolicyEx*: proc(self: ptr IInternetZoneManagerEx, dwZone: DWORD, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG, dwFlags: DWORD): HRESULT {.stdcall.}
    SetZoneActionPolicyEx*: proc(self: ptr IInternetZoneManagerEx, dwZone: DWORD, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG, dwFlags: DWORD): HRESULT {.stdcall.}
  IInternetZoneManagerEx2* {.pure.} = object
    lpVtbl*: ptr IInternetZoneManagerEx2Vtbl
  IInternetZoneManagerEx2Vtbl* {.pure, inheritable.} = object of IInternetZoneManagerExVtbl
    GetZoneAttributesEx*: proc(self: ptr IInternetZoneManagerEx2, dwZone: DWORD, pZoneAttributes: ptr ZONEATTRIBUTES, dwFlags: DWORD): HRESULT {.stdcall.}
    GetZoneSecurityState*: proc(self: ptr IInternetZoneManagerEx2, dwZoneIndex: DWORD, fRespectPolicy: WINBOOL, pdwState: LPDWORD, pfPolicyEncountered: ptr WINBOOL): HRESULT {.stdcall.}
    GetIESecurityState*: proc(self: ptr IInternetZoneManagerEx2, fRespectPolicy: WINBOOL, pdwState: LPDWORD, pfPolicyEncountered: ptr WINBOOL, fNoCache: WINBOOL): HRESULT {.stdcall.}
    FixUnsecureSettings*: proc(self: ptr IInternetZoneManagerEx2): HRESULT {.stdcall.}
  ISoftDistExt* {.pure.} = object
    lpVtbl*: ptr ISoftDistExtVtbl
  ISoftDistExtVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ProcessSoftDist*: proc(self: ptr ISoftDistExt, szCDFURL: LPCWSTR, pSoftDistElement: ptr IXMLElement, lpsdi: LPSOFTDISTINFO): HRESULT {.stdcall.}
    GetFirstCodeBase*: proc(self: ptr ISoftDistExt, szCodeBase: ptr LPWSTR, dwMaxSize: LPDWORD): HRESULT {.stdcall.}
    GetNextCodeBase*: proc(self: ptr ISoftDistExt, szCodeBase: ptr LPWSTR, dwMaxSize: LPDWORD): HRESULT {.stdcall.}
    AsyncInstallDistributionUnit*: proc(self: ptr ISoftDistExt, pbc: ptr IBindCtx, pvReserved: LPVOID, flags: DWORD, lpcbh: LPCODEBASEHOLD): HRESULT {.stdcall.}
  IZoomEvents* {.pure.} = object
    lpVtbl*: ptr IZoomEventsVtbl
  IZoomEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnZoomPercentChanged*: proc(self: ptr IZoomEvents, ulZoomPercent: ULONG): HRESULT {.stdcall.}
  IProtectFocus* {.pure.} = object
    lpVtbl*: ptr IProtectFocusVtbl
  IProtectFocusVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AllowFocusChange*: proc(self: ptr IProtectFocus, pfAllow: ptr WINBOOL): HRESULT {.stdcall.}
  IProtectedModeMenuServices* {.pure.} = object
    lpVtbl*: ptr IProtectedModeMenuServicesVtbl
  IProtectedModeMenuServicesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateMenu*: proc(self: ptr IProtectedModeMenuServices, phMenu: ptr HMENU): HRESULT {.stdcall.}
    LoadMenu*: proc(self: ptr IProtectedModeMenuServices, pszModuleName: LPCWSTR, pszMenuName: LPCWSTR, phMenu: ptr HMENU): HRESULT {.stdcall.}
    LoadMenuID*: proc(self: ptr IProtectedModeMenuServices, pszModuleName: LPCWSTR, wResourceID: WORD, phMenu: ptr HMENU): HRESULT {.stdcall.}
  IWebBrowser* {.pure.} = object
    lpVtbl*: ptr IWebBrowserVtbl
  IWebBrowserVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    GoBack*: proc(self: ptr IWebBrowser): HRESULT {.stdcall.}
    GoForward*: proc(self: ptr IWebBrowser): HRESULT {.stdcall.}
    GoHome*: proc(self: ptr IWebBrowser): HRESULT {.stdcall.}
    GoSearch*: proc(self: ptr IWebBrowser): HRESULT {.stdcall.}
    Navigate*: proc(self: ptr IWebBrowser, URL: BSTR, Flags: ptr VARIANT, TargetFrameName: ptr VARIANT, PostData: ptr VARIANT, Headers: ptr VARIANT): HRESULT {.stdcall.}
    Refresh*: proc(self: ptr IWebBrowser): HRESULT {.stdcall.}
    Refresh2*: proc(self: ptr IWebBrowser, Level: ptr VARIANT): HRESULT {.stdcall.}
    Stop*: proc(self: ptr IWebBrowser): HRESULT {.stdcall.}
    get_Application*: proc(self: ptr IWebBrowser, ppDisp: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Parent*: proc(self: ptr IWebBrowser, ppDisp: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Container*: proc(self: ptr IWebBrowser, ppDisp: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_Document*: proc(self: ptr IWebBrowser, ppDisp: ptr ptr IDispatch): HRESULT {.stdcall.}
    get_TopLevelContainer*: proc(self: ptr IWebBrowser, pBool: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_Type*: proc(self: ptr IWebBrowser, Type: ptr BSTR): HRESULT {.stdcall.}
    get_Left*: proc(self: ptr IWebBrowser, pl: ptr LONG): HRESULT {.stdcall.}
    put_Left*: proc(self: ptr IWebBrowser, Left: LONG): HRESULT {.stdcall.}
    get_Top*: proc(self: ptr IWebBrowser, pl: ptr LONG): HRESULT {.stdcall.}
    put_Top*: proc(self: ptr IWebBrowser, Top: LONG): HRESULT {.stdcall.}
    get_Width*: proc(self: ptr IWebBrowser, pl: ptr LONG): HRESULT {.stdcall.}
    put_Width*: proc(self: ptr IWebBrowser, Width: LONG): HRESULT {.stdcall.}
    get_Height*: proc(self: ptr IWebBrowser, pl: ptr LONG): HRESULT {.stdcall.}
    put_Height*: proc(self: ptr IWebBrowser, Height: LONG): HRESULT {.stdcall.}
    get_LocationName*: proc(self: ptr IWebBrowser, LocationName: ptr BSTR): HRESULT {.stdcall.}
    get_LocationURL*: proc(self: ptr IWebBrowser, LocationURL: ptr BSTR): HRESULT {.stdcall.}
    get_Busy*: proc(self: ptr IWebBrowser, pBool: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  DWebBrowserEvents* {.pure.} = object
    lpVtbl*: ptr DWebBrowserEventsVtbl
  DWebBrowserEventsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  IWebBrowserApp* {.pure.} = object
    lpVtbl*: ptr IWebBrowserAppVtbl
  IWebBrowserAppVtbl* {.pure, inheritable.} = object of IWebBrowserVtbl
    Quit*: proc(self: ptr IWebBrowserApp): HRESULT {.stdcall.}
    ClientToWindow*: proc(self: ptr IWebBrowserApp, pcx: ptr int32, pcy: ptr int32): HRESULT {.stdcall.}
    PutProperty*: proc(self: ptr IWebBrowserApp, Property: BSTR, vtValue: VARIANT): HRESULT {.stdcall.}
    GetProperty*: proc(self: ptr IWebBrowserApp, Property: BSTR, pvtValue: ptr VARIANT): HRESULT {.stdcall.}
    get_Name*: proc(self: ptr IWebBrowserApp, Name: ptr BSTR): HRESULT {.stdcall.}
    get_HWND*: proc(self: ptr IWebBrowserApp, pHWND: ptr SHANDLE_PTR): HRESULT {.stdcall.}
    get_FullName*: proc(self: ptr IWebBrowserApp, FullName: ptr BSTR): HRESULT {.stdcall.}
    get_Path*: proc(self: ptr IWebBrowserApp, Path: ptr BSTR): HRESULT {.stdcall.}
    get_Visible*: proc(self: ptr IWebBrowserApp, pBool: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_Visible*: proc(self: ptr IWebBrowserApp, Value: VARIANT_BOOL): HRESULT {.stdcall.}
    get_StatusBar*: proc(self: ptr IWebBrowserApp, pBool: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_StatusBar*: proc(self: ptr IWebBrowserApp, Value: VARIANT_BOOL): HRESULT {.stdcall.}
    get_StatusText*: proc(self: ptr IWebBrowserApp, StatusText: ptr BSTR): HRESULT {.stdcall.}
    put_StatusText*: proc(self: ptr IWebBrowserApp, StatusText: BSTR): HRESULT {.stdcall.}
    get_ToolBar*: proc(self: ptr IWebBrowserApp, Value: ptr int32): HRESULT {.stdcall.}
    put_ToolBar*: proc(self: ptr IWebBrowserApp, Value: int32): HRESULT {.stdcall.}
    get_MenuBar*: proc(self: ptr IWebBrowserApp, Value: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_MenuBar*: proc(self: ptr IWebBrowserApp, Value: VARIANT_BOOL): HRESULT {.stdcall.}
    get_FullScreen*: proc(self: ptr IWebBrowserApp, pbFullScreen: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_FullScreen*: proc(self: ptr IWebBrowserApp, bFullScreen: VARIANT_BOOL): HRESULT {.stdcall.}
  IWebBrowser2* {.pure.} = object
    lpVtbl*: ptr IWebBrowser2Vtbl
  IWebBrowser2Vtbl* {.pure, inheritable.} = object of IWebBrowserAppVtbl
    Navigate2*: proc(self: ptr IWebBrowser2, URL: ptr VARIANT, Flags: ptr VARIANT, TargetFrameName: ptr VARIANT, PostData: ptr VARIANT, Headers: ptr VARIANT): HRESULT {.stdcall.}
    QueryStatusWB*: proc(self: ptr IWebBrowser2, cmdID: OLECMDID, pcmdf: ptr OLECMDF): HRESULT {.stdcall.}
    ExecWB*: proc(self: ptr IWebBrowser2, cmdID: OLECMDID, cmdexecopt: OLECMDEXECOPT, pvaIn: ptr VARIANT, pvaOut: ptr VARIANT): HRESULT {.stdcall.}
    ShowBrowserBar*: proc(self: ptr IWebBrowser2, pvaClsid: ptr VARIANT, pvarShow: ptr VARIANT, pvarSize: ptr VARIANT): HRESULT {.stdcall.}
    get_ReadyState*: proc(self: ptr IWebBrowser2, plReadyState: ptr READYSTATE): HRESULT {.stdcall.}
    get_Offline*: proc(self: ptr IWebBrowser2, pbOffline: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_Offline*: proc(self: ptr IWebBrowser2, bOffline: VARIANT_BOOL): HRESULT {.stdcall.}
    get_Silent*: proc(self: ptr IWebBrowser2, pbSilent: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_Silent*: proc(self: ptr IWebBrowser2, bSilent: VARIANT_BOOL): HRESULT {.stdcall.}
    get_RegisterAsBrowser*: proc(self: ptr IWebBrowser2, pbRegister: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_RegisterAsBrowser*: proc(self: ptr IWebBrowser2, bRegister: VARIANT_BOOL): HRESULT {.stdcall.}
    get_RegisterAsDropTarget*: proc(self: ptr IWebBrowser2, pbRegister: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_RegisterAsDropTarget*: proc(self: ptr IWebBrowser2, bRegister: VARIANT_BOOL): HRESULT {.stdcall.}
    get_TheaterMode*: proc(self: ptr IWebBrowser2, pbRegister: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_TheaterMode*: proc(self: ptr IWebBrowser2, bRegister: VARIANT_BOOL): HRESULT {.stdcall.}
    get_AddressBar*: proc(self: ptr IWebBrowser2, Value: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_AddressBar*: proc(self: ptr IWebBrowser2, Value: VARIANT_BOOL): HRESULT {.stdcall.}
    get_Resizable*: proc(self: ptr IWebBrowser2, Value: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_Resizable*: proc(self: ptr IWebBrowser2, Value: VARIANT_BOOL): HRESULT {.stdcall.}
  DWebBrowserEvents2* {.pure.} = object
    lpVtbl*: ptr DWebBrowserEvents2Vtbl
  DWebBrowserEvents2Vtbl* {.pure, inheritable.} = object of IDispatchVtbl
  DShellWindowsEvents* {.pure.} = object
    lpVtbl*: ptr DShellWindowsEventsVtbl
  DShellWindowsEventsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  IShellWindows* {.pure.} = object
    lpVtbl*: ptr IShellWindowsVtbl
  IShellWindowsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Count*: proc(self: ptr IShellWindows, Count: ptr LONG): HRESULT {.stdcall.}
    Item*: proc(self: ptr IShellWindows, index: VARIANT, Folder: ptr ptr IDispatch): HRESULT {.stdcall.}
    NewEnum*: proc(self: ptr IShellWindows, ppunk: ptr ptr IUnknown): HRESULT {.stdcall.}
    Register*: proc(self: ptr IShellWindows, pid: ptr IDispatch, hWnd: LONG, swClass: int32, plCookie: ptr LONG): HRESULT {.stdcall.}
    RegisterPending*: proc(self: ptr IShellWindows, lThreadId: LONG, pvarloc: ptr VARIANT, pvarlocRoot: ptr VARIANT, swClass: int32, plCookie: ptr LONG): HRESULT {.stdcall.}
    Revoke*: proc(self: ptr IShellWindows, lCookie: LONG): HRESULT {.stdcall.}
    OnNavigate*: proc(self: ptr IShellWindows, lCookie: LONG, pvarLoc: ptr VARIANT): HRESULT {.stdcall.}
    OnActivated*: proc(self: ptr IShellWindows, lCookie: LONG, fActive: VARIANT_BOOL): HRESULT {.stdcall.}
    FindWindowSW*: proc(self: ptr IShellWindows, pvarLoc: ptr VARIANT, pvarLocRoot: ptr VARIANT, swClass: int32, phwnd: ptr LONG, swfwOptions: int32, ppdispOut: ptr ptr IDispatch): HRESULT {.stdcall.}
    OnCreated*: proc(self: ptr IShellWindows, lCookie: LONG, punk: ptr IUnknown): HRESULT {.stdcall.}
    ProcessAttachDetach*: proc(self: ptr IShellWindows, fAttach: VARIANT_BOOL): HRESULT {.stdcall.}
  IShellUIHelper* {.pure.} = object
    lpVtbl*: ptr IShellUIHelperVtbl
  IShellUIHelperVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    ResetFirstBootMode*: proc(self: ptr IShellUIHelper): HRESULT {.stdcall.}
    ResetSafeMode*: proc(self: ptr IShellUIHelper): HRESULT {.stdcall.}
    RefreshOfflineDesktop*: proc(self: ptr IShellUIHelper): HRESULT {.stdcall.}
    AddFavorite*: proc(self: ptr IShellUIHelper, URL: BSTR, Title: ptr VARIANT): HRESULT {.stdcall.}
    AddChannel*: proc(self: ptr IShellUIHelper, URL: BSTR): HRESULT {.stdcall.}
    AddDesktopComponent*: proc(self: ptr IShellUIHelper, URL: BSTR, Type: BSTR, Left: ptr VARIANT, Top: ptr VARIANT, Width: ptr VARIANT, Height: ptr VARIANT): HRESULT {.stdcall.}
    IsSubscribed*: proc(self: ptr IShellUIHelper, URL: BSTR, pBool: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    NavigateAndFind*: proc(self: ptr IShellUIHelper, URL: BSTR, strQuery: BSTR, varTargetFrame: ptr VARIANT): HRESULT {.stdcall.}
    ImportExportFavorites*: proc(self: ptr IShellUIHelper, fImport: VARIANT_BOOL, strImpExpPath: BSTR): HRESULT {.stdcall.}
    AutoCompleteSaveForm*: proc(self: ptr IShellUIHelper, Form: ptr VARIANT): HRESULT {.stdcall.}
    AutoScan*: proc(self: ptr IShellUIHelper, strSearch: BSTR, strFailureUrl: BSTR, pvarTargetFrame: ptr VARIANT): HRESULT {.stdcall.}
    AutoCompleteAttach*: proc(self: ptr IShellUIHelper, Reserved: ptr VARIANT): HRESULT {.stdcall.}
    ShowBrowserUI*: proc(self: ptr IShellUIHelper, bstrName: BSTR, pvarIn: ptr VARIANT, pvarOut: ptr VARIANT): HRESULT {.stdcall.}
  IShellUIHelper2* {.pure.} = object
    lpVtbl*: ptr IShellUIHelper2Vtbl
  IShellUIHelper2Vtbl* {.pure, inheritable.} = object of IShellUIHelperVtbl
    AddSearchProvider*: proc(self: ptr IShellUIHelper2, URL: BSTR): HRESULT {.stdcall.}
    RunOnceShown*: proc(self: ptr IShellUIHelper2): HRESULT {.stdcall.}
    SkipRunOnce*: proc(self: ptr IShellUIHelper2): HRESULT {.stdcall.}
    CustomizeSettings*: proc(self: ptr IShellUIHelper2, fSQM: VARIANT_BOOL, fPhishing: VARIANT_BOOL, bstrLocale: BSTR): HRESULT {.stdcall.}
    SqmEnabled*: proc(self: ptr IShellUIHelper2, pfEnabled: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    PhishingEnabled*: proc(self: ptr IShellUIHelper2, pfEnabled: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    BrandImageUri*: proc(self: ptr IShellUIHelper2, pbstrUri: ptr BSTR): HRESULT {.stdcall.}
    SkipTabsWelcome*: proc(self: ptr IShellUIHelper2): HRESULT {.stdcall.}
    DiagnoseConnection*: proc(self: ptr IShellUIHelper2): HRESULT {.stdcall.}
    CustomizeClearType*: proc(self: ptr IShellUIHelper2, fSet: VARIANT_BOOL): HRESULT {.stdcall.}
    IsSearchProviderInstalled*: proc(self: ptr IShellUIHelper2, URL: BSTR, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    IsSearchMigrated*: proc(self: ptr IShellUIHelper2, pfMigrated: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    DefaultSearchProvider*: proc(self: ptr IShellUIHelper2, pbstrName: ptr BSTR): HRESULT {.stdcall.}
    RunOnceRequiredSettingsComplete*: proc(self: ptr IShellUIHelper2, fComplete: VARIANT_BOOL): HRESULT {.stdcall.}
    RunOnceHasShown*: proc(self: ptr IShellUIHelper2, pfShown: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    SearchGuideUrl*: proc(self: ptr IShellUIHelper2, pbstrUrl: ptr BSTR): HRESULT {.stdcall.}
  DShellNameSpaceEvents* {.pure.} = object
    lpVtbl*: ptr DShellNameSpaceEventsVtbl
  DShellNameSpaceEventsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  IShellFavoritesNameSpace* {.pure.} = object
    lpVtbl*: ptr IShellFavoritesNameSpaceVtbl
  IShellFavoritesNameSpaceVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    MoveSelectionUp*: proc(self: ptr IShellFavoritesNameSpace): HRESULT {.stdcall.}
    MoveSelectionDown*: proc(self: ptr IShellFavoritesNameSpace): HRESULT {.stdcall.}
    ResetSort*: proc(self: ptr IShellFavoritesNameSpace): HRESULT {.stdcall.}
    NewFolder*: proc(self: ptr IShellFavoritesNameSpace): HRESULT {.stdcall.}
    Synchronize*: proc(self: ptr IShellFavoritesNameSpace): HRESULT {.stdcall.}
    Import*: proc(self: ptr IShellFavoritesNameSpace): HRESULT {.stdcall.}
    Export*: proc(self: ptr IShellFavoritesNameSpace): HRESULT {.stdcall.}
    InvokeContextMenuCommand*: proc(self: ptr IShellFavoritesNameSpace, strCommand: BSTR): HRESULT {.stdcall.}
    MoveSelectionTo*: proc(self: ptr IShellFavoritesNameSpace): HRESULT {.stdcall.}
    get_SubscriptionsEnabled*: proc(self: ptr IShellFavoritesNameSpace, pBool: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    CreateSubscriptionForSelection*: proc(self: ptr IShellFavoritesNameSpace, pBool: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    DeleteSubscriptionForSelection*: proc(self: ptr IShellFavoritesNameSpace, pBool: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    SetRoot*: proc(self: ptr IShellFavoritesNameSpace, bstrFullPath: BSTR): HRESULT {.stdcall.}
  IShellNameSpace* {.pure.} = object
    lpVtbl*: ptr IShellNameSpaceVtbl
  IShellNameSpaceVtbl* {.pure, inheritable.} = object of IShellFavoritesNameSpaceVtbl
    get_EnumOptions*: proc(self: ptr IShellNameSpace, pgrfEnumFlags: ptr LONG): HRESULT {.stdcall.}
    put_EnumOptions*: proc(self: ptr IShellNameSpace, pgrfEnumFlags: LONG): HRESULT {.stdcall.}
    get_SelectedItem*: proc(self: ptr IShellNameSpace, pItem: ptr ptr IDispatch): HRESULT {.stdcall.}
    put_SelectedItem*: proc(self: ptr IShellNameSpace, pItem: ptr IDispatch): HRESULT {.stdcall.}
    get_Root*: proc(self: ptr IShellNameSpace, pvar: ptr VARIANT): HRESULT {.stdcall.}
    put_Root*: proc(self: ptr IShellNameSpace, pvar: VARIANT): HRESULT {.stdcall.}
    get_Depth*: proc(self: ptr IShellNameSpace, piDepth: ptr int32): HRESULT {.stdcall.}
    put_Depth*: proc(self: ptr IShellNameSpace, piDepth: int32): HRESULT {.stdcall.}
    get_Mode*: proc(self: ptr IShellNameSpace, puMode: ptr int32): HRESULT {.stdcall.}
    put_Mode*: proc(self: ptr IShellNameSpace, puMode: int32): HRESULT {.stdcall.}
    get_Flags*: proc(self: ptr IShellNameSpace, pdwFlags: ptr ULONG): HRESULT {.stdcall.}
    put_Flags*: proc(self: ptr IShellNameSpace, pdwFlags: ULONG): HRESULT {.stdcall.}
    put_TVFlags*: proc(self: ptr IShellNameSpace, dwFlags: ULONG): HRESULT {.stdcall.}
    get_TVFlags*: proc(self: ptr IShellNameSpace, dwFlags: ptr ULONG): HRESULT {.stdcall.}
    get_Columns*: proc(self: ptr IShellNameSpace, bstrColumns: ptr BSTR): HRESULT {.stdcall.}
    put_Columns*: proc(self: ptr IShellNameSpace, bstrColumns: BSTR): HRESULT {.stdcall.}
    get_CountViewTypes*: proc(self: ptr IShellNameSpace, piTypes: ptr int32): HRESULT {.stdcall.}
    SetViewType*: proc(self: ptr IShellNameSpace, iType: int32): HRESULT {.stdcall.}
    SelectedItems*: proc(self: ptr IShellNameSpace, ppid: ptr ptr IDispatch): HRESULT {.stdcall.}
    Expand*: proc(self: ptr IShellNameSpace, `var`: VARIANT, iDepth: int32): HRESULT {.stdcall.}
    UnselectAll*: proc(self: ptr IShellNameSpace): HRESULT {.stdcall.}
  IScriptErrorList* {.pure.} = object
    lpVtbl*: ptr IScriptErrorListVtbl
  IScriptErrorListVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    advanceError*: proc(self: ptr IScriptErrorList): HRESULT {.stdcall.}
    retreatError*: proc(self: ptr IScriptErrorList): HRESULT {.stdcall.}
    canAdvanceError*: proc(self: ptr IScriptErrorList, pfCanAdvance: ptr LONG): HRESULT {.stdcall.}
    canRetreatError*: proc(self: ptr IScriptErrorList, pfCanRetreat: ptr LONG): HRESULT {.stdcall.}
    getErrorLine*: proc(self: ptr IScriptErrorList, plLine: ptr LONG): HRESULT {.stdcall.}
    getErrorChar*: proc(self: ptr IScriptErrorList, plChar: ptr LONG): HRESULT {.stdcall.}
    getErrorCode*: proc(self: ptr IScriptErrorList, plCode: ptr LONG): HRESULT {.stdcall.}
    getErrorMsg*: proc(self: ptr IScriptErrorList, pstr: ptr BSTR): HRESULT {.stdcall.}
    getErrorUrl*: proc(self: ptr IScriptErrorList, pstr: ptr BSTR): HRESULT {.stdcall.}
    getAlwaysShowLockState*: proc(self: ptr IScriptErrorList, pfAlwaysShowLocked: ptr LONG): HRESULT {.stdcall.}
    getDetailsPaneOpen*: proc(self: ptr IScriptErrorList, pfDetailsPaneOpen: ptr LONG): HRESULT {.stdcall.}
    setDetailsPaneOpen*: proc(self: ptr IScriptErrorList, fDetailsPaneOpen: LONG): HRESULT {.stdcall.}
    getPerErrorDisplay*: proc(self: ptr IScriptErrorList, pfPerErrorDisplay: ptr LONG): HRESULT {.stdcall.}
    setPerErrorDisplay*: proc(self: ptr IScriptErrorList, fPerErrorDisplay: LONG): HRESULT {.stdcall.}
  ISearch* {.pure.} = object
    lpVtbl*: ptr ISearchVtbl
  ISearchVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Title*: proc(self: ptr ISearch, pbstrTitle: ptr BSTR): HRESULT {.stdcall.}
    get_Id*: proc(self: ptr ISearch, pbstrId: ptr BSTR): HRESULT {.stdcall.}
    get_URL*: proc(self: ptr ISearch, pbstrUrl: ptr BSTR): HRESULT {.stdcall.}
  ISearches* {.pure.} = object
    lpVtbl*: ptr ISearchesVtbl
  ISearchesVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_Count*: proc(self: ptr ISearches, plCount: ptr LONG): HRESULT {.stdcall.}
    get_Default*: proc(self: ptr ISearches, pbstrDefault: ptr BSTR): HRESULT {.stdcall.}
    Item*: proc(self: ptr ISearches, index: VARIANT, ppid: ptr ptr ISearch): HRESULT {.stdcall.}
    NewEnum*: proc(self: ptr ISearches, ppunk: ptr ptr IUnknown): HRESULT {.stdcall.}
  ISearchAssistantOC* {.pure.} = object
    lpVtbl*: ptr ISearchAssistantOCVtbl
  ISearchAssistantOCVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    AddNextMenuItem*: proc(self: ptr ISearchAssistantOC, bstrText: BSTR, idItem: LONG): HRESULT {.stdcall.}
    SetDefaultSearchUrl*: proc(self: ptr ISearchAssistantOC, bstrUrl: BSTR): HRESULT {.stdcall.}
    NavigateToDefaultSearch*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    IsRestricted*: proc(self: ptr ISearchAssistantOC, bstrGuid: BSTR, pVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_ShellFeaturesEnabled*: proc(self: ptr ISearchAssistantOC, pVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_SearchAssistantDefault*: proc(self: ptr ISearchAssistantOC, pVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_Searches*: proc(self: ptr ISearchAssistantOC, ppid: ptr ptr ISearches): HRESULT {.stdcall.}
    get_InWebFolder*: proc(self: ptr ISearchAssistantOC, pVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    PutProperty*: proc(self: ptr ISearchAssistantOC, bPerLocale: VARIANT_BOOL, bstrName: BSTR, bstrValue: BSTR): HRESULT {.stdcall.}
    GetProperty*: proc(self: ptr ISearchAssistantOC, bPerLocale: VARIANT_BOOL, bstrName: BSTR, pbstrValue: ptr BSTR): HRESULT {.stdcall.}
    put_EventHandled*: proc(self: ptr ISearchAssistantOC, rhs: VARIANT_BOOL): HRESULT {.stdcall.}
    ResetNextMenu*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    FindOnWeb*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    FindFilesOrFolders*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    FindComputer*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    FindPrinter*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    FindPeople*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    GetSearchAssistantURL*: proc(self: ptr ISearchAssistantOC, bSubstitute: VARIANT_BOOL, bCustomize: VARIANT_BOOL, pbstrValue: ptr BSTR): HRESULT {.stdcall.}
    NotifySearchSettingsChanged*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    put_ASProvider*: proc(self: ptr ISearchAssistantOC, pProvider: BSTR): HRESULT {.stdcall.}
    get_ASProvider*: proc(self: ptr ISearchAssistantOC, pProvider: ptr BSTR): HRESULT {.stdcall.}
    put_ASSetting*: proc(self: ptr ISearchAssistantOC, pSetting: int32): HRESULT {.stdcall.}
    get_ASSetting*: proc(self: ptr ISearchAssistantOC, pSetting: ptr int32): HRESULT {.stdcall.}
    NETDetectNextNavigate*: proc(self: ptr ISearchAssistantOC): HRESULT {.stdcall.}
    PutFindText*: proc(self: ptr ISearchAssistantOC, FindText: BSTR): HRESULT {.stdcall.}
    get_Version*: proc(self: ptr ISearchAssistantOC, pVersion: ptr int32): HRESULT {.stdcall.}
    EncodeString*: proc(self: ptr ISearchAssistantOC, bstrValue: BSTR, bstrCharSet: BSTR, bUseUTF8: VARIANT_BOOL, pbstrResult: ptr BSTR): HRESULT {.stdcall.}
  ISearchAssistantOC2* {.pure.} = object
    lpVtbl*: ptr ISearchAssistantOC2Vtbl
  ISearchAssistantOC2Vtbl* {.pure, inheritable.} = object of ISearchAssistantOCVtbl
    get_ShowFindPrinter*: proc(self: ptr ISearchAssistantOC2, pbShowFindPrinter: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  ISearchAssistantOC3* {.pure.} = object
    lpVtbl*: ptr ISearchAssistantOC3Vtbl
  ISearchAssistantOC3Vtbl* {.pure, inheritable.} = object of ISearchAssistantOC2Vtbl
    get_SearchCompanionAvailable*: proc(self: ptr ISearchAssistantOC3, pbAvailable: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    put_UseSearchCompanion*: proc(self: ptr ISearchAssistantOC3, pbUseSC: VARIANT_BOOL): HRESULT {.stdcall.}
    get_UseSearchCompanion*: proc(self: ptr ISearchAssistantOC3, pbUseSC: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  SearchAssistantEvents* {.pure.} = object
    lpVtbl*: ptr SearchAssistantEventsVtbl
  SearchAssistantEventsVtbl* {.pure, inheritable.} = object of IDispatchVtbl
  IRichChunk* {.pure.} = object
    lpVtbl*: ptr IRichChunkVtbl
  IRichChunkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetData*: proc(self: ptr IRichChunk, pFirstPos: ptr ULONG, pLength: ptr ULONG, ppsz: ptr LPWSTR, pValue: ptr PROPVARIANT): HRESULT {.stdcall.}
  ICondition* {.pure.} = object
    lpVtbl*: ptr IConditionVtbl
  IConditionVtbl* {.pure, inheritable.} = object of IPersistStreamVtbl
    GetConditionType*: proc(self: ptr ICondition, pNodeType: ptr CONDITION_TYPE): HRESULT {.stdcall.}
    GetSubConditions*: proc(self: ptr ICondition, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetComparisonInfo*: proc(self: ptr ICondition, ppszPropertyName: ptr LPWSTR, pcop: ptr CONDITION_OPERATION, ppropvar: ptr PROPVARIANT): HRESULT {.stdcall.}
    GetValueType*: proc(self: ptr ICondition, ppszValueTypeName: ptr LPWSTR): HRESULT {.stdcall.}
    GetValueNormalization*: proc(self: ptr ICondition, ppszNormalization: ptr LPWSTR): HRESULT {.stdcall.}
    GetInputTerms*: proc(self: ptr ICondition, ppPropertyTerm: ptr ptr IRichChunk, ppOperationTerm: ptr ptr IRichChunk, ppValueTerm: ptr ptr IRichChunk): HRESULT {.stdcall.}
    Clone*: proc(self: ptr ICondition, ppc: ptr ptr ICondition): HRESULT {.stdcall.}
  ICondition2* {.pure.} = object
    lpVtbl*: ptr ICondition2Vtbl
  ICondition2Vtbl* {.pure, inheritable.} = object of IConditionVtbl
    GetLocale*: proc(self: ptr ICondition2, ppszLocaleName: ptr LPWSTR): HRESULT {.stdcall.}
    GetLeafConditionInfo*: proc(self: ptr ICondition2, ppropkey: ptr PROPERTYKEY, pcop: ptr CONDITION_OPERATION, ppropvar: ptr PROPVARIANT): HRESULT {.stdcall.}
  IInitializeWithFile* {.pure.} = object
    lpVtbl*: ptr IInitializeWithFileVtbl
  IInitializeWithFileVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeWithFile, pszFilePath: LPCWSTR, grfMode: DWORD): HRESULT {.stdcall.}
  IInitializeWithStream* {.pure.} = object
    lpVtbl*: ptr IInitializeWithStreamVtbl
  IInitializeWithStreamVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IInitializeWithStream, pstream: ptr IStream, grfMode: DWORD): HRESULT {.stdcall.}
  INamedPropertyStore* {.pure.} = object
    lpVtbl*: ptr INamedPropertyStoreVtbl
  INamedPropertyStoreVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetNamedValue*: proc(self: ptr INamedPropertyStore, pszName: LPCWSTR, ppropvar: ptr PROPVARIANT): HRESULT {.stdcall.}
    SetNamedValue*: proc(self: ptr INamedPropertyStore, pszName: LPCWSTR, propvar: REFPROPVARIANT): HRESULT {.stdcall.}
    GetNameCount*: proc(self: ptr INamedPropertyStore, pdwCount: ptr DWORD): HRESULT {.stdcall.}
    GetNameAt*: proc(self: ptr INamedPropertyStore, iProp: DWORD, pbstrName: ptr BSTR): HRESULT {.stdcall.}
  IObjectWithPropertyKey* {.pure.} = object
    lpVtbl*: ptr IObjectWithPropertyKeyVtbl
  IObjectWithPropertyKeyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetPropertyKey*: proc(self: ptr IObjectWithPropertyKey, key: REFPROPERTYKEY): HRESULT {.stdcall.}
    GetPropertyKey*: proc(self: ptr IObjectWithPropertyKey, pkey: ptr PROPERTYKEY): HRESULT {.stdcall.}
  IPropertyChange* {.pure.} = object
    lpVtbl*: ptr IPropertyChangeVtbl
  IPropertyChangeVtbl* {.pure, inheritable.} = object of IObjectWithPropertyKeyVtbl
    ApplyToPropVariant*: proc(self: ptr IPropertyChange, propvarIn: REFPROPVARIANT, ppropvarOut: ptr PROPVARIANT): HRESULT {.stdcall.}
  IPropertyChangeArray* {.pure.} = object
    lpVtbl*: ptr IPropertyChangeArrayVtbl
  IPropertyChangeArrayVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCount*: proc(self: ptr IPropertyChangeArray, pcOperations: ptr UINT): HRESULT {.stdcall.}
    GetAt*: proc(self: ptr IPropertyChangeArray, iIndex: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    InsertAt*: proc(self: ptr IPropertyChangeArray, iIndex: UINT, ppropChange: ptr IPropertyChange): HRESULT {.stdcall.}
    Append*: proc(self: ptr IPropertyChangeArray, ppropChange: ptr IPropertyChange): HRESULT {.stdcall.}
    AppendOrReplace*: proc(self: ptr IPropertyChangeArray, ppropChange: ptr IPropertyChange): HRESULT {.stdcall.}
    RemoveAt*: proc(self: ptr IPropertyChangeArray, iIndex: UINT): HRESULT {.stdcall.}
    IsKeyInArray*: proc(self: ptr IPropertyChangeArray, key: REFPROPERTYKEY): HRESULT {.stdcall.}
  IPropertyStoreCapabilities* {.pure.} = object
    lpVtbl*: ptr IPropertyStoreCapabilitiesVtbl
  IPropertyStoreCapabilitiesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IsPropertyWritable*: proc(self: ptr IPropertyStoreCapabilities, key: REFPROPERTYKEY): HRESULT {.stdcall.}
  IPropertyStoreCache* {.pure.} = object
    lpVtbl*: ptr IPropertyStoreCacheVtbl
  IPropertyStoreCacheVtbl* {.pure, inheritable.} = object of IPropertyStoreVtbl
    GetState*: proc(self: ptr IPropertyStoreCache, key: REFPROPERTYKEY, pstate: ptr PSC_STATE): HRESULT {.stdcall.}
    GetValueAndState*: proc(self: ptr IPropertyStoreCache, key: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT, pstate: ptr PSC_STATE): HRESULT {.stdcall.}
    SetState*: proc(self: ptr IPropertyStoreCache, key: REFPROPERTYKEY, state: PSC_STATE): HRESULT {.stdcall.}
    SetValueAndState*: proc(self: ptr IPropertyStoreCache, key: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT, state: PSC_STATE): HRESULT {.stdcall.}
  IPropertyEnumType* {.pure.} = object
    lpVtbl*: ptr IPropertyEnumTypeVtbl
  IPropertyEnumTypeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetEnumType*: proc(self: ptr IPropertyEnumType, penumtype: ptr PROPENUMTYPE): HRESULT {.stdcall.}
    GetValue*: proc(self: ptr IPropertyEnumType, ppropvar: ptr PROPVARIANT): HRESULT {.stdcall.}
    GetRangeMinValue*: proc(self: ptr IPropertyEnumType, ppropvarMin: ptr PROPVARIANT): HRESULT {.stdcall.}
    GetRangeSetValue*: proc(self: ptr IPropertyEnumType, ppropvarSet: ptr PROPVARIANT): HRESULT {.stdcall.}
    GetDisplayText*: proc(self: ptr IPropertyEnumType, ppszDisplay: ptr LPWSTR): HRESULT {.stdcall.}
  IPropertyEnumType2* {.pure.} = object
    lpVtbl*: ptr IPropertyEnumType2Vtbl
  IPropertyEnumType2Vtbl* {.pure, inheritable.} = object of IPropertyEnumTypeVtbl
    GetImageReference*: proc(self: ptr IPropertyEnumType2, ppszImageRes: ptr LPWSTR): HRESULT {.stdcall.}
  IPropertyEnumTypeList* {.pure.} = object
    lpVtbl*: ptr IPropertyEnumTypeListVtbl
  IPropertyEnumTypeListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCount*: proc(self: ptr IPropertyEnumTypeList, pctypes: ptr UINT): HRESULT {.stdcall.}
    GetAt*: proc(self: ptr IPropertyEnumTypeList, itype: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetConditionAt*: proc(self: ptr IPropertyEnumTypeList, nIndex: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    FindMatchingIndex*: proc(self: ptr IPropertyEnumTypeList, propvarCmp: REFPROPVARIANT, pnIndex: ptr UINT): HRESULT {.stdcall.}
  IPropertyDescription* {.pure.} = object
    lpVtbl*: ptr IPropertyDescriptionVtbl
  IPropertyDescriptionVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPropertyKey*: proc(self: ptr IPropertyDescription, pkey: ptr PROPERTYKEY): HRESULT {.stdcall.}
    GetCanonicalName*: proc(self: ptr IPropertyDescription, ppszName: ptr LPWSTR): HRESULT {.stdcall.}
    GetPropertyType*: proc(self: ptr IPropertyDescription, pvartype: ptr VARTYPE): HRESULT {.stdcall.}
    GetDisplayName*: proc(self: ptr IPropertyDescription, ppszName: ptr LPWSTR): HRESULT {.stdcall.}
    GetEditInvitation*: proc(self: ptr IPropertyDescription, ppszInvite: ptr LPWSTR): HRESULT {.stdcall.}
    GetTypeFlags*: proc(self: ptr IPropertyDescription, mask: PROPDESC_TYPE_FLAGS, ppdtFlags: ptr PROPDESC_TYPE_FLAGS): HRESULT {.stdcall.}
    GetViewFlags*: proc(self: ptr IPropertyDescription, ppdvFlags: ptr PROPDESC_VIEW_FLAGS): HRESULT {.stdcall.}
    GetDefaultColumnWidth*: proc(self: ptr IPropertyDescription, pcxChars: ptr UINT): HRESULT {.stdcall.}
    GetDisplayType*: proc(self: ptr IPropertyDescription, pdisplaytype: ptr PROPDESC_DISPLAYTYPE): HRESULT {.stdcall.}
    GetColumnState*: proc(self: ptr IPropertyDescription, pcsFlags: ptr SHCOLSTATEF): HRESULT {.stdcall.}
    GetGroupingRange*: proc(self: ptr IPropertyDescription, pgr: ptr PROPDESC_GROUPING_RANGE): HRESULT {.stdcall.}
    GetRelativeDescriptionType*: proc(self: ptr IPropertyDescription, prdt: ptr PROPDESC_RELATIVEDESCRIPTION_TYPE): HRESULT {.stdcall.}
    GetRelativeDescription*: proc(self: ptr IPropertyDescription, propvar1: REFPROPVARIANT, propvar2: REFPROPVARIANT, ppszDesc1: ptr LPWSTR, ppszDesc2: ptr LPWSTR): HRESULT {.stdcall.}
    GetSortDescription*: proc(self: ptr IPropertyDescription, psd: ptr PROPDESC_SORTDESCRIPTION): HRESULT {.stdcall.}
    GetSortDescriptionLabel*: proc(self: ptr IPropertyDescription, fDescending: WINBOOL, ppszDescription: ptr LPWSTR): HRESULT {.stdcall.}
    GetAggregationType*: proc(self: ptr IPropertyDescription, paggtype: ptr PROPDESC_AGGREGATION_TYPE): HRESULT {.stdcall.}
    GetConditionType*: proc(self: ptr IPropertyDescription, pcontype: ptr PROPDESC_CONDITION_TYPE, popDefault: ptr CONDITION_OPERATION): HRESULT {.stdcall.}
    GetEnumTypeList*: proc(self: ptr IPropertyDescription, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    CoerceToCanonicalValue*: proc(self: ptr IPropertyDescription, ppropvar: ptr PROPVARIANT): HRESULT {.stdcall.}
    FormatForDisplay*: proc(self: ptr IPropertyDescription, propvar: REFPROPVARIANT, pdfFlags: PROPDESC_FORMAT_FLAGS, ppszDisplay: ptr LPWSTR): HRESULT {.stdcall.}
    IsValueCanonical*: proc(self: ptr IPropertyDescription, propvar: REFPROPVARIANT): HRESULT {.stdcall.}
  IPropertyDescription2* {.pure.} = object
    lpVtbl*: ptr IPropertyDescription2Vtbl
  IPropertyDescription2Vtbl* {.pure, inheritable.} = object of IPropertyDescriptionVtbl
    GetImageReferenceForValue*: proc(self: ptr IPropertyDescription2, propvar: REFPROPVARIANT, ppszImageRes: ptr LPWSTR): HRESULT {.stdcall.}
  IPropertyDescriptionAliasInfo* {.pure.} = object
    lpVtbl*: ptr IPropertyDescriptionAliasInfoVtbl
  IPropertyDescriptionAliasInfoVtbl* {.pure, inheritable.} = object of IPropertyDescriptionVtbl
    GetSortByAlias*: proc(self: ptr IPropertyDescriptionAliasInfo, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetAdditionalSortByAliases*: proc(self: ptr IPropertyDescriptionAliasInfo, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IPropertyDescriptionSearchInfo* {.pure.} = object
    lpVtbl*: ptr IPropertyDescriptionSearchInfoVtbl
  IPropertyDescriptionSearchInfoVtbl* {.pure, inheritable.} = object of IPropertyDescriptionVtbl
    GetSearchInfoFlags*: proc(self: ptr IPropertyDescriptionSearchInfo, ppdsiFlags: ptr PROPDESC_SEARCHINFO_FLAGS): HRESULT {.stdcall.}
    GetColumnIndexType*: proc(self: ptr IPropertyDescriptionSearchInfo, ppdciType: ptr PROPDESC_COLUMNINDEX_TYPE): HRESULT {.stdcall.}
    GetProjectionString*: proc(self: ptr IPropertyDescriptionSearchInfo, ppszProjection: ptr LPWSTR): HRESULT {.stdcall.}
    GetMaxSize*: proc(self: ptr IPropertyDescriptionSearchInfo, pcbMaxSize: ptr UINT): HRESULT {.stdcall.}
  IPropertyDescriptionRelatedPropertyInfo* {.pure.} = object
    lpVtbl*: ptr IPropertyDescriptionRelatedPropertyInfoVtbl
  IPropertyDescriptionRelatedPropertyInfoVtbl* {.pure, inheritable.} = object of IPropertyDescriptionVtbl
    GetRelatedProperty*: proc(self: ptr IPropertyDescriptionRelatedPropertyInfo, pszRelationshipName: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IPropertySystem* {.pure.} = object
    lpVtbl*: ptr IPropertySystemVtbl
  IPropertySystemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPropertyDescription*: proc(self: ptr IPropertySystem, propkey: REFPROPERTYKEY, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetPropertyDescriptionByName*: proc(self: ptr IPropertySystem, pszCanonicalName: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetPropertyDescriptionListFromString*: proc(self: ptr IPropertySystem, pszPropList: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    EnumeratePropertyDescriptions*: proc(self: ptr IPropertySystem, filterOn: PROPDESC_ENUMFILTER, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    FormatForDisplay*: proc(self: ptr IPropertySystem, key: REFPROPERTYKEY, propvar: REFPROPVARIANT, pdff: PROPDESC_FORMAT_FLAGS, pszText: LPWSTR, cchText: DWORD): HRESULT {.stdcall.}
    FormatForDisplayAlloc*: proc(self: ptr IPropertySystem, key: REFPROPERTYKEY, propvar: REFPROPVARIANT, pdff: PROPDESC_FORMAT_FLAGS, ppszDisplay: ptr LPWSTR): HRESULT {.stdcall.}
    RegisterPropertySchema*: proc(self: ptr IPropertySystem, pszPath: LPCWSTR): HRESULT {.stdcall.}
    UnregisterPropertySchema*: proc(self: ptr IPropertySystem, pszPath: LPCWSTR): HRESULT {.stdcall.}
    RefreshPropertySchema*: proc(self: ptr IPropertySystem): HRESULT {.stdcall.}
  IPropertyDescriptionList* {.pure.} = object
    lpVtbl*: ptr IPropertyDescriptionListVtbl
  IPropertyDescriptionListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCount*: proc(self: ptr IPropertyDescriptionList, pcElem: ptr UINT): HRESULT {.stdcall.}
    GetAt*: proc(self: ptr IPropertyDescriptionList, iElem: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IPropertyStoreFactory* {.pure.} = object
    lpVtbl*: ptr IPropertyStoreFactoryVtbl
  IPropertyStoreFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetPropertyStore*: proc(self: ptr IPropertyStoreFactory, flags: GETPROPERTYSTOREFLAGS, pUnkFactory: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
    GetPropertyStoreForKeys*: proc(self: ptr IPropertyStoreFactory, rgKeys: ptr PROPERTYKEY, cKeys: UINT, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IDelayedPropertyStoreFactory* {.pure.} = object
    lpVtbl*: ptr IDelayedPropertyStoreFactoryVtbl
  IDelayedPropertyStoreFactoryVtbl* {.pure, inheritable.} = object of IPropertyStoreFactoryVtbl
    GetDelayedPropertyStore*: proc(self: ptr IDelayedPropertyStoreFactory, flags: GETPROPERTYSTOREFLAGS, dwStoreId: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
  IPersistSerializedPropStorage* {.pure.} = object
    lpVtbl*: ptr IPersistSerializedPropStorageVtbl
  IPersistSerializedPropStorageVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetFlags*: proc(self: ptr IPersistSerializedPropStorage, flags: PERSIST_SPROPSTORE_FLAGS): HRESULT {.stdcall.}
    SetPropertyStorage*: proc(self: ptr IPersistSerializedPropStorage, psps: PCUSERIALIZEDPROPSTORAGE, cb: DWORD): HRESULT {.stdcall.}
    GetPropertyStorage*: proc(self: ptr IPersistSerializedPropStorage, ppsps: ptr ptr SERIALIZEDPROPSTORAGE, pcb: ptr DWORD): HRESULT {.stdcall.}
  IPersistSerializedPropStorage2* {.pure.} = object
    lpVtbl*: ptr IPersistSerializedPropStorage2Vtbl
  IPersistSerializedPropStorage2Vtbl* {.pure, inheritable.} = object of IPersistSerializedPropStorageVtbl
    GetPropertyStorageSize*: proc(self: ptr IPersistSerializedPropStorage2, pcb: ptr DWORD): HRESULT {.stdcall.}
    GetPropertyStorageBuffer*: proc(self: ptr IPersistSerializedPropStorage2, psps: ptr SERIALIZEDPROPSTORAGE, cb: DWORD, pcbWritten: ptr DWORD): HRESULT {.stdcall.}
  IPropertySystemChangeNotify* {.pure.} = object
    lpVtbl*: ptr IPropertySystemChangeNotifyVtbl
  IPropertySystemChangeNotifyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SchemaRefreshed*: proc(self: ptr IPropertySystemChangeNotify): HRESULT {.stdcall.}
  ICreateObject* {.pure.} = object
    lpVtbl*: ptr ICreateObjectVtbl
  ICreateObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateObject*: proc(self: ptr ICreateObject, clsid: REFCLSID, pUnkOuter: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.stdcall.}
proc SysAllocString*(P1: ptr OLECHAR): BSTR {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SysReAllocString*(P1: ptr BSTR, P2: ptr OLECHAR): INT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SysAllocStringLen*(P1: ptr OLECHAR, P2: UINT): BSTR {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SysReAllocStringLen*(P1: ptr BSTR, P2: ptr OLECHAR, P3: UINT): INT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SysFreeString*(P1: BSTR): void {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SysStringLen*(P1: BSTR): UINT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SysStringByteLen*(bstr: BSTR): UINT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SysAllocStringByteLen*(psz: LPCSTR, len: UINT): BSTR {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc DosDateTimeToVariantTime*(wDosDate: USHORT, wDosTime: USHORT, pvtime: ptr DOUBLE): INT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VariantTimeToDosDateTime*(vtime: DOUBLE, pwDosDate: ptr USHORT, pwDosTime: ptr USHORT): INT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SystemTimeToVariantTime*(lpSystemTime: LPSYSTEMTIME, pvtime: ptr DOUBLE): INT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VariantTimeToSystemTime*(vtime: DOUBLE, lpSystemTime: LPSYSTEMTIME): INT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayAllocDescriptor*(cDims: UINT, ppsaOut: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayAllocDescriptorEx*(vt: VARTYPE, cDims: UINT, ppsaOut: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayAllocData*(psa: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayCreate*(vt: VARTYPE, cDims: UINT, rgsabound: ptr SAFEARRAYBOUND): ptr SAFEARRAY {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayCreateEx*(vt: VARTYPE, cDims: UINT, rgsabound: ptr SAFEARRAYBOUND, pvExtra: PVOID): ptr SAFEARRAY {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayCopyData*(psaSource: ptr SAFEARRAY, psaTarget: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayDestroyDescriptor*(psa: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayDestroyData*(psa: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayDestroy*(psa: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayRedim*(psa: ptr SAFEARRAY, psaboundNew: ptr SAFEARRAYBOUND): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayGetDim*(psa: ptr SAFEARRAY): UINT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayGetElemsize*(psa: ptr SAFEARRAY): UINT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayGetUBound*(psa: ptr SAFEARRAY, nDim: UINT, plUbound: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayGetLBound*(psa: ptr SAFEARRAY, nDim: UINT, plLbound: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayLock*(psa: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayUnlock*(psa: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayAccessData*(psa: ptr SAFEARRAY, ppvData: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayUnaccessData*(psa: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayGetElement*(psa: ptr SAFEARRAY, rgIndices: ptr LONG, pv: pointer): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayPutElement*(psa: ptr SAFEARRAY, rgIndices: ptr LONG, pv: pointer): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayCopy*(psa: ptr SAFEARRAY, ppsaOut: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayPtrOfIndex*(psa: ptr SAFEARRAY, rgIndices: ptr LONG, ppvData: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArraySetRecordInfo*(psa: ptr SAFEARRAY, prinfo: ptr IRecordInfo): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayGetRecordInfo*(psa: ptr SAFEARRAY, prinfo: ptr ptr IRecordInfo): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArraySetIID*(psa: ptr SAFEARRAY, guid: REFGUID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayGetIID*(psa: ptr SAFEARRAY, pguid: ptr GUID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayGetVartype*(psa: ptr SAFEARRAY, pvt: ptr VARTYPE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayCreateVector*(vt: VARTYPE, lLbound: LONG, cElements: ULONG): ptr SAFEARRAY {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SafeArrayCreateVectorEx*(vt: VARTYPE, lLbound: LONG, cElements: ULONG, pvExtra: PVOID): ptr SAFEARRAY {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VariantInit*(pvarg: ptr VARIANTARG): void {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VariantClear*(pvarg: ptr VARIANTARG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VariantCopy*(pvargDest: ptr VARIANTARG, pvargSrc: ptr VARIANTARG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VariantCopyInd*(pvarDest: ptr VARIANT, pvargSrc: ptr VARIANTARG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VariantChangeType*(pvargDest: ptr VARIANTARG, pvarSrc: ptr VARIANTARG, wFlags: USHORT, vt: VARTYPE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VariantChangeTypeEx*(pvargDest: ptr VARIANTARG, pvarSrc: ptr VARIANTARG, lcid: LCID, wFlags: USHORT, vt: VARTYPE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VectorFromBstr*(bstr: BSTR, ppsa: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc BstrFromVector*(psa: ptr SAFEARRAY, pbstr: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromI2*(sIn: SHORT, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromI4*(lIn: LONG, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromI8*(i64In: LONG64, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromR4*(fltIn: FLOAT, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromR8*(dblIn: DOUBLE, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromCy*(cyIn: CY, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromDate*(dateIn: DATE, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromBool*(boolIn: VARIANT_BOOL, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromI1*(cIn: CHAR, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromUI2*(uiIn: USHORT, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromUI4*(ulIn: ULONG, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromUI8*(ui64In: ULONG64, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromDec*(pdecIn: ptr DECIMAL, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromUI1*(bIn: BYTE, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromI4*(lIn: LONG, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromI8*(i64In: LONG64, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromR4*(fltIn: FLOAT, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromR8*(dblIn: DOUBLE, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromCy*(cyIn: CY, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromDate*(dateIn: DATE, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromBool*(boolIn: VARIANT_BOOL, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromI1*(cIn: CHAR, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromUI2*(uiIn: USHORT, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromUI4*(ulIn: ULONG, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromUI8*(ui64In: ULONG64, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI2FromDec*(pdecIn: ptr DECIMAL, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromUI1*(bIn: BYTE, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromI2*(sIn: SHORT, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromI8*(i64In: LONG64, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromR4*(fltIn: FLOAT, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromR8*(dblIn: DOUBLE, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromCy*(cyIn: CY, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromDate*(dateIn: DATE, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromBool*(boolIn: VARIANT_BOOL, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromI1*(cIn: CHAR, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromUI2*(uiIn: USHORT, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromUI4*(ulIn: ULONG, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromUI8*(ui64In: ULONG64, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI4FromDec*(pdecIn: ptr DECIMAL, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromUI1*(bIn: BYTE, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromI2*(sIn: SHORT, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromR4*(fltIn: FLOAT, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromR8*(dblIn: DOUBLE, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromCy*(cyIn: CY, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromDate*(dateIn: DATE, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: int32, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromBool*(boolIn: VARIANT_BOOL, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromI1*(cIn: CHAR, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromUI2*(uiIn: USHORT, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromUI4*(ulIn: ULONG, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromUI8*(ui64In: ULONG64, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI8FromDec*(pdecIn: ptr DECIMAL, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromUI1*(bIn: BYTE, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromI2*(sIn: SHORT, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromI4*(lIn: LONG, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromI8*(i64In: LONG64, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromR8*(dblIn: DOUBLE, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromCy*(cyIn: CY, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromDate*(dateIn: DATE, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromBool*(boolIn: VARIANT_BOOL, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromI1*(cIn: CHAR, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromUI2*(uiIn: USHORT, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromUI4*(ulIn: ULONG, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromUI8*(ui64In: ULONG64, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4FromDec*(pdecIn: ptr DECIMAL, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromUI1*(bIn: BYTE, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromI2*(sIn: SHORT, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromI4*(lIn: LONG, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromI8*(i64In: LONG64, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromR4*(fltIn: FLOAT, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromCy*(cyIn: CY, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromDate*(dateIn: DATE, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromBool*(boolIn: VARIANT_BOOL, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromI1*(cIn: CHAR, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromUI2*(uiIn: USHORT, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromUI4*(ulIn: ULONG, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromUI8*(ui64In: ULONG64, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8FromDec*(pdecIn: ptr DECIMAL, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromUI1*(bIn: BYTE, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromI2*(sIn: SHORT, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromI4*(lIn: LONG, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromI8*(i64In: LONG64, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromR4*(fltIn: FLOAT, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromR8*(dblIn: DOUBLE, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromCy*(cyIn: CY, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromBool*(boolIn: VARIANT_BOOL, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromI1*(cIn: CHAR, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromUI2*(uiIn: USHORT, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromUI4*(ulIn: ULONG, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromUI8*(ui64In: ULONG64, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromDec*(pdecIn: ptr DECIMAL, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromUI1*(bIn: BYTE, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromI2*(sIn: SHORT, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromI4*(lIn: LONG, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromI8*(i64In: LONG64, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromR4*(fltIn: FLOAT, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromR8*(dblIn: DOUBLE, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromDate*(dateIn: DATE, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromBool*(boolIn: VARIANT_BOOL, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromI1*(cIn: CHAR, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromUI2*(uiIn: USHORT, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromUI4*(ulIn: ULONG, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromUI8*(ui64In: ULONG64, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFromDec*(pdecIn: ptr DECIMAL, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromUI1*(bVal: BYTE, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromI2*(iVal: SHORT, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromI4*(lIn: LONG, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromI8*(i64In: LONG64, lcid: LCID, dwFlags: int32, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromR4*(fltIn: FLOAT, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromR8*(dblIn: DOUBLE, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromCy*(cyIn: CY, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromDate*(dateIn: DATE, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromDisp*(pdispIn: ptr IDispatch, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromBool*(boolIn: VARIANT_BOOL, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromI1*(cIn: CHAR, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromUI2*(uiIn: USHORT, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromUI4*(ulIn: ULONG, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromUI8*(ui64In: ULONG64, lcid: LCID, dwFlags: int32, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrFromDec*(pdecIn: ptr DECIMAL, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromUI1*(bIn: BYTE, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromI2*(sIn: SHORT, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromI4*(lIn: LONG, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromI8*(i64In: LONG64, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromR4*(fltIn: FLOAT, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromR8*(dblIn: DOUBLE, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromDate*(dateIn: DATE, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromCy*(cyIn: CY, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromI1*(cIn: CHAR, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromUI2*(uiIn: USHORT, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromUI4*(ulIn: ULONG, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromUI8*(i64In: ULONG64, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBoolFromDec*(pdecIn: ptr DECIMAL, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromUI1*(bIn: BYTE, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromI2*(uiIn: SHORT, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromI4*(lIn: LONG, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromI8*(i64In: LONG64, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromR4*(fltIn: FLOAT, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromR8*(dblIn: DOUBLE, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromDate*(dateIn: DATE, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromCy*(cyIn: CY, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromBool*(boolIn: VARIANT_BOOL, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromUI2*(uiIn: USHORT, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromUI4*(ulIn: ULONG, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromUI8*(i64In: ULONG64, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarI1FromDec*(pdecIn: ptr DECIMAL, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromUI1*(bIn: BYTE, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromI2*(uiIn: SHORT, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromI4*(lIn: LONG, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromI8*(i64In: LONG64, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromR4*(fltIn: FLOAT, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromR8*(dblIn: DOUBLE, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromDate*(dateIn: DATE, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromCy*(cyIn: CY, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromBool*(boolIn: VARIANT_BOOL, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromI1*(cIn: CHAR, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromUI4*(ulIn: ULONG, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromUI8*(i64In: ULONG64, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI2FromDec*(pdecIn: ptr DECIMAL, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromUI1*(bIn: BYTE, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromI2*(uiIn: SHORT, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromI4*(lIn: LONG, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromI8*(i64In: LONG64, plOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromR4*(fltIn: FLOAT, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromR8*(dblIn: DOUBLE, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromDate*(dateIn: DATE, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromCy*(cyIn: CY, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromBool*(boolIn: VARIANT_BOOL, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromI1*(cIn: CHAR, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromUI2*(uiIn: USHORT, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromUI8*(ui64In: ULONG64, plOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI4FromDec*(pdecIn: ptr DECIMAL, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromUI1*(bIn: BYTE, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromI2*(sIn: SHORT, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromI8*(ui64In: LONG64, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromR4*(fltIn: FLOAT, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromR8*(dblIn: DOUBLE, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromCy*(cyIn: CY, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromDate*(dateIn: DATE, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: int32, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromBool*(boolIn: VARIANT_BOOL, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromI1*(cIn: CHAR, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromUI2*(uiIn: USHORT, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromUI4*(ulIn: ULONG, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI8FromDec*(pdecIn: ptr DECIMAL, pi64Out: ptr ULONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromUI1*(bIn: BYTE, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromI2*(uiIn: SHORT, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromI4*(lIn: LONG, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromI8*(i64In: LONG64, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromR4*(fltIn: FLOAT, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromR8*(dblIn: DOUBLE, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromDate*(dateIn: DATE, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromCy*(cyIn: CY, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromBool*(boolIn: VARIANT_BOOL, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromI1*(cIn: CHAR, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromUI2*(uiIn: USHORT, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromUI4*(ulIn: ULONG, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFromUI8*(ui64In: ULONG64, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUI1FromInt*(lIn: LONG, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI1FromI4".}
proc VarUI1FromUint*(ulIn: ULONG, pbOut: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI1FromUI4".}
proc VarI2FromInt*(lIn: LONG, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI2FromI4".}
proc VarI2FromUint*(ulIn: ULONG, psOut: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI2FromUI4".}
proc VarI4FromUint*(ulIn: ULONG, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromUI4".}
proc VarI8FromUint*(ulIn: ULONG, pi64Out: ptr LONG64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI8FromUI4".}
proc VarR4FromInt*(lIn: LONG, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarR4FromI4".}
proc VarR4FromUint*(ulIn: ULONG, pfltOut: ptr FLOAT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarR4FromUI4".}
proc VarR8FromInt*(lIn: LONG, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarR8FromI4".}
proc VarR8FromUint*(ulIn: ULONG, pdblOut: ptr DOUBLE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarR8FromUI4".}
proc VarDateFromInt*(lIn: LONG, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarDateFromI4".}
proc VarDateFromUint*(ulIn: ULONG, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarDateFromUI4".}
proc VarCyFromInt*(lIn: LONG, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarCyFromI4".}
proc VarCyFromUint*(ulIn: ULONG, pcyOut: ptr CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarCyFromUI4".}
proc VarBstrFromInt*(lIn: LONG, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarBstrFromI4".}
proc VarBstrFromUint*(ulIn: ULONG, lcid: LCID, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarBstrFromUI4".}
proc VarBoolFromInt*(lIn: LONG, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarBoolFromI4".}
proc VarBoolFromUint*(ulIn: ULONG, pboolOut: ptr VARIANT_BOOL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarBoolFromUI4".}
proc VarI1FromInt*(lIn: LONG, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI1FromI4".}
proc VarI1FromUint*(ulIn: ULONG, pcOut: ptr CHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI1FromUI4".}
proc VarUI2FromInt*(lIn: LONG, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI2FromI4".}
proc VarUI2FromUint*(ulIn: ULONG, puiOut: ptr USHORT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI2FromUI4".}
proc VarUI4FromInt*(lIn: LONG, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromI4".}
proc VarDecFromInt*(lIn: LONG, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarDecFromI4".}
proc VarDecFromUint*(ulIn: ULONG, pdecOut: ptr DECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarDecFromUI4".}
proc VarIntFromUI1*(bIn: BYTE, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromUI1".}
proc VarIntFromI2*(sIn: SHORT, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromI2".}
proc VarIntFromI8*(i64In: LONG64, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromI8".}
proc VarIntFromR4*(fltIn: FLOAT, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromR4".}
proc VarIntFromR8*(dblIn: DOUBLE, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromR8".}
proc VarIntFromDate*(dateIn: DATE, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromDate".}
proc VarIntFromCy*(cyIn: CY, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromCy".}
proc VarIntFromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromStr".}
proc VarIntFromDisp*(pdispIn: ptr IDispatch, lcid: LCID, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromDisp".}
proc VarIntFromBool*(boolIn: VARIANT_BOOL, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromBool".}
proc VarIntFromI1*(cIn: CHAR, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromI1".}
proc VarIntFromUI2*(uiIn: USHORT, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromUI2".}
proc VarIntFromUI4*(ulIn: ULONG, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromUI4".}
proc VarIntFromUI8*(ui64In: ULONG64, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromUI8".}
proc VarIntFromDec*(pdecIn: ptr DECIMAL, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromDec".}
proc VarIntFromUint*(ulIn: ULONG, plOut: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarI4FromUI4".}
proc VarUintFromUI1*(bIn: BYTE, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromUI1".}
proc VarUintFromI2*(uiIn: SHORT, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromI2".}
proc VarUintFromI4*(lIn: LONG, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromI4".}
proc VarUintFromI8*(i64In: LONG64, plOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromI8".}
proc VarUintFromR4*(fltIn: FLOAT, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromR4".}
proc VarUintFromR8*(dblIn: DOUBLE, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromR8".}
proc VarUintFromDate*(dateIn: DATE, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromDate".}
proc VarUintFromCy*(cyIn: CY, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromCy".}
proc VarUintFromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromStr".}
proc VarUintFromDisp*(pdispIn: ptr IDispatch, lcid: LCID, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromDisp".}
proc VarUintFromBool*(boolIn: VARIANT_BOOL, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromBool".}
proc VarUintFromI1*(cIn: CHAR, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromI1".}
proc VarUintFromUI2*(uiIn: USHORT, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromUI2".}
proc VarUintFromUI8*(ui64In: ULONG64, plOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromUI8".}
proc VarUintFromDec*(pdecIn: ptr DECIMAL, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromDec".}
proc VarUintFromInt*(lIn: LONG, pulOut: ptr ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc: "VarUI4FromI4".}
proc VarParseNumFromStr*(strIn: ptr OLECHAR, lcid: LCID, dwFlags: ULONG, pnumprs: ptr NUMPARSE, rgbDig: ptr BYTE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarNumFromParseNum*(pnumprs: ptr NUMPARSE, rgbDig: ptr BYTE, dwVtBits: ULONG, pvar: ptr VARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarAdd*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarAnd*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCat*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDiv*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarEqv*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarIdiv*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarImp*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarMod*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarMul*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarOr*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarPow*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarSub*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarXor*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarAbs*(pvarIn: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarFix*(pvarIn: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarInt*(pvarIn: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarNeg*(pvarIn: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarNot*(pvarIn: LPVARIANT, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarRound*(pvarIn: LPVARIANT, cDecimals: int32, pvarResult: LPVARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCmp*(pvarLeft: LPVARIANT, pvarRight: LPVARIANT, lcid: LCID, dwFlags: ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecAdd*(pdecLeft: LPDECIMAL, pdecRight: LPDECIMAL, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecDiv*(pdecLeft: LPDECIMAL, pdecRight: LPDECIMAL, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecMul*(pdecLeft: LPDECIMAL, pdecRight: LPDECIMAL, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecSub*(pdecLeft: LPDECIMAL, pdecRight: LPDECIMAL, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecAbs*(pdecIn: LPDECIMAL, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecFix*(pdecIn: LPDECIMAL, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecInt*(pdecIn: LPDECIMAL, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecNeg*(pdecIn: LPDECIMAL, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecRound*(pdecIn: LPDECIMAL, cDecimals: int32, pdecResult: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecCmp*(pdecLeft: LPDECIMAL, pdecRight: LPDECIMAL): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDecCmpR8*(pdecLeft: LPDECIMAL, dblRight: float64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyAdd*(cyLeft: CY, cyRight: CY, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyMul*(cyLeft: CY, cyRight: CY, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyMulI4*(cyLeft: CY, lRight: int32, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyMulI8*(cyLeft: CY, lRight: LONG64, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCySub*(cyLeft: CY, cyRight: CY, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyAbs*(cyIn: CY, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyFix*(cyIn: CY, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyInt*(cyIn: CY, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyNeg*(cyIn: CY, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyRound*(cyIn: CY, cDecimals: int32, pcyResult: LPCY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyCmp*(cyLeft: CY, cyRight: CY): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarCyCmpR8*(cyLeft: CY, dblRight: float64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrCat*(bstrLeft: BSTR, bstrRight: BSTR, pbstrResult: LPBSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarBstrCmp*(bstrLeft: BSTR, bstrRight: BSTR, lcid: LCID, dwFlags: ULONG): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8Pow*(dblLeft: float64, dblRight: float64, pdblResult: ptr float64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR4CmpR8*(fltLeft: float32, dblRight: float64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarR8Round*(dblIn: float64, cDecimals: int32, pdblResult: ptr float64): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromUdate*(pudateIn: ptr UDATE, dwFlags: ULONG, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarDateFromUdateEx*(pudateIn: ptr UDATE, lcid: LCID, dwFlags: ULONG, pdateOut: ptr DATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarUdateFromDate*(dateIn: DATE, dwFlags: ULONG, pudateOut: ptr UDATE): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc GetAltMonthNames*(lcid: LCID, prgp: ptr ptr LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarFormat*(pvarIn: LPVARIANT, pstrFormat: LPOLESTR, iFirstDay: int32, iFirstWeek: int32, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarFormatDateTime*(pvarIn: LPVARIANT, iNamedFormat: int32, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarFormatNumber*(pvarIn: LPVARIANT, iNumDig: int32, iIncLead: int32, iUseParens: int32, iGroup: int32, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarFormatPercent*(pvarIn: LPVARIANT, iNumDig: int32, iIncLead: int32, iUseParens: int32, iGroup: int32, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarFormatCurrency*(pvarIn: LPVARIANT, iNumDig: int32, iIncLead: int32, iUseParens: int32, iGroup: int32, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarWeekdayName*(iWeekday: int32, fAbbrev: int32, iFirstDay: int32, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarMonthName*(iMonth: int32, fAbbrev: int32, dwFlags: ULONG, pbstrOut: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarFormatFromTokens*(pvarIn: LPVARIANT, pstrFormat: LPOLESTR, pbTokCur: LPBYTE, dwFlags: ULONG, pbstrOut: ptr BSTR, lcid: LCID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc VarTokenizeFormatString*(pstrFormat: LPOLESTR, rgbTok: LPBYTE, cbTok: int32, iFirstDay: int32, iFirstWeek: int32, lcid: LCID, pcbActual: ptr int32): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc LHashValOfNameSysA*(syskind: SYSKIND, lcid: LCID, szName: LPCSTR): ULONG {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc LHashValOfNameSys*(syskind: SYSKIND, lcid: LCID, szName: ptr OLECHAR): ULONG {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc LoadTypeLib*(szFile: ptr OLECHAR, pptlib: ptr ptr ITypeLib): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc LoadTypeLibEx*(szFile: LPCOLESTR, regkind: REGKIND, pptlib: ptr ptr ITypeLib): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc LoadRegTypeLib*(rguid: REFGUID, wVerMajor: WORD, wVerMinor: WORD, lcid: LCID, pptlib: ptr ptr ITypeLib): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc QueryPathOfRegTypeLib*(guid: REFGUID, wMaj: USHORT, wMin: USHORT, lcid: LCID, lpbstrPathName: LPBSTR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc RegisterTypeLib*(ptlib: ptr ITypeLib, szFullPath: ptr OLECHAR, szHelpDir: ptr OLECHAR): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc UnRegisterTypeLib*(libID: REFGUID, wVerMajor: WORD, wVerMinor: WORD, lcid: LCID, syskind: SYSKIND): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc CreateTypeLib*(syskind: SYSKIND, szFile: ptr OLECHAR, ppctlib: ptr ptr ICreateTypeLib): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc CreateTypeLib2*(syskind: SYSKIND, szFile: LPCOLESTR, ppctlib: ptr ptr ICreateTypeLib2): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc DispGetParam*(pdispparams: ptr DISPPARAMS, position: UINT, vtTarg: VARTYPE, pvarResult: ptr VARIANT, puArgErr: ptr UINT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc DispGetIDsOfNames*(ptinfo: ptr ITypeInfo, rgszNames: ptr ptr OLECHAR, cNames: UINT, rgdispid: ptr DISPID): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc DispInvoke*(this: pointer, ptinfo: ptr ITypeInfo, dispidMember: DISPID, wFlags: WORD, pparams: ptr DISPPARAMS, pvarResult: ptr VARIANT, pexcepinfo: ptr EXCEPINFO, puArgErr: ptr UINT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc CreateDispTypeInfo*(pidata: ptr INTERFACEDATA, lcid: LCID, pptinfo: ptr ptr ITypeInfo): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc CreateStdDispatch*(punkOuter: ptr IUnknown, pvThis: pointer, ptinfo: ptr ITypeInfo, ppunkStdDisp: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc DispCallFunc*(pvInstance: pointer, oVft: ULONG_PTR, cc: CALLCONV, vtReturn: VARTYPE, cActuals: UINT, prgvt: ptr VARTYPE, prgpvarg: ptr ptr VARIANTARG, pvargResult: ptr VARIANT): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc RegisterActiveObject*(punk: ptr IUnknown, rclsid: REFCLSID, dwFlags: DWORD, pdwRegister: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc RevokeActiveObject*(dwRegister: DWORD, pvReserved: pointer): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc GetActiveObject*(rclsid: REFCLSID, pvReserved: pointer, ppunk: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc SetErrorInfo*(dwReserved: ULONG, perrinfo: ptr IErrorInfo): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc GetErrorInfo*(dwReserved: ULONG, pperrinfo: ptr ptr IErrorInfo): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc CreateErrorInfo*(pperrinfo: ptr ptr ICreateErrorInfo): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc GetRecordInfoFromTypeInfo*(pTypeInfo: ptr ITypeInfo, ppRecInfo: ptr ptr IRecordInfo): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc GetRecordInfoFromGuids*(rGuidTypeLib: REFGUID, uVerMajor: ULONG, uVerMinor: ULONG, lcid: LCID, rGuidTypeInfo: REFGUID, ppRecInfo: ptr ptr IRecordInfo): HRESULT {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OaBuildVersion*(): ULONG {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc ClearCustData*(pCustData: LPCUSTDATA): void {.winapi, stdcall, dynlib: "oleaut32", importc.}
proc OleBuildVersion*(): DWORD {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateDataAdviseHolder*(ppDAHolder: ptr LPDATAADVISEHOLDER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc ReadClassStg*(pStg: LPSTORAGE, pclsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc WriteClassStg*(pStg: LPSTORAGE, rclsid: REFCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc ReadClassStm*(pStm: LPSTREAM, pclsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc WriteClassStm*(pStm: LPSTREAM, rclsid: REFCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc WriteFmtUserTypeStg*(pstg: LPSTORAGE, cf: CLIPFORMAT, lpszUserType: LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc ReadFmtUserTypeStg*(pstg: LPSTORAGE, pcf: ptr CLIPFORMAT, lplpszUserType: ptr LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleInitialize*(pvReserved: LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleUninitialize*(): void {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleQueryLinkFromData*(pSrcDataObject: LPDATAOBJECT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleQueryCreateFromData*(pSrcDataObject: LPDATAOBJECT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreate*(rclsid: REFCLSID, riid: REFIID, renderopt: DWORD, pFormatEtc: LPFORMATETC, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateEx*(rclsid: REFCLSID, riid: REFIID, dwFlags: DWORD, renderopt: DWORD, cFormats: ULONG, rgAdvf: ptr DWORD, rgFormatEtc: LPFORMATETC, lpAdviseSink: ptr IAdviseSink, rgdwConnection: ptr DWORD, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateFromData*(pSrcDataObj: LPDATAOBJECT, riid: REFIID, renderopt: DWORD, pFormatEtc: LPFORMATETC, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateFromDataEx*(pSrcDataObj: LPDATAOBJECT, riid: REFIID, dwFlags: DWORD, renderopt: DWORD, cFormats: ULONG, rgAdvf: ptr DWORD, rgFormatEtc: LPFORMATETC, lpAdviseSink: ptr IAdviseSink, rgdwConnection: ptr DWORD, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateLinkFromData*(pSrcDataObj: LPDATAOBJECT, riid: REFIID, renderopt: DWORD, pFormatEtc: LPFORMATETC, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateLinkFromDataEx*(pSrcDataObj: LPDATAOBJECT, riid: REFIID, dwFlags: DWORD, renderopt: DWORD, cFormats: ULONG, rgAdvf: ptr DWORD, rgFormatEtc: LPFORMATETC, lpAdviseSink: ptr IAdviseSink, rgdwConnection: ptr DWORD, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateStaticFromData*(pSrcDataObj: LPDATAOBJECT, iid: REFIID, renderopt: DWORD, pFormatEtc: LPFORMATETC, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateLink*(pmkLinkSrc: LPMONIKER, riid: REFIID, renderopt: DWORD, lpFormatEtc: LPFORMATETC, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateLinkEx*(pmkLinkSrc: LPMONIKER, riid: REFIID, dwFlags: DWORD, renderopt: DWORD, cFormats: ULONG, rgAdvf: ptr DWORD, rgFormatEtc: LPFORMATETC, lpAdviseSink: ptr IAdviseSink, rgdwConnection: ptr DWORD, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateLinkToFile*(lpszFileName: LPCOLESTR, riid: REFIID, renderopt: DWORD, lpFormatEtc: LPFORMATETC, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateLinkToFileEx*(lpszFileName: LPCOLESTR, riid: REFIID, dwFlags: DWORD, renderopt: DWORD, cFormats: ULONG, rgAdvf: ptr DWORD, rgFormatEtc: LPFORMATETC, lpAdviseSink: ptr IAdviseSink, rgdwConnection: ptr DWORD, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateFromFile*(rclsid: REFCLSID, lpszFileName: LPCOLESTR, riid: REFIID, renderopt: DWORD, lpFormatEtc: LPFORMATETC, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateFromFileEx*(rclsid: REFCLSID, lpszFileName: LPCOLESTR, riid: REFIID, dwFlags: DWORD, renderopt: DWORD, cFormats: ULONG, rgAdvf: ptr DWORD, rgFormatEtc: LPFORMATETC, lpAdviseSink: ptr IAdviseSink, rgdwConnection: ptr DWORD, pClientSite: LPOLECLIENTSITE, pStg: LPSTORAGE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleLoad*(pStg: LPSTORAGE, riid: REFIID, pClientSite: LPOLECLIENTSITE, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleSave*(pPS: LPPERSISTSTORAGE, pStg: LPSTORAGE, fSameAsLoad: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleLoadFromStream*(pStm: LPSTREAM, iidInterface: REFIID, ppvObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleSaveToStream*(pPStm: LPPERSISTSTREAM, pStm: LPSTREAM): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleSetContainedObject*(pUnknown: LPUNKNOWN, fContained: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleNoteObjectVisible*(pUnknown: LPUNKNOWN, fVisible: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc RegisterDragDrop*(hwnd: HWND, pDropTarget: LPDROPTARGET): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc RevokeDragDrop*(hwnd: HWND): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc DoDragDrop*(pDataObj: LPDATAOBJECT, pDropSource: LPDROPSOURCE, dwOKEffects: DWORD, pdwEffect: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleSetClipboard*(pDataObj: LPDATAOBJECT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleGetClipboard*(ppDataObj: ptr LPDATAOBJECT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleFlushClipboard*(): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleIsCurrentClipboard*(pDataObj: LPDATAOBJECT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateMenuDescriptor*(hmenuCombined: HMENU, lpMenuWidths: LPOLEMENUGROUPWIDTHS): HOLEMENU {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleSetMenuDescriptor*(holemenu: HOLEMENU, hwndFrame: HWND, hwndActiveObject: HWND, lpFrame: LPOLEINPLACEFRAME, lpActiveObj: LPOLEINPLACEACTIVEOBJECT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleDestroyMenuDescriptor*(holemenu: HOLEMENU): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleTranslateAccelerator*(lpFrame: LPOLEINPLACEFRAME, lpFrameInfo: LPOLEINPLACEFRAMEINFO, lpmsg: LPMSG): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleDuplicateData*(hSrc: HANDLE, cfFormat: CLIPFORMAT, uiFlags: UINT): HANDLE {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleDraw*(pUnknown: LPUNKNOWN, dwAspect: DWORD, hdcDraw: HDC, lprcBounds: LPCRECT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleRun*(pUnknown: LPUNKNOWN): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleIsRunning*(pObject: LPOLEOBJECT): WINBOOL {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleLockRunning*(pUnknown: LPUNKNOWN, fLock: WINBOOL, fLastUnlockCloses: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc ReleaseStgMedium*(P1: LPSTGMEDIUM): void {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateOleAdviseHolder*(ppOAHolder: ptr LPOLEADVISEHOLDER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateDefaultHandler*(clsid: REFCLSID, pUnkOuter: LPUNKNOWN, riid: REFIID, lplpObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleCreateEmbeddingHelper*(clsid: REFCLSID, pUnkOuter: LPUNKNOWN, flags: DWORD, pCF: LPCLASSFACTORY, riid: REFIID, lplpObj: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc IsAccelerator*(hAccel: HACCEL, cAccelEntries: int32, lpMsg: LPMSG, lpwCmd: ptr WORD): WINBOOL {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleGetIconOfFile*(lpszPath: LPOLESTR, fUseFileAsLabel: WINBOOL): HGLOBAL {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleGetIconOfClass*(rclsid: REFCLSID, lpszLabel: LPOLESTR, fUseTypeAsLabel: WINBOOL): HGLOBAL {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleMetafilePictFromIconAndLabel*(hIcon: HICON, lpszLabel: LPOLESTR, lpszSourceFile: LPOLESTR, iIconIndex: UINT): HGLOBAL {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleRegGetUserType*(clsid: REFCLSID, dwFormOfType: DWORD, pszUserType: ptr LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleRegGetMiscStatus*(clsid: REFCLSID, dwAspect: DWORD, pdwStatus: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleRegEnumFormatEtc*(clsid: REFCLSID, dwDirection: DWORD, ppenum: ptr LPENUMFORMATETC): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleRegEnumVerbs*(clsid: REFCLSID, ppenum: ptr LPENUMOLEVERB): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleConvertOLESTREAMToIStorage*(lpolestream: LPOLESTREAM, pstg: LPSTORAGE, ptd: ptr DVTARGETDEVICE): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleConvertIStorageToOLESTREAM*(pstg: LPSTORAGE, lpolestream: LPOLESTREAM): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc GetHGlobalFromILockBytes*(plkbyt: LPLOCKBYTES, phglobal: ptr HGLOBAL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateILockBytesOnHGlobal*(hGlobal: HGLOBAL, fDeleteOnRelease: WINBOOL, pplkbyt: ptr LPLOCKBYTES): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleDoAutoConvert*(pStg: LPSTORAGE, pClsidNew: LPCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleGetAutoConvert*(clsidOld: REFCLSID, pClsidNew: LPCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleSetAutoConvert*(clsidOld: REFCLSID, clsidNew: REFCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc GetConvertStg*(pStg: LPSTORAGE): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc SetConvertStg*(pStg: LPSTORAGE, fConvert: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleConvertIStorageToOLESTREAMEx*(pstg: LPSTORAGE, cfFormat: CLIPFORMAT, lWidth: LONG, lHeight: LONG, dwSize: DWORD, pmedium: LPSTGMEDIUM, polestm: LPOLESTREAM): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc OleConvertOLESTREAMToIStorageEx*(polestm: LPOLESTREAM, pstg: LPSTORAGE, pcfFormat: ptr CLIPFORMAT, plwWidth: ptr LONG, plHeight: ptr LONG, pdwSize: ptr DWORD, pmedium: LPSTGMEDIUM): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateStreamOnHGlobal*(hGlobal: HGLOBAL, fDeleteOnRelease: WINBOOL, ppstm: ptr LPSTREAM): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc GetHGlobalFromStream*(pstm: LPSTREAM, phglobal: ptr HGLOBAL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoUninitialize*(): void {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoInitializeEx*(pvReserved: LPVOID, dwCoInit: DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetCurrentLogicalThreadId*(pguid: ptr GUID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetContextToken*(pToken: ptr ULONG_PTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetApartmentType*(pAptType: ptr APTTYPE, pAptQualifier: ptr APTTYPEQUALIFIER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetObjectContext*(riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRegisterClassObject*(rclsid: REFCLSID, pUnk: LPUNKNOWN, dwClsContext: DWORD, flags: DWORD, lpdwRegister: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRevokeClassObject*(dwRegister: DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoResumeClassObjects*(): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoSuspendClassObjects*(): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetMalloc*(dwMemContext: DWORD, ppMalloc: ptr LPMALLOC): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetCurrentProcess*(): DWORD {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetCallerTID*(lpdwTID: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetDefaultContext*(aptType: APTTYPE, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoDecodeProxy*(dwClientPid: DWORD, ui64ProxyAddress: UINT64, pServerInformation: PServerInformation): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoIncrementMTAUsage*(pCookie: ptr CO_MTA_USAGE_COOKIE): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoDecrementMTAUsage*(Cookie: CO_MTA_USAGE_COOKIE): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoWaitForMultipleObjects*(dwFlags: DWORD, dwTimeout: DWORD, cHandles: ULONG, pHandles: ptr HANDLE, lpdwindex: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoAllowUnmarshalerCLSID*(clsid: REFCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetClassObject*(rclsid: REFCLSID, dwClsContext: DWORD, pvReserved: LPVOID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoAddRefServerProcess*(): ULONG {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoReleaseServerProcess*(): ULONG {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetPSClsid*(riid: REFIID, pClsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRegisterPSClsid*(riid: REFIID, rclsid: REFCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRegisterSurrogate*(pSurrogate: LPSURROGATE): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoMarshalHresult*(pstm: LPSTREAM, hresult: HRESULT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoUnmarshalHresult*(pstm: LPSTREAM, phresult: ptr HRESULT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoLockObjectExternal*(pUnk: LPUNKNOWN, fLock: WINBOOL, fLastUnlockReleases: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetStdMarshalEx*(pUnkOuter: LPUNKNOWN, smexflags: DWORD, ppUnkInner: ptr LPUNKNOWN): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetMarshalSizeMax*(pulSize: ptr ULONG, riid: REFIID, pUnk: LPUNKNOWN, dwDestContext: DWORD, pvDestContext: LPVOID, mshlflags: DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoMarshalInterface*(pStm: LPSTREAM, riid: REFIID, pUnk: LPUNKNOWN, dwDestContext: DWORD, pvDestContext: LPVOID, mshlflags: DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoUnmarshalInterface*(pStm: LPSTREAM, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoReleaseMarshalData*(pStm: LPSTREAM): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoDisconnectObject*(pUnk: LPUNKNOWN, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetStandardMarshal*(riid: REFIID, pUnk: LPUNKNOWN, dwDestContext: DWORD, pvDestContext: LPVOID, mshlflags: DWORD, ppMarshal: ptr LPMARSHAL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoMarshalInterThreadInterfaceInStream*(riid: REFIID, pUnk: LPUNKNOWN, ppStm: ptr LPSTREAM): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetInterfaceAndReleaseStream*(pStm: LPSTREAM, iid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoCreateFreeThreadedMarshaler*(punkOuter: LPUNKNOWN, ppunkMarshal: ptr LPUNKNOWN): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoFreeUnusedLibraries*(): void {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoFreeUnusedLibrariesEx*(dwUnloadDelay: DWORD, dwReserved: DWORD): void {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoInitializeSecurity*(pSecDesc: PSECURITY_DESCRIPTOR, cAuthSvc: LONG, asAuthSvc: ptr SOLE_AUTHENTICATION_SERVICE, pReserved1: pointer, dwAuthnLevel: DWORD, dwImpLevel: DWORD, pAuthList: pointer, dwCapabilities: DWORD, pReserved3: pointer): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoSwitchCallContext*(pNewObject: ptr IUnknown, ppOldObject: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoCreateInstanceFromApp*(Clsid: REFCLSID, punkOuter: ptr IUnknown, dwClsCtx: DWORD, reserved: PVOID, dwCount: DWORD, pResults: ptr MULTI_QI): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoIsHandlerConnected*(pUnk: LPUNKNOWN): WINBOOL {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoDisconnectContext*(dwTimeout: DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetCallContext*(riid: REFIID, ppInterface: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoQueryProxyBlanket*(pProxy: ptr IUnknown, pwAuthnSvc: ptr DWORD, pAuthzSvc: ptr DWORD, pServerPrincName: ptr LPOLESTR, pAuthnLevel: ptr DWORD, pImpLevel: ptr DWORD, pAuthInfo: ptr RPC_AUTH_IDENTITY_HANDLE, pCapabilites: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoSetProxyBlanket*(pProxy: ptr IUnknown, dwAuthnSvc: DWORD, dwAuthzSvc: DWORD, pServerPrincName: ptr OLECHAR, dwAuthnLevel: DWORD, dwImpLevel: DWORD, pAuthInfo: RPC_AUTH_IDENTITY_HANDLE, dwCapabilities: DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoCopyProxy*(pProxy: ptr IUnknown, ppCopy: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoQueryClientBlanket*(pAuthnSvc: ptr DWORD, pAuthzSvc: ptr DWORD, pServerPrincName: ptr LPOLESTR, pAuthnLevel: ptr DWORD, pImpLevel: ptr DWORD, pPrivs: ptr RPC_AUTHZ_HANDLE, pCapabilities: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoImpersonateClient*(): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRevertToSelf*(): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoQueryAuthenticationServices*(pcAuthSvc: ptr DWORD, asAuthSvc: ptr ptr SOLE_AUTHENTICATION_SERVICE): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoCreateInstance*(rclsid: REFCLSID, pUnkOuter: LPUNKNOWN, dwClsContext: DWORD, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoCreateInstanceEx*(Clsid: REFCLSID, punkOuter: ptr IUnknown, dwClsCtx: DWORD, pServerInfo: ptr COSERVERINFO, dwCount: DWORD, pResults: ptr MULTI_QI): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetCancelObject*(dwThreadId: DWORD, iid: REFIID, ppUnk: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoSetCancelObject*(pUnk: ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoCancelCall*(dwThreadId: DWORD, ulTimeout: ULONG): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoTestCancel*(): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoEnableCallCancellation*(pReserved: LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoDisableCallCancellation*(pReserved: LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StringFromCLSID*(rclsid: REFCLSID, lplpsz: ptr LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CLSIDFromString*(lpsz: LPCOLESTR, pclsid: LPCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StringFromIID*(rclsid: REFIID, lplpsz: ptr LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc IIDFromString*(lpsz: LPCOLESTR, lpiid: LPIID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc ProgIDFromCLSID*(clsid: REFCLSID, lplpszProgID: ptr LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CLSIDFromProgID*(lpszProgID: LPCOLESTR, lpclsid: LPCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StringFromGUID2*(rguid: REFGUID, lpsz: LPOLESTR, cchMax: int32): int32 {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoCreateGuid*(pguid: ptr GUID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc PropVariantCopy*(pvarDest: ptr PROPVARIANT, pvarSrc: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc PropVariantClear*(pvar: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc FreePropVariantArray*(cVariants: ULONG, rgvars: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoWaitForMultipleHandles*(dwFlags: DWORD, dwTimeout: DWORD, cHandles: ULONG, pHandles: LPHANDLE, lpdwindex: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetTreatAsClass*(clsidOld: REFCLSID, pClsidNew: LPCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoInvalidateRemoteMachineBindings*(pszMachineName: LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc DllGetClassObject*(rclsid: REFCLSID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc DllCanUnloadNow*(): HRESULT {.winapi, stdcall, dynlib: "shell32", importc.}
proc CoTaskMemAlloc*(cb: SIZE_T): LPVOID {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoTaskMemRealloc*(pv: LPVOID, cb: SIZE_T): LPVOID {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoTaskMemFree*(pv: LPVOID): void {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoBuildVersion*(): DWORD {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoInitialize*(pvReserved: LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRegisterMallocSpy*(pMallocSpy: LPMALLOCSPY): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRevokeMallocSpy*(): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRegisterInitializeSpy*(pSpy: LPINITIALIZESPY, puliCookie: ptr ULARGE_INTEGER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRevokeInitializeSpy*(uliCookie: ULARGE_INTEGER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetSystemSecurityPermissions*(comSDType: COMSD, ppSD: ptr PSECURITY_DESCRIPTOR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoLoadLibrary*(lpszLibName: LPOLESTR, bAutoFree: WINBOOL): HINSTANCE {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoFreeLibrary*(hInst: HINSTANCE): void {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoFreeAllLibraries*(): void {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetInstanceFromFile*(pServerInfo: ptr COSERVERINFO, pClsid: ptr CLSID, punkOuter: ptr IUnknown, dwClsCtx: DWORD, grfMode: DWORD, pwszName: ptr OLECHAR, dwCount: DWORD, pResults: ptr MULTI_QI): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetInstanceFromIStorage*(pServerInfo: ptr COSERVERINFO, pClsid: ptr CLSID, punkOuter: ptr IUnknown, dwClsCtx: DWORD, pstg: ptr IStorage, dwCount: DWORD, pResults: ptr MULTI_QI): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoAllowSetForegroundWindow*(pUnk: ptr IUnknown, lpvReserved: LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc DcomChannelSetHResult*(pvReserved: LPVOID, pulReserved: ptr ULONG, appsHR: HRESULT): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoIsOle1Class*(rclsid: REFCLSID): WINBOOL {.winapi, stdcall, dynlib: "ole32", importc.}
proc CLSIDFromProgIDEx*(lpszProgID: LPCOLESTR, lpclsid: LPCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoFileTimeToDosDateTime*(lpFileTime: ptr FILETIME, lpDosDate: LPWORD, lpDosTime: LPWORD): WINBOOL {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoDosDateTimeToFileTime*(nDosDate: WORD, nDosTime: WORD, lpFileTime: ptr FILETIME): WINBOOL {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoFileTimeNow*(lpFileTime: ptr FILETIME): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRegisterMessageFilter*(lpMessageFilter: LPMESSAGEFILTER, lplpMessageFilter: ptr LPMESSAGEFILTER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoRegisterChannelHook*(ExtensionUuid: REFGUID, pChannelHook: ptr IChannelHook): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoTreatAsClass*(clsidOld: REFCLSID, clsidNew: REFCLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateDataCache*(pUnkOuter: LPUNKNOWN, rclsid: REFCLSID, iid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgCreateDocfile*(pwcsName: ptr WCHAR, grfMode: DWORD, reserved: DWORD, ppstgOpen: ptr ptr IStorage): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgCreateDocfileOnILockBytes*(plkbyt: ptr ILockBytes, grfMode: DWORD, reserved: DWORD, ppstgOpen: ptr ptr IStorage): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgOpenStorage*(pwcsName: ptr WCHAR, pstgPriority: ptr IStorage, grfMode: DWORD, snbExclude: SNB, reserved: DWORD, ppstgOpen: ptr ptr IStorage): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgOpenStorageOnILockBytes*(plkbyt: ptr ILockBytes, pstgPriority: ptr IStorage, grfMode: DWORD, snbExclude: SNB, reserved: DWORD, ppstgOpen: ptr ptr IStorage): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgIsStorageFile*(pwcsName: ptr WCHAR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgIsStorageILockBytes*(plkbyt: ptr ILockBytes): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgSetTimes*(lpszName: ptr WCHAR, pctime: ptr FILETIME, patime: ptr FILETIME, pmtime: ptr FILETIME): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgOpenAsyncDocfileOnIFillLockBytes*(pflb: ptr IFillLockBytes, grfMode: DWORD, asyncFlags: DWORD, ppstgOpen: ptr ptr IStorage): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgGetIFillLockBytesOnILockBytes*(pilb: ptr ILockBytes, ppflb: ptr ptr IFillLockBytes): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgGetIFillLockBytesOnFile*(pwcsName: ptr OLECHAR, ppflb: ptr ptr IFillLockBytes): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgCreateStorageEx*(pwcsName: ptr WCHAR, grfMode: DWORD, stgfmt: DWORD, grfAttrs: DWORD, pStgOptions: ptr STGOPTIONS, pSecurityDescriptor: PSECURITY_DESCRIPTOR, riid: REFIID, ppObjectOpen: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgOpenStorageEx*(pwcsName: ptr WCHAR, grfMode: DWORD, stgfmt: DWORD, grfAttrs: DWORD, pStgOptions: ptr STGOPTIONS, pSecurityDescriptor: PSECURITY_DESCRIPTOR, riid: REFIID, ppObjectOpen: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc BindMoniker*(pmk: LPMONIKER, grfOpt: DWORD, iidResult: REFIID, ppvResult: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoGetObject*(pszName: LPCWSTR, pBindOptions: ptr BIND_OPTS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc MkParseDisplayName*(pbc: LPBC, szUserName: LPCOLESTR, pchEaten: ptr ULONG, ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc MonikerRelativePathTo*(pmkSrc: LPMONIKER, pmkDest: LPMONIKER, ppmkRelPath: ptr LPMONIKER, dwReserved: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc MonikerCommonPrefixWith*(pmkThis: LPMONIKER, pmkOther: LPMONIKER, ppmkCommon: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateBindCtx*(reserved: DWORD, ppbc: ptr LPBC): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateGenericComposite*(pmkFirst: LPMONIKER, pmkRest: LPMONIKER, ppmkComposite: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc GetClassFile*(szFilename: LPCOLESTR, pclsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateClassMoniker*(rclsid: REFCLSID, ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateFileMoniker*(lpszPathName: LPCOLESTR, ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateItemMoniker*(lpszDelim: LPCOLESTR, lpszItem: LPCOLESTR, ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateAntiMoniker*(ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreatePointerMoniker*(punk: LPUNKNOWN, ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateObjrefMoniker*(punk: LPUNKNOWN, ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CoInstall*(pbc: ptr IBindCtx, dwFlags: DWORD, pClassSpec: ptr uCLSSPEC, pQuery: ptr QUERYCONTEXT, pszCodeBase: LPWSTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc GetRunningObjectTable*(reserved: DWORD, pprot: ptr LPRUNNINGOBJECTTABLE): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateURLMoniker*(pMkCtx: LPMONIKER, szURL: LPCWSTR, ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateURLMonikerEx*(pMkCtx: LPMONIKER, szURL: LPCWSTR, ppmk: ptr LPMONIKER, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc GetClassURL*(szURL: LPCWSTR, pClsID: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateAsyncBindCtx*(reserved: DWORD, pBSCb: ptr IBindStatusCallback, pEFetc: ptr IEnumFORMATETC, ppBC: ptr ptr IBindCtx): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateURLMonikerEx2*(pMkCtx: LPMONIKER, pUri: ptr IUri, ppmk: ptr LPMONIKER, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateAsyncBindCtxEx*(pbc: ptr IBindCtx, dwOptions: DWORD, pBSCb: ptr IBindStatusCallback, pEnum: ptr IEnumFORMATETC, ppBC: ptr ptr IBindCtx, reserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc MkParseDisplayNameEx*(pbc: ptr IBindCtx, szDisplayName: LPCWSTR, pchEaten: ptr ULONG, ppmk: ptr LPMONIKER): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc RegisterBindStatusCallback*(pBC: LPBC, pBSCb: ptr IBindStatusCallback, ppBSCBPrev: ptr ptr IBindStatusCallback, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc RevokeBindStatusCallback*(pBC: LPBC, pBSCb: ptr IBindStatusCallback): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc GetClassFileOrMime*(pBC: LPBC, szFilename: LPCWSTR, pBuffer: LPVOID, cbSize: DWORD, szMime: LPCWSTR, dwReserved: DWORD, pclsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc IsValidURL*(pBC: LPBC, szURL: LPCWSTR, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoGetClassObjectFromURL*(rCLASSID: REFCLSID, szCODE: LPCWSTR, dwFileVersionMS: DWORD, dwFileVersionLS: DWORD, szTYPE: LPCWSTR, pBindCtx: LPBINDCTX, dwClsContext: DWORD, pvReserved: LPVOID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc IEInstallScope*(pdwScope: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc FaultInIEFeature*(hWnd: HWND, pClassSpec: ptr uCLSSPEC, pQuery: ptr QUERYCONTEXT, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc GetComponentIDFromCLSSPEC*(pClassspec: ptr uCLSSPEC, ppszComponentID: ptr LPSTR): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc IsAsyncMoniker*(pmk: ptr IMoniker): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc RegisterMediaTypes*(ctypes: UINT, rgszTypes: ptr LPCSTR, rgcfTypes: ptr CLIPFORMAT): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc FindMediaType*(rgszTypes: LPCSTR, rgcfTypes: ptr CLIPFORMAT): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateFormatEnumerator*(cfmtetc: UINT, rgfmtetc: ptr FORMATETC, ppenumfmtetc: ptr ptr IEnumFORMATETC): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc RegisterFormatEnumerator*(pBC: LPBC, pEFetc: ptr IEnumFORMATETC, reserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc RevokeFormatEnumerator*(pBC: LPBC, pEFetc: ptr IEnumFORMATETC): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc RegisterMediaTypeClass*(pBC: LPBC, ctypes: UINT, rgszTypes: ptr LPCSTR, rgclsID: ptr CLSID, reserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc FindMediaTypeClass*(pBC: LPBC, szType: LPCSTR, pclsID: ptr CLSID, reserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc UrlMkSetSessionOption*(dwOption: DWORD, pBuffer: LPVOID, dwBufferLength: DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc UrlMkGetSessionOption*(dwOption: DWORD, pBuffer: LPVOID, dwBufferLength: DWORD, pdwBufferLengthOut: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc FindMimeFromData*(pBC: LPBC, pwzUrl: LPCWSTR, pBuffer: LPVOID, cbSize: DWORD, pwzMimeProposed: LPCWSTR, dwMimeFlags: DWORD, ppwzMimeOut: ptr LPWSTR, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc ObtainUserAgentString*(dwOption: DWORD, pszUAOut: LPSTR, cbSize: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CompareSecurityIds*(pbSecurityId1: ptr BYTE, dwLen1: DWORD, pbSecurityId2: ptr BYTE, dwLen2: DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CompatFlagsFromClsid*(pclsid: ptr CLSID, pdwCompatFlags: LPDWORD, pdwMiscStatusFlags: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateUri*(pwzURI: LPCWSTR, dwFlags: DWORD, dwReserved: DWORD_PTR, ppURI: ptr ptr IUri): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateUriWithFragment*(pwzURI: LPCWSTR, pwzFragment: LPCWSTR, dwFlags: DWORD, dwReserved: DWORD_PTR, ppURI: ptr ptr IUri): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateUriFromMultiByteString*(pszANSIInputUri: LPCSTR, dwEncodingFlags: DWORD, dwCodePage: DWORD, dwCreateFlags: DWORD, dwReserved: DWORD_PTR, ppUri: ptr ptr IUri): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CreateIUriBuilder*(pIUri: ptr IUri, dwFlags: DWORD, dwReserved: DWORD_PTR, ppIUriBuilder: ptr ptr IUriBuilder): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc HlinkSimpleNavigateToString*(szTarget: LPCWSTR, szLocation: LPCWSTR, szTargetFrameName: LPCWSTR, pUnk: ptr IUnknown, pbc: ptr IBindCtx, P6: ptr IBindStatusCallback, grfHLNF: DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc HlinkSimpleNavigateToMoniker*(pmkTarget: ptr IMoniker, szLocation: LPCWSTR, szTargetFrameName: LPCWSTR, pUnk: ptr IUnknown, pbc: ptr IBindCtx, P6: ptr IBindStatusCallback, grfHLNF: DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLOpenStreamA*(P1: LPUNKNOWN, P2: LPCSTR, P3: DWORD, P4: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLOpenStreamW*(P1: LPUNKNOWN, P2: LPCWSTR, P3: DWORD, P4: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLOpenPullStreamA*(P1: LPUNKNOWN, P2: LPCSTR, P3: DWORD, P4: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLOpenPullStreamW*(P1: LPUNKNOWN, P2: LPCWSTR, P3: DWORD, P4: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLDownloadToFileA*(P1: LPUNKNOWN, P2: LPCSTR, P3: LPCSTR, P4: DWORD, P5: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLDownloadToFileW*(P1: LPUNKNOWN, P2: LPCWSTR, P3: LPCWSTR, P4: DWORD, P5: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLDownloadToCacheFileA*(P1: LPUNKNOWN, P2: LPCSTR, P3: LPSTR, P4: DWORD, P5: DWORD, P6: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLDownloadToCacheFileW*(P1: LPUNKNOWN, P2: LPCWSTR, P3: LPWSTR, P4: DWORD, P5: DWORD, P6: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLOpenBlockingStreamA*(P1: LPUNKNOWN, P2: LPCSTR, P3: ptr LPSTREAM, P4: DWORD, P5: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc URLOpenBlockingStreamW*(P1: LPUNKNOWN, P2: LPCWSTR, P3: ptr LPSTREAM, P4: DWORD, P5: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc HlinkGoBack*(pUnk: ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc HlinkGoForward*(pUnk: ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc HlinkNavigateString*(pUnk: ptr IUnknown, szTarget: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc HlinkNavigateMoniker*(pUnk: ptr IUnknown, pmkTarget: ptr IMoniker): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetParseUrl*(pwzUrl: LPCWSTR, ParseAction: PARSEACTION, dwFlags: DWORD, pszResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetParseIUri*(pIUri: ptr IUri, ParseAction: PARSEACTION, dwFlags: DWORD, pwzResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetCombineUrl*(pwzBaseUrl: LPCWSTR, pwzRelativeUrl: LPCWSTR, dwCombineFlags: DWORD, pszResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetCombineUrlEx*(pBaseUri: ptr IUri, pwzRelativeUrl: LPCWSTR, dwCombineFlags: DWORD, ppCombinedUri: ptr ptr IUri, dwReserved: DWORD_PTR): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetCombineIUri*(pBaseUri: ptr IUri, pRelativeUri: ptr IUri, dwCombineFlags: DWORD, ppCombinedUri: ptr ptr IUri, dwReserved: DWORD_PTR): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetCompareUrl*(pwzUrl1: LPCWSTR, pwzUrl2: LPCWSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetGetProtocolFlags*(pwzUrl: LPCWSTR, pdwFlags: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetQueryInfo*(pwzUrl: LPCWSTR, QueryOptions: QUERYOPTION, dwQueryFlags: DWORD, pvBuffer: LPVOID, cbBuffer: DWORD, pcbBuffer: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetGetSession*(dwSessionMode: DWORD, ppIInternetSession: ptr ptr IInternetSession, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetGetSecurityUrl*(pwszUrl: LPCWSTR, ppwszSecUrl: ptr LPWSTR, psuAction: PSUACTION, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc AsyncInstallDistributionUnit*(szDistUnit: LPCWSTR, szTYPE: LPCWSTR, szExt: LPCWSTR, dwFileVersionMS: DWORD, dwFileVersionLS: DWORD, szURL: LPCWSTR, pbc: ptr IBindCtx, pvReserved: LPVOID, flags: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetGetSecurityUrlEx*(pUri: ptr IUri, ppSecUri: ptr ptr IUri, psuAction: PSUACTION, dwReserved: DWORD_PTR): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetSetFeatureEnabled*(FeatureEntry: INTERNETFEATURELIST, dwFlags: DWORD, fEnable: WINBOOL): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetIsFeatureEnabled*(FeatureEntry: INTERNETFEATURELIST, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetIsFeatureEnabledForUrl*(FeatureEntry: INTERNETFEATURELIST, dwFlags: DWORD, szURL: LPCWSTR, pSecMgr: ptr IInternetSecurityManager): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetIsFeatureEnabledForIUri*(FeatureEntry: INTERNETFEATURELIST, dwFlags: DWORD, pIUri: ptr IUri, pSecMgr: ptr IInternetSecurityManagerEx2): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetIsFeatureZoneElevationEnabled*(szFromURL: LPCWSTR, szToURL: LPCWSTR, pSecMgr: ptr IInternetSecurityManager, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CopyStgMedium*(pcstgmedSrc: ptr STGMEDIUM, pstgmedDest: ptr STGMEDIUM): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CopyBindInfo*(pcbiSrc: ptr BINDINFO, pbiDest: ptr BINDINFO): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc ReleaseBindInfo*(pbindinfo: ptr BINDINFO): void {.winapi, stdcall, dynlib: "urlmon", importc.}
proc OInetParseUrl*(pwzUrl: LPCWSTR, ParseAction: PARSEACTION, dwFlags: DWORD, pszResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "CoInternetParseUrl".}
proc OInetCombineUrl*(pwzBaseUrl: LPCWSTR, pwzRelativeUrl: LPCWSTR, dwCombineFlags: DWORD, pszResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "CoInternetCombineUrl".}
proc OInetCombineUrlEx*(pBaseUri: ptr IUri, pwzRelativeUrl: LPCWSTR, dwCombineFlags: DWORD, ppCombinedUri: ptr ptr IUri, dwReserved: DWORD_PTR): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "CoInternetCombineUrlEx".}
proc OInetCombineIUri*(pBaseUri: ptr IUri, pRelativeUri: ptr IUri, dwCombineFlags: DWORD, ppCombinedUri: ptr ptr IUri, dwReserved: DWORD_PTR): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "CoInternetCombineIUri".}
proc OInetCompareUrl*(pwzUrl1: LPCWSTR, pwzUrl2: LPCWSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "CoInternetCompareUrl".}
proc OInetQueryInfo*(pwzUrl: LPCWSTR, QueryOptions: QUERYOPTION, dwQueryFlags: DWORD, pvBuffer: LPVOID, cbBuffer: DWORD, pcbBuffer: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "CoInternetQueryInfo".}
proc OInetGetSession*(dwSessionMode: DWORD, ppIInternetSession: ptr ptr IInternetSession, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "CoInternetGetSession".}
proc CoInternetCreateSecurityManager*(pSP: ptr IServiceProvider, ppSM: ptr ptr IInternetSecurityManager, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc CoInternetCreateZoneManager*(pSP: ptr IServiceProvider, ppZM: ptr ptr IInternetZoneManager, dwReserved: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc GetSoftwareUpdateInfo*(szDistUnit: LPCWSTR, psdi: LPSOFTDISTINFO): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc SetSoftwareUpdateAdvertisementState*(szDistUnit: LPCWSTR, dwAdState: DWORD, dwAdvertisedVersionMS: DWORD, dwAdvertisedVersionLS: DWORD): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc.}
proc IsLoggingEnabledA*(pszUrl: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "urlmon", importc.}
proc IsLoggingEnabledW*(pwszUrl: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "urlmon", importc.}
proc WriteHitLogging*(lpLogginginfo: LPHIT_LOGGING_INFO): WINBOOL {.winapi, stdcall, dynlib: "urlmon", importc.}
proc StgCreatePropStg*(pUnk: ptr IUnknown, fmtid: REFFMTID, pclsid: ptr CLSID, grfFlags: DWORD, dwReserved: DWORD, ppPropStg: ptr ptr IPropertyStorage): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgOpenPropStg*(pUnk: ptr IUnknown, fmtid: REFFMTID, grfFlags: DWORD, dwReserved: DWORD, ppPropStg: ptr ptr IPropertyStorage): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc StgCreatePropSetStg*(pStorage: ptr IStorage, dwReserved: DWORD, ppPropSetStg: ptr ptr IPropertySetStorage): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc FmtIdToPropStgName*(pfmtid: ptr FMTID, oszName: LPOLESTR): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc PropStgNameToFmtId*(oszName: LPOLESTR, pfmtid: ptr FMTID): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc CreateStdProgressIndicator*(hwndParent: HWND, pszTitle: LPCOLESTR, pIbscCaller: ptr IBindStatusCallback, ppIbsc: ptr ptr IBindStatusCallback): HRESULT {.winapi, stdcall, dynlib: "ole32", importc.}
proc PSCoerceToCanonicalValue*(key: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSCreateAdapterFromPropertyStore*(pps: ptr IPropertyStore, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSCreateDelayedMultiplexPropertyStore*(flags: GETPROPERTYSTOREFLAGS, pdpsf: ptr IDelayedPropertyStoreFactory, rgStoreIds: ptr DWORD, cStores: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSCreateMemoryPropertyStore*(riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSCreateMultiplexPropertyStore*(prgpunkStores: ptr ptr IUnknown, cStores: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSCreatePropertyChangeArray*(rgpropkey: ptr PROPERTYKEY, rgflags: ptr PKA_FLAGS, rgpropvar: ptr PROPVARIANT, cChanges: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSCreatePropertyStoreFromObject*(punk: ptr IUnknown, grfMode: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSCreatePropertyStoreFromPropertySetStorage*(ppss: ptr IPropertySetStorage, grfMode: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSCreateSimplePropertyChange*(flags: PKA_FLAGS, key: REFPROPERTYKEY, propvar: REFPROPVARIANT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSEnumeratePropertyDescriptions*(filterOn: PROPDESC_ENUMFILTER, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSFormatForDisplay*(propkey: REFPROPERTYKEY, propvar: REFPROPVARIANT, pdfFlags: PROPDESC_FORMAT_FLAGS, pwszText: LPWSTR, cchText: DWORD): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSFormatForDisplayAlloc*(key: REFPROPERTYKEY, propvar: REFPROPVARIANT, pdff: PROPDESC_FORMAT_FLAGS, ppszDisplay: ptr PWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSFormatPropertyValue*(pps: ptr IPropertyStore, ppd: ptr IPropertyDescription, pdff: PROPDESC_FORMAT_FLAGS, ppszDisplay: ptr LPWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetImageReferenceForValue*(propkey: REFPROPERTYKEY, propvar: REFPROPVARIANT, ppszImageRes: ptr PWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetItemPropertyHandler*(punkItem: ptr IUnknown, fReadWrite: BOOL, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetItemPropertyHandlerWithCreateObject*(punkItem: ptr IUnknown, fReadWrite: BOOL, punkCreateObject: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetNamedPropertyFromPropertyStorage*(psps: PCUSERIALIZEDPROPSTORAGE, cb: DWORD, pszName: LPCWSTR, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetNameFromPropertyKey*(propkey: REFPROPERTYKEY, ppszCanonicalName: ptr PWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetPropertyDescription*(propkey: REFPROPERTYKEY, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetPropertyDescriptionByName*(pszCanonicalName: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetPropertyDescriptionListFromString*(pszPropList: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetPropertyFromPropertyStorage*(psps: PCUSERIALIZEDPROPSTORAGE, cb: DWORD, rpkey: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetPropertyKeyFromName*(pszName: PCWSTR, ppropkey: ptr PROPERTYKEY): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetPropertySystem*(riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSGetPropertyValue*(pps: ptr IPropertyStore, ppd: ptr IPropertyDescription, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSLookupPropertyHandlerCLSID*(pszFilePath: PCWSTR, pclsid: ptr CLSID): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_Delete*(propBag: ptr IPropertyBag, propName: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadBOOL*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr BOOL): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadBSTR*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadDWORD*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadGUID*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr GUID): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadInt*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr INT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadLONG*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr LONG): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadPOINTL*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr POINTL): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadPOINTS*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr POINTS): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadPropertyKey*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr PROPERTYKEY): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadRECTL*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr RECTL): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadSHORT*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr SHORT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadStr*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: LPWSTR, characterCount: int32): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadStrAlloc*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr PWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadStream*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr ptr IStream): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadType*(propBag: ptr IPropertyBag, propName: LPCWSTR, `var`: ptr VARIANT, `type`: VARTYPE): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadULONGLONG*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr ULONGLONG): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_ReadUnknown*(propBag: ptr IPropertyBag, propName: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteBOOL*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: BOOL): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteBSTR*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: BSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteDWORD*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: DWORD): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteGUID*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr GUID): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteInt*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: INT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteLONG*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: LONG): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WritePOINTL*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr POINTL): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WritePOINTS*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr POINTS): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WritePropertyKey*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: REFPROPERTYKEY): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteRECTL*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr RECTL): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteSHORT*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: SHORT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteStr*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteStream*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ptr IStream): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteULONGLONG*(propBag: ptr IPropertyBag, propName: LPCWSTR, value: ULONGLONG): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyBag_WriteUnknown*(propBag: ptr IPropertyBag, propName: LPCWSTR, punk: ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSPropertyKeyFromString*(pszString: LPCWSTR, pkey: ptr PROPERTYKEY): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSRefreshPropertySchema*(): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSRegisterPropertySchema*(pszPath: PCWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSSetPropertyValue*(pps: ptr IPropertyStore, ppd: ptr IPropertyDescription, propvar: REFPROPVARIANT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSStringFromPropertyKey*(pkey: REFPROPERTYKEY, psz: LPWSTR, cch: UINT): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc PSUnregisterPropertySchema*(pszPath: PCWSTR): HRESULT {.winapi, stdcall, dynlib: "propsys", importc.}
proc VarUI4FromUI4*(ulIn: ULONG, pulOut: ptr ULONG): HRESULT {.winapi, inline.} = pulOut[] = ulIn
proc VarI4FromI4*(lIn: LONG, plOut: ptr LONG): HRESULT {.winapi, inline.} = plOut[] = lIn
proc VarUI8FromUI8*(ui64In: ULONG64, pi64Out: ptr ULONG64): HRESULT {.winapi, inline.} = pi64Out[] = ui64In
proc VarI8FromI8*(i64In: LONG64, pi64Out: ptr LONG64): HRESULT {.winapi, inline.} = pi64Out[] = i64In
proc `Lo=`*(self: var CY, x: int32) {.inline.} = self.struct1.Lo = x
proc Lo*(self: CY): int32 {.inline.} = self.struct1.Lo
proc Lo*(self: var CY): var int32 {.inline.} = self.struct1.Lo
proc `Hi=`*(self: var CY, x: int32) {.inline.} = self.struct1.Hi = x
proc Hi*(self: CY): int32 {.inline.} = self.struct1.Hi
proc Hi*(self: var CY): var int32 {.inline.} = self.struct1.Hi
proc `scale=`*(self: var DECIMAL, x: BYTE) {.inline.} = self.union1.struct1.scale = x
proc scale*(self: DECIMAL): BYTE {.inline.} = self.union1.struct1.scale
proc scale*(self: var DECIMAL): var BYTE {.inline.} = self.union1.struct1.scale
proc `sign=`*(self: var DECIMAL, x: BYTE) {.inline.} = self.union1.struct1.sign = x
proc sign*(self: DECIMAL): BYTE {.inline.} = self.union1.struct1.sign
proc sign*(self: var DECIMAL): var BYTE {.inline.} = self.union1.struct1.sign
proc `signscale=`*(self: var DECIMAL, x: USHORT) {.inline.} = self.union1.signscale = x
proc signscale*(self: DECIMAL): USHORT {.inline.} = self.union1.signscale
proc signscale*(self: var DECIMAL): var USHORT {.inline.} = self.union1.signscale
proc `Lo32=`*(self: var DECIMAL, x: ULONG) {.inline.} = self.union2.struct1.Lo32 = x
proc Lo32*(self: DECIMAL): ULONG {.inline.} = self.union2.struct1.Lo32
proc Lo32*(self: var DECIMAL): var ULONG {.inline.} = self.union2.struct1.Lo32
proc `Mid32=`*(self: var DECIMAL, x: ULONG) {.inline.} = self.union2.struct1.Mid32 = x
proc Mid32*(self: DECIMAL): ULONG {.inline.} = self.union2.struct1.Mid32
proc Mid32*(self: var DECIMAL): var ULONG {.inline.} = self.union2.struct1.Mid32
proc `Lo64=`*(self: var DECIMAL, x: ULONGLONG) {.inline.} = self.union2.Lo64 = x
proc Lo64*(self: DECIMAL): ULONGLONG {.inline.} = self.union2.Lo64
proc Lo64*(self: var DECIMAL): var ULONGLONG {.inline.} = self.union2.Lo64
proc `tymed=`*(self: var userSTGMEDIUM, x: DWORD) {.inline.} = self.struct1.tymed = x
proc tymed*(self: userSTGMEDIUM): DWORD {.inline.} = self.struct1.tymed
proc tymed*(self: var userSTGMEDIUM): var DWORD {.inline.} = self.struct1.tymed
proc `u=`*(self: var userSTGMEDIUM, x: userSTGMEDIUM_STRUCT1_u) {.inline.} = self.struct1.u = x
proc u*(self: userSTGMEDIUM): userSTGMEDIUM_STRUCT1_u {.inline.} = self.struct1.u
proc u*(self: var userSTGMEDIUM): var userSTGMEDIUM_STRUCT1_u {.inline.} = self.struct1.u
proc `vt=`*(self: var VARIANT, x: VARTYPE) {.inline.} = self.union1.struct1.vt = x
proc vt*(self: VARIANT): VARTYPE {.inline.} = self.union1.struct1.vt
proc vt*(self: var VARIANT): var VARTYPE {.inline.} = self.union1.struct1.vt
proc `wReserved1=`*(self: var VARIANT, x: WORD) {.inline.} = self.union1.struct1.wReserved1 = x
proc wReserved1*(self: VARIANT): WORD {.inline.} = self.union1.struct1.wReserved1
proc wReserved1*(self: var VARIANT): var WORD {.inline.} = self.union1.struct1.wReserved1
proc `wReserved2=`*(self: var VARIANT, x: WORD) {.inline.} = self.union1.struct1.wReserved2 = x
proc wReserved2*(self: VARIANT): WORD {.inline.} = self.union1.struct1.wReserved2
proc wReserved2*(self: var VARIANT): var WORD {.inline.} = self.union1.struct1.wReserved2
proc `wReserved3=`*(self: var VARIANT, x: WORD) {.inline.} = self.union1.struct1.wReserved3 = x
proc wReserved3*(self: VARIANT): WORD {.inline.} = self.union1.struct1.wReserved3
proc wReserved3*(self: var VARIANT): var WORD {.inline.} = self.union1.struct1.wReserved3
proc `llVal=`*(self: var VARIANT, x: LONGLONG) {.inline.} = self.union1.struct1.union1.llVal = x
proc llVal*(self: VARIANT): LONGLONG {.inline.} = self.union1.struct1.union1.llVal
proc llVal*(self: var VARIANT): var LONGLONG {.inline.} = self.union1.struct1.union1.llVal
proc `lVal=`*(self: var VARIANT, x: LONG) {.inline.} = self.union1.struct1.union1.lVal = x
proc lVal*(self: VARIANT): LONG {.inline.} = self.union1.struct1.union1.lVal
proc lVal*(self: var VARIANT): var LONG {.inline.} = self.union1.struct1.union1.lVal
proc `bVal=`*(self: var VARIANT, x: BYTE) {.inline.} = self.union1.struct1.union1.bVal = x
proc bVal*(self: VARIANT): BYTE {.inline.} = self.union1.struct1.union1.bVal
proc bVal*(self: var VARIANT): var BYTE {.inline.} = self.union1.struct1.union1.bVal
proc `iVal=`*(self: var VARIANT, x: SHORT) {.inline.} = self.union1.struct1.union1.iVal = x
proc iVal*(self: VARIANT): SHORT {.inline.} = self.union1.struct1.union1.iVal
proc iVal*(self: var VARIANT): var SHORT {.inline.} = self.union1.struct1.union1.iVal
proc `fltVal=`*(self: var VARIANT, x: FLOAT) {.inline.} = self.union1.struct1.union1.fltVal = x
proc fltVal*(self: VARIANT): FLOAT {.inline.} = self.union1.struct1.union1.fltVal
proc fltVal*(self: var VARIANT): var FLOAT {.inline.} = self.union1.struct1.union1.fltVal
proc `dblVal=`*(self: var VARIANT, x: DOUBLE) {.inline.} = self.union1.struct1.union1.dblVal = x
proc dblVal*(self: VARIANT): DOUBLE {.inline.} = self.union1.struct1.union1.dblVal
proc dblVal*(self: var VARIANT): var DOUBLE {.inline.} = self.union1.struct1.union1.dblVal
proc `boolVal=`*(self: var VARIANT, x: VARIANT_BOOL) {.inline.} = self.union1.struct1.union1.boolVal = x
proc boolVal*(self: VARIANT): VARIANT_BOOL {.inline.} = self.union1.struct1.union1.boolVal
proc boolVal*(self: var VARIANT): var VARIANT_BOOL {.inline.} = self.union1.struct1.union1.boolVal
proc `scode=`*(self: var VARIANT, x: SCODE) {.inline.} = self.union1.struct1.union1.scode = x
proc scode*(self: VARIANT): SCODE {.inline.} = self.union1.struct1.union1.scode
proc scode*(self: var VARIANT): var SCODE {.inline.} = self.union1.struct1.union1.scode
proc `cyVal=`*(self: var VARIANT, x: CY) {.inline.} = self.union1.struct1.union1.cyVal = x
proc cyVal*(self: VARIANT): CY {.inline.} = self.union1.struct1.union1.cyVal
proc cyVal*(self: var VARIANT): var CY {.inline.} = self.union1.struct1.union1.cyVal
proc `date=`*(self: var VARIANT, x: DATE) {.inline.} = self.union1.struct1.union1.date = x
proc date*(self: VARIANT): DATE {.inline.} = self.union1.struct1.union1.date
proc date*(self: var VARIANT): var DATE {.inline.} = self.union1.struct1.union1.date
proc `bstrVal=`*(self: var VARIANT, x: BSTR) {.inline.} = self.union1.struct1.union1.bstrVal = x
proc bstrVal*(self: VARIANT): BSTR {.inline.} = self.union1.struct1.union1.bstrVal
proc bstrVal*(self: var VARIANT): var BSTR {.inline.} = self.union1.struct1.union1.bstrVal
proc `punkVal=`*(self: var VARIANT, x: ptr IUnknown) {.inline.} = self.union1.struct1.union1.punkVal = x
proc punkVal*(self: VARIANT): ptr IUnknown {.inline.} = self.union1.struct1.union1.punkVal
proc punkVal*(self: var VARIANT): var ptr IUnknown {.inline.} = self.union1.struct1.union1.punkVal
proc `pdispVal=`*(self: var VARIANT, x: ptr IDispatch) {.inline.} = self.union1.struct1.union1.pdispVal = x
proc pdispVal*(self: VARIANT): ptr IDispatch {.inline.} = self.union1.struct1.union1.pdispVal
proc pdispVal*(self: var VARIANT): var ptr IDispatch {.inline.} = self.union1.struct1.union1.pdispVal
proc `parray=`*(self: var VARIANT, x: ptr SAFEARRAY) {.inline.} = self.union1.struct1.union1.parray = x
proc parray*(self: VARIANT): ptr SAFEARRAY {.inline.} = self.union1.struct1.union1.parray
proc parray*(self: var VARIANT): var ptr SAFEARRAY {.inline.} = self.union1.struct1.union1.parray
proc `pbVal=`*(self: var VARIANT, x: ptr BYTE) {.inline.} = self.union1.struct1.union1.pbVal = x
proc pbVal*(self: VARIANT): ptr BYTE {.inline.} = self.union1.struct1.union1.pbVal
proc pbVal*(self: var VARIANT): var ptr BYTE {.inline.} = self.union1.struct1.union1.pbVal
proc `piVal=`*(self: var VARIANT, x: ptr SHORT) {.inline.} = self.union1.struct1.union1.piVal = x
proc piVal*(self: VARIANT): ptr SHORT {.inline.} = self.union1.struct1.union1.piVal
proc piVal*(self: var VARIANT): var ptr SHORT {.inline.} = self.union1.struct1.union1.piVal
proc `plVal=`*(self: var VARIANT, x: ptr LONG) {.inline.} = self.union1.struct1.union1.plVal = x
proc plVal*(self: VARIANT): ptr LONG {.inline.} = self.union1.struct1.union1.plVal
proc plVal*(self: var VARIANT): var ptr LONG {.inline.} = self.union1.struct1.union1.plVal
proc `pllVal=`*(self: var VARIANT, x: ptr LONGLONG) {.inline.} = self.union1.struct1.union1.pllVal = x
proc pllVal*(self: VARIANT): ptr LONGLONG {.inline.} = self.union1.struct1.union1.pllVal
proc pllVal*(self: var VARIANT): var ptr LONGLONG {.inline.} = self.union1.struct1.union1.pllVal
proc `pfltVal=`*(self: var VARIANT, x: ptr FLOAT) {.inline.} = self.union1.struct1.union1.pfltVal = x
proc pfltVal*(self: VARIANT): ptr FLOAT {.inline.} = self.union1.struct1.union1.pfltVal
proc pfltVal*(self: var VARIANT): var ptr FLOAT {.inline.} = self.union1.struct1.union1.pfltVal
proc `pdblVal=`*(self: var VARIANT, x: ptr DOUBLE) {.inline.} = self.union1.struct1.union1.pdblVal = x
proc pdblVal*(self: VARIANT): ptr DOUBLE {.inline.} = self.union1.struct1.union1.pdblVal
proc pdblVal*(self: var VARIANT): var ptr DOUBLE {.inline.} = self.union1.struct1.union1.pdblVal
proc `pboolVal=`*(self: var VARIANT, x: ptr VARIANT_BOOL) {.inline.} = self.union1.struct1.union1.pboolVal = x
proc pboolVal*(self: VARIANT): ptr VARIANT_BOOL {.inline.} = self.union1.struct1.union1.pboolVal
proc pboolVal*(self: var VARIANT): var ptr VARIANT_BOOL {.inline.} = self.union1.struct1.union1.pboolVal
proc `pscode=`*(self: var VARIANT, x: ptr SCODE) {.inline.} = self.union1.struct1.union1.pscode = x
proc pscode*(self: VARIANT): ptr SCODE {.inline.} = self.union1.struct1.union1.pscode
proc pscode*(self: var VARIANT): var ptr SCODE {.inline.} = self.union1.struct1.union1.pscode
proc `pcyVal=`*(self: var VARIANT, x: ptr CY) {.inline.} = self.union1.struct1.union1.pcyVal = x
proc pcyVal*(self: VARIANT): ptr CY {.inline.} = self.union1.struct1.union1.pcyVal
proc pcyVal*(self: var VARIANT): var ptr CY {.inline.} = self.union1.struct1.union1.pcyVal
proc `pdate=`*(self: var VARIANT, x: ptr DATE) {.inline.} = self.union1.struct1.union1.pdate = x
proc pdate*(self: VARIANT): ptr DATE {.inline.} = self.union1.struct1.union1.pdate
proc pdate*(self: var VARIANT): var ptr DATE {.inline.} = self.union1.struct1.union1.pdate
proc `pbstrVal=`*(self: var VARIANT, x: ptr BSTR) {.inline.} = self.union1.struct1.union1.pbstrVal = x
proc pbstrVal*(self: VARIANT): ptr BSTR {.inline.} = self.union1.struct1.union1.pbstrVal
proc pbstrVal*(self: var VARIANT): var ptr BSTR {.inline.} = self.union1.struct1.union1.pbstrVal
proc `ppunkVal=`*(self: var VARIANT, x: ptr ptr IUnknown) {.inline.} = self.union1.struct1.union1.ppunkVal = x
proc ppunkVal*(self: VARIANT): ptr ptr IUnknown {.inline.} = self.union1.struct1.union1.ppunkVal
proc ppunkVal*(self: var VARIANT): var ptr ptr IUnknown {.inline.} = self.union1.struct1.union1.ppunkVal
proc `ppdispVal=`*(self: var VARIANT, x: ptr ptr IDispatch) {.inline.} = self.union1.struct1.union1.ppdispVal = x
proc ppdispVal*(self: VARIANT): ptr ptr IDispatch {.inline.} = self.union1.struct1.union1.ppdispVal
proc ppdispVal*(self: var VARIANT): var ptr ptr IDispatch {.inline.} = self.union1.struct1.union1.ppdispVal
proc `pparray=`*(self: var VARIANT, x: ptr ptr SAFEARRAY) {.inline.} = self.union1.struct1.union1.pparray = x
proc pparray*(self: VARIANT): ptr ptr SAFEARRAY {.inline.} = self.union1.struct1.union1.pparray
proc pparray*(self: var VARIANT): var ptr ptr SAFEARRAY {.inline.} = self.union1.struct1.union1.pparray
proc `pvarVal=`*(self: var VARIANT, x: ptr VARIANT) {.inline.} = self.union1.struct1.union1.pvarVal = x
proc pvarVal*(self: VARIANT): ptr VARIANT {.inline.} = self.union1.struct1.union1.pvarVal
proc pvarVal*(self: var VARIANT): var ptr VARIANT {.inline.} = self.union1.struct1.union1.pvarVal
proc `byref=`*(self: var VARIANT, x: PVOID) {.inline.} = self.union1.struct1.union1.byref = x
proc byref*(self: VARIANT): PVOID {.inline.} = self.union1.struct1.union1.byref
proc byref*(self: var VARIANT): var PVOID {.inline.} = self.union1.struct1.union1.byref
proc `cVal=`*(self: var VARIANT, x: CHAR) {.inline.} = self.union1.struct1.union1.cVal = x
proc cVal*(self: VARIANT): CHAR {.inline.} = self.union1.struct1.union1.cVal
proc cVal*(self: var VARIANT): var CHAR {.inline.} = self.union1.struct1.union1.cVal
proc `uiVal=`*(self: var VARIANT, x: USHORT) {.inline.} = self.union1.struct1.union1.uiVal = x
proc uiVal*(self: VARIANT): USHORT {.inline.} = self.union1.struct1.union1.uiVal
proc uiVal*(self: var VARIANT): var USHORT {.inline.} = self.union1.struct1.union1.uiVal
proc `ulVal=`*(self: var VARIANT, x: ULONG) {.inline.} = self.union1.struct1.union1.ulVal = x
proc ulVal*(self: VARIANT): ULONG {.inline.} = self.union1.struct1.union1.ulVal
proc ulVal*(self: var VARIANT): var ULONG {.inline.} = self.union1.struct1.union1.ulVal
proc `ullVal=`*(self: var VARIANT, x: ULONGLONG) {.inline.} = self.union1.struct1.union1.ullVal = x
proc ullVal*(self: VARIANT): ULONGLONG {.inline.} = self.union1.struct1.union1.ullVal
proc ullVal*(self: var VARIANT): var ULONGLONG {.inline.} = self.union1.struct1.union1.ullVal
proc `intVal=`*(self: var VARIANT, x: INT) {.inline.} = self.union1.struct1.union1.intVal = x
proc intVal*(self: VARIANT): INT {.inline.} = self.union1.struct1.union1.intVal
proc intVal*(self: var VARIANT): var INT {.inline.} = self.union1.struct1.union1.intVal
proc `uintVal=`*(self: var VARIANT, x: UINT) {.inline.} = self.union1.struct1.union1.uintVal = x
proc uintVal*(self: VARIANT): UINT {.inline.} = self.union1.struct1.union1.uintVal
proc uintVal*(self: var VARIANT): var UINT {.inline.} = self.union1.struct1.union1.uintVal
proc `pdecVal=`*(self: var VARIANT, x: ptr DECIMAL) {.inline.} = self.union1.struct1.union1.pdecVal = x
proc pdecVal*(self: VARIANT): ptr DECIMAL {.inline.} = self.union1.struct1.union1.pdecVal
proc pdecVal*(self: var VARIANT): var ptr DECIMAL {.inline.} = self.union1.struct1.union1.pdecVal
proc `pcVal=`*(self: var VARIANT, x: ptr CHAR) {.inline.} = self.union1.struct1.union1.pcVal = x
proc pcVal*(self: VARIANT): ptr CHAR {.inline.} = self.union1.struct1.union1.pcVal
proc pcVal*(self: var VARIANT): var ptr CHAR {.inline.} = self.union1.struct1.union1.pcVal
proc `puiVal=`*(self: var VARIANT, x: ptr USHORT) {.inline.} = self.union1.struct1.union1.puiVal = x
proc puiVal*(self: VARIANT): ptr USHORT {.inline.} = self.union1.struct1.union1.puiVal
proc puiVal*(self: var VARIANT): var ptr USHORT {.inline.} = self.union1.struct1.union1.puiVal
proc `pulVal=`*(self: var VARIANT, x: ptr ULONG) {.inline.} = self.union1.struct1.union1.pulVal = x
proc pulVal*(self: VARIANT): ptr ULONG {.inline.} = self.union1.struct1.union1.pulVal
proc pulVal*(self: var VARIANT): var ptr ULONG {.inline.} = self.union1.struct1.union1.pulVal
proc `pullVal=`*(self: var VARIANT, x: ptr ULONGLONG) {.inline.} = self.union1.struct1.union1.pullVal = x
proc pullVal*(self: VARIANT): ptr ULONGLONG {.inline.} = self.union1.struct1.union1.pullVal
proc pullVal*(self: var VARIANT): var ptr ULONGLONG {.inline.} = self.union1.struct1.union1.pullVal
proc `pintVal=`*(self: var VARIANT, x: ptr INT) {.inline.} = self.union1.struct1.union1.pintVal = x
proc pintVal*(self: VARIANT): ptr INT {.inline.} = self.union1.struct1.union1.pintVal
proc pintVal*(self: var VARIANT): var ptr INT {.inline.} = self.union1.struct1.union1.pintVal
proc `puintVal=`*(self: var VARIANT, x: ptr UINT) {.inline.} = self.union1.struct1.union1.puintVal = x
proc puintVal*(self: VARIANT): ptr UINT {.inline.} = self.union1.struct1.union1.puintVal
proc puintVal*(self: var VARIANT): var ptr UINT {.inline.} = self.union1.struct1.union1.puintVal
proc `pvRecord=`*(self: var VARIANT, x: PVOID) {.inline.} = self.union1.struct1.union1.struct1.pvRecord = x
proc pvRecord*(self: VARIANT): PVOID {.inline.} = self.union1.struct1.union1.struct1.pvRecord
proc pvRecord*(self: var VARIANT): var PVOID {.inline.} = self.union1.struct1.union1.struct1.pvRecord
proc `pRecInfo=`*(self: var VARIANT, x: ptr IRecordInfo) {.inline.} = self.union1.struct1.union1.struct1.pRecInfo = x
proc pRecInfo*(self: VARIANT): ptr IRecordInfo {.inline.} = self.union1.struct1.union1.struct1.pRecInfo
proc pRecInfo*(self: var VARIANT): var ptr IRecordInfo {.inline.} = self.union1.struct1.union1.struct1.pRecInfo
proc `decVal=`*(self: var VARIANT, x: DECIMAL) {.inline.} = self.union1.decVal = x
proc decVal*(self: VARIANT): DECIMAL {.inline.} = self.union1.decVal
proc decVal*(self: var VARIANT): var DECIMAL {.inline.} = self.union1.decVal
proc `llVal=`*(self: var wireVARIANT, x: LONGLONG) {.inline.} = self.union1.llVal = x
proc llVal*(self: wireVARIANT): LONGLONG {.inline.} = self.union1.llVal
proc llVal*(self: var wireVARIANT): var LONGLONG {.inline.} = self.union1.llVal
proc `lVal=`*(self: var wireVARIANT, x: LONG) {.inline.} = self.union1.lVal = x
proc lVal*(self: wireVARIANT): LONG {.inline.} = self.union1.lVal
proc lVal*(self: var wireVARIANT): var LONG {.inline.} = self.union1.lVal
proc `bVal=`*(self: var wireVARIANT, x: BYTE) {.inline.} = self.union1.bVal = x
proc bVal*(self: wireVARIANT): BYTE {.inline.} = self.union1.bVal
proc bVal*(self: var wireVARIANT): var BYTE {.inline.} = self.union1.bVal
proc `iVal=`*(self: var wireVARIANT, x: SHORT) {.inline.} = self.union1.iVal = x
proc iVal*(self: wireVARIANT): SHORT {.inline.} = self.union1.iVal
proc iVal*(self: var wireVARIANT): var SHORT {.inline.} = self.union1.iVal
proc `fltVal=`*(self: var wireVARIANT, x: FLOAT) {.inline.} = self.union1.fltVal = x
proc fltVal*(self: wireVARIANT): FLOAT {.inline.} = self.union1.fltVal
proc fltVal*(self: var wireVARIANT): var FLOAT {.inline.} = self.union1.fltVal
proc `dblVal=`*(self: var wireVARIANT, x: DOUBLE) {.inline.} = self.union1.dblVal = x
proc dblVal*(self: wireVARIANT): DOUBLE {.inline.} = self.union1.dblVal
proc dblVal*(self: var wireVARIANT): var DOUBLE {.inline.} = self.union1.dblVal
proc `boolVal=`*(self: var wireVARIANT, x: VARIANT_BOOL) {.inline.} = self.union1.boolVal = x
proc boolVal*(self: wireVARIANT): VARIANT_BOOL {.inline.} = self.union1.boolVal
proc boolVal*(self: var wireVARIANT): var VARIANT_BOOL {.inline.} = self.union1.boolVal
proc `scode=`*(self: var wireVARIANT, x: SCODE) {.inline.} = self.union1.scode = x
proc scode*(self: wireVARIANT): SCODE {.inline.} = self.union1.scode
proc scode*(self: var wireVARIANT): var SCODE {.inline.} = self.union1.scode
proc `cyVal=`*(self: var wireVARIANT, x: CY) {.inline.} = self.union1.cyVal = x
proc cyVal*(self: wireVARIANT): CY {.inline.} = self.union1.cyVal
proc cyVal*(self: var wireVARIANT): var CY {.inline.} = self.union1.cyVal
proc `date=`*(self: var wireVARIANT, x: DATE) {.inline.} = self.union1.date = x
proc date*(self: wireVARIANT): DATE {.inline.} = self.union1.date
proc date*(self: var wireVARIANT): var DATE {.inline.} = self.union1.date
proc `bstrVal=`*(self: var wireVARIANT, x: wireBSTR) {.inline.} = self.union1.bstrVal = x
proc bstrVal*(self: wireVARIANT): wireBSTR {.inline.} = self.union1.bstrVal
proc bstrVal*(self: var wireVARIANT): var wireBSTR {.inline.} = self.union1.bstrVal
proc `punkVal=`*(self: var wireVARIANT, x: ptr IUnknown) {.inline.} = self.union1.punkVal = x
proc punkVal*(self: wireVARIANT): ptr IUnknown {.inline.} = self.union1.punkVal
proc punkVal*(self: var wireVARIANT): var ptr IUnknown {.inline.} = self.union1.punkVal
proc `pdispVal=`*(self: var wireVARIANT, x: ptr IDispatch) {.inline.} = self.union1.pdispVal = x
proc pdispVal*(self: wireVARIANT): ptr IDispatch {.inline.} = self.union1.pdispVal
proc pdispVal*(self: var wireVARIANT): var ptr IDispatch {.inline.} = self.union1.pdispVal
proc `parray=`*(self: var wireVARIANT, x: wirePSAFEARRAY) {.inline.} = self.union1.parray = x
proc parray*(self: wireVARIANT): wirePSAFEARRAY {.inline.} = self.union1.parray
proc parray*(self: var wireVARIANT): var wirePSAFEARRAY {.inline.} = self.union1.parray
proc `brecVal=`*(self: var wireVARIANT, x: wireBRECORD) {.inline.} = self.union1.brecVal = x
proc brecVal*(self: wireVARIANT): wireBRECORD {.inline.} = self.union1.brecVal
proc brecVal*(self: var wireVARIANT): var wireBRECORD {.inline.} = self.union1.brecVal
proc `pbVal=`*(self: var wireVARIANT, x: ptr BYTE) {.inline.} = self.union1.pbVal = x
proc pbVal*(self: wireVARIANT): ptr BYTE {.inline.} = self.union1.pbVal
proc pbVal*(self: var wireVARIANT): var ptr BYTE {.inline.} = self.union1.pbVal
proc `piVal=`*(self: var wireVARIANT, x: ptr SHORT) {.inline.} = self.union1.piVal = x
proc piVal*(self: wireVARIANT): ptr SHORT {.inline.} = self.union1.piVal
proc piVal*(self: var wireVARIANT): var ptr SHORT {.inline.} = self.union1.piVal
proc `plVal=`*(self: var wireVARIANT, x: ptr LONG) {.inline.} = self.union1.plVal = x
proc plVal*(self: wireVARIANT): ptr LONG {.inline.} = self.union1.plVal
proc plVal*(self: var wireVARIANT): var ptr LONG {.inline.} = self.union1.plVal
proc `pllVal=`*(self: var wireVARIANT, x: ptr LONGLONG) {.inline.} = self.union1.pllVal = x
proc pllVal*(self: wireVARIANT): ptr LONGLONG {.inline.} = self.union1.pllVal
proc pllVal*(self: var wireVARIANT): var ptr LONGLONG {.inline.} = self.union1.pllVal
proc `pfltVal=`*(self: var wireVARIANT, x: ptr FLOAT) {.inline.} = self.union1.pfltVal = x
proc pfltVal*(self: wireVARIANT): ptr FLOAT {.inline.} = self.union1.pfltVal
proc pfltVal*(self: var wireVARIANT): var ptr FLOAT {.inline.} = self.union1.pfltVal
proc `pdblVal=`*(self: var wireVARIANT, x: ptr DOUBLE) {.inline.} = self.union1.pdblVal = x
proc pdblVal*(self: wireVARIANT): ptr DOUBLE {.inline.} = self.union1.pdblVal
proc pdblVal*(self: var wireVARIANT): var ptr DOUBLE {.inline.} = self.union1.pdblVal
proc `pboolVal=`*(self: var wireVARIANT, x: ptr VARIANT_BOOL) {.inline.} = self.union1.pboolVal = x
proc pboolVal*(self: wireVARIANT): ptr VARIANT_BOOL {.inline.} = self.union1.pboolVal
proc pboolVal*(self: var wireVARIANT): var ptr VARIANT_BOOL {.inline.} = self.union1.pboolVal
proc `pscode=`*(self: var wireVARIANT, x: ptr SCODE) {.inline.} = self.union1.pscode = x
proc pscode*(self: wireVARIANT): ptr SCODE {.inline.} = self.union1.pscode
proc pscode*(self: var wireVARIANT): var ptr SCODE {.inline.} = self.union1.pscode
proc `pcyVal=`*(self: var wireVARIANT, x: ptr CY) {.inline.} = self.union1.pcyVal = x
proc pcyVal*(self: wireVARIANT): ptr CY {.inline.} = self.union1.pcyVal
proc pcyVal*(self: var wireVARIANT): var ptr CY {.inline.} = self.union1.pcyVal
proc `pdate=`*(self: var wireVARIANT, x: ptr DATE) {.inline.} = self.union1.pdate = x
proc pdate*(self: wireVARIANT): ptr DATE {.inline.} = self.union1.pdate
proc pdate*(self: var wireVARIANT): var ptr DATE {.inline.} = self.union1.pdate
proc `pbstrVal=`*(self: var wireVARIANT, x: ptr wireBSTR) {.inline.} = self.union1.pbstrVal = x
proc pbstrVal*(self: wireVARIANT): ptr wireBSTR {.inline.} = self.union1.pbstrVal
proc pbstrVal*(self: var wireVARIANT): var ptr wireBSTR {.inline.} = self.union1.pbstrVal
proc `ppunkVal=`*(self: var wireVARIANT, x: ptr ptr IUnknown) {.inline.} = self.union1.ppunkVal = x
proc ppunkVal*(self: wireVARIANT): ptr ptr IUnknown {.inline.} = self.union1.ppunkVal
proc ppunkVal*(self: var wireVARIANT): var ptr ptr IUnknown {.inline.} = self.union1.ppunkVal
proc `ppdispVal=`*(self: var wireVARIANT, x: ptr ptr IDispatch) {.inline.} = self.union1.ppdispVal = x
proc ppdispVal*(self: wireVARIANT): ptr ptr IDispatch {.inline.} = self.union1.ppdispVal
proc ppdispVal*(self: var wireVARIANT): var ptr ptr IDispatch {.inline.} = self.union1.ppdispVal
proc `pparray=`*(self: var wireVARIANT, x: ptr wirePSAFEARRAY) {.inline.} = self.union1.pparray = x
proc pparray*(self: wireVARIANT): ptr wirePSAFEARRAY {.inline.} = self.union1.pparray
proc pparray*(self: var wireVARIANT): var ptr wirePSAFEARRAY {.inline.} = self.union1.pparray
proc `pvarVal=`*(self: var wireVARIANT, x: ptr wireVARIANT) {.inline.} = self.union1.pvarVal = x
proc pvarVal*(self: wireVARIANT): ptr wireVARIANT {.inline.} = self.union1.pvarVal
proc pvarVal*(self: var wireVARIANT): var ptr wireVARIANT {.inline.} = self.union1.pvarVal
proc `cVal=`*(self: var wireVARIANT, x: CHAR) {.inline.} = self.union1.cVal = x
proc cVal*(self: wireVARIANT): CHAR {.inline.} = self.union1.cVal
proc cVal*(self: var wireVARIANT): var CHAR {.inline.} = self.union1.cVal
proc `uiVal=`*(self: var wireVARIANT, x: USHORT) {.inline.} = self.union1.uiVal = x
proc uiVal*(self: wireVARIANT): USHORT {.inline.} = self.union1.uiVal
proc uiVal*(self: var wireVARIANT): var USHORT {.inline.} = self.union1.uiVal
proc `ulVal=`*(self: var wireVARIANT, x: ULONG) {.inline.} = self.union1.ulVal = x
proc ulVal*(self: wireVARIANT): ULONG {.inline.} = self.union1.ulVal
proc ulVal*(self: var wireVARIANT): var ULONG {.inline.} = self.union1.ulVal
proc `ullVal=`*(self: var wireVARIANT, x: ULONGLONG) {.inline.} = self.union1.ullVal = x
proc ullVal*(self: wireVARIANT): ULONGLONG {.inline.} = self.union1.ullVal
proc ullVal*(self: var wireVARIANT): var ULONGLONG {.inline.} = self.union1.ullVal
proc `intVal=`*(self: var wireVARIANT, x: INT) {.inline.} = self.union1.intVal = x
proc intVal*(self: wireVARIANT): INT {.inline.} = self.union1.intVal
proc intVal*(self: var wireVARIANT): var INT {.inline.} = self.union1.intVal
proc `uintVal=`*(self: var wireVARIANT, x: UINT) {.inline.} = self.union1.uintVal = x
proc uintVal*(self: wireVARIANT): UINT {.inline.} = self.union1.uintVal
proc uintVal*(self: var wireVARIANT): var UINT {.inline.} = self.union1.uintVal
proc `decVal=`*(self: var wireVARIANT, x: DECIMAL) {.inline.} = self.union1.decVal = x
proc decVal*(self: wireVARIANT): DECIMAL {.inline.} = self.union1.decVal
proc decVal*(self: var wireVARIANT): var DECIMAL {.inline.} = self.union1.decVal
proc `pdecVal=`*(self: var wireVARIANT, x: ptr DECIMAL) {.inline.} = self.union1.pdecVal = x
proc pdecVal*(self: wireVARIANT): ptr DECIMAL {.inline.} = self.union1.pdecVal
proc pdecVal*(self: var wireVARIANT): var ptr DECIMAL {.inline.} = self.union1.pdecVal
proc `pcVal=`*(self: var wireVARIANT, x: ptr CHAR) {.inline.} = self.union1.pcVal = x
proc pcVal*(self: wireVARIANT): ptr CHAR {.inline.} = self.union1.pcVal
proc pcVal*(self: var wireVARIANT): var ptr CHAR {.inline.} = self.union1.pcVal
proc `puiVal=`*(self: var wireVARIANT, x: ptr USHORT) {.inline.} = self.union1.puiVal = x
proc puiVal*(self: wireVARIANT): ptr USHORT {.inline.} = self.union1.puiVal
proc puiVal*(self: var wireVARIANT): var ptr USHORT {.inline.} = self.union1.puiVal
proc `pulVal=`*(self: var wireVARIANT, x: ptr ULONG) {.inline.} = self.union1.pulVal = x
proc pulVal*(self: wireVARIANT): ptr ULONG {.inline.} = self.union1.pulVal
proc pulVal*(self: var wireVARIANT): var ptr ULONG {.inline.} = self.union1.pulVal
proc `pullVal=`*(self: var wireVARIANT, x: ptr ULONGLONG) {.inline.} = self.union1.pullVal = x
proc pullVal*(self: wireVARIANT): ptr ULONGLONG {.inline.} = self.union1.pullVal
proc pullVal*(self: var wireVARIANT): var ptr ULONGLONG {.inline.} = self.union1.pullVal
proc `pintVal=`*(self: var wireVARIANT, x: ptr INT) {.inline.} = self.union1.pintVal = x
proc pintVal*(self: wireVARIANT): ptr INT {.inline.} = self.union1.pintVal
proc pintVal*(self: var wireVARIANT): var ptr INT {.inline.} = self.union1.pintVal
proc `puintVal=`*(self: var wireVARIANT, x: ptr UINT) {.inline.} = self.union1.puintVal = x
proc puintVal*(self: wireVARIANT): ptr UINT {.inline.} = self.union1.puintVal
proc puintVal*(self: var wireVARIANT): var ptr UINT {.inline.} = self.union1.puintVal
proc `lptdesc=`*(self: var TYPEDESC, x: ptr TYPEDESC) {.inline.} = self.union1.lptdesc = x
proc lptdesc*(self: TYPEDESC): ptr TYPEDESC {.inline.} = self.union1.lptdesc
proc lptdesc*(self: var TYPEDESC): var ptr TYPEDESC {.inline.} = self.union1.lptdesc
proc `lpadesc=`*(self: var TYPEDESC, x: ptr ARRAYDESC) {.inline.} = self.union1.lpadesc = x
proc lpadesc*(self: TYPEDESC): ptr ARRAYDESC {.inline.} = self.union1.lpadesc
proc lpadesc*(self: var TYPEDESC): var ptr ARRAYDESC {.inline.} = self.union1.lpadesc
proc `hreftype=`*(self: var TYPEDESC, x: HREFTYPE) {.inline.} = self.union1.hreftype = x
proc hreftype*(self: TYPEDESC): HREFTYPE {.inline.} = self.union1.hreftype
proc hreftype*(self: var TYPEDESC): var HREFTYPE {.inline.} = self.union1.hreftype
proc `idldesc=`*(self: var ELEMDESC, x: IDLDESC) {.inline.} = self.union1.idldesc = x
proc idldesc*(self: ELEMDESC): IDLDESC {.inline.} = self.union1.idldesc
proc idldesc*(self: var ELEMDESC): var IDLDESC {.inline.} = self.union1.idldesc
proc `paramdesc=`*(self: var ELEMDESC, x: PARAMDESC) {.inline.} = self.union1.paramdesc = x
proc paramdesc*(self: ELEMDESC): PARAMDESC {.inline.} = self.union1.paramdesc
proc paramdesc*(self: var ELEMDESC): var PARAMDESC {.inline.} = self.union1.paramdesc
proc `oInst=`*(self: var VARDESC, x: ULONG) {.inline.} = self.union1.oInst = x
proc oInst*(self: VARDESC): ULONG {.inline.} = self.union1.oInst
proc oInst*(self: var VARDESC): var ULONG {.inline.} = self.union1.oInst
proc `lpvarValue=`*(self: var VARDESC, x: ptr VARIANT) {.inline.} = self.union1.lpvarValue = x
proc lpvarValue*(self: VARDESC): ptr VARIANT {.inline.} = self.union1.lpvarValue
proc lpvarValue*(self: var VARDESC): var ptr VARIANT {.inline.} = self.union1.lpvarValue
proc `vt=`*(self: var PROPVARIANT, x: VARTYPE) {.inline.} = self.union1.struct1.vt = x
proc vt*(self: PROPVARIANT): VARTYPE {.inline.} = self.union1.struct1.vt
proc vt*(self: var PROPVARIANT): var VARTYPE {.inline.} = self.union1.struct1.vt
proc `wReserved1=`*(self: var PROPVARIANT, x: PROPVAR_PAD1) {.inline.} = self.union1.struct1.wReserved1 = x
proc wReserved1*(self: PROPVARIANT): PROPVAR_PAD1 {.inline.} = self.union1.struct1.wReserved1
proc wReserved1*(self: var PROPVARIANT): var PROPVAR_PAD1 {.inline.} = self.union1.struct1.wReserved1
proc `wReserved2=`*(self: var PROPVARIANT, x: PROPVAR_PAD2) {.inline.} = self.union1.struct1.wReserved2 = x
proc wReserved2*(self: PROPVARIANT): PROPVAR_PAD2 {.inline.} = self.union1.struct1.wReserved2
proc wReserved2*(self: var PROPVARIANT): var PROPVAR_PAD2 {.inline.} = self.union1.struct1.wReserved2
proc `wReserved3=`*(self: var PROPVARIANT, x: PROPVAR_PAD3) {.inline.} = self.union1.struct1.wReserved3 = x
proc wReserved3*(self: PROPVARIANT): PROPVAR_PAD3 {.inline.} = self.union1.struct1.wReserved3
proc wReserved3*(self: var PROPVARIANT): var PROPVAR_PAD3 {.inline.} = self.union1.struct1.wReserved3
proc `cVal=`*(self: var PROPVARIANT, x: CHAR) {.inline.} = self.union1.struct1.union1.cVal = x
proc cVal*(self: PROPVARIANT): CHAR {.inline.} = self.union1.struct1.union1.cVal
proc cVal*(self: var PROPVARIANT): var CHAR {.inline.} = self.union1.struct1.union1.cVal
proc `bVal=`*(self: var PROPVARIANT, x: UCHAR) {.inline.} = self.union1.struct1.union1.bVal = x
proc bVal*(self: PROPVARIANT): UCHAR {.inline.} = self.union1.struct1.union1.bVal
proc bVal*(self: var PROPVARIANT): var UCHAR {.inline.} = self.union1.struct1.union1.bVal
proc `iVal=`*(self: var PROPVARIANT, x: SHORT) {.inline.} = self.union1.struct1.union1.iVal = x
proc iVal*(self: PROPVARIANT): SHORT {.inline.} = self.union1.struct1.union1.iVal
proc iVal*(self: var PROPVARIANT): var SHORT {.inline.} = self.union1.struct1.union1.iVal
proc `uiVal=`*(self: var PROPVARIANT, x: USHORT) {.inline.} = self.union1.struct1.union1.uiVal = x
proc uiVal*(self: PROPVARIANT): USHORT {.inline.} = self.union1.struct1.union1.uiVal
proc uiVal*(self: var PROPVARIANT): var USHORT {.inline.} = self.union1.struct1.union1.uiVal
proc `lVal=`*(self: var PROPVARIANT, x: LONG) {.inline.} = self.union1.struct1.union1.lVal = x
proc lVal*(self: PROPVARIANT): LONG {.inline.} = self.union1.struct1.union1.lVal
proc lVal*(self: var PROPVARIANT): var LONG {.inline.} = self.union1.struct1.union1.lVal
proc `ulVal=`*(self: var PROPVARIANT, x: ULONG) {.inline.} = self.union1.struct1.union1.ulVal = x
proc ulVal*(self: PROPVARIANT): ULONG {.inline.} = self.union1.struct1.union1.ulVal
proc ulVal*(self: var PROPVARIANT): var ULONG {.inline.} = self.union1.struct1.union1.ulVal
proc `intVal=`*(self: var PROPVARIANT, x: INT) {.inline.} = self.union1.struct1.union1.intVal = x
proc intVal*(self: PROPVARIANT): INT {.inline.} = self.union1.struct1.union1.intVal
proc intVal*(self: var PROPVARIANT): var INT {.inline.} = self.union1.struct1.union1.intVal
proc `uintVal=`*(self: var PROPVARIANT, x: UINT) {.inline.} = self.union1.struct1.union1.uintVal = x
proc uintVal*(self: PROPVARIANT): UINT {.inline.} = self.union1.struct1.union1.uintVal
proc uintVal*(self: var PROPVARIANT): var UINT {.inline.} = self.union1.struct1.union1.uintVal
proc `hVal=`*(self: var PROPVARIANT, x: LARGE_INTEGER) {.inline.} = self.union1.struct1.union1.hVal = x
proc hVal*(self: PROPVARIANT): LARGE_INTEGER {.inline.} = self.union1.struct1.union1.hVal
proc hVal*(self: var PROPVARIANT): var LARGE_INTEGER {.inline.} = self.union1.struct1.union1.hVal
proc `uhVal=`*(self: var PROPVARIANT, x: ULARGE_INTEGER) {.inline.} = self.union1.struct1.union1.uhVal = x
proc uhVal*(self: PROPVARIANT): ULARGE_INTEGER {.inline.} = self.union1.struct1.union1.uhVal
proc uhVal*(self: var PROPVARIANT): var ULARGE_INTEGER {.inline.} = self.union1.struct1.union1.uhVal
proc `fltVal=`*(self: var PROPVARIANT, x: FLOAT) {.inline.} = self.union1.struct1.union1.fltVal = x
proc fltVal*(self: PROPVARIANT): FLOAT {.inline.} = self.union1.struct1.union1.fltVal
proc fltVal*(self: var PROPVARIANT): var FLOAT {.inline.} = self.union1.struct1.union1.fltVal
proc `dblVal=`*(self: var PROPVARIANT, x: DOUBLE) {.inline.} = self.union1.struct1.union1.dblVal = x
proc dblVal*(self: PROPVARIANT): DOUBLE {.inline.} = self.union1.struct1.union1.dblVal
proc dblVal*(self: var PROPVARIANT): var DOUBLE {.inline.} = self.union1.struct1.union1.dblVal
proc `boolVal=`*(self: var PROPVARIANT, x: VARIANT_BOOL) {.inline.} = self.union1.struct1.union1.boolVal = x
proc boolVal*(self: PROPVARIANT): VARIANT_BOOL {.inline.} = self.union1.struct1.union1.boolVal
proc boolVal*(self: var PROPVARIANT): var VARIANT_BOOL {.inline.} = self.union1.struct1.union1.boolVal
proc `scode=`*(self: var PROPVARIANT, x: SCODE) {.inline.} = self.union1.struct1.union1.scode = x
proc scode*(self: PROPVARIANT): SCODE {.inline.} = self.union1.struct1.union1.scode
proc scode*(self: var PROPVARIANT): var SCODE {.inline.} = self.union1.struct1.union1.scode
proc `cyVal=`*(self: var PROPVARIANT, x: CY) {.inline.} = self.union1.struct1.union1.cyVal = x
proc cyVal*(self: PROPVARIANT): CY {.inline.} = self.union1.struct1.union1.cyVal
proc cyVal*(self: var PROPVARIANT): var CY {.inline.} = self.union1.struct1.union1.cyVal
proc `date=`*(self: var PROPVARIANT, x: DATE) {.inline.} = self.union1.struct1.union1.date = x
proc date*(self: PROPVARIANT): DATE {.inline.} = self.union1.struct1.union1.date
proc date*(self: var PROPVARIANT): var DATE {.inline.} = self.union1.struct1.union1.date
proc `filetime=`*(self: var PROPVARIANT, x: FILETIME) {.inline.} = self.union1.struct1.union1.filetime = x
proc filetime*(self: PROPVARIANT): FILETIME {.inline.} = self.union1.struct1.union1.filetime
proc filetime*(self: var PROPVARIANT): var FILETIME {.inline.} = self.union1.struct1.union1.filetime
proc `puuid=`*(self: var PROPVARIANT, x: ptr CLSID) {.inline.} = self.union1.struct1.union1.puuid = x
proc puuid*(self: PROPVARIANT): ptr CLSID {.inline.} = self.union1.struct1.union1.puuid
proc puuid*(self: var PROPVARIANT): var ptr CLSID {.inline.} = self.union1.struct1.union1.puuid
proc `pclipdata=`*(self: var PROPVARIANT, x: ptr CLIPDATA) {.inline.} = self.union1.struct1.union1.pclipdata = x
proc pclipdata*(self: PROPVARIANT): ptr CLIPDATA {.inline.} = self.union1.struct1.union1.pclipdata
proc pclipdata*(self: var PROPVARIANT): var ptr CLIPDATA {.inline.} = self.union1.struct1.union1.pclipdata
proc `bstrVal=`*(self: var PROPVARIANT, x: BSTR) {.inline.} = self.union1.struct1.union1.bstrVal = x
proc bstrVal*(self: PROPVARIANT): BSTR {.inline.} = self.union1.struct1.union1.bstrVal
proc bstrVal*(self: var PROPVARIANT): var BSTR {.inline.} = self.union1.struct1.union1.bstrVal
proc `bstrblobVal=`*(self: var PROPVARIANT, x: BSTRBLOB) {.inline.} = self.union1.struct1.union1.bstrblobVal = x
proc bstrblobVal*(self: PROPVARIANT): BSTRBLOB {.inline.} = self.union1.struct1.union1.bstrblobVal
proc bstrblobVal*(self: var PROPVARIANT): var BSTRBLOB {.inline.} = self.union1.struct1.union1.bstrblobVal
proc `blob=`*(self: var PROPVARIANT, x: BLOB) {.inline.} = self.union1.struct1.union1.blob = x
proc blob*(self: PROPVARIANT): BLOB {.inline.} = self.union1.struct1.union1.blob
proc blob*(self: var PROPVARIANT): var BLOB {.inline.} = self.union1.struct1.union1.blob
proc `pszVal=`*(self: var PROPVARIANT, x: LPSTR) {.inline.} = self.union1.struct1.union1.pszVal = x
proc pszVal*(self: PROPVARIANT): LPSTR {.inline.} = self.union1.struct1.union1.pszVal
proc pszVal*(self: var PROPVARIANT): var LPSTR {.inline.} = self.union1.struct1.union1.pszVal
proc `pwszVal=`*(self: var PROPVARIANT, x: LPWSTR) {.inline.} = self.union1.struct1.union1.pwszVal = x
proc pwszVal*(self: PROPVARIANT): LPWSTR {.inline.} = self.union1.struct1.union1.pwszVal
proc pwszVal*(self: var PROPVARIANT): var LPWSTR {.inline.} = self.union1.struct1.union1.pwszVal
proc `punkVal=`*(self: var PROPVARIANT, x: ptr IUnknown) {.inline.} = self.union1.struct1.union1.punkVal = x
proc punkVal*(self: PROPVARIANT): ptr IUnknown {.inline.} = self.union1.struct1.union1.punkVal
proc punkVal*(self: var PROPVARIANT): var ptr IUnknown {.inline.} = self.union1.struct1.union1.punkVal
proc `pdispVal=`*(self: var PROPVARIANT, x: ptr IDispatch) {.inline.} = self.union1.struct1.union1.pdispVal = x
proc pdispVal*(self: PROPVARIANT): ptr IDispatch {.inline.} = self.union1.struct1.union1.pdispVal
proc pdispVal*(self: var PROPVARIANT): var ptr IDispatch {.inline.} = self.union1.struct1.union1.pdispVal
proc `pStream=`*(self: var PROPVARIANT, x: ptr IStream) {.inline.} = self.union1.struct1.union1.pStream = x
proc pStream*(self: PROPVARIANT): ptr IStream {.inline.} = self.union1.struct1.union1.pStream
proc pStream*(self: var PROPVARIANT): var ptr IStream {.inline.} = self.union1.struct1.union1.pStream
proc `pStorage=`*(self: var PROPVARIANT, x: ptr IStorage) {.inline.} = self.union1.struct1.union1.pStorage = x
proc pStorage*(self: PROPVARIANT): ptr IStorage {.inline.} = self.union1.struct1.union1.pStorage
proc pStorage*(self: var PROPVARIANT): var ptr IStorage {.inline.} = self.union1.struct1.union1.pStorage
proc `pVersionedStream=`*(self: var PROPVARIANT, x: LPVERSIONEDSTREAM) {.inline.} = self.union1.struct1.union1.pVersionedStream = x
proc pVersionedStream*(self: PROPVARIANT): LPVERSIONEDSTREAM {.inline.} = self.union1.struct1.union1.pVersionedStream
proc pVersionedStream*(self: var PROPVARIANT): var LPVERSIONEDSTREAM {.inline.} = self.union1.struct1.union1.pVersionedStream
proc `parray=`*(self: var PROPVARIANT, x: LPSAFEARRAY) {.inline.} = self.union1.struct1.union1.parray = x
proc parray*(self: PROPVARIANT): LPSAFEARRAY {.inline.} = self.union1.struct1.union1.parray
proc parray*(self: var PROPVARIANT): var LPSAFEARRAY {.inline.} = self.union1.struct1.union1.parray
proc `cac=`*(self: var PROPVARIANT, x: CAC) {.inline.} = self.union1.struct1.union1.cac = x
proc cac*(self: PROPVARIANT): CAC {.inline.} = self.union1.struct1.union1.cac
proc cac*(self: var PROPVARIANT): var CAC {.inline.} = self.union1.struct1.union1.cac
proc `caub=`*(self: var PROPVARIANT, x: CAUB) {.inline.} = self.union1.struct1.union1.caub = x
proc caub*(self: PROPVARIANT): CAUB {.inline.} = self.union1.struct1.union1.caub
proc caub*(self: var PROPVARIANT): var CAUB {.inline.} = self.union1.struct1.union1.caub
proc `cai=`*(self: var PROPVARIANT, x: CAI) {.inline.} = self.union1.struct1.union1.cai = x
proc cai*(self: PROPVARIANT): CAI {.inline.} = self.union1.struct1.union1.cai
proc cai*(self: var PROPVARIANT): var CAI {.inline.} = self.union1.struct1.union1.cai
proc `caui=`*(self: var PROPVARIANT, x: CAUI) {.inline.} = self.union1.struct1.union1.caui = x
proc caui*(self: PROPVARIANT): CAUI {.inline.} = self.union1.struct1.union1.caui
proc caui*(self: var PROPVARIANT): var CAUI {.inline.} = self.union1.struct1.union1.caui
proc `cal=`*(self: var PROPVARIANT, x: CAL) {.inline.} = self.union1.struct1.union1.cal = x
proc cal*(self: PROPVARIANT): CAL {.inline.} = self.union1.struct1.union1.cal
proc cal*(self: var PROPVARIANT): var CAL {.inline.} = self.union1.struct1.union1.cal
proc `caul=`*(self: var PROPVARIANT, x: CAUL) {.inline.} = self.union1.struct1.union1.caul = x
proc caul*(self: PROPVARIANT): CAUL {.inline.} = self.union1.struct1.union1.caul
proc caul*(self: var PROPVARIANT): var CAUL {.inline.} = self.union1.struct1.union1.caul
proc `cah=`*(self: var PROPVARIANT, x: CAH) {.inline.} = self.union1.struct1.union1.cah = x
proc cah*(self: PROPVARIANT): CAH {.inline.} = self.union1.struct1.union1.cah
proc cah*(self: var PROPVARIANT): var CAH {.inline.} = self.union1.struct1.union1.cah
proc `cauh=`*(self: var PROPVARIANT, x: CAUH) {.inline.} = self.union1.struct1.union1.cauh = x
proc cauh*(self: PROPVARIANT): CAUH {.inline.} = self.union1.struct1.union1.cauh
proc cauh*(self: var PROPVARIANT): var CAUH {.inline.} = self.union1.struct1.union1.cauh
proc `caflt=`*(self: var PROPVARIANT, x: CAFLT) {.inline.} = self.union1.struct1.union1.caflt = x
proc caflt*(self: PROPVARIANT): CAFLT {.inline.} = self.union1.struct1.union1.caflt
proc caflt*(self: var PROPVARIANT): var CAFLT {.inline.} = self.union1.struct1.union1.caflt
proc `cadbl=`*(self: var PROPVARIANT, x: CADBL) {.inline.} = self.union1.struct1.union1.cadbl = x
proc cadbl*(self: PROPVARIANT): CADBL {.inline.} = self.union1.struct1.union1.cadbl
proc cadbl*(self: var PROPVARIANT): var CADBL {.inline.} = self.union1.struct1.union1.cadbl
proc `cabool=`*(self: var PROPVARIANT, x: CABOOL) {.inline.} = self.union1.struct1.union1.cabool = x
proc cabool*(self: PROPVARIANT): CABOOL {.inline.} = self.union1.struct1.union1.cabool
proc cabool*(self: var PROPVARIANT): var CABOOL {.inline.} = self.union1.struct1.union1.cabool
proc `cascode=`*(self: var PROPVARIANT, x: CASCODE) {.inline.} = self.union1.struct1.union1.cascode = x
proc cascode*(self: PROPVARIANT): CASCODE {.inline.} = self.union1.struct1.union1.cascode
proc cascode*(self: var PROPVARIANT): var CASCODE {.inline.} = self.union1.struct1.union1.cascode
proc `cacy=`*(self: var PROPVARIANT, x: CACY) {.inline.} = self.union1.struct1.union1.cacy = x
proc cacy*(self: PROPVARIANT): CACY {.inline.} = self.union1.struct1.union1.cacy
proc cacy*(self: var PROPVARIANT): var CACY {.inline.} = self.union1.struct1.union1.cacy
proc `cadate=`*(self: var PROPVARIANT, x: CADATE) {.inline.} = self.union1.struct1.union1.cadate = x
proc cadate*(self: PROPVARIANT): CADATE {.inline.} = self.union1.struct1.union1.cadate
proc cadate*(self: var PROPVARIANT): var CADATE {.inline.} = self.union1.struct1.union1.cadate
proc `cafiletime=`*(self: var PROPVARIANT, x: CAFILETIME) {.inline.} = self.union1.struct1.union1.cafiletime = x
proc cafiletime*(self: PROPVARIANT): CAFILETIME {.inline.} = self.union1.struct1.union1.cafiletime
proc cafiletime*(self: var PROPVARIANT): var CAFILETIME {.inline.} = self.union1.struct1.union1.cafiletime
proc `cauuid=`*(self: var PROPVARIANT, x: CACLSID) {.inline.} = self.union1.struct1.union1.cauuid = x
proc cauuid*(self: PROPVARIANT): CACLSID {.inline.} = self.union1.struct1.union1.cauuid
proc cauuid*(self: var PROPVARIANT): var CACLSID {.inline.} = self.union1.struct1.union1.cauuid
proc `caclipdata=`*(self: var PROPVARIANT, x: CACLIPDATA) {.inline.} = self.union1.struct1.union1.caclipdata = x
proc caclipdata*(self: PROPVARIANT): CACLIPDATA {.inline.} = self.union1.struct1.union1.caclipdata
proc caclipdata*(self: var PROPVARIANT): var CACLIPDATA {.inline.} = self.union1.struct1.union1.caclipdata
proc `cabstr=`*(self: var PROPVARIANT, x: CABSTR) {.inline.} = self.union1.struct1.union1.cabstr = x
proc cabstr*(self: PROPVARIANT): CABSTR {.inline.} = self.union1.struct1.union1.cabstr
proc cabstr*(self: var PROPVARIANT): var CABSTR {.inline.} = self.union1.struct1.union1.cabstr
proc `cabstrblob=`*(self: var PROPVARIANT, x: CABSTRBLOB) {.inline.} = self.union1.struct1.union1.cabstrblob = x
proc cabstrblob*(self: PROPVARIANT): CABSTRBLOB {.inline.} = self.union1.struct1.union1.cabstrblob
proc cabstrblob*(self: var PROPVARIANT): var CABSTRBLOB {.inline.} = self.union1.struct1.union1.cabstrblob
proc `calpstr=`*(self: var PROPVARIANT, x: CALPSTR) {.inline.} = self.union1.struct1.union1.calpstr = x
proc calpstr*(self: PROPVARIANT): CALPSTR {.inline.} = self.union1.struct1.union1.calpstr
proc calpstr*(self: var PROPVARIANT): var CALPSTR {.inline.} = self.union1.struct1.union1.calpstr
proc `calpwstr=`*(self: var PROPVARIANT, x: CALPWSTR) {.inline.} = self.union1.struct1.union1.calpwstr = x
proc calpwstr*(self: PROPVARIANT): CALPWSTR {.inline.} = self.union1.struct1.union1.calpwstr
proc calpwstr*(self: var PROPVARIANT): var CALPWSTR {.inline.} = self.union1.struct1.union1.calpwstr
proc `capropvar=`*(self: var PROPVARIANT, x: CAPROPVARIANT) {.inline.} = self.union1.struct1.union1.capropvar = x
proc capropvar*(self: PROPVARIANT): CAPROPVARIANT {.inline.} = self.union1.struct1.union1.capropvar
proc capropvar*(self: var PROPVARIANT): var CAPROPVARIANT {.inline.} = self.union1.struct1.union1.capropvar
proc `pcVal=`*(self: var PROPVARIANT, x: ptr CHAR) {.inline.} = self.union1.struct1.union1.pcVal = x
proc pcVal*(self: PROPVARIANT): ptr CHAR {.inline.} = self.union1.struct1.union1.pcVal
proc pcVal*(self: var PROPVARIANT): var ptr CHAR {.inline.} = self.union1.struct1.union1.pcVal
proc `pbVal=`*(self: var PROPVARIANT, x: ptr UCHAR) {.inline.} = self.union1.struct1.union1.pbVal = x
proc pbVal*(self: PROPVARIANT): ptr UCHAR {.inline.} = self.union1.struct1.union1.pbVal
proc pbVal*(self: var PROPVARIANT): var ptr UCHAR {.inline.} = self.union1.struct1.union1.pbVal
proc `piVal=`*(self: var PROPVARIANT, x: ptr SHORT) {.inline.} = self.union1.struct1.union1.piVal = x
proc piVal*(self: PROPVARIANT): ptr SHORT {.inline.} = self.union1.struct1.union1.piVal
proc piVal*(self: var PROPVARIANT): var ptr SHORT {.inline.} = self.union1.struct1.union1.piVal
proc `puiVal=`*(self: var PROPVARIANT, x: ptr USHORT) {.inline.} = self.union1.struct1.union1.puiVal = x
proc puiVal*(self: PROPVARIANT): ptr USHORT {.inline.} = self.union1.struct1.union1.puiVal
proc puiVal*(self: var PROPVARIANT): var ptr USHORT {.inline.} = self.union1.struct1.union1.puiVal
proc `plVal=`*(self: var PROPVARIANT, x: ptr LONG) {.inline.} = self.union1.struct1.union1.plVal = x
proc plVal*(self: PROPVARIANT): ptr LONG {.inline.} = self.union1.struct1.union1.plVal
proc plVal*(self: var PROPVARIANT): var ptr LONG {.inline.} = self.union1.struct1.union1.plVal
proc `pulVal=`*(self: var PROPVARIANT, x: ptr ULONG) {.inline.} = self.union1.struct1.union1.pulVal = x
proc pulVal*(self: PROPVARIANT): ptr ULONG {.inline.} = self.union1.struct1.union1.pulVal
proc pulVal*(self: var PROPVARIANT): var ptr ULONG {.inline.} = self.union1.struct1.union1.pulVal
proc `pintVal=`*(self: var PROPVARIANT, x: ptr INT) {.inline.} = self.union1.struct1.union1.pintVal = x
proc pintVal*(self: PROPVARIANT): ptr INT {.inline.} = self.union1.struct1.union1.pintVal
proc pintVal*(self: var PROPVARIANT): var ptr INT {.inline.} = self.union1.struct1.union1.pintVal
proc `puintVal=`*(self: var PROPVARIANT, x: ptr UINT) {.inline.} = self.union1.struct1.union1.puintVal = x
proc puintVal*(self: PROPVARIANT): ptr UINT {.inline.} = self.union1.struct1.union1.puintVal
proc puintVal*(self: var PROPVARIANT): var ptr UINT {.inline.} = self.union1.struct1.union1.puintVal
proc `pfltVal=`*(self: var PROPVARIANT, x: ptr FLOAT) {.inline.} = self.union1.struct1.union1.pfltVal = x
proc pfltVal*(self: PROPVARIANT): ptr FLOAT {.inline.} = self.union1.struct1.union1.pfltVal
proc pfltVal*(self: var PROPVARIANT): var ptr FLOAT {.inline.} = self.union1.struct1.union1.pfltVal
proc `pdblVal=`*(self: var PROPVARIANT, x: ptr DOUBLE) {.inline.} = self.union1.struct1.union1.pdblVal = x
proc pdblVal*(self: PROPVARIANT): ptr DOUBLE {.inline.} = self.union1.struct1.union1.pdblVal
proc pdblVal*(self: var PROPVARIANT): var ptr DOUBLE {.inline.} = self.union1.struct1.union1.pdblVal
proc `pboolVal=`*(self: var PROPVARIANT, x: ptr VARIANT_BOOL) {.inline.} = self.union1.struct1.union1.pboolVal = x
proc pboolVal*(self: PROPVARIANT): ptr VARIANT_BOOL {.inline.} = self.union1.struct1.union1.pboolVal
proc pboolVal*(self: var PROPVARIANT): var ptr VARIANT_BOOL {.inline.} = self.union1.struct1.union1.pboolVal
proc `pdecVal=`*(self: var PROPVARIANT, x: ptr DECIMAL) {.inline.} = self.union1.struct1.union1.pdecVal = x
proc pdecVal*(self: PROPVARIANT): ptr DECIMAL {.inline.} = self.union1.struct1.union1.pdecVal
proc pdecVal*(self: var PROPVARIANT): var ptr DECIMAL {.inline.} = self.union1.struct1.union1.pdecVal
proc `pscode=`*(self: var PROPVARIANT, x: ptr SCODE) {.inline.} = self.union1.struct1.union1.pscode = x
proc pscode*(self: PROPVARIANT): ptr SCODE {.inline.} = self.union1.struct1.union1.pscode
proc pscode*(self: var PROPVARIANT): var ptr SCODE {.inline.} = self.union1.struct1.union1.pscode
proc `pcyVal=`*(self: var PROPVARIANT, x: ptr CY) {.inline.} = self.union1.struct1.union1.pcyVal = x
proc pcyVal*(self: PROPVARIANT): ptr CY {.inline.} = self.union1.struct1.union1.pcyVal
proc pcyVal*(self: var PROPVARIANT): var ptr CY {.inline.} = self.union1.struct1.union1.pcyVal
proc `pdate=`*(self: var PROPVARIANT, x: ptr DATE) {.inline.} = self.union1.struct1.union1.pdate = x
proc pdate*(self: PROPVARIANT): ptr DATE {.inline.} = self.union1.struct1.union1.pdate
proc pdate*(self: var PROPVARIANT): var ptr DATE {.inline.} = self.union1.struct1.union1.pdate
proc `pbstrVal=`*(self: var PROPVARIANT, x: ptr BSTR) {.inline.} = self.union1.struct1.union1.pbstrVal = x
proc pbstrVal*(self: PROPVARIANT): ptr BSTR {.inline.} = self.union1.struct1.union1.pbstrVal
proc pbstrVal*(self: var PROPVARIANT): var ptr BSTR {.inline.} = self.union1.struct1.union1.pbstrVal
proc `ppunkVal=`*(self: var PROPVARIANT, x: ptr ptr IUnknown) {.inline.} = self.union1.struct1.union1.ppunkVal = x
proc ppunkVal*(self: PROPVARIANT): ptr ptr IUnknown {.inline.} = self.union1.struct1.union1.ppunkVal
proc ppunkVal*(self: var PROPVARIANT): var ptr ptr IUnknown {.inline.} = self.union1.struct1.union1.ppunkVal
proc `ppdispVal=`*(self: var PROPVARIANT, x: ptr ptr IDispatch) {.inline.} = self.union1.struct1.union1.ppdispVal = x
proc ppdispVal*(self: PROPVARIANT): ptr ptr IDispatch {.inline.} = self.union1.struct1.union1.ppdispVal
proc ppdispVal*(self: var PROPVARIANT): var ptr ptr IDispatch {.inline.} = self.union1.struct1.union1.ppdispVal
proc `pparray=`*(self: var PROPVARIANT, x: ptr LPSAFEARRAY) {.inline.} = self.union1.struct1.union1.pparray = x
proc pparray*(self: PROPVARIANT): ptr LPSAFEARRAY {.inline.} = self.union1.struct1.union1.pparray
proc pparray*(self: var PROPVARIANT): var ptr LPSAFEARRAY {.inline.} = self.union1.struct1.union1.pparray
proc `pvarVal=`*(self: var PROPVARIANT, x: ptr PROPVARIANT) {.inline.} = self.union1.struct1.union1.pvarVal = x
proc pvarVal*(self: PROPVARIANT): ptr PROPVARIANT {.inline.} = self.union1.struct1.union1.pvarVal
proc pvarVal*(self: var PROPVARIANT): var ptr PROPVARIANT {.inline.} = self.union1.struct1.union1.pvarVal
proc `decVal=`*(self: var PROPVARIANT, x: DECIMAL) {.inline.} = self.union1.decVal = x
proc decVal*(self: PROPVARIANT): DECIMAL {.inline.} = self.union1.decVal
proc decVal*(self: var PROPVARIANT): var DECIMAL {.inline.} = self.union1.decVal
proc `propid=`*(self: var PROPSPEC, x: PROPID) {.inline.} = self.union1.propid = x
proc propid*(self: PROPSPEC): PROPID {.inline.} = self.union1.propid
proc propid*(self: var PROPSPEC): var PROPID {.inline.} = self.union1.propid
proc `lpwstr=`*(self: var PROPSPEC, x: LPOLESTR) {.inline.} = self.union1.lpwstr = x
proc lpwstr*(self: PROPSPEC): LPOLESTR {.inline.} = self.union1.lpwstr
proc lpwstr*(self: var PROPSPEC): var LPOLESTR {.inline.} = self.union1.lpwstr
proc `pOleStr=`*(self: var STRRET, x: LPWSTR) {.inline.} = self.union1.pOleStr = x
proc pOleStr*(self: STRRET): LPWSTR {.inline.} = self.union1.pOleStr
proc pOleStr*(self: var STRRET): var LPWSTR {.inline.} = self.union1.pOleStr
proc `uOffset=`*(self: var STRRET, x: UINT) {.inline.} = self.union1.uOffset = x
proc uOffset*(self: STRRET): UINT {.inline.} = self.union1.uOffset
proc uOffset*(self: var STRRET): var UINT {.inline.} = self.union1.uOffset
proc `cStr=`*(self: var STRRET, x: array[260, char]) {.inline.} = self.union1.cStr = x
proc cStr*(self: STRRET): array[260, char] {.inline.} = self.union1.cStr
proc cStr*(self: var STRRET): var array[260, char] {.inline.} = self.union1.cStr
proc QueryInterface*(self: ptr IUnknown, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryInterface(self, riid, ppvObject)
proc AddRef*(self: ptr IUnknown): ULONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddRef(self)
proc Release*(self: ptr IUnknown): ULONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Release(self)
proc Begin_QueryInterface*(self: ptr AsyncIUnknown, riid: REFIID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_QueryInterface(self, riid)
proc Finish_QueryInterface*(self: ptr AsyncIUnknown, ppvObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_QueryInterface(self, ppvObject)
proc Begin_AddRef*(self: ptr AsyncIUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_AddRef(self)
proc Finish_AddRef*(self: ptr AsyncIUnknown): ULONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_AddRef(self)
proc Begin_Release*(self: ptr AsyncIUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_Release(self)
proc Finish_Release*(self: ptr AsyncIUnknown): ULONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_Release(self)
proc CreateInstance*(self: ptr IClassFactory, pUnkOuter: ptr IUnknown, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance(self, pUnkOuter, riid, ppvObject)
proc LockServer*(self: ptr IClassFactory, fLock: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockServer(self, fLock)
proc GetUnmarshalClass*(self: ptr IMarshal, riid: REFIID, pv: pointer, dwDestContext: DWORD, pvDestContext: pointer, mshlflags: DWORD, pCid: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUnmarshalClass(self, riid, pv, dwDestContext, pvDestContext, mshlflags, pCid)
proc GetMarshalSizeMax*(self: ptr IMarshal, riid: REFIID, pv: pointer, dwDestContext: DWORD, pvDestContext: pointer, mshlflags: DWORD, pSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMarshalSizeMax(self, riid, pv, dwDestContext, pvDestContext, mshlflags, pSize)
proc MarshalInterface*(self: ptr IMarshal, pStm: ptr IStream, riid: REFIID, pv: pointer, dwDestContext: DWORD, pvDestContext: pointer, mshlflags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MarshalInterface(self, pStm, riid, pv, dwDestContext, pvDestContext, mshlflags)
proc UnmarshalInterface*(self: ptr IMarshal, pStm: ptr IStream, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnmarshalInterface(self, pStm, riid, ppv)
proc ReleaseMarshalData*(self: ptr IMarshal, pStm: ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseMarshalData(self, pStm)
proc DisconnectObject*(self: ptr IMarshal, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DisconnectObject(self, dwReserved)
proc Alloc*(self: ptr IMalloc, cb: SIZE_T): pointer {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Alloc(self, cb)
proc Realloc*(self: ptr IMalloc, pv: pointer, cb: SIZE_T): pointer {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Realloc(self, pv, cb)
proc Free*(self: ptr IMalloc, pv: pointer): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Free(self, pv)
proc GetSize*(self: ptr IMalloc, pv: pointer): SIZE_T {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSize(self, pv)
proc DidAlloc*(self: ptr IMalloc, pv: pointer): int32 {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DidAlloc(self, pv)
proc HeapMinimize*(self: ptr IMalloc): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HeapMinimize(self)
proc GetClassForHandler*(self: ptr IStdMarshalInfo, dwDestContext: DWORD, pvDestContext: pointer, pClsid: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClassForHandler(self, dwDestContext, pvDestContext, pClsid)
proc AddConnection*(self: ptr IExternalConnection, extconn: DWORD, reserved: DWORD): DWORD {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddConnection(self, extconn, reserved)
proc ReleaseConnection*(self: ptr IExternalConnection, extconn: DWORD, reserved: DWORD, fLastReleaseCloses: WINBOOL): DWORD {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseConnection(self, extconn, reserved, fLastReleaseCloses)
proc QueryMultipleInterfaces*(self: ptr IMultiQI, cMQIs: ULONG, pMQIs: ptr MULTI_QI): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryMultipleInterfaces(self, cMQIs, pMQIs)
proc Begin_QueryMultipleInterfaces*(self: ptr AsyncIMultiQI, cMQIs: ULONG, pMQIs: ptr MULTI_QI): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_QueryMultipleInterfaces(self, cMQIs, pMQIs)
proc Finish_QueryMultipleInterfaces*(self: ptr AsyncIMultiQI, pMQIs: ptr MULTI_QI): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_QueryMultipleInterfaces(self, pMQIs)
proc QueryInternalInterface*(self: ptr IInternalUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryInternalInterface(self, riid, ppv)
proc Next*(self: ptr IEnumUnknown, celt: ULONG, rgelt: ptr ptr IUnknown, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumUnknown, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumUnknown, ppenum: ptr ptr IEnumUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc Next*(self: ptr IEnumString, celt: ULONG, rgelt: ptr LPOLESTR, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumString, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumString): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumString, ppenum: ptr ptr IEnumString): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc Read*(self: ptr ISequentialStream, pv: pointer, cb: ULONG, pcbRead: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Read(self, pv, cb, pcbRead)
proc Write*(self: ptr ISequentialStream, pv: pointer, cb: ULONG, pcbWritten: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Write(self, pv, cb, pcbWritten)
proc Seek*(self: ptr IStream, dlibMove: LARGE_INTEGER, dwOrigin: DWORD, plibNewPosition: ptr ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Seek(self, dlibMove, dwOrigin, plibNewPosition)
proc SetSize*(self: ptr IStream, libNewSize: ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSize(self, libNewSize)
proc CopyTo*(self: ptr IStream, pstm: ptr IStream, cb: ULARGE_INTEGER, pcbRead: ptr ULARGE_INTEGER, pcbWritten: ptr ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyTo(self, pstm, cb, pcbRead, pcbWritten)
proc Commit*(self: ptr IStream, grfCommitFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self, grfCommitFlags)
proc Revert*(self: ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Revert(self)
proc LockRegion*(self: ptr IStream, libOffset: ULARGE_INTEGER, cb: ULARGE_INTEGER, dwLockType: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockRegion(self, libOffset, cb, dwLockType)
proc UnlockRegion*(self: ptr IStream, libOffset: ULARGE_INTEGER, cb: ULARGE_INTEGER, dwLockType: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnlockRegion(self, libOffset, cb, dwLockType)
proc Stat*(self: ptr IStream, pstatstg: ptr STATSTG, grfStatFlag: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Stat(self, pstatstg, grfStatFlag)
proc Clone*(self: ptr IStream, ppstm: ptr ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppstm)
proc GetBuffer*(self: ptr IRpcChannelBuffer, pMessage: ptr RPCOLEMESSAGE, riid: REFIID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBuffer(self, pMessage, riid)
proc SendReceive*(self: ptr IRpcChannelBuffer, pMessage: ptr RPCOLEMESSAGE, pStatus: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendReceive(self, pMessage, pStatus)
proc FreeBuffer*(self: ptr IRpcChannelBuffer, pMessage: ptr RPCOLEMESSAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FreeBuffer(self, pMessage)
proc GetDestCtx*(self: ptr IRpcChannelBuffer, pdwDestContext: ptr DWORD, ppvDestContext: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDestCtx(self, pdwDestContext, ppvDestContext)
proc IsConnected*(self: ptr IRpcChannelBuffer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsConnected(self)
proc GetProtocolVersion*(self: ptr IRpcChannelBuffer2, pdwVersion: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProtocolVersion(self, pdwVersion)
proc Send*(self: ptr IAsyncRpcChannelBuffer, pMsg: ptr RPCOLEMESSAGE, pSync: ptr ISynchronize, pulStatus: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Send(self, pMsg, pSync, pulStatus)
proc Receive*(self: ptr IAsyncRpcChannelBuffer, pMsg: ptr RPCOLEMESSAGE, pulStatus: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Receive(self, pMsg, pulStatus)
proc GetDestCtxEx*(self: ptr IAsyncRpcChannelBuffer, pMsg: ptr RPCOLEMESSAGE, pdwDestContext: ptr DWORD, ppvDestContext: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDestCtxEx(self, pMsg, pdwDestContext, ppvDestContext)
proc Send*(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, pulStatus: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Send(self, pMsg, pulStatus)
proc Receive*(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, ulSize: ULONG, pulStatus: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Receive(self, pMsg, ulSize, pulStatus)
proc Cancel*(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Cancel(self, pMsg)
proc GetCallContext*(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, riid: REFIID, pInterface: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCallContext(self, pMsg, riid, pInterface)
proc GetDestCtxEx*(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, pdwDestContext: ptr DWORD, ppvDestContext: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDestCtxEx(self, pMsg, pdwDestContext, ppvDestContext)
proc GetState*(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, pState: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetState(self, pMsg, pState)
proc RegisterAsync*(self: ptr IRpcChannelBuffer3, pMsg: ptr RPCOLEMESSAGE, pAsyncMgr: ptr IAsyncManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterAsync(self, pMsg, pAsyncMgr)
proc NegotiateSyntax*(self: ptr IRpcSyntaxNegotiate, pMsg: ptr RPCOLEMESSAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NegotiateSyntax(self, pMsg)
proc Connect*(self: ptr IRpcProxyBuffer, pRpcChannelBuffer: ptr IRpcChannelBuffer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Connect(self, pRpcChannelBuffer)
proc Disconnect*(self: ptr IRpcProxyBuffer): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Disconnect(self)
proc Connect*(self: ptr IRpcStubBuffer, pUnkServer: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Connect(self, pUnkServer)
proc Disconnect*(self: ptr IRpcStubBuffer): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Disconnect(self)
proc Invoke*(self: ptr IRpcStubBuffer, prpcmsg: ptr RPCOLEMESSAGE, pRpcChannelBuffer: ptr IRpcChannelBuffer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self, prpcmsg, pRpcChannelBuffer)
proc IsIIDSupported*(self: ptr IRpcStubBuffer, riid: REFIID): ptr IRpcStubBuffer {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsIIDSupported(self, riid)
proc CountRefs*(self: ptr IRpcStubBuffer): ULONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CountRefs(self)
proc DebugServerQueryInterface*(self: ptr IRpcStubBuffer, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DebugServerQueryInterface(self, ppv)
proc DebugServerRelease*(self: ptr IRpcStubBuffer, pv: pointer): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DebugServerRelease(self, pv)
proc CreateProxy*(self: ptr IPSFactoryBuffer, pUnkOuter: ptr IUnknown, riid: REFIID, ppProxy: ptr ptr IRpcProxyBuffer, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateProxy(self, pUnkOuter, riid, ppProxy, ppv)
proc CreateStub*(self: ptr IPSFactoryBuffer, riid: REFIID, pUnkServer: ptr IUnknown, ppStub: ptr ptr IRpcStubBuffer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateStub(self, riid, pUnkServer, ppStub)
proc ClientGetSize*(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, pDataSize: ptr ULONG): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClientGetSize(self, uExtent, riid, pDataSize)
proc ClientFillBuffer*(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, pDataSize: ptr ULONG, pDataBuffer: pointer): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClientFillBuffer(self, uExtent, riid, pDataSize, pDataBuffer)
proc ClientNotify*(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, cbDataSize: ULONG, pDataBuffer: pointer, lDataRep: DWORD, hrFault: HRESULT): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClientNotify(self, uExtent, riid, cbDataSize, pDataBuffer, lDataRep, hrFault)
proc ServerNotify*(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, cbDataSize: ULONG, pDataBuffer: pointer, lDataRep: DWORD): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ServerNotify(self, uExtent, riid, cbDataSize, pDataBuffer, lDataRep)
proc ServerGetSize*(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, hrFault: HRESULT, pDataSize: ptr ULONG): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ServerGetSize(self, uExtent, riid, hrFault, pDataSize)
proc ServerFillBuffer*(self: ptr IChannelHook, uExtent: REFGUID, riid: REFIID, pDataSize: ptr ULONG, pDataBuffer: pointer, hrFault: HRESULT): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ServerFillBuffer(self, uExtent, riid, pDataSize, pDataBuffer, hrFault)
proc QueryBlanket*(self: ptr IClientSecurity, pProxy: ptr IUnknown, pAuthnSvc: ptr DWORD, pAuthzSvc: ptr DWORD, pServerPrincName: ptr ptr OLECHAR, pAuthnLevel: ptr DWORD, pImpLevel: ptr DWORD, pAuthInfo: ptr pointer, pCapabilites: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryBlanket(self, pProxy, pAuthnSvc, pAuthzSvc, pServerPrincName, pAuthnLevel, pImpLevel, pAuthInfo, pCapabilites)
proc SetBlanket*(self: ptr IClientSecurity, pProxy: ptr IUnknown, dwAuthnSvc: DWORD, dwAuthzSvc: DWORD, pServerPrincName: ptr OLECHAR, dwAuthnLevel: DWORD, dwImpLevel: DWORD, pAuthInfo: pointer, dwCapabilities: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBlanket(self, pProxy, dwAuthnSvc, dwAuthzSvc, pServerPrincName, dwAuthnLevel, dwImpLevel, pAuthInfo, dwCapabilities)
proc CopyProxy*(self: ptr IClientSecurity, pProxy: ptr IUnknown, ppCopy: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyProxy(self, pProxy, ppCopy)
proc QueryBlanket*(self: ptr IServerSecurity, pAuthnSvc: ptr DWORD, pAuthzSvc: ptr DWORD, pServerPrincName: ptr ptr OLECHAR, pAuthnLevel: ptr DWORD, pImpLevel: ptr DWORD, pPrivs: ptr pointer, pCapabilities: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryBlanket(self, pAuthnSvc, pAuthzSvc, pServerPrincName, pAuthnLevel, pImpLevel, pPrivs, pCapabilities)
proc ImpersonateClient*(self: ptr IServerSecurity): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ImpersonateClient(self)
proc RevertToSelf*(self: ptr IServerSecurity): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RevertToSelf(self)
proc IsImpersonating*(self: ptr IServerSecurity): WINBOOL {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsImpersonating(self)
proc Set*(self: ptr IRpcOptions, pPrx: ptr IUnknown, dwProperty: RPCOPT_PROPERTIES, dwValue: ULONG_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Set(self, pPrx, dwProperty, dwValue)
proc Query*(self: ptr IRpcOptions, pPrx: ptr IUnknown, dwProperty: RPCOPT_PROPERTIES, pdwValue: ptr ULONG_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Query(self, pPrx, dwProperty, pdwValue)
proc Set*(self: ptr IGlobalOptions, dwProperty: GLOBALOPT_PROPERTIES, dwValue: ULONG_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Set(self, dwProperty, dwValue)
proc Query*(self: ptr IGlobalOptions, dwProperty: GLOBALOPT_PROPERTIES, pdwValue: ptr ULONG_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Query(self, dwProperty, pdwValue)
proc LoadDllServer*(self: ptr ISurrogate, Clsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadDllServer(self, Clsid)
proc FreeSurrogate*(self: ptr ISurrogate): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FreeSurrogate(self)
proc RegisterInterfaceInGlobal*(self: ptr IGlobalInterfaceTable, pUnk: ptr IUnknown, riid: REFIID, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterInterfaceInGlobal(self, pUnk, riid, pdwCookie)
proc RevokeInterfaceFromGlobal*(self: ptr IGlobalInterfaceTable, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RevokeInterfaceFromGlobal(self, dwCookie)
proc GetInterfaceFromGlobal*(self: ptr IGlobalInterfaceTable, dwCookie: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInterfaceFromGlobal(self, dwCookie, riid, ppv)
proc Wait*(self: ptr ISynchronize, dwFlags: DWORD, dwMilliseconds: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Wait(self, dwFlags, dwMilliseconds)
proc Signal*(self: ptr ISynchronize): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Signal(self)
proc Reset*(self: ptr ISynchronize): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc GetHandle*(self: ptr ISynchronizeHandle, ph: ptr HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHandle(self, ph)
proc SetEventHandle*(self: ptr ISynchronizeEvent, ph: ptr HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetEventHandle(self, ph)
proc AddSynchronize*(self: ptr ISynchronizeContainer, pSync: ptr ISynchronize): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddSynchronize(self, pSync)
proc WaitMultiple*(self: ptr ISynchronizeContainer, dwFlags: DWORD, dwTimeOut: DWORD, ppSync: ptr ptr ISynchronize): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WaitMultiple(self, dwFlags, dwTimeOut, ppSync)
proc ReleaseMutex*(self: ptr ISynchronizeMutex): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseMutex(self)
proc Cancel*(self: ptr ICancelMethodCalls, ulSeconds: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Cancel(self, ulSeconds)
proc TestCancel*(self: ptr ICancelMethodCalls): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TestCancel(self)
proc CompleteCall*(self: ptr IAsyncManager, Result: HRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CompleteCall(self, Result)
proc GetCallContext*(self: ptr IAsyncManager, riid: REFIID, pInterface: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCallContext(self, riid, pInterface)
proc GetState*(self: ptr IAsyncManager, pulStateFlags: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetState(self, pulStateFlags)
proc CreateCall*(self: ptr ICallFactory, riid: REFIID, pCtrlUnk: ptr IUnknown, riid2: REFIID, ppv: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateCall(self, riid, pCtrlUnk, riid2, ppv)
proc GetDCOMProtocolVersion*(self: ptr IRpcHelper, pComVersion: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDCOMProtocolVersion(self, pComVersion)
proc GetIIDFromOBJREF*(self: ptr IRpcHelper, pObjRef: pointer, piid: ptr ptr IID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIIDFromOBJREF(self, pObjRef, piid)
proc ReleaseMarshalBuffer*(self: ptr IReleaseMarshalBuffers, pMsg: ptr RPCOLEMESSAGE, dwFlags: DWORD, pChnl: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseMarshalBuffer(self, pMsg, dwFlags, pChnl)
proc WaitMultiple*(self: ptr IWaitMultiple, timeout: DWORD, pSync: ptr ptr ISynchronize): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WaitMultiple(self, timeout, pSync)
proc AddSynchronize*(self: ptr IWaitMultiple, pSync: ptr ISynchronize): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddSynchronize(self, pSync)
proc EnableCOMDynamicAddrTracking*(self: ptr IAddrTrackingControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableCOMDynamicAddrTracking(self)
proc DisableCOMDynamicAddrTracking*(self: ptr IAddrTrackingControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DisableCOMDynamicAddrTracking(self)
proc GetCurrentAddrExclusionList*(self: ptr IAddrExclusionControl, riid: REFIID, ppEnumerator: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentAddrExclusionList(self, riid, ppEnumerator)
proc UpdateAddrExclusionList*(self: ptr IAddrExclusionControl, pEnumerator: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateAddrExclusionList(self, pEnumerator)
proc Pull*(self: ptr IPipeByte, buf: ptr BYTE, cRequest: ULONG, pcReturned: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Pull(self, buf, cRequest, pcReturned)
proc Push*(self: ptr IPipeByte, buf: ptr BYTE, cSent: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Push(self, buf, cSent)
proc Pull*(self: ptr IPipeLong, buf: ptr LONG, cRequest: ULONG, pcReturned: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Pull(self, buf, cRequest, pcReturned)
proc Push*(self: ptr IPipeLong, buf: ptr LONG, cSent: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Push(self, buf, cSent)
proc Pull*(self: ptr IPipeDouble, buf: ptr DOUBLE, cRequest: ULONG, pcReturned: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Pull(self, buf, cRequest, pcReturned)
proc Push*(self: ptr IPipeDouble, buf: ptr DOUBLE, cSent: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Push(self, buf, cSent)
proc Next*(self: ptr IEnumContextProps, celt: ULONG, pContextProperties: ptr ContextProperty, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, pContextProperties, pceltFetched)
proc Skip*(self: ptr IEnumContextProps, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumContextProps): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumContextProps, ppEnumContextProps: ptr ptr IEnumContextProps): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnumContextProps)
proc Count*(self: ptr IEnumContextProps, pcelt: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Count(self, pcelt)
proc SetProperty*(self: ptr IContext, rpolicyId: REFGUID, flags: CPFLAGS, pUnk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProperty(self, rpolicyId, flags, pUnk)
proc RemoveProperty*(self: ptr IContext, rPolicyId: REFGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveProperty(self, rPolicyId)
proc GetProperty*(self: ptr IContext, rGuid: REFGUID, pFlags: ptr CPFLAGS, ppUnk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, rGuid, pFlags, ppUnk)
proc EnumContextProps*(self: ptr IContext, ppEnumContextProps: ptr ptr IEnumContextProps): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumContextProps(self, ppEnumContextProps)
proc GetCurrentApartmentType*(self: ptr IComThreadingInfo, pAptType: ptr APTTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentApartmentType(self, pAptType)
proc GetCurrentThreadType*(self: ptr IComThreadingInfo, pThreadType: ptr THDTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentThreadType(self, pThreadType)
proc GetCurrentLogicalThreadId*(self: ptr IComThreadingInfo, pguidLogicalThreadId: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentLogicalThreadId(self, pguidLogicalThreadId)
proc SetCurrentLogicalThreadId*(self: ptr IComThreadingInfo, rguid: REFGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCurrentLogicalThreadId(self, rguid)
proc ResetInitializerTimeout*(self: ptr IProcessInitControl, dwSecondsRemaining: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetInitializerTimeout(self, dwSecondsRemaining)
proc GetMarshalingContextAttribute*(self: ptr IMarshalingStream, attribute: CO_MARSHALING_CONTEXT_ATTRIBUTES, pAttributeValue: ptr ULONG_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMarshalingContextAttribute(self, attribute, pAttributeValue)
proc PreAlloc*(self: ptr IMallocSpy, cbRequest: SIZE_T): SIZE_T {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreAlloc(self, cbRequest)
proc PostAlloc*(self: ptr IMallocSpy, pActual: pointer): pointer {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostAlloc(self, pActual)
proc PreFree*(self: ptr IMallocSpy, pRequest: pointer, fSpyed: WINBOOL): pointer {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreFree(self, pRequest, fSpyed)
proc PostFree*(self: ptr IMallocSpy, fSpyed: WINBOOL): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostFree(self, fSpyed)
proc PreRealloc*(self: ptr IMallocSpy, pRequest: pointer, cbRequest: SIZE_T, ppNewRequest: ptr pointer, fSpyed: WINBOOL): SIZE_T {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreRealloc(self, pRequest, cbRequest, ppNewRequest, fSpyed)
proc PostRealloc*(self: ptr IMallocSpy, pActual: pointer, fSpyed: WINBOOL): pointer {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostRealloc(self, pActual, fSpyed)
proc PreGetSize*(self: ptr IMallocSpy, pRequest: pointer, fSpyed: WINBOOL): pointer {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreGetSize(self, pRequest, fSpyed)
proc PostGetSize*(self: ptr IMallocSpy, cbActual: SIZE_T, fSpyed: WINBOOL): SIZE_T {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostGetSize(self, cbActual, fSpyed)
proc PreDidAlloc*(self: ptr IMallocSpy, pRequest: pointer, fSpyed: WINBOOL): pointer {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreDidAlloc(self, pRequest, fSpyed)
proc PostDidAlloc*(self: ptr IMallocSpy, pRequest: pointer, fSpyed: WINBOOL, fActual: int32): int32 {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostDidAlloc(self, pRequest, fSpyed, fActual)
proc PreHeapMinimize*(self: ptr IMallocSpy): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreHeapMinimize(self)
proc PostHeapMinimize*(self: ptr IMallocSpy): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostHeapMinimize(self)
proc RegisterObjectBound*(self: ptr IBindCtx, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterObjectBound(self, punk)
proc RevokeObjectBound*(self: ptr IBindCtx, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RevokeObjectBound(self, punk)
proc ReleaseBoundObjects*(self: ptr IBindCtx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseBoundObjects(self)
proc SetBindOptions*(self: ptr IBindCtx, pbindopts: ptr BIND_OPTS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBindOptions(self, pbindopts)
proc GetBindOptions*(self: ptr IBindCtx, pbindopts: ptr BIND_OPTS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindOptions(self, pbindopts)
proc GetRunningObjectTable*(self: ptr IBindCtx, pprot: ptr ptr IRunningObjectTable): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRunningObjectTable(self, pprot)
proc RegisterObjectParam*(self: ptr IBindCtx, pszKey: LPOLESTR, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterObjectParam(self, pszKey, punk)
proc GetObjectParam*(self: ptr IBindCtx, pszKey: LPOLESTR, ppunk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectParam(self, pszKey, ppunk)
proc EnumObjectParam*(self: ptr IBindCtx, ppenum: ptr ptr IEnumString): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumObjectParam(self, ppenum)
proc RevokeObjectParam*(self: ptr IBindCtx, pszKey: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RevokeObjectParam(self, pszKey)
proc Next*(self: ptr IEnumMoniker, celt: ULONG, rgelt: ptr ptr IMoniker, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumMoniker, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumMoniker, ppenum: ptr ptr IEnumMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc GetRunningClass*(self: ptr IRunnableObject, lpClsid: LPCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRunningClass(self, lpClsid)
proc Run*(self: ptr IRunnableObject, pbc: LPBINDCTX): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Run(self, pbc)
proc IsRunning*(self: ptr IRunnableObject): WINBOOL {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsRunning(self)
proc LockRunning*(self: ptr IRunnableObject, fLock: WINBOOL, fLastUnlockCloses: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockRunning(self, fLock, fLastUnlockCloses)
proc SetContainedObject*(self: ptr IRunnableObject, fContained: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetContainedObject(self, fContained)
proc Register*(self: ptr IRunningObjectTable, grfFlags: DWORD, punkObject: ptr IUnknown, pmkObjectName: ptr IMoniker, pdwRegister: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Register(self, grfFlags, punkObject, pmkObjectName, pdwRegister)
proc Revoke*(self: ptr IRunningObjectTable, dwRegister: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Revoke(self, dwRegister)
proc IsRunning*(self: ptr IRunningObjectTable, pmkObjectName: ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsRunning(self, pmkObjectName)
proc GetObject*(self: ptr IRunningObjectTable, pmkObjectName: ptr IMoniker, ppunkObject: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObject(self, pmkObjectName, ppunkObject)
proc NoteChangeTime*(self: ptr IRunningObjectTable, dwRegister: DWORD, pfiletime: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NoteChangeTime(self, dwRegister, pfiletime)
proc GetTimeOfLastChange*(self: ptr IRunningObjectTable, pmkObjectName: ptr IMoniker, pfiletime: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTimeOfLastChange(self, pmkObjectName, pfiletime)
proc EnumRunning*(self: ptr IRunningObjectTable, ppenumMoniker: ptr ptr IEnumMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumRunning(self, ppenumMoniker)
proc GetClassID*(self: ptr IPersist, pClassID: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClassID(self, pClassID)
proc IsDirty*(self: ptr IPersistStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDirty(self)
proc Load*(self: ptr IPersistStream, pStm: ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, pStm)
proc Save*(self: ptr IPersistStream, pStm: ptr IStream, fClearDirty: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, pStm, fClearDirty)
proc GetSizeMax*(self: ptr IPersistStream, pcbSize: ptr ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSizeMax(self, pcbSize)
proc BindToObject*(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, riidResult: REFIID, ppvResult: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindToObject(self, pbc, pmkToLeft, riidResult, ppvResult)
proc BindToStorage*(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, riid: REFIID, ppvObj: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindToStorage(self, pbc, pmkToLeft, riid, ppvObj)
proc Reduce*(self: ptr IMoniker, pbc: ptr IBindCtx, dwReduceHowFar: DWORD, ppmkToLeft: ptr ptr IMoniker, ppmkReduced: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reduce(self, pbc, dwReduceHowFar, ppmkToLeft, ppmkReduced)
proc ComposeWith*(self: ptr IMoniker, pmkRight: ptr IMoniker, fOnlyIfNotGeneric: WINBOOL, ppmkComposite: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ComposeWith(self, pmkRight, fOnlyIfNotGeneric, ppmkComposite)
proc Enum*(self: ptr IMoniker, fForward: WINBOOL, ppenumMoniker: ptr ptr IEnumMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Enum(self, fForward, ppenumMoniker)
proc IsEqual*(self: ptr IMoniker, pmkOtherMoniker: ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsEqual(self, pmkOtherMoniker)
proc Hash*(self: ptr IMoniker, pdwHash: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Hash(self, pdwHash)
proc IsRunning*(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, pmkNewlyRunning: ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsRunning(self, pbc, pmkToLeft, pmkNewlyRunning)
proc GetTimeOfLastChange*(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, pFileTime: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTimeOfLastChange(self, pbc, pmkToLeft, pFileTime)
proc Inverse*(self: ptr IMoniker, ppmk: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Inverse(self, ppmk)
proc CommonPrefixWith*(self: ptr IMoniker, pmkOther: ptr IMoniker, ppmkPrefix: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CommonPrefixWith(self, pmkOther, ppmkPrefix)
proc RelativePathTo*(self: ptr IMoniker, pmkOther: ptr IMoniker, ppmkRelPath: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RelativePathTo(self, pmkOther, ppmkRelPath)
proc GetDisplayName*(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, ppszDisplayName: ptr LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayName(self, pbc, pmkToLeft, ppszDisplayName)
proc ParseDisplayName*(self: ptr IMoniker, pbc: ptr IBindCtx, pmkToLeft: ptr IMoniker, pszDisplayName: LPOLESTR, pchEaten: ptr ULONG, ppmkOut: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseDisplayName(self, pbc, pmkToLeft, pszDisplayName, pchEaten, ppmkOut)
proc IsSystemMoniker*(self: ptr IMoniker, pdwMksys: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsSystemMoniker(self, pdwMksys)
proc GetComparisonData*(self: ptr IROTData, pbData: ptr uint8, cbMax: ULONG, pcbData: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetComparisonData(self, pbData, cbMax, pcbData)
proc Next*(self: ptr IEnumSTATSTG, celt: ULONG, rgelt: ptr STATSTG, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumSTATSTG, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumSTATSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumSTATSTG, ppenum: ptr ptr IEnumSTATSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc CreateStream*(self: ptr IStorage, pwcsName: ptr OLECHAR, grfMode: DWORD, reserved1: DWORD, reserved2: DWORD, ppstm: ptr ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateStream(self, pwcsName, grfMode, reserved1, reserved2, ppstm)
proc OpenStream*(self: ptr IStorage, pwcsName: ptr OLECHAR, reserved1: pointer, grfMode: DWORD, reserved2: DWORD, ppstm: ptr ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenStream(self, pwcsName, reserved1, grfMode, reserved2, ppstm)
proc CreateStorage*(self: ptr IStorage, pwcsName: ptr OLECHAR, grfMode: DWORD, reserved1: DWORD, reserved2: DWORD, ppstg: ptr ptr IStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateStorage(self, pwcsName, grfMode, reserved1, reserved2, ppstg)
proc OpenStorage*(self: ptr IStorage, pwcsName: ptr OLECHAR, pstgPriority: ptr IStorage, grfMode: DWORD, snbExclude: SNB, reserved: DWORD, ppstg: ptr ptr IStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenStorage(self, pwcsName, pstgPriority, grfMode, snbExclude, reserved, ppstg)
proc CopyTo*(self: ptr IStorage, ciidExclude: DWORD, rgiidExclude: ptr IID, snbExclude: SNB, pstgDest: ptr IStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyTo(self, ciidExclude, rgiidExclude, snbExclude, pstgDest)
proc MoveElementTo*(self: ptr IStorage, pwcsName: ptr OLECHAR, pstgDest: ptr IStorage, pwcsNewName: ptr OLECHAR, grfFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveElementTo(self, pwcsName, pstgDest, pwcsNewName, grfFlags)
proc Commit*(self: ptr IStorage, grfCommitFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self, grfCommitFlags)
proc Revert*(self: ptr IStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Revert(self)
proc EnumElements*(self: ptr IStorage, reserved1: DWORD, reserved2: pointer, reserved3: DWORD, ppenum: ptr ptr IEnumSTATSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumElements(self, reserved1, reserved2, reserved3, ppenum)
proc DestroyElement*(self: ptr IStorage, pwcsName: ptr OLECHAR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DestroyElement(self, pwcsName)
proc RenameElement*(self: ptr IStorage, pwcsOldName: ptr OLECHAR, pwcsNewName: ptr OLECHAR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RenameElement(self, pwcsOldName, pwcsNewName)
proc SetElementTimes*(self: ptr IStorage, pwcsName: ptr OLECHAR, pctime: ptr FILETIME, patime: ptr FILETIME, pmtime: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetElementTimes(self, pwcsName, pctime, patime, pmtime)
proc SetClass*(self: ptr IStorage, clsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetClass(self, clsid)
proc SetStateBits*(self: ptr IStorage, grfStateBits: DWORD, grfMask: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetStateBits(self, grfStateBits, grfMask)
proc Stat*(self: ptr IStorage, pstatstg: ptr STATSTG, grfStatFlag: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Stat(self, pstatstg, grfStatFlag)
proc IsDirty*(self: ptr IPersistFile): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDirty(self)
proc Load*(self: ptr IPersistFile, pszFileName: LPCOLESTR, dwMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, pszFileName, dwMode)
proc Save*(self: ptr IPersistFile, pszFileName: LPCOLESTR, fRemember: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, pszFileName, fRemember)
proc SaveCompleted*(self: ptr IPersistFile, pszFileName: LPCOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveCompleted(self, pszFileName)
proc GetCurFile*(self: ptr IPersistFile, ppszFileName: ptr LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurFile(self, ppszFileName)
proc IsDirty*(self: ptr IPersistStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDirty(self)
proc InitNew*(self: ptr IPersistStorage, pStg: ptr IStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitNew(self, pStg)
proc Load*(self: ptr IPersistStorage, pStg: ptr IStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, pStg)
proc Save*(self: ptr IPersistStorage, pStgSave: ptr IStorage, fSameAsLoad: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, pStgSave, fSameAsLoad)
proc SaveCompleted*(self: ptr IPersistStorage, pStgNew: ptr IStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveCompleted(self, pStgNew)
proc HandsOffStorage*(self: ptr IPersistStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandsOffStorage(self)
proc ReadAt*(self: ptr ILockBytes, ulOffset: ULARGE_INTEGER, pv: pointer, cb: ULONG, pcbRead: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReadAt(self, ulOffset, pv, cb, pcbRead)
proc WriteAt*(self: ptr ILockBytes, ulOffset: ULARGE_INTEGER, pv: pointer, cb: ULONG, pcbWritten: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WriteAt(self, ulOffset, pv, cb, pcbWritten)
proc Flush*(self: ptr ILockBytes): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Flush(self)
proc SetSize*(self: ptr ILockBytes, cb: ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSize(self, cb)
proc LockRegion*(self: ptr ILockBytes, libOffset: ULARGE_INTEGER, cb: ULARGE_INTEGER, dwLockType: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockRegion(self, libOffset, cb, dwLockType)
proc UnlockRegion*(self: ptr ILockBytes, libOffset: ULARGE_INTEGER, cb: ULARGE_INTEGER, dwLockType: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnlockRegion(self, libOffset, cb, dwLockType)
proc Stat*(self: ptr ILockBytes, pstatstg: ptr STATSTG, grfStatFlag: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Stat(self, pstatstg, grfStatFlag)
proc Next*(self: ptr IEnumFORMATETC, celt: ULONG, rgelt: ptr FORMATETC, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumFORMATETC, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumFORMATETC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumFORMATETC, ppenum: ptr ptr IEnumFORMATETC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc Next*(self: ptr IEnumSTATDATA, celt: ULONG, rgelt: ptr STATDATA, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumSTATDATA, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumSTATDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumSTATDATA, ppenum: ptr ptr IEnumSTATDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc SwitchToFile*(self: ptr IRootStorage, pszFile: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SwitchToFile(self, pszFile)
proc OnDataChange*(self: ptr IAdviseSink, pFormatetc: ptr FORMATETC, pStgmed: ptr STGMEDIUM): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDataChange(self, pFormatetc, pStgmed)
proc OnViewChange*(self: ptr IAdviseSink, dwAspect: DWORD, lindex: LONG): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnViewChange(self, dwAspect, lindex)
proc OnRename*(self: ptr IAdviseSink, pmk: ptr IMoniker): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnRename(self, pmk)
proc OnSave*(self: ptr IAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnSave(self)
proc OnClose*(self: ptr IAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnClose(self)
proc Begin_OnDataChange*(self: ptr AsyncIAdviseSink, pFormatetc: ptr FORMATETC, pStgmed: ptr STGMEDIUM): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_OnDataChange(self, pFormatetc, pStgmed)
proc Finish_OnDataChange*(self: ptr AsyncIAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_OnDataChange(self)
proc Begin_OnViewChange*(self: ptr AsyncIAdviseSink, dwAspect: DWORD, lindex: LONG): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_OnViewChange(self, dwAspect, lindex)
proc Finish_OnViewChange*(self: ptr AsyncIAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_OnViewChange(self)
proc Begin_OnRename*(self: ptr AsyncIAdviseSink, pmk: ptr IMoniker): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_OnRename(self, pmk)
proc Finish_OnRename*(self: ptr AsyncIAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_OnRename(self)
proc Begin_OnSave*(self: ptr AsyncIAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_OnSave(self)
proc Finish_OnSave*(self: ptr AsyncIAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_OnSave(self)
proc Begin_OnClose*(self: ptr AsyncIAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_OnClose(self)
proc Finish_OnClose*(self: ptr AsyncIAdviseSink): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_OnClose(self)
proc OnLinkSrcChange*(self: ptr IAdviseSink2, pmk: ptr IMoniker): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnLinkSrcChange(self, pmk)
proc Begin_OnLinkSrcChange*(self: ptr AsyncIAdviseSink2, pmk: ptr IMoniker): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Begin_OnLinkSrcChange(self, pmk)
proc Finish_OnLinkSrcChange*(self: ptr AsyncIAdviseSink2): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Finish_OnLinkSrcChange(self)
proc GetData*(self: ptr IDataObject, pformatetcIn: ptr FORMATETC, pmedium: ptr STGMEDIUM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetData(self, pformatetcIn, pmedium)
proc GetDataHere*(self: ptr IDataObject, pformatetc: ptr FORMATETC, pmedium: ptr STGMEDIUM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDataHere(self, pformatetc, pmedium)
proc QueryGetData*(self: ptr IDataObject, pformatetc: ptr FORMATETC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryGetData(self, pformatetc)
proc GetCanonicalFormatEtc*(self: ptr IDataObject, pformatectIn: ptr FORMATETC, pformatetcOut: ptr FORMATETC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCanonicalFormatEtc(self, pformatectIn, pformatetcOut)
proc SetData*(self: ptr IDataObject, pformatetc: ptr FORMATETC, pmedium: ptr STGMEDIUM, fRelease: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetData(self, pformatetc, pmedium, fRelease)
proc EnumFormatEtc*(self: ptr IDataObject, dwDirection: DWORD, ppenumFormatEtc: ptr ptr IEnumFORMATETC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumFormatEtc(self, dwDirection, ppenumFormatEtc)
proc DAdvise*(self: ptr IDataObject, pformatetc: ptr FORMATETC, advf: DWORD, pAdvSink: ptr IAdviseSink, pdwConnection: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DAdvise(self, pformatetc, advf, pAdvSink, pdwConnection)
proc DUnadvise*(self: ptr IDataObject, dwConnection: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DUnadvise(self, dwConnection)
proc EnumDAdvise*(self: ptr IDataObject, ppenumAdvise: ptr ptr IEnumSTATDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumDAdvise(self, ppenumAdvise)
proc Advise*(self: ptr IDataAdviseHolder, pDataObject: ptr IDataObject, pFetc: ptr FORMATETC, advf: DWORD, pAdvise: ptr IAdviseSink, pdwConnection: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, pDataObject, pFetc, advf, pAdvise, pdwConnection)
proc Unadvise*(self: ptr IDataAdviseHolder, dwConnection: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwConnection)
proc EnumAdvise*(self: ptr IDataAdviseHolder, ppenumAdvise: ptr ptr IEnumSTATDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumAdvise(self, ppenumAdvise)
proc SendOnDataChange*(self: ptr IDataAdviseHolder, pDataObject: ptr IDataObject, dwReserved: DWORD, advf: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendOnDataChange(self, pDataObject, dwReserved, advf)
proc HandleInComingCall*(self: ptr IMessageFilter, dwCallType: DWORD, htaskCaller: HTASK, dwTickCount: DWORD, lpInterfaceInfo: LPINTERFACEINFO): DWORD {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleInComingCall(self, dwCallType, htaskCaller, dwTickCount, lpInterfaceInfo)
proc RetryRejectedCall*(self: ptr IMessageFilter, htaskCallee: HTASK, dwTickCount: DWORD, dwRejectType: DWORD): DWORD {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RetryRejectedCall(self, htaskCallee, dwTickCount, dwRejectType)
proc MessagePending*(self: ptr IMessageFilter, htaskCallee: HTASK, dwTickCount: DWORD, dwPendingType: DWORD): DWORD {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MessagePending(self, htaskCallee, dwTickCount, dwPendingType)
proc GetClassObject*(self: ptr IClassActivator, rclsid: REFCLSID, dwClassContext: DWORD, locale: LCID, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClassObject(self, rclsid, dwClassContext, locale, riid, ppv)
proc FillAppend*(self: ptr IFillLockBytes, pv: pointer, cb: ULONG, pcbWritten: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FillAppend(self, pv, cb, pcbWritten)
proc FillAt*(self: ptr IFillLockBytes, ulOffset: ULARGE_INTEGER, pv: pointer, cb: ULONG, pcbWritten: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FillAt(self, ulOffset, pv, cb, pcbWritten)
proc SetFillSize*(self: ptr IFillLockBytes, ulSize: ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFillSize(self, ulSize)
proc Terminate*(self: ptr IFillLockBytes, bCanceled: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Terminate(self, bCanceled)
proc OnProgress*(self: ptr IProgressNotify, dwProgressCurrent: DWORD, dwProgressMaximum: DWORD, fAccurate: WINBOOL, fOwner: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnProgress(self, dwProgressCurrent, dwProgressMaximum, fAccurate, fOwner)
proc LayoutScript*(self: ptr ILayoutStorage, pStorageLayout: ptr StorageLayout, nEntries: DWORD, glfInterleavedFlag: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LayoutScript(self, pStorageLayout, nEntries, glfInterleavedFlag)
proc BeginMonitor*(self: ptr ILayoutStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginMonitor(self)
proc EndMonitor*(self: ptr ILayoutStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndMonitor(self)
proc ReLayoutDocfile*(self: ptr ILayoutStorage, pwcsNewDfName: ptr OLECHAR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReLayoutDocfile(self, pwcsNewDfName)
proc ReLayoutDocfileOnILockBytes*(self: ptr ILayoutStorage, pILockBytes: ptr ILockBytes): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReLayoutDocfileOnILockBytes(self, pILockBytes)
proc Lock*(self: ptr IBlockingLock, dwTimeout: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Lock(self, dwTimeout)
proc Unlock*(self: ptr IBlockingLock): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unlock(self)
proc SuppressChanges*(self: ptr ITimeAndNoticeControl, res1: DWORD, res2: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SuppressChanges(self, res1, res2)
proc CreateStorageEx*(self: ptr IOplockStorage, pwcsName: LPCWSTR, grfMode: DWORD, stgfmt: DWORD, grfAttrs: DWORD, riid: REFIID, ppstgOpen: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateStorageEx(self, pwcsName, grfMode, stgfmt, grfAttrs, riid, ppstgOpen)
proc OpenStorageEx*(self: ptr IOplockStorage, pwcsName: LPCWSTR, grfMode: DWORD, stgfmt: DWORD, grfAttrs: DWORD, riid: REFIID, ppstgOpen: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenStorageEx(self, pwcsName, grfMode, stgfmt, grfAttrs, riid, ppstgOpen)
proc WaitForWriteAccess*(self: ptr IDirectWriterLock, dwTimeout: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WaitForWriteAccess(self, dwTimeout)
proc ReleaseWriteAccess*(self: ptr IDirectWriterLock): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseWriteAccess(self)
proc HaveWriteAccess*(self: ptr IDirectWriterLock): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HaveWriteAccess(self)
proc AsyncGetClassBits*(self: ptr IUrlMon, rclsid: REFCLSID, pszTYPE: LPCWSTR, pszExt: LPCWSTR, dwFileVersionMS: DWORD, dwFileVersionLS: DWORD, pszCodeBase: LPCWSTR, pbc: ptr IBindCtx, dwClassContext: DWORD, riid: REFIID, flags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AsyncGetClassBits(self, rclsid, pszTYPE, pszExt, dwFileVersionMS, dwFileVersionLS, pszCodeBase, pbc, dwClassContext, riid, flags)
proc AllowForegroundTransfer*(self: ptr IForegroundTransfer, lpvReserved: pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AllowForegroundTransfer(self, lpvReserved)
proc ExtractThumbnail*(self: ptr IThumbnailExtractor, pStg: ptr IStorage, ulLength: ULONG, ulHeight: ULONG, pulOutputLength: ptr ULONG, pulOutputHeight: ptr ULONG, phOutputBitmap: ptr HBITMAP): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExtractThumbnail(self, pStg, ulLength, ulHeight, pulOutputLength, pulOutputHeight, phOutputBitmap)
proc OnFileUpdated*(self: ptr IThumbnailExtractor, pStg: ptr IStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnFileUpdated(self, pStg)
proc Dummy*(self: ptr IDummyHICONIncluder, h1: HICON, h2: HDC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Dummy(self, h1, h2)
proc AddRefOnProcess*(self: ptr IProcessLock): ULONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddRefOnProcess(self)
proc ReleaseRefOnProcess*(self: ptr IProcessLock): ULONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseRefOnProcess(self)
proc Init*(self: ptr ISurrogateService, rguidProcessID: REFGUID, pProcessLock: ptr IProcessLock, pfApplicationAware: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Init(self, rguidProcessID, pProcessLock, pfApplicationAware)
proc ApplicationLaunch*(self: ptr ISurrogateService, rguidApplID: REFGUID, appType: ApplicationType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplicationLaunch(self, rguidApplID, appType)
proc ApplicationFree*(self: ptr ISurrogateService, rguidApplID: REFGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplicationFree(self, rguidApplID)
proc CatalogRefresh*(self: ptr ISurrogateService, ulReserved: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CatalogRefresh(self, ulReserved)
proc ProcessShutdown*(self: ptr ISurrogateService, shutdownType: ShutdownType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProcessShutdown(self, shutdownType)
proc PreInitialize*(self: ptr IInitializeSpy, dwCoInit: DWORD, dwCurThreadAptRefs: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreInitialize(self, dwCoInit, dwCurThreadAptRefs)
proc PostInitialize*(self: ptr IInitializeSpy, hrCoInit: HRESULT, dwCoInit: DWORD, dwNewThreadAptRefs: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostInitialize(self, hrCoInit, dwCoInit, dwNewThreadAptRefs)
proc PreUninitialize*(self: ptr IInitializeSpy, dwCurThreadAptRefs: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreUninitialize(self, dwCurThreadAptRefs)
proc PostUninitialize*(self: ptr IInitializeSpy, dwNewThreadAptRefs: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostUninitialize(self, dwNewThreadAptRefs)
proc OnUninitialize*(self: ptr IApartmentShutdown, ui64ApartmentIdentifier: UINT64): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnUninitialize(self, ui64ApartmentIdentifier)
proc SetGuid*(self: ptr ICreateTypeInfo, guid: REFGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGuid(self, guid)
proc SetTypeFlags*(self: ptr ICreateTypeInfo, uTypeFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTypeFlags(self, uTypeFlags)
proc SetDocString*(self: ptr ICreateTypeInfo, pStrDoc: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDocString(self, pStrDoc)
proc SetHelpContext*(self: ptr ICreateTypeInfo, dwHelpContext: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHelpContext(self, dwHelpContext)
proc SetVersion*(self: ptr ICreateTypeInfo, wMajorVerNum: WORD, wMinorVerNum: WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVersion(self, wMajorVerNum, wMinorVerNum)
proc AddRefTypeInfo*(self: ptr ICreateTypeInfo, pTInfo: ptr ITypeInfo, phRefType: ptr HREFTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddRefTypeInfo(self, pTInfo, phRefType)
proc AddFuncDesc*(self: ptr ICreateTypeInfo, index: UINT, pFuncDesc: ptr FUNCDESC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddFuncDesc(self, index, pFuncDesc)
proc AddImplType*(self: ptr ICreateTypeInfo, index: UINT, hRefType: HREFTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddImplType(self, index, hRefType)
proc SetImplTypeFlags*(self: ptr ICreateTypeInfo, index: UINT, implTypeFlags: INT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetImplTypeFlags(self, index, implTypeFlags)
proc SetAlignment*(self: ptr ICreateTypeInfo, cbAlignment: WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAlignment(self, cbAlignment)
proc SetSchema*(self: ptr ICreateTypeInfo, pStrSchema: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSchema(self, pStrSchema)
proc AddVarDesc*(self: ptr ICreateTypeInfo, index: UINT, pVarDesc: ptr VARDESC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddVarDesc(self, index, pVarDesc)
proc SetFuncAndParamNames*(self: ptr ICreateTypeInfo, index: UINT, rgszNames: ptr LPOLESTR, cNames: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFuncAndParamNames(self, index, rgszNames, cNames)
proc SetVarName*(self: ptr ICreateTypeInfo, index: UINT, szName: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVarName(self, index, szName)
proc SetTypeDescAlias*(self: ptr ICreateTypeInfo, pTDescAlias: ptr TYPEDESC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTypeDescAlias(self, pTDescAlias)
proc DefineFuncAsDllEntry*(self: ptr ICreateTypeInfo, index: UINT, szDllName: LPOLESTR, szProcName: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineFuncAsDllEntry(self, index, szDllName, szProcName)
proc SetFuncDocString*(self: ptr ICreateTypeInfo, index: UINT, szDocString: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFuncDocString(self, index, szDocString)
proc SetVarDocString*(self: ptr ICreateTypeInfo, index: UINT, szDocString: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVarDocString(self, index, szDocString)
proc SetFuncHelpContext*(self: ptr ICreateTypeInfo, index: UINT, dwHelpContext: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFuncHelpContext(self, index, dwHelpContext)
proc SetVarHelpContext*(self: ptr ICreateTypeInfo, index: UINT, dwHelpContext: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVarHelpContext(self, index, dwHelpContext)
proc SetMops*(self: ptr ICreateTypeInfo, index: UINT, bstrMops: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMops(self, index, bstrMops)
proc SetTypeIdldesc*(self: ptr ICreateTypeInfo, pIdlDesc: ptr IDLDESC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTypeIdldesc(self, pIdlDesc)
proc LayOut*(self: ptr ICreateTypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LayOut(self)
proc DeleteFuncDesc*(self: ptr ICreateTypeInfo2, index: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteFuncDesc(self, index)
proc DeleteFuncDescByMemId*(self: ptr ICreateTypeInfo2, memid: MEMBERID, invKind: INVOKEKIND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteFuncDescByMemId(self, memid, invKind)
proc DeleteVarDesc*(self: ptr ICreateTypeInfo2, index: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteVarDesc(self, index)
proc DeleteVarDescByMemId*(self: ptr ICreateTypeInfo2, memid: MEMBERID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteVarDescByMemId(self, memid)
proc DeleteImplType*(self: ptr ICreateTypeInfo2, index: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteImplType(self, index)
proc SetCustData*(self: ptr ICreateTypeInfo2, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCustData(self, guid, pVarVal)
proc SetFuncCustData*(self: ptr ICreateTypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFuncCustData(self, index, guid, pVarVal)
proc SetParamCustData*(self: ptr ICreateTypeInfo2, indexFunc: UINT, indexParam: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetParamCustData(self, indexFunc, indexParam, guid, pVarVal)
proc SetVarCustData*(self: ptr ICreateTypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVarCustData(self, index, guid, pVarVal)
proc SetImplTypeCustData*(self: ptr ICreateTypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetImplTypeCustData(self, index, guid, pVarVal)
proc SetHelpStringContext*(self: ptr ICreateTypeInfo2, dwHelpStringContext: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHelpStringContext(self, dwHelpStringContext)
proc SetFuncHelpStringContext*(self: ptr ICreateTypeInfo2, index: UINT, dwHelpStringContext: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFuncHelpStringContext(self, index, dwHelpStringContext)
proc SetVarHelpStringContext*(self: ptr ICreateTypeInfo2, index: UINT, dwHelpStringContext: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVarHelpStringContext(self, index, dwHelpStringContext)
proc Invalidate*(self: ptr ICreateTypeInfo2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invalidate(self)
proc SetName*(self: ptr ICreateTypeInfo2, szName: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetName(self, szName)
proc CreateTypeInfo*(self: ptr ICreateTypeLib, szName: LPOLESTR, tkind: TYPEKIND, ppCTInfo: ptr ptr ICreateTypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateTypeInfo(self, szName, tkind, ppCTInfo)
proc SetName*(self: ptr ICreateTypeLib, szName: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetName(self, szName)
proc SetVersion*(self: ptr ICreateTypeLib, wMajorVerNum: WORD, wMinorVerNum: WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVersion(self, wMajorVerNum, wMinorVerNum)
proc SetGuid*(self: ptr ICreateTypeLib, guid: REFGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGuid(self, guid)
proc SetDocString*(self: ptr ICreateTypeLib, szDoc: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDocString(self, szDoc)
proc SetHelpFileName*(self: ptr ICreateTypeLib, szHelpFileName: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHelpFileName(self, szHelpFileName)
proc SetHelpContext*(self: ptr ICreateTypeLib, dwHelpContext: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHelpContext(self, dwHelpContext)
proc SetLcid*(self: ptr ICreateTypeLib, lcid: LCID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLcid(self, lcid)
proc SetLibFlags*(self: ptr ICreateTypeLib, uLibFlags: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLibFlags(self, uLibFlags)
proc SaveAllChanges*(self: ptr ICreateTypeLib): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveAllChanges(self)
proc DeleteTypeInfo*(self: ptr ICreateTypeLib2, szName: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteTypeInfo(self, szName)
proc SetCustData*(self: ptr ICreateTypeLib2, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCustData(self, guid, pVarVal)
proc SetHelpStringContext*(self: ptr ICreateTypeLib2, dwHelpStringContext: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHelpStringContext(self, dwHelpStringContext)
proc SetHelpStringDll*(self: ptr ICreateTypeLib2, szFileName: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHelpStringDll(self, szFileName)
proc GetTypeInfoCount*(self: ptr IDispatch, pctinfo: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfoCount(self, pctinfo)
proc GetTypeInfo*(self: ptr IDispatch, iTInfo: UINT, lcid: LCID, ppTInfo: ptr ptr ITypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfo(self, iTInfo, lcid, ppTInfo)
proc GetIDsOfNames*(self: ptr IDispatch, riid: REFIID, rgszNames: ptr LPOLESTR, cNames: UINT, lcid: LCID, rgDispId: ptr DISPID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDsOfNames(self, riid, rgszNames, cNames, lcid, rgDispId)
proc Invoke*(self: ptr IDispatch, dispIdMember: DISPID, riid: REFIID, lcid: LCID, wFlags: WORD, pDispParams: ptr DISPPARAMS, pVarResult: ptr VARIANT, pExcepInfo: ptr EXCEPINFO, puArgErr: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
proc Next*(self: ptr IEnumVARIANT, celt: ULONG, rgVar: ptr VARIANT, pCeltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgVar, pCeltFetched)
proc Skip*(self: ptr IEnumVARIANT, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumVARIANT, ppEnum: ptr ptr IEnumVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc Bind*(self: ptr ITypeComp, szName: LPOLESTR, lHashVal: ULONG, wFlags: WORD, ppTInfo: ptr ptr ITypeInfo, pDescKind: ptr DESCKIND, pBindPtr: ptr BINDPTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Bind(self, szName, lHashVal, wFlags, ppTInfo, pDescKind, pBindPtr)
proc BindType*(self: ptr ITypeComp, szName: LPOLESTR, lHashVal: ULONG, ppTInfo: ptr ptr ITypeInfo, ppTComp: ptr ptr ITypeComp): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindType(self, szName, lHashVal, ppTInfo, ppTComp)
proc GetTypeAttr*(self: ptr ITypeInfo, ppTypeAttr: ptr ptr TYPEATTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeAttr(self, ppTypeAttr)
proc GetTypeComp*(self: ptr ITypeInfo, ppTComp: ptr ptr ITypeComp): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeComp(self, ppTComp)
proc GetFuncDesc*(self: ptr ITypeInfo, index: UINT, ppFuncDesc: ptr ptr FUNCDESC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFuncDesc(self, index, ppFuncDesc)
proc GetVarDesc*(self: ptr ITypeInfo, index: UINT, ppVarDesc: ptr ptr VARDESC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVarDesc(self, index, ppVarDesc)
proc GetNames*(self: ptr ITypeInfo, memid: MEMBERID, rgBstrNames: ptr BSTR, cMaxNames: UINT, pcNames: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNames(self, memid, rgBstrNames, cMaxNames, pcNames)
proc GetRefTypeOfImplType*(self: ptr ITypeInfo, index: UINT, pRefType: ptr HREFTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRefTypeOfImplType(self, index, pRefType)
proc GetImplTypeFlags*(self: ptr ITypeInfo, index: UINT, pImplTypeFlags: ptr INT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImplTypeFlags(self, index, pImplTypeFlags)
proc GetIDsOfNames*(self: ptr ITypeInfo, rgszNames: ptr LPOLESTR, cNames: UINT, pMemId: ptr MEMBERID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDsOfNames(self, rgszNames, cNames, pMemId)
proc Invoke*(self: ptr ITypeInfo, pvInstance: PVOID, memid: MEMBERID, wFlags: WORD, pDispParams: ptr DISPPARAMS, pVarResult: ptr VARIANT, pExcepInfo: ptr EXCEPINFO, puArgErr: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self, pvInstance, memid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
proc GetDocumentation*(self: ptr ITypeInfo, memid: MEMBERID, pBstrName: ptr BSTR, pBstrDocString: ptr BSTR, pdwHelpContext: ptr DWORD, pBstrHelpFile: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDocumentation(self, memid, pBstrName, pBstrDocString, pdwHelpContext, pBstrHelpFile)
proc GetDllEntry*(self: ptr ITypeInfo, memid: MEMBERID, invKind: INVOKEKIND, pBstrDllName: ptr BSTR, pBstrName: ptr BSTR, pwOrdinal: ptr WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDllEntry(self, memid, invKind, pBstrDllName, pBstrName, pwOrdinal)
proc GetRefTypeInfo*(self: ptr ITypeInfo, hRefType: HREFTYPE, ppTInfo: ptr ptr ITypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRefTypeInfo(self, hRefType, ppTInfo)
proc AddressOfMember*(self: ptr ITypeInfo, memid: MEMBERID, invKind: INVOKEKIND, ppv: ptr PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddressOfMember(self, memid, invKind, ppv)
proc CreateInstance*(self: ptr ITypeInfo, pUnkOuter: ptr IUnknown, riid: REFIID, ppvObj: ptr PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance(self, pUnkOuter, riid, ppvObj)
proc GetMops*(self: ptr ITypeInfo, memid: MEMBERID, pBstrMops: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMops(self, memid, pBstrMops)
proc GetContainingTypeLib*(self: ptr ITypeInfo, ppTLib: ptr ptr ITypeLib, pIndex: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContainingTypeLib(self, ppTLib, pIndex)
proc ReleaseTypeAttr*(self: ptr ITypeInfo, pTypeAttr: ptr TYPEATTR): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseTypeAttr(self, pTypeAttr)
proc ReleaseFuncDesc*(self: ptr ITypeInfo, pFuncDesc: ptr FUNCDESC): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseFuncDesc(self, pFuncDesc)
proc ReleaseVarDesc*(self: ptr ITypeInfo, pVarDesc: ptr VARDESC): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseVarDesc(self, pVarDesc)
proc GetTypeKind*(self: ptr ITypeInfo2, pTypeKind: ptr TYPEKIND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeKind(self, pTypeKind)
proc GetTypeFlags*(self: ptr ITypeInfo2, pTypeFlags: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeFlags(self, pTypeFlags)
proc GetFuncIndexOfMemId*(self: ptr ITypeInfo2, memid: MEMBERID, invKind: INVOKEKIND, pFuncIndex: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFuncIndexOfMemId(self, memid, invKind, pFuncIndex)
proc GetVarIndexOfMemId*(self: ptr ITypeInfo2, memid: MEMBERID, pVarIndex: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVarIndexOfMemId(self, memid, pVarIndex)
proc GetCustData*(self: ptr ITypeInfo2, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCustData(self, guid, pVarVal)
proc GetFuncCustData*(self: ptr ITypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFuncCustData(self, index, guid, pVarVal)
proc GetParamCustData*(self: ptr ITypeInfo2, indexFunc: UINT, indexParam: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetParamCustData(self, indexFunc, indexParam, guid, pVarVal)
proc GetVarCustData*(self: ptr ITypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVarCustData(self, index, guid, pVarVal)
proc GetImplTypeCustData*(self: ptr ITypeInfo2, index: UINT, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImplTypeCustData(self, index, guid, pVarVal)
proc GetDocumentation2*(self: ptr ITypeInfo2, memid: MEMBERID, lcid: LCID, pbstrHelpString: ptr BSTR, pdwHelpStringContext: ptr DWORD, pbstrHelpStringDll: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDocumentation2(self, memid, lcid, pbstrHelpString, pdwHelpStringContext, pbstrHelpStringDll)
proc GetAllCustData*(self: ptr ITypeInfo2, pCustData: ptr CUSTDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAllCustData(self, pCustData)
proc GetAllFuncCustData*(self: ptr ITypeInfo2, index: UINT, pCustData: ptr CUSTDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAllFuncCustData(self, index, pCustData)
proc GetAllParamCustData*(self: ptr ITypeInfo2, indexFunc: UINT, indexParam: UINT, pCustData: ptr CUSTDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAllParamCustData(self, indexFunc, indexParam, pCustData)
proc GetAllVarCustData*(self: ptr ITypeInfo2, index: UINT, pCustData: ptr CUSTDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAllVarCustData(self, index, pCustData)
proc GetAllImplTypeCustData*(self: ptr ITypeInfo2, index: UINT, pCustData: ptr CUSTDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAllImplTypeCustData(self, index, pCustData)
proc GetTypeInfoCount*(self: ptr ITypeLib): UINT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfoCount(self)
proc GetTypeInfo*(self: ptr ITypeLib, index: UINT, ppTInfo: ptr ptr ITypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfo(self, index, ppTInfo)
proc GetTypeInfoType*(self: ptr ITypeLib, index: UINT, pTKind: ptr TYPEKIND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfoType(self, index, pTKind)
proc GetTypeInfoOfGuid*(self: ptr ITypeLib, guid: REFGUID, ppTinfo: ptr ptr ITypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfoOfGuid(self, guid, ppTinfo)
proc GetLibAttr*(self: ptr ITypeLib, ppTLibAttr: ptr ptr TLIBATTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLibAttr(self, ppTLibAttr)
proc GetTypeComp*(self: ptr ITypeLib, ppTComp: ptr ptr ITypeComp): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeComp(self, ppTComp)
proc GetDocumentation*(self: ptr ITypeLib, index: INT, pBstrName: ptr BSTR, pBstrDocString: ptr BSTR, pdwHelpContext: ptr DWORD, pBstrHelpFile: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDocumentation(self, index, pBstrName, pBstrDocString, pdwHelpContext, pBstrHelpFile)
proc IsName*(self: ptr ITypeLib, szNameBuf: LPOLESTR, lHashVal: ULONG, pfName: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsName(self, szNameBuf, lHashVal, pfName)
proc FindName*(self: ptr ITypeLib, szNameBuf: LPOLESTR, lHashVal: ULONG, ppTInfo: ptr ptr ITypeInfo, rgMemId: ptr MEMBERID, pcFound: ptr USHORT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindName(self, szNameBuf, lHashVal, ppTInfo, rgMemId, pcFound)
proc ReleaseTLibAttr*(self: ptr ITypeLib, pTLibAttr: ptr TLIBATTR): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseTLibAttr(self, pTLibAttr)
proc GetCustData*(self: ptr ITypeLib2, guid: REFGUID, pVarVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCustData(self, guid, pVarVal)
proc GetLibStatistics*(self: ptr ITypeLib2, pcUniqueNames: ptr ULONG, pcchUniqueNames: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLibStatistics(self, pcUniqueNames, pcchUniqueNames)
proc GetDocumentation2*(self: ptr ITypeLib2, index: INT, lcid: LCID, pbstrHelpString: ptr BSTR, pdwHelpStringContext: ptr DWORD, pbstrHelpStringDll: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDocumentation2(self, index, lcid, pbstrHelpString, pdwHelpStringContext, pbstrHelpStringDll)
proc GetAllCustData*(self: ptr ITypeLib2, pCustData: ptr CUSTDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAllCustData(self, pCustData)
proc RequestTypeChange*(self: ptr ITypeChangeEvents, changeKind: CHANGEKIND, pTInfoBefore: ptr ITypeInfo, pStrName: LPOLESTR, pfCancel: ptr INT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestTypeChange(self, changeKind, pTInfoBefore, pStrName, pfCancel)
proc AfterTypeChange*(self: ptr ITypeChangeEvents, changeKind: CHANGEKIND, pTInfoAfter: ptr ITypeInfo, pStrName: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AfterTypeChange(self, changeKind, pTInfoAfter, pStrName)
proc GetGUID*(self: ptr IErrorInfo, pGUID: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGUID(self, pGUID)
proc GetSource*(self: ptr IErrorInfo, pBstrSource: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSource(self, pBstrSource)
proc GetDescription*(self: ptr IErrorInfo, pBstrDescription: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescription(self, pBstrDescription)
proc GetHelpFile*(self: ptr IErrorInfo, pBstrHelpFile: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHelpFile(self, pBstrHelpFile)
proc GetHelpContext*(self: ptr IErrorInfo, pdwHelpContext: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHelpContext(self, pdwHelpContext)
proc SetGUID*(self: ptr ICreateErrorInfo, rguid: REFGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGUID(self, rguid)
proc SetSource*(self: ptr ICreateErrorInfo, szSource: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSource(self, szSource)
proc SetDescription*(self: ptr ICreateErrorInfo, szDescription: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDescription(self, szDescription)
proc SetHelpFile*(self: ptr ICreateErrorInfo, szHelpFile: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHelpFile(self, szHelpFile)
proc SetHelpContext*(self: ptr ICreateErrorInfo, dwHelpContext: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHelpContext(self, dwHelpContext)
proc InterfaceSupportsErrorInfo*(self: ptr ISupportErrorInfo, riid: REFIID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InterfaceSupportsErrorInfo(self, riid)
proc CreateFromTypeInfo*(self: ptr ITypeFactory, pTypeInfo: ptr ITypeInfo, riid: REFIID, ppv: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateFromTypeInfo(self, pTypeInfo, riid, ppv)
proc mSize*(self: ptr ITypeMarshal, pvType: PVOID, dwDestContext: DWORD, pvDestContext: PVOID, pSize: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Size(self, pvType, dwDestContext, pvDestContext, pSize)
proc Marshal*(self: ptr ITypeMarshal, pvType: PVOID, dwDestContext: DWORD, pvDestContext: PVOID, cbBufferLength: ULONG, pBuffer: ptr BYTE, pcbWritten: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Marshal(self, pvType, dwDestContext, pvDestContext, cbBufferLength, pBuffer, pcbWritten)
proc Unmarshal*(self: ptr ITypeMarshal, pvType: PVOID, dwFlags: DWORD, cbBufferLength: ULONG, pBuffer: ptr BYTE, pcbRead: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unmarshal(self, pvType, dwFlags, cbBufferLength, pBuffer, pcbRead)
proc Free*(self: ptr ITypeMarshal, pvType: PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Free(self, pvType)
proc RecordInit*(self: ptr IRecordInfo, pvNew: PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RecordInit(self, pvNew)
proc RecordClear*(self: ptr IRecordInfo, pvExisting: PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RecordClear(self, pvExisting)
proc RecordCopy*(self: ptr IRecordInfo, pvExisting: PVOID, pvNew: PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RecordCopy(self, pvExisting, pvNew)
proc GetGuid*(self: ptr IRecordInfo, pguid: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGuid(self, pguid)
proc GetName*(self: ptr IRecordInfo, pbstrName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetName(self, pbstrName)
proc GetSize*(self: ptr IRecordInfo, pcbSize: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSize(self, pcbSize)
proc GetTypeInfo*(self: ptr IRecordInfo, ppTypeInfo: ptr ptr ITypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfo(self, ppTypeInfo)
proc GetField*(self: ptr IRecordInfo, pvData: PVOID, szFieldName: LPCOLESTR, pvarField: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetField(self, pvData, szFieldName, pvarField)
proc GetFieldNoCopy*(self: ptr IRecordInfo, pvData: PVOID, szFieldName: LPCOLESTR, pvarField: ptr VARIANT, ppvDataCArray: ptr PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFieldNoCopy(self, pvData, szFieldName, pvarField, ppvDataCArray)
proc PutField*(self: ptr IRecordInfo, wFlags: ULONG, pvData: PVOID, szFieldName: LPCOLESTR, pvarField: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PutField(self, wFlags, pvData, szFieldName, pvarField)
proc PutFieldNoCopy*(self: ptr IRecordInfo, wFlags: ULONG, pvData: PVOID, szFieldName: LPCOLESTR, pvarField: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PutFieldNoCopy(self, wFlags, pvData, szFieldName, pvarField)
proc GetFieldNames*(self: ptr IRecordInfo, pcNames: ptr ULONG, rgBstrNames: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFieldNames(self, pcNames, rgBstrNames)
proc IsMatchingType*(self: ptr IRecordInfo, pRecordInfo: ptr IRecordInfo): WINBOOL {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsMatchingType(self, pRecordInfo)
proc RecordCreate*(self: ptr IRecordInfo): PVOID {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RecordCreate(self)
proc RecordCreateCopy*(self: ptr IRecordInfo, pvSource: PVOID, ppvDest: ptr PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RecordCreateCopy(self, pvSource, ppvDest)
proc RecordDestroy*(self: ptr IRecordInfo, pvRecord: PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RecordDestroy(self, pvRecord)
proc AddError*(self: ptr IErrorLog, pszPropName: LPCOLESTR, pExcepInfo: ptr EXCEPINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddError(self, pszPropName, pExcepInfo)
proc Read*(self: ptr IPropertyBag, pszPropName: LPCOLESTR, pVar: ptr VARIANT, pErrorLog: ptr IErrorLog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Read(self, pszPropName, pVar, pErrorLog)
proc Write*(self: ptr IPropertyBag, pszPropName: LPCOLESTR, pVar: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Write(self, pszPropName, pVar)
proc Advise*(self: ptr IOleAdviseHolder, pAdvise: ptr IAdviseSink, pdwConnection: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, pAdvise, pdwConnection)
proc Unadvise*(self: ptr IOleAdviseHolder, dwConnection: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwConnection)
proc EnumAdvise*(self: ptr IOleAdviseHolder, ppenumAdvise: ptr ptr IEnumSTATDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumAdvise(self, ppenumAdvise)
proc SendOnRename*(self: ptr IOleAdviseHolder, pmk: ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendOnRename(self, pmk)
proc SendOnSave*(self: ptr IOleAdviseHolder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendOnSave(self)
proc SendOnClose*(self: ptr IOleAdviseHolder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SendOnClose(self)
proc Cache*(self: ptr IOleCache, pformatetc: ptr FORMATETC, advf: DWORD, pdwConnection: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Cache(self, pformatetc, advf, pdwConnection)
proc Uncache*(self: ptr IOleCache, dwConnection: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Uncache(self, dwConnection)
proc EnumCache*(self: ptr IOleCache, ppenumSTATDATA: ptr ptr IEnumSTATDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumCache(self, ppenumSTATDATA)
proc InitCache*(self: ptr IOleCache, pDataObject: ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitCache(self, pDataObject)
proc SetData*(self: ptr IOleCache, pformatetc: ptr FORMATETC, pmedium: ptr STGMEDIUM, fRelease: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetData(self, pformatetc, pmedium, fRelease)
proc UpdateCache*(self: ptr IOleCache2, pDataObject: LPDATAOBJECT, grfUpdf: DWORD, pReserved: LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UpdateCache(self, pDataObject, grfUpdf, pReserved)
proc DiscardCache*(self: ptr IOleCache2, dwDiscardOptions: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DiscardCache(self, dwDiscardOptions)
proc OnRun*(self: ptr IOleCacheControl, pDataObject: LPDATAOBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnRun(self, pDataObject)
proc OnStop*(self: ptr IOleCacheControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnStop(self)
proc ParseDisplayName*(self: ptr IParseDisplayName, pbc: ptr IBindCtx, pszDisplayName: LPOLESTR, pchEaten: ptr ULONG, ppmkOut: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseDisplayName(self, pbc, pszDisplayName, pchEaten, ppmkOut)
proc EnumObjects*(self: ptr IOleContainer, grfFlags: DWORD, ppenum: ptr ptr IEnumUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumObjects(self, grfFlags, ppenum)
proc LockContainer*(self: ptr IOleContainer, fLock: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockContainer(self, fLock)
proc SaveObject*(self: ptr IOleClientSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveObject(self)
proc GetMoniker*(self: ptr IOleClientSite, dwAssign: DWORD, dwWhichMoniker: DWORD, ppmk: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMoniker(self, dwAssign, dwWhichMoniker, ppmk)
proc GetContainer*(self: ptr IOleClientSite, ppContainer: ptr ptr IOleContainer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContainer(self, ppContainer)
proc ShowObject*(self: ptr IOleClientSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowObject(self)
proc OnShowWindow*(self: ptr IOleClientSite, fShow: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnShowWindow(self, fShow)
proc RequestNewObjectLayout*(self: ptr IOleClientSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestNewObjectLayout(self)
proc SetClientSite*(self: ptr IOleObject, pClientSite: ptr IOleClientSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetClientSite(self, pClientSite)
proc GetClientSite*(self: ptr IOleObject, ppClientSite: ptr ptr IOleClientSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClientSite(self, ppClientSite)
proc SetHostNames*(self: ptr IOleObject, szContainerApp: LPCOLESTR, szContainerObj: LPCOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHostNames(self, szContainerApp, szContainerObj)
proc Close*(self: ptr IOleObject, dwSaveOption: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Close(self, dwSaveOption)
proc SetMoniker*(self: ptr IOleObject, dwWhichMoniker: DWORD, pmk: ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMoniker(self, dwWhichMoniker, pmk)
proc GetMoniker*(self: ptr IOleObject, dwAssign: DWORD, dwWhichMoniker: DWORD, ppmk: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMoniker(self, dwAssign, dwWhichMoniker, ppmk)
proc InitFromData*(self: ptr IOleObject, pDataObject: ptr IDataObject, fCreation: WINBOOL, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitFromData(self, pDataObject, fCreation, dwReserved)
proc GetClipboardData*(self: ptr IOleObject, dwReserved: DWORD, ppDataObject: ptr ptr IDataObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClipboardData(self, dwReserved, ppDataObject)
proc DoVerb*(self: ptr IOleObject, iVerb: LONG, lpmsg: LPMSG, pActiveSite: ptr IOleClientSite, lindex: LONG, hwndParent: HWND, lprcPosRect: LPCRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoVerb(self, iVerb, lpmsg, pActiveSite, lindex, hwndParent, lprcPosRect)
proc EnumVerbs*(self: ptr IOleObject, ppEnumOleVerb: ptr ptr IEnumOLEVERB): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumVerbs(self, ppEnumOleVerb)
proc Update*(self: ptr IOleObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Update(self)
proc IsUpToDate*(self: ptr IOleObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsUpToDate(self)
proc GetUserClassID*(self: ptr IOleObject, pClsid: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUserClassID(self, pClsid)
proc GetUserType*(self: ptr IOleObject, dwFormOfType: DWORD, pszUserType: ptr LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUserType(self, dwFormOfType, pszUserType)
proc SetExtent*(self: ptr IOleObject, dwDrawAspect: DWORD, psizel: ptr SIZEL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetExtent(self, dwDrawAspect, psizel)
proc GetExtent*(self: ptr IOleObject, dwDrawAspect: DWORD, psizel: ptr SIZEL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExtent(self, dwDrawAspect, psizel)
proc Advise*(self: ptr IOleObject, pAdvSink: ptr IAdviseSink, pdwConnection: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, pAdvSink, pdwConnection)
proc Unadvise*(self: ptr IOleObject, dwConnection: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwConnection)
proc EnumAdvise*(self: ptr IOleObject, ppenumAdvise: ptr ptr IEnumSTATDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumAdvise(self, ppenumAdvise)
proc GetMiscStatus*(self: ptr IOleObject, dwAspect: DWORD, pdwStatus: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMiscStatus(self, dwAspect, pdwStatus)
proc SetColorScheme*(self: ptr IOleObject, pLogpal: ptr LOGPALETTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetColorScheme(self, pLogpal)
proc GetWindow*(self: ptr IOleWindow, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWindow(self, phwnd)
proc ContextSensitiveHelp*(self: ptr IOleWindow, fEnterMode: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ContextSensitiveHelp(self, fEnterMode)
proc SetUpdateOptions*(self: ptr IOleLink, dwUpdateOpt: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetUpdateOptions(self, dwUpdateOpt)
proc GetUpdateOptions*(self: ptr IOleLink, pdwUpdateOpt: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUpdateOptions(self, pdwUpdateOpt)
proc SetSourceMoniker*(self: ptr IOleLink, pmk: ptr IMoniker, rclsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSourceMoniker(self, pmk, rclsid)
proc GetSourceMoniker*(self: ptr IOleLink, ppmk: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSourceMoniker(self, ppmk)
proc SetSourceDisplayName*(self: ptr IOleLink, pszStatusText: LPCOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSourceDisplayName(self, pszStatusText)
proc GetSourceDisplayName*(self: ptr IOleLink, ppszDisplayName: ptr LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSourceDisplayName(self, ppszDisplayName)
proc BindToSource*(self: ptr IOleLink, bindflags: DWORD, pbc: ptr IBindCtx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindToSource(self, bindflags, pbc)
proc BindIfRunning*(self: ptr IOleLink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindIfRunning(self)
proc GetBoundSource*(self: ptr IOleLink, ppunk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBoundSource(self, ppunk)
proc UnbindSource*(self: ptr IOleLink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnbindSource(self)
proc Update*(self: ptr IOleLink, pbc: ptr IBindCtx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Update(self, pbc)
proc GetObject*(self: ptr IOleItemContainer, pszItem: LPOLESTR, dwSpeedNeeded: DWORD, pbc: ptr IBindCtx, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObject(self, pszItem, dwSpeedNeeded, pbc, riid, ppvObject)
proc GetObjectStorage*(self: ptr IOleItemContainer, pszItem: LPOLESTR, pbc: ptr IBindCtx, riid: REFIID, ppvStorage: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectStorage(self, pszItem, pbc, riid, ppvStorage)
proc IsRunning*(self: ptr IOleItemContainer, pszItem: LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsRunning(self, pszItem)
proc GetBorder*(self: ptr IOleInPlaceUIWindow, lprectBorder: LPRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBorder(self, lprectBorder)
proc RequestBorderSpace*(self: ptr IOleInPlaceUIWindow, pborderwidths: LPCBORDERWIDTHS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestBorderSpace(self, pborderwidths)
proc SetBorderSpace*(self: ptr IOleInPlaceUIWindow, pborderwidths: LPCBORDERWIDTHS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetBorderSpace(self, pborderwidths)
proc SetActiveObject*(self: ptr IOleInPlaceUIWindow, pActiveObject: ptr IOleInPlaceActiveObject, pszObjName: LPCOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetActiveObject(self, pActiveObject, pszObjName)
proc TranslateAccelerator*(self: ptr IOleInPlaceActiveObject, lpmsg: LPMSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAccelerator(self, lpmsg)
proc OnFrameWindowActivate*(self: ptr IOleInPlaceActiveObject, fActivate: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnFrameWindowActivate(self, fActivate)
proc OnDocWindowActivate*(self: ptr IOleInPlaceActiveObject, fActivate: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDocWindowActivate(self, fActivate)
proc ResizeBorder*(self: ptr IOleInPlaceActiveObject, prcBorder: LPCRECT, pUIWindow: ptr IOleInPlaceUIWindow, fFrameWindow: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResizeBorder(self, prcBorder, pUIWindow, fFrameWindow)
proc EnableModeless*(self: ptr IOleInPlaceActiveObject, fEnable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableModeless(self, fEnable)
proc InsertMenus*(self: ptr IOleInPlaceFrame, hmenuShared: HMENU, lpMenuWidths: LPOLEMENUGROUPWIDTHS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InsertMenus(self, hmenuShared, lpMenuWidths)
proc SetMenu*(self: ptr IOleInPlaceFrame, hmenuShared: HMENU, holemenu: HOLEMENU, hwndActiveObject: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMenu(self, hmenuShared, holemenu, hwndActiveObject)
proc RemoveMenus*(self: ptr IOleInPlaceFrame, hmenuShared: HMENU): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveMenus(self, hmenuShared)
proc SetStatusText*(self: ptr IOleInPlaceFrame, pszStatusText: LPCOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetStatusText(self, pszStatusText)
proc EnableModeless*(self: ptr IOleInPlaceFrame, fEnable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableModeless(self, fEnable)
proc TranslateAccelerator*(self: ptr IOleInPlaceFrame, lpmsg: LPMSG, wID: WORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAccelerator(self, lpmsg, wID)
proc InPlaceDeactivate*(self: ptr IOleInPlaceObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InPlaceDeactivate(self)
proc UIDeactivate*(self: ptr IOleInPlaceObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UIDeactivate(self)
proc SetObjectRects*(self: ptr IOleInPlaceObject, lprcPosRect: LPCRECT, lprcClipRect: LPCRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetObjectRects(self, lprcPosRect, lprcClipRect)
proc ReactivateAndUndo*(self: ptr IOleInPlaceObject): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReactivateAndUndo(self)
proc CanInPlaceActivate*(self: ptr IOleInPlaceSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CanInPlaceActivate(self)
proc OnInPlaceActivate*(self: ptr IOleInPlaceSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnInPlaceActivate(self)
proc OnUIActivate*(self: ptr IOleInPlaceSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnUIActivate(self)
proc GetWindowContext*(self: ptr IOleInPlaceSite, ppFrame: ptr ptr IOleInPlaceFrame, ppDoc: ptr ptr IOleInPlaceUIWindow, lprcPosRect: LPRECT, lprcClipRect: LPRECT, lpFrameInfo: LPOLEINPLACEFRAMEINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWindowContext(self, ppFrame, ppDoc, lprcPosRect, lprcClipRect, lpFrameInfo)
proc Scroll*(self: ptr IOleInPlaceSite, scrollExtant: SIZE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Scroll(self, scrollExtant)
proc OnUIDeactivate*(self: ptr IOleInPlaceSite, fUndoable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnUIDeactivate(self, fUndoable)
proc OnInPlaceDeactivate*(self: ptr IOleInPlaceSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnInPlaceDeactivate(self)
proc DiscardUndoState*(self: ptr IOleInPlaceSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DiscardUndoState(self)
proc DeactivateAndUndo*(self: ptr IOleInPlaceSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeactivateAndUndo(self)
proc OnPosRectChange*(self: ptr IOleInPlaceSite, lprcPosRect: LPCRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnPosRectChange(self, lprcPosRect)
proc FContinue*(self: ptr IContinue): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FContinue(self)
proc Draw*(self: ptr IViewObject, dwDrawAspect: DWORD, lindex: LONG, pvAspect: pointer, ptd: ptr DVTARGETDEVICE, hdcTargetDev: HDC, hdcDraw: HDC, lprcBounds: LPCRECTL, lprcWBounds: LPCRECTL, pfnContinue: proc (dwContinue: ULONG_PTR): WINBOOL {.stdcall.}, dwContinue: ULONG_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Draw(self, dwDrawAspect, lindex, pvAspect, ptd, hdcTargetDev, hdcDraw, lprcBounds, lprcWBounds, pfnContinue, dwContinue)
proc GetColorSet*(self: ptr IViewObject, dwDrawAspect: DWORD, lindex: LONG, pvAspect: pointer, ptd: ptr DVTARGETDEVICE, hicTargetDev: HDC, ppColorSet: ptr ptr LOGPALETTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColorSet(self, dwDrawAspect, lindex, pvAspect, ptd, hicTargetDev, ppColorSet)
proc Freeze*(self: ptr IViewObject, dwDrawAspect: DWORD, lindex: LONG, pvAspect: pointer, pdwFreeze: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Freeze(self, dwDrawAspect, lindex, pvAspect, pdwFreeze)
proc Unfreeze*(self: ptr IViewObject, dwFreeze: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unfreeze(self, dwFreeze)
proc SetAdvise*(self: ptr IViewObject, aspects: DWORD, advf: DWORD, pAdvSink: ptr IAdviseSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAdvise(self, aspects, advf, pAdvSink)
proc GetAdvise*(self: ptr IViewObject, pAspects: ptr DWORD, pAdvf: ptr DWORD, ppAdvSink: ptr ptr IAdviseSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAdvise(self, pAspects, pAdvf, ppAdvSink)
proc GetExtent*(self: ptr IViewObject2, dwDrawAspect: DWORD, lindex: LONG, ptd: ptr DVTARGETDEVICE, lpsizel: LPSIZEL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExtent(self, dwDrawAspect, lindex, ptd, lpsizel)
proc QueryContinueDrag*(self: ptr IDropSource, fEscapePressed: WINBOOL, grfKeyState: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryContinueDrag(self, fEscapePressed, grfKeyState)
proc GiveFeedback*(self: ptr IDropSource, dwEffect: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GiveFeedback(self, dwEffect)
proc DragEnter*(self: ptr IDropTarget, pDataObj: ptr IDataObject, grfKeyState: DWORD, pt: POINTL, pdwEffect: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragEnter(self, pDataObj, grfKeyState, pt, pdwEffect)
proc DragOver*(self: ptr IDropTarget, grfKeyState: DWORD, pt: POINTL, pdwEffect: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragOver(self, grfKeyState, pt, pdwEffect)
proc DragLeave*(self: ptr IDropTarget): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragLeave(self)
proc Drop*(self: ptr IDropTarget, pDataObj: ptr IDataObject, grfKeyState: DWORD, pt: POINTL, pdwEffect: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Drop(self, pDataObj, grfKeyState, pt, pdwEffect)
proc DragEnterTarget*(self: ptr IDropSourceNotify, hwndTarget: HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragEnterTarget(self, hwndTarget)
proc DragLeaveTarget*(self: ptr IDropSourceNotify): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DragLeaveTarget(self)
proc Next*(self: ptr IEnumOLEVERB, celt: ULONG, rgelt: LPOLEVERB, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumOLEVERB, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumOLEVERB): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumOLEVERB, ppenum: ptr ptr IEnumOLEVERB): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc QueryService*(self: ptr IServiceProvider, guidService: REFGUID, riid: REFIID, ppvObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryService(self, guidService, riid, ppvObject)
proc hasFeature*(self: ptr IXMLDOMImplementation, feature: BSTR, version: BSTR, hasFeature: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.hasFeature(self, feature, version, hasFeature)
proc get_nodeName*(self: ptr IXMLDOMNode, name: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_nodeName(self, name)
proc get_nodeValue*(self: ptr IXMLDOMNode, value: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_nodeValue(self, value)
proc put_nodeValue*(self: ptr IXMLDOMNode, value: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_nodeValue(self, value)
proc get_nodeType*(self: ptr IXMLDOMNode, `type`: ptr DOMNodeType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_nodeType(self, `type`)
proc get_parentNode*(self: ptr IXMLDOMNode, parent: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_parentNode(self, parent)
proc get_childNodes*(self: ptr IXMLDOMNode, childList: ptr ptr IXMLDOMNodeList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_childNodes(self, childList)
proc get_firstChild*(self: ptr IXMLDOMNode, firstChild: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_firstChild(self, firstChild)
proc get_lastChild*(self: ptr IXMLDOMNode, lastChild: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_lastChild(self, lastChild)
proc get_previousSibling*(self: ptr IXMLDOMNode, previousSibling: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_previousSibling(self, previousSibling)
proc get_nextSibling*(self: ptr IXMLDOMNode, nextSibling: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_nextSibling(self, nextSibling)
proc get_attributes*(self: ptr IXMLDOMNode, attributeMap: ptr ptr IXMLDOMNamedNodeMap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_attributes(self, attributeMap)
proc insertBefore*(self: ptr IXMLDOMNode, newChild: ptr IXMLDOMNode, refChild: VARIANT, outNewChild: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.insertBefore(self, newChild, refChild, outNewChild)
proc replaceChild*(self: ptr IXMLDOMNode, newChild: ptr IXMLDOMNode, oldChild: ptr IXMLDOMNode, outOldChild: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.replaceChild(self, newChild, oldChild, outOldChild)
proc removeChild*(self: ptr IXMLDOMNode, childNode: ptr IXMLDOMNode, oldChild: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeChild(self, childNode, oldChild)
proc appendChild*(self: ptr IXMLDOMNode, newChild: ptr IXMLDOMNode, outNewChild: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.appendChild(self, newChild, outNewChild)
proc hasChildNodes*(self: ptr IXMLDOMNode, hasChild: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.hasChildNodes(self, hasChild)
proc get_ownerDocument*(self: ptr IXMLDOMNode, DOMDocument: ptr ptr IXMLDOMDocument): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ownerDocument(self, DOMDocument)
proc cloneNode*(self: ptr IXMLDOMNode, deep: VARIANT_BOOL, cloneRoot: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.cloneNode(self, deep, cloneRoot)
proc get_nodeTypeString*(self: ptr IXMLDOMNode, nodeType: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_nodeTypeString(self, nodeType)
proc get_text*(self: ptr IXMLDOMNode, text: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_text(self, text)
proc put_text*(self: ptr IXMLDOMNode, text: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_text(self, text)
proc get_specified*(self: ptr IXMLDOMNode, isSpecified: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_specified(self, isSpecified)
proc get_definition*(self: ptr IXMLDOMNode, definitionNode: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_definition(self, definitionNode)
proc get_nodeTypedValue*(self: ptr IXMLDOMNode, typedValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_nodeTypedValue(self, typedValue)
proc put_nodeTypedValue*(self: ptr IXMLDOMNode, typedValue: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_nodeTypedValue(self, typedValue)
proc get_dataType*(self: ptr IXMLDOMNode, dataTypeName: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_dataType(self, dataTypeName)
proc put_dataType*(self: ptr IXMLDOMNode, dataTypeName: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_dataType(self, dataTypeName)
proc get_xml*(self: ptr IXMLDOMNode, xmlString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_xml(self, xmlString)
proc transformNode*(self: ptr IXMLDOMNode, stylesheet: ptr IXMLDOMNode, xmlString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.transformNode(self, stylesheet, xmlString)
proc selectNodes*(self: ptr IXMLDOMNode, queryString: BSTR, resultList: ptr ptr IXMLDOMNodeList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.selectNodes(self, queryString, resultList)
proc selectSingleNode*(self: ptr IXMLDOMNode, queryString: BSTR, resultNode: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.selectSingleNode(self, queryString, resultNode)
proc get_parsed*(self: ptr IXMLDOMNode, isParsed: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_parsed(self, isParsed)
proc get_namespaceURI*(self: ptr IXMLDOMNode, namespaceURI: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_namespaceURI(self, namespaceURI)
proc get_prefix*(self: ptr IXMLDOMNode, prefixString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_prefix(self, prefixString)
proc get_baseName*(self: ptr IXMLDOMNode, nameString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_baseName(self, nameString)
proc transformNodeToObject*(self: ptr IXMLDOMNode, stylesheet: ptr IXMLDOMNode, outputObject: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.transformNodeToObject(self, stylesheet, outputObject)
proc get_doctype*(self: ptr IXMLDOMDocument, documentType: ptr ptr IXMLDOMDocumentType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_doctype(self, documentType)
proc get_implementation*(self: ptr IXMLDOMDocument, impl: ptr ptr IXMLDOMImplementation): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_implementation(self, impl)
proc get_documentElement*(self: ptr IXMLDOMDocument, DOMElement: ptr ptr IXMLDOMElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_documentElement(self, DOMElement)
proc putref_documentElement*(self: ptr IXMLDOMDocument, DOMElement: ptr IXMLDOMElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.putref_documentElement(self, DOMElement)
proc createElement*(self: ptr IXMLDOMDocument, tagName: BSTR, element: ptr ptr IXMLDOMElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createElement(self, tagName, element)
proc createDocumentFragment*(self: ptr IXMLDOMDocument, docFrag: ptr ptr IXMLDOMDocumentFragment): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createDocumentFragment(self, docFrag)
proc createTextNode*(self: ptr IXMLDOMDocument, data: BSTR, text: ptr ptr IXMLDOMText): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createTextNode(self, data, text)
proc createComment*(self: ptr IXMLDOMDocument, data: BSTR, comment: ptr ptr IXMLDOMComment): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createComment(self, data, comment)
proc createCDATASection*(self: ptr IXMLDOMDocument, data: BSTR, cdata: ptr ptr IXMLDOMCDATASection): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createCDATASection(self, data, cdata)
proc createProcessingInstruction*(self: ptr IXMLDOMDocument, target: BSTR, data: BSTR, pi: ptr ptr IXMLDOMProcessingInstruction): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createProcessingInstruction(self, target, data, pi)
proc createAttribute*(self: ptr IXMLDOMDocument, name: BSTR, attribute: ptr ptr IXMLDOMAttribute): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createAttribute(self, name, attribute)
proc createEntityReference*(self: ptr IXMLDOMDocument, name: BSTR, entityRef: ptr ptr IXMLDOMEntityReference): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createEntityReference(self, name, entityRef)
proc getElementsByTagName*(self: ptr IXMLDOMDocument, tagName: BSTR, resultList: ptr ptr IXMLDOMNodeList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getElementsByTagName(self, tagName, resultList)
proc createNode*(self: ptr IXMLDOMDocument, Type: VARIANT, name: BSTR, namespaceURI: BSTR, node: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createNode(self, Type, name, namespaceURI, node)
proc nodeFromID*(self: ptr IXMLDOMDocument, idString: BSTR, node: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.nodeFromID(self, idString, node)
proc load*(self: ptr IXMLDOMDocument, xmlSource: VARIANT, isSuccessful: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.load(self, xmlSource, isSuccessful)
proc get_readyState*(self: ptr IXMLDOMDocument, value: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_readyState(self, value)
proc get_parseError*(self: ptr IXMLDOMDocument, errorObj: ptr ptr IXMLDOMParseError): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_parseError(self, errorObj)
proc get_url*(self: ptr IXMLDOMDocument, urlString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_url(self, urlString)
proc get_async*(self: ptr IXMLDOMDocument, isAsync: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_async(self, isAsync)
proc put_async*(self: ptr IXMLDOMDocument, isAsync: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_async(self, isAsync)
proc abort*(self: ptr IXMLDOMDocument): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.abort(self)
proc loadXML*(self: ptr IXMLDOMDocument, bstrXML: BSTR, isSuccessful: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.loadXML(self, bstrXML, isSuccessful)
proc save*(self: ptr IXMLDOMDocument, destination: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.save(self, destination)
proc get_validateOnParse*(self: ptr IXMLDOMDocument, isValidating: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_validateOnParse(self, isValidating)
proc put_validateOnParse*(self: ptr IXMLDOMDocument, isValidating: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_validateOnParse(self, isValidating)
proc get_resolveExternals*(self: ptr IXMLDOMDocument, isResolving: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_resolveExternals(self, isResolving)
proc put_resolveExternals*(self: ptr IXMLDOMDocument, isResolving: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_resolveExternals(self, isResolving)
proc get_preserveWhiteSpace*(self: ptr IXMLDOMDocument, isPreserving: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_preserveWhiteSpace(self, isPreserving)
proc put_preserveWhiteSpace*(self: ptr IXMLDOMDocument, isPreserving: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_preserveWhiteSpace(self, isPreserving)
proc put_onreadystatechange*(self: ptr IXMLDOMDocument, readystatechangeSink: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_onreadystatechange(self, readystatechangeSink)
proc put_ondataavailable*(self: ptr IXMLDOMDocument, ondataavailableSink: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ondataavailable(self, ondataavailableSink)
proc put_ontransformnode*(self: ptr IXMLDOMDocument, ontransformnodeSink: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ontransformnode(self, ontransformnodeSink)
proc get_item*(self: ptr IXMLDOMNodeList, index: LONG, listItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_item(self, index, listItem)
proc get_length*(self: ptr IXMLDOMNodeList, listLength: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_length(self, listLength)
proc nextNode*(self: ptr IXMLDOMNodeList, nextItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.nextNode(self, nextItem)
proc reset*(self: ptr IXMLDOMNodeList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.reset(self)
proc get_newEnum*(self: ptr IXMLDOMNodeList, ppUnk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_newEnum(self, ppUnk)
proc getNamedItem*(self: ptr IXMLDOMNamedNodeMap, name: BSTR, namedItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getNamedItem(self, name, namedItem)
proc setNamedItem*(self: ptr IXMLDOMNamedNodeMap, newItem: ptr IXMLDOMNode, nameItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.setNamedItem(self, newItem, nameItem)
proc removeNamedItem*(self: ptr IXMLDOMNamedNodeMap, name: BSTR, namedItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeNamedItem(self, name, namedItem)
proc get_item*(self: ptr IXMLDOMNamedNodeMap, index: LONG, listItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_item(self, index, listItem)
proc get_length*(self: ptr IXMLDOMNamedNodeMap, listLength: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_length(self, listLength)
proc getQualifiedItem*(self: ptr IXMLDOMNamedNodeMap, baseName: BSTR, namespaceURI: BSTR, qualifiedItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getQualifiedItem(self, baseName, namespaceURI, qualifiedItem)
proc removeQualifiedItem*(self: ptr IXMLDOMNamedNodeMap, baseName: BSTR, namespaceURI: BSTR, qualifiedItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeQualifiedItem(self, baseName, namespaceURI, qualifiedItem)
proc nextNode*(self: ptr IXMLDOMNamedNodeMap, nextItem: ptr ptr IXMLDOMNode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.nextNode(self, nextItem)
proc reset*(self: ptr IXMLDOMNamedNodeMap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.reset(self)
proc get_newEnum*(self: ptr IXMLDOMNamedNodeMap, ppUnk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_newEnum(self, ppUnk)
proc get_data*(self: ptr IXMLDOMCharacterData, data: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_data(self, data)
proc put_data*(self: ptr IXMLDOMCharacterData, data: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_data(self, data)
proc get_length*(self: ptr IXMLDOMCharacterData, dataLength: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_length(self, dataLength)
proc substringData*(self: ptr IXMLDOMCharacterData, offset: LONG, count: LONG, data: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.substringData(self, offset, count, data)
proc appendData*(self: ptr IXMLDOMCharacterData, data: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.appendData(self, data)
proc insertData*(self: ptr IXMLDOMCharacterData, offset: LONG, data: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.insertData(self, offset, data)
proc deleteData*(self: ptr IXMLDOMCharacterData, offset: LONG, count: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.deleteData(self, offset, count)
proc replaceData*(self: ptr IXMLDOMCharacterData, offset: LONG, count: LONG, data: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.replaceData(self, offset, count, data)
proc get_name*(self: ptr IXMLDOMAttribute, attributeName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_name(self, attributeName)
proc get_value*(self: ptr IXMLDOMAttribute, attributeValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_value(self, attributeValue)
proc put_value*(self: ptr IXMLDOMAttribute, attributeValue: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_value(self, attributeValue)
proc get_tagName*(self: ptr IXMLDOMElement, tagName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_tagName(self, tagName)
proc getAttribute*(self: ptr IXMLDOMElement, name: BSTR, value: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getAttribute(self, name, value)
proc setAttribute*(self: ptr IXMLDOMElement, name: BSTR, value: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.setAttribute(self, name, value)
proc removeAttribute*(self: ptr IXMLDOMElement, name: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeAttribute(self, name)
proc getAttributeNode*(self: ptr IXMLDOMElement, name: BSTR, attributeNode: ptr ptr IXMLDOMAttribute): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getAttributeNode(self, name, attributeNode)
proc setAttributeNode*(self: ptr IXMLDOMElement, DOMAttribute: ptr IXMLDOMAttribute, attributeNode: ptr ptr IXMLDOMAttribute): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.setAttributeNode(self, DOMAttribute, attributeNode)
proc removeAttributeNode*(self: ptr IXMLDOMElement, DOMAttribute: ptr IXMLDOMAttribute, attributeNode: ptr ptr IXMLDOMAttribute): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeAttributeNode(self, DOMAttribute, attributeNode)
proc getElementsByTagName*(self: ptr IXMLDOMElement, tagName: BSTR, resultList: ptr ptr IXMLDOMNodeList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getElementsByTagName(self, tagName, resultList)
proc normalize*(self: ptr IXMLDOMElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.normalize(self)
proc splitText*(self: ptr IXMLDOMText, offset: LONG, rightHandTextNode: ptr ptr IXMLDOMText): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.splitText(self, offset, rightHandTextNode)
proc get_target*(self: ptr IXMLDOMProcessingInstruction, name: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_target(self, name)
proc get_data*(self: ptr IXMLDOMProcessingInstruction, value: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_data(self, value)
proc put_data*(self: ptr IXMLDOMProcessingInstruction, value: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_data(self, value)
proc get_name*(self: ptr IXMLDOMDocumentType, rootName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_name(self, rootName)
proc get_entities*(self: ptr IXMLDOMDocumentType, entityMap: ptr ptr IXMLDOMNamedNodeMap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_entities(self, entityMap)
proc get_notations*(self: ptr IXMLDOMDocumentType, notationMap: ptr ptr IXMLDOMNamedNodeMap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_notations(self, notationMap)
proc get_publicId*(self: ptr IXMLDOMNotation, publicID: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_publicId(self, publicID)
proc get_systemId*(self: ptr IXMLDOMNotation, systemID: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_systemId(self, systemID)
proc get_publicId*(self: ptr IXMLDOMEntity, publicID: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_publicId(self, publicID)
proc get_systemId*(self: ptr IXMLDOMEntity, systemID: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_systemId(self, systemID)
proc get_notationName*(self: ptr IXMLDOMEntity, name: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_notationName(self, name)
proc get_errorCode*(self: ptr IXMLDOMParseError, errorCode: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_errorCode(self, errorCode)
proc get_url*(self: ptr IXMLDOMParseError, urlString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_url(self, urlString)
proc get_reason*(self: ptr IXMLDOMParseError, reasonString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_reason(self, reasonString)
proc get_srcText*(self: ptr IXMLDOMParseError, sourceString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_srcText(self, sourceString)
proc get_line*(self: ptr IXMLDOMParseError, lineNumber: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_line(self, lineNumber)
proc get_linepos*(self: ptr IXMLDOMParseError, linePosition: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_linepos(self, linePosition)
proc get_filepos*(self: ptr IXMLDOMParseError, filePosition: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_filepos(self, filePosition)
proc uniqueID*(self: ptr IXTLRuntime, pNode: ptr IXMLDOMNode, pID: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.uniqueID(self, pNode, pID)
proc depth*(self: ptr IXTLRuntime, pNode: ptr IXMLDOMNode, pDepth: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.depth(self, pNode, pDepth)
proc childNumber*(self: ptr IXTLRuntime, pNode: ptr IXMLDOMNode, pNumber: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.childNumber(self, pNode, pNumber)
proc ancestorChildNumber*(self: ptr IXTLRuntime, bstrNodeName: BSTR, pNode: ptr IXMLDOMNode, pNumber: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ancestorChildNumber(self, bstrNodeName, pNode, pNumber)
proc absoluteChildNumber*(self: ptr IXTLRuntime, pNode: ptr IXMLDOMNode, pNumber: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.absoluteChildNumber(self, pNode, pNumber)
proc formatIndex*(self: ptr IXTLRuntime, lIndex: LONG, bstrFormat: BSTR, pbstrFormattedString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.formatIndex(self, lIndex, bstrFormat, pbstrFormattedString)
proc formatNumber*(self: ptr IXTLRuntime, dblNumber: float64, bstrFormat: BSTR, pbstrFormattedString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.formatNumber(self, dblNumber, bstrFormat, pbstrFormattedString)
proc formatDate*(self: ptr IXTLRuntime, varDate: VARIANT, bstrFormat: BSTR, varDestLocale: VARIANT, pbstrFormattedString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.formatDate(self, varDate, bstrFormat, varDestLocale, pbstrFormattedString)
proc formatTime*(self: ptr IXTLRuntime, varTime: VARIANT, bstrFormat: BSTR, varDestLocale: VARIANT, pbstrFormattedString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.formatTime(self, varTime, bstrFormat, varDestLocale, pbstrFormattedString)
proc open*(self: ptr IXMLHttpRequest, bstrMethod: BSTR, bstrUrl: BSTR, varAsync: VARIANT, bstrUser: VARIANT, bstrPassword: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.open(self, bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword)
proc setRequestHeader*(self: ptr IXMLHttpRequest, bstrHeader: BSTR, bstrValue: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.setRequestHeader(self, bstrHeader, bstrValue)
proc getResponseHeader*(self: ptr IXMLHttpRequest, bstrHeader: BSTR, pbstrValue: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getResponseHeader(self, bstrHeader, pbstrValue)
proc getAllResponseHeaders*(self: ptr IXMLHttpRequest, pbstrHeaders: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getAllResponseHeaders(self, pbstrHeaders)
proc send*(self: ptr IXMLHttpRequest, varBody: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.send(self, varBody)
proc abort*(self: ptr IXMLHttpRequest): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.abort(self)
proc get_status*(self: ptr IXMLHttpRequest, plStatus: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_status(self, plStatus)
proc get_statusText*(self: ptr IXMLHttpRequest, pbstrStatus: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_statusText(self, pbstrStatus)
proc get_responseXML*(self: ptr IXMLHttpRequest, ppBody: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_responseXML(self, ppBody)
proc get_responseText*(self: ptr IXMLHttpRequest, pbstrBody: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_responseText(self, pbstrBody)
proc get_responseBody*(self: ptr IXMLHttpRequest, pvarBody: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_responseBody(self, pvarBody)
proc get_responseStream*(self: ptr IXMLHttpRequest, pvarBody: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_responseStream(self, pvarBody)
proc get_readyState*(self: ptr IXMLHttpRequest, plState: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_readyState(self, plState)
proc put_onreadystatechange*(self: ptr IXMLHttpRequest, pReadyStateSink: ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_onreadystatechange(self, pReadyStateSink)
proc get_XMLDocument*(self: ptr IXMLDSOControl, ppDoc: ptr ptr IXMLDOMDocument): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_XMLDocument(self, ppDoc)
proc put_XMLDocument*(self: ptr IXMLDSOControl, ppDoc: ptr IXMLDOMDocument): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_XMLDocument(self, ppDoc)
proc get_JavaDSOCompatible*(self: ptr IXMLDSOControl, fJavaDSOCompatible: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_JavaDSOCompatible(self, fJavaDSOCompatible)
proc put_JavaDSOCompatible*(self: ptr IXMLDSOControl, fJavaDSOCompatible: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_JavaDSOCompatible(self, fJavaDSOCompatible)
proc get_readyState*(self: ptr IXMLDSOControl, state: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_readyState(self, state)
proc put_length*(self: ptr IXMLElementCollection, v: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_length(self, v)
proc get_length*(self: ptr IXMLElementCollection, p: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_length(self, p)
proc get_newEnum*(self: ptr IXMLElementCollection, ppUnk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_newEnum(self, ppUnk)
proc item*(self: ptr IXMLElementCollection, var1: VARIANT, var2: VARIANT, ppDisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.item(self, var1, var2, ppDisp)
proc get_root*(self: ptr IXMLDocument, p: ptr ptr IXMLElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_root(self, p)
proc get_fileSize*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_fileSize(self, p)
proc get_fileModifiedDate*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_fileModifiedDate(self, p)
proc get_fileUpdatedDate*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_fileUpdatedDate(self, p)
proc get_URL*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_URL(self, p)
proc put_URL*(self: ptr IXMLDocument, p: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_URL(self, p)
proc get_mimeType*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_mimeType(self, p)
proc get_readyState*(self: ptr IXMLDocument, pl: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_readyState(self, pl)
proc get_charset*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_charset(self, p)
proc put_charset*(self: ptr IXMLDocument, p: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_charset(self, p)
proc get_version*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_version(self, p)
proc get_doctype*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_doctype(self, p)
proc get_dtdURL*(self: ptr IXMLDocument, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_dtdURL(self, p)
proc createElement*(self: ptr IXMLDocument, vType: VARIANT, var1: VARIANT, ppElem: ptr ptr IXMLElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createElement(self, vType, var1, ppElem)
proc get_root*(self: ptr IXMLDocument2, p: ptr ptr IXMLElement2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_root(self, p)
proc get_fileSize*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_fileSize(self, p)
proc get_fileModifiedDate*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_fileModifiedDate(self, p)
proc get_fileUpdatedDate*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_fileUpdatedDate(self, p)
proc get_URL*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_URL(self, p)
proc put_URL*(self: ptr IXMLDocument2, p: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_URL(self, p)
proc get_mimeType*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_mimeType(self, p)
proc get_readyState*(self: ptr IXMLDocument2, pl: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_readyState(self, pl)
proc get_charset*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_charset(self, p)
proc put_charset*(self: ptr IXMLDocument2, p: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_charset(self, p)
proc get_version*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_version(self, p)
proc get_doctype*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_doctype(self, p)
proc get_dtdURL*(self: ptr IXMLDocument2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_dtdURL(self, p)
proc createElement*(self: ptr IXMLDocument2, vType: VARIANT, var1: VARIANT, ppElem: ptr ptr IXMLElement2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.createElement(self, vType, var1, ppElem)
proc get_async*(self: ptr IXMLDocument2, pf: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_async(self, pf)
proc put_async*(self: ptr IXMLDocument2, f: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_async(self, f)
proc get_tagName*(self: ptr IXMLElement, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_tagName(self, p)
proc put_tagName*(self: ptr IXMLElement, p: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_tagName(self, p)
proc get_parent*(self: ptr IXMLElement, ppParent: ptr ptr IXMLElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_parent(self, ppParent)
proc setAttribute*(self: ptr IXMLElement, strPropertyName: BSTR, PropertyValue: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.setAttribute(self, strPropertyName, PropertyValue)
proc getAttribute*(self: ptr IXMLElement, strPropertyName: BSTR, PropertyValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getAttribute(self, strPropertyName, PropertyValue)
proc removeAttribute*(self: ptr IXMLElement, strPropertyName: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeAttribute(self, strPropertyName)
proc get_children*(self: ptr IXMLElement, pp: ptr ptr IXMLElementCollection): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_children(self, pp)
proc get_type*(self: ptr IXMLElement, plType: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_type(self, plType)
proc get_text*(self: ptr IXMLElement, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_text(self, p)
proc put_text*(self: ptr IXMLElement, p: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_text(self, p)
proc addChild*(self: ptr IXMLElement, pChildElem: ptr IXMLElement, lIndex: LONG, lReserved: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.addChild(self, pChildElem, lIndex, lReserved)
proc removeChild*(self: ptr IXMLElement, pChildElem: ptr IXMLElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeChild(self, pChildElem)
proc get_tagName*(self: ptr IXMLElement2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_tagName(self, p)
proc put_tagName*(self: ptr IXMLElement2, p: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_tagName(self, p)
proc get_parent*(self: ptr IXMLElement2, ppParent: ptr ptr IXMLElement2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_parent(self, ppParent)
proc setAttribute*(self: ptr IXMLElement2, strPropertyName: BSTR, PropertyValue: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.setAttribute(self, strPropertyName, PropertyValue)
proc getAttribute*(self: ptr IXMLElement2, strPropertyName: BSTR, PropertyValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getAttribute(self, strPropertyName, PropertyValue)
proc removeAttribute*(self: ptr IXMLElement2, strPropertyName: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeAttribute(self, strPropertyName)
proc get_children*(self: ptr IXMLElement2, pp: ptr ptr IXMLElementCollection): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_children(self, pp)
proc get_type*(self: ptr IXMLElement2, plType: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_type(self, plType)
proc get_text*(self: ptr IXMLElement2, p: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_text(self, p)
proc put_text*(self: ptr IXMLElement2, p: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_text(self, p)
proc addChild*(self: ptr IXMLElement2, pChildElem: ptr IXMLElement2, lIndex: LONG, lReserved: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.addChild(self, pChildElem, lIndex, lReserved)
proc removeChild*(self: ptr IXMLElement2, pChildElem: ptr IXMLElement2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.removeChild(self, pChildElem)
proc get_attributes*(self: ptr IXMLElement2, pp: ptr ptr IXMLElementCollection): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_attributes(self, pp)
proc get_name*(self: ptr IXMLAttribute, n: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_name(self, n)
proc get_value*(self: ptr IXMLAttribute, v: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_value(self, v)
proc GetErrorInfo*(self: ptr IXMLError, pErrorReturn: ptr XML_ERROR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetErrorInfo(self, pErrorReturn)
proc GetClassID*(self: ptr IPersistMoniker, pClassID: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClassID(self, pClassID)
proc IsDirty*(self: ptr IPersistMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDirty(self)
proc Load*(self: ptr IPersistMoniker, fFullyAvailable: WINBOOL, pimkName: ptr IMoniker, pibc: LPBC, grfMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, fFullyAvailable, pimkName, pibc, grfMode)
proc Save*(self: ptr IPersistMoniker, pimkName: ptr IMoniker, pbc: LPBC, fRemember: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, pimkName, pbc, fRemember)
proc SaveCompleted*(self: ptr IPersistMoniker, pimkName: ptr IMoniker, pibc: LPBC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveCompleted(self, pimkName, pibc)
proc GetCurMoniker*(self: ptr IPersistMoniker, ppimkName: ptr ptr IMoniker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurMoniker(self, ppimkName)
proc PutProperty*(self: ptr IMonikerProp, mkp: MONIKERPROPERTY, val: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PutProperty(self, mkp, val)
proc CreateBinding*(self: ptr IBindProtocol, szUrl: LPCWSTR, pbc: ptr IBindCtx, ppb: ptr ptr IBinding): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBinding(self, szUrl, pbc, ppb)
proc Abort*(self: ptr IBinding): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Abort(self)
proc Suspend*(self: ptr IBinding): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Suspend(self)
proc Resume*(self: ptr IBinding): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resume(self)
proc SetPriority*(self: ptr IBinding, nPriority: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPriority(self, nPriority)
proc GetPriority*(self: ptr IBinding, pnPriority: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPriority(self, pnPriority)
proc GetBindResult*(self: ptr IBinding, pclsidProtocol: ptr CLSID, pdwResult: ptr DWORD, pszResult: ptr LPOLESTR, pdwReserved: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindResult(self, pclsidProtocol, pdwResult, pszResult, pdwReserved)
proc OnStartBinding*(self: ptr IBindStatusCallback, dwReserved: DWORD, pib: ptr IBinding): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnStartBinding(self, dwReserved, pib)
proc GetPriority*(self: ptr IBindStatusCallback, pnPriority: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPriority(self, pnPriority)
proc OnLowResource*(self: ptr IBindStatusCallback, reserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnLowResource(self, reserved)
proc OnProgress*(self: ptr IBindStatusCallback, ulProgress: ULONG, ulProgressMax: ULONG, ulStatusCode: ULONG, szStatusText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnProgress(self, ulProgress, ulProgressMax, ulStatusCode, szStatusText)
proc OnStopBinding*(self: ptr IBindStatusCallback, hresult: HRESULT, szError: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnStopBinding(self, hresult, szError)
proc GetBindInfo*(self: ptr IBindStatusCallback, grfBINDF: ptr DWORD, pbindinfo: ptr BINDINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindInfo(self, grfBINDF, pbindinfo)
proc OnDataAvailable*(self: ptr IBindStatusCallback, grfBSCF: DWORD, dwSize: DWORD, pformatetc: ptr FORMATETC, pstgmed: ptr STGMEDIUM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDataAvailable(self, grfBSCF, dwSize, pformatetc, pstgmed)
proc OnObjectAvailable*(self: ptr IBindStatusCallback, riid: REFIID, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnObjectAvailable(self, riid, punk)
proc GetBindInfoEx*(self: ptr IBindStatusCallbackEx, grfBINDF: ptr DWORD, pbindinfo: ptr BINDINFO, grfBINDF2: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindInfoEx(self, grfBINDF, pbindinfo, grfBINDF2, pdwReserved)
proc Authenticate*(self: ptr IAuthenticate, phwnd: ptr HWND, pszUsername: ptr LPWSTR, pszPassword: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Authenticate(self, phwnd, pszUsername, pszPassword)
proc AuthenticateEx*(self: ptr IAuthenticateEx, phwnd: ptr HWND, pszUsername: ptr LPWSTR, pszPassword: ptr LPWSTR, pauthinfo: ptr AUTHENTICATEINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AuthenticateEx(self, phwnd, pszUsername, pszPassword, pauthinfo)
proc BeginningTransaction*(self: ptr IHttpNegotiate, szURL: LPCWSTR, szHeaders: LPCWSTR, dwReserved: DWORD, pszAdditionalHeaders: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginningTransaction(self, szURL, szHeaders, dwReserved, pszAdditionalHeaders)
proc OnResponse*(self: ptr IHttpNegotiate, dwResponseCode: DWORD, szResponseHeaders: LPCWSTR, szRequestHeaders: LPCWSTR, pszAdditionalRequestHeaders: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnResponse(self, dwResponseCode, szResponseHeaders, szRequestHeaders, pszAdditionalRequestHeaders)
proc GetRootSecurityId*(self: ptr IHttpNegotiate2, pbSecurityId: ptr BYTE, pcbSecurityId: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRootSecurityId(self, pbSecurityId, pcbSecurityId, dwReserved)
proc GetSerializedClientCertContext*(self: ptr IHttpNegotiate3, ppbCert: ptr ptr BYTE, pcbCert: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSerializedClientCertContext(self, ppbCert, pcbCert)
proc SetHandleForUnlock*(self: ptr IWinInetFileStream, hWinInetLockHandle: DWORD_PTR, dwReserved: DWORD_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHandleForUnlock(self, hWinInetLockHandle, dwReserved)
proc SetDeleteFile*(self: ptr IWinInetFileStream, dwReserved: DWORD_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDeleteFile(self, dwReserved)
proc GetWindow*(self: ptr IWindowForBindingUI, rguidReason: REFGUID, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWindow(self, rguidReason, phwnd)
proc OnCodeInstallProblem*(self: ptr ICodeInstall, ulStatusCode: ULONG, szDestination: LPCWSTR, szSource: LPCWSTR, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnCodeInstallProblem(self, ulStatusCode, szDestination, szSource, dwReserved)
proc GetPropertyBSTR*(self: ptr IUri, uriProp: Uri_PROPERTY, pbstrProperty: ptr BSTR, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyBSTR(self, uriProp, pbstrProperty, dwFlags)
proc GetPropertyLength*(self: ptr IUri, uriProp: Uri_PROPERTY, pcchProperty: ptr DWORD, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyLength(self, uriProp, pcchProperty, dwFlags)
proc GetPropertyDWORD*(self: ptr IUri, uriProp: Uri_PROPERTY, pdwProperty: ptr DWORD, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyDWORD(self, uriProp, pdwProperty, dwFlags)
proc HasProperty*(self: ptr IUri, uriProp: Uri_PROPERTY, pfHasProperty: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HasProperty(self, uriProp, pfHasProperty)
proc GetAbsoluteUri*(self: ptr IUri, pbstrAbsoluteUri: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAbsoluteUri(self, pbstrAbsoluteUri)
proc GetAuthority*(self: ptr IUri, pbstrAuthority: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAuthority(self, pbstrAuthority)
proc GetDisplayUri*(self: ptr IUri, pbstrDisplayString: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayUri(self, pbstrDisplayString)
proc GetDomain*(self: ptr IUri, pbstrDomain: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDomain(self, pbstrDomain)
proc GetExtension*(self: ptr IUri, pbstrExtension: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExtension(self, pbstrExtension)
proc GetFragment*(self: ptr IUri, pbstrFragment: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFragment(self, pbstrFragment)
proc GetHost*(self: ptr IUri, pbstrHost: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHost(self, pbstrHost)
proc GetPassword*(self: ptr IUri, pbstrPassword: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPassword(self, pbstrPassword)
proc GetPath*(self: ptr IUri, pbstrPath: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPath(self, pbstrPath)
proc GetPathAndQuery*(self: ptr IUri, pbstrPathAndQuery: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPathAndQuery(self, pbstrPathAndQuery)
proc GetQuery*(self: ptr IUri, pbstrQuery: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetQuery(self, pbstrQuery)
proc GetRawUri*(self: ptr IUri, pbstrRawUri: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRawUri(self, pbstrRawUri)
proc GetSchemeName*(self: ptr IUri, pbstrSchemeName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSchemeName(self, pbstrSchemeName)
proc GetUserInfo*(self: ptr IUri, pbstrUserInfo: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUserInfo(self, pbstrUserInfo)
proc GetUserName*(self: ptr IUri, pbstrUserName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUserName(self, pbstrUserName)
proc GetHostType*(self: ptr IUri, pdwHostType: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHostType(self, pdwHostType)
proc GetPort*(self: ptr IUri, pdwPort: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPort(self, pdwPort)
proc GetScheme*(self: ptr IUri, pdwScheme: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetScheme(self, pdwScheme)
proc GetZone*(self: ptr IUri, pdwZone: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZone(self, pdwZone)
proc GetProperties*(self: ptr IUri, pdwFlags: LPDWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperties(self, pdwFlags)
proc IsEqual*(self: ptr IUri, pUri: ptr IUri, pfEqual: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsEqual(self, pUri, pfEqual)
proc GetIUri*(self: ptr IUriContainer, ppIUri: ptr ptr IUri): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIUri(self, ppIUri)
proc CreateUriSimple*(self: ptr IUriBuilder, dwAllowEncodingPropertyMask: DWORD, dwReserved: DWORD_PTR, ppIUri: ptr ptr IUri): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateUriSimple(self, dwAllowEncodingPropertyMask, dwReserved, ppIUri)
proc CreateUri*(self: ptr IUriBuilder, dwCreateFlags: DWORD, dwAllowEncodingPropertyMask: DWORD, dwReserved: DWORD_PTR, ppIUri: ptr ptr IUri): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateUri(self, dwCreateFlags, dwAllowEncodingPropertyMask, dwReserved, ppIUri)
proc CreateUriWithFlags*(self: ptr IUriBuilder, dwCreateFlags: DWORD, dwUriBuilderFlags: DWORD, dwAllowEncodingPropertyMask: DWORD, dwReserved: DWORD_PTR, ppIUri: ptr ptr IUri): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateUriWithFlags(self, dwCreateFlags, dwUriBuilderFlags, dwAllowEncodingPropertyMask, dwReserved, ppIUri)
proc GetIUri*(self: ptr IUriBuilder, ppIUri: ptr ptr IUri): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIUri(self, ppIUri)
proc SetIUri*(self: ptr IUriBuilder, pIUri: ptr IUri): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetIUri(self, pIUri)
proc GetFragment*(self: ptr IUriBuilder, pcchFragment: ptr DWORD, ppwzFragment: ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFragment(self, pcchFragment, ppwzFragment)
proc GetHost*(self: ptr IUriBuilder, pcchHost: ptr DWORD, ppwzHost: ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHost(self, pcchHost, ppwzHost)
proc GetPassword*(self: ptr IUriBuilder, pcchPassword: ptr DWORD, ppwzPassword: ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPassword(self, pcchPassword, ppwzPassword)
proc GetPath*(self: ptr IUriBuilder, pcchPath: ptr DWORD, ppwzPath: ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPath(self, pcchPath, ppwzPath)
proc GetPort*(self: ptr IUriBuilder, pfHasPort: ptr WINBOOL, pdwPort: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPort(self, pfHasPort, pdwPort)
proc GetQuery*(self: ptr IUriBuilder, pcchQuery: ptr DWORD, ppwzQuery: ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetQuery(self, pcchQuery, ppwzQuery)
proc GetSchemeName*(self: ptr IUriBuilder, pcchSchemeName: ptr DWORD, ppwzSchemeName: ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSchemeName(self, pcchSchemeName, ppwzSchemeName)
proc GetUserName*(self: ptr IUriBuilder, pcchUserName: ptr DWORD, ppwzUserName: ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUserName(self, pcchUserName, ppwzUserName)
proc SetFragment*(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFragment(self, pwzNewValue)
proc SetHost*(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHost(self, pwzNewValue)
proc SetPassword*(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPassword(self, pwzNewValue)
proc SetPath*(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPath(self, pwzNewValue)
proc SetPort*(self: ptr IUriBuilder, fHasPort: WINBOOL, dwNewValue: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPort(self, fHasPort, dwNewValue)
proc SetQuery*(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetQuery(self, pwzNewValue)
proc SetSchemeName*(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSchemeName(self, pwzNewValue)
proc SetUserName*(self: ptr IUriBuilder, pwzNewValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetUserName(self, pwzNewValue)
proc RemoveProperties*(self: ptr IUriBuilder, dwPropertyMask: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveProperties(self, dwPropertyMask)
proc HasBeenModified*(self: ptr IUriBuilder, pfModified: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HasBeenModified(self, pfModified)
proc CreateIUriBuilder*(self: ptr IUriBuilderFactory, dwFlags: DWORD, dwReserved: DWORD_PTR, ppIUriBuilder: ptr ptr IUriBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateIUriBuilder(self, dwFlags, dwReserved, ppIUriBuilder)
proc CreateInitializedIUriBuilder*(self: ptr IUriBuilderFactory, dwFlags: DWORD, dwReserved: DWORD_PTR, ppIUriBuilder: ptr ptr IUriBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInitializedIUriBuilder(self, dwFlags, dwReserved, ppIUriBuilder)
proc mQueryOption*(self: ptr IWinInetInfo, dwOption: DWORD, pBuffer: LPVOID, pcbBuf: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryOption(self, dwOption, pBuffer, pcbBuf)
proc OnSecurityProblem*(self: ptr IHttpSecurity, dwProblem: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnSecurityProblem(self, dwProblem)
proc QueryInfo*(self: ptr IWinInetHttpInfo, dwOption: DWORD, pBuffer: LPVOID, pcbBuf: ptr DWORD, pdwFlags: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryInfo(self, dwOption, pBuffer, pcbBuf, pdwFlags, pdwReserved)
proc GetRequestTimeouts*(self: ptr IWinInetHttpTimeouts, pdwConnectTimeout: ptr DWORD, pdwSendTimeout: ptr DWORD, pdwReceiveTimeout: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRequestTimeouts(self, pdwConnectTimeout, pdwSendTimeout, pdwReceiveTimeout)
proc SetCacheExtension*(self: ptr IWinInetCacheHints, pwzExt: LPCWSTR, pszCacheFile: LPVOID, pcbCacheFile: ptr DWORD, pdwWinInetError: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCacheExtension(self, pwzExt, pszCacheFile, pcbCacheFile, pdwWinInetError, pdwReserved)
proc SetCacheExtension2*(self: ptr IWinInetCacheHints2, pwzExt: LPCWSTR, pwzCacheFile: ptr WCHAR, pcchCacheFile: ptr DWORD, pdwWinInetError: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCacheExtension2(self, pwzExt, pwzCacheFile, pcchCacheFile, pdwWinInetError, pdwReserved)
proc CreateMoniker*(self: ptr IBindHost, szName: LPOLESTR, pBC: ptr IBindCtx, ppmk: ptr ptr IMoniker, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateMoniker(self, szName, pBC, ppmk, dwReserved)
proc MonikerBindToStorage*(self: ptr IBindHost, pMk: ptr IMoniker, pBC: ptr IBindCtx, pBSC: ptr IBindStatusCallback, riid: REFIID, ppvObj: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MonikerBindToStorage(self, pMk, pBC, pBSC, riid, ppvObj)
proc MonikerBindToObject*(self: ptr IBindHost, pMk: ptr IMoniker, pBC: ptr IBindCtx, pBSC: ptr IBindStatusCallback, riid: REFIID, ppvObj: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MonikerBindToObject(self, pMk, pBC, pBSC, riid, ppvObj)
proc GetBindInfo*(self: ptr IInternetBindInfo, grfBINDF: ptr DWORD, pbindinfo: ptr BINDINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindInfo(self, grfBINDF, pbindinfo)
proc GetBindString*(self: ptr IInternetBindInfo, ulStringType: ULONG, ppwzStr: ptr LPOLESTR, cEl: ULONG, pcElFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindString(self, ulStringType, ppwzStr, cEl, pcElFetched)
proc GetBindInfoEx*(self: ptr IInternetBindInfoEx, grfBINDF: ptr DWORD, pbindinfo: ptr BINDINFO, grfBINDF2: ptr DWORD, pdwReserved: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindInfoEx(self, grfBINDF, pbindinfo, grfBINDF2, pdwReserved)
proc Start*(self: ptr IInternetProtocolRoot, szUrl: LPCWSTR, pOIProtSink: ptr IInternetProtocolSink, pOIBindInfo: ptr IInternetBindInfo, grfPI: DWORD, dwReserved: HANDLE_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Start(self, szUrl, pOIProtSink, pOIBindInfo, grfPI, dwReserved)
proc Continue*(self: ptr IInternetProtocolRoot, pProtocolData: ptr PROTOCOLDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Continue(self, pProtocolData)
proc Abort*(self: ptr IInternetProtocolRoot, hrReason: HRESULT, dwOptions: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Abort(self, hrReason, dwOptions)
proc Terminate*(self: ptr IInternetProtocolRoot, dwOptions: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Terminate(self, dwOptions)
proc Suspend*(self: ptr IInternetProtocolRoot): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Suspend(self)
proc Resume*(self: ptr IInternetProtocolRoot): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resume(self)
proc Read*(self: ptr IInternetProtocol, pv: pointer, cb: ULONG, pcbRead: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Read(self, pv, cb, pcbRead)
proc Seek*(self: ptr IInternetProtocol, dlibMove: LARGE_INTEGER, dwOrigin: DWORD, plibNewPosition: ptr ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Seek(self, dlibMove, dwOrigin, plibNewPosition)
proc LockRequest*(self: ptr IInternetProtocol, dwOptions: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockRequest(self, dwOptions)
proc UnlockRequest*(self: ptr IInternetProtocol): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnlockRequest(self)
proc StartEx*(self: ptr IInternetProtocolEx, pUri: ptr IUri, pOIProtSink: ptr IInternetProtocolSink, pOIBindInfo: ptr IInternetBindInfo, grfPI: DWORD, dwReserved: HANDLE_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartEx(self, pUri, pOIProtSink, pOIBindInfo, grfPI, dwReserved)
proc Switch*(self: ptr IInternetProtocolSink, pProtocolData: ptr PROTOCOLDATA): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Switch(self, pProtocolData)
proc ReportProgress*(self: ptr IInternetProtocolSink, ulStatusCode: ULONG, szStatusText: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReportProgress(self, ulStatusCode, szStatusText)
proc ReportData*(self: ptr IInternetProtocolSink, grfBSCF: DWORD, ulProgress: ULONG, ulProgressMax: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReportData(self, grfBSCF, ulProgress, ulProgressMax)
proc ReportResult*(self: ptr IInternetProtocolSink, hrResult: HRESULT, dwError: DWORD, szResult: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReportResult(self, hrResult, dwError, szResult)
proc SwitchSink*(self: ptr IInternetProtocolSinkStackable, pOIProtSink: ptr IInternetProtocolSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SwitchSink(self, pOIProtSink)
proc CommitSwitch*(self: ptr IInternetProtocolSinkStackable): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CommitSwitch(self)
proc RollbackSwitch*(self: ptr IInternetProtocolSinkStackable): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RollbackSwitch(self)
proc RegisterNameSpace*(self: ptr IInternetSession, pCF: ptr IClassFactory, rclsid: REFCLSID, pwzProtocol: LPCWSTR, cPatterns: ULONG, ppwzPatterns: ptr LPCWSTR, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterNameSpace(self, pCF, rclsid, pwzProtocol, cPatterns, ppwzPatterns, dwReserved)
proc UnregisterNameSpace*(self: ptr IInternetSession, pCF: ptr IClassFactory, pszProtocol: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterNameSpace(self, pCF, pszProtocol)
proc RegisterMimeFilter*(self: ptr IInternetSession, pCF: ptr IClassFactory, rclsid: REFCLSID, pwzType: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterMimeFilter(self, pCF, rclsid, pwzType)
proc UnregisterMimeFilter*(self: ptr IInternetSession, pCF: ptr IClassFactory, pwzType: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterMimeFilter(self, pCF, pwzType)
proc CreateBinding*(self: ptr IInternetSession, pBC: LPBC, szUrl: LPCWSTR, pUnkOuter: ptr IUnknown, ppUnk: ptr ptr IUnknown, ppOInetProt: ptr ptr IInternetProtocol, dwOption: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBinding(self, pBC, szUrl, pUnkOuter, ppUnk, ppOInetProt, dwOption)
proc SetSessionOption*(self: ptr IInternetSession, dwOption: DWORD, pBuffer: LPVOID, dwBufferLength: DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSessionOption(self, dwOption, pBuffer, dwBufferLength, dwReserved)
proc GetSessionOption*(self: ptr IInternetSession, dwOption: DWORD, pBuffer: LPVOID, pdwBufferLength: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSessionOption(self, dwOption, pBuffer, pdwBufferLength, dwReserved)
proc Prepare*(self: ptr IInternetThreadSwitch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Prepare(self)
proc Continue*(self: ptr IInternetThreadSwitch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Continue(self)
proc SetPriority*(self: ptr IInternetPriority, nPriority: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPriority(self, nPriority)
proc GetPriority*(self: ptr IInternetPriority, pnPriority: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPriority(self, pnPriority)
proc ParseUrl*(self: ptr IInternetProtocolInfo, pwzUrl: LPCWSTR, ParseAction: PARSEACTION, dwParseFlags: DWORD, pwzResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseUrl(self, pwzUrl, ParseAction, dwParseFlags, pwzResult, cchResult, pcchResult, dwReserved)
proc CombineUrl*(self: ptr IInternetProtocolInfo, pwzBaseUrl: LPCWSTR, pwzRelativeUrl: LPCWSTR, dwCombineFlags: DWORD, pwzResult: LPWSTR, cchResult: DWORD, pcchResult: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CombineUrl(self, pwzBaseUrl, pwzRelativeUrl, dwCombineFlags, pwzResult, cchResult, pcchResult, dwReserved)
proc CompareUrl*(self: ptr IInternetProtocolInfo, pwzUrl1: LPCWSTR, pwzUrl2: LPCWSTR, dwCompareFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CompareUrl(self, pwzUrl1, pwzUrl2, dwCompareFlags)
proc QueryInfo*(self: ptr IInternetProtocolInfo, pwzUrl: LPCWSTR, OueryOption: QUERYOPTION, dwQueryFlags: DWORD, pBuffer: LPVOID, cbBuffer: DWORD, pcbBuf: ptr DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryInfo(self, pwzUrl, OueryOption, dwQueryFlags, pBuffer, cbBuffer, pcbBuf, dwReserved)
proc GetWindow*(self: ptr IInternetSecurityMgrSite, phwnd: ptr HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWindow(self, phwnd)
proc EnableModeless*(self: ptr IInternetSecurityMgrSite, fEnable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnableModeless(self, fEnable)
proc SetSecuritySite*(self: ptr IInternetSecurityManager, pSite: ptr IInternetSecurityMgrSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSecuritySite(self, pSite)
proc GetSecuritySite*(self: ptr IInternetSecurityManager, ppSite: ptr ptr IInternetSecurityMgrSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSecuritySite(self, ppSite)
proc MapUrlToZone*(self: ptr IInternetSecurityManager, pwszUrl: LPCWSTR, pdwZone: ptr DWORD, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MapUrlToZone(self, pwszUrl, pdwZone, dwFlags)
proc GetSecurityId*(self: ptr IInternetSecurityManager, pwszUrl: LPCWSTR, pbSecurityId: ptr BYTE, pcbSecurityId: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSecurityId(self, pwszUrl, pbSecurityId, pcbSecurityId, dwReserved)
proc ProcessUrlAction*(self: ptr IInternetSecurityManager, pwszUrl: LPCWSTR, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, pContext: ptr BYTE, cbContext: DWORD, dwFlags: DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProcessUrlAction(self, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved)
proc QueryCustomPolicy*(self: ptr IInternetSecurityManager, pwszUrl: LPCWSTR, guidKey: REFGUID, ppPolicy: ptr ptr BYTE, pcbPolicy: ptr DWORD, pContext: ptr BYTE, cbContext: DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryCustomPolicy(self, pwszUrl, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved)
proc SetZoneMapping*(self: ptr IInternetSecurityManager, dwZone: DWORD, lpszPattern: LPCWSTR, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetZoneMapping(self, dwZone, lpszPattern, dwFlags)
proc GetZoneMappings*(self: ptr IInternetSecurityManager, dwZone: DWORD, ppenumString: ptr ptr IEnumString, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZoneMappings(self, dwZone, ppenumString, dwFlags)
proc ProcessUrlActionEx*(self: ptr IInternetSecurityManagerEx, pwszUrl: LPCWSTR, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, pContext: ptr BYTE, cbContext: DWORD, dwFlags: DWORD, dwReserved: DWORD, pdwOutFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProcessUrlActionEx(self, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags)
proc MapUrlToZoneEx2*(self: ptr IInternetSecurityManagerEx2, pUri: ptr IUri, pdwZone: ptr DWORD, dwFlags: DWORD, ppwszMappedUrl: ptr LPWSTR, pdwOutFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MapUrlToZoneEx2(self, pUri, pdwZone, dwFlags, ppwszMappedUrl, pdwOutFlags)
proc ProcessUrlActionEx2*(self: ptr IInternetSecurityManagerEx2, pUri: ptr IUri, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, pContext: ptr BYTE, cbContext: DWORD, dwFlags: DWORD, dwReserved: DWORD_PTR, pdwOutFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProcessUrlActionEx2(self, pUri, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags)
proc GetSecurityIdEx2*(self: ptr IInternetSecurityManagerEx2, pUri: ptr IUri, pbSecurityId: ptr BYTE, pcbSecurityId: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSecurityIdEx2(self, pUri, pbSecurityId, pcbSecurityId, dwReserved)
proc QueryCustomPolicyEx2*(self: ptr IInternetSecurityManagerEx2, pUri: ptr IUri, guidKey: REFGUID, ppPolicy: ptr ptr BYTE, pcbPolicy: ptr DWORD, pContext: ptr BYTE, cbContext: DWORD, dwReserved: DWORD_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryCustomPolicyEx2(self, pUri, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved)
proc GetId*(self: ptr IZoneIdentifier, pdwZone: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetId(self, pdwZone)
proc SetId*(self: ptr IZoneIdentifier, dwZone: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetId(self, dwZone)
proc Remove*(self: ptr IZoneIdentifier): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Remove(self)
proc GetSecurityId*(self: ptr IInternetHostSecurityManager, pbSecurityId: ptr BYTE, pcbSecurityId: ptr DWORD, dwReserved: DWORD_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSecurityId(self, pbSecurityId, pcbSecurityId, dwReserved)
proc ProcessUrlAction*(self: ptr IInternetHostSecurityManager, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, pContext: ptr BYTE, cbContext: DWORD, dwFlags: DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProcessUrlAction(self, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved)
proc QueryCustomPolicy*(self: ptr IInternetHostSecurityManager, guidKey: REFGUID, ppPolicy: ptr ptr BYTE, pcbPolicy: ptr DWORD, pContext: ptr BYTE, cbContext: DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryCustomPolicy(self, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved)
proc GetZoneAttributes*(self: ptr IInternetZoneManager, dwZone: DWORD, pZoneAttributes: ptr ZONEATTRIBUTES): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZoneAttributes(self, dwZone, pZoneAttributes)
proc SetZoneAttributes*(self: ptr IInternetZoneManager, dwZone: DWORD, pZoneAttributes: ptr ZONEATTRIBUTES): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetZoneAttributes(self, dwZone, pZoneAttributes)
proc GetZoneCustomPolicy*(self: ptr IInternetZoneManager, dwZone: DWORD, guidKey: REFGUID, ppPolicy: ptr ptr BYTE, pcbPolicy: ptr DWORD, urlZoneReg: URLZONEREG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZoneCustomPolicy(self, dwZone, guidKey, ppPolicy, pcbPolicy, urlZoneReg)
proc SetZoneCustomPolicy*(self: ptr IInternetZoneManager, dwZone: DWORD, guidKey: REFGUID, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetZoneCustomPolicy(self, dwZone, guidKey, pPolicy, cbPolicy, urlZoneReg)
proc GetZoneActionPolicy*(self: ptr IInternetZoneManager, dwZone: DWORD, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZoneActionPolicy(self, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg)
proc SetZoneActionPolicy*(self: ptr IInternetZoneManager, dwZone: DWORD, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetZoneActionPolicy(self, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg)
proc PromptAction*(self: ptr IInternetZoneManager, dwAction: DWORD, hwndParent: HWND, pwszUrl: LPCWSTR, pwszText: LPCWSTR, dwPromptFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PromptAction(self, dwAction, hwndParent, pwszUrl, pwszText, dwPromptFlags)
proc LogAction*(self: ptr IInternetZoneManager, dwAction: DWORD, pwszUrl: LPCWSTR, pwszText: LPCWSTR, dwLogFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LogAction(self, dwAction, pwszUrl, pwszText, dwLogFlags)
proc CreateZoneEnumerator*(self: ptr IInternetZoneManager, pdwEnum: ptr DWORD, pdwCount: ptr DWORD, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateZoneEnumerator(self, pdwEnum, pdwCount, dwFlags)
proc GetZoneAt*(self: ptr IInternetZoneManager, dwEnum: DWORD, dwIndex: DWORD, pdwZone: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZoneAt(self, dwEnum, dwIndex, pdwZone)
proc DestroyZoneEnumerator*(self: ptr IInternetZoneManager, dwEnum: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DestroyZoneEnumerator(self, dwEnum)
proc CopyTemplatePoliciesToZone*(self: ptr IInternetZoneManager, dwTemplate: DWORD, dwZone: DWORD, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyTemplatePoliciesToZone(self, dwTemplate, dwZone, dwReserved)
proc GetZoneActionPolicyEx*(self: ptr IInternetZoneManagerEx, dwZone: DWORD, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZoneActionPolicyEx(self, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags)
proc SetZoneActionPolicyEx*(self: ptr IInternetZoneManagerEx, dwZone: DWORD, dwAction: DWORD, pPolicy: ptr BYTE, cbPolicy: DWORD, urlZoneReg: URLZONEREG, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetZoneActionPolicyEx(self, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags)
proc GetZoneAttributesEx*(self: ptr IInternetZoneManagerEx2, dwZone: DWORD, pZoneAttributes: ptr ZONEATTRIBUTES, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZoneAttributesEx(self, dwZone, pZoneAttributes, dwFlags)
proc GetZoneSecurityState*(self: ptr IInternetZoneManagerEx2, dwZoneIndex: DWORD, fRespectPolicy: WINBOOL, pdwState: LPDWORD, pfPolicyEncountered: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetZoneSecurityState(self, dwZoneIndex, fRespectPolicy, pdwState, pfPolicyEncountered)
proc GetIESecurityState*(self: ptr IInternetZoneManagerEx2, fRespectPolicy: WINBOOL, pdwState: LPDWORD, pfPolicyEncountered: ptr WINBOOL, fNoCache: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIESecurityState(self, fRespectPolicy, pdwState, pfPolicyEncountered, fNoCache)
proc FixUnsecureSettings*(self: ptr IInternetZoneManagerEx2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FixUnsecureSettings(self)
proc ProcessSoftDist*(self: ptr ISoftDistExt, szCDFURL: LPCWSTR, pSoftDistElement: ptr IXMLElement, lpsdi: LPSOFTDISTINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProcessSoftDist(self, szCDFURL, pSoftDistElement, lpsdi)
proc GetFirstCodeBase*(self: ptr ISoftDistExt, szCodeBase: ptr LPWSTR, dwMaxSize: LPDWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFirstCodeBase(self, szCodeBase, dwMaxSize)
proc GetNextCodeBase*(self: ptr ISoftDistExt, szCodeBase: ptr LPWSTR, dwMaxSize: LPDWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNextCodeBase(self, szCodeBase, dwMaxSize)
proc AsyncInstallDistributionUnit*(self: ptr ISoftDistExt, pbc: ptr IBindCtx, pvReserved: LPVOID, flags: DWORD, lpcbh: LPCODEBASEHOLD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AsyncInstallDistributionUnit(self, pbc, pvReserved, flags, lpcbh)
proc GetCatalogFile*(self: ptr ICatalogFileInfo, ppszCatalogFile: ptr LPSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCatalogFile(self, ppszCatalogFile)
proc GetJavaTrust*(self: ptr ICatalogFileInfo, ppJavaTrust: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetJavaTrust(self, ppJavaTrust)
proc DoEncode*(self: ptr IDataFilter, dwFlags: DWORD, lInBufferSize: LONG, pbInBuffer: ptr BYTE, lOutBufferSize: LONG, pbOutBuffer: ptr BYTE, lInBytesAvailable: LONG, plInBytesRead: ptr LONG, plOutBytesWritten: ptr LONG, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoEncode(self, dwFlags, lInBufferSize, pbInBuffer, lOutBufferSize, pbOutBuffer, lInBytesAvailable, plInBytesRead, plOutBytesWritten, dwReserved)
proc DoDecode*(self: ptr IDataFilter, dwFlags: DWORD, lInBufferSize: LONG, pbInBuffer: ptr BYTE, lOutBufferSize: LONG, pbOutBuffer: ptr BYTE, lInBytesAvailable: LONG, plInBytesRead: ptr LONG, plOutBytesWritten: ptr LONG, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoDecode(self, dwFlags, lInBufferSize, pbInBuffer, lOutBufferSize, pbOutBuffer, lInBytesAvailable, plInBytesRead, plOutBytesWritten, dwReserved)
proc SetEncodingLevel*(self: ptr IDataFilter, dwEncLevel: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetEncodingLevel(self, dwEncLevel)
proc FindBestFilter*(self: ptr IEncodingFilterFactory, pwzCodeIn: LPCWSTR, pwzCodeOut: LPCWSTR, info: DATAINFO, ppDF: ptr ptr IDataFilter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindBestFilter(self, pwzCodeIn, pwzCodeOut, info, ppDF)
proc GetDefaultFilter*(self: ptr IEncodingFilterFactory, pwzCodeIn: LPCWSTR, pwzCodeOut: LPCWSTR, ppDF: ptr ptr IDataFilter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultFilter(self, pwzCodeIn, pwzCodeOut, ppDF)
proc GetWrapperCode*(self: ptr IWrappedProtocol, pnCode: ptr LONG, dwReserved: DWORD_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWrapperCode(self, pnCode, dwReserved)
proc GetBindHandle*(self: ptr IGetBindHandle, enumRequestedHandle: BINDHANDLETYPES, pRetHandle: ptr HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindHandle(self, enumRequestedHandle, pRetHandle)
proc Redirect*(self: ptr IBindCallbackRedirect, lpcUrl: LPCWSTR, vbCancel: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Redirect(self, lpcUrl, vbCancel)
proc ReadMultiple*(self: ptr IPropertyStorage, cpspec: ULONG, rgpspec: ptr PROPSPEC, rgpropvar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReadMultiple(self, cpspec, rgpspec, rgpropvar)
proc WriteMultiple*(self: ptr IPropertyStorage, cpspec: ULONG, rgpspec: ptr PROPSPEC, rgpropvar: ptr PROPVARIANT, propidNameFirst: PROPID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WriteMultiple(self, cpspec, rgpspec, rgpropvar, propidNameFirst)
proc DeleteMultiple*(self: ptr IPropertyStorage, cpspec: ULONG, rgpspec: ptr PROPSPEC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteMultiple(self, cpspec, rgpspec)
proc ReadPropertyNames*(self: ptr IPropertyStorage, cpropid: ULONG, rgpropid: ptr PROPID, rglpwstrName: ptr LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReadPropertyNames(self, cpropid, rgpropid, rglpwstrName)
proc WritePropertyNames*(self: ptr IPropertyStorage, cpropid: ULONG, rgpropid: ptr PROPID, rglpwstrName: ptr LPOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WritePropertyNames(self, cpropid, rgpropid, rglpwstrName)
proc DeletePropertyNames*(self: ptr IPropertyStorage, cpropid: ULONG, rgpropid: ptr PROPID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeletePropertyNames(self, cpropid, rgpropid)
proc Commit*(self: ptr IPropertyStorage, grfCommitFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self, grfCommitFlags)
proc Revert*(self: ptr IPropertyStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Revert(self)
proc Enum*(self: ptr IPropertyStorage, ppenum: ptr ptr IEnumSTATPROPSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Enum(self, ppenum)
proc SetTimes*(self: ptr IPropertyStorage, pctime: ptr FILETIME, patime: ptr FILETIME, pmtime: ptr FILETIME): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTimes(self, pctime, patime, pmtime)
proc SetClass*(self: ptr IPropertyStorage, clsid: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetClass(self, clsid)
proc Stat*(self: ptr IPropertyStorage, pstatpsstg: ptr STATPROPSETSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Stat(self, pstatpsstg)
proc Create*(self: ptr IPropertySetStorage, rfmtid: REFFMTID, pclsid: ptr CLSID, grfFlags: DWORD, grfMode: DWORD, ppprstg: ptr ptr IPropertyStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Create(self, rfmtid, pclsid, grfFlags, grfMode, ppprstg)
proc Open*(self: ptr IPropertySetStorage, rfmtid: REFFMTID, grfMode: DWORD, ppprstg: ptr ptr IPropertyStorage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Open(self, rfmtid, grfMode, ppprstg)
proc mDelete*(self: ptr IPropertySetStorage, rfmtid: REFFMTID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Delete(self, rfmtid)
proc Enum*(self: ptr IPropertySetStorage, ppenum: ptr ptr IEnumSTATPROPSETSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Enum(self, ppenum)
proc Next*(self: ptr IEnumSTATPROPSTG, celt: ULONG, rgelt: ptr STATPROPSTG, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumSTATPROPSTG, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumSTATPROPSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumSTATPROPSTG, ppenum: ptr ptr IEnumSTATPROPSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc Next*(self: ptr IEnumSTATPROPSETSTG, celt: ULONG, rgelt: ptr STATPROPSETSTG, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumSTATPROPSETSTG, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumSTATPROPSETSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumSTATPROPSETSTG, ppenum: ptr ptr IEnumSTATPROPSETSTG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc Next*(self: ptr IEnumConnections, cConnections: ULONG, rgcd: LPCONNECTDATA, pcFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, cConnections, rgcd, pcFetched)
proc Skip*(self: ptr IEnumConnections, cConnections: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, cConnections)
proc Reset*(self: ptr IEnumConnections): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumConnections, ppEnum: ptr ptr IEnumConnections): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc GetConnectionInterface*(self: ptr IConnectionPoint, pIID: ptr IID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConnectionInterface(self, pIID)
proc GetConnectionPointContainer*(self: ptr IConnectionPoint, ppCPC: ptr ptr IConnectionPointContainer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConnectionPointContainer(self, ppCPC)
proc Advise*(self: ptr IConnectionPoint, pUnkSink: ptr IUnknown, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Advise(self, pUnkSink, pdwCookie)
proc Unadvise*(self: ptr IConnectionPoint, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unadvise(self, dwCookie)
proc EnumConnections*(self: ptr IConnectionPoint, ppEnum: ptr ptr IEnumConnections): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumConnections(self, ppEnum)
proc Next*(self: ptr IEnumConnectionPoints, cConnections: ULONG, ppCP: ptr LPCONNECTIONPOINT, pcFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, cConnections, ppCP, pcFetched)
proc Skip*(self: ptr IEnumConnectionPoints, cConnections: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, cConnections)
proc Reset*(self: ptr IEnumConnectionPoints): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumConnectionPoints, ppEnum: ptr ptr IEnumConnectionPoints): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc EnumConnectionPoints*(self: ptr IConnectionPointContainer, ppEnum: ptr ptr IEnumConnectionPoints): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumConnectionPoints(self, ppEnum)
proc FindConnectionPoint*(self: ptr IConnectionPointContainer, riid: REFIID, ppCP: ptr ptr IConnectionPoint): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindConnectionPoint(self, riid, ppCP)
proc GetLicInfo*(self: ptr IClassFactory2, pLicInfo: ptr LICINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLicInfo(self, pLicInfo)
proc RequestLicKey*(self: ptr IClassFactory2, dwReserved: DWORD, pBstrKey: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestLicKey(self, dwReserved, pBstrKey)
proc CreateInstanceLic*(self: ptr IClassFactory2, pUnkOuter: ptr IUnknown, pUnkReserved: ptr IUnknown, riid: REFIID, bstrKey: BSTR, ppvObj: ptr PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstanceLic(self, pUnkOuter, pUnkReserved, riid, bstrKey, ppvObj)
proc GetClassInfo*(self: ptr IProvideClassInfo, ppTI: ptr ptr ITypeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClassInfo(self, ppTI)
proc GetGUID*(self: ptr IProvideClassInfo2, dwGuidKind: DWORD, pGUID: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGUID(self, dwGuidKind, pGUID)
proc GetMultiTypeInfoCount*(self: ptr IProvideMultipleClassInfo, pcti: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMultiTypeInfoCount(self, pcti)
proc GetInfoOfIndex*(self: ptr IProvideMultipleClassInfo, iti: ULONG, dwFlags: DWORD, pptiCoClass: ptr ptr ITypeInfo, pdwTIFlags: ptr DWORD, pcdispidReserved: ptr ULONG, piidPrimary: ptr IID, piidSource: ptr IID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInfoOfIndex(self, iti, dwFlags, pptiCoClass, pdwTIFlags, pcdispidReserved, piidPrimary, piidSource)
proc GetControlInfo*(self: ptr IOleControl, pCI: ptr CONTROLINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetControlInfo(self, pCI)
proc OnMnemonic*(self: ptr IOleControl, pMsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnMnemonic(self, pMsg)
proc OnAmbientPropertyChange*(self: ptr IOleControl, dispID: DISPID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnAmbientPropertyChange(self, dispID)
proc FreezeEvents*(self: ptr IOleControl, bFreeze: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FreezeEvents(self, bFreeze)
proc OnControlInfoChanged*(self: ptr IOleControlSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnControlInfoChanged(self)
proc LockInPlaceActive*(self: ptr IOleControlSite, fLock: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LockInPlaceActive(self, fLock)
proc GetExtendedControl*(self: ptr IOleControlSite, ppDisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExtendedControl(self, ppDisp)
proc TransformCoords*(self: ptr IOleControlSite, pPtlHimetric: ptr POINTL, pPtfContainer: ptr POINTF, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TransformCoords(self, pPtlHimetric, pPtfContainer, dwFlags)
proc TranslateAccelerator*(self: ptr IOleControlSite, pMsg: ptr MSG, grfModifiers: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAccelerator(self, pMsg, grfModifiers)
proc OnFocus*(self: ptr IOleControlSite, fGotFocus: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnFocus(self, fGotFocus)
proc ShowPropertyFrame*(self: ptr IOleControlSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowPropertyFrame(self)
proc SetPageSite*(self: ptr IPropertyPage, pPageSite: ptr IPropertyPageSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPageSite(self, pPageSite)
proc Activate*(self: ptr IPropertyPage, hWndParent: HWND, pRect: LPCRECT, bModal: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Activate(self, hWndParent, pRect, bModal)
proc Deactivate*(self: ptr IPropertyPage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Deactivate(self)
proc GetPageInfo*(self: ptr IPropertyPage, pPageInfo: ptr PROPPAGEINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPageInfo(self, pPageInfo)
proc SetObjects*(self: ptr IPropertyPage, cObjects: ULONG, ppUnk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetObjects(self, cObjects, ppUnk)
proc Show*(self: ptr IPropertyPage, nCmdShow: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Show(self, nCmdShow)
proc Move*(self: ptr IPropertyPage, pRect: LPCRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Move(self, pRect)
proc IsPageDirty*(self: ptr IPropertyPage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsPageDirty(self)
proc Apply*(self: ptr IPropertyPage): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Apply(self)
proc Help*(self: ptr IPropertyPage, pszHelpDir: LPCOLESTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Help(self, pszHelpDir)
proc TranslateAccelerator*(self: ptr IPropertyPage, pMsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAccelerator(self, pMsg)
proc EditProperty*(self: ptr IPropertyPage2, dispID: DISPID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EditProperty(self, dispID)
proc OnStatusChange*(self: ptr IPropertyPageSite, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnStatusChange(self, dwFlags)
proc GetLocaleID*(self: ptr IPropertyPageSite, pLocaleID: ptr LCID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLocaleID(self, pLocaleID)
proc GetPageContainer*(self: ptr IPropertyPageSite, ppUnk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPageContainer(self, ppUnk)
proc TranslateAccelerator*(self: ptr IPropertyPageSite, pMsg: ptr MSG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TranslateAccelerator(self, pMsg)
proc OnChanged*(self: ptr IPropertyNotifySink, dispID: DISPID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnChanged(self, dispID)
proc OnRequestEdit*(self: ptr IPropertyNotifySink, dispID: DISPID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnRequestEdit(self, dispID)
proc GetPages*(self: ptr ISpecifyPropertyPages, pPages: ptr CAUUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPages(self, pPages)
proc IsDirty*(self: ptr IPersistMemory): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDirty(self)
proc Load*(self: ptr IPersistMemory, pMem: LPVOID, cbSize: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, pMem, cbSize)
proc Save*(self: ptr IPersistMemory, pMem: LPVOID, fClearDirty: WINBOOL, cbSize: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, pMem, fClearDirty, cbSize)
proc GetSizeMax*(self: ptr IPersistMemory, pCbSize: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSizeMax(self, pCbSize)
proc InitNew*(self: ptr IPersistMemory): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitNew(self)
proc IsDirty*(self: ptr IPersistStreamInit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDirty(self)
proc Load*(self: ptr IPersistStreamInit, pStm: LPSTREAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, pStm)
proc Save*(self: ptr IPersistStreamInit, pStm: LPSTREAM, fClearDirty: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, pStm, fClearDirty)
proc GetSizeMax*(self: ptr IPersistStreamInit, pCbSize: ptr ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSizeMax(self, pCbSize)
proc InitNew*(self: ptr IPersistStreamInit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitNew(self)
proc InitNew*(self: ptr IPersistPropertyBag): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitNew(self)
proc Load*(self: ptr IPersistPropertyBag, pPropBag: ptr IPropertyBag, pErrorLog: ptr IErrorLog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, pPropBag, pErrorLog)
proc Save*(self: ptr IPersistPropertyBag, pPropBag: ptr IPropertyBag, fClearDirty: WINBOOL, fSaveAllProperties: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, pPropBag, fClearDirty, fSaveAllProperties)
proc PreMessageFilter*(self: ptr ISimpleFrameSite, hWnd: HWND, msg: UINT, wp: WPARAM, lp: LPARAM, plResult: ptr LRESULT, pdwCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PreMessageFilter(self, hWnd, msg, wp, lp, plResult, pdwCookie)
proc PostMessageFilter*(self: ptr ISimpleFrameSite, hWnd: HWND, msg: UINT, wp: WPARAM, lp: LPARAM, plResult: ptr LRESULT, dwCookie: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PostMessageFilter(self, hWnd, msg, wp, lp, plResult, dwCookie)
proc get_Name*(self: ptr IFont, pName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Name(self, pName)
proc put_Name*(self: ptr IFont, name: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Name(self, name)
proc get_Size*(self: ptr IFont, pSize: ptr CY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Size(self, pSize)
proc put_Size*(self: ptr IFont, size: CY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Size(self, size)
proc get_Bold*(self: ptr IFont, pBold: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Bold(self, pBold)
proc put_Bold*(self: ptr IFont, bold: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Bold(self, bold)
proc get_Italic*(self: ptr IFont, pItalic: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Italic(self, pItalic)
proc put_Italic*(self: ptr IFont, italic: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Italic(self, italic)
proc get_Underline*(self: ptr IFont, pUnderline: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Underline(self, pUnderline)
proc put_Underline*(self: ptr IFont, underline: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Underline(self, underline)
proc get_Strikethrough*(self: ptr IFont, pStrikethrough: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Strikethrough(self, pStrikethrough)
proc put_Strikethrough*(self: ptr IFont, strikethrough: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Strikethrough(self, strikethrough)
proc get_Weight*(self: ptr IFont, pWeight: ptr SHORT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Weight(self, pWeight)
proc put_Weight*(self: ptr IFont, weight: SHORT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Weight(self, weight)
proc get_Charset*(self: ptr IFont, pCharset: ptr SHORT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Charset(self, pCharset)
proc put_Charset*(self: ptr IFont, charset: SHORT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Charset(self, charset)
proc get_hFont*(self: ptr IFont, phFont: ptr HFONT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_hFont(self, phFont)
proc Clone*(self: ptr IFont, ppFont: ptr ptr IFont): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppFont)
proc IsEqual*(self: ptr IFont, pFontOther: ptr IFont): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsEqual(self, pFontOther)
proc SetRatio*(self: ptr IFont, cyLogical: LONG, cyHimetric: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRatio(self, cyLogical, cyHimetric)
proc QueryTextMetrics*(self: ptr IFont, pTM: ptr TEXTMETRICOLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryTextMetrics(self, pTM)
proc AddRefHfont*(self: ptr IFont, hFont: HFONT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddRefHfont(self, hFont)
proc ReleaseHfont*(self: ptr IFont, hFont: HFONT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseHfont(self, hFont)
proc SetHdc*(self: ptr IFont, hDC: HDC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHdc(self, hDC)
proc get_Handle*(self: ptr IPicture, pHandle: ptr OLE_HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Handle(self, pHandle)
proc get_hPal*(self: ptr IPicture, phPal: ptr OLE_HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_hPal(self, phPal)
proc get_Type*(self: ptr IPicture, pType: ptr SHORT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Type(self, pType)
proc get_Width*(self: ptr IPicture, pWidth: ptr OLE_XSIZE_HIMETRIC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Width(self, pWidth)
proc get_Height*(self: ptr IPicture, pHeight: ptr OLE_YSIZE_HIMETRIC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Height(self, pHeight)
proc Render*(self: ptr IPicture, hDC: HDC, x: LONG, y: LONG, cx: LONG, cy: LONG, xSrc: OLE_XPOS_HIMETRIC, ySrc: OLE_YPOS_HIMETRIC, cxSrc: OLE_XSIZE_HIMETRIC, cySrc: OLE_YSIZE_HIMETRIC, pRcWBounds: LPCRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Render(self, hDC, x, y, cx, cy, xSrc, ySrc, cxSrc, cySrc, pRcWBounds)
proc set_hPal*(self: ptr IPicture, hPal: OLE_HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.set_hPal(self, hPal)
proc get_CurDC*(self: ptr IPicture, phDC: ptr HDC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurDC(self, phDC)
proc SelectPicture*(self: ptr IPicture, hDCIn: HDC, phDCOut: ptr HDC, phBmpOut: ptr OLE_HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectPicture(self, hDCIn, phDCOut, phBmpOut)
proc get_KeepOriginalFormat*(self: ptr IPicture, pKeep: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_KeepOriginalFormat(self, pKeep)
proc put_KeepOriginalFormat*(self: ptr IPicture, keep: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_KeepOriginalFormat(self, keep)
proc PictureChanged*(self: ptr IPicture): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PictureChanged(self)
proc SaveAsFile*(self: ptr IPicture, pStream: LPSTREAM, fSaveMemCopy: WINBOOL, pCbSize: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveAsFile(self, pStream, fSaveMemCopy, pCbSize)
proc get_Attributes*(self: ptr IPicture, pDwAttr: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Attributes(self, pDwAttr)
proc get_Handle*(self: ptr IPicture2, pHandle: ptr HHANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Handle(self, pHandle)
proc get_hPal*(self: ptr IPicture2, phPal: ptr HHANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_hPal(self, phPal)
proc get_Type*(self: ptr IPicture2, pType: ptr SHORT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Type(self, pType)
proc get_Width*(self: ptr IPicture2, pWidth: ptr OLE_XSIZE_HIMETRIC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Width(self, pWidth)
proc get_Height*(self: ptr IPicture2, pHeight: ptr OLE_YSIZE_HIMETRIC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Height(self, pHeight)
proc Render*(self: ptr IPicture2, hDC: HDC, x: LONG, y: LONG, cx: LONG, cy: LONG, xSrc: OLE_XPOS_HIMETRIC, ySrc: OLE_YPOS_HIMETRIC, cxSrc: OLE_XSIZE_HIMETRIC, cySrc: OLE_YSIZE_HIMETRIC, pRcWBounds: LPCRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Render(self, hDC, x, y, cx, cy, xSrc, ySrc, cxSrc, cySrc, pRcWBounds)
proc set_hPal*(self: ptr IPicture2, hPal: HHANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.set_hPal(self, hPal)
proc get_CurDC*(self: ptr IPicture2, phDC: ptr HDC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurDC(self, phDC)
proc SelectPicture*(self: ptr IPicture2, hDCIn: HDC, phDCOut: ptr HDC, phBmpOut: ptr HHANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectPicture(self, hDCIn, phDCOut, phBmpOut)
proc get_KeepOriginalFormat*(self: ptr IPicture2, pKeep: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_KeepOriginalFormat(self, pKeep)
proc put_KeepOriginalFormat*(self: ptr IPicture2, keep: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_KeepOriginalFormat(self, keep)
proc PictureChanged*(self: ptr IPicture2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PictureChanged(self)
proc SaveAsFile*(self: ptr IPicture2, pStream: LPSTREAM, fSaveMemCopy: WINBOOL, pCbSize: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveAsFile(self, pStream, fSaveMemCopy, pCbSize)
proc get_Attributes*(self: ptr IPicture2, pDwAttr: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Attributes(self, pDwAttr)
proc OnWindowMessage*(self: ptr IOleInPlaceObjectWindowless, msg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnWindowMessage(self, msg, wParam, lParam, plResult)
proc GetDropTarget*(self: ptr IOleInPlaceObjectWindowless, ppDropTarget: ptr ptr IDropTarget): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDropTarget(self, ppDropTarget)
proc OnInPlaceActivateEx*(self: ptr IOleInPlaceSiteEx, pfNoRedraw: ptr WINBOOL, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnInPlaceActivateEx(self, pfNoRedraw, dwFlags)
proc OnInPlaceDeactivateEx*(self: ptr IOleInPlaceSiteEx, fNoRedraw: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnInPlaceDeactivateEx(self, fNoRedraw)
proc RequestUIActivate*(self: ptr IOleInPlaceSiteEx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestUIActivate(self)
proc CanWindowlessActivate*(self: ptr IOleInPlaceSiteWindowless): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CanWindowlessActivate(self)
proc GetCapture*(self: ptr IOleInPlaceSiteWindowless): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCapture(self)
proc SetCapture*(self: ptr IOleInPlaceSiteWindowless, fCapture: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCapture(self, fCapture)
proc GetFocus*(self: ptr IOleInPlaceSiteWindowless): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFocus(self)
proc SetFocus*(self: ptr IOleInPlaceSiteWindowless, fFocus: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFocus(self, fFocus)
proc GetDC*(self: ptr IOleInPlaceSiteWindowless, pRect: LPCRECT, grfFlags: DWORD, phDC: ptr HDC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDC(self, pRect, grfFlags, phDC)
proc ReleaseDC*(self: ptr IOleInPlaceSiteWindowless, hDC: HDC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseDC(self, hDC)
proc InvalidateRect*(self: ptr IOleInPlaceSiteWindowless, pRect: LPCRECT, fErase: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvalidateRect(self, pRect, fErase)
proc InvalidateRgn*(self: ptr IOleInPlaceSiteWindowless, hRGN: HRGN, fErase: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvalidateRgn(self, hRGN, fErase)
proc ScrollRect*(self: ptr IOleInPlaceSiteWindowless, dx: INT, dy: INT, pRectScroll: LPCRECT, pRectClip: LPCRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ScrollRect(self, dx, dy, pRectScroll, pRectClip)
proc AdjustRect*(self: ptr IOleInPlaceSiteWindowless, prc: LPRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AdjustRect(self, prc)
proc OnDefWindowMessage*(self: ptr IOleInPlaceSiteWindowless, msg: UINT, wParam: WPARAM, lParam: LPARAM, plResult: ptr LRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDefWindowMessage(self, msg, wParam, lParam, plResult)
proc GetRect*(self: ptr IViewObjectEx, dwAspect: DWORD, pRect: LPRECTL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRect(self, dwAspect, pRect)
proc GetViewStatus*(self: ptr IViewObjectEx, pdwStatus: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewStatus(self, pdwStatus)
proc QueryHitPoint*(self: ptr IViewObjectEx, dwAspect: DWORD, pRectBounds: LPCRECT, ptlLoc: POINT, lCloseHint: LONG, pHitResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryHitPoint(self, dwAspect, pRectBounds, ptlLoc, lCloseHint, pHitResult)
proc QueryHitRect*(self: ptr IViewObjectEx, dwAspect: DWORD, pRectBounds: LPCRECT, pRectLoc: LPCRECT, lCloseHint: LONG, pHitResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryHitRect(self, dwAspect, pRectBounds, pRectLoc, lCloseHint, pHitResult)
proc GetNaturalExtent*(self: ptr IViewObjectEx, dwAspect: DWORD, lindex: LONG, ptd: ptr DVTARGETDEVICE, hicTargetDev: HDC, pExtentInfo: ptr DVEXTENTINFO, pSizel: LPSIZEL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNaturalExtent(self, dwAspect, lindex, ptd, hicTargetDev, pExtentInfo, pSizel)
proc Do*(self: ptr IOleUndoUnit, pUndoManager: ptr IOleUndoManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Do(self, pUndoManager)
proc GetDescription*(self: ptr IOleUndoUnit, pBstr: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDescription(self, pBstr)
proc GetUnitType*(self: ptr IOleUndoUnit, pClsid: ptr CLSID, plID: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUnitType(self, pClsid, plID)
proc OnNextAdd*(self: ptr IOleUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnNextAdd(self)
proc Open*(self: ptr IOleParentUndoUnit, pPUU: ptr IOleParentUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Open(self, pPUU)
proc Close*(self: ptr IOleParentUndoUnit, pPUU: ptr IOleParentUndoUnit, fCommit: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Close(self, pPUU, fCommit)
proc Add*(self: ptr IOleParentUndoUnit, pUU: ptr IOleUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Add(self, pUU)
proc FindUnit*(self: ptr IOleParentUndoUnit, pUU: ptr IOleUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindUnit(self, pUU)
proc GetParentState*(self: ptr IOleParentUndoUnit, pdwState: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetParentState(self, pdwState)
proc Next*(self: ptr IEnumOleUndoUnits, cElt: ULONG, rgElt: ptr ptr IOleUndoUnit, pcEltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, cElt, rgElt, pcEltFetched)
proc Skip*(self: ptr IEnumOleUndoUnits, cElt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, cElt)
proc Reset*(self: ptr IEnumOleUndoUnits): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumOleUndoUnits, ppEnum: ptr ptr IEnumOleUndoUnits): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc Open*(self: ptr IOleUndoManager, pPUU: ptr IOleParentUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Open(self, pPUU)
proc Close*(self: ptr IOleUndoManager, pPUU: ptr IOleParentUndoUnit, fCommit: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Close(self, pPUU, fCommit)
proc Add*(self: ptr IOleUndoManager, pUU: ptr IOleUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Add(self, pUU)
proc GetOpenParentState*(self: ptr IOleUndoManager, pdwState: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOpenParentState(self, pdwState)
proc DiscardFrom*(self: ptr IOleUndoManager, pUU: ptr IOleUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DiscardFrom(self, pUU)
proc UndoTo*(self: ptr IOleUndoManager, pUU: ptr IOleUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UndoTo(self, pUU)
proc RedoTo*(self: ptr IOleUndoManager, pUU: ptr IOleUndoUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RedoTo(self, pUU)
proc EnumUndoable*(self: ptr IOleUndoManager, ppEnum: ptr ptr IEnumOleUndoUnits): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumUndoable(self, ppEnum)
proc EnumRedoable*(self: ptr IOleUndoManager, ppEnum: ptr ptr IEnumOleUndoUnits): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumRedoable(self, ppEnum)
proc GetLastUndoDescription*(self: ptr IOleUndoManager, pBstr: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLastUndoDescription(self, pBstr)
proc GetLastRedoDescription*(self: ptr IOleUndoManager, pBstr: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLastRedoDescription(self, pBstr)
proc Enable*(self: ptr IOleUndoManager, fEnable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Enable(self, fEnable)
proc GetActivationPolicy*(self: ptr IPointerInactive, pdwPolicy: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetActivationPolicy(self, pdwPolicy)
proc OnInactiveMouseMove*(self: ptr IPointerInactive, pRectBounds: LPCRECT, x: LONG, y: LONG, grfKeyState: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnInactiveMouseMove(self, pRectBounds, x, y, grfKeyState)
proc OnInactiveSetCursor*(self: ptr IPointerInactive, pRectBounds: LPCRECT, x: LONG, y: LONG, dwMouseMsg: DWORD, fSetAlways: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnInactiveSetCursor(self, pRectBounds, x, y, dwMouseMsg, fSetAlways)
proc SetSite*(self: ptr IObjectWithSite, pUnkSite: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSite(self, pUnkSite)
proc GetSite*(self: ptr IObjectWithSite, riid: REFIID, ppvSite: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSite(self, riid, ppvSite)
proc GetDisplayString*(self: ptr IPerPropertyBrowsing, dispID: DISPID, pBstr: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayString(self, dispID, pBstr)
proc MapPropertyToPage*(self: ptr IPerPropertyBrowsing, dispID: DISPID, pClsid: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MapPropertyToPage(self, dispID, pClsid)
proc GetPredefinedStrings*(self: ptr IPerPropertyBrowsing, dispID: DISPID, pCaStringsOut: ptr CALPOLESTR, pCaCookiesOut: ptr CADWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPredefinedStrings(self, dispID, pCaStringsOut, pCaCookiesOut)
proc GetPredefinedValue*(self: ptr IPerPropertyBrowsing, dispID: DISPID, dwCookie: DWORD, pVarOut: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPredefinedValue(self, dispID, dwCookie, pVarOut)
proc Read*(self: ptr IPropertyBag2, cProperties: ULONG, pPropBag: ptr PROPBAG2, pErrLog: ptr IErrorLog, pvarValue: ptr VARIANT, phrError: ptr HRESULT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Read(self, cProperties, pPropBag, pErrLog, pvarValue, phrError)
proc Write*(self: ptr IPropertyBag2, cProperties: ULONG, pPropBag: ptr PROPBAG2, pvarValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Write(self, cProperties, pPropBag, pvarValue)
proc CountProperties*(self: ptr IPropertyBag2, pcProperties: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CountProperties(self, pcProperties)
proc GetPropertyInfo*(self: ptr IPropertyBag2, iProperty: ULONG, cProperties: ULONG, pPropBag: ptr PROPBAG2, pcProperties: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyInfo(self, iProperty, cProperties, pPropBag, pcProperties)
proc LoadObject*(self: ptr IPropertyBag2, pstrName: LPCOLESTR, dwHint: DWORD, pUnkObject: ptr IUnknown, pErrLog: ptr IErrorLog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadObject(self, pstrName, dwHint, pUnkObject, pErrLog)
proc InitNew*(self: ptr IPersistPropertyBag2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitNew(self)
proc Load*(self: ptr IPersistPropertyBag2, pPropBag: ptr IPropertyBag2, pErrLog: ptr IErrorLog): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, pPropBag, pErrLog)
proc Save*(self: ptr IPersistPropertyBag2, pPropBag: ptr IPropertyBag2, fClearDirty: WINBOOL, fSaveAllProperties: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Save(self, pPropBag, fClearDirty, fSaveAllProperties)
proc IsDirty*(self: ptr IPersistPropertyBag2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDirty(self)
proc OnViewStatusChange*(self: ptr IAdviseSinkEx, dwViewStatus: DWORD): void {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnViewStatusChange(self, dwViewStatus)
proc QuickActivate*(self: ptr IQuickActivate, pQaContainer: ptr QACONTAINER, pQaControl: ptr QACONTROL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QuickActivate(self, pQaContainer, pQaControl)
proc SetContentExtent*(self: ptr IQuickActivate, pSizel: LPSIZEL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetContentExtent(self, pSizel)
proc GetContentExtent*(self: ptr IQuickActivate, pSizel: LPSIZEL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContentExtent(self, pSizel)
proc Next*(self: ptr IEnumGUID, celt: ULONG, rgelt: ptr GUID, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumGUID, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumGUID, ppenum: ptr ptr IEnumGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc Next*(self: ptr IEnumCATEGORYINFO, celt: ULONG, rgelt: ptr CATEGORYINFO, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgelt, pceltFetched)
proc Skip*(self: ptr IEnumCATEGORYINFO, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IEnumCATEGORYINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumCATEGORYINFO, ppenum: ptr ptr IEnumCATEGORYINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppenum)
proc RegisterCategories*(self: ptr ICatRegister, cCategories: ULONG, rgCategoryInfo: ptr CATEGORYINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterCategories(self, cCategories, rgCategoryInfo)
proc UnRegisterCategories*(self: ptr ICatRegister, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnRegisterCategories(self, cCategories, rgcatid)
proc RegisterClassImplCategories*(self: ptr ICatRegister, rclsid: REFCLSID, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterClassImplCategories(self, rclsid, cCategories, rgcatid)
proc UnRegisterClassImplCategories*(self: ptr ICatRegister, rclsid: REFCLSID, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnRegisterClassImplCategories(self, rclsid, cCategories, rgcatid)
proc RegisterClassReqCategories*(self: ptr ICatRegister, rclsid: REFCLSID, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterClassReqCategories(self, rclsid, cCategories, rgcatid)
proc UnRegisterClassReqCategories*(self: ptr ICatRegister, rclsid: REFCLSID, cCategories: ULONG, rgcatid: ptr CATID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnRegisterClassReqCategories(self, rclsid, cCategories, rgcatid)
proc EnumCategories*(self: ptr ICatInformation, lcid: LCID, ppenumCategoryInfo: ptr ptr IEnumCATEGORYINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumCategories(self, lcid, ppenumCategoryInfo)
proc GetCategoryDesc*(self: ptr ICatInformation, rcatid: REFCATID, lcid: LCID, pszDesc: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCategoryDesc(self, rcatid, lcid, pszDesc)
proc EnumClassesOfCategories*(self: ptr ICatInformation, cImplemented: ULONG, rgcatidImpl: ptr CATID, cRequired: ULONG, rgcatidReq: ptr CATID, ppenumClsid: ptr ptr IEnumGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumClassesOfCategories(self, cImplemented, rgcatidImpl, cRequired, rgcatidReq, ppenumClsid)
proc IsClassOfCategories*(self: ptr ICatInformation, rclsid: REFCLSID, cImplemented: ULONG, rgcatidImpl: ptr CATID, cRequired: ULONG, rgcatidReq: ptr CATID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsClassOfCategories(self, rclsid, cImplemented, rgcatidImpl, cRequired, rgcatidReq)
proc EnumImplCategoriesOfClass*(self: ptr ICatInformation, rclsid: REFCLSID, ppenumCatid: ptr ptr IEnumGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumImplCategoriesOfClass(self, rclsid, ppenumCatid)
proc EnumReqCategoriesOfClass*(self: ptr ICatInformation, rclsid: REFCLSID, ppenumCatid: ptr ptr IEnumGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumReqCategoriesOfClass(self, rclsid, ppenumCatid)
proc CreateView*(self: ptr IOleDocument, pIPSite: ptr IOleInPlaceSite, pstm: ptr IStream, dwReserved: DWORD, ppView: ptr ptr IOleDocumentView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateView(self, pIPSite, pstm, dwReserved, ppView)
proc GetDocMiscStatus*(self: ptr IOleDocument, pdwStatus: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDocMiscStatus(self, pdwStatus)
proc EnumViews*(self: ptr IOleDocument, ppEnum: ptr ptr IEnumOleDocumentViews, ppView: ptr ptr IOleDocumentView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumViews(self, ppEnum, ppView)
proc ActivateMe*(self: ptr IOleDocumentSite, pViewToActivate: ptr IOleDocumentView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ActivateMe(self, pViewToActivate)
proc SetInPlaceSite*(self: ptr IOleDocumentView, pIPSite: ptr IOleInPlaceSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetInPlaceSite(self, pIPSite)
proc GetInPlaceSite*(self: ptr IOleDocumentView, ppIPSite: ptr ptr IOleInPlaceSite): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInPlaceSite(self, ppIPSite)
proc GetDocument*(self: ptr IOleDocumentView, ppunk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDocument(self, ppunk)
proc SetRect*(self: ptr IOleDocumentView, prcView: LPRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRect(self, prcView)
proc GetRect*(self: ptr IOleDocumentView, prcView: LPRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRect(self, prcView)
proc SetRectComplex*(self: ptr IOleDocumentView, prcView: LPRECT, prcHScroll: LPRECT, prcVScroll: LPRECT, prcSizeBox: LPRECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRectComplex(self, prcView, prcHScroll, prcVScroll, prcSizeBox)
proc Show*(self: ptr IOleDocumentView, fShow: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Show(self, fShow)
proc UIActivate*(self: ptr IOleDocumentView, fUIActivate: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UIActivate(self, fUIActivate)
proc Open*(self: ptr IOleDocumentView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Open(self)
proc CloseView*(self: ptr IOleDocumentView, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CloseView(self, dwReserved)
proc SaveViewState*(self: ptr IOleDocumentView, pstm: LPSTREAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveViewState(self, pstm)
proc ApplyViewState*(self: ptr IOleDocumentView, pstm: LPSTREAM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplyViewState(self, pstm)
proc Clone*(self: ptr IOleDocumentView, pIPSiteNew: ptr IOleInPlaceSite, ppViewNew: ptr ptr IOleDocumentView): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, pIPSiteNew, ppViewNew)
proc Next*(self: ptr IEnumOleDocumentViews, cViews: ULONG, rgpView: ptr ptr IOleDocumentView, pcFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, cViews, rgpView, pcFetched)
proc Skip*(self: ptr IEnumOleDocumentViews, cViews: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, cViews)
proc Reset*(self: ptr IEnumOleDocumentViews): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IEnumOleDocumentViews, ppEnum: ptr ptr IEnumOleDocumentViews): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppEnum)
proc FContinue*(self: ptr IContinueCallback): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FContinue(self)
proc FContinuePrinting*(self: ptr IContinueCallback, nCntPrinted: LONG, nCurPage: LONG, pwszPrintStatus: ptr uint16): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FContinuePrinting(self, nCntPrinted, nCurPage, pwszPrintStatus)
proc SetInitialPageNum*(self: ptr IPrint, nFirstPage: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetInitialPageNum(self, nFirstPage)
proc GetPageInfo*(self: ptr IPrint, pnFirstPage: ptr LONG, pcPages: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPageInfo(self, pnFirstPage, pcPages)
proc Print*(self: ptr IPrint, grfFlags: DWORD, pptd: ptr ptr DVTARGETDEVICE, ppPageSet: ptr ptr PAGESET, pstgmOptions: ptr STGMEDIUM, pcallback: ptr IContinueCallback, nFirstPage: LONG, pcPagesPrinted: ptr LONG, pnLastPage: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Print(self, grfFlags, pptd, ppPageSet, pstgmOptions, pcallback, nFirstPage, pcPagesPrinted, pnLastPage)
proc QueryStatus*(self: ptr IOleCommandTarget, pguidCmdGroup: ptr GUID, cCmds: ULONG, prgCmds: ptr OLECMD, pCmdText: ptr OLECMDTEXT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryStatus(self, pguidCmdGroup, cCmds, prgCmds, pCmdText)
proc Exec*(self: ptr IOleCommandTarget, pguidCmdGroup: ptr GUID, nCmdID: DWORD, nCmdexecopt: DWORD, pvaIn: ptr VARIANT, pvaOut: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Exec(self, pguidCmdGroup, nCmdID, nCmdexecopt, pvaIn, pvaOut)
proc OnZoomPercentChanged*(self: ptr IZoomEvents, ulZoomPercent: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnZoomPercentChanged(self, ulZoomPercent)
proc AllowFocusChange*(self: ptr IProtectFocus, pfAllow: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AllowFocusChange(self, pfAllow)
proc CreateMenu*(self: ptr IProtectedModeMenuServices, phMenu: ptr HMENU): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateMenu(self, phMenu)
proc LoadMenu*(self: ptr IProtectedModeMenuServices, pszModuleName: LPCWSTR, pszMenuName: LPCWSTR, phMenu: ptr HMENU): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadMenu(self, pszModuleName, pszMenuName, phMenu)
proc LoadMenuID*(self: ptr IProtectedModeMenuServices, pszModuleName: LPCWSTR, wResourceID: WORD, phMenu: ptr HMENU): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadMenuID(self, pszModuleName, wResourceID, phMenu)
proc GoBack*(self: ptr IWebBrowser): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GoBack(self)
proc GoForward*(self: ptr IWebBrowser): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GoForward(self)
proc GoHome*(self: ptr IWebBrowser): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GoHome(self)
proc GoSearch*(self: ptr IWebBrowser): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GoSearch(self)
proc Navigate*(self: ptr IWebBrowser, URL: BSTR, Flags: ptr VARIANT, TargetFrameName: ptr VARIANT, PostData: ptr VARIANT, Headers: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Navigate(self, URL, Flags, TargetFrameName, PostData, Headers)
proc Refresh*(self: ptr IWebBrowser): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Refresh(self)
proc Refresh2*(self: ptr IWebBrowser, Level: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Refresh2(self, Level)
proc Stop*(self: ptr IWebBrowser): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Stop(self)
proc get_Application*(self: ptr IWebBrowser, ppDisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Application(self, ppDisp)
proc get_Parent*(self: ptr IWebBrowser, ppDisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Parent(self, ppDisp)
proc get_Container*(self: ptr IWebBrowser, ppDisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Container(self, ppDisp)
proc get_Document*(self: ptr IWebBrowser, ppDisp: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Document(self, ppDisp)
proc get_TopLevelContainer*(self: ptr IWebBrowser, pBool: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TopLevelContainer(self, pBool)
proc get_Type*(self: ptr IWebBrowser, Type: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Type(self, Type)
proc get_Left*(self: ptr IWebBrowser, pl: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Left(self, pl)
proc put_Left*(self: ptr IWebBrowser, Left: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Left(self, Left)
proc get_Top*(self: ptr IWebBrowser, pl: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Top(self, pl)
proc put_Top*(self: ptr IWebBrowser, Top: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Top(self, Top)
proc get_Width*(self: ptr IWebBrowser, pl: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Width(self, pl)
proc put_Width*(self: ptr IWebBrowser, Width: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Width(self, Width)
proc get_Height*(self: ptr IWebBrowser, pl: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Height(self, pl)
proc put_Height*(self: ptr IWebBrowser, Height: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Height(self, Height)
proc get_LocationName*(self: ptr IWebBrowser, LocationName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_LocationName(self, LocationName)
proc get_LocationURL*(self: ptr IWebBrowser, LocationURL: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_LocationURL(self, LocationURL)
proc get_Busy*(self: ptr IWebBrowser, pBool: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Busy(self, pBool)
proc Quit*(self: ptr IWebBrowserApp): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Quit(self)
proc ClientToWindow*(self: ptr IWebBrowserApp, pcx: ptr int32, pcy: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClientToWindow(self, pcx, pcy)
proc PutProperty*(self: ptr IWebBrowserApp, Property: BSTR, vtValue: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PutProperty(self, Property, vtValue)
proc GetProperty*(self: ptr IWebBrowserApp, Property: BSTR, pvtValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, Property, pvtValue)
proc get_Name*(self: ptr IWebBrowserApp, Name: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Name(self, Name)
proc get_HWND*(self: ptr IWebBrowserApp, pHWND: ptr SHANDLE_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_HWND(self, pHWND)
proc get_FullName*(self: ptr IWebBrowserApp, FullName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FullName(self, FullName)
proc get_Path*(self: ptr IWebBrowserApp, Path: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Path(self, Path)
proc get_Visible*(self: ptr IWebBrowserApp, pBool: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Visible(self, pBool)
proc put_Visible*(self: ptr IWebBrowserApp, Value: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Visible(self, Value)
proc get_StatusBar*(self: ptr IWebBrowserApp, pBool: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_StatusBar(self, pBool)
proc put_StatusBar*(self: ptr IWebBrowserApp, Value: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_StatusBar(self, Value)
proc get_StatusText*(self: ptr IWebBrowserApp, StatusText: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_StatusText(self, StatusText)
proc put_StatusText*(self: ptr IWebBrowserApp, StatusText: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_StatusText(self, StatusText)
proc get_ToolBar*(self: ptr IWebBrowserApp, Value: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ToolBar(self, Value)
proc put_ToolBar*(self: ptr IWebBrowserApp, Value: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ToolBar(self, Value)
proc get_MenuBar*(self: ptr IWebBrowserApp, Value: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_MenuBar(self, Value)
proc put_MenuBar*(self: ptr IWebBrowserApp, Value: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_MenuBar(self, Value)
proc get_FullScreen*(self: ptr IWebBrowserApp, pbFullScreen: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FullScreen(self, pbFullScreen)
proc put_FullScreen*(self: ptr IWebBrowserApp, bFullScreen: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_FullScreen(self, bFullScreen)
proc Navigate2*(self: ptr IWebBrowser2, URL: ptr VARIANT, Flags: ptr VARIANT, TargetFrameName: ptr VARIANT, PostData: ptr VARIANT, Headers: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Navigate2(self, URL, Flags, TargetFrameName, PostData, Headers)
proc QueryStatusWB*(self: ptr IWebBrowser2, cmdID: OLECMDID, pcmdf: ptr OLECMDF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryStatusWB(self, cmdID, pcmdf)
proc ExecWB*(self: ptr IWebBrowser2, cmdID: OLECMDID, cmdexecopt: OLECMDEXECOPT, pvaIn: ptr VARIANT, pvaOut: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExecWB(self, cmdID, cmdexecopt, pvaIn, pvaOut)
proc ShowBrowserBar*(self: ptr IWebBrowser2, pvaClsid: ptr VARIANT, pvarShow: ptr VARIANT, pvarSize: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowBrowserBar(self, pvaClsid, pvarShow, pvarSize)
proc get_ReadyState*(self: ptr IWebBrowser2, plReadyState: ptr READYSTATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ReadyState(self, plReadyState)
proc get_Offline*(self: ptr IWebBrowser2, pbOffline: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Offline(self, pbOffline)
proc put_Offline*(self: ptr IWebBrowser2, bOffline: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Offline(self, bOffline)
proc get_Silent*(self: ptr IWebBrowser2, pbSilent: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Silent(self, pbSilent)
proc put_Silent*(self: ptr IWebBrowser2, bSilent: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Silent(self, bSilent)
proc get_RegisterAsBrowser*(self: ptr IWebBrowser2, pbRegister: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_RegisterAsBrowser(self, pbRegister)
proc put_RegisterAsBrowser*(self: ptr IWebBrowser2, bRegister: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_RegisterAsBrowser(self, bRegister)
proc get_RegisterAsDropTarget*(self: ptr IWebBrowser2, pbRegister: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_RegisterAsDropTarget(self, pbRegister)
proc put_RegisterAsDropTarget*(self: ptr IWebBrowser2, bRegister: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_RegisterAsDropTarget(self, bRegister)
proc get_TheaterMode*(self: ptr IWebBrowser2, pbRegister: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TheaterMode(self, pbRegister)
proc put_TheaterMode*(self: ptr IWebBrowser2, bRegister: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_TheaterMode(self, bRegister)
proc get_AddressBar*(self: ptr IWebBrowser2, Value: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_AddressBar(self, Value)
proc put_AddressBar*(self: ptr IWebBrowser2, Value: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_AddressBar(self, Value)
proc get_Resizable*(self: ptr IWebBrowser2, Value: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Resizable(self, Value)
proc put_Resizable*(self: ptr IWebBrowser2, Value: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Resizable(self, Value)
proc get_Count*(self: ptr IShellWindows, Count: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Count(self, Count)
proc Item*(self: ptr IShellWindows, index: VARIANT, Folder: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Item(self, index, Folder)
proc NewEnum*(self: ptr IShellWindows, ppunk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NewEnum(self, ppunk)
proc Register*(self: ptr IShellWindows, pid: ptr IDispatch, hWnd: LONG, swClass: int32, plCookie: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Register(self, pid, hWnd, swClass, plCookie)
proc RegisterPending*(self: ptr IShellWindows, lThreadId: LONG, pvarloc: ptr VARIANT, pvarlocRoot: ptr VARIANT, swClass: int32, plCookie: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterPending(self, lThreadId, pvarloc, pvarlocRoot, swClass, plCookie)
proc Revoke*(self: ptr IShellWindows, lCookie: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Revoke(self, lCookie)
proc OnNavigate*(self: ptr IShellWindows, lCookie: LONG, pvarLoc: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnNavigate(self, lCookie, pvarLoc)
proc OnActivated*(self: ptr IShellWindows, lCookie: LONG, fActive: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnActivated(self, lCookie, fActive)
proc FindWindowSW*(self: ptr IShellWindows, pvarLoc: ptr VARIANT, pvarLocRoot: ptr VARIANT, swClass: int32, phwnd: ptr LONG, swfwOptions: int32, ppdispOut: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindWindowSW(self, pvarLoc, pvarLocRoot, swClass, phwnd, swfwOptions, ppdispOut)
proc OnCreated*(self: ptr IShellWindows, lCookie: LONG, punk: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnCreated(self, lCookie, punk)
proc ProcessAttachDetach*(self: ptr IShellWindows, fAttach: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProcessAttachDetach(self, fAttach)
proc ResetFirstBootMode*(self: ptr IShellUIHelper): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetFirstBootMode(self)
proc ResetSafeMode*(self: ptr IShellUIHelper): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetSafeMode(self)
proc RefreshOfflineDesktop*(self: ptr IShellUIHelper): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RefreshOfflineDesktop(self)
proc AddFavorite*(self: ptr IShellUIHelper, URL: BSTR, Title: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddFavorite(self, URL, Title)
proc AddChannel*(self: ptr IShellUIHelper, URL: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddChannel(self, URL)
proc AddDesktopComponent*(self: ptr IShellUIHelper, URL: BSTR, Type: BSTR, Left: ptr VARIANT, Top: ptr VARIANT, Width: ptr VARIANT, Height: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddDesktopComponent(self, URL, Type, Left, Top, Width, Height)
proc IsSubscribed*(self: ptr IShellUIHelper, URL: BSTR, pBool: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsSubscribed(self, URL, pBool)
proc NavigateAndFind*(self: ptr IShellUIHelper, URL: BSTR, strQuery: BSTR, varTargetFrame: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NavigateAndFind(self, URL, strQuery, varTargetFrame)
proc ImportExportFavorites*(self: ptr IShellUIHelper, fImport: VARIANT_BOOL, strImpExpPath: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ImportExportFavorites(self, fImport, strImpExpPath)
proc AutoCompleteSaveForm*(self: ptr IShellUIHelper, Form: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AutoCompleteSaveForm(self, Form)
proc AutoScan*(self: ptr IShellUIHelper, strSearch: BSTR, strFailureUrl: BSTR, pvarTargetFrame: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AutoScan(self, strSearch, strFailureUrl, pvarTargetFrame)
proc AutoCompleteAttach*(self: ptr IShellUIHelper, Reserved: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AutoCompleteAttach(self, Reserved)
proc ShowBrowserUI*(self: ptr IShellUIHelper, bstrName: BSTR, pvarIn: ptr VARIANT, pvarOut: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowBrowserUI(self, bstrName, pvarIn, pvarOut)
proc AddSearchProvider*(self: ptr IShellUIHelper2, URL: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddSearchProvider(self, URL)
proc RunOnceShown*(self: ptr IShellUIHelper2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RunOnceShown(self)
proc SkipRunOnce*(self: ptr IShellUIHelper2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SkipRunOnce(self)
proc CustomizeSettings*(self: ptr IShellUIHelper2, fSQM: VARIANT_BOOL, fPhishing: VARIANT_BOOL, bstrLocale: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CustomizeSettings(self, fSQM, fPhishing, bstrLocale)
proc SqmEnabled*(self: ptr IShellUIHelper2, pfEnabled: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SqmEnabled(self, pfEnabled)
proc PhishingEnabled*(self: ptr IShellUIHelper2, pfEnabled: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PhishingEnabled(self, pfEnabled)
proc BrandImageUri*(self: ptr IShellUIHelper2, pbstrUri: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BrandImageUri(self, pbstrUri)
proc SkipTabsWelcome*(self: ptr IShellUIHelper2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SkipTabsWelcome(self)
proc DiagnoseConnection*(self: ptr IShellUIHelper2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DiagnoseConnection(self)
proc CustomizeClearType*(self: ptr IShellUIHelper2, fSet: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CustomizeClearType(self, fSet)
proc IsSearchProviderInstalled*(self: ptr IShellUIHelper2, URL: BSTR, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsSearchProviderInstalled(self, URL, pdwResult)
proc IsSearchMigrated*(self: ptr IShellUIHelper2, pfMigrated: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsSearchMigrated(self, pfMigrated)
proc DefaultSearchProvider*(self: ptr IShellUIHelper2, pbstrName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefaultSearchProvider(self, pbstrName)
proc RunOnceRequiredSettingsComplete*(self: ptr IShellUIHelper2, fComplete: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RunOnceRequiredSettingsComplete(self, fComplete)
proc RunOnceHasShown*(self: ptr IShellUIHelper2, pfShown: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RunOnceHasShown(self, pfShown)
proc SearchGuideUrl*(self: ptr IShellUIHelper2, pbstrUrl: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SearchGuideUrl(self, pbstrUrl)
proc MoveSelectionUp*(self: ptr IShellFavoritesNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveSelectionUp(self)
proc MoveSelectionDown*(self: ptr IShellFavoritesNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveSelectionDown(self)
proc ResetSort*(self: ptr IShellFavoritesNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetSort(self)
proc NewFolder*(self: ptr IShellFavoritesNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NewFolder(self)
proc mSynchronize*(self: ptr IShellFavoritesNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Synchronize(self)
proc Import*(self: ptr IShellFavoritesNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Import(self)
proc Export*(self: ptr IShellFavoritesNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Export(self)
proc InvokeContextMenuCommand*(self: ptr IShellFavoritesNameSpace, strCommand: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeContextMenuCommand(self, strCommand)
proc MoveSelectionTo*(self: ptr IShellFavoritesNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveSelectionTo(self)
proc get_SubscriptionsEnabled*(self: ptr IShellFavoritesNameSpace, pBool: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SubscriptionsEnabled(self, pBool)
proc CreateSubscriptionForSelection*(self: ptr IShellFavoritesNameSpace, pBool: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateSubscriptionForSelection(self, pBool)
proc DeleteSubscriptionForSelection*(self: ptr IShellFavoritesNameSpace, pBool: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteSubscriptionForSelection(self, pBool)
proc SetRoot*(self: ptr IShellFavoritesNameSpace, bstrFullPath: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetRoot(self, bstrFullPath)
proc get_EnumOptions*(self: ptr IShellNameSpace, pgrfEnumFlags: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_EnumOptions(self, pgrfEnumFlags)
proc put_EnumOptions*(self: ptr IShellNameSpace, pgrfEnumFlags: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_EnumOptions(self, pgrfEnumFlags)
proc get_SelectedItem*(self: ptr IShellNameSpace, pItem: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SelectedItem(self, pItem)
proc put_SelectedItem*(self: ptr IShellNameSpace, pItem: ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_SelectedItem(self, pItem)
proc get_Root*(self: ptr IShellNameSpace, pvar: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Root(self, pvar)
proc put_Root*(self: ptr IShellNameSpace, pvar: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Root(self, pvar)
proc get_Depth*(self: ptr IShellNameSpace, piDepth: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Depth(self, piDepth)
proc put_Depth*(self: ptr IShellNameSpace, piDepth: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Depth(self, piDepth)
proc get_Mode*(self: ptr IShellNameSpace, puMode: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Mode(self, puMode)
proc put_Mode*(self: ptr IShellNameSpace, puMode: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Mode(self, puMode)
proc get_Flags*(self: ptr IShellNameSpace, pdwFlags: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Flags(self, pdwFlags)
proc put_Flags*(self: ptr IShellNameSpace, pdwFlags: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Flags(self, pdwFlags)
proc put_TVFlags*(self: ptr IShellNameSpace, dwFlags: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_TVFlags(self, dwFlags)
proc get_TVFlags*(self: ptr IShellNameSpace, dwFlags: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TVFlags(self, dwFlags)
proc get_Columns*(self: ptr IShellNameSpace, bstrColumns: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Columns(self, bstrColumns)
proc put_Columns*(self: ptr IShellNameSpace, bstrColumns: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_Columns(self, bstrColumns)
proc get_CountViewTypes*(self: ptr IShellNameSpace, piTypes: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CountViewTypes(self, piTypes)
proc SetViewType*(self: ptr IShellNameSpace, iType: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetViewType(self, iType)
proc SelectedItems*(self: ptr IShellNameSpace, ppid: ptr ptr IDispatch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SelectedItems(self, ppid)
proc Expand*(self: ptr IShellNameSpace, `var`: VARIANT, iDepth: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Expand(self, `var`, iDepth)
proc UnselectAll*(self: ptr IShellNameSpace): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnselectAll(self)
proc advanceError*(self: ptr IScriptErrorList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.advanceError(self)
proc retreatError*(self: ptr IScriptErrorList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.retreatError(self)
proc canAdvanceError*(self: ptr IScriptErrorList, pfCanAdvance: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.canAdvanceError(self, pfCanAdvance)
proc canRetreatError*(self: ptr IScriptErrorList, pfCanRetreat: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.canRetreatError(self, pfCanRetreat)
proc getErrorLine*(self: ptr IScriptErrorList, plLine: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getErrorLine(self, plLine)
proc getErrorChar*(self: ptr IScriptErrorList, plChar: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getErrorChar(self, plChar)
proc getErrorCode*(self: ptr IScriptErrorList, plCode: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getErrorCode(self, plCode)
proc getErrorMsg*(self: ptr IScriptErrorList, pstr: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getErrorMsg(self, pstr)
proc getErrorUrl*(self: ptr IScriptErrorList, pstr: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getErrorUrl(self, pstr)
proc getAlwaysShowLockState*(self: ptr IScriptErrorList, pfAlwaysShowLocked: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getAlwaysShowLockState(self, pfAlwaysShowLocked)
proc getDetailsPaneOpen*(self: ptr IScriptErrorList, pfDetailsPaneOpen: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getDetailsPaneOpen(self, pfDetailsPaneOpen)
proc setDetailsPaneOpen*(self: ptr IScriptErrorList, fDetailsPaneOpen: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.setDetailsPaneOpen(self, fDetailsPaneOpen)
proc getPerErrorDisplay*(self: ptr IScriptErrorList, pfPerErrorDisplay: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getPerErrorDisplay(self, pfPerErrorDisplay)
proc setPerErrorDisplay*(self: ptr IScriptErrorList, fPerErrorDisplay: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.setPerErrorDisplay(self, fPerErrorDisplay)
proc get_Title*(self: ptr ISearch, pbstrTitle: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Title(self, pbstrTitle)
proc get_Id*(self: ptr ISearch, pbstrId: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Id(self, pbstrId)
proc get_URL*(self: ptr ISearch, pbstrUrl: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_URL(self, pbstrUrl)
proc get_Count*(self: ptr ISearches, plCount: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Count(self, plCount)
proc get_Default*(self: ptr ISearches, pbstrDefault: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Default(self, pbstrDefault)
proc Item*(self: ptr ISearches, index: VARIANT, ppid: ptr ptr ISearch): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Item(self, index, ppid)
proc NewEnum*(self: ptr ISearches, ppunk: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NewEnum(self, ppunk)
proc AddNextMenuItem*(self: ptr ISearchAssistantOC, bstrText: BSTR, idItem: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddNextMenuItem(self, bstrText, idItem)
proc SetDefaultSearchUrl*(self: ptr ISearchAssistantOC, bstrUrl: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDefaultSearchUrl(self, bstrUrl)
proc NavigateToDefaultSearch*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NavigateToDefaultSearch(self)
proc IsRestricted*(self: ptr ISearchAssistantOC, bstrGuid: BSTR, pVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsRestricted(self, bstrGuid, pVal)
proc get_ShellFeaturesEnabled*(self: ptr ISearchAssistantOC, pVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ShellFeaturesEnabled(self, pVal)
proc get_SearchAssistantDefault*(self: ptr ISearchAssistantOC, pVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SearchAssistantDefault(self, pVal)
proc get_Searches*(self: ptr ISearchAssistantOC, ppid: ptr ptr ISearches): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Searches(self, ppid)
proc get_InWebFolder*(self: ptr ISearchAssistantOC, pVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_InWebFolder(self, pVal)
proc PutProperty*(self: ptr ISearchAssistantOC, bPerLocale: VARIANT_BOOL, bstrName: BSTR, bstrValue: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PutProperty(self, bPerLocale, bstrName, bstrValue)
proc GetProperty*(self: ptr ISearchAssistantOC, bPerLocale: VARIANT_BOOL, bstrName: BSTR, pbstrValue: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, bPerLocale, bstrName, pbstrValue)
proc put_EventHandled*(self: ptr ISearchAssistantOC, rhs: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_EventHandled(self, rhs)
proc ResetNextMenu*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ResetNextMenu(self)
proc FindOnWeb*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindOnWeb(self)
proc FindFilesOrFolders*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindFilesOrFolders(self)
proc FindComputer*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindComputer(self)
proc FindPrinter*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindPrinter(self)
proc FindPeople*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindPeople(self)
proc GetSearchAssistantURL*(self: ptr ISearchAssistantOC, bSubstitute: VARIANT_BOOL, bCustomize: VARIANT_BOOL, pbstrValue: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSearchAssistantURL(self, bSubstitute, bCustomize, pbstrValue)
proc NotifySearchSettingsChanged*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NotifySearchSettingsChanged(self)
proc put_ASProvider*(self: ptr ISearchAssistantOC, pProvider: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ASProvider(self, pProvider)
proc get_ASProvider*(self: ptr ISearchAssistantOC, pProvider: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ASProvider(self, pProvider)
proc put_ASSetting*(self: ptr ISearchAssistantOC, pSetting: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ASSetting(self, pSetting)
proc get_ASSetting*(self: ptr ISearchAssistantOC, pSetting: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ASSetting(self, pSetting)
proc NETDetectNextNavigate*(self: ptr ISearchAssistantOC): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NETDetectNextNavigate(self)
proc PutFindText*(self: ptr ISearchAssistantOC, FindText: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PutFindText(self, FindText)
proc get_Version*(self: ptr ISearchAssistantOC, pVersion: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Version(self, pVersion)
proc EncodeString*(self: ptr ISearchAssistantOC, bstrValue: BSTR, bstrCharSet: BSTR, bUseUTF8: VARIANT_BOOL, pbstrResult: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EncodeString(self, bstrValue, bstrCharSet, bUseUTF8, pbstrResult)
proc get_ShowFindPrinter*(self: ptr ISearchAssistantOC2, pbShowFindPrinter: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ShowFindPrinter(self, pbShowFindPrinter)
proc get_SearchCompanionAvailable*(self: ptr ISearchAssistantOC3, pbAvailable: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SearchCompanionAvailable(self, pbAvailable)
proc put_UseSearchCompanion*(self: ptr ISearchAssistantOC3, pbUseSC: VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_UseSearchCompanion(self, pbUseSC)
proc get_UseSearchCompanion*(self: ptr ISearchAssistantOC3, pbUseSC: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_UseSearchCompanion(self, pbUseSC)
proc GetData*(self: ptr IRichChunk, pFirstPos: ptr ULONG, pLength: ptr ULONG, ppsz: ptr LPWSTR, pValue: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetData(self, pFirstPos, pLength, ppsz, pValue)
proc GetConditionType*(self: ptr ICondition, pNodeType: ptr CONDITION_TYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConditionType(self, pNodeType)
proc GetSubConditions*(self: ptr ICondition, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSubConditions(self, riid, ppv)
proc GetComparisonInfo*(self: ptr ICondition, ppszPropertyName: ptr LPWSTR, pcop: ptr CONDITION_OPERATION, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetComparisonInfo(self, ppszPropertyName, pcop, ppropvar)
proc GetValueType*(self: ptr ICondition, ppszValueTypeName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetValueType(self, ppszValueTypeName)
proc GetValueNormalization*(self: ptr ICondition, ppszNormalization: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetValueNormalization(self, ppszNormalization)
proc GetInputTerms*(self: ptr ICondition, ppPropertyTerm: ptr ptr IRichChunk, ppOperationTerm: ptr ptr IRichChunk, ppValueTerm: ptr ptr IRichChunk): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInputTerms(self, ppPropertyTerm, ppOperationTerm, ppValueTerm)
proc Clone*(self: ptr ICondition, ppc: ptr ptr ICondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppc)
proc GetLocale*(self: ptr ICondition2, ppszLocaleName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLocale(self, ppszLocaleName)
proc GetLeafConditionInfo*(self: ptr ICondition2, ppropkey: ptr PROPERTYKEY, pcop: ptr CONDITION_OPERATION, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLeafConditionInfo(self, ppropkey, pcop, ppropvar)
proc Initialize*(self: ptr IInitializeWithFile, pszFilePath: LPCWSTR, grfMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pszFilePath, grfMode)
proc Initialize*(self: ptr IInitializeWithStream, pstream: ptr IStream, grfMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pstream, grfMode)
proc GetCount*(self: ptr IPropertyStore, cProps: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCount(self, cProps)
proc GetAt*(self: ptr IPropertyStore, iProp: DWORD, pkey: ptr PROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAt(self, iProp, pkey)
proc GetValue*(self: ptr IPropertyStore, key: REFPROPERTYKEY, pv: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetValue(self, key, pv)
proc SetValue*(self: ptr IPropertyStore, key: REFPROPERTYKEY, propvar: REFPROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetValue(self, key, propvar)
proc Commit*(self: ptr IPropertyStore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self)
proc GetNamedValue*(self: ptr INamedPropertyStore, pszName: LPCWSTR, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNamedValue(self, pszName, ppropvar)
proc SetNamedValue*(self: ptr INamedPropertyStore, pszName: LPCWSTR, propvar: REFPROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetNamedValue(self, pszName, propvar)
proc GetNameCount*(self: ptr INamedPropertyStore, pdwCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNameCount(self, pdwCount)
proc GetNameAt*(self: ptr INamedPropertyStore, iProp: DWORD, pbstrName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNameAt(self, iProp, pbstrName)
proc SetPropertyKey*(self: ptr IObjectWithPropertyKey, key: REFPROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPropertyKey(self, key)
proc GetPropertyKey*(self: ptr IObjectWithPropertyKey, pkey: ptr PROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyKey(self, pkey)
proc ApplyToPropVariant*(self: ptr IPropertyChange, propvarIn: REFPROPVARIANT, ppropvarOut: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ApplyToPropVariant(self, propvarIn, ppropvarOut)
proc GetCount*(self: ptr IPropertyChangeArray, pcOperations: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCount(self, pcOperations)
proc GetAt*(self: ptr IPropertyChangeArray, iIndex: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAt(self, iIndex, riid, ppv)
proc InsertAt*(self: ptr IPropertyChangeArray, iIndex: UINT, ppropChange: ptr IPropertyChange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InsertAt(self, iIndex, ppropChange)
proc Append*(self: ptr IPropertyChangeArray, ppropChange: ptr IPropertyChange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Append(self, ppropChange)
proc AppendOrReplace*(self: ptr IPropertyChangeArray, ppropChange: ptr IPropertyChange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AppendOrReplace(self, ppropChange)
proc RemoveAt*(self: ptr IPropertyChangeArray, iIndex: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveAt(self, iIndex)
proc IsKeyInArray*(self: ptr IPropertyChangeArray, key: REFPROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsKeyInArray(self, key)
proc IsPropertyWritable*(self: ptr IPropertyStoreCapabilities, key: REFPROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsPropertyWritable(self, key)
proc GetState*(self: ptr IPropertyStoreCache, key: REFPROPERTYKEY, pstate: ptr PSC_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetState(self, key, pstate)
proc GetValueAndState*(self: ptr IPropertyStoreCache, key: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT, pstate: ptr PSC_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetValueAndState(self, key, ppropvar, pstate)
proc SetState*(self: ptr IPropertyStoreCache, key: REFPROPERTYKEY, state: PSC_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetState(self, key, state)
proc SetValueAndState*(self: ptr IPropertyStoreCache, key: REFPROPERTYKEY, ppropvar: ptr PROPVARIANT, state: PSC_STATE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetValueAndState(self, key, ppropvar, state)
proc GetEnumType*(self: ptr IPropertyEnumType, penumtype: ptr PROPENUMTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnumType(self, penumtype)
proc GetValue*(self: ptr IPropertyEnumType, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetValue(self, ppropvar)
proc GetRangeMinValue*(self: ptr IPropertyEnumType, ppropvarMin: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRangeMinValue(self, ppropvarMin)
proc GetRangeSetValue*(self: ptr IPropertyEnumType, ppropvarSet: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRangeSetValue(self, ppropvarSet)
proc GetDisplayText*(self: ptr IPropertyEnumType, ppszDisplay: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayText(self, ppszDisplay)
proc GetImageReference*(self: ptr IPropertyEnumType2, ppszImageRes: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImageReference(self, ppszImageRes)
proc GetCount*(self: ptr IPropertyEnumTypeList, pctypes: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCount(self, pctypes)
proc GetAt*(self: ptr IPropertyEnumTypeList, itype: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAt(self, itype, riid, ppv)
proc GetConditionAt*(self: ptr IPropertyEnumTypeList, nIndex: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConditionAt(self, nIndex, riid, ppv)
proc FindMatchingIndex*(self: ptr IPropertyEnumTypeList, propvarCmp: REFPROPVARIANT, pnIndex: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindMatchingIndex(self, propvarCmp, pnIndex)
proc GetPropertyKey*(self: ptr IPropertyDescription, pkey: ptr PROPERTYKEY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyKey(self, pkey)
proc GetCanonicalName*(self: ptr IPropertyDescription, ppszName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCanonicalName(self, ppszName)
proc GetPropertyType*(self: ptr IPropertyDescription, pvartype: ptr VARTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyType(self, pvartype)
proc GetDisplayName*(self: ptr IPropertyDescription, ppszName: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayName(self, ppszName)
proc GetEditInvitation*(self: ptr IPropertyDescription, ppszInvite: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEditInvitation(self, ppszInvite)
proc GetTypeFlags*(self: ptr IPropertyDescription, mask: PROPDESC_TYPE_FLAGS, ppdtFlags: ptr PROPDESC_TYPE_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeFlags(self, mask, ppdtFlags)
proc GetViewFlags*(self: ptr IPropertyDescription, ppdvFlags: ptr PROPDESC_VIEW_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewFlags(self, ppdvFlags)
proc GetDefaultColumnWidth*(self: ptr IPropertyDescription, pcxChars: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultColumnWidth(self, pcxChars)
proc GetDisplayType*(self: ptr IPropertyDescription, pdisplaytype: ptr PROPDESC_DISPLAYTYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDisplayType(self, pdisplaytype)
proc GetColumnState*(self: ptr IPropertyDescription, pcsFlags: ptr SHCOLSTATEF): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumnState(self, pcsFlags)
proc GetGroupingRange*(self: ptr IPropertyDescription, pgr: ptr PROPDESC_GROUPING_RANGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGroupingRange(self, pgr)
proc GetRelativeDescriptionType*(self: ptr IPropertyDescription, prdt: ptr PROPDESC_RELATIVEDESCRIPTION_TYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRelativeDescriptionType(self, prdt)
proc GetRelativeDescription*(self: ptr IPropertyDescription, propvar1: REFPROPVARIANT, propvar2: REFPROPVARIANT, ppszDesc1: ptr LPWSTR, ppszDesc2: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRelativeDescription(self, propvar1, propvar2, ppszDesc1, ppszDesc2)
proc GetSortDescription*(self: ptr IPropertyDescription, psd: ptr PROPDESC_SORTDESCRIPTION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSortDescription(self, psd)
proc GetSortDescriptionLabel*(self: ptr IPropertyDescription, fDescending: WINBOOL, ppszDescription: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSortDescriptionLabel(self, fDescending, ppszDescription)
proc GetAggregationType*(self: ptr IPropertyDescription, paggtype: ptr PROPDESC_AGGREGATION_TYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAggregationType(self, paggtype)
proc GetConditionType*(self: ptr IPropertyDescription, pcontype: ptr PROPDESC_CONDITION_TYPE, popDefault: ptr CONDITION_OPERATION): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConditionType(self, pcontype, popDefault)
proc GetEnumTypeList*(self: ptr IPropertyDescription, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnumTypeList(self, riid, ppv)
proc CoerceToCanonicalValue*(self: ptr IPropertyDescription, ppropvar: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CoerceToCanonicalValue(self, ppropvar)
proc FormatForDisplay*(self: ptr IPropertyDescription, propvar: REFPROPVARIANT, pdfFlags: PROPDESC_FORMAT_FLAGS, ppszDisplay: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FormatForDisplay(self, propvar, pdfFlags, ppszDisplay)
proc IsValueCanonical*(self: ptr IPropertyDescription, propvar: REFPROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsValueCanonical(self, propvar)
proc GetImageReferenceForValue*(self: ptr IPropertyDescription2, propvar: REFPROPVARIANT, ppszImageRes: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetImageReferenceForValue(self, propvar, ppszImageRes)
proc GetSortByAlias*(self: ptr IPropertyDescriptionAliasInfo, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSortByAlias(self, riid, ppv)
proc GetAdditionalSortByAliases*(self: ptr IPropertyDescriptionAliasInfo, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAdditionalSortByAliases(self, riid, ppv)
proc GetSearchInfoFlags*(self: ptr IPropertyDescriptionSearchInfo, ppdsiFlags: ptr PROPDESC_SEARCHINFO_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSearchInfoFlags(self, ppdsiFlags)
proc GetColumnIndexType*(self: ptr IPropertyDescriptionSearchInfo, ppdciType: ptr PROPDESC_COLUMNINDEX_TYPE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumnIndexType(self, ppdciType)
proc GetProjectionString*(self: ptr IPropertyDescriptionSearchInfo, ppszProjection: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProjectionString(self, ppszProjection)
proc GetMaxSize*(self: ptr IPropertyDescriptionSearchInfo, pcbMaxSize: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMaxSize(self, pcbMaxSize)
proc GetRelatedProperty*(self: ptr IPropertyDescriptionRelatedPropertyInfo, pszRelationshipName: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRelatedProperty(self, pszRelationshipName, riid, ppv)
proc GetPropertyDescription*(self: ptr IPropertySystem, propkey: REFPROPERTYKEY, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyDescription(self, propkey, riid, ppv)
proc GetPropertyDescriptionByName*(self: ptr IPropertySystem, pszCanonicalName: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyDescriptionByName(self, pszCanonicalName, riid, ppv)
proc GetPropertyDescriptionListFromString*(self: ptr IPropertySystem, pszPropList: LPCWSTR, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyDescriptionListFromString(self, pszPropList, riid, ppv)
proc EnumeratePropertyDescriptions*(self: ptr IPropertySystem, filterOn: PROPDESC_ENUMFILTER, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumeratePropertyDescriptions(self, filterOn, riid, ppv)
proc FormatForDisplay*(self: ptr IPropertySystem, key: REFPROPERTYKEY, propvar: REFPROPVARIANT, pdff: PROPDESC_FORMAT_FLAGS, pszText: LPWSTR, cchText: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FormatForDisplay(self, key, propvar, pdff, pszText, cchText)
proc FormatForDisplayAlloc*(self: ptr IPropertySystem, key: REFPROPERTYKEY, propvar: REFPROPVARIANT, pdff: PROPDESC_FORMAT_FLAGS, ppszDisplay: ptr LPWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FormatForDisplayAlloc(self, key, propvar, pdff, ppszDisplay)
proc RegisterPropertySchema*(self: ptr IPropertySystem, pszPath: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterPropertySchema(self, pszPath)
proc UnregisterPropertySchema*(self: ptr IPropertySystem, pszPath: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterPropertySchema(self, pszPath)
proc RefreshPropertySchema*(self: ptr IPropertySystem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RefreshPropertySchema(self)
proc GetCount*(self: ptr IPropertyDescriptionList, pcElem: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCount(self, pcElem)
proc GetAt*(self: ptr IPropertyDescriptionList, iElem: UINT, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAt(self, iElem, riid, ppv)
proc GetPropertyStore*(self: ptr IPropertyStoreFactory, flags: GETPROPERTYSTOREFLAGS, pUnkFactory: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStore(self, flags, pUnkFactory, riid, ppv)
proc GetPropertyStoreForKeys*(self: ptr IPropertyStoreFactory, rgKeys: ptr PROPERTYKEY, cKeys: UINT, flags: GETPROPERTYSTOREFLAGS, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStoreForKeys(self, rgKeys, cKeys, flags, riid, ppv)
proc GetDelayedPropertyStore*(self: ptr IDelayedPropertyStoreFactory, flags: GETPROPERTYSTOREFLAGS, dwStoreId: DWORD, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDelayedPropertyStore(self, flags, dwStoreId, riid, ppv)
proc SetFlags*(self: ptr IPersistSerializedPropStorage, flags: PERSIST_SPROPSTORE_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFlags(self, flags)
proc SetPropertyStorage*(self: ptr IPersistSerializedPropStorage, psps: PCUSERIALIZEDPROPSTORAGE, cb: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPropertyStorage(self, psps, cb)
proc GetPropertyStorage*(self: ptr IPersistSerializedPropStorage, ppsps: ptr ptr SERIALIZEDPROPSTORAGE, pcb: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStorage(self, ppsps, pcb)
proc GetPropertyStorageSize*(self: ptr IPersistSerializedPropStorage2, pcb: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStorageSize(self, pcb)
proc GetPropertyStorageBuffer*(self: ptr IPersistSerializedPropStorage2, psps: ptr SERIALIZEDPROPSTORAGE, cb: DWORD, pcbWritten: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyStorageBuffer(self, psps, cb, pcbWritten)
proc SchemaRefreshed*(self: ptr IPropertySystemChangeNotify): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SchemaRefreshed(self)
proc CreateObject*(self: ptr ICreateObject, clsid: REFCLSID, pUnkOuter: ptr IUnknown, riid: REFIID, ppv: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateObject(self, clsid, pUnkOuter, riid, ppv)
converter winimConverterAsyncIUnknownToIUnknown*(x: ptr AsyncIUnknown): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIClassFactoryToIUnknown*(x: ptr IClassFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMarshalToIUnknown*(x: ptr IMarshal): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINoMarshalToIUnknown*(x: ptr INoMarshal): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAgileObjectToIUnknown*(x: ptr IAgileObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMarshal2ToIMarshal*(x: ptr IMarshal2): ptr IMarshal = cast[ptr IMarshal](x)
converter winimConverterIMarshal2ToIUnknown*(x: ptr IMarshal2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMallocToIUnknown*(x: ptr IMalloc): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIStdMarshalInfoToIUnknown*(x: ptr IStdMarshalInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExternalConnectionToIUnknown*(x: ptr IExternalConnection): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMultiQIToIUnknown*(x: ptr IMultiQI): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterAsyncIMultiQIToIUnknown*(x: ptr AsyncIMultiQI): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternalUnknownToIUnknown*(x: ptr IInternalUnknown): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumUnknownToIUnknown*(x: ptr IEnumUnknown): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumStringToIUnknown*(x: ptr IEnumString): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISequentialStreamToIUnknown*(x: ptr ISequentialStream): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIStreamToISequentialStream*(x: ptr IStream): ptr ISequentialStream = cast[ptr ISequentialStream](x)
converter winimConverterIStreamToIUnknown*(x: ptr IStream): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRpcChannelBufferToIUnknown*(x: ptr IRpcChannelBuffer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRpcChannelBuffer2ToIRpcChannelBuffer*(x: ptr IRpcChannelBuffer2): ptr IRpcChannelBuffer = cast[ptr IRpcChannelBuffer](x)
converter winimConverterIRpcChannelBuffer2ToIUnknown*(x: ptr IRpcChannelBuffer2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAsyncRpcChannelBufferToIRpcChannelBuffer2*(x: ptr IAsyncRpcChannelBuffer): ptr IRpcChannelBuffer2 = cast[ptr IRpcChannelBuffer2](x)
converter winimConverterIAsyncRpcChannelBufferToIRpcChannelBuffer*(x: ptr IAsyncRpcChannelBuffer): ptr IRpcChannelBuffer = cast[ptr IRpcChannelBuffer](x)
converter winimConverterIAsyncRpcChannelBufferToIUnknown*(x: ptr IAsyncRpcChannelBuffer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRpcChannelBuffer3ToIRpcChannelBuffer2*(x: ptr IRpcChannelBuffer3): ptr IRpcChannelBuffer2 = cast[ptr IRpcChannelBuffer2](x)
converter winimConverterIRpcChannelBuffer3ToIRpcChannelBuffer*(x: ptr IRpcChannelBuffer3): ptr IRpcChannelBuffer = cast[ptr IRpcChannelBuffer](x)
converter winimConverterIRpcChannelBuffer3ToIUnknown*(x: ptr IRpcChannelBuffer3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRpcSyntaxNegotiateToIUnknown*(x: ptr IRpcSyntaxNegotiate): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRpcProxyBufferToIUnknown*(x: ptr IRpcProxyBuffer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRpcStubBufferToIUnknown*(x: ptr IRpcStubBuffer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPSFactoryBufferToIUnknown*(x: ptr IPSFactoryBuffer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIChannelHookToIUnknown*(x: ptr IChannelHook): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIClientSecurityToIUnknown*(x: ptr IClientSecurity): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIServerSecurityToIUnknown*(x: ptr IServerSecurity): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRpcOptionsToIUnknown*(x: ptr IRpcOptions): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIGlobalOptionsToIUnknown*(x: ptr IGlobalOptions): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISurrogateToIUnknown*(x: ptr ISurrogate): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIGlobalInterfaceTableToIUnknown*(x: ptr IGlobalInterfaceTable): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISynchronizeToIUnknown*(x: ptr ISynchronize): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISynchronizeHandleToIUnknown*(x: ptr ISynchronizeHandle): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISynchronizeEventToISynchronizeHandle*(x: ptr ISynchronizeEvent): ptr ISynchronizeHandle = cast[ptr ISynchronizeHandle](x)
converter winimConverterISynchronizeEventToIUnknown*(x: ptr ISynchronizeEvent): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISynchronizeContainerToIUnknown*(x: ptr ISynchronizeContainer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISynchronizeMutexToISynchronize*(x: ptr ISynchronizeMutex): ptr ISynchronize = cast[ptr ISynchronize](x)
converter winimConverterISynchronizeMutexToIUnknown*(x: ptr ISynchronizeMutex): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICancelMethodCallsToIUnknown*(x: ptr ICancelMethodCalls): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAsyncManagerToIUnknown*(x: ptr IAsyncManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICallFactoryToIUnknown*(x: ptr ICallFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRpcHelperToIUnknown*(x: ptr IRpcHelper): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIReleaseMarshalBuffersToIUnknown*(x: ptr IReleaseMarshalBuffers): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWaitMultipleToIUnknown*(x: ptr IWaitMultiple): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAddrTrackingControlToIUnknown*(x: ptr IAddrTrackingControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAddrExclusionControlToIUnknown*(x: ptr IAddrExclusionControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPipeByteToIUnknown*(x: ptr IPipeByte): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPipeLongToIUnknown*(x: ptr IPipeLong): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPipeDoubleToIUnknown*(x: ptr IPipeDouble): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumContextPropsToIUnknown*(x: ptr IEnumContextProps): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIContextToIUnknown*(x: ptr IContext): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIComThreadingInfoToIUnknown*(x: ptr IComThreadingInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProcessInitControlToIUnknown*(x: ptr IProcessInitControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFastRundownToIUnknown*(x: ptr IFastRundown): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMarshalingStreamToIStream*(x: ptr IMarshalingStream): ptr IStream = cast[ptr IStream](x)
converter winimConverterIMarshalingStreamToISequentialStream*(x: ptr IMarshalingStream): ptr ISequentialStream = cast[ptr ISequentialStream](x)
converter winimConverterIMarshalingStreamToIUnknown*(x: ptr IMarshalingStream): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMallocSpyToIUnknown*(x: ptr IMallocSpy): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBindCtxToIUnknown*(x: ptr IBindCtx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumMonikerToIUnknown*(x: ptr IEnumMoniker): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRunnableObjectToIUnknown*(x: ptr IRunnableObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRunningObjectTableToIUnknown*(x: ptr IRunningObjectTable): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistToIUnknown*(x: ptr IPersist): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistStreamToIPersist*(x: ptr IPersistStream): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistStreamToIUnknown*(x: ptr IPersistStream): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMonikerToIPersistStream*(x: ptr IMoniker): ptr IPersistStream = cast[ptr IPersistStream](x)
converter winimConverterIMonikerToIPersist*(x: ptr IMoniker): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIMonikerToIUnknown*(x: ptr IMoniker): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIROTDataToIUnknown*(x: ptr IROTData): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumSTATSTGToIUnknown*(x: ptr IEnumSTATSTG): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIStorageToIUnknown*(x: ptr IStorage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistFileToIPersist*(x: ptr IPersistFile): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistFileToIUnknown*(x: ptr IPersistFile): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistStorageToIPersist*(x: ptr IPersistStorage): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistStorageToIUnknown*(x: ptr IPersistStorage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterILockBytesToIUnknown*(x: ptr ILockBytes): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumFORMATETCToIUnknown*(x: ptr IEnumFORMATETC): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumSTATDATAToIUnknown*(x: ptr IEnumSTATDATA): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRootStorageToIUnknown*(x: ptr IRootStorage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAdviseSinkToIUnknown*(x: ptr IAdviseSink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterAsyncIAdviseSinkToIUnknown*(x: ptr AsyncIAdviseSink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAdviseSink2ToIAdviseSink*(x: ptr IAdviseSink2): ptr IAdviseSink = cast[ptr IAdviseSink](x)
converter winimConverterIAdviseSink2ToIUnknown*(x: ptr IAdviseSink2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterAsyncIAdviseSink2ToIAdviseSink*(x: ptr AsyncIAdviseSink2): ptr IAdviseSink = cast[ptr IAdviseSink](x)
converter winimConverterAsyncIAdviseSink2ToIUnknown*(x: ptr AsyncIAdviseSink2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDataObjectToIUnknown*(x: ptr IDataObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDataAdviseHolderToIUnknown*(x: ptr IDataAdviseHolder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMessageFilterToIUnknown*(x: ptr IMessageFilter): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIClassActivatorToIUnknown*(x: ptr IClassActivator): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFillLockBytesToIUnknown*(x: ptr IFillLockBytes): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProgressNotifyToIUnknown*(x: ptr IProgressNotify): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterILayoutStorageToIUnknown*(x: ptr ILayoutStorage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBlockingLockToIUnknown*(x: ptr IBlockingLock): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITimeAndNoticeControlToIUnknown*(x: ptr ITimeAndNoticeControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOplockStorageToIUnknown*(x: ptr IOplockStorage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDirectWriterLockToIUnknown*(x: ptr IDirectWriterLock): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUrlMonToIUnknown*(x: ptr IUrlMon): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIForegroundTransferToIUnknown*(x: ptr IForegroundTransfer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIThumbnailExtractorToIUnknown*(x: ptr IThumbnailExtractor): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDummyHICONIncluderToIUnknown*(x: ptr IDummyHICONIncluder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProcessLockToIUnknown*(x: ptr IProcessLock): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISurrogateServiceToIUnknown*(x: ptr ISurrogateService): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeSpyToIUnknown*(x: ptr IInitializeSpy): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIApartmentShutdownToIUnknown*(x: ptr IApartmentShutdown): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICreateTypeInfoToIUnknown*(x: ptr ICreateTypeInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICreateTypeInfo2ToICreateTypeInfo*(x: ptr ICreateTypeInfo2): ptr ICreateTypeInfo = cast[ptr ICreateTypeInfo](x)
converter winimConverterICreateTypeInfo2ToIUnknown*(x: ptr ICreateTypeInfo2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICreateTypeLibToIUnknown*(x: ptr ICreateTypeLib): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICreateTypeLib2ToICreateTypeLib*(x: ptr ICreateTypeLib2): ptr ICreateTypeLib = cast[ptr ICreateTypeLib](x)
converter winimConverterICreateTypeLib2ToIUnknown*(x: ptr ICreateTypeLib2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDispatchToIUnknown*(x: ptr IDispatch): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumVARIANTToIUnknown*(x: ptr IEnumVARIANT): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeCompToIUnknown*(x: ptr ITypeComp): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeInfoToIUnknown*(x: ptr ITypeInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeInfo2ToITypeInfo*(x: ptr ITypeInfo2): ptr ITypeInfo = cast[ptr ITypeInfo](x)
converter winimConverterITypeInfo2ToIUnknown*(x: ptr ITypeInfo2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeLibToIUnknown*(x: ptr ITypeLib): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeLib2ToITypeLib*(x: ptr ITypeLib2): ptr ITypeLib = cast[ptr ITypeLib](x)
converter winimConverterITypeLib2ToIUnknown*(x: ptr ITypeLib2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeChangeEventsToIUnknown*(x: ptr ITypeChangeEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIErrorInfoToIUnknown*(x: ptr IErrorInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICreateErrorInfoToIUnknown*(x: ptr ICreateErrorInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISupportErrorInfoToIUnknown*(x: ptr ISupportErrorInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeFactoryToIUnknown*(x: ptr ITypeFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeMarshalToIUnknown*(x: ptr ITypeMarshal): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRecordInfoToIUnknown*(x: ptr IRecordInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIErrorLogToIUnknown*(x: ptr IErrorLog): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyBagToIUnknown*(x: ptr IPropertyBag): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleAdviseHolderToIUnknown*(x: ptr IOleAdviseHolder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleCacheToIUnknown*(x: ptr IOleCache): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleCache2ToIOleCache*(x: ptr IOleCache2): ptr IOleCache = cast[ptr IOleCache](x)
converter winimConverterIOleCache2ToIUnknown*(x: ptr IOleCache2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleCacheControlToIUnknown*(x: ptr IOleCacheControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIParseDisplayNameToIUnknown*(x: ptr IParseDisplayName): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleContainerToIParseDisplayName*(x: ptr IOleContainer): ptr IParseDisplayName = cast[ptr IParseDisplayName](x)
converter winimConverterIOleContainerToIUnknown*(x: ptr IOleContainer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleClientSiteToIUnknown*(x: ptr IOleClientSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleObjectToIUnknown*(x: ptr IOleObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleWindowToIUnknown*(x: ptr IOleWindow): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleLinkToIUnknown*(x: ptr IOleLink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleItemContainerToIOleContainer*(x: ptr IOleItemContainer): ptr IOleContainer = cast[ptr IOleContainer](x)
converter winimConverterIOleItemContainerToIParseDisplayName*(x: ptr IOleItemContainer): ptr IParseDisplayName = cast[ptr IParseDisplayName](x)
converter winimConverterIOleItemContainerToIUnknown*(x: ptr IOleItemContainer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleInPlaceUIWindowToIOleWindow*(x: ptr IOleInPlaceUIWindow): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIOleInPlaceUIWindowToIUnknown*(x: ptr IOleInPlaceUIWindow): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleInPlaceActiveObjectToIOleWindow*(x: ptr IOleInPlaceActiveObject): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIOleInPlaceActiveObjectToIUnknown*(x: ptr IOleInPlaceActiveObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleInPlaceFrameToIOleInPlaceUIWindow*(x: ptr IOleInPlaceFrame): ptr IOleInPlaceUIWindow = cast[ptr IOleInPlaceUIWindow](x)
converter winimConverterIOleInPlaceFrameToIOleWindow*(x: ptr IOleInPlaceFrame): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIOleInPlaceFrameToIUnknown*(x: ptr IOleInPlaceFrame): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleInPlaceObjectToIOleWindow*(x: ptr IOleInPlaceObject): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIOleInPlaceObjectToIUnknown*(x: ptr IOleInPlaceObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleInPlaceSiteToIOleWindow*(x: ptr IOleInPlaceSite): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIOleInPlaceSiteToIUnknown*(x: ptr IOleInPlaceSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIContinueToIUnknown*(x: ptr IContinue): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIViewObjectToIUnknown*(x: ptr IViewObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIViewObject2ToIViewObject*(x: ptr IViewObject2): ptr IViewObject = cast[ptr IViewObject](x)
converter winimConverterIViewObject2ToIUnknown*(x: ptr IViewObject2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDropSourceToIUnknown*(x: ptr IDropSource): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDropTargetToIUnknown*(x: ptr IDropTarget): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDropSourceNotifyToIUnknown*(x: ptr IDropSourceNotify): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumOLEVERBToIUnknown*(x: ptr IEnumOLEVERB): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIServiceProviderToIUnknown*(x: ptr IServiceProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMImplementationToIDispatch*(x: ptr IXMLDOMImplementation): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMImplementationToIUnknown*(x: ptr IXMLDOMImplementation): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMNodeToIDispatch*(x: ptr IXMLDOMNode): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMNodeToIUnknown*(x: ptr IXMLDOMNode): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMDocumentFragmentToIXMLDOMNode*(x: ptr IXMLDOMDocumentFragment): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMDocumentFragmentToIDispatch*(x: ptr IXMLDOMDocumentFragment): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMDocumentFragmentToIUnknown*(x: ptr IXMLDOMDocumentFragment): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMDocumentToIXMLDOMNode*(x: ptr IXMLDOMDocument): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMDocumentToIDispatch*(x: ptr IXMLDOMDocument): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMDocumentToIUnknown*(x: ptr IXMLDOMDocument): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMNodeListToIDispatch*(x: ptr IXMLDOMNodeList): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMNodeListToIUnknown*(x: ptr IXMLDOMNodeList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMNamedNodeMapToIDispatch*(x: ptr IXMLDOMNamedNodeMap): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMNamedNodeMapToIUnknown*(x: ptr IXMLDOMNamedNodeMap): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMCharacterDataToIXMLDOMNode*(x: ptr IXMLDOMCharacterData): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMCharacterDataToIDispatch*(x: ptr IXMLDOMCharacterData): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMCharacterDataToIUnknown*(x: ptr IXMLDOMCharacterData): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMAttributeToIXMLDOMNode*(x: ptr IXMLDOMAttribute): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMAttributeToIDispatch*(x: ptr IXMLDOMAttribute): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMAttributeToIUnknown*(x: ptr IXMLDOMAttribute): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMElementToIXMLDOMNode*(x: ptr IXMLDOMElement): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMElementToIDispatch*(x: ptr IXMLDOMElement): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMElementToIUnknown*(x: ptr IXMLDOMElement): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMTextToIXMLDOMCharacterData*(x: ptr IXMLDOMText): ptr IXMLDOMCharacterData = cast[ptr IXMLDOMCharacterData](x)
converter winimConverterIXMLDOMTextToIXMLDOMNode*(x: ptr IXMLDOMText): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMTextToIDispatch*(x: ptr IXMLDOMText): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMTextToIUnknown*(x: ptr IXMLDOMText): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMCommentToIXMLDOMCharacterData*(x: ptr IXMLDOMComment): ptr IXMLDOMCharacterData = cast[ptr IXMLDOMCharacterData](x)
converter winimConverterIXMLDOMCommentToIXMLDOMNode*(x: ptr IXMLDOMComment): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMCommentToIDispatch*(x: ptr IXMLDOMComment): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMCommentToIUnknown*(x: ptr IXMLDOMComment): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMProcessingInstructionToIXMLDOMNode*(x: ptr IXMLDOMProcessingInstruction): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMProcessingInstructionToIDispatch*(x: ptr IXMLDOMProcessingInstruction): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMProcessingInstructionToIUnknown*(x: ptr IXMLDOMProcessingInstruction): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMCDATASectionToIXMLDOMText*(x: ptr IXMLDOMCDATASection): ptr IXMLDOMText = cast[ptr IXMLDOMText](x)
converter winimConverterIXMLDOMCDATASectionToIXMLDOMCharacterData*(x: ptr IXMLDOMCDATASection): ptr IXMLDOMCharacterData = cast[ptr IXMLDOMCharacterData](x)
converter winimConverterIXMLDOMCDATASectionToIXMLDOMNode*(x: ptr IXMLDOMCDATASection): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMCDATASectionToIDispatch*(x: ptr IXMLDOMCDATASection): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMCDATASectionToIUnknown*(x: ptr IXMLDOMCDATASection): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMDocumentTypeToIXMLDOMNode*(x: ptr IXMLDOMDocumentType): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMDocumentTypeToIDispatch*(x: ptr IXMLDOMDocumentType): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMDocumentTypeToIUnknown*(x: ptr IXMLDOMDocumentType): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMNotationToIXMLDOMNode*(x: ptr IXMLDOMNotation): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMNotationToIDispatch*(x: ptr IXMLDOMNotation): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMNotationToIUnknown*(x: ptr IXMLDOMNotation): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMEntityToIXMLDOMNode*(x: ptr IXMLDOMEntity): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMEntityToIDispatch*(x: ptr IXMLDOMEntity): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMEntityToIUnknown*(x: ptr IXMLDOMEntity): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMEntityReferenceToIXMLDOMNode*(x: ptr IXMLDOMEntityReference): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXMLDOMEntityReferenceToIDispatch*(x: ptr IXMLDOMEntityReference): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMEntityReferenceToIUnknown*(x: ptr IXMLDOMEntityReference): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDOMParseErrorToIDispatch*(x: ptr IXMLDOMParseError): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDOMParseErrorToIUnknown*(x: ptr IXMLDOMParseError): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXTLRuntimeToIXMLDOMNode*(x: ptr IXTLRuntime): ptr IXMLDOMNode = cast[ptr IXMLDOMNode](x)
converter winimConverterIXTLRuntimeToIDispatch*(x: ptr IXTLRuntime): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXTLRuntimeToIUnknown*(x: ptr IXTLRuntime): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterXMLDOMDocumentEventsToIDispatch*(x: ptr XMLDOMDocumentEvents): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterXMLDOMDocumentEventsToIUnknown*(x: ptr XMLDOMDocumentEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLHttpRequestToIDispatch*(x: ptr IXMLHttpRequest): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLHttpRequestToIUnknown*(x: ptr IXMLHttpRequest): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDSOControlToIDispatch*(x: ptr IXMLDSOControl): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDSOControlToIUnknown*(x: ptr IXMLDSOControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLElementCollectionToIDispatch*(x: ptr IXMLElementCollection): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLElementCollectionToIUnknown*(x: ptr IXMLElementCollection): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDocumentToIDispatch*(x: ptr IXMLDocument): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDocumentToIUnknown*(x: ptr IXMLDocument): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLDocument2ToIDispatch*(x: ptr IXMLDocument2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLDocument2ToIUnknown*(x: ptr IXMLDocument2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLElementToIDispatch*(x: ptr IXMLElement): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLElementToIUnknown*(x: ptr IXMLElement): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLElement2ToIDispatch*(x: ptr IXMLElement2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLElement2ToIUnknown*(x: ptr IXMLElement2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLAttributeToIDispatch*(x: ptr IXMLAttribute): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIXMLAttributeToIUnknown*(x: ptr IXMLAttribute): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIXMLErrorToIUnknown*(x: ptr IXMLError): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistMonikerToIUnknown*(x: ptr IPersistMoniker): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMonikerPropToIUnknown*(x: ptr IMonikerProp): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBindProtocolToIUnknown*(x: ptr IBindProtocol): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBindingToIUnknown*(x: ptr IBinding): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBindStatusCallbackToIUnknown*(x: ptr IBindStatusCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBindStatusCallbackExToIBindStatusCallback*(x: ptr IBindStatusCallbackEx): ptr IBindStatusCallback = cast[ptr IBindStatusCallback](x)
converter winimConverterIBindStatusCallbackExToIUnknown*(x: ptr IBindStatusCallbackEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAuthenticateToIUnknown*(x: ptr IAuthenticate): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAuthenticateExToIAuthenticate*(x: ptr IAuthenticateEx): ptr IAuthenticate = cast[ptr IAuthenticate](x)
converter winimConverterIAuthenticateExToIUnknown*(x: ptr IAuthenticateEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHttpNegotiateToIUnknown*(x: ptr IHttpNegotiate): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHttpNegotiate2ToIHttpNegotiate*(x: ptr IHttpNegotiate2): ptr IHttpNegotiate = cast[ptr IHttpNegotiate](x)
converter winimConverterIHttpNegotiate2ToIUnknown*(x: ptr IHttpNegotiate2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHttpNegotiate3ToIHttpNegotiate2*(x: ptr IHttpNegotiate3): ptr IHttpNegotiate2 = cast[ptr IHttpNegotiate2](x)
converter winimConverterIHttpNegotiate3ToIHttpNegotiate*(x: ptr IHttpNegotiate3): ptr IHttpNegotiate = cast[ptr IHttpNegotiate](x)
converter winimConverterIHttpNegotiate3ToIUnknown*(x: ptr IHttpNegotiate3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWinInetFileStreamToIUnknown*(x: ptr IWinInetFileStream): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWindowForBindingUIToIUnknown*(x: ptr IWindowForBindingUI): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICodeInstallToIWindowForBindingUI*(x: ptr ICodeInstall): ptr IWindowForBindingUI = cast[ptr IWindowForBindingUI](x)
converter winimConverterICodeInstallToIUnknown*(x: ptr ICodeInstall): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUriToIUnknown*(x: ptr IUri): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUriContainerToIUnknown*(x: ptr IUriContainer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUriBuilderToIUnknown*(x: ptr IUriBuilder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUriBuilderFactoryToIUnknown*(x: ptr IUriBuilderFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWinInetInfoToIUnknown*(x: ptr IWinInetInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHttpSecurityToIWindowForBindingUI*(x: ptr IHttpSecurity): ptr IWindowForBindingUI = cast[ptr IWindowForBindingUI](x)
converter winimConverterIHttpSecurityToIUnknown*(x: ptr IHttpSecurity): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWinInetHttpInfoToIWinInetInfo*(x: ptr IWinInetHttpInfo): ptr IWinInetInfo = cast[ptr IWinInetInfo](x)
converter winimConverterIWinInetHttpInfoToIUnknown*(x: ptr IWinInetHttpInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWinInetHttpTimeoutsToIUnknown*(x: ptr IWinInetHttpTimeouts): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWinInetCacheHintsToIUnknown*(x: ptr IWinInetCacheHints): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWinInetCacheHints2ToIWinInetCacheHints*(x: ptr IWinInetCacheHints2): ptr IWinInetCacheHints = cast[ptr IWinInetCacheHints](x)
converter winimConverterIWinInetCacheHints2ToIUnknown*(x: ptr IWinInetCacheHints2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBindHostToIUnknown*(x: ptr IBindHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetToIUnknown*(x: ptr IInternet): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetBindInfoToIUnknown*(x: ptr IInternetBindInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetBindInfoExToIInternetBindInfo*(x: ptr IInternetBindInfoEx): ptr IInternetBindInfo = cast[ptr IInternetBindInfo](x)
converter winimConverterIInternetBindInfoExToIUnknown*(x: ptr IInternetBindInfoEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetProtocolRootToIUnknown*(x: ptr IInternetProtocolRoot): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetProtocolToIInternetProtocolRoot*(x: ptr IInternetProtocol): ptr IInternetProtocolRoot = cast[ptr IInternetProtocolRoot](x)
converter winimConverterIInternetProtocolToIUnknown*(x: ptr IInternetProtocol): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetProtocolExToIInternetProtocol*(x: ptr IInternetProtocolEx): ptr IInternetProtocol = cast[ptr IInternetProtocol](x)
converter winimConverterIInternetProtocolExToIInternetProtocolRoot*(x: ptr IInternetProtocolEx): ptr IInternetProtocolRoot = cast[ptr IInternetProtocolRoot](x)
converter winimConverterIInternetProtocolExToIUnknown*(x: ptr IInternetProtocolEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetProtocolSinkToIUnknown*(x: ptr IInternetProtocolSink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetProtocolSinkStackableToIUnknown*(x: ptr IInternetProtocolSinkStackable): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetSessionToIUnknown*(x: ptr IInternetSession): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetThreadSwitchToIUnknown*(x: ptr IInternetThreadSwitch): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetPriorityToIUnknown*(x: ptr IInternetPriority): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetProtocolInfoToIUnknown*(x: ptr IInternetProtocolInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetSecurityMgrSiteToIUnknown*(x: ptr IInternetSecurityMgrSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetSecurityManagerToIUnknown*(x: ptr IInternetSecurityManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetSecurityManagerExToIInternetSecurityManager*(x: ptr IInternetSecurityManagerEx): ptr IInternetSecurityManager = cast[ptr IInternetSecurityManager](x)
converter winimConverterIInternetSecurityManagerExToIUnknown*(x: ptr IInternetSecurityManagerEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetSecurityManagerEx2ToIInternetSecurityManagerEx*(x: ptr IInternetSecurityManagerEx2): ptr IInternetSecurityManagerEx = cast[ptr IInternetSecurityManagerEx](x)
converter winimConverterIInternetSecurityManagerEx2ToIInternetSecurityManager*(x: ptr IInternetSecurityManagerEx2): ptr IInternetSecurityManager = cast[ptr IInternetSecurityManager](x)
converter winimConverterIInternetSecurityManagerEx2ToIUnknown*(x: ptr IInternetSecurityManagerEx2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIZoneIdentifierToIUnknown*(x: ptr IZoneIdentifier): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetHostSecurityManagerToIUnknown*(x: ptr IInternetHostSecurityManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetZoneManagerToIUnknown*(x: ptr IInternetZoneManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetZoneManagerExToIInternetZoneManager*(x: ptr IInternetZoneManagerEx): ptr IInternetZoneManager = cast[ptr IInternetZoneManager](x)
converter winimConverterIInternetZoneManagerExToIUnknown*(x: ptr IInternetZoneManagerEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInternetZoneManagerEx2ToIInternetZoneManagerEx*(x: ptr IInternetZoneManagerEx2): ptr IInternetZoneManagerEx = cast[ptr IInternetZoneManagerEx](x)
converter winimConverterIInternetZoneManagerEx2ToIInternetZoneManager*(x: ptr IInternetZoneManagerEx2): ptr IInternetZoneManager = cast[ptr IInternetZoneManager](x)
converter winimConverterIInternetZoneManagerEx2ToIUnknown*(x: ptr IInternetZoneManagerEx2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISoftDistExtToIUnknown*(x: ptr ISoftDistExt): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICatalogFileInfoToIUnknown*(x: ptr ICatalogFileInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDataFilterToIUnknown*(x: ptr IDataFilter): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEncodingFilterFactoryToIUnknown*(x: ptr IEncodingFilterFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWrappedProtocolToIUnknown*(x: ptr IWrappedProtocol): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIGetBindHandleToIUnknown*(x: ptr IGetBindHandle): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIBindCallbackRedirectToIUnknown*(x: ptr IBindCallbackRedirect): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyStorageToIUnknown*(x: ptr IPropertyStorage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertySetStorageToIUnknown*(x: ptr IPropertySetStorage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumSTATPROPSTGToIUnknown*(x: ptr IEnumSTATPROPSTG): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumSTATPROPSETSTGToIUnknown*(x: ptr IEnumSTATPROPSETSTG): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumConnectionsToIUnknown*(x: ptr IEnumConnections): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIConnectionPointToIUnknown*(x: ptr IConnectionPoint): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumConnectionPointsToIUnknown*(x: ptr IEnumConnectionPoints): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIConnectionPointContainerToIUnknown*(x: ptr IConnectionPointContainer): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIClassFactory2ToIClassFactory*(x: ptr IClassFactory2): ptr IClassFactory = cast[ptr IClassFactory](x)
converter winimConverterIClassFactory2ToIUnknown*(x: ptr IClassFactory2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProvideClassInfoToIUnknown*(x: ptr IProvideClassInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProvideClassInfo2ToIProvideClassInfo*(x: ptr IProvideClassInfo2): ptr IProvideClassInfo = cast[ptr IProvideClassInfo](x)
converter winimConverterIProvideClassInfo2ToIUnknown*(x: ptr IProvideClassInfo2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProvideMultipleClassInfoToIProvideClassInfo2*(x: ptr IProvideMultipleClassInfo): ptr IProvideClassInfo2 = cast[ptr IProvideClassInfo2](x)
converter winimConverterIProvideMultipleClassInfoToIProvideClassInfo*(x: ptr IProvideMultipleClassInfo): ptr IProvideClassInfo = cast[ptr IProvideClassInfo](x)
converter winimConverterIProvideMultipleClassInfoToIUnknown*(x: ptr IProvideMultipleClassInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleControlToIUnknown*(x: ptr IOleControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleControlSiteToIUnknown*(x: ptr IOleControlSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyPageToIUnknown*(x: ptr IPropertyPage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyPage2ToIPropertyPage*(x: ptr IPropertyPage2): ptr IPropertyPage = cast[ptr IPropertyPage](x)
converter winimConverterIPropertyPage2ToIUnknown*(x: ptr IPropertyPage2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyPageSiteToIUnknown*(x: ptr IPropertyPageSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyNotifySinkToIUnknown*(x: ptr IPropertyNotifySink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISpecifyPropertyPagesToIUnknown*(x: ptr ISpecifyPropertyPages): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistMemoryToIPersist*(x: ptr IPersistMemory): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistMemoryToIUnknown*(x: ptr IPersistMemory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistStreamInitToIPersist*(x: ptr IPersistStreamInit): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistStreamInitToIUnknown*(x: ptr IPersistStreamInit): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistPropertyBagToIPersist*(x: ptr IPersistPropertyBag): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistPropertyBagToIUnknown*(x: ptr IPersistPropertyBag): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISimpleFrameSiteToIUnknown*(x: ptr ISimpleFrameSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFontToIUnknown*(x: ptr IFont): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPictureToIUnknown*(x: ptr IPicture): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPicture2ToIUnknown*(x: ptr IPicture2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFontEventsDispToIDispatch*(x: ptr IFontEventsDisp): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIFontEventsDispToIUnknown*(x: ptr IFontEventsDisp): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIFontDispToIDispatch*(x: ptr IFontDisp): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIFontDispToIUnknown*(x: ptr IFontDisp): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPictureDispToIDispatch*(x: ptr IPictureDisp): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIPictureDispToIUnknown*(x: ptr IPictureDisp): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleInPlaceObjectWindowlessToIOleInPlaceObject*(x: ptr IOleInPlaceObjectWindowless): ptr IOleInPlaceObject = cast[ptr IOleInPlaceObject](x)
converter winimConverterIOleInPlaceObjectWindowlessToIOleWindow*(x: ptr IOleInPlaceObjectWindowless): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIOleInPlaceObjectWindowlessToIUnknown*(x: ptr IOleInPlaceObjectWindowless): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleInPlaceSiteExToIOleInPlaceSite*(x: ptr IOleInPlaceSiteEx): ptr IOleInPlaceSite = cast[ptr IOleInPlaceSite](x)
converter winimConverterIOleInPlaceSiteExToIOleWindow*(x: ptr IOleInPlaceSiteEx): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIOleInPlaceSiteExToIUnknown*(x: ptr IOleInPlaceSiteEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleInPlaceSiteWindowlessToIOleInPlaceSiteEx*(x: ptr IOleInPlaceSiteWindowless): ptr IOleInPlaceSiteEx = cast[ptr IOleInPlaceSiteEx](x)
converter winimConverterIOleInPlaceSiteWindowlessToIOleInPlaceSite*(x: ptr IOleInPlaceSiteWindowless): ptr IOleInPlaceSite = cast[ptr IOleInPlaceSite](x)
converter winimConverterIOleInPlaceSiteWindowlessToIOleWindow*(x: ptr IOleInPlaceSiteWindowless): ptr IOleWindow = cast[ptr IOleWindow](x)
converter winimConverterIOleInPlaceSiteWindowlessToIUnknown*(x: ptr IOleInPlaceSiteWindowless): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIViewObjectExToIViewObject2*(x: ptr IViewObjectEx): ptr IViewObject2 = cast[ptr IViewObject2](x)
converter winimConverterIViewObjectExToIViewObject*(x: ptr IViewObjectEx): ptr IViewObject = cast[ptr IViewObject](x)
converter winimConverterIViewObjectExToIUnknown*(x: ptr IViewObjectEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleUndoUnitToIUnknown*(x: ptr IOleUndoUnit): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleParentUndoUnitToIOleUndoUnit*(x: ptr IOleParentUndoUnit): ptr IOleUndoUnit = cast[ptr IOleUndoUnit](x)
converter winimConverterIOleParentUndoUnitToIUnknown*(x: ptr IOleParentUndoUnit): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumOleUndoUnitsToIUnknown*(x: ptr IEnumOleUndoUnits): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleUndoManagerToIUnknown*(x: ptr IOleUndoManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPointerInactiveToIUnknown*(x: ptr IPointerInactive): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectWithSiteToIUnknown*(x: ptr IObjectWithSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPerPropertyBrowsingToIUnknown*(x: ptr IPerPropertyBrowsing): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyBag2ToIUnknown*(x: ptr IPropertyBag2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistPropertyBag2ToIPersist*(x: ptr IPersistPropertyBag2): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIPersistPropertyBag2ToIUnknown*(x: ptr IPersistPropertyBag2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAdviseSinkExToIAdviseSink*(x: ptr IAdviseSinkEx): ptr IAdviseSink = cast[ptr IAdviseSink](x)
converter winimConverterIAdviseSinkExToIUnknown*(x: ptr IAdviseSinkEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIQuickActivateToIUnknown*(x: ptr IQuickActivate): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumGUIDToIUnknown*(x: ptr IEnumGUID): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumCATEGORYINFOToIUnknown*(x: ptr IEnumCATEGORYINFO): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICatRegisterToIUnknown*(x: ptr ICatRegister): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICatInformationToIUnknown*(x: ptr ICatInformation): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleDocumentToIUnknown*(x: ptr IOleDocument): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleDocumentSiteToIUnknown*(x: ptr IOleDocumentSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleDocumentViewToIUnknown*(x: ptr IOleDocumentView): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIEnumOleDocumentViewsToIUnknown*(x: ptr IEnumOleDocumentViews): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIContinueCallbackToIUnknown*(x: ptr IContinueCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPrintToIUnknown*(x: ptr IPrint): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIOleCommandTargetToIUnknown*(x: ptr IOleCommandTarget): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIZoomEventsToIUnknown*(x: ptr IZoomEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProtectFocusToIUnknown*(x: ptr IProtectFocus): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProtectedModeMenuServicesToIUnknown*(x: ptr IProtectedModeMenuServices): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWebBrowserToIDispatch*(x: ptr IWebBrowser): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIWebBrowserToIUnknown*(x: ptr IWebBrowser): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterDWebBrowserEventsToIDispatch*(x: ptr DWebBrowserEvents): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterDWebBrowserEventsToIUnknown*(x: ptr DWebBrowserEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWebBrowserAppToIWebBrowser*(x: ptr IWebBrowserApp): ptr IWebBrowser = cast[ptr IWebBrowser](x)
converter winimConverterIWebBrowserAppToIDispatch*(x: ptr IWebBrowserApp): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIWebBrowserAppToIUnknown*(x: ptr IWebBrowserApp): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWebBrowser2ToIWebBrowserApp*(x: ptr IWebBrowser2): ptr IWebBrowserApp = cast[ptr IWebBrowserApp](x)
converter winimConverterIWebBrowser2ToIWebBrowser*(x: ptr IWebBrowser2): ptr IWebBrowser = cast[ptr IWebBrowser](x)
converter winimConverterIWebBrowser2ToIDispatch*(x: ptr IWebBrowser2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIWebBrowser2ToIUnknown*(x: ptr IWebBrowser2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterDWebBrowserEvents2ToIDispatch*(x: ptr DWebBrowserEvents2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterDWebBrowserEvents2ToIUnknown*(x: ptr DWebBrowserEvents2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterDShellWindowsEventsToIDispatch*(x: ptr DShellWindowsEvents): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterDShellWindowsEventsToIUnknown*(x: ptr DShellWindowsEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellWindowsToIDispatch*(x: ptr IShellWindows): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellWindowsToIUnknown*(x: ptr IShellWindows): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellUIHelperToIDispatch*(x: ptr IShellUIHelper): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellUIHelperToIUnknown*(x: ptr IShellUIHelper): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellUIHelper2ToIShellUIHelper*(x: ptr IShellUIHelper2): ptr IShellUIHelper = cast[ptr IShellUIHelper](x)
converter winimConverterIShellUIHelper2ToIDispatch*(x: ptr IShellUIHelper2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellUIHelper2ToIUnknown*(x: ptr IShellUIHelper2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterDShellNameSpaceEventsToIDispatch*(x: ptr DShellNameSpaceEvents): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterDShellNameSpaceEventsToIUnknown*(x: ptr DShellNameSpaceEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellFavoritesNameSpaceToIDispatch*(x: ptr IShellFavoritesNameSpace): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellFavoritesNameSpaceToIUnknown*(x: ptr IShellFavoritesNameSpace): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIShellNameSpaceToIShellFavoritesNameSpace*(x: ptr IShellNameSpace): ptr IShellFavoritesNameSpace = cast[ptr IShellFavoritesNameSpace](x)
converter winimConverterIShellNameSpaceToIDispatch*(x: ptr IShellNameSpace): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIShellNameSpaceToIUnknown*(x: ptr IShellNameSpace): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIScriptErrorListToIDispatch*(x: ptr IScriptErrorList): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIScriptErrorListToIUnknown*(x: ptr IScriptErrorList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchToIDispatch*(x: ptr ISearch): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterISearchToIUnknown*(x: ptr ISearch): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchesToIDispatch*(x: ptr ISearches): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterISearchesToIUnknown*(x: ptr ISearches): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchAssistantOCToIDispatch*(x: ptr ISearchAssistantOC): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterISearchAssistantOCToIUnknown*(x: ptr ISearchAssistantOC): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchAssistantOC2ToISearchAssistantOC*(x: ptr ISearchAssistantOC2): ptr ISearchAssistantOC = cast[ptr ISearchAssistantOC](x)
converter winimConverterISearchAssistantOC2ToIDispatch*(x: ptr ISearchAssistantOC2): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterISearchAssistantOC2ToIUnknown*(x: ptr ISearchAssistantOC2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISearchAssistantOC3ToISearchAssistantOC2*(x: ptr ISearchAssistantOC3): ptr ISearchAssistantOC2 = cast[ptr ISearchAssistantOC2](x)
converter winimConverterISearchAssistantOC3ToISearchAssistantOC*(x: ptr ISearchAssistantOC3): ptr ISearchAssistantOC = cast[ptr ISearchAssistantOC](x)
converter winimConverterISearchAssistantOC3ToIDispatch*(x: ptr ISearchAssistantOC3): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterISearchAssistantOC3ToIUnknown*(x: ptr ISearchAssistantOC3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterSearchAssistantEventsToIDispatch*(x: ptr SearchAssistantEvents): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterSearchAssistantEventsToIUnknown*(x: ptr SearchAssistantEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRichChunkToIUnknown*(x: ptr IRichChunk): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIConditionToIPersistStream*(x: ptr ICondition): ptr IPersistStream = cast[ptr IPersistStream](x)
converter winimConverterIConditionToIPersist*(x: ptr ICondition): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterIConditionToIUnknown*(x: ptr ICondition): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICondition2ToICondition*(x: ptr ICondition2): ptr ICondition = cast[ptr ICondition](x)
converter winimConverterICondition2ToIPersistStream*(x: ptr ICondition2): ptr IPersistStream = cast[ptr IPersistStream](x)
converter winimConverterICondition2ToIPersist*(x: ptr ICondition2): ptr IPersist = cast[ptr IPersist](x)
converter winimConverterICondition2ToIUnknown*(x: ptr ICondition2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeWithFileToIUnknown*(x: ptr IInitializeWithFile): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInitializeWithStreamToIUnknown*(x: ptr IInitializeWithStream): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyStoreToIUnknown*(x: ptr IPropertyStore): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterINamedPropertyStoreToIUnknown*(x: ptr INamedPropertyStore): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectWithPropertyKeyToIUnknown*(x: ptr IObjectWithPropertyKey): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyChangeToIObjectWithPropertyKey*(x: ptr IPropertyChange): ptr IObjectWithPropertyKey = cast[ptr IObjectWithPropertyKey](x)
converter winimConverterIPropertyChangeToIUnknown*(x: ptr IPropertyChange): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyChangeArrayToIUnknown*(x: ptr IPropertyChangeArray): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyStoreCapabilitiesToIUnknown*(x: ptr IPropertyStoreCapabilities): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyStoreCacheToIPropertyStore*(x: ptr IPropertyStoreCache): ptr IPropertyStore = cast[ptr IPropertyStore](x)
converter winimConverterIPropertyStoreCacheToIUnknown*(x: ptr IPropertyStoreCache): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyEnumTypeToIUnknown*(x: ptr IPropertyEnumType): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyEnumType2ToIPropertyEnumType*(x: ptr IPropertyEnumType2): ptr IPropertyEnumType = cast[ptr IPropertyEnumType](x)
converter winimConverterIPropertyEnumType2ToIUnknown*(x: ptr IPropertyEnumType2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyEnumTypeListToIUnknown*(x: ptr IPropertyEnumTypeList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyDescriptionToIUnknown*(x: ptr IPropertyDescription): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyDescription2ToIPropertyDescription*(x: ptr IPropertyDescription2): ptr IPropertyDescription = cast[ptr IPropertyDescription](x)
converter winimConverterIPropertyDescription2ToIUnknown*(x: ptr IPropertyDescription2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyDescriptionAliasInfoToIPropertyDescription*(x: ptr IPropertyDescriptionAliasInfo): ptr IPropertyDescription = cast[ptr IPropertyDescription](x)
converter winimConverterIPropertyDescriptionAliasInfoToIUnknown*(x: ptr IPropertyDescriptionAliasInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyDescriptionSearchInfoToIPropertyDescription*(x: ptr IPropertyDescriptionSearchInfo): ptr IPropertyDescription = cast[ptr IPropertyDescription](x)
converter winimConverterIPropertyDescriptionSearchInfoToIUnknown*(x: ptr IPropertyDescriptionSearchInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyDescriptionRelatedPropertyInfoToIPropertyDescription*(x: ptr IPropertyDescriptionRelatedPropertyInfo): ptr IPropertyDescription = cast[ptr IPropertyDescription](x)
converter winimConverterIPropertyDescriptionRelatedPropertyInfoToIUnknown*(x: ptr IPropertyDescriptionRelatedPropertyInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertySystemToIUnknown*(x: ptr IPropertySystem): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyDescriptionListToIUnknown*(x: ptr IPropertyDescriptionList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertyStoreFactoryToIUnknown*(x: ptr IPropertyStoreFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDelayedPropertyStoreFactoryToIPropertyStoreFactory*(x: ptr IDelayedPropertyStoreFactory): ptr IPropertyStoreFactory = cast[ptr IPropertyStoreFactory](x)
converter winimConverterIDelayedPropertyStoreFactoryToIUnknown*(x: ptr IDelayedPropertyStoreFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistSerializedPropStorageToIUnknown*(x: ptr IPersistSerializedPropStorage): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPersistSerializedPropStorage2ToIPersistSerializedPropStorage*(x: ptr IPersistSerializedPropStorage2): ptr IPersistSerializedPropStorage = cast[ptr IPersistSerializedPropStorage](x)
converter winimConverterIPersistSerializedPropStorage2ToIUnknown*(x: ptr IPersistSerializedPropStorage2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIPropertySystemChangeNotifyToIUnknown*(x: ptr IPropertySystemChangeNotify): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICreateObjectToIUnknown*(x: ptr ICreateObject): ptr IUnknown = cast[ptr IUnknown](x)
when winimUnicode:
  proc URLOpenStream*(P1: LPUNKNOWN, P2: LPCWSTR, P3: DWORD, P4: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLOpenStreamW".}
  proc URLOpenPullStream*(P1: LPUNKNOWN, P2: LPCWSTR, P3: DWORD, P4: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLOpenPullStreamW".}
  proc URLDownloadToFile*(P1: LPUNKNOWN, P2: LPCWSTR, P3: LPCWSTR, P4: DWORD, P5: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLDownloadToFileW".}
  proc URLDownloadToCacheFile*(P1: LPUNKNOWN, P2: LPCWSTR, P3: LPWSTR, P4: DWORD, P5: DWORD, P6: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLDownloadToCacheFileW".}
  proc URLOpenBlockingStream*(P1: LPUNKNOWN, P2: LPCWSTR, P3: ptr LPSTREAM, P4: DWORD, P5: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLOpenBlockingStreamW".}
  proc IsLoggingEnabled*(pwszUrl: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "urlmon", importc: "IsLoggingEnabledW".}
when winimAnsi:
  proc URLOpenStream*(P1: LPUNKNOWN, P2: LPCSTR, P3: DWORD, P4: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLOpenStreamA".}
  proc URLOpenPullStream*(P1: LPUNKNOWN, P2: LPCSTR, P3: DWORD, P4: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLOpenPullStreamA".}
  proc URLDownloadToFile*(P1: LPUNKNOWN, P2: LPCSTR, P3: LPCSTR, P4: DWORD, P5: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLDownloadToFileA".}
  proc URLDownloadToCacheFile*(P1: LPUNKNOWN, P2: LPCSTR, P3: LPSTR, P4: DWORD, P5: DWORD, P6: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLDownloadToCacheFileA".}
  proc URLOpenBlockingStream*(P1: LPUNKNOWN, P2: LPCSTR, P3: ptr LPSTREAM, P4: DWORD, P5: LPBINDSTATUSCALLBACK): HRESULT {.winapi, stdcall, dynlib: "urlmon", importc: "URLOpenBlockingStreamA".}
  proc IsLoggingEnabled*(pszUrl: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "urlmon", importc: "IsLoggingEnabledA".}
