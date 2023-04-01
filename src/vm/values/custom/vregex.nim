#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/custom/vregex.nim
#=======================================================

## The internal `:regex` type

#=======================================
# Compilation & Linking
#=======================================

when defined(windows): 
    {.passL: "-Bstatic -Lsrc/extras/pcre/deps/windows -lpcre -Bdynamic".}
elif defined(macosx):
    {.passL: "-Bstatic -Lsrc/extras/pcre/deps/macos -lpcre -Bdynamic".}

#=======================================
# Libraries
#=======================================

import hashes, strutils, tables

when defined(WEB):
    import jsre, sequtils, sugar
else:
    import nre except toSeq

#=======================================
# Types
#=======================================

type
    VRegex* = (when defined(WEB): RegExp else: Regex)

#=======================================
# Helpers
#=======================================

proc escapeForRegex*(s: string): string =
    result = ""
    for c in items(s):
        case c:
            of 'a'..'z', 'A'..'Z', '0'..'9', '_':
                result.add(c)
            else:
                result.add("\\x")
                result.add(toHex(ord(c), 2))

#=======================================
# Methods
#=======================================

proc `$`*(rx: VRegex): string =
    when defined(WEB):
        $(rx)
    else:
        rx.pattern

proc newRegexObj*(pattern: string, flags: string = ""): VRegex =
    when defined(WEB):
        if flags == "":
            result = newRegExp(cstring(pattern))
        else:
            var fla = ""
            if flags.contains("i"):
                fla.add("i")
            if flags.contains("m"):
                fla.add("m")
            if flags.contains("s"):
                fla.add("s")
            
            result = newRegExp(cstring(pattern), cstring(fla))
    else:
        if flags == "":
            result = re(pattern)
        else:
            var patt = pattern
            if flags.contains("i"):
                patt = "(?i)" & patt
            if flags.contains("m"):
                patt = "(?m)" & patt
            if flags.contains("s"):
                patt = "(?s)" & patt

            result = re(patt)

proc contains*(str: string, rx: VRegex): bool =
    when defined(WEB):
        cstring(str).contains(rx)
    else:
        nre.contains(str, rx)

proc contains*(str: string, rx: VRegex, at: int): bool =
    let robj = newRegexObj(".{" & $(at) & "}" & $(rx))
    when defined(WEB):
        cstring(str).contains(robj)
    else:
        nre.contains(str, robj)

proc startsWith*(str: string, rx: VRegex): bool =
    when defined(WEB):
        cstring(str).startsWith(rx)
    else:
        let match = str.find(rx)
        if not match.isNone:
            return match.get.matchBounds.a == 0
        else:
            return false

proc endsWith*(str: string, rx: VRegex): bool =
    when defined(WEB):
        cstring(str).endsWith(rx)
    else:
        let match = str.find(rx)
        if not match.isNone:
            return match.get.matchBounds.b == str.len - 1
        else:
            return false

proc replaceAll*(str: string, rx: VRegex, with: string): string =
    when defined(WEB):
        $(replace(cstring(str), rx, cstring(with)))
    else:
        nre.replace(str, rx, with)

proc split*(str: string, rx: VRegex): seq[string] =
    when defined(WEB):
        cstring(str).split(rx).map(x => $(x))
    else:
        nre.split(str, rx)

proc matchAll*(str: string, rx: VRegex): seq[string] =
    when defined(WEB):
        let globalR = rx
        rx.flags = "g"

        cstring(str).match(globalR).map(x => $(x))
    else:
        nre.findAll(str, rx)

proc matchAllGroups*(str: string, rx: VRegex): Table[string,string] =
    when defined(WEB):
        discard
    else:
        let matches = nre.match(str, rx)
        if not matches.isNone:
            result = matches.get.captures.toTable

proc hash*(rx: VRegex): Hash =
    when defined(WEB):
        hash($(rx))
    else:
        hash(rx.pattern)

func `==`*(a, b: VRegex): bool =
    when defined(WEB):
        $(a) == $(b)
    else:
        a.pattern == b.pattern