#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winuser
#include <winver.h>
const
  VS_FILE_INFO* = RT_VERSION
  VS_VERSION_INFO* = 1
  VS_USER_DEFINED* = 100
  VS_FFI_SIGNATURE* = 0xFEEF04BD'i32
  VS_FFI_STRUCVERSION* = 0x00010000
  VS_FFI_FILEFLAGSMASK* = 0x0000003F
  VS_FF_DEBUG* = 0x00000001
  VS_FF_PRERELEASE* = 0x00000002
  VS_FF_PATCHED* = 0x00000004
  VS_FF_PRIVATEBUILD* = 0x00000008
  VS_FF_INFOINFERRED* = 0x00000010
  VS_FF_SPECIALBUILD* = 0x00000020
  VOS_UNKNOWN* = 0x00000000
  VOS_DOS* = 0x00010000
  VOS_OS216* = 0x00020000
  VOS_OS232* = 0x00030000
  VOS_NT* = 0x00040000
  VOS_WINCE* = 0x00050000
  VOS_BASE* = 0x00000000
  VOS_WINDOWS16* = 0x00000001
  VOS_PM16* = 0x00000002
  VOS_PM32* = 0x00000003
  VOS_WINDOWS32* = 0x00000004
  VOS_DOS_WINDOWS16* = 0x00010001
  VOS_DOS_WINDOWS32* = 0x00010004
  VOS_OS216_PM16* = 0x00020002
  VOS_OS232_PM32* = 0x00030003
  VOS_NT_WINDOWS32* = 0x00040004
  VFT_UNKNOWN* = 0x00000000
  VFT_APP* = 0x00000001
  VFT_DLL* = 0x00000002
  VFT_DRV* = 0x00000003
  VFT_FONT* = 0x00000004
  VFT_VXD* = 0x00000005
  VFT_STATIC_LIB* = 0x00000007
  VFT2_UNKNOWN* = 0x00000000
  VFT2_DRV_PRINTER* = 0x00000001
  VFT2_DRV_KEYBOARD* = 0x00000002
  VFT2_DRV_LANGUAGE* = 0x00000003
  VFT2_DRV_DISPLAY* = 0x00000004
  VFT2_DRV_MOUSE* = 0x00000005
  VFT2_DRV_NETWORK* = 0x00000006
  VFT2_DRV_SYSTEM* = 0x00000007
  VFT2_DRV_INSTALLABLE* = 0x00000008
  VFT2_DRV_SOUND* = 0x00000009
  VFT2_DRV_COMM* = 0x0000000A
  VFT2_DRV_INPUTMETHOD* = 0x0000000B
  VFT2_DRV_VERSIONED_PRINTER* = 0x0000000C
  VFT2_FONT_RASTER* = 0x00000001
  VFT2_FONT_VECTOR* = 0x00000002
  VFT2_FONT_TRUETYPE* = 0x00000003
  VFFF_ISSHAREDFILE* = 0x0001
  VFF_CURNEDEST* = 0x0001
  VFF_FILEINUSE* = 0x0002
  VFF_BUFFTOOSMALL* = 0x0004
  VIFF_FORCEINSTALL* = 0x0001
  VIFF_DONTDELETEOLD* = 0x0002
  VIF_TEMPFILE* = 0x00000001
  VIF_MISMATCH* = 0x00000002
  VIF_SRCOLD* = 0x00000004
  VIF_DIFFLANG* = 0x00000008
  VIF_DIFFCODEPG* = 0x00000010
  VIF_DIFFTYPE* = 0x00000020
  VIF_WRITEPROT* = 0x00000040
  VIF_FILEINUSE* = 0x00000080
  VIF_OUTOFSPACE* = 0x00000100
  VIF_ACCESSVIOLATION* = 0x00000200
  VIF_SHARINGVIOLATION* = 0x00000400
  VIF_CANNOTCREATE* = 0x00000800
  VIF_CANNOTDELETE* = 0x00001000
  VIF_CANNOTRENAME* = 0x00002000
  VIF_CANNOTDELETECUR* = 0x00004000
  VIF_OUTOFMEMORY* = 0x00008000
  VIF_CANNOTREADSRC* = 0x00010000
  VIF_CANNOTREADDST* = 0x00020000
  VIF_BUFFTOOSMALL* = 0x00040000
  VIF_CANNOTLOADLZ32* = 0x00080000
  VIF_CANNOTLOADCABINET* = 0x00100000
type
  VS_FIXEDFILEINFO* {.pure.} = object
    dwSignature*: DWORD
    dwStrucVersion*: DWORD
    dwFileVersionMS*: DWORD
    dwFileVersionLS*: DWORD
    dwProductVersionMS*: DWORD
    dwProductVersionLS*: DWORD
    dwFileFlagsMask*: DWORD
    dwFileFlags*: DWORD
    dwFileOS*: DWORD
    dwFileType*: DWORD
    dwFileSubtype*: DWORD
    dwFileDateMS*: DWORD
    dwFileDateLS*: DWORD
