#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/string.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import lenientops, math, sequtils
import strutils, sugar, tables, unicode

when defined(WEB):
    import jsre
else:
    import re

#=======================================
# Methods
#=======================================

func truncatePreserving*(s: string, at: int, with: string = "..."): string =
    result = s
    if runeLen(s) > at:
        var i = at
        while i > 0 and ($(result.runeAt(i)))[0] notin Whitespace: dec i
        dec i
        while i > 0 and ($(result.runeAt(i)))[0] in Whitespace: dec i
        setLen result, i+1
        result.add with

func truncate*(s: string, at: int, with: string = "..."): string =
    result = s
    if runeLen(s) > (at + len(with)):
        setLen result, at+1
        result.add with

iterator tokenize*(text: string; sep: openArray[string]): string =
    var i, lastMatch = 0
    while i < text.len:
        for j, s in sep:
            if text[i..text.high].startsWith s:
                if i > lastMatch: yield text[lastMatch ..< i]
                lastMatch = i + s.len
                i += s.high
                break
        inc i
    if i > lastMatch: yield text[lastMatch ..< i]

func centerUnicode*(s: string, width: int, padding = ' '.Rune): string =
    let sLen = s.runeLen
    if width <= sLen: return s
    let leftPadding = (width - sLen) div 2
    result = unicode.align(s, leftPadding+sLen, padding)
    
    for i in (leftPadding+sLen) ..< width:
        result.add $padding

func levenshteinAlign*(astr, bstr: string, filler: Rune): tuple[a, b: string] =
    let a = astr
    let b = bstr
    var costs = newSeqWith(a.len + 1, newSeq[int](b.len + 1))
    for j in 0..b.len: costs[0][j] = j
    for i in 1..a.len:
        costs[i][0] = i
        for j in 1..b.len:
            let tmp = costs[i - 1][j - 1] + ord(a[i - 1] != b[j - 1])
            costs[i][j] = min(1 + min(costs[i - 1][j], costs[i][j - 1]), tmp)
 
    var aPathRev, bPathRev: string
    var i = a.len
    var j = b.len
    while i != 0 and j != 0:
        let tmp = costs[i - 1][j - 1] + ord(a[i - 1] != b[j - 1])
        if costs[i][j] == tmp:
            dec i
            dec j
            aPathRev.add a[i]
            bPathRev.add b[j]
        elif costs[i][j] == 1 + costs[i-1][j]:
            dec i
            aPathRev.add a[i]
            bPathRev.add filler
        elif costs[i][j] == 1 + costs[i][j-1]:
            dec j
            aPathRev.add filler
            bPathRev.add b[j]
        else:
            discard
 
    result = (reversed(aPathRev).join(), reversed(bPathRev).join())
 
type TCrc32* = uint32
const InitCrc32* = TCrc32(0xffffffff)
 
func createCrcTable(): array[0..255, TCrc32] =
    for i in 0..255:
        var rem = TCrc32(i)
        for j in 0..7:
            if (rem and 1) > 0: rem = (rem shr 1) xor TCrc32(0xedb88320)
            else: rem = rem shr 1
        result[i] = rem
 
# Table created at compile time
const crc32table = createCrcTable()
 
func crc32*(s: string): string =
    var res = InitCrc32
    for c in s:
        res = (res shr 8) xor crc32table[(res and 0xff) xor byte(c)]
    res = not res
    return res.toHex(8)

func jaro*(s1, s2: string): float =
    if s1.len == 0 and s2.len == 0: return 1
    if s1.len == 0 or s2.len == 0: return 0
 
    let matchDistance = max(s1.len, s2.len) div 2 - 1
    var s1Matches = newSeq[bool](s1.len)
    var s2Matches = newSeq[bool](s2.len)
    var matches = 0
    for i in 0..s1.high:
        for j in max(0, i - matchDistance)..min(i + matchDistance, s2.high):
            if not s2Matches[j] and s1[i] == s2[j]:
                s1Matches[i] = true
                s2Matches[j] = true
                inc matches
                break
    if matches == 0: return 0
 
    var transpositions = 0.0
    var k = 0
    for i in 0..s1.high:
        if not s1Matches[i]: continue
        while not s2Matches[k]: inc k
        if s1[i] != s2[k]: transpositions += 0.5
        inc k
 
    result = (matches / s1.len + matches / s2.len + (matches - transpositions) / matches) / 3

template replaceAll*(original, match, replacement: string): string =
    original.replace(match, replacement)

func replaceOnce*(s, sub: string, by = ""): string =
    let subLen = sub.len
    if subLen == 0:
        result = s
    else:
        var a {.noinit.}: SkipTable
        initSkipTable(a, sub)
        let last = s.high
        var i = 0
        let j = find(a, s, sub, i, last)
        if j >= 0: 
            add result, substr(s, i, j - 1)
            add result, by
            i = j + subLen

        add result, substr(s, i)

proc realLen*(s: string): int =
    let cleanString = 
        when not defined(WEB):
            s.replacef(re"\e[^m]+m","")
        else:
            s
    return cleanString.runeLen()

proc realFind*(s: string, subs: string): int =
    let cleanString = 
        when not defined(WEB):
            s.replacef(re"\e[^m]+m","")
        else:
            s
    let subsLen = subs.len
    let runeLen = cleanString.runeLen()
    var i: int = 0

    while i < runeLen:
        if (i + subsLen <= runeLen) and (cleanString.runeSubStr(i, subsLen) == subs):
            return i
        i += 1

    return -1

func wrapped*(initial: string, limit=50, delim="\n"): string =
    if initial.len < limit:
        return initial
    else:
        let words = unicode.splitWhitespace(initial)
        var lines: seq[seq[string]] = @[@[]]

        var i = 0

        while i < len(words):
            let newWord = words[i]
            if (sum(map(lines[^1], (x) => x.len)) + lines[^1].len + newWord.len) >= limit:
                lines.add(@[])
            lines[^1].add(newWord)
            i += 1

        return (lines.map((l) => l.join(" "))).join(delim)

func getSimilar*(s: string, options: seq[string]): seq[string] =
    var levs = initOrderedTable[string,float]()

    for k in options:
        levs[k] = 1 - jaro(s,k)

    proc cmper (x, y: (string, float)): int {.closure.} = 
        let pts = cmp(x[1], y[1])
        if pts == 0: return cmp(x[0], y[0])
        else: return pts

    levs.sort(cmper)

    if levs.len > 3: result = toSeq(levs.keys)[0..2]
    else: result = toSeq(levs.keys)