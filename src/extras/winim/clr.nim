#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#         Windows .NET Common Language Runtime Supports
#
#====================================================================

## This module add Windows Common Language Runtime (CLR) support to Winim.
## So that we can use Nim to interact with Windows .NET frameworks.
##
## This module heavily dependent on `winim/com` module. So please also
## read the document about it to help understanding the usage.
## Notice: `int` will be converted into `int32` before passing to CLR even in
## 64-bit environment.

when NimVersion < "1.2":
  {.fatal: "winim/clr require nim compiler version >= 1.2".}

runnableExamples:
  proc example1() =
    ## Create a CLR object (aka. C# instance) and call the method
    var mscor = load("mscorlib")
    var rand = mscor.new("System.Random")
    echo rand.Next()

  proc example2() =
    ## Create a type object and call the static method
    var mscor = load("mscorlib")
    var Int32 = mscor.GetType("System.Int32")
    echo @Int32.Parse("12345")

  proc example3() =
    ## Compile some code and run it
    var code = """

    using System;
    public class Test {
      public void Hello() {
        Console.WriteLine("Hello, world");
      }
    }
    """
    var res = compile(code)
    var o = res.CompiledAssembly.new("Test")
    o.Hello()

{.experimental, deadCodeElim: on.} # experimental for dot operators

import ole, com
import strutils, macros
import strformat except `&`
export com

const
  VBCodeProvider* = "Microsoft.VisualBasic.VBCodeProvider"
  CSharpCodeProvider* = "Microsoft.CSharp.CSharpCodeProvider"

type
  CLRError* = object of CatchableError
    ## Raised if a CLR error occurred.
    hresult*: HRESULT

  CLRVariant* = distinct variant
    ## `distinct variant` to represent CLR object or value.

  CLRType* = distinct variant
    ## `distinct variant` to represent CLR Type object.

  CLRInterface* = object
    ## Represent CLR object with specified interface.
    ## Use `{}` to create interface object.
    obj*: CLRVariant
    intf*: CLRVariant

# forward declarations
proc toObject*[T](x: T): CLRVariant

let Null = CLRVariant wrap(VARIANT())
var
  hresult {.threadvar.}: HRESULT
  CurrentAssembly {.threadvar.}: CLRVariant

converter voidpp_converter(x: ptr ptr object): ptr pointer {.used.} = cast[ptr pointer](x)

proc isNil*(x: CLRVariant): bool {.borrow.}
  ## Check if `CLRVariant` is nil or not.

proc isNil*(x: CLRType): bool {.borrow.}
  ## Check if `CLRType` is nil or not.

proc isNull*(x: CLRVariant): bool {.borrow.}
  ## Check if `CLRVariant` is C# null or VB nothing.

proc unwrap*(x: CLRVariant): VARIANT {.borrow.}
  ## Unwrap `CLRVariant` to `VARIANT` object.

proc `==`*(x, y: CLRVariant): bool {.borrow.}
  ## Checks for equality between two `CLRVariant` variables.

proc toVariant*(x: CLRVariant): variant {.inline.} =
  ## Converts a `CLRVariant` x into a `variant`.
  result = variant x

proc toCLRVariant*[T](x: T): CLRVariant {.inline.} =
  ## Converts any supported types into a `CLRVariant`.
  when T is int:
    result = CLRVariant toVariant(int32 x)
  else:
    result = CLRVariant toVariant(x)

proc toCLRVariant*[T](x: openArray[T], vt: VARENUM = VT_VARIANT): CLRVariant {.inline.} =
  ## Converts any supported openArray types into a `CLRVariant`.
  result = CLRVariant toVariant(x, vt)

proc toCLRVariant*(x: typeof(nil)): CLRVariant {.inline.} =
  ## Converts nil into a `CLRVariant`.
  {.gcsafe.}:
    result = Null

proc fromCLRVariant*[T](x: CLRVariant): T {.inline.} =
  ## Converts a `CLRVariant` into any supported types.
  result = fromVariant[T](variant x)

converter clrVariantToVariant*(x: CLRVariant): variant = variant x
  ## Converts `CLRVariant` into `variant` automatically.

