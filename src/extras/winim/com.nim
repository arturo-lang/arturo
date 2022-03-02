#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#           Windows COM Object And COM Event Supports
#
#====================================================================

## This module add windows COM support to Winim.
## So that we can use Nim to interact with COM object like a script language.
## For example:
##
## .. code-block:: Nim
##    comScript:
##      var dict = CreateObject("Scripting.Dictionary")
##      dict.add("a", "the")
##      dict.add("b", item:="quick")
##      dict.add(item:="fox", key:="c")
##      dict.item(key:="c") = "dog"
##      for key in dict:
##        echo key, " => ", dict.item(key)
##
## This module introduce two new types to deal with COM objects: "com" and "variant".
## In summary, CreateObject() or GetObject() returned a "com" type value,
## and any input/ouput of COM method should be a "variant" type value.
##
## Most Nim's data type and Winim's string type can convert to/from "variant" type value.
## The conversion is usually done automatically. However, specific conversion is aslo welcome.
##
## .. code-block:: Nim
##    proc toVariant[T](x: T): variant
##    proc fromVariant[T](x: variant): T
##
##      # Supported type:
##      #   char|string|cstring|mstring|wstring|BSTR
##      #   bool|enum|SomeInteger|SomeReal
##      #   com|variant|VARIANT|ptr IUnknown|ptr IDispatch|pointer
##      #   SYSTEMTIME|FILETIME
##      #   1D~3D array|seq|COMBinary
##
## *COMBinary* type can help to deal with binary data.
## For example:
##
## .. code-block:: Nim
##    var input = "binary\0string\0test\0"
##    var v = toVariant(COMBinary input)
##    var output = string fromVariant[COMBinary](v)
##    assert input == output

{.experimental, deadCodeElim: on.} # experimental for dot operators

import strutils, macros
import inc/winimbase, utils, winstr, core, shell, ole
export winimbase, utils, winstr, core, shell, ole

when defined(notrace) or defined(gcDestructors):
  const hasTraceTable = false
else:
  const hasTraceTable = true

type
  COMError* = object of CatchableError
    hresult*: HRESULT
  COMException* = object of COMError
  VariantConversionError* = object of ValueError
  SomeFloat = float | float32 | float64 # SomeReal is deprecated in devel

template notNil[T](x: T): bool =
  when T is BSTR: not cast[pointer](x).isNil
  else: not x.isNil

proc free(x: pointer) =
  if not x.isNil:
    system.dealloc(x)

converter voidpp_converter(x: ptr ptr object): ptr pointer = cast[ptr pointer](x)
converter vartype_converter(x: VARENUM): VARTYPE = VARTYPE x

# make these const store in global scope to avoid repeat init in every proc
discard &IID_NULL
discard &IID_IEnumVARIANT
discard &IID_IClassFactory
discard &IID_IDispatch
discard &IID_ITypeInfo

type
  com* = ref object
    disp: ptr IDispatch

  variant* = ref object
    raw: VARIANT

  COMArray* = seq[variant]
  COMArray1D* = seq[variant]
  COMArray2D* = seq[seq[variant]]
  COMArray3D* = seq[seq[seq[variant]]]
  COMBinary* = distinct string

proc `len`*(x: COMBinary): int {.borrow.}
proc high*(s: COMBinary): int {.borrow.}
proc low*(s: COMBinary): int {.borrow.}
proc cmp*(x, y: COMBinary): int {.borrow.}
proc `==`*(x, y: COMBinary): bool {.borrow.}
proc `<=` *(x, y: COMBinary): bool {.borrow.}
proc `<` *(x, y: COMBinary): bool {.borrow.}
proc substr*(s: COMBinary, first, last: int): COMBinary {.borrow.}
proc substr*(s: COMBinary, first = 0): COMBinary {.borrow.}

when hasTraceTable:
  import tables

  var
    comTrace {.threadvar.}: TableRef[pointer, bool]
    varTrace {.threadvar.}: TableRef[pointer, bool]

var hresult {.threadvar.}: HRESULT
var isInitialized {.threadvar.}: bool

template ERR(x: HRESULT): bool =
  hresult = x
  hresult != S_OK

template OK(x: HRESULT): bool =
  hresult = x
  hresult == S_OK

proc newCOMError(msg: string, hr: HRESULT = hresult): ref COMError =
  result = newException(COMError, msg)
  result.hresult = hr

proc newCOMException(msg: string, hr: HRESULT = hresult): ref COMException =
  result = newException(COMException, msg)
  result.hresult = hr

proc getCurrentCOMError*(): ref COMError {.inline.} =
  result = (ref COMError)(getCurrentException())

proc desc*(e: ref COMError): string =
  var buffer = newWString(4096)

  FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_IGNORE_INSERTS,
               nil,
               DWORD e.hresult,
               DWORD MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
               buffer, 4096, nil)

  result = $buffer

proc `=destroy`(x: var type(com()[])) =
  if not x.disp.isNil:
    x.disp.Release()
    x.disp = nil

proc `=destroy`(x: var type(variant()[])) =
  VariantClear(&x.raw)

when not defined(gcDestructors):
  proc del*(x: com) =
    when hasTraceTable:
      comTrace.del(cast[pointer](x))

    `=destroy`(x[])

  proc del*(x: variant) =
    when hasTraceTable:
      varTrace.del(cast[pointer](x))

    `=destroy`(x[])

template init(x): untyped =
  # lazy initialize, in case of the it need different apartment or OleInitialize
  if not isInitialized:
    CoInitialize(nil)
    isInitialized = true

  when not defined(gcDestructors):
    new(x, del)
  else:
    new(x)

  when hasTraceTable:
    if comTrace.isNil: comTrace = newTable[pointer, bool]()
    if varTrace.isNil: varTrace = newTable[pointer, bool]()

    when x.type is variant:
      varTrace[cast[pointer](x)] = true

    elif x.type is com:
      comTrace[cast[pointer](x)] = true

proc COM_FullRelease*() =
  ## Clean up all COM objects and variants.
  ##
  ## Usually, we let garbage collector to release the objects.
  ## However, sometimes the garbage collector can't release all the object even we call GC_fullCollect().
  ## Some object will create a endless process in this situation. (for example: Excel.Application).
  ## So we need this function.
  ##
  ## Use -d:notrace to disable this function.
  when hasTraceTable:
    for k, v in varTrace: `=destroy`(cast[variant](k)[])
    for k, v in comTrace: `=destroy`(cast[com](k)[])
    varTrace.clear
    comTrace.clear

