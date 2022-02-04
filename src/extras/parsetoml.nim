## :License: MIT
##
## Introduction
## ============
## This module implements a TOML parser that is compliant with v0.5.0 of its spec.
##
## Source
## ======
## `Repo link <https://github.com/NimParsers/parsetoml>`_
##

# Copyright (c) 2015 Maurizio Tomasi and contributors
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import math
import streams
import strutils
import tables
import unicode
export tables

type
  Sign* = enum None, Pos, Neg

  TomlValueKind* {.pure.} = enum
    None
    Int,
    Float,
    Bool,
    Datetime,
    Date,
    Time,
    String,
    Array,
    Table

  TomlDate* = object
    year*: int
    month*: int
    day*: int

  TomlTime* = object
    hour*: int
    minute*: int
    second*: int
    subsecond*: int

  TomlDateTime* = object
    date*: TomlDate
    time*: TomlTime
    case shift*: bool
    of true:
      isShiftPositive*: bool
      zoneHourShift*: int
      zoneMinuteShift*: int
    of false: nil

  TomlTable* = OrderedTable[string, TomlValueRef]
  TomlTableRef* = ref TomlTable

  TomlValueRef* = ref TomlValue
  TomlValue* = object
    case kind*: TomlValueKind
    of TomlValueKind.None: nil
    of TomlValueKind.Int: intVal*: int64
    of TomlValueKind.Float:
      floatVal*: float64
      forcedSign*: Sign
    of TomlValueKind.Bool: boolVal*: bool
    of TomlValueKind.Datetime: dateTimeVal*: TomlDateTime
    of TomlValueKind.Date: dateVal*: TomlDate
    of TomlValueKind.Time: timeVal*: TomlTime
    of TomlValueKind.String: stringVal*: string
    of TomlValueKind.Array: arrayVal*: seq[TomlValueRef]
    of TomlValueKind.Table: tableVal*: TomlTableRef

  ParserState = object
    fileName*: string
    line*: int
    column*: int
    pushback: char
    stream*: streams.Stream
    curTableRef*: TomlTableRef

  TomlError* = object of Defect
    location*: ParserState

  NumberBase = enum
    base10, base16, base8, base2

  StringType {.pure.} = enum
    Basic,  # Enclosed within double quotation marks
    Literal # Enclosed within single quotation marks

const
  defaultStringCapacity = 256

func newTomlError(location: ParserState, msg: string): ref TomlError =
  result = newException(TomlError, location.fileName & "(" & $location.line &
                        ":" & $location.column & ")" & " " & msg)
  result.location = location

proc getNextChar(state: var ParserState): char =
  # Return the next available char from the stream associate with
  # the parser state, or '\0' if there are no characters left.

  if state.pushback != '\0':
    # If we've just read a character without having interpreted
    # it, just return it
    result = state.pushback
    state.pushback = '\0'
  else:
    if state.stream.atEnd():
      return '\0'

    result = state.stream.readChar()

    # Update the line and column number
    if result == '\l':
      inc(state.line)
      state.column = 1
    elif result != '\r':
      inc(state.column)

func pushBackChar(state: var ParserState, c: char) {.inline.} =
  state.pushback = c

type
  LfSkipMode = enum
    skipLf, skipNoLf

proc getNextNonWhitespace(state: var ParserState,
                          skip: LfSkipMode): char =
  # Note: this procedure does *not* consider a newline as a
  # "whitespace". Since newlines are often mandatory in TOML files
  # (e.g. after a key/value specification), we do not want to miss
  # them...

  let whitespaces = (case skip
                     of skipLf: {' ', '\t', '\r', '\l'}
                     of skipNoLf: {' ', '\t', '\r'})

  var nextChar: char
  while true:
    nextChar = state.getNextChar()
    if nextChar == '#':
      # Skip the comment up to the newline, but do not jump over it
      while nextChar != '\l' and nextChar != '\0':
        nextChar = state.getNextChar()

    if nextChar notin whitespaces: break

  result = nextChar

func charToInt(c: char, base: NumberBase): int {.inline.} =
  case base
  of base10, base8, base2: result = int(c) - int('0')
  of base16:
    if c in strutils.Digits:
      result = charToInt(c, base10)
    else:
      result = 10 + int(toUpperAscii(c)) - int('A')

type
  LeadingChar {.pure.} = enum
    AllowZero, DenyZero

proc parseInt(state: var ParserState,
              base: NumberBase,
              leadingChar: LeadingChar): int64 =
  var
    nextChar: char
    firstPos = true
    negative = false
    wasUnderscore = false

  let
    baseNum = (case base
               of base2: 2
               of base8: 8
               of base10: 10
               of base16: 16)
    digits = (case base
              of base2: {'0', '1'}
              of base8: {'0', '1', '2', '3', '4', '5', '6', '7'}
              of base10: strutils.Digits
              of base16: strutils.HexDigits)

  result = 0
  while true:
    wasUnderscore = nextChar == '_'
    nextChar = state.getNextChar()
    if nextChar == '_':
      if firstPos or wasUnderscore:
        raise(newTomlError(state,
                           "underscore must be surrounded by digit"))
      continue

    if nextChar in {'+', '-'} and firstPos:
      firstPos = false
      if nextChar == '-': negative = true
      continue

    if nextChar == '0' and firstPos and leadingChar == LeadingChar.DenyZero:
      # TOML specifications forbid this
      var upcomingChar = state.getNextChar()
      if upcomingChar in Digits:
        raise(newTomlError(state,
                           "leading zeroes are not allowed in integers"))
      else:
        state.pushBackChar(upcomingChar)

    if nextChar notin digits:
      if wasUnderscore:
        raise(newTomlError(state,
                           "underscore must be surrounded by digit"))
      state.pushBackChar(nextChar)
      break

    try:
      result = result * baseNum - charToInt(nextChar, base)
    except OverflowDefect:
      raise(newTomlError(state,
                         "integer numbers wider than 64 bits not allowed"))

    firstPos = false

  if not negative:
    try:
      result = -result
    except OverflowDefect:
      raise(newTomlError(state,
                         "integer numbers wider than 64 bits not allowed"))

proc parseEncoding(state: var ParserState): TomlValueRef =
  let nextChar = state.getNextChar()
  case nextChar:
    of 'b':
      return TomlValueRef(kind: TomlValueKind.Int, intVal: parseInt(state, base2, LeadingChar.AllowZero))
    of 'o':
      return TomlValueRef(kind: TomlValueKind.Int, intVal: parseInt(state, base8, LeadingChar.AllowZero))
    of 'x':
      return TomlValueRef(kind: TomlValueKind.Int, intVal: parseInt(state, base16, LeadingChar.AllowZero))
    else: raise newTomlError(state, "illegal character")

proc parseDecimalPart(state: var ParserState): float64 =
  var
    nextChar: char
    invPowerOfTen = 10.0
    firstPos = true
    wasUnderscore = false

  result = 0.0
  while true:
    wasUnderscore = nextChar == '_'
    nextChar = state.getNextChar()
    if nextChar == '_':
      if firstPos or wasUnderscore:
        raise(newTomlError(state,
                           "underscore must be surrounded by digit"))
      continue
    if nextChar notin strutils.Digits:
      if wasUnderscore:
        raise(newTomlError(state,
                           "underscore must be surrounded by digit"))
      state.pushBackChar(nextChar)
      if firstPos:
        raise newTomlError(state, "decimal part empty")
      break

    result = result + (int(nextChar) - int('0')).float / invPowerOfTen
    invPowerOfTen *= 10

    firstPos = false


func stringDelimiter(kind: StringType): char {.inline.} =
  result = (case kind
            of StringType.Basic: '\"'
            of StringType.Literal: '\'')

proc parseUnicode(state: var ParserState): string =
  let
    escapeKindChar = state.getNextChar()
    oldState = (column: state.column, line: state.line)
    code = parseInt(state, base16, LeadingChar.AllowZero)
  if state.line != oldState.line:
    raise newTomlError(state, "invalid Unicode codepoint, can't span lines")
  if escapeKindChar == 'u' and state.column - 5 != oldState.column:
    raise newTomlError(state, "invalid Unicode codepoint, 'u' must have " &
                       "four character value")
  if escapeKindChar == 'U' and state.column - 9 != oldState.column:
    raise newTomlError(state, "invalid Unicode codepoint, 'U' must have " &
                       "eight character value")
  if code notin 0'i64..0xD7FF and code notin 0xE000'i64..0x10FFFF:
    raise(newTomlError(state, "invalid Unicode codepoint, " &
                       "must be a Unicode scalar value"))

  return unicode.toUTF8(Rune(code))

