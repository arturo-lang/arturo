import strscans, strutils, strformat, parseutils, streams, sugar, sequtils

import tokens
import errors

proc peeks*(s: string, start: int): string = s[start ..< s.len]

proc scanTextStop*(s: string, start: int, delim: Delimiter): int =
  var pos = start
  while pos < s.len:
    if s[pos] == '\n':
      pos += 1
      break
    if s.peeks(pos).startsWith(delim.open):
      break
    pos += 1
  result = pos - start

proc scanText*(s: string, idx: var int, delim: Delimiter, token: var Token): int =
  ## Anything that does not conflict with open or close counts as text.
  ##
  ## Text eats string `s` until an open or close delimiter is detected.
  ##
  var doc: string
  result = s.scanTextStop(idx, delim)
  if result != 0:
    doc = s[idx ..< idx+result]
    token = Text(doc: doc, src: doc)
    idx += result

proc scanSetDelimiter*(s: string, idx: int, delim: Delimiter, token: var Token): int =
  var open, close: string
  var pos = idx
  let start = idx

  if scanp(
    s, pos,
    (
      '=',                            # starts from a single char =
      *{' ', '\t'},
      +(~{' '} -> open.add($_)),      # next non-spaces become a open
      +{' ', '\t'},
      +(~{' ', '='} -> close.add($_)),# next non-spaces become a close
      *{' ', '\t'},
      '=',                            # ends at a single char =
    )
  ):
    let newDelim = Delimiter(open: open, close: close)
    token = SetDelimiter(delimiter: newDelim)
    result = pos - start
  else:
    result = 0

proc scanTagOpen*(s: string, idx: int, delim: Delimiter): int =
  if s.peeks(idx).startsWith(delim.open): delim.open.len else: 0

proc scanTagClose*(s: string, idx: int, delim: Delimiter): int =
  if s.peeks(idx).startsWith(delim.close): delim.close.len else: 0

proc scanVariable*(s: string, idx: int, delim: Delimiter, token: var Token): int =
  var key: string
  let size = parseUntil(s, key, delim.close, idx)
  if size == 0:
    result = 0
  else:
    token = EscapedTag(key: key.strip)
    result = size

proc scanComment*(s: string, idx: int, delim: Delimiter, token: var Token): int =
  let start = idx
  var pos = idx
  var comment: string

  if scanp(
    s, pos,
    (
      '!',
      *{' ', '\t'},
      parseUntil($input, comment, delim.close, $index),
    )
  ):
    token = Comment()
    result = pos - start
  else:
    result = 0

proc scanUnescaped*(s: string, idx: int, delim: Delimiter, token: var Token): int =
  let start = idx
  var pos = idx
  var key: string

  if scanp(
    s, pos,
    (
      '&',
      *{' ', '\t'},
      parseUntil($input, key, delim.close, $index),
    )
  ):
    token = UnescapedTag(key: key.strip)
    result = pos - start
  else:
    result = 0

proc scanTripleMustache*(s: string, idx: int, delim: Delimiter, token: var Token): int =
  let start = idx
  var pos = idx
  var key: string

  if scanp(
    s, pos,
    (
      '{',
      *{' ', '\t'},
      +(~{'}'}) -> key.add($_),
      *{' ', '\t'},
      '}',
    )
  ):
    token = UnescapedTag(key: key.strip)
    result = pos - start
  else:
    result = 0

proc scanInverted*(s: string, idx: int, inverted: var bool): int =
  case s[idx]
  of '#':
    inverted = false
    result = 1
  of '^':
    inverted = true
    result = 1
  else:
    result = 0

proc scanSectionOpen*(s: string, idx: int, delim: Delimiter, token: var Token): int =
  let start = idx
  var pos = idx
  var inverted: bool
  var key: string

  if scanp(
    s, pos,
    (
      scanInverted($input, $index, inverted),
      *{' ', '\t'},
      parseUntil($input, key, delim.close, $index),
    )
  ):
    token = SectionOpen(key: key.strip, inverted: inverted)
    result = pos - start
  else:
    result = 0

proc scanSectionClose*(s: string, idx: int, delim: Delimiter, token: var Token): int =
  let start = idx
  var pos = idx
  var key: string

  if scanp(
    s, pos,
    (
      '/',
      *{' ', '\t'},
      parseUntil($input, key, delim.close, $index),
    )
  ):
    token = SectionClose(key: key.strip)
    result = pos - start
  else:
    result = 0