proc typeDesc(vt: VARTYPE, d: UINT = 0): string =
  proc typeStr(vt: VARTYPE): string =
    case vt
    of 0: "VT_EMPTY"
    of 1: "VT_NULL"
    of 2: "VT_I2"
    of 3: "VT_I4"
    of 4: "VT_R4"
    of 5: "VT_R8"
    of 6: "VT_CY"
    of 7: "VT_DATE"
    of 8: "VT_BSTR"
    of 9: "VT_DISPATCH"
    of 10: "VT_ERROR"
    of 11: "VT_BOOL"
    of 12: "VT_VARIANT"
    of 13: "VT_UNKNOWN"
    of 14: "VT_DECIMAL"
    of 16: "VT_I1"
    of 17: "VT_UI1"
    of 18: "VT_UI2"
    of 19: "VT_UI4"
    of 20: "VT_I8"
    of 21: "VT_UI8"
    of 22: "VT_INT"
    of 23: "VT_UINT"
    of 24: "VT_VOID"
    of 25: "VT_HRESULT"
    of 26: "VT_PTR"
    of 27: "VT_SAFEARRAY"
    of 28: "VT_CARRAY"
    of 29: "VT_USERDEFINED"
    of 30: "VT_LPSTR"
    of 31: "VT_LPWSTR"
    of 36: "VT_RECORD"
    of 37: "VT_INT_PTR"
    of 38: "VT_UINT_PTR"
    of 64: "VT_FILETIME"
    of 65: "VT_BLOB"
    of 66: "VT_STREAM"
    of 67: "VT_STORAGE"
    of 68: "VT_STREAMED_OBJECT"
    of 69: "VT_STORED_OBJECT"
    of 70: "VT_BLOB_OBJECT"
    of 71: "VT_CF"
    of 72: "VT_CLSID"
    of 0xfff: "VT_BSTR_BLOB"
    else: "VT_ILLEGAL"

  if vt == VT_ILLEGAL:
    result = "VT_ILLEGAL"
  else:
    result = ""

    if (vt and VT_VECTOR) != 0: result &= "VT_VECTOR|"
    if (vt and VT_BYREF) != 0: result &= "VT_BYREF|"
    if (vt and VT_RESERVED) != 0: result &= "VT_RESERVED|"
    if (vt and VT_ARRAY) != 0:
      if d != 0: result &= "VT_ARRAY(" & $d & "D)|"
      else: result &= "VT_ARRAY|"

    result &= typeStr(vt and 0xfff)

proc vcErrorMsg(f: string, t: string = ""): string =
  "convert from " & f & " to " & (if t.len == 0: f else: t)

proc rawType*(x: variant): VARTYPE {.inline.} =
  result = x.raw.vt

proc rawTypeDesc*(x: variant): string =
  var dimensions: UINT = 0
  if (x.raw.vt and VT_ARRAY) != 0:
    dimensions = SafeArrayGetDim(x.raw.parray)

  result = x.raw.vt.typeDesc(dimensions)

proc newCom*(x: ptr IDispatch): com =
  if x.notNil:
    result.init
    x.AddRef()
    result.disp = x

proc copy*(x: com): com {.inline.} =
  if x.notNil:
    result = newCom(x.disp)

proc wrap*(x: ptr IDispatch): com {.inline.} =
  result = newCom(x)

proc wrap*(x: VARIANT): variant {.inline.} =
  result.init
  result.raw = x

proc unwrap*(x: com): ptr IDispatch {.inline.} =
  result = x.disp

proc unwrap*(x: variant): VARIANT {.inline.} =
  result = x.raw

proc isNull*(x: variant): bool {.inline.} =
  result = (x.raw.vt == VT_EMPTY or x.raw.vt == VT_NULL or (x.raw.vt == VT_DISPATCH and x.raw.byref.isNil))

proc newVariant*(x: VARIANT): variant =
  result.init
  if VariantCopy(&result.raw, x.unsafeaddr).FAILED:
    raise newException(VariantConversionError, vcErrorMsg(x.vt.typeDesc))

proc copy*(x: variant): variant =
  if x.notNil:
    result.init
    if VariantCopy(&result.raw, x.raw.unsafeaddr).FAILED:
      raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc))

proc toVariant*(x: string|cstring|mstring): variant =
  result.init
  result.raw.vt = VT_BSTR
  var ws = +$x
  result.raw.bstrVal = SysAllocString(&ws)

proc toVariant*(x: wstring): variant =
  result.init
  result.raw.vt = VT_BSTR
  result.raw.bstrVal = SysAllocString(&x)

proc toVariant*(x: BSTR): variant =
  result.init
  result.raw.vt = VT_BSTR
  result.raw.bstrVal = SysAllocString(x)

proc toVariant*(x: bool): variant =
  result.init
  result.raw.vt = VT_BOOL
  result.raw.boolVal = if x: VARIANT_TRUE else: VARIANT_FALSE

proc toVariant*(x: SomeInteger|enum): variant =
  result.init
  when x.type is SomeSignedInt:
    when sizeof(x) == 1:
      result.raw.vt = VT_I1
      result.raw.bVal = cast[uint8](x)
    elif sizeof(x) == 2:
      result.raw.vt = VT_I2
      result.raw.iVal = x.int16
    elif sizeof(x) == 4:
      result.raw.vt = VT_I4
      result.raw.lVal = x.int32
    else:
      result.raw.vt = VT_I8
      result.raw.llVal = x.int64
  else:
    when sizeof(x) == 1:
      result.raw.vt = VT_UI1
      result.raw.bVal = x.uint8
    elif sizeof(x) == 2:
      result.raw.vt = VT_UI2
      result.raw.uiVal = x.uint16
    elif sizeof(x) == 4:
      result.raw.vt = VT_UI4
      result.raw.ulVal = x.int32 # ULONG is declared as int32 for compatibility
    else:
      result.raw.vt = VT_UI8
      result.raw.ullVal = x.int64 # ULONG64 is declared as int64 for compatibility

proc toVariant*(x: SomeFloat): variant =
  result.init
  when sizeof(x) == 4:
    result.raw.vt = VT_R4
    result.raw.fltVal = x.float32
  else:
    result.raw.vt = VT_R8
    result.raw.dblVal = x.float64

proc toVariant*(x: char): variant =
  result.init
  result.raw.vt = VT_UI1
  result.raw.bVal = x.byte

proc toVariant*(x: pointer): variant =
  result.init
  result.raw.vt = VT_PTR
  result.raw.byref = x

proc toVariant*(x: ptr IDispatch): variant =
  result.init
  x.AddRef()
  result.raw.vt = VT_DISPATCH
  result.raw.pdispVal = x

proc toVariant*(x: com): variant =
  result.init
  x.disp.AddRef()
  result.raw.vt = VT_DISPATCH
  result.raw.pdispVal = x.disp

proc toVariant*(x: ptr IUnknown): variant =
  result.init
  x.AddRef()
  result.raw.vt = VT_UNKNOWN
  result.raw.punkVal = x

proc toVariant*(x: SYSTEMTIME): variant =
  # SystemTimeToVariantTime and VariantTimeToSystemTime ignored milliseconds
  # https://www.codeproject.com/Articles/17576/SystemTime-to-VariantTime-with-Milliseconds

  const ONETHOUSANDMILLISECONDS = 0.0000115740740740'f64
  var x = x
  result.init
  result.raw.vt = VT_DATE

  let wMilliSeconds = float x.wMilliseconds
  x.wMilliseconds = 0

  var date: float64
  if SystemTimeToVariantTime(&x, &date) == FALSE:
    raise newException(VariantConversionError, vcErrorMsg("SYSTEMTIME", "VT_DATE"))

  result.raw.date = date + ONETHOUSANDMILLISECONDS / 1000 * wMilliSeconds

