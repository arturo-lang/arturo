#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import macros

when not defined(noRes):
  when defined(vcc):
    {.link: "../lib/winimvcc.res".}

  elif defined(cpu64):
    {.link: "../lib/winim64.res".}

  else:
    {.link: "../lib/winim32.res".}

macro winapi*(x: untyped): untyped =
  when not defined(noDiscardableApi):
    x.addPragma(newIdentNode("discardable"))

  result = x

proc discardable*[T](x: T): T {.discardable, inline.} = x

macro DEFINE_GUID*(guid: string): untyped =
  const
    ranges = [0..7, 9..12, 14..17, 19..20, 21..22, 24..25, 26..27, 28..29, 30..31, 32..33, 34..35]
    parts = ["'i32, 0x", ", 0x", ", [0x", "'u8, 0x", ", 0x", ", 0x", ", 0x", ", 0x", ", 0x", ", 0x", "])"]

  let guid = guid.strVal
  assert guid.len == 36

  var code = "DEFINE_GUID(0x"
  for i in 0..10:
    code.add guid[ranges[i]]
    code.add parts[i]
  result = parseStmt(code)

const
  winimAnsi* = defined(useWinAnsi) or defined(winansi)
  winimUnicode* = not winimAnsi
  winimCpu64* = defined(cpu64)
  winimCpu32* = not defined(cpu64)
