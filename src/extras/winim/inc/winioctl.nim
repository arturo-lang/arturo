#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <winioctl.h>
type
  STORAGE_MEDIA_TYPE* = int32
  PSTORAGE_MEDIA_TYPE* = ptr int32
  STORAGE_BUS_TYPE* = int32
  PSTORAGE_BUS_TYPE* = ptr int32
  MEDIA_TYPE* = int32
  PMEDIA_TYPE* = ptr int32
  PARTITION_STYLE* = int32
  DETECTION_TYPE* = int32
  DISK_CACHE_RETENTION_PRIORITY* = int32
  BIN_TYPES* = int32
  ELEMENT_TYPE* = int32
  PELEMENT_TYPE* = ptr int32
  CHANGER_DEVICE_PROBLEM_TYPE* = int32
  PCHANGER_DEVICE_PROBLEM_TYPE* = ptr int32
  STORAGE_PROPERTY_ID* = int32
  PSTORAGE_PROPERTY_ID* = ptr int32
  STORAGE_QUERY_TYPE* = int32
  PSTORAGE_QUERY_TYPE* = ptr int32
  SHRINK_VOLUME_REQUEST_TYPES* = int32
  WRITE_CACHE_TYPE* = int32
  WRITE_CACHE_ENABLE* = int32
  WRITE_CACHE_CHANGE* = int32
  WRITE_THROUGH* = int32
  STORAGE_PORT_CODE_SET* = int32
  PSTORAGE_PORT_CODE_SET* = ptr int32
  DEVICE_DATA_MANAGEMENT_SET_ACTION* = DWORD
  BAD_TRACK_NUMBER* = WORD
  PBAD_TRACK_NUMBER* = ptr WORD
  STORAGE_READ_CAPACITY* {.pure.} = object
    Version*: ULONG
    Size*: ULONG
    BlockLength*: ULONG
    NumberOfBlocks*: LARGE_INTEGER
    DiskLength*: LARGE_INTEGER
  PSTORAGE_READ_CAPACITY* = ptr STORAGE_READ_CAPACITY
  DEVICE_MANAGE_DATA_SET_ATTRIBUTES* {.pure.} = object
    Size*: DWORD
    Action*: DEVICE_DATA_MANAGEMENT_SET_ACTION
    Flags*: DWORD
    ParameterBlockOffset*: DWORD
    ParameterBlockLength*: DWORD
    DataSetRangesOffset*: DWORD
    DataSetRangesLength*: DWORD
  PDEVICE_MANAGE_DATA_SET_ATTRIBUTES* = ptr DEVICE_MANAGE_DATA_SET_ATTRIBUTES
  DEVICE_DATA_SET_RANGE* {.pure.} = object
    StartingOffset*: LONGLONG
    LengthInBytes*: DWORDLONG
  PDEVICE_DATA_SET_RANGE* = ptr DEVICE_DATA_SET_RANGE
  STORAGE_HOTPLUG_INFO* {.pure.} = object
    Size*: DWORD
    MediaRemovable*: BOOLEAN
    MediaHotplug*: BOOLEAN
    DeviceHotplug*: BOOLEAN
    WriteCacheEnableOverride*: BOOLEAN
  PSTORAGE_HOTPLUG_INFO* = ptr STORAGE_HOTPLUG_INFO
  STORAGE_DEVICE_NUMBER* {.pure.} = object
    DeviceType*: DEVICE_TYPE
    DeviceNumber*: DWORD
    PartitionNumber*: DWORD
  PSTORAGE_DEVICE_NUMBER* = ptr STORAGE_DEVICE_NUMBER
  STORAGE_BUS_RESET_REQUEST* {.pure.} = object
    PathId*: BYTE
  PSTORAGE_BUS_RESET_REQUEST* = ptr STORAGE_BUS_RESET_REQUEST
  STORAGE_BREAK_RESERVATION_REQUEST* {.pure.} = object
    Length*: DWORD
    unused*: BYTE
    PathId*: BYTE
    TargetId*: BYTE
    Lun*: BYTE
  PSTORAGE_BREAK_RESERVATION_REQUEST* = ptr STORAGE_BREAK_RESERVATION_REQUEST
  PREVENT_MEDIA_REMOVAL* {.pure.} = object
    PreventMediaRemoval*: BOOLEAN
  PPREVENT_MEDIA_REMOVAL* = ptr PREVENT_MEDIA_REMOVAL
  CLASS_MEDIA_CHANGE_CONTEXT* {.pure.} = object
    MediaChangeCount*: DWORD
    NewState*: DWORD
  PCLASS_MEDIA_CHANGE_CONTEXT* = ptr CLASS_MEDIA_CHANGE_CONTEXT
  TAPE_STATISTICS* {.pure.} = object
    Version*: DWORD
    Flags*: DWORD
    RecoveredWrites*: LARGE_INTEGER
    UnrecoveredWrites*: LARGE_INTEGER
    RecoveredReads*: LARGE_INTEGER
    UnrecoveredReads*: LARGE_INTEGER
    CompressionRatioReads*: BYTE
    CompressionRatioWrites*: BYTE
  PTAPE_STATISTICS* = ptr TAPE_STATISTICS
  TAPE_GET_STATISTICS* {.pure.} = object
    Operation*: DWORD
  PTAPE_GET_STATISTICS* = ptr TAPE_GET_STATISTICS
  DEVICE_MEDIA_INFO_DeviceSpecific_DiskInfo* {.pure.} = object
    Cylinders*: LARGE_INTEGER
    MediaType*: STORAGE_MEDIA_TYPE
    TracksPerCylinder*: DWORD
    SectorsPerTrack*: DWORD
    BytesPerSector*: DWORD
    NumberMediaSides*: DWORD
    MediaCharacteristics*: DWORD
  DEVICE_MEDIA_INFO_DeviceSpecific_RemovableDiskInfo* {.pure.} = object
    Cylinders*: LARGE_INTEGER
    MediaType*: STORAGE_MEDIA_TYPE
    TracksPerCylinder*: DWORD
    SectorsPerTrack*: DWORD
    BytesPerSector*: DWORD
    NumberMediaSides*: DWORD
    MediaCharacteristics*: DWORD
  DEVICE_MEDIA_INFO_DeviceSpecific_TapeInfo_BusSpecificData_ScsiInformation* {.pure.} = object
    MediumType*: BYTE
    DensityCode*: BYTE
  DEVICE_MEDIA_INFO_DeviceSpecific_TapeInfo_BusSpecificData* {.pure, union.} = object
    ScsiInformation*: DEVICE_MEDIA_INFO_DeviceSpecific_TapeInfo_BusSpecificData_ScsiInformation
  DEVICE_MEDIA_INFO_DeviceSpecific_TapeInfo* {.pure.} = object
    MediaType*: STORAGE_MEDIA_TYPE
    MediaCharacteristics*: DWORD
    CurrentBlockSize*: DWORD
    BusType*: STORAGE_BUS_TYPE
    BusSpecificData*: DEVICE_MEDIA_INFO_DeviceSpecific_TapeInfo_BusSpecificData
  DEVICE_MEDIA_INFO_DeviceSpecific* {.pure, union.} = object
    DiskInfo*: DEVICE_MEDIA_INFO_DeviceSpecific_DiskInfo
    RemovableDiskInfo*: DEVICE_MEDIA_INFO_DeviceSpecific_RemovableDiskInfo
    TapeInfo*: DEVICE_MEDIA_INFO_DeviceSpecific_TapeInfo
  DEVICE_MEDIA_INFO* {.pure.} = object
    DeviceSpecific*: DEVICE_MEDIA_INFO_DeviceSpecific
  PDEVICE_MEDIA_INFO* = ptr DEVICE_MEDIA_INFO
  GET_MEDIA_TYPES* {.pure.} = object
    DeviceType*: DWORD
    MediaInfoCount*: DWORD
    MediaInfo*: array[1, DEVICE_MEDIA_INFO]
  PGET_MEDIA_TYPES* = ptr GET_MEDIA_TYPES
  STORAGE_PREDICT_FAILURE* {.pure.} = object
    PredictFailure*: DWORD
    VendorSpecific*: array[512, BYTE]
  PSTORAGE_PREDICT_FAILURE* = ptr STORAGE_PREDICT_FAILURE
  FORMAT_PARAMETERS* {.pure.} = object
    MediaType*: MEDIA_TYPE
    StartCylinderNumber*: DWORD
    EndCylinderNumber*: DWORD
    StartHeadNumber*: DWORD
    EndHeadNumber*: DWORD
  PFORMAT_PARAMETERS* = ptr FORMAT_PARAMETERS
  FORMAT_EX_PARAMETERS* {.pure.} = object
    MediaType*: MEDIA_TYPE
    StartCylinderNumber*: DWORD
    EndCylinderNumber*: DWORD
    StartHeadNumber*: DWORD
    EndHeadNumber*: DWORD
    FormatGapLength*: WORD
    SectorsPerTrack*: WORD
    SectorNumber*: array[1, WORD]
  PFORMAT_EX_PARAMETERS* = ptr FORMAT_EX_PARAMETERS
  DISK_GEOMETRY* {.pure.} = object
    Cylinders*: LARGE_INTEGER
    MediaType*: MEDIA_TYPE
    TracksPerCylinder*: DWORD
    SectorsPerTrack*: DWORD
    BytesPerSector*: DWORD
  PDISK_GEOMETRY* = ptr DISK_GEOMETRY
  PARTITION_INFORMATION* {.pure.} = object
    StartingOffset*: LARGE_INTEGER
    PartitionLength*: LARGE_INTEGER
    HiddenSectors*: DWORD
    PartitionNumber*: DWORD
    PartitionType*: BYTE
    BootIndicator*: BOOLEAN
    RecognizedPartition*: BOOLEAN
    RewritePartition*: BOOLEAN
  PPARTITION_INFORMATION* = ptr PARTITION_INFORMATION
  SET_PARTITION_INFORMATION* {.pure.} = object
    PartitionType*: BYTE
  PSET_PARTITION_INFORMATION* = ptr SET_PARTITION_INFORMATION
  DRIVE_LAYOUT_INFORMATION* {.pure.} = object
    PartitionCount*: DWORD
    Signature*: DWORD
    PartitionEntry*: array[1, PARTITION_INFORMATION]
  PDRIVE_LAYOUT_INFORMATION* = ptr DRIVE_LAYOUT_INFORMATION
  VERIFY_INFORMATION* {.pure.} = object
    StartingOffset*: LARGE_INTEGER
    Length*: DWORD
  PVERIFY_INFORMATION* = ptr VERIFY_INFORMATION
  REASSIGN_BLOCKS* {.pure.} = object
    Reserved*: WORD
    Count*: WORD
    BlockNumber*: array[1, DWORD]
  PREASSIGN_BLOCKS* = ptr REASSIGN_BLOCKS
  REASSIGN_BLOCKS_EX* {.pure, packed.} = object
    Reserved*: WORD
    Count*: WORD
    BlockNumber*: array[1, LARGE_INTEGER]
  PREASSIGN_BLOCKS_EX* = ptr REASSIGN_BLOCKS_EX
  PARTITION_INFORMATION_GPT* {.pure.} = object
    PartitionType*: GUID
    PartitionId*: GUID
    Attributes*: DWORD64
    Name*: array[36, WCHAR]
  PPARTITION_INFORMATION_GPT* = ptr PARTITION_INFORMATION_GPT
  PARTITION_INFORMATION_MBR* {.pure.} = object
    PartitionType*: BYTE
    BootIndicator*: BOOLEAN
    RecognizedPartition*: BOOLEAN
    HiddenSectors*: DWORD
  PPARTITION_INFORMATION_MBR* = ptr PARTITION_INFORMATION_MBR
  SET_PARTITION_INFORMATION_MBR* = SET_PARTITION_INFORMATION
  SET_PARTITION_INFORMATION_GPT* = PARTITION_INFORMATION_GPT
  SET_PARTITION_INFORMATION_EX_UNION1* {.pure, union.} = object
    Mbr*: SET_PARTITION_INFORMATION_MBR
    Gpt*: SET_PARTITION_INFORMATION_GPT
  SET_PARTITION_INFORMATION_EX* {.pure.} = object
    PartitionStyle*: PARTITION_STYLE
    union1*: SET_PARTITION_INFORMATION_EX_UNION1
  PSET_PARTITION_INFORMATION_EX* = ptr SET_PARTITION_INFORMATION_EX
  CREATE_DISK_GPT* {.pure.} = object
    DiskId*: GUID
    MaxPartitionCount*: DWORD
  PCREATE_DISK_GPT* = ptr CREATE_DISK_GPT
  CREATE_DISK_MBR* {.pure.} = object
    Signature*: DWORD
  PCREATE_DISK_MBR* = ptr CREATE_DISK_MBR
  CREATE_DISK_UNION1* {.pure, union.} = object
    Mbr*: CREATE_DISK_MBR
    Gpt*: CREATE_DISK_GPT
  CREATE_DISK* {.pure.} = object
    PartitionStyle*: PARTITION_STYLE
    union1*: CREATE_DISK_UNION1
  PCREATE_DISK* = ptr CREATE_DISK
  GET_LENGTH_INFORMATION* {.pure.} = object
    Length*: LARGE_INTEGER
  PGET_LENGTH_INFORMATION* = ptr GET_LENGTH_INFORMATION
  PARTITION_INFORMATION_EX_UNION1* {.pure, union.} = object
    Mbr*: PARTITION_INFORMATION_MBR
    Gpt*: PARTITION_INFORMATION_GPT
  PARTITION_INFORMATION_EX* {.pure.} = object
    PartitionStyle*: PARTITION_STYLE
    StartingOffset*: LARGE_INTEGER
    PartitionLength*: LARGE_INTEGER
    PartitionNumber*: DWORD
    RewritePartition*: BOOLEAN
    union1*: PARTITION_INFORMATION_EX_UNION1
  PPARTITION_INFORMATION_EX* = ptr PARTITION_INFORMATION_EX
  DRIVE_LAYOUT_INFORMATION_GPT* {.pure.} = object
    DiskId*: GUID
    StartingUsableOffset*: LARGE_INTEGER
    UsableLength*: LARGE_INTEGER
    MaxPartitionCount*: DWORD
  PDRIVE_LAYOUT_INFORMATION_GPT* = ptr DRIVE_LAYOUT_INFORMATION_GPT
  DRIVE_LAYOUT_INFORMATION_MBR* {.pure.} = object
    Signature*: DWORD
  PDRIVE_LAYOUT_INFORMATION_MBR* = ptr DRIVE_LAYOUT_INFORMATION_MBR
  DRIVE_LAYOUT_INFORMATION_EX_UNION1* {.pure, union.} = object
    Mbr*: DRIVE_LAYOUT_INFORMATION_MBR
    Gpt*: DRIVE_LAYOUT_INFORMATION_GPT
  DRIVE_LAYOUT_INFORMATION_EX* {.pure.} = object
    PartitionStyle*: DWORD
    PartitionCount*: DWORD
    union1*: DRIVE_LAYOUT_INFORMATION_EX_UNION1
    PartitionEntry*: array[1, PARTITION_INFORMATION_EX]
  PDRIVE_LAYOUT_INFORMATION_EX* = ptr DRIVE_LAYOUT_INFORMATION_EX
  DISK_INT13_INFO* {.pure.} = object
    DriveSelect*: WORD
    MaxCylinders*: DWORD
    SectorsPerTrack*: WORD
    MaxHeads*: WORD
    NumberDrives*: WORD
  PDISK_INT13_INFO* = ptr DISK_INT13_INFO
  DISK_EX_INT13_INFO* {.pure.} = object
    ExBufferSize*: WORD
    ExFlags*: WORD
    ExCylinders*: DWORD
    ExHeads*: DWORD
    ExSectorsPerTrack*: DWORD
    ExSectorsPerDrive*: DWORD64
    ExSectorSize*: WORD
    ExReserved*: WORD
  PDISK_EX_INT13_INFO* = ptr DISK_EX_INT13_INFO
  DISK_DETECTION_INFO_UNION1_STRUCT1* {.pure.} = object
    Int13*: DISK_INT13_INFO
    ExInt13*: DISK_EX_INT13_INFO
  DISK_DETECTION_INFO_UNION1* {.pure, union.} = object
    struct1*: DISK_DETECTION_INFO_UNION1_STRUCT1
  DISK_DETECTION_INFO* {.pure.} = object
    SizeOfDetectInfo*: DWORD
    DetectionType*: DETECTION_TYPE
    union1*: DISK_DETECTION_INFO_UNION1
  PDISK_DETECTION_INFO* = ptr DISK_DETECTION_INFO
  DISK_PARTITION_INFO_UNION1_Mbr* {.pure.} = object
    Signature*: DWORD
    CheckSum*: DWORD
  DISK_PARTITION_INFO_UNION1_Gpt* {.pure.} = object
    DiskId*: GUID
  DISK_PARTITION_INFO_UNION1* {.pure, union.} = object
    Mbr*: DISK_PARTITION_INFO_UNION1_Mbr
    Gpt*: DISK_PARTITION_INFO_UNION1_Gpt
  DISK_PARTITION_INFO* {.pure.} = object
    SizeOfPartitionInfo*: DWORD
    PartitionStyle*: PARTITION_STYLE
    union1*: DISK_PARTITION_INFO_UNION1
  PDISK_PARTITION_INFO* = ptr DISK_PARTITION_INFO
  DISK_GEOMETRY_EX* {.pure.} = object
    Geometry*: DISK_GEOMETRY
    DiskSize*: LARGE_INTEGER
    Data*: array[1, BYTE]
  PDISK_GEOMETRY_EX* = ptr DISK_GEOMETRY_EX
  DISK_CONTROLLER_NUMBER* {.pure.} = object
    ControllerNumber*: DWORD
    DiskNumber*: DWORD
  PDISK_CONTROLLER_NUMBER* = ptr DISK_CONTROLLER_NUMBER
  DISK_CACHE_INFORMATION_UNION1_ScalarPrefetch* {.pure.} = object
    Minimum*: WORD
    Maximum*: WORD
    MaximumBlocks*: WORD
  DISK_CACHE_INFORMATION_UNION1_BlockPrefetch* {.pure.} = object
    Minimum*: WORD
    Maximum*: WORD
  DISK_CACHE_INFORMATION_UNION1* {.pure, union.} = object
    ScalarPrefetch*: DISK_CACHE_INFORMATION_UNION1_ScalarPrefetch
    BlockPrefetch*: DISK_CACHE_INFORMATION_UNION1_BlockPrefetch
  DISK_CACHE_INFORMATION* {.pure.} = object
    ParametersSavable*: BOOLEAN
    ReadCacheEnabled*: BOOLEAN
    WriteCacheEnabled*: BOOLEAN
    ReadRetentionPriority*: DISK_CACHE_RETENTION_PRIORITY
    WriteRetentionPriority*: DISK_CACHE_RETENTION_PRIORITY
    DisablePrefetchTransferLength*: WORD
    PrefetchScalar*: BOOLEAN
    union1*: DISK_CACHE_INFORMATION_UNION1
  PDISK_CACHE_INFORMATION* = ptr DISK_CACHE_INFORMATION
  DISK_GROW_PARTITION* {.pure.} = object
    PartitionNumber*: DWORD
    BytesToGrow*: LARGE_INTEGER
  PDISK_GROW_PARTITION* = ptr DISK_GROW_PARTITION
  HISTOGRAM_BUCKET* {.pure.} = object
    Reads*: DWORD
    Writes*: DWORD
  PHISTOGRAM_BUCKET* = ptr HISTOGRAM_BUCKET
  DISK_HISTOGRAM* {.pure.} = object
    DiskSize*: LARGE_INTEGER
    Start*: LARGE_INTEGER
    End*: LARGE_INTEGER
    Average*: LARGE_INTEGER
    AverageRead*: LARGE_INTEGER
    AverageWrite*: LARGE_INTEGER
    Granularity*: DWORD
    Size*: DWORD
    ReadCount*: DWORD
    WriteCount*: DWORD
    Histogram*: PHISTOGRAM_BUCKET
  PDISK_HISTOGRAM* = ptr DISK_HISTOGRAM
  DISK_PERFORMANCE* {.pure.} = object
    BytesRead*: LARGE_INTEGER
    BytesWritten*: LARGE_INTEGER
    ReadTime*: LARGE_INTEGER
    WriteTime*: LARGE_INTEGER
    IdleTime*: LARGE_INTEGER
    ReadCount*: DWORD
    WriteCount*: DWORD
    QueueDepth*: DWORD
    SplitCount*: DWORD
    QueryTime*: LARGE_INTEGER
    StorageDeviceNumber*: DWORD
    StorageManagerName*: array[8, WCHAR]
  PDISK_PERFORMANCE* = ptr DISK_PERFORMANCE
  DISK_RECORD* {.pure.} = object
    ByteOffset*: LARGE_INTEGER
    StartTime*: LARGE_INTEGER
    EndTime*: LARGE_INTEGER
    VirtualAddress*: PVOID
    NumberOfBytes*: DWORD
    DeviceNumber*: BYTE
    ReadRequest*: BOOLEAN
  PDISK_RECORD* = ptr DISK_RECORD
  DISK_LOGGING* {.pure.} = object
    Function*: BYTE
    BufferAddress*: PVOID
    BufferSize*: DWORD
  PDISK_LOGGING* = ptr DISK_LOGGING
  BIN_RANGE* {.pure.} = object
    StartValue*: LARGE_INTEGER
    Length*: LARGE_INTEGER
  PBIN_RANGE* = ptr BIN_RANGE
  PERF_BIN* {.pure.} = object
    NumberOfBins*: DWORD
    TypeOfBin*: DWORD
    BinsRanges*: array[1, BIN_RANGE]
  PPERF_BIN* = ptr PERF_BIN
  BIN_COUNT* {.pure.} = object
    BinRange*: BIN_RANGE
    BinCount*: DWORD
  PBIN_COUNT* = ptr BIN_COUNT
  BIN_RESULTS* {.pure.} = object
    NumberOfBins*: DWORD
    BinCounts*: array[1, BIN_COUNT]
  PBIN_RESULTS* = ptr BIN_RESULTS
  GETVERSIONINPARAMS* {.pure.} = object
    bVersion*: BYTE
    bRevision*: BYTE
    bReserved*: BYTE
    bIDEDeviceMap*: BYTE
    fCapabilities*: DWORD
    dwReserved*: array[4, DWORD]
  PGETVERSIONINPARAMS* = ptr GETVERSIONINPARAMS
  LPGETVERSIONINPARAMS* = ptr GETVERSIONINPARAMS
  IDEREGS* {.pure.} = object
    bFeaturesReg*: BYTE
    bSectorCountReg*: BYTE
    bSectorNumberReg*: BYTE
    bCylLowReg*: BYTE
    bCylHighReg*: BYTE
    bDriveHeadReg*: BYTE
    bCommandReg*: BYTE
    bReserved*: BYTE
  PIDEREGS* = ptr IDEREGS
  LPIDEREGS* = ptr IDEREGS
  SENDCMDINPARAMS* {.pure, packed.} = object
    cBufferSize*: DWORD
    irDriveRegs*: IDEREGS
    bDriveNumber*: BYTE
    bReserved*: array[3, BYTE]
    dwReserved*: array[4, DWORD]
    bBuffer*: array[1, BYTE]
  PSENDCMDINPARAMS* = ptr SENDCMDINPARAMS
  LPSENDCMDINPARAMS* = ptr SENDCMDINPARAMS
  DRIVERSTATUS* {.pure.} = object
    bDriverError*: BYTE
    bIDEError*: BYTE
    bReserved*: array[2, BYTE]
    dwReserved*: array[2, DWORD]
  PDRIVERSTATUS* = ptr DRIVERSTATUS
  LPDRIVERSTATUS* = ptr DRIVERSTATUS
  SENDCMDOUTPARAMS* {.pure, packed.} = object
    cBufferSize*: DWORD
    DriverStatus*: DRIVERSTATUS
    bBuffer*: array[1, BYTE]
  PSENDCMDOUTPARAMS* = ptr SENDCMDOUTPARAMS
  LPSENDCMDOUTPARAMS* = ptr SENDCMDOUTPARAMS
  CHANGER_ELEMENT* {.pure.} = object
    ElementType*: ELEMENT_TYPE
    ElementAddress*: DWORD
  PCHANGER_ELEMENT* = ptr CHANGER_ELEMENT
  CHANGER_ELEMENT_LIST* {.pure.} = object
    Element*: CHANGER_ELEMENT
    NumberOfElements*: DWORD
  PCHANGER_ELEMENT_LIST* = ptr CHANGER_ELEMENT_LIST
  GET_CHANGER_PARAMETERS* {.pure.} = object
    Size*: DWORD
    NumberTransportElements*: WORD
    NumberStorageElements*: WORD
    NumberCleanerSlots*: WORD
    NumberIEElements*: WORD
    NumberDataTransferElements*: WORD
    NumberOfDoors*: WORD
    FirstSlotNumber*: WORD
    FirstDriveNumber*: WORD
    FirstTransportNumber*: WORD
    FirstIEPortNumber*: WORD
    FirstCleanerSlotAddress*: WORD
    MagazineSize*: WORD
    DriveCleanTimeout*: DWORD
    Features0*: DWORD
    Features1*: DWORD
    MoveFromTransport*: BYTE
    MoveFromSlot*: BYTE
    MoveFromIePort*: BYTE
    MoveFromDrive*: BYTE
    ExchangeFromTransport*: BYTE
    ExchangeFromSlot*: BYTE
    ExchangeFromIePort*: BYTE
    ExchangeFromDrive*: BYTE
    LockUnlockCapabilities*: BYTE
    PositionCapabilities*: BYTE
    Reserved1*: array[2, BYTE]
    Reserved2*: array[2, DWORD]
  PGET_CHANGER_PARAMETERS* = ptr GET_CHANGER_PARAMETERS
