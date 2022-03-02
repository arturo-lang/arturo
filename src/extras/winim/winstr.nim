#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#                Windows String Type Utilities
#
#====================================================================

##  This module contains new string types and utilities to deal with strings in Windows.
##  Windows SDK use following types to represent a char or a string:
##
##  .. code-block:: Nim
##    type
##      CHAR = char
##      WCHAR = uint16
##      LPSTR|LPCSTR = ptr CHAR # however, it should be ansi string, not utf8 string
##      LPWSTR|LPCWSTR = ptr WCHAR
##      BSTR = distinct ptr WCHAR # BSTR is not binary compatible with LPWSTR
##      (ptr) array[I, CHAR] # sometimes string defined as array[1, CHAR] but not only one char
##      (ptr) array[I, WCHAR] # sometimes string defined as array[1, WCHAR] but not only one widechar
##
##  By default, Nim's string type is utf8 encoding.
##  However, Windows use wide character string (aka. unicode string) or multibyte character string
##  (aka. ansi string). So, this module introduce following string types.
##
##  .. code-block:: Nim
##    type
##      string # nim built-in string type, utf8 encoding by default, can be ansi string sometimes.
##      cstring # compatible to the type char* in Ansi C
##      wstring = distinct string # new string type to store unicode string
##      mstring = distinct string # new string type to store ansi string
##
##  Some type classes are also defined for convenience to deal with strings.
##
##  .. code-block:: Nim
##    type
##      SomeChar = byte | char | WCHAR
##      SomeString = string | mstring | wstring
##      SomeBuffer[I] = ptr SomeChar | array[I, SomeChar] | ptr array[I, SomeChar] |
##        ptr UncheckedArray[SomeChar] | openArray[SomeChar] | seq[SomeChar]
##      Stringable = SomeChar | SomeString | SomeBuffer | cstring | BSTR
##
##  Here are the pseudocode for most useful functions introduced by this module.
##
##  .. code-block:: Nim
##    proc `&`(s: cstring|string|wstring|mstring): pointer
##      # Get address of the first char of a string.
##      # For string, it has a similar meaning to cstring(s).
##
##    proc `$`(x: Stringable): string
##    proc `+$`(x: Stringable): wstring
##    proc `-$`(x: Stringable): mstring
##      # Convert any stringable type to string, wstring, or mstring.
##      # These operators assume string|cstring|ptr char|openArray[char] are utf8 encoding.
##      # setOpenArrayStringable() can be used to switch the behavior of `$` operator.
##
##    proc `$$`(x: Stringable): string
##    proc `+$$`(x: Stringable): wstring
##    proc `-$$`(x: Stringable): mstring
##      # Convert any stringable type to string, wstring, or mstring.
##      # These operators assume string|cstring|ptr char|openArray[char] are ansi encoding.
##      # For mstring|wstring|LPWSTR etc, these operators are the same as `$`, `+$`, `-$`.
##
##    template `<<`(s: SomeString, b: SomeBuffer)
##    template `<<`(b: SomeBuffer, s: SomeString)
##    template `<<<`(b: SomeBuffer, s: SomeString)
##    template `>>`(a: typed, b: typed) = b << a
##    template `>>>`(a: typed, b: typed) = b <<< a
##      # String << Buffer or Buffer >> String: Fill string by buffer.
##      # Buffer << String or String >> Buffer: Fill buffer by string.
##      # Buffer <<< String or String >>> Buffer: Fill buffer by string, include a null.
##
##      # These operators don't convert the encoding (copy byte by byte).
##      # Please make sure both side have the same character size.
##      # If destination don't have the length information (e.g. pointer or UncheckedArray),
##      # please make sure the buffer size is large enough.
##
##    proc nullTerminate(s: var SomeString)
##      # Assume a string is null terminated and set the correct length.
##
##    proc nullTerminated[T: SomeString](s: T): T
##      # Assume a string is null terminated and return the length-corrected string.
##
##    template L(s: string): wstring
##      # Generate wstring at compile-time if possible.
##      # Only const string or string literal can be converted to unicode string at compile-time,
##      # otherwise it is just `+$`.
##
##    template T(s: string): mstring|wstring
##      # Generate wstring or mstring depend on conditional symbol: useWinAnsi.
##      # For example: (this code works under both unicode and ansi mode)
##
##        MessageBox(0, T"hello, world", T"Nim is Powerful 中文測試", 0)
##
##    template T(n: Natural): mstring|wstring
##      # Generate wstring or mstring buffer depend on conditional symbol: useWinAnsi.
##      # Use `&` to get the buffer address and then pass to Windows API.
##
##    converter winstrConverter(s: SomeString): SomeBuffer
##      # With these converters, passing string to Windows API is more easy.
##      #   Following converters don't need encoding conversion:
##      #     string => LPSTR|ptr char
##      #     mstring => LPSTR|ptr char
##      #     wstring => LPWSTR|BSTR
##      #     cstring => ptr char
##      #     BSTR => LPWSTR
##      #
##      #   Some converters DO need encoding conversion (utf8 to unicode).
##      #   New memory block will be allocated. However, they are useful and convenience.
##      #     cstring|string => LPWSTR|BSTR
##      #
##      # Winim don't use built-in WideCString, but still support it by converter.
##      #   WideCString => LPWSTR
##      #   WideCString => wstring
##      #   wstring => WideCString
##
##  There are also new string functions to deal with wstring and mstring just like built-in string type.
##
##  .. code-block:: Nim
##    proc newWString(len: Natural): wstring
##      # Generate wstring buffer
##    proc newMString(len: Natural): mstring
##      # Generate mstring buffer
##
##    proc setLen(s: var mstring|wstring, newLen: Natural)
##    proc substr(s: wstring|mstring, first = 0): wstring|mstring
##    proc substr(s: wstring|mstring, first, last: int): wstring|mstring
##    proc len(s: wstring|mstring): int
##    proc high(s: wstring|mstring): int
##    proc low(s: wstring|mstring): int
##    proc repr(s: wstring|mstring): string
##    proc toHex(s: wstring|mstring): string
##
##    proc `[]`(s: wstring|mstring, i: int): WCHAR|mstring
##    proc `[]=`(s: wstring|mstring, i: int, u: WCHAR|CHAR)
##    proc `[]=`(s: wstring|mstring, i: int, u: wstring|mstring)
##    proc `[]`(s: wstring|mstring, x: HSlice)
##    proc `[]=`(s: var wstring|var mstring, x: HSlice[int], b: wstring|mstring)
##    proc `==`(x, y: wstring|mstring): bool
##    proc `<=`(x, y: wstring|mstring): bool
##    proc `<`(x, y: wstring|mstring): bool
##    proc cmp(x, y: wstring|mstring): int
##    proc `&`(s: wstring|mstring, t: wstring|mstring): wstring|mstring
##
##    iterator items(s: wstring|mstring): WCHAR|mstring
##    iterator mitems(s: var wstring): WCHAR
##    iterator pairs(s: wstring|mstring): tuple[key: int|mIndex, val: WCHAR|mstring]
##    iterator mpairs(s: var wstring): WCHAR

