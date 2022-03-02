#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
#include <winreg.h>
#include <reason.h>
type
  LSTATUS* = LONG
  REGSAM* = ACCESS_MASK
  val_context* {.pure.} = object
    valuelen*: int32
    value_context*: LPVOID
    val_buff_ptr*: LPVOID
  PVALCONTEXT* = ptr val_context
  PVALUEA* {.pure.} = object
    pv_valuename*: LPSTR
    pv_valuelen*: int32
    pv_value_context*: LPVOID
    pv_type*: DWORD
  PPVALUEA* = ptr PVALUEA
  PVALUEW* {.pure.} = object
    pv_valuename*: LPWSTR
    pv_valuelen*: int32
    pv_value_context*: LPVOID
    pv_type*: DWORD
  PPVALUEW* = ptr PVALUEW
  QUERYHANDLER* = proc (keycontext: LPVOID, val_list: PVALCONTEXT, num_vals: DWORD, outputbuffer: LPVOID, total_outlen: ptr DWORD, input_blen: DWORD): DWORD {.cdecl.}
  PQUERYHANDLER* = QUERYHANDLER
  VALENTA* {.pure.} = object
    ve_valuename*: LPSTR
    ve_valuelen*: DWORD
    ve_valueptr*: DWORD_PTR
    ve_type*: DWORD
  PVALENTA* = ptr VALENTA
  VALENTW* {.pure.} = object
    ve_valuename*: LPWSTR
    ve_valuelen*: DWORD
    ve_valueptr*: DWORD_PTR
    ve_type*: DWORD
  PVALENTW* = ptr VALENTW
  REG_PROVIDER* {.pure.} = object
    pi_R0_1val*: PQUERYHANDLER
    pi_R0_allvals*: PQUERYHANDLER
    pi_R3_1val*: PQUERYHANDLER
    pi_R3_allvals*: PQUERYHANDLER
    pi_flags*: DWORD
    pi_key_context*: LPVOID
  PPROVIDER* = ptr REG_PROVIDER