proc parseEscapeChar(state: var ParserState, escape: char): string =
  case escape
  of 'b': result = "\b"
  of 't': result = "\t"
  of 'n': result = "\l"
  of 'f': result = "\f"
  of 'r': result = "\r"
  of '\'': result = "\'"
  of '\"': result = "\""
  of '\\': result = "\\"
  of 'u', 'U':
    state.pushBackChar(escape)
    result = parseUnicode(state)
  else:
    raise(newTomlError(state,
                       "unknown escape " &
                       "sequence \"\\" & escape & "\""))

proc parseSingleLineString(state: var ParserState, kind: StringType): string =
  # This procedure parses strings enclosed within single/double
  # quotation marks. It assumes that the quotation mark has already
  # been consumed by the "state" variable, which therefore is ready
  # to read the first character of the string.

  result = newStringOfCap(defaultStringCapacity)

  let delimiter = stringDelimiter(kind)

  var nextChar: char
  while true:
    nextChar = state.getNextChar()
    if nextChar == delimiter:
      break

    if nextChar == '\0':
      raise(newTomlError(state, "unterminated string"))

    if ord(nextChar) in {16, 31, 127}:
      raise(newTomlError(state, "invalid character in string, ord: " & $ord(nextChar)))

    if nextChar == '\\' and kind == StringType.Basic:
      nextChar = state.getNextChar()
      result.add(state.parseEscapeChar(nextChar))
      continue

    result.add(nextChar)

proc parseMultiLineString(state: var ParserState, kind: StringType): string =
  # This procedure parses strings enclosed within three consecutive
  # sigle/double quotation marks. It assumes that all the quotation
  # marks have already been consumed by the "state" variable, which
  # therefore is ready to read the first character of the string.

  result = newStringOfCap(defaultStringCapacity)
  let delimiter = stringDelimiter(kind)
  var
    isFirstChar = true
    nextChar: char
  while true:
    nextChar = state.getNextChar()

    # Skip the first newline, if it comes immediately after the
    # quotation marks
    if isFirstChar and (nextChar == '\l'):
      isFirstChar = false
      continue

    if nextChar == delimiter:
      # Are we done?
      nextChar = state.getNextChar()
      if nextChar == delimiter:
        nextChar = state.getNextChar()
        if nextChar == delimiter:
          # Done with this string
          return
        else:
          # Just got a double delimiter
          result.add(delimiter & delimiter)
          state.pushBackChar(nextChar)
          continue
      else:
        # Just got a lone delimiter
        result.add(delimiter)
        state.pushBackChar(nextChar)
        continue

    if nextChar == '\\' and kind == StringType.Basic:
      # This can either be an escape sequence or a end-of-line char
      nextChar = state.getNextChar()
      if nextChar in {'\l', '\r', ' '}:
        # We're at the end of a line: skip everything till the
        # next non-whitespace character
        while nextChar in {'\l', '\r', ' ', '\t'}:
          nextChar = state.getNextChar()

        state.pushBackChar(nextChar)
        continue
      else:
        # This is just an escape sequence (like "\t")
        #nextChar = state.getNextChar()
        result.add(state.parseEscapeChar(nextChar))
        continue

    if nextChar == '\0':
      raise(newTomlError(state, "unterminated string"))

    if ord(nextChar) in {16, 31, 127}:
      raise(newTomlError(state, "invalid character in string, ord: " & $ord(nextChar)))

    result.add(nextChar)
    isFirstChar = false

proc parseString(state: var ParserState, kind: StringType): string =
  ## This function assumes that "state" has already consumed the
  ## first character (either \" or \', which is passed in the
  ## "openChar" parameter).

  let delimiter = stringDelimiter(kind)
  var nextChar: char = state.getNextChar()
  if nextChar == delimiter:
    # We have two possibilities here: (1) the empty string, or (2)
    # "long" multi-line strings.
    nextChar = state.getNextChar()
    if nextChar == delimiter:
      return parseMultiLineString(state, kind)
    else:
      # Empty string. This was easy!
      state.pushBackChar(nextChar)
      return ""
  else:
    state.pushBackChar(nextChar)
    return parseSingleLineString(state, kind)

# Forward declaration
proc parseValue(state: var ParserState): TomlValueRef
proc parseInlineTable(state: var ParserState): TomlValueRef

proc parseArray(state: var ParserState): seq[TomlValueRef] =
  # This procedure assumes that "state" has already consumed the '['
  # character

  result = newSeq[TomlValueRef](0)

  while true:
    var nextChar: char = state.getNextNonWhitespace(skipLf)
    case nextChar
    of ']':
      return
    of ',':
      if len(result) == 0:
        # This happens with "[, 1, 2]", for instance
        raise(newTomlError(state, "first array element missing"))

      # Check that this is not a terminating comma (like in
      #  "[b,]")
      nextChar = state.getNextNonWhitespace(skipLf)
      if nextChar == ']':
        return

      state.pushBackChar(nextChar)
    else:
      let oldState = state # Saved for error messages
      var newValue: TomlValueRef
      if nextChar != '{':
        state.pushBackChar(nextChar)
        newValue = parseValue(state)
      else:
        newValue = parseInlineTable(state)

      if len(result) > 0:
        # Check that the type of newValue is compatible with the
        # previous ones
        if newValue.kind != result[low(result)].kind:
          raise(newTomlError(oldState,
                             "array members with incompatible types"))

      result.add(newValue)

proc parseStrictNum(state: var ParserState,
                    minVal: int,
                    maxVal: int,
                    count: Slice[int],
                    msg: string): int =
  var
    nextChar: char
    parsedChars = 0

  result = 0
  while true:
    nextChar = state.getNextChar()

    if nextChar notin strutils.Digits:
      state.pushBackChar(nextChar)
      break

    try:
      result = result * 10 + charToInt(nextChar, base10)
      parsedChars += 1
    except OverflowDefect:
      raise(newTomlError(state,
                         "integer numbers wider than 64 bits not allowed"))

  if parsedChars notin count:
    raise(newTomlError(state,
                       "too few or too many characters in digit, expected " &
                       $count & " got " & $parsedChars))

  if result < minVal or result > maxVal:
    raise(newTomlError(state, msg & " (" & $result & ")"))

template parseStrictNum(state: var ParserState,
                    minVal: int,
                    maxVal: int,
                    count: int,
                    msg: string): int =
  parseStrictNum(state, minVal, maxVal, (count..count), msg)

proc parseTimePart(state: var ParserState, val: var TomlTime) =
  var
    nextChar: char
    curLine = state.line

  # Parse the minutes
  val.minute = parseStrictNum(state, minVal = 0, maxVal = 59, count = 2,
                                   "number out of range for minutes")
  if curLine != state.line:
    raise(newTomlError(state, "invalid date field, stopped in or after minutes field"))

  nextChar = state.getNextChar()
  if nextChar != ':':
    raise(newTomlError(state,
                       "\":\" expected after the number of seconds"))

  # Parse the second. Note that seconds=60 *can* happen (leap second)
  val.second = parseStrictNum(state, minVal = 0, maxVal = 60, count = 2,
                                   "number out of range for seconds")

  nextChar = state.getNextChar()
  if nextChar == '.':
    val.subsecond = parseInt(state, base10, LeadingChar.AllowZero).int
  else:
    state.pushBackChar(nextChar)

