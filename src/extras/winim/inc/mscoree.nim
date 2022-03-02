#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import objbase
#include <mscoree.h>
#include <gchost.h>
#include <ivalidator.h>
#include <ivehandler.h>
#include <metahost.h>
#include <mscorlib.tlh>
type
  COR_GC_STAT_TYPES* = int32
  COR_GC_THREAD_STATS_TYPES* = int32
  ValidatorFlags* = int32
  HOST_TYPE* = int32
  STARTUP_FLAGS* = int32
  CLSID_RESOLUTION_FLAGS* = int32
  RUNTIME_INFO_FLAGS* = int32
  APPDOMAIN_SECURITY_FLAGS* = int32
  HDOMAINENUM* = pointer
  EMemoryAvailable* = int32
  EMemoryCriticalLevel* = int32
  WAIT_OPTION* = int32
  MALLOC_TYPE* = int32
  ETaskType* = int32
  ESymbolReadingPolicy* = int32
  ECustomDumpFlavor* = int32
  ECustomDumpItemKind* = int32
  BucketParameterIndex* = int32
  EClrOperation* = int32
  EClrFailure* = int32
  EClrUnhandledException* = int32
  EPolicyAction* = int32
  EClrEvent* = int32
  StackOverflowType* = int32
  ECLRAssemblyIdentityFlags* = int32
  EHostBindingPolicyModifyFlags* = int32
  EBindPolicyLevels* = int32
  EHostApplicationPolicy* = int32
  EApiCategories* = int32
  EInitializeNewDomainFlags* = int32
  EContextType* = int32
  METAHOST_POLICY_FLAGS* = int32
  METAHOST_CONFIG_FLAGS* = int32
  CLR_DEBUGGING_PROCESS_FLAGS* = int32
  BindingFlags* = int32
  MemberTypes* = int32
  CallingConventions* = int32
  TypeAttributes* = int32
  AssemblyBuilderAccess* = int32
  AssemblyBuilder* = int32
  PrincipalPolicy* = int32
  CONNID* = DWORD
  VerError* {.pure.} = object
    flags*: int32
    opcode*: int32
    uOffset*: int32
    Token*: int32
    item1_flags*: int32
    item1_data*: ptr int32
    item2_flags*: int32
    item2_data*: ptr int32
  VEContext* = VerError
  TASKID* = UINT64
  POBJECT* = ptr object
const
  COR_GC_COUNTS* = 0x1
  COR_GC_MEMORYUSAGE* = 0x2
  COR_GC_THREAD_HAS_PROMOTED_BYTES* = 0x1
  IID_IGCHost* = DEFINE_GUID("fac34f6e-0dcd-47b5-8021-531bc5ecca63")
  IID_IGCHost2* = DEFINE_GUID("a1d70cec-2dbe-4e2f-9291-fdf81438a1df")
  CLSID_VEHandlerClass* = DEFINE_GUID("856ca1b1-7dab-11d3-acec-00c04f86c309")
  IID_IVEHandler* = DEFINE_GUID("856ca1b2-7dab-11d3-acec-00c04f86c309")
  VALIDATOR_EXTRA_VERBOSE* = 0x1
  VALIDATOR_SHOW_SOURCE_LINES* = 0x2
  VALIDATOR_CHECK_ILONLY* = 0x4
  VALIDATOR_CHECK_PEFORMAT_ONLY* = 0x8
  VALIDATOR_NOCHECK_PEFORMAT* = 0x10
  VALIDATOR_TRANSPARENT_ONLY* = 0x20
  IID_IValidator* = DEFINE_GUID("63df8730-dc81-4062-84a2-1ff943f59fac")
  IID_ICLRValidator* = DEFINE_GUID("63df8730-dc81-4062-84a2-1ff943f59fdd")
  CLR_MAJOR_VERSION* = 4
  CLR_MINOR_VERSION* = 0
  CLR_BUILD_VERSION* = 30319
  CLR_ASSEMBLY_MAJOR_VERSION* = 4
  CLR_ASSEMBLY_MINOR_VERSION* = 0
  CLR_ASSEMBLY_BUILD_VERSION* = 0
  LIBID_mscoree* = DEFINE_GUID("5477469e-83b1-11d2-8b49-00a0c9b7c9c4")
  CLSID_CorRuntimeHost* = DEFINE_GUID("cb2f6723-ab3a-11d2-9c40-00c04fa30a3e")
  CLSID_TypeNameFactory* = DEFINE_GUID("b81ff171-20f3-11d2-8dcc-00a0c9b00525")
  CLSID_CLRRuntimeHost* = DEFINE_GUID("90f1a06e-7712-4762-86b5-7a5eba6bdb02")
  CLSID_ComCallUnmarshal* = DEFINE_GUID("3f281000-e95a-11d2-886b-00c04f869f04")
  CLSID_ComCallUnmarshalV4* = DEFINE_GUID("45fb4600-e6e8-4928-b25e-50476ff79425")
  IID_IObjectHandle* = DEFINE_GUID("c460e2b4-e199-412a-8456-84dc3e4838c3")
  IID_IManagedObject* = DEFINE_GUID("c3fcc19e-a970-11d2-8b5a-00a0c9b7c9c4")
  IID_IApartmentCallback* = DEFINE_GUID("178e5337-1528-4591-b1c9-1c6e484686d8")
  IID_ICatalogServices* = DEFINE_GUID("04c6be1e-1db1-4058-ab7a-700cccfbf254")
  IID_ICorRuntimeHost* = DEFINE_GUID("cb2f6722-ab3a-11d2-9c40-00c04fa30a3e")
  IID_ICorThreadpool* = DEFINE_GUID("84680d3a-b2c1-46e8-acc2-dbc0a359159a")
  IID_ICLRDebugManager* = DEFINE_GUID("00dcaec6-2ac0-43a9-acf9-1e36c139b10d")
  IID_IHostMemoryNeededCallback* = DEFINE_GUID("47eb8e57-0846-4546-af76-6f42fcfc2649")
  IID_IHostMalloc* = DEFINE_GUID("1831991c-cc53-4a31-b218-04e910446479")
  IID_IHostMemoryManager* = DEFINE_GUID("7bc698d1-f9e3-4460-9cde-d04248e9fa25")
  IID_ICLRTask* = DEFINE_GUID("28e66a4a-9906-4225-b231-9187c3eb8611")
  IID_ICLRTask2* = DEFINE_GUID("28e66a4a-9906-4225-b231-9187c3eb8612")
  IID_IHostTask* = DEFINE_GUID("c2275828-c4b1-4b55-82c9-92135f74df1a")
  IID_ICLRTaskManager* = DEFINE_GUID("4862efbe-3ae5-44f8-8feb-346190ee8a34")
  IID_IHostTaskManager* = DEFINE_GUID("997ff24c-43b7-4352-8667-0dc04fafd354")
  IID_IHostThreadpoolManager* = DEFINE_GUID("983d50e2-cb15-466b-80fc-845dc6e8c5fd")
  IID_ICLRIoCompletionManager* = DEFINE_GUID("2d74ce86-b8d6-4c84-b3a7-9768933b3c12")
  IID_IHostIoCompletionManager* = DEFINE_GUID("8bde9d80-ec06-41d6-83e6-22580effcc20")
  IID_IHostSyncManager* = DEFINE_GUID("234330c7-5f10-4f20-9615-5122dab7a0ac")
  IID_IHostCrst* = DEFINE_GUID("6df710a6-26a4-4a65-8cd5-7237b8bda8dc")
  IID_IHostAutoEvent* = DEFINE_GUID("50b0cfce-4063-4278-9673-e5cb4ed0bdb8")
  IID_IHostManualEvent* = DEFINE_GUID("1bf4ec38-affe-4fb9-85a6-525268f15b54")
  IID_IHostSemaphore* = DEFINE_GUID("855efd47-cc09-463a-a97d-16acab882661")
  IID_ICLRSyncManager* = DEFINE_GUID("55ff199d-ad21-48f9-a16c-f24ebbb8727d")
  IID_ICLRAppDomainResourceMonitor* = DEFINE_GUID("c62de18c-2e23-4aea-8423-b40c1fc59eae")
  IID_ICLRPolicyManager* = DEFINE_GUID("7d290010-d781-45da-a6f8-aa5d711a730e")
  IID_ICLRGCManager* = DEFINE_GUID("54d9007e-a8e2-4885-b7bf-f998deee4f2a")
  IID_ICLRGCManager2* = DEFINE_GUID("0603b793-a97a-4712-9cb4-0cd1c74c0f7c")
  IID_ICLRErrorReportingManager* = DEFINE_GUID("980d2f1a-bf79-4c08-812a-bb9778928f78")
  IID_IHostPolicyManager* = DEFINE_GUID("7ae49844-b1e3-4683-ba7c-1e8212ea3b79")
  IID_IHostGCManager* = DEFINE_GUID("5d4ec34e-f248-457b-b603-255faaba0d21")
  IID_IActionOnCLREvent* = DEFINE_GUID("607be24b-d91b-4e28-a242-61871ce56e35")
  IID_ICLROnEventManager* = DEFINE_GUID("1d0e0132-e64f-493d-9260-025c0e32c175")
  IID_ICLRRuntimeHost* = DEFINE_GUID("90f1a06c-7712-4762-86b5-7a5eba6bdb02")
  IID_ICLRHostProtectionManager* = DEFINE_GUID("89f25f5c-ceef-43e1-9cfa-a68ce863aaac")
  IID_IHostAssemblyStore* = DEFINE_GUID("7b102a88-3f7f-496d-8fa2-c35374e01af3")
  IID_IHostAssemblyManager* = DEFINE_GUID("613dabd7-62b2-493e-9e65-c1e32a1e0c5e")
  IID_IHostSecurityManager* = DEFINE_GUID("75ad2468-a349-4d02-a764-76a68aee0c4f")
  IID_IHostSecurityContext* = DEFINE_GUID("7e573ce4-0343-4423-98d7-6318348a1d3c")
  IID_ICLRAssemblyIdentityManager* = DEFINE_GUID("15f0a9da-3ff6-4393-9da9-fdfd284e6972")
  IID_ICLRDomainManager* = DEFINE_GUID("270d00a2-8e15-4d0b-adeb-37bc3e47df77")
  IID_ITypeName* = DEFINE_GUID("b81ff171-20f3-11d2-8dcc-00a0c9b00522")
  IID_ICLRAssemblyReferenceList* = DEFINE_GUID("1b2c9750-2e66-4bda-8b44-0a642c5cd733")
  IID_ICLRReferenceAssemblyEnum* = DEFINE_GUID("d509cb5d-cf32-4876-ae61-67770cf91973")
  IID_ICLRProbingAssemblyEnum* = DEFINE_GUID("d0c5fb1f-416b-4f97-81f4-7ac7dc24dd5d")
  IID_ICLRHostBindingPolicyManager* = DEFINE_GUID("4b3545e7-1856-48c9-a8ba-24b21a753c09")
  IID_ITypeNameBuilder* = DEFINE_GUID("b81ff171-20f3-11d2-8dcc-00a0c9b00523")
  IID_ITypeNameFactory* = DEFINE_GUID("b81ff171-20f3-11d2-8dcc-00a0c9b00521")
  HOST_TYPE_DEFAULT* = 0
  HOST_TYPE_APPLAUNCH* = 0x1
  HOST_TYPE_CORFLAG* = 0x2
  STARTUP_CONCURRENT_GC* = 0x1
  STARTUP_LOADER_OPTIMIZATION_MASK* = 0x3 shl 1
  STARTUP_LOADER_OPTIMIZATION_SINGLE_DOMAIN* = 0x1 shl 1
  STARTUP_LOADER_OPTIMIZATION_MULTI_DOMAIN* = 0x2 shl 1
  STARTUP_LOADER_OPTIMIZATION_MULTI_DOMAIN_HOST* = 0x3 shl 1
  STARTUP_LOADER_SAFEMODE* = 0x10
  STARTUP_LOADER_SETPREFERENCE* = 0x100
  STARTUP_SERVER_GC* = 0x1000
  STARTUP_HOARD_GC_VM* = 0x2000
  STARTUP_SINGLE_VERSION_HOSTING_INTERFACE* = 0x4000
  STARTUP_LEGACY_IMPERSONATION* = 0x10000
  STARTUP_DISABLE_COMMITTHREADSTACK* = 0x20000
  STARTUP_ALWAYSFLOW_IMPERSONATION* = 0x40000
  STARTUP_TRIM_GC_COMMIT* = 0x80000
  STARTUP_ETW* = 0x100000
  STARTUP_ARM* = 0x400000
  CLSID_RESOLUTION_DEFAULT* = 0
  CLSID_RESOLUTION_REGISTERED* = 0x1
  RUNTIME_INFO_UPGRADE_VERSION* = 0x1
  RUNTIME_INFO_REQUEST_IA64* = 0x2
  RUNTIME_INFO_REQUEST_AMD64* = 0x4
  RUNTIME_INFO_REQUEST_X86* = 0x8
  RUNTIME_INFO_DONT_RETURN_DIRECTORY* = 0x10
  RUNTIME_INFO_DONT_RETURN_VERSION* = 0x20
  RUNTIME_INFO_DONT_SHOW_ERROR_DIALOG* = 0x40
  RUNTIME_INFO_IGNORE_ERROR_MODE* = 0x1000
  APPDOMAIN_SECURITY_DEFAULT* = 0
  APPDOMAIN_SECURITY_SANDBOXED* = 0x1
  APPDOMAIN_SECURITY_FORBID_CROSSAD_REVERSE_PINVOKE* = 0x2
  APPDOMAIN_FORCE_TRIVIAL_WAIT_OPERATIONS* = 0x8
  IID_IAppDomainBinding* = DEFINE_GUID("5c2b07a7-1e98-11d3-872f-00c04f79ed0d")
  IID_IGCThreadControl* = DEFINE_GUID("f31d1788-c397-4725-87a5-6af3472c2791")
  IID_IGCHostControl* = DEFINE_GUID("5513d564-8374-4cb9-aed9-0083f4160a1d")
  IID_IDebuggerThreadControl* = DEFINE_GUID("23d86786-0bb5-4774-8fb5-e3522add6246")
  IID_IDebuggerInfo* = DEFINE_GUID("bf24142d-a47d-4d24-a66d-8c2141944e44")
  IID_ICorConfiguration* = DEFINE_GUID("5c2b07a5-1e98-11d3-872f-00c04f79ed0d")
  eMemoryAvailableLow* = 1
  eMemoryAvailableNeutral* = 2
  eMemoryAvailableHigh* = 3
  eTaskCritical* = 0
  eAppDomainCritical* = 1
  eProcessCritical* = 2
  WAIT_MSGPUMP* = 0x1
  WAIT_ALERTABLE* = 0x2
  WAIT_NOTINDEADLOCK* = 0x4
  IID_ICLRMemoryNotificationCallback* = DEFINE_GUID("47eb8e57-0846-4546-af76-6f42fcfc2649")
  MALLOC_THREADSAFE* = 0x1
  MALLOC_EXECUTABLE* = 0x2
  TT_DEBUGGERHELPER* = 0x1
  TT_GC* = 0x2
  TT_FINALIZER* = 0x4
  TT_THREADPOOL_TIMER* = 0x8
  TT_THREADPOOL_GATE* = 0x10
  TT_THREADPOOL_WORKER* = 0x20
  TT_THREADPOOL_IOCOMPLETION* = 0x40
  TT_ADUNLOAD* = 0x80
  TT_USER* = 0x100
  TT_THREADPOOL_WAIT* = 0x200
  TT_UNKNOWN* = 0x80000000'i32
  eSymbolReadingNever* = 0
  eSymbolReadingAlways* = 1
  eSymbolReadingFullTrustOnly* = 2
  DUMP_FLAVOR_Mini* = 0
  DUMP_FLAVOR_CriticalCLRState* = 1
  DUMP_FLAVOR_NonHeapCLRState* = 2
  DUMP_FLAVOR_Default* = DUMP_FLAVOR_Mini
  DUMP_ITEM_None* = 0
  bucketParamsCount* = 10
  bucketParamLength* = 255
  parameter1* = 0
  parameter2* = parameter1+1
  parameter3* = parameter2+1
  parameter4* = parameter3+1
  parameter5* = parameter4+1
  parameter6* = parameter5+1
  parameter7* = parameter6+1
  parameter8* = parameter7+1
  parameter9* = parameter8+1
  invalidBucketParamIndex* = parameter9+1
  OPR_ThreadAbort* = 0
  OPR_ThreadRudeAbortInNonCriticalRegion* = OPR_ThreadAbort+1
  OPR_ThreadRudeAbortInCriticalRegion* = OPR_ThreadRudeAbortInNonCriticalRegion+1
  OPR_AppDomainUnload* = OPR_ThreadRudeAbortInCriticalRegion+1
  OPR_AppDomainRudeUnload* = OPR_AppDomainUnload+1
  OPR_ProcessExit* = OPR_AppDomainRudeUnload+1
  OPR_FinalizerRun* = OPR_ProcessExit+1
  maxClrOperation* = OPR_FinalizerRun+1
  FAIL_NonCriticalResource* = 0
  FAIL_CriticalResource* = FAIL_NonCriticalResource+1
  FAIL_FatalRuntime* = FAIL_CriticalResource+1
  FAIL_OrphanedLock* = FAIL_FatalRuntime+1
  FAIL_StackOverflow* = FAIL_OrphanedLock+1
  FAIL_AccessViolation* = FAIL_StackOverflow+1
  FAIL_CodeContract* = FAIL_AccessViolation+1
  maxClrFailure* = FAIL_CodeContract+1
  eRuntimeDeterminedPolicy* = 0
  eHostDeterminedPolicy* = eRuntimeDeterminedPolicy+1
  eNoAction* = 0
  eThrowException* = eNoAction+1
  eAbortThread* = eThrowException+1
  eRudeAbortThread* = eAbortThread+1
  eUnloadAppDomain* = eRudeAbortThread+1
  eRudeUnloadAppDomain* = eUnloadAppDomain+1
  eExitProcess* = eRudeUnloadAppDomain+1
  eFastExitProcess* = eExitProcess+1
  eRudeExitProcess* = eFastExitProcess+1
  eDisableRuntime* = eRudeExitProcess+1
  maxPolicyAction* = eDisableRuntime+1
  Event_DomainUnload* = 0
  Event_ClrDisabled* = Event_DomainUnload+1
  Event_MDAFired* = Event_ClrDisabled+1
  Event_StackOverflow* = Event_MDAFired+1
  maxClrEvent* = Event_StackOverflow+1
  SO_Managed* = 0
  SO_ClrEngine* = SO_Managed+1
  SO_Other* = SO_ClrEngine+1
  CLR_ASSEMBLY_IDENTITY_FLAGS_DEFAULT* = 0
  HOST_BINDING_POLICY_MODIFY_DEFAULT* = 0
  HOST_BINDING_POLICY_MODIFY_CHAIN* = 1
  HOST_BINDING_POLICY_MODIFY_REMOVE* = 2
  HOST_BINDING_POLICY_MODIFY_MAX* = 3
  ePolicyLevelNone* = 0
  ePolicyLevelRetargetable* = 0x1
  ePolicyUnifiedToCLR* = 0x2
  ePolicyLevelApp* = 0x4
  ePolicyLevelPublisher* = 0x8
  ePolicyLevelHost* = 0x10
  ePolicyLevelAdmin* = 0x20
  ePolicyPortability* = 0x40
  HOST_APPLICATION_BINDING_POLICY* = 1
  IID_IHostControl* = DEFINE_GUID("02ca073c-7079-4860-880a-c2f7a449c991")
  IID_ICLRControl* = DEFINE_GUID("9065597e-d1a1-4fb2-b6ba-7e1fce230f61")
  eNoChecks* = 0
  eSynchronization* = 0x1
  eSharedState* = 0x2
  eExternalProcessMgmt* = 0x4
  eSelfAffectingProcessMgmt* = 0x8
  eExternalThreading* = 0x10
  eSelfAffectingThreading* = 0x20
  eSecurityInfrastructure* = 0x40
  eUI* = 0x80
  eMayLeakOnAbort* = 0x100
  eAll* = 0x1ff
  eInitializeNewDomainFlags_None* = 0
  eInitializeNewDomainFlags_NoSecurityChanges* = 0x2
  eCurrentContext* = 0
  eRestrictedContext* = 0x1
  CLSID_CLRStrongName* = DEFINE_GUID("b79b0acd-f5cd-409b-b5a5-a16244610b92")
  IID_ICLRMetaHost* = DEFINE_GUID("d332db9e-b9b3-4125-8207-a14884f53216")
  CLSID_CLRMetaHost* = DEFINE_GUID("9280188d-0e8e-4867-b30c-7fa83884e8de")
  IID_ICLRMetaHostPolicy* = DEFINE_GUID("e2190695-77b2-492e-8e14-c4b3a7fdd593")
  CLSID_CLRMetaHostPolicy* = DEFINE_GUID("2ebcd49a-1b47-4a61-b13a-4a03701e594b")
  IID_ICLRDebugging* = DEFINE_GUID("d28f3c5a-9634-4206-a509-477552eefb10")
  CLSID_CLRDebugging* = DEFINE_GUID("bacc578d-fbdd-48a4-969f-02d932b74634")
  IID_ICLRRuntimeInfo* = DEFINE_GUID("bd39d1d2-ba2f-486a-89b0-b4b0cb466891")
  IID_ICLRStrongName* = DEFINE_GUID("9fd93ccf-3280-4391-b3a9-96e1cde77c8d")
  IID_ICLRStrongName2* = DEFINE_GUID("c22ed5c5-4b59-4975-90eb-85ea55c0069b")
  IID_ICLRStrongName3* = DEFINE_GUID("22c7089b-bbd3-414a-b698-210f263f1fed")
  CLSID_CLRDebuggingLegacy* = DEFINE_GUID("df8395b5-a4ba-450b-a77c-a9a47762c520")
  CLSID_CLRProfiling* = DEFINE_GUID("bd097ed8-733e-43fe-8ed7-a95ff9a8448c")
  IID_ICLRProfiling* = DEFINE_GUID("b349abe3-b56f-4689-bfcd-76bf39d888ea")
  IID_ICLRDebuggingLibraryProvider* = DEFINE_GUID("3151c08d-4d09-4f9b-8838-2880bf18fe51")
  METAHOST_POLICY_HIGHCOMPAT* = 0
  METAHOST_POLICY_APPLY_UPGRADE_POLICY* = 0x8
  METAHOST_POLICY_EMULATE_EXE_LAUNCH* = 0x10
  METAHOST_POLICY_SHOW_ERROR_DIALOG* = 0x20
  METAHOST_POLICY_USE_PROCESS_IMAGE_PATH* = 0x40
  METAHOST_POLICY_ENSURE_SKU_SUPPORTED* = 0x80
  METAHOST_POLICY_IGNORE_ERROR_MODE* = 0x1000
  METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_UNSET* = 0
  METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_TRUE* = 0x1
  METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_FALSE* = 0x2
  METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_MASK* = 0x3
  CLR_DEBUGGING_MANAGED_EVENT_PENDING* = 1
  CLR_DEBUGGING_MANAGED_EVENT_DEBUGGER_LAUNCH* = 2
  IID_AppDomain* = DEFINE_GUID("05f696dc-2b29-3663-ad8b-c4389cf2a713")
  IID_ObjectHandle* = DEFINE_GUID("ea675b47-64e0-3b5f-9be7-f7dc2990730d")
  IID_IAppDomainSetup* = DEFINE_GUID("27fff232-a7a8-40dd-8d4a-734ad59fcd41")
  IID_IType* = DEFINE_GUID("bca8b44d-aad6-3a86-8ab7-03349f4f2da2")
  IID_IObject* = DEFINE_GUID("65074f7f-63c0-304e-af0a-d51741cb4a8d")
  BindingFlags_Default* = 0
  BindingFlags_IgnoreCase* = 1
  BindingFlags_DeclaredOnly* = 2
  BindingFlags_Instance* = 4
  BindingFlags_Static* = 8
  BindingFlags_Public* = 16
  BindingFlags_NonPublic* = 32
  BindingFlags_FlattenHierarchy* = 64
  BindingFlags_InvokeMethod* = 256
  BindingFlags_CreateInstance* = 512
  BindingFlags_GetField* = 1024
  BindingFlags_SetField* = 2048
  BindingFlags_GetProperty* = 4096
  BindingFlags_SetProperty* = 8192
  BindingFlags_PutDispProperty* = 16384
  BindingFlags_PutRefDispProperty* = 32768
  BindingFlags_ExactBinding* = 65536
  BindingFlags_SuppressChangeType* = 131072
  BindingFlags_OptionalParamBinding* = 262144
  BindingFlags_IgnoreReturn* = 16777216
  IID_IAssembly* = DEFINE_GUID("17156360-2f1a-384a-bc52-fde93c215c5b")