proc scanPartial*(s: string, idx: int, delim: Delimiter, token: var Token): int =
  let start = idx
  var pos = idx
  var key: string

  if scanp(
    s, pos,
    (
      '>',
      *{' ', '\t'},
      parseUntil($input, key, delim.close, $index),
    )
  ):
    token = Partial(key: key.strip)
    result = pos - start
  else:
    result = 0

proc scanTagContent*(s: string, idx: int, delim: var Delimiter, token: var Token): int =
  var size: int

  # set delimiter
  size = scanSetDelimiter(s, idx, delim, token)
  if size != 0: return size

  # comment
  size = scanComment(s, idx, delim, token)
  if size != 0: return size

  # unescaped tag - &
  size = scanUnescaped(s, idx, delim, token)
  if size != 0: return size

  # unescaped tag - {{{triple mustache}}}
  size = scanTripleMustache(s, idx, delim, token)
  if size != 0: return size

  # section open
  size = scanSectionOpen(s, idx, delim, token)
  if size != 0: return size

  # section close
  size = scanSectionClose(s, idx, delim, token)
  if size != 0: return size

  # partial
  size = scanPartial(s, idx, delim, token)
  if size != 0: return size

  # variable
  size = scanVariable(s, idx, delim, token)
  if size != 0: return size

  return 0

proc scanTag*(s: string, idx: var int, delim: var Delimiter, token :var Token): int =
  let start = idx

  if scanp(
    s, idx,
    (
      scanTagOpen($input, $index, delim),
      *{' ', '\t'},
      scanTagContent($input, $index, delim, token),
      *{' ', '\t'},
      scanTagClose($input, $index, delim),
    )
  ):
    if token != nil: token.src = s[start..<idx]
    result = idx-start
  else:
    idx = start
    result = 0

proc scanm(s: string, idx: var int, delim: var Delimiter, token: var Token): bool =
  ## Scan mustache tokens from a given string `s` starting from `idx`.
  ## It turns s[idx .. new idx] to a token and then updates idx to new idx.
  if s.scanTag(idx, delim, token) != 0: return true
  return s.scanText(idx, delim, token) != 0

proc scanTokens*(s: string): seq[Token] =
  result = @[]

  var delim = Delimiter(open: "{{", close: "}}")
  var idx = 0
  var token: Token

  while idx < s.len:
    token = nil
    if scanm(s, idx, delim, token):
      if token != nil:
        result.add(token)
      if token of SetDelimiter:
        delim = SetDelimiter(token).delimiter
    else:
      # if no mustache rule is matched, it eats 1 char as a Text at a time.
      let ch = fmt"{s[idx]}"
      result.add(Text(doc: ch, src: ch))
      idx += 1

iterator iterLine*(tokens: seq[Token]): seq[Token] =
  ## Group tokens by lines.
  var buf: seq[Token] = @[]
  for token in tokens:
    buf.add(token)
    if token of Text and token.src.contains('\n'):
      yield buf
      buf = @[]
  if buf.len != 0:
    yield buf

proc setIndent*(tokens: seq[Token]): seq[Token]=
  var indent = 0
  for token in tokens:
    if token of Text:
      if token.src.strip == "":
        indent += token.src.len
      else:
        break
    elif token of Partial:
      Partial(token).indent = indent
    else:
      break
  return tokens

proc trimStandalone*(tokens: seq[Token]): seq[Token] =
  ## Trim surrounded whitespaces for sections, set delimiters, and comments.
  var buf: seq[Token] = @[]
  for token in tokens:
    if (
      (token of SectionOpen) or
      (token of SectionClose) or
      (token of SetDelimiter) or
      (token of Partial) or
      (token of Comment)
    ):
      buf.add(token)
    elif (token of Text):
      # non-whitespaces: not standalone
      if token.src.strip != "":
        return tokens
      # whitespaces: ignore it.
    else:
      # all others
      return tokens
  # only strip line, return tokens.
  if buf.len == 0:
    return tokens
  # section/set delimiter/comment is surrounded by whitespaces.
  else:
    return buf

proc parse*(s: string): seq[Token] =
  result = @[]
  for tokens in s.scanTokens.iterLine:
    result.add(tokens.setIndent.trimStandalone)
