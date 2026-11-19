#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/values/custom/vregex.nim
#=======================================================

## The internal `:regex` type

#=======================================
# Compilation & Linking
#=======================================

when defined(linux):
    when defined(arm64):
        {.passL: "-Bstatic -Lsrc/deps/pcre/linux/arm64 -lpcre -Bdynamic".}
    else:   
        {.passL: "-Bstatic -Lsrc/deps/pcre/linux/amd64 -lpcre -Bdynamic".}
elif defined(freebsd):
    {.passL: "-Bstatic -Lsrc/deps/pcre/freebsd/amd64 -lpcre -Bdynamic".}
elif defined(macosx):
    when defined(arm64):
        {.passL: "src/deps/pcre/macos/arm64/libpcre.a".}
    else:
        {.passL: "src/deps/pcre/macos/amd64/libpcre.a".}
elif defined(windows): 
    when defined(arm64):
        {.passL: "-Bstatic -Lsrc/deps/pcre/windows/arm64 -lpcre -Bdynamic".}
    else:
        {.passL: "-Bstatic -Lsrc/deps/pcre/windows/amd64 -lpcre -Bdynamic".}

#=======================================
# Libraries
#=======================================

import hashes, strutils, tables

when defined(WEB):
    import jsffi, jsre, options, sequtils, sugar
    export options
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
        $(rx.source)
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
        $(replace(cstring(str), newRegExp(rx.source, cstring($(rx.flags) & "g")), cstring(with)))
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

when defined(WEB):
    # a (very) minimal equivalent of nre's `findIter`
    # & `RegexMatch`, on top of JS' `matchAll` - so that
    # `match` & `match?` work the same in Web builds

    type
        WebCaptures* = object
            list: seq[Option[string]]
            named*: seq[(string, string)]

        WebCaptureBounds* = object
            list: seq[Option[HSlice[int, int]]]

        WebRegexMatch* = object
            match*: string
            matchBounds*: HSlice[int, int]
            captures*: WebCaptures
            captureBounds*: WebCaptureBounds

    iterator items*(c: WebCaptures): Option[string] =
        for x in c.list: yield x

    iterator items*(c: WebCaptureBounds): Option[HSlice[int, int]] =
        for x in c.list: yield x

    proc jsMatchAll(s: cstring, source: cstring, flags: cstring): JsObject {.importjs: "Array.from(#.matchAll(new RegExp(#, # + 'gd')))".}
    proc jsSubstring(s: cstring, a, b: int): cstring {.importjs: "#.substring(#, #)".}
    proc jsLen(o: JsObject): int {.importjs: "#.length".}
    proc jsKeys(o: JsObject): seq[cstring] {.importjs: "Object.keys(#)".}

    iterator findIter*(str: string, rx: VRegex, start = 0, endpos = int.high): WebRegexMatch =
        let sub = if start > 0 or endpos < str.len - 1: str[start .. min(endpos, str.len - 1)] else: str
        let js = cstring(sub)
        # JS indices are in UTF-16 code units: we need bytes
        proc toByte(i: int): int = start + len($(js.jsSubstring(0, i)))

        let found = jsMatchAll(js, rx.source, rx.flags)
        for i in 0 ..< found.jsLen:
            let m = found[i]
            let ind = m["indices"]
            var res = WebRegexMatch(
                match: $(m[0].to(cstring)),
                matchBounds: toByte(ind[0][0].to(int)) .. toByte(ind[0][1].to(int)) - 1
            )
            for g in 1 ..< m.jsLen:
                if m[g].isUndefined:
                    res.captures.list.add(none(string))
                    res.captureBounds.list.add(none(HSlice[int, int]))
                else:
                    res.captures.list.add(some($(m[g].to(cstring))))
                    res.captureBounds.list.add(some(toByte(ind[g][0].to(int)) .. toByte(ind[g][1].to(int)) - 1))
            if not m["groups"].isUndefined:
                for k in m["groups"].jsKeys:
                    if not m["groups"][k].isUndefined:
                        res.captures.named.add(($(k), $(m["groups"][k].to(cstring))))
            yield res

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