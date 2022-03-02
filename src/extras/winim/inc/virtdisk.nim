#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
#include <virtdisk.h>
type
  ATTACH_VIRTUAL_DISK_FLAG* = int32
  ATTACH_VIRTUAL_DISK_VERSION* = int32
  COMPACT_VIRTUAL_DISK_FLAG* = int32
  COMPACT_VIRTUAL_DISK_VERSION* = int32
  CREATE_VIRTUAL_DISK_FLAG* = int32
  CREATE_VIRTUAL_DISK_VERSION* = int32
  DEPENDENT_DISK_FLAG* = int32
  EXPAND_VIRTUAL_DISK_VERSION* = int32
  DETACH_VIRTUAL_DISK_FLAG* = int32
  EXPAND_VIRTUAL_DISK_FLAG* = int32
  GET_STORAGE_DEPENDENCY_FLAG* = int32
  GET_VIRTUAL_DISK_INFO_VERSION* = int32
  MERGE_VIRTUAL_DISK_FLAG* = int32
  MERGE_VIRTUAL_DISK_VERSION* = int32
  OPEN_VIRTUAL_DISK_FLAG* = int32
  OPEN_VIRTUAL_DISK_VERSION* = int32
  SET_VIRTUAL_DISK_INFO_VERSION* = int32
  STORAGE_DEPENDENCY_INFO_VERSION* = int32
  VIRTUAL_DISK_ACCESS_MASK* = int32
  VIRTUAL_STORAGE_TYPE* {.pure.} = object
    DeviceId*: ULONG
    VendorId*: GUID
  PVIRTUAL_STORAGE_TYPE* = ptr VIRTUAL_STORAGE_TYPE
  ATTACH_VIRTUAL_DISK_PARAMETERS_UNION1_Version1* {.pure.} = object
    Reserved*: ULONG
  ATTACH_VIRTUAL_DISK_PARAMETERS_UNION1* {.pure, union.} = object
    Version1*: ATTACH_VIRTUAL_DISK_PARAMETERS_UNION1_Version1
  ATTACH_VIRTUAL_DISK_PARAMETERS* {.pure.} = object
    Version*: ATTACH_VIRTUAL_DISK_VERSION
    union1*: ATTACH_VIRTUAL_DISK_PARAMETERS_UNION1
  PATTACH_VIRTUAL_DISK_PARAMETERS* = ptr ATTACH_VIRTUAL_DISK_PARAMETERS
  COMPACT_VIRTUAL_DISK_PARAMETERS_UNION1_Version1* {.pure.} = object
    Reserved*: ULONG
  COMPACT_VIRTUAL_DISK_PARAMETERS_UNION1* {.pure, union.} = object
    Version1*: COMPACT_VIRTUAL_DISK_PARAMETERS_UNION1_Version1
  COMPACT_VIRTUAL_DISK_PARAMETERS* {.pure.} = object
    Version*: COMPACT_VIRTUAL_DISK_VERSION
    union1*: COMPACT_VIRTUAL_DISK_PARAMETERS_UNION1
  PCOMPACT_VIRTUAL_DISK_PARAMETERS* = ptr COMPACT_VIRTUAL_DISK_PARAMETERS
  CREATE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1* {.pure.} = object
    UniqueId*: GUID
    MaximumSize*: ULONGLONG
    BlockSizeInBytes*: ULONG
    SectorSizeInBytes*: ULONG
    ParentPath*: PCWSTR
    SourcePath*: PCWSTR
  CREATE_VIRTUAL_DISK_PARAMETERS_UNION1* {.pure, union.} = object
    Version1*: CREATE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1
  CREATE_VIRTUAL_DISK_PARAMETERS* {.pure.} = object
    Version*: CREATE_VIRTUAL_DISK_VERSION
    union1*: CREATE_VIRTUAL_DISK_PARAMETERS_UNION1
  PCREATE_VIRTUAL_DISK_PARAMETERS* = ptr CREATE_VIRTUAL_DISK_PARAMETERS
  EXPAND_VIRTUAL_DISK_PARAMETERS_UNION1_Version1* {.pure.} = object
    NewSize*: ULONGLONG
  EXPAND_VIRTUAL_DISK_PARAMETERS_UNION1* {.pure, union.} = object
    Version1*: EXPAND_VIRTUAL_DISK_PARAMETERS_UNION1_Version1
  EXPAND_VIRTUAL_DISK_PARAMETERS* {.pure.} = object
    Version*: EXPAND_VIRTUAL_DISK_VERSION
    union1*: EXPAND_VIRTUAL_DISK_PARAMETERS_UNION1
  PEXPAND_VIRTUAL_DISK_PARAMETERS* = ptr EXPAND_VIRTUAL_DISK_PARAMETERS
  GET_VIRTUAL_DISK_INFO_UNION1_Size* {.pure.} = object
    VirtualSize*: ULONGLONG
    PhysicalSize*: ULONGLONG
    BlockSize*: ULONG
    SectorSize*: ULONG
  GET_VIRTUAL_DISK_INFO_UNION1_ParentLocation* {.pure.} = object
    ParentResolved*: BOOL
    ParentLocationBuffer*: array[1, WCHAR]
  GET_VIRTUAL_DISK_INFO_UNION1* {.pure, union.} = object
    Size*: GET_VIRTUAL_DISK_INFO_UNION1_Size
    Identifier*: GUID
    ParentLocation*: GET_VIRTUAL_DISK_INFO_UNION1_ParentLocation
    ParentIdentifier*: GUID
    ParentTimestamp*: ULONG
    VirtualStorageType*: VIRTUAL_STORAGE_TYPE
    ProviderSubtype*: ULONG
  GET_VIRTUAL_DISK_INFO* {.pure.} = object
    Version*: GET_VIRTUAL_DISK_INFO_VERSION
    union1*: GET_VIRTUAL_DISK_INFO_UNION1
  PGET_VIRTUAL_DISK_INFO* = ptr GET_VIRTUAL_DISK_INFO
  MERGE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1* {.pure.} = object
    MergeDepth*: ULONG
  MERGE_VIRTUAL_DISK_PARAMETERS_UNION1* {.pure, union.} = object
    Version1*: MERGE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1
  MERGE_VIRTUAL_DISK_PARAMETERS* {.pure.} = object
    Version*: MERGE_VIRTUAL_DISK_VERSION
    union1*: MERGE_VIRTUAL_DISK_PARAMETERS_UNION1
  PMERGE_VIRTUAL_DISK_PARAMETERS* = ptr MERGE_VIRTUAL_DISK_PARAMETERS
  OPEN_VIRTUAL_DISK_PARAMETERS_UNION1_Version1* {.pure.} = object
    RWDepth*: ULONG
  OPEN_VIRTUAL_DISK_PARAMETERS_UNION1* {.pure, union.} = object
    Version1*: OPEN_VIRTUAL_DISK_PARAMETERS_UNION1_Version1
  OPEN_VIRTUAL_DISK_PARAMETERS* {.pure.} = object
    Version*: OPEN_VIRTUAL_DISK_VERSION
    union1*: OPEN_VIRTUAL_DISK_PARAMETERS_UNION1
  POPEN_VIRTUAL_DISK_PARAMETERS* = ptr OPEN_VIRTUAL_DISK_PARAMETERS
  SET_VIRTUAL_DISK_INFO_UNION1* {.pure, union.} = object
    ParentFilePath*: PCWSTR
    UniqueIdentifier*: GUID
  SET_VIRTUAL_DISK_INFO* {.pure.} = object
    Version*: SET_VIRTUAL_DISK_INFO_VERSION
    union1*: SET_VIRTUAL_DISK_INFO_UNION1
  PSET_VIRTUAL_DISK_INFO* = ptr SET_VIRTUAL_DISK_INFO
  STORAGE_DEPENDENCY_INFO_TYPE_1* {.pure.} = object
    DependencyTypeFlags*: DEPENDENT_DISK_FLAG
    ProviderSpecificFlags*: ULONG
    VirtualStorageType*: VIRTUAL_STORAGE_TYPE
  PSTORAGE_DEPENDENCY_INFO_TYPE_1* = ptr STORAGE_DEPENDENCY_INFO_TYPE_1
  STORAGE_DEPENDENCY_INFO_TYPE_2* {.pure.} = object
    DependencyTypeFlags*: DEPENDENT_DISK_FLAG
    ProviderSpecificFlags*: ULONG
    VirtualStorageType*: VIRTUAL_STORAGE_TYPE
    AncestorLevel*: ULONG
    DependencyDeviceName*: PWSTR
    HostVolumeName*: PWSTR
    DependentVolumeName*: PWSTR
    DependentVolumeRelativePath*: PWSTR
  PSTORAGE_DEPENDENCY_INFO_TYPE_2* = ptr STORAGE_DEPENDENCY_INFO_TYPE_2
  STORAGE_DEPENDENCY_INFO_UNION1* {.pure, union.} = object
    Version1Entries*: array[1, STORAGE_DEPENDENCY_INFO_TYPE_1]
    Version2Entries*: array[1, STORAGE_DEPENDENCY_INFO_TYPE_2]
  STORAGE_DEPENDENCY_INFO* {.pure.} = object
    Version*: STORAGE_DEPENDENCY_INFO_VERSION
    NumberEntries*: ULONG
    union1*: STORAGE_DEPENDENCY_INFO_UNION1
  PSTORAGE_DEPENDENCY_INFO* = ptr STORAGE_DEPENDENCY_INFO
  VIRTUAL_DISK_PROGRESS* {.pure.} = object
    OperationStatus*: DWORD
    CurrentValue*: ULONGLONG
    CompletionValue*: ULONGLONG
  PVIRTUAL_DISK_PROGRESS* = ptr VIRTUAL_DISK_PROGRESS
