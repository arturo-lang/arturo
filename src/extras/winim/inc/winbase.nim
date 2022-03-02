#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <winbase.h>
#include <minwinbase.h>
#include <bemapiset.h>
#include <debugapi.h>
#include <errhandlingapi.h>
#include <fibersapi.h>
#include <fileapi.h>
#include <handleapi.h>
#include <heapapi.h>
#include <ioapiset.h>
#include <interlockedapi.h>
#include <jobapi.h>
#include <libloaderapi.h>
#include <memoryapi.h>
#include <namedpipeapi.h>
#include <namespaceapi.h>
#include <processenv.h>
#include <processthreadsapi.h>
#include <processtopologyapi.h>
#include <profileapi.h>
#include <realtimeapiset.h>
#include <securityappcontainer.h>
#include <securitybaseapi.h>
#include <synchapi.h>
#include <sysinfoapi.h>
#include <systemtopologyapi.h>
#include <threadpoolapiset.h>
#include <threadpoollegacyapiset.h>
#include <utilapiset.h>
#include <wow64apiset.h>
#include <timezoneapi.h>
type
  FINDEX_INFO_LEVELS* = int32
  FINDEX_SEARCH_OPS* = int32
  GET_FILEEX_INFO_LEVELS* = int32
  FILE_INFO_BY_HANDLE_CLASS* = int32
  PFILE_INFO_BY_HANDLE_CLASS* = ptr int32
  MEMORY_RESOURCE_NOTIFICATION_TYPE* = int32
  OFFER_PRIORITY* = int32
  COMPUTER_NAME_FORMAT* = int32
  THREAD_INFORMATION_CLASS* = int32
  PROCESS_INFORMATION_CLASS* = int32
  DEP_SYSTEM_POLICY_TYPE* = int32
  PROC_THREAD_ATTRIBUTE_NUM* = int32
  COPYFILE2_MESSAGE_TYPE* = int32
  COPYFILE2_MESSAGE_ACTION* = int32
  COPYFILE2_COPY_PHASE* = int32
  STREAM_INFO_LEVELS* = int32
  PRIORITY_HINT* = int32
  FILE_ID_TYPE* = int32
  PFILE_ID_TYPE* = ptr int32
  BAD_MEMORY_CALLBACK_ROUTINE* = pointer
  DLL_DIRECTORY_COOKIE* = PVOID
  PDLL_DIRECTORY_COOKIE* = ptr PVOID
  OPERATION_ID* = ULONG
  SECURITY_ATTRIBUTES* {.pure.} = object
    nLength*: DWORD
    lpSecurityDescriptor*: LPVOID
    bInheritHandle*: WINBOOL
  PSECURITY_ATTRIBUTES* = ptr SECURITY_ATTRIBUTES
  LPSECURITY_ATTRIBUTES* = ptr SECURITY_ATTRIBUTES
  OVERLAPPED_UNION1_STRUCT1* {.pure.} = object
    Offset*: DWORD
    OffsetHigh*: DWORD
  OVERLAPPED_UNION1* {.pure, union.} = object
    struct1*: OVERLAPPED_UNION1_STRUCT1
    Pointer*: PVOID
  OVERLAPPED* {.pure.} = object
    Internal*: ULONG_PTR
    InternalHigh*: ULONG_PTR
    union1*: OVERLAPPED_UNION1
    hEvent*: HANDLE
  LPOVERLAPPED* = ptr OVERLAPPED
  OVERLAPPED_ENTRY* {.pure.} = object
    lpCompletionKey*: ULONG_PTR
    lpOverlapped*: LPOVERLAPPED
    Internal*: ULONG_PTR
    dwNumberOfBytesTransferred*: DWORD
  LPOVERLAPPED_ENTRY* = ptr OVERLAPPED_ENTRY
  SYSTEMTIME* {.pure.} = object
    wYear*: WORD
    wMonth*: WORD
    wDayOfWeek*: WORD
    wDay*: WORD
    wHour*: WORD
    wMinute*: WORD
    wSecond*: WORD
    wMilliseconds*: WORD
  PSYSTEMTIME* = ptr SYSTEMTIME
  LPSYSTEMTIME* = ptr SYSTEMTIME
  WIN32_FIND_DATAA* {.pure.} = object
    dwFileAttributes*: DWORD
    ftCreationTime*: FILETIME
    ftLastAccessTime*: FILETIME
    ftLastWriteTime*: FILETIME
    nFileSizeHigh*: DWORD
    nFileSizeLow*: DWORD
    dwReserved0*: DWORD
    dwReserved1*: DWORD
    cFileName*: array[MAX_PATH, CHAR]
    cAlternateFileName*: array[14, CHAR]
  PWIN32_FIND_DATAA* = ptr WIN32_FIND_DATAA
  LPWIN32_FIND_DATAA* = ptr WIN32_FIND_DATAA
  WIN32_FIND_DATAW* {.pure.} = object
    dwFileAttributes*: DWORD
    ftCreationTime*: FILETIME
    ftLastAccessTime*: FILETIME
    ftLastWriteTime*: FILETIME
    nFileSizeHigh*: DWORD
    nFileSizeLow*: DWORD
    dwReserved0*: DWORD
    dwReserved1*: DWORD
    cFileName*: array[MAX_PATH, WCHAR]
    cAlternateFileName*: array[14, WCHAR]
  PWIN32_FIND_DATAW* = ptr WIN32_FIND_DATAW
  LPWIN32_FIND_DATAW* = ptr WIN32_FIND_DATAW
  CRITICAL_SECTION* = RTL_CRITICAL_SECTION
  PCRITICAL_SECTION* = PRTL_CRITICAL_SECTION
  LPCRITICAL_SECTION* = PRTL_CRITICAL_SECTION
  CRITICAL_SECTION_DEBUG* = RTL_CRITICAL_SECTION_DEBUG
  PCRITICAL_SECTION_DEBUG* = PRTL_CRITICAL_SECTION_DEBUG
  LPCRITICAL_SECTION_DEBUG* = PRTL_CRITICAL_SECTION_DEBUG
  PROCESS_HEAP_ENTRY_UNION1_Block* {.pure.} = object
    hMem*: HANDLE
    dwReserved*: array[3, DWORD]
  PROCESS_HEAP_ENTRY_UNION1_Region* {.pure.} = object
    dwCommittedSize*: DWORD
    dwUnCommittedSize*: DWORD
    lpFirstBlock*: LPVOID
    lpLastBlock*: LPVOID
  PROCESS_HEAP_ENTRY_UNION1* {.pure, union.} = object
    Block*: PROCESS_HEAP_ENTRY_UNION1_Block
    Region*: PROCESS_HEAP_ENTRY_UNION1_Region
  PROCESS_HEAP_ENTRY* {.pure.} = object
    lpData*: PVOID
    cbData*: DWORD
    cbOverhead*: BYTE
    iRegionIndex*: BYTE
    wFlags*: WORD
    union1*: PROCESS_HEAP_ENTRY_UNION1
  LPPROCESS_HEAP_ENTRY* = ptr PROCESS_HEAP_ENTRY
  PPROCESS_HEAP_ENTRY* = ptr PROCESS_HEAP_ENTRY
  REASON_CONTEXT_Reason_Detailed* {.pure.} = object
    LocalizedReasonModule*: HMODULE
    LocalizedReasonId*: ULONG
    ReasonStringCount*: ULONG
    ReasonStrings*: ptr LPWSTR
  REASON_CONTEXT_Reason* {.pure, union.} = object
    Detailed*: REASON_CONTEXT_Reason_Detailed
    SimpleReasonString*: LPWSTR
  REASON_CONTEXT* {.pure.} = object
    Version*: ULONG
    Flags*: DWORD
    Reason*: REASON_CONTEXT_Reason
  PREASON_CONTEXT* = ptr REASON_CONTEXT
  PTHREAD_START_ROUTINE* = proc (lpThreadParameter: LPVOID): DWORD {.stdcall.}
  LPTHREAD_START_ROUTINE* = PTHREAD_START_ROUTINE
  EXCEPTION_DEBUG_INFO* {.pure.} = object
    ExceptionRecord*: EXCEPTION_RECORD
    dwFirstChance*: DWORD
  LPEXCEPTION_DEBUG_INFO* = ptr EXCEPTION_DEBUG_INFO
  CREATE_THREAD_DEBUG_INFO* {.pure.} = object
    hThread*: HANDLE
    lpThreadLocalBase*: LPVOID
    lpStartAddress*: LPTHREAD_START_ROUTINE
  LPCREATE_THREAD_DEBUG_INFO* = ptr CREATE_THREAD_DEBUG_INFO
  CREATE_PROCESS_DEBUG_INFO* {.pure.} = object
    hFile*: HANDLE
    hProcess*: HANDLE
    hThread*: HANDLE
    lpBaseOfImage*: LPVOID
    dwDebugInfoFileOffset*: DWORD
    nDebugInfoSize*: DWORD
    lpThreadLocalBase*: LPVOID
    lpStartAddress*: LPTHREAD_START_ROUTINE
    lpImageName*: LPVOID
    fUnicode*: WORD
  LPCREATE_PROCESS_DEBUG_INFO* = ptr CREATE_PROCESS_DEBUG_INFO
  EXIT_THREAD_DEBUG_INFO* {.pure.} = object
    dwExitCode*: DWORD
  LPEXIT_THREAD_DEBUG_INFO* = ptr EXIT_THREAD_DEBUG_INFO
  EXIT_PROCESS_DEBUG_INFO* {.pure.} = object
    dwExitCode*: DWORD
  LPEXIT_PROCESS_DEBUG_INFO* = ptr EXIT_PROCESS_DEBUG_INFO
  LOAD_DLL_DEBUG_INFO* {.pure.} = object
    hFile*: HANDLE
    lpBaseOfDll*: LPVOID
    dwDebugInfoFileOffset*: DWORD
    nDebugInfoSize*: DWORD
    lpImageName*: LPVOID
    fUnicode*: WORD
  LPLOAD_DLL_DEBUG_INFO* = ptr LOAD_DLL_DEBUG_INFO
  UNLOAD_DLL_DEBUG_INFO* {.pure.} = object
    lpBaseOfDll*: LPVOID
  LPUNLOAD_DLL_DEBUG_INFO* = ptr UNLOAD_DLL_DEBUG_INFO
  OUTPUT_DEBUG_STRING_INFO* {.pure.} = object
    lpDebugStringData*: LPSTR
    fUnicode*: WORD
    nDebugStringLength*: WORD
  LPOUTPUT_DEBUG_STRING_INFO* = ptr OUTPUT_DEBUG_STRING_INFO
  RIP_INFO* {.pure.} = object
    dwError*: DWORD
    dwType*: DWORD
  LPRIP_INFO* = ptr RIP_INFO
  DEBUG_EVENT_u* {.pure, union.} = object
    Exception*: EXCEPTION_DEBUG_INFO
    CreateThread*: CREATE_THREAD_DEBUG_INFO
    CreateProcessInfo*: CREATE_PROCESS_DEBUG_INFO
    ExitThread*: EXIT_THREAD_DEBUG_INFO
    ExitProcess*: EXIT_PROCESS_DEBUG_INFO
    LoadDll*: LOAD_DLL_DEBUG_INFO
    UnloadDll*: UNLOAD_DLL_DEBUG_INFO
    DebugString*: OUTPUT_DEBUG_STRING_INFO
    RipInfo*: RIP_INFO
  DEBUG_EVENT* {.pure.} = object
    dwDebugEventCode*: DWORD
    dwProcessId*: DWORD
    dwThreadId*: DWORD
    u*: DEBUG_EVENT_u
  LPDEBUG_EVENT* = ptr DEBUG_EVENT
  LPCONTEXT* = PCONTEXT
  PTOP_LEVEL_EXCEPTION_FILTER* = proc (ExceptionInfo: ptr EXCEPTION_POINTERS): LONG {.stdcall.}
  LPTOP_LEVEL_EXCEPTION_FILTER* = PTOP_LEVEL_EXCEPTION_FILTER
  BY_HANDLE_FILE_INFORMATION* {.pure.} = object
    dwFileAttributes*: DWORD
    ftCreationTime*: FILETIME
    ftLastAccessTime*: FILETIME
    ftLastWriteTime*: FILETIME
    dwVolumeSerialNumber*: DWORD
    nFileSizeHigh*: DWORD
    nFileSizeLow*: DWORD
    nNumberOfLinks*: DWORD
    nFileIndexHigh*: DWORD
    nFileIndexLow*: DWORD
  PBY_HANDLE_FILE_INFORMATION* = ptr BY_HANDLE_FILE_INFORMATION
  LPBY_HANDLE_FILE_INFORMATION* = ptr BY_HANDLE_FILE_INFORMATION
  WIN32_FILE_ATTRIBUTE_DATA* {.pure.} = object
    dwFileAttributes*: DWORD
    ftCreationTime*: FILETIME
    ftLastAccessTime*: FILETIME
    ftLastWriteTime*: FILETIME
    nFileSizeHigh*: DWORD
    nFileSizeLow*: DWORD
  LPWIN32_FILE_ATTRIBUTE_DATA* = ptr WIN32_FILE_ATTRIBUTE_DATA
  CREATEFILE2_EXTENDED_PARAMETERS* {.pure.} = object
    dwSize*: DWORD
    dwFileAttributes*: DWORD
    dwFileFlags*: DWORD
    dwSecurityQosFlags*: DWORD
    lpSecurityAttributes*: LPSECURITY_ATTRIBUTES
    hTemplateFile*: HANDLE
  PCREATEFILE2_EXTENDED_PARAMETERS* = ptr CREATEFILE2_EXTENDED_PARAMETERS
  LPCREATEFILE2_EXTENDED_PARAMETERS* = ptr CREATEFILE2_EXTENDED_PARAMETERS
  THEAP_SUMMARY* {.pure.} = object
    cb*: DWORD
    cbAllocated*: SIZE_T
    cbCommitted*: SIZE_T
    cbReserved*: SIZE_T
    cbMaxReserve*: SIZE_T
  PHEAP_SUMMARY* = ptr THEAP_SUMMARY
  LPHEAP_SUMMARY* = PHEAP_SUMMARY
  ENUMUILANG* {.pure.} = object
    NumOfEnumUILang*: ULONG
    SizeOfEnumUIBuffer*: ULONG
    pEnumUIBuffer*: ptr LANGID
  PENUMUILANG* = ptr ENUMUILANG
  WIN32_MEMORY_RANGE_ENTRY* {.pure.} = object
    VirtualAddress*: PVOID
    NumberOfBytes*: SIZE_T
  PWIN32_MEMORY_RANGE_ENTRY* = ptr WIN32_MEMORY_RANGE_ENTRY
  PROCESS_INFORMATION* {.pure.} = object
    hProcess*: HANDLE
    hThread*: HANDLE
    dwProcessId*: DWORD
    dwThreadId*: DWORD
  PPROCESS_INFORMATION* = ptr PROCESS_INFORMATION
  LPPROCESS_INFORMATION* = ptr PROCESS_INFORMATION
  STARTUPINFOA* {.pure.} = object
    cb*: DWORD
    lpReserved*: LPSTR
    lpDesktop*: LPSTR
    lpTitle*: LPSTR
    dwX*: DWORD
    dwY*: DWORD
    dwXSize*: DWORD
    dwYSize*: DWORD
    dwXCountChars*: DWORD
    dwYCountChars*: DWORD
    dwFillAttribute*: DWORD
    dwFlags*: DWORD
    wShowWindow*: WORD
    cbReserved2*: WORD
    lpReserved2*: LPBYTE
    hStdInput*: HANDLE
    hStdOutput*: HANDLE
    hStdError*: HANDLE
  LPSTARTUPINFOA* = ptr STARTUPINFOA
  STARTUPINFOW* {.pure.} = object
    cb*: DWORD
    lpReserved*: LPWSTR
    lpDesktop*: LPWSTR
    lpTitle*: LPWSTR
    dwX*: DWORD
    dwY*: DWORD
    dwXSize*: DWORD
    dwYSize*: DWORD
    dwXCountChars*: DWORD
    dwYCountChars*: DWORD
    dwFillAttribute*: DWORD
    dwFlags*: DWORD
    wShowWindow*: WORD
    cbReserved2*: WORD
    lpReserved2*: LPBYTE
    hStdInput*: HANDLE
    hStdOutput*: HANDLE
    hStdError*: HANDLE
  LPSTARTUPINFOW* = ptr STARTUPINFOW
  PROC_THREAD_ATTRIBUTE_LIST* {.pure.} = object
  PPROC_THREAD_ATTRIBUTE_LIST* = ptr PROC_THREAD_ATTRIBUTE_LIST
  LPPROC_THREAD_ATTRIBUTE_LIST* = ptr PROC_THREAD_ATTRIBUTE_LIST
  SRWLOCK* = RTL_SRWLOCK
  PSRWLOCK* = ptr RTL_SRWLOCK
  INIT_ONCE* = RTL_RUN_ONCE
  PINIT_ONCE* = PRTL_RUN_ONCE
  LPINIT_ONCE* = PRTL_RUN_ONCE
  CONDITION_VARIABLE* = RTL_CONDITION_VARIABLE
  PCONDITION_VARIABLE* = ptr RTL_CONDITION_VARIABLE
  SYNCHRONIZATION_BARRIER* = RTL_BARRIER
  PSYNCHRONIZATION_BARRIER* = PRTL_BARRIER
  LPSYNCHRONIZATION_BARRIER* = PRTL_BARRIER
  SYSTEM_INFO_UNION1_STRUCT1* {.pure.} = object
    wProcessorArchitecture*: WORD
    wReserved*: WORD
  SYSTEM_INFO_UNION1* {.pure, union.} = object
    dwOemId*: DWORD
    struct1*: SYSTEM_INFO_UNION1_STRUCT1
  SYSTEM_INFO* {.pure.} = object
    union1*: SYSTEM_INFO_UNION1
    dwPageSize*: DWORD
    lpMinimumApplicationAddress*: LPVOID
    lpMaximumApplicationAddress*: LPVOID
    dwActiveProcessorMask*: DWORD_PTR
    dwNumberOfProcessors*: DWORD
    dwProcessorType*: DWORD
    dwAllocationGranularity*: DWORD
    wProcessorLevel*: WORD
    wProcessorRevision*: WORD
  LPSYSTEM_INFO* = ptr SYSTEM_INFO
  MEMORYSTATUSEX* {.pure.} = object
    dwLength*: DWORD
    dwMemoryLoad*: DWORD
    ullTotalPhys*: DWORDLONG
    ullAvailPhys*: DWORDLONG
    ullTotalPageFile*: DWORDLONG
    ullAvailPageFile*: DWORDLONG
    ullTotalVirtual*: DWORDLONG
    ullAvailVirtual*: DWORDLONG
    ullAvailExtendedVirtual*: DWORDLONG
  LPMEMORYSTATUSEX* = ptr MEMORYSTATUSEX
  PFIBER_START_ROUTINE* = proc (lpFiberParameter: LPVOID): VOID {.stdcall.}
  LPFIBER_START_ROUTINE* = PFIBER_START_ROUTINE
  COMMPROP* {.pure.} = object
    wPacketLength*: WORD
    wPacketVersion*: WORD
    dwServiceMask*: DWORD
    dwReserved1*: DWORD
    dwMaxTxQueue*: DWORD
    dwMaxRxQueue*: DWORD
    dwMaxBaud*: DWORD
    dwProvSubType*: DWORD
    dwProvCapabilities*: DWORD
    dwSettableParams*: DWORD
    dwSettableBaud*: DWORD
    wSettableData*: WORD
    wSettableStopParity*: WORD
    dwCurrentTxQueue*: DWORD
    dwCurrentRxQueue*: DWORD
    dwProvSpec1*: DWORD
    dwProvSpec2*: DWORD
    wcProvChar*: array[1, WCHAR]
  LPCOMMPROP* = ptr COMMPROP
  COMSTAT* {.pure.} = object
    fCtsHold* {.bitsize:1.}: DWORD
    fDsrHold* {.bitsize:1.}: DWORD
    fRlsdHold* {.bitsize:1.}: DWORD
    fXoffHold* {.bitsize:1.}: DWORD
    fXoffSent* {.bitsize:1.}: DWORD
    fEof* {.bitsize:1.}: DWORD
    fTxim* {.bitsize:1.}: DWORD
    fReserved* {.bitsize:25.}: DWORD
    cbInQue*: DWORD
    cbOutQue*: DWORD
  LPCOMSTAT* = ptr COMSTAT
  DCB* {.pure.} = object
    DCBlength*: DWORD
    BaudRate*: DWORD
    fBinary* {.bitsize:1.}: DWORD
    fParity* {.bitsize:1.}: DWORD
    fOutxCtsFlow* {.bitsize:1.}: DWORD
    fOutxDsrFlow* {.bitsize:1.}: DWORD
    fDtrControl* {.bitsize:2.}: DWORD
    fDsrSensitivity* {.bitsize:1.}: DWORD
    fTXContinueOnXoff* {.bitsize:1.}: DWORD
    fOutX* {.bitsize:1.}: DWORD
    fInX* {.bitsize:1.}: DWORD
    fErrorChar* {.bitsize:1.}: DWORD
    fNull* {.bitsize:1.}: DWORD
    fRtsControl* {.bitsize:2.}: DWORD
    fAbortOnError* {.bitsize:1.}: DWORD
    fDummy2* {.bitsize:17.}: DWORD
    wReserved*: WORD
    XonLim*: WORD
    XoffLim*: WORD
    ByteSize*: BYTE
    Parity*: BYTE
    StopBits*: BYTE
    XonChar*: char
    XoffChar*: char
    ErrorChar*: char
    EofChar*: char
    EvtChar*: char
    wReserved1*: WORD
  LPDCB* = ptr DCB
  COMMTIMEOUTS* {.pure.} = object
    ReadIntervalTimeout*: DWORD
    ReadTotalTimeoutMultiplier*: DWORD
    ReadTotalTimeoutConstant*: DWORD
    WriteTotalTimeoutMultiplier*: DWORD
    WriteTotalTimeoutConstant*: DWORD
  LPCOMMTIMEOUTS* = ptr COMMTIMEOUTS
  COMMCONFIG* {.pure.} = object
    dwSize*: DWORD
    wVersion*: WORD
    wReserved*: WORD
    dcb*: DCB
    dwProviderSubType*: DWORD
    dwProviderOffset*: DWORD
    dwProviderSize*: DWORD
    wcProviderData*: array[1, WCHAR]
  LPCOMMCONFIG* = ptr COMMCONFIG
  MEMORYSTATUS* {.pure.} = object
    dwLength*: DWORD
    dwMemoryLoad*: DWORD
    dwTotalPhys*: SIZE_T
    dwAvailPhys*: SIZE_T
    dwTotalPageFile*: SIZE_T
    dwAvailPageFile*: SIZE_T
    dwTotalVirtual*: SIZE_T
    dwAvailVirtual*: SIZE_T
  LPMEMORYSTATUS* = ptr MEMORYSTATUS
  JIT_DEBUG_INFO* {.pure.} = object
    dwSize*: DWORD
    dwProcessorArchitecture*: DWORD
    dwThreadID*: DWORD
    dwReserved0*: DWORD
    lpExceptionAddress*: ULONG64
    lpExceptionRecord*: ULONG64
    lpContextRecord*: ULONG64
  LPJIT_DEBUG_INFO* = ptr JIT_DEBUG_INFO
  JIT_DEBUG_INFO32* = JIT_DEBUG_INFO
  LPJIT_DEBUG_INFO32* = ptr JIT_DEBUG_INFO
  JIT_DEBUG_INFO64* = JIT_DEBUG_INFO
  LPJIT_DEBUG_INFO64* = ptr JIT_DEBUG_INFO
  LPEXCEPTION_RECORD* = PEXCEPTION_RECORD
  LPEXCEPTION_POINTERS* = PEXCEPTION_POINTERS
const
  OFS_MAXPATHNAME* = 128
type
  OFSTRUCT* {.pure.} = object
    cBytes*: BYTE
    fFixedDisk*: BYTE
    nErrCode*: WORD
    Reserved1*: WORD
    Reserved2*: WORD
    szPathName*: array[OFS_MAXPATHNAME, CHAR]
  LPOFSTRUCT* = ptr OFSTRUCT
  POFSTRUCT* = ptr OFSTRUCT
  MEMORY_PRIORITY_INFORMATION* {.pure.} = object
    MemoryPriority*: ULONG
  PMEMORY_PRIORITY_INFORMATION* = ptr MEMORY_PRIORITY_INFORMATION
  POWER_REQUEST_CONTEXT* = REASON_CONTEXT
  PPOWER_REQUEST_CONTEXT* = ptr REASON_CONTEXT
  LPPOWER_REQUEST_CONTEXT* = ptr REASON_CONTEXT
  WIN32_STREAM_ID* {.pure.} = object
    dwStreamId*: DWORD
    dwStreamAttributes*: DWORD
    Size*: LARGE_INTEGER
    dwStreamNameSize*: DWORD
    cStreamName*: array[ANYSIZE_ARRAY, WCHAR]
  LPWIN32_STREAM_ID* = ptr WIN32_STREAM_ID
  STARTUPINFOEXA* {.pure.} = object
    StartupInfo*: STARTUPINFOA
    lpAttributeList*: LPPROC_THREAD_ATTRIBUTE_LIST
  LPSTARTUPINFOEXA* = ptr STARTUPINFOEXA
  STARTUPINFOEXW* {.pure.} = object
    StartupInfo*: STARTUPINFOW
    lpAttributeList*: LPPROC_THREAD_ATTRIBUTE_LIST
  LPSTARTUPINFOEXW* = ptr STARTUPINFOEXW
  WIN32_FIND_STREAM_DATA* {.pure.} = object
    StreamSize*: LARGE_INTEGER
    cStreamName*: array[MAX_PATH + 36, WCHAR]
  PWIN32_FIND_STREAM_DATA* = ptr WIN32_FIND_STREAM_DATA
  EVENTLOG_FULL_INFORMATION* {.pure.} = object
    dwFull*: DWORD
  LPEVENTLOG_FULL_INFORMATION* = ptr EVENTLOG_FULL_INFORMATION
  OPERATION_START_PARAMETERS* {.pure.} = object
    Version*: ULONG
    OperationId*: OPERATION_ID
    Flags*: ULONG
  POPERATION_START_PARAMETERS* = ptr OPERATION_START_PARAMETERS
  OPERATION_END_PARAMETERS* {.pure.} = object
    Version*: ULONG
    OperationId*: OPERATION_ID
    Flags*: ULONG
  POPERATION_END_PARAMETERS* = ptr OPERATION_END_PARAMETERS
const
  HW_PROFILE_GUIDLEN* = 39
  MAX_PROFILE_LEN* = 80
type
  HW_PROFILE_INFOA* {.pure.} = object
    dwDockInfo*: DWORD
    szHwProfileGuid*: array[HW_PROFILE_GUIDLEN, CHAR]
    szHwProfileName*: array[MAX_PROFILE_LEN, CHAR]
  LPHW_PROFILE_INFOA* = ptr HW_PROFILE_INFOA
  HW_PROFILE_INFOW* {.pure.} = object
    dwDockInfo*: DWORD
    szHwProfileGuid*: array[HW_PROFILE_GUIDLEN, WCHAR]
    szHwProfileName*: array[MAX_PROFILE_LEN, WCHAR]
  LPHW_PROFILE_INFOW* = ptr HW_PROFILE_INFOW
  TIME_ZONE_INFORMATION* {.pure.} = object
    Bias*: LONG
    StandardName*: array[32, WCHAR]
    StandardDate*: SYSTEMTIME
    StandardBias*: LONG
    DaylightName*: array[32, WCHAR]
    DaylightDate*: SYSTEMTIME
    DaylightBias*: LONG
  PTIME_ZONE_INFORMATION* = ptr TIME_ZONE_INFORMATION
  LPTIME_ZONE_INFORMATION* = ptr TIME_ZONE_INFORMATION
  DYNAMIC_TIME_ZONE_INFORMATION* {.pure.} = object
    Bias*: LONG
    StandardName*: array[32, WCHAR]
    StandardDate*: SYSTEMTIME
    StandardBias*: LONG
    DaylightName*: array[32, WCHAR]
    DaylightDate*: SYSTEMTIME
    DaylightBias*: LONG
    TimeZoneKeyName*: array[128, WCHAR]
    DynamicDaylightTimeDisabled*: BOOLEAN
  PDYNAMIC_TIME_ZONE_INFORMATION* = ptr DYNAMIC_TIME_ZONE_INFORMATION
  SYSTEM_POWER_STATUS* {.pure.} = object
    ACLineStatus*: BYTE
    BatteryFlag*: BYTE
    BatteryLifePercent*: BYTE
    Reserved1*: BYTE
    BatteryLifeTime*: DWORD
    BatteryFullLifeTime*: DWORD
  LPSYSTEM_POWER_STATUS* = ptr SYSTEM_POWER_STATUS
  PBAD_MEMORY_CALLBACK_ROUTINE* = ptr BAD_MEMORY_CALLBACK_ROUTINE
  ACTCTXA* {.pure.} = object
    cbSize*: ULONG
    dwFlags*: DWORD
    lpSource*: LPCSTR
    wProcessorArchitecture*: USHORT
    wLangId*: LANGID
    lpAssemblyDirectory*: LPCSTR
    lpResourceName*: LPCSTR
    lpApplicationName*: LPCSTR
    hModule*: HMODULE
  PACTCTXA* = ptr ACTCTXA
  ACTCTXW* {.pure.} = object
    cbSize*: ULONG
    dwFlags*: DWORD
    lpSource*: LPCWSTR
    wProcessorArchitecture*: USHORT
    wLangId*: LANGID
    lpAssemblyDirectory*: LPCWSTR
    lpResourceName*: LPCWSTR
    lpApplicationName*: LPCWSTR
    hModule*: HMODULE
  PACTCTXW* = ptr ACTCTXW
  PCACTCTXA* = ptr ACTCTXA
  PCACTCTXW* = ptr ACTCTXW
  ACTCTX_SECTION_KEYED_DATA_2600* {.pure.} = object
    cbSize*: ULONG
    ulDataFormatVersion*: ULONG
    lpData*: PVOID
    ulLength*: ULONG
    lpSectionGlobalData*: PVOID
    ulSectionGlobalDataLength*: ULONG
    lpSectionBase*: PVOID
    ulSectionTotalLength*: ULONG
    hActCtx*: HANDLE
    ulAssemblyRosterIndex*: ULONG
  PACTCTX_SECTION_KEYED_DATA_2600* = ptr ACTCTX_SECTION_KEYED_DATA_2600
  PCACTCTX_SECTION_KEYED_DATA_2600* = ptr ACTCTX_SECTION_KEYED_DATA_2600
  ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA* {.pure.} = object
    lpInformation*: PVOID
    lpSectionBase*: PVOID
    ulSectionLength*: ULONG
    lpSectionGlobalDataBase*: PVOID
    ulSectionGlobalDataLength*: ULONG
  PACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA* = ptr ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
  PCACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA* = ptr ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
  ACTCTX_SECTION_KEYED_DATA* {.pure.} = object
    cbSize*: ULONG
    ulDataFormatVersion*: ULONG
    lpData*: PVOID
    ulLength*: ULONG
    lpSectionGlobalData*: PVOID
    ulSectionGlobalDataLength*: ULONG
    lpSectionBase*: PVOID
    ulSectionTotalLength*: ULONG
    hActCtx*: HANDLE
    ulAssemblyRosterIndex*: ULONG
    ulFlags*: ULONG
    AssemblyMetadata*: ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
  PACTCTX_SECTION_KEYED_DATA* = ptr ACTCTX_SECTION_KEYED_DATA
  PCACTCTX_SECTION_KEYED_DATA* = ptr ACTCTX_SECTION_KEYED_DATA
  ACTIVATION_CONTEXT_BASIC_INFORMATION* {.pure.} = object
    hActCtx*: HANDLE
    dwFlags*: DWORD
  PACTIVATION_CONTEXT_BASIC_INFORMATION* = ptr ACTIVATION_CONTEXT_BASIC_INFORMATION
  PCACTIVATION_CONTEXT_BASIC_INFORMATION* = ptr ACTIVATION_CONTEXT_BASIC_INFORMATION
  FILE_BASIC_INFO* {.pure.} = object
    CreationTime*: LARGE_INTEGER
    LastAccessTime*: LARGE_INTEGER
    LastWriteTime*: LARGE_INTEGER
    ChangeTime*: LARGE_INTEGER
    FileAttributes*: DWORD
  PFILE_BASIC_INFO* = ptr FILE_BASIC_INFO
  FILE_STANDARD_INFO* {.pure.} = object
    AllocationSize*: LARGE_INTEGER
    EndOfFile*: LARGE_INTEGER
    NumberOfLinks*: DWORD
    DeletePending*: BOOLEAN
    Directory*: BOOLEAN
  PFILE_STANDARD_INFO* = ptr FILE_STANDARD_INFO
  FILE_NAME_INFO* {.pure.} = object
    FileNameLength*: DWORD
    FileName*: array[1, WCHAR]
  PFILE_NAME_INFO* = ptr FILE_NAME_INFO
  FILE_RENAME_INFO* {.pure.} = object
    ReplaceIfExists*: BOOLEAN
    RootDirectory*: HANDLE
    FileNameLength*: DWORD
    FileName*: array[1, WCHAR]
  PFILE_RENAME_INFO* = ptr FILE_RENAME_INFO
  FILE_ALLOCATION_INFO* {.pure.} = object
    AllocationSize*: LARGE_INTEGER
  PFILE_ALLOCATION_INFO* = ptr FILE_ALLOCATION_INFO
  FILE_END_OF_FILE_INFO* {.pure.} = object
    EndOfFile*: LARGE_INTEGER
  PFILE_END_OF_FILE_INFO* = ptr FILE_END_OF_FILE_INFO
  FILE_STREAM_INFO* {.pure.} = object
    NextEntryOffset*: DWORD
    StreamNameLength*: DWORD
    StreamSize*: LARGE_INTEGER
    StreamAllocationSize*: LARGE_INTEGER
    StreamName*: array[1, WCHAR]
  PFILE_STREAM_INFO* = ptr FILE_STREAM_INFO
  FILE_COMPRESSION_INFO* {.pure.} = object
    CompressedFileSize*: LARGE_INTEGER
    CompressionFormat*: WORD
    CompressionUnitShift*: UCHAR
    ChunkShift*: UCHAR
    ClusterShift*: UCHAR
    Reserved*: array[3, UCHAR]
  PFILE_COMPRESSION_INFO* = ptr FILE_COMPRESSION_INFO
  FILE_ATTRIBUTE_TAG_INFO* {.pure.} = object
    FileAttributes*: DWORD
    ReparseTag*: DWORD
  PFILE_ATTRIBUTE_TAG_INFO* = ptr FILE_ATTRIBUTE_TAG_INFO
  FILE_DISPOSITION_INFO* {.pure.} = object
    DeleteFile*: BOOLEAN
  PFILE_DISPOSITION_INFO* = ptr FILE_DISPOSITION_INFO
  FILE_ID_BOTH_DIR_INFO* {.pure.} = object
    NextEntryOffset*: DWORD
    FileIndex*: DWORD
    CreationTime*: LARGE_INTEGER
    LastAccessTime*: LARGE_INTEGER
    LastWriteTime*: LARGE_INTEGER
    ChangeTime*: LARGE_INTEGER
    EndOfFile*: LARGE_INTEGER
    AllocationSize*: LARGE_INTEGER
    FileAttributes*: DWORD
    FileNameLength*: DWORD
    EaSize*: DWORD
    ShortNameLength*: CCHAR
    ShortName*: array[12, WCHAR]
    FileId*: LARGE_INTEGER
    FileName*: array[1, WCHAR]
  PFILE_ID_BOTH_DIR_INFO* = ptr FILE_ID_BOTH_DIR_INFO
  FILE_FULL_DIR_INFO* {.pure.} = object
    NextEntryOffset*: ULONG
    FileIndex*: ULONG
    CreationTime*: LARGE_INTEGER
    LastAccessTime*: LARGE_INTEGER
    LastWriteTime*: LARGE_INTEGER
    ChangeTime*: LARGE_INTEGER
    EndOfFile*: LARGE_INTEGER
    AllocationSize*: LARGE_INTEGER
    FileAttributes*: ULONG
    FileNameLength*: ULONG
    EaSize*: ULONG
    FileName*: array[1, WCHAR]
  PFILE_FULL_DIR_INFO* = ptr FILE_FULL_DIR_INFO
  FILE_IO_PRIORITY_HINT_INFO* {.pure.} = object
    PriorityHint*: PRIORITY_HINT
  PFILE_IO_PRIORITY_HINT_INFO* = ptr FILE_IO_PRIORITY_HINT_INFO
  FILE_ALIGNMENT_INFO* {.pure.} = object
    AlignmentRequirement*: ULONG
  PFILE_ALIGNMENT_INFO* = ptr FILE_ALIGNMENT_INFO
  FILE_STORAGE_INFO* {.pure.} = object
    LogicalBytesPerSector*: ULONG
    PhysicalBytesPerSectorForAtomicity*: ULONG
    PhysicalBytesPerSectorForPerformance*: ULONG
    FileSystemEffectivePhysicalBytesPerSectorForAtomicity*: ULONG
    Flags*: ULONG
    ByteOffsetForSectorAlignment*: ULONG
    ByteOffsetForPartitionAlignment*: ULONG
  PFILE_STORAGE_INFO* = ptr FILE_STORAGE_INFO
  FILE_ID_INFO* {.pure.} = object
    VolumeSerialNumber*: ULONGLONG
    FileId*: FILE_ID_128
  PFILE_ID_INFO* = ptr FILE_ID_INFO
  FILE_ID_EXTD_DIR_INFO* {.pure.} = object
    NextEntryOffset*: ULONG
    FileIndex*: ULONG
    CreationTime*: LARGE_INTEGER
    LastAccessTime*: LARGE_INTEGER
    LastWriteTime*: LARGE_INTEGER
    ChangeTime*: LARGE_INTEGER
    EndOfFile*: LARGE_INTEGER
    AllocationSize*: LARGE_INTEGER
    FileAttributes*: ULONG
    FileNameLength*: ULONG
    EaSize*: ULONG
    ReparsePointTag*: ULONG
    FileId*: FILE_ID_128
    FileName*: array[1, WCHAR]
  PFILE_ID_EXTD_DIR_INFO* = ptr FILE_ID_EXTD_DIR_INFO
  FILE_REMOTE_PROTOCOL_INFO_GenericReserved* {.pure.} = object
    Reserved*: array[8, ULONG]
  FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2_Server* {.pure.} = object
    Capabilities*: ULONG
  FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2_Share* {.pure.} = object
    Capabilities*: ULONG
    CachingFlags*: ULONG
  FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2* {.pure.} = object
    Server*: FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2_Server
    Share*: FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2_Share
  FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific* {.pure, union.} = object
    Smb2*: FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2
    Reserved*: array[16, ULONG]
  FILE_REMOTE_PROTOCOL_INFO* {.pure.} = object
    StructureVersion*: USHORT
    StructureSize*: USHORT
    Protocol*: ULONG
    ProtocolMajorVersion*: USHORT
    ProtocolMinorVersion*: USHORT
    ProtocolRevision*: USHORT
    Reserved*: USHORT
    Flags*: ULONG
    GenericReserved*: FILE_REMOTE_PROTOCOL_INFO_GenericReserved
    ProtocolSpecific*: FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific
  PFILE_REMOTE_PROTOCOL_INFO* = ptr FILE_REMOTE_PROTOCOL_INFO
  FILE_ID_DESCRIPTOR_UNION1* {.pure, union.} = object
    FileId*: LARGE_INTEGER
    ObjectId*: GUID
    ExtendedFileId*: FILE_ID_128
  FILE_ID_DESCRIPTOR* {.pure.} = object
    dwSize*: DWORD
    Type*: FILE_ID_TYPE
    union1*: FILE_ID_DESCRIPTOR_UNION1
  LPFILE_ID_DESCRIPTOR* = ptr FILE_ID_DESCRIPTOR
