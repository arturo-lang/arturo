#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <psapi.h>
type
  MODULEINFO* {.pure.} = object
    lpBaseOfDll*: LPVOID
    SizeOfImage*: DWORD
    EntryPoint*: LPVOID
  LPMODULEINFO* = ptr MODULEINFO
  PSAPI_WS_WATCH_INFORMATION* {.pure.} = object
    FaultingPc*: LPVOID
    FaultingVa*: LPVOID
  PPSAPI_WS_WATCH_INFORMATION* = ptr PSAPI_WS_WATCH_INFORMATION
  PROCESS_MEMORY_COUNTERS* {.pure.} = object
    cb*: DWORD
    PageFaultCount*: DWORD
    PeakWorkingSetSize*: SIZE_T
    WorkingSetSize*: SIZE_T
    QuotaPeakPagedPoolUsage*: SIZE_T
    QuotaPagedPoolUsage*: SIZE_T
    QuotaPeakNonPagedPoolUsage*: SIZE_T
    QuotaNonPagedPoolUsage*: SIZE_T
    PagefileUsage*: SIZE_T
    PeakPagefileUsage*: SIZE_T
  PPROCESS_MEMORY_COUNTERS* = ptr PROCESS_MEMORY_COUNTERS
  PROCESS_MEMORY_COUNTERS_EX* {.pure.} = object
    cb*: DWORD
    PageFaultCount*: DWORD
    PeakWorkingSetSize*: SIZE_T
    WorkingSetSize*: SIZE_T
    QuotaPeakPagedPoolUsage*: SIZE_T
    QuotaPagedPoolUsage*: SIZE_T
    QuotaPeakNonPagedPoolUsage*: SIZE_T
    QuotaNonPagedPoolUsage*: SIZE_T
    PagefileUsage*: SIZE_T
    PeakPagefileUsage*: SIZE_T
    PrivateUsage*: SIZE_T
  PPROCESS_MEMORY_COUNTERS_EX* = ptr PROCESS_MEMORY_COUNTERS_EX
  PERFORMANCE_INFORMATION* {.pure.} = object
    cb*: DWORD
    CommitTotal*: SIZE_T
    CommitLimit*: SIZE_T
    CommitPeak*: SIZE_T
    PhysicalTotal*: SIZE_T
    PhysicalAvailable*: SIZE_T
    SystemCache*: SIZE_T
    KernelTotal*: SIZE_T
    KernelPaged*: SIZE_T
    KernelNonpaged*: SIZE_T
    PageSize*: SIZE_T
    HandleCount*: DWORD
    ProcessCount*: DWORD
    ThreadCount*: DWORD
  PPERFORMANCE_INFORMATION* = ptr PERFORMANCE_INFORMATION
  PERFORMACE_INFORMATION* = PERFORMANCE_INFORMATION
  PPERFORMACE_INFORMATION* = ptr PERFORMANCE_INFORMATION
  ENUM_PAGE_FILE_INFORMATION* {.pure.} = object
    cb*: DWORD
    Reserved*: DWORD
    TotalSize*: SIZE_T
    TotalInUse*: SIZE_T
    PeakUsage*: SIZE_T
  PENUM_PAGE_FILE_INFORMATION* = ptr ENUM_PAGE_FILE_INFORMATION
  PSAPI_WS_WATCH_INFORMATION_EX* {.pure.} = object
    BasicInfo*: PSAPI_WS_WATCH_INFORMATION
    FaultingThreadId*: ULONG_PTR
    Flags*: ULONG_PTR
  PPSAPI_WS_WATCH_INFORMATION_EX* = ptr PSAPI_WS_WATCH_INFORMATION_EX
when winimCpu64:
  type
    PSAPI_WORKING_SET_BLOCK_STRUCT1* {.pure.} = object
      Protection* {.bitsize:5.}: ULONG_PTR
      ShareCount* {.bitsize:3.}: ULONG_PTR
      Shared* {.bitsize:1.}: ULONG_PTR
      Reserved* {.bitsize:3.}: ULONG_PTR
      VirtualPage* {.bitsize:52.}: ULONG_PTR
when winimCpu32:
  type
    PSAPI_WORKING_SET_BLOCK_STRUCT1* {.pure.} = object
      Protection* {.bitsize:5.}: ULONG_PTR
      ShareCount* {.bitsize:3.}: ULONG_PTR
      Shared* {.bitsize:1.}: ULONG_PTR
      Reserved* {.bitsize:3.}: ULONG_PTR
      VirtualPage* {.bitsize:20.}: ULONG_PTR
when winimCpu64:
  type
    PSAPI_WORKING_SET_BLOCK* {.pure, union.} = object
      Flags*: ULONG_PTR
      struct1*: PSAPI_WORKING_SET_BLOCK_STRUCT1