proc parseDateTimePart(state: var ParserState,
                       dateTime: var TomlDateTime): bool =

  # This function is called whenever a datetime object is found. They follow
  # an ISO convention and can use one of the following format:
  #
  # - YYYY-MM-DDThh:mm:ss[+-]hh:mm
  # - YYYY-MM-DDThh:mm:ssZ
  #
  # where the "T" and "Z" letters are literals, [+-] indicates
  # *either* "+" or "-", YYYY is the 4-digit year, MM is the 2-digit
  # month, DD is the 2-digit day, hh is the 2-digit hour, mm is the
  # 2-digit minute, and ss is the 2-digit second. The hh:mm after
  # the +/- character is the timezone; a literal "Z" indicates the
  # local timezone.

  # This function assumes that the "YYYY-" part has already been
  # parsed (this happens because during parsing, finding a 4-digit
  # number like "YYYY" might just indicate the presence of an
  # integer or a floating-point number; it's the following "-" that
  # tells the parser that the value is a datetime). As a consequence
  # of this, we assume that "dateTime.year" has already been set.

  var
    nextChar: char
    curLine = state.line

  # Parse the month
  dateTime.date.month = parseStrictNum(state, minVal = 1, maxVal = 12, count = 2,
                                  "number out of range for the month")
  if curLine != state.line:
    raise(newTomlError(state, "invalid date field, stopped in or after month field"))

  nextChar = state.getNextChar()
  if nextChar != '-':
    raise(newTomlError(state, "\"-\" expected after the month number"))

  # Parse the day
  dateTime.date.day = parseStrictNum(state, minVal = 1, maxVal = 31, count = 2,
                                "number out of range for the day")
  if curLine != state.line:
    return false
  else:
    nextChar = state.getNextChar()
    if nextChar notin {'t', 'T', ' '}:
      raise(newTomlError(state, "\"T\", \"t\", or space expected after the day number"))

    # Parse the hour
    dateTime.time.hour = parseStrictNum(state, minVal = 0, maxVal = 23, count = 2,
                                   "number out of range for the hours")
    if curLine != state.line:
      raise(newTomlError(state, "invalid date field, stopped in or after hours field"))

    nextChar = state.getNextChar()
    if nextChar != ':':
      raise(newTomlError(state, "\":\" expected after the number of hours"))

    # Parse the minutes
    dateTime.time.minute = parseStrictNum(state, minVal = 0, maxVal = 59, count = 2,
                                     "number out of range for minutes")
    if curLine != state.line:
      raise(newTomlError(state, "invalid date field, stopped in or after minutes field"))

    nextChar = state.getNextChar()
    if nextChar != ':':
      raise(newTomlError(state,
                         "\":\" expected after the number of seconds"))

    # Parse the second. Note that seconds=60 *can* happen (leap second)
    dateTime.time.second = parseStrictNum(state, minVal = 0, maxVal = 60, count = 2,
                                     "number out of range for seconds")

    nextChar = state.getNextChar()
    if nextChar == '.':
      dateTime.time.subsecond = parseInt(state, base10, LeadingChar.AllowZero).int
    else:
      state.pushBackChar(nextChar)

    nextChar = state.getNextChar()
    case nextChar
    of 'z', 'Z':
      dateTime = TomlDateTime(
        time: dateTime.time,
        date: dateTime.date,
        shift: true,
        isShiftPositive: true,
        zoneHourShift: 0,
        zoneMinuteShift: 0
      )
    of '+', '-':
      dateTime = TomlDateTime(
        time: dateTime.time,
        date: dateTime.date,
        shift: true,
        isShiftPositive: (nextChar == '+')
      )
      dateTime.zoneHourShift =
        parseStrictNum(state, minVal = 0, maxVal = 23, count = 2,
                               "number out of range for shift hours")
      if curLine != state.line:
        raise(newTomlError(state, "invalid date field, stopped in or after shift hours field"))

      nextChar = state.getNextChar()
      if nextChar != ':':
        raise(newTomlError(state,
                           "\":\" expected after the number of shift hours"))

      dateTime.zoneMinuteShift =
        parseStrictNum(state, minVal = 0, maxVal = 59, count = 2,
                               "number out of range for shift minutes")
    else:
      if curLine == state.line:
        raise(newTomlError(state, "unexpected character " & escape($nextChar) &
                           " instead of the time zone"))
      else: # shift is automatically initialized to false
        state.pushBackChar(nextChar)

    return true

proc parseDateOrTime(state: var ParserState, digits: int, yearOrHour: int): TomlValueRef =
  var
    nextChar: char
    yoh = yearOrHour
    d = digits
  while true:
    nextChar = state.getNextChar()
    case nextChar:
      of ':':
        if d != 2:
          raise newTomlError(state, "wrong number of characters for hour")
        var val: TomlTime
        val.hour = yoh

        parseTimePart(state, val)
        return TomlValueRef(kind: TomlValueKind.Time, timeVal: val)
      of '-':
        if d != 4:
          raise newTomlError(state, "wrong number of characters for year")
        var val: TomlDateTime
        val.date.year = yoh
        let fullDate = parseDateTimePart(state, val)

        if fullDate:
          return TomlValueRef(kind: TomlValueKind.DateTime,
                                dateTimeVal: val)
        else:
          return TomlValueRef(kind: TomlValueKind.Date,
                                dateVal: val.date)
      of strutils.Digits:
        if d == 4:
          raise newTomlError(state, "leading zero not allowed")
        try:
          yoh *= 10
          yoh += ord(nextChar) - ord('0')
          d += 1
        except OverflowDefect:
          raise newTomlError(state, "number larger than 64 bits wide")
        continue
      of strutils.Whitespace:
        raise newTomlError(state, "leading zero not allowed")
      else: raise newTomlError(state, "illegal character")
    break

proc parseFloat(state: var ParserState, intPart: int, forcedSign: Sign): TomlValueRef =
  var
    decimalpart = parseDecimalPart(state)
    nextChar = state.getNextChar()
    exponent: int64 = 0
  if nextChar in {'e', 'E'}:
    exponent = parseInt(state, base10, LeadingChar.AllowZero)
  else:
    state.pushBackChar(nextChar)

  let value =
    if intPart <= 0:
      pow(10.0, exponent.float64) * (float64(intPart) - decimalPart)
    else:
      pow(10.0, exponent.float64) * (float64(intPart) + decimalPart)
  return TomlValueRef(kind: TomlValueKind.Float, floatVal: if forcedSign != Neg: -value else: value, forcedSign: forcedSign)

proc parseNumOrDate(state: var ParserState): TomlValueRef =
  var
    nextChar: char
    forcedSign: Sign = None

  while true:
    nextChar = state.getNextChar()
    case nextChar:
      of '0':
        nextChar = state.getNextChar()
        if forcedSign == None:
          if nextChar in {'b', 'x', 'o'}:
            state.pushBackChar(nextChar)
            return parseEncoding(state)
          else:
            # This must now be a float or a date/time, or a sole 0
            case nextChar:
              of '.':
                return parseFloat(state, 0, forcedSign)
              of strutils.Whitespace:
                state.pushBackChar(nextChar)
                return TomlValueRef(kind: TomlValueKind.Int, intVal: 0)
              of strutils.Digits:
                # This must now be a date/time
                return parseDateOrTime(state, digits = 2, yearOrHour = ord(nextChar) - ord('0'))
              else:
                # else is a sole 0
                return TomlValueRef(kind: TomlValueKind.Int, intVal: 0)
        else:
          # This must now be a float, or a sole 0
          case nextChar:
            of '.':
              return parseFloat(state, 0, forcedSign)
            of strutils.Whitespace:
              state.pushBackChar(nextChar)
              return TomlValueRef(kind: TomlValueKind.Int, intVal: 0)
            else:
              # else is a sole 0
              return TomlValueRef(kind: TomlValueKind.Int, intVal: 0)
      of strutils.Digits - {'0'}:
        # This might be a date/time, or an int or a float
        var
          digits = 1
          curSum = ord('0') - ord(nextChar)
          wasUnderscore = false
        while true:
          nextChar = state.getNextChar()
          if wasUnderscore and nextChar notin strutils.Digits:
            raise newTomlError(state, "underscores must be surrounded by digits")
          case nextChar:
            of ':':
              if digits != 2:
                raise newTomlError(state, "wrong number of characters for hour")
              var val: TomlTime
              val.hour = -curSum
              parseTimePart(state, val)
              return TomlValueRef(kind: TomlValueKind.Time, timeVal: val)
            of '-':
              if digits != 4:
                raise newTomlError(state, "wrong number of characters for year")
              var val: TomlDateTime
              val.date.year = -curSum
              let fullDate = parseDateTimePart(state, val)
              if fullDate:
                return TomlValueRef(kind: TomlValueKind.DateTime,
                                      dateTimeVal: val)
              else:
                return TomlValueRef(kind: TomlValueKind.Date,
                                      dateVal: val.date)
            of '.':
              return parseFloat(state, curSum, forcedSign)
            of 'e', 'E':
              var exponent = parseInt(state, base10, LeadingChar.AllowZero)
              let value = pow(10.0, exponent.float64) * float64(curSum)
              return TomlValueRef(kind: TomlValueKind.Float, floatVal: if forcedSign != Neg: -value else: value)
            of strutils.Digits:
              try:
                curSum *= 10
                curSum += ord('0') - ord(nextChar)
                digits += 1
              except OverflowDefect:
                raise newTomlError(state, "number larger than 64 bits wide")
              wasUnderscore = false
              continue
            of '_':
              wasUnderscore = true
              continue
            of strutils.Whitespace:
              state.pushBackChar(nextChar)
              return TomlValueRef(kind: TomlValueKind.Int, intVal: if forcedSign != Neg: -curSum else: curSum)
            else:
              state.pushBackChar(nextChar)
              return TomlValueRef(kind: TomlValueKind.Int, intVal: if forcedSign != Neg: -curSum else: curSum)
          break
      of '+', '-':
        forcedSign = if nextChar == '+': Pos else: Neg
        continue
      of 'i':
        #  Is this "inf"?
        let oldState = state
        if state.getNextChar() != 'n' or
           state.getNextChar() != 'f':
            raise(newTomlError(oldState, "unknown identifier"))
        return TomlValueRef(kind: TomlValueKind.Float, floatVal: if forcedSign == Neg: NegInf else: Inf, forcedSign: forcedSign)

      of 'n':
        #  Is this "nan"?
        let oldState = state
        if state.getNextChar() != 'a' or
           state.getNextChar() != 'n':
            raise(newTomlError(oldState, "unknown identifier"))
        return TomlValueRef(kind: TomlValueKind.Float, floatVal: Nan, forcedSign: forcedSign)
      else:
        raise newTomlError(state, "illegal character " & escape($nextChar))
    break