converter clrVariantToString*(x: CLRVariant): string = fromCLRVariant[string](x)
  ## Converts `CLRVariant` into `string` automatically.

converter clrVariantToCString*(x: CLRVariant): cstring = fromCLRVariant[cstring](x)
  ## Converts `CLRVariant` into `cstring` automatically.

converter clrVariantToMString*(x: CLRVariant): mstring = fromCLRVariant[mstring](x)
  ## Converts `CLRVariant` into `mstring` automatically.

converter clrVariantToWString*(x: CLRVariant): wstring = fromCLRVariant[wstring](x)
  ## Converts `CLRVariant` into `wstring` automatically.

converter clrVariantToChar*(x: CLRVariant): char = fromCLRVariant[char](x)
  ## Converts `CLRVariant` into `char` automatically.

converter clrVariantToBool*(x: CLRVariant): bool = fromCLRVariant[bool](x)
  ## Converts `CLRVariant` into `bool` automatically.

converter clrVariantToPtrIDispatch*(x: CLRVariant): ptr IDispatch = fromCLRVariant[ptr IDispatch](x)
  ## Converts `CLRVariant` into `ptr IDispatch` automatically.

converter clrVariantToPtrIUnknown*(x: CLRVariant): ptr IUnknown = fromCLRVariant[ptr IUnknown](x)
  ## Converts `CLRVariant` into `ptr IUnknown` automatically.

converter clrVariantToPointer*(x: CLRVariant): pointer = fromCLRVariant[pointer](x)
  ## Converts `CLRVariant` into `ptr IUnknown` automatically.

converter clrVariantToInt*(x: CLRVariant): int = fromCLRVariant[int](x)
  ## Converts `CLRVariant` into `int` automatically.

converter clrVariantToUint*(x: CLRVariant): uint = fromCLRVariant[uint](x)
  ## Converts `CLRVariant` into `uint` automatically.

converter clrVariantToInt8*(x: CLRVariant): int8 = fromCLRVariant[int8](x)
  ## Converts `CLRVariant` into `int8` automatically.

converter clrVariantToUint8*(x: CLRVariant): uint8 = fromCLRVariant[uint8](x)
  ## Converts `CLRVariant` into `uint8` automatically.

converter clrVariantToInt16*(x: CLRVariant): int16 = fromCLRVariant[int16](x)
  ## Converts `CLRVariant` into `int16` automatically.

converter clrVariantToUInt16*(x: CLRVariant): uint16 = fromCLRVariant[uint16](x)
  ## Converts `CLRVariant` into `uint16` automatically.

converter clrVariantToInt32*(x: CLRVariant): int32 = fromCLRVariant[int32](x)
  ## Converts `CLRVariant` into `int32` automatically.

converter clrVariantToUInt32*(x: CLRVariant): uint32 = fromCLRVariant[uint32](x)
  ## Converts `CLRVariant` into `uint32` automatically.

converter clrVariantToInt64*(x: CLRVariant): int64 = fromCLRVariant[int64](x)
  ## Converts `CLRVariant` into `int64` automatically.

converter clrVariantToUInt64*(x: CLRVariant): uint64 = fromCLRVariant[uint64](x)
  ## Converts `CLRVariant` into `uint64` automatically.

converter clrVariantToFloat32*(x: CLRVariant): float32 = fromCLRVariant[float32](x)
  ## Converts `CLRVariant` into `float32` automatically.

converter clrVariantToFloat64*(x: CLRVariant): float64 = fromCLRVariant[float64](x)
  ## Converts `CLRVariant` into `float64` automatically.

converter clrVariantToVARIANTRaw*(x: CLRVariant): VARIANT = fromCLRVariant[VARIANT](x)
  ## Converts `CLRVariant` into `VARIANT` automatically.

converter clrVariantToCOMArray1D*(x: CLRVariant): COMArray1D = fromCLRVariant[COMArray1D](x)
  ## Converts `CLRVariant` into `COMArray1D` automatically.

converter clrVariantToCOMArray2D*(x: CLRVariant): COMArray2D = fromCLRVariant[COMArray2D](x)
  ## Converts `CLRVariant` into `COMArray2D` automatically.