const
  ATTACH_VIRTUAL_DISK_FLAG_NONE* = 0x00000000
  ATTACH_VIRTUAL_DISK_FLAG_READ_ONLY* = 0x00000001
  ATTACH_VIRTUAL_DISK_FLAG_NO_DRIVE_LETTER* = 0x00000002
  ATTACH_VIRTUAL_DISK_FLAG_PERMANENT_LIFETIME* = 0x00000004
  ATTACH_VIRTUAL_DISK_FLAG_NO_LOCAL_HOST* = 0x00000008
  ATTACH_VIRTUAL_DISK_VERSION_UNSPECIFIED* = 0
  ATTACH_VIRTUAL_DISK_VERSION_1* = 1
  COMPACT_VIRTUAL_DISK_FLAG_NONE* = 0x00000000
  COMPACT_VIRTUAL_DISK_VERSION_UNSPECIFIED* = 0
  COMPACT_VIRTUAL_DISK_VERSION_1* = 1
  CREATE_VIRTUAL_DISK_FLAG_NONE* = 0x00000000
  CREATE_VIRTUAL_DISK_FLAG_FULL_PHYSICAL_ALLOCATION* = 0x00000001
  CREATE_VIRTUAL_DISK_VERSION_UNSPECIFIED* = 0
  CREATE_VIRTUAL_DISK_VERSION_1* = 1
  DEPENDENT_DISK_FLAG_NONE* = 0x00000000
  DEPENDENT_DISK_FLAG_MULT_BACKING_FILES* = 0x00000001
  DEPENDENT_DISK_FLAG_FULLY_ALLOCATED* = 0x00000002
  DEPENDENT_DISK_FLAG_READ_ONLY* = 0x00000004
  DEPENDENT_DISK_FLAG_REMOTE* = 0x00000008
  DEPENDENT_DISK_FLAG_SYSTEM_VOLUME* = 0x00000010
  DEPENDENT_DISK_FLAG_SYSTEM_VOLUME_PARENT* = 0x00000020
  DEPENDENT_DISK_FLAG_REMOVABLE* = 0x00000040
  DEPENDENT_DISK_FLAG_NO_DRIVE_LETTER* = 0x00000080
  DEPENDENT_DISK_FLAG_PARENT* = 0x00000100
  DEPENDENT_DISK_FLAG_NO_HOST_DISK* = 0x00000200
  DEPENDENT_DISK_FLAG_PERMANENT_LIFETIME* = 0x00000400
  EXPAND_VIRTUAL_DISK_VERSION_UNSPECIFIED* = 0
  EXPAND_VIRTUAL_DISK_VERSION_1* = 1
  DETACH_VIRTUAL_DISK_FLAG_NONE* = 0x00000000
  EXPAND_VIRTUAL_DISK_FLAG_NONE* = 0x00000000
  GET_STORAGE_DEPENDENCY_FLAG_NONE* = 0x00000000
  GET_STORAGE_DEPENDENCY_FLAG_HOST_VOLUMES* = 0x00000001
  GET_STORAGE_DEPENDENCY_FLAG_DISK_HANDLE* = 0x00000002
  GET_VIRTUAL_DISK_INFO_UNSPECIFIED* = 0
  GET_VIRTUAL_DISK_INFO_SIZE* = 1
  GET_VIRTUAL_DISK_INFO_IDENTIFIER* = 2
  GET_VIRTUAL_DISK_INFO_PARENT_LOCATION* = 3
  GET_VIRTUAL_DISK_INFO_PARENT_IDENTIFIER* = 4
  GET_VIRTUAL_DISK_INFO_PARENT_TIMESTAMP* = 5
  GET_VIRTUAL_DISK_INFO_VIRTUAL_STORAGE_TYPE* = 6
  GET_VIRTUAL_DISK_INFO_PROVIDER_SUBTYPE* = 7
  MERGE_VIRTUAL_DISK_FLAG_NONE* = 0x00000000
  MERGE_VIRTUAL_DISK_VERSION_UNSPECIFIED* = 0
  MERGE_VIRTUAL_DISK_VERSION_1* = 1
  OPEN_VIRTUAL_DISK_FLAG_NONE* = 0x00000000
  OPEN_VIRTUAL_DISK_FLAG_NO_PARENTS* = 0x00000001
  OPEN_VIRTUAL_DISK_FLAG_BLANK_FILE* = 0x00000002
  OPEN_VIRTUAL_DISK_FLAG_BOOT_DRIVE* = 0x00000004
  OPEN_VIRTUAL_DISK_VERSION_UNSPECIFIED* = 0
  OPEN_VIRTUAL_DISK_VERSION_1* = 1
  SET_VIRTUAL_DISK_INFO_UNSPECIFIED* = 0
  SET_VIRTUAL_DISK_INFO_PARENT_PATH* = 1
  SET_VIRTUAL_DISK_INFO_IDENTIFIER* = 2
  STORAGE_DEPENDENCY_INFO_VERSION_UNSPECIFIED* = 0
  STORAGE_DEPENDENCY_INFO_VERSION_1* = 1
  STORAGE_DEPENDENCY_INFO_VERSION_2* = 2
  VIRTUAL_DISK_ACCESS_ATTACH_RO* = 0x00010000
  VIRTUAL_DISK_ACCESS_ATTACH_RW* = 0x00020000
  VIRTUAL_DISK_ACCESS_DETACH* = 0x00040000
  VIRTUAL_DISK_ACCESS_GET_INFO* = 0x00080000
  VIRTUAL_DISK_ACCESS_CREATE* = 0x00100000
  VIRTUAL_DISK_ACCESS_METAOPS* = 0x00200000
  VIRTUAL_DISK_ACCESS_READ* = 0x000d0000
  VIRTUAL_DISK_ACCESS_ALL* = 0x003f0000
  VIRTUAL_DISK_ACCESS_WRITABLE* = 0x00320000
  VIRTUAL_STORAGE_TYPE_DEVICE_UNKNOWN* = 0
  VIRTUAL_STORAGE_TYPE_DEVICE_ISO* = 1
  VIRTUAL_STORAGE_TYPE_DEVICE_VHD* = 2
  VIRTUAL_STORAGE_TYPE_VENDOR_MICROSOFT* = DEFINE_GUID("ec984aec-a0f9-47e9-901f-71415a66345b")
