import tables, sequtils, strutils, strformat, os, json

type
  ValueKind* {.pure.}= enum
    vkInt,
    vkFloat,
    vkString,
    vkBool,
    vkProc,
    vkSeq,
    vkTable

  Value* = object
    case kind*: ValueKind
    of vkInt: vInt*: BiggestInt
    of vkFloat: vFloat*: float
    of vkString: vString*: string
    of vkBool: vBool*: bool
    of vkProc: vProc*: proc(s: string, c: Context): string {.closure.}
    of vkSeq: vSeq*: seq[Value]
    of vkTable: vTable*: ref Table[string, Value]

  Context* = ref object
    values: Table[string, Value]
    parent: Context
    searchDirs: seq[string]

proc derive*(val: Value, c: Context): Context;

proc newContext*(searchDirs = @["./"]): Context =
  Context(values: initTable[string,Value](), searchDirs: searchDirs)

proc read*(c: Context, filename: string): string =
  for dir in c.searchDirs:
    let path = fmt"{dir}/{filename}.mustache"
    if existsFile(path):
      return readFile(path)
  if c.parent != nil:
    return c.parent.read(filename)
  else:
    return ""

proc castValue*(value: int): Value =
  Value(kind: vkInt, vInt: cast[BiggestInt](value))

proc castValue*(value: BiggestInt): Value =
  Value(kind: vkInt, vInt: value)

proc castValue*(value: float): Value =
  Value(kind: vkFloat, vFloat: value)

proc castValue*(value: string): Value =
  Value(kind: vkString, vString: value)

proc castValue*(value: bool): Value =
  Value(kind: vkBool, vBool: value)

proc castValue*(value: proc(s: string, c: Context) : string): Value =
  Value(kind: vkProc, vProc: value)

proc castValue*[T](value: Table[string, T]): Value =
  let newValue = new(Table[string, Value])
  for k, v in value.pairs:
    newValue[k] = v.castValue
  Value(kind: vkTable, vTable: newValue)

proc castValue*[T](value: seq[T]): Value =
  Value(kind: vkSeq, vSeq: value.map(castValue))

proc castValue*(value: Value): Value = value

proc castValue*(value: JsonNode): Value =
  case value.kind
  of JObject:
    let vTable = new(Table[string, Value])
    for key, val in value.pairs:
      vTable[key] = val.castValue
    result = Value(kind: vkTable, vTable: vTable)
  of JArray:
    var vSeq: seq[Value] = @[]
    for elem in value.elems:
      vSeq.add(elem.castValue)
    result = Value(kind: vkSeq, vSeq: vSeq)
  of JString:
    result = value.str.castValue
  of JBool:
    result = value.bval.castValue
  of JFloat:
    result = value.fnum.castValue
  of JInt:
    result = value.num.castValue
  of JNull:
    result = castValue("")

proc `[]`*(ctx: Context, key: string): Value =
  if key == ".":
    try:
      return ctx.values["."]
    except KeyError:
      return castValue("")

  if key.contains("."):
    let parts = key.split(".")
    try:
      var newCtx = ctx.values[parts[0]].derive(ctx)
      return newCtx[parts[1..<parts.len].join(".")]
    except KeyError:
      return castValue("")

  if ctx.values.contains(key):
    result = ctx.values[key]
  elif ctx.parent != nil:
    result = ctx.parent[key]
  else:
    result = castValue("")

proc castBool*(value: Value): bool =
  case value.kind
  of vkInt: value.vInt != 0
  of vkFloat: value.vFloat != 0.0
  of vkString: value.vString != ""
  of vkBool: value.vBool
  of vkSeq: value.vSeq.len != 0
  of vkTable: value.vTable.len != 0
  else: true

proc castStr*(value: Value): string =
  case value.kind
  of vkInt: $(value.vInt)
  of vkFloat: $(value.vFloat)
  of vkString: value.vString
  of vkBool: $(value.vBool)
  of vkSeq: "@[]" # TODO
  of vkTable: "{}" # TODO
  else: ""

proc `[]=`*(ctx: Context, key: string, value: Value) =
  ctx.values[key] = value

proc `[]=`*[T](ctx: Context, key: string, value: T) =
  ctx.values[key] = value.castValue

proc derive*(val: Value, c: Context): Context =
  result = Context(parent: c)
  if val.kind == vkTable:
    for k, val in val.vTable.pairs:
      result[k] = val
