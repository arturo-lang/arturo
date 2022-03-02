#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import winerror
import wingdi
#include <winspool.h>
type
  BIDI_TYPE* = int32
  PRINTER_OPTION_FLAGS* = int32
  EPrintXPSJobOperation* = int32
  EPrintXPSJobProgress* = int32
  PRINTER_INFO_1A* {.pure.} = object
    Flags*: DWORD
    pDescription*: LPSTR
    pName*: LPSTR
    pComment*: LPSTR
  PPRINTER_INFO_1A* = ptr PRINTER_INFO_1A
  LPPRINTER_INFO_1A* = ptr PRINTER_INFO_1A
  PRINTER_INFO_1W* {.pure.} = object
    Flags*: DWORD
    pDescription*: LPWSTR
    pName*: LPWSTR
    pComment*: LPWSTR
  PPRINTER_INFO_1W* = ptr PRINTER_INFO_1W
  LPPRINTER_INFO_1W* = ptr PRINTER_INFO_1W
  PRINTER_INFO_2A* {.pure.} = object
    pServerName*: LPSTR
    pPrinterName*: LPSTR
    pShareName*: LPSTR
    pPortName*: LPSTR
    pDriverName*: LPSTR
    pComment*: LPSTR
    pLocation*: LPSTR
    pDevMode*: LPDEVMODEA
    pSepFile*: LPSTR
    pPrintProcessor*: LPSTR
    pDatatype*: LPSTR
    pParameters*: LPSTR
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
    Attributes*: DWORD
    Priority*: DWORD
    DefaultPriority*: DWORD
    StartTime*: DWORD
    UntilTime*: DWORD
    Status*: DWORD
    cJobs*: DWORD
    AveragePPM*: DWORD
  PPRINTER_INFO_2A* = ptr PRINTER_INFO_2A
  LPPRINTER_INFO_2A* = ptr PRINTER_INFO_2A
  PRINTER_INFO_2W* {.pure.} = object
    pServerName*: LPWSTR
    pPrinterName*: LPWSTR
    pShareName*: LPWSTR
    pPortName*: LPWSTR
    pDriverName*: LPWSTR
    pComment*: LPWSTR
    pLocation*: LPWSTR
    pDevMode*: LPDEVMODEW
    pSepFile*: LPWSTR
    pPrintProcessor*: LPWSTR
    pDatatype*: LPWSTR
    pParameters*: LPWSTR
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
    Attributes*: DWORD
    Priority*: DWORD
    DefaultPriority*: DWORD
    StartTime*: DWORD
    UntilTime*: DWORD
    Status*: DWORD
    cJobs*: DWORD
    AveragePPM*: DWORD
  PPRINTER_INFO_2W* = ptr PRINTER_INFO_2W
  LPPRINTER_INFO_2W* = ptr PRINTER_INFO_2W
  PRINTER_INFO_3* {.pure.} = object
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
  PPRINTER_INFO_3* = ptr PRINTER_INFO_3
  LPPRINTER_INFO_3* = ptr PRINTER_INFO_3
  PRINTER_INFO_4A* {.pure.} = object
    pPrinterName*: LPSTR
    pServerName*: LPSTR
    Attributes*: DWORD
  PPRINTER_INFO_4A* = ptr PRINTER_INFO_4A
  LPPRINTER_INFO_4A* = ptr PRINTER_INFO_4A
  PRINTER_INFO_4W* {.pure.} = object
    pPrinterName*: LPWSTR
    pServerName*: LPWSTR
    Attributes*: DWORD
  PPRINTER_INFO_4W* = ptr PRINTER_INFO_4W
  LPPRINTER_INFO_4W* = ptr PRINTER_INFO_4W
  PRINTER_INFO_5A* {.pure.} = object
    pPrinterName*: LPSTR
    pPortName*: LPSTR
    Attributes*: DWORD
    DeviceNotSelectedTimeout*: DWORD
    TransmissionRetryTimeout*: DWORD
  PPRINTER_INFO_5A* = ptr PRINTER_INFO_5A
  LPPRINTER_INFO_5A* = ptr PRINTER_INFO_5A
  PRINTER_INFO_5W* {.pure.} = object
    pPrinterName*: LPWSTR
    pPortName*: LPWSTR
    Attributes*: DWORD
    DeviceNotSelectedTimeout*: DWORD
    TransmissionRetryTimeout*: DWORD
  PPRINTER_INFO_5W* = ptr PRINTER_INFO_5W
  LPPRINTER_INFO_5W* = ptr PRINTER_INFO_5W
  PRINTER_INFO_6* {.pure.} = object
    dwStatus*: DWORD
  PPRINTER_INFO_6* = ptr PRINTER_INFO_6
  LPPRINTER_INFO_6* = ptr PRINTER_INFO_6
  PRINTER_INFO_7A* {.pure.} = object
    pszObjectGUID*: LPSTR
    dwAction*: DWORD
  PPRINTER_INFO_7A* = ptr PRINTER_INFO_7A
  LPPRINTER_INFO_7A* = ptr PRINTER_INFO_7A
  PRINTER_INFO_7W* {.pure.} = object
    pszObjectGUID*: LPWSTR
    dwAction*: DWORD
  PPRINTER_INFO_7W* = ptr PRINTER_INFO_7W
  LPPRINTER_INFO_7W* = ptr PRINTER_INFO_7W
  PRINTER_INFO_8A* {.pure.} = object
    pDevMode*: LPDEVMODEA
  PPRINTER_INFO_8A* = ptr PRINTER_INFO_8A
  LPPRINTER_INFO_8A* = ptr PRINTER_INFO_8A
  PRINTER_INFO_8W* {.pure.} = object
    pDevMode*: LPDEVMODEW
  PPRINTER_INFO_8W* = ptr PRINTER_INFO_8W
  LPPRINTER_INFO_8W* = ptr PRINTER_INFO_8W
  PRINTER_INFO_9A* {.pure.} = object
    pDevMode*: LPDEVMODEA
  PPRINTER_INFO_9A* = ptr PRINTER_INFO_9A
  LPPRINTER_INFO_9A* = ptr PRINTER_INFO_9A
  PRINTER_INFO_9W* {.pure.} = object
    pDevMode*: LPDEVMODEW
  PPRINTER_INFO_9W* = ptr PRINTER_INFO_9W
  LPPRINTER_INFO_9W* = ptr PRINTER_INFO_9W
  JOB_INFO_1A* {.pure.} = object
    JobId*: DWORD
    pPrinterName*: LPSTR
    pMachineName*: LPSTR
    pUserName*: LPSTR
    pDocument*: LPSTR
    pDatatype*: LPSTR
    pStatus*: LPSTR
    Status*: DWORD
    Priority*: DWORD
    Position*: DWORD
    TotalPages*: DWORD
    PagesPrinted*: DWORD
    Submitted*: SYSTEMTIME
  PJOB_INFO_1A* = ptr JOB_INFO_1A
  LPJOB_INFO_1A* = ptr JOB_INFO_1A
  JOB_INFO_1W* {.pure.} = object
    JobId*: DWORD
    pPrinterName*: LPWSTR
    pMachineName*: LPWSTR
    pUserName*: LPWSTR
    pDocument*: LPWSTR
    pDatatype*: LPWSTR
    pStatus*: LPWSTR
    Status*: DWORD
    Priority*: DWORD
    Position*: DWORD
    TotalPages*: DWORD
    PagesPrinted*: DWORD
    Submitted*: SYSTEMTIME
  PJOB_INFO_1W* = ptr JOB_INFO_1W
  LPJOB_INFO_1W* = ptr JOB_INFO_1W
  JOB_INFO_2A* {.pure.} = object
    JobId*: DWORD
    pPrinterName*: LPSTR
    pMachineName*: LPSTR
    pUserName*: LPSTR
    pDocument*: LPSTR
    pNotifyName*: LPSTR
    pDatatype*: LPSTR
    pPrintProcessor*: LPSTR
    pParameters*: LPSTR
    pDriverName*: LPSTR
    pDevMode*: LPDEVMODEA
    pStatus*: LPSTR
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
    Status*: DWORD
    Priority*: DWORD
    Position*: DWORD
    StartTime*: DWORD
    UntilTime*: DWORD
    TotalPages*: DWORD
    Size*: DWORD
    Submitted*: SYSTEMTIME
    Time*: DWORD
    PagesPrinted*: DWORD
  PJOB_INFO_2A* = ptr JOB_INFO_2A
  LPJOB_INFO_2A* = ptr JOB_INFO_2A
  JOB_INFO_2W* {.pure.} = object
    JobId*: DWORD
    pPrinterName*: LPWSTR
    pMachineName*: LPWSTR
    pUserName*: LPWSTR
    pDocument*: LPWSTR
    pNotifyName*: LPWSTR
    pDatatype*: LPWSTR
    pPrintProcessor*: LPWSTR
    pParameters*: LPWSTR
    pDriverName*: LPWSTR
    pDevMode*: LPDEVMODEW
    pStatus*: LPWSTR
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
    Status*: DWORD
    Priority*: DWORD
    Position*: DWORD
    StartTime*: DWORD
    UntilTime*: DWORD
    TotalPages*: DWORD
    Size*: DWORD
    Submitted*: SYSTEMTIME
    Time*: DWORD
    PagesPrinted*: DWORD
  PJOB_INFO_2W* = ptr JOB_INFO_2W
  LPJOB_INFO_2W* = ptr JOB_INFO_2W
  JOB_INFO_3* {.pure.} = object
    JobId*: DWORD
    NextJobId*: DWORD
    Reserved*: DWORD
  PJOB_INFO_3* = ptr JOB_INFO_3
  LPJOB_INFO_3* = ptr JOB_INFO_3
  ADDJOB_INFO_1A* {.pure.} = object
    Path*: LPSTR
    JobId*: DWORD
  PADDJOB_INFO_1A* = ptr ADDJOB_INFO_1A
  LPADDJOB_INFO_1A* = ptr ADDJOB_INFO_1A
  ADDJOB_INFO_1W* {.pure.} = object
    Path*: LPWSTR
    JobId*: DWORD
  PADDJOB_INFO_1W* = ptr ADDJOB_INFO_1W
  LPADDJOB_INFO_1W* = ptr ADDJOB_INFO_1W
  DRIVER_INFO_1A* {.pure.} = object
    pName*: LPSTR
  PDRIVER_INFO_1A* = ptr DRIVER_INFO_1A
  LPDRIVER_INFO_1A* = ptr DRIVER_INFO_1A
  DRIVER_INFO_1W* {.pure.} = object
    pName*: LPWSTR
  PDRIVER_INFO_1W* = ptr DRIVER_INFO_1W
  LPDRIVER_INFO_1W* = ptr DRIVER_INFO_1W
  DRIVER_INFO_2A* {.pure.} = object
    cVersion*: DWORD
    pName*: LPSTR
    pEnvironment*: LPSTR
    pDriverPath*: LPSTR
    pDataFile*: LPSTR
    pConfigFile*: LPSTR
  PDRIVER_INFO_2A* = ptr DRIVER_INFO_2A
  LPDRIVER_INFO_2A* = ptr DRIVER_INFO_2A
  DRIVER_INFO_2W* {.pure.} = object
    cVersion*: DWORD
    pName*: LPWSTR
    pEnvironment*: LPWSTR
    pDriverPath*: LPWSTR
    pDataFile*: LPWSTR
    pConfigFile*: LPWSTR
  PDRIVER_INFO_2W* = ptr DRIVER_INFO_2W
  LPDRIVER_INFO_2W* = ptr DRIVER_INFO_2W
  DRIVER_INFO_3A* {.pure.} = object
    cVersion*: DWORD
    pName*: LPSTR
    pEnvironment*: LPSTR
    pDriverPath*: LPSTR
    pDataFile*: LPSTR
    pConfigFile*: LPSTR
    pHelpFile*: LPSTR
    pDependentFiles*: LPSTR
    pMonitorName*: LPSTR
    pDefaultDataType*: LPSTR
  PDRIVER_INFO_3A* = ptr DRIVER_INFO_3A
  LPDRIVER_INFO_3A* = ptr DRIVER_INFO_3A
  DRIVER_INFO_3W* {.pure.} = object
    cVersion*: DWORD
    pName*: LPWSTR
    pEnvironment*: LPWSTR
    pDriverPath*: LPWSTR
    pDataFile*: LPWSTR
    pConfigFile*: LPWSTR
    pHelpFile*: LPWSTR
    pDependentFiles*: LPWSTR
    pMonitorName*: LPWSTR
    pDefaultDataType*: LPWSTR
  PDRIVER_INFO_3W* = ptr DRIVER_INFO_3W
  LPDRIVER_INFO_3W* = ptr DRIVER_INFO_3W
  DRIVER_INFO_4A* {.pure.} = object
    cVersion*: DWORD
    pName*: LPSTR
    pEnvironment*: LPSTR
    pDriverPath*: LPSTR
    pDataFile*: LPSTR
    pConfigFile*: LPSTR
    pHelpFile*: LPSTR
    pDependentFiles*: LPSTR
    pMonitorName*: LPSTR
    pDefaultDataType*: LPSTR
    pszzPreviousNames*: LPSTR
  PDRIVER_INFO_4A* = ptr DRIVER_INFO_4A
  LPDRIVER_INFO_4A* = ptr DRIVER_INFO_4A
  DRIVER_INFO_4W* {.pure.} = object
    cVersion*: DWORD
    pName*: LPWSTR
    pEnvironment*: LPWSTR
    pDriverPath*: LPWSTR
    pDataFile*: LPWSTR
    pConfigFile*: LPWSTR
    pHelpFile*: LPWSTR
    pDependentFiles*: LPWSTR
    pMonitorName*: LPWSTR
    pDefaultDataType*: LPWSTR
    pszzPreviousNames*: LPWSTR
  PDRIVER_INFO_4W* = ptr DRIVER_INFO_4W
  LPDRIVER_INFO_4W* = ptr DRIVER_INFO_4W
  DRIVER_INFO_5A* {.pure.} = object
    cVersion*: DWORD
    pName*: LPSTR
    pEnvironment*: LPSTR
    pDriverPath*: LPSTR
    pDataFile*: LPSTR
    pConfigFile*: LPSTR
    dwDriverAttributes*: DWORD
    dwConfigVersion*: DWORD
    dwDriverVersion*: DWORD
  PDRIVER_INFO_5A* = ptr DRIVER_INFO_5A
  LPDRIVER_INFO_5A* = ptr DRIVER_INFO_5A
  DRIVER_INFO_5W* {.pure.} = object
    cVersion*: DWORD
    pName*: LPWSTR
    pEnvironment*: LPWSTR
    pDriverPath*: LPWSTR
    pDataFile*: LPWSTR
    pConfigFile*: LPWSTR
    dwDriverAttributes*: DWORD
    dwConfigVersion*: DWORD
    dwDriverVersion*: DWORD
  PDRIVER_INFO_5W* = ptr DRIVER_INFO_5W
  LPDRIVER_INFO_5W* = ptr DRIVER_INFO_5W
  DRIVER_INFO_6A* {.pure.} = object
    cVersion*: DWORD
    pName*: LPSTR
    pEnvironment*: LPSTR
    pDriverPath*: LPSTR
    pDataFile*: LPSTR
    pConfigFile*: LPSTR
    pHelpFile*: LPSTR
    pDependentFiles*: LPSTR
    pMonitorName*: LPSTR
    pDefaultDataType*: LPSTR
    pszzPreviousNames*: LPSTR
    ftDriverDate*: FILETIME
    dwlDriverVersion*: DWORDLONG
    pszMfgName*: LPSTR
    pszOEMUrl*: LPSTR
    pszHardwareID*: LPSTR
    pszProvider*: LPSTR
  PDRIVER_INFO_6A* = ptr DRIVER_INFO_6A
  LPDRIVER_INFO_6A* = ptr DRIVER_INFO_6A
  DRIVER_INFO_6W* {.pure.} = object
    cVersion*: DWORD
    pName*: LPWSTR
    pEnvironment*: LPWSTR
    pDriverPath*: LPWSTR
    pDataFile*: LPWSTR
    pConfigFile*: LPWSTR
    pHelpFile*: LPWSTR
    pDependentFiles*: LPWSTR
    pMonitorName*: LPWSTR
    pDefaultDataType*: LPWSTR
    pszzPreviousNames*: LPWSTR
    ftDriverDate*: FILETIME
    dwlDriverVersion*: DWORDLONG
    pszMfgName*: LPWSTR
    pszOEMUrl*: LPWSTR
    pszHardwareID*: LPWSTR
    pszProvider*: LPWSTR
  PDRIVER_INFO_6W* = ptr DRIVER_INFO_6W
  LPDRIVER_INFO_6W* = ptr DRIVER_INFO_6W
  DOC_INFO_1A* {.pure.} = object
    pDocName*: LPSTR
    pOutputFile*: LPSTR
    pDatatype*: LPSTR
  PDOC_INFO_1A* = ptr DOC_INFO_1A
  LPDOC_INFO_1A* = ptr DOC_INFO_1A
  DOC_INFO_1W* {.pure.} = object
    pDocName*: LPWSTR
    pOutputFile*: LPWSTR
    pDatatype*: LPWSTR
  PDOC_INFO_1W* = ptr DOC_INFO_1W
  LPDOC_INFO_1W* = ptr DOC_INFO_1W
  FORM_INFO_1A* {.pure.} = object
    Flags*: DWORD
    pName*: LPSTR
    Size*: SIZEL
    ImageableArea*: RECTL
  PFORM_INFO_1A* = ptr FORM_INFO_1A
  LPFORM_INFO_1A* = ptr FORM_INFO_1A
  FORM_INFO_1W* {.pure.} = object
    Flags*: DWORD
    pName*: LPWSTR
    Size*: SIZEL
    ImageableArea*: RECTL
  PFORM_INFO_1W* = ptr FORM_INFO_1W
  LPFORM_INFO_1W* = ptr FORM_INFO_1W
  DOC_INFO_2A* {.pure.} = object
    pDocName*: LPSTR
    pOutputFile*: LPSTR
    pDatatype*: LPSTR
    dwMode*: DWORD
    JobId*: DWORD
  PDOC_INFO_2A* = ptr DOC_INFO_2A
  LPDOC_INFO_2A* = ptr DOC_INFO_2A
  DOC_INFO_2W* {.pure.} = object
    pDocName*: LPWSTR
    pOutputFile*: LPWSTR
    pDatatype*: LPWSTR
    dwMode*: DWORD
    JobId*: DWORD
  PDOC_INFO_2W* = ptr DOC_INFO_2W
  LPDOC_INFO_2W* = ptr DOC_INFO_2W
  DOC_INFO_3A* {.pure.} = object
    pDocName*: LPSTR
    pOutputFile*: LPSTR
    pDatatype*: LPSTR
    dwFlags*: DWORD
  PDOC_INFO_3A* = ptr DOC_INFO_3A
  LPDOC_INFO_3A* = ptr DOC_INFO_3A
  DOC_INFO_3W* {.pure.} = object
    pDocName*: LPWSTR
    pOutputFile*: LPWSTR
    pDatatype*: LPWSTR
    dwFlags*: DWORD
  PDOC_INFO_3W* = ptr DOC_INFO_3W
  LPDOC_INFO_3W* = ptr DOC_INFO_3W
  PRINTPROCESSOR_INFO_1A* {.pure.} = object
    pName*: LPSTR
  PPRINTPROCESSOR_INFO_1A* = ptr PRINTPROCESSOR_INFO_1A
  LPPRINTPROCESSOR_INFO_1A* = ptr PRINTPROCESSOR_INFO_1A
  PRINTPROCESSOR_INFO_1W* {.pure.} = object
    pName*: LPWSTR
  PPRINTPROCESSOR_INFO_1W* = ptr PRINTPROCESSOR_INFO_1W
  LPPRINTPROCESSOR_INFO_1W* = ptr PRINTPROCESSOR_INFO_1W
  PRINTPROCESSOR_CAPS_1* {.pure.} = object
    dwLevel*: DWORD
    dwNupOptions*: DWORD
    dwPageOrderFlags*: DWORD
    dwNumberOfCopies*: DWORD
  PPRINTPROCESSOR_CAPS_1* = ptr PRINTPROCESSOR_CAPS_1
  PORT_INFO_1A* {.pure.} = object
    pName*: LPSTR
  PPORT_INFO_1A* = ptr PORT_INFO_1A
  LPPORT_INFO_1A* = ptr PORT_INFO_1A
  PORT_INFO_1W* {.pure.} = object
    pName*: LPWSTR
  PPORT_INFO_1W* = ptr PORT_INFO_1W
  LPPORT_INFO_1W* = ptr PORT_INFO_1W
  PORT_INFO_2A* {.pure.} = object
    pPortName*: LPSTR
    pMonitorName*: LPSTR
    pDescription*: LPSTR
    fPortType*: DWORD
    Reserved*: DWORD
  PPORT_INFO_2A* = ptr PORT_INFO_2A
  LPPORT_INFO_2A* = ptr PORT_INFO_2A
  PORT_INFO_2W* {.pure.} = object
    pPortName*: LPWSTR
    pMonitorName*: LPWSTR
    pDescription*: LPWSTR
    fPortType*: DWORD
    Reserved*: DWORD
  PPORT_INFO_2W* = ptr PORT_INFO_2W
  LPPORT_INFO_2W* = ptr PORT_INFO_2W
  PORT_INFO_3A* {.pure.} = object
    dwStatus*: DWORD
    pszStatus*: LPSTR
    dwSeverity*: DWORD
  PPORT_INFO_3A* = ptr PORT_INFO_3A
  LPPORT_INFO_3A* = ptr PORT_INFO_3A
  PORT_INFO_3W* {.pure.} = object
    dwStatus*: DWORD
    pszStatus*: LPWSTR
    dwSeverity*: DWORD
  PPORT_INFO_3W* = ptr PORT_INFO_3W
  LPPORT_INFO_3W* = ptr PORT_INFO_3W
  MONITOR_INFO_1A* {.pure.} = object
    pName*: LPSTR
  PMONITOR_INFO_1A* = ptr MONITOR_INFO_1A
  LPMONITOR_INFO_1A* = ptr MONITOR_INFO_1A
  MONITOR_INFO_1W* {.pure.} = object
    pName*: LPWSTR
  PMONITOR_INFO_1W* = ptr MONITOR_INFO_1W
  LPMONITOR_INFO_1W* = ptr MONITOR_INFO_1W
  MONITOR_INFO_2A* {.pure.} = object
    pName*: LPSTR
    pEnvironment*: LPSTR
    pDLLName*: LPSTR
  PMONITOR_INFO_2A* = ptr MONITOR_INFO_2A
  LPMONITOR_INFO_2A* = ptr MONITOR_INFO_2A
  MONITOR_INFO_2W* {.pure.} = object
    pName*: LPWSTR
    pEnvironment*: LPWSTR
    pDLLName*: LPWSTR
  PMONITOR_INFO_2W* = ptr MONITOR_INFO_2W
  LPMONITOR_INFO_2W* = ptr MONITOR_INFO_2W
  DATATYPES_INFO_1A* {.pure.} = object
    pName*: LPSTR
  PDATATYPES_INFO_1A* = ptr DATATYPES_INFO_1A
  LPDATATYPES_INFO_1A* = ptr DATATYPES_INFO_1A
  DATATYPES_INFO_1W* {.pure.} = object
    pName*: LPWSTR
  PDATATYPES_INFO_1W* = ptr DATATYPES_INFO_1W
  LPDATATYPES_INFO_1W* = ptr DATATYPES_INFO_1W
  PRINTER_DEFAULTSA* {.pure.} = object
    pDatatype*: LPSTR
    pDevMode*: LPDEVMODEA
    DesiredAccess*: ACCESS_MASK
  PPRINTER_DEFAULTSA* = ptr PRINTER_DEFAULTSA
  LPPRINTER_DEFAULTSA* = ptr PRINTER_DEFAULTSA
  PRINTER_DEFAULTSW* {.pure.} = object
    pDatatype*: LPWSTR
    pDevMode*: LPDEVMODEW
    DesiredAccess*: ACCESS_MASK
  PPRINTER_DEFAULTSW* = ptr PRINTER_DEFAULTSW
  LPPRINTER_DEFAULTSW* = ptr PRINTER_DEFAULTSW
  PRINTER_ENUM_VALUESA* {.pure.} = object
    pValueName*: LPSTR
    cbValueName*: DWORD
    dwType*: DWORD
    pData*: LPBYTE
    cbData*: DWORD
  PPRINTER_ENUM_VALUESA* = ptr PRINTER_ENUM_VALUESA
  LPPRINTER_ENUM_VALUESA* = ptr PRINTER_ENUM_VALUESA
  PRINTER_ENUM_VALUESW* {.pure.} = object
    pValueName*: LPWSTR
    cbValueName*: DWORD
    dwType*: DWORD
    pData*: LPBYTE
    cbData*: DWORD
  PPRINTER_ENUM_VALUESW* = ptr PRINTER_ENUM_VALUESW
  LPPRINTER_ENUM_VALUESW* = ptr PRINTER_ENUM_VALUESW
  PRINTER_NOTIFY_OPTIONS_TYPE* {.pure.} = object
    Type*: WORD
    Reserved0*: WORD
    Reserved1*: DWORD
    Reserved2*: DWORD
    Count*: DWORD
    pFields*: PWORD
  PPRINTER_NOTIFY_OPTIONS_TYPE* = ptr PRINTER_NOTIFY_OPTIONS_TYPE
  LPPRINTER_NOTIFY_OPTIONS_TYPE* = ptr PRINTER_NOTIFY_OPTIONS_TYPE
  PRINTER_NOTIFY_OPTIONS* {.pure.} = object
    Version*: DWORD
    Flags*: DWORD
    Count*: DWORD
    pTypes*: PPRINTER_NOTIFY_OPTIONS_TYPE
  PPRINTER_NOTIFY_OPTIONS* = ptr PRINTER_NOTIFY_OPTIONS
  LPPRINTER_NOTIFY_OPTIONS* = ptr PRINTER_NOTIFY_OPTIONS
  PRINTER_NOTIFY_INFO_DATA_NotifyData_Data* {.pure.} = object
    cbBuf*: DWORD
    pBuf*: LPVOID
  PRINTER_NOTIFY_INFO_DATA_NotifyData* {.pure, union.} = object
    adwData*: array[2, DWORD]
    Data*: PRINTER_NOTIFY_INFO_DATA_NotifyData_Data
  PRINTER_NOTIFY_INFO_DATA* {.pure.} = object
    Type*: WORD
    Field*: WORD
    Reserved*: DWORD
    Id*: DWORD
    NotifyData*: PRINTER_NOTIFY_INFO_DATA_NotifyData
  PPRINTER_NOTIFY_INFO_DATA* = ptr PRINTER_NOTIFY_INFO_DATA
  LPPRINTER_NOTIFY_INFO_DATA* = ptr PRINTER_NOTIFY_INFO_DATA
  PRINTER_NOTIFY_INFO* {.pure.} = object
    Version*: DWORD
    Flags*: DWORD
    Count*: DWORD
    aData*: array[1, PRINTER_NOTIFY_INFO_DATA]
  PPRINTER_NOTIFY_INFO* = ptr PRINTER_NOTIFY_INFO
  LPPRINTER_NOTIFY_INFO* = ptr PRINTER_NOTIFY_INFO
  BINARY_CONTAINER* {.pure.} = object
    cbBuf*: DWORD
    pData*: LPBYTE
  PBINARY_CONTAINER* = ptr BINARY_CONTAINER
  BIDI_DATA_u* {.pure, union.} = object
    bData*: WINBOOL
    iData*: LONG
    sData*: LPWSTR
    fData*: FLOAT
    biData*: BINARY_CONTAINER
  BIDI_DATA* {.pure.} = object
    dwBidiType*: DWORD
    u*: BIDI_DATA_u
  PBIDI_DATA* = ptr BIDI_DATA
  LPBIDI_DATA* = ptr BIDI_DATA
  BIDI_REQUEST_DATA* {.pure.} = object
    dwReqNumber*: DWORD
    pSchema*: LPWSTR
    data*: BIDI_DATA
  PBIDI_REQUEST_DATA* = ptr BIDI_REQUEST_DATA
  LPBIDI_REQUEST_DATA* = ptr BIDI_REQUEST_DATA
  BIDI_REQUEST_CONTAINER* {.pure.} = object
    Version*: DWORD
    Flags*: DWORD
    Count*: DWORD
    aData*: array[1 , BIDI_REQUEST_DATA]
  PBIDI_REQUEST_CONTAINER* = ptr BIDI_REQUEST_CONTAINER
  LPBIDI_REQUEST_CONTAINER* = ptr BIDI_REQUEST_CONTAINER
  BIDI_RESPONSE_DATA* {.pure.} = object
    dwResult*: DWORD
    dwReqNumber*: DWORD
    pSchema*: LPWSTR
    data*: BIDI_DATA
  PBIDI_RESPONSE_DATA* = ptr BIDI_RESPONSE_DATA
  LPBIDI_RESPONSE_DATA* = ptr BIDI_RESPONSE_DATA
  BIDI_RESPONSE_CONTAINER* {.pure.} = object
    Version*: DWORD
    Flags*: DWORD
    Count*: DWORD
    aData*: array[1 , BIDI_RESPONSE_DATA]
  PBIDI_RESPONSE_CONTAINER* = ptr BIDI_RESPONSE_CONTAINER
  LPBIDI_RESPONSE_CONTAINER* = ptr BIDI_RESPONSE_CONTAINER
  PROVIDOR_INFO_1A* {.pure.} = object
    pName*: LPSTR
    pEnvironment*: LPSTR
    pDLLName*: LPSTR
  PPROVIDOR_INFO_1A* = ptr PROVIDOR_INFO_1A
  LPPROVIDOR_INFO_1A* = ptr PROVIDOR_INFO_1A
  PROVIDOR_INFO_1W* {.pure.} = object
    pName*: LPWSTR
    pEnvironment*: LPWSTR
    pDLLName*: LPWSTR
  PPROVIDOR_INFO_1W* = ptr PROVIDOR_INFO_1W
  LPPROVIDOR_INFO_1W* = ptr PROVIDOR_INFO_1W
  PROVIDOR_INFO_2A* {.pure.} = object
    pOrder*: LPSTR
  PPROVIDOR_INFO_2A* = ptr PROVIDOR_INFO_2A
  LPPROVIDOR_INFO_2A* = ptr PROVIDOR_INFO_2A
  PROVIDOR_INFO_2W* {.pure.} = object
    pOrder*: LPWSTR
  PPROVIDOR_INFO_2W* = ptr PROVIDOR_INFO_2W
  LPPROVIDOR_INFO_2W* = ptr PROVIDOR_INFO_2W
  PRINTER_CONNECTION_INFO_1* {.pure.} = object
    dwFlags*: DWORD
    pszDriverName*: LPTSTR
  PPRINTER_CONNECTION_INFO_1* = ptr PRINTER_CONNECTION_INFO_1
  DRIVER_INFO_8W* {.pure.} = object
    cVersion*: DWORD
    pName*: LPWSTR
    pEnvironment*: LPWSTR
    pDriverPath*: LPWSTR
    pDataFile*: LPWSTR
    pConfigFile*: LPWSTR
    pHelpFile*: LPWSTR
    pDependentFiles*: LPWSTR
    pMonitorName*: LPWSTR
    pDefaultDataType*: LPWSTR
    pszzPreviousNames*: LPWSTR
    ftDriverDate*: FILETIME
    dwlDriverVersion*: DWORDLONG
    pszMfgName*: LPWSTR
    pszOEMUrl*: LPWSTR
    pszHardwareID*: LPWSTR
    pszProvider*: LPWSTR
    pszPrintProcessor*: LPWSTR
    pszVendorSetup*: LPWSTR
    pszzColorProfiles*: LPWSTR
    pszInfPath*: LPWSTR
    dwPrinterDriverAttributes*: DWORD
    pszzCoreDriverDependencies*: LPWSTR
    ftMinInboxDriverVerDate*: FILETIME
    dwlMinInboxDriverVerVersion*: DWORDLONG
  PDRIVER_INFO_8W* = ptr DRIVER_INFO_8W
  LPDRIVER_INFO_8W* = ptr DRIVER_INFO_8W
  DRIVER_INFO_8A* {.pure.} = object
    cVersion*: DWORD
    pName*: LPSTR
    pEnvironment*: LPSTR
    pDriverPath*: LPSTR
    pDataFile*: LPSTR
    pConfigFile*: LPSTR
    pHelpFile*: LPSTR
    pDependentFiles*: LPSTR
    pMonitorName*: LPSTR
    pDefaultDataType*: LPSTR
    pszzPreviousNames*: LPSTR
    ftDriverDate*: FILETIME
    dwlDriverVersion*: DWORDLONG
    pszMfgName*: LPSTR
    pszOEMUrl*: LPSTR
    pszHardwareID*: LPSTR
    pszProvider*: LPSTR
    pszPrintProcessor*: LPSTR
    pszVendorSetup*: LPSTR
    pszzColorProfiles*: LPSTR
    pszInfPath*: LPSTR
    dwPrinterDriverAttributes*: DWORD
    pszzCoreDriverDependencies*: LPSTR
    ftMinInboxDriverVerDate*: FILETIME
    dwlMinInboxDriverVerVersion*: DWORDLONG
  PDRIVER_INFO_8A* = ptr DRIVER_INFO_8A
  LPDRIVER_INFO_8A* = ptr DRIVER_INFO_8A
  FORM_INFO_2A* {.pure.} = object
    Flags*: DWORD
    pName*: LPSTR
    Size*: SIZEL
    ImageableArea*: RECTL
    pKeyword*: LPCSTR
    StringType*: DWORD
    pMuiDll*: LPCSTR
    dwResourceId*: DWORD
    pDisplayName*: LPCSTR
    wLangId*: LANGID
  PFORM_INFO_2A* = ptr FORM_INFO_2A
  FORM_INFO_2W* {.pure.} = object
    Flags*: DWORD
    pName*: LPWSTR
    Size*: SIZEL
    ImageableArea*: RECTL
    pKeyword*: LPCSTR
    StringType*: DWORD
    pMuiDll*: LPCWSTR
    dwResourceId*: DWORD
    pDisplayName*: LPCWSTR
    wLangId*: LANGID
  PFORM_INFO_2W* = ptr FORM_INFO_2W
  PRINTPROCESSOR_CAPS_2* {.pure.} = object
    dwLevel*: DWORD
    dwNupOptions*: DWORD
    dwPageOrderFlags*: DWORD
    dwNumberOfCopies*: DWORD
    dwNupDirectionCaps*: DWORD
    dwNupBorderCaps*: DWORD
    dwBookletHandlingCaps*: DWORD
    dwDuplexHandlingCaps*: DWORD
    dwScalingCaps*: DWORD
  PPRINTPROCESSOR_CAPS_2* = ptr PRINTPROCESSOR_CAPS_2
  CORE_PRINTER_DRIVERA* {.pure.} = object
    CoreDriverGUID*: GUID
    ftDriverDate*: FILETIME
    dwlDriverVersion*: DWORDLONG
    szPackageID*: array[MAX_PATH, CHAR]
  PCORE_PRINTER_DRIVERA* = ptr CORE_PRINTER_DRIVERA
  CORE_PRINTER_DRIVERW* {.pure.} = object
    CoreDriverGUID*: GUID
    ftDriverDate*: FILETIME
    dwlDriverVersion*: DWORDLONG
    szPackageID*: array[MAX_PATH, WCHAR]
  PCORE_PRINTER_DRIVERW* = ptr CORE_PRINTER_DRIVERW
  PRINTER_OPTIONS* {.pure.} = object
    cbSize*: UINT
    dwFlags*: DWORD
  PPRINTER_OPTIONS* = ptr PRINTER_OPTIONS