proc AttachVirtualDisk*(VirtualDiskHandle: HANDLE, SecurityDescriptor: PSECURITY_DESCRIPTOR, Flags: ATTACH_VIRTUAL_DISK_FLAG, ProviderSpecificFlags: ULONG, Parameters: PATTACH_VIRTUAL_DISK_PARAMETERS, Overlapped: LPOVERLAPPED): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc CompactVirtualDisk*(VirtualDiskHandle: HANDLE, Flags: COMPACT_VIRTUAL_DISK_FLAG, Parameters: PCOMPACT_VIRTUAL_DISK_PARAMETERS, Overlapped: LPOVERLAPPED): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc CreateVirtualDisk*(VirtualStorageType: PVIRTUAL_STORAGE_TYPE, Path: PCWSTR, VirtualDiskAccessMask: VIRTUAL_DISK_ACCESS_MASK, SecurityDescriptor: PSECURITY_DESCRIPTOR, Flags: CREATE_VIRTUAL_DISK_FLAG, ProviderSpecificFlags: ULONG, Parameters: PCREATE_VIRTUAL_DISK_PARAMETERS, Overlapped: LPOVERLAPPED, Handle: PHANDLE): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc DetachVirtualDisk*(VirtualDiskHandle: HANDLE, Flags: DETACH_VIRTUAL_DISK_FLAG, ProviderSpecificFlags: ULONG): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc ExpandVirtualDisk*(VirtualDiskHandle: HANDLE, Flags: EXPAND_VIRTUAL_DISK_FLAG, Parameters: PEXPAND_VIRTUAL_DISK_PARAMETERS, Overlapped: LPOVERLAPPED): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc GetStorageDependencyInformation*(ObjectHandle: HANDLE, Flags: GET_STORAGE_DEPENDENCY_FLAG, StorageDependencyInfoSize: ULONG, StorageDependencyInfo: PSTORAGE_DEPENDENCY_INFO, SizeUsed: PULONG): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc GetVirtualDiskInformation*(VirtualDiskHandle: HANDLE, VirtualDiskInfoSize: PULONG, VirtualDiskInfo: PGET_VIRTUAL_DISK_INFO, SizeUsed: PULONG): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc GetVirtualDiskOperationProgress*(VirtualDiskHandle: HANDLE, Overlapped: LPOVERLAPPED, Progress: PVIRTUAL_DISK_PROGRESS): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc GetVirtualDiskPhysicalPath*(VirtualDiskHandle: HANDLE, DiskPathSizeInBytes: PULONG, DiskPath: PWSTR): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc MergeVirtualDisk*(VirtualDiskHandle: HANDLE, Flags: MERGE_VIRTUAL_DISK_FLAG, Parameters: PMERGE_VIRTUAL_DISK_PARAMETERS, Overlapped: LPOVERLAPPED): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc OpenVirtualDisk*(VirtualStorageType: PVIRTUAL_STORAGE_TYPE, Path: PCWSTR, VirtualDiskAccessMask: VIRTUAL_DISK_ACCESS_MASK, Flags: OPEN_VIRTUAL_DISK_FLAG, Parameters: POPEN_VIRTUAL_DISK_PARAMETERS, Handle: PHANDLE): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc SetVirtualDiskInformation*(VirtualDiskHandle: HANDLE, VirtualDiskInfo: PSET_VIRTUAL_DISK_INFO): DWORD {.winapi, stdcall, dynlib: "virtdisk", importc.}
proc `Version1=`*(self: var ATTACH_VIRTUAL_DISK_PARAMETERS, x: ATTACH_VIRTUAL_DISK_PARAMETERS_UNION1_Version1) {.inline.} = self.union1.Version1 = x
proc Version1*(self: ATTACH_VIRTUAL_DISK_PARAMETERS): ATTACH_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc Version1*(self: var ATTACH_VIRTUAL_DISK_PARAMETERS): var ATTACH_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc `Version1=`*(self: var COMPACT_VIRTUAL_DISK_PARAMETERS, x: COMPACT_VIRTUAL_DISK_PARAMETERS_UNION1_Version1) {.inline.} = self.union1.Version1 = x
proc Version1*(self: COMPACT_VIRTUAL_DISK_PARAMETERS): COMPACT_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc Version1*(self: var COMPACT_VIRTUAL_DISK_PARAMETERS): var COMPACT_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc `Version1=`*(self: var CREATE_VIRTUAL_DISK_PARAMETERS, x: CREATE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1) {.inline.} = self.union1.Version1 = x
proc Version1*(self: CREATE_VIRTUAL_DISK_PARAMETERS): CREATE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc Version1*(self: var CREATE_VIRTUAL_DISK_PARAMETERS): var CREATE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc `Version1=`*(self: var EXPAND_VIRTUAL_DISK_PARAMETERS, x: EXPAND_VIRTUAL_DISK_PARAMETERS_UNION1_Version1) {.inline.} = self.union1.Version1 = x
proc Version1*(self: EXPAND_VIRTUAL_DISK_PARAMETERS): EXPAND_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc Version1*(self: var EXPAND_VIRTUAL_DISK_PARAMETERS): var EXPAND_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc `Identifier=`*(self: var GET_VIRTUAL_DISK_INFO, x: GUID) {.inline.} = self.union1.Identifier = x
proc Identifier*(self: GET_VIRTUAL_DISK_INFO): GUID {.inline.} = self.union1.Identifier
proc Identifier*(self: var GET_VIRTUAL_DISK_INFO): var GUID {.inline.} = self.union1.Identifier
proc `ParentLocation=`*(self: var GET_VIRTUAL_DISK_INFO, x: GET_VIRTUAL_DISK_INFO_UNION1_ParentLocation) {.inline.} = self.union1.ParentLocation = x
proc ParentLocation*(self: GET_VIRTUAL_DISK_INFO): GET_VIRTUAL_DISK_INFO_UNION1_ParentLocation {.inline.} = self.union1.ParentLocation
proc ParentLocation*(self: var GET_VIRTUAL_DISK_INFO): var GET_VIRTUAL_DISK_INFO_UNION1_ParentLocation {.inline.} = self.union1.ParentLocation
proc `ParentIdentifier=`*(self: var GET_VIRTUAL_DISK_INFO, x: GUID) {.inline.} = self.union1.ParentIdentifier = x
proc ParentIdentifier*(self: GET_VIRTUAL_DISK_INFO): GUID {.inline.} = self.union1.ParentIdentifier
proc ParentIdentifier*(self: var GET_VIRTUAL_DISK_INFO): var GUID {.inline.} = self.union1.ParentIdentifier
proc `ParentTimestamp=`*(self: var GET_VIRTUAL_DISK_INFO, x: ULONG) {.inline.} = self.union1.ParentTimestamp = x
proc ParentTimestamp*(self: GET_VIRTUAL_DISK_INFO): ULONG {.inline.} = self.union1.ParentTimestamp
proc ParentTimestamp*(self: var GET_VIRTUAL_DISK_INFO): var ULONG {.inline.} = self.union1.ParentTimestamp
proc `ProviderSubtype=`*(self: var GET_VIRTUAL_DISK_INFO, x: ULONG) {.inline.} = self.union1.ProviderSubtype = x
proc ProviderSubtype*(self: GET_VIRTUAL_DISK_INFO): ULONG {.inline.} = self.union1.ProviderSubtype
proc ProviderSubtype*(self: var GET_VIRTUAL_DISK_INFO): var ULONG {.inline.} = self.union1.ProviderSubtype
proc `Version1=`*(self: var MERGE_VIRTUAL_DISK_PARAMETERS, x: MERGE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1) {.inline.} = self.union1.Version1 = x
proc Version1*(self: MERGE_VIRTUAL_DISK_PARAMETERS): MERGE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc Version1*(self: var MERGE_VIRTUAL_DISK_PARAMETERS): var MERGE_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc `Version1=`*(self: var OPEN_VIRTUAL_DISK_PARAMETERS, x: OPEN_VIRTUAL_DISK_PARAMETERS_UNION1_Version1) {.inline.} = self.union1.Version1 = x
proc Version1*(self: OPEN_VIRTUAL_DISK_PARAMETERS): OPEN_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc Version1*(self: var OPEN_VIRTUAL_DISK_PARAMETERS): var OPEN_VIRTUAL_DISK_PARAMETERS_UNION1_Version1 {.inline.} = self.union1.Version1
proc `ParentFilePath=`*(self: var SET_VIRTUAL_DISK_INFO, x: PCWSTR) {.inline.} = self.union1.ParentFilePath = x
proc ParentFilePath*(self: SET_VIRTUAL_DISK_INFO): PCWSTR {.inline.} = self.union1.ParentFilePath
proc ParentFilePath*(self: var SET_VIRTUAL_DISK_INFO): var PCWSTR {.inline.} = self.union1.ParentFilePath
proc `UniqueIdentifier=`*(self: var SET_VIRTUAL_DISK_INFO, x: GUID) {.inline.} = self.union1.UniqueIdentifier = x
proc UniqueIdentifier*(self: SET_VIRTUAL_DISK_INFO): GUID {.inline.} = self.union1.UniqueIdentifier
proc UniqueIdentifier*(self: var SET_VIRTUAL_DISK_INFO): var GUID {.inline.} = self.union1.UniqueIdentifier
proc `Version1Entries=`*(self: var STORAGE_DEPENDENCY_INFO, x: array[1, STORAGE_DEPENDENCY_INFO_TYPE_1]) {.inline.} = self.union1.Version1Entries = x
proc Version1Entries*(self: STORAGE_DEPENDENCY_INFO): array[1, STORAGE_DEPENDENCY_INFO_TYPE_1] {.inline.} = self.union1.Version1Entries
proc Version1Entries*(self: var STORAGE_DEPENDENCY_INFO): var array[1, STORAGE_DEPENDENCY_INFO_TYPE_1] {.inline.} = self.union1.Version1Entries
proc `Version2Entries=`*(self: var STORAGE_DEPENDENCY_INFO, x: array[1, STORAGE_DEPENDENCY_INFO_TYPE_2]) {.inline.} = self.union1.Version2Entries = x
proc Version2Entries*(self: STORAGE_DEPENDENCY_INFO): array[1, STORAGE_DEPENDENCY_INFO_TYPE_2] {.inline.} = self.union1.Version2Entries
proc Version2Entries*(self: var STORAGE_DEPENDENCY_INFO): var array[1, STORAGE_DEPENDENCY_INFO_TYPE_2] {.inline.} = self.union1.Version2Entries
