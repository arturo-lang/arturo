#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/string.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc String_capitalize*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(S(0).capitalize())

proc String_capitalizeI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    S(0) = S(0).capitalize()
    result = v[0]

proc String_isAlpha*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var i = 0
    while i<S(0).len:
        if not S(0)[i].isAlphaAscii(): return FALSE
        inc(i)

    result = TRUE

proc String_isAlphaNumeric*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var i = 0
    while i<S(0).len:
        if not S(0)[i].isAlphaNumeric(): return FALSE
        inc(i)

    result = TRUE

proc String_isLowercase*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var i = 0
    while i<S(0).len:
        if S(0)[i].isAlphaAscii() and (not S(0)[i].isLowerAscii()): return FALSE
        inc(i)

    result = TRUE

proc String_isNumber*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var i = 0
    while i<S(0).len:
        if not S(0)[i].isDigit(): return FALSE
        inc(i)

    result = TRUE

proc String_isUppercase*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var i = 0
    while i<S(0).len:
        if S(0)[i].isAlphaAscii() and (not S(0)[i].isUpperAscii()): return FALSE
        inc(i)

    result = TRUE

proc String_isWhitespace*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var i = 0
    while i<S(0).len:
        if not S(0)[i].isSpaceAscii(): return FALSE
        inc(i)

    result = TRUE

proc String_join*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let separator = 
        if v.len==2: S(1)
        else: ""

    result = STR(A(0).map((x) => x.s).join(separator))

proc String_lowercase*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(S(0).toLower())

proc String_lowercaseI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    S(0) = S(0).toLower()
    result = v[0]

proc String_lines*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    result = STRARR(S(0).splitLines())

proc String_uppercase*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(S(0).toUpper())

proc String_uppercaseI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    S(0) = S(0).toUpper()
    result = v[0]

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