const
  findExInfoStandard* = 0
  findExInfoBasic* = 1
  findExInfoMaxInfoLevel* = 2
  FIND_FIRST_EX_CASE_SENSITIVE* = 0x00000001
  FIND_FIRST_EX_LARGE_FETCH* = 0x00000002
  findExSearchNameMatch* = 0
  findExSearchLimitToDirectories* = 1
  findExSearchLimitToDevices* = 2
  findExSearchMaxSearchOp* = 3
  getFileExInfoStandard* = 0
  getFileExMaxInfoLevel* = 1
  fileBasicInfo* = 0
  fileStandardInfo* = 1
  fileNameInfo* = 2
  fileRenameInfo* = 3
  fileDispositionInfo* = 4
  fileAllocationInfo* = 5
  fileEndOfFileInfo* = 6
  fileStreamInfo* = 7
  fileCompressionInfo* = 8
  fileAttributeTagInfo* = 9
  fileIdBothDirectoryInfo* = 10
  fileIdBothDirectoryRestartInfo* = 11
  fileIoPriorityHintInfo* = 12
  fileRemoteProtocolInfo* = 13
  fileFullDirectoryInfo* = 14
  fileFullDirectoryRestartInfo* = 15
  fileStorageInfo* = 16
  fileAlignmentInfo* = 17
  fileIdInfo* = 18
  fileIdExtdDirectoryInfo* = 19
  fileIdExtdDirectoryRestartInfo* = 20
  maximumFileInfoByHandleClass* = 21
  LOCKFILE_FAIL_IMMEDIATELY* = 0x1
  LOCKFILE_EXCLUSIVE_LOCK* = 0x2
  PROCESS_HEAP_REGION* = 0x1
  PROCESS_HEAP_UNCOMMITTED_RANGE* = 0x2
  PROCESS_HEAP_ENTRY_BUSY* = 0x4
  PROCESS_HEAP_ENTRY_MOVEABLE* = 0x10
  PROCESS_HEAP_ENTRY_DDESHARE* = 0x20
  EXCEPTION_DEBUG_EVENT* = 1
  CREATE_THREAD_DEBUG_EVENT* = 2
  CREATE_PROCESS_DEBUG_EVENT* = 3
  EXIT_THREAD_DEBUG_EVENT* = 4
  EXIT_PROCESS_DEBUG_EVENT* = 5
  LOAD_DLL_DEBUG_EVENT* = 6
  UNLOAD_DLL_DEBUG_EVENT* = 7
  OUTPUT_DEBUG_STRING_EVENT* = 8
  RIP_EVENT* = 9
  STILL_ACTIVE* = STATUS_PENDING
  EXCEPTION_ACCESS_VIOLATION* = STATUS_ACCESS_VIOLATION
  EXCEPTION_DATATYPE_MISALIGNMENT* = STATUS_DATATYPE_MISALIGNMENT
  EXCEPTION_BREAKPOINT* = STATUS_BREAKPOINT
  EXCEPTION_SINGLE_STEP* = STATUS_SINGLE_STEP
  EXCEPTION_ARRAY_BOUNDS_EXCEEDED* = STATUS_ARRAY_BOUNDS_EXCEEDED
  EXCEPTION_FLT_DENORMAL_OPERAND* = STATUS_FLOAT_DENORMAL_OPERAND
  EXCEPTION_FLT_DIVIDE_BY_ZERO* = STATUS_FLOAT_DIVIDE_BY_ZERO
  EXCEPTION_FLT_INEXACT_RESULT* = STATUS_FLOAT_INEXACT_RESULT
  EXCEPTION_FLT_INVALID_OPERATION* = STATUS_FLOAT_INVALID_OPERATION
  EXCEPTION_FLT_OVERFLOW* = STATUS_FLOAT_OVERFLOW
  EXCEPTION_FLT_STACK_CHECK* = STATUS_FLOAT_STACK_CHECK
  EXCEPTION_FLT_UNDERFLOW* = STATUS_FLOAT_UNDERFLOW
  EXCEPTION_INT_DIVIDE_BY_ZERO* = STATUS_INTEGER_DIVIDE_BY_ZERO
  EXCEPTION_INT_OVERFLOW* = STATUS_INTEGER_OVERFLOW
  EXCEPTION_PRIV_INSTRUCTION* = STATUS_PRIVILEGED_INSTRUCTION
  EXCEPTION_IN_PAGE_ERROR* = STATUS_IN_PAGE_ERROR
  EXCEPTION_ILLEGAL_INSTRUCTION* = STATUS_ILLEGAL_INSTRUCTION
  EXCEPTION_NONCONTINUABLE_EXCEPTION* = STATUS_NONCONTINUABLE_EXCEPTION
  EXCEPTION_STACK_OVERFLOW* = STATUS_STACK_OVERFLOW
  EXCEPTION_INVALID_DISPOSITION* = STATUS_INVALID_DISPOSITION
  EXCEPTION_GUARD_PAGE* = STATUS_GUARD_PAGE_VIOLATION
  EXCEPTION_INVALID_HANDLE* = STATUS_INVALID_HANDLE
  EXCEPTION_POSSIBLE_DEADLOCK* = STATUS_POSSIBLE_DEADLOCK
  CONTROL_C_EXIT* = STATUS_CONTROL_C_EXIT
  LMEM_FIXED* = 0x0
  LMEM_MOVEABLE* = 0x2
  LMEM_NOCOMPACT* = 0x10
  LMEM_NODISCARD* = 0x20
  LMEM_ZEROINIT* = 0x40
  LMEM_MODIFY* = 0x80
  LMEM_DISCARDABLE* = 0xf00
  LMEM_VALID_FLAGS* = 0xf72
  LMEM_INVALID_HANDLE* = 0x8000
  LHND* = LMEM_MOVEABLE or LMEM_ZEROINIT
  LPTR* = LMEM_FIXED or LMEM_ZEROINIT
  NONZEROLHND* = LMEM_MOVEABLE
  NONZEROLPTR* = LMEM_FIXED
  LMEM_DISCARDED* = 0x4000
  LMEM_LOCKCOUNT* = 0xff
  RESTORE_LAST_ERROR_NAME_A* = "RestoreLastError"
  RESTORE_LAST_ERROR_NAME_W* = "RestoreLastError"
  RESTORE_LAST_ERROR_NAME* = "RestoreLastError"
  FLS_OUT_OF_INDEXES* = DWORD 0xffffffff'i32
  CREATE_NEW* = 1
  CREATE_ALWAYS* = 2
  OPEN_EXISTING* = 3
  OPEN_ALWAYS* = 4
  TRUNCATE_EXISTING* = 5
  INVALID_FILE_SIZE* = DWORD 0xffffffff'i32
  INVALID_SET_FILE_POINTER* = DWORD(-1)
  INVALID_FILE_ATTRIBUTES* = DWORD(-1)
  FIND_RESOURCE_DIRECTORY_TYPES* = 0x0100
  FIND_RESOURCE_DIRECTORY_NAMES* = 0x0200
  FIND_RESOURCE_DIRECTORY_LANGUAGES* = 0x0400
  RESOURCE_ENUM_LN* = 0x0001
  RESOURCE_ENUM_MUI* = 0x0002
  RESOURCE_ENUM_MUI_SYSTEM* = 0x0004
  RESOURCE_ENUM_VALIDATE* = 0x0008
  RESOURCE_ENUM_MODULE_EXACT* = 0x0010
  SUPPORT_LANG_NUMBER* = 32
  DONT_RESOLVE_DLL_REFERENCES* = 0x1
  LOAD_LIBRARY_AS_DATAFILE* = 0x2
  LOAD_WITH_ALTERED_SEARCH_PATH* = 0x8
  LOAD_IGNORE_CODE_AUTHZ_LEVEL* = 0x10
  LOAD_LIBRARY_AS_IMAGE_RESOURCE* = 0x20
  LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE* = 0x40
  LOAD_LIBRARY_REQUIRE_SIGNED_TARGET* = 0x80
  LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR* = 0x100
  LOAD_LIBRARY_SEARCH_APPLICATION_DIR* = 0x200
  LOAD_LIBRARY_SEARCH_USER_DIRS* = 0x400
  LOAD_LIBRARY_SEARCH_SYSTEM32* = 0x800
  LOAD_LIBRARY_SEARCH_DEFAULT_DIRS* = 0x1000
  GET_MODULE_HANDLE_EX_FLAG_PIN* = 0x1
  GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT* = 0x2
  GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS* = 0x4
  lowMemoryResourceNotification* = 0
  highMemoryResourceNotification* = 1
  vmOfferPriorityVeryLow* = 1
  vmOfferPriorityLow* = 2
  vmOfferPriorityBelowNormal* = 3
  vmOfferPriorityNormal* = 4
  FILE_MAP_WRITE* = SECTION_MAP_WRITE
  FILE_MAP_READ* = SECTION_MAP_READ
  FILE_MAP_ALL_ACCESS* = SECTION_ALL_ACCESS
  FILE_MAP_COPY* = 0x1
  FILE_MAP_RESERVE* = 0x80000000'i32
  FILE_MAP_EXECUTE* = SECTION_MAP_EXECUTE_EXPLICIT
  FILE_CACHE_MAX_HARD_ENABLE* = 0x00000001
  FILE_CACHE_MAX_HARD_DISABLE* = 0x00000002
  FILE_CACHE_MIN_HARD_ENABLE* = 0x00000004
  FILE_CACHE_MIN_HARD_DISABLE* = 0x00000008
  PRIVATE_NAMESPACE_FLAG_DESTROY* = 0x1
  TLS_OUT_OF_INDEXES* = DWORD 0xffffffff'i32
  PROCESS_AFFINITY_ENABLE_AUTO_UPDATE* = 0x1
  PROC_THREAD_ATTRIBUTE_REPLACE_VALUE* = 0x00000001
  SRWLOCK_INIT* = RTL_SRWLOCK_INIT
  INIT_ONCE_STATIC_INIT* = RTL_RUN_ONCE_INIT
  INIT_ONCE_CHECK_ONLY* = RTL_RUN_ONCE_CHECK_ONLY
  INIT_ONCE_ASYNC* = RTL_RUN_ONCE_ASYNC
  INIT_ONCE_INIT_FAILED* = RTL_RUN_ONCE_INIT_FAILED
  INIT_ONCE_CTX_RESERVED_BITS* = RTL_RUN_ONCE_CTX_RESERVED_BITS
  CONDITION_VARIABLE_INIT* = RTL_CONDITION_VARIABLE_INIT
  CONDITION_VARIABLE_LOCKMODE_SHARED* = RTL_CONDITION_VARIABLE_LOCKMODE_SHARED
  MUTEX_MODIFY_STATE* = MUTANT_QUERY_STATE
  MUTEX_ALL_ACCESS* = MUTANT_ALL_ACCESS
  CREATE_MUTEX_INITIAL_OWNER* = 0x1
  CREATE_EVENT_MANUAL_RESET* = 0x1
  CREATE_EVENT_INITIAL_SET* = 0x2
  SYNCHRONIZATION_BARRIER_FLAGS_SPIN_ONLY* = 0x01
  SYNCHRONIZATION_BARRIER_FLAGS_BLOCK_ONLY* = 0x02
  SYNCHRONIZATION_BARRIER_FLAGS_NO_DELETE* = 0x04
  CREATE_WAITABLE_TIMER_MANUAL_RESET* = 0x1
  computerNameNetBIOS* = 0
  computerNameDnsHostname* = 1
  computerNameDnsDomain* = 2
  computerNameDnsFullyQualified* = 3
  computerNamePhysicalNetBIOS* = 4
  computerNamePhysicalDnsHostname* = 5
  computerNamePhysicalDnsDomain* = 6
  computerNamePhysicalDnsFullyQualified* = 7
  computerNameMax* = 8
  FILE_BEGIN* = 0
  FILE_CURRENT* = 1
  FILE_END* = 2
  WAIT_FAILED* = DWORD 0xffffffff'i32
  WAIT_OBJECT_0* = (STATUS_WAIT_0)+0
  WAIT_ABANDONED* = (STATUS_ABANDONED_WAIT_0)+0
  WAIT_ABANDONED_0* = (STATUS_ABANDONED_WAIT_0)+0
  WAIT_IO_COMPLETION* = STATUS_USER_APC
  FILE_FLAG_WRITE_THROUGH* = 0x80000000'i32
  FILE_FLAG_OVERLAPPED* = 0x40000000
  FILE_FLAG_NO_BUFFERING* = 0x20000000
  FILE_FLAG_RANDOM_ACCESS* = 0x10000000
  FILE_FLAG_SEQUENTIAL_SCAN* = 0x8000000
  FILE_FLAG_DELETE_ON_CLOSE* = 0x4000000
  FILE_FLAG_BACKUP_SEMANTICS* = 0x2000000
  FILE_FLAG_POSIX_SEMANTICS* = 0x1000000
  FILE_FLAG_SESSION_AWARE* = 0x800000
  FILE_FLAG_OPEN_REPARSE_POINT* = 0x200000
  FILE_FLAG_OPEN_NO_RECALL* = 0x100000
  FILE_FLAG_FIRST_PIPE_INSTANCE* = 0x80000
  FILE_FLAG_OPEN_REQUIRING_OPLOCK* = 0x40000
  PROGRESS_CONTINUE* = 0
  PROGRESS_CANCEL* = 1
  PROGRESS_STOP* = 2
  PROGRESS_QUIET* = 3
  CALLBACK_CHUNK_FINISHED* = 0x0
  CALLBACK_STREAM_SWITCH* = 0x1
  COPY_FILE_FAIL_IF_EXISTS* = 0x1
  COPY_FILE_RESTARTABLE* = 0x2
  COPY_FILE_OPEN_SOURCE_FOR_WRITE* = 0x4
  COPY_FILE_ALLOW_DECRYPTED_DESTINATION* = 0x8
  COPY_FILE_COPY_SYMLINK* = 0x800
  COPY_FILE_NO_BUFFERING* = 0x1000
  COPY_FILE_REQUEST_SECURITY_PRIVILEGES* = 0x2000
  COPY_FILE_RESUME_FROM_PAUSE* = 0x4000
  COPY_FILE_NO_OFFLOAD* = 0x40000
  REPLACEFILE_WRITE_THROUGH* = 0x1
  REPLACEFILE_IGNORE_MERGE_ERRORS* = 0x2
  REPLACEFILE_IGNORE_ACL_ERRORS* = 0x4
  PIPE_ACCESS_INBOUND* = 0x1
  PIPE_ACCESS_OUTBOUND* = 0x2
  PIPE_ACCESS_DUPLEX* = 0x3
  PIPE_CLIENT_END* = 0x0
  PIPE_SERVER_END* = 0x1
  PIPE_WAIT* = 0x0
  PIPE_NOWAIT* = 0x1
  PIPE_READMODE_BYTE* = 0x0
  PIPE_READMODE_MESSAGE* = 0x2
  PIPE_TYPE_BYTE* = 0x0
  PIPE_TYPE_MESSAGE* = 0x4
  PIPE_ACCEPT_REMOTE_CLIENTS* = 0x0
  PIPE_REJECT_REMOTE_CLIENTS* = 0x8
  PIPE_UNLIMITED_INSTANCES* = 255
  SECURITY_ANONYMOUS* = securityAnonymous shl 16
  SECURITY_IDENTIFICATION* = securityIdentification shl 16
  SECURITY_IMPERSONATION* = securityImpersonation shl 16
  SECURITY_DELEGATION* = securityDelegation shl 16
  SECURITY_CONTEXT_TRACKING* = 0x40000
  SECURITY_EFFECTIVE_ONLY* = 0x80000
  SECURITY_SQOS_PRESENT* = 0x100000
  SECURITY_VALID_SQOS_FLAGS* = 0x1f0000
  FAIL_FAST_GENERATE_EXCEPTION_ADDRESS* = 0x1
  FAIL_FAST_NO_HARD_ERROR_DLG* = 0x2
  SP_SERIALCOMM* = DWORD 0x1
  PST_UNSPECIFIED* = DWORD 0x0
  PST_RS232* = DWORD 0x1
  PST_PARALLELPORT* = DWORD 0x2
  PST_RS422* = DWORD 0x3
  PST_RS423* = DWORD 0x4
  PST_RS449* = DWORD 0x5
  PST_MODEM* = DWORD 0x6
  PST_FAX* = DWORD 0x21
  PST_SCANNER* = DWORD 0x22
  PST_NETWORK_BRIDGE* = DWORD 0x100
  PST_LAT* = DWORD 0x101
  PST_TCPIP_TELNET* = DWORD 0x102
  PST_X25* = DWORD 0x103
  PCF_DTRDSR* = DWORD 0x1
  PCF_RTSCTS* = DWORD 0x2
  PCF_RLSD* = DWORD 0x4
  PCF_PARITY_CHECK* = DWORD 0x8
  PCF_XONXOFF* = DWORD 0x10
  PCF_SETXCHAR* = DWORD 0x20
  PCF_TOTALTIMEOUTS* = DWORD 0x40
  PCF_INTTIMEOUTS* = DWORD 0x80
  PCF_SPECIALCHARS* = DWORD 0x100
  PCF_16BITMODE* = DWORD 0x200
  SP_PARITY* = DWORD 0x1
  SP_BAUD* = DWORD 0x2
  SP_DATABITS* = DWORD 0x4
  SP_STOPBITS* = DWORD 0x8
  SP_HANDSHAKING* = DWORD 0x10
  SP_PARITY_CHECK* = DWORD 0x20
  SP_RLSD* = DWORD 0x40
  BAUD_075* = DWORD 0x1
  BAUD_110* = DWORD 0x2
  BAUD_134_5* = DWORD 0x4
  BAUD_150* = DWORD 0x8
  BAUD_300* = DWORD 0x10
  BAUD_600* = DWORD 0x20
  BAUD_1200* = DWORD 0x40
  BAUD_1800* = DWORD 0x80
  BAUD_2400* = DWORD 0x100
  BAUD_4800* = DWORD 0x200
  BAUD_7200* = DWORD 0x400
  BAUD_9600* = DWORD 0x800
  BAUD_14400* = DWORD 0x1000
  BAUD_19200* = DWORD 0x2000
  BAUD_38400* = DWORD 0x4000
  BAUD_56K* = DWORD 0x8000
  BAUD_128K* = DWORD 0x10000
  BAUD_115200* = DWORD 0x20000
  BAUD_57600* = DWORD 0x40000
  BAUD_USER* = DWORD 0x10000000
  DATABITS_5* = WORD 0x1
  DATABITS_6* = WORD 0x2
  DATABITS_7* = WORD 0x4
  DATABITS_8* = WORD 0x8
  DATABITS_16* = WORD 0x10
  DATABITS_16X* = WORD 0x20
  STOPBITS_10* = WORD 0x1
  STOPBITS_15* = WORD 0x2
  STOPBITS_20* = WORD 0x4
  PARITY_NONE* = WORD 0x100
  PARITY_ODD* = WORD 0x200
  PARITY_EVEN* = WORD 0x400
  PARITY_MARK* = WORD 0x800
  PARITY_SPACE* = WORD 0x1000
  COMMPROP_INITIALIZED* = DWORD 0xe73cf52e'i32
  DTR_CONTROL_DISABLE* = 0x0
  DTR_CONTROL_ENABLE* = 0x1
  DTR_CONTROL_HANDSHAKE* = 0x2
  RTS_CONTROL_DISABLE* = 0x0
  RTS_CONTROL_ENABLE* = 0x1
  RTS_CONTROL_HANDSHAKE* = 0x2
  RTS_CONTROL_TOGGLE* = 0x3
  GMEM_FIXED* = 0x0
  GMEM_MOVEABLE* = 0x2
  GMEM_NOCOMPACT* = 0x10
  GMEM_NODISCARD* = 0x20
  GMEM_ZEROINIT* = 0x40
  GMEM_MODIFY* = 0x80
  GMEM_DISCARDABLE* = 0x100
  GMEM_NOT_BANKED* = 0x1000
  GMEM_SHARE* = 0x2000
  GMEM_DDESHARE* = 0x2000
  GMEM_NOTIFY* = 0x4000
  GMEM_LOWER* = GMEM_NOT_BANKED
  GMEM_VALID_FLAGS* = 0x7f72
  GMEM_INVALID_HANDLE* = 0x8000
  GHND* = GMEM_MOVEABLE or GMEM_ZEROINIT
  GPTR* = GMEM_FIXED or GMEM_ZEROINIT
  GMEM_DISCARDED* = 0x4000
  GMEM_LOCKCOUNT* = 0x00ff
  NUMA_NO_PREFERRED_NODE* = DWORD(-1)
  DEBUG_PROCESS* = 0x1
  DEBUG_ONLY_THIS_PROCESS* = 0x2
  CREATE_SUSPENDED* = 0x4
  DETACHED_PROCESS* = 0x8
  CREATE_NEW_CONSOLE* = 0x10
  NORMAL_PRIORITY_CLASS* = 0x20
  IDLE_PRIORITY_CLASS* = 0x40
  HIGH_PRIORITY_CLASS* = 0x80
  REALTIME_PRIORITY_CLASS* = 0x100
  CREATE_NEW_PROCESS_GROUP* = 0x200
  CREATE_UNICODE_ENVIRONMENT* = 0x400
  CREATE_SEPARATE_WOW_VDM* = 0x800
  CREATE_SHARED_WOW_VDM* = 0x1000
  CREATE_FORCEDOS* = 0x2000
  BELOW_NORMAL_PRIORITY_CLASS* = 0x4000
  ABOVE_NORMAL_PRIORITY_CLASS* = 0x8000
  INHERIT_PARENT_AFFINITY* = 0x10000
  INHERIT_CALLER_PRIORITY* = 0x20000
  CREATE_PROTECTED_PROCESS* = 0x40000
  EXTENDED_STARTUPINFO_PRESENT* = 0x80000
  PROCESS_MODE_BACKGROUND_BEGIN* = 0x100000
  PROCESS_MODE_BACKGROUND_END* = 0x200000
  CREATE_BREAKAWAY_FROM_JOB* = 0x1000000
  CREATE_PRESERVE_CODE_AUTHZ_LEVEL* = 0x2000000
  CREATE_DEFAULT_ERROR_MODE* = 0x4000000
  CREATE_NO_WINDOW* = 0x8000000
  PROFILE_USER* = 0x10000000
  PROFILE_KERNEL* = 0x20000000
  PROFILE_SERVER* = 0x40000000
  CREATE_IGNORE_SYSTEM_DEFAULT* = 0x80000000'i32
  STACK_SIZE_PARAM_IS_A_RESERVATION* = 0x10000
  THREAD_PRIORITY_LOWEST* = THREAD_BASE_PRIORITY_MIN
  THREAD_PRIORITY_BELOW_NORMAL* = THREAD_PRIORITY_LOWEST+1
  THREAD_PRIORITY_NORMAL* = 0
  THREAD_PRIORITY_HIGHEST* = THREAD_BASE_PRIORITY_MAX
  THREAD_PRIORITY_ABOVE_NORMAL* = THREAD_PRIORITY_HIGHEST-1
  THREAD_PRIORITY_ERROR_RETURN* = MAXLONG
  THREAD_PRIORITY_TIME_CRITICAL* = THREAD_BASE_PRIORITY_LOWRT
  THREAD_PRIORITY_IDLE* = THREAD_BASE_PRIORITY_IDLE
  THREAD_MODE_BACKGROUND_BEGIN* = 0x00010000
  THREAD_MODE_BACKGROUND_END* = 0x00020000
  VOLUME_NAME_DOS* = 0x0
  VOLUME_NAME_GUID* = 0x1
  VOLUME_NAME_NT* = 0x2
  VOLUME_NAME_NONE* = 0x4
  FILE_NAME_NORMALIZED* = 0x0
  FILE_NAME_OPENED* = 0x8
  DRIVE_UNKNOWN* = 0
  DRIVE_NO_ROOT_DIR* = 1
  DRIVE_REMOVABLE* = 2
  DRIVE_FIXED* = 3
  DRIVE_REMOTE* = 4
  DRIVE_CDROM* = 5
  DRIVE_RAMDISK* = 6
  FILE_TYPE_UNKNOWN* = 0x0
  FILE_TYPE_DISK* = 0x1
  FILE_TYPE_CHAR* = 0x2
  FILE_TYPE_PIPE* = 0x3
  FILE_TYPE_REMOTE* = 0x8000
  STD_INPUT_HANDLE* = DWORD(-10)
  STD_OUTPUT_HANDLE* = DWORD(-11)
  STD_ERROR_HANDLE* = DWORD(-12)
  NOPARITY* = 0
  ODDPARITY* = 1
  EVENPARITY* = 2
  MARKPARITY* = 3
  SPACEPARITY* = 4
  ONESTOPBIT* = 0
  ONE5STOPBITS* = 1
  TWOSTOPBITS* = 2
  IGNORE* = 0
  INFINITE* = 0xffffffff'i32
  CBR_110* = 110
  CBR_300* = 300
  CBR_600* = 600
  CBR_1200* = 1200
  CBR_2400* = 2400
  CBR_4800* = 4800
  CBR_9600* = 9600
  CBR_14400* = 14400
  CBR_19200* = 19200
  CBR_38400* = 38400
  CBR_56000* = 56000
  CBR_57600* = 57600
  CBR_115200* = 115200
  CBR_128000* = 128000
  CBR_256000* = 256000
  CE_RXOVER* = 0x1
  CE_OVERRUN* = 0x2
  CE_RXPARITY* = 0x4
  CE_FRAME* = 0x8
  CE_BREAK* = 0x10
  CE_TXFULL* = 0x100
  CE_PTO* = 0x200
  CE_IOE* = 0x400
  CE_DNS* = 0x800
  CE_OOP* = 0x1000
  CE_MODE* = 0x8000
  IE_BADID* = -1
  IE_OPEN* = -2
  IE_NOPEN* = -3
  IE_MEMORY* = -4
  IE_DEFAULT* = -5
  IE_HARDWARE* = -10
  IE_BYTESIZE* = -11
  IE_BAUDRATE* = -12
  EV_RXCHAR* = 0x1
  EV_RXFLAG* = 0x2
  EV_TXEMPTY* = 0x4
  EV_CTS* = 0x8
  EV_DSR* = 0x10
  EV_RLSD* = 0x20
  EV_BREAK* = 0x40
  EV_ERR* = 0x80
  EV_RING* = 0x100
  EV_PERR* = 0x200
  EV_RX80FULL* = 0x400
  EV_EVENT1* = 0x800
  EV_EVENT2* = 0x1000
  SETXOFF* = 1
  SETXON* = 2
  SETRTS* = 3
  CLRRTS* = 4
  SETDTR* = 5
  CLRDTR* = 6
  RESETDEV* = 7
  SETBREAK* = 8
  CLRBREAK* = 9
  PURGE_TXABORT* = 0x1
  PURGE_RXABORT* = 0x2
  PURGE_TXCLEAR* = 0x4
  PURGE_RXCLEAR* = 0x8
  LPTx* = 0x80
  MS_CTS_ON* = DWORD 0x10
  MS_DSR_ON* = DWORD 0x20
  MS_RING_ON* = DWORD 0x40
  MS_RLSD_ON* = DWORD 0x80
  S_QUEUEEMPTY* = 0
  S_THRESHOLD* = 1
  S_ALLTHRESHOLD* = 2
  S_NORMAL* = 0
  S_LEGATO* = 1
  S_STACCATO* = 2
  S_PERIOD512* = 0
  S_PERIOD1024* = 1
  S_PERIOD2048* = 2
  S_PERIODVOICE* = 3
  S_WHITE512* = 4
  S_WHITE1024* = 5
  S_WHITE2048* = 6
  S_WHITEVOICE* = 7
  S_SERDVNA* = -1
  S_SEROFM* = -2
  S_SERMACT* = -3
  S_SERQFUL* = -4
  S_SERBDNT* = -5
  S_SERDLN* = -6
  S_SERDCC* = -7
  S_SERDTP* = -8
  S_SERDVL* = -9
  S_SERDMD* = -10
  S_SERDSH* = -11
  S_SERDPT* = -12
  S_SERDFQ* = -13
  S_SERDDR* = -14
  S_SERDSR* = -15
  S_SERDST* = -16
  NMPWAIT_WAIT_FOREVER* = 0xffffffff'i32
  NMPWAIT_NOWAIT* = 0x1
  NMPWAIT_USE_DEFAULT_WAIT* = 0x0
  FS_CASE_IS_PRESERVED* = FILE_CASE_PRESERVED_NAMES
  FS_CASE_SENSITIVE* = FILE_CASE_SENSITIVE_SEARCH
  FS_UNICODE_STORED_ON_DISK* = FILE_UNICODE_ON_DISK
  FS_PERSISTENT_ACLS* = FILE_PERSISTENT_ACLS
  FS_VOL_IS_COMPRESSED* = FILE_VOLUME_IS_COMPRESSED
  FS_FILE_COMPRESSION* = FILE_FILE_COMPRESSION
  FS_FILE_ENCRYPTION* = FILE_SUPPORTS_ENCRYPTION
  OF_READ* = 0x0
  OF_WRITE* = 0x1
  OF_READWRITE* = 0x2
  OF_SHARE_COMPAT* = 0x0
  OF_SHARE_EXCLUSIVE* = 0x10
  OF_SHARE_DENY_WRITE* = 0x20
  OF_SHARE_DENY_READ* = 0x30
  OF_SHARE_DENY_NONE* = 0x40
  OF_PARSE* = 0x100
  OF_DELETE* = 0x200
  OF_VERIFY* = 0x400
  OF_CANCEL* = 0x800
  OF_CREATE* = 0x1000
  OF_PROMPT* = 0x2000
  OF_EXIST* = 0x4000
  OF_REOPEN* = 0x8000
  MAXINTATOM* = 0xc000
  INVALID_ATOM* = ATOM 0
  SCS_32BIT_BINARY* = 0
  SCS_DOS_BINARY* = 1
  SCS_WOW_BINARY* = 2
  SCS_PIF_BINARY* = 3
  SCS_POSIX_BINARY* = 4
  SCS_OS216_BINARY* = 5
  SCS_64BIT_BINARY* = 6
  FIBER_FLAG_FLOAT_SWITCH* = 0x1
  threadMemoryPriority* = 0
  threadAbsoluteCpuPriority* = 1
  threadInformationClassMax* = 2
  processMemoryPriority* = 0
  processInformationClassMax* = 1
  MEMORY_PRIORITY_LOWEST* = 0
  MEMORY_PRIORITY_VERY_LOW* = 1
  MEMORY_PRIORITY_LOW* = 2
  MEMORY_PRIORITY_MEDIUM* = 3
  MEMORY_PRIORITY_BELOW_NORMAL* = 4
  MEMORY_PRIORITY_NORMAL* = 5
  PROCESS_DEP_ENABLE* = 0x00000001
  PROCESS_DEP_DISABLE_ATL_THUNK_EMULATION* = 0x00000002
  FILE_SKIP_COMPLETION_PORT_ON_SUCCESS* = 0x1
  FILE_SKIP_SET_EVENT_ON_HANDLE* = 0x2
  SEM_FAILCRITICALERRORS* = 0x0001
  SEM_NOGPFAULTERRORBOX* = 0x0002
  SEM_NOALIGNMENTFAULTEXCEPT* = 0x0004
  SEM_NOOPENFILEERRORBOX* = 0x8000
  CRITICAL_SECTION_NO_DEBUG_INFO* = RTL_CRITICAL_SECTION_FLAG_NO_DEBUG_INFO
  dEPPolicyAlwaysOff* = 0
  dEPPolicyAlwaysOn* = 1
  dEPPolicyOptIn* = 2
  dEPPolicyOptOut* = 3
  dEPTotalPolicyCount* = 4
  HANDLE_FLAG_INHERIT* = 0x1
  HANDLE_FLAG_PROTECT_FROM_CLOSE* = 0x2
  HINSTANCE_ERROR* = 32
  GET_TAPE_MEDIA_INFORMATION* = 0
  GET_TAPE_DRIVE_INFORMATION* = 1
  SET_TAPE_MEDIA_INFORMATION* = 0
  SET_TAPE_DRIVE_INFORMATION* = 1
  FORMAT_MESSAGE_IGNORE_INSERTS* = 0x00000200
  FORMAT_MESSAGE_FROM_STRING* = 0x00000400
  FORMAT_MESSAGE_FROM_HMODULE* = 0x00000800
  FORMAT_MESSAGE_FROM_SYSTEM* = 0x00001000
  FORMAT_MESSAGE_ARGUMENT_ARRAY* = 0x00002000
  FORMAT_MESSAGE_MAX_WIDTH_MASK* = 0x000000ff
  FILE_ENCRYPTABLE* = 0
  FILE_IS_ENCRYPTED* = 1
  FILE_SYSTEM_ATTR* = 2
  FILE_ROOT_DIR* = 3
  FILE_SYSTEM_DIR* = 4
  FILE_UNKNOWN* = 5
  FILE_SYSTEM_NOT_SUPPORT* = 6
  FILE_USER_DISALLOWED* = 7
  FILE_READ_ONLY* = 8
  FILE_DIR_DISALLOWED* = 9
  FORMAT_MESSAGE_ALLOCATE_BUFFER* = 0x00000100
  EFS_USE_RECOVERY_KEYS* = 0x1
  CREATE_FOR_IMPORT* = 1
  CREATE_FOR_DIR* = 2
  OVERWRITE_HIDDEN* = 4
  EFSRPC_SECURE_ONLY* = 8
  BACKUP_INVALID* = 0x00000000
  BACKUP_DATA* = 0x00000001
  BACKUP_EA_DATA* = 0x00000002
  BACKUP_SECURITY_DATA* = 0x00000003
  BACKUP_ALTERNATE_DATA* = 0x00000004
  BACKUP_LINK* = 0x00000005
  BACKUP_PROPERTY_DATA* = 0x00000006
  BACKUP_OBJECT_ID* = 0x00000007
  BACKUP_REPARSE_DATA* = 0x00000008
  BACKUP_SPARSE_BLOCK* = 0x00000009
  BACKUP_TXFS_DATA* = 0x0000000a
  STREAM_NORMAL_ATTRIBUTE* = 0x00000000
  STREAM_MODIFIED_WHEN_READ* = 0x00000001
  STREAM_CONTAINS_SECURITY* = 0x00000002
  STREAM_CONTAINS_PROPERTIES* = 0x00000004
  STREAM_SPARSE_ATTRIBUTE* = 0x00000008
  STARTF_USESHOWWINDOW* = 0x00000001
  STARTF_USESIZE* = 0x00000002
  STARTF_USEPOSITION* = 0x00000004
  STARTF_USECOUNTCHARS* = 0x00000008
  STARTF_USEFILLATTRIBUTE* = 0x00000010
  STARTF_RUNFULLSCREEN* = 0x00000020
  STARTF_FORCEONFEEDBACK* = 0x00000040
  STARTF_FORCEOFFFEEDBACK* = 0x00000080
  STARTF_USESTDHANDLES* = 0x00000100
  STARTF_USEHOTKEY* = 0x00000200
  STARTF_TITLEISLINKNAME* = 0x00000800
  STARTF_TITLEISAPPID* = 0x00001000
  STARTF_PREVENTPINNING* = 0x00002000
  SHUTDOWN_NORETRY* = 0x1
  PROCESS_NAME_NATIVE* = 0x00000001
  PROC_THREAD_ATTRIBUTE_NUMBER* = 0x0000ffff
  PROC_THREAD_ATTRIBUTE_THREAD* = 0x00010000
  PROC_THREAD_ATTRIBUTE_INPUT* = 0x00020000
  PROC_THREAD_ATTRIBUTE_ADDITIVE* = 0x00040000
  procThreadAttributeParentProcess* = 0
  procThreadAttributeHandleList* = 2
  procThreadAttributeGroupAffinity* = 3
  procThreadAttributePreferredNode* = 4
  procThreadAttributeIdealProcessor* = 5
  procThreadAttributeUmsThread* = 6
  procThreadAttributeMitigationPolicy* = 7
  procThreadAttributeSecurityCapabilities* = 9
