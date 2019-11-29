#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/url.nim
  * @description: URL handling
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Url_decodeUrl*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(decodeUrl(S(v0),decodePlus=false))

proc Url_decodeUrlI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        S(DEST) = decodeUrl(S(DEST),decodePlus=false)
        return DEST
    # let v0 = VALID(0,SV)

    # S(v0) = decodeUrl(S(v0))
    # result = v0

proc Url_encodeUrl*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(encodeUrl(S(v0),usePlus=false))

proc Url_encodeUrlI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        S(DEST) = encodeUrl(S(DEST),usePlus=false)
        return DEST
    # let v0 = VALID(0,SV)

    # S(v0) = encodeUrl(S(v0))
    # result = v0

proc Url_isAbsoluteUrl*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    let u = parseUri(S(v0))

    result = BOOL(u.isAbsolute())

proc Url_urlAnchor*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = STR(res.anchor)

proc Url_urlHost*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = STR(res.hostname)

proc Url_urlPassword*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = STR(res.password)

proc Url_urlPath*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = STR(res.path)

proc Url_urlPort*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = STR(res.port)

proc Url_urlQuery*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = STR(res.query)

proc Url_urlScheme*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = STR(res.scheme)

proc Url_urlUser*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = STR(res.username)

proc Url_urlComponents*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var res = initUri()
    parseUri(S(v0), res)

    result = DICT(@[
        ("scheme",  STR(res.scheme)),
        ("host",    STR(res.hostname)),
        ("port",    STR(res.port)),
        ("user",    STR(res.username)),
        ("password",STR(res.password)),
        ("path",    STR(res.path)),
        ("query",   STR(res.query)),
        ("anchor",  STR(res.anchor))
    ])


#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/dictionary":

#         test "shuffle":
#             check(not eq( callFunction("shuffle",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)])]), ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]) ))

#         test "swap":
#             check(eq( callFunction("swap",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0),INT(2)]), ARR(@[INT(3),INT(2),INT(1)]) ))
