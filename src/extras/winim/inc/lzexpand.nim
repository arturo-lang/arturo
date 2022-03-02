#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
#include <lzexpand.h>
const
  LZERROR_BADINHANDLE* = -1
  LZERROR_BADOUTHANDLE* = -2
  LZERROR_READ* = -3
  LZERROR_WRITE* = -4
  LZERROR_GLOBALLOC* = -5
  LZERROR_GLOBLOCK* = -6
  LZERROR_BADVALUE* = -7
  LZERROR_UNKNOWNALG* = -8
proc LZStart*(): INT {.winapi, stdcall, dynlib: "lz32", importc.}
proc LZDone*(): VOID {.winapi, stdcall, dynlib: "lz32", importc.}
proc CopyLZFile*(P1: INT, P2: INT): LONG {.winapi, stdcall, dynlib: "lz32", importc.}
proc LZCopy*(P1: INT, P2: INT): LONG {.winapi, stdcall, dynlib: "lz32", importc.}
proc LZInit*(P1: INT): INT {.winapi, stdcall, dynlib: "lz32", importc.}
proc GetExpandedNameA*(P1: LPSTR, P2: LPSTR): INT {.winapi, stdcall, dynlib: "lz32", importc.}
proc GetExpandedNameW*(P1: LPWSTR, P2: LPWSTR): INT {.winapi, stdcall, dynlib: "lz32", importc.}
proc LZOpenFileA*(P1: LPSTR, P2: LPOFSTRUCT, P3: WORD): INT {.winapi, stdcall, dynlib: "lz32", importc.}
proc LZOpenFileW*(P1: LPWSTR, P2: LPOFSTRUCT, P3: WORD): INT {.winapi, stdcall, dynlib: "lz32", importc.}
proc LZSeek*(P1: INT, P2: LONG, P3: INT): LONG {.winapi, stdcall, dynlib: "lz32", importc.}
proc LZRead*(P1: INT, P2: LPSTR, P3: INT): INT {.winapi, stdcall, dynlib: "lz32", importc.}
proc LZClose*(P1: INT): VOID {.winapi, stdcall, dynlib: "lz32", importc.}
when winimUnicode:
  proc GetExpandedName*(P1: LPWSTR, P2: LPWSTR): INT {.winapi, stdcall, dynlib: "lz32", importc: "GetExpandedNameW".}
  proc LZOpenFile*(P1: LPWSTR, P2: LPOFSTRUCT, P3: WORD): INT {.winapi, stdcall, dynlib: "lz32", importc: "LZOpenFileW".}
when winimAnsi:
  proc GetExpandedName*(P1: LPSTR, P2: LPSTR): INT {.winapi, stdcall, dynlib: "lz32", importc: "GetExpandedNameA".}
  proc LZOpenFile*(P1: LPSTR, P2: LPOFSTRUCT, P3: WORD): INT {.winapi, stdcall, dynlib: "lz32", importc: "LZOpenFileA".}
