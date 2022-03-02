#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
#include <ntdef.h>
#include <basetsd.h>
#include <excpt.h>
#include <ntstatus.h>
#include <windef.h>
#include <minwindef.h>
#include <winnt.h>
#include <guiddef.h>
#include <ktmtypes.h>
#include <winternl.h>
type
  INT8* = int8
  PINT8* = ptr int8
  INT32* = int32
  PINT32* = ptr int32
  INT64* = int64
  PINT64* = ptr int64
  UINT8* = uint8
  PUINT8* = ptr uint8
  UINT16* = uint16
  PUINT16* = ptr uint16
  UINT32* = int32
  PUINT32* = ptr int32
  UINT64* = int64
  PUINT64* = ptr int64
  LONG32* = int32
  PLONG32* = ptr int32
  ULONG32* = int32
  PULONG32* = ptr int32
  DWORD32* = int32
  PDWORD32* = ptr int32
  LONG64* = int64
  PLONG64* = ptr int64
  ULONG64* = int64
  PULONG64* = ptr int64
  DWORD64* = int64
  PDWORD64* = ptr int64
  PVOID* = pointer
  CHAR* = char
  LONG* = int32
  INT* = int32
  UCHAR* = uint8
  PUCHAR* = ptr uint8
  USHORT* = uint16
  PUSHORT* = ptr uint16
  ULONG* = int32
  PULONG* = ptr int32
  SCHAR* = int8
  WINBOOL* = int32
  BOOL* = int32
  LONGLONG* = int64
  PLONGLONG* = ptr int64
  ULONGLONG* = int64
  PULONGLONG* = ptr int64
  PCSZ* = ptr char
  WCHAR* = uint16
  CCHAR* = char
  PCCHAR* = ptr char
  NT_PRODUCT_TYPE* = int32
  PNT_PRODUCT_TYPE* = ptr int32
  EVENT_TYPE* = int32
  TIMER_TYPE* = int32
  WAIT_TYPE* = int32
  BYTE* = uint8
  WORD* = uint16
  DWORD* = int32
  PINT* = ptr int32
  LPINT* = ptr int32
  LPLONG* = ptr int32
  LPVOID* = pointer
  LPCVOID* = pointer
  UINT* = int32
  PUINT* = ptr int32
  UCSCHAR* = int32
  COMPARTMENT_ID* = int32
  PCOMPARTMENT_ID* = ptr int32
  SID_NAME_USE* = int32
  PSID_NAME_USE* = ptr int32
  WELL_KNOWN_SID_TYPE* = int32
  ACL_INFORMATION_CLASS* = int32
  AUDIT_EVENT_TYPE* = int32
  PAUDIT_EVENT_TYPE* = ptr int32
  ACCESS_REASON_TYPE* = int32
  SECURITY_IMPERSONATION_LEVEL* = int32
  PSECURITY_IMPERSONATION_LEVEL* = ptr int32
  TOKEN_TYPE* = int32
  TOKEN_ELEVATION_TYPE* = int32
  PTOKEN_ELEVATION_TYPE* = ptr int32
  TOKEN_INFORMATION_CLASS* = int32
  PTOKEN_INFORMATION_CLASS* = ptr int32
  MANDATORY_LEVEL* = int32
  PMANDATORY_LEVEL* = ptr int32
  SE_LEARNING_MODE_DATA_TYPE* = int32
  HARDWARE_COUNTER_TYPE* = int32
  PHARDWARE_COUNTER_TYPE* = ptr int32
  PROCESS_MITIGATION_POLICY* = int32
  PPROCESS_MITIGATION_POLICY* = ptr int32
  JOBOBJECT_RATE_CONTROL_TOLERANCE* = int32
  JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL* = int32
  JOBOBJECTINFOCLASS* = int32
  FIRMWARE_TYPE* = int32
  PFIRMWARE_TYPE* = ptr int32
  LOGICAL_PROCESSOR_RELATIONSHIP* = int32
  PROCESSOR_CACHE_TYPE* = int32
  SYSTEM_POWER_STATE* = int32
  PSYSTEM_POWER_STATE* = ptr int32
  POWER_ACTION* = int32
  PPOWER_ACTION* = ptr int32
  DEVICE_POWER_STATE* = int32
  PDEVICE_POWER_STATE* = ptr int32
  MONITOR_DISPLAY_STATE* = int32
  PMONITOR_DISPLAY_STATE* = ptr int32
  USER_ACTIVITY_PRESENCE* = int32
  PUSER_ACTIVITY_PRESENCE* = ptr int32
  LATENCY_TIME* = int32
  POWER_REQUEST_TYPE* = int32
  PPOWER_REQUEST_TYPE* = ptr int32
  POWER_INFORMATION_LEVEL* = int32
  POWER_USER_PRESENCE_TYPE* = int32
  PPOWER_USER_PRESENCE_TYPE* = ptr int32
  POWER_MONITOR_REQUEST_REASON* = int32
  SYSTEM_POWER_CONDITION* = int32
  POWER_PLATFORM_ROLE* = int32
  PPOWER_PLATFORM_ROLE* = ptr int32
  IMAGE_AUX_SYMBOL_TYPE* = int32
  IMPORT_OBJECT_TYPE* = int32
  IMPORT_OBJECT_NAME_TYPE* = int32
  ReplacesCorHdrNumericDefines* = int32
  RTL_UMS_THREAD_INFO_CLASS* = int32
  PRTL_UMS_THREAD_INFO_CLASS* = ptr int32
  RTL_UMS_SCHEDULER_REASON* = int32
  PRTL_UMS_SCHEDULER_REASON* = ptr int32
  HEAP_INFORMATION_CLASS* = int32
  ACTIVATION_CONTEXT_INFO_CLASS* = int32
  ACTCTX_REQUESTED_RUN_LEVEL* = int32
  ACTCTX_COMPATIBILITY_ELEMENT_TYPE* = int32
  SERVICE_NODE_TYPE* = int32
  SERVICE_LOAD_TYPE* = int32
  SERVICE_ERROR_TYPE* = int32
  TAPE_DRIVE_PROBLEM_TYPE* = int32
  TP_CALLBACK_PRIORITY* = int32
  TRANSACTION_OUTCOME* = int32
  TRANSACTION_STATE* = int32
  TRANSACTION_INFORMATION_CLASS* = int32
  TRANSACTIONMANAGER_INFORMATION_CLASS* = int32
  RESOURCEMANAGER_INFORMATION_CLASS* = int32
  ENLISTMENT_INFORMATION_CLASS* = int32
  KTMOBJECT_TYPE* = int32
  PKTMOBJECT_TYPE* = ptr int32
  HFILE* = int32
  FILE_INFORMATION_CLASS* = int32
  PFILE_INFORMATION_CLASS* = ptr int32
  FS_INFORMATION_CLASS* = int32
  PFS_INFORMATION_CLASS* = ptr int32
  THREAD_STATE* = int32
  KWAIT_REASON* = int32
  PROCESSINFOCLASS* = int32
  THREADINFOCLASS* = int32
  SYSTEM_INFORMATION_CLASS* = int32
  OBJECT_INFORMATION_CLASS* = int32
  POBJECT_INFORMATION_CLASS* = ptr int32
  WINSTATIONINFOCLASS* = int32
  HANDLE* = int
  VOID* = void
  PVOID64* = pointer
  va_list* = pointer
  FARPROC* = pointer
  NEARPROC* = pointer
  PROC* = pointer
  EXCEPTION_DISPOSITION* = int
  QWORD* = int64
  PQWORD* = ptr int64
when winimAnsi:
  type
    TCHAR* = char
    PTCHAR* = ptr char
    TBYTE* = uint8
    PTBYTE* = ptr uint8
when winimCpu64:
  type
    INT_PTR* = int64
    PINT_PTR* = ptr int64
    UINT_PTR* = int64
    PUINT_PTR* = ptr int64
    LONG_PTR* = int64
    PLONG_PTR* = ptr int64
    ULONG_PTR* = int64
    PULONG_PTR* = ptr int64
    SHANDLE_PTR* = int64
    HANDLE_PTR* = int64
    UHALF_PTR* = int32
    PUHALF_PTR* = ptr int32
    HALF_PTR* = int32
    PHALF_PTR* = ptr int32
when winimCpu32:
  type
    INT_PTR* = int32
    PINT_PTR* = ptr int32
    UINT_PTR* = int32
    PUINT_PTR* = ptr int32
    LONG_PTR* = int32
    PLONG_PTR* = ptr int32
    ULONG_PTR* = int32
    PULONG_PTR* = ptr int32
    UHALF_PTR* = uint16
    PUHALF_PTR* = ptr uint16
    SHANDLE_PTR* = int32
    HANDLE_PTR* = int32
type
  SIZE_T* = ULONG_PTR
  PSIZE_T* = ptr ULONG_PTR
  SSIZE_T* = LONG_PTR
  PSSIZE_T* = ptr LONG_PTR
  DWORD_PTR* = ULONG_PTR
  PDWORD_PTR* = ptr ULONG_PTR
  KAFFINITY* = ULONG_PTR
  PHANDLE* = ptr HANDLE
  PCUCHAR* = ptr UCHAR
  PCUSHORT* = ptr USHORT
  PCULONG* = ptr ULONG
  FCHAR* = UCHAR
  FSHORT* = USHORT
  FLONG* = ULONG
  BOOLEAN* = UCHAR
  PBOOLEAN* = ptr UCHAR
  LOGICAL* = ULONG
  PLOGICAL* = ptr ULONG
  SHORT* = int16
  PSHORT* = ptr SHORT
  PLONG* = ptr LONG
  NTSTATUS* = LONG
  PSCHAR* = ptr SCHAR
  PBOOL* = ptr BOOL
  LPBOOL* = ptr BOOL
  HRESULT* = LONG
  DWORDLONG* = ULONGLONG
  PDWORDLONG* = ptr ULONGLONG
  USN* = LONGLONG
  PCHAR* = ptr CHAR
  LPCH* = ptr CHAR
  PCH* = ptr CHAR
  LPCCH* = ptr CHAR
  PCCH* = ptr CHAR
  NPSTR* = ptr CHAR
  LPSTR* = ptr CHAR
  PSTR* = ptr CHAR
  PZPSTR* = ptr PSTR
  PCZPSTR* = ptr PSTR
  LPCSTR* = ptr CHAR
  PCSTR* = ptr CHAR
  PZPCSTR* = ptr PCSTR
  PSZ* = ptr CHAR
  PWCHAR* = ptr WCHAR
  LPWCH* = ptr WCHAR
  PWCH* = ptr WCHAR
  LPCWCH* = ptr WCHAR
  PCWCH* = ptr WCHAR
  NWPSTR* = ptr WCHAR
  LPWSTR* = ptr WCHAR
  PWSTR* = ptr WCHAR
  PZPWSTR* = ptr PWSTR
  PCZPWSTR* = ptr PWSTR
  LPUWSTR* = ptr WCHAR
  PUWSTR* = ptr WCHAR
  LPCWSTR* = ptr WCHAR
  PCWSTR* = ptr WCHAR
  PZPCWSTR* = ptr PCWSTR
  LPCUWSTR* = ptr WCHAR
  PCUWSTR* = ptr WCHAR
  CLONG* = ULONG
  PCLONG* = ptr ULONG
  LCID* = ULONG
  PLCID* = PULONG
  LANGID* = USHORT
  FLOAT* = float32
  PFLOAT* = ptr FLOAT
  PBYTE* = ptr BYTE
  LPBYTE* = ptr BYTE
  PWORD* = ptr WORD
  LPWORD* = ptr WORD
  PDWORD* = ptr DWORD
  LPDWORD* = ptr DWORD
  PZZWSTR* = ptr WCHAR
  PCZZWSTR* = ptr WCHAR
  PUZZWSTR* = ptr WCHAR
  PCUZZWSTR* = ptr WCHAR
  PNZWCH* = ptr WCHAR
  PCNZWCH* = ptr WCHAR
  PUNZWCH* = ptr WCHAR
  PCUNZWCH* = ptr WCHAR
  LPCWCHAR* = ptr WCHAR
  PCWCHAR* = ptr WCHAR
  LPCUWCHAR* = ptr WCHAR
  PCUWCHAR* = ptr WCHAR
  PUCSCHAR* = ptr UCSCHAR
  PCUCSCHAR* = ptr UCSCHAR
  PUCSSTR* = ptr UCSCHAR
  PUUCSSTR* = ptr UCSCHAR
  PCUCSSTR* = ptr UCSCHAR
  PCUUCSSTR* = ptr UCSCHAR
  PUUCSCHAR* = ptr UCSCHAR
  PCUUCSCHAR* = ptr UCSCHAR
  PZZSTR* = ptr CHAR
  PCZZSTR* = ptr CHAR
  PNZCH* = ptr CHAR
  PCNZCH* = ptr CHAR
  KSPIN_LOCK* = ULONG_PTR
  PACCESS_TOKEN* = PVOID
  PSECURITY_DESCRIPTOR* = PVOID
  PSID* = PVOID
  PCLAIMS_BLOB* = PVOID
  ACCESS_MASK* = DWORD
  SID_HASH_ENTRY* = ULONG_PTR
  PSID_HASH_ENTRY* = ptr ULONG_PTR
  SECURITY_DESCRIPTOR_CONTROL* = WORD
  PSECURITY_DESCRIPTOR_CONTROL* = ptr WORD
  ACCESS_REASON* = DWORD
  SECURITY_CONTEXT_TRACKING_MODE* = BOOLEAN
  PSECURITY_CONTEXT_TRACKING_MODE* = ptr BOOLEAN
  SECURITY_INFORMATION* = DWORD
  PSECURITY_INFORMATION* = ptr DWORD
  EXECUTION_STATE* = DWORD
  PEXECUTION_STATE* = ptr DWORD
  TP_VERSION* = DWORD
  PTP_VERSION* = ptr DWORD
  TP_WAIT_RESULT* = DWORD
  NOTIFICATION_MASK* = ULONG
  SAVEPOINT_ID* = ULONG
  PSAVEPOINT_ID* = ptr ULONG
  WPARAM* = UINT_PTR
  LPARAM* = LONG_PTR
  LRESULT* = LONG_PTR
  SPHANDLE* = ptr HANDLE
  LPHANDLE* = ptr HANDLE
  HGLOBAL* = HANDLE
  HLOCAL* = HANDLE
  ATOM* = WORD
  HINSTANCE* = HANDLE
  HKEY* = HANDLE
  HKL* = HANDLE
  HLSURF* = HANDLE
  HMETAFILE* = HANDLE
  HMODULE* = HINSTANCE
  HRGN* = HANDLE
  HRSRC* = HANDLE
  HSPRITE* = HANDLE
  HSTR* = HANDLE
  HTASK* = HANDLE
  HWINSTA* = HANDLE
  HWND* = HANDLE
  HHOOK* = HANDLE
  HEVENT* = HANDLE
  HACCEL* = HANDLE
  HBITMAP* = HANDLE
  HBRUSH* = HANDLE
  HCOLORSPACE* = HANDLE
  HDC* = HANDLE
  HGLRC* = HANDLE
  HDESK* = HANDLE
  HENHMETAFILE* = HANDLE
  HFONT* = HANDLE
  HICON* = HANDLE
  HMENU* = HANDLE
  HPALETTE* = HANDLE
  HPEN* = HANDLE
  HMONITOR* = HANDLE
  HWINEVENTHOOK* = HANDLE
  HCURSOR* = HICON
  COLORREF* = DWORD
  HUMPD* = HANDLE
  LPCOLORREF* = ptr DWORD
  DEVICE_TYPE* = ULONG
  KPRIORITY* = LONG
  HGDIOBJ* = HANDLE
  OLECHAR* = WCHAR
when winimUnicode:
  type
    TCHAR* = WCHAR
    PTCHAR* = ptr WCHAR
    TBYTE* = WCHAR
    PTBYTE* = ptr WCHAR
    LPTCH* = LPWSTR
    PTCH* = LPWSTR
    PTSTR* = LPWSTR
    LPTSTR* = LPWSTR
    PCTSTR* = LPCWSTR
    LPCTSTR* = LPCWSTR
    PUTSTR* = LPUWSTR
    LPUTSTR* = LPUWSTR
    PCUTSTR* = LPCUWSTR
    LPCUTSTR* = LPCUWSTR
    LP* = LPWSTR
    PZZTSTR* = PZZWSTR
    PUZZTSTR* = PUZZWSTR
    PZPTSTR* = PZPWSTR
    PUNZTCH* = PUNZWCH
when winimAnsi:
  type
    LPTCH* = LPSTR
    PTCH* = LPSTR
    LPCTCH* = LPCCH
    PCTCH* = LPCCH
    PTSTR* = LPSTR
    LPTSTR* = LPSTR
    PUTSTR* = LPSTR
    LPUTSTR* = LPSTR
    PCTSTR* = LPCSTR
    LPCTSTR* = LPCSTR
    PCUTSTR* = LPCSTR
    LPCUTSTR* = LPCSTR
    PZZTSTR* = PZZSTR
    PUZZTSTR* = PZZSTR
    PZPTSTR* = PZPSTR
type
  INT16* = int16
  PINT16* = ptr int16
  PKAFFINITY* = ptr KAFFINITY
const
  EXCEPTION_MAXIMUM_PARAMETERS* = 15
type
  EXCEPTION_RECORD* {.pure.} = object
    ExceptionCode*: DWORD
    ExceptionFlags*: DWORD
    ExceptionRecord*: ptr EXCEPTION_RECORD
    ExceptionAddress*: PVOID
    NumberParameters*: DWORD
    ExceptionInformation*: array[EXCEPTION_MAXIMUM_PARAMETERS, ULONG_PTR]
  PEXCEPTION_RECORD* = ptr EXCEPTION_RECORD
  M128A* {.pure.} = object
    Low*: ULONGLONG
    High*: LONGLONG
when winimCpu64:
  type
    XMM_SAVE_AREA32* {.pure.} = object
      ControlWord*: WORD
      StatusWord*: WORD
      TagWord*: BYTE
      Reserved1*: BYTE
      ErrorOpcode*: WORD
      ErrorOffset*: DWORD
      ErrorSelector*: WORD
      Reserved2*: WORD
      DataOffset*: DWORD
      DataSelector*: WORD
      Reserved3*: WORD
      MxCsr*: DWORD
      MxCsr_Mask*: DWORD
      FloatRegisters*: array[8, M128A]
      XmmRegisters*: array[16, M128A]
      Reserved4*: array[96, BYTE]
    CONTEXT_UNION1_STRUCT1* {.pure.} = object
      Header*: array[2, M128A]
      Legacy*: array[8, M128A]
      Xmm0*: M128A
      Xmm1*: M128A
      Xmm2*: M128A
      Xmm3*: M128A
      Xmm4*: M128A
      Xmm5*: M128A
      Xmm6*: M128A
      Xmm7*: M128A
      Xmm8*: M128A
      Xmm9*: M128A
      Xmm10*: M128A
      Xmm11*: M128A
      Xmm12*: M128A
      Xmm13*: M128A
      Xmm14*: M128A
      Xmm15*: M128A
    CONTEXT_UNION1* {.pure, union.} = object
      FltSave*: XMM_SAVE_AREA32
      FloatSave*: XMM_SAVE_AREA32
      struct1*: CONTEXT_UNION1_STRUCT1
    CONTEXT* {.pure.} = object
      P1Home*: DWORD64
      P2Home*: DWORD64
      P3Home*: DWORD64
      P4Home*: DWORD64
      P5Home*: DWORD64
      P6Home*: DWORD64
      ContextFlags*: DWORD
      MxCsr*: DWORD
      SegCs*: WORD
      SegDs*: WORD
      SegEs*: WORD
      SegFs*: WORD
      SegGs*: WORD
      SegSs*: WORD
      EFlags*: DWORD
      Dr0*: DWORD64
      Dr1*: DWORD64
      Dr2*: DWORD64
      Dr3*: DWORD64
      Dr6*: DWORD64
      Dr7*: DWORD64
      Rax*: DWORD64
      Rcx*: DWORD64
      Rdx*: DWORD64
      Rbx*: DWORD64
      Rsp*: DWORD64
      Rbp*: DWORD64
      Rsi*: DWORD64
      Rdi*: DWORD64
      R8*: DWORD64
      R9*: DWORD64
      R10*: DWORD64
      R11*: DWORD64
      R12*: DWORD64
      R13*: DWORD64
      R14*: DWORD64
      R15*: DWORD64
      Rip*: DWORD64
      union1*: CONTEXT_UNION1
      VectorRegister*: array[26, M128A]
      VectorControl*: DWORD64
      DebugControl*: DWORD64
      LastBranchToRip*: DWORD64
      LastBranchFromRip*: DWORD64
      LastExceptionToRip*: DWORD64
      LastExceptionFromRip*: DWORD64
when winimCpu32:
  const
    SIZE_OF_80387_REGISTERS* = 80
  type
    FLOATING_SAVE_AREA* {.pure.} = object
      ControlWord*: DWORD
      StatusWord*: DWORD
      TagWord*: DWORD
      ErrorOffset*: DWORD
      ErrorSelector*: DWORD
      DataOffset*: DWORD
      DataSelector*: DWORD
      RegisterArea*: array[SIZE_OF_80387_REGISTERS, BYTE]
      Cr0NpxState*: DWORD
  const
    MAXIMUM_SUPPORTED_EXTENSION* = 512
  type
    CONTEXT* {.pure.} = object
      ContextFlags*: DWORD
      Dr0*: DWORD
      Dr1*: DWORD
      Dr2*: DWORD
      Dr3*: DWORD
      Dr6*: DWORD
      Dr7*: DWORD
      FloatSave*: FLOATING_SAVE_AREA
      SegGs*: DWORD
      SegFs*: DWORD
      SegEs*: DWORD
      SegDs*: DWORD
      Edi*: DWORD
      Esi*: DWORD
      Ebx*: DWORD
      Edx*: DWORD
      Ecx*: DWORD
      Eax*: DWORD
      Ebp*: DWORD
      Eip*: DWORD
      SegCs*: DWORD
      EFlags*: DWORD
      Esp*: DWORD
      SegSs*: DWORD
      ExtendedRegisters*: array[MAXIMUM_SUPPORTED_EXTENSION, BYTE]
when winimCpu64:
  type
    PCONTEXT* = ptr CONTEXT
when winimCpu32:
  type
    PCONTEXT* = ptr CONTEXT
type
  EXCEPTION_POINTERS* {.pure.} = object
    ExceptionRecord*: PEXCEPTION_RECORD
    ContextRecord*: PCONTEXT
  Exception_info_ptr* = ptr EXCEPTION_POINTERS
  DOUBLE* = float64
  PNTSTATUS* = ptr NTSTATUS
  CSHORT* = int16
  PCSHORT* = ptr int16
  QUAD_UNION1* {.pure, union.} = object
    UseThisFieldToCopy*: int64
    DoNotUseThisField*: float64
  QUAD* {.pure.} = object
    union1*: QUAD_UNION1
  PQUAD* = ptr QUAD
  UQUAD* = QUAD
  PUQUAD* = ptr QUAD
  LARGE_INTEGER_STRUCT1* {.pure.} = object
    LowPart*: ULONG
    HighPart*: LONG
  LARGE_INTEGER_u* {.pure.} = object
    LowPart*: ULONG
    HighPart*: LONG
  LARGE_INTEGER* {.pure, union.} = object
    struct1*: LARGE_INTEGER_STRUCT1
    u*: LARGE_INTEGER_u
    QuadPart*: LONGLONG
  PLARGE_INTEGER* = ptr LARGE_INTEGER
  ULARGE_INTEGER_STRUCT1* {.pure.} = object
    LowPart*: ULONG
    HighPart*: ULONG
  ULARGE_INTEGER_u* {.pure.} = object
    LowPart*: ULONG
    HighPart*: ULONG
  ULARGE_INTEGER* {.pure, union.} = object
    struct1*: ULARGE_INTEGER_STRUCT1
    u*: ULARGE_INTEGER_u
    QuadPart*: ULONGLONG
  PULARGE_INTEGER* = ptr ULARGE_INTEGER
  LUID* {.pure.} = object
    LowPart*: ULONG
    HighPart*: LONG
  PLUID* = ptr LUID
  PHYSICAL_ADDRESS* = LARGE_INTEGER
  PPHYSICAL_ADDRESS* = ptr LARGE_INTEGER
  UNICODE_STRING* {.pure.} = object
    Length*: USHORT
    MaximumLength*: USHORT
    Buffer*: PWSTR
  PUNICODE_STRING* = ptr UNICODE_STRING
  PCUNICODE_STRING* = ptr UNICODE_STRING
  CSTRING* {.pure.} = object
    Length*: USHORT
    MaximumLength*: USHORT
    Buffer*: ptr CHAR
  PCSTRING* = ptr CSTRING
  STRING* {.pure.} = object
    Length*: USHORT
    MaximumLength*: USHORT
    Buffer*: PCHAR
  PSTRING* = ptr STRING
  ANSI_STRING* = STRING
  PANSI_STRING* = PSTRING
  OEM_STRING* = STRING
  POEM_STRING* = PSTRING
  PCOEM_STRING* = ptr STRING
  CANSI_STRING* = STRING
  PCANSI_STRING* = PSTRING
  STRING32* {.pure.} = object
    Length*: USHORT
    MaximumLength*: USHORT
    Buffer*: ULONG
  PSTRING32* = ptr STRING32
  UNICODE_STRING32* = STRING32
  PUNICODE_STRING32* = ptr STRING32
  ANSI_STRING32* = STRING32
  PANSI_STRING32* = ptr STRING32
  STRING64* {.pure.} = object
    Length*: USHORT
    MaximumLength*: USHORT
    Buffer*: ULONGLONG
  PSTRING64* = ptr STRING64
  UNICODE_STRING64* = STRING64
  PUNICODE_STRING64* = ptr STRING64
  ANSI_STRING64* = STRING64
  PANSI_STRING64* = ptr STRING64
  OBJECT_ATTRIBUTES* {.pure.} = object
    Length*: ULONG
    RootDirectory*: HANDLE
    ObjectName*: PUNICODE_STRING
    Attributes*: ULONG
    SecurityDescriptor*: PVOID
    SecurityQualityOfService*: PVOID
  POBJECT_ATTRIBUTES* = ptr OBJECT_ATTRIBUTES
  PCOBJECT_ATTRIBUTES* = ptr OBJECT_ATTRIBUTES
  LIST_ENTRY* {.pure.} = object
    Flink*: ptr LIST_ENTRY
    Blink*: ptr LIST_ENTRY
  PLIST_ENTRY* = ptr LIST_ENTRY
  PRLIST_ENTRY* = ptr LIST_ENTRY
  LIST_ENTRY32* {.pure.} = object
    Flink*: ULONG
    Blink*: ULONG
  PLIST_ENTRY32* = ptr LIST_ENTRY32
  LIST_ENTRY64* {.pure.} = object
    Flink*: ULONGLONG
    Blink*: ULONGLONG
  PLIST_ENTRY64* = ptr LIST_ENTRY64
  SINGLE_LIST_ENTRY* {.pure.} = object
    Next*: ptr SINGLE_LIST_ENTRY
  PSINGLE_LIST_ENTRY* = ptr SINGLE_LIST_ENTRY
  PROCESSOR_NUMBER* {.pure.} = object
    Group*: USHORT
    Number*: UCHAR
    Reserved*: UCHAR
  PPROCESSOR_NUMBER* = ptr PROCESSOR_NUMBER
  GROUP_AFFINITY* {.pure.} = object
    Mask*: KAFFINITY
    Group*: USHORT
    Reserved*: array[3, USHORT]
  PGROUP_AFFINITY* = ptr GROUP_AFFINITY
  REPARSE_DATA_BUFFER_UNION1_SymbolicLinkReparseBuffer* {.pure.} = object
    SubstituteNameOffset*: USHORT
    SubstituteNameLength*: USHORT
    PrintNameOffset*: USHORT
    PrintNameLength*: USHORT
    Flags*: ULONG
    PathBuffer*: array[1, WCHAR]
  REPARSE_DATA_BUFFER_UNION1_MountPointReparseBuffer* {.pure.} = object
    SubstituteNameOffset*: USHORT
    SubstituteNameLength*: USHORT
    PrintNameOffset*: USHORT
    PrintNameLength*: USHORT
    PathBuffer*: array[1, WCHAR]
  REPARSE_DATA_BUFFER_UNION1_GenericReparseBuffer* {.pure.} = object
    DataBuffer*: array[1, UCHAR]
  REPARSE_DATA_BUFFER_UNION1* {.pure, union.} = object
    SymbolicLinkReparseBuffer*: REPARSE_DATA_BUFFER_UNION1_SymbolicLinkReparseBuffer
    MountPointReparseBuffer*: REPARSE_DATA_BUFFER_UNION1_MountPointReparseBuffer
    GenericReparseBuffer*: REPARSE_DATA_BUFFER_UNION1_GenericReparseBuffer
  REPARSE_DATA_BUFFER* {.pure.} = object
    ReparseTag*: ULONG
    ReparseDataLength*: USHORT
    Reserved*: USHORT
    union1*: REPARSE_DATA_BUFFER_UNION1
  PREPARSE_DATA_BUFFER* = ptr REPARSE_DATA_BUFFER
  FLOAT128* {.pure.} = object
    LowPart*: int64
    HighPart*: int64
  PFLOAT128* = ptr FLOAT128
  GUID* {.pure.} = object
    Data1*: int32
    Data2*: uint16
    Data3*: uint16
    Data4*: array[8, uint8]
  LPGUID* = ptr GUID
  LPCGUID* = ptr GUID
  IID* = GUID
  LPIID* = ptr IID
  CLSID* = GUID
  LPCLSID* = ptr CLSID
  FMTID* = GUID
  LPFMTID* = ptr FMTID
  REFGUID* = ptr GUID
  REFIID* = ptr IID
  REFCLSID* = ptr IID
  REFFMTID* = ptr IID
  EXCEPTION_ROUTINE* = proc (ExceptionRecord: ptr EXCEPTION_RECORD, EstablisherFrame: PVOID, ContextRecord: ptr CONTEXT, DispatcherContext: PVOID): EXCEPTION_DISPOSITION {.stdcall.}
  PEXCEPTION_ROUTINE* = EXCEPTION_ROUTINE
  PKSPIN_LOCK* = ptr KSPIN_LOCK
  PM128A* = ptr M128A
  XSAVE_AREA_HEADER* {.pure.} = object
    Mask*: DWORD64
    Reserved*: array[7, DWORD64]
  PXSAVE_AREA_HEADER* = ptr XSAVE_AREA_HEADER
when winimCpu64:
  type
    XSAVE_FORMAT* {.pure.} = object
      ControlWord*: WORD
      StatusWord*: WORD
      TagWord*: BYTE
      Reserved1*: BYTE
      ErrorOpcode*: WORD
      ErrorOffset*: DWORD
      ErrorSelector*: WORD
      Reserved2*: WORD
      DataOffset*: DWORD
      DataSelector*: WORD
      Reserved3*: WORD
      MxCsr*: DWORD
      MxCsr_Mask*: DWORD
      FloatRegisters*: array[8, M128A]
      XmmRegisters*: array[16, M128A]
      Reserved4*: array[96, BYTE]
when winimCpu32:
  type
    XSAVE_FORMAT* {.pure.} = object
      ControlWord*: WORD
      StatusWord*: WORD
      TagWord*: BYTE
      Reserved1*: BYTE
      ErrorOpcode*: WORD
      ErrorOffset*: DWORD
      ErrorSelector*: WORD
      Reserved2*: WORD
      DataOffset*: DWORD
      DataSelector*: WORD
      Reserved3*: WORD
      MxCsr*: DWORD
      MxCsr_Mask*: DWORD
      FloatRegisters*: array[8, M128A]
      XmmRegisters*: array[8, M128A]
      Reserved4*: array[220, BYTE]
      Cr0NpxState*: DWORD
type
  XSAVE_AREA* {.pure.} = object
    LegacyState*: XSAVE_FORMAT
    Header*: XSAVE_AREA_HEADER
  PXSAVE_AREA* = ptr XSAVE_AREA
  SCOPE_TABLE_AMD64_ScopeRecord* {.pure.} = object
    BeginAddress*: DWORD
    EndAddress*: DWORD
    HandlerAddress*: DWORD
    JumpTarget*: DWORD
  SCOPE_TABLE_AMD64* {.pure.} = object
    Count*: DWORD
    ScopeRecord*: array[1, SCOPE_TABLE_AMD64_ScopeRecord]
  PSCOPE_TABLE_AMD64* = ptr SCOPE_TABLE_AMD64
  LDT_ENTRY_HighWord_Bytes* {.pure.} = object
    BaseMid*: BYTE
    Flags1*: BYTE
    Flags2*: BYTE
    BaseHi*: BYTE
  LDT_ENTRY_HighWord_Bits* {.pure.} = object
    BaseMid* {.bitsize:8.}: DWORD
    Type* {.bitsize:5.}: DWORD
    Dpl* {.bitsize:2.}: DWORD
    Pres* {.bitsize:1.}: DWORD
    LimitHi* {.bitsize:4.}: DWORD
    Sys* {.bitsize:1.}: DWORD
    Reserved_0* {.bitsize:1.}: DWORD
    Default_Big* {.bitsize:1.}: DWORD
    Granularity* {.bitsize:1.}: DWORD
    BaseHi* {.bitsize:8.}: DWORD
  LDT_ENTRY_HighWord* {.pure, union.} = object
    Bytes*: LDT_ENTRY_HighWord_Bytes
    Bits*: LDT_ENTRY_HighWord_Bits
  LDT_ENTRY* {.pure.} = object
    LimitLow*: WORD
    BaseLow*: WORD
    HighWord*: LDT_ENTRY_HighWord
  PLDT_ENTRY* = ptr LDT_ENTRY
  EXCEPTION_RECORD32* {.pure.} = object
    ExceptionCode*: DWORD
    ExceptionFlags*: DWORD
    ExceptionRecord*: DWORD
    ExceptionAddress*: DWORD
    NumberParameters*: DWORD
    ExceptionInformation*: array[EXCEPTION_MAXIMUM_PARAMETERS, DWORD]
  PEXCEPTION_RECORD32* = ptr EXCEPTION_RECORD32
  EXCEPTION_RECORD64* {.pure.} = object
    ExceptionCode*: DWORD
    ExceptionFlags*: DWORD
    ExceptionRecord*: DWORD64
    ExceptionAddress*: DWORD64
    NumberParameters*: DWORD
    unusedAlignment*: DWORD
    ExceptionInformation*: array[EXCEPTION_MAXIMUM_PARAMETERS, DWORD64]
  PEXCEPTION_RECORD64* = ptr EXCEPTION_RECORD64
  PEXCEPTION_POINTERS* = ptr EXCEPTION_POINTERS
  PACCESS_MASK* = ptr ACCESS_MASK
  GENERIC_MAPPING* {.pure.} = object
    GenericRead*: ACCESS_MASK
    GenericWrite*: ACCESS_MASK
    GenericExecute*: ACCESS_MASK
    GenericAll*: ACCESS_MASK
  PGENERIC_MAPPING* = ptr GENERIC_MAPPING
  LUID_AND_ATTRIBUTES* {.pure.} = object
    Luid*: LUID
    Attributes*: DWORD
  PLUID_AND_ATTRIBUTES* = ptr LUID_AND_ATTRIBUTES
const
  ANYSIZE_ARRAY* = 1
type
  LUID_AND_ATTRIBUTES_ARRAY* = array[ANYSIZE_ARRAY, LUID_AND_ATTRIBUTES]
  PLUID_AND_ATTRIBUTES_ARRAY* = ptr LUID_AND_ATTRIBUTES_ARRAY
  SID_IDENTIFIER_AUTHORITY* {.pure.} = object
    Value*: array[6, BYTE]
  PSID_IDENTIFIER_AUTHORITY* = ptr SID_IDENTIFIER_AUTHORITY
  SID* {.pure.} = object
    Revision*: BYTE
    SubAuthorityCount*: BYTE
    IdentifierAuthority*: SID_IDENTIFIER_AUTHORITY
    SubAuthority*: array[ANYSIZE_ARRAY, DWORD]
  PISID* = ptr SID
  SID_AND_ATTRIBUTES* {.pure.} = object
    Sid*: PSID
    Attributes*: DWORD
  PSID_AND_ATTRIBUTES* = ptr SID_AND_ATTRIBUTES
  SID_AND_ATTRIBUTES_ARRAY* = array[ANYSIZE_ARRAY, SID_AND_ATTRIBUTES]
  PSID_AND_ATTRIBUTES_ARRAY* = ptr SID_AND_ATTRIBUTES_ARRAY
const
  SID_HASH_SIZE* = 32
type
  SID_AND_ATTRIBUTES_HASH* {.pure.} = object
    SidCount*: DWORD
    SidAttr*: PSID_AND_ATTRIBUTES
    Hash*: array[SID_HASH_SIZE, SID_HASH_ENTRY]
  PSID_AND_ATTRIBUTES_HASH* = ptr SID_AND_ATTRIBUTES_HASH
  ACL* {.pure.} = object
    AclRevision*: BYTE
    Sbz1*: BYTE
    AclSize*: WORD
    AceCount*: WORD
    Sbz2*: WORD
  PACL* = ptr ACL
  ACE_HEADER* {.pure.} = object
    AceType*: BYTE
    AceFlags*: BYTE
    AceSize*: WORD
  PACE_HEADER* = ptr ACE_HEADER
  ACCESS_ALLOWED_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PACCESS_ALLOWED_ACE* = ptr ACCESS_ALLOWED_ACE
  ACCESS_DENIED_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PACCESS_DENIED_ACE* = ptr ACCESS_DENIED_ACE
  SYSTEM_AUDIT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PSYSTEM_AUDIT_ACE* = ptr SYSTEM_AUDIT_ACE
  SYSTEM_ALARM_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PSYSTEM_ALARM_ACE* = ptr SYSTEM_ALARM_ACE
  SYSTEM_RESOURCE_ATTRIBUTE_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PSYSTEM_RESOURCE_ATTRIBUTE_ACE* = ptr SYSTEM_RESOURCE_ATTRIBUTE_ACE
  SYSTEM_SCOPED_POLICY_ID_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PSYSTEM_SCOPED_POLICY_ID_ACE* = ptr SYSTEM_SCOPED_POLICY_ID_ACE
  SYSTEM_MANDATORY_LABEL_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PSYSTEM_MANDATORY_LABEL_ACE* = ptr SYSTEM_MANDATORY_LABEL_ACE
  ACCESS_ALLOWED_OBJECT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    Flags*: DWORD
    ObjectType*: GUID
    InheritedObjectType*: GUID
    SidStart*: DWORD
  PACCESS_ALLOWED_OBJECT_ACE* = ptr ACCESS_ALLOWED_OBJECT_ACE
  ACCESS_DENIED_OBJECT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    Flags*: DWORD
    ObjectType*: GUID
    InheritedObjectType*: GUID
    SidStart*: DWORD
  PACCESS_DENIED_OBJECT_ACE* = ptr ACCESS_DENIED_OBJECT_ACE
  SYSTEM_AUDIT_OBJECT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    Flags*: DWORD
    ObjectType*: GUID
    InheritedObjectType*: GUID
    SidStart*: DWORD
  PSYSTEM_AUDIT_OBJECT_ACE* = ptr SYSTEM_AUDIT_OBJECT_ACE
  SYSTEM_ALARM_OBJECT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    Flags*: DWORD
    ObjectType*: GUID
    InheritedObjectType*: GUID
    SidStart*: DWORD
  PSYSTEM_ALARM_OBJECT_ACE* = ptr SYSTEM_ALARM_OBJECT_ACE
  ACCESS_ALLOWED_CALLBACK_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PACCESS_ALLOWED_CALLBACK_ACE* = ptr ACCESS_ALLOWED_CALLBACK_ACE
  ACCESS_DENIED_CALLBACK_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PACCESS_DENIED_CALLBACK_ACE* = ptr ACCESS_DENIED_CALLBACK_ACE
  SYSTEM_AUDIT_CALLBACK_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PSYSTEM_AUDIT_CALLBACK_ACE* = ptr SYSTEM_AUDIT_CALLBACK_ACE
  SYSTEM_ALARM_CALLBACK_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    SidStart*: DWORD
  PSYSTEM_ALARM_CALLBACK_ACE* = ptr SYSTEM_ALARM_CALLBACK_ACE
  ACCESS_ALLOWED_CALLBACK_OBJECT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    Flags*: DWORD
    ObjectType*: GUID
    InheritedObjectType*: GUID
    SidStart*: DWORD
  PACCESS_ALLOWED_CALLBACK_OBJECT_ACE* = ptr ACCESS_ALLOWED_CALLBACK_OBJECT_ACE
  ACCESS_DENIED_CALLBACK_OBJECT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    Flags*: DWORD
    ObjectType*: GUID
    InheritedObjectType*: GUID
    SidStart*: DWORD
  PACCESS_DENIED_CALLBACK_OBJECT_ACE* = ptr ACCESS_DENIED_CALLBACK_OBJECT_ACE
  SYSTEM_AUDIT_CALLBACK_OBJECT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    Flags*: DWORD
    ObjectType*: GUID
    InheritedObjectType*: GUID
    SidStart*: DWORD
  PSYSTEM_AUDIT_CALLBACK_OBJECT_ACE* = ptr SYSTEM_AUDIT_CALLBACK_OBJECT_ACE
  SYSTEM_ALARM_CALLBACK_OBJECT_ACE* {.pure.} = object
    Header*: ACE_HEADER
    Mask*: ACCESS_MASK
    Flags*: DWORD
    ObjectType*: GUID
    InheritedObjectType*: GUID
    SidStart*: DWORD
  PSYSTEM_ALARM_CALLBACK_OBJECT_ACE* = ptr SYSTEM_ALARM_CALLBACK_OBJECT_ACE
  ACL_REVISION_INFORMATION* {.pure.} = object
    AclRevision*: DWORD
  PACL_REVISION_INFORMATION* = ptr ACL_REVISION_INFORMATION
  ACL_SIZE_INFORMATION* {.pure.} = object
    AceCount*: DWORD
    AclBytesInUse*: DWORD
    AclBytesFree*: DWORD
  PACL_SIZE_INFORMATION* = ptr ACL_SIZE_INFORMATION
  SECURITY_DESCRIPTOR_RELATIVE* {.pure.} = object
    Revision*: BYTE
    Sbz1*: BYTE
    Control*: SECURITY_DESCRIPTOR_CONTROL
    Owner*: DWORD
    Group*: DWORD
    Sacl*: DWORD
    Dacl*: DWORD
  PISECURITY_DESCRIPTOR_RELATIVE* = ptr SECURITY_DESCRIPTOR_RELATIVE
  SECURITY_DESCRIPTOR* {.pure.} = object
    Revision*: BYTE
    Sbz1*: BYTE
    Control*: SECURITY_DESCRIPTOR_CONTROL
    Owner*: PSID
    Group*: PSID
    Sacl*: PACL
    Dacl*: PACL
  PISECURITY_DESCRIPTOR* = ptr SECURITY_DESCRIPTOR
  OBJECT_TYPE_LIST* {.pure.} = object
    Level*: WORD
    Sbz*: WORD
    ObjectType*: ptr GUID
  POBJECT_TYPE_LIST* = ptr OBJECT_TYPE_LIST
  PRIVILEGE_SET* {.pure.} = object
    PrivilegeCount*: DWORD
    Control*: DWORD
    Privilege*: array[ANYSIZE_ARRAY, LUID_AND_ATTRIBUTES]
  PPRIVILEGE_SET* = ptr PRIVILEGE_SET
  ACCESS_REASONS* {.pure.} = object
    Data*: array[32, ACCESS_REASON]
  PACCESS_REASONS* = ptr ACCESS_REASONS
  SE_SECURITY_DESCRIPTOR* {.pure.} = object
    Size*: DWORD
    Flags*: DWORD
    SecurityDescriptor*: PSECURITY_DESCRIPTOR
  PSE_SECURITY_DESCRIPTOR* = ptr SE_SECURITY_DESCRIPTOR
  SE_ACCESS_REQUEST* {.pure.} = object
    Size*: DWORD
    SeSecurityDescriptor*: PSE_SECURITY_DESCRIPTOR
    DesiredAccess*: ACCESS_MASK
    PreviouslyGrantedAccess*: ACCESS_MASK
    PrincipalSelfSid*: PSID
    GenericMapping*: PGENERIC_MAPPING
    ObjectTypeListCount*: DWORD
    ObjectTypeList*: POBJECT_TYPE_LIST
  PSE_ACCESS_REQUEST* = ptr SE_ACCESS_REQUEST
  SE_ACCESS_REPLY* {.pure.} = object
    Size*: DWORD
    ResultListCount*: DWORD
    GrantedAccess*: PACCESS_MASK
    AccessStatus*: PDWORD
    AccessReason*: PACCESS_REASONS
    Privileges*: ptr PPRIVILEGE_SET
  PSE_ACCESS_REPLY* = ptr SE_ACCESS_REPLY
  PTOKEN_TYPE* = ptr TOKEN_TYPE
  TOKEN_USER* {.pure.} = object
    User*: SID_AND_ATTRIBUTES
  PTOKEN_USER* = ptr TOKEN_USER
  TOKEN_GROUPS* {.pure.} = object
    GroupCount*: DWORD
    Groups*: array[ANYSIZE_ARRAY, SID_AND_ATTRIBUTES]
  PTOKEN_GROUPS* = ptr TOKEN_GROUPS
  TOKEN_PRIVILEGES* {.pure.} = object
    PrivilegeCount*: DWORD
    Privileges*: array[ANYSIZE_ARRAY, LUID_AND_ATTRIBUTES]
  PTOKEN_PRIVILEGES* = ptr TOKEN_PRIVILEGES
  TOKEN_OWNER* {.pure.} = object
    Owner*: PSID
  PTOKEN_OWNER* = ptr TOKEN_OWNER
  TOKEN_PRIMARY_GROUP* {.pure.} = object
    PrimaryGroup*: PSID
  PTOKEN_PRIMARY_GROUP* = ptr TOKEN_PRIMARY_GROUP
  TOKEN_DEFAULT_DACL* {.pure.} = object
    DefaultDacl*: PACL
  PTOKEN_DEFAULT_DACL* = ptr TOKEN_DEFAULT_DACL
  TOKEN_USER_CLAIMS* {.pure.} = object
    UserClaims*: PCLAIMS_BLOB
  PTOKEN_USER_CLAIMS* = ptr TOKEN_USER_CLAIMS
  TOKEN_DEVICE_CLAIMS* {.pure.} = object
    DeviceClaims*: PCLAIMS_BLOB
  PTOKEN_DEVICE_CLAIMS* = ptr TOKEN_DEVICE_CLAIMS
  TOKEN_GROUPS_AND_PRIVILEGES* {.pure.} = object
    SidCount*: DWORD
    SidLength*: DWORD
    Sids*: PSID_AND_ATTRIBUTES
    RestrictedSidCount*: DWORD
    RestrictedSidLength*: DWORD
    RestrictedSids*: PSID_AND_ATTRIBUTES
    PrivilegeCount*: DWORD
    PrivilegeLength*: DWORD
    Privileges*: PLUID_AND_ATTRIBUTES
    AuthenticationId*: LUID
  PTOKEN_GROUPS_AND_PRIVILEGES* = ptr TOKEN_GROUPS_AND_PRIVILEGES
  TOKEN_LINKED_TOKEN* {.pure.} = object
    LinkedToken*: HANDLE
  PTOKEN_LINKED_TOKEN* = ptr TOKEN_LINKED_TOKEN
  TOKEN_ELEVATION* {.pure.} = object
    TokenIsElevated*: DWORD
  PTOKEN_ELEVATION* = ptr TOKEN_ELEVATION
  TOKEN_MANDATORY_LABEL* {.pure.} = object
    Label*: SID_AND_ATTRIBUTES
  PTOKEN_MANDATORY_LABEL* = ptr TOKEN_MANDATORY_LABEL
  TOKEN_MANDATORY_POLICY* {.pure.} = object
    Policy*: DWORD
  PTOKEN_MANDATORY_POLICY* = ptr TOKEN_MANDATORY_POLICY
  TOKEN_ACCESS_INFORMATION* {.pure.} = object
    SidHash*: PSID_AND_ATTRIBUTES_HASH
    RestrictedSidHash*: PSID_AND_ATTRIBUTES_HASH
    Privileges*: PTOKEN_PRIVILEGES
    AuthenticationId*: LUID
    TokenType*: TOKEN_TYPE
    ImpersonationLevel*: SECURITY_IMPERSONATION_LEVEL
    MandatoryPolicy*: TOKEN_MANDATORY_POLICY
    Flags*: DWORD
    AppContainerNumber*: DWORD
    PackageSid*: PSID
    CapabilitiesHash*: PSID_AND_ATTRIBUTES_HASH
  PTOKEN_ACCESS_INFORMATION* = ptr TOKEN_ACCESS_INFORMATION
const
  POLICY_AUDIT_SUBCATEGORY_COUNT* = 56
type
  TOKEN_AUDIT_POLICY* {.pure.} = object
    PerUserPolicy*: array[((POLICY_AUDIT_SUBCATEGORY_COUNT) shr 1) + 1, UCHAR]
  PTOKEN_AUDIT_POLICY* = ptr TOKEN_AUDIT_POLICY
const
  TOKEN_SOURCE_LENGTH* = 8
type
  TOKEN_SOURCE* {.pure.} = object
    SourceName*: array[TOKEN_SOURCE_LENGTH, CHAR]
    SourceIdentifier*: LUID
  PTOKEN_SOURCE* = ptr TOKEN_SOURCE
  TOKEN_STATISTICS* {.pure.} = object
    TokenId*: LUID
    AuthenticationId*: LUID
    ExpirationTime*: LARGE_INTEGER
    TokenType*: TOKEN_TYPE
    ImpersonationLevel*: SECURITY_IMPERSONATION_LEVEL
    DynamicCharged*: DWORD
    DynamicAvailable*: DWORD
    GroupCount*: DWORD
    PrivilegeCount*: DWORD
    ModifiedId*: LUID
  PTOKEN_STATISTICS* = ptr TOKEN_STATISTICS
  TOKEN_CONTROL* {.pure.} = object
    TokenId*: LUID
    AuthenticationId*: LUID
    ModifiedId*: LUID
    TokenSource*: TOKEN_SOURCE
  PTOKEN_CONTROL* = ptr TOKEN_CONTROL
  TOKEN_ORIGIN* {.pure.} = object
    OriginatingLogonSession*: LUID
  PTOKEN_ORIGIN* = ptr TOKEN_ORIGIN
  TOKEN_APPCONTAINER_INFORMATION* {.pure.} = object
    TokenAppContainer*: PSID
  PTOKEN_APPCONTAINER_INFORMATION* = ptr TOKEN_APPCONTAINER_INFORMATION
  CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE* {.pure.} = object
    Version*: DWORD64
    Name*: PWSTR
  PCLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE* = ptr CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE
  CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE* {.pure.} = object
    pValue*: PVOID
    ValueLength*: DWORD
  PCLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE* = ptr CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
  CLAIM_SECURITY_ATTRIBUTE_V1_Values* {.pure, union.} = object
    pInt64*: PLONG64
    pUint64*: PDWORD64
    ppString*: ptr PWSTR
    pFqbn*: PCLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE
    pOctetString*: PCLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
  CLAIM_SECURITY_ATTRIBUTE_V1* {.pure.} = object
    Name*: PWSTR
    ValueType*: WORD
    Reserved*: WORD
    Flags*: DWORD
    ValueCount*: DWORD
    Values*: CLAIM_SECURITY_ATTRIBUTE_V1_Values
  PCLAIM_SECURITY_ATTRIBUTE_V1* = ptr CLAIM_SECURITY_ATTRIBUTE_V1
  CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1_Values* {.pure, union.} = object
    pInt64*: array[ANYSIZE_ARRAY, DWORD]
    pUint64*: array[ANYSIZE_ARRAY, DWORD]
    ppString*: array[ANYSIZE_ARRAY, DWORD]
    pFqbn*: array[ANYSIZE_ARRAY, DWORD]
    pOctetString*: array[ANYSIZE_ARRAY, DWORD]
  CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1* {.pure.} = object
    Name*: DWORD
    ValueType*: WORD
    Reserved*: WORD
    Flags*: DWORD
    ValueCount*: DWORD
    Values*: CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1_Values
  PCLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1* = ptr CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1
  CLAIM_SECURITY_ATTRIBUTES_INFORMATION_Attribute* {.pure, union.} = object
    pAttributeV1*: PCLAIM_SECURITY_ATTRIBUTE_V1
  CLAIM_SECURITY_ATTRIBUTES_INFORMATION* {.pure.} = object
    Version*: WORD
    Reserved*: WORD
    AttributeCount*: DWORD
    Attribute*: CLAIM_SECURITY_ATTRIBUTES_INFORMATION_Attribute
  PCLAIM_SECURITY_ATTRIBUTES_INFORMATION* = ptr CLAIM_SECURITY_ATTRIBUTES_INFORMATION
  SECURITY_QUALITY_OF_SERVICE* {.pure.} = object
    Length*: DWORD
    ImpersonationLevel*: SECURITY_IMPERSONATION_LEVEL
    ContextTrackingMode*: SECURITY_CONTEXT_TRACKING_MODE
    EffectiveOnly*: BOOLEAN
  PSECURITY_QUALITY_OF_SERVICE* = ptr SECURITY_QUALITY_OF_SERVICE
  SE_IMPERSONATION_STATE* {.pure.} = object
    Token*: PACCESS_TOKEN
    CopyOnOpen*: BOOLEAN
    EffectiveOnly*: BOOLEAN
    Level*: SECURITY_IMPERSONATION_LEVEL
  PSE_IMPERSONATION_STATE* = ptr SE_IMPERSONATION_STATE
  SECURITY_CAPABILITIES* {.pure.} = object
    AppContainerSid*: PSID
    Capabilities*: PSID_AND_ATTRIBUTES
    CapabilityCount*: DWORD
    Reserved*: DWORD
  PSECURITY_CAPABILITIES* = ptr SECURITY_CAPABILITIES
  LPSECURITY_CAPABILITIES* = ptr SECURITY_CAPABILITIES
  JOB_SET_ARRAY* {.pure.} = object
    JobHandle*: HANDLE
    MemberLevel*: DWORD
    Flags*: DWORD
  PJOB_SET_ARRAY* = ptr JOB_SET_ARRAY
  EXCEPTION_REGISTRATION_RECORD* {.pure.} = object
  NT_TIB_UNION1* {.pure, union.} = object
    FiberData*: PVOID
    Version*: DWORD
  NT_TIB* {.pure.} = object
    ExceptionList*: ptr EXCEPTION_REGISTRATION_RECORD
    StackBase*: PVOID
    StackLimit*: PVOID
    SubSystemTib*: PVOID
    union1*: NT_TIB_UNION1
    ArbitraryUserPointer*: PVOID
    Self*: ptr NT_TIB
  PNT_TIB* = ptr NT_TIB
  NT_TIB32_UNION1* {.pure, union.} = object
    FiberData*: DWORD
    Version*: DWORD
  NT_TIB32* {.pure.} = object
    ExceptionList*: DWORD
    StackBase*: DWORD
    StackLimit*: DWORD
    SubSystemTib*: DWORD
    union1*: NT_TIB32_UNION1
    ArbitraryUserPointer*: DWORD
    Self*: DWORD
  PNT_TIB32* = ptr NT_TIB32
  NT_TIB64_UNION1* {.pure, union.} = object
    FiberData*: DWORD64
    Version*: DWORD
  NT_TIB64* {.pure.} = object
    ExceptionList*: DWORD64
    StackBase*: DWORD64
    StackLimit*: DWORD64
    SubSystemTib*: DWORD64
    union1*: NT_TIB64_UNION1
    ArbitraryUserPointer*: DWORD64
    Self*: DWORD64
  PNT_TIB64* = ptr NT_TIB64
  UMS_CREATE_THREAD_ATTRIBUTES* {.pure.} = object
    UmsVersion*: DWORD
    UmsContext*: PVOID
    UmsCompletionList*: PVOID
  PUMS_CREATE_THREAD_ATTRIBUTES* = ptr UMS_CREATE_THREAD_ATTRIBUTES
  QUOTA_LIMITS* {.pure.} = object
    PagedPoolLimit*: SIZE_T
    NonPagedPoolLimit*: SIZE_T
    MinimumWorkingSetSize*: SIZE_T
    MaximumWorkingSetSize*: SIZE_T
    PagefileLimit*: SIZE_T
    TimeLimit*: LARGE_INTEGER
  PQUOTA_LIMITS* = ptr QUOTA_LIMITS
  RATE_QUOTA_LIMIT_STRUCT1* {.pure.} = object
    RatePercent* {.bitsize:7.}: DWORD
    Reserved0* {.bitsize:25.}: DWORD
  RATE_QUOTA_LIMIT* {.pure, union.} = object
    RateData*: DWORD
    struct1*: RATE_QUOTA_LIMIT_STRUCT1
  PRATE_QUOTA_LIMIT* = ptr RATE_QUOTA_LIMIT
  QUOTA_LIMITS_EX* {.pure.} = object
    PagedPoolLimit*: SIZE_T
    NonPagedPoolLimit*: SIZE_T
    MinimumWorkingSetSize*: SIZE_T
    MaximumWorkingSetSize*: SIZE_T
    PagefileLimit*: SIZE_T
    TimeLimit*: LARGE_INTEGER
    WorkingSetLimit*: SIZE_T
    Reserved2*: SIZE_T
    Reserved3*: SIZE_T
    Reserved4*: SIZE_T
    Flags*: DWORD
    CpuRateLimit*: RATE_QUOTA_LIMIT
  PQUOTA_LIMITS_EX* = ptr QUOTA_LIMITS_EX
  IO_COUNTERS* {.pure.} = object
    ReadOperationCount*: ULONGLONG
    WriteOperationCount*: ULONGLONG
    OtherOperationCount*: ULONGLONG
    ReadTransferCount*: ULONGLONG
    WriteTransferCount*: ULONGLONG
    OtherTransferCount*: ULONGLONG
  PIO_COUNTERS* = ptr IO_COUNTERS
  PROCESS_MITIGATION_ASLR_POLICY_UNION1_STRUCT1* {.pure.} = object
    EnableBottomUpRandomization* {.bitsize:1.}: DWORD
    EnableForceRelocateImages* {.bitsize:1.}: DWORD
    EnableHighEntropy* {.bitsize:1.}: DWORD
    DisallowStrippedImages* {.bitsize:1.}: DWORD
    ReservedFlags* {.bitsize:28.}: DWORD
  PROCESS_MITIGATION_ASLR_POLICY_UNION1* {.pure, union.} = object
    Flags*: DWORD
    struct1*: PROCESS_MITIGATION_ASLR_POLICY_UNION1_STRUCT1
  PROCESS_MITIGATION_ASLR_POLICY* {.pure.} = object
    union1*: PROCESS_MITIGATION_ASLR_POLICY_UNION1
  PPROCESS_MITIGATION_ASLR_POLICY* = ptr PROCESS_MITIGATION_ASLR_POLICY
  PROCESS_MITIGATION_DEP_POLICY_UNION1_STRUCT1* {.pure.} = object
    Enable* {.bitsize:1.}: DWORD
    DisableAtlThunkEmulation* {.bitsize:1.}: DWORD
    ReservedFlags* {.bitsize:30.}: DWORD
  PROCESS_MITIGATION_DEP_POLICY_UNION1* {.pure, union.} = object
    Flags*: DWORD
    struct1*: PROCESS_MITIGATION_DEP_POLICY_UNION1_STRUCT1
  PROCESS_MITIGATION_DEP_POLICY* {.pure.} = object
    union1*: PROCESS_MITIGATION_DEP_POLICY_UNION1
    Permanent*: BOOLEAN
  PPROCESS_MITIGATION_DEP_POLICY* = ptr PROCESS_MITIGATION_DEP_POLICY
  PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY_UNION1_STRUCT1* {.pure.} = object
    RaiseExceptionOnInvalidHandleReference* {.bitsize:1.}: DWORD
    HandleExceptionsPermanentlyEnabled* {.bitsize:1.}: DWORD
    ReservedFlags* {.bitsize:30.}: DWORD
  PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY_UNION1* {.pure, union.} = object
    Flags*: DWORD
    struct1*: PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY_UNION1_STRUCT1
  PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY* {.pure.} = object
    union1*: PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY_UNION1
  PPROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY* = ptr PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY
  PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY_UNION1_STRUCT1* {.pure.} = object
    DisallowWin32kSystemCalls* {.bitsize:1.}: DWORD
    ReservedFlags* {.bitsize:31.}: DWORD
  PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY_UNION1* {.pure, union.} = object
    Flags*: DWORD
    struct1*: PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY_UNION1_STRUCT1
  PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY* {.pure.} = object
    union1*: PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY_UNION1
  PPROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY* = ptr PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY
  PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY_UNION1_STRUCT1* {.pure.} = object
    DisableExtensionPoints* {.bitsize:1.}: DWORD
    ReservedFlags* {.bitsize:31.}: DWORD
  PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY_UNION1* {.pure, union.} = object
    Flags*: DWORD
    struct1*: PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY_UNION1_STRUCT1
  PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY* {.pure.} = object
    union1*: PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY_UNION1
  PPROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY* = ptr PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY
  JOBOBJECT_BASIC_ACCOUNTING_INFORMATION* {.pure.} = object
    TotalUserTime*: LARGE_INTEGER
    TotalKernelTime*: LARGE_INTEGER
    ThisPeriodTotalUserTime*: LARGE_INTEGER
    ThisPeriodTotalKernelTime*: LARGE_INTEGER
    TotalPageFaultCount*: DWORD
    TotalProcesses*: DWORD
    ActiveProcesses*: DWORD
    TotalTerminatedProcesses*: DWORD
  PJOBOBJECT_BASIC_ACCOUNTING_INFORMATION* = ptr JOBOBJECT_BASIC_ACCOUNTING_INFORMATION
  JOBOBJECT_BASIC_LIMIT_INFORMATION* {.pure.} = object
    PerProcessUserTimeLimit*: LARGE_INTEGER
    PerJobUserTimeLimit*: LARGE_INTEGER
    LimitFlags*: DWORD
    MinimumWorkingSetSize*: SIZE_T
    MaximumWorkingSetSize*: SIZE_T
    ActiveProcessLimit*: DWORD
    Affinity*: ULONG_PTR
    PriorityClass*: DWORD
    SchedulingClass*: DWORD
  PJOBOBJECT_BASIC_LIMIT_INFORMATION* = ptr JOBOBJECT_BASIC_LIMIT_INFORMATION
  JOBOBJECT_EXTENDED_LIMIT_INFORMATION* {.pure.} = object
    BasicLimitInformation*: JOBOBJECT_BASIC_LIMIT_INFORMATION
    IoInfo*: IO_COUNTERS
    ProcessMemoryLimit*: SIZE_T
    JobMemoryLimit*: SIZE_T
    PeakProcessMemoryUsed*: SIZE_T
    PeakJobMemoryUsed*: SIZE_T
  PJOBOBJECT_EXTENDED_LIMIT_INFORMATION* = ptr JOBOBJECT_EXTENDED_LIMIT_INFORMATION
  JOBOBJECT_BASIC_PROCESS_ID_LIST* {.pure.} = object
    NumberOfAssignedProcesses*: DWORD
    NumberOfProcessIdsInList*: DWORD
    ProcessIdList*: array[1, ULONG_PTR]
  PJOBOBJECT_BASIC_PROCESS_ID_LIST* = ptr JOBOBJECT_BASIC_PROCESS_ID_LIST
  JOBOBJECT_BASIC_UI_RESTRICTIONS* {.pure.} = object
    UIRestrictionsClass*: DWORD
  PJOBOBJECT_BASIC_UI_RESTRICTIONS* = ptr JOBOBJECT_BASIC_UI_RESTRICTIONS
  JOBOBJECT_SECURITY_LIMIT_INFORMATION* {.pure.} = object
    SecurityLimitFlags*: DWORD
    JobToken*: HANDLE
    SidsToDisable*: PTOKEN_GROUPS
    PrivilegesToDelete*: PTOKEN_PRIVILEGES
    RestrictedSids*: PTOKEN_GROUPS
  PJOBOBJECT_SECURITY_LIMIT_INFORMATION* = ptr JOBOBJECT_SECURITY_LIMIT_INFORMATION
  JOBOBJECT_END_OF_JOB_TIME_INFORMATION* {.pure.} = object
    EndOfJobTimeAction*: DWORD
  PJOBOBJECT_END_OF_JOB_TIME_INFORMATION* = ptr JOBOBJECT_END_OF_JOB_TIME_INFORMATION
  JOBOBJECT_ASSOCIATE_COMPLETION_PORT* {.pure.} = object
    CompletionKey*: PVOID
    CompletionPort*: HANDLE
  PJOBOBJECT_ASSOCIATE_COMPLETION_PORT* = ptr JOBOBJECT_ASSOCIATE_COMPLETION_PORT
  JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION* {.pure.} = object
    BasicInfo*: JOBOBJECT_BASIC_ACCOUNTING_INFORMATION
    IoInfo*: IO_COUNTERS
  PJOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION* = ptr JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION
  JOBOBJECT_JOBSET_INFORMATION* {.pure.} = object
    MemberLevel*: DWORD
  PJOBOBJECT_JOBSET_INFORMATION* = ptr JOBOBJECT_JOBSET_INFORMATION
  JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION* {.pure.} = object
    IoReadBytesLimit*: DWORD64
    IoWriteBytesLimit*: DWORD64
    PerJobUserTimeLimit*: LARGE_INTEGER
    JobMemoryLimit*: DWORD64
    RateControlTolerance*: JOBOBJECT_RATE_CONTROL_TOLERANCE
    RateControlToleranceInterval*: JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
    LimitFlags*: DWORD
  PJOBOBJECT_NOTIFICATION_LIMIT_INFORMATION* = ptr JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION
  JOBOBJECT_LIMIT_VIOLATION_INFORMATION* {.pure.} = object
    LimitFlags*: DWORD
    ViolationLimitFlags*: DWORD
    IoReadBytes*: DWORD64
    IoReadBytesLimit*: DWORD64
    IoWriteBytes*: DWORD64
    IoWriteBytesLimit*: DWORD64
    PerJobUserTime*: LARGE_INTEGER
    PerJobUserTimeLimit*: LARGE_INTEGER
    JobMemory*: DWORD64
    JobMemoryLimit*: DWORD64
    RateControlTolerance*: JOBOBJECT_RATE_CONTROL_TOLERANCE
    RateControlToleranceLimit*: JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
  PJOBOBJECT_LIMIT_VIOLATION_INFORMATION* = ptr JOBOBJECT_LIMIT_VIOLATION_INFORMATION
  JOBOBJECT_CPU_RATE_CONTROL_INFORMATION_UNION1* {.pure, union.} = object
    CpuRate*: DWORD
    Weight*: DWORD
  JOBOBJECT_CPU_RATE_CONTROL_INFORMATION* {.pure.} = object
    ControlFlags*: DWORD
    union1*: JOBOBJECT_CPU_RATE_CONTROL_INFORMATION_UNION1
  PJOBOBJECT_CPU_RATE_CONTROL_INFORMATION* = ptr JOBOBJECT_CPU_RATE_CONTROL_INFORMATION
  CACHE_DESCRIPTOR* {.pure.} = object
    Level*: BYTE
    Associativity*: BYTE
    LineSize*: WORD
    Size*: DWORD
    Type*: PROCESSOR_CACHE_TYPE
  PCACHE_DESCRIPTOR* = ptr CACHE_DESCRIPTOR
  SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_ProcessorCore* {.pure.} = object
    Flags*: BYTE
  SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_NumaNode* {.pure.} = object
    NodeNumber*: DWORD
  SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1* {.pure, union.} = object
    ProcessorCore*: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_ProcessorCore
    NumaNode*: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_NumaNode
    Cache*: CACHE_DESCRIPTOR
    Reserved*: array[2, ULONGLONG]
  SYSTEM_LOGICAL_PROCESSOR_INFORMATION* {.pure.} = object
    ProcessorMask*: ULONG_PTR
    Relationship*: LOGICAL_PROCESSOR_RELATIONSHIP
    union1*: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1
  PSYSTEM_LOGICAL_PROCESSOR_INFORMATION* = ptr SYSTEM_LOGICAL_PROCESSOR_INFORMATION
  PROCESSOR_RELATIONSHIP* {.pure.} = object
    Flags*: BYTE
    Reserved*: array[21, BYTE]
    GroupCount*: WORD
    GroupMask*: array[ANYSIZE_ARRAY, GROUP_AFFINITY]
  PPROCESSOR_RELATIONSHIP* = ptr PROCESSOR_RELATIONSHIP
  NUMA_NODE_RELATIONSHIP* {.pure.} = object
    NodeNumber*: DWORD
    Reserved*: array[20, BYTE]
    GroupMask*: GROUP_AFFINITY
  PNUMA_NODE_RELATIONSHIP* = ptr NUMA_NODE_RELATIONSHIP
  CACHE_RELATIONSHIP* {.pure.} = object
    Level*: BYTE
    Associativity*: BYTE
    LineSize*: WORD
    CacheSize*: DWORD
    Type*: PROCESSOR_CACHE_TYPE
    Reserved*: array[20, BYTE]
    GroupMask*: GROUP_AFFINITY
  PCACHE_RELATIONSHIP* = ptr CACHE_RELATIONSHIP
  PROCESSOR_GROUP_INFO* {.pure.} = object
    MaximumProcessorCount*: BYTE
    ActiveProcessorCount*: BYTE
    Reserved*: array[38, BYTE]
    ActiveProcessorMask*: KAFFINITY
  PPROCESSOR_GROUP_INFO* = ptr PROCESSOR_GROUP_INFO
  GROUP_RELATIONSHIP* {.pure.} = object
    MaximumGroupCount*: WORD
    ActiveGroupCount*: WORD
    Reserved*: array[20, BYTE]
    GroupInfo*: array[ANYSIZE_ARRAY, PROCESSOR_GROUP_INFO]
  PGROUP_RELATIONSHIP* = ptr GROUP_RELATIONSHIP
  SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX_UNION1* {.pure, union.} = object
    Processor*: PROCESSOR_RELATIONSHIP
    NumaNode*: NUMA_NODE_RELATIONSHIP
    Cache*: CACHE_RELATIONSHIP
    Group*: GROUP_RELATIONSHIP
  SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX* {.pure.} = object
    Relationship*: LOGICAL_PROCESSOR_RELATIONSHIP
    Size*: DWORD
    union1*: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX_UNION1
  PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX* = ptr SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX
  SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION* {.pure.} = object
    CycleTime*: DWORD64
  PSYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION* = ptr SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION
  XSTATE_FEATURE* {.pure.} = object
    Offset*: DWORD
    Size*: DWORD
  PXSTATE_FEATURE* = ptr XSTATE_FEATURE
const
  MAXIMUM_XSTATE_FEATURES* = 64
type
  XSTATE_CONFIGURATION* {.pure.} = object
    EnabledFeatures*: DWORD64
    EnabledVolatileFeatures*: DWORD64
    Size*: DWORD
    OptimizedSave* {.bitsize:1.}: DWORD
    Features*: array[MAXIMUM_XSTATE_FEATURES, XSTATE_FEATURE]
  PXSTATE_CONFIGURATION* = ptr XSTATE_CONFIGURATION
  MEMORY_BASIC_INFORMATION* {.pure.} = object
    BaseAddress*: PVOID
    AllocationBase*: PVOID
    AllocationProtect*: DWORD
    RegionSize*: SIZE_T
    State*: DWORD
    Protect*: DWORD
    Type*: DWORD
  PMEMORY_BASIC_INFORMATION* = ptr MEMORY_BASIC_INFORMATION
  MEMORY_BASIC_INFORMATION32* {.pure.} = object
    BaseAddress*: DWORD
    AllocationBase*: DWORD
    AllocationProtect*: DWORD
    RegionSize*: DWORD
    State*: DWORD
    Protect*: DWORD
    Type*: DWORD
  PMEMORY_BASIC_INFORMATION32* = ptr MEMORY_BASIC_INFORMATION32
  MEMORY_BASIC_INFORMATION64* {.pure.} = object
    BaseAddress*: ULONGLONG
    AllocationBase*: ULONGLONG
    AllocationProtect*: DWORD
    alignment1*: DWORD
    RegionSize*: ULONGLONG
    State*: DWORD
    Protect*: DWORD
    Type*: DWORD
    alignment2*: DWORD
  PMEMORY_BASIC_INFORMATION64* = ptr MEMORY_BASIC_INFORMATION64
  FILE_ID_128* {.pure.} = object
    LowPart*: ULONGLONG
    HighPart*: ULONGLONG
  PFILE_ID_128* = ptr FILE_ID_128
  FILE_NOTIFY_INFORMATION* {.pure.} = object
    NextEntryOffset*: DWORD
    Action*: DWORD
    FileNameLength*: DWORD
    FileName*: array[1, WCHAR]
  PFILE_NOTIFY_INFORMATION* = ptr FILE_NOTIFY_INFORMATION
  FILE_SEGMENT_ELEMENT* {.pure, union.} = object
    Buffer*: PVOID64
    Alignment*: ULONGLONG
  PFILE_SEGMENT_ELEMENT* = ptr FILE_SEGMENT_ELEMENT
  REPARSE_GUID_DATA_BUFFER_GenericReparseBuffer* {.pure.} = object
    DataBuffer*: array[1, BYTE]
  REPARSE_GUID_DATA_BUFFER* {.pure.} = object
    ReparseTag*: DWORD
    ReparseDataLength*: WORD
    Reserved*: WORD
    ReparseGuid*: GUID
    GenericReparseBuffer*: REPARSE_GUID_DATA_BUFFER_GenericReparseBuffer
  PREPARSE_GUID_DATA_BUFFER* = ptr REPARSE_GUID_DATA_BUFFER
  SCRUB_DATA_INPUT* {.pure.} = object
    Size*: DWORD
    Flags*: DWORD
    MaximumIos*: DWORD
    Reserved*: array[17, DWORD]
    ResumeContext*: array[816, BYTE]
  PSCRUB_DATA_INPUT* = ptr SCRUB_DATA_INPUT
  SCRUB_DATA_OUTPUT* {.pure.} = object
    Size*: DWORD
    Flags*: DWORD
    Status*: DWORD
    ErrorFileOffset*: ULONGLONG
    ErrorLength*: ULONGLONG
    NumberOfBytesRepaired*: ULONGLONG
    NumberOfBytesFailed*: ULONGLONG
    InternalFileReference*: ULONGLONG
    Reserved*: array[6, DWORD]
    ResumeContext*: array[816, BYTE]
  PSCRUB_DATA_OUTPUT* = ptr SCRUB_DATA_OUTPUT
const
  POWER_SYSTEM_MAXIMUM* = 7
type
  CM_POWER_DATA* {.pure.} = object
    PD_Size*: DWORD
    PD_MostRecentPowerState*: DEVICE_POWER_STATE
    PD_Capabilities*: DWORD
    PD_D1Latency*: DWORD
    PD_D2Latency*: DWORD
    PD_D3Latency*: DWORD
    PD_PowerStateMapping*: array[POWER_SYSTEM_MAXIMUM, DEVICE_POWER_STATE]
    PD_DeepestSystemWake*: SYSTEM_POWER_STATE
  PCM_POWER_DATA* = ptr CM_POWER_DATA
  POWER_USER_PRESENCE* {.pure.} = object
    UserPresence*: POWER_USER_PRESENCE_TYPE
  PPOWER_USER_PRESENCE* = ptr POWER_USER_PRESENCE
  POWER_SESSION_CONNECT* {.pure.} = object
    Connected*: BOOLEAN
    Console*: BOOLEAN
  PPOWER_SESSION_CONNECT* = ptr POWER_SESSION_CONNECT
  POWER_SESSION_TIMEOUTS* {.pure.} = object
    InputTimeout*: DWORD
    DisplayTimeout*: DWORD
  PPOWER_SESSION_TIMEOUTS* = ptr POWER_SESSION_TIMEOUTS
  POWER_SESSION_RIT_STATE* {.pure.} = object
    Active*: BOOLEAN
    LastInputTime*: DWORD
  PPOWER_SESSION_RIT_STATE* = ptr POWER_SESSION_RIT_STATE
  POWER_SESSION_WINLOGON* {.pure.} = object
    SessionId*: DWORD
    Console*: BOOLEAN
    Locked*: BOOLEAN
  PPOWER_SESSION_WINLOGON* = ptr POWER_SESSION_WINLOGON
  POWER_IDLE_RESILIENCY* {.pure.} = object
    CoalescingTimeout*: DWORD
    IdleResiliencyPeriod*: DWORD
  PPOWER_IDLE_RESILIENCY* = ptr POWER_IDLE_RESILIENCY
  POWER_MONITOR_INVOCATION* {.pure.} = object
    On*: BOOLEAN
    Console*: BOOLEAN
    RequestReason*: POWER_MONITOR_REQUEST_REASON
  PPOWER_MONITOR_INVOCATION* = ptr POWER_MONITOR_INVOCATION
  RESUME_PERFORMANCE* {.pure.} = object
    PostTimeMs*: DWORD
    TotalResumeTimeMs*: ULONGLONG
    ResumeCompleteTimestamp*: ULONGLONG
  PRESUME_PERFORMANCE* = ptr RESUME_PERFORMANCE
  SET_POWER_SETTING_VALUE* {.pure.} = object
    Version*: DWORD
    Guid*: GUID
    PowerCondition*: SYSTEM_POWER_CONDITION
    DataLength*: DWORD
    Data*: array[ANYSIZE_ARRAY, BYTE]
  PSET_POWER_SETTING_VALUE* = ptr SET_POWER_SETTING_VALUE
  NOTIFY_USER_POWER_SETTING* {.pure.} = object
    Guid*: GUID
  PNOTIFY_USER_POWER_SETTING* = ptr NOTIFY_USER_POWER_SETTING
  APPLICATIONLAUNCH_SETTING_VALUE* {.pure.} = object
    ActivationTime*: LARGE_INTEGER
    Flags*: DWORD
    ButtonInstanceID*: DWORD
  PAPPLICATIONLAUNCH_SETTING_VALUE* = ptr APPLICATIONLAUNCH_SETTING_VALUE
  POWER_PLATFORM_INFORMATION* {.pure.} = object
    AoAc*: BOOLEAN
  PPOWER_PLATFORM_INFORMATION* = ptr POWER_PLATFORM_INFORMATION
  BATTERY_REPORTING_SCALE* {.pure.} = object
    Granularity*: DWORD
    Capacity*: DWORD
  PBATTERY_REPORTING_SCALE* = ptr BATTERY_REPORTING_SCALE
  PPM_WMI_LEGACY_PERFSTATE* {.pure.} = object
    Frequency*: DWORD
    Flags*: DWORD
    PercentFrequency*: DWORD
  PPPM_WMI_LEGACY_PERFSTATE* = ptr PPM_WMI_LEGACY_PERFSTATE
  PPM_WMI_IDLE_STATE* {.pure.} = object
    Latency*: DWORD
    Power*: DWORD
    TimeCheck*: DWORD
    PromotePercent*: BYTE
    DemotePercent*: BYTE
    StateType*: BYTE
    Reserved*: BYTE
    StateFlags*: DWORD
    Context*: DWORD
    IdleHandler*: DWORD
    Reserved1*: DWORD
  PPPM_WMI_IDLE_STATE* = ptr PPM_WMI_IDLE_STATE
  PPM_WMI_IDLE_STATES* {.pure.} = object
    Type*: DWORD
    Count*: DWORD
    TargetState*: DWORD
    OldState*: DWORD
    TargetProcessors*: DWORD64
    State*: array[ANYSIZE_ARRAY, PPM_WMI_IDLE_STATE]
  PPPM_WMI_IDLE_STATES* = ptr PPM_WMI_IDLE_STATES
  PPM_WMI_IDLE_STATES_EX* {.pure.} = object
    Type*: DWORD
    Count*: DWORD
    TargetState*: DWORD
    OldState*: DWORD
    TargetProcessors*: PVOID
    State*: array[ANYSIZE_ARRAY, PPM_WMI_IDLE_STATE]
  PPPM_WMI_IDLE_STATES_EX* = ptr PPM_WMI_IDLE_STATES_EX
  PPM_WMI_PERF_STATE* {.pure.} = object
    Frequency*: DWORD
    Power*: DWORD
    PercentFrequency*: BYTE
    IncreaseLevel*: BYTE
    DecreaseLevel*: BYTE
    Type*: BYTE
    IncreaseTime*: DWORD
    DecreaseTime*: DWORD
    Control*: DWORD64
    Status*: DWORD64
    HitCount*: DWORD
    Reserved1*: DWORD
    Reserved2*: DWORD64
    Reserved3*: DWORD64
  PPPM_WMI_PERF_STATE* = ptr PPM_WMI_PERF_STATE
  PPM_WMI_PERF_STATES* {.pure.} = object
    Count*: DWORD
    MaxFrequency*: DWORD
    CurrentState*: DWORD
    MaxPerfState*: DWORD
    MinPerfState*: DWORD
    LowestPerfState*: DWORD
    ThermalConstraint*: DWORD
    BusyAdjThreshold*: BYTE
    PolicyType*: BYTE
    Type*: BYTE
    Reserved*: BYTE
    TimerInterval*: DWORD
    TargetProcessors*: DWORD64
    PStateHandler*: DWORD
    PStateContext*: DWORD
    TStateHandler*: DWORD
    TStateContext*: DWORD
    FeedbackHandler*: DWORD
    Reserved1*: DWORD
    Reserved2*: DWORD64
    State*: array[ANYSIZE_ARRAY, PPM_WMI_PERF_STATE]
  PPPM_WMI_PERF_STATES* = ptr PPM_WMI_PERF_STATES
  PPM_WMI_PERF_STATES_EX* {.pure.} = object
    Count*: DWORD
    MaxFrequency*: DWORD
    CurrentState*: DWORD
    MaxPerfState*: DWORD
    MinPerfState*: DWORD
    LowestPerfState*: DWORD
    ThermalConstraint*: DWORD
    BusyAdjThreshold*: BYTE
    PolicyType*: BYTE
    Type*: BYTE
    Reserved*: BYTE
    TimerInterval*: DWORD
    TargetProcessors*: PVOID
    PStateHandler*: DWORD
    PStateContext*: DWORD
    TStateHandler*: DWORD
    TStateContext*: DWORD
    FeedbackHandler*: DWORD
    Reserved1*: DWORD
    Reserved2*: DWORD64
    State*: array[ANYSIZE_ARRAY, PPM_WMI_PERF_STATE]
  PPPM_WMI_PERF_STATES_EX* = ptr PPM_WMI_PERF_STATES_EX
const
  PROC_IDLE_BUCKET_COUNT* = 6
type
  PPM_IDLE_STATE_ACCOUNTING* {.pure.} = object
    IdleTransitions*: DWORD
    FailedTransitions*: DWORD
    InvalidBucketIndex*: DWORD
    TotalTime*: DWORD64
    IdleTimeBuckets*: array[PROC_IDLE_BUCKET_COUNT, DWORD]
  PPPM_IDLE_STATE_ACCOUNTING* = ptr PPM_IDLE_STATE_ACCOUNTING
  PPM_IDLE_ACCOUNTING* {.pure.} = object
    StateCount*: DWORD
    TotalTransitions*: DWORD
    ResetCount*: DWORD
    StartTime*: DWORD64
    State*: array[ANYSIZE_ARRAY, PPM_IDLE_STATE_ACCOUNTING]
  PPPM_IDLE_ACCOUNTING* = ptr PPM_IDLE_ACCOUNTING
  PPM_IDLE_STATE_BUCKET_EX* {.pure.} = object
    TotalTimeUs*: DWORD64
    MinTimeUs*: DWORD
    MaxTimeUs*: DWORD
    Count*: DWORD
  PPPM_IDLE_STATE_BUCKET_EX* = ptr PPM_IDLE_STATE_BUCKET_EX
const
  PROC_IDLE_BUCKET_COUNT_EX* = 16
type
  PPM_IDLE_STATE_ACCOUNTING_EX* {.pure.} = object
    TotalTime*: DWORD64
    IdleTransitions*: DWORD
    FailedTransitions*: DWORD
    InvalidBucketIndex*: DWORD
    MinTimeUs*: DWORD
    MaxTimeUs*: DWORD
    CancelledTransitions*: DWORD
    IdleTimeBuckets*: array[PROC_IDLE_BUCKET_COUNT_EX, PPM_IDLE_STATE_BUCKET_EX]
  PPPM_IDLE_STATE_ACCOUNTING_EX* = ptr PPM_IDLE_STATE_ACCOUNTING_EX
  PPM_IDLE_ACCOUNTING_EX* {.pure.} = object
    StateCount*: DWORD
    TotalTransitions*: DWORD
    ResetCount*: DWORD
    AbortCount*: DWORD
    StartTime*: DWORD64
    State*: array[ANYSIZE_ARRAY, PPM_IDLE_STATE_ACCOUNTING_EX]
  PPPM_IDLE_ACCOUNTING_EX* = ptr PPM_IDLE_ACCOUNTING_EX
  PPM_PERFSTATE_EVENT* {.pure.} = object
    State*: DWORD
    Status*: DWORD
    Latency*: DWORD
    Speed*: DWORD
    Processor*: DWORD
  PPPM_PERFSTATE_EVENT* = ptr PPM_PERFSTATE_EVENT
  PPM_PERFSTATE_DOMAIN_EVENT* {.pure.} = object
    State*: DWORD
    Latency*: DWORD
    Speed*: DWORD
    Processors*: DWORD64
  PPPM_PERFSTATE_DOMAIN_EVENT* = ptr PPM_PERFSTATE_DOMAIN_EVENT
  PPM_IDLESTATE_EVENT* {.pure.} = object
    NewState*: DWORD
    OldState*: DWORD
    Processors*: DWORD64
  PPPM_IDLESTATE_EVENT* = ptr PPM_IDLESTATE_EVENT
  PPM_THERMALCHANGE_EVENT* {.pure.} = object
    ThermalConstraint*: DWORD
    Processors*: DWORD64
  PPPM_THERMALCHANGE_EVENT* = ptr PPM_THERMALCHANGE_EVENT
  PPM_THERMAL_POLICY_EVENT* {.pure.} = object
    Mode*: BYTE
    Processors*: DWORD64
  PPPM_THERMAL_POLICY_EVENT* = ptr PPM_THERMAL_POLICY_EVENT
  POWER_ACTION_POLICY* {.pure.} = object
    Action*: POWER_ACTION
    Flags*: DWORD
    EventCode*: DWORD
  PPOWER_ACTION_POLICY* = ptr POWER_ACTION_POLICY
  PROCESSOR_IDLESTATE_INFO* {.pure.} = object
    TimeCheck*: DWORD
    DemotePercent*: BYTE
    PromotePercent*: BYTE
    Spare*: array[2, BYTE]
  PPROCESSOR_IDLESTATE_INFO* = ptr PROCESSOR_IDLESTATE_INFO
  SYSTEM_POWER_LEVEL* {.pure.} = object
    Enable*: BOOLEAN
    Spare*: array[3, BYTE]
    BatteryLevel*: DWORD
    PowerPolicy*: POWER_ACTION_POLICY
    MinSystemState*: SYSTEM_POWER_STATE
  PSYSTEM_POWER_LEVEL* = ptr SYSTEM_POWER_LEVEL
const
  NUM_DISCHARGE_POLICIES* = 4
type
  SYSTEM_POWER_POLICY* {.pure.} = object
    Revision*: DWORD
    PowerButton*: POWER_ACTION_POLICY
    SleepButton*: POWER_ACTION_POLICY
    LidClose*: POWER_ACTION_POLICY
    LidOpenWake*: SYSTEM_POWER_STATE
    Reserved*: DWORD
    Idle*: POWER_ACTION_POLICY
    IdleTimeout*: DWORD
    IdleSensitivity*: BYTE
    DynamicThrottle*: BYTE
    Spare2*: array[2, BYTE]
    MinSleep*: SYSTEM_POWER_STATE
    MaxSleep*: SYSTEM_POWER_STATE
    ReducedLatencySleep*: SYSTEM_POWER_STATE
    WinLogonFlags*: DWORD
    Spare3*: DWORD
    DozeS4Timeout*: DWORD
    BroadcastCapacityResolution*: DWORD
    DischargePolicy*: array[NUM_DISCHARGE_POLICIES, SYSTEM_POWER_LEVEL]
    VideoTimeout*: DWORD
    VideoDimDisplay*: BOOLEAN
    VideoReserved*: array[3, DWORD]
    SpindownTimeout*: DWORD
    OptimizeForPower*: BOOLEAN
    FanThrottleTolerance*: BYTE
    ForcedThrottle*: BYTE
    MinThrottle*: BYTE
    OverThrottled*: POWER_ACTION_POLICY
  PSYSTEM_POWER_POLICY* = ptr SYSTEM_POWER_POLICY
  PROCESSOR_IDLESTATE_POLICY_Flags_STRUCT1* {.pure.} = object
    AllowScaling* {.bitsize:1.}: WORD
    Disabled* {.bitsize:1.}: WORD
    Reserved* {.bitsize:14.}: WORD
  PROCESSOR_IDLESTATE_POLICY_Flags* {.pure, union.} = object
    AsWORD*: WORD
    struct1*: PROCESSOR_IDLESTATE_POLICY_Flags_STRUCT1
const
  PROCESSOR_IDLESTATE_POLICY_COUNT* = 0x3
type
  PROCESSOR_IDLESTATE_POLICY* {.pure.} = object
    Revision*: WORD
    Flags*: PROCESSOR_IDLESTATE_POLICY_Flags
    PolicyCount*: DWORD
    Policy*: array[PROCESSOR_IDLESTATE_POLICY_COUNT, PROCESSOR_IDLESTATE_INFO]
  PPROCESSOR_IDLESTATE_POLICY* = ptr PROCESSOR_IDLESTATE_POLICY
  PROCESSOR_POWER_POLICY_INFO* {.pure.} = object
    TimeCheck*: DWORD
    DemoteLimit*: DWORD
    PromoteLimit*: DWORD
    DemotePercent*: BYTE
    PromotePercent*: BYTE
    Spare*: array[2, BYTE]
    AllowDemotion* {.bitsize:1.}: DWORD
    AllowPromotion* {.bitsize:1.}: DWORD
    Reserved* {.bitsize:30.}: DWORD
  PPROCESSOR_POWER_POLICY_INFO* = ptr PROCESSOR_POWER_POLICY_INFO
  PROCESSOR_POWER_POLICY* {.pure.} = object
    Revision*: DWORD
    DynamicThrottle*: BYTE
    Spare*: array[3, BYTE]
    DisableCStates* {.bitsize:1.}: DWORD
    Reserved* {.bitsize:31.}: DWORD
    PolicyCount*: DWORD
    Policy*: array[3, PROCESSOR_POWER_POLICY_INFO]
  PPROCESSOR_POWER_POLICY* = ptr PROCESSOR_POWER_POLICY
  PROCESSOR_PERFSTATE_POLICY_UNION1_Flags_STRUCT1* {.pure.} = object
    NoDomainAccounting* {.bitsize:1.}: BYTE
    IncreasePolicy* {.bitsize:2.}: BYTE
    DecreasePolicy* {.bitsize:2.}: BYTE
    Reserved* {.bitsize:3.}: BYTE
  PROCESSOR_PERFSTATE_POLICY_UNION1_Flags* {.pure, union.} = object
    AsBYTE*: BYTE
    struct1*: PROCESSOR_PERFSTATE_POLICY_UNION1_Flags_STRUCT1
  PROCESSOR_PERFSTATE_POLICY_UNION1* {.pure, union.} = object
    Spare*: BYTE
    Flags*: PROCESSOR_PERFSTATE_POLICY_UNION1_Flags
  PROCESSOR_PERFSTATE_POLICY* {.pure.} = object
    Revision*: DWORD
    MaxThrottle*: BYTE
    MinThrottle*: BYTE
    BusyAdjThreshold*: BYTE
    union1*: PROCESSOR_PERFSTATE_POLICY_UNION1
    TimeCheck*: DWORD
    IncreaseTime*: DWORD
    DecreaseTime*: DWORD
    IncreasePercent*: DWORD
    DecreasePercent*: DWORD
  PPROCESSOR_PERFSTATE_POLICY* = ptr PROCESSOR_PERFSTATE_POLICY
  ADMINISTRATOR_POWER_POLICY* {.pure.} = object
    MinSleep*: SYSTEM_POWER_STATE
    MaxSleep*: SYSTEM_POWER_STATE
    MinVideoTimeout*: DWORD
    MaxVideoTimeout*: DWORD
    MinSpindownTimeout*: DWORD
    MaxSpindownTimeout*: DWORD
  PADMINISTRATOR_POWER_POLICY* = ptr ADMINISTRATOR_POWER_POLICY
  SYSTEM_POWER_CAPABILITIES* {.pure.} = object
    PowerButtonPresent*: BOOLEAN
    SleepButtonPresent*: BOOLEAN
    LidPresent*: BOOLEAN
    SystemS1*: BOOLEAN
    SystemS2*: BOOLEAN
    SystemS3*: BOOLEAN
    SystemS4*: BOOLEAN
    SystemS5*: BOOLEAN
    HiberFilePresent*: BOOLEAN
    FullWake*: BOOLEAN
    VideoDimPresent*: BOOLEAN
    ApmPresent*: BOOLEAN
    UpsPresent*: BOOLEAN
    ThermalControl*: BOOLEAN
    ProcessorThrottle*: BOOLEAN
    ProcessorMinThrottle*: BYTE
    ProcessorMaxThrottle*: BYTE
    FastSystemS4*: BOOLEAN
    spare2*: array[3, BYTE]
    DiskSpinDown*: BOOLEAN
    spare3*: array[8, BYTE]
    SystemBatteriesPresent*: BOOLEAN
    BatteriesAreShortTerm*: BOOLEAN
    BatteryScale*: array[3, BATTERY_REPORTING_SCALE]
    AcOnLineWake*: SYSTEM_POWER_STATE
    SoftLidWake*: SYSTEM_POWER_STATE
    RtcWake*: SYSTEM_POWER_STATE
    MinDeviceWakeState*: SYSTEM_POWER_STATE
    DefaultLowLatencyWake*: SYSTEM_POWER_STATE
  PSYSTEM_POWER_CAPABILITIES* = ptr SYSTEM_POWER_CAPABILITIES
  SYSTEM_BATTERY_STATE* {.pure.} = object
    AcOnLine*: BOOLEAN
    BatteryPresent*: BOOLEAN
    Charging*: BOOLEAN
    Discharging*: BOOLEAN
    Spare1*: array[4, BOOLEAN]
    MaxCapacity*: DWORD
    RemainingCapacity*: DWORD
    Rate*: DWORD
    EstimatedTime*: DWORD
    DefaultAlert1*: DWORD
    DefaultAlert2*: DWORD
  PSYSTEM_BATTERY_STATE* = ptr SYSTEM_BATTERY_STATE
  IMAGE_DOS_HEADER* {.pure.} = object
    e_magic*: WORD
    e_cblp*: WORD
    e_cp*: WORD
    e_crlc*: WORD
    e_cparhdr*: WORD
    e_minalloc*: WORD
    e_maxalloc*: WORD
    e_ss*: WORD
    e_sp*: WORD
    e_csum*: WORD
    e_ip*: WORD
    e_cs*: WORD
    e_lfarlc*: WORD
    e_ovno*: WORD
    e_res*: array[4, WORD]
    e_oemid*: WORD
    e_oeminfo*: WORD
    e_res2*: array[10, WORD]
    e_lfanew*: LONG
  PIMAGE_DOS_HEADER* = ptr IMAGE_DOS_HEADER
  IMAGE_OS2_HEADER* {.pure.} = object
    ne_magic*: WORD
    ne_ver*: CHAR
    ne_rev*: CHAR
    ne_enttab*: WORD
    ne_cbenttab*: WORD
    ne_crc*: LONG
    ne_flags*: WORD
    ne_autodata*: WORD
    ne_heap*: WORD
    ne_stack*: WORD
    ne_csip*: LONG
    ne_sssp*: LONG
    ne_cseg*: WORD
    ne_cmod*: WORD
    ne_cbnrestab*: WORD
    ne_segtab*: WORD
    ne_rsrctab*: WORD
    ne_restab*: WORD
    ne_modtab*: WORD
    ne_imptab*: WORD
    ne_nrestab*: LONG
    ne_cmovent*: WORD
    ne_align*: WORD
    ne_cres*: WORD
    ne_exetyp*: BYTE
    ne_flagsothers*: BYTE
    ne_pretthunks*: WORD
    ne_psegrefbytes*: WORD
    ne_swaparea*: WORD
    ne_expver*: WORD
  PIMAGE_OS2_HEADER* = ptr IMAGE_OS2_HEADER
  IMAGE_VXD_HEADER* {.pure.} = object
    e32_magic*: WORD
    e32_border*: BYTE
    e32_worder*: BYTE
    e32_level*: DWORD
    e32_cpu*: WORD
    e32_os*: WORD
    e32_ver*: DWORD
    e32_mflags*: DWORD
    e32_mpages*: DWORD
    e32_startobj*: DWORD
    e32_eip*: DWORD
    e32_stackobj*: DWORD
    e32_esp*: DWORD
    e32_pagesize*: DWORD
    e32_lastpagesize*: DWORD
    e32_fixupsize*: DWORD
    e32_fixupsum*: DWORD
    e32_ldrsize*: DWORD
    e32_ldrsum*: DWORD
    e32_objtab*: DWORD
    e32_objcnt*: DWORD
    e32_objmap*: DWORD
    e32_itermap*: DWORD
    e32_rsrctab*: DWORD
    e32_rsrccnt*: DWORD
    e32_restab*: DWORD
    e32_enttab*: DWORD
    e32_dirtab*: DWORD
    e32_dircnt*: DWORD
    e32_fpagetab*: DWORD
    e32_frectab*: DWORD
    e32_impmod*: DWORD
    e32_impmodcnt*: DWORD
    e32_impproc*: DWORD
    e32_pagesum*: DWORD
    e32_datapage*: DWORD
    e32_preload*: DWORD
    e32_nrestab*: DWORD
    e32_cbnrestab*: DWORD
    e32_nressum*: DWORD
    e32_autodata*: DWORD
    e32_debuginfo*: DWORD
    e32_debuglen*: DWORD
    e32_instpreload*: DWORD
    e32_instdemand*: DWORD
    e32_heapsize*: DWORD
    e32_res3*: array[12, BYTE]
    e32_winresoff*: DWORD
    e32_winreslen*: DWORD
    e32_devid*: WORD
    e32_ddkver*: WORD
  PIMAGE_VXD_HEADER* = ptr IMAGE_VXD_HEADER
  IMAGE_FILE_HEADER* {.pure.} = object
    Machine*: WORD
    NumberOfSections*: WORD
    TimeDateStamp*: DWORD
    PointerToSymbolTable*: DWORD
    NumberOfSymbols*: DWORD
    SizeOfOptionalHeader*: WORD
    Characteristics*: WORD
  PIMAGE_FILE_HEADER* = ptr IMAGE_FILE_HEADER
  IMAGE_DATA_DIRECTORY* {.pure.} = object
    VirtualAddress*: DWORD
    Size*: DWORD
  PIMAGE_DATA_DIRECTORY* = ptr IMAGE_DATA_DIRECTORY
const
  IMAGE_NUMBEROF_DIRECTORY_ENTRIES* = 16
type
  IMAGE_OPTIONAL_HEADER32* {.pure.} = object
    Magic*: WORD
    MajorLinkerVersion*: BYTE
    MinorLinkerVersion*: BYTE
    SizeOfCode*: DWORD
    SizeOfInitializedData*: DWORD
    SizeOfUninitializedData*: DWORD
    AddressOfEntryPoint*: DWORD
    BaseOfCode*: DWORD
    BaseOfData*: DWORD
    ImageBase*: DWORD
    SectionAlignment*: DWORD
    FileAlignment*: DWORD
    MajorOperatingSystemVersion*: WORD
    MinorOperatingSystemVersion*: WORD
    MajorImageVersion*: WORD
    MinorImageVersion*: WORD
    MajorSubsystemVersion*: WORD
    MinorSubsystemVersion*: WORD
    Win32VersionValue*: DWORD
    SizeOfImage*: DWORD
    SizeOfHeaders*: DWORD
    CheckSum*: DWORD
    Subsystem*: WORD
    DllCharacteristics*: WORD
    SizeOfStackReserve*: DWORD
    SizeOfStackCommit*: DWORD
    SizeOfHeapReserve*: DWORD
    SizeOfHeapCommit*: DWORD
    LoaderFlags*: DWORD
    NumberOfRvaAndSizes*: DWORD
    DataDirectory*: array[IMAGE_NUMBEROF_DIRECTORY_ENTRIES, IMAGE_DATA_DIRECTORY]
  PIMAGE_OPTIONAL_HEADER32* = ptr IMAGE_OPTIONAL_HEADER32
  IMAGE_ROM_OPTIONAL_HEADER* {.pure.} = object
    Magic*: WORD
    MajorLinkerVersion*: BYTE
    MinorLinkerVersion*: BYTE
    SizeOfCode*: DWORD
    SizeOfInitializedData*: DWORD
    SizeOfUninitializedData*: DWORD
    AddressOfEntryPoint*: DWORD
    BaseOfCode*: DWORD
    BaseOfData*: DWORD
    BaseOfBss*: DWORD
    GprMask*: DWORD
    CprMask*: array[4, DWORD]
    GpValue*: DWORD
  PIMAGE_ROM_OPTIONAL_HEADER* = ptr IMAGE_ROM_OPTIONAL_HEADER
  IMAGE_OPTIONAL_HEADER64* {.pure.} = object
    Magic*: WORD
    MajorLinkerVersion*: BYTE
    MinorLinkerVersion*: BYTE
    SizeOfCode*: DWORD
    SizeOfInitializedData*: DWORD
    SizeOfUninitializedData*: DWORD
    AddressOfEntryPoint*: DWORD
    BaseOfCode*: DWORD
    ImageBase*: ULONGLONG
    SectionAlignment*: DWORD
    FileAlignment*: DWORD
    MajorOperatingSystemVersion*: WORD
    MinorOperatingSystemVersion*: WORD
    MajorImageVersion*: WORD
    MinorImageVersion*: WORD
    MajorSubsystemVersion*: WORD
    MinorSubsystemVersion*: WORD
    Win32VersionValue*: DWORD
    SizeOfImage*: DWORD
    SizeOfHeaders*: DWORD
    CheckSum*: DWORD
    Subsystem*: WORD
    DllCharacteristics*: WORD
    SizeOfStackReserve*: ULONGLONG
    SizeOfStackCommit*: ULONGLONG
    SizeOfHeapReserve*: ULONGLONG
    SizeOfHeapCommit*: ULONGLONG
    LoaderFlags*: DWORD
    NumberOfRvaAndSizes*: DWORD
    DataDirectory*: array[IMAGE_NUMBEROF_DIRECTORY_ENTRIES, IMAGE_DATA_DIRECTORY]
  PIMAGE_OPTIONAL_HEADER64* = ptr IMAGE_OPTIONAL_HEADER64
  IMAGE_NT_HEADERS64* {.pure.} = object
    Signature*: DWORD
    FileHeader*: IMAGE_FILE_HEADER
    OptionalHeader*: IMAGE_OPTIONAL_HEADER64
  PIMAGE_NT_HEADERS64* = ptr IMAGE_NT_HEADERS64
  IMAGE_NT_HEADERS32* {.pure.} = object
    Signature*: DWORD
    FileHeader*: IMAGE_FILE_HEADER
    OptionalHeader*: IMAGE_OPTIONAL_HEADER32
  PIMAGE_NT_HEADERS32* = ptr IMAGE_NT_HEADERS32
  IMAGE_ROM_HEADERS* {.pure.} = object
    FileHeader*: IMAGE_FILE_HEADER
    OptionalHeader*: IMAGE_ROM_OPTIONAL_HEADER
  PIMAGE_ROM_HEADERS* = ptr IMAGE_ROM_HEADERS
const
  IMAGE_SIZEOF_SHORT_NAME* = 8
type
  IMAGE_SECTION_HEADER_Misc* {.pure, union.} = object
    PhysicalAddress*: DWORD
    VirtualSize*: DWORD
  IMAGE_SECTION_HEADER* {.pure.} = object
    Name*: array[IMAGE_SIZEOF_SHORT_NAME, BYTE]
    Misc*: IMAGE_SECTION_HEADER_Misc
    VirtualAddress*: DWORD
    SizeOfRawData*: DWORD
    PointerToRawData*: DWORD
    PointerToRelocations*: DWORD
    PointerToLinenumbers*: DWORD
    NumberOfRelocations*: WORD
    NumberOfLinenumbers*: WORD
    Characteristics*: DWORD
  PIMAGE_SECTION_HEADER* = ptr IMAGE_SECTION_HEADER
  IMAGE_SYMBOL_N_Name* {.pure.} = object
    Short*: DWORD
    Long*: DWORD
  IMAGE_SYMBOL_N* {.pure, union.} = object
    ShortName*: array[8, BYTE]
    Name*: IMAGE_SYMBOL_N_Name
    LongName*: array[2, DWORD]
  IMAGE_SYMBOL* {.pure, packed.} = object
    N*: IMAGE_SYMBOL_N
    Value*: DWORD
    SectionNumber*: SHORT
    Type*: WORD
    StorageClass*: BYTE
    NumberOfAuxSymbols*: BYTE
  PIMAGE_SYMBOL* = ptr IMAGE_SYMBOL
  IMAGE_SYMBOL_EX_N_Name* {.pure.} = object
    Short*: DWORD
    Long*: DWORD
  IMAGE_SYMBOL_EX_N* {.pure, union.} = object
    ShortName*: array[8, BYTE]
    Name*: IMAGE_SYMBOL_EX_N_Name
    LongName*: array[2, DWORD]
  IMAGE_SYMBOL_EX* {.pure.} = object
    N*: IMAGE_SYMBOL_EX_N
    Value*: DWORD
    SectionNumber*: LONG
    Type*: WORD
    StorageClass*: BYTE
    NumberOfAuxSymbols*: BYTE
  PIMAGE_SYMBOL_EX* = ptr IMAGE_SYMBOL_EX
  IMAGE_AUX_SYMBOL_TOKEN_DEF* {.pure, packed.} = object
    bAuxType*: BYTE
    bReserved*: BYTE
    SymbolTableIndex*: DWORD
    rgbReserved*: array[12, BYTE]
  PIMAGE_AUX_SYMBOL_TOKEN_DEF* = ptr IMAGE_AUX_SYMBOL_TOKEN_DEF
  IMAGE_AUX_SYMBOL_Sym_Misc_LnSz* {.pure.} = object
    Linenumber*: WORD
    Size*: WORD
  IMAGE_AUX_SYMBOL_Sym_Misc* {.pure, union.} = object
    LnSz*: IMAGE_AUX_SYMBOL_Sym_Misc_LnSz
    TotalSize*: DWORD
  IMAGE_AUX_SYMBOL_Sym_FcnAry_Function* {.pure.} = object
    PointerToLinenumber*: DWORD
    PointerToNextFunction*: DWORD
  IMAGE_AUX_SYMBOL_Sym_FcnAry_Array* {.pure.} = object
    Dimension*: array[4, WORD]
  IMAGE_AUX_SYMBOL_Sym_FcnAry* {.pure, union.} = object
    Function*: IMAGE_AUX_SYMBOL_Sym_FcnAry_Function
    Array*: IMAGE_AUX_SYMBOL_Sym_FcnAry_Array
  IMAGE_AUX_SYMBOL_Sym* {.pure.} = object
    TagIndex*: DWORD
    Misc*: IMAGE_AUX_SYMBOL_Sym_Misc
    FcnAry*: IMAGE_AUX_SYMBOL_Sym_FcnAry
    TvIndex*: WORD
const
  IMAGE_SIZEOF_SYMBOL* = 18
type
  IMAGE_AUX_SYMBOL_File* {.pure.} = object
    Name*: array[IMAGE_SIZEOF_SYMBOL, BYTE]
  IMAGE_AUX_SYMBOL_Section* {.pure.} = object
    Length*: DWORD
    NumberOfRelocations*: WORD
    NumberOfLinenumbers*: WORD
    CheckSum*: DWORD
    Number*: SHORT
    Selection*: BYTE
  IMAGE_AUX_SYMBOL_CRC* {.pure.} = object
    crc*: DWORD
    rgbReserved*: array[14, BYTE]
  IMAGE_AUX_SYMBOL* {.pure, union.} = object
    Sym*: IMAGE_AUX_SYMBOL_Sym
    File*: IMAGE_AUX_SYMBOL_File
    Section*: IMAGE_AUX_SYMBOL_Section
    TokenDef*: IMAGE_AUX_SYMBOL_TOKEN_DEF
    CRC*: IMAGE_AUX_SYMBOL_CRC
  PIMAGE_AUX_SYMBOL* = ptr IMAGE_AUX_SYMBOL
  IMAGE_AUX_SYMBOL_EX_Sym* {.pure.} = object
    WeakDefaultSymIndex*: DWORD
    WeakSearchType*: DWORD
    rgbReserved*: array[12, BYTE]
  IMAGE_AUX_SYMBOL_EX_File* {.pure.} = object
    Name*: array[20, BYTE]
  IMAGE_AUX_SYMBOL_EX_Section* {.pure.} = object
    Length*: DWORD
    NumberOfRelocations*: WORD
    NumberOfLinenumbers*: WORD
    CheckSum*: DWORD
    Number*: SHORT
    Selection*: BYTE
    bReserved*: BYTE
    HighNumber*: SHORT
    rgbReserved*: array[2, BYTE]
  IMAGE_AUX_SYMBOL_EX_STRUCT4* {.pure.} = object
    TokenDef*: IMAGE_AUX_SYMBOL_TOKEN_DEF
    rgbReserved*: array[2, BYTE]
  IMAGE_AUX_SYMBOL_EX_CRC* {.pure.} = object
    crc*: DWORD
    rgbReserved*: array[16, BYTE]
  IMAGE_AUX_SYMBOL_EX* {.pure, union.} = object
    Sym*: IMAGE_AUX_SYMBOL_EX_Sym
    File*: IMAGE_AUX_SYMBOL_EX_File
    Section*: IMAGE_AUX_SYMBOL_EX_Section
    struct4*: IMAGE_AUX_SYMBOL_EX_STRUCT4
    CRC*: IMAGE_AUX_SYMBOL_EX_CRC
  PIMAGE_AUX_SYMBOL_EX* = ptr IMAGE_AUX_SYMBOL_EX
  IMAGE_RELOCATION_UNION1* {.pure, union.} = object
    VirtualAddress*: DWORD
    RelocCount*: DWORD
  IMAGE_RELOCATION* {.pure, packed.} = object
    union1*: IMAGE_RELOCATION_UNION1
    SymbolTableIndex*: DWORD
    Type*: WORD
  PIMAGE_RELOCATION* = ptr IMAGE_RELOCATION
  IMAGE_LINENUMBER_Type* {.pure, union.} = object
    SymbolTableIndex*: DWORD
    VirtualAddress*: DWORD
  IMAGE_LINENUMBER* {.pure, packed.} = object
    Type*: IMAGE_LINENUMBER_Type
    Linenumber*: WORD
  PIMAGE_LINENUMBER* = ptr IMAGE_LINENUMBER
  IMAGE_BASE_RELOCATION* {.pure.} = object
    VirtualAddress*: DWORD
    SizeOfBlock*: DWORD
  PIMAGE_BASE_RELOCATION* = ptr IMAGE_BASE_RELOCATION
  IMAGE_ARCHIVE_MEMBER_HEADER* {.pure.} = object
    Name*: array[16, BYTE]
    Date*: array[12, BYTE]
    UserID*: array[6, BYTE]
    GroupID*: array[6, BYTE]
    Mode*: array[8, BYTE]
    Size*: array[10, BYTE]
    EndHeader*: array[2, BYTE]
  PIMAGE_ARCHIVE_MEMBER_HEADER* = ptr IMAGE_ARCHIVE_MEMBER_HEADER
  IMAGE_EXPORT_DIRECTORY* {.pure.} = object
    Characteristics*: DWORD
    TimeDateStamp*: DWORD
    MajorVersion*: WORD
    MinorVersion*: WORD
    Name*: DWORD
    Base*: DWORD
    NumberOfFunctions*: DWORD
    NumberOfNames*: DWORD
    AddressOfFunctions*: DWORD
    AddressOfNames*: DWORD
    AddressOfNameOrdinals*: DWORD
  PIMAGE_EXPORT_DIRECTORY* = ptr IMAGE_EXPORT_DIRECTORY
  IMAGE_IMPORT_BY_NAME* {.pure.} = object
    Hint*: WORD
    Name*: array[1, BYTE]
  PIMAGE_IMPORT_BY_NAME* = ptr IMAGE_IMPORT_BY_NAME
  IMAGE_THUNK_DATA64_u1* {.pure, union.} = object
    ForwarderString*: ULONGLONG
    Function*: ULONGLONG
    Ordinal*: ULONGLONG
    AddressOfData*: ULONGLONG
  IMAGE_THUNK_DATA64* {.pure.} = object
    u1*: IMAGE_THUNK_DATA64_u1
  PIMAGE_THUNK_DATA64* = ptr IMAGE_THUNK_DATA64
  IMAGE_THUNK_DATA32_u1* {.pure, union.} = object
    ForwarderString*: DWORD
    Function*: DWORD
    Ordinal*: DWORD
    AddressOfData*: DWORD
  IMAGE_THUNK_DATA32* {.pure.} = object
    u1*: IMAGE_THUNK_DATA32_u1
  PIMAGE_THUNK_DATA32* = ptr IMAGE_THUNK_DATA32
  IMAGE_TLS_DIRECTORY64* {.pure.} = object
    StartAddressOfRawData*: ULONGLONG
    EndAddressOfRawData*: ULONGLONG
    AddressOfIndex*: ULONGLONG
    AddressOfCallBacks*: ULONGLONG
    SizeOfZeroFill*: DWORD
    Characteristics*: DWORD
  PIMAGE_TLS_DIRECTORY64* = ptr IMAGE_TLS_DIRECTORY64
  IMAGE_TLS_DIRECTORY32* {.pure.} = object
    StartAddressOfRawData*: DWORD
    EndAddressOfRawData*: DWORD
    AddressOfIndex*: DWORD
    AddressOfCallBacks*: DWORD
    SizeOfZeroFill*: DWORD
    Characteristics*: DWORD
  PIMAGE_TLS_DIRECTORY32* = ptr IMAGE_TLS_DIRECTORY32
  IMAGE_IMPORT_DESCRIPTOR_UNION1* {.pure, union.} = object
    Characteristics*: DWORD
    OriginalFirstThunk*: DWORD
  IMAGE_IMPORT_DESCRIPTOR* {.pure.} = object
    union1*: IMAGE_IMPORT_DESCRIPTOR_UNION1
    TimeDateStamp*: DWORD
    ForwarderChain*: DWORD
    Name*: DWORD
    FirstThunk*: DWORD
  PIMAGE_IMPORT_DESCRIPTOR* = ptr IMAGE_IMPORT_DESCRIPTOR
  IMAGE_BOUND_IMPORT_DESCRIPTOR* {.pure.} = object
    TimeDateStamp*: DWORD
    OffsetModuleName*: WORD
    NumberOfModuleForwarderRefs*: WORD
  PIMAGE_BOUND_IMPORT_DESCRIPTOR* = ptr IMAGE_BOUND_IMPORT_DESCRIPTOR
  IMAGE_BOUND_FORWARDER_REF* {.pure.} = object
    TimeDateStamp*: DWORD
    OffsetModuleName*: WORD
    Reserved*: WORD
  PIMAGE_BOUND_FORWARDER_REF* = ptr IMAGE_BOUND_FORWARDER_REF
  IMAGE_DELAYLOAD_DESCRIPTOR_Attributes_STRUCT1* {.pure.} = object
    RvaBased* {.bitsize:1.}: DWORD
    ReservedAttributes* {.bitsize:31.}: DWORD
  IMAGE_DELAYLOAD_DESCRIPTOR_Attributes* {.pure, union.} = object
    AllAttributes*: DWORD
    struct1*: IMAGE_DELAYLOAD_DESCRIPTOR_Attributes_STRUCT1
  IMAGE_DELAYLOAD_DESCRIPTOR* {.pure.} = object
    Attributes*: IMAGE_DELAYLOAD_DESCRIPTOR_Attributes
    DllNameRVA*: DWORD
    ModuleHandleRVA*: DWORD
    ImportAddressTableRVA*: DWORD
    ImportNameTableRVA*: DWORD
    BoundImportAddressTableRVA*: DWORD
    UnloadInformationTableRVA*: DWORD
    TimeDateStamp*: DWORD
  PIMAGE_DELAYLOAD_DESCRIPTOR* = ptr IMAGE_DELAYLOAD_DESCRIPTOR
  PCIMAGE_DELAYLOAD_DESCRIPTOR* = ptr IMAGE_DELAYLOAD_DESCRIPTOR
  IMAGE_RESOURCE_DIRECTORY* {.pure.} = object
    Characteristics*: DWORD
    TimeDateStamp*: DWORD
    MajorVersion*: WORD
    MinorVersion*: WORD
    NumberOfNamedEntries*: WORD
    NumberOfIdEntries*: WORD
  PIMAGE_RESOURCE_DIRECTORY* = ptr IMAGE_RESOURCE_DIRECTORY
  IMAGE_RESOURCE_DIRECTORY_ENTRY_UNION1_STRUCT1* {.pure.} = object
    NameOffset* {.bitsize:31.}: DWORD
    NameIsString* {.bitsize:1.}: DWORD
  IMAGE_RESOURCE_DIRECTORY_ENTRY_UNION1* {.pure, union.} = object
    struct1*: IMAGE_RESOURCE_DIRECTORY_ENTRY_UNION1_STRUCT1
    Name*: DWORD
    Id*: WORD
  IMAGE_RESOURCE_DIRECTORY_ENTRY_UNION2_STRUCT1* {.pure.} = object
    OffsetToDirectory* {.bitsize:31.}: DWORD
    DataIsDirectory* {.bitsize:1.}: DWORD
  IMAGE_RESOURCE_DIRECTORY_ENTRY_UNION2* {.pure, union.} = object
    OffsetToData*: DWORD
    struct1*: IMAGE_RESOURCE_DIRECTORY_ENTRY_UNION2_STRUCT1
  IMAGE_RESOURCE_DIRECTORY_ENTRY* {.pure.} = object
    union1*: IMAGE_RESOURCE_DIRECTORY_ENTRY_UNION1
    union2*: IMAGE_RESOURCE_DIRECTORY_ENTRY_UNION2
  PIMAGE_RESOURCE_DIRECTORY_ENTRY* = ptr IMAGE_RESOURCE_DIRECTORY_ENTRY
  IMAGE_RESOURCE_DIRECTORY_STRING* {.pure.} = object
    Length*: WORD
    NameString*: array[1, CHAR]
  PIMAGE_RESOURCE_DIRECTORY_STRING* = ptr IMAGE_RESOURCE_DIRECTORY_STRING
  IMAGE_RESOURCE_DIR_STRING_U* {.pure.} = object
    Length*: WORD
    NameString*: array[1, WCHAR]
  PIMAGE_RESOURCE_DIR_STRING_U* = ptr IMAGE_RESOURCE_DIR_STRING_U
  IMAGE_RESOURCE_DATA_ENTRY* {.pure.} = object
    OffsetToData*: DWORD
    Size*: DWORD
    CodePage*: DWORD
    Reserved*: DWORD
  PIMAGE_RESOURCE_DATA_ENTRY* = ptr IMAGE_RESOURCE_DATA_ENTRY
  IMAGE_LOAD_CONFIG_DIRECTORY32* {.pure.} = object
    Size*: DWORD
    TimeDateStamp*: DWORD
    MajorVersion*: WORD
    MinorVersion*: WORD
    GlobalFlagsClear*: DWORD
    GlobalFlagsSet*: DWORD
    CriticalSectionDefaultTimeout*: DWORD
    DeCommitFreeBlockThreshold*: DWORD
    DeCommitTotalFreeThreshold*: DWORD
    LockPrefixTable*: DWORD
    MaximumAllocationSize*: DWORD
    VirtualMemoryThreshold*: DWORD
    ProcessHeapFlags*: DWORD
    ProcessAffinityMask*: DWORD
    CSDVersion*: WORD
    Reserved1*: WORD
    EditList*: DWORD
    SecurityCookie*: DWORD
    SEHandlerTable*: DWORD
    SEHandlerCount*: DWORD
  PIMAGE_LOAD_CONFIG_DIRECTORY32* = ptr IMAGE_LOAD_CONFIG_DIRECTORY32
  IMAGE_LOAD_CONFIG_DIRECTORY64* {.pure.} = object
    Size*: DWORD
    TimeDateStamp*: DWORD
    MajorVersion*: WORD
    MinorVersion*: WORD
    GlobalFlagsClear*: DWORD
    GlobalFlagsSet*: DWORD
    CriticalSectionDefaultTimeout*: DWORD
    DeCommitFreeBlockThreshold*: ULONGLONG
    DeCommitTotalFreeThreshold*: ULONGLONG
    LockPrefixTable*: ULONGLONG
    MaximumAllocationSize*: ULONGLONG
    VirtualMemoryThreshold*: ULONGLONG
    ProcessAffinityMask*: ULONGLONG
    ProcessHeapFlags*: DWORD
    CSDVersion*: WORD
    Reserved1*: WORD
    EditList*: ULONGLONG
    SecurityCookie*: ULONGLONG
    SEHandlerTable*: ULONGLONG
    SEHandlerCount*: ULONGLONG
  PIMAGE_LOAD_CONFIG_DIRECTORY64* = ptr IMAGE_LOAD_CONFIG_DIRECTORY64
  IMAGE_DEBUG_DIRECTORY* {.pure.} = object
    Characteristics*: DWORD
    TimeDateStamp*: DWORD
    MajorVersion*: WORD
    MinorVersion*: WORD
    Type*: DWORD
    SizeOfData*: DWORD
    AddressOfRawData*: DWORD
    PointerToRawData*: DWORD
  PIMAGE_DEBUG_DIRECTORY* = ptr IMAGE_DEBUG_DIRECTORY
  IMAGE_COFF_SYMBOLS_HEADER* {.pure.} = object
    NumberOfSymbols*: DWORD
    LvaToFirstSymbol*: DWORD
    NumberOfLinenumbers*: DWORD
    LvaToFirstLinenumber*: DWORD
    RvaToFirstByteOfCode*: DWORD
    RvaToLastByteOfCode*: DWORD
    RvaToFirstByteOfData*: DWORD
    RvaToLastByteOfData*: DWORD
  PIMAGE_COFF_SYMBOLS_HEADER* = ptr IMAGE_COFF_SYMBOLS_HEADER
  FPO_DATA* {.pure.} = object
    ulOffStart*: DWORD
    cbProcSize*: DWORD
    cdwLocals*: DWORD
    cdwParams*: WORD
    cbProlog* {.bitsize:8.}: WORD
    cbRegs* {.bitsize:3.}: WORD
    fHasSEH* {.bitsize:1.}: WORD
    fUseBP* {.bitsize:1.}: WORD
    reserved* {.bitsize:1.}: WORD
    cbFrame* {.bitsize:2.}: WORD
  PFPO_DATA* = ptr FPO_DATA
  IMAGE_DEBUG_MISC* {.pure.} = object
    DataType*: DWORD
    Length*: DWORD
    Unicode*: BOOLEAN
    Reserved*: array[3, BYTE]
    Data*: array[1, BYTE]
  PIMAGE_DEBUG_MISC* = ptr IMAGE_DEBUG_MISC
  IMAGE_FUNCTION_ENTRY* {.pure.} = object
    StartingAddress*: DWORD
    EndingAddress*: DWORD
    EndOfPrologue*: DWORD
  PIMAGE_FUNCTION_ENTRY* = ptr IMAGE_FUNCTION_ENTRY
  IMAGE_FUNCTION_ENTRY64_UNION1* {.pure, union.} = object
    EndOfPrologue*: ULONGLONG
    UnwindInfoAddress*: ULONGLONG
  IMAGE_FUNCTION_ENTRY64* {.pure.} = object
    StartingAddress*: ULONGLONG
    EndingAddress*: ULONGLONG
    union1*: IMAGE_FUNCTION_ENTRY64_UNION1
  PIMAGE_FUNCTION_ENTRY64* = ptr IMAGE_FUNCTION_ENTRY64
  IMAGE_SEPARATE_DEBUG_HEADER* {.pure.} = object
    Signature*: WORD
    Flags*: WORD
    Machine*: WORD
    Characteristics*: WORD
    TimeDateStamp*: DWORD
    CheckSum*: DWORD
    ImageBase*: DWORD
    SizeOfImage*: DWORD
    NumberOfSections*: DWORD
    ExportedNamesSize*: DWORD
    DebugDirectorySize*: DWORD
    SectionAlignment*: DWORD
    Reserved*: array[2, DWORD]
  PIMAGE_SEPARATE_DEBUG_HEADER* = ptr IMAGE_SEPARATE_DEBUG_HEADER
  NON_PAGED_DEBUG_INFO* {.pure.} = object
    Signature*: WORD
    Flags*: WORD
    Size*: DWORD
    Machine*: WORD
    Characteristics*: WORD
    TimeDateStamp*: DWORD
    CheckSum*: DWORD
    SizeOfImage*: DWORD
    ImageBase*: ULONGLONG
  PNON_PAGED_DEBUG_INFO* = ptr NON_PAGED_DEBUG_INFO
  IMAGE_ARCHITECTURE_HEADER* {.pure.} = object
    AmaskValue* {.bitsize:1.}: int32
    Adummy1* {.bitsize:7.}: int32
    AmaskShift* {.bitsize:8.}: int32
    Adummy2* {.bitsize:16.}: int32
    FirstEntryRVA*: DWORD
  PIMAGE_ARCHITECTURE_HEADER* = ptr IMAGE_ARCHITECTURE_HEADER
  IMAGE_ARCHITECTURE_ENTRY* {.pure.} = object
    FixupInstRVA*: DWORD
    NewInst*: DWORD
  PIMAGE_ARCHITECTURE_ENTRY* = ptr IMAGE_ARCHITECTURE_ENTRY
  IMAGE_COR20_HEADER_UNION1* {.pure, union.} = object
    EntryPointToken*: DWORD
    EntryPointRVA*: DWORD
  IMAGE_COR20_HEADER* {.pure.} = object
    cb*: DWORD
    MajorRuntimeVersion*: WORD
    MinorRuntimeVersion*: WORD
    MetaData*: IMAGE_DATA_DIRECTORY
    Flags*: DWORD
    union1*: IMAGE_COR20_HEADER_UNION1
    Resources*: IMAGE_DATA_DIRECTORY
    StrongNameSignature*: IMAGE_DATA_DIRECTORY
    CodeManagerTable*: IMAGE_DATA_DIRECTORY
    VTableFixups*: IMAGE_DATA_DIRECTORY
    ExportAddressTableJumps*: IMAGE_DATA_DIRECTORY
    ManagedNativeHeader*: IMAGE_DATA_DIRECTORY
  PIMAGE_COR20_HEADER* = ptr IMAGE_COR20_HEADER
  RTL_RUN_ONCE* {.pure.} = object
    Ptr*: PVOID
  PRTL_RUN_ONCE* = ptr RTL_RUN_ONCE
  RTL_BARRIER* {.pure.} = object
    Reserved1*: DWORD
    Reserved2*: DWORD
    Reserved3*: array[2, ULONG_PTR]
    Reserved4*: DWORD
    Reserved5*: DWORD
  PRTL_BARRIER* = ptr RTL_BARRIER
  MESSAGE_RESOURCE_ENTRY* {.pure.} = object
    Length*: WORD
    Flags*: WORD
    Text*: array[1, BYTE]
  PMESSAGE_RESOURCE_ENTRY* = ptr MESSAGE_RESOURCE_ENTRY
  MESSAGE_RESOURCE_BLOCK* {.pure.} = object
    LowId*: DWORD
    HighId*: DWORD
    OffsetToEntries*: DWORD
  PMESSAGE_RESOURCE_BLOCK* = ptr MESSAGE_RESOURCE_BLOCK
  MESSAGE_RESOURCE_DATA* {.pure.} = object
    NumberOfBlocks*: DWORD
    Blocks*: array[1, MESSAGE_RESOURCE_BLOCK]
  PMESSAGE_RESOURCE_DATA* = ptr MESSAGE_RESOURCE_DATA
  OSVERSIONINFOA* {.pure.} = object
    dwOSVersionInfoSize*: DWORD
    dwMajorVersion*: DWORD
    dwMinorVersion*: DWORD
    dwBuildNumber*: DWORD
    dwPlatformId*: DWORD
    szCSDVersion*: array[128, CHAR]
  POSVERSIONINFOA* = ptr OSVERSIONINFOA
  LPOSVERSIONINFOA* = ptr OSVERSIONINFOA
  OSVERSIONINFOW* {.pure.} = object
    dwOSVersionInfoSize*: DWORD
    dwMajorVersion*: DWORD
    dwMinorVersion*: DWORD
    dwBuildNumber*: DWORD
    dwPlatformId*: DWORD
    szCSDVersion*: array[128, WCHAR]
  POSVERSIONINFOW* = ptr OSVERSIONINFOW
  LPOSVERSIONINFOW* = ptr OSVERSIONINFOW
  RTL_OSVERSIONINFOW* = OSVERSIONINFOW
  PRTL_OSVERSIONINFOW* = ptr OSVERSIONINFOW
  OSVERSIONINFOEXA* {.pure.} = object
    dwOSVersionInfoSize*: DWORD
    dwMajorVersion*: DWORD
    dwMinorVersion*: DWORD
    dwBuildNumber*: DWORD
    dwPlatformId*: DWORD
    szCSDVersion*: array[128, CHAR]
    wServicePackMajor*: WORD
    wServicePackMinor*: WORD
    wSuiteMask*: WORD
    wProductType*: BYTE
    wReserved*: BYTE
  POSVERSIONINFOEXA* = ptr OSVERSIONINFOEXA
  LPOSVERSIONINFOEXA* = ptr OSVERSIONINFOEXA
  OSVERSIONINFOEXW* {.pure.} = object
    dwOSVersionInfoSize*: DWORD
    dwMajorVersion*: DWORD
    dwMinorVersion*: DWORD
    dwBuildNumber*: DWORD
    dwPlatformId*: DWORD
    szCSDVersion*: array[128, WCHAR]
    wServicePackMajor*: WORD
    wServicePackMinor*: WORD
    wSuiteMask*: WORD
    wProductType*: BYTE
    wReserved*: BYTE
  POSVERSIONINFOEXW* = ptr OSVERSIONINFOEXW
  LPOSVERSIONINFOEXW* = ptr OSVERSIONINFOEXW
  RTL_OSVERSIONINFOEXW* = OSVERSIONINFOEXW
  PRTL_OSVERSIONINFOEXW* = ptr OSVERSIONINFOEXW
  RTL_UMS_SCHEDULER_ENTRY_POINT* = proc (Reason: RTL_UMS_SCHEDULER_REASON, ActivationPayload: ULONG_PTR, SchedulerParam: PVOID): VOID {.stdcall.}
  PRTL_UMS_SCHEDULER_ENTRY_POINT* = RTL_UMS_SCHEDULER_ENTRY_POINT
  RTL_CRITICAL_SECTION* {.pure.} = object
    DebugInfo*: PRTL_CRITICAL_SECTION_DEBUG
    LockCount*: LONG
    RecursionCount*: LONG
    OwningThread*: HANDLE
    LockSemaphore*: HANDLE
    SpinCount*: ULONG_PTR
  RTL_CRITICAL_SECTION_DEBUG* {.pure.} = object
    Type*: WORD
    CreatorBackTraceIndex*: WORD
    CriticalSection*: ptr RTL_CRITICAL_SECTION
    ProcessLocksList*: LIST_ENTRY
    EntryCount*: DWORD
    ContentionCount*: DWORD
    Flags*: DWORD
    CreatorBackTraceIndexHigh*: WORD
    SpareWORD*: WORD
  PRTL_CRITICAL_SECTION_DEBUG* = ptr RTL_CRITICAL_SECTION_DEBUG
  RTL_RESOURCE_DEBUG* = RTL_CRITICAL_SECTION_DEBUG
  PRTL_RESOURCE_DEBUG* = ptr RTL_CRITICAL_SECTION_DEBUG
  PRTL_CRITICAL_SECTION* = ptr RTL_CRITICAL_SECTION
  RTL_SRWLOCK* {.pure.} = object
    Ptr*: PVOID
  PRTL_SRWLOCK* = ptr RTL_SRWLOCK
  RTL_CONDITION_VARIABLE* {.pure.} = object
    Ptr*: PVOID
  PRTL_CONDITION_VARIABLE* = ptr RTL_CONDITION_VARIABLE
  WAITORTIMERCALLBACKFUNC* = proc (P1: PVOID, P2: BOOLEAN): VOID {.stdcall.}
  WAITORTIMERCALLBACK* = WAITORTIMERCALLBACKFUNC
  ACTIVATION_CONTEXT_QUERY_INDEX* {.pure.} = object
    ulAssemblyIndex*: DWORD
    ulFileIndexInAssembly*: DWORD
  PACTIVATION_CONTEXT_QUERY_INDEX* = ptr ACTIVATION_CONTEXT_QUERY_INDEX
  ASSEMBLY_FILE_DETAILED_INFORMATION* {.pure.} = object
    ulFlags*: DWORD
    ulFilenameLength*: DWORD
    ulPathLength*: DWORD
    lpFileName*: PCWSTR
    lpFilePath*: PCWSTR
  PASSEMBLY_FILE_DETAILED_INFORMATION* = ptr ASSEMBLY_FILE_DETAILED_INFORMATION
  ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION* {.pure.} = object
    ulFlags*: DWORD
    ulEncodedAssemblyIdentityLength*: DWORD
    ulManifestPathType*: DWORD
    ulManifestPathLength*: DWORD
    liManifestLastWriteTime*: LARGE_INTEGER
    ulPolicyPathType*: DWORD
    ulPolicyPathLength*: DWORD
    liPolicyLastWriteTime*: LARGE_INTEGER
    ulMetadataSatelliteRosterIndex*: DWORD
    ulManifestVersionMajor*: DWORD
    ulManifestVersionMinor*: DWORD
    ulPolicyVersionMajor*: DWORD
    ulPolicyVersionMinor*: DWORD
    ulAssemblyDirectoryNameLength*: DWORD
    lpAssemblyEncodedAssemblyIdentity*: PCWSTR
    lpAssemblyManifestPath*: PCWSTR
    lpAssemblyPolicyPath*: PCWSTR
    lpAssemblyDirectoryName*: PCWSTR
    ulFileCount*: DWORD
  PACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION* = ptr ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION
  ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION* {.pure.} = object
    ulFlags*: DWORD
    RunLevel*: ACTCTX_REQUESTED_RUN_LEVEL
    UiAccess*: DWORD
  PACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION* = ptr ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION
  COMPATIBILITY_CONTEXT_ELEMENT* {.pure.} = object
    Id*: GUID
    Type*: ACTCTX_COMPATIBILITY_ELEMENT_TYPE
  PCOMPATIBILITY_CONTEXT_ELEMENT* = ptr COMPATIBILITY_CONTEXT_ELEMENT
  ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION* {.pure.} = object
    ElementCount*: DWORD
    Elements*: UncheckedArray[COMPATIBILITY_CONTEXT_ELEMENT]
  PACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION* = ptr ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION
const
  MAX_SUPPORTED_OS_NUM* = 4
type
  SUPPORTED_OS_INFO* {.pure.} = object
    OsCount*: WORD
    MitigationExist*: WORD
    OsList*: array[MAX_SUPPORTED_OS_NUM, WORD]
  PSUPPORTED_OS_INFO* = ptr SUPPORTED_OS_INFO
  ACTIVATION_CONTEXT_DETAILED_INFORMATION* {.pure.} = object
    dwFlags*: DWORD
    ulFormatVersion*: DWORD
    ulAssemblyCount*: DWORD
    ulRootManifestPathType*: DWORD
    ulRootManifestPathChars*: DWORD
    ulRootConfigurationPathType*: DWORD
    ulRootConfigurationPathChars*: DWORD
    ulAppDirPathType*: DWORD
    ulAppDirPathChars*: DWORD
    lpRootManifestPath*: PCWSTR
    lpRootConfigurationPath*: PCWSTR
    lpAppDirPath*: PCWSTR
  PACTIVATION_CONTEXT_DETAILED_INFORMATION* = ptr ACTIVATION_CONTEXT_DETAILED_INFORMATION
  PCACTIVATION_CONTEXT_QUERY_INDEX* = ptr ACTIVATION_CONTEXT_QUERY_INDEX
  PCASSEMBLY_FILE_DETAILED_INFORMATION* = ptr ASSEMBLY_FILE_DETAILED_INFORMATION
  PCACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION* = ptr ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION
  PCACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION* = ptr ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION
  PCCOMPATIBILITY_CONTEXT_ELEMENT* = ptr COMPATIBILITY_CONTEXT_ELEMENT
  PCACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION* = ptr ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION
  PCACTIVATION_CONTEXT_DETAILED_INFORMATION* = ptr ACTIVATION_CONTEXT_DETAILED_INFORMATION
  ASSEMBLY_DLL_REDIRECTION_DETAILED_INFORMATION* = ASSEMBLY_FILE_DETAILED_INFORMATION
  PASSEMBLY_DLL_REDIRECTION_DETAILED_INFORMATION* = PASSEMBLY_FILE_DETAILED_INFORMATION
  PCASSEMBLY_DLL_REDIRECTION_DETAILED_INFORMATION* = PCASSEMBLY_FILE_DETAILED_INFORMATION
  RTL_VERIFIER_THUNK_DESCRIPTOR* {.pure.} = object
    ThunkName*: PCHAR
    ThunkOldAddress*: PVOID
    ThunkNewAddress*: PVOID
  PRTL_VERIFIER_THUNK_DESCRIPTOR* = ptr RTL_VERIFIER_THUNK_DESCRIPTOR
  RTL_VERIFIER_DLL_DESCRIPTOR* {.pure.} = object
    DllName*: PWCHAR
    DllFlags*: DWORD
    DllAddress*: PVOID
    DllThunks*: PRTL_VERIFIER_THUNK_DESCRIPTOR
  PRTL_VERIFIER_DLL_DESCRIPTOR* = ptr RTL_VERIFIER_DLL_DESCRIPTOR
  RTL_VERIFIER_DLL_LOAD_CALLBACK* = proc (DllName: PWSTR, DllBase: PVOID, DllSize: SIZE_T, Reserved: PVOID): VOID {.stdcall.}
  RTL_VERIFIER_DLL_UNLOAD_CALLBACK* = proc (DllName: PWSTR, DllBase: PVOID, DllSize: SIZE_T, Reserved: PVOID): VOID {.stdcall.}
  RTL_VERIFIER_NTDLLHEAPFREE_CALLBACK* = proc (AllocationBase: PVOID, AllocationSize: SIZE_T): VOID {.stdcall.}
  RTL_VERIFIER_PROVIDER_DESCRIPTOR* {.pure.} = object
    Length*: DWORD
    ProviderDlls*: PRTL_VERIFIER_DLL_DESCRIPTOR
    ProviderDllLoadCallback*: RTL_VERIFIER_DLL_LOAD_CALLBACK
    ProviderDllUnloadCallback*: RTL_VERIFIER_DLL_UNLOAD_CALLBACK
    VerifierImage*: PWSTR
    VerifierFlags*: DWORD
    VerifierDebug*: DWORD
    RtlpGetStackTraceAddress*: PVOID
    RtlpDebugPageHeapCreate*: PVOID
    RtlpDebugPageHeapDestroy*: PVOID
    ProviderNtdllHeapFreeCallback*: RTL_VERIFIER_NTDLLHEAPFREE_CALLBACK
  PRTL_VERIFIER_PROVIDER_DESCRIPTOR* = ptr RTL_VERIFIER_PROVIDER_DESCRIPTOR
  HARDWARE_COUNTER_DATA* {.pure.} = object
    Type*: HARDWARE_COUNTER_TYPE
    Reserved*: DWORD
    Value*: DWORD64
  PHARDWARE_COUNTER_DATA* = ptr HARDWARE_COUNTER_DATA
const
  MAX_HW_COUNTERS* = 16
type
  PERFORMANCE_DATA* {.pure.} = object
    Size*: WORD
    Version*: BYTE
    HwCountersCount*: BYTE
    ContextSwitchCount*: DWORD
    WaitReasonBitMap*: DWORD64
    CycleTime*: DWORD64
    RetryCount*: DWORD
    Reserved*: DWORD
    HwCounters*: array[MAX_HW_COUNTERS, HARDWARE_COUNTER_DATA]
  PPERFORMANCE_DATA* = ptr PERFORMANCE_DATA
  EVENTLOGRECORD* {.pure.} = object
    Length*: DWORD
    Reserved*: DWORD
    RecordNumber*: DWORD
    TimeGenerated*: DWORD
    TimeWritten*: DWORD
    EventID*: DWORD
    EventType*: WORD
    NumStrings*: WORD
    EventCategory*: WORD
    ReservedFlags*: WORD
    ClosingRecordNumber*: DWORD
    StringOffset*: DWORD
    UserSidLength*: DWORD
    UserSidOffset*: DWORD
    DataLength*: DWORD
    DataOffset*: DWORD
  PEVENTLOGRECORD* = ptr EVENTLOGRECORD
const
  MAXLOGICALLOGNAMESIZE* = 256
type
  EVENTSFORLOGFILE* {.pure.} = object
    ulSize*: DWORD
    szLogicalLogFile*: array[MAXLOGICALLOGNAMESIZE, WCHAR]
    ulNumRecords*: DWORD
    pEventLogRecords*: UncheckedArray[EVENTLOGRECORD]
  PEVENTSFORLOGFILE* = ptr EVENTSFORLOGFILE
  PACKEDEVENTINFO* {.pure.} = object
    ulSize*: DWORD
    ulNumEventsForLogFile*: DWORD
    ulOffsets*: UncheckedArray[DWORD]
  PPACKEDEVENTINFO* = ptr PACKEDEVENTINFO
  TAPE_ERASE* {.pure.} = object
    Type*: DWORD
    Immediate*: BOOLEAN
  PTAPE_ERASE* = ptr TAPE_ERASE
  TAPE_PREPARE* {.pure.} = object
    Operation*: DWORD
    Immediate*: BOOLEAN
  PTAPE_PREPARE* = ptr TAPE_PREPARE
  TAPE_WRITE_MARKS* {.pure.} = object
    Type*: DWORD
    Count*: DWORD
    Immediate*: BOOLEAN
  PTAPE_WRITE_MARKS* = ptr TAPE_WRITE_MARKS
  TAPE_GET_POSITION* {.pure.} = object
    Type*: DWORD
    Partition*: DWORD
    Offset*: LARGE_INTEGER
  PTAPE_GET_POSITION* = ptr TAPE_GET_POSITION
  TAPE_SET_POSITION* {.pure.} = object
    Method*: DWORD
    Partition*: DWORD
    Offset*: LARGE_INTEGER
    Immediate*: BOOLEAN
  PTAPE_SET_POSITION* = ptr TAPE_SET_POSITION
  TAPE_GET_DRIVE_PARAMETERS* {.pure.} = object
    ECC*: BOOLEAN
    Compression*: BOOLEAN
    DataPadding*: BOOLEAN
    ReportSetmarks*: BOOLEAN
    DefaultBlockSize*: DWORD
    MaximumBlockSize*: DWORD
    MinimumBlockSize*: DWORD
    MaximumPartitionCount*: DWORD
    FeaturesLow*: DWORD
    FeaturesHigh*: DWORD
    EOTWarningZoneSize*: DWORD
  PTAPE_GET_DRIVE_PARAMETERS* = ptr TAPE_GET_DRIVE_PARAMETERS
  TAPE_SET_DRIVE_PARAMETERS* {.pure.} = object
    ECC*: BOOLEAN
    Compression*: BOOLEAN
    DataPadding*: BOOLEAN
    ReportSetmarks*: BOOLEAN
    EOTWarningZoneSize*: DWORD
  PTAPE_SET_DRIVE_PARAMETERS* = ptr TAPE_SET_DRIVE_PARAMETERS
  TAPE_GET_MEDIA_PARAMETERS* {.pure.} = object
    Capacity*: LARGE_INTEGER
    Remaining*: LARGE_INTEGER
    BlockSize*: DWORD
    PartitionCount*: DWORD
    WriteProtected*: BOOLEAN
  PTAPE_GET_MEDIA_PARAMETERS* = ptr TAPE_GET_MEDIA_PARAMETERS
  TAPE_SET_MEDIA_PARAMETERS* {.pure.} = object
    BlockSize*: DWORD
  PTAPE_SET_MEDIA_PARAMETERS* = ptr TAPE_SET_MEDIA_PARAMETERS
  TAPE_CREATE_PARTITION* {.pure.} = object
    Method*: DWORD
    Count*: DWORD
    Size*: DWORD
  PTAPE_CREATE_PARTITION* = ptr TAPE_CREATE_PARTITION
  TAPE_WMI_OPERATIONS* {.pure.} = object
    Method*: DWORD
    DataBufferSize*: DWORD
    DataBuffer*: PVOID
  PTAPE_WMI_OPERATIONS* = ptr TAPE_WMI_OPERATIONS
  TP_CALLBACK_INSTANCE* {.pure.} = object
  PTP_CALLBACK_INSTANCE* = ptr TP_CALLBACK_INSTANCE
  TP_POOL* {.pure.} = object
  PTP_POOL* = ptr TP_POOL
  TP_POOL_STACK_INFORMATION* {.pure.} = object
    StackReserve*: SIZE_T
    StackCommit*: SIZE_T
  PTP_POOL_STACK_INFORMATION* = ptr TP_POOL_STACK_INFORMATION
  TP_CLEANUP_GROUP* {.pure.} = object
  PTP_CLEANUP_GROUP* = ptr TP_CLEANUP_GROUP
  PTP_CLEANUP_GROUP_CANCEL_CALLBACK* = proc (ObjectContext: PVOID, CleanupContext: PVOID): VOID {.stdcall.}
  ACTIVATION_CONTEXT* {.pure.} = object
  PTP_SIMPLE_CALLBACK* = proc (Instance: PTP_CALLBACK_INSTANCE, Context: PVOID): VOID {.stdcall.}
  TP_CALLBACK_ENVIRON_V3_u_s* {.pure.} = object
    LongFunction* {.bitsize:1.}: DWORD
    Persistent* {.bitsize:1.}: DWORD
    Private* {.bitsize:30.}: DWORD
  TP_CALLBACK_ENVIRON_V3_u* {.pure, union.} = object
    Flags*: DWORD
    s*: TP_CALLBACK_ENVIRON_V3_u_s
  TP_CALLBACK_ENVIRON_V3* {.pure.} = object
    Version*: TP_VERSION
    Pool*: PTP_POOL
    CleanupGroup*: PTP_CLEANUP_GROUP
    CleanupGroupCancelCallback*: PTP_CLEANUP_GROUP_CANCEL_CALLBACK
    RaceDll*: PVOID
    ActivationContext*: ptr ACTIVATION_CONTEXT
    FinalizationCallback*: PTP_SIMPLE_CALLBACK
    u*: TP_CALLBACK_ENVIRON_V3_u
    CallbackPriority*: TP_CALLBACK_PRIORITY
    Size*: DWORD
  TP_CALLBACK_ENVIRON* = TP_CALLBACK_ENVIRON_V3
  PTP_CALLBACK_ENVIRON* = ptr TP_CALLBACK_ENVIRON_V3
  TP_WORK* {.pure.} = object
  PTP_WORK* = ptr TP_WORK
  TP_TIMER* {.pure.} = object
  PTP_TIMER* = ptr TP_TIMER
  TP_WAIT* {.pure.} = object
  PTP_WAIT* = ptr TP_WAIT
  TP_IO* {.pure.} = object
  PTP_IO* = ptr TP_IO
  CRM_PROTOCOL_ID* = GUID
  PCRM_PROTOCOL_ID* = ptr GUID
  TRANSACTION_NOTIFICATION* {.pure.} = object
    TransactionKey*: PVOID
    TransactionNotification*: ULONG
    TmVirtualClock*: LARGE_INTEGER
    ArgumentLength*: ULONG
  PTRANSACTION_NOTIFICATION* = ptr TRANSACTION_NOTIFICATION
  TRANSACTION_NOTIFICATION_RECOVERY_ARGUMENT* {.pure.} = object
    EnlistmentId*: GUID
    UOW*: GUID
  PTRANSACTION_NOTIFICATION_RECOVERY_ARGUMENT* = ptr TRANSACTION_NOTIFICATION_RECOVERY_ARGUMENT
  TRANSACTION_NOTIFICATION_TM_ONLINE_ARGUMENT* {.pure.} = object
    TmIdentity*: GUID
    Flags*: ULONG
  PTRANSACTION_NOTIFICATION_TM_ONLINE_ARGUMENT* = ptr TRANSACTION_NOTIFICATION_TM_ONLINE_ARGUMENT
  TRANSACTION_NOTIFICATION_SAVEPOINT_ARGUMENT* {.pure.} = object
    SavepointId*: SAVEPOINT_ID
  PTRANSACTION_NOTIFICATION_SAVEPOINT_ARGUMENT* = ptr TRANSACTION_NOTIFICATION_SAVEPOINT_ARGUMENT
  TRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT* {.pure.} = object
    PropagationCookie*: ULONG
    UOW*: GUID
    TmIdentity*: GUID
    BufferLength*: ULONG
  PTRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT* = ptr TRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT
  TRANSACTION_NOTIFICATION_MARSHAL_ARGUMENT* {.pure.} = object
    MarshalCookie*: ULONG
    UOW*: GUID
  PTRANSACTION_NOTIFICATION_MARSHAL_ARGUMENT* = ptr TRANSACTION_NOTIFICATION_MARSHAL_ARGUMENT
  TRANSACTION_NOTIFICATION_PROMOTE_ARGUMENT* = TRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT
  PTRANSACTION_NOTIFICATION_PROMOTE_ARGUMENT* = ptr TRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT
  KCRM_MARSHAL_HEADER* {.pure.} = object
    VersionMajor*: ULONG
    VersionMinor*: ULONG
    NumProtocols*: ULONG
    Unused*: ULONG
  PKCRM_MARSHAL_HEADER* = ptr KCRM_MARSHAL_HEADER
  PRKCRM_MARSHAL_HEADER* = ptr KCRM_MARSHAL_HEADER
const
  MAX_TRANSACTION_DESCRIPTION_LENGTH* = 64
type
  KCRM_TRANSACTION_BLOB* {.pure.} = object
    UOW*: GUID
    TmIdentity*: GUID
    IsolationLevel*: ULONG
    IsolationFlags*: ULONG
    Timeout*: ULONG
    Description*: array[MAX_TRANSACTION_DESCRIPTION_LENGTH, WCHAR]
  PKCRM_TRANSACTION_BLOB* = ptr KCRM_TRANSACTION_BLOB
  PRKCRM_TRANSACTION_BLOB* = ptr KCRM_TRANSACTION_BLOB
  KCRM_PROTOCOL_BLOB* {.pure.} = object
    ProtocolId*: CRM_PROTOCOL_ID
    StaticInfoLength*: ULONG
    TransactionIdInfoLength*: ULONG
    Unused1*: ULONG
    Unused2*: ULONG
  PKCRM_PROTOCOL_BLOB* = ptr KCRM_PROTOCOL_BLOB
  PRKCRM_PROTOCOL_BLOB* = ptr KCRM_PROTOCOL_BLOB
  TRANSACTION_BASIC_INFORMATION* {.pure.} = object
    TransactionId*: GUID
    State*: DWORD
    Outcome*: DWORD
  PTRANSACTION_BASIC_INFORMATION* = ptr TRANSACTION_BASIC_INFORMATION
  TRANSACTIONMANAGER_BASIC_INFORMATION* {.pure.} = object
    TmIdentity*: GUID
    VirtualClock*: LARGE_INTEGER
  PTRANSACTIONMANAGER_BASIC_INFORMATION* = ptr TRANSACTIONMANAGER_BASIC_INFORMATION
  TRANSACTIONMANAGER_LOG_INFORMATION* {.pure.} = object
    LogIdentity*: GUID
  PTRANSACTIONMANAGER_LOG_INFORMATION* = ptr TRANSACTIONMANAGER_LOG_INFORMATION
  TRANSACTIONMANAGER_LOGPATH_INFORMATION* {.pure.} = object
    LogPathLength*: DWORD
    LogPath*: array[1, WCHAR]
  PTRANSACTIONMANAGER_LOGPATH_INFORMATION* = ptr TRANSACTIONMANAGER_LOGPATH_INFORMATION
  TRANSACTIONMANAGER_RECOVERY_INFORMATION* {.pure.} = object
    LastRecoveredLsn*: ULONGLONG
  PTRANSACTIONMANAGER_RECOVERY_INFORMATION* = ptr TRANSACTIONMANAGER_RECOVERY_INFORMATION
  TRANSACTIONMANAGER_OLDEST_INFORMATION* {.pure.} = object
    OldestTransactionGuid*: GUID
  PTRANSACTIONMANAGER_OLDEST_INFORMATION* = ptr TRANSACTIONMANAGER_OLDEST_INFORMATION
  TRANSACTION_PROPERTIES_INFORMATION* {.pure.} = object
    IsolationLevel*: DWORD
    IsolationFlags*: DWORD
    Timeout*: LARGE_INTEGER
    Outcome*: DWORD
    DescriptionLength*: DWORD
    Description*: array[1, WCHAR]
  PTRANSACTION_PROPERTIES_INFORMATION* = ptr TRANSACTION_PROPERTIES_INFORMATION
  TRANSACTION_BIND_INFORMATION* {.pure.} = object
    TmHandle*: HANDLE
  PTRANSACTION_BIND_INFORMATION* = ptr TRANSACTION_BIND_INFORMATION
  TRANSACTION_ENLISTMENT_PAIR* {.pure.} = object
    EnlistmentId*: GUID
    ResourceManagerId*: GUID
  PTRANSACTION_ENLISTMENT_PAIR* = ptr TRANSACTION_ENLISTMENT_PAIR
  TRANSACTION_ENLISTMENTS_INFORMATION* {.pure.} = object
    NumberOfEnlistments*: DWORD
    EnlistmentPair*: array[1, TRANSACTION_ENLISTMENT_PAIR]
  PTRANSACTION_ENLISTMENTS_INFORMATION* = ptr TRANSACTION_ENLISTMENTS_INFORMATION
  TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION* {.pure.} = object
    SuperiorEnlistmentPair*: TRANSACTION_ENLISTMENT_PAIR
  PTRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION* = ptr TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION
  RESOURCEMANAGER_BASIC_INFORMATION* {.pure.} = object
    ResourceManagerId*: GUID
    DescriptionLength*: DWORD
    Description*: array[1, WCHAR]
  PRESOURCEMANAGER_BASIC_INFORMATION* = ptr RESOURCEMANAGER_BASIC_INFORMATION
  RESOURCEMANAGER_COMPLETION_INFORMATION* {.pure.} = object
    IoCompletionPortHandle*: HANDLE
    CompletionKey*: ULONG_PTR
  PRESOURCEMANAGER_COMPLETION_INFORMATION* = ptr RESOURCEMANAGER_COMPLETION_INFORMATION
  ENLISTMENT_BASIC_INFORMATION* {.pure.} = object
    EnlistmentId*: GUID
    TransactionId*: GUID
    ResourceManagerId*: GUID
  PENLISTMENT_BASIC_INFORMATION* = ptr ENLISTMENT_BASIC_INFORMATION
  ENLISTMENT_CRM_INFORMATION* {.pure.} = object
    CrmTransactionManagerId*: GUID
    CrmResourceManagerId*: GUID
    CrmEnlistmentId*: GUID
  PENLISTMENT_CRM_INFORMATION* = ptr ENLISTMENT_CRM_INFORMATION
  TRANSACTION_LIST_ENTRY* {.pure.} = object
    UOW*: GUID
  PTRANSACTION_LIST_ENTRY* = ptr TRANSACTION_LIST_ENTRY
  TRANSACTION_LIST_INFORMATION* {.pure.} = object
    NumberOfTransactions*: DWORD
    TransactionInformation*: array[1, TRANSACTION_LIST_ENTRY]
  PTRANSACTION_LIST_INFORMATION* = ptr TRANSACTION_LIST_INFORMATION
  KTMOBJECT_CURSOR* {.pure.} = object
    LastQuery*: GUID
    ObjectIdCount*: DWORD
    ObjectIds*: array[1, GUID]
  PKTMOBJECT_CURSOR* = ptr KTMOBJECT_CURSOR
const
  WOW64_SIZE_OF_80387_REGISTERS* = 80
type
  WOW64_FLOATING_SAVE_AREA* {.pure.} = object
    ControlWord*: DWORD
    StatusWord*: DWORD
    TagWord*: DWORD
    ErrorOffset*: DWORD
    ErrorSelector*: DWORD
    DataOffset*: DWORD
    DataSelector*: DWORD
    RegisterArea*: array[WOW64_SIZE_OF_80387_REGISTERS, BYTE]
    Cr0NpxState*: DWORD
  PWOW64_FLOATING_SAVE_AREA* = ptr WOW64_FLOATING_SAVE_AREA
const
  WOW64_MAXIMUM_SUPPORTED_EXTENSION* = 512
type
  WOW64_CONTEXT* {.pure.} = object
    ContextFlags*: DWORD
    Dr0*: DWORD
    Dr1*: DWORD
    Dr2*: DWORD
    Dr3*: DWORD
    Dr6*: DWORD
    Dr7*: DWORD
    FloatSave*: WOW64_FLOATING_SAVE_AREA
    SegGs*: DWORD
    SegFs*: DWORD
    SegEs*: DWORD
    SegDs*: DWORD
    Edi*: DWORD
    Esi*: DWORD
    Ebx*: DWORD
    Edx*: DWORD
    Ecx*: DWORD
    Eax*: DWORD
    Ebp*: DWORD
    Eip*: DWORD
    SegCs*: DWORD
    EFlags*: DWORD
    Esp*: DWORD
    SegSs*: DWORD
    ExtendedRegisters*: array[WOW64_MAXIMUM_SUPPORTED_EXTENSION, BYTE]
  PWOW64_CONTEXT* = ptr WOW64_CONTEXT
  WOW64_LDT_ENTRY_HighWord_Bytes* {.pure.} = object
    BaseMid*: BYTE
    Flags1*: BYTE
    Flags2*: BYTE
    BaseHi*: BYTE
  WOW64_LDT_ENTRY_HighWord_Bits* {.pure.} = object
    BaseMid* {.bitsize:8.}: DWORD
    Type* {.bitsize:5.}: DWORD
    Dpl* {.bitsize:2.}: DWORD
    Pres* {.bitsize:1.}: DWORD
    LimitHi* {.bitsize:4.}: DWORD
    Sys* {.bitsize:1.}: DWORD
    Reserved_0* {.bitsize:1.}: DWORD
    Default_Big* {.bitsize:1.}: DWORD
    Granularity* {.bitsize:1.}: DWORD
    BaseHi* {.bitsize:8.}: DWORD
  WOW64_LDT_ENTRY_HighWord* {.pure, union.} = object
    Bytes*: WOW64_LDT_ENTRY_HighWord_Bytes
    Bits*: WOW64_LDT_ENTRY_HighWord_Bits
  WOW64_LDT_ENTRY* {.pure.} = object
    LimitLow*: WORD
    BaseLow*: WORD
    HighWord*: WOW64_LDT_ENTRY_HighWord
  PWOW64_LDT_ENTRY* = ptr WOW64_LDT_ENTRY
  WOW64_DESCRIPTOR_TABLE_ENTRY* {.pure.} = object
    Selector*: DWORD
    Descriptor*: WOW64_LDT_ENTRY
  PWOW64_DESCRIPTOR_TABLE_ENTRY* = ptr WOW64_DESCRIPTOR_TABLE_ENTRY
  PHKEY* = ptr HKEY
  FILETIME* {.pure.} = object
    dwLowDateTime*: DWORD
    dwHighDateTime*: DWORD
  PFILETIME* = ptr FILETIME
  LPFILETIME* = ptr FILETIME
  RECT* {.pure.} = object
    left*: LONG
    top*: LONG
    right*: LONG
    bottom*: LONG
  PRECT* = ptr RECT
  NPRECT* = ptr RECT
  LPRECT* = ptr RECT
  LPCRECT* = ptr RECT
  RECTL* {.pure.} = object
    left*: LONG
    top*: LONG
    right*: LONG
    bottom*: LONG
  PRECTL* = ptr RECTL
  LPRECTL* = ptr RECTL
  LPCRECTL* = ptr RECTL
  POINT* {.pure.} = object
    x*: LONG
    y*: LONG
  PPOINT* = ptr POINT
  NPPOINT* = ptr POINT
  LPPOINT* = ptr POINT
  POINTL* {.pure.} = object
    x*: LONG
    y*: LONG
  PPOINTL* = ptr POINTL
  SIZE* {.pure.} = object
    cx*: LONG
    cy*: LONG
  PSIZE* = ptr SIZE
  LPSIZE* = ptr SIZE
  SIZEL* = SIZE
  PSIZEL* = ptr SIZE
  LPSIZEL* = ptr SIZE
  POINTS* {.pure.} = object
    x*: SHORT
    y*: SHORT
  PPOINTS* = ptr POINTS
  LPPOINTS* = ptr POINTS
  PEB_LDR_DATA* {.pure.} = object
    Reserved1*: array[8, BYTE]
    Reserved2*: array[3, PVOID]
    InMemoryOrderModuleList*: LIST_ENTRY
  PPEB_LDR_DATA* = ptr PEB_LDR_DATA
  LDR_DATA_TABLE_ENTRY_UNION1* {.pure, union.} = object
    CheckSum*: ULONG
    Reserved6*: PVOID
  LDR_DATA_TABLE_ENTRY* {.pure.} = object
    Reserved1*: array[2, PVOID]
    InMemoryOrderLinks*: LIST_ENTRY
    Reserved2*: array[2, PVOID]
    DllBase*: PVOID
    Reserved3*: array[2, PVOID]
    FullDllName*: UNICODE_STRING
    Reserved4*: array[8, BYTE]
    Reserved5*: array[3, PVOID]
    union1*: LDR_DATA_TABLE_ENTRY_UNION1
    TimeDateStamp*: ULONG
  PLDR_DATA_TABLE_ENTRY* = ptr LDR_DATA_TABLE_ENTRY
  RTL_USER_PROCESS_PARAMETERS* {.pure.} = object
    Reserved1*: array[16, BYTE]
    Reserved2*: array[10, PVOID]
    ImagePathName*: UNICODE_STRING
    CommandLine*: UNICODE_STRING
  PRTL_USER_PROCESS_PARAMETERS* = ptr RTL_USER_PROCESS_PARAMETERS
  PPS_POST_PROCESS_INIT_ROUTINE* = proc (): VOID {.stdcall.}
  PEB* {.pure.} = object
    Reserved1*: array[2, BYTE]
    BeingDebugged*: BYTE
    Reserved2*: array[1, BYTE]
    Reserved3*: array[2, PVOID]
    Ldr*: PPEB_LDR_DATA
    ProcessParameters*: PRTL_USER_PROCESS_PARAMETERS
    Reserved4*: array[104, BYTE]
    Reserved5*: array[52, PVOID]
    PostProcessInitRoutine*: PPS_POST_PROCESS_INIT_ROUTINE
    Reserved6*: array[128, BYTE]
    Reserved7*: array[1, PVOID]
    SessionId*: ULONG
  PPEB* = ptr PEB
  TEB* {.pure.} = object
    Reserved1*: array[1952, BYTE]
    Reserved2*: array[412, PVOID]
    TlsSlots*: array[64, PVOID]
    Reserved3*: array[8, BYTE]
    Reserved4*: array[26, PVOID]
    ReservedForOle*: PVOID
    Reserved5*: array[4, PVOID]
    TlsExpansionSlots*: PVOID
  PTEB* = ptr TEB
  OBJECT_DATA_INFORMATION* {.pure.} = object
    InheritHandle*: BOOLEAN
    ProtectFromClose*: BOOLEAN
  POBJECT_DATA_INFORMATION* = ptr OBJECT_DATA_INFORMATION
  OBJECT_BASIC_INFORMATION* {.pure.} = object
    Attributes*: ULONG
    GrantedAccess*: ACCESS_MASK
    HandleCount*: ULONG
    PointerCount*: ULONG
    PagedPoolUsage*: ULONG
    NonPagedPoolUsage*: ULONG
    Reserved*: array[3, ULONG]
    NameInformationLength*: ULONG
    TypeInformationLength*: ULONG
    SecurityDescriptorLength*: ULONG
    CreateTime*: LARGE_INTEGER
  POBJECT_BASIC_INFORMATION* = ptr OBJECT_BASIC_INFORMATION
  OBJECT_NAME_INFORMATION* {.pure.} = object
    Name*: UNICODE_STRING
  POBJECT_NAME_INFORMATION* = ptr OBJECT_NAME_INFORMATION
  OBJECT_TYPE_INFORMATION* {.pure.} = object
    TypeName*: UNICODE_STRING
    TotalNumberOfObjects*: ULONG
    TotalNumberOfHandles*: ULONG
    TotalPagedPoolUsage*: ULONG
    TotalNonPagedPoolUsage*: ULONG
    TotalNamePoolUsage*: ULONG
    TotalHandleTableUsage*: ULONG
    HighWaterNumberOfObjects*: ULONG
    HighWaterNumberOfHandles*: ULONG
    HighWaterPagedPoolUsage*: ULONG
    HighWaterNonPagedPoolUsage*: ULONG
    HighWaterNamePoolUsage*: ULONG
    HighWaterHandleTableUsage*: ULONG
    InvalidAttributes*: ULONG
    GenericMapping*: GENERIC_MAPPING
    ValidAccessMask*: ULONG
    SecurityRequired*: BOOLEAN
    MaintainHandleCount*: BOOLEAN
    PoolType*: ULONG
    DefaultPagedPoolCharge*: ULONG
    DefaultNonPagedPoolCharge*: ULONG
  POBJECT_TYPE_INFORMATION* = ptr OBJECT_TYPE_INFORMATION
  OBJECT_ALL_INFORMATION* {.pure.} = object
    NumberOfObjects*: ULONG
    ObjectTypeInformation*: array[1, OBJECT_TYPE_INFORMATION]
  POBJECT_ALL_INFORMATION* = ptr OBJECT_ALL_INFORMATION
  FILE_DIRECTORY_INFORMATION* {.pure.} = object
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
    FileName*: array[ANYSIZE_ARRAY, WCHAR]
  PFILE_DIRECTORY_INFORMATION* = ptr FILE_DIRECTORY_INFORMATION
  FILE_FULL_DIR_INFORMATION* {.pure.} = object
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
    FileName*: array[ANYSIZE_ARRAY, WCHAR]
  PFILE_FULL_DIR_INFORMATION* = ptr FILE_FULL_DIR_INFORMATION
  FILE_ID_FULL_DIR_INFORMATION* {.pure.} = object
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
    FileId*: LARGE_INTEGER
    FileName*: array[ANYSIZE_ARRAY, WCHAR]
  PFILE_ID_FULL_DIR_INFORMATION* = ptr FILE_ID_FULL_DIR_INFORMATION
  FILE_BOTH_DIR_INFORMATION* {.pure.} = object
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
    ShortNameLength*: CHAR
    ShortName*: array[12, WCHAR]
    FileName*: array[ANYSIZE_ARRAY, WCHAR]
  PFILE_BOTH_DIR_INFORMATION* = ptr FILE_BOTH_DIR_INFORMATION
  FILE_ID_BOTH_DIR_INFORMATION* {.pure.} = object
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
    ShortNameLength*: CHAR
    ShortName*: array[12, WCHAR]
    FileId*: LARGE_INTEGER
    FileName*: array[ANYSIZE_ARRAY, WCHAR]
  PFILE_ID_BOTH_DIR_INFORMATION* = ptr FILE_ID_BOTH_DIR_INFORMATION
  FILE_FULL_DIRECTORY_INFORMATION* = FILE_FULL_DIR_INFORMATION
  PFILE_FULL_DIRECTORY_INFORMATION* = ptr FILE_FULL_DIR_INFORMATION
  FILE_ID_FULL_DIRECTORY_INFORMATION* = FILE_ID_FULL_DIR_INFORMATION
  PFILE_ID_FULL_DIRECTORY_INFORMATION* = ptr FILE_ID_FULL_DIR_INFORMATION
  FILE_BOTH_DIRECTORY_INFORMATION* = FILE_BOTH_DIR_INFORMATION
  PFILE_BOTH_DIRECTORY_INFORMATION* = ptr FILE_BOTH_DIR_INFORMATION
  FILE_ID_BOTH_DIRECTORY_INFORMATION* = FILE_ID_BOTH_DIR_INFORMATION
  PFILE_ID_BOTH_DIRECTORY_INFORMATION* = ptr FILE_ID_BOTH_DIR_INFORMATION
  FILE_BASIC_INFORMATION* {.pure.} = object
    CreationTime*: LARGE_INTEGER
    LastAccessTime*: LARGE_INTEGER
    LastWriteTime*: LARGE_INTEGER
    ChangeTime*: LARGE_INTEGER
    FileAttributes*: ULONG
  PFILE_BASIC_INFORMATION* = ptr FILE_BASIC_INFORMATION
  FILE_STANDARD_INFORMATION* {.pure.} = object
    AllocationSize*: LARGE_INTEGER
    EndOfFile*: LARGE_INTEGER
    NumberOfLinks*: ULONG
    DeletePending*: BOOLEAN
    Directory*: BOOLEAN
  PFILE_STANDARD_INFORMATION* = ptr FILE_STANDARD_INFORMATION
  FILE_INTERNAL_INFORMATION* {.pure.} = object
    IndexNumber*: LARGE_INTEGER
  PFILE_INTERNAL_INFORMATION* = ptr FILE_INTERNAL_INFORMATION
  FILE_EA_INFORMATION* {.pure.} = object
    EaSize*: ULONG
  PFILE_EA_INFORMATION* = ptr FILE_EA_INFORMATION
  FILE_ACCESS_INFORMATION* {.pure.} = object
    AccessFlags*: ACCESS_MASK
  PFILE_ACCESS_INFORMATION* = ptr FILE_ACCESS_INFORMATION
  FILE_LINK_INFORMATION* {.pure.} = object
    ReplaceIfExists*: BOOLEAN
    RootDirectory*: HANDLE
    FileNameLength*: ULONG
    FileName*: array[1, WCHAR]
  PFILE_LINK_INFORMATION* = ptr FILE_LINK_INFORMATION
  FILE_NAME_INFORMATION* {.pure.} = object
    FileNameLength*: ULONG
    FileName*: array[1, WCHAR]
  PFILE_NAME_INFORMATION* = ptr FILE_NAME_INFORMATION
  FILE_RENAME_INFORMATION* {.pure.} = object
    ReplaceIfExists*: BOOLEAN
    RootDirectory*: HANDLE
    FileNameLength*: ULONG
    FileName*: array[1, WCHAR]
  PFILE_RENAME_INFORMATION* = ptr FILE_RENAME_INFORMATION
  FILE_NAMES_INFORMATION* {.pure.} = object
    NextEntryOffset*: ULONG
    FileIndex*: ULONG
    FileNameLength*: ULONG
    FileName*: array[1, WCHAR]
  PFILE_NAMES_INFORMATION* = ptr FILE_NAMES_INFORMATION
  FILE_DISPOSITION_INFORMATION* {.pure.} = object
    DoDeleteFile*: BOOLEAN
  PFILE_DISPOSITION_INFORMATION* = ptr FILE_DISPOSITION_INFORMATION
  FILE_POSITION_INFORMATION* {.pure.} = object
    CurrentByteOffset*: LARGE_INTEGER
  PFILE_POSITION_INFORMATION* = ptr FILE_POSITION_INFORMATION
  FILE_ALIGNMENT_INFORMATION* {.pure.} = object
    AlignmentRequirement*: ULONG
  PFILE_ALIGNMENT_INFORMATION* = ptr FILE_ALIGNMENT_INFORMATION
  FILE_ALLOCATION_INFORMATION* {.pure.} = object
    AllocationSize*: LARGE_INTEGER
  PFILE_ALLOCATION_INFORMATION* = ptr FILE_ALLOCATION_INFORMATION
  FILE_END_OF_FILE_INFORMATION* {.pure.} = object
    EndOfFile*: LARGE_INTEGER
  PFILE_END_OF_FILE_INFORMATION* = ptr FILE_END_OF_FILE_INFORMATION
  FILE_NETWORK_OPEN_INFORMATION* {.pure.} = object
    CreationTime*: LARGE_INTEGER
    LastAccessTime*: LARGE_INTEGER
    LastWriteTime*: LARGE_INTEGER
    ChangeTime*: LARGE_INTEGER
    AllocationSize*: LARGE_INTEGER
    EndOfFile*: LARGE_INTEGER
    FileAttributes*: ULONG
  PFILE_NETWORK_OPEN_INFORMATION* = ptr FILE_NETWORK_OPEN_INFORMATION
  FILE_FULL_EA_INFORMATION* {.pure.} = object
    NextEntryOffset*: ULONG
    Flags*: UCHAR
    EaNameLength*: UCHAR
    EaValueLength*: USHORT
    EaName*: array[1, CHAR]
  PFILE_FULL_EA_INFORMATION* = ptr FILE_FULL_EA_INFORMATION
  FILE_MODE_INFORMATION* {.pure.} = object
    Mode*: ULONG
  PFILE_MODE_INFORMATION* = ptr FILE_MODE_INFORMATION
  FILE_STREAM_INFORMATION* {.pure.} = object
    NextEntryOffset*: ULONG
    StreamNameLength*: ULONG
    StreamSize*: LARGE_INTEGER
    StreamAllocationSize*: LARGE_INTEGER
    StreamName*: array[1, WCHAR]
  PFILE_STREAM_INFORMATION* = ptr FILE_STREAM_INFORMATION
  FILE_ATTRIBUTE_TAG_INFORMATION* {.pure.} = object
    FileAttributes*: ULONG
    ReparseTag*: ULONG
  PFILE_ATTRIBUTE_TAG_INFORMATION* = ptr FILE_ATTRIBUTE_TAG_INFORMATION
  FILE_MAILSLOT_QUERY_INFORMATION* {.pure.} = object
    MaximumMessageSize*: ULONG
    MailslotQuota*: ULONG
    NextMessageSize*: ULONG
    MessagesAvailable*: ULONG
    ReadTimeout*: LARGE_INTEGER
  PFILE_MAILSLOT_QUERY_INFORMATION* = ptr FILE_MAILSLOT_QUERY_INFORMATION
  FILE_MAILSLOT_SET_INFORMATION* {.pure.} = object
    ReadTimeout*: LARGE_INTEGER
  PFILE_MAILSLOT_SET_INFORMATION* = ptr FILE_MAILSLOT_SET_INFORMATION
  FILE_PIPE_LOCAL_INFORMATION* {.pure.} = object
    NamedPipeType*: ULONG
    NamedPipeConfiguration*: ULONG
    MaximumInstances*: ULONG
    CurrentInstances*: ULONG
    InboundQuota*: ULONG
    ReadDataAvailable*: ULONG
    OutboundQuota*: ULONG
    WriteQuotaAvailable*: ULONG
    NamedPipeState*: ULONG
    NamedPipeEnd*: ULONG
  PFILE_PIPE_LOCAL_INFORMATION* = ptr FILE_PIPE_LOCAL_INFORMATION
  FILE_ALL_INFORMATION* {.pure.} = object
    BasicInformation*: FILE_BASIC_INFORMATION
    StandardInformation*: FILE_STANDARD_INFORMATION
    InternalInformation*: FILE_INTERNAL_INFORMATION
    EaInformation*: FILE_EA_INFORMATION
    AccessInformation*: FILE_ACCESS_INFORMATION
    PositionInformation*: FILE_POSITION_INFORMATION
    ModeInformation*: FILE_MODE_INFORMATION
    AlignmentInformation*: FILE_ALIGNMENT_INFORMATION
    NameInformation*: FILE_NAME_INFORMATION
  PFILE_ALL_INFORMATION* = ptr FILE_ALL_INFORMATION
  FILE_FS_VOLUME_INFORMATION* {.pure.} = object
    VolumeCreationTime*: LARGE_INTEGER
    VolumeSerialNumber*: ULONG
    VolumeLabelLength*: ULONG
    SupportsObjects*: BOOLEAN
    VolumeLabel*: array[1, WCHAR]
  PFILE_FS_VOLUME_INFORMATION* = ptr FILE_FS_VOLUME_INFORMATION
  FILE_FS_LABEL_INFORMATION* {.pure.} = object
    VolumeLabelLength*: ULONG
    VolumeLabel*: array[1, WCHAR]
  PFILE_FS_LABEL_INFORMATION* = ptr FILE_FS_LABEL_INFORMATION
  FILE_FS_SIZE_INFORMATION* {.pure.} = object
    TotalAllocationUnits*: LARGE_INTEGER
    AvailableAllocationUnits*: LARGE_INTEGER
    SectorsPerAllocationUnit*: ULONG
    BytesPerSector*: ULONG
  PFILE_FS_SIZE_INFORMATION* = ptr FILE_FS_SIZE_INFORMATION
  FILE_FS_DEVICE_INFORMATION* {.pure.} = object
    DeviceType*: DEVICE_TYPE
    Characteristics*: ULONG
  PFILE_FS_DEVICE_INFORMATION* = ptr FILE_FS_DEVICE_INFORMATION
  FILE_FS_ATTRIBUTE_INFORMATION* {.pure.} = object
    FileSystemAttributes*: ULONG
    MaximumComponentNameLength*: ULONG
    FileSystemNameLength*: ULONG
    FileSystemName*: array[1, WCHAR]
  PFILE_FS_ATTRIBUTE_INFORMATION* = ptr FILE_FS_ATTRIBUTE_INFORMATION
  FILE_FS_FULL_SIZE_INFORMATION* {.pure.} = object
    TotalAllocationUnits*: LARGE_INTEGER
    CallerAvailableAllocationUnits*: LARGE_INTEGER
    ActualAvailableAllocationUnits*: LARGE_INTEGER
    SectorsPerAllocationUnit*: ULONG
    BytesPerSector*: ULONG
  PFILE_FS_FULL_SIZE_INFORMATION* = ptr FILE_FS_FULL_SIZE_INFORMATION
  FILE_FS_OBJECTID_INFORMATION* {.pure.} = object
    ObjectId*: array[16, UCHAR]
    ExtendedInfo*: array[48, UCHAR]
  PFILE_FS_OBJECTID_INFORMATION* = ptr FILE_FS_OBJECTID_INFORMATION
  IO_STATUS_BLOCK_UNION1* {.pure, union.} = object
    Status*: NTSTATUS
    Pointer*: PVOID
  IO_STATUS_BLOCK* {.pure.} = object
    union1*: IO_STATUS_BLOCK_UNION1
    Information*: ULONG_PTR
  PIO_STATUS_BLOCK* = ptr IO_STATUS_BLOCK
  VM_COUNTERS* {.pure.} = object
    PeakVirtualSize*: SIZE_T
    VirtualSize*: SIZE_T
    PageFaultCount*: ULONG
    PeakWorkingSetSize*: SIZE_T
    WorkingSetSize*: SIZE_T
    QuotaPeakPagedPoolUsage*: SIZE_T
    QuotaPagedPoolUsage*: SIZE_T
    QuotaPeakNonPagedPoolUsage*: SIZE_T
    QuotaNonPagedPoolUsage*: SIZE_T
    PagefileUsage*: SIZE_T
    PeakPagefileUsage*: SIZE_T
  PVM_COUNTERS* = ptr VM_COUNTERS
  CLIENT_ID* {.pure.} = object
    UniqueProcess*: HANDLE
    UniqueThread*: HANDLE
  PCLIENT_ID* = ptr CLIENT_ID
  SYSTEM_THREADS* {.pure.} = object
    KernelTime*: LARGE_INTEGER
    UserTime*: LARGE_INTEGER
    CreateTime*: LARGE_INTEGER
    WaitTime*: ULONG
    StartAddress*: PVOID
    ClientId*: CLIENT_ID
    Priority*: KPRIORITY
    BasePriority*: KPRIORITY
    ContextSwitchCount*: ULONG
    State*: THREAD_STATE
    WaitReason*: KWAIT_REASON
  PSYSTEM_THREADS* = ptr SYSTEM_THREADS
  PROCESS_BASIC_INFORMATION* {.pure.} = object
    ExitStatus*: NTSTATUS
    PebBaseAddress*: PPEB
    AffinityMask*: KAFFINITY
    BasePriority*: KPRIORITY
    UniqueProcessId*: ULONG_PTR
    InheritedFromUniqueProcessId*: ULONG_PTR
  PPROCESS_BASIC_INFORMATION* = ptr PROCESS_BASIC_INFORMATION
  KERNEL_USER_TIMES* {.pure.} = object
    CreateTime*: FILETIME
    ExitTime*: FILETIME
    KernelTime*: LARGE_INTEGER
    UserTime*: LARGE_INTEGER
  PKERNEL_USER_TIMES* = ptr KERNEL_USER_TIMES
  SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION* {.pure.} = object
    IdleTime*: LARGE_INTEGER
    KernelTime*: LARGE_INTEGER
    UserTime*: LARGE_INTEGER
    Reserved1*: array[2, LARGE_INTEGER]
    Reserved2*: ULONG
  PSYSTEM_PROCESSOR_PERFORMANCE_INFORMATION* = ptr SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION
  SYSTEM_PROCESS_INFORMATION* {.pure.} = object
    NextEntryOffset*: ULONG
    NumberOfThreads*: ULONG
    Reserved*: array[3, LARGE_INTEGER]
    CreateTime*: LARGE_INTEGER
    UserTime*: LARGE_INTEGER
    KernelTime*: LARGE_INTEGER
    ImageName*: UNICODE_STRING
    BasePriority*: KPRIORITY
    UniqueProcessId*: HANDLE
    InheritedFromUniqueProcessId*: HANDLE
    HandleCount*: ULONG
    SessionId*: ULONG
    PageDirectoryBase*: ULONG
    VirtualMemoryCounters*: VM_COUNTERS
    PrivatePageCount*: SIZE_T
    IoCounters*: IO_COUNTERS
  PSYSTEM_PROCESS_INFORMATION* = ptr SYSTEM_PROCESS_INFORMATION
  SYSTEM_REGISTRY_QUOTA_INFORMATION* {.pure.} = object
    RegistryQuotaAllowed*: ULONG
    RegistryQuotaUsed*: ULONG
    Reserved1*: PVOID
  PSYSTEM_REGISTRY_QUOTA_INFORMATION* = ptr SYSTEM_REGISTRY_QUOTA_INFORMATION
  SYSTEM_BASIC_INFORMATION* {.pure.} = object
    Reserved1*: array[4, BYTE]
    MaximumIncrement*: ULONG
    PhysicalPageSize*: ULONG
    NumberOfPhysicalPages*: ULONG
    LowestPhysicalPage*: ULONG
    HighestPhysicalPage*: ULONG
    AllocationGranularity*: ULONG
    LowestUserAddress*: ULONG_PTR
    HighestUserAddress*: ULONG_PTR
    ActiveProcessors*: ULONG_PTR
    NumberOfProcessors*: CCHAR
  PSYSTEM_BASIC_INFORMATION* = ptr SYSTEM_BASIC_INFORMATION
  SYSTEM_PROCESSOR_INFORMATION* {.pure.} = object
    ProcessorArchitecture*: USHORT
    ProcessorLevel*: USHORT
    ProcessorRevision*: USHORT
    Unknown*: USHORT
    FeatureBits*: ULONG
  PSYSTEM_PROCESSOR_INFORMATION* = ptr SYSTEM_PROCESSOR_INFORMATION
  SYSTEM_TIMEOFDAY_INFORMATION* {.pure.} = object
    BootTime*: LARGE_INTEGER
    CurrentTime*: LARGE_INTEGER
    TimeZoneBias*: LARGE_INTEGER
    CurrentTimeZoneId*: ULONG
    Reserved1*: array[20, BYTE]
  PSYSTEM_TIMEOFDAY_INFORMATION* = ptr SYSTEM_TIMEOFDAY_INFORMATION
  SYSTEM_PERFORMANCE_INFORMATION* {.pure.} = object
    IdleTime*: LARGE_INTEGER
    ReadTransferCount*: LARGE_INTEGER
    WriteTransferCount*: LARGE_INTEGER
    OtherTransferCount*: LARGE_INTEGER
    ReadOperationCount*: ULONG
    WriteOperationCount*: ULONG
    OtherOperationCount*: ULONG
    AvailablePages*: ULONG
    TotalCommittedPages*: ULONG
    TotalCommitLimit*: ULONG
    PeakCommitment*: ULONG
    PageFaults*: ULONG
    WriteCopyFaults*: ULONG
    TransitionFaults*: ULONG
    CacheTransitionFaults*: ULONG
    DemandZeroFaults*: ULONG
    PagesRead*: ULONG
    PageReadIos*: ULONG
    CacheReads*: ULONG
    CacheIos*: ULONG
    PagefilePagesWritten*: ULONG
    PagefilePageWriteIos*: ULONG
    MappedFilePagesWritten*: ULONG
    MappedFilePageWriteIos*: ULONG
    PagedPoolUsage*: ULONG
    NonPagedPoolUsage*: ULONG
    PagedPoolAllocs*: ULONG
    PagedPoolFrees*: ULONG
    NonPagedPoolAllocs*: ULONG
    NonPagedPoolFrees*: ULONG
    TotalFreeSystemPtes*: ULONG
    SystemCodePage*: ULONG
    TotalSystemDriverPages*: ULONG
    TotalSystemCodePages*: ULONG
    SmallNonPagedLookasideListAllocateHits*: ULONG
    SmallPagedLookasideListAllocateHits*: ULONG
    Reserved3*: ULONG
    MmSystemCachePage*: ULONG
    PagedPoolPage*: ULONG
    SystemDriverPage*: ULONG
    FastReadNoWait*: ULONG
    FastReadWait*: ULONG
    FastReadResourceMiss*: ULONG
    FastReadNotPossible*: ULONG
    FastMdlReadNoWait*: ULONG
    FastMdlReadWait*: ULONG
    FastMdlReadResourceMiss*: ULONG
    FastMdlReadNotPossible*: ULONG
    MapDataNoWait*: ULONG
    MapDataWait*: ULONG
    MapDataNoWaitMiss*: ULONG
    MapDataWaitMiss*: ULONG
    PinMappedDataCount*: ULONG
    PinReadNoWait*: ULONG
    PinReadWait*: ULONG
    PinReadNoWaitMiss*: ULONG
    PinReadWaitMiss*: ULONG
    CopyReadNoWait*: ULONG
    CopyReadWait*: ULONG
    CopyReadNoWaitMiss*: ULONG
    CopyReadWaitMiss*: ULONG
    MdlReadNoWait*: ULONG
    MdlReadWait*: ULONG
    MdlReadNoWaitMiss*: ULONG
    MdlReadWaitMiss*: ULONG
    ReadAheadIos*: ULONG
    LazyWriteIos*: ULONG
    LazyWritePages*: ULONG
    DataFlushes*: ULONG
    DataPages*: ULONG
    ContextSwitches*: ULONG
    FirstLevelTbFills*: ULONG
    SecondLevelTbFills*: ULONG
    SystemCalls*: ULONG
  PSYSTEM_PERFORMANCE_INFORMATION* = ptr SYSTEM_PERFORMANCE_INFORMATION
  SYSTEM_EXCEPTION_INFORMATION* {.pure.} = object
    Reserved1*: array[16, BYTE]
  PSYSTEM_EXCEPTION_INFORMATION* = ptr SYSTEM_EXCEPTION_INFORMATION
  SYSTEM_LOOKASIDE_INFORMATION* {.pure.} = object
    Reserved1*: array[32, BYTE]
  PSYSTEM_LOOKASIDE_INFORMATION* = ptr SYSTEM_LOOKASIDE_INFORMATION
  SYSTEM_INTERRUPT_INFORMATION* {.pure.} = object
    Reserved1*: array[24, BYTE]
  PSYSTEM_INTERRUPT_INFORMATION* = ptr SYSTEM_INTERRUPT_INFORMATION
  SYSTEM_HANDLE_ENTRY* {.pure.} = object
    OwnerPid*: ULONG
    ObjectType*: BYTE
    HandleFlags*: BYTE
    HandleValue*: USHORT
    ObjectPointer*: PVOID
    AccessMask*: ULONG
  PSYSTEM_HANDLE_ENTRY* = ptr SYSTEM_HANDLE_ENTRY
  SYSTEM_HANDLE_INFORMATION* {.pure.} = object
    Count*: ULONG
    Handle*: array[1, SYSTEM_HANDLE_ENTRY]
  PSYSTEM_HANDLE_INFORMATION* = ptr SYSTEM_HANDLE_INFORMATION
  SYSTEM_PAGEFILE_INFORMATION* {.pure.} = object
    NextEntryOffset*: ULONG
    CurrentSize*: ULONG
    TotalUsed*: ULONG
    PeakUsed*: ULONG
    FileName*: UNICODE_STRING
  PSYSTEM_PAGEFILE_INFORMATION* = ptr SYSTEM_PAGEFILE_INFORMATION
  PRTL_HEAP_COMMIT_ROUTINE* = proc (Base: PVOID, CommitAddress: ptr PVOID, CommitSize: PSIZE_T): NTSTATUS {.stdcall.}
  RTL_HEAP_PARAMETERS* {.pure.} = object
    Length*: ULONG
    SegmentReserve*: SIZE_T
    SegmentCommit*: SIZE_T
    DeCommitFreeBlockThreshold*: SIZE_T
    DeCommitTotalFreeThreshold*: SIZE_T
    MaximumAllocationSize*: SIZE_T
    VirtualMemoryThreshold*: SIZE_T
    InitialCommit*: SIZE_T
    InitialReserve*: SIZE_T
    CommitRoutine*: PRTL_HEAP_COMMIT_ROUTINE
    Reserved*: array[ 2 , SIZE_T]
  PRTL_HEAP_PARAMETERS* = ptr RTL_HEAP_PARAMETERS
  WINSTATIONINFORMATIONW* {.pure.} = object
    Reserved2*: array[70, BYTE]
    LogonId*: ULONG
    Reserved3*: array[1140, BYTE]
  PWINSTATIONINFORMATIONW* = ptr WINSTATIONINFORMATIONW
  BSTR* = distinct ptr OLECHAR
const
  exceptionContinueExecution* = 0
  exceptionContinueSearch* = 1
  exceptionNestedException* = 2
  exceptionCollidedUnwind* = 3
  exceptionExecuteHandler* = 4
  EXCEPTION_EXECUTE_HANDLER* = 1
  EXCEPTION_CONTINUE_SEARCH* = 0
  EXCEPTION_CONTINUE_EXECUTION* = -1
  FALSE* = 0
  TRUE* = 1
  UNICODE_NULL* = WCHAR 0
  ANSI_NULL* = CHAR 0
  NLS_VALID_LOCALE_MASK* = 0x000fffff
  OBJ_INHERIT* = 0x00000002
  OBJ_PERMANENT* = 0x00000010
  OBJ_EXCLUSIVE* = 0x00000020
  OBJ_CASE_INSENSITIVE* = 0x00000040
  OBJ_OPENIF* = 0x00000080
  OBJ_OPENLINK* = 0x00000100
  OBJ_KERNEL_HANDLE* = 0x00000200
  OBJ_FORCE_ACCESS_CHECK* = 0x00000400
  OBJ_VALID_ATTRIBUTES* = 0x000007F2
  ntProductWinNt* = 1
  ntProductLanManNt* = 2
  ntProductServer* = 3
  notificationEvent* = 0
  synchronizationEvent* = 1
  notificationTimer* = 0
  synchronizationTimer* = 1
  waitAll* = 0
  waitAny* = 1
  MINCHAR* = 0x80
  MAXCHAR* = 0x7f
  MINSHORT* = 0x8000
  MAXSHORT* = 0x7fff
  MINLONG* = 0x80000000'i32
  MAXLONG* = 0x7fffffff
  MAXUCHAR* = 0xff
  MAXUSHORT* = 0xffff
  MAXULONG* = 0xffffffff'i32
  MAXLONGLONG* = 0x7fffffffffffffff
  VER_WORKSTATION_NT* = 0x40000000
  VER_SERVER_NT* = 0x80000000'i32
  VER_SUITE_SMALLBUSINESS* = 0x00000001
  VER_SUITE_ENTERPRISE* = 0x00000002
  VER_SUITE_BACKOFFICE* = 0x00000004
  VER_SUITE_COMMUNICATIONS* = 0x00000008
  VER_SUITE_TERMINAL* = 0x00000010
  VER_SUITE_SMALLBUSINESS_RESTRICTED* = 0x00000020
  VER_SUITE_EMBEDDEDNT* = 0x00000040
  VER_SUITE_DATACENTER* = 0x00000080
  VER_SUITE_SINGLEUSERTS* = 0x00000100
  VER_SUITE_PERSONAL* = 0x00000200
  VER_SUITE_BLADE* = 0x00000400
  VER_SUITE_EMBEDDED_RESTRICTED* = 0x00000800
  VER_SUITE_SECURITY_APPLIANCE* = 0x00001000
  VER_SUITE_STORAGE_SERVER* = 0x00002000
  VER_SUITE_COMPUTE_SERVER* = 0x00004000
  VER_SUITE_WH_SERVER* = 0x00008000
  LANG_NEUTRAL* = 0x00
  LANG_INVARIANT* = 0x7f
  LANG_AFRIKAANS* = 0x36
  LANG_ALBANIAN* = 0x1c
  LANG_ALSATIAN* = 0x84
  LANG_AMHARIC* = 0x5e
  LANG_ARABIC* = 0x01
  LANG_ARMENIAN* = 0x2b
  LANG_ASSAMESE* = 0x4d
  LANG_AZERI* = 0x2c
  LANG_BASHKIR* = 0x6d
  LANG_BASQUE* = 0x2d
  LANG_BELARUSIAN* = 0x23
  LANG_BENGALI* = 0x45
  LANG_BRETON* = 0x7e
  LANG_BOSNIAN* = 0x1a
  LANG_BOSNIAN_NEUTRAL* = 0x781a
  LANG_BULGARIAN* = 0x02
  LANG_CATALAN* = 0x03
  LANG_CHINESE* = 0x04
  LANG_CHINESE_SIMPLIFIED* = 0x04
  LANG_CHINESE_TRADITIONAL* = 0x7c04
  LANG_CORSICAN* = 0x83
  LANG_CROATIAN* = 0x1a
  LANG_CZECH* = 0x05
  LANG_DANISH* = 0x06
  LANG_DARI* = 0x8c
  LANG_DIVEHI* = 0x65
  LANG_DUTCH* = 0x13
  LANG_ENGLISH* = 0x09
  LANG_ESTONIAN* = 0x25
  LANG_FAEROESE* = 0x38
  LANG_FARSI* = 0x29
  LANG_FILIPINO* = 0x64
  LANG_FINNISH* = 0x0b
  LANG_FRENCH* = 0x0c
  LANG_FRISIAN* = 0x62
  LANG_GALICIAN* = 0x56
  LANG_GEORGIAN* = 0x37
  LANG_GERMAN* = 0x07
  LANG_GREEK* = 0x08
  LANG_GREENLANDIC* = 0x6f
  LANG_GUJARATI* = 0x47
  LANG_HAUSA* = 0x68
  LANG_HEBREW* = 0x0d
  LANG_HINDI* = 0x39
  LANG_HUNGARIAN* = 0x0e
  LANG_ICELANDIC* = 0x0f
  LANG_IGBO* = 0x70
  LANG_INDONESIAN* = 0x21
  LANG_INUKTITUT* = 0x5d
  LANG_IRISH* = 0x3c
  LANG_ITALIAN* = 0x10
  LANG_JAPANESE* = 0x11
  LANG_KANNADA* = 0x4b
  LANG_KASHMIRI* = 0x60
  LANG_KAZAK* = 0x3f
  LANG_KHMER* = 0x53
  LANG_KICHE* = 0x86
  LANG_KINYARWANDA* = 0x87
  LANG_KONKANI* = 0x57
  LANG_KOREAN* = 0x12
  LANG_KYRGYZ* = 0x40
  LANG_LAO* = 0x54
  LANG_LATVIAN* = 0x26
  LANG_LITHUANIAN* = 0x27
  LANG_LOWER_SORBIAN* = 0x2e
  LANG_LUXEMBOURGISH* = 0x6e
  LANG_MACEDONIAN* = 0x2f
  LANG_MALAY* = 0x3e
  LANG_MALAYALAM* = 0x4c
  LANG_MALTESE* = 0x3a
  LANG_MANIPURI* = 0x58
  LANG_MAORI* = 0x81
  LANG_MAPUDUNGUN* = 0x7a
  LANG_MARATHI* = 0x4e
  LANG_MOHAWK* = 0x7c
  LANG_MONGOLIAN* = 0x50
  LANG_NEPALI* = 0x61
  LANG_NORWEGIAN* = 0x14
  LANG_OCCITAN* = 0x82
  LANG_ORIYA* = 0x48
  LANG_PASHTO* = 0x63
  LANG_PERSIAN* = 0x29
  LANG_POLISH* = 0x15
  LANG_PORTUGUESE* = 0x16
  LANG_PUNJABI* = 0x46
  LANG_QUECHUA* = 0x6b
  LANG_ROMANIAN* = 0x18
  LANG_ROMANSH* = 0x17
  LANG_RUSSIAN* = 0x19
  LANG_SAMI* = 0x3b
  LANG_SANSKRIT* = 0x4f
  LANG_SERBIAN* = 0x1a
  LANG_SERBIAN_NEUTRAL* = 0x7c1a
  LANG_SINDHI* = 0x59
  LANG_SINHALESE* = 0x5b
  LANG_SLOVAK* = 0x1b
  LANG_SLOVENIAN* = 0x24
  LANG_SOTHO* = 0x6c
  LANG_SPANISH* = 0x0a
  LANG_SWAHILI* = 0x41
  LANG_SWEDISH* = 0x1d
  LANG_SYRIAC* = 0x5a
  LANG_TAJIK* = 0x28
  LANG_TAMAZIGHT* = 0x5f
  LANG_TAMIL* = 0x49
  LANG_TATAR* = 0x44
  LANG_TELUGU* = 0x4a
  LANG_THAI* = 0x1e
  LANG_TIBETAN* = 0x51
  LANG_TIGRIGNA* = 0x73
  LANG_TSWANA* = 0x32
  LANG_TURKISH* = 0x1f
  LANG_TURKMEN* = 0x42
  LANG_UIGHUR* = 0x80
  LANG_UKRAINIAN* = 0x22
  LANG_UPPER_SORBIAN* = 0x2e
  LANG_URDU* = 0x20
  LANG_UZBEK* = 0x43
  LANG_VIETNAMESE* = 0x2a
  LANG_WELSH* = 0x52
  LANG_WOLOF* = 0x88
  LANG_XHOSA* = 0x34
  LANG_YAKUT* = 0x85
  LANG_YI* = 0x78
  LANG_YORUBA* = 0x6a
  LANG_ZULU* = 0x35
  FILE_ATTRIBUTE_VALID_FLAGS* = 0x00007fb7
  FILE_SHARE_READ* = 0x00000001
  FILE_SHARE_WRITE* = 0x00000002
  FILE_SHARE_DELETE* = 0x00000004
  FILE_SHARE_VALID_FLAGS* = FILE_SHARE_READ or FILE_SHARE_WRITE or FILE_SHARE_DELETE
  FILE_SUPERSEDE* = 0x00000000
  FILE_OPEN* = 0x00000001
  FILE_CREATE* = 0x00000002
  FILE_OPEN_IF* = 0x00000003
  FILE_OVERWRITE* = 0x00000004
  FILE_OVERWRITE_IF* = 0x00000005
  FILE_MAXIMUM_DISPOSITION* = 0x00000005
  FILE_DIRECTORY_FILE* = 0x00000001
  FILE_WRITE_THROUGH* = 0x00000002
  FILE_SEQUENTIAL_ONLY* = 0x00000004
  FILE_NO_INTERMEDIATE_BUFFERING* = 0x00000008
  FILE_SYNCHRONOUS_IO_ALERT* = 0x00000010
  FILE_SYNCHRONOUS_IO_NONALERT* = 0x00000020
  FILE_NON_DIRECTORY_FILE* = 0x00000040
  FILE_CREATE_TREE_CONNECTION* = 0x00000080
  FILE_COMPLETE_IF_OPLOCKED* = 0x00000100
  FILE_NO_EA_KNOWLEDGE* = 0x00000200
  FILE_OPEN_REMOTE_INSTANCE* = 0x00000400
  FILE_RANDOM_ACCESS* = 0x00000800
  FILE_DELETE_ON_CLOSE* = 0x00001000
  FILE_OPEN_BY_FILE_ID* = 0x00002000
  FILE_OPEN_FOR_BACKUP_INTENT* = 0x00004000
  FILE_NO_COMPRESSION* = 0x00008000
  FILE_OPEN_REQUIRING_OPLOCK* = 0x00010000
  FILE_DISALLOW_EXCLUSIVE* = 0x00020000
  FILE_RESERVE_OPFILTER* = 0x00100000
  FILE_OPEN_REPARSE_POINT* = 0x00200000
  FILE_OPEN_NO_RECALL* = 0x00400000
  FILE_OPEN_FOR_FREE_SPACE_QUERY* = 0x00800000
  FACILITY_USB_ERROR_CODE* = 0x10
  FACILITY_TRANSACTION* = 0x19
  FACILITY_TERMINAL_SERVER* = 0xA
  FACILITY_SXS_ERROR_CODE* = 0x15
  FACILITY_RPC_STUBS* = 0x3
  FACILITY_RPC_RUNTIME* = 0x2
  FACILITY_IO_ERROR_CODE* = 0x4
  FACILITY_HID_ERROR_CODE* = 0x11
  FACILITY_FIREWIRE_ERROR_CODE* = 0x12
  FACILITY_DEBUGGER* = 0x1
  FACILITY_COMMONLOG_ERROR_CODE* = 0x1A
  FACILITY_CLUSTER_ERROR_CODE* = 0x13
  FACILITY_ACPI_ERROR_CODE* = 0x14
  STATUS_SEVERITY_WARNING* = 0x2
  STATUS_SEVERITY_SUCCESS* = 0x0
  STATUS_SEVERITY_INFORMATIONAL* = 0x1
  STATUS_SEVERITY_ERROR* = 0x3
  STATUS_KERNEL_APC* = NTSTATUS 0x00000100
  STATUS_DEVICE_POWER_FAILURE* = NTSTATUS 0xC000009E'i32
  STATUS_ABIOS_NOT_PRESENT* = NTSTATUS 0xC000010F'i32
  STATUS_ABIOS_LID_NOT_EXIST* = NTSTATUS 0xC0000110'i32
  STATUS_ABIOS_LID_ALREADY_OWNED* = NTSTATUS 0xC0000111'i32
  STATUS_ABIOS_NOT_LID_OWNER* = NTSTATUS 0xC0000112'i32
  STATUS_ABIOS_INVALID_COMMAND* = NTSTATUS 0xC0000113'i32
  STATUS_ABIOS_INVALID_LID* = NTSTATUS 0xC0000114'i32
  STATUS_ABIOS_SELECTOR_NOT_AVAILABLE* = NTSTATUS 0xC0000115'i32
  STATUS_ABIOS_INVALID_SELECTOR* = NTSTATUS 0xC0000116'i32
  STATUS_MULTIPLE_FAULT_VIOLATION* = NTSTATUS 0xC00002E8'i32
  STATUS_SUCCESS* = NTSTATUS 0x00000000
  STATUS_WAIT_0* = NTSTATUS 0x00000000
  STATUS_WAIT_1* = NTSTATUS 0x00000001
  STATUS_WAIT_2* = NTSTATUS 0x00000002
  STATUS_WAIT_3* = NTSTATUS 0x00000003
  STATUS_WAIT_63* = NTSTATUS 0x0000003F
  STATUS_ABANDONED* = NTSTATUS 0x00000080
  STATUS_ABANDONED_WAIT_0* = NTSTATUS 0x00000080
  STATUS_ABANDONED_WAIT_63* = NTSTATUS 0x000000BF
  STATUS_USER_APC* = NTSTATUS 0x000000C0
  STATUS_ALERTED* = NTSTATUS 0x00000101
  STATUS_TIMEOUT* = NTSTATUS 0x00000102
  STATUS_PENDING* = NTSTATUS 0x00000103
  STATUS_REPARSE* = NTSTATUS 0x00000104
  STATUS_MORE_ENTRIES* = NTSTATUS 0x00000105
  STATUS_NOT_ALL_ASSIGNED* = NTSTATUS 0x00000106
  STATUS_SOME_NOT_MAPPED* = NTSTATUS 0x00000107
  STATUS_OPLOCK_BREAK_IN_PROGRESS* = NTSTATUS 0x00000108
  STATUS_VOLUME_MOUNTED* = NTSTATUS 0x00000109
  STATUS_RXACT_COMMITTED* = NTSTATUS 0x0000010A
  STATUS_NOTIFY_CLEANUP* = NTSTATUS 0x0000010B
  STATUS_NOTIFY_ENUM_DIR* = NTSTATUS 0x0000010C
  STATUS_NO_QUOTAS_FOR_ACCOUNT* = NTSTATUS 0x0000010D
  STATUS_PRIMARY_TRANSPORT_CONNECT_FAILED* = NTSTATUS 0x0000010E
  STATUS_PAGE_FAULT_TRANSITION* = NTSTATUS 0x00000110
  STATUS_PAGE_FAULT_DEMAND_ZERO* = NTSTATUS 0x00000111
  STATUS_PAGE_FAULT_COPY_ON_WRITE* = NTSTATUS 0x00000112
  STATUS_PAGE_FAULT_GUARD_PAGE* = NTSTATUS 0x00000113
  STATUS_PAGE_FAULT_PAGING_FILE* = NTSTATUS 0x00000114
  STATUS_CACHE_PAGE_LOCKED* = NTSTATUS 0x00000115
  STATUS_CRASH_DUMP* = NTSTATUS 0x00000116
  STATUS_BUFFER_ALL_ZEROS* = NTSTATUS 0x00000117
  STATUS_REPARSE_OBJECT* = NTSTATUS 0x00000118
  STATUS_RESOURCE_REQUIREMENTS_CHANGED* = NTSTATUS 0x00000119
  STATUS_TRANSLATION_COMPLETE* = NTSTATUS 0x00000120
  STATUS_DS_MEMBERSHIP_EVALUATED_LOCALLY* = NTSTATUS 0x00000121
  STATUS_NOTHING_TO_TERMINATE* = NTSTATUS 0x00000122
  STATUS_PROCESS_NOT_IN_JOB* = NTSTATUS 0x00000123
  STATUS_PROCESS_IN_JOB* = NTSTATUS 0x00000124
  STATUS_VOLSNAP_HIBERNATE_READY* = NTSTATUS 0x00000125
  STATUS_FSFILTER_OP_COMPLETED_SUCCESSFULLY* = NTSTATUS 0x00000126
  STATUS_INTERRUPT_VECTOR_ALREADY_CONNECTED* = NTSTATUS 0x00000127
  STATUS_INTERRUPT_STILL_CONNECTED* = NTSTATUS 0x00000128
  STATUS_PROCESS_CLONED* = NTSTATUS 0x00000129
  STATUS_FILE_LOCKED_WITH_ONLY_READERS* = NTSTATUS 0x0000012A
  STATUS_FILE_LOCKED_WITH_WRITERS* = NTSTATUS 0x0000012B
  STATUS_RESOURCEMANAGER_READ_ONLY* = NTSTATUS 0x00000202
  STATUS_WAIT_FOR_OPLOCK* = NTSTATUS 0x00000367
  DBG_EXCEPTION_HANDLED* = NTSTATUS 0x00010001
  DBG_CONTINUE* = NTSTATUS 0x00010002
  STATUS_FLT_IO_COMPLETE* = NTSTATUS 0x001C0001
  STATUS_FILE_NOT_AVAILABLE* = NTSTATUS 0xC0000467'i32
  STATUS_OBJECT_NAME_EXISTS* = NTSTATUS 0x40000000
  STATUS_THREAD_WAS_SUSPENDED* = NTSTATUS 0x40000001
  STATUS_WORKING_SET_LIMIT_RANGE* = NTSTATUS 0x40000002
  STATUS_IMAGE_NOT_AT_BASE* = NTSTATUS 0x40000003
  STATUS_RXACT_STATE_CREATED* = NTSTATUS 0x40000004
  STATUS_SEGMENT_NOTIFICATION* = NTSTATUS 0x40000005
  STATUS_LOCAL_USER_SESSION_KEY* = NTSTATUS 0x40000006
  STATUS_BAD_CURRENT_DIRECTORY* = NTSTATUS 0x40000007
  STATUS_SERIAL_MORE_WRITES* = NTSTATUS 0x40000008
  STATUS_REGISTRY_RECOVERED* = NTSTATUS 0x40000009
  STATUS_FT_READ_RECOVERY_FROM_BACKUP* = NTSTATUS 0x4000000A
  STATUS_FT_WRITE_RECOVERY* = NTSTATUS 0x4000000B
  STATUS_SERIAL_COUNTER_TIMEOUT* = NTSTATUS 0x4000000C
  STATUS_NULL_LM_PASSWORD* = NTSTATUS 0x4000000D
  STATUS_IMAGE_MACHINE_TYPE_MISMATCH* = NTSTATUS 0x4000000E
  STATUS_RECEIVE_PARTIAL* = NTSTATUS 0x4000000F
  STATUS_RECEIVE_EXPEDITED* = NTSTATUS 0x40000010
  STATUS_RECEIVE_PARTIAL_EXPEDITED* = NTSTATUS 0x40000011
  STATUS_EVENT_DONE* = NTSTATUS 0x40000012
  STATUS_EVENT_PENDING* = NTSTATUS 0x40000013
  STATUS_CHECKING_FILE_SYSTEM* = NTSTATUS 0x40000014
  STATUS_FATAL_APP_EXIT* = NTSTATUS 0x40000015
  STATUS_PREDEFINED_HANDLE* = NTSTATUS 0x40000016
  STATUS_WAS_UNLOCKED* = NTSTATUS 0x40000017
  STATUS_SERVICE_NOTIFICATION* = NTSTATUS 0x40000018
  STATUS_WAS_LOCKED* = NTSTATUS 0x40000019
  STATUS_LOG_HARD_ERROR* = NTSTATUS 0x4000001A
  STATUS_ALREADY_WIN32* = NTSTATUS 0x4000001B
  STATUS_WX86_UNSIMULATE* = NTSTATUS 0x4000001C
  STATUS_WX86_CONTINUE* = NTSTATUS 0x4000001D
  STATUS_WX86_SINGLE_STEP* = NTSTATUS 0x4000001E
  STATUS_WX86_BREAKPOINT* = NTSTATUS 0x4000001F
  STATUS_WX86_EXCEPTION_CONTINUE* = NTSTATUS 0x40000020
  STATUS_WX86_EXCEPTION_LASTCHANCE* = NTSTATUS 0x40000021
  STATUS_WX86_EXCEPTION_CHAIN* = NTSTATUS 0x40000022
  STATUS_IMAGE_MACHINE_TYPE_MISMATCH_EXE* = NTSTATUS 0x40000023
  STATUS_NO_YIELD_PERFORMED* = NTSTATUS 0x40000024
  STATUS_TIMER_RESUME_IGNORED* = NTSTATUS 0x40000025
  STATUS_ARBITRATION_UNHANDLED* = NTSTATUS 0x40000026
  STATUS_CARDBUS_NOT_SUPPORTED* = NTSTATUS 0x40000027
  STATUS_WX86_CREATEWX86TIB* = NTSTATUS 0x40000028
  STATUS_MP_PROCESSOR_MISMATCH* = NTSTATUS 0x40000029
  STATUS_HIBERNATED* = NTSTATUS 0x4000002A
  STATUS_RESUME_HIBERNATION* = NTSTATUS 0x4000002B
  STATUS_FIRMWARE_UPDATED* = NTSTATUS 0x4000002C
  STATUS_DRIVERS_LEAKING_LOCKED_PAGES* = NTSTATUS 0x4000002D
  STATUS_MESSAGE_RETRIEVED* = NTSTATUS 0x4000002E
  STATUS_SYSTEM_POWERSTATE_TRANSITION* = NTSTATUS 0x4000002F
  STATUS_ALPC_CHECK_COMPLETION_LIST* = NTSTATUS 0x40000030
  STATUS_SYSTEM_POWERSTATE_COMPLEX_TRANSITION* = NTSTATUS 0x40000031
  STATUS_ACCESS_AUDIT_BY_POLICY* = NTSTATUS 0x40000032
  STATUS_ABANDON_HIBERFILE* = NTSTATUS 0x40000033
  STATUS_BIZRULES_NOT_ENABLED* = NTSTATUS 0x40000034
  STATUS_WAKE_SYSTEM* = NTSTATUS 0x40000294
  STATUS_DS_SHUTTING_DOWN* = NTSTATUS 0x40000370
  DBG_REPLY_LATER* = NTSTATUS 0x40010001
  DBG_UNABLE_TO_PROVIDE_HANDLE* = NTSTATUS 0x40010002
  DBG_TERMINATE_THREAD* = NTSTATUS 0x40010003
  DBG_TERMINATE_PROCESS* = NTSTATUS 0x40010004
  DBG_CONTROL_C* = NTSTATUS 0x40010005
  DBG_PRINTEXCEPTION_C* = NTSTATUS 0x40010006
  DBG_RIPEXCEPTION* = NTSTATUS 0x40010007
  DBG_CONTROL_BREAK* = NTSTATUS 0x40010008
  DBG_COMMAND_EXCEPTION* = NTSTATUS 0x40010009
  RPC_NT_UUID_LOCAL_ONLY* = NTSTATUS 0x40020056
  RPC_NT_SEND_INCOMPLETE* = NTSTATUS 0x400200AF
  STATUS_CTX_CDM_CONNECT* = NTSTATUS 0x400A0004
  STATUS_CTX_CDM_DISCONNECT* = NTSTATUS 0x400A0005
  STATUS_SXS_RELEASE_ACTIVATION_CONTEXT* = NTSTATUS 0x4015000D
  STATUS_RECOVERY_NOT_NEEDED* = NTSTATUS 0x40190034
  STATUS_RM_ALREADY_STARTED* = NTSTATUS 0x40190035
  STATUS_LOG_NO_RESTART* = NTSTATUS 0x401A000C
  STATUS_VIDEO_DRIVER_DEBUG_REPORT_REQUEST* = NTSTATUS 0x401B00EC
  STATUS_GRAPHICS_PARTIAL_DATA_POPULATED* = NTSTATUS 0x401E000A
  STATUS_GRAPHICS_DRIVER_MISMATCH* = NTSTATUS 0x401E0117
  STATUS_GRAPHICS_MODE_NOT_PINNED* = NTSTATUS 0x401E0307
  STATUS_GRAPHICS_NO_PREFERRED_MODE* = NTSTATUS 0x401E031E
  STATUS_GRAPHICS_DATASET_IS_EMPTY* = NTSTATUS 0x401E034B
  STATUS_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET* = NTSTATUS 0x401E034C
  STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED* = NTSTATUS 0x401E0351
  STATUS_GRAPHICS_UNKNOWN_CHILD_STATUS* = NTSTATUS 0x401E042F
  STATUS_GRAPHICS_LEADLINK_START_DEFERRED* = NTSTATUS 0x401E0437
  STATUS_GRAPHICS_POLLING_TOO_FREQUENTLY* = NTSTATUS 0x401E0439
  STATUS_GRAPHICS_START_DEFERRED* = NTSTATUS 0x401E043A
  STATUS_NDIS_INDICATION_REQUIRED* = NTSTATUS 0x40230001
  STATUS_GUARD_PAGE_VIOLATION* = NTSTATUS 0x80000001'i32
  STATUS_DATATYPE_MISALIGNMENT* = NTSTATUS 0x80000002'i32
  STATUS_BREAKPOINT* = NTSTATUS 0x80000003'i32
  STATUS_SINGLE_STEP* = NTSTATUS 0x80000004'i32
  STATUS_BUFFER_OVERFLOW* = NTSTATUS 0x80000005'i32
  STATUS_NO_MORE_FILES* = NTSTATUS 0x80000006'i32
  STATUS_WAKE_SYSTEM_DEBUGGER* = NTSTATUS 0x80000007'i32
  STATUS_HANDLES_CLOSED* = NTSTATUS 0x8000000A'i32
  STATUS_NO_INHERITANCE* = NTSTATUS 0x8000000B'i32
  STATUS_GUID_SUBSTITUTION_MADE* = NTSTATUS 0x8000000C'i32
  STATUS_PARTIAL_COPY* = NTSTATUS 0x8000000D'i32
  STATUS_DEVICE_PAPER_EMPTY* = NTSTATUS 0x8000000E'i32
  STATUS_DEVICE_POWERED_OFF* = NTSTATUS 0x8000000F'i32
  STATUS_DEVICE_OFF_LINE* = NTSTATUS 0x80000010'i32
  STATUS_DEVICE_BUSY* = NTSTATUS 0x80000011'i32
  STATUS_NO_MORE_EAS* = NTSTATUS 0x80000012'i32
  STATUS_INVALID_EA_NAME* = NTSTATUS 0x80000013'i32
  STATUS_EA_LIST_INCONSISTENT* = NTSTATUS 0x80000014'i32
  STATUS_INVALID_EA_FLAG* = NTSTATUS 0x80000015'i32
  STATUS_VERIFY_REQUIRED* = NTSTATUS 0x80000016'i32
  STATUS_EXTRANEOUS_INFORMATION* = NTSTATUS 0x80000017'i32
  STATUS_RXACT_COMMIT_NECESSARY* = NTSTATUS 0x80000018'i32
  STATUS_NO_MORE_ENTRIES* = NTSTATUS 0x8000001A'i32
  STATUS_FILEMARK_DETECTED* = NTSTATUS 0x8000001B'i32
  STATUS_MEDIA_CHANGED* = NTSTATUS 0x8000001C'i32
  STATUS_BUS_RESET* = NTSTATUS 0x8000001D'i32
  STATUS_END_OF_MEDIA* = NTSTATUS 0x8000001E'i32
  STATUS_BEGINNING_OF_MEDIA* = NTSTATUS 0x8000001F'i32
  STATUS_MEDIA_CHECK* = NTSTATUS 0x80000020'i32
  STATUS_SETMARK_DETECTED* = NTSTATUS 0x80000021'i32
  STATUS_NO_DATA_DETECTED* = NTSTATUS 0x80000022'i32
  STATUS_REDIRECTOR_HAS_OPEN_HANDLES* = NTSTATUS 0x80000023'i32
  STATUS_SERVER_HAS_OPEN_HANDLES* = NTSTATUS 0x80000024'i32
  STATUS_ALREADY_DISCONNECTED* = NTSTATUS 0x80000025'i32
  STATUS_LONGJUMP* = NTSTATUS 0x80000026'i32
  STATUS_CLEANER_CARTRIDGE_INSTALLED* = NTSTATUS 0x80000027'i32
  STATUS_PLUGPLAY_QUERY_VETOED* = NTSTATUS 0x80000028'i32
  STATUS_UNWIND_CONSOLIDATE* = NTSTATUS 0x80000029'i32
  STATUS_REGISTRY_HIVE_RECOVERED* = NTSTATUS 0x8000002A'i32
  STATUS_DLL_MIGHT_BE_INSECURE* = NTSTATUS 0x8000002B'i32
  STATUS_DLL_MIGHT_BE_INCOMPATIBLE* = NTSTATUS 0x8000002C'i32
  STATUS_STOPPED_ON_SYMLINK* = NTSTATUS 0x8000002D'i32
  STATUS_DEVICE_REQUIRES_CLEANING* = NTSTATUS 0x80000288'i32
  STATUS_DEVICE_DOOR_OPEN* = NTSTATUS 0x80000289'i32
  STATUS_DATA_LOST_REPAIR* = NTSTATUS 0x80000803'i32
  DBG_EXCEPTION_NOT_HANDLED* = NTSTATUS 0x80010001'i32
  STATUS_CLUSTER_NODE_ALREADY_UP* = NTSTATUS 0x80130001'i32
  STATUS_CLUSTER_NODE_ALREADY_DOWN* = NTSTATUS 0x80130002'i32
  STATUS_CLUSTER_NETWORK_ALREADY_ONLINE* = NTSTATUS 0x80130003'i32
  STATUS_CLUSTER_NETWORK_ALREADY_OFFLINE* = NTSTATUS 0x80130004'i32
  STATUS_CLUSTER_NODE_ALREADY_MEMBER* = NTSTATUS 0x80130005'i32
  STATUS_COULD_NOT_RESIZE_LOG* = NTSTATUS 0x80190009'i32
  STATUS_NO_TXF_METADATA* = NTSTATUS 0x80190029'i32
  STATUS_CANT_RECOVER_WITH_HANDLE_OPEN* = NTSTATUS 0x80190031'i32
  STATUS_TXF_METADATA_ALREADY_PRESENT* = NTSTATUS 0x80190041'i32
  STATUS_TRANSACTION_SCOPE_CALLBACKS_NOT_SET* = NTSTATUS 0x80190042'i32
  STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD_RECOVERED* = NTSTATUS 0x801B00EB'i32
  STATUS_FLT_BUFFER_TOO_SMALL* = NTSTATUS 0x801C0001'i32
  STATUS_FVE_PARTIAL_METADATA* = NTSTATUS 0x80210001'i32
  STATUS_FVE_TRANSIENT_STATE* = NTSTATUS 0x80210002'i32
  STATUS_UNSUCCESSFUL* = NTSTATUS 0xC0000001'i32
  STATUS_NOT_IMPLEMENTED* = NTSTATUS 0xC0000002'i32
  STATUS_INVALID_INFO_CLASS* = NTSTATUS 0xC0000003'i32
  STATUS_INFO_LENGTH_MISMATCH* = NTSTATUS 0xC0000004'i32
  STATUS_ACCESS_VIOLATION* = NTSTATUS 0xC0000005'i32
  STATUS_IN_PAGE_ERROR* = NTSTATUS 0xC0000006'i32
  STATUS_PAGEFILE_QUOTA* = NTSTATUS 0xC0000007'i32
  STATUS_INVALID_HANDLE* = NTSTATUS 0xC0000008'i32
  STATUS_BAD_INITIAL_STACK* = NTSTATUS 0xC0000009'i32
  STATUS_BAD_INITIAL_PC* = NTSTATUS 0xC000000A'i32
  STATUS_INVALID_CID* = NTSTATUS 0xC000000B'i32
  STATUS_TIMER_NOT_CANCELED* = NTSTATUS 0xC000000C'i32
  STATUS_INVALID_PARAMETER* = NTSTATUS 0xC000000D'i32
  STATUS_NO_SUCH_DEVICE* = NTSTATUS 0xC000000E'i32
  STATUS_NO_SUCH_FILE* = NTSTATUS 0xC000000F'i32
  STATUS_INVALID_DEVICE_REQUEST* = NTSTATUS 0xC0000010'i32
  STATUS_END_OF_FILE* = NTSTATUS 0xC0000011'i32
  STATUS_WRONG_VOLUME* = NTSTATUS 0xC0000012'i32
  STATUS_NO_MEDIA_IN_DEVICE* = NTSTATUS 0xC0000013'i32
  STATUS_UNRECOGNIZED_MEDIA* = NTSTATUS 0xC0000014'i32
  STATUS_NONEXISTENT_SECTOR* = NTSTATUS 0xC0000015'i32
  STATUS_MORE_PROCESSING_REQUIRED* = NTSTATUS 0xC0000016'i32
  STATUS_NO_MEMORY* = NTSTATUS 0xC0000017'i32
  STATUS_CONFLICTING_ADDRESSES* = NTSTATUS 0xC0000018'i32
  STATUS_NOT_MAPPED_VIEW* = NTSTATUS 0xC0000019'i32
  STATUS_UNABLE_TO_FREE_VM* = NTSTATUS 0xC000001A'i32
  STATUS_UNABLE_TO_DELETE_SECTION* = NTSTATUS 0xC000001B'i32
  STATUS_INVALID_SYSTEM_SERVICE* = NTSTATUS 0xC000001C'i32
  STATUS_ILLEGAL_INSTRUCTION* = NTSTATUS 0xC000001D'i32
  STATUS_INVALID_LOCK_SEQUENCE* = NTSTATUS 0xC000001E'i32
  STATUS_INVALID_VIEW_SIZE* = NTSTATUS 0xC000001F'i32
  STATUS_INVALID_FILE_FOR_SECTION* = NTSTATUS 0xC0000020'i32
  STATUS_ALREADY_COMMITTED* = NTSTATUS 0xC0000021'i32
  STATUS_ACCESS_DENIED* = NTSTATUS 0xC0000022'i32
  STATUS_BUFFER_TOO_SMALL* = NTSTATUS 0xC0000023'i32
  STATUS_OBJECT_TYPE_MISMATCH* = NTSTATUS 0xC0000024'i32
  STATUS_NONCONTINUABLE_EXCEPTION* = NTSTATUS 0xC0000025'i32
  STATUS_INVALID_DISPOSITION* = NTSTATUS 0xC0000026'i32
  STATUS_UNWIND* = NTSTATUS 0xC0000027'i32
  STATUS_BAD_STACK* = NTSTATUS 0xC0000028'i32
  STATUS_INVALID_UNWIND_TARGET* = NTSTATUS 0xC0000029'i32
  STATUS_NOT_LOCKED* = NTSTATUS 0xC000002A'i32
  STATUS_PARITY_ERROR* = NTSTATUS 0xC000002B'i32
  STATUS_UNABLE_TO_DECOMMIT_VM* = NTSTATUS 0xC000002C'i32
  STATUS_NOT_COMMITTED* = NTSTATUS 0xC000002D'i32
  STATUS_INVALID_PORT_ATTRIBUTES* = NTSTATUS 0xC000002E'i32
  STATUS_PORT_MESSAGE_TOO_LONG* = NTSTATUS 0xC000002F'i32
  STATUS_INVALID_PARAMETER_MIX* = NTSTATUS 0xC0000030'i32
  STATUS_INVALID_QUOTA_LOWER* = NTSTATUS 0xC0000031'i32
  STATUS_DISK_CORRUPT_ERROR* = NTSTATUS 0xC0000032'i32
  STATUS_OBJECT_NAME_INVALID* = NTSTATUS 0xC0000033'i32
  STATUS_OBJECT_NAME_NOT_FOUND* = NTSTATUS 0xC0000034'i32
  STATUS_OBJECT_NAME_COLLISION* = NTSTATUS 0xC0000035'i32
  STATUS_PORT_DISCONNECTED* = NTSTATUS 0xC0000037'i32
  STATUS_DEVICE_ALREADY_ATTACHED* = NTSTATUS 0xC0000038'i32
  STATUS_OBJECT_PATH_INVALID* = NTSTATUS 0xC0000039'i32
  STATUS_OBJECT_PATH_NOT_FOUND* = NTSTATUS 0xC000003A'i32
  STATUS_OBJECT_PATH_SYNTAX_BAD* = NTSTATUS 0xC000003B'i32
  STATUS_DATA_OVERRUN* = NTSTATUS 0xC000003C'i32
  STATUS_DATA_LATE_ERROR* = NTSTATUS 0xC000003D'i32
  STATUS_DATA_ERROR* = NTSTATUS 0xC000003E'i32
  STATUS_CRC_ERROR* = NTSTATUS 0xC000003F'i32
  STATUS_SECTION_TOO_BIG* = NTSTATUS 0xC0000040'i32
  STATUS_PORT_CONNECTION_REFUSED* = NTSTATUS 0xC0000041'i32
  STATUS_INVALID_PORT_HANDLE* = NTSTATUS 0xC0000042'i32
  STATUS_SHARING_VIOLATION* = NTSTATUS 0xC0000043'i32
  STATUS_QUOTA_EXCEEDED* = NTSTATUS 0xC0000044'i32
  STATUS_INVALID_PAGE_PROTECTION* = NTSTATUS 0xC0000045'i32
  STATUS_MUTANT_NOT_OWNED* = NTSTATUS 0xC0000046'i32
  STATUS_SEMAPHORE_LIMIT_EXCEEDED* = NTSTATUS 0xC0000047'i32
  STATUS_PORT_ALREADY_SET* = NTSTATUS 0xC0000048'i32
  STATUS_SECTION_NOT_IMAGE* = NTSTATUS 0xC0000049'i32
  STATUS_SUSPEND_COUNT_EXCEEDED* = NTSTATUS 0xC000004A'i32
  STATUS_THREAD_IS_TERMINATING* = NTSTATUS 0xC000004B'i32
  STATUS_BAD_WORKING_SET_LIMIT* = NTSTATUS 0xC000004C'i32
  STATUS_INCOMPATIBLE_FILE_MAP* = NTSTATUS 0xC000004D'i32
  STATUS_SECTION_PROTECTION* = NTSTATUS 0xC000004E'i32
  STATUS_EAS_NOT_SUPPORTED* = NTSTATUS 0xC000004F'i32
  STATUS_EA_TOO_LARGE* = NTSTATUS 0xC0000050'i32
  STATUS_NONEXISTENT_EA_ENTRY* = NTSTATUS 0xC0000051'i32
  STATUS_NO_EAS_ON_FILE* = NTSTATUS 0xC0000052'i32
  STATUS_EA_CORRUPT_ERROR* = NTSTATUS 0xC0000053'i32
  STATUS_FILE_LOCK_CONFLICT* = NTSTATUS 0xC0000054'i32
  STATUS_LOCK_NOT_GRANTED* = NTSTATUS 0xC0000055'i32
  STATUS_DELETE_PENDING* = NTSTATUS 0xC0000056'i32
  STATUS_CTL_FILE_NOT_SUPPORTED* = NTSTATUS 0xC0000057'i32
  STATUS_UNKNOWN_REVISION* = NTSTATUS 0xC0000058'i32
  STATUS_REVISION_MISMATCH* = NTSTATUS 0xC0000059'i32
  STATUS_INVALID_OWNER* = NTSTATUS 0xC000005A'i32
  STATUS_INVALID_PRIMARY_GROUP* = NTSTATUS 0xC000005B'i32
  STATUS_NO_IMPERSONATION_TOKEN* = NTSTATUS 0xC000005C'i32
  STATUS_CANT_DISABLE_MANDATORY* = NTSTATUS 0xC000005D'i32
  STATUS_NO_LOGON_SERVERS* = NTSTATUS 0xC000005E'i32
  STATUS_NO_SUCH_LOGON_SESSION* = NTSTATUS 0xC000005F'i32
  STATUS_NO_SUCH_PRIVILEGE* = NTSTATUS 0xC0000060'i32
  STATUS_PRIVILEGE_NOT_HELD* = NTSTATUS 0xC0000061'i32
  STATUS_INVALID_ACCOUNT_NAME* = NTSTATUS 0xC0000062'i32
  STATUS_USER_EXISTS* = NTSTATUS 0xC0000063'i32
  STATUS_NO_SUCH_USER* = NTSTATUS 0xC0000064'i32
  STATUS_GROUP_EXISTS* = NTSTATUS 0xC0000065'i32
  STATUS_NO_SUCH_GROUP* = NTSTATUS 0xC0000066'i32
  STATUS_MEMBER_IN_GROUP* = NTSTATUS 0xC0000067'i32
  STATUS_MEMBER_NOT_IN_GROUP* = NTSTATUS 0xC0000068'i32
  STATUS_LAST_ADMIN* = NTSTATUS 0xC0000069'i32
  STATUS_WRONG_PASSWORD* = NTSTATUS 0xC000006A'i32
  STATUS_ILL_FORMED_PASSWORD* = NTSTATUS 0xC000006B'i32
  STATUS_PASSWORD_RESTRICTION* = NTSTATUS 0xC000006C'i32
  STATUS_LOGON_FAILURE* = NTSTATUS 0xC000006D'i32
  STATUS_ACCOUNT_RESTRICTION* = NTSTATUS 0xC000006E'i32
  STATUS_INVALID_LOGON_HOURS* = NTSTATUS 0xC000006F'i32
  STATUS_INVALID_WORKSTATION* = NTSTATUS 0xC0000070'i32
  STATUS_PASSWORD_EXPIRED* = NTSTATUS 0xC0000071'i32
  STATUS_ACCOUNT_DISABLED* = NTSTATUS 0xC0000072'i32
  STATUS_NONE_MAPPED* = NTSTATUS 0xC0000073'i32
  STATUS_TOO_MANY_LUIDS_REQUESTED* = NTSTATUS 0xC0000074'i32
  STATUS_LUIDS_EXHAUSTED* = NTSTATUS 0xC0000075'i32
  STATUS_INVALID_SUB_AUTHORITY* = NTSTATUS 0xC0000076'i32
  STATUS_INVALID_ACL* = NTSTATUS 0xC0000077'i32
  STATUS_INVALID_SID* = NTSTATUS 0xC0000078'i32
  STATUS_INVALID_SECURITY_DESCR* = NTSTATUS 0xC0000079'i32
  STATUS_PROCEDURE_NOT_FOUND* = NTSTATUS 0xC000007A'i32
  STATUS_INVALID_IMAGE_FORMAT* = NTSTATUS 0xC000007B'i32
  STATUS_NO_TOKEN* = NTSTATUS 0xC000007C'i32
  STATUS_BAD_INHERITANCE_ACL* = NTSTATUS 0xC000007D'i32
  STATUS_RANGE_NOT_LOCKED* = NTSTATUS 0xC000007E'i32
  STATUS_DISK_FULL* = NTSTATUS 0xC000007F'i32
  STATUS_SERVER_DISABLED* = NTSTATUS 0xC0000080'i32
  STATUS_SERVER_NOT_DISABLED* = NTSTATUS 0xC0000081'i32
  STATUS_TOO_MANY_GUIDS_REQUESTED* = NTSTATUS 0xC0000082'i32
  STATUS_GUIDS_EXHAUSTED* = NTSTATUS 0xC0000083'i32
  STATUS_INVALID_ID_AUTHORITY* = NTSTATUS 0xC0000084'i32
  STATUS_AGENTS_EXHAUSTED* = NTSTATUS 0xC0000085'i32
  STATUS_INVALID_VOLUME_LABEL* = NTSTATUS 0xC0000086'i32
  STATUS_SECTION_NOT_EXTENDED* = NTSTATUS 0xC0000087'i32
  STATUS_NOT_MAPPED_DATA* = NTSTATUS 0xC0000088'i32
  STATUS_RESOURCE_DATA_NOT_FOUND* = NTSTATUS 0xC0000089'i32
  STATUS_RESOURCE_TYPE_NOT_FOUND* = NTSTATUS 0xC000008A'i32
  STATUS_RESOURCE_NAME_NOT_FOUND* = NTSTATUS 0xC000008B'i32
  STATUS_ARRAY_BOUNDS_EXCEEDED* = NTSTATUS 0xC000008C'i32
  STATUS_FLOAT_DENORMAL_OPERAND* = NTSTATUS 0xC000008D'i32
  STATUS_FLOAT_DIVIDE_BY_ZERO* = NTSTATUS 0xC000008E'i32
  STATUS_FLOAT_INEXACT_RESULT* = NTSTATUS 0xC000008F'i32
  STATUS_FLOAT_INVALID_OPERATION* = NTSTATUS 0xC0000090'i32
  STATUS_FLOAT_OVERFLOW* = NTSTATUS 0xC0000091'i32
  STATUS_FLOAT_STACK_CHECK* = NTSTATUS 0xC0000092'i32
  STATUS_FLOAT_UNDERFLOW* = NTSTATUS 0xC0000093'i32
  STATUS_INTEGER_DIVIDE_BY_ZERO* = NTSTATUS 0xC0000094'i32
  STATUS_INTEGER_OVERFLOW* = NTSTATUS 0xC0000095'i32
  STATUS_PRIVILEGED_INSTRUCTION* = NTSTATUS 0xC0000096'i32
  STATUS_TOO_MANY_PAGING_FILES* = NTSTATUS 0xC0000097'i32
  STATUS_FILE_INVALID* = NTSTATUS 0xC0000098'i32
  STATUS_ALLOTTED_SPACE_EXCEEDED* = NTSTATUS 0xC0000099'i32
  STATUS_INSUFFICIENT_RESOURCES* = NTSTATUS 0xC000009A'i32
  STATUS_DFS_EXIT_PATH_FOUND* = NTSTATUS 0xC000009B'i32
  STATUS_DEVICE_DATA_ERROR* = NTSTATUS 0xC000009C'i32
  STATUS_DEVICE_NOT_CONNECTED* = NTSTATUS 0xC000009D'i32
  STATUS_FREE_VM_NOT_AT_BASE* = NTSTATUS 0xC000009F'i32
  STATUS_MEMORY_NOT_ALLOCATED* = NTSTATUS 0xC00000A0'i32
  STATUS_WORKING_SET_QUOTA* = NTSTATUS 0xC00000A1'i32
  STATUS_MEDIA_WRITE_PROTECTED* = NTSTATUS 0xC00000A2'i32
  STATUS_DEVICE_NOT_READY* = NTSTATUS 0xC00000A3'i32
  STATUS_INVALID_GROUP_ATTRIBUTES* = NTSTATUS 0xC00000A4'i32
  STATUS_BAD_IMPERSONATION_LEVEL* = NTSTATUS 0xC00000A5'i32
  STATUS_CANT_OPEN_ANONYMOUS* = NTSTATUS 0xC00000A6'i32
  STATUS_BAD_VALIDATION_CLASS* = NTSTATUS 0xC00000A7'i32
  STATUS_BAD_TOKEN_TYPE* = NTSTATUS 0xC00000A8'i32
  STATUS_BAD_MASTER_BOOT_RECORD* = NTSTATUS 0xC00000A9'i32
  STATUS_INSTRUCTION_MISALIGNMENT* = NTSTATUS 0xC00000AA'i32
  STATUS_INSTANCE_NOT_AVAILABLE* = NTSTATUS 0xC00000AB'i32
  STATUS_PIPE_NOT_AVAILABLE* = NTSTATUS 0xC00000AC'i32
  STATUS_INVALID_PIPE_STATE* = NTSTATUS 0xC00000AD'i32
  STATUS_PIPE_BUSY* = NTSTATUS 0xC00000AE'i32
  STATUS_ILLEGAL_FUNCTION* = NTSTATUS 0xC00000AF'i32
  STATUS_PIPE_DISCONNECTED* = NTSTATUS 0xC00000B0'i32
  STATUS_PIPE_CLOSING* = NTSTATUS 0xC00000B1'i32
  STATUS_PIPE_CONNECTED* = NTSTATUS 0xC00000B2'i32
  STATUS_PIPE_LISTENING* = NTSTATUS 0xC00000B3'i32
  STATUS_INVALID_READ_MODE* = NTSTATUS 0xC00000B4'i32
  STATUS_IO_TIMEOUT* = NTSTATUS 0xC00000B5'i32
  STATUS_FILE_FORCED_CLOSED* = NTSTATUS 0xC00000B6'i32
  STATUS_PROFILING_NOT_STARTED* = NTSTATUS 0xC00000B7'i32
  STATUS_PROFILING_NOT_STOPPED* = NTSTATUS 0xC00000B8'i32
  STATUS_COULD_NOT_INTERPRET* = NTSTATUS 0xC00000B9'i32
  STATUS_FILE_IS_A_DIRECTORY* = NTSTATUS 0xC00000BA'i32
  STATUS_NOT_SUPPORTED* = NTSTATUS 0xC00000BB'i32
  STATUS_REMOTE_NOT_LISTENING* = NTSTATUS 0xC00000BC'i32
  STATUS_DUPLICATE_NAME* = NTSTATUS 0xC00000BD'i32
  STATUS_BAD_NETWORK_PATH* = NTSTATUS 0xC00000BE'i32
  STATUS_NETWORK_BUSY* = NTSTATUS 0xC00000BF'i32
  STATUS_DEVICE_DOES_NOT_EXIST* = NTSTATUS 0xC00000C0'i32
  STATUS_TOO_MANY_COMMANDS* = NTSTATUS 0xC00000C1'i32
  STATUS_ADAPTER_HARDWARE_ERROR* = NTSTATUS 0xC00000C2'i32
  STATUS_INVALID_NETWORK_RESPONSE* = NTSTATUS 0xC00000C3'i32
  STATUS_UNEXPECTED_NETWORK_ERROR* = NTSTATUS 0xC00000C4'i32
  STATUS_BAD_REMOTE_ADAPTER* = NTSTATUS 0xC00000C5'i32
  STATUS_PRINT_QUEUE_FULL* = NTSTATUS 0xC00000C6'i32
  STATUS_NO_SPOOL_SPACE* = NTSTATUS 0xC00000C7'i32
  STATUS_PRINT_CANCELLED* = NTSTATUS 0xC00000C8'i32
  STATUS_NETWORK_NAME_DELETED* = NTSTATUS 0xC00000C9'i32
  STATUS_NETWORK_ACCESS_DENIED* = NTSTATUS 0xC00000CA'i32
  STATUS_BAD_DEVICE_TYPE* = NTSTATUS 0xC00000CB'i32
  STATUS_BAD_NETWORK_NAME* = NTSTATUS 0xC00000CC'i32
  STATUS_TOO_MANY_NAMES* = NTSTATUS 0xC00000CD'i32
  STATUS_TOO_MANY_SESSIONS* = NTSTATUS 0xC00000CE'i32
  STATUS_SHARING_PAUSED* = NTSTATUS 0xC00000CF'i32
  STATUS_REQUEST_NOT_ACCEPTED* = NTSTATUS 0xC00000D0'i32
  STATUS_REDIRECTOR_PAUSED* = NTSTATUS 0xC00000D1'i32
  STATUS_NET_WRITE_FAULT* = NTSTATUS 0xC00000D2'i32
  STATUS_PROFILING_AT_LIMIT* = NTSTATUS 0xC00000D3'i32
  STATUS_NOT_SAME_DEVICE* = NTSTATUS 0xC00000D4'i32
  STATUS_FILE_RENAMED* = NTSTATUS 0xC00000D5'i32
  STATUS_VIRTUAL_CIRCUIT_CLOSED* = NTSTATUS 0xC00000D6'i32
  STATUS_NO_SECURITY_ON_OBJECT* = NTSTATUS 0xC00000D7'i32
  STATUS_CANT_WAIT* = NTSTATUS 0xC00000D8'i32
  STATUS_PIPE_EMPTY* = NTSTATUS 0xC00000D9'i32
  STATUS_CANT_ACCESS_DOMAIN_INFO* = NTSTATUS 0xC00000DA'i32
  STATUS_CANT_TERMINATE_SELF* = NTSTATUS 0xC00000DB'i32
  STATUS_INVALID_SERVER_STATE* = NTSTATUS 0xC00000DC'i32
  STATUS_INVALID_DOMAIN_STATE* = NTSTATUS 0xC00000DD'i32
  STATUS_INVALID_DOMAIN_ROLE* = NTSTATUS 0xC00000DE'i32
  STATUS_NO_SUCH_DOMAIN* = NTSTATUS 0xC00000DF'i32
  STATUS_DOMAIN_EXISTS* = NTSTATUS 0xC00000E0'i32
  STATUS_DOMAIN_LIMIT_EXCEEDED* = NTSTATUS 0xC00000E1'i32
  STATUS_OPLOCK_NOT_GRANTED* = NTSTATUS 0xC00000E2'i32
  STATUS_INVALID_OPLOCK_PROTOCOL* = NTSTATUS 0xC00000E3'i32
  STATUS_INTERNAL_DB_CORRUPTION* = NTSTATUS 0xC00000E4'i32
  STATUS_INTERNAL_ERROR* = NTSTATUS 0xC00000E5'i32
  STATUS_GENERIC_NOT_MAPPED* = NTSTATUS 0xC00000E6'i32
  STATUS_BAD_DESCRIPTOR_FORMAT* = NTSTATUS 0xC00000E7'i32
  STATUS_INVALID_USER_BUFFER* = NTSTATUS 0xC00000E8'i32
  STATUS_UNEXPECTED_IO_ERROR* = NTSTATUS 0xC00000E9'i32
  STATUS_UNEXPECTED_MM_CREATE_ERR* = NTSTATUS 0xC00000EA'i32
  STATUS_UNEXPECTED_MM_MAP_ERROR* = NTSTATUS 0xC00000EB'i32
  STATUS_UNEXPECTED_MM_EXTEND_ERR* = NTSTATUS 0xC00000EC'i32
  STATUS_NOT_LOGON_PROCESS* = NTSTATUS 0xC00000ED'i32
  STATUS_LOGON_SESSION_EXISTS* = NTSTATUS 0xC00000EE'i32
  STATUS_INVALID_PARAMETER_1* = NTSTATUS 0xC00000EF'i32
  STATUS_INVALID_PARAMETER_2* = NTSTATUS 0xC00000F0'i32
  STATUS_INVALID_PARAMETER_3* = NTSTATUS 0xC00000F1'i32
  STATUS_INVALID_PARAMETER_4* = NTSTATUS 0xC00000F2'i32
  STATUS_INVALID_PARAMETER_5* = NTSTATUS 0xC00000F3'i32
  STATUS_INVALID_PARAMETER_6* = NTSTATUS 0xC00000F4'i32
  STATUS_INVALID_PARAMETER_7* = NTSTATUS 0xC00000F5'i32
  STATUS_INVALID_PARAMETER_8* = NTSTATUS 0xC00000F6'i32
  STATUS_INVALID_PARAMETER_9* = NTSTATUS 0xC00000F7'i32
  STATUS_INVALID_PARAMETER_10* = NTSTATUS 0xC00000F8'i32
  STATUS_INVALID_PARAMETER_11* = NTSTATUS 0xC00000F9'i32
  STATUS_INVALID_PARAMETER_12* = NTSTATUS 0xC00000FA'i32
  STATUS_REDIRECTOR_NOT_STARTED* = NTSTATUS 0xC00000FB'i32
  STATUS_REDIRECTOR_STARTED* = NTSTATUS 0xC00000FC'i32
  STATUS_STACK_OVERFLOW* = NTSTATUS 0xC00000FD'i32
  STATUS_NO_SUCH_PACKAGE* = NTSTATUS 0xC00000FE'i32
  STATUS_BAD_FUNCTION_TABLE* = NTSTATUS 0xC00000FF'i32
  STATUS_VARIABLE_NOT_FOUND* = NTSTATUS 0xC0000100'i32
  STATUS_DIRECTORY_NOT_EMPTY* = NTSTATUS 0xC0000101'i32
  STATUS_FILE_CORRUPT_ERROR* = NTSTATUS 0xC0000102'i32
  STATUS_NOT_A_DIRECTORY* = NTSTATUS 0xC0000103'i32
  STATUS_BAD_LOGON_SESSION_STATE* = NTSTATUS 0xC0000104'i32
  STATUS_LOGON_SESSION_COLLISION* = NTSTATUS 0xC0000105'i32
  STATUS_NAME_TOO_LONG* = NTSTATUS 0xC0000106'i32
  STATUS_FILES_OPEN* = NTSTATUS 0xC0000107'i32
  STATUS_CONNECTION_IN_USE* = NTSTATUS 0xC0000108'i32
  STATUS_MESSAGE_NOT_FOUND* = NTSTATUS 0xC0000109'i32
  STATUS_PROCESS_IS_TERMINATING* = NTSTATUS 0xC000010A'i32
  STATUS_INVALID_LOGON_TYPE* = NTSTATUS 0xC000010B'i32
  STATUS_NO_GUID_TRANSLATION* = NTSTATUS 0xC000010C'i32
  STATUS_CANNOT_IMPERSONATE* = NTSTATUS 0xC000010D'i32
  STATUS_IMAGE_ALREADY_LOADED* = NTSTATUS 0xC000010E'i32
  STATUS_NO_LDT* = NTSTATUS 0xC0000117'i32
  STATUS_INVALID_LDT_SIZE* = NTSTATUS 0xC0000118'i32
  STATUS_INVALID_LDT_OFFSET* = NTSTATUS 0xC0000119'i32
  STATUS_INVALID_LDT_DESCRIPTOR* = NTSTATUS 0xC000011A'i32
  STATUS_INVALID_IMAGE_NE_FORMAT* = NTSTATUS 0xC000011B'i32
  STATUS_RXACT_INVALID_STATE* = NTSTATUS 0xC000011C'i32
  STATUS_RXACT_COMMIT_FAILURE* = NTSTATUS 0xC000011D'i32
  STATUS_MAPPED_FILE_SIZE_ZERO* = NTSTATUS 0xC000011E'i32
  STATUS_TOO_MANY_OPENED_FILES* = NTSTATUS 0xC000011F'i32
  STATUS_CANCELLED* = NTSTATUS 0xC0000120'i32
  STATUS_CANNOT_DELETE* = NTSTATUS 0xC0000121'i32
  STATUS_INVALID_COMPUTER_NAME* = NTSTATUS 0xC0000122'i32
  STATUS_FILE_DELETED* = NTSTATUS 0xC0000123'i32
  STATUS_SPECIAL_ACCOUNT* = NTSTATUS 0xC0000124'i32
  STATUS_SPECIAL_GROUP* = NTSTATUS 0xC0000125'i32
  STATUS_SPECIAL_USER* = NTSTATUS 0xC0000126'i32
  STATUS_MEMBERS_PRIMARY_GROUP* = NTSTATUS 0xC0000127'i32
  STATUS_FILE_CLOSED* = NTSTATUS 0xC0000128'i32
  STATUS_TOO_MANY_THREADS* = NTSTATUS 0xC0000129'i32
  STATUS_THREAD_NOT_IN_PROCESS* = NTSTATUS 0xC000012A'i32
  STATUS_TOKEN_ALREADY_IN_USE* = NTSTATUS 0xC000012B'i32
  STATUS_PAGEFILE_QUOTA_EXCEEDED* = NTSTATUS 0xC000012C'i32
  STATUS_COMMITMENT_LIMIT* = NTSTATUS 0xC000012D'i32
  STATUS_INVALID_IMAGE_LE_FORMAT* = NTSTATUS 0xC000012E'i32
  STATUS_INVALID_IMAGE_NOT_MZ* = NTSTATUS 0xC000012F'i32
  STATUS_INVALID_IMAGE_PROTECT* = NTSTATUS 0xC0000130'i32
  STATUS_INVALID_IMAGE_WIN_16* = NTSTATUS 0xC0000131'i32
  STATUS_LOGON_SERVER_CONFLICT* = NTSTATUS 0xC0000132'i32
  STATUS_TIME_DIFFERENCE_AT_DC* = NTSTATUS 0xC0000133'i32
  STATUS_SYNCHRONIZATION_REQUIRED* = NTSTATUS 0xC0000134'i32
  STATUS_DLL_NOT_FOUND* = NTSTATUS 0xC0000135'i32
  STATUS_OPEN_FAILED* = NTSTATUS 0xC0000136'i32
  STATUS_IO_PRIVILEGE_FAILED* = NTSTATUS 0xC0000137'i32
  STATUS_ORDINAL_NOT_FOUND* = NTSTATUS 0xC0000138'i32
  STATUS_ENTRYPOINT_NOT_FOUND* = NTSTATUS 0xC0000139'i32
  STATUS_CONTROL_C_EXIT* = NTSTATUS 0xC000013A'i32
  STATUS_LOCAL_DISCONNECT* = NTSTATUS 0xC000013B'i32
  STATUS_REMOTE_DISCONNECT* = NTSTATUS 0xC000013C'i32
  STATUS_REMOTE_RESOURCES* = NTSTATUS 0xC000013D'i32
  STATUS_LINK_FAILED* = NTSTATUS 0xC000013E'i32
  STATUS_LINK_TIMEOUT* = NTSTATUS 0xC000013F'i32
  STATUS_INVALID_CONNECTION* = NTSTATUS 0xC0000140'i32
  STATUS_INVALID_ADDRESS* = NTSTATUS 0xC0000141'i32
  STATUS_DLL_INIT_FAILED* = NTSTATUS 0xC0000142'i32
  STATUS_MISSING_SYSTEMFILE* = NTSTATUS 0xC0000143'i32
  STATUS_UNHANDLED_EXCEPTION* = NTSTATUS 0xC0000144'i32
  STATUS_APP_INIT_FAILURE* = NTSTATUS 0xC0000145'i32
  STATUS_PAGEFILE_CREATE_FAILED* = NTSTATUS 0xC0000146'i32
  STATUS_NO_PAGEFILE* = NTSTATUS 0xC0000147'i32
  STATUS_INVALID_LEVEL* = NTSTATUS 0xC0000148'i32
  STATUS_WRONG_PASSWORD_CORE* = NTSTATUS 0xC0000149'i32
  STATUS_ILLEGAL_FLOAT_CONTEXT* = NTSTATUS 0xC000014A'i32
  STATUS_PIPE_BROKEN* = NTSTATUS 0xC000014B'i32
  STATUS_REGISTRY_CORRUPT* = NTSTATUS 0xC000014C'i32
  STATUS_REGISTRY_IO_FAILED* = NTSTATUS 0xC000014D'i32
  STATUS_NO_EVENT_PAIR* = NTSTATUS 0xC000014E'i32
  STATUS_UNRECOGNIZED_VOLUME* = NTSTATUS 0xC000014F'i32
  STATUS_SERIAL_NO_DEVICE_INITED* = NTSTATUS 0xC0000150'i32
  STATUS_NO_SUCH_ALIAS* = NTSTATUS 0xC0000151'i32
  STATUS_MEMBER_NOT_IN_ALIAS* = NTSTATUS 0xC0000152'i32
  STATUS_MEMBER_IN_ALIAS* = NTSTATUS 0xC0000153'i32
  STATUS_ALIAS_EXISTS* = NTSTATUS 0xC0000154'i32
  STATUS_LOGON_NOT_GRANTED* = NTSTATUS 0xC0000155'i32
  STATUS_TOO_MANY_SECRETS* = NTSTATUS 0xC0000156'i32
  STATUS_SECRET_TOO_LONG* = NTSTATUS 0xC0000157'i32
  STATUS_INTERNAL_DB_ERROR* = NTSTATUS 0xC0000158'i32
  STATUS_FULLSCREEN_MODE* = NTSTATUS 0xC0000159'i32
  STATUS_TOO_MANY_CONTEXT_IDS* = NTSTATUS 0xC000015A'i32
  STATUS_LOGON_TYPE_NOT_GRANTED* = NTSTATUS 0xC000015B'i32
  STATUS_NOT_REGISTRY_FILE* = NTSTATUS 0xC000015C'i32
  STATUS_NT_CROSS_ENCRYPTION_REQUIRED* = NTSTATUS 0xC000015D'i32
  STATUS_DOMAIN_CTRLR_CONFIG_ERROR* = NTSTATUS 0xC000015E'i32
  STATUS_FT_MISSING_MEMBER* = NTSTATUS 0xC000015F'i32
  STATUS_ILL_FORMED_SERVICE_ENTRY* = NTSTATUS 0xC0000160'i32
  STATUS_ILLEGAL_CHARACTER* = NTSTATUS 0xC0000161'i32
  STATUS_UNMAPPABLE_CHARACTER* = NTSTATUS 0xC0000162'i32
  STATUS_UNDEFINED_CHARACTER* = NTSTATUS 0xC0000163'i32
  STATUS_FLOPPY_VOLUME* = NTSTATUS 0xC0000164'i32
  STATUS_FLOPPY_ID_MARK_NOT_FOUND* = NTSTATUS 0xC0000165'i32
  STATUS_FLOPPY_WRONG_CYLINDER* = NTSTATUS 0xC0000166'i32
  STATUS_FLOPPY_UNKNOWN_ERROR* = NTSTATUS 0xC0000167'i32
  STATUS_FLOPPY_BAD_REGISTERS* = NTSTATUS 0xC0000168'i32
  STATUS_DISK_RECALIBRATE_FAILED* = NTSTATUS 0xC0000169'i32
  STATUS_DISK_OPERATION_FAILED* = NTSTATUS 0xC000016A'i32
  STATUS_DISK_RESET_FAILED* = NTSTATUS 0xC000016B'i32
  STATUS_SHARED_IRQ_BUSY* = NTSTATUS 0xC000016C'i32
  STATUS_FT_ORPHANING* = NTSTATUS 0xC000016D'i32
  STATUS_BIOS_FAILED_TO_CONNECT_INTERRUPT* = NTSTATUS 0xC000016E'i32
  STATUS_PARTITION_FAILURE* = NTSTATUS 0xC0000172'i32
  STATUS_INVALID_BLOCK_LENGTH* = NTSTATUS 0xC0000173'i32
  STATUS_DEVICE_NOT_PARTITIONED* = NTSTATUS 0xC0000174'i32
  STATUS_UNABLE_TO_LOCK_MEDIA* = NTSTATUS 0xC0000175'i32
  STATUS_UNABLE_TO_UNLOAD_MEDIA* = NTSTATUS 0xC0000176'i32
  STATUS_EOM_OVERFLOW* = NTSTATUS 0xC0000177'i32
  STATUS_NO_MEDIA* = NTSTATUS 0xC0000178'i32
  STATUS_NO_SUCH_MEMBER* = NTSTATUS 0xC000017A'i32
  STATUS_INVALID_MEMBER* = NTSTATUS 0xC000017B'i32
  STATUS_KEY_DELETED* = NTSTATUS 0xC000017C'i32
  STATUS_NO_LOG_SPACE* = NTSTATUS 0xC000017D'i32
  STATUS_TOO_MANY_SIDS* = NTSTATUS 0xC000017E'i32
  STATUS_LM_CROSS_ENCRYPTION_REQUIRED* = NTSTATUS 0xC000017F'i32
  STATUS_KEY_HAS_CHILDREN* = NTSTATUS 0xC0000180'i32
  STATUS_CHILD_MUST_BE_VOLATILE* = NTSTATUS 0xC0000181'i32
  STATUS_DEVICE_CONFIGURATION_ERROR* = NTSTATUS 0xC0000182'i32
  STATUS_DRIVER_INTERNAL_ERROR* = NTSTATUS 0xC0000183'i32
  STATUS_INVALID_DEVICE_STATE* = NTSTATUS 0xC0000184'i32
  STATUS_IO_DEVICE_ERROR* = NTSTATUS 0xC0000185'i32
  STATUS_DEVICE_PROTOCOL_ERROR* = NTSTATUS 0xC0000186'i32
  STATUS_BACKUP_CONTROLLER* = NTSTATUS 0xC0000187'i32
  STATUS_LOG_FILE_FULL* = NTSTATUS 0xC0000188'i32
  STATUS_TOO_LATE* = NTSTATUS 0xC0000189'i32
  STATUS_NO_TRUST_LSA_SECRET* = NTSTATUS 0xC000018A'i32
  STATUS_NO_TRUST_SAM_ACCOUNT* = NTSTATUS 0xC000018B'i32
  STATUS_TRUSTED_DOMAIN_FAILURE* = NTSTATUS 0xC000018C'i32
  STATUS_TRUSTED_RELATIONSHIP_FAILURE* = NTSTATUS 0xC000018D'i32
  STATUS_EVENTLOG_FILE_CORRUPT* = NTSTATUS 0xC000018E'i32
  STATUS_EVENTLOG_CANT_START* = NTSTATUS 0xC000018F'i32
  STATUS_TRUST_FAILURE* = NTSTATUS 0xC0000190'i32
  STATUS_MUTANT_LIMIT_EXCEEDED* = NTSTATUS 0xC0000191'i32
  STATUS_NETLOGON_NOT_STARTED* = NTSTATUS 0xC0000192'i32
  STATUS_ACCOUNT_EXPIRED* = NTSTATUS 0xC0000193'i32
  STATUS_POSSIBLE_DEADLOCK* = NTSTATUS 0xC0000194'i32
  STATUS_NETWORK_CREDENTIAL_CONFLICT* = NTSTATUS 0xC0000195'i32
  STATUS_REMOTE_SESSION_LIMIT* = NTSTATUS 0xC0000196'i32
  STATUS_EVENTLOG_FILE_CHANGED* = NTSTATUS 0xC0000197'i32
  STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT* = NTSTATUS 0xC0000198'i32
  STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT* = NTSTATUS 0xC0000199'i32
  STATUS_NOLOGON_SERVER_TRUST_ACCOUNT* = NTSTATUS 0xC000019A'i32
  STATUS_DOMAIN_TRUST_INCONSISTENT* = NTSTATUS 0xC000019B'i32
  STATUS_FS_DRIVER_REQUIRED* = NTSTATUS 0xC000019C'i32
  STATUS_IMAGE_ALREADY_LOADED_AS_DLL* = NTSTATUS 0xC000019D'i32
  STATUS_INCOMPATIBLE_WITH_GLOBAL_SHORT_NAME_REGISTRY_SETTING* = NTSTATUS 0xC000019E'i32
  STATUS_SHORT_NAMES_NOT_ENABLED_ON_VOLUME* = NTSTATUS 0xC000019F'i32
  STATUS_SECURITY_STREAM_IS_INCONSISTENT* = NTSTATUS 0xC00001A0'i32
  STATUS_INVALID_LOCK_RANGE* = NTSTATUS 0xC00001A1'i32
  STATUS_INVALID_ACE_CONDITION* = NTSTATUS 0xC00001A2'i32
  STATUS_IMAGE_SUBSYSTEM_NOT_PRESENT* = NTSTATUS 0xC00001A3'i32
  STATUS_NOTIFICATION_GUID_ALREADY_DEFINED* = NTSTATUS 0xC00001A4'i32
  STATUS_NETWORK_OPEN_RESTRICTION* = NTSTATUS 0xC0000201'i32
  STATUS_NO_USER_SESSION_KEY* = NTSTATUS 0xC0000202'i32
  STATUS_USER_SESSION_DELETED* = NTSTATUS 0xC0000203'i32
  STATUS_RESOURCE_LANG_NOT_FOUND* = NTSTATUS 0xC0000204'i32
  STATUS_INSUFF_SERVER_RESOURCES* = NTSTATUS 0xC0000205'i32
  STATUS_INVALID_BUFFER_SIZE* = NTSTATUS 0xC0000206'i32
  STATUS_INVALID_ADDRESS_COMPONENT* = NTSTATUS 0xC0000207'i32
  STATUS_INVALID_ADDRESS_WILDCARD* = NTSTATUS 0xC0000208'i32
  STATUS_TOO_MANY_ADDRESSES* = NTSTATUS 0xC0000209'i32
  STATUS_ADDRESS_ALREADY_EXISTS* = NTSTATUS 0xC000020A'i32
  STATUS_ADDRESS_CLOSED* = NTSTATUS 0xC000020B'i32
  STATUS_CONNECTION_DISCONNECTED* = NTSTATUS 0xC000020C'i32
  STATUS_CONNECTION_RESET* = NTSTATUS 0xC000020D'i32
  STATUS_TOO_MANY_NODES* = NTSTATUS 0xC000020E'i32
  STATUS_TRANSACTION_ABORTED* = NTSTATUS 0xC000020F'i32
  STATUS_TRANSACTION_TIMED_OUT* = NTSTATUS 0xC0000210'i32
  STATUS_TRANSACTION_NO_RELEASE* = NTSTATUS 0xC0000211'i32
  STATUS_TRANSACTION_NO_MATCH* = NTSTATUS 0xC0000212'i32
  STATUS_TRANSACTION_RESPONDED* = NTSTATUS 0xC0000213'i32
  STATUS_TRANSACTION_INVALID_ID* = NTSTATUS 0xC0000214'i32
  STATUS_TRANSACTION_INVALID_TYPE* = NTSTATUS 0xC0000215'i32
  STATUS_NOT_SERVER_SESSION* = NTSTATUS 0xC0000216'i32
  STATUS_NOT_CLIENT_SESSION* = NTSTATUS 0xC0000217'i32
  STATUS_CANNOT_LOAD_REGISTRY_FILE* = NTSTATUS 0xC0000218'i32
  STATUS_DEBUG_ATTACH_FAILED* = NTSTATUS 0xC0000219'i32
  STATUS_SYSTEM_PROCESS_TERMINATED* = NTSTATUS 0xC000021A'i32
  STATUS_DATA_NOT_ACCEPTED* = NTSTATUS 0xC000021B'i32
  STATUS_NO_BROWSER_SERVERS_FOUND* = NTSTATUS 0xC000021C'i32
  STATUS_VDM_HARD_ERROR* = NTSTATUS 0xC000021D'i32
  STATUS_DRIVER_CANCEL_TIMEOUT* = NTSTATUS 0xC000021E'i32
  STATUS_REPLY_MESSAGE_MISMATCH* = NTSTATUS 0xC000021F'i32
  STATUS_MAPPED_ALIGNMENT* = NTSTATUS 0xC0000220'i32
  STATUS_IMAGE_CHECKSUM_MISMATCH* = NTSTATUS 0xC0000221'i32
  STATUS_LOST_WRITEBEHIND_DATA* = NTSTATUS 0xC0000222'i32
  STATUS_CLIENT_SERVER_PARAMETERS_INVALID* = NTSTATUS 0xC0000223'i32
  STATUS_PASSWORD_MUST_CHANGE* = NTSTATUS 0xC0000224'i32
  STATUS_NOT_FOUND* = NTSTATUS 0xC0000225'i32
  STATUS_NOT_TINY_STREAM* = NTSTATUS 0xC0000226'i32
  STATUS_RECOVERY_FAILURE* = NTSTATUS 0xC0000227'i32
  STATUS_STACK_OVERFLOW_READ* = NTSTATUS 0xC0000228'i32
  STATUS_FAIL_CHECK* = NTSTATUS 0xC0000229'i32
  STATUS_DUPLICATE_OBJECTID* = NTSTATUS 0xC000022A'i32
  STATUS_OBJECTID_EXISTS* = NTSTATUS 0xC000022B'i32
  STATUS_CONVERT_TO_LARGE* = NTSTATUS 0xC000022C'i32
  STATUS_RETRY* = NTSTATUS 0xC000022D'i32
  STATUS_FOUND_OUT_OF_SCOPE* = NTSTATUS 0xC000022E'i32
  STATUS_ALLOCATE_BUCKET* = NTSTATUS 0xC000022F'i32
  STATUS_PROPSET_NOT_FOUND* = NTSTATUS 0xC0000230'i32
  STATUS_MARSHALL_OVERFLOW* = NTSTATUS 0xC0000231'i32
  STATUS_INVALID_VARIANT* = NTSTATUS 0xC0000232'i32
  STATUS_DOMAIN_CONTROLLER_NOT_FOUND* = NTSTATUS 0xC0000233'i32
  STATUS_ACCOUNT_LOCKED_OUT* = NTSTATUS 0xC0000234'i32
  STATUS_HANDLE_NOT_CLOSABLE* = NTSTATUS 0xC0000235'i32
  STATUS_CONNECTION_REFUSED* = NTSTATUS 0xC0000236'i32
  STATUS_GRACEFUL_DISCONNECT* = NTSTATUS 0xC0000237'i32
  STATUS_ADDRESS_ALREADY_ASSOCIATED* = NTSTATUS 0xC0000238'i32
  STATUS_ADDRESS_NOT_ASSOCIATED* = NTSTATUS 0xC0000239'i32
  STATUS_CONNECTION_INVALID* = NTSTATUS 0xC000023A'i32
  STATUS_CONNECTION_ACTIVE* = NTSTATUS 0xC000023B'i32
  STATUS_NETWORK_UNREACHABLE* = NTSTATUS 0xC000023C'i32
  STATUS_HOST_UNREACHABLE* = NTSTATUS 0xC000023D'i32
  STATUS_PROTOCOL_UNREACHABLE* = NTSTATUS 0xC000023E'i32
  STATUS_PORT_UNREACHABLE* = NTSTATUS 0xC000023F'i32
  STATUS_REQUEST_ABORTED* = NTSTATUS 0xC0000240'i32
  STATUS_CONNECTION_ABORTED* = NTSTATUS 0xC0000241'i32
  STATUS_BAD_COMPRESSION_BUFFER* = NTSTATUS 0xC0000242'i32
  STATUS_USER_MAPPED_FILE* = NTSTATUS 0xC0000243'i32
  STATUS_AUDIT_FAILED* = NTSTATUS 0xC0000244'i32
  STATUS_TIMER_RESOLUTION_NOT_SET* = NTSTATUS 0xC0000245'i32
  STATUS_CONNECTION_COUNT_LIMIT* = NTSTATUS 0xC0000246'i32
  STATUS_LOGIN_TIME_RESTRICTION* = NTSTATUS 0xC0000247'i32
  STATUS_LOGIN_WKSTA_RESTRICTION* = NTSTATUS 0xC0000248'i32
  STATUS_IMAGE_MP_UP_MISMATCH* = NTSTATUS 0xC0000249'i32
  STATUS_INSUFFICIENT_LOGON_INFO* = NTSTATUS 0xC0000250'i32
  STATUS_BAD_DLL_ENTRYPOINT* = NTSTATUS 0xC0000251'i32
  STATUS_BAD_SERVICE_ENTRYPOINT* = NTSTATUS 0xC0000252'i32
  STATUS_LPC_REPLY_LOST* = NTSTATUS 0xC0000253'i32
  STATUS_IP_ADDRESS_CONFLICT1* = NTSTATUS 0xC0000254'i32
  STATUS_IP_ADDRESS_CONFLICT2* = NTSTATUS 0xC0000255'i32
  STATUS_REGISTRY_QUOTA_LIMIT* = NTSTATUS 0xC0000256'i32
  STATUS_PATH_NOT_COVERED* = NTSTATUS 0xC0000257'i32
  STATUS_NO_CALLBACK_ACTIVE* = NTSTATUS 0xC0000258'i32
  STATUS_LICENSE_QUOTA_EXCEEDED* = NTSTATUS 0xC0000259'i32
  STATUS_PWD_TOO_SHORT* = NTSTATUS 0xC000025A'i32
  STATUS_PWD_TOO_RECENT* = NTSTATUS 0xC000025B'i32
  STATUS_PWD_HISTORY_CONFLICT* = NTSTATUS 0xC000025C'i32
  STATUS_PLUGPLAY_NO_DEVICE* = NTSTATUS 0xC000025E'i32
  STATUS_UNSUPPORTED_COMPRESSION* = NTSTATUS 0xC000025F'i32
  STATUS_INVALID_HW_PROFILE* = NTSTATUS 0xC0000260'i32
  STATUS_INVALID_PLUGPLAY_DEVICE_PATH* = NTSTATUS 0xC0000261'i32
  STATUS_DRIVER_ORDINAL_NOT_FOUND* = NTSTATUS 0xC0000262'i32
  STATUS_DRIVER_ENTRYPOINT_NOT_FOUND* = NTSTATUS 0xC0000263'i32
  STATUS_RESOURCE_NOT_OWNED* = NTSTATUS 0xC0000264'i32
  STATUS_TOO_MANY_LINKS* = NTSTATUS 0xC0000265'i32
  STATUS_QUOTA_LIST_INCONSISTENT* = NTSTATUS 0xC0000266'i32
  STATUS_FILE_IS_OFFLINE* = NTSTATUS 0xC0000267'i32
  STATUS_EVALUATION_EXPIRATION* = NTSTATUS 0xC0000268'i32
  STATUS_ILLEGAL_DLL_RELOCATION* = NTSTATUS 0xC0000269'i32
  STATUS_LICENSE_VIOLATION* = NTSTATUS 0xC000026A'i32
  STATUS_DLL_INIT_FAILED_LOGOFF* = NTSTATUS 0xC000026B'i32
  STATUS_DRIVER_UNABLE_TO_LOAD* = NTSTATUS 0xC000026C'i32
  STATUS_DFS_UNAVAILABLE* = NTSTATUS 0xC000026D'i32
  STATUS_VOLUME_DISMOUNTED* = NTSTATUS 0xC000026E'i32
  STATUS_WX86_INTERNAL_ERROR* = NTSTATUS 0xC000026F'i32
  STATUS_WX86_FLOAT_STACK_CHECK* = NTSTATUS 0xC0000270'i32
  STATUS_VALIDATE_CONTINUE* = NTSTATUS 0xC0000271'i32
  STATUS_NO_MATCH* = NTSTATUS 0xC0000272'i32
  STATUS_NO_MORE_MATCHES* = NTSTATUS 0xC0000273'i32
  STATUS_NOT_A_REPARSE_POINT* = NTSTATUS 0xC0000275'i32
  STATUS_IO_REPARSE_TAG_INVALID* = NTSTATUS 0xC0000276'i32
  STATUS_IO_REPARSE_TAG_MISMATCH* = NTSTATUS 0xC0000277'i32
  STATUS_IO_REPARSE_DATA_INVALID* = NTSTATUS 0xC0000278'i32
  STATUS_IO_REPARSE_TAG_NOT_HANDLED* = NTSTATUS 0xC0000279'i32
  STATUS_REPARSE_POINT_NOT_RESOLVED* = NTSTATUS 0xC0000280'i32
  STATUS_DIRECTORY_IS_A_REPARSE_POINT* = NTSTATUS 0xC0000281'i32
  STATUS_RANGE_LIST_CONFLICT* = NTSTATUS 0xC0000282'i32
  STATUS_SOURCE_ELEMENT_EMPTY* = NTSTATUS 0xC0000283'i32
  STATUS_DESTINATION_ELEMENT_FULL* = NTSTATUS 0xC0000284'i32
  STATUS_ILLEGAL_ELEMENT_ADDRESS* = NTSTATUS 0xC0000285'i32
  STATUS_MAGAZINE_NOT_PRESENT* = NTSTATUS 0xC0000286'i32
  STATUS_REINITIALIZATION_NEEDED* = NTSTATUS 0xC0000287'i32
  STATUS_ENCRYPTION_FAILED* = NTSTATUS 0xC000028A'i32
  STATUS_DECRYPTION_FAILED* = NTSTATUS 0xC000028B'i32
  STATUS_RANGE_NOT_FOUND* = NTSTATUS 0xC000028C'i32
  STATUS_NO_RECOVERY_POLICY* = NTSTATUS 0xC000028D'i32
  STATUS_NO_EFS* = NTSTATUS 0xC000028E'i32
  STATUS_WRONG_EFS* = NTSTATUS 0xC000028F'i32
  STATUS_NO_USER_KEYS* = NTSTATUS 0xC0000290'i32
  STATUS_FILE_NOT_ENCRYPTED* = NTSTATUS 0xC0000291'i32
  STATUS_NOT_EXPORT_FORMAT* = NTSTATUS 0xC0000292'i32
  STATUS_FILE_ENCRYPTED* = NTSTATUS 0xC0000293'i32
  STATUS_WMI_GUID_NOT_FOUND* = NTSTATUS 0xC0000295'i32
  STATUS_WMI_INSTANCE_NOT_FOUND* = NTSTATUS 0xC0000296'i32
  STATUS_WMI_ITEMID_NOT_FOUND* = NTSTATUS 0xC0000297'i32
  STATUS_WMI_TRY_AGAIN* = NTSTATUS 0xC0000298'i32
  STATUS_SHARED_POLICY* = NTSTATUS 0xC0000299'i32
  STATUS_POLICY_OBJECT_NOT_FOUND* = NTSTATUS 0xC000029A'i32
  STATUS_POLICY_ONLY_IN_DS* = NTSTATUS 0xC000029B'i32
  STATUS_VOLUME_NOT_UPGRADED* = NTSTATUS 0xC000029C'i32
  STATUS_REMOTE_STORAGE_NOT_ACTIVE* = NTSTATUS 0xC000029D'i32
  STATUS_REMOTE_STORAGE_MEDIA_ERROR* = NTSTATUS 0xC000029E'i32
  STATUS_NO_TRACKING_SERVICE* = NTSTATUS 0xC000029F'i32
  STATUS_SERVER_SID_MISMATCH* = NTSTATUS 0xC00002A0'i32
  STATUS_DS_NO_ATTRIBUTE_OR_VALUE* = NTSTATUS 0xC00002A1'i32
  STATUS_DS_INVALID_ATTRIBUTE_SYNTAX* = NTSTATUS 0xC00002A2'i32
  STATUS_DS_ATTRIBUTE_TYPE_UNDEFINED* = NTSTATUS 0xC00002A3'i32
  STATUS_DS_ATTRIBUTE_OR_VALUE_EXISTS* = NTSTATUS 0xC00002A4'i32
  STATUS_DS_BUSY* = NTSTATUS 0xC00002A5'i32
  STATUS_DS_UNAVAILABLE* = NTSTATUS 0xC00002A6'i32
  STATUS_DS_NO_RIDS_ALLOCATED* = NTSTATUS 0xC00002A7'i32
  STATUS_DS_NO_MORE_RIDS* = NTSTATUS 0xC00002A8'i32
  STATUS_DS_INCORRECT_ROLE_OWNER* = NTSTATUS 0xC00002A9'i32
  STATUS_DS_RIDMGR_INIT_ERROR* = NTSTATUS 0xC00002AA'i32
  STATUS_DS_OBJ_CLASS_VIOLATION* = NTSTATUS 0xC00002AB'i32
  STATUS_DS_CANT_ON_NON_LEAF* = NTSTATUS 0xC00002AC'i32
  STATUS_DS_CANT_ON_RDN* = NTSTATUS 0xC00002AD'i32
  STATUS_DS_CANT_MOD_OBJ_CLASS* = NTSTATUS 0xC00002AE'i32
  STATUS_DS_CROSS_DOM_MOVE_FAILED* = NTSTATUS 0xC00002AF'i32
  STATUS_DS_GC_NOT_AVAILABLE* = NTSTATUS 0xC00002B0'i32
  STATUS_DIRECTORY_SERVICE_REQUIRED* = NTSTATUS 0xC00002B1'i32
  STATUS_REPARSE_ATTRIBUTE_CONFLICT* = NTSTATUS 0xC00002B2'i32
  STATUS_CANT_ENABLE_DENY_ONLY* = NTSTATUS 0xC00002B3'i32
  STATUS_FLOAT_MULTIPLE_FAULTS* = NTSTATUS 0xC00002B4'i32
  STATUS_FLOAT_MULTIPLE_TRAPS* = NTSTATUS 0xC00002B5'i32
  STATUS_DEVICE_REMOVED* = NTSTATUS 0xC00002B6'i32
  STATUS_JOURNAL_DELETE_IN_PROGRESS* = NTSTATUS 0xC00002B7'i32
  STATUS_JOURNAL_NOT_ACTIVE* = NTSTATUS 0xC00002B8'i32
  STATUS_NOINTERFACE* = NTSTATUS 0xC00002B9'i32
  STATUS_DS_ADMIN_LIMIT_EXCEEDED* = NTSTATUS 0xC00002C1'i32
  STATUS_DRIVER_FAILED_SLEEP* = NTSTATUS 0xC00002C2'i32
  STATUS_MUTUAL_AUTHENTICATION_FAILED* = NTSTATUS 0xC00002C3'i32
  STATUS_CORRUPT_SYSTEM_FILE* = NTSTATUS 0xC00002C4'i32
  STATUS_DATATYPE_MISALIGNMENT_ERROR* = NTSTATUS 0xC00002C5'i32
  STATUS_WMI_READ_ONLY* = NTSTATUS 0xC00002C6'i32
  STATUS_WMI_SET_FAILURE* = NTSTATUS 0xC00002C7'i32
  STATUS_COMMITMENT_MINIMUM* = NTSTATUS 0xC00002C8'i32
  STATUS_REG_NAT_CONSUMPTION* = NTSTATUS 0xC00002C9'i32
  STATUS_TRANSPORT_FULL* = NTSTATUS 0xC00002CA'i32
  STATUS_DS_SAM_INIT_FAILURE* = NTSTATUS 0xC00002CB'i32
  STATUS_ONLY_IF_CONNECTED* = NTSTATUS 0xC00002CC'i32
  STATUS_DS_SENSITIVE_GROUP_VIOLATION* = NTSTATUS 0xC00002CD'i32
  STATUS_PNP_RESTART_ENUMERATION* = NTSTATUS 0xC00002CE'i32
  STATUS_JOURNAL_ENTRY_DELETED* = NTSTATUS 0xC00002CF'i32
  STATUS_DS_CANT_MOD_PRIMARYGROUPID* = NTSTATUS 0xC00002D0'i32
  STATUS_SYSTEM_IMAGE_BAD_SIGNATURE* = NTSTATUS 0xC00002D1'i32
  STATUS_PNP_REBOOT_REQUIRED* = NTSTATUS 0xC00002D2'i32
  STATUS_POWER_STATE_INVALID* = NTSTATUS 0xC00002D3'i32
  STATUS_DS_INVALID_GROUP_TYPE* = NTSTATUS 0xC00002D4'i32
  STATUS_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN* = NTSTATUS 0xC00002D5'i32
  STATUS_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN* = NTSTATUS 0xC00002D6'i32
  STATUS_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER* = NTSTATUS 0xC00002D7'i32
  STATUS_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER* = NTSTATUS 0xC00002D8'i32
  STATUS_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER* = NTSTATUS 0xC00002D9'i32
  STATUS_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER* = NTSTATUS 0xC00002DA'i32
  STATUS_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER* = NTSTATUS 0xC00002DB'i32
  STATUS_DS_HAVE_PRIMARY_MEMBERS* = NTSTATUS 0xC00002DC'i32
  STATUS_WMI_NOT_SUPPORTED* = NTSTATUS 0xC00002DD'i32
  STATUS_INSUFFICIENT_POWER* = NTSTATUS 0xC00002DE'i32
  STATUS_SAM_NEED_BOOTKEY_PASSWORD* = NTSTATUS 0xC00002DF'i32
  STATUS_SAM_NEED_BOOTKEY_FLOPPY* = NTSTATUS 0xC00002E0'i32
  STATUS_DS_CANT_START* = NTSTATUS 0xC00002E1'i32
  STATUS_DS_INIT_FAILURE* = NTSTATUS 0xC00002E2'i32
  STATUS_SAM_INIT_FAILURE* = NTSTATUS 0xC00002E3'i32
  STATUS_DS_GC_REQUIRED* = NTSTATUS 0xC00002E4'i32
  STATUS_DS_LOCAL_MEMBER_OF_LOCAL_ONLY* = NTSTATUS 0xC00002E5'i32
  STATUS_DS_NO_FPO_IN_UNIVERSAL_GROUPS* = NTSTATUS 0xC00002E6'i32
  STATUS_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED* = NTSTATUS 0xC00002E7'i32
  STATUS_CURRENT_DOMAIN_NOT_ALLOWED* = NTSTATUS 0xC00002E9'i32
  STATUS_CANNOT_MAKE* = NTSTATUS 0xC00002EA'i32
  STATUS_SYSTEM_SHUTDOWN* = NTSTATUS 0xC00002EB'i32
  STATUS_DS_INIT_FAILURE_CONSOLE* = NTSTATUS 0xC00002EC'i32
  STATUS_DS_SAM_INIT_FAILURE_CONSOLE* = NTSTATUS 0xC00002ED'i32
  STATUS_UNFINISHED_CONTEXT_DELETED* = NTSTATUS 0xC00002EE'i32
  STATUS_NO_TGT_REPLY* = NTSTATUS 0xC00002EF'i32
  STATUS_OBJECTID_NOT_FOUND* = NTSTATUS 0xC00002F0'i32
  STATUS_NO_IP_ADDRESSES* = NTSTATUS 0xC00002F1'i32
  STATUS_WRONG_CREDENTIAL_HANDLE* = NTSTATUS 0xC00002F2'i32
  STATUS_CRYPTO_SYSTEM_INVALID* = NTSTATUS 0xC00002F3'i32
  STATUS_MAX_REFERRALS_EXCEEDED* = NTSTATUS 0xC00002F4'i32
  STATUS_MUST_BE_KDC* = NTSTATUS 0xC00002F5'i32
  STATUS_STRONG_CRYPTO_NOT_SUPPORTED* = NTSTATUS 0xC00002F6'i32
  STATUS_TOO_MANY_PRINCIPALS* = NTSTATUS 0xC00002F7'i32
  STATUS_NO_PA_DATA* = NTSTATUS 0xC00002F8'i32
  STATUS_PKINIT_NAME_MISMATCH* = NTSTATUS 0xC00002F9'i32
  STATUS_SMARTCARD_LOGON_REQUIRED* = NTSTATUS 0xC00002FA'i32
  STATUS_KDC_INVALID_REQUEST* = NTSTATUS 0xC00002FB'i32
  STATUS_KDC_UNABLE_TO_REFER* = NTSTATUS 0xC00002FC'i32
  STATUS_KDC_UNKNOWN_ETYPE* = NTSTATUS 0xC00002FD'i32
  STATUS_SHUTDOWN_IN_PROGRESS* = NTSTATUS 0xC00002FE'i32
  STATUS_SERVER_SHUTDOWN_IN_PROGRESS* = NTSTATUS 0xC00002FF'i32
  STATUS_NOT_SUPPORTED_ON_SBS* = NTSTATUS 0xC0000300'i32
  STATUS_WMI_GUID_DISCONNECTED* = NTSTATUS 0xC0000301'i32
  STATUS_WMI_ALREADY_DISABLED* = NTSTATUS 0xC0000302'i32
  STATUS_WMI_ALREADY_ENABLED* = NTSTATUS 0xC0000303'i32
  STATUS_MFT_TOO_FRAGMENTED* = NTSTATUS 0xC0000304'i32
  STATUS_COPY_PROTECTION_FAILURE* = NTSTATUS 0xC0000305'i32
  STATUS_CSS_AUTHENTICATION_FAILURE* = NTSTATUS 0xC0000306'i32
  STATUS_CSS_KEY_NOT_PRESENT* = NTSTATUS 0xC0000307'i32
  STATUS_CSS_KEY_NOT_ESTABLISHED* = NTSTATUS 0xC0000308'i32
  STATUS_CSS_SCRAMBLED_SECTOR* = NTSTATUS 0xC0000309'i32
  STATUS_CSS_REGION_MISMATCH* = NTSTATUS 0xC000030A'i32
  STATUS_CSS_RESETS_EXHAUSTED* = NTSTATUS 0xC000030B'i32
  STATUS_PKINIT_FAILURE* = NTSTATUS 0xC0000320'i32
  STATUS_SMARTCARD_SUBSYSTEM_FAILURE* = NTSTATUS 0xC0000321'i32
  STATUS_NO_KERB_KEY* = NTSTATUS 0xC0000322'i32
  STATUS_HOST_DOWN* = NTSTATUS 0xC0000350'i32
  STATUS_UNSUPPORTED_PREAUTH* = NTSTATUS 0xC0000351'i32
  STATUS_EFS_ALG_BLOB_TOO_BIG* = NTSTATUS 0xC0000352'i32
  STATUS_PORT_NOT_SET* = NTSTATUS 0xC0000353'i32
  STATUS_DEBUGGER_INACTIVE* = NTSTATUS 0xC0000354'i32
  STATUS_DS_VERSION_CHECK_FAILURE* = NTSTATUS 0xC0000355'i32
  STATUS_AUDITING_DISABLED* = NTSTATUS 0xC0000356'i32
  STATUS_PRENT4_MACHINE_ACCOUNT* = NTSTATUS 0xC0000357'i32
  STATUS_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER* = NTSTATUS 0xC0000358'i32
  STATUS_INVALID_IMAGE_WIN_32* = NTSTATUS 0xC0000359'i32
  STATUS_INVALID_IMAGE_WIN_64* = NTSTATUS 0xC000035A'i32
  STATUS_BAD_BINDINGS* = NTSTATUS 0xC000035B'i32
  STATUS_NETWORK_SESSION_EXPIRED* = NTSTATUS 0xC000035C'i32
  STATUS_APPHELP_BLOCK* = NTSTATUS 0xC000035D'i32
  STATUS_ALL_SIDS_FILTERED* = NTSTATUS 0xC000035E'i32
  STATUS_NOT_SAFE_MODE_DRIVER* = NTSTATUS 0xC000035F'i32
  STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT* = NTSTATUS 0xC0000361'i32
  STATUS_ACCESS_DISABLED_BY_POLICY_PATH* = NTSTATUS 0xC0000362'i32
  STATUS_ACCESS_DISABLED_BY_POLICY_PUBLISHER* = NTSTATUS 0xC0000363'i32
  STATUS_ACCESS_DISABLED_BY_POLICY_OTHER* = NTSTATUS 0xC0000364'i32
  STATUS_FAILED_DRIVER_ENTRY* = NTSTATUS 0xC0000365'i32
  STATUS_DEVICE_ENUMERATION_ERROR* = NTSTATUS 0xC0000366'i32
  STATUS_MOUNT_POINT_NOT_RESOLVED* = NTSTATUS 0xC0000368'i32
  STATUS_INVALID_DEVICE_OBJECT_PARAMETER* = NTSTATUS 0xC0000369'i32
  STATUS_MCA_OCCURED* = NTSTATUS 0xC000036A'i32
  STATUS_DRIVER_BLOCKED_CRITICAL* = NTSTATUS 0xC000036B'i32
  STATUS_DRIVER_BLOCKED* = NTSTATUS 0xC000036C'i32
  STATUS_DRIVER_DATABASE_ERROR* = NTSTATUS 0xC000036D'i32
  STATUS_SYSTEM_HIVE_TOO_LARGE* = NTSTATUS 0xC000036E'i32
  STATUS_INVALID_IMPORT_OF_NON_DLL* = NTSTATUS 0xC000036F'i32
  STATUS_NO_SECRETS* = NTSTATUS 0xC0000371'i32
  STATUS_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY* = NTSTATUS 0xC0000372'i32
  STATUS_FAILED_STACK_SWITCH* = NTSTATUS 0xC0000373'i32
  STATUS_HEAP_CORRUPTION* = NTSTATUS 0xC0000374'i32
  STATUS_SMARTCARD_WRONG_PIN* = NTSTATUS 0xC0000380'i32
  STATUS_SMARTCARD_CARD_BLOCKED* = NTSTATUS 0xC0000381'i32
  STATUS_SMARTCARD_CARD_NOT_AUTHENTICATED* = NTSTATUS 0xC0000382'i32
  STATUS_SMARTCARD_NO_CARD* = NTSTATUS 0xC0000383'i32
  STATUS_SMARTCARD_NO_KEY_CONTAINER* = NTSTATUS 0xC0000384'i32
  STATUS_SMARTCARD_NO_CERTIFICATE* = NTSTATUS 0xC0000385'i32
  STATUS_SMARTCARD_NO_KEYSET* = NTSTATUS 0xC0000386'i32
  STATUS_SMARTCARD_IO_ERROR* = NTSTATUS 0xC0000387'i32
  STATUS_DOWNGRADE_DETECTED* = NTSTATUS 0xC0000388'i32
  STATUS_SMARTCARD_CERT_REVOKED* = NTSTATUS 0xC0000389'i32
  STATUS_ISSUING_CA_UNTRUSTED* = NTSTATUS 0xC000038A'i32
  STATUS_REVOCATION_OFFLINE_C* = NTSTATUS 0xC000038B'i32
  STATUS_PKINIT_CLIENT_FAILURE* = NTSTATUS 0xC000038C'i32
  STATUS_SMARTCARD_CERT_EXPIRED* = NTSTATUS 0xC000038D'i32
  STATUS_DRIVER_FAILED_PRIOR_UNLOAD* = NTSTATUS 0xC000038E'i32
  STATUS_SMARTCARD_SILENT_CONTEXT* = NTSTATUS 0xC000038F'i32
  STATUS_PER_USER_TRUST_QUOTA_EXCEEDED* = NTSTATUS 0xC0000401'i32
  STATUS_ALL_USER_TRUST_QUOTA_EXCEEDED* = NTSTATUS 0xC0000402'i32
  STATUS_USER_DELETE_TRUST_QUOTA_EXCEEDED* = NTSTATUS 0xC0000403'i32
  STATUS_DS_NAME_NOT_UNIQUE* = NTSTATUS 0xC0000404'i32
  STATUS_DS_DUPLICATE_ID_FOUND* = NTSTATUS 0xC0000405'i32
  STATUS_DS_GROUP_CONVERSION_ERROR* = NTSTATUS 0xC0000406'i32
  STATUS_VOLSNAP_PREPARE_HIBERNATE* = NTSTATUS 0xC0000407'i32
  STATUS_USER2USER_REQUIRED* = NTSTATUS 0xC0000408'i32
  STATUS_STACK_BUFFER_OVERRUN* = NTSTATUS 0xC0000409'i32
  STATUS_NO_S4U_PROT_SUPPORT* = NTSTATUS 0xC000040A'i32
  STATUS_CROSSREALM_DELEGATION_FAILURE* = NTSTATUS 0xC000040B'i32
  STATUS_REVOCATION_OFFLINE_KDC* = NTSTATUS 0xC000040C'i32
  STATUS_ISSUING_CA_UNTRUSTED_KDC* = NTSTATUS 0xC000040D'i32
  STATUS_KDC_CERT_EXPIRED* = NTSTATUS 0xC000040E'i32
  STATUS_KDC_CERT_REVOKED* = NTSTATUS 0xC000040F'i32
  STATUS_PARAMETER_QUOTA_EXCEEDED* = NTSTATUS 0xC0000410'i32
  STATUS_HIBERNATION_FAILURE* = NTSTATUS 0xC0000411'i32
  STATUS_DELAY_LOAD_FAILED* = NTSTATUS 0xC0000412'i32
  STATUS_AUTHENTICATION_FIREWALL_FAILED* = NTSTATUS 0xC0000413'i32
  STATUS_VDM_DISALLOWED* = NTSTATUS 0xC0000414'i32
  STATUS_HUNG_DISPLAY_DRIVER_THREAD* = NTSTATUS 0xC0000415'i32
  STATUS_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE* = NTSTATUS 0xC0000416'i32
  STATUS_INVALID_CRUNTIME_PARAMETER* = NTSTATUS 0xC0000417'i32
  STATUS_NTLM_BLOCKED* = NTSTATUS 0xC0000418'i32
  STATUS_DS_SRC_SID_EXISTS_IN_FOREST* = NTSTATUS 0xC0000419'i32
  STATUS_DS_DOMAIN_NAME_EXISTS_IN_FOREST* = NTSTATUS 0xC000041A'i32
  STATUS_DS_FLAT_NAME_EXISTS_IN_FOREST* = NTSTATUS 0xC000041B'i32
  STATUS_INVALID_USER_PRINCIPAL_NAME* = NTSTATUS 0xC000041C'i32
  STATUS_ASSERTION_FAILURE* = NTSTATUS 0xC0000420'i32
  STATUS_VERIFIER_STOP* = NTSTATUS 0xC0000421'i32
  STATUS_CALLBACK_POP_STACK* = NTSTATUS 0xC0000423'i32
  STATUS_INCOMPATIBLE_DRIVER_BLOCKED* = NTSTATUS 0xC0000424'i32
  STATUS_HIVE_UNLOADED* = NTSTATUS 0xC0000425'i32
  STATUS_COMPRESSION_DISABLED* = NTSTATUS 0xC0000426'i32
  STATUS_FILE_SYSTEM_LIMITATION* = NTSTATUS 0xC0000427'i32
  STATUS_INVALID_IMAGE_HASH* = NTSTATUS 0xC0000428'i32
  STATUS_NOT_CAPABLE* = NTSTATUS 0xC0000429'i32
  STATUS_REQUEST_OUT_OF_SEQUENCE* = NTSTATUS 0xC000042A'i32
  STATUS_IMPLEMENTATION_LIMIT* = NTSTATUS 0xC000042B'i32
  STATUS_ELEVATION_REQUIRED* = NTSTATUS 0xC000042C'i32
  STATUS_NO_SECURITY_CONTEXT* = NTSTATUS 0xC000042D'i32
  STATUS_PKU2U_CERT_FAILURE* = NTSTATUS 0xC000042E'i32
  STATUS_BEYOND_VDL* = NTSTATUS 0xC0000432'i32
  STATUS_ENCOUNTERED_WRITE_IN_PROGRESS* = NTSTATUS 0xC0000433'i32
  STATUS_PTE_CHANGED* = NTSTATUS 0xC0000434'i32
  STATUS_PURGE_FAILED* = NTSTATUS 0xC0000435'i32
  STATUS_CRED_REQUIRES_CONFIRMATION* = NTSTATUS 0xC0000440'i32
  STATUS_CS_ENCRYPTION_INVALID_SERVER_RESPONSE* = NTSTATUS 0xC0000441'i32
  STATUS_CS_ENCRYPTION_UNSUPPORTED_SERVER* = NTSTATUS 0xC0000442'i32
  STATUS_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE* = NTSTATUS 0xC0000443'i32
  STATUS_CS_ENCRYPTION_NEW_ENCRYPTED_FILE* = NTSTATUS 0xC0000444'i32
  STATUS_CS_ENCRYPTION_FILE_NOT_CSE* = NTSTATUS 0xC0000445'i32
  STATUS_INVALID_LABEL* = NTSTATUS 0xC0000446'i32
  STATUS_DRIVER_PROCESS_TERMINATED* = NTSTATUS 0xC0000450'i32
  STATUS_AMBIGUOUS_SYSTEM_DEVICE* = NTSTATUS 0xC0000451'i32
  STATUS_SYSTEM_DEVICE_NOT_FOUND* = NTSTATUS 0xC0000452'i32
  STATUS_RESTART_BOOT_APPLICATION* = NTSTATUS 0xC0000453'i32
  STATUS_INSUFFICIENT_NVRAM_RESOURCES* = NTSTATUS 0xC0000454'i32
  STATUS_INVALID_TASK_NAME* = NTSTATUS 0xC0000500'i32
  STATUS_INVALID_TASK_INDEX* = NTSTATUS 0xC0000501'i32
  STATUS_THREAD_ALREADY_IN_TASK* = NTSTATUS 0xC0000502'i32
  STATUS_CALLBACK_BYPASS* = NTSTATUS 0xC0000503'i32
  STATUS_FAIL_FAST_EXCEPTION* = NTSTATUS 0xC0000602'i32
  STATUS_IMAGE_CERT_REVOKED* = NTSTATUS 0xC0000603'i32
  STATUS_PORT_CLOSED* = NTSTATUS 0xC0000700'i32
  STATUS_MESSAGE_LOST* = NTSTATUS 0xC0000701'i32
  STATUS_INVALID_MESSAGE* = NTSTATUS 0xC0000702'i32
  STATUS_REQUEST_CANCELED* = NTSTATUS 0xC0000703'i32
  STATUS_RECURSIVE_DISPATCH* = NTSTATUS 0xC0000704'i32
  STATUS_LPC_RECEIVE_BUFFER_EXPECTED* = NTSTATUS 0xC0000705'i32
  STATUS_LPC_INVALID_CONNECTION_USAGE* = NTSTATUS 0xC0000706'i32
  STATUS_LPC_REQUESTS_NOT_ALLOWED* = NTSTATUS 0xC0000707'i32
  STATUS_RESOURCE_IN_USE* = NTSTATUS 0xC0000708'i32
  STATUS_HARDWARE_MEMORY_ERROR* = NTSTATUS 0xC0000709'i32
  STATUS_THREADPOOL_HANDLE_EXCEPTION* = NTSTATUS 0xC000070A'i32
  STATUS_THREADPOOL_SET_EVENT_ON_COMPLETION_FAILED* = NTSTATUS 0xC000070B'i32
  STATUS_THREADPOOL_RELEASE_SEMAPHORE_ON_COMPLETION_FAILED* = NTSTATUS 0xC000070C'i32
  STATUS_THREADPOOL_RELEASE_MUTEX_ON_COMPLETION_FAILED* = NTSTATUS 0xC000070D'i32
  STATUS_THREADPOOL_FREE_LIBRARY_ON_COMPLETION_FAILED* = NTSTATUS 0xC000070E'i32
  STATUS_THREADPOOL_RELEASED_DURING_OPERATION* = NTSTATUS 0xC000070F'i32
  STATUS_CALLBACK_RETURNED_WHILE_IMPERSONATING* = NTSTATUS 0xC0000710'i32
  STATUS_APC_RETURNED_WHILE_IMPERSONATING* = NTSTATUS 0xC0000711'i32
  STATUS_PROCESS_IS_PROTECTED* = NTSTATUS 0xC0000712'i32
  STATUS_MCA_EXCEPTION* = NTSTATUS 0xC0000713'i32
  STATUS_CERTIFICATE_MAPPING_NOT_UNIQUE* = NTSTATUS 0xC0000714'i32
  STATUS_SYMLINK_CLASS_DISABLED* = NTSTATUS 0xC0000715'i32
  STATUS_INVALID_IDN_NORMALIZATION* = NTSTATUS 0xC0000716'i32
  STATUS_NO_UNICODE_TRANSLATION* = NTSTATUS 0xC0000717'i32
  STATUS_ALREADY_REGISTERED* = NTSTATUS 0xC0000718'i32
  STATUS_CONTEXT_MISMATCH* = NTSTATUS 0xC0000719'i32
  STATUS_PORT_ALREADY_HAS_COMPLETION_LIST* = NTSTATUS 0xC000071A'i32
  STATUS_CALLBACK_RETURNED_THREAD_PRIORITY* = NTSTATUS 0xC000071B'i32
  STATUS_INVALID_THREAD* = NTSTATUS 0xC000071C'i32
  STATUS_CALLBACK_RETURNED_TRANSACTION* = NTSTATUS 0xC000071D'i32
  STATUS_CALLBACK_RETURNED_LDR_LOCK* = NTSTATUS 0xC000071E'i32
  STATUS_CALLBACK_RETURNED_LANG* = NTSTATUS 0xC000071F'i32
  STATUS_CALLBACK_RETURNED_PRI_BACK* = NTSTATUS 0xC0000720'i32
  STATUS_DISK_REPAIR_DISABLED* = NTSTATUS 0xC0000800'i32
  STATUS_DS_DOMAIN_RENAME_IN_PROGRESS* = NTSTATUS 0xC0000801'i32
  STATUS_DISK_QUOTA_EXCEEDED* = NTSTATUS 0xC0000802'i32
  STATUS_CONTENT_BLOCKED* = NTSTATUS 0xC0000804'i32
  STATUS_BAD_CLUSTERS* = NTSTATUS 0xC0000805'i32
  STATUS_VOLUME_DIRTY* = NTSTATUS 0xC0000806'i32
  STATUS_FILE_CHECKED_OUT* = NTSTATUS 0xC0000901'i32
  STATUS_CHECKOUT_REQUIRED* = NTSTATUS 0xC0000902'i32
  STATUS_BAD_FILE_TYPE* = NTSTATUS 0xC0000903'i32
  STATUS_FILE_TOO_LARGE* = NTSTATUS 0xC0000904'i32
  STATUS_FORMS_AUTH_REQUIRED* = NTSTATUS 0xC0000905'i32
  STATUS_VIRUS_INFECTED* = NTSTATUS 0xC0000906'i32
  STATUS_VIRUS_DELETED* = NTSTATUS 0xC0000907'i32
  STATUS_BAD_MCFG_TABLE* = NTSTATUS 0xC0000908'i32
  STATUS_CANNOT_BREAK_OPLOCK* = NTSTATUS 0xC0000909'i32
  STATUS_WOW_ASSERTION* = NTSTATUS 0xC0009898'i32
  STATUS_INVALID_SIGNATURE* = NTSTATUS 0xC000A000'i32
  STATUS_HMAC_NOT_SUPPORTED* = NTSTATUS 0xC000A001'i32
  STATUS_IPSEC_QUEUE_OVERFLOW* = NTSTATUS 0xC000A010'i32
  STATUS_ND_QUEUE_OVERFLOW* = NTSTATUS 0xC000A011'i32
  STATUS_HOPLIMIT_EXCEEDED* = NTSTATUS 0xC000A012'i32
  STATUS_PROTOCOL_NOT_SUPPORTED* = NTSTATUS 0xC000A013'i32
  STATUS_LOST_WRITEBEHIND_DATA_NETWORK_DISCONNECTED* = NTSTATUS 0xC000A080'i32
  STATUS_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR* = NTSTATUS 0xC000A081'i32
  STATUS_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR* = NTSTATUS 0xC000A082'i32
  STATUS_XML_PARSE_ERROR* = NTSTATUS 0xC000A083'i32
  STATUS_XMLDSIG_ERROR* = NTSTATUS 0xC000A084'i32
  STATUS_WRONG_COMPARTMENT* = NTSTATUS 0xC000A085'i32
  STATUS_AUTHIP_FAILURE* = NTSTATUS 0xC000A086'i32
  STATUS_DS_OID_MAPPED_GROUP_CANT_HAVE_MEMBERS* = NTSTATUS 0xC000A087'i32
  STATUS_DS_OID_NOT_FOUND* = NTSTATUS 0xC000A088'i32
  STATUS_HASH_NOT_SUPPORTED* = NTSTATUS 0xC000A100'i32
  STATUS_HASH_NOT_PRESENT* = NTSTATUS 0xC000A101'i32
  DBG_NO_STATE_CHANGE* = NTSTATUS 0xC0010001'i32
  DBG_APP_NOT_IDLE* = NTSTATUS 0xC0010002'i32
  RPC_NT_INVALID_STRING_BINDING* = NTSTATUS 0xC0020001'i32
  RPC_NT_WRONG_KIND_OF_BINDING* = NTSTATUS 0xC0020002'i32
  RPC_NT_INVALID_BINDING* = NTSTATUS 0xC0020003'i32
  RPC_NT_PROTSEQ_NOT_SUPPORTED* = NTSTATUS 0xC0020004'i32
  RPC_NT_INVALID_RPC_PROTSEQ* = NTSTATUS 0xC0020005'i32
  RPC_NT_INVALID_STRING_UUID* = NTSTATUS 0xC0020006'i32
  RPC_NT_INVALID_ENDPOINT_FORMAT* = NTSTATUS 0xC0020007'i32
  RPC_NT_INVALID_NET_ADDR* = NTSTATUS 0xC0020008'i32
  RPC_NT_NO_ENDPOINT_FOUND* = NTSTATUS 0xC0020009'i32
  RPC_NT_INVALID_TIMEOUT* = NTSTATUS 0xC002000A'i32
  RPC_NT_OBJECT_NOT_FOUND* = NTSTATUS 0xC002000B'i32
  RPC_NT_ALREADY_REGISTERED* = NTSTATUS 0xC002000C'i32
  RPC_NT_TYPE_ALREADY_REGISTERED* = NTSTATUS 0xC002000D'i32
  RPC_NT_ALREADY_LISTENING* = NTSTATUS 0xC002000E'i32
  RPC_NT_NO_PROTSEQS_REGISTERED* = NTSTATUS 0xC002000F'i32
  RPC_NT_NOT_LISTENING* = NTSTATUS 0xC0020010'i32
  RPC_NT_UNKNOWN_MGR_TYPE* = NTSTATUS 0xC0020011'i32
  RPC_NT_UNKNOWN_IF* = NTSTATUS 0xC0020012'i32
  RPC_NT_NO_BINDINGS* = NTSTATUS 0xC0020013'i32
  RPC_NT_NO_PROTSEQS* = NTSTATUS 0xC0020014'i32
  RPC_NT_CANT_CREATE_ENDPOINT* = NTSTATUS 0xC0020015'i32
  RPC_NT_OUT_OF_RESOURCES* = NTSTATUS 0xC0020016'i32
  RPC_NT_SERVER_UNAVAILABLE* = NTSTATUS 0xC0020017'i32
  RPC_NT_SERVER_TOO_BUSY* = NTSTATUS 0xC0020018'i32
  RPC_NT_INVALID_NETWORK_OPTIONS* = NTSTATUS 0xC0020019'i32
  RPC_NT_NO_CALL_ACTIVE* = NTSTATUS 0xC002001A'i32
  RPC_NT_CALL_FAILED* = NTSTATUS 0xC002001B'i32
  RPC_NT_CALL_FAILED_DNE* = NTSTATUS 0xC002001C'i32
  RPC_NT_PROTOCOL_ERROR* = NTSTATUS 0xC002001D'i32
  RPC_NT_UNSUPPORTED_TRANS_SYN* = NTSTATUS 0xC002001F'i32
  RPC_NT_UNSUPPORTED_TYPE* = NTSTATUS 0xC0020021'i32
  RPC_NT_INVALID_TAG* = NTSTATUS 0xC0020022'i32
  RPC_NT_INVALID_BOUND* = NTSTATUS 0xC0020023'i32
  RPC_NT_NO_ENTRY_NAME* = NTSTATUS 0xC0020024'i32
  RPC_NT_INVALID_NAME_SYNTAX* = NTSTATUS 0xC0020025'i32
  RPC_NT_UNSUPPORTED_NAME_SYNTAX* = NTSTATUS 0xC0020026'i32
  RPC_NT_UUID_NO_ADDRESS* = NTSTATUS 0xC0020028'i32
  RPC_NT_DUPLICATE_ENDPOINT* = NTSTATUS 0xC0020029'i32
  RPC_NT_UNKNOWN_AUTHN_TYPE* = NTSTATUS 0xC002002A'i32
  RPC_NT_MAX_CALLS_TOO_SMALL* = NTSTATUS 0xC002002B'i32
  RPC_NT_STRING_TOO_LONG* = NTSTATUS 0xC002002C'i32
  RPC_NT_PROTSEQ_NOT_FOUND* = NTSTATUS 0xC002002D'i32
  RPC_NT_PROCNUM_OUT_OF_RANGE* = NTSTATUS 0xC002002E'i32
  RPC_NT_BINDING_HAS_NO_AUTH* = NTSTATUS 0xC002002F'i32
  RPC_NT_UNKNOWN_AUTHN_SERVICE* = NTSTATUS 0xC0020030'i32
  RPC_NT_UNKNOWN_AUTHN_LEVEL* = NTSTATUS 0xC0020031'i32
  RPC_NT_INVALID_AUTH_IDENTITY* = NTSTATUS 0xC0020032'i32
  RPC_NT_UNKNOWN_AUTHZ_SERVICE* = NTSTATUS 0xC0020033'i32
  EPT_NT_INVALID_ENTRY* = NTSTATUS 0xC0020034'i32
  EPT_NT_CANT_PERFORM_OP* = NTSTATUS 0xC0020035'i32
  EPT_NT_NOT_REGISTERED* = NTSTATUS 0xC0020036'i32
  RPC_NT_NOTHING_TO_EXPORT* = NTSTATUS 0xC0020037'i32
  RPC_NT_INCOMPLETE_NAME* = NTSTATUS 0xC0020038'i32
  RPC_NT_INVALID_VERS_OPTION* = NTSTATUS 0xC0020039'i32
  RPC_NT_NO_MORE_MEMBERS* = NTSTATUS 0xC002003A'i32
  RPC_NT_NOT_ALL_OBJS_UNEXPORTED* = NTSTATUS 0xC002003B'i32
  RPC_NT_INTERFACE_NOT_FOUND* = NTSTATUS 0xC002003C'i32
  RPC_NT_ENTRY_ALREADY_EXISTS* = NTSTATUS 0xC002003D'i32
  RPC_NT_ENTRY_NOT_FOUND* = NTSTATUS 0xC002003E'i32
  RPC_NT_NAME_SERVICE_UNAVAILABLE* = NTSTATUS 0xC002003F'i32
  RPC_NT_INVALID_NAF_ID* = NTSTATUS 0xC0020040'i32
  RPC_NT_CANNOT_SUPPORT* = NTSTATUS 0xC0020041'i32
  RPC_NT_NO_CONTEXT_AVAILABLE* = NTSTATUS 0xC0020042'i32
  RPC_NT_INTERNAL_ERROR* = NTSTATUS 0xC0020043'i32
  RPC_NT_ZERO_DIVIDE* = NTSTATUS 0xC0020044'i32
  RPC_NT_ADDRESS_ERROR* = NTSTATUS 0xC0020045'i32
  RPC_NT_FP_DIV_ZERO* = NTSTATUS 0xC0020046'i32
  RPC_NT_FP_UNDERFLOW* = NTSTATUS 0xC0020047'i32
  RPC_NT_FP_OVERFLOW* = NTSTATUS 0xC0020048'i32
  RPC_NT_CALL_IN_PROGRESS* = NTSTATUS 0xC0020049'i32
  RPC_NT_NO_MORE_BINDINGS* = NTSTATUS 0xC002004A'i32
  RPC_NT_GROUP_MEMBER_NOT_FOUND* = NTSTATUS 0xC002004B'i32
  EPT_NT_CANT_CREATE* = NTSTATUS 0xC002004C'i32
  RPC_NT_INVALID_OBJECT* = NTSTATUS 0xC002004D'i32
  RPC_NT_NO_INTERFACES* = NTSTATUS 0xC002004F'i32
  RPC_NT_CALL_CANCELLED* = NTSTATUS 0xC0020050'i32
  RPC_NT_BINDING_INCOMPLETE* = NTSTATUS 0xC0020051'i32
  RPC_NT_COMM_FAILURE* = NTSTATUS 0xC0020052'i32
  RPC_NT_UNSUPPORTED_AUTHN_LEVEL* = NTSTATUS 0xC0020053'i32
  RPC_NT_NO_PRINC_NAME* = NTSTATUS 0xC0020054'i32
  RPC_NT_NOT_RPC_ERROR* = NTSTATUS 0xC0020055'i32
  RPC_NT_SEC_PKG_ERROR* = NTSTATUS 0xC0020057'i32
  RPC_NT_NOT_CANCELLED* = NTSTATUS 0xC0020058'i32
  RPC_NT_INVALID_ASYNC_HANDLE* = NTSTATUS 0xC0020062'i32
  RPC_NT_INVALID_ASYNC_CALL* = NTSTATUS 0xC0020063'i32
  RPC_NT_PROXY_ACCESS_DENIED* = NTSTATUS 0xC0020064'i32
  RPC_NT_NO_MORE_ENTRIES* = NTSTATUS 0xC0030001'i32
  RPC_NT_SS_CHAR_TRANS_OPEN_FAIL* = NTSTATUS 0xC0030002'i32
  RPC_NT_SS_CHAR_TRANS_SHORT_FILE* = NTSTATUS 0xC0030003'i32
  RPC_NT_SS_IN_NULL_CONTEXT* = NTSTATUS 0xC0030004'i32
  RPC_NT_SS_CONTEXT_MISMATCH* = NTSTATUS 0xC0030005'i32
  RPC_NT_SS_CONTEXT_DAMAGED* = NTSTATUS 0xC0030006'i32
  RPC_NT_SS_HANDLES_MISMATCH* = NTSTATUS 0xC0030007'i32
  RPC_NT_SS_CANNOT_GET_CALL_HANDLE* = NTSTATUS 0xC0030008'i32
  RPC_NT_NULL_REF_POINTER* = NTSTATUS 0xC0030009'i32
  RPC_NT_ENUM_VALUE_OUT_OF_RANGE* = NTSTATUS 0xC003000A'i32
  RPC_NT_BYTE_COUNT_TOO_SMALL* = NTSTATUS 0xC003000B'i32
  RPC_NT_BAD_STUB_DATA* = NTSTATUS 0xC003000C'i32
  RPC_NT_INVALID_ES_ACTION* = NTSTATUS 0xC0030059'i32
  RPC_NT_WRONG_ES_VERSION* = NTSTATUS 0xC003005A'i32
  RPC_NT_WRONG_STUB_VERSION* = NTSTATUS 0xC003005B'i32
  RPC_NT_INVALID_PIPE_OBJECT* = NTSTATUS 0xC003005C'i32
  RPC_NT_INVALID_PIPE_OPERATION* = NTSTATUS 0xC003005D'i32
  RPC_NT_WRONG_PIPE_VERSION* = NTSTATUS 0xC003005E'i32
  RPC_NT_PIPE_CLOSED* = NTSTATUS 0xC003005F'i32
  RPC_NT_PIPE_DISCIPLINE_ERROR* = NTSTATUS 0xC0030060'i32
  RPC_NT_PIPE_EMPTY* = NTSTATUS 0xC0030061'i32
  STATUS_PNP_BAD_MPS_TABLE* = NTSTATUS 0xC0040035'i32
  STATUS_PNP_TRANSLATION_FAILED* = NTSTATUS 0xC0040036'i32
  STATUS_PNP_IRQ_TRANSLATION_FAILED* = NTSTATUS 0xC0040037'i32
  STATUS_PNP_INVALID_ID* = NTSTATUS 0xC0040038'i32
  STATUS_IO_REISSUE_AS_CACHED* = NTSTATUS 0xC0040039'i32
  STATUS_CTX_WINSTATION_NAME_INVALID* = NTSTATUS 0xC00A0001'i32
  STATUS_CTX_INVALID_PD* = NTSTATUS 0xC00A0002'i32
  STATUS_CTX_PD_NOT_FOUND* = NTSTATUS 0xC00A0003'i32
  STATUS_CTX_CLOSE_PENDING* = NTSTATUS 0xC00A0006'i32
  STATUS_CTX_NO_OUTBUF* = NTSTATUS 0xC00A0007'i32
  STATUS_CTX_MODEM_INF_NOT_FOUND* = NTSTATUS 0xC00A0008'i32
  STATUS_CTX_INVALID_MODEMNAME* = NTSTATUS 0xC00A0009'i32
  STATUS_CTX_RESPONSE_ERROR* = NTSTATUS 0xC00A000A'i32
  STATUS_CTX_MODEM_RESPONSE_TIMEOUT* = NTSTATUS 0xC00A000B'i32
  STATUS_CTX_MODEM_RESPONSE_NO_CARRIER* = NTSTATUS 0xC00A000C'i32
  STATUS_CTX_MODEM_RESPONSE_NO_DIALTONE* = NTSTATUS 0xC00A000D'i32
  STATUS_CTX_MODEM_RESPONSE_BUSY* = NTSTATUS 0xC00A000E'i32
  STATUS_CTX_MODEM_RESPONSE_VOICE* = NTSTATUS 0xC00A000F'i32
  STATUS_CTX_TD_ERROR* = NTSTATUS 0xC00A0010'i32
  STATUS_CTX_LICENSE_CLIENT_INVALID* = NTSTATUS 0xC00A0012'i32
  STATUS_CTX_LICENSE_NOT_AVAILABLE* = NTSTATUS 0xC00A0013'i32
  STATUS_CTX_LICENSE_EXPIRED* = NTSTATUS 0xC00A0014'i32
  STATUS_CTX_WINSTATION_NOT_FOUND* = NTSTATUS 0xC00A0015'i32
  STATUS_CTX_WINSTATION_NAME_COLLISION* = NTSTATUS 0xC00A0016'i32
  STATUS_CTX_WINSTATION_BUSY* = NTSTATUS 0xC00A0017'i32
  STATUS_CTX_BAD_VIDEO_MODE* = NTSTATUS 0xC00A0018'i32
  STATUS_CTX_GRAPHICS_INVALID* = NTSTATUS 0xC00A0022'i32
  STATUS_CTX_NOT_CONSOLE* = NTSTATUS 0xC00A0024'i32
  STATUS_CTX_CLIENT_QUERY_TIMEOUT* = NTSTATUS 0xC00A0026'i32
  STATUS_CTX_CONSOLE_DISCONNECT* = NTSTATUS 0xC00A0027'i32
  STATUS_CTX_CONSOLE_CONNECT* = NTSTATUS 0xC00A0028'i32
  STATUS_CTX_SHADOW_DENIED* = NTSTATUS 0xC00A002A'i32
  STATUS_CTX_WINSTATION_ACCESS_DENIED* = NTSTATUS 0xC00A002B'i32
  STATUS_CTX_INVALID_WD* = NTSTATUS 0xC00A002E'i32
  STATUS_CTX_WD_NOT_FOUND* = NTSTATUS 0xC00A002F'i32
  STATUS_CTX_SHADOW_INVALID* = NTSTATUS 0xC00A0030'i32
  STATUS_CTX_SHADOW_DISABLED* = NTSTATUS 0xC00A0031'i32
  STATUS_RDP_PROTOCOL_ERROR* = NTSTATUS 0xC00A0032'i32
  STATUS_CTX_CLIENT_LICENSE_NOT_SET* = NTSTATUS 0xC00A0033'i32
  STATUS_CTX_CLIENT_LICENSE_IN_USE* = NTSTATUS 0xC00A0034'i32
  STATUS_CTX_SHADOW_ENDED_BY_MODE_CHANGE* = NTSTATUS 0xC00A0035'i32
  STATUS_CTX_SHADOW_NOT_RUNNING* = NTSTATUS 0xC00A0036'i32
  STATUS_CTX_LOGON_DISABLED* = NTSTATUS 0xC00A0037'i32
  STATUS_CTX_SECURITY_LAYER_ERROR* = NTSTATUS 0xC00A0038'i32
  STATUS_TS_INCOMPATIBLE_SESSIONS* = NTSTATUS 0xC00A0039'i32
  STATUS_MUI_FILE_NOT_FOUND* = NTSTATUS 0xC00B0001'i32
  STATUS_MUI_INVALID_FILE* = NTSTATUS 0xC00B0002'i32
  STATUS_MUI_INVALID_RC_CONFIG* = NTSTATUS 0xC00B0003'i32
  STATUS_MUI_INVALID_LOCALE_NAME* = NTSTATUS 0xC00B0004'i32
  STATUS_MUI_INVALID_ULTIMATEFALLBACK_NAME* = NTSTATUS 0xC00B0005'i32
  STATUS_MUI_FILE_NOT_LOADED* = NTSTATUS 0xC00B0006'i32
  STATUS_RESOURCE_ENUM_USER_STOP* = NTSTATUS 0xC00B0007'i32
  STATUS_CLUSTER_INVALID_NODE* = NTSTATUS 0xC0130001'i32
  STATUS_CLUSTER_NODE_EXISTS* = NTSTATUS 0xC0130002'i32
  STATUS_CLUSTER_JOIN_IN_PROGRESS* = NTSTATUS 0xC0130003'i32
  STATUS_CLUSTER_NODE_NOT_FOUND* = NTSTATUS 0xC0130004'i32
  STATUS_CLUSTER_LOCAL_NODE_NOT_FOUND* = NTSTATUS 0xC0130005'i32
  STATUS_CLUSTER_NETWORK_EXISTS* = NTSTATUS 0xC0130006'i32
  STATUS_CLUSTER_NETWORK_NOT_FOUND* = NTSTATUS 0xC0130007'i32
  STATUS_CLUSTER_NETINTERFACE_EXISTS* = NTSTATUS 0xC0130008'i32
  STATUS_CLUSTER_NETINTERFACE_NOT_FOUND* = NTSTATUS 0xC0130009'i32
  STATUS_CLUSTER_INVALID_REQUEST* = NTSTATUS 0xC013000A'i32
  STATUS_CLUSTER_INVALID_NETWORK_PROVIDER* = NTSTATUS 0xC013000B'i32
  STATUS_CLUSTER_NODE_DOWN* = NTSTATUS 0xC013000C'i32
  STATUS_CLUSTER_NODE_UNREACHABLE* = NTSTATUS 0xC013000D'i32
  STATUS_CLUSTER_NODE_NOT_MEMBER* = NTSTATUS 0xC013000E'i32
  STATUS_CLUSTER_JOIN_NOT_IN_PROGRESS* = NTSTATUS 0xC013000F'i32
  STATUS_CLUSTER_INVALID_NETWORK* = NTSTATUS 0xC0130010'i32
  STATUS_CLUSTER_NO_NET_ADAPTERS* = NTSTATUS 0xC0130011'i32
  STATUS_CLUSTER_NODE_UP* = NTSTATUS 0xC0130012'i32
  STATUS_CLUSTER_NODE_PAUSED* = NTSTATUS 0xC0130013'i32
  STATUS_CLUSTER_NODE_NOT_PAUSED* = NTSTATUS 0xC0130014'i32
  STATUS_CLUSTER_NO_SECURITY_CONTEXT* = NTSTATUS 0xC0130015'i32
  STATUS_CLUSTER_NETWORK_NOT_INTERNAL* = NTSTATUS 0xC0130016'i32
  STATUS_CLUSTER_POISONED* = NTSTATUS 0xC0130017'i32
  STATUS_ACPI_INVALID_OPCODE* = NTSTATUS 0xC0140001'i32
  STATUS_ACPI_STACK_OVERFLOW* = NTSTATUS 0xC0140002'i32
  STATUS_ACPI_ASSERT_FAILED* = NTSTATUS 0xC0140003'i32
  STATUS_ACPI_INVALID_INDEX* = NTSTATUS 0xC0140004'i32
  STATUS_ACPI_INVALID_ARGUMENT* = NTSTATUS 0xC0140005'i32
  STATUS_ACPI_FATAL* = NTSTATUS 0xC0140006'i32
  STATUS_ACPI_INVALID_SUPERNAME* = NTSTATUS 0xC0140007'i32
  STATUS_ACPI_INVALID_ARGTYPE* = NTSTATUS 0xC0140008'i32
  STATUS_ACPI_INVALID_OBJTYPE* = NTSTATUS 0xC0140009'i32
  STATUS_ACPI_INVALID_TARGETTYPE* = NTSTATUS 0xC014000A'i32
  STATUS_ACPI_INCORRECT_ARGUMENT_COUNT* = NTSTATUS 0xC014000B'i32
  STATUS_ACPI_ADDRESS_NOT_MAPPED* = NTSTATUS 0xC014000C'i32
  STATUS_ACPI_INVALID_EVENTTYPE* = NTSTATUS 0xC014000D'i32
  STATUS_ACPI_HANDLER_COLLISION* = NTSTATUS 0xC014000E'i32
  STATUS_ACPI_INVALID_DATA* = NTSTATUS 0xC014000F'i32
  STATUS_ACPI_INVALID_REGION* = NTSTATUS 0xC0140010'i32
  STATUS_ACPI_INVALID_ACCESS_SIZE* = NTSTATUS 0xC0140011'i32
  STATUS_ACPI_ACQUIRE_GLOBAL_LOCK* = NTSTATUS 0xC0140012'i32
  STATUS_ACPI_ALREADY_INITIALIZED* = NTSTATUS 0xC0140013'i32
  STATUS_ACPI_NOT_INITIALIZED* = NTSTATUS 0xC0140014'i32
  STATUS_ACPI_INVALID_MUTEX_LEVEL* = NTSTATUS 0xC0140015'i32
  STATUS_ACPI_MUTEX_NOT_OWNED* = NTSTATUS 0xC0140016'i32
  STATUS_ACPI_MUTEX_NOT_OWNER* = NTSTATUS 0xC0140017'i32
  STATUS_ACPI_RS_ACCESS* = NTSTATUS 0xC0140018'i32
  STATUS_ACPI_INVALID_TABLE* = NTSTATUS 0xC0140019'i32
  STATUS_ACPI_REG_HANDLER_FAILED* = NTSTATUS 0xC0140020'i32
  STATUS_ACPI_POWER_REQUEST_FAILED* = NTSTATUS 0xC0140021'i32
  STATUS_SXS_SECTION_NOT_FOUND* = NTSTATUS 0xC0150001'i32
  STATUS_SXS_CANT_GEN_ACTCTX* = NTSTATUS 0xC0150002'i32
  STATUS_SXS_INVALID_ACTCTXDATA_FORMAT* = NTSTATUS 0xC0150003'i32
  STATUS_SXS_ASSEMBLY_NOT_FOUND* = NTSTATUS 0xC0150004'i32
  STATUS_SXS_MANIFEST_FORMAT_ERROR* = NTSTATUS 0xC0150005'i32
  STATUS_SXS_MANIFEST_PARSE_ERROR* = NTSTATUS 0xC0150006'i32
  STATUS_SXS_ACTIVATION_CONTEXT_DISABLED* = NTSTATUS 0xC0150007'i32
  STATUS_SXS_KEY_NOT_FOUND* = NTSTATUS 0xC0150008'i32
  STATUS_SXS_VERSION_CONFLICT* = NTSTATUS 0xC0150009'i32
  STATUS_SXS_WRONG_SECTION_TYPE* = NTSTATUS 0xC015000A'i32
  STATUS_SXS_THREAD_QUERIES_DISABLED* = NTSTATUS 0xC015000B'i32
  STATUS_SXS_ASSEMBLY_MISSING* = NTSTATUS 0xC015000C'i32
  STATUS_SXS_PROCESS_DEFAULT_ALREADY_SET* = NTSTATUS 0xC015000E'i32
  STATUS_SXS_EARLY_DEACTIVATION* = NTSTATUS 0xC015000F'i32
  STATUS_SXS_INVALID_DEACTIVATION* = NTSTATUS 0xC0150010'i32
  STATUS_SXS_MULTIPLE_DEACTIVATION* = NTSTATUS 0xC0150011'i32
  STATUS_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY* = NTSTATUS 0xC0150012'i32
  STATUS_SXS_PROCESS_TERMINATION_REQUESTED* = NTSTATUS 0xC0150013'i32
  STATUS_SXS_CORRUPT_ACTIVATION_STACK* = NTSTATUS 0xC0150014'i32
  STATUS_SXS_CORRUPTION* = NTSTATUS 0xC0150015'i32
  STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE* = NTSTATUS 0xC0150016'i32
  STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME* = NTSTATUS 0xC0150017'i32
  STATUS_SXS_IDENTITY_DUPLICATE_ATTRIBUTE* = NTSTATUS 0xC0150018'i32
  STATUS_SXS_IDENTITY_PARSE_ERROR* = NTSTATUS 0xC0150019'i32
  STATUS_SXS_COMPONENT_STORE_CORRUPT* = NTSTATUS 0xC015001A'i32
  STATUS_SXS_FILE_HASH_MISMATCH* = NTSTATUS 0xC015001B'i32
  STATUS_SXS_MANIFEST_IDENTITY_SAME_BUT_CONTENTS_DIFFERENT* = NTSTATUS 0xC015001C'i32
  STATUS_SXS_IDENTITIES_DIFFERENT* = NTSTATUS 0xC015001D'i32
  STATUS_SXS_ASSEMBLY_IS_NOT_A_DEPLOYMENT* = NTSTATUS 0xC015001E'i32
  STATUS_SXS_FILE_NOT_PART_OF_ASSEMBLY* = NTSTATUS 0xC015001F'i32
  STATUS_ADVANCED_INSTALLER_FAILED* = NTSTATUS 0xC0150020'i32
  STATUS_XML_ENCODING_MISMATCH* = NTSTATUS 0xC0150021'i32
  STATUS_SXS_MANIFEST_TOO_BIG* = NTSTATUS 0xC0150022'i32
  STATUS_SXS_SETTING_NOT_REGISTERED* = NTSTATUS 0xC0150023'i32
  STATUS_SXS_TRANSACTION_CLOSURE_INCOMPLETE* = NTSTATUS 0xC0150024'i32
  STATUS_SMI_PRIMITIVE_INSTALLER_FAILED* = NTSTATUS 0xC0150025'i32
  STATUS_GENERIC_COMMAND_FAILED* = NTSTATUS 0xC0150026'i32
  STATUS_SXS_FILE_HASH_MISSING* = NTSTATUS 0xC0150027'i32
  STATUS_TRANSACTIONAL_CONFLICT* = NTSTATUS 0xC0190001'i32
  STATUS_INVALID_TRANSACTION* = NTSTATUS 0xC0190002'i32
  STATUS_TRANSACTION_NOT_ACTIVE* = NTSTATUS 0xC0190003'i32
  STATUS_TM_INITIALIZATION_FAILED* = NTSTATUS 0xC0190004'i32
  STATUS_RM_NOT_ACTIVE* = NTSTATUS 0xC0190005'i32
  STATUS_RM_METADATA_CORRUPT* = NTSTATUS 0xC0190006'i32
  STATUS_TRANSACTION_NOT_JOINED* = NTSTATUS 0xC0190007'i32
  STATUS_DIRECTORY_NOT_RM* = NTSTATUS 0xC0190008'i32
  STATUS_TRANSACTIONS_UNSUPPORTED_REMOTE* = NTSTATUS 0xC019000A'i32
  STATUS_LOG_RESIZE_INVALID_SIZE* = NTSTATUS 0xC019000B'i32
  STATUS_REMOTE_FILE_VERSION_MISMATCH* = NTSTATUS 0xC019000C'i32
  STATUS_CRM_PROTOCOL_ALREADY_EXISTS* = NTSTATUS 0xC019000F'i32
  STATUS_TRANSACTION_PROPAGATION_FAILED* = NTSTATUS 0xC0190010'i32
  STATUS_CRM_PROTOCOL_NOT_FOUND* = NTSTATUS 0xC0190011'i32
  STATUS_TRANSACTION_SUPERIOR_EXISTS* = NTSTATUS 0xC0190012'i32
  STATUS_TRANSACTION_REQUEST_NOT_VALID* = NTSTATUS 0xC0190013'i32
  STATUS_TRANSACTION_NOT_REQUESTED* = NTSTATUS 0xC0190014'i32
  STATUS_TRANSACTION_ALREADY_ABORTED* = NTSTATUS 0xC0190015'i32
  STATUS_TRANSACTION_ALREADY_COMMITTED* = NTSTATUS 0xC0190016'i32
  STATUS_TRANSACTION_INVALID_MARSHALL_BUFFER* = NTSTATUS 0xC0190017'i32
  STATUS_CURRENT_TRANSACTION_NOT_VALID* = NTSTATUS 0xC0190018'i32
  STATUS_LOG_GROWTH_FAILED* = NTSTATUS 0xC0190019'i32
  STATUS_OBJECT_NO_LONGER_EXISTS* = NTSTATUS 0xC0190021'i32
  STATUS_STREAM_MINIVERSION_NOT_FOUND* = NTSTATUS 0xC0190022'i32
  STATUS_STREAM_MINIVERSION_NOT_VALID* = NTSTATUS 0xC0190023'i32
  STATUS_MINIVERSION_INACCESSIBLE_FROM_SPECIFIED_TRANSACTION* = NTSTATUS 0xC0190024'i32
  STATUS_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT* = NTSTATUS 0xC0190025'i32
  STATUS_CANT_CREATE_MORE_STREAM_MINIVERSIONS* = NTSTATUS 0xC0190026'i32
  STATUS_HANDLE_NO_LONGER_VALID* = NTSTATUS 0xC0190028'i32
  STATUS_LOG_CORRUPTION_DETECTED* = NTSTATUS 0xC0190030'i32
  STATUS_RM_DISCONNECTED* = NTSTATUS 0xC0190032'i32
  STATUS_ENLISTMENT_NOT_SUPERIOR* = NTSTATUS 0xC0190033'i32
  STATUS_FILE_IDENTITY_NOT_PERSISTENT* = NTSTATUS 0xC0190036'i32
  STATUS_CANT_BREAK_TRANSACTIONAL_DEPENDENCY* = NTSTATUS 0xC0190037'i32
  STATUS_CANT_CROSS_RM_BOUNDARY* = NTSTATUS 0xC0190038'i32
  STATUS_TXF_DIR_NOT_EMPTY* = NTSTATUS 0xC0190039'i32
  STATUS_INDOUBT_TRANSACTIONS_EXIST* = NTSTATUS 0xC019003A'i32
  STATUS_TM_VOLATILE* = NTSTATUS 0xC019003B'i32
  STATUS_ROLLBACK_TIMER_EXPIRED* = NTSTATUS 0xC019003C'i32
  STATUS_TXF_ATTRIBUTE_CORRUPT* = NTSTATUS 0xC019003D'i32
  STATUS_EFS_NOT_ALLOWED_IN_TRANSACTION* = NTSTATUS 0xC019003E'i32
  STATUS_TRANSACTIONAL_OPEN_NOT_ALLOWED* = NTSTATUS 0xC019003F'i32
  STATUS_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE* = NTSTATUS 0xC0190040'i32
  STATUS_TRANSACTION_REQUIRED_PROMOTION* = NTSTATUS 0xC0190043'i32
  STATUS_CANNOT_EXECUTE_FILE_IN_TRANSACTION* = NTSTATUS 0xC0190044'i32
  STATUS_TRANSACTIONS_NOT_FROZEN* = NTSTATUS 0xC0190045'i32
  STATUS_TRANSACTION_FREEZE_IN_PROGRESS* = NTSTATUS 0xC0190046'i32
  STATUS_NOT_SNAPSHOT_VOLUME* = NTSTATUS 0xC0190047'i32
  STATUS_NO_SAVEPOINT_WITH_OPEN_FILES* = NTSTATUS 0xC0190048'i32
  STATUS_SPARSE_NOT_ALLOWED_IN_TRANSACTION* = NTSTATUS 0xC0190049'i32
  STATUS_TM_IDENTITY_MISMATCH* = NTSTATUS 0xC019004A'i32
  STATUS_FLOATED_SECTION* = NTSTATUS 0xC019004B'i32
  STATUS_CANNOT_ACCEPT_TRANSACTED_WORK* = NTSTATUS 0xC019004C'i32
  STATUS_CANNOT_ABORT_TRANSACTIONS* = NTSTATUS 0xC019004D'i32
  STATUS_TRANSACTION_NOT_FOUND* = NTSTATUS 0xC019004E'i32
  STATUS_RESOURCEMANAGER_NOT_FOUND* = NTSTATUS 0xC019004F'i32
  STATUS_ENLISTMENT_NOT_FOUND* = NTSTATUS 0xC0190050'i32
  STATUS_TRANSACTIONMANAGER_NOT_FOUND* = NTSTATUS 0xC0190051'i32
  STATUS_TRANSACTIONMANAGER_NOT_ONLINE* = NTSTATUS 0xC0190052'i32
  STATUS_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION* = NTSTATUS 0xC0190053'i32
  STATUS_TRANSACTION_NOT_ROOT* = NTSTATUS 0xC0190054'i32
  STATUS_TRANSACTION_OBJECT_EXPIRED* = NTSTATUS 0xC0190055'i32
  STATUS_COMPRESSION_NOT_ALLOWED_IN_TRANSACTION* = NTSTATUS 0xC0190056'i32
  STATUS_TRANSACTION_RESPONSE_NOT_ENLISTED* = NTSTATUS 0xC0190057'i32
  STATUS_TRANSACTION_RECORD_TOO_LONG* = NTSTATUS 0xC0190058'i32
  STATUS_NO_LINK_TRACKING_IN_TRANSACTION* = NTSTATUS 0xC0190059'i32
  STATUS_OPERATION_NOT_SUPPORTED_IN_TRANSACTION* = NTSTATUS 0xC019005A'i32
  STATUS_TRANSACTION_INTEGRITY_VIOLATED* = NTSTATUS 0xC019005B'i32
  STATUS_EXPIRED_HANDLE* = NTSTATUS 0xC0190060'i32
  STATUS_TRANSACTION_NOT_ENLISTED* = NTSTATUS 0xC0190061'i32
  STATUS_LOG_SECTOR_INVALID* = NTSTATUS 0xC01A0001'i32
  STATUS_LOG_SECTOR_PARITY_INVALID* = NTSTATUS 0xC01A0002'i32
  STATUS_LOG_SECTOR_REMAPPED* = NTSTATUS 0xC01A0003'i32
  STATUS_LOG_BLOCK_INCOMPLETE* = NTSTATUS 0xC01A0004'i32
  STATUS_LOG_INVALID_RANGE* = NTSTATUS 0xC01A0005'i32
  STATUS_LOG_BLOCKS_EXHAUSTED* = NTSTATUS 0xC01A0006'i32
  STATUS_LOG_READ_CONTEXT_INVALID* = NTSTATUS 0xC01A0007'i32
  STATUS_LOG_RESTART_INVALID* = NTSTATUS 0xC01A0008'i32
  STATUS_LOG_BLOCK_VERSION* = NTSTATUS 0xC01A0009'i32
  STATUS_LOG_BLOCK_INVALID* = NTSTATUS 0xC01A000A'i32
  STATUS_LOG_READ_MODE_INVALID* = NTSTATUS 0xC01A000B'i32
  STATUS_LOG_METADATA_CORRUPT* = NTSTATUS 0xC01A000D'i32
  STATUS_LOG_METADATA_INVALID* = NTSTATUS 0xC01A000E'i32
  STATUS_LOG_METADATA_INCONSISTENT* = NTSTATUS 0xC01A000F'i32
  STATUS_LOG_RESERVATION_INVALID* = NTSTATUS 0xC01A0010'i32
  STATUS_LOG_CANT_DELETE* = NTSTATUS 0xC01A0011'i32
  STATUS_LOG_CONTAINER_LIMIT_EXCEEDED* = NTSTATUS 0xC01A0012'i32
  STATUS_LOG_START_OF_LOG* = NTSTATUS 0xC01A0013'i32
  STATUS_LOG_POLICY_ALREADY_INSTALLED* = NTSTATUS 0xC01A0014'i32
  STATUS_LOG_POLICY_NOT_INSTALLED* = NTSTATUS 0xC01A0015'i32
  STATUS_LOG_POLICY_INVALID* = NTSTATUS 0xC01A0016'i32
  STATUS_LOG_POLICY_CONFLICT* = NTSTATUS 0xC01A0017'i32
  STATUS_LOG_PINNED_ARCHIVE_TAIL* = NTSTATUS 0xC01A0018'i32
  STATUS_LOG_RECORD_NONEXISTENT* = NTSTATUS 0xC01A0019'i32
  STATUS_LOG_RECORDS_RESERVED_INVALID* = NTSTATUS 0xC01A001A'i32
  STATUS_LOG_SPACE_RESERVED_INVALID* = NTSTATUS 0xC01A001B'i32
  STATUS_LOG_TAIL_INVALID* = NTSTATUS 0xC01A001C'i32
  STATUS_LOG_FULL* = NTSTATUS 0xC01A001D'i32
  STATUS_LOG_MULTIPLEXED* = NTSTATUS 0xC01A001E'i32
  STATUS_LOG_DEDICATED* = NTSTATUS 0xC01A001F'i32
  STATUS_LOG_ARCHIVE_NOT_IN_PROGRESS* = NTSTATUS 0xC01A0020'i32
  STATUS_LOG_ARCHIVE_IN_PROGRESS* = NTSTATUS 0xC01A0021'i32
  STATUS_LOG_EPHEMERAL* = NTSTATUS 0xC01A0022'i32
  STATUS_LOG_NOT_ENOUGH_CONTAINERS* = NTSTATUS 0xC01A0023'i32
  STATUS_LOG_CLIENT_ALREADY_REGISTERED* = NTSTATUS 0xC01A0024'i32
  STATUS_LOG_CLIENT_NOT_REGISTERED* = NTSTATUS 0xC01A0025'i32
  STATUS_LOG_FULL_HANDLER_IN_PROGRESS* = NTSTATUS 0xC01A0026'i32
  STATUS_LOG_CONTAINER_READ_FAILED* = NTSTATUS 0xC01A0027'i32
  STATUS_LOG_CONTAINER_WRITE_FAILED* = NTSTATUS 0xC01A0028'i32
  STATUS_LOG_CONTAINER_OPEN_FAILED* = NTSTATUS 0xC01A0029'i32
  STATUS_LOG_CONTAINER_STATE_INVALID* = NTSTATUS 0xC01A002A'i32
  STATUS_LOG_STATE_INVALID* = NTSTATUS 0xC01A002B'i32
  STATUS_LOG_PINNED* = NTSTATUS 0xC01A002C'i32
  STATUS_LOG_METADATA_FLUSH_FAILED* = NTSTATUS 0xC01A002D'i32
  STATUS_LOG_INCONSISTENT_SECURITY* = NTSTATUS 0xC01A002E'i32
  STATUS_LOG_APPENDED_FLUSH_FAILED* = NTSTATUS 0xC01A002F'i32
  STATUS_LOG_PINNED_RESERVATION* = NTSTATUS 0xC01A0030'i32
  STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD* = NTSTATUS 0xC01B00EA'i32
  STATUS_FLT_NO_HANDLER_DEFINED* = NTSTATUS 0xC01C0001'i32
  STATUS_FLT_CONTEXT_ALREADY_DEFINED* = NTSTATUS 0xC01C0002'i32
  STATUS_FLT_INVALID_ASYNCHRONOUS_REQUEST* = NTSTATUS 0xC01C0003'i32
  STATUS_FLT_DISALLOW_FAST_IO* = NTSTATUS 0xC01C0004'i32
  STATUS_FLT_INVALID_NAME_REQUEST* = NTSTATUS 0xC01C0005'i32
  STATUS_FLT_NOT_SAFE_TO_POST_OPERATION* = NTSTATUS 0xC01C0006'i32
  STATUS_FLT_NOT_INITIALIZED* = NTSTATUS 0xC01C0007'i32
  STATUS_FLT_FILTER_NOT_READY* = NTSTATUS 0xC01C0008'i32
  STATUS_FLT_POST_OPERATION_CLEANUP* = NTSTATUS 0xC01C0009'i32
  STATUS_FLT_INTERNAL_ERROR* = NTSTATUS 0xC01C000A'i32
  STATUS_FLT_DELETING_OBJECT* = NTSTATUS 0xC01C000B'i32
  STATUS_FLT_MUST_BE_NONPAGED_POOL* = NTSTATUS 0xC01C000C'i32
  STATUS_FLT_DUPLICATE_ENTRY* = NTSTATUS 0xC01C000D'i32
  STATUS_FLT_CBDQ_DISABLED* = NTSTATUS 0xC01C000E'i32
  STATUS_FLT_DO_NOT_ATTACH* = NTSTATUS 0xC01C000F'i32
  STATUS_FLT_DO_NOT_DETACH* = NTSTATUS 0xC01C0010'i32
  STATUS_FLT_INSTANCE_ALTITUDE_COLLISION* = NTSTATUS 0xC01C0011'i32
  STATUS_FLT_INSTANCE_NAME_COLLISION* = NTSTATUS 0xC01C0012'i32
  STATUS_FLT_FILTER_NOT_FOUND* = NTSTATUS 0xC01C0013'i32
  STATUS_FLT_VOLUME_NOT_FOUND* = NTSTATUS 0xC01C0014'i32
  STATUS_FLT_INSTANCE_NOT_FOUND* = NTSTATUS 0xC01C0015'i32
  STATUS_FLT_CONTEXT_ALLOCATION_NOT_FOUND* = NTSTATUS 0xC01C0016'i32
  STATUS_FLT_INVALID_CONTEXT_REGISTRATION* = NTSTATUS 0xC01C0017'i32
  STATUS_FLT_NAME_CACHE_MISS* = NTSTATUS 0xC01C0018'i32
  STATUS_FLT_NO_DEVICE_OBJECT* = NTSTATUS 0xC01C0019'i32
  STATUS_FLT_VOLUME_ALREADY_MOUNTED* = NTSTATUS 0xC01C001A'i32
  STATUS_FLT_ALREADY_ENLISTED* = NTSTATUS 0xC01C001B'i32
  STATUS_FLT_CONTEXT_ALREADY_LINKED* = NTSTATUS 0xC01C001C'i32
  STATUS_FLT_NO_WAITER_FOR_REPLY* = NTSTATUS 0xC01C0020'i32
  STATUS_MONITOR_NO_DESCRIPTOR* = NTSTATUS 0xC01D0001'i32
  STATUS_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT* = NTSTATUS 0xC01D0002'i32
  STATUS_MONITOR_INVALID_DESCRIPTOR_CHECKSUM* = NTSTATUS 0xC01D0003'i32
  STATUS_MONITOR_INVALID_STANDARD_TIMING_BLOCK* = NTSTATUS 0xC01D0004'i32
  STATUS_MONITOR_WMI_DATABLOCK_REGISTRATION_FAILED* = NTSTATUS 0xC01D0005'i32
  STATUS_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK* = NTSTATUS 0xC01D0006'i32
  STATUS_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK* = NTSTATUS 0xC01D0007'i32
  STATUS_MONITOR_NO_MORE_DESCRIPTOR_DATA* = NTSTATUS 0xC01D0008'i32
  STATUS_MONITOR_INVALID_DETAILED_TIMING_BLOCK* = NTSTATUS 0xC01D0009'i32
  STATUS_MONITOR_INVALID_MANUFACTURE_DATE* = NTSTATUS 0xC01D000A'i32
  STATUS_GRAPHICS_NOT_EXCLUSIVE_MODE_OWNER* = NTSTATUS 0xC01E0000'i32
  STATUS_GRAPHICS_INSUFFICIENT_DMA_BUFFER* = NTSTATUS 0xC01E0001'i32
  STATUS_GRAPHICS_INVALID_DISPLAY_ADAPTER* = NTSTATUS 0xC01E0002'i32
  STATUS_GRAPHICS_ADAPTER_WAS_RESET* = NTSTATUS 0xC01E0003'i32
  STATUS_GRAPHICS_INVALID_DRIVER_MODEL* = NTSTATUS 0xC01E0004'i32
  STATUS_GRAPHICS_PRESENT_MODE_CHANGED* = NTSTATUS 0xC01E0005'i32
  STATUS_GRAPHICS_PRESENT_OCCLUDED* = NTSTATUS 0xC01E0006'i32
  STATUS_GRAPHICS_PRESENT_DENIED* = NTSTATUS 0xC01E0007'i32
  STATUS_GRAPHICS_CANNOTCOLORCONVERT* = NTSTATUS 0xC01E0008'i32
  STATUS_GRAPHICS_PRESENT_REDIRECTION_DISABLED* = NTSTATUS 0xC01E000B'i32
  STATUS_GRAPHICS_PRESENT_UNOCCLUDED* = NTSTATUS 0xC01E000C'i32
  STATUS_GRAPHICS_NO_VIDEO_MEMORY* = NTSTATUS 0xC01E0100'i32
  STATUS_GRAPHICS_CANT_LOCK_MEMORY* = NTSTATUS 0xC01E0101'i32
  STATUS_GRAPHICS_ALLOCATION_BUSY* = NTSTATUS 0xC01E0102'i32
  STATUS_GRAPHICS_TOO_MANY_REFERENCES* = NTSTATUS 0xC01E0103'i32
  STATUS_GRAPHICS_TRY_AGAIN_LATER* = NTSTATUS 0xC01E0104'i32
  STATUS_GRAPHICS_TRY_AGAIN_NOW* = NTSTATUS 0xC01E0105'i32
  STATUS_GRAPHICS_ALLOCATION_INVALID* = NTSTATUS 0xC01E0106'i32
  STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE* = NTSTATUS 0xC01E0107'i32
  STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED* = NTSTATUS 0xC01E0108'i32
  STATUS_GRAPHICS_CANT_EVICT_PINNED_ALLOCATION* = NTSTATUS 0xC01E0109'i32
  STATUS_GRAPHICS_INVALID_ALLOCATION_USAGE* = NTSTATUS 0xC01E0110'i32
  STATUS_GRAPHICS_CANT_RENDER_LOCKED_ALLOCATION* = NTSTATUS 0xC01E0111'i32
  STATUS_GRAPHICS_ALLOCATION_CLOSED* = NTSTATUS 0xC01E0112'i32
  STATUS_GRAPHICS_INVALID_ALLOCATION_INSTANCE* = NTSTATUS 0xC01E0113'i32
  STATUS_GRAPHICS_INVALID_ALLOCATION_HANDLE* = NTSTATUS 0xC01E0114'i32
  STATUS_GRAPHICS_WRONG_ALLOCATION_DEVICE* = NTSTATUS 0xC01E0115'i32
  STATUS_GRAPHICS_ALLOCATION_CONTENT_LOST* = NTSTATUS 0xC01E0116'i32
  STATUS_GRAPHICS_GPU_EXCEPTION_ON_DEVICE* = NTSTATUS 0xC01E0200'i32
  STATUS_GRAPHICS_INVALID_VIDPN_TOPOLOGY* = NTSTATUS 0xC01E0300'i32
  STATUS_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED* = NTSTATUS 0xC01E0301'i32
  STATUS_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED* = NTSTATUS 0xC01E0302'i32
  STATUS_GRAPHICS_INVALID_VIDPN* = NTSTATUS 0xC01E0303'i32
  STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE* = NTSTATUS 0xC01E0304'i32
  STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET* = NTSTATUS 0xC01E0305'i32
  STATUS_GRAPHICS_VIDPN_MODALITY_NOT_SUPPORTED* = NTSTATUS 0xC01E0306'i32
  STATUS_GRAPHICS_INVALID_VIDPN_SOURCEMODESET* = NTSTATUS 0xC01E0308'i32
  STATUS_GRAPHICS_INVALID_VIDPN_TARGETMODESET* = NTSTATUS 0xC01E0309'i32
  STATUS_GRAPHICS_INVALID_FREQUENCY* = NTSTATUS 0xC01E030A'i32
  STATUS_GRAPHICS_INVALID_ACTIVE_REGION* = NTSTATUS 0xC01E030B'i32
  STATUS_GRAPHICS_INVALID_TOTAL_REGION* = NTSTATUS 0xC01E030C'i32
  STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE* = NTSTATUS 0xC01E0310'i32
  STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE* = NTSTATUS 0xC01E0311'i32
  STATUS_GRAPHICS_PINNED_MODE_MUST_REMAIN_IN_SET* = NTSTATUS 0xC01E0312'i32
  STATUS_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY* = NTSTATUS 0xC01E0313'i32
  STATUS_GRAPHICS_MODE_ALREADY_IN_MODESET* = NTSTATUS 0xC01E0314'i32
  STATUS_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET* = NTSTATUS 0xC01E0315'i32
  STATUS_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET* = NTSTATUS 0xC01E0316'i32
  STATUS_GRAPHICS_SOURCE_ALREADY_IN_SET* = NTSTATUS 0xC01E0317'i32
  STATUS_GRAPHICS_TARGET_ALREADY_IN_SET* = NTSTATUS 0xC01E0318'i32
  STATUS_GRAPHICS_INVALID_VIDPN_PRESENT_PATH* = NTSTATUS 0xC01E0319'i32
  STATUS_GRAPHICS_NO_RECOMMENDED_VIDPN_TOPOLOGY* = NTSTATUS 0xC01E031A'i32
  STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET* = NTSTATUS 0xC01E031B'i32
  STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE* = NTSTATUS 0xC01E031C'i32
  STATUS_GRAPHICS_FREQUENCYRANGE_NOT_IN_SET* = NTSTATUS 0xC01E031D'i32
  STATUS_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET* = NTSTATUS 0xC01E031F'i32
  STATUS_GRAPHICS_STALE_MODESET* = NTSTATUS 0xC01E0320'i32
  STATUS_GRAPHICS_INVALID_MONITOR_SOURCEMODESET* = NTSTATUS 0xC01E0321'i32
  STATUS_GRAPHICS_INVALID_MONITOR_SOURCE_MODE* = NTSTATUS 0xC01E0322'i32
  STATUS_GRAPHICS_NO_RECOMMENDED_FUNCTIONAL_VIDPN* = NTSTATUS 0xC01E0323'i32
  STATUS_GRAPHICS_MODE_ID_MUST_BE_UNIQUE* = NTSTATUS 0xC01E0324'i32
  STATUS_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION* = NTSTATUS 0xC01E0325'i32
  STATUS_GRAPHICS_VIDEO_PRESENT_TARGETS_LESS_THAN_SOURCES* = NTSTATUS 0xC01E0326'i32
  STATUS_GRAPHICS_PATH_NOT_IN_TOPOLOGY* = NTSTATUS 0xC01E0327'i32
  STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE* = NTSTATUS 0xC01E0328'i32
  STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET* = NTSTATUS 0xC01E0329'i32
  STATUS_GRAPHICS_INVALID_MONITORDESCRIPTORSET* = NTSTATUS 0xC01E032A'i32
  STATUS_GRAPHICS_INVALID_MONITORDESCRIPTOR* = NTSTATUS 0xC01E032B'i32
  STATUS_GRAPHICS_MONITORDESCRIPTOR_NOT_IN_SET* = NTSTATUS 0xC01E032C'i32
  STATUS_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET* = NTSTATUS 0xC01E032D'i32
  STATUS_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE* = NTSTATUS 0xC01E032E'i32
  STATUS_GRAPHICS_INVALID_VIDPN_TARGET_SUBSET_TYPE* = NTSTATUS 0xC01E032F'i32
  STATUS_GRAPHICS_RESOURCES_NOT_RELATED* = NTSTATUS 0xC01E0330'i32
  STATUS_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE* = NTSTATUS 0xC01E0331'i32
  STATUS_GRAPHICS_TARGET_ID_MUST_BE_UNIQUE* = NTSTATUS 0xC01E0332'i32
  STATUS_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET* = NTSTATUS 0xC01E0333'i32
  STATUS_GRAPHICS_MONITOR_COULD_NOT_BE_ASSOCIATED_WITH_ADAPTER* = NTSTATUS 0xC01E0334'i32
  STATUS_GRAPHICS_NO_VIDPNMGR* = NTSTATUS 0xC01E0335'i32
  STATUS_GRAPHICS_NO_ACTIVE_VIDPN* = NTSTATUS 0xC01E0336'i32
  STATUS_GRAPHICS_STALE_VIDPN_TOPOLOGY* = NTSTATUS 0xC01E0337'i32
  STATUS_GRAPHICS_MONITOR_NOT_CONNECTED* = NTSTATUS 0xC01E0338'i32
  STATUS_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY* = NTSTATUS 0xC01E0339'i32
  STATUS_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE* = NTSTATUS 0xC01E033A'i32
  STATUS_GRAPHICS_INVALID_VISIBLEREGION_SIZE* = NTSTATUS 0xC01E033B'i32
  STATUS_GRAPHICS_INVALID_STRIDE* = NTSTATUS 0xC01E033C'i32
  STATUS_GRAPHICS_INVALID_PIXELFORMAT* = NTSTATUS 0xC01E033D'i32
  STATUS_GRAPHICS_INVALID_COLORBASIS* = NTSTATUS 0xC01E033E'i32
  STATUS_GRAPHICS_INVALID_PIXELVALUEACCESSMODE* = NTSTATUS 0xC01E033F'i32
  STATUS_GRAPHICS_TARGET_NOT_IN_TOPOLOGY* = NTSTATUS 0xC01E0340'i32
  STATUS_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT* = NTSTATUS 0xC01E0341'i32
  STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE* = NTSTATUS 0xC01E0342'i32
  STATUS_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN* = NTSTATUS 0xC01E0343'i32
  STATUS_GRAPHICS_INVALID_PATH_IMPORTANCE_ORDINAL* = NTSTATUS 0xC01E0344'i32
  STATUS_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION* = NTSTATUS 0xC01E0345'i32
  STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_SUPPORTED* = NTSTATUS 0xC01E0346'i32
  STATUS_GRAPHICS_INVALID_GAMMA_RAMP* = NTSTATUS 0xC01E0347'i32
  STATUS_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED* = NTSTATUS 0xC01E0348'i32
  STATUS_GRAPHICS_MULTISAMPLING_NOT_SUPPORTED* = NTSTATUS 0xC01E0349'i32
  STATUS_GRAPHICS_MODE_NOT_IN_MODESET* = NTSTATUS 0xC01E034A'i32
  STATUS_GRAPHICS_INVALID_VIDPN_TOPOLOGY_RECOMMENDATION_REASON* = NTSTATUS 0xC01E034D'i32
  STATUS_GRAPHICS_INVALID_PATH_CONTENT_TYPE* = NTSTATUS 0xC01E034E'i32
  STATUS_GRAPHICS_INVALID_COPYPROTECTION_TYPE* = NTSTATUS 0xC01E034F'i32
  STATUS_GRAPHICS_UNASSIGNED_MODESET_ALREADY_EXISTS* = NTSTATUS 0xC01E0350'i32
  STATUS_GRAPHICS_INVALID_SCANLINE_ORDERING* = NTSTATUS 0xC01E0352'i32
  STATUS_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED* = NTSTATUS 0xC01E0353'i32
  STATUS_GRAPHICS_NO_AVAILABLE_IMPORTANCE_ORDINALS* = NTSTATUS 0xC01E0354'i32
  STATUS_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT* = NTSTATUS 0xC01E0355'i32
  STATUS_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM* = NTSTATUS 0xC01E0356'i32
  STATUS_GRAPHICS_INVALID_MONITOR_CAPABILITY_ORIGIN* = NTSTATUS 0xC01E0357'i32
  STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE_CONSTRAINT* = NTSTATUS 0xC01E0358'i32
  STATUS_GRAPHICS_MAX_NUM_PATHS_REACHED* = NTSTATUS 0xC01E0359'i32
  STATUS_GRAPHICS_CANCEL_VIDPN_TOPOLOGY_AUGMENTATION* = NTSTATUS 0xC01E035A'i32
  STATUS_GRAPHICS_INVALID_CLIENT_TYPE* = NTSTATUS 0xC01E035B'i32
  STATUS_GRAPHICS_CLIENTVIDPN_NOT_SET* = NTSTATUS 0xC01E035C'i32
  STATUS_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED* = NTSTATUS 0xC01E0400'i32
  STATUS_GRAPHICS_CHILD_DESCRIPTOR_NOT_SUPPORTED* = NTSTATUS 0xC01E0401'i32
  STATUS_GRAPHICS_NOT_A_LINKED_ADAPTER* = NTSTATUS 0xC01E0430'i32
  STATUS_GRAPHICS_LEADLINK_NOT_ENUMERATED* = NTSTATUS 0xC01E0431'i32
  STATUS_GRAPHICS_CHAINLINKS_NOT_ENUMERATED* = NTSTATUS 0xC01E0432'i32
  STATUS_GRAPHICS_ADAPTER_CHAIN_NOT_READY* = NTSTATUS 0xC01E0433'i32
  STATUS_GRAPHICS_CHAINLINKS_NOT_STARTED* = NTSTATUS 0xC01E0434'i32
  STATUS_GRAPHICS_CHAINLINKS_NOT_POWERED_ON* = NTSTATUS 0xC01E0435'i32
  STATUS_GRAPHICS_INCONSISTENT_DEVICE_LINK_STATE* = NTSTATUS 0xC01E0436'i32
  STATUS_GRAPHICS_NOT_POST_DEVICE_DRIVER* = NTSTATUS 0xC01E0438'i32
  STATUS_GRAPHICS_ADAPTER_ACCESS_NOT_EXCLUDED* = NTSTATUS 0xC01E043B'i32
  STATUS_GRAPHICS_OPM_NOT_SUPPORTED* = NTSTATUS 0xC01E0500'i32
  STATUS_GRAPHICS_COPP_NOT_SUPPORTED* = NTSTATUS 0xC01E0501'i32
  STATUS_GRAPHICS_UAB_NOT_SUPPORTED* = NTSTATUS 0xC01E0502'i32
  STATUS_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS* = NTSTATUS 0xC01E0503'i32
  STATUS_GRAPHICS_OPM_PARAMETER_ARRAY_TOO_SMALL* = NTSTATUS 0xC01E0504'i32
  STATUS_GRAPHICS_OPM_NO_PROTECTED_OUTPUTS_EXIST* = NTSTATUS 0xC01E0505'i32
  STATUS_GRAPHICS_PVP_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME* = NTSTATUS 0xC01E0506'i32
  STATUS_GRAPHICS_PVP_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP* = NTSTATUS 0xC01E0507'i32
  STATUS_GRAPHICS_PVP_MIRRORING_DEVICES_NOT_SUPPORTED* = NTSTATUS 0xC01E0508'i32
  STATUS_GRAPHICS_OPM_INVALID_POINTER* = NTSTATUS 0xC01E050A'i32
  STATUS_GRAPHICS_OPM_INTERNAL_ERROR* = NTSTATUS 0xC01E050B'i32
  STATUS_GRAPHICS_OPM_INVALID_HANDLE* = NTSTATUS 0xC01E050C'i32
  STATUS_GRAPHICS_PVP_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE* = NTSTATUS 0xC01E050D'i32
  STATUS_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH* = NTSTATUS 0xC01E050E'i32
  STATUS_GRAPHICS_OPM_SPANNING_MODE_ENABLED* = NTSTATUS 0xC01E050F'i32
  STATUS_GRAPHICS_OPM_THEATER_MODE_ENABLED* = NTSTATUS 0xC01E0510'i32
  STATUS_GRAPHICS_PVP_HFS_FAILED* = NTSTATUS 0xC01E0511'i32
  STATUS_GRAPHICS_OPM_INVALID_SRM* = NTSTATUS 0xC01E0512'i32
  STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP* = NTSTATUS 0xC01E0513'i32
  STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP* = NTSTATUS 0xC01E0514'i32
  STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA* = NTSTATUS 0xC01E0515'i32
  STATUS_GRAPHICS_OPM_HDCP_SRM_NEVER_SET* = NTSTATUS 0xC01E0516'i32
  STATUS_GRAPHICS_OPM_RESOLUTION_TOO_HIGH* = NTSTATUS 0xC01E0517'i32
  STATUS_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE* = NTSTATUS 0xC01E0518'i32
  STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_NO_LONGER_EXISTS* = NTSTATUS 0xC01E051A'i32
  STATUS_GRAPHICS_OPM_SESSION_TYPE_CHANGE_IN_PROGRESS* = NTSTATUS 0xC01E051B'i32
  STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_COPP_SEMANTICS* = NTSTATUS 0xC01E051C'i32
  STATUS_GRAPHICS_OPM_INVALID_INFORMATION_REQUEST* = NTSTATUS 0xC01E051D'i32
  STATUS_GRAPHICS_OPM_DRIVER_INTERNAL_ERROR* = NTSTATUS 0xC01E051E'i32
  STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_OPM_SEMANTICS* = NTSTATUS 0xC01E051F'i32
  STATUS_GRAPHICS_OPM_SIGNALING_NOT_SUPPORTED* = NTSTATUS 0xC01E0520'i32
  STATUS_GRAPHICS_OPM_INVALID_CONFIGURATION_REQUEST* = NTSTATUS 0xC01E0521'i32
  STATUS_GRAPHICS_I2C_NOT_SUPPORTED* = NTSTATUS 0xC01E0580'i32
  STATUS_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST* = NTSTATUS 0xC01E0581'i32
  STATUS_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA* = NTSTATUS 0xC01E0582'i32
  STATUS_GRAPHICS_I2C_ERROR_RECEIVING_DATA* = NTSTATUS 0xC01E0583'i32
  STATUS_GRAPHICS_DDCCI_VCP_NOT_SUPPORTED* = NTSTATUS 0xC01E0584'i32
  STATUS_GRAPHICS_DDCCI_INVALID_DATA* = NTSTATUS 0xC01E0585'i32
  STATUS_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE* = NTSTATUS 0xC01E0586'i32
  STATUS_GRAPHICS_DDCCI_INVALID_CAPABILITIES_STRING* = NTSTATUS 0xC01E0587'i32
  STATUS_GRAPHICS_MCA_INTERNAL_ERROR* = NTSTATUS 0xC01E0588'i32
  STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND* = NTSTATUS 0xC01E0589'i32
  STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH* = NTSTATUS 0xC01E058A'i32
  STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM* = NTSTATUS 0xC01E058B'i32
  STATUS_GRAPHICS_INVALID_PHYSICAL_MONITOR_HANDLE* = NTSTATUS 0xC01E058C'i32
  STATUS_GRAPHICS_MONITOR_NO_LONGER_EXISTS* = NTSTATUS 0xC01E058D'i32
  STATUS_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED* = NTSTATUS 0xC01E05E0'i32
  STATUS_GRAPHICS_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME* = NTSTATUS 0xC01E05E1'i32
  STATUS_GRAPHICS_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP* = NTSTATUS 0xC01E05E2'i32
  STATUS_GRAPHICS_MIRRORING_DEVICES_NOT_SUPPORTED* = NTSTATUS 0xC01E05E3'i32
  STATUS_GRAPHICS_INVALID_POINTER* = NTSTATUS 0xC01E05E4'i32
  STATUS_GRAPHICS_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE* = NTSTATUS 0xC01E05E5'i32
  STATUS_GRAPHICS_PARAMETER_ARRAY_TOO_SMALL* = NTSTATUS 0xC01E05E6'i32
  STATUS_GRAPHICS_INTERNAL_ERROR* = NTSTATUS 0xC01E05E7'i32
  STATUS_GRAPHICS_SESSION_TYPE_CHANGE_IN_PROGRESS* = NTSTATUS 0xC01E05E8'i32
  STATUS_FVE_LOCKED_VOLUME* = NTSTATUS 0xC0210000'i32
  STATUS_FVE_NOT_ENCRYPTED* = NTSTATUS 0xC0210001'i32
  STATUS_FVE_BAD_INFORMATION* = NTSTATUS 0xC0210002'i32
  STATUS_FVE_TOO_SMALL* = NTSTATUS 0xC0210003'i32
  STATUS_FVE_FAILED_WRONG_FS* = NTSTATUS 0xC0210004'i32
  STATUS_FVE_FAILED_BAD_FS* = NTSTATUS 0xC0210005'i32
  STATUS_FVE_FS_NOT_EXTENDED* = NTSTATUS 0xC0210006'i32
  STATUS_FVE_FS_MOUNTED* = NTSTATUS 0xC0210007'i32
  STATUS_FVE_NO_LICENSE* = NTSTATUS 0xC0210008'i32
  STATUS_FVE_ACTION_NOT_ALLOWED* = NTSTATUS 0xC0210009'i32
  STATUS_FVE_BAD_DATA* = NTSTATUS 0xC021000A'i32
  STATUS_FVE_VOLUME_NOT_BOUND* = NTSTATUS 0xC021000B'i32
  STATUS_FVE_NOT_DATA_VOLUME* = NTSTATUS 0xC021000C'i32
  STATUS_FVE_CONV_READ_ERROR* = NTSTATUS 0xC021000D'i32
  STATUS_FVE_CONV_WRITE_ERROR* = NTSTATUS 0xC021000E'i32
  STATUS_FVE_OVERLAPPED_UPDATE* = NTSTATUS 0xC021000F'i32
  STATUS_FVE_FAILED_SECTOR_SIZE* = NTSTATUS 0xC0210010'i32
  STATUS_FVE_FAILED_AUTHENTICATION* = NTSTATUS 0xC0210011'i32
  STATUS_FVE_NOT_OS_VOLUME* = NTSTATUS 0xC0210012'i32
  STATUS_FVE_KEYFILE_NOT_FOUND* = NTSTATUS 0xC0210013'i32
  STATUS_FVE_KEYFILE_INVALID* = NTSTATUS 0xC0210014'i32
  STATUS_FVE_KEYFILE_NO_VMK* = NTSTATUS 0xC0210015'i32
  STATUS_FVE_TPM_DISABLED* = NTSTATUS 0xC0210016'i32
  STATUS_FVE_TPM_SRK_AUTH_NOT_ZERO* = NTSTATUS 0xC0210017'i32
  STATUS_FVE_TPM_INVALID_PCR* = NTSTATUS 0xC0210018'i32
  STATUS_FVE_TPM_NO_VMK* = NTSTATUS 0xC0210019'i32
  STATUS_FVE_PIN_INVALID* = NTSTATUS 0xC021001A'i32
  STATUS_FVE_AUTH_INVALID_APPLICATION* = NTSTATUS 0xC021001B'i32
  STATUS_FVE_AUTH_INVALID_CONFIG* = NTSTATUS 0xC021001C'i32
  STATUS_FVE_DEBUGGER_ENABLED* = NTSTATUS 0xC021001D'i32
  STATUS_FVE_DRY_RUN_FAILED* = NTSTATUS 0xC021001E'i32
  STATUS_FVE_BAD_METADATA_POINTER* = NTSTATUS 0xC021001F'i32
  STATUS_FVE_OLD_METADATA_COPY* = NTSTATUS 0xC0210020'i32
  STATUS_FVE_REBOOT_REQUIRED* = NTSTATUS 0xC0210021'i32
  STATUS_FVE_RAW_ACCESS* = NTSTATUS 0xC0210022'i32
  STATUS_FVE_RAW_BLOCKED* = NTSTATUS 0xC0210023'i32
  STATUS_FVE_NO_FEATURE_LICENSE* = NTSTATUS 0xC0210026'i32
  STATUS_FVE_POLICY_USER_DISABLE_RDV_NOT_ALLOWED* = NTSTATUS 0xC0210027'i32
  STATUS_FVE_CONV_RECOVERY_FAILED* = NTSTATUS 0xC0210028'i32
  STATUS_FVE_VIRTUALIZED_SPACE_TOO_BIG* = NTSTATUS 0xC0210029'i32
  STATUS_FVE_VOLUME_TOO_SMALL* = NTSTATUS 0xC0210030'i32
  STATUS_FWP_CALLOUT_NOT_FOUND* = NTSTATUS 0xC0220001'i32
  STATUS_FWP_CONDITION_NOT_FOUND* = NTSTATUS 0xC0220002'i32
  STATUS_FWP_FILTER_NOT_FOUND* = NTSTATUS 0xC0220003'i32
  STATUS_FWP_LAYER_NOT_FOUND* = NTSTATUS 0xC0220004'i32
  STATUS_FWP_PROVIDER_NOT_FOUND* = NTSTATUS 0xC0220005'i32
  STATUS_FWP_PROVIDER_CONTEXT_NOT_FOUND* = NTSTATUS 0xC0220006'i32
  STATUS_FWP_SUBLAYER_NOT_FOUND* = NTSTATUS 0xC0220007'i32
  STATUS_FWP_NOT_FOUND* = NTSTATUS 0xC0220008'i32
  STATUS_FWP_ALREADY_EXISTS* = NTSTATUS 0xC0220009'i32
  STATUS_FWP_IN_USE* = NTSTATUS 0xC022000A'i32
  STATUS_FWP_DYNAMIC_SESSION_IN_PROGRESS* = NTSTATUS 0xC022000B'i32
  STATUS_FWP_WRONG_SESSION* = NTSTATUS 0xC022000C'i32
  STATUS_FWP_NO_TXN_IN_PROGRESS* = NTSTATUS 0xC022000D'i32
  STATUS_FWP_TXN_IN_PROGRESS* = NTSTATUS 0xC022000E'i32
  STATUS_FWP_TXN_ABORTED* = NTSTATUS 0xC022000F'i32
  STATUS_FWP_SESSION_ABORTED* = NTSTATUS 0xC0220010'i32
  STATUS_FWP_INCOMPATIBLE_TXN* = NTSTATUS 0xC0220011'i32
  STATUS_FWP_TIMEOUT* = NTSTATUS 0xC0220012'i32
  STATUS_FWP_NET_EVENTS_DISABLED* = NTSTATUS 0xC0220013'i32
  STATUS_FWP_INCOMPATIBLE_LAYER* = NTSTATUS 0xC0220014'i32
  STATUS_FWP_KM_CLIENTS_ONLY* = NTSTATUS 0xC0220015'i32
  STATUS_FWP_LIFETIME_MISMATCH* = NTSTATUS 0xC0220016'i32
  STATUS_FWP_BUILTIN_OBJECT* = NTSTATUS 0xC0220017'i32
  STATUS_FWP_TOO_MANY_BOOTTIME_FILTERS* = NTSTATUS 0xC0220018'i32
  STATUS_FWP_TOO_MANY_CALLOUTS* = NTSTATUS 0xC0220018'i32
  STATUS_FWP_NOTIFICATION_DROPPED* = NTSTATUS 0xC0220019'i32
  STATUS_FWP_TRAFFIC_MISMATCH* = NTSTATUS 0xC022001A'i32
  STATUS_FWP_INCOMPATIBLE_SA_STATE* = NTSTATUS 0xC022001B'i32
  STATUS_FWP_NULL_POINTER* = NTSTATUS 0xC022001C'i32
  STATUS_FWP_INVALID_ENUMERATOR* = NTSTATUS 0xC022001D'i32
  STATUS_FWP_INVALID_FLAGS* = NTSTATUS 0xC022001E'i32
  STATUS_FWP_INVALID_NET_MASK* = NTSTATUS 0xC022001F'i32
  STATUS_FWP_INVALID_RANGE* = NTSTATUS 0xC0220020'i32
  STATUS_FWP_INVALID_INTERVAL* = NTSTATUS 0xC0220021'i32
  STATUS_FWP_ZERO_LENGTH_ARRAY* = NTSTATUS 0xC0220022'i32
  STATUS_FWP_NULL_DISPLAY_NAME* = NTSTATUS 0xC0220023'i32
  STATUS_FWP_INVALID_ACTION_TYPE* = NTSTATUS 0xC0220024'i32
  STATUS_FWP_INVALID_WEIGHT* = NTSTATUS 0xC0220025'i32
  STATUS_FWP_MATCH_TYPE_MISMATCH* = NTSTATUS 0xC0220026'i32
  STATUS_FWP_TYPE_MISMATCH* = NTSTATUS 0xC0220027'i32
  STATUS_FWP_OUT_OF_BOUNDS* = NTSTATUS 0xC0220028'i32
  STATUS_FWP_RESERVED* = NTSTATUS 0xC0220029'i32
  STATUS_FWP_DUPLICATE_CONDITION* = NTSTATUS 0xC022002A'i32
  STATUS_FWP_DUPLICATE_KEYMOD* = NTSTATUS 0xC022002B'i32
  STATUS_FWP_ACTION_INCOMPATIBLE_WITH_LAYER* = NTSTATUS 0xC022002C'i32
  STATUS_FWP_ACTION_INCOMPATIBLE_WITH_SUBLAYER* = NTSTATUS 0xC022002D'i32
  STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_LAYER* = NTSTATUS 0xC022002E'i32
  STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_CALLOUT* = NTSTATUS 0xC022002F'i32
  STATUS_FWP_INCOMPATIBLE_AUTH_METHOD* = NTSTATUS 0xC0220030'i32
  STATUS_FWP_INCOMPATIBLE_DH_GROUP* = NTSTATUS 0xC0220031'i32
  STATUS_FWP_EM_NOT_SUPPORTED* = NTSTATUS 0xC0220032'i32
  STATUS_FWP_NEVER_MATCH* = NTSTATUS 0xC0220033'i32
  STATUS_FWP_PROVIDER_CONTEXT_MISMATCH* = NTSTATUS 0xC0220034'i32
  STATUS_FWP_INVALID_PARAMETER* = NTSTATUS 0xC0220035'i32
  STATUS_FWP_TOO_MANY_SUBLAYERS* = NTSTATUS 0xC0220036'i32
  STATUS_FWP_CALLOUT_NOTIFICATION_FAILED* = NTSTATUS 0xC0220037'i32
  STATUS_FWP_INCOMPATIBLE_AUTH_CONFIG* = NTSTATUS 0xC0220038'i32
  STATUS_FWP_INCOMPATIBLE_CIPHER_CONFIG* = NTSTATUS 0xC0220039'i32
  STATUS_FWP_DUPLICATE_AUTH_METHOD* = NTSTATUS 0xC022003C'i32
  STATUS_FWP_TCPIP_NOT_READY* = NTSTATUS 0xC0220100'i32
  STATUS_FWP_INJECT_HANDLE_CLOSING* = NTSTATUS 0xC0220101'i32
  STATUS_FWP_INJECT_HANDLE_STALE* = NTSTATUS 0xC0220102'i32
  STATUS_FWP_CANNOT_PEND* = NTSTATUS 0xC0220103'i32
  STATUS_NDIS_CLOSING* = NTSTATUS 0xC0230002'i32
  STATUS_NDIS_BAD_VERSION* = NTSTATUS 0xC0230004'i32
  STATUS_NDIS_BAD_CHARACTERISTICS* = NTSTATUS 0xC0230005'i32
  STATUS_NDIS_ADAPTER_NOT_FOUND* = NTSTATUS 0xC0230006'i32
  STATUS_NDIS_OPEN_FAILED* = NTSTATUS 0xC0230007'i32
  STATUS_NDIS_DEVICE_FAILED* = NTSTATUS 0xC0230008'i32
  STATUS_NDIS_MULTICAST_FULL* = NTSTATUS 0xC0230009'i32
  STATUS_NDIS_MULTICAST_EXISTS* = NTSTATUS 0xC023000A'i32
  STATUS_NDIS_MULTICAST_NOT_FOUND* = NTSTATUS 0xC023000B'i32
  STATUS_NDIS_REQUEST_ABORTED* = NTSTATUS 0xC023000C'i32
  STATUS_NDIS_RESET_IN_PROGRESS* = NTSTATUS 0xC023000D'i32
  STATUS_NDIS_INVALID_PACKET* = NTSTATUS 0xC023000F'i32
  STATUS_NDIS_INVALID_DEVICE_REQUEST* = NTSTATUS 0xC0230010'i32
  STATUS_NDIS_ADAPTER_NOT_READY* = NTSTATUS 0xC0230011'i32
  STATUS_NDIS_INVALID_LENGTH* = NTSTATUS 0xC0230014'i32
  STATUS_NDIS_INVALID_DATA* = NTSTATUS 0xC0230015'i32
  STATUS_NDIS_BUFFER_TOO_SHORT* = NTSTATUS 0xC0230016'i32
  STATUS_NDIS_INVALID_OID* = NTSTATUS 0xC0230017'i32
  STATUS_NDIS_ADAPTER_REMOVED* = NTSTATUS 0xC0230018'i32
  STATUS_NDIS_UNSUPPORTED_MEDIA* = NTSTATUS 0xC0230019'i32
  STATUS_NDIS_GROUP_ADDRESS_IN_USE* = NTSTATUS 0xC023001A'i32
  STATUS_NDIS_FILE_NOT_FOUND* = NTSTATUS 0xC023001B'i32
  STATUS_NDIS_ERROR_READING_FILE* = NTSTATUS 0xC023001C'i32
  STATUS_NDIS_ALREADY_MAPPED* = NTSTATUS 0xC023001D'i32
  STATUS_NDIS_RESOURCE_CONFLICT* = NTSTATUS 0xC023001E'i32
  STATUS_NDIS_MEDIA_DISCONNECTED* = NTSTATUS 0xC023001F'i32
  STATUS_NDIS_INVALID_ADDRESS* = NTSTATUS 0xC0230022'i32
  STATUS_NDIS_PAUSED* = NTSTATUS 0xC023002A'i32
  STATUS_NDIS_INTERFACE_NOT_FOUND* = NTSTATUS 0xC023002B'i32
  STATUS_NDIS_UNSUPPORTED_REVISION* = NTSTATUS 0xC023002C'i32
  STATUS_NDIS_INVALID_PORT* = NTSTATUS 0xC023002D'i32
  STATUS_NDIS_INVALID_PORT_STATE* = NTSTATUS 0xC023002E'i32
  STATUS_NDIS_LOW_POWER_STATE* = NTSTATUS 0xC023002F'i32
  STATUS_NDIS_NOT_SUPPORTED* = NTSTATUS 0xC02300BB'i32
  STATUS_NDIS_OFFLOAD_POLICY* = NTSTATUS 0xC023100F'i32
  STATUS_NDIS_OFFLOAD_CONNECTION_REJECTED* = NTSTATUS 0xC0231012'i32
  STATUS_NDIS_OFFLOAD_PATH_REJECTED* = NTSTATUS 0xC0231013'i32
  STATUS_NDIS_DOT11_AUTO_CONFIG_ENABLED* = NTSTATUS 0xC0232000'i32
  STATUS_NDIS_DOT11_MEDIA_IN_USE* = NTSTATUS 0xC0232001'i32
  STATUS_NDIS_DOT11_POWER_STATE_INVALID* = NTSTATUS 0xC0232002'i32
  STATUS_NDIS_PM_WOL_PATTERN_LIST_FULL* = NTSTATUS 0xC0232003'i32
  STATUS_NDIS_PM_PROTOCOL_OFFLOAD_LIST_FULL* = NTSTATUS 0xC0232004'i32
  STATUS_IPSEC_BAD_SPI* = NTSTATUS 0xC0360001'i32
  STATUS_IPSEC_SA_LIFETIME_EXPIRED* = NTSTATUS 0xC0360002'i32
  STATUS_IPSEC_WRONG_SA* = NTSTATUS 0xC0360003'i32
  STATUS_IPSEC_REPLAY_CHECK_FAILED* = NTSTATUS 0xC0360004'i32
  STATUS_IPSEC_INVALID_PACKET* = NTSTATUS 0xC0360005'i32
  STATUS_IPSEC_INTEGRITY_CHECK_FAILED* = NTSTATUS 0xC0360006'i32
  STATUS_IPSEC_CLEAR_TEXT_DROP* = NTSTATUS 0xC0360007'i32
  STATUS_IPSEC_AUTH_FIREWALL_DROP* = NTSTATUS 0xC0360008'i32
  STATUS_IPSEC_THROTTLE_DROP* = NTSTATUS 0xC0360009'i32
  STATUS_IPSEC_DOSP_BLOCK* = NTSTATUS 0xC0368000'i32
  STATUS_IPSEC_DOSP_RECEIVED_MULTICAST* = NTSTATUS 0xC0368001'i32
  STATUS_IPSEC_DOSP_INVALID_PACKET* = NTSTATUS 0xC0368002'i32
  STATUS_IPSEC_DOSP_STATE_LOOKUP_FAILED* = NTSTATUS 0xC0368003'i32
  STATUS_IPSEC_DOSP_MAX_ENTRIES* = NTSTATUS 0xC0368004'i32
  STATUS_IPSEC_DOSP_KEYMOD_NOT_ALLOWED* = NTSTATUS 0xC0368005'i32
  STATUS_IPSEC_DOSP_MAX_PER_IP_RATELIMIT_QUEUES* = NTSTATUS 0xC0368006'i32
  STATUS_VOLMGR_MIRROR_NOT_SUPPORTED* = NTSTATUS 0xC038005B'i32
  STATUS_VOLMGR_RAID5_NOT_SUPPORTED* = NTSTATUS 0xC038005C'i32
  STATUS_VIRTDISK_PROVIDER_NOT_FOUND* = NTSTATUS 0xC03A0014'i32
  STATUS_VIRTDISK_NOT_VIRTUAL_DISK* = NTSTATUS 0xC03A0015'i32
  STATUS_VHD_PARENT_VHD_ACCESS_DENIED* = NTSTATUS 0xC03A0016'i32
  STATUS_VHD_CHILD_PARENT_SIZE_MISMATCH* = NTSTATUS 0xC03A0017'i32
  STATUS_VHD_DIFFERENCING_CHAIN_CYCLE_DETECTED* = NTSTATUS 0xC03A0018'i32
  STATUS_VHD_DIFFERENCING_CHAIN_ERROR_IN_PARENT* = NTSTATUS 0xC03A0019'i32
  MAX_PATH* = 260
  PRAGMA_DEPRECATED_DDK* = 0
  UCSCHAR_INVALID_CHARACTER* = 0xffffffff'i32
  MIN_UCSCHAR* = 0
  MAX_UCSCHAR* = 0x0010ffff
  UNSPECIFIED_COMPARTMENT_ID* = 0
  DEFAULT_COMPARTMENT_ID* = 1
  APPLICATION_ERROR_MASK* = 0x20000000
  ERROR_SEVERITY_SUCCESS* = 0x00000000
  ERROR_SEVERITY_INFORMATIONAL* = 0x40000000
  ERROR_SEVERITY_WARNING* = 0x80000000'i32
  ERROR_SEVERITY_ERROR* = 0xC0000000'i32
  UNICODE_STRING_MAX_BYTES* = WORD 65534
  UNICODE_STRING_MAX_CHARS* = 32767
template DEFINE_GUID*(data1: int32, data2: uint16, data3: uint16, data4: array[8, uint8]): GUID = GUID(Data1: data1, Data2: data2, Data3: data3, Data4: data4)
const
  GUID_NULL* = DEFINE_GUID("00000000-0000-0000-0000-000000000000")
  IID_NULL* = GUID_NULL
  CLSID_NULL* = GUID_NULL
  FMTID_NULL* = GUID_NULL
  MAXBYTE* = 0xff
  MAXWORD* = 0xffff
  MAXDWORD* = 0xffffffff'i32
  PRODUCT_UNDEFINED* = 0x0
  PRODUCT_ULTIMATE* = 0x1
  PRODUCT_HOME_BASIC* = 0x2
  PRODUCT_HOME_PREMIUM* = 0x3
  PRODUCT_ENTERPRISE* = 0x4
  PRODUCT_HOME_BASIC_N* = 0x5
  PRODUCT_BUSINESS* = 0x6
  PRODUCT_STANDARD_SERVER* = 0x7
  PRODUCT_DATACENTER_SERVER* = 0x8
  PRODUCT_SMALLBUSINESS_SERVER* = 0x9
  PRODUCT_ENTERPRISE_SERVER* = 0xa
  PRODUCT_STARTER* = 0xb
  PRODUCT_DATACENTER_SERVER_CORE* = 0xc
  PRODUCT_STANDARD_SERVER_CORE* = 0xd
  PRODUCT_ENTERPRISE_SERVER_CORE* = 0xe
  PRODUCT_ENTERPRISE_SERVER_IA64* = 0xf
  PRODUCT_BUSINESS_N* = 0x10
  PRODUCT_WEB_SERVER* = 0x11
  PRODUCT_CLUSTER_SERVER* = 0x12
  PRODUCT_HOME_SERVER* = 0x13
  PRODUCT_STORAGE_EXPRESS_SERVER* = 0x14
  PRODUCT_STORAGE_STANDARD_SERVER* = 0x15
  PRODUCT_STORAGE_WORKGROUP_SERVER* = 0x16
  PRODUCT_STORAGE_ENTERPRISE_SERVER* = 0x17
  PRODUCT_SERVER_FOR_SMALLBUSINESS* = 0x18
  PRODUCT_SMALLBUSINESS_SERVER_PREMIUM* = 0x19
  PRODUCT_HOME_PREMIUM_N* = 0x1a
  PRODUCT_ENTERPRISE_N* = 0x1b
  PRODUCT_ULTIMATE_N* = 0x1c
  PRODUCT_WEB_SERVER_CORE* = 0x1d
  PRODUCT_MEDIUMBUSINESS_SERVER_MANAGEMENT* = 0x1e
  PRODUCT_MEDIUMBUSINESS_SERVER_SECURITY* = 0x1f
  PRODUCT_MEDIUMBUSINESS_SERVER_MESSAGING* = 0x20
  PRODUCT_SERVER_FOUNDATION* = 0x21
  PRODUCT_HOME_PREMIUM_SERVER* = 0x22
  PRODUCT_SERVER_FOR_SMALLBUSINESS_V* = 0x23
  PRODUCT_STANDARD_SERVER_V* = 0x24
  PRODUCT_DATACENTER_SERVER_V* = 0x25
  PRODUCT_ENTERPRISE_SERVER_V* = 0x26
  PRODUCT_DATACENTER_SERVER_CORE_V* = 0x27
  PRODUCT_STANDARD_SERVER_CORE_V* = 0x28
  PRODUCT_ENTERPRISE_SERVER_CORE_V* = 0x29
  PRODUCT_HYPERV* = 0x2a
  PRODUCT_STORAGE_EXPRESS_SERVER_CORE* = 0x2b
  PRODUCT_STORAGE_STANDARD_SERVER_CORE* = 0x2c
  PRODUCT_STORAGE_WORKGROUP_SERVER_CORE* = 0x2d
  PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE* = 0x2e
  PRODUCT_STARTER_N* = 0x2f
  PRODUCT_PROFESSIONAL* = 0x30
  PRODUCT_PROFESSIONAL_N* = 0x31
  PRODUCT_SB_SOLUTION_SERVER* = 0x32
  PRODUCT_SERVER_FOR_SB_SOLUTIONS* = 0x33
  PRODUCT_STANDARD_SERVER_SOLUTIONS* = 0x34
  PRODUCT_STANDARD_SERVER_SOLUTIONS_CORE* = 0x35
  PRODUCT_SB_SOLUTION_SERVER_EM* = 0x36
  PRODUCT_SERVER_FOR_SB_SOLUTIONS_EM* = 0x37
  PRODUCT_SOLUTION_EMBEDDEDSERVER* = 0x38
  PRODUCT_SOLUTION_EMBEDDEDSERVER_CORE* = 0x39
  PRODUCT_ESSENTIALBUSINESS_SERVER_MGMT* = 0x3B
  PRODUCT_ESSENTIALBUSINESS_SERVER_ADDL* = 0x3C
  PRODUCT_ESSENTIALBUSINESS_SERVER_MGMTSVC* = 0x3D
  PRODUCT_ESSENTIALBUSINESS_SERVER_ADDLSVC* = 0x3E
  PRODUCT_SMALLBUSINESS_SERVER_PREMIUM_CORE* = 0x3f
  PRODUCT_CLUSTER_SERVER_V* = 0x40
  PRODUCT_EMBEDDED* = 0x41
  PRODUCT_STARTER_E* = 0x42
  PRODUCT_HOME_BASIC_E* = 0x43
  PRODUCT_HOME_PREMIUM_E* = 0x44
  PRODUCT_PROFESSIONAL_E* = 0x45
  PRODUCT_ENTERPRISE_E* = 0x46
  PRODUCT_ULTIMATE_E* = 0x47
  PRODUCT_ENTERPRISE_EVALUATION* = 0x48
  PRODUCT_MULTIPOINT_STANDARD_SERVER* = 0x4C
  PRODUCT_MULTIPOINT_PREMIUM_SERVER* = 0x4D
  PRODUCT_STANDARD_EVALUATION_SERVER* = 0x4F
  PRODUCT_DATACENTER_EVALUATION_SERVER* = 0x50
  PRODUCT_ENTERPRISE_N_EVALUATION* = 0x54
  PRODUCT_EMBEDDED_AUTOMOTIVE* = 0x55
  PRODUCT_EMBEDDED_INDUSTRY_A* = 0x56
  PRODUCT_THINPC* = 0x57
  PRODUCT_EMBEDDED_A* = 0x58
  PRODUCT_EMBEDDED_INDUSTRY* = 0x59
  PRODUCT_EMBEDDED_E* = 0x5A
  PRODUCT_EMBEDDED_INDUSTRY_E* = 0x5B
  PRODUCT_EMBEDDED_INDUSTRY_A_E* = 0x5C
  PRODUCT_STORAGE_WORKGROUP_EVALUATION_SERVER* = 0x5F
  PRODUCT_STORAGE_STANDARD_EVALUATION_SERVER* = 0x60
  PRODUCT_CORE_ARM* = 0x61
  PRODUCT_CORE_N* = 0x62
  PRODUCT_CORE_COUNTRYSPECIFIC* = 0x63
  PRODUCT_CORE_SINGLELANGUAGE* = 0x64
  PRODUCT_CORE* = 0x65
  PRODUCT_PROFESSIONAL_WMC* = 0x67
  PRODUCT_MOBILE_CORE* = 0x68
  PRODUCT_EDUCATION* = 0x79
  PRODUCT_EDUCATION_N* = 0x7a
  PRODUCT_MOBILE_ENTERPRISE* = 0x85
  PRODUCT_UNLICENSED* = 0xabcdabcd'i32
  LANG_AZERBAIJANI* = 0x2c
  LANG_BANGLA* = 0x45
  LANG_CENTRAL_KURDISH* = 0x92
  LANG_CHEROKEE* = 0x5c
  LANG_FULAH* = 0x67
  LANG_ODIA* = 0x48
  LANG_PULAR* = 0x67
  LANG_SAKHA* = 0x85
  LANG_SCOTTISH_GAELIC* = 0x91
  LANG_TIGRINYA* = 0x73
  LANG_VALENCIAN* = 0x03
  SUBLANG_NEUTRAL* = 0x00
  SUBLANG_DEFAULT* = 0x01
  SUBLANG_SYS_DEFAULT* = 0x02
  SUBLANG_CUSTOM_DEFAULT* = 0x03
  SUBLANG_CUSTOM_UNSPECIFIED* = 0x04
  SUBLANG_UI_CUSTOM_DEFAULT* = 0x05
  SUBLANG_AFRIKAANS_SOUTH_AFRICA* = 0x01
  SUBLANG_ALBANIAN_ALBANIA* = 0x01
  SUBLANG_ALSATIAN_FRANCE* = 0x01
  SUBLANG_AMHARIC_ETHIOPIA* = 0x01
  SUBLANG_ARABIC_SAUDI_ARABIA* = 0x01
  SUBLANG_ARABIC_IRAQ* = 0x02
  SUBLANG_ARABIC_EGYPT* = 0x03
  SUBLANG_ARABIC_LIBYA* = 0x04
  SUBLANG_ARABIC_ALGERIA* = 0x05
  SUBLANG_ARABIC_MOROCCO* = 0x06
  SUBLANG_ARABIC_TUNISIA* = 0x07
  SUBLANG_ARABIC_OMAN* = 0x08
  SUBLANG_ARABIC_YEMEN* = 0x09
  SUBLANG_ARABIC_SYRIA* = 0x0a
  SUBLANG_ARABIC_JORDAN* = 0x0b
  SUBLANG_ARABIC_LEBANON* = 0x0c
  SUBLANG_ARABIC_KUWAIT* = 0x0d
  SUBLANG_ARABIC_UAE* = 0x0e
  SUBLANG_ARABIC_BAHRAIN* = 0x0f
  SUBLANG_ARABIC_QATAR* = 0x10
  SUBLANG_ARMENIAN_ARMENIA* = 0x01
  SUBLANG_ASSAMESE_INDIA* = 0x01
  SUBLANG_AZERI_LATIN* = 0x01
  SUBLANG_AZERI_CYRILLIC* = 0x02
  SUBLANG_AZERBAIJANI_AZERBAIJAN_LATIN* = 0x01
  SUBLANG_AZERBAIJANI_AZERBAIJAN_CYRILLIC* = 0x02
  SUBLANG_BANGLA_INDIA* = 0x01
  SUBLANG_BANGLA_BANGLADESH* = 0x02
  SUBLANG_BASHKIR_RUSSIA* = 0x01
  SUBLANG_BASQUE_BASQUE* = 0x01
  SUBLANG_BELARUSIAN_BELARUS* = 0x01
  SUBLANG_BENGALI_INDIA* = 0x01
  SUBLANG_BENGALI_BANGLADESH* = 0x02
  SUBLANG_BOSNIAN_BOSNIA_HERZEGOVINA_LATIN* = 0x05
  SUBLANG_BOSNIAN_BOSNIA_HERZEGOVINA_CYRILLIC* = 0x08
  SUBLANG_BRETON_FRANCE* = 0x01
  SUBLANG_BULGARIAN_BULGARIA* = 0x01
  SUBLANG_CATALAN_CATALAN* = 0x01
  SUBLANG_CENTRAL_KURDISH_IRAQ* = 0x01
  SUBLANG_CHEROKEE_CHEROKEE* = 0x01
  SUBLANG_CHINESE_TRADITIONAL* = 0x01
  SUBLANG_CHINESE_SIMPLIFIED* = 0x02
  SUBLANG_CHINESE_HONGKONG* = 0x03
  SUBLANG_CHINESE_SINGAPORE* = 0x04
  SUBLANG_CHINESE_MACAU* = 0x05
  SUBLANG_CORSICAN_FRANCE* = 0x01
  SUBLANG_CZECH_CZECH_REPUBLIC* = 0x01
  SUBLANG_CROATIAN_CROATIA* = 0x01
  SUBLANG_CROATIAN_BOSNIA_HERZEGOVINA_LATIN* = 0x04
  SUBLANG_DANISH_DENMARK* = 0x01
  SUBLANG_DARI_AFGHANISTAN* = 0x01
  SUBLANG_DIVEHI_MALDIVES* = 0x01
  SUBLANG_DUTCH* = 0x01
  SUBLANG_DUTCH_BELGIAN* = 0x02
  SUBLANG_ENGLISH_US* = 0x01
  SUBLANG_ENGLISH_UK* = 0x02
  SUBLANG_ENGLISH_AUS* = 0x03
  SUBLANG_ENGLISH_CAN* = 0x04
  SUBLANG_ENGLISH_NZ* = 0x05
  SUBLANG_ENGLISH_IRELAND* = 0x06
  SUBLANG_ENGLISH_EIRE* = 0x06
  SUBLANG_ENGLISH_SOUTH_AFRICA* = 0x07
  SUBLANG_ENGLISH_JAMAICA* = 0x08
  SUBLANG_ENGLISH_CARIBBEAN* = 0x09
  SUBLANG_ENGLISH_BELIZE* = 0x0a
  SUBLANG_ENGLISH_TRINIDAD* = 0x0b
  SUBLANG_ENGLISH_ZIMBABWE* = 0x0c
  SUBLANG_ENGLISH_PHILIPPINES* = 0x0d
  SUBLANG_ENGLISH_INDIA* = 0x10
  SUBLANG_ENGLISH_MALAYSIA* = 0x11
  SUBLANG_ENGLISH_SINGAPORE* = 0x12
  SUBLANG_ESTONIAN_ESTONIA* = 0x01
  SUBLANG_FAEROESE_FAROE_ISLANDS* = 0x01
  SUBLANG_FILIPINO_PHILIPPINES* = 0x01
  SUBLANG_FINNISH_FINLAND* = 0x01
  SUBLANG_FRENCH* = 0x01
  SUBLANG_FRENCH_BELGIAN* = 0x02
  SUBLANG_FRENCH_CANADIAN* = 0x03
  SUBLANG_FRENCH_SWISS* = 0x04
  SUBLANG_FRENCH_LUXEMBOURG* = 0x05
  SUBLANG_FRENCH_MONACO* = 0x06
  SUBLANG_FRISIAN_NETHERLANDS* = 0x01
  SUBLANG_FULAH_SENEGAL* = 0x02
  SUBLANG_GALICIAN_GALICIAN* = 0x01
  SUBLANG_GEORGIAN_GEORGIA* = 0x01
  SUBLANG_GERMAN* = 0x01
  SUBLANG_GERMAN_SWISS* = 0x02
  SUBLANG_GERMAN_AUSTRIAN* = 0x03
  SUBLANG_GERMAN_LUXEMBOURG* = 0x04
  SUBLANG_GERMAN_LIECHTENSTEIN* = 0x05
  SUBLANG_GREEK_GREECE* = 0x01
  SUBLANG_GREENLANDIC_GREENLAND* = 0x01
  SUBLANG_GUJARATI_INDIA* = 0x01
  SUBLANG_HAUSA_NIGERIA_LATIN* = 0x01
  SUBLANG_HAUSA_NIGERIA* = SUBLANG_HAUSA_NIGERIA_LATIN
  SUBLANG_HAWAIIAN_US* = 0x01
  SUBLANG_HEBREW_ISRAEL* = 0x01
  SUBLANG_HINDI_INDIA* = 0x01
  SUBLANG_HUNGARIAN_HUNGARY* = 0x01
  SUBLANG_ICELANDIC_ICELAND* = 0x01
  SUBLANG_IGBO_NIGERIA* = 0x01
  SUBLANG_INDONESIAN_INDONESIA* = 0x01
  SUBLANG_INUKTITUT_CANADA* = 0x01
  SUBLANG_INUKTITUT_CANADA_LATIN* = 0x02
  SUBLANG_IRISH_IRELAND* = 0x02
  SUBLANG_ITALIAN* = 0x01
  SUBLANG_ITALIAN_SWISS* = 0x02
  SUBLANG_JAPANESE_JAPAN* = 0x01
  SUBLANG_KANNADA_INDIA* = 0x01
  SUBLANG_KASHMIRI_INDIA* = 0x02
  SUBLANG_KASHMIRI_SASIA* = 0x02
  SUBLANG_KAZAK_KAZAKHSTAN* = 0x01
  SUBLANG_KHMER_CAMBODIA* = 0x01
  SUBLANG_KICHE_GUATEMALA* = 0x01
  SUBLANG_KINYARWANDA_RWANDA* = 0x01
  SUBLANG_KONKANI_INDIA* = 0x01
  SUBLANG_KOREAN* = 0x01
  SUBLANG_KYRGYZ_KYRGYZSTAN* = 0x01
  SUBLANG_LAO_LAO* = 0x01
  SUBLANG_LAO_LAO_PDR* = SUBLANG_LAO_LAO
  SUBLANG_LATVIAN_LATVIA* = 0x01
  SUBLANG_LITHUANIAN_LITHUANIA* = 0x01
  SUBLANG_LITHUANIAN* = 0x01
  SUBLANG_LOWER_SORBIAN_GERMANY* = 0x02
  SUBLANG_LUXEMBOURGISH_LUXEMBOURG* = 0x01
  SUBLANG_MACEDONIAN_MACEDONIA* = 0x01
  SUBLANG_MALAY_MALAYSIA* = 0x01
  SUBLANG_MALAY_BRUNEI_DARUSSALAM* = 0x02
  SUBLANG_MALAYALAM_INDIA* = 0x01
  SUBLANG_MALTESE_MALTA* = 0x01
  SUBLANG_MAORI_NEW_ZEALAND* = 0x01
  SUBLANG_MAPUDUNGUN_CHILE* = 0x01
  SUBLANG_MARATHI_INDIA* = 0x01
  SUBLANG_MOHAWK_MOHAWK* = 0x01
  SUBLANG_MONGOLIAN_CYRILLIC_MONGOLIA* = 0x01
  SUBLANG_MONGOLIAN_PRC* = 0x02
  SUBLANG_NEPALI_NEPAL* = 0x01
  SUBLANG_NEPALI_INDIA* = 0x02
  SUBLANG_NORWEGIAN_BOKMAL* = 0x01
  SUBLANG_NORWEGIAN_NYNORSK* = 0x02
  SUBLANG_OCCITAN_FRANCE* = 0x01
  SUBLANG_ORIYA_INDIA* = 0x01
  SUBLANG_PASHTO_AFGHANISTAN* = 0x01
  SUBLANG_PERSIAN_IRAN* = 0x01
  SUBLANG_POLISH_POLAND* = 0x01
  SUBLANG_PORTUGUESE_BRAZILIAN* = 0x01
  SUBLANG_PORTUGUESE_PORTUGAL* = 0x02
  SUBLANG_PORTUGUESE* = 0x02
  SUBLANG_PULAR_SENEGAL* = 0x02
  SUBLANG_PUNJABI_INDIA* = 0x01
  SUBLANG_PUNJABI_PAKISTAN* = 0x02
  SUBLANG_QUECHUA_BOLIVIA* = 0x01
  SUBLANG_QUECHUA_ECUADOR* = 0x02
  SUBLANG_QUECHUA_PERU* = 0x03
  SUBLANG_ROMANIAN_ROMANIA* = 0x01
  SUBLANG_ROMANSH_SWITZERLAND* = 0x01
  SUBLANG_RUSSIAN_RUSSIA* = 0x01
  SUBLANG_SAKHA_RUSSIA* = 0x01
  SUBLANG_SAMI_NORTHERN_NORWAY* = 0x01
  SUBLANG_SAMI_NORTHERN_SWEDEN* = 0x02
  SUBLANG_SAMI_NORTHERN_FINLAND* = 0x03
  SUBLANG_SAMI_LULE_NORWAY* = 0x04
  SUBLANG_SAMI_LULE_SWEDEN* = 0x05
  SUBLANG_SAMI_SOUTHERN_NORWAY* = 0x06
  SUBLANG_SAMI_SOUTHERN_SWEDEN* = 0x07
  SUBLANG_SAMI_SKOLT_FINLAND* = 0x08
  SUBLANG_SAMI_INARI_FINLAND* = 0x09
  SUBLANG_SANSKRIT_INDIA* = 0x01
  SUBLANG_SCOTTISH_GAELIC* = 0x01
  SUBLANG_SERBIAN_LATIN* = 0x02
  SUBLANG_SERBIAN_CYRILLIC* = 0x03
  SUBLANG_SERBIAN_BOSNIA_HERZEGOVINA_LATIN* = 0x06
  SUBLANG_SERBIAN_BOSNIA_HERZEGOVINA_CYRILLIC* = 0x07
  SUBLANG_SERBIAN_MONTENEGRO_LATIN* = 0x0b
  SUBLANG_SERBIAN_MONTENEGRO_CYRILLIC* = 0x0c
  SUBLANG_SERBIAN_SERBIA_LATIN* = 0x09
  SUBLANG_SERBIAN_SERBIA_CYRILLIC* = 0x0a
  SUBLANG_SINDHI_INDIA* = 0x01
  SUBLANG_SINDHI_AFGHANISTAN* = 0x02
  SUBLANG_SINDHI_PAKISTAN* = 0x02
  SUBLANG_SINHALESE_SRI_LANKA* = 0x01
  SUBLANG_SOTHO_NORTHERN_SOUTH_AFRICA* = 0x01
  SUBLANG_SLOVAK_SLOVAKIA* = 0x01
  SUBLANG_SLOVENIAN_SLOVENIA* = 0x01
  SUBLANG_SPANISH* = 0x01
  SUBLANG_SPANISH_MEXICAN* = 0x02
  SUBLANG_SPANISH_MODERN* = 0x03
  SUBLANG_SPANISH_GUATEMALA* = 0x04
  SUBLANG_SPANISH_COSTA_RICA* = 0x05
  SUBLANG_SPANISH_PANAMA* = 0x06
  SUBLANG_SPANISH_DOMINICAN_REPUBLIC* = 0x07
  SUBLANG_SPANISH_VENEZUELA* = 0x08
  SUBLANG_SPANISH_COLOMBIA* = 0x09
  SUBLANG_SPANISH_PERU* = 0x0a
  SUBLANG_SPANISH_ARGENTINA* = 0x0b
  SUBLANG_SPANISH_ECUADOR* = 0x0c
  SUBLANG_SPANISH_CHILE* = 0x0d
  SUBLANG_SPANISH_URUGUAY* = 0x0e
  SUBLANG_SPANISH_PARAGUAY* = 0x0f
  SUBLANG_SPANISH_BOLIVIA* = 0x10
  SUBLANG_SPANISH_EL_SALVADOR* = 0x11
  SUBLANG_SPANISH_HONDURAS* = 0x12
  SUBLANG_SPANISH_NICARAGUA* = 0x13
  SUBLANG_SPANISH_PUERTO_RICO* = 0x14
  SUBLANG_SPANISH_US* = 0x15
  SUBLANG_SWAHILI_KENYA* = 0x01
  SUBLANG_SWEDISH_SWEDEN* = 0x01
  SUBLANG_SWEDISH* = 0x01
  SUBLANG_SWEDISH_FINLAND* = 0x02
  SUBLANG_SYRIAC* = 0x01
  SUBLANG_SYRIAC_SYRIA* = SUBLANG_SYRIAC
  SUBLANG_TAJIK_TAJIKISTAN* = 0x01
  SUBLANG_TAMAZIGHT_ALGERIA_LATIN* = 0x02
  SUBLANG_TAMAZIGHT_MOROCCO_TIFINAGH* = 0x04
  SUBLANG_TAMIL_INDIA* = 0x01
  SUBLANG_TAMIL_SRI_LANKA* = 0x02
  SUBLANG_TATAR_RUSSIA* = 0x01
  SUBLANG_TELUGU_INDIA* = 0x01
  SUBLANG_THAI_THAILAND* = 0x01
  SUBLANG_TIBETAN_PRC* = 0x01
  SUBLANG_TIBETAN_BHUTAN* = 0x02
  SUBLANG_TIGRIGNA_ERITREA* = 0x02
  SUBLANG_TIGRINYA_ERITREA* = 0x02
  SUBLANG_TIGRINYA_ETHIOPIA* = 0x01
  SUBLANG_TSWANA_BOTSWANA* = 0x02
  SUBLANG_TSWANA_SOUTH_AFRICA* = 0x01
  SUBLANG_TURKISH_TURKEY* = 0x01
  SUBLANG_TURKMEN_TURKMENISTAN* = 0x01
  SUBLANG_UIGHUR_PRC* = 0x01
  SUBLANG_UKRAINIAN_UKRAINE* = 0x01
  SUBLANG_UPPER_SORBIAN_GERMANY* = 0x01
  SUBLANG_URDU_PAKISTAN* = 0x01
  SUBLANG_URDU_INDIA* = 0x02
  SUBLANG_UZBEK_LATIN* = 0x01
  SUBLANG_UZBEK_CYRILLIC* = 0x02
  SUBLANG_VALENCIAN_VALENCIA* = 0x02
  SUBLANG_VIETNAMESE_VIETNAM* = 0x01
  SUBLANG_WELSH_UNITED_KINGDOM* = 0x01
  SUBLANG_WOLOF_SENEGAL* = 0x01
  SUBLANG_YORUBA_NIGERIA* = 0x01
  SUBLANG_XHOSA_SOUTH_AFRICA* = 0x01
  SUBLANG_YAKUT_RUSSIA* = 0x01
  SUBLANG_YI_PRC* = 0x01
  SUBLANG_ZULU_SOUTH_AFRICA* = 0x01
  SORT_DEFAULT* = 0x0
  SORT_INVARIANT_MATH* = 0x1
  SORT_JAPANESE_XJIS* = 0x0
  SORT_JAPANESE_UNICODE* = 0x1
  SORT_JAPANESE_RADICALSTROKE* = 0x4
  SORT_CHINESE_BIG5* = 0x0
  SORT_CHINESE_PRCP* = 0x0
  SORT_CHINESE_UNICODE* = 0x1
  SORT_CHINESE_PRC* = 0x2
  SORT_CHINESE_BOPOMOFO* = 0x3
  SORT_CHINESE_RADICALSTROKE* = 0x4
  SORT_KOREAN_KSC* = 0x0
  SORT_KOREAN_UNICODE* = 0x1
  SORT_GERMAN_PHONE_BOOK* = 0x1
  SORT_HUNGARIAN_DEFAULT* = 0x0
  SORT_HUNGARIAN_TECHNICAL* = 0x1
  SORT_GEORGIAN_TRADITIONAL* = 0x0
  SORT_GEORGIAN_MODERN* = 0x1
  LOCALE_NAME_MAX_LENGTH* = 85
template MAKELANGID*(p: untyped, s: untyped): WORD = s.WORD shl 10 or p.WORD
const
  LANG_SYSTEM_DEFAULT* = MAKELANGID(LANG_NEUTRAL,SUBLANG_SYS_DEFAULT)
  LANG_USER_DEFAULT* = MAKELANGID(LANG_NEUTRAL,SUBLANG_DEFAULT)
template MAKELCID*(l: untyped, s: untyped): DWORD = (s.DWORD shl 16) or l.DWORD
const
  LOCALE_SYSTEM_DEFAULT* = MAKELCID(LANG_SYSTEM_DEFAULT,SORT_DEFAULT)
  LOCALE_USER_DEFAULT* = MAKELCID(LANG_USER_DEFAULT,SORT_DEFAULT)
  LOCALE_NEUTRAL* = MAKELCID(MAKELANGID(LANG_NEUTRAL,SUBLANG_NEUTRAL),SORT_DEFAULT)
  LOCALE_CUSTOM_DEFAULT* = MAKELCID(MAKELANGID(LANG_NEUTRAL, SUBLANG_CUSTOM_DEFAULT), SORT_DEFAULT)
  LOCALE_CUSTOM_UNSPECIFIED* = MAKELCID(MAKELANGID(LANG_NEUTRAL, SUBLANG_CUSTOM_UNSPECIFIED), SORT_DEFAULT)
  LOCALE_CUSTOM_UI_DEFAULT* = MAKELCID(MAKELANGID(LANG_NEUTRAL, SUBLANG_UI_CUSTOM_DEFAULT), SORT_DEFAULT)
  LOCALE_INVARIANT* = MAKELCID(MAKELANGID(LANG_INVARIANT,SUBLANG_NEUTRAL),SORT_DEFAULT)
  MAXIMUM_WAIT_OBJECTS* = 64
  MAXIMUM_SUSPEND_COUNT* = MAXCHAR
  EXCEPTION_NONCONTINUABLE* = 0x1
  EXCEPTION_UNWINDING* = 0x2
  EXCEPTION_EXIT_UNWIND* = 0x4
  EXCEPTION_STACK_INVALID* = 0x8
  EXCEPTION_NESTED_CALL* = 0x10
  EXCEPTION_TARGET_UNWIND* = 0x20
  EXCEPTION_COLLIDED_UNWIND* = 0x40
  EXCEPTION_UNWIND* = 0x66
  DELETE* = 0x00010000
  READ_CONTROL* = 0x00020000
  WRITE_DAC* = 0x00040000
  WRITE_OWNER* = 0x00080000
  SYNCHRONIZE* = 0x00100000
  STANDARD_RIGHTS_REQUIRED* = 0x000F0000
  STANDARD_RIGHTS_READ* = READ_CONTROL
  STANDARD_RIGHTS_WRITE* = READ_CONTROL
  STANDARD_RIGHTS_EXECUTE* = READ_CONTROL
  STANDARD_RIGHTS_ALL* = 0x001F0000
  SPECIFIC_RIGHTS_ALL* = 0x0000FFFF
  ACCESS_SYSTEM_SECURITY* = 0x01000000
  MAXIMUM_ALLOWED* = 0x02000000
  GENERIC_READ* = 0x80000000'i32
  GENERIC_WRITE* = 0x40000000
  GENERIC_EXECUTE* = 0x20000000
  GENERIC_ALL* = 0x10000000
  SID_REVISION* = 1
  SID_MAX_SUB_AUTHORITIES* = 15
  SID_RECOMMENDED_SUB_AUTHORITIES* = 1
  sidTypeUser* = 1
  sidTypeGroup* = 2
  sidTypeDomain* = 3
  sidTypeAlias* = 4
  sidTypeWellKnownGroup* = 5
  sidTypeDeletedAccount* = 6
  sidTypeInvalid* = 7
  sidTypeUnknown* = 8
  sidTypeComputer* = 9
  sidTypeLabel* = 10
  SECURITY_NULL_SID_AUTHORITY* = [0'u8,0,0,0,0,0]
  SECURITY_WORLD_SID_AUTHORITY* = [0'u8,0,0,0,0,1]
  SECURITY_LOCAL_SID_AUTHORITY* = [0'u8,0,0,0,0,2]
  SECURITY_CREATOR_SID_AUTHORITY* = [0'u8,0,0,0,0,3]
  SECURITY_NON_UNIQUE_AUTHORITY* = [0'u8,0,0,0,0,4]
  SECURITY_RESOURCE_MANAGER_AUTHORITY* = [0'u8,0,0,0,0,9]
  SECURITY_NULL_RID* = 0x00000000
  SECURITY_WORLD_RID* = 0x00000000
  SECURITY_LOCAL_RID* = 0x00000000
  SECURITY_LOCAL_LOGON_RID* = 0x00000001
  SECURITY_CREATOR_OWNER_RID* = 0x00000000
  SECURITY_CREATOR_GROUP_RID* = 0x00000001
  SECURITY_CREATOR_OWNER_SERVER_RID* = 0x00000002
  SECURITY_CREATOR_GROUP_SERVER_RID* = 0x00000003
  SECURITY_CREATOR_OWNER_RIGHTS_RID* = 0x00000004
  SECURITY_NT_AUTHORITY* = [0'u8,0,0,0,0,5]
  SECURITY_DIALUP_RID* = 0x00000001
  SECURITY_NETWORK_RID* = 0x00000002
  SECURITY_BATCH_RID* = 0x00000003
  SECURITY_INTERACTIVE_RID* = 0x00000004
  SECURITY_LOGON_IDS_RID* = 0x00000005
  SECURITY_LOGON_IDS_RID_COUNT* = 3
  SECURITY_SERVICE_RID* = 0x00000006
  SECURITY_ANONYMOUS_LOGON_RID* = 0x00000007
  SECURITY_PROXY_RID* = 0x00000008
  SECURITY_ENTERPRISE_CONTROLLERS_RID* = 0x00000009
  SECURITY_SERVER_LOGON_RID* = SECURITY_ENTERPRISE_CONTROLLERS_RID
  SECURITY_PRINCIPAL_SELF_RID* = 0x0000000A
  SECURITY_AUTHENTICATED_USER_RID* = 0x0000000B
  SECURITY_RESTRICTED_CODE_RID* = 0x0000000C
  SECURITY_TERMINAL_SERVER_RID* = 0x0000000D
  SECURITY_REMOTE_LOGON_RID* = 0x0000000E
  SECURITY_THIS_ORGANIZATION_RID* = 0x0000000F
  SECURITY_IUSER_RID* = 0x00000011
  SECURITY_LOCAL_SYSTEM_RID* = 0x00000012
  SECURITY_LOCAL_SERVICE_RID* = 0x00000013
  SECURITY_NETWORK_SERVICE_RID* = 0x00000014
  SECURITY_NT_NON_UNIQUE* = 0x00000015
  SECURITY_NT_NON_UNIQUE_SUB_AUTH_COUNT* = 3
  SECURITY_ENTERPRISE_READONLY_CONTROLLERS_RID* = 0x00000016
  SECURITY_BUILTIN_DOMAIN_RID* = 0x00000020
  SECURITY_WRITE_RESTRICTED_CODE_RID* = 0x00000021
  SECURITY_PACKAGE_BASE_RID* = 0x00000040
  SECURITY_PACKAGE_RID_COUNT* = 2
  SECURITY_PACKAGE_NTLM_RID* = 0x0000000A
  SECURITY_PACKAGE_SCHANNEL_RID* = 0x0000000E
  SECURITY_PACKAGE_DIGEST_RID* = 0x00000015
  SECURITY_CRED_TYPE_BASE_RID* = 0x00000041
  SECURITY_CRED_TYPE_RID_COUNT* = 2
  SECURITY_CRED_TYPE_THIS_ORG_CERT_RID* = 0x00000001
  SECURITY_MIN_BASE_RID* = 0x00000050
  SECURITY_SERVICE_ID_BASE_RID* = 0x00000050
  SECURITY_SERVICE_ID_RID_COUNT* = 6
  SECURITY_RESERVED_ID_BASE_RID* = 0x00000051
  SECURITY_APPPOOL_ID_BASE_RID* = 0x00000052
  SECURITY_APPPOOL_ID_RID_COUNT* = 6
  SECURITY_VIRTUALSERVER_ID_BASE_RID* = 0x00000053
  SECURITY_VIRTUALSERVER_ID_RID_COUNT* = 6
  SECURITY_USERMODEDRIVERHOST_ID_BASE_RID* = 0x00000054
  SECURITY_USERMODEDRIVERHOST_ID_RID_COUNT* = 6
  SECURITY_CLOUD_INFRASTRUCTURE_SERVICES_ID_BASE_RID* = 0x00000055
  SECURITY_CLOUD_INFRASTRUCTURE_SERVICES_ID_RID_COUNT* = 6
  SECURITY_WMIHOST_ID_BASE_RID* = 0x00000056
  SECURITY_WMIHOST_ID_RID_COUNT* = 6
  SECURITY_TASK_ID_BASE_RID* = 0x00000057
  SECURITY_NFS_ID_BASE_RID* = 0x00000058
  SECURITY_COM_ID_BASE_RID* = 0x00000059
  SECURITY_WINDOW_MANAGER_BASE_RID* = 0x0000005a
  SECURITY_RDV_GFX_BASE_RID* = 0x0000005b
  SECURITY_DASHOST_ID_BASE_RID* = 0x0000005c
  SECURITY_DASHOST_ID_RID_COUNT* = 6
  SECURITY_VIRTUALACCOUNT_ID_RID_COUNT* = 6
  SECURITY_MAX_BASE_RID* = 0x0000006f
  SECURITY_MAX_ALWAYS_FILTERED* = 0x000003E7
  SECURITY_MIN_NEVER_FILTERED* = 0x000003E8
  SECURITY_OTHER_ORGANIZATION_RID* = 0x000003E8
  SECURITY_WINDOWSMOBILE_ID_BASE_RID* = 0x00000070
  DOMAIN_GROUP_RID_AUTHORIZATION_DATA_IS_COMPOUNDED* = 0x000001f0
  DOMAIN_GROUP_RID_AUTHORIZATION_DATA_CONTAINS_CLAIMS* = 0x000001f1
  DOMAIN_GROUP_RID_ENTERPRISE_READONLY_DOMAIN_CONTROLLERS* = 0x000001f2
  FOREST_USER_RID_MAX* = 0x000001F3
  DOMAIN_USER_RID_ADMIN* = 0x000001F4
  DOMAIN_USER_RID_GUEST* = 0x000001F5
  DOMAIN_USER_RID_KRBTGT* = 0x000001F6
  DOMAIN_USER_RID_MAX* = 0x000003E7
  DOMAIN_GROUP_RID_ADMINS* = 0x00000200
  DOMAIN_GROUP_RID_USERS* = 0x00000201
  DOMAIN_GROUP_RID_GUESTS* = 0x00000202
  DOMAIN_GROUP_RID_COMPUTERS* = 0x00000203
  DOMAIN_GROUP_RID_CONTROLLERS* = 0x00000204
  DOMAIN_GROUP_RID_CERT_ADMINS* = 0x00000205
  DOMAIN_GROUP_RID_SCHEMA_ADMINS* = 0x00000206
  DOMAIN_GROUP_RID_ENTERPRISE_ADMINS* = 0x00000207
  DOMAIN_GROUP_RID_POLICY_ADMINS* = 0x00000208
  DOMAIN_GROUP_RID_READONLY_CONTROLLERS* = 0x00000209
  DOMAIN_GROUP_RID_CLONEABLE_CONTROLLERS* = 0x0000020a
  DOMAIN_ALIAS_RID_ADMINS* = 0x00000220
  DOMAIN_ALIAS_RID_USERS* = 0x00000221
  DOMAIN_ALIAS_RID_GUESTS* = 0x00000222
  DOMAIN_ALIAS_RID_POWER_USERS* = 0x00000223
  DOMAIN_ALIAS_RID_ACCOUNT_OPS* = 0x00000224
  DOMAIN_ALIAS_RID_SYSTEM_OPS* = 0x00000225
  DOMAIN_ALIAS_RID_PRINT_OPS* = 0x00000226
  DOMAIN_ALIAS_RID_BACKUP_OPS* = 0x00000227
  DOMAIN_ALIAS_RID_REPLICATOR* = 0x00000228
  DOMAIN_ALIAS_RID_RAS_SERVERS* = 0x00000229
  DOMAIN_ALIAS_RID_PREW2KCOMPACCESS* = 0x0000022A
  DOMAIN_ALIAS_RID_REMOTE_DESKTOP_USERS* = 0x0000022B
  DOMAIN_ALIAS_RID_NETWORK_CONFIGURATION_OPS* = 0x0000022C
  DOMAIN_ALIAS_RID_INCOMING_FOREST_TRUST_BUILDERS* = 0x0000022D
  DOMAIN_ALIAS_RID_MONITORING_USERS* = 0x0000022E
  DOMAIN_ALIAS_RID_LOGGING_USERS* = 0x0000022F
  DOMAIN_ALIAS_RID_AUTHORIZATIONACCESS* = 0x00000230
  DOMAIN_ALIAS_RID_TS_LICENSE_SERVERS* = 0x00000231
  DOMAIN_ALIAS_RID_DCOM_USERS* = 0x00000232
  DOMAIN_ALIAS_RID_IUSERS* = 0x00000238
  DOMAIN_ALIAS_RID_CRYPTO_OPERATORS* = 0x00000239
  DOMAIN_ALIAS_RID_CACHEABLE_PRINCIPALS_GROUP* = 0x0000023B
  DOMAIN_ALIAS_RID_NON_CACHEABLE_PRINCIPALS_GROUP* = 0x0000023C
  DOMAIN_ALIAS_RID_EVENT_LOG_READERS_GROUP* = 0x0000023D
  DOMAIN_ALIAS_RID_CERTSVC_DCOM_ACCESS_GROUP* = 0x0000023e
  DOMAIN_ALIAS_RID_RDS_REMOTE_ACCESS_SERVERS* = 0x0000023f
  DOMAIN_ALIAS_RID_RDS_ENDPOINT_SERVERS* = 0x00000240
  DOMAIN_ALIAS_RID_RDS_MANAGEMENT_SERVERS* = 0x00000241
  DOMAIN_ALIAS_RID_HYPER_V_ADMINS* = 0x00000242
  DOMAIN_ALIAS_RID_ACCESS_CONTROL_ASSISTANCE_OPS* = 0x00000243
  DOMAIN_ALIAS_RID_REMOTE_MANAGEMENT_USERS* = 0x00000244
  SECURITY_APP_PACKAGE_AUTHORITY* = [0'u8, 0, 0, 0, 0, 15]
  SECURITY_APP_PACKAGE_BASE_RID* = 0x00000002
  SECURITY_BUILTIN_APP_PACKAGE_RID_COUNT* = 2
  SECURITY_APP_PACKAGE_RID_COUNT* = 8
  SECURITY_CAPABILITY_BASE_RID* = 0x00000003
  SECURITY_BUILTIN_CAPABILITY_RID_COUNT* = 2
  SECURITY_CAPABILITY_RID_COUNT* = 5
  SECURITY_BUILTIN_PACKAGE_ANY_PACKAGE* = 0x00000001
  SECURITY_CAPABILITY_INTERNET_CLIENT* = 0x00000001
  SECURITY_CAPABILITY_INTERNET_CLIENT_SERVER* = 0x00000002
  SECURITY_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER* = 0x00000003
  SECURITY_CAPABILITY_PICTURES_LIBRARY* = 0x00000004
  SECURITY_CAPABILITY_VIDEOS_LIBRARY* = 0x00000005
  SECURITY_CAPABILITY_MUSIC_LIBRARY* = 0x00000006
  SECURITY_CAPABILITY_DOCUMENTS_LIBRARY* = 0x00000007
  SECURITY_CAPABILITY_ENTERPRISE_AUTHENTICATION* = 0x00000008
  SECURITY_CAPABILITY_SHARED_USER_CERTIFICATES* = 0x00000009
  SECURITY_CAPABILITY_REMOVABLE_STORAGE* = 0x0000000a
  SECURITY_CAPABILITY_INTERNET_EXPLORER* = 0x00001000
  SECURITY_MANDATORY_LABEL_AUTHORITY* = [0'u8,0,0,0,0,16]
  SECURITY_MANDATORY_UNTRUSTED_RID* = 0x00000000
  SECURITY_MANDATORY_LOW_RID* = 0x00001000
  SECURITY_MANDATORY_MEDIUM_RID* = 0x00002000
  SECURITY_MANDATORY_HIGH_RID* = 0x00003000
  SECURITY_MANDATORY_SYSTEM_RID* = 0x00004000
  SECURITY_MANDATORY_PROTECTED_PROCESS_RID* = 0x00005000
  SECURITY_MANDATORY_MAXIMUM_USER_RID* = SECURITY_MANDATORY_SYSTEM_RID
  SECURITY_SCOPED_POLICY_ID_AUTHORITY* = [0'u8, 0, 0, 0, 0, 17]
  SECURITY_AUTHENTICATION_AUTHORITY* = [0'u8, 0, 0, 0, 0, 18]
  SECURITY_AUTHENTICATION_AUTHORITY_RID_COUNT* = 1
  SECURITY_AUTHENTICATION_AUTHORITY_ASSERTED_RID* = 0x00000001
  SECURITY_AUTHENTICATION_SERVICE_ASSERTED_RID* = 0x00000002
  SECURITY_TRUSTED_INSTALLER_RID1* = 956008885
  SECURITY_TRUSTED_INSTALLER_RID2* = 3418522649
  SECURITY_TRUSTED_INSTALLER_RID3* = 1831038044
  SECURITY_TRUSTED_INSTALLER_RID4* = 1853292631
  SECURITY_TRUSTED_INSTALLER_RID5* = 2271478464
  winNullSid* = 0
  winWorldSid* = 1
  winLocalSid* = 2
  winCreatorOwnerSid* = 3
  winCreatorGroupSid* = 4
  winCreatorOwnerServerSid* = 5
  winCreatorGroupServerSid* = 6
  winNtAuthoritySid* = 7
  winDialupSid* = 8
  winNetworkSid* = 9
  winBatchSid* = 10
  winInteractiveSid* = 11
  winServiceSid* = 12
  winAnonymousSid* = 13
  winProxySid* = 14
  winEnterpriseControllersSid* = 15
  winSelfSid* = 16
  winAuthenticatedUserSid* = 17
  winRestrictedCodeSid* = 18
  winTerminalServerSid* = 19
  winRemoteLogonIdSid* = 20
  winLogonIdsSid* = 21
  winLocalSystemSid* = 22
  winLocalServiceSid* = 23
  winNetworkServiceSid* = 24
  winBuiltinDomainSid* = 25
  winBuiltinAdministratorsSid* = 26
  winBuiltinUsersSid* = 27
  winBuiltinGuestsSid* = 28
  winBuiltinPowerUsersSid* = 29
  winBuiltinAccountOperatorsSid* = 30
  winBuiltinSystemOperatorsSid* = 31
  winBuiltinPrintOperatorsSid* = 32
  winBuiltinBackupOperatorsSid* = 33
  winBuiltinReplicatorSid* = 34
  winBuiltinPreWindows2000CompatibleAccessSid* = 35
  winBuiltinRemoteDesktopUsersSid* = 36
  winBuiltinNetworkConfigurationOperatorsSid* = 37
  winAccountAdministratorSid* = 38
  winAccountGuestSid* = 39
  winAccountKrbtgtSid* = 40
  winAccountDomainAdminsSid* = 41
  winAccountDomainUsersSid* = 42
  winAccountDomainGuestsSid* = 43
  winAccountComputersSid* = 44
  winAccountControllersSid* = 45
  winAccountCertAdminsSid* = 46
  winAccountSchemaAdminsSid* = 47
  winAccountEnterpriseAdminsSid* = 48
  winAccountPolicyAdminsSid* = 49
  winAccountRasAndIasServersSid* = 50
  winNTLMAuthenticationSid* = 51
  winDigestAuthenticationSid* = 52
  winSChannelAuthenticationSid* = 53
  winThisOrganizationSid* = 54
  winOtherOrganizationSid* = 55
  winBuiltinIncomingForestTrustBuildersSid* = 56
  winBuiltinPerfMonitoringUsersSid* = 57
  winBuiltinPerfLoggingUsersSid* = 58
  winBuiltinAuthorizationAccessSid* = 59
  winBuiltinTerminalServerLicenseServersSid* = 60
  winBuiltinDCOMUsersSid* = 61
  winBuiltinIUsersSid* = 62
  winIUserSid* = 63
  winBuiltinCryptoOperatorsSid* = 64
  winUntrustedLabelSid* = 65
  winLowLabelSid* = 66
  winMediumLabelSid* = 67
  winHighLabelSid* = 68
  winSystemLabelSid* = 69
  winWriteRestrictedCodeSid* = 70
  winCreatorOwnerRightsSid* = 71
  winCacheablePrincipalsGroupSid* = 72
  winNonCacheablePrincipalsGroupSid* = 73
  winEnterpriseReadonlyControllersSid* = 74
  winAccountReadonlyControllersSid* = 75
  winBuiltinEventLogReadersGroup* = 76
  winNewEnterpriseReadonlyControllersSid* = 77
  winBuiltinCertSvcDComAccessGroup* = 78
  winMediumPlusLabelSid* = 79
  winLocalLogonSid* = 80
  winConsoleLogonSid* = 81
  winThisOrganizationCertificateSid* = 82
  winApplicationPackageAuthoritySid* = 83
  winBuiltinAnyPackageSid* = 84
  winCapabilityInternetClientSid* = 85
  winCapabilityInternetClientServerSid* = 86
  winCapabilityPrivateNetworkClientServerSid* = 87
  winCapabilityPicturesLibrarySid* = 88
  winCapabilityVideosLibrarySid* = 89
  winCapabilityMusicLibrarySid* = 90
  winCapabilityDocumentsLibrarySid* = 91
  winCapabilitySharedUserCertificatesSid* = 92
  winCapabilityEnterpriseAuthenticationSid* = 93
  winCapabilityRemovableStorageSid* = 94
  winBuiltinRDSRemoteAccessServersSid* = 95
  winBuiltinRDSEndpointServersSid* = 96
  winBuiltinRDSManagementServersSid* = 97
  winUserModeDriversSid* = 98
  winBuiltinHyperVAdminsSid* = 99
  winAccountCloneableControllersSid* = 100
  winBuiltinAccessControlAssistanceOperatorsSid* = 101
  winBuiltinRemoteManagementUsersSid* = 102
  winAuthenticationAuthorityAssertedSid* = 103
  winAuthenticationServiceAssertedSid* = 104
  SE_GROUP_MANDATORY* = 0x00000001
  SE_GROUP_ENABLED_BY_DEFAULT* = 0x00000002
  SE_GROUP_ENABLED* = 0x00000004
  SE_GROUP_OWNER* = 0x00000008
  SE_GROUP_USE_FOR_DENY_ONLY* = 0x00000010
  SE_GROUP_INTEGRITY* = 0x00000020
  SE_GROUP_INTEGRITY_ENABLED* = 0x00000040
  SE_GROUP_LOGON_ID* = 0xC0000000'i32
  SE_GROUP_RESOURCE* = 0x20000000
  SE_GROUP_VALID_ATTRIBUTES* = SE_GROUP_MANDATORY or SE_GROUP_ENABLED_BY_DEFAULT or SE_GROUP_ENABLED or SE_GROUP_OWNER or SE_GROUP_USE_FOR_DENY_ONLY or SE_GROUP_LOGON_ID or SE_GROUP_RESOURCE or SE_GROUP_INTEGRITY or SE_GROUP_INTEGRITY_ENABLED
  ACL_REVISION* = 2
  ACL_REVISION_DS* = 4
  ACL_REVISION1* = 1
  ACL_REVISION2* = 2
  MIN_ACL_REVISION* = ACL_REVISION2
  ACL_REVISION3* = 3
  ACL_REVISION4* = 4
  MAX_ACL_REVISION* = ACL_REVISION4
  ACCESS_MIN_MS_ACE_TYPE* = 0x0
  ACCESS_ALLOWED_ACE_TYPE* = 0x0
  ACCESS_DENIED_ACE_TYPE* = 0x1
  SYSTEM_AUDIT_ACE_TYPE* = 0x2
  SYSTEM_ALARM_ACE_TYPE* = 0x3
  ACCESS_MAX_MS_V2_ACE_TYPE* = 0x3
  ACCESS_ALLOWED_COMPOUND_ACE_TYPE* = 0x4
  ACCESS_MAX_MS_V3_ACE_TYPE* = 0x4
  ACCESS_MIN_MS_OBJECT_ACE_TYPE* = 0x5
  ACCESS_ALLOWED_OBJECT_ACE_TYPE* = 0x5
  ACCESS_DENIED_OBJECT_ACE_TYPE* = 0x6
  SYSTEM_AUDIT_OBJECT_ACE_TYPE* = 0x7
  SYSTEM_ALARM_OBJECT_ACE_TYPE* = 0x8
  ACCESS_MAX_MS_OBJECT_ACE_TYPE* = 0x8
  ACCESS_MAX_MS_V4_ACE_TYPE* = 0x8
  ACCESS_MAX_MS_ACE_TYPE* = 0x8
  ACCESS_ALLOWED_CALLBACK_ACE_TYPE* = 0x9
  ACCESS_DENIED_CALLBACK_ACE_TYPE* = 0xA
  ACCESS_ALLOWED_CALLBACK_OBJECT_ACE_TYPE* = 0xB
  ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE* = 0xC
  SYSTEM_AUDIT_CALLBACK_ACE_TYPE* = 0xD
  SYSTEM_ALARM_CALLBACK_ACE_TYPE* = 0xE
  SYSTEM_AUDIT_CALLBACK_OBJECT_ACE_TYPE* = 0xF
  SYSTEM_ALARM_CALLBACK_OBJECT_ACE_TYPE* = 0x10
  SYSTEM_MANDATORY_LABEL_ACE_TYPE* = 0x11
  SYSTEM_RESOURCE_ATTRIBUTE_ACE_TYPE* = 0x12
  SYSTEM_SCOPED_POLICY_ID_ACE_TYPE* = 0x13
  ACCESS_MAX_MS_V5_ACE_TYPE* = 0x13
  OBJECT_INHERIT_ACE* = 0x1
  CONTAINER_INHERIT_ACE* = 0x2
  NO_PROPAGATE_INHERIT_ACE* = 0x4
  INHERIT_ONLY_ACE* = 0x8
  INHERITED_ACE* = 0x10
  VALID_INHERIT_FLAGS* = 0x1F
  SUCCESSFUL_ACCESS_ACE_FLAG* = 0x40
  FAILED_ACCESS_ACE_FLAG* = 0x80
  SYSTEM_MANDATORY_LABEL_NO_WRITE_UP* = 0x1
  SYSTEM_MANDATORY_LABEL_NO_READ_UP* = 0x2
  SYSTEM_MANDATORY_LABEL_NO_EXECUTE_UP* = 0x4
  SYSTEM_MANDATORY_LABEL_VALID_MASK* = SYSTEM_MANDATORY_LABEL_NO_WRITE_UP or SYSTEM_MANDATORY_LABEL_NO_READ_UP or SYSTEM_MANDATORY_LABEL_NO_EXECUTE_UP
  ACE_OBJECT_TYPE_PRESENT* = 0x1
  ACE_INHERITED_OBJECT_TYPE_PRESENT* = 0x2
  aclRevisionInformation* = 1
  aclSizeInformation* = 2
  SECURITY_DESCRIPTOR_REVISION* = 1
  SECURITY_DESCRIPTOR_REVISION1* = 1
  SE_OWNER_DEFAULTED* = 0x0001
  SE_GROUP_DEFAULTED* = 0x0002
  SE_DACL_PRESENT* = 0x0004
  SE_DACL_DEFAULTED* = 0x0008
  SE_SACL_PRESENT* = 0x0010
  SE_SACL_DEFAULTED* = 0x0020
  SE_DACL_AUTO_INHERIT_REQ* = 0x0100
  SE_SACL_AUTO_INHERIT_REQ* = 0x0200
  SE_DACL_AUTO_INHERITED* = 0x0400
  SE_SACL_AUTO_INHERITED* = 0x0800
  SE_DACL_PROTECTED* = 0x1000
  SE_SACL_PROTECTED* = 0x2000
  SE_RM_CONTROL_VALID* = 0x4000
  SE_SELF_RELATIVE* = 0x8000
  ACCESS_OBJECT_GUID* = 0
  ACCESS_PROPERTY_SET_GUID* = 1
  ACCESS_PROPERTY_GUID* = 2
  ACCESS_MAX_LEVEL* = 4
  auditEventObjectAccess* = 0
  auditEventDirectoryServiceAccess* = 1
  AUDIT_ALLOW_NO_PRIVILEGE* = 0x1
  ACCESS_DS_SOURCE_A* = "DS"
  ACCESS_DS_SOURCE_W* = "DS"
  ACCESS_DS_OBJECT_TYPE_NAME_A* = "Directory Service Object"
  ACCESS_DS_OBJECT_TYPE_NAME_W* = "Directory Service Object"
  SE_PRIVILEGE_ENABLED_BY_DEFAULT* = 0x00000001
  SE_PRIVILEGE_ENABLED* = 0x00000002
  SE_PRIVILEGE_REMOVED* = 0X00000004
  SE_PRIVILEGE_USED_FOR_ACCESS* = 0x80000000'i32
  SE_PRIVILEGE_VALID_ATTRIBUTES* = SE_PRIVILEGE_ENABLED_BY_DEFAULT or SE_PRIVILEGE_ENABLED or SE_PRIVILEGE_REMOVED or SE_PRIVILEGE_USED_FOR_ACCESS
  PRIVILEGE_SET_ALL_NECESSARY* = 1
  ACCESS_REASON_TYPE_MASK* = 0x00ff0000
  ACCESS_REASON_DATA_MASK* = 0x0000ffff
  ACCESS_REASON_STAGING_MASK* = 0x80000000'i32
  ACCESS_REASON_EXDATA_MASK* = 0x7f000000
  accessReasonNone* = 0x00000000
  accessReasonAllowedAce* = 0x00010000
  accessReasonDeniedAce* = 0x00020000
  accessReasonAllowedParentAce* = 0x00030000
  accessReasonDeniedParentAce* = 0x00040000
  accessReasonNotGrantedByCape* = 0x00050000
  accessReasonNotGrantedByParentCape* = 0x00060000
  accessReasonNotGrantedToAppContainer* = 0x00070000
  accessReasonMissingPrivilege* = 0x00100000
  accessReasonFromPrivilege* = 0x00200000
  accessReasonIntegrityLevel* = 0x00300000
  accessReasonOwnership* = 0x00400000
  accessReasonNullDacl* = 0x00500000
  accessReasonEmptyDacl* = 0x00600000
  accessReasonNoSD* = 0x00700000
  accessReasonNoGrant* = 0x00800000
  SE_SECURITY_DESCRIPTOR_FLAG_NO_OWNER_ACE* = 0x00000001
  SE_SECURITY_DESCRIPTOR_FLAG_NO_LABEL_ACE* = 0x00000002
  SE_SECURITY_DESCRIPTOR_VALID_FLAGS* = 0x00000003
  SE_CREATE_TOKEN_NAME* = "SeCreateTokenPrivilege"
  SE_ASSIGNPRIMARYTOKEN_NAME* = "SeAssignPrimaryTokenPrivilege"
  SE_LOCK_MEMORY_NAME* = "SeLockMemoryPrivilege"
  SE_INCREASE_QUOTA_NAME* = "SeIncreaseQuotaPrivilege"
  SE_UNSOLICITED_INPUT_NAME* = "SeUnsolicitedInputPrivilege"
  SE_MACHINE_ACCOUNT_NAME* = "SeMachineAccountPrivilege"
  SE_TCB_NAME* = "SeTcbPrivilege"
  SE_SECURITY_NAME* = "SeSecurityPrivilege"
  SE_TAKE_OWNERSHIP_NAME* = "SeTakeOwnershipPrivilege"
  SE_LOAD_DRIVER_NAME* = "SeLoadDriverPrivilege"
  SE_SYSTEM_PROFILE_NAME* = "SeSystemProfilePrivilege"
  SE_SYSTEMTIME_NAME* = "SeSystemtimePrivilege"
  SE_PROF_SINGLE_PROCESS_NAME* = "SeProfileSingleProcessPrivilege"
  SE_INC_BASE_PRIORITY_NAME* = "SeIncreaseBasePriorityPrivilege"
  SE_CREATE_PAGEFILE_NAME* = "SeCreatePagefilePrivilege"
  SE_CREATE_PERMANENT_NAME* = "SeCreatePermanentPrivilege"
  SE_BACKUP_NAME* = "SeBackupPrivilege"
  SE_RESTORE_NAME* = "SeRestorePrivilege"
  SE_SHUTDOWN_NAME* = "SeShutdownPrivilege"
  SE_DEBUG_NAME* = "SeDebugPrivilege"
  SE_AUDIT_NAME* = "SeAuditPrivilege"
  SE_SYSTEM_ENVIRONMENT_NAME* = "SeSystemEnvironmentPrivilege"
  SE_CHANGE_NOTIFY_NAME* = "SeChangeNotifyPrivilege"
  SE_REMOTE_SHUTDOWN_NAME* = "SeRemoteShutdownPrivilege"
  SE_UNDOCK_NAME* = "SeUndockPrivilege"
  SE_SYNC_AGENT_NAME* = "SeSyncAgentPrivilege"
  SE_ENABLE_DELEGATION_NAME* = "SeEnableDelegationPrivilege"
  SE_MANAGE_VOLUME_NAME* = "SeManageVolumePrivilege"
  SE_IMPERSONATE_NAME* = "SeImpersonatePrivilege"
  SE_CREATE_GLOBAL_NAME* = "SeCreateGlobalPrivilege"
  SE_TRUSTED_CREDMAN_ACCESS_NAME* = "SeTrustedCredManAccessPrivilege"
  SE_RELABEL_NAME* = "SeRelabelPrivilege"
  SE_INC_WORKING_SET_NAME* = "SeIncreaseWorkingSetPrivilege"
  SE_TIME_ZONE_NAME* = "SeTimeZonePrivilege"
  SE_CREATE_SYMBOLIC_LINK_NAME* = "SeCreateSymbolicLinkPrivilege"
  securityAnonymous* = 0
  securityIdentification* = 1
  securityImpersonation* = 2
  securityDelegation* = 3
  SECURITY_MAX_IMPERSONATION_LEVEL* = securityDelegation
  SECURITY_MIN_IMPERSONATION_LEVEL* = securityAnonymous
  DEFAULT_IMPERSONATION_LEVEL* = securityImpersonation
  TOKEN_ASSIGN_PRIMARY* = 0x0001
  TOKEN_DUPLICATE* = 0x0002
  TOKEN_IMPERSONATE* = 0x0004
  TOKEN_QUERY* = 0x0008
  TOKEN_QUERY_SOURCE* = 0x0010
  TOKEN_ADJUST_PRIVILEGES* = 0x0020
  TOKEN_ADJUST_GROUPS* = 0x0040
  TOKEN_ADJUST_DEFAULT* = 0x0080
  TOKEN_ADJUST_SESSIONID* = 0x0100
  TOKEN_ALL_ACCESS_P* = STANDARD_RIGHTS_REQUIRED or TOKEN_ASSIGN_PRIMARY or TOKEN_DUPLICATE or TOKEN_IMPERSONATE or TOKEN_QUERY or TOKEN_QUERY_SOURCE or TOKEN_ADJUST_PRIVILEGES or TOKEN_ADJUST_GROUPS or TOKEN_ADJUST_DEFAULT
  TOKEN_ALL_ACCESS* = TOKEN_ALL_ACCESS_P or TOKEN_ADJUST_SESSIONID
  TOKEN_READ* = STANDARD_RIGHTS_READ or TOKEN_QUERY
  TOKEN_WRITE* = STANDARD_RIGHTS_WRITE or TOKEN_ADJUST_PRIVILEGES or TOKEN_ADJUST_GROUPS or TOKEN_ADJUST_DEFAULT
  TOKEN_EXECUTE* = STANDARD_RIGHTS_EXECUTE
  tokenPrimary* = 1
  tokenImpersonation* = 2
  tokenElevationTypeDefault* = 1
  tokenElevationTypeFull* = 2
  tokenElevationTypeLimited* = 3
  tokenUser* = 1
  tokenGroups* = 2
  tokenPrivileges* = 3
  tokenOwner* = 4
  tokenPrimaryGroup* = 5
  tokenDefaultDacl* = 6
  tokenSource* = 7
  tokenType* = 8
  tokenImpersonationLevel* = 9
  tokenStatistics* = 10
  tokenRestrictedSids* = 11
  tokenSessionId* = 12
  tokenGroupsAndPrivileges* = 13
  tokenSessionReference* = 14
  tokenSandBoxInert* = 15
  tokenAuditPolicy* = 16
  tokenOrigin* = 17
  tokenElevationType* = 18
  tokenLinkedToken* = 19
  tokenElevation* = 20
  tokenHasRestrictions* = 21
  tokenAccessInformation* = 22
  tokenVirtualizationAllowed* = 23
  tokenVirtualizationEnabled* = 24
  tokenIntegrityLevel* = 25
  tokenUIAccess* = 26
  tokenMandatoryPolicy* = 27
  tokenLogonSid* = 28
  tokenIsAppContainer* = 29
  tokenCapabilities* = 30
  tokenAppContainerSid* = 31
  tokenAppContainerNumber* = 32
  tokenUserClaimAttributes* = 33
  tokenDeviceClaimAttributes* = 34
  tokenRestrictedUserClaimAttributes* = 35
  tokenRestrictedDeviceClaimAttributes* = 36
  tokenDeviceGroups* = 37
  tokenRestrictedDeviceGroups* = 38
  tokenSecurityAttributes* = 39
  tokenIsRestricted* = 40
  maxTokenInfoClass* = 41
  TOKEN_MANDATORY_POLICY_OFF* = 0x0
  TOKEN_MANDATORY_POLICY_NO_WRITE_UP* = 0x1
  TOKEN_MANDATORY_POLICY_NEW_PROCESS_MIN* = 0x2
  TOKEN_MANDATORY_POLICY_VALID_MASK* = TOKEN_MANDATORY_POLICY_NO_WRITE_UP or TOKEN_MANDATORY_POLICY_NEW_PROCESS_MIN
  mandatoryLevelUntrusted* = 0
  mandatoryLevelLow* = 1
  mandatoryLevelMedium* = 2
  mandatoryLevelHigh* = 3
  mandatoryLevelSystem* = 4
  mandatoryLevelSecureProcess* = 5
  mandatoryLevelCount* = 6
  CLAIM_SECURITY_ATTRIBUTE_TYPE_INVALID* = 0x00
  CLAIM_SECURITY_ATTRIBUTE_TYPE_INT64* = 0x01
  CLAIM_SECURITY_ATTRIBUTE_TYPE_UINT64* = 0x02
  CLAIM_SECURITY_ATTRIBUTE_TYPE_STRING* = 0x03
  CLAIM_SECURITY_ATTRIBUTE_TYPE_FQBN* = 0x04
  CLAIM_SECURITY_ATTRIBUTE_TYPE_SID* = 0x05
  CLAIM_SECURITY_ATTRIBUTE_TYPE_BOOLEAN* = 0x06
  CLAIM_SECURITY_ATTRIBUTE_TYPE_OCTET_STRING* = 0x10
  CLAIM_SECURITY_ATTRIBUTE_NON_INHERITABLE* = 0x0001
  CLAIM_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE* = 0x0002
  CLAIM_SECURITY_ATTRIBUTE_USE_FOR_DENY_ONLY* = 0x0004
  CLAIM_SECURITY_ATTRIBUTE_DISABLED_BY_DEFAULT* = 0x0008
  CLAIM_SECURITY_ATTRIBUTE_DISABLED* = 0x0010
  CLAIM_SECURITY_ATTRIBUTE_MANDATORY* = 0x0020
  CLAIM_SECURITY_ATTRIBUTE_VALID_FLAGS* = CLAIM_SECURITY_ATTRIBUTE_NON_INHERITABLE or CLAIM_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE or CLAIM_SECURITY_ATTRIBUTE_USE_FOR_DENY_ONLY or CLAIM_SECURITY_ATTRIBUTE_DISABLED_BY_DEFAULT or CLAIM_SECURITY_ATTRIBUTE_DISABLED or CLAIM_SECURITY_ATTRIBUTE_MANDATORY
  CLAIM_SECURITY_ATTRIBUTE_CUSTOM_FLAGS* = 0xffff0000'i32
  CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1* = 1
  CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION* = CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1
  SECURITY_DYNAMIC_TRACKING* = TRUE
  SECURITY_STATIC_TRACKING* = FALSE
  DISABLE_MAX_PRIVILEGE* = 0x1
  SANDBOX_INERT* = 0x2
  LUA_TOKEN* = 0x4
  WRITE_RESTRICTED* = 0x8
  OWNER_SECURITY_INFORMATION* = 0x00000001
  GROUP_SECURITY_INFORMATION* = 0x00000002
  DACL_SECURITY_INFORMATION* = 0x00000004
  SACL_SECURITY_INFORMATION* = 0x00000008
  LABEL_SECURITY_INFORMATION* = 0x00000010
  ATTRIBUTE_SECURITY_INFORMATION* = 0x00000020
  SCOPE_SECURITY_INFORMATION* = 0x00000040
  BACKUP_SECURITY_INFORMATION* = 0x00010000
  PROTECTED_DACL_SECURITY_INFORMATION* = 0x80000000'i32
  PROTECTED_SACL_SECURITY_INFORMATION* = 0x40000000
  UNPROTECTED_DACL_SECURITY_INFORMATION* = 0x20000000
  UNPROTECTED_SACL_SECURITY_INFORMATION* = 0x10000000
  seLearningModeInvalidType* = 0
  seLearningModeSettings* = 1
  seLearningModeMax* = 2
  SE_LEARNING_MODE_FLAG_PERMISSIVE* = 0x00000001
  PROCESS_TERMINATE* = 0x0001
  PROCESS_CREATE_THREAD* = 0x0002
  PROCESS_SET_SESSIONID* = 0x0004
  PROCESS_VM_OPERATION* = 0x0008
  PROCESS_VM_READ* = 0x0010
  PROCESS_VM_WRITE* = 0x0020
  PROCESS_DUP_HANDLE* = 0x0040
  PROCESS_CREATE_PROCESS* = 0x0080
  PROCESS_SET_QUOTA* = 0x0100
  PROCESS_SET_INFORMATION* = 0x0200
  PROCESS_QUERY_INFORMATION* = 0x0400
  PROCESS_SUSPEND_RESUME* = 0x0800
  PROCESS_QUERY_LIMITED_INFORMATION* = 0x1000
  PROCESS_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0xffff
when winimCpu64:
  const
    MAXIMUM_PROC_PER_GROUP* = 64
when winimCpu32:
  const
    MAXIMUM_PROC_PER_GROUP* = 32
const
  MAXIMUM_PROCESSORS* = MAXIMUM_PROC_PER_GROUP
  THREAD_TERMINATE* = 0x0001
  THREAD_SUSPEND_RESUME* = 0x0002
  THREAD_GET_CONTEXT* = 0x0008
  THREAD_SET_CONTEXT* = 0x0010
  THREAD_SET_INFORMATION* = 0x0020
  THREAD_QUERY_INFORMATION* = 0x0040
  THREAD_SET_THREAD_TOKEN* = 0x0080
  THREAD_IMPERSONATE* = 0x0100
  THREAD_DIRECT_IMPERSONATION* = 0x0200
  THREAD_SET_LIMITED_INFORMATION* = 0x0400
  THREAD_QUERY_LIMITED_INFORMATION* = 0x0800
  THREAD_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0xffff
  JOB_OBJECT_ASSIGN_PROCESS* = 0x0001
  JOB_OBJECT_SET_ATTRIBUTES* = 0x0002
  JOB_OBJECT_QUERY* = 0x0004
  JOB_OBJECT_TERMINATE* = 0x0008
  JOB_OBJECT_SET_SECURITY_ATTRIBUTES* = 0x0010
  JOB_OBJECT_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0x1F
  FLS_MAXIMUM_AVAILABLE* = 128
  TLS_MINIMUM_AVAILABLE* = 64
  THREAD_BASE_PRIORITY_LOWRT* = 15
  THREAD_BASE_PRIORITY_MAX* = 2
  THREAD_BASE_PRIORITY_MIN* = -2
  THREAD_BASE_PRIORITY_IDLE* = -15
  QUOTA_LIMITS_HARDWS_MIN_ENABLE* = 0x00000001
  QUOTA_LIMITS_HARDWS_MIN_DISABLE* = 0x00000002
  QUOTA_LIMITS_HARDWS_MAX_ENABLE* = 0x00000004
  QUOTA_LIMITS_HARDWS_MAX_DISABLE* = 0x00000008
  QUOTA_LIMITS_USE_DEFAULT_LIMITS* = 0x00000010
  THREAD_PROFILING_FLAG_DISPATCH* = 0x1
  pMCCounter* = 0
  maxHardwareCounterType* = 1
  processDEPPolicy* = 0
  processASLRPolicy* = 1
  processReserved1MitigationPolicy* = 2
  processStrictHandleCheckPolicy* = 3
  processSystemCallDisablePolicy* = 4
  processMitigationOptionsMask* = 5
  processExtensionPointDisablePolicy* = 6
  maxProcessMitigationPolicy* = 7
  toleranceLow* = 1
  toleranceMedium* = 2
  toleranceHigh* = 3
  toleranceIntervalShort* = 1
  toleranceIntervalMedium* = 2
  toleranceIntervalLong* = 3
  JOB_OBJECT_TERMINATE_AT_END_OF_JOB* = 0
  JOB_OBJECT_POST_AT_END_OF_JOB* = 1
  JOB_OBJECT_MSG_END_OF_JOB_TIME* = 1
  JOB_OBJECT_MSG_END_OF_PROCESS_TIME* = 2
  JOB_OBJECT_MSG_ACTIVE_PROCESS_LIMIT* = 3
  JOB_OBJECT_MSG_ACTIVE_PROCESS_ZERO* = 4
  JOB_OBJECT_MSG_NEW_PROCESS* = 6
  JOB_OBJECT_MSG_EXIT_PROCESS* = 7
  JOB_OBJECT_MSG_ABNORMAL_EXIT_PROCESS* = 8
  JOB_OBJECT_MSG_PROCESS_MEMORY_LIMIT* = 9
  JOB_OBJECT_MSG_JOB_MEMORY_LIMIT* = 10
  JOB_OBJECT_MSG_NOTIFICATION_LIMIT* = 11
  JOB_OBJECT_MSG_JOB_CYCLE_TIME_LIMIT* = 12
  JOB_OBJECT_MSG_MINIMUM* = 1
  JOB_OBJECT_MSG_MAXIMUM* = 12
  JOB_OBJECT_LIMIT_WORKINGSET* = 0x00000001
  JOB_OBJECT_LIMIT_PROCESS_TIME* = 0x00000002
  JOB_OBJECT_LIMIT_JOB_TIME* = 0x00000004
  JOB_OBJECT_LIMIT_ACTIVE_PROCESS* = 0x00000008
  JOB_OBJECT_LIMIT_AFFINITY* = 0x00000010
  JOB_OBJECT_LIMIT_PRIORITY_CLASS* = 0x00000020
  JOB_OBJECT_LIMIT_PRESERVE_JOB_TIME* = 0x00000040
  JOB_OBJECT_LIMIT_SCHEDULING_CLASS* = 0x00000080
  JOB_OBJECT_LIMIT_PROCESS_MEMORY* = 0x00000100
  JOB_OBJECT_LIMIT_JOB_MEMORY* = 0x00000200
  JOB_OBJECT_LIMIT_DIE_ON_UNHANDLED_EXCEPTION* = 0x00000400
  JOB_OBJECT_LIMIT_BREAKAWAY_OK* = 0x00000800
  JOB_OBJECT_LIMIT_SILENT_BREAKAWAY_OK* = 0x00001000
  JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE* = 0x00002000
  JOB_OBJECT_LIMIT_SUBSET_AFFINITY* = 0x00004000
  JOB_OBJECT_LIMIT_RESERVED3* = 0x00008000
  JOB_OBJECT_LIMIT_JOB_READ_BYTES* = 0x00010000
  JOB_OBJECT_LIMIT_JOB_WRITE_BYTES* = 0x00020000
  JOB_OBJECT_LIMIT_RATE_CONTROL* = 0x00040000
  JOB_OBJECT_LIMIT_RESERVED4* = 0x00010000
  JOB_OBJECT_LIMIT_RESERVED5* = 0x00020000
  JOB_OBJECT_LIMIT_RESERVED6* = 0x00040000
  JOB_OBJECT_LIMIT_VALID_FLAGS* = 0x0007ffff
  JOB_OBJECT_BASIC_LIMIT_VALID_FLAGS* = 0x000000ff
  JOB_OBJECT_EXTENDED_LIMIT_VALID_FLAGS* = 0x00007fff
  JOB_OBJECT_RESERVED_LIMIT_VALID_FLAGS* = 0x0007ffff
  JOB_OBJECT_NOTIFICATION_LIMIT_VALID_FLAGS* = 0x00070204
  JOB_OBJECT_UILIMIT_NONE* = 0x00000000
  JOB_OBJECT_UILIMIT_HANDLES* = 0x00000001
  JOB_OBJECT_UILIMIT_READCLIPBOARD* = 0x00000002
  JOB_OBJECT_UILIMIT_WRITECLIPBOARD* = 0x00000004
  JOB_OBJECT_UILIMIT_SYSTEMPARAMETERS* = 0x00000008
  JOB_OBJECT_UILIMIT_DISPLAYSETTINGS* = 0x00000010
  JOB_OBJECT_UILIMIT_GLOBALATOMS* = 0x00000020
  JOB_OBJECT_UILIMIT_DESKTOP* = 0x00000040
  JOB_OBJECT_UILIMIT_EXITWINDOWS* = 0x00000080
  JOB_OBJECT_UILIMIT_ALL* = 0x000000FF
  JOB_OBJECT_UI_VALID_FLAGS* = 0x000000FF
  JOB_OBJECT_SECURITY_NO_ADMIN* = 0x00000001
  JOB_OBJECT_SECURITY_RESTRICTED_TOKEN* = 0x00000002
  JOB_OBJECT_SECURITY_ONLY_TOKEN* = 0x00000004
  JOB_OBJECT_SECURITY_FILTER_TOKENS* = 0x00000008
  JOB_OBJECT_SECURITY_VALID_FLAGS* = 0x0000000f
  JOB_OBJECT_CPU_RATE_CONTROL_ENABLE* = 0x1
  JOB_OBJECT_CPU_RATE_CONTROL_WEIGHT_BASED* = 0x2
  JOB_OBJECT_CPU_RATE_CONTROL_HARD_CAP* = 0x4
  JOB_OBJECT_CPU_RATE_CONTROL_NOTIFY* = 0x8
  JOB_OBJECT_CPU_RATE_CONTROL_VALID_FLAGS* = 0xf
  jobObjectBasicAccountingInformation* = 1
  jobObjectBasicLimitInformation* = 2
  jobObjectBasicProcessIdList* = 3
  jobObjectBasicUIRestrictions* = 4
  jobObjectSecurityLimitInformation* = 5
  jobObjectEndOfJobTimeInformation* = 6
  jobObjectAssociateCompletionPortInformation* = 7
  jobObjectBasicAndIoAccountingInformation* = 8
  jobObjectExtendedLimitInformation* = 9
  jobObjectJobSetInformation* = 10
  jobObjectGroupInformation* = 11
  jobObjectNotificationLimitInformation* = 12
  jobObjectLimitViolationInformation* = 13
  jobObjectGroupInformationEx* = 14
  jobObjectCpuRateControlInformation* = 15
  jobObjectCompletionFilter* = 16
  jobObjectCompletionCounter* = 17
  jobObjectReserved1Information* = 18
  jobObjectReserved2Information* = 19
  jobObjectReserved3Information* = 20
  jobObjectReserved4Information* = 21
  jobObjectReserved5Information* = 22
  jobObjectReserved6Information* = 23
  jobObjectReserved7Information* = 24
  jobObjectReserved8Information* = 25
  maxJobObjectInfoClass* = 26
  firmwareTypeUnknown* = 0
  firmwareTypeBios* = 1
  firmwareTypeUefi* = 2
  firmwareTypeMax* = 3
  EVENT_MODIFY_STATE* = 0x0002
  EVENT_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0x3
  MUTANT_QUERY_STATE* = 0x0001
  MUTANT_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or MUTANT_QUERY_STATE
  SEMAPHORE_MODIFY_STATE* = 0x0002
  SEMAPHORE_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0x3
  TIMER_QUERY_STATE* = 0x0001
  TIMER_MODIFY_STATE* = 0x0002
  TIMER_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or TIMER_QUERY_STATE or TIMER_MODIFY_STATE
  TIME_ZONE_ID_UNKNOWN* = 0
  TIME_ZONE_ID_STANDARD* = 1
  TIME_ZONE_ID_DAYLIGHT* = 2
  relationProcessorCore* = 0
  relationNumaNode* = 1
  relationCache* = 2
  relationProcessorPackage* = 3
  relationGroup* = 4
  relationAll* = 0xffff
  LTP_PC_SMT* = 0x1
  cacheUnified* = 0
  cacheInstruction* = 1
  cacheData* = 2
  cacheTrace* = 3
  CACHE_FULLY_ASSOCIATIVE* = 0xFF
  PROCESSOR_INTEL_386* = 386
  PROCESSOR_INTEL_486* = 486
  PROCESSOR_INTEL_PENTIUM* = 586
  PROCESSOR_INTEL_IA64* = 2200
  PROCESSOR_AMD_X8664* = 8664
  PROCESSOR_MIPS_R4000* = 4000
  PROCESSOR_ALPHA_21064* = 21064
  PROCESSOR_PPC_601* = 601
  PROCESSOR_PPC_603* = 603
  PROCESSOR_PPC_604* = 604
  PROCESSOR_PPC_620* = 620
  PROCESSOR_HITACHI_SH3* = 10003
  PROCESSOR_HITACHI_SH3E* = 10004
  PROCESSOR_HITACHI_SH4* = 10005
  PROCESSOR_MOTOROLA_821* = 821
  PROCESSOR_SHx_SH3* = 103
  PROCESSOR_SHx_SH4* = 104
  PROCESSOR_STRONGARM* = 2577
  PROCESSOR_ARM720* = 1824
  PROCESSOR_ARM820* = 2080
  PROCESSOR_ARM920* = 2336
  PROCESSOR_ARM_7TDMI* = 70001
  PROCESSOR_OPTIL* = 0x494f
  PROCESSOR_ARCHITECTURE_INTEL* = 0
  PROCESSOR_ARCHITECTURE_MIPS* = 1
  PROCESSOR_ARCHITECTURE_ALPHA* = 2
  PROCESSOR_ARCHITECTURE_PPC* = 3
  PROCESSOR_ARCHITECTURE_SHX* = 4
  PROCESSOR_ARCHITECTURE_ARM* = 5
  PROCESSOR_ARCHITECTURE_IA64* = 6
  PROCESSOR_ARCHITECTURE_ALPHA64* = 7
  PROCESSOR_ARCHITECTURE_MSIL* = 8
  PROCESSOR_ARCHITECTURE_AMD64* = 9
  PROCESSOR_ARCHITECTURE_IA32_ON_WIN64* = 10
  PROCESSOR_ARCHITECTURE_NEUTRAL* = 11
  PROCESSOR_ARCHITECTURE_UNKNOWN* = 0xffff
  PF_FLOATING_POINT_PRECISION_ERRATA* = 0
  PF_FLOATING_POINT_EMULATED* = 1
  PF_COMPARE_EXCHANGE_DOUBLE* = 2
  PF_MMX_INSTRUCTIONS_AVAILABLE* = 3
  PF_PPC_MOVEMEM_64BIT_OK* = 4
  PF_ALPHA_BYTE_INSTRUCTIONS* = 5
  PF_XMMI_INSTRUCTIONS_AVAILABLE* = 6
  PF_3DNOW_INSTRUCTIONS_AVAILABLE* = 7
  PF_RDTSC_INSTRUCTION_AVAILABLE* = 8
  PF_PAE_ENABLED* = 9
  PF_XMMI64_INSTRUCTIONS_AVAILABLE* = 10
  PF_SSE_DAZ_MODE_AVAILABLE* = 11
  PF_NX_ENABLED* = 12
  PF_SSE3_INSTRUCTIONS_AVAILABLE* = 13
  PF_COMPARE_EXCHANGE128* = 14
  PF_COMPARE64_EXCHANGE128* = 15
  PF_CHANNELS_ENABLED* = 16
  PF_XSAVE_ENABLED* = 17
  PF_ARM_VFP_32_REGISTERS_AVAILABLE* = 18
  PF_ARM_NEON_INSTRUCTIONS_AVAILABLE* = 19
  PF_SECOND_LEVEL_ADDRESS_TRANSLATION* = 20
  PF_VIRT_FIRMWARE_ENABLED* = 21
  PF_RDWRFSGSBASE_AVAILABLE* = 22
  PF_FASTFAIL_AVAILABLE* = 23
  PF_ARM_DIVIDE_INSTRUCTION_AVAILABLE* = 24
  PF_ARM_64BIT_LOADSTORE_ATOMIC* = 25
  PF_ARM_EXTERNAL_CACHE_AVAILABLE* = 26
  PF_ARM_FMAC_INSTRUCTIONS_AVAILABLE* = 27
  XSTATE_LEGACY_FLOATING_POINT* = 0
  XSTATE_LEGACY_SSE* = 1
  XSTATE_GSSE* = 2
  XSTATE_AVX* = XSTATE_GSSE
  XSTATE_MASK_LEGACY_FLOATING_POINT* = 1 shl (XSTATE_LEGACY_FLOATING_POINT)
  XSTATE_MASK_LEGACY_SSE* = 1 shl (XSTATE_LEGACY_SSE)
  XSTATE_MASK_LEGACY* = XSTATE_MASK_LEGACY_FLOATING_POINT or XSTATE_MASK_LEGACY_SSE
  XSTATE_MASK_GSSE* = 1 shl (XSTATE_GSSE)
  XSTATE_MASK_AVX* = XSTATE_MASK_GSSE
  SECTION_QUERY* = 0x0001
  SECTION_MAP_WRITE* = 0x0002
  SECTION_MAP_READ* = 0x0004
  SECTION_MAP_EXECUTE* = 0x0008
  SECTION_EXTEND_SIZE* = 0x0010
  SECTION_MAP_EXECUTE_EXPLICIT* = 0x0020
  SECTION_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SECTION_QUERY or SECTION_MAP_WRITE or SECTION_MAP_READ or SECTION_MAP_EXECUTE or SECTION_EXTEND_SIZE
  SESSION_QUERY_ACCESS* = 0x1
  SESSION_MODIFY_ACCESS* = 0x2
  SESSION_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SESSION_QUERY_ACCESS or SESSION_MODIFY_ACCESS
  PAGE_NOACCESS* = 0x01
  PAGE_READONLY* = 0x02
  PAGE_READWRITE* = 0x04
  PAGE_WRITECOPY* = 0x08
  PAGE_EXECUTE* = 0x10
  PAGE_EXECUTE_READ* = 0x20
  PAGE_EXECUTE_READWRITE* = 0x40
  PAGE_EXECUTE_WRITECOPY* = 0x80
  PAGE_GUARD* = 0x100
  PAGE_NOCACHE* = 0x200
  PAGE_WRITECOMBINE* = 0x400
  MEM_COMMIT* = 0x1000
  MEM_RESERVE* = 0x2000
  MEM_DECOMMIT* = 0x4000
  MEM_RELEASE* = 0x8000
  MEM_FREE* = 0x10000
  MEM_PRIVATE* = 0x20000
  MEM_MAPPED* = 0x40000
  MEM_RESET* = 0x80000
  MEM_TOP_DOWN* = 0x100000
  MEM_WRITE_WATCH* = 0x200000
  MEM_PHYSICAL* = 0x400000
  MEM_ROTATE* = 0x800000
  MEM_LARGE_PAGES* = 0x20000000
  MEM_4MB_PAGES* = 0x80000000'i32
  SEC_FILE* = 0x800000
  SEC_IMAGE* = 0x1000000
  SEC_PROTECTED_IMAGE* = 0x2000000
  SEC_RESERVE* = 0x4000000
  SEC_COMMIT* = 0x8000000
  SEC_NOCACHE* = 0x10000000
  SEC_WRITECOMBINE* = 0x40000000
  SEC_LARGE_PAGES* = 0x80000000'i32
  SEC_IMAGE_NO_EXECUTE* = SEC_IMAGE or SEC_NOCACHE
  MEM_IMAGE* = SEC_IMAGE
  WRITE_WATCH_FLAG_RESET* = 0x01
  MEM_UNMAP_WITH_TRANSIENT_BOOST* = 0x01
  FILE_READ_DATA* = 0x0001
  FILE_LIST_DIRECTORY* = 0x0001
  FILE_WRITE_DATA* = 0x0002
  FILE_ADD_FILE* = 0x0002
  FILE_APPEND_DATA* = 0x0004
  FILE_ADD_SUBDIRECTORY* = 0x0004
  FILE_CREATE_PIPE_INSTANCE* = 0x0004
  FILE_READ_EA* = 0x0008
  FILE_WRITE_EA* = 0x0010
  FILE_EXECUTE* = 0x0020
  FILE_TRAVERSE* = 0x0020
  FILE_DELETE_CHILD* = 0x0040
  FILE_READ_ATTRIBUTES* = 0x0080
  FILE_WRITE_ATTRIBUTES* = 0x0100
  FILE_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0x1FF
  FILE_GENERIC_READ* = STANDARD_RIGHTS_READ or FILE_READ_DATA or FILE_READ_ATTRIBUTES or FILE_READ_EA or SYNCHRONIZE
  FILE_GENERIC_WRITE* = STANDARD_RIGHTS_WRITE or FILE_WRITE_DATA or FILE_WRITE_ATTRIBUTES or FILE_WRITE_EA or FILE_APPEND_DATA or SYNCHRONIZE
  FILE_GENERIC_EXECUTE* = STANDARD_RIGHTS_EXECUTE or FILE_READ_ATTRIBUTES or FILE_EXECUTE or SYNCHRONIZE
  FILE_ATTRIBUTE_READONLY* = 0x00000001
  FILE_ATTRIBUTE_HIDDEN* = 0x00000002
  FILE_ATTRIBUTE_SYSTEM* = 0x00000004
  FILE_ATTRIBUTE_DIRECTORY* = 0x00000010
  FILE_ATTRIBUTE_ARCHIVE* = 0x00000020
  FILE_ATTRIBUTE_DEVICE* = 0x00000040
  FILE_ATTRIBUTE_NORMAL* = 0x00000080
  FILE_ATTRIBUTE_TEMPORARY* = 0x00000100
  FILE_ATTRIBUTE_SPARSE_FILE* = 0x00000200
  FILE_ATTRIBUTE_REPARSE_POINT* = 0x00000400
  FILE_ATTRIBUTE_COMPRESSED* = 0x00000800
  FILE_ATTRIBUTE_OFFLINE* = 0x00001000
  FILE_ATTRIBUTE_NOT_CONTENT_INDEXED* = 0x00002000
  FILE_ATTRIBUTE_ENCRYPTED* = 0x00004000
  FILE_ATTRIBUTE_VIRTUAL* = 0x00010000
  FILE_NOTIFY_CHANGE_FILE_NAME* = 0x00000001
  FILE_NOTIFY_CHANGE_DIR_NAME* = 0x00000002
  FILE_NOTIFY_CHANGE_ATTRIBUTES* = 0x00000004
  FILE_NOTIFY_CHANGE_SIZE* = 0x00000008
  FILE_NOTIFY_CHANGE_LAST_WRITE* = 0x00000010
  FILE_NOTIFY_CHANGE_LAST_ACCESS* = 0x00000020
  FILE_NOTIFY_CHANGE_CREATION* = 0x00000040
  FILE_NOTIFY_CHANGE_SECURITY* = 0x00000100
  FILE_ACTION_ADDED* = 0x00000001
  FILE_ACTION_REMOVED* = 0x00000002
  FILE_ACTION_MODIFIED* = 0x00000003
  FILE_ACTION_RENAMED_OLD_NAME* = 0x00000004
  FILE_ACTION_RENAMED_NEW_NAME* = 0x00000005
  MAILSLOT_NO_MESSAGE* = DWORD(-1)
  MAILSLOT_WAIT_FOREVER* = DWORD(-1)
  FILE_CASE_SENSITIVE_SEARCH* = 0x00000001
  FILE_CASE_PRESERVED_NAMES* = 0x00000002
  FILE_UNICODE_ON_DISK* = 0x00000004
  FILE_PERSISTENT_ACLS* = 0x00000008
  FILE_FILE_COMPRESSION* = 0x00000010
  FILE_VOLUME_QUOTAS* = 0x00000020
  FILE_SUPPORTS_SPARSE_FILES* = 0x00000040
  FILE_SUPPORTS_REPARSE_POINTS* = 0x00000080
  FILE_SUPPORTS_REMOTE_STORAGE* = 0x00000100
  FILE_VOLUME_IS_COMPRESSED* = 0x00008000
  FILE_SUPPORTS_OBJECT_IDS* = 0x00010000
  FILE_SUPPORTS_ENCRYPTION* = 0x00020000
  FILE_NAMED_STREAMS* = 0x00040000
  FILE_READ_ONLY_VOLUME* = 0x00080000
  FILE_SEQUENTIAL_WRITE_ONCE* = 0x00100000
  FILE_SUPPORTS_TRANSACTIONS* = 0x00200000
  FILE_SUPPORTS_HARD_LINKS* = 0x00400000
  FILE_SUPPORTS_EXTENDED_ATTRIBUTES* = 0x00800000
  FILE_SUPPORTS_OPEN_BY_FILE_ID* = 0x01000000
  FILE_SUPPORTS_USN_JOURNAL* = 0x02000000
  FILE_SUPPORTS_INTEGRITY_STREAMS* = 0x04000000
  MAXIMUM_REPARSE_DATA_BUFFER_SIZE* = 16*1024
  SYMLINK_FLAG_RELATIVE* = 1
  IO_REPARSE_TAG_RESERVED_ZERO* = 0
  IO_REPARSE_TAG_RESERVED_ONE* = 1
  IO_REPARSE_TAG_RESERVED_RANGE* = IO_REPARSE_TAG_RESERVED_ONE
  IO_REPARSE_TAG_MOUNT_POINT* = 0xA0000003'i32
  IO_REPARSE_TAG_HSM* = 0xC0000004'i32
  IO_REPARSE_TAG_HSM2* = 0x80000006'i32
  IO_REPARSE_TAG_SIS* = 0x80000007'i32
  IO_REPARSE_TAG_WIM* = 0x80000008'i32
  IO_REPARSE_TAG_CSV* = 0x80000009'i32
  IO_REPARSE_TAG_DFS* = 0x8000000A'i32
  IO_REPARSE_TAG_FILTER_MANAGER* = 0x8000000B'i32
  IO_REPARSE_TAG_DFSR* = 0x80000012'i32
  IO_REPARSE_TAG_SYMLINK* = 0xA000000C'i32
  IO_REPARSE_TAG_IIS_CACHE* = 0xA0000010'i32
  IO_REPARSE_TAG_DRIVE_EXTENDER* = 0x80000005'i32
  IO_REPARSE_TAG_DEDUP* = 0x80000013'i32
  IO_REPARSE_TAG_NFS* = 0x80000014'i32
  SCRUB_DATA_INPUT_FLAG_RESUME* = 0x00000001
  SCRUB_DATA_INPUT_FLAG_SKIP_IN_SYNC* = 0x00000002
  SCRUB_DATA_INPUT_FLAG_SKIP_NON_INTEGRITY_DATA* = 0x00000004
  SCRUB_DATA_OUTPUT_FLAG_INCOMPLETE* = 0x00000001
  SCRUB_DATA_OUTPUT_FLAG_NON_USER_DATA_RANGE* = 0x00010000
  IO_COMPLETION_MODIFY_STATE* = 0x0002
  IO_COMPLETION_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0x3
  DUPLICATE_CLOSE_SOURCE* = 0x00000001
  DUPLICATE_SAME_ACCESS* = 0x00000002
  POWERBUTTON_ACTION_INDEX_NOTHING* = 0
  POWERBUTTON_ACTION_INDEX_SLEEP* = 1
  POWERBUTTON_ACTION_INDEX_HIBERNATE* = 2
  POWERBUTTON_ACTION_INDEX_SHUTDOWN* = 3
  POWERBUTTON_ACTION_VALUE_NOTHING* = 0
  POWERBUTTON_ACTION_VALUE_SLEEP* = 2
  POWERBUTTON_ACTION_VALUE_HIBERNATE* = 3
  POWERBUTTON_ACTION_VALUE_SHUTDOWN* = 6
  PERFSTATE_POLICY_CHANGE_IDEAL* = 0
  PERFSTATE_POLICY_CHANGE_SINGLE* = 1
  PERFSTATE_POLICY_CHANGE_ROCKET* = 2
  PERFSTATE_POLICY_CHANGE_MAX* = PERFSTATE_POLICY_CHANGE_ROCKET
  PROCESSOR_PERF_BOOST_POLICY_DISABLED* = 0
  PROCESSOR_PERF_BOOST_POLICY_MAX* = 100
  PROCESSOR_PERF_BOOST_MODE_DISABLED* = 0
  PROCESSOR_PERF_BOOST_MODE_ENABLED* = 1
  PROCESSOR_PERF_BOOST_MODE_AGGRESSIVE* = 2
  PROCESSOR_PERF_BOOST_MODE_EFFICIENT_ENABLED* = 3
  PROCESSOR_PERF_BOOST_MODE_EFFICIENT_AGGRESSIVE* = 4
  PROCESSOR_PERF_BOOST_MODE_MAX* = PROCESSOR_PERF_BOOST_MODE_EFFICIENT_AGGRESSIVE
  CORE_PARKING_POLICY_CHANGE_IDEAL* = 0
  CORE_PARKING_POLICY_CHANGE_SINGLE* = 1
  CORE_PARKING_POLICY_CHANGE_ROCKET* = 2
  CORE_PARKING_POLICY_CHANGE_MULTISTEP* = 3
  CORE_PARKING_POLICY_CHANGE_MAX* = CORE_PARKING_POLICY_CHANGE_MULTISTEP
  POWER_DEVICE_IDLE_POLICY_PERFORMANCE* = 0
  POWER_DEVICE_IDLE_POLICY_CONSERVATIVE* = 1
  GUID_MAX_POWER_SAVINGS* = DEFINE_GUID("a1841308-3541-4fab-bc81-f71556f20b4a")
  GUID_MIN_POWER_SAVINGS* = DEFINE_GUID("8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c")
  GUID_TYPICAL_POWER_SAVINGS* = DEFINE_GUID("381b4222-f694-41f0-9685-ff5bb260df2e")
  NO_SUBGROUP_GUID* = DEFINE_GUID("fea3413e-7e05-4911-9a71-700331f1c294")
  ALL_POWERSCHEMES_GUID* = DEFINE_GUID("68a1e95e-13ea-41e1-8011-0c496ca490b0")
  GUID_POWERSCHEME_PERSONALITY* = DEFINE_GUID("245d8541-3943-4422-b025-13a784f679b7")
  GUID_ACTIVE_POWERSCHEME* = DEFINE_GUID("31f9f286-5084-42fe-b720-2b0264993763")
  GUID_IDLE_RESILIENCY_SUBGROUP* = DEFINE_GUID("2e601130-5351-4d9d-8e04-252966bad054")
  GUID_IDLE_RESILIENCY_PERIOD* = DEFINE_GUID("c42b79aa-aa3a-484b-a98f-2cf32aa90a28")
  GUID_DISK_COALESCING_POWERDOWN_TIMEOUT* = DEFINE_GUID("c36f0eb4-2988-4a70-8eee-0884fc2c2433")
  GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT* = DEFINE_GUID("3166bc41-7e98-4e03-b34e-ec0f5f2b218e")
  GUID_VIDEO_SUBGROUP* = DEFINE_GUID("7516b95f-f776-4464-8c53-06167f40cc99")
  GUID_VIDEO_POWERDOWN_TIMEOUT* = DEFINE_GUID("3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e")
  GUID_VIDEO_ANNOYANCE_TIMEOUT* = DEFINE_GUID("82dbcf2d-cd67-40c5-bfdc-9f1a5ccd4663")
  GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE* = DEFINE_GUID("eed904df-b142-4183-b10b-5a1197a37864")
  GUID_VIDEO_DIM_TIMEOUT* = DEFINE_GUID("17aaa29b-8b43-4b94-aafe-35f64daaf1ee")
  GUID_VIDEO_ADAPTIVE_POWERDOWN* = DEFINE_GUID("90959d22-d6a1-49b9-af93-bce885ad335b")
  GUID_MONITOR_POWER_ON* = DEFINE_GUID("02731015-4510-4526-99e6-e5a17ebd1aea")
  GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS* = DEFINE_GUID("aded5e82-b909-4619-9949-f5d71dac0bcb")
  GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS* = DEFINE_GUID("f1fbfde2-a960-4165-9f88-50667911ce96")
  GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS* = DEFINE_GUID("8ffee2c6-2d01-46be-adb9-398addc5b4ff")
  GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS* = DEFINE_GUID("fbd9aa66-9553-4097-ba44-ed6e9d65eab8")
  GUID_CONSOLE_DISPLAY_STATE* = DEFINE_GUID("6fe69556-704a-47a0-8f24-c28d936fda47")
  GUID_ALLOW_DISPLAY_REQUIRED* = DEFINE_GUID("a9ceb8da-cd46-44fb-a98b-02af69de4623")
  GUID_VIDEO_CONSOLE_LOCK_TIMEOUT* = DEFINE_GUID("8ec4b3a5-6868-48c2-be75-4f3044be88a7")
  GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP* = DEFINE_GUID("8619b916-e004-4dd8-9b66-dae86f806698")
  GUID_NON_ADAPTIVE_INPUT_TIMEOUT* = DEFINE_GUID("5adbbfbc-074e-4da1-ba38-db8b36b2c8f3")
  GUID_DISK_SUBGROUP* = DEFINE_GUID("0012ee47-9041-4b5d-9b77-535fba8b1442")
  GUID_DISK_POWERDOWN_TIMEOUT* = DEFINE_GUID("6738e2c4-e8a5-4a42-b16a-e040e769756e")
  GUID_DISK_IDLE_TIMEOUT* = DEFINE_GUID("58e39ba8-b8e6-4ef6-90d0-89ae32b258d6")
  GUID_DISK_BURST_IGNORE_THRESHOLD* = DEFINE_GUID("80e3c60e-bb94-4ad8-bbe0-0d3195efc663")
  GUID_DISK_ADAPTIVE_POWERDOWN* = DEFINE_GUID("396a32e1-499a-40b2-9124-a96afe707667")
  GUID_SLEEP_SUBGROUP* = DEFINE_GUID("238c9fa8-0aad-41ed-83f4-97be242c8f20")
  GUID_SLEEP_IDLE_THRESHOLD* = DEFINE_GUID("81cd32e0-7833-44f3-8737-7081f38d1f70")
  GUID_STANDBY_TIMEOUT* = DEFINE_GUID("29f6c1db-86da-48c5-9fdb-f2b67b1f44da")
  GUID_UNATTEND_SLEEP_TIMEOUT* = DEFINE_GUID("7bc4a2f9-d8fc-4469-b07b-33eb785aaca0")
  GUID_HIBERNATE_TIMEOUT* = DEFINE_GUID("9d7815a6-7ee4-497e-8888-515a05f02364")
  GUID_HIBERNATE_FASTS4_POLICY* = DEFINE_GUID("94ac6d29-73ce-41a6-809f-6363ba21b47e")
  GUID_CRITICAL_POWER_TRANSITION* = DEFINE_GUID("b7a27025-e569-46c2-a504-2b96cad225a1")
  GUID_SYSTEM_AWAYMODE* = DEFINE_GUID("98a7f580-01f7-48aa-9c0f-44352c29e5c0")
  GUID_ALLOW_AWAYMODE* = DEFINE_GUID("25dfa149-5dd1-4736-b5ab-e8a37b5b8187")
  GUID_ALLOW_STANDBY_STATES* = DEFINE_GUID("abfc2519-3608-4c2a-94ea-171b0ed546ab")
  GUID_ALLOW_RTC_WAKE* = DEFINE_GUID("bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d")
  GUID_ALLOW_SYSTEM_REQUIRED* = DEFINE_GUID("a4b195f5-8225-47d8-8012-9d41369786e2")
  GUID_SYSTEM_BUTTON_SUBGROUP* = DEFINE_GUID("4f971e89-eebd-4455-a8de-9e59040e7347")
  GUID_POWERBUTTON_ACTION* = DEFINE_GUID("7648efa3-dd9c-4e3e-b566-50f929386280")
  GUID_SLEEPBUTTON_ACTION* = DEFINE_GUID("96996bc0-ad50-47ec-923b-6f41874dd9eb")
  GUID_USERINTERFACEBUTTON_ACTION* = DEFINE_GUID("a7066653-8d6c-40a8-910e-a1f54b84c7e5")
  GUID_LIDCLOSE_ACTION* = DEFINE_GUID("5ca83367-6e45-459f-a27b-476b1d01c936")
  GUID_LIDOPEN_POWERSTATE* = DEFINE_GUID("99ff10e7-23b1-4c07-a9d1-5c3206d741b4")
  GUID_BATTERY_SUBGROUP* = DEFINE_GUID("e73a048d-bf27-4f12-9731-8b2076e8891f")
  GUID_BATTERY_DISCHARGE_ACTION_0* = DEFINE_GUID("637ea02f-bbcb-4015-8e2c-a1c7b9c0b546")
  GUID_BATTERY_DISCHARGE_LEVEL_0* = DEFINE_GUID("9a66d8d7-4ff7-4ef9-b5a2-5a326ca2a469")
  GUID_BATTERY_DISCHARGE_FLAGS_0* = DEFINE_GUID("5dbb7c9f-38e9-40d2-9749-4f8a0e9f640f")
  GUID_BATTERY_DISCHARGE_ACTION_1* = DEFINE_GUID("d8742dcb-3e6a-4b3c-b3fe-374623cdcf06")
  GUID_BATTERY_DISCHARGE_LEVEL_1* = DEFINE_GUID("8183ba9a-e910-48da-8769-14ae6dc1170a")
  GUID_BATTERY_DISCHARGE_FLAGS_1* = DEFINE_GUID("bcded951-187b-4d05-bccc-f7e51960c258")
  GUID_BATTERY_DISCHARGE_ACTION_2* = DEFINE_GUID("421cba38-1a8e-4881-ac89-e33a8b04ece4")
  GUID_BATTERY_DISCHARGE_LEVEL_2* = DEFINE_GUID("07a07ca2-adaf-40d7-b077-533aaded1bfa")
  GUID_BATTERY_DISCHARGE_FLAGS_2* = DEFINE_GUID("7fd2f0c4-feb7-4da3-8117-e3fbedc46582")
  GUID_BATTERY_DISCHARGE_ACTION_3* = DEFINE_GUID("80472613-9780-455e-b308-72d3003cf2f8")
  GUID_BATTERY_DISCHARGE_LEVEL_3* = DEFINE_GUID("58afd5a6-c2dd-47d2-9fbf-ef70cc5c5965")
  GUID_BATTERY_DISCHARGE_FLAGS_3* = DEFINE_GUID("73613ccf-dbfa-4279-8356-4935f6bf62f3")
  GUID_PROCESSOR_SETTINGS_SUBGROUP* = DEFINE_GUID("54533251-82be-4824-96c1-47b60b740d00")
  GUID_PROCESSOR_THROTTLE_POLICY* = DEFINE_GUID("57027304-4af6-4104-9260-e3d95248fc36")
  GUID_PROCESSOR_THROTTLE_MAXIMUM* = DEFINE_GUID("bc5038f7-23e0-4960-96da-33abaf5935ec")
  GUID_PROCESSOR_THROTTLE_MINIMUM* = DEFINE_GUID("893dee8e-2bef-41e0-89c6-b55d0929964c")
  GUID_PROCESSOR_ALLOW_THROTTLING* = DEFINE_GUID("3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb")
  GUID_PROCESSOR_IDLESTATE_POLICY* = DEFINE_GUID("68f262a7-f621-4069-b9a5-4874169be23c")
  GUID_PROCESSOR_PERFSTATE_POLICY* = DEFINE_GUID("bbdc3814-18e9-4463-8a55-d197327c45c0")
  GUID_PROCESSOR_PERF_INCREASE_THRESHOLD* = DEFINE_GUID("06cadf0e-64ed-448a-8927-ce7bf90eb35d")
  GUID_PROCESSOR_PERF_DECREASE_THRESHOLD* = DEFINE_GUID("12a0ab44-fe28-4fa9-b3bd-4b64f44960a6")
  GUID_PROCESSOR_PERF_INCREASE_POLICY* = DEFINE_GUID("465e1f50-b610-473a-ab58-00d1077dc418")
  GUID_PROCESSOR_PERF_DECREASE_POLICY* = DEFINE_GUID("40fbefc7-2e9d-4d25-a185-0cfd8574bac6")
  GUID_PROCESSOR_PERF_INCREASE_TIME* = DEFINE_GUID("984cf492-3bed-4488-a8f9-4286c97bf5aa")
  GUID_PROCESSOR_PERF_DECREASE_TIME* = DEFINE_GUID("d8edeb9b-95cf-4f95-a73c-b061973693c8")
  GUID_PROCESSOR_PERF_TIME_CHECK* = DEFINE_GUID("4d2b0152-7d5c-498b-88e2-34345392a2c5")
  GUID_PROCESSOR_PERF_BOOST_POLICY* = DEFINE_GUID("45bcc044-d885-43e2-8605-ee0ec6e96b59")
  GUID_PROCESSOR_PERF_BOOST_MODE* = DEFINE_GUID("be337238-0d82-4146-a960-4f3749d470c7")
  GUID_PROCESSOR_IDLE_ALLOW_SCALING* = DEFINE_GUID("6c2993b0-8f48-481f-bcc6-00dd2742aa06")
  GUID_PROCESSOR_IDLE_DISABLE* = DEFINE_GUID("5d76a2ca-e8c0-402f-a133-2158492d58ad")
  GUID_PROCESSOR_IDLE_STATE_MAXIMUM* = DEFINE_GUID("9943e905-9a30-4ec1-9b99-44dd3b76f7a2")
  GUID_PROCESSOR_IDLE_TIME_CHECK* = DEFINE_GUID("c4581c31-89ab-4597-8e2b-9c9cab440e6b")
  GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD* = DEFINE_GUID("4b92d758-5a24-4851-a470-815d78aee119")
  GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD* = DEFINE_GUID("7b224883-b3cc-4d79-819f-8374152cbe7c")
  GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD* = DEFINE_GUID("df142941-20f3-4edf-9a4a-9c83d3d717d1")
  GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD* = DEFINE_GUID("68dd2f27-a4ce-4e11-8487-3794e4135dfa")
  GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY* = DEFINE_GUID("c7be0679-2817-4d69-9d02-519a537ed0c6")
  GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY* = DEFINE_GUID("71021b41-c749-4d21-be74-a00f335d582b")
  GUID_PROCESSOR_CORE_PARKING_MAX_CORES* = DEFINE_GUID("ea062031-0e34-4ff1-9b6d-eb1059334028")
  GUID_PROCESSOR_CORE_PARKING_MIN_CORES* = DEFINE_GUID("0cc5b647-c1df-4637-891a-dec35c318583")
  GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME* = DEFINE_GUID("2ddd5a84-5a71-437e-912a-db0b8c788732")
  GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME* = DEFINE_GUID("dfd10d17-d5eb-45dd-877a-9a34ddd15c82")
  GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR* = DEFINE_GUID("8f7b45e3-c393-480a-878c-f67ac3d07082")
  GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD* = DEFINE_GUID("5b33697b-e89d-4d38-aa46-9e7dfb7cd2f9")
  GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING* = DEFINE_GUID("e70867f1-fa2f-4f4e-aea1-4d8a0ba23b20")
  GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR* = DEFINE_GUID("1299023c-bc28-4f0a-81ec-d3295a8d815d")
  GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD* = DEFINE_GUID("9ac18e92-aa3c-4e27-b307-01ae37307129")
  GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING* = DEFINE_GUID("8809c2d8-b155-42d4-bcda-0d345651b1db")
  GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD* = DEFINE_GUID("943c8cb6-6f93-4227-ad87-e9a3feec08d1")
  GUID_PROCESSOR_PARKING_CORE_OVERRIDE* = DEFINE_GUID("a55612aa-f624-42c6-a443-7397d064c04f")
  GUID_PROCESSOR_PARKING_PERF_STATE* = DEFINE_GUID("447235c7-6a8d-4cc0-8e24-9eaf70b96e2b")
  GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD* = DEFINE_GUID("2430ab6f-a520-44a2-9601-f7f23b5134b1")
  GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD* = DEFINE_GUID("f735a673-2066-4f80-a0c5-ddee0cf1bf5d")
  GUID_PROCESSOR_PERF_HISTORY* = DEFINE_GUID("7d24baa7-0b84-480f-840c-1b0743c00f5f")
  GUID_PROCESSOR_PERF_LATENCY_HINT* = DEFINE_GUID("0822df31-9c83-441c-a079-0de4cf009c7b")
  GUID_PROCESSOR_DISTRIBUTE_UTILITY* = DEFINE_GUID("e0007330-f589-42ed-a401-5ddb10e785d3")
  GUID_SYSTEM_COOLING_POLICY* = DEFINE_GUID("94d3a615-a899-4ac5-ae2b-e4d8f634367f")
  GUID_LOCK_CONSOLE_ON_WAKE* = DEFINE_GUID("0e796bdb-100d-47d6-a2d5-f7d2daa51f51")
  GUID_DEVICE_IDLE_POLICY* = DEFINE_GUID("4faab71a-92e5-4726-b531-224559672d19")
  GUID_ACDC_POWER_SOURCE* = DEFINE_GUID("5d3e9a59-e9d5-4b00-a6bd-ff34ff516548")
  GUID_LIDSWITCH_STATE_CHANGE* = DEFINE_GUID("ba3e0f4d-b817-4094-a2d1-d56379e6a0f3")
  GUID_BATTERY_PERCENTAGE_REMAINING* = DEFINE_GUID("a7ad8041-b45a-4cae-87a3-eecbb468a9e1")
  GUID_GLOBAL_USER_PRESENCE* = DEFINE_GUID("786e8a1d-b427-4344-9207-09e70bdcbea9")
  GUID_SESSION_DISPLAY_STATUS* = DEFINE_GUID("2b84c20e-ad23-4ddf-93db-05ffbd7efca5")
  GUID_SESSION_USER_PRESENCE* = DEFINE_GUID("3c0f4548-c03f-4c4d-b9f2-237ede686376")
  GUID_IDLE_BACKGROUND_TASK* = DEFINE_GUID("515c31d8-f734-163d-a0fd-11a08c91e8f1")
  GUID_BACKGROUND_TASK_NOTIFICATION* = DEFINE_GUID("cf23f240-2a54-48d8-b114-de1518ff052e")
  GUID_APPLAUNCH_BUTTON* = DEFINE_GUID("1a689231-7399-4e9a-8f99-b71f999db3fa")
  GUID_PCIEXPRESS_SETTINGS_SUBGROUP* = DEFINE_GUID("501a4d13-42af-4429-9fd1-a8218c268e20")
  GUID_PCIEXPRESS_ASPM_POLICY* = DEFINE_GUID("ee12f906-d277-404b-b6da-e5fa1a576df5")
  GUID_ENABLE_SWITCH_FORCED_SHUTDOWN* = DEFINE_GUID("833a6b62-dfa4-46d1-82f8-e09e34d029d6")
  powerSystemUnspecified* = 0
  powerSystemWorking* = 1
  powerSystemSleeping1* = 2
  powerSystemSleeping2* = 3
  powerSystemSleeping3* = 4
  powerSystemHibernate* = 5
  powerSystemShutdown* = 6
  powerSystemMaximum* = 7
  powerActionNone* = 0
  powerActionReserved* = 1
  powerActionSleep* = 2
  powerActionHibernate* = 3
  powerActionShutdown* = 4
  powerActionShutdownReset* = 5
  powerActionShutdownOff* = 6
  powerActionWarmEject* = 7
  powerDeviceUnspecified* = 0
  powerDeviceD0* = 1
  powerDeviceD1* = 2
  powerDeviceD2* = 3
  powerDeviceD3* = 4
  powerDeviceMaximum* = 5
  powerMonitorOff* = 0
  powerMonitorOn* = 1
  powerMonitorDim* = 2
  powerUserPresent* = 0
  powerUserNotPresent* = 1
  powerUserInactive* = 2
  powerUserMaximum* = 3
  powerUserInvalid* = powerUserMaximum
  ES_SYSTEM_REQUIRED* = DWORD 0x00000001
  ES_DISPLAY_REQUIRED* = DWORD 0x00000002
  ES_USER_PRESENT* = DWORD 0x00000004
  ES_AWAYMODE_REQUIRED* = DWORD 0x00000040
  ES_CONTINUOUS* = DWORD 0x80000000'i32
  LT_DONT_CARE* = 0
  LT_LOWEST_LATENCY* = 1
  DIAGNOSTIC_REASON_VERSION* = 0
  POWER_REQUEST_CONTEXT_VERSION* = 0
  DIAGNOSTIC_REASON_SIMPLE_STRING* = 0x00000001
  DIAGNOSTIC_REASON_DETAILED_STRING* = 0x00000002
  DIAGNOSTIC_REASON_NOT_SPECIFIED* = 0x80000000'i32
  DIAGNOSTIC_REASON_INVALID_FLAGS* = not 0x80000003'i32
  POWER_REQUEST_CONTEXT_SIMPLE_STRING* = 0x00000001
  POWER_REQUEST_CONTEXT_DETAILED_STRING* = 0x00000002
  powerRequestDisplayRequired* = 0
  powerRequestSystemRequired* = 1
  powerRequestAwayModeRequired* = 2
  powerRequestExecutionRequired* = 3
  PDCAP_D0_SUPPORTED* = 0x00000001
  PDCAP_D1_SUPPORTED* = 0x00000002
  PDCAP_D2_SUPPORTED* = 0x00000004
  PDCAP_D3_SUPPORTED* = 0x00000008
  PDCAP_WAKE_FROM_D0_SUPPORTED* = 0x00000010
  PDCAP_WAKE_FROM_D1_SUPPORTED* = 0x00000020
  PDCAP_WAKE_FROM_D2_SUPPORTED* = 0x00000040
  PDCAP_WAKE_FROM_D3_SUPPORTED* = 0x00000080
  PDCAP_WARM_EJECT_SUPPORTED* = 0x00000100
  systemPowerPolicyAc* = 0
  systemPowerPolicyDc* = 1
  verifySystemPolicyAc* = 2
  verifySystemPolicyDc* = 3
  systemPowerCapabilities* = 4
  systemBatteryState* = 5
  systemPowerStateHandler* = 6
  processorStateHandler* = 7
  systemPowerPolicyCurrent* = 8
  administratorPowerPolicy* = 9
  systemReserveHiberFile* = 10
  processorInformation* = 11
  systemPowerInformation* = 12
  processorStateHandler2* = 13
  lastWakeTime* = 14
  lastSleepTime* = 15
  systemExecutionState* = 16
  systemPowerStateNotifyHandler* = 17
  processorPowerPolicyAc* = 18
  processorPowerPolicyDc* = 19
  verifyProcessorPowerPolicyAc* = 20
  verifyProcessorPowerPolicyDc* = 21
  processorPowerPolicyCurrent* = 22
  systemPowerStateLogging* = 23
  systemPowerLoggingEntry* = 24
  setPowerSettingValue* = 25
  notifyUserPowerSetting* = 26
  powerInformationLevelUnused0* = 27
  systemMonitorHiberBootPowerOff* = 28
  systemVideoState* = 29
  traceApplicationPowerMessage* = 30
  traceApplicationPowerMessageEnd* = 31
  processorPerfStates* = 32
  processorIdleStates* = 33
  processorCap* = 34
  systemWakeSource* = 35
  systemHiberFileInformation* = 36
  traceServicePowerMessage* = 37
  processorLoad* = 38
  powerShutdownNotification* = 39
  monitorCapabilities* = 40
  sessionPowerInit* = 41
  sessionDisplayState* = 42
  powerRequestCreate* = 43
  powerRequestAction* = 44
  getPowerRequestList* = 45
  processorInformationEx* = 46
  notifyUserModeLegacyPowerEvent* = 47
  groupPark* = 48
  processorIdleDomains* = 49
  wakeTimerList* = 50
  systemHiberFileSize* = 51
  processorIdleStatesHv* = 52
  processorPerfStatesHv* = 53
  processorPerfCapHv* = 54
  processorSetIdle* = 55
  logicalProcessorIdling* = 56
  userPresence* = 57
  powerSettingNotificationName* = 58
  getPowerSettingValue* = 59
  idleResiliency* = 60
  sessionRITState* = 61
  sessionConnectNotification* = 62
  sessionPowerCleanup* = 63
  sessionLockState* = 64
  systemHiberbootState* = 65
  platformInformation* = 66
  pdcInvocation* = 67
  monitorInvocation* = 68
  firmwareTableInformationRegistered* = 69
  setShutdownSelectedTime* = 70
  suspendResumeInvocation* = 71
  plmPowerRequestCreate* = 72
  screenOff* = 73
  csDeviceNotification* = 74
  platformRole* = 75
  lastResumePerformance* = 76
  displayBurst* = 77
  exitLatencySamplingPercentage* = 78
  applyLowPowerScenarioSettings* = 79
  powerInformationLevelMaximum* = 80
  userNotPresent* = 0
  userPresent* = 1
  userUnknown* = 0xff
  monitorRequestReasonUnknown* = 0
  monitorRequestReasonPowerButton* = 1
  monitorRequestReasonRemoteConnection* = 2
  monitorRequestReasonScMonitorpower* = 3
  monitorRequestReasonUserInput* = 4
  monitorRequestReasonAcDcDisplayBurst* = 5
  monitorRequestReasonUserDisplayBurst* = 6
  monitorRequestReasonPoSetSystemState* = 7
  monitorRequestReasonSetThreadExecutionState* = 8
  monitorRequestReasonFullWake* = 9
  monitorRequestReasonSessionUnlock* = 10
  monitorRequestReasonScreenOffRequest* = 11
  monitorRequestReasonIdleTimeout* = 12
  monitorRequestReasonPolicyChange* = 13
  monitorRequestReasonMax* = 14
  poAc* = 0
  poDc* = 1
  poHot* = 2
  poConditionMaximum* = 3
  POWER_SETTING_VALUE_VERSION* = 0x1
  platformRoleUnspecified* = 0
  platformRoleDesktop* = 1
  platformRoleMobile* = 2
  platformRoleWorkstation* = 3
  platformRoleEnterpriseServer* = 4
  platformRoleSOHOServer* = 5
  platformRoleAppliancePC* = 6
  platformRolePerformanceServer* = 7
  platformRoleSlate* = 8
  platformRoleMaximum* = 9
  POWER_PLATFORM_ROLE_V1* = 0x00000001
  POWER_PLATFORM_ROLE_V1_MAX* = platformRolePerformanceServer+1
  POWER_PLATFORM_ROLE_V2* = 0x00000002
  POWER_PLATFORM_ROLE_V2_MAX* = platformRoleSlate+1
  POWER_PLATFORM_ROLE_VERSION* = POWER_PLATFORM_ROLE_V2
  POWER_PLATFORM_ROLE_VERSION_MAX* = POWER_PLATFORM_ROLE_V2_MAX
  ACPI_PPM_SOFTWARE_ALL* = 0xfc
  ACPI_PPM_SOFTWARE_ANY* = 0xfd
  ACPI_PPM_HARDWARE_ALL* = 0xfe
  MS_PPM_SOFTWARE_ALL* = 0x1
  PPM_FIRMWARE_ACPI1C2* = 0x1
  PPM_FIRMWARE_ACPI1C3* = 0x2
  PPM_FIRMWARE_ACPI1TSTATES* = 0x4
  PPM_FIRMWARE_CST* = 0x8
  PPM_FIRMWARE_CSD* = 0x10
  PPM_FIRMWARE_PCT* = 0x20
  PPM_FIRMWARE_PSS* = 0x40
  PPM_FIRMWARE_XPSS* = 0x80
  PPM_FIRMWARE_PPC* = 0x100
  PPM_FIRMWARE_PSD* = 0x200
  PPM_FIRMWARE_PTC* = 0x400
  PPM_FIRMWARE_TSS* = 0x800
  PPM_FIRMWARE_TPC* = 0x1000
  PPM_FIRMWARE_TSD* = 0x2000
  PPM_FIRMWARE_PCCH* = 0x4000
  PPM_FIRMWARE_PCCP* = 0x8000
  PPM_FIRMWARE_OSC* = 0x10000
  PPM_FIRMWARE_PDC* = 0x20000
  PPM_FIRMWARE_CPC* = 0x40000
  PPM_PERFORMANCE_IMPLEMENTATION_NONE* = 0
  PPM_PERFORMANCE_IMPLEMENTATION_PSTATES* = 1
  PPM_PERFORMANCE_IMPLEMENTATION_PCCV1* = 2
  PPM_PERFORMANCE_IMPLEMENTATION_CPPC* = 3
  PPM_PERFORMANCE_IMPLEMENTATION_PEP* = 4
  PPM_IDLE_IMPLEMENTATION_NONE* = 0x0
  PPM_IDLE_IMPLEMENTATION_CSTATES* = 0x1
  PPM_IDLE_IMPLEMENTATION_PEP* = 0x2
  PPM_PERFSTATE_CHANGE_GUID* = DEFINE_GUID("a5b32ddd-7f39-4abc-b892-900e43b59ebb")
  PPM_PERFSTATE_DOMAIN_CHANGE_GUID* = DEFINE_GUID("995e6b7f-d653-497a-b978-36a30c29bf01")
  PPM_IDLESTATE_CHANGE_GUID* = DEFINE_GUID("4838fe4f-f71c-4e51-9ecc-8430a7ac4c6c")
  PPM_PERFSTATES_DATA_GUID* = DEFINE_GUID("5708cc20-7d40-4bf4-b4aa-2b01338d0126")
  PPM_IDLESTATES_DATA_GUID* = DEFINE_GUID("ba138e10-e250-4ad7-8616-cf1a7ad410e7")
  PPM_IDLE_ACCOUNTING_GUID* = DEFINE_GUID("e2a26f78-ae07-4ee0-a30f-ce54f55a94cd")
  PPM_IDLE_ACCOUNTING_EX_GUID* = DEFINE_GUID("d67abd39-81f8-4a5e-8152-72e31ec912ee")
  PPM_THERMALCONSTRAINT_GUID* = DEFINE_GUID("a852c2c8-1a4c-423b-8c2c-f30d82931a88")
  PPM_PERFMON_PERFSTATE_GUID* = DEFINE_GUID("7fd18652-0cfe-40d2-b0a1-0b066a87759e")
  PPM_THERMAL_POLICY_CHANGE_GUID* = DEFINE_GUID("48f377b8-6880-4c7b-8bdc-380176c6654d")
  POWER_ACTION_QUERY_ALLOWED* = 0x00000001
  POWER_ACTION_UI_ALLOWED* = 0x00000002
  POWER_ACTION_OVERRIDE_APPS* = 0x00000004
  POWER_ACTION_HIBERBOOT* = 0x00000008
  POWER_ACTION_PSEUDO_TRANSITION* = 0x08000000
  POWER_ACTION_LIGHTEST_FIRST* = 0x10000000
  POWER_ACTION_LOCK_CONSOLE* = 0x20000000
  POWER_ACTION_DISABLE_WAKES* = 0x40000000
  POWER_ACTION_CRITICAL* = 0x80000000'i32
  POWER_LEVEL_USER_NOTIFY_TEXT* = 0x00000001
  POWER_LEVEL_USER_NOTIFY_SOUND* = 0x00000002
  POWER_LEVEL_USER_NOTIFY_EXEC* = 0x00000004
  POWER_USER_NOTIFY_BUTTON* = 0x00000008
  POWER_USER_NOTIFY_SHUTDOWN* = 0x00000010
  POWER_USER_NOTIFY_FORCED_SHUTDOWN* = 0x00000020
  POWER_FORCE_TRIGGER_RESET* = 0x80000000'i32
  BATTERY_DISCHARGE_FLAGS_EVENTCODE_MASK* = 0x00000007
  BATTERY_DISCHARGE_FLAGS_ENABLE* = 0x80000000'i32
  DISCHARGE_POLICY_CRITICAL* = 0
  DISCHARGE_POLICY_LOW* = 1
  PO_THROTTLE_NONE* = 0
  PO_THROTTLE_CONSTANT* = 1
  PO_THROTTLE_DEGRADE* = 2
  PO_THROTTLE_ADAPTIVE* = 3
  PO_THROTTLE_MAXIMUM* = 4
  IMAGE_DOS_SIGNATURE* = 0x5A4D
  IMAGE_OS2_SIGNATURE* = 0x454E
  IMAGE_OS2_SIGNATURE_LE* = 0x454C
  IMAGE_VXD_SIGNATURE* = 0x454C
  IMAGE_NT_SIGNATURE* = 0x00004550
  IMAGE_SIZEOF_FILE_HEADER* = 20
  IMAGE_FILE_RELOCS_STRIPPED* = 0x0001
  IMAGE_FILE_EXECUTABLE_IMAGE* = 0x0002
  IMAGE_FILE_LINE_NUMS_STRIPPED* = 0x0004
  IMAGE_FILE_LOCAL_SYMS_STRIPPED* = 0x0008
  IMAGE_FILE_AGGRESIVE_WS_TRIM* = 0x0010
  IMAGE_FILE_LARGE_ADDRESS_AWARE* = 0x0020
  IMAGE_FILE_BYTES_REVERSED_LO* = 0x0080
  IMAGE_FILE_32BIT_MACHINE* = 0x0100
  IMAGE_FILE_DEBUG_STRIPPED* = 0x0200
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP* = 0x0400
  IMAGE_FILE_NET_RUN_FROM_SWAP* = 0x0800
  IMAGE_FILE_SYSTEM* = 0x1000
  IMAGE_FILE_DLL* = 0x2000
  IMAGE_FILE_UP_SYSTEM_ONLY* = 0x4000
  IMAGE_FILE_BYTES_REVERSED_HI* = 0x8000
  IMAGE_FILE_MACHINE_UNKNOWN* = 0
  IMAGE_FILE_MACHINE_I386* = 0x014c
  IMAGE_FILE_MACHINE_R3000* = 0x0162
  IMAGE_FILE_MACHINE_R4000* = 0x0166
  IMAGE_FILE_MACHINE_R10000* = 0x0168
  IMAGE_FILE_MACHINE_WCEMIPSV2* = 0x0169
  IMAGE_FILE_MACHINE_ALPHA* = 0x0184
  IMAGE_FILE_MACHINE_SH3* = 0x01a2
  IMAGE_FILE_MACHINE_SH3DSP* = 0x01a3
  IMAGE_FILE_MACHINE_SH3E* = 0x01a4
  IMAGE_FILE_MACHINE_SH4* = 0x01a6
  IMAGE_FILE_MACHINE_SH5* = 0x01a8
  IMAGE_FILE_MACHINE_ARM* = 0x01c0
  IMAGE_FILE_MACHINE_ARMV7* = 0x01c4
  IMAGE_FILE_MACHINE_ARMNT* = 0x01c4
  IMAGE_FILE_MACHINE_THUMB* = 0x01c2
  IMAGE_FILE_MACHINE_AM33* = 0x01d3
  IMAGE_FILE_MACHINE_POWERPC* = 0x01F0
  IMAGE_FILE_MACHINE_POWERPCFP* = 0x01f1
  IMAGE_FILE_MACHINE_IA64* = 0x0200
  IMAGE_FILE_MACHINE_MIPS16* = 0x0266
  IMAGE_FILE_MACHINE_ALPHA64* = 0x0284
  IMAGE_FILE_MACHINE_MIPSFPU* = 0x0366
  IMAGE_FILE_MACHINE_MIPSFPU16* = 0x0466
  IMAGE_FILE_MACHINE_AXP64* = IMAGE_FILE_MACHINE_ALPHA64
  IMAGE_FILE_MACHINE_TRICORE* = 0x0520
  IMAGE_FILE_MACHINE_CEF* = 0x0CEF
  IMAGE_FILE_MACHINE_EBC* = 0x0EBC
  IMAGE_FILE_MACHINE_AMD64* = 0x8664
  IMAGE_FILE_MACHINE_M32R* = 0x9041
  IMAGE_FILE_MACHINE_CEE* = 0xc0ee
  IMAGE_SIZEOF_ROM_OPTIONAL_HEADER* = 56
  IMAGE_SIZEOF_STD_OPTIONAL_HEADER* = 28
  IMAGE_SIZEOF_NT_OPTIONAL32_HEADER* = 224
  IMAGE_SIZEOF_NT_OPTIONAL64_HEADER* = 240
  IMAGE_NT_OPTIONAL_HDR32_MAGIC* = 0x10b
  IMAGE_NT_OPTIONAL_HDR64_MAGIC* = 0x20b
  IMAGE_ROM_OPTIONAL_HDR_MAGIC* = 0x107
  IMAGE_SUBSYSTEM_UNKNOWN* = 0
  IMAGE_SUBSYSTEM_NATIVE* = 1
  IMAGE_SUBSYSTEM_WINDOWS_GUI* = 2
  IMAGE_SUBSYSTEM_WINDOWS_CUI* = 3
  IMAGE_SUBSYSTEM_OS2_CUI* = 5
  IMAGE_SUBSYSTEM_POSIX_CUI* = 7
  IMAGE_SUBSYSTEM_NATIVE_WINDOWS* = 8
  IMAGE_SUBSYSTEM_WINDOWS_CE_GUI* = 9
  IMAGE_SUBSYSTEM_EFI_APPLICATION* = 10
  IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER* = 11
  IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER* = 12
  IMAGE_SUBSYSTEM_EFI_ROM* = 13
  IMAGE_SUBSYSTEM_XBOX* = 14
  IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION* = 16
  IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA* = 0x0020
  IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE* = 0x0040
  IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY* = 0x0080
  IMAGE_DLLCHARACTERISTICS_NX_COMPAT* = 0x0100
  IMAGE_DLLCHARACTERISTICS_NO_ISOLATION* = 0x0200
  IMAGE_DLLCHARACTERISTICS_NO_SEH* = 0x0400
  IMAGE_DLLCHARACTERISTICS_NO_BIND* = 0x0800
  IMAGE_DLLCHARACTERISTICS_APPCONTAINER* = 0x1000
  IMAGE_DLLCHARACTERISTICS_WDM_DRIVER* = 0x2000
  IMAGE_DLLCHARACTERISTICS_GUARD_CF* = 0x4000
  IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE* = 0x8000
  IMAGE_DIRECTORY_ENTRY_EXPORT* = 0
  IMAGE_DIRECTORY_ENTRY_IMPORT* = 1
  IMAGE_DIRECTORY_ENTRY_RESOURCE* = 2
  IMAGE_DIRECTORY_ENTRY_EXCEPTION* = 3
  IMAGE_DIRECTORY_ENTRY_SECURITY* = 4
  IMAGE_DIRECTORY_ENTRY_BASERELOC* = 5
  IMAGE_DIRECTORY_ENTRY_DEBUG* = 6
  IMAGE_DIRECTORY_ENTRY_ARCHITECTURE* = 7
  IMAGE_DIRECTORY_ENTRY_GLOBALPTR* = 8
  IMAGE_DIRECTORY_ENTRY_TLS* = 9
  IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG* = 10
  IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT* = 11
  IMAGE_DIRECTORY_ENTRY_IAT* = 12
  IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT* = 13
  IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR* = 14
  IMAGE_SIZEOF_SECTION_HEADER* = 40
  IMAGE_SCN_TYPE_NO_PAD* = 0x00000008
  IMAGE_SCN_CNT_CODE* = 0x00000020
  IMAGE_SCN_CNT_INITIALIZED_DATA* = 0x00000040
  IMAGE_SCN_CNT_UNINITIALIZED_DATA* = 0x00000080
  IMAGE_SCN_LNK_OTHER* = 0x00000100
  IMAGE_SCN_LNK_INFO* = 0x00000200
  IMAGE_SCN_LNK_REMOVE* = 0x00000800
  IMAGE_SCN_LNK_COMDAT* = 0x00001000
  IMAGE_SCN_NO_DEFER_SPEC_EXC* = 0x00004000
  IMAGE_SCN_GPREL* = 0x00008000
  IMAGE_SCN_MEM_FARDATA* = 0x00008000
  IMAGE_SCN_MEM_PURGEABLE* = 0x00020000
  IMAGE_SCN_MEM_16BIT* = 0x00020000
  IMAGE_SCN_MEM_LOCKED* = 0x00040000
  IMAGE_SCN_MEM_PRELOAD* = 0x00080000
  IMAGE_SCN_ALIGN_1BYTES* = 0x00100000
  IMAGE_SCN_ALIGN_2BYTES* = 0x00200000
  IMAGE_SCN_ALIGN_4BYTES* = 0x00300000
  IMAGE_SCN_ALIGN_8BYTES* = 0x00400000
  IMAGE_SCN_ALIGN_16BYTES* = 0x00500000
  IMAGE_SCN_ALIGN_32BYTES* = 0x00600000
  IMAGE_SCN_ALIGN_64BYTES* = 0x00700000
  IMAGE_SCN_ALIGN_128BYTES* = 0x00800000
  IMAGE_SCN_ALIGN_256BYTES* = 0x00900000
  IMAGE_SCN_ALIGN_512BYTES* = 0x00A00000
  IMAGE_SCN_ALIGN_1024BYTES* = 0x00B00000
  IMAGE_SCN_ALIGN_2048BYTES* = 0x00C00000
  IMAGE_SCN_ALIGN_4096BYTES* = 0x00D00000
  IMAGE_SCN_ALIGN_8192BYTES* = 0x00E00000
  IMAGE_SCN_ALIGN_MASK* = 0x00F00000
  IMAGE_SCN_LNK_NRELOC_OVFL* = 0x01000000
  IMAGE_SCN_MEM_DISCARDABLE* = 0x02000000
  IMAGE_SCN_MEM_NOT_CACHED* = 0x04000000
  IMAGE_SCN_MEM_NOT_PAGED* = 0x08000000
  IMAGE_SCN_MEM_SHARED* = 0x10000000
  IMAGE_SCN_MEM_EXECUTE* = 0x20000000
  IMAGE_SCN_MEM_READ* = 0x40000000
  IMAGE_SCN_MEM_WRITE* = 0x80000000'i32
  IMAGE_SCN_SCALE_INDEX* = 0x00000001
  IMAGE_SYM_UNDEFINED* = SHORT 0
  IMAGE_SYM_ABSOLUTE* = SHORT(-1)
  IMAGE_SYM_DEBUG* = SHORT(-2)
  IMAGE_SYM_SECTION_MAX* = 0xFEFF
  IMAGE_SYM_SECTION_MAX_EX* = MAXLONG
  IMAGE_SYM_TYPE_NULL* = 0x0000
  IMAGE_SYM_TYPE_VOID* = 0x0001
  IMAGE_SYM_TYPE_CHAR* = 0x0002
  IMAGE_SYM_TYPE_SHORT* = 0x0003
  IMAGE_SYM_TYPE_INT* = 0x0004
  IMAGE_SYM_TYPE_LONG* = 0x0005
  IMAGE_SYM_TYPE_FLOAT* = 0x0006
  IMAGE_SYM_TYPE_DOUBLE* = 0x0007
  IMAGE_SYM_TYPE_STRUCT* = 0x0008
  IMAGE_SYM_TYPE_UNION* = 0x0009
  IMAGE_SYM_TYPE_ENUM* = 0x000A
  IMAGE_SYM_TYPE_MOE* = 0x000B
  IMAGE_SYM_TYPE_BYTE* = 0x000C
  IMAGE_SYM_TYPE_WORD* = 0x000D
  IMAGE_SYM_TYPE_UINT* = 0x000E
  IMAGE_SYM_TYPE_DWORD* = 0x000F
  IMAGE_SYM_TYPE_PCODE* = 0x8000
  IMAGE_SYM_DTYPE_NULL* = 0
  IMAGE_SYM_DTYPE_POINTER* = 1
  IMAGE_SYM_DTYPE_FUNCTION* = 2
  IMAGE_SYM_DTYPE_ARRAY* = 3
  IMAGE_SYM_CLASS_NULL* = 0x0000
  IMAGE_SYM_CLASS_AUTOMATIC* = 0x0001
  IMAGE_SYM_CLASS_EXTERNAL* = 0x0002
  IMAGE_SYM_CLASS_STATIC* = 0x0003
  IMAGE_SYM_CLASS_REGISTER* = 0x0004
  IMAGE_SYM_CLASS_EXTERNAL_DEF* = 0x0005
  IMAGE_SYM_CLASS_LABEL* = 0x0006
  IMAGE_SYM_CLASS_UNDEFINED_LABEL* = 0x0007
  IMAGE_SYM_CLASS_MEMBER_OF_STRUCT* = 0x0008
  IMAGE_SYM_CLASS_ARGUMENT* = 0x0009
  IMAGE_SYM_CLASS_STRUCT_TAG* = 0x000A
  IMAGE_SYM_CLASS_MEMBER_OF_UNION* = 0x000B
  IMAGE_SYM_CLASS_UNION_TAG* = 0x000C
  IMAGE_SYM_CLASS_TYPE_DEFINITION* = 0x000D
  IMAGE_SYM_CLASS_UNDEFINED_STATIC* = 0x000E
  IMAGE_SYM_CLASS_ENUM_TAG* = 0x000F
  IMAGE_SYM_CLASS_MEMBER_OF_ENUM* = 0x0010
  IMAGE_SYM_CLASS_REGISTER_PARAM* = 0x0011
  IMAGE_SYM_CLASS_BIT_FIELD* = 0x0012
  IMAGE_SYM_CLASS_FAR_EXTERNAL* = 0x0044
  IMAGE_SYM_CLASS_BLOCK* = 0x0064
  IMAGE_SYM_CLASS_FUNCTION* = 0x0065
  IMAGE_SYM_CLASS_END_OF_STRUCT* = 0x0066
  IMAGE_SYM_CLASS_FILE* = 0x0067
  IMAGE_SYM_CLASS_SECTION* = 0x0068
  IMAGE_SYM_CLASS_WEAK_EXTERNAL* = 0x0069
  IMAGE_SYM_CLASS_CLR_TOKEN* = 0x006B
  N_BTMASK* = 0x000F
  N_TMASK* = 0x0030
  N_TMASK1* = 0x00C0
  N_TMASK2* = 0x00F0
  N_BTSHFT* = 4
  N_TSHIFT* = 2
  IMAGE_SIZEOF_AUX_SYMBOL* = 18
  IMAGE_AUX_SYMBOL_TYPE_TOKEN_DEF* = 1
  IMAGE_COMDAT_SELECT_NODUPLICATES* = 1
  IMAGE_COMDAT_SELECT_ANY* = 2
  IMAGE_COMDAT_SELECT_SAME_SIZE* = 3
  IMAGE_COMDAT_SELECT_EXACT_MATCH* = 4
  IMAGE_COMDAT_SELECT_ASSOCIATIVE* = 5
  IMAGE_COMDAT_SELECT_LARGEST* = 6
  IMAGE_COMDAT_SELECT_NEWEST* = 7
  IMAGE_WEAK_EXTERN_SEARCH_NOLIBRARY* = 1
  IMAGE_WEAK_EXTERN_SEARCH_LIBRARY* = 2
  IMAGE_WEAK_EXTERN_SEARCH_ALIAS* = 3
  IMAGE_SIZEOF_RELOCATION* = 10
  IMAGE_REL_I386_ABSOLUTE* = 0x0000
  IMAGE_REL_I386_DIR16* = 0x0001
  IMAGE_REL_I386_REL16* = 0x0002
  IMAGE_REL_I386_DIR32* = 0x0006
  IMAGE_REL_I386_DIR32NB* = 0x0007
  IMAGE_REL_I386_SEG12* = 0x0009
  IMAGE_REL_I386_SECTION* = 0x000A
  IMAGE_REL_I386_SECREL* = 0x000B
  IMAGE_REL_I386_TOKEN* = 0x000C
  IMAGE_REL_I386_SECREL7* = 0x000D
  IMAGE_REL_I386_REL32* = 0x0014
  IMAGE_REL_MIPS_ABSOLUTE* = 0x0000
  IMAGE_REL_MIPS_REFHALF* = 0x0001
  IMAGE_REL_MIPS_REFWORD* = 0x0002
  IMAGE_REL_MIPS_JMPADDR* = 0x0003
  IMAGE_REL_MIPS_REFHI* = 0x0004
  IMAGE_REL_MIPS_REFLO* = 0x0005
  IMAGE_REL_MIPS_GPREL* = 0x0006
  IMAGE_REL_MIPS_LITERAL* = 0x0007
  IMAGE_REL_MIPS_SECTION* = 0x000A
  IMAGE_REL_MIPS_SECREL* = 0x000B
  IMAGE_REL_MIPS_SECRELLO* = 0x000C
  IMAGE_REL_MIPS_SECRELHI* = 0x000D
  IMAGE_REL_MIPS_TOKEN* = 0x000E
  IMAGE_REL_MIPS_JMPADDR16* = 0x0010
  IMAGE_REL_MIPS_REFWORDNB* = 0x0022
  IMAGE_REL_MIPS_PAIR* = 0x0025
  IMAGE_REL_ALPHA_ABSOLUTE* = 0x0000
  IMAGE_REL_ALPHA_REFLONG* = 0x0001
  IMAGE_REL_ALPHA_REFQUAD* = 0x0002
  IMAGE_REL_ALPHA_GPREL32* = 0x0003
  IMAGE_REL_ALPHA_LITERAL* = 0x0004
  IMAGE_REL_ALPHA_LITUSE* = 0x0005
  IMAGE_REL_ALPHA_GPDISP* = 0x0006
  IMAGE_REL_ALPHA_BRADDR* = 0x0007
  IMAGE_REL_ALPHA_HINT* = 0x0008
  IMAGE_REL_ALPHA_INLINE_REFLONG* = 0x0009
  IMAGE_REL_ALPHA_REFHI* = 0x000A
  IMAGE_REL_ALPHA_REFLO* = 0x000B
  IMAGE_REL_ALPHA_PAIR* = 0x000C
  IMAGE_REL_ALPHA_MATCH* = 0x000D
  IMAGE_REL_ALPHA_SECTION* = 0x000E
  IMAGE_REL_ALPHA_SECREL* = 0x000F
  IMAGE_REL_ALPHA_REFLONGNB* = 0x0010
  IMAGE_REL_ALPHA_SECRELLO* = 0x0011
  IMAGE_REL_ALPHA_SECRELHI* = 0x0012
  IMAGE_REL_ALPHA_REFQ3* = 0x0013
  IMAGE_REL_ALPHA_REFQ2* = 0x0014
  IMAGE_REL_ALPHA_REFQ1* = 0x0015
  IMAGE_REL_ALPHA_GPRELLO* = 0x0016
  IMAGE_REL_ALPHA_GPRELHI* = 0x0017
  IMAGE_REL_PPC_ABSOLUTE* = 0x0000
  IMAGE_REL_PPC_ADDR64* = 0x0001
  IMAGE_REL_PPC_ADDR32* = 0x0002
  IMAGE_REL_PPC_ADDR24* = 0x0003
  IMAGE_REL_PPC_ADDR16* = 0x0004
  IMAGE_REL_PPC_ADDR14* = 0x0005
  IMAGE_REL_PPC_REL24* = 0x0006
  IMAGE_REL_PPC_REL14* = 0x0007
  IMAGE_REL_PPC_TOCREL16* = 0x0008
  IMAGE_REL_PPC_TOCREL14* = 0x0009
  IMAGE_REL_PPC_ADDR32NB* = 0x000A
  IMAGE_REL_PPC_SECREL* = 0x000B
  IMAGE_REL_PPC_SECTION* = 0x000C
  IMAGE_REL_PPC_IFGLUE* = 0x000D
  IMAGE_REL_PPC_IMGLUE* = 0x000E
  IMAGE_REL_PPC_SECREL16* = 0x000F
  IMAGE_REL_PPC_REFHI* = 0x0010
  IMAGE_REL_PPC_REFLO* = 0x0011
  IMAGE_REL_PPC_PAIR* = 0x0012
  IMAGE_REL_PPC_SECRELLO* = 0x0013
  IMAGE_REL_PPC_SECRELHI* = 0x0014
  IMAGE_REL_PPC_GPREL* = 0x0015
  IMAGE_REL_PPC_TOKEN* = 0x0016
  IMAGE_REL_PPC_TYPEMASK* = 0x00FF
  IMAGE_REL_PPC_NEG* = 0x0100
  IMAGE_REL_PPC_BRTAKEN* = 0x0200
  IMAGE_REL_PPC_BRNTAKEN* = 0x0400
  IMAGE_REL_PPC_TOCDEFN* = 0x0800
  IMAGE_REL_SH3_ABSOLUTE* = 0x0000
  IMAGE_REL_SH3_DIRECT16* = 0x0001
  IMAGE_REL_SH3_DIRECT32* = 0x0002
  IMAGE_REL_SH3_DIRECT8* = 0x0003
  IMAGE_REL_SH3_DIRECT8_WORD* = 0x0004
  IMAGE_REL_SH3_DIRECT8_LONG* = 0x0005
  IMAGE_REL_SH3_DIRECT4* = 0x0006
  IMAGE_REL_SH3_DIRECT4_WORD* = 0x0007
  IMAGE_REL_SH3_DIRECT4_LONG* = 0x0008
  IMAGE_REL_SH3_PCREL8_WORD* = 0x0009
  IMAGE_REL_SH3_PCREL8_LONG* = 0x000A
  IMAGE_REL_SH3_PCREL12_WORD* = 0x000B
  IMAGE_REL_SH3_STARTOF_SECTION* = 0x000C
  IMAGE_REL_SH3_SIZEOF_SECTION* = 0x000D
  IMAGE_REL_SH3_SECTION* = 0x000E
  IMAGE_REL_SH3_SECREL* = 0x000F
  IMAGE_REL_SH3_DIRECT32_NB* = 0x0010
  IMAGE_REL_SH3_GPREL4_LONG* = 0x0011
  IMAGE_REL_SH3_TOKEN* = 0x0012
  IMAGE_REL_SHM_PCRELPT* = 0x0013
  IMAGE_REL_SHM_REFLO* = 0x0014
  IMAGE_REL_SHM_REFHALF* = 0x0015
  IMAGE_REL_SHM_RELLO* = 0x0016
  IMAGE_REL_SHM_RELHALF* = 0x0017
  IMAGE_REL_SHM_PAIR* = 0x0018
  IMAGE_REL_SH_NOMODE* = 0x8000
  IMAGE_REL_ARM_ABSOLUTE* = 0x0000
  IMAGE_REL_ARM_ADDR32* = 0x0001
  IMAGE_REL_ARM_ADDR32NB* = 0x0002
  IMAGE_REL_ARM_BRANCH24* = 0x0003
  IMAGE_REL_ARM_BRANCH11* = 0x0004
  IMAGE_REL_ARM_TOKEN* = 0x0005
  IMAGE_REL_ARM_GPREL12* = 0x0006
  IMAGE_REL_ARM_GPREL7* = 0x0007
  IMAGE_REL_ARM_BLX24* = 0x0008
  IMAGE_REL_ARM_BLX11* = 0x0009
  IMAGE_REL_ARM_SECTION* = 0x000E
  IMAGE_REL_ARM_SECREL* = 0x000F
  IMAGE_REL_ARM_MOV32A* = 0x0010
  IMAGE_REL_ARM_MOV32* = 0x0010
  IMAGE_REL_ARM_MOV32T* = 0x0011
  IMAGE_REL_THUMB_MOV32* = 0x0011
  IMAGE_REL_ARM_BRANCH20T* = 0x0012
  IMAGE_REL_THUMB_BRANCH20* = 0x0012
  IMAGE_REL_ARM_BRANCH24T* = 0x0014
  IMAGE_REL_THUMB_BRANCH24* = 0x0014
  IMAGE_REL_ARM_BLX23T* = 0x0015
  IMAGE_REL_THUMB_BLX23* = 0x0015
  IMAGE_REL_AM_ABSOLUTE* = 0x0000
  IMAGE_REL_AM_ADDR32* = 0x0001
  IMAGE_REL_AM_ADDR32NB* = 0x0002
  IMAGE_REL_AM_CALL32* = 0x0003
  IMAGE_REL_AM_FUNCINFO* = 0x0004
  IMAGE_REL_AM_REL32_1* = 0x0005
  IMAGE_REL_AM_REL32_2* = 0x0006
  IMAGE_REL_AM_SECREL* = 0x0007
  IMAGE_REL_AM_SECTION* = 0x0008
  IMAGE_REL_AM_TOKEN* = 0x0009
  IMAGE_REL_AMD64_ABSOLUTE* = 0x0000
  IMAGE_REL_AMD64_ADDR64* = 0x0001
  IMAGE_REL_AMD64_ADDR32* = 0x0002
  IMAGE_REL_AMD64_ADDR32NB* = 0x0003
  IMAGE_REL_AMD64_REL32* = 0x0004
  IMAGE_REL_AMD64_REL32_1* = 0x0005
  IMAGE_REL_AMD64_REL32_2* = 0x0006
  IMAGE_REL_AMD64_REL32_3* = 0x0007
  IMAGE_REL_AMD64_REL32_4* = 0x0008
  IMAGE_REL_AMD64_REL32_5* = 0x0009
  IMAGE_REL_AMD64_SECTION* = 0x000A
  IMAGE_REL_AMD64_SECREL* = 0x000B
  IMAGE_REL_AMD64_SECREL7* = 0x000C
  IMAGE_REL_AMD64_TOKEN* = 0x000D
  IMAGE_REL_AMD64_SREL32* = 0x000E
  IMAGE_REL_AMD64_PAIR* = 0x000F
  IMAGE_REL_AMD64_SSPAN32* = 0x0010
  IMAGE_REL_IA64_ABSOLUTE* = 0x0000
  IMAGE_REL_IA64_IMM14* = 0x0001
  IMAGE_REL_IA64_IMM22* = 0x0002
  IMAGE_REL_IA64_IMM64* = 0x0003
  IMAGE_REL_IA64_DIR32* = 0x0004
  IMAGE_REL_IA64_DIR64* = 0x0005
  IMAGE_REL_IA64_PCREL21B* = 0x0006
  IMAGE_REL_IA64_PCREL21M* = 0x0007
  IMAGE_REL_IA64_PCREL21F* = 0x0008
  IMAGE_REL_IA64_GPREL22* = 0x0009
  IMAGE_REL_IA64_LTOFF22* = 0x000A
  IMAGE_REL_IA64_SECTION* = 0x000B
  IMAGE_REL_IA64_SECREL22* = 0x000C
  IMAGE_REL_IA64_SECREL64I* = 0x000D
  IMAGE_REL_IA64_SECREL32* = 0x000E
  IMAGE_REL_IA64_DIR32NB* = 0x0010
  IMAGE_REL_IA64_SREL14* = 0x0011
  IMAGE_REL_IA64_SREL22* = 0x0012
  IMAGE_REL_IA64_SREL32* = 0x0013
  IMAGE_REL_IA64_UREL32* = 0x0014
  IMAGE_REL_IA64_PCREL60X* = 0x0015
  IMAGE_REL_IA64_PCREL60B* = 0x0016
  IMAGE_REL_IA64_PCREL60F* = 0x0017
  IMAGE_REL_IA64_PCREL60I* = 0x0018
  IMAGE_REL_IA64_PCREL60M* = 0x0019
  IMAGE_REL_IA64_IMMGPREL64* = 0x001A
  IMAGE_REL_IA64_TOKEN* = 0x001B
  IMAGE_REL_IA64_GPREL32* = 0x001C
  IMAGE_REL_IA64_ADDEND* = 0x001F
  IMAGE_REL_CEF_ABSOLUTE* = 0x0000
  IMAGE_REL_CEF_ADDR32* = 0x0001
  IMAGE_REL_CEF_ADDR64* = 0x0002
  IMAGE_REL_CEF_ADDR32NB* = 0x0003
  IMAGE_REL_CEF_SECTION* = 0x0004
  IMAGE_REL_CEF_SECREL* = 0x0005
  IMAGE_REL_CEF_TOKEN* = 0x0006
  IMAGE_REL_CEE_ABSOLUTE* = 0x0000
  IMAGE_REL_CEE_ADDR32* = 0x0001
  IMAGE_REL_CEE_ADDR64* = 0x0002
  IMAGE_REL_CEE_ADDR32NB* = 0x0003
  IMAGE_REL_CEE_SECTION* = 0x0004
  IMAGE_REL_CEE_SECREL* = 0x0005
  IMAGE_REL_CEE_TOKEN* = 0x0006
  IMAGE_REL_M32R_ABSOLUTE* = 0x0000
  IMAGE_REL_M32R_ADDR32* = 0x0001
  IMAGE_REL_M32R_ADDR32NB* = 0x0002
  IMAGE_REL_M32R_ADDR24* = 0x0003
  IMAGE_REL_M32R_GPREL16* = 0x0004
  IMAGE_REL_M32R_PCREL24* = 0x0005
  IMAGE_REL_M32R_PCREL16* = 0x0006
  IMAGE_REL_M32R_PCREL8* = 0x0007
  IMAGE_REL_M32R_REFHALF* = 0x0008
  IMAGE_REL_M32R_REFHI* = 0x0009
  IMAGE_REL_M32R_REFLO* = 0x000A
  IMAGE_REL_M32R_PAIR* = 0x000B
  IMAGE_REL_M32R_SECTION* = 0x000C
  IMAGE_REL_M32R_SECREL32* = 0x000D
  IMAGE_REL_M32R_TOKEN* = 0x000E
  IMAGE_REL_EBC_ABSOLUTE* = 0x0000
  IMAGE_REL_EBC_ADDR32NB* = 0x0001
  IMAGE_REL_EBC_REL32* = 0x0002
  IMAGE_REL_EBC_SECTION* = 0x0003
  IMAGE_REL_EBC_SECREL* = 0x0004
  EMARCH_ENC_I17_IMM7B_INST_WORD_X* = 3
  EMARCH_ENC_I17_IMM7B_SIZE_X* = 7
  EMARCH_ENC_I17_IMM7B_INST_WORD_POS_X* = 4
  EMARCH_ENC_I17_IMM7B_VAL_POS_X* = 0
  EMARCH_ENC_I17_IMM9D_INST_WORD_X* = 3
  EMARCH_ENC_I17_IMM9D_SIZE_X* = 9
  EMARCH_ENC_I17_IMM9D_INST_WORD_POS_X* = 18
  EMARCH_ENC_I17_IMM9D_VAL_POS_X* = 7
  EMARCH_ENC_I17_IMM5C_INST_WORD_X* = 3
  EMARCH_ENC_I17_IMM5C_SIZE_X* = 5
  EMARCH_ENC_I17_IMM5C_INST_WORD_POS_X* = 13
  EMARCH_ENC_I17_IMM5C_VAL_POS_X* = 16
  EMARCH_ENC_I17_IC_INST_WORD_X* = 3
  EMARCH_ENC_I17_IC_SIZE_X* = 1
  EMARCH_ENC_I17_IC_INST_WORD_POS_X* = 12
  EMARCH_ENC_I17_IC_VAL_POS_X* = 21
  EMARCH_ENC_I17_IMM41a_INST_WORD_X* = 1
  EMARCH_ENC_I17_IMM41a_SIZE_X* = 10
  EMARCH_ENC_I17_IMM41a_INST_WORD_POS_X* = 14
  EMARCH_ENC_I17_IMM41a_VAL_POS_X* = 22
  EMARCH_ENC_I17_IMM41b_INST_WORD_X* = 1
  EMARCH_ENC_I17_IMM41b_SIZE_X* = 8
  EMARCH_ENC_I17_IMM41b_INST_WORD_POS_X* = 24
  EMARCH_ENC_I17_IMM41b_VAL_POS_X* = 32
  EMARCH_ENC_I17_IMM41c_INST_WORD_X* = 2
  EMARCH_ENC_I17_IMM41c_SIZE_X* = 23
  EMARCH_ENC_I17_IMM41c_INST_WORD_POS_X* = 0
  EMARCH_ENC_I17_IMM41c_VAL_POS_X* = 40
  EMARCH_ENC_I17_SIGN_INST_WORD_X* = 3
  EMARCH_ENC_I17_SIGN_SIZE_X* = 1
  EMARCH_ENC_I17_SIGN_INST_WORD_POS_X* = 27
  EMARCH_ENC_I17_SIGN_VAL_POS_X* = 63
  X3_OPCODE_INST_WORD_X* = 3
  X3_OPCODE_SIZE_X* = 4
  X3_OPCODE_INST_WORD_POS_X* = 28
  X3_OPCODE_SIGN_VAL_POS_X* = 0
  X3_I_INST_WORD_X* = 3
  X3_I_SIZE_X* = 1
  X3_I_INST_WORD_POS_X* = 27
  X3_I_SIGN_VAL_POS_X* = 59
  X3_D_WH_INST_WORD_X* = 3
  X3_D_WH_SIZE_X* = 3
  X3_D_WH_INST_WORD_POS_X* = 24
  X3_D_WH_SIGN_VAL_POS_X* = 0
  X3_IMM20_INST_WORD_X* = 3
  X3_IMM20_SIZE_X* = 20
  X3_IMM20_INST_WORD_POS_X* = 4
  X3_IMM20_SIGN_VAL_POS_X* = 0
  X3_IMM39_1_INST_WORD_X* = 2
  X3_IMM39_1_SIZE_X* = 23
  X3_IMM39_1_INST_WORD_POS_X* = 0
  X3_IMM39_1_SIGN_VAL_POS_X* = 36
  X3_IMM39_2_INST_WORD_X* = 1
  X3_IMM39_2_SIZE_X* = 16
  X3_IMM39_2_INST_WORD_POS_X* = 16
  X3_IMM39_2_SIGN_VAL_POS_X* = 20
  X3_P_INST_WORD_X* = 3
  X3_P_SIZE_X* = 4
  X3_P_INST_WORD_POS_X* = 0
  X3_P_SIGN_VAL_POS_X* = 0
  X3_TMPLT_INST_WORD_X* = 0
  X3_TMPLT_SIZE_X* = 4
  X3_TMPLT_INST_WORD_POS_X* = 0
  X3_TMPLT_SIGN_VAL_POS_X* = 0
  X3_BTYPE_QP_INST_WORD_X* = 2
  X3_BTYPE_QP_SIZE_X* = 9
  X3_BTYPE_QP_INST_WORD_POS_X* = 23
  X3_BTYPE_QP_INST_VAL_POS_X* = 0
  X3_EMPTY_INST_WORD_X* = 1
  X3_EMPTY_SIZE_X* = 2
  X3_EMPTY_INST_WORD_POS_X* = 14
  X3_EMPTY_INST_VAL_POS_X* = 0
  IMAGE_SIZEOF_LINENUMBER* = 6
  IMAGE_SIZEOF_BASE_RELOCATION* = 8
  IMAGE_REL_BASED_ABSOLUTE* = 0
  IMAGE_REL_BASED_HIGH* = 1
  IMAGE_REL_BASED_LOW* = 2
  IMAGE_REL_BASED_HIGHLOW* = 3
  IMAGE_REL_BASED_HIGHADJ* = 4
  IMAGE_REL_BASED_MIPS_JMPADDR* = 5
  IMAGE_REL_BASED_ARM_MOV32* = 5
  IMAGE_REL_BASED_THUMB_MOV32* = 7
  IMAGE_REL_BASED_MIPS_JMPADDR16* = 9
  IMAGE_REL_BASED_IA64_IMM64* = 9
  IMAGE_REL_BASED_DIR64* = 10
  IMAGE_ARCHIVE_START_SIZE* = 8
  IMAGE_ARCHIVE_START* = "!<arch>\n"
  IMAGE_ARCHIVE_END* = "`\n"
  IMAGE_ARCHIVE_PAD* = "\n"
  IMAGE_ARCHIVE_LINKER_MEMBER* = "/"
  IMAGE_ARCHIVE_LONGNAMES_MEMBER* = "//"
  IMAGE_SIZEOF_ARCHIVE_MEMBER_HDR* = 60
  IMAGE_ORDINAL_FLAG64* = 0x8000000000000000
  IMAGE_ORDINAL_FLAG32* = 0x80000000'i32
  IMAGE_RESOURCE_NAME_IS_STRING* = 0x80000000'i32
  IMAGE_RESOURCE_DATA_IS_DIRECTORY* = 0x80000000'i32
  IMAGE_DEBUG_TYPE_UNKNOWN* = 0
  IMAGE_DEBUG_TYPE_COFF* = 1
  IMAGE_DEBUG_TYPE_CODEVIEW* = 2
  IMAGE_DEBUG_TYPE_FPO* = 3
  IMAGE_DEBUG_TYPE_MISC* = 4
  IMAGE_DEBUG_TYPE_EXCEPTION* = 5
  IMAGE_DEBUG_TYPE_FIXUP* = 6
  IMAGE_DEBUG_TYPE_OMAP_TO_SRC* = 7
  IMAGE_DEBUG_TYPE_OMAP_FROM_SRC* = 8
  IMAGE_DEBUG_TYPE_BORLAND* = 9
  IMAGE_DEBUG_TYPE_RESERVED10* = 10
  IMAGE_DEBUG_TYPE_CLSID* = 11
  FRAME_FPO* = 0
  FRAME_TRAP* = 1
  FRAME_TSS* = 2
  FRAME_NONFPO* = 3
  SIZEOF_RFPO_DATA* = 16
  IMAGE_DEBUG_MISC_EXENAME* = 1
  IMAGE_SEPARATE_DEBUG_SIGNATURE* = 0x4944
  NON_PAGED_DEBUG_SIGNATURE* = 0x494E
  IMAGE_SEPARATE_DEBUG_FLAGS_MASK* = 0x8000
  IMAGE_SEPARATE_DEBUG_MISMATCH* = 0x8000
  IMPORT_OBJECT_HDR_SIG2* = 0xffff
  IMPORT_OBJECT_CODE* = 0
  IMPORT_OBJECT_DATA* = 1
  IMPORT_OBJECT_CONST* = 2
  IMPORT_OBJECT_ORDINAL* = 0
  IMPORT_OBJECT_NAME* = 1
  IMPORT_OBJECT_NAME_NO_PREFIX* = 2
  IMPORT_OBJECT_NAME_UNDECORATE* = 3
  COMIMAGE_FLAGS_ILONLY* = 0x00000001
  COMIMAGE_FLAGS_32BITREQUIRED* = 0x00000002
  COMIMAGE_FLAGS_IL_LIBRARY* = 0x00000004
  COMIMAGE_FLAGS_STRONGNAMESIGNED* = 0x00000008
  COMIMAGE_FLAGS_TRACKDEBUGDATA* = 0x00010000
  COR_VERSION_MAJOR_V2* = 2
  COR_VERSION_MAJOR* = COR_VERSION_MAJOR_V2
  COR_VERSION_MINOR* = 0
  COR_DELETED_NAME_LENGTH* = 8
  COR_VTABLEGAP_NAME_LENGTH* = 8
  NATIVE_TYPE_MAX_CB* = 1
  COR_ILMETHOD_SECT_SMALL_MAX_DATASIZE* = 0xFF
  IMAGE_COR_MIH_METHODRVA* = 0x01
  IMAGE_COR_MIH_EHRVA* = 0x02
  IMAGE_COR_MIH_BASICBLOCK* = 0x08
  COR_VTABLE_32BIT* = 0x01
  COR_VTABLE_64BIT* = 0x02
  COR_VTABLE_FROM_UNMANAGED* = 0x04
  COR_VTABLE_CALL_MOST_DERIVED* = 0x10
  IMAGE_COR_EATJ_THUNK_SIZE* = 32
  MAX_CLASS_NAME* = 1024
  MAX_PACKAGE_NAME* = 1024
  RTL_RUN_ONCE_INIT* = [0'u8]
  RTL_RUN_ONCE_CHECK_ONLY* = 1
  RTL_RUN_ONCE_ASYNC* = 2
  RTL_RUN_ONCE_INIT_FAILED* = 4
  RTL_RUN_ONCE_CTX_RESERVED_BITS* = 2
  FAST_FAIL_LEGACY_GS_VIOLATION* = 0
  FAST_FAIL_VTGUARD_CHECK_FAILURE* = 1
  FAST_FAIL_STACK_COOKIE_CHECK_FAILURE* = 2
  FAST_FAIL_CORRUPT_LIST_ENTRY* = 3
  FAST_FAIL_INCORRECT_STACK* = 4
  FAST_FAIL_INVALID_ARG* = 5
  FAST_FAIL_GS_COOKIE_INIT* = 6
  FAST_FAIL_FATAL_APP_EXIT* = 7
  FAST_FAIL_RANGE_CHECK_FAILURE* = 8
  FAST_FAIL_UNSAFE_REGISTRY_ACCESS* = 9
  FAST_FAIL_INVALID_FAST_FAIL_CODE* = 0xffffffff'i32
  HEAP_NO_SERIALIZE* = 0x00000001
  HEAP_GROWABLE* = 0x00000002
  HEAP_GENERATE_EXCEPTIONS* = 0x00000004
  HEAP_ZERO_MEMORY* = 0x00000008
  HEAP_REALLOC_IN_PLACE_ONLY* = 0x00000010
  HEAP_TAIL_CHECKING_ENABLED* = 0x00000020
  HEAP_FREE_CHECKING_ENABLED* = 0x00000040
  HEAP_DISABLE_COALESCE_ON_FREE* = 0x00000080
  HEAP_CREATE_ALIGN_16* = 0x00010000
  HEAP_CREATE_ENABLE_TRACING* = 0x00020000
  HEAP_CREATE_ENABLE_EXECUTE* = 0x00040000
  HEAP_MAXIMUM_TAG* = 0x0FFF
  HEAP_PSEUDO_TAG_FLAG* = 0x8000
  HEAP_TAG_SHIFT* = 18
  IS_TEXT_UNICODE_ASCII16* = 0x0001
  IS_TEXT_UNICODE_REVERSE_ASCII16* = 0x0010
  IS_TEXT_UNICODE_STATISTICS* = 0x0002
  IS_TEXT_UNICODE_REVERSE_STATISTICS* = 0x0020
  IS_TEXT_UNICODE_CONTROLS* = 0x0004
  IS_TEXT_UNICODE_REVERSE_CONTROLS* = 0x0040
  IS_TEXT_UNICODE_SIGNATURE* = 0x0008
  IS_TEXT_UNICODE_REVERSE_SIGNATURE* = 0x0080
  IS_TEXT_UNICODE_ILLEGAL_CHARS* = 0x0100
  IS_TEXT_UNICODE_ODD_LENGTH* = 0x0200
  IS_TEXT_UNICODE_DBCS_LEADBYTE* = 0x0400
  IS_TEXT_UNICODE_NULL_BYTES* = 0x1000
  IS_TEXT_UNICODE_UNICODE_MASK* = 0x000F
  IS_TEXT_UNICODE_REVERSE_MASK* = 0x00F0
  IS_TEXT_UNICODE_NOT_UNICODE_MASK* = 0x0F00
  IS_TEXT_UNICODE_NOT_ASCII_MASK* = 0xF000
  COMPRESSION_FORMAT_NONE* = 0x0000
  COMPRESSION_FORMAT_DEFAULT* = 0x0001
  COMPRESSION_FORMAT_LZNT1* = 0x0002
  COMPRESSION_FORMAT_XPRESS* = 0x0003
  COMPRESSION_FORMAT_XPRESS_HUFF* = 0x0004
  COMPRESSION_ENGINE_STANDARD* = 0x0000
  COMPRESSION_ENGINE_MAXIMUM* = 0x0100
  COMPRESSION_ENGINE_HIBER* = 0x0200
  SEF_DACL_AUTO_INHERIT* = 0x01
  SEF_SACL_AUTO_INHERIT* = 0x02
  SEF_DEFAULT_DESCRIPTOR_FOR_OBJECT* = 0x04
  SEF_AVOID_PRIVILEGE_CHECK* = 0x08
  SEF_AVOID_OWNER_CHECK* = 0x10
  SEF_DEFAULT_OWNER_FROM_PARENT* = 0x20
  SEF_DEFAULT_GROUP_FROM_PARENT* = 0x40
  SEF_MACL_NO_WRITE_UP* = 0x100
  SEF_MACL_NO_READ_UP* = 0x200
  SEF_MACL_NO_EXECUTE_UP* = 0x400
  SEF_AVOID_OWNER_RESTRICTION* = 0x1000
  SEF_MACL_VALID_FLAGS* = SEF_MACL_NO_WRITE_UP or SEF_MACL_NO_READ_UP or SEF_MACL_NO_EXECUTE_UP
  MESSAGE_RESOURCE_UNICODE* = 0x0001
  VER_EQUAL* = 1
  VER_GREATER* = 2
  VER_GREATER_EQUAL* = 3
  VER_LESS* = 4
  VER_LESS_EQUAL* = 5
  VER_AND* = 6
  VER_OR* = 7
  VER_CONDITION_MASK* = 7
  VER_NUM_BITS_PER_CONDITION_MASK* = 3
  VER_MINORVERSION* = 0x0000001
  VER_MAJORVERSION* = 0x0000002
  VER_BUILDNUMBER* = 0x0000004
  VER_PLATFORMID* = 0x0000008
  VER_SERVICEPACKMINOR* = 0x0000010
  VER_SERVICEPACKMAJOR* = 0x0000020
  VER_SUITENAME* = 0x0000040
  VER_PRODUCT_TYPE* = 0x0000080
  VER_NT_WORKSTATION* = 0x0000001
  VER_NT_DOMAIN_CONTROLLER* = 0x0000002
  VER_NT_SERVER* = 0x0000003
  VER_PLATFORM_WIN32s* = 0
  VER_PLATFORM_WIN32_WINDOWS* = 1
  VER_PLATFORM_WIN32_NT* = 2
  RTL_UMS_VERSION* = 0x0100
  umsThreadInvalidInfoClass* = 0
  umsThreadUserContext* = 1
  umsThreadPriority* = 2
  umsThreadAffinity* = 3
  umsThreadTeb* = 4
  umsThreadIsSuspended* = 5
  umsThreadIsTerminated* = 6
  umsThreadMaxInfoClass* = 7
  umsSchedulerStartup* = 0
  umsSchedulerThreadBlocked* = 1
  umsSchedulerThreadYield* = 2
  VRL_PREDEFINED_CLASS_BEGIN* = 1
  VRL_CUSTOM_CLASS_BEGIN* = 1 shl 8
  VRL_CLASS_CONSISTENCY* = VRL_PREDEFINED_CLASS_BEGIN
  VRL_ENABLE_KERNEL_BREAKS* = 1 shl 31
  CTMF_INCLUDE_APPCONTAINER* = 0x1
  CTMF_VALID_FLAGS* = CTMF_INCLUDE_APPCONTAINER
  RTL_CRITSECT_TYPE* = 0
  RTL_RESOURCE_TYPE* = 1
  RTL_CRITICAL_SECTION_FLAG_NO_DEBUG_INFO* = 0x01000000
  RTL_CRITICAL_SECTION_FLAG_DYNAMIC_SPIN* = 0x02000000
  RTL_CRITICAL_SECTION_FLAG_STATIC_INIT* = 0x04000000
  RTL_CRITICAL_SECTION_FLAG_RESOURCE_TYPE* = 0x08000000
  RTL_CRITICAL_SECTION_FLAG_FORCE_DEBUG_INFO* = 0x10000000
  RTL_CRITICAL_SECTION_ALL_FLAG_BITS* = 0xff000000'i32
  RTL_CRITICAL_SECTION_FLAG_RESERVED* = RTL_CRITICAL_SECTION_ALL_FLAG_BITS and (not (RTL_CRITICAL_SECTION_FLAG_NO_DEBUG_INFO or RTL_CRITICAL_SECTION_FLAG_DYNAMIC_SPIN or RTL_CRITICAL_SECTION_FLAG_STATIC_INIT or RTL_CRITICAL_SECTION_FLAG_RESOURCE_TYPE or RTL_CRITICAL_SECTION_FLAG_FORCE_DEBUG_INFO))
  RTL_CRITICAL_SECTION_DEBUG_FLAG_STATIC_INIT* = 0x00000001
  RTL_SRWLOCK_INIT* = [0'u8]
  RTL_CONDITION_VARIABLE_INIT* = [0'u8]
  RTL_CONDITION_VARIABLE_LOCKMODE_SHARED* = 0x1
  heapCompatibilityInformation* = 0
  heapEnableTerminationOnCorruption* = 1
  WT_EXECUTEDEFAULT* = 0x00000000
  WT_EXECUTEINIOTHREAD* = 0x00000001
  WT_EXECUTEINUITHREAD* = 0x00000002
  WT_EXECUTEINWAITTHREAD* = 0x00000004
  WT_EXECUTEONLYONCE* = 0x00000008
  WT_EXECUTEINTIMERTHREAD* = 0x00000020
  WT_EXECUTELONGFUNCTION* = 0x00000010
  WT_EXECUTEINPERSISTENTIOTHREAD* = 0x00000040
  WT_EXECUTEINPERSISTENTTHREAD* = 0x00000080
  WT_TRANSFER_IMPERSONATION* = 0x00000100
  WT_EXECUTEDELETEWAIT* = 0x00000008
  WT_EXECUTEINLONGTHREAD* = 0x00000010
  activationContextBasicInformation* = 1
  activationContextDetailedInformation* = 2
  assemblyDetailedInformationInActivationContext* = 3
  fileInformationInAssemblyOfAssemblyInActivationContext* = 4
  runlevelInformationInActivationContext* = 5
  compatibilityInformationInActivationContext* = 6
  activationContextManifestResourceName* = 7
  maxActivationContextInfoClass* = 8
  assemblyDetailedInformationInActivationContxt* = 3
  fileInformationInAssemblyOfAssemblyInActivationContxt* = 4
  ACTCTX_RUN_LEVEL_UNSPECIFIED* = 0
  ACTCTX_RUN_LEVEL_AS_INVOKER* = 1
  ACTCTX_RUN_LEVEL_HIGHEST_AVAILABLE* = 2
  ACTCTX_RUN_LEVEL_REQUIRE_ADMIN* = 3
  ACTCTX_RUN_LEVEL_NUMBERS* = 4
  ACTCTX_COMPATIBILITY_ELEMENT_TYPE_UNKNOWN* = 0
  ACTCTX_COMPATIBILITY_ELEMENT_TYPE_OS* = 1
  ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MITIGATION* = 2
  ACTIVATION_CONTEXT_PATH_TYPE_NONE* = 1
  ACTIVATION_CONTEXT_PATH_TYPE_WIN32_FILE* = 2
  ACTIVATION_CONTEXT_PATH_TYPE_URL* = 3
  ACTIVATION_CONTEXT_PATH_TYPE_ASSEMBLYREF* = 4
  INVALID_OS_COUNT* = 0xffff
  CREATE_BOUNDARY_DESCRIPTOR_ADD_APPCONTAINER_SID* = 0x1
  RTL_VRF_FLG_FULL_PAGE_HEAP* = 0x00000001
  RTL_VRF_FLG_RESERVED_DONOTUSE* = 0x00000002
  RTL_VRF_FLG_HANDLE_CHECKS* = 0x00000004
  RTL_VRF_FLG_STACK_CHECKS* = 0x00000008
  RTL_VRF_FLG_APPCOMPAT_CHECKS* = 0x00000010
  RTL_VRF_FLG_TLS_CHECKS* = 0x00000020
  RTL_VRF_FLG_DIRTY_STACKS* = 0x00000040
  RTL_VRF_FLG_RPC_CHECKS* = 0x00000080
  RTL_VRF_FLG_COM_CHECKS* = 0x00000100
  RTL_VRF_FLG_DANGEROUS_APIS* = 0x00000200
  RTL_VRF_FLG_RACE_CHECKS* = 0x00000400
  RTL_VRF_FLG_DEADLOCK_CHECKS* = 0x00000800
  RTL_VRF_FLG_FIRST_CHANCE_EXCEPTION_CHECKS* = 0x00001000
  RTL_VRF_FLG_VIRTUAL_MEM_CHECKS* = 0x00002000
  RTL_VRF_FLG_ENABLE_LOGGING* = 0x00004000
  RTL_VRF_FLG_FAST_FILL_HEAP* = 0x00008000
  RTL_VRF_FLG_VIRTUAL_SPACE_TRACKING* = 0x00010000
  RTL_VRF_FLG_ENABLED_SYSTEM_WIDE* = 0x00020000
  RTL_VRF_FLG_MISCELLANEOUS_CHECKS* = 0x00020000
  RTL_VRF_FLG_LOCK_CHECKS* = 0x00040000
  APPLICATION_VERIFIER_INTERNAL_ERROR* = 0x80000000'i32
  APPLICATION_VERIFIER_INTERNAL_WARNING* = 0x40000000
  APPLICATION_VERIFIER_NO_BREAK* = 0x20000000
  APPLICATION_VERIFIER_CONTINUABLE_BREAK* = 0x10000000
  APPLICATION_VERIFIER_UNKNOWN_ERROR* = 0x0001
  APPLICATION_VERIFIER_ACCESS_VIOLATION* = 0x0002
  APPLICATION_VERIFIER_UNSYNCHRONIZED_ACCESS* = 0x0003
  APPLICATION_VERIFIER_EXTREME_SIZE_REQUEST* = 0x0004
  APPLICATION_VERIFIER_BAD_HEAP_HANDLE* = 0x0005
  APPLICATION_VERIFIER_SWITCHED_HEAP_HANDLE* = 0x0006
  APPLICATION_VERIFIER_DOUBLE_FREE* = 0x0007
  APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK* = 0x0008
  APPLICATION_VERIFIER_DESTROY_PROCESS_HEAP* = 0x0009
  APPLICATION_VERIFIER_UNEXPECTED_EXCEPTION* = 0x000A
  APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_EXCEPTION_RAISED_FOR_HEADER* = 0x000B
  APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_EXCEPTION_RAISED_FOR_PROBING* = 0x000C
  APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_HEADER* = 0x000D
  APPLICATION_VERIFIER_CORRUPTED_FREED_HEAP_BLOCK* = 0x000E
  APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_SUFFIX* = 0x000F
  APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_START_STAMP* = 0x0010
  APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_END_STAMP* = 0x0011
  APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_PREFIX* = 0x0012
  APPLICATION_VERIFIER_FIRST_CHANCE_ACCESS_VIOLATION* = 0x0013
  APPLICATION_VERIFIER_CORRUPTED_HEAP_LIST* = 0x0014
  APPLICATION_VERIFIER_TERMINATE_THREAD_CALL* = 0x0100
  APPLICATION_VERIFIER_STACK_OVERFLOW* = 0x0101
  APPLICATION_VERIFIER_INVALID_EXIT_PROCESS_CALL* = 0x0102
  APPLICATION_VERIFIER_EXIT_THREAD_OWNS_LOCK* = 0x0200
  APPLICATION_VERIFIER_LOCK_IN_UNLOADED_DLL* = 0x0201
  APPLICATION_VERIFIER_LOCK_IN_FREED_HEAP* = 0x0202
  APPLICATION_VERIFIER_LOCK_DOUBLE_INITIALIZE* = 0x0203
  APPLICATION_VERIFIER_LOCK_IN_FREED_MEMORY* = 0x0204
  APPLICATION_VERIFIER_LOCK_CORRUPTED* = 0x0205
  APPLICATION_VERIFIER_LOCK_INVALID_OWNER* = 0x0206
  APPLICATION_VERIFIER_LOCK_INVALID_RECURSION_COUNT* = 0x0207
  APPLICATION_VERIFIER_LOCK_INVALID_LOCK_COUNT* = 0x0208
  APPLICATION_VERIFIER_LOCK_OVER_RELEASED* = 0x0209
  APPLICATION_VERIFIER_LOCK_NOT_INITIALIZED* = 0x0210
  APPLICATION_VERIFIER_LOCK_ALREADY_INITIALIZED* = 0x0211
  APPLICATION_VERIFIER_LOCK_IN_FREED_VMEM* = 0x0212
  APPLICATION_VERIFIER_LOCK_IN_UNMAPPED_MEM* = 0x0213
  APPLICATION_VERIFIER_THREAD_NOT_LOCK_OWNER* = 0x0214
  APPLICATION_VERIFIER_INVALID_HANDLE* = 0x0300
  APPLICATION_VERIFIER_INVALID_TLS_VALUE* = 0x0301
  APPLICATION_VERIFIER_INCORRECT_WAIT_CALL* = 0x0302
  APPLICATION_VERIFIER_NULL_HANDLE* = 0x0303
  APPLICATION_VERIFIER_WAIT_IN_DLLMAIN* = 0x0304
  APPLICATION_VERIFIER_COM_ERROR* = 0x0400
  APPLICATION_VERIFIER_COM_API_IN_DLLMAIN* = 0x0401
  APPLICATION_VERIFIER_COM_UNHANDLED_EXCEPTION* = 0x0402
  APPLICATION_VERIFIER_COM_UNBALANCED_COINIT* = 0x0403
  APPLICATION_VERIFIER_COM_UNBALANCED_OLEINIT* = 0x0404
  APPLICATION_VERIFIER_COM_UNBALANCED_SWC* = 0x0405
  APPLICATION_VERIFIER_COM_NULL_DACL* = 0x0406
  APPLICATION_VERIFIER_COM_UNSAFE_IMPERSONATION* = 0x0407
  APPLICATION_VERIFIER_COM_SMUGGLED_WRAPPER* = 0x0408
  APPLICATION_VERIFIER_COM_SMUGGLED_PROXY* = 0x0409
  APPLICATION_VERIFIER_COM_CF_SUCCESS_WITH_NULL* = 0x040A
  APPLICATION_VERIFIER_COM_GCO_SUCCESS_WITH_NULL* = 0x040B
  APPLICATION_VERIFIER_COM_OBJECT_IN_FREED_MEMORY* = 0x040C
  APPLICATION_VERIFIER_COM_OBJECT_IN_UNLOADED_DLL* = 0x040D
  APPLICATION_VERIFIER_COM_VTBL_IN_FREED_MEMORY* = 0x040E
  APPLICATION_VERIFIER_COM_VTBL_IN_UNLOADED_DLL* = 0x040F
  APPLICATION_VERIFIER_COM_HOLDING_LOCKS_ON_CALL* = 0x0410
  APPLICATION_VERIFIER_RPC_ERROR* = 0x0500
  APPLICATION_VERIFIER_INVALID_FREEMEM* = 0x0600
  APPLICATION_VERIFIER_INVALID_ALLOCMEM* = 0x0601
  APPLICATION_VERIFIER_INVALID_MAPVIEW* = 0x0602
  APPLICATION_VERIFIER_PROBE_INVALID_ADDRESS* = 0x0603
  APPLICATION_VERIFIER_PROBE_FREE_MEM* = 0x0604
  APPLICATION_VERIFIER_PROBE_GUARD_PAGE* = 0x0605
  APPLICATION_VERIFIER_PROBE_NULL* = 0x0606
  APPLICATION_VERIFIER_PROBE_INVALID_START_OR_SIZE* = 0x0607
  APPLICATION_VERIFIER_SIZE_HEAP_UNEXPECTED_EXCEPTION* = 0x0618
  PERFORMANCE_DATA_VERSION* = 1
  READ_THREAD_PROFILING_FLAG_DISPATCHING* = 0x00000001
  READ_THREAD_PROFILING_FLAG_HARDWARE_COUNTERS* = 0x00000002
  DLL_PROCESS_ATTACH* = 1
  DLL_THREAD_ATTACH* = 2
  DLL_THREAD_DETACH* = 3
  DLL_PROCESS_DETACH* = 0
  DLL_PROCESS_VERIFIER* = 4
  EVENTLOG_SEQUENTIAL_READ* = 0x0001
  EVENTLOG_SEEK_READ* = 0x0002
  EVENTLOG_FORWARDS_READ* = 0x0004
  EVENTLOG_BACKWARDS_READ* = 0x0008
  EVENTLOG_SUCCESS* = 0x0000
  EVENTLOG_ERROR_TYPE* = 0x0001
  EVENTLOG_WARNING_TYPE* = 0x0002
  EVENTLOG_INFORMATION_TYPE* = 0x0004
  EVENTLOG_AUDIT_SUCCESS* = 0x0008
  EVENTLOG_AUDIT_FAILURE* = 0x0010
  EVENTLOG_START_PAIRED_EVENT* = 0x0001
  EVENTLOG_END_PAIRED_EVENT* = 0x0002
  EVENTLOG_END_ALL_PAIRED_EVENTS* = 0x0004
  EVENTLOG_PAIRED_EVENT_ACTIVE* = 0x0008
  EVENTLOG_PAIRED_EVENT_INACTIVE* = 0x0010
  KEY_QUERY_VALUE* = 0x0001
  KEY_SET_VALUE* = 0x0002
  KEY_CREATE_SUB_KEY* = 0x0004
  KEY_ENUMERATE_SUB_KEYS* = 0x0008
  KEY_NOTIFY* = 0x0010
  KEY_CREATE_LINK* = 0x0020
  KEY_WOW64_64KEY* = 0x0100
  KEY_WOW64_32KEY* = 0x0200
  KEY_WOW64_RES* = 0x0300
  KEY_READ* = (STANDARD_RIGHTS_READ or KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS or KEY_NOTIFY) and (not SYNCHRONIZE)
  KEY_WRITE* = (STANDARD_RIGHTS_WRITE or KEY_SET_VALUE or KEY_CREATE_SUB_KEY) and (not SYNCHRONIZE)
  KEY_EXECUTE* = (KEY_READ) and (not SYNCHRONIZE)
  KEY_ALL_ACCESS* = (STANDARD_RIGHTS_ALL or KEY_QUERY_VALUE or KEY_SET_VALUE or KEY_CREATE_SUB_KEY or KEY_ENUMERATE_SUB_KEYS or KEY_NOTIFY or KEY_CREATE_LINK) and (not SYNCHRONIZE)
  REG_OPTION_RESERVED* = 0x00000000
  REG_OPTION_NON_VOLATILE* = 0x00000000
  REG_OPTION_VOLATILE* = 0x00000001
  REG_OPTION_CREATE_LINK* = 0x00000002
  REG_OPTION_BACKUP_RESTORE* = 0x00000004
  REG_OPTION_OPEN_LINK* = 0x00000008
  REG_LEGAL_OPTION* = REG_OPTION_RESERVED or REG_OPTION_NON_VOLATILE or REG_OPTION_VOLATILE or REG_OPTION_CREATE_LINK or REG_OPTION_BACKUP_RESTORE or REG_OPTION_OPEN_LINK
  REG_CREATED_NEW_KEY* = 0x00000001
  REG_OPENED_EXISTING_KEY* = 0x00000002
  REG_STANDARD_FORMAT* = 1
  REG_LATEST_FORMAT* = 2
  REG_NO_COMPRESSION* = 4
  REG_WHOLE_HIVE_VOLATILE* = 0x00000001
  REG_REFRESH_HIVE* = 0x00000002
  REG_NO_LAZY_FLUSH* = 0x00000004
  REG_FORCE_RESTORE* = 0x00000008
  REG_APP_HIVE* = 0x00000010
  REG_PROCESS_PRIVATE* = 0x00000020
  REG_START_JOURNAL* = 0x00000040
  REG_HIVE_EXACT_FILE_GROWTH* = 0x00000080
  REG_HIVE_NO_RM* = 0x00000100
  REG_HIVE_SINGLE_LOG* = 0x00000200
  REG_BOOT_HIVE* = 0x00000400
  REG_FORCE_UNLOAD* = 1
  REG_NOTIFY_CHANGE_NAME* = 0x00000001
  REG_NOTIFY_CHANGE_ATTRIBUTES* = 0x00000002
  REG_NOTIFY_CHANGE_LAST_SET* = 0x00000004
  REG_NOTIFY_CHANGE_SECURITY* = 0x00000008
  REG_NOTIFY_THREAD_AGNOSTIC* = 0x10000000
  REG_LEGAL_CHANGE_FILTER* = REG_NOTIFY_CHANGE_NAME or REG_NOTIFY_CHANGE_ATTRIBUTES or REG_NOTIFY_CHANGE_LAST_SET or REG_NOTIFY_CHANGE_SECURITY or REG_NOTIFY_THREAD_AGNOSTIC
  REG_NONE* = 0
  REG_SZ* = 1
  REG_EXPAND_SZ* = 2
  REG_BINARY* = 3
  REG_DWORD* = 4
  REG_DWORD_LITTLE_ENDIAN* = 4
  REG_DWORD_BIG_ENDIAN* = 5
  REG_LINK* = 6
  REG_MULTI_SZ* = 7
  REG_RESOURCE_LIST* = 8
  REG_FULL_RESOURCE_DESCRIPTOR* = 9
  REG_RESOURCE_REQUIREMENTS_LIST* = 10
  REG_QWORD* = 11
  REG_QWORD_LITTLE_ENDIAN* = 11
  SERVICE_KERNEL_DRIVER* = 0x00000001
  SERVICE_FILE_SYSTEM_DRIVER* = 0x00000002
  SERVICE_ADAPTER* = 0x00000004
  SERVICE_RECOGNIZER_DRIVER* = 0x00000008
  SERVICE_DRIVER* = SERVICE_KERNEL_DRIVER or SERVICE_FILE_SYSTEM_DRIVER or SERVICE_RECOGNIZER_DRIVER
  SERVICE_WIN32_OWN_PROCESS* = 0x00000010
  SERVICE_WIN32_SHARE_PROCESS* = 0x00000020
  SERVICE_WIN32* = SERVICE_WIN32_OWN_PROCESS or SERVICE_WIN32_SHARE_PROCESS
  SERVICE_INTERACTIVE_PROCESS* = 0x00000100
  SERVICE_TYPE_ALL* = SERVICE_WIN32 or SERVICE_ADAPTER or SERVICE_DRIVER or SERVICE_INTERACTIVE_PROCESS
  SERVICE_BOOT_START* = 0x00000000
  SERVICE_SYSTEM_START* = 0x00000001
  SERVICE_AUTO_START* = 0x00000002
  SERVICE_DEMAND_START* = 0x00000003
  SERVICE_DISABLED* = 0x00000004
  SERVICE_ERROR_IGNORE* = 0x00000000
  SERVICE_ERROR_NORMAL* = 0x00000001
  SERVICE_ERROR_SEVERE* = 0x00000002
  SERVICE_ERROR_CRITICAL* = 0x00000003
  driverType* = SERVICE_KERNEL_DRIVER
  fileSystemType* = SERVICE_FILE_SYSTEM_DRIVER
  win32ServiceOwnProcess* = SERVICE_WIN32_OWN_PROCESS
  win32ServiceShareProcess* = SERVICE_WIN32_SHARE_PROCESS
  adapterType* = SERVICE_ADAPTER
  recognizerType* = SERVICE_RECOGNIZER_DRIVER
  bootLoad* = SERVICE_BOOT_START
  systemLoad* = SERVICE_SYSTEM_START
  autoLoad* = SERVICE_AUTO_START
  demandLoad* = SERVICE_DEMAND_START
  disableLoad* = SERVICE_DISABLED
  ignoreError* = SERVICE_ERROR_IGNORE
  normalError* = SERVICE_ERROR_NORMAL
  severeError* = SERVICE_ERROR_SEVERE
  criticalError* = SERVICE_ERROR_CRITICAL
  CM_SERVICE_NETWORK_BOOT_LOAD* = 0x00000001
  CM_SERVICE_VIRTUAL_DISK_BOOT_LOAD* = 0x00000002
  CM_SERVICE_USB_DISK_BOOT_LOAD* = 0x00000004
  CM_SERVICE_SD_DISK_BOOT_LOAD* = 0x00000008
  CM_SERVICE_USB3_DISK_BOOT_LOAD* = 0x00000010
  CM_SERVICE_MEASURED_BOOT_LOAD* = 0x00000020
  CM_SERVICE_VERIFIER_BOOT_LOAD* = 0x00000040
  CM_SERVICE_WINPE_BOOT_LOAD* = 0x00000080
  CM_SERVICE_VALID_PROMOTION_MASK* = CM_SERVICE_NETWORK_BOOT_LOAD or CM_SERVICE_VIRTUAL_DISK_BOOT_LOAD or CM_SERVICE_USB_DISK_BOOT_LOAD or CM_SERVICE_SD_DISK_BOOT_LOAD or CM_SERVICE_USB3_DISK_BOOT_LOAD or CM_SERVICE_MEASURED_BOOT_LOAD or CM_SERVICE_VERIFIER_BOOT_LOAD or CM_SERVICE_WINPE_BOOT_LOAD
  TAPE_ERASE_SHORT* = 0
  TAPE_ERASE_LONG* = 1
  TAPE_LOAD* = 0
  TAPE_UNLOAD* = 1
  TAPE_TENSION* = 2
  TAPE_LOCK* = 3
  TAPE_UNLOCK* = 4
  TAPE_FORMAT* = 5
  TAPE_SETMARKS* = 0
  TAPE_FILEMARKS* = 1
  TAPE_SHORT_FILEMARKS* = 2
  TAPE_LONG_FILEMARKS* = 3
  TAPE_ABSOLUTE_POSITION* = 0
  TAPE_LOGICAL_POSITION* = 1
  TAPE_PSEUDO_LOGICAL_POSITION* = 2
  TAPE_REWIND* = 0
  TAPE_ABSOLUTE_BLOCK* = 1
  TAPE_LOGICAL_BLOCK* = 2
  TAPE_PSEUDO_LOGICAL_BLOCK* = 3
  TAPE_SPACE_END_OF_DATA* = 4
  TAPE_SPACE_RELATIVE_BLOCKS* = 5
  TAPE_SPACE_FILEMARKS* = 6
  TAPE_SPACE_SEQUENTIAL_FMKS* = 7
  TAPE_SPACE_SETMARKS* = 8
  TAPE_SPACE_SEQUENTIAL_SMKS* = 9
  TAPE_DRIVE_FIXED* = 0x00000001
  TAPE_DRIVE_SELECT* = 0x00000002
  TAPE_DRIVE_INITIATOR* = 0x00000004
  TAPE_DRIVE_ERASE_SHORT* = 0x00000010
  TAPE_DRIVE_ERASE_LONG* = 0x00000020
  TAPE_DRIVE_ERASE_BOP_ONLY* = 0x00000040
  TAPE_DRIVE_ERASE_IMMEDIATE* = 0x00000080
  TAPE_DRIVE_TAPE_CAPACITY* = 0x00000100
  TAPE_DRIVE_TAPE_REMAINING* = 0x00000200
  TAPE_DRIVE_FIXED_BLOCK* = 0x00000400
  TAPE_DRIVE_VARIABLE_BLOCK* = 0x00000800
  TAPE_DRIVE_WRITE_PROTECT* = 0x00001000
  TAPE_DRIVE_EOT_WZ_SIZE* = 0x00002000
  TAPE_DRIVE_ECC* = 0x00010000
  TAPE_DRIVE_COMPRESSION* = 0x00020000
  TAPE_DRIVE_PADDING* = 0x00040000
  TAPE_DRIVE_REPORT_SMKS* = 0x00080000
  TAPE_DRIVE_GET_ABSOLUTE_BLK* = 0x00100000
  TAPE_DRIVE_GET_LOGICAL_BLK* = 0x00200000
  TAPE_DRIVE_SET_EOT_WZ_SIZE* = 0x00400000
  TAPE_DRIVE_EJECT_MEDIA* = 0x01000000
  TAPE_DRIVE_CLEAN_REQUESTS* = 0x02000000
  TAPE_DRIVE_SET_CMP_BOP_ONLY* = 0x04000000
  TAPE_DRIVE_RESERVED_BIT* = 0x80000000'i32
  TAPE_DRIVE_LOAD_UNLOAD* = 0x80000001'i32
  TAPE_DRIVE_TENSION* = 0x80000002'i32
  TAPE_DRIVE_LOCK_UNLOCK* = 0x80000004'i32
  TAPE_DRIVE_REWIND_IMMEDIATE* = 0x80000008'i32
  TAPE_DRIVE_SET_BLOCK_SIZE* = 0x80000010'i32
  TAPE_DRIVE_LOAD_UNLD_IMMED* = 0x80000020'i32
  TAPE_DRIVE_TENSION_IMMED* = 0x80000040'i32
  TAPE_DRIVE_LOCK_UNLK_IMMED* = 0x80000080'i32
  TAPE_DRIVE_SET_ECC* = 0x80000100'i32
  TAPE_DRIVE_SET_COMPRESSION* = 0x80000200'i32
  TAPE_DRIVE_SET_PADDING* = 0x80000400'i32
  TAPE_DRIVE_SET_REPORT_SMKS* = 0x80000800'i32
  TAPE_DRIVE_ABSOLUTE_BLK* = 0x80001000'i32
  TAPE_DRIVE_ABS_BLK_IMMED* = 0x80002000'i32
  TAPE_DRIVE_LOGICAL_BLK* = 0x80004000'i32
  TAPE_DRIVE_LOG_BLK_IMMED* = 0x80008000'i32
  TAPE_DRIVE_END_OF_DATA* = 0x80010000'i32
  TAPE_DRIVE_RELATIVE_BLKS* = 0x80020000'i32
  TAPE_DRIVE_FILEMARKS* = 0x80040000'i32
  TAPE_DRIVE_SEQUENTIAL_FMKS* = 0x80080000'i32
  TAPE_DRIVE_SETMARKS* = 0x80100000'i32
  TAPE_DRIVE_SEQUENTIAL_SMKS* = 0x80200000'i32
  TAPE_DRIVE_REVERSE_POSITION* = 0x80400000'i32
  TAPE_DRIVE_SPACE_IMMEDIATE* = 0x80800000'i32
  TAPE_DRIVE_WRITE_SETMARKS* = 0x81000000'i32
  TAPE_DRIVE_WRITE_FILEMARKS* = 0x82000000'i32
  TAPE_DRIVE_WRITE_SHORT_FMKS* = 0x84000000'i32
  TAPE_DRIVE_WRITE_LONG_FMKS* = 0x88000000'i32
  TAPE_DRIVE_WRITE_MARK_IMMED* = 0x90000000'i32
  TAPE_DRIVE_FORMAT* = 0xA0000000'i32
  TAPE_DRIVE_FORMAT_IMMEDIATE* = 0xC0000000'i32
  TAPE_DRIVE_HIGH_FEATURES* = 0x80000000'i32
  TAPE_FIXED_PARTITIONS* = 0
  TAPE_SELECT_PARTITIONS* = 1
  TAPE_INITIATOR_PARTITIONS* = 2
  TAPE_QUERY_DRIVE_PARAMETERS* = 0
  TAPE_QUERY_MEDIA_CAPACITY* = 1
  TAPE_CHECK_FOR_DRIVE_PROBLEM* = 2
  TAPE_QUERY_IO_ERROR_DATA* = 3
  TAPE_QUERY_DEVICE_ERROR_DATA* = 4
  tapeDriveProblemNone* = 0
  tapeDriveReadWriteWarning* = 1
  tapeDriveReadWriteError* = 2
  tapeDriveReadWarning* = 3
  tapeDriveWriteWarning* = 4
  tapeDriveReadError* = 5
  tapeDriveWriteError* = 6
  tapeDriveHardwareError* = 7
  tapeDriveUnsupportedMedia* = 8
  tapeDriveScsiConnectionError* = 9
  tapeDriveTimetoClean* = 10
  tapeDriveCleanDriveNow* = 11
  tapeDriveMediaLifeExpired* = 12
  tapeDriveSnappedTape* = 13
  TP_CALLBACK_PRIORITY_HIGH* = 0
  TP_CALLBACK_PRIORITY_NORMAL* = 1
  TP_CALLBACK_PRIORITY_LOW* = 2
  TP_CALLBACK_PRIORITY_INVALID* = 3
  TP_CALLBACK_PRIORITY_COUNT* = TP_CALLBACK_PRIORITY_INVALID
  TRANSACTION_MANAGER_VOLATILE* = 0x00000001
  TRANSACTION_MANAGER_COMMIT_DEFAULT* = 0x00000000
  TRANSACTION_MANAGER_COMMIT_SYSTEM_VOLUME* = 0x00000002
  TRANSACTION_MANAGER_COMMIT_SYSTEM_HIVES* = 0x00000004
  TRANSACTION_MANAGER_COMMIT_LOWEST* = 0x00000008
  TRANSACTION_MANAGER_CORRUPT_FOR_RECOVERY* = 0x00000010
  TRANSACTION_MANAGER_CORRUPT_FOR_PROGRESS* = 0x00000020
  TRANSACTION_MANAGER_MAXIMUM_OPTION* = 0x0000003f
  TRANSACTION_DO_NOT_PROMOTE* = 0x00000001
  TRANSACTION_MAXIMUM_OPTION* = 0x00000001
  RESOURCE_MANAGER_VOLATILE* = 0x00000001
  RESOURCE_MANAGER_COMMUNICATION* = 0x00000002
  RESOURCE_MANAGER_MAXIMUM_OPTION* = 0x00000003
  CRM_PROTOCOL_EXPLICIT_MARSHAL_ONLY* = 0x00000001
  CRM_PROTOCOL_DYNAMIC_MARSHAL_INFO* = 0x00000002
  CRM_PROTOCOL_MAXIMUM_OPTION* = 0x00000003
  ENLISTMENT_SUPERIOR* = 0x00000001
  ENLISTMENT_MAXIMUM_OPTION* = 0x00000001
  TRANSACTION_NOTIFY_MASK* = 0x3fffffff
  TRANSACTION_NOTIFY_PREPREPARE* = 0x00000001
  TRANSACTION_NOTIFY_PREPARE* = 0x00000002
  TRANSACTION_NOTIFY_COMMIT* = 0x00000004
  TRANSACTION_NOTIFY_ROLLBACK* = 0x00000008
  TRANSACTION_NOTIFY_PREPREPARE_COMPLETE* = 0x00000010
  TRANSACTION_NOTIFY_PREPARE_COMPLETE* = 0x00000020
  TRANSACTION_NOTIFY_COMMIT_COMPLETE* = 0x00000040
  TRANSACTION_NOTIFY_ROLLBACK_COMPLETE* = 0x00000080
  TRANSACTION_NOTIFY_RECOVER* = 0x00000100
  TRANSACTION_NOTIFY_SINGLE_PHASE_COMMIT* = 0x00000200
  TRANSACTION_NOTIFY_DELEGATE_COMMIT* = 0x00000400
  TRANSACTION_NOTIFY_RECOVER_QUERY* = 0x00000800
  TRANSACTION_NOTIFY_ENLIST_PREPREPARE* = 0x00001000
  TRANSACTION_NOTIFY_LAST_RECOVER* = 0x00002000
  TRANSACTION_NOTIFY_INDOUBT* = 0x00004000
  TRANSACTION_NOTIFY_PROPAGATE_PULL* = 0x00008000
  TRANSACTION_NOTIFY_PROPAGATE_PUSH* = 0x00010000
  TRANSACTION_NOTIFY_MARSHAL* = 0x00020000
  TRANSACTION_NOTIFY_ENLIST_MASK* = 0x00040000
  TRANSACTION_NOTIFY_RM_DISCONNECTED* = 0x01000000
  TRANSACTION_NOTIFY_TM_ONLINE* = 0x02000000
  TRANSACTION_NOTIFY_COMMIT_REQUEST* = 0x04000000
  TRANSACTION_NOTIFY_PROMOTE* = 0x08000000
  TRANSACTION_NOTIFY_PROMOTE_NEW* = 0x10000000
  TRANSACTION_NOTIFY_REQUEST_OUTCOME* = 0x20000000
  TRANSACTION_NOTIFY_COMMIT_FINALIZE* = 0x40000000
  TRANSACTIONMANAGER_OBJECT_PATH* = "\\TransactionManager\\"
  TRANSACTION_OBJECT_PATH* = "\\Transaction\\"
  ENLISTMENT_OBJECT_PATH* = "\\Enlistment\\"
  RESOURCE_MANAGER_OBJECT_PATH* = "\\ResourceManager\\"
  TRANSACTION_NOTIFICATION_TM_ONLINE_FLAG_IS_CLUSTERED* = 0x1
  KTM_MARSHAL_BLOB_VERSION_MAJOR* = 1
  KTM_MARSHAL_BLOB_VERSION_MINOR* = 1
  MAX_RESOURCEMANAGER_DESCRIPTION_LENGTH* = 64
  TRANSACTIONMANAGER_QUERY_INFORMATION* = 0x00001
  TRANSACTIONMANAGER_SET_INFORMATION* = 0x00002
  TRANSACTIONMANAGER_RECOVER* = 0x00004
  TRANSACTIONMANAGER_RENAME* = 0x00008
  TRANSACTIONMANAGER_CREATE_RM* = 0x00010
  TRANSACTIONMANAGER_BIND_TRANSACTION* = 0x00020
  TRANSACTIONMANAGER_GENERIC_READ* = STANDARD_RIGHTS_READ or TRANSACTIONMANAGER_QUERY_INFORMATION
  TRANSACTIONMANAGER_GENERIC_WRITE* = STANDARD_RIGHTS_WRITE or TRANSACTIONMANAGER_SET_INFORMATION or TRANSACTIONMANAGER_RECOVER or TRANSACTIONMANAGER_RENAME or TRANSACTIONMANAGER_CREATE_RM
  TRANSACTIONMANAGER_GENERIC_EXECUTE* = STANDARD_RIGHTS_EXECUTE
  TRANSACTIONMANAGER_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or TRANSACTIONMANAGER_GENERIC_READ or TRANSACTIONMANAGER_GENERIC_WRITE or TRANSACTIONMANAGER_GENERIC_EXECUTE or TRANSACTIONMANAGER_BIND_TRANSACTION
  TRANSACTION_QUERY_INFORMATION* = 0x0001
  TRANSACTION_SET_INFORMATION* = 0x0002
  TRANSACTION_ENLIST* = 0x0004
  TRANSACTION_COMMIT* = 0x0008
  TRANSACTION_ROLLBACK* = 0x0010
  TRANSACTION_PROPAGATE* = 0x0020
  TRANSACTION_RIGHT_RESERVED1* = 0x0040
  TRANSACTION_GENERIC_READ* = STANDARD_RIGHTS_READ or TRANSACTION_QUERY_INFORMATION or SYNCHRONIZE
  TRANSACTION_GENERIC_WRITE* = STANDARD_RIGHTS_WRITE or TRANSACTION_SET_INFORMATION or TRANSACTION_COMMIT or TRANSACTION_ENLIST or TRANSACTION_ROLLBACK or TRANSACTION_PROPAGATE or SYNCHRONIZE
  TRANSACTION_GENERIC_EXECUTE* = STANDARD_RIGHTS_EXECUTE or TRANSACTION_COMMIT or TRANSACTION_ROLLBACK or SYNCHRONIZE
  TRANSACTION_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or TRANSACTION_GENERIC_READ or TRANSACTION_GENERIC_WRITE or TRANSACTION_GENERIC_EXECUTE
  TRANSACTION_RESOURCE_MANAGER_RIGHTS* = TRANSACTION_GENERIC_READ or STANDARD_RIGHTS_WRITE or TRANSACTION_SET_INFORMATION or TRANSACTION_ENLIST or TRANSACTION_ROLLBACK or TRANSACTION_PROPAGATE or SYNCHRONIZE
  RESOURCEMANAGER_QUERY_INFORMATION* = 0x0001
  RESOURCEMANAGER_SET_INFORMATION* = 0x0002
  RESOURCEMANAGER_RECOVER* = 0x0004
  RESOURCEMANAGER_ENLIST* = 0x0008
  RESOURCEMANAGER_GET_NOTIFICATION* = 0x0010
  RESOURCEMANAGER_REGISTER_PROTOCOL* = 0x0020
  RESOURCEMANAGER_COMPLETE_PROPAGATION* = 0x0040
  RESOURCEMANAGER_GENERIC_READ* = STANDARD_RIGHTS_READ or RESOURCEMANAGER_QUERY_INFORMATION or SYNCHRONIZE
  RESOURCEMANAGER_GENERIC_WRITE* = STANDARD_RIGHTS_WRITE or RESOURCEMANAGER_SET_INFORMATION or RESOURCEMANAGER_RECOVER or RESOURCEMANAGER_ENLIST or RESOURCEMANAGER_GET_NOTIFICATION or RESOURCEMANAGER_REGISTER_PROTOCOL or RESOURCEMANAGER_COMPLETE_PROPAGATION or SYNCHRONIZE
  RESOURCEMANAGER_GENERIC_EXECUTE* = STANDARD_RIGHTS_EXECUTE or RESOURCEMANAGER_RECOVER or RESOURCEMANAGER_ENLIST or RESOURCEMANAGER_GET_NOTIFICATION or RESOURCEMANAGER_COMPLETE_PROPAGATION or SYNCHRONIZE
  RESOURCEMANAGER_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or RESOURCEMANAGER_GENERIC_READ or RESOURCEMANAGER_GENERIC_WRITE or RESOURCEMANAGER_GENERIC_EXECUTE
  ENLISTMENT_QUERY_INFORMATION* = 1
  ENLISTMENT_SET_INFORMATION* = 2
  ENLISTMENT_RECOVER* = 4
  ENLISTMENT_SUBORDINATE_RIGHTS* = 8
  ENLISTMENT_SUPERIOR_RIGHTS* = 0x10
  ENLISTMENT_GENERIC_READ* = STANDARD_RIGHTS_READ or ENLISTMENT_QUERY_INFORMATION
  ENLISTMENT_GENERIC_WRITE* = STANDARD_RIGHTS_WRITE or ENLISTMENT_SET_INFORMATION or ENLISTMENT_RECOVER or ENLISTMENT_SUBORDINATE_RIGHTS or ENLISTMENT_SUPERIOR_RIGHTS
  ENLISTMENT_GENERIC_EXECUTE* = STANDARD_RIGHTS_EXECUTE or ENLISTMENT_RECOVER or ENLISTMENT_SUBORDINATE_RIGHTS or ENLISTMENT_SUPERIOR_RIGHTS
  ENLISTMENT_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or ENLISTMENT_GENERIC_READ or ENLISTMENT_GENERIC_WRITE or ENLISTMENT_GENERIC_EXECUTE
  transactionOutcomeUndetermined* = 1
  transactionOutcomeCommitted* = 2
  transactionOutcomeAborted* = 3
  transactionStateNormal* = 1
  transactionStateIndoubt* = 2
  transactionStateCommittedNotify* = 3
  transactionBasicInformation* = 0
  transactionPropertiesInformation* = 1
  transactionEnlistmentInformation* = 2
  transactionSuperiorEnlistmentInformation* = 3
  transactionBindInformation* = 4
  transactionDTCPrivateInformation* = 5
  transactionManagerBasicInformation* = 0
  transactionManagerLogInformation* = 1
  transactionManagerLogPathInformation* = 2
  transactionManagerOnlineProbeInformation* = 3
  transactionManagerRecoveryInformation* = 4
  transactionManagerOldestTransactionInformation* = 5
  resourceManagerBasicInformation* = 0
  resourceManagerCompletionInformation* = 1
  enlistmentBasicInformation* = 0
  enlistmentRecoveryInformation* = 1
  enlistmentCrmInformation* = 2
  KTMOBJECT_TRANSACTION* = 0
  KTMOBJECT_TRANSACTION_MANAGER* = 1
  KTMOBJECT_RESOURCE_MANAGER* = 2
  KTMOBJECT_ENLISTMENT* = 3
  KTMOBJECT_INVALID* = 4
  WOW64_CONTEXT_i386* = 0x00010000
  WOW64_CONTEXT_i486* = 0x00010000
  WOW64_CONTEXT_CONTROL* = WOW64_CONTEXT_i386 or 0x00000001
  WOW64_CONTEXT_INTEGER* = WOW64_CONTEXT_i386 or 0x00000002
  WOW64_CONTEXT_SEGMENTS* = WOW64_CONTEXT_i386 or 0x00000004
  WOW64_CONTEXT_FLOATING_POINT* = WOW64_CONTEXT_i386 or 0x00000008
  WOW64_CONTEXT_DEBUG_REGISTERS* = WOW64_CONTEXT_i386 or 0x00000010
  WOW64_CONTEXT_EXTENDED_REGISTERS* = WOW64_CONTEXT_i386 or 0x00000020
  WOW64_CONTEXT_FULL* = WOW64_CONTEXT_CONTROL or WOW64_CONTEXT_INTEGER or WOW64_CONTEXT_SEGMENTS
  WOW64_CONTEXT_ALL* = WOW64_CONTEXT_CONTROL or WOW64_CONTEXT_INTEGER or WOW64_CONTEXT_SEGMENTS or WOW64_CONTEXT_FLOATING_POINT or WOW64_CONTEXT_DEBUG_REGISTERS or WOW64_CONTEXT_EXTENDED_REGISTERS
  WOW64_CONTEXT_XSTATE* = WOW64_CONTEXT_i386 or 0x00000040
  WOW64_CONTEXT_EXCEPTION_ACTIVE* = 0x08000000
  WOW64_CONTEXT_SERVICE_ACTIVE* = 0x10000000
  WOW64_CONTEXT_EXCEPTION_REQUEST* = 0x40000000
  WOW64_CONTEXT_EXCEPTION_REPORTING* = 0x80000000'i32
  ALL_PROCESSOR_GROUPS* = 0xffff
  ACTIVATION_CONTEXT_SECTION_ASSEMBLY_INFORMATION* = 1
  ACTIVATION_CONTEXT_SECTION_DLL_REDIRECTION* = 2
  ACTIVATION_CONTEXT_SECTION_WINDOW_CLASS_REDIRECTION* = 3
  ACTIVATION_CONTEXT_SECTION_COM_SERVER_REDIRECTION* = 4
  ACTIVATION_CONTEXT_SECTION_COM_INTERFACE_REDIRECTION* = 5
  ACTIVATION_CONTEXT_SECTION_COM_TYPE_LIBRARY_REDIRECTION* = 6
  ACTIVATION_CONTEXT_SECTION_COM_PROGID_REDIRECTION* = 7
  ACTIVATION_CONTEXT_SECTION_GLOBAL_OBJECT_RENAME_TABLE* = 8
  ACTIVATION_CONTEXT_SECTION_CLR_SURROGATES* = 9
  ACTIVATION_CONTEXT_SECTION_APPLICATION_SETTINGS* = 10
  ACTIVATION_CONTEXT_SECTION_COMPATIBILITY_INFO* = 11
  HFILE_ERROR* = HFILE(-1)
  DM_UPDATE* = 1
  DM_COPY* = 2
  DM_PROMPT* = 4
  DM_MODIFY* = 8
  DM_IN_BUFFER* = DM_MODIFY
  DM_IN_PROMPT* = DM_PROMPT
  DM_OUT_BUFFER* = DM_COPY
  DM_OUT_DEFAULT* = DM_UPDATE
  DC_FIELDS* = 1
  DC_PAPERS* = 2
  DC_PAPERSIZE* = 3
  DC_MINEXTENT* = 4
  DC_MAXEXTENT* = 5
  DC_BINS* = 6
  DC_DUPLEX* = 7
  DC_SIZE* = 8
  DC_EXTRA* = 9
  DC_VERSION* = 10
  DC_DRIVER* = 11
  DC_BINNAMES* = 12
  DC_ENUMRESOLUTIONS* = 13
  DC_FILEDEPENDENCIES* = 14
  DC_TRUETYPE* = 15
  DC_PAPERNAMES* = 16
  DC_ORIENTATION* = 17
  DC_COPIES* = 18
  fileDirectoryInformation* = 1
  fileFullDirectoryInformation* = 2
  fileBothDirectoryInformation* = 3
  fileBasicInformation* = 4
  fileStandardInformation* = 5
  fileInternalInformation* = 6
  fileEaInformation* = 7
  fileAccessInformation* = 8
  fileNameInformation* = 9
  fileRenameInformation* = 10
  fileLinkInformation* = 11
  fileNamesInformation* = 12
  fileDispositionInformation* = 13
  filePositionInformation* = 14
  fileFullEaInformation* = 15
  fileModeInformation* = 16
  fileAlignmentInformation* = 17
  fileAllInformation* = 18
  fileAllocationInformation* = 19
  fileEndOfFileInformation* = 20
  fileAlternateNameInformation* = 21
  fileStreamInformation* = 22
  filePipeInformation* = 23
  filePipeLocalInformation* = 24
  filePipeRemoteInformation* = 25
  fileMailslotQueryInformation* = 26
  fileMailslotSetInformation* = 27
  fileCompressionInformation* = 28
  fileObjectIdInformation* = 29
  fileCompletionInformation* = 30
  fileMoveClusterInformation* = 31
  fileQuotaInformation* = 32
  fileReparsePointInformation* = 33
  fileNetworkOpenInformation* = 34
  fileAttributeTagInformation* = 35
  fileTrackingInformation* = 36
  fileIdBothDirectoryInformation* = 37
  fileIdFullDirectoryInformation* = 38
  fileValidDataLengthInformation* = 39
  fileShortNameInformation* = 40
  fileSfioReserveInformation* = 44
  fileSfioVolumeInformation* = 45
  fileHardLinkInformation* = 46
  fileNormalizedNameInformation* = 48
  fileIdGlobalTxDirectoryInformation* = 50
  fileStandardLinkInformation* = 54
  fileMaximumInformation* = 55
  fileFsVolumeInformation* = 1
  fileFsLabelInformation* = 2
  fileFsSizeInformation* = 3
  fileFsDeviceInformation* = 4
  fileFsAttributeInformation* = 5
  fileFsControlInformation* = 6
  fileFsFullSizeInformation* = 7
  fileFsObjectIdInformation* = 8
  fileFsDriverPathInformation* = 9
  fileFsVolumeFlagsInformation* = 10
  fileFsMaximumInformation* = 11
  stateInitialized* = 0
  stateReady* = 1
  stateRunning* = 2
  stateStandby* = 3
  stateTerminated* = 4
  stateWait* = 5
  stateTransition* = 6
  stateUnknown* = 7
  executive* = 0
  freePage* = 1
  pageIn* = 2
  poolAllocation* = 3
  delayExecution* = 4
  suspended* = 5
  userRequest* = 6
  wrExecutive* = 7
  wrFreePage* = 8
  wrPageIn* = 9
  wrPoolAllocation* = 10
  wrDelayExecution* = 11
  wrSuspended* = 12
  wrUserRequest* = 13
  wrEventPair* = 14
  wrQueue* = 15
  wrLpcReceive* = 16
  wrLpcReply* = 17
  wrVirtualMemory* = 18
  wrPageOut* = 19
  wrRendezvous* = 20
  spare2* = 21
  spare3* = 22
  spare4* = 23
  spare5* = 24
  spare6* = 25
  wrKernel* = 26
  maximumWaitReason* = 27
  processBasicInformation* = 0
  processQuotaLimits* = 1
  processIoCounters* = 2
  processVmCounters* = 3
  processTimes* = 4
  processBasePriority* = 5
  processRaisePriority* = 6
  processDebugPort* = 7
  processExceptionPort* = 8
  processAccessToken* = 9
  processLdtInformation* = 10
  processLdtSize* = 11
  processDefaultHardErrorMode* = 12
  processIoPortHandlers* = 13
  processPooledUsageAndLimits* = 14
  processWorkingSetWatch* = 15
  processUserModeIOPL* = 16
  processEnableAlignmentFaultFixup* = 17
  processPriorityClass* = 18
  processWx86Information* = 19
  processHandleCount* = 20
  processAffinityMask* = 21
  processPriorityBoost* = 22
  processDeviceMap* = 23
  processSessionInformation* = 24
  processForegroundInformation* = 25
  processWow64Information* = 26
  processImageFileName* = 27
  processLUIDDeviceMapsEnabled* = 28
  processBreakOnTermination* = 29
  processDebugObjectHandle* = 30
  processDebugFlags* = 31
  processHandleTracing* = 32
  processIoPriority* = 33
  processExecuteFlags* = 34
  processTlsInformation* = 35
  processCookie* = 36
  processImageInformation* = 37
  processCycleTime* = 38
  processPagePriority* = 39
  processInstrumentationCallback* = 40
  processThreadStackAllocation* = 41
  processWorkingSetWatchEx* = 42
  processImageFileNameWin32* = 43
  processImageFileMapping* = 44
  processAffinityUpdateMode* = 45
  processMemoryAllocationMode* = 46
  processGroupInformation* = 47
  processTokenVirtualizationEnabled* = 48
  processConsoleHostProcess* = 49
  processWindowInformation* = 50
  maxProcessInfoClass* = 51
  threadBasicInformation* = 0
  threadTimes* = 1
  threadPriority* = 2
  threadBasePriority* = 3
  threadAffinityMask* = 4
  threadImpersonationToken* = 5
  threadDescriptorTableEntry* = 6
  threadEnableAlignmentFaultFixup* = 7
  threadEventPair* = 8
  threadQuerySetWin32StartAddress* = 9
  threadZeroTlsCell* = 10
  threadPerformanceCount* = 11
  threadAmILastThread* = 12
  threadIdealProcessor* = 13
  threadPriorityBoost* = 14
  threadSetTlsArrayAddress* = 15
  threadIsIoPending* = 16
  threadHideFromDebugger* = 17
  systemBasicInformation* = 0
  systemProcessorInformation* = 1
  systemPerformanceInformation* = 2
  systemTimeOfDayInformation* = 3
  systemProcessInformation* = 5
  systemProcessorPerformanceInformation* = 8
  systemHandleInformation* = 16
  systemPagefileInformation* = 18
  systemInterruptInformation* = 23
  systemExceptionInformation* = 33
  systemRegistryQuotaInformation* = 37
  systemLookasideInformation* = 45
  objectBasicInformation* = 0
  objectNameInformation* = 1
  objectTypeInformation* = 2
  objectAllInformation* = 3
  objectDataInformation* = 4
  LOGONID_CURRENT* = ULONG(-1)
  winStationInformation* = 8
  REPARSE_DATA_BUFFER_HEADER_SIZE* = 0x00000008
  REPARSE_GUID_DATA_BUFFER_HEADER_SIZE* = 0x00000018
  SECURITY_DESCRIPTOR_MIN_LENGTH* = 0x00000028
  NULL* = nil
  NULL64* = nil
  SYSTEM_LUID* = LUID(LowPart: 0x3e7, HighPart: 0x0)
  ANONYMOUS_LOGON_LUID* = LUID(LowPart: 0x3e6, HighPart: 0x0)
  LOCALSERVICE_LUID* = LUID(LowPart: 0x3e5, HighPart: 0x0)
  NETWORKSERVICE_LUID* = LUID(LowPart: 0x3e4, HighPart: 0x0)
  IUSER_LUID* = LUID(LowPart: 0x3e3, HighPart: 0x0)
  SERVERNAME_CURRENT* = HANDLE 0
  TRANSACTIONMANAGER_OBJECT_NAME_LENGTH_IN_BYTES* = (len(TRANSACTIONMANAGER_OBJECT_PATH)+1)+(38*sizeof(WCHAR))
  TRANSACTION_OBJECT_NAME_LENGTH_IN_BYTES* = (len(TRANSACTION_OBJECT_PATH)+1)+(38*sizeof(WCHAR))
  ENLISTMENT_OBJECT_NAME_LENGTH_IN_BYTES* = (len(ENLISTMENT_OBJECT_PATH)+1)+(38*sizeof(WCHAR))
  RESOURCE_MANAGER_OBJECT_NAME_LENGTH_IN_BYTES* = (len(RESOURCE_MANAGER_OBJECT_PATH)+1)+(38*sizeof(WCHAR))
  IMAGE_SYM_CLASS_END_OF_FUNCTION* = not BYTE(0)
type
  PHNDLR* = proc (P1: int32): void {.stdcall.}
  PEXCEPTION_HANDLER* = proc (P1: ptr EXCEPTION_RECORD, P2: pointer, P3: ptr CONTEXT, P4: pointer): EXCEPTION_DISPOSITION {.stdcall.}
  PIMAGE_TLS_CALLBACK* = proc (DllHandle: PVOID, Reason: DWORD, Reserved: PVOID): VOID {.stdcall.}
  PRTL_RUN_ONCE_INIT_FN* = proc (P1: PRTL_RUN_ONCE, P2: PVOID, P3: ptr PVOID): DWORD {.stdcall.}
  PAPCFUNC* = proc (Parameter: ULONG_PTR): VOID {.stdcall.}
  PVECTORED_EXCEPTION_HANDLER* = proc (ExceptionInfo: ptr EXCEPTION_POINTERS): LONG {.stdcall.}
  WORKERCALLBACKFUNC* = proc (P1: PVOID): VOID {.stdcall.}
  APC_CALLBACK_FUNCTION* = proc (P1: DWORD, P2: PVOID, P3: PVOID): VOID {.stdcall.}
  PFLS_CALLBACK_FUNCTION* = proc (lpFlsData: PVOID): VOID {.stdcall.}
  PSECURE_MEMORY_CACHE_CALLBACK* = proc (Addr: PVOID, Range: SIZE_T): BOOLEAN {.stdcall.}
  PTP_WORK_CALLBACK* = proc (Instance: PTP_CALLBACK_INSTANCE, Context: PVOID, Work: PTP_WORK): VOID {.stdcall.}
  PTP_TIMER_CALLBACK* = proc (Instance: PTP_CALLBACK_INSTANCE, Context: PVOID, Timer: PTP_TIMER): VOID {.stdcall.}
  PTP_WAIT_CALLBACK* = proc (Instance: PTP_CALLBACK_INSTANCE, Context: PVOID, Wait: PTP_WAIT, WaitResult: TP_WAIT_RESULT): VOID {.stdcall.}
  PIO_APC_ROUTINE* = proc (ApcContext: PVOID, IoStatusBlock: PIO_STATUS_BLOCK, Reserved: ULONG): VOID {.stdcall.}
  PWINSTATIONQUERYINFORMATIONW* = proc (P1: HANDLE, P2: ULONG, P3: WINSTATIONINFOCLASS, P4: PVOID, P5: ULONG, P6: PULONG): BOOLEAN {.stdcall.}
  XCPT_ACTION* {.pure.} = object
    XcptNum*: int32
    SigNum*: int32
    XcptAction*: PHNDLR
  OBJECTID* {.pure.} = object
    Lineage*: GUID
    Uniquifier*: DWORD
  ANON_OBJECT_HEADER* {.pure.} = object
    Sig1*: WORD
    Sig2*: WORD
    Version*: WORD
    Machine*: WORD
    TimeDateStamp*: DWORD
    ClassID*: CLSID
    SizeOfData*: DWORD
  ANON_OBJECT_HEADER_V2* {.pure.} = object
    Sig1*: WORD
    Sig2*: WORD
    Version*: WORD
    Machine*: WORD
    TimeDateStamp*: DWORD
    ClassID*: CLSID
    SizeOfData*: DWORD
    Flags*: DWORD
    MetaDataSize*: DWORD
    MetaDataOffset*: DWORD
  ANON_OBJECT_HEADER_BIGOBJ* {.pure.} = object
    Sig1*: WORD
    Sig2*: WORD
    Version*: WORD
    Machine*: WORD
    TimeDateStamp*: DWORD
    ClassID*: CLSID
    SizeOfData*: DWORD
    Flags*: DWORD
    MetaDataSize*: DWORD
    MetaDataOffset*: DWORD
    NumberOfSections*: DWORD
    PointerToSymbolTable*: DWORD
    NumberOfSymbols*: DWORD
  IMPORT_OBJECT_HEADER_UNION1* {.pure, union.} = object
    Ordinal*: WORD
    Hint*: WORD
  IMPORT_OBJECT_HEADER* {.pure.} = object
    Sig1*: WORD
    Sig2*: WORD
    Version*: WORD
    Machine*: WORD
    TimeDateStamp*: DWORD
    SizeOfData*: DWORD
    union1*: IMPORT_OBJECT_HEADER_UNION1
    Type* {.bitsize:2.}: WORD
    NameType* {.bitsize:3.}: WORD
    Reserved* {.bitsize:11.}: WORD
  TP_CALLBACK_ENVIRON_V1_u_s* {.pure.} = object
    LongFunction* {.bitsize:1.}: DWORD
    Persistent* {.bitsize:1.}: DWORD
    Private* {.bitsize:30.}: DWORD
  TP_CALLBACK_ENVIRON_V1_u* {.pure, union.} = object
    Flags*: DWORD
    s*: TP_CALLBACK_ENVIRON_V1_u_s
  TP_CALLBACK_ENVIRON_V1* {.pure.} = object
    Version*: TP_VERSION
    Pool*: PTP_POOL
    CleanupGroup*: PTP_CLEANUP_GROUP
    CleanupGroupCancelCallback*: PTP_CLEANUP_GROUP_CANCEL_CALLBACK
    RaceDll*: PVOID
    ActivationContext*: ptr ACTIVATION_CONTEXT
    FinalizationCallback*: PTP_SIMPLE_CALLBACK
    u*: TP_CALLBACK_ENVIRON_V1_u
proc IsEqualGUID*(rguid1: REFGUID, rguid2: REFGUID): BOOL {.winapi, stdcall, dynlib: "ole32", importc.}
proc IsEqualIID*(rguid1: REFIID, rguid2: REFIID): BOOL {.winapi, stdcall, dynlib: "ole32", importc: "IsEqualGUID".}
proc IsEqualCLSID*(rguid1: REFCLSID, rguid2: REFCLSID): BOOL {.winapi, stdcall, dynlib: "ole32", importc: "IsEqualGUID".}
proc IsEqualFMTID*(rguid1: REFFMTID, rguid2: REFFMTID): BOOL {.winapi, stdcall, dynlib: "ole32", importc: "IsEqualGUID".}
proc RtlCaptureStackBackTrace*(FramesToSkip: DWORD, FramesToCapture: DWORD, BackTrace: ptr PVOID, BackTraceHash: PDWORD): WORD {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlCaptureContext*(ContextRecord: PCONTEXT): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlCompareMemory*(Source1: pointer, Source2: pointer, Length: SIZE_T): SIZE_T {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlUnwind*(TargetFrame: PVOID, TargetIp: PVOID, ExceptionRecord: PEXCEPTION_RECORD, ReturnValue: PVOID): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlPcToFileHeader*(PcValue: PVOID, BaseOfImage: ptr PVOID): PVOID {.winapi, stdcall, dynlib: "ntdll", importc.}
when winimCpu64:
  type
    SLIST_HEADER_STRUCT1* {.pure.} = object
      Alignment*: ULONGLONG
      Region*: ULONGLONG
when winimCpu32:
  type
    SLIST_ENTRY* = SINGLE_LIST_ENTRY
when winimCpu64:
  type
    SLIST_ENTRY* {.pure.} = object
      Next*: ptr SLIST_ENTRY
      padding*: array[8, byte]
when winimCpu32:
  type
    SLIST_HEADER_STRUCT1* {.pure.} = object
      Next*: SLIST_ENTRY
      Depth*: WORD
      Sequence*: WORD
when winimCpu64:
  type
    SLIST_HEADER_Header8* {.pure.} = object
      Depth* {.bitsize:16.}: ULONGLONG
      Sequence* {.bitsize:9.}: ULONGLONG
      NextEntry* {.bitsize:39.}: ULONGLONG
      HeaderType* {.bitsize:1.}: ULONGLONG
      Init* {.bitsize:1.}: ULONGLONG
      Reserved* {.bitsize:59.}: ULONGLONG
      Region* {.bitsize:3.}: ULONGLONG
    SLIST_HEADER_HeaderX64* {.pure.} = object
      Depth* {.bitsize:16.}: ULONGLONG
      Sequence* {.bitsize:48.}: ULONGLONG
      HeaderType* {.bitsize:1.}: ULONGLONG
      Reserved* {.bitsize:3.}: ULONGLONG
      NextEntry* {.bitsize:60.}: ULONGLONG
    SLIST_HEADER* {.pure, union.} = object
      struct1*: SLIST_HEADER_STRUCT1
      Header8*: SLIST_HEADER_Header8
      HeaderX64*: SLIST_HEADER_HeaderX64
when winimCpu32:
  type
    SLIST_HEADER* {.pure, union.} = object
      Alignment*: ULONGLONG
      struct1*: SLIST_HEADER_STRUCT1
when winimCpu64:
  type
    PSLIST_HEADER* = ptr SLIST_HEADER
when winimCpu32:
  type
    PSLIST_HEADER* = ptr SLIST_HEADER
proc RtlInitializeSListHead*(ListHead: PSLIST_HEADER): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
when winimCpu64:
  type
    PSLIST_ENTRY* = ptr SLIST_ENTRY
when winimCpu32:
  type
    PSLIST_ENTRY* = ptr SINGLE_LIST_ENTRY
proc RtlFirstEntrySList*(ListHead: ptr SLIST_HEADER): PSLIST_ENTRY {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlInterlockedPopEntrySList*(ListHead: PSLIST_HEADER): PSLIST_ENTRY {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlInterlockedPushEntrySList*(ListHead: PSLIST_HEADER, ListEntry: PSLIST_ENTRY): PSLIST_ENTRY {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlInterlockedPushListSListEx*(ListHead: PSLIST_HEADER, List: PSLIST_ENTRY, ListEnd: PSLIST_ENTRY, Count: DWORD): PSLIST_ENTRY {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlInterlockedFlushSList*(ListHead: PSLIST_HEADER): PSLIST_ENTRY {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlQueryDepthSList*(ListHead: PSLIST_HEADER): WORD {.winapi, stdcall, dynlib: "ntdll", importc.}
proc VerSetConditionMask*(ConditionMask: ULONGLONG, TypeMask: DWORD, Condition: BYTE): ULONGLONG {.winapi, stdcall, dynlib: "kernel32", importc.}
proc RtlGetProductInfo*(OSMajorVersion: DWORD, OSMinorVersion: DWORD, SpMajorVersion: DWORD, SpMinorVersion: DWORD, ReturnedProductType: PDWORD): BOOLEAN {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlCrc32*(Buffer: pointer, Size: int, InitialCrc: DWORD): DWORD {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlCrc64*(Buffer: pointer, Size: int, InitialCrc: ULONGLONG): ULONGLONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlApplicationVerifierStop*(Code: ULONG_PTR, Message: PSTR, Param1: ULONG_PTR, Description1: PSTR, Param2: ULONG_PTR, Description2: PSTR, Param3: ULONG_PTR, Description3: PSTR, Param4: ULONG_PTR, Description4: PSTR): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlSetHeapInformation*(HeapHandle: PVOID, HeapInformationClass: HEAP_INFORMATION_CLASS, HeapInformation: PVOID, HeapInformationLength: SIZE_T): DWORD {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlQueryHeapInformation*(HeapHandle: PVOID, HeapInformationClass: HEAP_INFORMATION_CLASS, HeapInformation: PVOID, HeapInformationLength: SIZE_T, ReturnLength: PSIZE_T): DWORD {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlMultipleAllocateHeap*(HeapHandle: PVOID, Flags: DWORD, Size: SIZE_T, Count: DWORD, Array: ptr PVOID): DWORD {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlMultipleFreeHeap*(HeapHandle: PVOID, Flags: DWORD, Count: DWORD, Array: ptr PVOID): DWORD {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtClose*(Handle: HANDLE): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtCreateFile*(FileHandle: PHANDLE, DesiredAccess: ACCESS_MASK, ObjectAttributes: POBJECT_ATTRIBUTES, IoStatusBlock: PIO_STATUS_BLOCK, AllocationSize: PLARGE_INTEGER, FileAttributes: ULONG, ShareAccess: ULONG, CreateDisposition: ULONG, CreateOptions: ULONG, EaBuffer: PVOID, EaLength: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtOpenFile*(FileHandle: PHANDLE, DesiredAccess: ACCESS_MASK, ObjectAttributes: POBJECT_ATTRIBUTES, IoStatusBlock: PIO_STATUS_BLOCK, ShareAccess: ULONG, OpenOptions: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtFsControlFile*(FileHandle: HANDLE, Event: HANDLE, ApcRoutine: PIO_APC_ROUTINE, ApcContext: PVOID, IoStatusBlock: PIO_STATUS_BLOCK, IoControlCode: ULONG, InputBuffer: PVOID, InputBufferLength: ULONG, OutputBuffer: PVOID, OutputBufferLength: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtDeviceIoControlFile*(FileHandle: HANDLE, Event: HANDLE, ApcRoutine: PIO_APC_ROUTINE, ApcContext: PVOID, IoStatusBlock: PIO_STATUS_BLOCK, IoControlCode: ULONG, InputBuffer: PVOID, InputBufferLength: ULONG, OutputBuffer: PVOID, OutputBufferLength: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtWaitForSingleObject*(Handle: HANDLE, Alertable: BOOLEAN, Timeout: PLARGE_INTEGER): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlIsNameLegalDOS8Dot3*(Name: PUNICODE_STRING, OemName: POEM_STRING, NameContainsSpaces: PBOOLEAN): BOOLEAN {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlNtStatusToDosError*(Status: NTSTATUS): ULONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtQueryInformationProcess*(ProcessHandle: HANDLE, ProcessInformationClass: PROCESSINFOCLASS, ProcessInformation: PVOID, ProcessInformationLength: ULONG, ReturnLength: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtQueryInformationThread*(ThreadHandle: HANDLE, ThreadInformationClass: THREADINFOCLASS, ThreadInformation: PVOID, ThreadInformationLength: ULONG, ReturnLength: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtQueryInformationFile*(hFile: HANDLE, io: PIO_STATUS_BLOCK, `ptr`: PVOID, len: ULONG, FileInformationClass: FILE_INFORMATION_CLASS): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtQueryObject*(Handle: HANDLE, ObjectInformationClass: OBJECT_INFORMATION_CLASS, ObjectInformation: PVOID, ObjectInformationLength: ULONG, ReturnLength: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtQuerySystemInformation*(SystemInformationClass: SYSTEM_INFORMATION_CLASS, SystemInformation: PVOID, SystemInformationLength: ULONG, ReturnLength: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtQuerySystemTime*(SystemTime: PLARGE_INTEGER): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtQueryVolumeInformationFile*(hFile: HANDLE, io: PIO_STATUS_BLOCK, `ptr`: PVOID, len: ULONG, FsInformationClass: FS_INFORMATION_CLASS): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtSetInformationFile*(hFile: HANDLE, io: PIO_STATUS_BLOCK, `ptr`: PVOID, len: ULONG, FileInformationClass: FILE_INFORMATION_CLASS): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtSetInformationProcess*(ProcessHandle: HANDLE, ProcessInformationClass: PROCESSINFOCLASS, ProcessInformation: PVOID, ProcessInformationLength: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc NtSetVolumeInformationFile*(hFile: HANDLE, io: PIO_STATUS_BLOCK, `ptr`: PVOID, len: ULONG, FileInformationClass: FILE_INFORMATION_CLASS): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlLocalTimeToSystemTime*(LocalTime: PLARGE_INTEGER, SystemTime: PLARGE_INTEGER): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlTimeToSecondsSince1970*(Time: PLARGE_INTEGER, ElapsedSeconds: PULONG): BOOLEAN {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlFreeAnsiString*(AnsiString: PANSI_STRING): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlFreeUnicodeString*(UnicodeString: PUNICODE_STRING): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlFreeOemString*(OemString: POEM_STRING): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlInitString*(DestinationString: PSTRING, SourceString: PCSZ): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlInitAnsiString*(DestinationString: PANSI_STRING, SourceString: PCSZ): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlInitUnicodeString*(DestinationString: PUNICODE_STRING, SourceString: PCWSTR): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlAnsiStringToUnicodeString*(DestinationString: PUNICODE_STRING, SourceString: PCANSI_STRING, AllocateDestinationString: BOOLEAN): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlUnicodeStringToAnsiString*(DestinationString: PANSI_STRING, SourceString: PCUNICODE_STRING, AllocateDestinationString: BOOLEAN): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlUnicodeStringToOemString*(DestinationString: POEM_STRING, SourceString: PCUNICODE_STRING, AllocateDestinationString: BOOLEAN): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlUnicodeToMultiByteSize*(BytesInMultiByteString: PULONG, UnicodeString: PWCH, BytesInUnicodeString: ULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlCharToInteger*(String: PCSZ, Base: ULONG, Value: PULONG): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlConvertSidToUnicodeString*(UnicodeString: PUNICODE_STRING, Sid: PSID, AllocateDestinationString: BOOLEAN): NTSTATUS {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlUniform*(Seed: PULONG): ULONG {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlDosPathNameToNtPathName_U*(DosPathName: PCWSTR, NtPathName: PUNICODE_STRING, NtFileNamePart: ptr PCWSTR, DirectoryInfo: pointer): BOOL {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlPrefixUnicodeString*(String1: PCUNICODE_STRING, String2: PCUNICODE_STRING, CaseInSensitive: BOOLEAN): BOOLEAN {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlCreateUnicodeStringFromAsciiz*(target: PUNICODE_STRING, src: LPCSTR): BOOLEAN {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlFreeHeap*(HeapHandle: PVOID, Flags: ULONG, HeapBase: PVOID): BOOLEAN {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlAllocateHeap*(HeapHandle: PVOID, Flags: ULONG, Size: SIZE_T): PVOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlCreateHeap*(Flags: ULONG, HeapBase: PVOID, ReserveSize: SIZE_T, CommitSize: SIZE_T, Lock: PVOID, Parameters: PRTL_HEAP_PARAMETERS): PVOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc RtlDestroyHeap*(HeapHandle: PVOID): PVOID {.winapi, stdcall, dynlib: "ntdll", importc.}
proc CaptureStackBackTrace*(FramesToSkip: DWORD, FramesToCapture: DWORD, BackTrace: ptr PVOID, BackTraceHash: PDWORD): WORD {.winapi, stdcall, dynlib: "ntdll", importc: "RtlCaptureStackBackTrace".}
template NT_SUCCESS*(status: untyped): bool = status.NTSTATUS >= 0
template NT_INFORMATION*(status: untyped): bool = status.NTSTATUS shr 30 == 1
template NT_WARNING*(status: untyped): bool = status.NTSTATUS shr 30 == 2
template NT_ERROR*(status: untyped): bool = status.NTSTATUS shr 30 == 3
template PRIMARYLANGID*(lgid: untyped): WORD = lgid.WORD and 0x3ff
template SUBLANGID*(lgid: untyped): WORD = lgid.WORD shr 10
template MAKESORTLCID*(lgid: untyped, srtid: untyped, ver: untyped): DWORD = MAKELCID(lgid, srtid) or (ver.DWORD shl 20)
template LANGIDFROMLCID*(lcid: untyped): WORD = WORD(lcid and 0xffff)
template SORTIDFROMLCID*(lcid: untyped): WORD = WORD((lcid shr 16) and 0xf)
template SORTVERSIONFROMLCID*(lcid: untyped): WORD = WORD((lcid shr 20) and 0xf)
template MAKEWORD*(a: untyped, b: untyped): WORD = WORD((b and 0xff) shl 8) or WORD(a and 0xff)
template MAKELONG*(a: untyped, b: untyped): DWORD = cast[DWORD](b shl 16) or DWORD(a and 0xffff)
template LOWORD*(l: untyped): WORD = WORD(l and 0xffff)
template HIWORD*(l: untyped): WORD = WORD((l shr 16) and 0xffff)
template LOBYTE*(w: untyped): BYTE = BYTE(w and 0xff)
template HIBYTE*(w: untyped): BYTE = BYTE((w shr 8) and 0xff)
template GET_X_LPARAM*(x: untyped): int = int cast[int16](LOWORD(x))
template GET_Y_LPARAM*(x: untyped): int = int cast[int16](HIWORD(x))
template IS_UNWINDING*(f: untyped): bool = (f and EXCEPTION_UNWIND) != 0
template IS_DISPATCHING*(f: untyped): bool = (f and EXCEPTION_UNWIND) == 0
template IS_TARGET_UNWIND*(f: untyped): bool = (f and EXCEPTION_TARGET_UNWIND) != 0
template MANDATORY_LEVEL_TO_MANDATORY_RID*(IL: untyped): DWORD = IL.DWORD * 0x1000
template VALID_IMPERSONATION_LEVEL*(L: untyped): bool = (L >= SECURITY_MIN_IMPERSONATION_LEVEL) and (L <= SECURITY_MAX_IMPERSONATION_LEVEL)
template IsReparseTagMicrosoft*(tag: untyped): ULONG = tag.ULONG and 0x80000000'i32
template IsReparseTagNameSurrogate*(tag: untyped): ULONG = tag.ULONG and 0x20000000'i32
when winimCpu64:
  type
    PIMAGE_NT_HEADERS* = PIMAGE_NT_HEADERS64
when winimCpu32:
  type
    PIMAGE_NT_HEADERS* = PIMAGE_NT_HEADERS32
template IMAGE_FIRST_SECTION*(ntheader: PIMAGE_NT_HEADERS): PIMAGE_SECTION_HEADER = cast[PIMAGE_SECTION_HEADER](cast[int](addr ntheader.OptionalHeader) + int(ntheader.FileHeader.SizeOfOptionalHeader))
template BTYPE*(x: untyped): DWORD = x.DWORD and N_BTMASK
template ISPTR*(x: untyped): bool = DWORD(x and N_TMASK) == DWORD(IMAGE_SYM_DTYPE_POINTER shl N_BTSHFT)
template ISFCN*(x: untyped): bool = DWORD(x and N_TMASK) == DWORD(IMAGE_SYM_DTYPE_FUNCTION shl N_BTSHFT)
template ISARY*(x: untyped): bool = DWORD(x and N_TMASK) == DWORD(IMAGE_SYM_DTYPE_ARRAY shl N_BTSHFT)
template ISTAG*(x: untyped): bool = (x == IMAGE_SYM_CLASS_STRUCT_TAG) or (x == IMAGE_SYM_CLASS_UNION_TAG) or (x == IMAGE_SYM_CLASS_ENUM_TAG)
template INCREF*(x: untyped): DWORD = ((x.DWORD and (not N_BTMASK)) shl N_TSHIFT) or DWORD(IMAGE_SYM_DTYPE_POINTER shl N_BTSHFT) or DWORD(x and N_BTMASK)
template DECREF*(x: untyped): DWORD = (x.DWORD shr N_TSHIFT) and DWORD(not N_BTMASK) or (x.DWORD and N_BTMASK)
template IMAGE_ORDINAL64*(Ordinal: untyped): int64 = Ordinal.int64 and 0xffff'i64
template IMAGE_ORDINAL32*(Ordinal: untyped): int32 = Ordinal.int32 and 0xffff'i32
template IMAGE_SNAP_BY_ORDINAL64*(Ordinal: untyped): bool = (Ordinal and IMAGE_ORDINAL_FLAG64) != 0
template IMAGE_SNAP_BY_ORDINAL32*(Ordinal: untyped): bool = (Ordinal and IMAGE_ORDINAL_FLAG32) != 0
template HEAP_MAKE_TAG_FLAGS*(b: untyped, o: untyped): DWORD = b.DWORD + (o.DWORD shl 18)
template InitializeObjectAttributes*(p: POBJECT_ATTRIBUTES, n: PUNICODE_STRING, a: ULONG, r: HANDLE, s: PSECURITY_DESCRIPTOR) = p.Length = int32 sizeof(OBJECT_ATTRIBUTES); p.RootDirectory = r; p.Attributes = a; p.ObjectName = n; p.SecurityDescriptor = s; p.SecurityQualityOfService = nil
proc ReadTimeStampCounter*(): int64 {.importc: "__rdtsc".}
proc RtlEqualMemory*(Destination: pointer, Source: pointer, Length: Natural): bool {.importc: "RtlEqualMemory", header: "<windows.h>".}
proc RtlMoveMemory*(Destination: pointer, Source: pointer, Length: Natural) {.importc: "RtlMoveMemory", header: "<windows.h>".}
proc RtlCopyMemory*(Destination: pointer, Source: pointer, Length: Natural) {.importc: "RtlCopyMemory", header: "<windows.h>".}
proc RtlZeroMemory*(Destination: pointer, Length: Natural) {.importc: "RtlZeroMemory", header: "<windows.h>".}
proc RtlSecureZeroMemory*(Destination: pointer, Length: Natural) {.importc: "RtlSecureZeroMemory", header: "<windows.h>".}
proc RtlFillMemory*(Destination: pointer, Length: Natural, Fill: byte): void {.importc: "RtlFillMemory", header: "<windows.h>".}
proc `UseThisFieldToCopy=`*(self: var QUAD, x: int64) {.inline.} = self.union1.UseThisFieldToCopy = x
proc UseThisFieldToCopy*(self: QUAD): int64 {.inline.} = self.union1.UseThisFieldToCopy
proc UseThisFieldToCopy*(self: var QUAD): var int64 {.inline.} = self.union1.UseThisFieldToCopy
proc `DoNotUseThisField=`*(self: var QUAD, x: float64) {.inline.} = self.union1.DoNotUseThisField = x
proc DoNotUseThisField*(self: QUAD): float64 {.inline.} = self.union1.DoNotUseThisField
proc DoNotUseThisField*(self: var QUAD): var float64 {.inline.} = self.union1.DoNotUseThisField
proc `LowPart=`*(self: var LARGE_INTEGER, x: ULONG) {.inline.} = self.struct1.LowPart = x
proc LowPart*(self: LARGE_INTEGER): ULONG {.inline.} = self.struct1.LowPart
proc LowPart*(self: var LARGE_INTEGER): var ULONG {.inline.} = self.struct1.LowPart
proc `HighPart=`*(self: var LARGE_INTEGER, x: LONG) {.inline.} = self.struct1.HighPart = x
proc HighPart*(self: LARGE_INTEGER): LONG {.inline.} = self.struct1.HighPart
proc HighPart*(self: var LARGE_INTEGER): var LONG {.inline.} = self.struct1.HighPart
proc `LowPart=`*(self: var ULARGE_INTEGER, x: ULONG) {.inline.} = self.struct1.LowPart = x
proc LowPart*(self: ULARGE_INTEGER): ULONG {.inline.} = self.struct1.LowPart
proc LowPart*(self: var ULARGE_INTEGER): var ULONG {.inline.} = self.struct1.LowPart
proc `HighPart=`*(self: var ULARGE_INTEGER, x: ULONG) {.inline.} = self.struct1.HighPart = x
proc HighPart*(self: ULARGE_INTEGER): ULONG {.inline.} = self.struct1.HighPart
proc HighPart*(self: var ULARGE_INTEGER): var ULONG {.inline.} = self.struct1.HighPart
proc `SymbolicLinkReparseBuffer=`*(self: var REPARSE_DATA_BUFFER, x: REPARSE_DATA_BUFFER_UNION1_SymbolicLinkReparseBuffer) {.inline.} = self.union1.SymbolicLinkReparseBuffer = x
proc SymbolicLinkReparseBuffer*(self: REPARSE_DATA_BUFFER): REPARSE_DATA_BUFFER_UNION1_SymbolicLinkReparseBuffer {.inline.} = self.union1.SymbolicLinkReparseBuffer
proc SymbolicLinkReparseBuffer*(self: var REPARSE_DATA_BUFFER): var REPARSE_DATA_BUFFER_UNION1_SymbolicLinkReparseBuffer {.inline.} = self.union1.SymbolicLinkReparseBuffer
proc `MountPointReparseBuffer=`*(self: var REPARSE_DATA_BUFFER, x: REPARSE_DATA_BUFFER_UNION1_MountPointReparseBuffer) {.inline.} = self.union1.MountPointReparseBuffer = x
proc MountPointReparseBuffer*(self: REPARSE_DATA_BUFFER): REPARSE_DATA_BUFFER_UNION1_MountPointReparseBuffer {.inline.} = self.union1.MountPointReparseBuffer
proc MountPointReparseBuffer*(self: var REPARSE_DATA_BUFFER): var REPARSE_DATA_BUFFER_UNION1_MountPointReparseBuffer {.inline.} = self.union1.MountPointReparseBuffer
proc `GenericReparseBuffer=`*(self: var REPARSE_DATA_BUFFER, x: REPARSE_DATA_BUFFER_UNION1_GenericReparseBuffer) {.inline.} = self.union1.GenericReparseBuffer = x
proc GenericReparseBuffer*(self: REPARSE_DATA_BUFFER): REPARSE_DATA_BUFFER_UNION1_GenericReparseBuffer {.inline.} = self.union1.GenericReparseBuffer
proc GenericReparseBuffer*(self: var REPARSE_DATA_BUFFER): var REPARSE_DATA_BUFFER_UNION1_GenericReparseBuffer {.inline.} = self.union1.GenericReparseBuffer
proc `FiberData=`*(self: var NT_TIB, x: PVOID) {.inline.} = self.union1.FiberData = x
proc FiberData*(self: NT_TIB): PVOID {.inline.} = self.union1.FiberData
proc FiberData*(self: var NT_TIB): var PVOID {.inline.} = self.union1.FiberData
proc `Version=`*(self: var NT_TIB, x: DWORD) {.inline.} = self.union1.Version = x
proc Version*(self: NT_TIB): DWORD {.inline.} = self.union1.Version
proc Version*(self: var NT_TIB): var DWORD {.inline.} = self.union1.Version
proc `FiberData=`*(self: var NT_TIB32, x: DWORD) {.inline.} = self.union1.FiberData = x
proc FiberData*(self: NT_TIB32): DWORD {.inline.} = self.union1.FiberData
proc FiberData*(self: var NT_TIB32): var DWORD {.inline.} = self.union1.FiberData
proc `Version=`*(self: var NT_TIB32, x: DWORD) {.inline.} = self.union1.Version = x
proc Version*(self: NT_TIB32): DWORD {.inline.} = self.union1.Version
proc Version*(self: var NT_TIB32): var DWORD {.inline.} = self.union1.Version
proc `FiberData=`*(self: var NT_TIB64, x: DWORD64) {.inline.} = self.union1.FiberData = x
proc FiberData*(self: NT_TIB64): DWORD64 {.inline.} = self.union1.FiberData
proc FiberData*(self: var NT_TIB64): var DWORD64 {.inline.} = self.union1.FiberData
proc `Version=`*(self: var NT_TIB64, x: DWORD) {.inline.} = self.union1.Version = x
proc Version*(self: NT_TIB64): DWORD {.inline.} = self.union1.Version
proc Version*(self: var NT_TIB64): var DWORD {.inline.} = self.union1.Version
proc `RatePercent=`*(self: var RATE_QUOTA_LIMIT, x: DWORD) {.inline.} = self.struct1.RatePercent = x
proc RatePercent*(self: RATE_QUOTA_LIMIT): DWORD {.inline.} = self.struct1.RatePercent
proc `Reserved0=`*(self: var RATE_QUOTA_LIMIT, x: DWORD) {.inline.} = self.struct1.Reserved0 = x
proc Reserved0*(self: RATE_QUOTA_LIMIT): DWORD {.inline.} = self.struct1.Reserved0
proc `Flags=`*(self: var PROCESS_MITIGATION_ASLR_POLICY, x: DWORD) {.inline.} = self.union1.Flags = x
proc Flags*(self: PROCESS_MITIGATION_ASLR_POLICY): DWORD {.inline.} = self.union1.Flags
proc Flags*(self: var PROCESS_MITIGATION_ASLR_POLICY): var DWORD {.inline.} = self.union1.Flags
proc `EnableBottomUpRandomization=`*(self: var PROCESS_MITIGATION_ASLR_POLICY, x: DWORD) {.inline.} = self.union1.struct1.EnableBottomUpRandomization = x
proc EnableBottomUpRandomization*(self: PROCESS_MITIGATION_ASLR_POLICY): DWORD {.inline.} = self.union1.struct1.EnableBottomUpRandomization
proc `EnableForceRelocateImages=`*(self: var PROCESS_MITIGATION_ASLR_POLICY, x: DWORD) {.inline.} = self.union1.struct1.EnableForceRelocateImages = x
proc EnableForceRelocateImages*(self: PROCESS_MITIGATION_ASLR_POLICY): DWORD {.inline.} = self.union1.struct1.EnableForceRelocateImages
proc `EnableHighEntropy=`*(self: var PROCESS_MITIGATION_ASLR_POLICY, x: DWORD) {.inline.} = self.union1.struct1.EnableHighEntropy = x
proc EnableHighEntropy*(self: PROCESS_MITIGATION_ASLR_POLICY): DWORD {.inline.} = self.union1.struct1.EnableHighEntropy
proc `DisallowStrippedImages=`*(self: var PROCESS_MITIGATION_ASLR_POLICY, x: DWORD) {.inline.} = self.union1.struct1.DisallowStrippedImages = x
proc DisallowStrippedImages*(self: PROCESS_MITIGATION_ASLR_POLICY): DWORD {.inline.} = self.union1.struct1.DisallowStrippedImages
proc `ReservedFlags=`*(self: var PROCESS_MITIGATION_ASLR_POLICY, x: DWORD) {.inline.} = self.union1.struct1.ReservedFlags = x
proc ReservedFlags*(self: PROCESS_MITIGATION_ASLR_POLICY): DWORD {.inline.} = self.union1.struct1.ReservedFlags
proc `Flags=`*(self: var PROCESS_MITIGATION_DEP_POLICY, x: DWORD) {.inline.} = self.union1.Flags = x
proc Flags*(self: PROCESS_MITIGATION_DEP_POLICY): DWORD {.inline.} = self.union1.Flags
proc Flags*(self: var PROCESS_MITIGATION_DEP_POLICY): var DWORD {.inline.} = self.union1.Flags
proc `Enable=`*(self: var PROCESS_MITIGATION_DEP_POLICY, x: DWORD) {.inline.} = self.union1.struct1.Enable = x
proc Enable*(self: PROCESS_MITIGATION_DEP_POLICY): DWORD {.inline.} = self.union1.struct1.Enable
proc `DisableAtlThunkEmulation=`*(self: var PROCESS_MITIGATION_DEP_POLICY, x: DWORD) {.inline.} = self.union1.struct1.DisableAtlThunkEmulation = x
proc DisableAtlThunkEmulation*(self: PROCESS_MITIGATION_DEP_POLICY): DWORD {.inline.} = self.union1.struct1.DisableAtlThunkEmulation
proc `ReservedFlags=`*(self: var PROCESS_MITIGATION_DEP_POLICY, x: DWORD) {.inline.} = self.union1.struct1.ReservedFlags = x
proc ReservedFlags*(self: PROCESS_MITIGATION_DEP_POLICY): DWORD {.inline.} = self.union1.struct1.ReservedFlags
proc `Flags=`*(self: var PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY, x: DWORD) {.inline.} = self.union1.Flags = x
proc Flags*(self: PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY): DWORD {.inline.} = self.union1.Flags
proc Flags*(self: var PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY): var DWORD {.inline.} = self.union1.Flags
proc `RaiseExceptionOnInvalidHandleReference=`*(self: var PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY, x: DWORD) {.inline.} = self.union1.struct1.RaiseExceptionOnInvalidHandleReference = x
proc RaiseExceptionOnInvalidHandleReference*(self: PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY): DWORD {.inline.} = self.union1.struct1.RaiseExceptionOnInvalidHandleReference
proc `HandleExceptionsPermanentlyEnabled=`*(self: var PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY, x: DWORD) {.inline.} = self.union1.struct1.HandleExceptionsPermanentlyEnabled = x
proc HandleExceptionsPermanentlyEnabled*(self: PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY): DWORD {.inline.} = self.union1.struct1.HandleExceptionsPermanentlyEnabled
proc `ReservedFlags=`*(self: var PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY, x: DWORD) {.inline.} = self.union1.struct1.ReservedFlags = x
proc ReservedFlags*(self: PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY): DWORD {.inline.} = self.union1.struct1.ReservedFlags
proc `Flags=`*(self: var PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY, x: DWORD) {.inline.} = self.union1.Flags = x
proc Flags*(self: PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY): DWORD {.inline.} = self.union1.Flags
proc Flags*(self: var PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY): var DWORD {.inline.} = self.union1.Flags
proc `DisallowWin32kSystemCalls=`*(self: var PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY, x: DWORD) {.inline.} = self.union1.struct1.DisallowWin32kSystemCalls = x
proc DisallowWin32kSystemCalls*(self: PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY): DWORD {.inline.} = self.union1.struct1.DisallowWin32kSystemCalls
proc `ReservedFlags=`*(self: var PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY, x: DWORD) {.inline.} = self.union1.struct1.ReservedFlags = x
proc ReservedFlags*(self: PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY): DWORD {.inline.} = self.union1.struct1.ReservedFlags
proc `Flags=`*(self: var PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY, x: DWORD) {.inline.} = self.union1.Flags = x
proc Flags*(self: PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY): DWORD {.inline.} = self.union1.Flags
proc Flags*(self: var PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY): var DWORD {.inline.} = self.union1.Flags
proc `DisableExtensionPoints=`*(self: var PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY, x: DWORD) {.inline.} = self.union1.struct1.DisableExtensionPoints = x
proc DisableExtensionPoints*(self: PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY): DWORD {.inline.} = self.union1.struct1.DisableExtensionPoints
proc `ReservedFlags=`*(self: var PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY, x: DWORD) {.inline.} = self.union1.struct1.ReservedFlags = x
proc ReservedFlags*(self: PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY): DWORD {.inline.} = self.union1.struct1.ReservedFlags
proc `CpuRate=`*(self: var JOBOBJECT_CPU_RATE_CONTROL_INFORMATION, x: DWORD) {.inline.} = self.union1.CpuRate = x
proc CpuRate*(self: JOBOBJECT_CPU_RATE_CONTROL_INFORMATION): DWORD {.inline.} = self.union1.CpuRate
proc CpuRate*(self: var JOBOBJECT_CPU_RATE_CONTROL_INFORMATION): var DWORD {.inline.} = self.union1.CpuRate
proc `Weight=`*(self: var JOBOBJECT_CPU_RATE_CONTROL_INFORMATION, x: DWORD) {.inline.} = self.union1.Weight = x
proc Weight*(self: JOBOBJECT_CPU_RATE_CONTROL_INFORMATION): DWORD {.inline.} = self.union1.Weight
proc Weight*(self: var JOBOBJECT_CPU_RATE_CONTROL_INFORMATION): var DWORD {.inline.} = self.union1.Weight
proc `ProcessorCore=`*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION, x: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_ProcessorCore) {.inline.} = self.union1.ProcessorCore = x
proc ProcessorCore*(self: SYSTEM_LOGICAL_PROCESSOR_INFORMATION): SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_ProcessorCore {.inline.} = self.union1.ProcessorCore
proc ProcessorCore*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION): var SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_ProcessorCore {.inline.} = self.union1.ProcessorCore
proc `NumaNode=`*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION, x: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_NumaNode) {.inline.} = self.union1.NumaNode = x
proc NumaNode*(self: SYSTEM_LOGICAL_PROCESSOR_INFORMATION): SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_NumaNode {.inline.} = self.union1.NumaNode
proc NumaNode*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION): var SYSTEM_LOGICAL_PROCESSOR_INFORMATION_UNION1_NumaNode {.inline.} = self.union1.NumaNode
proc `Cache=`*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION, x: CACHE_DESCRIPTOR) {.inline.} = self.union1.Cache = x
proc Cache*(self: SYSTEM_LOGICAL_PROCESSOR_INFORMATION): CACHE_DESCRIPTOR {.inline.} = self.union1.Cache
proc Cache*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION): var CACHE_DESCRIPTOR {.inline.} = self.union1.Cache
proc `Reserved=`*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION, x: array[2, ULONGLONG]) {.inline.} = self.union1.Reserved = x
proc Reserved*(self: SYSTEM_LOGICAL_PROCESSOR_INFORMATION): array[2, ULONGLONG] {.inline.} = self.union1.Reserved
proc Reserved*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION): var array[2, ULONGLONG] {.inline.} = self.union1.Reserved
proc `Processor=`*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX, x: PROCESSOR_RELATIONSHIP) {.inline.} = self.union1.Processor = x
proc Processor*(self: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX): PROCESSOR_RELATIONSHIP {.inline.} = self.union1.Processor
proc Processor*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX): var PROCESSOR_RELATIONSHIP {.inline.} = self.union1.Processor
proc `NumaNode=`*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX, x: NUMA_NODE_RELATIONSHIP) {.inline.} = self.union1.NumaNode = x
proc NumaNode*(self: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX): NUMA_NODE_RELATIONSHIP {.inline.} = self.union1.NumaNode
proc NumaNode*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX): var NUMA_NODE_RELATIONSHIP {.inline.} = self.union1.NumaNode
proc `Cache=`*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX, x: CACHE_RELATIONSHIP) {.inline.} = self.union1.Cache = x
proc Cache*(self: SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX): CACHE_RELATIONSHIP {.inline.} = self.union1.Cache
proc Cache*(self: var SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX): var CACHE_RELATIONSHIP {.inline.} = self.union1.Cache
proc `AllowScaling=`*(self: var PROCESSOR_IDLESTATE_POLICY, x: WORD) {.inline.} = self.Flags.struct1.AllowScaling = x
proc AllowScaling*(self: PROCESSOR_IDLESTATE_POLICY): WORD {.inline.} = self.Flags.struct1.AllowScaling
proc `Disabled=`*(self: var PROCESSOR_IDLESTATE_POLICY, x: WORD) {.inline.} = self.Flags.struct1.Disabled = x
proc Disabled*(self: PROCESSOR_IDLESTATE_POLICY): WORD {.inline.} = self.Flags.struct1.Disabled
proc `Reserved=`*(self: var PROCESSOR_IDLESTATE_POLICY, x: WORD) {.inline.} = self.Flags.struct1.Reserved = x
proc Reserved*(self: PROCESSOR_IDLESTATE_POLICY): WORD {.inline.} = self.Flags.struct1.Reserved
proc `Spare=`*(self: var PROCESSOR_PERFSTATE_POLICY, x: BYTE) {.inline.} = self.union1.Spare = x
proc Spare*(self: PROCESSOR_PERFSTATE_POLICY): BYTE {.inline.} = self.union1.Spare
proc Spare*(self: var PROCESSOR_PERFSTATE_POLICY): var BYTE {.inline.} = self.union1.Spare
proc `NoDomainAccounting=`*(self: var PROCESSOR_PERFSTATE_POLICY, x: BYTE) {.inline.} = self.union1.Flags.struct1.NoDomainAccounting = x
proc NoDomainAccounting*(self: PROCESSOR_PERFSTATE_POLICY): BYTE {.inline.} = self.union1.Flags.struct1.NoDomainAccounting
proc `IncreasePolicy=`*(self: var PROCESSOR_PERFSTATE_POLICY, x: BYTE) {.inline.} = self.union1.Flags.struct1.IncreasePolicy = x
proc IncreasePolicy*(self: PROCESSOR_PERFSTATE_POLICY): BYTE {.inline.} = self.union1.Flags.struct1.IncreasePolicy
proc `DecreasePolicy=`*(self: var PROCESSOR_PERFSTATE_POLICY, x: BYTE) {.inline.} = self.union1.Flags.struct1.DecreasePolicy = x
proc DecreasePolicy*(self: PROCESSOR_PERFSTATE_POLICY): BYTE {.inline.} = self.union1.Flags.struct1.DecreasePolicy
proc `Reserved=`*(self: var PROCESSOR_PERFSTATE_POLICY, x: BYTE) {.inline.} = self.union1.Flags.struct1.Reserved = x
proc Reserved*(self: PROCESSOR_PERFSTATE_POLICY): BYTE {.inline.} = self.union1.Flags.struct1.Reserved
proc `Flags=`*(self: var PROCESSOR_PERFSTATE_POLICY, x: PROCESSOR_PERFSTATE_POLICY_UNION1_Flags) {.inline.} = self.union1.Flags = x
proc Flags*(self: PROCESSOR_PERFSTATE_POLICY): PROCESSOR_PERFSTATE_POLICY_UNION1_Flags {.inline.} = self.union1.Flags
proc Flags*(self: var PROCESSOR_PERFSTATE_POLICY): var PROCESSOR_PERFSTATE_POLICY_UNION1_Flags {.inline.} = self.union1.Flags
proc `TokenDef=`*(self: var IMAGE_AUX_SYMBOL_EX, x: IMAGE_AUX_SYMBOL_TOKEN_DEF) {.inline.} = self.struct4.TokenDef = x
proc TokenDef*(self: IMAGE_AUX_SYMBOL_EX): IMAGE_AUX_SYMBOL_TOKEN_DEF {.inline.} = self.struct4.TokenDef
proc TokenDef*(self: var IMAGE_AUX_SYMBOL_EX): var IMAGE_AUX_SYMBOL_TOKEN_DEF {.inline.} = self.struct4.TokenDef
proc `rgbReserved=`*(self: var IMAGE_AUX_SYMBOL_EX, x: array[2, BYTE]) {.inline.} = self.struct4.rgbReserved = x
proc rgbReserved*(self: IMAGE_AUX_SYMBOL_EX): array[2, BYTE] {.inline.} = self.struct4.rgbReserved
proc rgbReserved*(self: var IMAGE_AUX_SYMBOL_EX): var array[2, BYTE] {.inline.} = self.struct4.rgbReserved
proc `VirtualAddress=`*(self: var IMAGE_RELOCATION, x: DWORD) {.inline.} = self.union1.VirtualAddress = x
proc VirtualAddress*(self: IMAGE_RELOCATION): DWORD {.inline.} = self.union1.VirtualAddress
proc VirtualAddress*(self: var IMAGE_RELOCATION): var DWORD {.inline.} = self.union1.VirtualAddress
proc `RelocCount=`*(self: var IMAGE_RELOCATION, x: DWORD) {.inline.} = self.union1.RelocCount = x
proc RelocCount*(self: IMAGE_RELOCATION): DWORD {.inline.} = self.union1.RelocCount
proc RelocCount*(self: var IMAGE_RELOCATION): var DWORD {.inline.} = self.union1.RelocCount
proc `Characteristics=`*(self: var IMAGE_IMPORT_DESCRIPTOR, x: DWORD) {.inline.} = self.union1.Characteristics = x
proc Characteristics*(self: IMAGE_IMPORT_DESCRIPTOR): DWORD {.inline.} = self.union1.Characteristics
proc Characteristics*(self: var IMAGE_IMPORT_DESCRIPTOR): var DWORD {.inline.} = self.union1.Characteristics
proc `OriginalFirstThunk=`*(self: var IMAGE_IMPORT_DESCRIPTOR, x: DWORD) {.inline.} = self.union1.OriginalFirstThunk = x
proc OriginalFirstThunk*(self: IMAGE_IMPORT_DESCRIPTOR): DWORD {.inline.} = self.union1.OriginalFirstThunk
proc OriginalFirstThunk*(self: var IMAGE_IMPORT_DESCRIPTOR): var DWORD {.inline.} = self.union1.OriginalFirstThunk
proc `RvaBased=`*(self: var IMAGE_DELAYLOAD_DESCRIPTOR, x: DWORD) {.inline.} = self.Attributes.struct1.RvaBased = x
proc RvaBased*(self: IMAGE_DELAYLOAD_DESCRIPTOR): DWORD {.inline.} = self.Attributes.struct1.RvaBased
proc `ReservedAttributes=`*(self: var IMAGE_DELAYLOAD_DESCRIPTOR, x: DWORD) {.inline.} = self.Attributes.struct1.ReservedAttributes = x
proc ReservedAttributes*(self: IMAGE_DELAYLOAD_DESCRIPTOR): DWORD {.inline.} = self.Attributes.struct1.ReservedAttributes
proc `NameOffset=`*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY, x: DWORD) {.inline.} = self.union1.struct1.NameOffset = x
proc NameOffset*(self: IMAGE_RESOURCE_DIRECTORY_ENTRY): DWORD {.inline.} = self.union1.struct1.NameOffset
proc `NameIsString=`*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY, x: DWORD) {.inline.} = self.union1.struct1.NameIsString = x
proc NameIsString*(self: IMAGE_RESOURCE_DIRECTORY_ENTRY): DWORD {.inline.} = self.union1.struct1.NameIsString
proc `Name=`*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY, x: DWORD) {.inline.} = self.union1.Name = x
proc Name*(self: IMAGE_RESOURCE_DIRECTORY_ENTRY): DWORD {.inline.} = self.union1.Name
proc Name*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY): var DWORD {.inline.} = self.union1.Name
proc `Id=`*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY, x: WORD) {.inline.} = self.union1.Id = x
proc Id*(self: IMAGE_RESOURCE_DIRECTORY_ENTRY): WORD {.inline.} = self.union1.Id
proc Id*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY): var WORD {.inline.} = self.union1.Id
proc `OffsetToData=`*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY, x: DWORD) {.inline.} = self.union2.OffsetToData = x
proc OffsetToData*(self: IMAGE_RESOURCE_DIRECTORY_ENTRY): DWORD {.inline.} = self.union2.OffsetToData
proc OffsetToData*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY): var DWORD {.inline.} = self.union2.OffsetToData
proc `OffsetToDirectory=`*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY, x: DWORD) {.inline.} = self.union2.struct1.OffsetToDirectory = x
proc OffsetToDirectory*(self: IMAGE_RESOURCE_DIRECTORY_ENTRY): DWORD {.inline.} = self.union2.struct1.OffsetToDirectory
proc `DataIsDirectory=`*(self: var IMAGE_RESOURCE_DIRECTORY_ENTRY, x: DWORD) {.inline.} = self.union2.struct1.DataIsDirectory = x
proc DataIsDirectory*(self: IMAGE_RESOURCE_DIRECTORY_ENTRY): DWORD {.inline.} = self.union2.struct1.DataIsDirectory
proc `EndOfPrologue=`*(self: var IMAGE_FUNCTION_ENTRY64, x: ULONGLONG) {.inline.} = self.union1.EndOfPrologue = x
proc EndOfPrologue*(self: IMAGE_FUNCTION_ENTRY64): ULONGLONG {.inline.} = self.union1.EndOfPrologue
proc EndOfPrologue*(self: var IMAGE_FUNCTION_ENTRY64): var ULONGLONG {.inline.} = self.union1.EndOfPrologue
proc `UnwindInfoAddress=`*(self: var IMAGE_FUNCTION_ENTRY64, x: ULONGLONG) {.inline.} = self.union1.UnwindInfoAddress = x
proc UnwindInfoAddress*(self: IMAGE_FUNCTION_ENTRY64): ULONGLONG {.inline.} = self.union1.UnwindInfoAddress
proc UnwindInfoAddress*(self: var IMAGE_FUNCTION_ENTRY64): var ULONGLONG {.inline.} = self.union1.UnwindInfoAddress
proc `Ordinal=`*(self: var IMPORT_OBJECT_HEADER, x: WORD) {.inline.} = self.union1.Ordinal = x
proc Ordinal*(self: IMPORT_OBJECT_HEADER): WORD {.inline.} = self.union1.Ordinal
proc Ordinal*(self: var IMPORT_OBJECT_HEADER): var WORD {.inline.} = self.union1.Ordinal
proc `Hint=`*(self: var IMPORT_OBJECT_HEADER, x: WORD) {.inline.} = self.union1.Hint = x
proc Hint*(self: IMPORT_OBJECT_HEADER): WORD {.inline.} = self.union1.Hint
proc Hint*(self: var IMPORT_OBJECT_HEADER): var WORD {.inline.} = self.union1.Hint
proc `EntryPointToken=`*(self: var IMAGE_COR20_HEADER, x: DWORD) {.inline.} = self.union1.EntryPointToken = x
proc EntryPointToken*(self: IMAGE_COR20_HEADER): DWORD {.inline.} = self.union1.EntryPointToken
proc EntryPointToken*(self: var IMAGE_COR20_HEADER): var DWORD {.inline.} = self.union1.EntryPointToken
proc `EntryPointRVA=`*(self: var IMAGE_COR20_HEADER, x: DWORD) {.inline.} = self.union1.EntryPointRVA = x
proc EntryPointRVA*(self: IMAGE_COR20_HEADER): DWORD {.inline.} = self.union1.EntryPointRVA
proc EntryPointRVA*(self: var IMAGE_COR20_HEADER): var DWORD {.inline.} = self.union1.EntryPointRVA
proc `CheckSum=`*(self: var LDR_DATA_TABLE_ENTRY, x: ULONG) {.inline.} = self.union1.CheckSum = x
proc CheckSum*(self: LDR_DATA_TABLE_ENTRY): ULONG {.inline.} = self.union1.CheckSum
proc CheckSum*(self: var LDR_DATA_TABLE_ENTRY): var ULONG {.inline.} = self.union1.CheckSum
proc `Reserved6=`*(self: var LDR_DATA_TABLE_ENTRY, x: PVOID) {.inline.} = self.union1.Reserved6 = x
proc Reserved6*(self: LDR_DATA_TABLE_ENTRY): PVOID {.inline.} = self.union1.Reserved6
proc Reserved6*(self: var LDR_DATA_TABLE_ENTRY): var PVOID {.inline.} = self.union1.Reserved6
proc `Status=`*(self: var IO_STATUS_BLOCK, x: NTSTATUS) {.inline.} = self.union1.Status = x
proc Status*(self: IO_STATUS_BLOCK): NTSTATUS {.inline.} = self.union1.Status
proc Status*(self: var IO_STATUS_BLOCK): var NTSTATUS {.inline.} = self.union1.Status
proc `Pointer=`*(self: var IO_STATUS_BLOCK, x: PVOID) {.inline.} = self.union1.Pointer = x
proc Pointer*(self: IO_STATUS_BLOCK): PVOID {.inline.} = self.union1.Pointer
proc Pointer*(self: var IO_STATUS_BLOCK): var PVOID {.inline.} = self.union1.Pointer
when winimUnicode:
  type
    PCZZTSTR* = PCZZWSTR
    PCUZZTSTR* = PCUZZWSTR
    PNZTCH* = PNZWCH
    PCNZTCH* = PCNZWCH
    PCUNZTCH* = PCUNZWCH
    OSVERSIONINFO* = OSVERSIONINFOW
    POSVERSIONINFO* = POSVERSIONINFOW
    LPOSVERSIONINFO* = LPOSVERSIONINFOW
    OSVERSIONINFOEX* = OSVERSIONINFOEXW
    POSVERSIONINFOEX* = POSVERSIONINFOEXW
    LPOSVERSIONINFOEX* = LPOSVERSIONINFOEXW
when winimAnsi:
  type
    PCZZTSTR* = PCZZSTR
    PCUZZTSTR* = PCZZSTR
    PNZTCH* = PNZCH
    PUNZTCH* = PNZCH
    PCNZTCH* = PCNZCH
    PCUNZTCH* = PCNZCH
    OSVERSIONINFO* = OSVERSIONINFOA
    POSVERSIONINFO* = POSVERSIONINFOA
    LPOSVERSIONINFO* = LPOSVERSIONINFOA
    OSVERSIONINFOEX* = OSVERSIONINFOEXA
    POSVERSIONINFOEX* = POSVERSIONINFOEXA
    LPOSVERSIONINFOEX* = LPOSVERSIONINFOEXA
when winimCpu64:
  type
    PXSAVE_FORMAT* = ptr XSAVE_FORMAT
    XSTATE_CONTEXT* {.pure.} = object
      Mask*: DWORD64
      Length*: DWORD
      Reserved1*: DWORD
      Area*: PXSAVE_AREA
      Buffer*: PVOID
when winimCpu32:
  type
    XSTATE_CONTEXT* {.pure.} = object
      Mask*: DWORD64
      Length*: DWORD
      Reserved1*: DWORD
      Area*: PXSAVE_AREA
      Reserved2*: DWORD
      Buffer*: PVOID
      Reserved3*: DWORD
when winimCpu64:
  type
    PXSTATE_CONTEXT* = ptr XSTATE_CONTEXT
    PXMM_SAVE_AREA32* = ptr XMM_SAVE_AREA32
    RUNTIME_FUNCTION* {.pure.} = object
      BeginAddress*: DWORD
      EndAddress*: DWORD
      UnwindData*: DWORD
    PRUNTIME_FUNCTION* = ptr RUNTIME_FUNCTION
    UNWIND_HISTORY_TABLE_ENTRY* {.pure.} = object
      ImageBase*: ULONG64
      FunctionEntry*: PRUNTIME_FUNCTION
    PUNWIND_HISTORY_TABLE_ENTRY* = ptr UNWIND_HISTORY_TABLE_ENTRY
  const
    UNWIND_HISTORY_TABLE_SIZE* = 12
  type
    UNWIND_HISTORY_TABLE* {.pure.} = object
      Count*: ULONG
      Search*: UCHAR
      LowAddress*: ULONG64
      HighAddress*: ULONG64
      Entry*: array[UNWIND_HISTORY_TABLE_SIZE, UNWIND_HISTORY_TABLE_ENTRY]
    PUNWIND_HISTORY_TABLE* = ptr UNWIND_HISTORY_TABLE
    DISPATCHER_CONTEXT* {.pure.} = object
      ControlPc*: ULONG64
      ImageBase*: ULONG64
      FunctionEntry*: PRUNTIME_FUNCTION
      EstablisherFrame*: ULONG64
      TargetIp*: ULONG64
      ContextRecord*: PCONTEXT
      LanguageHandler*: PEXCEPTION_ROUTINE
      HandlerData*: PVOID
      HistoryTable*: PUNWIND_HISTORY_TABLE
      ScopeIndex*: ULONG
      Fill0*: ULONG
    PDISPATCHER_CONTEXT* = ptr DISPATCHER_CONTEXT
    KNONVOLATILE_CONTEXT_POINTERS* {.pure.} = object
      FloatingContext*: array[16, PM128A]
      IntegerContext*: array[16, PULONG64]
    PKNONVOLATILE_CONTEXT_POINTERS* = ptr KNONVOLATILE_CONTEXT_POINTERS
    IMAGE_OPTIONAL_HEADER* = IMAGE_OPTIONAL_HEADER64
    PIMAGE_OPTIONAL_HEADER* = PIMAGE_OPTIONAL_HEADER64
    IMAGE_NT_HEADERS* = IMAGE_NT_HEADERS64
    IMAGE_THUNK_DATA* = IMAGE_THUNK_DATA64
    PIMAGE_THUNK_DATA* = PIMAGE_THUNK_DATA64
    IMAGE_TLS_DIRECTORY* = IMAGE_TLS_DIRECTORY64
    PIMAGE_TLS_DIRECTORY* = PIMAGE_TLS_DIRECTORY64
    IMAGE_LOAD_CONFIG_DIRECTORY* = IMAGE_LOAD_CONFIG_DIRECTORY64
    PIMAGE_LOAD_CONFIG_DIRECTORY* = PIMAGE_LOAD_CONFIG_DIRECTORY64
  const
    ADDRESS_TAG_BIT* = 0x40000000000
    EXCEPTION_READ_FAULT* = 0
    EXCEPTION_WRITE_FAULT* = 1
    EXCEPTION_EXECUTE_FAULT* = 8
    CONTEXT_AMD64* = 0x100000
    CONTEXT_CONTROL* = CONTEXT_AMD64 or 0x1
    CONTEXT_INTEGER* = CONTEXT_AMD64 or 0x2
    CONTEXT_SEGMENTS* = CONTEXT_AMD64 or 0x4
    CONTEXT_FLOATING_POINT* = CONTEXT_AMD64 or 0x8
    CONTEXT_DEBUG_REGISTERS* = CONTEXT_AMD64 or 0x10
when winimCpu32:
  const
    CONTEXT_i386* = 0x00010000
    CONTEXT_CONTROL* = CONTEXT_i386 or 0x00000001
    CONTEXT_INTEGER* = CONTEXT_i386 or 0x00000002
    CONTEXT_FLOATING_POINT* = CONTEXT_i386 or 0x00000008
when winimCpu64:
  const
    CONTEXT_FULL* = CONTEXT_CONTROL or CONTEXT_INTEGER or CONTEXT_FLOATING_POINT
when winimCpu32:
  const
    CONTEXT_SEGMENTS* = CONTEXT_i386 or 0x00000004
    CONTEXT_DEBUG_REGISTERS* = CONTEXT_i386 or 0x00000010
when winimCpu64:
  const
    CONTEXT_ALL* = CONTEXT_CONTROL or CONTEXT_INTEGER or CONTEXT_SEGMENTS or CONTEXT_FLOATING_POINT or CONTEXT_DEBUG_REGISTERS
    CONTEXT_EXCEPTION_ACTIVE* = 0x8000000
    CONTEXT_SERVICE_ACTIVE* = 0x10000000
    CONTEXT_EXCEPTION_REQUEST* = 0x40000000
    CONTEXT_EXCEPTION_REPORTING* = 0x80000000'i32
    INITIAL_MXCSR* = 0x1f80
    INITIAL_FPCSR* = 0x027f
    RUNTIME_FUNCTION_INDIRECT* = 0x1
    OUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK_EXPORT_NAME* = "OutOfProcessFunctionTableCallback"
    UNW_FLAG_NHANDLER* = 0x0
    UNW_FLAG_EHANDLER* = 0x1
    UNW_FLAG_UHANDLER* = 0x2
    UNW_FLAG_CHAININFO* = 0x4
    UNWIND_HISTORY_TABLE_NONE* = 0
    UNWIND_HISTORY_TABLE_GLOBAL* = 1
    UNWIND_HISTORY_TABLE_LOCAL* = 2
    IMAGE_SIZEOF_NT_OPTIONAL_HEADER* = IMAGE_SIZEOF_NT_OPTIONAL64_HEADER
    IMAGE_NT_OPTIONAL_HDR_MAGIC* = IMAGE_NT_OPTIONAL_HDR64_MAGIC
    IMAGE_ORDINAL_FLAG* = IMAGE_ORDINAL_FLAG64
    LEGACY_SAVE_AREA_LENGTH* = 0x00000200
  type
    PGET_RUNTIME_FUNCTION_CALLBACK* = proc (ControlPc: DWORD64, Context: PVOID): PRUNTIME_FUNCTION {.stdcall.}
    POUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK* = proc (Process: HANDLE, TableAddress: PVOID, Entries: PDWORD, Functions: ptr PRUNTIME_FUNCTION): DWORD {.stdcall.}
  proc RtlAddGrowableFunctionTable*(DynamicTable: ptr PVOID, FunctionTable: PRUNTIME_FUNCTION, EntryCount: DWORD, MaximumEntryCount: DWORD, RangeBase: ULONG_PTR, RangeEnd: ULONG_PTR): DWORD {.winapi, stdcall, dynlib: "ntdll", importc.}
  proc RtlGrowFunctionTable*(DynamicTable: PVOID, NewEntryCount: DWORD): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
  proc RtlDeleteGrowableFunctionTable*(DynamicTable: PVOID): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
  proc RtlAddFunctionTable*(FunctionTable: PRUNTIME_FUNCTION, EntryCount: DWORD, BaseAddress: DWORD64): BOOLEAN {.winapi, cdecl, dynlib: "ntdll", importc.}
  proc RtlDeleteFunctionTable*(FunctionTable: PRUNTIME_FUNCTION): BOOLEAN {.winapi, cdecl, dynlib: "ntdll", importc.}
  proc RtlInstallFunctionTableCallback*(TableIdentifier: DWORD64, BaseAddress: DWORD64, Length: DWORD, Callback: PGET_RUNTIME_FUNCTION_CALLBACK, Context: PVOID, OutOfProcessCallbackDll: PCWSTR): BOOLEAN {.winapi, cdecl, dynlib: "ntdll", importc.}
  proc RtlRestoreContext*(ContextRecord: PCONTEXT, ExceptionRecord: ptr EXCEPTION_RECORD): VOID {.winapi, cdecl, dynlib: "ntdll", importc.}
  proc RtlVirtualUnwind*(HandlerType: DWORD, ImageBase: DWORD64, ControlPc: DWORD64, FunctionEntry: PRUNTIME_FUNCTION, ContextRecord: PCONTEXT, HandlerData: ptr PVOID, EstablisherFrame: PDWORD64, ContextPointers: PKNONVOLATILE_CONTEXT_POINTERS): PEXCEPTION_ROUTINE {.winapi, stdcall, dynlib: "ntdll", importc.}
  proc RtlLookupFunctionEntry*(ControlPc: DWORD64, ImageBase: PDWORD64, HistoryTable: PUNWIND_HISTORY_TABLE): PRUNTIME_FUNCTION {.winapi, stdcall, dynlib: "ntdll", importc.}
  proc RtlUnwindEx*(TargetFrame: PVOID, TargetIp: PVOID, ExceptionRecord: PEXCEPTION_RECORD, ReturnValue: PVOID, ContextRecord: PCONTEXT, HistoryTable: PUNWIND_HISTORY_TABLE): VOID {.winapi, stdcall, dynlib: "ntdll", importc.}
  template IMAGE_ORDINAL*(Ordinal: untyped): int64 = Ordinal.int64 and 0xffff'i64
  template IMAGE_SNAP_BY_ORDINAL*(Ordinal: untyped): bool = (Ordinal and IMAGE_ORDINAL_FLAG64) != 0
  proc `FltSave=`*(self: var CONTEXT, x: XMM_SAVE_AREA32) {.inline.} = self.union1.FltSave = x
  proc FltSave*(self: CONTEXT): XMM_SAVE_AREA32 {.inline.} = self.union1.FltSave
  proc FltSave*(self: var CONTEXT): var XMM_SAVE_AREA32 {.inline.} = self.union1.FltSave
  proc `FloatSave=`*(self: var CONTEXT, x: XMM_SAVE_AREA32) {.inline.} = self.union1.FloatSave = x
  proc FloatSave*(self: CONTEXT): XMM_SAVE_AREA32 {.inline.} = self.union1.FloatSave
  proc FloatSave*(self: var CONTEXT): var XMM_SAVE_AREA32 {.inline.} = self.union1.FloatSave
  proc `Header=`*(self: var CONTEXT, x: array[2, M128A]) {.inline.} = self.union1.struct1.Header = x
  proc Header*(self: CONTEXT): array[2, M128A] {.inline.} = self.union1.struct1.Header
  proc Header*(self: var CONTEXT): var array[2, M128A] {.inline.} = self.union1.struct1.Header
  proc `Legacy=`*(self: var CONTEXT, x: array[8, M128A]) {.inline.} = self.union1.struct1.Legacy = x
  proc Legacy*(self: CONTEXT): array[8, M128A] {.inline.} = self.union1.struct1.Legacy
  proc Legacy*(self: var CONTEXT): var array[8, M128A] {.inline.} = self.union1.struct1.Legacy
  proc `Xmm0=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm0 = x
  proc Xmm0*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm0
  proc Xmm0*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm0
  proc `Xmm1=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm1 = x
  proc Xmm1*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm1
  proc Xmm1*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm1
  proc `Xmm2=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm2 = x
  proc Xmm2*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm2
  proc Xmm2*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm2
  proc `Xmm3=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm3 = x
  proc Xmm3*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm3
  proc Xmm3*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm3
  proc `Xmm4=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm4 = x
  proc Xmm4*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm4
  proc Xmm4*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm4
  proc `Xmm5=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm5 = x
  proc Xmm5*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm5
  proc Xmm5*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm5
  proc `Xmm6=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm6 = x
  proc Xmm6*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm6
  proc Xmm6*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm6
  proc `Xmm7=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm7 = x
  proc Xmm7*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm7
  proc Xmm7*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm7
  proc `Xmm8=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm8 = x
  proc Xmm8*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm8
  proc Xmm8*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm8
  proc `Xmm9=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm9 = x
  proc Xmm9*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm9
  proc Xmm9*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm9
  proc `Xmm10=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm10 = x
  proc Xmm10*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm10
  proc Xmm10*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm10
  proc `Xmm11=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm11 = x
  proc Xmm11*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm11
  proc Xmm11*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm11
  proc `Xmm12=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm12 = x
  proc Xmm12*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm12
  proc Xmm12*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm12
  proc `Xmm13=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm13 = x
  proc Xmm13*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm13
  proc Xmm13*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm13
  proc `Xmm14=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm14 = x
  proc Xmm14*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm14
  proc Xmm14*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm14
  proc `Xmm15=`*(self: var CONTEXT, x: M128A) {.inline.} = self.union1.struct1.Xmm15 = x
  proc Xmm15*(self: CONTEXT): M128A {.inline.} = self.union1.struct1.Xmm15
  proc Xmm15*(self: var CONTEXT): var M128A {.inline.} = self.union1.struct1.Xmm15
  proc `Alignment=`*(self: var SLIST_HEADER, x: ULONGLONG) {.inline.} = self.struct1.Alignment = x
  proc Alignment*(self: SLIST_HEADER): ULONGLONG {.inline.} = self.struct1.Alignment
  proc Alignment*(self: var SLIST_HEADER): var ULONGLONG {.inline.} = self.struct1.Alignment
  proc `Region=`*(self: var SLIST_HEADER, x: ULONGLONG) {.inline.} = self.struct1.Region = x
  proc Region*(self: SLIST_HEADER): ULONGLONG {.inline.} = self.struct1.Region
  proc Region*(self: var SLIST_HEADER): var ULONGLONG {.inline.} = self.struct1.Region
when winimCpu32:
  type
    HALF_PTR* = int16
    PHALF_PTR* = ptr int16
    PXSAVE_FORMAT* = ptr XSAVE_FORMAT
    PXSTATE_CONTEXT* = ptr XSTATE_CONTEXT
    PFLOATING_SAVE_AREA* = ptr FLOATING_SAVE_AREA
    IMAGE_OPTIONAL_HEADER* = IMAGE_OPTIONAL_HEADER32
    PIMAGE_OPTIONAL_HEADER* = PIMAGE_OPTIONAL_HEADER32
    IMAGE_NT_HEADERS* = IMAGE_NT_HEADERS32
    IMAGE_THUNK_DATA* = IMAGE_THUNK_DATA32
    PIMAGE_THUNK_DATA* = PIMAGE_THUNK_DATA32
    IMAGE_TLS_DIRECTORY* = IMAGE_TLS_DIRECTORY32
    PIMAGE_TLS_DIRECTORY* = PIMAGE_TLS_DIRECTORY32
    IMAGE_LOAD_CONFIG_DIRECTORY* = IMAGE_LOAD_CONFIG_DIRECTORY32
    PIMAGE_LOAD_CONFIG_DIRECTORY* = PIMAGE_LOAD_CONFIG_DIRECTORY32
  const
    ADDRESS_TAG_BIT* = 0x80000000'i32
    pcTeb* = 0x18
    EXCEPTION_READ_FAULT* = 0
    EXCEPTION_WRITE_FAULT* = 1
    EXCEPTION_EXECUTE_FAULT* = 8
    CONTEXT_i486* = 0x00010000
    CONTEXT_EXTENDED_REGISTERS* = CONTEXT_i386 or 0x00000020
    CONTEXT_FULL* = CONTEXT_CONTROL or CONTEXT_INTEGER or CONTEXT_SEGMENTS
    CONTEXT_ALL* = CONTEXT_CONTROL or CONTEXT_INTEGER or CONTEXT_SEGMENTS or CONTEXT_FLOATING_POINT or CONTEXT_DEBUG_REGISTERS or CONTEXT_EXTENDED_REGISTERS
    IMAGE_SIZEOF_NT_OPTIONAL_HEADER* = IMAGE_SIZEOF_NT_OPTIONAL32_HEADER
    IMAGE_NT_OPTIONAL_HDR_MAGIC* = IMAGE_NT_OPTIONAL_HDR32_MAGIC
    IMAGE_ORDINAL_FLAG* = IMAGE_ORDINAL_FLAG32
  template IMAGE_ORDINAL*(Ordinal: untyped): int32 = Ordinal.int32 and 0xffff'i32
  template IMAGE_SNAP_BY_ORDINAL*(Ordinal: untyped): bool = (Ordinal and IMAGE_ORDINAL_FLAG32) != 0
  proc `Next=`*(self: var SLIST_HEADER, x: SLIST_ENTRY) {.inline.} = self.struct1.Next = x
  proc Next*(self: SLIST_HEADER): SLIST_ENTRY {.inline.} = self.struct1.Next
  proc Next*(self: var SLIST_HEADER): var SLIST_ENTRY {.inline.} = self.struct1.Next
  proc `Depth=`*(self: var SLIST_HEADER, x: WORD) {.inline.} = self.struct1.Depth = x
  proc Depth*(self: SLIST_HEADER): WORD {.inline.} = self.struct1.Depth
  proc Depth*(self: var SLIST_HEADER): var WORD {.inline.} = self.struct1.Depth
  proc `Sequence=`*(self: var SLIST_HEADER, x: WORD) {.inline.} = self.struct1.Sequence = x
  proc Sequence*(self: SLIST_HEADER): WORD {.inline.} = self.struct1.Sequence
  proc Sequence*(self: var SLIST_HEADER): var WORD {.inline.} = self.struct1.Sequence
