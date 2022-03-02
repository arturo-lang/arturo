#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import winver
import wintrust
#include <imagehlp.h>
#include <psdk_inc/_dbg_load_image.h>
#include <psdk_inc/_dbg_common.h>
type
  IMAGEHLP_STATUS_REASON* = int32
  ADDRESS_MODE* = int32
  SYM_TYPE* = int32
  PIMAGEHLP_CONTEXT* = pointer
  IMAGEHLP_SYMBOL_TYPE_INFO* = int32
  MINIDUMP_STREAM_TYPE* = int32
  MINIDUMP_CALLBACK_TYPE* = int32
  TTHREAD_WRITE_FLAGS* = int32
  TMODULE_WRITE_FLAGS* = int32
  MINIDUMP_SECONDARY_FLAGS* = int32
  MINIDUMP_TYPE* = int32
  DIGEST_HANDLE* = PVOID
  RVA* = DWORD
  LOADED_IMAGE* {.pure.} = object
    ModuleName*: PSTR
    hFile*: HANDLE
    MappedAddress*: PUCHAR
    FileHeader*: PIMAGE_NT_HEADERS
    LastRvaSection*: PIMAGE_SECTION_HEADER
    NumberOfSections*: ULONG
    Sections*: PIMAGE_SECTION_HEADER
    Characteristics*: ULONG
    fSystemImage*: BOOLEAN
    fDOSImage*: BOOLEAN
    fReadOnly*: BOOLEAN
    Version*: UCHAR
    Links*: LIST_ENTRY
    SizeOfImage*: ULONG
  PLOADED_IMAGE* = ptr LOADED_IMAGE
  MODLOAD_DATA* {.pure.} = object
    ssize*: DWORD
    ssig*: DWORD
    data*: PVOID
    size*: DWORD
    flags*: DWORD
  PMODLOAD_DATA* = ptr MODLOAD_DATA
  MODLOAD_CVMISC* {.pure.} = object
    oCV*: DWORD
    cCV*: int
    oMisc*: DWORD
    cMisc*: int
    dtImage*: DWORD
    cImage*: DWORD
  PMODLOAD_CVMISC* = ptr MODLOAD_CVMISC
  TADDRESS64* {.pure.} = object
    Offset*: DWORD64
    Segment*: WORD
    Mode*: ADDRESS_MODE
  LPADDRESS64* = ptr TADDRESS64
  KDHELP64* {.pure.} = object
    Thread*: DWORD64
    ThCallbackStack*: DWORD
    ThCallbackBStore*: DWORD
    NextCallback*: DWORD
    FramePointer*: DWORD
    KiCallUserMode*: DWORD64
    KeUserCallbackDispatcher*: DWORD64
    SystemRangeStart*: DWORD64
    KiUserExceptionDispatcher*: DWORD64
    StackBase*: DWORD64
    StackLimit*: DWORD64
    Reserved*: array[5, DWORD64]
  PKDHELP64* = ptr KDHELP64
  STACKFRAME64* {.pure.} = object
    AddrPC*: TADDRESS64
    AddrReturn*: TADDRESS64
    AddrFrame*: TADDRESS64
    AddrStack*: TADDRESS64
    AddrBStore*: TADDRESS64
    FuncTableEntry*: PVOID
    Params*: array[4, DWORD64]
    Far*: WINBOOL
    Virtual*: WINBOOL
    Reserved*: array[3, DWORD64]
    KdHelp*: KDHELP64
  LPSTACKFRAME64* = ptr STACKFRAME64
  API_VERSION* {.pure.} = object
    MajorVersion*: USHORT
    MinorVersion*: USHORT
    Revision*: USHORT
    Reserved*: USHORT
  LPAPI_VERSION* = ptr API_VERSION
  IMAGEHLP_SYMBOL64* {.pure.} = object
    SizeOfStruct*: DWORD
    Address*: DWORD64
    Size*: DWORD
    Flags*: DWORD
    MaxNameLength*: DWORD
    Name*: array[1, CHAR]
  PIMAGEHLP_SYMBOL64* = ptr IMAGEHLP_SYMBOL64
const
  MAX_SYM_NAME* = 2000
