#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <powrprof.h>
type
  POWER_DATA_ACCESSOR* = int32
  PPOWER_DATA_ACCESSOR* = ptr int32
  GLOBAL_MACHINE_POWER_POLICY* {.pure.} = object
    Revision*: ULONG
    LidOpenWakeAc*: SYSTEM_POWER_STATE
    LidOpenWakeDc*: SYSTEM_POWER_STATE
    BroadcastCapacityResolution*: ULONG
  PGLOBAL_MACHINE_POWER_POLICY* = ptr GLOBAL_MACHINE_POWER_POLICY
  GLOBAL_USER_POWER_POLICY* {.pure.} = object
    Revision*: ULONG
    PowerButtonAc*: POWER_ACTION_POLICY
    PowerButtonDc*: POWER_ACTION_POLICY
    SleepButtonAc*: POWER_ACTION_POLICY
    SleepButtonDc*: POWER_ACTION_POLICY
    LidCloseAc*: POWER_ACTION_POLICY
    LidCloseDc*: POWER_ACTION_POLICY
    DischargePolicy*: array[NUM_DISCHARGE_POLICIES, SYSTEM_POWER_LEVEL]
    GlobalFlags*: ULONG
  PGLOBAL_USER_POWER_POLICY* = ptr GLOBAL_USER_POWER_POLICY
  GLOBAL_POWER_POLICY* {.pure.} = object
    user*: GLOBAL_USER_POWER_POLICY
    mach*: GLOBAL_MACHINE_POWER_POLICY
  PGLOBAL_POWER_POLICY* = ptr GLOBAL_POWER_POLICY
  MACHINE_POWER_POLICY* {.pure.} = object
    Revision*: ULONG
    MinSleepAc*: SYSTEM_POWER_STATE
    MinSleepDc*: SYSTEM_POWER_STATE
    ReducedLatencySleepAc*: SYSTEM_POWER_STATE
    ReducedLatencySleepDc*: SYSTEM_POWER_STATE
    DozeTimeoutAc*: ULONG
    DozeTimeoutDc*: ULONG
    DozeS4TimeoutAc*: ULONG
    DozeS4TimeoutDc*: ULONG
    MinThrottleAc*: UCHAR
    MinThrottleDc*: UCHAR
    pad1*: array[2, UCHAR]
    OverThrottledAc*: POWER_ACTION_POLICY
    OverThrottledDc*: POWER_ACTION_POLICY
  PMACHINE_POWER_POLICY* = ptr MACHINE_POWER_POLICY
  MACHINE_PROCESSOR_POWER_POLICY* {.pure.} = object
    Revision*: ULONG
    ProcessorPolicyAc*: PROCESSOR_POWER_POLICY
    ProcessorPolicyDc*: PROCESSOR_POWER_POLICY
  PMACHINE_PROCESSOR_POWER_POLICY* = ptr MACHINE_PROCESSOR_POWER_POLICY
  USER_POWER_POLICY* {.pure.} = object
    Revision*: ULONG
    IdleAc*: POWER_ACTION_POLICY
    IdleDc*: POWER_ACTION_POLICY
    IdleTimeoutAc*: ULONG
    IdleTimeoutDc*: ULONG
    IdleSensitivityAc*: UCHAR
    IdleSensitivityDc*: UCHAR
    ThrottlePolicyAc*: UCHAR
    ThrottlePolicyDc*: UCHAR
    MaxSleepAc*: SYSTEM_POWER_STATE
    MaxSleepDc*: SYSTEM_POWER_STATE
    Reserved*: array[2, ULONG]
    VideoTimeoutAc*: ULONG
    VideoTimeoutDc*: ULONG
    SpindownTimeoutAc*: ULONG
    SpindownTimeoutDc*: ULONG
    OptimizeForPowerAc*: BOOLEAN
    OptimizeForPowerDc*: BOOLEAN
    FanThrottleToleranceAc*: UCHAR
    FanThrottleToleranceDc*: UCHAR
    ForcedThrottleAc*: UCHAR
    ForcedThrottleDc*: UCHAR
  PUSER_POWER_POLICY* = ptr USER_POWER_POLICY
  POWER_POLICY* {.pure.} = object
    user*: USER_POWER_POLICY
    mach*: MACHINE_POWER_POLICY
  PPOWER_POLICY* = ptr POWER_POLICY