converter clrVariantToCOMArray3D*(x: CLRVariant): COMArray3D = fromCLRVariant[COMArray3D](x)
  ## Converts `CLRVariant` into `COMArray3D` automatically.

converter clrVariantToCOMBinary*(x: CLRVariant): COMBinary = fromCLRVariant[COMBinary](x)
  ## Converts `CLRVariant` into `COMBinary` automatically.

template ERR(x: HRESULT): bool =
  hresult = x
  hresult != S_OK

proc clrError(msg: string, hr: HRESULT = 0) =
  var hr = hr
  if hr == 0: hr = hresult
  if hr == 0: hr = E_FAIL

  var e = newException(CLRError, fmt"{msg} (0x{hr.tohex})")
  e.hresult = hr
  raise e

template to(v: CLRVariant, T: typedesc): untyped =
  var ret: ptr T
  if v.unwrap.vt == VT_UNKNOWN:
    hresult = v.unwrap.punkVal.QueryInterface(&(`IID T`), &ret)

  elif v.unwrap.vt == VT_DISPATCH:
    hresult = v.unwrap.pdispVal.QueryInterface(&(`IID T`), &ret)

  else:
    hresult = E_NOINTERFACE

  ret

proc isObject*(v: CLRVariant): bool =
  ## Check if `CLRVariant` is CLR object or not.
  var obj = v.to(IObject)
  if not obj.isNil:
    result = true
    obj.Release()

proc isType*(v: CLRVariant): bool =
  ## Check if `CLRVariant` is CLR Type object or not.
  var obj = v.to(IType)
  if not obj.isNil:
    result = true
    obj.Release()

proc isStruct*(v: CLRVariant): bool {.inline.} =
  ## Check if `CLRVariant` is CLR struct type (returnd from CLR as VT_RECORD variant).
  result = v.unwrap.vt == VT_RECORD

proc `@`*(v: CLRVariant): CLRType =
  ## Convert `CLRVariant` into `CLRType` so that static members can be invoked.
  if not v.isType():
    clrError("variant is not a type object")

  result = CLRType v

proc com*(v: CLRVariant): com =
  ## Convert `CLRVariant` to winim's com object, aka. COM callable wrapper (CCW).
  if not v.isObject():
    clrError("variant is not an object")

  result = newCom(cast[ptr IDispatch](v.unwrap.punkVal))

proc invoke(typ: ptr IType, self: VARIANT, name: string, flags: int,
    vargs: varargs[CLRVariant, toCLRVariant]): CLRVariant {.discardable.} =

  var
    bstr = SysAllocString(name)
    retVal: VARIANT

  defer:
    SysFreeString(bstr)

  let hr =
    if vargs.len == 0:
      typ.InvokeMember_3(bstr, int32 flags, nil, self, nil, &retVal)
    else:
      let arr = toCLRVariant(vargs)
      typ.InvokeMember_3(bstr, int32 flags, nil, self, arr.unwrap.parray, &retVal)

  if hr.ERR:
    clrError("unable to invoke specified member: " & name)

  result = CLRVariant wrap(retVal)

proc invoke*(v: CLRVariant, name: string, flags: int,
    vargs: varargs[CLRVariant, toCLRVariant]): CLRVariant {.discardable.} =
  ## Low level `invoke` for `CLRVariant`. Equal to `CLRVariant.GetType().InvokeMember(...)`
  if v.isNil:
    clrError("variant is nil", E_POINTER)

  var
    obj: ptr IObject
    typ: ptr IType
    self: VARIANT

  defer:
    if not obj.isNil: obj.Release()
    if not typ.isNil: typ.Release()

  obj = v.to(IObject)
  if obj.isNil:
    obj = toObject(v).to(IObject)
    if obj.isNil:
      clrError("variant is not an object")

  if obj.GetType(&typ).ERR:
    clrError("unable to get type of object")

  self.vt = VT_UNKNOWN
  self.punkVal = obj

  result = invoke(typ, self, name, flags, vargs)