{.deadCodeElim: on.}

import macros, strutils, inc/[winimbase, windef]
export strutils.toHex, winimbase

when not declared(IndexDefect):
  type
    IndexDefect = object of IndexError

# generate from winimx (avoid importing objbase everytime)
const
  CP_ACP = 0
  CP_UTF8 = 65001

proc lstrlenA(lpString: LPCSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc lstrlenW(lpString: LPCWSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MultiByteToWideChar(CodePage: UINT, dwFlags: DWORD, lpMultiByteStr: LPCCH, cbMultiByte: int32, lpWideCharStr: LPWSTR, cchWideChar: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WideCharToMultiByte(CodePage: UINT, dwFlags: DWORD, lpWideCharStr: LPCWCH, cchWideChar: int32, lpMultiByteStr: LPSTR, cbMultiByte: int32, lpDefaultChar: LPCCH, lpUsedDefaultChar: LPBOOL): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SysStringLen(P1: BSTR): UINT {.winapi, stdcall, dynlib: "oleaut32", importc.}

# helper functions

proc toHex(p: pointer, L: int): string =
  const HexChars = "0123456789ABCDEF"
  let a = cast[ptr UncheckedArray[byte]](p)
  result = newStringOfCap(L * 2)
  for i in 0 ..< L:
    let
      hi = int a[i] shr 4
      lo = int a[i] and 0xF
    result.add HexChars[hi]
    result.add HexChars[lo]

proc toHex*(s: cstring): string {.inline.} =
  ## Converts a `cstring` to its hexadecimal representation.
  ## No prefix like ``0x`` is generated.
  result = toHex($s)

when defined(cpu64):
  converter NaturalToInt32(x: Natural): int32 = int32 x

# new string types

type
  # for wstring, always add extra null wchar to ensure null-terminated.

  wstring* = distinct string
    ## New string type to store wide character string (aka. unicode string).

  mstring* = distinct string
    ## New string type to store multibyte character string (aka. ansi string).

  mIndex* = distinct int
    ## Use `mIndex` in substr, [] or []= for `mstring` means
    ## index by MBCS characters, not by bytes.

  SomeChar* = byte | char | WCHAR
    ## Type class matching all char types.

  SomeString* = string | mstring | wstring
    ## Type class matching all string types.

  SomeBuffer*[I] = ptr SomeChar | array[I, SomeChar] | ptr array[I, SomeChar] |
      ptr UncheckedArray[SomeChar] | openArray[SomeChar] | seq[SomeChar]
    ## Type class matching all string buffer types.

  Stringable* = SomeChar | SomeString | SomeBuffer | cstring | BSTR
    ## Type class matching all stringable types.

template raw(s: wstring, L: Natural): var WCHAR =
  cast[ptr WCHAR](unsafeaddr(string(s)[L * 2]))[]

template `^^`(s, i: untyped): untyped =
  (when i is BackwardsIndex: s.len - int(i) else: int(i))

proc newWString*(L: Natural): wstring = wstring(newString((L + 1) * 2))
  ## Returns a new `wstring` of length L, counting by wide characters.

proc newMString*(L: Natural): mstring = mstring(newString(L))
  ## Returns a new `mstring` of length L, counting by bytes.

proc len*(s: wstring): int {.inline.} = max(string(s).len div 2 - 1, 0)
  ## Returns the length of `wstring`, counting by wide characters.

proc len*(s: mstring): int {.inline.} = string(s).len
  ## Returns the length of `mstring`, counting by bytes.

proc newWStringOfCap*(L: Natural): wstring =
  ## Returns a new `wstring` of length 0 but with capacity L, counting by wide characters.
  result = wstring(newStringOfCap((L + 1) * 2))
  string(result).add "\0\0"

proc newMStringOfCap*(L: Natural): mstring =
  ## Returns a new `mstring` of length 0 but with capacity L, counting by bytes.
  result = mstring(newStringOfCap(L))

proc setLen*(s: var wstring, L: Natural) {.inline.} =
  ## Sets the length of `wstring` s to L, counting by wide characters.
  setLen(string(s), (L + 1) * 2)
  s.raw(s.len) = 0

proc setLen*(s: var mstring, L: Natural) {.inline.} =
  ## Sets the length of `mstring` s to L, counting by wide bytes.
  setLen(string(s), L)

proc `&`*(s: string): ptr char {.inline.} =
  ## Get address of the first char of a `string`.
  result = cast[ptr char](cstring s)

proc `&`*(s: cstring): ptr char {.inline.} =
  ## Get address of the first char of a `cstring`.
  result = cast[ptr char](s)

proc `&`*(s: wstring): ptr WCHAR {.inline.} =
  ## Get address of the first WCHAR of a `wstring`.
  result = cast[ptr WCHAR](&(string(s)))

proc `&`*(s: mstring): ptr char {.inline.} =
  ## Get address of the first char of a `mstring`.
  result = &(string(s))

proc `UTF8->wstring`(source: ptr char, L: Natural): wstring =
  if not source.isNil:
    var wLen = MultiByteToWideChar(CP_UTF8, 0, source, L, nil, 0)
    result = newWString(wLen)
    discard MultiByteToWideChar(CP_UTF8, 0, source, L, &result, wLen)

proc `ANSI->wstring`(source: ptr char, L: Natural): wstring =
  if not source.isNil:
    var wLen = MultiByteToWideChar(CP_ACP, 0, source, L, nil, 0)
    result = newWString(wLen)
    discard MultiByteToWideChar(CP_ACP, 0, source, L, &result, wLen)

proc `UNICODE->wstring`(source: ptr WCHAR, L: Natural): wstring =
  if not source.isNil:
    result = newWString(L)
    copyMem(&result, source, L * 2)

proc `UTF8->mstring`(source: ptr char, L: Natural): mstring =
  if not source.isNil:
    var wLen = MultiByteToWideChar(CP_UTF8, 0, source, L, nil, 0)
    var buffer = cast[ptr WCHAR](alloc(wLen * 2))
    if not buffer.isNil:
      discard MultiByteToWideChar(CP_UTF8, 0, source, L, buffer, wLen)

      var mLen = WideCharToMultiByte(CP_ACP, 0, buffer, wLen, nil, 0, nil, nil)
      result = newMString(mLen)
      discard WideCharToMultiByte(CP_ACP, 0, buffer, wLen, &result, mLen, nil, nil)
      dealloc(buffer)

proc `ANSI->mstring`(source: ptr char, L: Natural): mstring =
  if not source.isNil:
    result = newMString(L)
    copyMem(&result, source, L)

proc `UNICODE->mstring`(source: ptr WCHAR, L: Natural): mstring =
  if not source.isNil:
    var mLen = WideCharToMultiByte(CP_ACP, 0, source, L, nil, 0, nil, nil)
    result = newMString(mLen)
    discard WideCharToMultiByte(CP_ACP, 0, source, L, &result, mLen, nil, nil)

proc `UTF8->string`(source: ptr char, L: Natural): string =
  if not source.isNil:
    result = newString(L)
    copyMem(&result, source, L)

proc `ANSI->string`(source: ptr char, L: Natural): string =
  if not source.isNil:
    var wLen = MultiByteToWideChar(CP_ACP, 0, source, L, nil, 0)
    var buffer = cast[ptr WCHAR](alloc(wLen * 2))
    if not buffer.isNil:
      discard MultiByteToWideChar(CP_ACP, 0, source, L, buffer, wLen)

      var mLen = WideCharToMultiByte(CP_UTF8, 0, buffer, wLen, nil, 0, nil, nil)
      result = newString(mLen)
      discard WideCharToMultiByte(CP_UTF8, 0, buffer, wLen, &result, mLen, nil, nil)
      dealloc(buffer)

proc `UNICODE->string`(source: ptr WCHAR, L: Natural): string =
  if not source.isNil:
    var mLen = WideCharToMultiByte(CP_UTF8, 0, source, L, nil, 0, nil, nil)
    result = newString(mLen)
    discard WideCharToMultiByte(CP_UTF8, 0, source, L, &result, mLen, nil, nil)

template getptr[T](x: openArray[T]): untyped =
  when sizeof(T) == 1:
    cast[ptr char](unsafeaddr x[0])

  elif sizeof(T) == 2:
    cast[ptr WCHAR](unsafeaddr x[0])

template getptr[T](x: ptr UncheckedArray[T]): untyped =
  when sizeof(T) == 1:
    cast[ptr char](unsafeaddr x[0])

  elif sizeof(T) == 2:
    cast[ptr WCHAR](unsafeaddr x[0])

proc `UTF8->wstring`(source: openArray[byte|char]): wstring {.inline.} =
  `UTF8->wstring`(source.getptr, source.len)

proc `ANSI->wstring`(source: openArray[byte|char]): wstring {.inline.} =
  `ANSI->wstring`(source.getptr, source.len)

proc `UNICODE->wstring`(source: openArray[WCHAR]): wstring {.inline.} =
  `UNICODE->wstring`(source.getptr, source.len)

proc `UTF8->mstring`(source: openArray[byte|char]): mstring {.inline.} =
  `UTF8->mstring`(source.getptr, source.len)

proc `ANSI->mstring`(source: openArray[byte|char]): mstring {.inline.} =
  `ANSI->mstring`(source.getptr, source.len)

proc `UNICODE->mstring`(source: openArray[WCHAR]): mstring {.inline.} =
  `UNICODE->mstring`(source.getptr, source.len)

proc `UTF8->string`(source: openArray[byte|char]): string {.inline.} =
  `UTF8->string`(source.getptr, source.len)

proc `ANSI->string`(source: openArray[byte|char]): string {.inline.} =
  `ANSI->string`(source.getptr, source.len)

proc `UNICODE->string`(source: openArray[WCHAR]): string {.inline.} =
  `UNICODE->string`(source.getptr, source.len)

# wstring functions

proc high*(s: wstring): int {.inline.} = s.len - 1
  ## Returns the highest possible index of `wstring`.

proc low*(s: wstring): int {.inline.} = 0
  ## Returns the lowest possible index of `wstring`.

proc cmp*(x, y: wstring): int {.borrow.}
  ## Compare proc for `wstring` (in binary format only).

proc `==`*(x, y: wstring): bool {.borrow.}
  ## Checks for equality between two `wstring`.

proc `<=`*(x, y: wstring): bool {.borrow.}
  ## Lexicographic ``<=`` operator for `wstring`.

proc `<`*(x, y: wstring): bool {.borrow.}
  ## Lexicographic ``<`` operator for `wstring`.

proc substr*(s: wstring, first, last: int): wstring =
  ## Copies a slice of `s` into a new `wstring` and returns it.
  result = wstring(string(s).substr(first * 2, last * 2 + 3))
  if result.len != 0:
    result.raw(result.len) = 0

  else:
    result = newWString(0)

proc substr*(s: wstring, first = 0): wstring {.inline.} =
  ## Copies a slice of `s` into a new `wstring` and returns it.
  result = s.substr(first, s.high)

proc `[]`*(s: wstring, i: int): WCHAR {.inline.} =
  ## Index operator for `wstring`.
  when compileOption("boundChecks"):
    if i >= s.len:
      raise newException(IndexDefect, "index out of bounds")

  result = s.raw(i)

proc `[]=`*(s: var wstring, i: int, c: WCHAR|char) {.inline.} =
  ## Index assignment operator for `wstring`.
  when compileOption("boundChecks"):
    if i >= s.len:
      raise newException(IndexDefect, "index out of bounds")

  s.raw(i) = WCHAR c

proc `[]`*[T, U](s: wstring, x: HSlice[T, U]): wstring =
  ## Slice operation for `wstring`.
  let a = s ^^ x.a
  let L = (s ^^ x.b) - a + 1
  when compileOption("boundChecks"):
    if a < 0 or a + L > s.len:
      raise newException(IndexDefect, "index out of bounds")
  result = s.substr(a, a + L-1)

proc `[]=`*[T, U](s: var wstring, x: HSlice[T, U], b: wstring) =
  ## Slice assignment for `wstring`.
  let a = s ^^ x.a
  let L = (s ^^ x.b) - a + 1
  if L == b.len:
    for i in 0 ..< L: s[i+a] = b[i]
  else:
    var slen = s.len
    var shift = b.len - L
    var newLen = slen + shift
    if shift > 0:
      setLen(s, newLen)
      for i in countdown(newLen-1, a+shift+1): s[i] = s[i-shift]
    else:
      for i in countup(a+b.len, s.len-1+shift): s[i] = s[i-shift]
      setLen(s, newLen)
    for i in 0 ..< b.len: s[i+a] = b[i]

    s.raw(s.len) = 0

proc add*(s: var wstring, c: char|WCHAR) =
  ## Appends `c` to `s` in place.
  s.raw(s.len) = WCHAR c
  string(s).add "\0\0"

proc add*(s: var wstring, u: wstring) =
  ## Appends `u` to `s` in place.
  setLen(string(s), string(s).len - 2)
  string(s).add(string(u))

proc `&`*(s: wstring, c: WCHAR|char): wstring {.inline.} =
  ## Concatenates `s` with `c`.
  result = s
  result.add c

proc `&`*(s, u: wstring): wstring {.inline.} =
  ## Concatenates `s` with `u`.
  result = s
  result.add u

proc toHex*(s: wstring): string {.inline.} =
  ## Converts `wstring` to its hexadecimal representation.
  ## No prefix like ``0x`` is generated.
  result = toHex(&s, s.len * 2)

iterator items*(s: wstring): WCHAR =
  ## Iterates over each `WCHAR` of `wstring`.
  var i = 0
  while i < s.len:
    yield s.raw(i)
    inc i

iterator mitems*(s: var wstring): var WCHAR =
  ## Iterates over each `WCHAR` of `wstring` so that you can modify the yielded value.
  var i = 0
  while i < s.len:
    yield s.raw(i)
    inc i

iterator pairs*(s: wstring): tuple[key: int, val: WCHAR] =
  ## Iterates over each `WCHAR` of `wstring`. Yields `(int, WCHAR)` pairs.
  var i = 0
  while i < s.len:
    yield (i, s.raw(i))
    inc i

iterator mpairs*(s: var wstring): tuple[key: int, val: var WCHAR] =
  ## Iterates over each `WCHAR` of `wstring`. Yields `(int, var WCHAR)` pairs.
  var i = 0
  while i < s.len:
    yield (i, s.raw(i))
    inc i

proc repr*(s: wstring): string =
  ## Returns string representation of `wstring`.
  result = $cast[int](&s).tohex & "(wstring)\""
  if s.len != 0:
    for w in s:
      if w == 0:
        result.add "\\0"

      else:
        result.add `UNICODE->string`(w.unsafeaddr, 1)

  result.add  "\""

# mstring functions

proc mlen*(s: mstring): int =
  ## Returns the length of `mstring`, counting by MBCS characters.
  result = int MultiByteToWideChar(CP_ACP, 0, &s, int32 s.len, nil, 0)

proc high*(s: mstring): int {.borrow.}
  ## Returns the highest possible index of `mstring`.

proc low*(s: mstring): int {.borrow.}
  ## Returns the lowest possible index of `mstring`.

proc cmp*(x, y: mstring): int {.borrow.}
  ## Compare proc for `mstring` (in binary format only).

proc `==`*(x, y: mstring): bool {.borrow.}
  ## Checks for equality between two `mstring`.

proc `<=`*(x, y: mstring): bool {.borrow.}
  ## Lexicographic ``<=`` operator for `mstring`.

proc `<`*(x, y: mstring): bool {.borrow.}
  ## Lexicographic ``<`` operator for `mstring`.

proc substr*(s: mstring, first, last: int): mstring {.borrow.}
  ## Copies a slice of `s` into a new `mstring` and returns it, counting by bytes.

proc substr*(s: mstring, first = 0): mstring {.borrow.}
  ## Copies a slice of `s` into a new `mstring` and returns it, counting by bytes.

proc `[]`*(s: mstring, i: int): char {.inline.} = string(s)[i]
  ## Index operator for `mstring`, counting by bytes.

proc `[]=`*(s: var mstring, i: int, x: char|byte) {.inline.} = string(s)[i] = cast[char](x)
  ## Index assignment operator for `mstring`, counting by bytes.

proc substr*(s: mstring, first, last: mIndex): mstring =
  ## Copies a slice of `s` into a new `mstring` and returns it, counting by MBCS characters.
  var ws = `ANSI->wstring`(&s, s.len)
  ws = ws.substr(int first, int last)
  result = `UNICODE->mstring`(&ws, ws.len)

proc substr*(s: mstring, first: mIndex = 0.mIndex): mstring =
  ## Copies a slice of `s` into a new `mstring` and returns it, counting by MBCS characters.
  var ws = `ANSI->wstring`(&s, s.len)
  ws = ws.substr(int first)
  result = `UNICODE->mstring`(&ws, ws.len)

proc `[]`*(s: mstring, i: mIndex): mstring =
  ## Index operator for `mstring`, counting by MBCS characters.
  let ws = `ANSI->wstring`(&s, s.len)
  var wchar = ws[int i]
  result = `UNICODE->mstring`(addr wchar, 1)

proc `[]=`*(s: var mstring, i: mIndex, u: mstring) =
  ## Index assignment operator for `mstring`, counting by MBCS characters,
  ## and only first MBCS characters of `u` will be used.
  var ws = `ANSI->wstring`(&s, s.len)
  let wu = `ANSI->wstring`(&u, u.len)

  if wu.len == 0:
    ws[int i] = 0

  else:
    ws[int i] = wu[0]

  s = `UNICODE->mstring`(&ws, ws.len)

proc `[]`*[T, U](s: mstring, x: HSlice[T, U]): mstring =
  ## Slice operation for `mstring`.
  when T is mIndex or U is mIndex:
    var ws = `[]`(`ANSI->wstring`(&s, s.len), x)
    result = `UNICODE->mstring`(&ws, ws.len)

  else:
    result = mstring(`[]`(string(s), x))

proc `[]=`*[T, U](s: var mstring, x: HSlice[T, U], u: mstring) =
  ## Slice assignment for `mstrings`.
  when T is mIndex or U is mIndex:
    var ws = `ANSI->wstring`(&s, s.len)
    `[]=`(ws, x, `ANSI->wstring`(&u, u.len))
    s = `UNICODE->mstring`(&ws, ws.len)
  else:
    `[]=`(string(s), x, string(u))

proc add*(x: var mstring, y: char) {.borrow.}
  ## Appends `y` to `x` in place.

proc add*(x: var mstring, y: string) {.borrow.}
  ## Appends `y` to `x` in place.

proc add*(x: var mstring, y: mstring) {.borrow.}
  ## Appends `y` to `x` in place.

proc add*(x: var mstring, y: byte) {.inline.} = x.add(char(y))
  ## Appends `y` to `x` in place.

proc `&`*(x: mstring, y: char): mstring {.borrow.}
  ## Concatenates `x` with `y`.

proc `&`*(x, y: mstring): mstring {.borrow.}
  ## Concatenates `x` with `y`.

proc `&`*(x: char, y: mstring): mstring {.borrow.}
  ## Concatenates `x` with `y`.

proc toHex*(s: mstring): string {.inline.} =
  ## Converts `mstring` to its hexadecimal representation.
  ## No prefix like ``0x`` is generated.
  result = toHex(&s, s.len)

iterator items*(s: mstring): mstring =
  ## Iterates over each MBCS character of `mstring`.
  var ws = `ANSI->wstring`(&s, s.len)
  for wchar in ws.mitems:
    yield `UNICODE->mstring`(addr wchar, 1)

iterator pairs*(s: mstring): tuple[key: mIndex, val: mstring] =
  ## Iterates over each MBCS character of `mstring`. Yields `(mIndex, mstring)` pairs.
  var ws = `ANSI->wstring`(&s, s.len)
  for i, wchar in ws.mpairs:
    yield (mIndex i, `UNICODE->mstring`(addr wchar, 1))

proc repr*(s: mstring): string =
  ## Returns string representation of `mstring`.
  result = $cast[int](&s).tohex & "(mstring)\""
  if s.len != 0:
    for m in s:
      if m[0] == '\0':
        result.add "\\0"

      else:
        result.add `ANSI->string`(&m, m.len)

  result &= "\""

# conversion functions

var isOpenArrayStringable {.threadvar.}: bool

proc setOpenArrayStringable*(flag: bool): bool {.inline, discardable.} =
  ## Nim's system.`$` will return array representation for `openArray[SomeChar]`.
  ## After turn this option on, winstr will overwrite the defualt behavior
  ## for `$` and treats `openArray[SomeChar]` as string.
  result = isOpenArrayStringable
  isOpenArrayStringable = flag

proc `$`*(s: Stringable): string {.inline.} =
  ## Convert any stringable type to `string`.
  ## This operator assume `string|cstring|ptr char|openArray[char]` is utf8 encoding.
  when s is char|byte: system.`$`(s)
  elif s is WCHAR: system.`$`(s)
  elif s is string: s
  elif s is mstring: `ANSI->string`(&s, s.len)
  elif s is wstring: `UNICODE->string`(&s, s.len)
  elif s is cstring|ptr char|ptr byte: system.`$`(cast[cstring](s))
  elif s is ptr WCHAR: `UNICODE->string`(s, lstrlenW(s))
  elif s is BSTR: `UNICODE->string`(s, int SysStringLen(s))
  elif s is array|seq|openArray:
    if isOpenArrayStringable:
      when sizeof(s[0]) == 1: `UTF8->string`(s)
      elif sizeof(s[0]) == 2: `UNICODE->string`(s)
      else: {.fatal: "invalid type".}
    else:
      system.`$`(s)
  elif s is ptr array:
    when sizeof(s[][0]) == 1: `UTF8->string`(s[])
    elif sizeof(s[][0]) == 2: `UNICODE->string`(s[])
    else: {.fatal: "invalid type".}
  elif s is ptr UncheckedArray:
    when sizeof(s[0]) == 1: `UTF8->string`(s.getptr, lstrlenA(s.getptr))
    elif sizeof(s[0]) == 2: `UNICODE->string`(s.getptr, lstrlenW(s.getptr))
    else: {.fatal: "invalid type".}
  else: {.fatal: "invalid type".}

proc `%$`*(s: Stringable): string {.inline.} =
  ## Convert any stringable type to `string`. Always treat `openArray[SomeChar]` as string.
  ## This operator assume `string|cstring|ptr char|openArray[char]` is utf8 encoding.
  when s is char|byte: system.`$`(s)
  elif s is WCHAR: `UNICODE->string`(unsafeaddr s, 1)
  elif s is string: s
  elif s is mstring: `ANSI->string`(&s, s.len)
  elif s is wstring: `UNICODE->string`(&s, s.len)
  elif s is cstring|ptr char|ptr byte: system.`$`(cast[cstring](s))
  elif s is ptr WCHAR: `UNICODE->string`(s, lstrlenW(s))
  elif s is BSTR: `UNICODE->string`(s, int SysStringLen(s))
  elif s is array|seq|openArray:
    when sizeof(s[0]) == 1: `UTF8->string`(s)
    elif sizeof(s[0]) == 2: `UNICODE->string`(s)
    else: {.fatal: "invalid type".}
  elif s is ptr array:
    when sizeof(s[][0]) == 1: `UTF8->string`(s[])
    elif sizeof(s[][0]) == 2: `UNICODE->string`(s[])
    else: {.fatal: "invalid type".}
  elif s is ptr UncheckedArray:
    when sizeof(s[0]) == 1: `UTF8->string`(s.getptr, lstrlenA(s.getptr))
    elif sizeof(s[0]) == 2: `UNICODE->string`(s.getptr, lstrlenW(s.getptr))
    else: {.fatal: "invalid type".}
  else: {.fatal: "invalid type".}

proc `+$`*(s: Stringable): wstring {.inline.} =
  ## Convert any stringable type to `wstring`.
  ## This operator assume `string|cstring|ptr char|openArray[char]` is utf8 encoding.
  when s is char|byte: `UTF8->wstring`(cast[ptr char](unsafeaddr s), 1)
  elif s is WCHAR: `UNICODE->wstring`(unsafeaddr s, 1)
  elif s is string: `UTF8->wstring`(&s, s.len)
  elif s is mstring: `ANSI->wstring`(&s, s.len)
  elif s is wstring: s
  elif s is cstring|ptr char|ptr byte: `UTF8->wstring`(cast[ptr char](s), cast[cstring](s).len)
  elif s is ptr WCHAR: `UNICODE->wstring`(s, lstrlenW(s))
  elif s is BSTR: `UNICODE->wstring`(s, int SysStringLen(s))
  elif s is array|seq|openArray:
    when sizeof(s[0]) == 1: `UTF8->wstring`(s)
    elif sizeof(s[0]) == 2: `UNICODE->wstring`(s)
    else: {.fatal: "invalid type".}
  elif s is ptr array:
    when sizeof(s[][0]) == 1: `UTF8->wstring`(s[])
    elif sizeof(s[][0]) == 2: `UNICODE->wstring`(s[])
    else: {.fatal: "invalid type".}
  elif s is ptr UncheckedArray:
    when sizeof(s[0]) == 1: `UTF8->wstring`(s.getptr, lstrlenA(s.getptr))
    elif sizeof(s[0]) == 2: `UNICODE->wstring`(s.getptr, lstrlenW(s.getptr))
    else: {.fatal: "invalid type".}
  else: {.fatal: "invalid type".}

proc `-$`*(s: Stringable): mstring {.inline.} =
  ## Convert any stringable type to `mstring`.
  ## This operator assume `string|cstring|ptr char|openArray[char]` is utf8 encoding.
  when s is char|byte: `UTF8->mstring`(cast[ptr char](unsafeaddr s), 1)
  elif s is WCHAR: `UNICODE->mstring`(unsafeaddr s, 1)
  elif s is string: `UTF8->mstring`(&s, s.len)
  elif s is mstring: s
  elif s is wstring: `UNICODE->mstring`(&s, s.len)
  elif s is cstring|ptr char|ptr byte: `UTF8->mstring`(cast[ptr char](s), cast[cstring](s).len)
  elif s is ptr WCHAR: `UNICODE->mstring`(s, lstrlenW(s))
  elif s is BSTR: `UNICODE->mstring`(s, int SysStringLen(s))
  elif s is array|seq|openArray:
    when sizeof(s[0]) == 1: `UTF8->mstring`(s)
    elif sizeof(s[0]) == 2: `UNICODE->mstring`(s)
    else: {.fatal: "invalid type".}
  elif s is ptr array:
    when sizeof(s[][0]) == 1: `UTF8->mstring`(s[])
    elif sizeof(s[][0]) == 2: `UNICODE->mstring`(s[])
    else: {.fatal: "invalid type".}
  elif s is ptr UncheckedArray:
    when sizeof(s[0]) == 1: `UTF8->mstring`(s.getptr, lstrlenA(s.getptr))
    elif sizeof(s[0]) == 2: `UNICODE->mstring`(s.getptr, lstrlenW(s.getptr))
    else: {.fatal: "invalid type".}
  else: {.fatal: "invalid type".}

proc `$$`*(s: Stringable): string {.inline.} =
  ## Convert any stringable type to `string`.
  ## This operator assume `string|cstring|ptr char|openArray[char]` is ansi encoding.
  # Only exception is `WCHAR(uint16)`: regard as number in `$`, but string in `$$`
  when s is WCHAR: `UNICODE->string`(unsafeaddr s, 1)
  elif s is string: `ANSI->string`(&s, s.len)
  elif s is cstring|ptr char|ptr byte: `ANSI->string`(cast[ptr char](s), cast[cstring](s).len)
  elif s is array|seq|openArray:
    when sizeof(s[0]) == 1: `ANSI->string`(s)
    elif sizeof(s[0]) == 2: `UNICODE->string`(s)
  elif s is ptr array:
    when sizeof(s[][0]) == 1: `ANSI->string`(s[])
    else: `$`(s)
  elif s is ptr UncheckedArray:
    when sizeof(s[0]) == 1: `ANSI->string`(s.getptr, lstrlenA(s.getptr))
    else: `$`(s)
  else: `$`(s)

proc `+$$`*(s: Stringable): wstring {.inline.} =
  ## Convert any stringable type to `wstring`.
  ## This operator assume `string|cstring|ptr char|openArray[char]` is ansi encoding.
  when s is string: `ANSI->wstring`(&s, s.len)
  elif s is cstring|ptr char|ptr byte: `ANSI->wstring`(cast[ptr char](s), cast[cstring](s).len)
  elif s is array|seq|openArray:
    when sizeof(s[0]) == 1: `ANSI->wstring`(s)
    else: `+$`(s)
  elif s is ptr array:
    when sizeof(s[][0]) == 1: `ANSI->wstring`(s[])
    else: `+$`(s)
  elif s is ptr UncheckedArray:
    when sizeof(s[0]) == 1: `ANSI->wstring`(s.getptr, lstrlenA(s.getptr))
    else: `+$`(s)
  else: `+$`(s)

proc `-$$`*(s: Stringable): mstring {.inline.} =
  ## Convert any stringable type to `mstring`.
  ## This operator assume `string|cstring|ptr char|openArray[char]` is ansi encoding.
  when s is string: `ANSI->mstring`(&s, s.len)
  elif s is cstring|ptr char|ptr byte: `ANSI->mstring`(cast[ptr char](s), cast[cstring](s).len)
  elif s is array|seq|openArray:
    when sizeof(s[0]) == 1: `ANSI->mstring`(s)
    else: `-$`(s)
  elif s is ptr array:
    when sizeof(s[][0]) == 1: `ANSI->mstring`(s[])
    else: `-$`(s)
  elif s is ptr UncheckedArray:
    when sizeof(s[0]) == 1: `ANSI->mstring`(s.getptr, lstrlenA(s.getptr))
    else: `-$`(s)
  else: `-$`(s)

proc fillBuffer[T: SomeChar](a: var openArray[T], s: SomeString, skip = 0, inclNull = false) =
  when sizeof(a[0]) != sizeof(s[0]):
    {.fatal: "type mismatch".}

  for i in 0 .. min(a.high, s.len - skip - 1):
    a[i] = cast[T](s[i + skip])

  if inclNull and a.high >= s.len:
    a[s.len - skip] = cast[T](0)

  # fill as much as possible before raise an exception
  if (not inclNull and a.high < s.len - skip - 1) or (inclNull and a.high < s.len - skip):
    raise newException(IndexDefect, "string length too long")

proc fillString[T: SomeChar](s: var SomeString, a: openArray[T], skip = 0) =
  when sizeof(a[0]) != sizeof(s[0]):
    {.fatal: "type mismatch".}

  for i in 0 .. min(a.high, s.len - skip - 1):
    s[i + skip] = cast[s[0].type](a[i])

template `<<`*[A: SomeBuffer|SomeString, B: SomeBuffer|SomeString](a: A, b: B) =
  ## Fill operator for `SomeBuffer` and `SomeString`.
  ## Please make sure both side have the same character size.
  ## If destination don't have the length information (e.g. `pointer` or `UncheckedArray`),
  ## please make sure the buffer size is large enough.
  when A is SomeString and B is SomeString:
    # treat string a as buffer
    var v = cast[ptr UncheckedArray[a[0].type]](&a)
    fillBuffer(v.toOpenArray(0, a.len - 1), b, inclNull=false)

  elif A is not SomeString and B is SomeString:
    when A is array:
      fillBuffer(a.toOpenArray(a.low, a.high), b, skip=a.low, inclNull=false)

    elif A is ptr array:
      fillBuffer(a[].toOpenArray(a[].low, a[].high), b, skip=a[].low, inclNull=false)

    elif A is ptr char | ptr byte:
      var v = cast[ptr UncheckedArray[byte]](a)
      fillBuffer(v.toOpenArray(0, int.high - 1), b, inclNull=false)

    elif A is ptr WCHAR:
      var v = cast[ptr UncheckedArray[WCHAR]](a)
      fillBuffer(v.toOpenArray(0, int.high - 1), b, inclNull=false)

    elif A is ptr UncheckedArray:
      var v = a
      fillBuffer(v.toOpenArray(0, int.high - 1), b, inclNull=false)

    elif A is openArray | seq:
      fillBuffer(a, b, inclNull=false)

    else:
      {.fatal: "type mismatch".}

  elif A is SomeString and B is not SomeString:
    when B is array:
      fillString(a, b.toOpenArray(b.low, b.high), skip=b.low)

    elif B is ptr array:
      fillString(a, b[].toOpenArray(b[].low, b[].high), skip=b[].low)

    elif B is ptr char | ptr byte:
      fillString(a, cast[ptr UncheckedArray[byte]](b).toOpenArray(0, int.high - 1))

    elif B is ptr WCHAR:
      fillString(a, cast[ptr UncheckedArray[WCHAR]](b).toOpenArray(0, int.high - 1))

    elif B is ptr UncheckedArray:
      fillString(a, b.toOpenArray(0, int.high - 1))

    elif B is openArray | seq:
      fillString(a, b)

    else:
      {.fatal: "type mismatch".}

  else:
    {.fatal: "type mismatch".}

template `<<<`*[A: SomeBuffer|SomeString](a: A, b: SomeString) =
  ## Fill buffer by string, include a null.
  ## Please make sure both side have the same character size.
  ## If destination don't have the length information (e.g. `pointer` or `UncheckedArray`),
  ## please make sure the buffer size is large enough.
  when A is SomeString:
    # treat string a as buffer
    var v = cast[ptr UncheckedArray[a[0].type]](&a)
    fillBuffer(v.toOpenArray(0, a.len - 1), b, inclNull=true)

  else:
    when A is array:
      fillBuffer(a.toOpenArray(a.low, a.high), b, skip=a.low, inclNull=true)

    elif A is ptr array:
      fillBuffer(a[].toOpenArray(a[].low, a[].high), b, skip=a[].low, inclNull=true)

    elif A is ptr char | ptr byte:
      var v = cast[ptr UncheckedArray[byte]](a)
      fillBuffer(v.toOpenArray(0, int.high - 1), b, inclNull=true)

    elif A is ptr WCHAR:
      var v = cast[ptr UncheckedArray[WCHAR]](a)
      fillBuffer(v.toOpenArray(0, int.high - 1), b, inclNull=true)

    elif A is ptr UncheckedArray:
      var v = a
      fillBuffer(v.toOpenArray(0, int.high - 1), b, inclNull=true)

    elif A is openArray | seq:
      fillBuffer(a, b, inclNull=true)

    else:
      {.fatal: "type mismatch".}

template `>>`*(a: typed, b: typed) =
  ## This is the same as `b << a`.
  b << a

template `>>>`*(a: typed, b: typed) =
  ## This is the same as `b <<< a`.
  b <<< a

proc nullTerminate*(s: var SomeString) {.inline.} =
  ## Assume a string is null terminated and set the correct length.
  when s is string|mstring:
    let L = lstrlenA(cast[LPCSTR](&s))
    if L < s.len:
      s.setLen(L)

  elif s is wstring:
    let L = lstrlenW(cast[LPWSTR](&s))
    if L < s.len:
      s.setLen(L)

  else: {.fatal: "invalid type".}

proc nullTerminated*[T: SomeString](s: T): T {.inline.} =
  ## Assume a string is null terminated and return the length-corrected string.
  when s is string:
    result = newString(lstrlenA(cast[LPCSTR](&s)))
    result << &s

  elif s is mstring:
    result = newMString(lstrlenA(cast[LPCSTR](&s)))
    result << &s

  elif s is wstring:
    result = newWString(lstrlenW(cast[LPWSTR](&s)))
    result << &s

  else: {.fatal: "invalid type".}

# generics has problems on converters, define one by one

converter winstrConverterWStringToLPWSTR*(x: wstring): LPWSTR = cast[LPWSTR](&x)
  ## Converts `wstring` to `LPWSTR` automatically.

converter winstrConverterWStringToBSTR*(x: wstring): BSTR = cast[BSTR](&x)
  ## Converts `wstring` to `BSTR` automatically.

converter winstrConverterBSTRToLPWSTR*(x: BSTR): LPWSTR = cast[LPWSTR](x)
  ## Converts `BSTR` to `LPWSTR` automatically.

converter winstrConverterStringToPtrChar*(x: string): ptr char = cast[ptr char](&x)
  ## Converts `string` to `ptr char` automatically.

converter winstrConverterCStringToPtrChar*(x: cstring): ptr char = cast[ptr char](x)
  ## Converts `cstring` to `ptr char` automatically.

converter winstrConverterMStringToPtrChar*(x: mstring): ptr char = cast[ptr char](&x)
  ## Converts `mstring` to `ptr char` automatically.

converter winstrConverterMStringToLPSTR*(x: mstring): LPSTR = cast[LPSTR](&x)
  ## Converts `mstring` to `LPSTR` automatically.

when defined(gcDestructors):
  converter winstrConverterWideCStringToLPWSTR*(x: WideCStringObj): LPWSTR = cast[LPWSTR](x[0].unsafeaddr)
    ## Converts `WideCString` to `LPWSTR` automatically.

  converter winstrConverterWideCStringToWString*(x: WideCStringObj): wstring = +$cast[LPWSTR](x[0].unsafeaddr)
    ## Converts `WideCString` to `wstring` automatically.

  converter winstrConverterWStringToWideCString*(x: wstring): WideCStringObj = newWideCString($x)
    ## Converts `wstring` to `WideCString` automatically.

else:
  converter winstrConverterWideCStringToLPWSTR*(x: WideCString): LPWSTR = cast[LPWSTR](x[0].unsafeaddr)
    ## Converts `WideCString` to `LPWSTR` automatically.

  converter winstrConverterWideCStringToWString*(x: WideCString): wstring = +$cast[LPWSTR](x[0].unsafeaddr)
    ## Converts `WideCString` to `wstring` automatically.

  converter winstrConverterWStringToWideCString*(x: wstring): WideCString = newWideCString($x)
    ## Converts `wstring` to `WideCString` automatically.

when defined(gcDestructors):
  # Here is the workaround for --gc:arc and --newruntime. It is a tricky problem,
  # wstring needs to be alive until converter ending so that the windows API can
  # use the pointer later.

  import deques
  var wstringQueue {.threadvar.}: Deque[wstring]
  var wstringQueueInit {.threadvar.}: bool

  proc saddr(str: sink wstring): LPWSTR =
    if not wstringQueueInit:
      wstringQueue = initDeque[wstring]()
      wstringQueueInit = true

    elif wstringQueue.len > 128:
      wstringQueue.shrink(fromFirst=64)

    wstringQueue.addLast str
    &wstringQueue[^1]

  converter winstrConverterStringToLPWSTR*(x: string): LPWSTR = saddr(+$x)
    ## Converts `string` to `LPWSTR` automatically.

  converter winstrConverterCStringToLPWSTR*(x: cstring): LPWSTR = saddr(+$x)
    ## Converts `cstring` to `LPWSTR` automatically.

  converter winstrConverterStringToBSTR*(x: string): BSTR = cast[BSTR](saddr(+$x))
    ## Converts `string` to `BSTR` automatically.

  converter winstrConverterCStringToBSTR*(x: cstring): BSTR = cast[BSTR](saddr(+$x))
    ## Converts `cstring` to `BSTR` automatically.

else:
  converter winstrConverterStringToLPWSTR*(x: string): LPWSTR = cast[LPWSTR](&(+$x))
    ## Converts `string` to `LPWSTR` automatically.

  converter winstrConverterCStringToLPWSTR*(x: cstring): LPWSTR = cast[LPWSTR](&(+$x))
    ## Converts `cstring` to `LPWSTR` automatically.

  converter winstrConverterStringToBSTR*(x: string): BSTR = cast[BSTR](&(+$x))
    ## Converts `string` to `BSTR` automatically.

  converter winstrConverterCStringToBSTR*(x: cstring): BSTR = cast[BSTR](&(+$x))
    ## Converts `cstring` to `BSTR` automatically.

proc newWString*(s: cstring|string|mstring): wstring {.inline,
    deprecated: "use `+$` instead".} =
  ## Return a new `wstring`.
  result = +$s

proc newMString*(s: string|cstring|wstring): mstring {.inline,
  deprecated: "use `-$` instead".} =
  ## Return a new `mstring`.
  result = -$s

proc ctNewWString(s: static[string]): wstring {.compiletime.} =
  # copy from widestrs.nim, use WCHAR instead of Utf16Char
  const
    UNI_REPLACEMENT_CHAR = WCHAR(0xFFFD'u16)
    UNI_MAX_BMP = 0x0000FFFF
    UNI_MAX_UTF16 = 0x0010FFFF

    halfShift = 10
    halfBase = 0x0010000
    halfMask = 0x3FF

    UNI_SUR_HIGH_START = 0xD800
    UNI_SUR_LOW_START = 0xDC00
    UNI_SUR_LOW_END = 0xDFFF
    UNI_REPL = 0xFFFD

  template ones(n: untyped): untyped = ((1 shl n)-1)

  template fastRuneAt(s: cstring, i, L: int, result: untyped, doInc = true) =
    if ord(s[i]) <= 127:
      result = ord(s[i])
      when doInc: inc(i)
    elif ord(s[i]) shr 5 == 0b110:
      if i <= L - 2:
        result = (ord(s[i]) and (ones(5))) shl 6 or (ord(s[i+1]) and ones(6))
        when doInc: inc(i, 2)
      else:
        result = UNI_REPL
        when doInc: inc(i)
    elif ord(s[i]) shr 4 == 0b1110:
      if i <= L - 3:
        result = (ord(s[i]) and ones(4)) shl 12 or
                 (ord(s[i+1]) and ones(6)) shl 6 or
                 (ord(s[i+2]) and ones(6))
        when doInc: inc(i, 3)
      else:
        result = UNI_REPL
        when doInc: inc(i)
    elif ord(s[i]) shr 3 == 0b11110:
      if i <= L - 4:
        result = (ord(s[i]) and ones(3)) shl 18 or
                 (ord(s[i+1]) and ones(6)) shl 12 or
                 (ord(s[i+2]) and ones(6)) shl 6 or
                 (ord(s[i+3]) and ones(6))
        when doInc: inc(i, 4)
      else:
        result = UNI_REPL
        when doInc: inc(i)
    else:
      result = 0xFFFD
      when doInc: inc(i)

  iterator runes(s: cstring, L: int): int =
    var
      i = 0
      ret: int

    while i < L:
      fastRuneAt(s, i, L, ret, true)
      yield ret

  iterator WCHARs(source: cstring, L: int): WCHAR =
    for ch in runes(source, L):
      if ch <=% UNI_MAX_BMP:
        if ch >=% UNI_SUR_HIGH_START and ch <=% UNI_SUR_LOW_END:
          yield UNI_REPLACEMENT_CHAR
        else:
          yield WCHAR(ch)
      elif ch >% UNI_MAX_UTF16:
        yield UNI_REPLACEMENT_CHAR
      else:
        let ch = ch -% halfBase
        yield WCHAR((ch shr halfShift) +% UNI_SUR_HIGH_START)
        yield WCHAR((ch and halfMask) +% UNI_SUR_LOW_START)

  var ret: string
  for u in WCHARs(s, s.len):
    ret.add char(u and 0xFF)
    ret.add char(u shr 8)

  ret.add "\0\0"
  result = wstring ret

template L*(x: static[string]): wstring =
  ## Generate const wstring from `static[string]` at compile-time.
  const wstr = ctNewWString(x)
  wstr

template L*(x: string): wstring = +$x
  ## Same as `+$` for dynamic string (string at run-time).

template T*(x: string): untyped =
  ## Generate wstring or mstring depend on conditional symbol: `useWinAnsi`.
  # must export winimbase to use winimAnsi here.
  when winimAnsi:
    -$x
  else:
    L(x)

template T*(x: Natural): untyped =
  ## Generate wstring or mstring buffer depend on conditional symbol: `useWinAnsi`.
  ## Use `&` to get the buffer address and then pass to Windows API.
  when winimAnsi:
    newMString(x)
  else:
    newWString(x)

when winimAnsi:
  type
    TString* = mstring ## `wstring` or `mstring` depend on conditional symbol: `useWinAnsi`.
else:
  type
    TString* = wstring ## `wstring` or `mstring` depend on conditional symbol: `useWinAnsi`.

when isMainModule:
  let str = "the quick brown fox jumps over the lazy dog"
  echo +$str == L"the quick brown fox jumps over the lazy dog"