when winimCpu32:
  type
    PSAPI_WORKING_SET_BLOCK* {.pure, union.} = object
      Flags*: ULONG_PTR
      struct1*: PSAPI_WORKING_SET_BLOCK_STRUCT1
type
  PSAPI_WORKING_SET_INFORMATION* {.pure.} = object
    NumberOfEntries*: ULONG_PTR
    WorkingSetInfo*: array[1, PSAPI_WORKING_SET_BLOCK]
  PPSAPI_WORKING_SET_INFORMATION* = ptr PSAPI_WORKING_SET_INFORMATION
  PSAPI_WORKING_SET_EX_BLOCK_STRUCT1* {.pure.} = object
    Valid* {.bitsize:1.}: ULONG_PTR
    ShareCount* {.bitsize:3.}: ULONG_PTR
    Win32Protection* {.bitsize:11.}: ULONG_PTR
    Shared* {.bitsize:1.}: ULONG_PTR
    Node* {.bitsize:6.}: ULONG_PTR
    Locked* {.bitsize:1.}: ULONG_PTR
    LargePage* {.bitsize:1.}: ULONG_PTR
  PSAPI_WORKING_SET_EX_BLOCK* {.pure, union.} = object
    Flags*: ULONG_PTR
    struct1*: PSAPI_WORKING_SET_EX_BLOCK_STRUCT1
  PPSAPI_WORKING_SET_EX_BLOCK* = ptr PSAPI_WORKING_SET_EX_BLOCK
  PSAPI_WORKING_SET_EX_INFORMATION* {.pure.} = object
    VirtualAddress*: PVOID
    VirtualAttributes*: PSAPI_WORKING_SET_EX_BLOCK
  PPSAPI_WORKING_SET_EX_INFORMATION* = ptr PSAPI_WORKING_SET_EX_INFORMATION
const
  LIST_MODULES_DEFAULT* = 0x0
  LIST_MODULES_32BIT* = 0x01
  LIST_MODULES_64BIT* = 0x02
  LIST_MODULES_ALL* = LIST_MODULES_32BIT or LIST_MODULES_64BIT
type
  PENUM_PAGE_FILE_CALLBACKW* = proc (pContext: LPVOID, pPageFileInfo: PENUM_PAGE_FILE_INFORMATION, lpFilename: LPCWSTR): WINBOOL {.stdcall.}
  PENUM_PAGE_FILE_CALLBACKA* = proc (pContext: LPVOID, pPageFileInfo: PENUM_PAGE_FILE_INFORMATION, lpFilename: LPCSTR): WINBOOL {.stdcall.}