const
  VENDOR_ID_LENGTH* = 8
  PRODUCT_ID_LENGTH* = 16
  REVISION_LENGTH* = 4
  SERIAL_NUMBER_LENGTH* = 32
type
  CHANGER_PRODUCT_DATA* {.pure.} = object
    VendorId*: array[VENDOR_ID_LENGTH, BYTE]
    ProductId*: array[PRODUCT_ID_LENGTH, BYTE]
    Revision*: array[REVISION_LENGTH, BYTE]
    SerialNumber*: array[SERIAL_NUMBER_LENGTH, BYTE]
    DeviceType*: BYTE
  PCHANGER_PRODUCT_DATA* = ptr CHANGER_PRODUCT_DATA
  CHANGER_SET_ACCESS* {.pure.} = object
    Element*: CHANGER_ELEMENT
    Control*: DWORD
  PCHANGER_SET_ACCESS* = ptr CHANGER_SET_ACCESS
  CHANGER_READ_ELEMENT_STATUS* {.pure.} = object
    ElementList*: CHANGER_ELEMENT_LIST
    VolumeTagInfo*: BOOLEAN
  PCHANGER_READ_ELEMENT_STATUS* = ptr CHANGER_READ_ELEMENT_STATUS
const
  MAX_VOLUME_ID_SIZE* = 36
type
  CHANGER_ELEMENT_STATUS* {.pure.} = object
    Element*: CHANGER_ELEMENT
    SrcElementAddress*: CHANGER_ELEMENT
    Flags*: DWORD
    ExceptionCode*: DWORD
    TargetId*: BYTE
    Lun*: BYTE
    Reserved*: WORD
    PrimaryVolumeID*: array[MAX_VOLUME_ID_SIZE, BYTE]
    AlternateVolumeID*: array[MAX_VOLUME_ID_SIZE, BYTE]
  PCHANGER_ELEMENT_STATUS* = ptr CHANGER_ELEMENT_STATUS
  CHANGER_ELEMENT_STATUS_EX* {.pure.} = object
    Element*: CHANGER_ELEMENT
    SrcElementAddress*: CHANGER_ELEMENT
    Flags*: DWORD
    ExceptionCode*: DWORD
    TargetId*: BYTE
    Lun*: BYTE
    Reserved*: WORD
    PrimaryVolumeID*: array[MAX_VOLUME_ID_SIZE, BYTE]
    AlternateVolumeID*: array[MAX_VOLUME_ID_SIZE, BYTE]
    VendorIdentification*: array[VENDOR_ID_LENGTH, BYTE]
    ProductIdentification*: array[PRODUCT_ID_LENGTH, BYTE]
    SerialNumber*: array[SERIAL_NUMBER_LENGTH, BYTE]
  PCHANGER_ELEMENT_STATUS_EX* = ptr CHANGER_ELEMENT_STATUS_EX
  CHANGER_INITIALIZE_ELEMENT_STATUS* {.pure.} = object
    ElementList*: CHANGER_ELEMENT_LIST
    BarCodeScan*: BOOLEAN
  PCHANGER_INITIALIZE_ELEMENT_STATUS* = ptr CHANGER_INITIALIZE_ELEMENT_STATUS
  CHANGER_SET_POSITION* {.pure.} = object
    Transport*: CHANGER_ELEMENT
    Destination*: CHANGER_ELEMENT
    Flip*: BOOLEAN
  PCHANGER_SET_POSITION* = ptr CHANGER_SET_POSITION
  CHANGER_EXCHANGE_MEDIUM* {.pure.} = object
    Transport*: CHANGER_ELEMENT
    Source*: CHANGER_ELEMENT
    Destination1*: CHANGER_ELEMENT
    Destination2*: CHANGER_ELEMENT
    Flip1*: BOOLEAN
    Flip2*: BOOLEAN
  PCHANGER_EXCHANGE_MEDIUM* = ptr CHANGER_EXCHANGE_MEDIUM
  CHANGER_MOVE_MEDIUM* {.pure.} = object
    Transport*: CHANGER_ELEMENT
    Source*: CHANGER_ELEMENT
    Destination*: CHANGER_ELEMENT
    Flip*: BOOLEAN
  PCHANGER_MOVE_MEDIUM* = ptr CHANGER_MOVE_MEDIUM
const
  MAX_VOLUME_TEMPLATE_SIZE* = 40