const
  enableSysTrayBatteryMeter* = 0x01
  enableMultiBatteryDisplay* = 0x02
  enablePasswordLogon* = 0x04
  enableWakeOnRing* = 0x08
  enableVideoDimDisplay* = 0x10
  NEWSCHEME* = UINT(-1)
  DEVICEPOWER_HARDWAREID* = 0x80000000'i32
  DEVICEPOWER_FILTER_DEVICES_PRESENT* = 0x20000000
  DEVICEPOWER_AND_OPERATION* = 0x40000000
  DEVICEPOWER_FILTER_WAKEENABLED* = 0x08000000
  DEVICEPOWER_FILTER_ON_NAME* = 0x02000000
  PDCAP_S0_SUPPORTED* = 0x00010000
  PDCAP_S1_SUPPORTED* = 0x00020000
  PDCAP_S2_SUPPORTED* = 0x00040000
  PDCAP_S3_SUPPORTED* = 0x00080000
  PDCAP_S4_SUPPORTED* = 0x01000000
  PDCAP_S5_SUPPORTED* = 0x02000000
  PDCAP_WAKE_FROM_S0_SUPPORTED* = 0x00100000
  PDCAP_WAKE_FROM_S1_SUPPORTED* = 0x00200000
  PDCAP_WAKE_FROM_S2_SUPPORTED* = 0x00400000
  PDCAP_WAKE_FROM_S3_SUPPORTED* = 0x00800000
  DEVICEPOWER_SET_WAKEENABLED* = 0x00000001
  DEVICEPOWER_CLEAR_WAKEENABLED* = 0x00000002
  ACCESS_AC_POWER_SETTING_INDEX* = 0
  ACCESS_DC_POWER_SETTING_INDEX* = 1
  ACCESS_SCHEME* = 16
  ACCESS_SUBGROUP* = 17
  ACCESS_INDIVIDUAL_SETTING* = 18
  ACCESS_ACTIVE_SCHEME* = 19
  ACCESS_CREATE_SCHEME* = 20
  POWER_ATTRIBUTE_HIDE* = 1
type
  PWRSCHEMESENUMPROC* = proc (P1: UINT, P2: DWORD, P3: LPTSTR, P4: DWORD, P5: LPTSTR, P6: PPOWER_POLICY, P7: LPARAM): BOOLEAN {.stdcall.}
  PFNNTINITIATEPWRACTION* = proc (P1: POWER_ACTION, P2: SYSTEM_POWER_STATE, P3: ULONG, P4: BOOLEAN): BOOLEAN {.stdcall.}