type
  IMAGEHLP_SYMBOL64_PACKAGE* {.pure.} = object
    sym*: IMAGEHLP_SYMBOL64
    name*: array[MAX_SYM_NAME+1, CHAR]
  PIMAGEHLP_SYMBOL64_PACKAGE* = ptr IMAGEHLP_SYMBOL64_PACKAGE
  IMAGEHLP_MODULE64* {.pure.} = object
    SizeOfStruct*: DWORD
    BaseOfImage*: DWORD64
    ImageSize*: DWORD
    TimeDateStamp*: DWORD
    CheckSum*: DWORD
    NumSyms*: DWORD
    SymType*: SYM_TYPE
    ModuleName*: array[32, CHAR]
    ImageName*: array[256, CHAR]
    LoadedImageName*: array[256, CHAR]
    LoadedPdbName*: array[256, CHAR]
    CVSig*: DWORD
    CVData*: array[MAX_PATH*3, CHAR]
    PdbSig*: DWORD
    PdbSig70*: GUID
    PdbAge*: DWORD
    PdbUnmatched*: WINBOOL
    DbgUnmatched*: WINBOOL
    LineNumbers*: WINBOOL
    GlobalSymbols*: WINBOOL
    TypeInfo*: WINBOOL
    SourceIndexed*: WINBOOL
    Publics*: WINBOOL
  PIMAGEHLP_MODULE64* = ptr IMAGEHLP_MODULE64
  IMAGEHLP_MODULEW64* {.pure.} = object
    SizeOfStruct*: DWORD
    BaseOfImage*: DWORD64
    ImageSize*: DWORD
    TimeDateStamp*: DWORD
    CheckSum*: DWORD
    NumSyms*: DWORD
    SymType*: SYM_TYPE
    ModuleName*: array[32, WCHAR]
    ImageName*: array[256, WCHAR]
    LoadedImageName*: array[256, WCHAR]
    LoadedPdbName*: array[256, WCHAR]
    CVSig*: DWORD
    CVData*: array[MAX_PATH*3, WCHAR]
    PdbSig*: DWORD
    PdbSig70*: GUID
    PdbAge*: DWORD
    PdbUnmatched*: WINBOOL
    DbgUnmatched*: WINBOOL
    LineNumbers*: WINBOOL
    GlobalSymbols*: WINBOOL
    TypeInfo*: WINBOOL
    SourceIndexed*: WINBOOL
    Publics*: WINBOOL
  PIMAGEHLP_MODULEW64* = ptr IMAGEHLP_MODULEW64
  IMAGEHLP_LINE64* {.pure.} = object
    SizeOfStruct*: DWORD
    Key*: PVOID
    LineNumber*: DWORD
    FileName*: PCHAR
    Address*: DWORD64
  PIMAGEHLP_LINE64* = ptr IMAGEHLP_LINE64
  IMAGEHLP_LINEW64* {.pure.} = object
    SizeOfStruct*: DWORD
    Key*: PVOID
    LineNumber*: DWORD
    FileName*: PWSTR
    Address*: DWORD64
  PIMAGEHLP_LINEW64* = ptr IMAGEHLP_LINEW64
  SOURCEFILE* {.pure.} = object
    ModBase*: DWORD64
    FileName*: PCHAR
  PSOURCEFILE* = ptr SOURCEFILE
  SOURCEFILEW* {.pure.} = object
    ModBase*: DWORD64
    FileName*: PWCHAR
  PSOURCEFILEW* = ptr SOURCEFILEW
  IMAGEHLP_CBA_READ_MEMORY* {.pure.} = object
    `addr`*: DWORD64
    buf*: PVOID
    bytes*: DWORD
    bytesread*: ptr DWORD
  PIMAGEHLP_CBA_READ_MEMORY* = ptr IMAGEHLP_CBA_READ_MEMORY
  IMAGEHLP_CBA_EVENT* {.pure.} = object
    severity*: DWORD
    code*: DWORD
    desc*: PCHAR
    `object`*: PVOID
  PIMAGEHLP_CBA_EVENT* = ptr IMAGEHLP_CBA_EVENT
  IMAGEHLP_DEFERRED_SYMBOL_LOAD64* {.pure.} = object
    SizeOfStruct*: DWORD
    BaseOfImage*: DWORD64
    CheckSum*: DWORD
    TimeDateStamp*: DWORD
    FileName*: array[MAX_PATH, CHAR]
    Reparse*: BOOLEAN
    hFile*: HANDLE
    Flags*: DWORD
  PIMAGEHLP_DEFERRED_SYMBOL_LOAD64* = ptr IMAGEHLP_DEFERRED_SYMBOL_LOAD64
  IMAGEHLP_DUPLICATE_SYMBOL64* {.pure.} = object
    SizeOfStruct*: DWORD
    NumberOfDups*: DWORD
    Symbol*: PIMAGEHLP_SYMBOL64
    SelectedSymbol*: DWORD
  PIMAGEHLP_DUPLICATE_SYMBOL64* = ptr IMAGEHLP_DUPLICATE_SYMBOL64
  SYMSRV_INDEX_INFO* {.pure.} = object
    sizeofstruct*: DWORD
    file*: array[MAX_PATH+1, CHAR]
    stripped*: WINBOOL
    timestamp*: DWORD
    size*: DWORD
    dbgfile*: array[MAX_PATH+1, CHAR]
    pdbfile*: array[MAX_PATH+1, CHAR]
    guid*: GUID
    sig*: DWORD
    age*: DWORD
  PSYMSRV_INDEX_INFO* = ptr SYMSRV_INDEX_INFO
  SYMSRV_INDEX_INFOW* {.pure.} = object
    sizeofstruct*: DWORD
    file*: array[MAX_PATH+1, WCHAR]
    stripped*: WINBOOL
    timestamp*: DWORD
    size*: DWORD
    dbgfile*: array[MAX_PATH+1, WCHAR]
    pdbfile*: array[MAX_PATH+1, WCHAR]
    guid*: GUID
    sig*: DWORD
    age*: DWORD
  PSYMSRV_INDEX_INFOW* = ptr SYMSRV_INDEX_INFOW
  PSYM_ENUMSOURCEFILES_CALLBACK* = proc (pSourceFile: PSOURCEFILE, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYM_ENUMSOURCFILES_CALLBACK* = PSYM_ENUMSOURCEFILES_CALLBACK
  SRCCODEINFO* {.pure.} = object
    SizeOfStruct*: DWORD
    Key*: PVOID
    ModBase*: DWORD64
    Obj*: array[MAX_PATH+1, CHAR]
    FileName*: array[MAX_PATH+1, CHAR]
    LineNumber*: DWORD
    Address*: DWORD64
  PSRCCODEINFO* = ptr SRCCODEINFO
  SRCCODEINFOW* {.pure.} = object
    SizeOfStruct*: DWORD
    Key*: PVOID
    ModBase*: DWORD64
    Obj*: array[MAX_PATH+1, WCHAR]
    FileName*: array[MAX_PATH+1, WCHAR]
    LineNumber*: DWORD
    Address*: DWORD64
  PSRCCODEINFOW* = ptr SRCCODEINFOW
  IMAGEHLP_SYMBOL_SRC* {.pure.} = object
    sizeofstruct*: DWORD
    `type`*: DWORD
    file*: array[MAX_PATH, char]
  PIMAGEHLP_SYMBOL_SRC* = ptr IMAGEHLP_SYMBOL_SRC
  MODULE_TYPE_INFO* {.pure.} = object
    dataLength*: USHORT
    leaf*: USHORT
    data*: array[1, BYTE]
  PMODULE_TYPE_INFO* = ptr MODULE_TYPE_INFO
  SYMBOL_INFO* {.pure.} = object
    SizeOfStruct*: ULONG
    TypeIndex*: ULONG
    Reserved*: array[2, ULONG64]
    info*: ULONG
    Size*: ULONG
    ModBase*: ULONG64
    Flags*: ULONG
    Value*: ULONG64
    Address*: ULONG64
    Register*: ULONG
    Scope*: ULONG
    Tag*: ULONG
    NameLen*: ULONG
    MaxNameLen*: ULONG
    Name*: array[1, CHAR]
  PSYMBOL_INFO* = ptr SYMBOL_INFO
  SYMBOL_INFOW* {.pure.} = object
    SizeOfStruct*: ULONG
    TypeIndex*: ULONG
    Reserved*: array[2, ULONG64]
    info*: ULONG
    Size*: ULONG
    ModBase*: ULONG64
    Flags*: ULONG
    Value*: ULONG64
    Address*: ULONG64
    Register*: ULONG
    Scope*: ULONG
    Tag*: ULONG
    NameLen*: ULONG
    MaxNameLen*: ULONG
    Name*: array[1, WCHAR]
  PSYMBOL_INFOW* = ptr SYMBOL_INFOW
  SYMBOL_INFO_PACKAGE* {.pure.} = object
    si*: SYMBOL_INFO
    name*: array[MAX_SYM_NAME+1, CHAR]
  PSYMBOL_INFO_PACKAGE* = ptr SYMBOL_INFO_PACKAGE
  IMAGEHLP_STACK_FRAME* {.pure.} = object
    InstructionOffset*: ULONG64
    ReturnOffset*: ULONG64
    FrameOffset*: ULONG64
    StackOffset*: ULONG64
    BackingStoreOffset*: ULONG64
    FuncTableEntry*: ULONG64
    Params*: array[4, ULONG64]
    Reserved*: array[5, ULONG64]
    Virtual*: WINBOOL
    Reserved2*: ULONG
  PIMAGEHLP_STACK_FRAME* = ptr IMAGEHLP_STACK_FRAME
  IMAGEHLP_CONTEXT* = VOID
  RVA64* = ULONG64
  MINIDUMP_LOCATION_DESCRIPTOR* {.pure.} = object
    DataSize*: ULONG32
    Rva*: RVA
  MINIDUMP_MEMORY_DESCRIPTOR* {.pure.} = object
    StartOfMemoryRange*: ULONG64
    Memory*: MINIDUMP_LOCATION_DESCRIPTOR
  PMINIDUMP_MEMORY_DESCRIPTOR* = ptr MINIDUMP_MEMORY_DESCRIPTOR
  MINIDUMP_MEMORY_DESCRIPTOR64* {.pure.} = object
    StartOfMemoryRange*: ULONG64
    DataSize*: ULONG64
  PMINIDUMP_MEMORY_DESCRIPTOR64* = ptr MINIDUMP_MEMORY_DESCRIPTOR64
  MINIDUMP_HEADER_UNION1* {.pure, union.} = object
    Reserved*: ULONG32
    TimeDateStamp*: ULONG32
  MINIDUMP_HEADER* {.pure.} = object
    Signature*: ULONG32
    Version*: ULONG32
    NumberOfStreams*: ULONG32
    StreamDirectoryRva*: RVA
    CheckSum*: ULONG32
    union1*: MINIDUMP_HEADER_UNION1
    Flags*: ULONG64
  PMINIDUMP_HEADER* = ptr MINIDUMP_HEADER
  MINIDUMP_DIRECTORY* {.pure.} = object
    StreamType*: ULONG32
    Location*: MINIDUMP_LOCATION_DESCRIPTOR
  PMINIDUMP_DIRECTORY* = ptr MINIDUMP_DIRECTORY
  MINIDUMP_STRING* {.pure.} = object
    Length*: ULONG32
    Buffer*: UncheckedArray[WCHAR]
  PMINIDUMP_STRING* = ptr MINIDUMP_STRING
  CPU_INFORMATION_X86CpuInfo* {.pure.} = object
    VendorId*: array[3, ULONG32]
    VersionInformation*: ULONG32
    FeatureInformation*: ULONG32
    AMDExtendedCpuFeatures*: ULONG32
  CPU_INFORMATION_OtherCpuInfo* {.pure.} = object
    ProcessorFeatures*: array[2, ULONG64]
  CPU_INFORMATION* {.pure, union.} = object
    X86CpuInfo*: CPU_INFORMATION_X86CpuInfo
    OtherCpuInfo*: CPU_INFORMATION_OtherCpuInfo
  PCPU_INFORMATION* = ptr CPU_INFORMATION
  MINIDUMP_SYSTEM_INFO_UNION1_STRUCT1* {.pure.} = object
    NumberOfProcessors*: UCHAR
    ProductType*: UCHAR
  MINIDUMP_SYSTEM_INFO_UNION1* {.pure, union.} = object
    Reserved0*: USHORT
    struct1*: MINIDUMP_SYSTEM_INFO_UNION1_STRUCT1
  MINIDUMP_SYSTEM_INFO_UNION2_STRUCT1* {.pure.} = object
    SuiteMask*: USHORT
    Reserved2*: USHORT
  MINIDUMP_SYSTEM_INFO_UNION2* {.pure, union.} = object
    Reserved1*: ULONG32
    struct1*: MINIDUMP_SYSTEM_INFO_UNION2_STRUCT1
  MINIDUMP_SYSTEM_INFO* {.pure.} = object
    ProcessorArchitecture*: USHORT
    ProcessorLevel*: USHORT
    ProcessorRevision*: USHORT
    union1*: MINIDUMP_SYSTEM_INFO_UNION1
    MajorVersion*: ULONG32
    MinorVersion*: ULONG32
    BuildNumber*: ULONG32
    PlatformId*: ULONG32
    CSDVersionRva*: RVA
    union2*: MINIDUMP_SYSTEM_INFO_UNION2
    Cpu*: CPU_INFORMATION
  PMINIDUMP_SYSTEM_INFO* = ptr MINIDUMP_SYSTEM_INFO
  MINIDUMP_THREAD* {.pure.} = object
    ThreadId*: ULONG32
    SuspendCount*: ULONG32
    PriorityClass*: ULONG32
    Priority*: ULONG32
    Teb*: ULONG64
    Stack*: MINIDUMP_MEMORY_DESCRIPTOR
    ThreadContext*: MINIDUMP_LOCATION_DESCRIPTOR
  PMINIDUMP_THREAD* = ptr MINIDUMP_THREAD
  MINIDUMP_THREAD_LIST* {.pure, packed.} = object
    NumberOfThreads*: ULONG32
    Threads*: UncheckedArray[MINIDUMP_THREAD]
  PMINIDUMP_THREAD_LIST* = ptr MINIDUMP_THREAD_LIST
  MINIDUMP_THREAD_EX* {.pure.} = object
    ThreadId*: ULONG32
    SuspendCount*: ULONG32
    PriorityClass*: ULONG32
    Priority*: ULONG32
    Teb*: ULONG64
    Stack*: MINIDUMP_MEMORY_DESCRIPTOR
    ThreadContext*: MINIDUMP_LOCATION_DESCRIPTOR
    BackingStore*: MINIDUMP_MEMORY_DESCRIPTOR
  PMINIDUMP_THREAD_EX* = ptr MINIDUMP_THREAD_EX
  MINIDUMP_THREAD_EX_LIST* {.pure, packed.} = object
    NumberOfThreads*: ULONG32
    Threads*: UncheckedArray[MINIDUMP_THREAD_EX]
  PMINIDUMP_THREAD_EX_LIST* = ptr MINIDUMP_THREAD_EX_LIST
  MINIDUMP_EXCEPTION* {.pure.} = object
    ExceptionCode*: ULONG32
    ExceptionFlags*: ULONG32
    ExceptionRecord*: ULONG64
    ExceptionAddress*: ULONG64
    NumberParameters*: ULONG32
    unusedAlignment*: ULONG32
    ExceptionInformation*: array[EXCEPTION_MAXIMUM_PARAMETERS, ULONG64]
  PMINIDUMP_EXCEPTION* = ptr MINIDUMP_EXCEPTION
  MINIDUMP_EXCEPTION_STREAM* {.pure.} = object
    ThreadId*: ULONG32
    alignment*: ULONG32
    ExceptionRecord*: MINIDUMP_EXCEPTION
    ThreadContext*: MINIDUMP_LOCATION_DESCRIPTOR
  PMINIDUMP_EXCEPTION_STREAM* = ptr MINIDUMP_EXCEPTION_STREAM
  MINIDUMP_MODULE* {.pure, packed.} = object
    BaseOfImage*: ULONG64
    SizeOfImage*: ULONG32
    CheckSum*: ULONG32
    TimeDateStamp*: ULONG32
    ModuleNameRva*: RVA
    VersionInfo*: VS_FIXEDFILEINFO
    CvRecord*: MINIDUMP_LOCATION_DESCRIPTOR
    MiscRecord*: MINIDUMP_LOCATION_DESCRIPTOR
    Reserved0*: ULONG64
    Reserved1*: ULONG64
  PMINIDUMP_MODULE* = ptr MINIDUMP_MODULE
  MINIDUMP_MODULE_LIST* {.pure, packed.} = object
    NumberOfModules*: ULONG32
    Modules*: UncheckedArray[MINIDUMP_MODULE]
  PMINIDUMP_MODULE_LIST* = ptr MINIDUMP_MODULE_LIST
  MINIDUMP_MEMORY_LIST* {.pure, packed.} = object
    NumberOfMemoryRanges*: ULONG32
    MemoryRanges*: UncheckedArray[MINIDUMP_MEMORY_DESCRIPTOR]
  PMINIDUMP_MEMORY_LIST* = ptr MINIDUMP_MEMORY_LIST
  MINIDUMP_MEMORY64_LIST* {.pure.} = object
    NumberOfMemoryRanges*: ULONG64
    BaseRva*: RVA64
    MemoryRanges*: UncheckedArray[MINIDUMP_MEMORY_DESCRIPTOR64]
  PMINIDUMP_MEMORY64_LIST* = ptr MINIDUMP_MEMORY64_LIST
  MINIDUMP_EXCEPTION_INFORMATION* {.pure, packed.} = object
    ThreadId*: DWORD
    ExceptionPointers*: PEXCEPTION_POINTERS
    ClientPointers*: WINBOOL
  PMINIDUMP_EXCEPTION_INFORMATION* = ptr MINIDUMP_EXCEPTION_INFORMATION
  MINIDUMP_EXCEPTION_INFORMATION64* {.pure, packed.} = object
    ThreadId*: DWORD
    ExceptionRecord*: ULONG64
    ContextRecord*: ULONG64
    ClientPointers*: WINBOOL
  PMINIDUMP_EXCEPTION_INFORMATION64* = ptr MINIDUMP_EXCEPTION_INFORMATION64
  MINIDUMP_HANDLE_DESCRIPTOR* {.pure.} = object
    Handle*: ULONG64
    TypeNameRva*: RVA
    ObjectNameRva*: RVA
    Attributes*: ULONG32
    GrantedAccess*: ULONG32
    HandleCount*: ULONG32
    PointerCount*: ULONG32
  PMINIDUMP_HANDLE_DESCRIPTOR* = ptr MINIDUMP_HANDLE_DESCRIPTOR
  MINIDUMP_HANDLE_DATA_STREAM* {.pure.} = object
    SizeOfHeader*: ULONG32
    SizeOfDescriptor*: ULONG32
    NumberOfDescriptors*: ULONG32
    Reserved*: ULONG32
  PMINIDUMP_HANDLE_DATA_STREAM* = ptr MINIDUMP_HANDLE_DATA_STREAM
  MINIDUMP_FUNCTION_TABLE_DESCRIPTOR* {.pure.} = object
    MinimumAddress*: ULONG64
    MaximumAddress*: ULONG64
    BaseAddress*: ULONG64
    EntryCount*: ULONG32
    SizeOfAlignPad*: ULONG32
  PMINIDUMP_FUNCTION_TABLE_DESCRIPTOR* = ptr MINIDUMP_FUNCTION_TABLE_DESCRIPTOR
  MINIDUMP_FUNCTION_TABLE_STREAM* {.pure.} = object
    SizeOfHeader*: ULONG32
    SizeOfDescriptor*: ULONG32
    SizeOfNativeDescriptor*: ULONG32
    SizeOfFunctionEntry*: ULONG32
    NumberOfDescriptors*: ULONG32
    SizeOfAlignPad*: ULONG32
  PMINIDUMP_FUNCTION_TABLE_STREAM* = ptr MINIDUMP_FUNCTION_TABLE_STREAM
  MINIDUMP_UNLOADED_MODULE* {.pure.} = object
    BaseOfImage*: ULONG64
    SizeOfImage*: ULONG32
    CheckSum*: ULONG32
    TimeDateStamp*: ULONG32
    ModuleNameRva*: RVA
  PMINIDUMP_UNLOADED_MODULE* = ptr MINIDUMP_UNLOADED_MODULE
  MINIDUMP_UNLOADED_MODULE_LIST* {.pure.} = object
    SizeOfHeader*: ULONG32
    SizeOfEntry*: ULONG32
    NumberOfEntries*: ULONG32
  PMINIDUMP_UNLOADED_MODULE_LIST* = ptr MINIDUMP_UNLOADED_MODULE_LIST
  MINIDUMP_MISC_INFO* {.pure.} = object
    SizeOfInfo*: ULONG32
    Flags1*: ULONG32
    ProcessId*: ULONG32
    ProcessCreateTime*: ULONG32
    ProcessUserTime*: ULONG32
    ProcessKernelTime*: ULONG32
  PMINIDUMP_MISC_INFO* = ptr MINIDUMP_MISC_INFO
  MINIDUMP_USER_RECORD* {.pure.} = object
    Type*: ULONG32
    Memory*: MINIDUMP_LOCATION_DESCRIPTOR
  PMINIDUMP_USER_RECORD* = ptr MINIDUMP_USER_RECORD
  MINIDUMP_USER_STREAM* {.pure.} = object
    Type*: ULONG32
    BufferSize*: ULONG
    Buffer*: PVOID
  PMINIDUMP_USER_STREAM* = ptr MINIDUMP_USER_STREAM
  MINIDUMP_USER_STREAM_INFORMATION* {.pure, packed.} = object
    UserStreamCount*: ULONG
    UserStreamArray*: PMINIDUMP_USER_STREAM
  PMINIDUMP_USER_STREAM_INFORMATION* = ptr MINIDUMP_USER_STREAM_INFORMATION
  MINIDUMP_THREAD_CALLBACK* {.pure, packed.} = object
    ThreadId*: ULONG
    ThreadHandle*: HANDLE
    Context*: CONTEXT
    SizeOfContext*: ULONG
    StackBase*: ULONG64
    StackEnd*: ULONG64
  PMINIDUMP_THREAD_CALLBACK* = ptr MINIDUMP_THREAD_CALLBACK
  MINIDUMP_THREAD_EX_CALLBACK* {.pure, packed.} = object
    ThreadId*: ULONG
    ThreadHandle*: HANDLE
    Context*: CONTEXT
    SizeOfContext*: ULONG
    StackBase*: ULONG64
    StackEnd*: ULONG64
    BackingStoreBase*: ULONG64
    BackingStoreEnd*: ULONG64
  PMINIDUMP_THREAD_EX_CALLBACK* = ptr MINIDUMP_THREAD_EX_CALLBACK
  MINIDUMP_INCLUDE_THREAD_CALLBACK* {.pure.} = object
    ThreadId*: ULONG
  PMINIDUMP_INCLUDE_THREAD_CALLBACK* = ptr MINIDUMP_INCLUDE_THREAD_CALLBACK
  MINIDUMP_MODULE_CALLBACK* {.pure, packed.} = object
    FullPath*: PWCHAR
    BaseOfImage*: ULONG64
    SizeOfImage*: ULONG
    CheckSum*: ULONG
    TimeDateStamp*: ULONG
    VersionInfo*: VS_FIXEDFILEINFO
    CvRecord*: PVOID
    SizeOfCvRecord*: ULONG
    MiscRecord*: PVOID
    SizeOfMiscRecord*: ULONG
  PMINIDUMP_MODULE_CALLBACK* = ptr MINIDUMP_MODULE_CALLBACK
  MINIDUMP_INCLUDE_MODULE_CALLBACK* {.pure.} = object
    BaseOfImage*: ULONG64
  PMINIDUMP_INCLUDE_MODULE_CALLBACK* = ptr MINIDUMP_INCLUDE_MODULE_CALLBACK
  MINIDUMP_CALLBACK_INPUT_UNION1* {.pure, union.} = object
    Thread*: MINIDUMP_THREAD_CALLBACK
    ThreadEx*: MINIDUMP_THREAD_EX_CALLBACK
    Module*: MINIDUMP_MODULE_CALLBACK
    IncludeThread*: MINIDUMP_INCLUDE_THREAD_CALLBACK
    IncludeModule*: MINIDUMP_INCLUDE_MODULE_CALLBACK
  MINIDUMP_CALLBACK_INPUT* {.pure, packed.} = object
    ProcessId*: ULONG
    ProcessHandle*: HANDLE
    CallbackType*: ULONG
    union1*: MINIDUMP_CALLBACK_INPUT_UNION1
  PMINIDUMP_CALLBACK_INPUT* = ptr MINIDUMP_CALLBACK_INPUT
  MINIDUMP_MEMORY_INFO* {.pure.} = object
    BaseAddress*: ULONG64
    AllocationBase*: ULONG64
    AllocationProtect*: ULONG32
    alignment1*: ULONG32
    RegionSize*: ULONG64
    State*: ULONG32
    Protect*: ULONG32
    Type*: ULONG32
    alignment2*: ULONG32
  PMINIDUMP_MEMORY_INFO* = ptr MINIDUMP_MEMORY_INFO
  MINIDUMP_MISC_INFO_2* {.pure.} = object
    SizeOfInfo*: ULONG32
    Flags1*: ULONG32
    ProcessId*: ULONG32
    ProcessCreateTime*: ULONG32
    ProcessUserTime*: ULONG32
    ProcessKernelTime*: ULONG32
    ProcessorMaxMhz*: ULONG32
    ProcessorCurrentMhz*: ULONG32
    ProcessorMhzLimit*: ULONG32
    ProcessorMaxIdleState*: ULONG32
    ProcessorCurrentIdleState*: ULONG32
  PMINIDUMP_MISC_INFO_2* = ptr MINIDUMP_MISC_INFO_2
  MINIDUMP_MEMORY_INFO_LIST* {.pure.} = object
    SizeOfHeader*: ULONG
    SizeOfEntry*: ULONG
    NumberOfEntries*: ULONG64
  PMINIDUMP_MEMORY_INFO_LIST* = ptr MINIDUMP_MEMORY_INFO_LIST
  MINIDUMP_CALLBACK_OUTPUT_UNION1_STRUCT1* {.pure, packed.} = object
    MemoryBase*: ULONG64
    MemorySize*: ULONG
  MINIDUMP_CALLBACK_OUTPUT_UNION1_STRUCT2* {.pure, packed.} = object
    CheckCancel*: WINBOOL
    Cancel*: WINBOOL
  MINIDUMP_CALLBACK_OUTPUT_UNION1* {.pure, union.} = object
    ModuleWriteFlags*: ULONG
    ThreadWriteFlags*: ULONG
    SecondaryFlags*: ULONG
    struct1*: MINIDUMP_CALLBACK_OUTPUT_UNION1_STRUCT1
    struct2*: MINIDUMP_CALLBACK_OUTPUT_UNION1_STRUCT2
    Handle*: HANDLE
  MINIDUMP_CALLBACK_OUTPUT_STRUCT1* {.pure, packed.} = object
    VmRegion*: MINIDUMP_MEMORY_INFO
    Continue*: WINBOOL
  MINIDUMP_CALLBACK_OUTPUT* {.pure, packed.} = object
    union1*: MINIDUMP_CALLBACK_OUTPUT_UNION1
    struct1*: MINIDUMP_CALLBACK_OUTPUT_STRUCT1
    Status*: HRESULT
  PMINIDUMP_CALLBACK_OUTPUT* = ptr MINIDUMP_CALLBACK_OUTPUT
  MINIDUMP_THREAD_INFO* {.pure.} = object
    ThreadId*: ULONG32
    DumpFlags*: ULONG32
    DumpError*: ULONG32
    ExitStatus*: ULONG32
    CreateTime*: ULONG64
    ExitTime*: ULONG64
    KernelTime*: ULONG64
    UserTime*: ULONG64
    StartAddress*: ULONG64
    Affinity*: ULONG64
  PMINIDUMP_THREAD_INFO* = ptr MINIDUMP_THREAD_INFO
  MINIDUMP_THREAD_INFO_LIST* {.pure.} = object
    SizeOfHeader*: ULONG
    SizeOfEntry*: ULONG
    NumberOfEntries*: ULONG
  PMINIDUMP_THREAD_INFO_LIST* = ptr MINIDUMP_THREAD_INFO_LIST
  MINIDUMP_HANDLE_OPERATION_LIST* {.pure.} = object
    SizeOfHeader*: ULONG32
    SizeOfEntry*: ULONG32
    NumberOfEntries*: ULONG32
    Reserved*: ULONG32
  PMINIDUMP_HANDLE_OPERATION_LIST* = ptr MINIDUMP_HANDLE_OPERATION_LIST
  MINIDUMP_CALLBACK_ROUTINE* = proc (CallbackParam: PVOID, CallbackInput: PMINIDUMP_CALLBACK_INPUT, CallbackOutput: PMINIDUMP_CALLBACK_OUTPUT): WINBOOL {.stdcall.}
  MINIDUMP_CALLBACK_INFORMATION* {.pure.} = object
    CallbackRoutine*: MINIDUMP_CALLBACK_ROUTINE
    CallbackParam*: PVOID
  PMINIDUMP_CALLBACK_INFORMATION* = ptr MINIDUMP_CALLBACK_INFORMATION
const
  IMAGE_SEPARATION* = 64*1024
  bindOutOfMemory* = 0
  bindRvaToVaFailed* = 1
  bindNoRoomInImage* = 2
  bindImportModuleFailed* = 3
  bindImportProcedureFailed* = 4
  bindImportModule* = 5
  bindImportProcedure* = 6
  bindForwarder* = 7
  bindForwarderNOT* = 8
  bindImageModified* = 9
  bindExpandFileHeaders* = 10
  bindImageComplete* = 11
  bindMismatchedSymbols* = 12
  bindSymbolsNotUpdated* = 13
  bindImportProcedure32* = 14
  bindImportProcedure64* = 15
  bindForwarder32* = 16
  bindForwarder64* = 17
  bindForwarderNOT32* = 18
  bindForwarderNOT64* = 19
  BIND_NO_BOUND_IMPORTS* = 0x00000001
  BIND_NO_UPDATE* = 0x00000002
  BIND_ALL_IMAGES* = 0x00000004
  BIND_CACHE_IMPORT_DLLS* = 0x00000008
  BIND_REPORT_64BIT_VA* = 0x00000010
  CHECKSUM_SUCCESS* = 0
  CHECKSUM_OPEN_FAILURE* = 1
  CHECKSUM_MAP_FAILURE* = 2
  CHECKSUM_MAPVIEW_FAILURE* = 3
  CHECKSUM_UNICODE_FAILURE* = 4
  SPLITSYM_REMOVE_PRIVATE* = 0x00000001
  SPLITSYM_EXTRACT_ALL* = 0x00000002
  SPLITSYM_SYMBOLPATH_IS_SRC* = 0x00000004
  CERT_PE_IMAGE_DIGEST_DEBUG_INFO* = 0x01
  CERT_PE_IMAGE_DIGEST_RESOURCES* = 0x02
  CERT_PE_IMAGE_DIGEST_ALL_IMPORT_INFO* = 0x04
  CERT_PE_IMAGE_DIGEST_NON_PE_INFO* = 0x08
  CERT_SECTION_TYPE_ANY* = 0xFF
  SSRVOPT_CALLBACK* = 0x0001
  SSRVOPT_DWORD* = 0x0002
  SSRVOPT_DWORDPTR* = 0x0004
  SSRVOPT_GUIDPTR* = 0x0008
  SSRVOPT_OLDGUIDPTR* = 0x0010
  SSRVOPT_UNATTENDED* = 0x0020
  SSRVOPT_NOCOPY* = 0x0040
  SSRVOPT_PARENTWIN* = 0x0080
  SSRVOPT_PARAMTYPE* = 0x0100
  SSRVOPT_SECURE* = 0x0200
  SSRVOPT_TRACE* = 0x0400
  SSRVOPT_SETCONTEXT* = 0x0800
  SSRVOPT_PROXY* = 0x1000
  SSRVOPT_DOWNSTREAM_STORE* = 0x2000
  SSRVACTION_TRACE* = 1
  SSRVACTION_QUERYCANCEL* = 2
  SSRVACTION_EVENT* = 3
  UNDNAME_COMPLETE* = 0x0000
  UNDNAME_NO_LEADING_UNDERSCORES* = 0x0001
  UNDNAME_NO_MS_KEYWORDS* = 0x0002
  UNDNAME_NO_FUNCTION_RETURNS* = 0x0004
  UNDNAME_NO_ALLOCATION_MODEL* = 0x0008
  UNDNAME_NO_ALLOCATION_LANGUAGE* = 0x0010
  UNDNAME_NO_MS_THISTYPE* = 0x0020
  UNDNAME_NO_CV_THISTYPE* = 0x0040
  UNDNAME_NO_THISTYPE* = 0x0060
  UNDNAME_NO_ACCESS_SPECIFIERS* = 0x0080
  UNDNAME_NO_THROW_SIGNATURES* = 0x0100
  UNDNAME_NO_MEMBER_TYPE* = 0x0200
  UNDNAME_NO_RETURN_UDT_MODEL* = 0x0400
  UNDNAME_32_BIT_DECODE* = 0x0800
  UNDNAME_NAME_ONLY* = 0x1000
  UNDNAME_NO_ARGUMENTS* = 0x2000
  UNDNAME_NO_SPECIAL_SYMS* = 0x4000
  DBHHEADER_DEBUGDIRS* = 0x1
  DBHHEADER_CVMISC* = 0x2
  addrMode1616* = 0
  addrMode1632* = 1
  addrModeReal* = 2
  addrModeFlat* = 3
  API_VERSION_NUMBER* = 11
  SYMFLAG_VALUEPRESENT* = 0x00000001
  SYMFLAG_REGISTER* = 0x00000008
  SYMFLAG_REGREL* = 0x00000010
  SYMFLAG_FRAMEREL* = 0x00000020
  SYMFLAG_PARAMETER* = 0x00000040
  SYMFLAG_LOCAL* = 0x00000080
  SYMFLAG_CONSTANT* = 0x00000100
  SYMFLAG_EXPORT* = 0x00000200
  SYMFLAG_FORWARDER* = 0x00000400
  SYMFLAG_FUNCTION* = 0x00000800
  SYMFLAG_VIRTUAL* = 0x00001000
  SYMFLAG_THUNK* = 0x00002000
  SYMFLAG_TLSREL* = 0x00004000
  symNone* = 0
  symCoff* = 1
  symCv* = 2
  symPdb* = 3
  symExport* = 4
  symDeferred* = 5
  symSym* = 6
  symDia* = 7
  symVirtual* = 8
  numSymTypes* = 9
  CBA_DEFERRED_SYMBOL_LOAD_START* = 0x00000001
  CBA_DEFERRED_SYMBOL_LOAD_COMPLETE* = 0x00000002
  CBA_DEFERRED_SYMBOL_LOAD_FAILURE* = 0x00000003
  CBA_SYMBOLS_UNLOADED* = 0x00000004
  CBA_DUPLICATE_SYMBOL* = 0x00000005
  CBA_READ_MEMORY* = 0x00000006
  CBA_DEFERRED_SYMBOL_LOAD_CANCEL* = 0x00000007
  CBA_SET_OPTIONS* = 0x00000008
  CBA_EVENT* = 0x00000010
  CBA_DEFERRED_SYMBOL_LOAD_PARTIAL* = 0x00000020
  CBA_DEBUG_INFO* = 0x10000000
  CBA_SRCSRV_INFO* = 0x20000000
  CBA_SRCSRV_EVENT* = 0x40000000
  sevInfo* = 0
  sevProblem* = 1
  sevAttn* = 2
  sevFatal* = 3
  sevMax* = 4
  DSLFLAG_MISMATCHED_PDB* = 0x1
  DSLFLAG_MISMATCHED_DBG* = 0x2
  hdBase* = 0
  hdSym* = 1
  hdSrc* = 2
  hdMax* = 3
  SYMOPT_CASE_INSENSITIVE* = 0x00000001
  SYMOPT_UNDNAME* = 0x00000002
  SYMOPT_DEFERRED_LOADS* = 0x00000004
  SYMOPT_NO_CPP* = 0x00000008
  SYMOPT_LOAD_LINES* = 0x00000010
  SYMOPT_OMAP_FIND_NEAREST* = 0x00000020
  SYMOPT_LOAD_ANYTHING* = 0x00000040
  SYMOPT_IGNORE_CVREC* = 0x00000080
  SYMOPT_NO_UNQUALIFIED_LOADS* = 0x00000100
  SYMOPT_FAIL_CRITICAL_ERRORS* = 0x00000200
  SYMOPT_EXACT_SYMBOLS* = 0x00000400
  SYMOPT_ALLOW_ABSOLUTE_SYMBOLS* = 0x00000800
  SYMOPT_IGNORE_NT_SYMPATH* = 0x00001000
  SYMOPT_INCLUDE_32BIT_MODULES* = 0x00002000
  SYMOPT_PUBLICS_ONLY* = 0x00004000
  SYMOPT_NO_PUBLICS* = 0x00008000
  SYMOPT_AUTO_PUBLICS* = 0x00010000
  SYMOPT_NO_IMAGE_SEARCH* = 0x00020000
  SYMOPT_SECURE* = 0x00040000
  SYMOPT_NO_PROMPTS* = 0x00080000
  SYMOPT_ALLOW_ZERO_ADDRESS* = 0x01000000
  SYMOPT_DISABLE_SYMSRV_AUTODETECT* = 0x02000000
  SYMOPT_FAVOR_COMPRESSED* = 0x00800000
  SYMOPT_FLAT_DIRECTORY* = 0x00400000
  SYMOPT_IGNORE_IMAGEDIR* = 0x00200000
  SYMOPT_OVERWRITE* = 0x00100000
  SYMOPT_DEBUG* = 0x80000000'i32
  SLMFLAG_VIRTUAL* = 0x1
  SYMFLAG_CLR_TOKEN* = 0x00040000
  SYMFLAG_ILREL* = 0x00010000
  SYMFLAG_METADATA* = 0x00020000
  SYMFLAG_SLOT* = 0x00008000
  SYMENUMFLAG_FULLSRCH* = 1
  SYMENUMFLAG_SPEEDSRCH* = 2
  TI_GET_SYMTAG* = 0
  TI_GET_SYMNAME* = 1
  TI_GET_LENGTH* = 2
  TI_GET_TYPE* = 3
  TI_GET_TYPEID* = 4
  TI_GET_BASETYPE* = 5
  TI_GET_ARRAYINDEXTYPEID* = 6
  TI_FINDCHILDREN* = 7
  TI_GET_DATAKIND* = 8
  TI_GET_ADDRESSOFFSET* = 9
  TI_GET_OFFSET* = 10
  TI_GET_VALUE* = 11
  TI_GET_COUNT* = 12
  TI_GET_CHILDRENCOUNT* = 13
  TI_GET_BITPOSITION* = 14
  TI_GET_VIRTUALBASECLASS* = 15
  TI_GET_VIRTUALTABLESHAPEID* = 16
  TI_GET_VIRTUALBASEPOINTEROFFSET* = 17
  TI_GET_CLASSPARENTID* = 18
  TI_GET_NESTED* = 19
  TI_GET_SYMINDEX* = 20
  TI_GET_LEXICALPARENT* = 21
  TI_GET_ADDRESS* = 22
  TI_GET_THISADJUST* = 23
  TI_GET_UDTKIND* = 24
  TI_IS_EQUIV_TO* = 25
  TI_GET_CALLING_CONVENTION* = 26
  SYMF_OMAP_GENERATED* = 0x00000001
  SYMF_OMAP_MODIFIED* = 0x00000002
  SYMF_REGISTER* = 0x00000008
  SYMF_REGREL* = 0x00000010
  SYMF_FRAMEREL* = 0x00000020
  SYMF_PARAMETER* = 0x00000040
  SYMF_LOCAL* = 0x00000080
  SYMF_CONSTANT* = 0x00000100
  SYMF_EXPORT* = 0x00000200
  SYMF_FORWARDER* = 0x00000400
  SYMF_FUNCTION* = 0x00000800
  SYMF_VIRTUAL* = 0x00001000
  SYMF_THUNK* = 0x00002000
  SYMF_TLSREL* = 0x00004000
  IMAGEHLP_SYMBOL_INFO_VALUEPRESENT* = 1
  IMAGEHLP_SYMBOL_INFO_REGISTER* = SYMF_REGISTER
  IMAGEHLP_SYMBOL_INFO_REGRELATIVE* = SYMF_REGREL
  IMAGEHLP_SYMBOL_INFO_FRAMERELATIVE* = SYMF_FRAMEREL
  IMAGEHLP_SYMBOL_INFO_PARAMETER* = SYMF_PARAMETER
  IMAGEHLP_SYMBOL_INFO_LOCAL* = SYMF_LOCAL
  IMAGEHLP_SYMBOL_INFO_CONSTANT* = SYMF_CONSTANT
  IMAGEHLP_SYMBOL_FUNCTION* = SYMF_FUNCTION
  IMAGEHLP_SYMBOL_VIRTUAL* = SYMF_VIRTUAL
  IMAGEHLP_SYMBOL_THUNK* = SYMF_THUNK
  IMAGEHLP_SYMBOL_INFO_TLSRELATIVE* = SYMF_TLSREL
  MINIDUMP_SIGNATURE* = 0x504D444D
  MINIDUMP_VERSION* = 42899
  unusedStream* = 0
  reservedStream0* = 1
  reservedStream1* = 2
  threadListStream* = 3
  moduleListStream* = 4
  memoryListStream* = 5
  exceptionStream* = 6
  systemInfoStream* = 7
  threadExListStream* = 8
  memory64ListStream* = 9
  commentStreamA* = 10
  commentStreamW* = 11
  handleDataStream* = 12
  functionTableStream* = 13
  unloadedModuleListStream* = 14
  miscInfoStream* = 15
  memoryInfoListStream* = 16
  threadInfoListStream* = 17
  handleOperationListStream* = 18
  tokenStream* = 19
  ceStreamNull* = 0x8000
  ceStreamSystemInfo* = 0x8001
  ceStreamException* = 0x8002
  ceStreamModuleList* = 0x8003
  ceStreamProcessList* = 0x8004
  ceStreamThreadList* = 0x8005
  ceStreamThreadContextList* = 0x8006
  ceStreamThreadCallStackList* = 0x8007
  ceStreamMemoryVirtualList* = 0x8008
  ceStreamMemoryPhysicalList* = 0x8009
  ceStreamBucketParameters* = 0x800a
  ceStreamProcessModuleMap* = 0x800b
  ceStreamDiagnosisList* = 0x800c
  lastReservedStream* = 0xffff
  MINIDUMP_MISC1_PROCESS_ID* = 0x00000001
  MINIDUMP_MISC1_PROCESS_TIMES* = 0x00000002
  MINIDUMP_MISC1_PROCESSOR_POWER_INFO* = 0x00000004
  moduleCallback* = 0
  threadCallback* = 1
  threadExCallback* = 2
  includeThreadCallback* = 3
  includeModuleCallback* = 4
  memoryCallback* = 5
  cancelCallback* = 6
  writeKernelMinidumpCallback* = 7
  kernelMinidumpStatusCallback* = 8
  removeMemoryCallback* = 9
  includeVmRegionCallback* = 10
  ioStartCallback* = 11
  ioWriteAllCallback* = 12
  ioFinishCallback* = 13
  readMemoryFailureCallback* = 14
  secondaryFlagsCallback* = 15
  threadWriteThread* = 0x0001
  threadWriteStack* = 0x0002
  threadWriteContext* = 0x0004
  threadWriteBackingStore* = 0x0008
  threadWriteInstructionWindow* = 0x0010
  threadWriteThreadData* = 0x0020
  threadWriteThreadInfo* = 0x0040
  moduleWriteModule* = 0x0001
  moduleWriteDataSeg* = 0x0002
  moduleWriteMiscRecord* = 0x0004
  moduleWriteCvRecord* = 0x0008
  moduleReferencedByMemory* = 0x0010
  moduleWriteTlsData* = 0x0020
  moduleWriteCodeSegs* = 0x0040
  miniSecondaryWithoutPowerInfo* = 0x00000001
  miniDumpNormal* = 0x00000000
  miniDumpWithDataSegs* = 0x00000001
  miniDumpWithFullMemory* = 0x00000002
  miniDumpWithHandleData* = 0x00000004
  miniDumpFilterMemory* = 0x00000008
  miniDumpScanMemory* = 0x00000010
  miniDumpWithUnloadedModules* = 0x00000020
  miniDumpWithIndirectlyReferencedMemory* = 0x00000040
  miniDumpFilterModulePaths* = 0x00000080
  miniDumpWithProcessThreadData* = 0x00000100
  miniDumpWithPrivateReadWriteMemory* = 0x00000200
  miniDumpWithoutOptionalData* = 0x00000400
  miniDumpWithFullMemoryInfo* = 0x00000800
  miniDumpWithThreadInfo* = 0x00001000
  miniDumpWithCodeSegs* = 0x00002000
  miniDumpWithoutAuxiliaryState* = 0x00004000
  miniDumpWithFullAuxiliaryState* = 0x00008000
  miniDumpWithPrivateWriteCopyMemory* = 0x00010000
  miniDumpIgnoreInaccessibleMemory* = 0x00020000
  miniDumpWithTokenInformation* = 0x00040000
  MINIDUMP_THREAD_INFO_ERROR_THREAD* = 0x00000001
  MINIDUMP_THREAD_INFO_WRITING_THREAD* = 0x00000002
  MINIDUMP_THREAD_INFO_EXITED_THREAD* = 0x00000004
  MINIDUMP_THREAD_INFO_INVALID_INFO* = 0x00000008
  MINIDUMP_THREAD_INFO_INVALID_CONTEXT* = 0x00000010
  MINIDUMP_THREAD_INFO_INVALID_TEB* = 0x00000020
  SYMSEARCH_MASKOBJS* = 0x01
  SYMSEARCH_RECURSE* = 0x02
  SYMSEARCH_GLOBALSONLY* = 0x04
  SYMSEARCH_ALLITEMS* = 0x08
  SYMSTOREOPT_COMPRESS* = 0x01
  SYMSTOREOPT_OVERWRITE* = 0x02
  SYMSTOREOPT_RETURNINDEX* = 0x04
  SYMSTOREOPT_POINTER* = 0x08
  SYMSTOREOPT_PASS_IF_EXISTS* = 0x40
  SSRVOPT_RESET* = not ULONG_PTR(0)
type
  PIMAGEHLP_STATUS_ROUTINE* = proc (Reason: IMAGEHLP_STATUS_REASON, ImageName: PCSTR, DllName: PCSTR, Va: ULONG_PTR, Parameter: ULONG_PTR): WINBOOL {.stdcall.}
  PIMAGEHLP_STATUS_ROUTINE32* = proc (Reason: IMAGEHLP_STATUS_REASON, ImageName: PCSTR, DllName: PCSTR, Va: ULONG, Parameter: ULONG_PTR): WINBOOL {.stdcall.}
  PIMAGEHLP_STATUS_ROUTINE64* = proc (Reason: IMAGEHLP_STATUS_REASON, ImageName: PCSTR, DllName: PCSTR, Va: ULONG64, Parameter: ULONG_PTR): WINBOOL {.stdcall.}
  DIGEST_FUNCTION* = proc (refdata: DIGEST_HANDLE, pData: PBYTE, dwLength: DWORD): WINBOOL {.stdcall.}
  PFIND_DEBUG_FILE_CALLBACK* = proc (FileHandle: HANDLE, FileName: PCSTR, CallerData: PVOID): WINBOOL {.stdcall.}
  PFIND_DEBUG_FILE_CALLBACKW* = proc (FileHandle: HANDLE, FileName: PCWSTR, CallerData: PVOID): WINBOOL {.stdcall.}
  PFINDFILEINPATHCALLBACK* = proc (filename: PCSTR, context: PVOID): WINBOOL {.stdcall.}
  PFINDFILEINPATHCALLBACKW* = proc (filename: PCWSTR, context: PVOID): WINBOOL {.stdcall.}
  PFIND_EXE_FILE_CALLBACK* = proc (FileHandle: HANDLE, FileName: PCSTR, CallerData: PVOID): WINBOOL {.stdcall.}
  PFIND_EXE_FILE_CALLBACKW* = proc (FileHandle: HANDLE, FileName: PCWSTR, CallerData: PVOID): WINBOOL {.stdcall.}
  PSYMBOLSERVERPROC* = proc (P1: LPCSTR, P2: LPCSTR, P3: PVOID, P4: DWORD, P5: DWORD, P6: LPSTR): WINBOOL {.stdcall.}
  PSYMBOLSERVEROPENPROC* = proc (): WINBOOL {.stdcall.}
  PSYMBOLSERVERCLOSEPROC* = proc (): WINBOOL {.stdcall.}
  PSYMBOLSERVERSETOPTIONSPROC* = proc (P1: UINT_PTR, P2: ULONG64): WINBOOL {.stdcall.}
  PSYMBOLSERVERCALLBACKPROC* = proc (action: UINT_PTR, data: ULONG64, context: ULONG64): WINBOOL {.stdcall.}
  PSYMBOLSERVERGETOPTIONSPROC* = proc (): UINT_PTR {.stdcall.}
  PSYMBOLSERVERPINGPROC* = proc (P1: LPCSTR): WINBOOL {.stdcall.}
  PENUMDIRTREE_CALLBACK* = proc (FilePath: LPCSTR, CallerData: PVOID): WINBOOL {.stdcall.}
  PREAD_PROCESS_MEMORY_ROUTINE64* = proc (hProcess: HANDLE, qwBaseAddress: DWORD64, lpBuffer: PVOID, nSize: DWORD, lpNumberOfBytesRead: LPDWORD): WINBOOL {.stdcall.}
  PFUNCTION_TABLE_ACCESS_ROUTINE64* = proc (hProcess: HANDLE, AddrBase: DWORD64): PVOID {.stdcall.}
  PGET_MODULE_BASE_ROUTINE64* = proc (hProcess: HANDLE, Address: DWORD64): DWORD64 {.stdcall.}
  PTRANSLATE_ADDRESS_ROUTINE64* = proc (hProcess: HANDLE, hThread: HANDLE, lpaddr: LPADDRESS64): DWORD64 {.stdcall.}
  PSYM_ENUMMODULES_CALLBACK64* = proc (ModuleName: PCSTR, BaseOfDll: DWORD64, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYM_ENUMMODULES_CALLBACKW64* = proc (ModuleName: PCWSTR, BaseOfDll: DWORD64, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYM_ENUMSYMBOLS_CALLBACK64* = proc (SymbolName: PCSTR, SymbolAddress: DWORD64, SymbolSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYM_ENUMSYMBOLS_CALLBACK64W* = proc (SymbolName: PCWSTR, SymbolAddress: DWORD64, SymbolSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
  PENUMLOADED_MODULES_CALLBACK64* = proc (ModuleName: PCSTR, ModuleBase: DWORD64, ModuleSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
  PENUMLOADED_MODULES_CALLBACKW64* = proc (ModuleName: PCWSTR, ModuleBase: DWORD64, ModuleSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYMBOL_REGISTERED_CALLBACK64* = proc (hProcess: HANDLE, ActionCode: ULONG, CallbackData: ULONG64, UserContext: ULONG64): WINBOOL {.stdcall.}
  PSYMBOL_FUNCENTRY_CALLBACK64* = proc (hProcess: HANDLE, AddrBase: ULONG64, UserContext: ULONG64): PVOID {.stdcall.}
  PSYM_ENUMSOURCEFILES_CALLBACKW* = proc (pSourceFile: PSOURCEFILEW, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYM_ENUMLINES_CALLBACK* = proc (LineInfo: PSRCCODEINFO, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYM_ENUMLINES_CALLBACKW* = proc (LineInfo: PSRCCODEINFOW, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYM_ENUMERATESYMBOLS_CALLBACK* = proc (pSymInfo: PSYMBOL_INFO, SymbolSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
  PSYM_ENUMERATESYMBOLS_CALLBACKW* = proc (pSymInfo: PSYMBOL_INFOW, SymbolSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
  PDBGHELP_CREATE_USER_DUMP_CALLBACK* = proc (DataType: DWORD, Data: ptr PVOID, DataLength: LPDWORD, UserData: PVOID): WINBOOL {.stdcall.}
  TI_FINDCHILDREN_PARAMS* {.pure.} = object
    Count*: ULONG
    Start*: ULONG
    ChildId*: array[1, ULONG]
  MINIDUMP_LOCATION_DESCRIPTOR64* {.pure.} = object
    DataSize*: ULONG64
    Rva*: RVA64
proc BindImage*(ImageName: PCSTR, DllPath: PCSTR, SymbolPath: PCSTR): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc BindImageEx*(Flags: DWORD, ImageName: PCSTR, DllPath: PCSTR, SymbolPath: PCSTR, StatusRoutine: PIMAGEHLP_STATUS_ROUTINE): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ReBaseImage*(CurrentImageName: PCSTR, SymbolPath: PCSTR, fReBase: WINBOOL, fRebaseSysfileOk: WINBOOL, fGoingDown: WINBOOL, CheckImageSize: ULONG, OldImageSize: ptr ULONG, OldImageBase: ptr ULONG_PTR, NewImageSize: ptr ULONG, NewImageBase: ptr ULONG_PTR, TimeStamp: ULONG): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ReBaseImage64*(CurrentImageName: PCSTR, SymbolPath: PCSTR, fReBase: WINBOOL, fRebaseSysfileOk: WINBOOL, fGoingDown: WINBOOL, CheckImageSize: ULONG, OldImageSize: ptr ULONG, OldImageBase: ptr ULONG64, NewImageSize: ptr ULONG, NewImageBase: ptr ULONG64, TimeStamp: ULONG): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc GetImageConfigInformation*(LoadedImage: PLOADED_IMAGE, ImageConfigInformation: PIMAGE_LOAD_CONFIG_DIRECTORY): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc GetImageUnusedHeaderBytes*(LoadedImage: PLOADED_IMAGE, SizeUnusedHeaderBytes: PDWORD): DWORD {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc SetImageConfigInformation*(LoadedImage: PLOADED_IMAGE, ImageConfigInformation: PIMAGE_LOAD_CONFIG_DIRECTORY): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc CheckSumMappedFile*(BaseAddress: PVOID, FileLength: DWORD, HeaderSum: PDWORD, CheckSum: PDWORD): PIMAGE_NT_HEADERS {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc MapFileAndCheckSumA*(Filename: PCSTR, HeaderSum: PDWORD, CheckSum: PDWORD): DWORD {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc MapFileAndCheckSumW*(Filename: PCWSTR, HeaderSum: PDWORD, CheckSum: PDWORD): DWORD {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ImageGetDigestStream*(FileHandle: HANDLE, DigestLevel: DWORD, DigestFunction: DIGEST_FUNCTION, DigestHandle: DIGEST_HANDLE): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ImageAddCertificate*(FileHandle: HANDLE, Certificate: LPWIN_CERTIFICATE, Index: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ImageRemoveCertificate*(FileHandle: HANDLE, Index: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ImageEnumerateCertificates*(FileHandle: HANDLE, TypeFilter: WORD, CertificateCount: PDWORD, Indices: PDWORD, IndexCount: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ImageGetCertificateData*(FileHandle: HANDLE, CertificateIndex: DWORD, Certificate: LPWIN_CERTIFICATE, RequiredLength: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ImageGetCertificateHeader*(FileHandle: HANDLE, CertificateIndex: DWORD, Certificateheader: LPWIN_CERTIFICATE): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ImageLoad*(DllName: PCSTR, DllPath: PCSTR): PLOADED_IMAGE {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc ImageUnload*(LoadedImage: PLOADED_IMAGE): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc MapAndLoad*(ImageName: PCSTR, DllPath: PCSTR, LoadedImage: PLOADED_IMAGE, DotDll: WINBOOL, ReadOnly: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc UnMapAndLoad*(LoadedImage: PLOADED_IMAGE): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc TouchFileTimes*(FileHandle: HANDLE, pSystemTime: PSYSTEMTIME): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc SplitSymbols*(ImageName: PSTR, SymbolsPath: PCSTR, SymbolFilePath: PSTR, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc UpdateDebugInfoFile*(ImageFileName: PCSTR, SymbolPath: PCSTR, DebugFilePath: PSTR, NtHeaders: PIMAGE_NT_HEADERS32): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc UpdateDebugInfoFileEx*(ImageFileName: PCSTR, SymbolPath: PCSTR, DebugFilePath: PSTR, NtHeaders: PIMAGE_NT_HEADERS32, OldChecksum: DWORD): WINBOOL {.winapi, stdcall, dynlib: "imagehlp", importc.}
proc FindDebugInfoFile*(FileName: PCSTR, SymbolPath: PCSTR, DebugFilePath: PSTR): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc FindDebugInfoFileEx*(FileName: PCSTR, SymbolPath: PCSTR, DebugFilePath: PSTR, Callback: PFIND_DEBUG_FILE_CALLBACK, CallerData: PVOID): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc FindDebugInfoFileExW*(FileName: PCWSTR, SymbolPath: PCWSTR, DebugFilePath: PWSTR, Callback: PFIND_DEBUG_FILE_CALLBACKW, CallerData: PVOID): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFindFileInPath*(hprocess: HANDLE, SearchPath: PCSTR, FileName: PCSTR, id: PVOID, two: DWORD, three: DWORD, flags: DWORD, FoundFile: LPSTR, callback: PFINDFILEINPATHCALLBACK, context: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFindFileInPathW*(hprocess: HANDLE, SearchPath: PCWSTR, FileName: PCWSTR, id: PVOID, two: DWORD, three: DWORD, flags: DWORD, FoundFile: LPSTR, callback: PFINDFILEINPATHCALLBACKW, context: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc FindExecutableImage*(FileName: PCSTR, SymbolPath: PCSTR, ImageFilePath: PSTR): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc FindExecutableImageEx*(FileName: PCSTR, SymbolPath: PCSTR, ImageFilePath: PSTR, Callback: PFIND_EXE_FILE_CALLBACK, CallerData: PVOID): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc FindExecutableImageExW*(FileName: PCWSTR, SymbolPath: PCWSTR, ImageFilePath: PWSTR, Callback: PFIND_EXE_FILE_CALLBACKW, CallerData: PVOID): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc ImageNtHeader*(Base: PVOID): PIMAGE_NT_HEADERS {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc ImageDirectoryEntryToDataEx*(Base: PVOID, MappedAsImage: BOOLEAN, DirectoryEntry: USHORT, Size: PULONG, FoundHeader: ptr PIMAGE_SECTION_HEADER): PVOID {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc ImageDirectoryEntryToData*(Base: PVOID, MappedAsImage: BOOLEAN, DirectoryEntry: USHORT, Size: PULONG): PVOID {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc ImageRvaToSection*(NtHeaders: PIMAGE_NT_HEADERS, Base: PVOID, Rva: ULONG): PIMAGE_SECTION_HEADER {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc ImageRvaToVa*(NtHeaders: PIMAGE_NT_HEADERS, Base: PVOID, Rva: ULONG, LastRvaSection: ptr PIMAGE_SECTION_HEADER): PVOID {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SearchTreeForFile*(RootPath: PSTR, InputPathName: PSTR, OutputPathBuffer: PSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SearchTreeForFileW*(RootPath: PWSTR, InputPathName: PWSTR, OutputPathBuffer: PWSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc EnumDirTree*(hProcess: HANDLE, RootPath: PSTR, InputPathName: PSTR, OutputPathBuffer: PSTR, Callback: PENUMDIRTREE_CALLBACK, CallbackData: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc MakeSureDirectoryPathExists*(DirPath: PCSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc UnDecorateSymbolNameA*(DecoratedName: PCSTR, UnDecoratedName: PSTR, UndecoratedLength: DWORD, Flags: DWORD): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc: "UnDecorateSymbolName".}
proc UnDecorateSymbolNameW*(DecoratedName: PCWSTR, UnDecoratedName: PWSTR, UndecoratedLength: DWORD, Flags: DWORD): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc StackWalk64*(MachineType: DWORD, hProcess: HANDLE, hThread: HANDLE, StackFrame: LPSTACKFRAME64, ContextRecord: PVOID, ReadMemoryRoutine: PREAD_PROCESS_MEMORY_ROUTINE64, FunctionTableAccessRoutine: PFUNCTION_TABLE_ACCESS_ROUTINE64, GetModuleBaseRoutine: PGET_MODULE_BASE_ROUTINE64, TranslateAddress: PTRANSLATE_ADDRESS_ROUTINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc ImagehlpApiVersion*(): LPAPI_VERSION {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc ImagehlpApiVersionEx*(AppVersion: LPAPI_VERSION): LPAPI_VERSION {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc GetTimestampForLoadedLibrary*(Module: HMODULE): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSetParentWindow*(hwnd: HWND): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSetHomeDirectory*(hProcess: HANDLE, dir: PCSTR): PCHAR {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSetHomeDirectoryW*(hProcess: HANDLE, dir: PCWSTR): PCHAR {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetHomeDirectory*(`type`: DWORD, dir: PSTR, size: int): PCHAR {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetHomeDirectoryW*(`type`: DWORD, dir: PWSTR, size: int): PWCHAR {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSetOptions*(SymOptions: DWORD): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetOptions*(): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymCleanup*(hProcess: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymMatchString*(string: PCSTR, expression: PCSTR, fCase: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymMatchStringW*(string: PCWSTR, expression: PCWSTR, fCase: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumSourceFiles*(hProcess: HANDLE, ModBase: ULONG64, Mask: PCSTR, cbSrcFiles: PSYM_ENUMSOURCEFILES_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumSourceFilesW*(hProcess: HANDLE, ModBase: ULONG64, Mask: PCWSTR, cbSrcFiles: PSYM_ENUMSOURCEFILES_CALLBACKW, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumerateModules64*(hProcess: HANDLE, EnumModulesCallback: PSYM_ENUMMODULES_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumerateModulesW64*(hProcess: HANDLE, EnumModulesCallback: PSYM_ENUMMODULES_CALLBACKW64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumerateSymbols64*(hProcess: HANDLE, BaseOfDll: DWORD64, EnumSymbolsCallback: PSYM_ENUMSYMBOLS_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumerateSymbolsW64*(hProcess: HANDLE, BaseOfDll: DWORD64, EnumSymbolsCallback: PSYM_ENUMSYMBOLS_CALLBACK64W, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc EnumerateLoadedModulesA64*(hProcess: HANDLE, EnumLoadedModulesCallback: PENUMLOADED_MODULES_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "EnumerateLoadedModules64".}
proc EnumerateLoadedModulesW64*(hProcess: HANDLE, EnumLoadedModulesCallback: PENUMLOADED_MODULES_CALLBACKW64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFunctionTableAccess64*(hProcess: HANDLE, AddrBase: DWORD64): PVOID {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetModuleInfo64*(hProcess: HANDLE, qwAddr: DWORD64, ModuleInfo: PIMAGEHLP_MODULE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetModuleInfoW64*(hProcess: HANDLE, qwAddr: DWORD64, ModuleInfo: PIMAGEHLP_MODULEW64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetModuleBase64*(hProcess: HANDLE, qwAddr: DWORD64): DWORD64 {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSymNext64*(hProcess: HANDLE, Symbol: PIMAGEHLP_SYMBOL64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSymPrev64*(hProcess: HANDLE, Symbol: PIMAGEHLP_SYMBOL64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumLines*(hProcess: HANDLE, Base: ULONG64, Obj: PCSTR, File: PCSTR, EnumLinesCallback: PSYM_ENUMLINES_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumLinesW*(hProcess: HANDLE, Base: ULONG64, Obj: PCWSTR, File: PCSTR, EnumLinesCallback: PSYM_ENUMLINES_CALLBACKW, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetLineFromAddr64*(hProcess: HANDLE, qwAddr: DWORD64, pdwDisplacement: PDWORD, Line64: PIMAGEHLP_LINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetLineFromAddrW64*(hProcess: HANDLE, qwAddr: DWORD64, pdwDisplacement: PDWORD, Line64: PIMAGEHLP_LINEW64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetLineFromName64*(hProcess: HANDLE, ModuleName: PCSTR, FileName: PCSTR, dwLineNumber: DWORD, plDisplacement: PLONG, Line: PIMAGEHLP_LINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetLineFromNameW64*(hProcess: HANDLE, ModuleName: PCWSTR, FileName: PCWSTR, dwLineNumber: DWORD, plDisplacement: PLONG, Line: PIMAGEHLP_LINEW64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetLineNext64*(hProcess: HANDLE, Line: PIMAGEHLP_LINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetLineNextW64*(hProcess: HANDLE, Line: PIMAGEHLP_LINEW64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetLinePrev64*(hProcess: HANDLE, Line: PIMAGEHLP_LINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetLinePrevW64*(hProcess: HANDLE, Line: PIMAGEHLP_LINEW64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymMatchFileName*(FileName: PCSTR, Match: PCSTR, FileNameStop: ptr PSTR, MatchStop: ptr PSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymMatchFileNameW*(FileName: PCWSTR, Match: PCWSTR, FileNameStop: ptr PWSTR, MatchStop: ptr PWSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymInitialize*(hProcess: HANDLE, UserSearchPath: PCSTR, fInvadeProcess: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymInitializeW*(hProcess: HANDLE, UserSearchPath: PCWSTR, fInvadeProcess: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSearchPath*(hProcess: HANDLE, SearchPath: PSTR, SearchPathLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSearchPathW*(hProcess: HANDLE, SearchPath: PWSTR, SearchPathLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSetSearchPath*(hProcess: HANDLE, SearchPath: PCSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSetSearchPathW*(hProcess: HANDLE, SearchPath: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymLoadModule64*(hProcess: HANDLE, hFile: HANDLE, ImageName: PSTR, ModuleName: PSTR, BaseOfDll: DWORD64, SizeOfDll: DWORD): DWORD64 {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymLoadModuleEx*(hProcess: HANDLE, hFile: HANDLE, ImageName: PCSTR, ModuleName: PCSTR, BaseOfDll: DWORD64, DllSize: DWORD, Data: PMODLOAD_DATA, Flags: DWORD): DWORD64 {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymLoadModuleExW*(hProcess: HANDLE, hFile: HANDLE, ImageName: PCWSTR, ModuleName: PCWSTR, BaseOfDll: DWORD64, DllSize: DWORD, Data: PMODLOAD_DATA, Flags: DWORD): DWORD64 {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymUnloadModule64*(hProcess: HANDLE, BaseOfDll: DWORD64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymUnDName64*(sym: PIMAGEHLP_SYMBOL64, UnDecName: PSTR, UnDecNameLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymRegisterCallback64*(hProcess: HANDLE, CallbackFunction: PSYMBOL_REGISTERED_CALLBACK64, UserContext: ULONG64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymRegisterFunctionEntryCallback64*(hProcess: HANDLE, CallbackFunction: PSYMBOL_FUNCENTRY_CALLBACK64, UserContext: ULONG64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSetContext*(hProcess: HANDLE, StackFrame: PIMAGEHLP_STACK_FRAME, Context: PIMAGEHLP_CONTEXT): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFromAddr*(hProcess: HANDLE, Address: DWORD64, Displacement: PDWORD64, Symbol: PSYMBOL_INFO): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFromAddrW*(hProcess: HANDLE, Address: DWORD64, Displacement: PDWORD64, Symbol: PSYMBOL_INFOW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFromToken*(hProcess: HANDLE, Base: DWORD64, Token: DWORD, Symbol: PSYMBOL_INFO): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFromTokenW*(hProcess: HANDLE, Base: DWORD64, Token: DWORD, Symbol: PSYMBOL_INFOW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFromName*(hProcess: HANDLE, Name: PCSTR, Symbol: PSYMBOL_INFO): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFromNameW*(hProcess: HANDLE, Name: PCWSTR, Symbol: PSYMBOL_INFOW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumSymbols*(hProcess: HANDLE, BaseOfDll: ULONG64, Mask: PCSTR, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumSymbolsW*(hProcess: HANDLE, BaseOfDll: ULONG64, Mask: PCWSTR, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACKW, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumSymbolsForAddr*(hProcess: HANDLE, Address: DWORD64, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumSymbolsForAddrW*(hProcess: HANDLE, Address: DWORD64, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACKW, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetTypeInfo*(hProcess: HANDLE, ModBase: DWORD64, TypeId: ULONG, GetType: IMAGEHLP_SYMBOL_TYPE_INFO, pInfo: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumTypes*(hProcess: HANDLE, BaseOfDll: ULONG64, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumTypesW*(hProcess: HANDLE, BaseOfDll: ULONG64, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACKW, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetTypeFromName*(hProcess: HANDLE, BaseOfDll: ULONG64, Name: PCSTR, Symbol: PSYMBOL_INFO): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetTypeFromNameW*(hProcess: HANDLE, BaseOfDll: ULONG64, Name: PCWSTR, Symbol: PSYMBOL_INFOW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymAddSymbol*(hProcess: HANDLE, BaseOfDll: ULONG64, Name: PCSTR, Address: DWORD64, Size: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymAddSymbolW*(hProcess: HANDLE, BaseOfDll: ULONG64, Name: PCWSTR, Address: DWORD64, Size: DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymDeleteSymbol*(hProcess: HANDLE, BaseOfDll: ULONG64, Name: PCSTR, Address: DWORD64, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymDeleteSymbolW*(hProcess: HANDLE, BaseOfDll: ULONG64, Name: PCWSTR, Address: DWORD64, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc DbgHelpCreateUserDump*(FileName: LPCSTR, Callback: PDBGHELP_CREATE_USER_DUMP_CALLBACK, UserData: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc DbgHelpCreateUserDumpW*(FileName: LPCWSTR, Callback: PDBGHELP_CREATE_USER_DUMP_CALLBACK, UserData: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSymFromAddr64*(hProcess: HANDLE, qwAddr: DWORD64, pdwDisplacement: PDWORD64, Symbol: PIMAGEHLP_SYMBOL64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSymFromName64*(hProcess: HANDLE, Name: PCSTR, Symbol: PIMAGEHLP_SYMBOL64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc MiniDumpWriteDump*(hProcess: HANDLE, ProcessId: DWORD, hFile: HANDLE, DumpType: MINIDUMP_TYPE, ExceptionParam: PMINIDUMP_EXCEPTION_INFORMATION, UserStreamParam: PMINIDUMP_USER_STREAM_INFORMATION, CallbackParam: PMINIDUMP_CALLBACK_INFORMATION): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc MiniDumpReadDumpStream*(BaseOfDump: PVOID, StreamNumber: ULONG, Dir: ptr PMINIDUMP_DIRECTORY, StreamPointer: ptr PVOID, StreamSize: ptr ULONG): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc EnumerateLoadedModulesEx*(hProcess: HANDLE, EnumLoadedModulesCallback: PENUMLOADED_MODULES_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc EnumerateLoadedModulesExW*(hProcess: HANDLE, EnumLoadedModulesCallback: PENUMLOADED_MODULES_CALLBACKW64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymAddSourceStream*(hProcess: HANDLE, Base: ULONG64, StreamFile: PCSTR, Buffer: PBYTE, Size: int): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymAddSourceStreamW*(hProcess: HANDLE, Base: ULONG64, StreamFile: PCWSTR, Buffer: PBYTE, Size: int): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumSourceLines*(hProcess: HANDLE, Base: ULONG64, Obj: PCSTR, File: PCSTR, Line: DWORD, Flags: DWORD, EnumLinesCallback: PSYM_ENUMLINES_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumSourceLinesW*(hProcess: HANDLE, Base: ULONG64, Obj: PCWSTR, File: PCWSTR, Line: DWORD, Flags: DWORD, EnumLinesCallback: PSYM_ENUMLINES_CALLBACKW, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumTypesByName*(hProcess: HANDLE, BaseOfDll: ULONG64, mask: PCSTR, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymEnumTypesByNameW*(hProcess: HANDLE, BaseOfDll: ULONG64, mask: PCSTR, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACKW, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFindDebugInfoFile*(hProcess: HANDLE, FileName: PCSTR, DebugFilePath: PSTR, Callback: PFIND_DEBUG_FILE_CALLBACK, CallerData: PVOID): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFindDebugInfoFileW*(hProcess: HANDLE, FileName: PCWSTR, DebugFilePath: PWSTR, Callback: PFIND_DEBUG_FILE_CALLBACKW, CallerData: PVOID): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFindExecutableImage*(hProcess: HANDLE, FileName: PCSTR, ImageFilePath: PSTR, Callback: PFIND_EXE_FILE_CALLBACK, CallerData: PVOID): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFindExecutableImageW*(hProcess: HANDLE, FileName: PCWSTR, ImageFilePath: PWSTR, Callback: PFIND_EXE_FILE_CALLBACKW, CallerData: PVOID): HANDLE {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFromIndex*(hProcess: HANDLE, BaseOfDll: ULONG64, Index: DWORD, Symbol: PSYMBOL_INFO): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymFromIndexW*(hProcess: HANDLE, BaseOfDll: ULONG64, Index: DWORD, Symbol: PSYMBOL_INFOW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetScope*(hProcess: HANDLE, BaseOfDll: ULONG64, Index: DWORD, Symbol: PSYMBOL_INFO): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetScopeW*(hProcess: HANDLE, BaseOfDll: ULONG64, Index: DWORD, Symbol: PSYMBOL_INFOW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSourceFileFromToken*(hProcess: HANDLE, Token: PVOID, Params: PCSTR, FilePath: PSTR, Size: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSourceFileFromTokenW*(hProcess: HANDLE, Token: PVOID, Params: PCWSTR, FilePath: PWSTR, Size: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSourceFileToken*(hProcess: HANDLE, Base: ULONG64, FileSpec: PCSTR, Token: ptr PVOID, Size: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSourceFileTokenW*(hProcess: HANDLE, Base: ULONG64, FileSpec: PCWSTR, Token: ptr PVOID, Size: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSourceFile*(hProcess: HANDLE, Base: ULONG64, Params: PCSTR, FileSpec: PCSTR, FilePath: PSTR, Size: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSourceFileW*(hProcess: HANDLE, Base: ULONG64, Params: PCWSTR, FileSpec: PCWSTR, FilePath: PWSTR, Size: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSourceVarFromToken*(hProcess: HANDLE, Token: PVOID, Params: PCSTR, VarName: PCSTR, Value: PSTR, Size: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSourceVarFromTokenW*(hProcess: HANDLE, Token: PVOID, Params: PCWSTR, VarName: PCWSTR, Value: PWSTR, Size: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSymbolFile*(hProcess: HANDLE, SymPath: PCSTR, ImageFile: PCSTR, Type: DWORD, SymbolFile: PSTR, cSymbolFile: int, DbgFile: PSTR, cDbgFile: int): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymGetSymbolFileW*(hProcess: HANDLE, SymPath: PCWSTR, ImageFile: PCWSTR, Type: DWORD, SymbolFile: PWSTR, cSymbolFile: int, DbgFile: PWSTR, cDbgFile: int): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymNext*(hProcess: HANDLE, Symbol: PSYMBOL_INFO): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymNextW*(hProcess: HANDLE, Symbol: PSYMBOL_INFOW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymPrev*(hProcess: HANDLE, Symbol: PSYMBOL_INFO): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymPrevW*(hProcess: HANDLE, Symbol: PSYMBOL_INFOW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymRefreshModuleList*(hProcess: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSearch*(hProcess: HANDLE, BaseOfDll: ULONG64, Index: DWORD, SymTag: DWORD, Mask: PCSTR, Address: DWORD64, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACK, UserContext: PVOID, Options: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSearchW*(hProcess: HANDLE, BaseOfDll: ULONG64, Index: DWORD, SymTag: DWORD, Mask: PCWSTR, Address: DWORD64, EnumSymbolsCallback: PSYM_ENUMERATESYMBOLS_CALLBACKW, UserContext: PVOID, Options: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSrvGetFileIndexStringA*(hProcess: HANDLE, SrvPath: PCSTR, File: PCSTR, Index: PSTR, Size: int, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvGetFileIndexString".}
proc SymSrvGetFileIndexStringW*(hProcess: HANDLE, SrvPath: PCWSTR, File: PCWSTR, Index: PWSTR, Size: int, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSrvGetFileIndexInfoA*(File: PCSTR, Info: PSYMSRV_INDEX_INFO, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvGetFileIndexInfo".}
proc SymSrvGetFileIndexInfoW*(File: PCWSTR, Info: PSYMSRV_INDEX_INFOW, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSrvGetFileIndexesA*(File: PCSTR, Id: ptr GUID, Val1: ptr DWORD, Val2: ptr DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvGetFileIndexes".}
proc SymSrvGetFileIndexesW*(File: PCWSTR, Id: ptr GUID, Val1: ptr DWORD, Val2: ptr DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSrvGetSupplementA*(hProcess: HANDLE, SymPath: PCSTR, Node: PCSTR, File: PCSTR): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvGetSupplement".}
proc SymSrvGetSupplementW*(hProcess: HANDLE, SymPath: PCWSTR, Node: PCWSTR, File: PCWSTR): PCWSTR {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSrvIsStoreA*(hProcess: HANDLE, path: PCSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvIsStore".}
proc SymSrvIsStoreW*(hProcess: HANDLE, path: PCWSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSrvStoreFileA*(hProcess: HANDLE, SrvPath: PCSTR, File: PCSTR, Flags: DWORD): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvStoreFile".}
proc SymSrvStoreFileW*(hProcess: HANDLE, SrvPath: PCWSTR, File: PCWSTR, Flags: DWORD): PCWSTR {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSrvStoreSupplementA*(hProcess: HANDLE, SymPath: PCTSTR, Node: PCSTR, File: PCSTR, Flags: DWORD): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvStoreSupplement".}
proc SymSrvStoreSupplementW*(hProcess: HANDLE, SymPath: PCWSTR, Node: PCWSTR, File: PCWSTR, Flags: DWORD): PCWSTR {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc SymSrvDeltaNameA*(hProcess: HANDLE, SymPath: PCSTR, Type: PCSTR, File1: PCSTR, File2: PCSTR): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvDeltaName".}
proc SymSrvDeltaNameW*(hProcess: HANDLE, SymPath: PCWSTR, Type: PCWSTR, File1: PCWSTR, File2: PCWSTR): PCWSTR {.winapi, stdcall, dynlib: "dbghelp", importc.}
proc `Reserved=`*(self: var MINIDUMP_HEADER, x: ULONG32) {.inline.} = self.union1.Reserved = x
proc Reserved*(self: MINIDUMP_HEADER): ULONG32 {.inline.} = self.union1.Reserved
proc Reserved*(self: var MINIDUMP_HEADER): var ULONG32 {.inline.} = self.union1.Reserved
proc `TimeDateStamp=`*(self: var MINIDUMP_HEADER, x: ULONG32) {.inline.} = self.union1.TimeDateStamp = x
proc TimeDateStamp*(self: MINIDUMP_HEADER): ULONG32 {.inline.} = self.union1.TimeDateStamp
proc TimeDateStamp*(self: var MINIDUMP_HEADER): var ULONG32 {.inline.} = self.union1.TimeDateStamp
proc `Reserved0=`*(self: var MINIDUMP_SYSTEM_INFO, x: USHORT) {.inline.} = self.union1.Reserved0 = x
proc Reserved0*(self: MINIDUMP_SYSTEM_INFO): USHORT {.inline.} = self.union1.Reserved0
proc Reserved0*(self: var MINIDUMP_SYSTEM_INFO): var USHORT {.inline.} = self.union1.Reserved0
proc `NumberOfProcessors=`*(self: var MINIDUMP_SYSTEM_INFO, x: UCHAR) {.inline.} = self.union1.struct1.NumberOfProcessors = x
proc NumberOfProcessors*(self: MINIDUMP_SYSTEM_INFO): UCHAR {.inline.} = self.union1.struct1.NumberOfProcessors
proc NumberOfProcessors*(self: var MINIDUMP_SYSTEM_INFO): var UCHAR {.inline.} = self.union1.struct1.NumberOfProcessors
proc `ProductType=`*(self: var MINIDUMP_SYSTEM_INFO, x: UCHAR) {.inline.} = self.union1.struct1.ProductType = x
proc ProductType*(self: MINIDUMP_SYSTEM_INFO): UCHAR {.inline.} = self.union1.struct1.ProductType
proc ProductType*(self: var MINIDUMP_SYSTEM_INFO): var UCHAR {.inline.} = self.union1.struct1.ProductType
proc `Reserved1=`*(self: var MINIDUMP_SYSTEM_INFO, x: ULONG32) {.inline.} = self.union2.Reserved1 = x
proc Reserved1*(self: MINIDUMP_SYSTEM_INFO): ULONG32 {.inline.} = self.union2.Reserved1
proc Reserved1*(self: var MINIDUMP_SYSTEM_INFO): var ULONG32 {.inline.} = self.union2.Reserved1
proc `SuiteMask=`*(self: var MINIDUMP_SYSTEM_INFO, x: USHORT) {.inline.} = self.union2.struct1.SuiteMask = x
proc SuiteMask*(self: MINIDUMP_SYSTEM_INFO): USHORT {.inline.} = self.union2.struct1.SuiteMask
proc SuiteMask*(self: var MINIDUMP_SYSTEM_INFO): var USHORT {.inline.} = self.union2.struct1.SuiteMask
proc `Reserved2=`*(self: var MINIDUMP_SYSTEM_INFO, x: USHORT) {.inline.} = self.union2.struct1.Reserved2 = x
proc Reserved2*(self: MINIDUMP_SYSTEM_INFO): USHORT {.inline.} = self.union2.struct1.Reserved2
proc Reserved2*(self: var MINIDUMP_SYSTEM_INFO): var USHORT {.inline.} = self.union2.struct1.Reserved2
proc `Thread=`*(self: var MINIDUMP_CALLBACK_INPUT, x: MINIDUMP_THREAD_CALLBACK) {.inline.} = self.union1.Thread = x
proc Thread*(self: MINIDUMP_CALLBACK_INPUT): MINIDUMP_THREAD_CALLBACK {.inline.} = self.union1.Thread
proc Thread*(self: var MINIDUMP_CALLBACK_INPUT): var MINIDUMP_THREAD_CALLBACK {.inline.} = self.union1.Thread
proc `ThreadEx=`*(self: var MINIDUMP_CALLBACK_INPUT, x: MINIDUMP_THREAD_EX_CALLBACK) {.inline.} = self.union1.ThreadEx = x
proc ThreadEx*(self: MINIDUMP_CALLBACK_INPUT): MINIDUMP_THREAD_EX_CALLBACK {.inline.} = self.union1.ThreadEx
proc ThreadEx*(self: var MINIDUMP_CALLBACK_INPUT): var MINIDUMP_THREAD_EX_CALLBACK {.inline.} = self.union1.ThreadEx
proc `Module=`*(self: var MINIDUMP_CALLBACK_INPUT, x: MINIDUMP_MODULE_CALLBACK) {.inline.} = self.union1.Module = x
proc Module*(self: MINIDUMP_CALLBACK_INPUT): MINIDUMP_MODULE_CALLBACK {.inline.} = self.union1.Module
proc Module*(self: var MINIDUMP_CALLBACK_INPUT): var MINIDUMP_MODULE_CALLBACK {.inline.} = self.union1.Module
proc `IncludeThread=`*(self: var MINIDUMP_CALLBACK_INPUT, x: MINIDUMP_INCLUDE_THREAD_CALLBACK) {.inline.} = self.union1.IncludeThread = x
proc IncludeThread*(self: MINIDUMP_CALLBACK_INPUT): MINIDUMP_INCLUDE_THREAD_CALLBACK {.inline.} = self.union1.IncludeThread
proc IncludeThread*(self: var MINIDUMP_CALLBACK_INPUT): var MINIDUMP_INCLUDE_THREAD_CALLBACK {.inline.} = self.union1.IncludeThread
proc `IncludeModule=`*(self: var MINIDUMP_CALLBACK_INPUT, x: MINIDUMP_INCLUDE_MODULE_CALLBACK) {.inline.} = self.union1.IncludeModule = x
proc IncludeModule*(self: MINIDUMP_CALLBACK_INPUT): MINIDUMP_INCLUDE_MODULE_CALLBACK {.inline.} = self.union1.IncludeModule
proc IncludeModule*(self: var MINIDUMP_CALLBACK_INPUT): var MINIDUMP_INCLUDE_MODULE_CALLBACK {.inline.} = self.union1.IncludeModule
proc `ModuleWriteFlags=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: ULONG) {.inline.} = self.union1.ModuleWriteFlags = x
proc ModuleWriteFlags*(self: MINIDUMP_CALLBACK_OUTPUT): ULONG {.inline.} = self.union1.ModuleWriteFlags
proc ModuleWriteFlags*(self: var MINIDUMP_CALLBACK_OUTPUT): var ULONG {.inline.} = self.union1.ModuleWriteFlags
proc `ThreadWriteFlags=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: ULONG) {.inline.} = self.union1.ThreadWriteFlags = x
proc ThreadWriteFlags*(self: MINIDUMP_CALLBACK_OUTPUT): ULONG {.inline.} = self.union1.ThreadWriteFlags
proc ThreadWriteFlags*(self: var MINIDUMP_CALLBACK_OUTPUT): var ULONG {.inline.} = self.union1.ThreadWriteFlags
proc `SecondaryFlags=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: ULONG) {.inline.} = self.union1.SecondaryFlags = x
proc SecondaryFlags*(self: MINIDUMP_CALLBACK_OUTPUT): ULONG {.inline.} = self.union1.SecondaryFlags
proc SecondaryFlags*(self: var MINIDUMP_CALLBACK_OUTPUT): var ULONG {.inline.} = self.union1.SecondaryFlags
proc `MemoryBase=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: ULONG64) {.inline.} = self.union1.struct1.MemoryBase = x
proc MemoryBase*(self: MINIDUMP_CALLBACK_OUTPUT): ULONG64 {.inline.} = self.union1.struct1.MemoryBase
proc MemoryBase*(self: var MINIDUMP_CALLBACK_OUTPUT): var ULONG64 {.inline.} = self.union1.struct1.MemoryBase
proc `MemorySize=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: ULONG) {.inline.} = self.union1.struct1.MemorySize = x
proc MemorySize*(self: MINIDUMP_CALLBACK_OUTPUT): ULONG {.inline.} = self.union1.struct1.MemorySize
proc MemorySize*(self: var MINIDUMP_CALLBACK_OUTPUT): var ULONG {.inline.} = self.union1.struct1.MemorySize
proc `CheckCancel=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: WINBOOL) {.inline.} = self.union1.struct2.CheckCancel = x
proc CheckCancel*(self: MINIDUMP_CALLBACK_OUTPUT): WINBOOL {.inline.} = self.union1.struct2.CheckCancel
proc CheckCancel*(self: var MINIDUMP_CALLBACK_OUTPUT): var WINBOOL {.inline.} = self.union1.struct2.CheckCancel
proc `Cancel=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: WINBOOL) {.inline.} = self.union1.struct2.Cancel = x
proc Cancel*(self: MINIDUMP_CALLBACK_OUTPUT): WINBOOL {.inline.} = self.union1.struct2.Cancel
proc Cancel*(self: var MINIDUMP_CALLBACK_OUTPUT): var WINBOOL {.inline.} = self.union1.struct2.Cancel
proc `VmRegion=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: MINIDUMP_MEMORY_INFO) {.inline.} = self.struct1.VmRegion = x
proc VmRegion*(self: MINIDUMP_CALLBACK_OUTPUT): MINIDUMP_MEMORY_INFO {.inline.} = self.struct1.VmRegion
proc VmRegion*(self: var MINIDUMP_CALLBACK_OUTPUT): var MINIDUMP_MEMORY_INFO {.inline.} = self.struct1.VmRegion
proc `Continue=`*(self: var MINIDUMP_CALLBACK_OUTPUT, x: WINBOOL) {.inline.} = self.struct1.Continue = x
proc Continue*(self: MINIDUMP_CALLBACK_OUTPUT): WINBOOL {.inline.} = self.struct1.Continue
proc Continue*(self: var MINIDUMP_CALLBACK_OUTPUT): var WINBOOL {.inline.} = self.struct1.Continue
when winimUnicode:
  proc UnDecorateSymbolName*(DecoratedName: PCSTR, UnDecoratedName: PSTR, UndecoratedLength: DWORD, Flags: DWORD): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc: "UnDecorateSymbolNameW".}
  proc EnumerateLoadedModules64*(hProcess: HANDLE, EnumLoadedModulesCallback: PENUMLOADED_MODULES_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "EnumerateLoadedModulesW64".}
  proc SymSrvGetFileIndexString*(hProcess: HANDLE, SrvPath: PCSTR, File: PCSTR, Index: PSTR, Size: int, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvGetFileIndexStringW".}
  proc SymSrvGetFileIndexInfo*(File: PCSTR, Info: PSYMSRV_INDEX_INFO, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvGetFileIndexInfoW".}
  proc SymSrvGetFileIndexes*(File: PCSTR, Id: ptr GUID, Val1: ptr DWORD, Val2: ptr DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvGetFileIndexesW".}
  proc SymSrvGetSupplement*(hProcess: HANDLE, SymPath: PCSTR, Node: PCSTR, File: PCSTR): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvGetSupplementW".}
  proc SymSrvIsStore*(hProcess: HANDLE, path: PCSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvIsStoreW".}
  proc SymSrvStoreFile*(hProcess: HANDLE, SrvPath: PCSTR, File: PCSTR, Flags: DWORD): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvStoreFileW".}
  proc SymSrvStoreSupplement*(hProcess: HANDLE, SymPath: PCTSTR, Node: PCSTR, File: PCSTR, Flags: DWORD): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvStoreSupplementW".}
  proc SymSrvDeltaName*(hProcess: HANDLE, SymPath: PCSTR, Type: PCSTR, File1: PCSTR, File2: PCSTR): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc: "SymSrvDeltaNameW".}
  proc MapFileAndCheckSum*(Filename: PCWSTR, HeaderSum: PDWORD, CheckSum: PDWORD): DWORD {.winapi, stdcall, dynlib: "imagehlp", importc: "MapFileAndCheckSumW".}
when winimAnsi:
  proc UnDecorateSymbolName*(DecoratedName: PCSTR, UnDecoratedName: PSTR, UndecoratedLength: DWORD, Flags: DWORD): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc EnumerateLoadedModules64*(hProcess: HANDLE, EnumLoadedModulesCallback: PENUMLOADED_MODULES_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymSrvGetFileIndexString*(hProcess: HANDLE, SrvPath: PCSTR, File: PCSTR, Index: PSTR, Size: int, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymSrvGetFileIndexInfo*(File: PCSTR, Info: PSYMSRV_INDEX_INFO, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymSrvGetFileIndexes*(File: PCSTR, Id: ptr GUID, Val1: ptr DWORD, Val2: ptr DWORD, Flags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymSrvGetSupplement*(hProcess: HANDLE, SymPath: PCSTR, Node: PCSTR, File: PCSTR): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymSrvIsStore*(hProcess: HANDLE, path: PCSTR): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymSrvStoreFile*(hProcess: HANDLE, SrvPath: PCSTR, File: PCSTR, Flags: DWORD): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymSrvStoreSupplement*(hProcess: HANDLE, SymPath: PCTSTR, Node: PCSTR, File: PCSTR, Flags: DWORD): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymSrvDeltaName*(hProcess: HANDLE, SymPath: PCSTR, Type: PCSTR, File1: PCSTR, File2: PCSTR): PCSTR {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc MapFileAndCheckSum*(Filename: PCSTR, HeaderSum: PDWORD, CheckSum: PDWORD): DWORD {.winapi, stdcall, dynlib: "imagehlp", importc: "MapFileAndCheckSumA".}
when winimCpu64:
  type
    TADDRESS* = TADDRESS64
    LPADDRESS* = LPADDRESS64
    KDHELP* = KDHELP64
    PKDHELP* = PKDHELP64
    STACKFRAME* = STACKFRAME64
    LPSTACKFRAME* = LPSTACKFRAME64
    PREAD_PROCESS_MEMORY_ROUTINE* = PREAD_PROCESS_MEMORY_ROUTINE64
    PFUNCTION_TABLE_ACCESS_ROUTINE* = PFUNCTION_TABLE_ACCESS_ROUTINE64
    PGET_MODULE_BASE_ROUTINE* = PGET_MODULE_BASE_ROUTINE64
    PTRANSLATE_ADDRESS_ROUTINE* = PTRANSLATE_ADDRESS_ROUTINE64
    PSYM_ENUMMODULES_CALLBACK* = PSYM_ENUMMODULES_CALLBACK64
    PSYM_ENUMSYMBOLS_CALLBACK* = PSYM_ENUMSYMBOLS_CALLBACK64
    PSYM_ENUMSYMBOLS_CALLBACKW* = PSYM_ENUMSYMBOLS_CALLBACK64W
    PENUMLOADED_MODULES_CALLBACK* = PENUMLOADED_MODULES_CALLBACK64
    PSYMBOL_REGISTERED_CALLBACK* = PSYMBOL_REGISTERED_CALLBACK64
    PSYMBOL_FUNCENTRY_CALLBACK* = PSYMBOL_FUNCENTRY_CALLBACK64
    IMAGEHLP_SYMBOL* = IMAGEHLP_SYMBOL64
    PIMAGEHLP_SYMBOL* = PIMAGEHLP_SYMBOL64
    IMAGEHLP_SYMBOL_PACKAGE* = IMAGEHLP_SYMBOL64_PACKAGE
    PIMAGEHLP_SYMBOL_PACKAGE* = PIMAGEHLP_SYMBOL64_PACKAGE
    IMAGEHLP_MODULE* = IMAGEHLP_MODULE64
    PIMAGEHLP_MODULE* = PIMAGEHLP_MODULE64
    IMAGEHLP_MODULEW* = IMAGEHLP_MODULEW64
    PIMAGEHLP_MODULEW* = PIMAGEHLP_MODULEW64
    IMAGEHLP_LINE* = IMAGEHLP_LINE64
    PIMAGEHLP_LINE* = PIMAGEHLP_LINE64
    IMAGEHLP_DEFERRED_SYMBOL_LOAD* = IMAGEHLP_DEFERRED_SYMBOL_LOAD64
    PIMAGEHLP_DEFERRED_SYMBOL_LOAD* = PIMAGEHLP_DEFERRED_SYMBOL_LOAD64
    IMAGEHLP_DUPLICATE_SYMBOL* = IMAGEHLP_DUPLICATE_SYMBOL64
    PIMAGEHLP_DUPLICATE_SYMBOL* = PIMAGEHLP_DUPLICATE_SYMBOL64
  proc StackWalk*(MachineType: DWORD, hProcess: HANDLE, hThread: HANDLE, StackFrame: LPSTACKFRAME64, ContextRecord: PVOID, ReadMemoryRoutine: PREAD_PROCESS_MEMORY_ROUTINE64, FunctionTableAccessRoutine: PFUNCTION_TABLE_ACCESS_ROUTINE64, GetModuleBaseRoutine: PGET_MODULE_BASE_ROUTINE64, TranslateAddress: PTRANSLATE_ADDRESS_ROUTINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "StackWalk64".}
  proc SymEnumerateModules*(hProcess: HANDLE, EnumModulesCallback: PSYM_ENUMMODULES_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymEnumerateModules64".}
  proc SymEnumerateSymbols*(hProcess: HANDLE, BaseOfDll: DWORD64, EnumSymbolsCallback: PSYM_ENUMSYMBOLS_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymEnumerateSymbols64".}
  proc SymEnumerateSymbolsW*(hProcess: HANDLE, BaseOfDll: DWORD64, EnumSymbolsCallback: PSYM_ENUMSYMBOLS_CALLBACK64W, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymEnumerateSymbolsW64".}
  proc EnumerateLoadedModules*(hProcess: HANDLE, EnumLoadedModulesCallback: PENUMLOADED_MODULES_CALLBACK64, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "EnumerateLoadedModules64".}
  proc SymFunctionTableAccess*(hProcess: HANDLE, AddrBase: DWORD64): PVOID {.winapi, stdcall, dynlib: "dbghelp", importc: "SymFunctionTableAccess64".}
  proc SymGetModuleInfo*(hProcess: HANDLE, qwAddr: DWORD64, ModuleInfo: PIMAGEHLP_MODULE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetModuleInfo64".}
  proc SymGetModuleInfoW*(hProcess: HANDLE, qwAddr: DWORD64, ModuleInfo: PIMAGEHLP_MODULEW64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetModuleInfoW64".}
  proc SymGetModuleBase*(hProcess: HANDLE, qwAddr: DWORD64): DWORD64 {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetModuleBase64".}
  proc SymGetSymNext*(hProcess: HANDLE, Symbol: PIMAGEHLP_SYMBOL64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetSymNext64".}
  proc SymGetSymPrev*(hProcess: HANDLE, Symbol: PIMAGEHLP_SYMBOL64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetSymPrev64".}
  proc SymGetLineFromAddr*(hProcess: HANDLE, qwAddr: DWORD64, pdwDisplacement: PDWORD, Line64: PIMAGEHLP_LINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetLineFromAddr64".}
  proc SymGetLineFromName*(hProcess: HANDLE, ModuleName: PCSTR, FileName: PCSTR, dwLineNumber: DWORD, plDisplacement: PLONG, Line: PIMAGEHLP_LINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetLineFromName64".}
  proc SymGetLineNext*(hProcess: HANDLE, Line: PIMAGEHLP_LINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetLineNext64".}
  proc SymGetLinePrev*(hProcess: HANDLE, Line: PIMAGEHLP_LINE64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetLinePrev64".}
  proc SymLoadModule*(hProcess: HANDLE, hFile: HANDLE, ImageName: PSTR, ModuleName: PSTR, BaseOfDll: DWORD64, SizeOfDll: DWORD): DWORD64 {.winapi, stdcall, dynlib: "dbghelp", importc: "SymLoadModule64".}
  proc SymUnloadModule*(hProcess: HANDLE, BaseOfDll: DWORD64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymUnloadModule64".}
  proc SymUnDName*(sym: PIMAGEHLP_SYMBOL64, UnDecName: PSTR, UnDecNameLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymUnDName64".}
  proc SymRegisterCallback*(hProcess: HANDLE, CallbackFunction: PSYMBOL_REGISTERED_CALLBACK64, UserContext: ULONG64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymRegisterCallback64".}
  proc SymRegisterFunctionEntryCallback*(hProcess: HANDLE, CallbackFunction: PSYMBOL_FUNCENTRY_CALLBACK64, UserContext: ULONG64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymRegisterFunctionEntryCallback64".}
  proc SymGetSymFromAddr*(hProcess: HANDLE, qwAddr: DWORD64, pdwDisplacement: PDWORD64, Symbol: PIMAGEHLP_SYMBOL64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetSymFromAddr64".}
  proc SymGetSymFromName*(hProcess: HANDLE, Name: PCSTR, Symbol: PIMAGEHLP_SYMBOL64): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc: "SymGetSymFromName64".}
when winimCpu32:
  type
    IMAGE_DEBUG_INFORMATION* {.pure.} = object
      List*: LIST_ENTRY
      ReservedSize*: DWORD
      ReservedMappedBase*: PVOID
      ReservedMachine*: USHORT
      ReservedCharacteristics*: USHORT
      ReservedCheckSum*: DWORD
      ImageBase*: DWORD
      SizeOfImage*: DWORD
      ReservedNumberOfSections*: DWORD
      ReservedSections*: PIMAGE_SECTION_HEADER
      ReservedExportedNamesSize*: DWORD
      ReservedExportedNames*: PSTR
      ReservedNumberOfFunctionTableEntries*: DWORD
      ReservedFunctionTableEntries*: PIMAGE_FUNCTION_ENTRY
      ReservedLowestFunctionStartingAddress*: DWORD
      ReservedHighestFunctionEndingAddress*: DWORD
      ReservedNumberOfFpoTableEntries*: DWORD
      ReservedFpoTableEntries*: PFPO_DATA
      SizeOfCoffSymbols*: DWORD
      CoffSymbols*: PIMAGE_COFF_SYMBOLS_HEADER
      ReservedSizeOfCodeViewSymbols*: DWORD
      ReservedCodeViewSymbols*: PVOID
      ImageFilePath*: PSTR
      ImageFileName*: PSTR
      ReservedDebugFilePath*: PSTR
      ReservedTimeDateStamp*: DWORD
      ReservedRomImage*: WINBOOL
      ReservedDebugDirectory*: PIMAGE_DEBUG_DIRECTORY
      ReservedNumberOfDebugDirectories*: DWORD
      ReservedOriginalFunctionTableBaseAddress*: DWORD
      Reserved*: array[2, DWORD]
    PIMAGE_DEBUG_INFORMATION* = ptr IMAGE_DEBUG_INFORMATION
    TADDRESS* {.pure.} = object
      Offset*: DWORD
      Segment*: WORD
      Mode*: ADDRESS_MODE
    LPADDRESS* = ptr TADDRESS
    KDHELP* {.pure.} = object
      Thread*: DWORD
      ThCallbackStack*: DWORD
      NextCallback*: DWORD
      FramePointer*: DWORD
      KiCallUserMode*: DWORD
      KeUserCallbackDispatcher*: DWORD
      SystemRangeStart*: DWORD
      ThCallbackBStore*: DWORD
      KiUserExceptionDispatcher*: DWORD
      StackBase*: DWORD
      StackLimit*: DWORD
      Reserved*: array[5, DWORD]
    PKDHELP* = ptr KDHELP
    STACKFRAME* {.pure.} = object
      AddrPC*: TADDRESS
      AddrReturn*: TADDRESS
      AddrFrame*: TADDRESS
      AddrStack*: TADDRESS
      FuncTableEntry*: PVOID
      Params*: array[4, DWORD]
      Far*: WINBOOL
      Virtual*: WINBOOL
      Reserved*: array[3, DWORD]
      KdHelp*: KDHELP
      AddrBStore*: TADDRESS
    LPSTACKFRAME* = ptr STACKFRAME
    IMAGEHLP_SYMBOL* {.pure.} = object
      SizeOfStruct*: DWORD
      Address*: DWORD
      Size*: DWORD
      Flags*: DWORD
      MaxNameLength*: DWORD
      Name*: array[1, CHAR]
    PIMAGEHLP_SYMBOL* = ptr IMAGEHLP_SYMBOL
    IMAGEHLP_SYMBOL_PACKAGE* {.pure.} = object
      sym*: IMAGEHLP_SYMBOL
      name*: array[MAX_SYM_NAME+1, CHAR]
    PIMAGEHLP_SYMBOL_PACKAGE* = ptr IMAGEHLP_SYMBOL_PACKAGE
    IMAGEHLP_MODULE* {.pure.} = object
      SizeOfStruct*: DWORD
      BaseOfImage*: DWORD
      ImageSize*: DWORD
      TimeDateStamp*: DWORD
      CheckSum*: DWORD
      NumSyms*: DWORD
      SymType*: SYM_TYPE
      ModuleName*: array[32, CHAR]
      ImageName*: array[256, CHAR]
      LoadedImageName*: array[256, CHAR]
    PIMAGEHLP_MODULE* = ptr IMAGEHLP_MODULE
    IMAGEHLP_MODULEW* {.pure.} = object
      SizeOfStruct*: DWORD
      BaseOfImage*: DWORD
      ImageSize*: DWORD
      TimeDateStamp*: DWORD
      CheckSum*: DWORD
      NumSyms*: DWORD
      SymType*: SYM_TYPE
      ModuleName*: array[32, WCHAR]
      ImageName*: array[256, WCHAR]
      LoadedImageName*: array[256, WCHAR]
    PIMAGEHLP_MODULEW* = ptr IMAGEHLP_MODULEW
    IMAGEHLP_LINE* {.pure.} = object
      SizeOfStruct*: DWORD
      Key*: PVOID
      LineNumber*: DWORD
      FileName*: PCHAR
      Address*: DWORD
    PIMAGEHLP_LINE* = ptr IMAGEHLP_LINE
    IMAGEHLP_DEFERRED_SYMBOL_LOAD* {.pure.} = object
      SizeOfStruct*: DWORD
      BaseOfImage*: DWORD
      CheckSum*: DWORD
      TimeDateStamp*: DWORD
      FileName*: array[MAX_PATH, CHAR]
      Reparse*: BOOLEAN
      hFile*: HANDLE
    PIMAGEHLP_DEFERRED_SYMBOL_LOAD* = ptr IMAGEHLP_DEFERRED_SYMBOL_LOAD
    IMAGEHLP_DUPLICATE_SYMBOL* {.pure.} = object
      SizeOfStruct*: DWORD
      NumberOfDups*: DWORD
      Symbol*: PIMAGEHLP_SYMBOL
      SelectedSymbol*: DWORD
    PIMAGEHLP_DUPLICATE_SYMBOL* = ptr IMAGEHLP_DUPLICATE_SYMBOL
    PREAD_PROCESS_MEMORY_ROUTINE* = proc (hProcess: HANDLE, lpBaseAddress: DWORD, lpBuffer: PVOID, nSize: DWORD, lpNumberOfBytesRead: PDWORD): WINBOOL {.stdcall.}
    PFUNCTION_TABLE_ACCESS_ROUTINE* = proc (hProcess: HANDLE, AddrBase: DWORD): PVOID {.stdcall.}
    PGET_MODULE_BASE_ROUTINE* = proc (hProcess: HANDLE, Address: DWORD): DWORD {.stdcall.}
    PTRANSLATE_ADDRESS_ROUTINE* = proc (hProcess: HANDLE, hThread: HANDLE, lpaddr: LPADDRESS): DWORD {.stdcall.}
    PSYMBOL_FUNCENTRY_CALLBACK* = proc (hProcess: HANDLE, AddrBase: DWORD, UserContext: PVOID): PVOID {.stdcall.}
    PSYM_ENUMMODULES_CALLBACK* = proc (ModuleName: PCSTR, BaseOfDll: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
    PSYM_ENUMSYMBOLS_CALLBACK* = proc (SymbolName: PCSTR, SymbolAddress: ULONG, SymbolSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
    PSYM_ENUMSYMBOLS_CALLBACKW* = proc (SymbolName: PCWSTR, SymbolAddress: ULONG, SymbolSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
    PENUMLOADED_MODULES_CALLBACK* = proc (ModuleName: PCSTR, ModuleBase: ULONG, ModuleSize: ULONG, UserContext: PVOID): WINBOOL {.stdcall.}
    PSYMBOL_REGISTERED_CALLBACK* = proc (hProcess: HANDLE, ActionCode: ULONG, CallbackData: PVOID, UserContext: PVOID): WINBOOL {.stdcall.}
  proc StackWalk*(MachineType: DWORD, hProcess: HANDLE, hThread: HANDLE, StackFrame: LPSTACKFRAME, ContextRecord: PVOID, ReadMemoryRoutine: PREAD_PROCESS_MEMORY_ROUTINE, FunctionTableAccessRoutine: PFUNCTION_TABLE_ACCESS_ROUTINE, GetModuleBaseRoutine: PGET_MODULE_BASE_ROUTINE, TranslateAddress: PTRANSLATE_ADDRESS_ROUTINE): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymEnumerateModules*(hProcess: HANDLE, EnumModulesCallback: PSYM_ENUMMODULES_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymEnumerateSymbols*(hProcess: HANDLE, BaseOfDll: DWORD, EnumSymbolsCallback: PSYM_ENUMSYMBOLS_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymEnumerateSymbolsW*(hProcess: HANDLE, BaseOfDll: DWORD, EnumSymbolsCallback: PSYM_ENUMSYMBOLS_CALLBACKW, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc EnumerateLoadedModules*(hProcess: HANDLE, EnumLoadedModulesCallback: PENUMLOADED_MODULES_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymFunctionTableAccess*(hProcess: HANDLE, AddrBase: DWORD): PVOID {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetModuleInfo*(hProcess: HANDLE, dwAddr: DWORD, ModuleInfo: PIMAGEHLP_MODULE): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetModuleInfoW*(hProcess: HANDLE, dwAddr: DWORD, ModuleInfo: PIMAGEHLP_MODULEW): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetModuleBase*(hProcess: HANDLE, dwAddr: DWORD): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetSymNext*(hProcess: HANDLE, Symbol: PIMAGEHLP_SYMBOL): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetSymPrev*(hProcess: HANDLE, Symbol: PIMAGEHLP_SYMBOL): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetLineFromAddr*(hProcess: HANDLE, dwAddr: DWORD, pdwDisplacement: PDWORD, Line: PIMAGEHLP_LINE): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetLineFromName*(hProcess: HANDLE, ModuleName: PCSTR, FileName: PCSTR, dwLineNumber: DWORD, plDisplacement: PLONG, Line: PIMAGEHLP_LINE): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetLineNext*(hProcess: HANDLE, Line: PIMAGEHLP_LINE): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetLinePrev*(hProcess: HANDLE, Line: PIMAGEHLP_LINE): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymLoadModule*(hProcess: HANDLE, hFile: HANDLE, ImageName: PCSTR, ModuleName: PCSTR, BaseOfDll: DWORD, SizeOfDll: DWORD): DWORD {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymUnloadModule*(hProcess: HANDLE, BaseOfDll: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymUnDName*(sym: PIMAGEHLP_SYMBOL, UnDecName: PSTR, UnDecNameLength: DWORD): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymRegisterCallback*(hProcess: HANDLE, CallbackFunction: PSYMBOL_REGISTERED_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymRegisterFunctionEntryCallback*(hProcess: HANDLE, CallbackFunction: PSYMBOL_FUNCENTRY_CALLBACK, UserContext: PVOID): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetSymFromAddr*(hProcess: HANDLE, dwAddr: DWORD, pdwDisplacement: PDWORD, Symbol: PIMAGEHLP_SYMBOL): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
  proc SymGetSymFromName*(hProcess: HANDLE, Name: PCSTR, Symbol: PIMAGEHLP_SYMBOL): WINBOOL {.winapi, stdcall, dynlib: "dbghelp", importc.}