proc toVariant*(x: FILETIME): variant =
  result.init
  result.raw.vt = VT_DATE

  var st: SYSTEMTIME
  var date: float64
  if FileTimeToSystemTime(x.unsafeaddr, &st) == FALSE or SystemTimeToVariantTime(&st, &date) == FALSE:
    raise newException(VariantConversionError, vcErrorMsg("FILETIME", "VT_DATE"))

  result.raw.date = date

proc toVariant*(x: ptr SomeInteger|ptr SomeFloat|ptr char|ptr bool|ptr BSTR): variant =
  result = toVariant(x[])
  result.raw.byref = cast[pointer](x)
  result.raw.vt = result.raw.vt or VT_BYREF

proc toVariant*(x: VARIANT): variant =
  result.init
  if VariantCopy(&result.raw, x.unsafeaddr).FAILED:
    raise newException(VariantConversionError, vcErrorMsg(x.vt.typeDesc))

proc toVariant*(x: variant): variant =
  result.init
  if x.isNil: # nil.variant for missing optional parameters
    result.raw.vt = VT_ERROR
    result.raw.scode = DISP_E_PARAMNOTFOUND
  else:
    result = x.copy

proc toVariant*(x: COMBinary): variant =
  result.init
  result.raw.vt = VARTYPE(VT_ARRAY or VT_UI1)
  result.raw.parray = SafeArrayCreateVector(VT_UI1, 0, ULONG len(string x))

  block:
    var pBuffer: pointer
    if result.raw.parray == nil: break
    if SafeArrayAccessData(result.raw.parray, &pBuffer) != S_OK: break
    defer: SafeArrayUnaccessData(result.raw.parray)

    copyMem(pBuffer, &(string x), x.len)
    return

  raise newException(VariantConversionError, vcErrorMsg("COMBinary", VARTYPE(VT_ARRAY or VT_UI1).typeDesc(1)))

template toVariant1D(x: typed, vt: VARENUM) =
  var sab: array[1, SAFEARRAYBOUND]
  sab[0].cElements = x.len.ULONG
  result.raw.parray = SafeArrayCreate(VARTYPE vt, 1, &sab[0])
  if result.raw.parray == nil:
    raise newException(VariantConversionError, vcErrorMsg("openarray", VARTYPE(vt or VT_ARRAY).typeDesc(1)))

  for i in 0..<x.len:
    var
      v = toVariant(x[i])
      indices = i.LONG

    if vt == VT_VARIANT:
      discard SafeArrayPutElement(result.raw.parray, &indices, &(v.raw))
    elif vt == VT_DISPATCH or vt == VT_UNKNOWN or vt == VT_BSTR:
      discard SafeArrayPutElement(result.raw.parray, &indices, (v.raw.union1.struct1.union1.byref))
    else:
      discard SafeArrayPutElement(result.raw.parray, &indices, &(v.raw.union1.struct1.union1.intVal))

template toVariant2D(x: typed, vt: VARENUM) =
  var sab: array[2, SAFEARRAYBOUND]
  sab[0].cElements = x.len.ULONG

  for i in 0..<x.len:
    if x[i].len.ULONG > sab[1].cElements: sab[1].cElements = x[i].len.ULONG

  result.raw.parray = SafeArrayCreate(VARTYPE vt, 2, &sab[0])
  if result.raw.parray == nil:
    raise newException(VariantConversionError, vcErrorMsg("openarray", VARTYPE(vt or VT_ARRAY).typeDesc(2)))

  for i in 0..<x.len:
    for j in 0..<x[i].len:
      var
        v = toVariant(x[i][j])
        indices = [i.LONG, j.LONG]

      if vt == VT_VARIANT:
        discard SafeArrayPutElement(result.raw.parray, &indices[0], &(v.raw))
      elif vt == VT_DISPATCH or vt == VT_UNKNOWN or vt == VT_BSTR:
        discard SafeArrayPutElement(result.raw.parray, &indices[0], (v.raw.union1.struct1.union1.byref))
      else:
        discard SafeArrayPutElement(result.raw.parray, &indices[0], &(v.raw.union1.struct1.union1.intVal))

template toVariant3D(x: typed, vt: VARENUM) =
  var sab: array[3, SAFEARRAYBOUND]
  sab[0].cElements = x.len.ULONG

  for i in 0..<x.len:
    if x[i].len.ULONG > sab[1].cElements: sab[1].cElements = x[i].len.ULONG
    for j in 0..<x[i].len:
      if x[i][j].len.ULONG > sab[2].cElements: sab[2].cElements = x[i][j].len.ULONG

  result.raw.parray = SafeArrayCreate(VARTYPE vt, 3, &sab[0])
  if result.raw.parray == nil:
    raise newException(VariantConversionError, vcErrorMsg("openarray", VARTYPE(vt or VT_ARRAY).typeDesc(3)))

  for i in 0..<x.len:
    for j in 0..<x[i].len:
      for k in 0..<x[i][j].len:
        var
          v = toVariant(x[i][j][k])
          indices = [i.LONG, j.LONG, k.LONG]

        if vt == VT_VARIANT:
          discard SafeArrayPutElement(result.raw.parray, &indices[0], &(v.raw))
        elif vt == VT_DISPATCH or vt == VT_UNKNOWN or vt == VT_BSTR:
          discard SafeArrayPutElement(result.raw.parray, &indices[0], (v.raw.union1.struct1.union1.byref))
        else:
          discard SafeArrayPutElement(result.raw.parray, &indices[0], &(v.raw.union1.struct1.union1.intVal))

proc toVariant*[T](x: openarray[T], vt: VARENUM = VT_VARIANT): variant =
  result.init
  result.raw.vt = VARTYPE(VT_ARRAY or vt)

  when x[0].type is array|seq:
    when x[0][0].type is array|seq:
      when x[0][0][0].type is array|seq:
        raise newException(VariantConversionError, vcErrorMsg("openarray", VARTYPE(vt or VT_ARRAY).typeDesc(4)))
      else:
        toVariant3D(x, vt)
    else:
      toVariant2D(x, vt)
  else:
    toVariant1D(x, vt)

template fromVariant1D(x, dimensions: typed) =
  var
    vt: VARTYPE
    xUbound, xLbound: LONG

  if SafeArrayGetVartype(x.raw.parray, &vt) == S_OK and dimensions == 1 and
    SafeArrayGetLBound(x.raw.parray, 1, &xLbound) == S_OK and
    SafeArrayGetUBound(x.raw.parray, 1, &xUbound) == S_OK:

    var xLen = xUbound - xLbound + 1
    newSeq(result, xLen)
    for i in 0..<xLen:
      var indices = i.LONG + xLbound
      result[i].init
      if vt == VT_VARIANT:
        discard SafeArrayGetElement(x.raw.parray, &indices, &result[i].raw)
      else:
        result[i].raw.vt = vt
        discard SafeArrayGetElement(x.raw.parray, &indices, &result[i].raw.union1.struct1.union1.intVal)

  else:
    raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc(dimensions), "COMArray1D"))