proc invoke*(v: CLRType, name: string, flags: int,
    vargs: varargs[CLRVariant, toCLRVariant]): CLRVariant {.discardable.} =
  ## Low level `invoke` for `CLRType`. Equal to `CLRType.InvokeMember(...)`
  let v = CLRVariant v
  if v.isNil:
    clrError("variant is nil", E_POINTER)

  var
    typ: ptr IType
    self: VARIANT

  defer:
    if not typ.isNil: typ.Release()

  typ = v.to(IType)
  if typ.isNil:
    clrError("variant is not a type")

  result = invoke(typ, self, name, flags, vargs)

proc invoke*(v: CLRInterface, name: string, flags: int,
    vargs: varargs[CLRVariant, toCLRVariant]): CLRVariant {.discardable.} =
  ## Low level `invoke` for `CLRInterface`.
  if v.obj.isNil or v.intf.isNil:
    clrError("invalid interface", E_POINTER)

  var
    obj: ptr IObject
    typ: ptr IType
    self: VARIANT

  defer:
    if not obj.isNil: obj.Release()
    if not typ.isNil: typ.Release()

  obj = v.obj.to(IObject)
  if obj.isNil:
    obj = toObject(v.obj).to(IObject)
    if obj.isNil:
      clrError("CLRInterface.obj is not an object")

  typ = v.intf.to(IType)
  if typ.isNil:
    clrError("CLRInterface.intf is not a type")

  self.vt = VT_UNKNOWN
  self.punkVal = obj

  result = invoke(typ, self, name, flags, vargs)

macro `.`*(v: CLRVariant, name: untyped, vargs: varargs[untyped]): untyped =
  ## Dot operator for `CLRVariant`. Invoke a method, get a property, or get a field.
  result = newCall("invoke", v, newStrLitNode($name),
    newIntLitNode(BindingFlags_InvokeMethod or BindingFlags_GetProperty or
      BindingFlags_GetField or BindingFlags_OptionalParamBinding))

  for i in vargs: result.add i

macro `.=`*(v: CLRVariant, name: untyped, vargs: varargs[untyped]): untyped =
  ## Dot assignment operator for `CLRVariant`. Set a property or field.
  result = newCall("invoke", v, newStrLitNode($name),
    newIntLitNode(BindingFlags_SetProperty or BindingFlags_SetField))

  for i in vargs: result.add i

macro `.`*(v: CLRType, name: untyped, vargs: varargs[untyped]): untyped =
  ## Dot operator for `CLRType`. Invoke a static method, get a static property, or get a static field.
  result = newCall("invoke", v, newStrLitNode($name),
    newIntLitNode(BindingFlags_InvokeMethod or BindingFlags_GetProperty or
      BindingFlags_GetField or BindingFlags_FlattenHierarchy or BindingFlags_Static or
      BindingFlags_Public or BindingFlags_NonPublic or BindingFlags_OptionalParamBinding))

  for i in vargs: result.add i

macro `.=`*(v: CLRType, name: untyped, vargs: varargs[untyped]): untyped =
  ## Dot assignment operator for `CLRType`. Set a static property or field.
  result = newCall("invoke", v, newStrLitNode($name),
    newIntLitNode(BindingFlags_SetProperty or BindingFlags_SetField or
      BindingFlags_FlattenHierarchy or BindingFlags_Static or BindingFlags_Public or
      BindingFlags_NonPublic))

  for i in vargs: result.add i

macro `.`*(v: CLRInterface, name: untyped, vargs: varargs[untyped]): untyped =
  ## Dot operator for `CLRInterface`.
  result = newCall("invoke", v, newStrLitNode($name),
    newIntLitNode(BindingFlags_InvokeMethod or BindingFlags_GetProperty or
      BindingFlags_GetField or BindingFlags_OptionalParamBinding))

  for i in vargs: result.add i

macro `.=`*(v: CLRInterface, name: untyped, vargs: varargs[untyped]): untyped =
  ## Dot assignment operator for `CLRInterface`.
  result = newCall("invoke", v, newStrLitNode($name),
    newIntLitNode(BindingFlags_SetProperty or BindingFlags_SetField))

  for i in vargs: result.add i