type
  FLockClrVersionCallback* = proc (): HRESULT {.stdcall.}
  FExecuteInAppDomainCallback* = proc (cookie: pointer): HRESULT {.stdcall.}
  PTLS_CALLBACK_FUNCTION* = proc (MIDL_itf_mscoree_0000_00040005: PVOID): VOID {.stdcall.}
  CLRCreateInstanceFnPtr* = proc (clsid: REFCLSID, riid: REFIID, ppInterface: ptr LPVOID): HRESULT {.stdcall.}
  CreateInterfaceFnPtr* = proc (clsid: REFCLSID, riid: REFIID, ppInterface: ptr LPVOID): HRESULT {.stdcall.}
  CallbackThreadSetFnPtr* = proc (P1: void): HRESULT {.stdcall.}
  CallbackThreadUnsetFnPtr* = proc (P1: void): HRESULT {.stdcall.}
  ICLRRuntimeInfo* {.pure.} = object
    lpVtbl*: ptr ICLRRuntimeInfoVtbl
  ICLRRuntimeInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetVersionString*: proc(self: ptr ICLRRuntimeInfo, pwzBuffer: LPWSTR, pcchBuffer: ptr DWORD): HRESULT {.stdcall.}
    GetRuntimeDirectory*: proc(self: ptr ICLRRuntimeInfo, pwzBuffer: LPWSTR, pcchBuffer: ptr DWORD): HRESULT {.stdcall.}
    IsLoaded*: proc(self: ptr ICLRRuntimeInfo, hndProcess: HANDLE, pbLoaded: ptr BOOL): HRESULT {.stdcall.}
    LoadErrorString*: proc(self: ptr ICLRRuntimeInfo, iResourceID: UINT, pwzBuffer: LPWSTR, pcchBuffer: ptr DWORD, iLocaleID: LONG): HRESULT {.stdcall.}
    LoadLibrary*: proc(self: ptr ICLRRuntimeInfo, pwzDllName: LPCWSTR, phndModule: ptr HMODULE): HRESULT {.stdcall.}
    GetProcAddress*: proc(self: ptr ICLRRuntimeInfo, pszProcName: LPCSTR, ppProc: ptr LPVOID): HRESULT {.stdcall.}
    GetInterface*: proc(self: ptr ICLRRuntimeInfo, rclsid: REFCLSID, riid: REFIID, ppUnk: ptr LPVOID): HRESULT {.stdcall.}
    IsLoadable*: proc(self: ptr ICLRRuntimeInfo, pbLoadable: ptr BOOL): HRESULT {.stdcall.}
    SetDefaultStartupFlags*: proc(self: ptr ICLRRuntimeInfo, dwStartupFlags: DWORD, pwzHostConfigFile: LPCWSTR): HRESULT {.stdcall.}
    GetDefaultStartupFlags*: proc(self: ptr ICLRRuntimeInfo, pdwStartupFlags: ptr DWORD, pwzHostConfigFile: LPWSTR, pcchHostConfigFile: ptr DWORD): HRESULT {.stdcall.}
    BindAsLegacyV2Runtime*: proc(self: ptr ICLRRuntimeInfo): HRESULT {.stdcall.}
    IsStarted*: proc(self: ptr ICLRRuntimeInfo, pbStarted: ptr BOOL, pdwStartupFlags: ptr DWORD): HRESULT {.stdcall.}
  RuntimeLoadedCallbackFnPtr* = proc (pRuntimeInfo: ptr ICLRRuntimeInfo, pfnCallbackThreadSet: CallbackThreadSetFnPtr, pfnCallbackThreadUnset: CallbackThreadUnsetFnPtr): void {.stdcall.}
  COR_GC_STATS* {.pure.} = object
    Flags*: ULONG
    ExplicitGCCount*: SIZE_T
    GenCollectionsTaken*: array[ 3 , SIZE_T]
    CommittedKBytes*: SIZE_T
    ReservedKBytes*: SIZE_T
    Gen0HeapSizeKBytes*: SIZE_T
    Gen1HeapSizeKBytes*: SIZE_T
    Gen2HeapSizeKBytes*: SIZE_T
    LargeObjectHeapSizeKBytes*: SIZE_T
    KBytesPromotedFromGen0*: SIZE_T
    KBytesPromotedFromGen1*: SIZE_T
  COR_GC_THREAD_STATS* {.pure.} = object
    PerThreadAllocation*: ULONGLONG
    Flags*: ULONG
  CustomDumpItem_UNION1* {.pure, union.} = object
    pReserved*: UINT_PTR
  CustomDumpItem* {.pure.} = object
    itemKind*: ECustomDumpItemKind
    union1*: CustomDumpItem_UNION1
  BucketParameters* {.pure.} = object
    fInited*: BOOL
    pszEventTypeName*: array[ 255 , WCHAR]
    pszParams*: array[ 10 , array[ 255 , WCHAR]]
  MDAInfo* {.pure.} = object
    lpMDACaption*: LPCWSTR
    lpMDAMessage*: LPCWSTR
    lpStackTrace*: LPCWSTR
  StackOverflowInfo* {.pure.} = object
    soType*: StackOverflowType
    pExceptionInfo*: ptr EXCEPTION_POINTERS
  AssemblyBindInfo* {.pure.} = object
    dwAppDomainId*: DWORD
    lpReferencedIdentity*: LPCWSTR
    lpPostPolicyIdentity*: LPCWSTR
    ePolicyLevel*: DWORD
  ModuleBindInfo* {.pure.} = object
    dwAppDomainId*: DWORD
    lpAssemblyIdentity*: LPCWSTR
    lpModuleName*: LPCWSTR
  CLR_DEBUGGING_VERSION* {.pure.} = object
    wStructVersion*: WORD
    wMajor*: WORD
    wMinor*: WORD
    wBuild*: WORD
    wRevision*: WORD
  StreamingContext* {.pure.} = object
  IGCHost* {.pure.} = object
    lpVtbl*: ptr IGCHostVtbl
  IGCHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetGCStartupLimits*: proc(self: ptr IGCHost, SegmentSize: DWORD, MaxGen0Size: DWORD): HRESULT {.stdcall.}
    Collect*: proc(self: ptr IGCHost, Generation: LONG): HRESULT {.stdcall.}
    GetStats*: proc(self: ptr IGCHost, pStats: ptr COR_GC_STATS): HRESULT {.stdcall.}
    GetThreadStats*: proc(self: ptr IGCHost, pFiberCookie: ptr DWORD, pStats: ptr COR_GC_THREAD_STATS): HRESULT {.stdcall.}
    SetVirtualMemLimit*: proc(self: ptr IGCHost, sztMaxVirtualMemMB: SIZE_T): HRESULT {.stdcall.}
  IGCHost2* {.pure.} = object
    lpVtbl*: ptr IGCHost2Vtbl
  IGCHost2Vtbl* {.pure, inheritable.} = object of IGCHostVtbl
    SetGCStartupLimitsEx*: proc(self: ptr IGCHost2, SegmentSize: SIZE_T, MaxGen0Size: SIZE_T): HRESULT {.stdcall.}
  IVEHandler* {.pure.} = object
    lpVtbl*: ptr IVEHandlerVtbl
  IVEHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    VEHandler*: proc(self: ptr IVEHandler, VECode: HRESULT, Context: VEContext, psa: ptr SAFEARRAY): HRESULT {.stdcall.}
    SetReporterFtn*: proc(self: ptr IVEHandler, lFnPtr: int64): HRESULT {.stdcall.}
  IValidator* {.pure.} = object
    lpVtbl*: ptr IValidatorVtbl
  IValidatorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Validate*: proc(self: ptr IValidator, veh: ptr IVEHandler, pAppDomain: ptr IUnknown, ulFlags: int32, ulMaxError: int32, token: int32, fileName: LPWSTR, pe: ptr BYTE, ulSize: int32): HRESULT {.stdcall.}
    FormatEventInfo*: proc(self: ptr IValidator, hVECode: HRESULT, Context: VEContext, msg: LPWSTR, ulMaxLength: int32, psa: ptr SAFEARRAY): HRESULT {.stdcall.}
  ICLRValidator* {.pure.} = object
    lpVtbl*: ptr ICLRValidatorVtbl
  ICLRValidatorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Validate*: proc(self: ptr ICLRValidator, veh: ptr IVEHandler, ulAppDomainId: int32, ulFlags: int32, ulMaxError: int32, token: int32, fileName: LPWSTR, pe: ptr BYTE, ulSize: int32): HRESULT {.stdcall.}
    FormatEventInfo*: proc(self: ptr ICLRValidator, hVECode: HRESULT, Context: VEContext, msg: LPWSTR, ulMaxLength: int32, psa: ptr SAFEARRAY): HRESULT {.stdcall.}
  IObjectHandle* {.pure.} = object
    lpVtbl*: ptr IObjectHandleVtbl
  IObjectHandleVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Unwrap*: proc(self: ptr IObjectHandle, ppv: ptr VARIANT): HRESULT {.stdcall.}
  IAppDomainBinding* {.pure.} = object
    lpVtbl*: ptr IAppDomainBindingVtbl
  IAppDomainBindingVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnAppDomain*: proc(self: ptr IAppDomainBinding, pAppdomain: ptr IUnknown): HRESULT {.stdcall.}
  IGCThreadControl* {.pure.} = object
    lpVtbl*: ptr IGCThreadControlVtbl
  IGCThreadControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ThreadIsBlockingForSuspension*: proc(self: ptr IGCThreadControl): HRESULT {.stdcall.}
    SuspensionStarting*: proc(self: ptr IGCThreadControl): HRESULT {.stdcall.}
    SuspensionEnding*: proc(self: ptr IGCThreadControl, Generation: DWORD): HRESULT {.stdcall.}
  IGCHostControl* {.pure.} = object
    lpVtbl*: ptr IGCHostControlVtbl
  IGCHostControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RequestVirtualMemLimit*: proc(self: ptr IGCHostControl, sztMaxVirtualMemMB: SIZE_T, psztNewMaxVirtualMemMB: ptr SIZE_T): HRESULT {.stdcall.}
  ICorThreadpool* {.pure.} = object
    lpVtbl*: ptr ICorThreadpoolVtbl
  ICorThreadpoolVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CorRegisterWaitForSingleObject*: proc(self: ptr ICorThreadpool, phNewWaitObject: ptr HANDLE, hWaitObject: HANDLE, Callback: WAITORTIMERCALLBACK, Context: PVOID, timeout: ULONG, executeOnlyOnce: BOOL, ret: ptr BOOL): HRESULT {.stdcall.}
    CorUnregisterWait*: proc(self: ptr ICorThreadpool, hWaitObject: HANDLE, CompletionEvent: HANDLE, ret: ptr BOOL): HRESULT {.stdcall.}
    CorQueueUserWorkItem*: proc(self: ptr ICorThreadpool, Function: LPTHREAD_START_ROUTINE, Context: PVOID, executeOnlyOnce: BOOL, ret: ptr BOOL): HRESULT {.stdcall.}
    CorCreateTimer*: proc(self: ptr ICorThreadpool, phNewTimer: ptr HANDLE, Callback: WAITORTIMERCALLBACK, Parameter: PVOID, DueTime: DWORD, Period: DWORD, ret: ptr BOOL): HRESULT {.stdcall.}
    CorChangeTimer*: proc(self: ptr ICorThreadpool, Timer: HANDLE, DueTime: ULONG, Period: ULONG, ret: ptr BOOL): HRESULT {.stdcall.}
    CorDeleteTimer*: proc(self: ptr ICorThreadpool, Timer: HANDLE, CompletionEvent: HANDLE, ret: ptr BOOL): HRESULT {.stdcall.}
    CorBindIoCompletionCallback*: proc(self: ptr ICorThreadpool, fileHandle: HANDLE, callback: LPOVERLAPPED_COMPLETION_ROUTINE): HRESULT {.stdcall.}
    CorCallOrQueueUserWorkItem*: proc(self: ptr ICorThreadpool, Function: LPTHREAD_START_ROUTINE, Context: PVOID, ret: ptr BOOL): HRESULT {.stdcall.}
    CorSetMaxThreads*: proc(self: ptr ICorThreadpool, MaxWorkerThreads: DWORD, MaxIOCompletionThreads: DWORD): HRESULT {.stdcall.}
    CorGetMaxThreads*: proc(self: ptr ICorThreadpool, MaxWorkerThreads: ptr DWORD, MaxIOCompletionThreads: ptr DWORD): HRESULT {.stdcall.}
    CorGetAvailableThreads*: proc(self: ptr ICorThreadpool, AvailableWorkerThreads: ptr DWORD, AvailableIOCompletionThreads: ptr DWORD): HRESULT {.stdcall.}
  IDebuggerThreadControl* {.pure.} = object
    lpVtbl*: ptr IDebuggerThreadControlVtbl
  IDebuggerThreadControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ThreadIsBlockingForDebugger*: proc(self: ptr IDebuggerThreadControl): HRESULT {.stdcall.}
    ReleaseAllRuntimeThreads*: proc(self: ptr IDebuggerThreadControl): HRESULT {.stdcall.}
    StartBlockingForDebugger*: proc(self: ptr IDebuggerThreadControl, dwUnused: DWORD): HRESULT {.stdcall.}
  IDebuggerInfo* {.pure.} = object
    lpVtbl*: ptr IDebuggerInfoVtbl
  IDebuggerInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IsDebuggerAttached*: proc(self: ptr IDebuggerInfo, pbAttached: ptr BOOL): HRESULT {.stdcall.}
  ICorConfiguration* {.pure.} = object
    lpVtbl*: ptr ICorConfigurationVtbl
  ICorConfigurationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetGCThreadControl*: proc(self: ptr ICorConfiguration, pGCThreadControl: ptr IGCThreadControl): HRESULT {.stdcall.}
    SetGCHostControl*: proc(self: ptr ICorConfiguration, pGCHostControl: ptr IGCHostControl): HRESULT {.stdcall.}
    SetDebuggerThreadControl*: proc(self: ptr ICorConfiguration, pDebuggerThreadControl: ptr IDebuggerThreadControl): HRESULT {.stdcall.}
    AddDebuggerSpecialThread*: proc(self: ptr ICorConfiguration, dwSpecialThreadId: DWORD): HRESULT {.stdcall.}
  ICorRuntimeHost* {.pure.} = object
    lpVtbl*: ptr ICorRuntimeHostVtbl
  ICorRuntimeHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateLogicalThreadState*: proc(self: ptr ICorRuntimeHost): HRESULT {.stdcall.}
    DeleteLogicalThreadState*: proc(self: ptr ICorRuntimeHost): HRESULT {.stdcall.}
    SwitchInLogicalThreadState*: proc(self: ptr ICorRuntimeHost, pFiberCookie: ptr DWORD): HRESULT {.stdcall.}
    SwitchOutLogicalThreadState*: proc(self: ptr ICorRuntimeHost, pFiberCookie: ptr ptr DWORD): HRESULT {.stdcall.}
    LocksHeldByLogicalThread*: proc(self: ptr ICorRuntimeHost, pCount: ptr DWORD): HRESULT {.stdcall.}
    MapFile*: proc(self: ptr ICorRuntimeHost, hFile: HANDLE, hMapAddress: ptr HMODULE): HRESULT {.stdcall.}
    GetConfiguration*: proc(self: ptr ICorRuntimeHost, pConfiguration: ptr ptr ICorConfiguration): HRESULT {.stdcall.}
    Start*: proc(self: ptr ICorRuntimeHost): HRESULT {.stdcall.}
    Stop*: proc(self: ptr ICorRuntimeHost): HRESULT {.stdcall.}
    CreateDomain*: proc(self: ptr ICorRuntimeHost, pwzFriendlyName: LPCWSTR, pIdentityArray: ptr IUnknown, pAppDomain: ptr ptr IUnknown): HRESULT {.stdcall.}
    GetDefaultDomain*: proc(self: ptr ICorRuntimeHost, pAppDomain: ptr ptr IUnknown): HRESULT {.stdcall.}
    EnumDomains*: proc(self: ptr ICorRuntimeHost, hEnum: ptr HDOMAINENUM): HRESULT {.stdcall.}
    NextDomain*: proc(self: ptr ICorRuntimeHost, hEnum: HDOMAINENUM, pAppDomain: ptr ptr IUnknown): HRESULT {.stdcall.}
    CloseEnum*: proc(self: ptr ICorRuntimeHost, hEnum: HDOMAINENUM): HRESULT {.stdcall.}
    CreateDomainEx*: proc(self: ptr ICorRuntimeHost, pwzFriendlyName: LPCWSTR, pSetup: ptr IUnknown, pEvidence: ptr IUnknown, pAppDomain: ptr ptr IUnknown): HRESULT {.stdcall.}
    CreateDomainSetup*: proc(self: ptr ICorRuntimeHost, pAppDomainSetup: ptr ptr IUnknown): HRESULT {.stdcall.}
    CreateEvidence*: proc(self: ptr ICorRuntimeHost, pEvidence: ptr ptr IUnknown): HRESULT {.stdcall.}
    UnloadDomain*: proc(self: ptr ICorRuntimeHost, pAppDomain: ptr IUnknown): HRESULT {.stdcall.}
    CurrentDomain*: proc(self: ptr ICorRuntimeHost, pAppDomain: ptr ptr IUnknown): HRESULT {.stdcall.}
  ICLRMemoryNotificationCallback* {.pure.} = object
    lpVtbl*: ptr ICLRMemoryNotificationCallbackVtbl
  ICLRMemoryNotificationCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnMemoryNotification*: proc(self: ptr ICLRMemoryNotificationCallback, eMemoryAvailable: EMemoryAvailable): HRESULT {.stdcall.}
  IHostMalloc* {.pure.} = object
    lpVtbl*: ptr IHostMallocVtbl
  IHostMallocVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Alloc*: proc(self: ptr IHostMalloc, cbSize: SIZE_T, eCriticalLevel: EMemoryCriticalLevel, ppMem: ptr pointer): HRESULT {.stdcall.}
    DebugAlloc*: proc(self: ptr IHostMalloc, cbSize: SIZE_T, eCriticalLevel: EMemoryCriticalLevel, pszFileName: ptr char, iLineNo: int32, ppMem: ptr pointer): HRESULT {.stdcall.}
    Free*: proc(self: ptr IHostMalloc, pMem: pointer): HRESULT {.stdcall.}
  IHostMemoryManager* {.pure.} = object
    lpVtbl*: ptr IHostMemoryManagerVtbl
  IHostMemoryManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateMalloc*: proc(self: ptr IHostMemoryManager, dwMallocType: DWORD, ppMalloc: ptr ptr IHostMalloc): HRESULT {.stdcall.}
    VirtualAlloc*: proc(self: ptr IHostMemoryManager, pAddress: pointer, dwSize: SIZE_T, flAllocationType: DWORD, flProtect: DWORD, eCriticalLevel: EMemoryCriticalLevel, ppMem: ptr pointer): HRESULT {.stdcall.}
    VirtualFree*: proc(self: ptr IHostMemoryManager, lpAddress: LPVOID, dwSize: SIZE_T, dwFreeType: DWORD): HRESULT {.stdcall.}
    VirtualQuery*: proc(self: ptr IHostMemoryManager, lpAddress: pointer, lpBuffer: pointer, dwLength: SIZE_T, pResult: ptr SIZE_T): HRESULT {.stdcall.}
    VirtualProtect*: proc(self: ptr IHostMemoryManager, lpAddress: pointer, dwSize: SIZE_T, flNewProtect: DWORD, pflOldProtect: ptr DWORD): HRESULT {.stdcall.}
    GetMemoryLoad*: proc(self: ptr IHostMemoryManager, pMemoryLoad: ptr DWORD, pAvailableBytes: ptr SIZE_T): HRESULT {.stdcall.}
    RegisterMemoryNotificationCallback*: proc(self: ptr IHostMemoryManager, pCallback: ptr ICLRMemoryNotificationCallback): HRESULT {.stdcall.}
    NeedsVirtualAddressSpace*: proc(self: ptr IHostMemoryManager, startAddress: LPVOID, size: SIZE_T): HRESULT {.stdcall.}
    AcquiredVirtualAddressSpace*: proc(self: ptr IHostMemoryManager, startAddress: LPVOID, size: SIZE_T): HRESULT {.stdcall.}
    ReleasedVirtualAddressSpace*: proc(self: ptr IHostMemoryManager, startAddress: LPVOID): HRESULT {.stdcall.}
  ICLRTask* {.pure.} = object
    lpVtbl*: ptr ICLRTaskVtbl
  ICLRTaskVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SwitchIn*: proc(self: ptr ICLRTask, threadHandle: HANDLE): HRESULT {.stdcall.}
    SwitchOut*: proc(self: ptr ICLRTask): HRESULT {.stdcall.}
    GetMemStats*: proc(self: ptr ICLRTask, memUsage: ptr COR_GC_THREAD_STATS): HRESULT {.stdcall.}
    Reset*: proc(self: ptr ICLRTask, fFull: BOOL): HRESULT {.stdcall.}
    ExitTask*: proc(self: ptr ICLRTask): HRESULT {.stdcall.}
    Abort*: proc(self: ptr ICLRTask): HRESULT {.stdcall.}
    RudeAbort*: proc(self: ptr ICLRTask): HRESULT {.stdcall.}
    NeedsPriorityScheduling*: proc(self: ptr ICLRTask, pbNeedsPriorityScheduling: ptr BOOL): HRESULT {.stdcall.}
    YieldTask*: proc(self: ptr ICLRTask): HRESULT {.stdcall.}
    LocksHeld*: proc(self: ptr ICLRTask, pLockCount: ptr SIZE_T): HRESULT {.stdcall.}
    SetTaskIdentifier*: proc(self: ptr ICLRTask, asked: TASKID): HRESULT {.stdcall.}
  ICLRTask2* {.pure.} = object
    lpVtbl*: ptr ICLRTask2Vtbl
  ICLRTask2Vtbl* {.pure, inheritable.} = object of ICLRTaskVtbl
    BeginPreventAsyncAbort*: proc(self: ptr ICLRTask2): HRESULT {.stdcall.}
    EndPreventAsyncAbort*: proc(self: ptr ICLRTask2): HRESULT {.stdcall.}
  IHostTask* {.pure.} = object
    lpVtbl*: ptr IHostTaskVtbl
  IHostTaskVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Start*: proc(self: ptr IHostTask): HRESULT {.stdcall.}
    Alert*: proc(self: ptr IHostTask): HRESULT {.stdcall.}
    Join*: proc(self: ptr IHostTask, dwMilliseconds: DWORD, option: DWORD): HRESULT {.stdcall.}
    SetPriority*: proc(self: ptr IHostTask, newPriority: int32): HRESULT {.stdcall.}
    GetPriority*: proc(self: ptr IHostTask, pPriority: ptr int32): HRESULT {.stdcall.}
    SetCLRTask*: proc(self: ptr IHostTask, pCLRTask: ptr ICLRTask): HRESULT {.stdcall.}
  ICLRTaskManager* {.pure.} = object
    lpVtbl*: ptr ICLRTaskManagerVtbl
  ICLRTaskManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateTask*: proc(self: ptr ICLRTaskManager, pTask: ptr ptr ICLRTask): HRESULT {.stdcall.}
    GetCurrentTask*: proc(self: ptr ICLRTaskManager, pTask: ptr ptr ICLRTask): HRESULT {.stdcall.}
    SetUILocale*: proc(self: ptr ICLRTaskManager, lcid: LCID): HRESULT {.stdcall.}
    SetLocale*: proc(self: ptr ICLRTaskManager, lcid: LCID): HRESULT {.stdcall.}
    GetCurrentTaskType*: proc(self: ptr ICLRTaskManager, pTaskType: ptr ETaskType): HRESULT {.stdcall.}
  IHostTaskManager* {.pure.} = object
    lpVtbl*: ptr IHostTaskManagerVtbl
  IHostTaskManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentTask*: proc(self: ptr IHostTaskManager, pTask: ptr ptr IHostTask): HRESULT {.stdcall.}
    CreateTask*: proc(self: ptr IHostTaskManager, dwStackSize: DWORD, pStartAddress: LPTHREAD_START_ROUTINE, pParameter: PVOID, ppTask: ptr ptr IHostTask): HRESULT {.stdcall.}
    Sleep*: proc(self: ptr IHostTaskManager, dwMilliseconds: DWORD, option: DWORD): HRESULT {.stdcall.}
    SwitchToTask*: proc(self: ptr IHostTaskManager, option: DWORD): HRESULT {.stdcall.}
    SetUILocale*: proc(self: ptr IHostTaskManager, lcid: LCID): HRESULT {.stdcall.}
    SetLocale*: proc(self: ptr IHostTaskManager, lcid: LCID): HRESULT {.stdcall.}
    CallNeedsHostHook*: proc(self: ptr IHostTaskManager, target: SIZE_T, pbCallNeedsHostHook: ptr BOOL): HRESULT {.stdcall.}
    LeaveRuntime*: proc(self: ptr IHostTaskManager, target: SIZE_T): HRESULT {.stdcall.}
    EnterRuntime*: proc(self: ptr IHostTaskManager): HRESULT {.stdcall.}
    ReverseLeaveRuntime*: proc(self: ptr IHostTaskManager): HRESULT {.stdcall.}
    ReverseEnterRuntime*: proc(self: ptr IHostTaskManager): HRESULT {.stdcall.}
    BeginDelayAbort*: proc(self: ptr IHostTaskManager): HRESULT {.stdcall.}
    EndDelayAbort*: proc(self: ptr IHostTaskManager): HRESULT {.stdcall.}
    BeginThreadAffinity*: proc(self: ptr IHostTaskManager): HRESULT {.stdcall.}
    EndThreadAffinity*: proc(self: ptr IHostTaskManager): HRESULT {.stdcall.}
    SetStackGuarantee*: proc(self: ptr IHostTaskManager, guarantee: ULONG): HRESULT {.stdcall.}
    GetStackGuarantee*: proc(self: ptr IHostTaskManager, pGuarantee: ptr ULONG): HRESULT {.stdcall.}
    SetCLRTaskManager*: proc(self: ptr IHostTaskManager, ppManager: ptr ICLRTaskManager): HRESULT {.stdcall.}
  IHostThreadpoolManager* {.pure.} = object
    lpVtbl*: ptr IHostThreadpoolManagerVtbl
  IHostThreadpoolManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueueUserWorkItem*: proc(self: ptr IHostThreadpoolManager, Function: LPTHREAD_START_ROUTINE, Context: PVOID, Flags: ULONG): HRESULT {.stdcall.}
    SetMaxThreads*: proc(self: ptr IHostThreadpoolManager, dwMaxWorkerThreads: DWORD): HRESULT {.stdcall.}
    GetMaxThreads*: proc(self: ptr IHostThreadpoolManager, pdwMaxWorkerThreads: ptr DWORD): HRESULT {.stdcall.}
    GetAvailableThreads*: proc(self: ptr IHostThreadpoolManager, pdwAvailableWorkerThreads: ptr DWORD): HRESULT {.stdcall.}
    SetMinThreads*: proc(self: ptr IHostThreadpoolManager, dwMinIOCompletionThreads: DWORD): HRESULT {.stdcall.}
    GetMinThreads*: proc(self: ptr IHostThreadpoolManager, pdwMinIOCompletionThreads: ptr DWORD): HRESULT {.stdcall.}
  ICLRIoCompletionManager* {.pure.} = object
    lpVtbl*: ptr ICLRIoCompletionManagerVtbl
  ICLRIoCompletionManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnComplete*: proc(self: ptr ICLRIoCompletionManager, dwErrorCode: DWORD, NumberOfBytesTransferred: DWORD, pvOverlapped: pointer): HRESULT {.stdcall.}
  IHostIoCompletionManager* {.pure.} = object
    lpVtbl*: ptr IHostIoCompletionManagerVtbl
  IHostIoCompletionManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateIoCompletionPort*: proc(self: ptr IHostIoCompletionManager, phPort: ptr HANDLE): HRESULT {.stdcall.}
    CloseIoCompletionPort*: proc(self: ptr IHostIoCompletionManager, hPort: HANDLE): HRESULT {.stdcall.}
    SetMaxThreads*: proc(self: ptr IHostIoCompletionManager, dwMaxIOCompletionThreads: DWORD): HRESULT {.stdcall.}
    GetMaxThreads*: proc(self: ptr IHostIoCompletionManager, pdwMaxIOCompletionThreads: ptr DWORD): HRESULT {.stdcall.}
    GetAvailableThreads*: proc(self: ptr IHostIoCompletionManager, pdwAvailableIOCompletionThreads: ptr DWORD): HRESULT {.stdcall.}
    GetHostOverlappedSize*: proc(self: ptr IHostIoCompletionManager, pcbSize: ptr DWORD): HRESULT {.stdcall.}
    SetCLRIoCompletionManager*: proc(self: ptr IHostIoCompletionManager, pManager: ptr ICLRIoCompletionManager): HRESULT {.stdcall.}
    InitializeHostOverlapped*: proc(self: ptr IHostIoCompletionManager, pvOverlapped: pointer): HRESULT {.stdcall.}
    Bind*: proc(self: ptr IHostIoCompletionManager, hPort: HANDLE, hHandle: HANDLE): HRESULT {.stdcall.}
    SetMinThreads*: proc(self: ptr IHostIoCompletionManager, dwMinIOCompletionThreads: DWORD): HRESULT {.stdcall.}
    GetMinThreads*: proc(self: ptr IHostIoCompletionManager, pdwMinIOCompletionThreads: ptr DWORD): HRESULT {.stdcall.}
  ICLRDebugManager* {.pure.} = object
    lpVtbl*: ptr ICLRDebugManagerVtbl
  ICLRDebugManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    BeginConnection*: proc(self: ptr ICLRDebugManager, dwConnectionId: CONNID, szConnectionName: ptr uint16): HRESULT {.stdcall.}
    SetConnectionTasks*: proc(self: ptr ICLRDebugManager, id: CONNID, dwCount: DWORD, ppCLRTask: ptr ptr ICLRTask): HRESULT {.stdcall.}
    EndConnection*: proc(self: ptr ICLRDebugManager, dwConnectionId: CONNID): HRESULT {.stdcall.}
    SetDacl*: proc(self: ptr ICLRDebugManager, pacl: PACL): HRESULT {.stdcall.}
    GetDacl*: proc(self: ptr ICLRDebugManager, pacl: ptr PACL): HRESULT {.stdcall.}
    IsDebuggerAttached*: proc(self: ptr ICLRDebugManager, pbAttached: ptr BOOL): HRESULT {.stdcall.}
    SetSymbolReadingPolicy*: proc(self: ptr ICLRDebugManager, policy: ESymbolReadingPolicy): HRESULT {.stdcall.}
  ICLRErrorReportingManager* {.pure.} = object
    lpVtbl*: ptr ICLRErrorReportingManagerVtbl
  ICLRErrorReportingManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetBucketParametersForCurrentException*: proc(self: ptr ICLRErrorReportingManager, pParams: ptr BucketParameters): HRESULT {.stdcall.}
    BeginCustomDump*: proc(self: ptr ICLRErrorReportingManager, dwFlavor: ECustomDumpFlavor, dwNumItems: DWORD, items: ptr CustomDumpItem, dwReserved: DWORD): HRESULT {.stdcall.}
    EndCustomDump*: proc(self: ptr ICLRErrorReportingManager): HRESULT {.stdcall.}
  IHostCrst* {.pure.} = object
    lpVtbl*: ptr IHostCrstVtbl
  IHostCrstVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Enter*: proc(self: ptr IHostCrst, option: DWORD): HRESULT {.stdcall.}
    Leave*: proc(self: ptr IHostCrst): HRESULT {.stdcall.}
    TryEnter*: proc(self: ptr IHostCrst, option: DWORD, pbSucceeded: ptr BOOL): HRESULT {.stdcall.}
    SetSpinCount*: proc(self: ptr IHostCrst, dwSpinCount: DWORD): HRESULT {.stdcall.}
  IHostAutoEvent* {.pure.} = object
    lpVtbl*: ptr IHostAutoEventVtbl
  IHostAutoEventVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Wait*: proc(self: ptr IHostAutoEvent, dwMilliseconds: DWORD, option: DWORD): HRESULT {.stdcall.}
    Set*: proc(self: ptr IHostAutoEvent): HRESULT {.stdcall.}
  IHostManualEvent* {.pure.} = object
    lpVtbl*: ptr IHostManualEventVtbl
  IHostManualEventVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Wait*: proc(self: ptr IHostManualEvent, dwMilliseconds: DWORD, option: DWORD): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IHostManualEvent): HRESULT {.stdcall.}
    Set*: proc(self: ptr IHostManualEvent): HRESULT {.stdcall.}
  IHostSemaphore* {.pure.} = object
    lpVtbl*: ptr IHostSemaphoreVtbl
  IHostSemaphoreVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Wait*: proc(self: ptr IHostSemaphore, dwMilliseconds: DWORD, option: DWORD): HRESULT {.stdcall.}
    ReleaseSemaphore*: proc(self: ptr IHostSemaphore, lReleaseCount: LONG, lpPreviousCount: ptr LONG): HRESULT {.stdcall.}
  ICLRSyncManager* {.pure.} = object
    lpVtbl*: ptr ICLRSyncManagerVtbl
  ICLRSyncManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetMonitorOwner*: proc(self: ptr ICLRSyncManager, Cookie: SIZE_T, ppOwnerHostTask: ptr ptr IHostTask): HRESULT {.stdcall.}
    CreateRWLockOwnerIterator*: proc(self: ptr ICLRSyncManager, Cookie: SIZE_T, pIterator: ptr SIZE_T): HRESULT {.stdcall.}
    GetRWLockOwnerNext*: proc(self: ptr ICLRSyncManager, Iterator: SIZE_T, ppOwnerHostTask: ptr ptr IHostTask): HRESULT {.stdcall.}
    DeleteRWLockOwnerIterator*: proc(self: ptr ICLRSyncManager, Iterator: SIZE_T): HRESULT {.stdcall.}
  IHostSyncManager* {.pure.} = object
    lpVtbl*: ptr IHostSyncManagerVtbl
  IHostSyncManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetCLRSyncManager*: proc(self: ptr IHostSyncManager, pManager: ptr ICLRSyncManager): HRESULT {.stdcall.}
    CreateCrst*: proc(self: ptr IHostSyncManager, ppCrst: ptr ptr IHostCrst): HRESULT {.stdcall.}
    CreateCrstWithSpinCount*: proc(self: ptr IHostSyncManager, dwSpinCount: DWORD, ppCrst: ptr ptr IHostCrst): HRESULT {.stdcall.}
    CreateAutoEvent*: proc(self: ptr IHostSyncManager, ppEvent: ptr ptr IHostAutoEvent): HRESULT {.stdcall.}
    CreateManualEvent*: proc(self: ptr IHostSyncManager, bInitialState: BOOL, ppEvent: ptr ptr IHostManualEvent): HRESULT {.stdcall.}
    CreateMonitorEvent*: proc(self: ptr IHostSyncManager, Cookie: SIZE_T, ppEvent: ptr ptr IHostAutoEvent): HRESULT {.stdcall.}
    CreateRWLockWriterEvent*: proc(self: ptr IHostSyncManager, Cookie: SIZE_T, ppEvent: ptr ptr IHostAutoEvent): HRESULT {.stdcall.}
    CreateRWLockReaderEvent*: proc(self: ptr IHostSyncManager, bInitialState: BOOL, Cookie: SIZE_T, ppEvent: ptr ptr IHostManualEvent): HRESULT {.stdcall.}
    CreateSemaphore*: proc(self: ptr IHostSyncManager, dwInitial: DWORD, dwMax: DWORD, ppSemaphore: ptr ptr IHostSemaphore): HRESULT {.stdcall.}
  ICLRPolicyManager* {.pure.} = object
    lpVtbl*: ptr ICLRPolicyManagerVtbl
  ICLRPolicyManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetDefaultAction*: proc(self: ptr ICLRPolicyManager, operation: EClrOperation, action: EPolicyAction): HRESULT {.stdcall.}
    SetTimeout*: proc(self: ptr ICLRPolicyManager, operation: EClrOperation, dwMilliseconds: DWORD): HRESULT {.stdcall.}
    SetActionOnTimeout*: proc(self: ptr ICLRPolicyManager, operation: EClrOperation, action: EPolicyAction): HRESULT {.stdcall.}
    SetTimeoutAndAction*: proc(self: ptr ICLRPolicyManager, operation: EClrOperation, dwMilliseconds: DWORD, action: EPolicyAction): HRESULT {.stdcall.}
    SetActionOnFailure*: proc(self: ptr ICLRPolicyManager, failure: EClrFailure, action: EPolicyAction): HRESULT {.stdcall.}
    SetUnhandledExceptionPolicy*: proc(self: ptr ICLRPolicyManager, policy: EClrUnhandledException): HRESULT {.stdcall.}
  IHostPolicyManager* {.pure.} = object
    lpVtbl*: ptr IHostPolicyManagerVtbl
  IHostPolicyManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnDefaultAction*: proc(self: ptr IHostPolicyManager, operation: EClrOperation, action: EPolicyAction): HRESULT {.stdcall.}
    OnTimeout*: proc(self: ptr IHostPolicyManager, operation: EClrOperation, action: EPolicyAction): HRESULT {.stdcall.}
    OnFailure*: proc(self: ptr IHostPolicyManager, failure: EClrFailure, action: EPolicyAction): HRESULT {.stdcall.}
  IActionOnCLREvent* {.pure.} = object
    lpVtbl*: ptr IActionOnCLREventVtbl
  IActionOnCLREventVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OnEvent*: proc(self: ptr IActionOnCLREvent, event: EClrEvent, data: PVOID): HRESULT {.stdcall.}
  ICLROnEventManager* {.pure.} = object
    lpVtbl*: ptr ICLROnEventManagerVtbl
  ICLROnEventManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RegisterActionOnEvent*: proc(self: ptr ICLROnEventManager, event: EClrEvent, pAction: ptr IActionOnCLREvent): HRESULT {.stdcall.}
    UnregisterActionOnEvent*: proc(self: ptr ICLROnEventManager, event: EClrEvent, pAction: ptr IActionOnCLREvent): HRESULT {.stdcall.}
  IHostGCManager* {.pure.} = object
    lpVtbl*: ptr IHostGCManagerVtbl
  IHostGCManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ThreadIsBlockingForSuspension*: proc(self: ptr IHostGCManager): HRESULT {.stdcall.}
    SuspensionStarting*: proc(self: ptr IHostGCManager): HRESULT {.stdcall.}
    SuspensionEnding*: proc(self: ptr IHostGCManager, Generation: DWORD): HRESULT {.stdcall.}
  ICLRAssemblyReferenceList* {.pure.} = object
    lpVtbl*: ptr ICLRAssemblyReferenceListVtbl
  ICLRAssemblyReferenceListVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    IsStringAssemblyReferenceInList*: proc(self: ptr ICLRAssemblyReferenceList, pwzAssemblyName: LPCWSTR): HRESULT {.stdcall.}
    IsAssemblyReferenceInList*: proc(self: ptr ICLRAssemblyReferenceList, pName: ptr IUnknown): HRESULT {.stdcall.}
  ICLRReferenceAssemblyEnum* {.pure.} = object
    lpVtbl*: ptr ICLRReferenceAssemblyEnumVtbl
  ICLRReferenceAssemblyEnumVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Get*: proc(self: ptr ICLRReferenceAssemblyEnum, dwIndex: DWORD, pwzBuffer: LPWSTR, pcchBufferSize: ptr DWORD): HRESULT {.stdcall.}
  ICLRProbingAssemblyEnum* {.pure.} = object
    lpVtbl*: ptr ICLRProbingAssemblyEnumVtbl
  ICLRProbingAssemblyEnumVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Get*: proc(self: ptr ICLRProbingAssemblyEnum, dwIndex: DWORD, pwzBuffer: LPWSTR, pcchBufferSize: ptr DWORD): HRESULT {.stdcall.}
  ICLRAssemblyIdentityManager* {.pure.} = object
    lpVtbl*: ptr ICLRAssemblyIdentityManagerVtbl
  ICLRAssemblyIdentityManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCLRAssemblyReferenceList*: proc(self: ptr ICLRAssemblyIdentityManager, ppwzAssemblyReferences: ptr LPCWSTR, dwNumOfReferences: DWORD, ppReferenceList: ptr ptr ICLRAssemblyReferenceList): HRESULT {.stdcall.}
    GetBindingIdentityFromFile*: proc(self: ptr ICLRAssemblyIdentityManager, pwzFilePath: LPCWSTR, dwFlags: DWORD, pwzBuffer: LPWSTR, pcchBufferSize: ptr DWORD): HRESULT {.stdcall.}
    GetBindingIdentityFromStream*: proc(self: ptr ICLRAssemblyIdentityManager, pStream: ptr IStream, dwFlags: DWORD, pwzBuffer: LPWSTR, pcchBufferSize: ptr DWORD): HRESULT {.stdcall.}
    GetReferencedAssembliesFromFile*: proc(self: ptr ICLRAssemblyIdentityManager, pwzFilePath: LPCWSTR, dwFlags: DWORD, pExcludeAssembliesList: ptr ICLRAssemblyReferenceList, ppReferenceEnum: ptr ptr ICLRReferenceAssemblyEnum): HRESULT {.stdcall.}
    GetReferencedAssembliesFromStream*: proc(self: ptr ICLRAssemblyIdentityManager, pStream: ptr IStream, dwFlags: DWORD, pExcludeAssembliesList: ptr ICLRAssemblyReferenceList, ppReferenceEnum: ptr ptr ICLRReferenceAssemblyEnum): HRESULT {.stdcall.}
    GetProbingAssembliesFromReference*: proc(self: ptr ICLRAssemblyIdentityManager, dwMachineType: DWORD, dwFlags: DWORD, pwzReferenceIdentity: LPCWSTR, ppProbingAssemblyEnum: ptr ptr ICLRProbingAssemblyEnum): HRESULT {.stdcall.}
    IsStronglyNamed*: proc(self: ptr ICLRAssemblyIdentityManager, pwzAssemblyIdentity: LPCWSTR, pbIsStronglyNamed: ptr BOOL): HRESULT {.stdcall.}
  ICLRHostBindingPolicyManager* {.pure.} = object
    lpVtbl*: ptr ICLRHostBindingPolicyManagerVtbl
  ICLRHostBindingPolicyManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ModifyApplicationPolicy*: proc(self: ptr ICLRHostBindingPolicyManager, pwzSourceAssemblyIdentity: LPCWSTR, pwzTargetAssemblyIdentity: LPCWSTR, pbApplicationPolicy: ptr BYTE, cbAppPolicySize: DWORD, dwPolicyModifyFlags: DWORD, pbNewApplicationPolicy: ptr BYTE, pcbNewAppPolicySize: ptr DWORD): HRESULT {.stdcall.}
    EvaluatePolicy*: proc(self: ptr ICLRHostBindingPolicyManager, pwzReferenceIdentity: LPCWSTR, pbApplicationPolicy: ptr BYTE, cbAppPolicySize: DWORD, pwzPostPolicyReferenceIdentity: LPWSTR, pcchPostPolicyReferenceIdentity: ptr DWORD, pdwPoliciesApplied: ptr DWORD): HRESULT {.stdcall.}
  ICLRGCManager* {.pure.} = object
    lpVtbl*: ptr ICLRGCManagerVtbl
  ICLRGCManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Collect*: proc(self: ptr ICLRGCManager, Generation: LONG): HRESULT {.stdcall.}
    GetStats*: proc(self: ptr ICLRGCManager, pStats: ptr COR_GC_STATS): HRESULT {.stdcall.}
    SetGCStartupLimits*: proc(self: ptr ICLRGCManager, SegmentSize: DWORD, MaxGen0Size: DWORD): HRESULT {.stdcall.}
  ICLRGCManager2* {.pure.} = object
    lpVtbl*: ptr ICLRGCManager2Vtbl
  ICLRGCManager2Vtbl* {.pure, inheritable.} = object of ICLRGCManagerVtbl
    SetGCStartupLimitsEx*: proc(self: ptr ICLRGCManager2, SegmentSize: SIZE_T, MaxGen0Size: SIZE_T): HRESULT {.stdcall.}
  IHostAssemblyStore* {.pure.} = object
    lpVtbl*: ptr IHostAssemblyStoreVtbl
  IHostAssemblyStoreVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ProvideAssembly*: proc(self: ptr IHostAssemblyStore, pBindInfo: ptr AssemblyBindInfo, pAssemblyId: ptr UINT64, pContext: ptr UINT64, ppStmAssemblyImage: ptr ptr IStream, ppStmPDB: ptr ptr IStream): HRESULT {.stdcall.}
    ProvideModule*: proc(self: ptr IHostAssemblyStore, pBindInfo: ptr ModuleBindInfo, pdwModuleId: ptr DWORD, ppStmModuleImage: ptr ptr IStream, ppStmPDB: ptr ptr IStream): HRESULT {.stdcall.}
  IHostAssemblyManager* {.pure.} = object
    lpVtbl*: ptr IHostAssemblyManagerVtbl
  IHostAssemblyManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetNonHostStoreAssemblies*: proc(self: ptr IHostAssemblyManager, ppReferenceList: ptr ptr ICLRAssemblyReferenceList): HRESULT {.stdcall.}
    GetAssemblyStore*: proc(self: ptr IHostAssemblyManager, ppAssemblyStore: ptr ptr IHostAssemblyStore): HRESULT {.stdcall.}
  IHostControl* {.pure.} = object
    lpVtbl*: ptr IHostControlVtbl
  IHostControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetHostManager*: proc(self: ptr IHostControl, riid: REFIID, ppObject: ptr pointer): HRESULT {.stdcall.}
    SetAppDomainManager*: proc(self: ptr IHostControl, dwAppDomainID: DWORD, pUnkAppDomainManager: ptr IUnknown): HRESULT {.stdcall.}
  ICLRControl* {.pure.} = object
    lpVtbl*: ptr ICLRControlVtbl
  ICLRControlVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCLRManager*: proc(self: ptr ICLRControl, riid: REFIID, ppObject: ptr pointer): HRESULT {.stdcall.}
    SetAppDomainManagerType*: proc(self: ptr ICLRControl, pwzAppDomainManagerAssembly: LPCWSTR, pwzAppDomainManagerType: LPCWSTR): HRESULT {.stdcall.}
  ICLRRuntimeHost* {.pure.} = object
    lpVtbl*: ptr ICLRRuntimeHostVtbl
  ICLRRuntimeHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Start*: proc(self: ptr ICLRRuntimeHost): HRESULT {.stdcall.}
    Stop*: proc(self: ptr ICLRRuntimeHost): HRESULT {.stdcall.}
    SetHostControl*: proc(self: ptr ICLRRuntimeHost, pHostControl: ptr IHostControl): HRESULT {.stdcall.}
    GetCLRControl*: proc(self: ptr ICLRRuntimeHost, pCLRControl: ptr ptr ICLRControl): HRESULT {.stdcall.}
    UnloadAppDomain*: proc(self: ptr ICLRRuntimeHost, dwAppDomainId: DWORD, fWaitUntilDone: BOOL): HRESULT {.stdcall.}
    ExecuteInAppDomain*: proc(self: ptr ICLRRuntimeHost, dwAppDomainId: DWORD, pCallback: FExecuteInAppDomainCallback, cookie: pointer): HRESULT {.stdcall.}
    GetCurrentAppDomainId*: proc(self: ptr ICLRRuntimeHost, pdwAppDomainId: ptr DWORD): HRESULT {.stdcall.}
    ExecuteApplication*: proc(self: ptr ICLRRuntimeHost, pwzAppFullName: LPCWSTR, dwManifestPaths: DWORD, ppwzManifestPaths: ptr LPCWSTR, dwActivationData: DWORD, ppwzActivationData: ptr LPCWSTR, pReturnValue: ptr int32): HRESULT {.stdcall.}
    ExecuteInDefaultAppDomain*: proc(self: ptr ICLRRuntimeHost, pwzAssemblyPath: LPCWSTR, pwzTypeName: LPCWSTR, pwzMethodName: LPCWSTR, pwzArgument: LPCWSTR, pReturnValue: ptr DWORD): HRESULT {.stdcall.}
  ICLRHostProtectionManager* {.pure.} = object
    lpVtbl*: ptr ICLRHostProtectionManagerVtbl
  ICLRHostProtectionManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetProtectedCategories*: proc(self: ptr ICLRHostProtectionManager, categories: EApiCategories): HRESULT {.stdcall.}
    SetEagerSerializeGrantSets*: proc(self: ptr ICLRHostProtectionManager): HRESULT {.stdcall.}
  ICLRDomainManager* {.pure.} = object
    lpVtbl*: ptr ICLRDomainManagerVtbl
  ICLRDomainManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetAppDomainManagerType*: proc(self: ptr ICLRDomainManager, wszAppDomainManagerAssembly: LPCWSTR, wszAppDomainManagerType: LPCWSTR, dwInitializeDomainFlags: EInitializeNewDomainFlags): HRESULT {.stdcall.}
    SetPropertiesForDefaultAppDomain*: proc(self: ptr ICLRDomainManager, nProperties: DWORD, pwszPropertyNames: ptr LPCWSTR, pwszPropertyValues: ptr LPCWSTR): HRESULT {.stdcall.}
  ITypeName* {.pure.} = object
    lpVtbl*: ptr ITypeNameVtbl
  ITypeNameVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetNameCount*: proc(self: ptr ITypeName, pCount: ptr DWORD): HRESULT {.stdcall.}
    GetNames*: proc(self: ptr ITypeName, count: DWORD, rgbszNames: ptr BSTR, pCount: ptr DWORD): HRESULT {.stdcall.}
    GetTypeArgumentCount*: proc(self: ptr ITypeName, pCount: ptr DWORD): HRESULT {.stdcall.}
    GetTypeArguments*: proc(self: ptr ITypeName, count: DWORD, rgpArguments: ptr ptr ITypeName, pCount: ptr DWORD): HRESULT {.stdcall.}
    GetModifierLength*: proc(self: ptr ITypeName, pCount: ptr DWORD): HRESULT {.stdcall.}
    GetModifiers*: proc(self: ptr ITypeName, count: DWORD, rgModifiers: ptr DWORD, pCount: ptr DWORD): HRESULT {.stdcall.}
    GetAssemblyName*: proc(self: ptr ITypeName, rgbszAssemblyNames: ptr BSTR): HRESULT {.stdcall.}
  ITypeNameBuilder* {.pure.} = object
    lpVtbl*: ptr ITypeNameBuilderVtbl
  ITypeNameBuilderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OpenGenericArguments*: proc(self: ptr ITypeNameBuilder): HRESULT {.stdcall.}
    CloseGenericArguments*: proc(self: ptr ITypeNameBuilder): HRESULT {.stdcall.}
    OpenGenericArgument*: proc(self: ptr ITypeNameBuilder): HRESULT {.stdcall.}
    CloseGenericArgument*: proc(self: ptr ITypeNameBuilder): HRESULT {.stdcall.}
    AddName*: proc(self: ptr ITypeNameBuilder, szName: LPCWSTR): HRESULT {.stdcall.}
    AddPointer*: proc(self: ptr ITypeNameBuilder): HRESULT {.stdcall.}
    AddByRef*: proc(self: ptr ITypeNameBuilder): HRESULT {.stdcall.}
    AddSzArray*: proc(self: ptr ITypeNameBuilder): HRESULT {.stdcall.}
    AddArray*: proc(self: ptr ITypeNameBuilder, rank: DWORD): HRESULT {.stdcall.}
    AddAssemblySpec*: proc(self: ptr ITypeNameBuilder, szAssemblySpec: LPCWSTR): HRESULT {.stdcall.}
    ToString*: proc(self: ptr ITypeNameBuilder, pszStringRepresentation: ptr BSTR): HRESULT {.stdcall.}
    Clear*: proc(self: ptr ITypeNameBuilder): HRESULT {.stdcall.}
  ITypeNameFactory* {.pure.} = object
    lpVtbl*: ptr ITypeNameFactoryVtbl
  ITypeNameFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ParseTypeName*: proc(self: ptr ITypeNameFactory, szName: LPCWSTR, pError: ptr DWORD, ppTypeName: ptr ptr ITypeName): HRESULT {.stdcall.}
    GetTypeNameBuilder*: proc(self: ptr ITypeNameFactory, ppTypeBuilder: ptr ptr ITypeNameBuilder): HRESULT {.stdcall.}
  IApartmentCallback* {.pure.} = object
    lpVtbl*: ptr IApartmentCallbackVtbl
  IApartmentCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    DoCallback*: proc(self: ptr IApartmentCallback, pFunc: SIZE_T, pData: SIZE_T): HRESULT {.stdcall.}
  IManagedObject* {.pure.} = object
    lpVtbl*: ptr IManagedObjectVtbl
  IManagedObjectVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSerializedBuffer*: proc(self: ptr IManagedObject, pBSTR: ptr BSTR): HRESULT {.stdcall.}
    GetObjectIdentity*: proc(self: ptr IManagedObject, pBSTRGUID: ptr BSTR, AppDomainID: ptr int32, pCCW: ptr int32): HRESULT {.stdcall.}
  ICatalogServices* {.pure.} = object
    lpVtbl*: ptr ICatalogServicesVtbl
  ICatalogServicesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Autodone*: proc(self: ptr ICatalogServices): HRESULT {.stdcall.}
    NotAutodone*: proc(self: ptr ICatalogServices): HRESULT {.stdcall.}
  IHostSecurityContext* {.pure.} = object
    lpVtbl*: ptr IHostSecurityContextVtbl
  IHostSecurityContextVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Capture*: proc(self: ptr IHostSecurityContext, ppClonedContext: ptr ptr IHostSecurityContext): HRESULT {.stdcall.}
  IHostSecurityManager* {.pure.} = object
    lpVtbl*: ptr IHostSecurityManagerVtbl
  IHostSecurityManagerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ImpersonateLoggedOnUser*: proc(self: ptr IHostSecurityManager, hToken: HANDLE): HRESULT {.stdcall.}
    RevertToSelf*: proc(self: ptr IHostSecurityManager): HRESULT {.stdcall.}
    OpenThreadToken*: proc(self: ptr IHostSecurityManager, dwDesiredAccess: DWORD, bOpenAsSelf: BOOL, phThreadToken: ptr HANDLE): HRESULT {.stdcall.}
    SetThreadToken*: proc(self: ptr IHostSecurityManager, hToken: HANDLE): HRESULT {.stdcall.}
    GetSecurityContext*: proc(self: ptr IHostSecurityManager, eContextType: EContextType, ppSecurityContext: ptr ptr IHostSecurityContext): HRESULT {.stdcall.}
    SetSecurityContext*: proc(self: ptr IHostSecurityManager, eContextType: EContextType, pSecurityContext: ptr IHostSecurityContext): HRESULT {.stdcall.}
  ICLRAppDomainResourceMonitor* {.pure.} = object
    lpVtbl*: ptr ICLRAppDomainResourceMonitorVtbl
  ICLRAppDomainResourceMonitorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentAllocated*: proc(self: ptr ICLRAppDomainResourceMonitor, dwAppDomainId: DWORD, pBytesAllocated: ptr ULONGLONG): HRESULT {.stdcall.}
    GetCurrentSurvived*: proc(self: ptr ICLRAppDomainResourceMonitor, dwAppDomainId: DWORD, pAppDomainBytesSurvived: ptr ULONGLONG, pTotalBytesSurvived: ptr ULONGLONG): HRESULT {.stdcall.}
    GetCurrentCpuTime*: proc(self: ptr ICLRAppDomainResourceMonitor, dwAppDomainId: DWORD, pMilliseconds: ptr ULONGLONG): HRESULT {.stdcall.}
  ICLRMetaHost* {.pure.} = object
    lpVtbl*: ptr ICLRMetaHostVtbl
  ICLRMetaHostVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetRuntime*: proc(self: ptr ICLRMetaHost, pwzVersion: LPCWSTR, riid: REFIID, ppRuntime: ptr LPVOID): HRESULT {.stdcall.}
    GetVersionFromFile*: proc(self: ptr ICLRMetaHost, pwzFilePath: LPCWSTR, pwzBuffer: LPWSTR, pcchBuffer: ptr DWORD): HRESULT {.stdcall.}
    EnumerateInstalledRuntimes*: proc(self: ptr ICLRMetaHost, ppEnumerator: ptr ptr IEnumUnknown): HRESULT {.stdcall.}
    EnumerateLoadedRuntimes*: proc(self: ptr ICLRMetaHost, hndProcess: HANDLE, ppEnumerator: ptr ptr IEnumUnknown): HRESULT {.stdcall.}
    RequestRuntimeLoadedNotification*: proc(self: ptr ICLRMetaHost, pCallbackFunction: RuntimeLoadedCallbackFnPtr): HRESULT {.stdcall.}
    QueryLegacyV2RuntimeBinding*: proc(self: ptr ICLRMetaHost, riid: REFIID, ppUnk: ptr LPVOID): HRESULT {.stdcall.}
    ExitProcess*: proc(self: ptr ICLRMetaHost, iExitCode: INT32): HRESULT {.stdcall.}
  ICLRMetaHostPolicy* {.pure.} = object
    lpVtbl*: ptr ICLRMetaHostPolicyVtbl
  ICLRMetaHostPolicyVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetRequestedRuntime*: proc(self: ptr ICLRMetaHostPolicy, dwPolicyFlags: METAHOST_POLICY_FLAGS, pwzBinary: LPCWSTR, pCfgStream: ptr IStream, pwzVersion: LPWSTR, pcchVersion: ptr DWORD, pwzImageVersion: LPWSTR, pcchImageVersion: ptr DWORD, pdwConfigFlags: ptr DWORD, riid: REFIID, ppRuntime: ptr LPVOID): HRESULT {.stdcall.}
  ICLRProfiling* {.pure.} = object
    lpVtbl*: ptr ICLRProfilingVtbl
  ICLRProfilingVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AttachProfiler*: proc(self: ptr ICLRProfiling, dwProfileeProcessID: DWORD, dwMillisecondsMax: DWORD, pClsidProfiler: ptr CLSID, wszProfilerPath: LPCWSTR, pvClientData: pointer, cbClientData: UINT): HRESULT {.stdcall.}
  ICLRDebuggingLibraryProvider* {.pure.} = object
    lpVtbl*: ptr ICLRDebuggingLibraryProviderVtbl
  ICLRDebuggingLibraryProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ProvideLibrary*: proc(self: ptr ICLRDebuggingLibraryProvider, pwszFileName: ptr WCHAR, dwTimestamp: DWORD, dwSizeOfImage: DWORD, phModule: ptr HMODULE): HRESULT {.stdcall.}
  ICLRDebugging* {.pure.} = object
    lpVtbl*: ptr ICLRDebuggingVtbl
  ICLRDebuggingVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    OpenVirtualProcess*: proc(self: ptr ICLRDebugging, moduleBaseAddress: ULONG64, pDataTarget: ptr IUnknown, pLibraryProvider: ptr ICLRDebuggingLibraryProvider, pMaxDebuggerSupportedVersion: ptr CLR_DEBUGGING_VERSION, riidProcess: REFIID, ppProcess: ptr ptr IUnknown, pVersion: ptr CLR_DEBUGGING_VERSION, pdwFlags: ptr CLR_DEBUGGING_PROCESS_FLAGS): HRESULT {.stdcall.}
    CanUnloadNow*: proc(self: ptr ICLRDebugging, hModule: HMODULE): HRESULT {.stdcall.}
  ICLRStrongName* {.pure.} = object
    lpVtbl*: ptr ICLRStrongNameVtbl
  ICLRStrongNameVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetHashFromAssemblyFile*: proc(self: ptr ICLRStrongName, pszFilePath: LPCSTR, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.stdcall.}
    GetHashFromAssemblyFileW*: proc(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.stdcall.}
    GetHashFromBlob*: proc(self: ptr ICLRStrongName, pbBlob: ptr BYTE, cchBlob: DWORD, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.stdcall.}
    GetHashFromFile*: proc(self: ptr ICLRStrongName, pszFilePath: LPCSTR, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.stdcall.}
    GetHashFromFileW*: proc(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.stdcall.}
    GetHashFromHandle*: proc(self: ptr ICLRStrongName, hFile: HANDLE, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.stdcall.}
    StrongNameCompareAssemblies*: proc(self: ptr ICLRStrongName, pwzAssembly1: LPCWSTR, pwzAssembly2: LPCWSTR, pdwResult: ptr DWORD): HRESULT {.stdcall.}
    StrongNameFreeBuffer*: proc(self: ptr ICLRStrongName, pbMemory: ptr BYTE): HRESULT {.stdcall.}
    StrongNameGetBlob*: proc(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, pbBlob: ptr BYTE, pcbBlob: ptr DWORD): HRESULT {.stdcall.}
    StrongNameGetBlobFromImage*: proc(self: ptr ICLRStrongName, pbBase: ptr BYTE, dwLength: DWORD, pbBlob: ptr BYTE, pcbBlob: ptr DWORD): HRESULT {.stdcall.}
    StrongNameGetPublicKey*: proc(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, ppbPublicKeyBlob: ptr ptr BYTE, pcbPublicKeyBlob: ptr ULONG): HRESULT {.stdcall.}
    StrongNameHashSize*: proc(self: ptr ICLRStrongName, ulHashAlg: ULONG, pcbSize: ptr DWORD): HRESULT {.stdcall.}
    StrongNameKeyDelete*: proc(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR): HRESULT {.stdcall.}
    StrongNameKeyGen*: proc(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR, dwFlags: DWORD, ppbKeyBlob: ptr ptr BYTE, pcbKeyBlob: ptr ULONG): HRESULT {.stdcall.}
    StrongNameKeyGenEx*: proc(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR, dwFlags: DWORD, dwKeySize: DWORD, ppbKeyBlob: ptr ptr BYTE, pcbKeyBlob: ptr ULONG): HRESULT {.stdcall.}
    StrongNameKeyInstall*: proc(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG): HRESULT {.stdcall.}
    StrongNameSignatureGeneration*: proc(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, pwzKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, ppbSignatureBlob: ptr ptr BYTE, pcbSignatureBlob: ptr ULONG): HRESULT {.stdcall.}
    StrongNameSignatureGenerationEx*: proc(self: ptr ICLRStrongName, wszFilePath: LPCWSTR, wszKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, ppbSignatureBlob: ptr ptr BYTE, pcbSignatureBlob: ptr ULONG, dwFlags: DWORD): HRESULT {.stdcall.}
    StrongNameSignatureSize*: proc(self: ptr ICLRStrongName, pbPublicKeyBlob: ptr BYTE, cbPublicKeyBlob: ULONG, pcbSize: ptr DWORD): HRESULT {.stdcall.}
    StrongNameSignatureVerification*: proc(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, dwInFlags: DWORD, pdwOutFlags: ptr DWORD): HRESULT {.stdcall.}
    StrongNameSignatureVerificationEx*: proc(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, fForceVerification: BOOLEAN, pfWasVerified: ptr BOOLEAN): HRESULT {.stdcall.}
    StrongNameSignatureVerificationFromImage*: proc(self: ptr ICLRStrongName, pbBase: ptr BYTE, dwLength: DWORD, dwInFlags: DWORD, pdwOutFlags: ptr DWORD): HRESULT {.stdcall.}
    StrongNameTokenFromAssembly*: proc(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, ppbStrongNameToken: ptr ptr BYTE, pcbStrongNameToken: ptr ULONG): HRESULT {.stdcall.}
    StrongNameTokenFromAssemblyEx*: proc(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, ppbStrongNameToken: ptr ptr BYTE, pcbStrongNameToken: ptr ULONG, ppbPublicKeyBlob: ptr ptr BYTE, pcbPublicKeyBlob: ptr ULONG): HRESULT {.stdcall.}
    StrongNameTokenFromPublicKey*: proc(self: ptr ICLRStrongName, pbPublicKeyBlob: ptr BYTE, cbPublicKeyBlob: ULONG, ppbStrongNameToken: ptr ptr BYTE, pcbStrongNameToken: ptr ULONG): HRESULT {.stdcall.}
  ICLRStrongName2* {.pure.} = object
    lpVtbl*: ptr ICLRStrongName2Vtbl
  ICLRStrongName2Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StrongNameGetPublicKeyEx*: proc(self: ptr ICLRStrongName2, pwzKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, ppbPublicKeyBlob: ptr ptr BYTE, pcbPublicKeyBlob: ptr ULONG, uHashAlgId: ULONG, uReserved: ULONG): HRESULT {.stdcall.}
    StrongNameSignatureVerificationEx2*: proc(self: ptr ICLRStrongName2, wszFilePath: LPCWSTR, fForceVerification: BOOLEAN, pbEcmaPublicKey: ptr BYTE, cbEcmaPublicKey: DWORD, pfWasVerified: ptr BOOLEAN): HRESULT {.stdcall.}
  ICLRStrongName3* {.pure.} = object
    lpVtbl*: ptr ICLRStrongName3Vtbl
  ICLRStrongName3Vtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StrongNameDigestGenerate*: proc(self: ptr ICLRStrongName3, wszFilePath: LPCWSTR, ppbDigestBlob: ptr ptr BYTE, pcbDigestBlob: ptr ULONG, dwFlags: DWORD): HRESULT {.stdcall.}
    StrongNameDigestSign*: proc(self: ptr ICLRStrongName3, wszKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, pbDigestBlob: ptr BYTE, cbDigestBlob: ULONG, hashAlgId: DWORD, ppbSignatureBlob: ptr ptr BYTE, pcbSignatureBlob: ptr ULONG, dwFlags: DWORD): HRESULT {.stdcall.}
    StrongNameDigestEmbed*: proc(self: ptr ICLRStrongName3, wszFilePath: LPCWSTR, pbSignatureBlob: ptr BYTE, cbSignatureBlob: ULONG): HRESULT {.stdcall.}
  IAssembly* {.pure.} = object
    lpVtbl*: ptr IAssemblyVtbl
  IAssemblyVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_ToString*: proc(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    Equals*: proc(self: ptr IAssembly, other: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    GetHashCode*: proc(self: ptr IAssembly, pRetVal: ptr int32): HRESULT {.stdcall.}
    GetType*: proc(self: ptr IAssembly, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    get_CodeBase*: proc(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_EscapedCodeBase*: proc(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    GetName*: proc(self: ptr IAssembly, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetName_2*: proc(self: ptr IAssembly, copiedName: VARIANT_BOOL, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    get_FullName*: proc(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_EntryPoint*: proc(self: ptr IAssembly, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetType_2*: proc(self: ptr IAssembly, name: BSTR, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetType_3*: proc(self: ptr IAssembly, name: BSTR, throwOnError: VARIANT_BOOL, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetExportedTypes*: proc(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetTypes*: proc(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetManifestResourceStream*: proc(self: ptr IAssembly, Type: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetManifestResourceStream_2*: proc(self: ptr IAssembly, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetFile*: proc(self: ptr IAssembly, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetFiles*: proc(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetFiles_2*: proc(self: ptr IAssembly, getResourceModules: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetManifestResourceNames*: proc(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetManifestResourceInfo*: proc(self: ptr IAssembly, resourceName: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    get_Location*: proc(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_Evidence*: proc(self: ptr IAssembly, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetCustomAttributes*: proc(self: ptr IAssembly, attributeType: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetCustomAttributes_2*: proc(self: ptr IAssembly, inherit: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    IsDefined*: proc(self: ptr IAssembly, attributeType: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    GetObjectData*: proc(self: ptr IAssembly, info: POBJECT, Context: StreamingContext): HRESULT {.stdcall.}
    add_ModuleResolve*: proc(self: ptr IAssembly, value: POBJECT): HRESULT {.stdcall.}
    remove_ModuleResolve*: proc(self: ptr IAssembly, value: POBJECT): HRESULT {.stdcall.}
    GetType_4*: proc(self: ptr IAssembly, name: BSTR, throwOnError: VARIANT_BOOL, ignoreCase: VARIANT_BOOL, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetSatelliteAssembly*: proc(self: ptr IAssembly, culture: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    GetSatelliteAssembly_2*: proc(self: ptr IAssembly, culture: POBJECT, Version: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    LoadModule*: proc(self: ptr IAssembly, moduleName: BSTR, rawModule: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    LoadModule_2*: proc(self: ptr IAssembly, moduleName: BSTR, rawModule: ptr SAFEARRAY, rawSymbolStore: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    CreateInstance*: proc(self: ptr IAssembly, typeName: BSTR, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    CreateInstance_2*: proc(self: ptr IAssembly, typeName: BSTR, ignoreCase: VARIANT_BOOL, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    CreateInstance_3*: proc(self: ptr IAssembly, typeName: BSTR, ignoreCase: VARIANT_BOOL, bindingAttr: BindingFlags, Binder: POBJECT, args: ptr SAFEARRAY, culture: POBJECT, activationAttributes: ptr SAFEARRAY, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    GetLoadedModules*: proc(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetLoadedModules_2*: proc(self: ptr IAssembly, getResourceModules: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetModules*: proc(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetModules_2*: proc(self: ptr IAssembly, getResourceModules: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetModule*: proc(self: ptr IAssembly, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetReferencedAssemblies*: proc(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_GlobalAssemblyCache*: proc(self: ptr IAssembly, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  IType* {.pure.} = object
    lpVtbl*: ptr ITypeVtbl
  ITypeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetTypeInfoCount*: proc(self: ptr IType, pcTInfo: ptr int32): HRESULT {.stdcall.}
    GetTypeInfo*: proc(self: ptr IType, iTInfo: int32, lcid: int32, ppTInfo: int32): HRESULT {.stdcall.}
    GetIDsOfNames*: proc(self: ptr IType, riid: ptr GUID, rgszNames: int32, cNames: int32, lcid: int32, rgDispId: int32): HRESULT {.stdcall.}
    Invoke*: proc(self: ptr IType, dispIdMember: int32, riid: ptr GUID, lcid: int32, wFlags: int16, pDispParams: int32, pVarResult: int32, pExcepInfo: int32, puArgErr: int32): HRESULT {.stdcall.}
    get_ToString*: proc(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    Equals*: proc(self: ptr IType, other: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    GetHashCode*: proc(self: ptr IType, pRetVal: ptr int32): HRESULT {.stdcall.}
    GetType*: proc(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    get_MemberType*: proc(self: ptr IType, pRetVal: ptr MemberTypes): HRESULT {.stdcall.}
    get_name*: proc(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_DeclaringType*: proc(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    get_ReflectedType*: proc(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetCustomAttributes*: proc(self: ptr IType, attributeType: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetCustomAttributes_2*: proc(self: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    IsDefined*: proc(self: ptr IType, attributeType: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_Guid*: proc(self: ptr IType, pRetVal: ptr GUID): HRESULT {.stdcall.}
    get_Module*: proc(self: ptr IType, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    getIAssembly*: proc(self: ptr IType, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    get_TypeHandle*: proc(self: ptr IType, pRetVal: POBJECT): HRESULT {.stdcall.}
    get_FullName*: proc(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_Namespace*: proc(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_AssemblyQualifiedName*: proc(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    GetArrayRank*: proc(self: ptr IType, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_BaseType*: proc(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetConstructors*: proc(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetInterface*: proc(self: ptr IType, name: BSTR, ignoreCase: VARIANT_BOOL, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetInterfaces*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    FindInterfaces*: proc(self: ptr IType, filter: POBJECT, filterCriteria: VARIANT, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetEvent*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetEvents*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetEvents_2*: proc(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetNestedTypes*: proc(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetNestedType*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetMember*: proc(self: ptr IType, name: BSTR, Type: MemberTypes, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetDefaultMembers*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    FindMembers*: proc(self: ptr IType, MemberType: MemberTypes, bindingAttr: BindingFlags, filter: POBJECT, filterCriteria: VARIANT, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetElementType*: proc(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    IsSubclassOf*: proc(self: ptr IType, c: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    IsInstanceOfType*: proc(self: ptr IType, o: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    IsAssignableFrom*: proc(self: ptr IType, c: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    GetInterfaceMap*: proc(self: ptr IType, interfaceType: ptr IType, pRetVal: POBJECT): HRESULT {.stdcall.}
    GetMethod*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, Binder: POBJECT, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetMethod_2*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetMethods*: proc(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetField*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetFields*: proc(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetProperty*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetProperty_2*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, Binder: POBJECT, returnType: ptr IType, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetProperties*: proc(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetMember_2*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetMembers*: proc(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    InvokeMember*: proc(self: ptr IType, name: BSTR, invokeAttr: BindingFlags, Binder: POBJECT, Target: VARIANT, args: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, culture: POBJECT, namedParameters: ptr SAFEARRAY, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    get_UnderlyingSystemType*: proc(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    InvokeMember_2*: proc(self: ptr IType, name: BSTR, invokeAttr: BindingFlags, Binder: POBJECT, Target: VARIANT, args: ptr SAFEARRAY, culture: POBJECT, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    InvokeMember_3*: proc(self: ptr IType, name: BSTR, invokeAttr: BindingFlags, Binder: POBJECT, Target: VARIANT, args: ptr SAFEARRAY, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    GetConstructor*: proc(self: ptr IType, bindingAttr: BindingFlags, Binder: POBJECT, callConvention: CallingConventions, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetConstructor_2*: proc(self: ptr IType, bindingAttr: BindingFlags, Binder: POBJECT, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetConstructor_3*: proc(self: ptr IType, types: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetConstructors_2*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_TypeInitializer*: proc(self: ptr IType, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetMethod_3*: proc(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, Binder: POBJECT, callConvention: CallingConventions, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetMethod_4*: proc(self: ptr IType, name: BSTR, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetMethod_5*: proc(self: ptr IType, name: BSTR, types: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetMethod_6*: proc(self: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetMethods_2*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetField_2*: proc(self: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetFields_2*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetInterface_2*: proc(self: ptr IType, name: BSTR, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetEvent_2*: proc(self: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetProperty_3*: proc(self: ptr IType, name: BSTR, returnType: ptr IType, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetProperty_4*: proc(self: ptr IType, name: BSTR, returnType: ptr IType, types: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetProperty_5*: proc(self: ptr IType, name: BSTR, types: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetProperty_6*: proc(self: ptr IType, name: BSTR, returnType: ptr IType, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetProperty_7*: proc(self: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    GetProperties_2*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetNestedTypes_2*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetNestedType_2*: proc(self: ptr IType, name: BSTR, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetMember_3*: proc(self: ptr IType, name: BSTR, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetMembers_2*: proc(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_Attributes*: proc(self: ptr IType, pRetVal: ptr TypeAttributes): HRESULT {.stdcall.}
    get_IsNotPublic*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsPublic*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsNestedPublic*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsNestedPrivate*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsNestedFamily*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsNestedAssembly*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsNestedFamANDAssem*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsNestedFamORAssem*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsAutoLayout*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsLayoutSequential*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsExplicitLayout*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsClass*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsInterface*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsValueType*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsAbstract*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsSealed*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsEnum*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsSpecialName*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsImport*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsSerializable*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsAnsiClass*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsUnicodeClass*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsAutoClass*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsArray*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsByRef*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsPointer*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsPrimitive*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsCOMObject*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_HasElementType*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsContextful*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    get_IsMarshalByRef*: proc(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    Equals_2*: proc(self: ptr IType, o: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
  IObject* {.pure.} = object
    lpVtbl*: ptr IObjectVtbl
  IObjectVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_ToString*: proc(self: ptr IObject, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    Equals*: proc(self: ptr IObject, obj: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    GetHashCode*: proc(self: ptr IObject, pRetVal: ptr int32): HRESULT {.stdcall.}
    GetType*: proc(self: ptr IObject, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
  IAppDomainSetup* {.pure.} = object
    lpVtbl*: ptr IAppDomainSetupVtbl
  IAppDomainSetupVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_ApplicationBase*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_ApplicationBase*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_ApplicationName*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_ApplicationName*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_CachePath*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_CachePath*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_ConfigurationFile*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_ConfigurationFile*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_DynamicBase*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_DynamicBase*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_LicenseFile*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_LicenseFile*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_PrivateBinPath*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_PrivateBinPath*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_PrivateBinPathProbe*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_PrivateBinPathProbe*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_ShadowCopyDirectories*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_ShadowCopyDirectories*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
    get_ShadowCopyFiles*: proc(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    put_ShadowCopyFiles*: proc(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.stdcall.}
  ObjectHandle* {.pure.} = object
    lpVtbl*: ptr ObjectHandleVtbl
  ObjectHandleVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_ToString*: proc(self: ptr ObjectHandle, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    Equals*: proc(self: ptr ObjectHandle, obj: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    GetHashCode*: proc(self: ptr ObjectHandle, pRetVal: ptr int32): HRESULT {.stdcall.}
    GetType*: proc(self: ptr ObjectHandle, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    GetLifetimeService*: proc(self: ptr ObjectHandle, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    InitializeLifetimeService*: proc(self: ptr ObjectHandle, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    CreateObjRef*: proc(self: ptr ObjectHandle, requestedType: ptr IType, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    Unwrap*: proc(self: ptr ObjectHandle, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
  AppDomain* {.pure.} = object
    lpVtbl*: ptr AppDomainVtbl
  AppDomainVtbl* {.pure, inheritable.} = object of IDispatchVtbl
    get_ToString*: proc(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    Equals*: proc(self: ptr AppDomain, other: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    GetHashCode*: proc(self: ptr AppDomain, pRetVal: ptr int32): HRESULT {.stdcall.}
    GetType*: proc(self: ptr AppDomain, pRetVal: ptr ptr IType): HRESULT {.stdcall.}
    InitializeLifetimeService*: proc(self: ptr AppDomain, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    GetLifetimeService*: proc(self: ptr AppDomain, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    get_Evidence*: proc(self: ptr AppDomain, pRetVal: ptr POBJECT): HRESULT {.stdcall.}
    add_DomainUnload*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    remove_DomainUnload*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    add_AssemblyLoad*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    remove_AssemblyLoad*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    add_ProcessExit*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    remove_ProcessExit*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    add_TypeResolve*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    remove_TypeResolve*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    add_ResourceResolve*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    remove_ResourceResolve*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    add_AssemblyResolve*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    remove_AssemblyResolve*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    add_UnhandledException*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    remove_UnhandledException*: proc(self: ptr AppDomain, value: POBJECT): HRESULT {.stdcall.}
    DefineDynamicAssembly*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    DefineDynamicAssembly_2*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    DefineDynamicAssembly_3*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, Evidence: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    DefineDynamicAssembly_4*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    DefineDynamicAssembly_5*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, Evidence: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    DefineDynamicAssembly_6*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    DefineDynamicAssembly_7*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, Evidence: POBJECT, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    DefineDynamicAssembly_8*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, Evidence: POBJECT, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    DefineDynamicAssembly_9*: proc(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, Evidence: POBJECT, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, IsSynchronized: VARIANT_BOOL, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.stdcall.}
    CreateInstance*: proc(self: ptr AppDomain, AssemblyName: BSTR, typeName: BSTR, pRetVal: ptr ptr ObjectHandle): HRESULT {.stdcall.}
    CreateInstanceFrom*: proc(self: ptr AppDomain, assemblyFile: BSTR, typeName: BSTR, pRetVal: ptr ptr ObjectHandle): HRESULT {.stdcall.}
    CreateInstance_2*: proc(self: ptr AppDomain, AssemblyName: BSTR, typeName: BSTR, activationAttributes: ptr SAFEARRAY, pRetVal: ptr ptr ObjectHandle): HRESULT {.stdcall.}
    CreateInstanceFrom_2*: proc(self: ptr AppDomain, assemblyFile: BSTR, typeName: BSTR, activationAttributes: ptr SAFEARRAY, pRetVal: ptr ptr ObjectHandle): HRESULT {.stdcall.}
    CreateInstance_3*: proc(self: ptr AppDomain, AssemblyName: BSTR, typeName: BSTR, ignoreCase: VARIANT_BOOL, bindingAttr: BindingFlags, Binder: POBJECT, args: ptr SAFEARRAY, culture: POBJECT, activationAttributes: ptr SAFEARRAY, securityAttributes: POBJECT, pRetVal: ptr ptr ObjectHandle): HRESULT {.stdcall.}
    CreateInstanceFrom_3*: proc(self: ptr AppDomain, assemblyFile: BSTR, typeName: BSTR, ignoreCase: VARIANT_BOOL, bindingAttr: BindingFlags, Binder: POBJECT, args: ptr SAFEARRAY, culture: POBJECT, activationAttributes: ptr SAFEARRAY, securityAttributes: POBJECT, pRetVal: ptr ptr ObjectHandle): HRESULT {.stdcall.}
    Load*: proc(self: ptr AppDomain, assemblyRef: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    Load_2*: proc(self: ptr AppDomain, assemblyString: BSTR, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    Load_3*: proc(self: ptr AppDomain, rawAssembly: ptr SAFEARRAY, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    Load_4*: proc(self: ptr AppDomain, rawAssembly: ptr SAFEARRAY, rawSymbolStore: ptr SAFEARRAY, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    Load_5*: proc(self: ptr AppDomain, rawAssembly: ptr SAFEARRAY, rawSymbolStore: ptr SAFEARRAY, securityEvidence: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    Load_6*: proc(self: ptr AppDomain, assemblyRef: POBJECT, assemblySecurity: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    Load_7*: proc(self: ptr AppDomain, assemblyString: BSTR, assemblySecurity: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.stdcall.}
    ExecuteAssembly*: proc(self: ptr AppDomain, assemblyFile: BSTR, assemblySecurity: POBJECT, pRetVal: ptr int32): HRESULT {.stdcall.}
    ExecuteAssembly_2*: proc(self: ptr AppDomain, assemblyFile: BSTR, pRetVal: ptr int32): HRESULT {.stdcall.}
    ExecuteAssembly_3*: proc(self: ptr AppDomain, assemblyFile: BSTR, assemblySecurity: POBJECT, args: ptr SAFEARRAY, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_FriendlyName*: proc(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_BaseDirectory*: proc(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_RelativeSearchPath*: proc(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_ShadowCopyFiles*: proc(self: ptr AppDomain, pRetVal: ptr VARIANT_BOOL): HRESULT {.stdcall.}
    GetAssemblies*: proc(self: ptr AppDomain, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    AppendPrivatePath*: proc(self: ptr AppDomain, Path: BSTR): HRESULT {.stdcall.}
    ClearPrivatePath*: proc(self: ptr AppDomain): HRESULT {.stdcall.}
    SetShadowCopyPath*: proc(self: ptr AppDomain, s: BSTR): HRESULT {.stdcall.}
    ClearShadowCopyPath*: proc(self: ptr AppDomain): HRESULT {.stdcall.}
    SetCachePath*: proc(self: ptr AppDomain, s: BSTR): HRESULT {.stdcall.}
    SetData*: proc(self: ptr AppDomain, name: BSTR, data: VARIANT): HRESULT {.stdcall.}
    GetData*: proc(self: ptr AppDomain, name: BSTR, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    SetAppDomainPolicy*: proc(self: ptr AppDomain, domainPolicy: POBJECT): HRESULT {.stdcall.}
    SetThreadPrincipal*: proc(self: ptr AppDomain, principal: POBJECT): HRESULT {.stdcall.}
    SetPrincipalPolicy*: proc(self: ptr AppDomain, policy: PrincipalPolicy): HRESULT {.stdcall.}
    DoCallBack*: proc(self: ptr AppDomain, theDelegate: POBJECT): HRESULT {.stdcall.}
    get_DynamicDirectory*: proc(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.stdcall.}
proc GetCORSystemDirectory*(pbuffer: LPWSTR, cchBuffer: DWORD, dwLength: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc GetCORVersion*(pbBuffer: LPWSTR, cchBuffer: DWORD, dwLength: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc GetFileVersion*(szFilename: LPCWSTR, szBuffer: LPWSTR, cchBuffer: DWORD, dwLength: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc GetCORRequiredVersion*(pbuffer: LPWSTR, cchBuffer: DWORD, dwLength: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc GetRequestedRuntimeInfo*(pExe: LPCWSTR, pwszVersion: LPCWSTR, pConfigurationFile: LPCWSTR, startupFlags: DWORD, runtimeInfoFlags: DWORD, pDirectory: LPWSTR, dwDirectory: DWORD, dwDirectoryLength: ptr DWORD, pVersion: LPWSTR, cchBuffer: DWORD, dwlength: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc GetRequestedRuntimeVersion*(pExe: LPWSTR, pVersion: LPWSTR, cchBuffer: DWORD, dwLength: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc CorBindToRuntimeHost*(pwszVersion: LPCWSTR, pwszBuildFlavor: LPCWSTR, pwszHostConfigFile: LPCWSTR, pReserved: pointer, startupFlags: DWORD, rclsid: REFCLSID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc CorBindToRuntimeEx*(pwszVersion: LPCWSTR, pwszBuildFlavor: LPCWSTR, startupFlags: DWORD, rclsid: REFCLSID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc CorBindToRuntimeByCfg*(pCfgStream: ptr IStream, reserved: DWORD, startupFlags: DWORD, rclsid: REFCLSID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc CorBindToRuntime*(pwszVersion: LPCWSTR, pwszBuildFlavor: LPCWSTR, rclsid: REFCLSID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc CorBindToCurrentRuntime*(pwszFileName: LPCWSTR, rclsid: REFCLSID, riid: REFIID, ppv: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc ClrCreateManagedInstance*(pTypeName: LPCWSTR, riid: REFIID, ppObject: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc RunDll32ShimW*(hwnd: HWND, hinst: HINSTANCE, lpszCmdLine: LPCWSTR, nCmdShow: int32): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc LoadLibraryShim*(szDllName: LPCWSTR, szVersion: LPCWSTR, pvReserved: LPVOID, phModDll: ptr HMODULE): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc CallFunctionShim*(szDllName: LPCWSTR, szFunctionName: LPCSTR, lpvArgument1: LPVOID, lpvArgument2: LPVOID, szVersion: LPCWSTR, pvReserved: LPVOID): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc GetRealProcAddress*(pwszProcName: LPCSTR, ppv: ptr pointer): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc LoadStringRC*(iResouceID: UINT, szBuffer: LPWSTR, iMax: int32, bQuiet: int32): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc LoadStringRCEx*(lcid: LCID, iResouceID: UINT, szBuffer: LPWSTR, iMax: int32, bQuiet: int32, pcwchUsed: ptr int32): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc LockClrVersion*(hostCallback: FLockClrVersionCallback, pBeginHostSetup: ptr FLockClrVersionCallback, pEndHostSetup: ptr FLockClrVersionCallback): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc CreateDebuggingInterfaceFromVersion*(iDebuggerVersion: int32, szDebuggeeVersion: LPCWSTR, ppCordb: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc GetVersionFromProcess*(hProcess: HANDLE, pVersion: LPWSTR, cchBuffer: DWORD, dwLength: ptr DWORD): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc GetRequestedRuntimeVersionForCLSID*(rclsid: REFCLSID, pVersion: LPWSTR, cchBuffer: DWORD, dwLength: ptr DWORD, dwResolutionFlags: CLSID_RESOLUTION_FLAGS): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc CLRCreateInstance*(clsid: REFCLSID, riid: REFIID, ppInterface: ptr LPVOID): HRESULT {.winapi, stdcall, dynlib: "mscoree", importc.}
proc `pReserved=`*(self: var CustomDumpItem, x: UINT_PTR) {.inline.} = self.union1.pReserved = x
proc pReserved*(self: CustomDumpItem): UINT_PTR {.inline.} = self.union1.pReserved
proc pReserved*(self: var CustomDumpItem): var UINT_PTR {.inline.} = self.union1.pReserved
proc SetGCStartupLimits*(self: ptr IGCHost, SegmentSize: DWORD, MaxGen0Size: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGCStartupLimits(self, SegmentSize, MaxGen0Size)
proc Collect*(self: ptr IGCHost, Generation: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Collect(self, Generation)
proc GetStats*(self: ptr IGCHost, pStats: ptr COR_GC_STATS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStats(self, pStats)
proc GetThreadStats*(self: ptr IGCHost, pFiberCookie: ptr DWORD, pStats: ptr COR_GC_THREAD_STATS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetThreadStats(self, pFiberCookie, pStats)
proc SetVirtualMemLimit*(self: ptr IGCHost, sztMaxVirtualMemMB: SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVirtualMemLimit(self, sztMaxVirtualMemMB)
proc SetGCStartupLimitsEx*(self: ptr IGCHost2, SegmentSize: SIZE_T, MaxGen0Size: SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGCStartupLimitsEx(self, SegmentSize, MaxGen0Size)
proc VEHandler*(self: ptr IVEHandler, VECode: HRESULT, Context: VEContext, psa: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.VEHandler(self, VECode, Context, psa)
proc SetReporterFtn*(self: ptr IVEHandler, lFnPtr: int64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetReporterFtn(self, lFnPtr)
proc Validate*(self: ptr IValidator, veh: ptr IVEHandler, pAppDomain: ptr IUnknown, ulFlags: int32, ulMaxError: int32, token: int32, fileName: LPWSTR, pe: ptr BYTE, ulSize: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Validate(self, veh, pAppDomain, ulFlags, ulMaxError, token, fileName, pe, ulSize)
proc FormatEventInfo*(self: ptr IValidator, hVECode: HRESULT, Context: VEContext, msg: LPWSTR, ulMaxLength: int32, psa: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FormatEventInfo(self, hVECode, Context, msg, ulMaxLength, psa)
proc Validate*(self: ptr ICLRValidator, veh: ptr IVEHandler, ulAppDomainId: int32, ulFlags: int32, ulMaxError: int32, token: int32, fileName: LPWSTR, pe: ptr BYTE, ulSize: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Validate(self, veh, ulAppDomainId, ulFlags, ulMaxError, token, fileName, pe, ulSize)
proc FormatEventInfo*(self: ptr ICLRValidator, hVECode: HRESULT, Context: VEContext, msg: LPWSTR, ulMaxLength: int32, psa: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FormatEventInfo(self, hVECode, Context, msg, ulMaxLength, psa)
proc Unwrap*(self: ptr IObjectHandle, ppv: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unwrap(self, ppv)
proc OnAppDomain*(self: ptr IAppDomainBinding, pAppdomain: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnAppDomain(self, pAppdomain)
proc ThreadIsBlockingForSuspension*(self: ptr IGCThreadControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ThreadIsBlockingForSuspension(self)
proc SuspensionStarting*(self: ptr IGCThreadControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SuspensionStarting(self)
proc SuspensionEnding*(self: ptr IGCThreadControl, Generation: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SuspensionEnding(self, Generation)
proc RequestVirtualMemLimit*(self: ptr IGCHostControl, sztMaxVirtualMemMB: SIZE_T, psztNewMaxVirtualMemMB: ptr SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestVirtualMemLimit(self, sztMaxVirtualMemMB, psztNewMaxVirtualMemMB)
proc CorRegisterWaitForSingleObject*(self: ptr ICorThreadpool, phNewWaitObject: ptr HANDLE, hWaitObject: HANDLE, Callback: WAITORTIMERCALLBACK, Context: PVOID, timeout: ULONG, executeOnlyOnce: BOOL, ret: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorRegisterWaitForSingleObject(self, phNewWaitObject, hWaitObject, Callback, Context, timeout, executeOnlyOnce, ret)
proc CorUnregisterWait*(self: ptr ICorThreadpool, hWaitObject: HANDLE, CompletionEvent: HANDLE, ret: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorUnregisterWait(self, hWaitObject, CompletionEvent, ret)
proc CorQueueUserWorkItem*(self: ptr ICorThreadpool, Function: LPTHREAD_START_ROUTINE, Context: PVOID, executeOnlyOnce: BOOL, ret: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorQueueUserWorkItem(self, Function, Context, executeOnlyOnce, ret)
proc CorCreateTimer*(self: ptr ICorThreadpool, phNewTimer: ptr HANDLE, Callback: WAITORTIMERCALLBACK, Parameter: PVOID, DueTime: DWORD, Period: DWORD, ret: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorCreateTimer(self, phNewTimer, Callback, Parameter, DueTime, Period, ret)
proc CorChangeTimer*(self: ptr ICorThreadpool, Timer: HANDLE, DueTime: ULONG, Period: ULONG, ret: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorChangeTimer(self, Timer, DueTime, Period, ret)
proc CorDeleteTimer*(self: ptr ICorThreadpool, Timer: HANDLE, CompletionEvent: HANDLE, ret: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorDeleteTimer(self, Timer, CompletionEvent, ret)
proc CorBindIoCompletionCallback*(self: ptr ICorThreadpool, fileHandle: HANDLE, callback: LPOVERLAPPED_COMPLETION_ROUTINE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorBindIoCompletionCallback(self, fileHandle, callback)
proc CorCallOrQueueUserWorkItem*(self: ptr ICorThreadpool, Function: LPTHREAD_START_ROUTINE, Context: PVOID, ret: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorCallOrQueueUserWorkItem(self, Function, Context, ret)
proc CorSetMaxThreads*(self: ptr ICorThreadpool, MaxWorkerThreads: DWORD, MaxIOCompletionThreads: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorSetMaxThreads(self, MaxWorkerThreads, MaxIOCompletionThreads)
proc CorGetMaxThreads*(self: ptr ICorThreadpool, MaxWorkerThreads: ptr DWORD, MaxIOCompletionThreads: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorGetMaxThreads(self, MaxWorkerThreads, MaxIOCompletionThreads)
proc CorGetAvailableThreads*(self: ptr ICorThreadpool, AvailableWorkerThreads: ptr DWORD, AvailableIOCompletionThreads: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CorGetAvailableThreads(self, AvailableWorkerThreads, AvailableIOCompletionThreads)
proc ThreadIsBlockingForDebugger*(self: ptr IDebuggerThreadControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ThreadIsBlockingForDebugger(self)
proc ReleaseAllRuntimeThreads*(self: ptr IDebuggerThreadControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseAllRuntimeThreads(self)
proc StartBlockingForDebugger*(self: ptr IDebuggerThreadControl, dwUnused: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartBlockingForDebugger(self, dwUnused)
proc IsDebuggerAttached*(self: ptr IDebuggerInfo, pbAttached: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDebuggerAttached(self, pbAttached)
proc SetGCThreadControl*(self: ptr ICorConfiguration, pGCThreadControl: ptr IGCThreadControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGCThreadControl(self, pGCThreadControl)
proc SetGCHostControl*(self: ptr ICorConfiguration, pGCHostControl: ptr IGCHostControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGCHostControl(self, pGCHostControl)
proc SetDebuggerThreadControl*(self: ptr ICorConfiguration, pDebuggerThreadControl: ptr IDebuggerThreadControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDebuggerThreadControl(self, pDebuggerThreadControl)
proc AddDebuggerSpecialThread*(self: ptr ICorConfiguration, dwSpecialThreadId: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddDebuggerSpecialThread(self, dwSpecialThreadId)
proc CreateLogicalThreadState*(self: ptr ICorRuntimeHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateLogicalThreadState(self)
proc DeleteLogicalThreadState*(self: ptr ICorRuntimeHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteLogicalThreadState(self)
proc SwitchInLogicalThreadState*(self: ptr ICorRuntimeHost, pFiberCookie: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SwitchInLogicalThreadState(self, pFiberCookie)
proc SwitchOutLogicalThreadState*(self: ptr ICorRuntimeHost, pFiberCookie: ptr ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SwitchOutLogicalThreadState(self, pFiberCookie)
proc LocksHeldByLogicalThread*(self: ptr ICorRuntimeHost, pCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LocksHeldByLogicalThread(self, pCount)
proc MapFile*(self: ptr ICorRuntimeHost, hFile: HANDLE, hMapAddress: ptr HMODULE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MapFile(self, hFile, hMapAddress)
proc GetConfiguration*(self: ptr ICorRuntimeHost, pConfiguration: ptr ptr ICorConfiguration): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConfiguration(self, pConfiguration)
proc Start*(self: ptr ICorRuntimeHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Start(self)
proc Stop*(self: ptr ICorRuntimeHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Stop(self)
proc CreateDomain*(self: ptr ICorRuntimeHost, pwzFriendlyName: LPCWSTR, pIdentityArray: ptr IUnknown, pAppDomain: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateDomain(self, pwzFriendlyName, pIdentityArray, pAppDomain)
proc GetDefaultDomain*(self: ptr ICorRuntimeHost, pAppDomain: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultDomain(self, pAppDomain)
proc EnumDomains*(self: ptr ICorRuntimeHost, hEnum: ptr HDOMAINENUM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumDomains(self, hEnum)
proc NextDomain*(self: ptr ICorRuntimeHost, hEnum: HDOMAINENUM, pAppDomain: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NextDomain(self, hEnum, pAppDomain)
proc CloseEnum*(self: ptr ICorRuntimeHost, hEnum: HDOMAINENUM): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CloseEnum(self, hEnum)
proc CreateDomainEx*(self: ptr ICorRuntimeHost, pwzFriendlyName: LPCWSTR, pSetup: ptr IUnknown, pEvidence: ptr IUnknown, pAppDomain: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateDomainEx(self, pwzFriendlyName, pSetup, pEvidence, pAppDomain)
proc CreateDomainSetup*(self: ptr ICorRuntimeHost, pAppDomainSetup: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateDomainSetup(self, pAppDomainSetup)
proc CreateEvidence*(self: ptr ICorRuntimeHost, pEvidence: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateEvidence(self, pEvidence)
proc UnloadDomain*(self: ptr ICorRuntimeHost, pAppDomain: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnloadDomain(self, pAppDomain)
proc CurrentDomain*(self: ptr ICorRuntimeHost, pAppDomain: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CurrentDomain(self, pAppDomain)
proc OnMemoryNotification*(self: ptr ICLRMemoryNotificationCallback, eMemoryAvailable: EMemoryAvailable): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnMemoryNotification(self, eMemoryAvailable)
proc Alloc*(self: ptr IHostMalloc, cbSize: SIZE_T, eCriticalLevel: EMemoryCriticalLevel, ppMem: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Alloc(self, cbSize, eCriticalLevel, ppMem)
proc DebugAlloc*(self: ptr IHostMalloc, cbSize: SIZE_T, eCriticalLevel: EMemoryCriticalLevel, pszFileName: ptr char, iLineNo: int32, ppMem: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DebugAlloc(self, cbSize, eCriticalLevel, pszFileName, iLineNo, ppMem)
proc Free*(self: ptr IHostMalloc, pMem: pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Free(self, pMem)
proc CreateMalloc*(self: ptr IHostMemoryManager, dwMallocType: DWORD, ppMalloc: ptr ptr IHostMalloc): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateMalloc(self, dwMallocType, ppMalloc)
proc VirtualAlloc*(self: ptr IHostMemoryManager, pAddress: pointer, dwSize: SIZE_T, flAllocationType: DWORD, flProtect: DWORD, eCriticalLevel: EMemoryCriticalLevel, ppMem: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.VirtualAlloc(self, pAddress, dwSize, flAllocationType, flProtect, eCriticalLevel, ppMem)
proc VirtualFree*(self: ptr IHostMemoryManager, lpAddress: LPVOID, dwSize: SIZE_T, dwFreeType: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.VirtualFree(self, lpAddress, dwSize, dwFreeType)
proc VirtualQuery*(self: ptr IHostMemoryManager, lpAddress: pointer, lpBuffer: pointer, dwLength: SIZE_T, pResult: ptr SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.VirtualQuery(self, lpAddress, lpBuffer, dwLength, pResult)
proc VirtualProtect*(self: ptr IHostMemoryManager, lpAddress: pointer, dwSize: SIZE_T, flNewProtect: DWORD, pflOldProtect: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.VirtualProtect(self, lpAddress, dwSize, flNewProtect, pflOldProtect)
proc GetMemoryLoad*(self: ptr IHostMemoryManager, pMemoryLoad: ptr DWORD, pAvailableBytes: ptr SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMemoryLoad(self, pMemoryLoad, pAvailableBytes)
proc RegisterMemoryNotificationCallback*(self: ptr IHostMemoryManager, pCallback: ptr ICLRMemoryNotificationCallback): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterMemoryNotificationCallback(self, pCallback)
proc NeedsVirtualAddressSpace*(self: ptr IHostMemoryManager, startAddress: LPVOID, size: SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NeedsVirtualAddressSpace(self, startAddress, size)
proc AcquiredVirtualAddressSpace*(self: ptr IHostMemoryManager, startAddress: LPVOID, size: SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AcquiredVirtualAddressSpace(self, startAddress, size)
proc ReleasedVirtualAddressSpace*(self: ptr IHostMemoryManager, startAddress: LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleasedVirtualAddressSpace(self, startAddress)
proc SwitchIn*(self: ptr ICLRTask, threadHandle: HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SwitchIn(self, threadHandle)
proc SwitchOut*(self: ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SwitchOut(self)
proc GetMemStats*(self: ptr ICLRTask, memUsage: ptr COR_GC_THREAD_STATS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMemStats(self, memUsage)
proc Reset*(self: ptr ICLRTask, fFull: BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self, fFull)
proc ExitTask*(self: ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExitTask(self)
proc Abort*(self: ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Abort(self)
proc RudeAbort*(self: ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RudeAbort(self)
proc NeedsPriorityScheduling*(self: ptr ICLRTask, pbNeedsPriorityScheduling: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NeedsPriorityScheduling(self, pbNeedsPriorityScheduling)
proc YieldTask*(self: ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.YieldTask(self)
proc LocksHeld*(self: ptr ICLRTask, pLockCount: ptr SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LocksHeld(self, pLockCount)
proc SetTaskIdentifier*(self: ptr ICLRTask, asked: TASKID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTaskIdentifier(self, asked)
proc BeginPreventAsyncAbort*(self: ptr ICLRTask2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginPreventAsyncAbort(self)
proc EndPreventAsyncAbort*(self: ptr ICLRTask2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndPreventAsyncAbort(self)
proc Start*(self: ptr IHostTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Start(self)
proc Alert*(self: ptr IHostTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Alert(self)
proc Join*(self: ptr IHostTask, dwMilliseconds: DWORD, option: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Join(self, dwMilliseconds, option)
proc SetPriority*(self: ptr IHostTask, newPriority: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPriority(self, newPriority)
proc GetPriority*(self: ptr IHostTask, pPriority: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPriority(self, pPriority)
proc SetCLRTask*(self: ptr IHostTask, pCLRTask: ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCLRTask(self, pCLRTask)
proc CreateTask*(self: ptr ICLRTaskManager, pTask: ptr ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateTask(self, pTask)
proc GetCurrentTask*(self: ptr ICLRTaskManager, pTask: ptr ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentTask(self, pTask)
proc SetUILocale*(self: ptr ICLRTaskManager, lcid: LCID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetUILocale(self, lcid)
proc SetLocale*(self: ptr ICLRTaskManager, lcid: LCID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLocale(self, lcid)
proc GetCurrentTaskType*(self: ptr ICLRTaskManager, pTaskType: ptr ETaskType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentTaskType(self, pTaskType)
proc GetCurrentTask*(self: ptr IHostTaskManager, pTask: ptr ptr IHostTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentTask(self, pTask)
proc CreateTask*(self: ptr IHostTaskManager, dwStackSize: DWORD, pStartAddress: LPTHREAD_START_ROUTINE, pParameter: PVOID, ppTask: ptr ptr IHostTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateTask(self, dwStackSize, pStartAddress, pParameter, ppTask)
proc Sleep*(self: ptr IHostTaskManager, dwMilliseconds: DWORD, option: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Sleep(self, dwMilliseconds, option)
proc SwitchToTask*(self: ptr IHostTaskManager, option: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SwitchToTask(self, option)
proc SetUILocale*(self: ptr IHostTaskManager, lcid: LCID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetUILocale(self, lcid)
proc SetLocale*(self: ptr IHostTaskManager, lcid: LCID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLocale(self, lcid)
proc CallNeedsHostHook*(self: ptr IHostTaskManager, target: SIZE_T, pbCallNeedsHostHook: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CallNeedsHostHook(self, target, pbCallNeedsHostHook)
proc LeaveRuntime*(self: ptr IHostTaskManager, target: SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LeaveRuntime(self, target)
proc EnterRuntime*(self: ptr IHostTaskManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnterRuntime(self)
proc ReverseLeaveRuntime*(self: ptr IHostTaskManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReverseLeaveRuntime(self)
proc ReverseEnterRuntime*(self: ptr IHostTaskManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReverseEnterRuntime(self)
proc BeginDelayAbort*(self: ptr IHostTaskManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginDelayAbort(self)
proc EndDelayAbort*(self: ptr IHostTaskManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndDelayAbort(self)
proc BeginThreadAffinity*(self: ptr IHostTaskManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginThreadAffinity(self)
proc EndThreadAffinity*(self: ptr IHostTaskManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndThreadAffinity(self)
proc SetStackGuarantee*(self: ptr IHostTaskManager, guarantee: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetStackGuarantee(self, guarantee)
proc GetStackGuarantee*(self: ptr IHostTaskManager, pGuarantee: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStackGuarantee(self, pGuarantee)
proc SetCLRTaskManager*(self: ptr IHostTaskManager, ppManager: ptr ICLRTaskManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCLRTaskManager(self, ppManager)
proc QueueUserWorkItem*(self: ptr IHostThreadpoolManager, Function: LPTHREAD_START_ROUTINE, Context: PVOID, Flags: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueueUserWorkItem(self, Function, Context, Flags)
proc SetMaxThreads*(self: ptr IHostThreadpoolManager, dwMaxWorkerThreads: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMaxThreads(self, dwMaxWorkerThreads)
proc GetMaxThreads*(self: ptr IHostThreadpoolManager, pdwMaxWorkerThreads: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMaxThreads(self, pdwMaxWorkerThreads)
proc GetAvailableThreads*(self: ptr IHostThreadpoolManager, pdwAvailableWorkerThreads: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAvailableThreads(self, pdwAvailableWorkerThreads)
proc SetMinThreads*(self: ptr IHostThreadpoolManager, dwMinIOCompletionThreads: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMinThreads(self, dwMinIOCompletionThreads)
proc GetMinThreads*(self: ptr IHostThreadpoolManager, pdwMinIOCompletionThreads: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMinThreads(self, pdwMinIOCompletionThreads)
proc OnComplete*(self: ptr ICLRIoCompletionManager, dwErrorCode: DWORD, NumberOfBytesTransferred: DWORD, pvOverlapped: pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnComplete(self, dwErrorCode, NumberOfBytesTransferred, pvOverlapped)
proc CreateIoCompletionPort*(self: ptr IHostIoCompletionManager, phPort: ptr HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateIoCompletionPort(self, phPort)
proc CloseIoCompletionPort*(self: ptr IHostIoCompletionManager, hPort: HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CloseIoCompletionPort(self, hPort)
proc SetMaxThreads*(self: ptr IHostIoCompletionManager, dwMaxIOCompletionThreads: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMaxThreads(self, dwMaxIOCompletionThreads)
proc GetMaxThreads*(self: ptr IHostIoCompletionManager, pdwMaxIOCompletionThreads: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMaxThreads(self, pdwMaxIOCompletionThreads)
proc GetAvailableThreads*(self: ptr IHostIoCompletionManager, pdwAvailableIOCompletionThreads: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAvailableThreads(self, pdwAvailableIOCompletionThreads)
proc GetHostOverlappedSize*(self: ptr IHostIoCompletionManager, pcbSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHostOverlappedSize(self, pcbSize)
proc SetCLRIoCompletionManager*(self: ptr IHostIoCompletionManager, pManager: ptr ICLRIoCompletionManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCLRIoCompletionManager(self, pManager)
proc InitializeHostOverlapped*(self: ptr IHostIoCompletionManager, pvOverlapped: pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeHostOverlapped(self, pvOverlapped)
proc Bind*(self: ptr IHostIoCompletionManager, hPort: HANDLE, hHandle: HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Bind(self, hPort, hHandle)
proc SetMinThreads*(self: ptr IHostIoCompletionManager, dwMinIOCompletionThreads: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMinThreads(self, dwMinIOCompletionThreads)
proc GetMinThreads*(self: ptr IHostIoCompletionManager, pdwMinIOCompletionThreads: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMinThreads(self, pdwMinIOCompletionThreads)
proc BeginConnection*(self: ptr ICLRDebugManager, dwConnectionId: CONNID, szConnectionName: ptr uint16): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginConnection(self, dwConnectionId, szConnectionName)
proc SetConnectionTasks*(self: ptr ICLRDebugManager, id: CONNID, dwCount: DWORD, ppCLRTask: ptr ptr ICLRTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetConnectionTasks(self, id, dwCount, ppCLRTask)
proc EndConnection*(self: ptr ICLRDebugManager, dwConnectionId: CONNID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndConnection(self, dwConnectionId)
proc SetDacl*(self: ptr ICLRDebugManager, pacl: PACL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDacl(self, pacl)
proc GetDacl*(self: ptr ICLRDebugManager, pacl: ptr PACL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDacl(self, pacl)
proc IsDebuggerAttached*(self: ptr ICLRDebugManager, pbAttached: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDebuggerAttached(self, pbAttached)
proc SetSymbolReadingPolicy*(self: ptr ICLRDebugManager, policy: ESymbolReadingPolicy): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSymbolReadingPolicy(self, policy)
proc GetBucketParametersForCurrentException*(self: ptr ICLRErrorReportingManager, pParams: ptr BucketParameters): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBucketParametersForCurrentException(self, pParams)
proc BeginCustomDump*(self: ptr ICLRErrorReportingManager, dwFlavor: ECustomDumpFlavor, dwNumItems: DWORD, items: ptr CustomDumpItem, dwReserved: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BeginCustomDump(self, dwFlavor, dwNumItems, items, dwReserved)
proc EndCustomDump*(self: ptr ICLRErrorReportingManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EndCustomDump(self)
proc Enter*(self: ptr IHostCrst, option: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Enter(self, option)
proc Leave*(self: ptr IHostCrst): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Leave(self)
proc TryEnter*(self: ptr IHostCrst, option: DWORD, pbSucceeded: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.TryEnter(self, option, pbSucceeded)
proc SetSpinCount*(self: ptr IHostCrst, dwSpinCount: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSpinCount(self, dwSpinCount)
proc Wait*(self: ptr IHostAutoEvent, dwMilliseconds: DWORD, option: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Wait(self, dwMilliseconds, option)
proc Set*(self: ptr IHostAutoEvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Set(self)
proc Wait*(self: ptr IHostManualEvent, dwMilliseconds: DWORD, option: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Wait(self, dwMilliseconds, option)
proc Reset*(self: ptr IHostManualEvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Set*(self: ptr IHostManualEvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Set(self)
proc Wait*(self: ptr IHostSemaphore, dwMilliseconds: DWORD, option: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Wait(self, dwMilliseconds, option)
proc ReleaseSemaphore*(self: ptr IHostSemaphore, lReleaseCount: LONG, lpPreviousCount: ptr LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ReleaseSemaphore(self, lReleaseCount, lpPreviousCount)
proc GetMonitorOwner*(self: ptr ICLRSyncManager, Cookie: SIZE_T, ppOwnerHostTask: ptr ptr IHostTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMonitorOwner(self, Cookie, ppOwnerHostTask)
proc CreateRWLockOwnerIterator*(self: ptr ICLRSyncManager, Cookie: SIZE_T, pIterator: ptr SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateRWLockOwnerIterator(self, Cookie, pIterator)
proc GetRWLockOwnerNext*(self: ptr ICLRSyncManager, Iterator: SIZE_T, ppOwnerHostTask: ptr ptr IHostTask): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRWLockOwnerNext(self, Iterator, ppOwnerHostTask)
proc DeleteRWLockOwnerIterator*(self: ptr ICLRSyncManager, Iterator: SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteRWLockOwnerIterator(self, Iterator)
proc SetCLRSyncManager*(self: ptr IHostSyncManager, pManager: ptr ICLRSyncManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCLRSyncManager(self, pManager)
proc CreateCrst*(self: ptr IHostSyncManager, ppCrst: ptr ptr IHostCrst): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateCrst(self, ppCrst)
proc CreateCrstWithSpinCount*(self: ptr IHostSyncManager, dwSpinCount: DWORD, ppCrst: ptr ptr IHostCrst): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateCrstWithSpinCount(self, dwSpinCount, ppCrst)
proc CreateAutoEvent*(self: ptr IHostSyncManager, ppEvent: ptr ptr IHostAutoEvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateAutoEvent(self, ppEvent)
proc CreateManualEvent*(self: ptr IHostSyncManager, bInitialState: BOOL, ppEvent: ptr ptr IHostManualEvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateManualEvent(self, bInitialState, ppEvent)
proc CreateMonitorEvent*(self: ptr IHostSyncManager, Cookie: SIZE_T, ppEvent: ptr ptr IHostAutoEvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateMonitorEvent(self, Cookie, ppEvent)
proc CreateRWLockWriterEvent*(self: ptr IHostSyncManager, Cookie: SIZE_T, ppEvent: ptr ptr IHostAutoEvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateRWLockWriterEvent(self, Cookie, ppEvent)
proc CreateRWLockReaderEvent*(self: ptr IHostSyncManager, bInitialState: BOOL, Cookie: SIZE_T, ppEvent: ptr ptr IHostManualEvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateRWLockReaderEvent(self, bInitialState, Cookie, ppEvent)
proc CreateSemaphore*(self: ptr IHostSyncManager, dwInitial: DWORD, dwMax: DWORD, ppSemaphore: ptr ptr IHostSemaphore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateSemaphore(self, dwInitial, dwMax, ppSemaphore)
proc SetDefaultAction*(self: ptr ICLRPolicyManager, operation: EClrOperation, action: EPolicyAction): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDefaultAction(self, operation, action)
proc SetTimeout*(self: ptr ICLRPolicyManager, operation: EClrOperation, dwMilliseconds: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTimeout(self, operation, dwMilliseconds)
proc SetActionOnTimeout*(self: ptr ICLRPolicyManager, operation: EClrOperation, action: EPolicyAction): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetActionOnTimeout(self, operation, action)
proc SetTimeoutAndAction*(self: ptr ICLRPolicyManager, operation: EClrOperation, dwMilliseconds: DWORD, action: EPolicyAction): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTimeoutAndAction(self, operation, dwMilliseconds, action)
proc SetActionOnFailure*(self: ptr ICLRPolicyManager, failure: EClrFailure, action: EPolicyAction): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetActionOnFailure(self, failure, action)
proc SetUnhandledExceptionPolicy*(self: ptr ICLRPolicyManager, policy: EClrUnhandledException): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetUnhandledExceptionPolicy(self, policy)
proc OnDefaultAction*(self: ptr IHostPolicyManager, operation: EClrOperation, action: EPolicyAction): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnDefaultAction(self, operation, action)
proc OnTimeout*(self: ptr IHostPolicyManager, operation: EClrOperation, action: EPolicyAction): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnTimeout(self, operation, action)
proc OnFailure*(self: ptr IHostPolicyManager, failure: EClrFailure, action: EPolicyAction): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnFailure(self, failure, action)
proc OnEvent*(self: ptr IActionOnCLREvent, event: EClrEvent, data: PVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OnEvent(self, event, data)
proc RegisterActionOnEvent*(self: ptr ICLROnEventManager, event: EClrEvent, pAction: ptr IActionOnCLREvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterActionOnEvent(self, event, pAction)
proc UnregisterActionOnEvent*(self: ptr ICLROnEventManager, event: EClrEvent, pAction: ptr IActionOnCLREvent): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnregisterActionOnEvent(self, event, pAction)
proc ThreadIsBlockingForSuspension*(self: ptr IHostGCManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ThreadIsBlockingForSuspension(self)
proc SuspensionStarting*(self: ptr IHostGCManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SuspensionStarting(self)
proc SuspensionEnding*(self: ptr IHostGCManager, Generation: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SuspensionEnding(self, Generation)
proc IsStringAssemblyReferenceInList*(self: ptr ICLRAssemblyReferenceList, pwzAssemblyName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsStringAssemblyReferenceInList(self, pwzAssemblyName)
proc IsAssemblyReferenceInList*(self: ptr ICLRAssemblyReferenceList, pName: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsAssemblyReferenceInList(self, pName)
proc Get*(self: ptr ICLRReferenceAssemblyEnum, dwIndex: DWORD, pwzBuffer: LPWSTR, pcchBufferSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Get(self, dwIndex, pwzBuffer, pcchBufferSize)
proc Get*(self: ptr ICLRProbingAssemblyEnum, dwIndex: DWORD, pwzBuffer: LPWSTR, pcchBufferSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Get(self, dwIndex, pwzBuffer, pcchBufferSize)
proc GetCLRAssemblyReferenceList*(self: ptr ICLRAssemblyIdentityManager, ppwzAssemblyReferences: ptr LPCWSTR, dwNumOfReferences: DWORD, ppReferenceList: ptr ptr ICLRAssemblyReferenceList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCLRAssemblyReferenceList(self, ppwzAssemblyReferences, dwNumOfReferences, ppReferenceList)
proc GetBindingIdentityFromFile*(self: ptr ICLRAssemblyIdentityManager, pwzFilePath: LPCWSTR, dwFlags: DWORD, pwzBuffer: LPWSTR, pcchBufferSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindingIdentityFromFile(self, pwzFilePath, dwFlags, pwzBuffer, pcchBufferSize)
proc GetBindingIdentityFromStream*(self: ptr ICLRAssemblyIdentityManager, pStream: ptr IStream, dwFlags: DWORD, pwzBuffer: LPWSTR, pcchBufferSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBindingIdentityFromStream(self, pStream, dwFlags, pwzBuffer, pcchBufferSize)
proc GetReferencedAssembliesFromFile*(self: ptr ICLRAssemblyIdentityManager, pwzFilePath: LPCWSTR, dwFlags: DWORD, pExcludeAssembliesList: ptr ICLRAssemblyReferenceList, ppReferenceEnum: ptr ptr ICLRReferenceAssemblyEnum): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetReferencedAssembliesFromFile(self, pwzFilePath, dwFlags, pExcludeAssembliesList, ppReferenceEnum)
proc GetReferencedAssembliesFromStream*(self: ptr ICLRAssemblyIdentityManager, pStream: ptr IStream, dwFlags: DWORD, pExcludeAssembliesList: ptr ICLRAssemblyReferenceList, ppReferenceEnum: ptr ptr ICLRReferenceAssemblyEnum): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetReferencedAssembliesFromStream(self, pStream, dwFlags, pExcludeAssembliesList, ppReferenceEnum)
proc GetProbingAssembliesFromReference*(self: ptr ICLRAssemblyIdentityManager, dwMachineType: DWORD, dwFlags: DWORD, pwzReferenceIdentity: LPCWSTR, ppProbingAssemblyEnum: ptr ptr ICLRProbingAssemblyEnum): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProbingAssembliesFromReference(self, dwMachineType, dwFlags, pwzReferenceIdentity, ppProbingAssemblyEnum)
proc IsStronglyNamed*(self: ptr ICLRAssemblyIdentityManager, pwzAssemblyIdentity: LPCWSTR, pbIsStronglyNamed: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsStronglyNamed(self, pwzAssemblyIdentity, pbIsStronglyNamed)
proc ModifyApplicationPolicy*(self: ptr ICLRHostBindingPolicyManager, pwzSourceAssemblyIdentity: LPCWSTR, pwzTargetAssemblyIdentity: LPCWSTR, pbApplicationPolicy: ptr BYTE, cbAppPolicySize: DWORD, dwPolicyModifyFlags: DWORD, pbNewApplicationPolicy: ptr BYTE, pcbNewAppPolicySize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ModifyApplicationPolicy(self, pwzSourceAssemblyIdentity, pwzTargetAssemblyIdentity, pbApplicationPolicy, cbAppPolicySize, dwPolicyModifyFlags, pbNewApplicationPolicy, pcbNewAppPolicySize)
proc EvaluatePolicy*(self: ptr ICLRHostBindingPolicyManager, pwzReferenceIdentity: LPCWSTR, pbApplicationPolicy: ptr BYTE, cbAppPolicySize: DWORD, pwzPostPolicyReferenceIdentity: LPWSTR, pcchPostPolicyReferenceIdentity: ptr DWORD, pdwPoliciesApplied: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EvaluatePolicy(self, pwzReferenceIdentity, pbApplicationPolicy, cbAppPolicySize, pwzPostPolicyReferenceIdentity, pcchPostPolicyReferenceIdentity, pdwPoliciesApplied)
proc Collect*(self: ptr ICLRGCManager, Generation: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Collect(self, Generation)
proc GetStats*(self: ptr ICLRGCManager, pStats: ptr COR_GC_STATS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStats(self, pStats)
proc SetGCStartupLimits*(self: ptr ICLRGCManager, SegmentSize: DWORD, MaxGen0Size: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGCStartupLimits(self, SegmentSize, MaxGen0Size)
proc SetGCStartupLimitsEx*(self: ptr ICLRGCManager2, SegmentSize: SIZE_T, MaxGen0Size: SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetGCStartupLimitsEx(self, SegmentSize, MaxGen0Size)
proc ProvideAssembly*(self: ptr IHostAssemblyStore, pBindInfo: ptr AssemblyBindInfo, pAssemblyId: ptr UINT64, pContext: ptr UINT64, ppStmAssemblyImage: ptr ptr IStream, ppStmPDB: ptr ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProvideAssembly(self, pBindInfo, pAssemblyId, pContext, ppStmAssemblyImage, ppStmPDB)
proc ProvideModule*(self: ptr IHostAssemblyStore, pBindInfo: ptr ModuleBindInfo, pdwModuleId: ptr DWORD, ppStmModuleImage: ptr ptr IStream, ppStmPDB: ptr ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProvideModule(self, pBindInfo, pdwModuleId, ppStmModuleImage, ppStmPDB)
proc GetNonHostStoreAssemblies*(self: ptr IHostAssemblyManager, ppReferenceList: ptr ptr ICLRAssemblyReferenceList): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNonHostStoreAssemblies(self, ppReferenceList)
proc GetAssemblyStore*(self: ptr IHostAssemblyManager, ppAssemblyStore: ptr ptr IHostAssemblyStore): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAssemblyStore(self, ppAssemblyStore)
proc GetHostManager*(self: ptr IHostControl, riid: REFIID, ppObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHostManager(self, riid, ppObject)
proc SetAppDomainManager*(self: ptr IHostControl, dwAppDomainID: DWORD, pUnkAppDomainManager: ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppDomainManager(self, dwAppDomainID, pUnkAppDomainManager)
proc GetCLRManager*(self: ptr ICLRControl, riid: REFIID, ppObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCLRManager(self, riid, ppObject)
proc SetAppDomainManagerType*(self: ptr ICLRControl, pwzAppDomainManagerAssembly: LPCWSTR, pwzAppDomainManagerType: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppDomainManagerType(self, pwzAppDomainManagerAssembly, pwzAppDomainManagerType)
proc Start*(self: ptr ICLRRuntimeHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Start(self)
proc Stop*(self: ptr ICLRRuntimeHost): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Stop(self)
proc SetHostControl*(self: ptr ICLRRuntimeHost, pHostControl: ptr IHostControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHostControl(self, pHostControl)
proc GetCLRControl*(self: ptr ICLRRuntimeHost, pCLRControl: ptr ptr ICLRControl): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCLRControl(self, pCLRControl)
proc UnloadAppDomain*(self: ptr ICLRRuntimeHost, dwAppDomainId: DWORD, fWaitUntilDone: BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.UnloadAppDomain(self, dwAppDomainId, fWaitUntilDone)
proc ExecuteInAppDomain*(self: ptr ICLRRuntimeHost, dwAppDomainId: DWORD, pCallback: FExecuteInAppDomainCallback, cookie: pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExecuteInAppDomain(self, dwAppDomainId, pCallback, cookie)
proc GetCurrentAppDomainId*(self: ptr ICLRRuntimeHost, pdwAppDomainId: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentAppDomainId(self, pdwAppDomainId)
proc ExecuteApplication*(self: ptr ICLRRuntimeHost, pwzAppFullName: LPCWSTR, dwManifestPaths: DWORD, ppwzManifestPaths: ptr LPCWSTR, dwActivationData: DWORD, ppwzActivationData: ptr LPCWSTR, pReturnValue: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExecuteApplication(self, pwzAppFullName, dwManifestPaths, ppwzManifestPaths, dwActivationData, ppwzActivationData, pReturnValue)
proc ExecuteInDefaultAppDomain*(self: ptr ICLRRuntimeHost, pwzAssemblyPath: LPCWSTR, pwzTypeName: LPCWSTR, pwzMethodName: LPCWSTR, pwzArgument: LPCWSTR, pReturnValue: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExecuteInDefaultAppDomain(self, pwzAssemblyPath, pwzTypeName, pwzMethodName, pwzArgument, pReturnValue)
proc SetProtectedCategories*(self: ptr ICLRHostProtectionManager, categories: EApiCategories): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetProtectedCategories(self, categories)
proc SetEagerSerializeGrantSets*(self: ptr ICLRHostProtectionManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetEagerSerializeGrantSets(self)
proc SetAppDomainManagerType*(self: ptr ICLRDomainManager, wszAppDomainManagerAssembly: LPCWSTR, wszAppDomainManagerType: LPCWSTR, dwInitializeDomainFlags: EInitializeNewDomainFlags): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppDomainManagerType(self, wszAppDomainManagerAssembly, wszAppDomainManagerType, dwInitializeDomainFlags)
proc SetPropertiesForDefaultAppDomain*(self: ptr ICLRDomainManager, nProperties: DWORD, pwszPropertyNames: ptr LPCWSTR, pwszPropertyValues: ptr LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPropertiesForDefaultAppDomain(self, nProperties, pwszPropertyNames, pwszPropertyValues)
proc GetNameCount*(self: ptr ITypeName, pCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNameCount(self, pCount)
proc GetNames*(self: ptr ITypeName, count: DWORD, rgbszNames: ptr BSTR, pCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNames(self, count, rgbszNames, pCount)
proc GetTypeArgumentCount*(self: ptr ITypeName, pCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeArgumentCount(self, pCount)
proc GetTypeArguments*(self: ptr ITypeName, count: DWORD, rgpArguments: ptr ptr ITypeName, pCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeArguments(self, count, rgpArguments, pCount)
proc GetModifierLength*(self: ptr ITypeName, pCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetModifierLength(self, pCount)
proc GetModifiers*(self: ptr ITypeName, count: DWORD, rgModifiers: ptr DWORD, pCount: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetModifiers(self, count, rgModifiers, pCount)
proc GetAssemblyName*(self: ptr ITypeName, rgbszAssemblyNames: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAssemblyName(self, rgbszAssemblyNames)
proc OpenGenericArguments*(self: ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenGenericArguments(self)
proc CloseGenericArguments*(self: ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CloseGenericArguments(self)
proc OpenGenericArgument*(self: ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenGenericArgument(self)
proc CloseGenericArgument*(self: ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CloseGenericArgument(self)
proc AddName*(self: ptr ITypeNameBuilder, szName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddName(self, szName)
proc AddPointer*(self: ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPointer(self)
proc AddByRef*(self: ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddByRef(self)
proc AddSzArray*(self: ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddSzArray(self)
proc AddArray*(self: ptr ITypeNameBuilder, rank: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddArray(self, rank)
proc AddAssemblySpec*(self: ptr ITypeNameBuilder, szAssemblySpec: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddAssemblySpec(self, szAssemblySpec)
proc ToString*(self: ptr ITypeNameBuilder, pszStringRepresentation: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ToString(self, pszStringRepresentation)
proc Clear*(self: ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clear(self)
proc ParseTypeName*(self: ptr ITypeNameFactory, szName: LPCWSTR, pError: ptr DWORD, ppTypeName: ptr ptr ITypeName): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ParseTypeName(self, szName, pError, ppTypeName)
proc GetTypeNameBuilder*(self: ptr ITypeNameFactory, ppTypeBuilder: ptr ptr ITypeNameBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeNameBuilder(self, ppTypeBuilder)
proc DoCallback*(self: ptr IApartmentCallback, pFunc: SIZE_T, pData: SIZE_T): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoCallback(self, pFunc, pData)
proc GetSerializedBuffer*(self: ptr IManagedObject, pBSTR: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSerializedBuffer(self, pBSTR)
proc GetObjectIdentity*(self: ptr IManagedObject, pBSTRGUID: ptr BSTR, AppDomainID: ptr int32, pCCW: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectIdentity(self, pBSTRGUID, AppDomainID, pCCW)
proc Autodone*(self: ptr ICatalogServices): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Autodone(self)
proc NotAutodone*(self: ptr ICatalogServices): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NotAutodone(self)
proc Capture*(self: ptr IHostSecurityContext, ppClonedContext: ptr ptr IHostSecurityContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Capture(self, ppClonedContext)
proc ImpersonateLoggedOnUser*(self: ptr IHostSecurityManager, hToken: HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ImpersonateLoggedOnUser(self, hToken)
proc RevertToSelf*(self: ptr IHostSecurityManager): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RevertToSelf(self)
proc OpenThreadToken*(self: ptr IHostSecurityManager, dwDesiredAccess: DWORD, bOpenAsSelf: BOOL, phThreadToken: ptr HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenThreadToken(self, dwDesiredAccess, bOpenAsSelf, phThreadToken)
proc SetThreadToken*(self: ptr IHostSecurityManager, hToken: HANDLE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetThreadToken(self, hToken)
proc GetSecurityContext*(self: ptr IHostSecurityManager, eContextType: EContextType, ppSecurityContext: ptr ptr IHostSecurityContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSecurityContext(self, eContextType, ppSecurityContext)
proc SetSecurityContext*(self: ptr IHostSecurityManager, eContextType: EContextType, pSecurityContext: ptr IHostSecurityContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSecurityContext(self, eContextType, pSecurityContext)
proc GetCurrentAllocated*(self: ptr ICLRAppDomainResourceMonitor, dwAppDomainId: DWORD, pBytesAllocated: ptr ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentAllocated(self, dwAppDomainId, pBytesAllocated)
proc GetCurrentSurvived*(self: ptr ICLRAppDomainResourceMonitor, dwAppDomainId: DWORD, pAppDomainBytesSurvived: ptr ULONGLONG, pTotalBytesSurvived: ptr ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentSurvived(self, dwAppDomainId, pAppDomainBytesSurvived, pTotalBytesSurvived)
proc GetCurrentCpuTime*(self: ptr ICLRAppDomainResourceMonitor, dwAppDomainId: DWORD, pMilliseconds: ptr ULONGLONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentCpuTime(self, dwAppDomainId, pMilliseconds)
proc GetRuntime*(self: ptr ICLRMetaHost, pwzVersion: LPCWSTR, riid: REFIID, ppRuntime: ptr LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRuntime(self, pwzVersion, riid, ppRuntime)
proc GetVersionFromFile*(self: ptr ICLRMetaHost, pwzFilePath: LPCWSTR, pwzBuffer: LPWSTR, pcchBuffer: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVersionFromFile(self, pwzFilePath, pwzBuffer, pcchBuffer)
proc EnumerateInstalledRuntimes*(self: ptr ICLRMetaHost, ppEnumerator: ptr ptr IEnumUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumerateInstalledRuntimes(self, ppEnumerator)
proc EnumerateLoadedRuntimes*(self: ptr ICLRMetaHost, hndProcess: HANDLE, ppEnumerator: ptr ptr IEnumUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EnumerateLoadedRuntimes(self, hndProcess, ppEnumerator)
proc RequestRuntimeLoadedNotification*(self: ptr ICLRMetaHost, pCallbackFunction: RuntimeLoadedCallbackFnPtr): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RequestRuntimeLoadedNotification(self, pCallbackFunction)
proc QueryLegacyV2RuntimeBinding*(self: ptr ICLRMetaHost, riid: REFIID, ppUnk: ptr LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryLegacyV2RuntimeBinding(self, riid, ppUnk)
proc ExitProcess*(self: ptr ICLRMetaHost, iExitCode: INT32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExitProcess(self, iExitCode)
proc GetRequestedRuntime*(self: ptr ICLRMetaHostPolicy, dwPolicyFlags: METAHOST_POLICY_FLAGS, pwzBinary: LPCWSTR, pCfgStream: ptr IStream, pwzVersion: LPWSTR, pcchVersion: ptr DWORD, pwzImageVersion: LPWSTR, pcchImageVersion: ptr DWORD, pdwConfigFlags: ptr DWORD, riid: REFIID, ppRuntime: ptr LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRequestedRuntime(self, dwPolicyFlags, pwzBinary, pCfgStream, pwzVersion, pcchVersion, pwzImageVersion, pcchImageVersion, pdwConfigFlags, riid, ppRuntime)
proc AttachProfiler*(self: ptr ICLRProfiling, dwProfileeProcessID: DWORD, dwMillisecondsMax: DWORD, pClsidProfiler: ptr CLSID, wszProfilerPath: LPCWSTR, pvClientData: pointer, cbClientData: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AttachProfiler(self, dwProfileeProcessID, dwMillisecondsMax, pClsidProfiler, wszProfilerPath, pvClientData, cbClientData)
proc ProvideLibrary*(self: ptr ICLRDebuggingLibraryProvider, pwszFileName: ptr WCHAR, dwTimestamp: DWORD, dwSizeOfImage: DWORD, phModule: ptr HMODULE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ProvideLibrary(self, pwszFileName, dwTimestamp, dwSizeOfImage, phModule)
proc OpenVirtualProcess*(self: ptr ICLRDebugging, moduleBaseAddress: ULONG64, pDataTarget: ptr IUnknown, pLibraryProvider: ptr ICLRDebuggingLibraryProvider, pMaxDebuggerSupportedVersion: ptr CLR_DEBUGGING_VERSION, riidProcess: REFIID, ppProcess: ptr ptr IUnknown, pVersion: ptr CLR_DEBUGGING_VERSION, pdwFlags: ptr CLR_DEBUGGING_PROCESS_FLAGS): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.OpenVirtualProcess(self, moduleBaseAddress, pDataTarget, pLibraryProvider, pMaxDebuggerSupportedVersion, riidProcess, ppProcess, pVersion, pdwFlags)
proc CanUnloadNow*(self: ptr ICLRDebugging, hModule: HMODULE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CanUnloadNow(self, hModule)
proc GetVersionString*(self: ptr ICLRRuntimeInfo, pwzBuffer: LPWSTR, pcchBuffer: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVersionString(self, pwzBuffer, pcchBuffer)
proc GetRuntimeDirectory*(self: ptr ICLRRuntimeInfo, pwzBuffer: LPWSTR, pcchBuffer: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRuntimeDirectory(self, pwzBuffer, pcchBuffer)
proc IsLoaded*(self: ptr ICLRRuntimeInfo, hndProcess: HANDLE, pbLoaded: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsLoaded(self, hndProcess, pbLoaded)
proc LoadErrorString*(self: ptr ICLRRuntimeInfo, iResourceID: UINT, pwzBuffer: LPWSTR, pcchBuffer: ptr DWORD, iLocaleID: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadErrorString(self, iResourceID, pwzBuffer, pcchBuffer, iLocaleID)
proc LoadLibrary*(self: ptr ICLRRuntimeInfo, pwzDllName: LPCWSTR, phndModule: ptr HMODULE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadLibrary(self, pwzDllName, phndModule)
proc GetProcAddress*(self: ptr ICLRRuntimeInfo, pszProcName: LPCSTR, ppProc: ptr LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProcAddress(self, pszProcName, ppProc)
proc GetInterface*(self: ptr ICLRRuntimeInfo, rclsid: REFCLSID, riid: REFIID, ppUnk: ptr LPVOID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInterface(self, rclsid, riid, ppUnk)
proc IsLoadable*(self: ptr ICLRRuntimeInfo, pbLoadable: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsLoadable(self, pbLoadable)
proc SetDefaultStartupFlags*(self: ptr ICLRRuntimeInfo, dwStartupFlags: DWORD, pwzHostConfigFile: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDefaultStartupFlags(self, dwStartupFlags, pwzHostConfigFile)
proc GetDefaultStartupFlags*(self: ptr ICLRRuntimeInfo, pdwStartupFlags: ptr DWORD, pwzHostConfigFile: LPWSTR, pcchHostConfigFile: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultStartupFlags(self, pdwStartupFlags, pwzHostConfigFile, pcchHostConfigFile)
proc BindAsLegacyV2Runtime*(self: ptr ICLRRuntimeInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BindAsLegacyV2Runtime(self)
proc IsStarted*(self: ptr ICLRRuntimeInfo, pbStarted: ptr BOOL, pdwStartupFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsStarted(self, pbStarted, pdwStartupFlags)
proc GetHashFromAssemblyFile*(self: ptr ICLRStrongName, pszFilePath: LPCSTR, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashFromAssemblyFile(self, pszFilePath, piHashAlg, pbHash, cchHash, pchHash)
proc GetHashFromAssemblyFileW*(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashFromAssemblyFileW(self, pwzFilePath, piHashAlg, pbHash, cchHash, pchHash)
proc GetHashFromBlob*(self: ptr ICLRStrongName, pbBlob: ptr BYTE, cchBlob: DWORD, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashFromBlob(self, pbBlob, cchBlob, piHashAlg, pbHash, cchHash, pchHash)
proc GetHashFromFile*(self: ptr ICLRStrongName, pszFilePath: LPCSTR, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashFromFile(self, pszFilePath, piHashAlg, pbHash, cchHash, pchHash)
proc GetHashFromFileW*(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashFromFileW(self, pwzFilePath, piHashAlg, pbHash, cchHash, pchHash)
proc GetHashFromHandle*(self: ptr ICLRStrongName, hFile: HANDLE, piHashAlg: ptr int32, pbHash: ptr BYTE, cchHash: DWORD, pchHash: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashFromHandle(self, hFile, piHashAlg, pbHash, cchHash, pchHash)
proc StrongNameCompareAssemblies*(self: ptr ICLRStrongName, pwzAssembly1: LPCWSTR, pwzAssembly2: LPCWSTR, pdwResult: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameCompareAssemblies(self, pwzAssembly1, pwzAssembly2, pdwResult)
proc StrongNameFreeBuffer*(self: ptr ICLRStrongName, pbMemory: ptr BYTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameFreeBuffer(self, pbMemory)
proc StrongNameGetBlob*(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, pbBlob: ptr BYTE, pcbBlob: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameGetBlob(self, pwzFilePath, pbBlob, pcbBlob)
proc StrongNameGetBlobFromImage*(self: ptr ICLRStrongName, pbBase: ptr BYTE, dwLength: DWORD, pbBlob: ptr BYTE, pcbBlob: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameGetBlobFromImage(self, pbBase, dwLength, pbBlob, pcbBlob)
proc StrongNameGetPublicKey*(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, ppbPublicKeyBlob: ptr ptr BYTE, pcbPublicKeyBlob: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameGetPublicKey(self, pwzKeyContainer, pbKeyBlob, cbKeyBlob, ppbPublicKeyBlob, pcbPublicKeyBlob)
proc StrongNameHashSize*(self: ptr ICLRStrongName, ulHashAlg: ULONG, pcbSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameHashSize(self, ulHashAlg, pcbSize)
proc StrongNameKeyDelete*(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameKeyDelete(self, pwzKeyContainer)
proc StrongNameKeyGen*(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR, dwFlags: DWORD, ppbKeyBlob: ptr ptr BYTE, pcbKeyBlob: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameKeyGen(self, pwzKeyContainer, dwFlags, ppbKeyBlob, pcbKeyBlob)
proc StrongNameKeyGenEx*(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR, dwFlags: DWORD, dwKeySize: DWORD, ppbKeyBlob: ptr ptr BYTE, pcbKeyBlob: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameKeyGenEx(self, pwzKeyContainer, dwFlags, dwKeySize, ppbKeyBlob, pcbKeyBlob)
proc StrongNameKeyInstall*(self: ptr ICLRStrongName, pwzKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameKeyInstall(self, pwzKeyContainer, pbKeyBlob, cbKeyBlob)
proc StrongNameSignatureGeneration*(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, pwzKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, ppbSignatureBlob: ptr ptr BYTE, pcbSignatureBlob: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameSignatureGeneration(self, pwzFilePath, pwzKeyContainer, pbKeyBlob, cbKeyBlob, ppbSignatureBlob, pcbSignatureBlob)
proc StrongNameSignatureGenerationEx*(self: ptr ICLRStrongName, wszFilePath: LPCWSTR, wszKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, ppbSignatureBlob: ptr ptr BYTE, pcbSignatureBlob: ptr ULONG, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameSignatureGenerationEx(self, wszFilePath, wszKeyContainer, pbKeyBlob, cbKeyBlob, ppbSignatureBlob, pcbSignatureBlob, dwFlags)
proc StrongNameSignatureSize*(self: ptr ICLRStrongName, pbPublicKeyBlob: ptr BYTE, cbPublicKeyBlob: ULONG, pcbSize: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameSignatureSize(self, pbPublicKeyBlob, cbPublicKeyBlob, pcbSize)
proc StrongNameSignatureVerification*(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, dwInFlags: DWORD, pdwOutFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameSignatureVerification(self, pwzFilePath, dwInFlags, pdwOutFlags)
proc StrongNameSignatureVerificationEx*(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, fForceVerification: BOOLEAN, pfWasVerified: ptr BOOLEAN): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameSignatureVerificationEx(self, pwzFilePath, fForceVerification, pfWasVerified)
proc StrongNameSignatureVerificationFromImage*(self: ptr ICLRStrongName, pbBase: ptr BYTE, dwLength: DWORD, dwInFlags: DWORD, pdwOutFlags: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameSignatureVerificationFromImage(self, pbBase, dwLength, dwInFlags, pdwOutFlags)
proc StrongNameTokenFromAssembly*(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, ppbStrongNameToken: ptr ptr BYTE, pcbStrongNameToken: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameTokenFromAssembly(self, pwzFilePath, ppbStrongNameToken, pcbStrongNameToken)
proc StrongNameTokenFromAssemblyEx*(self: ptr ICLRStrongName, pwzFilePath: LPCWSTR, ppbStrongNameToken: ptr ptr BYTE, pcbStrongNameToken: ptr ULONG, ppbPublicKeyBlob: ptr ptr BYTE, pcbPublicKeyBlob: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameTokenFromAssemblyEx(self, pwzFilePath, ppbStrongNameToken, pcbStrongNameToken, ppbPublicKeyBlob, pcbPublicKeyBlob)
proc StrongNameTokenFromPublicKey*(self: ptr ICLRStrongName, pbPublicKeyBlob: ptr BYTE, cbPublicKeyBlob: ULONG, ppbStrongNameToken: ptr ptr BYTE, pcbStrongNameToken: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameTokenFromPublicKey(self, pbPublicKeyBlob, cbPublicKeyBlob, ppbStrongNameToken, pcbStrongNameToken)
proc StrongNameGetPublicKeyEx*(self: ptr ICLRStrongName2, pwzKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, ppbPublicKeyBlob: ptr ptr BYTE, pcbPublicKeyBlob: ptr ULONG, uHashAlgId: ULONG, uReserved: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameGetPublicKeyEx(self, pwzKeyContainer, pbKeyBlob, cbKeyBlob, ppbPublicKeyBlob, pcbPublicKeyBlob, uHashAlgId, uReserved)
proc StrongNameSignatureVerificationEx2*(self: ptr ICLRStrongName2, wszFilePath: LPCWSTR, fForceVerification: BOOLEAN, pbEcmaPublicKey: ptr BYTE, cbEcmaPublicKey: DWORD, pfWasVerified: ptr BOOLEAN): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameSignatureVerificationEx2(self, wszFilePath, fForceVerification, pbEcmaPublicKey, cbEcmaPublicKey, pfWasVerified)
proc StrongNameDigestGenerate*(self: ptr ICLRStrongName3, wszFilePath: LPCWSTR, ppbDigestBlob: ptr ptr BYTE, pcbDigestBlob: ptr ULONG, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameDigestGenerate(self, wszFilePath, ppbDigestBlob, pcbDigestBlob, dwFlags)
proc StrongNameDigestSign*(self: ptr ICLRStrongName3, wszKeyContainer: LPCWSTR, pbKeyBlob: ptr BYTE, cbKeyBlob: ULONG, pbDigestBlob: ptr BYTE, cbDigestBlob: ULONG, hashAlgId: DWORD, ppbSignatureBlob: ptr ptr BYTE, pcbSignatureBlob: ptr ULONG, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameDigestSign(self, wszKeyContainer, pbKeyBlob, cbKeyBlob, pbDigestBlob, cbDigestBlob, hashAlgId, ppbSignatureBlob, pcbSignatureBlob, dwFlags)
proc StrongNameDigestEmbed*(self: ptr ICLRStrongName3, wszFilePath: LPCWSTR, pbSignatureBlob: ptr BYTE, cbSignatureBlob: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StrongNameDigestEmbed(self, wszFilePath, pbSignatureBlob, cbSignatureBlob)
proc get_ToString*(self: ptr IObject, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ToString(self, pRetVal)
proc Equals*(self: ptr IObject, obj: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Equals(self, obj, pRetVal)
proc GetHashCode*(self: ptr IObject, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashCode(self, pRetVal)
proc GetType*(self: ptr IObject, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType(self, pRetVal)
proc GetTypeInfoCount*(self: ptr IType, pcTInfo: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfoCount(self, pcTInfo)
proc GetTypeInfo*(self: ptr IType, iTInfo: int32, lcid: int32, ppTInfo: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypeInfo(self, iTInfo, lcid, ppTInfo)
proc GetIDsOfNames*(self: ptr IType, riid: ptr GUID, rgszNames: int32, cNames: int32, lcid: int32, rgDispId: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIDsOfNames(self, riid, rgszNames, cNames, lcid, rgDispId)
proc Invoke*(self: ptr IType, dispIdMember: int32, riid: ptr GUID, lcid: int32, wFlags: int16, pDispParams: int32, pVarResult: int32, pExcepInfo: int32, puArgErr: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
proc get_ToString*(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ToString(self, pRetVal)
proc Equals*(self: ptr IType, other: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Equals(self, other, pRetVal)
proc GetHashCode*(self: ptr IType, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashCode(self, pRetVal)
proc GetType*(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType(self, pRetVal)
proc get_MemberType*(self: ptr IType, pRetVal: ptr MemberTypes): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_MemberType(self, pRetVal)
proc get_name*(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_name(self, pRetVal)
proc get_DeclaringType*(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DeclaringType(self, pRetVal)
proc get_ReflectedType*(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ReflectedType(self, pRetVal)
proc GetCustomAttributes*(self: ptr IType, attributeType: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCustomAttributes(self, attributeType, inherit, pRetVal)
proc GetCustomAttributes_2*(self: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCustomAttributes_2(self, inherit, pRetVal)
proc IsDefined*(self: ptr IType, attributeType: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDefined(self, attributeType, inherit, pRetVal)
proc get_Guid*(self: ptr IType, pRetVal: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Guid(self, pRetVal)
proc get_Module*(self: ptr IType, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Module(self, pRetVal)
proc getIAssembly*(self: ptr IType, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.getIAssembly(self, pRetVal)
proc get_TypeHandle*(self: ptr IType, pRetVal: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TypeHandle(self, pRetVal)
proc get_FullName*(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FullName(self, pRetVal)
proc get_Namespace*(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Namespace(self, pRetVal)
proc get_AssemblyQualifiedName*(self: ptr IType, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_AssemblyQualifiedName(self, pRetVal)
proc GetArrayRank*(self: ptr IType, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetArrayRank(self, pRetVal)
proc get_BaseType*(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_BaseType(self, pRetVal)
proc GetConstructors*(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConstructors(self, bindingAttr, pRetVal)
proc GetInterface*(self: ptr IType, name: BSTR, ignoreCase: VARIANT_BOOL, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInterface(self, name, ignoreCase, pRetVal)
proc GetInterfaces*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInterfaces(self, pRetVal)
proc FindInterfaces*(self: ptr IType, filter: POBJECT, filterCriteria: VARIANT, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindInterfaces(self, filter, filterCriteria, pRetVal)
proc GetEvent*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEvent(self, name, bindingAttr, pRetVal)
proc GetEvents*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEvents(self, pRetVal)
proc GetEvents_2*(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEvents_2(self, bindingAttr, pRetVal)
proc GetNestedTypes*(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNestedTypes(self, bindingAttr, pRetVal)
proc GetNestedType*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNestedType(self, name, bindingAttr, pRetVal)
proc GetMember*(self: ptr IType, name: BSTR, Type: MemberTypes, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMember(self, name, Type, bindingAttr, pRetVal)
proc GetDefaultMembers*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDefaultMembers(self, pRetVal)
proc FindMembers*(self: ptr IType, MemberType: MemberTypes, bindingAttr: BindingFlags, filter: POBJECT, filterCriteria: VARIANT, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindMembers(self, MemberType, bindingAttr, filter, filterCriteria, pRetVal)
proc GetElementType*(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetElementType(self, pRetVal)
proc IsSubclassOf*(self: ptr IType, c: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsSubclassOf(self, c, pRetVal)
proc IsInstanceOfType*(self: ptr IType, o: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsInstanceOfType(self, o, pRetVal)
proc IsAssignableFrom*(self: ptr IType, c: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsAssignableFrom(self, c, pRetVal)
proc GetInterfaceMap*(self: ptr IType, interfaceType: ptr IType, pRetVal: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInterfaceMap(self, interfaceType, pRetVal)
proc GetMethod*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, Binder: POBJECT, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMethod(self, name, bindingAttr, Binder, types, modifiers, pRetVal)
proc GetMethod_2*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMethod_2(self, name, bindingAttr, pRetVal)
proc GetMethods*(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMethods(self, bindingAttr, pRetVal)
proc GetField*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetField(self, name, bindingAttr, pRetVal)
proc GetFields*(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFields(self, bindingAttr, pRetVal)
proc GetProperty*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, name, bindingAttr, pRetVal)
proc GetProperty_2*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, Binder: POBJECT, returnType: ptr IType, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty_2(self, name, bindingAttr, Binder, returnType, types, modifiers, pRetVal)
proc GetProperties*(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperties(self, bindingAttr, pRetVal)
proc GetMember_2*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMember_2(self, name, bindingAttr, pRetVal)
proc GetMembers*(self: ptr IType, bindingAttr: BindingFlags, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMembers(self, bindingAttr, pRetVal)
proc InvokeMember*(self: ptr IType, name: BSTR, invokeAttr: BindingFlags, Binder: POBJECT, Target: VARIANT, args: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, culture: POBJECT, namedParameters: ptr SAFEARRAY, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeMember(self, name, invokeAttr, Binder, Target, args, modifiers, culture, namedParameters, pRetVal)
proc get_UnderlyingSystemType*(self: ptr IType, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_UnderlyingSystemType(self, pRetVal)
proc InvokeMember_2*(self: ptr IType, name: BSTR, invokeAttr: BindingFlags, Binder: POBJECT, Target: VARIANT, args: ptr SAFEARRAY, culture: POBJECT, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeMember_2(self, name, invokeAttr, Binder, Target, args, culture, pRetVal)
proc InvokeMember_3*(self: ptr IType, name: BSTR, invokeAttr: BindingFlags, Binder: POBJECT, Target: VARIANT, args: ptr SAFEARRAY, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InvokeMember_3(self, name, invokeAttr, Binder, Target, args, pRetVal)
proc GetConstructor*(self: ptr IType, bindingAttr: BindingFlags, Binder: POBJECT, callConvention: CallingConventions, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConstructor(self, bindingAttr, Binder, callConvention, types, modifiers, pRetVal)
proc GetConstructor_2*(self: ptr IType, bindingAttr: BindingFlags, Binder: POBJECT, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConstructor_2(self, bindingAttr, Binder, types, modifiers, pRetVal)
proc GetConstructor_3*(self: ptr IType, types: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConstructor_3(self, types, pRetVal)
proc GetConstructors_2*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConstructors_2(self, pRetVal)
proc get_TypeInitializer*(self: ptr IType, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TypeInitializer(self, pRetVal)
proc GetMethod_3*(self: ptr IType, name: BSTR, bindingAttr: BindingFlags, Binder: POBJECT, callConvention: CallingConventions, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMethod_3(self, name, bindingAttr, Binder, callConvention, types, modifiers, pRetVal)
proc GetMethod_4*(self: ptr IType, name: BSTR, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMethod_4(self, name, types, modifiers, pRetVal)
proc GetMethod_5*(self: ptr IType, name: BSTR, types: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMethod_5(self, name, types, pRetVal)
proc GetMethod_6*(self: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMethod_6(self, name, pRetVal)
proc GetMethods_2*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMethods_2(self, pRetVal)
proc GetField_2*(self: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetField_2(self, name, pRetVal)
proc GetFields_2*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFields_2(self, pRetVal)
proc GetInterface_2*(self: ptr IType, name: BSTR, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInterface_2(self, name, pRetVal)
proc GetEvent_2*(self: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEvent_2(self, name, pRetVal)
proc GetProperty_3*(self: ptr IType, name: BSTR, returnType: ptr IType, types: ptr SAFEARRAY, modifiers: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty_3(self, name, returnType, types, modifiers, pRetVal)
proc GetProperty_4*(self: ptr IType, name: BSTR, returnType: ptr IType, types: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty_4(self, name, returnType, types, pRetVal)
proc GetProperty_5*(self: ptr IType, name: BSTR, types: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty_5(self, name, types, pRetVal)
proc GetProperty_6*(self: ptr IType, name: BSTR, returnType: ptr IType, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty_6(self, name, returnType, pRetVal)
proc GetProperty_7*(self: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty_7(self, name, pRetVal)
proc GetProperties_2*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperties_2(self, pRetVal)
proc GetNestedTypes_2*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNestedTypes_2(self, pRetVal)
proc GetNestedType_2*(self: ptr IType, name: BSTR, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNestedType_2(self, name, pRetVal)
proc GetMember_3*(self: ptr IType, name: BSTR, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMember_3(self, name, pRetVal)
proc GetMembers_2*(self: ptr IType, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMembers_2(self, pRetVal)
proc get_Attributes*(self: ptr IType, pRetVal: ptr TypeAttributes): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Attributes(self, pRetVal)
proc get_IsNotPublic*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsNotPublic(self, pRetVal)
proc get_IsPublic*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsPublic(self, pRetVal)
proc get_IsNestedPublic*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsNestedPublic(self, pRetVal)
proc get_IsNestedPrivate*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsNestedPrivate(self, pRetVal)
proc get_IsNestedFamily*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsNestedFamily(self, pRetVal)
proc get_IsNestedAssembly*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsNestedAssembly(self, pRetVal)
proc get_IsNestedFamANDAssem*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsNestedFamANDAssem(self, pRetVal)
proc get_IsNestedFamORAssem*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsNestedFamORAssem(self, pRetVal)
proc get_IsAutoLayout*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsAutoLayout(self, pRetVal)
proc get_IsLayoutSequential*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsLayoutSequential(self, pRetVal)
proc get_IsExplicitLayout*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsExplicitLayout(self, pRetVal)
proc get_IsClass*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsClass(self, pRetVal)
proc get_IsInterface*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsInterface(self, pRetVal)
proc get_IsValueType*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsValueType(self, pRetVal)
proc get_IsAbstract*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsAbstract(self, pRetVal)
proc get_IsSealed*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsSealed(self, pRetVal)
proc get_IsEnum*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsEnum(self, pRetVal)
proc get_IsSpecialName*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsSpecialName(self, pRetVal)
proc get_IsImport*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsImport(self, pRetVal)
proc get_IsSerializable*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsSerializable(self, pRetVal)
proc get_IsAnsiClass*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsAnsiClass(self, pRetVal)
proc get_IsUnicodeClass*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsUnicodeClass(self, pRetVal)
proc get_IsAutoClass*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsAutoClass(self, pRetVal)
proc get_IsArray*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsArray(self, pRetVal)
proc get_IsByRef*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsByRef(self, pRetVal)
proc get_IsPointer*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsPointer(self, pRetVal)
proc get_IsPrimitive*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsPrimitive(self, pRetVal)
proc get_IsCOMObject*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsCOMObject(self, pRetVal)
proc get_HasElementType*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_HasElementType(self, pRetVal)
proc get_IsContextful*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsContextful(self, pRetVal)
proc get_IsMarshalByRef*(self: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsMarshalByRef(self, pRetVal)
proc Equals_2*(self: ptr IType, o: ptr IType, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Equals_2(self, o, pRetVal)
proc get_ApplicationBase*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ApplicationBase(self, pRetVal)
proc put_ApplicationBase*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ApplicationBase(self, pRetVal)
proc get_ApplicationName*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ApplicationName(self, pRetVal)
proc put_ApplicationName*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ApplicationName(self, pRetVal)
proc get_CachePath*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachePath(self, pRetVal)
proc put_CachePath*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_CachePath(self, pRetVal)
proc get_ConfigurationFile*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ConfigurationFile(self, pRetVal)
proc put_ConfigurationFile*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ConfigurationFile(self, pRetVal)
proc get_DynamicBase*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DynamicBase(self, pRetVal)
proc put_DynamicBase*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_DynamicBase(self, pRetVal)
proc get_LicenseFile*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_LicenseFile(self, pRetVal)
proc put_LicenseFile*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_LicenseFile(self, pRetVal)
proc get_PrivateBinPath*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_PrivateBinPath(self, pRetVal)
proc put_PrivateBinPath*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_PrivateBinPath(self, pRetVal)
proc get_PrivateBinPathProbe*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_PrivateBinPathProbe(self, pRetVal)
proc put_PrivateBinPathProbe*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_PrivateBinPathProbe(self, pRetVal)
proc get_ShadowCopyDirectories*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ShadowCopyDirectories(self, pRetVal)
proc put_ShadowCopyDirectories*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ShadowCopyDirectories(self, pRetVal)
proc get_ShadowCopyFiles*(self: ptr IAppDomainSetup, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ShadowCopyFiles(self, pRetVal)
proc put_ShadowCopyFiles*(self: ptr IAppDomainSetup, pRetVal: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ShadowCopyFiles(self, pRetVal)
proc get_ToString*(self: ptr ObjectHandle, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ToString(self, pRetVal)
proc Equals*(self: ptr ObjectHandle, obj: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Equals(self, obj, pRetVal)
proc GetHashCode*(self: ptr ObjectHandle, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashCode(self, pRetVal)
proc GetType*(self: ptr ObjectHandle, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType(self, pRetVal)
proc GetLifetimeService*(self: ptr ObjectHandle, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLifetimeService(self, pRetVal)
proc InitializeLifetimeService*(self: ptr ObjectHandle, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeLifetimeService(self, pRetVal)
proc CreateObjRef*(self: ptr ObjectHandle, requestedType: ptr IType, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateObjRef(self, requestedType, pRetVal)
proc Unwrap*(self: ptr ObjectHandle, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Unwrap(self, pRetVal)
proc get_ToString*(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ToString(self, pRetVal)
proc Equals*(self: ptr AppDomain, other: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Equals(self, other, pRetVal)
proc GetHashCode*(self: ptr AppDomain, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashCode(self, pRetVal)
proc GetType*(self: ptr AppDomain, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType(self, pRetVal)
proc InitializeLifetimeService*(self: ptr AppDomain, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeLifetimeService(self, pRetVal)
proc GetLifetimeService*(self: ptr AppDomain, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLifetimeService(self, pRetVal)
proc get_Evidence*(self: ptr AppDomain, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Evidence(self, pRetVal)
proc add_DomainUnload*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.add_DomainUnload(self, value)
proc remove_DomainUnload*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.remove_DomainUnload(self, value)
proc add_AssemblyLoad*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.add_AssemblyLoad(self, value)
proc remove_AssemblyLoad*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.remove_AssemblyLoad(self, value)
proc add_ProcessExit*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.add_ProcessExit(self, value)
proc remove_ProcessExit*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.remove_ProcessExit(self, value)
proc add_TypeResolve*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.add_TypeResolve(self, value)
proc remove_TypeResolve*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.remove_TypeResolve(self, value)
proc add_ResourceResolve*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.add_ResourceResolve(self, value)
proc remove_ResourceResolve*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.remove_ResourceResolve(self, value)
proc add_AssemblyResolve*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.add_AssemblyResolve(self, value)
proc remove_AssemblyResolve*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.remove_AssemblyResolve(self, value)
proc add_UnhandledException*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.add_UnhandledException(self, value)
proc remove_UnhandledException*(self: ptr AppDomain, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.remove_UnhandledException(self, value)
proc DefineDynamicAssembly*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly(self, name, access, pRetVal)
proc DefineDynamicAssembly_2*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly_2(self, name, access, dir, pRetVal)
proc DefineDynamicAssembly_3*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, Evidence: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly_3(self, name, access, Evidence, pRetVal)
proc DefineDynamicAssembly_4*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly_4(self, name, access, requiredPermissions, optionalPermissions, refusedPermissions, pRetVal)
proc DefineDynamicAssembly_5*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, Evidence: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly_5(self, name, access, dir, Evidence, pRetVal)
proc DefineDynamicAssembly_6*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly_6(self, name, access, dir, requiredPermissions, optionalPermissions, refusedPermissions, pRetVal)
proc DefineDynamicAssembly_7*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, Evidence: POBJECT, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly_7(self, name, access, Evidence, requiredPermissions, optionalPermissions, refusedPermissions, pRetVal)
proc DefineDynamicAssembly_8*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, Evidence: POBJECT, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly_8(self, name, access, dir, Evidence, requiredPermissions, optionalPermissions, refusedPermissions, pRetVal)
proc DefineDynamicAssembly_9*(self: ptr AppDomain, name: POBJECT, access: AssemblyBuilderAccess, dir: BSTR, Evidence: POBJECT, requiredPermissions: POBJECT, optionalPermissions: POBJECT, refusedPermissions: POBJECT, IsSynchronized: VARIANT_BOOL, pRetVal: ptr ptr AssemblyBuilder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DefineDynamicAssembly_9(self, name, access, dir, Evidence, requiredPermissions, optionalPermissions, refusedPermissions, IsSynchronized, pRetVal)
proc CreateInstance*(self: ptr AppDomain, AssemblyName: BSTR, typeName: BSTR, pRetVal: ptr ptr ObjectHandle): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance(self, AssemblyName, typeName, pRetVal)
proc CreateInstanceFrom*(self: ptr AppDomain, assemblyFile: BSTR, typeName: BSTR, pRetVal: ptr ptr ObjectHandle): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstanceFrom(self, assemblyFile, typeName, pRetVal)
proc CreateInstance_2*(self: ptr AppDomain, AssemblyName: BSTR, typeName: BSTR, activationAttributes: ptr SAFEARRAY, pRetVal: ptr ptr ObjectHandle): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance_2(self, AssemblyName, typeName, activationAttributes, pRetVal)
proc CreateInstanceFrom_2*(self: ptr AppDomain, assemblyFile: BSTR, typeName: BSTR, activationAttributes: ptr SAFEARRAY, pRetVal: ptr ptr ObjectHandle): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstanceFrom_2(self, assemblyFile, typeName, activationAttributes, pRetVal)
proc CreateInstance_3*(self: ptr AppDomain, AssemblyName: BSTR, typeName: BSTR, ignoreCase: VARIANT_BOOL, bindingAttr: BindingFlags, Binder: POBJECT, args: ptr SAFEARRAY, culture: POBJECT, activationAttributes: ptr SAFEARRAY, securityAttributes: POBJECT, pRetVal: ptr ptr ObjectHandle): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance_3(self, AssemblyName, typeName, ignoreCase, bindingAttr, Binder, args, culture, activationAttributes, securityAttributes, pRetVal)
proc CreateInstanceFrom_3*(self: ptr AppDomain, assemblyFile: BSTR, typeName: BSTR, ignoreCase: VARIANT_BOOL, bindingAttr: BindingFlags, Binder: POBJECT, args: ptr SAFEARRAY, culture: POBJECT, activationAttributes: ptr SAFEARRAY, securityAttributes: POBJECT, pRetVal: ptr ptr ObjectHandle): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstanceFrom_3(self, assemblyFile, typeName, ignoreCase, bindingAttr, Binder, args, culture, activationAttributes, securityAttributes, pRetVal)
proc Load*(self: ptr AppDomain, assemblyRef: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load(self, assemblyRef, pRetVal)
proc Load_2*(self: ptr AppDomain, assemblyString: BSTR, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load_2(self, assemblyString, pRetVal)
proc Load_3*(self: ptr AppDomain, rawAssembly: ptr SAFEARRAY, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load_3(self, rawAssembly, pRetVal)
proc Load_4*(self: ptr AppDomain, rawAssembly: ptr SAFEARRAY, rawSymbolStore: ptr SAFEARRAY, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load_4(self, rawAssembly, rawSymbolStore, pRetVal)
proc Load_5*(self: ptr AppDomain, rawAssembly: ptr SAFEARRAY, rawSymbolStore: ptr SAFEARRAY, securityEvidence: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load_5(self, rawAssembly, rawSymbolStore, securityEvidence, pRetVal)
proc Load_6*(self: ptr AppDomain, assemblyRef: POBJECT, assemblySecurity: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load_6(self, assemblyRef, assemblySecurity, pRetVal)
proc Load_7*(self: ptr AppDomain, assemblyString: BSTR, assemblySecurity: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Load_7(self, assemblyString, assemblySecurity, pRetVal)
proc ExecuteAssembly*(self: ptr AppDomain, assemblyFile: BSTR, assemblySecurity: POBJECT, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExecuteAssembly(self, assemblyFile, assemblySecurity, pRetVal)
proc ExecuteAssembly_2*(self: ptr AppDomain, assemblyFile: BSTR, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExecuteAssembly_2(self, assemblyFile, pRetVal)
proc ExecuteAssembly_3*(self: ptr AppDomain, assemblyFile: BSTR, assemblySecurity: POBJECT, args: ptr SAFEARRAY, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExecuteAssembly_3(self, assemblyFile, assemblySecurity, args, pRetVal)
proc get_FriendlyName*(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FriendlyName(self, pRetVal)
proc get_BaseDirectory*(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_BaseDirectory(self, pRetVal)
proc get_RelativeSearchPath*(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_RelativeSearchPath(self, pRetVal)
proc get_ShadowCopyFiles*(self: ptr AppDomain, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ShadowCopyFiles(self, pRetVal)
proc GetAssemblies*(self: ptr AppDomain, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAssemblies(self, pRetVal)
proc AppendPrivatePath*(self: ptr AppDomain, Path: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AppendPrivatePath(self, Path)
proc ClearPrivatePath*(self: ptr AppDomain): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearPrivatePath(self)
proc SetShadowCopyPath*(self: ptr AppDomain, s: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetShadowCopyPath(self, s)
proc ClearShadowCopyPath*(self: ptr AppDomain): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearShadowCopyPath(self)
proc SetCachePath*(self: ptr AppDomain, s: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCachePath(self, s)
proc SetData*(self: ptr AppDomain, name: BSTR, data: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetData(self, name, data)
proc GetData*(self: ptr AppDomain, name: BSTR, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetData(self, name, pRetVal)
proc SetAppDomainPolicy*(self: ptr AppDomain, domainPolicy: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetAppDomainPolicy(self, domainPolicy)
proc SetThreadPrincipal*(self: ptr AppDomain, principal: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetThreadPrincipal(self, principal)
proc SetPrincipalPolicy*(self: ptr AppDomain, policy: PrincipalPolicy): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPrincipalPolicy(self, policy)
proc DoCallBack*(self: ptr AppDomain, theDelegate: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoCallBack(self, theDelegate)
proc get_DynamicDirectory*(self: ptr AppDomain, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DynamicDirectory(self, pRetVal)
proc get_ToString*(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ToString(self, pRetVal)
proc Equals*(self: ptr IAssembly, other: VARIANT, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Equals(self, other, pRetVal)
proc GetHashCode*(self: ptr IAssembly, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetHashCode(self, pRetVal)
proc GetType*(self: ptr IAssembly, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType(self, pRetVal)
proc get_CodeBase*(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CodeBase(self, pRetVal)
proc get_EscapedCodeBase*(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_EscapedCodeBase(self, pRetVal)
proc GetName*(self: ptr IAssembly, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetName(self, pRetVal)
proc GetName_2*(self: ptr IAssembly, copiedName: VARIANT_BOOL, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetName_2(self, copiedName, pRetVal)
proc get_FullName*(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FullName(self, pRetVal)
proc get_EntryPoint*(self: ptr IAssembly, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_EntryPoint(self, pRetVal)
proc GetType_2*(self: ptr IAssembly, name: BSTR, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType_2(self, name, pRetVal)
proc GetType_3*(self: ptr IAssembly, name: BSTR, throwOnError: VARIANT_BOOL, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType_3(self, name, throwOnError, pRetVal)
proc GetExportedTypes*(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExportedTypes(self, pRetVal)
proc GetTypes*(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTypes(self, pRetVal)
proc GetManifestResourceStream*(self: ptr IAssembly, Type: ptr IType, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetManifestResourceStream(self, Type, name, pRetVal)
proc GetManifestResourceStream_2*(self: ptr IAssembly, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetManifestResourceStream_2(self, name, pRetVal)
proc GetFile*(self: ptr IAssembly, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFile(self, name, pRetVal)
proc GetFiles*(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFiles(self, pRetVal)
proc GetFiles_2*(self: ptr IAssembly, getResourceModules: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFiles_2(self, getResourceModules, pRetVal)
proc GetManifestResourceNames*(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetManifestResourceNames(self, pRetVal)
proc GetManifestResourceInfo*(self: ptr IAssembly, resourceName: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetManifestResourceInfo(self, resourceName, pRetVal)
proc get_Location*(self: ptr IAssembly, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Location(self, pRetVal)
proc get_Evidence*(self: ptr IAssembly, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Evidence(self, pRetVal)
proc GetCustomAttributes*(self: ptr IAssembly, attributeType: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCustomAttributes(self, attributeType, inherit, pRetVal)
proc GetCustomAttributes_2*(self: ptr IAssembly, inherit: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCustomAttributes_2(self, inherit, pRetVal)
proc IsDefined*(self: ptr IAssembly, attributeType: ptr IType, inherit: VARIANT_BOOL, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsDefined(self, attributeType, inherit, pRetVal)
proc GetObjectData*(self: ptr IAssembly, info: POBJECT, Context: StreamingContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectData(self, info, Context)
proc add_ModuleResolve*(self: ptr IAssembly, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.add_ModuleResolve(self, value)
proc remove_ModuleResolve*(self: ptr IAssembly, value: POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.remove_ModuleResolve(self, value)
proc GetType_4*(self: ptr IAssembly, name: BSTR, throwOnError: VARIANT_BOOL, ignoreCase: VARIANT_BOOL, pRetVal: ptr ptr IType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType_4(self, name, throwOnError, ignoreCase, pRetVal)
proc GetSatelliteAssembly*(self: ptr IAssembly, culture: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSatelliteAssembly(self, culture, pRetVal)
proc GetSatelliteAssembly_2*(self: ptr IAssembly, culture: POBJECT, Version: POBJECT, pRetVal: ptr ptr IAssembly): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSatelliteAssembly_2(self, culture, Version, pRetVal)
proc LoadModule*(self: ptr IAssembly, moduleName: BSTR, rawModule: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadModule(self, moduleName, rawModule, pRetVal)
proc LoadModule_2*(self: ptr IAssembly, moduleName: BSTR, rawModule: ptr SAFEARRAY, rawSymbolStore: ptr SAFEARRAY, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.LoadModule_2(self, moduleName, rawModule, rawSymbolStore, pRetVal)
proc CreateInstance*(self: ptr IAssembly, typeName: BSTR, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance(self, typeName, pRetVal)
proc CreateInstance_2*(self: ptr IAssembly, typeName: BSTR, ignoreCase: VARIANT_BOOL, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance_2(self, typeName, ignoreCase, pRetVal)
proc CreateInstance_3*(self: ptr IAssembly, typeName: BSTR, ignoreCase: VARIANT_BOOL, bindingAttr: BindingFlags, Binder: POBJECT, args: ptr SAFEARRAY, culture: POBJECT, activationAttributes: ptr SAFEARRAY, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance_3(self, typeName, ignoreCase, bindingAttr, Binder, args, culture, activationAttributes, pRetVal)
proc GetLoadedModules*(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLoadedModules(self, pRetVal)
proc GetLoadedModules_2*(self: ptr IAssembly, getResourceModules: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLoadedModules_2(self, getResourceModules, pRetVal)
proc GetModules*(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetModules(self, pRetVal)
proc GetModules_2*(self: ptr IAssembly, getResourceModules: VARIANT_BOOL, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetModules_2(self, getResourceModules, pRetVal)
proc GetModule*(self: ptr IAssembly, name: BSTR, pRetVal: ptr POBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetModule(self, name, pRetVal)
proc GetReferencedAssemblies*(self: ptr IAssembly, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetReferencedAssemblies(self, pRetVal)
proc get_GlobalAssemblyCache*(self: ptr IAssembly, pRetVal: ptr VARIANT_BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_GlobalAssemblyCache(self, pRetVal)
converter winimConverterIGCHostToIUnknown*(x: ptr IGCHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIGCHost2ToIGCHost*(x: ptr IGCHost2): ptr IGCHost = cast[ptr IGCHost](x)
converter winimConverterIGCHost2ToIUnknown*(x: ptr IGCHost2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIVEHandlerToIUnknown*(x: ptr IVEHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIValidatorToIUnknown*(x: ptr IValidator): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRValidatorToIUnknown*(x: ptr ICLRValidator): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectHandleToIUnknown*(x: ptr IObjectHandle): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAppDomainBindingToIUnknown*(x: ptr IAppDomainBinding): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIGCThreadControlToIUnknown*(x: ptr IGCThreadControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIGCHostControlToIUnknown*(x: ptr IGCHostControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICorThreadpoolToIUnknown*(x: ptr ICorThreadpool): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDebuggerThreadControlToIUnknown*(x: ptr IDebuggerThreadControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDebuggerInfoToIUnknown*(x: ptr IDebuggerInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICorConfigurationToIUnknown*(x: ptr ICorConfiguration): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICorRuntimeHostToIUnknown*(x: ptr ICorRuntimeHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRMemoryNotificationCallbackToIUnknown*(x: ptr ICLRMemoryNotificationCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostMallocToIUnknown*(x: ptr IHostMalloc): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostMemoryManagerToIUnknown*(x: ptr IHostMemoryManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRTaskToIUnknown*(x: ptr ICLRTask): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRTask2ToICLRTask*(x: ptr ICLRTask2): ptr ICLRTask = cast[ptr ICLRTask](x)
converter winimConverterICLRTask2ToIUnknown*(x: ptr ICLRTask2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostTaskToIUnknown*(x: ptr IHostTask): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRTaskManagerToIUnknown*(x: ptr ICLRTaskManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostTaskManagerToIUnknown*(x: ptr IHostTaskManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostThreadpoolManagerToIUnknown*(x: ptr IHostThreadpoolManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRIoCompletionManagerToIUnknown*(x: ptr ICLRIoCompletionManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostIoCompletionManagerToIUnknown*(x: ptr IHostIoCompletionManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRDebugManagerToIUnknown*(x: ptr ICLRDebugManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRErrorReportingManagerToIUnknown*(x: ptr ICLRErrorReportingManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostCrstToIUnknown*(x: ptr IHostCrst): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostAutoEventToIUnknown*(x: ptr IHostAutoEvent): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostManualEventToIUnknown*(x: ptr IHostManualEvent): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostSemaphoreToIUnknown*(x: ptr IHostSemaphore): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRSyncManagerToIUnknown*(x: ptr ICLRSyncManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostSyncManagerToIUnknown*(x: ptr IHostSyncManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRPolicyManagerToIUnknown*(x: ptr ICLRPolicyManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostPolicyManagerToIUnknown*(x: ptr IHostPolicyManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIActionOnCLREventToIUnknown*(x: ptr IActionOnCLREvent): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLROnEventManagerToIUnknown*(x: ptr ICLROnEventManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostGCManagerToIUnknown*(x: ptr IHostGCManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRAssemblyReferenceListToIUnknown*(x: ptr ICLRAssemblyReferenceList): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRReferenceAssemblyEnumToIUnknown*(x: ptr ICLRReferenceAssemblyEnum): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRProbingAssemblyEnumToIUnknown*(x: ptr ICLRProbingAssemblyEnum): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRAssemblyIdentityManagerToIUnknown*(x: ptr ICLRAssemblyIdentityManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRHostBindingPolicyManagerToIUnknown*(x: ptr ICLRHostBindingPolicyManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRGCManagerToIUnknown*(x: ptr ICLRGCManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRGCManager2ToICLRGCManager*(x: ptr ICLRGCManager2): ptr ICLRGCManager = cast[ptr ICLRGCManager](x)
converter winimConverterICLRGCManager2ToIUnknown*(x: ptr ICLRGCManager2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostAssemblyStoreToIUnknown*(x: ptr IHostAssemblyStore): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostAssemblyManagerToIUnknown*(x: ptr IHostAssemblyManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostControlToIUnknown*(x: ptr IHostControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRControlToIUnknown*(x: ptr ICLRControl): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRRuntimeHostToIUnknown*(x: ptr ICLRRuntimeHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRHostProtectionManagerToIUnknown*(x: ptr ICLRHostProtectionManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRDomainManagerToIUnknown*(x: ptr ICLRDomainManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeNameToIUnknown*(x: ptr ITypeName): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeNameBuilderToIUnknown*(x: ptr ITypeNameBuilder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeNameFactoryToIUnknown*(x: ptr ITypeNameFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIApartmentCallbackToIUnknown*(x: ptr IApartmentCallback): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIManagedObjectToIUnknown*(x: ptr IManagedObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICatalogServicesToIUnknown*(x: ptr ICatalogServices): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostSecurityContextToIUnknown*(x: ptr IHostSecurityContext): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIHostSecurityManagerToIUnknown*(x: ptr IHostSecurityManager): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRAppDomainResourceMonitorToIUnknown*(x: ptr ICLRAppDomainResourceMonitor): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRMetaHostToIUnknown*(x: ptr ICLRMetaHost): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRMetaHostPolicyToIUnknown*(x: ptr ICLRMetaHostPolicy): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRProfilingToIUnknown*(x: ptr ICLRProfiling): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRDebuggingLibraryProviderToIUnknown*(x: ptr ICLRDebuggingLibraryProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRDebuggingToIUnknown*(x: ptr ICLRDebugging): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRRuntimeInfoToIUnknown*(x: ptr ICLRRuntimeInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRStrongNameToIUnknown*(x: ptr ICLRStrongName): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRStrongName2ToIUnknown*(x: ptr ICLRStrongName2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICLRStrongName3ToIUnknown*(x: ptr ICLRStrongName3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectToIDispatch*(x: ptr IObject): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIObjectToIUnknown*(x: ptr IObject): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITypeToIUnknown*(x: ptr IType): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAppDomainSetupToIUnknown*(x: ptr IAppDomainSetup): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterObjectHandleToIDispatch*(x: ptr ObjectHandle): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterObjectHandleToIUnknown*(x: ptr ObjectHandle): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterAppDomainToIDispatch*(x: ptr AppDomain): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterAppDomainToIUnknown*(x: ptr AppDomain): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAssemblyToIDispatch*(x: ptr IAssembly): ptr IDispatch = cast[ptr IDispatch](x)
converter winimConverterIAssemblyToIUnknown*(x: ptr IAssembly): ptr IUnknown = cast[ptr IUnknown](x)
