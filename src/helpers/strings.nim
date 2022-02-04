######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/string.nim
######################################################

#=======================================
# Libraries
#=======================================

import lenientops, sequtils, strutils, unicode

when defined(WEB):
    import jsre

when not defined(NOASCIIDECODE):
    import unidecode

#=======================================
# Methods
#=======================================

when not defined(NOASCIIDECODE):
    func convertToAscii*(input: string): string =
        return unidecode(input)

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

template replaceAll*(original, match, replacement: string, regex=false): string =
    when regex:
        when not defined(WEB):
            original.replacef(re.re(match), replacement)
        else:
            $(jsre.replace(cstring(original), newRegExp(cstring(match),""), cstring(replacement)))
    else:
        original.replace(match, replacement)

template multiReplaceAll*(original: string, matches: seq[string], replacement: string, regex=false): string =
    var result = original
    for m in matches:
        result = result.replaceAll(m, replacement, regex)
    result

template multiReplaceAll*(original: string, matches: seq[string], replacements: seq[string], regex=false): string =
    var result = original
    let lim = min(len(matches), len(replacements))
    var i = 0
    while i < lim:
        result = result.replaceAll(matches[i], replacements[i], regex)
        inc i
    result

    