template fromVariant2D(x, dimensions: typed) =
  var
    vt: VARTYPE
    xUbound, xLbound: LONG
    yUbound, yLbound: LONG

  if SafeArrayGetVartype(x.raw.parray, &vt) == S_OK and dimensions == 2 and
    SafeArrayGetLBound(x.raw.parray, 1, &xLbound) == S_OK and
    SafeArrayGetUBound(x.raw.parray, 1, &xUbound) == S_OK and
    SafeArrayGetLBound(x.raw.parray, 2, &yLbound) == S_OK and
    SafeArrayGetUBound(x.raw.parray, 2, &yUbound) == S_OK:

    var
      xLen = xUbound - xLbound + 1
      yLen = yUbound - yLbound + 1

    newSeq(result, xLen)
    for i in 0..<xLen:
      newSeq(result[i], yLen)
      for j in 0..<yLen:
        var indices = [i.LONG + xLbound, j.LONG + yLbound]
        result[i][j].init
        if vt == VT_VARIANT:
          discard SafeArrayGetElement(x.raw.parray, &indices[0], &result[i][j].raw)
        else:
          result[i][j].raw.vt = vt
          discard SafeArrayGetElement(x.raw.parray, &indices[0], &result[i][j].raw.union1.struct1.union1.intVal)

  else:
    raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc(dimensions), "COMArray2D"))

template fromVariant3D(x, dimensions: typed) =
  var
    vt: VARTYPE
    xUbound, xLbound: LONG
    yUbound, yLbound: LONG
    zUbound, zLbound: LONG

  if SafeArrayGetVartype(x.raw.parray, &vt) == S_OK and dimensions == 3 and
    SafeArrayGetLBound(x.raw.parray, 1, &xLbound) == S_OK and
    SafeArrayGetUBound(x.raw.parray, 1, &xUbound) == S_OK and
    SafeArrayGetLBound(x.raw.parray, 2, &yLbound) == S_OK and
    SafeArrayGetUBound(x.raw.parray, 2, &yUbound) == S_OK and
    SafeArrayGetLBound(x.raw.parray, 3, &zLbound) == S_OK and
    SafeArrayGetUBound(x.raw.parray, 3, &zUbound) == S_OK:

    var
      xLen = xUbound - xLbound + 1
      yLen = yUbound - yLbound + 1
      zLen = zUbound - zLbound + 1

    newSeq(result, xLen)
    for i in 0..<xLen:
      newSeq(result[i], yLen)
      for j in 0..<yLen:
        newSeq(result[i][j], zLen)
        for k in 0..<zLen:
          var indices = [i.LONG + xLbound, j.LONG + yLbound, k.LONG + zLbound]
          result[i][j][k].init
          if vt == VT_VARIANT:
            discard SafeArrayGetElement(x.raw.parray, &indices[0], &result[i][j][k].raw)
          else:
            result[i][j][k].raw.vt = vt
            discard SafeArrayGetElement(x.raw.parray, &indices[0], &result[i][j][k].raw.union1.struct1.union1.intVal)

  else:
    raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc(dimensions), "COMArray3D"))

template fromVariantBinary(x: typed) =
  var
    vt: VARTYPE
    xUbound, xLbound: LONG
    pBuffer: pointer
    ok = false

  block:
    if dimensions != 1: break
    if SafeArrayGetVartype(x.raw.parray, &vt) != S_OK or vt notin {VT_UI1, VT_I1}: break
    if SafeArrayGetLBound(x.raw.parray, 1, &xLbound) != S_OK: break
    if SafeArrayGetUBound(x.raw.parray, 1, &xUbound) != S_OK: break
    if SafeArrayAccessData(x.raw.parray, &pBuffer) != S_OK: break
    defer: SafeArrayUnaccessData(x.raw.parray)

    let xLen = xUbound - xLbound + 1
    result = COMBinary newString(xLen)
    copyMem(&(string result), pBuffer, xLen)
    ok = true

  if not ok:
    raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc(dimensions), "COMBinary"))

proc fromVariant*[T](x: variant): T =
  if x.isNil: return

  when T is VARIANT:
    result = x.raw

  else:
    const VT_BYREF_VARIANT = VT_BYREF or VT_VARIANT
    if (x.raw.vt and VT_BYREF_VARIANT) == VT_BYREF_VARIANT:
      var v: VARIANT = x.raw.pvarVal[]
      return fromVariant[T](newVariant(v))

    var dimensions: UINT = 0
    if (x.raw.vt and VT_ARRAY) != 0:
      dimensions = SafeArrayGetDim(x.raw.parray)

    when T is COMArray1D: fromVariant1D(x, dimensions)
    elif T is COMArray2D: fromVariant2D(x, dimensions)
    elif T is COMArray3D: fromVariant3D(x, dimensions)
    elif T is COMBinary: fromVariantBinary(x)
    elif T is ptr and not (T is ptr IDispatch) and not (T is ptr IUnknown):
      if (x.raw.vt and VT_BYREF) != 0:
        result = cast[T](x.raw.byref)

      else:
        raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc, "unsupported type"))

    else:
      var
        ret: VARIANT
        targetVt: VARENUM
        targetName: string

      when T is string:         targetVt = VT_BSTR;     targetName = "string"
      elif T is cstring:        targetVt = VT_BSTR;     targetName = "cstring"
      elif T is mstring:        targetVt = VT_BSTR;     targetName = "mstring"
      elif T is wstring:        targetVt = VT_BSTR;     targetName = "wstring"
      elif T is BSTR:           targetVt = VT_BSTR;     targetName = "BSTR"
      elif T is char:           targetVt = VT_UI1;      targetName = "char"
      elif T is SomeInteger:    targetVt = VT_I8;       targetName = "integer"
      elif T is SomeFloat:      targetVt = VT_R8;       targetName = "float"
      elif T is bool:           targetVt = VT_BOOL;     targetName = "bool"
      elif T is com:            targetVt = VT_DISPATCH; targetName = "com object"
      elif T is ptr IDispatch:  targetVt = VT_DISPATCH; targetName = "ptr IDispatch"
      elif T is ptr IUnknown:   targetVt = VT_UNKNOWN;  targetName = "ptr IUnknown"
      elif T is pointer:        targetVt = VT_PTR;      targetName = "pointer"
      elif T is FILETIME:       targetVt = VT_DATE;     targetName = "FILETIME"
      elif T is SYSTEMTIME:     targetVt = VT_DATE;     targetName = "SYSTEMTIME"
      else: {.fatal: "trying to do unsupported type conversion.".}

      var
        hr: HRESULT
        needClear: bool

      if x.raw.vt == targetVt:
        hr = S_OK
        needClear = false
        ret = x.raw
      elif x.raw.vt == VT_NULL and targetVt == VT_BSTR:
        # convert VT_NULL to empty string
        hr = S_OK
        needClear = true
        ret.vt = VT_BSTR
        ret.bstrVal = SysAllocString("")
      else:
        hr = VariantChangeType(&ret, x.raw.unsafeaddr, 16, targetVt)
        needClear = true

      defer:
        if needClear: discard VariantClear(&ret)

      if hr.FAILED:
        raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc(dimensions), targetName))

      when T is string:
        result = $ret.bstrVal

      elif T is cstring:
        result = cstring($ret.bstrVal)

      elif T is mstring:
        result = -$ret.bstrVal

      elif T is wstring:
        result = +$ret.bstrVal

      elif T is SYSTEMTIME:
        # SystemTimeToVariantTime and VariantTimeToSystemTime ignored milliseconds
        # https://www.codeproject.com/Articles/17576/SystemTime-to-VariantTime-with-Milliseconds

        const ONETHOUSANDMILLISECONDS = 0.0000115740740740'F64
        let halfSecond = ONETHOUSANDMILLISECONDS / 2.0
        if VariantTimeToSystemTime(ret.date - halfSecond, &result) == FALSE:
          raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc(dimensions), targetName))

        var
          fraction = ret.date - ret.date.int.float64
          hours = (fraction - fraction.int.float64) * 24
          minutes = (hours - hours.int.float64) * 60
          seconds = (minutes - minutes.int.float64) * 60
          milliseconds = (seconds - seconds.int.float64) * 1000 + 0.5

        if milliseconds < 1.0 or milliseconds > 999.0:
          milliseconds = 0

        if milliseconds != 0:
          result.wMilliseconds = WORD milliseconds
        else:
          if VariantTimeToSystemTime(ret.date, &result) == FALSE:
            raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc(dimensions), targetName))

      elif T is FILETIME:
        var st: SYSTEMTIME
        if VariantTimeToSystemTime(ret.date, &st) == FALSE or SystemTimeToFileTime(&st, &result) == FALSE:
          raise newException(VariantConversionError, vcErrorMsg(x.raw.vt.typeDesc(dimensions), targetName))

      elif T is com:
        result = newCom(ret.pdispVal)

      elif T is ptr IDispatch:
        ret.pdispVal.AddRef()
        result = ret.pdispVal

      elif T is ptr IUnknown:
        ret.punkVal.AddRef()
        result = ret.punkVal

      elif T is pointer:
        result = ret.byref

      elif T is SomeInteger:  result = cast[T](ret.llVal)
      elif T is SomeFloat:    result = T(ret.dblVal)
      elif T is char:         result = char(ret.bVal)
      elif T is bool:         result = if ret.boolVal != 0: true else: false