proc reformatAsgn(n: NimNode): NimNode =
  # reformat code:
  #   a.b(c, ...) = d -> a.b.invoke("c", ..., d)
  expectKind(n, nnkAsgn)

  var
    params = n[0]
    dots = n[0][0]

  params.insert(1, newIntLitNode(BindingFlags_SetProperty or BindingFlags_SetField))
  params.insert(1, dots.last.toStrLit)
  params.add(n.last)
  dots.del(dots.len-1)
  dots.add(newIdentNode("invoke"))
  result = n[0]

proc clrReformat(n: NimNode): NimNode =
  result = n

  if n.kind == nnkAsgn and n[0].kind == nnkCall and n[0][0].kind == nnkDotExpr:
    # deal with a.b(c) = d
    result = clrReformat(reformatAsgn(n))

  elif n.len != 0:
    for i in 0..<n.len:
      n[i] = clrReformat(n[i])

macro clrScript*(x: untyped): untyped =
  ## Nim's dot operators `.=` only allow "a.b = c". With this macro, "a.b(c, d) = e"
  ## is allowed. Some assignment needs this macro to work.
  result = clrReformat(x)

iterator fields*(v: CLRVariant): string =
  ## Iterates over every field of CLR struct type.
  if v.unwrap.vt != VT_RECORD:
    clrError("variant is not a struct", E_NOINTERFACE)

  var count: ULONG
  if v.unwrap.pRecInfo.GetFieldNames(&count, nil).ERR:
    clrError("unable to get field names of struct")

  var names = newSeq[BSTR](count)
  if v.unwrap.pRecInfo.GetFieldNames(&count, &names[0]).ERR:
    clrError("unable to get field names of struct")

  for bstr in names:
    yield $bstr
    SysFreeString(bstr)

iterator fieldPairs*(v: CLRVariant): tuple[name: string, value: CLRVariant] =
  ## Iterates over every field of CLR struct type returning their name and value.
  if v.unwrap.vt != VT_RECORD:
    clrError("variant is not a record", E_NOINTERFACE)

  var count: ULONG
  if v.unwrap.pRecInfo.GetFieldNames(&count, nil).ERR:
    clrError("unable to get field names of record")

  var names = newSeq[BSTR](count)
  if v.unwrap.pRecInfo.GetFieldNames(&count, &names[0]).ERR:
    clrError("unable to get field names of record")

  for bstr in names:
    var name = $bstr
    var V: VARIANT
    if v.unwrap.pRecInfo.GetField(v.unwrap.pvRecord, bstr, &V).ERR:
      clrError("unable to get specified filed: " & name)

    yield (name, toCLRVariant(V))
    SysFreeString(bstr)

proc `[]`*(v: CLRVariant, name: string): CLRVariant =
  ## Returns specified field as `CLRVariant` from CLR struct type.
  if v.unwrap.vt != VT_RECORD:
    clrError("variant is not a record", E_NOINTERFACE)

  var V: VARIANT
  if v.unwrap.pRecInfo.GetField(v.unwrap.pvRecord, name, &V).ERR:
    clrError("unable to get specified filed: " & name)

  result = toCLRVariant(V)

proc `$`*(v: CLRVariant): string =
  ## `$` operator for CLRVariant.
  try:
    result = string v

  except VariantConversionError:
    if v.isObject:
      result = $v.ToString()

    elif v.isStruct:
      var parts = newSeq[string]()
      for key, val in v.fieldPairs:
        parts.add key & ": " & $val

      result = '(' & parts.join(", ") & ')'

    else:
      result = v.rawTypeDesc

proc repr*(v: CLRVariant): string =
  ## `repr` operator for CLRVariant.
  try:
    result = string v

  except VariantConversionError:
    if v.isObject:
      result = $v.ToString()

    elif v.isStruct:
      var parts = newSeq[string]()
      for key, val in v.fieldPairs:
        parts.add key & ": " & $val

      result = '(' & parts.join(", ") & ')'

    else:
      result = repr v.unwrap

