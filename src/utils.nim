#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: utils.nim
  *****************************************************************]#

import bitops, times, strutils

#[######################################################
    Methods
  ======================================================]#

template `|`*(a: int, b: int): int = 
    a or b

proc removingPrefix*(s: string, pr: string): string =
    if s.startsWith(pr): s[pr.len..^1]
    else: s

proc removingSuffix*(s: string, pr: string): string =
    if s.endsWith(pr): s[0..(s.len-pr.len-1)]
    else: s

template isRegex*(s: string): bool = 
    s.len!=1 and s.startsWith("/") and s.endsWith("/")

template prepareRegex*(s: string): string = 
    s.removingPrefix("/").removingSuffix("/")

template benchmark*(benchmarkName: string, code: untyped) =
    block:
        let t0 = epochTime()
        code
        let elapsed = epochTime() - t0
        let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
        echo "CPU Time [", benchmarkName, "] ", elapsedStr, "s"

iterator reverse*[T](a: seq[T]): T {.inline.} =
    var i = len(a) - 1
    while i > -1:
        yield a[i]
        dec(i)
