######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/charsets.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, strutils, sugar, tables, unicode

import vm/values/value

#=======================================
# Constants
#=======================================

# TODO(Strings\alphabet) add support for Vietnamese alphabet -> vi
#  label: library, enhancement, easy

const
    NgraphReplacement = "%".runeAt(0)

    # the main alphabet, by ISO 639-1 code, 
    # containing only characters that can be found in a dictionary index
    # and in the exact same order as found in a dictionary
    charsets = {
        "af": "abcdefghijklmnopqrstuvwxyz",
        "be": "абвгдеёжзійклмнопрстуўфхцчшыьэюя",
        "bg": "абвгдежзийклмнопрстуфхцчшщъьюя",
        "ca": "abcdefghijklmnopqrstuvwxyz",
        "cs": "aábcčdďeéěfgh%iíjklmnňoópqrřsštťuúůvwxyýzž",
        "da": "abcdefghijklmnopqrstuvwxyzæøå",
        "de": "abcedfghijklmnopqrstuvwxyz",
        "el": "αβγδεζηθικλμνξοπρστυφχψω",
        "en": "abcdefghijklmnopqrstuvwxyz",
        "eo": "abcĉdefgĝhĥijĵklmnoprsŝtuŭvz",
        "es": "abcdefghijklmnñopqrstuvwxyz",
        "et": "abcdefghijklmnopqrsšzžtuvwõäöüxy",
        "eu": "abcdefghijklmnñopqrstuvwxyz",
        "fi": "abcdefghijklmnopqrstuvwxyzåäö",
        "fo": "aábdðefghiíjklmnoóprstuúvxyýæø",
        "fr": "abcdefghijklmnopqrstuvwxyz",
        "ga": "abcdefghijklmnopqrstuvwxyz",
        "gd": "abcdefghilmnoprstu",
        "hr": "abcčćd%đefghijkl%m%n%oprsštuvzž",
        "hu": "aábc%d%%eéfg%hiíjkl%mn%oóöőpqrs%t%uúüűvwxyz%",
        "hy": "աբգդեզէըթժիլխծկհձղճմյնշոչպջռսվտրցւփքօֆուև",
        "id": "abcdefghijklmnopqrstuvwxyz",
        "ig": "abɓcdɗeǝẹfghiịjkƙlmnoọprsṣtuụvwyz",
        "is": "aábdðeéfghiíjklmnoóprstuúvxyýþæö",
        "it": "abcdefghilmnopqrstuvz",
        "ka": "აბგდევზთიკლმნოპჟრსტუფქღყშჩცძწჭხჯჰ",
        "la": "abcdefghijklmnopqrstuvwxyz",
        "lb": "abcdefghijklmnopqrstuvwxyzäëé",
        "lt": "aąbcčdeęėfghiįyjklmnoprsštuųūvzž",
        "lv": "aābcčdeēfgģhiījkķlļmnņoprsštuūvzž",
        "mi": "aeghikmnoprtuw%%",
        "mk": "абвгдѓежзѕијклљмнњопрстќуфхцчџш",
        "ms": "abcdefghijklmnopqrstuvwxyz",
        "mt": "abċdefġg%hħi%jklmnopqrstuvwxżz",
        "nl": "abcdefghijklmnopqrstuvwxyz",
        "no": "abcdefghijklmnopqrstuvwxyzæøå",
        "pl": "aąbcćdeęfghijklłmnńoópqrsśtuvwxyzźż",
        "pt": "abcdefghijklmnopqrstuvwxyz",
        "ro": "aăâbcdefghiîjklmnopqrsștțuvwxyz",
        "ru": "абвгдеёжзийклмнопрстуфхцчшщъыьэюя",
        "sk": "aáäbcčdď%%eéfgh%iíjklĺľmnňoóôpqrŕsštťuúvwxyýzž",
        "sl": "abcčdefghijklmnoprsštuvzž",
        "sq": "abcçd%eëfg%hijkl%mn%opqr%s%t%uvx%yz%",
        "sr": "абвгдђежзијклљмнњопрстћуфхцчџш",
        "sv": "abcdefghijklmnopqrstuvwxyzåäö",
        "sw": "abcdefghijklmnoprstuvwyz",
        "tl": "abcdefghijklmnñ%opqrstuvwxyz",
        "tr": "abcçdefgğhıijklmnoöprsştuüvyz",
        "uk": "абвгґдеєжзиіїйклмнопрстуфхцчшщьюя"
    }.toTable

    # extra characters that can be found in a given language, by ISO 639-1 code,
    # but would not form part of its dictionary index
    extras = {
        "af": "áäéèêëíîïóôöúûüý",
        "ca": "àéèçíïóòúü",
        "de": "äöüß",
        "el": "άέίόύϊϋΐΰ",
        "es": "áéíóúü",
        "eu": "ç",
        "fo": "ö",
        "fr": "àâæçéèêëîïôœùûüÿ",
        "ga": "áḃċḋéḟġíṁóṗṡṫú",
        "gd": "àèìòù",
        "ig": "áàâéèêíìîóòȏúùû",
        "it": "àéèíìîóòúù",
        "pt": "áàâãäçéêëíïóõöúü",
        "ru": "а́е́и́о́у́э́",
        "sl": "áȃȁćđéèȇẹ́ẹ̑ȅíȋȉóȏọ́ọ̑ȍqŕȓúȗȕwxy"
    }.toTable

    # di- or tri-graphs that can be found in a given language, by ISO 639-1 code,
    # with the exact order as in the NgraphReplacement placeholders (`%`) 
    # found in the main charset
    ngraphs = {
        "cs": "ch",
        "hr": "dž,lj,nj",
        "hu": "cs,dz,dzs,gy,ly,ny,sz,ty,zs",
        "mi": "ng,wh",
        "mt": "għ,ie",
        "sk": "dz,dž,ch",
        "sq": "dh,gj,ll,nj,rr,sh,th,xh,zh",
        "tl": "ng"
    }.toTable