const
  RRF_RT_REG_NONE* = 0x00000001
  RRF_RT_REG_SZ* = 0x00000002
  RRF_RT_REG_EXPAND_SZ* = 0x00000004
  RRF_RT_REG_BINARY* = 0x00000008
  RRF_RT_REG_DWORD* = 0x00000010
  RRF_RT_REG_MULTI_SZ* = 0x00000020
  RRF_RT_REG_QWORD* = 0x00000040
  RRF_RT_DWORD* = RRF_RT_REG_BINARY or RRF_RT_REG_DWORD
  RRF_RT_QWORD* = RRF_RT_REG_BINARY or RRF_RT_REG_QWORD
  RRF_RT_ANY* = 0x0000ffff
  RRF_NOEXPAND* = 0x10000000
  RRF_ZEROONFAILURE* = 0x20000000
  REG_SECURE_CONNECTION* = 1
  PROVIDER_KEEPS_VALUE_LENGTH* = 0x1
  WIN31_CLASS* = NULL
  SHTDN_REASON_FLAG_COMMENT_REQUIRED* = 0x01000000
  SHTDN_REASON_FLAG_DIRTY_PROBLEM_ID_REQUIRED* = 0x02000000
  SHTDN_REASON_FLAG_CLEAN_UI* = 0x04000000
  SHTDN_REASON_FLAG_DIRTY_UI* = 0x08000000
  SHTDN_REASON_FLAG_USER_DEFINED* = 0x40000000
  SHTDN_REASON_FLAG_PLANNED* = 0x80000000'i32
  SHTDN_REASON_MAJOR_OTHER* = 0x00000000
  SHTDN_REASON_MAJOR_NONE* = 0x00000000
  SHTDN_REASON_MAJOR_HARDWARE* = 0x00010000
  SHTDN_REASON_MAJOR_OPERATINGSYSTEM* = 0x00020000
  SHTDN_REASON_MAJOR_SOFTWARE* = 0x00030000
  SHTDN_REASON_MAJOR_APPLICATION* = 0x00040000
  SHTDN_REASON_MAJOR_SYSTEM* = 0x00050000
  SHTDN_REASON_MAJOR_POWER* = 0x00060000
  SHTDN_REASON_MAJOR_LEGACY_API* = 0x00070000
  SHTDN_REASON_MINOR_OTHER* = 0x00000000
  SHTDN_REASON_MINOR_NONE* = 0x000000ff
  SHTDN_REASON_MINOR_MAINTENANCE* = 0x00000001
  SHTDN_REASON_MINOR_INSTALLATION* = 0x00000002
  SHTDN_REASON_MINOR_UPGRADE* = 0x00000003
  SHTDN_REASON_MINOR_RECONFIG* = 0x00000004
  SHTDN_REASON_MINOR_HUNG* = 0x00000005
  SHTDN_REASON_MINOR_UNSTABLE* = 0x00000006
  SHTDN_REASON_MINOR_DISK* = 0x00000007
  SHTDN_REASON_MINOR_PROCESSOR* = 0x00000008
  SHTDN_REASON_MINOR_NETWORKCARD* = 0x00000009
  SHTDN_REASON_MINOR_POWER_SUPPLY* = 0x0000000a
  SHTDN_REASON_MINOR_CORDUNPLUGGED* = 0x0000000b
  SHTDN_REASON_MINOR_ENVIRONMENT* = 0x0000000c
  SHTDN_REASON_MINOR_HARDWARE_DRIVER* = 0x0000000d
  SHTDN_REASON_MINOR_OTHERDRIVER* = 0x0000000e
  SHTDN_REASON_MINOR_BLUESCREEN* = 0x0000000F
  SHTDN_REASON_MINOR_SERVICEPACK* = 0x00000010
  SHTDN_REASON_MINOR_HOTFIX* = 0x00000011
  SHTDN_REASON_MINOR_SECURITYFIX* = 0x00000012
  SHTDN_REASON_MINOR_SECURITY* = 0x00000013
  SHTDN_REASON_MINOR_NETWORK_CONNECTIVITY* = 0x00000014
  SHTDN_REASON_MINOR_WMI* = 0x00000015
  SHTDN_REASON_MINOR_SERVICEPACK_UNINSTALL* = 0x00000016
  SHTDN_REASON_MINOR_HOTFIX_UNINSTALL* = 0x00000017
  SHTDN_REASON_MINOR_SECURITYFIX_UNINSTALL* = 0x00000018
  SHTDN_REASON_MINOR_MMC* = 0x00000019
  SHTDN_REASON_MINOR_SYSTEMRESTORE* = 0x0000001a
  SHTDN_REASON_MINOR_TERMSRV* = 0x00000020
  SHTDN_REASON_MINOR_DC_PROMOTION* = 0x00000021
  SHTDN_REASON_MINOR_DC_DEMOTION* = 0x00000022
  SHTDN_REASON_UNKNOWN* = SHTDN_REASON_MINOR_NONE
  SHTDN_REASON_LEGACY_API* = SHTDN_REASON_MAJOR_LEGACY_API or SHTDN_REASON_FLAG_PLANNED
  SHTDN_REASON_VALID_BIT_MASK* = 0xc0ffffff'i32
  PCLEANUI* = SHTDN_REASON_FLAG_PLANNED or SHTDN_REASON_FLAG_CLEAN_UI
  UCLEANUI* = SHTDN_REASON_FLAG_CLEAN_UI
  PDIRTYUI* = SHTDN_REASON_FLAG_PLANNED or SHTDN_REASON_FLAG_DIRTY_UI
  UDIRTYUI* = SHTDN_REASON_FLAG_DIRTY_UI
  MAX_REASON_NAME_LEN* = 64
  MAX_REASON_DESC_LEN* = 256
  MAX_REASON_BUGID_LEN* = 32
  MAX_REASON_COMMENT_LEN* = 512
  SHUTDOWN_TYPE_LEN* = 32
  POLICY_SHOWREASONUI_NEVER* = 0
  POLICY_SHOWREASONUI_ALWAYS* = 1
  POLICY_SHOWREASONUI_WORKSTATIONONLY* = 2
  POLICY_SHOWREASONUI_SERVERONLY* = 3
  SNAPSHOT_POLICY_NEVER* = 0
  SNAPSHOT_POLICY_ALWAYS* = 1
  SNAPSHOT_POLICY_UNPLANNED* = 2
  MAX_NUM_REASONS* = 256
  REASON_SWINSTALL* = SHTDN_REASON_MAJOR_SOFTWARE or SHTDN_REASON_MINOR_INSTALLATION
  REASON_HWINSTALL* = SHTDN_REASON_MAJOR_HARDWARE or SHTDN_REASON_MINOR_INSTALLATION
  REASON_SERVICEHANG* = SHTDN_REASON_MAJOR_SOFTWARE or SHTDN_REASON_MINOR_HUNG
  REASON_UNSTABLE* = SHTDN_REASON_MAJOR_SYSTEM or SHTDN_REASON_MINOR_UNSTABLE
  REASON_SWHWRECONF* = SHTDN_REASON_MAJOR_SOFTWARE or SHTDN_REASON_MINOR_RECONFIG
  REASON_OTHER* = SHTDN_REASON_MAJOR_OTHER or SHTDN_REASON_MINOR_OTHER
  REASON_UNKNOWN* = SHTDN_REASON_UNKNOWN
  REASON_LEGACY_API* = SHTDN_REASON_LEGACY_API
  REASON_PLANNED_FLAG* = SHTDN_REASON_FLAG_PLANNED
  MAX_SHUTDOWN_TIMEOUT* = 10*365*24*60*60
  SHUTDOWN_FORCE_OTHERS* = 0x00000001
  SHUTDOWN_FORCE_SELF* = 0x00000002
  SHUTDOWN_RESTART* = 0x00000004
  SHUTDOWN_POWEROFF* = 0x00000008
  SHUTDOWN_NOREBOOT* = 0x00000010
  SHUTDOWN_GRACE_OVERRIDE* = 0x00000020
  SHUTDOWN_INSTALL_UPDATES* = 0x00000040
  SHUTDOWN_RESTARTAPPS* = 0x00000080
  SHUTDOWN_HYBRID* = 0x00000200
  HKEY_CLASSES_ROOT* = HKEY 0x80000000'i32
  HKEY_CURRENT_CONFIG* = HKEY 0x80000005'i32
  HKEY_CURRENT_USER* = HKEY 0x80000001'i32
  HKEY_DYN_DATA* = HKEY 0x80000006'i32
  HKEY_LOCAL_MACHINE* = HKEY 0x80000002'i32
  HKEY_PERFORMANCE_DATA* = HKEY 0x80000004'i32
  HKEY_PERFORMANCE_NLSTEXT* = HKEY 0x80000060'i32
  HKEY_PERFORMANCE_TEXT* = HKEY 0x80000050'i32
  HKEY_USERS* = HKEY 0x80000003'i32
