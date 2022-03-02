#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <tlhelp32.h>
type
  HEAPLIST32* {.pure.} = object
    dwSize*: SIZE_T
    th32ProcessID*: DWORD
    th32HeapID*: ULONG_PTR
    dwFlags*: DWORD
  PHEAPLIST32* = ptr HEAPLIST32
  LPHEAPLIST32* = ptr HEAPLIST32
  HEAPENTRY32* {.pure.} = object
    dwSize*: SIZE_T
    hHandle*: HANDLE
    dwAddress*: ULONG_PTR
    dwBlockSize*: SIZE_T
    dwFlags*: DWORD
    dwLockCount*: DWORD
    dwResvd*: DWORD
    th32ProcessID*: DWORD
    th32HeapID*: ULONG_PTR
  PHEAPENTRY32* = ptr HEAPENTRY32
  LPHEAPENTRY32* = ptr HEAPENTRY32
  PROCESSENTRY32W* {.pure.} = object
    dwSize*: DWORD
    cntUsage*: DWORD
    th32ProcessID*: DWORD
    th32DefaultHeapID*: ULONG_PTR
    th32ModuleID*: DWORD
    cntThreads*: DWORD
    th32ParentProcessID*: DWORD
    pcPriClassBase*: LONG
    dwFlags*: DWORD
    szExeFile*: array[MAX_PATH, WCHAR]
  PPROCESSENTRY32W* = ptr PROCESSENTRY32W
  LPPROCESSENTRY32W* = ptr PROCESSENTRY32W
  THREADENTRY32* {.pure.} = object
    dwSize*: DWORD
    cntUsage*: DWORD
    th32ThreadID*: DWORD
    th32OwnerProcessID*: DWORD
    tpBasePri*: LONG
    tpDeltaPri*: LONG
    dwFlags*: DWORD
  PTHREADENTRY32* = ptr THREADENTRY32
  LPTHREADENTRY32* = ptr THREADENTRY32
const
  MAX_MODULE_NAME32* = 255
type
  MODULEENTRY32W* {.pure.} = object
    dwSize*: DWORD
    th32ModuleID*: DWORD
    th32ProcessID*: DWORD
    GlblcntUsage*: DWORD
    ProccntUsage*: DWORD
    modBaseAddr*: ptr BYTE
    modBaseSize*: DWORD
    hModule*: HMODULE
    szModule*: array[MAX_MODULE_NAME32 + 1, WCHAR]
    szExePath*: array[MAX_PATH, WCHAR]
  PMODULEENTRY32W* = ptr MODULEENTRY32W
  LPMODULEENTRY32W* = ptr MODULEENTRY32W
when winimUnicode:
  type
    MODULEENTRY32* = MODULEENTRY32W
type
  MODULEENTRY32A* {.pure.} = object
    dwSize*: DWORD
    th32ModuleID*: DWORD
    th32ProcessID*: DWORD
    GlblcntUsage*: DWORD
    ProccntUsage*: DWORD
    modBaseAddr*: ptr BYTE
    modBaseSize*: DWORD
    hModule*: HMODULE
    szModule*: array[MAX_MODULE_NAME32 + 1, char]
    szExePath*: array[MAX_PATH, char]
when winimAnsi:
  type
    MODULEENTRY32* = MODULEENTRY32A
type
  LPMODULEENTRY32* = ptr MODULEENTRY32
  PROCESSENTRY32A* {.pure.} = object
    dwSize*: DWORD
    cntUsage*: DWORD
    th32ProcessID*: DWORD
    th32DefaultHeapID*: ULONG_PTR
    th32ModuleID*: DWORD
    cntThreads*: DWORD
    th32ParentProcessID*: DWORD
    pcPriClassBase*: LONG
    dwFlags*: DWORD
    szExeFile*: array[MAX_PATH, CHAR]
  PPROCESSENTRY32A* = ptr PROCESSENTRY32A
  LPPROCESSENTRY32A* = ptr PROCESSENTRY32A
  PMODULEENTRY32A* = ptr MODULEENTRY32A
  LPMODULEENTRY32A* = ptr MODULEENTRY32A
const
  TH32CS_SNAPHEAPLIST* = 0x00000001
  TH32CS_SNAPPROCESS* = 0x00000002
  TH32CS_SNAPTHREAD* = 0x00000004
  TH32CS_SNAPMODULE* = 0x00000008
  TH32CS_SNAPMODULE32* = 0x00000010
  TH32CS_SNAPALL* = TH32CS_SNAPHEAPLIST or TH32CS_SNAPPROCESS or TH32CS_SNAPTHREAD or TH32CS_SNAPMODULE
  TH32CS_INHERIT* = 0x80000000'i32
  HF32_DEFAULT* = 1
  HF32_SHARED* = 2
  LF32_FIXED* = 0x00000001
  LF32_FREE* = 0x00000002
  LF32_MOVEABLE* = 0x00000004
proc CreateToolhelp32Snapshot*(dwFlags: DWORD, th32ProcessID: DWORD): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Heap32ListFirst*(hSnapshot: HANDLE, lphl: LPHEAPLIST32): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Heap32ListNext*(hSnapshot: HANDLE, lphl: LPHEAPLIST32): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Heap32First*(lphe: LPHEAPENTRY32, th32ProcessID: DWORD, th32HeapID: ULONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Heap32Next*(lphe: LPHEAPENTRY32): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Toolhelp32ReadProcessMemory*(th32ProcessID: DWORD, lpBaseAddress: LPCVOID, lpBuffer: LPVOID, cbRead: SIZE_T, lpNumberOfBytesRead: ptr SIZE_T): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Process32FirstW*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32W): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Process32NextW*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32W): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Process32FirstA*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32A): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "Process32First".}
proc Process32NextA*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32A): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "Process32Next".}
proc Thread32First*(hSnapshot: HANDLE, lpte: LPTHREADENTRY32): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Thread32Next*(hSnapshot: HANDLE, lpte: LPTHREADENTRY32): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Module32FirstW*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32W): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Module32NextW*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32W): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc Module32FirstA*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32A): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "Module32First".}
proc Module32NextA*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32A): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "Module32Next".}
when winimUnicode:
  type
    PROCESSENTRY32* = PROCESSENTRY32W
    PPROCESSENTRY32* = ptr PROCESSENTRY32W
    LPPROCESSENTRY32* = ptr PROCESSENTRY32W
    PMODULEENTRY32* = ptr MODULEENTRY32W
    LMODULEENTRY32* = ptr MODULEENTRY32W
  proc Process32First*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32W): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "Process32FirstW".}
  proc Process32Next*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32W): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "Process32NextW".}
  proc Module32First*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32W): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "Module32FirstW".}
  proc Module32Next*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32W): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "Module32NextW".}
when winimAnsi:
  type
    PROCESSENTRY32* = PROCESSENTRY32A
    PPROCESSENTRY32* = ptr PROCESSENTRY32A
    LPPROCESSENTRY32* = ptr PROCESSENTRY32A
    PMODULEENTRY32* = ptr MODULEENTRY32A
    LMODULEENTRY32* = ptr MODULEENTRY32A
  proc Process32First*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32A): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
  proc Process32Next*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32A): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
  proc Module32First*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32A): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
  proc Module32Next*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32A): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