proc `$`*(x: variant): string {.inline.} = fromVariant[string](x)
converter variantConverterToString*(x: variant): string = fromVariant[string](x)
converter variantConverterToCString*(x: variant): cstring = fromVariant[cstring](x)
converter variantConverterToMString*(x: variant): mstring = fromVariant[mstring](x)
converter variantConverterToWString*(x: variant): wstring = fromVariant[wstring](x)
converter variantConverterToChar*(x: variant): char = fromVariant[char](x)
converter variantConverterToBool*(x: variant): bool = fromVariant[bool](x)
converter variantConverterToCom*(x: variant): com = fromVariant[com](x)
converter variantConverterToIDispatch*(x: variant): ptr IDispatch = fromVariant[ptr IDispatch](x)
converter variantConverterToIUnknown*(x: variant): ptr IUnknown = fromVariant[ptr IUnknown](x)
converter variantConverterToPointer*(x: variant): pointer = fromVariant[pointer](x)
converter variantConverterToInt*(x: variant): int = fromVariant[int](x)
converter variantConverterToUInt*(x: variant): uint = fromVariant[uint](x)
converter variantConverterToInt8*(x: variant): int8 = fromVariant[int8](x)
converter variantConverterToUInt8*(x: variant): uint8 = fromVariant[uint8](x)
converter variantConverterToInt16*(x: variant): int16 = fromVariant[int16](x)
converter variantConverterToUInt16*(x: variant): uint16 = fromVariant[uint16](x)
converter variantConverterToInt32*(x: variant): int32 = fromVariant[int32](x)
converter variantConverterToUInt32*(x: variant): uint32 = fromVariant[uint32](x)
converter variantConverterToInt64*(x: variant): int64 = fromVariant[int64](x)
converter variantConverterToUInt64*(x: variant): uint64 = fromVariant[uint64](x)
converter variantConverterToFloat32*(x: variant): float32 = fromVariant[float32](x)
converter variantConverterToFloat64*(x: variant): float64 = fromVariant[float64](x)
converter variantConverterToFILETIME*(x: variant): FILETIME = fromVariant[FILETIME](x)
converter variantConverterToSYSTEMTIME*(x: variant): SYSTEMTIME = fromVariant[SYSTEMTIME](x)
converter variantConverterToVARIANT*(x: variant): VARIANT = fromVariant[VARIANT](x)
converter variantConverterToCOMArray1D*(x: variant): COMArray1D = fromVariant[COMArray1D](x)
converter variantConverterToCOMArray2D*(x: variant): COMArray2D = fromVariant[COMArray2D](x)
converter variantConverterToCOMArray3D*(x: variant): COMArray3D = fromVariant[COMArray3D](x)
converter variantConverterToCOMBinary*(x: variant): COMBinary = fromVariant[COMBinary](x)

proc getEnumeration(self: com, name: string): variant =
  var
    tinfo: ptr ITypeInfo
    tlib: ptr ITypeLib
    index: UINT
    kind: TYPEKIND
    bname: BSTR

  if self.disp.GetTypeInfo(0, 0, &tinfo).ERR: return
  defer: tinfo.Release()

  if tinfo.GetContainingTypeLib(&tlib, &index).ERR: return
  defer: tlib.Release()

  for i in 0..<tlib.GetTypeInfoCount():
    if tlib.GetTypeInfoType(UINT i, &kind).ERR: continue
    if kind != TKIND_ENUM: continue
    if tlib.GetDocumentation(UINT i, &bname, nil, nil, nil).ERR: continue
    defer: SysFreeString(bname)

    if name.cmpIgnoreCase($bname) == 0:
      var tinfoEnum: ptr ITypeInfo
      if tlib.GetTypeInfo(UINT i, &tinfoEnum).OK:
        defer: tinfoEnum.Release()

        # save ITypeInfo into variant as IUnknown
        return toVariant((ptr IUnknown)(tinfoEnum))

proc getVariantTypeInfo(x: variant): ptr ITypeInfo =
  if x.raw.vt == VT_UNKNOWN and x.raw.punkVal.QueryInterface(&IID_ITypeInfo, &result).OK:
    return result
  else:
    return nil

iterator items(tinfo: ptr ITypeInfo, keyOnly=true): tuple[key: string, value: variant] =
  var
    attr: ptr TYPEATTR
    desc: ptr VARDESC
    name: BSTR
    nameCount: UINT

  if tinfo.GetTypeAttr(&attr).OK:
    defer: tinfo.ReleaseTypeAttr(attr)

    for i in 0..<int attr.cVars:
      if tinfo.GetVarDesc(UINT i, &desc).OK:
        defer: tinfo.ReleaseVarDesc(desc)

        if desc.varkind == VAR_CONST:
          if tinfo.GetNames(desc.memid, &name, 1, &nameCount).OK:
            defer: SysFreeString(name)
            if keyOnly:
              yield ($name, nil)
            else:
              yield ($name, toVariant(desc[].lpvarValue[]))