iterator clrVersions*(): string =
  ## Iterates over every CLR version installed on a computer..
  var
    metahost: ptr ICLRMetaHost
    enumUnknown: ptr IEnumUnknown
    enumRuntime: ptr IUnknown
    runtimeInfo: ptr ICLRRuntimeInfo

  defer:
    if not metahost.isNil: metahost.Release()
    if not enumUnknown.isNil: enumUnknown.Release()

  if CLRCreateInstance(&CLSID_CLRMetaHost, &IID_ICLRMetaHost, &metahost).ERR:
    clrError("unable to create metahost instance")

  if metaHost.EnumerateInstalledRuntimes(&enumUnknown).ERR:
    clrError("unable to enumerate installed runtimes")

  while enumUnknown.Next(1, &enumRuntime, nil) == S_OK:
    defer: enumRuntime.Release()
    if enumRuntime.QueryInterface(&IID_ICLRRuntimeInfo, &runtimeInfo) == S_OK:
      defer: runtimeInfo.Release()
      var
        size = DWORD 1024
        buffer = newWString(size)

      if runtimeInfo.GetVersionString(&buffer, &size) == S_OK:
        yield $buffer.nullTerminated

proc clrStart*(version = ""): CLRVariant {.discardable.} =
  ## Start the specified CLR and return its `AppDomain`.
  ## This call can be omitted if last version of runtime is required.
  var version = version
  if version == "":
    for v in clrVersions():
      version = v

    if version == "":
      clrError("unable to find a installed CLR")

  var
    metahost: ptr ICLRMetaHost
    runtimeInfo: ptr ICLRRuntimeInfo
    clrRuntimeHost: ptr ICLRRuntimeHost
    corRuntimeHost: ptr ICorRuntimeHost
    retVal: VARIANT
    loadable: BOOL

  defer:
    if not metahost.isNil: metahost.Release()
    if not runtimeInfo.isNil: runtimeInfo.Release()
    if not clrRuntimeHost.isNil: clrRuntimeHost.Release()
    if not corRuntimeHost.isNil: corRuntimeHost.Release()

  if CLRCreateInstance(&CLSID_CLRMetaHost, &IID_ICLRMetaHost, &metahost).ERR:
    clrError("unable to create metahost instance")

  if metahost.GetRuntime(version, &IID_ICLRRuntimeInfo, &runtimeInfo).ERR:
    clrError("unable to get runtime of " & version)

  if runtimeInfo.IsLoadable(&loadable).ERR or not bool(loadable):
    clrError("specified runtime is not loadable")

  if runtimeInfo.GetInterface(&CLSID_CLRRuntimeHost, &IID_ICLRRuntimeHost, &clrRuntimeHost).ERR:
    clrError("unable to get interface of CLRRuntimeHost")

  if runtimeInfo.GetInterface(&CLSID_CorRuntimeHost, &IID_ICorRuntimeHost, &corRuntimeHost).ERR or
      corRuntimeHost.GetDefaultDomain(&retVal.punkVal).ERR:

    if clrRuntimeHost.Start().ERR:
      clrError("unable to start CLRRuntimeHost")

    if runtimeInfo.GetInterface(&CLSID_CorRuntimeHost, &IID_ICorRuntimeHost, &corRuntimeHost).ERR:
      clrError("unable to get interface of CorRuntimeHost")

    if corRuntimeHost.Start().ERR:
      clrError("unable to start CorRuntimeHost")

    if corRuntimeHost.GetDefaultDomain(&retVal.punkVal).ERR:
      clrError("unable to get default domain")

  retVal.vt = VT_UNKNOWN
  result = CLRVariant wrap(retVal)
  CurrentAssembly = result.GetType().Assembly.GetType()

proc load*(name: string): CLRVariant {.discardable.} =
  ## Loads an assembly from file or from the global assembly cache using a partial name.
  if CurrentAssembly.isNil:
    clrStart()

  try:
    result = @CurrentAssembly.LoadFrom(name)

  except CLRError:
    result = @CurrentAssembly.LoadWithPartialName(name)

proc load*(data: COMBinary): CLRVariant {.discardable.} =
  ## Loads the assembly with a common object file format (COFF)-based image.
  if CurrentAssembly.isNil:
    clrStart()

  result = @CurrentAssembly.Load(data)

proc load*(data: openArray[byte]): CLRVariant {.discardable.} =
  ## Loads the assembly with a common object file format (COFF)-based image.
  if CurrentAssembly.isNil:
    clrStart()

  result = @CurrentAssembly.Load(toCLRVariant(data, VT_UI1))