const
  DSPRINT_PUBLISH* = 0x00000001
  DSPRINT_UPDATE* = 0x00000002
  DSPRINT_UNPUBLISH* = 0x00000004
  DSPRINT_REPUBLISH* = 0x00000008
  DSPRINT_PENDING* = 0x80000000'i32
  PRINTER_CONTROL_PAUSE* = 1
  PRINTER_CONTROL_RESUME* = 2
  PRINTER_CONTROL_PURGE* = 3
  PRINTER_CONTROL_SET_STATUS* = 4
  PRINTER_STATUS_PAUSED* = 0x00000001
  PRINTER_STATUS_ERROR* = 0x00000002
  PRINTER_STATUS_PENDING_DELETION* = 0x00000004
  PRINTER_STATUS_PAPER_JAM* = 0x00000008
  PRINTER_STATUS_PAPER_OUT* = 0x00000010
  PRINTER_STATUS_MANUAL_FEED* = 0x00000020
  PRINTER_STATUS_PAPER_PROBLEM* = 0x00000040
  PRINTER_STATUS_OFFLINE* = 0x00000080
  PRINTER_STATUS_IO_ACTIVE* = 0x00000100
  PRINTER_STATUS_BUSY* = 0x00000200
  PRINTER_STATUS_PRINTING* = 0x00000400
  PRINTER_STATUS_OUTPUT_BIN_FULL* = 0x00000800
  PRINTER_STATUS_NOT_AVAILABLE* = 0x00001000
  PRINTER_STATUS_WAITING* = 0x00002000
  PRINTER_STATUS_PROCESSING* = 0x00004000
  PRINTER_STATUS_INITIALIZING* = 0x00008000
  PRINTER_STATUS_WARMING_UP* = 0x00010000
  PRINTER_STATUS_TONER_LOW* = 0x00020000
  PRINTER_STATUS_NO_TONER* = 0x00040000
  PRINTER_STATUS_PAGE_PUNT* = 0x00080000
  PRINTER_STATUS_USER_INTERVENTION* = 0x00100000
  PRINTER_STATUS_OUT_OF_MEMORY* = 0x00200000
  PRINTER_STATUS_DOOR_OPEN* = 0x00400000
  PRINTER_STATUS_SERVER_UNKNOWN* = 0x00800000
  PRINTER_STATUS_POWER_SAVE* = 0x01000000
  PRINTER_ATTRIBUTE_QUEUED* = 0x00000001
  PRINTER_ATTRIBUTE_DIRECT* = 0x00000002
  PRINTER_ATTRIBUTE_DEFAULT* = 0x00000004
  PRINTER_ATTRIBUTE_SHARED* = 0x00000008
  PRINTER_ATTRIBUTE_NETWORK* = 0x00000010
  PRINTER_ATTRIBUTE_HIDDEN* = 0x00000020
  PRINTER_ATTRIBUTE_LOCAL* = 0x00000040
  PRINTER_ATTRIBUTE_ENABLE_DEVQ* = 0x00000080
  PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS* = 0x00000100
  PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST* = 0x00000200
  PRINTER_ATTRIBUTE_WORK_OFFLINE* = 0x00000400
  PRINTER_ATTRIBUTE_ENABLE_BIDI* = 0x00000800
  PRINTER_ATTRIBUTE_RAW_ONLY* = 0x00001000
  PRINTER_ATTRIBUTE_PUBLISHED* = 0x00002000
  PRINTER_ATTRIBUTE_FAX* = 0x00004000
  PRINTER_ATTRIBUTE_TS* = 0x00008000
  NO_PRIORITY* = 0
  MAX_PRIORITY* = 99
  MIN_PRIORITY* = 1
  DEF_PRIORITY* = 1
  JOB_CONTROL_PAUSE* = 1
  JOB_CONTROL_RESUME* = 2
  JOB_CONTROL_CANCEL* = 3
  JOB_CONTROL_RESTART* = 4
  JOB_CONTROL_DELETE* = 5
  JOB_CONTROL_SENT_TO_PRINTER* = 6
  JOB_CONTROL_LAST_PAGE_EJECTED* = 7
  JOB_STATUS_PAUSED* = 0x00000001
  JOB_STATUS_ERROR* = 0x00000002
  JOB_STATUS_DELETING* = 0x00000004
  JOB_STATUS_SPOOLING* = 0x00000008
  JOB_STATUS_PRINTING* = 0x00000010
  JOB_STATUS_OFFLINE* = 0x00000020
  JOB_STATUS_PAPEROUT* = 0x00000040
  JOB_STATUS_PRINTED* = 0x00000080
  JOB_STATUS_DELETED* = 0x00000100
  JOB_STATUS_BLOCKED_DEVQ* = 0x00000200
  JOB_STATUS_USER_INTERVENTION* = 0x00000400
  JOB_STATUS_RESTART* = 0x00000800
  JOB_STATUS_COMPLETE* = 0x00001000
  JOB_POSITION_UNSPECIFIED* = 0
  DRIVER_KERNELMODE* = 0x00000001
  DRIVER_USERMODE* = 0x00000002
  DPD_DELETE_UNUSED_FILES* = 0x00000001
  DPD_DELETE_SPECIFIC_VERSION* = 0x00000002
  DPD_DELETE_ALL_FILES* = 0x00000004
  APD_STRICT_UPGRADE* = 0x00000001
  APD_STRICT_DOWNGRADE* = 0x00000002
  APD_COPY_ALL_FILES* = 0x00000004
  APD_COPY_NEW_FILES* = 0x00000008
  APD_COPY_FROM_DIRECTORY* = 0x00000010
  DI_CHANNEL* = 1
  DI_READ_SPOOL_JOB* = 3
  DI_MEMORYMAP_WRITE* = 0x00000001
  FORM_USER* = 0x00000000
  FORM_BUILTIN* = 0x00000001
  FORM_PRINTER* = 0x00000002
  NORMAL_PRINT* = 0x00000000
  REVERSE_PRINT* = 0x00000001
  PORT_TYPE_WRITE* = 0x0001
  PORT_TYPE_READ* = 0x0002
  PORT_TYPE_REDIRECTED* = 0x0004
  PORT_TYPE_NET_ATTACHED* = 0x0008
  PORT_STATUS_TYPE_ERROR* = 1
  PORT_STATUS_TYPE_WARNING* = 2
  PORT_STATUS_TYPE_INFO* = 3
  PORT_STATUS_OFFLINE* = 1
  PORT_STATUS_PAPER_JAM* = 2
  PORT_STATUS_PAPER_OUT* = 3
  PORT_STATUS_OUTPUT_BIN_FULL* = 4
  PORT_STATUS_PAPER_PROBLEM* = 5
  PORT_STATUS_NO_TONER* = 6
  PORT_STATUS_DOOR_OPEN* = 7
  PORT_STATUS_USER_INTERVENTION* = 8
  PORT_STATUS_OUT_OF_MEMORY* = 9
  PORT_STATUS_TONER_LOW* = 10
  PORT_STATUS_WARMING_UP* = 11
  PORT_STATUS_POWER_SAVE* = 12
  PRINTER_ENUM_DEFAULT* = 0x00000001
  PRINTER_ENUM_LOCAL* = 0x00000002
  PRINTER_ENUM_CONNECTIONS* = 0x00000004
  PRINTER_ENUM_FAVORITE* = 0x00000004
  PRINTER_ENUM_NAME* = 0x00000008
  PRINTER_ENUM_REMOTE* = 0x00000010
  PRINTER_ENUM_SHARED* = 0x00000020
  PRINTER_ENUM_NETWORK* = 0x00000040
  PRINTER_ENUM_EXPAND* = 0x00004000
  PRINTER_ENUM_CONTAINER* = 0x00008000
  PRINTER_ENUM_ICONMASK* = 0x00ff0000
  PRINTER_ENUM_ICON1* = 0x00010000
  PRINTER_ENUM_ICON2* = 0x00020000
  PRINTER_ENUM_ICON3* = 0x00040000
  PRINTER_ENUM_ICON4* = 0x00080000
  PRINTER_ENUM_ICON5* = 0x00100000
  PRINTER_ENUM_ICON6* = 0x00200000
  PRINTER_ENUM_ICON7* = 0x00400000
  PRINTER_ENUM_ICON8* = 0x00800000
  PRINTER_ENUM_HIDE* = 0x01000000
  SPOOL_FILE_PERSISTENT* = 0x00000001
  SPOOL_FILE_TEMPORARY* = 0x00000002
  PRINTER_NOTIFY_TYPE* = 0x00
  JOB_NOTIFY_TYPE* = 0x01
  PRINTER_NOTIFY_FIELD_SERVER_NAME* = 0x00
  PRINTER_NOTIFY_FIELD_PRINTER_NAME* = 0x01
  PRINTER_NOTIFY_FIELD_SHARE_NAME* = 0x02
  PRINTER_NOTIFY_FIELD_PORT_NAME* = 0x03
  PRINTER_NOTIFY_FIELD_DRIVER_NAME* = 0x04
  PRINTER_NOTIFY_FIELD_COMMENT* = 0x05
  PRINTER_NOTIFY_FIELD_LOCATION* = 0x06
  PRINTER_NOTIFY_FIELD_DEVMODE* = 0x07
  PRINTER_NOTIFY_FIELD_SEPFILE* = 0x08
  PRINTER_NOTIFY_FIELD_PRINT_PROCESSOR* = 0x09
  PRINTER_NOTIFY_FIELD_PARAMETERS* = 0x0A
  PRINTER_NOTIFY_FIELD_DATATYPE* = 0x0B
  PRINTER_NOTIFY_FIELD_SECURITY_DESCRIPTOR* = 0x0C
  PRINTER_NOTIFY_FIELD_ATTRIBUTES* = 0x0D
  PRINTER_NOTIFY_FIELD_PRIORITY* = 0x0E
  PRINTER_NOTIFY_FIELD_DEFAULT_PRIORITY* = 0x0F
  PRINTER_NOTIFY_FIELD_START_TIME* = 0x10
  PRINTER_NOTIFY_FIELD_UNTIL_TIME* = 0x11
  PRINTER_NOTIFY_FIELD_STATUS* = 0x12
  PRINTER_NOTIFY_FIELD_STATUS_STRING* = 0x13
  PRINTER_NOTIFY_FIELD_CJOBS* = 0x14
  PRINTER_NOTIFY_FIELD_AVERAGE_PPM* = 0x15
  PRINTER_NOTIFY_FIELD_TOTAL_PAGES* = 0x16
  PRINTER_NOTIFY_FIELD_PAGES_PRINTED* = 0x17
  PRINTER_NOTIFY_FIELD_TOTAL_BYTES* = 0x18
  PRINTER_NOTIFY_FIELD_BYTES_PRINTED* = 0x19
  PRINTER_NOTIFY_FIELD_OBJECT_GUID* = 0x1A
  JOB_NOTIFY_FIELD_PRINTER_NAME* = 0x00
  JOB_NOTIFY_FIELD_MACHINE_NAME* = 0x01
  JOB_NOTIFY_FIELD_PORT_NAME* = 0x02
  JOB_NOTIFY_FIELD_USER_NAME* = 0x03
  JOB_NOTIFY_FIELD_NOTIFY_NAME* = 0x04
  JOB_NOTIFY_FIELD_DATATYPE* = 0x05
  JOB_NOTIFY_FIELD_PRINT_PROCESSOR* = 0x06
  JOB_NOTIFY_FIELD_PARAMETERS* = 0x07
  JOB_NOTIFY_FIELD_DRIVER_NAME* = 0x08
  JOB_NOTIFY_FIELD_DEVMODE* = 0x09
  JOB_NOTIFY_FIELD_STATUS* = 0x0A
  JOB_NOTIFY_FIELD_STATUS_STRING* = 0x0B
  JOB_NOTIFY_FIELD_SECURITY_DESCRIPTOR* = 0x0C
  JOB_NOTIFY_FIELD_DOCUMENT* = 0x0D
  JOB_NOTIFY_FIELD_PRIORITY* = 0x0E
  JOB_NOTIFY_FIELD_POSITION* = 0x0F
  JOB_NOTIFY_FIELD_SUBMITTED* = 0x10
  JOB_NOTIFY_FIELD_START_TIME* = 0x11
  JOB_NOTIFY_FIELD_UNTIL_TIME* = 0x12
  JOB_NOTIFY_FIELD_TIME* = 0x13
  JOB_NOTIFY_FIELD_TOTAL_PAGES* = 0x14
  JOB_NOTIFY_FIELD_PAGES_PRINTED* = 0x15
  JOB_NOTIFY_FIELD_TOTAL_BYTES* = 0x16
  JOB_NOTIFY_FIELD_BYTES_PRINTED* = 0x17
  PRINTER_NOTIFY_OPTIONS_REFRESH* = 0x01
  PRINTER_NOTIFY_INFO_DISCARDED* = 0x01
  BIDI_ACTION_ENUM_SCHEMA* = "EnumSchema"
  BIDI_ACTION_GET* = "Get"
  BIDI_ACTION_SET* = "Set"
  BIDI_ACTION_GET_ALL* = "GetAll"
  BIDI_NULL* = 0
  BIDI_INT* = 1
  BIDI_FLOAT* = 2
  BIDI_BOOL* = 3
  BIDI_STRING* = 4
  BIDI_TEXT* = 5
  BIDI_ENUM* = 6
  BIDI_BLOB* = 7
  BIDI_ACCESS_ADMINISTRATOR* = 0x1
  BIDI_ACCESS_USER* = 0x2
  ERROR_BIDI_STATUS_OK* = 0
  ERROR_BIDI_NOT_SUPPORTED* = ERROR_NOT_SUPPORTED
  ERROR_BIDI_ERROR_BASE* = 13000
  ERROR_BIDI_STATUS_WARNING* = ERROR_BIDI_ERROR_BASE+1
  ERROR_BIDI_SCHEMA_READ_ONLY* = ERROR_BIDI_ERROR_BASE+2
  ERROR_BIDI_SERVER_OFFLINE* = ERROR_BIDI_ERROR_BASE+3
  ERROR_BIDI_DEVICE_OFFLINE* = ERROR_BIDI_ERROR_BASE+4
  ERROR_BIDI_SCHEMA_NOT_SUPPORTED* = ERROR_BIDI_ERROR_BASE+5
  PRINTER_CHANGE_ADD_PRINTER* = 0x00000001
  PRINTER_CHANGE_SET_PRINTER* = 0x00000002
  PRINTER_CHANGE_DELETE_PRINTER* = 0x00000004
  PRINTER_CHANGE_FAILED_CONNECTION_PRINTER* = 0x00000008
  PRINTER_CHANGE_PRINTER* = 0x000000FF
  PRINTER_CHANGE_ADD_JOB* = 0x00000100
  PRINTER_CHANGE_SET_JOB* = 0x00000200
  PRINTER_CHANGE_DELETE_JOB* = 0x00000400
  PRINTER_CHANGE_WRITE_JOB* = 0x00000800
  PRINTER_CHANGE_JOB* = 0x0000FF00
  PRINTER_CHANGE_ADD_FORM* = 0x00010000
  PRINTER_CHANGE_SET_FORM* = 0x00020000
  PRINTER_CHANGE_DELETE_FORM* = 0x00040000
  PRINTER_CHANGE_FORM* = 0x00070000
  PRINTER_CHANGE_ADD_PORT* = 0x00100000
  PRINTER_CHANGE_CONFIGURE_PORT* = 0x00200000
  PRINTER_CHANGE_DELETE_PORT* = 0x00400000
  PRINTER_CHANGE_PORT* = 0x00700000
  PRINTER_CHANGE_ADD_PRINT_PROCESSOR* = 0x01000000
  PRINTER_CHANGE_DELETE_PRINT_PROCESSOR* = 0x04000000
  PRINTER_CHANGE_PRINT_PROCESSOR* = 0x07000000
  PRINTER_CHANGE_ADD_PRINTER_DRIVER* = 0x10000000
  PRINTER_CHANGE_SET_PRINTER_DRIVER* = 0x20000000
  PRINTER_CHANGE_DELETE_PRINTER_DRIVER* = 0x40000000
  PRINTER_CHANGE_PRINTER_DRIVER* = 0x70000000
  PRINTER_CHANGE_TIMEOUT* = 0x80000000'i32
  PRINTER_CHANGE_ALL* = 0x7777FFFF
  PRINTER_ERROR_INFORMATION* = 0x80000000'i32
  PRINTER_ERROR_WARNING* = 0x40000000
  PRINTER_ERROR_SEVERE* = 0x20000000
  PRINTER_ERROR_OUTOFPAPER* = 0x00000001
  PRINTER_ERROR_JAM* = 0x00000002
  PRINTER_ERROR_OUTOFTONER* = 0x00000004
  SPLREG_DEFAULT_SPOOL_DIRECTORY* = "DefaultSpoolDirectory"
  SPLREG_PORT_THREAD_PRIORITY_DEFAULT* = "PortThreadPriorityDefault"
  SPLREG_PORT_THREAD_PRIORITY* = "PortThreadPriority"
  SPLREG_SCHEDULER_THREAD_PRIORITY_DEFAULT* = "SchedulerThreadPriorityDefault"
  SPLREG_SCHEDULER_THREAD_PRIORITY* = "SchedulerThreadPriority"
  SPLREG_BEEP_ENABLED* = "BeepEnabled"
  SPLREG_NET_POPUP* = "NetPopup"
  SPLREG_RETRY_POPUP* = "RetryPopup"
  SPLREG_NET_POPUP_TO_COMPUTER* = "NetPopupToComputer"
  SPLREG_EVENT_LOG* = "EventLog"
  SPLREG_MAJOR_VERSION* = "MajorVersion"
  SPLREG_MINOR_VERSION* = "MinorVersion"
  SPLREG_ARCHITECTURE* = "Architecture"
  SPLREG_OS_VERSION* = "OSVersion"
  SPLREG_OS_VERSIONEX* = "OSVersionEx"
  SPLREG_DS_PRESENT* = "DsPresent"
  SPLREG_DS_PRESENT_FOR_USER* = "DsPresentForUser"
  SPLREG_REMOTE_FAX* = "RemoteFax"
  SPLREG_RESTART_JOB_ON_POOL_ERROR* = "RestartJobOnPoolError"
  SPLREG_RESTART_JOB_ON_POOL_ENABLED* = "RestartJobOnPoolEnabled"
  SPLREG_DNS_MACHINE_NAME* = "DNSMachineName"
  SPLREG_ALLOW_USER_MANAGEFORMS* = "AllowUserManageForms"
  SPLREG_WEBSHAREMGMT* = "WebShareMgmt"
  SERVER_ACCESS_ADMINISTER* = 0x00000001
  SERVER_ACCESS_ENUMERATE* = 0x00000002
  PRINTER_ACCESS_ADMINISTER* = 0x00000004
  PRINTER_ACCESS_USE* = 0x00000008
  JOB_ACCESS_ADMINISTER* = 0x00000010
  JOB_ACCESS_READ* = 0x00000020
  SERVER_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or SERVER_ACCESS_ADMINISTER or SERVER_ACCESS_ENUMERATE
  SERVER_READ* = STANDARD_RIGHTS_READ or SERVER_ACCESS_ENUMERATE
  SERVER_WRITE* = STANDARD_RIGHTS_WRITE or SERVER_ACCESS_ADMINISTER or SERVER_ACCESS_ENUMERATE
  SERVER_EXECUTE* = STANDARD_RIGHTS_EXECUTE or SERVER_ACCESS_ENUMERATE
  PRINTER_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or PRINTER_ACCESS_ADMINISTER or PRINTER_ACCESS_USE
  PRINTER_READ* = STANDARD_RIGHTS_READ or PRINTER_ACCESS_USE
  PRINTER_WRITE* = STANDARD_RIGHTS_WRITE or PRINTER_ACCESS_USE
  PRINTER_EXECUTE* = STANDARD_RIGHTS_EXECUTE or PRINTER_ACCESS_USE
  JOB_ALL_ACCESS* = STANDARD_RIGHTS_REQUIRED or JOB_ACCESS_ADMINISTER or JOB_ACCESS_READ
  JOB_READ* = STANDARD_RIGHTS_READ or JOB_ACCESS_READ
  JOB_WRITE* = STANDARD_RIGHTS_WRITE or JOB_ACCESS_ADMINISTER
  JOB_EXECUTE* = STANDARD_RIGHTS_EXECUTE or JOB_ACCESS_ADMINISTER
  SPLDS_SPOOLER_KEY* = "DsSpooler"
  SPLDS_DRIVER_KEY* = "DsDriver"
  SPLDS_USER_KEY* = "DsUser"
  SPLDS_ASSET_NUMBER* = "assetNumber"
  SPLDS_BYTES_PER_MINUTE* = "bytesPerMinute"
  SPLDS_DESCRIPTION* = "description"
  SPLDS_DRIVER_NAME* = "driverName"
  SPLDS_DRIVER_VERSION* = "driverVersion"
  SPLDS_LOCATION* = "location"
  SPLDS_PORT_NAME* = "portName"
  SPLDS_PRINT_ATTRIBUTES* = "printAttributes"
  SPLDS_PRINT_BIN_NAMES* = "printBinNames"
  SPLDS_PRINT_COLLATE* = "printCollate"
  SPLDS_PRINT_COLOR* = "printColor"
  SPLDS_PRINT_DUPLEX_SUPPORTED* = "printDuplexSupported"
  SPLDS_PRINT_END_TIME* = "printEndTime"
  SPLDS_PRINTER_CLASS* = "printQueue"
  SPLDS_PRINTER_NAME* = "printerName"
  SPLDS_PRINT_KEEP_PRINTED_JOBS* = "printKeepPrintedJobs"
  SPLDS_PRINT_LANGUAGE* = "printLanguage"
  SPLDS_PRINT_MAC_ADDRESS* = "printMACAddress"
  SPLDS_PRINT_MAX_X_EXTENT* = "printMaxXExtent"
  SPLDS_PRINT_MAX_Y_EXTENT* = "printMaxYExtent"
  SPLDS_PRINT_MAX_RESOLUTION_SUPPORTED* = "printMaxResolutionSupported"
  SPLDS_PRINT_MEDIA_READY* = "printMediaReady"
  SPLDS_PRINT_MEDIA_SUPPORTED* = "printMediaSupported"
  SPLDS_PRINT_MEMORY* = "printMemory"
  SPLDS_PRINT_MIN_X_EXTENT* = "printMinXExtent"
  SPLDS_PRINT_MIN_Y_EXTENT* = "printMinYExtent"
  SPLDS_PRINT_NETWORK_ADDRESS* = "printNetworkAddress"
  SPLDS_PRINT_NOTIFY* = "printNotify"
  SPLDS_PRINT_NUMBER_UP* = "printNumberUp"
  SPLDS_PRINT_ORIENTATIONS_SUPPORTED* = "printOrientationsSupported"
  SPLDS_PRINT_OWNER* = "printOwner"
  SPLDS_PRINT_PAGES_PER_MINUTE* = "printPagesPerMinute"
  SPLDS_PRINT_RATE* = "printRate"
  SPLDS_PRINT_RATE_UNIT* = "printRateUnit"
  SPLDS_PRINT_SEPARATOR_FILE* = "printSeparatorFile"
  SPLDS_PRINT_SHARE_NAME* = "printShareName"
  SPLDS_PRINT_SPOOLING* = "printSpooling"
  SPLDS_PRINT_STAPLING_SUPPORTED* = "printStaplingSupported"
  SPLDS_PRINT_START_TIME* = "printStartTime"
  SPLDS_PRINT_STATUS* = "printStatus"
  SPLDS_PRIORITY* = "priority"
  SPLDS_SERVER_NAME* = "serverName"
  SPLDS_SHORT_SERVER_NAME* = "shortServerName"
  SPLDS_UNC_NAME* = "uNCName"
  SPLDS_URL* = "url"
  SPLDS_FLAGS* = "flags"
  SPLDS_VERSION_NUMBER* = "versionNumber"
  SPLDS_PRINTER_NAME_ALIASES* = "printerNameAliases"
  SPLDS_PRINTER_LOCATIONS* = "printerLocations"
  SPLDS_PRINTER_MODEL* = "printerModel"
  PRINTER_CONNECTION_MISMATCH* = 0x00000020
  PRINTER_CONNECTION_NO_UI* = 0x00000040
  PRINTER_OPTION_NO_CACHE* = 0
  PRINTER_OPTION_CACHE* = 1
  PRINTER_OPTION_CLIENT_CHANGE* = 2
  kJobProduction* = 0
  kJobConsumption* = 1
  kAddingDocumentSequence* = 0
  kDocumentSequenceAdded* = 1
  kAddingFixedDocument* = 2
  kFixedDocumentAdded* = 3
  kAddingFixedPage* = 4
  kFixedPageAdded* = 5
  kResourceAdded* = 6
  kFontAdded* = 7
  kImageAdded* = 8
  kXpsDocumentCommitted* = 9
