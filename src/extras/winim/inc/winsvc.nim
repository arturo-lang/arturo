#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <winsvc.h>
type
  SC_ACTION_TYPE* = int32
  SC_STATUS_TYPE* = int32
  SC_ENUM_TYPE* = int32
  SC_HANDLE* = HANDLE
  SERVICE_STATUS_HANDLE* = HANDLE
  SERVICE_DESCRIPTIONA* {.pure.} = object
    lpDescription*: LPSTR
  LPSERVICE_DESCRIPTIONA* = ptr SERVICE_DESCRIPTIONA
  SERVICE_DESCRIPTIONW* {.pure.} = object
    lpDescription*: LPWSTR
  LPSERVICE_DESCRIPTIONW* = ptr SERVICE_DESCRIPTIONW
  SC_ACTION* {.pure.} = object
    Type*: SC_ACTION_TYPE
    Delay*: DWORD
  LPSC_ACTION* = ptr SC_ACTION
  SERVICE_FAILURE_ACTIONSA* {.pure.} = object
    dwResetPeriod*: DWORD
    lpRebootMsg*: LPSTR
    lpCommand*: LPSTR
    cActions*: DWORD
    lpsaActions*: ptr SC_ACTION
  LPSERVICE_FAILURE_ACTIONSA* = ptr SERVICE_FAILURE_ACTIONSA
  SERVICE_FAILURE_ACTIONSW* {.pure.} = object
    dwResetPeriod*: DWORD
    lpRebootMsg*: LPWSTR
    lpCommand*: LPWSTR
    cActions*: DWORD
    lpsaActions*: ptr SC_ACTION
  LPSERVICE_FAILURE_ACTIONSW* = ptr SERVICE_FAILURE_ACTIONSW
  LPSC_HANDLE* = ptr SC_HANDLE
  SERVICE_STATUS* {.pure.} = object
    dwServiceType*: DWORD
    dwCurrentState*: DWORD
    dwControlsAccepted*: DWORD
    dwWin32ExitCode*: DWORD
    dwServiceSpecificExitCode*: DWORD
    dwCheckPoint*: DWORD
    dwWaitHint*: DWORD
  LPSERVICE_STATUS* = ptr SERVICE_STATUS
  SERVICE_STATUS_PROCESS* {.pure.} = object
    dwServiceType*: DWORD
    dwCurrentState*: DWORD
    dwControlsAccepted*: DWORD
    dwWin32ExitCode*: DWORD
    dwServiceSpecificExitCode*: DWORD
    dwCheckPoint*: DWORD
    dwWaitHint*: DWORD
    dwProcessId*: DWORD
    dwServiceFlags*: DWORD
  LPSERVICE_STATUS_PROCESS* = ptr SERVICE_STATUS_PROCESS
  ENUM_SERVICE_STATUSA* {.pure.} = object
    lpServiceName*: LPSTR
    lpDisplayName*: LPSTR
    ServiceStatus*: SERVICE_STATUS
  LPENUM_SERVICE_STATUSA* = ptr ENUM_SERVICE_STATUSA
  ENUM_SERVICE_STATUSW* {.pure.} = object
    lpServiceName*: LPWSTR
    lpDisplayName*: LPWSTR
    ServiceStatus*: SERVICE_STATUS
  LPENUM_SERVICE_STATUSW* = ptr ENUM_SERVICE_STATUSW
  ENUM_SERVICE_STATUS_PROCESSA* {.pure.} = object
    lpServiceName*: LPSTR
    lpDisplayName*: LPSTR
    ServiceStatusProcess*: SERVICE_STATUS_PROCESS
  LPENUM_SERVICE_STATUS_PROCESSA* = ptr ENUM_SERVICE_STATUS_PROCESSA
  ENUM_SERVICE_STATUS_PROCESSW* {.pure.} = object
    lpServiceName*: LPWSTR
    lpDisplayName*: LPWSTR
    ServiceStatusProcess*: SERVICE_STATUS_PROCESS
  LPENUM_SERVICE_STATUS_PROCESSW* = ptr ENUM_SERVICE_STATUS_PROCESSW
  SC_LOCK* = LPVOID
  TQUERY_SERVICE_LOCK_STATUSA* {.pure.} = object
    fIsLocked*: DWORD
    lpLockOwner*: LPSTR
    dwLockDuration*: DWORD
  LPQUERY_SERVICE_LOCK_STATUSA* = ptr TQUERY_SERVICE_LOCK_STATUSA
  TQUERY_SERVICE_LOCK_STATUSW* {.pure.} = object
    fIsLocked*: DWORD
    lpLockOwner*: LPWSTR
    dwLockDuration*: DWORD
  LPQUERY_SERVICE_LOCK_STATUSW* = ptr TQUERY_SERVICE_LOCK_STATUSW
  TQUERY_SERVICE_CONFIGA* {.pure.} = object
    dwServiceType*: DWORD
    dwStartType*: DWORD
    dwErrorControl*: DWORD
    lpBinaryPathName*: LPSTR
    lpLoadOrderGroup*: LPSTR
    dwTagId*: DWORD
    lpDependencies*: LPSTR
    lpServiceStartName*: LPSTR
    lpDisplayName*: LPSTR
  LPQUERY_SERVICE_CONFIGA* = ptr TQUERY_SERVICE_CONFIGA
  TQUERY_SERVICE_CONFIGW* {.pure.} = object
    dwServiceType*: DWORD
    dwStartType*: DWORD
    dwErrorControl*: DWORD
    lpBinaryPathName*: LPWSTR
    lpLoadOrderGroup*: LPWSTR
    dwTagId*: DWORD
    lpDependencies*: LPWSTR
    lpServiceStartName*: LPWSTR
    lpDisplayName*: LPWSTR
  LPQUERY_SERVICE_CONFIGW* = ptr TQUERY_SERVICE_CONFIGW
  LPSERVICE_MAIN_FUNCTIONA* = proc (dwNumServicesArgs: DWORD, lpServiceArgVectors: ptr LPSTR): VOID {.stdcall.}
  SERVICE_TABLE_ENTRYA* {.pure.} = object
    lpServiceName*: LPSTR
    lpServiceProc*: LPSERVICE_MAIN_FUNCTIONA
  LPSERVICE_TABLE_ENTRYA* = ptr SERVICE_TABLE_ENTRYA
  LPSERVICE_MAIN_FUNCTIONW* = proc (dwNumServicesArgs: DWORD, lpServiceArgVectors: ptr LPWSTR): VOID {.stdcall.}
  SERVICE_TABLE_ENTRYW* {.pure.} = object
    lpServiceName*: LPWSTR
    lpServiceProc*: LPSERVICE_MAIN_FUNCTIONW
  LPSERVICE_TABLE_ENTRYW* = ptr SERVICE_TABLE_ENTRYW
  SERVICE_CONTROL_STATUS_REASON_PARAMSA* {.pure.} = object
    dwReason*: DWORD
    pszComment*: LPSTR
    ServiceStatus*: SERVICE_STATUS_PROCESS
  PSERVICE_CONTROL_STATUS_REASON_PARAMSA* = ptr SERVICE_CONTROL_STATUS_REASON_PARAMSA
  SERVICE_CONTROL_STATUS_REASON_PARAMSW* {.pure.} = object
    dwReason*: DWORD
    pszComment*: LPWSTR
    ServiceStatus*: SERVICE_STATUS_PROCESS
  PSERVICE_CONTROL_STATUS_REASON_PARAMSW* = ptr SERVICE_CONTROL_STATUS_REASON_PARAMSW
  PFN_SC_NOTIFY_CALLBACK* = proc (pParameter: PVOID): VOID {.stdcall.}
  SERVICE_NOTIFYA* {.pure.} = object
    dwVersion*: DWORD
    pfnNotifyCallback*: PFN_SC_NOTIFY_CALLBACK
    pContext*: PVOID
    dwNotificationStatus*: DWORD
    ServiceStatus*: SERVICE_STATUS_PROCESS
    dwNotificationTriggered*: DWORD
    pszServiceNames*: LPSTR
  PSERVICE_NOTIFYA* = ptr SERVICE_NOTIFYA
  SERVICE_NOTIFYW* {.pure.} = object
    dwVersion*: DWORD
    pfnNotifyCallback*: PFN_SC_NOTIFY_CALLBACK
    pContext*: PVOID
    dwNotificationStatus*: DWORD
    ServiceStatus*: SERVICE_STATUS_PROCESS
    dwNotificationTriggered*: DWORD
    pszServiceNames*: LPWSTR
  PSERVICE_NOTIFYW* = ptr SERVICE_NOTIFYW
  SERVICE_DELAYED_AUTO_START_INFO* {.pure.} = object
    fDelayedAutostart*: WINBOOL
  LPSERVICE_DELAYED_AUTO_START_INFO* = ptr SERVICE_DELAYED_AUTO_START_INFO
  SERVICE_FAILURE_ACTIONS_FLAG* {.pure.} = object
    fFailureActionsOnNonCrashFailures*: WINBOOL
  LPSERVICE_FAILURE_ACTIONS_FLAG* = ptr SERVICE_FAILURE_ACTIONS_FLAG
  SERVICE_PRESHUTDOWN_INFO* {.pure.} = object
    dwPreshutdownTimeout*: DWORD
  LPSERVICE_PRESHUTDOWN_INFO* = ptr SERVICE_PRESHUTDOWN_INFO
  SERVICE_REQUIRED_PRIVILEGES_INFOA* {.pure.} = object
    pmszRequiredPrivileges*: LPSTR
  LPSERVICE_REQUIRED_PRIVILEGES_INFOA* = ptr SERVICE_REQUIRED_PRIVILEGES_INFOA
  SERVICE_REQUIRED_PRIVILEGES_INFOW* {.pure.} = object
    pmszRequiredPrivileges*: LPWSTR
  LPSERVICE_REQUIRED_PRIVILEGES_INFOW* = ptr SERVICE_REQUIRED_PRIVILEGES_INFOW
  SERVICE_SID_INFO* {.pure.} = object
    dwServiceSidType*: DWORD
  LPSERVICE_SID_INFO* = ptr SERVICE_SID_INFO