proc parseValue(state: var ParserState): TomlValueRef =
  var nextChar: char

  nextChar = state.getNextNonWhitespace(skipNoLf)
  case nextChar
  of strutils.Digits, '+', '-', 'i', 'n':
    state.pushBackChar(nextChar)
    return parseNumOrDate(state)
  of 't':
    # Is this "true"?
    let oldState = state # Only used for error messages
    if state.getNextChar() != 'r' or
       state.getNextChar() != 'u' or
       state.getNextChar() != 'e':
        raise(newTomlError(oldState, "unknown identifier"))
    result = TomlValueRef(kind: TomlValueKind.Bool, boolVal: true)

  of 'f':
    # Is this "false"?
    let oldState = state # Only used for error messages
    if state.getNextChar() != 'a' or
       state.getNextChar() != 'l' or
       state.getNextChar() != 's' or
       state.getNextChar() != 'e':
        raise(newTomlError(oldState, "unknown identifier"))
    result = TomlValueRef(kind: TomlValueKind.Bool, boolVal: false)

  of '\"':
    # A basic string (accepts \ escape codes)
    result = TomlValueRef(kind: TomlValueKind.String,
                          stringVal: parseString(state, StringType.Basic))

  of '\'':
    # A literal string (does not accept \ escape codes)
    result = TomlValueRef(kind: TomlValueKind.String,
                          stringVal: parseString(state, StringType.Literal))

  of '[':
    # An array
    result = TomlValueRef(kind: TomlValueKind.Array,
                          arrayVal: parseArray(state))
  else:
    raise(newTomlError(state,
                       "unexpected character " & escape($nextChar)))

proc parseName(state: var ParserState): string =
  # This parses the name of a key or a table
  result = newStringOfCap(defaultStringCapacity)

  var nextChar = state.getNextNonWhitespace(skipNoLf)
  if nextChar == '\"':
    return state.parseString(StringType.Basic)
  elif nextChar == '\'':
    return state.parseString(StringType.Literal)
  state.pushBackChar(nextChar)
  while true:
    nextChar = state.getNextChar()
    if (nextChar in {'=', '.', '[', ']', '\0', ' ', '\t'}):
      # Any of the above characters marks the end of the name
      state.pushBackChar(nextChar)
      break
    elif (nextChar notin {'a'..'z', 'A'..'Z', '0'..'9', '_', '-'}):
      raise(newTomlError(state,
        "bare key has illegal character: " & escape($nextChar)))
    else:
      result.add(nextChar)

type
  BracketType {.pure.} = enum
    single, double

proc parseTableName(state: var ParserState,
                    brackets: BracketType): seq[string] =
  # This code assumes that '[' has already been consumed
  result = newSeq[string](0)

  while true:
    #let partName = state.parseName(SpecialChars.AllowNumberSign)
    var
      nextChar = state.getNextChar()
      partName: string
    if nextChar == '"':
      partName = state.parseString(StringType.Basic)
    else:
      state.pushBackChar(nextChar)
      partName = state.parseName()
    result.add(partName)

    nextChar = state.getNextNonWhitespace(skipNoLf)
    case nextChar
    of ']':
      if brackets == BracketType.double:
        nextChar = state.getNextChar()
        if nextChar != ']':
          raise(newTomlError(state,
                             "\"]]\" expected"))

      # We must check that there is nothing else in this line
      nextChar = state.getNextNonWhitespace(skipNoLf)
      if nextChar notin {'\l', '\0'}:
        raise(newTomlError(state,
                           "unexpected character " & escape($nextChar)))

      break

    of '.': continue
    else:
      raise(newTomlError(state,
                         "unexpected character " & escape($nextChar)))

func setEmptyTableVal(val: var TomlValueRef) =
  val = TomlValueRef(kind: TomlValueKind.Table)
  new(val.tableVal)
  val.tableVal[] = initOrderedTable[string, TomlValueRef]()

proc parseInlineTable(state: var ParserState): TomlValueRef =
  new(result)
  setEmptyTableVal(result)
  var firstComma = true
  while true:
    var nextChar = state.getNextNonWhitespace(skipNoLf)
    case nextChar
    of '}':
      return
    of ',':
      if firstComma:
        raise(newTomlError(state, "first inline table element missing"))
      # Check that this is not a terminating comma (like in
      #  "[b,]")
      nextChar = state.getNextNonWhitespace(skipNoLf)
      if nextChar == '}':
        return

      state.pushBackChar(nextChar)
    of '\n':
      raise(newTomlError(state, "inline tables cannot contain newlines"))
    else:
      firstComma = false
      state.pushBackChar(nextChar)
      var key = state.parseName()

      nextChar = state.getNextNonWhitespace(skipNoLf)
      var curTable = result.tableVal
      while nextChar == '.':
        var deepestTable = new(TomlTableRef)
        deepestTable[] = initOrderedTable[string, TomlValueRef]()
        curTable[key] = TomlValueRef(kind: TomlValueKind.Table, tableVal: deepestTable)
        curTable = deepestTable
        key = state.parseName()
        nextChar = state.getNextNonWhitespace(skipNoLf)

      if nextChar != '=':
        raise(newTomlError(state,
                           "key names cannot contain spaces"))
      nextChar = state.getNextNonWhitespace(skipNoLf)
      if nextChar == '{':
        curTable[key] = state.parseInlineTable()
      else:
        state.pushBackChar(nextChar)
        curTable[key] = state.parseValue()

func createTableDef(state: var ParserState,
                    tableNames: seq[string],
                    dotted = false)

proc parseKeyValuePair(state: var ParserState) =
  var
    tableKeys: seq[string]
    key: string
    nextChar: char
    oldTableRef = state.curTableRef

  while true:
    let subkey = state.parseName()

    nextChar = state.getNextNonWhitespace(skipNoLf)
    if nextChar == '.':
      tableKeys.add subkey
    else:
      if tableKeys.len != 0:
        createTableDef(state, tableKeys, dotted = true)
      key = subkey
      break

  if nextChar != '=':
    raise(newTomlError(state,
                       "key names cannot contain character \"" & nextChar & "\""))

  nextChar = state.getNextNonWhitespace(skipNoLf)
  # Check that this is a regular value and not an inline table
  if nextChar != '{':
    state.pushBackChar(nextChar)
    let value = state.parseValue()

    # We must check that there is nothing else in this line
    nextChar = state.getNextNonWhitespace(skipNoLf)
    if nextChar != '\l' and nextChar != '\0':
      raise(newTomlError(state,
                         "unexpected character " & escape($nextChar)))

    if state.curTableRef.hasKey(key):
      raise(newTomlError(state,
                         "duplicate key, \"" & key & "\" already in table"))
    state.curTableRef[key] = value
  else:
    #createTableDef(state, @[key])
    if key.len == 0:
      raise newTomlError(state, "empty key not allowed")
    if state.curTableRef.hasKey(key):
      raise newTomlError(state, "duplicate table key not allowed")
    state.curTableRef[key] = parseInlineTable(state)

  state.curTableRef = oldTableRef