template ProcThreadAttributeValue*(Number, Thread, Input, Additive: untyped): untyped = (((Number) and PROC_THREAD_ATTRIBUTE_NUMBER) or (if (Thread != FALSE): PROC_THREAD_ATTRIBUTE_THREAD else: 0) or (if (Input != FALSE): PROC_THREAD_ATTRIBUTE_INPUT else: 0) or (if (Additive != FALSE): PROC_THREAD_ATTRIBUTE_ADDITIVE else: 0))
const
  PROC_THREAD_ATTRIBUTE_PARENT_PROCESS* = ProcThreadAttributeValue(procThreadAttributeParentProcess, FALSE, TRUE, FALSE)
  PROC_THREAD_ATTRIBUTE_HANDLE_LIST* = ProcThreadAttributeValue(procThreadAttributeHandleList, FALSE, TRUE, FALSE)
  PROC_THREAD_ATTRIBUTE_GROUP_AFFINITY* = ProcThreadAttributeValue(procThreadAttributeGroupAffinity, TRUE, TRUE, FALSE)
  PROC_THREAD_ATTRIBUTE_PREFERRED_NODE* = ProcThreadAttributeValue(procThreadAttributePreferredNode, FALSE, TRUE, FALSE)
  PROC_THREAD_ATTRIBUTE_IDEAL_PROCESSOR* = ProcThreadAttributeValue(procThreadAttributeIdealProcessor, TRUE, TRUE, FALSE)
  PROC_THREAD_ATTRIBUTE_UMS_THREAD* = ProcThreadAttributeValue(procThreadAttributeUmsThread, TRUE, TRUE, FALSE)
  PROC_THREAD_ATTRIBUTE_MITIGATION_POLICY* = ProcThreadAttributeValue(procThreadAttributeMitigationPolicy, FALSE, TRUE, FALSE)
  PROCESS_CREATION_MITIGATION_POLICY_DEP_ENABLE* = 0x01
  PROCESS_CREATION_MITIGATION_POLICY_DEP_ATL_THUNK_ENABLE* = 0x02
  PROCESS_CREATION_MITIGATION_POLICY_SEHOP_ENABLE* = 0x04
  PROC_THREAD_ATTRIBUTE_SECURITY_CAPABILITIES* = ProcThreadAttributeValue(procThreadAttributeSecurityCapabilities, FALSE, TRUE, FALSE)
  PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_MASK* = 0x00000003 shl 8
  PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_DEFER* = 0x00000000 shl 8
  PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_ALWAYS_ON* = 0x00000001 shl 8
  PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_ALWAYS_OFF* = 0x00000002 shl 8
  PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_ALWAYS_ON_REQ_RELOCS* = 0x00000003 shl 8
  PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_MASK* = 0x00000003 shl 12
  PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_DEFER* = 0x00000000 shl 12
  PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_ALWAYS_ON* = 0x00000001 shl 12
  PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_ALWAYS_OFF* = 0x00000002 shl 12
  PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_RESERVED* = 0x00000003 shl 12
  PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_MASK* = 0x00000003 shl 16
  PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_DEFER* = 0x00000000 shl 16
  PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_ALWAYS_ON* = 0x00000001 shl 16
  PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_ALWAYS_OFF* = 0x00000002 shl 16
  PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_RESERVED* = 0x00000003 shl 16
  PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_MASK* = 0x00000003 shl 20
  PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_DEFER* = 0x00000000 shl 20
  PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_ALWAYS_ON* = 0x00000001 shl 20
  PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_ALWAYS_OFF* = 0x00000002 shl 20
  PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_RESERVED* = 0x00000003 shl 20
  PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_MASK* = 0x00000003 shl 24
  PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_DEFER* = 0x00000000 shl 24
  PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_ALWAYS_ON* = 0x00000001 shl 24
  PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_ALWAYS_OFF* = 0x00000002 shl 24
  PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_RESERVED* = 0x00000003 shl 24
  PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_MASK* = 0x00000003 shl 28
  PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_DEFER* = 0x00000000 shl 28
  PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_ALWAYS_ON* = 0x00000001 shl 28
  PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_ALWAYS_OFF* = 0x00000002 shl 28
  PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_RESERVED* = 0x00000003 shl 28
  PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_MASK* = 0x00000003 shl 32
  PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_DEFER* = 0x00000000 shl 32
  PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_ALWAYS_ON* = 0x00000001 shl 32
  PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_ALWAYS_OFF* = 0x00000002 shl 32
  PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_RESERVED* = 0x00000003 shl 32
  ATOM_FLAG_GLOBAL* = 0x2
  GET_SYSTEM_WOW64_DIRECTORY_NAME_A_A* = "GetSystemWow64DirectoryA"
  GET_SYSTEM_WOW64_DIRECTORY_NAME_A_W* = "GetSystemWow64DirectoryA"
  GET_SYSTEM_WOW64_DIRECTORY_NAME_A_T* = "GetSystemWow64DirectoryA"
  GET_SYSTEM_WOW64_DIRECTORY_NAME_W_A* = "GetSystemWow64DirectoryW"
  GET_SYSTEM_WOW64_DIRECTORY_NAME_W_W* = "GetSystemWow64DirectoryW"
  GET_SYSTEM_WOW64_DIRECTORY_NAME_W_T* = "GetSystemWow64DirectoryW"
  BASE_SEARCH_PATH_ENABLE_SAFE_SEARCHMODE* = 0x1
  BASE_SEARCH_PATH_DISABLE_SAFE_SEARCHMODE* = 0x10000
  BASE_SEARCH_PATH_PERMANENT* = 0x8000
  BASE_SEARCH_PATH_INVALID_FLAGS* = not 0x18001
  DDD_RAW_TARGET_PATH* = 0x00000001
  DDD_REMOVE_DEFINITION* = 0x00000002
  DDD_EXACT_MATCH_ON_REMOVE* = 0x00000004
  DDD_NO_BROADCAST_SYSTEM* = 0x00000008
  DDD_LUID_BROADCAST_DRIVE* = 0x00000010
  COPYFILE2_CALLBACK_NONE* = 0
  COPYFILE2_CALLBACK_CHUNK_STARTED* = 1
  COPYFILE2_CALLBACK_CHUNK_FINISHED* = 2
  COPYFILE2_CALLBACK_STREAM_STARTED* = 3
  COPYFILE2_CALLBACK_STREAM_FINISHED* = 4
  COPYFILE2_CALLBACK_POLL_CONTINUE* = 5
  COPYFILE2_CALLBACK_ERROR* = 6
  COPYFILE2_CALLBACK_MAX* = 7
  COPYFILE2_PROGRESS_CONTINUE* = 0
  COPYFILE2_PROGRESS_CANCEL* = 1
  COPYFILE2_PROGRESS_STOP* = 2
  COPYFILE2_PROGRESS_QUIET* = 3
  COPYFILE2_PROGRESS_PAUSE* = 4
  COPYFILE2_PHASE_NONE* = 0
  COPYFILE2_PHASE_PREPARE_SOURCE* = 1
  COPYFILE2_PHASE_PREPARE_DEST* = 2
  COPYFILE2_PHASE_READ_SOURCE* = 3
  COPYFILE2_PHASE_WRITE_DESTINATION* = 4
  COPYFILE2_PHASE_SERVER_COPY* = 5
  COPYFILE2_PHASE_NAMEGRAFT_COPY* = 6
  COPYFILE2_PHASE_MAX* = 7
  COPYFILE2_MESSAGE_COPY_OFFLOAD* = 0x00000001
  MOVEFILE_REPLACE_EXISTING* = 0x00000001
  MOVEFILE_COPY_ALLOWED* = 0x00000002
  MOVEFILE_DELAY_UNTIL_REBOOT* = 0x00000004
  MOVEFILE_WRITE_THROUGH* = 0x00000008
  MOVEFILE_CREATE_HARDLINK* = 0x00000010
  MOVEFILE_FAIL_IF_NOT_TRACKABLE* = 0x00000020
  findStreamInfoStandard* = 0
  findStreamInfoMaxInfoLevel* = 1
  EVENTLOG_FULL_INFO* = 0
  OPERATION_API_VERSION* = 1
  OPERATION_START_TRACE_CURRENT_THREAD* = 0x1
  OPERATION_END_DISCARD* = 0x1
  MAX_COMPUTERNAME_LENGTH* = 15
  LOGON32_LOGON_INTERACTIVE* = 2
  LOGON32_LOGON_NETWORK* = 3
  LOGON32_LOGON_BATCH* = 4
  LOGON32_LOGON_SERVICE* = 5
  LOGON32_LOGON_UNLOCK* = 7
  LOGON32_LOGON_NETWORK_CLEARTEXT* = 8
  LOGON32_LOGON_NEW_CREDENTIALS* = 9
  LOGON32_PROVIDER_DEFAULT* = 0
  LOGON32_PROVIDER_WINNT35* = 1
  LOGON32_PROVIDER_WINNT40* = 2
  LOGON32_PROVIDER_WINNT50* = 3
  LOGON32_PROVIDER_VIRTUAL* = 4
  LOGON_WITH_PROFILE* = 0x00000001
  LOGON_NETCREDENTIALS_ONLY* = 0x00000002
  LOGON_ZERO_PASSWORD_BUFFER* = 0x80000000'i32
  DOCKINFO_UNDOCKED* = 0x1
  DOCKINFO_DOCKED* = 0x2
  DOCKINFO_USER_SUPPLIED* = 0x4
  DOCKINFO_USER_UNDOCKED* = DOCKINFO_USER_SUPPLIED or DOCKINFO_UNDOCKED
  DOCKINFO_USER_DOCKED* = DOCKINFO_USER_SUPPLIED or DOCKINFO_DOCKED
  TIME_ZONE_ID_INVALID* = DWORD 0xffffffff'i32
  AC_LINE_OFFLINE* = 0x00
  AC_LINE_ONLINE* = 0x01
  AC_LINE_BACKUP_POWER* = 0x02
  AC_LINE_UNKNOWN* = 0xff
  BATTERY_FLAG_HIGH* = 0x01
  BATTERY_FLAG_LOW* = 0x02
  BATTERY_FLAG_CRITICAL* = 0x04
  BATTERY_FLAG_CHARGING* = 0x08
  BATTERY_FLAG_NO_BATTERY* = 0x80
  BATTERY_FLAG_UNKNOWN* = 0xff
  BATTERY_PERCENTAGE_UNKNOWN* = 0xff
  BATTERY_LIFE_UNKNOWN* = 0xffffffff'i32
  MEHC_PATROL_SCRUBBER_PRESENT* = 0x1
  ACTCTX_FLAG_PROCESSOR_ARCHITECTURE_VALID* = 0x00000001
  ACTCTX_FLAG_LANGID_VALID* = 0x00000002
  ACTCTX_FLAG_ASSEMBLY_DIRECTORY_VALID* = 0x00000004
  ACTCTX_FLAG_RESOURCE_NAME_VALID* = 0x00000008
  ACTCTX_FLAG_SET_PROCESS_DEFAULT* = 0x00000010
  ACTCTX_FLAG_APPLICATION_NAME_VALID* = 0x00000020
  ACTCTX_FLAG_SOURCE_IS_ASSEMBLYREF* = 0x00000040
  ACTCTX_FLAG_HMODULE_VALID* = 0x00000080
  DEACTIVATE_ACTCTX_FLAG_FORCE_EARLY_DEACTIVATION* = 0x00000001
  FIND_ACTCTX_SECTION_KEY_RETURN_HACTCTX* = 0x00000001
  FIND_ACTCTX_SECTION_KEY_RETURN_FLAGS* = 0x00000002
  FIND_ACTCTX_SECTION_KEY_RETURN_ASSEMBLY_METADATA* = 0x00000004
  ACTIVATION_CONTEXT_BASIC_INFORMATION_DEFINED* = 1
  QUERY_ACTCTX_FLAG_USE_ACTIVE_ACTCTX* = 0x00000004
  QUERY_ACTCTX_FLAG_ACTCTX_IS_HMODULE* = 0x00000008
  QUERY_ACTCTX_FLAG_ACTCTX_IS_ADDRESS* = 0x00000010
  QUERY_ACTCTX_FLAG_NO_ADDREF* = 0x80000000'i32
  RESTART_MAX_CMD_LINE* = 1024
  RESTART_NO_CRASH* = 1
  RESTART_NO_HANG* = 2
  RESTART_NO_PATCH* = 4
  RESTART_NO_REBOOT* = 8
  RECOVERY_DEFAULT_PING_INTERVAL* = 5000
  RECOVERY_MAX_PING_INTERVAL* = 5*60*1000
  ioPriorityHintVeryLow* = 0
  ioPriorityHintLow* = 1
  ioPriorityHintNormal* = 2
  maximumIoPriorityHintType* = 3
  STORAGE_INFO_FLAGS_ALIGNED_DEVICE* = 0x00000001
  STORAGE_INFO_FLAGS_PARTITION_ALIGNED_ON_DEVICE* = 0x00000002
  STORAGE_INFO_OFFSET_UNKNOWN* = 0xffffffff'i32
  REMOTE_PROTOCOL_INFO_FLAG_LOOPBACK* = 0x00000001
  REMOTE_PROTOCOL_INFO_FLAG_OFFLINE* = 0x00000002
  REMOTE_PROTOCOL_INFO_FLAG_PERSISTENT_HANDLE* = 0x00000004
  RPI_FLAG_SMB2_SHARECAP_TIMEWARP* = 0x00000002
  RPI_FLAG_SMB2_SHARECAP_DFS* = 0x00000008
  RPI_FLAG_SMB2_SHARECAP_CONTINUOUS_AVAILABILITY* = 0x00000010
  RPI_FLAG_SMB2_SHARECAP_SCALEOUT* = 0x00000020
  RPI_FLAG_SMB2_SHARECAP_CLUSTER* = 0x00000040
  RPI_SMB2_FLAG_SERVERCAP_DFS* = 0x00000001
  RPI_SMB2_FLAG_SERVERCAP_LEASING* = 0x00000002
  RPI_SMB2_FLAG_SERVERCAP_LARGEMTU* = 0x00000004
  RPI_SMB2_FLAG_SERVERCAP_MULTICHANNEL* = 0x00000008
  RPI_SMB2_FLAG_SERVERCAP_PERSISTENT_HANDLES* = 0x00000010
  RPI_SMB2_FLAG_SERVERCAP_DIRECTORY_LEASING* = 0x00000020
  fileIdType* = 0
  objectIdType* = 1
  extendedFileIdType* = 2
  maximumFileIdType* = 3
  SYMBOLIC_LINK_FLAG_DIRECTORY* = 0x1
  VALID_SYMBOLIC_LINK_FLAGS* = SYMBOLIC_LINK_FLAG_DIRECTORY
  INVALID_HANDLE_VALUE* = HANDLE(-1)
type
  LPOVERLAPPED_COMPLETION_ROUTINE* = proc (dwErrorCode: DWORD, dwNumberOfBytesTransfered: DWORD, lpOverlapped: LPOVERLAPPED): VOID {.stdcall.}
  BEM_FREE_INTERFACE_CALLBACK* = proc (interfaceInstance: pointer): void {.stdcall.}
  PRESTORE_LAST_ERROR* = proc (P1: DWORD): VOID {.stdcall.}
  ENUMRESLANGPROCA* = proc (hModule: HMODULE, lpType: LPCSTR, lpName: LPCSTR, wLanguage: WORD, lParam: LONG_PTR): WINBOOL {.stdcall.}
  ENUMRESLANGPROCW* = proc (hModule: HMODULE, lpType: LPCWSTR, lpName: LPCWSTR, wLanguage: WORD, lParam: LONG_PTR): WINBOOL {.stdcall.}
  ENUMRESNAMEPROCA* = proc (hModule: HMODULE, lpType: LPCSTR, lpName: LPSTR, lParam: LONG_PTR): WINBOOL {.stdcall.}
  ENUMRESNAMEPROCW* = proc (hModule: HMODULE, lpType: LPCWSTR, lpName: LPWSTR, lParam: LONG_PTR): WINBOOL {.stdcall.}
  ENUMRESTYPEPROCA* = proc (hModule: HMODULE, lpType: LPSTR, lParam: LONG_PTR): WINBOOL {.stdcall.}
  ENUMRESTYPEPROCW* = proc (hModule: HMODULE, lpType: LPWSTR, lParam: LONG_PTR): WINBOOL {.stdcall.}
  PGET_MODULE_HANDLE_EXA* = proc (dwFlags: DWORD, lpModuleName: LPCSTR, phModule: ptr HMODULE): WINBOOL {.stdcall.}
  PGET_MODULE_HANDLE_EXW* = proc (dwFlags: DWORD, lpModuleName: LPCWSTR, phModule: ptr HMODULE): WINBOOL {.stdcall.}
  PINIT_ONCE_FN* = proc (InitOnce: PINIT_ONCE, Parameter: PVOID, Context: ptr PVOID): WINBOOL {.stdcall.}
  PTIMERAPCROUTINE* = proc (lpArgToCompletionRoutine: LPVOID, dwTimerLowValue: DWORD, dwTimerHighValue: DWORD): VOID {.stdcall.}
  PTP_WIN32_IO_CALLBACK* = proc (Instance: PTP_CALLBACK_INSTANCE, Context: PVOID, Overlapped: PVOID, IoResult: ULONG, NumberOfBytesTransferred: ULONG_PTR, Io: PTP_IO): VOID {.stdcall.}
  PFE_EXPORT_FUNC* = proc (pbData: PBYTE, pvCallbackContext: PVOID, ulLength: ULONG): DWORD {.stdcall.}
  PFE_IMPORT_FUNC* = proc (pbData: PBYTE, pvCallbackContext: PVOID, ulLength: PULONG): DWORD {.stdcall.}
  PGET_SYSTEM_WOW64_DIRECTORY_A* = proc (lpBuffer: LPSTR, uSize: UINT): UINT {.stdcall.}
  PGET_SYSTEM_WOW64_DIRECTORY_W* = proc (lpBuffer: LPWSTR, uSize: UINT): UINT {.stdcall.}
  LPPROGRESS_ROUTINE* = proc (TotalFileSize: LARGE_INTEGER, TotalBytesTransferred: LARGE_INTEGER, StreamSize: LARGE_INTEGER, StreamBytesTransferred: LARGE_INTEGER, dwStreamNumber: DWORD, dwCallbackReason: DWORD, hSourceFile: HANDLE, hDestinationFile: HANDLE, lpData: LPVOID): DWORD {.stdcall.}
  COPYFILE2_MESSAGE_Info_ChunkStarted* {.pure.} = object
    dwStreamNumber*: DWORD
    dwReserved*: DWORD
    hSourceFile*: HANDLE
    hDestinationFile*: HANDLE
    uliChunkNumber*: ULARGE_INTEGER
    uliChunkSize*: ULARGE_INTEGER
    uliStreamSize*: ULARGE_INTEGER
    uliTotalFileSize*: ULARGE_INTEGER
  COPYFILE2_MESSAGE_Info_ChunkFinished* {.pure.} = object
    dwStreamNumber*: DWORD
    dwFlags*: DWORD
    hSourceFile*: HANDLE
    hDestinationFile*: HANDLE
    uliChunkNumber*: ULARGE_INTEGER
    uliChunkSize*: ULARGE_INTEGER
    uliStreamSize*: ULARGE_INTEGER
    uliStreamBytesTransferred*: ULARGE_INTEGER
    uliTotalFileSize*: ULARGE_INTEGER
    uliTotalBytesTransferred*: ULARGE_INTEGER
  COPYFILE2_MESSAGE_Info_StreamStarted* {.pure.} = object
    dwStreamNumber*: DWORD
    dwReserved*: DWORD
    hSourceFile*: HANDLE
    hDestinationFile*: HANDLE
    uliStreamSize*: ULARGE_INTEGER
    uliTotalFileSize*: ULARGE_INTEGER
  COPYFILE2_MESSAGE_Info_StreamFinished* {.pure.} = object
    dwStreamNumber*: DWORD
    dwReserved*: DWORD
    hSourceFile*: HANDLE
    hDestinationFile*: HANDLE
    uliStreamSize*: ULARGE_INTEGER
    uliStreamBytesTransferred*: ULARGE_INTEGER
    uliTotalFileSize*: ULARGE_INTEGER
    uliTotalBytesTransferred*: ULARGE_INTEGER
  COPYFILE2_MESSAGE_Info_PollContinue* {.pure.} = object
    dwReserved*: DWORD
  COPYFILE2_MESSAGE_Info_Error* {.pure.} = object
    CopyPhase*: COPYFILE2_COPY_PHASE
    dwStreamNumber*: DWORD
    hrFailure*: HRESULT
    dwReserved*: DWORD
    uliChunkNumber*: ULARGE_INTEGER
    uliStreamSize*: ULARGE_INTEGER
    uliStreamBytesTransferred*: ULARGE_INTEGER
    uliTotalFileSize*: ULARGE_INTEGER
    uliTotalBytesTransferred*: ULARGE_INTEGER
  COPYFILE2_MESSAGE_Info* {.pure, union.} = object
    ChunkStarted*: COPYFILE2_MESSAGE_Info_ChunkStarted
    ChunkFinished*: COPYFILE2_MESSAGE_Info_ChunkFinished
    StreamStarted*: COPYFILE2_MESSAGE_Info_StreamStarted
    StreamFinished*: COPYFILE2_MESSAGE_Info_StreamFinished
    PollContinue*: COPYFILE2_MESSAGE_Info_PollContinue
    Error*: COPYFILE2_MESSAGE_Info_Error
  COPYFILE2_MESSAGE* {.pure.} = object
    Type*: COPYFILE2_MESSAGE_TYPE
    dwPadding*: DWORD
    Info*: COPYFILE2_MESSAGE_Info
  PCOPYFILE2_PROGRESS_ROUTINE* = proc (pMessage: ptr COPYFILE2_MESSAGE, pvCallbackContext: PVOID): COPYFILE2_MESSAGE_ACTION {.stdcall.}
  PQUERYACTCTXW_FUNC* = proc (dwFlags: DWORD, hActCtx: HANDLE, pvSubInstance: PVOID, ulInfoClass: ULONG, pvBuffer: PVOID, cbBuffer: SIZE_T, pcbWrittenOrRequired: ptr SIZE_T): WINBOOL {.stdcall.}
  APPLICATION_RECOVERY_CALLBACK* = proc (pvParameter: PVOID): DWORD {.stdcall.}
  COPYFILE2_EXTENDED_PARAMETERS* {.pure.} = object
    dwSize*: DWORD
    dwCopyFlags*: DWORD
    pfCancel*: ptr WINBOOL
    pProgressRoutine*: PCOPYFILE2_PROGRESS_ROUTINE
    pvCallbackContext*: PVOID
