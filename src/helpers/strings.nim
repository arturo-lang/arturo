######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/string.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, strutils, unicode

when not defined(NOASCIIDECODE):
    import unidecode

#=======================================
# Methods
#=======================================

when not defined(NOASCIIDECODE):
    proc convertToAscii*(input: string): string =
        return unidecode(input)


proc truncatePreserving*(s: string, at: int, with: string = "..."): string =
    result = s
    if runeLen(s) > at:
        var i = at
        while i > 0 and ($(result.runeAt(i)))[0] notin Whitespace: dec i
        dec i
        while i > 0 and ($(result.runeAt(i)))[0] in Whitespace: dec i
        setLen result, i+1
        result.add with

proc truncate*(s: string, at: int, with: string = "..."): string =
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

proc centerUnicode*(s: string, width: int, padding = ' '.Rune): string =
    let sLen = s.runeLen
    if width <= sLen: return s
    let leftPadding = (width - sLen) div 2
    result = unicode.align(s, leftPadding+sLen, padding)
    
    for i in (leftPadding+sLen) ..< width:
        result.add $padding

proc levenshteinAlign*(astr, bstr: string, filler: Rune): tuple[a, b: string] =
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
 
proc createCrcTable(): array[0..255, TCrc32] =
    for i in 0..255:
        var rem = TCrc32(i)
        for j in 0..7:
            if (rem and 1) > 0: rem = (rem shr 1) xor TCrc32(0xedb88320)
            else: rem = rem shr 1
        result[i] = rem
 
# Table created at compile time
const crc32table = createCrcTable()
 
proc crc32*(s: string): string =
    var res = InitCrc32
    for c in s:
        res = (res shr 8) xor crc32table[(res and 0xff) xor byte(c)]
    res = not res
    return res.toHex(8)