proc EnumProcesses*(lpidProcess: ptr DWORD, cb: DWORD, cbNeeded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc EnumProcessModules*(hProcess: HANDLE, lphModule: ptr HMODULE, cb: DWORD, lpcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetModuleBaseNameA*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetModuleBaseNameW*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetModuleFileNameExA*(hProcess: HANDLE, hModule: HMODULE, lpFilename: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetModuleFileNameExW*(hProcess: HANDLE, hModule: HMODULE, lpFilename: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetModuleInformation*(hProcess: HANDLE, hModule: HMODULE, lpmodinfo: LPMODULEINFO, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc EmptyWorkingSet*(hProcess: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc QueryWorkingSet*(hProcess: HANDLE, pv: PVOID, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc QueryWorkingSetEx*(hProcess: HANDLE, pv: PVOID, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc InitializeProcessForWsWatch*(hProcess: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetWsChanges*(hProcess: HANDLE, lpWatchInfo: PPSAPI_WS_WATCH_INFORMATION, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetMappedFileNameW*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetMappedFileNameA*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc EnumDeviceDrivers*(lpImageBase: ptr LPVOID, cb: DWORD, lpcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetDeviceDriverBaseNameA*(ImageBase: LPVOID, lpBaseName: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetDeviceDriverBaseNameW*(ImageBase: LPVOID, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetDeviceDriverFileNameA*(ImageBase: LPVOID, lpFilename: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetDeviceDriverFileNameW*(ImageBase: LPVOID, lpFilename: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetProcessMemoryInfo*(Process: HANDLE, ppsmemCounters: PPROCESS_MEMORY_COUNTERS, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetPerformanceInfo*(pPerformanceInformation: PPERFORMACE_INFORMATION, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc EnumPageFilesW*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKW, pContext: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc EnumPageFilesA*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKA, pContext: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetProcessImageFileNameA*(hProcess: HANDLE, lpImageFileName: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetProcessImageFileNameW*(hProcess: HANDLE, lpImageFileName: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc.}
proc GetWsChangesEx*(hProcess: HANDLE, lpWatchInfoEx: PPSAPI_WS_WATCH_INFORMATION_EX, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc EnumProcessModulesEx*(hProcess: HANDLE, lphModule: ptr HMODULE, cb: DWORD, lpcbNeeded: LPDWORD, dwFilterFlag: DWORD): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc.}
proc `Valid=`*(self: var PSAPI_WORKING_SET_EX_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Valid = x
proc Valid*(self: PSAPI_WORKING_SET_EX_BLOCK): ULONG_PTR {.inline.} = self.struct1.Valid
proc `ShareCount=`*(self: var PSAPI_WORKING_SET_EX_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.ShareCount = x
proc ShareCount*(self: PSAPI_WORKING_SET_EX_BLOCK): ULONG_PTR {.inline.} = self.struct1.ShareCount
proc `Win32Protection=`*(self: var PSAPI_WORKING_SET_EX_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Win32Protection = x
proc Win32Protection*(self: PSAPI_WORKING_SET_EX_BLOCK): ULONG_PTR {.inline.} = self.struct1.Win32Protection
proc `Shared=`*(self: var PSAPI_WORKING_SET_EX_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Shared = x
proc Shared*(self: PSAPI_WORKING_SET_EX_BLOCK): ULONG_PTR {.inline.} = self.struct1.Shared
proc `Node=`*(self: var PSAPI_WORKING_SET_EX_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Node = x
proc Node*(self: PSAPI_WORKING_SET_EX_BLOCK): ULONG_PTR {.inline.} = self.struct1.Node
proc `Locked=`*(self: var PSAPI_WORKING_SET_EX_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Locked = x
proc Locked*(self: PSAPI_WORKING_SET_EX_BLOCK): ULONG_PTR {.inline.} = self.struct1.Locked
proc `LargePage=`*(self: var PSAPI_WORKING_SET_EX_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.LargePage = x
proc LargePage*(self: PSAPI_WORKING_SET_EX_BLOCK): ULONG_PTR {.inline.} = self.struct1.LargePage
when winimUnicode:
  type
    PENUM_PAGE_FILE_CALLBACK* = PENUM_PAGE_FILE_CALLBACKW
  proc GetModuleBaseName*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetModuleBaseNameW".}
  proc GetModuleFileNameEx*(hProcess: HANDLE, hModule: HMODULE, lpFilename: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetModuleFileNameExW".}
  proc GetMappedFileName*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetMappedFileNameW".}
  proc GetDeviceDriverBaseName*(ImageBase: LPVOID, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetDeviceDriverBaseNameW".}
  proc GetDeviceDriverFileName*(ImageBase: LPVOID, lpFilename: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetDeviceDriverFileNameW".}
  proc EnumPageFiles*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKW, pContext: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc: "EnumPageFilesW".}
  proc GetProcessImageFileName*(hProcess: HANDLE, lpImageFileName: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetProcessImageFileNameW".}
when winimAnsi:
  type
    PENUM_PAGE_FILE_CALLBACK* = PENUM_PAGE_FILE_CALLBACKA
  proc GetModuleBaseName*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetModuleBaseNameA".}
  proc GetModuleFileNameEx*(hProcess: HANDLE, hModule: HMODULE, lpFilename: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetModuleFileNameExA".}
  proc GetMappedFileName*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetMappedFileNameA".}
  proc GetDeviceDriverBaseName*(ImageBase: LPVOID, lpBaseName: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetDeviceDriverBaseNameA".}
  proc GetDeviceDriverFileName*(ImageBase: LPVOID, lpFilename: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetDeviceDriverFileNameA".}
  proc EnumPageFiles*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKA, pContext: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "psapi", importc: "EnumPageFilesA".}
  proc GetProcessImageFileName*(hProcess: HANDLE, lpImageFileName: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "psapi", importc: "GetProcessImageFileNameA".}
when winimCpu64:
  type
    PPSAPI_WORKING_SET_BLOCK* = ptr PSAPI_WORKING_SET_BLOCK
  proc `Protection=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Protection = x
  proc Protection*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.Protection
  proc `ShareCount=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.ShareCount = x
  proc ShareCount*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.ShareCount
  proc `Shared=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Shared = x
  proc Shared*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.Shared
  proc `Reserved=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Reserved = x
  proc Reserved*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.Reserved
  proc `VirtualPage=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.VirtualPage = x
  proc VirtualPage*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.VirtualPage
when winimCpu32:
  type
    PPSAPI_WORKING_SET_BLOCK* = ptr PSAPI_WORKING_SET_BLOCK
  proc `Protection=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Protection = x
  proc Protection*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.Protection
  proc `ShareCount=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.ShareCount = x
  proc ShareCount*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.ShareCount
  proc `Shared=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Shared = x
  proc Shared*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.Shared
  proc `Reserved=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.Reserved = x
  proc Reserved*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.Reserved
  proc `VirtualPage=`*(self: var PSAPI_WORKING_SET_BLOCK, x: ULONG_PTR) {.inline.} = self.struct1.VirtualPage = x
  proc VirtualPage*(self: PSAPI_WORKING_SET_BLOCK): ULONG_PTR {.inline.} = self.struct1.VirtualPage