proc GetPwrDiskSpindownRange*(P1: PUINT, P2: PUINT): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc EnumPwrSchemes*(P1: PWRSCHEMESENUMPROC, P2: LPARAM): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc ReadGlobalPwrPolicy*(P1: PGLOBAL_POWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc ReadPwrScheme*(P1: UINT, P2: PPOWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc WritePwrScheme*(P1: PUINT, P2: LPTSTR, P3: LPTSTR, P4: PPOWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc WriteGlobalPwrPolicy*(P1: PGLOBAL_POWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc DeletePwrScheme*(P1: UINT): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc GetActivePwrScheme*(P1: PUINT): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc SetActivePwrScheme*(P1: UINT, P2: PGLOBAL_POWER_POLICY, P3: PPOWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc GetPwrCapabilities*(P1: PSYSTEM_POWER_CAPABILITIES): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc IsPwrSuspendAllowed*(): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc IsPwrHibernateAllowed*(): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc IsPwrShutdownAllowed*(): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc IsAdminOverrideActive*(P1: PADMINISTRATOR_POWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc SetSuspendState*(P1: BOOLEAN, P2: BOOLEAN, P3: BOOLEAN): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc GetCurrentPowerPolicies*(P1: PGLOBAL_POWER_POLICY, P2: PPOWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc CanUserWritePwrScheme*(): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc ReadProcessorPwrScheme*(P1: UINT, P2: PMACHINE_PROCESSOR_POWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc WriteProcessorPwrScheme*(P1: UINT, P2: PMACHINE_PROCESSOR_POWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc ValidatePowerPolicies*(P1: PGLOBAL_POWER_POLICY, P2: PPOWER_POLICY): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc DevicePowerClose*(): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc DevicePowerEnumDevices*(QueryIndex: ULONG, QueryInterpretationFlags: ULONG, QueryFlags: ULONG, pReturnBuffer: PBYTE, pBufferSize: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc DevicePowerOpen*(Flags: ULONG): BOOLEAN {.winapi, stdcall, dynlib: "powrprof", importc.}
proc DevicePowerSetDeviceState*(DeviceDescription: LPCWSTR, SetFlags: ULONG, SetData: LPCVOID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerCanRestoreIndividualDefaultPowerScheme*(SchemeGuid: ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerCreatePossibleSetting*(RootSystemPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, PossibleSettingIndex: ULONG): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerCreateSetting*(RootSystemPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerDeleteScheme*(RootPowerKey: HKEY, SchemeGuid: ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerDeterminePlatformRole*(): POWER_PLATFORM_ROLE {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerDuplicateScheme*(RootPowerKey: HKEY, SourceSchemeGuid: ptr GUID, DestinationSchemeGuid: ptr ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerEnumerate*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, AccessFlags: POWER_DATA_ACCESSOR, Index: ULONG, Buffer: ptr UCHAR, BufferSize: ptr DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerGetActiveScheme*(UserRootPowerKey: HKEY, ActivePolicyGuid: ptr ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerImportPowerScheme*(RootPowerKey: HKEY, ImportFileNamePath: LPCWSTR, DestinationSchemeGuid: ptr ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadACDefaultIndex*(RootPowerKey: HKEY, SchemePersonalityGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, AcDefaultIndex: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadACValue*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Type: PULONG, Buffer: LPBYTE, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadACValueIndex*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, AcValueIndex: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadDCDefaultIndex*(RootPowerKey: HKEY, SchemePersonalityGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, DcDefaultIndex: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadDCValue*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Type: PULONG, Buffer: PUCHAR, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadDCValueIndex*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, DcValueIndex: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadDescription*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Buffer: PUCHAR, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadFriendlyName*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Buffer: PUCHAR, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadIconResourceSpecifier*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Buffer: PUCHAR, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadPossibleDescription*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, PossibleSettingIndex: ULONG, Buffer: PUCHAR, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadPossibleFriendlyName*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, PossibleSettingIndex: ULONG, Buffer: PUCHAR, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadPossibleValue*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Type: PULONG, PossibleSettingIndex: ULONG, Buffer: PUCHAR, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadSettingAttributes*(SubGroupGuid: ptr GUID, PowerSettingGuid: ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadValueIncrement*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, ValueIncrement: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadValueMax*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, ValueMaximum: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadValueMin*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, ValueMinimum: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReadValueUnitsSpecifier*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Buffer: ptr UCHAR, BufferSize: LPDWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerRemovePowerSetting*(PowerSettingSubKeyGuid: ptr GUID, PowerSettingGuid: ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerReplaceDefaultPowerSchemes*(): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerRestoreDefaultPowerSchemes*(): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerRestoreIndividualDefaultPowerScheme*(SchemeGuid: ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerSetActiveScheme*(UserRootPowerKey: HKEY, SchemeGuid: ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerSettingAccessCheck*(AccessFlags: POWER_DATA_ACCESSOR, PowerGuid: ptr GUID): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteACDefaultIndex*(RootSystemPowerKey: HKEY, SchemePersonalityGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, DefaultAcIndex: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteACValueIndex*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, AcValueIndex: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteDCDefaultIndex*(RootSystemPowerKey: HKEY, SchemePersonalityGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, DefaultDcIndex: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteDCValueIndex*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, DcValueIndex: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteDescription*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Buffer: ptr UCHAR, BufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteFriendlyName*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Buffer: ptr UCHAR, BufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteIconResourceSpecifier*(RootPowerKey: HKEY, SchemeGuid: ptr GUID, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Buffer: ptr UCHAR, BufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWritePossibleDescription*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, PossibleSettingIndex: ULONG, Buffer: ptr UCHAR, BufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWritePossibleFriendlyName*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, PossibleSettingIndex: ULONG, Buffer: ptr UCHAR, BufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWritePossibleValue*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Type: ULONG, PossibleSettingIndex: ULONG, Buffer: ptr UCHAR, BufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteSettingAttributes*(SubGroupGuid: ptr GUID, PowerSettingGuid: ptr GUID, Attributes: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteValueIncrement*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, ValueIncrement: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteValueMax*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, ValueMaximum: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteValueMin*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, ValueMinimum: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc PowerWriteValueUnitsSpecifier*(RootPowerKey: HKEY, SubGroupOfPowerSettingsGuid: ptr GUID, PowerSettingGuid: ptr GUID, Buffer: ptr UCHAR, BufferSize: DWORD): DWORD {.winapi, stdcall, dynlib: "powrprof", importc.}
proc CallNtPowerInformation*(P1: POWER_INFORMATION_LEVEL, P2: PVOID, P3: ULONG, P4: PVOID, P5: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "powrprof", importc.}