proc RegCloseKey*(hKey: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOverridePredefKey*(hKey: HKEY, hNewHKey: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOpenUserClassesRoot*(hToken: HANDLE, dwOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOpenCurrentUser*(samDesired: REGSAM, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDisablePredefinedCache*(): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegConnectRegistryA*(lpMachineName: LPCSTR, hKey: HKEY, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegConnectRegistryW*(lpMachineName: LPCWSTR, hKey: HKEY, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegConnectRegistryExA*(lpMachineName: LPCSTR, hKey: HKEY, Flags: ULONG, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegConnectRegistryExW*(lpMachineName: LPCWSTR, hKey: HKEY, Flags: ULONG, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegCreateKeyA*(hKey: HKEY, lpSubKey: LPCSTR, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegCreateKeyW*(hKey: HKEY, lpSubKey: LPCWSTR, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegCreateKeyExA*(hKey: HKEY, lpSubKey: LPCSTR, Reserved: DWORD, lpClass: LPSTR, dwOptions: DWORD, samDesired: REGSAM, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, phkResult: PHKEY, lpdwDisposition: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegCreateKeyExW*(hKey: HKEY, lpSubKey: LPCWSTR, Reserved: DWORD, lpClass: LPWSTR, dwOptions: DWORD, samDesired: REGSAM, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, phkResult: PHKEY, lpdwDisposition: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteKeyA*(hKey: HKEY, lpSubKey: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteKeyW*(hKey: HKEY, lpSubKey: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteKeyExA*(hKey: HKEY, lpSubKey: LPCSTR, samDesired: REGSAM, Reserved: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteKeyExW*(hKey: HKEY, lpSubKey: LPCWSTR, samDesired: REGSAM, Reserved: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDisableReflectionKey*(hBase: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegEnableReflectionKey*(hBase: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryReflectionKey*(hBase: HKEY, bIsReflectionDisabled: ptr WINBOOL): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteValueA*(hKey: HKEY, lpValueName: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteValueW*(hKey: HKEY, lpValueName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegEnumKeyA*(hKey: HKEY, dwIndex: DWORD, lpName: LPSTR, cchName: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegEnumKeyW*(hKey: HKEY, dwIndex: DWORD, lpName: LPWSTR, cchName: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegEnumKeyExA*(hKey: HKEY, dwIndex: DWORD, lpName: LPSTR, lpcchName: LPDWORD, lpReserved: LPDWORD, lpClass: LPSTR, lpcchClass: LPDWORD, lpftLastWriteTime: PFILETIME): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegEnumKeyExW*(hKey: HKEY, dwIndex: DWORD, lpName: LPWSTR, lpcchName: LPDWORD, lpReserved: LPDWORD, lpClass: LPWSTR, lpcchClass: LPDWORD, lpftLastWriteTime: PFILETIME): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegEnumValueA*(hKey: HKEY, dwIndex: DWORD, lpValueName: LPSTR, lpcchValueName: LPDWORD, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegEnumValueW*(hKey: HKEY, dwIndex: DWORD, lpValueName: LPWSTR, lpcchValueName: LPDWORD, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegFlushKey*(hKey: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegGetKeySecurity*(hKey: HKEY, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR, lpcbSecurityDescriptor: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegLoadKeyA*(hKey: HKEY, lpSubKey: LPCSTR, lpFile: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegLoadKeyW*(hKey: HKEY, lpSubKey: LPCWSTR, lpFile: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegNotifyChangeKeyValue*(hKey: HKEY, bWatchSubtree: WINBOOL, dwNotifyFilter: DWORD, hEvent: HANDLE, fAsynchronous: WINBOOL): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOpenKeyA*(hKey: HKEY, lpSubKey: LPCSTR, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOpenKeyW*(hKey: HKEY, lpSubKey: LPCWSTR, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOpenKeyExA*(hKey: HKEY, lpSubKey: LPCSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOpenKeyExW*(hKey: HKEY, lpSubKey: LPCWSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryInfoKeyA*(hKey: HKEY, lpClass: LPSTR, lpcchClass: LPDWORD, lpReserved: LPDWORD, lpcSubKeys: LPDWORD, lpcbMaxSubKeyLen: LPDWORD, lpcbMaxClassLen: LPDWORD, lpcValues: LPDWORD, lpcbMaxValueNameLen: LPDWORD, lpcbMaxValueLen: LPDWORD, lpcbSecurityDescriptor: LPDWORD, lpftLastWriteTime: PFILETIME): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryInfoKeyW*(hKey: HKEY, lpClass: LPWSTR, lpcchClass: LPDWORD, lpReserved: LPDWORD, lpcSubKeys: LPDWORD, lpcbMaxSubKeyLen: LPDWORD, lpcbMaxClassLen: LPDWORD, lpcValues: LPDWORD, lpcbMaxValueNameLen: LPDWORD, lpcbMaxValueLen: LPDWORD, lpcbSecurityDescriptor: LPDWORD, lpftLastWriteTime: PFILETIME): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryValueA*(hKey: HKEY, lpSubKey: LPCSTR, lpData: LPSTR, lpcbData: PLONG): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryValueW*(hKey: HKEY, lpSubKey: LPCWSTR, lpData: LPWSTR, lpcbData: PLONG): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryMultipleValuesA*(hKey: HKEY, val_list: PVALENTA, num_vals: DWORD, lpValueBuf: LPSTR, ldwTotsize: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryMultipleValuesW*(hKey: HKEY, val_list: PVALENTW, num_vals: DWORD, lpValueBuf: LPWSTR, ldwTotsize: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryValueExA*(hKey: HKEY, lpValueName: LPCSTR, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegQueryValueExW*(hKey: HKEY, lpValueName: LPCWSTR, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegReplaceKeyA*(hKey: HKEY, lpSubKey: LPCSTR, lpNewFile: LPCSTR, lpOldFile: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegReplaceKeyW*(hKey: HKEY, lpSubKey: LPCWSTR, lpNewFile: LPCWSTR, lpOldFile: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegRestoreKeyA*(hKey: HKEY, lpFile: LPCSTR, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegRestoreKeyW*(hKey: HKEY, lpFile: LPCWSTR, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSaveKeyA*(hKey: HKEY, lpFile: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSaveKeyW*(hKey: HKEY, lpFile: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSetKeySecurity*(hKey: HKEY, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSetValueA*(hKey: HKEY, lpSubKey: LPCSTR, dwType: DWORD, lpData: LPCSTR, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSetValueW*(hKey: HKEY, lpSubKey: LPCWSTR, dwType: DWORD, lpData: LPCWSTR, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSetValueExA*(hKey: HKEY, lpValueName: LPCSTR, Reserved: DWORD, dwType: DWORD, lpData: ptr BYTE, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSetValueExW*(hKey: HKEY, lpValueName: LPCWSTR, Reserved: DWORD, dwType: DWORD, lpData: ptr BYTE, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegUnLoadKeyA*(hKey: HKEY, lpSubKey: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegUnLoadKeyW*(hKey: HKEY, lpSubKey: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegGetValueA*(hkey: HKEY, lpSubKey: LPCSTR, lpValue: LPCSTR, dwFlags: DWORD, pdwType: LPDWORD, pvData: PVOID, pcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegGetValueW*(hkey: HKEY, lpSubKey: LPCWSTR, lpValue: LPCWSTR, dwFlags: DWORD, pdwType: LPDWORD, pvData: PVOID, pcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitiateSystemShutdownA*(lpMachineName: LPSTR, lpMessage: LPSTR, dwTimeout: DWORD, bForceAppsClosed: WINBOOL, bRebootAfterShutdown: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitiateSystemShutdownW*(lpMachineName: LPWSTR, lpMessage: LPWSTR, dwTimeout: DWORD, bForceAppsClosed: WINBOOL, bRebootAfterShutdown: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AbortSystemShutdownA*(lpMachineName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AbortSystemShutdownW*(lpMachineName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitiateSystemShutdownExA*(lpMachineName: LPSTR, lpMessage: LPSTR, dwTimeout: DWORD, bForceAppsClosed: WINBOOL, bRebootAfterShutdown: WINBOOL, dwReason: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitiateSystemShutdownExW*(lpMachineName: LPWSTR, lpMessage: LPWSTR, dwTimeout: DWORD, bForceAppsClosed: WINBOOL, bRebootAfterShutdown: WINBOOL, dwReason: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSaveKeyExA*(hKey: HKEY, lpFile: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, Flags: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSaveKeyExW*(hKey: HKEY, lpFile: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, Flags: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegCopyTreeA*(hKeySrc: HKEY, lpSubKey: LPCSTR, hKeyDest: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegCopyTreeW*(hKeySrc: HKEY, lpSubKey: LPCWSTR, hKeyDest: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegCreateKeyTransactedA*(hKey: HKEY, lpSubKey: LPCSTR, Reserved: DWORD, lpClass: LPSTR, dwOptions: DWORD, samDesired: REGSAM, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, phkResult: PHKEY, lpdwDisposition: LPDWORD, hTransaction: HANDLE, pExtendedParemeter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegCreateKeyTransactedW*(hKey: HKEY, lpSubKey: LPCWSTR, Reserved: DWORD, lpClass: LPWSTR, dwOptions: DWORD, samDesired: REGSAM, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, phkResult: PHKEY, lpdwDisposition: LPDWORD, hTransaction: HANDLE, pExtendedParemeter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteKeyTransactedA*(hKey: HKEY, lpSubKey: LPCSTR, samDesired: REGSAM, Reserved: DWORD, hTransaction: HANDLE, pExtendedParameter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteKeyTransactedW*(hKey: HKEY, lpSubKey: LPCWSTR, samDesired: REGSAM, Reserved: DWORD, hTransaction: HANDLE, pExtendedParameter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteKeyValueA*(hKey: HKEY, lpSubKey: LPCSTR, lpValueName: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteKeyValueW*(hKey: HKEY, lpSubKey: LPCWSTR, lpValueName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteTreeA*(hKey: HKEY, lpSubKey: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDeleteTreeW*(hKey: HKEY, lpSubKey: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegDisablePredefinedCacheEx*(): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegLoadAppKeyA*(lpFile: LPCSTR, phkResult: PHKEY, samDesired: REGSAM, dwOptions: DWORD, Reserved: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegLoadAppKeyW*(lpFile: LPCWSTR, phkResult: PHKEY, samDesired: REGSAM, dwOptions: DWORD, Reserved: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegLoadMUIStringA*(hKey: HKEY, pszValue: LPCSTR, pszOutBuf: LPSTR, cbOutBuf: DWORD, pcbData: LPDWORD, Flags: DWORD, pszDirectory: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegLoadMUIStringW*(hKey: HKEY, pszValue: LPCWSTR, pszOutBuf: LPWSTR, cbOutBuf: DWORD, pcbData: LPDWORD, Flags: DWORD, pszDirectory: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOpenKeyTransactedA*(hKey: HKEY, lpSubKey: LPCSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY, hTransaction: HANDLE, pExtendedParameter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegOpenKeyTransactedW*(hKey: HKEY, lpSubKey: LPCWSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY, hTransaction: HANDLE, pExtendedParameter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSetKeyValueA*(hKey: HKEY, lpSubKey: LPCSTR, lpValueName: LPCSTR, dwType: DWORD, lpData: LPCVOID, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegSetKeyValueW*(hKey: HKEY, lpSubKey: LPCSTR, lpValueName: LPCSTR, dwType: DWORD, lpData: LPCVOID, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitiateShutdownA*(lpMachineName: LPSTR, lpMessage: LPSTR, dwGracePeriod: DWORD, dwShutdownFlags: DWORD, dwReason: DWORD): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitiateShutdownW*(lpMachineName: LPWSTR, lpMessage: LPWSTR, dwGracePeriod: DWORD, dwShutdownFlags: DWORD, dwReason: DWORD): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
when winimUnicode:
  type
    PVALUE* = PVALUEW
    PPVALUE* = PPVALUEW
    VALENT* = VALENTW
    PVALENT* = PVALENTW
  proc RegConnectRegistry*(lpMachineName: LPCWSTR, hKey: HKEY, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegConnectRegistryW".}
  proc RegConnectRegistryEx*(lpMachineName: LPCWSTR, hKey: HKEY, Flags: ULONG, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegConnectRegistryExW".}
  proc RegCreateKey*(hKey: HKEY, lpSubKey: LPCWSTR, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegCreateKeyW".}
  proc RegCreateKeyEx*(hKey: HKEY, lpSubKey: LPCWSTR, Reserved: DWORD, lpClass: LPWSTR, dwOptions: DWORD, samDesired: REGSAM, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, phkResult: PHKEY, lpdwDisposition: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegCreateKeyExW".}
  proc RegDeleteKey*(hKey: HKEY, lpSubKey: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteKeyW".}
  proc RegDeleteKeyEx*(hKey: HKEY, lpSubKey: LPCWSTR, samDesired: REGSAM, Reserved: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteKeyExW".}
  proc RegDeleteValue*(hKey: HKEY, lpValueName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteValueW".}
  proc RegEnumKey*(hKey: HKEY, dwIndex: DWORD, lpName: LPWSTR, cchName: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegEnumKeyW".}
  proc RegEnumKeyEx*(hKey: HKEY, dwIndex: DWORD, lpName: LPWSTR, lpcchName: LPDWORD, lpReserved: LPDWORD, lpClass: LPWSTR, lpcchClass: LPDWORD, lpftLastWriteTime: PFILETIME): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegEnumKeyExW".}
  proc RegEnumValue*(hKey: HKEY, dwIndex: DWORD, lpValueName: LPWSTR, lpcchValueName: LPDWORD, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegEnumValueW".}
  proc RegLoadKey*(hKey: HKEY, lpSubKey: LPCWSTR, lpFile: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegLoadKeyW".}
  proc RegOpenKey*(hKey: HKEY, lpSubKey: LPCWSTR, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegOpenKeyW".}
  proc RegOpenKeyEx*(hKey: HKEY, lpSubKey: LPCWSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegOpenKeyExW".}
  proc RegQueryInfoKey*(hKey: HKEY, lpClass: LPWSTR, lpcchClass: LPDWORD, lpReserved: LPDWORD, lpcSubKeys: LPDWORD, lpcbMaxSubKeyLen: LPDWORD, lpcbMaxClassLen: LPDWORD, lpcValues: LPDWORD, lpcbMaxValueNameLen: LPDWORD, lpcbMaxValueLen: LPDWORD, lpcbSecurityDescriptor: LPDWORD, lpftLastWriteTime: PFILETIME): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegQueryInfoKeyW".}
  proc RegQueryValue*(hKey: HKEY, lpSubKey: LPCWSTR, lpData: LPWSTR, lpcbData: PLONG): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegQueryValueW".}
  proc RegQueryMultipleValues*(hKey: HKEY, val_list: PVALENTW, num_vals: DWORD, lpValueBuf: LPWSTR, ldwTotsize: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegQueryMultipleValuesW".}
  proc RegQueryValueEx*(hKey: HKEY, lpValueName: LPCWSTR, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegQueryValueExW".}
  proc RegReplaceKey*(hKey: HKEY, lpSubKey: LPCWSTR, lpNewFile: LPCWSTR, lpOldFile: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegReplaceKeyW".}
  proc RegRestoreKey*(hKey: HKEY, lpFile: LPCWSTR, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegRestoreKeyW".}
  proc RegSaveKey*(hKey: HKEY, lpFile: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSaveKeyW".}
  proc RegSetValue*(hKey: HKEY, lpSubKey: LPCWSTR, dwType: DWORD, lpData: LPCWSTR, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSetValueW".}
  proc RegSetValueEx*(hKey: HKEY, lpValueName: LPCWSTR, Reserved: DWORD, dwType: DWORD, lpData: ptr BYTE, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSetValueExW".}
  proc RegUnLoadKey*(hKey: HKEY, lpSubKey: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegUnLoadKeyW".}
  proc RegGetValue*(hkey: HKEY, lpSubKey: LPCWSTR, lpValue: LPCWSTR, dwFlags: DWORD, pdwType: LPDWORD, pvData: PVOID, pcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegGetValueW".}
  proc InitiateSystemShutdown*(lpMachineName: LPWSTR, lpMessage: LPWSTR, dwTimeout: DWORD, bForceAppsClosed: WINBOOL, bRebootAfterShutdown: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "InitiateSystemShutdownW".}
  proc AbortSystemShutdown*(lpMachineName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AbortSystemShutdownW".}
  proc InitiateSystemShutdownEx*(lpMachineName: LPWSTR, lpMessage: LPWSTR, dwTimeout: DWORD, bForceAppsClosed: WINBOOL, bRebootAfterShutdown: WINBOOL, dwReason: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "InitiateSystemShutdownExW".}
  proc RegSaveKeyEx*(hKey: HKEY, lpFile: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, Flags: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSaveKeyExW".}
  proc RegCopyTree*(hKeySrc: HKEY, lpSubKey: LPCWSTR, hKeyDest: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegCopyTreeW".}
  proc RegCreateKeyTransacted*(hKey: HKEY, lpSubKey: LPCWSTR, Reserved: DWORD, lpClass: LPWSTR, dwOptions: DWORD, samDesired: REGSAM, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, phkResult: PHKEY, lpdwDisposition: LPDWORD, hTransaction: HANDLE, pExtendedParemeter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegCreateKeyTransactedW".}
  proc RegDeleteKeyTransacted*(hKey: HKEY, lpSubKey: LPCWSTR, samDesired: REGSAM, Reserved: DWORD, hTransaction: HANDLE, pExtendedParameter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteKeyTransactedW".}
  proc RegDeleteKeyValue*(hKey: HKEY, lpSubKey: LPCWSTR, lpValueName: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteKeyValueW".}
  proc RegDeleteTree*(hKey: HKEY, lpSubKey: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteTreeW".}
  proc RegLoadAppKey*(lpFile: LPCWSTR, phkResult: PHKEY, samDesired: REGSAM, dwOptions: DWORD, Reserved: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegLoadAppKeyW".}
  proc RegLoadMUIString*(hKey: HKEY, pszValue: LPCWSTR, pszOutBuf: LPWSTR, cbOutBuf: DWORD, pcbData: LPDWORD, Flags: DWORD, pszDirectory: LPCWSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegLoadMUIStringW".}
  proc RegOpenKeyTransacted*(hKey: HKEY, lpSubKey: LPCWSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY, hTransaction: HANDLE, pExtendedParameter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegOpenKeyTransactedW".}
  proc RegSetKeyValue*(hKey: HKEY, lpSubKey: LPCSTR, lpValueName: LPCSTR, dwType: DWORD, lpData: LPCVOID, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSetKeyValueW".}
  proc InitiateShutdown*(lpMachineName: LPWSTR, lpMessage: LPWSTR, dwGracePeriod: DWORD, dwShutdownFlags: DWORD, dwReason: DWORD): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "InitiateShutdownW".}
when winimAnsi:
  type
    PVALUE* = PVALUEA
    PPVALUE* = PPVALUEA
    VALENT* = VALENTA
    PVALENT* = PVALENTA
  proc RegConnectRegistry*(lpMachineName: LPCSTR, hKey: HKEY, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegConnectRegistryA".}
  proc RegConnectRegistryEx*(lpMachineName: LPCSTR, hKey: HKEY, Flags: ULONG, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegConnectRegistryExA".}
  proc RegCreateKey*(hKey: HKEY, lpSubKey: LPCSTR, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegCreateKeyA".}
  proc RegCreateKeyEx*(hKey: HKEY, lpSubKey: LPCSTR, Reserved: DWORD, lpClass: LPSTR, dwOptions: DWORD, samDesired: REGSAM, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, phkResult: PHKEY, lpdwDisposition: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegCreateKeyExA".}
  proc RegDeleteKey*(hKey: HKEY, lpSubKey: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteKeyA".}
  proc RegDeleteKeyEx*(hKey: HKEY, lpSubKey: LPCSTR, samDesired: REGSAM, Reserved: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteKeyExA".}
  proc RegDeleteValue*(hKey: HKEY, lpValueName: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteValueA".}
  proc RegEnumKey*(hKey: HKEY, dwIndex: DWORD, lpName: LPSTR, cchName: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegEnumKeyA".}
  proc RegEnumKeyEx*(hKey: HKEY, dwIndex: DWORD, lpName: LPSTR, lpcchName: LPDWORD, lpReserved: LPDWORD, lpClass: LPSTR, lpcchClass: LPDWORD, lpftLastWriteTime: PFILETIME): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegEnumKeyExA".}
  proc RegEnumValue*(hKey: HKEY, dwIndex: DWORD, lpValueName: LPSTR, lpcchValueName: LPDWORD, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegEnumValueA".}
  proc RegLoadKey*(hKey: HKEY, lpSubKey: LPCSTR, lpFile: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegLoadKeyA".}
  proc RegOpenKey*(hKey: HKEY, lpSubKey: LPCSTR, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegOpenKeyA".}
  proc RegOpenKeyEx*(hKey: HKEY, lpSubKey: LPCSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegOpenKeyExA".}
  proc RegQueryInfoKey*(hKey: HKEY, lpClass: LPSTR, lpcchClass: LPDWORD, lpReserved: LPDWORD, lpcSubKeys: LPDWORD, lpcbMaxSubKeyLen: LPDWORD, lpcbMaxClassLen: LPDWORD, lpcValues: LPDWORD, lpcbMaxValueNameLen: LPDWORD, lpcbMaxValueLen: LPDWORD, lpcbSecurityDescriptor: LPDWORD, lpftLastWriteTime: PFILETIME): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegQueryInfoKeyA".}
  proc RegQueryValue*(hKey: HKEY, lpSubKey: LPCSTR, lpData: LPSTR, lpcbData: PLONG): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegQueryValueA".}
  proc RegQueryMultipleValues*(hKey: HKEY, val_list: PVALENTA, num_vals: DWORD, lpValueBuf: LPSTR, ldwTotsize: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegQueryMultipleValuesA".}
  proc RegQueryValueEx*(hKey: HKEY, lpValueName: LPCSTR, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegQueryValueExA".}
  proc RegReplaceKey*(hKey: HKEY, lpSubKey: LPCSTR, lpNewFile: LPCSTR, lpOldFile: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegReplaceKeyA".}
  proc RegRestoreKey*(hKey: HKEY, lpFile: LPCSTR, dwFlags: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegRestoreKeyA".}
  proc RegSaveKey*(hKey: HKEY, lpFile: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSaveKeyA".}
  proc RegSetValue*(hKey: HKEY, lpSubKey: LPCSTR, dwType: DWORD, lpData: LPCSTR, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSetValueA".}
  proc RegSetValueEx*(hKey: HKEY, lpValueName: LPCSTR, Reserved: DWORD, dwType: DWORD, lpData: ptr BYTE, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSetValueExA".}
  proc RegUnLoadKey*(hKey: HKEY, lpSubKey: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegUnLoadKeyA".}
  proc RegGetValue*(hkey: HKEY, lpSubKey: LPCSTR, lpValue: LPCSTR, dwFlags: DWORD, pdwType: LPDWORD, pvData: PVOID, pcbData: LPDWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegGetValueA".}
  proc InitiateSystemShutdown*(lpMachineName: LPSTR, lpMessage: LPSTR, dwTimeout: DWORD, bForceAppsClosed: WINBOOL, bRebootAfterShutdown: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "InitiateSystemShutdownA".}
  proc AbortSystemShutdown*(lpMachineName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AbortSystemShutdownA".}
  proc InitiateSystemShutdownEx*(lpMachineName: LPSTR, lpMessage: LPSTR, dwTimeout: DWORD, bForceAppsClosed: WINBOOL, bRebootAfterShutdown: WINBOOL, dwReason: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "InitiateSystemShutdownExA".}
  proc RegSaveKeyEx*(hKey: HKEY, lpFile: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, Flags: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSaveKeyExA".}
  proc RegCopyTree*(hKeySrc: HKEY, lpSubKey: LPCSTR, hKeyDest: HKEY): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegCopyTreeA".}
  proc RegCreateKeyTransacted*(hKey: HKEY, lpSubKey: LPCSTR, Reserved: DWORD, lpClass: LPSTR, dwOptions: DWORD, samDesired: REGSAM, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, phkResult: PHKEY, lpdwDisposition: LPDWORD, hTransaction: HANDLE, pExtendedParemeter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegCreateKeyTransactedA".}
  proc RegDeleteKeyTransacted*(hKey: HKEY, lpSubKey: LPCSTR, samDesired: REGSAM, Reserved: DWORD, hTransaction: HANDLE, pExtendedParameter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteKeyTransactedA".}
  proc RegDeleteKeyValue*(hKey: HKEY, lpSubKey: LPCSTR, lpValueName: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteKeyValueA".}
  proc RegDeleteTree*(hKey: HKEY, lpSubKey: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegDeleteTreeA".}
  proc RegLoadAppKey*(lpFile: LPCSTR, phkResult: PHKEY, samDesired: REGSAM, dwOptions: DWORD, Reserved: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegLoadAppKeyA".}
  proc RegLoadMUIString*(hKey: HKEY, pszValue: LPCSTR, pszOutBuf: LPSTR, cbOutBuf: DWORD, pcbData: LPDWORD, Flags: DWORD, pszDirectory: LPCSTR): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegLoadMUIStringA".}
  proc RegOpenKeyTransacted*(hKey: HKEY, lpSubKey: LPCSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY, hTransaction: HANDLE, pExtendedParameter: PVOID): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegOpenKeyTransactedA".}
  proc RegSetKeyValue*(hKey: HKEY, lpSubKey: LPCSTR, lpValueName: LPCSTR, dwType: DWORD, lpData: LPCVOID, cbData: DWORD): LONG {.winapi, stdcall, dynlib: "advapi32", importc: "RegSetKeyValueA".}
  proc InitiateShutdown*(lpMachineName: LPSTR, lpMessage: LPSTR, dwGracePeriod: DWORD, dwShutdownFlags: DWORD, dwReason: DWORD): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "InitiateShutdownA".}
