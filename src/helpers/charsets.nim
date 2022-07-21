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

import sequtils, sugar, tables, unicode

import vm/values/value

#=======================================
# Constants
#=======================================

# TODO(Strings\alphabet) add support for Albanian alphabet -> sq
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Croatian alphabet -> hr
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Czech alphabet -> cs
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Esperanto alphabet -> eo
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Hungarian alphabet -> hu
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Indonesian alphabet -> id
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Malay alphabet -> ms
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Maltese alphabet -> mt
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Maori alphabet -> mi
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Slovak alphabet -> sk
#  label: library, enhancement, easy
# TODO(Strings\alphabet) add support for Vietnamese alphabet -> vi
#  label: library, enhancement, easy

const
    # the main alphabet, by ISO 639-1 code, 
    # containing only characters that can be found in a dictionary index
    # and in the exact same order as found in a dictionary
    charsets = {
        "af": "abcdefghijklmnopqrstuvwxyz",
        "be": "абвгдеёжзійклмнопрстуўфхцчшыьэюя",
        "bg": "абвгдежзийклмнопрстуфхцчшщъьюя",
        "ca": "abcdefghijklmnopqrstuvwxyz",
        "da": "abcdefghijklmnopqrstuvwxyzæøå",
        "de": "abcedfghijklmnopqrstuvwxyz",
        "el": "αβγδεζηθικλμνξοπρστυφχψω",
        "en": "abcdefghijklmnopqrstuvwxyz",
        "es": "abcdefghijklmnñopqrstuvwxyz",
        "et": "abcdefghijklmnopqrsšzžtuvwõäöüxy",
        "eu": "abcdefghijklmnñopqrstuvwxyz",
        "fi": "abcdefghijklmnopqrstuvwxyzåäö",
        "fo": "aábdðefghiíjklmnoóprstuúvxyýæø",
        "fr": "abcdefghijklmnopqrstuvwxyz",
        "ga": "abcdefghijklmnopqrstuvwxyz",
        "gd": "abcdefghilmnoprstu",
        "hy": "աբգդեզէըթժիլխծկհձղճմյնշոչպջռսվտրցւփքօֆուև",
        "ig": "abɓcdɗeǝẹfghiịjkƙlmnoọprsṣtuụvwyz",
        "is": "aábdðeéfghiíjklmnoóprstuúvxyýþæö",
        "it": "abcdefghilmnopqrstuvz",
        "ka": "აბგდევზთიკლმნოპჟრსტუფქღყშჩცძწჭხჯჰ",
        "la": "abcdefghijklmnopqrstuvwxyz",
        "lb": "abcdefghijklmnopqrstuvwxyzäëé",
        "lt": "aąbcčdeęėfghiįyjklmnoprsštuųūvzž",
        "lv": "aābcčdeēfgģhiījkķlļmnņoprsštuūvzž",
        "mk": "абвгдѓежзѕијклљмнњопрстќуфхцчџш",
        "nl": "abcdefghijklmnopqrstuvwxyz",
        "no": "abcdefghijklmnopqrstuvwxyzæøå",
        "pl": "aąbcćdeęfghijklłmnńoópqrsśtuvwxyzźż",
        "pt": "abcdefghijklmnopqrstuvwxyz",
        "ro": "aăâbcdefghiîjklmnopqrsștțuvwxyz",
        "ru": "абвгдеёжзийклмнопрстуфхцчшщъыьэюя",
        "sl": "abcčdefghijklmnoprsštuvzž",
        "sr": "абвгдђежзијклљмнњопрстћуфхцчџш",
        "sv": "abcdefghijklmnopqrstuvwxyzåäö",
        "sw": "abcdefghijklmnoprstuvwyz",
        "tr": "abcçdefgğhıijklmnoöprsştuüvyz",
        "uk": "абвгґдеєжзиіїйклмнопрстуфхцчшщьюя"
    }.toTable

    # extra characters that can be found in a given language, by ISO 639-1 code,
    # but would not form part of its dictionary index
    extras = {
        "af": "áäéèêëíîïóôöúûüý",
        "be": "",
        "bg": "",
        "ca": "àéèçíïóòúü",
        "da": "",
        "de": "äöüß",
        "el": "άέίόύϊϋΐΰ",
        "en": "",
        "es": "áéíóúü",
        "et": "",
        "eu": "ç",
        "fi": "",
        "fo": "ö",
        "fr": "àâæçéèêëîïôœùûüÿ",
        "ga": "áḃċḋéḟġíṁóṗṡṫú",
        "gd": "àèìòù",
        "hy": "",
        "ig": "áàâéèêíìîóòȏúùû",
        "is": "",
        "it": "àéèíìîóòúù",
        "ka": "",
        "la": "",
        "lb": "",
        "lt": "",
        "lv": "",
        "mk": "",
        "nl": "",
        "no": "",
        "pl": "",
        "pt": "áàâãäçéêëíïóõöúü",
        "ro": "",
        "ru": "а́е́и́о́у́э́",
        "sl": "áȃȁćđéèȇẹ́ẹ̑ȅíȋȉóȏọ́ọ̑ȍqŕȓúȗȕwxy",
        "sr": "",
        "sv": "",
        "sw": "",
        "tr": "",
        "uk": ""
    }.toTable

#=======================================
# Methods
#=======================================

proc getCharset*(locale: string, withExtras = false, doUppercase = false): ValueArray =
    var ret: seq[Rune] = @[]

    if doUppercase:
        ret = toSeq(runes(charsets[locale])).map((x)=>toUpper(x))
    else:
        ret = toSeq(runes(charsets[locale]))

    if withExtras:
        var extra: seq[Rune] = @[]
        if doUppercase:
            extra = toSeq(runes(extras[locale])).map((x)=>toUpper(x))
        else:
            extra = toSeq(runes(extras[locale]))

        ret.add(extra)
        
    result = ret.map((x)=>newChar(x))
