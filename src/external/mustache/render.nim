import strutils, strformat, sequtils

import errors
import tokens
import values
import parser

proc escape(s: string): string = s.multiReplace([
    ("&", "&amp;"),
    ("\"", "&quot;"),
    ("<", "&lt;"),
    (">", "&gt;"),
  ])

method render*(token: Token, ctx: Context): string {.base, locks: "unknown".} = ""

proc render*(tokens: seq[Token], ctx: Context): string =
  var stack: seq[Section] = @[]
  for token in tokens:
    if token of SectionOpen:
      let open = SectionOpen(token)
      stack.add(Section(
        key: open.key,
        inverted: open.inverted,
        children: @[]
      ))

    elif token of SectionClose:
      var close = SectionClose(token)
      if stack.len == 0:
        raise newException(MustacheError, fmt"early closed: {close.key}")

      var lastSection = stack[stack.len-1]
      if close.key.strip != lastSection.key:
        raise newException(MustacheError,
          fmt"unmatch section: last open: {lastSection.key}, close: {close.key}")

      discard stack.pop()

      if stack.len == 0:
        result.add(lastSection.render(ctx))
      else:
        stack[stack.len-1].children.add(lastSection)

    elif stack.len != 0:
      stack[stack.len-1].children.add(token)

    else:
      result.add(token.render(ctx))

proc render*(s: string, ctx: Context = newContext()): string =
  s.parse.render(ctx)

method render*(token: Text, ctx: Context): string {.locks: "unknown".}=
  token.doc

method render*(token: EscapedTag, ctx: Context): string =
  ctx[token.key].castStr.escape

method render*(token: UnescapedTag, ctx: Context): string =
  ctx[token.key].castStr

method render*(token: Partial, ctx: Context): string =
  let s = ctx.read(token.key)
  var lns: seq[string] = @[]
  for ln in s.splitLines(keepEol=true):
    if ln != "":
      lns.add(" ".repeat(token.indent) & ln)
  result = lns.join("").render(ctx)

method render*(token: Section, ctx: Context): string =
  let val = ctx[token.key]
  let truthy = val.castBool

  # Inverted
  if token.inverted:
    if truthy:
      return ""
    else:
      return render(token.children, ctx)

  if not truthy:
    return ""

  # Lists
  if val.kind == vkSeq:
    for el in val.vSeq:
      var newCtx = el.derive(ctx)
      newCtx["."] = el
      result.add(render(token.children, newCtx))

  # Tables
  elif val.kind == vkTable:
    return render(token.children, val.derive(ctx))

  # Lambdas handles static strings.
  elif val.kind == vkProc:
    let src = token.children.map(
      proc(s: Token): string = s.src
    ).join("")
    return val.vProc(src, ctx)

  # Non-empty Values
  else:
    return render(token.children, ctx)