type
  CHANGER_SEND_VOLUME_TAG_INFORMATION* {.pure.} = object
    StartingElement*: CHANGER_ELEMENT
    ActionCode*: DWORD
    VolumeIDTemplate*: array[MAX_VOLUME_TEMPLATE_SIZE, BYTE]
  PCHANGER_SEND_VOLUME_TAG_INFORMATION* = ptr CHANGER_SEND_VOLUME_TAG_INFORMATION
  READ_ELEMENT_ADDRESS_INFO* {.pure.} = object
    NumberOfElements*: DWORD
    ElementStatus*: array[1, CHANGER_ELEMENT_STATUS]
  PREAD_ELEMENT_ADDRESS_INFO* = ptr READ_ELEMENT_ADDRESS_INFO
  PATHNAME_BUFFER* {.pure.} = object
    PathNameLength*: DWORD
    Name*: array[1, WCHAR]
  PPATHNAME_BUFFER* = ptr PATHNAME_BUFFER
  FSCTL_QUERY_FAT_BPB_BUFFER* {.pure.} = object
    First0x24BytesOfBootSector*: array[0x24, BYTE]
  PFSCTL_QUERY_FAT_BPB_BUFFER* = ptr FSCTL_QUERY_FAT_BPB_BUFFER
  NTFS_VOLUME_DATA_BUFFER* {.pure.} = object
    VolumeSerialNumber*: LARGE_INTEGER
    NumberSectors*: LARGE_INTEGER
    TotalClusters*: LARGE_INTEGER
    FreeClusters*: LARGE_INTEGER
    TotalReserved*: LARGE_INTEGER
    BytesPerSector*: DWORD
    BytesPerCluster*: DWORD
    BytesPerFileRecordSegment*: DWORD
    ClustersPerFileRecordSegment*: DWORD
    MftValidDataLength*: LARGE_INTEGER
    MftStartLcn*: LARGE_INTEGER
    Mft2StartLcn*: LARGE_INTEGER
    MftZoneStart*: LARGE_INTEGER
    MftZoneEnd*: LARGE_INTEGER
  PNTFS_VOLUME_DATA_BUFFER* = ptr NTFS_VOLUME_DATA_BUFFER
  NTFS_EXTENDED_VOLUME_DATA* {.pure.} = object
    ByteCount*: DWORD
    MajorVersion*: WORD
    MinorVersion*: WORD
  PNTFS_EXTENDED_VOLUME_DATA* = ptr NTFS_EXTENDED_VOLUME_DATA
  STARTING_LCN_INPUT_BUFFER* {.pure.} = object
    StartingLcn*: LARGE_INTEGER
  PSTARTING_LCN_INPUT_BUFFER* = ptr STARTING_LCN_INPUT_BUFFER
  VOLUME_BITMAP_BUFFER* {.pure.} = object
    StartingLcn*: LARGE_INTEGER
    BitmapSize*: LARGE_INTEGER
    Buffer*: array[1, BYTE]
  PVOLUME_BITMAP_BUFFER* = ptr VOLUME_BITMAP_BUFFER
  STARTING_VCN_INPUT_BUFFER* {.pure.} = object
    StartingVcn*: LARGE_INTEGER
  PSTARTING_VCN_INPUT_BUFFER* = ptr STARTING_VCN_INPUT_BUFFER
  RETRIEVAL_POINTERS_BUFFER_Extents* {.pure.} = object
    NextVcn*: LARGE_INTEGER
    Lcn*: LARGE_INTEGER
  RETRIEVAL_POINTERS_BUFFER* {.pure.} = object
    ExtentCount*: DWORD
    StartingVcn*: LARGE_INTEGER
    Extents*: array[1, RETRIEVAL_POINTERS_BUFFER_Extents]
  PRETRIEVAL_POINTERS_BUFFER* = ptr RETRIEVAL_POINTERS_BUFFER
  NTFS_FILE_RECORD_INPUT_BUFFER* {.pure.} = object
    FileReferenceNumber*: LARGE_INTEGER
  PNTFS_FILE_RECORD_INPUT_BUFFER* = ptr NTFS_FILE_RECORD_INPUT_BUFFER
  NTFS_FILE_RECORD_OUTPUT_BUFFER* {.pure.} = object
    FileReferenceNumber*: LARGE_INTEGER
    FileRecordLength*: DWORD
    FileRecordBuffer*: array[1, BYTE]
  PNTFS_FILE_RECORD_OUTPUT_BUFFER* = ptr NTFS_FILE_RECORD_OUTPUT_BUFFER
  MOVE_FILE_DATA* {.pure.} = object
    FileHandle*: HANDLE
    StartingVcn*: LARGE_INTEGER
    StartingLcn*: LARGE_INTEGER
    ClusterCount*: DWORD
  PMOVE_FILE_DATA* = ptr MOVE_FILE_DATA
  FIND_BY_SID_DATA* {.pure.} = object
    Restart*: DWORD
    Sid*: SID
  PFIND_BY_SID_DATA* = ptr FIND_BY_SID_DATA
  FIND_BY_SID_OUTPUT* {.pure.} = object
    NextEntryOffset*: DWORD
    FileIndex*: DWORD
    FileNameLength*: DWORD
    FileName*: array[1, WCHAR]
  PFIND_BY_SID_OUTPUT* = ptr FIND_BY_SID_OUTPUT
  MFT_ENUM_DATA* {.pure.} = object
    StartFileReferenceNumber*: DWORDLONG
    LowUsn*: USN
    HighUsn*: USN
  PMFT_ENUM_DATA* = ptr MFT_ENUM_DATA
  CREATE_USN_JOURNAL_DATA* {.pure.} = object
    MaximumSize*: DWORDLONG
    AllocationDelta*: DWORDLONG
  PCREATE_USN_JOURNAL_DATA* = ptr CREATE_USN_JOURNAL_DATA
  READ_USN_JOURNAL_DATA* {.pure.} = object
    StartUsn*: USN
    ReasonMask*: DWORD
    ReturnOnlyOnClose*: DWORD
    Timeout*: DWORDLONG
    BytesToWaitFor*: DWORDLONG
    UsnJournalID*: DWORDLONG
  PREAD_USN_JOURNAL_DATA* = ptr READ_USN_JOURNAL_DATA
  USN_RECORD* {.pure.} = object
    RecordLength*: DWORD
    MajorVersion*: WORD
    MinorVersion*: WORD
    FileReferenceNumber*: DWORDLONG
    ParentFileReferenceNumber*: DWORDLONG
    Usn*: USN
    TimeStamp*: LARGE_INTEGER
    Reason*: DWORD
    SourceInfo*: DWORD
    SecurityId*: DWORD
    FileAttributes*: DWORD
    FileNameLength*: WORD
    FileNameOffset*: WORD
    FileName*: array[1, WCHAR]
  PUSN_RECORD* = ptr USN_RECORD
  USN_JOURNAL_DATA* {.pure.} = object
    UsnJournalID*: DWORDLONG
    FirstUsn*: USN
    NextUsn*: USN
    LowestValidUsn*: USN
    MaxUsn*: USN
    MaximumSize*: DWORDLONG
    AllocationDelta*: DWORDLONG
  PUSN_JOURNAL_DATA* = ptr USN_JOURNAL_DATA
  DELETE_USN_JOURNAL_DATA* {.pure.} = object
    UsnJournalID*: DWORDLONG
    DeleteFlags*: DWORD
  PDELETE_USN_JOURNAL_DATA* = ptr DELETE_USN_JOURNAL_DATA
  MARK_HANDLE_INFO* {.pure.} = object
    UsnSourceInfo*: DWORD
    VolumeHandle*: HANDLE
    HandleInfo*: DWORD
  PMARK_HANDLE_INFO* = ptr MARK_HANDLE_INFO
  BULK_SECURITY_TEST_DATA* {.pure.} = object
    DesiredAccess*: ACCESS_MASK
    SecurityIds*: array[1, DWORD]
  PBULK_SECURITY_TEST_DATA* = ptr BULK_SECURITY_TEST_DATA
  FILE_PREFETCH* {.pure.} = object
    Type*: DWORD
    Count*: DWORD
    Prefetch*: array[1, DWORDLONG]
  PFILE_PREFETCH* = ptr FILE_PREFETCH
  FILESYSTEM_STATISTICS* {.pure.} = object
    FileSystemType*: WORD
    Version*: WORD
    SizeOfCompleteStructure*: DWORD
    UserFileReads*: DWORD
    UserFileReadBytes*: DWORD
    UserDiskReads*: DWORD
    UserFileWrites*: DWORD
    UserFileWriteBytes*: DWORD
    UserDiskWrites*: DWORD
    MetaDataReads*: DWORD
    MetaDataReadBytes*: DWORD
    MetaDataDiskReads*: DWORD
    MetaDataWrites*: DWORD
    MetaDataWriteBytes*: DWORD
    MetaDataDiskWrites*: DWORD
  PFILESYSTEM_STATISTICS* = ptr FILESYSTEM_STATISTICS
  FAT_STATISTICS* {.pure.} = object
    CreateHits*: DWORD
    SuccessfulCreates*: DWORD
    FailedCreates*: DWORD
    NonCachedReads*: DWORD
    NonCachedReadBytes*: DWORD
    NonCachedWrites*: DWORD
    NonCachedWriteBytes*: DWORD
    NonCachedDiskReads*: DWORD
    NonCachedDiskWrites*: DWORD
  PFAT_STATISTICS* = ptr FAT_STATISTICS
  EXFAT_STATISTICS* {.pure.} = object
    CreateHits*: DWORD
    SuccessfulCreates*: DWORD
    FailedCreates*: DWORD
    NonCachedReads*: DWORD
    NonCachedReadBytes*: DWORD
    NonCachedWrites*: DWORD
    NonCachedWriteBytes*: DWORD
    NonCachedDiskReads*: DWORD
    NonCachedDiskWrites*: DWORD
  PEXFAT_STATISTICS* = ptr EXFAT_STATISTICS
  NTFS_STATISTICS_MftWritesUserLevel* {.pure.} = object
    Write*: WORD
    Create*: WORD
    SetInfo*: WORD
    Flush*: WORD
  NTFS_STATISTICS_Mft2WritesUserLevel* {.pure.} = object
    Write*: WORD
    Create*: WORD
    SetInfo*: WORD
    Flush*: WORD
  NTFS_STATISTICS_BitmapWritesUserLevel* {.pure.} = object
    Write*: WORD
    Create*: WORD
    SetInfo*: WORD
  NTFS_STATISTICS_MftBitmapWritesUserLevel* {.pure.} = object
    Write*: WORD
    Create*: WORD
    SetInfo*: WORD
    Flush*: WORD
  NTFS_STATISTICS_Allocate* {.pure.} = object
    Calls*: DWORD
    Clusters*: DWORD
    Hints*: DWORD
    RunsReturned*: DWORD
    HintsHonored*: DWORD
    HintsClusters*: DWORD
    Cache*: DWORD
    CacheClusters*: DWORD
    CacheMiss*: DWORD
    CacheMissClusters*: DWORD
  NTFS_STATISTICS* {.pure.} = object
    LogFileFullExceptions*: DWORD
    OtherExceptions*: DWORD
    MftReads*: DWORD
    MftReadBytes*: DWORD
    MftWrites*: DWORD
    MftWriteBytes*: DWORD
    MftWritesUserLevel*: NTFS_STATISTICS_MftWritesUserLevel
    MftWritesFlushForLogFileFull*: WORD
    MftWritesLazyWriter*: WORD
    MftWritesUserRequest*: WORD
    Mft2Writes*: DWORD
    Mft2WriteBytes*: DWORD
    Mft2WritesUserLevel*: NTFS_STATISTICS_Mft2WritesUserLevel
    Mft2WritesFlushForLogFileFull*: WORD
    Mft2WritesLazyWriter*: WORD
    Mft2WritesUserRequest*: WORD
    RootIndexReads*: DWORD
    RootIndexReadBytes*: DWORD
    RootIndexWrites*: DWORD
    RootIndexWriteBytes*: DWORD
    BitmapReads*: DWORD
    BitmapReadBytes*: DWORD
    BitmapWrites*: DWORD
    BitmapWriteBytes*: DWORD
    BitmapWritesFlushForLogFileFull*: WORD
    BitmapWritesLazyWriter*: WORD
    BitmapWritesUserRequest*: WORD
    BitmapWritesUserLevel*: NTFS_STATISTICS_BitmapWritesUserLevel
    MftBitmapReads*: DWORD
    MftBitmapReadBytes*: DWORD
    MftBitmapWrites*: DWORD
    MftBitmapWriteBytes*: DWORD
    MftBitmapWritesFlushForLogFileFull*: WORD
    MftBitmapWritesLazyWriter*: WORD
    MftBitmapWritesUserRequest*: WORD
    MftBitmapWritesUserLevel*: NTFS_STATISTICS_MftBitmapWritesUserLevel
    UserIndexReads*: DWORD
    UserIndexReadBytes*: DWORD
    UserIndexWrites*: DWORD
    UserIndexWriteBytes*: DWORD
    LogFileReads*: DWORD
    LogFileReadBytes*: DWORD
    LogFileWrites*: DWORD
    LogFileWriteBytes*: DWORD
    Allocate*: NTFS_STATISTICS_Allocate
  PNTFS_STATISTICS* = ptr NTFS_STATISTICS
  FILE_OBJECTID_BUFFER_UNION1_STRUCT1* {.pure.} = object
    BirthVolumeId*: array[16, BYTE]
    BirthObjectId*: array[16, BYTE]
    DomainId*: array[16, BYTE]
  FILE_OBJECTID_BUFFER_UNION1* {.pure, union.} = object
    struct1*: FILE_OBJECTID_BUFFER_UNION1_STRUCT1
    ExtendedInfo*: array[48, BYTE]
  FILE_OBJECTID_BUFFER* {.pure.} = object
    ObjectId*: array[16, BYTE]
    union1*: FILE_OBJECTID_BUFFER_UNION1
  PFILE_OBJECTID_BUFFER* = ptr FILE_OBJECTID_BUFFER
  FILE_SET_SPARSE_BUFFER* {.pure.} = object
    SetSparse*: BOOLEAN
  PFILE_SET_SPARSE_BUFFER* = ptr FILE_SET_SPARSE_BUFFER
  FILE_ZERO_DATA_INFORMATION* {.pure.} = object
    FileOffset*: LARGE_INTEGER
    BeyondFinalZero*: LARGE_INTEGER
  PFILE_ZERO_DATA_INFORMATION* = ptr FILE_ZERO_DATA_INFORMATION
  FILE_ALLOCATED_RANGE_BUFFER* {.pure.} = object
    FileOffset*: LARGE_INTEGER
    Length*: LARGE_INTEGER
  PFILE_ALLOCATED_RANGE_BUFFER* = ptr FILE_ALLOCATED_RANGE_BUFFER
  ENCRYPTION_BUFFER* {.pure.} = object
    EncryptionOperation*: DWORD
    Private*: array[1, BYTE]
  PENCRYPTION_BUFFER* = ptr ENCRYPTION_BUFFER
  DECRYPTION_STATUS_BUFFER* {.pure.} = object
    NoEncryptedStreams*: BOOLEAN
  PDECRYPTION_STATUS_BUFFER* = ptr DECRYPTION_STATUS_BUFFER
  REQUEST_RAW_ENCRYPTED_DATA* {.pure.} = object
    FileOffset*: LONGLONG
    Length*: DWORD
  PREQUEST_RAW_ENCRYPTED_DATA* = ptr REQUEST_RAW_ENCRYPTED_DATA
  ENCRYPTED_DATA_INFO* {.pure.} = object
    StartingFileOffset*: DWORDLONG
    OutputBufferOffset*: DWORD
    BytesWithinFileSize*: DWORD
    BytesWithinValidDataLength*: DWORD
    CompressionFormat*: WORD
    DataUnitShift*: BYTE
    ChunkShift*: BYTE
    ClusterShift*: BYTE
    EncryptionFormat*: BYTE
    NumberOfDataBlocks*: WORD
    DataBlockSize*: array[ANYSIZE_ARRAY, DWORD]
  PENCRYPTED_DATA_INFO* = ptr ENCRYPTED_DATA_INFO
  PLEX_READ_DATA_REQUEST* {.pure.} = object
    ByteOffset*: LARGE_INTEGER
    ByteLength*: DWORD
    PlexNumber*: DWORD
  PPLEX_READ_DATA_REQUEST* = ptr PLEX_READ_DATA_REQUEST
  SI_COPYFILE* {.pure.} = object
    SourceFileNameLength*: DWORD
    DestinationFileNameLength*: DWORD
    Flags*: DWORD
    FileNameBuffer*: array[1, WCHAR]
  PSI_COPYFILE* = ptr SI_COPYFILE
  STORAGE_DESCRIPTOR_HEADER* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
  PSTORAGE_DESCRIPTOR_HEADER* = ptr STORAGE_DESCRIPTOR_HEADER
  STORAGE_PROPERTY_QUERY* {.pure.} = object
    PropertyId*: STORAGE_PROPERTY_ID
    QueryType*: STORAGE_QUERY_TYPE
    AdditionalParameters*: array[1, BYTE]
  PSTORAGE_PROPERTY_QUERY* = ptr STORAGE_PROPERTY_QUERY
  STORAGE_DEVICE_DESCRIPTOR* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
    DeviceType*: BYTE
    DeviceTypeModifier*: BYTE
    RemovableMedia*: BOOLEAN
    CommandQueueing*: BOOLEAN
    VendorIdOffset*: DWORD
    ProductIdOffset*: DWORD
    ProductRevisionOffset*: DWORD
    SerialNumberOffset*: DWORD
    BusType*: STORAGE_BUS_TYPE
    RawPropertiesLength*: DWORD
    RawDeviceProperties*: array[1, BYTE]
  PSTORAGE_DEVICE_DESCRIPTOR* = ptr STORAGE_DEVICE_DESCRIPTOR
  STORAGE_ADAPTER_DESCRIPTOR* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
    MaximumTransferLength*: DWORD
    MaximumPhysicalPages*: DWORD
    AlignmentMask*: DWORD
    AdapterUsesPio*: BOOLEAN
    AdapterScansDown*: BOOLEAN
    CommandQueueing*: BOOLEAN
    AcceleratedTransfer*: BOOLEAN
    BusType*: BYTE
    BusMajorVersion*: WORD
    BusMinorVersion*: WORD
  PSTORAGE_ADAPTER_DESCRIPTOR* = ptr STORAGE_ADAPTER_DESCRIPTOR
  STORAGE_DEVICE_ID_DESCRIPTOR* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
    NumberOfIdentifiers*: DWORD
    Identifiers*: array[1, BYTE]
  PSTORAGE_DEVICE_ID_DESCRIPTOR* = ptr STORAGE_DEVICE_ID_DESCRIPTOR
  VOLUME_GET_GPT_ATTRIBUTES_INFORMATION* {.pure.} = object
    GptAttributes*: ULONGLONG
  PVOLUME_GET_GPT_ATTRIBUTES_INFORMATION* = ptr VOLUME_GET_GPT_ATTRIBUTES_INFORMATION
  FILE_MAKE_COMPATIBLE_BUFFER* {.pure.} = object
    CloseDisc*: BOOLEAN
  PFILE_MAKE_COMPATIBLE_BUFFER* = ptr FILE_MAKE_COMPATIBLE_BUFFER
  FILE_SET_DEFECT_MGMT_BUFFER* {.pure.} = object
    Disable*: BOOLEAN
  PFILE_SET_DEFECT_MGMT_BUFFER* = ptr FILE_SET_DEFECT_MGMT_BUFFER
  FILE_QUERY_SPARING_BUFFER* {.pure.} = object
    SparingUnitBytes*: ULONG
    SoftwareSparing*: BOOLEAN
    TotalSpareBlocks*: ULONG
    FreeSpareBlocks*: ULONG
  PFILE_QUERY_SPARING_BUFFER* = ptr FILE_QUERY_SPARING_BUFFER
  FILE_QUERY_ON_DISK_VOL_INFO_BUFFER* {.pure.} = object
    DirectoryCount*: LARGE_INTEGER
    FileCount*: LARGE_INTEGER
    FsFormatMajVersion*: WORD
    FsFormatMinVersion*: WORD
    FsFormatName*: array[12, WCHAR]
    FormatTime*: LARGE_INTEGER
    LastUpdateTime*: LARGE_INTEGER
    CopyrightInfo*: array[34, WCHAR]
    AbstractInfo*: array[34, WCHAR]
    FormattingImplementationInfo*: array[34, WCHAR]
    LastModifyingImplementationInfo*: array[34, WCHAR]
  PFILE_QUERY_ON_DISK_VOL_INFO_BUFFER* = ptr FILE_QUERY_ON_DISK_VOL_INFO_BUFFER
  SHRINK_VOLUME_INFORMATION* {.pure.} = object
    ShrinkRequestType*: SHRINK_VOLUME_REQUEST_TYPES
    Flags*: DWORDLONG
    NewNumberOfSectors*: LONGLONG
  PSHRINK_VOLUME_INFORMATION* = ptr SHRINK_VOLUME_INFORMATION
  TXFS_MODIFY_RM* {.pure.} = object
    Flags*: ULONG
    LogContainerCountMax*: ULONG
    LogContainerCountMin*: ULONG
    LogContainerCount*: ULONG
    LogGrowthIncrement*: ULONG
    LogAutoShrinkPercentage*: ULONG
    Reserved*: ULONGLONG
    LoggingMode*: USHORT
  PTXFS_MODIFY_RM* = ptr TXFS_MODIFY_RM
  TXFS_QUERY_RM_INFORMATION* {.pure.} = object
    BytesRequired*: ULONG
    TailLsn*: ULONGLONG
    CurrentLsn*: ULONGLONG
    ArchiveTailLsn*: ULONGLONG
    LogContainerSize*: ULONGLONG
    HighestVirtualClock*: LARGE_INTEGER
    LogContainerCount*: ULONG
    LogContainerCountMax*: ULONG
    LogContainerCountMin*: ULONG
    LogGrowthIncrement*: ULONG
    LogAutoShrinkPercentage*: ULONG
    Flags*: ULONG
    LoggingMode*: USHORT
    Reserved*: USHORT
    RmState*: ULONG
    LogCapacity*: ULONGLONG
    LogFree*: ULONGLONG
    TopsSize*: ULONGLONG
    TopsUsed*: ULONGLONG
    TransactionCount*: ULONGLONG
    OnePCCount*: ULONGLONG
    TwoPCCount*: ULONGLONG
    NumberLogFileFull*: ULONGLONG
    OldestTransactionAge*: ULONGLONG
    RMName*: GUID
    TmLogPathOffset*: ULONG
  PTXFS_QUERY_RM_INFORMATION* = ptr TXFS_QUERY_RM_INFORMATION
  TXFS_ROLLFORWARD_REDO_INFORMATION* {.pure.} = object
    LastVirtualClock*: LARGE_INTEGER
    LastRedoLsn*: ULONGLONG
    HighestRecoveryLsn*: ULONGLONG
    Flags*: ULONG
  PTXFS_ROLLFORWARD_REDO_INFORMATION* = ptr TXFS_ROLLFORWARD_REDO_INFORMATION
  TXFS_START_RM_INFORMATION* {.pure.} = object
    Flags*: ULONG
    LogContainerSize*: ULONGLONG
    LogContainerCountMin*: ULONG
    LogContainerCountMax*: ULONG
    LogGrowthIncrement*: ULONG
    LogAutoShrinkPercentage*: ULONG
    TmLogPathOffset*: ULONG
    TmLogPathLength*: USHORT
    LoggingMode*: USHORT
    LogPathLength*: USHORT
    Reserved*: USHORT
    LogPath*: array[1, WCHAR]
  PTXFS_START_RM_INFORMATION* = ptr TXFS_START_RM_INFORMATION
  TXFS_GET_METADATA_INFO_OUT_TxfFileId* {.pure.} = object
    LowPart*: LONGLONG
    HighPart*: LONGLONG
  TXFS_GET_METADATA_INFO_OUT* {.pure.} = object
    TxfFileId*: TXFS_GET_METADATA_INFO_OUT_TxfFileId
    LockingTransaction*: GUID
    LastLsn*: ULONGLONG
    TransactionState*: ULONG
  PTXFS_GET_METADATA_INFO_OUT* = ptr TXFS_GET_METADATA_INFO_OUT
  TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY* {.pure.} = object
    Offset*: ULONGLONG
    NameFlags*: ULONG
    FileId*: LONGLONG
    Reserved1*: ULONG
    Reserved2*: ULONG
    Reserved3*: LONGLONG
    FileName*: array[1, WCHAR]
  PTXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY* = ptr TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY
  TXFS_LIST_TRANSACTION_LOCKED_FILES* {.pure.} = object
    KtmTransaction*: GUID
    NumberOfFiles*: ULONGLONG
    BufferSizeRequired*: ULONGLONG
    Offset*: ULONGLONG
  PTXFS_LIST_TRANSACTION_LOCKED_FILES* = ptr TXFS_LIST_TRANSACTION_LOCKED_FILES
  TXFS_LIST_TRANSACTIONS_ENTRY* {.pure.} = object
    TransactionId*: GUID
    TransactionState*: ULONG
    Reserved1*: ULONG
    Reserved2*: ULONG
    Reserved3*: LONGLONG
  PTXFS_LIST_TRANSACTIONS_ENTRY* = ptr TXFS_LIST_TRANSACTIONS_ENTRY
  TXFS_LIST_TRANSACTIONS* {.pure.} = object
    NumberOfTransactions*: ULONGLONG
    BufferSizeRequired*: ULONGLONG
  PTXFS_LIST_TRANSACTIONS* = ptr TXFS_LIST_TRANSACTIONS
  TXFS_READ_BACKUP_INFORMATION_OUT_UNION1* {.pure, union.} = object
    BufferLength*: ULONG
    Buffer*: UCHAR
  TXFS_READ_BACKUP_INFORMATION_OUT* {.pure.} = object
    union1*: TXFS_READ_BACKUP_INFORMATION_OUT_UNION1
  PTXFS_READ_BACKUP_INFORMATION_OUT* = ptr TXFS_READ_BACKUP_INFORMATION_OUT
  TXFS_WRITE_BACKUP_INFORMATION* {.pure.} = object
    Buffer*: UCHAR
  PTXFS_WRITE_BACKUP_INFORMATION* = ptr TXFS_WRITE_BACKUP_INFORMATION
  TXFS_GET_TRANSACTED_VERSION* {.pure.} = object
    ThisBaseVersion*: ULONG
    LatestVersion*: ULONG
    ThisMiniVersion*: USHORT
    FirstMiniVersion*: USHORT
    LatestMiniVersion*: USHORT
  PTXFS_GET_TRANSACTED_VERSION* = ptr TXFS_GET_TRANSACTED_VERSION
  TXFS_SAVEPOINT_INFORMATION* {.pure.} = object
    KtmTransaction*: HANDLE
    ActionCode*: ULONG
    SavepointId*: ULONG
  PTXFS_SAVEPOINT_INFORMATION* = ptr TXFS_SAVEPOINT_INFORMATION
  TXFS_CREATE_MINIVERSION_INFO* {.pure.} = object
    StructureVersion*: USHORT
    StructureLength*: USHORT
    BaseVersion*: ULONG
    MiniVersion*: USHORT
  PTXFS_CREATE_MINIVERSION_INFO* = ptr TXFS_CREATE_MINIVERSION_INFO
  TXFS_TRANSACTION_ACTIVE_INFO* {.pure.} = object
    TransactionsActiveAtSnapshot*: WINBOOL
  PTXFS_TRANSACTION_ACTIVE_INFO* = ptr TXFS_TRANSACTION_ACTIVE_INFO
  STORAGE_WRITE_CACHE_PROPERTY* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
    WriteCacheType*: WRITE_CACHE_TYPE
    WriteCacheEnabled*: WRITE_CACHE_ENABLE
    WriteCacheChangeable*: WRITE_CACHE_CHANGE
    WriteThroughSupported*: WRITE_THROUGH
    FlushCacheSupported*: BOOLEAN
    UserDefinedPowerProtection*: BOOLEAN
    NVCacheEnabled*: BOOLEAN
  PSTORAGE_WRITE_CACHE_PROPERTY* = ptr STORAGE_WRITE_CACHE_PROPERTY
  STORAGE_MINIPORT_DESCRIPTOR* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
    Portdriver*: STORAGE_PORT_CODE_SET
    LUNResetSupported*: BOOLEAN
    TargetResetSupported*: BOOLEAN
  PSTORAGE_MINIPORT_DESCRIPTOR* = ptr STORAGE_MINIPORT_DESCRIPTOR
  STORAGE_ACCESS_ALIGNMENT_DESCRIPTOR* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
    BytesPerCacheLine*: DWORD
    BytesOffsetForCacheAlignment*: DWORD
    BytesPerLogicalSector*: DWORD
    BytesPerPhysicalSector*: DWORD
    BytesOffsetForSectorAlignment*: DWORD
  PSTORAGE_ACCESS_ALIGNMENT_DESCRIPTOR* = ptr STORAGE_ACCESS_ALIGNMENT_DESCRIPTOR
  DEVICE_SEEK_PENALTY_DESCRIPTOR* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
    IncursSeekPenalty*: BOOLEAN
  PDEVICE_SEEK_PENALTY_DESCRIPTOR* = ptr DEVICE_SEEK_PENALTY_DESCRIPTOR
  DEVICE_TRIM_DESCRIPTOR* {.pure.} = object
    Version*: DWORD
    Size*: DWORD
    TrimEnabled*: BOOLEAN
  PDEVICE_TRIM_DESCRIPTOR* = ptr DEVICE_TRIM_DESCRIPTOR
  REQUEST_OPLOCK_INPUT_BUFFER* {.pure.} = object
    StructureVersion*: WORD
    StructureLength*: WORD
    RequestedOplockLevel*: DWORD
    Flags*: DWORD
  PREQUEST_OPLOCK_INPUT_BUFFER* = ptr REQUEST_OPLOCK_INPUT_BUFFER
  REQUEST_OPLOCK_OUTPUT_BUFFER* {.pure.} = object
    StructureVersion*: WORD
    StructureLength*: WORD
    OriginalOplockLevel*: DWORD
    NewOplockLevel*: DWORD
    Flags*: DWORD
    AccessMode*: ACCESS_MASK
    ShareMode*: WORD
  PREQUEST_OPLOCK_OUTPUT_BUFFER* = ptr REQUEST_OPLOCK_OUTPUT_BUFFER
  BOOT_AREA_INFO_BootSectors* {.pure.} = object
    Offset*: LARGE_INTEGER
  BOOT_AREA_INFO* {.pure.} = object
    BootSectorCount*: ULONG
    BootSectors*: array[2, BOOT_AREA_INFO_BootSectors]
  PBOOT_AREA_INFO* = ptr BOOT_AREA_INFO
  RETRIEVAL_POINTER_BASE* {.pure.} = object
    FileAreaOffset*: LARGE_INTEGER
  PRETRIEVAL_POINTER_BASE* = ptr RETRIEVAL_POINTER_BASE
  FILE_SYSTEM_RECOGNITION_INFORMATION* {.pure.} = object
    FileSystem*: array[9, CHAR]
  PFILE_SYSTEM_RECOGNITION_INFORMATION* = ptr FILE_SYSTEM_RECOGNITION_INFORMATION
  LOOKUP_STREAM_FROM_CLUSTER_INPUT* {.pure.} = object
    Flags*: DWORD
    NumberOfClusters*: DWORD
    Cluster*: array[1, LARGE_INTEGER]
  PLOOKUP_STREAM_FROM_CLUSTER_INPUT* = ptr LOOKUP_STREAM_FROM_CLUSTER_INPUT
  LOOKUP_STREAM_FROM_CLUSTER_OUTPUT* {.pure.} = object
    Offset*: DWORD
    NumberOfMatches*: DWORD
    BufferSizeRequired*: DWORD
  PLOOKUP_STREAM_FROM_CLUSTER_OUTPUT* = ptr LOOKUP_STREAM_FROM_CLUSTER_OUTPUT
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY* {.pure.} = object
    OffsetToNext*: DWORD
    Flags*: DWORD
    Reserved*: LARGE_INTEGER
    Cluster*: LARGE_INTEGER
    FileName*: array[1, WCHAR]
  PLOOKUP_STREAM_FROM_CLUSTER_ENTRY* = ptr LOOKUP_STREAM_FROM_CLUSTER_ENTRY
  DISK_EXTENT* {.pure.} = object
    DiskNumber*: DWORD
    StartingOffset*: LARGE_INTEGER
    ExtentLength*: LARGE_INTEGER
  PDISK_EXTENT* = ptr DISK_EXTENT
  VOLUME_DISK_EXTENTS* {.pure.} = object
    NumberOfDiskExtents*: DWORD
    Extents*: array[1, DISK_EXTENT]
  PVOLUME_DISK_EXTENTS* = ptr VOLUME_DISK_EXTENTS
