######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/unisort.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, tables, unicode

import vm/values/value

#=======================================
# Constants
#=======================================

const
    onlySafeCode = true

    charsets = {
        "en": toRunes("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"),
        "es": toRunes("0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz")
    }.toOrderedTable()

    transform = {
        "en": func (r: var Rune) =
            discard,
        "es": func (r: var Rune) =
            case $(r):
                of "Á": r = "A".runeAt(0)
                of "É": r = "E".runeAt(0)
                of "Í": r = "I".runeAt(0)
                of "Ó": r = "O".runeAt(0)
                of "Ú": r = "U".runeAt(0)
                of "á": r = "a".runeAt(0)
                of "é": r = "e".runeAt(0)
                of "í": r = "i".runeAt(0)
                of "ó": r = "o".runeAt(0)
                of "ú": r = "u".runeAt(0)
                else: discard
    }.toOrderedTable()

func unicmp(x,y: Value, lang: string, sensitive:bool = false):int =
    let charset = charsets[lang]

    # echo "sorting: " & lang & " => sensitive: " & $(sensitive)
    var i = 0
    var j = 0
    var xr, yr: Rune
    while i < x.s.len and j < y.s.len:
        fastRuneAt(x.s, i, xr)
        fastRuneAt(y.s, j, yr)

        if not sensitive:
            xr = toLower(xr)
            yr = toLower(yr)

        # echo "comparing => xr: " & $(xr) & ", yr: " & $(yr)

        transform[lang](xr)
        transform[lang](yr)

        # echo "transformed => xr: " & $(xr) & ", yr: " & $(yr)

        result = charset.find(xr) - charset.find(yr)

        if result != 0: return
  
    result = x.s.len - y.s.len

#=======================================
# Templates
#=======================================

template `<-` (a, b) =
    when defined(gcDestructors):
        a = move b
    elif onlySafeCode:
        shallowCopy(a, b)
    else:
        copyMem(addr(a), addr(b), sizeof(T))

#=======================================
# Methods
#=======================================

func unimerge(a, b: var openArray[Value], lo, m, hi: int, lang: string, 
              cmp: proc (x, y: Value, lang: string, sensitive: bool): int {.closure.}, 
              sensitive:bool = false,
              order: SortOrder) =

    if cmp(a[m], a[m+1], lang, sensitive) * order <= 0: return
    var j = lo

    assert j <= m
    when onlySafeCode:
        var bb = 0
        while j <= m:
            b[bb] <- a[j]
            inc(bb)
            inc(j)
    else:
        copyMem(addr(b[0]), addr(a[j]), sizeof(Value)*(m-j+1))
        j = m+1
    
    var i = 0
    var k = lo

    while k < j and j <= hi:
        if cmp(b[i], a[j], lang, sensitive) * order <= 0:
            a[k] <- b[i]
            inc(i)
        else:
            a[k] <- a[j]
            inc(j)
        inc(k)

    when onlySafeCode:
        while k < j:
            a[k] <- b[i]
            inc(k)
            inc(i)
    else:
        if k < j: copyMem(addr(a[k]), addr(b[i]), sizeof(Value)*(j-k))

# TODO(Helpers\unisort) Verify string sorting works properly
#  The `unisort` implementation looks like hack - or incomplete. Also, add unit tests
#  labels: library,bug,unit-test
func unisort*(a: var openArray[Value], lang: string, 
              cmp: proc (x, y: Value, lang: string, sensitive: bool): int {.closure.},
              sensitive:bool = false,
              order = SortOrder.Ascending) =
    var n = a.len
    var b: seq[Value]
    newSeq(b, n div 2)
    var s = 1
    while s < n:
        var m = n-1-s
        while m >= 0:
            unimerge(a, b, max(m-s+1, 0), m, m+s, lang, cmp, sensitive, order)
            dec(m, s*2)
        s = s*2

func unisort*(a: var openArray[Value], lang: string, sensitive:bool = false, order = SortOrder.Ascending) = 
    unisort(a, lang, unicmp, sensitive, order)

func unisorted*(a: openArray[Value], lang: string, cmp: proc(x, y: Value, lang: string, insensitive: bool): int {.closure.},
                sensitive:bool = false,
                order = SortOrder.Ascending): seq[Value] =
    result = newSeq[Value](a.len)
    for i in 0 .. a.high:
        result[i] = a[i]
    unisort(result, lang, cmp, sensitive, order)

func unisorted*(a: openArray[Value], lang: string, sensitive:bool = false, order = SortOrder.Ascending): seq[Value] =
    unisorted(a, lang, unicmp, sensitive, order)