proc getValue(tinfo: ptr ITypeInfo, name: string): variant =
  for tup in tinfo.items(keyOnly=false):
    if tup.key == name:
      return tup.value

  raise newCOMError("constant not found: " & name)

proc desc*(self: com, name: string): string =
  ## Gets the description (include name and arguments) for the specified method.
  var
    dispid: DISPID
    wstr = +$name
    pwstr = &wstr
    tinfo: ptr ITypeInfo
    count: UINT
    names: array[128, BSTR]

  if self.disp.GetIDsOfNames(&IID_NULL, &pwstr, 1, LOCALE_USER_DEFAULT, &dispid).ERR:
    raise newCOMError("unsupported method: " & name)

  if self.disp.GetTypeInfo(0, 0, &tinfo).ERR: raise newCOMError("named arguments not allowed")
  defer: tinfo.Release()

  if tinfo.GetNames(dispid, &names[0], 128, &count).ERR: raise newCOMError("named arguments not allowed")
  defer:
    for i in 0..<count:
      SysFreeString(names[i])

  result = $names[0] & "("
  for i in 1..<count:
    result.add $names[i]
    result.add ", "
  result.removeSuffix ", "
  result.add ")"

proc invoke(self: com, name: string, invokeType: WORD, vargs: varargs[variant, toVariant],
    kwargs: openarray[(string, variant)] = []): variant =

  var
    isSet = (invokeType and (DISPATCH_PROPERTYPUT or DISPATCH_PROPERTYPUTREF)) != 0
    dispid: DISPID
    wstr = +$name
    pwstr = &wstr
    args: seq[VARIANT]

  if self.disp.GetIDsOfNames(&IID_NULL, &pwstr, 1, LOCALE_USER_DEFAULT, &dispid).ERR:
    # if the method name is not recognized, maybe it is an enum name
    result = getEnumeration(self, name)
    if not result.isNil: return

    raise newCOMError("unsupported method: " & name)

  if kwargs.len != 0:
    var
      tinfo: ptr ITypeInfo
      count: UINT
      names: array[128, BSTR]

    if self.disp.GetTypeInfo(0, 0, &tinfo).ERR: raise newCOMError("named arguments not allowed")
    defer: tinfo.Release()

    if tinfo.GetNames(dispid, &names[0], 128, &count).ERR: raise newCOMError("named arguments not allowed")
    defer:
      for i in 0..<count:
        SysFreeString(names[i])

    # names[0] is method name, names[1] is first argument's name, ...
    args.setLen(count - (if isSet: 0 else: 1))

    for _, tup in kwargs:
      var found = false
      for i in 1..<count:
        if tup[0].cmpIgnoreCase($names[i]) == 0:
          args[args.high - (i - 1)] = tup[1].raw # reverse order
          found = true
          break

      if not found:
        raise newCOMError($names[0] & "() got an unexpected argument: " & tup[0])

  if args.len == 0:
    args.setLen(vargs.len)

  var index = 0
  for i in countdown(args.high, 0): # reverse order
    if index >= vargs.len: break
    if args[i].vt == VT_EMPTY:
      args[i] = vargs[index].raw
      index.inc

  var
    dp: DISPPARAMS
    dispidNamed: DISPID = DISPID_PROPERTYPUT
    ret: VARIANT
    excep: EXCEPINFO
    skipArgs = 0

  if args.len != 0:
    for i in 0..args.high:
      if args[i].vt == VT_EMPTY: skipArgs.inc
      else: break

    dp.rgvarg = &args[skipArgs]
    dp.cArgs = DWORD(args.len - skipArgs)

    if isSet:
      dp.rgdispidNamedArgs = &dispidNamed
      dp.cNamedArgs = 1

  if self.disp.Invoke(dispid, &IID_NULL, LOCALE_USER_DEFAULT, invokeType, &dp, &ret, &excep, nil).ERR:
    {.gcsafe.}:
      if cast[pointer](excep.pfnDeferredFillIn).notNil:
        discard excep.pfnDeferredFillIn(&excep)

    if excep.bstrSource.notNil:
      var err = $toVariant(excep.bstrSource)
      if excep.bstrDescription.notNil: err &= ": " & $toVariant(excep.bstrDescription)
      SysFreeString(excep.bstrSource)
      SysFreeString(excep.bstrDescription)
      SysFreeString(excep.bstrHelpFile)
      raise newCOMException(err)

    raise newCOMError("invoke method failed: " & name)

  result = newVariant(ret)
  discard VariantClear(&ret)

proc call*(self: com, name: string, vargs: varargs[variant, toVariant],
    kwargs: openarray[(string, variant)] = []): variant {.discardable, inline.} =
  result = invoke(self, name, DISPATCH_METHOD, vargs, kwargs=kwargs)

proc call*(self: com, name: string, vargs: varargs[variant, toVariant]): variant {.discardable, inline.} =
  result = invoke(self, name, DISPATCH_METHOD, vargs, kwargs=[])

proc set*(self: com, name: string, vargs: varargs[variant, toVariant],
    kwargs: openarray[(string, variant)]): variant {.discardable, inline.} =
  result = invoke(self, name, DISPATCH_PROPERTYPUT, vargs, kwargs=kwargs)

proc set*(self: com, name: string, vargs: varargs[variant, toVariant]): variant {.discardable, inline.} =
  result = invoke(self, name, DISPATCH_PROPERTYPUT, vargs, kwargs=[])

proc setRef*(self: com, name: string, vargs: varargs[variant, toVariant],
    kwargs: openarray[(string, variant)]): variant {.discardable, inline.} =
  result = invoke(self, name, DISPATCH_PROPERTYPUTREF, vargs, kwargs=kwargs)

proc setRef*(self: com, name: string, vargs: varargs[variant, toVariant]): variant {.discardable, inline.} =
  result = invoke(self, name, DISPATCH_PROPERTYPUTREF, vargs, kwargs=[])

proc get*(self: com, name: string, vargs: varargs[variant, toVariant],
    kwargs: openarray[(string, variant)]): variant {.discardable, inline.} =
  result = invoke(self, name, DISPATCH_METHOD or DISPATCH_PROPERTYGET, vargs, kwargs=kwargs)

proc get*(self: com, name: string, vargs: varargs[variant, toVariant]): variant {.discardable, inline.} =
  result = invoke(self, name, DISPATCH_METHOD or DISPATCH_PROPERTYGET, vargs, kwargs=[])

proc `[]`*(self: variant, name: string): variant =
  var tinfo = self.getVariantTypeInfo()
  if tinfo.notNil:
    defer: tinfo.Release()
    return tinfo.getValue(name)

  else:
    return invoke(self, name, DISPATCH_METHOD or DISPATCH_PROPERTYGET)

template `[]`*(self: com, name: string): variant =
  discardable invoke(self, name, DISPATCH_METHOD or DISPATCH_PROPERTYGET)

template `[]=`*(self: com, name: string, v: untyped) =
  discardable invoke(self, name, DISPATCH_PROPERTYPUT, toVariant(v))

template `.`*(self: variant, name: untyped): variant =
  discardable `[]`(self, astToStr(name))