#=======================================
# Methods
#=======================================

proc getCharsetRunes*(locale: string, withExtras = false, doUppercase = false, filterNgraphs = true): seq[Rune] =
    if doUppercase:
        result = toSeq(runes(charsets[locale])).map((x)=>toUpper(x))
    else:
        result = toSeq(runes(charsets[locale]))

    if withExtras:
        var extra: seq[Rune] = @[]
        if extras.hasKey(locale):
            if doUppercase:
                extra = toSeq(runes(extras[locale])).map((x)=>toUpper(x))
            else:
                extra = toSeq(runes(extras[locale]))

        result.add(extra)

    if filterNgraphs:
        result = result.filter((x) => x!=NgraphReplacement)

proc getCharsetForSorting*(locale: string): seq[Rune] =
    toRunes("0123456789") & 
    getCharsetRunes(locale, false, true) & 
    getCharsetRunes(locale, false, false)

proc getExtraCharsetForSorting*(locale: string): seq[Rune] =
    if extras.hasKey(locale):
        result = toSeq(runes(extras[locale])).map((x)=>toUpper(x)) & 
                 toSeq(runes(extras[locale]))

proc getCharsetWithNgraphs*(locale: string): seq[string] =
    let ret = toRunes("0123456789").map((x) => $(x)) &
              getCharsetRunes(locale, false, true, false).map((x) => $(x)) &
              getCharsetRunes(locale, false, false, false).map((x) => $(x))

    var ngr = ngraphs[locale].split(",")
    var i = 0
    var doCapitalize = true
    for item in ret:
        if item == "%":
            if doCapitalize:
                result.add(ngr[i].capitalize())
            else:
                result.add(ngr[i])
            if i+1 < ngr.len:
                i+=1
            else:
                i = 0
                doCapitalize = false
        else:
            result.add(item)

proc hasNgraphs*(locale: string): bool =
    ngraphs.hasKey(locale)

proc getCharset*(locale: string, withExtras = false, doUppercase = false): ValueArray =
    return getCharsetRunes(locale, withExtras, doUppercase).map((x)=>newChar(x))