func newParserState(s: streams.Stream,
                    fileName: string = ""): ParserState =
  result = ParserState(fileName: fileName, line: 1, column: 1, stream: s)

func setArrayVal(val: var TomlValueRef, numOfElems: int = 0) =
  val = TomlValueRef(kind: TomlValueKind.Array)
  val.arrayVal = newSeq[TomlValueRef](numOfElems)

func advanceToNextNestLevel(state: var ParserState,
                            tableName: string) =
  let target = state.curTableRef[tableName]
  case target.kind
  of TomlValueKind.Table:
    state.curTableRef = target.tableVal
  of TomlValueKind.Array:
    let arr = target.arrayVal[high(target.arrayVal)]
    if arr.kind != TomlValueKind.Table:
      raise(newTomlError(state, "\"" & tableName &
                         "\" elements are not tables"))
    state.curTableRef = arr.tableVal
  else:
    raise(newTomlError(state, "\"" & tableName &
                       "\" is not a table"))

# This function is called by the TOML parser whenever a
# "[[table.name]]" line is encountered in the parsing process. Its
# purpose is to make sure that all the parent nodes in "table.name"
# exist and are tables, and that a terminal node of the correct type
# is created.
#
# Starting from "curTableRef" (which is usually the root object),
# traverse the object tree following the names in "tableNames" and
# create a new TomlValueRef object of kind "TomlValueKind.Array" at
# the terminal node. This array is going to be an array of tables: the
# function will create an element and will make "curTableRef"
# reference it. Example: if tableNames == ["a", "b", "c"], the code
# will look for the "b" table that is child of "a", and then it will
# check if "c" is a child of "b". If it is, it must be an array of
# tables, and a new element will be appended. Otherwise, a new "c"
# array is created, and an empty table element is added in "c". In
# either cases, curTableRef will refer to the last element of "c".

func createOrAppendTableArrayDef(state: var ParserState,
                                 tableNames: seq[string]) =
  # This is a table array entry (e.g. "[[entry]]")
  for idx, tableName in tableNames:
    if tableName.len == 0:
      raise(newTomlError(state,
                         "empty key not allowed"))
    let lastTableInChain = idx == high(tableNames)

    var newValue: TomlValueRef
    if not state.curTableRef.hasKey(tableName):
      # If this element does not exist, create it
      new(newValue)

      # If this is the last name in the chain (e.g.,
      # "c" in "a.b.c"), its value should be an
      # array of tables, otherwise just a table
      if lastTableInChain:
        setArrayVal(newValue, 1)

        new(newValue.arrayVal[0])
        setEmptyTableVal(newValue.arrayVal[0])

        state.curTableRef[tableName] = newValue
        state.curTableRef = newValue.arrayVal[0].tableVal
      else:
        setEmptyTableVal(newValue)

        # Add the newly created object to the current table
        state.curTableRef[tableName] = newValue

        # Update the pointer to the current table
        state.curTableRef = newValue.tableVal
    else:
      # The element exists: is it of the right type?
      let target = state.curTableRef[tableName]

      if lastTableInChain:
        if target.kind != TomlValueKind.Array:
          raise(newTomlError(state, "\"" & tableName &
                                    "\" is not an array"))

        var newValue: TomlValueRef
        new(newValue)
        setEmptyTableVal(newValue)
        target.arrayVal.add(newValue)
        state.curTableRef = newValue.tableVal
      else:
        advanceToNextNestLevel(state, tableName)

# Starting from "curTableRef" (which is usually the root object),
# traverse the object tree following the names in "tableNames" and
# create a new TomlValueRef object of kind "TomlValueKind.Table" at
# the terminal node. Example: if tableNames == ["a", "b", "c"], the
# code will look for the "b" table that is child of "a" and it will
# create a new table "c" which is "b"'s children.

func createTableDef(state: var ParserState,
                    tableNames: seq[string],
                    dotted = false) =
  var newValue: TomlValueRef

  # This starts a new table (e.g. "[table]")
  for i, tableName in tableNames:
    if tableName.len == 0:
      raise(newTomlError(state,
                         "empty key not allowed"))
    if not state.curTableRef.hasKey(tableName):
      new(newValue)
      setEmptyTableVal(newValue)

      # Add the newly created object to the current table
      state.curTableRef[tableName] = newValue

      # Update the pointer to the current table
      state.curTableRef = newValue.tableVal
    else:
      if i == tableNames.high and state.curTableRef.hasKey(tableName) and
        state.curTableRef[tableName].kind == TomlValueKind.Table:
        if state.curTableRef[tableName].tableVal.len == 0:
          raise newTomlError(state, "duplicate table key not allowed")
        elif not dotted:
          for value in state.curTableRef[tableName].tableVal.values:
            if value.kind != TomlValueKind.Table:
              raise newTomlError(state, "duplicate table key not allowed")
      advanceToNextNestLevel(state, tableName)

proc parseStream*(inputStream: streams.Stream,
                  fileName: string = ""): TomlValueRef =
  ## Parses a stream of TOML formatted data into a TOML table. The optional
  ## filename is used for error messages.
  if inputStream == nil:
    raise newException(IOError,
      "Unable to read from the stream created from: \"" & fileName & "\", " &
      "possibly a missing file")
  var state = newParserState(inputStream, fileName)
  result = TomlValueRef(kind: TomlValueKind.Table)
  new(result.tableVal)
  result.tableVal[] = initOrderedTable[string, TomlValueRef]()

  # This pointer will always point to the table that should get new
  # key/value pairs found in the TOML file during parsing
  state.curTableRef = result.tableVal

  # Unlike "curTableRef", this pointer never changes: it always
  # points to the uppermost table in the tree
  let baseTable = result.tableVal

  var nextChar: char
  while true:
    nextChar = state.getNextNonWhitespace(skipLf)
    case nextChar
    of '[':
      # A new section/table begins. We'll have to start again
      # from the uppermost level, so let's rewind curTableRef to
      # the root node
      state.curTableRef = baseTable

      # First, decompose the table name into its part (e.g.,
      # "a.b.c" -> ["a", "b", "c"])
      nextChar = state.getNextChar()
      let isTableArrayDef = nextChar == '['
      var tableNames: seq[string]
      if isTableArrayDef:
        tableNames = state.parseTableName(BracketType.double)
      else:
        state.pushBackChar(nextChar)
        tableNames = state.parseTableName(BracketType.single)

      # Now create the proper (empty) data structure: either a
      # table or an array of tables. Note that both functions
      # update the "curTableRef" variable: they have to, since
      # the TOML specification says that any "key = value"
      # statement that follows is a child of the table we're
      # defining right now, and we use "curTableRef" as a
      # reference to the table that gets every next key/value
      # definition.
      if isTableArrayDef:
        createOrAppendTableArrayDef(state, tableNames)
      else:
        createTableDef(state, tableNames)

    of '=':
      raise(newTomlError(state, "key name missing"))
    of '#', '.', ']':
      raise(newTomlError(state,
                         "unexpected character " & escape($nextChar)))
    of '\0': # EOF
      return
    else:
      # Everything else marks the presence of a "key = value" pattern
      state.pushBackChar(nextChar)
      parseKeyValuePair(state)

proc parseString*(tomlStr: string, fileName: string = ""): TomlValueRef =
  ## Parses a string of TOML formatted data into a TOML table. The optional
  ## filename is used for error messages.
  let strStream = newStringStream(tomlStr)
  result = parseStream(strStream, fileName)

proc parseFile*(f: File, fileName: string = ""): TomlValueRef =
  ## Parses a file of TOML formatted data into a TOML table. The optional
  ## filename is used for error messages.
  let fStream = newFileStream(f)
  result = parseStream(fStream, fileName)

proc parseFile*(fileName: string): TomlValueRef =
  ## Parses the file found at fileName with TOML formatted data into a TOML
  ## table.
  let fStream = newFileStream(fileName, fmRead)
  result = parseStream(fStream, fileName)

func `$`*(val: TomlDate): string =
  ## Converts the TOML date object into the ISO format read by the parser
  result = ($val.year).align(4, '0') & "-" & ($val.month).align(2, '0') & "-" &
    ($val.day).align(2, '0')