proc EnumPrintersA*(Flags: DWORD, Name: LPSTR, Level: DWORD, pPrinterEnum: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrintersW*(Flags: DWORD, Name: LPWSTR, Level: DWORD, pPrinterEnum: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc OpenPrinterA*(pPrinterName: LPSTR, phPrinter: LPHANDLE, pDefault: LPPRINTER_DEFAULTSA): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc OpenPrinterW*(pPrinterName: LPWSTR, phPrinter: LPHANDLE, pDefault: LPPRINTER_DEFAULTSW): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ResetPrinterA*(hPrinter: HANDLE, pDefault: LPPRINTER_DEFAULTSA): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ResetPrinterW*(hPrinter: HANDLE, pDefault: LPPRINTER_DEFAULTSW): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetJobA*(hPrinter: HANDLE, JobId: DWORD, Level: DWORD, pJob: LPBYTE, Command: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetJobW*(hPrinter: HANDLE, JobId: DWORD, Level: DWORD, pJob: LPBYTE, Command: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetJobA*(hPrinter: HANDLE, JobId: DWORD, Level: DWORD, pJob: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetJobW*(hPrinter: HANDLE, JobId: DWORD, Level: DWORD, pJob: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumJobsA*(hPrinter: HANDLE, FirstJob: DWORD, NoJobs: DWORD, Level: DWORD, pJob: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumJobsW*(hPrinter: HANDLE, FirstJob: DWORD, NoJobs: DWORD, Level: DWORD, pJob: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterA*(pName: LPSTR, Level: DWORD, pPrinter: LPBYTE): HANDLE {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterW*(pName: LPWSTR, Level: DWORD, pPrinter: LPBYTE): HANDLE {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinter*(hPrinter: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetPrinterA*(hPrinter: HANDLE, Level: DWORD, pPrinter: LPBYTE, Command: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetPrinterW*(hPrinter: HANDLE, Level: DWORD, pPrinter: LPBYTE, Command: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterA*(hPrinter: HANDLE, Level: DWORD, pPrinter: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterW*(hPrinter: HANDLE, Level: DWORD, pPrinter: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterDriverA*(pName: LPSTR, Level: DWORD, pDriverInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterDriverW*(pName: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterDriverExA*(pName: LPSTR, Level: DWORD, pDriverInfo: LPBYTE, dwFileCopyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterDriverExW*(pName: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE, dwFileCopyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrinterDriversA*(pName: LPSTR, pEnvironment: LPSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrinterDriversW*(pName: LPWSTR, pEnvironment: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDriverA*(hPrinter: HANDLE, pEnvironment: LPSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDriverW*(hPrinter: HANDLE, pEnvironment: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDriverDirectoryA*(pName: LPSTR, pEnvironment: LPSTR, Level: DWORD, pDriverDirectory: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDriverDirectoryW*(pName: LPWSTR, pEnvironment: LPWSTR, Level: DWORD, pDriverDirectory: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDriverA*(pName: LPSTR, pEnvironment: LPSTR, pDriverName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDriverW*(pName: LPWSTR, pEnvironment: LPWSTR, pDriverName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDriverExA*(pName: LPSTR, pEnvironment: LPSTR, pDriverName: LPSTR, dwDeleteFlag: DWORD, dwVersionFlag: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDriverExW*(pName: LPWSTR, pEnvironment: LPWSTR, pDriverName: LPWSTR, dwDeleteFlag: DWORD, dwVersionFlag: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrintProcessorA*(pName: LPSTR, pEnvironment: LPSTR, pPathName: LPSTR, pPrintProcessorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrintProcessorW*(pName: LPWSTR, pEnvironment: LPWSTR, pPathName: LPWSTR, pPrintProcessorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrintProcessorsA*(pName: LPSTR, pEnvironment: LPSTR, Level: DWORD, pPrintProcessorInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrintProcessorsW*(pName: LPWSTR, pEnvironment: LPWSTR, Level: DWORD, pPrintProcessorInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrintProcessorDirectoryA*(pName: LPSTR, pEnvironment: LPSTR, Level: DWORD, pPrintProcessorInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrintProcessorDirectoryW*(pName: LPWSTR, pEnvironment: LPWSTR, Level: DWORD, pPrintProcessorInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrintProcessorDatatypesA*(pName: LPSTR, pPrintProcessorName: LPSTR, Level: DWORD, pDatatypes: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrintProcessorDatatypesW*(pName: LPWSTR, pPrintProcessorName: LPWSTR, Level: DWORD, pDatatypes: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrintProcessorA*(pName: LPSTR, pEnvironment: LPSTR, pPrintProcessorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrintProcessorW*(pName: LPWSTR, pEnvironment: LPWSTR, pPrintProcessorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc StartDocPrinterA*(hPrinter: HANDLE, Level: DWORD, pDocInfo: LPBYTE): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc StartDocPrinterW*(hPrinter: HANDLE, Level: DWORD, pDocInfo: LPBYTE): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc StartPagePrinter*(hPrinter: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc WritePrinter*(hPrinter: HANDLE, pBuf: LPVOID, cbBuf: DWORD, pcWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc FlushPrinter*(hPrinter: HANDLE, pBuf: LPVOID, cbBuf: DWORD, pcWritten: LPDWORD, cSleep: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EndPagePrinter*(hPrinter: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AbortPrinter*(hPrinter: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ReadPrinter*(hPrinter: HANDLE, pBuf: LPVOID, cbBuf: DWORD, pNoBytesRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EndDocPrinter*(hPrinter: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddJobA*(hPrinter: HANDLE, Level: DWORD, pData: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddJobW*(hPrinter: HANDLE, Level: DWORD, pData: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ScheduleJob*(hPrinter: HANDLE, JobId: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc PrinterProperties*(hWnd: HWND, hPrinter: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DocumentPropertiesA*(hWnd: HWND, hPrinter: HANDLE, pDeviceName: LPSTR, pDevModeOutput: PDEVMODEA, pDevModeInput: PDEVMODEA, fMode: DWORD): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DocumentPropertiesW*(hWnd: HWND, hPrinter: HANDLE, pDeviceName: LPWSTR, pDevModeOutput: PDEVMODEW, pDevModeInput: PDEVMODEW, fMode: DWORD): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AdvancedDocumentPropertiesA*(hWnd: HWND, hPrinter: HANDLE, pDeviceName: LPSTR, pDevModeOutput: PDEVMODEA, pDevModeInput: PDEVMODEA): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AdvancedDocumentPropertiesW*(hWnd: HWND, hPrinter: HANDLE, pDeviceName: LPWSTR, pDevModeOutput: PDEVMODEW, pDevModeInput: PDEVMODEW): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ExtDeviceMode*(hWnd: HWND, hInst: HANDLE, pDevModeOutput: LPDEVMODEA, pDeviceName: LPSTR, pPort: LPSTR, pDevModeInput: LPDEVMODEA, pProfile: LPSTR, fMode: DWORD): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDataA*(hPrinter: HANDLE, pValueName: LPSTR, pType: LPDWORD, pData: LPBYTE, nSize: DWORD, pcbNeeded: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDataW*(hPrinter: HANDLE, pValueName: LPWSTR, pType: LPDWORD, pData: LPBYTE, nSize: DWORD, pcbNeeded: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDataExA*(hPrinter: HANDLE, pKeyName: LPCSTR, pValueName: LPCSTR, pType: LPDWORD, pData: LPBYTE, nSize: DWORD, pcbNeeded: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDataExW*(hPrinter: HANDLE, pKeyName: LPCWSTR, pValueName: LPCWSTR, pType: LPDWORD, pData: LPBYTE, nSize: DWORD, pcbNeeded: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrinterDataA*(hPrinter: HANDLE, dwIndex: DWORD, pValueName: LPSTR, cbValueName: DWORD, pcbValueName: LPDWORD, pType: LPDWORD, pData: LPBYTE, cbData: DWORD, pcbData: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrinterDataW*(hPrinter: HANDLE, dwIndex: DWORD, pValueName: LPWSTR, cbValueName: DWORD, pcbValueName: LPDWORD, pType: LPDWORD, pData: LPBYTE, cbData: DWORD, pcbData: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrinterDataExA*(hPrinter: HANDLE, pKeyName: LPCSTR, pEnumValues: LPBYTE, cbEnumValues: DWORD, pcbEnumValues: LPDWORD, pnEnumValues: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrinterDataExW*(hPrinter: HANDLE, pKeyName: LPCWSTR, pEnumValues: LPBYTE, cbEnumValues: DWORD, pcbEnumValues: LPDWORD, pnEnumValues: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrinterKeyA*(hPrinter: HANDLE, pKeyName: LPCSTR, pSubkey: LPSTR, cbSubkey: DWORD, pcbSubkey: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPrinterKeyW*(hPrinter: HANDLE, pKeyName: LPCWSTR, pSubkey: LPWSTR, cbSubkey: DWORD, pcbSubkey: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetPrinterDataA*(hPrinter: HANDLE, pValueName: LPSTR, Type: DWORD, pData: LPBYTE, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetPrinterDataW*(hPrinter: HANDLE, pValueName: LPWSTR, Type: DWORD, pData: LPBYTE, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetPrinterDataExA*(hPrinter: HANDLE, pKeyName: LPCSTR, pValueName: LPCSTR, Type: DWORD, pData: LPBYTE, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetPrinterDataExW*(hPrinter: HANDLE, pKeyName: LPCWSTR, pValueName: LPCWSTR, Type: DWORD, pData: LPBYTE, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDataA*(hPrinter: HANDLE, pValueName: LPSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDataW*(hPrinter: HANDLE, pValueName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDataExA*(hPrinter: HANDLE, pKeyName: LPCSTR, pValueName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDataExW*(hPrinter: HANDLE, pKeyName: LPCWSTR, pValueName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterKeyA*(hPrinter: HANDLE, pKeyName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterKeyW*(hPrinter: HANDLE, pKeyName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc WaitForPrinterChange*(hPrinter: HANDLE, Flags: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc FindFirstPrinterChangeNotification*(hPrinter: HANDLE, fdwFlags: DWORD, fdwOptions: DWORD, pPrinterNotifyOptions: LPVOID): HANDLE {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc FindNextPrinterChangeNotification*(hChange: HANDLE, pdwChange: PDWORD, pPrinterNotifyOptions: LPVOID, ppPrinterNotifyInfo: ptr LPVOID): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc FreePrinterNotifyInfo*(pPrinterNotifyInfo: PPRINTER_NOTIFY_INFO): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc FindClosePrinterChangeNotification*(hChange: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc PrinterMessageBoxA*(hPrinter: HANDLE, Error: DWORD, hWnd: HWND, pText: LPSTR, pCaption: LPSTR, dwType: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc PrinterMessageBoxW*(hPrinter: HANDLE, Error: DWORD, hWnd: HWND, pText: LPWSTR, pCaption: LPWSTR, dwType: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ClosePrinter*(hPrinter: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddFormA*(hPrinter: HANDLE, Level: DWORD, pForm: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddFormW*(hPrinter: HANDLE, Level: DWORD, pForm: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeleteFormA*(hPrinter: HANDLE, pFormName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeleteFormW*(hPrinter: HANDLE, pFormName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetFormA*(hPrinter: HANDLE, pFormName: LPSTR, Level: DWORD, pForm: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetFormW*(hPrinter: HANDLE, pFormName: LPWSTR, Level: DWORD, pForm: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetFormA*(hPrinter: HANDLE, pFormName: LPSTR, Level: DWORD, pForm: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetFormW*(hPrinter: HANDLE, pFormName: LPWSTR, Level: DWORD, pForm: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumFormsA*(hPrinter: HANDLE, Level: DWORD, pForm: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumFormsW*(hPrinter: HANDLE, Level: DWORD, pForm: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumMonitorsA*(pName: LPSTR, Level: DWORD, pMonitor: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumMonitorsW*(pName: LPWSTR, Level: DWORD, pMonitor: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddMonitorA*(pName: LPSTR, Level: DWORD, pMonitorInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddMonitorW*(pName: LPWSTR, Level: DWORD, pMonitorInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeleteMonitorA*(pName: LPSTR, pEnvironment: LPSTR, pMonitorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeleteMonitorW*(pName: LPWSTR, pEnvironment: LPWSTR, pMonitorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPortsA*(pName: LPSTR, Level: DWORD, pPorts: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc EnumPortsW*(pName: LPWSTR, Level: DWORD, pPorts: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPortA*(pName: LPSTR, hWnd: HWND, pMonitorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPortW*(pName: LPWSTR, hWnd: HWND, pMonitorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ConfigurePortA*(pName: LPSTR, hWnd: HWND, pPortName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ConfigurePortW*(pName: LPWSTR, hWnd: HWND, pPortName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePortA*(pName: LPSTR, hWnd: HWND, pPortName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePortW*(pName: LPWSTR, hWnd: HWND, pPortName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc XcvDataW*(hXcv: HANDLE, pszDataName: PCWSTR, pInputData: PBYTE, cbInputData: DWORD, pOutputData: PBYTE, cbOutputData: DWORD, pcbOutputNeeded: PDWORD, pdwStatus: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc XcvData*(hXcv: HANDLE, pszDataName: PCWSTR, pInputData: PBYTE, cbInputData: DWORD, pOutputData: PBYTE, cbOutputData: DWORD, pcbOutputNeeded: PDWORD, pdwStatus: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "XcvDataW".}
proc GetDefaultPrinterA*(pszBuffer: LPSTR, pcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetDefaultPrinterW*(pszBuffer: LPWSTR, pcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetDefaultPrinterA*(pszPrinter: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetDefaultPrinterW*(pszPrinter: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetPortA*(pName: LPSTR, pPortName: LPSTR, dwLevel: DWORD, pPortInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc SetPortW*(pName: LPWSTR, pPortName: LPWSTR, dwLevel: DWORD, pPortInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterConnectionA*(pName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterConnectionW*(pName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterConnectionA*(pName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterConnectionW*(pName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ConnectToPrinterDlg*(hwnd: HWND, Flags: DWORD): HANDLE {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrintProvidorA*(pName: LPSTR, level: DWORD, pProvidorInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrintProvidorW*(pName: LPWSTR, level: DWORD, pProvidorInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrintProvidorA*(pName: LPSTR, pEnvironment: LPSTR, pPrintProvidorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrintProvidorW*(pName: LPWSTR, pEnvironment: LPWSTR, pPrintProvidorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc IsValidDevmodeA*(pDevmode: PDEVMODEA, DevmodeSize: int): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc IsValidDevmodeW*(pDevmode: PDEVMODEW, DevmodeSize: int): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterConnection2W*(hWnd: HWND, pszName: LPCWSTR, dwLevel: DWORD, pConnectionInfo: PVOID): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc AddPrinterConnection2A*(hWnd: HWND, pszName: LPCSTR, dwLevel: DWORD, pConnectionInfo: PVOID): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDriverPackageA*(pszServer: LPCSTR, pszInfPath: LPCSTR, pszEnvironment: LPCSTR): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc DeletePrinterDriverPackageW*(pszServer: LPCWSTR, pszInfPath: LPCWSTR, pszEnvironment: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc ReportJobProcessingProgress*(printerHandle: HANDLE, jobId: ULONG, jobOperation: EPrintXPSJobOperation, jobProgress: EPrintXPSJobProgress): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetCorePrinterDriversA*(pszServer: LPCSTR, pszEnvironment: LPCSTR, pszzCoreDriverDependencies: LPCSTR, cCorePrinterDrivers: DWORD, pCorePrinterDrivers: PCORE_PRINTER_DRIVERA): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetCorePrinterDriversW*(pszServer: LPCWSTR, pszEnvironment: LPCWSTR, pszzCoreDriverDependencies: LPCWSTR, cCorePrinterDrivers: DWORD, pCorePrinterDrivers: PCORE_PRINTER_DRIVERW): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDriver2A*(hWnd: HWND, hPrinter: HANDLE, pEnvironment: LPSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDriver2W*(hWnd: HWND, hPrinter: HANDLE, pEnvironment: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDriverPackagePathA*(pszServer: LPCSTR, pszEnvironment: LPCSTR, pszLanguage: LPCSTR, pszPackageID: LPCSTR, pszDriverPackageCab: LPSTR, cchDriverPackageCab: DWORD, pcchRequiredSize: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc GetPrinterDriverPackagePathW*(pszServer: LPCWSTR, pszEnvironment: LPCWSTR, pszLanguage: LPCWSTR, pszPackageID: LPCWSTR, pszDriverPackageCab: LPWSTR, cchDriverPackageCab: DWORD, pcchRequiredSize: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc CommitSpoolData*(hPrinter: HANDLE, hSpoolFile: HANDLE, cbCommit: DWORD): HANDLE {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc CloseSpoolFileHandle*(hPrinter: HANDLE, hSpoolFile: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
when winimUnicode:
  type
    LPPRINTER_DEFAULTS* = LPPRINTER_DEFAULTSW
when winimAnsi:
  type
    LPPRINTER_DEFAULTS* = LPPRINTER_DEFAULTSA
proc OpenPrinter2A*(pPrinterName: LPCSTR, phPrinter: LPHANDLE, pDefault: LPPRINTER_DEFAULTS, pOptions: PPRINTER_OPTIONS): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc OpenPrinter2W*(pPrinterName: LPCWSTR, phPrinter: LPHANDLE, pDefault: LPPRINTER_DEFAULTS, pOptions: PPRINTER_OPTIONS): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc UploadPrinterDriverPackageA*(pszServer: LPCSTR, pszInfPath: LPCSTR, pszEnvironment: LPCSTR, dwFlags: DWORD, hwnd: HWND, pszDestInfPath: LPSTR, pcchDestInfPath: PULONG): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
proc UploadPrinterDriverPackageW*(pszServer: LPCWSTR, pszInfPath: LPCWSTR, pszEnvironment: LPCWSTR, dwFlags: DWORD, hwnd: HWND, pszDestInfPath: LPWSTR, pcchDestInfPath: PULONG): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc.}
when winimUnicode:
  type
    PRINTER_INFO_1* = PRINTER_INFO_1W
    PPRINTER_INFO_1* = PPRINTER_INFO_1W
    LPPRINTER_INFO_1* = LPPRINTER_INFO_1W
    PRINTER_INFO_2* = PRINTER_INFO_2W
    PPRINTER_INFO_2* = PPRINTER_INFO_2W
    LPPRINTER_INFO_2* = LPPRINTER_INFO_2W
    PRINTER_INFO_4* = PRINTER_INFO_4W
    PPRINTER_INFO_4* = PPRINTER_INFO_4W
    LPPRINTER_INFO_4* = LPPRINTER_INFO_4W
    PRINTER_INFO_5* = PRINTER_INFO_5W
    PPRINTER_INFO_5* = PPRINTER_INFO_5W
    LPPRINTER_INFO_5* = LPPRINTER_INFO_5W
    PRINTER_INFO_7* = PRINTER_INFO_7W
    PPRINTER_INFO_7* = PPRINTER_INFO_7W
    LPPRINTER_INFO_7* = LPPRINTER_INFO_7W
    PRINTER_INFO_8* = PRINTER_INFO_8W
    PPRINTER_INFO_8* = PPRINTER_INFO_8W
    LPPRINTER_INFO_8* = LPPRINTER_INFO_8W
    PRINTER_INFO_9* = PRINTER_INFO_9W
    PPRINTER_INFO_9* = PPRINTER_INFO_9W
    LPPRINTER_INFO_9* = LPPRINTER_INFO_9W
    JOB_INFO_1* = JOB_INFO_1W
    PJOB_INFO_1* = PJOB_INFO_1W
    LPJOB_INFO_1* = LPJOB_INFO_1W
    JOB_INFO_2* = JOB_INFO_2W
    PJOB_INFO_2* = PJOB_INFO_2W
    LPJOB_INFO_2* = LPJOB_INFO_2W
    ADDJOB_INFO_1* = ADDJOB_INFO_1W
    PADDJOB_INFO_1* = PADDJOB_INFO_1W
    LPADDJOB_INFO_1* = LPADDJOB_INFO_1W
    DRIVER_INFO_1* = DRIVER_INFO_1W
    PDRIVER_INFO_1* = PDRIVER_INFO_1W
    LPDRIVER_INFO_1* = LPDRIVER_INFO_1W
    DRIVER_INFO_2* = DRIVER_INFO_2W
    PDRIVER_INFO_2* = PDRIVER_INFO_2W
    LPDRIVER_INFO_2* = LPDRIVER_INFO_2W
    DRIVER_INFO_3* = DRIVER_INFO_3W
    PDRIVER_INFO_3* = PDRIVER_INFO_3W
    LPDRIVER_INFO_3* = LPDRIVER_INFO_3W
    DRIVER_INFO_4* = DRIVER_INFO_4W
    PDRIVER_INFO_4* = PDRIVER_INFO_4W
    LPDRIVER_INFO_4* = LPDRIVER_INFO_4W
    DRIVER_INFO_5* = DRIVER_INFO_5W
    PDRIVER_INFO_5* = PDRIVER_INFO_5W
    LPDRIVER_INFO_5* = LPDRIVER_INFO_5W
    DRIVER_INFO_6* = DRIVER_INFO_6W
    PDRIVER_INFO_6* = PDRIVER_INFO_6W
    LPDRIVER_INFO_6* = LPDRIVER_INFO_6W
    DOC_INFO_1* = DOC_INFO_1W
    PDOC_INFO_1* = PDOC_INFO_1W
    LPDOC_INFO_1* = LPDOC_INFO_1W
    FORM_INFO_1* = FORM_INFO_1W
    PFORM_INFO_1* = PFORM_INFO_1W
    LPFORM_INFO_1* = LPFORM_INFO_1W
    DOC_INFO_2* = DOC_INFO_2W
    PDOC_INFO_2* = PDOC_INFO_2W
    LPDOC_INFO_2* = LPDOC_INFO_2W
    DOC_INFO_3* = DOC_INFO_3W
    PDOC_INFO_3* = PDOC_INFO_3W
    LPDOC_INFO_3* = LPDOC_INFO_3W
    PRINTPROCESSOR_INFO_1* = PRINTPROCESSOR_INFO_1W
    PPRINTPROCESSOR_INFO_1* = PPRINTPROCESSOR_INFO_1W
    LPPRINTPROCESSOR_INFO_1* = LPPRINTPROCESSOR_INFO_1W
    PORT_INFO_1* = PORT_INFO_1W
    PPORT_INFO_1* = PPORT_INFO_1W
    LPPORT_INFO_1* = LPPORT_INFO_1W
    PORT_INFO_2* = PORT_INFO_2W
    PPORT_INFO_2* = PPORT_INFO_2W
    LPPORT_INFO_2* = LPPORT_INFO_2W
    PORT_INFO_3* = PORT_INFO_3W
    PPORT_INFO_3* = PPORT_INFO_3W
    LPPORT_INFO_3* = LPPORT_INFO_3W
    MONITOR_INFO_1* = MONITOR_INFO_1W
    PMONITOR_INFO_1* = PMONITOR_INFO_1W
    LPMONITOR_INFO_1* = LPMONITOR_INFO_1W
    MONITOR_INFO_2* = MONITOR_INFO_2W
    PMONITOR_INFO_2* = PMONITOR_INFO_2W
    LPMONITOR_INFO_2* = LPMONITOR_INFO_2W
    DATATYPES_INFO_1* = DATATYPES_INFO_1W
    PDATATYPES_INFO_1* = PDATATYPES_INFO_1W
    LPDATATYPES_INFO_1* = LPDATATYPES_INFO_1W
    PRINTER_DEFAULTS* = PRINTER_DEFAULTSW
    PPRINTER_DEFAULTS* = PPRINTER_DEFAULTSW
    PRINTER_ENUM_VALUES* = PRINTER_ENUM_VALUESW
    PPRINTER_ENUM_VALUES* = PPRINTER_ENUM_VALUESW
    LPPRINTER_ENUM_VALUES* = LPPRINTER_ENUM_VALUESW
    PROVIDOR_INFO_1* = PROVIDOR_INFO_1W
    PPROVIDOR_INFO_1* = PPROVIDOR_INFO_1W
    LPPROVIDOR_INFO_1* = LPPROVIDOR_INFO_1W
    PROVIDOR_INFO_2* = PROVIDOR_INFO_2W
    PPROVIDOR_INFO_2* = PPROVIDOR_INFO_2W
    LPPROVIDOR_INFO_2* = LPPROVIDOR_INFO_2W
    DRIVER_INFO_8* = DRIVER_INFO_8W
    PDRIVER_INFO_8* = PDRIVER_INFO_8W
    LPDRIVER_INFO_8* = LPDRIVER_INFO_8W
    FORM_INFO_2* = FORM_INFO_2W
    PFORM_INFO_2* = PFORM_INFO_2W
    CORE_PRINTER_DRIVER* = CORE_PRINTER_DRIVERW
    PCORE_PRINTER_DRIVER* = PCORE_PRINTER_DRIVERW
  proc EnumPrinters*(Flags: DWORD, Name: LPWSTR, Level: DWORD, pPrinterEnum: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrintersW".}
  proc OpenPrinter*(pPrinterName: LPWSTR, phPrinter: LPHANDLE, pDefault: LPPRINTER_DEFAULTSW): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "OpenPrinterW".}
  proc ResetPrinter*(hPrinter: HANDLE, pDefault: LPPRINTER_DEFAULTSW): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "ResetPrinterW".}
  proc SetJob*(hPrinter: HANDLE, JobId: DWORD, Level: DWORD, pJob: LPBYTE, Command: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetJobW".}
  proc GetJob*(hPrinter: HANDLE, JobId: DWORD, Level: DWORD, pJob: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetJobW".}
  proc EnumJobs*(hPrinter: HANDLE, FirstJob: DWORD, NoJobs: DWORD, Level: DWORD, pJob: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumJobsW".}
  proc AddPrinter*(pName: LPWSTR, Level: DWORD, pPrinter: LPBYTE): HANDLE {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterW".}
  proc SetPrinter*(hPrinter: HANDLE, Level: DWORD, pPrinter: LPBYTE, Command: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetPrinterW".}
  proc GetPrinter*(hPrinter: HANDLE, Level: DWORD, pPrinter: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterW".}
  proc AddPrinterDriver*(pName: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterDriverW".}
  proc AddPrinterDriverEx*(pName: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE, dwFileCopyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterDriverExW".}
  proc EnumPrinterDrivers*(pName: LPWSTR, pEnvironment: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrinterDriversW".}
  proc GetPrinterDriver*(hPrinter: HANDLE, pEnvironment: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDriverW".}
  proc GetPrinterDriverDirectory*(pName: LPWSTR, pEnvironment: LPWSTR, Level: DWORD, pDriverDirectory: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDriverDirectoryW".}
  proc DeletePrinterDriver*(pName: LPWSTR, pEnvironment: LPWSTR, pDriverName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDriverW".}
  proc DeletePrinterDriverEx*(pName: LPWSTR, pEnvironment: LPWSTR, pDriverName: LPWSTR, dwDeleteFlag: DWORD, dwVersionFlag: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDriverExW".}
  proc AddPrintProcessor*(pName: LPWSTR, pEnvironment: LPWSTR, pPathName: LPWSTR, pPrintProcessorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrintProcessorW".}
  proc EnumPrintProcessors*(pName: LPWSTR, pEnvironment: LPWSTR, Level: DWORD, pPrintProcessorInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrintProcessorsW".}
  proc GetPrintProcessorDirectory*(pName: LPWSTR, pEnvironment: LPWSTR, Level: DWORD, pPrintProcessorInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrintProcessorDirectoryW".}
  proc EnumPrintProcessorDatatypes*(pName: LPWSTR, pPrintProcessorName: LPWSTR, Level: DWORD, pDatatypes: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrintProcessorDatatypesW".}
  proc DeletePrintProcessor*(pName: LPWSTR, pEnvironment: LPWSTR, pPrintProcessorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrintProcessorW".}
  proc StartDocPrinter*(hPrinter: HANDLE, Level: DWORD, pDocInfo: LPBYTE): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "StartDocPrinterW".}
  proc AddJob*(hPrinter: HANDLE, Level: DWORD, pData: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddJobW".}
  proc DocumentProperties*(hWnd: HWND, hPrinter: HANDLE, pDeviceName: LPWSTR, pDevModeOutput: PDEVMODEW, pDevModeInput: PDEVMODEW, fMode: DWORD): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc: "DocumentPropertiesW".}
  proc AdvancedDocumentProperties*(hWnd: HWND, hPrinter: HANDLE, pDeviceName: LPWSTR, pDevModeOutput: PDEVMODEW, pDevModeInput: PDEVMODEW): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc: "AdvancedDocumentPropertiesW".}
  proc GetPrinterData*(hPrinter: HANDLE, pValueName: LPWSTR, pType: LPDWORD, pData: LPBYTE, nSize: DWORD, pcbNeeded: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDataW".}
  proc GetPrinterDataEx*(hPrinter: HANDLE, pKeyName: LPCWSTR, pValueName: LPCWSTR, pType: LPDWORD, pData: LPBYTE, nSize: DWORD, pcbNeeded: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDataExW".}
  proc EnumPrinterData*(hPrinter: HANDLE, dwIndex: DWORD, pValueName: LPWSTR, cbValueName: DWORD, pcbValueName: LPDWORD, pType: LPDWORD, pData: LPBYTE, cbData: DWORD, pcbData: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrinterDataW".}
  proc EnumPrinterDataEx*(hPrinter: HANDLE, pKeyName: LPCWSTR, pEnumValues: LPBYTE, cbEnumValues: DWORD, pcbEnumValues: LPDWORD, pnEnumValues: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrinterDataExW".}
  proc EnumPrinterKey*(hPrinter: HANDLE, pKeyName: LPCWSTR, pSubkey: LPWSTR, cbSubkey: DWORD, pcbSubkey: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrinterKeyW".}
  proc SetPrinterData*(hPrinter: HANDLE, pValueName: LPWSTR, Type: DWORD, pData: LPBYTE, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetPrinterDataW".}
  proc SetPrinterDataEx*(hPrinter: HANDLE, pKeyName: LPCWSTR, pValueName: LPCWSTR, Type: DWORD, pData: LPBYTE, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetPrinterDataExW".}
  proc DeletePrinterData*(hPrinter: HANDLE, pValueName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDataW".}
  proc DeletePrinterDataEx*(hPrinter: HANDLE, pKeyName: LPCWSTR, pValueName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDataExW".}
  proc DeletePrinterKey*(hPrinter: HANDLE, pKeyName: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterKeyW".}
  proc PrinterMessageBox*(hPrinter: HANDLE, Error: DWORD, hWnd: HWND, pText: LPWSTR, pCaption: LPWSTR, dwType: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "PrinterMessageBoxW".}
  proc AddForm*(hPrinter: HANDLE, Level: DWORD, pForm: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddFormW".}
  proc DeleteForm*(hPrinter: HANDLE, pFormName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeleteFormW".}
  proc GetForm*(hPrinter: HANDLE, pFormName: LPWSTR, Level: DWORD, pForm: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetFormW".}
  proc SetForm*(hPrinter: HANDLE, pFormName: LPWSTR, Level: DWORD, pForm: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetFormW".}
  proc EnumForms*(hPrinter: HANDLE, Level: DWORD, pForm: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumFormsW".}
  proc EnumMonitors*(pName: LPWSTR, Level: DWORD, pMonitor: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumMonitorsW".}
  proc AddMonitor*(pName: LPWSTR, Level: DWORD, pMonitorInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddMonitorW".}
  proc DeleteMonitor*(pName: LPWSTR, pEnvironment: LPWSTR, pMonitorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeleteMonitorW".}
  proc EnumPorts*(pName: LPWSTR, Level: DWORD, pPorts: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPortsW".}
  proc AddPort*(pName: LPWSTR, hWnd: HWND, pMonitorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPortW".}
  proc ConfigurePort*(pName: LPWSTR, hWnd: HWND, pPortName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "ConfigurePortW".}
  proc DeletePort*(pName: LPWSTR, hWnd: HWND, pPortName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePortW".}
  proc GetDefaultPrinter*(pszBuffer: LPWSTR, pcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetDefaultPrinterW".}
  proc SetDefaultPrinter*(pszPrinter: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetDefaultPrinterW".}
  proc SetPort*(pName: LPWSTR, pPortName: LPWSTR, dwLevel: DWORD, pPortInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetPortW".}
  proc AddPrinterConnection*(pName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterConnectionW".}
  proc DeletePrinterConnection*(pName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterConnectionW".}
  proc AddPrintProvidor*(pName: LPWSTR, level: DWORD, pProvidorInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrintProvidorW".}
  proc DeletePrintProvidor*(pName: LPWSTR, pEnvironment: LPWSTR, pPrintProvidorName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrintProvidorW".}
  proc IsValidDevmode*(pDevmode: PDEVMODEW, DevmodeSize: int): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "IsValidDevmodeW".}
  proc AddPrinterConnection2*(hWnd: HWND, pszName: LPCWSTR, dwLevel: DWORD, pConnectionInfo: PVOID): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterConnection2W".}
  proc DeletePrinterDriverPackage*(pszServer: LPCWSTR, pszInfPath: LPCWSTR, pszEnvironment: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDriverPackageW".}
  proc GetCorePrinterDrivers*(pszServer: LPCWSTR, pszEnvironment: LPCWSTR, pszzCoreDriverDependencies: LPCWSTR, cCorePrinterDrivers: DWORD, pCorePrinterDrivers: PCORE_PRINTER_DRIVERW): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetCorePrinterDriversW".}
  proc GetPrinterDriver2*(hWnd: HWND, hPrinter: HANDLE, pEnvironment: LPWSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDriver2W".}
  proc GetPrinterDriverPackagePath*(pszServer: LPCWSTR, pszEnvironment: LPCWSTR, pszLanguage: LPCWSTR, pszPackageID: LPCWSTR, pszDriverPackageCab: LPWSTR, cchDriverPackageCab: DWORD, pcchRequiredSize: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDriverPackagePathW".}
  proc OpenPrinter2*(pPrinterName: LPCWSTR, phPrinter: LPHANDLE, pDefault: LPPRINTER_DEFAULTS, pOptions: PPRINTER_OPTIONS): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "OpenPrinter2W".}
  proc UploadPrinterDriverPackage*(pszServer: LPCWSTR, pszInfPath: LPCWSTR, pszEnvironment: LPCWSTR, dwFlags: DWORD, hwnd: HWND, pszDestInfPath: LPWSTR, pcchDestInfPath: PULONG): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc: "UploadPrinterDriverPackageW".}
when winimAnsi:
  type
    PRINTER_INFO_1* = PRINTER_INFO_1A
    PPRINTER_INFO_1* = PPRINTER_INFO_1A
    LPPRINTER_INFO_1* = LPPRINTER_INFO_1A
    PRINTER_INFO_2* = PRINTER_INFO_2A
    PPRINTER_INFO_2* = PPRINTER_INFO_2A
    LPPRINTER_INFO_2* = LPPRINTER_INFO_2A
    PRINTER_INFO_4* = PRINTER_INFO_4A
    PPRINTER_INFO_4* = PPRINTER_INFO_4A
    LPPRINTER_INFO_4* = LPPRINTER_INFO_4A
    PRINTER_INFO_5* = PRINTER_INFO_5A
    PPRINTER_INFO_5* = PPRINTER_INFO_5A
    LPPRINTER_INFO_5* = LPPRINTER_INFO_5A
    PRINTER_INFO_7* = PRINTER_INFO_7A
    PPRINTER_INFO_7* = PPRINTER_INFO_7A
    LPPRINTER_INFO_7* = LPPRINTER_INFO_7A
    PRINTER_INFO_8* = PRINTER_INFO_8A
    PPRINTER_INFO_8* = PPRINTER_INFO_8A
    LPPRINTER_INFO_8* = LPPRINTER_INFO_8A
    PRINTER_INFO_9* = PRINTER_INFO_9A
    PPRINTER_INFO_9* = PPRINTER_INFO_9A
    LPPRINTER_INFO_9* = LPPRINTER_INFO_9A
    JOB_INFO_1* = JOB_INFO_1A
    PJOB_INFO_1* = PJOB_INFO_1A
    LPJOB_INFO_1* = LPJOB_INFO_1A
    JOB_INFO_2* = JOB_INFO_2A
    PJOB_INFO_2* = PJOB_INFO_2A
    LPJOB_INFO_2* = LPJOB_INFO_2A
    ADDJOB_INFO_1* = ADDJOB_INFO_1A
    PADDJOB_INFO_1* = PADDJOB_INFO_1A
    LPADDJOB_INFO_1* = LPADDJOB_INFO_1A
    DRIVER_INFO_1* = DRIVER_INFO_1A
    PDRIVER_INFO_1* = PDRIVER_INFO_1A
    LPDRIVER_INFO_1* = LPDRIVER_INFO_1A
    DRIVER_INFO_2* = DRIVER_INFO_2A
    PDRIVER_INFO_2* = PDRIVER_INFO_2A
    LPDRIVER_INFO_2* = LPDRIVER_INFO_2A
    DRIVER_INFO_3* = DRIVER_INFO_3A
    PDRIVER_INFO_3* = PDRIVER_INFO_3A
    LPDRIVER_INFO_3* = LPDRIVER_INFO_3A
    DRIVER_INFO_4* = DRIVER_INFO_4A
    PDRIVER_INFO_4* = PDRIVER_INFO_4A
    LPDRIVER_INFO_4* = LPDRIVER_INFO_4A
    DRIVER_INFO_5* = DRIVER_INFO_5A
    PDRIVER_INFO_5* = PDRIVER_INFO_5A
    LPDRIVER_INFO_5* = LPDRIVER_INFO_5A
    DRIVER_INFO_6* = DRIVER_INFO_6A
    PDRIVER_INFO_6* = PDRIVER_INFO_6A
    LPDRIVER_INFO_6* = LPDRIVER_INFO_6A
    DOC_INFO_1* = DOC_INFO_1A
    PDOC_INFO_1* = PDOC_INFO_1A
    LPDOC_INFO_1* = LPDOC_INFO_1A
    FORM_INFO_1* = FORM_INFO_1A
    PFORM_INFO_1* = PFORM_INFO_1A
    LPFORM_INFO_1* = LPFORM_INFO_1A
    DOC_INFO_2* = DOC_INFO_2A
    PDOC_INFO_2* = PDOC_INFO_2A
    LPDOC_INFO_2* = LPDOC_INFO_2A
    DOC_INFO_3* = DOC_INFO_3A
    PDOC_INFO_3* = PDOC_INFO_3A
    LPDOC_INFO_3* = LPDOC_INFO_3A
    PRINTPROCESSOR_INFO_1* = PRINTPROCESSOR_INFO_1A
    PPRINTPROCESSOR_INFO_1* = PPRINTPROCESSOR_INFO_1A
    LPPRINTPROCESSOR_INFO_1* = LPPRINTPROCESSOR_INFO_1A
    PORT_INFO_1* = PORT_INFO_1A
    PPORT_INFO_1* = PPORT_INFO_1A
    LPPORT_INFO_1* = LPPORT_INFO_1A
    PORT_INFO_2* = PORT_INFO_2A
    PPORT_INFO_2* = PPORT_INFO_2A
    LPPORT_INFO_2* = LPPORT_INFO_2A
    PORT_INFO_3* = PORT_INFO_3A
    PPORT_INFO_3* = PPORT_INFO_3A
    LPPORT_INFO_3* = LPPORT_INFO_3A
    MONITOR_INFO_1* = MONITOR_INFO_1A
    PMONITOR_INFO_1* = PMONITOR_INFO_1A
    LPMONITOR_INFO_1* = LPMONITOR_INFO_1A
    MONITOR_INFO_2* = MONITOR_INFO_2A
    PMONITOR_INFO_2* = PMONITOR_INFO_2A
    LPMONITOR_INFO_2* = LPMONITOR_INFO_2A
    DATATYPES_INFO_1* = DATATYPES_INFO_1A
    PDATATYPES_INFO_1* = PDATATYPES_INFO_1A
    LPDATATYPES_INFO_1* = LPDATATYPES_INFO_1A
    PRINTER_DEFAULTS* = PRINTER_DEFAULTSA
    PPRINTER_DEFAULTS* = PPRINTER_DEFAULTSA
    PRINTER_ENUM_VALUES* = PRINTER_ENUM_VALUESA
    PPRINTER_ENUM_VALUES* = PPRINTER_ENUM_VALUESA
    LPPRINTER_ENUM_VALUES* = LPPRINTER_ENUM_VALUESA
    PROVIDOR_INFO_1* = PROVIDOR_INFO_1A
    PPROVIDOR_INFO_1* = PPROVIDOR_INFO_1A
    LPPROVIDOR_INFO_1* = LPPROVIDOR_INFO_1A
    PROVIDOR_INFO_2* = PROVIDOR_INFO_2A
    PPROVIDOR_INFO_2* = PPROVIDOR_INFO_2A
    LPPROVIDOR_INFO_2* = LPPROVIDOR_INFO_2A
    DRIVER_INFO_8* = DRIVER_INFO_8A
    PDRIVER_INFO_8* = PDRIVER_INFO_8A
    LPDRIVER_INFO_8* = LPDRIVER_INFO_8A
    FORM_INFO_2* = FORM_INFO_2A
    PFORM_INFO_2* = PFORM_INFO_2A
    CORE_PRINTER_DRIVER* = CORE_PRINTER_DRIVERA
    PCORE_PRINTER_DRIVER* = PCORE_PRINTER_DRIVERA
  proc EnumPrinters*(Flags: DWORD, Name: LPSTR, Level: DWORD, pPrinterEnum: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrintersA".}
  proc OpenPrinter*(pPrinterName: LPSTR, phPrinter: LPHANDLE, pDefault: LPPRINTER_DEFAULTSA): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "OpenPrinterA".}
  proc ResetPrinter*(hPrinter: HANDLE, pDefault: LPPRINTER_DEFAULTSA): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "ResetPrinterA".}
  proc SetJob*(hPrinter: HANDLE, JobId: DWORD, Level: DWORD, pJob: LPBYTE, Command: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetJobA".}
  proc GetJob*(hPrinter: HANDLE, JobId: DWORD, Level: DWORD, pJob: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetJobA".}
  proc EnumJobs*(hPrinter: HANDLE, FirstJob: DWORD, NoJobs: DWORD, Level: DWORD, pJob: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumJobsA".}
  proc AddPrinter*(pName: LPSTR, Level: DWORD, pPrinter: LPBYTE): HANDLE {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterA".}
  proc SetPrinter*(hPrinter: HANDLE, Level: DWORD, pPrinter: LPBYTE, Command: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetPrinterA".}
  proc GetPrinter*(hPrinter: HANDLE, Level: DWORD, pPrinter: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterA".}
  proc AddPrinterDriver*(pName: LPSTR, Level: DWORD, pDriverInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterDriverA".}
  proc AddPrinterDriverEx*(pName: LPSTR, Level: DWORD, pDriverInfo: LPBYTE, dwFileCopyFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterDriverExA".}
  proc EnumPrinterDrivers*(pName: LPSTR, pEnvironment: LPSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrinterDriversA".}
  proc GetPrinterDriver*(hPrinter: HANDLE, pEnvironment: LPSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDriverA".}
  proc GetPrinterDriverDirectory*(pName: LPSTR, pEnvironment: LPSTR, Level: DWORD, pDriverDirectory: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDriverDirectoryA".}
  proc DeletePrinterDriver*(pName: LPSTR, pEnvironment: LPSTR, pDriverName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDriverA".}
  proc DeletePrinterDriverEx*(pName: LPSTR, pEnvironment: LPSTR, pDriverName: LPSTR, dwDeleteFlag: DWORD, dwVersionFlag: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDriverExA".}
  proc AddPrintProcessor*(pName: LPSTR, pEnvironment: LPSTR, pPathName: LPSTR, pPrintProcessorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrintProcessorA".}
  proc EnumPrintProcessors*(pName: LPSTR, pEnvironment: LPSTR, Level: DWORD, pPrintProcessorInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrintProcessorsA".}
  proc GetPrintProcessorDirectory*(pName: LPSTR, pEnvironment: LPSTR, Level: DWORD, pPrintProcessorInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrintProcessorDirectoryA".}
  proc EnumPrintProcessorDatatypes*(pName: LPSTR, pPrintProcessorName: LPSTR, Level: DWORD, pDatatypes: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrintProcessorDatatypesA".}
  proc DeletePrintProcessor*(pName: LPSTR, pEnvironment: LPSTR, pPrintProcessorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrintProcessorA".}
  proc StartDocPrinter*(hPrinter: HANDLE, Level: DWORD, pDocInfo: LPBYTE): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "StartDocPrinterA".}
  proc AddJob*(hPrinter: HANDLE, Level: DWORD, pData: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddJobA".}
  proc DocumentProperties*(hWnd: HWND, hPrinter: HANDLE, pDeviceName: LPSTR, pDevModeOutput: PDEVMODEA, pDevModeInput: PDEVMODEA, fMode: DWORD): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc: "DocumentPropertiesA".}
  proc AdvancedDocumentProperties*(hWnd: HWND, hPrinter: HANDLE, pDeviceName: LPSTR, pDevModeOutput: PDEVMODEA, pDevModeInput: PDEVMODEA): LONG {.winapi, stdcall, dynlib: "winspool.drv", importc: "AdvancedDocumentPropertiesA".}
  proc GetPrinterData*(hPrinter: HANDLE, pValueName: LPSTR, pType: LPDWORD, pData: LPBYTE, nSize: DWORD, pcbNeeded: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDataA".}
  proc GetPrinterDataEx*(hPrinter: HANDLE, pKeyName: LPCSTR, pValueName: LPCSTR, pType: LPDWORD, pData: LPBYTE, nSize: DWORD, pcbNeeded: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDataExA".}
  proc EnumPrinterData*(hPrinter: HANDLE, dwIndex: DWORD, pValueName: LPSTR, cbValueName: DWORD, pcbValueName: LPDWORD, pType: LPDWORD, pData: LPBYTE, cbData: DWORD, pcbData: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrinterDataA".}
  proc EnumPrinterDataEx*(hPrinter: HANDLE, pKeyName: LPCSTR, pEnumValues: LPBYTE, cbEnumValues: DWORD, pcbEnumValues: LPDWORD, pnEnumValues: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrinterDataExA".}
  proc EnumPrinterKey*(hPrinter: HANDLE, pKeyName: LPCSTR, pSubkey: LPSTR, cbSubkey: DWORD, pcbSubkey: LPDWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPrinterKeyA".}
  proc SetPrinterData*(hPrinter: HANDLE, pValueName: LPSTR, Type: DWORD, pData: LPBYTE, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetPrinterDataA".}
  proc SetPrinterDataEx*(hPrinter: HANDLE, pKeyName: LPCSTR, pValueName: LPCSTR, Type: DWORD, pData: LPBYTE, cbData: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetPrinterDataExA".}
  proc DeletePrinterData*(hPrinter: HANDLE, pValueName: LPSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDataA".}
  proc DeletePrinterDataEx*(hPrinter: HANDLE, pKeyName: LPCSTR, pValueName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDataExA".}
  proc DeletePrinterKey*(hPrinter: HANDLE, pKeyName: LPCSTR): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterKeyA".}
  proc PrinterMessageBox*(hPrinter: HANDLE, Error: DWORD, hWnd: HWND, pText: LPSTR, pCaption: LPSTR, dwType: DWORD): DWORD {.winapi, stdcall, dynlib: "winspool.drv", importc: "PrinterMessageBoxA".}
  proc AddForm*(hPrinter: HANDLE, Level: DWORD, pForm: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddFormA".}
  proc DeleteForm*(hPrinter: HANDLE, pFormName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeleteFormA".}
  proc GetForm*(hPrinter: HANDLE, pFormName: LPSTR, Level: DWORD, pForm: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetFormA".}
  proc SetForm*(hPrinter: HANDLE, pFormName: LPSTR, Level: DWORD, pForm: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetFormA".}
  proc EnumForms*(hPrinter: HANDLE, Level: DWORD, pForm: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumFormsA".}
  proc EnumMonitors*(pName: LPSTR, Level: DWORD, pMonitor: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumMonitorsA".}
  proc AddMonitor*(pName: LPSTR, Level: DWORD, pMonitorInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddMonitorA".}
  proc DeleteMonitor*(pName: LPSTR, pEnvironment: LPSTR, pMonitorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeleteMonitorA".}
  proc EnumPorts*(pName: LPSTR, Level: DWORD, pPorts: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD, pcReturned: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "EnumPortsA".}
  proc AddPort*(pName: LPSTR, hWnd: HWND, pMonitorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPortA".}
  proc ConfigurePort*(pName: LPSTR, hWnd: HWND, pPortName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "ConfigurePortA".}
  proc DeletePort*(pName: LPSTR, hWnd: HWND, pPortName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePortA".}
  proc GetDefaultPrinter*(pszBuffer: LPSTR, pcchBuffer: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetDefaultPrinterA".}
  proc SetDefaultPrinter*(pszPrinter: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetDefaultPrinterA".}
  proc SetPort*(pName: LPSTR, pPortName: LPSTR, dwLevel: DWORD, pPortInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "SetPortA".}
  proc AddPrinterConnection*(pName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterConnectionA".}
  proc DeletePrinterConnection*(pName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterConnectionA".}
  proc AddPrintProvidor*(pName: LPSTR, level: DWORD, pProvidorInfo: LPBYTE): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrintProvidorA".}
  proc DeletePrintProvidor*(pName: LPSTR, pEnvironment: LPSTR, pPrintProvidorName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrintProvidorA".}
  proc IsValidDevmode*(pDevmode: PDEVMODEA, DevmodeSize: int): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "IsValidDevmodeA".}
  proc AddPrinterConnection2*(hWnd: HWND, pszName: LPCSTR, dwLevel: DWORD, pConnectionInfo: PVOID): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "AddPrinterConnection2A".}
  proc DeletePrinterDriverPackage*(pszServer: LPCSTR, pszInfPath: LPCSTR, pszEnvironment: LPCSTR): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc: "DeletePrinterDriverPackageA".}
  proc GetCorePrinterDrivers*(pszServer: LPCSTR, pszEnvironment: LPCSTR, pszzCoreDriverDependencies: LPCSTR, cCorePrinterDrivers: DWORD, pCorePrinterDrivers: PCORE_PRINTER_DRIVERA): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetCorePrinterDriversA".}
  proc GetPrinterDriver2*(hWnd: HWND, hPrinter: HANDLE, pEnvironment: LPSTR, Level: DWORD, pDriverInfo: LPBYTE, cbBuf: DWORD, pcbNeeded: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDriver2A".}
  proc GetPrinterDriverPackagePath*(pszServer: LPCSTR, pszEnvironment: LPCSTR, pszLanguage: LPCSTR, pszPackageID: LPCSTR, pszDriverPackageCab: LPSTR, cchDriverPackageCab: DWORD, pcchRequiredSize: LPDWORD): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc: "GetPrinterDriverPackagePathA".}
  proc OpenPrinter2*(pPrinterName: LPCSTR, phPrinter: LPHANDLE, pDefault: LPPRINTER_DEFAULTS, pOptions: PPRINTER_OPTIONS): WINBOOL {.winapi, stdcall, dynlib: "winspool.drv", importc: "OpenPrinter2A".}
  proc UploadPrinterDriverPackage*(pszServer: LPCSTR, pszInfPath: LPCSTR, pszEnvironment: LPCSTR, dwFlags: DWORD, hwnd: HWND, pszDestInfPath: LPSTR, pcchDestInfPath: PULONG): HRESULT {.winapi, stdcall, dynlib: "winspool.drv", importc: "UploadPrinterDriverPackageA".}