proc VerFindFileA*(uFlags: DWORD, szFileName: LPSTR, szWinDir: LPSTR, szAppDir: LPSTR, szCurDir: LPSTR, lpuCurDirLen: PUINT, szDestDir: LPSTR, lpuDestDirLen: PUINT): DWORD {.winapi, stdcall, dynlib: "version", importc.}
proc VerFindFileW*(uFlags: DWORD, szFileName: LPWSTR, szWinDir: LPWSTR, szAppDir: LPWSTR, szCurDir: LPWSTR, lpuCurDirLen: PUINT, szDestDir: LPWSTR, lpuDestDirLen: PUINT): DWORD {.winapi, stdcall, dynlib: "version", importc.}
proc VerInstallFileA*(uFlags: DWORD, szSrcFileName: LPSTR, szDestFileName: LPSTR, szSrcDir: LPSTR, szDestDir: LPSTR, szCurDir: LPSTR, szTmpFile: LPSTR, lpuTmpFileLen: PUINT): DWORD {.winapi, stdcall, dynlib: "version", importc.}
proc VerInstallFileW*(uFlags: DWORD, szSrcFileName: LPWSTR, szDestFileName: LPWSTR, szSrcDir: LPWSTR, szDestDir: LPWSTR, szCurDir: LPWSTR, szTmpFile: LPWSTR, lpuTmpFileLen: PUINT): DWORD {.winapi, stdcall, dynlib: "version", importc.}
proc GetFileVersionInfoSizeA*(lptstrFilename: LPCSTR, lpdwHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "version", importc.}
proc GetFileVersionInfoSizeW*(lptstrFilename: LPCWSTR, lpdwHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "version", importc.}
proc GetFileVersionInfoA*(lptstrFilename: LPCSTR, dwHandle: DWORD, dwLen: DWORD, lpData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "version", importc.}
proc GetFileVersionInfoW*(lptstrFilename: LPCWSTR, dwHandle: DWORD, dwLen: DWORD, lpData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "version", importc.}
proc VerLanguageNameA*(wLang: DWORD, szLang: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "version", importc.}
proc VerLanguageNameW*(wLang: DWORD, szLang: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "version", importc.}
proc VerQueryValueA*(pBlock: LPVOID, lpSubBlock: LPCSTR, lplpBuffer: ptr LPVOID, puLen: PUINT): WINBOOL {.winapi, stdcall, dynlib: "version", importc.}
proc VerQueryValueW*(pBlock: LPVOID, lpSubBlock: LPCWSTR, lplpBuffer: ptr LPVOID, puLen: PUINT): WINBOOL {.winapi, stdcall, dynlib: "version", importc.}
when winimUnicode:
  proc VerFindFile*(uFlags: DWORD, szFileName: LPWSTR, szWinDir: LPWSTR, szAppDir: LPWSTR, szCurDir: LPWSTR, lpuCurDirLen: PUINT, szDestDir: LPWSTR, lpuDestDirLen: PUINT): DWORD {.winapi, stdcall, dynlib: "version", importc: "VerFindFileW".}
  proc VerInstallFile*(uFlags: DWORD, szSrcFileName: LPWSTR, szDestFileName: LPWSTR, szSrcDir: LPWSTR, szDestDir: LPWSTR, szCurDir: LPWSTR, szTmpFile: LPWSTR, lpuTmpFileLen: PUINT): DWORD {.winapi, stdcall, dynlib: "version", importc: "VerInstallFileW".}
  proc GetFileVersionInfoSize*(lptstrFilename: LPCWSTR, lpdwHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "version", importc: "GetFileVersionInfoSizeW".}
  proc GetFileVersionInfo*(lptstrFilename: LPCWSTR, dwHandle: DWORD, dwLen: DWORD, lpData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "version", importc: "GetFileVersionInfoW".}
  proc VerLanguageName*(wLang: DWORD, szLang: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "version", importc: "VerLanguageNameW".}
  proc VerQueryValue*(pBlock: LPVOID, lpSubBlock: LPCWSTR, lplpBuffer: ptr LPVOID, puLen: PUINT): WINBOOL {.winapi, stdcall, dynlib: "version", importc: "VerQueryValueW".}
when winimAnsi:
  proc VerFindFile*(uFlags: DWORD, szFileName: LPSTR, szWinDir: LPSTR, szAppDir: LPSTR, szCurDir: LPSTR, lpuCurDirLen: PUINT, szDestDir: LPSTR, lpuDestDirLen: PUINT): DWORD {.winapi, stdcall, dynlib: "version", importc: "VerFindFileA".}
  proc VerInstallFile*(uFlags: DWORD, szSrcFileName: LPSTR, szDestFileName: LPSTR, szSrcDir: LPSTR, szDestDir: LPSTR, szCurDir: LPSTR, szTmpFile: LPSTR, lpuTmpFileLen: PUINT): DWORD {.winapi, stdcall, dynlib: "version", importc: "VerInstallFileA".}
  proc GetFileVersionInfoSize*(lptstrFilename: LPCSTR, lpdwHandle: LPDWORD): DWORD {.winapi, stdcall, dynlib: "version", importc: "GetFileVersionInfoSizeA".}
  proc GetFileVersionInfo*(lptstrFilename: LPCSTR, dwHandle: DWORD, dwLen: DWORD, lpData: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "version", importc: "GetFileVersionInfoA".}
  proc VerLanguageName*(wLang: DWORD, szLang: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "version", importc: "VerLanguageNameA".}
  proc VerQueryValue*(pBlock: LPVOID, lpSubBlock: LPCSTR, lplpBuffer: ptr LPVOID, puLen: PUINT): WINBOOL {.winapi, stdcall, dynlib: "version", importc: "VerQueryValueA".}