func `$`*(val: TomlTime): string =
  ## Converts the TOML time object into the ISO format read by the parser
  result = ($val.hour).align(2, '0') & ":" &
    ($val.minute).align(2, '0') & ":" & ($val.second).align(2, '0') &
    (if val.subsecond > 0: ("." & $val.subsecond) else: "")

func `$`*(val: TomlDateTime): string =
  ## Converts the TOML date-time object into the ISO format read by the parser
  result = $val.date & "T" & $val.time &
    (if not val.shift: "" else: (
      (if val.zoneHourShift == 0 and val.zoneMinuteShift == 0: "Z" else: (
        ((if val.isShiftPositive: "+" else: "-") &
        ($val.zonehourshift).align(2, '0') & ":" &
        ($val.zoneminuteshift).align(2, '0'))
      ))
    ))

func toTomlString*(value: TomlValueRef): string

func `$`*(val: TomlValueRef): string =
  ## Turns whatever value into a regular Nim value representtation
  case val.kind
  of TomlValueKind.None:
    result = "nil"
  of TomlValueKind.Int:
    result = $val.intVal
  of TomlValueKind.Float:
    result = $val.floatVal
  of TomlValueKind.Bool:
    result = $val.boolVal
  of TomlValueKind.Datetime:
    result = $val.datetimeVal
  of TomlValueKind.Date:
    result = $val.dateVal
  of TomlValueKind.Time:
    result = $val.timeVal
  of TomlValueKind.String:
    result = $val.stringVal
  of TomlValueKind.Array:
    result = ""
    for elem in val.arrayVal:
      result.add($(elem[]))
  of TomlValueKind.Table:
    result = val.toTomlString

func `$`*(val: TomlValue): string =
  ## Turns whatever value into a type and value representation, used by ``dump``
  case val.kind
  of TomlValueKind.None:
    result = "none()"
  of TomlValueKind.Int:
    result = "int(" & $val.intVal & ")"
  of TomlValueKind.Float:
    result = "float(" & $val.floatVal & ")"
  of TomlValueKind.Bool:
    result = "boolean(" & $val.boolVal & ")"
  of TomlValueKind.Datetime:
    result = "datetime(" & $val.datetimeVal & ")"
  of TomlValueKind.Date:
    result = "date(" & $val.dateVal & ")"
  of TomlValueKind.Time:
    result = "time(" & $val.timeVal & ")"
  of TomlValueKind.String:
    result = "string(\"" & $val.stringVal & "\")"
  of TomlValueKind.Array:
    result = "array("
    for elem in val.arrayVal:
      result.add($(elem[]))
    result.add(")")
  of TomlValueKind.Table:
    result = "table(" & $(len(val.tableVal)) & " elements)"

proc dump*(table: TomlTableRef, indentLevel: int = 0) =
  ## Dump out the entire table as it was parsed. This procedure is mostly
  ## useful for debugging purposes
  let space = spaces(indentLevel)
  for key, val in pairs(table):
    if val.kind == TomlValueKind.Table:
      echo space & key & " = table"
      dump(val.tableVal, indentLevel + 4)
    elif (val.kind == TomlValueKind.Array and
        val.arrayVal[0].kind == TomlValueKind.Table):
      for idx, val in val.arrayVal:
        echo space & key & "[" & $idx & "] = table"
        dump(val.tableVal, indentLevel + 4)
    else:
      echo space & key & " = " & $(val[])

import json, sequtils

func toJson*(value: TomlValueRef): JsonNode

func toJson*(table: TomlTableRef): JsonNode =
  ## Converts a TOML table to a JSON node. This uses the format specified in
  ## the validation suite for it's output:
  ## https://github.com/BurntSushi/toml-test#example-json-encoding
  result = newJObject()
  for key, value in pairs(table):
    result[key] = value.toJson

func toJson*(value: TomlValueRef): JsonNode =
  ## Converts a TOML value to a JSON node. This uses the format specified in
  ## the validation suite for it's output:
  ## https://github.com/BurntSushi/toml-test#example-json-encoding
  case value.kind:
    of TomlValueKind.Int:
      %*{"type": "integer", "value": $value.intVal}
    of TomlValueKind.Float:
      if classify(value.floatVal) == fcNan:
        if value.forcedSign != Pos:
          %*{"type": "float", "value": $value.floatVal}
        else:
          %*{"type": "float", "value": "+" & $value.floatVal}
      else:
        %*{"type": "float", "value": $value.floatVal}
    of TomlValueKind.Bool:
      %*{"type": "bool", "value": $value.boolVal}
    of TomlValueKind.Datetime:
      if value.datetimeVal.shift == false:
        %*{"type": "datetime-local", "value": $value.datetimeVal}
      else:
        %*{"type": "datetime", "value": $value.datetimeVal}
    of TomlValueKind.Date:
      %*{"type": "date", "value": $value.dateVal}
    of TomlValueKind.Time:
      %*{"type": "time", "value": $value.timeVal}
    of TomlValueKind.String:
      %*{"type": "string", "value": newJString(value.stringVal)}
    of TomlValueKind.Array:
      if value.arrayVal.len == 0:
        when defined(newtestsuite):
          %[]
        else:
          %*{"type": "array", "value": []}
      elif value.arrayVal[0].kind == TomlValueKind.Table:
        %value.arrayVal.map(toJson)
      else:
        when defined(newtestsuite):
          %*value.arrayVal.map(toJson)
        else:
          %*{"type": "array", "value": value.arrayVal.map(toJson)}
    of TomlValueKind.Table:
      value.tableVal.toJson
    of TomlValueKind.None:
      %*{"type": "ERROR"}

func toKey(str: string): string =
  for c in str:
    if (c notin {'a'..'z', 'A'..'Z', '0'..'9', '_', '-'}):
      return "\"" & str & "\""
  str


func toTomlString*(value: TomlTableRef, parents = ""): string =
  ## Converts a TOML table to a TOML formatted string for output to a file.
  result = ""
  var subtables: seq[tuple[key: string, value: TomlValueRef]] = @[]
  for key, value in pairs(value):
    block outer:
      if value.kind == TomlValueKind.Table:
        subtables.add((key: key, value: value))
      elif value.kind == TomlValueKind.Array and
        value.arrayVal[0].kind == TomlValueKind.Table:
        let tables = value.arrayVal.map(toTomlString)
        for table in tables:
          result = result & "[[" & key & "]]\n" & table & "\n"
      else:
        result = result & key.toKey & " = " & toTomlString(value) & "\n"
  for kv in subtables:
    let fullKey = (if parents.len > 0: parents & "." else: "") & kv.key.toKey
    block outer:
      for ikey, ivalue in pairs(kv.value.tableVal):
        if ivalue.kind != TomlValueKind.Table:
          result = result & "[" & fullKey & "]\n" &
            kv.value.tableVal.toTomlString(fullKey) & "\n"
          break outer
      result = result & kv.value.tableVal.toTomlString(fullKey)

func toTomlString*(value: TomlValueRef): string =
  ## Converts a TOML value to a TOML formatted string for output to a file.
  case value.kind:
  of TomlValueKind.Int: $value.intVal
  of TomlValueKind.Float: $value.floatVal
  of TomlValueKind.Bool: $value.boolVal
  of TomlValueKind.Datetime: $value.datetimeVal
  of TomlValueKind.String: "\"" & value.stringVal & "\""
  of TomlValueKind.Array:
    if value.arrayVal.len == 0:
      "[]"
    elif value.arrayVal[0].kind == TomlValueKind.Table:
      value.arrayVal.map(toTomlString).join("\n")
    else:
      "[" & value.arrayVal.map(toTomlString).join(", ") & "]"
  of TomlValueKind.Table: value.tableVal.toTomlString
  else:
    "UNKNOWN"

func newTString*(s: string): TomlValueRef =
  ## Creates a new `TomlValueKind.String TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.String, stringVal: s)

func newTInt*(n: int64): TomlValueRef =
  ## Creates a new `TomlValueKind.Int TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.Int, intVal: n)

func newTFloat*(n: float): TomlValueRef =
  ## Creates a new `TomlValueKind.Float TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.Float, floatVal: n)

func newTBool*(b: bool): TomlValueRef =
  ## Creates a new `TomlValueKind.Bool TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.Bool, boolVal: b)

func newTNull*(): TomlValueRef =
  ## Creates a new `JNull TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.None)

