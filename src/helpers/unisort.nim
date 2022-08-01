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

import algorithm, sequtils, sets, tables, unicode

when not defined(NOASCIIDECODE):
    import unidecode

import helpers/charsets as CharsetsHelper

import vm/values/value

#=======================================
# Compile-Time Helpers
#=======================================

proc fixTransformations(x: openArray[(Rune,string)]): seq[(Rune,Rune)] {.compileTime.} =
    result = @[]
    for item in x:
        for rn in toRunes(item[1]):
            result &= ((rn, item[0]))

#=======================================
# Types
#=======================================

type
    CompProc = proc (
        x, y: Value, 
        charset: seq[Rune], 
        transformable: HashSet[Rune], 
        sensitive: bool, 
        ascii:bool = false
    ): int {.closure.}

#=======================================
# Constants
#=======================================

const
    onlySafeCode = true

    simpleA_cap = static ("A".runeAt(0))
    simpleE_cap = static ("E".runeAt(0))
    simpleI_cap = static ("I".runeAt(0))
    simpleO_cap = static ("O".runeAt(0))
    simpleU_cap = static ("U".runeAt(0))
    simpleA     = static ("a".runeAt(0))
    simpleE     = static ("e".runeAt(0))
    simpleI     = static ("i".runeAt(0))
    simpleO     = static ("o".runeAt(0))
    simpleU     = static ("u".runeAt(0))

    transformations = {
        simpleA_cap: "ÁÀÂÃÄ",
        simpleE_cap: "ÉÈÊË",
        simpleI_cap: "ÍÌÎÏ",
        simpleO_cap: "ÓÒÔÕÖ",
        simpleU_cap: "ÚÙÛÜ",
        simpleA:     "áàâãä",
        simpleE:     "éèêë",
        simpleI:     "íìîï",
        simpleO:     "óòôõö",
        simpleU:     "úùûü"
    }.fixTransformations().toTable

#=======================================
# Helpers
#=======================================

func unicmp(x,y: Value, charset: seq[Rune], transformable: HashSet[Rune], sensitive:bool = false, ascii:bool = false):int =
    func transformRune(ru: var Rune) =
        if transformable.contains(ru):
            ru = transformations[ru]

    var i = 0
    var j = 0
    var xr, yr: Rune
    when not defined(NOASCIIDECODE):
        if ascii:
            return cmp(unidecode(x.s), unidecode(y.s))
        
    while i < x.s.len and j < y.s.len:
        fastRuneAt(x.s, i, xr)
        fastRuneAt(y.s, j, yr)

        if not sensitive:
            xr = toLower(xr)
            yr = toLower(yr)

        transformRune(xr)
        transformRune(yr)

        let xri = charset.find(xr)
        let yri = charset.find(yr)

        if xri == -1 or yri == -1:
            if sensitive:
                result = cmp((int)(xr), (int)(yr))
            else:
                result = cmp((int)(toLower(xr)), (int)(toLower(yr)))
        else:
            result = xri - yri

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

proc unimerge(a, b: var openArray[Value], lo, m, hi: int, lang: string, 
              cmp: CompProc, 
              charset: seq[Rune], 
              transformable: HashSet[Rune],
              sensitive:bool = false,
              order: SortOrder,
              ascii:bool = false) =

    if cmp(a[m], a[m+1], charset, transformable, sensitive, ascii) * order <= 0: return
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
        if cmp(b[i], a[j], charset, transformable, sensitive, ascii) * order <= 0:
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

# TODO(Helpers\unisort) Add unit-tests to verify everything is working fine
#  labels: library, unit-test
proc unisort*(a: var openArray[Value], lang: string, 
              cmp: CompProc,
              sensitive:bool = false,
              order = SortOrder.Ascending,
              ascii:bool = false) =
    let charset = getCharsetForSorting(lang)
    let extraCharset = getExtraCharsetForSorting(lang)
    let transformable = intersection(toHashSet(toSeq(keys(transformations))),toHashSet(extraCharset))

    var n = a.len
    var b: seq[Value]
    newSeq(b, n div 2)
    var s = 1
    while s < n:
        var m = n-1-s
        while m >= 0:
            unimerge(a, b, max(m-s+1, 0), m, m+s, lang, cmp, charset, transformable, sensitive, order, ascii)
            dec(m, s*2)
        s = s*2

proc unisort*(a: var openArray[Value], lang: string, sensitive:bool = false, order = SortOrder.Ascending, ascii:bool = false) = 
    unisort(a, lang, unicmp, sensitive, order, ascii)

proc unisorted*(a: openArray[Value], lang: string, cmp: CompProc,
                sensitive:bool = false,
                order = SortOrder.Ascending,
                ascii:bool = false): seq[Value] =
    result = newSeq[Value](a.len)
    for i in 0 .. a.high:
        result[i] = a[i]
    unisort(result, lang, cmp, sensitive, order, ascii)

proc unisorted*(a: openArray[Value], lang: string, sensitive:bool = false, order = SortOrder.Ascending, ascii:bool = false): seq[Value] =
    unisorted(a, lang, unicmp, sensitive, order, ascii)