const
  GUID_DEVINTERFACE_DISK* = DEFINE_GUID("53f56307-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_CDROM* = DEFINE_GUID("53f56308-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_PARTITION* = DEFINE_GUID("53f5630a-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_TAPE* = DEFINE_GUID("53f5630b-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_WRITEONCEDISK* = DEFINE_GUID("53f5630c-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_VOLUME* = DEFINE_GUID("53f5630d-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_MEDIUMCHANGER* = DEFINE_GUID("53f56310-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_FLOPPY* = DEFINE_GUID("53f56311-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_CDCHANGER* = DEFINE_GUID("53f56312-b6bf-11d0-94f2-00a0c91efb8b")
  GUID_DEVINTERFACE_STORAGEPORT* = DEFINE_GUID("2accfe60-c130-11d2-b082-00a0c91efb8b")
  GUID_DEVINTERFACE_COMPORT* = DEFINE_GUID("86e0d1e0-8089-11d0-9ce4-08003e301f73")
  GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR* = DEFINE_GUID("4d36e978-e325-11ce-bfc1-08002be10318")
  diskClassGuid* = GUID_DEVINTERFACE_DISK
  cdRomClassGuid* = GUID_DEVINTERFACE_CDROM
  partitionClassGuid* = GUID_DEVINTERFACE_PARTITION
  tapeClassGuid* = GUID_DEVINTERFACE_TAPE
  writeOnceDiskClassGuid* = GUID_DEVINTERFACE_WRITEONCEDISK
  volumeClassGuid* = GUID_DEVINTERFACE_VOLUME
  mediumChangerClassGuid* = GUID_DEVINTERFACE_MEDIUMCHANGER
  floppyClassGuid* = GUID_DEVINTERFACE_FLOPPY
  cdChangerClassGuid* = GUID_DEVINTERFACE_CDCHANGER
  storagePortClassGuid* = GUID_DEVINTERFACE_STORAGEPORT
  GUID_CLASS_COMPORT* = GUID_DEVINTERFACE_COMPORT
  GUID_SERENUM_BUS_ENUMERATOR* = GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR
  FILE_DEVICE_BEEP* = 0x00000001
  FILE_DEVICE_CD_ROM* = 0x00000002
  FILE_DEVICE_CD_ROM_FILE_SYSTEM* = 0x00000003
  FILE_DEVICE_CONTROLLER* = 0x00000004
  FILE_DEVICE_DATALINK* = 0x00000005
  FILE_DEVICE_DFS* = 0x00000006
  FILE_DEVICE_DISK* = 0x00000007
  FILE_DEVICE_DISK_FILE_SYSTEM* = 0x00000008
  FILE_DEVICE_FILE_SYSTEM* = 0x00000009
  FILE_DEVICE_INPORT_PORT* = 0x0000000a
  FILE_DEVICE_KEYBOARD* = 0x0000000b
  FILE_DEVICE_MAILSLOT* = 0x0000000c
  FILE_DEVICE_MIDI_IN* = 0x0000000d
  FILE_DEVICE_MIDI_OUT* = 0x0000000e
  FILE_DEVICE_MOUSE* = 0x0000000f
  FILE_DEVICE_MULTI_UNC_PROVIDER* = 0x00000010
  FILE_DEVICE_NAMED_PIPE* = 0x00000011
  FILE_DEVICE_NETWORK* = 0x00000012
  FILE_DEVICE_NETWORK_BROWSER* = 0x00000013
  FILE_DEVICE_NETWORK_FILE_SYSTEM* = 0x00000014
  FILE_DEVICE_NULL* = 0x00000015
  FILE_DEVICE_PARALLEL_PORT* = 0x00000016
  FILE_DEVICE_PHYSICAL_NETCARD* = 0x00000017
  FILE_DEVICE_PRINTER* = 0x00000018
  FILE_DEVICE_SCANNER* = 0x00000019
  FILE_DEVICE_SERIAL_MOUSE_PORT* = 0x0000001a
  FILE_DEVICE_SERIAL_PORT* = 0x0000001b
  FILE_DEVICE_SCREEN* = 0x0000001c
  FILE_DEVICE_SOUND* = 0x0000001d
  FILE_DEVICE_STREAMS* = 0x0000001e
  FILE_DEVICE_TAPE* = 0x0000001f
  FILE_DEVICE_TAPE_FILE_SYSTEM* = 0x00000020
  FILE_DEVICE_TRANSPORT* = 0x00000021
  FILE_DEVICE_UNKNOWN* = 0x00000022
  FILE_DEVICE_VIDEO* = 0x00000023
  FILE_DEVICE_VIRTUAL_DISK* = 0x00000024
  FILE_DEVICE_WAVE_IN* = 0x00000025
  FILE_DEVICE_WAVE_OUT* = 0x00000026
  FILE_DEVICE_8042_PORT* = 0x00000027
  FILE_DEVICE_NETWORK_REDIRECTOR* = 0x00000028
  FILE_DEVICE_BATTERY* = 0x00000029
  FILE_DEVICE_BUS_EXTENDER* = 0x0000002a
  FILE_DEVICE_MODEM* = 0x0000002b
  FILE_DEVICE_VDM* = 0x0000002c
  FILE_DEVICE_MASS_STORAGE* = 0x0000002d
  FILE_DEVICE_SMB* = 0x0000002e
  FILE_DEVICE_KS* = 0x0000002f
  FILE_DEVICE_CHANGER* = 0x00000030
  FILE_DEVICE_SMARTCARD* = 0x00000031
  FILE_DEVICE_ACPI* = 0x00000032
  FILE_DEVICE_DVD* = 0x00000033
  FILE_DEVICE_FULLSCREEN_VIDEO* = 0x00000034
  FILE_DEVICE_DFS_FILE_SYSTEM* = 0x00000035
  FILE_DEVICE_DFS_VOLUME* = 0x00000036
  FILE_DEVICE_SERENUM* = 0x00000037
  FILE_DEVICE_TERMSRV* = 0x00000038
  FILE_DEVICE_KSEC* = 0x00000039
  FILE_DEVICE_FIPS* = 0x0000003A
  FILE_DEVICE_INFINIBAND* = 0x0000003B
  METHOD_BUFFERED* = 0
  METHOD_IN_DIRECT* = 1
  METHOD_OUT_DIRECT* = 2
  METHOD_NEITHER* = 3
  METHOD_DIRECT_TO_HARDWARE* = METHOD_IN_DIRECT
  METHOD_DIRECT_FROM_HARDWARE* = METHOD_OUT_DIRECT
  FILE_ANY_ACCESS* = 0
  FILE_SPECIAL_ACCESS* = FILE_ANY_ACCESS
  FILE_READ_ACCESS* = 0x0001
  FILE_WRITE_ACCESS* = 0x0002
  IOCTL_STORAGE_BASE* = FILE_DEVICE_MASS_STORAGE
template CTL_CODE*(t: untyped, f: untyped, m: untyped, a:untyped): untyped = (t shl 16) or (a shl 14) or (f shl 2) or m
const
  IOCTL_STORAGE_CHECK_VERIFY* = CTL_CODE(IOCTL_STORAGE_BASE,0x0200,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_CHECK_VERIFY2* = CTL_CODE(IOCTL_STORAGE_BASE,0x0200,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_MEDIA_REMOVAL* = CTL_CODE(IOCTL_STORAGE_BASE,0x0201,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_EJECT_MEDIA* = CTL_CODE(IOCTL_STORAGE_BASE,0x0202,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_LOAD_MEDIA* = CTL_CODE(IOCTL_STORAGE_BASE,0x0203,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_LOAD_MEDIA2* = CTL_CODE(IOCTL_STORAGE_BASE,0x0203,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_RESERVE* = CTL_CODE(IOCTL_STORAGE_BASE,0x0204,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_RELEASE* = CTL_CODE(IOCTL_STORAGE_BASE,0x0205,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_FIND_NEW_DEVICES* = CTL_CODE(IOCTL_STORAGE_BASE,0x0206,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_EJECTION_CONTROL* = CTL_CODE(IOCTL_STORAGE_BASE,0x0250,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_MCN_CONTROL* = CTL_CODE(IOCTL_STORAGE_BASE,0x0251,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_GET_MEDIA_TYPES* = CTL_CODE(IOCTL_STORAGE_BASE,0x0300,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_GET_MEDIA_TYPES_EX* = CTL_CODE(IOCTL_STORAGE_BASE,0x0301,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_GET_MEDIA_SERIAL_NUMBER* = CTL_CODE(IOCTL_STORAGE_BASE,0x0304,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_GET_HOTPLUG_INFO* = CTL_CODE(IOCTL_STORAGE_BASE,0x0305,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_SET_HOTPLUG_INFO* = CTL_CODE(IOCTL_STORAGE_BASE,0x0306,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_STORAGE_RESET_BUS* = CTL_CODE(IOCTL_STORAGE_BASE,0x0400,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_RESET_DEVICE* = CTL_CODE(IOCTL_STORAGE_BASE,0x0401,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_BREAK_RESERVATION* = CTL_CODE(IOCTL_STORAGE_BASE,0x0405,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_STORAGE_GET_DEVICE_NUMBER* = CTL_CODE(IOCTL_STORAGE_BASE,0x0420,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_PREDICT_FAILURE* = CTL_CODE(IOCTL_STORAGE_BASE,0x0440,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_READ_CAPACITY* = CTL_CODE(IOCTL_STORAGE_BASE,0x0450,METHOD_BUFFERED,FILE_READ_ACCESS)
  OBSOLETE_IOCTL_STORAGE_RESET_BUS* = CTL_CODE(IOCTL_STORAGE_BASE,0x0400,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  OBSOLETE_IOCTL_STORAGE_RESET_DEVICE* = CTL_CODE(IOCTL_STORAGE_BASE,0x0401,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_STORAGE_MANAGE_DATA_SET_ATTRIBUTES* = CTL_CODE(IOCTL_STORAGE_BASE, 0x0501, METHOD_BUFFERED, FILE_WRITE_ACCESS)
  DeviceDsmActionFlag_NonDestructive* = 0x80000000'i32
  DeviceDsmAction_None* = 0
  DeviceDsmAction_Trim* = 1
  DeviceDsmAction_Notification* = 2 or DeviceDsmActionFlag_NonDestructive
  DEVICE_DSM_FLAG_ENTIRE_DATA_SET_RANGE* = 0x00000001
  RECOVERED_WRITES_VALID* = 0x00000001
  UNRECOVERED_WRITES_VALID* = 0x00000002
  RECOVERED_READS_VALID* = 0x00000004
  UNRECOVERED_READS_VALID* = 0x00000008
  WRITE_COMPRESSION_INFO_VALID* = 0x00000010
  READ_COMPRESSION_INFO_VALID* = 0x00000020
  TAPE_RETURN_STATISTICS* = 0
  TAPE_RETURN_ENV_INFO* = 1
  TAPE_RESET_STATISTICS* = 2
  DDS_4mm* = 0x20
  miniQic* = 0x21
  travan* = 0x22
  QIC* = 0x23
  MP_8mm* = 0x24
  AME_8mm* = 0x25
  AIT1_8mm* = 0x26
  DLT* = 0x27
  NCTP* = 0x28
  IBM_3480* = 0x29
  IBM_3490E* = 0x2A
  IBM_Magstar_3590* = 0x2B
  IBM_Magstar_MP* = 0x2C
  STK_DATA_D3* = 0x2D
  SONY_DTF* = 0x2E
  DV_6mm* = 0x2F
  DMI* = 0x3
  SONY_D2* = 0x4
  CLEANER_CARTRIDGE* = 0x5
  CD_ROM* = 0x6
  CD_R* = 0x7
  CD_RW* = 0x8
  DVD_ROM* = 0x9
  DVD_R* = 0xA
  DVD_RW* = 0xB
  MO_3_RW* = 0xC
  MO_5_WO* = 0xD
  MO_5_RW* = 0xE
  MO_5_LIMDOW* = 0xF
  PC_5_WO* = 0x1
  PC_5_RW* = 0x2
  PD_5_RW* = 0x3
  ABL_5_WO* = 0x4
  PINNACLE_APEX_5_RW* = 0x5
  SONY_12_WO* = 0x6
  PHILIPS_12_WO* = 0x7
  HITACHI_12_WO* = 0x8
  CYGNET_12_WO* = 0x9
  KODAK_14_WO* = 0xA
  MO_NFR_525* = 0xB
  NIKON_12_RW* = 0xC
  IOMEGA_ZIP* = 0xD
  IOMEGA_JAZ* = 0xE
  SYQUEST_EZ135* = 0xF
  SYQUEST_EZFLYER* = 0x1
  SYQUEST_SYJET* = 0x2
  AVATAR_F2* = 0x3
  MP2_8mm* = 0x4
  DST_S* = 0x5
  DST_M* = 0x6
  DST_L* = 0x7
  VXATape_1* = 0x8
  VXATape_2* = 0x9
  STK_9840* = 0xA
  LTO_Ultrium* = 0xB
  LTO_Accelis* = 0xC
  DVD_RAM* = 0xD
  AIT_8mm* = 0xE
  ADR_1* = 0xF
  ADR_2* = 0x1
  STK_9940* = 0x2
  SAIT* = 0x3
  vXATape* = 0x4
  MEDIA_ERASEABLE* = 0x00000001
  MEDIA_WRITE_ONCE* = 0x00000002
  MEDIA_READ_ONLY* = 0x00000004
  MEDIA_READ_WRITE* = 0x00000008
  MEDIA_WRITE_PROTECTED* = 0x00000100
  MEDIA_CURRENTLY_MOUNTED* = 0x80000000'i32
  busTypeUnknown* = 0x00
  busTypeScsi* = 0x1
  busTypeAtapi* = 0x2
  busTypeAta* = 0x3
  busType1394* = 0x4
  busTypeSsa* = 0x5
  busTypeFibre* = 0x6
  busTypeUsb* = 0x7
  busTypeRAID* = 0x8
  busTypeiScsi* = 0x9
  busTypeSas* = 0xA
  busTypeSata* = 0xB
  busTypeSd* = 0xC
  busTypeMmc* = 0xD
  busTypeVirtual* = 0xE
  busTypeFileBackedVirtual* = 0xF
  busTypeMax* = 0x1
  busTypeMaxReserved* = 0x7F
  IOCTL_DISK_BASE* = FILE_DEVICE_DISK
  IOCTL_DISK_GET_DRIVE_GEOMETRY* = CTL_CODE(IOCTL_DISK_BASE,0x0000,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_GET_PARTITION_INFO* = CTL_CODE(IOCTL_DISK_BASE,0x0001,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_SET_PARTITION_INFO* = CTL_CODE(IOCTL_DISK_BASE,0x0002,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_GET_DRIVE_LAYOUT* = CTL_CODE(IOCTL_DISK_BASE,0x0003,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_SET_DRIVE_LAYOUT* = CTL_CODE(IOCTL_DISK_BASE,0x0004,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_VERIFY* = CTL_CODE(IOCTL_DISK_BASE,0x0005,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_FORMAT_TRACKS* = CTL_CODE(IOCTL_DISK_BASE,0x0006,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_REASSIGN_BLOCKS* = CTL_CODE(IOCTL_DISK_BASE,0x0007,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_PERFORMANCE* = CTL_CODE(IOCTL_DISK_BASE,0x0008,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_IS_WRITABLE* = CTL_CODE(IOCTL_DISK_BASE,0x0009,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_LOGGING* = CTL_CODE(IOCTL_DISK_BASE,0x000a,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_FORMAT_TRACKS_EX* = CTL_CODE(IOCTL_DISK_BASE,0x000b,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_HISTOGRAM_STRUCTURE* = CTL_CODE(IOCTL_DISK_BASE,0x000c,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_HISTOGRAM_DATA* = CTL_CODE(IOCTL_DISK_BASE,0x000d,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_HISTOGRAM_RESET* = CTL_CODE(IOCTL_DISK_BASE,0x000e,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_REQUEST_STRUCTURE* = CTL_CODE(IOCTL_DISK_BASE,0x000f,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_REQUEST_DATA* = CTL_CODE(IOCTL_DISK_BASE,0x0010,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_PERFORMANCE_OFF* = CTL_CODE(IOCTL_DISK_BASE,0x0018,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_CONTROLLER_NUMBER* = CTL_CODE(IOCTL_DISK_BASE,0x0011,METHOD_BUFFERED,FILE_ANY_ACCESS)
  SMART_GET_VERSION* = CTL_CODE(IOCTL_DISK_BASE,0x0020,METHOD_BUFFERED,FILE_READ_ACCESS)
  SMART_SEND_DRIVE_COMMAND* = CTL_CODE(IOCTL_DISK_BASE,0x0021,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  SMART_RCV_DRIVE_DATA* = CTL_CODE(IOCTL_DISK_BASE,0x0022,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_GET_PARTITION_INFO_EX* = CTL_CODE(IOCTL_DISK_BASE,0x0012,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_SET_PARTITION_INFO_EX* = CTL_CODE(IOCTL_DISK_BASE,0x0013,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_GET_DRIVE_LAYOUT_EX* = CTL_CODE(IOCTL_DISK_BASE,0x0014,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_SET_DRIVE_LAYOUT_EX* = CTL_CODE(IOCTL_DISK_BASE,0x0015,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_CREATE_DISK* = CTL_CODE(IOCTL_DISK_BASE,0x0016,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_GET_LENGTH_INFO* = CTL_CODE(IOCTL_DISK_BASE,0x0017,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_GET_DRIVE_GEOMETRY_EX* = CTL_CODE(IOCTL_DISK_BASE,0x0028,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_REASSIGN_BLOCKS_EX* = CTL_CODE(IOCTL_DISK_BASE,0x0029,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_UPDATE_DRIVE_SIZE* = CTL_CODE(IOCTL_DISK_BASE,0x0032,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_GROW_PARTITION* = CTL_CODE(IOCTL_DISK_BASE,0x0034,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_GET_CACHE_INFORMATION* = CTL_CODE(IOCTL_DISK_BASE,0x0035,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_SET_CACHE_INFORMATION* = CTL_CODE(IOCTL_DISK_BASE,0x0036,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  OBSOLETE_DISK_GET_WRITE_CACHE_STATE* = CTL_CODE(IOCTL_DISK_BASE,0x0037,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_DELETE_DRIVE_LAYOUT* = CTL_CODE(IOCTL_DISK_BASE,0x0040,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_UPDATE_PROPERTIES* = CTL_CODE(IOCTL_DISK_BASE,0x0050,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_RESET_SNAPSHOT_INFO* = CTL_CODE(IOCTL_DISK_BASE,0x0084,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_FORMAT_DRIVE* = CTL_CODE(IOCTL_DISK_BASE,0x00f3,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_DISK_SENSE_DEVICE* = CTL_CODE(IOCTL_DISK_BASE,0x00f8,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_DISK_CHECK_VERIFY* = CTL_CODE(IOCTL_DISK_BASE,0x0200,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_MEDIA_REMOVAL* = CTL_CODE(IOCTL_DISK_BASE,0x0201,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_EJECT_MEDIA* = CTL_CODE(IOCTL_DISK_BASE,0x0202,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_LOAD_MEDIA* = CTL_CODE(IOCTL_DISK_BASE,0x0203,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_RESERVE* = CTL_CODE(IOCTL_DISK_BASE,0x0204,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_RELEASE* = CTL_CODE(IOCTL_DISK_BASE,0x0205,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_FIND_NEW_DEVICES* = CTL_CODE(IOCTL_DISK_BASE,0x0206,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_DISK_GET_MEDIA_TYPES* = CTL_CODE(IOCTL_DISK_BASE,0x0300,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_STORAGE_QUERY_PROPERTY* = CTL_CODE(IOCTL_STORAGE_BASE, 0x0500, METHOD_BUFFERED, FILE_ANY_ACCESS)
  PARTITION_ENTRY_UNUSED* = 0x00
  PARTITION_FAT_12* = 0x01
  PARTITION_XENIX_1* = 0x02
  PARTITION_XENIX_2* = 0x03
  PARTITION_FAT_16* = 0x04
  PARTITION_EXTENDED* = 0x05
  PARTITION_HUGE* = 0x06
  PARTITION_IFS* = 0x07
  PARTITION_OS2BOOTMGR* = 0x0A
  PARTITION_FAT32* = 0x0B
  PARTITION_FAT32_XINT13* = 0x0C
  PARTITION_XINT13* = 0x0E
  PARTITION_XINT13_EXTENDED* = 0x0F
  PARTITION_PREP* = 0x41
  PARTITION_LDM* = 0x42
  PARTITION_UNIX* = 0x63
  VALID_NTFT* = 0xC0
  PARTITION_NTFT* = 0x80
  unknown* = 0
  F5_1Pt2_512* = 1
  F3_1Pt44_512* = 2
  F3_2Pt88_512* = 3
  F3_20Pt8_512* = 4
  F3_720_512* = 5
  F5_360_512* = 6
  F5_320_512* = 7
  F5_320_1024* = 8
  F5_180_512* = 9
  F5_160_512* = 10
  removableMedia* = 11
  fixedMedia* = 12
  F3_120M_512* = 13
  F3_640_512* = 14
  F5_640_512* = 15
  F5_720_512* = 16
  F3_1Pt2_512* = 17
  F3_1Pt23_1024* = 18
  F5_1Pt23_1024* = 19
  F3_128Mb_512* = 20
  F3_230Mb_512* = 21
  F8_256_128* = 22
  F3_200Mb_512* = 23
  F3_240M_512* = 24
  F3_32M_512* = 25
  WMI_DISK_GEOMETRY_GUID* = DEFINE_GUID("25007f51-57c2-11d1-a528-00a0c9062910")
  PARTITION_STYLE_MBR* = 0
  PARTITION_STYLE_GPT* = 1
  PARTITION_STYLE_RAW* = 2
  GPT_ATTRIBUTE_PLATFORM_REQUIRED* = 0x0000000000000001
  GPT_BASIC_DATA_ATTRIBUTE_NO_DRIVE_LETTER* = 0x8000000000000000
  GPT_BASIC_DATA_ATTRIBUTE_HIDDEN* = 0x4000000000000000
  GPT_BASIC_DATA_ATTRIBUTE_SHADOW_COPY* = 0x2000000000000000
  GPT_BASIC_DATA_ATTRIBUTE_READ_ONLY* = 0x1000000000000000
  detectNone* = 0
  detectInt13* = 1
  detectExInt13* = 2
  equalPriority* = 0
  keepPrefetchedData* = 1
  keepReadData* = 2
  HIST_NO_OF_BUCKETS* = 24
  DISK_LOGGING_START* = 0
  DISK_LOGGING_STOP* = 1
  DISK_LOGGING_DUMP* = 2
  DISK_BINNING* = 3
  requestSize* = 0
  requestLocation* = 1
  CAP_ATA_ID_CMD* = 1
  CAP_ATAPI_ID_CMD* = 2
  CAP_SMART_CMD* = 4
  ATAPI_ID_CMD* = 0xA1
  ID_CMD* = 0xEC
  SMART_CMD* = 0xB0
  SMART_CYL_LOW* = 0x4F
  SMART_CYL_HI* = 0xC2
  SMART_NO_ERROR* = 0
  SMART_IDE_ERROR* = 1
  SMART_INVALID_FLAG* = 2
  SMART_INVALID_COMMAND* = 3
  SMART_INVALID_BUFFER* = 4
  SMART_INVALID_DRIVE* = 5
  SMART_INVALID_IOCTL* = 6
  SMART_ERROR_NO_MEM* = 7
  SMART_INVALID_REGISTER* = 8
  SMART_NOT_SUPPORTED* = 9
  SMART_NO_IDE_DEVICE* = 10
  SMART_OFFLINE_ROUTINE_OFFLINE* = 0
  SMART_SHORT_SELFTEST_OFFLINE* = 1
  SMART_EXTENDED_SELFTEST_OFFLINE* = 2
  SMART_ABORT_OFFLINE_SELFTEST* = 127
  SMART_SHORT_SELFTEST_CAPTIVE* = 129
  SMART_EXTENDED_SELFTEST_CAPTIVE* = 130
  READ_ATTRIBUTE_BUFFER_SIZE* = 512
  IDENTIFY_BUFFER_SIZE* = 512
  READ_THRESHOLD_BUFFER_SIZE* = 512
  SMART_LOG_SECTOR_SIZE* = 512
  READ_ATTRIBUTES* = 0xD0
  READ_THRESHOLDS* = 0xD1
  ENABLE_DISABLE_AUTOSAVE* = 0xD2
  SAVE_ATTRIBUTE_VALUES* = 0xD3
  EXECUTE_OFFLINE_DIAGS* = 0xD4
  SMART_READ_LOG* = 0xD5
  SMART_WRITE_LOG* = 0xd6
  ENABLE_SMART* = 0xD8
  DISABLE_SMART* = 0xD9
  RETURN_SMART_STATUS* = 0xDA
  ENABLE_DISABLE_AUTO_OFFLINE* = 0xDB
  IOCTL_CHANGER_BASE* = FILE_DEVICE_CHANGER
  IOCTL_CHANGER_GET_PARAMETERS* = CTL_CODE(IOCTL_CHANGER_BASE,0x0000,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_CHANGER_GET_STATUS* = CTL_CODE(IOCTL_CHANGER_BASE,0x0001,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_CHANGER_GET_PRODUCT_DATA* = CTL_CODE(IOCTL_CHANGER_BASE,0x0002,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_CHANGER_SET_ACCESS* = CTL_CODE(IOCTL_CHANGER_BASE,0x0004,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_CHANGER_GET_ELEMENT_STATUS* = CTL_CODE(IOCTL_CHANGER_BASE,0x0005,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_CHANGER_INITIALIZE_ELEMENT_STATUS* = CTL_CODE(IOCTL_CHANGER_BASE,0x0006,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_CHANGER_SET_POSITION* = CTL_CODE(IOCTL_CHANGER_BASE,0x0007,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_CHANGER_EXCHANGE_MEDIUM* = CTL_CODE(IOCTL_CHANGER_BASE,0x0008,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_CHANGER_MOVE_MEDIUM* = CTL_CODE(IOCTL_CHANGER_BASE,0x0009,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_CHANGER_REINITIALIZE_TRANSPORT* = CTL_CODE(IOCTL_CHANGER_BASE,0x000A,METHOD_BUFFERED,FILE_READ_ACCESS)
  IOCTL_CHANGER_QUERY_VOLUME_TAGS* = CTL_CODE(IOCTL_CHANGER_BASE,0x000B,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  allElements* = 0
  changerTransport* = 1
  changerSlot* = 2
  changerIEPort* = 3
  changerDrive* = 4
  changerDoor* = 5
  changerKeypad* = 6
  changerMaxElement* = 7
  CHANGER_BAR_CODE_SCANNER_INSTALLED* = 0x00000001
  CHANGER_INIT_ELEM_STAT_WITH_RANGE* = 0x00000002
  CHANGER_CLOSE_IEPORT* = 0x00000004
  CHANGER_OPEN_IEPORT* = 0x00000008
  CHANGER_STATUS_NON_VOLATILE* = 0x00000010
  CHANGER_EXCHANGE_MEDIA* = 0x00000020
  CHANGER_CLEANER_SLOT* = 0x00000040
  CHANGER_LOCK_UNLOCK* = 0x00000080
  CHANGER_CARTRIDGE_MAGAZINE* = 0x00000100
  CHANGER_MEDIUM_FLIP* = 0x00000200
  CHANGER_POSITION_TO_ELEMENT* = 0x00000400
  CHANGER_REPORT_IEPORT_STATE* = 0x00000800
  CHANGER_STORAGE_DRIVE* = 0x00001000
  CHANGER_STORAGE_IEPORT* = 0x00002000
  CHANGER_STORAGE_SLOT* = 0x00004000
  CHANGER_STORAGE_TRANSPORT* = 0x00008000
  CHANGER_DRIVE_CLEANING_REQUIRED* = 0x00010000
  CHANGER_PREDISMOUNT_EJECT_REQUIRED* = 0x00020000
  CHANGER_CLEANER_ACCESS_NOT_VALID* = 0x00040000
  CHANGER_PREMOUNT_EJECT_REQUIRED* = 0x00080000
  CHANGER_VOLUME_IDENTIFICATION* = 0x00100000
  CHANGER_VOLUME_SEARCH* = 0x00200000
  CHANGER_VOLUME_ASSERT* = 0x00400000
  CHANGER_VOLUME_REPLACE* = 0x00800000
  CHANGER_VOLUME_UNDEFINE* = 0x01000000
  CHANGER_SERIAL_NUMBER_VALID* = 0x04000000
  CHANGER_DEVICE_REINITIALIZE_CAPABLE* = 0x08000000
  CHANGER_KEYPAD_ENABLE_DISABLE* = 0x10000000
  CHANGER_DRIVE_EMPTY_ON_DOOR_ACCESS* = 0x20000000
  CHANGER_RESERVED_BIT* = 0x80000000'i32
  CHANGER_PREDISMOUNT_ALIGN_TO_SLOT* = 0x80000001'i32
  CHANGER_PREDISMOUNT_ALIGN_TO_DRIVE* = 0x80000002'i32
  CHANGER_CLEANER_AUTODISMOUNT* = 0x80000004'i32
  CHANGER_TRUE_EXCHANGE_CAPABLE* = 0x80000008'i32
  CHANGER_SLOTS_USE_TRAYS* = 0x80000010'i32
  CHANGER_RTN_MEDIA_TO_ORIGINAL_ADDR* = 0x80000020'i32
  CHANGER_CLEANER_OPS_NOT_SUPPORTED* = 0x80000040'i32
  CHANGER_IEPORT_USER_CONTROL_OPEN* = 0x80000080'i32
  CHANGER_IEPORT_USER_CONTROL_CLOSE* = 0x80000100'i32
  CHANGER_MOVE_EXTENDS_IEPORT* = 0x80000200'i32
  CHANGER_MOVE_RETRACTS_IEPORT* = 0x80000400'i32
  CHANGER_TO_TRANSPORT* = 0x01
  CHANGER_TO_SLOT* = 0x02
  CHANGER_TO_IEPORT* = 0x04
  CHANGER_TO_DRIVE* = 0x08
  LOCK_UNLOCK_IEPORT* = 0x01
  LOCK_UNLOCK_DOOR* = 0x02
  LOCK_UNLOCK_KEYPAD* = 0x04
  LOCK_ELEMENT* = 0
  UNLOCK_ELEMENT* = 1
  EXTEND_IEPORT* = 2
  RETRACT_IEPORT* = 3
  ELEMENT_STATUS_FULL* = 0x00000001
  ELEMENT_STATUS_IMPEXP* = 0x00000002
  ELEMENT_STATUS_EXCEPT* = 0x00000004
  ELEMENT_STATUS_ACCESS* = 0x00000008
  ELEMENT_STATUS_EXENAB* = 0x00000010
  ELEMENT_STATUS_INENAB* = 0x00000020
  ELEMENT_STATUS_PRODUCT_DATA* = 0x00000040
  ELEMENT_STATUS_LUN_VALID* = 0x00001000
  ELEMENT_STATUS_ID_VALID* = 0x00002000
  ELEMENT_STATUS_NOT_BUS* = 0x00008000
  ELEMENT_STATUS_INVERT* = 0x00400000
  ELEMENT_STATUS_SVALID* = 0x00800000
  ELEMENT_STATUS_PVOLTAG* = 0x10000000
  ELEMENT_STATUS_AVOLTAG* = 0x20000000
  ERROR_LABEL_UNREADABLE* = 0x00000001
  ERROR_LABEL_QUESTIONABLE* = 0x00000002
  ERROR_SLOT_NOT_PRESENT* = 0x00000004
  ERROR_DRIVE_NOT_INSTALLED* = 0x00000008
  ERROR_TRAY_MALFUNCTION* = 0x00000010
  ERROR_INIT_STATUS_NEEDED* = 0x00000011
  ERROR_UNHANDLED_ERROR* = 0xFFFFFFFF'i32
  SEARCH_ALL* = 0x0
  SEARCH_PRIMARY* = 0x1
  SEARCH_ALTERNATE* = 0x2
  SEARCH_ALL_NO_SEQ* = 0x4
  SEARCH_PRI_NO_SEQ* = 0x5
  SEARCH_ALT_NO_SEQ* = 0x6
  ASSERT_PRIMARY* = 0x8
  ASSERT_ALTERNATE* = 0x9
  REPLACE_PRIMARY* = 0xA
  REPLACE_ALTERNATE* = 0xB
  UNDEFINE_PRIMARY* = 0xC
  UNDEFINE_ALTERNATE* = 0xD
  deviceProblemNone* = 0
  deviceProblemHardware* = 1
  deviceProblemCHMError* = 2
  deviceProblemDoorOpen* = 3
  deviceProblemCalibrationError* = 4
  deviceProblemTargetFailure* = 5
  deviceProblemCHMMoveError* = 6
  deviceProblemCHMZeroError* = 7
  deviceProblemCartridgeInsertError* = 8
  deviceProblemPositionError* = 9
  deviceProblemSensorError* = 10
  deviceProblemCartridgeEjectError* = 11
  deviceProblemGripperError* = 12
  deviceProblemDriveError* = 13
  IOCTL_SERIAL_LSRMST_INSERT* = CTL_CODE(FILE_DEVICE_SERIAL_PORT,31,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_SERENUM_EXPOSE_HARDWARE* = CTL_CODE(FILE_DEVICE_SERENUM,128,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_SERENUM_REMOVE_HARDWARE* = CTL_CODE(FILE_DEVICE_SERENUM,129,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_SERENUM_PORT_DESC* = CTL_CODE(FILE_DEVICE_SERENUM,130,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_SERENUM_GET_PORT_NAME* = CTL_CODE(FILE_DEVICE_SERENUM,131,METHOD_BUFFERED,FILE_ANY_ACCESS)
  SERIAL_LSRMST_ESCAPE* = BYTE 0x00
  SERIAL_LSRMST_LSR_DATA* = BYTE 0x01
  SERIAL_LSRMST_LSR_NODATA* = BYTE 0x02
  SERIAL_LSRMST_MST* = BYTE 0x03
  SERIAL_IOC_FCR_FIFO_ENABLE* = DWORD 0x00000001
  SERIAL_IOC_FCR_RCVR_RESET* = DWORD 0x00000002
  SERIAL_IOC_FCR_XMIT_RESET* = DWORD 0x00000004
  SERIAL_IOC_FCR_DMA_MODE* = DWORD 0x00000008
  SERIAL_IOC_FCR_RES1* = DWORD 0x00000010
  SERIAL_IOC_FCR_RES2* = DWORD 0x00000020
  SERIAL_IOC_FCR_RCVR_TRIGGER_LSB* = DWORD 0x00000040
  SERIAL_IOC_FCR_RCVR_TRIGGER_MSB* = DWORD 0x00000080
  SERIAL_IOC_MCR_DTR* = DWORD 0x00000001
  SERIAL_IOC_MCR_RTS* = DWORD 0x00000002
  SERIAL_IOC_MCR_OUT1* = DWORD 0x00000004
  SERIAL_IOC_MCR_OUT2* = DWORD 0x00000008
  SERIAL_IOC_MCR_LOOP* = DWORD 0x00000010
  FSCTL_REQUEST_OPLOCK_LEVEL_1* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,0,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_REQUEST_OPLOCK_LEVEL_2* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,1,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_REQUEST_BATCH_OPLOCK* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,2,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_OPLOCK_BREAK_ACKNOWLEDGE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,3,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_OPBATCH_ACK_CLOSE_PENDING* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,4,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_OPLOCK_BREAK_NOTIFY* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,5,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_LOCK_VOLUME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,6,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_UNLOCK_VOLUME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,7,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_DISMOUNT_VOLUME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,8,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_IS_VOLUME_MOUNTED* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,10,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_IS_PATHNAME_VALID* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,11,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_MARK_VOLUME_DIRTY* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,12,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_QUERY_RETRIEVAL_POINTERS* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,14,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_GET_COMPRESSION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,15,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_SET_COMPRESSION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,16,METHOD_BUFFERED,FILE_READ_DATA or FILE_WRITE_DATA)
  FSCTL_MARK_AS_SYSTEM_HIVE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,19,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_OPLOCK_BREAK_ACK_NO_2* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,20,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_INVALIDATE_VOLUMES* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,21,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_QUERY_FAT_BPB* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,22,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_REQUEST_FILTER_OPLOCK* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,23,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_FILESYSTEM_GET_STATISTICS* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,24,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_GET_NTFS_VOLUME_DATA* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,25,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_GET_NTFS_FILE_RECORD* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,26,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_GET_VOLUME_BITMAP* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,27,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_GET_RETRIEVAL_POINTERS* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,28,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_MOVE_FILE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,29,METHOD_BUFFERED,FILE_SPECIAL_ACCESS)
  FSCTL_IS_VOLUME_DIRTY* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,30,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_ALLOW_EXTENDED_DASD_IO* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,32,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_FIND_FILES_BY_SID* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,35,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_SET_OBJECT_ID* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,38,METHOD_BUFFERED,FILE_SPECIAL_ACCESS)
  FSCTL_GET_OBJECT_ID* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,39,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_DELETE_OBJECT_ID* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,40,METHOD_BUFFERED,FILE_SPECIAL_ACCESS)
  FSCTL_SET_REPARSE_POINT* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,41,METHOD_BUFFERED,FILE_SPECIAL_ACCESS)
  FSCTL_GET_REPARSE_POINT* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,42,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_DELETE_REPARSE_POINT* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,43,METHOD_BUFFERED,FILE_SPECIAL_ACCESS)
  FSCTL_ENUM_USN_DATA* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,44,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_SECURITY_ID_CHECK* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,45,METHOD_NEITHER,FILE_READ_DATA)
  FSCTL_READ_USN_JOURNAL* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,46,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_SET_OBJECT_ID_EXTENDED* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,47,METHOD_BUFFERED,FILE_SPECIAL_ACCESS)
  FSCTL_CREATE_OR_GET_OBJECT_ID* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,48,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_SET_SPARSE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,49,METHOD_BUFFERED,FILE_SPECIAL_ACCESS)
  FSCTL_SET_ZERO_DATA* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,50,METHOD_BUFFERED,FILE_WRITE_DATA)
  FSCTL_QUERY_ALLOCATED_RANGES* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,51,METHOD_NEITHER,FILE_READ_DATA)
  FSCTL_SET_ENCRYPTION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,53,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_ENCRYPTION_FSCTL_IO* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,54,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_WRITE_RAW_ENCRYPTED* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,55,METHOD_NEITHER,FILE_SPECIAL_ACCESS)
  FSCTL_READ_RAW_ENCRYPTED* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,56,METHOD_NEITHER,FILE_SPECIAL_ACCESS)
  FSCTL_CREATE_USN_JOURNAL* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,57,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_READ_FILE_USN_DATA* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,58,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_WRITE_USN_CLOSE_RECORD* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,59,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_EXTEND_VOLUME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,60,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_QUERY_USN_JOURNAL* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,61,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_DELETE_USN_JOURNAL* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,62,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_MARK_HANDLE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,63,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_SIS_COPYFILE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,64,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_SIS_LINK_FILES* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,65,METHOD_BUFFERED,FILE_READ_DATA or FILE_WRITE_DATA)
  FSCTL_HSM_MSG* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,66,METHOD_BUFFERED,FILE_READ_DATA or FILE_WRITE_DATA)
  FSCTL_HSM_DATA* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,68,METHOD_NEITHER,FILE_READ_DATA or FILE_WRITE_DATA)
  FSCTL_RECALL_FILE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,69,METHOD_NEITHER,FILE_ANY_ACCESS)
  FSCTL_READ_FROM_PLEX* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,71,METHOD_OUT_DIRECT,FILE_READ_DATA)
  FSCTL_FILE_PREFETCH* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,72,METHOD_BUFFERED,FILE_SPECIAL_ACCESS)
  USN_PAGE_SIZE* = 0x1000
  USN_REASON_DATA_OVERWRITE* = 0x00000001
  USN_REASON_DATA_EXTEND* = 0x00000002
  USN_REASON_DATA_TRUNCATION* = 0x00000004
  USN_REASON_NAMED_DATA_OVERWRITE* = 0x00000010
  USN_REASON_NAMED_DATA_EXTEND* = 0x00000020
  USN_REASON_NAMED_DATA_TRUNCATION* = 0x00000040
  USN_REASON_FILE_CREATE* = 0x00000100
  USN_REASON_FILE_DELETE* = 0x00000200
  USN_REASON_EA_CHANGE* = 0x00000400
  USN_REASON_SECURITY_CHANGE* = 0x00000800
  USN_REASON_RENAME_OLD_NAME* = 0x00001000
  USN_REASON_RENAME_NEW_NAME* = 0x00002000
  USN_REASON_INDEXABLE_CHANGE* = 0x00004000
  USN_REASON_BASIC_INFO_CHANGE* = 0x00008000
  USN_REASON_HARD_LINK_CHANGE* = 0x00010000
  USN_REASON_COMPRESSION_CHANGE* = 0x00020000
  USN_REASON_ENCRYPTION_CHANGE* = 0x00040000
  USN_REASON_OBJECT_ID_CHANGE* = 0x00080000
  USN_REASON_REPARSE_POINT_CHANGE* = 0x00100000
  USN_REASON_STREAM_CHANGE* = 0x00200000
  USN_REASON_CLOSE* = 0x80000000'i32
  USN_DELETE_FLAG_DELETE* = 0x00000001
  USN_DELETE_FLAG_NOTIFY* = 0x00000002
  USN_DELETE_VALID_FLAGS* = 0x00000003
  USN_SOURCE_DATA_MANAGEMENT* = 0x00000001
  USN_SOURCE_AUXILIARY_DATA* = 0x00000002
  USN_SOURCE_REPLICATION_MANAGEMENT* = 0x00000004
  MARK_HANDLE_PROTECT_CLUSTERS* = 0x00000001
  MARK_HANDLE_TXF_SYSTEM_LOG* = 0x00000004
  MARK_HANDLE_NOT_TXF_SYSTEM_LOG* = 0x00000008
  MARK_HANDLE_REALTIME* = 0x00000020
  MARK_HANDLE_NOT_REALTIME* = 0x00000040
  VOLUME_IS_DIRTY* = 0x00000001
  VOLUME_UPGRADE_SCHEDULED* = 0x00000002
  FILE_PREFETCH_TYPE_FOR_CREATE* = 0x1
  FILESYSTEM_STATISTICS_TYPE_NTFS* = 1
  FILESYSTEM_STATISTICS_TYPE_FAT* = 2
  FILE_SET_ENCRYPTION* = 0x00000001
  FILE_CLEAR_ENCRYPTION* = 0x00000002
  STREAM_SET_ENCRYPTION* = 0x00000003
  STREAM_CLEAR_ENCRYPTION* = 0x00000004
  MAXIMUM_ENCRYPTION_VALUE* = 0x00000004
  ENCRYPTION_FORMAT_DEFAULT* = 0x01
  COMPRESSION_FORMAT_SPARSE* = 0x4000
  COPYFILE_SIS_LINK* = 0x0001
  COPYFILE_SIS_REPLACE* = 0x0002
  COPYFILE_SIS_FLAGS* = 0x0003
  storageDeviceProperty* = 0
  storageAdapterProperty* = 1
  storageDeviceIdProperty* = 2
  storageDeviceUniqueIdProperty* = 3
  storageDeviceWriteCacheProperty* = 4
  storageMiniportProperty* = 5
  storageAccessAlignmentProperty* = 6
  storageDeviceSeekPenaltyProperty* = 7
  storageDeviceTrimProperty* = 8
  propertyStandardQuery* = 0
  propertyExistsQuery* = 1
  propertyMaskQuery* = 2
  propertyQueryMaxDefined* = 3
  FSCTL_MAKE_MEDIA_COMPATIBLE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 76, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_SET_DEFECT_MANAGEMENT* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 77, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_QUERY_SPARING_INFO* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 78, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_QUERY_ON_DISK_VOLUME_INFO* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 79, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_SET_VOLUME_COMPRESSION_STATE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,80, METHOD_BUFFERED, FILE_SPECIAL_ACCESS)
  FSCTL_TXFS_MODIFY_RM* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,81, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_QUERY_RM_INFORMATION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,82, METHOD_BUFFERED, FILE_READ_DATA)
  FSCTL_TXFS_ROLLFORWARD_REDO* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,84, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_ROLLFORWARD_UNDO* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,85, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_START_RM* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,86, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_SHUTDOWN_RM* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 87, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_READ_BACKUP_INFORMATION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,88, METHOD_BUFFERED, FILE_READ_DATA)
  FSCTL_TXFS_WRITE_BACKUP_INFORMATION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,89, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_CREATE_SECONDARY_RM* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,90,METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_GET_METADATA_INFO* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,91, METHOD_BUFFERED, FILE_READ_DATA)
  FSCTL_TXFS_GET_TRANSACTED_VERSION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,92, METHOD_BUFFERED, FILE_READ_DATA)
  FSCTL_TXFS_SAVEPOINT_INFORMATION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,94, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_CREATE_MINIVERSION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 95, METHOD_BUFFERED, FILE_WRITE_DATA)
  FSCTL_TXFS_TRANSACTION_ACTIVE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,99, METHOD_BUFFERED, FILE_READ_DATA)
  FSCTL_SET_ZERO_ON_DEALLOCATION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,101, METHOD_BUFFERED, FILE_SPECIAL_ACCESS)
  FSCTL_SET_REPAIR* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 102, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_GET_REPAIR* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 103, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_WAIT_FOR_REPAIR* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 104, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_INITIATE_REPAIR* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 106, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_CSC_INTERNAL* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 107, METHOD_NEITHER, FILE_ANY_ACCESS)
  FSCTL_SHRINK_VOLUME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 108, METHOD_BUFFERED, FILE_SPECIAL_ACCESS)
  FSCTL_SET_SHORT_NAME_BEHAVIOR* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 109, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_DFSR_SET_GHOST_HANDLE_STATE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 110, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_TXFS_LIST_TRANSACTION_LOCKED_FILES* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 120, METHOD_BUFFERED, FILE_READ_DATA)
  FSCTL_TXFS_LIST_TRANSACTIONS* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 121, METHOD_BUFFERED, FILE_READ_DATA)
  FSCTL_QUERY_PAGEFILE_ENCRYPTION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 122, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_RESET_VOLUME_ALLOCATION_HINTS* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 123, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_TXFS_READ_BACKUP_INFORMATION2* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 126, METHOD_BUFFERED, FILE_ANY_ACCESS)
  SET_REPAIR_ENABLED* = 0x00000001
  SET_REPAIR_VOLUME_BITMAP_SCAN* = 0x00000002
  SET_REPAIR_DELETE_CROSSLINK* = 0x00000004
  SET_REPAIR_WARN_ABOUT_DATA_LOSS* = 0x00000008
  SET_REPAIR_DISABLED_AND_BUGCHECK_ON_CORRUPT* = 0x00000010
  SET_REPAIR_VALID_MASK* = 0x0000001F
  shrinkPrepare* = 0
  shrinkCommit* = 1
  shrinkAbort* = 2
  TXFS_RM_FLAG_LOGGING_MODE* = 0x00000001
  TXFS_RM_FLAG_RENAME_RM* = 0x00000002
  TXFS_RM_FLAG_LOG_CONTAINER_COUNT_MAX* = 0x00000004
  TXFS_RM_FLAG_LOG_CONTAINER_COUNT_MIN* = 0x00000008
  TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_NUM_CONTAINERS* = 0x00000010
  TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_PERCENT* = 0x00000020
  TXFS_RM_FLAG_LOG_AUTO_SHRINK_PERCENTAGE* = 0x00000040
  TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MAX* = 0x00000080
  TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MIN* = 0x00000100
  TXFS_RM_FLAG_GROW_LOG* = 0x00000400
  TXFS_RM_FLAG_SHRINK_LOG* = 0x00000800
  TXFS_RM_FLAG_ENFORCE_MINIMUM_SIZE* = 0x00001000
  TXFS_RM_FLAG_PRESERVE_CHANGES* = 0x00002000
  TXFS_RM_FLAG_RESET_RM_AT_NEXT_START* = 0x00004000
  TXFS_RM_FLAG_DO_NOT_RESET_RM_AT_NEXT_START* = 0x00008000
  TXFS_RM_FLAG_PREFER_CONSISTENCY* = 0x00010000
  TXFS_RM_FLAG_PREFER_AVAILABILITY* = 0x00020000
  TXFS_LOGGING_MODE_SIMPLE* = 1
  TXFS_LOGGING_MODE_FULL* = 2
  TXFS_TRANSACTION_STATE_NONE* = 0
  TXFS_TRANSACTION_STATE_ACTIVE* = 1
  TXFS_TRANSACTION_STATE_PREPARED* = 2
  TXFS_TRANSACTION_STATE_NOTACTIVE* = 3
  TXFS_MODIFY_RM_VALID_FLAGS* = TXFS_RM_FLAG_LOGGING_MODE or TXFS_RM_FLAG_RENAME_RM or TXFS_RM_FLAG_LOG_CONTAINER_COUNT_MAX or TXFS_RM_FLAG_LOG_CONTAINER_COUNT_MIN or TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_NUM_CONTAINERS or TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_PERCENT or TXFS_RM_FLAG_LOG_AUTO_SHRINK_PERCENTAGE or TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MAX or TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MIN or TXFS_RM_FLAG_SHRINK_LOG or TXFS_RM_FLAG_GROW_LOG or TXFS_RM_FLAG_ENFORCE_MINIMUM_SIZE or TXFS_RM_FLAG_PRESERVE_CHANGES or TXFS_RM_FLAG_RESET_RM_AT_NEXT_START or TXFS_RM_FLAG_DO_NOT_RESET_RM_AT_NEXT_START or TXFS_RM_FLAG_PREFER_CONSISTENCY or TXFS_RM_FLAG_PREFER_AVAILABILITY
  TXFS_RM_STATE_NOT_STARTED* = 0
  TXFS_RM_STATE_STARTING* = 1
  TXFS_RM_STATE_ACTIVE* = 3
  TXFS_RM_STATE_SHUTTING_DOWN* = 4
  TXFS_QUERY_RM_INFORMATION_VALID_FLAGS* = TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_NUM_CONTAINERS or TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_PERCENT or TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MAX or TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MIN or TXFS_RM_FLAG_RESET_RM_AT_NEXT_START or TXFS_RM_FLAG_DO_NOT_RESET_RM_AT_NEXT_START or TXFS_RM_FLAG_PREFER_CONSISTENCY or TXFS_RM_FLAG_PREFER_AVAILABILITY
  TXFS_ROLLFORWARD_REDO_FLAG_USE_LAST_REDO_LSN* = 0x01
  TXFS_ROLLFORWARD_REDO_FLAG_USE_LAST_VIRTUAL_CLOCK* = 0x02
  TXFS_ROLLFORWARD_REDO_VALID_FLAGS* = TXFS_ROLLFORWARD_REDO_FLAG_USE_LAST_REDO_LSN or TXFS_ROLLFORWARD_REDO_FLAG_USE_LAST_VIRTUAL_CLOCK
  TXFS_START_RM_FLAG_LOG_CONTAINER_COUNT_MAX* = 0x00000001
  TXFS_START_RM_FLAG_LOG_CONTAINER_COUNT_MIN* = 0x00000002
  TXFS_START_RM_FLAG_LOG_CONTAINER_SIZE* = 0x00000004
  TXFS_START_RM_FLAG_LOG_GROWTH_INCREMENT_NUM_CONTAINERS* = 0x00000008
  TXFS_START_RM_FLAG_LOG_GROWTH_INCREMENT_PERCENT* = 0x00000010
  TXFS_START_RM_FLAG_LOG_AUTO_SHRINK_PERCENTAGE* = 0x00000020
  TXFS_START_RM_FLAG_LOG_NO_CONTAINER_COUNT_MAX* = 0x00000040
  TXFS_START_RM_FLAG_LOG_NO_CONTAINER_COUNT_MIN* = 0x00000080
  TXFS_START_RM_FLAG_RECOVER_BEST_EFFORT* = 0x00000200
  TXFS_START_RM_FLAG_LOGGING_MODE* = 0x00000400
  TXFS_START_RM_FLAG_PRESERVE_CHANGES* = 0x00000800
  TXFS_START_RM_FLAG_PREFER_CONSISTENCY* = 0x00001000
  TXFS_START_RM_FLAG_PREFER_AVAILABILITY* = 0x00002000
  TXFS_START_RM_VALID_FLAGS* = TXFS_START_RM_FLAG_LOG_CONTAINER_COUNT_MAX or TXFS_START_RM_FLAG_LOG_CONTAINER_COUNT_MIN or TXFS_START_RM_FLAG_LOG_CONTAINER_SIZE or TXFS_START_RM_FLAG_LOG_GROWTH_INCREMENT_NUM_CONTAINERS or TXFS_START_RM_FLAG_LOG_GROWTH_INCREMENT_PERCENT or TXFS_START_RM_FLAG_LOG_AUTO_SHRINK_PERCENTAGE or TXFS_START_RM_FLAG_RECOVER_BEST_EFFORT or TXFS_START_RM_FLAG_LOG_NO_CONTAINER_COUNT_MAX or TXFS_START_RM_FLAG_LOGGING_MODE or TXFS_START_RM_FLAG_PRESERVE_CHANGES or TXFS_START_RM_FLAG_PREFER_CONSISTENCY or TXFS_START_RM_FLAG_PREFER_AVAILABILITY
  TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY_FLAG_CREATED* = 0x00000001
  TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY_FLAG_DELETED* = 0x000000012
  TXFS_TRANSACTED_VERSION_NONTRANSACTED* = 0xFFFFFFFE'i32
  TXFS_TRANSACTED_VERSION_UNCOMMITTED* = 0xFFFFFFFF'i32
  TXFS_SAVEPOINT_SET* = 1
  TXFS_SAVEPOINT_ROLLBACK* = 2
  TXFS_SAVEPOINT_CLEAR* = 4
  TXFS_SAVEPOINT_CLEAR_ALL* = 16
  writeCacheTypeUnknown* = 0
  writeCacheTypeNone* = 1
  writeCacheTypeWriteBack* = 2
  writeCacheTypeWriteThrough* = 3
  writeCacheEnableUnknown* = 0
  writeCacheDisabled* = 1
  writeCacheEnabled* = 2
  writeCacheChangeUnknown* = 0
  writeCacheNotChangeable* = 1
  writeCacheChangeable* = 2
  writeThroughUnknown* = 0
  writeThroughNotSupported* = 1
  writeThroughSupported* = 2
  storagePortCodeSetReserved* = 0
  storagePortCodeSetStorport* = 1
  storagePortCodeSetSCSIport* = 2
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY_ATTRIBUTE_MASK* = 0xff000000'i32
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY_FLAG_PAGE_FILE* = 0x00000001
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY_FLAG_DENY_DEFRAG_SET* = 0x00000002
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY_FLAG_FS_SYSTEM_FILE* = 0x00000004
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY_FLAG_TXF_SYSTEM_FILE* = 0x00000008
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY_ATTRIBUTE_DATA* = 0x01000000
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY_ATTRIBUTE_INDEX* = 0x02000000
  LOOKUP_STREAM_FROM_CLUSTER_ENTRY_ATTRIBUTE_SYSTEM* = 0x03000000
  FSCTL_QUERY_DEPENDENT_VOLUME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,124, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_SD_GLOBAL_CHANGE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,125, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_LOOKUP_STREAM_FROM_CLUSTER* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,127, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_TXFS_WRITE_BACKUP_INFORMATION2* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,128, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_FILE_TYPE_NOTIFICATION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,129, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_GET_BOOT_AREA_INFO* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,140, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_GET_RETRIEVAL_POINTER_BASE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,141, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_SET_PERSISTENT_VOLUME_STATE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 142, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_QUERY_PERSISTENT_VOLUME_STATE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 143, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_REQUEST_OPLOCK* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,144,METHOD_BUFFERED,FILE_ANY_ACCESS)
  FSCTL_CSV_TUNNEL_REQUEST* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 145, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_IS_CSV_FILE* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 146, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_QUERY_FILE_SYSTEM_RECOGNITION* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,147, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_CSV_GET_VOLUME_PATH_NAME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM,148, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_CSV_GET_VOLUME_NAME_FOR_VOLUME_MOUNT_POINT* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 149, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_CSV_GET_VOLUME_PATH_NAMES_FOR_VOLUME_NAME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 150, METHOD_BUFFERED, FILE_ANY_ACCESS)
  FSCTL_IS_FILE_ON_CSV_VOLUME* = CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 151, METHOD_BUFFERED, FILE_ANY_ACCESS)
  IOCTL_VOLUME_BASE* = (DWORD) 'V'
  IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS* = CTL_CODE(IOCTL_VOLUME_BASE,0,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_VOLUME_SUPPORTS_ONLINE_OFFLINE* = CTL_CODE(IOCTL_VOLUME_BASE,1,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_VOLUME_ONLINE* = CTL_CODE(IOCTL_VOLUME_BASE,2,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_VOLUME_OFFLINE* = CTL_CODE(IOCTL_VOLUME_BASE,3,METHOD_BUFFERED,FILE_READ_ACCESS or FILE_WRITE_ACCESS)
  IOCTL_VOLUME_IS_OFFLINE* = CTL_CODE(IOCTL_VOLUME_BASE,4,METHOD_BUFFERED, FILE_ANY_ACCESS)
  IOCTL_VOLUME_IS_IO_CAPABLE* = CTL_CODE(IOCTL_VOLUME_BASE,5,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_VOLUME_QUERY_FAILOVER_SET* = CTL_CODE(IOCTL_VOLUME_BASE,6,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_VOLUME_QUERY_VOLUME_NUMBER* = CTL_CODE(IOCTL_VOLUME_BASE,7,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_VOLUME_LOGICAL_TO_PHYSICAL* = CTL_CODE(IOCTL_VOLUME_BASE,8,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_VOLUME_PHYSICAL_TO_LOGICAL* = CTL_CODE(IOCTL_VOLUME_BASE,9,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_VOLUME_IS_CLUSTERED* = CTL_CODE(IOCTL_VOLUME_BASE,12,METHOD_BUFFERED,FILE_ANY_ACCESS)
  IOCTL_VOLUME_GET_GPT_ATTRIBUTES* = CTL_CODE(IOCTL_VOLUME_BASE,14,METHOD_BUFFERED,FILE_ANY_ACCESS)
  HISTOGRAM_BUCKET_SIZE* = 0x00000008
  DISK_HISTOGRAM_SIZE* = 0x00000048
type
  FILE_SYSTEM_RECOGNITION_STRUCTURE* {.pure.} = object
    Jmp*: array[3, UCHAR]
    FsName*: array[8, UCHAR]
    MustBeZero*: array[5, UCHAR]
    Identifier*: ULONG
    Length*: USHORT
    Checksum*: USHORT
proc `Mbr=`*(self: var SET_PARTITION_INFORMATION_EX, x: SET_PARTITION_INFORMATION_MBR) {.inline.} = self.union1.Mbr = x
proc Mbr*(self: SET_PARTITION_INFORMATION_EX): SET_PARTITION_INFORMATION_MBR {.inline.} = self.union1.Mbr
proc Mbr*(self: var SET_PARTITION_INFORMATION_EX): var SET_PARTITION_INFORMATION_MBR {.inline.} = self.union1.Mbr
proc `Gpt=`*(self: var SET_PARTITION_INFORMATION_EX, x: SET_PARTITION_INFORMATION_GPT) {.inline.} = self.union1.Gpt = x
proc Gpt*(self: SET_PARTITION_INFORMATION_EX): SET_PARTITION_INFORMATION_GPT {.inline.} = self.union1.Gpt
proc Gpt*(self: var SET_PARTITION_INFORMATION_EX): var SET_PARTITION_INFORMATION_GPT {.inline.} = self.union1.Gpt
proc `Mbr=`*(self: var CREATE_DISK, x: CREATE_DISK_MBR) {.inline.} = self.union1.Mbr = x
proc Mbr*(self: CREATE_DISK): CREATE_DISK_MBR {.inline.} = self.union1.Mbr
proc Mbr*(self: var CREATE_DISK): var CREATE_DISK_MBR {.inline.} = self.union1.Mbr
proc `Gpt=`*(self: var CREATE_DISK, x: CREATE_DISK_GPT) {.inline.} = self.union1.Gpt = x
proc Gpt*(self: CREATE_DISK): CREATE_DISK_GPT {.inline.} = self.union1.Gpt
proc Gpt*(self: var CREATE_DISK): var CREATE_DISK_GPT {.inline.} = self.union1.Gpt
proc `Mbr=`*(self: var PARTITION_INFORMATION_EX, x: PARTITION_INFORMATION_MBR) {.inline.} = self.union1.Mbr = x
proc Mbr*(self: PARTITION_INFORMATION_EX): PARTITION_INFORMATION_MBR {.inline.} = self.union1.Mbr
proc Mbr*(self: var PARTITION_INFORMATION_EX): var PARTITION_INFORMATION_MBR {.inline.} = self.union1.Mbr
proc `Gpt=`*(self: var PARTITION_INFORMATION_EX, x: PARTITION_INFORMATION_GPT) {.inline.} = self.union1.Gpt = x
proc Gpt*(self: PARTITION_INFORMATION_EX): PARTITION_INFORMATION_GPT {.inline.} = self.union1.Gpt
proc Gpt*(self: var PARTITION_INFORMATION_EX): var PARTITION_INFORMATION_GPT {.inline.} = self.union1.Gpt
proc `Mbr=`*(self: var DRIVE_LAYOUT_INFORMATION_EX, x: DRIVE_LAYOUT_INFORMATION_MBR) {.inline.} = self.union1.Mbr = x
proc Mbr*(self: DRIVE_LAYOUT_INFORMATION_EX): DRIVE_LAYOUT_INFORMATION_MBR {.inline.} = self.union1.Mbr
proc Mbr*(self: var DRIVE_LAYOUT_INFORMATION_EX): var DRIVE_LAYOUT_INFORMATION_MBR {.inline.} = self.union1.Mbr
proc `Gpt=`*(self: var DRIVE_LAYOUT_INFORMATION_EX, x: DRIVE_LAYOUT_INFORMATION_GPT) {.inline.} = self.union1.Gpt = x
proc Gpt*(self: DRIVE_LAYOUT_INFORMATION_EX): DRIVE_LAYOUT_INFORMATION_GPT {.inline.} = self.union1.Gpt
proc Gpt*(self: var DRIVE_LAYOUT_INFORMATION_EX): var DRIVE_LAYOUT_INFORMATION_GPT {.inline.} = self.union1.Gpt
proc `Int13=`*(self: var DISK_DETECTION_INFO, x: DISK_INT13_INFO) {.inline.} = self.union1.struct1.Int13 = x
proc Int13*(self: DISK_DETECTION_INFO): DISK_INT13_INFO {.inline.} = self.union1.struct1.Int13
proc Int13*(self: var DISK_DETECTION_INFO): var DISK_INT13_INFO {.inline.} = self.union1.struct1.Int13
proc `ExInt13=`*(self: var DISK_DETECTION_INFO, x: DISK_EX_INT13_INFO) {.inline.} = self.union1.struct1.ExInt13 = x
proc ExInt13*(self: DISK_DETECTION_INFO): DISK_EX_INT13_INFO {.inline.} = self.union1.struct1.ExInt13
proc ExInt13*(self: var DISK_DETECTION_INFO): var DISK_EX_INT13_INFO {.inline.} = self.union1.struct1.ExInt13
proc `Mbr=`*(self: var DISK_PARTITION_INFO, x: DISK_PARTITION_INFO_UNION1_Mbr) {.inline.} = self.union1.Mbr = x
proc Mbr*(self: DISK_PARTITION_INFO): DISK_PARTITION_INFO_UNION1_Mbr {.inline.} = self.union1.Mbr
proc Mbr*(self: var DISK_PARTITION_INFO): var DISK_PARTITION_INFO_UNION1_Mbr {.inline.} = self.union1.Mbr
proc `Gpt=`*(self: var DISK_PARTITION_INFO, x: DISK_PARTITION_INFO_UNION1_Gpt) {.inline.} = self.union1.Gpt = x
proc Gpt*(self: DISK_PARTITION_INFO): DISK_PARTITION_INFO_UNION1_Gpt {.inline.} = self.union1.Gpt
proc Gpt*(self: var DISK_PARTITION_INFO): var DISK_PARTITION_INFO_UNION1_Gpt {.inline.} = self.union1.Gpt
proc `ScalarPrefetch=`*(self: var DISK_CACHE_INFORMATION, x: DISK_CACHE_INFORMATION_UNION1_ScalarPrefetch) {.inline.} = self.union1.ScalarPrefetch = x
proc ScalarPrefetch*(self: DISK_CACHE_INFORMATION): DISK_CACHE_INFORMATION_UNION1_ScalarPrefetch {.inline.} = self.union1.ScalarPrefetch
proc ScalarPrefetch*(self: var DISK_CACHE_INFORMATION): var DISK_CACHE_INFORMATION_UNION1_ScalarPrefetch {.inline.} = self.union1.ScalarPrefetch
proc `BlockPrefetch=`*(self: var DISK_CACHE_INFORMATION, x: DISK_CACHE_INFORMATION_UNION1_BlockPrefetch) {.inline.} = self.union1.BlockPrefetch = x
proc BlockPrefetch*(self: DISK_CACHE_INFORMATION): DISK_CACHE_INFORMATION_UNION1_BlockPrefetch {.inline.} = self.union1.BlockPrefetch
proc BlockPrefetch*(self: var DISK_CACHE_INFORMATION): var DISK_CACHE_INFORMATION_UNION1_BlockPrefetch {.inline.} = self.union1.BlockPrefetch
proc `BirthVolumeId=`*(self: var FILE_OBJECTID_BUFFER, x: array[16, BYTE]) {.inline.} = self.union1.struct1.BirthVolumeId = x
proc BirthVolumeId*(self: FILE_OBJECTID_BUFFER): array[16, BYTE] {.inline.} = self.union1.struct1.BirthVolumeId
proc BirthVolumeId*(self: var FILE_OBJECTID_BUFFER): var array[16, BYTE] {.inline.} = self.union1.struct1.BirthVolumeId
proc `BirthObjectId=`*(self: var FILE_OBJECTID_BUFFER, x: array[16, BYTE]) {.inline.} = self.union1.struct1.BirthObjectId = x
proc BirthObjectId*(self: FILE_OBJECTID_BUFFER): array[16, BYTE] {.inline.} = self.union1.struct1.BirthObjectId
proc BirthObjectId*(self: var FILE_OBJECTID_BUFFER): var array[16, BYTE] {.inline.} = self.union1.struct1.BirthObjectId
proc `DomainId=`*(self: var FILE_OBJECTID_BUFFER, x: array[16, BYTE]) {.inline.} = self.union1.struct1.DomainId = x
proc DomainId*(self: FILE_OBJECTID_BUFFER): array[16, BYTE] {.inline.} = self.union1.struct1.DomainId
proc DomainId*(self: var FILE_OBJECTID_BUFFER): var array[16, BYTE] {.inline.} = self.union1.struct1.DomainId
proc `ExtendedInfo=`*(self: var FILE_OBJECTID_BUFFER, x: array[48, BYTE]) {.inline.} = self.union1.ExtendedInfo = x
proc ExtendedInfo*(self: FILE_OBJECTID_BUFFER): array[48, BYTE] {.inline.} = self.union1.ExtendedInfo
proc ExtendedInfo*(self: var FILE_OBJECTID_BUFFER): var array[48, BYTE] {.inline.} = self.union1.ExtendedInfo
proc `BufferLength=`*(self: var TXFS_READ_BACKUP_INFORMATION_OUT, x: ULONG) {.inline.} = self.union1.BufferLength = x
proc BufferLength*(self: TXFS_READ_BACKUP_INFORMATION_OUT): ULONG {.inline.} = self.union1.BufferLength
proc BufferLength*(self: var TXFS_READ_BACKUP_INFORMATION_OUT): var ULONG {.inline.} = self.union1.BufferLength
proc `Buffer=`*(self: var TXFS_READ_BACKUP_INFORMATION_OUT, x: UCHAR) {.inline.} = self.union1.Buffer = x
proc Buffer*(self: TXFS_READ_BACKUP_INFORMATION_OUT): UCHAR {.inline.} = self.union1.Buffer
proc Buffer*(self: var TXFS_READ_BACKUP_INFORMATION_OUT): var UCHAR {.inline.} = self.union1.Buffer
when winimCpu64:
  type
    MOVE_FILE_DATA32* {.pure.} = object
      FileHandle*: UINT32
      StartingVcn*: LARGE_INTEGER
      StartingLcn*: LARGE_INTEGER
      ClusterCount*: DWORD
    PMOVE_FILE_DATA32* = ptr MOVE_FILE_DATA32
    MARK_HANDLE_INFO32* {.pure.} = object
      UsnSourceInfo*: DWORD
      VolumeHandle*: UINT32
      HandleInfo*: DWORD
    PMARK_HANDLE_INFO32* = ptr MARK_HANDLE_INFO32