func newTTable*(): TomlValueRef =
  ## Creates a new `TomlValueKind.Table TomlValueRef`
  result = TomlValueRef(kind: TomlValueKind.Table)
  new(result.tableVal)
  result.tableVal[] = initOrderedTable[string, TomlValueRef](4)

func newTArray*(): TomlValueRef =
  ## Creates a new `TomlValueKind.Array TomlValueRef`
  TomlValueRef(kind: TomlValueKind.Array, arrayVal: @[])

func getStr*(n: TomlValueRef, default: string = ""): string =
  ## Retrieves the string value of a `TomlValueKind.String TomlValueRef`.
  ##
  ## Returns ``default`` if ``n`` is not a ``TomlValueKind.String``, or if ``n`` is nil.
  if n.isNil or n.kind != TomlValueKind.String: return default
  else: return n.stringVal

func getInt*(n: TomlValueRef, default: int = 0): int =
  ## Retrieves the int value of a `TomlValueKind.Int TomlValueRef`.
  ##
  ## Returns ``default`` if ``n`` is not a ``TomlValueKind.Int``, or if ``n`` is nil.
  if n.isNil or n.kind != TomlValueKind.Int: return default
  else: return int(n.intVal)

func getBiggestInt*(n: TomlValueRef, default: int64 = 0): int64 =
  ## Retrieves the int64 value of a `TomlValueKind.Int TomlValueRef`.
  ##
  ## Returns ``default`` if ``n`` is not a ``TomlValueKind.Int``, or if ``n`` is nil.
  if n.isNil or n.kind != TomlValueKind.Int: return default
  else: return n.intVal

func getFloat*(n: TomlValueRef, default: float = 0.0): float =
  ## Retrieves the float value of a `TomlValueKind.Float TomlValueRef`.
  ##
  ## Returns ``default`` if ``n`` is not a ``TomlValueKind.Float`` or ``TomlValueKind.Int``, or if ``n`` is nil.
  if n.isNil: return default
  case n.kind
  of TomlValueKind.Float: return n.floatVal
  of TomlValueKind.Int: return float(n.intVal)
  else: return default

func getBool*(n: TomlValueRef, default: bool = false): bool =
  ## Retrieves the bool value of a `TomlValueKind.Bool TomlValueRef`.
  ##
  ## Returns ``default`` if ``n`` is not a ``TomlValueKind.Bool``, or if ``n`` is nil.
  if n.isNil or n.kind != TomlValueKind.Bool: return default
  else: return n.boolVal

func getTable*(n: TomlValueRef, default = new(TomlTableRef)): TomlTableRef =
  ## Retrieves the key, value pairs of a `TomlValueKind.Table TomlValueRef`.
  ##
  ## Returns ``default`` if ``n`` is not a ``TomlValueKind.Table``, or if ``n`` is nil.
  if n.isNil or n.kind != TomlValueKind.Table: return default
  else: return n.tableVal

func getElems*(n: TomlValueRef, default: seq[TomlValueRef] = @[]): seq[TomlValueRef] =
  ## Retrieves the int value of a `TomlValueKind.Array TomlValueRef`.
  ##
  ## Returns ``default`` if ``n`` is not a ``TomlValueKind.Array``, or if ``n`` is nil.
  if n.isNil or n.kind != TomlValueKind.Array: return default
  else: return n.arrayVal

func add*(father, child: TomlValueRef) =
  ## Adds `child` to a TomlValueKind.Array node `father`.
  assert father.kind == TomlValueKind.Array
  father.arrayVal.add(child)

func add*(obj: TomlValueRef, key: string, val: TomlValueRef) =
  ## Sets a field from a `TomlValueKind.Table`.
  assert obj.kind == TomlValueKind.Table
  obj.tableVal[key] = val

func `?`*(s: string): TomlValueRef =
  ## Generic constructor for TOML data. Creates a new `TomlValueKind.String TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.String, stringVal: s)

func `?`*(n: int64): TomlValueRef =
  ## Generic constructor for TOML data. Creates a new `TomlValueKind.Int TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.Int, intVal: n)

func `?`*(n: float): TomlValueRef =
  ## Generic constructor for TOML data. Creates a new `TomlValueKind.Float TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.Float, floatVal: n)

func `?`*(b: bool): TomlValueRef =
  ## Generic constructor for TOML data. Creates a new `TomlValueKind.Bool TomlValueRef`.
  TomlValueRef(kind: TomlValueKind.Bool, boolVal: b)

func `?`*(keyVals: openArray[tuple[key: string, val: TomlValueRef]]): TomlValueRef =
  ## Generic constructor for TOML data. Creates a new `TomlValueKind.Table TomlValueRef`
  if keyvals.len == 0: return newTArray()
  result = newTTable()
  for key, val in items(keyVals): result.tableVal[key] = val

template `?`*(j: TomlValueRef): TomlValueRef = j

func `?`*[T](elements: openArray[T]): TomlValueRef =
  ## Generic constructor for TOML data. Creates a new `TomlValueKind.Array TomlValueRef`
  result = newTArray()
  for elem in elements: result.add(?elem)

when false:
  # For 'consistency' we could do this, but that only pushes people further
  # into that evil comfort zone where they can use Nim without understanding it
  # causing problems later on.
  proc `?`*(elements: set[bool]): TomlValueRef =
    ## Generic constructor for TOML data. Creates a new `TomlValueKind.Table TomlValueRef`.
    ## This can only be used with the empty set ``{}`` and is supported
    ## to prevent the gotcha ``%*{}`` which used to produce an empty
    ## TOML array.
    result = newTTable()
    assert false notin elements, "usage error: only empty sets allowed"
    assert true notin elements, "usage error: only empty sets allowed"

func `?`*(o: object): TomlValueRef =
  ## Generic constructor for TOML data. Creates a new `TomlValueKind.Table TomlValueRef`
  result = newTTable()
  for k, v in o.fieldPairs: result[k] = ?v

func `?`*(o: ref object): TomlValueRef =
  ## Generic constructor for TOML data. Creates a new `TomlValueKind.Table TomlValueRef`
  if o.isNil:
    result = newTNull()
  else:
    result = ?(o[])

func `?`*(o: enum): TomlValueRef =
  ## Construct a TomlValueRef that represents the specified enum value as a
  ## string. Creates a new ``TomlValueKind.String TomlValueRef``.
  result = ?($o)

import macros

func toToml(x: NimNode): NimNode {.compiletime.} =
  case x.kind
  of nnkBracket: # array
    if x.len == 0: return newCall(bindSym"newTArray")
    result = newNimNode(nnkBracket)
    for i in 0 ..< x.len:
      result.add(toToml(x[i]))
    result = newCall(bindSym("?", brOpen), result)
  of nnkTableConstr: # object
    if x.len == 0: return newCall(bindSym"newTTable")
    result = newNimNode(nnkTableConstr)
    for i in 0 ..< x.len:
      x[i].expectKind nnkExprColonExpr
      result.add newTree(nnkExprColonExpr, x[i][0], toToml(x[i][1]))
    result = newCall(bindSym("?", brOpen), result)
  of nnkCurly: # empty object
    x.expectLen(0)
    result = newCall(bindSym"newTTable")
  of nnkNilLit:
    result = newCall(bindSym"newTNull")
  else:
    result = newCall(bindSym("?", brOpen), x)

macro `?*`*(x: untyped): untyped =
  ## Convert an expression to a TomlValueRef directly, without having to specify
  ## `?` for every element.
  result = toToml(x)
  echo result.repr

func toTomlValue(x: NimNode): NimNode {.compileTime.} =
  newCall(bindSym("?", brOpen), x)

proc toTomlNew(x: NimNode): NimNode {.compiletime.} =
  echo x.treeRepr
  var
    i = 0
    curTable: NimNode = nil
  while i < x.len:
    echo x[i].kind
    case x[i].kind:
    of nnkAsgn:
      if curTable.isNil:
        curTable = newNimNode(nnkTableConstr)
        result = curTable
      curTable.add newTree(nnkExprColonExpr, newLit($x[i][0]), toTomlValue(x[i][1]))
    of nnkBracket:
      if curTable.isNil:
        curTable = newNimNode(nnkTableConstr)
        result = curTable
      else:
        var table = newNimNode(nnkTableConstr)
        result.add newTree(nnkExprColonExpr, newLit($x[i][0]), newCall(bindSym("?", brOpen), table))
        curTable = table
    else: discard
    i += 1
  result = newCall(bindSym("?", brOpen), result)

