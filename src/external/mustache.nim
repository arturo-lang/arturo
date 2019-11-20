# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import tables, sequtils, sugar, strutils, strformat, parseopt, os, json

import mustache/errors
import mustache/tokens
import mustache/parser
import mustache/values
import mustache/render

export Context
export newContext
export Value
export ValueKind
export castValue
export render
export parse
export `$`
export `[]`
export `[]=`

when isMainModule:
  var p = initOptParser()
  var optCompile: bool
  var optToken: bool
  var args: seq[string]
  while true:
    p.next()
    case p.kind
    of cmdEnd: break
    of cmdShortOption, cmdLongOption:
      case p.val
      of "-c":
        optCompile = true
      of "-t":
        optToken = true
      else:
        discard
    of cmdArgument:
      args.add(p.key)

  if args.len == 0:
    stderr.writeLine("require a template file.")
    quit(1)

  var contextData: string
  var tpl: string
  if args.len == 1:
    contextData = stdin.readAll()
    try:
      tpl = readFile(args[0])
    except IOError:
      stderr.writeLine(fmt"unable read template {args[0]}.")
      quit(1)
  else:
    try:
      contextData = readFile(args[0])
    except IOError:
      stderr.writeLine(fmt"unable read template {args[0]}.")
      quit(1)

    try:
      tpl = readFile(args[1])
    except IOError:
      stderr.writeLine(fmt"unable load data from {args[1]}.")
      quit(1)

  var c = Context()
  for key, value in parseJson(contextData).pairs:
    c[key] = value

  echo(tpl.render(c))