iterator items*(x: com): variant =
  var
    ret, item: VARIANT
    dp: DISPPARAMS
    enumvar: ptr IEnumVARIANT

  if x.disp.Invoke(DISPID_NEWENUM, &IID_NULL, LOCALE_USER_DEFAULT, DISPATCH_METHOD or DISPATCH_PROPERTYGET, &dp, &ret, nil, nil).ERR:
    raise newCOMError("object is not iterable")

  if ret.punkVal.QueryInterface(&IID_IEnumVARIANT, &enumvar).ERR:
    raise newCOMError("object is not iterable")

  while enumvar.Next(1, &item, nil) == 0:
    yield newVariant(item)
    discard VariantClear(&item)

  enumvar.Release()
  ret.punkVal.Release()

iterator items*(x: variant): variant =
  if not x.isNil:
    var tinfo = x.getVariantTypeInfo()
    if tinfo.notNil:
      defer: tinfo.Release()
      for tup in tinfo.items(keyOnly=true):
        yield toVariant(tup.key)

    else:
      var obj = x.com
      for v in obj:
        yield v

proc standardizeKwargs(n: var NimNode) =
  # if last argument is table constructor, name it as kwargs
  if n[^1].kind == nnkTableConstr:
    n[^1] = newTree(nnkExprEqExpr, ident("kwargs"), n[^1])

  # if last argument is already named kwargs, just do nothing
  elif n[^1].kind == nnkExprEqExpr and n[^1][0].eqIdent("kwargs") and
      n[^1][1].kind == nnkTableConstr:
    return

  # otherwise, add empty array as kwargs
  else:
    n.add newTree(nnkExprEqExpr, ident("kwargs"), newNimNode(nnkBracket))

macro `.`*(self: com, name: untyped, vargs: varargs[untyped]): untyped =
  result = newCall("get", self, newStrLitNode($name))
  for i in vargs: result.add i
  result.standardizeKwargs()

macro `.=`*(self: com, name: untyped, vargs: varargs[untyped]): untyped =
  result = newCall("set", self, newStrLitNode($name))
  for i in vargs: result.add i
  result.standardizeKwargs()

proc GetCLSID(progId: string, clsid: var GUID): HRESULT =
  if progId[0] == '{':
    result = CLSIDFromString(progId, &clsid)
  else:
    result = CLSIDFromProgID(progId, &clsid)

proc CreateObject*(progId: string): com =
  ## Creates a reference to a COM object.

  result.init
  var
    clsid: GUID
    pCf: ptr IClassFactory

  if GetCLSID(progId, clsid).OK:
    # better than CoCreateInstance:
    # some IClassFactory.CreateInstance return SUCCEEDED with nil pointer, this crash CoCreateInstance
    # for example: {D5F7E36B-5B38-445D-A50F-439B8FCBB87A}
    if CoGetClassObject(&clsid, CLSCTX_LOCAL_SERVER or CLSCTX_INPROC_SERVER, nil, &IID_IClassFactory, &pCf).OK:
      defer: pCf.Release()

      if pCf.CreateInstance(nil, &IID_IDispatch, &(result.disp)).OK and result.disp.notNil:
        return result

  raise newCOMError("unable to create object from " & progId)

proc GetObject*(file: string, progId: string = ""): com =
  ## Retrieves a reference to a COM object from an existing process or filename.

  result.init
  var
    clsid: GUID
    pUk: ptr IUnknown
    pPf: ptr IPersistFile

  if progId.len != 0:
    if GetCLSID(progId, clsid).OK:
      if file.len != 0:
        if CoCreateInstance(&clsid, nil, CLSCTX_LOCAL_SERVER or CLSCTX_INPROC_SERVER, &IID_IPersistFile, &pPf).OK:
          defer: pPf.Release()

          if pPf.Load(file, 0).OK and pPf.QueryInterface(&IID_IDispatch, &(result.disp)).OK:
            return result
      else:
        if GetActiveObject(&clsid, nil, &pUk).OK:
          defer: pUk.Release()

          if pUk.QueryInterface(&IID_IDispatch, &(result.disp)).OK:
            return result

  elif file.len != 0:
    if CoGetObject(file, nil, &IID_IDispatch, &(result.disp)).OK:
      return result

  raise newCOMError("unable to get object")

proc newCom*(progId: string): com {.inline.} =
  result = CreateObject(progId)

proc newCom*(file, progId: string): com {.inline.} =
  result = GetObject(file, progId)

type
  comEventHandler* = proc(self: com, name: string, params: varargs[variant]): variant
  SinkObj {.pure.} = object
    lpVtbl: ptr IDispatchVtbl
    typeInfo: ptr ITypeInfo
    iid: GUID
    refCount: ULONG
    handler: comEventHandler
    parent: com
  Sink {.pure.} = ptr SinkObj

proc Sink_QueryInterface(self: ptr IUnknown, riid: ptr IID, pvObject: ptr pointer): HRESULT {.stdcall.} =
  var this = cast[Sink](self)
  if IsEqualGUID(riid, &IID_IUnknown) or IsEqualGUID(riid, &IID_IDispatch) or IsEqualGUID(riid, &this.iid):
    pvObject[] = self
    self.AddRef()
    result = S_OK
  else:
    pvObject[] = nil
    result = E_NOINTERFACE

proc Sink_AddRef(self: ptr IUnknown): ULONG {.stdcall.} =
  var this = cast[Sink](self)
  this.refCount.inc
  result = this.refCount

proc Sink_Release(self: ptr IUnknown): ULONG {.stdcall.} =
  var this = cast[Sink](self)
  this.refCount.dec
  if this.refCount == 0:
    this.typeInfo.Release()
    free(self)
    result = 0
  else:
    result = this.refCount

proc Sink_GetTypeInfoCount(self: ptr IDispatch, pctinfo: ptr UINT): HRESULT {.stdcall.} =
  pctinfo[] = 1
  result = S_OK

proc Sink_GetTypeInfo(self: ptr IDispatch, iTInfo: UINT, lcid: LCID, ppTInfo: ptr LPTYPEINFO): HRESULT {.stdcall.} =
  var this = cast[Sink](self)
  ppTInfo[] = this.typeInfo
  this.typeInfo.AddRef()
  result = S_OK

proc Sink_GetIDsOfNames(self: ptr IDispatch, riid: REFIID, rgszNames: ptr LPOLESTR, cNames: UINT, lcid: LCID, rgDispId: ptr DISPID): HRESULT {.stdcall.} =
  var this = cast[Sink](self)
  result = DispGetIDsOfNames(this.typeInfo, rgszNames, cNames, rgDispId)

