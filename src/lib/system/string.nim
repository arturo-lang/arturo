#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/string.nim
  * @description: String manipulation
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc String_capitalize*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(S(v0).capitalize())

proc String_capitalizeI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    
    S(v0) = S(v0).capitalize()
    result = v0

proc String_char*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,IV)

    result = STR($(chr(I(v0))))

proc String_chars*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = ARR(S(v0).map((c)=>STR($c)))

proc String_deletePrefix*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    result = STR(S(v0).removingPrefix(S(v1)))

proc String_deletePrefixI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    S(v0) = S(v0).removingPrefix(S(v1))
    result = v0

proc String_deleteSuffix*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    result = STR(S(v0).removingSuffix(S(v1)))

proc String_deleteSuffixI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    S(v0) = S(v0).removingSuffix(S(v1))
    result = v0

proc String_distance*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    result = SINT(editDistanceAscii(S(v0),S(v1)))

proc String_endsWith*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    if unlikely(S(v1).isRegex()):
        result = BOOL(S(v0).endsWith(re(prepareRegex(S(v1)))))
    else:
        result = BOOL(S(v0).endsWith(S(v1)))

proc String_isAlpha*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var i = 0
    while i<S(v0).len:
        if not S(v0)[i].isAlphaAscii(): return FALSE
        inc(i)

    result = TRUE

proc String_isAlphaNumeric*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var i = 0
    while i<S(v0).len:
        if not S(v0)[i].isAlphaNumeric(): return FALSE
        inc(i)

    result = TRUE

proc String_isLowercase*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var i = 0
    while i<S(v0).len:
        if S(v0)[i].isAlphaAscii() and (not S(v0)[i].isLowerAscii()): return FALSE
        inc(i)

    result = TRUE

proc String_isNumber*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var i = 0
    while i<S(v0).len:
        if not S(v0)[i].isDigit(): return FALSE
        inc(i)

    result = TRUE

proc String_isUppercase*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var i = 0
    while i<S(v0).len:
        if S(v0)[i].isAlphaAscii() and (not S(v0)[i].isUpperAscii()): return FALSE
        inc(i)

    result = TRUE

proc String_isWhitespace*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var i = 0
    while i<S(v0).len:
        if not S(v0)[i].isSpaceAscii(): return FALSE
        inc(i)

    result = TRUE

proc String_join*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV)

    let separator = 
        if xl.list.len==2: S(VALID(1,SV))
        else: ""

    result = STR(A(v0).map((x) => S(x)).join(separator))

proc String_lines*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    
    result = STRARR(S(v0).splitLines())

proc String_lowercase*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(S(v0).toLower())

proc String_lowercaseI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    
    S(v0) = S(v0).toLower()
    result = v0

proc String_matches*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    result = STRARR(S(v0).findAll(re(prepareRegex(S(v1)))))

proc String_padCenter*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,IV)

    result = STR(center(S(v0),I(v1)))

proc String_padCenterI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,IV)

    S(v0) = center(S(v0),I(v1))
    result = v0

proc String_padLeft*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,IV)

    result = STR(unicode.align(S(v0),I(v1)))

proc String_padLeftI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,IV)

    S(v0) = unicode.align(S(v0),I(v1))
    result = v0

proc String_padRight*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,IV)

    result = STR(unicode.alignLeft(S(v0),I(v1)))

proc String_padRightI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,IV)

    S(v0) = unicode.alignLeft(S(v0),I(v1))
    result = v0

proc String_replace*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)
    let v2 = VALID(2,SV)

    if unlikely(S(v1).isRegex()):
        result = STR(S(v0).replacef(re(prepareRegex(S(v1))),S(v2)))
    else:
        result = STR(S(v0).replace(S(v1),S(v2)))

proc String_replaceI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)
    let v2 = VALID(2,SV)

    if unlikely(S(v1).isRegex()):
        S(v0) = S(v0).replace(re(prepareRegex(S(v1))),S(v2))
        result = v0
    else:
        S(v0) = S(v0).replace(S(v1),S(v2))
        result = v0
 
proc String_split*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    if unlikely(S(v1).isRegex()):
        result = STRARR(S(v0).split(re(prepareRegex(S(v1)))))
    else:
        result = STRARR(S(v0).split(S(v1)))

proc String_startsWith*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    if unlikely(S(v1).isRegex()):
        result = BOOL(S(v0).startsWith(re(prepareRegex(S(v1)))))
    else:
        result = BOOL(S(v0).startsWith(S(v1)))

proc String_strip*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(unicode.strip(S(v0)))

proc String_stripI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    S(v0) = unicode.strip(S(v0))
    result = v0

proc String_uppercase*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(S(v0).toUpper())

proc String_uppercaseI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    
    S(v0) = S(v0).toUpper()
    result = v0

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

when defined(unittest):

    suite "Library: system/string":

        test "capitalize":
            check(eq( callFunction("capitalize",@[STR("done")]), STR("Done") ))

        test "isAlpha":
            check(eq( callFunction("isAlpha",@[STR("done")]), TRUE ))
            check(eq( callFunction("isAlpha",@[STR("d3one")]), FALSE ))

        test "isAlphaNumeric":
            check(eq( callFunction("isAlphaNumeric",@[STR("done")]), TRUE ))
            check(eq( callFunction("isAlphaNumeric",@[STR("d3one")]), TRUE ))

        test "isLowercase":
            check(eq( callFunction("isLowercase",@[STR("done")]), TRUE ))
            check(eq( callFunction("isLowercase",@[STR("d3one")]), TRUE ))
            check(eq( callFunction("isLowercase",@[STR("d3oNe")]), FALSE ))

        test "isNumber":
            check(eq( callFunction("isNumber",@[STR("12345")]), TRUE ))
            check(eq( callFunction("isNumber",@[STR("d3one")]), FALSE ))
            check(eq( callFunction("isNumber",@[STR("done")]), FALSE ))

        test "isUppercase":
            check(eq( callFunction("isUppercase",@[STR("done")]), FALSE ))
            check(eq( callFunction("isUppercase",@[STR("dONe")]), FALSE ))
            check(eq( callFunction("isUppercase",@[STR("DONE")]), TRUE ))

        test "isWhitespace":
            check(eq( callFunction("isWhitespace",@[STR("done")]), FALSE ))
            check(eq( callFunction("isWhitespace",@[STR("  ")]), TRUE ))
            check(eq( callFunction("isWhitespace",@[STR("  \t\n")]), TRUE ))

        test "join":
            check(eq( callFunction("join",@[ARR(@[STR("a"),STR("b"),STR("c")])]), STR("abc") ))
            check(eq( callFunction("join",@[ARR(@[STR("a"),STR("b"),STR("c")]),STR("|")]), STR("a|b|c") ))

        test "lowercase":
            check(eq( callFunction("lowercase",@[STR("dOnE")]), STR("done") ))

        test "lines":
            check(eq( callFunction("lines",@[STR("one\ntwo")]), STRARR(@["one","two"]) ))

        test "uppercase":
            check(eq( callFunction("uppercase",@[STR("dOnE")]), STR("DONE") ))