proc new*(assembly: CLRVariant, name: string, vargs: varargs[CLRVariant, toCLRVariant]): CLRVariant {.discardable.} =
  ## Create an instance from this assembly by name (case-sensitive).
  if assembly.isNil:
    clrError("variant is nil", E_POINTER)

  if vargs.len == 0:
    result = assembly.CreateInstance(name, false, nil, nil, nil, nil, nil)
  else:
    let arr = toCLRVariant(vargs)
    result = assembly.CreateInstance(name, false, nil, nil, arr, nil, nil)

proc new*(typ: CLRType, vargs: varargs[CLRVariant, toCLRVariant]): CLRVariant {.discardable.} =
  ## Create an instance of this type
  if typ.isNil:
    clrError("variant is nil", E_POINTER)

  var Activator {.threadvar.}: CLRVariant
  if Activator.isNil:
    Activator = load("mscorlib").GetType("System.Activator")

  let arr = toCLRVariant(vargs)
  result = @Activator.CreateInstance(CLRVariant typ, arr)

proc compile*(code: string, references: openArray[string] = ["System.dll"], filename = "",
    compilerOptions = "", provider = CSharpCodeProvider, debug = false): CLRVariant {.discardable.} =
  ## Compiles the specified code. Returns the `CompilerResults` object.
  var
    sys = load("System")
    codeProvider = sys.new(provider)
    assemblyNames = toCLRVariant(references, VT_BSTR)
    prms = sys.new("System.CodeDom.Compiler.CompilerParameters", assemblyNames)

  prms.OutputAssembly = filename
  prms.GenerateInMemory = filename == ""
  prms.GenerateExecutable = filename.toLowerAscii.endsWith ".exe"
  prms.CompilerOptions = compilerOptions
  prms.IncludeDebugInformation = debug

  result = codeProvider.CompileAssemblyFromSource(prms, code)

proc reclaim*() =
  ## Forces an immediate garbage collection.
  var Gc {.threadvar.}: CLRVariant
  if Gc.isNil:
    Gc = load("mscorlib").GetType("System.GC")

  @Gc.Collect()
  @Gc.GetTotalMemory(true)

proc getRuntimeHelp(): CLRVariant =
  # Use runtime compiled assembly to support different runtime version.
  const code = """
  using System;using System.Drawing;using System.Runtime.InteropServices;abstract class RuntimeHelper{public static IntPtr wrapIntPtr(Int64 i){return Marshal.GetIUnknownForObject((IntPtr)i);}
  public static IntPtr wrapIntPtr(Int32 i){return Marshal.GetIUnknownForObject((IntPtr)i);}
  public static IntPtr wrapAny(Object o){return Marshal.GetIUnknownForObject(o);}
  public static T Cast<T>(Object o){return(T)o;}
  public static IntPtr wrapAny(Object o,Type t){try{if(t==o.GetType()){return wrapAny(o);}
  else if(t.IsEnum){return wrapAny(Enum.ToObject(t,o));}
  else if(t==typeof(Color)){int i=(int)Convert.ChangeType(o,typeof(int));return wrapAny(Color.FromArgb(i&0xff,(i>>8)&0xff,(i>>16)&0xff));}
  else{try{return wrapAny(Convert.ChangeType(o,t));}
  catch(System.InvalidCastException){return wrapAny(typeof(RuntimeHelper).GetMethod("Cast").MakeGenericMethod(t).Invoke(null,new object[]{o}));}}}
  catch{return IntPtr.Zero;}}
  public static IntPtr wrapAny(Object o,String type){try{return wrapAny(o,Type.GetType(type,true,true));}
  catch{return IntPtr.Zero;}}}
  """

  if CurrentAssembly.isNil:
    clrStart()

  var RuntimeHelp {.threadvar.}: CLRVariant
  if RuntimeHelp.isNil:
    var res = compile(code, ["System.dll", "System.Drawing.dll"])
    assert res.Errors.Count == 0
    RuntimeHelp = res.CompiledAssembly.GetType("RuntimeHelper")

  result = RuntimeHelp