proc IsDebuggerPresent*(): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OutputDebugStringA*(lpOutputString: LPCSTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OutputDebugStringW*(lpOutputString: LPCWSTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DebugBreak*(): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ContinueDebugEvent*(dwProcessId: DWORD, dwThreadId: DWORD, dwContinueStatus: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForDebugEvent*(lpDebugEvent: LPDEBUG_EVENT, dwMilliseconds: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DebugActiveProcess*(dwProcessId: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DebugActiveProcessStop*(dwProcessId: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CheckRemoteDebuggerPresent*(hProcess: HANDLE, pbDebuggerPresent: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnhandledExceptionFilter*(ExceptionInfo: ptr EXCEPTION_POINTERS): LONG {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetUnhandledExceptionFilter*(lpTopLevelExceptionFilter: LPTOP_LEVEL_EXCEPTION_FILTER): LPTOP_LEVEL_EXCEPTION_FILTER {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetErrorMode*(uMode: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddVectoredExceptionHandler*(First: ULONG, Handler: PVECTORED_EXCEPTION_HANDLER): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RemoveVectoredExceptionHandler*(Handle: PVOID): ULONG {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddVectoredContinueHandler*(First: ULONG, Handler: PVECTORED_EXCEPTION_HANDLER): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RemoveVectoredContinueHandler*(Handle: PVOID): ULONG {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetErrorMode*(): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RestoreLastError*(dwErrCode: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RaiseException*(dwExceptionCode: DWORD, dwExceptionFlags: DWORD, nNumberOfArguments: DWORD, lpArguments: ptr ULONG_PTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLastError*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetLastError*(dwErrCode: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlsAlloc*(lpCallback: PFLS_CALLBACK_FUNCTION): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlsGetValue*(dwFlsIndex: DWORD): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlsSetValue*(dwFlsIndex: DWORD, lpFlsData: PVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlsFree*(dwFlsIndex: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsThreadAFiber*(): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CompareFileTime*(lpFileTime1: ptr FILETIME, lpFileTime2: ptr FILETIME): LONG {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileA*(lpFileName: LPCSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwCreationDisposition: DWORD, dwFlagsAndAttributes: DWORD, hTemplateFile: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileW*(lpFileName: LPCWSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwCreationDisposition: DWORD, dwFlagsAndAttributes: DWORD, hTemplateFile: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DefineDosDeviceW*(dwFlags: DWORD, lpDeviceName: LPCWSTR, lpTargetPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteVolumeMountPointW*(lpszVolumeMountPoint: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FileTimeToLocalFileTime*(lpFileTime: ptr FILETIME, lpLocalFileTime: LPFILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindCloseChangeNotification*(hChangeHandle: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstChangeNotificationA*(lpPathName: LPCSTR, bWatchSubtree: WINBOOL, dwNotifyFilter: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstChangeNotificationW*(lpPathName: LPCWSTR, bWatchSubtree: WINBOOL, dwNotifyFilter: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstFileA*(lpFileName: LPCSTR, lpFindFileData: LPWIN32_FIND_DATAA): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstFileW*(lpFileName: LPCWSTR, lpFindFileData: LPWIN32_FIND_DATAW): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstVolumeW*(lpszVolumeName: LPWSTR, cchBufferLength: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextChangeNotification*(hChangeHandle: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextVolumeW*(hFindVolume: HANDLE, lpszVolumeName: LPWSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindVolumeClose*(hFindVolume: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDiskFreeSpaceA*(lpRootPathName: LPCSTR, lpSectorsPerCluster: LPDWORD, lpBytesPerSector: LPDWORD, lpNumberOfFreeClusters: LPDWORD, lpTotalNumberOfClusters: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDiskFreeSpaceW*(lpRootPathName: LPCWSTR, lpSectorsPerCluster: LPDWORD, lpBytesPerSector: LPDWORD, lpNumberOfFreeClusters: LPDWORD, lpTotalNumberOfClusters: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDriveTypeA*(lpRootPathName: LPCSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDriveTypeW*(lpRootPathName: LPCWSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileAttributesA*(lpFileName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileAttributesW*(lpFileName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileInformationByHandle*(hFile: HANDLE, lpFileInformation: LPBY_HANDLE_FILE_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileSize*(hFile: HANDLE, lpFileSizeHigh: LPDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileSizeEx*(hFile: HANDLE, lpFileSize: PLARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileTime*(hFile: HANDLE, lpCreationTime: LPFILETIME, lpLastAccessTime: LPFILETIME, lpLastWriteTime: LPFILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileType*(hFile: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFullPathNameA*(lpFileName: LPCSTR, nBufferLength: DWORD, lpBuffer: LPSTR, lpFilePart: ptr LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFullPathNameW*(lpFileName: LPCWSTR, nBufferLength: DWORD, lpBuffer: LPWSTR, lpFilePart: ptr LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLogicalDrives*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLogicalDriveStringsW*(nBufferLength: DWORD, lpBuffer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLongPathNameA*(lpszShortPath: LPCSTR, lpszLongPath: LPSTR, cchBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLongPathNameW*(lpszShortPath: LPCWSTR, lpszLongPath: LPWSTR, cchBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetShortPathNameW*(lpszLongPath: LPCWSTR, lpszShortPath: LPWSTR, cchBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTempFileNameW*(lpPathName: LPCWSTR, lpPrefixString: LPCWSTR, uUnique: UINT, lpTempFileName: LPWSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumeInformationW*(lpRootPathName: LPCWSTR, lpVolumeNameBuffer: LPWSTR, nVolumeNameSize: DWORD, lpVolumeSerialNumber: LPDWORD, lpMaximumComponentLength: LPDWORD, lpFileSystemFlags: LPDWORD, lpFileSystemNameBuffer: LPWSTR, nFileSystemNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumePathNameW*(lpszFileName: LPCWSTR, lpszVolumePathName: LPWSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalFileTimeToFileTime*(lpLocalFileTime: ptr FILETIME, lpFileTime: LPFILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LockFile*(hFile: HANDLE, dwFileOffsetLow: DWORD, dwFileOffsetHigh: DWORD, nNumberOfBytesToLockLow: DWORD, nNumberOfBytesToLockHigh: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryDosDeviceW*(lpDeviceName: LPCWSTR, lpTargetPath: LPWSTR, ucchMax: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadFileEx*(hFile: HANDLE, lpBuffer: LPVOID, nNumberOfBytesToRead: DWORD, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPOVERLAPPED_COMPLETION_ROUTINE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadFileScatter*(hFile: HANDLE, aSegmentArray: ptr FILE_SEGMENT_ELEMENT, nNumberOfBytesToRead: DWORD, lpReserved: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFilePointer*(hFile: HANDLE, lDistanceToMove: LONG, lpDistanceToMoveHigh: PLONG, dwMoveMethod: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileTime*(hFile: HANDLE, lpCreationTime: ptr FILETIME, lpLastAccessTime: ptr FILETIME, lpLastWriteTime: ptr FILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileValidData*(hFile: HANDLE, ValidDataLength: LONGLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnlockFile*(hFile: HANDLE, dwFileOffsetLow: DWORD, dwFileOffsetHigh: DWORD, nNumberOfBytesToUnlockLow: DWORD, nNumberOfBytesToUnlockHigh: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteFileEx*(hFile: HANDLE, lpBuffer: LPCVOID, nNumberOfBytesToWrite: DWORD, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPOVERLAPPED_COMPLETION_ROUTINE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteFileGather*(hFile: HANDLE, aSegmentArray: ptr FILE_SEGMENT_ELEMENT, nNumberOfBytesToWrite: DWORD, lpReserved: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumeNameForVolumeMountPointW*(lpszVolumeMountPoint: LPCWSTR, lpszVolumeName: LPWSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumePathNamesForVolumeNameW*(lpszVolumeName: LPCWSTR, lpszVolumePathNames: LPWCH, cchBufferLength: DWORD, lpcchReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFinalPathNameByHandleA*(hFile: HANDLE, lpszFilePath: LPSTR, cchFilePath: DWORD, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFinalPathNameByHandleW*(hFile: HANDLE, lpszFilePath: LPWSTR, cchFilePath: DWORD, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumeInformationByHandleW*(hFile: HANDLE, lpVolumeNameBuffer: LPWSTR, nVolumeNameSize: DWORD, lpVolumeSerialNumber: LPDWORD, lpMaximumComponentLength: LPDWORD, lpFileSystemFlags: LPDWORD, lpFileSystemNameBuffer: LPWSTR, nFileSystemNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateDirectoryA*(lpPathName: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateDirectoryW*(lpPathName: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteFileA*(lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteFileW*(lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindClose*(hFindFile: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstFileExA*(lpFileName: LPCSTR, fInfoLevelId: FINDEX_INFO_LEVELS, lpFindFileData: LPVOID, fSearchOp: FINDEX_SEARCH_OPS, lpSearchFilter: LPVOID, dwAdditionalFlags: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstFileExW*(lpFileName: LPCWSTR, fInfoLevelId: FINDEX_INFO_LEVELS, lpFindFileData: LPVOID, fSearchOp: FINDEX_SEARCH_OPS, lpSearchFilter: LPVOID, dwAdditionalFlags: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextFileA*(hFindFile: HANDLE, lpFindFileData: LPWIN32_FIND_DATAA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextFileW*(hFindFile: HANDLE, lpFindFileData: LPWIN32_FIND_DATAW): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlushFileBuffers*(hFile: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDiskFreeSpaceExA*(lpDirectoryName: LPCSTR, lpFreeBytesAvailableToCaller: PULARGE_INTEGER, lpTotalNumberOfBytes: PULARGE_INTEGER, lpTotalNumberOfFreeBytes: PULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDiskFreeSpaceExW*(lpDirectoryName: LPCWSTR, lpFreeBytesAvailableToCaller: PULARGE_INTEGER, lpTotalNumberOfBytes: PULARGE_INTEGER, lpTotalNumberOfFreeBytes: PULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileAttributesExA*(lpFileName: LPCSTR, fInfoLevelId: GET_FILEEX_INFO_LEVELS, lpFileInformation: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileAttributesExW*(lpFileName: LPCWSTR, fInfoLevelId: GET_FILEEX_INFO_LEVELS, lpFileInformation: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTempPathW*(nBufferLength: DWORD, lpBuffer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LockFileEx*(hFile: HANDLE, dwFlags: DWORD, dwReserved: DWORD, nNumberOfBytesToLockLow: DWORD, nNumberOfBytesToLockHigh: DWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadFile*(hFile: HANDLE, lpBuffer: LPVOID, nNumberOfBytesToRead: DWORD, lpNumberOfBytesRead: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RemoveDirectoryA*(lpPathName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RemoveDirectoryW*(lpPathName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetEndOfFile*(hFile: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileAttributesA*(lpFileName: LPCSTR, dwFileAttributes: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileAttributesW*(lpFileName: LPCWSTR, dwFileAttributes: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFilePointerEx*(hFile: HANDLE, liDistanceToMove: LARGE_INTEGER, lpNewFilePointer: PLARGE_INTEGER, dwMoveMethod: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnlockFileEx*(hFile: HANDLE, dwReserved: DWORD, nNumberOfBytesToUnlockLow: DWORD, nNumberOfBytesToUnlockHigh: DWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteFile*(hFile: HANDLE, lpBuffer: LPCVOID, nNumberOfBytesToWrite: DWORD, lpNumberOfBytesWritten: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileInformationByHandle*(hFile: HANDLE, FileInformationClass: FILE_INFO_BY_HANDLE_CLASS, lpFileInformation: LPVOID, dwBufferSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFile2*(lpFileName: LPCWSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, dwCreationDisposition: DWORD, pCreateExParams: LPCREATEFILE2_EXTENDED_PARAMETERS): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CloseHandle*(hObject: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DuplicateHandle*(hSourceProcessHandle: HANDLE, hSourceHandle: HANDLE, hTargetProcessHandle: HANDLE, lpTargetHandle: LPHANDLE, dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, dwOptions: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetHandleInformation*(hObject: HANDLE, lpdwFlags: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetHandleInformation*(hObject: HANDLE, dwMask: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapCreate*(flOptions: DWORD, dwInitialSize: SIZE_T, dwMaximumSize: SIZE_T): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapDestroy*(hHeap: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapValidate*(hHeap: HANDLE, dwFlags: DWORD, lpMem: LPCVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapCompact*(hHeap: HANDLE, dwFlags: DWORD): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapSummary*(hHeap: HANDLE, dwFlags: DWORD, lpSummary: LPHEAP_SUMMARY): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessHeaps*(NumberOfHeaps: DWORD, ProcessHeaps: PHANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapLock*(hHeap: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapUnlock*(hHeap: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapWalk*(hHeap: HANDLE, lpEntry: LPPROCESS_HEAP_ENTRY): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapSetInformation*(HeapHandle: HANDLE, HeapInformationClass: HEAP_INFORMATION_CLASS, HeapInformation: PVOID, HeapInformationLength: SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapQueryInformation*(HeapHandle: HANDLE, HeapInformationClass: HEAP_INFORMATION_CLASS, HeapInformation: PVOID, HeapInformationLength: SIZE_T, ReturnLength: PSIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapAlloc*(hHeap: HANDLE, dwFlags: DWORD, dwBytes: SIZE_T): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapReAlloc*(hHeap: HANDLE, dwFlags: DWORD, lpMem: LPVOID, dwBytes: SIZE_T): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapFree*(hHeap: HANDLE, dwFlags: DWORD, lpMem: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc HeapSize*(hHeap: HANDLE, dwFlags: DWORD, lpMem: LPCVOID): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessHeap*(): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetOverlappedResult*(hFile: HANDLE, lpOverlapped: LPOVERLAPPED, lpNumberOfBytesTransferred: LPDWORD, bWait: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateIoCompletionPort*(FileHandle: HANDLE, ExistingCompletionPort: HANDLE, CompletionKey: ULONG_PTR, NumberOfConcurrentThreads: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetQueuedCompletionStatus*(CompletionPort: HANDLE, lpNumberOfBytesTransferred: LPDWORD, lpCompletionKey: PULONG_PTR, lpOverlapped: ptr LPOVERLAPPED, dwMilliseconds: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PostQueuedCompletionStatus*(CompletionPort: HANDLE, dwNumberOfBytesTransferred: DWORD, dwCompletionKey: ULONG_PTR, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeviceIoControl*(hDevice: HANDLE, dwIoControlCode: DWORD, lpInBuffer: LPVOID, nInBufferSize: DWORD, lpOutBuffer: LPVOID, nOutBufferSize: DWORD, lpBytesReturned: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CancelIo*(hFile: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetQueuedCompletionStatusEx*(CompletionPort: HANDLE, lpCompletionPortEntries: LPOVERLAPPED_ENTRY, ulCount: ULONG, ulNumEntriesRemoved: PULONG, dwMilliseconds: DWORD, fAlertable: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CancelIoEx*(hFile: HANDLE, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CancelSynchronousIo*(hThread: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetOverlappedResultEx*(hFile: HANDLE, lpOverlapped: LPOVERLAPPED, lpNumberOfBytesTransferred: LPDWORD, dwMilliseconds: DWORD, bAlertable: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeSListHead*(ListHead: PSLIST_HEADER): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InterlockedPopEntrySList*(ListHead: PSLIST_HEADER): PSLIST_ENTRY {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InterlockedPushEntrySList*(ListHead: PSLIST_HEADER, ListEntry: PSLIST_ENTRY): PSLIST_ENTRY {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InterlockedFlushSList*(ListHead: PSLIST_HEADER): PSLIST_ENTRY {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryDepthSList*(ListHead: PSLIST_HEADER): USHORT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InterlockedPushListSListEx*(ListHead: PSLIST_HEADER, List: PSLIST_ENTRY, ListEnd: PSLIST_ENTRY, Count: ULONG): PSLIST_ENTRY {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsProcessInJob*(ProcessHandle: HANDLE, JobHandle: HANDLE, Result: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindResourceExW*(hModule: HMODULE, lpType: LPCWSTR, lpName: LPCWSTR, wLanguage: WORD): HRSRC {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FreeLibraryAndExitThread*(hLibModule: HMODULE, dwExitCode: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FreeResource*(hResData: HGLOBAL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetModuleFileNameA*(hModule: HMODULE, lpFilename: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetModuleFileNameW*(hModule: HMODULE, lpFilename: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetModuleHandleA*(lpModuleName: LPCSTR): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetModuleHandleW*(lpModuleName: LPCWSTR): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LoadLibraryExA*(lpLibFileName: LPCSTR, hFile: HANDLE, dwFlags: DWORD): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LoadLibraryExW*(lpLibFileName: LPCWSTR, hFile: HANDLE, dwFlags: DWORD): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LoadResource*(hModule: HMODULE, hResInfo: HRSRC): HGLOBAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LoadStringA*(hInstance: HINSTANCE, uID: UINT, lpBuffer: LPSTR, cchBufferMax: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc LoadStringW*(hInstance: HINSTANCE, uID: UINT, lpBuffer: LPWSTR, cchBufferMax: int32): int32 {.winapi, stdcall, dynlib: "user32", importc.}
proc LockResource*(hResData: HGLOBAL): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SizeofResource*(hModule: HMODULE, hResInfo: HRSRC): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddDllDirectory*(NewDirectory: PCWSTR): DLL_DIRECTORY_COOKIE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RemoveDllDirectory*(Cookie: DLL_DIRECTORY_COOKIE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetDefaultDllDirectories*(DirectoryFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetModuleHandleExA*(dwFlags: DWORD, lpModuleName: LPCSTR, phModule: ptr HMODULE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetModuleHandleExW*(dwFlags: DWORD, lpModuleName: LPCWSTR, phModule: ptr HMODULE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceLanguagesA*(hModule: HMODULE, lpType: LPCSTR, lpName: LPCSTR, lpEnumFunc: ENUMRESLANGPROCA, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceLanguagesW*(hModule: HMODULE, lpType: LPCWSTR, lpName: LPCWSTR, lpEnumFunc: ENUMRESLANGPROCW, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceLanguagesExA*(hModule: HMODULE, lpType: LPCSTR, lpName: LPCSTR, lpEnumFunc: ENUMRESLANGPROCA, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceLanguagesExW*(hModule: HMODULE, lpType: LPCWSTR, lpName: LPCWSTR, lpEnumFunc: ENUMRESLANGPROCW, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceNamesExA*(hModule: HMODULE, lpType: LPCSTR, lpEnumFunc: ENUMRESNAMEPROCA, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceNamesExW*(hModule: HMODULE, lpType: LPCWSTR, lpEnumFunc: ENUMRESNAMEPROCW, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceTypesExA*(hModule: HMODULE, lpEnumFunc: ENUMRESTYPEPROCA, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceTypesExW*(hModule: HMODULE, lpEnumFunc: ENUMRESTYPEPROCW, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DisableThreadLibraryCalls*(hLibModule: HMODULE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FreeLibrary*(hLibModule: HMODULE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcAddress*(hModule: HMODULE, lpProcName: LPCSTR): FARPROC {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindStringOrdinal*(dwFindStringOrdinalFlags: DWORD, lpStringSource: LPCWSTR, cchSource: int32, lpStringValue: LPCWSTR, cchValue: int32, bIgnoreCase: WINBOOL): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualQuery*(lpAddress: LPCVOID, lpBuffer: PMEMORY_BASIC_INFORMATION, dwLength: SIZE_T): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlushViewOfFile*(lpBaseAddress: LPCVOID, dwNumberOfBytesToFlush: SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnmapViewOfFile*(lpBaseAddress: LPCVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileMappingFromApp*(hFile: HANDLE, SecurityAttributes: PSECURITY_ATTRIBUTES, PageProtection: ULONG, MaximumSize: ULONG64, Name: PCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MapViewOfFileFromApp*(hFileMappingObject: HANDLE, DesiredAccess: ULONG, FileOffset: ULONG64, NumberOfBytesToMap: SIZE_T): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualAlloc*(lpAddress: LPVOID, dwSize: SIZE_T, flAllocationType: DWORD, flProtect: DWORD): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualFree*(lpAddress: LPVOID, dwSize: SIZE_T, dwFreeType: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualProtect*(lpAddress: LPVOID, dwSize: SIZE_T, flNewProtect: DWORD, lpflOldProtect: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualAllocEx*(hProcess: HANDLE, lpAddress: LPVOID, dwSize: SIZE_T, flAllocationType: DWORD, flProtect: DWORD): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualFreeEx*(hProcess: HANDLE, lpAddress: LPVOID, dwSize: SIZE_T, dwFreeType: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualProtectEx*(hProcess: HANDLE, lpAddress: LPVOID, dwSize: SIZE_T, flNewProtect: DWORD, lpflOldProtect: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualQueryEx*(hProcess: HANDLE, lpAddress: LPCVOID, lpBuffer: PMEMORY_BASIC_INFORMATION, dwLength: SIZE_T): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadProcessMemory*(hProcess: HANDLE, lpBaseAddress: LPCVOID, lpBuffer: LPVOID, nSize: SIZE_T, lpNumberOfBytesRead: ptr SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteProcessMemory*(hProcess: HANDLE, lpBaseAddress: LPVOID, lpBuffer: LPCVOID, nSize: SIZE_T, lpNumberOfBytesWritten: ptr SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileMappingW*(hFile: HANDLE, lpFileMappingAttributes: LPSECURITY_ATTRIBUTES, flProtect: DWORD, dwMaximumSizeHigh: DWORD, dwMaximumSizeLow: DWORD, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenFileMappingW*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MapViewOfFile*(hFileMappingObject: HANDLE, dwDesiredAccess: DWORD, dwFileOffsetHigh: DWORD, dwFileOffsetLow: DWORD, dwNumberOfBytesToMap: SIZE_T): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MapViewOfFileEx*(hFileMappingObject: HANDLE, dwDesiredAccess: DWORD, dwFileOffsetHigh: DWORD, dwFileOffsetLow: DWORD, dwNumberOfBytesToMap: SIZE_T, lpBaseAddress: LPVOID): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLargePageMinimum*(): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessWorkingSetSizeEx*(hProcess: HANDLE, lpMinimumWorkingSetSize: PSIZE_T, lpMaximumWorkingSetSize: PSIZE_T, Flags: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessWorkingSetSizeEx*(hProcess: HANDLE, dwMinimumWorkingSetSize: SIZE_T, dwMaximumWorkingSetSize: SIZE_T, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualLock*(lpAddress: LPVOID, dwSize: SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualUnlock*(lpAddress: LPVOID, dwSize: SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetWriteWatch*(dwFlags: DWORD, lpBaseAddress: PVOID, dwRegionSize: SIZE_T, lpAddresses: ptr PVOID, lpdwCount: ptr ULONG_PTR, lpdwGranularity: LPDWORD): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ResetWriteWatch*(lpBaseAddress: LPVOID, dwRegionSize: SIZE_T): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateMemoryResourceNotification*(NotificationType: MEMORY_RESOURCE_NOTIFICATION_TYPE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryMemoryResourceNotification*(ResourceNotificationHandle: HANDLE, ResourceState: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemFileCacheSize*(lpMinimumFileCacheSize: PSIZE_T, lpMaximumFileCacheSize: PSIZE_T, lpFlags: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetSystemFileCacheSize*(MinimumFileCacheSize: SIZE_T, MaximumFileCacheSize: SIZE_T, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileMappingNumaW*(hFile: HANDLE, lpFileMappingAttributes: LPSECURITY_ATTRIBUTES, flProtect: DWORD, dwMaximumSizeHigh: DWORD, dwMaximumSizeLow: DWORD, lpName: LPCWSTR, nndPreferred: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PrefetchVirtualMemory*(hProcess: HANDLE, NumberOfEntries: ULONG_PTR, VirtualAddresses: PWIN32_MEMORY_RANGE_ENTRY, Flags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnmapViewOfFileEx*(BaseAddress: PVOID, UnmapFlags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DiscardVirtualMemory*(VirtualAddress: PVOID, Size: SIZE_T): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OfferVirtualMemory*(VirtualAddress: PVOID, Size: SIZE_T, Priority: OFFER_PRIORITY): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReclaimVirtualMemory*(VirtualAddress: PVOID, Size: SIZE_T): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ImpersonateNamedPipeClient*(hNamedPipe: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreatePipe*(hReadPipe: PHANDLE, hWritePipe: PHANDLE, lpPipeAttributes: LPSECURITY_ATTRIBUTES, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ConnectNamedPipe*(hNamedPipe: HANDLE, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DisconnectNamedPipe*(hNamedPipe: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetNamedPipeHandleState*(hNamedPipe: HANDLE, lpMode: LPDWORD, lpMaxCollectionCount: LPDWORD, lpCollectDataTimeout: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PeekNamedPipe*(hNamedPipe: HANDLE, lpBuffer: LPVOID, nBufferSize: DWORD, lpBytesRead: LPDWORD, lpTotalBytesAvail: LPDWORD, lpBytesLeftThisMessage: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TransactNamedPipe*(hNamedPipe: HANDLE, lpInBuffer: LPVOID, nInBufferSize: DWORD, lpOutBuffer: LPVOID, nOutBufferSize: DWORD, lpBytesRead: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateNamedPipeW*(lpName: LPCWSTR, dwOpenMode: DWORD, dwPipeMode: DWORD, nMaxInstances: DWORD, nOutBufferSize: DWORD, nInBufferSize: DWORD, nDefaultTimeOut: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitNamedPipeW*(lpNamedPipeName: LPCWSTR, nTimeOut: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeClientComputerNameW*(Pipe: HANDLE, ClientComputerName: LPWSTR, ClientComputerNameLength: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreatePrivateNamespaceW*(lpPrivateNamespaceAttributes: LPSECURITY_ATTRIBUTES, lpBoundaryDescriptor: LPVOID, lpAliasPrefix: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenPrivateNamespaceW*(lpBoundaryDescriptor: LPVOID, lpAliasPrefix: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ClosePrivateNamespace*(Handle: HANDLE, Flags: ULONG): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateBoundaryDescriptorW*(Name: LPCWSTR, Flags: ULONG): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddSIDToBoundaryDescriptor*(BoundaryDescriptor: ptr HANDLE, RequiredSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteBoundaryDescriptor*(BoundaryDescriptor: HANDLE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetEnvironmentStringsA*(): LPCH {.winapi, stdcall, dynlib: "kernel32", importc: "GetEnvironmentStrings".}
proc GetEnvironmentStringsW*(): LPWCH {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetEnvironmentStringsW*(NewEnvironment: LPWCH): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FreeEnvironmentStringsA*(penv: LPCH): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FreeEnvironmentStringsW*(penv: LPWCH): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetStdHandle*(nStdHandle: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetStdHandle*(nStdHandle: DWORD, hHandle: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetStdHandleEx*(nStdHandle: DWORD, hHandle: HANDLE, phPrevValue: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCommandLineA*(): LPSTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCommandLineW*(): LPWSTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetEnvironmentVariableA*(lpName: LPCSTR, lpBuffer: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetEnvironmentVariableW*(lpName: LPCWSTR, lpBuffer: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetEnvironmentVariableA*(lpName: LPCSTR, lpValue: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetEnvironmentVariableW*(lpName: LPCWSTR, lpValue: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ExpandEnvironmentStringsA*(lpSrc: LPCSTR, lpDst: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ExpandEnvironmentStringsW*(lpSrc: LPCWSTR, lpDst: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCurrentDirectoryA*(lpPathName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCurrentDirectoryW*(lpPathName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentDirectoryA*(nBufferLength: DWORD, lpBuffer: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentDirectoryW*(nBufferLength: DWORD, lpBuffer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SearchPathW*(lpPath: LPCWSTR, lpFileName: LPCWSTR, lpExtension: LPCWSTR, nBufferLength: DWORD, lpBuffer: LPWSTR, lpFilePart: ptr LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SearchPathA*(lpPath: LPCSTR, lpFileName: LPCSTR, lpExtension: LPCSTR, nBufferLength: DWORD, lpBuffer: LPSTR, lpFilePart: ptr LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc NeedCurrentDirectoryForExePathA*(ExeName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc NeedCurrentDirectoryForExePathW*(ExeName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueueUserAPC*(pfnAPC: PAPCFUNC, hThread: HANDLE, dwData: ULONG_PTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessTimes*(hProcess: HANDLE, lpCreationTime: LPFILETIME, lpExitTime: LPFILETIME, lpKernelTime: LPFILETIME, lpUserTime: LPFILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ExitProcess*(uExitCode: UINT): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TerminateProcess*(hProcess: HANDLE, uExitCode: UINT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetExitCodeProcess*(hProcess: HANDLE, lpExitCode: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SwitchToThread*(): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateRemoteThread*(hProcess: HANDLE, lpThreadAttributes: LPSECURITY_ATTRIBUTES, dwStackSize: SIZE_T, lpStartAddress: LPTHREAD_START_ROUTINE, lpParameter: LPVOID, dwCreationFlags: DWORD, lpThreadId: LPDWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenThread*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, dwThreadId: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadPriorityBoost*(hThread: HANDLE, bDisablePriorityBoost: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadPriorityBoost*(hThread: HANDLE, pDisablePriorityBoost: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TerminateThread*(hThread: HANDLE, dwExitCode: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessShutdownParameters*(dwLevel: DWORD, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessVersion*(ProcessId: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetStartupInfoW*(lpStartupInfo: LPSTARTUPINFOW): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadToken*(Thread: PHANDLE, Token: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenProcessToken*(ProcessHandle: HANDLE, DesiredAccess: DWORD, TokenHandle: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenThreadToken*(ThreadHandle: HANDLE, DesiredAccess: DWORD, OpenAsSelf: WINBOOL, TokenHandle: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetPriorityClass*(hProcess: HANDLE, dwPriorityClass: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadStackGuarantee*(StackSizeInBytes: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPriorityClass*(hProcess: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ProcessIdToSessionId*(dwProcessId: DWORD, pSessionId: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessId*(Process: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadId*(Thread: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateRemoteThreadEx*(hProcess: HANDLE, lpThreadAttributes: LPSECURITY_ATTRIBUTES, dwStackSize: SIZE_T, lpStartAddress: LPTHREAD_START_ROUTINE, lpParameter: LPVOID, dwCreationFlags: DWORD, lpAttributeList: LPPROC_THREAD_ATTRIBUTE_LIST, lpThreadId: LPDWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadContext*(hThread: HANDLE, lpContext: LPCONTEXT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadContext*(hThread: HANDLE, lpContext: ptr CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlushInstructionCache*(hProcess: HANDLE, lpBaseAddress: LPCVOID, dwSize: SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadTimes*(hThread: HANDLE, lpCreationTime: LPFILETIME, lpExitTime: LPFILETIME, lpKernelTime: LPFILETIME, lpUserTime: LPFILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenProcess*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, dwProcessId: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessHandleCount*(hProcess: HANDLE, pdwHandleCount: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentProcessorNumber*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateProcessA*(lpApplicationName: LPCSTR, lpCommandLine: LPSTR, lpProcessAttributes: LPSECURITY_ATTRIBUTES, lpThreadAttributes: LPSECURITY_ATTRIBUTES, bInheritHandles: WINBOOL, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCSTR, lpStartupInfo: LPSTARTUPINFOA, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateProcessW*(lpApplicationName: LPCWSTR, lpCommandLine: LPWSTR, lpProcessAttributes: LPSECURITY_ATTRIBUTES, lpThreadAttributes: LPSECURITY_ATTRIBUTES, bInheritHandles: WINBOOL, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCWSTR, lpStartupInfo: LPSTARTUPINFOW, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateProcessAsUserW*(hToken: HANDLE, lpApplicationName: LPCWSTR, lpCommandLine: LPWSTR, lpProcessAttributes: LPSECURITY_ATTRIBUTES, lpThreadAttributes: LPSECURITY_ATTRIBUTES, bInheritHandles: WINBOOL, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCWSTR, lpStartupInfo: LPSTARTUPINFOW, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetProcessIdOfThread*(Thread: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeProcThreadAttributeList*(lpAttributeList: LPPROC_THREAD_ATTRIBUTE_LIST, dwAttributeCount: DWORD, dwFlags: DWORD, lpSize: PSIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteProcThreadAttributeList*(lpAttributeList: LPPROC_THREAD_ATTRIBUTE_LIST): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessAffinityUpdateMode*(hProcess: HANDLE, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryProcessAffinityUpdateMode*(hProcess: HANDLE, lpdwFlags: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UpdateProcThreadAttribute*(lpAttributeList: LPPROC_THREAD_ATTRIBUTE_LIST, dwFlags: DWORD, Attribute: DWORD_PTR, lpValue: PVOID, cbSize: SIZE_T, lpPreviousValue: PVOID, lpReturnSize: PSIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadIdealProcessorEx*(hThread: HANDLE, lpIdealProcessor: PPROCESSOR_NUMBER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentProcessorNumberEx*(ProcNumber: PPROCESSOR_NUMBER): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentThreadStackLimits*(LowLimit: PULONG_PTR, HighLimit: PULONG_PTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessMitigationPolicy*(MitigationPolicy: PROCESS_MITIGATION_POLICY, lpBuffer: PVOID, dwLength: SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessMitigationPolicy*(hProcess: HANDLE, MitigationPolicy: PROCESS_MITIGATION_POLICY, lpBuffer: PVOID, dwLength: SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentProcess*(): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentProcessId*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentThread*(): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentThreadId*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsProcessorFeaturePresent*(ProcessorFeature: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlushProcessWriteBuffers*(): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateThread*(lpThreadAttributes: LPSECURITY_ATTRIBUTES, dwStackSize: SIZE_T, lpStartAddress: LPTHREAD_START_ROUTINE, lpParameter: LPVOID, dwCreationFlags: DWORD, lpThreadId: LPDWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadPriority*(hThread: HANDLE, nPriority: int32): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadPriority*(hThread: HANDLE): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ExitThread*(dwExitCode: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetExitCodeThread*(hThread: HANDLE, lpExitCode: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SuspendThread*(hThread: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ResumeThread*(hThread: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TlsAlloc*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TlsGetValue*(dwTlsIndex: DWORD): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TlsSetValue*(dwTlsIndex: DWORD, lpTlsValue: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TlsFree*(dwTlsIndex: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadIdealProcessorEx*(hThread: HANDLE, lpIdealProcessor: PPROCESSOR_NUMBER, lpPreviousIdealProcessor: PPROCESSOR_NUMBER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessGroupAffinity*(hProcess: HANDLE, GroupCount: PUSHORT, GroupArray: PUSHORT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadGroupAffinity*(hThread: HANDLE, GroupAffinity: PGROUP_AFFINITY): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadGroupAffinity*(hThread: HANDLE, GroupAffinity: ptr GROUP_AFFINITY, PreviousGroupAffinity: PGROUP_AFFINITY): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryPerformanceCounter*(lpPerformanceCount: ptr LARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryPerformanceFrequency*(lpFrequency: ptr LARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryThreadCycleTime*(ThreadHandle: HANDLE, CycleTime: PULONG64): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryProcessCycleTime*(ProcessHandle: HANDLE, CycleTime: PULONG64): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryIdleProcessorCycleTime*(BufferLength: PULONG, ProcessorIdleCycleTime: PULONG64): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryIdleProcessorCycleTimeEx*(Group: USHORT, BufferLength: PULONG, ProcessorIdleCycleTime: PULONG64): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryUnbiasedInterruptTime*(UnbiasedTime: PULONGLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetAppContainerNamedObjectPath*(Token: HANDLE, AppContainerSid: PSID, ObjectPathLength: ULONG, ObjectPath: LPWSTR, ReturnLength: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AccessCheck*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, ClientToken: HANDLE, DesiredAccess: DWORD, GenericMapping: PGENERIC_MAPPING, PrivilegeSet: PPRIVILEGE_SET, PrivilegeSetLength: LPDWORD, GrantedAccess: LPDWORD, AccessStatus: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckAndAuditAlarmW*(SubsystemName: LPCWSTR, HandleId: LPVOID, ObjectTypeName: LPWSTR, ObjectName: LPWSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, DesiredAccess: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatus: LPBOOL, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckByType*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, ClientToken: HANDLE, DesiredAccess: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, PrivilegeSet: PPRIVILEGE_SET, PrivilegeSetLength: LPDWORD, GrantedAccess: LPDWORD, AccessStatus: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckByTypeResultList*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, ClientToken: HANDLE, DesiredAccess: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, PrivilegeSet: PPRIVILEGE_SET, PrivilegeSetLength: LPDWORD, GrantedAccessList: LPDWORD, AccessStatusList: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckByTypeAndAuditAlarmW*(SubsystemName: LPCWSTR, HandleId: LPVOID, ObjectTypeName: LPCWSTR, ObjectName: LPCWSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatus: LPBOOL, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckByTypeResultListAndAuditAlarmW*(SubsystemName: LPCWSTR, HandleId: LPVOID, ObjectTypeName: LPCWSTR, ObjectName: LPCWSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccessList: LPDWORD, AccessStatusList: LPDWORD, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckByTypeResultListAndAuditAlarmByHandleW*(SubsystemName: LPCWSTR, HandleId: LPVOID, ClientToken: HANDLE, ObjectTypeName: LPCWSTR, ObjectName: LPCWSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccessList: LPDWORD, AccessStatusList: LPDWORD, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAccessAllowedAce*(pAcl: PACL, dwAceRevision: DWORD, AccessMask: DWORD, pSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAccessAllowedAceEx*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, AccessMask: DWORD, pSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAccessAllowedObjectAce*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, AccessMask: DWORD, ObjectTypeGuid: ptr GUID, InheritedObjectTypeGuid: ptr GUID, pSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAccessDeniedAce*(pAcl: PACL, dwAceRevision: DWORD, AccessMask: DWORD, pSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAccessDeniedAceEx*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, AccessMask: DWORD, pSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAccessDeniedObjectAce*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, AccessMask: DWORD, ObjectTypeGuid: ptr GUID, InheritedObjectTypeGuid: ptr GUID, pSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAce*(pAcl: PACL, dwAceRevision: DWORD, dwStartingAceIndex: DWORD, pAceList: LPVOID, nAceListLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAuditAccessAce*(pAcl: PACL, dwAceRevision: DWORD, dwAccessMask: DWORD, pSid: PSID, bAuditSuccess: WINBOOL, bAuditFailure: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAuditAccessAceEx*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, dwAccessMask: DWORD, pSid: PSID, bAuditSuccess: WINBOOL, bAuditFailure: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddAuditAccessObjectAce*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, AccessMask: DWORD, ObjectTypeGuid: ptr GUID, InheritedObjectTypeGuid: ptr GUID, pSid: PSID, bAuditSuccess: WINBOOL, bAuditFailure: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddMandatoryAce*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, MandatoryPolicy: DWORD, pLabelSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AddResourceAttributeAce*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, AccessMask: DWORD, pSid: PSID, pAttributeInfo: PCLAIM_SECURITY_ATTRIBUTES_INFORMATION, pReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddScopedPolicyIDAce*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, AccessMask: DWORD, pSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AdjustTokenGroups*(TokenHandle: HANDLE, ResetToDefault: WINBOOL, NewState: PTOKEN_GROUPS, BufferLength: DWORD, PreviousState: PTOKEN_GROUPS, ReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AdjustTokenPrivileges*(TokenHandle: HANDLE, DisableAllPrivileges: WINBOOL, NewState: PTOKEN_PRIVILEGES, BufferLength: DWORD, PreviousState: PTOKEN_PRIVILEGES, ReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AllocateAndInitializeSid*(pIdentifierAuthority: PSID_IDENTIFIER_AUTHORITY, nSubAuthorityCount: BYTE, nSubAuthority0: DWORD, nSubAuthority1: DWORD, nSubAuthority2: DWORD, nSubAuthority3: DWORD, nSubAuthority4: DWORD, nSubAuthority5: DWORD, nSubAuthority6: DWORD, nSubAuthority7: DWORD, pSid: ptr PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AllocateLocallyUniqueId*(Luid: PLUID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AreAllAccessesGranted*(GrantedAccess: DWORD, DesiredAccess: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AreAnyAccessesGranted*(GrantedAccess: DWORD, DesiredAccess: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CheckTokenMembership*(TokenHandle: HANDLE, SidToCheck: PSID, IsMember: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CheckTokenCapability*(TokenHandle: HANDLE, CapabilitySidToCheck: PSID, HasCapability: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetAppContainerAce*(Acl: PACL, StartingAceIndex: DWORD, AppContainerAce: ptr PVOID, AppContainerAceIndex: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CheckTokenMembershipEx*(TokenHandle: HANDLE, SidToCheck: PSID, Flags: DWORD, IsMember: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ConvertToAutoInheritPrivateObjectSecurity*(ParentDescriptor: PSECURITY_DESCRIPTOR, CurrentSecurityDescriptor: PSECURITY_DESCRIPTOR, NewSecurityDescriptor: ptr PSECURITY_DESCRIPTOR, ObjectType: ptr GUID, IsDirectoryObject: BOOLEAN, GenericMapping: PGENERIC_MAPPING): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CopySid*(nDestinationSidLength: DWORD, pDestinationSid: PSID, pSourceSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreatePrivateObjectSecurity*(ParentDescriptor: PSECURITY_DESCRIPTOR, CreatorDescriptor: PSECURITY_DESCRIPTOR, NewDescriptor: ptr PSECURITY_DESCRIPTOR, IsDirectoryObject: WINBOOL, Token: HANDLE, GenericMapping: PGENERIC_MAPPING): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreatePrivateObjectSecurityEx*(ParentDescriptor: PSECURITY_DESCRIPTOR, CreatorDescriptor: PSECURITY_DESCRIPTOR, NewDescriptor: ptr PSECURITY_DESCRIPTOR, ObjectType: ptr GUID, IsContainerObject: WINBOOL, AutoInheritFlags: ULONG, Token: HANDLE, GenericMapping: PGENERIC_MAPPING): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreatePrivateObjectSecurityWithMultipleInheritance*(ParentDescriptor: PSECURITY_DESCRIPTOR, CreatorDescriptor: PSECURITY_DESCRIPTOR, NewDescriptor: ptr PSECURITY_DESCRIPTOR, ObjectTypes: ptr ptr GUID, GuidCount: ULONG, IsContainerObject: WINBOOL, AutoInheritFlags: ULONG, Token: HANDLE, GenericMapping: PGENERIC_MAPPING): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreateRestrictedToken*(ExistingTokenHandle: HANDLE, Flags: DWORD, DisableSidCount: DWORD, SidsToDisable: PSID_AND_ATTRIBUTES, DeletePrivilegeCount: DWORD, PrivilegesToDelete: PLUID_AND_ATTRIBUTES, RestrictedSidCount: DWORD, SidsToRestrict: PSID_AND_ATTRIBUTES, NewTokenHandle: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreateWellKnownSid*(WellKnownSidType: WELL_KNOWN_SID_TYPE, DomainSid: PSID, pSid: PSID, cbSid: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EqualDomainSid*(pSid1: PSID, pSid2: PSID, pfEqual: ptr WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DeleteAce*(pAcl: PACL, dwAceIndex: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DestroyPrivateObjectSecurity*(ObjectDescriptor: ptr PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DuplicateToken*(ExistingTokenHandle: HANDLE, ImpersonationLevel: SECURITY_IMPERSONATION_LEVEL, DuplicateTokenHandle: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DuplicateTokenEx*(hExistingToken: HANDLE, dwDesiredAccess: DWORD, lpTokenAttributes: LPSECURITY_ATTRIBUTES, ImpersonationLevel: SECURITY_IMPERSONATION_LEVEL, TokenType: TOKEN_TYPE, phNewToken: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EqualPrefixSid*(pSid1: PSID, pSid2: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EqualSid*(pSid1: PSID, pSid2: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc FindFirstFreeAce*(pAcl: PACL, pAce: ptr LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc FreeSid*(pSid: PSID): PVOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetAce*(pAcl: PACL, dwAceIndex: DWORD, pAce: ptr LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetAclInformation*(pAcl: PACL, pAclInformation: LPVOID, nAclInformationLength: DWORD, dwAclInformationClass: ACL_INFORMATION_CLASS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetFileSecurityW*(lpFileName: LPCWSTR, RequestedInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetKernelObjectSecurity*(Handle: HANDLE, RequestedInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetLengthSid*(pSid: PSID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetPrivateObjectSecurity*(ObjectDescriptor: PSECURITY_DESCRIPTOR, SecurityInformation: SECURITY_INFORMATION, ResultantDescriptor: PSECURITY_DESCRIPTOR, DescriptorLength: DWORD, ReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSecurityDescriptorControl*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, pControl: PSECURITY_DESCRIPTOR_CONTROL, lpdwRevision: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSecurityDescriptorDacl*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, lpbDaclPresent: LPBOOL, pDacl: ptr PACL, lpbDaclDefaulted: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSecurityDescriptorGroup*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, pGroup: ptr PSID, lpbGroupDefaulted: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSecurityDescriptorLength*(pSecurityDescriptor: PSECURITY_DESCRIPTOR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSecurityDescriptorOwner*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, pOwner: ptr PSID, lpbOwnerDefaulted: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSecurityDescriptorRMControl*(SecurityDescriptor: PSECURITY_DESCRIPTOR, RMControl: PUCHAR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSecurityDescriptorSacl*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, lpbSaclPresent: LPBOOL, pSacl: ptr PACL, lpbSaclDefaulted: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSidIdentifierAuthority*(pSid: PSID): PSID_IDENTIFIER_AUTHORITY {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSidLengthRequired*(nSubAuthorityCount: UCHAR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSidSubAuthority*(pSid: PSID, nSubAuthority: DWORD): PDWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetSidSubAuthorityCount*(pSid: PSID): PUCHAR {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetTokenInformation*(TokenHandle: HANDLE, TokenInformationClass: TOKEN_INFORMATION_CLASS, TokenInformation: LPVOID, TokenInformationLength: DWORD, ReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetWindowsAccountDomainSid*(pSid: PSID, pDomainSid: PSID, cbDomainSid: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ImpersonateAnonymousToken*(ThreadHandle: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ImpersonateLoggedOnUser*(hToken: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ImpersonateSelf*(ImpersonationLevel: SECURITY_IMPERSONATION_LEVEL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitializeAcl*(pAcl: PACL, nAclLength: DWORD, dwAclRevision: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitializeSecurityDescriptor*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, dwRevision: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc InitializeSid*(Sid: PSID, pIdentifierAuthority: PSID_IDENTIFIER_AUTHORITY, nSubAuthorityCount: BYTE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc IsTokenRestricted*(TokenHandle: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc IsValidAcl*(pAcl: PACL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc IsValidSecurityDescriptor*(pSecurityDescriptor: PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc IsValidSid*(pSid: PSID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc IsWellKnownSid*(pSid: PSID, WellKnownSidType: WELL_KNOWN_SID_TYPE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc MakeAbsoluteSD*(pSelfRelativeSecurityDescriptor: PSECURITY_DESCRIPTOR, pAbsoluteSecurityDescriptor: PSECURITY_DESCRIPTOR, lpdwAbsoluteSecurityDescriptorSize: LPDWORD, pDacl: PACL, lpdwDaclSize: LPDWORD, pSacl: PACL, lpdwSaclSize: LPDWORD, pOwner: PSID, lpdwOwnerSize: LPDWORD, pPrimaryGroup: PSID, lpdwPrimaryGroupSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc MakeSelfRelativeSD*(pAbsoluteSecurityDescriptor: PSECURITY_DESCRIPTOR, pSelfRelativeSecurityDescriptor: PSECURITY_DESCRIPTOR, lpdwBufferLength: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc MapGenericMask*(AccessMask: PDWORD, GenericMapping: PGENERIC_MAPPING): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ObjectCloseAuditAlarmW*(SubsystemName: LPCWSTR, HandleId: LPVOID, GenerateOnClose: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ObjectDeleteAuditAlarmW*(SubsystemName: LPCWSTR, HandleId: LPVOID, GenerateOnClose: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ObjectOpenAuditAlarmW*(SubsystemName: LPCWSTR, HandleId: LPVOID, ObjectTypeName: LPWSTR, ObjectName: LPWSTR, pSecurityDescriptor: PSECURITY_DESCRIPTOR, ClientToken: HANDLE, DesiredAccess: DWORD, GrantedAccess: DWORD, Privileges: PPRIVILEGE_SET, ObjectCreation: WINBOOL, AccessGranted: WINBOOL, GenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ObjectPrivilegeAuditAlarmW*(SubsystemName: LPCWSTR, HandleId: LPVOID, ClientToken: HANDLE, DesiredAccess: DWORD, Privileges: PPRIVILEGE_SET, AccessGranted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc PrivilegeCheck*(ClientToken: HANDLE, RequiredPrivileges: PPRIVILEGE_SET, pfResult: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc PrivilegedServiceAuditAlarmW*(SubsystemName: LPCWSTR, ServiceName: LPCWSTR, ClientToken: HANDLE, Privileges: PPRIVILEGE_SET, AccessGranted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc QuerySecurityAccessMask*(SecurityInformation: SECURITY_INFORMATION, DesiredAccess: LPDWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RevertToSelf*(): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetAclInformation*(pAcl: PACL, pAclInformation: LPVOID, nAclInformationLength: DWORD, dwAclInformationClass: ACL_INFORMATION_CLASS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetFileSecurityW*(lpFileName: LPCWSTR, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetKernelObjectSecurity*(Handle: HANDLE, SecurityInformation: SECURITY_INFORMATION, SecurityDescriptor: PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetPrivateObjectSecurity*(SecurityInformation: SECURITY_INFORMATION, ModificationDescriptor: PSECURITY_DESCRIPTOR, ObjectsSecurityDescriptor: ptr PSECURITY_DESCRIPTOR, GenericMapping: PGENERIC_MAPPING, Token: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetPrivateObjectSecurityEx*(SecurityInformation: SECURITY_INFORMATION, ModificationDescriptor: PSECURITY_DESCRIPTOR, ObjectsSecurityDescriptor: ptr PSECURITY_DESCRIPTOR, AutoInheritFlags: ULONG, GenericMapping: PGENERIC_MAPPING, Token: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetSecurityAccessMask*(SecurityInformation: SECURITY_INFORMATION, DesiredAccess: LPDWORD): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetSecurityDescriptorControl*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, ControlBitsOfInterest: SECURITY_DESCRIPTOR_CONTROL, ControlBitsToSet: SECURITY_DESCRIPTOR_CONTROL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetSecurityDescriptorDacl*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, bDaclPresent: WINBOOL, pDacl: PACL, bDaclDefaulted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetSecurityDescriptorGroup*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, pGroup: PSID, bGroupDefaulted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetSecurityDescriptorOwner*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, pOwner: PSID, bOwnerDefaulted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetSecurityDescriptorRMControl*(SecurityDescriptor: PSECURITY_DESCRIPTOR, RMControl: PUCHAR): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetSecurityDescriptorSacl*(pSecurityDescriptor: PSECURITY_DESCRIPTOR, bSaclPresent: WINBOOL, pSacl: PACL, bSaclDefaulted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetTokenInformation*(TokenHandle: HANDLE, TokenInformationClass: TOKEN_INFORMATION_CLASS, TokenInformation: LPVOID, TokenInformationLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetCachedSigningLevel*(SourceFiles: PHANDLE, SourceFileCount: ULONG, Flags: ULONG, TargetFile: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCachedSigningLevel*(File: HANDLE, Flags: PULONG, SigningLevel: PULONG, Thumbprint: PUCHAR, ThumbprintSize: PULONG, ThumbprintAlgorithm: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnterCriticalSection*(lpCriticalSection: LPCRITICAL_SECTION): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LeaveCriticalSection*(lpCriticalSection: LPCRITICAL_SECTION): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TryEnterCriticalSection*(lpCriticalSection: LPCRITICAL_SECTION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteCriticalSection*(lpCriticalSection: LPCRITICAL_SECTION): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetEvent*(hEvent: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ResetEvent*(hEvent: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReleaseSemaphore*(hSemaphore: HANDLE, lReleaseCount: LONG, lpPreviousCount: LPLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReleaseMutex*(hMutex: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForSingleObjectEx*(hHandle: HANDLE, dwMilliseconds: DWORD, bAlertable: WINBOOL): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForMultipleObjectsEx*(nCount: DWORD, lpHandles: ptr HANDLE, bWaitAll: WINBOOL, dwMilliseconds: DWORD, bAlertable: WINBOOL): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenMutexW*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenEventA*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenEventW*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenSemaphoreW*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeSRWLock*(SRWLock: PSRWLOCK): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReleaseSRWLockExclusive*(SRWLock: PSRWLOCK): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReleaseSRWLockShared*(SRWLock: PSRWLOCK): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AcquireSRWLockExclusive*(SRWLock: PSRWLOCK): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AcquireSRWLockShared*(SRWLock: PSRWLOCK): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TryAcquireSRWLockExclusive*(SRWLock: PSRWLOCK): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TryAcquireSRWLockShared*(SRWLock: PSRWLOCK): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeCriticalSectionEx*(lpCriticalSection: LPCRITICAL_SECTION, dwSpinCount: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitOnceInitialize*(InitOnce: PINIT_ONCE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitOnceExecuteOnce*(InitOnce: PINIT_ONCE, InitFn: PINIT_ONCE_FN, Parameter: PVOID, Context: ptr LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitOnceBeginInitialize*(lpInitOnce: LPINIT_ONCE, dwFlags: DWORD, fPending: PBOOL, lpContext: ptr LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitOnceComplete*(lpInitOnce: LPINIT_ONCE, dwFlags: DWORD, lpContext: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeConditionVariable*(ConditionVariable: PCONDITION_VARIABLE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WakeConditionVariable*(ConditionVariable: PCONDITION_VARIABLE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WakeAllConditionVariable*(ConditionVariable: PCONDITION_VARIABLE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SleepConditionVariableCS*(ConditionVariable: PCONDITION_VARIABLE, CriticalSection: PCRITICAL_SECTION, dwMilliseconds: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SleepConditionVariableSRW*(ConditionVariable: PCONDITION_VARIABLE, SRWLock: PSRWLOCK, dwMilliseconds: DWORD, Flags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateMutexExA*(lpMutexAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateMutexExW*(lpMutexAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateEventExA*(lpEventAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateEventExW*(lpEventAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateSemaphoreExW*(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES, lInitialCount: LONG, lMaximumCount: LONG, lpName: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeCriticalSection*(lpCriticalSection: LPCRITICAL_SECTION): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeCriticalSectionAndSpinCount*(lpCriticalSection: LPCRITICAL_SECTION, dwSpinCount: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCriticalSectionSpinCount*(lpCriticalSection: LPCRITICAL_SECTION, dwSpinCount: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForSingleObject*(hHandle: HANDLE, dwMilliseconds: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SleepEx*(dwMilliseconds: DWORD, bAlertable: WINBOOL): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateMutexA*(lpMutexAttributes: LPSECURITY_ATTRIBUTES, bInitialOwner: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateMutexW*(lpMutexAttributes: LPSECURITY_ATTRIBUTES, bInitialOwner: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateEventA*(lpEventAttributes: LPSECURITY_ATTRIBUTES, bManualReset: WINBOOL, bInitialState: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateEventW*(lpEventAttributes: LPSECURITY_ATTRIBUTES, bManualReset: WINBOOL, bInitialState: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetWaitableTimer*(hTimer: HANDLE, lpDueTime: ptr LARGE_INTEGER, lPeriod: LONG, pfnCompletionRoutine: PTIMERAPCROUTINE, lpArgToCompletionRoutine: LPVOID, fResume: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CancelWaitableTimer*(hTimer: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenWaitableTimerW*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpTimerName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnterSynchronizationBarrier*(lpBarrier: LPSYNCHRONIZATION_BARRIER, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeSynchronizationBarrier*(lpBarrier: LPSYNCHRONIZATION_BARRIER, lTotalThreads: LONG, lSpinCount: LONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteSynchronizationBarrier*(lpBarrier: LPSYNCHRONIZATION_BARRIER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Sleep*(dwMilliseconds: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SignalObjectAndWait*(hObjectToSignal: HANDLE, hObjectToWaitOn: HANDLE, dwMilliseconds: DWORD, bAlertable: WINBOOL): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateWaitableTimerExW*(lpTimerAttributes: LPSECURITY_ATTRIBUTES, lpTimerName: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetWaitableTimerEx*(hTimer: HANDLE, lpDueTime: ptr LARGE_INTEGER, lPeriod: LONG, pfnCompletionRoutine: PTIMERAPCROUTINE, lpArgToCompletionRoutine: LPVOID, WakeContext: PREASON_CONTEXT, TolerableDelay: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemTime*(lpSystemTime: LPSYSTEMTIME): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemTimeAsFileTime*(lpSystemTimeAsFileTime: LPFILETIME): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLocalTime*(lpSystemTime: LPSYSTEMTIME): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNativeSystemInfo*(lpSystemInfo: LPSYSTEM_INFO): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTickCount64*(): ULONGLONG {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVersion*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalMemoryStatusEx*(lpBuffer: LPMEMORYSTATUSEX): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetLocalTime*(lpSystemTime: ptr SYSTEMTIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemInfo*(lpSystemInfo: LPSYSTEM_INFO): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTickCount*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemTimeAdjustment*(lpTimeAdjustment: PDWORD, lpTimeIncrement: PDWORD, lpTimeAdjustmentDisabled: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemDirectoryA*(lpBuffer: LPSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemDirectoryW*(lpBuffer: LPWSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetWindowsDirectoryA*(lpBuffer: LPSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetWindowsDirectoryW*(lpBuffer: LPWSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemWindowsDirectoryA*(lpBuffer: LPSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemWindowsDirectoryW*(lpBuffer: LPWSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetComputerNameExA*(NameType: COMPUTER_NAME_FORMAT, lpBuffer: LPSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetComputerNameExW*(NameType: COMPUTER_NAME_FORMAT, lpBuffer: LPWSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetComputerNameExW*(NameType: COMPUTER_NAME_FORMAT, lpBuffer: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetSystemTime*(lpSystemTime: ptr SYSTEMTIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVersionExA*(lpVersionInformation: LPOSVERSIONINFOA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVersionExW*(lpVersionInformation: LPOSVERSIONINFOW): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLogicalProcessorInformation*(Buffer: PSYSTEM_LOGICAL_PROCESSOR_INFORMATION, ReturnedLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemTimePreciseAsFileTime*(lpSystemTimeAsFileTime: LPFILETIME): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemFirmwareTables*(FirmwareTableProviderSignature: DWORD, pFirmwareTableEnumBuffer: PVOID, BufferSize: DWORD): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemFirmwareTable*(FirmwareTableProviderSignature: DWORD, FirmwareTableID: DWORD, pFirmwareTableBuffer: PVOID, BufferSize: DWORD): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProductInfo*(dwOSMajorVersion: DWORD, dwOSMinorVersion: DWORD, dwSpMajorVersion: DWORD, dwSpMinorVersion: DWORD, pdwReturnedProductType: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLogicalProcessorInformationEx*(RelationshipType: LOGICAL_PROCESSOR_RELATIONSHIP, Buffer: PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX, ReturnedLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaHighestNodeNumber*(HighestNodeNumber: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaNodeProcessorMaskEx*(Node: USHORT, ProcessorMask: PGROUP_AFFINITY): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateThreadpool*(reserved: PVOID): PTP_POOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadpoolThreadMaximum*(ptpp: PTP_POOL, cthrdMost: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadpoolThreadMinimum*(ptpp: PTP_POOL, cthrdMic: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadpoolStackInformation*(ptpp: PTP_POOL, ptpsi: PTP_POOL_STACK_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryThreadpoolStackInformation*(ptpp: PTP_POOL, ptpsi: PTP_POOL_STACK_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CloseThreadpool*(ptpp: PTP_POOL): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateThreadpoolCleanupGroup*(): PTP_CLEANUP_GROUP {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CloseThreadpoolCleanupGroupMembers*(ptpcg: PTP_CLEANUP_GROUP, fCancelPendingCallbacks: WINBOOL, pvCleanupContext: PVOID): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CloseThreadpoolCleanupGroup*(ptpcg: PTP_CLEANUP_GROUP): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetEventWhenCallbackReturns*(pci: PTP_CALLBACK_INSTANCE, evt: HANDLE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReleaseSemaphoreWhenCallbackReturns*(pci: PTP_CALLBACK_INSTANCE, sem: HANDLE, crel: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReleaseMutexWhenCallbackReturns*(pci: PTP_CALLBACK_INSTANCE, mut: HANDLE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LeaveCriticalSectionWhenCallbackReturns*(pci: PTP_CALLBACK_INSTANCE, pcs: PCRITICAL_SECTION): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FreeLibraryWhenCallbackReturns*(pci: PTP_CALLBACK_INSTANCE, `mod`: HMODULE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CallbackMayRunLong*(pci: PTP_CALLBACK_INSTANCE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DisassociateCurrentThreadFromCallback*(pci: PTP_CALLBACK_INSTANCE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TrySubmitThreadpoolCallback*(pfns: PTP_SIMPLE_CALLBACK, pv: PVOID, pcbe: PTP_CALLBACK_ENVIRON): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateThreadpoolWork*(pfnwk: PTP_WORK_CALLBACK, pv: PVOID, pcbe: PTP_CALLBACK_ENVIRON): PTP_WORK {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SubmitThreadpoolWork*(pwk: PTP_WORK): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForThreadpoolWorkCallbacks*(pwk: PTP_WORK, fCancelPendingCallbacks: WINBOOL): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CloseThreadpoolWork*(pwk: PTP_WORK): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateThreadpoolTimer*(pfnti: PTP_TIMER_CALLBACK, pv: PVOID, pcbe: PTP_CALLBACK_ENVIRON): PTP_TIMER {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadpoolTimer*(pti: PTP_TIMER, pftDueTime: PFILETIME, msPeriod: DWORD, msWindowLength: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsThreadpoolTimerSet*(pti: PTP_TIMER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForThreadpoolTimerCallbacks*(pti: PTP_TIMER, fCancelPendingCallbacks: WINBOOL): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CloseThreadpoolTimer*(pti: PTP_TIMER): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateThreadpoolWait*(pfnwa: PTP_WAIT_CALLBACK, pv: PVOID, pcbe: PTP_CALLBACK_ENVIRON): PTP_WAIT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadpoolWait*(pwa: PTP_WAIT, h: HANDLE, pftTimeout: PFILETIME): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForThreadpoolWaitCallbacks*(pwa: PTP_WAIT, fCancelPendingCallbacks: WINBOOL): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CloseThreadpoolWait*(pwa: PTP_WAIT): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateThreadpoolIo*(fl: HANDLE, pfnio: PTP_WIN32_IO_CALLBACK, pv: PVOID, pcbe: PTP_CALLBACK_ENVIRON): PTP_IO {.winapi, stdcall, dynlib: "kernel32", importc.}
proc StartThreadpoolIo*(pio: PTP_IO): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CancelThreadpoolIo*(pio: PTP_IO): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForThreadpoolIoCallbacks*(pio: PTP_IO, fCancelPendingCallbacks: WINBOOL): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CloseThreadpoolIo*(pio: PTP_IO): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadpoolTimerEx*(pti: PTP_TIMER, pftDueTime: PFILETIME, msPeriod: DWORD, msWindowLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadpoolWaitEx*(pwa: PTP_WAIT, h: HANDLE, pftTimeout: PFILETIME, Reserved: PVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateTimerQueueTimer*(phNewTimer: PHANDLE, TimerQueue: HANDLE, Callback: WAITORTIMERCALLBACK, Parameter: PVOID, DueTime: DWORD, Period: DWORD, Flags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteTimerQueueTimer*(TimerQueue: HANDLE, Timer: HANDLE, CompletionEvent: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueueUserWorkItem*(Function: LPTHREAD_START_ROUTINE, Context: PVOID, Flags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnregisterWaitEx*(WaitHandle: HANDLE, CompletionEvent: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateTimerQueue*(): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ChangeTimerQueueTimer*(TimerQueue: HANDLE, Timer: HANDLE, DueTime: ULONG, Period: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteTimerQueueEx*(TimerQueue: HANDLE, CompletionEvent: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EncodePointer*(Ptr: PVOID): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DecodePointer*(Ptr: PVOID): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EncodeSystemPointer*(Ptr: PVOID): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DecodeSystemPointer*(Ptr: PVOID): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Beep*(dwFreq: DWORD, dwDuration: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Wow64DisableWow64FsRedirection*(OldValue: ptr PVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Wow64RevertWow64FsRedirection*(OlValue: PVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsWow64Process*(hProcess: HANDLE, Wow64Process: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalAlloc*(uFlags: UINT, dwBytes: SIZE_T): HGLOBAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalReAlloc*(hMem: HGLOBAL, dwBytes: SIZE_T, uFlags: UINT): HGLOBAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalSize*(hMem: HGLOBAL): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalFlags*(hMem: HGLOBAL): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalLock*(hMem: HGLOBAL): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalHandle*(pMem: LPCVOID): HGLOBAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalUnlock*(hMem: HGLOBAL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalFree*(hMem: HGLOBAL): HGLOBAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalCompact*(dwMinFree: DWORD): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalFix*(hMem: HGLOBAL): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalUnfix*(hMem: HGLOBAL): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalWire*(hMem: HGLOBAL): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalUnWire*(hMem: HGLOBAL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalMemoryStatus*(lpBuffer: LPMEMORYSTATUS): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalAlloc*(uFlags: UINT, uBytes: SIZE_T): HLOCAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalReAlloc*(hMem: HLOCAL, uBytes: SIZE_T, uFlags: UINT): HLOCAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalLock*(hMem: HLOCAL): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalHandle*(pMem: LPCVOID): HLOCAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalUnlock*(hMem: HLOCAL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalSize*(hMem: HLOCAL): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalFlags*(hMem: HLOCAL): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalFree*(hMem: HLOCAL): HLOCAL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalShrink*(hMem: HLOCAL, cbNewSize: UINT): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocalCompact*(uMinFree: UINT): SIZE_T {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VirtualAllocExNuma*(hProcess: HANDLE, lpAddress: LPVOID, dwSize: SIZE_T, flAllocationType: DWORD, flProtect: DWORD, nndPreferred: DWORD): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessorSystemCycleTime*(Group: USHORT, Buffer: PSYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION, ReturnedLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPhysicallyInstalledSystemMemory*(TotalMemoryInKilobytes: PULONGLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetBinaryTypeA*(lpApplicationName: LPCSTR, lpBinaryType: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetBinaryTypeW*(lpApplicationName: LPCWSTR, lpBinaryType: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetShortPathNameA*(lpszLongPath: LPCSTR, lpszShortPath: LPSTR, cchBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLongPathNameTransactedA*(lpszShortPath: LPCSTR, lpszLongPath: LPSTR, cchBuffer: DWORD, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLongPathNameTransactedW*(lpszShortPath: LPCWSTR, lpszLongPath: LPWSTR, cchBuffer: DWORD, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessAffinityMask*(hProcess: HANDLE, lpProcessAffinityMask: PDWORD_PTR, lpSystemAffinityMask: PDWORD_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessAffinityMask*(hProcess: HANDLE, dwProcessAffinityMask: DWORD_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessIoCounters*(hProcess: HANDLE, lpIoCounters: PIO_COUNTERS): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessWorkingSetSize*(hProcess: HANDLE, lpMinimumWorkingSetSize: PSIZE_T, lpMaximumWorkingSetSize: PSIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessWorkingSetSize*(hProcess: HANDLE, dwMinimumWorkingSetSize: SIZE_T, dwMaximumWorkingSetSize: SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FatalExit*(ExitCode: int32): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetEnvironmentStringsA*(NewEnvironment: LPCH): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RaiseFailFastException*(pExceptionRecord: PEXCEPTION_RECORD, pContextRecord: PCONTEXT, dwFlags: DWORD): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadIdealProcessor*(hThread: HANDLE, dwIdealProcessor: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFiber*(dwStackSize: SIZE_T, lpStartAddress: LPFIBER_START_ROUTINE, lpParameter: LPVOID): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFiberEx*(dwStackCommitSize: SIZE_T, dwStackReserveSize: SIZE_T, dwFlags: DWORD, lpStartAddress: LPFIBER_START_ROUTINE, lpParameter: LPVOID): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteFiber*(lpFiber: LPVOID): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ConvertThreadToFiber*(lpParameter: LPVOID): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ConvertThreadToFiberEx*(lpParameter: LPVOID, dwFlags: DWORD): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ConvertFiberToThread*(): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SwitchToFiber*(lpFiber: LPVOID): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadAffinityMask*(hThread: HANDLE, dwThreadAffinityMask: DWORD_PTR): DWORD_PTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadInformation*(hThread: HANDLE, ThreadInformationClass: THREAD_INFORMATION_CLASS, ThreadInformation: LPVOID, ThreadInformationSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadInformation*(hThread: HANDLE, ThreadInformationClass: THREAD_INFORMATION_CLASS, ThreadInformation: LPVOID, ThreadInformationSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessInformation*(hProcess: HANDLE, ProcessInformationClass: PROCESS_INFORMATION_CLASS, ProcessInformation: LPVOID, ProcessInformationSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessInformation*(hProcess: HANDLE, ProcessInformationClass: PROCESS_INFORMATION_CLASS, ProcessInformation: LPVOID, ProcessInformationSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessDEPPolicy*(dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessDEPPolicy*(hProcess: HANDLE, lpFlags: LPDWORD, lpPermanent: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessPriorityBoost*(hProcess: HANDLE, bDisablePriorityBoost: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessPriorityBoost*(hProcess: HANDLE, pDisablePriorityBoost: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RequestWakeupLatency*(latency: LATENCY_TIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsSystemResumeAutomatic*(): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadIOPendingFlag*(hThread: HANDLE, lpIOIsPending: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
when winimCpu64:
  type
    LPLDT_ENTRY* = LPVOID
when winimCpu32:
  type
    LPLDT_ENTRY* = PLDT_ENTRY
proc GetThreadSelectorEntry*(hThread: HANDLE, dwSelector: DWORD, lpSelectorEntry: LPLDT_ENTRY): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadExecutionState*(esFlags: EXECUTION_STATE): EXECUTION_STATE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PowerCreateRequest*(Context: PREASON_CONTEXT): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PowerSetRequest*(PowerRequest: HANDLE, RequestType: POWER_REQUEST_TYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PowerClearRequest*(PowerRequest: HANDLE, RequestType: POWER_REQUEST_TYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileCompletionNotificationModes*(FileHandle: HANDLE, Flags: UCHAR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileIoOverlappedRange*(FileHandle: HANDLE, OverlappedRangeStart: PUCHAR, Length: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadErrorMode*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadErrorMode*(dwNewMode: DWORD, lpOldMode: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Wow64GetThreadContext*(hThread: HANDLE, lpContext: PWOW64_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Wow64SetThreadContext*(hThread: HANDLE, lpContext: ptr WOW64_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Wow64GetThreadSelectorEntry*(hThread: HANDLE, dwSelector: DWORD, lpSelectorEntry: PWOW64_LDT_ENTRY): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Wow64SuspendThread*(hThread: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DebugSetProcessKillOnExit*(KillOnExit: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DebugBreakProcess*(Process: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PulseEvent*(hEvent: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitForMultipleObjects*(nCount: DWORD, lpHandles: ptr HANDLE, bWaitAll: WINBOOL, dwMilliseconds: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalDeleteAtom*(nAtom: ATOM): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitAtomTable*(nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteAtom*(nAtom: ATOM): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetHandleCount*(uNumber: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RequestDeviceWakeup*(hDevice: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CancelDeviceWakeupRequest*(hDevice: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDevicePowerState*(hDevice: HANDLE, pfOn: ptr WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetMessageWaitingIndicator*(hMsgIndicator: HANDLE, ulMsgCount: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileShortNameA*(hFile: HANDLE, lpShortName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileShortNameW*(hFile: HANDLE, lpShortName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LoadModule*(lpModuleName: LPCSTR, lpParameterBlock: LPVOID): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WinExec*(lpCmdLine: LPCSTR, uCmdShow: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ClearCommBreak*(hFile: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ClearCommError*(hFile: HANDLE, lpErrors: LPDWORD, lpStat: LPCOMSTAT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetupComm*(hFile: HANDLE, dwInQueue: DWORD, dwOutQueue: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EscapeCommFunction*(hFile: HANDLE, dwFunc: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCommConfig*(hCommDev: HANDLE, lpCC: LPCOMMCONFIG, lpdwSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCommMask*(hFile: HANDLE, lpEvtMask: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCommProperties*(hFile: HANDLE, lpCommProp: LPCOMMPROP): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCommModemStatus*(hFile: HANDLE, lpModemStat: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCommState*(hFile: HANDLE, lpDCB: LPDCB): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCommTimeouts*(hFile: HANDLE, lpCommTimeouts: LPCOMMTIMEOUTS): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PurgeComm*(hFile: HANDLE, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCommBreak*(hFile: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCommConfig*(hCommDev: HANDLE, lpCC: LPCOMMCONFIG, dwSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCommMask*(hFile: HANDLE, dwEvtMask: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCommState*(hFile: HANDLE, lpDCB: LPDCB): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCommTimeouts*(hFile: HANDLE, lpCommTimeouts: LPCOMMTIMEOUTS): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TransmitCommChar*(hFile: HANDLE, cChar: char): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitCommEvent*(hFile: HANDLE, lpEvtMask: LPDWORD, lpOverlapped: LPOVERLAPPED): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetTapePosition*(hDevice: HANDLE, dwPositionMethod: DWORD, dwPartition: DWORD, dwOffsetLow: DWORD, dwOffsetHigh: DWORD, bImmediate: WINBOOL): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTapePosition*(hDevice: HANDLE, dwPositionType: DWORD, lpdwPartition: LPDWORD, lpdwOffsetLow: LPDWORD, lpdwOffsetHigh: LPDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PrepareTape*(hDevice: HANDLE, dwOperation: DWORD, bImmediate: WINBOOL): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EraseTape*(hDevice: HANDLE, dwEraseType: DWORD, bImmediate: WINBOOL): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateTapePartition*(hDevice: HANDLE, dwPartitionMethod: DWORD, dwCount: DWORD, dwSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteTapemark*(hDevice: HANDLE, dwTapemarkType: DWORD, dwTapemarkCount: DWORD, bImmediate: WINBOOL): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTapeStatus*(hDevice: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTapeParameters*(hDevice: HANDLE, dwOperation: DWORD, lpdwSize: LPDWORD, lpTapeInformation: LPVOID): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetTapeParameters*(hDevice: HANDLE, dwOperation: DWORD, lpTapeInformation: LPVOID): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemDEPPolicy*(): DEP_SYSTEM_POLICY_TYPE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemRegistryQuota*(pdwQuotaAllowed: PDWORD, pdwQuotaUsed: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemTimes*(lpIdleTime: LPFILETIME, lpKernelTime: LPFILETIME, lpUserTime: LPFILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FileTimeToDosDateTime*(lpFileTime: ptr FILETIME, lpFatDate: LPWORD, lpFatTime: LPWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DosDateTimeToFileTime*(wFatDate: WORD, wFatTime: WORD, lpFileTime: LPFILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetSystemTimeAdjustment*(dwTimeAdjustment: DWORD, bTimeAdjustmentDisabled: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MulDiv*(nNumber: int32, nNumerator: int32, nDenominator: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FormatMessageA*(dwFlags: DWORD, lpSource: LPCVOID, dwMessageId: DWORD, dwLanguageId: DWORD, lpBuffer: LPSTR, nSize: DWORD, Arguments: ptr va_list): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FormatMessageW*(dwFlags: DWORD, lpSource: LPCVOID, dwMessageId: DWORD, dwLanguageId: DWORD, lpBuffer: LPWSTR, nSize: DWORD, Arguments: ptr va_list): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeInfo*(hNamedPipe: HANDLE, lpFlags: LPDWORD, lpOutBufferSize: LPDWORD, lpInBufferSize: LPDWORD, lpMaxInstances: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateMailslotA*(lpName: LPCSTR, nMaxMessageSize: DWORD, lReadTimeout: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateMailslotW*(lpName: LPCWSTR, nMaxMessageSize: DWORD, lReadTimeout: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetMailslotInfo*(hMailslot: HANDLE, lpMaxMessageSize: LPDWORD, lpNextSize: LPDWORD, lpMessageCount: LPDWORD, lpReadTimeout: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetMailslotInfo*(hMailslot: HANDLE, lReadTimeout: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EncryptFileA*(lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc EncryptFileW*(lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DecryptFileA*(lpFileName: LPCSTR, dwReserved: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DecryptFileW*(lpFileName: LPCWSTR, dwReserved: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc FileEncryptionStatusA*(lpFileName: LPCSTR, lpStatus: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc FileEncryptionStatusW*(lpFileName: LPCWSTR, lpStatus: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenEncryptedFileRawA*(lpFileName: LPCSTR, ulFlags: ULONG, pvContext: ptr PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenEncryptedFileRawW*(lpFileName: LPCWSTR, ulFlags: ULONG, pvContext: ptr PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ReadEncryptedFileRaw*(pfExportCallback: PFE_EXPORT_FUNC, pvCallbackContext: PVOID, pvContext: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc WriteEncryptedFileRaw*(pfImportCallback: PFE_IMPORT_FUNC, pvCallbackContext: PVOID, pvContext: PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CloseEncryptedFileRaw*(pvContext: PVOID): VOID {.winapi, stdcall, dynlib: "advapi32", importc.}
proc lstrcmpA*(lpString1: LPCSTR, lpString2: LPCSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcmpW*(lpString1: LPCWSTR, lpString2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcmpiA*(lpString1: LPCSTR, lpString2: LPCSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcmpiW*(lpString1: LPCWSTR, lpString2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcpynA*(lpString1: LPSTR, lpString2: LPCSTR, iMaxLength: int32): LPSTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcpynW*(lpString1: LPWSTR, lpString2: LPCWSTR, iMaxLength: int32): LPWSTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcpyA*(lpString1: LPSTR, lpString2: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcpyW*(lpString1: LPWSTR, lpString2: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcatA*(lpString1: LPSTR, lpString2: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrcatW*(lpString1: LPWSTR, lpString2: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrlenA*(lpString: LPCSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrlenW*(lpString: LPCWSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenFile*(lpFileName: LPCSTR, lpReOpenBuff: LPOFSTRUCT, uStyle: UINT): HFILE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsTextUnicode*(lpv: pointer, iSize: int32, lpiResult: LPINT): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BackupRead*(hFile: HANDLE, lpBuffer: LPBYTE, nNumberOfBytesToRead: DWORD, lpNumberOfBytesRead: LPDWORD, bAbort: WINBOOL, bProcessSecurity: WINBOOL, lpContext: ptr LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc BackupSeek*(hFile: HANDLE, dwLowBytesToSeek: DWORD, dwHighBytesToSeek: DWORD, lpdwLowByteSeeked: LPDWORD, lpdwHighByteSeeked: LPDWORD, lpContext: ptr LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc BackupWrite*(hFile: HANDLE, lpBuffer: LPBYTE, nNumberOfBytesToWrite: DWORD, lpNumberOfBytesWritten: LPDWORD, bAbort: WINBOOL, bProcessSecurity: WINBOOL, lpContext: ptr LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateSemaphoreW*(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES, lInitialCount: LONG, lMaximumCount: LONG, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LoadLibraryW*(lpLibFileName: LPCWSTR): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenMutexA*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateSemaphoreA*(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES, lInitialCount: LONG, lMaximumCount: LONG, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenSemaphoreA*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateWaitableTimerA*(lpTimerAttributes: LPSECURITY_ATTRIBUTES, bManualReset: WINBOOL, lpTimerName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateWaitableTimerW*(lpTimerAttributes: LPSECURITY_ATTRIBUTES, bManualReset: WINBOOL, lpTimerName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenWaitableTimerA*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpTimerName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileMappingA*(hFile: HANDLE, lpFileMappingAttributes: LPSECURITY_ATTRIBUTES, flProtect: DWORD, dwMaximumSizeHigh: DWORD, dwMaximumSizeLow: DWORD, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateSemaphoreExA*(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES, lInitialCount: LONG, lMaximumCount: LONG, lpName: LPCSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateWaitableTimerExA*(lpTimerAttributes: LPSECURITY_ATTRIBUTES, lpTimerName: LPCSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileMappingNumaA*(hFile: HANDLE, lpFileMappingAttributes: LPSECURITY_ATTRIBUTES, flProtect: DWORD, dwMaximumSizeHigh: DWORD, dwMaximumSizeLow: DWORD, lpName: LPCSTR, nndPreferred: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenFileMappingA*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLogicalDriveStringsA*(nBufferLength: DWORD, lpBuffer: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LoadLibraryA*(lpLibFileName: LPCSTR): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LoadPackagedLibrary*(lpwLibFileName: LPCWSTR, Reserved: DWORD): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryFullProcessImageNameA*(hProcess: HANDLE, dwFlags: DWORD, lpExeName: LPSTR, lpdwSize: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryFullProcessImageNameW*(hProcess: HANDLE, dwFlags: DWORD, lpExeName: LPWSTR, lpdwSize: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessShutdownParameters*(lpdwLevel: LPDWORD, lpdwFlags: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FatalAppExitA*(uAction: UINT, lpMessageText: LPCSTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FatalAppExitW*(uAction: UINT, lpMessageText: LPCWSTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetStartupInfoA*(lpStartupInfo: LPSTARTUPINFOA): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFirmwareEnvironmentVariableA*(lpName: LPCSTR, lpGuid: LPCSTR, pBuffer: PVOID, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFirmwareEnvironmentVariableW*(lpName: LPCWSTR, lpGuid: LPCWSTR, pBuffer: PVOID, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFirmwareEnvironmentVariableA*(lpName: LPCSTR, lpGuid: LPCSTR, pValue: PVOID, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFirmwareEnvironmentVariableW*(lpName: LPCWSTR, lpGuid: LPCWSTR, pValue: PVOID, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindResourceA*(hModule: HMODULE, lpName: LPCSTR, lpType: LPCSTR): HRSRC {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindResourceW*(hModule: HMODULE, lpName: LPCWSTR, lpType: LPCWSTR): HRSRC {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindResourceExA*(hModule: HMODULE, lpType: LPCSTR, lpName: LPCSTR, wLanguage: WORD): HRSRC {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceTypesA*(hModule: HMODULE, lpEnumFunc: ENUMRESTYPEPROCA, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceTypesW*(hModule: HMODULE, lpEnumFunc: ENUMRESTYPEPROCW, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceNamesA*(hModule: HMODULE, lpType: LPCSTR, lpEnumFunc: ENUMRESNAMEPROCA, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumResourceNamesW*(hModule: HMODULE, lpType: LPCWSTR, lpEnumFunc: ENUMRESNAMEPROCW, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc BeginUpdateResourceA*(pFileName: LPCSTR, bDeleteExistingResources: WINBOOL): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc BeginUpdateResourceW*(pFileName: LPCWSTR, bDeleteExistingResources: WINBOOL): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UpdateResourceA*(hUpdate: HANDLE, lpType: LPCSTR, lpName: LPCSTR, wLanguage: WORD, lpData: LPVOID, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UpdateResourceW*(hUpdate: HANDLE, lpType: LPCWSTR, lpName: LPCWSTR, wLanguage: WORD, lpData: LPVOID, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EndUpdateResourceA*(hUpdate: HANDLE, fDiscard: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EndUpdateResourceW*(hUpdate: HANDLE, fDiscard: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFirmwareEnvironmentVariableExA*(lpName: LPCSTR, lpGuid: LPCSTR, pBuffer: PVOID, nSize: DWORD, pdwAttribubutes: PDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFirmwareEnvironmentVariableExW*(lpName: LPCWSTR, lpGuid: LPCWSTR, pBuffer: PVOID, nSize: DWORD, pdwAttribubutes: PDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFirmwareEnvironmentVariableExA*(lpName: LPCSTR, lpGuid: LPCSTR, pValue: PVOID, nSize: DWORD, dwAttributes: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFirmwareEnvironmentVariableExW*(lpName: LPCWSTR, lpGuid: LPCWSTR, pValue: PVOID, nSize: DWORD, dwAttributes: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFirmwareType*(FirmwareType: PFIRMWARE_TYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsNativeVhdBoot*(NativeVhdBoot: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalAddAtomA*(lpString: LPCSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalAddAtomW*(lpString: LPCWSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalAddAtomExA*(lpString: LPCSTR, Flags: DWORD): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalAddAtomExW*(lpString: LPCWSTR, Flags: DWORD): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalFindAtomA*(lpString: LPCSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalFindAtomW*(lpString: LPCWSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalGetAtomNameA*(nAtom: ATOM, lpBuffer: LPSTR, nSize: int32): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GlobalGetAtomNameW*(nAtom: ATOM, lpBuffer: LPWSTR, nSize: int32): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddAtomA*(lpString: LPCSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddAtomW*(lpString: LPCWSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindAtomA*(lpString: LPCSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindAtomW*(lpString: LPCWSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetAtomNameA*(nAtom: ATOM, lpBuffer: LPSTR, nSize: int32): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetAtomNameW*(nAtom: ATOM, lpBuffer: LPWSTR, nSize: int32): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProfileIntA*(lpAppName: LPCSTR, lpKeyName: LPCSTR, nDefault: INT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProfileIntW*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, nDefault: INT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProfileStringA*(lpAppName: LPCSTR, lpKeyName: LPCSTR, lpDefault: LPCSTR, lpReturnedString: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProfileStringW*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, lpDefault: LPCWSTR, lpReturnedString: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteProfileStringA*(lpAppName: LPCSTR, lpKeyName: LPCSTR, lpString: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteProfileStringW*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, lpString: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProfileSectionA*(lpAppName: LPCSTR, lpReturnedString: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProfileSectionW*(lpAppName: LPCWSTR, lpReturnedString: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteProfileSectionA*(lpAppName: LPCSTR, lpString: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteProfileSectionW*(lpAppName: LPCWSTR, lpString: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileIntA*(lpAppName: LPCSTR, lpKeyName: LPCSTR, nDefault: INT, lpFileName: LPCSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileIntW*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, nDefault: INT, lpFileName: LPCWSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileStringA*(lpAppName: LPCSTR, lpKeyName: LPCSTR, lpDefault: LPCSTR, lpReturnedString: LPSTR, nSize: DWORD, lpFileName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileStringW*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, lpDefault: LPCWSTR, lpReturnedString: LPWSTR, nSize: DWORD, lpFileName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WritePrivateProfileStringA*(lpAppName: LPCSTR, lpKeyName: LPCSTR, lpString: LPCSTR, lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WritePrivateProfileStringW*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, lpString: LPCWSTR, lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileSectionA*(lpAppName: LPCSTR, lpReturnedString: LPSTR, nSize: DWORD, lpFileName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileSectionW*(lpAppName: LPCWSTR, lpReturnedString: LPWSTR, nSize: DWORD, lpFileName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WritePrivateProfileSectionA*(lpAppName: LPCSTR, lpString: LPCSTR, lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WritePrivateProfileSectionW*(lpAppName: LPCWSTR, lpString: LPCWSTR, lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileSectionNamesA*(lpszReturnBuffer: LPSTR, nSize: DWORD, lpFileName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileSectionNamesW*(lpszReturnBuffer: LPWSTR, nSize: DWORD, lpFileName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileStructA*(lpszSection: LPCSTR, lpszKey: LPCSTR, lpStruct: LPVOID, uSizeStruct: UINT, szFile: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetPrivateProfileStructW*(lpszSection: LPCWSTR, lpszKey: LPCWSTR, lpStruct: LPVOID, uSizeStruct: UINT, szFile: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WritePrivateProfileStructA*(lpszSection: LPCSTR, lpszKey: LPCSTR, lpStruct: LPVOID, uSizeStruct: UINT, szFile: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WritePrivateProfileStructW*(lpszSection: LPCWSTR, lpszKey: LPCWSTR, lpStruct: LPVOID, uSizeStruct: UINT, szFile: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTempPathA*(nBufferLength: DWORD, lpBuffer: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTempFileNameA*(lpPathName: LPCSTR, lpPrefixString: LPCSTR, uUnique: UINT, lpTempFileName: LPSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemWow64DirectoryA*(lpBuffer: LPSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemWow64DirectoryW*(lpBuffer: LPWSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Wow64EnableWow64FsRedirection*(Wow64FsEnableRedirection: BOOLEAN): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetDllDirectoryA*(lpPathName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetDllDirectoryW*(lpPathName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDllDirectoryA*(nBufferLength: DWORD, lpBuffer: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDllDirectoryW*(nBufferLength: DWORD, lpBuffer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetSearchPathMode*(Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateDirectoryExA*(lpTemplateDirectory: LPCSTR, lpNewDirectory: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateDirectoryExW*(lpTemplateDirectory: LPCWSTR, lpNewDirectory: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateDirectoryTransactedA*(lpTemplateDirectory: LPCSTR, lpNewDirectory: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateDirectoryTransactedW*(lpTemplateDirectory: LPCWSTR, lpNewDirectory: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RemoveDirectoryTransactedA*(lpPathName: LPCSTR, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RemoveDirectoryTransactedW*(lpPathName: LPCWSTR, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFullPathNameTransactedA*(lpFileName: LPCSTR, nBufferLength: DWORD, lpBuffer: LPSTR, lpFilePart: ptr LPSTR, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFullPathNameTransactedW*(lpFileName: LPCWSTR, nBufferLength: DWORD, lpBuffer: LPWSTR, lpFilePart: ptr LPWSTR, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DefineDosDeviceA*(dwFlags: DWORD, lpDeviceName: LPCSTR, lpTargetPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryDosDeviceA*(lpDeviceName: LPCSTR, lpTargetPath: LPSTR, ucchMax: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileTransactedA*(lpFileName: LPCSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwCreationDisposition: DWORD, dwFlagsAndAttributes: DWORD, hTemplateFile: HANDLE, hTransaction: HANDLE, pusMiniVersion: PUSHORT, lpExtendedParameter: PVOID): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateFileTransactedW*(lpFileName: LPCWSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwCreationDisposition: DWORD, dwFlagsAndAttributes: DWORD, hTemplateFile: HANDLE, hTransaction: HANDLE, pusMiniVersion: PUSHORT, lpExtendedParameter: PVOID): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReOpenFile*(hOriginalFile: HANDLE, dwDesiredAccess: DWORD, dwShareMode: DWORD, dwFlagsAndAttributes: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileAttributesTransactedA*(lpFileName: LPCSTR, dwFileAttributes: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileAttributesTransactedW*(lpFileName: LPCWSTR, dwFileAttributes: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileAttributesTransactedA*(lpFileName: LPCSTR, fInfoLevelId: GET_FILEEX_INFO_LEVELS, lpFileInformation: LPVOID, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileAttributesTransactedW*(lpFileName: LPCWSTR, fInfoLevelId: GET_FILEEX_INFO_LEVELS, lpFileInformation: LPVOID, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCompressedFileSizeA*(lpFileName: LPCSTR, lpFileSizeHigh: LPDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCompressedFileSizeW*(lpFileName: LPCWSTR, lpFileSizeHigh: LPDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCompressedFileSizeTransactedA*(lpFileName: LPCSTR, lpFileSizeHigh: LPDWORD, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCompressedFileSizeTransactedW*(lpFileName: LPCWSTR, lpFileSizeHigh: LPDWORD, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteFileTransactedA*(lpFileName: LPCSTR, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteFileTransactedW*(lpFileName: LPCWSTR, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CheckNameLegalDOS8Dot3A*(lpName: LPCSTR, lpOemName: LPSTR, OemNameSize: DWORD, pbNameContainsSpaces: PBOOL, pbNameLegal: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CheckNameLegalDOS8Dot3W*(lpName: LPCWSTR, lpOemName: LPSTR, OemNameSize: DWORD, pbNameContainsSpaces: PBOOL, pbNameLegal: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CopyFileA*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, bFailIfExists: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CopyFileW*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, bFailIfExists: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CopyFileExA*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, pbCancel: LPBOOL, dwCopyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CopyFileExW*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, pbCancel: LPBOOL, dwCopyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstFileTransactedA*(lpFileName: LPCSTR, fInfoLevelId: FINDEX_INFO_LEVELS, lpFindFileData: LPVOID, fSearchOp: FINDEX_SEARCH_OPS, lpSearchFilter: LPVOID, dwAdditionalFlags: DWORD, hTransaction: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstFileTransactedW*(lpFileName: LPCWSTR, fInfoLevelId: FINDEX_INFO_LEVELS, lpFindFileData: LPVOID, fSearchOp: FINDEX_SEARCH_OPS, lpSearchFilter: LPVOID, dwAdditionalFlags: DWORD, hTransaction: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CopyFileTransactedA*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, pbCancel: LPBOOL, dwCopyFlags: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CopyFileTransactedW*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, pbCancel: LPBOOL, dwCopyFlags: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CopyFile2*(pwszExistingFileName: PCWSTR, pwszNewFileName: PCWSTR, pExtendedParameters: ptr COPYFILE2_EXTENDED_PARAMETERS): HRESULT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MoveFileA*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MoveFileW*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MoveFileExA*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MoveFileExW*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MoveFileWithProgressA*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MoveFileWithProgressW*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MoveFileTransactedA*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, dwFlags: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MoveFileTransactedW*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, dwFlags: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReplaceFileA*(lpReplacedFileName: LPCSTR, lpReplacementFileName: LPCSTR, lpBackupFileName: LPCSTR, dwReplaceFlags: DWORD, lpExclude: LPVOID, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReplaceFileW*(lpReplacedFileName: LPCWSTR, lpReplacementFileName: LPCWSTR, lpBackupFileName: LPCWSTR, dwReplaceFlags: DWORD, lpExclude: LPVOID, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateHardLinkA*(lpFileName: LPCSTR, lpExistingFileName: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateHardLinkW*(lpFileName: LPCWSTR, lpExistingFileName: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateHardLinkTransactedA*(lpFileName: LPCSTR, lpExistingFileName: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateHardLinkTransactedW*(lpFileName: LPCWSTR, lpExistingFileName: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstStreamW*(lpFileName: LPCWSTR, InfoLevel: STREAM_INFO_LEVELS, lpFindStreamData: LPVOID, dwFlags: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextStreamW*(hFindStream: HANDLE, lpFindStreamData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstStreamTransactedW*(lpFileName: LPCWSTR, InfoLevel: STREAM_INFO_LEVELS, lpFindStreamData: LPVOID, dwFlags: DWORD, hTransaction: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstFileNameW*(lpFileName: LPCWSTR, dwFlags: DWORD, StringLength: LPDWORD, LinkName: PWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextFileNameW*(hFindStream: HANDLE, StringLength: LPDWORD, LinkName: PWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstFileNameTransactedW*(lpFileName: LPCWSTR, dwFlags: DWORD, StringLength: LPDWORD, LinkName: PWSTR, hTransaction: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeClientComputerNameA*(Pipe: HANDLE, ClientComputerName: LPSTR, ClientComputerNameLength: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeClientProcessId*(Pipe: HANDLE, ClientProcessId: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeClientSessionId*(Pipe: HANDLE, ClientSessionId: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeServerProcessId*(Pipe: HANDLE, ServerProcessId: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeServerSessionId*(Pipe: HANDLE, ServerSessionId: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileBandwidthReservation*(hFile: HANDLE, nPeriodMilliseconds: DWORD, nBytesPerPeriod: DWORD, bDiscardable: WINBOOL, lpTransferSize: LPDWORD, lpNumOutstandingRequests: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileBandwidthReservation*(hFile: HANDLE, lpPeriodMilliseconds: LPDWORD, lpBytesPerPeriod: LPDWORD, pDiscardable: LPBOOL, lpTransferSize: LPDWORD, lpNumOutstandingRequests: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateNamedPipeA*(lpName: LPCSTR, dwOpenMode: DWORD, dwPipeMode: DWORD, nMaxInstances: DWORD, nOutBufferSize: DWORD, nInBufferSize: DWORD, nDefaultTimeOut: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeHandleStateA*(hNamedPipe: HANDLE, lpState: LPDWORD, lpCurInstances: LPDWORD, lpMaxCollectionCount: LPDWORD, lpCollectDataTimeout: LPDWORD, lpUserName: LPSTR, nMaxUserNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNamedPipeHandleStateW*(hNamedPipe: HANDLE, lpState: LPDWORD, lpCurInstances: LPDWORD, lpMaxCollectionCount: LPDWORD, lpCollectDataTimeout: LPDWORD, lpUserName: LPWSTR, nMaxUserNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CallNamedPipeA*(lpNamedPipeName: LPCSTR, lpInBuffer: LPVOID, nInBufferSize: DWORD, lpOutBuffer: LPVOID, nOutBufferSize: DWORD, lpBytesRead: LPDWORD, nTimeOut: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CallNamedPipeW*(lpNamedPipeName: LPCWSTR, lpInBuffer: LPVOID, nInBufferSize: DWORD, lpOutBuffer: LPVOID, nOutBufferSize: DWORD, lpBytesRead: LPDWORD, nTimeOut: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WaitNamedPipeA*(lpNamedPipeName: LPCSTR, nTimeOut: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetVolumeLabelA*(lpRootPathName: LPCSTR, lpVolumeName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetVolumeLabelW*(lpRootPathName: LPCWSTR, lpVolumeName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileApisToOEM*(): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetFileApisToANSI*(): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AreFileApisANSI*(): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumeInformationA*(lpRootPathName: LPCSTR, lpVolumeNameBuffer: LPSTR, nVolumeNameSize: DWORD, lpVolumeSerialNumber: LPDWORD, lpMaximumComponentLength: LPDWORD, lpFileSystemFlags: LPDWORD, lpFileSystemNameBuffer: LPSTR, nFileSystemNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ClearEventLogA*(hEventLog: HANDLE, lpBackupFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ClearEventLogW*(hEventLog: HANDLE, lpBackupFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BackupEventLogA*(hEventLog: HANDLE, lpBackupFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BackupEventLogW*(hEventLog: HANDLE, lpBackupFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CloseEventLog*(hEventLog: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc DeregisterEventSource*(hEventLog: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc NotifyChangeEventLog*(hEventLog: HANDLE, hEvent: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetNumberOfEventLogRecords*(hEventLog: HANDLE, NumberOfRecords: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetOldestEventLogRecord*(hEventLog: HANDLE, OldestRecord: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenEventLogA*(lpUNCServerName: LPCSTR, lpSourceName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenEventLogW*(lpUNCServerName: LPCWSTR, lpSourceName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegisterEventSourceA*(lpUNCServerName: LPCSTR, lpSourceName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegisterEventSourceW*(lpUNCServerName: LPCWSTR, lpSourceName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenBackupEventLogA*(lpUNCServerName: LPCSTR, lpFileName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OpenBackupEventLogW*(lpUNCServerName: LPCWSTR, lpFileName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ReadEventLogA*(hEventLog: HANDLE, dwReadFlags: DWORD, dwRecordOffset: DWORD, lpBuffer: LPVOID, nNumberOfBytesToRead: DWORD, pnBytesRead: ptr DWORD, pnMinNumberOfBytesNeeded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ReadEventLogW*(hEventLog: HANDLE, dwReadFlags: DWORD, dwRecordOffset: DWORD, lpBuffer: LPVOID, nNumberOfBytesToRead: DWORD, pnBytesRead: ptr DWORD, pnMinNumberOfBytesNeeded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ReportEventA*(hEventLog: HANDLE, wType: WORD, wCategory: WORD, dwEventID: DWORD, lpUserSid: PSID, wNumStrings: WORD, dwDataSize: DWORD, lpStrings: ptr LPCSTR, lpRawData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ReportEventW*(hEventLog: HANDLE, wType: WORD, wCategory: WORD, dwEventID: DWORD, lpUserSid: PSID, wNumStrings: WORD, dwDataSize: DWORD, lpStrings: ptr LPCWSTR, lpRawData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetNamedPipeClientComputerName*(Pipe: HANDLE, ClientComputerName: LPSTR, ClientComputerNameLength: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetNamedPipeClientComputerNameA".}
proc GetEventLogInformation*(hEventLog: HANDLE, dwInfoLevel: DWORD, lpBuffer: LPVOID, cbBufSize: DWORD, pcbBytesNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OperationStart*(OperationStartParams: ptr OPERATION_START_PARAMETERS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc OperationEnd*(OperationEndParams: ptr OPERATION_END_PARAMETERS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckAndAuditAlarmA*(SubsystemName: LPCSTR, HandleId: LPVOID, ObjectTypeName: LPSTR, ObjectName: LPSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, DesiredAccess: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatus: LPBOOL, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckByTypeAndAuditAlarmA*(SubsystemName: LPCSTR, HandleId: LPVOID, ObjectTypeName: LPCSTR, ObjectName: LPCSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatus: LPBOOL, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckByTypeResultListAndAuditAlarmA*(SubsystemName: LPCSTR, HandleId: LPVOID, ObjectTypeName: LPCSTR, ObjectName: LPCSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatusList: LPDWORD, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc AccessCheckByTypeResultListAndAuditAlarmByHandleA*(SubsystemName: LPCSTR, HandleId: LPVOID, ClientToken: HANDLE, ObjectTypeName: LPCSTR, ObjectName: LPCSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatusList: LPDWORD, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ObjectOpenAuditAlarmA*(SubsystemName: LPCSTR, HandleId: LPVOID, ObjectTypeName: LPSTR, ObjectName: LPSTR, pSecurityDescriptor: PSECURITY_DESCRIPTOR, ClientToken: HANDLE, DesiredAccess: DWORD, GrantedAccess: DWORD, Privileges: PPRIVILEGE_SET, ObjectCreation: WINBOOL, AccessGranted: WINBOOL, GenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ObjectPrivilegeAuditAlarmA*(SubsystemName: LPCSTR, HandleId: LPVOID, ClientToken: HANDLE, DesiredAccess: DWORD, Privileges: PPRIVILEGE_SET, AccessGranted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ObjectCloseAuditAlarmA*(SubsystemName: LPCSTR, HandleId: LPVOID, GenerateOnClose: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ObjectDeleteAuditAlarmA*(SubsystemName: LPCSTR, HandleId: LPVOID, GenerateOnClose: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc PrivilegedServiceAuditAlarmA*(SubsystemName: LPCSTR, ServiceName: LPCSTR, ClientToken: HANDLE, Privileges: PPRIVILEGE_SET, AccessGranted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SetFileSecurityA*(lpFileName: LPCSTR, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetFileSecurityA*(lpFileName: LPCSTR, RequestedInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc ReadDirectoryChangesW*(hDirectory: HANDLE, lpBuffer: LPVOID, nBufferLength: DWORD, bWatchSubtree: WINBOOL, dwNotifyFilter: DWORD, lpBytesReturned: LPDWORD, lpOverlapped: LPOVERLAPPED, lpCompletionRoutine: LPOVERLAPPED_COMPLETION_ROUTINE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsBadReadPtr*(lp: pointer, ucb: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsBadWritePtr*(lp: LPVOID, ucb: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsBadHugeReadPtr*(lp: pointer, ucb: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsBadHugeWritePtr*(lp: LPVOID, ucb: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsBadCodePtr*(lpfn: FARPROC): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsBadStringPtrA*(lpsz: LPCSTR, ucchMax: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsBadStringPtrW*(lpsz: LPCWSTR, ucchMax: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MapViewOfFileExNuma*(hFileMappingObject: HANDLE, dwDesiredAccess: DWORD, dwFileOffsetHigh: DWORD, dwFileOffsetLow: DWORD, dwNumberOfBytesToMap: SIZE_T, lpBaseAddress: LPVOID, nndPreferred: DWORD): LPVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddConditionalAce*(pAcl: PACL, dwAceRevision: DWORD, AceFlags: DWORD, AceType: UCHAR, AccessMask: DWORD, pSid: PSID, ConditionStr: PWCHAR, ReturnLength: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupAccountSidA*(lpSystemName: LPCSTR, Sid: PSID, Name: LPSTR, cchName: LPDWORD, ReferencedDomainName: LPSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupAccountSidW*(lpSystemName: LPCWSTR, Sid: PSID, Name: LPWSTR, cchName: LPDWORD, ReferencedDomainName: LPWSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupAccountNameA*(lpSystemName: LPCSTR, lpAccountName: LPCSTR, Sid: PSID, cbSid: LPDWORD, ReferencedDomainName: LPSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupAccountNameW*(lpSystemName: LPCWSTR, lpAccountName: LPCWSTR, Sid: PSID, cbSid: LPDWORD, ReferencedDomainName: LPWSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupPrivilegeValueA*(lpSystemName: LPCSTR, lpName: LPCSTR, lpLuid: PLUID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupPrivilegeValueW*(lpSystemName: LPCWSTR, lpName: LPCWSTR, lpLuid: PLUID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupPrivilegeNameA*(lpSystemName: LPCSTR, lpLuid: PLUID, lpName: LPSTR, cchName: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupPrivilegeNameW*(lpSystemName: LPCWSTR, lpLuid: PLUID, lpName: LPWSTR, cchName: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupPrivilegeDisplayNameA*(lpSystemName: LPCSTR, lpName: LPCSTR, lpDisplayName: LPSTR, cchDisplayName: LPDWORD, lpLanguageId: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LookupPrivilegeDisplayNameW*(lpSystemName: LPCWSTR, lpName: LPCWSTR, lpDisplayName: LPWSTR, cchDisplayName: LPDWORD, lpLanguageId: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc BuildCommDCBA*(lpDef: LPCSTR, lpDCB: LPDCB): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc BuildCommDCBW*(lpDef: LPCWSTR, lpDCB: LPDCB): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc BuildCommDCBAndTimeoutsA*(lpDef: LPCSTR, lpDCB: LPDCB, lpCommTimeouts: LPCOMMTIMEOUTS): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc BuildCommDCBAndTimeoutsW*(lpDef: LPCWSTR, lpDCB: LPDCB, lpCommTimeouts: LPCOMMTIMEOUTS): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CommConfigDialogA*(lpszName: LPCSTR, hWnd: HWND, lpCC: LPCOMMCONFIG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CommConfigDialogW*(lpszName: LPCWSTR, hWnd: HWND, lpCC: LPCOMMCONFIG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDefaultCommConfigA*(lpszName: LPCSTR, lpCC: LPCOMMCONFIG, lpdwSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDefaultCommConfigW*(lpszName: LPCWSTR, lpCC: LPCOMMCONFIG, lpdwSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetDefaultCommConfigA*(lpszName: LPCSTR, lpCC: LPCOMMCONFIG, dwSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetDefaultCommConfigW*(lpszName: LPCWSTR, lpCC: LPCOMMCONFIG, dwSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetComputerNameA*(lpBuffer: LPSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetComputerNameW*(lpBuffer: LPWSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetComputerNameA*(lpComputerName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetComputerNameW*(lpComputerName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetComputerNameExA*(NameType: COMPUTER_NAME_FORMAT, lpBuffer: LPCTSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DnsHostnameToComputerNameA*(Hostname: LPCSTR, ComputerName: LPSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DnsHostnameToComputerNameW*(Hostname: LPCWSTR, ComputerName: LPWSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetUserNameA*(lpBuffer: LPSTR, pcbBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetUserNameW*(lpBuffer: LPWSTR, pcbBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LogonUserA*(lpszUsername: LPCSTR, lpszDomain: LPCSTR, lpszPassword: LPCSTR, dwLogonType: DWORD, dwLogonProvider: DWORD, phToken: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LogonUserW*(lpszUsername: LPCWSTR, lpszDomain: LPCWSTR, lpszPassword: LPCWSTR, dwLogonType: DWORD, dwLogonProvider: DWORD, phToken: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LogonUserExA*(lpszUsername: LPCSTR, lpszDomain: LPCSTR, lpszPassword: LPCSTR, dwLogonType: DWORD, dwLogonProvider: DWORD, phToken: PHANDLE, ppLogonSid: ptr PSID, ppProfileBuffer: ptr PVOID, pdwProfileLength: LPDWORD, pQuotaLimits: PQUOTA_LIMITS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc LogonUserExW*(lpszUsername: LPCWSTR, lpszDomain: LPCWSTR, lpszPassword: LPCWSTR, dwLogonType: DWORD, dwLogonProvider: DWORD, phToken: PHANDLE, ppLogonSid: ptr PSID, ppProfileBuffer: ptr PVOID, pdwProfileLength: LPDWORD, pQuotaLimits: PQUOTA_LIMITS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreateProcessAsUserA*(hToken: HANDLE, lpApplicationName: LPCSTR, lpCommandLine: LPSTR, lpProcessAttributes: LPSECURITY_ATTRIBUTES, lpThreadAttributes: LPSECURITY_ATTRIBUTES, bInheritHandles: WINBOOL, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCSTR, lpStartupInfo: LPSTARTUPINFOA, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreateProcessWithLogonW*(lpUsername: LPCWSTR, lpDomain: LPCWSTR, lpPassword: LPCWSTR, dwLogonFlags: DWORD, lpApplicationName: LPCWSTR, lpCommandLine: LPWSTR, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCWSTR, lpStartupInfo: LPSTARTUPINFOW, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc CreateProcessWithTokenW*(hToken: HANDLE, dwLogonFlags: DWORD, lpApplicationName: LPCWSTR, lpCommandLine: LPWSTR, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCWSTR, lpStartupInfo: LPSTARTUPINFOW, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc IsTokenUntrusted*(TokenHandle: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc RegisterWaitForSingleObject*(phNewWaitObject: PHANDLE, hObject: HANDLE, Callback: WAITORTIMERCALLBACK, Context: PVOID, dwMilliseconds: ULONG, dwFlags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnregisterWait*(WaitHandle: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc BindIoCompletionCallback*(FileHandle: HANDLE, Function: LPOVERLAPPED_COMPLETION_ROUTINE, Flags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetTimerQueueTimer*(TimerQueue: HANDLE, Callback: WAITORTIMERCALLBACK, Parameter: PVOID, DueTime: DWORD, Period: DWORD, PreferIo: WINBOOL): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CancelTimerQueueTimer*(TimerQueue: HANDLE, Timer: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteTimerQueue*(TimerQueue: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreatePrivateNamespaceA*(lpPrivateNamespaceAttributes: LPSECURITY_ATTRIBUTES, lpBoundaryDescriptor: LPVOID, lpAliasPrefix: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenPrivateNamespaceA*(lpBoundaryDescriptor: LPVOID, lpAliasPrefix: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateBoundaryDescriptorA*(Name: LPCSTR, Flags: ULONG): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddIntegrityLabelToBoundaryDescriptor*(BoundaryDescriptor: ptr HANDLE, IntegrityLabel: PSID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentHwProfileA*(lpHwProfileInfo: LPHW_PROFILE_INFOA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetCurrentHwProfileW*(lpHwProfileInfo: LPHW_PROFILE_INFOW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc VerifyVersionInfoA*(lpVersionInformation: LPOSVERSIONINFOEXA, dwTypeMask: DWORD, dwlConditionMask: DWORDLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VerifyVersionInfoW*(lpVersionInformation: LPOSVERSIONINFOEXW, dwTypeMask: DWORD, dwlConditionMask: DWORDLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SystemTimeToTzSpecificLocalTime*(lpTimeZoneInformation: ptr TIME_ZONE_INFORMATION, lpUniversalTime: ptr SYSTEMTIME, lpLocalTime: LPSYSTEMTIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TzSpecificLocalTimeToSystemTime*(lpTimeZoneInformation: ptr TIME_ZONE_INFORMATION, lpLocalTime: ptr SYSTEMTIME, lpUniversalTime: LPSYSTEMTIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FileTimeToSystemTime*(lpFileTime: ptr FILETIME, lpSystemTime: LPSYSTEMTIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SystemTimeToFileTime*(lpSystemTime: ptr SYSTEMTIME, lpFileTime: LPFILETIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTimeZoneInformation*(lpTimeZoneInformation: LPTIME_ZONE_INFORMATION): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDynamicTimeZoneInformation*(pTimeZoneInformation: PDYNAMIC_TIME_ZONE_INFORMATION): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTimeZoneInformationForYear*(wYear: USHORT, pdtzi: PDYNAMIC_TIME_ZONE_INFORMATION, ptzi: LPTIME_ZONE_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumDynamicTimeZoneInformation*(dwIndex: DWORD, lpTimeZoneInformation: PDYNAMIC_TIME_ZONE_INFORMATION): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc GetDynamicTimeZoneInformationEffectiveYears*(lpTimeZoneInformation: PDYNAMIC_TIME_ZONE_INFORMATION, FirstYear: LPDWORD, LastYear: LPDWORD): DWORD {.winapi, stdcall, dynlib: "advapi32", importc.}
proc SystemTimeToTzSpecificLocalTimeEx*(lpTimeZoneInformation: ptr DYNAMIC_TIME_ZONE_INFORMATION, lpUniversalTime: ptr SYSTEMTIME, lpLocalTime: LPSYSTEMTIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TzSpecificLocalTimeToSystemTimeEx*(lpTimeZoneInformation: ptr DYNAMIC_TIME_ZONE_INFORMATION, lpLocalTime: ptr SYSTEMTIME, lpUniversalTime: LPSYSTEMTIME): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetTimeZoneInformation*(lpTimeZoneInformation: ptr TIME_ZONE_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetDynamicTimeZoneInformation*(lpTimeZoneInformation: ptr DYNAMIC_TIME_ZONE_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemPowerStatus*(lpSystemPowerStatus: LPSYSTEM_POWER_STATUS): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetSystemPowerState*(fSuspend: WINBOOL, fForce: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RegisterBadMemoryNotification*(Callback: PBAD_MEMORY_CALLBACK_ROUTINE): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnregisterBadMemoryNotification*(RegistrationHandle: PVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetMemoryErrorHandlingCapabilities*(Capabilities: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AllocateUserPhysicalPages*(hProcess: HANDLE, NumberOfPages: PULONG_PTR, PageArray: PULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FreeUserPhysicalPages*(hProcess: HANDLE, NumberOfPages: PULONG_PTR, PageArray: PULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MapUserPhysicalPages*(VirtualAddress: PVOID, NumberOfPages: ULONG_PTR, PageArray: PULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MapUserPhysicalPagesScatter*(VirtualAddresses: ptr PVOID, NumberOfPages: ULONG_PTR, PageArray: PULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateJobObjectA*(lpJobAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateJobObjectW*(lpJobAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenJobObjectA*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenJobObjectW*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AssignProcessToJobObject*(hJob: HANDLE, hProcess: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc TerminateJobObject*(hJob: HANDLE, uExitCode: UINT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryInformationJobObject*(hJob: HANDLE, JobObjectInformationClass: JOBOBJECTINFOCLASS, lpJobObjectInformation: LPVOID, cbJobObjectInformationLength: DWORD, lpReturnLength: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetInformationJobObject*(hJob: HANDLE, JobObjectInformationClass: JOBOBJECTINFOCLASS, lpJobObjectInformation: LPVOID, cbJobObjectInformationLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateJobSet*(NumJob: ULONG, UserJobSet: PJOB_SET_ARRAY, Flags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstVolumeA*(lpszVolumeName: LPSTR, cchBufferLength: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextVolumeA*(hFindVolume: HANDLE, lpszVolumeName: LPSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstVolumeMountPointA*(lpszRootPathName: LPCSTR, lpszVolumeMountPoint: LPSTR, cchBufferLength: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindFirstVolumeMountPointW*(lpszRootPathName: LPCWSTR, lpszVolumeMountPoint: LPWSTR, cchBufferLength: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextVolumeMountPointA*(hFindVolumeMountPoint: HANDLE, lpszVolumeMountPoint: LPSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNextVolumeMountPointW*(hFindVolumeMountPoint: HANDLE, lpszVolumeMountPoint: LPWSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindVolumeMountPointClose*(hFindVolumeMountPoint: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetVolumeMountPointA*(lpszVolumeMountPoint: LPCSTR, lpszVolumeName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetVolumeMountPointW*(lpszVolumeMountPoint: LPCWSTR, lpszVolumeName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeleteVolumeMountPointA*(lpszVolumeMountPoint: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumeNameForVolumeMountPointA*(lpszVolumeMountPoint: LPCSTR, lpszVolumeName: LPSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumePathNameA*(lpszFileName: LPCSTR, lpszVolumePathName: LPSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetVolumePathNamesForVolumeNameA*(lpszVolumeName: LPCSTR, lpszVolumePathNames: LPCH, cchBufferLength: DWORD, lpcchReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AllocateUserPhysicalPagesNuma*(hProcess: HANDLE, NumberOfPages: PULONG_PTR, PageArray: PULONG_PTR, nndPreferred: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateActCtxA*(pActCtx: PCACTCTXA): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateActCtxW*(pActCtx: PCACTCTXW): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddRefActCtx*(hActCtx: HANDLE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReleaseActCtx*(hActCtx: HANDLE): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ZombifyActCtx*(hActCtx: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ActivateActCtx*(hActCtx: HANDLE, lpCookie: ptr ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DeactivateActCtx*(dwFlags: DWORD, ulCookie: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentActCtx*(lphActCtx: ptr HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindActCtxSectionStringA*(dwFlags: DWORD, lpExtensionGuid: ptr GUID, ulSectionId: ULONG, lpStringToFind: LPCSTR, ReturnedData: PACTCTX_SECTION_KEYED_DATA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindActCtxSectionStringW*(dwFlags: DWORD, lpExtensionGuid: ptr GUID, ulSectionId: ULONG, lpStringToFind: LPCWSTR, ReturnedData: PACTCTX_SECTION_KEYED_DATA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindActCtxSectionGuid*(dwFlags: DWORD, lpExtensionGuid: ptr GUID, ulSectionId: ULONG, lpGuidToFind: ptr GUID, ReturnedData: PACTCTX_SECTION_KEYED_DATA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryActCtxW*(dwFlags: DWORD, hActCtx: HANDLE, pvSubInstance: PVOID, ulInfoClass: ULONG, pvBuffer: PVOID, cbBuffer: SIZE_T, pcbWrittenOrRequired: ptr SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WTSGetActiveConsoleSessionId*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaProcessorNode*(Processor: UCHAR, NodeNumber: PUCHAR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaNodeProcessorMask*(Node: UCHAR, ProcessorMask: PULONGLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaAvailableMemoryNode*(Node: UCHAR, AvailableBytes: PULONGLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaProximityNode*(ProximityId: ULONG, NodeNumber: PUCHAR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetActiveProcessorGroupCount*(): WORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetMaximumProcessorGroupCount*(): WORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetActiveProcessorCount*(GroupNumber: WORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetMaximumProcessorCount*(GroupNumber: WORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaNodeNumberFromHandle*(hFile: HANDLE, NodeNumber: PUSHORT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaProcessorNodeEx*(Processor: PPROCESSOR_NUMBER, NodeNumber: PUSHORT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaAvailableMemoryNodeEx*(Node: USHORT, AvailableBytes: PULONGLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumaProximityNodeEx*(ProximityId: ULONG, NodeNumber: PUSHORT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RegisterApplicationRecoveryCallback*(pRecoveyCallback: APPLICATION_RECOVERY_CALLBACK, pvParameter: PVOID, dwPingInterval: DWORD, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnregisterApplicationRecoveryCallback*(): HRESULT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RegisterApplicationRestart*(pwzCommandline: PCWSTR, dwFlags: DWORD): HRESULT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc UnregisterApplicationRestart*(): HRESULT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetApplicationRecoveryCallback*(hProcess: HANDLE, pRecoveryCallback: ptr APPLICATION_RECOVERY_CALLBACK, ppvParameter: ptr PVOID, pdwPingInterval: PDWORD, pdwFlags: PDWORD): HRESULT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetApplicationRestartSettings*(hProcess: HANDLE, pwzCommandline: PWSTR, pcchSize: PDWORD, pdwFlags: PDWORD): HRESULT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ApplicationRecoveryInProgress*(pbCancelled: PBOOL): HRESULT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ApplicationRecoveryFinished*(bSuccess: WINBOOL): VOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileInformationByHandleEx*(hFile: HANDLE, FileInformationClass: FILE_INFO_BY_HANDLE_CLASS, lpFileInformation: LPVOID, dwBufferSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc OpenFileById*(hVolumeHint: HANDLE, lpFileId: LPFILE_ID_DESCRIPTOR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwFlagsAndAttributes: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateSymbolicLinkA*(lpSymlinkFileName: LPCSTR, lpTargetFileName: LPCSTR, dwFlags: DWORD): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateSymbolicLinkW*(lpSymlinkFileName: LPCWSTR, lpTargetFileName: LPCWSTR, dwFlags: DWORD): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateSymbolicLinkTransactedA*(lpSymlinkFileName: LPCSTR, lpTargetFileName: LPCSTR, dwFlags: DWORD, hTransaction: HANDLE): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateSymbolicLinkTransactedW*(lpSymlinkFileName: LPCWSTR, lpTargetFileName: LPCWSTR, dwFlags: DWORD, hTransaction: HANDLE): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryActCtxSettingsW*(dwFlags: DWORD, hActCtx: HANDLE, settingsNameSpace: PCWSTR, settingName: PCWSTR, pvBuffer: PWSTR, dwBuffer: SIZE_T, pdwWrittenOrRequired: ptr SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReplacePartitionUnit*(TargetPartition: PWSTR, SparePartition: PWSTR, Flags: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddSecureMemoryCacheCallback*(pfnCallBack: PSECURE_MEMORY_CACHE_CALLBACK): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RemoveSecureMemoryCacheCallback*(pfnCallBack: PSECURE_MEMORY_CACHE_CALLBACK): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CopyContext*(Destination: PCONTEXT, ContextFlags: DWORD, Source: PCONTEXT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc InitializeContext*(Buffer: PVOID, ContextFlags: DWORD, Context: ptr PCONTEXT, ContextLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnableThreadProfiling*(ThreadHandle: HANDLE, Flags: DWORD, HardwareCounters: DWORD64, PerformanceDataHandle: ptr HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc DisableThreadProfiling*(PerformanceDataHandle: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc QueryThreadProfiling*(ThreadHandle: HANDLE, Enabled: PBOOLEAN): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadThreadProfilingData*(PerformanceDataHandle: HANDLE, Flags: DWORD, PerformanceData: PPERFORMANCE_DATA): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentTime*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetTickCount".}
proc LockSegment*(hMem: HGLOBAL): VOID {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalFix".}
proc UnlockSegment*(hMem: HGLOBAL): VOID {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalUnfix".}
proc FreeModule*(hLibModule: HMODULE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FreeLibrary".}
proc InterlockedPushListSList*(ListHead: PSLIST_HEADER, List: PSLIST_ENTRY, ListEnd: PSLIST_ENTRY, Count: ULONG): PSLIST_ENTRY {.winapi, stdcall, dynlib: "kernel32", importc: "InterlockedPushListSListEx".}
template HasOverlappedIoCompleted*(lpOverlapped: LPOVERLAPPED): bool = lpOverlapped.Internal != STATUS_PENDING
template RtlSecureZeroMemory*(Destination: PVOID, Length: SIZE_T) = zeroMem(Destination, Length)
template SecureZeroMemory*(Destination: PVOID, Length: SIZE_T) = zeroMem(Destination, Length)
template RtlZeroMemory*(Destination: PVOID, Length: SIZE_T) = zeroMem(Destination, Length)
template ZeroMemory*(Destination: PVOID, Length: SIZE_T) = zeroMem(Destination, Length)
template RtlCopyMemory*(Destination: PVOID, Source: PVOID, Length: SIZE_T) = copyMem(Destination, Source, Length)
template CopyMemory*(Destination: PVOID, Source: PVOID, Length: SIZE_T) = copyMem(Destination, Source, Length)
template MAKEINTATOM*(i: untyped): untyped = cast[LPTSTR](i and 0xffff)
proc LocalDiscard*(h: HLOCAL): HLOCAL {.winapi, inline.} = LocalReAlloc(h, 0, LMEM_MOVEABLE)
proc GlobalDiscard*(h: HGLOBAL): HGLOBAL {.winapi, inline.} = GlobalReAlloc(h, 0, GMEM_MOVEABLE)
when winimAnsi:
  proc LookupAccountName*(lpSystemName: LPCSTR, lpAccountName: LPCSTR, Sid: PSID, cbSid: LPDWORD, ReferencedDomainName: LPSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupAccountNameA".}
proc LookupAccountNameLocalA*(lpAccountName: LPCSTR, Sid: PSID, cbSid: LPDWORD, ReferencedDomainName: LPSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, inline.} = LookupAccountNameA(nil, lpAccountName, Sid, cbSid, ReferencedDomainName, cchReferencedDomainName, peUse)
when winimUnicode:
  proc LookupAccountName*(lpSystemName: LPCWSTR, lpAccountName: LPCWSTR, Sid: PSID, cbSid: LPDWORD, ReferencedDomainName: LPWSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupAccountNameW".}
proc LookupAccountNameLocalW*(lpAccountName: LPCWSTR, Sid: PSID, cbSid: LPDWORD, ReferencedDomainName: LPWSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, inline.} = LookupAccountNameW(nil, lpAccountName, Sid, cbSid, ReferencedDomainName, cchReferencedDomainName, peUse)
when winimAnsi:
  proc LookupAccountSid*(lpSystemName: LPCSTR, Sid: PSID, Name: LPSTR, cchName: LPDWORD, ReferencedDomainName: LPSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupAccountSidA".}
proc LookupAccountSidLocalA*(Sid: PSID, Name: LPSTR, cchName: LPDWORD, ReferencedDomainName: LPSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, inline.} = LookupAccountSidA(nil, Sid, Name, cchName, ReferencedDomainName, cchReferencedDomainName, peUse)
when winimUnicode:
  proc LookupAccountSid*(lpSystemName: LPCWSTR, Sid: PSID, Name: LPWSTR, cchName: LPDWORD, ReferencedDomainName: LPWSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupAccountSidW".}
proc LookupAccountSidLocalW*(Sid: PSID, Name: LPWSTR, cchName: LPDWORD, ReferencedDomainName: LPWSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, inline.} = LookupAccountSidW(nil, Sid, Name, cchName, ReferencedDomainName, cchReferencedDomainName, peUse)
proc InterlockedOr*(Destination: ptr LONG, Value: LONG): LONG {.importc: "InterlockedOr", header: "<windows.h>".}
proc InterlockedOr8*(Destination: ptr byte, Value: byte): byte {.importc: "InterlockedOr8", header: "<windows.h>".}
proc InterlockedOr16*(Destination: ptr SHORT, Value: SHORT): SHORT {.importc: "InterlockedOr16", header: "<windows.h>".}
proc InterlockedOr64*(Destination: ptr LONGLONG, Value: LONGLONG): LONGLONG {.importc: "InterlockedOr64", header: "<windows.h>".}
proc InterlockedXor*(Destination: ptr LONG, Value: LONG): LONG {.importc: "InterlockedXor", header: "<windows.h>".}
proc InterlockedXor8*(Destination: ptr byte, Value: byte): byte {.importc: "InterlockedXor8", header: "<windows.h>".}
proc InterlockedXor16*(Destination: ptr SHORT, Value: SHORT): SHORT {.importc: "InterlockedXor16", header: "<windows.h>".}
proc InterlockedXor64*(Destination: ptr LONGLONG, Value: LONGLONG): LONGLONG {.importc: "InterlockedXor64", header: "<windows.h>".}
proc InterlockedAnd*(Destination: ptr LONG, Value: LONG): LONG {.importc: "InterlockedAnd", header: "<windows.h>".}
proc InterlockedAnd8*(Destination: ptr byte, Value: byte): byte {.importc: "InterlockedAnd8", header: "<windows.h>".}
proc InterlockedAnd16*(Destination: ptr SHORT, Value: SHORT): SHORT {.importc: "InterlockedAnd16", header: "<windows.h>".}
proc InterlockedAnd64*(Destination: ptr LONGLONG, Value: LONGLONG): LONGLONG {.importc: "InterlockedAnd64", header: "<windows.h>".}
proc InterlockedIncrement64*(Addend: ptr LONGLONG): LONGLONG {.importc: "InterlockedIncrement64", header: "<windows.h>".}
proc InterlockedDecrement64*(Addend: ptr LONGLONG): LONGLONG {.importc: "InterlockedDecrement64", header: "<windows.h>".}
proc InterlockedExchange64*(Target: ptr LONGLONG, Value: LONGLONG): LONGLONG {.importc: "InterlockedExchange64", header: "<windows.h>".}
proc InterlockedExchangeAdd64*(Addend: ptr LONGLONG, Value: LONGLONG): LONGLONG {.importc: "InterlockedExchangeAdd64", header: "<windows.h>".}
proc InterlockedCompareExchange64*(Destination: ptr LONGLONG, ExChange: LONGLONG, Comperand: LONGLONG): LONGLONG {.importc: "InterlockedCompareExchange64", header: "<windows.h>".}
proc InterlockedCompare64Exchange128*(Destination: ptr LONG64, ExchangeHigh: LONG64, ExchangeLow: LONG64, Comperand: LONG64): LONG64 {.importc: "InterlockedCompare64Exchange128", header: "<windows.h>".}
proc InterlockedIncrement*(Addend: ptr LONG): LONG {.importc: "InterlockedIncrement", header: "<windows.h>".}
proc InterlockedDecrement*(Addend: ptr LONG): LONG {.importc: "InterlockedDecrement", header: "<windows.h>".}
proc InterlockedExchange*(Target: ptr LONG, Value: LONG): LONG {.importc: "InterlockedExchange", header: "<windows.h>".}
proc InterlockedExchangeAdd*(Addend: ptr LONG, Value: LONG): LONG {.importc: "InterlockedExchangeAdd", header: "<windows.h>".}
proc InterlockedCompareExchange*(Destination: ptr LONG, ExChange: LONG, Comperand: LONG): LONG {.importc: "InterlockedCompareExchange", header: "<windows.h>".}
proc InterlockedExchangePointer*(Target: ptr PVOID, Value: PVOID): PVOID {.importc: "InterlockedExchangePointer", header: "<windows.h>".}
proc InterlockedCompareExchangePointer*(Destination: ptr PVOID, ExChange: PVOID, Comperand: PVOID): PVOID {.importc: "InterlockedCompareExchangePointer", header: "<windows.h>".}
proc `Offset=`*(self: var OVERLAPPED, x: DWORD) {.inline.} = self.union1.struct1.Offset = x
proc Offset*(self: OVERLAPPED): DWORD {.inline.} = self.union1.struct1.Offset
proc Offset*(self: var OVERLAPPED): var DWORD {.inline.} = self.union1.struct1.Offset
proc `OffsetHigh=`*(self: var OVERLAPPED, x: DWORD) {.inline.} = self.union1.struct1.OffsetHigh = x
proc OffsetHigh*(self: OVERLAPPED): DWORD {.inline.} = self.union1.struct1.OffsetHigh
proc OffsetHigh*(self: var OVERLAPPED): var DWORD {.inline.} = self.union1.struct1.OffsetHigh
proc `Pointer=`*(self: var OVERLAPPED, x: PVOID) {.inline.} = self.union1.Pointer = x
proc Pointer*(self: OVERLAPPED): PVOID {.inline.} = self.union1.Pointer
proc Pointer*(self: var OVERLAPPED): var PVOID {.inline.} = self.union1.Pointer
proc `Block=`*(self: var PROCESS_HEAP_ENTRY, x: PROCESS_HEAP_ENTRY_UNION1_Block) {.inline.} = self.union1.Block = x
proc Block*(self: PROCESS_HEAP_ENTRY): PROCESS_HEAP_ENTRY_UNION1_Block {.inline.} = self.union1.Block
proc Block*(self: var PROCESS_HEAP_ENTRY): var PROCESS_HEAP_ENTRY_UNION1_Block {.inline.} = self.union1.Block
proc `Region=`*(self: var PROCESS_HEAP_ENTRY, x: PROCESS_HEAP_ENTRY_UNION1_Region) {.inline.} = self.union1.Region = x
proc Region*(self: PROCESS_HEAP_ENTRY): PROCESS_HEAP_ENTRY_UNION1_Region {.inline.} = self.union1.Region
proc Region*(self: var PROCESS_HEAP_ENTRY): var PROCESS_HEAP_ENTRY_UNION1_Region {.inline.} = self.union1.Region
proc `dwOemId=`*(self: var SYSTEM_INFO, x: DWORD) {.inline.} = self.union1.dwOemId = x
proc dwOemId*(self: SYSTEM_INFO): DWORD {.inline.} = self.union1.dwOemId
proc dwOemId*(self: var SYSTEM_INFO): var DWORD {.inline.} = self.union1.dwOemId
proc `wProcessorArchitecture=`*(self: var SYSTEM_INFO, x: WORD) {.inline.} = self.union1.struct1.wProcessorArchitecture = x
proc wProcessorArchitecture*(self: SYSTEM_INFO): WORD {.inline.} = self.union1.struct1.wProcessorArchitecture
proc wProcessorArchitecture*(self: var SYSTEM_INFO): var WORD {.inline.} = self.union1.struct1.wProcessorArchitecture
proc `wReserved=`*(self: var SYSTEM_INFO, x: WORD) {.inline.} = self.union1.struct1.wReserved = x
proc wReserved*(self: SYSTEM_INFO): WORD {.inline.} = self.union1.struct1.wReserved
proc wReserved*(self: var SYSTEM_INFO): var WORD {.inline.} = self.union1.struct1.wReserved
proc `FileId=`*(self: var FILE_ID_DESCRIPTOR, x: LARGE_INTEGER) {.inline.} = self.union1.FileId = x
proc FileId*(self: FILE_ID_DESCRIPTOR): LARGE_INTEGER {.inline.} = self.union1.FileId
proc FileId*(self: var FILE_ID_DESCRIPTOR): var LARGE_INTEGER {.inline.} = self.union1.FileId
proc `ObjectId=`*(self: var FILE_ID_DESCRIPTOR, x: GUID) {.inline.} = self.union1.ObjectId = x
proc objectId*(self: FILE_ID_DESCRIPTOR): GUID {.inline.} = self.union1.ObjectId
proc objectId*(self: var FILE_ID_DESCRIPTOR): var GUID {.inline.} = self.union1.ObjectId
proc `ExtendedFileId=`*(self: var FILE_ID_DESCRIPTOR, x: FILE_ID_128) {.inline.} = self.union1.ExtendedFileId = x
proc ExtendedFileId*(self: FILE_ID_DESCRIPTOR): FILE_ID_128 {.inline.} = self.union1.ExtendedFileId
proc ExtendedFileId*(self: var FILE_ID_DESCRIPTOR): var FILE_ID_128 {.inline.} = self.union1.ExtendedFileId
when winimUnicode:
  type
    WIN32_FIND_DATA* = WIN32_FIND_DATAW
    PWIN32_FIND_DATA* = PWIN32_FIND_DATAW
    LPWIN32_FIND_DATA* = LPWIN32_FIND_DATAW
    ENUMRESLANGPROC* = ENUMRESLANGPROCW
    ENUMRESNAMEPROC* = ENUMRESNAMEPROCW
    ENUMRESTYPEPROC* = ENUMRESTYPEPROCW
    PGET_MODULE_HANDLE_EX* = PGET_MODULE_HANDLE_EXW
    STARTUPINFO* = STARTUPINFOW
    LPSTARTUPINFO* = LPSTARTUPINFOW
    STARTUPINFOEX* = STARTUPINFOEXW
    LPSTARTUPINFOEX* = LPSTARTUPINFOEXW
    HW_PROFILE_INFO* = HW_PROFILE_INFOW
    LPHW_PROFILE_INFO* = LPHW_PROFILE_INFOW
    ACTCTX* = ACTCTXW
    PACTCTX* = PACTCTXW
    PCACTCTX* = PCACTCTXW
  const
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_A* = GET_SYSTEM_WOW64_DIRECTORY_NAME_W_A
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_W* = GET_SYSTEM_WOW64_DIRECTORY_NAME_W_W
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_T* = GET_SYSTEM_WOW64_DIRECTORY_NAME_W_T
  proc DefineDosDevice*(dwFlags: DWORD, lpDeviceName: LPCWSTR, lpTargetPath: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DefineDosDeviceW".}
  proc DeleteVolumeMountPoint*(lpszVolumeMountPoint: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DeleteVolumeMountPointW".}
  proc FindFirstVolume*(lpszVolumeName: LPWSTR, cchBufferLength: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstVolumeW".}
  proc FindNextVolume*(hFindVolume: HANDLE, lpszVolumeName: LPWSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FindNextVolumeW".}
  proc GetLogicalDriveStrings*(nBufferLength: DWORD, lpBuffer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetLogicalDriveStringsW".}
  proc GetShortPathName*(lpszLongPath: LPCWSTR, lpszShortPath: LPWSTR, cchBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetShortPathNameW".}
  proc GetTempFileName*(lpPathName: LPCWSTR, lpPrefixString: LPCWSTR, uUnique: UINT, lpTempFileName: LPWSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetTempFileNameW".}
  proc GetVolumeInformation*(lpRootPathName: LPCWSTR, lpVolumeNameBuffer: LPWSTR, nVolumeNameSize: DWORD, lpVolumeSerialNumber: LPDWORD, lpMaximumComponentLength: LPDWORD, lpFileSystemFlags: LPDWORD, lpFileSystemNameBuffer: LPWSTR, nFileSystemNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVolumeInformationW".}
  proc GetVolumePathName*(lpszFileName: LPCWSTR, lpszVolumePathName: LPWSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVolumePathNameW".}
  proc QueryDosDevice*(lpDeviceName: LPCWSTR, lpTargetPath: LPWSTR, ucchMax: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "QueryDosDeviceW".}
  proc GetVolumeNameForVolumeMountPoint*(lpszVolumeMountPoint: LPCWSTR, lpszVolumeName: LPWSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVolumeNameForVolumeMountPointW".}
  proc GetVolumePathNamesForVolumeName*(lpszVolumeName: LPCWSTR, lpszVolumePathNames: LPWCH, cchBufferLength: DWORD, lpcchReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVolumePathNamesForVolumeNameW".}
  proc GetTempPath*(nBufferLength: DWORD, lpBuffer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetTempPathW".}
  proc FindResourceEx*(hModule: HMODULE, lpType: LPCWSTR, lpName: LPCWSTR, wLanguage: WORD): HRSRC {.winapi, stdcall, dynlib: "kernel32", importc: "FindResourceExW".}
  proc CreateFileMapping*(hFile: HANDLE, lpFileMappingAttributes: LPSECURITY_ATTRIBUTES, flProtect: DWORD, dwMaximumSizeHigh: DWORD, dwMaximumSizeLow: DWORD, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateFileMappingW".}
  proc OpenFileMapping*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenFileMappingW".}
  proc CreateFileMappingNuma*(hFile: HANDLE, lpFileMappingAttributes: LPSECURITY_ATTRIBUTES, flProtect: DWORD, dwMaximumSizeHigh: DWORD, dwMaximumSizeLow: DWORD, lpName: LPCWSTR, nndPreferred: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateFileMappingNumaW".}
  proc CreateNamedPipe*(lpName: LPCWSTR, dwOpenMode: DWORD, dwPipeMode: DWORD, nMaxInstances: DWORD, nOutBufferSize: DWORD, nInBufferSize: DWORD, nDefaultTimeOut: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateNamedPipeW".}
  proc WaitNamedPipe*(lpNamedPipeName: LPCWSTR, nTimeOut: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WaitNamedPipeW".}
  proc GetNamedPipeClientComputerName*(Pipe: HANDLE, ClientComputerName: LPWSTR, ClientComputerNameLength: ULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetNamedPipeClientComputerNameW".}
  proc CreatePrivateNamespace*(lpPrivateNamespaceAttributes: LPSECURITY_ATTRIBUTES, lpBoundaryDescriptor: LPVOID, lpAliasPrefix: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreatePrivateNamespaceW".}
  proc CreateBoundaryDescriptor*(Name: LPCWSTR, Flags: ULONG): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateBoundaryDescriptorW".}
  proc GetEnvironmentStrings*(): LPWCH {.winapi, stdcall, dynlib: "kernel32", importc: "GetEnvironmentStringsW".}
  proc SetEnvironmentStrings*(NewEnvironment: LPWCH): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetEnvironmentStringsW".}
  proc GetStartupInfo*(lpStartupInfo: LPSTARTUPINFOW): VOID {.winapi, stdcall, dynlib: "kernel32", importc: "GetStartupInfoW".}
  proc CreateProcessAsUser*(hToken: HANDLE, lpApplicationName: LPCWSTR, lpCommandLine: LPWSTR, lpProcessAttributes: LPSECURITY_ATTRIBUTES, lpThreadAttributes: LPSECURITY_ATTRIBUTES, bInheritHandles: WINBOOL, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCWSTR, lpStartupInfo: LPSTARTUPINFOW, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CreateProcessAsUserW".}
  proc AccessCheckAndAuditAlarm*(SubsystemName: LPCWSTR, HandleId: LPVOID, ObjectTypeName: LPWSTR, ObjectName: LPWSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, DesiredAccess: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatus: LPBOOL, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AccessCheckAndAuditAlarmW".}
  proc AccessCheckByTypeAndAuditAlarm*(SubsystemName: LPCWSTR, HandleId: LPVOID, ObjectTypeName: LPCWSTR, ObjectName: LPCWSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatus: LPBOOL, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AccessCheckByTypeAndAuditAlarmW".}
  proc AccessCheckByTypeResultListAndAuditAlarm*(SubsystemName: LPCWSTR, HandleId: LPVOID, ObjectTypeName: LPCWSTR, ObjectName: LPCWSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccessList: LPDWORD, AccessStatusList: LPDWORD, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AccessCheckByTypeResultListAndAuditAlarmW".}
  proc AccessCheckByTypeResultListAndAuditAlarmByHandle*(SubsystemName: LPCWSTR, HandleId: LPVOID, ClientToken: HANDLE, ObjectTypeName: LPCWSTR, ObjectName: LPCWSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccessList: LPDWORD, AccessStatusList: LPDWORD, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AccessCheckByTypeResultListAndAuditAlarmByHandleW".}
  proc GetFileSecurity*(lpFileName: LPCWSTR, RequestedInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetFileSecurityW".}
  proc ObjectCloseAuditAlarm*(SubsystemName: LPCWSTR, HandleId: LPVOID, GenerateOnClose: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ObjectCloseAuditAlarmW".}
  proc ObjectDeleteAuditAlarm*(SubsystemName: LPCWSTR, HandleId: LPVOID, GenerateOnClose: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ObjectDeleteAuditAlarmW".}
  proc ObjectOpenAuditAlarm*(SubsystemName: LPCWSTR, HandleId: LPVOID, ObjectTypeName: LPWSTR, ObjectName: LPWSTR, pSecurityDescriptor: PSECURITY_DESCRIPTOR, ClientToken: HANDLE, DesiredAccess: DWORD, GrantedAccess: DWORD, Privileges: PPRIVILEGE_SET, ObjectCreation: WINBOOL, AccessGranted: WINBOOL, GenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ObjectOpenAuditAlarmW".}
  proc ObjectPrivilegeAuditAlarm*(SubsystemName: LPCWSTR, HandleId: LPVOID, ClientToken: HANDLE, DesiredAccess: DWORD, Privileges: PPRIVILEGE_SET, AccessGranted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ObjectPrivilegeAuditAlarmW".}
  proc PrivilegedServiceAuditAlarm*(SubsystemName: LPCWSTR, ServiceName: LPCWSTR, ClientToken: HANDLE, Privileges: PPRIVILEGE_SET, AccessGranted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "PrivilegedServiceAuditAlarmW".}
  proc SetFileSecurity*(lpFileName: LPCWSTR, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "SetFileSecurityW".}
  proc CreateSemaphoreEx*(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES, lInitialCount: LONG, lMaximumCount: LONG, lpName: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateSemaphoreExW".}
  proc OpenMutex*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenMutexW".}
  proc OpenSemaphore*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenSemaphoreW".}
  proc CreateWaitableTimerEx*(lpTimerAttributes: LPSECURITY_ATTRIBUTES, lpTimerName: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateWaitableTimerExW".}
  proc OpenWaitableTimer*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpTimerName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenWaitableTimerW".}
  proc SetComputerNameEx*(NameType: COMPUTER_NAME_FORMAT, lpBuffer: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetComputerNameExW".}
  proc OutputDebugString*(lpOutputString: LPCWSTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc: "OutputDebugStringW".}
  proc CreateFile*(lpFileName: LPCWSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwCreationDisposition: DWORD, dwFlagsAndAttributes: DWORD, hTemplateFile: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateFileW".}
  proc FindFirstChangeNotification*(lpPathName: LPCWSTR, bWatchSubtree: WINBOOL, dwNotifyFilter: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstChangeNotificationW".}
  proc FindFirstFile*(lpFileName: LPCWSTR, lpFindFileData: LPWIN32_FIND_DATAW): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstFileW".}
  proc GetDiskFreeSpace*(lpRootPathName: LPCWSTR, lpSectorsPerCluster: LPDWORD, lpBytesPerSector: LPDWORD, lpNumberOfFreeClusters: LPDWORD, lpTotalNumberOfClusters: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetDiskFreeSpaceW".}
  proc GetDriveType*(lpRootPathName: LPCWSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetDriveTypeW".}
  proc GetFileAttributes*(lpFileName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFileAttributesW".}
  proc GetFullPathName*(lpFileName: LPCWSTR, nBufferLength: DWORD, lpBuffer: LPWSTR, lpFilePart: ptr LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFullPathNameW".}
  proc GetLongPathName*(lpszShortPath: LPCWSTR, lpszLongPath: LPWSTR, cchBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetLongPathNameW".}
  proc GetFinalPathNameByHandle*(hFile: HANDLE, lpszFilePath: LPWSTR, cchFilePath: DWORD, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFinalPathNameByHandleW".}
  proc CreateDirectory*(lpPathName: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateDirectoryW".}
  proc DeleteFile*(lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DeleteFileW".}
  proc FindFirstFileEx*(lpFileName: LPCWSTR, fInfoLevelId: FINDEX_INFO_LEVELS, lpFindFileData: LPVOID, fSearchOp: FINDEX_SEARCH_OPS, lpSearchFilter: LPVOID, dwAdditionalFlags: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstFileExW".}
  proc FindNextFile*(hFindFile: HANDLE, lpFindFileData: LPWIN32_FIND_DATAW): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FindNextFileW".}
  proc GetDiskFreeSpaceEx*(lpDirectoryName: LPCWSTR, lpFreeBytesAvailableToCaller: PULARGE_INTEGER, lpTotalNumberOfBytes: PULARGE_INTEGER, lpTotalNumberOfFreeBytes: PULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetDiskFreeSpaceExW".}
  proc GetFileAttributesEx*(lpFileName: LPCWSTR, fInfoLevelId: GET_FILEEX_INFO_LEVELS, lpFileInformation: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetFileAttributesExW".}
  proc RemoveDirectory*(lpPathName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "RemoveDirectoryW".}
  proc SetFileAttributes*(lpFileName: LPCWSTR, dwFileAttributes: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFileAttributesW".}
  proc GetModuleHandleEx*(dwFlags: DWORD, lpModuleName: LPCWSTR, phModule: ptr HMODULE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetModuleHandleExW".}
  proc LoadString*(hInstance: HINSTANCE, uID: UINT, lpBuffer: LPWSTR, cchBufferMax: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "LoadStringW".}
  proc GetModuleFileName*(hModule: HMODULE, lpFilename: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetModuleFileNameW".}
  proc GetModuleHandle*(lpModuleName: LPCWSTR): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc: "GetModuleHandleW".}
  proc LoadLibraryEx*(lpLibFileName: LPCWSTR, hFile: HANDLE, dwFlags: DWORD): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc: "LoadLibraryExW".}
  proc EnumResourceLanguages*(hModule: HMODULE, lpType: LPCWSTR, lpName: LPCWSTR, lpEnumFunc: ENUMRESLANGPROCW, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceLanguagesW".}
  proc EnumResourceLanguagesEx*(hModule: HMODULE, lpType: LPCWSTR, lpName: LPCWSTR, lpEnumFunc: ENUMRESLANGPROCW, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceLanguagesExW".}
  proc EnumResourceNamesEx*(hModule: HMODULE, lpType: LPCWSTR, lpEnumFunc: ENUMRESNAMEPROCW, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceNamesExW".}
  proc EnumResourceTypesEx*(hModule: HMODULE, lpEnumFunc: ENUMRESTYPEPROCW, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceTypesExW".}
  proc ExpandEnvironmentStrings*(lpSrc: LPCWSTR, lpDst: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "ExpandEnvironmentStringsW".}
  proc FreeEnvironmentStrings*(penv: LPWCH): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FreeEnvironmentStringsW".}
  proc GetCommandLine*(): LPWSTR {.winapi, stdcall, dynlib: "kernel32", importc: "GetCommandLineW".}
  proc GetCurrentDirectory*(nBufferLength: DWORD, lpBuffer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetCurrentDirectoryW".}
  proc GetEnvironmentVariable*(lpName: LPCWSTR, lpBuffer: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetEnvironmentVariableW".}
  proc NeedCurrentDirectoryForExePath*(ExeName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "NeedCurrentDirectoryForExePathW".}
  proc SearchPath*(lpPath: LPCWSTR, lpFileName: LPCWSTR, lpExtension: LPCWSTR, nBufferLength: DWORD, lpBuffer: LPWSTR, lpFilePart: ptr LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "SearchPathW".}
  proc SetCurrentDirectory*(lpPathName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetCurrentDirectoryW".}
  proc SetEnvironmentVariable*(lpName: LPCWSTR, lpValue: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetEnvironmentVariableW".}
  proc CreateProcess*(lpApplicationName: LPCWSTR, lpCommandLine: LPWSTR, lpProcessAttributes: LPSECURITY_ATTRIBUTES, lpThreadAttributes: LPSECURITY_ATTRIBUTES, bInheritHandles: WINBOOL, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCWSTR, lpStartupInfo: LPSTARTUPINFOW, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateProcessW".}
  proc CreateMutexEx*(lpMutexAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateMutexExW".}
  proc CreateEventEx*(lpEventAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCWSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateEventExW".}
  proc OpenEvent*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenEventW".}
  proc CreateMutex*(lpMutexAttributes: LPSECURITY_ATTRIBUTES, bInitialOwner: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateMutexW".}
  proc CreateEvent*(lpEventAttributes: LPSECURITY_ATTRIBUTES, bManualReset: WINBOOL, bInitialState: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateEventW".}
  proc GetSystemDirectory*(lpBuffer: LPWSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetSystemDirectoryW".}
  proc GetWindowsDirectory*(lpBuffer: LPWSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetWindowsDirectoryW".}
  proc GetSystemWindowsDirectory*(lpBuffer: LPWSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetSystemWindowsDirectoryW".}
  proc GetComputerNameEx*(NameType: COMPUTER_NAME_FORMAT, lpBuffer: LPWSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetComputerNameExW".}
  proc GetVersionEx*(lpVersionInformation: LPOSVERSIONINFOW): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVersionExW".}
  proc GetBinaryType*(lpApplicationName: LPCWSTR, lpBinaryType: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetBinaryTypeW".}
  proc GetLongPathNameTransacted*(lpszShortPath: LPCWSTR, lpszLongPath: LPWSTR, cchBuffer: DWORD, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetLongPathNameTransactedW".}
  proc SetFileShortName*(hFile: HANDLE, lpShortName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFileShortNameW".}
  proc FormatMessage*(dwFlags: DWORD, lpSource: LPCVOID, dwMessageId: DWORD, dwLanguageId: DWORD, lpBuffer: LPWSTR, nSize: DWORD, Arguments: ptr va_list): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "FormatMessageW".}
  proc CreateMailslot*(lpName: LPCWSTR, nMaxMessageSize: DWORD, lReadTimeout: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateMailslotW".}
  proc EncryptFile*(lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "EncryptFileW".}
  proc DecryptFile*(lpFileName: LPCWSTR, dwReserved: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "DecryptFileW".}
  proc FileEncryptionStatus*(lpFileName: LPCWSTR, lpStatus: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "FileEncryptionStatusW".}
  proc OpenEncryptedFileRaw*(lpFileName: LPCWSTR, ulFlags: ULONG, pvContext: ptr PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "OpenEncryptedFileRawW".}
  proc lstrcmp*(lpString1: LPCWSTR, lpString2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcmpW".}
  proc lstrcmpi*(lpString1: LPCWSTR, lpString2: LPCWSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcmpiW".}
  proc lstrcpyn*(lpString1: LPWSTR, lpString2: LPCWSTR, iMaxLength: int32): LPWSTR {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcpynW".}
  proc lstrcpy*(lpString1: LPWSTR, lpString2: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcpyW".}
  proc lstrcat*(lpString1: LPWSTR, lpString2: LPCWSTR): LPWSTR {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcatW".}
  proc lstrlen*(lpString: LPCWSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "lstrlenW".}
  proc CreateSemaphore*(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES, lInitialCount: LONG, lMaximumCount: LONG, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateSemaphoreW".}
  proc CreateWaitableTimer*(lpTimerAttributes: LPSECURITY_ATTRIBUTES, bManualReset: WINBOOL, lpTimerName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateWaitableTimerW".}
  proc LoadLibrary*(lpLibFileName: LPCWSTR): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc: "LoadLibraryW".}
  proc QueryFullProcessImageName*(hProcess: HANDLE, dwFlags: DWORD, lpExeName: LPWSTR, lpdwSize: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "QueryFullProcessImageNameW".}
  proc FatalAppExit*(uAction: UINT, lpMessageText: LPCWSTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc: "FatalAppExitW".}
  proc GetFirmwareEnvironmentVariable*(lpName: LPCWSTR, lpGuid: LPCWSTR, pBuffer: PVOID, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFirmwareEnvironmentVariableW".}
  proc SetFirmwareEnvironmentVariable*(lpName: LPCWSTR, lpGuid: LPCWSTR, pValue: PVOID, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFirmwareEnvironmentVariableW".}
  proc FindResource*(hModule: HMODULE, lpName: LPCWSTR, lpType: LPCWSTR): HRSRC {.winapi, stdcall, dynlib: "kernel32", importc: "FindResourceW".}
  proc EnumResourceTypes*(hModule: HMODULE, lpEnumFunc: ENUMRESTYPEPROCW, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceTypesW".}
  proc EnumResourceNames*(hModule: HMODULE, lpType: LPCWSTR, lpEnumFunc: ENUMRESNAMEPROCW, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceNamesW".}
  proc BeginUpdateResource*(pFileName: LPCWSTR, bDeleteExistingResources: WINBOOL): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "BeginUpdateResourceW".}
  proc UpdateResource*(hUpdate: HANDLE, lpType: LPCWSTR, lpName: LPCWSTR, wLanguage: WORD, lpData: LPVOID, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "UpdateResourceW".}
  proc EndUpdateResource*(hUpdate: HANDLE, fDiscard: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EndUpdateResourceW".}
  proc GlobalAddAtom*(lpString: LPCWSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalAddAtomW".}
  proc GlobalAddAtomEx*(lpString: LPCWSTR, Flags: DWORD): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalAddAtomExW".}
  proc GlobalFindAtom*(lpString: LPCWSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalFindAtomW".}
  proc GlobalGetAtomName*(nAtom: ATOM, lpBuffer: LPWSTR, nSize: int32): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalGetAtomNameW".}
  proc AddAtom*(lpString: LPCWSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "AddAtomW".}
  proc FindAtom*(lpString: LPCWSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "FindAtomW".}
  proc GetAtomName*(nAtom: ATOM, lpBuffer: LPWSTR, nSize: int32): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetAtomNameW".}
  proc GetProfileInt*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, nDefault: INT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetProfileIntW".}
  proc GetProfileString*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, lpDefault: LPCWSTR, lpReturnedString: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetProfileStringW".}
  proc WriteProfileString*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, lpString: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteProfileStringW".}
  proc GetProfileSection*(lpAppName: LPCWSTR, lpReturnedString: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetProfileSectionW".}
  proc WriteProfileSection*(lpAppName: LPCWSTR, lpString: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteProfileSectionW".}
  proc GetPrivateProfileInt*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, nDefault: INT, lpFileName: LPCWSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileIntW".}
  proc GetPrivateProfileString*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, lpDefault: LPCWSTR, lpReturnedString: LPWSTR, nSize: DWORD, lpFileName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileStringW".}
  proc WritePrivateProfileString*(lpAppName: LPCWSTR, lpKeyName: LPCWSTR, lpString: LPCWSTR, lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WritePrivateProfileStringW".}
  proc GetPrivateProfileSection*(lpAppName: LPCWSTR, lpReturnedString: LPWSTR, nSize: DWORD, lpFileName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileSectionW".}
  proc WritePrivateProfileSection*(lpAppName: LPCWSTR, lpString: LPCWSTR, lpFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WritePrivateProfileSectionW".}
  proc GetPrivateProfileSectionNames*(lpszReturnBuffer: LPWSTR, nSize: DWORD, lpFileName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileSectionNamesW".}
  proc GetPrivateProfileStruct*(lpszSection: LPCWSTR, lpszKey: LPCWSTR, lpStruct: LPVOID, uSizeStruct: UINT, szFile: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileStructW".}
  proc WritePrivateProfileStruct*(lpszSection: LPCWSTR, lpszKey: LPCWSTR, lpStruct: LPVOID, uSizeStruct: UINT, szFile: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WritePrivateProfileStructW".}
  proc GetFirmwareEnvironmentVariableEx*(lpName: LPCWSTR, lpGuid: LPCWSTR, pBuffer: PVOID, nSize: DWORD, pdwAttribubutes: PDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFirmwareEnvironmentVariableExW".}
  proc SetFirmwareEnvironmentVariableEx*(lpName: LPCWSTR, lpGuid: LPCWSTR, pValue: PVOID, nSize: DWORD, dwAttributes: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFirmwareEnvironmentVariableExW".}
  proc GetSystemWow64Directory*(lpBuffer: LPWSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetSystemWow64DirectoryW".}
  proc SetDllDirectory*(lpPathName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetDllDirectoryW".}
  proc GetDllDirectory*(nBufferLength: DWORD, lpBuffer: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetDllDirectoryW".}
  proc CreateDirectoryEx*(lpTemplateDirectory: LPCWSTR, lpNewDirectory: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateDirectoryExW".}
  proc CreateDirectoryTransacted*(lpTemplateDirectory: LPCWSTR, lpNewDirectory: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateDirectoryTransactedW".}
  proc RemoveDirectoryTransacted*(lpPathName: LPCWSTR, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "RemoveDirectoryTransactedW".}
  proc GetFullPathNameTransacted*(lpFileName: LPCWSTR, nBufferLength: DWORD, lpBuffer: LPWSTR, lpFilePart: ptr LPWSTR, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFullPathNameTransactedW".}
  proc CreateFileTransacted*(lpFileName: LPCWSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwCreationDisposition: DWORD, dwFlagsAndAttributes: DWORD, hTemplateFile: HANDLE, hTransaction: HANDLE, pusMiniVersion: PUSHORT, lpExtendedParameter: PVOID): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateFileTransactedW".}
  proc SetFileAttributesTransacted*(lpFileName: LPCWSTR, dwFileAttributes: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFileAttributesTransactedW".}
  proc GetFileAttributesTransacted*(lpFileName: LPCWSTR, fInfoLevelId: GET_FILEEX_INFO_LEVELS, lpFileInformation: LPVOID, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetFileAttributesTransactedW".}
  proc GetCompressedFileSize*(lpFileName: LPCWSTR, lpFileSizeHigh: LPDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetCompressedFileSizeW".}
  proc DeleteFileTransacted*(lpFileName: LPCWSTR, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DeleteFileTransactedW".}
  proc GetCompressedFileSizeTransacted*(lpFileName: LPCWSTR, lpFileSizeHigh: LPDWORD, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetCompressedFileSizeTransactedW".}
  proc FindFirstFileTransacted*(lpFileName: LPCWSTR, fInfoLevelId: FINDEX_INFO_LEVELS, lpFindFileData: LPVOID, fSearchOp: FINDEX_SEARCH_OPS, lpSearchFilter: LPVOID, dwAdditionalFlags: DWORD, hTransaction: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstFileTransactedW".}
  proc CopyFileTransacted*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, pbCancel: LPBOOL, dwCopyFlags: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CopyFileTransactedW".}
  proc CheckNameLegalDOS8Dot3*(lpName: LPCWSTR, lpOemName: LPSTR, OemNameSize: DWORD, pbNameContainsSpaces: PBOOL, pbNameLegal: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CheckNameLegalDOS8Dot3W".}
  proc CopyFile*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, bFailIfExists: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CopyFileW".}
  proc CopyFileEx*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, pbCancel: LPBOOL, dwCopyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CopyFileExW".}
  proc MoveFile*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "MoveFileW".}
  proc MoveFileEx*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "MoveFileExW".}
  proc MoveFileWithProgress*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "MoveFileWithProgressW".}
  proc MoveFileTransacted*(lpExistingFileName: LPCWSTR, lpNewFileName: LPCWSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, dwFlags: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "MoveFileTransactedW".}
  proc ReplaceFile*(lpReplacedFileName: LPCWSTR, lpReplacementFileName: LPCWSTR, lpBackupFileName: LPCWSTR, dwReplaceFlags: DWORD, lpExclude: LPVOID, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReplaceFileW".}
  proc CreateHardLink*(lpFileName: LPCWSTR, lpExistingFileName: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateHardLinkW".}
  proc CreateHardLinkTransacted*(lpFileName: LPCWSTR, lpExistingFileName: LPCWSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateHardLinkTransactedW".}
  proc GetNamedPipeHandleState*(hNamedPipe: HANDLE, lpState: LPDWORD, lpCurInstances: LPDWORD, lpMaxCollectionCount: LPDWORD, lpCollectDataTimeout: LPDWORD, lpUserName: LPWSTR, nMaxUserNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetNamedPipeHandleStateW".}
  proc CallNamedPipe*(lpNamedPipeName: LPCWSTR, lpInBuffer: LPVOID, nInBufferSize: DWORD, lpOutBuffer: LPVOID, nOutBufferSize: DWORD, lpBytesRead: LPDWORD, nTimeOut: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CallNamedPipeW".}
  proc SetVolumeLabel*(lpRootPathName: LPCWSTR, lpVolumeName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetVolumeLabelW".}
  proc ClearEventLog*(hEventLog: HANDLE, lpBackupFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ClearEventLogW".}
  proc BackupEventLog*(hEventLog: HANDLE, lpBackupFileName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "BackupEventLogW".}
  proc OpenEventLog*(lpUNCServerName: LPCWSTR, lpSourceName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "OpenEventLogW".}
  proc RegisterEventSource*(lpUNCServerName: LPCWSTR, lpSourceName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "RegisterEventSourceW".}
  proc OpenBackupEventLog*(lpUNCServerName: LPCWSTR, lpFileName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "OpenBackupEventLogW".}
  proc ReadEventLog*(hEventLog: HANDLE, dwReadFlags: DWORD, dwRecordOffset: DWORD, lpBuffer: LPVOID, nNumberOfBytesToRead: DWORD, pnBytesRead: ptr DWORD, pnMinNumberOfBytesNeeded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ReadEventLogW".}
  proc ReportEvent*(hEventLog: HANDLE, wType: WORD, wCategory: WORD, dwEventID: DWORD, lpUserSid: PSID, wNumStrings: WORD, dwDataSize: DWORD, lpStrings: ptr LPCWSTR, lpRawData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ReportEventW".}
  proc IsBadStringPtr*(lpsz: LPCWSTR, ucchMax: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "IsBadStringPtrW".}
  proc LookupPrivilegeValue*(lpSystemName: LPCWSTR, lpName: LPCWSTR, lpLuid: PLUID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupPrivilegeValueW".}
  proc LookupPrivilegeName*(lpSystemName: LPCWSTR, lpLuid: PLUID, lpName: LPWSTR, cchName: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupPrivilegeNameW".}
  proc LookupPrivilegeDisplayName*(lpSystemName: LPCWSTR, lpName: LPCWSTR, lpDisplayName: LPWSTR, cchDisplayName: LPDWORD, lpLanguageId: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupPrivilegeDisplayNameW".}
  proc BuildCommDCB*(lpDef: LPCWSTR, lpDCB: LPDCB): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "BuildCommDCBW".}
  proc BuildCommDCBAndTimeouts*(lpDef: LPCWSTR, lpDCB: LPDCB, lpCommTimeouts: LPCOMMTIMEOUTS): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "BuildCommDCBAndTimeoutsW".}
  proc CommConfigDialog*(lpszName: LPCWSTR, hWnd: HWND, lpCC: LPCOMMCONFIG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CommConfigDialogW".}
  proc GetDefaultCommConfig*(lpszName: LPCWSTR, lpCC: LPCOMMCONFIG, lpdwSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetDefaultCommConfigW".}
  proc SetDefaultCommConfig*(lpszName: LPCWSTR, lpCC: LPCOMMCONFIG, dwSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetDefaultCommConfigW".}
  proc GetComputerName*(lpBuffer: LPWSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetComputerNameW".}
  proc SetComputerName*(lpComputerName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetComputerNameW".}
  proc DnsHostnameToComputerName*(Hostname: LPCWSTR, ComputerName: LPWSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DnsHostnameToComputerNameW".}
  proc GetUserName*(lpBuffer: LPWSTR, pcbBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetUserNameW".}
  proc LogonUser*(lpszUsername: LPCWSTR, lpszDomain: LPCWSTR, lpszPassword: LPCWSTR, dwLogonType: DWORD, dwLogonProvider: DWORD, phToken: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LogonUserW".}
  proc LogonUserEx*(lpszUsername: LPCWSTR, lpszDomain: LPCWSTR, lpszPassword: LPCWSTR, dwLogonType: DWORD, dwLogonProvider: DWORD, phToken: PHANDLE, ppLogonSid: ptr PSID, ppProfileBuffer: ptr PVOID, pdwProfileLength: LPDWORD, pQuotaLimits: PQUOTA_LIMITS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LogonUserExW".}
  proc OpenPrivateNamespace*(lpBoundaryDescriptor: LPVOID, lpAliasPrefix: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenPrivateNamespaceW".}
  proc GetCurrentHwProfile*(lpHwProfileInfo: LPHW_PROFILE_INFOW): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetCurrentHwProfileW".}
  proc VerifyVersionInfo*(lpVersionInformation: LPOSVERSIONINFOEXW, dwTypeMask: DWORD, dwlConditionMask: DWORDLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "VerifyVersionInfoW".}
  proc CreateJobObject*(lpJobAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateJobObjectW".}
  proc OpenJobObject*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCWSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenJobObjectW".}
  proc FindFirstVolumeMountPoint*(lpszRootPathName: LPCWSTR, lpszVolumeMountPoint: LPWSTR, cchBufferLength: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstVolumeMountPointW".}
  proc FindNextVolumeMountPoint*(hFindVolumeMountPoint: HANDLE, lpszVolumeMountPoint: LPWSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FindNextVolumeMountPointW".}
  proc SetVolumeMountPoint*(lpszVolumeMountPoint: LPCWSTR, lpszVolumeName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetVolumeMountPointW".}
  proc CreateActCtx*(pActCtx: PCACTCTXW): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateActCtxW".}
  proc FindActCtxSectionString*(dwFlags: DWORD, lpExtensionGuid: ptr GUID, ulSectionId: ULONG, lpStringToFind: LPCWSTR, ReturnedData: PACTCTX_SECTION_KEYED_DATA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FindActCtxSectionStringW".}
  proc CreateSymbolicLink*(lpSymlinkFileName: LPCWSTR, lpTargetFileName: LPCWSTR, dwFlags: DWORD): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc: "CreateSymbolicLinkW".}
  proc CreateSymbolicLinkTransacted*(lpSymlinkFileName: LPCWSTR, lpTargetFileName: LPCWSTR, dwFlags: DWORD, hTransaction: HANDLE): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc: "CreateSymbolicLinkTransactedW".}
  proc LookupAccountNameLocal*(lpAccountName: LPCWSTR, Sid: PSID, cbSid: LPDWORD, ReferencedDomainName: LPWSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, inline.} = LookupAccountNameW(nil, lpAccountName, Sid, cbSid, ReferencedDomainName, cchReferencedDomainName, peUse)
  proc LookupAccountSidLocal*(Sid: PSID, Name: LPWSTR, cchName: LPDWORD, ReferencedDomainName: LPWSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, inline.} = LookupAccountSidW(nil, Sid, Name, cchName, ReferencedDomainName, cchReferencedDomainName, peUse)
when winimAnsi:
  type
    WIN32_FIND_DATA* = WIN32_FIND_DATAA
    PWIN32_FIND_DATA* = PWIN32_FIND_DATAA
    LPWIN32_FIND_DATA* = LPWIN32_FIND_DATAA
    ENUMRESLANGPROC* = ENUMRESLANGPROCA
    ENUMRESNAMEPROC* = ENUMRESNAMEPROCA
    ENUMRESTYPEPROC* = ENUMRESTYPEPROCA
    PGET_MODULE_HANDLE_EX* = PGET_MODULE_HANDLE_EXA
    STARTUPINFO* = STARTUPINFOA
    LPSTARTUPINFO* = LPSTARTUPINFOA
    STARTUPINFOEX* = STARTUPINFOEXA
    LPSTARTUPINFOEX* = LPSTARTUPINFOEXA
    HW_PROFILE_INFO* = HW_PROFILE_INFOA
    LPHW_PROFILE_INFO* = LPHW_PROFILE_INFOA
    ACTCTX* = ACTCTXA
    PACTCTX* = PACTCTXA
    PCACTCTX* = PCACTCTXA
  const
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_A* = GET_SYSTEM_WOW64_DIRECTORY_NAME_A_A
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_W* = GET_SYSTEM_WOW64_DIRECTORY_NAME_A_W
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_T* = GET_SYSTEM_WOW64_DIRECTORY_NAME_A_T
  proc GetEnvironmentStrings*(): LPCH {.winapi, stdcall, dynlib: "kernel32", importc.}
  proc SetEnvironmentStrings*(NewEnvironment: LPCH): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetEnvironmentStringsA".}
  proc GetShortPathName*(lpszLongPath: LPCSTR, lpszShortPath: LPSTR, cchBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetShortPathNameA".}
  proc OpenMutex*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenMutexA".}
  proc OpenSemaphore*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenSemaphoreA".}
  proc OpenWaitableTimer*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpTimerName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenWaitableTimerA".}
  proc CreateFileMapping*(hFile: HANDLE, lpFileMappingAttributes: LPSECURITY_ATTRIBUTES, flProtect: DWORD, dwMaximumSizeHigh: DWORD, dwMaximumSizeLow: DWORD, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateFileMappingA".}
  proc OpenFileMapping*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenFileMappingA".}
  proc GetLogicalDriveStrings*(nBufferLength: DWORD, lpBuffer: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetLogicalDriveStringsA".}
  proc CreateSemaphoreEx*(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES, lInitialCount: LONG, lMaximumCount: LONG, lpName: LPCSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateSemaphoreExA".}
  proc CreateWaitableTimerEx*(lpTimerAttributes: LPSECURITY_ATTRIBUTES, lpTimerName: LPCSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateWaitableTimerExA".}
  proc CreateFileMappingNuma*(hFile: HANDLE, lpFileMappingAttributes: LPSECURITY_ATTRIBUTES, flProtect: DWORD, dwMaximumSizeHigh: DWORD, dwMaximumSizeLow: DWORD, lpName: LPCSTR, nndPreferred: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateFileMappingNumaA".}
  proc GetStartupInfo*(lpStartupInfo: LPSTARTUPINFOA): VOID {.winapi, stdcall, dynlib: "kernel32", importc: "GetStartupInfoA".}
  proc FindResourceEx*(hModule: HMODULE, lpType: LPCSTR, lpName: LPCSTR, wLanguage: WORD): HRSRC {.winapi, stdcall, dynlib: "kernel32", importc: "FindResourceExA".}
  proc GetTempPath*(nBufferLength: DWORD, lpBuffer: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetTempPathA".}
  proc GetTempFileName*(lpPathName: LPCSTR, lpPrefixString: LPCSTR, uUnique: UINT, lpTempFileName: LPSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetTempFileNameA".}
  proc DefineDosDevice*(dwFlags: DWORD, lpDeviceName: LPCSTR, lpTargetPath: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DefineDosDeviceA".}
  proc QueryDosDevice*(lpDeviceName: LPCSTR, lpTargetPath: LPSTR, ucchMax: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "QueryDosDeviceA".}
  proc CreateNamedPipe*(lpName: LPCSTR, dwOpenMode: DWORD, dwPipeMode: DWORD, nMaxInstances: DWORD, nOutBufferSize: DWORD, nInBufferSize: DWORD, nDefaultTimeOut: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateNamedPipeA".}
  proc WaitNamedPipe*(lpNamedPipeName: LPCSTR, nTimeOut: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WaitNamedPipeA".}
  proc GetVolumeInformation*(lpRootPathName: LPCSTR, lpVolumeNameBuffer: LPSTR, nVolumeNameSize: DWORD, lpVolumeSerialNumber: LPDWORD, lpMaximumComponentLength: LPDWORD, lpFileSystemFlags: LPDWORD, lpFileSystemNameBuffer: LPSTR, nFileSystemNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVolumeInformationA".}
  proc AccessCheckAndAuditAlarm*(SubsystemName: LPCSTR, HandleId: LPVOID, ObjectTypeName: LPSTR, ObjectName: LPSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, DesiredAccess: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatus: LPBOOL, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AccessCheckAndAuditAlarmA".}
  proc AccessCheckByTypeAndAuditAlarm*(SubsystemName: LPCSTR, HandleId: LPVOID, ObjectTypeName: LPCSTR, ObjectName: LPCSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatus: LPBOOL, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AccessCheckByTypeAndAuditAlarmA".}
  proc AccessCheckByTypeResultListAndAuditAlarm*(SubsystemName: LPCSTR, HandleId: LPVOID, ObjectTypeName: LPCSTR, ObjectName: LPCSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatusList: LPDWORD, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AccessCheckByTypeResultListAndAuditAlarmA".}
  proc AccessCheckByTypeResultListAndAuditAlarmByHandle*(SubsystemName: LPCSTR, HandleId: LPVOID, ClientToken: HANDLE, ObjectTypeName: LPCSTR, ObjectName: LPCSTR, SecurityDescriptor: PSECURITY_DESCRIPTOR, PrincipalSelfSid: PSID, DesiredAccess: DWORD, AuditType: AUDIT_EVENT_TYPE, Flags: DWORD, ObjectTypeList: POBJECT_TYPE_LIST, ObjectTypeListLength: DWORD, GenericMapping: PGENERIC_MAPPING, ObjectCreation: WINBOOL, GrantedAccess: LPDWORD, AccessStatusList: LPDWORD, pfGenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "AccessCheckByTypeResultListAndAuditAlarmByHandleA".}
  proc ObjectOpenAuditAlarm*(SubsystemName: LPCSTR, HandleId: LPVOID, ObjectTypeName: LPSTR, ObjectName: LPSTR, pSecurityDescriptor: PSECURITY_DESCRIPTOR, ClientToken: HANDLE, DesiredAccess: DWORD, GrantedAccess: DWORD, Privileges: PPRIVILEGE_SET, ObjectCreation: WINBOOL, AccessGranted: WINBOOL, GenerateOnClose: LPBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ObjectOpenAuditAlarmA".}
  proc ObjectPrivilegeAuditAlarm*(SubsystemName: LPCSTR, HandleId: LPVOID, ClientToken: HANDLE, DesiredAccess: DWORD, Privileges: PPRIVILEGE_SET, AccessGranted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ObjectPrivilegeAuditAlarmA".}
  proc ObjectCloseAuditAlarm*(SubsystemName: LPCSTR, HandleId: LPVOID, GenerateOnClose: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ObjectCloseAuditAlarmA".}
  proc ObjectDeleteAuditAlarm*(SubsystemName: LPCSTR, HandleId: LPVOID, GenerateOnClose: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ObjectDeleteAuditAlarmA".}
  proc PrivilegedServiceAuditAlarm*(SubsystemName: LPCSTR, ServiceName: LPCSTR, ClientToken: HANDLE, Privileges: PPRIVILEGE_SET, AccessGranted: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "PrivilegedServiceAuditAlarmA".}
  proc SetFileSecurity*(lpFileName: LPCSTR, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "SetFileSecurityA".}
  proc GetFileSecurity*(lpFileName: LPCSTR, RequestedInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR, nLength: DWORD, lpnLengthNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetFileSecurityA".}
  proc SetComputerNameEx*(NameType: COMPUTER_NAME_FORMAT, lpBuffer: LPCTSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetComputerNameExA".}
  proc CreateProcessAsUser*(hToken: HANDLE, lpApplicationName: LPCSTR, lpCommandLine: LPSTR, lpProcessAttributes: LPSECURITY_ATTRIBUTES, lpThreadAttributes: LPSECURITY_ATTRIBUTES, bInheritHandles: WINBOOL, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCSTR, lpStartupInfo: LPSTARTUPINFOA, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "CreateProcessAsUserA".}
  proc FindFirstVolume*(lpszVolumeName: LPSTR, cchBufferLength: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstVolumeA".}
  proc FindNextVolume*(hFindVolume: HANDLE, lpszVolumeName: LPSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FindNextVolumeA".}
  proc DeleteVolumeMountPoint*(lpszVolumeMountPoint: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DeleteVolumeMountPointA".}
  proc GetVolumeNameForVolumeMountPoint*(lpszVolumeMountPoint: LPCSTR, lpszVolumeName: LPSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVolumeNameForVolumeMountPointA".}
  proc GetVolumePathName*(lpszFileName: LPCSTR, lpszVolumePathName: LPSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVolumePathNameA".}
  proc GetVolumePathNamesForVolumeName*(lpszVolumeName: LPCSTR, lpszVolumePathNames: LPCH, cchBufferLength: DWORD, lpcchReturnLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVolumePathNamesForVolumeNameA".}
  proc OutputDebugString*(lpOutputString: LPCSTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc: "OutputDebugStringA".}
  proc CreateFile*(lpFileName: LPCSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwCreationDisposition: DWORD, dwFlagsAndAttributes: DWORD, hTemplateFile: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateFileA".}
  proc FindFirstChangeNotification*(lpPathName: LPCSTR, bWatchSubtree: WINBOOL, dwNotifyFilter: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstChangeNotificationA".}
  proc FindFirstFile*(lpFileName: LPCSTR, lpFindFileData: LPWIN32_FIND_DATAA): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstFileA".}
  proc GetDiskFreeSpace*(lpRootPathName: LPCSTR, lpSectorsPerCluster: LPDWORD, lpBytesPerSector: LPDWORD, lpNumberOfFreeClusters: LPDWORD, lpTotalNumberOfClusters: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetDiskFreeSpaceA".}
  proc GetDriveType*(lpRootPathName: LPCSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetDriveTypeA".}
  proc GetFileAttributes*(lpFileName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFileAttributesA".}
  proc GetFullPathName*(lpFileName: LPCSTR, nBufferLength: DWORD, lpBuffer: LPSTR, lpFilePart: ptr LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFullPathNameA".}
  proc GetLongPathName*(lpszShortPath: LPCSTR, lpszLongPath: LPSTR, cchBuffer: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetLongPathNameA".}
  proc GetFinalPathNameByHandle*(hFile: HANDLE, lpszFilePath: LPSTR, cchFilePath: DWORD, dwFlags: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFinalPathNameByHandleA".}
  proc CreateDirectory*(lpPathName: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateDirectoryA".}
  proc DeleteFile*(lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DeleteFileA".}
  proc FindFirstFileEx*(lpFileName: LPCSTR, fInfoLevelId: FINDEX_INFO_LEVELS, lpFindFileData: LPVOID, fSearchOp: FINDEX_SEARCH_OPS, lpSearchFilter: LPVOID, dwAdditionalFlags: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstFileExA".}
  proc FindNextFile*(hFindFile: HANDLE, lpFindFileData: LPWIN32_FIND_DATAA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FindNextFileA".}
  proc GetDiskFreeSpaceEx*(lpDirectoryName: LPCSTR, lpFreeBytesAvailableToCaller: PULARGE_INTEGER, lpTotalNumberOfBytes: PULARGE_INTEGER, lpTotalNumberOfFreeBytes: PULARGE_INTEGER): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetDiskFreeSpaceExA".}
  proc GetFileAttributesEx*(lpFileName: LPCSTR, fInfoLevelId: GET_FILEEX_INFO_LEVELS, lpFileInformation: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetFileAttributesExA".}
  proc RemoveDirectory*(lpPathName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "RemoveDirectoryA".}
  proc SetFileAttributes*(lpFileName: LPCSTR, dwFileAttributes: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFileAttributesA".}
  proc GetModuleHandleEx*(dwFlags: DWORD, lpModuleName: LPCSTR, phModule: ptr HMODULE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetModuleHandleExA".}
  proc LoadString*(hInstance: HINSTANCE, uID: UINT, lpBuffer: LPSTR, cchBufferMax: int32): int32 {.winapi, stdcall, dynlib: "user32", importc: "LoadStringA".}
  proc GetModuleFileName*(hModule: HMODULE, lpFilename: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetModuleFileNameA".}
  proc GetModuleHandle*(lpModuleName: LPCSTR): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc: "GetModuleHandleA".}
  proc LoadLibraryEx*(lpLibFileName: LPCSTR, hFile: HANDLE, dwFlags: DWORD): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc: "LoadLibraryExA".}
  proc EnumResourceLanguages*(hModule: HMODULE, lpType: LPCSTR, lpName: LPCSTR, lpEnumFunc: ENUMRESLANGPROCA, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceLanguagesA".}
  proc EnumResourceLanguagesEx*(hModule: HMODULE, lpType: LPCSTR, lpName: LPCSTR, lpEnumFunc: ENUMRESLANGPROCA, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceLanguagesExA".}
  proc EnumResourceNamesEx*(hModule: HMODULE, lpType: LPCSTR, lpEnumFunc: ENUMRESNAMEPROCA, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceNamesExA".}
  proc EnumResourceTypesEx*(hModule: HMODULE, lpEnumFunc: ENUMRESTYPEPROCA, lParam: LONG_PTR, dwFlags: DWORD, LangId: LANGID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceTypesExA".}
  proc ExpandEnvironmentStrings*(lpSrc: LPCSTR, lpDst: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "ExpandEnvironmentStringsA".}
  proc FreeEnvironmentStrings*(penv: LPCH): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FreeEnvironmentStringsA".}
  proc GetCommandLine*(): LPSTR {.winapi, stdcall, dynlib: "kernel32", importc: "GetCommandLineA".}
  proc GetCurrentDirectory*(nBufferLength: DWORD, lpBuffer: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetCurrentDirectoryA".}
  proc GetEnvironmentVariable*(lpName: LPCSTR, lpBuffer: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetEnvironmentVariableA".}
  proc NeedCurrentDirectoryForExePath*(ExeName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "NeedCurrentDirectoryForExePathA".}
  proc SearchPath*(lpPath: LPCSTR, lpFileName: LPCSTR, lpExtension: LPCSTR, nBufferLength: DWORD, lpBuffer: LPSTR, lpFilePart: ptr LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "SearchPathA".}
  proc SetCurrentDirectory*(lpPathName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetCurrentDirectoryA".}
  proc SetEnvironmentVariable*(lpName: LPCSTR, lpValue: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetEnvironmentVariableA".}
  proc CreateProcess*(lpApplicationName: LPCSTR, lpCommandLine: LPSTR, lpProcessAttributes: LPSECURITY_ATTRIBUTES, lpThreadAttributes: LPSECURITY_ATTRIBUTES, bInheritHandles: WINBOOL, dwCreationFlags: DWORD, lpEnvironment: LPVOID, lpCurrentDirectory: LPCSTR, lpStartupInfo: LPSTARTUPINFOA, lpProcessInformation: LPPROCESS_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateProcessA".}
  proc CreateMutexEx*(lpMutexAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateMutexExA".}
  proc CreateEventEx*(lpEventAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCSTR, dwFlags: DWORD, dwDesiredAccess: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateEventExA".}
  proc OpenEvent*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenEventA".}
  proc CreateMutex*(lpMutexAttributes: LPSECURITY_ATTRIBUTES, bInitialOwner: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateMutexA".}
  proc CreateEvent*(lpEventAttributes: LPSECURITY_ATTRIBUTES, bManualReset: WINBOOL, bInitialState: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateEventA".}
  proc GetSystemDirectory*(lpBuffer: LPSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetSystemDirectoryA".}
  proc GetWindowsDirectory*(lpBuffer: LPSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetWindowsDirectoryA".}
  proc GetSystemWindowsDirectory*(lpBuffer: LPSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetSystemWindowsDirectoryA".}
  proc GetComputerNameEx*(NameType: COMPUTER_NAME_FORMAT, lpBuffer: LPSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetComputerNameExA".}
  proc GetVersionEx*(lpVersionInformation: LPOSVERSIONINFOA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetVersionExA".}
  proc GetBinaryType*(lpApplicationName: LPCSTR, lpBinaryType: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetBinaryTypeA".}
  proc GetLongPathNameTransacted*(lpszShortPath: LPCSTR, lpszLongPath: LPSTR, cchBuffer: DWORD, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetLongPathNameTransactedA".}
  proc SetFileShortName*(hFile: HANDLE, lpShortName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFileShortNameA".}
  proc FormatMessage*(dwFlags: DWORD, lpSource: LPCVOID, dwMessageId: DWORD, dwLanguageId: DWORD, lpBuffer: LPSTR, nSize: DWORD, Arguments: ptr va_list): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "FormatMessageA".}
  proc CreateMailslot*(lpName: LPCSTR, nMaxMessageSize: DWORD, lReadTimeout: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateMailslotA".}
  proc EncryptFile*(lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "EncryptFileA".}
  proc DecryptFile*(lpFileName: LPCSTR, dwReserved: DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "DecryptFileA".}
  proc FileEncryptionStatus*(lpFileName: LPCSTR, lpStatus: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "FileEncryptionStatusA".}
  proc OpenEncryptedFileRaw*(lpFileName: LPCSTR, ulFlags: ULONG, pvContext: ptr PVOID): DWORD {.winapi, stdcall, dynlib: "advapi32", importc: "OpenEncryptedFileRawA".}
  proc lstrcmp*(lpString1: LPCSTR, lpString2: LPCSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcmpA".}
  proc lstrcmpi*(lpString1: LPCSTR, lpString2: LPCSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcmpiA".}
  proc lstrcpyn*(lpString1: LPSTR, lpString2: LPCSTR, iMaxLength: int32): LPSTR {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcpynA".}
  proc lstrcpy*(lpString1: LPSTR, lpString2: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcpyA".}
  proc lstrcat*(lpString1: LPSTR, lpString2: LPCSTR): LPSTR {.winapi, stdcall, dynlib: "kernel32", importc: "lstrcatA".}
  proc lstrlen*(lpString: LPCSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "lstrlenA".}
  proc CreateSemaphore*(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES, lInitialCount: LONG, lMaximumCount: LONG, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateSemaphoreA".}
  proc CreateWaitableTimer*(lpTimerAttributes: LPSECURITY_ATTRIBUTES, bManualReset: WINBOOL, lpTimerName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateWaitableTimerA".}
  proc LoadLibrary*(lpLibFileName: LPCSTR): HMODULE {.winapi, stdcall, dynlib: "kernel32", importc: "LoadLibraryA".}
  proc QueryFullProcessImageName*(hProcess: HANDLE, dwFlags: DWORD, lpExeName: LPSTR, lpdwSize: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "QueryFullProcessImageNameA".}
  proc FatalAppExit*(uAction: UINT, lpMessageText: LPCSTR): VOID {.winapi, stdcall, dynlib: "kernel32", importc: "FatalAppExitA".}
  proc GetFirmwareEnvironmentVariable*(lpName: LPCSTR, lpGuid: LPCSTR, pBuffer: PVOID, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFirmwareEnvironmentVariableA".}
  proc SetFirmwareEnvironmentVariable*(lpName: LPCSTR, lpGuid: LPCSTR, pValue: PVOID, nSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFirmwareEnvironmentVariableA".}
  proc FindResource*(hModule: HMODULE, lpName: LPCSTR, lpType: LPCSTR): HRSRC {.winapi, stdcall, dynlib: "kernel32", importc: "FindResourceA".}
  proc EnumResourceTypes*(hModule: HMODULE, lpEnumFunc: ENUMRESTYPEPROCA, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceTypesA".}
  proc EnumResourceNames*(hModule: HMODULE, lpType: LPCSTR, lpEnumFunc: ENUMRESNAMEPROCA, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumResourceNamesA".}
  proc BeginUpdateResource*(pFileName: LPCSTR, bDeleteExistingResources: WINBOOL): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "BeginUpdateResourceA".}
  proc UpdateResource*(hUpdate: HANDLE, lpType: LPCSTR, lpName: LPCSTR, wLanguage: WORD, lpData: LPVOID, cb: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "UpdateResourceA".}
  proc EndUpdateResource*(hUpdate: HANDLE, fDiscard: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EndUpdateResourceA".}
  proc GlobalAddAtom*(lpString: LPCSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalAddAtomA".}
  proc GlobalAddAtomEx*(lpString: LPCSTR, Flags: DWORD): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalAddAtomExA".}
  proc GlobalFindAtom*(lpString: LPCSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalFindAtomA".}
  proc GlobalGetAtomName*(nAtom: ATOM, lpBuffer: LPSTR, nSize: int32): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GlobalGetAtomNameA".}
  proc AddAtom*(lpString: LPCSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "AddAtomA".}
  proc FindAtom*(lpString: LPCSTR): ATOM {.winapi, stdcall, dynlib: "kernel32", importc: "FindAtomA".}
  proc GetAtomName*(nAtom: ATOM, lpBuffer: LPSTR, nSize: int32): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetAtomNameA".}
  proc GetProfileInt*(lpAppName: LPCSTR, lpKeyName: LPCSTR, nDefault: INT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetProfileIntA".}
  proc GetProfileString*(lpAppName: LPCSTR, lpKeyName: LPCSTR, lpDefault: LPCSTR, lpReturnedString: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetProfileStringA".}
  proc WriteProfileString*(lpAppName: LPCSTR, lpKeyName: LPCSTR, lpString: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteProfileStringA".}
  proc GetProfileSection*(lpAppName: LPCSTR, lpReturnedString: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetProfileSectionA".}
  proc WriteProfileSection*(lpAppName: LPCSTR, lpString: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteProfileSectionA".}
  proc GetPrivateProfileInt*(lpAppName: LPCSTR, lpKeyName: LPCSTR, nDefault: INT, lpFileName: LPCSTR): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileIntA".}
  proc GetPrivateProfileString*(lpAppName: LPCSTR, lpKeyName: LPCSTR, lpDefault: LPCSTR, lpReturnedString: LPSTR, nSize: DWORD, lpFileName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileStringA".}
  proc WritePrivateProfileString*(lpAppName: LPCSTR, lpKeyName: LPCSTR, lpString: LPCSTR, lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WritePrivateProfileStringA".}
  proc GetPrivateProfileSection*(lpAppName: LPCSTR, lpReturnedString: LPSTR, nSize: DWORD, lpFileName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileSectionA".}
  proc WritePrivateProfileSection*(lpAppName: LPCSTR, lpString: LPCSTR, lpFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WritePrivateProfileSectionA".}
  proc GetPrivateProfileSectionNames*(lpszReturnBuffer: LPSTR, nSize: DWORD, lpFileName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileSectionNamesA".}
  proc GetPrivateProfileStruct*(lpszSection: LPCSTR, lpszKey: LPCSTR, lpStruct: LPVOID, uSizeStruct: UINT, szFile: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetPrivateProfileStructA".}
  proc WritePrivateProfileStruct*(lpszSection: LPCSTR, lpszKey: LPCSTR, lpStruct: LPVOID, uSizeStruct: UINT, szFile: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WritePrivateProfileStructA".}
  proc GetFirmwareEnvironmentVariableEx*(lpName: LPCSTR, lpGuid: LPCSTR, pBuffer: PVOID, nSize: DWORD, pdwAttribubutes: PDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFirmwareEnvironmentVariableExA".}
  proc SetFirmwareEnvironmentVariableEx*(lpName: LPCSTR, lpGuid: LPCSTR, pValue: PVOID, nSize: DWORD, dwAttributes: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFirmwareEnvironmentVariableExA".}
  proc GetSystemWow64Directory*(lpBuffer: LPSTR, uSize: UINT): UINT {.winapi, stdcall, dynlib: "kernel32", importc: "GetSystemWow64DirectoryA".}
  proc SetDllDirectory*(lpPathName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetDllDirectoryA".}
  proc GetDllDirectory*(nBufferLength: DWORD, lpBuffer: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetDllDirectoryA".}
  proc CreateDirectoryEx*(lpTemplateDirectory: LPCSTR, lpNewDirectory: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateDirectoryExA".}
  proc CreateDirectoryTransacted*(lpTemplateDirectory: LPCSTR, lpNewDirectory: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateDirectoryTransactedA".}
  proc RemoveDirectoryTransacted*(lpPathName: LPCSTR, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "RemoveDirectoryTransactedA".}
  proc GetFullPathNameTransacted*(lpFileName: LPCSTR, nBufferLength: DWORD, lpBuffer: LPSTR, lpFilePart: ptr LPSTR, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetFullPathNameTransactedA".}
  proc CreateFileTransacted*(lpFileName: LPCSTR, dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, dwCreationDisposition: DWORD, dwFlagsAndAttributes: DWORD, hTemplateFile: HANDLE, hTransaction: HANDLE, pusMiniVersion: PUSHORT, lpExtendedParameter: PVOID): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateFileTransactedA".}
  proc SetFileAttributesTransacted*(lpFileName: LPCSTR, dwFileAttributes: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetFileAttributesTransactedA".}
  proc GetFileAttributesTransacted*(lpFileName: LPCSTR, fInfoLevelId: GET_FILEEX_INFO_LEVELS, lpFileInformation: LPVOID, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetFileAttributesTransactedA".}
  proc GetCompressedFileSize*(lpFileName: LPCSTR, lpFileSizeHigh: LPDWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetCompressedFileSizeA".}
  proc DeleteFileTransacted*(lpFileName: LPCSTR, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DeleteFileTransactedA".}
  proc GetCompressedFileSizeTransacted*(lpFileName: LPCSTR, lpFileSizeHigh: LPDWORD, hTransaction: HANDLE): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetCompressedFileSizeTransactedA".}
  proc FindFirstFileTransacted*(lpFileName: LPCSTR, fInfoLevelId: FINDEX_INFO_LEVELS, lpFindFileData: LPVOID, fSearchOp: FINDEX_SEARCH_OPS, lpSearchFilter: LPVOID, dwAdditionalFlags: DWORD, hTransaction: HANDLE): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstFileTransactedA".}
  proc CopyFileTransacted*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, pbCancel: LPBOOL, dwCopyFlags: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CopyFileTransactedA".}
  proc CheckNameLegalDOS8Dot3*(lpName: LPCSTR, lpOemName: LPSTR, OemNameSize: DWORD, pbNameContainsSpaces: PBOOL, pbNameLegal: PBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CheckNameLegalDOS8Dot3A".}
  proc CopyFile*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, bFailIfExists: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CopyFileA".}
  proc CopyFileEx*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, pbCancel: LPBOOL, dwCopyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CopyFileExA".}
  proc MoveFile*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "MoveFileA".}
  proc MoveFileEx*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "MoveFileExA".}
  proc MoveFileWithProgress*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "MoveFileWithProgressA".}
  proc MoveFileTransacted*(lpExistingFileName: LPCSTR, lpNewFileName: LPCSTR, lpProgressRoutine: LPPROGRESS_ROUTINE, lpData: LPVOID, dwFlags: DWORD, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "MoveFileTransactedA".}
  proc ReplaceFile*(lpReplacedFileName: LPCSTR, lpReplacementFileName: LPCSTR, lpBackupFileName: LPCSTR, dwReplaceFlags: DWORD, lpExclude: LPVOID, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReplaceFileA".}
  proc CreateHardLink*(lpFileName: LPCSTR, lpExistingFileName: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateHardLinkA".}
  proc CreateHardLinkTransacted*(lpFileName: LPCSTR, lpExistingFileName: LPCSTR, lpSecurityAttributes: LPSECURITY_ATTRIBUTES, hTransaction: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CreateHardLinkTransactedA".}
  proc GetNamedPipeHandleState*(hNamedPipe: HANDLE, lpState: LPDWORD, lpCurInstances: LPDWORD, lpMaxCollectionCount: LPDWORD, lpCollectDataTimeout: LPDWORD, lpUserName: LPSTR, nMaxUserNameSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetNamedPipeHandleStateA".}
  proc CallNamedPipe*(lpNamedPipeName: LPCSTR, lpInBuffer: LPVOID, nInBufferSize: DWORD, lpOutBuffer: LPVOID, nOutBufferSize: DWORD, lpBytesRead: LPDWORD, nTimeOut: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CallNamedPipeA".}
  proc SetVolumeLabel*(lpRootPathName: LPCSTR, lpVolumeName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetVolumeLabelA".}
  proc ClearEventLog*(hEventLog: HANDLE, lpBackupFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ClearEventLogA".}
  proc BackupEventLog*(hEventLog: HANDLE, lpBackupFileName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "BackupEventLogA".}
  proc OpenEventLog*(lpUNCServerName: LPCSTR, lpSourceName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "OpenEventLogA".}
  proc RegisterEventSource*(lpUNCServerName: LPCSTR, lpSourceName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "RegisterEventSourceA".}
  proc OpenBackupEventLog*(lpUNCServerName: LPCSTR, lpFileName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "advapi32", importc: "OpenBackupEventLogA".}
  proc ReadEventLog*(hEventLog: HANDLE, dwReadFlags: DWORD, dwRecordOffset: DWORD, lpBuffer: LPVOID, nNumberOfBytesToRead: DWORD, pnBytesRead: ptr DWORD, pnMinNumberOfBytesNeeded: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ReadEventLogA".}
  proc ReportEvent*(hEventLog: HANDLE, wType: WORD, wCategory: WORD, dwEventID: DWORD, lpUserSid: PSID, wNumStrings: WORD, dwDataSize: DWORD, lpStrings: ptr LPCSTR, lpRawData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "ReportEventA".}
  proc IsBadStringPtr*(lpsz: LPCSTR, ucchMax: UINT_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "IsBadStringPtrA".}
  proc LookupPrivilegeValue*(lpSystemName: LPCSTR, lpName: LPCSTR, lpLuid: PLUID): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupPrivilegeValueA".}
  proc LookupPrivilegeName*(lpSystemName: LPCSTR, lpLuid: PLUID, lpName: LPSTR, cchName: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupPrivilegeNameA".}
  proc LookupPrivilegeDisplayName*(lpSystemName: LPCSTR, lpName: LPCSTR, lpDisplayName: LPSTR, cchDisplayName: LPDWORD, lpLanguageId: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LookupPrivilegeDisplayNameA".}
  proc BuildCommDCB*(lpDef: LPCSTR, lpDCB: LPDCB): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "BuildCommDCBA".}
  proc BuildCommDCBAndTimeouts*(lpDef: LPCSTR, lpDCB: LPDCB, lpCommTimeouts: LPCOMMTIMEOUTS): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "BuildCommDCBAndTimeoutsA".}
  proc CommConfigDialog*(lpszName: LPCSTR, hWnd: HWND, lpCC: LPCOMMCONFIG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "CommConfigDialogA".}
  proc GetDefaultCommConfig*(lpszName: LPCSTR, lpCC: LPCOMMCONFIG, lpdwSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetDefaultCommConfigA".}
  proc SetDefaultCommConfig*(lpszName: LPCSTR, lpCC: LPCOMMCONFIG, dwSize: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetDefaultCommConfigA".}
  proc GetComputerName*(lpBuffer: LPSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetComputerNameA".}
  proc SetComputerName*(lpComputerName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetComputerNameA".}
  proc DnsHostnameToComputerName*(Hostname: LPCSTR, ComputerName: LPSTR, nSize: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "DnsHostnameToComputerNameA".}
  proc GetUserName*(lpBuffer: LPSTR, pcbBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetUserNameA".}
  proc LogonUser*(lpszUsername: LPCSTR, lpszDomain: LPCSTR, lpszPassword: LPCSTR, dwLogonType: DWORD, dwLogonProvider: DWORD, phToken: PHANDLE): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LogonUserA".}
  proc LogonUserEx*(lpszUsername: LPCSTR, lpszDomain: LPCSTR, lpszPassword: LPCSTR, dwLogonType: DWORD, dwLogonProvider: DWORD, phToken: PHANDLE, ppLogonSid: ptr PSID, ppProfileBuffer: ptr PVOID, pdwProfileLength: LPDWORD, pQuotaLimits: PQUOTA_LIMITS): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "LogonUserExA".}
  proc CreatePrivateNamespace*(lpPrivateNamespaceAttributes: LPSECURITY_ATTRIBUTES, lpBoundaryDescriptor: LPVOID, lpAliasPrefix: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreatePrivateNamespaceA".}
  proc OpenPrivateNamespace*(lpBoundaryDescriptor: LPVOID, lpAliasPrefix: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenPrivateNamespaceA".}
  proc CreateBoundaryDescriptor*(Name: LPCSTR, Flags: ULONG): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateBoundaryDescriptorA".}
  proc GetCurrentHwProfile*(lpHwProfileInfo: LPHW_PROFILE_INFOA): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc: "GetCurrentHwProfileA".}
  proc VerifyVersionInfo*(lpVersionInformation: LPOSVERSIONINFOEXA, dwTypeMask: DWORD, dwlConditionMask: DWORDLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "VerifyVersionInfoA".}
  proc CreateJobObject*(lpJobAttributes: LPSECURITY_ATTRIBUTES, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateJobObjectA".}
  proc OpenJobObject*(dwDesiredAccess: DWORD, bInheritHandle: WINBOOL, lpName: LPCSTR): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "OpenJobObjectA".}
  proc FindFirstVolumeMountPoint*(lpszRootPathName: LPCSTR, lpszVolumeMountPoint: LPSTR, cchBufferLength: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "FindFirstVolumeMountPointA".}
  proc FindNextVolumeMountPoint*(hFindVolumeMountPoint: HANDLE, lpszVolumeMountPoint: LPSTR, cchBufferLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FindNextVolumeMountPointA".}
  proc SetVolumeMountPoint*(lpszVolumeMountPoint: LPCSTR, lpszVolumeName: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetVolumeMountPointA".}
  proc CreateActCtx*(pActCtx: PCACTCTXA): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc: "CreateActCtxA".}
  proc FindActCtxSectionString*(dwFlags: DWORD, lpExtensionGuid: ptr GUID, ulSectionId: ULONG, lpStringToFind: LPCSTR, ReturnedData: PACTCTX_SECTION_KEYED_DATA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FindActCtxSectionStringA".}
  proc CreateSymbolicLink*(lpSymlinkFileName: LPCSTR, lpTargetFileName: LPCSTR, dwFlags: DWORD): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc: "CreateSymbolicLinkA".}
  proc CreateSymbolicLinkTransacted*(lpSymlinkFileName: LPCSTR, lpTargetFileName: LPCSTR, dwFlags: DWORD, hTransaction: HANDLE): BOOLEAN {.winapi, stdcall, dynlib: "kernel32", importc: "CreateSymbolicLinkTransactedA".}
  proc LookupAccountNameLocal*(lpAccountName: LPCSTR, Sid: PSID, cbSid: LPDWORD, ReferencedDomainName: LPSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, inline.} = LookupAccountNameA(nil, lpAccountName, Sid, cbSid, ReferencedDomainName, cchReferencedDomainName, peUse)
  proc LookupAccountSidLocal*(Sid: PSID, Name: LPSTR, cchName: LPDWORD, ReferencedDomainName: LPSTR, cchReferencedDomainName: LPDWORD, peUse: PSID_NAME_USE): WINBOOL {.winapi, inline.} = LookupAccountSidA(nil, Sid, Name, cchName, ReferencedDomainName, cchReferencedDomainName, peUse)
when winimCpu64:
  const
    SCS_THIS_PLATFORM_BINARY* = SCS_64BIT_BINARY
  proc GetEnabledXStateFeatures*(): DWORD64 {.winapi, stdcall, dynlib: "kernel32", importc.}
  proc GetXStateFeaturesMask*(Context: PCONTEXT, FeatureMask: PDWORD64): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
  proc LocateXStateFeature*(Context: PCONTEXT, FeatureId: DWORD, Length: PDWORD): PVOID {.winapi, stdcall, dynlib: "kernel32", importc.}
  proc SetXStateFeaturesMask*(Context: PCONTEXT, FeatureMask: DWORD64): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
when winimCpu32:
  const
    SCS_THIS_PLATFORM_BINARY* = SCS_32BIT_BINARY