const
  SERVICES_ACTIVE_DATABASEW* = "ServicesActive"
  SERVICES_FAILED_DATABASEW* = "ServicesFailed"
  SERVICES_ACTIVE_DATABASEA* = "ServicesActive"
  SERVICES_FAILED_DATABASEA* = "ServicesFailed"
  SERVICE_NO_CHANGE* = 0xffffffff'i32
  SERVICE_ACTIVE* = 0x00000001
  SERVICE_INACTIVE* = 0x00000002
  SERVICE_STATE_ALL* = SERVICE_ACTIVE or SERVICE_INACTIVE
  SERVICE_CONTROL_STOP* = 0x00000001
  SERVICE_CONTROL_PAUSE* = 0x00000002
  SERVICE_CONTROL_CONTINUE* = 0x00000003
  SERVICE_CONTROL_INTERROGATE* = 0x00000004
  SERVICE_CONTROL_SHUTDOWN* = 0x00000005
  SERVICE_CONTROL_PARAMCHANGE* = 0x00000006
  SERVICE_CONTROL_NETBINDADD* = 0x00000007
  SERVICE_CONTROL_NETBINDREMOVE* = 0x00000008
  SERVICE_CONTROL_NETBINDENABLE* = 0x00000009
  SERVICE_CONTROL_NETBINDDISABLE* = 0x0000000A
  SERVICE_CONTROL_DEVICEEVENT* = 0x0000000B
  SERVICE_CONTROL_HARDWAREPROFILECHANGE* = 0x0000000C
  SERVICE_CONTROL_POWEREVENT* = 0x0000000D
  SERVICE_CONTROL_SESSIONCHANGE* = 0x0000000E
  SERVICE_STOPPED* = 0x00000001
  SERVICE_START_PENDING* = 0x00000002
  SERVICE_STOP_PENDING* = 0x00000003
  SERVICE_RUNNING* = 0x00000004
  SERVICE_CONTINUE_PENDING* = 0x00000005
  SERVICE_PAUSE_PENDING* = 0x00000006
  SERVICE_PAUSED* = 0x00000007
  SERVICE_ACCEPT_STOP* = 0x00000001
  SERVICE_ACCEPT_PAUSE_CONTINUE* = 0x00000002
  SERVICE_ACCEPT_SHUTDOWN* = 0x00000004
  SERVICE_ACCEPT_PARAMCHANGE* = 0x00000008
  SERVICE_ACCEPT_NETBINDCHANGE* = 0x00000010
  SERVICE_ACCEPT_HARDWAREPROFILECHANGE* = 0x00000020
  SERVICE_ACCEPT_POWEREVENT* = 0x00000040
  SERVICE_ACCEPT_SESSIONCHANGE* = 0x00000080
  SC_MANAGER_CONNECT* = 0x0001
  SC_MANAGER_CREATE_SERVICE* = 0x0002
  SC_MANAGER_ENUMERATE_SERVICE* = 0x0004
  SC_MANAGER_LOCK* = 0x0008
  SC_MANAGER_QUERY_LOCK_STATUS* = 0x0010
  SC_MANAGER_MODIFY_BOOT_CONFIG* = 0x0020
  SC_MANAGER_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SC_MANAGER_CONNECT or SC_MANAGER_CREATE_SERVICE or SC_MANAGER_ENUMERATE_SERVICE or SC_MANAGER_LOCK or SC_MANAGER_QUERY_LOCK_STATUS or SC_MANAGER_MODIFY_BOOT_CONFIG
  SERVICE_QUERY_CONFIG* = 0x0001
  SERVICE_CHANGE_CONFIG* = 0x0002
  SERVICE_QUERY_STATUS* = 0x0004
  SERVICE_ENUMERATE_DEPENDENTS* = 0x0008
  SERVICE_START* = 0x0010
  SERVICE_STOP* = 0x0020
  SERVICE_PAUSE_CONTINUE* = 0x0040
  SERVICE_INTERROGATE* = 0x0080
  SERVICE_USER_DEFINED_CONTROL* = 0x0100
  SERVICE_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SERVICE_QUERY_CONFIG or SERVICE_CHANGE_CONFIG or SERVICE_QUERY_STATUS or SERVICE_ENUMERATE_DEPENDENTS or SERVICE_START or SERVICE_STOP or SERVICE_PAUSE_CONTINUE or SERVICE_INTERROGATE or SERVICE_USER_DEFINED_CONTROL
  SERVICE_RUNS_IN_SYSTEM_PROCESS* = 0x00000001
  SERVICE_CONFIG_DESCRIPTION* = 1
  SERVICE_CONFIG_FAILURE_ACTIONS* = 2
  SC_ACTION_NONE* = 0
  SC_ACTION_RESTART* = 1
  SC_ACTION_REBOOT* = 2
  SC_ACTION_RUN_COMMAND* = 3
  SC_STATUS_PROCESS_INFO* = 0
  SC_ENUM_PROCESS_INFO* = 0
  SERVICE_STOP_REASON_FLAG_CUSTOM* = 0x20000000
  SERVICE_STOP_REASON_FLAG_PLANNED* = 0x40000000
  SERVICE_STOP_REASON_FLAG_UNPLANNED* = 0x10000000
  SERVICE_STOP_REASON_MAJOR_APPLICATION* = 0x00050000
  SERVICE_STOP_REASON_MAJOR_HARDWARE* = 0x00020000
  SERVICE_STOP_REASON_MAJOR_NONE* = 0x00060000
  SERVICE_STOP_REASON_MAJOR_OPERATINGSYSTEM* = 0x00030000
  SERVICE_STOP_REASON_MAJOR_OTHER* = 0x00010000
  SERVICE_STOP_REASON_MAJOR_SOFTWARE* = 0x00040000
  SERVICE_STOP_REASON_MINOR_DISK* = 0x00000008
  SERVICE_STOP_REASON_MINOR_ENVIRONMENT* = 0x0000000a
  SERVICE_STOP_REASON_MINOR_HARDWARE_DRIVER* = 0x0000000b
  SERVICE_STOP_REASON_MINOR_HUNG* = 0x00000006
  SERVICE_STOP_REASON_MINOR_INSTALLATION* = 0x00000003
  SERVICE_STOP_REASON_MINOR_MAINTENANCE* = 0x00000002
  SERVICE_STOP_REASON_MINOR_MMC* = 0x00000016
  SERVICE_STOP_REASON_MINOR_NETWORK_CONNECTIVITY* = 0x00000011
  SERVICE_STOP_REASON_MINOR_NETWORKCARD* = 0x00000009
  SERVICE_STOP_REASON_MINOR_NONE* = 0x00060000
  SERVICE_STOP_REASON_MINOR_OTHER* = 0x00000001
  SERVICE_STOP_REASON_MINOR_OTHERDRIVER* = 0x0000000c
  SERVICE_STOP_REASON_MINOR_RECONFIG* = 0x00000005
  SERVICE_STOP_REASON_MINOR_SECURITY* = 0x00000010
  SERVICE_STOP_REASON_MINOR_SECURITYFIX* = 0x0000000f
  SERVICE_STOP_REASON_MINOR_SECURITYFIX_UNINSTALL* = 0x00000015
  SERVICE_STOP_REASON_MINOR_SERVICEPACK* = 0x0000000d
  SERVICE_STOP_REASON_MINOR_SERVICEPACK_UNINSTALL* = 0x00000013
  SERVICE_STOP_REASON_MINOR_SOFTWARE_UPDATE* = 0x0000000e
  SERVICE_STOP_REASON_MINOR_SOFTWARE_UPDATE_UNINSTALL* = 0x0000000e
  SERVICE_STOP_REASON_MINOR_UNSTABLE* = 0x00000007
  SERVICE_STOP_REASON_MINOR_UPGRADE* = 0x00000004
  SERVICE_STOP_REASON_MINOR_WMI* = 0x00000012
  SERVICE_CONFIG_DELAYED_AUTO_START_INFO* = 3
  SERVICE_CONFIG_FAILURE_ACTIONS_FLAG* = 4
  SERVICE_CONFIG_SERVICE_SID_INFO* = 5
  SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO* = 6
  SERVICE_CONFIG_PRESHUTDOWN_INFO* = 7
  SERVICE_SID_TYPE_NONE* = 0x00000000
  SERVICE_SID_TYPE_RESTRICTED* = 0x00000003
  SERVICE_SID_TYPE_UNRESTRICTED* = 0x00000001
  SC_GROUP_IDENTIFIERA* = '+'
  SC_GROUP_IDENTIFIERW* = WCHAR '+'