proc toObjectRaw(iunknown: CLRVariant): CLRVariant =
  var v: VARIANT
  v.vt = VT_UNKNOWN
  v.byref = iunknown.unwrap.byref
  if v.byref.isNil:
    clrError("unable to convert to object", E_NOTIMPL)

  # Decrement the reference count for Marshal.GetIUnknownForObject()
  if not v.punkVal.isNil:
    v.punkVal.Release()
  result = toCLRVariant(v)

proc toObject*(x: pointer|proc): CLRVariant =
  ## Converts `pointer` or `proc` into a `System.IntPtr` object.
  var RuntimeHelp = getRuntimeHelp()
  toObjectRaw(@RuntimeHelp.wrapIntPtr(cast[int](x)))

proc toObject*[T](x: T): CLRVariant =
  ## Try to convert any value types or struct types into a CLR object.
  var RuntimeHelp = getRuntimeHelp()
  toObjectRaw(@RuntimeHelp.wrapAny(x))

proc toObject*[T](x: T, typ: string): CLRVariant =
  ## Try to convert any value types or struct types into CLR object of specified type.
  var RuntimeHelp = getRuntimeHelp()
  toObjectRaw(@RuntimeHelp.wrapAny(x, typ))

proc toObject*[T](x: T, typ: CLRVariant): CLRVariant =
  ## Try to convert any value types or struct types into CLR object of specified type.
  var RuntimeHelp = getRuntimeHelp()
  toObjectRaw(@RuntimeHelp.wrapAny(x, typ))

proc `[]`*[T](x: T): CLRVariant =
  ## Syntax sugar for x.toObject().
  toObject(x)

proc `[]`*[T](x: T, typ: CLRVariant): CLRVariant {.inline.} =
  ## Syntax sugar for x.toObject(CLRVariant).
  if typ.isNil:
    clrError("variant is nil", E_POINTER)

  toObject(x, typ)

proc `{}`*(v, i: CLRVariant): CLRInterface {.inline.} =
  ## Syntax suger to create CLRInterface (require nim compiler version >= 1.2.0).
  result.obj = v
  result.intf = i

proc item(v: CLRVariant, i: int): CLRVariant =
  var v = v
  if not v.isObject:
    v = v.toObject()

  let iList = CLRInterface(obj: v, intf: v.GetType.GetInterface("System.Collections.IList"))
  result = iList.Item(i)

proc `[]`*(v: CLRVariant, i: SomeOrdinal): CLRVariant =
  ## Index operator for `CLRVariant` (via `IList` interface).
  try:
    result = v.item(int i)
  except CLRError:
    clrError("variant is not indexable")

iterator pairs*(v: CLRVariant): (int, CLRVariant) =
  ## Iterates over every member of `CLRVariant`. Yields (int, CLRVariant) pairs.
  ## Support System.Array, Enumerable, Collection, etc.
  var v = v
  if not v.isObject:
    var Array {.threadvar.}: CLRVariant
    if Array.isNil:
      Array = load("mscorlib").GetType("System.Array")

    try:
      v = v[Array]
    except CLRError:
      clrError("variant is not enumerable")

  proc ok(i: CLRInterface): bool {.inline.} = (not i.intf.isNil) and (not i.intf.isNull)

  let
    vtype = v.GetType
    iCollection = CLRInterface(obj: v, intf: vtype.GetInterface("System.Collections.ICollection"))
    iList = CLRInterface(obj: v, intf: vtype.GetInterface("System.Collections.IList"))
    iEnumerable = CLRInterface(obj: v, intf: vtype.GetInterface("System.Collections.IEnumerable"))

  if iCollection.ok and iList.ok:
    for i in 0 ..< iCollection.Count:
      yield (i, iList.Item(i))

  elif iEnumerable.ok:
    var
      enumerator: CLRVariant
      i = 0

    try:
      enumerator = iEnumerable.GetEnumerator
    except CLRError:
      clrError("variant is not enumerable")

    while enumerator.MoveNext:
      yield (i, enumerator.Current)
      i.inc

  else:
    clrError("variant is not enumerable")

iterator items*(v: CLRVariant): CLRVariant =
  ## Iterates over every member of `CLRVariant`.
  ## Support System.Array, Enumerable, Collection, etc.
  for i, o in v:
    yield o