proc Sink_Invoke(self: ptr IDispatch, dispid: DISPID, riid: REFIID, lcid: LCID, wFlags: WORD, params: ptr DISPPARAMS, ret: ptr VARIANT, pExcepInfo: ptr EXCEPINFO, puArgErr: ptr UINT): HRESULT {.stdcall, thread.} =
  var this = cast[Sink](self)
  var
    bname: BSTR
    nameCount: UINT
    vret: variant
    name: string
    args = cast[ptr UncheckedArray[VARIANT]](params.rgvarg)
    sargs = newSeq[variant]()
    total = params.cArgs + params.cNamedArgs

  result = this.typeInfo.GetNames(dispid, &bname, 1, &nameCount)

  if result == S_OK:
    name = $bname
    SysFreeString(bname)

    for i in 1..total:
      sargs.add(newVariant(args[total-i]))

    try:
      {.gcsafe.}: vret = this.handler(this.parent, name, sargs)

    except:
      let e = getCurrentException()
      echo "uncatched exception inside event hander: " & $e.name & " (" & $e.msg & ")"

    finally:
      if vret.notNil and ret.notNil:
        result = VariantCopy(ret, &vret.raw)
      else:
        result = S_OK

let
  SinkVtbl: IDispatchVtbl = IDispatchVtbl(
    QueryInterface: Sink_QueryInterface,
    AddRef: Sink_AddRef,
    Release: Sink_Release,
    GetTypeInfoCount: Sink_GetTypeInfoCount,
    GetTypeInfo: Sink_GetTypeInfo,
    GetIDsOfNames: Sink_GetIDsOfNames,
    Invoke: Sink_Invoke
  )

proc newSink(parent: com, iid: GUID, typeInfo: ptr ITypeInfo, handler: comEventHandler): Sink =
  result = cast[Sink.type](alloc0(sizeof(SinkObj)))
  result.lpVtbl = SinkVtbl.unsafeaddr
  result.parent = parent
  result.iid = iid
  result.typeInfo = typeInfo
  typeInfo.AddRef()
  result.handler = handler

proc connectRaw(self: com, riid: REFIID = nil, cookie: DWORD, handler: comEventHandler = nil): DWORD =
  var
    iid: IID
    count, index: UINT
    typeInfo, dispTypeInfo: ptr ITypeInfo
    connection: ptr IConnectionPoint
    typeLib: ptr ITypeLib
    container: ptr IConnectionPointContainer
    enu: ptr IEnumConnectionPoints
    sink: Sink

  defer:
    if typeInfo.notNil: typeInfo.Release()
    if dispTypeInfo.notNil: dispTypeInfo.Release()
    if connection.notNil: connection.Release()
    if typeLib.notNil: typeLib.Release()
    if container.notNil: container.Release()
    if enu.notNil: enu.Release()

  block:
    if self.disp.GetTypeInfoCount(&count).ERR or count != 1: break
    if self.disp.GetTypeInfo(0, 0, &dispTypeInfo).ERR: break
    if dispTypeInfo.GetContainingTypeLib(&typeLib, &index).ERR: break
    if self.disp.QueryInterface(&IID_IConnectionPointContainer, &container).ERR: break

    if riid.isNil:
      if container.EnumConnectionPoints(&enu).ERR: break
      enu.Reset()
      while enu.Next(1, &connection, nil) != S_FALSE:
        if connection.GetConnectionInterface(&iid).OK and
          typeLib.GetTypeInfoOfGuid(&iid, &typeInfo).OK:
            break

        connection.Release()
        connection = nil

    else:
      if container.FindConnectionPoint(riid, &connection).ERR: break
      if connection.GetConnectionInterface(&iid).ERR: break
      if typeLib.GetTypeInfoOfGuid(riid, &typeInfo).ERR: break

    if handler.notNil:
      sink = newSink(self, iid, typeInfo, handler)
      if connection.Advise(cast[ptr IUnknown](sink), &result).OK: return result

    elif cookie != 0:
      if connection.Unadvise(cookie).OK: return 1

  raise newCOMError("unable to connect/disconnect event")

proc connect*(self: com, handler: comEventHandler, riid: REFIID = nil): DWORD {.discardable.} =
  ## Connect a COM object to a comEventHandler. Return a cookie to disconnect (if needed).
  ## Handler is a user defined proc to receive the COM event.
  ## comEventHandler is defined as:
  ##
  ## .. code-block:: Nim
  ##    type comEventHandler = proc(self: com, name: string, params: varargs[variant]): variant

  if handler.notNil:
    result = connectRaw(self, riid, 0, handler)

proc disconnect*(self: com, cookie: DWORD, riid: REFIID = nil): bool {.discardable.} =
  ## Disconnect a COM object from a comEventHandler.

  if cookie != 0 and connectRaw(self, riid, cookie, nil) != 0:
    result = true

proc reformatAsgn(n: NimNode): NimNode =
  # reformat code:
  #   a.b(c, ...) = d -> a.b.set("c", ..., d)
  expectKind(n, nnkAsgn)

  var
    params = n[0]
    dots = n[0][0]

  params.insert(1, dots.last.toStrLit)
  params.add(n.last)
  dots.del(dots.len-1)
  dots.add(newIdentNode("set"))
  result = n[0]

proc reformatCall(n: NimNode): NimNode =
  # reformat code:
  #   a(b, c:=d, e:=f, g, h) -> a(b, g, h, kwargs={"c": toVariant(d), "e": toVariant(f)})
  expectKind(n, nnkCall)

  result = newNimNode(nnkCall)
  var table = newNimNode(nnkTableConstr)

  for i in 0..<n.len:
    if n[i].kind == nnkInfix and n[i][0].eqIdent(":="):
      table.add newTree(nnkExprColonExpr,
          newStrLitNode($n[i][1]),
          newCall(ident("toVariant"), (n[i][2])))

    else:
      result.add n[i]

  if table.len != 0:
    result.add newTree(nnkExprEqExpr, ident("kwargs"), table)

proc comReformat(n: NimNode): NimNode =
  result = n

  proc hasInfixChildren(n: NimNode, infix: string): bool =
    for i in n.children:
      if i.kind == nnkInfix and i[0].eqIdent(infix):
        return true

  if n.kind == nnkAsgn and n[0].kind == nnkCall and n[0][0].kind == nnkDotExpr:
    # deal with a.b(c) = d
    result = comReformat(reformatAsgn(n))

  elif n.kind == nnkCall and n.hasInfixChildren(":="):
    # deal with a(b:=c)
    result = comReformat(reformatCall(n))

  elif n.len != 0:
    for i in 0..<n.len:
      n[i] = comReformat(n[i])

macro comScript*(x: untyped): untyped =
  ## Nim's dot operators `.=` only allow "a.b = c". With this macro, "a.b(c, d) = e"
  ## is allowed. Some assignment needs this macro to work. Moreover, this macro
  ## also translates named arguments to table constructor syntax which
  ## methods/properties related functions can accept (here we use **:=** as
  ## assignment to avoid syntax conflict). For example:
  ##
  ## .. code-block:: Nim
  ##    comScript:
  ##      dict.item("c") = "dog"
  ##      dict.add(item:="fox", key:="c")
  ##      excel.activeSheet.cells(1, 1) = "text"
  ##      excel.activeSheet.range(cell1:="A1") = "text"
  result = comReformat(x)

when isMainModule:

  comScript:
    var dict = CreateObject("Scripting.Dictionary")
    dict.add("a", "the")
    dict.add("b", item:="quick")
    dict.add(item:="fox", key:="c")
    dict.item(key:="c") = "dog"
    for key in dict:
      echo key, " => ", dict.item(key)