macro `parseToml`*(x: untyped): untyped =
  ## Convert an expression to a TomlValueRef directly, without having to specify
  ## `?` for every element.
  result = toTomlNew(x)
  echo result.repr

func `==`* (a, b: TomlValueRef): bool =
  ## Check two nodes for equality
  if a.isNil:
    if b.isNil: return true
    return false
  elif b.isNil or a.kind != b.kind:
    return false
  else:
    case a.kind
    of TomlValueKind.String:
      result = a.stringVal == b.stringVal
    of TomlValueKind.Int:
      result = a.intVal == b.intVal
    of TomlValueKind.Float:
      result = a.floatVal == b.floatVal
    of TomlValueKind.Bool:
      result = a.boolVal == b.boolVal
    of TomlValueKind.None:
      result = true
    of TomlValueKind.Array:
      result = a.arrayVal == b.arrayVal
    of TomlValueKind.Table:
      # we cannot use OrderedTable's equality here as
      # the order does not matter for equality here.
      if a.tableVal.len != b.tableVal.len: return false
      for key, val in a.tableVal:
        if not b.tableVal.hasKey(key): return false
        if b.tableVal[key] != val: return false
      result = true
    of TomlValueKind.DateTime:
      result =
        a.dateTimeVal.date.year == b.dateTimeVal.date.year and
        a.dateTimeVal.date.month == b.dateTimeVal.date.month and
        a.dateTimeVal.date.day == b.dateTimeVal.date.day and
        a.dateTimeVal.time.hour == b.dateTimeVal.time.hour and
        a.dateTimeVal.time.minute == b.dateTimeVal.time.minute and
        a.dateTimeVal.time.second == b.dateTimeVal.time.second and
        a.dateTimeVal.time.subsecond == b.dateTimeVal.time.subsecond and
        a.dateTimeVal.shift == b.dateTimeVal.shift and
        (a.dateTimeVal.shift == true and
          (a.dateTimeVal.isShiftPositive == b.dateTimeVal.isShiftPositive and
          a.dateTimeVal.zoneHourShift == b.dateTimeVal.zoneHourShift and
          a.dateTimeVal.zoneMinuteShift == b.dateTimeVal.zoneMinuteShift)) or
        a.dateTimeVal.shift == false
    of TomlValueKind.Date:
      result =
        a.dateVal.year == b.dateVal.year and
        a.dateVal.month == b.dateVal.month and
        a.dateVal.day == b.dateVal.day
    of TomlValueKind.Time:
      result =
        a.timeVal.hour == b.timeVal.hour and
        a.timeVal.minute == b.timeVal.minute and
        a.timeVal.second == b.timeVal.second and
        a.timeVal.subsecond == b.timeVal.subsecond

import hashes

func hash*(n: OrderedTable[string, TomlValueRef]): Hash

func hash*(n: TomlValueRef): Hash =
  ## Compute the hash for a TOML node
  case n.kind
  of TomlValueKind.Array:
    result = hash(n.arrayVal)
  of TomlValueKind.Table:
    result = hash(n.tableVal[])
  of TomlValueKind.Int:
    result = hash(n.intVal)
  of TomlValueKind.Float:
    result = hash(n.floatVal)
  of TomlValueKind.Bool:
    result = hash(n.boolVal.int)
  of TomlValueKind.String:
    result = hash(n.stringVal)
  of TomlValueKind.None:
    result = Hash(0)
  of TomlValueKind.DateTime:
    result = hash($n.dateTimeVal)
  of TomlValueKind.Date:
    result = hash($n.dateVal)
  of TomlValueKind.Time:
    result = hash($n.timeVal)

func hash*(n: OrderedTable[string, TomlValueRef]): Hash =
  for key, val in n:
    result = result xor (hash(key) !& hash(val))
  result = !$result

func len*(n: TomlValueRef): int =
  ## If `n` is a `TomlValueKind.Array`, it returns the number of elements.
  ## If `n` is a `TomlValueKind.Table`, it returns the number of pairs.
  ## Else it returns 0.
  case n.kind
  of TomlValueKind.Array: result = n.arrayVal.len
  of TomlValueKind.Table: result = n.tableVal.len
  else: discard

func `[]`*(node: TomlValueRef, name: string): TomlValueRef {.inline.} =
  ## Gets a field from a `TomlValueKind.Table`, which must not be nil.
  ## If the value at `name` does not exist, raises KeyError.
  assert(not isNil(node))
  assert(node.kind == TomlValueKind.Table)
  result = node.tableVal[name]

func `[]`*(node: TomlValueRef, index: int): TomlValueRef {.inline.} =
  ## Gets the node at `index` in an Array. Result is undefined if `index`
  ## is out of bounds, but as long as array bound checks are enabled it will
  ## result in an exception.
  assert(not isNil(node))
  assert(node.kind == TomlValueKind.Array)
  return node.arrayVal[index]

func hasKey*(node: TomlValueRef, key: string): bool =
  ## Checks if `key` exists in `node`.
  assert(node.kind == TomlValueKind.Table)
  result = node.tableVal.hasKey(key)

func contains*(node: TomlValueRef, key: string): bool =
  ## Checks if `key` exists in `node`.
  assert(node.kind == TomlValueKind.Table)
  node.tableVal.hasKey(key)

func contains*(node: TomlValueRef, val: TomlValueRef): bool =
  ## Checks if `val` exists in array `node`.
  assert(node.kind == TomlValueKind.Array)
  find(node.arrayVal, val) >= 0

func existsKey*(node: TomlValueRef, key: string): bool {.deprecated.} = node.hasKey(key)
  ## Deprecated for `hasKey`

func `[]=`*(obj: TomlValueRef, key: string, val: TomlValueRef) {.inline.} =
  ## Sets a field from a `TomlValueKind.Table`.
  assert(obj.kind == TomlValueKind.Table)
  obj.tableVal[key] = val

func `{}`*(node: TomlValueRef, keys: varargs[string]): TomlValueRef =
  ## Traverses the node and gets the given value. If any of the
  ## keys do not exist, returns ``nil``. Also returns ``nil`` if one of the
  ## intermediate data structures is not an object.
  result = node
  for key in keys:
    if isNil(result) or result.kind != TomlValueKind.Table:
      return nil
    result = result.tableVal.getOrDefault(key)

func getOrDefault*(node: TomlValueRef, key: string): TomlValueRef =
  ## Gets a field from a `node`. If `node` is nil or not an object or
  ## value at `key` does not exist, returns nil
  if not isNil(node) and node.kind == TomlValueKind.Table:
    result = node.tableVal.getOrDefault(key)

template simpleGetOrDefault*{`{}`(node, [key])}(node: TomlValueRef, key: string): TomlValueRef = node.getOrDefault(key)

func `{}=`*(node: TomlValueRef, keys: varargs[string], value: TomlValueRef) =
  ## Traverses the node and tries to set the value at the given location
  ## to ``value``. If any of the keys are missing, they are added.
  var node = node
  for i in 0..(keys.len-2):
    if not node.hasKey(keys[i]):
      node[keys[i]] = newTTable()
    node = node[keys[i]]
  node[keys[keys.len-1]] = value

func delete*(obj: TomlValueRef, key: string) =
  ## Deletes ``obj[key]``.
  assert(obj.kind == TomlValueKind.Table)
  if not obj.tableVal.hasKey(key):
    raise newException(IndexDefect, "key not in object")
  obj.tableVal.del(key)

func copy*(p: TomlValueRef): TomlValueRef =
  ## Performs a deep copy of `a`.
  case p.kind
  of TomlValueKind.String:
    result = newTString(p.stringVal)
  of TomlValueKind.Int:
    result = newTInt(p.intVal)
  of TomlValueKind.Float:
    result = newTFloat(p.floatVal)
  of TomlValueKind.Bool:
    result = newTBool(p.boolVal)
  of TomlValueKind.None:
    result = newTNull()
  of TomlValueKind.Table:
    result = newTTable()
    for key, val in pairs(p.tableVal):
      result.tableVal[key] = copy(val)
  of TomlValueKind.Array:
    result = newTArray()
    for i in items(p.arrayVal):
      result.arrayVal.add(copy(i))
  of TomlValueKind.DateTime:
    deepCopy(result, p)
  of TomlValueKind.Date:
    deepCopy(result, p)
  of TomlValueKind.Time:
    deepCopy(result, p)