type
  LPHANDLER_FUNCTION* = proc (dwControl: DWORD): VOID {.stdcall.}
  LPHANDLER_FUNCTION_EX* = proc (dwControl: DWORD, dwEventType: DWORD, lpEventData: LPVOID, lpContext: LPVOID): DWORD {.stdcall.}
proc ChangeServiceConfigA*(hService: SC_HANDLE, dwServiceType: DWORD, dwStartType: DWORD, dwErrorControl: DWORD, lpBinaryPathName: LPCSTR, lpLoadOrderGroup: LPCSTR, lpdwTagId: LPDWORD, lpDependencies: LPCSTR, lpServiceStartName: LPCSTR, lpPassword: LPCSTR, lpDisplayName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ChangeServiceConfigW*(hService: SC_HANDLE, dwServiceType: DWORD, dwStartType: DWORD, dwErrorControl: DWORD, lpBinaryPathName: LPCWSTR, lpLoadOrderGroup: LPCWSTR, lpdwTagId: LPDWORD, lpDependencies: LPCWSTR, lpServiceStartName: LPCWSTR, lpPassword: LPCWSTR, lpDisplayName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ChangeServiceConfig2A*(hService: SC_HANDLE, dwInfoLevel: DWORD, lpInfo: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ChangeServiceConfig2W*(hService: SC_HANDLE, dwInfoLevel: DWORD, lpInfo: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CloseServiceHandle*(hSCObject: SC_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ControlService*(hService: SC_HANDLE, dwControl: DWORD, lpServiceStatus: LPSERVICE_STATUS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreateServiceA*(hSCManager: SC_HANDLE, lpServiceName: LPCSTR, lpDisplayName: LPCSTR, dwDesiredAccess: DWORD, dwServiceType: DWORD, dwStartType: DWORD, dwErrorControl: DWORD, lpBinaryPathName: LPCSTR, lpLoadOrderGroup: LPCSTR, lpdwTagId: LPDWORD, lpDependencies: LPCSTR, lpServiceStartName: LPCSTR, lpPassword: LPCSTR): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreateServiceW*(hSCManager: SC_HANDLE, lpServiceName: LPCWSTR, lpDisplayName: LPCWSTR, dwDesiredAccess: DWORD, dwServiceType: DWORD, dwStartType: DWORD, dwErrorControl: DWORD, lpBinaryPathName: LPCWSTR, lpLoadOrderGroup: LPCWSTR, lpdwTagId: LPDWORD, lpDependencies: LPCWSTR, lpServiceStartName: LPCWSTR, lpPassword: LPCWSTR): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DeleteService*(hService: SC_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EnumDependentServicesA*(hService: SC_HANDLE, dwServiceState: DWORD, lpServices: LPENUM_SERVICE_STATUSA, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EnumDependentServicesW*(hService: SC_HANDLE, dwServiceState: DWORD, lpServices: LPENUM_SERVICE_STATUSW, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EnumServicesStatusA*(hSCManager: SC_HANDLE, dwServiceType: DWORD, dwServiceState: DWORD, lpServices: LPENUM_SERVICE_STATUSA, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD, lpResumeHandle: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EnumServicesStatusW*(hSCManager: SC_HANDLE, dwServiceType: DWORD, dwServiceState: DWORD, lpServices: LPENUM_SERVICE_STATUSW, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD, lpResumeHandle: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EnumServicesStatusExA*(hSCManager: SC_HANDLE, InfoLevel: SC_ENUM_TYPE, dwServiceType: DWORD, dwServiceState: DWORD, lpServices: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD, lpResumeHandle: LPDWORD, pszGroupName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EnumServicesStatusExW*(hSCManager: SC_HANDLE, InfoLevel: SC_ENUM_TYPE, dwServiceType: DWORD, dwServiceState: DWORD, lpServices: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD, lpResumeHandle: LPDWORD, pszGroupName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetServiceKeyNameA*(hSCManager: SC_HANDLE, lpDisplayName: LPCSTR, lpServiceName: LPSTR, lpcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetServiceKeyNameW*(hSCManager: SC_HANDLE, lpDisplayName: LPCWSTR, lpServiceName: LPWSTR, lpcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetServiceDisplayNameA*(hSCManager: SC_HANDLE, lpServiceName: LPCSTR, lpDisplayName: LPSTR, lpcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetServiceDisplayNameW*(hSCManager: SC_HANDLE, lpServiceName: LPCWSTR, lpDisplayName: LPWSTR, lpcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LockServiceDatabase*(hSCManager: SC_HANDLE): SC_LOCK {.winapi, stdcall, dynlib: "advapi32", importc.}
proc NotifyBootConfigStatus*(BootAcceptable: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenSCManagerA*(lpMachineName: LPCSTR, lpDatabaseName: LPCSTR, dwDesiredAccess: DWORD): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenSCManagerW*(lpMachineName: LPCWSTR, lpDatabaseName: LPCWSTR, dwDesiredAccess: DWORD): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenServiceA*(hSCManager: SC_HANDLE, lpServiceName: LPCSTR, dwDesiredAccess: DWORD): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenServiceW*(hSCManager: SC_HANDLE, lpServiceName: LPCWSTR, dwDesiredAccess: DWORD): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceConfigA*(hService: SC_HANDLE, lpServiceConfig: LPQUERY_SERVICE_CONFIGA, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceConfigW*(hService: SC_HANDLE, lpServiceConfig: LPQUERY_SERVICE_CONFIGW, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceConfig2A*(hService: SC_HANDLE, dwInfoLevel: DWORD, lpBuffer: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceConfig2W*(hService: SC_HANDLE, dwInfoLevel: DWORD, lpBuffer: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceLockStatusA*(hSCManager: SC_HANDLE, lpLockStatus: LPQUERY_SERVICE_LOCK_STATUSA, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceLockStatusW*(hSCManager: SC_HANDLE, lpLockStatus: LPQUERY_SERVICE_LOCK_STATUSW, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceObjectSecurity*(hService: SC_HANDLE, dwSecurityInformation: SECURITY_INFORMATION, lpSecurityDescriptor: PSECURITY_DESCRIPTOR, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceStatus*(hService: SC_HANDLE, lpServiceStatus: LPSERVICE_STATUS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QueryServiceStatusEx*(hService: SC_HANDLE, InfoLevel: SC_STATUS_TYPE, lpBuffer: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegisterServiceCtrlHandlerA*(lpServiceName: LPCSTR, lpHandlerProc: LPHANDLER_FUNCTION): SERVICE_STATUS_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegisterServiceCtrlHandlerW*(lpServiceName: LPCWSTR, lpHandlerProc: LPHANDLER_FUNCTION): SERVICE_STATUS_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegisterServiceCtrlHandlerExA*(lpServiceName: LPCSTR, lpHandlerProc: LPHANDLER_FUNCTION_EX, lpContext: LPVOID): SERVICE_STATUS_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegisterServiceCtrlHandlerExW*(lpServiceName: LPCWSTR, lpHandlerProc: LPHANDLER_FUNCTION_EX, lpContext: LPVOID): SERVICE_STATUS_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetServiceObjectSecurity*(hService: SC_HANDLE, dwSecurityInformation: SECURITY_INFORMATION, lpSecurityDescriptor: PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetServiceStatus*(hServiceStatus: SERVICE_STATUS_HANDLE, lpServiceStatus: LPSERVICE_STATUS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc StartServiceCtrlDispatcherA*(lpServiceStartTable: ptr SERVICE_TABLE_ENTRYA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc StartServiceCtrlDispatcherW*(lpServiceStartTable: ptr SERVICE_TABLE_ENTRYW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc StartServiceA*(hService: SC_HANDLE, dwNumServiceArgs: DWORD, lpServiceArgVectors: ptr LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc StartServiceW*(hService: SC_HANDLE, dwNumServiceArgs: DWORD, lpServiceArgVectors: ptr LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc UnlockServiceDatabase*(ScLock: SC_LOCK): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ControlServiceExA*(hService: SC_HANDLE, dwControl: DWORD, dwInfoLevel: DWORD, pControlParams: PVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ControlServiceExW*(hService: SC_HANDLE, dwControl: DWORD, dwInfoLevel: DWORD, pControlParams: PVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc NotifyServiceStatusChangeA*(hService: SC_HANDLE, dwNotifyMask: DWORD, pNotifyBuffer: PSERVICE_NOTIFYA): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc NotifyServiceStatusChangeW*(hService: SC_HANDLE, dwNotifyMask: DWORD, pNotifyBuffer: PSERVICE_NOTIFYW): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
when winimUnicode:
  type
    SERVICE_DESCRIPTION* = SERVICE_DESCRIPTIONW
    LPSERVICE_DESCRIPTION* = LPSERVICE_DESCRIPTIONW
    SERVICE_FAILURE_ACTIONS* = SERVICE_FAILURE_ACTIONSW
    LPSERVICE_FAILURE_ACTIONS* = LPSERVICE_FAILURE_ACTIONSW
    ENUM_SERVICE_STATUS* = ENUM_SERVICE_STATUSW
    LPENUM_SERVICE_STATUS* = LPENUM_SERVICE_STATUSW
    ENUM_SERVICE_STATUS_PROCESS* = ENUM_SERVICE_STATUS_PROCESSW
    LPENUM_SERVICE_STATUS_PROCESS* = LPENUM_SERVICE_STATUS_PROCESSW
    TQUERY_SERVICE_LOCK_STATUS* = TQUERY_SERVICE_LOCK_STATUSW
    LPQUERY_SERVICE_LOCK_STATUS* = LPQUERY_SERVICE_LOCK_STATUSW
    TQUERY_SERVICE_CONFIG* = TQUERY_SERVICE_CONFIGW
    LPQUERY_SERVICE_CONFIG* = LPQUERY_SERVICE_CONFIGW
    LPSERVICE_MAIN_FUNCTION* = LPSERVICE_MAIN_FUNCTIONW
    SERVICE_TABLE_ENTRY* = SERVICE_TABLE_ENTRYW
    LPSERVICE_TABLE_ENTRY* = LPSERVICE_TABLE_ENTRYW
    SERVICE_CONTROL_STATUS_REASON_PARAMS* = SERVICE_CONTROL_STATUS_REASON_PARAMSW
    PSERVICE_CONTROL_STATUS_REASON_PARAMS* = PSERVICE_CONTROL_STATUS_REASON_PARAMSW
    SERVICE_NOTIFY* = SERVICE_NOTIFYW
    PSERVICE_NOTIFY* = PSERVICE_NOTIFYW
    SERVICE_REQUIRED_PRIVILEGES_INFO* = SERVICE_REQUIRED_PRIVILEGES_INFOW
  const
    SERVICES_ACTIVE_DATABASE* = SERVICES_ACTIVE_DATABASEW
    SERVICES_FAILED_DATABASE* = SERVICES_FAILED_DATABASEW
    SC_GROUP_IDENTIFIER* = SC_GROUP_IDENTIFIERW
  proc ChangeServiceConfig*(hService: SC_HANDLE, dwServiceType: DWORD, dwStartType: DWORD, dwErrorControl: DWORD, lpBinaryPathName: LPCWSTR, lpLoadOrderGroup: LPCWSTR, lpdwTagId: LPDWORD, lpDependencies: LPCWSTR, lpServiceStartName: LPCWSTR, lpPassword: LPCWSTR, lpDisplayName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ChangeServiceConfigW".}
  proc ChangeServiceConfig2*(hService: SC_HANDLE, dwInfoLevel: DWORD, lpInfo: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ChangeServiceConfig2W".}
  proc CreateService*(hSCManager: SC_HANDLE, lpServiceName: LPCWSTR, lpDisplayName: LPCWSTR, dwDesiredAccess: DWORD, dwServiceType: DWORD, dwStartType: DWORD, dwErrorControl: DWORD, lpBinaryPathName: LPCWSTR, lpLoadOrderGroup: LPCWSTR, lpdwTagId: LPDWORD, lpDependencies: LPCWSTR, lpServiceStartName: LPCWSTR, lpPassword: LPCWSTR): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "CreateServiceW".}
  proc EnumDependentServices*(hService: SC_HANDLE, dwServiceState: DWORD, lpServices: LPENUM_SERVICE_STATUSW, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "EnumDependentServicesW".}
  proc EnumServicesStatus*(hSCManager: SC_HANDLE, dwServiceType: DWORD, dwServiceState: DWORD, lpServices: LPENUM_SERVICE_STATUSW, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD, lpResumeHandle: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "EnumServicesStatusW".}
  proc EnumServicesStatusEx*(hSCManager: SC_HANDLE, InfoLevel: SC_ENUM_TYPE, dwServiceType: DWORD, dwServiceState: DWORD, lpServices: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD, lpResumeHandle: LPDWORD, pszGroupName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "EnumServicesStatusExW".}
  proc GetServiceKeyName*(hSCManager: SC_HANDLE, lpDisplayName: LPCWSTR, lpServiceName: LPWSTR, lpcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetServiceKeyNameW".}
  proc GetServiceDisplayName*(hSCManager: SC_HANDLE, lpServiceName: LPCWSTR, lpDisplayName: LPWSTR, lpcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetServiceDisplayNameW".}
  proc OpenSCManager*(lpMachineName: LPCWSTR, lpDatabaseName: LPCWSTR, dwDesiredAccess: DWORD): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "OpenSCManagerW".}
  proc OpenService*(hSCManager: SC_HANDLE, lpServiceName: LPCWSTR, dwDesiredAccess: DWORD): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "OpenServiceW".}
  proc QueryServiceConfig*(hService: SC_HANDLE, lpServiceConfig: LPQUERY_SERVICE_CONFIGW, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "QueryServiceConfigW".}
  proc QueryServiceConfig2*(hService: SC_HANDLE, dwInfoLevel: DWORD, lpBuffer: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "QueryServiceConfig2W".}
  proc QueryServiceLockStatus*(hSCManager: SC_HANDLE, lpLockStatus: LPQUERY_SERVICE_LOCK_STATUSW, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "QueryServiceLockStatusW".}
  proc RegisterServiceCtrlHandler*(lpServiceName: LPCWSTR, lpHandlerProc: LPHANDLER_FUNCTION): SERVICE_STATUS_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "RegisterServiceCtrlHandlerW".}
  proc RegisterServiceCtrlHandlerEx*(lpServiceName: LPCWSTR, lpHandlerProc: LPHANDLER_FUNCTION_EX, lpContext: LPVOID): SERVICE_STATUS_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "RegisterServiceCtrlHandlerExW".}
  proc StartServiceCtrlDispatcher*(lpServiceStartTable: ptr SERVICE_TABLE_ENTRYW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "StartServiceCtrlDispatcherW".}
  proc StartService*(hService: SC_HANDLE, dwNumServiceArgs: DWORD, lpServiceArgVectors: ptr LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "StartServiceW".}
  proc ControlServiceEx*(hService: SC_HANDLE, dwControl: DWORD, dwInfoLevel: DWORD, pControlParams: PVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ControlServiceExW".}
  proc NotifyServiceStatusChange*(hService: SC_HANDLE, dwNotifyMask: DWORD, pNotifyBuffer: PSERVICE_NOTIFYW): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "NotifyServiceStatusChangeW".}
when winimAnsi:
  type
    SERVICE_DESCRIPTION* = SERVICE_DESCRIPTIONA
    LPSERVICE_DESCRIPTION* = LPSERVICE_DESCRIPTIONA
    SERVICE_FAILURE_ACTIONS* = SERVICE_FAILURE_ACTIONSA
    LPSERVICE_FAILURE_ACTIONS* = LPSERVICE_FAILURE_ACTIONSA
    ENUM_SERVICE_STATUS* = ENUM_SERVICE_STATUSA
    LPENUM_SERVICE_STATUS* = LPENUM_SERVICE_STATUSA
    ENUM_SERVICE_STATUS_PROCESS* = ENUM_SERVICE_STATUS_PROCESSA
    LPENUM_SERVICE_STATUS_PROCESS* = LPENUM_SERVICE_STATUS_PROCESSA
    TQUERY_SERVICE_LOCK_STATUS* = TQUERY_SERVICE_LOCK_STATUSA
    LPQUERY_SERVICE_LOCK_STATUS* = LPQUERY_SERVICE_LOCK_STATUSA
    TQUERY_SERVICE_CONFIG* = TQUERY_SERVICE_CONFIGA
    LPQUERY_SERVICE_CONFIG* = LPQUERY_SERVICE_CONFIGA
    LPSERVICE_MAIN_FUNCTION* = LPSERVICE_MAIN_FUNCTIONA
    SERVICE_TABLE_ENTRY* = SERVICE_TABLE_ENTRYA
    LPSERVICE_TABLE_ENTRY* = LPSERVICE_TABLE_ENTRYA
    SERVICE_CONTROL_STATUS_REASON_PARAMS* = SERVICE_CONTROL_STATUS_REASON_PARAMSA
    PSERVICE_CONTROL_STATUS_REASON_PARAMS* = PSERVICE_CONTROL_STATUS_REASON_PARAMSA
    SERVICE_NOTIFY* = SERVICE_NOTIFYA
    PSERVICE_NOTIFY* = PSERVICE_NOTIFYA
    SERVICE_REQUIRED_PRIVILEGES_INFO* = SERVICE_REQUIRED_PRIVILEGES_INFOA
  const
    SERVICES_ACTIVE_DATABASE* = SERVICES_ACTIVE_DATABASEA
    SERVICES_FAILED_DATABASE* = SERVICES_FAILED_DATABASEA
    SC_GROUP_IDENTIFIER* = SC_GROUP_IDENTIFIERA
  proc ChangeServiceConfig*(hService: SC_HANDLE, dwServiceType: DWORD, dwStartType: DWORD, dwErrorControl: DWORD, lpBinaryPathName: LPCSTR, lpLoadOrderGroup: LPCSTR, lpdwTagId: LPDWORD, lpDependencies: LPCSTR, lpServiceStartName: LPCSTR, lpPassword: LPCSTR, lpDisplayName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ChangeServiceConfigA".}
  proc ChangeServiceConfig2*(hService: SC_HANDLE, dwInfoLevel: DWORD, lpInfo: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ChangeServiceConfig2A".}
  proc CreateService*(hSCManager: SC_HANDLE, lpServiceName: LPCSTR, lpDisplayName: LPCSTR, dwDesiredAccess: DWORD, dwServiceType: DWORD, dwStartType: DWORD, dwErrorControl: DWORD, lpBinaryPathName: LPCSTR, lpLoadOrderGroup: LPCSTR, lpdwTagId: LPDWORD, lpDependencies: LPCSTR, lpServiceStartName: LPCSTR, lpPassword: LPCSTR): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "CreateServiceA".}
  proc EnumDependentServices*(hService: SC_HANDLE, dwServiceState: DWORD, lpServices: LPENUM_SERVICE_STATUSA, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "EnumDependentServicesA".}
  proc EnumServicesStatus*(hSCManager: SC_HANDLE, dwServiceType: DWORD, dwServiceState: DWORD, lpServices: LPENUM_SERVICE_STATUSA, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD, lpResumeHandle: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "EnumServicesStatusA".}
  proc EnumServicesStatusEx*(hSCManager: SC_HANDLE, InfoLevel: SC_ENUM_TYPE, dwServiceType: DWORD, dwServiceState: DWORD, lpServices: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD, lpServicesReturned: LPDWORD, lpResumeHandle: LPDWORD, pszGroupName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "EnumServicesStatusExA".}
  proc GetServiceKeyName*(hSCManager: SC_HANDLE, lpDisplayName: LPCSTR, lpServiceName: LPSTR, lpcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetServiceKeyNameA".}
  proc GetServiceDisplayName*(hSCManager: SC_HANDLE, lpServiceName: LPCSTR, lpDisplayName: LPSTR, lpcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetServiceDisplayNameA".}
  proc OpenSCManager*(lpMachineName: LPCSTR, lpDatabaseName: LPCSTR, dwDesiredAccess: DWORD): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "OpenSCManagerA".}
  proc OpenService*(hSCManager: SC_HANDLE, lpServiceName: LPCSTR, dwDesiredAccess: DWORD): SC_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "OpenServiceA".}
  proc QueryServiceConfig*(hService: SC_HANDLE, lpServiceConfig: LPQUERY_SERVICE_CONFIGA, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "QueryServiceConfigA".}
  proc QueryServiceConfig2*(hService: SC_HANDLE, dwInfoLevel: DWORD, lpBuffer: LPBYTE, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "QueryServiceConfig2A".}
  proc QueryServiceLockStatus*(hSCManager: SC_HANDLE, lpLockStatus: LPQUERY_SERVICE_LOCK_STATUSA, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "QueryServiceLockStatusA".}
  proc RegisterServiceCtrlHandler*(lpServiceName: LPCSTR, lpHandlerProc: LPHANDLER_FUNCTION): SERVICE_STATUS_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "RegisterServiceCtrlHandlerA".}
  proc RegisterServiceCtrlHandlerEx*(lpServiceName: LPCSTR, lpHandlerProc: LPHANDLER_FUNCTION_EX, lpContext: LPVOID): SERVICE_STATUS_HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "RegisterServiceCtrlHandlerExA".}
  proc StartServiceCtrlDispatcher*(lpServiceStartTable: ptr SERVICE_TABLE_ENTRYA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "StartServiceCtrlDispatcherA".}
  proc StartService*(hService: SC_HANDLE, dwNumServiceArgs: DWORD, lpServiceArgVectors: ptr LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "StartServiceA".}
  proc ControlServiceEx*(hService: SC_HANDLE, dwControl: DWORD, dwInfoLevel: DWORD, pControlParams: PVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ControlServiceExA".}
  proc NotifyServiceStatusChange*(hService: SC_HANDLE, dwNotifyMask: DWORD, pNotifyBuffer: PSERVICE_NOTIFYA): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "NotifyServiceStatusChangeA".}
